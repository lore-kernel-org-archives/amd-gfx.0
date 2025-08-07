Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D72AC87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 07:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1000C10E073;
	Thu,  7 Aug 2025 07:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vBqNaIoy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A3C10E073
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 07:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcgqlrMZd9QgPOec6dvLSLr7wU3g7+ZIA8JxLmPAfh8fzEqRKvkBAkALNkwb+5hja3TjAkAK7Vhz2vomkOjz5EidnDGjv3fi/vqWpudO9RTOvac4KLCfJ3vKJRvUkxboz9IdfxKuQ8FIhU4Q1hcl+kmJttL64968+7pPljErR79C+wRvNHf64698Fw32bymgKXKFyXQ5gkgEAKHtM/fZWdpfUYl8RarsU9mwrfF6hxkC2wm9fBVpb+rcm28NwzsvQSar1dHOUsmi6WzEsrvL6Xi+QNdgL3nljmSNtxRUJOh1HIq/mUqCbu2n9JvzjTSaf3x6Yn73JeMnL/zCiBFuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXqSLKYWlJ22ckM+zHCoUsxTCjvjvlW5v11T7kVJO1Q=;
 b=dNUP+d1/1fDjS/l/biTjDnpLx+gG1z8qxWfd96BD5VYljmAaXFWrNp5Q9/Gat2J6+hVzH9euN19PJ7i9l30u28yndXdsMRQG+f1wASEBIur6e9KSvNXRhOt4SvNLCgS2UKvQrN4+CRytkAtddYAcbu5PdFSx932n4C9VRgeYAHHgiIACgVdZDZQ/QCSTBCs29DflVKzbC/gKglpqKiLOvjjQDnxPeR8gi9j+VCIjUHydJK1XnlhnBJdIkGhwurYNseoPTHY6PXv9BNmgsHhmsGTQxGxbfGTYW/rlv0leWxlSr4aAFQYldws1q3V+2QCX0e5cYbx4Cczf4j2HEz//nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXqSLKYWlJ22ckM+zHCoUsxTCjvjvlW5v11T7kVJO1Q=;
 b=vBqNaIoyDuLB9d15OrclOYEDgmPzEXCPW09i5DAg2Yx79s5jpC8VBTR2KUdWqBOBiBGcSIpnZ4jp4fjz/oPPIXlW+pn9yzvMsdmRE7y4Y5Q+pkK6dhsRgtayG7ay4+10anMrukC+6a275riPV29M+ayICRNlkLtSw5O+BMUtAL4=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 07:35:28 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%7]) with mapi id 15.20.8989.017; Thu, 7 Aug 2025
 07:35:28 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Save and restore switch state
Thread-Topic: [PATCH v3] drm/amdgpu: Save and restore switch state
Thread-Index: AQHcAuGBw0aXZ2OZlkGCifDTzCXHxbRW1UAAgAAAnpY=
Date: Thu, 7 Aug 2025 07:35:28 +0000
Message-ID: <SJ0PR12MB6967E0F7018D6FDCE8B565219D2CA@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250801124027.1709925-1-lijo.lazar@amd.com>
 <83be04f6-33c6-4fdd-a52b-898f6c8364d7@amd.com>
In-Reply-To: <83be04f6-33c6-4fdd-a52b-898f6c8364d7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-07T07:35:28.0680000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|LV8PR12MB9084:EE_
x-ms-office365-filtering-correlation-id: a97bacdd-439b-4bab-f8f5-08ddd584fb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kJWHywUnSQw0R2ogeLdRxPweXdFPue7mH51ZDsYcWROGnwAgFqqgllHamEPm?=
 =?us-ascii?Q?AybtgbnDnDBFtzAZ2S2soF+aCDF2RqzckLJ9pBlXwgknLH2wf9fvrzTZjuTV?=
 =?us-ascii?Q?MUFfq44eZSsuXcC1sUHTiCRtJI8B6cC5glCnvtNpPKLgrV3cLam4UUCOd04D?=
 =?us-ascii?Q?mMdHIWheckPSap6cfREizUzvbdl5PoHiIM/wEGOEY7HFLjBj7u6uci9+Ds+L?=
 =?us-ascii?Q?OX/xm3Sf3O0s9Yr0RU6O5Vf5EpQPDDloS8/101Yg1donp+XIdN1adizK0Ekh?=
 =?us-ascii?Q?LNGmI6exCEWz1voyHvsMKVpJ3PqPNhG2bofZ3k2ph2pI43FMsAzyeyVm/Civ?=
 =?us-ascii?Q?0uT737XiuMh4SgliGGSds/lnpLbZ05FqUxiSy8922XhrATCaLXjw0Xetz5sE?=
 =?us-ascii?Q?zGUEIsk+zkv1rlwJ+bGUI8gJre39+XsJA0UPibPdL5yIp6BQ09nBIpjqSBGe?=
 =?us-ascii?Q?QzVrDPaaWu4HSQ+p5DaHI2GWWKy2SAQB6bQU8jKvpR1Lk4MAZJf1Ovus0FMO?=
 =?us-ascii?Q?L3bafGGkXe6ZG3yPKpOup+QjA96Bb3d/6Q3/Medltrq1hPxWTXsP4fpzINh/?=
 =?us-ascii?Q?ArAXnQeNG1wzTAewztcGtqhdeG3KcMd0T/ScH5hVOAXy0y0zkTvasRc+PBjv?=
 =?us-ascii?Q?Cgwxqh0GSyIXcx++QkWhn/c8CqE8VWg/TCBA4bNaFk2h/2D1h6TkYI6yTaXo?=
 =?us-ascii?Q?gbbRg/X0Qh3vZr4Z8C+3vdSmN+PSJl276UwGaj0Mpg8HcVbSJYOnmwlO4oSE?=
 =?us-ascii?Q?qB3ayd2pgkYo1ULsBxadutA+OCkgOQkVu6TvLLYppAIil41bpy4P6EAxZk7D?=
 =?us-ascii?Q?8N/mNMsWolrzWwLRncQtgx7YrfNrspD9Tv5CsiCEtD2gebVlVhLLxzreBZpc?=
 =?us-ascii?Q?eMc8BiRTk2sM62bZ49sIpuyHxWkE2R1luPsXo27Zaoaw9uijvEEBAX/2LOXH?=
 =?us-ascii?Q?lGaG0hhSCGJ9+xtOTQVT22uFcH7zXkU8z6Zo8kiCcELESbe5p9yO9gD3Z9HG?=
 =?us-ascii?Q?E5gP+ADTjo4haJf3ms1iunuyVthtVj/e4t5WSM0h2ofQSR3PYDA1l50vrbap?=
 =?us-ascii?Q?H3V3v1dgVBL/CZ4v8JejTbVOuHixK8z2Hu8umG8Zs7RIpL/QE2+OErbXoLsC?=
 =?us-ascii?Q?Itzho/BLzB8JGqfCnC8llA4Y+tq9ss40GLnpOoCtjjlZ/ByvixGCUxvXJoSR?=
 =?us-ascii?Q?NQmG7QwnY/Res55F/epiu07M4p9XSpae9pDrx9QbxNkGEEoAIRw6xsxgH5UG?=
 =?us-ascii?Q?1PymmKAztn+P4nCoTQsAuKkfD7RvHBGbQ0P55rQCZX28qxnB7rZXC7XrKo0a?=
 =?us-ascii?Q?TClgIYLWeUl76YJEMFVZ61+RIWzAv18yELR6nQbzUxaI2jIQNxiujSwccFgK?=
 =?us-ascii?Q?64sS/wbmFzNjlbNabMBdnxP/pOAkj14Cid/Vy1HPDNJNuLu7cb/XpZ7nElsW?=
 =?us-ascii?Q?0u4ELqaca2WptTFhIvsQ46DDP7Q+fFGbN26UlSDbSmvXTHz461xtHzDP7N8a?=
 =?us-ascii?Q?+wHSczV7NSd/pqY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5FUZMVFFPQGB47KXPSW5lIU/iH4kHzpQyRqUNIGXS0M256KcBst+eAgim1hg?=
 =?us-ascii?Q?q3XYW1Lho7xrKsJAc3TmD1lXriMQkag8n6EPxRiYD036KzzvU8C/IXQoSAD8?=
 =?us-ascii?Q?uWmeFGLxK5m6b9D2oaGwzn8J1GGYGaR31S9ACOhfExw35ecwbqUK8U+D86AH?=
 =?us-ascii?Q?gi8VD7ZU9DO9Y8FbZlYdFB9Myfbg4iOz+RiuYH2I9ZKdf2tUKsKXiUdX02aV?=
 =?us-ascii?Q?FkoKQDdr6omPNa/zy6ouIASM+JjZpSsAdunvPJBUxo8zkFUsogsOEAfJ0ovy?=
 =?us-ascii?Q?WQoA0jPxQ+Zds/m+CV8zvDdCybGAN2jr9RJCQYyU0X/d4EzpGSDx79ZW7N0A?=
 =?us-ascii?Q?IwHfsTd3BkBvzbPhdOcceGU43AZt3JTTR6zJR2WDDVWwyzeJbFk87KfUm57E?=
 =?us-ascii?Q?lRx5BJCTzQjoSD6lxw4CC8tV8wN2pR9T2czS7W6ur+1Acj0sTMaHczTyKFa2?=
 =?us-ascii?Q?+hOoFgDG7WilDeFd/jPO3MLtjFkCBo2bheMPy2nlRFGN2VraMgCgKaQg9k8E?=
 =?us-ascii?Q?sixi/N9CWNuen5K4YahRvcqzIEao1IWdWMTNhEDk/ZyJ1noV3fJ5tY/C03Id?=
 =?us-ascii?Q?Cp6a0QeYYjqeBvvEpKZtnRSgY49AQiekhb38+1aFXQN4m5bTxZAQaocm9EYo?=
 =?us-ascii?Q?9WMtagoBfGIEqOnAFx4MjDo1zWQBN8kjTyLOuxecstsZ5jT5nKc/YDSL/Kun?=
 =?us-ascii?Q?84U3cjLPO3KB4UloU7Nl796jRkpz5zuw33neEjP9yG5BHF7dov09pCYQXMUj?=
 =?us-ascii?Q?2gwe4L/MzqnXVMamm+LrAnXT9jV96rKuw6fu/iMVyHPpphIng+BsxbcB4NZ9?=
 =?us-ascii?Q?7QcdU8f2emebALdmS6E+L+Id8P1hhYqVlh8Njc1lHnBQpPiB+NIf9OavXSoF?=
 =?us-ascii?Q?NriOoUWLCXgbw0btK9Drr3FMpeKFi+pKxcCZOBdzDNOg90s+E4zZnocRaNqp?=
 =?us-ascii?Q?9Dx/wxtrX10sXpzcLljFMuDQNYH9vmbppj8Zf6LFHEskwBiPwt7eonYzcSqw?=
 =?us-ascii?Q?clLUOY+itil2Z4Yts6wYI4lB90dBO5CdH4azvsZSaxvBXDOyOQMN2aVz+w6j?=
 =?us-ascii?Q?PIG+OiRszcJNhr3w8xRMQtKu+uaSuF/AZtnIHOHH+oLMH9gHLvCHTfPvSr2v?=
 =?us-ascii?Q?t2AGfsCbJEH768VGZy1WkRtijglnb4aD6zw4r2PjEPDASH+bp6EGKo69duP+?=
 =?us-ascii?Q?l/P5HIqcp7IFMGNLiTy7wcyNBo20Q5ZHJX7clve/6SedbibB1SFFvEd+LkH7?=
 =?us-ascii?Q?IdRRFz0B4OMkBug4vQ55sikDNVa8SWswf8Vr3Y1QnClaweoIABYe/NDwpQ4Z?=
 =?us-ascii?Q?XZ0e6R5/SlMGtLw3B2TPo6vF5AnzzI9+jCP4BrnOhJlclPh6ec+PyJV9wShX?=
 =?us-ascii?Q?RZOfCKEC8amUqjv7tRJot6dYxqz4sRVSxZ9Tffs6K9T/7MzVr9r0DSSVP4Ex?=
 =?us-ascii?Q?Dwc540zHwvEqYIGmCzHKWnEJWX97qrM2k2veQgtljfXmD7k4hpgBsuobwnc/?=
 =?us-ascii?Q?77NSAxv0jHNJ++5lx3PltRdSQfeBgYfTt8v1OPPjv5UZHI7gXKvvNsh/C2oM?=
 =?us-ascii?Q?1zzhhZCGDijqdxdbZtM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967E0F7018D6FDCE8B565219D2CASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97bacdd-439b-4bab-f8f5-08ddd584fb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 07:35:28.5007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzeMzrCixJT7nOB4kJcRXmpuSbBoussAYWzZ0fJI/bfibvCpvALyt24E8XL+YxNT8j2xAWOxCDQsdlaes1OpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SJ0PR12MB6967E0F7018D6FDCE8B565219D2CASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: Ce Sun <cesun102@amd.com>







Thanks
Ce Sun
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 7, 2025 3:33 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Save and restore switch state

<Ping>

On 8/1/2025 6:10 PM, Lijo Lazar wrote:
> During a DPC error kernel waits for the link to be active before
> notifying downstream devices. On certain platforms with Broadcom switch
> in synthetiic mode, switch responds with values even though the link is
> not fully ready. The config space restoration done by pcie port driver
> for SWUS/DS of dGPU is thus not effective as the switch is still doing
> internal enumeration.
>
> As a workaround, save state of SWUS/DS device in driver. Add additional
> check to see if link is active and restore the values during DPC error
> callbacks.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> v2: Use usleep_range as sleep is short. Remove dev_info logs.
> v3: remove redundant increment of 'i' in loop (Ce Sun).
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 +++++++++++++++++++++-
>  2 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3550c2fac184..96d772aadb04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -904,6 +904,9 @@ struct amdgpu_pcie_reset_ctx {
>        bool in_link_reset;
>        bool occurs_dpc;
>        bool audio_suspended;
> +     struct pci_dev *swus;
> +     struct pci_saved_state *swus_pcistate;
> +     struct pci_saved_state *swds_pcistate;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index cfd72faec16e..e58f42531974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =3D=
 {
>                BIT(AMD_IP_BLOCK_TYPE_PSP)
>  };
>
> +static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
> +
>  static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
>                                             enum amd_ip_block_type block)
>  {
> @@ -5006,7 +5008,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ad=
ev)
>        adev->reset_domain =3D NULL;
>
>        kfree(adev->pci_state);
> -
> +     kfree(adev->pcie_reset_ctx.swds_pcistate);
> +     kfree(adev->pcie_reset_ctx.swus_pcistate);
>  }
>
>  /**
> @@ -6963,16 +6966,27 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci=
_dev *pdev)
>        struct amdgpu_device *tmp_adev;
>        struct amdgpu_hive_info *hive;
>        struct list_head device_list;
> +     struct pci_dev *link_dev;
>        int r =3D 0, i;
>        u32 memsize;
> +     u16 status;
>
>        dev_info(adev->dev, "PCI error: slot reset callback!!\n");
>
>        memset(&reset_context, 0, sizeof(reset_context));
>
> +     if (adev->pcie_reset_ctx.swus)
> +             link_dev =3D adev->pcie_reset_ctx.swus;
> +     else
> +             link_dev =3D adev->pdev;
>        /* wait for asic to come out of reset */
> -     msleep(700);
> +     do {
> +             usleep_range(10000, 10500);
> +             r =3D pci_read_config_word(link_dev, PCI_VENDOR_ID, &status=
);
> +     } while ((status !=3D PCI_VENDOR_ID_ATI) &&
> +              (status !=3D PCI_VENDOR_ID_AMD));
>
> +     amdgpu_device_load_switch_state(adev);
>        /* Restore PCI confspace */
>        amdgpu_device_load_pci_state(pdev);
>
> @@ -7074,6 +7088,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>        }
>  }
>
> +static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
> +{
> +     struct pci_dev *parent =3D pci_upstream_bridge(adev->pdev);
> +     int r;
> +
> +     if (parent->vendor !=3D PCI_VENDOR_ID_ATI)
> +             return;
> +
> +     /* If already saved, return */
> +     if (adev->pcie_reset_ctx.swus)
> +             return;
> +     /* Upstream bridge is ATI, assume it's SWUS/DS architecture */
> +     r =3D pci_save_state(parent);
> +     if (r)
> +             return;
> +     adev->pcie_reset_ctx.swds_pcistate =3D pci_store_saved_state(parent=
);
> +
> +     parent =3D pci_upstream_bridge(parent);
> +     r =3D pci_save_state(parent);
> +     if (r)
> +             return;
> +     adev->pcie_reset_ctx.swus_pcistate =3D pci_store_saved_state(parent=
);
> +
> +     adev->pcie_reset_ctx.swus =3D parent;
> +}
> +
> +static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)
> +{
> +     struct pci_dev *pdev;
> +     int r;
> +
> +     if (!adev->pcie_reset_ctx.swds_pcistate ||
> +         !adev->pcie_reset_ctx.swus_pcistate)
> +             return;
> +
> +     pdev =3D adev->pcie_reset_ctx.swus;
> +     r =3D pci_load_saved_state(pdev, adev->pcie_reset_ctx.swus_pcistate=
);
> +     if (!r) {
> +             pci_restore_state(pdev);
> +     } else {
> +             dev_warn(adev->dev, "Failed to load SWUS state, err:%d\n", =
r);
> +             return;
> +     }
> +
> +     pdev =3D pci_upstream_bridge(adev->pdev);
> +     r =3D pci_load_saved_state(pdev, adev->pcie_reset_ctx.swds_pcistate=
);
> +     if (!r)
> +             pci_restore_state(pdev);
> +     else
> +             dev_warn(adev->dev, "Failed to load SWDS state, err:%d\n", =
r);
> +}
> +
>  bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>  {
>        struct drm_device *dev =3D pci_get_drvdata(pdev);
> @@ -7098,6 +7164,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *=
pdev)
>                return false;
>        }
>
> +     amdgpu_device_cache_switch_state(adev);
> +
>        return true;
>  }
>


--_000_SJ0PR12MB6967E0F7018D6FDCE8B565219D2CASJ0PR12MB6967namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: black;" class=3D"el=
ementToProof">
Tested-by: Ce Sun &lt;cesun102@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Ce Sun</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 7, 2025 3:33 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt=
;<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdgpu: Save and restore switch state</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&lt;Ping&gt;<br>
<br>
On 8/1/2025 6:10 PM, Lijo Lazar wrote:<br>
&gt; During a DPC error kernel waits for the link to be active before<br>
&gt; notifying downstream devices. On certain platforms with Broadcom switc=
h<br>
&gt; in synthetiic mode, switch responds with values even though the link i=
s<br>
&gt; not fully ready. The config space restoration done by pcie port driver=
<br>
&gt; for SWUS/DS of dGPU is thus not effective as the switch is still doing=
<br>
&gt; internal enumeration.<br>
&gt; <br>
&gt; As a workaround, save state of SWUS/DS device in driver. Add additiona=
l<br>
&gt; check to see if link is active and restore the values during DPC error=
<br>
&gt; callbacks.<br>
&gt; <br>
&gt; Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
&gt; ---<br>
&gt; v2: Use usleep_range as sleep is short. Remove dev_info logs.<br>
&gt; v3: remove redundant increment of 'i' in loop (Ce Sun).<br>
&gt; <br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 3 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++++++=
+++++-<br>
&gt;&nbsp; 2 files changed, 73 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 3550c2fac184..96d772aadb04 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -904,6 +904,9 @@ struct amdgpu_pcie_reset_ctx {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool in_link_reset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool occurs_dpc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *swus;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state *swus_pcistate;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state *swds_pcistate;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; /*<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index cfd72faec16e..e58f42531974 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; BIT(AMD_IP_BLOCK_TYPE_PSP)<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; +static void amdgpu_device_load_switch_state(struct amdgpu_device *ade=
v);<br>
&gt; +<br>
&gt;&nbsp; static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_devic=
e *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type block)<b=
r>
&gt;&nbsp; {<br>
&gt; @@ -5006,7 +5008,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_domain =3D NU=
LL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);<b=
r>
&gt; -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pcistate)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pcistate)=
;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt; @@ -6963,16 +6966,27 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct =
pci_dev *pdev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_ad=
ev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hiv=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head device_list=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *link_dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0, i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 memsize;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 status;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot=
;PCI error: slot reset callback!!\n&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context, 0=
, sizeof(reset_context));<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ctx.swus)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; link_dev =3D adev-&gt;pcie_reset_ctx.swus;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; link_dev =3D adev-&gt;pdev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come out=
 of reset */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; msleep(700);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; usleep_range(10000, 10500);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D pci_read_config_word(link_dev, PCI_VENDOR_ID, &amp;status);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } while ((status !=3D PCI_VENDOR_ID_ATI) &am=
p;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (status !=3D PCI_VENDOR_ID_AMD));<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_switch_state(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restore PCI confspace */<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_state=
(pdev);<br>
&gt;&nbsp; <br>
&gt; @@ -7074,6 +7088,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static void amdgpu_device_cache_switch_state(struct amdgpu_device *ad=
ev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *parent =3D pci_upstream_brid=
ge(adev-&gt;pdev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (parent-&gt;vendor !=3D PCI_VENDOR_ID_ATI=
)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* If already saved, return */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ctx.swus)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Upstream bridge is ATI, assume it's SWUS/=
DS architecture */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(parent);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swds_pcistate =3D pc=
i_store_saved_state(parent);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; parent =3D pci_upstream_bridge(parent);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(parent);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swus_pcistate =3D pc=
i_store_saved_state(parent);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swus =3D parent;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_device_load_switch_state(struct amdgpu_device *ade=
v)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pcie_reset_ctx.swds_pcistate |=
|<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;pcie_reset=
_ctx.swus_pcistate)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pdev =3D adev-&gt;pcie_reset_ctx.swus;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(pdev, adev-&gt;pc=
ie_reset_ctx.swus_pcistate);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pci_restore_state(pdev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn(adev-&gt;dev, &quot;Failed to load SWUS state, err:%d\n&quot;,=
 r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pdev =3D pci_upstream_bridge(adev-&gt;pdev);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(pdev, adev-&gt;pc=
ie_reset_ctx.swds_pcistate);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pci_restore_state(pdev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn(adev-&gt;dev, &quot;Failed to load SWDS state, err:%d\n&quot;,=
 r);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D p=
ci_get_drvdata(pdev);<br>
&gt; @@ -7098,6 +7164,8 @@ bool amdgpu_device_cache_pci_state(struct pci_de=
v *pdev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_switch_state(adev);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6967E0F7018D6FDCE8B565219D2CASJ0PR12MB6967namp_--
