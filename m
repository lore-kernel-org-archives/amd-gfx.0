Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F04C43381
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 13:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC9E64F0F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 13:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC9E64F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5766E160;
	Thu, 25 Feb 2021 13:42:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3AC6E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 13:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKkW8Hx4GIiLDDQuWoy2Q5Jn6128ZHVrvdVJrGcBjMIabRjKqPDNJBOvfE8NO7nELAUZ33oBZAwt8l5u+G1yvNl8a38LfKUfFPzZBtxS70fFxBCAvKKFCM4Z4/ZZjR0to3xsdzywJvPcy4pmfV34Dv58KtvhzZXu+zn1j+RKLEkvLuC5yBiKSXoJGgeOyFt/tvGkb5WpRNIlNkT35xhy37hghPj81Kz/cO1nZAIXoeox9IIJJMr8U2w6l7W+3QtAxNvtrWQcJYWJOFzuERg6YGfXV9Z2jyiDfs7LUzJz34rY9RAC+Jq5Ldxe7PV8AxVju+m/SmKP3+HePao4XcmY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aaWUSa6n/806nCR95g+GOpMHOsN70jSwO0HWi2lsPc=;
 b=C0Wy4+YGeFskAmhjQm86Cna1wV4VFQlQ/+oWDNTHXK1qHg5fh6CbaRSHomqS+ql+ytTD10Dmr9DqtJ3h4vdqRbmL2/+2QNB0wArFRlgUbcVNz4m5rI4tOui3zFRJcX+sqIFwGwG9PNE5Mq9QB0FUaJpmqbh418kFULZJyJjPrDunwRPpijqI3pSN8kyPTs2x4cihSuUx7hKsD+sMJNtjZxlLtVlLCDhquKw/M80dfztsKvhLygngcNt/PxjQvAAJKFoc3MASiFoRdu3qOLqn0ma5qHSk/jEQVqUs3dE0R4ybkkzfQXF+RHBj9W4nE3Zz6q2GJnJHBTS8e1eFZMJtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aaWUSa6n/806nCR95g+GOpMHOsN70jSwO0HWi2lsPc=;
 b=cMi+sQwySMYAzHhxohYM870oziZcT935gSo5txHNid5aEETIChzY9VTmso53Sjq0Wwt0wM6bZQODc39GMSj4cbxm8LqiPH84cyATwMbfXwuOXvyHNN0e8SjWSveRiqxmR5ncrfI+eDxmvHTyUVMmxHG7l7PTXbdjiCuEPI2184g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 25 Feb
 2021 13:42:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 13:42:04 +0000
Subject: Re: [PATCH 088/159] drm/ttm: ioremap buffer properly according to TTM
 placement flag
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
 <20210224221859.3068810-81-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5f10504c-45c3-d214-29f3-6f3b108114e8@amd.com>
Date: Thu, 25 Feb 2021 14:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210224221859.3068810-81-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fc8:43:f4c0:95af]
X-ClientProxiedBy: AM8P192CA0011.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fc8:43:f4c0:95af]
 (2a02:908:1252:fb60:fc8:43:f4c0:95af) by
 AM8P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 13:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 743a1625-b973-4dd9-9828-08d8d9932307
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39519E464A31566DC1EC0670839E9@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ng7l2eV7RZ+w/H+9pF6qFUSw+y6EB66mIHhqAPpA59pg4/uhogf5lCHnOwt1X9IQJpRYUYaLlO9zsaDDGpQNtIKtCF+xRg9DYlKKJQGgiqdbB795fXg/jaoGpqikkslEgCffKZV5mOykIPRXrIWZ90AUMZFCg434MbHpJ8wMv8h9QZOWYBUuP4cKNhdKCuI4n3rPuNRQuLdMkIYTUgTJL1zIcGaE/xynnFWXA3h2WmNEzeTFXTsawEfRUy9/u6/8Pb3TmHoXBH+rEDYXFBFEKccCeRpKGz6ccG8bxyZO7xI04DYh+63IgMxUW65wP5OOFn5H2DSvB9Bgs1Uk7UMf/R/YN5uDgbmKIImoiThmecc5tfqPiiUJjMRMggnCl8iOepipqaKaJ6I16eiFV119buPjAAN+PxscScaMsfwXnTfRNlQAZXAiPhybKsPFzb5DabYiEH2gwCp9/IcjH91yh2s5psj9FhQkYJrShI7H156VzysfNQ0+eh+Tds65hUDqwGM/VhV/pPSNricaVcih3k//51l7yfe+NBKA/ZsBjxitd5/1d4B4AmJ4lXAi5TmX2H1uT3eQyLVSPZcxDYJdumP1W/oekC7j6vaIaot7+qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(52116002)(54906003)(4326008)(478600001)(66946007)(31696002)(6486002)(186003)(66476007)(36756003)(316002)(6666004)(2616005)(2906002)(86362001)(16526019)(66556008)(8676002)(31686004)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0hxQmFWd1JPb285eEZsMDlqOEU3aFVYZkhlbUtia3pqd0RKdDVla1lsN3Rv?=
 =?utf-8?B?c0NabXVrZk1IaExId3N1MmNjZGhqRktDb2Q5emYxUlhYNEkwRVZjYlB0K0R4?=
 =?utf-8?B?Vk9iUDlIT3hEVHBrQkVKblcrRkNzN21KSlp0TDJyR3J4T3JGcHdPWG1lVHhK?=
 =?utf-8?B?NTBPc2FSNE41MkQ0aWNWYk9VTGw2emg0cWxYNU5GOVovZDBVbUpkQzdpUHVP?=
 =?utf-8?B?MG1VN0VuTUI5K2Fwa1VqbUJGSkViZnVwSzNWQjloUC95UU1KOTVQa1dmeUYz?=
 =?utf-8?B?OThaV0xFdGQyeEdRWWtKdTJmTUtWSmJ4dzFkMGVGMllRWHZsR1MwSHMyTnNw?=
 =?utf-8?B?blZKb0tYTUszbmFIaFpwWEZHMEpCUzUwRzhOU2ZlUUp1VkJQZ00vNmN2Vkti?=
 =?utf-8?B?NzNxNkd1d3BwUTBHZVNKVEFiTFl3UnZQSDFNRE1TZGNuZTlxM1ExOXIxSWxs?=
 =?utf-8?B?MXJJYVRPSGN3VSs2M0ZVOHdtM2hTbDZjK2ZVR0hqL0didC9Ta3Y1dElSOUlP?=
 =?utf-8?B?bTk2UmZZSFZxNGw2ZjQzcVFRTHdyWDRnQy92ZTZuSktJcHRJRE0vbENCK0dt?=
 =?utf-8?B?WS9zNHJQZlYwTFZMcGZhZHlkREhCZmlVZ0xQZU14cTlmaE14RmlTVGNkb1pD?=
 =?utf-8?B?d3Y3SkZTTVRmbkZOZnRaNG9nUUlETUQwRTlOSzMvV2VpZElsNlpkZ2pTbU9z?=
 =?utf-8?B?VGVBdUQ3Mk92Qm8ybjZ3Q0FaY1JJRlBLLzNQVXZnK3creURFcVN3OFBQUnVy?=
 =?utf-8?B?VmlmalBIaS9lQk9pVVBxRytUdHlvK05hQW1OZHZGWm9YYXh3U01TbFBSbkJO?=
 =?utf-8?B?cmZRenkwM0ZzR08zdUtJUWhBU25wWWZWZy9VZ2Y0U1l0THd1bEV1MnNwSEMy?=
 =?utf-8?B?SFZvMEZHU29wWnZxck90WEQrRU1BOVVtZkJhYlNqdythMlM4V3ZiRFQrTmc0?=
 =?utf-8?B?NHBvN1VvTmI0SFp4aE5PM0c3R2h0dWltQ05tNkwxRy90dWFsTWdrMGQwSEFh?=
 =?utf-8?B?dm1XaEs5NXFkbC9JTzNHakx4T0ptZkJodEVRUlBGbzZ2d0R5dGNOSitZdHIw?=
 =?utf-8?B?Z1FWM3MxUTdvMlpBWnRGOHRCYjhvcEJvRkdHNkpIOVRvYjh0dnNMYWRoOWtq?=
 =?utf-8?B?R2ljNWd4eVZLQXhqTVIwWG5EdU02Z2kwTjlna1MwNFpuZzh5MjFqYTZKcDgy?=
 =?utf-8?B?NFVjazZ5RXlyWmwrWG5xWWhhMDltcnk0NzVndlBxVEVDaXljcWV1VDBUZHRN?=
 =?utf-8?B?Y3JRNURzNzUrNmdyY1Q0RFpsZ1dxUUFTYUhpOVZXcEdLMzVBSG1icVQxUmdB?=
 =?utf-8?B?NWhoZjRheWVJbTNXWDhmamZVaXRpRUdCc1ZQTmluZDE4cDFwbHhpemZVOWJa?=
 =?utf-8?B?UHNoay9kY1JnM2RzNTVTSXpjVld3OWhVSnhrMzBiNjd0OHM2N3hiVHU5RXZ4?=
 =?utf-8?B?QXFWckRaSm9iWXlLSG51OW03ZGtGYVFtaDBMY0Vya3NTejd2WldTM3Z0Rk9B?=
 =?utf-8?B?OE1GR3ZLYUk2NFphNnY1SmtHMWdMZnRrVFVSNG9wbExLNXdzMG5CWVlEbXhM?=
 =?utf-8?B?NlBLTzc4MVNVRG1ueCs3RUZHU3M0Umd4bUZxbFdLV2hLYkJzdU5oWTNsSktW?=
 =?utf-8?B?Vm9KWWJnQis1a2ZVN3h3SllhZFJFRGZQZW9MRnByNmczOXg4cUV1T24yQWVi?=
 =?utf-8?B?ZlZrSnhocnBjQk5RRFdhNzlvdzlhbHhaN2E2Uk1uN3lyaXM3Q3cxOStvOGJB?=
 =?utf-8?B?ZkxOM0taVzd0NzdFNVJRbnZDWm5MSkxlRTBEY2xvN3RVWWFURmdWRUxlQUt3?=
 =?utf-8?B?Z2plRFQ0QW9VRHAweG9vQitLbHNnbzJzYm12ZjBVTkUwYnhicUt3eVd5NWht?=
 =?utf-8?Q?aF03al2sgZvov?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743a1625-b973-4dd9-9828-08d8d9932307
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 13:42:04.8192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rId5goKdoBhxlUbhOKpOCyQfExGPWTKW0AIfog//yMry5wMbomsU2n/6WXzIi0J2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: Amber Lin <Amber.Lin@amd.com>, Oak Zeng <Oak.Zeng@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The whole patch set needs a rebase since the TTM_PL_FLAG_* for 
controlling the caching doesn't exists any more upstream.

How should we approach that?

Thanks,
Christian.

Am 24.02.21 um 23:17 schrieb Alex Deucher:
> From: Oak Zeng <Oak.Zeng@amd.com>
>
> If TTM placement flag is cached, buffer is intended to be mapped
> as cached from CPU. Map it with ioremap_cache.
>
> This wasn't necessary before as device memory was never mapped
> as cached from CPU side. It becomes necessary for aldebaran as
> device memory is mapped cached from CPU.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
> Tested-by: Amber Lin <Amber.Lin@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index ee04716b2603..e11ec1ff5d0b 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -519,6 +519,10 @@ static int ttm_bo_ioremap(struct ttm_buffer_object *bo,
>   			map->virtual = ioremap_wc(bo->mem.bus.base +
>   						  bo->mem.bus.offset + offset,
>   						  size);
> +		else if (mem->placement & TTM_PL_FLAG_CACHED)
> +			map->virtual = ioremap_cache(bo->mem.bus.base +
> +						  bo->mem.bus.offset + offset,
> +						  size);
>   		else
>   			map->virtual = ioremap(bo->mem.bus.base +
>   					       bo->mem.bus.offset + offset,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
