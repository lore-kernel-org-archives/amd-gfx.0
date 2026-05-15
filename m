Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB134CD4F3C
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 02:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E03810E053;
	Fri, 15 May 2026 02:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXPrWvjM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EDD10E053
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 02:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mgqs0H9IkUIZulbNR29sY5DhBUvMnJP/GRNZ/+ww9gZwiM5fb4Ir2UutdhPXuTlXWg9LYutVfQGwCmcCjelAb8L88u0+9+d9YoAZTZ+shbx0CApy2NNFyAQlhLIkVxzJhX4cfiL2y79swQgoslpYPd3SQ6EnFcbac/AEu6qG6u5DxXpD6/b40GU7Z94v5H3pvX6G10vv5+M4fAKzjNV/f9MiRIKhmJMcO1vwVhzyEW+SKTkEmMKt0MzloChtDMbMfW7YsUlQjO8gjGtBmgKUaHtry+flPkWoTfHOqBqMM3N8du5ua7hVjjbVqr2QVQYHz945ODjjAsaSnLAbTilm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FhSn7Hr4LZ5tS67hSQA664lpRne+Knqbtpto0eR9VI=;
 b=ZAmZ0J/yqRtt3jyeanzMhE3UrEPDeweKldO/od3r1J3DmgcW5/Fgp6EGy4owe91DJAqhGJ5eVRYS8MWOrcNCF3BoWeluWixbOky/efSkImIbjkuahTdaYga3ngf40ETsTJ1FFxYVWWCROX0OI/vF1KF6Y+E52OimQApjGiKF58xbl9JUMXu4uX/5cdiqGOq9pem3qY6BwC7ZfhsD4MMoZt4togqZy42PEQtTQUVuZDF5+yOb6/Nw+8z6c/AyI0+6QuO7+OczUqM8gxFnj2gi9LqrN0zjKfXAb5RpC26c+04LPPUOizVT/hQ5rxjNLC7S0jOVKbPIBKAGXotVSMcTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FhSn7Hr4LZ5tS67hSQA664lpRne+Knqbtpto0eR9VI=;
 b=gXPrWvjMFgqQxsDEKBmtU8FFJ9vJ1i7sPHUnqQEzCyDZ+3ecHWUQa1Dma/UzxY1RNjLpVv9c3dO2PDHefrg2gZ7Xnp5hCRBXJ8YcC8p+1fElahNPtnZcxwoLBfmkc3baNOlnOq3Jd2shau5GSycyZuKdjrotST67L5oke2bOgG8=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.18; Fri, 15 May 2026 02:30:46 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 02:30:46 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Topic: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Index: AQHc4585QHymMJ9kqUu5GNrLN/0ywrYOXkAw
Date: Fri, 15 May 2026 02:30:46 +0000
Message-ID: <DS7PR12MB60058DE56534CDD21A0817D3FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
In-Reply-To: <20260514124250.3833711-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-15T02:30:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN0PR12MB6077:EE_
x-ms-office365-filtering-correlation-id: fc4dd5ed-b53e-428c-3e38-08deb229f870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|4143699003|18002099003|56012099003|22082099003|11063799003;
x-microsoft-antispam-message-info: 3GYkQKigrZO98RtnNP4NAJ7TyLHG622bdkC/RqfjK9GfKOd/UmWfu0+X0xucYJp7YDDGTe/oMOmNqUjHXbQgG9oBU7wcOHKxOCMQ5/hDEnVsadissH5twfsHha1qbqLWKgy2/cHTRUjgSJluENuRc+Z5HeGN6mQMe87K4Lr5ajd+uP7Rg/sEfsaCqMnYiBsZ+t525r/3MdVZwnI4Lx879y+/SKLamBRS9Qx2IEUbWNk07hQoWUraUJ5OIlMqSImWLus9I/bkWW6OSLH+ASAoxNeKkOp4exdypNBW50Sq33Q8LBszk8pcKVYNU5nMZfkDgKoY23RuWQEv3GTcgEaF2XqrflHE6nd0uOivPRlZN2gr6M0VaGXw4S0HwFHuxu6YRr1PnG+7uclx+FVHX/Hc8blcEpJfJffOAbod5d3gqDozxw+tnt7QrjESrfxwhXz6QLG1kiDgYVtF3mi8uM93JTwsYGDxF7dKLlaUQxh7qiQLSDX0JlFDVc6ugBddYeDg3otoo0t4yzhgzAUz3bWGrRkDuweRwOUWq0CftntB5iIh/vvs46UQhWaL2UlXHZZ/kMx8AHVS3b0w3/Smw4lSGqCFXCb3F863ul1uXmddf1Pzz0ib3ZC6NJBnu279+YdmCpwsvjeANIuwcdDtuHO18KF7uIfAvAdHU7kxf7+N26diAePX/SrCNz69mbWpek1iUws147fe5q6RyqqyMhVoFG6n7a0c0ewmqAfCDpv1NaVrhUpD85ausaceYF3zdDvO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(4143699003)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gUk051lhtUxzOZlIIzOIO3SF1+UX5zeLZ0kYjJiA3k5v6aMKzE7AupiSam8U?=
 =?us-ascii?Q?huvHNSAGxCgutVZF1p5pMRwjhixw8VJzrBbov7sviLICnM4Krd6PuQsPP0Xr?=
 =?us-ascii?Q?VBbB1Inngio4C58Ve+pnf5msNq5NHC6vFP7Lu0ks8Bzmb4yUCldnr+VmVd0e?=
 =?us-ascii?Q?CUE/aXdQt7OCnwaRPLMJaGZ12wH4kI1MTnY+sWIlb4/GtknNcT7TUMkOnvx5?=
 =?us-ascii?Q?cuEAfoS4Azo5BxWmWKve0D0VWJjROZKjMipm7Z/objmSHk8bQbW13Ad79vBA?=
 =?us-ascii?Q?UzuJdsKk/Xek65RtPnj3baArRciJoWf4NLOrKKeKnJjorAEU56ptk+8+CKrJ?=
 =?us-ascii?Q?LlZoGLHKFeJ4T2Xab4IUBYL2Ff20+SoX09CndMtx1dp+oNy7ikL9g99P2Bwz?=
 =?us-ascii?Q?RThjMud3Al7xZC7NN4PZU3OXkuWpmaK18+DP9v2M23EraAKUUUdS786LjT/B?=
 =?us-ascii?Q?4uiOS7YFMphwVfngv7a25xq5OIStGXI2YsX7mHqAPB6QlQUulqbPwVtnHCN9?=
 =?us-ascii?Q?HwcY7FeDTGLHeDZ/5JyWpqOj/ZLWCwWN2SOB391wxF2atrZesUT1gbubFguX?=
 =?us-ascii?Q?GummG1OXz6uZkt9OoMHbPhFEAbUWUUzclrur4OW8kAuJITwykyrUJbD60z+s?=
 =?us-ascii?Q?V2MEoUw34L44/QbZfPIqEGjfGJ7ZLlFXUim9N+njoxVEIC3eqmIBoasOXkzW?=
 =?us-ascii?Q?AQ1RhVz/zK5ESg1Dy9m95y7yBVg/Qd1inzOo+hwwgymdq4bUQMtDPqlHIT03?=
 =?us-ascii?Q?8V/WwB5QvnXbYxzVojPESow9wBHvalVvkC0zRLorxIbqn558zUJGtKqE7vA8?=
 =?us-ascii?Q?cHLiekL7UG/cYNEwNawACvGd7UNvwb7vmu8GPMpPCWkYlTjijqfA6LeJNIwM?=
 =?us-ascii?Q?9bjGLurcSPIXPbJ252sbjji3OlfetZRaIOwQ1dF+hiv2rCMWRwhb1JkWrv2j?=
 =?us-ascii?Q?JrCjP8pvMy3N/OrqkE8A8nq6JoE0VrlINM9vn4Cf0Bq3XHACXuE84jLSH1fz?=
 =?us-ascii?Q?wiORMyb05AluUJb/5si1e4ESGyB+ORjYlbGfvg9bCgLn0JUg0OQSdE9Vtnea?=
 =?us-ascii?Q?JsP3qfhir9/ZsP3OydYjpxZv4nTQ0CBpJggOIdTVIIMcpFs0D3ZGK1ltUXLJ?=
 =?us-ascii?Q?q2vekQNf1XJKyQouIfX1b2Aq5/J6okw5oK0Olxa6vur8kDtB6bECPXsMC0Or?=
 =?us-ascii?Q?9xb2F6s4sOIN+rRrU8A3cKXM9NgnFCoUEnNV9HKqA+8J8uHywkLqQ5LQ6v3d?=
 =?us-ascii?Q?EfiKJweVeB8lwoUm5pNcOLDg9Tmn3kg7WBuIM8gfDzXS4e93KdG/p1s7slTT?=
 =?us-ascii?Q?t6NbMWlybUjZOG6FtDSym/VsK2pDTPlB8OoTYxXFOJhxmvsqXjj9Uja02XU5?=
 =?us-ascii?Q?Lwv3njj68XzRqnUUs2K2JTzprK06NozpWvx8gd1OVKl7uIT8o8wR5HUF+qoc?=
 =?us-ascii?Q?vdiGZQ8aYWo86qbJxtj6YoiuL2Kekc3UsYkhVRc1knZS9zkja9IKKeEO0c/G?=
 =?us-ascii?Q?BI642IkNkD/hPZNserDJY66hrDhl4t4EHlWEEBXBnt/RJaL/Hg8vc/yhxv4F?=
 =?us-ascii?Q?IyfHLk6A4vPHn0BV3DKDIguwejjGao0/VkPi6/kxLvBoX2uyDyTiOxQznyB7?=
 =?us-ascii?Q?Cqfeg8bpjEiUvR3Lp4eqdKeJ3dr/nNZNKi7qsB7jibV4rAmdBAu53GbeVHGf?=
 =?us-ascii?Q?blT4VPu6w4cSOjIAJYJ2teGDDMzuTUhv7gLsMVy3V3rv+IMw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4dd5ed-b53e-428c-3e38-08deb229f870
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 02:30:46.4088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4fRdeJstYnVOQu7yq1QTW8uaEq5Enp37n62lqKfyxnT59hwIT+Awgm+tZZeCSxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

Will resent a new version for updating the commit log.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, May 14, 2026 8:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
>
> If the driver only preempts queues, there can still be inflight waves, pe=
nding dispatch
> state, or resume/redispatch possibility tied to the same queue. Then the =
VM/TTM
> side may proceed to move/unmap queue related BOs during evicting the queu=
e
> while shader TCP clients still need to access them.
>
> So for eviction, unmap is safer because it makes the queue nonrunnable be=
fore
> memory backing is invalidated. Meanwhile, for a idle queue it's more suti=
able for
> unmapping it rather preempt and unmapping also safe more processing time =
than
> preempt.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2e3edb6dd506..a63dfdfa4195 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1048,7 +1048,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
> *uq_mgr)
>                       continue;
>               }
>
> -             r =3D amdgpu_userq_restore_helper(queue);
> +             r =3D amdgpu_userq_map_helper(queue);
>               if (r)
>                       ret =3D r;
>
> @@ -1285,7 +1285,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr
> *uq_mgr)
>
>       /* Try to unmap all the queues in this process ctx */
>       xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -             r =3D amdgpu_userq_preempt_helper(queue);
> +             r =3D amdgpu_userq_unmap_helper(queue);
>               if (r)
>                       ret =3D r;
>       }
> --
> 2.34.1

