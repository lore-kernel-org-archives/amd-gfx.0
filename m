Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F58C25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 07:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7216C10E76A;
	Thu, 26 Oct 2023 07:31:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B4210E76A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 07:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcjyPiYxZ3Rc/20VVirlFXG2PvkaGVV/iSoIGTsMUOuNEPIVudfPNZW4WfIAU3C37B1rtoD/cz36ck/x8gDW6dc3/LjgjnyOrMxiHPIypCQ/c3dbAPgijPMdSHmNa2aAFmtmpbROX1XvhFbJMtJ85hP0bXbKlaMqpStd0Ql+vmpFkD8BOLbHdR0PRRnM2ojxUJPUSBKEiyhJbvQbHoBdmGKz3CzhNpdJPVVG+FnB4MyaSzCef95xGNmjD3RTtm8fxjhTKqRoQ3uHLyDod57LPqRuKYFTHJSEbMZGuOt343yGL3FvIagHSH6fBgz6aSdwkW98v+v13Es5hcnVnYlsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqA7ws8t4/XDsKdnLN0sRmXLxGWcR59/p9VSFcI88G0=;
 b=N5nm2ZyksJygC8oPC8VvXE6UN2EpSx4X8S5Yxd6GvOzH2VamXpqjeej8X7TtLEZGG5AQmS2XnIaZ3z+DbTLeEMlrnzRQpbh7tfT4s0XIcUzvCr2L4EPMZ2uWbgEEKeff+BiR8JZDDV7N7sBBuHUvWaCeuCSIUFb45zszZeOQu12Qp2YnZUVXycz9OPRgYTOd88BO3dTU1nh6K6to5vOTTW3eyBfcyt3fGa9GgMmCg4QD2ujbY/F6mBk5jMw/9ri2RIhW3P84lIIlYourMdzQm+tzgfDsuNEz+aXwDkKTZ8ger3KraURSuGPYFYPLSQq1tPiEjhmBjnea2q+jmeNRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqA7ws8t4/XDsKdnLN0sRmXLxGWcR59/p9VSFcI88G0=;
 b=0HPBWAtPesqLJgbfJfUHwQQB83MOiPAMGJivKjbYYS+s1b6uYSiFwybJBWlZfKVaobiaQH3dE2lgtIFy09+rVQ1LiUobyJKx8W+Xn+ctBV6+qxkirXjQM6CDxguEmcVEXZam1rucA/ZQ2zSnxo3r63YBDu2jqS0UTLWZe04mpow=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 07:31:17 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 07:31:17 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Thread-Topic: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when
 system resumes from S3
Thread-Index: AQHaBolXT7qlqmrERkuea16E3Eapg7Bbr7fQ
Date: Thu, 26 Oct 2023 07:31:16 +0000
Message-ID: <CY5PR12MB63690CB8961261A2B0E64620C1DDA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
 <3e270efa46affe3c52614099575368726eb32793.1698158958.git.perry.yuan@amd.com>
In-Reply-To: <3e270efa46affe3c52614099575368726eb32793.1698158958.git.perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a1a0ff45-6a71-40e6-ab4f-f00b7db4d757;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T07:31:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW6PR12MB8916:EE_
x-ms-office365-filtering-correlation-id: 5d576dc8-71b5-4a2d-4d9d-08dbd5f58a7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94zTYxyqEEGnRIf/cX8GitPTjl4KRWD7mkgHnVmG31MNMAuB4Ylw3dn+taJlmiDijm4EqjczIhL7kf5zzH1onocUYeMbWpwUHSKyeqggfqbbUrxz1kmIctVLzMd7KS3qa0PjmhiFpEVOIkb8JdcX2yCeq8WMA8IAY9vlI1j/O3jbNE+BWi8FeKmKdDidvMevoEZo1WmzsTUpZ8JwHspdGQETgAG/6jkABOU7bYIZ8ipFTji2i2RU6tbjuxJJ+gIfdpnzUI0VKWORC/JnX9p7jk85FwaCCHg3rVgea6A7pDw1SrmFZo2oK1luT78b8YdN9GtYCRJQM5V8EMbCXdMLoqejzyGn2ATWUhfAzzxMsHl6wky64qEMhXmCp8doqknqk4ugR7010pKIXxAqp3mJlna6QWfYnKId2oQ3L9xLEtrhF/2vc++ha3nIpNPAKFfa7Ke4WzSWkBgT4AR4GmFvBfTlWxGCAXc1obIAD9B79jCZfx0dpmBvmcBUVq8dzHOma9FJtgBH6lW2WsmkXl+bcEJmEXJUSfNr3BhGv4On4s4zJ7+5mMexL6x16mqlpinH6ng9u2MZRphr1W7BqRkNSnhkMW9xI6oNAtydAU5fDRA73ubcVEQbM/QnZqmPgXWc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700009)(26005)(38100700002)(55016003)(122000001)(2906002)(6636002)(86362001)(4326008)(76116006)(8936002)(8676002)(33656002)(54906003)(110136005)(71200400001)(66446008)(478600001)(64756008)(7696005)(6506007)(52536014)(66556008)(41300700001)(66476007)(66946007)(316002)(83380400001)(5660300002)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qJeF55/OaovZmphIK+l2ez/kNiwsKmPpYlYusFYLosvRy7R4YENvftoj1d/t?=
 =?us-ascii?Q?Cbc6Qyp3jYcjXWBzkRkca9ksq2nv16o3CIgT4ifkwAgWyZLy4JMI0GVbHQKV?=
 =?us-ascii?Q?pzbgScYdvVkU+55hbnfr0P4Q9G17p+7pW+kFz84exQV4ekvug8tQrL9ZKO1M?=
 =?us-ascii?Q?Y1FnFI9VjYL6AzmFVBDLAcAsW+xPonJS6uQwsOVwXrF5uqX8+FPEDGwGhL6B?=
 =?us-ascii?Q?n2o4N/SAZ/VJ5U1UBaFNtNGaO1g7/ZZgM7ojeOAhlMPcu87+2QSDjbIkhPuS?=
 =?us-ascii?Q?Knp9jycwGsduHU3tPNtBgh1qPXK5K2Beq8U8i0dOKaBwQBQAJMP3OKqJsA72?=
 =?us-ascii?Q?Nklu2mnXH1i8yBksToKQGm95b/sYfqVFUTuL+dGilXoLviu1vLse2GMkHGox?=
 =?us-ascii?Q?d+PTvCw+7H1cbI+8sW4DtlbU79RCf6XVqjkNkblKJ/fSbTyt0c/vRjM7mMn6?=
 =?us-ascii?Q?zOIWPq5xpEIL2Xfe6LrIBAq9dWmNpz5RFVNHyxNG4b9cD1Gg+HTwzm5kfWS/?=
 =?us-ascii?Q?ztiiSvmtn/HSrMY+aRpsCJIjEFwGBbIuHDWc5crMseqKc/KXdFDHOaD2pPAy?=
 =?us-ascii?Q?TtxINIjoUWTWDfHGZ7gsXj0haR9k0xN3EbirrULXHKdlhPv1T8V/CqrZMfBd?=
 =?us-ascii?Q?pPtNv57OUcUmYSQiJnrmshu2ZFz9UdBgUVYvO6FbL3QFMCAJnb1kzwTeQL6a?=
 =?us-ascii?Q?0yRCQ09smi9Nrn+67xw2OI0BJeMLG5ZJwaEh8lBc9fG0Z5ezqQfW2kY2dcUr?=
 =?us-ascii?Q?HHmCdm0csaXaHbTivaQ0wsb4ae34xx+RiwnUNW508nDWL2LPKLM6LA91SzWd?=
 =?us-ascii?Q?P/WmaU7JC6SkOgy2OWCl7Fc1UIEOcGUiFSShXCM2GmewiDVR/h4SxJpaK1MC?=
 =?us-ascii?Q?TO0t78P8kJBwnRT7j9AoV6D8POosk7jlnc0NBXwz6wyHwNBF2Ot95kPR8vSL?=
 =?us-ascii?Q?gHTnyA3pl37fUqi4riEOKSTmWTij4chOr2xWDOhuyz4Kl9zegxSO7WeiIJ0N?=
 =?us-ascii?Q?VcfAXcB8hVPcdxAKm7nUIk236vMOeGpyRvGz6NktSSb2bmqUhl3USSOQK+oO?=
 =?us-ascii?Q?KvaR0xMmui0mZE5NfHnMDtvhknAd10aHA/kFKL9LTpFZVqsiQ9u4CnwGNDeZ?=
 =?us-ascii?Q?ywV2eEtz/PAeSyDO5MD3876b1UXOschI0taGEbdksjY4vsChFi8QiBaq6PbP?=
 =?us-ascii?Q?mAcP9C5pALsjiy28m6Ay1DJuLWpsZzakqP+pCYgFJHvy4lBE/qH7yce2rdQC?=
 =?us-ascii?Q?lXMDQ17DxNLXcEUhQvSzt86eLk617+6FO5bmE2Xl1RWiYI6AvZ6CvYSGGSgH?=
 =?us-ascii?Q?+8akkvSdurEQPAK/qE2WY+L5mjiEWYlAZK10pK/PRQOy7KCMMBadcsru/ErB?=
 =?us-ascii?Q?l3FP3EnKP/r+2CPtZXzo8zo/u/erk9/nxWD41MhI0a3t7dN66JXPmoGmK0oo?=
 =?us-ascii?Q?jqtNhNUgWgZLElv4bHsOyyf+NIEaVzdn8TfoxMhoKv0SRDuixBQCNoVwnOS4?=
 =?us-ascii?Q?uaW0itWxxqGDCmm0WgjX5b8/hs0oXJBXkL4tPh2GSpAPuGwUuZyEpD7/mfQc?=
 =?us-ascii?Q?F+ePAFVyVtoIkaQOtW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d576dc8-71b5-4a2d-4d9d-08dbd5f58a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 07:31:16.9515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+uNyKTmj2BJ9aPsmIcCfDsU4kxvnWhzT/qM4Y8XD3ACgF+vfIrtCHjJBmc90usH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Tuesday, October 24, 2023 10:50 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when system =
resumes from S3

Previously the CSIB command pocket was sent to GFX block while amdgpu drive=
r loading or S3 resuming time all the time.
As the CP protocol required, the CSIB is not needed to send again while GC =
is not powered down while resuming from aborted S3 suspend sequence.

PREAMBLE_CNTL packet coming in the ring after PG event where the RLC alread=
y sent its copy of CSIB, send another CSIB pocket will cause Gfx IB testing=
 timeout when system resume from S3.

Add flag `csib_initialized` to make sure normal S3 suspend/resume will init=
ialize csib normally, when system abort to S3 suspend and resume immediatel=
y because of some failed suspend callback, GPU is not power down at that ti=
me, so csib command is not needed to send again.

Error dmesg log:
amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test fa=
iled on gfx_0.0.0 (-110).
[drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test=
 failed (-110).
PM: resume of devices complete after 2373.995 msecs
PM: Finishing wakeup.

v1-v2:
 * align csib_initialized with other failed with space[Kevin]
 * check return value check for gfx_v10_0_wait_for_idle()[Kevin]

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 ++++  drivers/gpu/drm/amd/amd=
gpu/gfx_v10_0.c  | 32 ++++++++++++++++++-------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 44df1a5bce7f..7d570f53e66b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1114,6 +1114,7 @@ struct amdgpu_device {
        bool                            debug_vm;
        bool                            debug_largebar;
        bool                            debug_disable_soft_recovery;
+       bool                            csib_initialized;
 };

 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_drv.c
index 420196a17e22..a47c9f840754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2468,6 +2468,11 @@ static int amdgpu_pmops_suspend_noirq(struct device =
*dev)
        if (amdgpu_acpi_should_gpu_reset(adev))
                return amdgpu_asic_reset(adev);

+       /* update flag to make sure csib will be sent when system
+        * resume from normal S3
+        */
+       adev->csib_initialized =3D false;
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 6399bc71c56d..138340e1fa95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3481,6 +3481,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struc=
t amdgpu_device *adev);  static void gfx_v10_0_select_se_sh(struct amdgpu_d=
evice *adev, u32 se_num,
                                   u32 sh_num, u32 instance, int xcc_id);  =
static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *ade=
v);
+static int gfx_v10_0_wait_for_idle(void *handle);

 static int gfx_v10_0_rlc_backdoor_autoload_buffer_init(struct amdgpu_devic=
e *adev);  static void gfx_v10_0_rlc_backdoor_autoload_buffer_fini(struct a=
mdgpu_device *adev); @@ -5958,7 +5959,7 @@ static int gfx_v10_0_cp_gfx_load=
_microcode(struct amdgpu_device *adev)
        return 0;
 }

-static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
+static int gfx_v10_csib_submit(struct amdgpu_device *adev)
 {
        struct amdgpu_ring *ring;
        const struct cs_section_def *sect =3D NULL; @@ -5966,13 +5967,6 @@ =
static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
        int r, i;
        int ctx_reg_offset;

-       /* init the CP */
-       WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
-                    adev->gfx.config.max_hw_contexts - 1);
-       WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
-
-       gfx_v10_0_cp_gfx_enable(adev, true);
-
        ring =3D &adev->gfx.gfx_ring[0];
        r =3D amdgpu_ring_alloc(ring, gfx_v10_0_get_csb_size(adev) + 4);
        if (r) {
@@ -6035,6 +6029,28 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_devi=
ce *adev)

                amdgpu_ring_commit(ring);
        }
+
+       r =3D gfx_v10_0_wait_for_idle(adev);
+       if (r)
+               return r;
+
+       adev->csib_initialized =3D true;
+
+       return 0;
+};
+
+static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev) {
+       /* init the CP */
+       WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
+                    adev->gfx.config.max_hw_contexts - 1);
+       WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
+
+       gfx_v10_0_cp_gfx_enable(adev, true);
+
+       if (!adev->csib_initialized)
+               gfx_v10_csib_submit(adev);
+
        return 0;
 }

--
2.34.1

