Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A6C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51B920C09
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R7OnUTZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51B920C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA0E89C2C;
	Tue, 29 Sep 2020 06:09:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4654589C28
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5N1ZlZCs1S8+nlbvl+rgCHtyYTUdjBL5gXAoVOq2OKMkxHaFgQneJ04mcLku60VqyPBj+kT1iJCVgQQ4HzCYrNiNg/rNcd+333tMcLV5DDmCABS5asSxt8laHmIS1EG5M94f8ylFXjZre7NyniJna5G5za7Fzupiay/fZDRVg0o8lxmFgUs0XEwzePvviLnzqGI0jSEr1T7DT1iXtXUSgwFwpSgzBT+Vz4ogDUGGYnX8PJUnsswwdrX11+/aN7DzDejUWPer0qtym2fcp+EY2bbYeVgB0LTznrO4CkB7Z2UZ5P2ceYUr3qqtjrssVIZ2Un+p4MZ1fiOcVYptEk02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVKgMWCrAlBKGaH1u7+M86GhuOFZEIEyr6R2yLozlHo=;
 b=f1U7TggztDRYdCSru5Sta/duDGzA1ZzNmasks/zG8HQUanfaKeVpxaRQZy7ZEv0iEysIZ4v+0eL8xLRcvHizodArvL6Lp3ojNmvepPrG/3rOteilQTQwOJPXGB/vczKAqTFrxbhGHnvRao1NvEADNL8AWvTYZxtfAttxml08aBHEzMvcXG24bMwDs5WTmldNiXAuDeIXcDCNuNBm4WhbK0qBFoGks0uSYTF1gHiiBeR5aT3A3mulxW+fceQNfgat8ybgc+D/J/taTv0KggWG54e1IC97lxXafUvYNwFWFPe7op1bmOvwn404BFpiWRQFd+Za+R6+QktI+BIPyeQ7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVKgMWCrAlBKGaH1u7+M86GhuOFZEIEyr6R2yLozlHo=;
 b=R7OnUTZYLqMxtjxjNZShtk6sX7Wqt4iR7AQpXNwEtu3XqhoH/8KLfkZ13oeGDPrusJfLkjTFPFKpfWhlhE+hOozHLNEehSPA8N+X1wElmmgI8zmrL99Vwvag7nE/Y5MchG3Hc5RZMPS/Cbspn3BB4j9PSeLw74LEu06eQyRwcqM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1621.namprd12.prod.outlook.com (2603:10b6:910:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 06:09:14 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3412.026; Tue, 29 Sep 2020
 06:09:14 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10
Thread-Index: AQHWlhzXRs9sS65ywUW5UQ5pSHIz4ql/IMWAgAAAv8A=
Date: Tue, 29 Sep 2020 06:09:13 +0000
Message-ID: <CY4PR12MB12871E9F5D9CA613D54BDDB3F1320@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200929045549.6164-1-guchun.chen@amd.com>
 <DM6PR12MB40752F7D0CC161F3E8525066FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40752F7D0CC161F3E8525066FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T06:05:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a4e6754e-6543-4584-be99-000029e06f9a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T06:09:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 40246a21-544f-455c-8093-00001b1a6a69
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50c95eb5-2931-425b-1a4b-08d8643e30e0
x-ms-traffictypediagnostic: CY4PR12MB1621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1621B2054DF4DCE5D8583DDDF1320@CY4PR12MB1621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4lGM75J5DQs2IaWcpfSIrgTiTH36NTa7jvo56HA5fVpOLr8qD43TnkVNODFdLZnoUDeCmYJUaA1j/EXvyDDbMBsIUdNWwwp6pIt8HAChkDu8LSn4HJK7WPfyXbN8J00kBCRYrZsFZxflAhoSeE56JLy2cR3nOJd9G/cosHrL1XdLCV6P/mX45WahCX6ZyjVpYkKDXX07a2eXraJ3Gh43eg2a2xGiqjK0UX0hWN1P+Fkm+izoGgymQM6xqYkf1Wespiwf5eUN3gwYzQaimh/wTPbD+YqFa/C/ZkQYZI2TLPuZreFTjEHuAIEIhhn52eGzaiEDHEMEKAp8sMN0D80k2ootNzXshs2SDPQbBVsbAe9NKP/eBJQiw/q82MXQNg08SuUEkQoY+926vTHoXcyj2A2aU/a+omLCLsh/Cp/A8M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(55016002)(478600001)(2906002)(6506007)(53546011)(26005)(7696005)(8676002)(9686003)(316002)(83380400001)(6636002)(110136005)(186003)(8936002)(66476007)(66556008)(64756008)(66446008)(66946007)(52536014)(71200400001)(76116006)(33656002)(86362001)(5660300002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lsvE8ExGWD8LG1OFWfV1w+nGgt6xjdamd3PzoHqPOVMEBPuirn4JeY5GWQtW5jrAAgxkfoKfw2Kn/Gw7/HqxS9lKCDiaLLe7mivK6kcxnk57rKKmCnMAGUsu4ItwWXVJqTXFecUalagIj5FeaqNibN36E+bir2E/mVMZ7u2TTqmUPrWKUVgEI/8s1Da3HPeCivEhN7cnoLKYhB0McswFwSH01e3Xq829unP1D5CHCwvZDmbgqqpE0s5YDPV/5z9PkLnWlYq7qgjx2yc3tuahFLXaCSnkXJJ2vsNe34vbPRm1qPu0KyFkyLsr30g9XZMXZirQwSHFEQivalGpcfU1LATdeq+gQPy2es9FtzmS9YIThARDKOHsPY66AyP3KNWf1iaVQYch6iOyzo5VG6xJ70mGz58aGAdCQlorbJRFLg2NOXFoCs7JtIOszPBQtAMYDaHPXq8Dg00pX6Mr1m+SXZ2dX13XxtGZZH7VZEO1kWX53hGI6VgpDqjtqooiLSTXko4u9FDqzpJmCU7vZU33Or2Jz5dqSn1s9Vnt/Go9KgWhGPkiV/3YXF4kUpfYTahaGUQz1YPwYmb49g88fYgGjwDj0dfcWYE/exjNHRsCirfBhGjnQMY1ZF44nPTEdnKWU2/t4T5fRm26T6h3HCDdqA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c95eb5-2931-425b-1a4b-08d8643e30e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:09:14.1929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U9jbVgKiw5KKfF4JTHEFFqslKn0IZGfL+OWxvzZOGVg3w54MH/pJVYA1Vjd4DgkuXd//Mnhh9c1NaONUKr1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1621
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Let me send v2 later to correct it.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Tuesday, September 29, 2020 2:05 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10

[AMD Public Use]

Although we unified check ecc capability to ras_init, we still need to query the ecc capability here to apply the vega10 specific workaround. So we don't need to call the atomfirmware helper again, but leverage adev->ras_features to decide apply the workaround or not.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, September 29, 2020 12:56
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..f72acb7cfea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,14 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
 		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
 		if (!r) {
-			DRM_INFO("ECC is not present.\n");
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
