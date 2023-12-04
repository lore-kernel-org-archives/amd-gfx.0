Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1ABC10DC1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 15:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8CD10E04F;
	Mon,  4 Dec 2023 15:55:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1399B10E04F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 15:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GybDdxFMV3g/rEjJZT2TQpf0kkmeLY3R4KtPAvfw/9bkH1xmBHVUekV+kcefu9CX7UzBTk0o254GtLWxZIByccvU78oekkCA/PDcNp+mJ2GbWO3/yOl38O1vzT0iOEAVeClswJI82OS5yoRtxVKa5x9ZVoaQSwCHEkYL735m1vSrQQcALS0EP+PWEF5S65e84AvyF9D/hd5d2273o1KckTapgbmbct5l3JwUTDQQgDhEzHFIlB0sGPYqNqD6SZcOOfpy7dXhlKkyFFvQrj4PSVArRES524AnBvOZLzU4WIUCBYgYxcxDBpbMiuRtno74xoZcDKY6YX4K5x8bfp2kkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5078rb85gvMmA2bGFU7HCBjK7dn2znkfk//lj3O8uo=;
 b=ksDGRkgxPV79alZkCbt1lIb17fCJAGt/AiDHM8wbe+Wj/8oYaqkA1lHFELYXhELB59/I4uDaz4YRsszBHkb30usLgAUqTDi74TNN7CP9xdHjjxEknny44CRFSlOOEOYJ9u1OdTOUNTvogJ02E9zIJouCUAGzRKA3ZrlzKZrZMz9y1URfRfMUWl32ZsBHa4+DgmyNx1KuCTYnpDzZe4j48IrnYdloSdw4ftiIas8ExTUGhoe6M3nNipuwy3e/dxrM+U7fQIy4B4K8hoQvmi3ALCw0G5rChkvkfEVyyAr5n6aM9UvsPDpbIGhpVsQUegvV3QhPi0DbJqAH0JMrA3l+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5078rb85gvMmA2bGFU7HCBjK7dn2znkfk//lj3O8uo=;
 b=DhwdVgNWbZ2gQbaQTu+L5hdSWGX7+FrTh2RIyN9qiPjX/Io8zM0nl0qQ5X2UdSicZtMR3Tvw/CszvanbsEkZeugSpy/tHb0mG/IVdlApT5n7Gi97SCnBk9bXeITtxCoVGfAVsxILjP5qBgImWy1rZsazn59VrCQORQlT257/Dy0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 4 Dec
 2023 15:55:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 15:55:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Topic: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Index: AQHaHfTM+o7Q9tKoqUC859uE3ReQ9rCOqIeQgAo5woCAAHWpQA==
Date: Mon, 4 Dec 2023 15:55:36 +0000
Message-ID: <BL1PR12MB5144B65DA838B71AC6568E50F786A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231123100645.235821-1-li.ma@amd.com>
 <BL1PR12MB5144909C7C9B11362D4F23BEF7BDA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <SJ1PR12MB60753D131385D5AEC27EF024FA86A@SJ1PR12MB6075.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB60753D131385D5AEC27EF024FA86A@SJ1PR12MB6075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d3fb3ec6-baf2-4429-87b2-0d260c7442c1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-27T20:42:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB7321:EE_
x-ms-office365-filtering-correlation-id: c6a52f32-1bb6-4c95-ed09-08dbf4e174ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZx5f05a/C9v52wOCHttfldv1bseqswKd3NyOeDUqy5TgmvduzVHqJpkxvNPYt+BuRzzOu4xNsTttHp5AMyVy4XqblzHjn5Jo7WRzB+0lxEZ6+MiHQOTYwGQ6mdcHuHJQBtmUsr/rspVCp5KyYYLi8xjDlGb4vB+AB8X7ZDLSSN1qmSW0VOyp6CiSivbcGDgjevT6f+PnauO7YoJxd2HQohpiqingaZAYVmRq0u8Cb5Cwl1nE4I14ttU8lWUEU/0Pt2pXn1uxexQct8HaU9rjXFH0y9qOmIB5pJ/IZU0hSMnZ6k4R3S83E2d5YmVMUDEUIEAklQZKMi9e9pIJz3mWFzGQHBzhrR/HfHoDqqHYx1tHEs6vc+kw+CNJTbhzcF4knOUk7J1s23goNjDdyYTTMNctxhrnCOfuBSIO08f94enCDR4SJuD/x1bzTp5wgFn4MUEpMVMWoXxTR0v2NZ1J5K+fgv5cAoTOQqNeul3EA2zU6Njlimbm/n5IgZPqswSe0DrFoqK7RGaVRPSMZSuTC8ra+48gAaJjGA4oFHpCS7uHTIZvwiDVGYI57hBILIyg3BkMPjS8Fx9vBSKPsCyIfbWvp4DxjhWtKJI/ambzNWivfxlJiUt0aIyqmfSUtWZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(38100700002)(86362001)(33656002)(38070700009)(122000001)(15650500001)(55016003)(30864003)(5660300002)(26005)(83380400001)(53546011)(9686003)(6506007)(7696005)(4326008)(2906002)(52536014)(8936002)(8676002)(478600001)(71200400001)(66946007)(66556008)(110136005)(66476007)(66446008)(76116006)(316002)(54906003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fkZ65fJ84h1dLHYFpMWhMjGxDB8UIMOkDVtMndK/lNU/NBU1g4JS9gmeZ8Qa?=
 =?us-ascii?Q?3lN1gzGqBiBUu1PEPK8Hl29pw29GI5DSEQvG+p1Rg7wuCNeHsQl+ZRGzrFOd?=
 =?us-ascii?Q?P/5MwPsR1ykDzKYq1JPS8HgmocyAAuxc5J+Jss3gJoC7UOw8x5WWL8UdoyCA?=
 =?us-ascii?Q?i1BA2Trbb5awHxqH2rh2RJUafYcgyQKs2ItcS6fhNLy58deYmhCsUgcDODjd?=
 =?us-ascii?Q?tRaZhhRHONrdeIsUNHUsu1R98WlG4po7vB+EmpQuQi3o3rKUPYawqCfkEyyL?=
 =?us-ascii?Q?MXliwv2eQ6dm7iqKtBmYvH4SU5v3VHKxLGbO5Kj08PwC5u95oqw1HW1k7rLx?=
 =?us-ascii?Q?3PxZMqysJDyz2ADveNWa9mvMtEdmlct2EiT+ZzE4DqqK2Wf7IQ+vQPCV1zXG?=
 =?us-ascii?Q?dgmeFtI/eqxR1tMUxTiIy8fw3XweRbqeG7ltbJk1RC1JFSMTLBYsRrhCI3Wh?=
 =?us-ascii?Q?Y77cGJRO7m68xl/Rd5oHLqBcWAUErotnaN74cAb91jIO5CFbuWigix8vT84c?=
 =?us-ascii?Q?+sF/Ruaj5TFLUx5j3Eui8Gqyh1KI3TIoWtQnFw4BfYcHjOH7vk2isR5QgA9b?=
 =?us-ascii?Q?Eb2uBcaqSkYJc+rhKT9yA3MdJW3GYKIbA8wVJ9V4iObVWuaYvo+1mbf00FUH?=
 =?us-ascii?Q?u5hN4fmMCvW1yanBeKzl6eDFfv5gfUWnDbEQ1LMayuWOJUKAz6Gf4Saan12Y?=
 =?us-ascii?Q?frZpsDaaZ2Q4qsVhB0A44YbEzn9nzSjcfnPv5u/Mid17fAZc7d33x1AumhPz?=
 =?us-ascii?Q?jkSyl9gw65gC4qLAL62PhYt8CcPm5+wnbDD1VY3gR1bLmldT7eDy+W4r6D7/?=
 =?us-ascii?Q?o3wV62Qo2LQ3ggTSiTYzFkBz8xyB+UYZVN/8wBKnEqhnwnffyvQiUG+C2N4K?=
 =?us-ascii?Q?40cGgK0hz1GAHIlBJkYsV8vSNNLrAKGOqJrSfFiYjpfJV3BBxzdlYA2H02sX?=
 =?us-ascii?Q?Y6oITxrcUUlP5N9GdkSM68Lc9m8at/7PIGnpt9KWQ89MvytExXyCUeVi5i51?=
 =?us-ascii?Q?vfULVM2XucnREykls+u6xs0/MpkJM9FnNQZhsMGQpxdaxM8FmIYJmhzymPs2?=
 =?us-ascii?Q?+j8MyHbj/Whh1RyzMdevRPcX8AegceVpAZAh5cNJ0rpw0L/Jhod4WIlGKzRL?=
 =?us-ascii?Q?rmk+wibQFr0byl9W0HHj+HUbs6Fib2we1dOpcMSNvf2r1XafKE8S30OK2UnS?=
 =?us-ascii?Q?yu5YmIEaKz1VUHjekedjhVIVo4yXIkTH2hyE1Jj3+AH36rbzOEhB2TKLo85a?=
 =?us-ascii?Q?HDeDISJkWCC+Co0y2e7aNaHuhQ09DH5LTr/HMo4vM3BqoJ53XkVoFEI9jndG?=
 =?us-ascii?Q?7qT9p0AmTggYV1oj7+D1LpkvxAPiUzUkO4p7wQRLElYlvMImAp1xDCWfaL6R?=
 =?us-ascii?Q?E8i0F0N0mVoVeEaCn6A861U87XN5K374jBYB+/IJwbbWjfWD8DkcIyrCL19H?=
 =?us-ascii?Q?RTfJkd0vKoXVItQBCB21bnZ6r4uS6x7oFir7z8ziBFKDXRD99Z3Ev/VpEXCT?=
 =?us-ascii?Q?1jfnIGwTNycnff2NZ5bwqbvDmtP9n88Zh89GYYVO/fEAPGPnPlBUIsvNlB5v?=
 =?us-ascii?Q?6FpHhSArO6l0KjsepS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a52f32-1bb6-4c95-ed09-08dbf4e174ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 15:55:36.9156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/G9nOow8OyVzwFsb6i7JozfCCX35TYhQiud29Hzz1M9Wrmbekrx7hYj0jGF36h495pGUqwOXOSpxVAyHF54hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Monday, December 4, 2023 3:52 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version
> and metrics table
>
> [Public]
>
> Hi Alex,
>
> Sorry for the late reply. Only smu14 used this gpu_metrics_v3_0 struct. A=
nd
> the patch has upstream. As far as l know, umr used gpu_metrics_v3_0 and I
> will submit a patch to umr.
> Does this struct need to be back compatible currently? If yes, I will rev=
ert this
> patch and add a new gpu_metrics_v3_1.

Ok.  If we don't yet have a released kernel with v3_0 support we should be =
fine.  I'll just include the updates in 6.7.

Alex

>
> Best Regards,
> Li
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, November 28, 2023 4:47 AM
> To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version
> and metrics table
>
> [Public]
>
> > -----Original Message-----
> > From: Ma, Li <Li.Ma@amd.com>
> > Sent: Thursday, November 23, 2023 5:07 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu,
> > Lang <Lang.Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
> > Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version
> > and metrics table
> >
> > Increment the driver if version and add new mems to the mertics table.
> >
> > Signed-off-by: Li Ma <li.ma@amd.com>
> > ---
> >  .../gpu/drm/amd/include/kgd_pp_interface.h    | 17 ++++
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 +++
> >  .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 77 +++++++++++--------
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++-
> >  4 files changed, 115 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > index 8ebba87f4289..eaea1c65e526 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > @@ -1086,6 +1086,10 @@ struct gpu_metrics_v3_0 {
> >       uint16_t                        average_dram_reads;
> >       /* time filtered DRAM write bandwidth [MB/sec] */
> >       uint16_t                        average_dram_writes;
> > +     /* time filtered IPU read bandwidth [MB/sec] */
> > +     uint16_t                        average_ipu_reads;
> > +     /* time filtered IPU write bandwidth [MB/sec] */
> > +     uint16_t                        average_ipu_writes;
> >
> >       /* Driver attached timestamp (in ns) */
> >       uint64_t                        system_clock_counter;
> > @@ -1105,6 +1109,8 @@ struct gpu_metrics_v3_0 {
> >       uint32_t                        average_all_core_power;
> >       /* calculated core power [mW] */
> >       uint16_t                        average_core_power[16];
> > +     /* time filtered total system power [mW] */
> > +     uint16_t                        average_sys_power;
> >       /* maximum IRM defined STAPM power limit [mW] */
> >       uint16_t                        stapm_power_limit;
> >       /* time filtered STAPM power limit [mW] */ @@ -1117,6 +1123,8 @@
> > struct gpu_metrics_v3_0 {
> >       uint16_t                        average_ipuclk_frequency;
> >       uint16_t                        average_fclk_frequency;
> >       uint16_t                        average_vclk_frequency;
> > +     uint16_t                        average_uclk_frequency;
> > +     uint16_t                        average_mpipu_frequency;
> >
> >       /* Current clocks */
> >       /* target core frequency [MHz] */ @@ -1126,6 +1134,15 @@ struct
> > gpu_metrics_v3_0 {
> >       /* GFXCLK frequency limit enforced on GFX [MHz] */
> >       uint16_t                        current_gfx_maxfreq;
> >
> > +     /* Throttle Residency (ASIC dependent) */
> > +     uint32_t throttle_residency_prochot;
> > +     uint32_t throttle_residency_spl;
> > +     uint32_t throttle_residency_fppt;
> > +     uint32_t throttle_residency_sppt;
> > +     uint32_t throttle_residency_thm_core;
> > +     uint32_t throttle_residency_thm_gfx;
> > +     uint32_t throttle_residency_thm_soc;
> > +
> >       /* Metrics table alpha filter time constant [us] */
> >       uint32_t                        time_filter_alphavalue;
> >  };
>
> Is anything else besides smu14 using v3 of this struct?  If so, we can't =
change
> the layout otherwise it will break existing tools.  If so, bump the versi=
on minor
> and append the new items to the end.
>
> Alex
>
>
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index c125253df20b..c2265e027ca8 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -1418,6 +1418,16 @@ typedef enum {
> >       METRICS_PCIE_WIDTH,
> >       METRICS_CURR_FANPWM,
> >       METRICS_CURR_SOCKETPOWER,
> > +     METRICS_AVERAGE_VPECLK,
> > +     METRICS_AVERAGE_IPUCLK,
> > +     METRICS_AVERAGE_MPIPUCLK,
> > +     METRICS_THROTTLER_RESIDENCY_PROCHOT,
> > +     METRICS_THROTTLER_RESIDENCY_SPL,
> > +     METRICS_THROTTLER_RESIDENCY_FPPT,
> > +     METRICS_THROTTLER_RESIDENCY_SPPT,
> > +     METRICS_THROTTLER_RESIDENCY_THM_CORE,
> > +     METRICS_THROTTLER_RESIDENCY_THM_GFX,
> > +     METRICS_THROTTLER_RESIDENCY_THM_SOC,
> >  } MetricsMember_t;
> >
> >  enum smu_cmn2asic_mapping_type {
> > diff --git
> >
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> > .h
> >
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> > .h
> > index 22f88842a7fd..8f42771e1f0a 100644
> > ---
> >
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> > .h
> > +++
> >
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> > .h
> > @@ -27,7 +27,7 @@
> >  // *** IMPORTANT ***
> >  // SMU TEAM: Always increment the interface version if  // any
> > structure is changed in this file -#define PMFW_DRIVER_IF_VERSION 6
> > +#define PMFW_DRIVER_IF_VERSION 7
> >
> >  typedef struct {
> >    int32_t value;
> > @@ -150,37 +150,50 @@ typedef struct {  } DpmClocks_t;
> >
> >  typedef struct {
> > -  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
> > -  uint16_t CorePower[16];            //CAC calculated core power [mW]
> > -  uint16_t CoreTemperature[16];      //TSEN measured core temperature
> > [centi-C]
> > -  uint16_t GfxTemperature;           //TSEN measured GFX temperature [=
centi-
> C]
> > -  uint16_t SocTemperature;           //TSEN measured SOC temperature [=
centi-
> C]
> > -  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power
> limit
> > [mW]
> > -  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit=
 [mW]
> > -  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced
> > on classic cores [MHz]
> > -  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequency limit
> > enforced on GFX [MHz]
> > -  uint16_t SkinTemp;                 //Maximum skin temperature report=
ed by
> APU
> > and HS2 chassis sensors [centi-C]
> > -  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK fre=
quency
> > [MHz]
> > -  uint16_t FclkFrequency;            //Time filtered target FCLK frequ=
ency [MHz]
> > -  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100=
]
> > -  uint16_t SocclkFrequency;          //Time filtered target SOCCLK fre=
quency
> > [MHz]
> > -  uint16_t VclkFrequency;            //Time filtered target VCLK frequ=
ency [MHz]
> > -  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100=
]
> > -  uint16_t VpeclkFrequency;          //Time filtered target VPECLK fre=
quency
> > [MHz]
> > -  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK fre=
quency
> > [MHz]
> > -  uint16_t IpuBusy[8];               //Time filtered IPU per-column bu=
sy % [0-
> 100]
> > -  uint16_t DRAMReads;                //Time filtered DRAM read bandwid=
th
> > [MB/sec]
> > -  uint16_t DRAMWrites;               //Time filtered DRAM write bandwi=
dth
> > [MB/sec]
> > -  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 resid=
ency %
> > [0-100]
> > -  uint16_t IpuPower;                 //Time filtered IPU power [mW]
> > -  uint32_t ApuPower;                 //Time filtered APU power [mW]
> > -  uint32_t GfxPower;                 //Time filtered GFX power [mW]
> > -  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
> > -  uint32_t SocketPower;              //Time filtered power used for PP=
T/STAPM
> > [APU+dGPU] [mW]
> > -  uint32_t AllCorePower;             //Time filtered sum of core power=
 across all
> > cores in the socket [mW]
> > -  uint32_t FilterAlphaValue;         //Metrics table alpha filter time=
 constant
> [us]
> > -  uint32_t MetricsCounter;           //Counter that is incremented on =
every
> > metrics table update [PM_TIMER cycles]
> > -  uint32_t spare[16];
> > +  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
> > +  uint16_t CorePower[16];              //CAC calculated core power [mW=
]
> > +  uint16_t CoreTemperature[16];        //TSEN measured core temperatur=
e
> > [centi-C]
> > +  uint16_t GfxTemperature;             //TSEN measured GFX temperature
> [centi-
> > C]
> > +  uint16_t SocTemperature;             //TSEN measured SOC temperature
> [centi-
> > C]
> > +  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM pow=
er
> > limit [mW]
> > +  uint16_t StapmCurrentLimit;          //Time filtered STAPM power lim=
it [mW]
> > +  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced=
 on
> > classic cores [MHz]
> > +  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforc=
ed
> on
> > GFX [MHz]
> > +  uint16_t SkinTemp;                   //Maximum skin temperature repo=
rted by
> APU
> > and HS2 chassis sensors [centi-C]
> > +  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK f=
requency
> > [MHz]
> > +  uint16_t FclkFrequency;              //Time filtered target FCLK fre=
quency
> [MHz]
> > +  uint16_t GfxActivity;                //Time filtered GFX busy % [0-1=
00]
> > +  uint16_t SocclkFrequency;            //Time filtered target SOCCLK f=
requency
> > [MHz]
> > +  uint16_t VclkFrequency;              //Time filtered target VCLK fre=
quency
> [MHz]
> > +  uint16_t VcnActivity;                //Time filtered VCN busy % [0-1=
00]
> > +  uint16_t VpeclkFrequency;            //Time filtered target VPECLK f=
requency
> > [MHz]
> > +  uint16_t IpuclkFrequency;            //Time filtered target IPUCLK f=
requency
> > [MHz]
> > +  uint16_t IpuBusy[8];                 //Time filtered IPU per-column =
busy % [0-
> > 100]
> > +  uint16_t DRAMReads;                  //Time filtered DRAM read bandw=
idth
> > [MB/sec]
> > +  uint16_t DRAMWrites;                 //Time filtered DRAM write band=
width
> > [MB/sec]
> > +  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 res=
idency %
> > [0-100]
> > +  uint16_t IpuPower;                   //Time filtered IPU power [mW]
> > +  uint32_t ApuPower;                   //Time filtered APU power [mW]
> > +  uint32_t GfxPower;                   //Time filtered GFX power [mW]
> > +  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
> > +  uint32_t SocketPower;                //Time filtered power used for =
PPT/STAPM
> > [APU+dGPU] [mW]
> > +  uint32_t AllCorePower;               //Time filtered sum of core pow=
er across all
> > cores in the socket [mW]
> > +  uint32_t FilterAlphaValue;           //Metrics table alpha filter ti=
me constant
> > [us]
> > +  uint32_t MetricsCounter;             //Counter that is incremented o=
n every
> > metrics table update [PM_TIMER cycles]
> > +  uint16_t MemclkFrequency;            //Time filtered target MEMCLK
> frequency
> > [MHz]
> > +  uint16_t MpipuclkFrequency;          //Time filtered target MPIPUCLK
> > frequency [MHz]
> > +  uint16_t IpuReads;                   //Time filtered IPU read bandwi=
dth [MB/sec]
> > +  uint16_t IpuWrites;                  //Time filtered IPU write bandw=
idth [MB/sec]
> > +  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented
> > + on
> > every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
> > +  uint32_t ThrottleResidency_SPL;      //Counter that is incremented o=
n
> every
> > metrics table update when SPL was engaged [PM_TIMER cycles]
> > +  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented o=
n
> every
> > metrics table update when fast PPT was engaged [PM_TIMER cycles]
> > +  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented o=
n
> every
> > metrics table update when slow PPT was engaged [PM_TIMER cycles]
> > +  uint32_t ThrottleResidency_THM_CORE; //Counter that is incremented
> > + on every metrics table update when CORE thermal throttling was
> > + engaged [PM_TIMER cycles]  uint32_t ThrottleResidency_THM_GFX;
> > + //Counter that
> > is incremented on every metrics table update when GFX thermal
> > throttling was engaged [PM_TIMER cycles]  uint32_t
> > ThrottleResidency_THM_SOC; //Counter that is incremented on every
> > metrics table update when SOC thermal throttling was engaged [PM_TIMER
> > cycles]
> > +  uint16_t Psys;                       //Time filtered Psys power [mW]
> > +  uint16_t spare1;
> > +  uint32_t spare[6];
> >  } SmuMetrics_t;
> >
> >  //ISP tile definitions
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > index 03b38c3a9968..94ccdbfd7090 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > @@ -246,11 +246,20 @@ static int
> > smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
> >               *value =3D 0;
> >               break;
> >       case METRICS_AVERAGE_UCLK:
> > -             *value =3D 0;
> > +             *value =3D metrics->MemclkFrequency;
> >               break;
> >       case METRICS_AVERAGE_FCLK:
> >               *value =3D metrics->FclkFrequency;
> >               break;
> > +     case METRICS_AVERAGE_VPECLK:
> > +             *value =3D metrics->VpeclkFrequency;
> > +             break;
> > +     case METRICS_AVERAGE_IPUCLK:
> > +             *value =3D metrics->IpuclkFrequency;
> > +             break;
> > +     case METRICS_AVERAGE_MPIPUCLK:
> > +             *value =3D metrics->MpipuclkFrequency;
> > +             break;
> >       case METRICS_AVERAGE_GFXACTIVITY:
> >               *value =3D metrics->GfxActivity / 100;
> >               break;
> > @@ -270,8 +279,26 @@ static int
> > smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
> >               *value =3D metrics->SocTemperature / 100 *
> >               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >               break;
> > -     case METRICS_THROTTLER_STATUS:
> > -             *value =3D 0;
> > +     case METRICS_THROTTLER_RESIDENCY_PROCHOT:
> > +             *value =3D metrics->ThrottleResidency_PROCHOT;
> > +             break;
> > +     case METRICS_THROTTLER_RESIDENCY_SPL:
> > +             *value =3D metrics->ThrottleResidency_SPL;
> > +             break;
> > +     case METRICS_THROTTLER_RESIDENCY_FPPT:
> > +             *value =3D metrics->ThrottleResidency_FPPT;
> > +             break;
> > +     case METRICS_THROTTLER_RESIDENCY_SPPT:
> > +             *value =3D metrics->ThrottleResidency_SPPT;
> > +             break;
> > +     case METRICS_THROTTLER_RESIDENCY_THM_CORE:
> > +             *value =3D metrics->ThrottleResidency_THM_CORE;
> > +             break;
> > +     case METRICS_THROTTLER_RESIDENCY_THM_GFX:
> > +             *value =3D metrics->ThrottleResidency_THM_GFX;
> > +             break;
> > +     case METRICS_THROTTLER_RESIDENCY_THM_SOC:
> > +             *value =3D metrics->ThrottleResidency_THM_SOC;
> >               break;
> >       case METRICS_VOLTAGE_VDDGFX:
> >               *value =3D 0;
> > @@ -498,6 +525,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> > smu_context *smu,
> >               sizeof(uint16_t) * 16);
> >       gpu_metrics->average_dram_reads =3D metrics.DRAMReads;
> >       gpu_metrics->average_dram_writes =3D metrics.DRAMWrites;
> > +     gpu_metrics->average_ipu_reads =3D metrics.IpuReads;
> > +     gpu_metrics->average_ipu_writes =3D metrics.IpuWrites;
> >
> >       gpu_metrics->average_socket_power =3D metrics.SocketPower;
> >       gpu_metrics->average_ipu_power =3D metrics.IpuPower; @@ -505,6
> > +534,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> > +smu_context
> > *smu,
> >       gpu_metrics->average_gfx_power =3D metrics.GfxPower;
> >       gpu_metrics->average_dgpu_power =3D metrics.dGpuPower;
> >       gpu_metrics->average_all_core_power =3D metrics.AllCorePower;
> > +     gpu_metrics->average_sys_power =3D metrics.Psys;
> >       memcpy(&gpu_metrics->average_core_power[0],
> >               &metrics.CorePower[0],
> >               sizeof(uint16_t) * 16);
> > @@ -515,6 +545,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> > smu_context *smu,
> >       gpu_metrics->average_fclk_frequency =3D metrics.FclkFrequency;
> >       gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
> >       gpu_metrics->average_ipuclk_frequency =3D metrics.IpuclkFrequency=
;
> > +     gpu_metrics->average_uclk_frequency =3D metrics.MemclkFrequency;
> > +     gpu_metrics->average_mpipu_frequency =3D
> > metrics.MpipuclkFrequency;
> >
> >       memcpy(&gpu_metrics->current_coreclk[0],
> >               &metrics.CoreFrequency[0], @@ -522,6 +554,14 @@ static
> > ssize_t smu_v14_0_0_get_gpu_metrics(struct
> > smu_context *smu,
> >       gpu_metrics->current_core_maxfreq =3D
> > metrics.InfrastructureCpuMaxFreq;
> >       gpu_metrics->current_gfx_maxfreq =3D
> > metrics.InfrastructureGfxMaxFreq;
> >
> > +     gpu_metrics->throttle_residency_prochot =3D
> > metrics.ThrottleResidency_PROCHOT;
> > +     gpu_metrics->throttle_residency_spl =3D metrics.ThrottleResidency=
_SPL;
> > +     gpu_metrics->throttle_residency_fppt =3D
> > metrics.ThrottleResidency_FPPT;
> > +     gpu_metrics->throttle_residency_sppt =3D
> > metrics.ThrottleResidency_SPPT;
> > +     gpu_metrics->throttle_residency_thm_core =3D
> > metrics.ThrottleResidency_THM_CORE;
> > +     gpu_metrics->throttle_residency_thm_gfx =3D
> > metrics.ThrottleResidency_THM_GFX;
> > +     gpu_metrics->throttle_residency_thm_soc =3D
> > +metrics.ThrottleResidency_THM_SOC;
> > +
> >       gpu_metrics->time_filter_alphavalue =3D metrics.FilterAlphaValue;
> >       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
> >
> > --
> > 2.25.1
>
>

