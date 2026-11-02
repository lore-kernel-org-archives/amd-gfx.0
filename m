Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC9606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SB4UqlI0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD5210E619;
	Mon,  2 Nov 2026 13:40:12 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1BF10E619
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8668K0GEWtn/fnX66tCZbvYRiw4VkLNGRb/gAJzEErw02/Vt6gL5cJcmeKH5QCtH3h6bKmBijmTn4KXNNLO28ErtpYkblvixgRks5oHcT/RDM1iim7hVRaqbCjg8hRlcs3e/0DrgHdyPUpkgSwKOex695pwAWF8Y4Elld/yVtjFFAdbe2cuKhDQ/AIMaocYKP73bwaWDkuqGDqSe2jWshfN0KBmCh8AviymTQiAhIEmCsBpLJaBlLSCxKlyc/xhOEgbSGy4yK4WX0nVGFR3yD6ujoCYGrRZsa7skZkJubDEUB8ZTSyW0Aclm4+tW9+shXf4rBF+v9SoEBQJuIDtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5mXwHZw5l7I7yuhCvGBrQhZ4UkLEBRv25r0U+FTzFM=;
 b=M1Edg7hCJa3a78JbAZ43pM5R9T0yE8sGhm1NpuWafMyfzAD50oQ80EOtBFwMm3avt+l9+jLZy1id9Welog18CKBabg6DAn+PqQO1TcTaQujj76atQP25zeaziNmHBgRFbtguGHYM+dlKRdFcnOjExQjiZch3CyZwEwdzA4tXCMg9I5JCZhSHDAkxBbRCUuNQu76a/kvyINr3RVlvDGOe5ZCVV3GFl7B7ku0S4R8bfxUsG3jM5Lbzygi2VaxiQTZWZc2sK3XaauWKIgkDnqOU+9+E8UXKJ87feaVn+sx/jjYyfW1IvTRHZMqbEYZ/WtyK75NqmeRpQKPF5OCsa1f6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5mXwHZw5l7I7yuhCvGBrQhZ4UkLEBRv25r0U+FTzFM=;
 b=SB4UqlI0pD+TAcvR1lVp8Z7X6dnY8xNzHqlXxBrdyh5c/Nv+mCMZ6bPazPwOfyjVi5ZDafRCR6FEKJzRh8Z1cvP/llIplKMMjxUq0FLJIxMIj3XdiwYqb3tfh6oB6gEE2dVY1z3MHP4t2pEn4Ku9AFBKY/ofUSdXxaMcTOvuEew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:40:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:40:01 +0000
Message-ID: <361f5ae9-8beb-4263-9042-b9f3c65e6fff@amd.com>
Date: Mon, 2 Nov 2026 14:39:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the size in GEM_USERPTR ioctl
To: Perry Yuan <perry.yuan@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>
Cc: Yifan1.Zhang@amd.com
References: <20261102082915.2289352-1-perry.yuan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261102082915.2289352-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 388016d2-7a56-405a-8da2-08df38e6caf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|261009220027099003|261009221227099003|261009223327099003|261009221727099003|261022105027099003|261021121427099003|261009223027099003|11063799006|5023799004|10067099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: JtM4ev7Hhnx1cw2o0wCCoRDZdf7zWv3DQq0y8w4Eehn1X+ldtT1vSvfAUKxOShZzsiZ3trzJRPJkUo55N5zB7L0Y/kGiiTQxiF4bDcqQC9DHZ2gmotrlILNsxseSxyaWlF4Dnqs2bNH0cu3heSk+e/g/Ob5W/OE5SJ2bjZjmoUJJZFShgwmmGUr+HMEwfIYcMnTd5xOyJe2v2TvLFqYMt6qr4HeVGDSqhWKzY0oNHa3MPXstlgaDrhASCH740ZXodRXMcvO2GjDKjmqWPWZJbzd2CS7Q6K75M5HU4/LarimvJcjAyI8esMxUxeE/JdntkIDSV0npInQoqV0SjCS3d3s7FXh7Fa6/g8xfnvFC/F7spLREXHMEqzfNDPjXYJ4zZ5xtnSqAbjK6D8qoGuapKt/jSbSRins0cu3C5vgrYq7b4yQDl+1aTwPfBGvZQyoZC4fgZRSzaDbHyacvmofUawUz2kBhY0VQ4OgLD8ptGpwAKCBahABrpVW7hsi7eHVRJBdWClRaZo+ZDhQav/pUKZIYMhyWSHRpjM9NjpG+8kTqQvHByqEdYTbyissLPFdfM0OoHN4SK0rGVNUr3gkJWAIiWmOzP8lDjktqsKH/Zo8Wc8Q2L/bkg1dN0S2HeXd0ZGXzRm5R9wl8MXPwHw2elZEkdicMxwDGs2keQa8vGVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(261009220027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261022105027099003)(261021121427099003)(261009223027099003)(11063799006)(5023799004)(10067099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1l3RXFwSmpsRy9iNTNQVjltb3Btc2w5ajl4M3kvVlVKZVM4TEJqNGEvdklh?=
 =?utf-8?B?dXdIQmkyRmpIN1BwcXJtVEVWSmc1Yk10V090UldWdHdBV3ZodkljcUh1djVI?=
 =?utf-8?B?YzJUM1U4UVFpc2owbkIrSTg1MlVTM3pOU0tOdWJ6Y0w0Q3JIZEd1QXA1N1BY?=
 =?utf-8?B?MXo5dVpoU2tvQ0hwcjhZZzRLRnJtTGtvU3VESDZaSDhjZVNxVWpIdTVuMjMy?=
 =?utf-8?B?QkZQYjUvVXhvUzlSZzFDNzFqcnZLbFFLWldZMkVncDRDemhzcHRZb0EyaXBC?=
 =?utf-8?B?SWhkc0hPT2o3VjVkRUxYUWNtb3Q3aUdTUkNZVktiTGlzbUQzbEM0SU5iUGtN?=
 =?utf-8?B?RkZLTG1DZHdpQytNM2F6YWtTSlN4OE9BZXhNUWRpdXJIVTNuc2IzSEN4bEFG?=
 =?utf-8?B?Z2plMWROZVVETSs1aCtGdkx2L0JjNk9tb1E1Z29UcktuQThpaml3QWljNnIv?=
 =?utf-8?B?dTFIa3RTTStiRTkwZXowRi9WSHRZalBGR0krYTE3MmlRRXVrMG5QK2VsSEx5?=
 =?utf-8?B?N3ByM3dsUHM5YkpMbHhHSzR6N1RFd0FVa3Z2NDdsWmRFMnRLVU1vUjBPSXl1?=
 =?utf-8?B?Z3hlb0t0ZHI4Y09tWUhTNnZab1pzb2tSQit4NkJJamZRMWlRQTJ2UUxaRTdB?=
 =?utf-8?B?QTYrdmJZRTRzaGovVmhBbEdQVUkwU2lGaUdxajJaYmI3RTVEOCthRUd1MVhv?=
 =?utf-8?B?djNFWHR0NTZQNzdpUDZVZWVSaERTTGlkMFB4cVJwNjMyNFFhWkJTZlVHdFh0?=
 =?utf-8?B?TDM5RHc0V2dlYmE4OWlsVWUxYjJWcnIwRjczZmxoSGpVTGpSOFlqN0VpWVZM?=
 =?utf-8?B?Y0RNYjZFQkExaThnT2lzdnpKUmhHUlFrWWgxR2VGWWtraDZzek9YbmNRL2kr?=
 =?utf-8?B?VVEwdmgwSUVBWnpIanp0cTV0cXJkQUNHZ1hYQXg5TDVuN0dpd2RwRGE0UStL?=
 =?utf-8?B?OTlqOC9ENkZPL3F3SENoTFBUcE9VSFhDYzh0QU9WT01ndlNrNzMzQytkMGVm?=
 =?utf-8?B?NEVyTk9YdEVRcXRGRStHOTQzZHp5c0syYmZpdkhDRTUwV0l5OVdsdVNieXFV?=
 =?utf-8?B?QkVxS0lEWE5jRUh6UGE2NTZlZlczbGVvTE5pNHBxK3hzYXBlZ1FPVDNwd2Rw?=
 =?utf-8?B?V2tmL3YxRXhkaFFYUkFlOVp1Z1MvNUJUWElsRmthQ0kyaW9TMWYvenYySzlY?=
 =?utf-8?B?ajZVRTRNazgxS05pQ3V1eGRWeXZmcWhZZVNXbXM2Y3V1QU1QQmxaVkp5MDJy?=
 =?utf-8?B?bVN3VGVMd2ZsNkg5dzdZZnAyOXpVcm5wK0k3cXBlVnpVY2pOTEQyQUdieEtN?=
 =?utf-8?B?TU1OR25rQkZsMG5xdjNIeGZTK2FvdUo4eUlHaVREYWx6RThxU1lTbWJQTWxM?=
 =?utf-8?B?TEpnMEF4cVRnY2NSdU1WcEZoc241bmZmN2dkdDRjNHBHYXI0c25ETGs5L1lK?=
 =?utf-8?B?cjZwc2ZrTHpEUFc4MFBUdE8wZmxOR3Y5UkFsOGtZbS9aRWRHcENWdlp3emtC?=
 =?utf-8?B?UElCaU0rNXlyMHYrRHhKdFhsRUkxcTlicU1BdWdDenNvVGZnZkNRV3pJNlhy?=
 =?utf-8?B?SjFOZmN3d01iNHlxODE0Z21xYkRhcVJUQkdWL3N4ZElmdzJmKzZlTVNNd1pM?=
 =?utf-8?B?aE1pbHJKRDJWcEZab3NoSG9rUWVhNmVQWHdVK2xWblFWbXFHLzB5cGZMT014?=
 =?utf-8?B?TnRmeEMvcE1RSWM4TXJTQlluaGlRY3RLZUZ1cEJTZlFTbFdJMWUzc3haUkxF?=
 =?utf-8?B?Z2h2VjFuKzY3cFdSaWpaQmNPKzZnR2FaREFpeTRUVGJqbFN3NHBpZk1VSmpS?=
 =?utf-8?B?K0dDVWhwMENNQjhyRTlvU0tVeHhQZzgwdUNzQ3c2QTFqZzQvV2ZUbkdZYTJG?=
 =?utf-8?B?R3RLdVpyci8yU1pBd09xSkQ3WlFzTitrZS9Ia0dmbHlaSXUvTnQwSFdkd0cy?=
 =?utf-8?B?WFVyVUc0Q1ZyMU9GQXBFMGlpaVNXQ1RXZUVDMUc3czQvc0tpbE1SbHdlbktL?=
 =?utf-8?B?R3FEeTc1V25mbE1raDlRKzVpSzdrRFhiR0dQeU91Q1NGV0tYNFBYNTI0ZmpW?=
 =?utf-8?B?UUJJWnl0ZGlXbGZYeWpuYkNwMVRWUjBQTjBBM1NvRVl0eituYVluTDdtQmxO?=
 =?utf-8?B?aUZic0YxeHdLTlFMemR1SWJuazViZXA1ZjZYVjZaNjJGSmN4QkVibGk3emJ6?=
 =?utf-8?B?ZzZuUjBmSTBKdllKekh4bmxmcHY3UnVRQVhuZWtpanYxL1cyemJMZ0syZ3ZQ?=
 =?utf-8?B?UHc3WE9uZ2N3TnpUT2ZuN0p3SEJHN3BhSTV0K21VcUtTK2kxVmp5aDhvQUlT?=
 =?utf-8?Q?eixj2R5kFlsTWMIPGi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388016d2-7a56-405a-8da2-08df38e6caf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:40:01.0051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QtjV7cKrTphM1fngWkDyDUPQnLv9LIdzSBZSgCgRM8SOtbwIl+LLsVcsVD4DJO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 09:29, Perry Yuan wrote:
> Nothing limits args->size in amdgpu_gem_userptr_ioctl(), only the
> alignment and access_ok() are checked. Acquiring the DMA addresses for a
> huge range and cleaning everything up again whenever it changes is
> expensive enough that a sufficiently large userptr can keep the machine
> busy more or less indefinitely.
> 
> On top of that the interface is increasingly used as a replacement for
> real driver or udmabuf backed allocations, which it was never meant for.
> 
> Reject a zero size and anything above 1GiB. That is far more than a
> temporary upload buffer needs and stops the ioctl from being abused as a
> general purpose memory allocator.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for now.

We might need to adjust the limit based on customer feedback and/or disable it with some debug/workaround flag.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index c982d102614e..348693023563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -566,6 +566,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  	if (!access_ok((void __user *)(uintptr_t)args->addr, args->size))
>  		return -EFAULT;
>  
> +	/* Userptrs are for temporary uploads, not a general memory allocator */
> +	if (args->size == 0 || args->size > SZ_1G)
> +		return -EINVAL;
> +
>  	/* reject unknown flag values */
>  	if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
>  	    AMDGPU_GEM_USERPTR_ANONONLY | AMDGPU_GEM_USERPTR_VALIDATE |

