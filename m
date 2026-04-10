Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EADF44872
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 14:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA0810E961;
	Fri, 10 Apr 2026 14:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4cEM0fW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5896C10E961
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 14:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sznUBSFf1UmdS2n4B6jRvISc9TsPd0IPHbjsbQse+4cxqS40VBNiWNjdloz320PZwaPvw9pwFad1dRPgzxts5SEmFVFfxwnnVW29pAPwNTfRgo/iq5wHJtTSjqFJHe5zv98Fnfs7NmApQ+brh5ET3E7Pn4rP19UXVdaiWPEzqW8n5WdhTP6YkJgXd5nRPlIMozQ69dyxwcZcklaO9hvLH1TLoX9oZrN1dokoPOMd2PPIxZiQlFTGdzWOpEa1LNeip5KZK++Vp+R+Sfh7t1FMoDLz6+iDpmc6p8ZhPTh5lzuCS9nG7q/9w+c/mgEMycDNyKzS9lQK4TKmqM6fytCbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj8PBYlr3J/IuyyVWecM0xv8aI2GxB2QH/VOHaWBL6w=;
 b=Jjs3PBmixbqtd8VrwVeD6PdqBfgeptDmCTUsaatVI9eE3weKIEvo5ZVdfvVWd3+VqJSbofsp390XNooDAJhLAMVnsMsloHs1Suy5IkN5W12M1PNXek1t9ZwC1/ZIilbEA808iF6S9+m4FGjQEVT2O/S+CZXOk2onE0DGNxb334dpdWqumDP8ZVdey/UTwzxmCFI+W/cexwBoNJSkZYm0iQiUMxFI6Ehd8Otw6nPn80rwWhDJAutKds2SGYxbGW3FSxWtwIQ0hlv8FyP3Bn1pSdi/p16gXv9+qwTEHhVCUxhMqtNpOgFvLXBSnDPO+CaWPhix4Z4DWHO3BjJXgGb4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj8PBYlr3J/IuyyVWecM0xv8aI2GxB2QH/VOHaWBL6w=;
 b=X4cEM0fWlYw3zmnerfVFF+fuw34GcbqsnwgUZMmJt8mspUulv4XMg+zHE7yz3Jc2ed/y07T25/VDAUgMiDmqlB4Yv96KgKMpiP1sDKeSjLqe+2f/teOVYT6Or98mPn4uXM8yzPzXmMFnD4USv2ZsfVJZvok7b8SmY9IXwdUJgu0=
Received: from DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 14:07:57 +0000
Received: from DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41]) by DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 14:07:57 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Change gpu_metrics over to binary with
 per-reader snapshots (v4)
Thread-Topic: [PATCH] drm/amd/pm: Change gpu_metrics over to binary with
 per-reader snapshots (v4)
Thread-Index: AQHcxeIP3Lf8DmWm5U++1W55H0cZVrXYWQYAgAAAbbk=
Date: Fri, 10 Apr 2026 14:07:57 +0000
Message-ID: <DS0PR12MB799330CC19869C8674FA69F5F7592@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <20260406162553.25281-1-tom.stdenis@amd.com>
 <04b995f0-6edb-408c-8468-9fea7ad828a1@amd.com>
In-Reply-To: <04b995f0-6edb-408c-8468-9fea7ad828a1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-10T14:07:56.606Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7993:EE_|DS0PR12MB9039:EE_
x-ms-office365-filtering-correlation-id: 0e965ce0-2dd5-4c12-e399-08de970a90fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: eHfoaCc8ViQ/WMUJeefxUi8UisOVtC9rXPSHHGFHZil/JaXYwgfQ6amxGWj9ikZTfYR+3LTnHjsgnHvnypaybLxWfZ9PyIMg3z54NTMgbE3RLQH4vHt/Z41pSA74lb2/nwP52bLeHMHgVRrSBklSWKa7HcP2WcafMzZp96G19RoqhYByIk++/yD6A8VeYfDB7/Bgp6WWhykAYVXdU93y29MxLxAveoktisjY9OOBzGRm0m1Qb8Joo+5J3tQcJpzZuJIXChKwg1Axc3hbzpDU/Z6zUfq8eMwdvNcMivwnOS+hN2s3Ai6Dz8BsvuRKBnOcxc1emosPYQ+54C8ORHlZwUn8EXUIREtBOY3QnIWtTt0YQxMdAoVPPp0aCnA+Wq+lgFJYdn6I56Kjos4dNpokCwJxW0IzF8fw350Q0J3K0TjAYdPRt3DeWzaVCICSM9dc+/1Mlr/Y72cZdxvzjus5uEbGp+9s/7En5a14KNV5HFjHo8DRJL6jlaIjkqe/rvITbgKSu0NAXaWCIZrGzHITb9EhRVfeHMeorXA8ScbKY8hXMts+v2lB6lM3xqraI1Xc2M/eAqGIYRnDJ0jV5B0IZMeBDjTWrmanjZ/SpYYcCIxqYcmHuVn7ERovo74AoEu6jCH4+jEaUdV37E9xb1VHdipbyWHEPd3vbUoo36rqo99ZIrZA9erIWFUJu55fwr489nCk4eBHwdOUz6wTrCzNGedB7A0gSxFBvb3+yM9oPERJdCbL9V+uwJhtPqbNBPom3F2E+1JiGp62QLMRpQ0PhGsiwHkIWSGnJZBPgKogbu0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?NVyNauqc3mEav8qEqinsRq9XnFo5xxeFcgxZs/hWWiE79nV+NH79kqE1?=
 =?Windows-1252?Q?60Mex91X4lKcVms+EX4jGLPCONV/6s22lu4wDUXCmHK4SGiQbqpMtInv?=
 =?Windows-1252?Q?lQf85EnIk+AepnGbxnXYJL9gjCl+8YQyOMMN5JhWsT9yl+vqhvooRBmM?=
 =?Windows-1252?Q?QBxg5xSCbiywqkGv/JeXyJt0HA0bZQru5wb1Ra4NPCuALBBkk+8uXaxk?=
 =?Windows-1252?Q?7vfDJVqh1WLEeTvgMbX3xHqJpNpm/3Cp2TeVpazGGBlDceGR1HKXpSLN?=
 =?Windows-1252?Q?N2vSG5NELqQckS1UIBBbvWOWh72OE2QTGxwLAnuN8/T0a24OEWXJTPKI?=
 =?Windows-1252?Q?Wa+OtbuujajJ+I/qUETwyzgemqUiODM+w/ct5H2QzAXQH5E8IeVfjrws?=
 =?Windows-1252?Q?76BLmGdetw4xYqMtF2hWN2AWs8qrLWxsRARQLKmFv7+j+2XITNGpot47?=
 =?Windows-1252?Q?8OuKi7juZsOVdhHxnG5rJHUHHMJfI0BvZxLZzJLrkbrEtwR6qaHe7Saj?=
 =?Windows-1252?Q?dsPq+DXl8Bm3P6KIdZPV7FoS9c0UeQ+/KP1lFud5al5JlX39fKOVOZBO?=
 =?Windows-1252?Q?Y/fPJaVzYqCk0z2V4Xi857Ro4b2bVal3AH1LBMDWn4QbIctWjCzBbqA5?=
 =?Windows-1252?Q?rKL88BOQgtdL/3pg60jKyYFCW4WKQ2kFzIWc3JLsTNUkLqyIXJXHUIpV?=
 =?Windows-1252?Q?QCigcdwynPClJO7ybwVxyrcX7upuISGbul+JDuUHiMdq+EwvzIoiTErP?=
 =?Windows-1252?Q?em8iJVwSPTZvQjeSC2anHpcE+u9Iz1UbNIup3kDjhZwBRfDWfHwyrFMZ?=
 =?Windows-1252?Q?l4wmQHtGh36HJ1xaem9/u+fQBblb+zq9ECcmxCSYjWWMGt3nLgwE8N8q?=
 =?Windows-1252?Q?7s7rXspscDW1qLSrbRB2VmLaeknYoPn2vzj4QdSQ7JkgwfYXQL7AUeOu?=
 =?Windows-1252?Q?jNmX4DSQO8hcP4i2ZmK2vMVKYlohCF8ChsmrOWotm7g7RoZU/ZrRBbBo?=
 =?Windows-1252?Q?6WjhVg8yrGEgNeT2NpP34YNn/5FNl9McrttES+1decB//3oyLtbLd3yo?=
 =?Windows-1252?Q?sYFM+UGJRzXxfdXBY+H73LxWWV69DoQSRApyQuJc+AwWQE6fnehMwZsN?=
 =?Windows-1252?Q?GgBMXkaHA5eQPxUs6Ouw4KcET1Od3lFje08IOGb0DWJ+pdZbN4W1ttCz?=
 =?Windows-1252?Q?GTqmSWRqjjb6ijLXupp8CAa8wlYjmd2sdJYpquGU8IPWgvotm9C5S4e4?=
 =?Windows-1252?Q?x9kBPyOkezhVGverG8g9qP58Wrx0rObWH0AD2cxoDCOdr44xZUtACxub?=
 =?Windows-1252?Q?wt/4bATKs3f1Wz06tRQ7YMviqGUzAfLEId6/bwBhYoETFz2KkKc53Yr6?=
 =?Windows-1252?Q?csTtQWd+LeE0mkn33swYoclsdTp8OnSjLBygAhgwwtR2PoNgQC13utUD?=
 =?Windows-1252?Q?2QBrd/EvcndAfOiLfq+WWHn2qSZXiAPc24jJULsSqLDbVHsffi9taeHF?=
 =?Windows-1252?Q?04ioVxaEmiG0RJi0o3kQ1MTb26RUBH3G0XYiY2IkFFFAGMadU3u936BR?=
 =?Windows-1252?Q?F1fqkb5QurYJoz64duyF3vGYXh0I2HeCIXSfTpbDafb6C2FhOszsIckA?=
 =?Windows-1252?Q?m4/VkFczvkhBg7e3oCWaYzTXPhs0CeO07Ru12RE4OBLOe/0p/1Aiybcv?=
 =?Windows-1252?Q?j70YRzNcuTnVJezxMDsNCRy+po+ZdEDWBb4Tqe4LiFk98W6rs8pDVIt4?=
 =?Windows-1252?Q?55hzrJOeAZFMSifcwOBixe42WLD0bSfF5fLOdqnyZlISgPYAEAwmePAG?=
 =?Windows-1252?Q?/ePlLc9+ntXdju6QAjxs4q/VrhMBMoNPvfWt8wgOhAjzRGjX?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e965ce0-2dd5-4c12-e399-08de970a90fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 14:07:57.0884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxftiFxpnSXkzr+uBzKVtjdnmlaN6c1P+NHlpuvMMz5jlC9/nERDrxMkbf6lXeO27Yg27hfodtfLRBizNAUrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

Reading GPU metrics has several constraints that weren't being honoured bef=
ore:=0A=
=0A=
- reading from offset >0 should be from the sampled data when offset=3D=3D0=
 was read so it's coherent=0A=
- support >4KB gpu metrics=0A=
- use binary attributes=0A=
- ideally for a given file handle you should invalidate the data periodical=
ly (so you can keep the handle open and seek to 0 to capture new data thoug=
h the invalidation should only happen on an offset=3D=3D0 read)=0A=
=0A=
Not really arguing one way or another if this patch is correct/ideal just s=
aying what/why we're doing this.=0A=
=0A=
Tom=0A=
=0A=
=0A=
________________________________________=0A=
From: Koenig, Christian <Christian.Koenig@amd.com>=0A=
Sent: Friday, April 10, 2026 10:00=0A=
To: StDenis, Tom; amd-gfx@lists.freedesktop.org=0A=
Cc: Prosyak, Vitaly=0A=
Subject: Re: [PATCH] drm/amd/pm: Change gpu_metrics over to binary with per=
-reader snapshots (v4)=0A=
=0A=
On 4/6/26 18:25, Tom St Denis wrote:=0A=
> The gpu_metrics sysfs file carries a binary blob but was implemented as=
=0A=
> a text device_attribute, which imposes a hard PAGE_SIZE-1 cap and makes=
=0A=
> it impossible for userspace to distinguish a successful short read from=
=0A=
> a truncated one (stat reports 4 KiB regardless of actual payload size).=
=0A=
>=0A=
> Convert gpu_metrics to a bin_attribute.  The declared file size is an=0A=
> upper bound (128 KiB); the real payload length is the byte count=0A=
> returned before EOF.=0A=
>=0A=
> To guarantee that multi-chunk reads (which kernfs splits at PAGE_SIZE=0A=
> boundaries) return a coherent snapshot, each reader (identified by its=0A=
> struct file pointer) gets its own cached metrics buffer via an xarray.=0A=
> When offset is 0, PMFW is sampled and stored in that reader's entry;=0A=
> subsequent offsets are served from the same snapshot.  The entry is=0A=
> freed on EOF.  A mutex serialises xarray mutations and PMFW access.=0A=
>=0A=
> Stale entries from readers that close without reaching EOF (e.g.,=0A=
> killed processes) are lazily evicted after 30 seconds whenever any=0A=
> new reader starts.=0A=
>=0A=
> This per-reader approach avoids the cross-contamination problem of=0A=
> a single shared cache: concurrent readers each see their own coherent=0A=
> PMFW snapshot rather than risking one reader's off=3D0 overwriting the=0A=
> buffer while another reader is mid-way through a multi-chunk read.=0A=
>=0A=
> V3: Per-reader snapshot state, so each open fd gets its own cached=0A=
>     gpu_metrics buffer and all chunks for that reader come from the=0A=
>     same sample (Vitaly)=0A=
>=0A=
> V4: Remove the residual PAGE_SIZE cap that v3 still carried over from=0A=
>     v1. The whole point of the bin_attribute conversion is to=0A=
>     lift the old PAGE_SIZE-1 limit, but v3 still had:=0A=
>       - WARN_ON_ONCE(len > PAGE_SIZE) with silent truncation to 4K=0A=
>       - kzalloc(PAGE_SIZE) for the snapshot buffer (fixed allocation)=0A=
>       - a separate memcpy from metrics into that fixed buffer=0A=
>     In v4 the snapshot buffer is allocated with kmemdup() sized to the=0A=
>     actual payload returned by amdgpu_dpm_get_gpu_metrics(), so payloads=
=0A=
>     larger than PAGE_SIZE work correctly.  The only remaining upper bound=
=0A=
>     is AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ (128 KiB), which is the=0A=
>     declared bin_attribute file size and serves as a sanity check =97=0A=
>     exceeding it now returns -EOVERFLOW instead of silently truncating.=
=0A=
>     (Tom)=0A=
>=0A=
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>=0A=
> Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>=0A=
> Change-Id: Ib4fa233d9a25a396f1cc7d5fcf74f5f6578329f5=0A=
> ---=0A=
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 208 +++++++++++++++++++++---=
=0A=
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |   4 +=0A=
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h  |   1 -=0A=
>  3 files changed, 188 insertions(+), 25 deletions(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c=0A=
> index a4d8e667eafb..303a2d643b10 100644=0A=
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c=0A=
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c=0A=
> @@ -34,8 +34,19 @@=0A=
>  #include <linux/nospec.h>=0A=
>  #include <linux/pm_runtime.h>=0A=
>  #include <linux/string_choices.h>=0A=
> +#include <linux/sysfs.h>=0A=
> +#include <linux/sizes.h>=0A=
> +#include <linux/xarray.h>=0A=
>  #include <asm/processor.h>=0A=
>=0A=
> +/*=0A=
> + * Sysfs reports this as the file size (stat/ls); kernfs also uses it to=
 cap=0A=
> + * read offsets.  Actual payload length is the return value of=0A=
> + * amdgpu_dpm_get_gpu_metrics() and must not exceed this.=0A=
> + */=0A=
> +#define AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ   SZ_128K=0A=
> +=0A=
> +=0A=
>  #define MAX_NUM_OF_FEATURES_PER_SUBSET               8=0A=
>  #define MAX_NUM_OF_SUBSETS                   8=0A=
>=0A=
> @@ -1734,43 +1745,170 @@ static ssize_t amdgpu_get_pm_metrics(struct devi=
ce *dev,=0A=
>   * DOC: gpu_metrics=0A=
>   *=0A=
>   * The amdgpu driver provides a sysfs API for retrieving current gpu=0A=
> - * metrics data. The file gpu_metrics is used for this. Reading the=0A=
> - * file will dump all the current gpu metrics data.=0A=
> + * metrics data.  The binary sysfs file gpu_metrics is used for this.=0A=
> + * Reading the file returns the raw metrics blob.  The sysfs file size=
=0A=
> + * is an upper bound for inode metadata; the real length is the amount=
=0A=
> + * returned before EOF.=0A=
> + *=0A=
> + * Metrics are sampled atomically per reader: the first read at offset 0=
=0A=
> + * captures a snapshot into a per-fd cache; subsequent reads at higher=
=0A=
> + * offsets (for payloads that span multiple pages) are served from that=
=0A=
> + * same snapshot.  Concurrent readers each get their own cache.=0A=
>   *=0A=
>   * These data include temperature, frequency, engines utilization,=0A=
>   * power consume, throttler status, fan speed and cpu core statistics(=
=0A=
>   * available for APU only). That's it will give a snapshot of all sensor=
s=0A=
>   * at the same time.=0A=
>   */=0A=
> -static ssize_t amdgpu_get_gpu_metrics(struct device *dev,=0A=
> -                                   struct device_attribute *attr,=0A=
> -                                   char *buf)=0A=
> +=0A=
> +/* Per-reader snapshot entry, keyed by struct file pointer in the xarray=
 */=0A=
> +struct gpu_metrics_snap_entry {=0A=
> +     void    *data;=0A=
> +     size_t  size;=0A=
> +     ktime_t timestamp;=0A=
> +};=0A=
> +=0A=
> +/* Evict stale entries from readers that closed without reaching EOF */=
=0A=
> +#define GPU_METRICS_SNAP_STALE_NS    (30ULL * NSEC_PER_SEC)=0A=
> +=0A=
> +static void gpu_metrics_evict_stale_locked(struct xarray *xa,=0A=
> +                                        unsigned long skip_key)=0A=
> +{=0A=
> +     struct gpu_metrics_snap_entry *entry;=0A=
> +     unsigned long idx;=0A=
> +     ktime_t cutoff;=0A=
> +=0A=
> +     cutoff =3D ktime_sub(ktime_get(), ns_to_ktime(GPU_METRICS_SNAP_STAL=
E_NS));=0A=
> +=0A=
> +     xa_for_each(xa, idx, entry) {=0A=
> +             if (idx !=3D skip_key && ktime_before(entry->timestamp, cut=
off)) {=0A=
> +                     xa_erase(xa, idx);=0A=
> +                     kfree(entry->data);=0A=
> +                     kfree(entry);=0A=
> +             }=0A=
> +     }=0A=
> +}=0A=
> +=0A=
> +static void gpu_metrics_free_all(struct xarray *xa)=0A=
>  {=0A=
> +     struct gpu_metrics_snap_entry *entry;=0A=
> +     unsigned long idx;=0A=
> +=0A=
> +     xa_for_each(xa, idx, entry) {=0A=
> +             xa_erase(xa, idx);=0A=
> +             kfree(entry->data);=0A=
> +             kfree(entry);=0A=
> +     }=0A=
> +     xa_destroy(xa);=0A=
> +}=0A=
> +=0A=
> +static bool amdgpu_pm_gpu_metrics_bin_visible(struct amdgpu_device *adev=
,=0A=
> +                                           uint32_t mask)=0A=
> +{=0A=
> +     uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);=0A=
> +=0A=
> +     if (!((ATTR_FLAG_BASIC | ATTR_FLAG_ONEVF) & mask))=0A=
> +             return false;=0A=
> +=0A=
> +     return gc_ver >=3D IP_VERSION(9, 1, 0);=0A=
> +}=0A=
> +=0A=
> +static ssize_t amdgpu_sysfs_gpu_metrics_read(struct file *f,=0A=
> +                                           struct kobject *kobj,=0A=
> +                                           const struct bin_attribute *a=
ttr,=0A=
> +                                           char *buf, loff_t off,=0A=
> +                                           size_t count)=0A=
> +{=0A=
> +     struct device *dev =3D kobj_to_dev(kobj);=0A=
>       struct drm_device *ddev =3D dev_get_drvdata(dev);=0A=
>       struct amdgpu_device *adev =3D drm_to_adev(ddev);=0A=
> -     void *gpu_metrics;=0A=
> -     ssize_t size =3D 0;=0A=
> -     int ret;=0A=
> +     unsigned long key =3D (unsigned long)f;=0A=
> +     struct gpu_metrics_snap_entry *entry;=0A=
> +     ssize_t ret;=0A=
>=0A=
> -     ret =3D amdgpu_pm_get_access_if_active(adev);=0A=
> -     if (ret)=0A=
> -             return ret;=0A=
> +     mutex_lock(&adev->pm.gpu_metrics_lock);=0A=
>=0A=
> -     size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);=0A=
> -     if (size <=3D 0)=0A=
> -             goto out;=0A=
> +     if (off =3D=3D 0) {=0A=
> +             void *metrics;=0A=
> +             void *old;=0A=
> +             int len;=0A=
>=0A=
> -     if (size >=3D PAGE_SIZE)=0A=
> -             size =3D PAGE_SIZE - 1;=0A=
> +             /* Evict stale entries from readers that never hit EOF */=
=0A=
> +             gpu_metrics_evict_stale_locked(&adev->pm.gpu_metrics_reader=
s,=0A=
> +                                            key);=0A=
>=0A=
> -     memcpy(buf, gpu_metrics, size);=0A=
> +             ret =3D amdgpu_pm_get_access(adev);=0A=
> +             if (ret)=0A=
> +                     goto out_unlock;=0A=
>=0A=
> -out:=0A=
> -     amdgpu_pm_put_access(adev);=0A=
> +             len =3D amdgpu_dpm_get_gpu_metrics(adev, &metrics);=0A=
> +             amdgpu_pm_put_access(adev);=0A=
>=0A=
> -     return size;=0A=
> +             if (len <=3D 0) {=0A=
> +                     ret =3D len;=0A=
> +                     goto out_unlock;=0A=
> +             }=0A=
> +=0A=
> +             if (WARN_ON_ONCE(len > AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ))=
 {=0A=
> +                     ret =3D -EOVERFLOW;=0A=
> +                     goto out_unlock;=0A=
> +             }=0A=
> +=0A=
> +             entry =3D xa_load(&adev->pm.gpu_metrics_readers, key);=0A=
> +             if (!entry) {=0A=
> +                     entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);=0A=
> +                     if (!entry) {=0A=
> +                             ret =3D -ENOMEM;=0A=
> +                             goto out_unlock;=0A=
> +                     }=0A=
> +                     old =3D xa_store(&adev->pm.gpu_metrics_readers, key=
,=0A=
> +                                    entry, GFP_KERNEL);=0A=
> +                     if (xa_is_err(old)) {=0A=
> +                             kfree(entry);=0A=
> +                             ret =3D xa_err(old);=0A=
> +                             goto out_unlock;=0A=
> +                     }=0A=
> +             }=0A=
> +=0A=
> +             /* (Re-)allocate snapshot buffer sized to actual payload */=
=0A=
> +             kfree(entry->data);=0A=
> +             entry->data =3D kmemdup(metrics, len, GFP_KERNEL);=0A=
> +             if (!entry->data) {=0A=
> +                     xa_erase(&adev->pm.gpu_metrics_readers, key);=0A=
> +                     kfree(entry);=0A=
> +                     ret =3D -ENOMEM;=0A=
> +                     goto out_unlock;=0A=
> +             }=0A=
> +             entry->size =3D len;=0A=
> +             entry->timestamp =3D ktime_get();=0A=
> +     } else {=0A=
> +             entry =3D xa_load(&adev->pm.gpu_metrics_readers, key);=0A=
> +             if (!entry) {=0A=
> +                     ret =3D -EIO;=0A=
> +                     goto out_unlock;=0A=
> +             }=0A=
> +     }=0A=
> +=0A=
> +     if (off >=3D entry->size) {=0A=
> +             xa_erase(&adev->pm.gpu_metrics_readers, key);=0A=
> +             kfree(entry->data);=0A=
> +             kfree(entry);=0A=
> +             ret =3D 0;=0A=
> +             goto out_unlock;=0A=
> +     }=0A=
> +=0A=
> +     count =3D min_t(size_t, count, entry->size - off);=0A=
> +     memcpy(buf, (u8 *)entry->data + off, count);=0A=
> +     ret =3D count;=0A=
> +=0A=
> +out_unlock:=0A=
> +     mutex_unlock(&adev->pm.gpu_metrics_lock);=0A=
> +     return ret;=0A=
>  }=0A=
>=0A=
> +static const BIN_ATTR(gpu_metrics, 0444, amdgpu_sysfs_gpu_metrics_read, =
NULL,=0A=
> +                   AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ);=0A=
> +=0A=
>  static int amdgpu_show_powershift_percent(struct device *dev,=0A=
>                                       char *buf, enum amd_pp_sensors sens=
or)=0A=
>  {=0A=
> @@ -2579,7 +2717,6 @@ static struct amdgpu_device_attr amdgpu_device_attr=
s[] =3D {=0A=
>       AMDGPU_DEVICE_ATTR_RO(unique_id,                                ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),=0A=
>       AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,               ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),=0A=
>       AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,                          ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),=0A=
> -     AMDGPU_DEVICE_ATTR_RO(gpu_metrics,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),=0A=
>       AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,                     ATT=
R_FLAG_BASIC,=0A=
>                             .attr_update =3D ss_power_attr_update),=0A=
>       AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,                    ATT=
R_FLAG_BASIC,=0A=
> @@ -2657,9 +2794,6 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_=0A=
>                    gc_ver !=3D IP_VERSION(9, 4, 3)) ||=0A=
>                   gc_ver < IP_VERSION(9, 0, 0))=0A=
>                       *states =3D ATTR_STATE_UNSUPPORTED;=0A=
> -     } else if (DEVICE_ATTR_IS(gpu_metrics)) {=0A=
> -             if (gc_ver < IP_VERSION(9, 1, 0))=0A=
> -                     *states =3D ATTR_STATE_UNSUPPORTED;=0A=
>       } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {=0A=
>               if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -E=
OPNOTSUPP)=0A=
>                       *states =3D ATTR_STATE_UNSUPPORTED;=0A=
> @@ -4755,6 +4889,19 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ade=
v)=0A=
>       if (ret)=0A=
>               goto err_out0;=0A=
>=0A=
> +     if (amdgpu_pm_gpu_metrics_bin_visible(adev, mask)) {=0A=
> +             mutex_init(&adev->pm.gpu_metrics_lock);=0A=
> +             xa_init(&adev->pm.gpu_metrics_readers);=0A=
> +             ret =3D sysfs_create_bin_file(&adev->dev->kobj,=0A=
> +                                         &bin_attr_gpu_metrics);=0A=
> +             if (ret) {=0A=
> +                     xa_destroy(&adev->pm.gpu_metrics_readers);=0A=
> +                     mutex_destroy(&adev->pm.gpu_metrics_lock);=0A=
> +                     goto err_out1;=0A=
> +             }=0A=
> +             adev->pm.gpu_metrics_bin_registered =3D true;=0A=
> +     }=0A=
> +=0A=
>       if (amdgpu_dpm_is_overdrive_supported(adev)) {=0A=
>               ret =3D amdgpu_od_set_init(adev);=0A=
>               if (ret)=0A=
> @@ -4806,6 +4953,12 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ade=
v)=0A=
>       return 0;=0A=
>=0A=
>  err_out1:=0A=
> +     if (adev->pm.gpu_metrics_bin_registered) {=0A=
> +             sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metri=
cs);=0A=
> +             gpu_metrics_free_all(&adev->pm.gpu_metrics_readers);=0A=
> +             mutex_destroy(&adev->pm.gpu_metrics_lock);=0A=
> +             adev->pm.gpu_metrics_bin_registered =3D false;=0A=
> +     }=0A=
>       amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);=0A=
>  err_out0:=0A=
>       if (adev->pm.int_hwmon_dev)=0A=
> @@ -4821,6 +4974,13 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ad=
ev)=0A=
>       if (adev->pm.int_hwmon_dev)=0A=
>               hwmon_device_unregister(adev->pm.int_hwmon_dev);=0A=
>=0A=
> +     if (adev->pm.gpu_metrics_bin_registered) {=0A=
> +             sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metri=
cs);=0A=
> +             gpu_metrics_free_all(&adev->pm.gpu_metrics_readers);=0A=
> +             mutex_destroy(&adev->pm.gpu_metrics_lock);=0A=
> +             adev->pm.gpu_metrics_bin_registered =3D false;=0A=
> +     }=0A=
> +=0A=
>       amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);=0A=
>  }=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h=0A=
> index aa3f427819a0..3677a4f543fb 100644=0A=
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h=0A=
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h=0A=
> @@ -349,6 +349,10 @@ struct amdgpu_pm {=0A=
>       /* dpm */=0A=
>       bool                    dpm_enabled;=0A=
>       bool                    sysfs_initialized;=0A=
> +     bool                    gpu_metrics_bin_registered;=0A=
> +     struct mutex            gpu_metrics_lock;=0A=
> +     /* per-reader snapshot entries, keyed by (unsigned long)struct file=
 * */=0A=
> +     struct xarray           gpu_metrics_readers;=0A=
=0A=
Pretty clear NAK on that approach. What the heck are you doing here?=0A=
=0A=
Regards,=0A=
Christian.=0A=
=0A=
>       struct amdgpu_dpm       dpm;=0A=
>       const struct firmware   *fw;    /* SMC firmware */=0A=
>       uint32_t                fw_version;=0A=
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd=
/pm/inc/amdgpu_pm.h=0A=
> index c12ced32f780..dc6875871f1d 100644=0A=
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h=0A=
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h=0A=
> @@ -73,7 +73,6 @@ enum amdgpu_device_attr_id {=0A=
>       device_attr_id__unique_id,=0A=
>       device_attr_id__thermal_throttling_logging,=0A=
>       device_attr_id__apu_thermal_cap,=0A=
> -     device_attr_id__gpu_metrics,=0A=
>       device_attr_id__smartshift_apu_power,=0A=
>       device_attr_id__smartshift_dgpu_power,=0A=
>       device_attr_id__smartshift_bias,=0A=
=0A=
