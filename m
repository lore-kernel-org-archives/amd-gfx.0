Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6462DC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 20:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEB810E678;
	Wed, 29 Nov 2023 20:49:49 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABD710E678
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 20:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYCwIvkB9zEJAFSmkcnU8kCkppMepjKQyghgYh4A9eUfldAEl8UVpXIem6ReA6P/hfSKvgpTVFB2hOhAtMhexKVWKMpQ2AWGsR0DX7pq/mFpbAn4mQ8wgwpEiT+jygdhEL0pu4n+xAhDoXAaqfGpQg8w6Sn6kBQS4VUWkQRP9t2xos87Tsn9tU/2OwB6ZDLH46bvcLGVa4WdEvCnN47m/adr3U7YMpfm7rYS3eX7wHea14v6+pVx3XWnYZDrXGV4kJiXruKFEmTovDWHlnXDZFUfT9Hwv2nW60ybVi25iJR4n2zRvm06zX8o15DUJ82n5u4EPsIP+8W+8UjdNrlL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf/g9VVMUGamb62yyvtP9MF0tM3UK+5d23Dlk+SEpSg=;
 b=Jb1CE2rM8fdlfP8vKhtR2FCWZqmdSMo/cPCvM3UBLTUmuE9L1kWMyVaL7l8BETA81L/IX8QnHWXr0NJhND+eT+IdoXXEQl8EEA16Y6v1to+ZWDHPb6FcsW+KtwEOpheiS3jcWXhN5phq51JtqLa7kh05mLnvslNu1dvdtWHVKVIj/EzdPHTXtDG+7TODtoMXf36BQanJj2Ifhb5iZB/es9YN9DGA2cMfztzhx8y2HS6uJYVu1eYRiZvNzX6d0hSaZ38x4BB4kxfRPfBtOxBnuAod4G+nEbIu4+X7+rvS4t/v57v+0hw6k81XCLCtMh0sJqdgMrcOD3Y8InyX7SHHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf/g9VVMUGamb62yyvtP9MF0tM3UK+5d23Dlk+SEpSg=;
 b=WCO+xs5pth23gqsmwyYHs3CT+JFVUFpOruPEC0cfsWOufxCLvC081fYpqnu8uBlQ8imeYjD8d1PbGvXBFNjUlnnObV6wN7dSv2YFoiU52EuLBNrAgzFD8X9Z1KPhR+D5e0QmeDv402SyTYaUIUmsoMhcHIakSFAbRj1CdSe1Bzo=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 20:49:44 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::2c8:a4b8:6a94:e062]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::2c8:a4b8:6a94:e062%6]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 20:49:43 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Clean up VCN fw_shared and set flag bits
 during hw_init
Thread-Topic: [PATCH] drm/amd/amdgpu: Clean up VCN fw_shared and set flag bits
 during hw_init
Thread-Index: AQHaIkFyF2+LE669cU2GfQDc6GwVz7CRxFGw
Date: Wed, 29 Nov 2023 20:49:43 +0000
Message-ID: <DM8PR12MB5399308F9EB1C9DB9CBAB5BFE583A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20231128212517.3183-1-bokun.zhang@amd.com>
In-Reply-To: <20231128212517.3183-1-bokun.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bb1eae06-4b61-41de-ab2e-a630a2994546;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-29T20:41:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|PH7PR12MB5856:EE_
x-ms-office365-filtering-correlation-id: 4461e881-d16d-47cc-c610-08dbf11cb742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LHRc6VguH/wy16oc08juRAb8lvTmtCDOAOnodW+PzaOJAnsBSQvC/XZFgIEjFrDXArysLYRsfcJ56yJ84HtWRWebSWyxHcxNjfq5tRXGjt4SYWC/dQxSUcsUerw3+hQThLPUgq6cmtVLEY7h6DkP3ZJGh1Hg867hXhlr87WBaTJJoNRgZxIuuZTErRHKhLusZm6ODZfH/dEMrj2RMwjkrI2yp3AYh3jiriyrOopZJhvb1XqW4ek/gynaeJyX30jy2ue783geEw0Rru/2zmtxpbkPZ0YuitTD3R18PnFNzPVfZywO6JE5J7ZzytPHPuS3Dt3LV4UwXmFzVxkw+7+gQ1ybcRU1/XN2SomwCsdLO+/lSBf88YXcKE8ch3xDOv6sY+Dmp3dO/W6GM44GnIZ36096zbe+zEqowQNvn3Lv94eMaR4JETo88Kfhk46pmISfNugXYzJSnrJwCGZe8ZUhv3HV2k5wIza/GcXVRxIIJiK7U7yhqJ5Zyvyi/nNFlC8iW1aihHTcTkF6tnRMp2+vqNTeaPJqh7Dg5/fInHlwUvzr14dpTnu4SZVTj5boD96Rylr5TcqpLQ17wm4LV+PiiUWbMO164rtZYnwr0nguwQ4TJEQA8QxKlmaRU40epzX0x41rBkiG1JOYN8yvlvTeD/GdGcdAGeV0keU6FeNJWQs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(38070700009)(26005)(86362001)(316002)(66946007)(76116006)(64756008)(66556008)(110136005)(66446008)(66476007)(2906002)(202311291699003)(83380400001)(7696005)(53546011)(71200400001)(55016003)(9686003)(6506007)(8936002)(478600001)(8676002)(4326008)(52536014)(41300700001)(33656002)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SZZKI5b/ZTRIzQ3cw4fWZOIVgrnAf86hAwEmtTlSFQaT17mbEBmiaQfBxEJJ?=
 =?us-ascii?Q?uak0edQab42wR8QBnOW8T+XmhZDZ4AsvWX9L4SB9I4Bkxq/OVjnyhexiAC4B?=
 =?us-ascii?Q?sFvcpsWokddvw0YnK06vO5d9exh+VXCHu515X73Hyw0oKYIxcTOShdN2h+GU?=
 =?us-ascii?Q?581NGgQenyeurblDyjOQFcb6CmTEoWk4061ee5+nVdmoxPSjaxP78EIuZhpR?=
 =?us-ascii?Q?dhcg0wRX0N8dXsY4wFQzMzqWaDMIEaMwp+VEKWbbZIRa2SagJO0pMsPJzftG?=
 =?us-ascii?Q?xGN+yQcXUrSHwikLBccGrA4+ZzulvrdrmSy1IVM767xP7XQufbH4+TWbZwbH?=
 =?us-ascii?Q?OJGtbGPxhBhFNQvWiv2zm651JJcU5WRpkUYJMx6qy/Z5F/HVcaKARY3+fl02?=
 =?us-ascii?Q?t1foudDBU0tIkjcCPHeY0zldiqzX0gBK71vCdnE4DoZ0TV+f1Xzh5woDgCV/?=
 =?us-ascii?Q?ioF0h0yQsuaL4FCytpJGAoXzrlVWiT4hjQVMMS7UqdlAt+mOHN+1Tlqy86Bi?=
 =?us-ascii?Q?7hp8G1DuxSx9ZgYQ6gKiancEsykAYG+MUaJBaQYyyFFlaIgYzEiDuMN1mCz+?=
 =?us-ascii?Q?JtnbasvHyvKAHm0PO+LZasFR2wAQcBletFBBksODO998lMesU6fjx7KoidPT?=
 =?us-ascii?Q?UiVfwvBtvfVddIEmLntfO1v8VvoVAzY7P/kOABDd1UBIb1QNv71acYV9Q8JO?=
 =?us-ascii?Q?2D9qncxIFr1sIyFlODulBZkAbWIOsBKvbdxPoJj7YrxvUAa2B71wivvk0aHk?=
 =?us-ascii?Q?HuQIa2iD78GsSHf+Rj6uKkDYmhZXD4sqA1Ztj4maUtcKwMq/pYkp+z4t4rae?=
 =?us-ascii?Q?KOLtcGFBbM8eoAyMPAD1qzzB2szI2h0a9sgHJcPUWCUBZejqT4FxreLp799x?=
 =?us-ascii?Q?+pSYpPFMKewbKBsCC8vY0PdQf82ccZgGfX/HEZCPUyDG5VOAkPlqrv+GMgUA?=
 =?us-ascii?Q?YwwgpdFcDOKoKsr+cQRf5jKtFJzwEegc02d1RITTSQ3LcWkTxdGyBlfMlAOn?=
 =?us-ascii?Q?7G/nI7oqOjC9giVUBDX1WjVejhk8zUngXwjiofcwQevSfoITiX9Y7T/UxMac?=
 =?us-ascii?Q?qtsQqMDri4n5aWcz8eo85BvFMK6Biuaf/o4N4nodptZFE8OOQF820B1+PyW1?=
 =?us-ascii?Q?So2DxuUCYFhD6BuWnYvR7O25+z36HKFApsc749Xml4xq7dHG1mw6e3BXEQ41?=
 =?us-ascii?Q?aIVk5viNhp4DF9PzweNaZ6ipiZzVyuNvYJaU4eVI92jOASNGRJWWxgSFI0AG?=
 =?us-ascii?Q?gUFDQgTXyLsNJ2Bs+HwTdzZs3oZl/J7/dSeJebv2Gf0qp+6qdGdEntpLYvj9?=
 =?us-ascii?Q?v9dAiOiEIBz+SRF9pHOsGhmKDD5kgsPVrc8KrR2SWFvjOjD4UsE3UoVeM3ZS?=
 =?us-ascii?Q?WMNIqq6dYy+nNTId1ppwasGvEcd/lo8LPCrla/ZSqxpGvvUqZuO6b59UE2NS?=
 =?us-ascii?Q?/rKLTjBXVIbsylfGVXMdy98dDqS0E9cvauJxfGBznSLdGg0WmbgHDAL0gxBg?=
 =?us-ascii?Q?wIPZQCljTqj8R2RJTIq4v0uNyD5tfcx78H2jv+KoPqWORbiJURHUeK3A2w77?=
 =?us-ascii?Q?2nEkeP1O9wgbxdZrsQY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4461e881-d16d-47cc-c610-08dbf11cb742
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 20:49:43.8925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nAPhNGiRy3sNOvRdtAKJ3xalRh+GuuUDYymSSrb0VW1ZJxIhNC/cfTkygfeOoyT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Bokun Zhang
> Sent: Tuesday, November 28, 2023 4:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: Clean up VCN fw_shared and set flag
> bits during hw_init
>
> - After whole GPU reset, the VCN fw_shared data is cleaned up.
>   This seems like a new behavior and it is considered safer since
>   we do not want to keep the residual data
>
> - However, the existing driver code still assumes the residual data.
>   For example, in sw_init, we will set the UNIFIED_QUEUE flag bit.
>   This flag bit is never set anywhere else.
>
>   Then if a WGR happens, sw_init will not be called and therefore,
>   we will lose this bit and it leads to a crash in VCN FW.
>
> - A proper fix is that we explicitly set the flag bit in hw_init
>   every time and the data is repopulated after a WGR instead of
>   assuming the data can survive the WGR.
>
I think this is part of sw_init, along with loading fw. Should not be in th=
e hw_init. I think you probably can try to save it to a saved_bo when suspe=
nd, and copy back when resume, same way as for FW.

Regards,
Leo



> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> Change-Id: I783ff826f12e12eaf48d046ff9f1cef65558c7b9
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 45 +++++++++++++++++----------
>  1 file changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index bf07aa200030..0cf3e639c480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -111,6 +111,7 @@ static int vcn_v4_0_sw_init(void *handle)  {
>       struct amdgpu_ring *ring;
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>       int i, r;
>
>       r =3D amdgpu_vcn_sw_init(adev);
> @@ -124,11 +125,12 @@ static int vcn_v4_0_sw_init(void *handle)
>               return r;
>
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -             volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> +             fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +             memset(fw_shared, 0, sizeof(struct
> amdgpu_vcn4_fw_shared));
> +
>               /* Init instance 0 sched_score to 1, so it's scheduled afte=
r
> other instances */
>               if (i =3D=3D 0)
>                       atomic_set(&adev->vcn.inst[i].sched_score, 1); @@ -
> 161,21 +163,6 @@ static int vcn_v4_0_sw_init(void *handle)
>               if (r)
>                       return r;
>
> -             fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -             fw_shared->present_flag_0 =3D
> cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -             fw_shared->sq.is_enabled =3D 1;
> -
> -             fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
> -             fw_shared->smu_dpm_interface.smu_interface_type =3D (adev-
> >flags & AMD_IS_APU) ?
> -                     AMDGPU_VCN_SMU_DPM_INTERFACE_APU :
> AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
> -
> -             if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                 IP_VERSION(4, 0, 2)) {
> -                     fw_shared->present_flag_0 |=3D
> AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
> -                     fw_shared->drm_key_wa.method =3D
> -
>       AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSH
> AKING;
> -             }
> -
>               if (amdgpu_vcnfw_log)
>                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>       }
> @@ -245,9 +232,33 @@ static int vcn_v4_0_sw_fini(void *handle)  static in=
t
> vcn_v4_0_hw_init(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>       struct amdgpu_ring *ring;
>       int i, r;
>
> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +             if (adev->vcn.harvest_config & (1 << i))
> +                     continue;
> +
> +             fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +             fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +             fw_shared->sq.is_enabled =3D 1;
> +
> +             fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
> +             fw_shared->smu_dpm_interface.smu_interface_type =3D (adev-
> >flags & AMD_IS_APU) ?
> +                     AMDGPU_VCN_SMU_DPM_INTERFACE_APU :
> +AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
> +
> +             if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> +                 IP_VERSION(4, 0, 2)) {
> +                     fw_shared->present_flag_0 |=3D
> AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
> +                     fw_shared->drm_key_wa.method =3D
> +
>       AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSH
> AKING;
> +             }
> +
> +             if (amdgpu_vcnfw_log)
> +                     fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_FW_LOGGING_FLAG);
> +     }
> +
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D vcn_v4_0_start_sriov(adev);
>               if (r)
> --
> 2.34.1

