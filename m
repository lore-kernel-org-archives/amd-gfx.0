Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F490C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 05:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7370410E2DE;
	Tue, 24 Oct 2023 05:24:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2226610E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 05:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5PsOUFlaNGmxTUu6hUydJINVrWHRQArknV91pXcq1lyJX7oRk3MKNN45ee6q9rbxwF2+kRsPYTMtQs5bE/My+hScV9jkY5bbnPG/kq5fD50Rn4yZC9qWN7bzeHfuX9cic7goRinKpLeemIstGhGK2Ix8dMGnB4p9X5UGyR/yzMzZtMRZPGDdKknWz21br2LDWJwcn5kmGuXOEH//0Ydp5zqNpY6186Xmf+ZlGnrMLU8bMmvbcntn31DxZQ5HYYBJZ7W4Zr/Gy/sCKRXdgrixcamEIPaVFikHC4NwUAsSvyWpkFfgO/nY9lNuVMPJB8YzIG0V7jM0yxHwBeSWKIfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLDjAjklUA7OGm359tASDG3TGh1J+KBBKoZPppa941Q=;
 b=U5j0knjl5bkPV71XNvG3gBr+i7O1e7C/kwdpOK52IMJ7kXo4sWQfaGGjZW5PXlSpTdG6EKm3gSf7hh1g4PCLkjW4C+XibUQWxEumI2p+9S0bGjYsRpQONFPm6IUMeMHSJ5h8YAY87wz/BEQB1Tj5i1ugX3HRS+or8NpZXukhIyzH6vo1VthjE+KJD/CnJQc5gbeAhvh/G6ZOtELhG1AP0/PEJhrz0dvbi1jFwaV6VQSOGKhRCI9glKYx655IQRIR8t9Q3qGF05rrWRaM+KpdmXHOhVb37uJh4UL+4X1hDZUi0fQVMLcN/6w1JoPl0yw9e6Ul8Zeb+raXJNbBiEz/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLDjAjklUA7OGm359tASDG3TGh1J+KBBKoZPppa941Q=;
 b=u/vb4sECu3RSzCToqyaLcOjrOJPu0AxkWefLkhLG4NbjMX3DbG0yhtQI4SeMLKrdfESg3jq8z1t5wZUntxmv+E9e+ZsIqse1zrKFV9PgDpVNb3Ryg9W0RBr3wzPjhinfaCcsAlZebyb4tiGvvd9l9kpxCbvSnG8dBpFE3qw7GhU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 05:23:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 05:23:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>, 
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Thread-Topic: [PATCH 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Thread-Index: AQHaBiJ+nPkpbXA3w0WN9Po6/PaxVrBYZ0wA
Date: Tue, 24 Oct 2023 05:23:55 +0000
Message-ID: <PH7PR12MB599773B103A677179EEBC4F182DFA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
 <c8aab746fe07c1385caa25afac8e69bfad2e693d.1698114574.git.perry.yuan@amd.com>
In-Reply-To: <c8aab746fe07c1385caa25afac8e69bfad2e693d.1698114574.git.perry.yuan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fd716a7a-cabe-4bd2-8d85-ae865572e708;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T05:20:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB7521:EE_
x-ms-office365-filtering-correlation-id: 4621fb11-c3a4-4844-4d0c-08dbd4516b00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNKiA2uK4cRQzhefQV9jsZDfeOk3XQfzAgT5zinMTPutUeAkYbpEqCLi9w+UFg4DgR5lS3IZwLTPPwRVsAabcTEohJAmjiwyI6tSDiVIzt9LaNwuApB7nP8HC/x+MkvA7In0Kuf60oalDVvn+7Aj/I5yO+l5U0iHz0TmtbCbN0Um4XAtBeJTB0AG2dTs1N4hL4iJm0VrjoUWLeJRAGxjxP0pdIgEoI2+tOL9S0Cvwb8NJHbp4CluK4ORPNn+DNceZ1taOYYL1/MfF4E0u8bA6wQPKZh8L5UAwEhu5yP2kQ2L/59V7TLy1a9SV5/5J9JwAwW6YC3hTlP66yToHEQkdpGHkvculuKQdps48GkSiAAEPIkESITuJm9mEbX0AABPp0K9IAroU1XBiJDnFHR/RBSjaBJnbzCMuXQJZOCpnte2/Adt+9rdvMTyQqmuTxRsxRWyPezGnIN9r3IRob40GB6SZG2kAWZiDG3nyWcUorwSlbAkaSzWQj81645bb86iPOFEzlT00TmbAlclSItKd7HWzpskVe+iclCIXG2yxQxeAKHKgv1wRxWux4hQZ4EaADv/89Yx3QMLYw1d/cLw4icleA9U6n2sFDbkpFfOFghpmM/VMNML3aA755QfelFq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(2906002)(38100700002)(66476007)(110136005)(64756008)(66946007)(66556008)(76116006)(122000001)(6636002)(71200400001)(6506007)(478600001)(316002)(66446008)(7696005)(53546011)(9686003)(83380400001)(54906003)(41300700001)(4326008)(5660300002)(52536014)(86362001)(33656002)(8676002)(8936002)(38070700009)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hDtRO1YiSYNvSZnouPnau0Eg7FdTLqkZYx2zOx/Xpttrr7Bg2JudvtA7xRfQ?=
 =?us-ascii?Q?Ua7WufBLnFWkrI1xCoZZVR1wuH9588Ok9uRI/MCGll+HOVF/RNZVMUrB3Oqa?=
 =?us-ascii?Q?niL4hVO+YxO3OBEsQDDUn3M96Cne3kYa6imP7rhqCxj/YJJqyy03C5cWNbve?=
 =?us-ascii?Q?3V/VAz3MJoMX9e3xW9rUsOd+Szb8yKIAnY2OYTVieItNOXboMNdINUAo1Rxf?=
 =?us-ascii?Q?sT5rgsMSfWppdtaRJonsbMmEVeOkwTKKX10PccOkVX8du+6c1qvQjMmHn6+f?=
 =?us-ascii?Q?aensQoD1Gz3cVPP7IUTWmBIXpOLUim0uYdUAakez9KDnbMj4MkJQmHvZ+AOE?=
 =?us-ascii?Q?GF2ItV2Ses/Y5sVN0ghM2tDdlobpnjabCKIN+GNv2whkJ2+2Q2MjZYqoHILy?=
 =?us-ascii?Q?dS6YMA0Nl0OeoOgfXb7do/AdXHedT/n5UrFtS6yDvNVQpD06ZlrJlsIBXOd6?=
 =?us-ascii?Q?g2xNVPKMT0WRRTCAvp7GxYKMUIv2tBdHSZULoGcVnE1E4G6F2LgieyqfsEFQ?=
 =?us-ascii?Q?5mtMeQPekeJ3O7G0Z9zuhYWOyu7RuVyTKIBTtzt/jEfLyZju3oES82CsIveO?=
 =?us-ascii?Q?O4z9FotTC+CL6zFvcJ+MwRdSMUappO+kj+bj6BoxpHCgv8sDN6sWJCTWp29J?=
 =?us-ascii?Q?rYcrUPcIOFQiMNjWe7luv2D0zYf+Bn1UVYb4xIE5cdGzFeaK4nZ4ZKBmBSsf?=
 =?us-ascii?Q?hj2vligDeNSVW8HNo3fOeQUNGZtUkkGmax8IsyywW2V2sbuLA9QVJaEdZqy4?=
 =?us-ascii?Q?gGMmTXJO5r2HINJ3QEfTPRaj1bmO0V9ztKMF/bZN/am88Sj+CkoVAkyuZ4EN?=
 =?us-ascii?Q?Ly/W81RiE9BaFp3StAPiGq1OUXanAl+fy5q+TW6O1hpq1SCb3jZfbBQw9Ups?=
 =?us-ascii?Q?HOe8AqgtqmIw6cFt70V4nKId9JemaX0f40++HSE8XeFG27zdtbtagMyLuex8?=
 =?us-ascii?Q?8YzTDV366mQUrpr0cPsfmIF9SpSMnsKFFf6qz+TZhEkIxcuC8LdXcnG0v7zJ?=
 =?us-ascii?Q?mkXcqpTn7iS88F/lEGJqUeNqWFkewcnx9DHlApjPUznNlPwBYXu3jvHNvyui?=
 =?us-ascii?Q?Lla95c5rjD1WqPRTnHK0Irnc81o0FmcmDyy0zzG4TstTusFstEWxUFSRLcYW?=
 =?us-ascii?Q?im8wasSDDU8cPDD/UwTkhWDfASTTw1L78U5eSq2bIj5/YdkyRNxgvx8fZiQ+?=
 =?us-ascii?Q?ViUxwd0KwyD5UQa6XnaPI7s6G/A/m+v//cQ+u23PyaA/Iuxz30WOyzyKopGU?=
 =?us-ascii?Q?9IoHsajpkmXcyvZvQXHRZvPyTqwqDszNPxpW18vPwZ958IhtYKcwtshNI1tH?=
 =?us-ascii?Q?OYPu6ynl34afb8MIG3SVVEIAaWd8gT+/m4wHieSJrX71U4XNupEGnsK53HwO?=
 =?us-ascii?Q?ch6GrjxwcBMZJpOm558SqDlwfyM5SWuJQ6doH+uImfl9lRrsJkbFwPynPoMf?=
 =?us-ascii?Q?hCmjUgG9aBneNxEnwgPPuop6u9g6lvitoxCcp8NDpNTEFAe5n1UMbKHdx7Sv?=
 =?us-ascii?Q?OB4oEfXyuoZWIwj8VWdVQU+EJ+tpJAYIo27ufGe6zMquI7eXK53yv8iaehWS?=
 =?us-ascii?Q?DDNzfZNEQhbDLKnCJmc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621fb11-c3a4-4844-4d0c-08dbd4516b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 05:23:55.5664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEkaDKwShBf/Kcp4nWQt0ZMp3Bx13BaeV0Uoh++4oRSJNMjwSI5axlX9YIIwTod3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Tuesday, October 24, 2023 10:33 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: avoid sending csib command when system res=
umes from S3

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

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++++  drivers/gpu/drm/amd/am=
dgpu/gfx_v10_0.c  | 29 ++++++++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 44df1a5bce7f..e5d85ea26a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1114,6 +1114,7 @@ struct amdgpu_device {
        bool                            debug_vm;
        bool                            debug_largebar;
        bool                            debug_disable_soft_recovery;
+       bool                            csib_initialized;
[Kevin]:
you'd better use space to instead of "tab" , to align with other field.

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
index 6399bc71c56d..ab2e3e592dfc 100644
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
@@ -6035,6 +6029,25 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_devi=
ce *adev)

                amdgpu_ring_commit(ring);
        }
+
+       gfx_v10_0_wait_for_idle(adev);
[kevin]:
Do you forgot to check return value here?  If you want to ignore the return=
 result, you'd better put some comments here.
Thanks.

Best Regards,
Kevin

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

