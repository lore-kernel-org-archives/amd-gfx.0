Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA8BC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 20:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEC210E148;
	Mon, 27 Nov 2023 20:47:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C64110E14E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 20:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McyywUyBAdpOWiaWk/jjZ7lw6kRM/dNdF/VxOtvO6ct0qIPje8tcD8xvWLZSpuUsDojBMv+DbvAImXCCye9o2lPvcyHOd/HXYR+8evdAp3xJTOGUmeamAljg946hqenz6ajngtROd/L+uHQzG8/25uMxt8Dqxxk314eByFEcIqaRk9qqXwVKWwIN08NmLk0qaSv2ZNWi61/n+oIjnv4oXKiKsLnP4gJku34zhC2W17gxLGi+y2doIfPXpyksPfZjIGIB9ySHP7zGr4i3zEy9r0XPrzyaxFG0nUjR90KmmETjtm4fu/JH89xuwwVSRJE/31rz2GR9bCmpcDnV0VqVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMf3cP5gR369ssXdrkAn7szJ2ig6VBkTzBxRa/tvbBM=;
 b=K9rnfu0Dealkp12dJtrxnKh3j5NdjESLYQoy3/G6YGVMXol1xK6JcvId6iB8ETvKS10IC6btZxJmnHohXSwdmcNPHKwhPSrGLtR9nIEvrC3byJnrsjcRxaUVbGwfzgoTXr5vdWLT1g4A6YrVjldk24gFAYq1jYJSm8kLclp1QndxeKFaE+wkcya5w6wzDpnDE0rGsIvLlDx5qFnKBNQWuW0KcJYqcEvgt5XqmhvJX9U8RTpJhG8nqdBKRLsPTbN+JHeTOnOY3bJOT+DSt/QrJNqfGYq0SRr3QaoGrJ2YPJTEotKoV3eBzhOOD9WWE63Xj/9ELoz4eYyr/4YETil35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMf3cP5gR369ssXdrkAn7szJ2ig6VBkTzBxRa/tvbBM=;
 b=nqngftrYTqmaGQO59sAZ7C7FIwPgfp9YjyY0387FQWzpNto/2l6YMu4fI83v/rn3gKIf+flA5bNTrbiCTPi/GYfDpFfAKxXw0yBgMYoo1C2q8SgqlVO3aMRi7NuCLyETpNh/YOC7mSeCyLXVU228JnO5pgZhXJWANi+D1XPlT6A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 20:47:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 20:47:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Topic: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Index: AQHaHfTM+o7Q9tKoqUC859uE3ReQ9rCOqIeQ
Date: Mon, 27 Nov 2023 20:47:06 +0000
Message-ID: <BL1PR12MB5144909C7C9B11362D4F23BEF7BDA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231123100645.235821-1-li.ma@amd.com>
In-Reply-To: <20231123100645.235821-1-li.ma@amd.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB7855:EE_
x-ms-office365-filtering-correlation-id: 9737261c-3548-4f90-c073-08dbef8a04d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2kpIRt7vgoFIhxTutV2HE3d/K7m0C8QODveXrSW2Q9UqIFZb/r4pgjHo+Ke7tFM28j/R6dKOY/+RTtISyfEqIW4gtV7FGSfuuk0Oi7HgodsWR57zeA1AyA5Hw727LVDnHDQeQegovZElpULd7lc948Gz/f6oNQF0QoPxwS4Fw7XV5xvhGFQTMc1y/41Sx65wNGm1XPoFPB0YIk4U1ZllrnBgDaPMC43MwC+07SDaSygVO70VyQRBz8FKS+RQo8Zy9xvcOBS868MTG62EshN4+t/ILUQvy99b8En3NmaEvjQFS1YfA7Mft+pKzs3Vr0NT6lT8dbaEdLP6f6iCj66bG1106M0dT/holu1Mjmgj2eC8KmgVJLOBJPQ4ougV8lbPhpjuyoShmQGNZqCKScBWvuUKi+holGDht2ZzgZOEyzlxuUpz/kMqBEBoylZSQ5bfnmsKpKGJXRwK9wr4IECzKnqOIf0bV4XuGeyzxk5FXqlaIwxB1s4pDwBPbQ/dfnmL8I+uSSDPfuhXubWiJauu+WUjTLYaPvJfyy5EGoRIfdgMemNVST6srNRd9Rwx5e+zd0wwyj4SYEW2bDQPNc4j8s+JfARkPrlru0tRb0k1BNYB/f6JuztdMwb+GMpvseC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(15650500001)(2906002)(30864003)(52536014)(41300700001)(76116006)(66946007)(55016003)(110136005)(9686003)(53546011)(64756008)(8676002)(54906003)(316002)(8936002)(66446008)(66476007)(66556008)(4326008)(6506007)(71200400001)(7696005)(478600001)(5660300002)(26005)(83380400001)(38100700002)(86362001)(122000001)(38070700009)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oB/N7yW+Xf2qmBqcqzfsFJrqy4yXfQspLFkMU+/AWbcSPhiHQhOYaTGb5vrZ?=
 =?us-ascii?Q?wScrv6cve0Tn4uApzrQZopugl2xRNGB1+qnpMnOVd3QrIjILNdqPdDied5ef?=
 =?us-ascii?Q?4SDRzqy+NcT9eE4DqcZK6p1nyR4VXmfMqXTHlRPG1lKEFPzKiBcIhER4fRVx?=
 =?us-ascii?Q?My7m/w9JTT5gOZ3Z6SxHEk12PmPROgutYPt4QqrnvWu77i3/ikcoYxkC/qr9?=
 =?us-ascii?Q?mLudhHF/gJg11miLPz8x4KjVj0jkuzloRu6LMlDeil8l3Vv4qDYKjdd9036P?=
 =?us-ascii?Q?XWKyJpeeIVxKrpCAnS43FkMvhzrOAbL3eSrgHgX+nxuwB0uumfBUSnvmFTtm?=
 =?us-ascii?Q?Eq5QzjtZ5BpQ/qm82br4/a27oFzKeHitIftoBqAIFRWPehtb9Trm0HVLKfCz?=
 =?us-ascii?Q?1NTEarr4CTXdV7fcmUynre0kEA1ZcDh93ThHkpl97kWAnzK17xTfbK4Wb/mz?=
 =?us-ascii?Q?mVzUygVeXpN4lffihP/NR8yahILLekCubgBgNCtb8tFSR2ZhnyIHLOkrEzdV?=
 =?us-ascii?Q?oTLUm5l/PqlsPt8w5XNMbP0z6mnZCu1IjC+swEOW906R0WEN3yUSV84F+0BP?=
 =?us-ascii?Q?dxnFhYMplNp7aX4pl05MnmRCcyT8Drdhqnd9Xhid6WjiNGZ//JP7WH3FpSkr?=
 =?us-ascii?Q?Y1MIvwd/OMdEGePazjZCv7gUejALcaWSlP2AzTCE1GgHF+pbrieOkSM3oHAu?=
 =?us-ascii?Q?kCvdIrLHGOZIf/tTiVusAMnX11GDCjWeN6Suz30DUl9Ejxmz24ieAxQem/s9?=
 =?us-ascii?Q?ZD7eMLokGZO3YuCiS+CFx7UR7+m0ZChpMoWWFfbHwtn8rYp8dBD2JoOAy31c?=
 =?us-ascii?Q?ESGdLlSHbWKtC1RhT2PBPWJTmPF9/idDLBLXcjNK1/i6t9b3dC9/Qs5PNi07?=
 =?us-ascii?Q?8i9XnPvXXiKNz27QwkmWsnzEJnVVjJWj4LJhGxGQC8ybn9TcYNOC213R2GEM?=
 =?us-ascii?Q?SEB8UtesxJbsiZLN2oZjBTB1Qf/g5ea+nlwyeHOVh2vQiFdEdMcLhyfHY9Io?=
 =?us-ascii?Q?8kBxkP7Ckcnt9/MIVJtDr1jSv30qmh7s0RvxWcnljth7Sa3nJ4cbAbjeYL6h?=
 =?us-ascii?Q?Ox46sWlAYMkaU34jwuz1tRpo8DK8FJYx0FilqzryLr2CLuQB6zzKMrluc1qs?=
 =?us-ascii?Q?Phps/buukL9tjhSVP9Bm0AwDSvcZF+MW7S7qb8IyrwYFDXTKM4aDUEIHD1xK?=
 =?us-ascii?Q?dtIIUoDgQY2ps0msF/nO3b1lt83jOs3kBRq2j/zzzvCNks7ZQOHPp7g/NFfW?=
 =?us-ascii?Q?MOVtG3I/VrwfVuwxawSY7f8QvzsO9aFpxHUkLBFnKhIX7qFZ/oPDxyPsSymT?=
 =?us-ascii?Q?MpL7iMwPtLsQQHeff9V5m7vYU38rQbK0n6KKXg6dR6PbdlR8/35FeH4F9nM9?=
 =?us-ascii?Q?fBaKIIiJfK+nnY/s/mYytsHv4TNxDsz6n5cvG5h3F2/pafI5g7uXCa6dC99N?=
 =?us-ascii?Q?Dn98WiWGzgfcf3DtIy/amMLfMQArcMgtZfaCRCpPKb3sC8nTwl9RHVAuEoRy?=
 =?us-ascii?Q?0+XlnVjoQpa6DKT8CECKC1HzYl0mFj7RgyL2cbg3nOuR+gm1qwxKFC7/qDB8?=
 =?us-ascii?Q?IC4s+XtaTanTDu6ok74=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9737261c-3548-4f90-c073-08dbef8a04d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 20:47:06.8339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2O6YdtL3QmMrjmVjW0/LE3hjXE4n8xqkssbyxSDgjq23Vj0sYZ6lviJib3IHquSTwJeUGSLBzgH9cyWOAZbhew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Thursday, November 23, 2023 5:07 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu,
> Lang <Lang.Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
> Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
> metrics table
>
> Increment the driver if version and add new mems to the mertics table.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    | 17 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 +++
>  .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 77 +++++++++++--------
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++-
>  4 files changed, 115 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 8ebba87f4289..eaea1c65e526 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -1086,6 +1086,10 @@ struct gpu_metrics_v3_0 {
>       uint16_t                        average_dram_reads;
>       /* time filtered DRAM write bandwidth [MB/sec] */
>       uint16_t                        average_dram_writes;
> +     /* time filtered IPU read bandwidth [MB/sec] */
> +     uint16_t                        average_ipu_reads;
> +     /* time filtered IPU write bandwidth [MB/sec] */
> +     uint16_t                        average_ipu_writes;
>
>       /* Driver attached timestamp (in ns) */
>       uint64_t                        system_clock_counter;
> @@ -1105,6 +1109,8 @@ struct gpu_metrics_v3_0 {
>       uint32_t                        average_all_core_power;
>       /* calculated core power [mW] */
>       uint16_t                        average_core_power[16];
> +     /* time filtered total system power [mW] */
> +     uint16_t                        average_sys_power;
>       /* maximum IRM defined STAPM power limit [mW] */
>       uint16_t                        stapm_power_limit;
>       /* time filtered STAPM power limit [mW] */ @@ -1117,6 +1123,8
> @@ struct gpu_metrics_v3_0 {
>       uint16_t                        average_ipuclk_frequency;
>       uint16_t                        average_fclk_frequency;
>       uint16_t                        average_vclk_frequency;
> +     uint16_t                        average_uclk_frequency;
> +     uint16_t                        average_mpipu_frequency;
>
>       /* Current clocks */
>       /* target core frequency [MHz] */
> @@ -1126,6 +1134,15 @@ struct gpu_metrics_v3_0 {
>       /* GFXCLK frequency limit enforced on GFX [MHz] */
>       uint16_t                        current_gfx_maxfreq;
>
> +     /* Throttle Residency (ASIC dependent) */
> +     uint32_t throttle_residency_prochot;
> +     uint32_t throttle_residency_spl;
> +     uint32_t throttle_residency_fppt;
> +     uint32_t throttle_residency_sppt;
> +     uint32_t throttle_residency_thm_core;
> +     uint32_t throttle_residency_thm_gfx;
> +     uint32_t throttle_residency_thm_soc;
> +
>       /* Metrics table alpha filter time constant [us] */
>       uint32_t                        time_filter_alphavalue;
>  };

Is anything else besides smu14 using v3 of this struct?  If so, we can't ch=
ange the layout otherwise it will break existing tools.  If so, bump the ve=
rsion minor and append the new items to the end.

Alex


> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index c125253df20b..c2265e027ca8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1418,6 +1418,16 @@ typedef enum {
>       METRICS_PCIE_WIDTH,
>       METRICS_CURR_FANPWM,
>       METRICS_CURR_SOCKETPOWER,
> +     METRICS_AVERAGE_VPECLK,
> +     METRICS_AVERAGE_IPUCLK,
> +     METRICS_AVERAGE_MPIPUCLK,
> +     METRICS_THROTTLER_RESIDENCY_PROCHOT,
> +     METRICS_THROTTLER_RESIDENCY_SPL,
> +     METRICS_THROTTLER_RESIDENCY_FPPT,
> +     METRICS_THROTTLER_RESIDENCY_SPPT,
> +     METRICS_THROTTLER_RESIDENCY_THM_CORE,
> +     METRICS_THROTTLER_RESIDENCY_THM_GFX,
> +     METRICS_THROTTLER_RESIDENCY_THM_SOC,
>  } MetricsMember_t;
>
>  enum smu_cmn2asic_mapping_type {
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> index 22f88842a7fd..8f42771e1f0a 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> @@ -27,7 +27,7 @@
>  // *** IMPORTANT ***
>  // SMU TEAM: Always increment the interface version if  // any structure=
 is
> changed in this file -#define PMFW_DRIVER_IF_VERSION 6
> +#define PMFW_DRIVER_IF_VERSION 7
>
>  typedef struct {
>    int32_t value;
> @@ -150,37 +150,50 @@ typedef struct {
>  } DpmClocks_t;
>
>  typedef struct {
> -  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
> -  uint16_t CorePower[16];            //CAC calculated core power [mW]
> -  uint16_t CoreTemperature[16];      //TSEN measured core temperature
> [centi-C]
> -  uint16_t GfxTemperature;           //TSEN measured GFX temperature [ce=
nti-C]
> -  uint16_t SocTemperature;           //TSEN measured SOC temperature [ce=
nti-C]
> -  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power l=
imit
> [mW]
> -  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit [=
mW]
> -  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced on
> classic cores [MHz]
> -  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequency limit enforced o=
n
> GFX [MHz]
> -  uint16_t SkinTemp;                 //Maximum skin temperature reported=
 by APU
> and HS2 chassis sensors [centi-C]
> -  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK frequ=
ency
> [MHz]
> -  uint16_t FclkFrequency;            //Time filtered target FCLK frequen=
cy [MHz]
> -  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100]
> -  uint16_t SocclkFrequency;          //Time filtered target SOCCLK frequ=
ency
> [MHz]
> -  uint16_t VclkFrequency;            //Time filtered target VCLK frequen=
cy [MHz]
> -  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100]
> -  uint16_t VpeclkFrequency;          //Time filtered target VPECLK frequ=
ency
> [MHz]
> -  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK frequ=
ency
> [MHz]
> -  uint16_t IpuBusy[8];               //Time filtered IPU per-column busy=
 % [0-100]
> -  uint16_t DRAMReads;                //Time filtered DRAM read bandwidth
> [MB/sec]
> -  uint16_t DRAMWrites;               //Time filtered DRAM write bandwidt=
h
> [MB/sec]
> -  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 residen=
cy %
> [0-100]
> -  uint16_t IpuPower;                 //Time filtered IPU power [mW]
> -  uint32_t ApuPower;                 //Time filtered APU power [mW]
> -  uint32_t GfxPower;                 //Time filtered GFX power [mW]
> -  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
> -  uint32_t SocketPower;              //Time filtered power used for PPT/=
STAPM
> [APU+dGPU] [mW]
> -  uint32_t AllCorePower;             //Time filtered sum of core power a=
cross all
> cores in the socket [mW]
> -  uint32_t FilterAlphaValue;         //Metrics table alpha filter time c=
onstant [us]
> -  uint32_t MetricsCounter;           //Counter that is incremented on ev=
ery
> metrics table update [PM_TIMER cycles]
> -  uint32_t spare[16];
> +  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
> +  uint16_t CorePower[16];              //CAC calculated core power [mW]
> +  uint16_t CoreTemperature[16];        //TSEN measured core temperature
> [centi-C]
> +  uint16_t GfxTemperature;             //TSEN measured GFX temperature [=
centi-
> C]
> +  uint16_t SocTemperature;             //TSEN measured SOC temperature [=
centi-
> C]
> +  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power
> limit [mW]
> +  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit=
 [mW]
> +  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced o=
n
> classic cores [MHz]
> +  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced=
 on
> GFX [MHz]
> +  uint16_t SkinTemp;                   //Maximum skin temperature report=
ed by APU
> and HS2 chassis sensors [centi-C]
> +  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK fre=
quency
> [MHz]
> +  uint16_t FclkFrequency;              //Time filtered target FCLK frequ=
ency [MHz]
> +  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100=
]
> +  uint16_t SocclkFrequency;            //Time filtered target SOCCLK fre=
quency
> [MHz]
> +  uint16_t VclkFrequency;              //Time filtered target VCLK frequ=
ency [MHz]
> +  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100=
]
> +  uint16_t VpeclkFrequency;            //Time filtered target VPECLK fre=
quency
> [MHz]
> +  uint16_t IpuclkFrequency;            //Time filtered target IPUCLK fre=
quency
> [MHz]
> +  uint16_t IpuBusy[8];                 //Time filtered IPU per-column bu=
sy % [0-
> 100]
> +  uint16_t DRAMReads;                  //Time filtered DRAM read bandwid=
th
> [MB/sec]
> +  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwi=
dth
> [MB/sec]
> +  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 resid=
ency %
> [0-100]
> +  uint16_t IpuPower;                   //Time filtered IPU power [mW]
> +  uint32_t ApuPower;                   //Time filtered APU power [mW]
> +  uint32_t GfxPower;                   //Time filtered GFX power [mW]
> +  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
> +  uint32_t SocketPower;                //Time filtered power used for PP=
T/STAPM
> [APU+dGPU] [mW]
> +  uint32_t AllCorePower;               //Time filtered sum of core power=
 across all
> cores in the socket [mW]
> +  uint32_t FilterAlphaValue;           //Metrics table alpha filter time=
 constant
> [us]
> +  uint32_t MetricsCounter;             //Counter that is incremented on =
every
> metrics table update [PM_TIMER cycles]
> +  uint16_t MemclkFrequency;            //Time filtered target MEMCLK fre=
quency
> [MHz]
> +  uint16_t MpipuclkFrequency;          //Time filtered target MPIPUCLK
> frequency [MHz]
> +  uint16_t IpuReads;                   //Time filtered IPU read bandwidt=
h [MB/sec]
> +  uint16_t IpuWrites;                  //Time filtered IPU write bandwid=
th [MB/sec]
> +  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented on
> every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on =
every
> metrics table update when SPL was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on =
every
> metrics table update when fast PPT was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on =
every
> metrics table update when slow PPT was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_THM_CORE; //Counter that is incremented on
> + every metrics table update when CORE thermal throttling was engaged
> + [PM_TIMER cycles]  uint32_t ThrottleResidency_THM_GFX;  //Counter that
> is incremented on every metrics table update when GFX thermal throttling =
was
> engaged [PM_TIMER cycles]  uint32_t ThrottleResidency_THM_SOC;
> //Counter that is incremented on every metrics table update when SOC
> thermal throttling was engaged [PM_TIMER cycles]
> +  uint16_t Psys;                       //Time filtered Psys power [mW]
> +  uint16_t spare1;
> +  uint32_t spare[6];
>  } SmuMetrics_t;
>
>  //ISP tile definitions
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 03b38c3a9968..94ccdbfd7090 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -246,11 +246,20 @@ static int
> smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>               *value =3D 0;
>               break;
>       case METRICS_AVERAGE_UCLK:
> -             *value =3D 0;
> +             *value =3D metrics->MemclkFrequency;
>               break;
>       case METRICS_AVERAGE_FCLK:
>               *value =3D metrics->FclkFrequency;
>               break;
> +     case METRICS_AVERAGE_VPECLK:
> +             *value =3D metrics->VpeclkFrequency;
> +             break;
> +     case METRICS_AVERAGE_IPUCLK:
> +             *value =3D metrics->IpuclkFrequency;
> +             break;
> +     case METRICS_AVERAGE_MPIPUCLK:
> +             *value =3D metrics->MpipuclkFrequency;
> +             break;
>       case METRICS_AVERAGE_GFXACTIVITY:
>               *value =3D metrics->GfxActivity / 100;
>               break;
> @@ -270,8 +279,26 @@ static int
> smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>               *value =3D metrics->SocTemperature / 100 *
>               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>               break;
> -     case METRICS_THROTTLER_STATUS:
> -             *value =3D 0;
> +     case METRICS_THROTTLER_RESIDENCY_PROCHOT:
> +             *value =3D metrics->ThrottleResidency_PROCHOT;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_SPL:
> +             *value =3D metrics->ThrottleResidency_SPL;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_FPPT:
> +             *value =3D metrics->ThrottleResidency_FPPT;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_SPPT:
> +             *value =3D metrics->ThrottleResidency_SPPT;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_THM_CORE:
> +             *value =3D metrics->ThrottleResidency_THM_CORE;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_THM_GFX:
> +             *value =3D metrics->ThrottleResidency_THM_GFX;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_THM_SOC:
> +             *value =3D metrics->ThrottleResidency_THM_SOC;
>               break;
>       case METRICS_VOLTAGE_VDDGFX:
>               *value =3D 0;
> @@ -498,6 +525,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> smu_context *smu,
>               sizeof(uint16_t) * 16);
>       gpu_metrics->average_dram_reads =3D metrics.DRAMReads;
>       gpu_metrics->average_dram_writes =3D metrics.DRAMWrites;
> +     gpu_metrics->average_ipu_reads =3D metrics.IpuReads;
> +     gpu_metrics->average_ipu_writes =3D metrics.IpuWrites;
>
>       gpu_metrics->average_socket_power =3D metrics.SocketPower;
>       gpu_metrics->average_ipu_power =3D metrics.IpuPower; @@ -505,6
> +534,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context
> *smu,
>       gpu_metrics->average_gfx_power =3D metrics.GfxPower;
>       gpu_metrics->average_dgpu_power =3D metrics.dGpuPower;
>       gpu_metrics->average_all_core_power =3D metrics.AllCorePower;
> +     gpu_metrics->average_sys_power =3D metrics.Psys;
>       memcpy(&gpu_metrics->average_core_power[0],
>               &metrics.CorePower[0],
>               sizeof(uint16_t) * 16);
> @@ -515,6 +545,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> smu_context *smu,
>       gpu_metrics->average_fclk_frequency =3D metrics.FclkFrequency;
>       gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
>       gpu_metrics->average_ipuclk_frequency =3D metrics.IpuclkFrequency;
> +     gpu_metrics->average_uclk_frequency =3D metrics.MemclkFrequency;
> +     gpu_metrics->average_mpipu_frequency =3D
> metrics.MpipuclkFrequency;
>
>       memcpy(&gpu_metrics->current_coreclk[0],
>               &metrics.CoreFrequency[0],
> @@ -522,6 +554,14 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> smu_context *smu,
>       gpu_metrics->current_core_maxfreq =3D
> metrics.InfrastructureCpuMaxFreq;
>       gpu_metrics->current_gfx_maxfreq =3D
> metrics.InfrastructureGfxMaxFreq;
>
> +     gpu_metrics->throttle_residency_prochot =3D
> metrics.ThrottleResidency_PROCHOT;
> +     gpu_metrics->throttle_residency_spl =3D metrics.ThrottleResidency_S=
PL;
> +     gpu_metrics->throttle_residency_fppt =3D
> metrics.ThrottleResidency_FPPT;
> +     gpu_metrics->throttle_residency_sppt =3D
> metrics.ThrottleResidency_SPPT;
> +     gpu_metrics->throttle_residency_thm_core =3D
> metrics.ThrottleResidency_THM_CORE;
> +     gpu_metrics->throttle_residency_thm_gfx =3D
> metrics.ThrottleResidency_THM_GFX;
> +     gpu_metrics->throttle_residency_thm_soc =3D
> +metrics.ThrottleResidency_THM_SOC;
> +
>       gpu_metrics->time_filter_alphavalue =3D metrics.FilterAlphaValue;
>       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
>
> --
> 2.25.1

