Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA85EC44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 14:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B0E10E1B6;
	Tue, 21 Jul 2026 14:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f4SYbq3G";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0790410E1B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 14:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjUMd9C/PpSAe532Ayw17X2KilqeCl0V09UPmnmx5eNdNO+l1pAoYQaI12+lbePxB7bdLyVLypAEVRZ6nvbJqR3yRb9a8seXFsDI2uPH/Wsrk9bgWV7oc8Y7xlapIYtjAHHnN2UdD5rEvT9p+W+uNfcHHesJT2G1NQlMmcZDzfm3+MmAnBcGFMuhdvt3FFHQ6irELNcq+kK/HGbCaZsoxkHpjQl990r0yEfMMtBDu4ENRhaQyyKLkFR8C8cHK+cRF++ka+/2RYqBi1Mg1jgyC8gnNZgr/sL++7ZMJ5hoKnFzLmaQKrOS1gCy19ORHPrkRRxYTHkB/ph8HAHEfxFeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK+V0dYQIecQ7ySIViCtEdkVXGBK2rNBAMUv6T/gl0Y=;
 b=GgxM6/D0b1cOHd6gbUddroxLj/SbHHayoTf1whT3LqImhI5ok7SLGF/o4EJeFckHKQfkgH9zxesiXBJulGFUYAGJKlMvcV2O9FBLDm8vECiL55JRJvoqxxrRXpA3gIYc/jtOp1QfXbkZXRsm/AeKJcTV85B/E/4VPSThZCdPYU96NjguoUaoNMd87xUe9LSwEuejSgQDALJnNlQrb64xbCQATaQuWiR2WfTJb2nOe+CkbZ+orG1wurev+y0CwjIA88+5b4Qal9n4chFMLPrmPTj6JdrpH4fGAVRERUHj69cI3/Yhp+N6JIlPEYSk8syVNqIL+NqevMnoAf9+1B+BdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK+V0dYQIecQ7ySIViCtEdkVXGBK2rNBAMUv6T/gl0Y=;
 b=f4SYbq3Gh5RSQfX9ldyFuSpIBvYZwGNfVWMOTkNyvWcvV339nUSVsoXzKJ5if0rlwDIOY4IpEZXfA6AFLDxSDIZu2+fnNv1vtOWvgSlqB3gyv82r6PGacDrDqSEWS9CHFgpSmH1uL9VPwpQ1RUu2L3aL9tZCUHXBFwqSsIBD7PI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:04:26 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 14:04:26 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Handle invalid event type in CRIU event
 restore
Thread-Topic: [PATCH] drm/amdkfd: Handle invalid event type in CRIU event
 restore
Thread-Index: AQHdGRY6xnkrq4e/b0mFQpV3WffKtLZ4ASuQ
Date: Tue, 21 Jul 2026 14:04:25 +0000
Message-ID: <BL1PR12MB589874896FE87FE0AF19A35D85C22@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260721133803.899885-1-David.Francis@amd.com>
In-Reply-To: <20260721133803.899885-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-21T14:03:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CH2PR12MB4102:EE_
x-ms-office365-filtering-correlation-id: d2d066b1-c7ab-4a4a-5c8e-08dee730f94a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: AEAddyaFCgphsWsEoEvpGL8jfLfdCc6edY6eSLVAl4XkoR3D4NwWb8Y8jbQ4mu0FMi80ILbOluon6jrI5i9e4c4wnmgfRuH9XTMoBnmgXZ5NZDAiw6g0CaIgdjls1p03J+tiP2MnmIV+YPDofDa5jXQsP40WxILNK8FW+lztSkjHs+jI0LoCCG/1+GyLSYYnUfxrSvBmh00Qv3+/9aQ1l1BzscNd9ezQKp/y92AwHOSOZepjWOnQhBdpuuy1CVk7FhDS8O65eXBLWqSgFxY48QC8fGIgRpb/7wFO9ExsKqEMOFxh0Co81j4cwdHJbnkdcN2nwf4Mv/5rs/jbewzL/+mSOZFiNrflH4gDWTloMfACn4foa57jMBas2N/RMLwulH9oZyESGMFGUzHJg8pmu4rGuvbkcYUTM/Xu48P21XXbdNfOCKUwjZEzPu6jNcH++8bIRjQmrp8q0Z8b/7NIRR9SmE0GOa4xODoKDwXOEhtBOp1aVnRW1l0c8didGa6MSDC8iQV48UlwVdVCxThHbqjQARmIelqfxKFJxe9YxM5vKceJ2u69DZxLVOW2KaRtQy52tFxkJgZYXNJeZra2NlGHBrNBueQpr5J2Eie0ttcaG+hC4VPZ8o16azRvONZNT2Wqiv1dwKrc4LlQPIlIAYnXjvS8X2WJ7FDWSsfAg1cjGZ9D9esnnK3a7/AaXKoueJLUDI0yIWUGHYHjybBU+ZSoxOfTg9Dv8CQmTDnLRiw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/3WUo2VletLuslq/yGs/0Sa8Nd50/OeG6y4MnXoFaj+D+vnxif4hERQHVtA0?=
 =?us-ascii?Q?JMtGp1he9o0agzNMh27+T9cSe4tjM0HE6UGFMpWv3jO2RERbmgAfJL91scwB?=
 =?us-ascii?Q?nEzAXVsAvIBMIDit6D7P/AT0M30Xnfx0/7zoHWMoW6Vrvm0IecbUFz9IkLvK?=
 =?us-ascii?Q?v0rbQjuT53KT/Sg/Z6UPfet7scR5PXHZzOeuCvdGI9cpUDsdEhb0ybscFBKR?=
 =?us-ascii?Q?Cq3QqdqQ3u7mvcSvcHN7PyT6mWYvcHQqP5071Giuk4Ziwv3/soXpTdmJ2swB?=
 =?us-ascii?Q?400mPKuC2dVYjwRF9FwwEgWBxkVPiEueT9Oi+WL9aazZYVKru8FrTnAnHxCz?=
 =?us-ascii?Q?aq+z9Twg864UUXBGWvdmvlkWsLxaFSH1v3qNTrtYrsFgqHJMbXImeje2AJcj?=
 =?us-ascii?Q?yA5kGc7Tt19F8ewm8PdfSvLtl3DIT8wnNY0lRLDElQ1vWP+tzfg98hCOY7/d?=
 =?us-ascii?Q?y2QmCVEiLGgwVa2aXsKYmrO99dG9p33aNqjFVetPP1PBDpDC7wJcQP0VLRHa?=
 =?us-ascii?Q?DMJzZKmynHJ/j+e5cNYpwqc2jVQ4HpnlSicF6t0z6tckUqx/WbG1vb9Lzp9Q?=
 =?us-ascii?Q?DXoL8OfWKeZr7UiBH+2nHxXovSL4Em0Qw4XohFKHbGrUV6suv3hepf9y8iuj?=
 =?us-ascii?Q?cYPJoFpwZl4VLVSe0h4cavXaYZhXTrD/RtX0qPuMPmdJ5bV7OefmzaA+9Vyz?=
 =?us-ascii?Q?y+y7dAUSeWGHn2JR3q+mA8EhoOrsbYUHzJnueP92aPYsHoA6YGVU0oWMGLGp?=
 =?us-ascii?Q?fwAtzRuU2tcO5bTTlKoHcNskEKDhwSltsxGnyI/ocP5uiYIUQkvXNt05wl4L?=
 =?us-ascii?Q?vXdgjF/AxbG5VjK47ydp9gEXs230xSFYTrXjXgt3lvDd4kRV9Cz0G9RL0W3t?=
 =?us-ascii?Q?PkGK4kzHGglTBFYdvDQuKv/IrqY9pve1TzDrlvIbdxawg0IwKCN6OU2oRYBV?=
 =?us-ascii?Q?weiXMipvuuAemyf7i4W2MqW68jc5s+37WN0DPAt19a6BEZhHmX6YYuHQaAcd?=
 =?us-ascii?Q?6xOds1VOEsq9ICv0VRuvPLzwExk6qepQyrbTkz4QzMAD8FLywYsxX5s4yexi?=
 =?us-ascii?Q?uyCQBBA0Wq+Upp4Drb80ongekSwM0at1QaD7cS6QSCTABLv/cdNhV03ztqKG?=
 =?us-ascii?Q?9QfoIzeG/a5klcw/wyhRGRQc42/WfczENGomv8XwSssOF1Fs79cFMnGxJ64T?=
 =?us-ascii?Q?ZIcDlxc5HfhykIyhfSHJWUiyGXxGJ0MBsA8p/rrnWgn8YiZ/2kUKXVUy/80i?=
 =?us-ascii?Q?Q706yTJEbSSb6agQu/g239rjKRC65bNz5CMkDpZ9BP2fIxdeAGuOOF7B1l9z?=
 =?us-ascii?Q?S6FYTvNbTMoLDPEc9Mw33r+gW7V6HSEQjUMvHabCXn5pNaKb+vqrLyQfjxX+?=
 =?us-ascii?Q?6V9npUk6fbP90Jrv1IPj2l/bEE/X0NQ7gpyEZAoj9ZoJIvJN5jMnLzfBVRSB?=
 =?us-ascii?Q?EI1v3/uCHC1ClzaGcGRmwAvAahb11Uu0t3p/qvoA1WcYa+tgjj1rtVXU9OL/?=
 =?us-ascii?Q?BJi6uC9iYb8lVjbb9YJSLFtBRjYYgtj/4QM00d6G9zoLUFm1idVEvA+i12pV?=
 =?us-ascii?Q?Y5/bc42GZkOQZP7jDxmPaj8Mn82Ts23TCO4FFtXesdZB6iYmyNdp2kj2hkss?=
 =?us-ascii?Q?lFPylEi2qfPcgHTg6DFPnSXfzJoblzmpyvwpXIcxiULLTOQ4Ob2aF5VBIhft?=
 =?us-ascii?Q?qj1qwOsWrwIoP4FqyYSq9UjbVM7AmsI+JZU17TC954TL7PFZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d066b1-c7ab-4a4a-5c8e-08dee730f94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 14:04:25.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znpVH6LvkgHZL2uQtW88nrxBOVV3RFESsFGeS7qa6Bz56iAtnygn2WBv7SM0++6KnE6MgeBOjo8j+/2hXDQYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: July 21, 2026 9:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Handle invalid event type in CRIU event rest=
ore
>
> In kfd_criu_restore_event, there was no handling for
> the event priv data having an invalid event type. The priv
> data here is untrusted and can be invalid.
>
> In that case, fail with EINVAL.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index f5fd78f0df7d..9e0f57cfa3bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -452,6 +452,9 @@ int kfd_criu_restore_event(struct file *devkfd,
>
>               ret =3D create_other_event(p, ev, &ev_priv->event_id);
>               break;
> +     default:
> +             ret =3D -EINVAL;
> +             break;
>       }
>       mutex_unlock(&p->event_mutex);
>
> --
> 2.34.1

