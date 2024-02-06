Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC091C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B47112E75;
	Tue,  6 Feb 2024 21:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Al0TGvUv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A15F112E75
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvj7SCBVsxnMis9gSBeBpHQg5Sc6LR0AX5LmdCwuvxr137AoUhkzVt+0xrv18hKUqbiuFsRBlUds0wHg1VbaDw+1dPaSauidoEl8SNzxEVCZ5F8msmGODsE2pXvDUBMxkO+SK55AZ2ivtRbom/hPQ5GdLrN0J8bmKz4ZZll7KeHnNQWwUtWjoODVSTzbJbTdKHs/udC5d3aBg1CKBJ28s8+4TOFkK6GyPRkq/yZALwFLgZvAzc2doZDRlzoLAmBqn4vmnX7OProQvjdRPEs7LfNJS6PIKkltLROfvXqK0ctxorsDfQ57uK+Uoc74nEWXb5Xe5H6GQo9kb7nTOisz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0NGccpwzdHAWbi9aJVimJJ+Sg9y7rqpWcKHfDh/++4=;
 b=hYlmx5Kti/p+A7v6WhV9U0RYLLPv+uMW+eEa49CDLOFWzWiI//xXzgbXypwgqox74QKvyvjMhLKXlVxIlviTntYRuepjUu7h61QxsZUWVOzER4lguMFs4oL1wjXzCWyC3SHV03GC/9wQkEosZuEvj60K8KsWbQiImpgP+DtFlmOIrJeJfGmekmkzvCVlHrXcUmybAhBvsnsIhuRV47S3WKx7RTe9NCKnsWOaMXTnFSazq86LVdIaD5Vwe5po0dU8ODn4BcnTShIFerY18eb6IF/qaiFs4Pg0UF2NqsrY4+sI2wNSffCqTC82FjCbgCnqI+X9cSxAulFnh2x+4mEHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0NGccpwzdHAWbi9aJVimJJ+Sg9y7rqpWcKHfDh/++4=;
 b=Al0TGvUvyiZAhQuWQ4Po0HhQOH7rl0m3y14YlWpG4wD1zbvHwQgLUsO9LH8N5cAm7xaC8Qq1oQHDx7xf0BcmM4e+SHD3lDn74CQ5h8WSmvdi1ghX7QLxeawWaxGTKLw8MWIx1+Qhd+YiceFthCmFfMc3Zrw2hOtlRE/hwyGGCl8=
Received: from DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) by
 DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Tue, 6 Feb 2024 21:32:59 +0000
Received: from DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::7f22:4cb3:cff9:2872]) by DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::7f22:4cb3:cff9:2872%7]) with mapi id 15.20.7270.015; Tue, 6 Feb 2024
 21:32:59 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Topic: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Index: AQHaWUPrN7ruehyO6UGEEOWlqy1UmLD91XOA
Date: Tue, 6 Feb 2024 21:32:58 +0000
Message-ID: <DS7PR12MB83217AF22AAB5FF573F2F5FFE3462@DS7PR12MB8321.namprd12.prod.outlook.com>
References: <20240206213140.629705-1-kent.russell@amd.com>
In-Reply-To: <20240206213140.629705-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=de7b738b-026c-46cc-b730-078389a155f1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T21:32:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8321:EE_|DS7PR12MB8370:EE_
x-ms-office365-filtering-correlation-id: d7a5c7ad-c613-4d26-8371-08dc275b3094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3AfR9gwXgwEWPhLiZ7HAWJa9AmgFhC7MdF7xW6eEnFgVM+bADBe9au0unNhVTrdgRguqKdmtc2VJ3/m8YPgSgc4aJZRUSTKpw3eVwPLQ6tufsfLeeBaxd1lOucIOyKNeqLIi5WwRcJPuy2agaHaRvaxoqKNX4ogpf38v6FXIpldCnLZ+ebS9ZMZhaZliH7Xbtn5uBUPM1/3LMmGUzFDzMuHSvOPBXbqgNT4YoCA51GMWPNRlW4g6j2VFDSF8Gp7r9eLYHqD3BD2QYJtd+UW+y3SHbQAwwSD8K3+b9PP/vzgo0SV4MobsgQGIudz9oE7RGYb4+S94MtSIwNlsAElY2jzIiBtVxfyPuxAvoGkq2MmJ+LfBAUBG+N/49LjrMcckYogrMAJAhwv/mtrprzpaRRxwsAG1ZBKskqlFK1r8QjCS8sjEfI37acG107pgyHZPEy8wxzFVknJwexp7vTAAZWrcRssVjZXbqiXFgx2VU3XPnrnbDsxX1KJiCiEuLtDYC/dc6WN7+YRQOFW2yc5tMwNT1vj2u0+xgQysQOTfsKl6oRoSdlKW10BajcnHv/qcmEVPTkpUJ9l1Viqz+ZdMe0b7stsPIUXfy0+S14320UCA1P36+R1CV9CRdjSP9AC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(83380400001)(2906002)(53546011)(6506007)(110136005)(8936002)(52536014)(7696005)(66476007)(66946007)(66446008)(76116006)(316002)(66556008)(54906003)(4326008)(8676002)(478600001)(64756008)(5660300002)(38070700009)(71200400001)(38100700002)(9686003)(26005)(33656002)(122000001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n0hQ0fQPUQzfiC2qVeUhq0vOXXLAMSn/tHrjeSK/eN6Q7lejQx6UShAS8Qry?=
 =?us-ascii?Q?yb/KYfEWnUJvEF4LosW7omjVKL6iHUwD+sfqTWrZF9L+5MmqYXNiv4LFuPYh?=
 =?us-ascii?Q?uh8myKlGPKKJQabtV/59Cg7Ho36CBzydU+Cy0xEDirABKQqQnz6Iek6I3UYy?=
 =?us-ascii?Q?1anW8iEEwXcx0SeIms8EYFN6M5aAvnQAyrkVrstnIf8InbFIWTFapMcpMAbB?=
 =?us-ascii?Q?2yoVRqMuBpcqqZIbaXbAAq8vjfu1Xwm6U79J0DyozP1kNoQKTd7YwJQZhMLq?=
 =?us-ascii?Q?3B9E2MOX+gTuQ9IPSjrFK9116PFhIGcQR2NJ3QOP7LYhhUrAbe/NGVg8zChf?=
 =?us-ascii?Q?gGQTmuIee3Y6J/X809qpLR75sYWAGu62J4MXy9H6UvaTlI2yat7sPgJ3Q6+d?=
 =?us-ascii?Q?cFvKLCz20Zwm5SoZQa1z2vZaAmbH3cxJGa0DGsF2lLlSxr0dNQs8xyzoEQ0z?=
 =?us-ascii?Q?3i5T6xwmcOreOS2BsU8JyrQEFUw7Fwf9t9pLF9H930ulbPHPFFks4441gP7w?=
 =?us-ascii?Q?EDTbp/meXAY81Fv6vVV5lvSlZhsJp6nrJz68tDzjMah2lRyoar1k4iy6p4jp?=
 =?us-ascii?Q?mrIytNh1tEmchw/x64rzUIGLwglGyiP406NNrgrbCYSnCYn1KQoOP54Lfc2/?=
 =?us-ascii?Q?N81RI/tE3FRMN3J21js9w16LIO2AsnP7jsb2rctRbGXGHVd7UYewtq1LeuRj?=
 =?us-ascii?Q?eGhnEGWfEMNZx1L+0uVg6ScL+tnqbmvR/VUsCokGkYMCmajhLToAMbhMyNpo?=
 =?us-ascii?Q?3rAWJhjxnCSrSneRKI+PkQI8yWsM+tJBB7jcRF7IeGQK+xmKjlODLeGbNc32?=
 =?us-ascii?Q?j592lpTqsraiCcW6fZ5ITB6KEdZLtwBeIjAvmW0qv3ca1ksijNK/dfdJyddj?=
 =?us-ascii?Q?zLYnpQVQafrRVXaLgVuJAiSRbJ4MR1eH/NPr89/zUpRMqLYt91p0rJl+8elB?=
 =?us-ascii?Q?VESHBZo8sRRH2RhIvet7klbCExD+5OFcKaIHBUwsO0WhWZSz/d5zLVhWUHYT?=
 =?us-ascii?Q?oO3yDktt/bsJZwx5ddQLPmmWogthAN1urAxeDgRg/aIrjUzNg3n7tfqquZLd?=
 =?us-ascii?Q?wfQhD1eCkU1Qe6doKIAQL2+TCGGa0vXiZL6wLnu2pUdUBmdp3wBHghdV1H7g?=
 =?us-ascii?Q?P7sS+93V2PukmAAvDPvgJ9SdHdZG8X2GxH7ryYFyt10vfqPXoC3y8XQ3ODEw?=
 =?us-ascii?Q?qwT6arCNYZ6RDTSL58zDCe2MJ/DYXUCWrWs/vIEDBltI9Y22xIzI4CMkXfIY?=
 =?us-ascii?Q?zhY4fCKt4uRVXckeVKfswmMOCoXsPFgXQqTIzeYEDhguy44RxYo8BOKXmeIM?=
 =?us-ascii?Q?yah+KRcenmu33zzB9NP3so+Yx6yeNn2jIlAI95f3QqVGU0ZY3erTGip8O+U4?=
 =?us-ascii?Q?WW2J57TexuKiI5S9mekv4WTM11Abp1ew+D5muo+6Az1pygrs1rSnyGnVm5fZ?=
 =?us-ascii?Q?2kcMOEuVDW7K2zA5OcIO3zp8YZ74AVomGvW9UQT/u09ZvPDNle4dLEzW4uHc?=
 =?us-ascii?Q?L/BrFLC2KCbvuutxYopBtSNNOQ7fpJN8F2Yz9RyZ7CQ/2XZUifANlEjxAZGo?=
 =?us-ascii?Q?02tGgCJtd3BCb2bXSEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5c7ad-c613-4d26-8371-08dc275b3094
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 21:32:58.9870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYb7WrrmOvZ8BjCIJzv2DasxUwzrc9jKvBFpeqsprns1yM9cafFugyqUZ5eWOcTNV6CeX8zDMP+TOE1DukSTgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

[AMD Official Use Only - General]

Looks fine by me

Regards,
Ramesh

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Rus=
sell
Sent: Wednesday, February 7, 2024 3:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Russell, Kent <Kent.Russell@amd.com=
>
Subject: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3

Its currently incorrectly multiplied by number of XCCs in the partition

Fixes: 6b537864925e ("drm/amdkfd: Update cache info for GFX 9.4.3")
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 3df2a8ad86fb..533b8292b136 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1640,12 +1640,10 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_pr=
operties **props_ext,
                else
                        mode =3D UNKNOWN_MEMORY_PARTITION_MODE;

-               if (pcache->cache_level =3D=3D 2)
-                       pcache->cache_size =3D pcache_info[cache_type].cach=
e_size * num_xcc;
-               else if (mode)
-                       pcache->cache_size =3D pcache_info[cache_type].cach=
e_size / mode;
-               else
-                       pcache->cache_size =3D pcache_info[cache_type].cach=
e_size;
+               pcache->cache_size =3D pcache_info[cache_type].cache_size;
+               /* Partition mode only affects L3 cache size */
+               if (mode && pcache->cache_level =3D=3D 3)
+                       pcache->cache_size /=3D mode;

                if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_C=
ACHE)
                        pcache->cache_type |=3D HSA_CACHE_TYPE_DATA;
--
2.34.1

