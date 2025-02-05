Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDCDC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 20:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BE610E3E0;
	Wed,  5 Feb 2025 20:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMQLKAqG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1F910E3E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 20:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr9EyqTzTSrIT4nCsPZTjvUHjHlilF1KqQ/i8MPaeTfKlYztSerJLIZ4NTqdjqL6SP4pves6XzASKos+8ru3xfxYFLllhY7aSDlE8RYjKZTx+V0AcBPLksDeI62y14wXjW9S5THqdj5ePl1bpMCJW2aqlNoKF6hZ5Lsn48ZoWHr4roLBslj8+dzuKFOC3y31Gznwt0dpdMfY9EkrTU8I6/t+7Af20LLjvvYQ/7OSi+v4VsmJHdylS/0DkkGKr/wiR7ccFP0h06XRzi9+WxV8ofJGvRk6+aGnyWG4uptENB+YyVPSjhguj/gy6s33BipSsaiJyBhFz+Ai/WcgJeEpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AXF9wGnEQhJqcBWre/rpPUg1HYEg1p31qgaTsYKdAc=;
 b=rwt+/I5GG4GeVTrcM5HhTLV42JB2ITK+Bbp+C9grSVs882mIvPzY7nZQyTBS/zkgby//RU1Swkh66wVG3jvkkVbSX2zvJgPf7ZYzUPZgrJQj/lG9mUplMoaZ8DJNovH9UpscVJqtMAtfNoYffyrrTKbbIDZdyPgriiSCUiuQIYiu4v27TaTFrONi22706P4OHb583jA4jWQ3CghFPqtzooO6NGK8sYsoStzGQcILj+XVEGhrTervjwGvrwTzvfWlpAIZy7nL+90Gwqo9JKgNyyGmQIyRr1kNio/fnvv/sjRIEShuj2XYmHql1NCbRdw5XmT5/eUnT+FwDs3moHwpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AXF9wGnEQhJqcBWre/rpPUg1HYEg1p31qgaTsYKdAc=;
 b=DMQLKAqGqUx36KSAEKfTIJaplmV+YJ/D7VbH+aKcZe8bWiZfyaGYs9QxvGkDsy2tKyoJEucQh5lKL9LqKHRhBcaH88K7qioYiVedS+TCIIP5l7IdGddZkodkNULRUcS/O/PR08/4Z5wJQBVxUdA+GB2h7srclH53/1AQ9/k07bo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 20:19:30 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 20:19:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up atom header file inclusion
Thread-Topic: [PATCH] drm/amdgpu: Clean up atom header file inclusion
Thread-Index: AQHbd6K1J9xqwrnpkk2rJxr0JaKFj7M5JyOs
Date: Wed, 5 Feb 2025 20:19:30 +0000
Message-ID: <BL1PR12MB51449F4A93C5217F777BCF70F7F72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250205075044.1896764-1-lijo.lazar@amd.com>
In-Reply-To: <20250205075044.1896764-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-05T20:19:30.200Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB8175:EE_
x-ms-office365-filtering-correlation-id: f9977048-a1f7-4777-e2e6-08dd462265d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?00UMe2cVi1WYPVzIBSRK2xQ2CIR8WCmtIrXbdIoeQbMf6tCKK/aWasx9OygA?=
 =?us-ascii?Q?Iyz3ZHPyudXD9vREvVYq87so4Z2garDLen5l0JQby9DkeJproSmVVRxhpEAL?=
 =?us-ascii?Q?HDLF8Y/PgDYOmTGu88nl/Kw4GukqQJyveELqzHCBHS8kaqGdYyu65z8OR4BA?=
 =?us-ascii?Q?Uc5Kdjy4AmMX2+acc9gKwMhvBEn0/qdAff0IcF8RTRFKc/F+6qMi2zO/ssBb?=
 =?us-ascii?Q?Axzx6qTPw3Bfzt+pCeA2MCibrOhCQzVIOA50TVn+h5+140WiQMbOcoVGQRDo?=
 =?us-ascii?Q?8HQzJXoabINQJHsRMP1UDJlaclnBASVqc/Cqcobg5C8QRr4Rks29ReyCDRe+?=
 =?us-ascii?Q?MVsHxXNrtn+l2HlOwMe0ADtj+RTJB5NP4zxhvcbT3M1E0q8WDqZ6+UviMY/+?=
 =?us-ascii?Q?b2zxzdnfOFqvjqowTL4xTruUQcDDUVyczaBHgsatr7ePktpHkioS4Km4kiaF?=
 =?us-ascii?Q?cvY4h2oCevQmF0jRnxclzmVFbmQ/rWGmYz4Fnt6A0zbrfrEl6v2gRljJIXcm?=
 =?us-ascii?Q?91xSh8Bdqof1IAXiWbzmfQw/mUXyurncJDZwgdvlr7PQCydnNgVknhtb28AX?=
 =?us-ascii?Q?fHjAcI6wrsrvUamLq3G6yDhoL9Uzu8beWzUuWPAEAt32DDz6uYujyP7NDpPO?=
 =?us-ascii?Q?wjRTOCNMCMwohlpUW8CPQ51M9zCQ/OxNkd/m4MdT5gl5sXZh2PPNFwLkKRP2?=
 =?us-ascii?Q?XKJJ1PNDY6I1XF+AnjFS38+ccSj4u0d5kpwGIf4kmGXy+1ApXSd8w+wGYwwZ?=
 =?us-ascii?Q?hueYJZfOzJZaiy+oL83luN5gmTgSMyJi1dcJbGykAOMoLaJsk9JVPlyemhYj?=
 =?us-ascii?Q?0CcSsT4mzd08weHibUHL63o5kNInW2cPm2pBsXDPX5Azae+FqVxm2Hbn5zPH?=
 =?us-ascii?Q?ncQqLH+tvy+NbLYgoNeOg8H1AkkBTtvtef3oz80cnGwBq69+wXzKRSG18Ksu?=
 =?us-ascii?Q?AG2NR2dQdjjt9U0NRxAt9bchSEgj4Mr5rG85WRCIPpH2nMT7VkXDKe0Y5Tqv?=
 =?us-ascii?Q?0DkTuVKQCV00+U07CmUww2gixun+jrBTuHRspOyVW0VzuTjGZZIfxf/y7pLw?=
 =?us-ascii?Q?+5GakJ6bmxatpm836wxxuNXMshpZ+CdKfRMHe9buP++5BjwvKH9zr4dA3PBA?=
 =?us-ascii?Q?inluTo6UTwKI//5LuX7C6GmwRnyxxUaSMTqMSVQYlxJdWX0OJkz/eEdV5aUy?=
 =?us-ascii?Q?NePIM1CC2pEZbpkJAGSfjNzQfDimW36nN6KSNfa99Fn6RyeC6WxUhaX5IC2T?=
 =?us-ascii?Q?PetmRbBUsRuzDubOif2+AbkWfjWgHQATDZb8ilAKr/lTKJKhb6cTLJbHXr1L?=
 =?us-ascii?Q?0IdXjvTOXxjRVExiqwY8ydJCgkC2i96bHvC88fCXZ+0RXhAtOEXfjQAFtmzh?=
 =?us-ascii?Q?PaW6LdAPbL32co3xoB43nhVaNXXrxS68exEzcP8LFApkCitfok7dwJPumemg?=
 =?us-ascii?Q?y/V6jh7+iGkuUPZW/d5SXdI3L5qwQ5ri?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qht0Lyx7SMVKsOzn2ZHn8z1E+IiZB+ADtiYFx4IyDdAlO+Pin62b58I1wpXm?=
 =?us-ascii?Q?FrRas4XNReEgDpYxT16Wqwkr3BjkQ/MweUatsVuIz6o/ovKy2pwKoz2MjgJm?=
 =?us-ascii?Q?2nPCmE8K3eZOti4twTc1uIvH0OtdBASE9EVuWm8dSh9bAeoPFl03cRD2Pwav?=
 =?us-ascii?Q?KLVlGY7C9AkkKhx6BTt4QVn2vIeQNy9KilhqapsyHDn9oDkyItpB1md9WFJK?=
 =?us-ascii?Q?L7a4+d+pkRVZCVWRHDqdafDk9WPxS9QYDEjgotg6GfCGIIGH+I17GvzdFG4C?=
 =?us-ascii?Q?e1aBLrPKP2qPZaSNWb4BO3PzAVHBZJ6ZUNP0BO1DlgXKz4IzBZBRt8uFIOBX?=
 =?us-ascii?Q?RBXwSQiQKn6BDNYWZg2Ki5iMzRyqT3n3BebDqUnstHEBxASc1RieLDSPPVIH?=
 =?us-ascii?Q?eiaVP2FQ3u4baPbzr/DqATAPLaxSJHXOl0WHfHOg8Z00eW6Gadh40cZStw69?=
 =?us-ascii?Q?4MScuqShV5XIeMs4StOICgMza87UEWMgxKd4/eS2cTOyDD/YqbFvhyzscwOI?=
 =?us-ascii?Q?0T9NznFa2uyxQs8kY+n+9O92UUx5UIj2ZkLOxDgbPk90QHiwAZRZw3vkkpcy?=
 =?us-ascii?Q?gys+5i8ZZZWnvTWtXF1TEq5mT/CdjSBfLaCa/X+XG/Tl3rdj20scIm8jBXa4?=
 =?us-ascii?Q?6gd+64kmt3kTI/fOeHwulERpKVJD7qzeJ7ehLEvaSJUbsr3qW+yGbCC8lBXs?=
 =?us-ascii?Q?SaSNa32o7hQWrNRLD1WNNCC1xPm1YOvFHZfgG8BF49jCaQtVf3MoAdMtFM96?=
 =?us-ascii?Q?YJbGV3d8KMRQIiHhOYELtlN+IR1kDM9qWKR4NkNdMM59Q9jn8/z9rLtxmL/n?=
 =?us-ascii?Q?/wBZFU/0bIiUfCXPmSPRmxvUax/EQRFvXrVADuGa4bEgxgK6D7XhJsi97FKa?=
 =?us-ascii?Q?u+hnkmqmdLE7Xz2aPCu5LXK0iQfsVVrGJDu4Uy1sAPLxuBVTJ5uoeoTN0mi5?=
 =?us-ascii?Q?ZlEzsmooj0/V7mwFfZJir+LM/tJoywRVxEA8ASQr+2zNN4t7QaqoA3X+7jXh?=
 =?us-ascii?Q?94uaQZBPYqB/aknwH4qy9nkbRFncOSaDQ555yo9c5td2HMSt/e0BKIwaDVn9?=
 =?us-ascii?Q?eR3ODNXRaurs4i+zY18sdOKyzEtsH9otbw3FT8+D8OFvq7Pq6vhlaLXjjqrE?=
 =?us-ascii?Q?y/fk+PmAtwHgLu0r1KdcUWF+05x3YCm/m3hAbjp/YohLVNH6pkCuTVvgOK+e?=
 =?us-ascii?Q?Z0VkL77c52XM+omTGPZk5aea/geCpok/Ys/8wQq08IWbrR1T2uxwBfC/rBP5?=
 =?us-ascii?Q?oBTVtuBV584slwApiRC2SNhWe1yG/1puDbmLL+7CpCC4me4eyhdPR4ujJeFB?=
 =?us-ascii?Q?3sd1VgXgcypqEhTRe0rKPyPO2kGFRqG5mdImRNqzOuIf5nX6p8/Z73iUw9Qj?=
 =?us-ascii?Q?UtuMxQIanpf/K5vL9BMYrg3eQNwTxDhnwgQwn4bu9DJ3VZk74Tdcbx74s5NX?=
 =?us-ascii?Q?nYZym14cWpuZ0HrZNbUW5rPGHzD/1cqPX73Bh1OTxsBGH7UGV9EfJTIS6fmw?=
 =?us-ascii?Q?sX9tb5Q61xM4IFc0dOdv6NnTT9lTgP5cFHetTlKOfAqIaQdzQcNw4KixbfF1?=
 =?us-ascii?Q?CR9+1nrBoDp24FBENug=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449F4A93C5217F777BCF70F7F72BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9977048-a1f7-4777-e2e6-08dd462265d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 20:19:30.7718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJaPRfwlHZhi7TcDMU9RPkvc3iBN0bHJ9vWBNk8ZN5d5bvIsFyBpM7MyQQp/2M8uiiAGxg8cvuL9ESmBqMMuXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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

--_000_BL1PR12MB51449F4A93C5217F777BCF70F7F72BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 5, 2025 2:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Clean up atom header file inclusion

atom bios header files are not required in these files.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c           | 1 -
 drivers/gpu/drm/amd/amdgpu/soc24.c           | 1 -
 21 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c
index ff5e52025266..6da8994e0469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,7 +28,6 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_res_cursor.h"
-#include "amdgpu_atomfirmware.h"
 #include "atom.h"

 #define AMDGPU_MAX_SG_SEGMENT_SIZE      (2UL << 30)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 89d17750af04..aabc5bacd154 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -29,7 +29,6 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
-#include "amdgpu_atomfirmware.h"
 #include "imu_v11_0.h"
 #include "soc21.h"
 #include "nvd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index db5cc060de85..638507422f9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -29,7 +29,6 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
-#include "amdgpu_atomfirmware.h"
 #include "imu_v12_0.h"
 #include "soc24.h"
 #include "nvd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_4.c
index f53b379d8971..6028afd81690 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -27,7 +27,6 @@
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15d.h"
-#include "amdgpu_atomfirmware.h"
 #include "amdgpu_pm.h"

 #include "gc/gc_9_4_1_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index 194026e9be33..f1dc13b3ab38 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v4_0.h"
 #include "amdgpu_ras.h"

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v5_0.c
index d3962d469088..43195c079748 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v5_0.h"

 #include "hdp/hdp_5_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v5_2.c
index f52552c5fa27..fcb8dd2876bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v5_2.h"

 #include "hdp/hdp_5_2_1_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v6_0.c
index 6948fe9956ce..a88d25a06c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v6_0.h"

 #include "hdp/hdp_6_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v7_0.c
index 63820329f67e..49f7eb4fbd11 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v7_0.h"

 #include "hdp/hdp_7_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index c92875ceb31f..9900fe5c3bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbif_v6_3_1.h"

 #include "nbif/nbif_6_3_1_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v2_3.c
index 739fce4fa8fd..04041b398781 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v2_3.h"

 #include "nbio/nbio_2_3_default.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c
index a54052dea8bf..f89e5f40e1a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v4_3.h"

 #include "nbio/nbio_4_3_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v6_1.c
index 34180c6070dd..e911368c1aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v6_1.h"

 #include "nbio/nbio_6_1_default.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_0.c
index d1032e9992b4..1569a1e934ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_0.h"

 #include "nbio/nbio_7_0_default.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/=
amdgpu/nbio_v7_11.c
index 41421da63a08..2ece3ae75ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_11.h"

 #include "nbio/nbio_7_11_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_2.c
index a766e2d90cd0..acc5f363684a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_2.h"

 #include "nbio/nbio_7_2_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index a26a9be58eac..d5002ff931d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_4.h"
 #include "amdgpu_ras.h"

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c
index 3fb6d2aa7e3b..2ee60b8746a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_7.h"

 #include "nbio/nbio_7_7_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index 8a0a63ac88d2..f23cb79110d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_9.h"
 #include "amdgpu_ras.h"

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 0e1daefd1a8e..6f8d867b290e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -28,7 +28,6 @@
 #include <drm/amdgpu_drm.h>

 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 6b8e078ee7c7..69c5c8769395 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -26,7 +26,6 @@
 #include <linux/pci.h>

 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
--
2.25.1


--_000_BL1PR12MB51449F4A93C5217F777BCF70F7F72BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 5, 2025 2:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Clean up atom header file inclusion</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">atom bios header files are not required in these f=
iles.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c&nbsp;&nbsp;&nbsp;&nbsp; | 1 =
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc24.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 1 -<br>
&nbsp;21 files changed, 21 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c<br>
index ff5e52025266..6da8994e0469 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
@@ -28,7 +28,6 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_vm.h&quot;<br>
&nbsp;#include &quot;amdgpu_res_cursor.h&quot;<br>
-#include &quot;amdgpu_atomfirmware.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;<br>
&nbsp;#define AMDGPU_MAX_SG_SEGMENT_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2UL=
 &lt;&lt; 30)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 89d17750af04..aabc5bacd154 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -29,7 +29,6 @@<br>
&nbsp;#include &quot;amdgpu_gfx.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
-#include &quot;amdgpu_atomfirmware.h&quot;<br>
&nbsp;#include &quot;imu_v11_0.h&quot;<br>
&nbsp;#include &quot;soc21.h&quot;<br>
&nbsp;#include &quot;nvd.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index db5cc060de85..638507422f9b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -29,7 +29,6 @@<br>
&nbsp;#include &quot;amdgpu_gfx.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
-#include &quot;amdgpu_atomfirmware.h&quot;<br>
&nbsp;#include &quot;imu_v12_0.h&quot;<br>
&nbsp;#include &quot;soc24.h&quot;<br>
&nbsp;#include &quot;nvd.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_4.c<br>
index f53b379d8971..6028afd81690 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c<br>
@@ -27,7 +27,6 @@<br>
&nbsp;#include &quot;amdgpu_gfx.h&quot;<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;soc15d.h&quot;<br>
-#include &quot;amdgpu_atomfirmware.h&quot;<br>
&nbsp;#include &quot;amdgpu_pm.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;gc/gc_9_4_1_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c<br>
index 194026e9be33..f1dc13b3ab38 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;hdp_v4_0.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v5_0.c<br>
index d3962d469088..43195c079748 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;hdp_v5_0.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;hdp/hdp_5_0_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v5_2.c<br>
index f52552c5fa27..fcb8dd2876bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;hdp_v5_2.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;hdp/hdp_5_2_1_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v6_0.c<br>
index 6948fe9956ce..a88d25a06c29 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;hdp_v6_0.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;hdp/hdp_6_0_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v7_0.c<br>
index 63820329f67e..49f7eb4fbd11 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;hdp_v7_0.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;hdp/hdp_7_0_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c<br>
index c92875ceb31f..9900fe5c3bc3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbif_v6_3_1.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbif/nbif_6_3_1_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v2_3.c<br>
index 739fce4fa8fd..04041b398781 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v2_3.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_2_3_default.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c<br>
index a54052dea8bf..f89e5f40e1a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v4_3.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_4_3_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v6_1.c<br>
index 34180c6070dd..e911368c1aeb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v6_1.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_6_1_default.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_0.c<br>
index d1032e9992b4..1569a1e934ec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v7_0.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_7_0_default.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/=
amdgpu/nbio_v7_11.c<br>
index 41421da63a08..2ece3ae75ec1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v7_11.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_7_11_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_2.c<br>
index a766e2d90cd0..acc5f363684a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v7_2.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_7_2_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index a26a9be58eac..d5002ff931d8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v7_4.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c<br>
index 3fb6d2aa7e3b..2ee60b8746a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v7_7.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_7_7_0_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c<br>
index 8a0a63ac88d2..f23cb79110d6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c<br>
@@ -21,7 +21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;nbio_v7_9.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 0e1daefd1a8e..6f8d867b290e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -28,7 +28,6 @@<br>
&nbsp;#include &lt;drm/amdgpu_drm.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;amdgpu_ih.h&quot;<br>
&nbsp;#include &quot;amdgpu_uvd.h&quot;<br>
&nbsp;#include &quot;amdgpu_vce.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c<br>
index 6b8e078ee7c7..69c5c8769395 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c<br>
@@ -26,7 +26,6 @@<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
&nbsp;#include &quot;amdgpu_ih.h&quot;<br>
&nbsp;#include &quot;amdgpu_uvd.h&quot;<br>
&nbsp;#include &quot;amdgpu_vce.h&quot;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449F4A93C5217F777BCF70F7F72BL1PR12MB5144namp_--
