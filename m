Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B95C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B699610E3E8;
	Mon, 28 Apr 2025 12:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JXU+r9a1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1310F10E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcQYQP7ZhUxn08YfA9xBcLnm3FWXy1XWCpRFAxL/JtUk8vj+wxfsmW3OgaNbD4/fVlrTkHsCYBCou/j188N+HMGMldbku/e1UvBYhD1duehp7JvSO/gLw5AFSHO6UH7TJF2sbBK/QN7MGeyjWacmEXG1GiouuG41+pE6UuWRgDNWbofYTlJ208qlb2242jFbIQHG/YFF9GJWS6u15XyMPdqpxrhCGnwgfu0vRgjLePtSShcSp/bbdHpRkGXn9qOAUTb/pg/++uSzOL9pEE87Dv7xfA4uRhtbF5LypG7bqA5Aoc4B9ecZtfOpuVLfm9Km7OlnvsRYh5F+80rOaD78Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jF9w9MJxAgYB4M8UjI6hd7HyPuSCzts13NsxESbqWo=;
 b=qixrKgzeVTIr+WQyP7zFuBQfGgyrBrToagaR9jJ3md54EN/HAnTbJW89/hiIQvNXBCqiVfSh/fJqnsAztUHuljz5EzGGEACeHWgqUMDuG+wHJvfaL28VElcw0fo+dFVGbAmYSffrcbr8tzhDXIMF3+XL2vU4vMn8HJIIIsZjp8NtAxF9LiDnHYt+i++i3tK6ggnXmsxSLAvfBol4Y0frwkCCYfKz1rdq04EiWpN4UXADcWNc+BYhjaXawq4xNfMlZHIfNl5sv5FFSPmo/pWFHjulGEUfgf5DwIrIo/0hxK67/4T+ZArPw2IA1FZSrL9xCwv/zkaTbvBLsuYQnL784w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jF9w9MJxAgYB4M8UjI6hd7HyPuSCzts13NsxESbqWo=;
 b=JXU+r9a1Kz4naxbTDirJ/Viu2DF7cQuREVcv4YYY15IMjVeBc1DzcNH9bDQTefB1rSZqIt+lnSUM5zlR8cGSnm1aVdUpJ8ghBYGC6azmZd/ufEoZL9YGJQmENnRQFey+Yt1mrma4xMDmGvqPClOr9rsqP6KSoxRUSw7Y1rwxoNE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 12:41:26 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:41:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/userq: take the userq_mgr lock in
 suspend/resume
Thread-Topic: [PATCH 1/2] drm/amdgpu/userq: take the userq_mgr lock in
 suspend/resume
Thread-Index: AQHbthDApvo2wUFybkGAZRKYALQb4LO5CYIw
Date: Mon, 28 Apr 2025 12:41:26 +0000
Message-ID: <DS7PR12MB60058658F68DDF4F779CABA3FB812@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425183428.162862-1-alexander.deucher@amd.com>
In-Reply-To: <20250425183428.162862-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=97e264d2-eb69-4cc4-9d5a-f820cd1a5af3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-28T12:41:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4354:EE_
x-ms-office365-filtering-correlation-id: 54c60497-ad86-4e3c-7d74-08dd8651fdb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KHMHHdJTZ4cNdsGXY4eFHhocBTPZNWwkGIUScSGAO6HHw6LuDEIcTkBc2xGA?=
 =?us-ascii?Q?9iAXdusuUTP3oLmP28RrJlMnwA18vXB+Hjfn3u2L/NIybuLus2ZaJfhuf7iM?=
 =?us-ascii?Q?ccFU1Jjz1DvXpK7m02n2AcwDROIGaq13lHE6n2jVM/dfB/8wfwH+1wQPTv7s?=
 =?us-ascii?Q?i/ExpKvsyKlGpE1O6o4ciXmei330OCbqZtsnF4tIRrLLP3VZiOjDN55u1JBH?=
 =?us-ascii?Q?pbk+wzGbMgS7mMOtw2uGwHksa5Se5fNnGva0dOpnwe+ZMDeVOrKMNa9YXvO0?=
 =?us-ascii?Q?OK5OTq81q85qkqfgNPb+dcEaZ3FlfR5SRISe2QpR6tIKiSfMFiIGDHeSdCOx?=
 =?us-ascii?Q?wzoNAZie89aFeEnLbyQGgB3wuMGZdvCZZDeXm8PyWl+Q+ZDzcVEpJd+WgXiu?=
 =?us-ascii?Q?rMJT8saPUH2yNPWNDxzER5hevDNdC5Jk+ppr2MVJ7P+Ht1r9GCuttRWl0Yn9?=
 =?us-ascii?Q?R6mco+eWM0XX8jsoZiqg4cn3nHJIAPNaRUUy8cv6RS6/rTqYyW71zmhfiUxg?=
 =?us-ascii?Q?y2BraNhT/ReCe5ywdq7SnFuHiueEQyE2IvZJez9OAljJ7LhNGqa8A2RFbLhv?=
 =?us-ascii?Q?ypNUoeD/GrcDfLcsyv6u6cufoJDPgO6/gKHZnDiURmxTBq5Pt7bZIJ9k9Rjp?=
 =?us-ascii?Q?GPAV7jESI8bauFY7SH+IOpUtpTda1LGDnU0fdZTgwmD2LBatoRkO7vTPLyGK?=
 =?us-ascii?Q?AE7/m/e5UuIgC6ziOCoIbnJMFqdw6+eQdDfjCZwCsg7TSetUUtpgrqLw78oy?=
 =?us-ascii?Q?W+g4rvRBWXm1GQLwMT9PehJDobgiek09QvHlSGWCAUfdq92dBHiTs0ET53bz?=
 =?us-ascii?Q?B/HU4/rxrMcb851xYkM6a2Y3Y6a4uMdS+rB7e/SWbhMw8t152iW/e3cF4yVj?=
 =?us-ascii?Q?1Qvc9x0eGjDaNBvimmjaVhFrPjq74Tt2xgOlpxPcADHmALVn6bfl3CDZzprf?=
 =?us-ascii?Q?im7gmuh2MyZlURwkvvUOQnYOIaJumsTuETneW05iN5D0WNz4+yvh24HVBsKf?=
 =?us-ascii?Q?9ROhTUmRJH85QNmlAjjejV4RVKThozO7wTEue3LEGNIfllTgMnAqvhnINkZA?=
 =?us-ascii?Q?5iYNaxUR2zU5YCNuVE7Yuz43pdEzktoAA0xbx95qyWp3YEBZ2vOAVt+wqPtI?=
 =?us-ascii?Q?XUd+JQNEZoU3GlrG5KtZ22kZYR73s693OAsNYhgw9rI+puSwqiG2rn99wsP5?=
 =?us-ascii?Q?s/ioFibuoDqlQJyYSHKMvbdYOgO1/MMrslqQp+Q1SNyy0p+gjb/wKVO8sDKO?=
 =?us-ascii?Q?R51Wk/llPyPEgyuX6ygOxZZOzvKBkoPKsvcXdlsyOJFHYX9wg8gpQK0BlG0y?=
 =?us-ascii?Q?tcDuXiYl/R6LrAlXMjxHLCd4OZ+UHM9qQGZBCEuVFMdzYbm1dYQu6K3oGkLq?=
 =?us-ascii?Q?MK3L/kOdxY0ERIQ1SEEOiwflsSYuW7/Rb6taLZjEUH7rD/ayrZEX2Qutt9Di?=
 =?us-ascii?Q?IRSoZUMW5GIX5jdFfCT1xiZWBNXJcFphcwLSPxdOHnlOwMnJy13US5im2neh?=
 =?us-ascii?Q?+FvTKy+Yqxw24K0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QzyWPEnJSZy/ltoQUfKRXWSxZcHBqaIkzxFr/DLN4nXU51J+8bq73UujOluc?=
 =?us-ascii?Q?Dyky+cti4EgTX9+HScej/iApFAMqtjgyS3rdLlNC8tzgIRoYMf9p+yZEYFvg?=
 =?us-ascii?Q?wI8Zgtc9/huY2pEmO04hhNFD6GOML61P6lTbNdcHeyXJHGYRp9k/f1qAKa4m?=
 =?us-ascii?Q?+I4r5hPCnHOak46AWCPs7KA/6uTS3joRSX/+Vs+sv+FF8aJVJJ9DIAj5eXJi?=
 =?us-ascii?Q?g/C2LUkslx1ztmq2FHJYVnZtJ4/C48wi5EtdrnYEdJ+IzCT9YFOt6j7BPgxP?=
 =?us-ascii?Q?o7GCxlccn9LkRUsslWvWJznvAf37dMR6lbwne3vpy8gqy/ytyIBlndmltvPf?=
 =?us-ascii?Q?p0FZVQtNOUHgcAZ3Uao8fRyOFzegJRQTQtWKZmHZbW8URbTeVQMvVfBJwlYh?=
 =?us-ascii?Q?pI8tqmvMGQ/06nlL4nJu8IWAYXxQkRMAvxFLMrxlyDB0E+BwFV9bL4hSf8uS?=
 =?us-ascii?Q?3rUh7S+ZNadVzUKlndefYLYZHy/+gNS4u1oRKGpZ3d1Zv6v+tHMjmp79HtGE?=
 =?us-ascii?Q?q3rolsf5KR4X8+Ck8BycGJn9dKpJwO6+1MxBxuG/8pgn33xAIbpvxMX/kX05?=
 =?us-ascii?Q?zR+71xH0p5//eDIHJvW1+82fwYOxNId8oSk2NqX4kwxsYq52S6Rc+Zg4lij/?=
 =?us-ascii?Q?G7Gs/Jp3mQVBFsaonFn+86fEKfq2LgAlKodIldSxO8YCc5SvPpJOLzVVwjCl?=
 =?us-ascii?Q?KIlv/hTKvKhJF3TwZznGlB2s/dV7uPJ5Bj53kbIZ2y2XPu4aTEtPR8bFNLgv?=
 =?us-ascii?Q?M88olU2s18Zbg00QWrA4aCAwV4GWnxSP4cpg1ECJCulXSdNWXdow+GpIlZly?=
 =?us-ascii?Q?4T8taSYQzTJJ5GjqJRhm4rA8yorteMJbuIKN46VcCPU1DMHIIYtYSrJBYUYJ?=
 =?us-ascii?Q?gHkpTXDiH45AsjzT0fnRX+p+TKTpJVGhzPtMdlliH13MqKP9tinBTWKfsYRY?=
 =?us-ascii?Q?FOcWinZlTM4GzJEtWUOaNdZyP4xKRK/XktdQ9UtMZfI2nB/nvCq70wZsnJSP?=
 =?us-ascii?Q?7DK9nTgTxlLEJ3fEw7PR/zU8v9JUx5KiHGhS3KFSzYOJPOd6oS3PKpqd1wQv?=
 =?us-ascii?Q?IfEMsqcMraqyGShsg35LCZ+sWjmDRIJWLCd3J8onY4xMT+07VJEWjgATuudf?=
 =?us-ascii?Q?XFEV7KZVDS0l7CGoWmDjOTHqBZuaS9lkHsc5d9SsEzrJz06cmMfGDYJPsye4?=
 =?us-ascii?Q?nimbiuTUddAHlv2LQ252i2KsiPOn5MFQX/QqAZgwi+XSC2Sh44X090WQUSbd?=
 =?us-ascii?Q?fxD5jMjWkNVf4IcPlJ5dsGihqwsQTnXbrrBhIRegmQliGYUJPjzVox0QysNH?=
 =?us-ascii?Q?3cerMOOsFsB0w4cQ1ZG0REtk+uBheiTjDp4qnxMW+q6+7fKnalltJDyRxFMG?=
 =?us-ascii?Q?6vxyisCOL6wKH2U0rOr3dvYEbSgOOU4IztSCEFEgma5Z+aLuIaYOoWr0xlTx?=
 =?us-ascii?Q?QYU6MiUYtBax3IA4oADP632zuNnr++dxgoTdVIVq8yDn2reCATbv+3XOJNEE?=
 =?us-ascii?Q?zVSb31phST+KO/FFoK1v3JA2GLvvaur/LDgBDTr6+/9mE528+G2Uu2eft74w?=
 =?us-ascii?Q?5WQshqzPzA0/jZGDVcQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c60497-ad86-4e3c-7d74-08dd8651fdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 12:41:26.2977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zN5RXZgUL4PZ3LXF3gJgP88yTQEnGkMwUmulNk0YYjBiUg61wNu5ilqmii/6xE9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, April 26, 2025 2:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/userq: take the userq_mgr lock in
> suspend/resume
>
> Add the missing locking.
>
> Fixes: 73e12e98ec0c ("drm/amdgpu/userq: add suspend and resume helpers")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 451890ee3fb79..1fa9d2be87f39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -809,11 +809,13 @@ int amdgpu_userq_suspend(struct amdgpu_device
> *adev)
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               cancel_delayed_work_sync(&uqm->resume_work);
> +             mutex_lock(&uqm->userq_mutex);
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                       r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                       if (r)
>                               ret =3D r;
>               }
> +             mutex_unlock(&uqm->userq_mutex);
>       }
>       mutex_unlock(&adev->userq_mutex);
>       return ret;
> @@ -832,11 +834,13 @@ int amdgpu_userq_resume(struct amdgpu_device
> *adev)
>
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +             mutex_lock(&uqm->userq_mutex);
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                       r =3D amdgpu_userq_map_helper(uqm, queue);
>                       if (r)
>                               ret =3D r;
>               }
> +             mutex_unlock(&uqm->userq_mutex);
>       }
>       mutex_unlock(&adev->userq_mutex);
>       return ret;
> --
> 2.49.0

