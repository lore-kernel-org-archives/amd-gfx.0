Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A776C25B48
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68E910E3D8;
	Tue, 24 Oct 2023 14:47:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD8410E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6fnvcEuVt9cyBtRQl9pK+B88wHYk46VDQfWLCVJ9pW9j6lBFxyx/5WZYZFtqY21krNnnRm/ttfJaTNGrKGNTIDxKyfK+XPl+VoMJpi2gBdATdLI0eDJs5uNrVhjvhOfektHzYgPYR4dX1Zm20mHsPVWSnYc5b009B9az3Icmm40AK4THl/Nh0UZHLsSAf/RN+h2dTDkbqc5Fxdqbcm5vBl9F0CBxjub4zdXK4fLOPCZSObbAoyy80oNN3n0j8VflSHSXKtqNQbilwqapl5Mxkuu1mho+0bQY23cHBwrjFaTcR4tae9eUCQqSLzMSrcmdukZE64wpdeEEI2hy86vDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6QL8gM7AWMRZQ0IN2rNq3C8XfFc8X6rsHSsDIZSLs8=;
 b=bJ7kBBmN22HmXI0AeYcNmwpXCUp3Zr7T4IC4+yaarHa/idViKq9uO6flge5cRIW03VGTA44SNC6Ic+SQ1KBYYOL55E6c3kxOTCpcgXZGwZcpcEYASKAshkbEoI4fH/NjfbHgsJg41knXFWt/C1H00FxpFSFf/AaqScSSTdadT9qm4ebHg8TX3lNOeUNDlD/TVWHTT2NJun8m7boAEoZKhfOsJUuAIcpbjktCBTjFq5dCdQN/he4uf//rFPQaPdHENJlxhQVO39LUrsCz+1+bXIF/sSPku96tUxxBkaYH2MvnAp4/JzVNSeESbbeYII2N8PZUHNZgf41W69uTQDxxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6QL8gM7AWMRZQ0IN2rNq3C8XfFc8X6rsHSsDIZSLs8=;
 b=3MDiWjMYx6/SIbWMMf+r0xgx1dH83z1lp6CwdtpZdYDDGs5MNqdcQ+tPj4s6DJ/FgPuuYtb6O+BdvVISSBZI28TJMP9jo9WIofwxLm/AAmUvkuti6+HhF7Ob+PvcPU79TW1tbCCvLxISPZJNnL6YjkDDa0TL/w1uiVCOo+nlhnw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:47:11 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:47:11 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Thread-Topic: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Thread-Index: AQHaBiKCq5a1fvcQ/E24Rm9FuNleirBYe4mAgAAcbICAAGfPQA==
Date: Tue, 24 Oct 2023 14:47:11 +0000
Message-ID: <CYYPR12MB86558FF8DE49930EBD122B0F9CDFA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
 <DM4PR12MB5165A612DFDB89A7DC5DDB5B8EDFA@DM4PR12MB5165.namprd12.prod.outlook.com>
 <PH7PR12MB599791A41D2A4E0803CAB07982DFA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599791A41D2A4E0803CAB07982DFA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=95cd0cc3-2f00-4034-b3bd-5e597ac8538c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T06:32:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SA3PR12MB9091:EE_
x-ms-office365-filtering-correlation-id: 5535b6c6-ad8d-49a9-586c-08dbd4a01b02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDHyd218AunJToQHlqKim/3Gqv8OYqfIJd9cDHdcop3lwbqRzlG3IKIBJ/KHaGMK+Ras9yDjNPLVs+8FTL9/2PkIkI2MELlMsn7wkI7rdH1GjE2UmeRQBdACd4KsQElLYeQ/WwGq1MCC0gophQF6xWcFnvd6cSumryEWp9+1yg46AJBKqeJN6PT1APRIzjLnfxsLCDnZ9no1YtIwp1ik66j630sglIT64n6FleXYoZwcJXoxxacgK1gd1yyiMnWUq2v24ZpDqunIt+emc9pFITCjSxpwLG/nHICIqtX/vjXwoYlijuwBoGGZ4ur7NSgd2fp/NFeJOZc8JwmUQsESZ7UQ8LIU6d+t6eZOvfxQpNeeU8eJIx4Ri+vdEmEk5oR2MsNvAjazcUTSMyQZtZ36HdSGdmH4QEgxCuNFOStxHwb1yjbVqTwIy6Cy5FY0ezDn72Gso/M0aiQ3a0Rl+2UNOyt6+Rdqx2QsEkegILw8/cB6s1qjVYwMtTwnYof1cauAsfBVWFiFkE6m31NxG3zJIWd57/PIl/TCLn5v+AuCydByFCEUn0PJr3QwA189b6ec3oyaS4Tx/npvZNxpuI79OketsGEtNGu55nh6wVKThFdnzPdh3QBTh0GHmU+/OM0d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(55016003)(83380400001)(2906002)(71200400001)(8936002)(4326008)(52536014)(33656002)(8676002)(38100700002)(53546011)(122000001)(26005)(15650500001)(7696005)(9686003)(5660300002)(6636002)(6506007)(316002)(66446008)(478600001)(54906003)(86362001)(64756008)(66556008)(110136005)(76116006)(66946007)(41300700001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?loIPGXa0GjBixpaJCbgtr75dz4xLVGmFqI0fCSz3Bposk+6c4sKDKlsbzdVr?=
 =?us-ascii?Q?x/Fwz4pntSFPOaf0kQwmWP4SuxQP3s7F72H8VjmjbrG/EKdcVj9sxHq1Ac2L?=
 =?us-ascii?Q?dVZF8OwknZ66upM28t9NSKbWWYZgx2GhgNrzTXABppDm+FxWgvWh38HQhJ3W?=
 =?us-ascii?Q?6gaZ1JOSLKhcYloCHciycUwdSM6BeDm/loif2tPoPe54Vt3Q3LPPFYc0QmbO?=
 =?us-ascii?Q?b5X7gxvdj2DEu38CuzmTppdYvAUdXFIQobQjLXKygQX08Nq4w8K6k9LH2Qn+?=
 =?us-ascii?Q?NBs1wXaKVa0Z0aYQYt6xTVNui0VxU+xioexBljeeRghO6dTZAf4CrBKQTBnz?=
 =?us-ascii?Q?O9FW/fUvHVpEYOwQU9DQUeahoUbalhbHTybabds/n6iotSDam4ZczsFSosE6?=
 =?us-ascii?Q?5wyPrynGKeuzArqlvF2KXnCISTCkF6EUoPo3pcAB9kMTCNZGSGVkku1f7MDA?=
 =?us-ascii?Q?TLtxayPBfP6jExySGz0S+ejYAI5jQYtC+CTGB9YcdegOckwHMEdpRf0eLC3a?=
 =?us-ascii?Q?jIkfEDVz7eET2YVmIq+IXqOnICr1/3LgMdCK0aDTFk9XOeLNZYThayM/Kc90?=
 =?us-ascii?Q?/e7N8sAlWTDD8/3PPTEYtsOIcMSXJqvXHiqM3LPF6JOn4yMDEx6Mmzx9ScTs?=
 =?us-ascii?Q?GZp15OLKk4IU7Q0tdk4ChLOIXmeao4Lc8/ZhuG8Ol8bqJb5lx/EAmjif1DEW?=
 =?us-ascii?Q?xAVn/lJsWP7pf2iO3o7n9QaE4gF0md7leZAUPVoqnNEqkf7D5BMElFpHLVuF?=
 =?us-ascii?Q?sKjhAZ3J44kqZNEEAHQpa6q14bwMD87bYrDQT+IWnqbF8ZUxPtHbuJZUBF2s?=
 =?us-ascii?Q?9hQvRX1PNTqKWN2KZsbT40PhwJ/5wj3iqUIYeKXiuRSRGXvMB30mDgSi0UeZ?=
 =?us-ascii?Q?k72BHn3S4SPUwFdOtpJ4qXFBR/PeZ/4gZW7B4REZWgodisK97qpu5aXGfL06?=
 =?us-ascii?Q?TWiCXtv0nbnWV53QoZE+60/xIltRB13ZwsuA8C7NWVTM8Ri8RqGEwzrQKRPm?=
 =?us-ascii?Q?wqn+DLmoqKElGbusjfZ78Lc8ae+dxuRW688Ux1TvlJwSSKPQyn0z4tgnrIqA?=
 =?us-ascii?Q?+VwjAog7cRCggWOwcjGD3JKfXDkuhuP0CBgWQ91ggb692IToVrqoTQJXvN1K?=
 =?us-ascii?Q?4ejdSP28OYZnd+IZxyeiY8jvg6X/kb6QJ6aaTe1opVY/NwvpdLI7BsO3dDCP?=
 =?us-ascii?Q?fVpO6s35Gtcy8c7Irq3rDOoTgpqn7aQg7Colpw3ZT3PzMmGYMrE8Hz/0/xCQ?=
 =?us-ascii?Q?ytCYixBWsajxaubZHF2LMyzqDzYAg5zW5Rlmr4HXnyYYN7G5jpSCUVPLKYUR?=
 =?us-ascii?Q?/4FKstkU77fMuQmj20AWwtPml/41zbwlrJ2PVrN6+HWpAYQmUbEe4L5zGIq8?=
 =?us-ascii?Q?3gPlLyupBca5hPzyKCD3HGl4cFT5fhlkFtGJtM/LCo+j1+GhLTh9yWvukfnS?=
 =?us-ascii?Q?HgAqd+nBvJzqjVDR03WgPgKF3kJRnRcwT8l7yktJxlbv2CLD7YrjziII0Ihx?=
 =?us-ascii?Q?fekS8IgiGCygJjLxUXntqh9fWzjGpIKJ3q4AmsAINAL6fFM8fXhsvx457snA?=
 =?us-ascii?Q?Aw8+smFsheltajm8d+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5535b6c6-ad8d-49a9-586c-08dbd4a01b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 14:47:11.5767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0p6eBf2Vjcp7MwQVanNiKMNypQ0CDwBE5r5C3YNC0klZ1PEcNNo3TPfIh5H+T0zvBSIkouwwWc7eT2HKW8Ziag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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

Hi Kevin, Kenneth,

Thanks for the review and ack, will pick it up in v2.

Regards.
Perry

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, October 24, 2023 4:15 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>; Yuan, Perry
> <Perry.Yuan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH 1/3] drm/amdgpu: ungate power gating when system
> suspend
>
> [AMD Official Use Only - General]
>
> Acked-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Feng, Kenneth <Kenneth.Feng@amd.com>
> Sent: Tuesday, October 24, 2023 2:33 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 1/3] drm/amdgpu: ungate power gating when system
> suspend
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>
>
> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Tuesday, October 24, 2023 10:33 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH 1/3] drm/amdgpu: ungate power gating when system
> suspend
>
> [Why] During suspend, if GFX DPM is enabled and GFXOFF feature is enabled
> the system may get hung. So, it is suggested to disable GFXOFF feature
> during suspend and enable it after resume.
>
> [How] Update the code to disable GFXOFF feature during suspend and
> enable it after resume.
>
> [  311.396526] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your
> previous command: SMN_C2PMSG_66:0x0000001E
> SMN_C2PMSG_82:0x00000000 [  311.396530] amdgpu 0000:03:00.0: amdgpu:
> Fail to disable dpm features!
> [  311.396531] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]
> *ERROR* suspend of IP block <smu> failed -62
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Kun Liu <kun.liu2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d9ccacd06fba..6399bc71c56d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3498,6 +3498,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct
> amdgpu_ring *ring,  static void
> gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>                                                unsigned int vmid);
>
> +static int gfx_v10_0_set_powergating_state(void *handle,
> +                                         enum amd_powergating_state stat=
e);
>  static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64=
_t
> queue_mask)  {
>         amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
> @@ -7172,6 +7174,13 @@ static int gfx_v10_0_hw_fini(void *handle)
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>
> +       /* WA added for Vangogh asic fixing the SMU suspend failure
> +        * It needs to set power gating again during gfxoff control
> +        * otherwise the gfxoff disallowing will be failed to set.
> +        */
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, =
1))
> +               gfx_v10_0_set_powergating_state(handle,
> AMD_PG_STATE_UNGATE);
> +
>         if (!adev->no_hw_access) {
>                 if (amdgpu_async_gfx_ring) {
>                         if (amdgpu_gfx_disable_kgq(adev, 0))
> --
> 2.34.1
>
>

