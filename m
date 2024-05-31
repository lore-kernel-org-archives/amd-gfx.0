Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641F8C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C2310E703;
	Fri, 31 May 2024 06:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="On34ZYGf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578D610E703
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT21tC1lZta+ta/iZ+RSeIhNmqKhTXDM3L/6l8D+wZSx+vpKwTJ5dkpG9mHiqBTBxtqI6xnkms5V2BKGsGw9EtVAKKSwR8JBGhWeBvwpU8oyWD6t/QhablCQUMl9B84QJYp4o3anzi9glyfOj32+FUzhcVDorywM+IQauvOHgOzg78GPHhURHoPpbuRNXk+lp55FxgB7Nq2DyQ66yUcF/2TN7uzvF7/Q0XDoec0a5bZWIMKfvmctInxYwYtQThmJi5gkigLlPniqrMwS63gAZdV6J+UDjDmaLurx6NJProfRsV03Xbt/3pYg9+8xb/tU88Z7qnopdi0NjWtDjW+t7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycXnNQMbHumN2kF4qdwN/I8ZGeI3M4F1azrS/ZA9UIs=;
 b=SK6uNNilQ8lyAjPkNl6lZQOiSKb8R79/RDsrXVNZUBZzT6+a7H8pBpXAbkXctzQtSx1N3ujB/oa3H5HDaELT4gBxmvlM3HtyLfqFgwVAIxSMFqJTHb16z/9zmnvBo6jRsJz4q8AJ8Sdh1a3RedvpW1DEI/uWCadAUknbNO3XQyayslVjYYaVNoujyIFJoYvelFXUFU04SIMKHxXn01Kdezbgu7+wvqXhVNgWa6wolo1gpLG/VoJSCQTSxjTUc0nKDItvzqa4DZMixPgv1YuyUE3Xn/QyBJDwp2ASmcKwgFG7D/SZrBF2nHNikuXb1nbBxA7BJgS7wcLjzfljjIajLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycXnNQMbHumN2kF4qdwN/I8ZGeI3M4F1azrS/ZA9UIs=;
 b=On34ZYGfhrcIxSz4yzP9fOzaQFrXw1OJbQxc72G93eGnvDjXc6Hj/uE+Sr6PqJ+EE08aq4hHrtRPgqr+mwHSvaHRowYaSYB9WN3S1udWYzSbh7EqhG7vbqA1yDuz//0k4VlMh2b3FmdJ9KleoCJo6tWip2NIEnkWvul4ynlx3do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.36; Fri, 31 May
 2024 06:52:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 06:52:07 +0000
Message-ID: <c848dcc1-0816-4c2b-bc87-8d5918046cd7@amd.com>
Date: Fri, 31 May 2024 08:52:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
To: Felix Kuehling <felix.kuehling@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-10-Yunxiang.Li@amd.com>
 <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 384aaf74-0bfe-4401-62e5-08dc813e2fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW9BR21WK2pGZU5QcnVJT2kzbFN2c052cHlSYk4wOXNFbXhPdG0rRzVnQ2dq?=
 =?utf-8?B?RkNhellneHdDakNmMDBjVDdJa3ZGcGE2czdxbFdzclhGNzVlVktDTFdCWTlh?=
 =?utf-8?B?Z0wxTXk1U2U1QnZPMWJxYjZqVkxiVWhzOWxHd3dkQ2MwOVdhVCtjYlI2U1Y3?=
 =?utf-8?B?dVdickEvVEprQlRrOUMrb0tEcWhkNkVQd3k3MVpvOHZOWEpmMWJkRUxhcERi?=
 =?utf-8?B?dHBqaVlVNVVNTG5GT3orMHBuVDJReW1xZFFqNDd2dzdPSXQzMVZWUDVZZXpk?=
 =?utf-8?B?YUlOTXlpOGpzd3lXTDZBV0U4Mit5SFZmRThBZFBXYWNKQm04YmNKd2tJV3Ru?=
 =?utf-8?B?WHd2WTJSZ3dTbWJnTjRveVlnemxCYVlNc2lqQjBUR29TK1A5VTJEcUN6UTRT?=
 =?utf-8?B?aXdVaGQxM3o5NGNkeHk4U1ozWFpRREcwYjFYUTFKcW9JNjdEam81bUR0UjV2?=
 =?utf-8?B?Z1lnNHhqYVN6eW9HbHJ1aHJXWm9kL1JSV2tUYjh6RExoYjdvTDdhdDlKbVBU?=
 =?utf-8?B?MUZFT0FpZm9NcXhCS0JxUVN1SmNoS0FoYTJaeE1qSFNhaWRjOU1UTFZYRHkv?=
 =?utf-8?B?aFZoZDBxbWVvMG9nbmJoRm1XOXRtaWNRQk9tM0oyejlHbDhnSCtrb0hKM091?=
 =?utf-8?B?b0VCRkx1UmlyVzY0akNiaDhWYnVNS3k1R0V5RVVuYlRZMEovdEZweE03U3kx?=
 =?utf-8?B?cDBLNHovWi9ENnFhcklTVmRvN3FYVDUwT0RjbDJzdmExb0hRRi9iNjg2NEdK?=
 =?utf-8?B?MmV6ZXcwQ21TL1ZuZkEzWVZnc0gzKy9NdzAzL1dHbE9FNTduT21oS09UcjZP?=
 =?utf-8?B?cm5WeVY1R0pBdS90eWJPMWZXZHNPemtBeEl6K3h2bzZaWnZsanhPKzQ3V1p5?=
 =?utf-8?B?ZzBBWFU4QXlXbjZBeHNvRUxQUGw0Zm1rOFdzeWJqMUxKNEpaeGNYMy80THpU?=
 =?utf-8?B?YnlsVG1nRzV4ZkNNc0FORURxcThDZUdMVmRyYTZxZm53U3dKemVDbGJ0S2JS?=
 =?utf-8?B?NVFrNlhnWEVMMm1vZ0hscHZiSGhmSnNXVTJWbnZlajNYTXIzaXZYczZSeGgz?=
 =?utf-8?B?R0Y3azVwQ1FSbmFkM1AxL1I0Yi9BRmNSdThDVmpsODcvYitQOU5wNllGMjc4?=
 =?utf-8?B?VHhwWmNLdXJJNERMTldNK24wU2tKWVlIREZWK1NtNGVMOTNIRUFtdTMwUlhp?=
 =?utf-8?B?Y1ZtOS9Saml6Z2NtTW5xaENWWEtIdGQvMHN2dkhTcWNFL1I2Um16UHVneFNV?=
 =?utf-8?B?VU12UWY4YUNqaTV5TWo3Sy9KYnA2QmVoZG9rbWxPT0h0TVJyY240SURMM3lv?=
 =?utf-8?B?ODhGb1NGRUMrbVNwSnNmTU1yYU0xWXE2NG9jUXdXY25JWGl4Tm53N1dramM5?=
 =?utf-8?B?bVNqNGpOclZrampIQmlXNHg1cjZZZXFkMHVOR3dlMVBva0VrTmpyZWV1SFdE?=
 =?utf-8?B?Z2FhcTN2bGZzSEdnOHJKc2NpL09neWszL0QvZ3NxMTluUVhGUjB4SFFGMk5Q?=
 =?utf-8?B?S0pqYm1WVkJNdXhpNlVWV1krMWJQRk9rbklKMGp0YjZwbmJsL0lDK2IvaFFF?=
 =?utf-8?B?WXNBSFZjYkgyK2hqbDVUVzNFcDRyeVNmdXpXbUJiek5qU0Z6NlJveTNqTWJN?=
 =?utf-8?B?bGwxSUVqbnh1L3J0MkJNZE9kL09wSS9UZWtBVlV6YkZpZHMzTGt5Y00zMkQ2?=
 =?utf-8?B?aURLaEtBei84LzFVN2NKNzdtMlYzcmFaYStma0pJQ3RTbHVjcStHK3J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHcxb1pwcUE1a0NZWHRlN1R5ZTN0WHBIbmdBM2JnTGUrSTNCWkVHY0lRc1pZ?=
 =?utf-8?B?WE81dTN3M2NrbTBKY25tb2lRbjUxOG1yenU0U1BST1hhZXl3NE4yWnpCREht?=
 =?utf-8?B?Q0xSQXpNQ1NLR1RCSG12WkltK3YzVW1Hb0RZa1RYc3ZKUitIaTNQR24vaGN2?=
 =?utf-8?B?cUpLR1BML1NPTzhoTlRiSUI3RU1nc002VXBKMTJsUE90QmpaLzNia2EyY0ha?=
 =?utf-8?B?Q096dzl0WlR4Wk1tZHdsVG96VFljMXFlc0xsNk1iVnkrdk5vbUVaeVZKWWNO?=
 =?utf-8?B?V00zRk9yQ0xERzVOVVdTNXp1dmd3clpvWTdjSi8yNWZqbWNvNG16QTdDUWt1?=
 =?utf-8?B?cDQ2S3NCQWJ5SUNYUlBFWElGVVBkNlBwd0N4bkcwU3dCZm83R1FHWjBkNDZU?=
 =?utf-8?B?blZNd0tkUUc2azZPNnpBeXp6ZFNlNFc5VGxuOHdRZFk4OXg4QjMrZUlSVE5x?=
 =?utf-8?B?NVhBVEtnOWt4VnZtVGphVE9Ka0x1UlkvSzhlQUpxSThtcVhHQ1R0a3BOZG5N?=
 =?utf-8?B?NS9YeEI4L0dxeHRpU2VzYzUrMkttOUZDUkFzc1FrQjMwUzlhMU8vdExqYVJz?=
 =?utf-8?B?WHh3WmR0YkRIWHB1TitHOTVRa0lBVm50U0dhRHM1VEJFUENxUUlhQ1BOd1dG?=
 =?utf-8?B?UGIyQmxQTXQwNVdmZHEzMDVjU3lsR0hlNmF0QkcvUXJud0U2TkRBcytYTEtF?=
 =?utf-8?B?SkY3eGRzaER0ZzdLd3Q4UXBzQVdNd1ZiWHRIQnI0dVdKRTRLZE9sZ2dnSk83?=
 =?utf-8?B?N0J4cThuQmVWMWxqVk5uWlhMcTlacC9hL0VLUTRyTGFzWDMxOVdpT3k1Wm5w?=
 =?utf-8?B?SHovdzRieHgyWkpvUDNEY3VPOEpJZDJvcStVSjFEQnMzSGRjU3NCMUVRaVdZ?=
 =?utf-8?B?UjNvS1ZkeGNCNGZPc1JiZkdzQUhYakQzUk85VnRrTlFGNWpVTGJuQitEYTBO?=
 =?utf-8?B?T0xvOVNtMm1sa3AvU2JuSlBtSmhwbjkzR003THYwbWY2Q0ZCanBHa3M4TmhI?=
 =?utf-8?B?ZXJyamFrRjg3VXQxMzNoczZ1djFNZU9GZEZVQjRxYUJvR25jYThpMHlaUEZ5?=
 =?utf-8?B?anZyaFRSdzVDRnR4MXp2cXlWUVVWeEt2a2E3azRGMkZKMU8rdmdBbG9mcHJG?=
 =?utf-8?B?Uy9SNHI4S3N0a3BVREdFMHpXSk8yVkk4cGtJMkVabzRqTGllbkNwT1pDNVM5?=
 =?utf-8?B?U3hnREtIY2ZuVVdvSU5wVlNISG42N3J1SW5YQVdqbGFWYWorMkxhaE0yMnpk?=
 =?utf-8?B?aThzR2NjSXNSVDIzNTg0bE1sTTg5My9YUHJCTTVTaGorVHJIQ1I2bytoOEVF?=
 =?utf-8?B?OUxVZFgwaXdRZzBiWkllWGhvRVdKUERxN2NzdE5uQmJUeWd2NU9NWTRaYjhl?=
 =?utf-8?B?RWVBS1FuWUhGMDFTM0FhTURDblJBRVpQa2pXNTRQVVEzQksxRzRLNkxzZy8w?=
 =?utf-8?B?Uk8wb0N5Z2x4UFA5TC9ZNG05U2FpR1NLRXF2Tm1iVFh4WC9UNFRvRUZWRW9r?=
 =?utf-8?B?YlhwSjVESlFxN1lCaVNQTkZaWmNLZmd5b1lwczdRSzNmNmNnbExIc3V2ZFZG?=
 =?utf-8?B?SEw5YzkyRDRwdWZFaDNVZnB4V2ZtZGRCVHVJZnhoSDZPQnFORFpjbVFwbjl3?=
 =?utf-8?B?VHhNeEtsVDNlaWFOT3kvcFlaaHJLSk9idlYrc1dYaFZKSlRMS3I3dGxSREti?=
 =?utf-8?B?dS85UmQ1UGN5Y2tNamM1VHdrQ0FGK2d2aW0yV0x6STZwbnZyOTBZTXlINFJW?=
 =?utf-8?B?Y3RLTkhHMHA4UDJXLzF3ZEJDdVRIRlNwdldUMDFXTkpYSS9ScmJWNk1hNG5R?=
 =?utf-8?B?Q0lJNHNSK0plU3RCNWpvWjFHWTdDVFV2Vk1iSmZ1TEtNcVNGaTJpR0krdGw5?=
 =?utf-8?B?YWkxMHhRa0RRWTNWV2l0MUVHMVJaSVROMWxqN2s5NTNQSVI1bFhMSks5c1Mr?=
 =?utf-8?B?VnNHaU5RWEtqQ3RsVnl2Z24vd3QzaTVyamZidFRpeEIrbFZjVkJWY011aWJ0?=
 =?utf-8?B?Vm5qVkZyNEluTjhCUXdtaGx4UEtMelRwRlBYSGJLbVgvSU5OWWwwZ1B0MkJp?=
 =?utf-8?B?Q0J3SWYzdkRyZ2xsenplY3F1WVRGUFhxdURFQ3RVbGtlUnFmZkptV3B6aWM2?=
 =?utf-8?Q?LSuIv/JCD2Vn/vXoeqvFkNEC6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384aaf74-0bfe-4401-62e5-08dc813e2fd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:52:07.4898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On6tjh3a3KkkxRof4+hZ0fvC1iNEqCpUTrjuGfoNSpVLZDn+wFMjIObOWsoPs+MB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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

Am 31.05.24 um 00:02 schrieb Felix Kuehling:
> On 2024-05-28 13:23, Yunxiang Li wrote:
>> These functions are missing the lock for reset domain.
>>
>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                | 8 ++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index eb172388d99e..ddc5e9972da8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -34,6 +34,7 @@
>>   #include <asm/set_memory.h>
>>   #endif
>>   #include "amdgpu.h"
>> +#include "amdgpu_reset.h"
>>   #include <drm/drm_drv.h>
>>   #include <drm/ttm/ttm_tt.h>
>>   @@ -401,13 +402,14 @@ void amdgpu_gart_invalidate_tlb(struct 
>> amdgpu_device *adev)
>>   {
>>       int i;
>>   -    if (!adev->gart.ptr)
>> +    if (!adev->gart.ptr || 
>> !down_read_trylock(&adev->reset_domain->sem))
>>           return;
>>         mb();
>>       amdgpu_device_flush_hdp(adev, NULL);
>>       for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
>>           amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>> +    up_read(&adev->reset_domain->sem);
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index e4742b65032d..52a3170d15b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -307,8 +307,12 @@ static struct dma_fence *amdgpu_job_run(struct 
>> drm_sched_job *sched_job)
>>           dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
>>               ring->name);
>>       } else {
>> -        r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
>> -                       &fence);
>> +        r = -ETIME;
>> +        if (down_read_trylock(&adev->reset_domain->sem)) {
>> +            r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
>> +                           job, &fence);
>> +            up_read(&adev->reset_domain->sem);
>> +        }
>>           if (r)
>>               dev_err(adev->dev,
>>                   "Error scheduling IBs (%d) in ring(%s)", r,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 86ea610b16f3..21f5a1fb3bf8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -28,6 +28,7 @@
>>   #include "kfd_priv.h"
>>   #include "kfd_kernel_queue.h"
>>   #include "amdgpu_amdkfd.h"
>> +#include "amdgpu_reset.h"
>>     static inline struct process_queue_node *get_queue_by_qid(
>>               struct process_queue_manager *pqm, unsigned int qid)
>> @@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct 
>> kfd_process_device *pdd)
>>           return;
>>         dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
>> -    if (dev->kfd->shared_resources.enable_mes)
>> -        amdgpu_mes_flush_shader_debugger(dev->adev, 
>> pdd->proc_ctx_gpu_addr);
>> +    if (dev->kfd->shared_resources.enable_mes &&
>> + down_read_trylock(&dev->adev->reset_domain->sem)) {
>> +        amdgpu_mes_flush_shader_debugger(dev->adev,
>> +                         pdd->proc_ctx_gpu_addr);
>> +
>
> It's not clear to me what's the requirement for reset domain locking 
> around MES calls. We have a lot more of them in 
> kfd_device_queue_manager.c (mostly calling adev->mes.funcs->... 
> directly). Do they all need to be wrapped individually?

Whenever you call a MES function (or any other function directly 
interacting with the rings or the HW registers) you need to make sure 
that at least the read side of the reset lock is held.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>> up_read(&dev->adev->reset_domain->sem);
>> +    }
>>       pdd->already_dequeued = true;
>>   }

