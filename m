Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEE4C9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 13:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F53110E29B;
	Fri, 25 Sep 2026 13:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vZ6hW2Zv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013030.outbound.protection.outlook.com
 [40.93.196.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3107610FA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 13:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klq9fYzT76iYJmNxwzKqclJrXuA1S6h8GPdO+F9mKNW8foov5T9l1D1EZhXj3H1+fOvFOhtY8QAwYzAjso6pmEjt+LSpPgBrwW5fF/VB+MGrCfSo9gh5rAW6VAlRPkUHtxF8bsxzn9tJ+rQwRrV+rHE0W6qMJjCEvYngPe5iFE2RbN6GPTxkeGJt+ZF6Sb9//m0r3pWQULe+yBXhNHny154C/mUuqnZ3poRaDed1IhoWjpo/O4YN23cxzcCuFTKj5A3pAYD/5PfsIJ+5pV1+TRlBD4EzdFerGiM41pQd0EuJCQ32lNe1oh+UXe1/5VtT4bf8UgcxawgXsFTlgUsL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRcWKqubNQcVZmvqWmtetZDxLSH+P0d0I96eGoRdx5U=;
 b=k2aHvsXncy3ZvN3sbYIT6FnK0V9dj9ZVfg5Khc59XYBUAmWbXKeo8ZJi3b3TrystuULjjbs2LXVj5q5yfd4m8LzBr4M0f1/GZhzKpmxdWEdS5pafxXeMlVuvefJmr+ZWFxuDwZTVCDnzgGgbVXY9jNpF1AhZCyEAtqLSHOBd3nLdt/gN/x00+K7kLfQZT3iPkr6+PKYSEFWbB/66SFfcpJMx5p1Ob3ehgFtCxq+OsAfWms/ho8JBieNgxMQzA/5VTgrTfLviRVDZDmAyavb0RsjXtA2dv3XSYoYWvjJjklFubvs62F9EuTk8D/QofR67ATdeLjSdXGmjUhBbA+8Vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRcWKqubNQcVZmvqWmtetZDxLSH+P0d0I96eGoRdx5U=;
 b=vZ6hW2ZvjV+xVI/QSuUl7rJNAeaaSqWuRl4INv+C/hn7WPSOe4Hgfjou57+vhmysPK2ibX/Ma6JxIaYD5MgcABcJUcC2bnjSyGN/EREu6jAsm1/uFU6MkXFHsfIia0y1GSQhnWNP2sLlVhROESl8nWjvUnBz5C/HTzkfq0A2EDk=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:22:43 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:22:42 +0000
From: "Francis, David" <David.Francis@amd.com>
To: list amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Fw: [PATCH v4 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
Thread-Topic: [PATCH v4 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
Thread-Index: AQHdS5IOFgA1xDkjfUyeN+Tq4gk6KrbfLXOAgAAdO5I=
Date: Fri, 25 Sep 2026 13:22:42 +0000
Message-ID: <SA1PR12MB8144114FAB11F629984DE4ECEF802@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260923193035.1148578-1-David.Francis@amd.com>
 <fb467a57-b162-4bcb-97af-6100c9436753@igalia.com>
In-Reply-To: <fb467a57-b162-4bcb-97af-6100c9436753@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-25T13:22:42.053Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SA0PR12MB7004:EE_
x-ms-office365-filtering-correlation-id: 208afdc8-6a95-4fc1-7731-08df1b081471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: gFv0r4EIRVn3MNrl6hDDzmrtwJNRovQtwB87Dn1JcbWARcr7VnVd6DKzPvTOMh1mXrGL2nZx9/po3AkOXkphF+KgtR/YmB+SqTVt87Xb1A+/sZuLNa0KclCKFe7qpMSJX9q8lkQDqUTxu9TmNbKOARyhr0rL9Qw3MoSEqCy1JZvpjeA0/hlEIObjAKMm1vX+1IpBE+aPc4JkqIhcMCNeHerwCbe50sLj1Q1HJPUqUD5p9/EG/Sz+Zi7jmPvMCe+4dwlVa3zopfYCr8wtLD4xUvpJ8X69IjPEMWqdc8xDiyF+2o/9MPljo7/OWUHZOy2o/jh2+op5MjPk1zqVtJ3KmI7CvnsMatmlZZZAUunUSqp8Zu4+4KFbDNFa9DunLGH/5j4yota8hqY9HRcD+pbPUoo/bNVkvDVMts1xhuHrERGO0Wd+nPo3LALHfAh7fxmR+ylft6qLjce6FKXDyeZ1awo53HwlJH2S70czmpHl4iCDH5e/EzckJoK+QyScPl1jMkP4BsQAn2+OySHc0lmq5e1Gjulzn/M5nqAMp6PU3W0xAcxSiy3V4RRThTKZwN4B9kYoegofHV4iC+dlRnXgU2XYwIZzOtqh0zKPHwlNELihatPTTpWDG+hq3AX6CvtWv5p1abw/zV9sYGJCxzfwQxLa31TNkjv8ZANxCi73rwHBr9RlO5LjJPXZi4Lg41Z6HwJXM5nAKkl74ahjOHlDR1c4zOANDTarGdX9IMRAm/E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UF+ZQiT4S+7IfHtCyDUjUdEl8zWs+NuDmFKeon5mMjM3EYg1GfGCxUcBBr?=
 =?iso-8859-1?Q?br4agg1FzsmqgJ8FlHY8P+6ZYjQo+Pf7za52giZnfecX1SNm+FKGt3B+UL?=
 =?iso-8859-1?Q?gIp4MPUUPJp/8Or0tKZIXVHVazmhExIzGSBA1pykdaAscj1iVYDUAJAKcn?=
 =?iso-8859-1?Q?xtOg6Wm926QxCPGc8mbAI9rj10gh2soCW9AZpB45cFiER5t5v1kg2p6bfz?=
 =?iso-8859-1?Q?Rx/VWXZ5pdUPzjn+ovdEUZsRZhxHK7WP8p58LprmgTu1zGpQGZ/8IPqGhT?=
 =?iso-8859-1?Q?P5xisI8VbPjAR/QwsnHzkjJwlBueYSDkKBG++Ld/5om6DN/XD+6T0stlUI?=
 =?iso-8859-1?Q?kM6sRkZyba3IJ9lU7aMYlMejybQO+EQi4wZLr9CIIGDCmGtFAxfmIS7aA2?=
 =?iso-8859-1?Q?a4rrg8SinSJxyXT3gw8FgluHyKaMzmWT7AsQzvCR95go+uDkW6kBWcBxrs?=
 =?iso-8859-1?Q?I9s0flJXucxVbnu4s4AXqI1d6mxAh1CvzkNr2j97GF65YmD3TSfMfiiO9P?=
 =?iso-8859-1?Q?QBDSi8froqbNXsm5sem3ZM1AO3WrfffiZO2UxpP/TDbmLsWHeAwQkREX3b?=
 =?iso-8859-1?Q?Km131pJXAKhNawb+BqTnQY4xntBEiM1hDQjEcgp5H+KWtKQMUne6qiOBDO?=
 =?iso-8859-1?Q?B/UVT6tPBwoRrhU+PRfqDtJPEhu3wk9IqSPVuypIcrNPHxVOypJWgJWQre?=
 =?iso-8859-1?Q?lO+ZJ3/uyWClGMpQkrXdZlIl6kE87lAbk1h1514J20DhTw/NKjbszEeIT8?=
 =?iso-8859-1?Q?xstc2SvlzWdS7CSyah/BWWyTJsE55PVIGIH1aAfrCh+/xgtfU4f4MCL689?=
 =?iso-8859-1?Q?67Uqun10ZLpdk/ecexzuzE4TMglgvImUVn3TmuJg3xMZJ5CY0BWSaJCr7m?=
 =?iso-8859-1?Q?aqxw/tEvn6Na3gX8+Gb94spt19MEATLGIzP6mejTd560u7WNQXIcT3jXel?=
 =?iso-8859-1?Q?ICK4PEYPcU4Xb5P5M2fGdMw/yy6zM/wQ15D9xM1p0E0AvNQvPAAtUeRjjU?=
 =?iso-8859-1?Q?GYnu4GvkmImFnkEsvJB3JRr/erJABMVncUz3Ep0DHhh93/TkTV58CZITK0?=
 =?iso-8859-1?Q?AnszokfTHy2cKIYPc3D664ly5vk3udyoopr5xNJWJuc3o4lROJ3PGWazK1?=
 =?iso-8859-1?Q?OflGwd1b7rmtAIPq2VBcc4GczSVRsgUY0akOLYszMrHAy2aZNE3PN+Yd1K?=
 =?iso-8859-1?Q?Meo8XHNxylzxXdz4G4XWY5BmjJhiYRXCI1utcFFQmyaaLAUXX25cL/3R9+?=
 =?iso-8859-1?Q?InJ8VZI6Hxcl0+m4e+TbwpwFk5smQd9Y6giDd0RablYwXkSaHWoYD2flPr?=
 =?iso-8859-1?Q?kYdgwO+y2fni7z09iCNucuNR/OkS4pzucLk0NGdWmBqcunUhUaoCrODUgQ?=
 =?iso-8859-1?Q?cV/smDNaPdHoULIpee2se8yfY679lWhNsGy+ZI6IHN1Vzy5zylHBKiCgrc?=
 =?iso-8859-1?Q?8pu3I0mbf65JTrCfnaz1jXf+1vIk1SFh1HAqoDPU24QQX/6yecd9CK6BXa?=
 =?iso-8859-1?Q?75Ix6GouV6dMPfeprxEc6VDSKtu9yuUgruUuTu/Uw/EZVD80mWqgjAcdD8?=
 =?iso-8859-1?Q?BzWokirgg13j56ZpkwENkuX64wgKZDV6oQlAeZa/6QXr0a4UT8GoPJ1TRt?=
 =?iso-8859-1?Q?4fhn1VGXMQ0JmW0Rp2eMVwpeBMK7Ar0IpqX8Rcs1oZZDLzhKXnTslqbrUA?=
 =?iso-8859-1?Q?x1n+CsB3wddi9NYWE+3Cbyt88HYqt1vUkdZ2KZjFNRYJTUEgq20n9K21yV?=
 =?iso-8859-1?Q?k8p6FyHMwR2j7+TyyL5xYL8G+ufmVpanjc52jc0AlbnpFG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208afdc8-6a95-4fc1-7731-08df1b081471
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 13:22:42.5886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSmS0p7iyc4qXvWPXd9f2OGd4RPFHawr+KuPU0CNRNaB7FuMzjKAeKdDPQMmnZH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

=0A=
(Mistyped mailing list)=0A=
=0A=
________________________________________=0A=
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>=0A=
Sent: Friday, September 25, 2026 7:37 AM=0A=
To: Francis, David; amd-gfc@lists.freedesktop.org=0A=
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Add LIST option to USERQ ioctl=0A=
=0A=
=0A=
On 23/09/2026 20:30, David Francis wrote:=0A=
> Add a new option to ioctl USERQ which provides information=0A=
> to a process about their own user queues on the queried=0A=
> device.=0A=
=0A=
Device or file?=0A=
=0A=
> The returned data is in the same format as that used to=0A=
> create the queue in the first place.=0A=
>=0A=
> The interface uses retries; the user can guess at the number=0A=
> of queues required; if insufficiently large, the correct=0A=
> value will be returned.=0A=
> The same is done for the mqd sizes of each entry.=0A=
>=0A=
> This operation holds userq_mutex for its entire duration=0A=
> to prevent the queues from being freed or modified under it.=0A=
=0A=
Stale paragraph.=0A=
=0A=
> v3: Don't acquire xa_lock and other misc fixes=0A=
> v4: Don't acquire mutex either and other misc fixes=0A=
>=0A=
> Signed-off-by: David Francis <David.Francis@amd.com>=0A=
> ---=0A=
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 145 +++++++++++++++++++++-=
=0A=
>   include/uapi/drm/amdgpu_drm.h             |  40 ++++++=0A=
>   2 files changed, 182 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c=0A=
> index 3fe10d6af757..9338f6f4cc5f 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c=0A=
> @@ -850,6 +850,8 @@ static int amdgpu_userq_input_args_validate(struct dr=
m_device *dev,=0A=
>                   args->in.mqd_size)=0A=
>                       return -EINVAL;=0A=
>               break;=0A=
> +     case AMDGPU_USERQ_OP_LIST:=0A=
> +             break;=0A=
>       default:=0A=
>               return -EINVAL;=0A=
>       }=0A=
> @@ -857,6 +859,142 @@ static int amdgpu_userq_input_args_validate(struct =
drm_device *dev,=0A=
>       return 0;=0A=
>   }=0A=
>=0A=
> +static int=0A=
> +amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)=
=0A=
> +{=0A=
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;=0A=
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;=0A=
> +     struct drm_amdgpu_userq_list_entry *entries;=0A=
> +     struct amdgpu_usermode_queue *queue;=0A=
> +     unsigned long queue_id;=0A=
> +     size_t mqd_size, entry_buffer_size;=0A=
> +     uint32_t num_queues =3D 0;=0A=
> +     int ret;=0A=
> +     int i =3D 0;=0A=
=0A=
Nit - for me it reads nicer if the declaration block is sorted by width=0A=
where possible. Although TBF I do not know if kernel coding style=0A=
explicitly calls this out.=0A=
=0A=
> +=0A=
> +     xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {=0A=
> +             num_queues +=3D 1;=0A=
> +     }=0A=
=0A=
Can drop the curlies if you want.=0A=
=0A=
> +=0A=
> +     args->list_in_out.num_entries =3D num_queues;=0A=
> +     /**=0A=
> +      * If the num_entries buffer is too small,=0A=
> +      * return the correct size. User should=0A=
> +      * try again with the right space allocated.=0A=
> +      */=0A=
=0A=
Question and a nit - what criteria do you use to decide on the column=0A=
width for the comments? Like this one is narrower thatn the one below=0A=
which is even indented so has less space to begin with. It just looks a=0A=
bit wonky in my mind when this narrow.=0A=
=0A=
> +     if (num_queues > args->list_in_out.num_entries)=0A=
> +             return 0;=0A=
> +=0A=
> +     if (num_queues =3D=3D 0)=0A=
> +             return 0;=0A=
> +=0A=
> +     ret =3D check_mul_overflow(num_queues, sizeof(*entries), &entry_buf=
fer_size);=0A=
> +     if (ret) {=0A=
> +             ret =3D -E2BIG;=0A=
> +             goto exit;=0A=
> +     }=0A=
=0A=
Can return straight away here.=0A=
=0A=
> +=0A=
> +     entries =3D kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL)=
;=0A=
> +=0A=
=0A=
Spurious blank line.=0A=
=0A=
> +     if (!entries)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     ret =3D copy_from_user(entries, u64_to_user_ptr(args->list_in_out.e=
ntries),=0A=
> +                          entry_buffer_size);=0A=
> +     if (ret) {=0A=
> +             ret =3D -EFAULT;=0A=
> +             goto exit;=0A=
> +     }=0A=
> +=0A=
> +     xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {=0A=
> +             /**=0A=
> +              * The xa may have added or removed queues since we counted=
=0A=
> +              * them, so break if there are now more queues than entries=
.=0A=
> +              */=0A=
> +             if (i >=3D num_queues)=0A=
> +                     break;=0A=
> +             /**=0A=
> +              * Check mqd size. As with num_entries, return the right si=
zes=0A=
> +              * if they are too small. These sizes also serve as=0A=
> +              * versioning for the mqd. Despite the names, these are the=
=0A=
> +              * mqd sizes for both gfx11 and gfx12.=0A=
> +              */=0A=
> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {=0A=
> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_com=
pute_gfx11);=0A=
> +             } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {=0A=
> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_gfx=
11);=0A=
> +             } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {=0A=
> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_sdm=
a_gfx11);=0A=
> +             } else {=0A=
> +                     drm_err_once(adev_to_drm(uq_mgr->adev), "Unrecogniz=
ed mqd size in USERQ_OP_LIST");=0A=
> +                     ret =3D -EINVAL;=0A=
> +                     goto exit;=0A=
> +             }=0A=
> +=0A=
> +             entries[i].mqd_size =3D mqd_size;=0A=
> +             entries[i].ip_type =3D queue->queue_type;=0A=
> +             if (mqd_size > entries[i].mqd_size) {=0A=
=0A=
I'm afraid I gave you bad advice here and now the condition can never be=0A=
true. :( Sorry about that. You will need to go back to your previous=0A=
version, or a hybrid approach of only doing ip_type before the check.=0A=
=0A=
> +                     i +=3D 1;=0A=
> +                     continue;=0A=
> +             }=0A=
> +=0A=
> +             entries[i].queue_id =3D queue_id;=0A=
> +             /* userq prop handling */=0A=
> +             entries[i].queue_va =3D queue->userq_prop->hqd_base_gpu_add=
r;=0A=
> +             entries[i].queue_size =3D queue->userq_prop->queue_size;=0A=
> +             entries[i].rptr_va =3D queue->userq_prop->rptr_gpu_addr;=0A=
> +             entries[i].wptr_va =3D queue->userq_prop->wptr_gpu_addr;=0A=
> +             /* flag handling (AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_=
MASK are the only flags in use) */=0A=
> +             entries[i].flags =3D (queue->priority << AMDGPU_USERQ_CREAT=
E_FLAGS_QUEUE_PRIORITY_SHIFT)=0A=
> +                     & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK;=0A=
> +             /* doorbell handling */=0A=
> +             entries[i].doorbell_handle =3D queue->doorbell_handle;=0A=
> +             /* This is the inverse of the calculation used in amdgpu_do=
orbell_index_on_bar=0A=
> +              * doorbell_index =3D db_bo_offset / sizeof(u32)=0A=
> +              *    + doorbell_offset * DIV_ROUND_UP(db_size, 4)=0A=
> +              * db_size is always sizeof(u64) =3D 8=0A=
> +              */=0A=
> +             entries[i].doorbell_offset =3D=0A=
> +                     (queue->doorbell_index - amdgpu_bo_gpu_offset_no_ch=
eck(queue->db_obj.obj) / 4) / 2;=0A=
> +=0A=
> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {=0A=
> +                     struct drm_amdgpu_userq_mqd_compute_gfx11 compute_m=
qd =3D {0};=0A=
> +=0A=
> +                     compute_mqd.eop_va =3D queue->userq_prop->eop_gpu_a=
ddr;=0A=
> +=0A=
> +                     ret =3D copy_to_user(u64_to_user_ptr(entries[i].mqd=
_data),=0A=
> +                                        &compute_mqd, mqd_size);=0A=
> +             } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {=0A=
> +                     struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 =3D {=
0};=0A=
> +=0A=
> +                     mqd_gfx_v11.shadow_va =3D queue->userq_prop->shadow=
_addr;=0A=
> +                     mqd_gfx_v11.csa_va =3D queue->userq_prop->csa_addr;=
=0A=
> +=0A=
> +                     ret =3D copy_to_user(u64_to_user_ptr(entries[i].mqd=
_data),=0A=
> +                                        &mqd_gfx_v11, mqd_size);=0A=
> +             } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {=0A=
> +                     struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11=
 =3D {0};=0A=
> +=0A=
> +                     mqd_sdma_v11.csa_va =3D queue->userq_prop->csa_addr=
;=0A=
> +=0A=
> +                     ret =3D copy_to_user(u64_to_user_ptr(entries[i].mqd=
_data),=0A=
> +                                        &mqd_sdma_v11, mqd_size);=0A=
> +             }=0A=
> +             if (ret) {=0A=
> +                     ret =3D -EFAULT;=0A=
> +                     goto exit;=0A=
> +             }=0A=
> +             i +=3D 1;=0A=
> +     }=0A=
> +     ret =3D copy_to_user(u64_to_user_ptr(args->list_in_out.entries), en=
tries,=0A=
> +                        num_queues * sizeof(*entries));=0A=
=0A=
entry_buffer_size instead of the multiplication.=0A=
=0A=
The rest looks good to me.=0A=
=0A=
Regards,=0A=
=0A=
Tvrtko=0A=
=0A=
> +     if (ret)=0A=
> +             ret =3D -EFAULT;=0A=
> +exit:=0A=
> +     kvfree(entries);=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
>   bool amdgpu_userq_enabled(struct drm_device *dev)=0A=
>   {=0A=
>       struct amdgpu_device *adev =3D drm_to_adev(dev);=0A=
> @@ -891,7 +1029,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,=0A=
>                       drm_file_err(filp, "Failed to create usermode queue=
\n");=0A=
>               break;=0A=
>=0A=
> -     case AMDGPU_USERQ_OP_FREE: {=0A=
> +     case AMDGPU_USERQ_OP_FREE:=0A=
>               xa_lock(&fpriv->userq_mgr.userq_xa);=0A=
>               queue =3D __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.q=
ueue_id);=0A=
>               xa_unlock(&fpriv->userq_mgr.userq_xa);=0A=
> @@ -900,8 +1038,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,=0A=
>=0A=
>               amdgpu_userq_put(queue);=0A=
>               break;=0A=
> -     }=0A=
> -=0A=
> +     case AMDGPU_USERQ_OP_LIST:=0A=
> +             r =3D amdgpu_userq_list(filp, args);=0A=
> +             break;=0A=
>       default:=0A=
>               drm_dbg_driver(dev, "Invalid user queue op specified: %d\n"=
, args->in.op);=0A=
>               return -EINVAL;=0A=
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h=0A=
> index b32c72a662b6..92738d630eea 100644=0A=
> --- a/include/uapi/drm/amdgpu_drm.h=0A=
> +++ b/include/uapi/drm/amdgpu_drm.h=0A=
> @@ -332,6 +332,7 @@ union drm_amdgpu_ctx {=0A=
>   /* user queue IOCTL operations */=0A=
>   #define AMDGPU_USERQ_OP_CREATE      1=0A=
>   #define AMDGPU_USERQ_OP_FREE        2=0A=
> +#define AMDGPU_USERQ_OP_LIST 3=0A=
>=0A=
>   /* queue priority levels */=0A=
>   /* low < normal low < normal high < high */=0A=
> @@ -425,9 +426,48 @@ struct drm_amdgpu_userq_out {=0A=
>       __u32 _pad;=0A=
>   };=0A=
>=0A=
> +struct drm_amdgpu_userq_list_entry {=0A=
> +     /** Userspace pointer to buffer holding mqd */=0A=
> +     __u64   mqd_data;=0A=
> +     /**=0A=
> +      *  In: Size of mqd_data user-allocated buffer.=0A=
> +      *  Out: If mqd_data was insufficiently large, the=0A=
> +      * size it needs to be.=0A=
> +      */=0A=
> +     __u32   mqd_size;=0A=
> +=0A=
> +     /** Definitions same as drm_amdgpu_userq_in */=0A=
> +     __u32   queue_id;=0A=
> +     __u32   ip_type;=0A=
> +     __u32   doorbell_handle;=0A=
> +     __u32   doorbell_offset;=0A=
> +     __u32   flags;=0A=
> +     __u64   queue_va;=0A=
> +     __u64   queue_size;=0A=
> +     __u64   rptr_va;=0A=
> +     __u64   wptr_va;=0A=
> +};=0A=
> +=0A=
> +struct drm_amdgpu_userq_list_in_out {=0A=
> +     /**=0A=
> +      * For operation AMDGPU_USERQ_OP_LIST: User will provide a buffer, =
which the=0A=
> +      * driver will fill with information about all of that process's qu=
eues on this device.=0A=
> +      */=0A=
> +     /** AMDGPU_USERQ_OP_LIST */=0A=
> +     __u32   op;=0A=
> +     /**=0A=
> +      * Size of entries buffer / Number of handles in process=0A=
> +      * (if larger than size of buffer, must retry)=0A=
> +      */=0A=
> +     __u32   num_entries;=0A=
> +     /* User pointer to array of drm_amdgpu_userq_list_entry */=0A=
> +     __u64   entries;=0A=
> +};=0A=
> +=0A=
>   union drm_amdgpu_userq {=0A=
>       struct drm_amdgpu_userq_in in;=0A=
>       struct drm_amdgpu_userq_out out;=0A=
> +     struct drm_amdgpu_userq_list_in_out list_in_out;=0A=
>   };=0A=
>=0A=
>   /* GFX V11 IP specific MQD parameters */=0A=
=0A=
