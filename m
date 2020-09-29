Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D6C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8CA2083B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GqWLFsaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8CA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A00889CFA;
	Tue, 29 Sep 2020 06:36:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFF989CFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ8e+gNYP8zG5qPs7vZawVs4CuwmidwV8UryfEwr7i8Yag7CQaPu7JvGoGesSQK7XQNcCFX+p7ZLtiqbl3MGwwbLCKiHtadVDsmDO9LwHZrzEIF546hbyCYE2/vKVS9r1W64XGXH5UB+c8SJg5yUTe49kZJGQNXg7pKFOOdC13VaSInnIZQIkYPGxeMK0WGinNULCObGUg3hTjPRdCWoj94tOYfePGxhVoWyJm3jfPx+LdqXz7BIamI+1PIfCWKLD0TwXYz2+yHOQaBxpvrGS92xgleM660scNi5oZw7J9TZB8UO10GjIExbDKpsuKYOBQF06ngVgy1mUutEr8AuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQm4VM5VgWcHsPWjuEVt1/mgbZfehGUd+Gatvj00jXA=;
 b=d2EDNRAovflDVZueJeFeSHrBaB9RGb1ohj9/fFTe9pSp8h1EOYfoMVFUyG8+2Hg31u3sAAdaOQNSztc2t+UFcSMdiZ3pSr4OPer6OTEbMX+RFmubTp/dVNuTcwXYdYlHmBC4IjRWS8D0+GkfI/1eH75wynPOAtwZJZ+B2PLXZadDvrNt5Yd9sLxgPJtc1FXFpXYUjDn8SDSRfsgA9P22EPr7Q4lZ+701WmqkkjCxmP+xDneBjYXKLzVC0GBFKNXC0qeRKQ5Y08x7BbFuypcab3xXMQ4zZOFxikekAWicouGO/G8H+b85pXEvjGluuQ32O3H6Q838PPbk8ar7V+4sOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQm4VM5VgWcHsPWjuEVt1/mgbZfehGUd+Gatvj00jXA=;
 b=GqWLFsaWELf/qWo2K8stkndrvhkiyeYKrxT3FXBymgn/l6SOpG+DT3K46oj021uFHqpoBkCKmEUls56aKVwwoBsGvXdSvO13rQW4c3GfFeGMt9zrqpAqXRWPX5qQ85ATegJFJb966IXJD36ArTU2MY8fFfRAfZN4Z3+OID7Akwg=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Tue, 29 Sep 2020 06:36:22 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 06:36:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)
Thread-Index: AQHWlifHu30dp4P51EO+ET6dQaiQjal/KSRw
Date: Tue, 29 Sep 2020 06:36:21 +0000
Message-ID: <DM6PR12MB407571BBA40C324FF4D1605FFC320@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200929061402.29064-1-guchun.chen@amd.com>
In-Reply-To: <20200929061402.29064-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T06:36:19Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=82d775da-4baa-4ee7-b081-000094d0fcd3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-29T06:36:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8c0b8774-59d8-4047-974f-000045e9de3b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T06:36:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1d408c48-a3d9-48ab-a310-0000a1eda277
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73215a0d-3d02-4047-12e4-08d86441fb10
x-ms-traffictypediagnostic: DM6PR12MB3372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3372228936754737A2B1D775FC320@DM6PR12MB3372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nh53++zArbtOmtZhZZa9aTR/d0e+OIANODUsQhrkIdJeTlXaspqTjjfRmczjSB1l2ZVt8u2T3B/ywytFnZOBDlwr4v4RGFls6OQxaqZt0tbnGmVbRoVHKMSxFfW9JOEnMfCZmw2VLz0OV3evCD2WqbU7utHwQx1jaC4S1ij6B24u/EE9+Jq0YunIPyZxl+H6q3e4as497BDNtFTTorZrb901NZIAj8iJyNxBGjiTxM3Gygxy7HpVFrtjfJyAatJumiGD7cJnC2LBvnVZXeSxACso/RkW6YqJYVtaDsXAz8xRUjxML6SmoBC8TuA/49gQEmjj85RuEsjYt5TMBOjFdJ3pD8GgHy5EwDRdI0SjORZ8I4SiMB8K46GtiYWkuvieLDCMaJc/gFkStOFZRMbpn68VcDb4p5e5hJbyzvsIkXc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(8936002)(83380400001)(6636002)(8676002)(55016002)(9686003)(53546011)(26005)(6506007)(7696005)(186003)(316002)(110136005)(478600001)(33656002)(71200400001)(66446008)(64756008)(66946007)(66476007)(86362001)(5660300002)(66556008)(52536014)(76116006)(2906002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gODwj1UkpkfxWfJKux4GiDXgUSKT8jLMLAJLoGCe573we6NSnzshbRtt7/p/A8RBagIMJXbvpuWvcI0gXD18hrU26mBHmBRTUTfRHed8dT9lXEL+hM7y18FgQ6DIPLwSopsd20LLrXdGDxrydxev3/GYC+QD+Z8kzF6OChJHy6cIRWwt8k/voKiXiUY/WVvkr2wPf5ywKvNN7S9mesI98ehquLmDGcs5NH7PFG2ih75yk9iOiUmwjiDDkxguOyFyIR0zeGquUIIqsbkIYVHb6jFt+TO2p/9+eq7/Bl1QB68Yt351bZwC5UVV7/qCKZv1/DaamTtApI8UDB8qoFE5XIzPkSCmOZ0pesoHEf/MOnTCkubWezJ722lVR7q8n1g6Vxup7m2I7xBihlujwuEPaiiVt8I64EVmNYgfF2tII9uOnpMJ0XuwOMhUNVvwi8238/O0vVaH7Zq8nLbG2tSXDWv0kwGj6iSx72zaUCKrbIbRQp2WVGPXHWRTbDz9ubq148vyTQgyvhXaDDdQTphq+4EACazZTczXrvNhYRO9vBXUJIdkK+3TeNxDyYjxys59PnvbZbGJmVDQGoLdah26RnRjfU63RPz9dRCfRujXujHtTSC2yN9CWJrzHBskE/qJ7zcK07cV2eNwTl2nh2EjLQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73215a0d-3d02-4047-12e4-08d86441fb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:36:21.9228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3u9Dq5X7IOluvzyvGeY5mX3J2kvHBlFhWpDHnOmjzeNkxrjoVdsnLvA6jn5nemISrLd3jGTD9vDMO3IuN2wf6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
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

+		if (adev->ras_features & AMDGPU_RAS_BLOCK__UMC)

ras_feature is in bitmask, so it should be 1 << block or use BIT macro here for the check

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, September 29, 2020 14:14
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..c80840ff762a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,13 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-		if (!r) {
-			DRM_INFO("ECC is not present.\n");
+		if (adev->ras_features & AMDGPU_RAS_BLOCK__UMC) {
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
