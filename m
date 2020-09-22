Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B64C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 10:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEC72395C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z7NDBt/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEC72395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63986E118;
	Tue, 22 Sep 2020 10:22:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466B36E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 10:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaYxR9Wmeiz1IdQKHcBHKcfy2UtjywtU0R4Qg4h/5dQd52yCBWC9EnitHuDhkkshHZrrWul9x5YLHTUPnxFcu8JuCA3zBG6ZzCJUBYtgTkrPHpTUCMf1PNu+gEW7FuaBVpVREfLO0zrOy7RPf8htMuHGeQp3Lu8T3DYgXMahwEztRe0F8AczrDkSYqUQ4d+HOTuntM387Qe+UyLYIHHuS1/ea7tm52Rl8EMZxEhZIfQl97IcauwpEQ8BsYGOkPQ4fKrUX64LHwICmEgLnZNbcBdqUFPldV7QM9KaHXeZI9NDznInYP0ywAkk6LLZxmBeYAog2Z2yHHXwLr1LanpelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49oPoPHPEMjFvqNSJAaFFI+9FJqCNT1TNzGeW5g+9EQ=;
 b=lb8a4JOtFUaQ/FJATGQniPos4NzNhC5WWGNlGCTutLXfA0HuABTGdDj35DWuNFhRRgBf+eT4A2YC5fgujkkXTbHUE7IQIeBw1YIo+HNbqPUC7YADArhXzjDbknxLEaU37DVgDx7XCL8OvefjUkI/3kNXDl1Swou7qjNRREK79G22z2CrnoC/YjglD4pV773g8b/QihIjStlrFV8jOmP3JU7ucrvFiF9jxtC/c/RP3RIEWgy1/8q1/xJkSfP46+uLIhNbij0Lf1wYkej/jfbA2lP6kj3hkV6vgaJC6YmEHaK5lthxrbNgxYEk/Tx6cqQgItTOObH6/DUyoA2cY5BgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49oPoPHPEMjFvqNSJAaFFI+9FJqCNT1TNzGeW5g+9EQ=;
 b=Z7NDBt/8ENnYjmyXq3rH0NkRQOt+kg5mzg8GHrZHlcHOpxZZglFZ7t1/NH2Zssolvh9+inrV5iqnKZvLez36E1fWsXYcatT1KVxKcqnQFGs1OvOK+HxPBUQxEa9wXllMtZI4Ba8AEBjdEEqlB8dwO6seWhtQ+NTHekPK9pOLA58=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 10:22:25 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.026; Tue, 22 Sep 2020
 10:22:25 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Topic: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Index: AQHWkK9Tlkn+Mcf4ikScODymTuWS8al0QZkAgAADh4CAAC1qIA==
Date: Tue, 22 Sep 2020 10:22:25 +0000
Message-ID: <BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
 <20200922070842.366545-2-Jingwen.Chen2@amd.com>,
 <DM6PR12MB40754DDA2888F313D7C18005FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <MN2PR12MB3022F4100A13D2127B8BFC15A23B0@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3022F4100A13D2127B8BFC15A23B0@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T07:37:38.464Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD Public;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e9f5176-8464-4e0a-80c5-08d85ee1668f
x-ms-traffictypediagnostic: BY5PR12MB4003:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4003338F85605CDF7B20EBDA8F3B0@BY5PR12MB4003.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsMkuTCQjhjEwrSxpXXx2knbS83ArZHpqgMFapido5AKw13Snt95miIVzirIP9wNX0lZaUknyS2q5xBeVTeOErdulsGW7FqNXHaCuKvydK6wG49wUeQ2HMlDli8aZ1oPvxovxzCy7FFL8IhzYuCgGeL8FUNAaKdfuU766o2trHk4SQDmEBaeTuWXJpg89ABr85OQ44ZRaN8i2tw59gJFr0hkMaH1vxEcZLuCrRaQvQQ6tf/RqcXRnQPEcdOXWyGYaje4LBw50LVtKostEfWZquLPg3451B73GKrY/tpNu99/sHsLBSi+sbqioLtYi0xawVeeg8It6nxpUR+VYvfrICyWu+KmH01KWwPSK5yevzA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(71200400001)(86362001)(2906002)(8676002)(45080400002)(55016002)(316002)(110136005)(26005)(66946007)(66476007)(52536014)(186003)(33656002)(76116006)(966005)(8936002)(478600001)(9686003)(66556008)(7696005)(5660300002)(53546011)(6506007)(66446008)(64756008)(166002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: quRR+cKPwkvLu6o4Mxz6fyHITQrzDS/GpRmgWvnqXi7UwnfLW/IO/hJeMBOm1U754G/4qCAuBuJV4x7syVWT+89A6ZId6ySqExtE5LSxy+NzH8i0k8+LmgG04pMOLwX17q2Z4wv6RDsT8jT+SWgS6m7Kn3Ev3ueWsbNobL/S80lGobxDLKWvxGa7P12m+VKP0CovwIg1CotPv7Oq0Cy/0vyRg0zcI8Pn2Sszd6SccGOR67OfZxOZjX76axRAIV8W6VF/ABHxVN7E1zuvYWNUGM8sVjgE8V0JpZEfuiUPc2O/sEaeCrua11UlzR39aAoTQl2Kwqfo1sGcu3qLe5qmDp485nTjsXfEL6WOHetmgbl8p+KPvXrK/JvlWmeAEvc9gGTHLkXgG9cCk535pkn+KWCDST2ey+6LXF9vj1Xem1m8fsSaHJTmNb6V7cZ0WKsAPdKuvESp7IDgXrgKgDXxfH7CuSRsKPXSJtpIsF5Q3wyNko76060QA2lGOOM66gTQZW7BxGnAq971mb4KcEwIZtHIn2vP9EiqOobxkO09nWnoOwFKzw6/nSi53jHhl+6NvfvyL2DEWBVLo+burVmTlekMRXbgg5BhrkPRwLJj1e366zEPk1Wss6oa3AihrASy3Wbb1G9Mn1GkEp5ughlBzA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9f5176-8464-4e0a-80c5-08d85ee1668f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 10:22:25.2615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lx3Yf2g1Nvpz5aeobAQbozNsGT3jfzoT5qOMJfAS7gzNrnrPBTJjRrM5Jg1riM7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
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
Content-Type: multipart/mixed; boundary="===============1503473332=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1503473332==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0BY5PR12MB4115namp_"

--_000_BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0BY5PR12MB4115namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Kevin and Hawking,
I think both you are right. But currently we haven't good method to handle =
this. It seems need to re-arch the whole driver, not only refer to this pat=
ch. Only refer to this patch, I think it is OK.

Best wishes
Emily Deng
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wang, Ke=
vin(Yang)
Sent: Tuesday, September 22, 2020 3:38 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, JingWen <JingWen.Chen2@am=
d.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV


[AMD Public Use]


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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhang, Hawking <Hawking.Zhang@amd.com=
<mailto:Hawking.Zhang@amd.com>>
Sent: Tuesday, September 22, 2020 3:25 PM
To: Chen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Jingwen Chen
Sent: Tuesday, September 22, 2020 15:09
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Chen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV

smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate=
 sw_init for navi12.

v2: skip above fw in SRIOV for vega10 and sienna_cichlid
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com<mailto:Jingwen.Chen2@amd=
.com>>
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
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637363564431270216&amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5D=
bogjhMuyHMHIzWygj6Lg%3D&amp;reserved=3D0<https://nam11.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinf=
o%2Famd-gfx&data=3D02%7C01%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d=
85eca6667%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363570681227058&s=
data=3DulesiZTX8RCcr4IQRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&reserved=3D0>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C96b1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637363564431270216&amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5D=
bogjhMuyHMHIzWygj6Lg%3D&amp;reserved=3D0<https://nam11.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinf=
o%2Famd-gfx&data=3D02%7C01%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d=
85eca6667%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363570681227058&s=
data=3DulesiZTX8RCcr4IQRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&reserved=3D0>

--_000_BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0BY5PR12MB4115namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Kevin and Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.0pt">I think both you are ri=
ght. But currently we haven&#8217;t good method to handle this. It seems ne=
ed to re-arch the whole driver, not only refer to this patch. Only refer to=
 this patch, I think it is OK.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Wang, Kevin(Yang)<br>
<b>Sent:</b> Tuesday, September 22, 2020 3:38 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, JingWen &lt;=
JingWen.Chen2@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd: Skip not used microcode loading in=
 SRIOV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Embeddi=
ng these SRIOV check into the underlying functions is in many places, which=
 is not conducive to subsequent code optimization and maintenance.<o:p></o:=
p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">It took=
 a long time to clean up the SMU code before, but now some new checks have =
been introduced into the SMU code.&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I think=
 a new method should be adopted to solve this problem unless&nbsp;there's a=
 special reason.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang=
@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, September 22, 2020 3:25 PM<br>
<b>To:</b> Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingW=
en.Chen2@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingW=
en.Chen2@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in=
 SRIOV</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
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
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Jingwen Chen<br>
Sent: Tuesday, September 22, 2020 15:09<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingWen.Chen=
2@amd.com</a>&gt;<br>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV<br>
<br>
smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate=
 sw_init for navi12.<br>
<br>
v2: skip above fw in SRIOV for vega10 and sienna_cichlid<br>
Signed-off-by: Jingwen Chen &lt;<a href=3D"mailto:Jingwen.Chen2@amd.com">Ji=
ngwen.Chen2@amd.com</a>&gt;<br>
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
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d85eca6667%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637363570681227058&amp;sdata=3DulesiZTX8RCcr4I=
QRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&amp;reserved=3D0">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailma=
n%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40amd.com%7C96b=
1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637363564431270216&amp;amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5DbogjhMuyHMHIzWy=
gj6Lg%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CEmily.Deng%40amd.com%7C849a249868ba4128962408d85eca6667%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637363570681227058&amp;sdata=3DulesiZTX8RCcr4I=
QRg2E6aenA430mwjHi%2BhlfAuRGoc%3D&amp;reserved=3D0">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailma=
n%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40amd.com%7C96b=
1fda73cc94c3ec44408d85ec8f126%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637363564431270216&amp;amp;sdata=3DszoPYYfIpzZCyRrzYSR%2Fv5DbogjhMuyHMHIzWy=
gj6Lg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB4115EF7F980F6CEE08480F9E8F3B0BY5PR12MB4115namp_--

--===============1503473332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1503473332==--
