Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E315C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963592395B
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RIgR3+KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963592395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D226E0D9;
	Tue, 22 Sep 2020 07:37:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8DE6E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 07:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMDrNaycSjYIQAZjrlMVPsquauFiA0ruPbqWAmSKYhKK/GP+b2wB8bEKB9Vuq/vHpTypHMfNN5rwN53BdYbA+n2Jevt+YiaV9+xInz9n4QndlL2jAB+PFSY3FN/YNEIeNCtO8MbgGLqIGXzbKsLiR59qcrjKKpQpu9CY3L2AxwYfMhPwE/dOJDVQawtWZbVajXjGm+m3LKT7Cj+8dAZyU4+omq+ii9XMDbQ+pXGQtK1dgQZI0Z5Tyj5eYMjb28gC+qZyPC2RExImj4oZq4A+RaGSAy1N9mLIk11cF2Uf+3XKIq49JupIPrK/Xgr0WTmmmb1p+s0VhItP4gaSnnwzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stUUpyKV8BW7vepTzGyd1MxNmCHAtG2C2ci1L9xm99A=;
 b=AAH8v+RhgneHoV3udHMfVqxm+mggGPriMaLXCDDx0XCa4jbHcFLprQ1iEmTpA0bGdTKq+vvhNBAhCm1LGoX333yUTHxuxkJyx9r805358OplMmnyHjgze79ZSiVvyzKBkL2BdpxJdmBdMY0a2zc8/n7tn3agmUNrrsgxjOtCvY1uTkA4W6voLA7CmZVa/trpZfopYOXKNnMKPe6f3i4ccf57BD+TlXghL/VWdA43GRwtCoN4SJ9pidE2m8tTH6gBIg5qCs/h+hkbd/+zPMAR3dmjxu5k6k/m2oaiNfzex+KAsKPIXPX1oDHNx7FrIXG30WV3Q4cI0iADzx1x08uJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stUUpyKV8BW7vepTzGyd1MxNmCHAtG2C2ci1L9xm99A=;
 b=RIgR3+KSAIbVmw3vcyBgE8P6CdlJdBH3uFL2i13HufSCjPQNYPYsf2463wYOObCe1j8ZWhSfBhW/OJCYe2c2bfoA0/ZnlBozxorOIgCk8JxAY3+EyzoBIEgb4yiVMGNe/ubPd/BqoiizvAwGMDo4RgCJ8pvvntRwa1/Bw1dFUnk=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 07:37:40 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 07:37:39 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, JingWen"
 <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Topic: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Index: AQHWkK9SYqkIDCK8eUmtAOrutowdb6l0QZkAgAACf/4=
Date: Tue, 22 Sep 2020 07:37:39 +0000
Message-ID: <MN2PR12MB3022F4100A13D2127B8BFC15A23B0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
 <20200922070842.366545-2-Jingwen.Chen2@amd.com>,
 <DM6PR12MB40754DDA2888F313D7C18005FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40754DDA2888F313D7C18005FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T07:37:38.464Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd19f5a6-4619-47ac-44f6-08d85eca625f
x-ms-traffictypediagnostic: MN2PR12MB2863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB28633BBFE0788DA7F456CA14A23B0@MN2PR12MB2863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okwbYbAA8Bt4DT6bhyYspQ8SqdX9VsH5+DFHyfvucW350F5691BuD8QELkmo4kiG9ZB452PEaGgKj1Djkq3AfOmGvpYU0n/Ph0kdtKEYJAwwi19M1i83+K8Z+sy1ztAcWv0KCcpJYxY8Pec/Az2kuYbJqNpwYKT2LWrxjYmmK/kC1wFFAWcktVX52KSldbJKlNxxKMaUYnGgTJ1pYW2M3uqkPiKlNhYcJhjO1dJ/lGjtSdZfnqtSQdoCy6nb0RnkNNAskcSwbbJjyPIwGGBjKI1bt88IhqjnuRMwUjS0SkYSwEkjqlj7cBbD2QNRXZGSv8h/X31DknkP6DkDLX/QFRVhB0Z9BAhRdmbetFtQX/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(71200400001)(7696005)(316002)(2906002)(966005)(52536014)(33656002)(5660300002)(110136005)(76116006)(66446008)(478600001)(186003)(83380400001)(45080400002)(26005)(66476007)(66556008)(64756008)(66946007)(166002)(91956017)(8676002)(86362001)(53546011)(6506007)(19627405001)(9686003)(55016002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4IlKdi+q1o7ZWWS4b7mOjTyrTJZH2Jk6kKVPVOQ1hI1fgp6DbeuNv0Bl/58zGmLjPAVlgoMlFr2nV3JZPanaVes3Lo7IJP7J0YNkbiE377N01F49kY5e8Bv38RyrWPNq0cFKC62/HwY+pmma3zC8tXyMaLB9XsPkb9V11AVuvQy2dyKT8872CzBNdf0T/6uqnVR0L98fhWUkLkbWAeP09GhU/Qz3FTG34rqH6ewJWptO+MGBk1YMCacXaA+qFcot1nNDjsplIOLKI46KszWGm9rVo6X8UhHjUcfmldk6U6RXTq8tTGcYF1XvuSu7FBS/M0tDrHaI7RHb38jv5OHhiN695/WSxxB8CTByJUt5sLWji5dSzZh4xEpSS8jVnk7Rc5x5KDldmc7tw5ZDe9k7Hgnsi6ycfoE0tUBlPE7zlv1OUeEV2YewGNKRxhB/oBdyOFMFpnSD5spIVG2cDcc5dV+owR8M4rWgXQe+b2k5BjiYVdp4DMEPSp8QnBoePcQNKjph+kNLJqMSjU6Fhly6rbGRHrg3IA5aEBN9JAsIdVD5HKs3RdM9vOtgtBW4Fj1dwKahcnD2QpQpFfoSSG1vuSOpM1Ys6vhr0TCXnZe4dv8K/st3xNYx/MQkehzHRtM+dcuWgyfHVYbIdOwifpxJ1g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd19f5a6-4619-47ac-44f6-08d85eca625f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 07:37:39.7571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzAzoTKgFzoXpXbL2xChONrcpLrHAHlr7EZLZPMhicDQzkX9/KPoECILy5SOD+ma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
Content-Type: multipart/mixed; boundary="===============1586110946=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1586110946==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022F4100A13D2127B8BFC15A23B0MN2PR12MB3022namp_"

--_000_MN2PR12MB3022F4100A13D2127B8BFC15A23B0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Embedding these SRIOV check into the underlying functions is in many places=
, which is not conducive to subsequent code optimization and maintenance.
It took a long time to clean up the SMU code before, but now some new check=
s have been introduced into the SMU code.
I think a new method should be adopted to solve this problem unless there's=
 a special reason.

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, H=
awking <Hawking.Zhang@amd.com>
Sent: Tuesday, September 22, 2020 3:25 PM
To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org <a=
md-gfx@lists.freedesktop.org>
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV

[AMD Public Use]

1. Please do not add the amdgpu_sriov_vf check in every psp fw init_microco=
de function. psp_init_microcode is the entry point for all kinds of psp fw =
microcode initialization.
2. I'd like to get a whole picture on all the sequence you want to skip fro=
m guest side so that we can have more organized/reasonable approach to excl=
ude those programing sequence for SRIOV, instead of having the amdgpu_sriov=
_vf patched case by case...

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen =
Chen
Sent: Tuesday, September 22, 2020 15:09
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV

smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate=
 sw_init for navi12.

v2: skip above fw in SRIOV for vega10 and sienna_cichlid
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c               |  3 +++
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c  | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 11 +++++++----
 6 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 2c66e20b2ed9..9e2038de6ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2385,6 +2385,9 @@ int psp_init_asd_microcode(struct psp_context *psp,
         const struct psp_firmware_header_v1_0 *asd_hdr;
         int err =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         if (!chip_name) {
                 dev_err(adev->dev, "invalid chip name for asd microcode\n"=
);
                 return -EINVAL;
@@ -2424,6 +2427,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
         const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
         int err =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         if (!chip_name) {
                 dev_err(adev->dev, "invalid chip name for sos microcode\n"=
);
                 return -EINVAL;
@@ -2558,6 +2564,9 @@ int psp_init_ta_microcode(struct psp_context *psp,
         int err =3D 0;
         int ta_index =3D 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         if (!chip_name) {
                 dev_err(adev->dev, "invalid chip name for ta microcode\n")=
;
                 return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 810635cbf4c1..86fb1eddf5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devic=
e *adev)
         struct amdgpu_firmware_info *info =3D NULL;
         const struct common_firmware_header *header =3D NULL;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 48c95a78a173..9c72b95b7463 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)
         const struct common_firmware_header *header =3D NULL;
         const struct sdma_firmware_header_v1_0 *hdr;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 34ccf376ee45..9f3952723c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_devic=
e *adev)
         struct amdgpu_firmware_info *info =3D NULL;
         const struct common_firmware_header *header =3D NULL;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index 1e222c5d91a4..daf122f24f23 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
         int ret;
         struct cgs_firmware_info info =3D {0};

-       ret =3D cgs_get_firmware_info(hwmgr->device,
-                                   CGS_UCODE_ID_SMU,
-                                   &info);
-       if (ret || !info.kptr)
-               return -EINVAL;
+       if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
+               ret =3D cgs_get_firmware_info(hwmgr->device,
+                                               CGS_UCODE_ID_SMU,
+                                               &info);
+               if (ret || !info.kptr)
+                       return -EINVAL;
+       }

         priv =3D kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 538e6f5e19eb..3010cb31324a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)

         smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
         smu->smu_dpm.requested_dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
-       ret =3D smu_init_microcode(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to load smu firmware!\n");
-               return ret;
+
+       if (!amdgpu_sriov_vf(adev)) {
+               ret =3D smu_init_microcode(smu);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to load smu firmware!\n"=
);
+                       return ret;
+               }
         }

         ret =3D smu_smc_table_sw_init(smu);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637363564431270216&amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5D=
bogjhMuyHMHIzWygj6Lg%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637363564431270216&amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5D=
bogjhMuyHMHIzWygj6Lg%3D&amp;reserved=3D0

--_000_MN2PR12MB3022F4100A13D2127B8BFC15A23B0MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">Embedding these SRIOV check into the underly=
ing functions is in many places, which is not conducive to subsequent code =
optimization and maintenance.</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<div><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helve=
tica, sans-serif; font-size: 12pt;">It took a long time to clean up the SMU=
 code before, but now some new checks have been introduced into the SMU cod=
e.&nbsp;</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helve=
tica, sans-serif; font-size: 12pt;">I think a new method should be adopted =
to solve this problem unless&nbsp;there's a special reason.</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helve=
tica, sans-serif; font-size: 12pt;"><br>
</span></div>
<div><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helve=
tica, sans-serif; font-size: 12pt;">Best Regards,<br>
Kevin</span></div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 22, 2020 3:25 PM<br>
<b>To:</b> Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;; amd-gfx@lists.freed=
esktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in=
 SRIOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
1. Please do not add the amdgpu_sriov_vf check in every psp fw init_microco=
de function. psp_init_microcode is the entry point for all kinds of psp fw =
microcode initialization.<br>
2. I'd like to get a whole picture on all the sequence you want to skip fro=
m guest side so that we can have more organized/reasonable approach to excl=
ude those programing sequence for SRIOV, instead of having the amdgpu_sriov=
_vf patched case by case...<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ji=
ngwen Chen<br>
Sent: Tuesday, September 22, 2020 15:09<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV<br>
<br>
smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate=
 sw_init for navi12.<br>
<br>
v2: skip above fw in SRIOV for vega10 and sienna_cichlid<br>
Signed-off-by: Jingwen Chen &lt;Jingwen.Chen2@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c&nbsp; | 12 ++++++=
+-----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 +++++++----<br>
&nbsp;6 files changed, 32 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 2c66e20b2ed9..9e2038de6ea7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -2385,6 +2385,9 @@ int psp_init_asd_microcode(struct psp_context *psp,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct psp_firmware_=
header_v1_0 *asd_hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip_name) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid chip name for asd=
 microcode\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -2424,6 +2427,9 @@ int psp_init_sos_microcode(struct psp_context *psp,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct psp_firmware_=
header_v1_3 *sos_hdr_v1_3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip_name) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid chip name for sos=
 microcode\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -2558,6 +2564,9 @@ int psp_init_ta_microcode(struct psp_context *psp,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ta_index =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!chip_name) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid chip name for ta =
microcode\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 810635cbf4c1..86fb1eddf5a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 48c95a78a173..9c72b95b7463 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct sdma_firmware=
_header_v1_0 *hdr;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 34ccf376ee45..9f3952723c63 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c<br>
index 1e222c5d91a4..daf122f24f23 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c<br>
@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_firmware_info i=
nfo =3D {0};<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cgs_get_firmware_info(hwmgr-&=
gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_UCODE_ID_SMU,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;info);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !info.kptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf((struct amdgpu_d=
evice *)hwmgr-&gt;adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D cgs_get_firmware_info(hwmgr-&gt;device,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_UCODE_ID_SMU,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret || !info.kptr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv =3D kzalloc(sizeof(st=
ruct vega10_smumgr), GFP_KERNEL);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 538e6f5e19eb..3010cb31324a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_dpm.dpm_level =
=3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_dpm.requested_=
dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_microcode(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to load smu firmware!\n&quot;=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_init_microcode(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to load smu firmware!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_table_sw_i=
nit(smu);<br>
--<br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637363564431270216&amp;amp;sdata=3DszoPYY=
fIpzZCyRrzYSR%2Fv5DbogjhMuyHMHIzWygj6Lg%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637363564431270216&amp;amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5Dbo=
gjhMuyHMHIzWygj6Lg%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637363564431270216&amp;amp;sdata=3DszoPYY=
fIpzZCyRrzYSR%2Fv5DbogjhMuyHMHIzWygj6Lg%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637363564431270216&amp;amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5Dbo=
gjhMuyHMHIzWygj6Lg%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022F4100A13D2127B8BFC15A23B0MN2PR12MB3022namp_--

--===============1586110946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1586110946==--
