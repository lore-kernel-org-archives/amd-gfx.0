Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2A3C44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 20:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2001710E0F0;
	Tue, 14 Jul 2026 20:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUJAOzyz";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C341810E721
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 20:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnUNSkdxPDkbwyiRqehl1hz9HrOf8zWJjmhjj4lLx/fcm7TPgVrLZ8zzsXp4SXw72NHX/4m8ZTGU1rISjIbkHPqVi+7lMgXKaEP+mIQGd8yzp6rM39QQVHyE72oNBTkB7atYCXFyneCqHaTB/EgVYJPtqV46yq88VE6g7qJldBDN/RxHWsM5UQCW3uIsCr3b9J3uYEdSvcDC8i6nviBB/RcfZCHqCnO0W+TNYLDyQ4hdXqbDN+jKTeQZ6ZfKMAUxkOYHBhvKC1i8VP5FRUQGS1MVLSlEkobUJOHA2EqHxbS4sjO5nhS4t/M9bMrWaknaxaPoHAa+TjemH8AZ3pp0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+GCoKxoWaoT/Kbo5LQM+aGVfFXCahxvg4AP3J7e6io=;
 b=HKlPtKbr3mZudzw/jVwu3w0QgOpI/GAOKSqy5M0ijSZk7ZtRWVro9drxyO+/X+LRdEqhumAPGAE+PfPCJiUU/3hJ3qlSMRrndLS/Du06cASOAdk2Tljtzq50dY5zjP3tz/loW8BmYxE64LZFZXvJEj5meweTovPBwoum7lLzPs2m4tdC9VltjEVzQOg56FLqxsIV4uGbxIlOO5Ucpts2NJxzUo34ABcMY+LUKFDQKo1IGjtRRRkwnwv/ZfAI+MCMzIzuV+iP8FTXX++C2gKkqNmyNUNqqoy89sPQso8U6qCJrKwbQN2kxWW4GRJwfCaprOuyDd5iXfiaGc9mPP2fZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+GCoKxoWaoT/Kbo5LQM+aGVfFXCahxvg4AP3J7e6io=;
 b=DUJAOzyzjhK0o94oZrPNT7cgDGEFtsJbB+nkhFrhfIf52zESnZwBTiqt276xmk1ZkaLXm536RZ65a+2TvCZ5FoUKHztJVCtAAyco3fxKVWShr5N4eZkV9VdB184rJK88fcJaJM/qmxD69s6pwQvi4hAtW4XIiv9vYx8JbaboEGU=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Tue, 14 Jul
 2026 20:05:57 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 20:05:57 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Clean up debug runlist printing
Thread-Topic: [PATCH] drm/amdkfd: Clean up debug runlist printing
Thread-Index: AQHdDW0X7YR/1Zrw4UOf1k5iGkPA3bZtfWUA
Date: Tue, 14 Jul 2026 20:05:57 +0000
Message-ID: <BL1PR12MB589858F4A8DA255797CD710385F92@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260706172950.1586506-1-kent.russell@amd.com>
In-Reply-To: <20260706172950.1586506-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T20:05:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA5PPFB9BA66B77:EE_
x-ms-office365-filtering-correlation-id: e6f55b03-ea18-406c-195c-08dee1e351a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|3023799007|38070700021|56012099006|6133799003;
x-microsoft-antispam-message-info: 84dMPO5cwhtfCxZKVBDzjwOSB1coF3z1FjUPygY1d5YLdoQKfDiLeEZqOWbZfTzmxr1vkJIrvgXEkZFM85uhzbcaLDpn5lCav/PqRh78S9Dm/K3EABbm01ohK1aSYSaDQh33ue6/UqzSWLaSmZFb0loRMYSXcmBy2y5NfF6Gs+CjzWEaR9BOIYxrG9C0GB6OrvQ5sggwBCiVfvZ1RhZeBTnEfk8v/YaiuFiBJiOa3AdQiyUD5brCgaU2NrYOpHxoBz6EUcg00/Cs05vnMXfq5gfNXJRQnNFlvejPx8fKRJ+XskDpyxpzFyqfwuEyGKR/aX1L2TqiZ96d7u8NZmD6MgmL92goKK5cp9F478mtYU+NRw2GTN7VziuNk/gQ/ytveqtOeQ4jXTkg2kcS7rqEqLUQIU1L5qRYx1qHZk8jDhOnMuskmFlTfJWH38GZJG7ZpHapk62nmpw7RsWhuE2jo9WPl54CBS2xG7cXBQqs63UL8Nm4Bjy2PhlilkIZlvxm1/eH3kXdHoG8+dGlGVPge9Y3DXh6v+1NrTU692vbvvYfh/VFtbWwUCFK9TPSOuVilnp6/I30uATDB24I0STcjZnyPF7rJqL5lzP+VVNNs7Apr2lrfuTapsR5lfpsz9gVbzgixr4VnHXpAyop0odoW7J/mnSCxVQzNdKsDFagK5wXBR71olIG46zY3OY+yZeXL870hA+UBvjTkkbmdfI2kFJ/YYhTs37QBCsiT/nOriw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(3023799007)(38070700021)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WWB2dXUVYkT3tmrAKTpZn19vKKZ63hz4JbG5hQcAj247vpchyn7ucCBTLjHd?=
 =?us-ascii?Q?xPeOZnfu2WkaReHboYMjGAubLNkP7VmeEDGlVR4qeQEpoL6FcM72yy/g0/bI?=
 =?us-ascii?Q?GhxBjkKbF/Ah6TxXajrZ2fxdDABGiCX2qdewJTdA3HcX2LjRh3hh/G0husuf?=
 =?us-ascii?Q?Gvy5b6sFn8YcSJjbIdtlx/M//9iscLFc3+DfiswkSXavUl5eLcqqvim36Xcp?=
 =?us-ascii?Q?q4lAJqDjAfKHj515oN1/5Io7fqytw95ReK9k8wrE9N7lqCmNgUHT9PBYmtdJ?=
 =?us-ascii?Q?g5255MQq2Bbkb4zKX1tbUGZvFO4m3qlOat6RWLgwDAjqxhp41+eHXO/c+tl1?=
 =?us-ascii?Q?XQ4f3KldXUn0FKzmXoYg4KOi/HaKum08ty4gikU/Xea8N/CKKCBAZIsTZ2bs?=
 =?us-ascii?Q?0TEQC48kUJWbw1VT/IC7TZgKri7KmeqSVMUPC6Lj0yKVPZrELqV4vxOu0ztf?=
 =?us-ascii?Q?115wubh+5pyoLZB77jGoBf4w2Qa+PSwF0A+LT4AC2jyPecC7AWa+V7ka/qjV?=
 =?us-ascii?Q?u+klNpfyoKt64oW96UMIidaCSTfvJKwfI9Hf002o3R8cPUTzg0Ua215CwQMh?=
 =?us-ascii?Q?/HCg2rpoes3a9UspQNboIaJEsKbWEOk+d75BZjvkShpxoSyVvhvMxiwCOMaw?=
 =?us-ascii?Q?WCYgAcYtedUrAbgxs6JLBxghkTukJXGGYk9HTzwomN+LwwblcniPfcSmsvml?=
 =?us-ascii?Q?NYlV9f7R/6IhYYGfY3AZ2Z+3/CI6gYT3fHdLab3SiHUHL/sQR5IrqQRXKNle?=
 =?us-ascii?Q?78T1VIv/kGZNUVMqet3f6WElGAfACHpQNvQOUW2F4mUVbxG39X0Kql1dwVHZ?=
 =?us-ascii?Q?zZXZQjFIFh2/jZtftN004OMfbk0e2jCMac2nqqmclSj+9Gr/JYz7d4X42MCX?=
 =?us-ascii?Q?r1aO7oKtGBSt6zRHflSmhUIPFVQDEk0o8tbW/sSsFtWzZ0iMgt1mm8MlEpmJ?=
 =?us-ascii?Q?Ea7hfZNfaEjOm4KAsvbruXAl09PVd9P7MEYIoEA+NQRTazIq+ekSrPf6C6xF?=
 =?us-ascii?Q?mvUq2Qw+vgfQutJT+rdsrwHwbVwlnEMWkkovrTKaVdAEWJV1TxRho4+5R86o?=
 =?us-ascii?Q?LDJbCma+Dwx93k79Pbf+OYSUnVTMuYejOcYSRzN5Ooj3NRO5CDkWvdWtGiJh?=
 =?us-ascii?Q?M0+tc9pWZENlQpnToBrcvnchb54aiEBHNOnxokY4dKqU1cFuiakuwqAK/9Dy?=
 =?us-ascii?Q?tgb1dY76fkhyh8TkXEh2L57a6Ji5ZnWsYETvnw4hwnHPhVZ6XB2SmBAj+dCY?=
 =?us-ascii?Q?yWanDdBSo7h4fcfuyV6WVTJVliGu54JAyCluHBlSjTPdD6KrP02o4DHYCmUT?=
 =?us-ascii?Q?wvDRnBDWB4q+v1eq6ceGfFJth8TIp74TOr4bzIg4TvE8daSnC77T6WzgbIqT?=
 =?us-ascii?Q?bFrhdFtVo19udW9tTZYIlI2UMvyatMZvkOtCP0EvIu1JAi78XlTdqXzZ/Eco?=
 =?us-ascii?Q?KCTNgMEBvsn4Y7DAHy2LZLhROOElDcKw3FYcUX5ywRFYeyDowGC6CqfGCQUt?=
 =?us-ascii?Q?XlAdcBJbn9O2iYv8/5GPaVA/s1Ktl0dSmnGN00DsnNUf6alk6pEaMgSrD95V?=
 =?us-ascii?Q?3dusrITSRbuHWX2b7dJ6Ve0j8OQdF05Bt3rHmVFr4liyeKIqelr/ziGs44na?=
 =?us-ascii?Q?rBt5dePzXYME9TZZK8VDltWxfs8a9pXnlaPOT7dtU2GFP5ejDLVhFnCWybzv?=
 =?us-ascii?Q?r7gDCbxol2n6JPnx47bv6IOnYRwHLIQaKKjAXw6OVUPFCqFz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f55b03-ea18-406c-195c-08dee1e351a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 20:05:57.5912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZ6u0EO6hilEW9oXnqSPBtjniOW1nbcvv4LX9/cKvnwBBZqSe6KdB49kpJ83rf0pAXrat9UWV0NRHfCgW5G3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77
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

AMD General

Non-critical ping

 Kent

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: July 6, 2026 1:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdkfd: Clean up debug runlist printing
>
> Having single lines with random hex codes really doesn't help a user to
> know what's going on. Give it a title, and print 8 8-length hex values
> per line, instead of a single 2-length hex value per printed line.
>
> Previous output:
>
> ...
> amdgpu: 0x20000010
> amdgpu: 0x3000
> amdgpu: 0x12E6E00
> amdgpu: 0xFF
> amdgpu: 0x207008
> amdgpu: 0x 0
> amdgpu:
>
> New output:
>
> amdgpu: Runlist dump:
> amdgpu:    0: 0xc00ea100 0x14008008 0x0f4fffc0 0x00000000 0x20002000
> 0x00000338 0x00000020 0x00080017
> amdgpu:    8: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000
> 0x03400000 0x00000000 0x00000000
> amdgpu:   16: 0xc005a200 0x20000010 0x00003030 0x012ed000 0x000000ff
> 0x00252008 0x00000000 0xc005a200
> amdgpu:   24: 0x20000010 0x0000302c 0x012ec800 0x000000ff 0x0024c008
> 0x00000000 0xc005a200 0x20000010
> amdgpu:   32: 0x00003028 0x012ec000 0x000000ff 0x00246008 0x00000000
> 0xc005a200 0x20000010 0x00003024
> amdgpu:   40: 0x012eb800 0x000000ff 0x00240008 0x00000000 0xc005a200
> 0x20000010 0x00003020 0x012eb000
> amdgpu:   48: 0x000000ff 0x0023a008 0x00000000 0xc005a200 0x20000010
> 0x0000301c 0x012ea800 0x000000ff
> amdgpu:   56: 0x00234008 0x00000000 0xc005a200 0x20000010 0x00003018
> 0x012ea000 0x000000ff 0x0022e008
> amdgpu:   64: 0x00000000 0xc005a200 0x20000010 0x00003014 0x012e9800
> 0x000000ff 0x00228008 0x00000000
> amdgpu:   72: 0xc005a200 0x20000010 0x00003010 0x012e9000 0x000000ff
> 0x00222008 0x00000000 0xc005a200
> amdgpu:   80: 0x20000010 0x0000300c 0x012e8800 0x000000ff 0x0021c008
> 0x00000000 0xc005a200 0x20000010
> amdgpu:   88: 0x00003008 0x012e8000 0x000000ff 0x00216008 0x00000000
> 0xc005a200 0x20000010 0x00003004
> amdgpu:   96: 0x012e7800 0x000000ff 0x00210008 0x00000000 0xc005a200
> 0x20000010 0x00003000 0x012e6e00
> amdgpu:  104: 0x000000ff 0x00207008 0x00000000
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index b1a6eb349bb3..85bf1790a6c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -269,9 +269,19 @@ static int pm_create_runlist_ib(struct packet_manage=
r
> *pm,
>       }
>       pm->is_over_subscription =3D !!is_over_subscription;
>
> -     for (i =3D 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
> -             pr_debug("0x%2X ", rl_buffer[i]);
> -     pr_debug("\n");
> +     pr_debug("Runlist dump:");
> +     for (i =3D 0; i < alloc_size_bytes / sizeof(uint32_t); i +=3D 8) {
> +             char buf[128];
> +             int j, len =3D 0;
> +
> +             /* Dump 8 entries per line with an index for each line */
> +             len +=3D scnprintf(buf + len, sizeof(buf) - len, "%4u:", i)=
;
> +
> +             for (j =3D 0; j < 8 && (i + j) < alloc_size_bytes / sizeof(=
uint32_t); j++)
> +                     len +=3D scnprintf(buf + len, sizeof(buf) - len, " =
0x%08x",
> rl_buffer[i + j]);
> +
> +             pr_debug("%s\n", buf);
> +     }
>
>       return retval;
>  }
> --
> 2.43.0

