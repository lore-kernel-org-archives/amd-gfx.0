Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D5C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 08:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB662075A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 08:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JTZpjIFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB662075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C94989944;
	Tue, 29 Sep 2020 08:39:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F0F89944
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FejzpEiop8wu1FHiR1710WE2yLFztYdtVCy4SP3kCnYfGsOAtzEQdtgC3Whuxhxcf+4R33rXLjApq4MgqgjGOhLNItFuPoXDZ5axjfP+owiWYr49Hh2aggjVNeMR+q4Clh33hqLDmBpz80QjrgG7j2FDnS69ndIaVLe9vLc0oSXGu8DcHtEKqLCLM/WpwfjG/1164CwMjH7jlFYXq95vS9f/DFLYoi7cQiXNOGAQxWidi1HprvH8MvIS9xgknU194Yco9h2zN8Vdrezs9z9aa1tktFfi9UrKJmlkjRkWAgzxEz9dTVvFLI80fJLVWM0SIzfqiLe1n6FJMT9yy6Ld8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+cLT8AjiNAuMWGJJSJq07yC+intPopB/MmTlD79M0s=;
 b=gxIpgJwpXyXPu1SQLP3jlfge5dtkulX8YR8DlsyRF4CdPRL9BlV/jZQwY6q+FvvGJKU415CPo0H+9UDJepjaC0WlCalXg44dGEbWC5xDd3digC2x3uCxGht2nuWbsX/FBTnbn8q9WWhgT3seUuD3ZSYQgmZp/lhPeMNAt0n3wA8PfN8hYUuyf/0EjMywJLu42AQkhokQGyu9PRhYuPbBN4XY57pbLgcVwMiYV0IWXCAif79WbPSixgZMrBJChEjAw1hsZ7e2pWOrd0nwspME1umhuU/vJFjHEf60+l8wSB4MOEPdRVcvZLZ5NbZa7D1V1A+tjDdelWDPuH5Z5s6C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+cLT8AjiNAuMWGJJSJq07yC+intPopB/MmTlD79M0s=;
 b=JTZpjIFVKRIr791lEDv+H16HDxUcS0DBvWAaXVE9EvaWwu0QGQpYCTKcFvXudHSYkMFXHunXmFErprn38d9vT1iOqJ4nFxRInJFJXTb9hJSlu/Z6oSTaDVYIhVf/gn29OoNLwRzGjXy75vRPQyBgwsajqFSt5JwQ4wA+pJmEHf8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Tue, 29 Sep 2020 08:39:25 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:39:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Thread-Index: AQHWli00CuP/AJk6bEeihNA2mfGgc6l/RrEggAAD2kA=
Date: Tue, 29 Sep 2020 08:39:25 +0000
Message-ID: <DM6PR12MB407551EDC506D9227279A283FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200929065255.11856-1-guchun.chen@amd.com>
 <DM6PR12MB407561BB1D3293D1EF0497F8FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407561BB1D3293D1EF0497F8FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T08:31:00Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9a6c1653-4234-4c9a-a6c1-00005369f35c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T08:39:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e9d6d754-829a-497a-9215-00007855fd0c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10c54465-1530-4cf0-cbc1-08d864532bd5
x-ms-traffictypediagnostic: DM6PR12MB3865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3865CD1DD465AE4DDB71CCCEFC320@DM6PR12MB3865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvYPxohkLaNRXCoaMEho5LuMPCMRRjpjoSDH5H8XC8hgT1BudN8dPp67x2NIK28BlfqjKaH3OeLmsHSrJbynY7kT3eH4WsUOGWv2b3pyJAtGkni6sHo8n48+JxowtuPw34iHLfNOSwMw5sWzursS/L6LTNyPTL/Jq7kom/UD7EpOqOJUD5+6zgHulN3lmRlFMU/bEgRfBHYnG2KXqZeVwA0YdwdXe+RY3bcghxd4uV0EZxxFssj9sCrWlOW+1BYFym3Tvd/EHyvMZdNot1phusynoXK9Fp8WUOPJUuF++3Om4kd5r6g5ic58j168kzbZTOKdBjbl2KWgX2y3sabItTLJZpFft+8TYowIWoQZl8YTWGfZWWpORiURbmGUyGVPmzJATpDpq7tKq0p4lVGlyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(110136005)(9686003)(2940100002)(55016002)(86362001)(6636002)(52536014)(66446008)(66476007)(66946007)(64756008)(66556008)(8936002)(5660300002)(8676002)(26005)(186003)(316002)(71200400001)(478600001)(45080400002)(966005)(33656002)(76116006)(83380400001)(7696005)(6506007)(2906002)(53546011)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0USKvQM7fS0UHn1Jf9+LMU5VBRJCtdYEmuyyaS+cu2TuALqkrqe8uA+nJzDmspdKFENbbFdE5E8tToqf5H/FfnekaxeHY9qDSiEDopARZETV6kJf/2WZBKMy53Y3ZiNNFmKPhFRCEEGFjNVcWp+a9eVNu3gtQep1AcQrSP4WP1uPotkEuTFbWmax0tMkKDeM38hl+2s4RezY/SCDhlca9sojzt2/8kImn79kSRe57udhQdrGqJl4K2DGERKD8JoyxgTOi3Y+ErV5/jYav4jawSFsUD4AHgCCv7AvMjsh/Ck/nmiMGpTLNv/n73Kz3uKAiUc3fFvGhnCu2jclF/KxLIf6J8Flfx9KQhRPKRZEIYxl+CsRH4L70GImXHBkvRtwZIMM+imhveDO/sRU+HGC+F2jzHBvecxDAzH4nVvLqiw3X/Lbr38q33wIvMGYA8ExenYqClQLrxdCmO3Kwg1nbuQi+Qzdbslg0C4QE+TM0EKw0lZyTe3h21zNGo8qfCdRGGbhWEnk4Iozg2C4qT7XV9KBOvsQpLqm5fagnOfpp75e7XQH4quguNtNuqIm9fiDbXP8yX9FR1m0adDzoCaYPwWmbWwHvkST4mICp9/5wY850GnfI7TCgNhhL1s8AxEuTB2tIb/k/czPWoYAcHX7GA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c54465-1530-4cf0-cbc1-08d864532bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 08:39:25.0861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQX3lVusFbOJVnDD2PLe/5tNmSYQbX3IgYDr/zFDo6ZhPyZ3KBRWxFhwvA3/Qw0xlq6cRQF7v8amwnG6ryVf0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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

BTW, this workaround is actually used to fix vbios issue that the partial writes was enabled on board without ECC capability and result to performance drop. I don't think this is related to parity check or something. So the comment inline is also not correct.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Tuesday, September 29, 2020 16:31
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)

[AMD Public Use]

+		if (adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);

Hmm... this is still not correct. If the UMC ECC is enabled, we don't need to apply the workaround.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, September 29, 2020 14:53
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings
v3: use bit operation

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..9599946e4bee 100644
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
+		if (adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C06c662b3015149395d5c08d86452077e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637369650776046907&amp;sdata=zEH5g3uQtHPGeZNc2qIteRg%2B%2FlhehcKHf7G3I5He1WU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
