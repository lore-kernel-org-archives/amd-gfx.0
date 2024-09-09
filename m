Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814ADCD4F4C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 02:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC1B10E0B7;
	Mon,  9 Sep 2024 02:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yY4mVCCC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E1110E0B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 02:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4avCZu5vpIL80mDgsQsz2nNyuIlWvbcX4F33F0/T4RsZz2ESw8cb++ZOngR1/PcfXpPlmEcjyu+uAv1vh3uJ9mUWjUBn98shqH9k+16i+TCWIaC3o5HL0EbZGodb2jLwKCt8RPob6RB/yo2CmQal3+aPue8Pyep0BsOVzkFAFOzakFo1pOswjI/D60e9tCZvmlHyuV9pWJcQcxAuuo7fTPji8c3/eZBuncyKzx9l59NXVDxuMoevlADeoag8aLdxeUzNeaQA/EZt6PCHadF8Ltsbds2wm1kDZc3J8Q4UchtB7NEn9lbCN5N800Wj4jIsV9DQgbPwZ3mE2Zkglmfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ixo/T2DcujFcmiVCaCuBOon3IP8zMdUDt4y4FA+uS4=;
 b=CmFC7/r3O4uhUAG3eyUbEOBy6ndtfClF/ejNn8YQ0lyEgJsYanMZG1NlAW27Fcq95uO/i5xZw/ihJ44adSXNRTNGYiDxNUhr1qZHNc1E+UiWxhzSBn50CywAGrVab4h6QVI9UkrdOp8uFNEfaQtp2je+i4etp87mUVrm7ThxGw+p3E1zETsgTsL6MDmCrd+Yhl0xgj62S6aK2NYyH88swNN9qzc5mphnE/1aXN7yW0IG7Xxds/ua4u1OudXw24BRoQm95NkCq9xA5qCLqjPlJUCqvSeKa7T5swuzKX8/KYPIni7C5i8JZK4GXcD831ayT2ZjcCQEtMJGRQyfTE2Z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ixo/T2DcujFcmiVCaCuBOon3IP8zMdUDt4y4FA+uS4=;
 b=yY4mVCCCgJvUdSsbqphMgReyPzQCh6orgAF8EXEXRfj5U6foUDzPXjkqw6cP3nNA7b0T+caLcBeNNw0dlsqk4TEjEvl5xaVSndveAyGLlKGrVeL+R+bJoLQbNcy9ALGtJGV1ojSbw22iI6exkVrNb1MkaRNXlPkrpP5VGohrzmw=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 02:53:11 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 02:53:11 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: clean up code for interrupt v10
Thread-Topic: [PATCH] drm/amdkfd: clean up code for interrupt v10
Thread-Index: AQHa/3Tj3RvSfnN3J0SUwySsjvadt7JOx35g
Date: Mon, 9 Sep 2024 02:53:11 +0000
Message-ID: <CH3PR12MB8074D5AD70773FADCD4F9943F6992@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240905092040.1054873-1-jesse.zhang@amd.com>
In-Reply-To: <20240905092040.1054873-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fc9c506e-3718-4066-8b08-10d4ab0d9d28;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-09T02:52:11Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH7PR12MB9076:EE_
x-ms-office365-filtering-correlation-id: 0d895587-0dff-468f-a4e0-08dcd07a8adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?J8rKDKm+Zf1nrY9SS1UouV5yIdhIzQsvr9V/x7D8+TtBoiFvcLsjFuaRnK?=
 =?iso-8859-1?Q?N8PB92vnvtl1/PhLbfXK+1BQvf5cICzE4T1Q9hsy7MhoPn90ThjO7o2A+i?=
 =?iso-8859-1?Q?sDFMNEHD4M3J00iLX5jTAL+whPJse24ZzicJ2OuWCDeCAsTmJoPYTpnlp7?=
 =?iso-8859-1?Q?Fbqm0Ytq4de1dAYDTc9ym5Yk7+41dslcob5N8S/otznn6ktwFUDsvyAVPv?=
 =?iso-8859-1?Q?JEo51VNIkT+J2BPEuyfvYbxKeqztGllX0MajufWafLgPN/UY/8T9T6GzxE?=
 =?iso-8859-1?Q?QosF9M0QFzvFYPq0RiwTeC4rttnSpoZzIbw5wUHxUA6knh/ydCUImRQGCW?=
 =?iso-8859-1?Q?UIiN7IZY3HJQZ17PjTqdCn620rhMcTB3g82pqZXMZ5EYlWsHBn6Yd8s+vL?=
 =?iso-8859-1?Q?MEvPz5TydXi+vTU6y76vkJrQO9a3FtReB0a7OqooncjbU8+4aeFDHeLbc7?=
 =?iso-8859-1?Q?Ccf2DwmEjMQn8SyGhwr3QZoHt8SYIzzwmgzahWNGDdb9LFBrqNoQRpXVlI?=
 =?iso-8859-1?Q?r76Z77wpbc4xB/eCw3JfwuwcbFDqnRonwGa+CiOsEYCcfhpR/cQso1VYNR?=
 =?iso-8859-1?Q?+16xhHSAv/v3E27eJadPEAU2rWayPjnR7sRNFkxFF3QvAowChrhDgUyz+H?=
 =?iso-8859-1?Q?VDnPK66lPfwZiLD094v3uu5mMZngA+kfTqWhquATQyNFnjfSdaOjfURBPb?=
 =?iso-8859-1?Q?3OJ4XD4jHY0qWE7+2C24zv5Gv8En6n9sgNP6TpOYfcOsDgMop9LYaPLEBm?=
 =?iso-8859-1?Q?KToxm6nRnAlZsHdAhiWpG9n1x66C2d2ediwb1No+mJmgzkg2mnH95UzA9n?=
 =?iso-8859-1?Q?eHrz2izmBF5QJP/PIs4SYofN2qIpsXhE57EqTv7dEIn2/CyMtv2ezcVZ5r?=
 =?iso-8859-1?Q?ipGiNTT0RwLpbQUEF6IH6D9JPdf0MGpa2qbB4GyxcOzksnz6iLMa5jUJjq?=
 =?iso-8859-1?Q?i/HVUC7IRnOOlzUuix9WIfy0qv3KrZGYz0evSdkULBFTvU1Dbt8wKk0X9O?=
 =?iso-8859-1?Q?jilA/s/DXNmlXgGKlDxCh0Xxcnb1QSJN0D8h4XM7ehgwbgqAVZV9/l4qFz?=
 =?iso-8859-1?Q?7yA3j4k9+2dcqFinZ6MMVGDOO3ncUiY7USj1eOpTVkxC5pHa0XB+o2XqEn?=
 =?iso-8859-1?Q?R2WJseVGo6P3TO+8tGBDClRiySyoTMQxClN8TgKhnWsTab5xiUkPAjR+hZ?=
 =?iso-8859-1?Q?2CBRMJrKXFjSRGpwcgbyt3GjAbNgRegd3h8l9bfZEVhCcXT4fYImDX7VC9?=
 =?iso-8859-1?Q?ziSRmFpx5YQOoFees+3jFYq6Sqind5GZ/1/5/Tt0JPCAEi9VicENyhuUPI?=
 =?iso-8859-1?Q?KV4nBefIjqhWhXy1L1NMAvVyyzuPTTw0VT4OrmhX2ki8UCZ7CKxPDv5+HB?=
 =?iso-8859-1?Q?Kui8LQrVqc06H9DEKKB3TOlb67rlBCpSlp7EhliofK3QpOl3bIZHvmlrxa?=
 =?iso-8859-1?Q?6P5L5gICWZhf+pPnZLOnuFeVnv6BiuKFcSq3zg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fYBqhmVCUc4FSUx3/doKy8FKL92gDvm8Fs7uWmdw9m8KPr5zyGto37HN2T?=
 =?iso-8859-1?Q?NgcJtMBB29pt3gSdxW45lSFiLjCj4cO4hny+y0UMW3iEGrSbhuO+NyMYzX?=
 =?iso-8859-1?Q?Eq+r80qcLa5TIzsYmevR6bhRd4NfJK2zWfncnMhUQi3oNfFrbee4PME87X?=
 =?iso-8859-1?Q?paacHaMgyu0qBVA4DywlWfFBqhUkxS2qve9VBwEKezS3KfJXctcEUEmZsE?=
 =?iso-8859-1?Q?AsVNcLnA37Nvo5IOvkbJn2pCWaVpFvfd4dAX4Ndzq7THS8lNF3/l+ix0or?=
 =?iso-8859-1?Q?0/PuMTGDRIo7g9T53nEtOdE6EA2XCGgmbHUIg3bO40g4XpYhLjdfiQACUr?=
 =?iso-8859-1?Q?Pdm0Wlq+Z5QDyANo6XG6BLV6Esr/319SVKQwTqIaT08FaVI1euULzFN71a?=
 =?iso-8859-1?Q?BZqqX/LmWR9O+CO0psf2v9GZnuzvZtt6LcY9E10gr+mcpqjcZ1VqFUCQyq?=
 =?iso-8859-1?Q?Dtn/Mbf3bQGgHtn0OyCTijJgWqg2PVdG/TrNCGU6LZiacFXackhmoSj1hw?=
 =?iso-8859-1?Q?oa34ShZvK5iVla+n8/PGqxzBqFLwu1UuYGOKpoB4ERMLli9hjwZp8H47Cn?=
 =?iso-8859-1?Q?KFBB+0OcjJdPvcTu1rwu6sr/ZYRRCX6MBKZkAQvuxewCGwfUkcX0BCSmuQ?=
 =?iso-8859-1?Q?ZK2zTCnHITxXG9XvJU8oZ1NDHKSS3+COoSJPPuXyneNhTMp5P2+Ya8ZdMD?=
 =?iso-8859-1?Q?uJLCDC7djrElLkvjyyvSndnVoexIpmg/FVJAPiZwodCSn3RSAbI0VHIPKK?=
 =?iso-8859-1?Q?YwTqDJVESuJzGehgQC+fTlxslohJgF/OMAG6XZ2H5Vwal/Tm3LJd9Lz6in?=
 =?iso-8859-1?Q?EFgUqYR3fHxLb20sdLCRzN0+UDKTrQylrptA3pPHzDVfKMrnHtLwoT0E8B?=
 =?iso-8859-1?Q?TSddeaxtOVkKZ0EJlhaNB4oLJSed6jcgeSKTjXQVnixOD/e2J0HmUI1ytd?=
 =?iso-8859-1?Q?oNJGaTRPJpSoRumDBxNy3Hi+wAkmh61udokABhdwp3XuPIwDBezmeBQXB9?=
 =?iso-8859-1?Q?6BFHVe7+ON/mRcqWg3Wtqq1WQpy/9ovyF5MCZSzL4cifNBLb5/NkLS4NVz?=
 =?iso-8859-1?Q?i9O+F+j12Hhy50oZRalUVLXRHrhEnoVjiASlbXtIb05IMZoMjOogGHnURD?=
 =?iso-8859-1?Q?NeZlkBO8nGFqI8AIcLqYerNecbF9GowcO8Q0oWt412HemStbzfWvAzBM3O?=
 =?iso-8859-1?Q?Sjx3I4yTCpkL9sag8HqECiSDu63kZA1tW5fJTb8RusK0FftFj7LZ9n39g3?=
 =?iso-8859-1?Q?1PigOlXLCCq2zoEEiyzRhT5sAS0lJ2VTvWN8l3YtxHwkHQkSScpelTAVGx?=
 =?iso-8859-1?Q?ojqjLFRNHqCQaSo7eOhNmB+8g/moJ1S+3Syzlbvcw2ds+EqMpYSf2E5M/6?=
 =?iso-8859-1?Q?cNTNyTHJOpSe2tg6nOXwazEIW0wSP5ymu8fGNZlceV+JXx0wELiFo+W6Cd?=
 =?iso-8859-1?Q?iSgW0lVJQMxZ8lZClUYZ2JniF0wFt3NOsVDc7iN8TcNCxyYxVfKVtcc3tA?=
 =?iso-8859-1?Q?WmACfMFrHXNVOv3qnRERSxCZclvF1eCS/Il0dXebCH145tH6ZAan8eX+Jp?=
 =?iso-8859-1?Q?1Uu0axmEAuQHIkzz+20gSJwXxOQrdTjvT2R/ME83jnpdrGC9sCUu/+ipaR?=
 =?iso-8859-1?Q?7DURnoldhJlGA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d895587-0dff-468f-a4e0-08dcd07a8adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 02:53:11.3788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQEv9ArjOFO8qnI/EHA8sl4ymUrEH6shZwZgSa8IoodErAmdU9V/rbsSXWqRqIMyEwgXHjpyztsyptMMlBwFVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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

[Public]

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Thursday, September 5, 2024 5:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: clean up code for interrupt v10
>
> Variable hub_inst is unused.
> Related the commit "bde7ae79ca40":
> "drm/amdkfd: Drop poison hanlding from gfx v10"
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index bb8cbfc39b90..2db824e87c8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -308,21 +308,8 @@ static void event_interrupt_wq_v10(struct kfd_node
> *dev,
>               uint16_t ring_id =3D
> SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
>               uint32_t node_id =3D
> SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
>               uint32_t vmid_type =3D
> SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
> -             int hub_inst =3D 0;
>               struct kfd_hsa_memory_exception_data exception_data;
>
> -             /* gfxhub */
> -             if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_=
xcc) {
> -                     hub_inst =3D
> dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
> -                             node_id);
> -                     if (hub_inst < 0)
> -                             hub_inst =3D 0;
> -             }
> -
> -             /* mmhub */
> -             if (vmid_type && client_id =3D=3D SOC15_IH_CLIENTID_VMC)
> -                     hub_inst =3D node_id / 4;
> -
>               info.vmid =3D vmid;
>               info.mc_id =3D client_id;
>               info.page_addr =3D ih_ring_entry[4] |
> --
> 2.25.1

