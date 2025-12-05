Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF058D339A2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 18:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701EF10EB9A;
	Fri,  5 Dec 2025 18:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZKCX1hPj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A4710EB9A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 18:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzVX8Z2Lo3NnPGf6Rblw4brCWqWHzw8RTvSyeP9hcjxI8tkpDerd+iZlPyYKq88mas8LaEqlvVr/aCGBd49gO7AfBXxvrbGGqY+9prTVvyCSO70D8jHM0tx2EzAI77HgP0fbcFcZTLUm+rKyYzbvmICMckfD+osKN6U7RPu4xih/Mk3v0kNNISt9Xo6LjivMzotnvL9ijuSU7IzVyrWvjKFfo3eDtnr0+Mmy2ypYKQ9JPS8PVb1mQeycwYnoWSRYP7GNZJtMNrFAYGAe2CkpNejhykWslzJBT9EURiMhrq+3etq4KzGVllo6ptBYzsmvznO54D1Z76NM4lbITRxVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw1TKSU/uo0Xmh+EAY3LK4xlaPfuqVj0dLXbzdumFho=;
 b=tB4JP0wN23gMYHiA0QRjwieBEuRInZxWABZ/fPUWphlDleQ+jxzzafumU3jH4ba98NO3pBWPHXEMLrGHZxl34lh47FmyqIqYysMFQuvbTIlDqe4r/lnhdIOaNxObiPuys3A/Qh59/ABwKki0m6PGDzysxrzmu929VbseyAoC8a7hCWhCrxA7+tiLi59kbdYwogfiIRZwMGQ81X++vyls41aWlG1kNinjv3XU8JfAuX1O4G9s7pjo8mXWsc+ajkfTsD6Y+PFPksrXkiaJ/1+VoknPMeevDZ61Xt8kDWV/Q2zlGwqt+cb+XgOues8N6ZPW+l+2V8bbn+7EvAmSjDqmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw1TKSU/uo0Xmh+EAY3LK4xlaPfuqVj0dLXbzdumFho=;
 b=ZKCX1hPjAIOrde6ZubgCln8r/11UCUHRrty3roldEM5Enux71pHOT8eEXOn0nUWD+muH46SKHxhpU4HKY6fSaB1+DM0zxLDDu2/1/Cq426t7u6cdBAffSxJkBdtetPCdLJVRugZ1Bc3VFnB1wyWIxuh7rY9LyZE3G9m3WZzGtbo=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 18:58:22 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 18:58:22 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Export the cwsr_size and ctl_stack_size to
 userspace
Thread-Topic: [PATCH] drm/amdkfd: Export the cwsr_size and ctl_stack_size to
 userspace
Thread-Index: AQHcZhbrn0YAQgqYYk+TGmSTIL0GPbUTZgPg
Date: Fri, 5 Dec 2025 18:58:22 +0000
Message-ID: <BL1PR12MB58981FF226F7E9DC49ECC08085A7A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251205184158.2261400-1-mario.limonciello@amd.com>
In-Reply-To: <20251205184158.2261400-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-05T18:58:15.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA1PR12MB7320:EE_
x-ms-office365-filtering-correlation-id: d0671377-3fb2-4dbb-e88e-08de3430434e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zBxui9tt/HCk3qCZp3GPY3Vj4shDmBRZEy1Y61vyIqMt1hFjmMYF/7Bjcsft?=
 =?us-ascii?Q?UHJFeRicoNd/OoR0gv58dhPzP46FnU94SlYodylMGo2WJhkBhGEN5QtsIlIz?=
 =?us-ascii?Q?TGwp9ZdKUoymIsKe/SmybEL3lvDJxh8z9HhGt7tdn0orSBD/snEpjoev8LzG?=
 =?us-ascii?Q?XjxTHdM9s6W+2KWll06YmqSP3s9US1gB5VyyazvR3DsC7izpT1/BZtjUESiz?=
 =?us-ascii?Q?hb1ZRVWdQDXMmi+/96a+NyZVL/rfL1CFiGn1aoregy/K6oMb9DVXfOkK48Aj?=
 =?us-ascii?Q?ah++ZmcCShWcPAaYYWK3fWoiyzkqboaO4zCQzKaivtrTlibXEJAO6aClh7At?=
 =?us-ascii?Q?E6ZBrAysbV/FeMts4WTKduf7MejgNDnkpgXgl1332puHG1RKodRcfuzksVFb?=
 =?us-ascii?Q?S55O1PPLsm+Wn//GFZcNIe5u3tmQI/nXg4vja5xdbMHmgLr9NYezhAmNrhZH?=
 =?us-ascii?Q?2nmTC3BPGuLlvaQs8kO2Rz/krkammgfuPjvoJTLV4mz7FE633IKCZ+/dzV7Z?=
 =?us-ascii?Q?FvMPEEbctO/a7Jj7t7XZ9C8JUrB9I46vNH8l0G3CWwl44TfKCHNbk73Fzsbf?=
 =?us-ascii?Q?LwawnMPcKkYc+6pj2tZw/YSl4AwbL6Q6oU81+PcXqg4DeUowzWBSZkc3oR01?=
 =?us-ascii?Q?4/JsSPHZVLVI3Mj9bGsVSwWFEIfxJYZUPbwB0W2NZ1qTCH0bNAzbd2Zm9Bqc?=
 =?us-ascii?Q?dPjpTxQ57ZHz07kJPmRaWPlccfblyyqcfCWXkjbtv95YwHAHLvtqHZfL5VdQ?=
 =?us-ascii?Q?eDRi+xWvOpREj42Ejhc9m9W/31GIcL6EoWWPcCuJ1PYIc0CfAF3/HccsqyeP?=
 =?us-ascii?Q?akAcu5gbJzk7k7SY50ysWfsRTqFNJk6G8PGEMqil25yLk1eviiaurw9ukI5a?=
 =?us-ascii?Q?zBKlvKwwnEHfPhBTnNhEci+jjmtxvw9ccUbL43nybuMarKuZcn6+jV2kUrup?=
 =?us-ascii?Q?veUzpZVSo/oqUf+lZAwisyOyzp98jETlOu4g7NTP7ZVXOE1Nv1M+UdAoLavE?=
 =?us-ascii?Q?COQwTFo6R5H+njZvVR+663p/pCbnSFZXC7ROJzhI30KL2xKMM0mCVTO9uJL8?=
 =?us-ascii?Q?jEj23eFljK7Z6C0B6l6NOTWTmbocjmSHZPiME1fVWLP4bthFp+WMDh54K7VQ?=
 =?us-ascii?Q?ZJKh92nkKRQLQzydLODqRXjeh7awa7QeNf2nrC6hNfJxkmB/4uG6bLWU6Y0J?=
 =?us-ascii?Q?eeSIW9qJlZHftSnWNJV91GOG448RKByT/xGVevlohqAoFpGtbodKDZAN/ULD?=
 =?us-ascii?Q?c9pfHKmhjvnfUb6hxc4GwPbPQ0xV0MvvNf5GTLlpiaq2Sz9FNIjRi7tz1Q/W?=
 =?us-ascii?Q?1EYBxtpwJQqxuk77AA3IPnfbjzwsuZLu0wLULpxr3ZfojRKGEvMtHxPBs++V?=
 =?us-ascii?Q?J/AqwCMfFqBf3IfEtMwTwhIj3+0CjOGGS3RU7eJg4jrU+Vs2UWVQ9zZsxv8T?=
 =?us-ascii?Q?iTyDWtLqyCggVA12M+f0ES5aJmTCVkraUtldD2VAeYzLnSix8TRR9n9tjL7W?=
 =?us-ascii?Q?wttgOTYe9yYPFwN8UWXq2CcV5wzJ00xco63x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6DMO/GSO+8yBPWk+8AYKmk293s6BlCSnnmvv5jF2WOOn/tarYJXK8107oWYl?=
 =?us-ascii?Q?y/qxs/qiNvsNu5yAEq/fJhUJQL7i3qdyEVZM9FZuHUm77RofsJKRKVAqn9Y8?=
 =?us-ascii?Q?sNZWWgGc8U+RfAowcnc1wDDMm9CMcR1w1vv5tTZGs1b0EYU+ZqO45/v0VJN/?=
 =?us-ascii?Q?3U/CHZayP7QeNZjBDFFkwWjDw9ik1+J891pW+gK3wh3VR8c4gI7UOkwn99AE?=
 =?us-ascii?Q?8gVfPbNXTUx8UhS3we30lBQsJumieKQNezrssucbGZ1JyDWEuvd5EbjFSjbA?=
 =?us-ascii?Q?xAnGCFIqXXT8T3BuLxssGoymZ9l2s7VD1sezq8JkLCFpf8Ev0YAlyljswmvn?=
 =?us-ascii?Q?SRI3k96qNhgiHB/U1WbeUpcA+tZoHRzSkmjPGvxACodN+dggDEi2NLhIIDus?=
 =?us-ascii?Q?V/I9+IWAlA6CQXZeZ/2Chw0GVPISrYulClihBDAmEhsL+Rzt+MoNAo7+TwSx?=
 =?us-ascii?Q?JZsty08Hh0SO/mkCB11EQvx7bsqtGcrSsRkGHI3n9xN+7mOAzFfPFJxH8yqN?=
 =?us-ascii?Q?qkvybJ4av70hello/RTK4S0UG1V/thRZ3lt44XTHT+aXVqpWPATFBjyYFlrt?=
 =?us-ascii?Q?IGIiBMpC1voNT8cjEfCdMoZJytJ9m8Aqrhm7mJKwrW7jukqQ3vlWeHPFcrMm?=
 =?us-ascii?Q?e/wukZghCotBPdG3MB2sGYrDV5MnfK6Z25UtBP4jR9afrNedhWrjASSny2Ul?=
 =?us-ascii?Q?OozqTGUcZ2W4PJBNtyd05gOyEj7cukSSV+LjM8nnTP2P7CPIwUQ6awjHeUMX?=
 =?us-ascii?Q?rB8D7GFjdoGQMJq63xmdmoKMiC2dlmBlo5o4N4xbtIiQOUCPMI53cru5p2EI?=
 =?us-ascii?Q?LcYhT8mhmxhCYyLW3ZyIDJD7e7X+6AwM9het7j07LXTjz046OuYnVs+pbOjK?=
 =?us-ascii?Q?fv/t8ni1Hz+okKikCCTgRTp0P+hTYnIW4rxFXiFpVVV+tA6T7XurS95+h3fG?=
 =?us-ascii?Q?SGC9F4UZAzF+5v05LGYm7WCDR0qmBmE5yg/ga/OlsxgvDnIve/agItD/vqS8?=
 =?us-ascii?Q?ndhvNqKKPgYcUTssYyX6jyyxvoazAtg7iPSW/ZGoxplnkDlCmbO5cmzqgSbF?=
 =?us-ascii?Q?Ru8kYMiWTW1VG+r+HTRBPka0bBFLb3hR8T2wPZicWJSkes/OLWaI0b9Dh7Rv?=
 =?us-ascii?Q?o73sBgfdXTLypNFJ9eVdYLLfP6FV5hohyzqn5Uy/M4zo90Pl+QLzAb2RsJ0k?=
 =?us-ascii?Q?o0BBdiVwLLF0Qa1TORtVH1LQLtNxJoC4LFzs3iORBOfh/Bm2fS2u9928iC62?=
 =?us-ascii?Q?DBrC5K6z3OtzAltYDMvVlBcK67CbjSNww+f8obLMEnbRo4ZyfGiMJZvKwJtT?=
 =?us-ascii?Q?uR+nayrOvSzSOppm6s5VnuvPIA2gU9ycoK5eSyG75oly2RHXYwUcVbEJdMfJ?=
 =?us-ascii?Q?jEVObGN75+dCiXXymvlBnJBPZ3blm9GLatBBa7vCs/3sdeLj0F4kcrl/31Mi?=
 =?us-ascii?Q?xGCGljSucxj8eQfVL5Z5QAVfrvwmEenvtJ3xWBXrvxrDZo9iU55/CgNBKQpc?=
 =?us-ascii?Q?5fK2lEs2FeJHFEQtEicjruRmmVIa0taBLBoOBCgwWhgrTHThJFc8TYfQ0zy0?=
 =?us-ascii?Q?rlfa71EzisBhw8gCxT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0671377-3fb2-4dbb-e88e-08de3430434e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 18:58:22.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KusapceS61ts2U7sQeTiG69SvP0aVpz13VdWKo+k6uRxn7JhsKv32K0U4hFnVq6fAeem0XqFJdujP/ScCcG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Friday, December 5, 2025 1:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amdkfd: Export the cwsr_size and ctl_stack_size to u=
serspace
>
> This is important for userspace to avoid hardcoding VGPR size.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 9c3e8f946a3d..a0990dd2378c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -491,6 +491,10 @@ static ssize_t node_show(struct kobject *kobj, struc=
t
> attribute *attr,
>                             dev->node_props.num_sdma_queues_per_engine);
>       sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
>                             dev->node_props.num_cp_queues);
> +     sysfs_show_32bit_prop(buffer, offs, "cwsr_size",
> +                           dev->node_props.cwsr_size);
> +     sysfs_show_32bit_prop(buffer, offs, "ctl_stack_size",
> +                           dev->node_props.ctl_stack_size);
>
>       if (dev->gpu) {
>               log_max_watch_addr =3D
> --
> 2.51.2

