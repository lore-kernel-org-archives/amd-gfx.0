Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7ACC001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 09:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3AD10E3DA;
	Tue,  8 Aug 2023 09:54:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F363910E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 09:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcuvwXRvwlZ/XhDrsFmTU342WVMSc1OcM56rVIbhfhNgGsdxzPYazJbYAsXuxXEXNjIkx3N5QaK6WXUEicJk//Ym4GWHYbnk+kQMvWUYCYSt+QA8xILgKhaLIE5MOerG68oxDaMUJDSaUaFfe+1xbXqHVYjw38+yNFcASQ/U/ufAfAYUtuhhaPiu6kabfsAQzopN/Tm0g8RiB3UJPurZHMeW8qsGl15IdtqSZIidUNT7mDuiXhT2J5mXPx0sy+3SdYC4RdrTVf3nivjWPfDxl5u13kyn3lar1UmJLvZ9F9sXrX4OV53z1MjtqK5stLaKawbX5+v3uogWEmS+5Us3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9dDu6n7kVRORw4aI4hYLquLazkrUrprMTpwWlVq3B0=;
 b=Vv0cvoX8hvSu9sZr1w5x1Geolf/TZO6bXkdRTxQJWYhxK9KzBhBMkAlAgzpBm6cTunie/Q7e5W1FUATixufVGLsH8DpWsBdqmAGCYo4y7fpBWvWjJe1jv4lVvZj34er1GhrHXmODxRnf4wO6SjPlNXSmCanaUmTD/IFprURSMiH0zvdsY0P4hPmTbbjucq5WupjeAZDTaPuhntQP6wiC0UxmmYdTcmczwwbs3OeGl39LcIPThJv2i9iQGpxaz2vSnWjCUS5axGrCLBjCW9OjMa87pkEKMaotlA/bNAGw1aMCLOezxrinNwmCx98qAToaxD1RTXobVlAyqCQ2ABHFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9dDu6n7kVRORw4aI4hYLquLazkrUrprMTpwWlVq3B0=;
 b=LpZjfH7uto27E/8t9HECe3mHUBOaQGOF0bA0uz7G0sBK+vYGGNTc+Wt4IKpi9xAjLUc0ufz6WjquUgW1DfHr5Pu781/ZTBeY3LCtMENDMJZdlQuaJnXD9L4QwwU9dhAVpnsudJO0r5Mb3uPSbqFlkWN095KqKhSHHFBI6/xJ1ZA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:54:40 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e2ee:2947:91e1:82c3]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e2ee:2947:91e1:82c3%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 09:54:40 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Thread-Topic: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Thread-Index: AQHZyc7IsM+1yJ7VGk6BuLfjHRNmPq/gJ+KAgAABJHA=
Date: Tue, 8 Aug 2023 09:54:40 +0000
Message-ID: <CH2PR12MB4215849221CC05221CD6C212FC0DA@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230808080211.3857950-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257B1064B8861ECE080C8C4FC0DA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257B1064B8861ECE080C8C4FC0DA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6009bbea-898d-4003-8c51-3d2f3f65b11f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T09:41:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SJ1PR12MB6195:EE_
x-ms-office365-filtering-correlation-id: 612b210c-323f-4def-7b9c-08db97f57bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xseyDMa9/cp8o/7a8UPmCzatIebUNepvMVA3rpat01YUL/LjEAr+qQTi0JPjyKMClEvmR8LaOxhUbHr6DUhPUTfBqem6LZF9MLIOVLebFRwplMfxQ9KuhtDWHAVjvkZg73EX1XR4bPQWXxpMoviP5RhnDVvHviEt+unthHM0cImSAc4j1hB3ym0bCvouzUwYrt6HBW7UkJNGyfpr8D4/dABxVqSeiUH6/pb2Pc74zRP7Z51PBgTYbHOxbuuwFTHUaFuGO1AL87TTW4jEyjbqyaMnN/SvglWLGsz8DJ77xXZYZ4UfnuWuIvgEYi77UF/lk9tzBl9I0C6PTeI5fTB07bgQi3YSZwIBo90FusgJ9t3t4vH10yrUBVQg9V+ghIjwQC9yDGt48dTd8y1MrHbWcrwXDo7bzhMyFu+sE+INx+dqLtT1bA4AklhXGI4bnYri3fnJ98T9HIQDj1Nv+1SWVWKFLoaALRgW+671dj2YV1ANigxxl1LC2Tz/L04UddM4IjSeL5KmEh+SyLd5gChGOFqp8a8kWrSKUECpfa5NoLxP3oMs7A1W5KuDU43A3vHtMzIMhn58BBrzmUMC0KoNdZK4koUegqVbcNT34OA46ZRrzxF9xE4L0rB8OxPvyNBX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799003)(83380400001)(55016003)(71200400001)(4326008)(110136005)(54906003)(2906002)(38100700002)(5660300002)(316002)(38070700005)(52536014)(8676002)(8936002)(66946007)(66476007)(64756008)(66446008)(76116006)(66556008)(33656002)(86362001)(9686003)(478600001)(122000001)(7696005)(41300700001)(6506007)(26005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gyn90ikJUFmqLocknJ0kv71Znjj7T+DXT/9RsxSsCeGPpSQmkk/Yh2rS4urE?=
 =?us-ascii?Q?2h/MgNZq6ZRkgqLpDlAOE47U32t1QhY1mLSFNVykyrziA4yRcAfPSOWlLvcX?=
 =?us-ascii?Q?2m7kddukg2I/VZA7oTKLZNbpCENBPu7oeHo0IU8wAuXCyRTYyFOXxk0YZiK9?=
 =?us-ascii?Q?dIZ7sL0XyyIf0QbxyqKhcZ0HwQy0evMD3g7pXc3RInKUmZmW1NfuUdyTHn8O?=
 =?us-ascii?Q?l+bKxx0qbMPFyBQgZDtGW4ofF60wxclPqVwVXOjVwGmt4IEWGa8sEVvlxDAg?=
 =?us-ascii?Q?/BFfVxc3cTQqyDqECcbWzV/jQwisrIivrUE8+rnWWIIFfplmoXVfNgH2FGGm?=
 =?us-ascii?Q?P0A8vtGiMtFKtzxcDoVA6qRl80SJz+MXKMCbhRJRtKjqS3T4QAMeoKYYEA4K?=
 =?us-ascii?Q?ZTQYKtwR0Tqlmqhkr3MEgNbF4y6+vprfXCVo/A6cSUKZfQDPYAQrZxE9GZA8?=
 =?us-ascii?Q?mFPBEndNB0j9liL/cJhmBOkUADG/2Peh0Qp9XA7LWgbO5niIGCitY2bXzH+3?=
 =?us-ascii?Q?E8nEXejgjUEiTIBLDmndxih50bB7gZ6fD3Ve3WJIFKEopIIpCOz67U+ElWCU?=
 =?us-ascii?Q?jNJwu2Bpynn/ubHJw9L5YySiCyCC++rhQ0sBZFIxze4GTzuKBVgEa4zpOMzr?=
 =?us-ascii?Q?3Xtm+WEdshAbeIGuTYOziANFoSRfITU1DIL0FTyMOpSvkAm17SG+4AUgpt4B?=
 =?us-ascii?Q?ChbXfjkYhC19IB9rxysRvYz/lV2RZuTsEwhzUjJMdfGXDKFJe/9CD2prXZ2t?=
 =?us-ascii?Q?qhrajhcU1/+4t0vATjm6CcXtBIHVcWlzJ91nwIgIdGB3INYGKIg2ssO2tf1d?=
 =?us-ascii?Q?dB3cOcfWupvLpFmDGzK4MTxVrObNhNy2BLC2ljz3EUP+rCr/j9++ccjHmBEZ?=
 =?us-ascii?Q?bwfvBo9xHGy3WUpYFHFZoSiT0z7GDh3oQNQ0XTcbsMHpJCmoNahXCgsHll49?=
 =?us-ascii?Q?LGvZar/45t3EpVzvU2VoZc935hW4Thh2LiovYFmwxULb+XKnPuMtFp8VfF/E?=
 =?us-ascii?Q?pMVqiw+r/3WUI0Vl95BgublOltNysa5HrNARLJtCIWTE+zaNDpJFd0dsP0+V?=
 =?us-ascii?Q?/x4S1p+UES6ktPZyUx+78FrAHHInC3fAv1rJPyWgYIS3oCzQ6nisAE2O7AL4?=
 =?us-ascii?Q?CvWMHZN26z6vTTphPj7p06FTRxP4AdhY5hH9pPyrRGdkfR+eoFHCkieVvWp9?=
 =?us-ascii?Q?4r/WO/YA1UmEmSs7MvycjGYrzETAFIP9508miVCRfe70o6DH0AUfl5AgPB95?=
 =?us-ascii?Q?p4CnvGCOokiK4S7wY6jEvz2tN+9pKaohzJQA/dAONcdJbMBf8L5JxIfz+lYp?=
 =?us-ascii?Q?fkY/CR/vRjRWvanjMTn4RMuqTBK2Oomfdc+QH7csWEhA5t6qqMA9WUXppISo?=
 =?us-ascii?Q?nuXEeBzUC56Q/eElkhFNn/WVw2pJIIYhb1bhnvg1iPr9ujXXlwiStWmfVoI/?=
 =?us-ascii?Q?RIgWY8ZEdBmvHp1gvrlh9uQG9MEJchkywu685M6872uQSvC11J97MTPywoqv?=
 =?us-ascii?Q?AzIN+QExiC0QZj9TkHFtO/+F4xt9Wk6zW/KkCWCOs8OxdN+EmCuYql0jYQav?=
 =?us-ascii?Q?RF/+MkmGbRxz7vshxNE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612b210c-323f-4def-7b9c-08db97f57bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 09:54:40.1199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eny5xNo1BS104QP+fFfeiLW7whENvourFlFDofrLl13CG5j4lnBb9N0LFaALX15xbCBC9yaPwH306rm3WR4PTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

OK, will do


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, August 8, 2023 5:50 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Yan=
g, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, =
Candice <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0 v=
13_0_10

[AMD Official Use Only - General]

Like other psp callback helper defined in amdgpu_psp.h, let's define a macr=
o called psp_fatal_error_recovery_quirk to wrap the psp function (psp_v13_0=
_fatal_error_recovery_quirk)

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Tuesday, August 8, 2023 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Yan=
g, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, =
Candice <Candice.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0 v13_0=
_10

Mode1 reset needs to recover mp1 in fatal error case for mp0 v13_0_10.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.c |  3 +++  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 24 ++++++=
+++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index e8cbfacb5ac1..763242d702c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -127,6 +127,7 @@ struct psp_funcs
        int (*ring_destroy)(struct psp_context *psp,
                            enum psp_ring_type ring_type);
        bool (*smu_reload_quirk)(struct psp_context *psp);
+       int (*pre_mode1_reset)(struct psp_context *psp);
        int (*mode1_reset)(struct psp_context *psp);
        int (*mem_training)(struct psp_context *psp, uint32_t ops);
        uint32_t (*ring_get_wptr)(struct psp_context *psp); diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_r=
as.c
index 50c38f75769c..f59f0cc2ab5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,6 +2066,9 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
                        if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MOD=
E1_RESET) {
                                ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET;
                                set_bit(AMDGPU_NEED_FULL_RESET, &reset_cont=
ext.flags);
+
+                               if (adev->psp.funcs && adev->psp.funcs->pre=
_mode1_reset)
+                                       adev->psp.funcs->pre_mode1_reset(&a=
dev->psp);
                        }
                }

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 58db1ee631b3..65c44c7d2b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -691,6 +691,27 @@ static int psp_v13_0_vbflash_status(struct psp_context=
 *psp)
        return RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);  }

+static int psp_v13_0_pre_mode1_reset(struct psp_context *psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+
+       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) {
+               uint32_t  reg_data;
+               /* MP1 fatal error: trigger PSP dram read to unhalt PSP
+                * during MP1 triggered sync flood.
+                */
+               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67);
+               WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, reg_data + 0x10)=
;
+
+               /* delay 1000ms for the mode1 reset for fatal error
+                * to be recovered back.
+                */
+               msleep(1000);
+       }
+
+       return 0;
+}
+
 static const struct psp_funcs psp_v13_0_funcs =3D {
        .init_microcode =3D psp_v13_0_init_microcode,
        .bootloader_load_kdb =3D psp_v13_0_bootloader_load_kdb, @@ -710,7 +=
731,8 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
        .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
        .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
        .update_spirom =3D psp_v13_0_update_spirom,
-       .vbflash_stat =3D psp_v13_0_vbflash_status
+       .vbflash_stat =3D psp_v13_0_vbflash_status,
+       .pre_mode1_reset =3D psp_v13_0_pre_mode1_reset,
 };

 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
--
2.34.1


