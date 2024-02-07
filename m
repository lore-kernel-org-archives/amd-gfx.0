Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B693DC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 16:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327E110E059;
	Wed,  7 Feb 2024 16:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfvunQIW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3FF10E094
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 16:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QihoaeeoZYXVBAUJUiBJh7FjTiH6cE3iNr4qoamAdjc1lTFEyTs6nvirhW/NVLfk3LtlGfRFTSRntZDsZSIelQIRrQS4m6na2MPCvSkliAAJk2oX8bh8vBBcmVTt/SIiAULbcIQpP6BMd8GdDKFkJ1Pa+Sc64swvLJu6kVNDqj8pN3jQybdLlnobd7k9XH6UytygctPpeb9pGJ+64EPDt/+eaG1FfkyiysitiTI5jXZHzim9HDBP/RRtLJkjbWE0Cm4UvZD8jlF1QhQp/zzjY+1Bk5PAc1b3U+T41qdITyTQIt0WH21V6IHH/1aOj/VfOioL4KZGy/PbRfRXRL6G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abK0Vi+NWreIeyUT5raYB10DZlRy24qwduxHBmbu0bs=;
 b=ZHUZPd3lj36itQiqm7A+8uRtUV4HMJk7XL39h7x2Q0YbbUySLLoQXPzQ8/CLfR3qTP5eEx5Eo2/ps9NAykcNRCSuBch96TA6L3S7KaQTR1xnOxktp/JPw1G/NP8kXrCyPDVOBCC37pRPOVYAPrgrDeAiOw9Q9jYgbsB/+6cO1U2zyitC0DYvJJUkLAVSfEO1XylwX3NJ9+hy9IWMsF4sPMBMSxag6rDns9TOS4vDXsmb4cs6bb6dB6iNjWCxZoK+0b1RNjuXrUlZYR8KUdEdNEFZI92MYmsqfTm/JyaZwoL+8EFJVHb+fSGSIbgQqwLN7CopBElwAjfg0s3bTXKQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abK0Vi+NWreIeyUT5raYB10DZlRy24qwduxHBmbu0bs=;
 b=qfvunQIWFQEHowqqrgyE1JbEBer8iVGSfLlKm+uhVjbu1fEi2fG+hBbDjOmb2uhG7wInB1Q1Cqr+U2+9A718OPVgw6hDaCxuq8szge6WbA5uzaLuKm7HQdWFFFJfZfNq8DKHP5jHtTuZi5GNqJsYhuIdXl1XNcU21yBsMEZDKEI=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 16:35:11 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::a1f9:8073:1b53:8779]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::a1f9:8073:1b53:8779%5]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 16:35:11 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Topic: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Index: AQHaWUPl/ekDfzXLqkWkq1UntBt5YbD/FIKQ
Date: Wed, 7 Feb 2024 16:35:11 +0000
Message-ID: <BL3PR12MB6425BC7CB32353E790082BEFEE452@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240206213140.629705-1-kent.russell@amd.com>
In-Reply-To: <20240206213140.629705-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7e7ccc0-8bd2-4c2b-803a-232ce5392f1c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T16:34:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|BY5PR12MB4323:EE_
x-ms-office365-filtering-correlation-id: 3cb88409-04a4-4816-10bb-08dc27fac0f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sf6w6+xJyJJfzLMSrj/baF2NUXc7yxIereg7A6uHX6UGln5cvAMXHKKzW7f6lBkaKnyIFt6n/vGUmyunZ61gBIoxSXUslai1mSBo9BfI3jRqBYrP0fPMgVj2rm07s8o5Uq9sbo5N+/27WXitW2uj7t6Sartsw0yjy1LtNg02es/Nka1mI3KXMfQPkcTwsv0dFHj1VC2W2HTGUAXUialQnpK5PdhwYOcjPxH1QEcwUiOloR6jRPrH1Xj4yJ2qfpAeRV5UPiqbe8wt4nvjPt50di/T/gvs9l5e2IxSqF+ashY7LaS3xRMb6mrTLYbvyEgZRqxbc2pvAs7MQHq4BwXYrDmhNqe28qe1mQ/QbftvSAenJrzPSb0JwnjtX8xzCnSArOvY5+Sldy/qttw/gXvpLugh5HAElkbhDm2Hn4ZUnMW+qgwEIqKsfxQYj8TJt+P/ctsSvze5EqOJhqhiLcdKRlVLOj83xro/y0tqurG+QIZVaJwTACLwgzI2PfYLDAV/z/2uHrCeXsI7F7EQv7IY5+395Wa6t/yB9kIq6u6/Qk4zSY7/PHbOf6ftfW5ffsd63BDC4KqV57SfWGh+ODFvX7j+bzJWPrsg2nO9X/mX/r/qdWU4ZkA7vZYzbS9VdkGM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(33656002)(55016003)(83380400001)(66476007)(41300700001)(5660300002)(2906002)(38070700009)(76116006)(64756008)(66946007)(86362001)(66446008)(66556008)(478600001)(9686003)(53546011)(38100700002)(7696005)(6506007)(71200400001)(122000001)(8676002)(316002)(52536014)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UpJvo/P0A4iFxBUqbzdE08Y4Vk8HBqUtsxFB77pI85Alb5PNqWiKYtikW2Qb?=
 =?us-ascii?Q?zsO0xwiZhxjjbrIumizyP0p8doMygGtT73Rg+cHhctClTaSH7RxMXcRIVg31?=
 =?us-ascii?Q?5XLZeJHgLudExZ44L9yuxzfNDJ0/6+d8d9s3TWe5PAGVW6Da3bsfNnEeMHge?=
 =?us-ascii?Q?obRLkU8gGpSMKuuRIMze2pxRSQ2YlponSODaJq4gIl/wDzSm1YzvBmVVe0k0?=
 =?us-ascii?Q?6wqTdPBpFKcjvKdc8Jyu6rJeM8XfKDvPTjsrlkGLh9FMmFoC04RqpO5gNNxV?=
 =?us-ascii?Q?L58xnaicbbubzuE7xSD0xbRlX2hHc6fo2MAzaQt2lzMzdRpOFlY7TEdfiU52?=
 =?us-ascii?Q?Y2/5BywURGBpTAQd315GxMhQNlgzf3uRllbp5Xnappif3dYVhkxUDkfLJ1lV?=
 =?us-ascii?Q?j4+WG1+ziIIa06EU5fKW+hNQlHJZsa7TLeF9WXhBEVWI05LOcy12ShUW3GjL?=
 =?us-ascii?Q?95mnaJu8aqHSxmrPSoyNBHIs460xuOXwSmTl/5nkWYetkpHWg8oXyK8AVlBl?=
 =?us-ascii?Q?zPMe4HgAgYKZSo9Z/M4ET8nz8xZPnJMeaVL6Cg6iwY/5HpunwMGIejUrynZC?=
 =?us-ascii?Q?1J3wQXH77RGLeHzvEzsbTuyzz81ERZIVDx3toIwoeH1GlXrskExwhOozuN8E?=
 =?us-ascii?Q?jK1Iio8oxQYuzzdag97rUOW6zOBpOYZ8vd1Xye+cpwz/7i97kLZMMCWMq50a?=
 =?us-ascii?Q?cCkX76yQ445VS6xg51puTFBrVuyHqxcT4TwNwq5ER7FWcu2j6c0M4rCIzNe5?=
 =?us-ascii?Q?TXxIvT5aZITTOAUJyX2JtWBzETheLDxvLy6P3A1iUOyaRUVgGualahVKYx89?=
 =?us-ascii?Q?uQLnp3jyLdWvu8GOU9uH06ABe8HiPMHoo+q+MaRYuGrfZu1MXoKeZLTJ1jPj?=
 =?us-ascii?Q?YAKwxqoH1FSaPj19KT5pFAO85UKmp3aH0aRaouhBeekjRWLiayBcAXepSCa5?=
 =?us-ascii?Q?jI6oHVrsoJ+iXYTB0mo371cQodzRL8wqV8fBJyrayWcy+xxKXj6P1eMqQ0hP?=
 =?us-ascii?Q?l1KxC/8DW+WCw1jU39NLg08CXvOYxTSGm7hIpAC5lTllUR0rO5yHvBK8z+Bq?=
 =?us-ascii?Q?oWOMpPwY+W4Undo1VOBEn+FT0W9F9+4tTo1eEAgQJ3mlWwACdLdf5njIDIBq?=
 =?us-ascii?Q?MHAcoz7RoNl7lCjDCmSJDDvfALrO+zemMN+h8QQqGHXGKpV3oNNdjeJk94il?=
 =?us-ascii?Q?XpfxvOEW64V7JSsDtaDehF0dRurmBiWoSBqftrJcJNWKknMAVRwunF4PIFdW?=
 =?us-ascii?Q?VW6z8ArjbUmzoqnhDh0j7sCUSu9nQNizWCuGlgQqJPAtNXKO3uDpIMpOO68D?=
 =?us-ascii?Q?f4T8i8ghHNn+2QBh+9TT8z+5AdLhvpVGJeA3FrKbNVD1cbld7DtyjHrURlC8?=
 =?us-ascii?Q?/hMB7CQPnyxKrqGTNFUz3WBi5ttJC6MpZkCvYsrxvh5y5pi3ndMWpo0G/sP2?=
 =?us-ascii?Q?zaDEiHR6GpI8UztFUxWq2kNEZ3qoSGDDhyjaJDJc19rruf9x9mDvmbU+YMTV?=
 =?us-ascii?Q?kXI8z3M+tV2L9pGCUpUM6n0PmDlTbsBR6Fm6jA2dcJQ2+i93lXp+R1msv0w2?=
 =?us-ascii?Q?cqYgAO6G8DVJFq3ou5M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb88409-04a4-4816-10bb-08dc27fac0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 16:35:11.1997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94DxebtVG24cSoskU8Nz5ALDODguHVm2B/3pNfj0xt5KNYLgtD2CpcQTQ5WI3xu7fozGF2v4ezi210lubF6PNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Tuesday, February 6, 2024 4:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
>
> Its currently incorrectly multiplied by number of XCCs in the partition
>
> Fixes: 6b537864925e ("drm/amdkfd: Update cache info for GFX 9.4.3")
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3df2a8ad86fb..533b8292b136 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1640,12 +1640,10 @@ static int fill_in_l2_l3_pcache(struct
> kfd_cache_properties **props_ext,
>               else
>                       mode =3D UNKNOWN_MEMORY_PARTITION_MODE;
>
> -             if (pcache->cache_level =3D=3D 2)
> -                     pcache->cache_size =3D
> pcache_info[cache_type].cache_size * num_xcc;
> -             else if (mode)
> -                     pcache->cache_size =3D
> pcache_info[cache_type].cache_size / mode;
> -             else
> -                     pcache->cache_size =3D
> pcache_info[cache_type].cache_size;
> +             pcache->cache_size =3D pcache_info[cache_type].cache_size;
> +             /* Partition mode only affects L3 cache size */
> +             if (mode && pcache->cache_level =3D=3D 3)
> +                     pcache->cache_size /=3D mode;
>
>               if (pcache_info[cache_type].flags &
> CRAT_CACHE_FLAGS_DATA_CACHE)
>                       pcache->cache_type |=3D HSA_CACHE_TYPE_DATA;
> --
> 2.34.1

