Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720D2C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 04:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14B210E352;
	Tue, 15 Apr 2025 04:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="elLDOB81";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB30C10E352
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 04:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfQR1I5ShaZhEoirOGiktGTOY3geROOx59nMWJi3Z/y6gDjAT9T50EV4q/DgSzCtjJ2xRVq/dPV1Sxs/G7MoaQqEW7ai2+9Lme7+/yM87nPVsx+EqnN2pwS8AJuw0KCVSXcUrBNSmdDetLTa1oiCzSzlADBOWEaUFpK7eGFhZxH1ZfrPA/LppuidHcnUA13r8i24h/KNPagtl9xWhjA6WH3LMVpPysQdLXe+9LODXLijIVrFKAYzAG0KZliHeYI1+u4DQLmNJsz/CarRXCe4SVWcCfXl5fz+IcBKjvcDLdgu0YJ8n2/0KHSAEbSHL4nm1mTRTJBKgJrfGKJ99sHSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEDhObxOTLnhdqhqhtwNcDXjw1rDuAVn6dkgd+UuD78=;
 b=R/5uVvs9OGB8DX4Wg53SGsAjyZnzj/vlazh4L1xrO5dJLoDY2OewfUcrLHPRaVh6edmMRg9TxqedKbewcsBJS7ec9tsCfbop9ttB5hCDRVZuh1VzjidaB0wfUcdBILyl2uVgk0BDvwlvQGOAZUiyq/0ZINi7C8+doy+F2A3azCGdfS15hUD5hRTM7A6QvG0zhxIe+0uV2KcHg06kGc+QJh4stggZqgNIg0hLVOyjidGaeRAur0xlUNBjsG8qWDBLCTFjBSLuGGxEXQty4ZSLpN1D1aOh4WbOXY28XgEZxGmuRTdIqXoE4EBFDv/WkPugbSctAdKCbuRh//Aymcc1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEDhObxOTLnhdqhqhtwNcDXjw1rDuAVn6dkgd+UuD78=;
 b=elLDOB81TeNYkrKMyXFxIvCVf07sUWSzm9gAcbLav/zjzRfpNe4oD613apiLE/U2w7v0YsHQZ21yfPsDPSnkUwNfBq7bX6vZDin3mYBJJ8NZHokLni9xQVuZedRjUa32JeLARQ9aysKFmdzAVtxbjAZGA2dMtDIMls75Zx2rtR4=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 04:07:20 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 04:07:20 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Clear overflow for SRIOV
Thread-Topic: [PATCH v2] drm/amdgpu: Clear overflow for SRIOV
Thread-Index: AQHbraZJOtt8SBT0yEudpxbNgqLMhrOkHGyg
Date: Tue, 15 Apr 2025 04:07:20 +0000
Message-ID: <PH0PR12MB5417962308FEE5DFBD46733A8FB22@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250415013232.1105469-1-Emily.Deng@amd.com>
In-Reply-To: <20250415013232.1105469-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=36356bca-0b98-477e-9df8-c339dac23702;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-15T04:07:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH7PR12MB6737:EE_
x-ms-office365-filtering-correlation-id: 571985e6-d849-47df-4c8a-08dd7bd30484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QAaS6VNM7KdXeNbCrwpQ0L4tWBT7UiuDGzjp5XO2d9ChGvcrTZRyEPxUqfHT?=
 =?us-ascii?Q?lw+l/xTTvVtHH5CWjMx5+cxaY7QSr2+bKr9IDrp9yns9kSpZw/NFwL2nnjWR?=
 =?us-ascii?Q?xtHkhHKHq/Gtnwp0rmQcJQC7YFRdsrxpO13rJEHMfo/6aH4VVBdxvB0Xqz91?=
 =?us-ascii?Q?Bc3R7TRGqC1Vv6pwga60j/FlujFjeLVufV/sH44Rd7YVDw9wS9kAsSvftqW1?=
 =?us-ascii?Q?p9jnX4zwYhXPuMx+sXF8Qp1GkKUrv1SxLV9QPwnyhG2+4FE92HQQQVxmHCzl?=
 =?us-ascii?Q?YMovbWRlnx5uXRunh/r2/hx9wRwtSsl/Glv1X3S6/FZh+tYc4NDwew6fn2QW?=
 =?us-ascii?Q?4vlJgtspWAXNP+fG1/aEaf0A4q0bJxLc1eeg2yREE1ZTepHwoRn/H87aT8CN?=
 =?us-ascii?Q?t34LdTke1MwdvrdmaiaUzGeBW2BGASdRzeFzHykSZseY9lOP83+rpxKGF7XB?=
 =?us-ascii?Q?a0Y6X4zD6LU9+1lWfhpkS139C1TpTTEWffIfQSZtoFXRYtNLaa8M419IMhp/?=
 =?us-ascii?Q?eTvCM0botPXS3pDFai3W/tulVA60qZumbHOuoKnQ055MOMCAv7zol5sXDtpM?=
 =?us-ascii?Q?0p0rBwORrfv5QOfDEC+ZDJlhOa150eGApU/U1hmHj+YHR7EgP/lPjIwUyDUA?=
 =?us-ascii?Q?Ke9UEjxGlYuDShdXadkeTMxU+tPlSwOOfTPfojc2If6zh3R+ro6Hzmt1MHJa?=
 =?us-ascii?Q?ra2uceeqI9Vsch2tJxNH33gIyz/QSYpHrSEHnzPewmpcBYUVtuj+L5AoYkGn?=
 =?us-ascii?Q?np4/yDdpx9C6aokghHxSnfUw0qtJmjVR5iMRAyExsSa3g5RMezlzTUvxyLOh?=
 =?us-ascii?Q?jgZp/mSuIuUabHkmr4JN+ZV/adNV1vdCEwSVrz08usYbP0G/m+3Y9UQrpBmB?=
 =?us-ascii?Q?hMwQoxV+jnOHC+cXFD/7FAY67A5+QXUR1cYg1uS7m27Wb5Jw8JdN4VGM5RZd?=
 =?us-ascii?Q?FBybEVEi8TkJylkZnGCrE2s9jUaBAQaruZAd+Me0jKurQSonx6tUM0n1RE87?=
 =?us-ascii?Q?vBAjWnY8+QOrAPWLd15d5I+96r8z/s8KUUT4SZj04tPfQkr/Tk0Imnz5/GRK?=
 =?us-ascii?Q?vejQamubHLWrYQE1tONmerQ0FVRaEfH8ior/GY007hYRyEG+++HxaK7xboih?=
 =?us-ascii?Q?O4nbQiufEPKuxwrxk7EUTVWNwU2edOOe/hmeqQHj5sxPpUH0YHinepY7T3zy?=
 =?us-ascii?Q?RBN0FxN4U52pJAalS/6W/W9StbdXRb/+NOXrbhZ7mbf3ONQ6ZoaJOgZA1M//?=
 =?us-ascii?Q?DGGxCpyHgkt3jVXtPVv1+3cgtWf+1nYLSEuSNtTaOK6NHV/doBIhMNviuSUF?=
 =?us-ascii?Q?B5MlVJv6mImarM0zMryoAD/NHvmdKncYhzjn5/eVWBAKrJLXj2XH6Y3X5TtB?=
 =?us-ascii?Q?n8XEerK/KIx3f3B2WVBbbKMufX22yJ9Z4DcJXB+2jn/aUDvfJKuWLwPpTXGf?=
 =?us-ascii?Q?wbqXMUdvWggesIHfYAq/tWq9q2IknwVUdqR2pWxI6p4zwtJoE292DFDri1qb?=
 =?us-ascii?Q?WMyS37kZ1jWG7+c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qDkUWPfnJ3BInbd+ZIddkCLhY36FSKQ3duFSbuQgOOrJtG7+lTKxwjbxGHGC?=
 =?us-ascii?Q?jpKZLNa85ZRAlltd5nTojAm3bzkIlbjn8eRJ88NQa/7GRyIqwPoQpGw4guNB?=
 =?us-ascii?Q?2ogVXaoTRdMPPXsZFODf1rS+qXK7pOepGIdVtgHVrDyYtjl1n/1L7KYIYolY?=
 =?us-ascii?Q?VlfcTh266lFcSmFSvojjIg7NkZKNcJAdHyyi2SFl6N2IwxfmSg8ZLz442VoG?=
 =?us-ascii?Q?L2vaiPfN7eEDVhig0KvABy++Q3m2vrxE1lJ5FXtofcP86a9VtUIjo70lJGJ8?=
 =?us-ascii?Q?7qvzfXBRJS/MCxqcDQBsZvKGlhyBlLjpAMUf4l7lk5yyyEOpAoYITXDlnJRc?=
 =?us-ascii?Q?v0XT4hiTKJz83YKBeCl/fmwbl7j1q8VMa/Txs+GVWhITYb8j0CX18b0KQbRS?=
 =?us-ascii?Q?dDpTL+6acuz1venOsNMiQ455GE+0283euP/2/PcZugQVQeU6F2SFHmxVN22h?=
 =?us-ascii?Q?550V8Xm8HOS8RsEwSjd7dzSThcKzDeZ3uCyJse87lhveePiroUw9OkJa0i6k?=
 =?us-ascii?Q?l2Hylg1VUbLOGFuvcwmuCMFBenumc5/SSLE9lRN4AAfYXckt45Im4VuFUWAb?=
 =?us-ascii?Q?1fwW+WEmS1w5ysfIYA51UJRuI5Beq3266eUGq47QJ+kE4oZkVkpk+KueDlwv?=
 =?us-ascii?Q?USTmyjDuyRkp5wC8O+d0TdqfQiQxHpaJGpPNLjCROgOu9MNiUIVI81Ihlf9X?=
 =?us-ascii?Q?LnXccbkiKGuGTE8BFGmWn84g0iymGpITXyzDNOvmh+ON3aIAA+msLIlH6gfS?=
 =?us-ascii?Q?kApqD/pb864dP5Cw5Z2zBxHpjRo0gtEqIuTyX6Uv3ovm3TOUiZ8hU4yjNJzC?=
 =?us-ascii?Q?OTFhp5Th72cSBZ+gIqNDQusEFajJdixEb+fPvX0xOgc3RNvmiyicdHKc3tU0?=
 =?us-ascii?Q?i/efNFAQFf+xoCbY4qajcNWYbZ6w0dYF0mSic064X+Zy4kggQ2JxfrYXiFF6?=
 =?us-ascii?Q?UnR1dANDHaWkLTMKj/fxOppgWJZ+Am4/io/4NZi4PLk5dexLOMZdt1539ZNR?=
 =?us-ascii?Q?DLFBCb9ndT/wcRU8LEz5EyloneH/Rl5UmodpI3rRM2gxVX0SNi9RGQZPmRWz?=
 =?us-ascii?Q?6422KPiYR1Xkjd2NA7Q9sbPpWU3uf6Gg6jPs69WQptfg/lWbwKo8qUPzSRzE?=
 =?us-ascii?Q?r0qdLXvrF6/l4plvKtLgzS6/NWrsEdkHGyalS5eca5TIOoyGiUarFVIq26iU?=
 =?us-ascii?Q?PITih7fwsR4Om/rftgBU7egRmt3tHLisQmYwpxnaqE8TIVq6WM1QlDj2PL85?=
 =?us-ascii?Q?6OIChG9+SSSvn8FTLaBrM5vDk0aBd2AWpZg4lbhY9OdOilsGjfGaty/SvL11?=
 =?us-ascii?Q?dIXHvvsekiUS3aWIykOECgEVnx5g6YqMpkP+81yAyFd2ukxOqKHtR3lxjpLM?=
 =?us-ascii?Q?/O8/jq5dF+cG0oHHC2rMENtWezOCKTEGSCxmTnjP6dQdhh8nEy4nXRWz5hnl?=
 =?us-ascii?Q?zMfH3yh1Jcp5oEOnpbbjtUaa7ssLJ9pnOOkd0tLBkRJHkteso0RKFZf5JLxa?=
 =?us-ascii?Q?O7Y0kWy/AtJlnNvg7qemKgOTD49vbHHpaV+KndmupOOpJ2FsNslNIN9czXGz?=
 =?us-ascii?Q?tmVlVak8vECOF5QOLCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571985e6-d849-47df-4c8a-08dd7bd30484
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 04:07:20.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZBl7mOjsOKzT2UB02TUy1Wlcym/a0LRtUEsBMlH95QXLNleJ1RbjJ9zMyZzGBFz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, April 15, 2025 9:33 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v2] drm/amdgpu: Clear overflow for SRIOV
>
>For VF, it doesn't have the permission to clear overflow, clear the bit by=
 reset.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++--
>drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
> drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
> 4 files changed, 24 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>index 901f8b12c672..30f16968b578 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>@@ -25,6 +25,7 @@
>
> #include "amdgpu.h"
> #include "amdgpu_ih.h"
>+#include "amdgpu_reset.h"
>
> /**
>  * amdgpu_ih_ring_init - initialize the IH state @@ -227,13 +228,23 @@ in=
t
>amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>               ih->rptr &=3D ih->ptr_mask;
>       }
>
>-      amdgpu_ih_set_rptr(adev, ih);
>+      if (!ih->overflow)
>+              amdgpu_ih_set_rptr(adev, ih);
>+
>       wake_up_all(&ih->wait_process);
>
>       /* make sure wptr hasn't changed while processing */
>       wptr =3D amdgpu_ih_get_wptr(adev, ih);
>       if (wptr !=3D ih->rptr)
>-              goto restart_ih;
>+              if (!ih->overflow)
>+                      goto restart_ih;
>+
>+      if (ih->overflow)
>+              if (amdgpu_sriov_runtime(adev))
>+                      WARN_ONCE(!amdgpu_reset_domain_schedule(adev-
>>reset_domain,
>+                                 &adev->virt.flr_work),
>+                                "Failed to queue work! at %s",
>+                                __func__);
>
>       return IRQ_HANDLED;
> }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>index b0a88f92cd82..7f7ea046e209 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
>       /* For waiting on IH processing at checkpoint. */
>       wait_queue_head_t wait_process;
>       uint64_t                processed_timestamp;
>+      bool overflow;
> };
>
> /* return true if time stamp t2 is after t1 with 48bit wrap around */ dif=
f --git
>a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_=
0.c
>index f8a485164437..8d3ae88b96a4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev=
)
>                       if (ret)
>                               return ret;
>               }
>+              ih[i]->overflow =3D false;
>       }
>
>       /* update doorbell range for ih ring 0 */ @@ -446,7 +447,10 @@ stat=
ic u32
>ih_v6_0_get_wptr(struct amdgpu_device *adev,
>       wptr =3D RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
>       if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>               goto out;
>-      wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+      if (!amdgpu_sriov_vf(adev))
>+              wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+      else
>+              ih->overflow =3D true;
>
>       /* When a ring buffer overflow happen start parsing interrupt
>        * from the last not overwritten vector (wptr + 32). Hopefully diff=
 --git
>a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>index e9e3b2ed4b7b..2ad209406d17 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *ad=
ev)
>                       if (ret)
>                               return ret;
>               }
>+              ih[i]->overflow =3D false;
>       }
>
>       if (!amdgpu_sriov_vf(adev))
>@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device
>*adev,
>       if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>               goto out;
>
>-      wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+      if (!amdgpu_sriov_vf(adev))
>+              wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+      else
>+              ih->overflow =3D true;
>
>       /* When a ring buffer overflow happen start parsing interrupt
>        * from the last not overwritten vector (wptr + 32). Hopefully
>--
>2.34.1

