Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786D5C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 08:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E8720759
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 08:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ketOLDuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E8720759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DB189DA9;
	Tue, 29 Sep 2020 08:31:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4307989DA9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFMVsm5cyj0qSk/s5WUrqc3U2zytVwTHjrTOO0VJRkFC9OYPBrQi2ysd7JkwngxjEc0xuP+F02JFKRCh1zztv3UDWUpPu9qnrsy+HlZw8/5v3a2+3x2g2C9MBj69tvrl1oU90KbbZSj4wJNVAxC0i4/8472ud+LuGZXlXvqcEgPXydhVQyERdPWaXovlO6WQ6+HRfuHrbLf6kt0YsLqfbA0ARl66+K19dQGBkFDSiDk8anH9Gj6Kgg8xD5TTCe+gnHyu3aIg5i1NjzJz//UbaoSlXCc57wmbPGOfHUgSWcc+zcLy7s+eFl4Jq0NvHtyhqlUQ2/q1S3UdnHl1piTMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUjFVqhO4M6jS5TbV7T4X7GjDw660snIwSRycIkwZlc=;
 b=Igfygksn9lRIHjo9av87A6PwOIWpXxNyL2CEuPvaiMvmtJ8NCe01coRalHIa+r4VVSkZrPbfFd1KKEolKADUU8RuXAsLW3lPf4s42Ld8tFzKCx2cNCEs4Fp3XSlimzDfPJoxyPc5MeH889Dpk9yUpTlLB4wvw3iSmz4Yo9mPTlkDZy10M5Wn8VeAfHraiGcRvO4XxJIFkvg0vThE0ObA+OC8NJ9DDHkqQQTxqDabGhubwyj+QQsvtAHmuhT0qOq2sm0/BYy3WE2SZ6gspkP1kFnKmc/aiOkV7VDuMXhH4lWTGMGbuAmq+fhcEqlHwlzdwWepPvatgu6oKYuT8ewi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUjFVqhO4M6jS5TbV7T4X7GjDw660snIwSRycIkwZlc=;
 b=ketOLDuT1j2ZYjerKhnehaif3t26Yt229BIOW8m60wsR9+I18mjun9slPlLUDR9QqU4fYieIBf33lN/5cORNzH7SnrmShVoYkyTTxgPsbYI1enHeEVok1v2rBSbEF8EpGySCmK3KQPi1ffz/rH5wz0HTST/GuVSLPQsO8psrRLg=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23; Tue, 29 Sep 2020 08:31:10 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:31:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Thread-Index: AQHWli00CuP/AJk6bEeihNA2mfGgc6l/RrEg
Date: Tue, 29 Sep 2020 08:31:10 +0000
Message-ID: <DM6PR12MB407561BB1D3293D1EF0497F8FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200929065255.11856-1-guchun.chen@amd.com>
In-Reply-To: <20200929065255.11856-1-guchun.chen@amd.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-29T08:30:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a0bf5c3b-7ed9-4ead-a767-0000338e8140
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T08:31:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 825f02d3-fba2-48a3-a85a-0000cb4eb584
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d834dc2-675d-4001-7916-08d8645204f6
x-ms-traffictypediagnostic: DM5PR1201MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0028301EEE00CB4CD26F08AAFC320@DM5PR1201MB0028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBcgJsPjyvG0NBLLSQRGJxHhGJKkygKsXEIjGUoMTEyyUGTRJShNPnyvc30HzwAh2ETmZak2CxTKpwJmMuXmZalzSQ4beGe7oz6xIh91g2fdrcvkJEfvvn8xqXdpKlgij+XwqneanHLGqMqT/XhwyDhKoxYaZdXKJftUvLsttcRnegnXQpFfMEIXl4I5/oEUnEJcfjnpN57cfCEvrfbhxaM5hcEtrSktsBfI0nR1fIUMjQSy0+xzmaZGx6vjz7H5i6hUKhLNetiGvBHuhPrOB6WJlfCKPS1v9tSdTaSuLLJyNyZ9aCn6uH6HgBkfUElLNrkp1CA6iWESid5d0AnCvoBjVFOua2zf9MugQzp4hcP7G6RR7/CdAj7MMyuZM+Y+xZrak8B/QgOihyF5+Geg6ABmURc25pzPxSYOQg/0qAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(8676002)(478600001)(33656002)(186003)(76116006)(2906002)(26005)(66946007)(86362001)(66446008)(64756008)(66476007)(66556008)(6636002)(83380400001)(110136005)(6506007)(53546011)(316002)(55016002)(52536014)(71200400001)(5660300002)(7696005)(8936002)(9686003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: h0Q/wqGLDwH8OczHVu7GsoGh3Wbc0ND4bCZ0aXylaIY3Nj4Y0XeodjXRvgvH4fgnNnP/Jp/VWJRpZOu5AhCSumXkINy/a9VHx33U5ocwFFk3TEjJ+fAMNCdlIsvojCZ+tEeVXPeL9MbHquhoLjXI6tUw8yNTvihogJZfdie9NusT7XwivBFSgSVZZIot0Bc7poOdrknL8vjSnL7AQiff6W7AzrWm5Mb+crJadWjTu+pmQm6YKY0lM6TJJo4EjzXUSB2gR1C5gkJFID7i2Ua7cnqrjGrwfthmx58t1KMDbX9fNgEWX7LhVBr0OgKQcY+gD6NPJ2rWoiwYGi1Z6zy3tshOSmGG5d8/ueVWDIWtvc11sZOgyWzF2u5a/qFP+1B7BzKrswE8RvEzaTQ6LF6ehs7ZEisQbLZBXEEfEjHYdS3AJRvek9zcycVFrV2KTurXKM3qHiyD9F4tnyAk57T2Qqy3bPlYjvgvuG0mljkrR6Z44Lh4BOPOWP79wxWax/+N7oJ1bD+28+HEN+w98SmGJUhDdIXfXrAMMBPPLp/azzRZh3XxcDNKFjMY3dm5SfRFDLAbejuBrzwwuafrMHgpFjgsVT/7UFleRnstOPA5qFWotlPVK7kzx9TdFMIF5AzoKp5SCl2XK3ZvJsP3UCzAPQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d834dc2-675d-4001-7916-08d8645204f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 08:31:10.4012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cJod/mcs+lOq89ZHPk4lwxSSXz/+rYOJN6D1Wo9pxf1Iv8fyqMrcCPwtG03Ej+Oc7MLDncbil3pARoiohjhmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
