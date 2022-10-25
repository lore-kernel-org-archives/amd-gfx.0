Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC047C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 11:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B1410E341;
	Tue, 25 Oct 2022 11:38:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE5A10E322
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 11:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUlxjDkIhd+Vt7QeR5TX8GDM1AOYPlBxDKyLF4nRTs1EiLsj5h6VDwT7bvGainT2Wnrl6rW9tD0p8Yo0qXlEDPPugPeByCCRZcWNu5rIU5PUpZsmrzzPHCwqkRKpsknYLw9Wp7TEpQ+BhnoZiHyc0/WF1k1PUgvZEXGgMJNJVi6+DO8wnUrVUjnHfVgrbSeJdTVofjGz9o6dCRTaE9agsiPV1ujkuvj9Ch/eG2/hrLg41glH+vaUa2YltI9592RyGVrYZoCh2rnScWPmQXHXGnhszztqH3iAdj6SaYdKO+U5UcvZwbUqMT2X2zzhDj94jrvLOXMKUxtJ1Beh+8/zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx7tLHHf2mAhVf8tAusnaQHfRXoYxEB3bUQl+giVLX0=;
 b=BLNFRIGvs17+rI2JfbEv73/rbOP0KLphYY7KfiS2zLqKb/wevwiO5Ii9EeGUAL9fA8wuXjyMH8AU1/dXx0mrm/IH4bXZSzkOUGNs6Nk40DlaxLtKOurTLPewlD+Q87O0AfiUw0/EaOcDJ/txSlS5ZdDeQ8Fji7IeWgXIKVrmGxoJm2ZWqz/QxxvhCzMwK3GjwkKo2MIV3FcbEonBlZ2BH7IfH4XAnrw2aq/DZo2OQCMDuylGPeaNjPw4J9tP3n3Qec4bBNMZn9j6xx66HjNJ9SWw9aZrX2Pv4j1MRLntumFegUfitA8mmUxw3Bra6fMnOwsdgrcHANcmszD/9JklwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx7tLHHf2mAhVf8tAusnaQHfRXoYxEB3bUQl+giVLX0=;
 b=Q5CDG808TpOyJdGj/t4K93vSwhvHb+lgifl0HPFWTKHH5oTncfFvslgOXnREGUp6DeZ51Ngye7tUsLVuB37xEMrDLpEHIlzzV2HK4G/Z6OQQKs0GLoASUhk/zOQE8d0A1T5qc/CUkwqQyN9C5yWznf+ii4c/ztZra06fn7T6DiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 11:37:59 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%5]) with mapi id 15.20.5746.027; Tue, 25 Oct 2022
 11:37:59 +0000
Message-ID: <2482e26c-9d26-3eca-c402-cbe9de50fc27@amd.com>
Date: Tue, 25 Oct 2022 19:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] drm/amdkfd: Fix the warning of
 array-index-out-of-bounds
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20221024112639.3440664-1-Jun.Ma2@amd.com>
 <20221024112639.3440664-2-Jun.Ma2@amd.com>
 <bda0c7ec-8bd4-2829-fae3-fed6562f0670@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <bda0c7ec-8bd4-2829-fae3-fed6562f0670@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: edaabdaa-ccc2-4702-a6cb-08dab67d5e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dvcopxLWMJS4evEzaQzNOF8MHi3riWf/Cq5gD0h2/GmNXmkenimNtN1e3cxAwIezsOU4EShLftGS5VJSTiatFEpf2ZXNSYu64ODKpAzJfM0XjMnvcr3sPO1UadeCj3otMvBX21i1banTgq5XgT7/EewPXrAHQbh7HNHm/pu4ODbNQkCVInKoOODGc9dsVf4yQvJVSC90XTwvvdMBsm3nmULdRbgfVdTf8Uus7JD3++VzY7acvbkDmk0Kg+ilP4GBewTI3+nsBRf07xx5d5Ai16NF/Du4MHTT/nRJ7mYF790gTkZEc7V2w63tzoSSKEbIXbO+gamfULj2+fODauMnkXsdC33VD5DQ336g7IvPvrMZVQ61vDowUN5ILLiLDXh6xLfpRo29KBG5xtApuWaaNsHF7eygItv3FmyV2vIJpeFD/dHKOKtn4l6cdpGK1ThYhgjMB7dA2iQRyt0YOipqj/lqzTFBG8/CZOZKwobPgBoxAfQfJW0Ul5Y+oCfPrtEs33vThLnUB17xs2APNP/4tzg5/aFunpmoO03ptqa9JNnCJYKbmzFpAem/hB5sfVXqRmNmSwCi9TtTCzFbLIhnvGStE5OVMaGfdfsQdqh52Y0+bzOmw9A3bSlz59w4nMUZtDvxnsq5qbaK33BwMxmd1nMoQhmI1WrXbbNkJIow9lnlAZIa1MmZyZ7s2fAtR9fI1qUG3gv9263lbDehbb3QUljPwQoiHvDJ569d7LbK4C1kjWDIa9Aw95tGj7BcW5VggLz0ys2CYSNiLuXozOdfTn/QUtRGIECernz952sscI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(6506007)(6636002)(66476007)(110136005)(8936002)(316002)(66556008)(66946007)(6512007)(5660300002)(4326008)(8676002)(6666004)(41300700001)(26005)(53546011)(38100700002)(186003)(2906002)(2616005)(36756003)(4001150100001)(30864003)(478600001)(6486002)(83380400001)(31696002)(31686004)(43740500002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01qdkViSHcvbUNmUzBRbjFVZVJydmh0TFJOSkdTd3h2eWw1NzJFaml3Zkg2?=
 =?utf-8?B?bm1Kcms1M3NjT0FJdDRiSEdTWjdNVnp5MyszcUx1aittUE9JWm5CaE04cVV4?=
 =?utf-8?B?QVB6Mm1aWU9mSkR0UXJGa1h6aFlVYWlmZ3dza0p3MmsxTjRneWxZcE90Mm1u?=
 =?utf-8?B?K29QNlRGOHRLajd6bUttZjdwbWJXTUlhOGlaQy9DTWg3KzdpYitCZmF6NmdQ?=
 =?utf-8?B?VWZBVkxUSHNkY09jSXVuejRURFkyNDh0RGdPV3NKQW5malNBUmNQWjNTMkRp?=
 =?utf-8?B?SDFlOTlYTEZlNjhVNFZSQmkySUtySnk1TEtvQkd4dzVtdFBtNGVFS2hPVGF4?=
 =?utf-8?B?S3RyS1JVclNON1lFdXBxMkJMNHNuT29ySTJLMkxyY25xK3YyVWxiT1BsYmph?=
 =?utf-8?B?SFFYRklVWFVORHNEUXJac3VhTC9vV0piSWswZTJpeGtBL2ZWVmZXL0FQajYw?=
 =?utf-8?B?R1B0N3RKajVZaVk2R2JxL2JNM1B6dDRUb3pYUzd3OHc5ZHRYOTFlVzBaQTlp?=
 =?utf-8?B?Mjg0NVRoUGd2b3lqRXUrM3A5SmkxSjQ3a0ljcEF6WjBIR2dSN1ZjNHhKN1lt?=
 =?utf-8?B?aURQNUFBbW44R1NlY0JhTWR1VXVJUTloMC81WVU2SnBld2tLUlBNR09GdlJY?=
 =?utf-8?B?cHBjQnRYNThjaEl1WU5YTWQzR3BGSXhabTJMc0g2SnFDY3Vnd0s1UWpLaURD?=
 =?utf-8?B?VVJIZUg2N1EyTkZlcWtGczNHUnlZNjI4VDBlaktXb2hiZ2tMNC9jRkY0RlRz?=
 =?utf-8?B?cE1NSTVCT0trTmdsVHU0Y3JWR2NRK2FYVUNGUG90VkxPNkdKUXBieVlrSG8v?=
 =?utf-8?B?TG1vWFNMSGJEaFJLRFdsS2dhZFkzUjc2bFlvYWowYWNxbkVJVmtlaGlCR2l5?=
 =?utf-8?B?ajd5b2hMSE15N1VGYnUzcnlaMlJnV1lOZG4zYTVTOFRoMHVRMjN1M3MwVWxB?=
 =?utf-8?B?SitVa21NUk1wcmZXaGJUTEhQUUNsV3dCSTFWSUdwdEpxb1RBMHRwMEdXOFI0?=
 =?utf-8?B?VGdFdWJDMk9MY3dvZkpyaUhHdE5ZV3BwbkFCZlFiK0tUdEk0Myt3bGhiZy9s?=
 =?utf-8?B?OUNCRktLOHo0STlQWGV0L2F6RWt5bHEzbUJOd0t0OWNRckEvNUFqZ1hyMEdM?=
 =?utf-8?B?SGxQZ0lJNkFQbVlKcUFSSUtTMkRvNzJDY1Ezd0Q4aXVCU2x6MkJnSmt5WlRl?=
 =?utf-8?B?amwxZXFLSUZzbllyTFY2dzJxVFlvbjdoNkJMcmw3RENzWFBlN0FnUUlRajVT?=
 =?utf-8?B?MFg3Z2c3UXRaaTIwUnhCZzBENVgvNkl6WWkxcWJjaGxwNVB0S0cxcVcxcFBz?=
 =?utf-8?B?YmFxV2xBM0doUWpRVzFTNjRTODNoVzR3cEhUR3pYTVRpOGpvc2M0YVZ1U0t6?=
 =?utf-8?B?UytDL21pcXViUFB6bTZKZlBQOGhPNy82Lzh2U00zdHFTQVVpR0FPdHJVekRP?=
 =?utf-8?B?TThMUzJtY0pJdGFscjBqaWNBK1BWbDcwYkh2dTZtd3FKbGNKclFLeFVQQjFN?=
 =?utf-8?B?QUZQOEREN0JrMEtqaHhFeWpLbFQyeFRHRU96QS85S2JEZVZNMlRpbjBvZ001?=
 =?utf-8?B?R0JhZVV2eG1XMWZGSzArdHZVWFM1aUZiVk03RXJLQ3NJNHMrdGVOV3NSUHpX?=
 =?utf-8?B?SVZjM1RBTVdxL3p1VFdVNzAvUzUxdkNWbXhydWFtMktXNy9WT2Q1eXVQOHlK?=
 =?utf-8?B?S25rWDZJMFZGWkphZExjZDB2enRjOFc4MEpoMHZOVGR2Mk5PR3ZRdExQSWlC?=
 =?utf-8?B?eWJVQ1p2TW00cHdxalNPdmtiVXpqbWlDdkVETkpESXZCdStwRjhKakVSRGd2?=
 =?utf-8?B?SVRXWGxzWlJVYXhzV0hxNTZ6RFQrKzZwZ1dnTWFZQk8xejJEdENybEtGejkw?=
 =?utf-8?B?TWdTWVhJbmFJdGY0ZGlWeUdLb0xlaEVmUEdUK1pCSGJkbUVmNmxZU2Z5K0VE?=
 =?utf-8?B?Rk1KcXR1azkzcWhLekttc1dFMmJzMjcrcGs2RFdhbFB0YmR0Z05tNW9iOGd2?=
 =?utf-8?B?YTd1QTdmaDloV1pMRVV6SnhPcGJwVm83Tk9yckgvcGlqeDIwZmN6VFRuT3JT?=
 =?utf-8?B?NHFseVBrem1tOG12SmtSeURkN2VUSEdwZHphTEpPRWgvK2FPSlhrdmF3NFJY?=
 =?utf-8?Q?otznzRt57FKVNJ+9fbszOwi9Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaabdaa-ccc2-4702-a6cb-08dab67d5e15
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 11:37:59.5584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZKX1oizJbVek3ODi8nA9trcEi2nHOWHdwxvpxkn9v6O7NE1S756svG2oLWa4Nct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

On 10/25/2022 5:06 AM, Felix Kuehling wrote:
> 
> On 2022-10-24 07:26, Ma Jun wrote:
>> For some GPUs with more CUs, the original sibling_map[32]
>> in struct crat_subtype_cache is not enough
>> to save the cache information when create the VCRAT table,
>> so fill the cache info into struct kfd_cache_properties_ext
>> directly to fix the problem.
>>
>> At the same time, a new directory
>> "/sys/class/kfd/kfd/topology/nodes/*nodes_num*/caches_ext"
>> is created for cache information showing.
> 
> Is this necessary because existing user mode cannot handle the larger 
> sibling map? If so, you'll also need to update the Thunk to parse the 
> information from caches_ext. Do you have a link to that patch?
> 
> If user mode can handle a larger siblingmap in the existing sysfs 
> interface, we should not create new one.
> 
> Another alternative is to add more lines to the existing cache info 
> sysfs entries. Older user mode will probably ignore the ones it doesn't 
> know about.
> 
Yes, it's not necessary to make a new directory for cache.

How about the code below?

+#define CAHCHE_INFO_FROM_CRAT  0x00000001
+#define CAHCHE_INFO_FROM_VCRAT 0x00000002
+
+#define VCRAT_SIBLINGMAP_SIZE 64
+
 struct kfd_cache_properties {
        struct list_head        list;
        uint32_t                processor_id_low;
@@ -98,9 +103,11 @@ struct kfd_cache_properties {
        uint32_t                cache_latency;
        uint32_t                cache_type;
        uint8_t                 sibling_map[CRAT_SIBLINGMAP_SIZE];
+       uint8_t                 sibling_map_ext[VCRAT_SIBLINGMAP_SIZE];
        struct kfd_dev          *gpu;
        struct kobject          *kobj;
        struct attribute        attr;
+       uint32_t                flags;
 };

        cache = container_of(attr, struct kfd_cache_properties, attr);
        if (cache->gpu && kfd_devcgroup_check_permission(cache->gpu))
                return -EPERM;
@@ -402,12 +1142,22 @@ static ssize_t kfd_cache_show(struct kobject *kobj, struct attribute *attr,
        sysfs_show_32bit_prop(buffer, offs, "association", cache->cache_assoc);
        sysfs_show_32bit_prop(buffer, offs, "latency", cache->cache_latency);
        sysfs_show_32bit_prop(buffer, offs, "type", cache->cache_type);
-       offs += snprintf(buffer+offs, PAGE_SIZE-offs, "sibling_map ");
-       for (i = 0; i < CRAT_SIBLINGMAP_SIZE; i++)
-               for (j = 0; j < sizeof(cache->sibling_map[0])*8; j++)
-                       /* Check each bit */
-                       offs += snprintf(buffer+offs, PAGE_SIZE-offs, "%d,",
-                                        (cache->sibling_map[i] >> j) & 1);
+
+       if (cache->flags & CAHCHE_INFO_FROM_CRAT) {
+               offs += snprintf(buffer+offs, PAGE_SIZE-offs, "sibling_map ");
+               for (i = 0; i < CRAT_SIBLINGMAP_SIZE; i++)
+                       for (j = 0; j < sizeof(cache->sibling_map[0])*8; j++)
+                               /* Check each bit */
+                               offs += snprintf(buffer+offs, PAGE_SIZE-offs, "%d,",
+                                               (cache->sibling_map[i] >> j) & 1);
+       } else if (cache->flags & CAHCHE_INFO_FROM_VCRAT) {
+               offs += snprintf(buffer+offs, PAGE_SIZE-offs, "sibling_map ");
+               for (i = 0; i < VCRAT_SIBLINGMAP_SIZE; i++)
+                       for (j = 0; j < sizeof(cache->sibling_map_ext[0])*8; j++)
+                               /* Check each bit */
+                               offs += snprintf(buffer+offs, PAGE_SIZE-offs, "%d,",
+                                               (cache->sibling_map_ext[i] >> j) & 1);
+       }
 
Regards,
Ma Jun

> Regards,
>    Felix
> 
> 
>>
>> The original directory "cache" is reserved for GPU which using real CRAT
>> table.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 1229 +-------------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1246 ++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   21 +
>>   3 files changed, 1261 insertions(+), 1235 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 4857ec5b9f46..e6928c60338e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -30,799 +30,6 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_amdkfd.h"
>>   
>> -/* Static table to describe GPU Cache information */
>> -struct kfd_gpu_cache_info {
>> -	uint32_t	cache_size;
>> -	uint32_t	cache_level;
>> -	uint32_t	flags;
>> -	/* Indicates how many Compute Units share this cache
>> -	 * within a SA. Value = 1 indicates the cache is not shared
>> -	 */
>> -	uint32_t	num_cu_shared;
>> -};
>> -
>> -static struct kfd_gpu_cache_info kaveri_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache (in SQC module) per bank */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache (in SQC module) per bank */
>> -		.cache_size = 8,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -
>> -	/* TODO: Add L2 Cache information */
>> -};
>> -
>> -
>> -static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache (in SQC module) per bank */
>> -		.cache_size = 8,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 4,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache (in SQC module) per bank. */
>> -		.cache_size = 4,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 4,
>> -	},
>> -
>> -	/* TODO: Add L2 Cache information */
>> -};
>> -
>> -#define hawaii_cache_info kaveri_cache_info
>> -#define tonga_cache_info carrizo_cache_info
>> -#define fiji_cache_info  carrizo_cache_info
>> -#define polaris10_cache_info carrizo_cache_info
>> -#define polaris11_cache_info carrizo_cache_info
>> -#define polaris12_cache_info carrizo_cache_info
>> -#define vegam_cache_info carrizo_cache_info
>> -
>> -/* NOTE: L1 cache information has been updated and L2/L3
>> - * cache information has been added for Vega10 and
>> - * newer ASICs. The unit for cache_size is KiB.
>> - * In future,  check & update cache details
>> - * for every new ASIC is required.
>> - */
>> -
>> -static struct kfd_gpu_cache_info vega10_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 4096,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 16,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info raven_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 1024,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 11,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info renoir_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 1024,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info vega12_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 2048,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 5,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info vega20_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 3,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 8192,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 16,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 8192,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 14,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info navi10_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 4096,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 1024,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info navi14_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 12,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 2048,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 12,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 4096,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -	{
>> -		/* L3 Data Cache per GPU */
>> -		.cache_size = 128*1024,
>> -		.cache_level = 3,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 3072,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -	{
>> -		/* L3 Data Cache per GPU */
>> -		.cache_size = 96*1024,
>> -		.cache_level = 3,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 10,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 2048,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -	{
>> -		/* L3 Data Cache per GPU */
>> -		.cache_size = 32*1024,
>> -		.cache_level = 3,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 1024,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -	{
>> -		/* L3 Data Cache per GPU */
>> -		.cache_size = 16*1024,
>> -		.cache_level = 3,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 8,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>> -	{
>> -		/* TCP L1 Cache per CU */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 1,
>> -	},
>> -	{
>> -		/* Scalar L1 Instruction Cache per SQC */
>> -		.cache_size = 32,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_INST_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* Scalar L1 Data Cache per SQC */
>> -		.cache_size = 16,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 2,
>> -	},
>> -	{
>> -		/* GL1 Data Cache per SA */
>> -		.cache_size = 128,
>> -		.cache_level = 1,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 6,
>> -	},
>> -	{
>> -		/* L2 Data Cache per GPU (Total Tex Cache) */
>> -		.cache_size = 2048,
>> -		.cache_level = 2,
>> -		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -				CRAT_CACHE_FLAGS_DATA_CACHE |
>> -				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -		.num_cu_shared = 6,
>> -	},
>> -};
>> -
>> -static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
>> -       {
>> -               /* TCP L1 Cache per CU */
>> -               .cache_size = 16,
>> -               .cache_level = 1,
>> -               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -                               CRAT_CACHE_FLAGS_DATA_CACHE |
>> -                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -               .num_cu_shared = 1,
>> -       },
>> -       {
>> -               /* Scalar L1 Instruction Cache per SQC */
>> -               .cache_size = 32,
>> -               .cache_level = 1,
>> -               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -                               CRAT_CACHE_FLAGS_INST_CACHE |
>> -                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -               .num_cu_shared = 2,
>> -       },
>> -       {
>> -               /* Scalar L1 Data Cache per SQC */
>> -               .cache_size = 16,
>> -               .cache_level = 1,
>> -               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -                               CRAT_CACHE_FLAGS_DATA_CACHE |
>> -                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -               .num_cu_shared = 2,
>> -       },
>> -       {
>> -               /* GL1 Data Cache per SA */
>> -               .cache_size = 128,
>> -               .cache_level = 1,
>> -               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -                               CRAT_CACHE_FLAGS_DATA_CACHE |
>> -                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -               .num_cu_shared = 2,
>> -       },
>> -       {
>> -               /* L2 Data Cache per GPU (Total Tex Cache) */
>> -               .cache_size = 256,
>> -               .cache_level = 2,
>> -               .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -                               CRAT_CACHE_FLAGS_DATA_CACHE |
>> -                               CRAT_CACHE_FLAGS_SIMD_CACHE),
>> -               .num_cu_shared = 2,
>> -       },
>> -};
>> -
>>   static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
>>   		struct crat_subtype_computeunit *cu)
>>   {
>> @@ -1223,419 +430,6 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
>>   	return ret;
>>   }
>>   
>> -/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
>> -static int fill_in_l1_pcache(struct crat_subtype_cache *pcache,
>> -				struct kfd_gpu_cache_info *pcache_info,
>> -				struct kfd_cu_info *cu_info,
>> -				int mem_available,
>> -				int cu_bitmask,
>> -				int cache_type, unsigned int cu_processor_id,
>> -				int cu_block)
>> -{
>> -	unsigned int cu_sibling_map_mask;
>> -	int first_active_cu;
>> -
>> -	/* First check if enough memory is available */
>> -	if (sizeof(struct crat_subtype_cache) > mem_available)
>> -		return -ENOMEM;
>> -
>> -	cu_sibling_map_mask = cu_bitmask;
>> -	cu_sibling_map_mask >>= cu_block;
>> -	cu_sibling_map_mask &=
>> -		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>> -	first_active_cu = ffs(cu_sibling_map_mask);
>> -
>> -	/* CU could be inactive. In case of shared cache find the first active
>> -	 * CU. and incase of non-shared cache check if the CU is inactive. If
>> -	 * inactive active skip it
>> -	 */
>> -	if (first_active_cu) {
>> -		memset(pcache, 0, sizeof(struct crat_subtype_cache));
>> -		pcache->type = CRAT_SUBTYPE_CACHE_AFFINITY;
>> -		pcache->length = sizeof(struct crat_subtype_cache);
>> -		pcache->flags = pcache_info[cache_type].flags;
>> -		pcache->processor_id_low = cu_processor_id
>> -					 + (first_active_cu - 1);
>> -		pcache->cache_level = pcache_info[cache_type].cache_level;
>> -		pcache->cache_size = pcache_info[cache_type].cache_size;
>> -
>> -		/* Sibling map is w.r.t processor_id_low, so shift out
>> -		 * inactive CU
>> -		 */
>> -		cu_sibling_map_mask =
>> -			cu_sibling_map_mask >> (first_active_cu - 1);
>> -
>> -		pcache->sibling_map[0] = (uint8_t)(cu_sibling_map_mask & 0xFF);
>> -		pcache->sibling_map[1] =
>> -				(uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
>> -		pcache->sibling_map[2] =
>> -				(uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
>> -		pcache->sibling_map[3] =
>> -				(uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
>> -		return 0;
>> -	}
>> -	return 1;
>> -}
>> -
>> -/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
>> -static int fill_in_l2_l3_pcache(struct crat_subtype_cache *pcache,
>> -				struct kfd_gpu_cache_info *pcache_info,
>> -				struct kfd_cu_info *cu_info,
>> -				int mem_available,
>> -				int cache_type, unsigned int cu_processor_id)
>> -{
>> -	unsigned int cu_sibling_map_mask;
>> -	int first_active_cu;
>> -	int i, j, k;
>> -
>> -	/* First check if enough memory is available */
>> -	if (sizeof(struct crat_subtype_cache) > mem_available)
>> -		return -ENOMEM;
>> -
>> -	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
>> -	cu_sibling_map_mask &=
>> -		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>> -	first_active_cu = ffs(cu_sibling_map_mask);
>> -
>> -	/* CU could be inactive. In case of shared cache find the first active
>> -	 * CU. and incase of non-shared cache check if the CU is inactive. If
>> -	 * inactive active skip it
>> -	 */
>> -	if (first_active_cu) {
>> -		memset(pcache, 0, sizeof(struct crat_subtype_cache));
>> -		pcache->type = CRAT_SUBTYPE_CACHE_AFFINITY;
>> -		pcache->length = sizeof(struct crat_subtype_cache);
>> -		pcache->flags = pcache_info[cache_type].flags;
>> -		pcache->processor_id_low = cu_processor_id
>> -					 + (first_active_cu - 1);
>> -		pcache->cache_level = pcache_info[cache_type].cache_level;
>> -		pcache->cache_size = pcache_info[cache_type].cache_size;
>> -
>> -		/* Sibling map is w.r.t processor_id_low, so shift out
>> -		 * inactive CU
>> -		 */
>> -		cu_sibling_map_mask =
>> -			cu_sibling_map_mask >> (first_active_cu - 1);
>> -		k = 0;
>> -		for (i = 0; i < cu_info->num_shader_engines; i++) {
>> -			for (j = 0; j < cu_info->num_shader_arrays_per_engine;
>> -				j++) {
>> -				pcache->sibling_map[k] =
>> -				 (uint8_t)(cu_sibling_map_mask & 0xFF);
>> -				pcache->sibling_map[k+1] =
>> -				 (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
>> -				pcache->sibling_map[k+2] =
>> -				 (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
>> -				pcache->sibling_map[k+3] =
>> -				 (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
>> -				k += 4;
>> -				cu_sibling_map_mask =
>> -					cu_info->cu_bitmap[i % 4][j + i / 4];
>> -				cu_sibling_map_mask &= (
>> -				 (1 << pcache_info[cache_type].num_cu_shared)
>> -				 - 1);
>> -			}
>> -		}
>> -		return 0;
>> -	}
>> -	return 1;
>> -}
>> -
>> -#define KFD_MAX_CACHE_TYPES 6
>> -
>> -static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>> -						   struct kfd_gpu_cache_info *pcache_info)
>> -{
>> -	struct amdgpu_device *adev = kdev->adev;
>> -	int i = 0;
>> -
>> -	/* TCP L1 Cache per CU */
>> -	if (adev->gfx.config.gc_tcp_l1_size) {
>> -		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_l1_size;
>> -		pcache_info[i].cache_level = 1;
>> -		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -					CRAT_CACHE_FLAGS_DATA_CACHE |
>> -					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> -		pcache_info[0].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
>> -		i++;
>> -	}
>> -	/* Scalar L1 Instruction Cache per SQC */
>> -	if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
>> -		pcache_info[i].cache_size =
>> -			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
>> -		pcache_info[i].cache_level = 1;
>> -		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -					CRAT_CACHE_FLAGS_INST_CACHE |
>> -					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> -		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
>> -		i++;
>> -	}
>> -	/* Scalar L1 Data Cache per SQC */
>> -	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
>> -		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
>> -		pcache_info[i].cache_level = 1;
>> -		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -					CRAT_CACHE_FLAGS_DATA_CACHE |
>> -					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> -		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
>> -		i++;
>> -	}
>> -	/* GL1 Data Cache per SA */
>> -	if (adev->gfx.config.gc_gl1c_per_sa &&
>> -	    adev->gfx.config.gc_gl1c_size_per_instance) {
>> -		pcache_info[i].cache_size = adev->gfx.config.gc_gl1c_per_sa *
>> -			adev->gfx.config.gc_gl1c_size_per_instance;
>> -		pcache_info[i].cache_level = 1;
>> -		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -					CRAT_CACHE_FLAGS_DATA_CACHE |
>> -					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> -		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>> -		i++;
>> -	}
>> -	/* L2 Data Cache per GPU (Total Tex Cache) */
>> -	if (adev->gfx.config.gc_gl2c_per_gpu) {
>> -		pcache_info[i].cache_size = adev->gfx.config.gc_gl2c_per_gpu;
>> -		pcache_info[i].cache_level = 2;
>> -		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -					CRAT_CACHE_FLAGS_DATA_CACHE |
>> -					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> -		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>> -		i++;
>> -	}
>> -	/* L3 Data Cache per GPU */
>> -	if (adev->gmc.mall_size) {
>> -		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;
>> -		pcache_info[i].cache_level = 3;
>> -		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> -					CRAT_CACHE_FLAGS_DATA_CACHE |
>> -					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> -		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>> -		i++;
>> -	}
>> -	return i;
>> -}
>> -
>> -/* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
>> - * tables
>> - *
>> - *	@kdev - [IN] GPU device
>> - *	@gpu_processor_id - [IN] GPU processor ID to which these caches
>> - *			    associate
>> - *	@available_size - [IN] Amount of memory available in pcache
>> - *	@cu_info - [IN] Compute Unit info obtained from KGD
>> - *	@pcache - [OUT] memory into which cache data is to be filled in.
>> - *	@size_filled - [OUT] amount of data used up in pcache.
>> - *	@num_of_entries - [OUT] number of caches added
>> - */
>> -static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>> -			int gpu_processor_id,
>> -			int available_size,
>> -			struct kfd_cu_info *cu_info,
>> -			struct crat_subtype_cache *pcache,
>> -			int *size_filled,
>> -			int *num_of_entries)
>> -{
>> -	struct kfd_gpu_cache_info *pcache_info;
>> -	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
>> -	int num_of_cache_types = 0;
>> -	int i, j, k;
>> -	int ct = 0;
>> -	int mem_available = available_size;
>> -	unsigned int cu_processor_id;
>> -	int ret;
>> -	unsigned int num_cu_shared;
>> -
>> -	switch (kdev->adev->asic_type) {
>> -	case CHIP_KAVERI:
>> -		pcache_info = kaveri_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(kaveri_cache_info);
>> -		break;
>> -	case CHIP_HAWAII:
>> -		pcache_info = hawaii_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(hawaii_cache_info);
>> -		break;
>> -	case CHIP_CARRIZO:
>> -		pcache_info = carrizo_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(carrizo_cache_info);
>> -		break;
>> -	case CHIP_TONGA:
>> -		pcache_info = tonga_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(tonga_cache_info);
>> -		break;
>> -	case CHIP_FIJI:
>> -		pcache_info = fiji_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(fiji_cache_info);
>> -		break;
>> -	case CHIP_POLARIS10:
>> -		pcache_info = polaris10_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(polaris10_cache_info);
>> -		break;
>> -	case CHIP_POLARIS11:
>> -		pcache_info = polaris11_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(polaris11_cache_info);
>> -		break;
>> -	case CHIP_POLARIS12:
>> -		pcache_info = polaris12_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(polaris12_cache_info);
>> -		break;
>> -	case CHIP_VEGAM:
>> -		pcache_info = vegam_cache_info;
>> -		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
>> -		break;
>> -	default:
>> -		switch (KFD_GC_VERSION(kdev)) {
>> -		case IP_VERSION(9, 0, 1):
>> -			pcache_info = vega10_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
>> -			break;
>> -		case IP_VERSION(9, 2, 1):
>> -			pcache_info = vega12_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
>> -			break;
>> -		case IP_VERSION(9, 4, 0):
>> -		case IP_VERSION(9, 4, 1):
>> -			pcache_info = vega20_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
>> -			break;
>> -		case IP_VERSION(9, 4, 2):
>> -			pcache_info = aldebaran_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
>> -			break;
>> -		case IP_VERSION(9, 1, 0):
>> -		case IP_VERSION(9, 2, 2):
>> -			pcache_info = raven_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(raven_cache_info);
>> -			break;
>> -		case IP_VERSION(9, 3, 0):
>> -			pcache_info = renoir_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 1, 10):
>> -		case IP_VERSION(10, 1, 2):
>> -		case IP_VERSION(10, 1, 3):
>> -		case IP_VERSION(10, 1, 4):
>> -			pcache_info = navi10_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 1, 1):
>> -			pcache_info = navi14_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 0):
>> -			pcache_info = sienna_cichlid_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 2):
>> -			pcache_info = navy_flounder_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 4):
>> -			pcache_info = dimgrey_cavefish_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 1):
>> -			pcache_info = vangogh_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 5):
>> -			pcache_info = beige_goby_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 3):
>> -		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
>> -			pcache_info = yellow_carp_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
>> -			break;
>> -		case IP_VERSION(10, 3, 6):
>> -			pcache_info = gc_10_3_6_cache_info;
>> -			num_of_cache_types = ARRAY_SIZE(gc_10_3_6_cache_info);
>> -			break;
>> -		case IP_VERSION(11, 0, 0):
>> -		case IP_VERSION(11, 0, 1):
>> -		case IP_VERSION(11, 0, 2):
>> -		case IP_VERSION(11, 0, 3):
>> -			pcache_info = cache_info;
>> -			num_of_cache_types =
>> -				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
>> -			break;
>> -		default:
>> -			return -EINVAL;
>> -		}
>> -	}
>> -
>> -	*size_filled = 0;
>> -	*num_of_entries = 0;
>> -
>> -	/* For each type of cache listed in the kfd_gpu_cache_info table,
>> -	 * go through all available Compute Units.
>> -	 * The [i,j,k] loop will
>> -	 *		if kfd_gpu_cache_info.num_cu_shared = 1
>> -	 *			will parse through all available CU
>> -	 *		If (kfd_gpu_cache_info.num_cu_shared != 1)
>> -	 *			then it will consider only one CU from
>> -	 *			the shared unit
>> -	 */
>> -
>> -	for (ct = 0; ct < num_of_cache_types; ct++) {
>> -	  cu_processor_id = gpu_processor_id;
>> -	  if (pcache_info[ct].cache_level == 1) {
>> -	    for (i = 0; i < cu_info->num_shader_engines; i++) {
>> -	      for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
>> -	        for (k = 0; k < cu_info->num_cu_per_sh;
>> -		  k += pcache_info[ct].num_cu_shared) {
>> -		  ret = fill_in_l1_pcache(pcache,
>> -					pcache_info,
>> -					cu_info,
>> -					mem_available,
>> -					cu_info->cu_bitmap[i % 4][j + i / 4],
>> -					ct,
>> -					cu_processor_id,
>> -					k);
>> -
>> -		  if (ret < 0)
>> -			break;
>> -
>> -		  if (!ret) {
>> -				pcache++;
>> -				(*num_of_entries)++;
>> -				mem_available -= sizeof(*pcache);
>> -				(*size_filled) += sizeof(*pcache);
>> -		  }
>> -
>> -		  /* Move to next CU block */
>> -		  num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
>> -					cu_info->num_cu_per_sh) ?
>> -					pcache_info[ct].num_cu_shared :
>> -					(cu_info->num_cu_per_sh - k);
>> -		  cu_processor_id += num_cu_shared;
>> -		}
>> -	      }
>> -	    }
>> -	  } else {
>> -			ret = fill_in_l2_l3_pcache(pcache,
>> -				pcache_info,
>> -				cu_info,
>> -				mem_available,
>> -				ct,
>> -				cu_processor_id);
>> -
>> -			if (ret < 0)
>> -				break;
>> -
>> -			if (!ret) {
>> -				pcache++;
>> -				(*num_of_entries)++;
>> -				mem_available -= sizeof(*pcache);
>> -				(*size_filled) += sizeof(*pcache);
>> -			}
>> -	  }
>> -	}
>> -
>> -	pr_debug("Added [%d] GPU cache entries\n", *num_of_entries);
>> -
>> -	return 0;
>> -}
>> -
>>   static bool kfd_ignore_crat(void)
>>   {
>>   	bool ret;
>> @@ -2203,8 +997,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>   	struct crat_subtype_computeunit *cu;
>>   	struct kfd_cu_info cu_info;
>>   	int avail_size = *size;
>> -	int num_of_cache_entries = 0;
>> -	int cache_mem_filled = 0;
>>   	uint32_t nid = 0;
>>   	int ret = 0;
>>   
>> @@ -2304,31 +1096,12 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>   	crat_table->length += sizeof(struct crat_subtype_memory);
>>   	crat_table->total_entries++;
>>   
>> -	/* TODO: Fill in cache information. This information is NOT readily
>> -	 * available in KGD
>> -	 */
>> -	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>> -		sub_type_hdr->length);
>> -	ret = kfd_fill_gpu_cache_info(kdev, cu->processor_id_low,
>> -				avail_size,
>> -				&cu_info,
>> -				(struct crat_subtype_cache *)sub_type_hdr,
>> -				&cache_mem_filled,
>> -				&num_of_cache_entries);
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	crat_table->length += cache_mem_filled;
>> -	crat_table->total_entries += num_of_cache_entries;
>> -	avail_size -= cache_mem_filled;
>> -
>>   	/* Fill in Subtype: IO_LINKS
>>   	 *  Only direct links are added here which is Link from GPU to
>>   	 *  its NUMA node. Indirect links are added by userspace.
>>   	 */
>>   	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>> -		cache_mem_filled);
>> +		sub_type_hdr->length);
>>   	ret = kfd_fill_gpu_direct_io_link_to_cpu(&avail_size, kdev,
>>   		(struct crat_subtype_iolink *)sub_type_hdr, proximity_domain);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index e0680d265a66..97e88c35be01 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -50,6 +50,747 @@ static struct kfd_system_properties sys_props;
>>   static DECLARE_RWSEM(topology_lock);
>>   static uint32_t topology_crat_proximity_domain;
>>   
>> +/* Static table to describe GPU Cache information */
>> +struct kfd_gpu_cache_info {
>> +	uint32_t	cache_size;
>> +	uint32_t	cache_level;
>> +	uint32_t	flags;
>> +	/* Indicates how many Compute Units share this cache
>> +	 * within a SA. Value = 1 indicates the cache is not shared
>> +	 */
>> +	uint32_t	num_cu_shared;
>> +};
>> +
>> +static struct kfd_gpu_cache_info kaveri_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache (in SQC module) per bank */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache (in SQC module) per bank */
>> +		.cache_size = 8,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +
>> +	/* TODO: Add L2 Cache information */
>> +};
>> +
>> +static struct kfd_gpu_cache_info carrizo_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache (in SQC module) per bank */
>> +		.cache_size = 8,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 4,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache (in SQC module) per bank. */
>> +		.cache_size = 4,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 4,
>> +	},
>> +
>> +	/* TODO: Add L2 Cache information */
>> +};
>> +
>> +#define hawaii_cache_info kaveri_cache_info
>> +#define tonga_cache_info carrizo_cache_info
>> +#define fiji_cache_info  carrizo_cache_info
>> +#define polaris10_cache_info carrizo_cache_info
>> +#define polaris11_cache_info carrizo_cache_info
>> +#define polaris12_cache_info carrizo_cache_info
>> +#define vegam_cache_info carrizo_cache_info
>> +
>> +/* NOTE: L1 cache information has been updated and L2/L3
>> + * cache information has been added for Vega10 and
>> + * newer ASICs. The unit for cache_size is KiB.
>> + * In future,  check & update cache details
>> + * for every new ASIC is required.
>> + */
>> +static struct kfd_gpu_cache_info vega10_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 4096,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 16,
>> +	},
>> +};
>> +static struct kfd_gpu_cache_info raven_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 1024,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 11,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info renoir_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 1024,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info vega12_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 2048,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 5,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info vega20_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 3,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 8192,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 16,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 8192,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 14,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info navi10_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 4096,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info vangogh_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 1024,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info navi14_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 12,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 2048,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 12,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 4096,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +	{
>> +		/* L3 Data Cache per GPU */
>> +		.cache_size = 128*1024,
>> +		.cache_level = 3,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 3072,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +	{
>> +		/* L3 Data Cache per GPU */
>> +		.cache_size = 96*1024,
>> +		.cache_level = 3,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 10,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 2048,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +	{
>> +		/* L3 Data Cache per GPU */
>> +		.cache_size = 32*1024,
>> +		.cache_level = 3,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +};
>> +
>> +static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 1024,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +	{
>> +		/* L3 Data Cache per GPU */
>> +		.cache_size = 16*1024,
>> +		.cache_level = 3,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 8,
>> +	},
>> +};
>> +static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>> +	{
>> +		/* TCP L1 Cache per CU */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 1,
>> +	},
>> +	{
>> +		/* Scalar L1 Instruction Cache per SQC */
>> +		.cache_size = 32,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_INST_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* Scalar L1 Data Cache per SQC */
>> +		.cache_size = 16,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 2,
>> +	},
>> +	{
>> +		/* GL1 Data Cache per SA */
>> +		.cache_size = 128,
>> +		.cache_level = 1,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 6,
>> +	},
>> +	{
>> +		/* L2 Data Cache per GPU (Total Tex Cache) */
>> +		.cache_size = 2048,
>> +		.cache_level = 2,
>> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +				CRAT_CACHE_FLAGS_DATA_CACHE |
>> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +		.num_cu_shared = 6,
>> +	},
>> +};
>> +
>>   struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
>>   						uint32_t proximity_domain)
>>   {
>> @@ -149,6 +890,7 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
>>   {
>>   	struct kfd_mem_properties *mem;
>>   	struct kfd_cache_properties *cache;
>> +	struct kfd_cache_properties_ext *cache_ext;
>>   	struct kfd_iolink_properties *iolink;
>>   	struct kfd_iolink_properties *p2plink;
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>> @@ -171,6 +913,13 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
>>   		kfree(cache);
>>   	}
>>   
>> +	while (dev->cache_props_ext.next != &dev->cache_props_ext) {
>> +		cache_ext = container_of(dev->cache_props_ext.next,
>> +				struct kfd_cache_properties_ext, list);
>> +		list_del(&cache_ext->list);
>> +		kfree(cache_ext);
>> +	}
>> +
>>   	while (dev->io_link_props.next != &dev->io_link_props) {
>>   		iolink = container_of(dev->io_link_props.next,
>>   				struct kfd_iolink_properties, list);
>> @@ -227,6 +976,7 @@ struct kfd_topology_device *kfd_create_topology_device(
>>   
>>   	INIT_LIST_HEAD(&dev->mem_props);
>>   	INIT_LIST_HEAD(&dev->cache_props);
>> +	INIT_LIST_HEAD(&dev->cache_props_ext);
>>   	INIT_LIST_HEAD(&dev->io_link_props);
>>   	INIT_LIST_HEAD(&dev->p2p_link_props);
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>> @@ -387,7 +1137,6 @@ static ssize_t kfd_cache_show(struct kobject *kobj, struct attribute *attr,
>>   
>>   	/* Making sure that the buffer is an empty string */
>>   	buffer[0] = 0;
>> -
>>   	cache = container_of(attr, struct kfd_cache_properties, attr);
>>   	if (cache->gpu && kfd_devcgroup_check_permission(cache->gpu))
>>   		return -EPERM;
>> @@ -423,6 +1172,50 @@ static struct kobj_type cache_type = {
>>   	.sysfs_ops = &cache_ops,
>>   };
>>   
>> +static ssize_t kfd_cache_ext_show(struct kobject *kobj, struct attribute *attr,
>> +		char *buffer)
>> +{
>> +	int offs = 0;
>> +	uint32_t i, j;
>> +	struct kfd_cache_properties_ext *cache;
>> +
>> +	/* Making sure that the buffer is an empty string */
>> +	buffer[0] = 0;
>> +	cache = container_of(attr, struct kfd_cache_properties_ext, attr);
>> +	if (cache->gpu && kfd_devcgroup_check_permission(cache->gpu))
>> +		return -EPERM;
>> +	sysfs_show_32bit_prop(buffer, offs, "processor_id_low",
>> +			cache->processor_id_low);
>> +	sysfs_show_32bit_prop(buffer, offs, "level", cache->cache_level);
>> +	sysfs_show_32bit_prop(buffer, offs, "size", cache->cache_size);
>> +	sysfs_show_32bit_prop(buffer, offs, "cache_line_size",
>> +			      cache->cacheline_size);
>> +	sysfs_show_32bit_prop(buffer, offs, "cache_lines_per_tag",
>> +			      cache->cachelines_per_tag);
>> +	sysfs_show_32bit_prop(buffer, offs, "association", cache->cache_assoc);
>> +	sysfs_show_32bit_prop(buffer, offs, "latency", cache->cache_latency);
>> +	sysfs_show_32bit_prop(buffer, offs, "type", cache->cache_type);
>> +	offs += snprintf(buffer+offs, PAGE_SIZE-offs, "sibling_map ");
>> +	for (i = 0; i < CRAT_SIBLINGMAP_SIZE; i++)
>> +		for (j = 0; j < sizeof(cache->sibling_map[0])*8; j++)
>> +			/* Check each bit */
>> +			offs += snprintf(buffer+offs, PAGE_SIZE-offs, "%d,",
>> +					 (cache->sibling_map[i] >> j) & 1);
>> +
>> +	/* Replace the last "," with end of line */
>> +	buffer[offs-1] = '\n';
>> +	return offs;
>> +}
>> +
>> +static const struct sysfs_ops cache_ext_ops = {
>> +	.show = kfd_cache_ext_show,
>> +};
>> +
>> +static struct kobj_type cache_ext_type = {
>> +	.release = kfd_topology_kobj_release,
>> +	.sysfs_ops = &cache_ext_ops,
>> +};
>> +
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>>   /****** Sysfs of Performance Counters ******/
>>   
>> @@ -610,6 +1403,7 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>>   	struct kfd_iolink_properties *p2plink;
>>   	struct kfd_iolink_properties *iolink;
>>   	struct kfd_cache_properties *cache;
>> +	struct kfd_cache_properties_ext *cache_ext;
>>   	struct kfd_mem_properties *mem;
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>>   	struct kfd_perf_properties *perf;
>> @@ -663,6 +1457,18 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>>   		dev->kobj_cache = NULL;
>>   	}
>>   
>> +	if (dev->kobj_cache_ext) {
>> +		list_for_each_entry(cache_ext, &dev->cache_props_ext, list)
>> +			if (cache_ext->kobj) {
>> +				kfd_remove_sysfs_file(cache_ext->kobj,
>> +							&cache_ext->attr);
>> +				cache_ext->kobj = NULL;
>> +			}
>> +		kobject_del(dev->kobj_cache_ext);
>> +		kobject_put(dev->kobj_cache_ext);
>> +		dev->kobj_cache_ext = NULL;
>> +	}
>> +
>>   	if (dev->kobj_mem) {
>>   		list_for_each_entry(mem, &dev->mem_props, list)
>>   			if (mem->kobj) {
>> @@ -707,6 +1513,7 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>>   	struct kfd_iolink_properties *p2plink;
>>   	struct kfd_iolink_properties *iolink;
>>   	struct kfd_cache_properties *cache;
>> +	struct kfd_cache_properties_ext *cache_ext;
>>   	struct kfd_mem_properties *mem;
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>>   	struct kfd_perf_properties *perf;
>> @@ -741,6 +1548,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>>   	if (!dev->kobj_cache)
>>   		return -ENOMEM;
>>   
>> +	dev->kobj_cache_ext = kobject_create_and_add("caches_ext", dev->kobj_node);
>> +	if (!dev->kobj_cache_ext)
>> +		return -ENOMEM;
>> +
>>   	dev->kobj_iolink = kobject_create_and_add("io_links", dev->kobj_node);
>>   	if (!dev->kobj_iolink)
>>   		return -ENOMEM;
>> @@ -830,6 +1641,28 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>>   		i++;
>>   	}
>>   
>> +	i = 0;
>> +	list_for_each_entry(cache_ext, &dev->cache_props_ext, list) {
>> +		cache_ext->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
>> +		if (!cache_ext->kobj)
>> +			return -ENOMEM;
>> +		ret = kobject_init_and_add(cache_ext->kobj, &cache_ext_type,
>> +				dev->kobj_cache_ext, "%d", i);
>> +		if (ret < 0) {
>> +			kobject_put(cache_ext->kobj);
>> +			return ret;
>> +		}
>> +
>> +		cache_ext->attr.name = "properties";
>> +		cache_ext->attr.mode = KFD_SYSFS_FILE_MODE;
>> +		sysfs_attr_init(&cache_ext->attr);
>> +		ret = sysfs_create_file(cache_ext->kobj, &cache_ext->attr);
>> +		if (ret < 0)
>> +			return ret;
>> +		i++;
>> +	}
>> +
>> +
>>   	i = 0;
>>   	list_for_each_entry(iolink, &dev->io_link_props, list) {
>>   		iolink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
>> @@ -1268,6 +2101,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>>   	struct kfd_topology_device *out_dev = NULL;
>>   	struct kfd_mem_properties *mem;
>>   	struct kfd_cache_properties *cache;
>> +	struct kfd_cache_properties_ext *cache_ext;
>>   	struct kfd_iolink_properties *iolink;
>>   	struct kfd_iolink_properties *p2plink;
>>   
>> @@ -1288,6 +2122,8 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>>   				mem->gpu = dev->gpu;
>>   			list_for_each_entry(cache, &dev->cache_props, list)
>>   				cache->gpu = dev->gpu;
>> +			list_for_each_entry(cache, &dev->cache_props_ext, list)
>> +				cache_ext->gpu = dev->gpu;
>>   			list_for_each_entry(iolink, &dev->io_link_props, list)
>>   				iolink->gpu = dev->gpu;
>>   			list_for_each_entry(p2plink, &dev->p2p_link_props, list)
>> @@ -1721,6 +2557,397 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>>   		dev->node_props.capability |= HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED;
>>   }
>>   
>> +/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
>> +static int fill_in_l1_pcache(struct kfd_cache_properties_ext **props_ext,
>> +				struct kfd_gpu_cache_info *pcache_info,
>> +				struct kfd_cu_info *cu_info,
>> +				int cu_bitmask,
>> +				int cache_type, unsigned int cu_processor_id,
>> +				int cu_block)
>> +{
>> +	unsigned int cu_sibling_map_mask;
>> +	int first_active_cu;
>> +	struct kfd_cache_properties_ext *pcache = NULL;
>> +
>> +	cu_sibling_map_mask = cu_bitmask;
>> +	cu_sibling_map_mask >>= cu_block;
>> +	cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>> +	first_active_cu = ffs(cu_sibling_map_mask);
>> +
>> +	/* CU could be inactive. In case of shared cache find the first active
>> +	 * CU. and incase of non-shared cache check if the CU is inactive. If
>> +	 * inactive active skip it
>> +	 */
>> +	if (first_active_cu) {
>> +		pcache = kfd_alloc_struct(pcache);
>> +		if (!pcache)
>> +			return -ENOMEM;
>> +
>> +		memset(pcache, 0, sizeof(struct kfd_cache_properties_ext));
>> +		pcache->processor_id_low = cu_processor_id + (first_active_cu - 1);
>> +		pcache->cache_level = pcache_info[cache_type].cache_level;
>> +		pcache->cache_size = pcache_info[cache_type].cache_size;
>> +
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_INST_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_INSTRUCTION;
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_CPU_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_CPU;
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_SIMD_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_HSACU;
>> +
>> +		/* Sibling map is w.r.t processor_id_low, so shift out
>> +		 * inactive CU
>> +		 */
>> +		cu_sibling_map_mask =
>> +			cu_sibling_map_mask >> (first_active_cu - 1);
>> +
>> +		pcache->sibling_map[0] = (uint8_t)(cu_sibling_map_mask & 0xFF);
>> +		pcache->sibling_map[1] =
>> +				(uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
>> +		pcache->sibling_map[2] =
>> +				(uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
>> +		pcache->sibling_map[3] =
>> +				(uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
>> +
>> +		*props_ext = pcache;
>> +
>> +		return 0;
>> +	}
>> +	return 1;
>> +}
>> +
>> +/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
>> +static int fill_in_l2_l3_pcache(struct kfd_cache_properties_ext **props_ext,
>> +				struct kfd_gpu_cache_info *pcache_info,
>> +				struct kfd_cu_info *cu_info,
>> +				int cache_type, unsigned int cu_processor_id)
>> +{
>> +	unsigned int cu_sibling_map_mask;
>> +	int first_active_cu;
>> +	int i, j, k;
>> +	struct kfd_cache_properties_ext *pcache = NULL;
>> +
>> +	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
>> +	cu_sibling_map_mask &=
>> +		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>> +	first_active_cu = ffs(cu_sibling_map_mask);
>> +
>> +	/* CU could be inactive. In case of shared cache find the first active
>> +	 * CU. and incase of non-shared cache check if the CU is inactive. If
>> +	 * inactive active skip it
>> +	 */
>> +	if (first_active_cu) {
>> +		pcache = kfd_alloc_struct(pcache);
>> +		if (!pcache)
>> +			return -ENOMEM;
>> +
>> +		memset(pcache, 0, sizeof(struct kfd_cache_properties_ext));
>> +		pcache->processor_id_low = cu_processor_id
>> +					+ (first_active_cu - 1);
>> +		pcache->cache_level = pcache_info[cache_type].cache_level;
>> +		pcache->cache_size = pcache_info[cache_type].cache_size;
>> +
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_INST_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_INSTRUCTION;
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_CPU_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_CPU;
>> +		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_SIMD_CACHE)
>> +			pcache->cache_type |= HSA_CACHE_TYPE_HSACU;
>> +
>> +		/* Sibling map is w.r.t processor_id_low, so shift out
>> +		 * inactive CU
>> +		 */
>> +		cu_sibling_map_mask = cu_sibling_map_mask >> (first_active_cu - 1);
>> +		k = 0;
>> +
>> +		for (i = 0; i < cu_info->num_shader_engines; i++) {
>> +			for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
>> +				pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
>> +				pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
>> +				pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
>> +				pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
>> +				k += 4;
>> +
>> +				cu_sibling_map_mask = cu_info->cu_bitmap[i % 4][j + i / 4];
>> +				cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>> +			}
>> +		}
>> +		*props_ext = pcache;
>> +		return 0;
>> +	}
>> +	return 1;
>> +}
>> +
>> +#define KFD_MAX_CACHE_TYPES 6
>> +
>> +static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>> +						   struct kfd_gpu_cache_info *pcache_info)
>> +{
>> +	struct amdgpu_device *adev = kdev->adev;
>> +	int i = 0;
>> +
>> +	/* TCP L1 Cache per CU */
>> +	if (adev->gfx.config.gc_tcp_l1_size) {
>> +		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_l1_size;
>> +		pcache_info[i].cache_level = 1;
>> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +					CRAT_CACHE_FLAGS_DATA_CACHE |
>> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> +		pcache_info[0].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
>> +		i++;
>> +	}
>> +	/* Scalar L1 Instruction Cache per SQC */
>> +	if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
>> +		pcache_info[i].cache_size =
>> +			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
>> +		pcache_info[i].cache_level = 1;
>> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +					CRAT_CACHE_FLAGS_INST_CACHE |
>> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> +		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
>> +		i++;
>> +	}
>> +	/* Scalar L1 Data Cache per SQC */
>> +	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
>> +		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
>> +		pcache_info[i].cache_level = 1;
>> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +					CRAT_CACHE_FLAGS_DATA_CACHE |
>> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> +		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
>> +		i++;
>> +	}
>> +	/* GL1 Data Cache per SA */
>> +	if (adev->gfx.config.gc_gl1c_per_sa &&
>> +		adev->gfx.config.gc_gl1c_size_per_instance) {
>> +		pcache_info[i].cache_size = adev->gfx.config.gc_gl1c_per_sa *
>> +			adev->gfx.config.gc_gl1c_size_per_instance;
>> +		pcache_info[i].cache_level = 1;
>> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +					CRAT_CACHE_FLAGS_DATA_CACHE |
>> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> +		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>> +		i++;
>> +	}
>> +	/* L2 Data Cache per GPU (Total Tex Cache) */
>> +	if (adev->gfx.config.gc_gl2c_per_gpu) {
>> +		pcache_info[i].cache_size = adev->gfx.config.gc_gl2c_per_gpu;
>> +		pcache_info[i].cache_level = 2;
>> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +					CRAT_CACHE_FLAGS_DATA_CACHE |
>> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> +		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>> +		i++;
>> +	}
>> +	/* L3 Data Cache per GPU */
>> +	if (adev->gmc.mall_size) {
>> +		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;
>> +		pcache_info[i].cache_level = 3;
>> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +					CRAT_CACHE_FLAGS_DATA_CACHE |
>> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
>> +		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
>> +		i++;
>> +	}
>> +	return i;
>> +}
>> +/* kfd_fill_cache_non_crat_info - Fill GPU cache info using kfd_gpu_cache_info
>> + * tables
>> + */
>> +static int kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_dev *kdev)
>> +{
>> +	struct kfd_gpu_cache_info *pcache_info = NULL;
>> +	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
>> +	int num_of_cache_types = 0;
>> +	int i, j, k;
>> +	int ct = 0;
>> +	unsigned int cu_processor_id;
>> +	int ret;
>> +	unsigned int num_cu_shared;
>> +	struct kfd_cu_info cu_info;
>> +	struct kfd_cu_info *pcu_info;
>> +	int gpu_processor_id;
>> +	struct kfd_cache_properties_ext *props_ext;
>> +	int num_of_entries = 0;
>> +
>> +	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
>> +	pcu_info = &cu_info;
>> +
>> +	gpu_processor_id = kdev->processor_id_low;
>> +
>> +	switch (kdev->adev->asic_type) {
>> +	case CHIP_KAVERI:
>> +		pcache_info = kaveri_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(kaveri_cache_info);
>> +		break;
>> +	case CHIP_HAWAII:
>> +		pcache_info = hawaii_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(hawaii_cache_info);
>> +		break;
>> +	case CHIP_CARRIZO:
>> +		pcache_info = carrizo_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(carrizo_cache_info);
>> +		break;
>> +	case CHIP_TONGA:
>> +		pcache_info = tonga_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(tonga_cache_info);
>> +		break;
>> +	case CHIP_FIJI:
>> +		pcache_info = fiji_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(fiji_cache_info);
>> +		break;
>> +	case CHIP_POLARIS10:
>> +		pcache_info = polaris10_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(polaris10_cache_info);
>> +		break;
>> +	case CHIP_POLARIS11:
>> +		pcache_info = polaris11_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(polaris11_cache_info);
>> +		break;
>> +	case CHIP_POLARIS12:
>> +		pcache_info = polaris12_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(polaris12_cache_info);
>> +		break;
>> +	case CHIP_VEGAM:
>> +		pcache_info = vegam_cache_info;
>> +		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
>> +		break;
>> +	default:
>> +		switch (KFD_GC_VERSION(kdev)) {
>> +		case IP_VERSION(9, 0, 1):
>> +			pcache_info = vega10_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
>> +			break;
>> +		case IP_VERSION(9, 2, 1):
>> +			pcache_info = vega12_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
>> +			break;
>> +		case IP_VERSION(9, 4, 0):
>> +		case IP_VERSION(9, 4, 1):
>> +			pcache_info = vega20_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
>> +			break;
>> +		case IP_VERSION(9, 4, 2):
>> +			pcache_info = aldebaran_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
>> +			break;
>> +		case IP_VERSION(9, 1, 0):
>> +		case IP_VERSION(9, 2, 2):
>> +			pcache_info = raven_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(raven_cache_info);
>> +			break;
>> +		case IP_VERSION(9, 3, 0):
>> +			pcache_info = renoir_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 1, 10):
>> +		case IP_VERSION(10, 1, 2):
>> +		case IP_VERSION(10, 1, 3):
>> +		case IP_VERSION(10, 1, 4):
>> +			pcache_info = navi10_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 1, 1):
>> +			pcache_info = navi14_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 3, 0):
>> +			pcache_info = sienna_cichlid_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 3, 2):
>> +			pcache_info = navy_flounder_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 3, 4):
>> +			pcache_info = dimgrey_cavefish_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 3, 1):
>> +			pcache_info = vangogh_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 3, 5):
>> +			pcache_info = beige_goby_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
>> +			break;
>> +		case IP_VERSION(10, 3, 3):
>> +		case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
>> +		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
>> +			pcache_info = yellow_carp_cache_info;
>> +			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
>> +			break;
>> +		case IP_VERSION(11, 0, 0):
>> +		case IP_VERSION(11, 0, 1):
>> +		case IP_VERSION(11, 0, 2):
>> +		case IP_VERSION(11, 0, 3):
>> +			pcache_info = cache_info;
>> +			num_of_cache_types =
>> +				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	/* For each type of cache listed in the kfd_gpu_cache_info table,
>> +	 * go through all available Compute Units.
>> +	 * The [i,j,k] loop will
>> +	 *		if kfd_gpu_cache_info.num_cu_shared = 1
>> +	 *			will parse through all available CU
>> +	 *		If (kfd_gpu_cache_info.num_cu_shared != 1)
>> +	 *			then it will consider only one CU from
>> +	 *			the shared unit
>> +	 */
>> +	for (ct = 0; ct < num_of_cache_types; ct++) {
>> +		cu_processor_id = gpu_processor_id;
>> +		if (pcache_info[ct].cache_level == 1) {
>> +			for (i = 0; i < pcu_info->num_shader_engines; i++) {
>> +				for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
>> +					for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
>> +
>> +						ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
>> +										pcu_info->cu_bitmap[i % 4][j + i / 4], ct,
>> +										cu_processor_id, k);
>> +
>> +						if (ret < 0)
>> +							break;
>> +
>> +						if (!ret) {
>> +							num_of_entries++;
>> +							list_add_tail(&props_ext->list, &dev->cache_props_ext);
>> +						}
>> +
>> +						/* Move to next CU block */
>> +						num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
>> +							pcu_info->num_cu_per_sh) ?
>> +							pcache_info[ct].num_cu_shared :
>> +							(pcu_info->num_cu_per_sh - k);
>> +						cu_processor_id += num_cu_shared;
>> +					}
>> +				}
>> +			}
>> +		} else {
>> +			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
>> +								pcu_info, ct, cu_processor_id);
>> +
>> +			if (ret < 0)
>> +				break;
>> +
>> +			if (!ret) {
>> +				num_of_entries++;
>> +				list_add_tail(&props_ext->list, &dev->cache_props_ext);
>> +			}
>> +		}
>> +	}
>> +	pr_debug("Added [%d] GPU cache entries\n", num_of_entries);
>> +	return 0;
>> +}
>> +
>>   int kfd_topology_add_device(struct kfd_dev *gpu)
>>   {
>>   	uint32_t gpu_id;
>> @@ -1759,6 +2986,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   			topology_crat_proximity_domain--;
>>   			return res;
>>   		}
>> +
>>   		res = kfd_parse_crat_table(crat_image,
>>   					   &temp_topology_device_list,
>>   					   proximity_domain);
>> @@ -1771,23 +2999,27 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   
>>   		kfd_topology_update_device_list(&temp_topology_device_list,
>>   			&topology_device_list);
>> +		up_write(&topology_lock);
>> +
>> +		dev = kfd_assign_gpu(gpu);
>> +		if (WARN_ON(!dev)) {
>> +			res = -ENODEV;
>> +			goto err;
>> +		}
>> +
>> +		down_write(&topology_lock);
>> +		kfd_fill_cache_non_crat_info(dev, gpu);
>>   
>>   		/* Update the SYSFS tree, since we added another topology
>>   		 * device
>>   		 */
>>   		res = kfd_topology_update_sysfs();
>>   		up_write(&topology_lock);
>> -
>>   		if (!res)
>>   			sys_props.generation_count++;
>>   		else
>>   			pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
>>   						gpu_id, res);
>> -		dev = kfd_assign_gpu(gpu);
>> -		if (WARN_ON(!dev)) {
>> -			res = -ENODEV;
>> -			goto err;
>> -		}
>>   	}
>>   
>>   	dev->gpu_id = gpu_id;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> index dc4e239c8f8f..fc35fe9fa914 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> @@ -103,6 +103,25 @@ struct kfd_cache_properties {
>>   	struct attribute	attr;
>>   };
>>   
>> +#define VCRAT_SIBLINGMAP_SIZE 64
>> +
>> +/* for GPUs with more CUs */
>> +struct kfd_cache_properties_ext {
>> +	struct list_head	list;
>> +	uint32_t		processor_id_low;
>> +	uint32_t		cache_level;
>> +	uint32_t		cache_size;
>> +	uint32_t		cacheline_size;
>> +	uint32_t		cachelines_per_tag;
>> +	uint32_t		cache_assoc;
>> +	uint32_t		cache_latency;
>> +	uint32_t		cache_type;
>> +	uint8_t			sibling_map[VCRAT_SIBLINGMAP_SIZE];
>> +	struct kfd_dev		*gpu;
>> +	struct kobject		*kobj;
>> +	struct attribute	attr;
>> +};
>> +
>>   struct kfd_iolink_properties {
>>   	struct list_head	list;
>>   	uint32_t		iolink_type;
>> @@ -139,6 +158,7 @@ struct kfd_topology_device {
>>   	struct list_head		mem_props;
>>   	uint32_t			cache_count;
>>   	struct list_head		cache_props;
>> +	struct list_head		cache_props_ext;
>>   	struct list_head		io_link_props;
>>   	struct list_head		p2p_link_props;
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>> @@ -148,6 +168,7 @@ struct kfd_topology_device {
>>   	struct kobject			*kobj_node;
>>   	struct kobject			*kobj_mem;
>>   	struct kobject			*kobj_cache;
>> +	struct kobject			*kobj_cache_ext;
>>   	struct kobject			*kobj_iolink;
>>   	struct kobject			*kobj_p2plink;
>>   #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
