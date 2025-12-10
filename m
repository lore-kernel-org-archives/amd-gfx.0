Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315ACD3E77A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70E810E280;
	Wed, 10 Dec 2025 20:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gI2Bw2b8";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59D010E280
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+5Tosl6IvIMmvT/dXbLIlBOeWyRr578fhODzM+b4PJAtj6gHS+QLPP8tUEJQKACmUsQPR+BzO3XzG6Vw4gZGpsAw/OnGyynjZgEgvI3aVpsL7QDlROCXHesEOHLrcCDP4s+f382Rlugdu00vl+OiuIUabjVhEpM0sobOHT3CzSXZpajKHtXDl2S/I+SAHdpg2RXlukMrYklbelyvPcpkUqhP5lOhodKs/TjvWEqhJ/u1bcn/aqBXbTIOJdOc0RT6QAF1zYoLt1u23h2olIrJrgF5oE/WRXc2+rZ5QIK9JC4d7crjr/iTgc97yhgQN/TmQREMOFxB8r3rmo3JSqrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icvYurH0z0nx5xrbCsKC12pkh7almHgmxIVOrZ/1Lnw=;
 b=jIndWdgFWEazCmBcWd0kJ2NxSZGBZfaS3wOSc9Ww6CmzfNzOFiKOWX6qdrMpuzVZwEbQIKhCeRRCITJU6QppNAV2wIeSd1kkAzMsTNcQUNODe+zjHZVploA3TA48Y3j8LoWj2gfT8sgHb4M5R0NAaJFaf48R1zDj8YNemWkE25Cx4r11iVeVUQzve7XGEWXAc1YRHOlOJfHc0Bja/Sho+XGwXpdFJtDFFcy1XtNx1FQV1Y0551uoIBEv388DbayDBMDc4QJ9w8VbliXojq9vyuJeSBmLo8KQHHDmL9tUuBxMjilD8suIB9d8Wah4d0h78xNxKSHL26zAuPS9MR/SOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icvYurH0z0nx5xrbCsKC12pkh7almHgmxIVOrZ/1Lnw=;
 b=gI2Bw2b8SI8KpDbdDUCuEMgKhZ1HHg32wR15tedaPslVJ9ctYEvhTUV+z5BigK5GXZuP9J7v2CCRR0ysAjqly1zz9dwRn7F6B/uBfXMgQ2vk3Qaicou3AGbMA3/b+1R961jPzNULIUAcfPxcxi4uAXKHD3MWQr8mwh7+LJUtTig=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 20:40:04 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 20:40:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling
 kfd_topology_update_sysfs()
Thread-Topic: [PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling
 kfd_topology_update_sysfs()
Thread-Index: AQHcahG9sf7MCVZb8EG7OQPOgIscMbUbVcmg
Date: Wed, 10 Dec 2025 20:40:03 +0000
Message-ID: <BL1PR12MB5898AE4D889F8510968F2A8585A0A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251210201510.3000-1-superm1@kernel.org>
 <20251210201510.3000-3-superm1@kernel.org>
In-Reply-To: <20251210201510.3000-3-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-10T20:39:32.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SN7PR12MB6671:EE_
x-ms-office365-filtering-correlation-id: eef3ce15-6259-4f19-f1a5-08de382c4bd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?NleeEHU6h33sek61H6b3++bJg2UTTTNRMGGSi1suKsKBTD2PvDbX/dl1za/p?=
 =?us-ascii?Q?Iuz/5RXyINbds6BhD6zQ1AKROkenchEhqHfkMIsXyOZEGHZUOVuYQGX51I38?=
 =?us-ascii?Q?WKasClVJVonQVGTGhnM+V5Jj63GSA9TmoMwVlzGlmsHO5XcJfywqiggeov6G?=
 =?us-ascii?Q?U9QSqKPP2tQ8aMNCQEqwyQh2Tg1OJQt0qAz/PNrWvnSuCv3UUurwNBG6C9bW?=
 =?us-ascii?Q?a3CAtMUipYFBTUhU0jNgyBKmmVDSLmHHbN3g6YFreGAZ4Z8uSmWQLS/2tcPK?=
 =?us-ascii?Q?dE50C5lNXEpdZWDjSEu0+aUneWIw1vqh6IwGV4sMOToJBKnQ7i/mylbDmdvE?=
 =?us-ascii?Q?YpvUUup8OVqeL0UhTrjl/Fex9me3AwU1M2h0H9+HPZxG73cZg+UDL5n22e/p?=
 =?us-ascii?Q?z1O+OGKtGXA7KFqZna3HEXTJnxKbjpGCjxQLwchsOnN+QBhjPMSWaIbi0u1v?=
 =?us-ascii?Q?LPcZFhtw0J/SgVP5p0haiCT7wN53t9xTw4hhIBPazsnJe1Bf5QPLGkxcwxeX?=
 =?us-ascii?Q?fjqwKMRFY6cAhgZUo+9j70T6MJ7tJQCjj/oqhVz8lIh3mCBO2VAgdMUl9DUv?=
 =?us-ascii?Q?5fofInwDFPfF68AQ5FyOUZvVrDnqp/xoxY9vrnHfrseSP7Rb9Bh7lTpXeNAH?=
 =?us-ascii?Q?mp7z1h1S0UHr06GkQXexyGsQaWs7bnYjqT6Mj/jneR17WYE4RS2omm9DxbLy?=
 =?us-ascii?Q?ucOXhf/nYZeJnv3oxIeyWGeOw0PL14GhV/B6qyknk93vSWSlpmguOleuWEMQ?=
 =?us-ascii?Q?BoliQ7I8JiCja9baZJ+K4mOQE2hmq60x+pyeInCgEYTdoEbkKTUnWh+FmGRo?=
 =?us-ascii?Q?NX6UUUBjYO9sXAo0SpS6BPR+p1pNIxf9iatySK7K2zgeAftGgjklV3Lvdtuz?=
 =?us-ascii?Q?RCBNRa1tB9+6kAJ5ojSMbDdi/rxSgSjif1F0ND7MGVS8UXshHSpbKSp0fyy+?=
 =?us-ascii?Q?IPJ8ESnvTqGUfrQ++omeXDfVpXyYtmhSOvsFv/OMs2Ch19UAciZl0gjj3MOC?=
 =?us-ascii?Q?d6w9r8NAYqH+GMH75ennruPPgxg1uWp5DDQJlLRpIjKuR50jHf+DC66qdstm?=
 =?us-ascii?Q?2bL6C1LuDGPdj50kwLKjd1Q62ow38auDt9t7LS6G7giHnn3a8m4+OVsOq/6g?=
 =?us-ascii?Q?+x7c9DVIghz1xL06sTFtwK++4jgoEvRxI9f245Vfxiqlh+qtfGCZQe6blGk0?=
 =?us-ascii?Q?tLbXZX2N9htgQMKqGLgTl3+F/i5rHefz3RJEOqE07jU2Mjbijn0qBH6VXgit?=
 =?us-ascii?Q?WK4OwGAq8br3P3i9pb9J6Xk50ONxgigzei0IXxoJ2LJG9oZJyHDWg8h2uZwt?=
 =?us-ascii?Q?F8VI++LngMesNoXTp0anITQsbd5uir8GuTO+y1tevwfPl8ND2EA7Uhh7hOOr?=
 =?us-ascii?Q?7JSq3fNF0a4a2rT7Ai+xBp2D6xMAOXIiqrDZd07OqOLdtft5vcyatzIBXLCk?=
 =?us-ascii?Q?XkB3fe/BNHbHC51bQvl3oSMrU2f03YDp8Aa9ECjdOGn7nzrhqMKO4xklPzwN?=
 =?us-ascii?Q?90TKU2SYt8dT3uSc4r0s6n7ZB9AK/5Qzpijy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4K05Cfd5WYIckrYAX7kZhuLYfffXsz9Avt7zTNzYMEYhWC8iYcuQ/rcu97o?=
 =?us-ascii?Q?iwyoRO46T37WtX681/e4JCjGVg1WmlPJPv82pYjwx+Ae/erjX2k+h2Wgh/lA?=
 =?us-ascii?Q?xw27+b3NrO6eEK0QG0sBQw76llFfFK+dgVv7/0gUWz6r+dY9DK3PdZz+XBR5?=
 =?us-ascii?Q?kdB8JsD/rbyvy2nlnJKkDuReOAtblneLIH5x/l3p+m8tPlM/BOr4iS8nDcWN?=
 =?us-ascii?Q?QpZkhw2k3py/jxkuMp2N/OSq82WPwS3E+RfeBEEkdfUjQbHM+ARRFp8dNda7?=
 =?us-ascii?Q?QaDguQmyuqBCUwiruvYKae2wgMicySBOcotiA/NS+q5VZzvK3guKm85/zubQ?=
 =?us-ascii?Q?Fl1/SZQYVf/6HnxCXM7UJi0/fUs9usiBa9xobZIX7EsJ+VTS/wj7Hx9Eh4FL?=
 =?us-ascii?Q?Q8lBeoaajW1hXH22vhQLenj8gOstKmLQYAlVqFbOxHp9bsX6sVVHiQb8uHRp?=
 =?us-ascii?Q?0D9fNGsP1N0+Lo3YXjIB0RzcGzidSIuumjJpAYDDlW5EdQK+2HUtsfLCXMKe?=
 =?us-ascii?Q?HrePfSEz6ILKFZI9xmJJf2i18nGJydDiu/yFMQ1nH/uSprqHOusmdkA5zUMp?=
 =?us-ascii?Q?ObL6pAy/8su9Bt3zsZrFrICvdN51hjJKsoasR/r5UEDOuYBACI3QZZXKy5Ur?=
 =?us-ascii?Q?Yyn8ikFIyavvKnP8lboPdDhlCi8N0dBblpZkN8NY8dOhJCEM7+1EpWFwHxtC?=
 =?us-ascii?Q?dT8uGrtX7ThpkW4/WhhiP2FE9p5bCbAZFI3m7JsgQk/SFlwASiTmp1YHOaGw?=
 =?us-ascii?Q?pIzKhdUBBwLUXVCZXdCS0M3zMJptg6EwJ4Gg1MfYwm1PfXCuCD4jg+7rdLxc?=
 =?us-ascii?Q?khuAi7PYgY9CSz2G7S56pYzsCOEtFJqzR2Cig+nItsHb0ICoZzcc/GWJWxKz?=
 =?us-ascii?Q?5uzTA4TTCUc1qQg0QyjaLMQGtVcybVgO9d7YDpeD40Ydlez0PKQhAbpBb1kC?=
 =?us-ascii?Q?4pXNTZVtC/QZN8QId9/cLzCwwLXaydbVHqXnFDxI6pZynlk72pSqrGamU26b?=
 =?us-ascii?Q?S9/yjFLqR7fdaxyTO6O+OSu2ZW4oAc0BthbgAaVQYrI+KDqVxwyJugbnHdmG?=
 =?us-ascii?Q?z3e7WkBLeoUJAAjS8g1QxwRc199R1bRnAzLyITo0npJEEAG1YMFoR5oe+DY3?=
 =?us-ascii?Q?WHJIWpYXVmFxat8QKZntkhh1KK9KC1+Fh8OHv/CfaxkrKKj84Wnjf3HGC7SG?=
 =?us-ascii?Q?0A6jZwgOHMezlQv+gUu0A12sqdIfEEao4IZJcx2J3b4ooYySFcIH/zjttSQZ?=
 =?us-ascii?Q?Ep5gDNOtKVrFd+irGbr1x2mm9K6t7HZqsohcpfR9jHJmxhwTG0Jwn9dBJKO9?=
 =?us-ascii?Q?sBvcdL78PTtmId4FialDZEqJ9Yt/OPT/Xhb9zWTACWdEEOXKoC2LYAf3l4Lx?=
 =?us-ascii?Q?jbKPwDXgnKQsPiqSVuuTQUHBJFsPpzT+AMxPoJAe2d4VJbrvtEES4ntzOFR/?=
 =?us-ascii?Q?DhCKVDKvHC3o4oM3Kek5actDLFlC035SA7kB5L+D1LpEt3LQDystxcgpc/Kb?=
 =?us-ascii?Q?4Toj0QDLL7IDRiLhplFaudVtbiKPD6GFVpITQonuGMuX0R4e3Nct+YyYOT5k?=
 =?us-ascii?Q?jChfqGyVs0ly7oDBezo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef3ce15-6259-4f19-f1a5-08de382c4bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 20:40:03.5125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0R+5Jg3r+FVLv56JPDXZg6rwJ9y2iTPIkoFu/bGucHroGVdOYycpcnoVPXoSY9mTu1YdknfLaq6HUQpmaoLsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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

Seems reasonable to me, but I'd want Felix (unlikely due to PTO) or Harish =
to weigh in to make sure I am not missing something obvious.

From what I can tell, it was called way back when KFD Topology was first wr=
itten, back when it was for APUs-only. So they'd do 2 calls to update sysfs=
, once for the CPU and once for the GPU. I think the logic just never got t=
ouched because it still works, even though we've changed things a bit now.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello (AMD)
> Sent: Wednesday, December 10, 2025 3:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Subject: [PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling
> kfd_topology_update_sysfs()
>
> There is no need to remove all the nodes and rebuild them.  The content
> will be the same.  Instead check whether the node was created and skip
> the creation.
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a0990dd2378c1..b65f29294e2d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -650,8 +650,8 @@ static int kfd_build_sysfs_node_entry(struct
> kfd_topology_device *dev,
>       uint32_t i, num_attrs;
>       struct attribute **attrs;
>
> -     if (WARN_ON(dev->kobj_node))
> -             return -EEXIST;
> +     if (dev->kobj_node)
> +             return 0;
>
>       /*
>        * Creating the sysfs folders
> @@ -888,8 +888,6 @@ static int kfd_topology_update_sysfs(void)
>                       return ret;
>       }
>
> -     kfd_remove_sysfs_node_tree();
> -
>       return kfd_build_sysfs_node_tree();
>  }
>
> --
> 2.43.0

