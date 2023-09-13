Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F410AEE3F3F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 00:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8036E10E0CB;
	Wed, 13 Sep 2023 00:49:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFDF10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 00:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlrj3PCNRJsHuIA9Rp6KnpzqSCG3V+xtSD+N13VUZ7bEMgrjPASGPxSyCA8ij2niffaugrLn7qBFtaUA0KADLIPpmSTGN6HvpaWCaZwgHi58vRfeWw6XwaaeHxPk1X6mcW59gcVIXxGI6A902nBrDbKA4pVDBaOOGPYS5nc8gfAjLAWwH/U5kzknudK8Ho3XB6jeuoaTgUEKtYnOnhIIxaZtIxWzTaq94cDkocrujeijc+DlGG4YgqqqvLCQS0L+4AqLn3OPvVGkI6iS2nPC5YOC+GA/6R+9q1R0A8Nn9tnSM0XahGrf8Wp3bjP1lk/vBqPMNYWLMMGQqBPyyIJQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QWMDCNmuuk2vGKG0nxtRqc3hhetacO4s4Oh8bjGEHk=;
 b=UnMrwoDuIec7rQPEY0CVU3Ls2bqe/XqUFmQbp0M0eMRazg7m1xTiXtohwW2LpXb6b0K75bc5fwzQQD8mPAV7PHjXpVQiP8t+IbZeRh5vmtzluBP1CtG7bgpYpIrA7tEz91xHEXf9k4xBX0RASX/BnMSS+TuEQ27tAG+T4Yr67c2QysdyXZhKTdadn23QYRXfMIONRVWBQ+GJa54RZtfSUG5kqIVJ15O7zysDp9sqjoYuHE54cJqe4BVXH4Dl91MliOgLVJdH+dcpf0vu24nwl6XY+Qib8/7LXvmlQdgKrpZ8+dY7fI5aqdooQ8AD+wmWZDy+sZOb5JP7i1zpAwxDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QWMDCNmuuk2vGKG0nxtRqc3hhetacO4s4Oh8bjGEHk=;
 b=NZ7QyUDitnYAy0C8Q1rGMxHHaADO0WnHLY1j03/cyUxSfb8vXbaN+0hfuUSkXyixKpjuxTOO7maGqGfBmtGcFfk9GMcrXdS2H+QrMwdi9etxZlw2ARRSAlTv6G9RLH7oWP2jY2ukXKQsuB4U84XmLpcwcocdH0iWVxK8wV1NKGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 00:49:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:49:16 +0000
Content-Type: multipart/alternative;
 boundary="------------KtXos1DFO1jRaeVZS3VSBNks"
Message-ID: <c04dd9a3-ab81-5d5d-fafa-93877073017e@amd.com>
Date: Tue, 12 Sep 2023 20:48:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
 <ZP/SdUd9am/f2WJw@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ZP/SdUd9am/f2WJw@lang-desktop>
X-ClientProxiedBy: YQBPR0101CA0303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: eae23bcc-4962-497a-4b86-08dbb3f34163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQmZNP5WvltW7CRBORrul5oXjSIhCDStsu9cqUlDveyvZObs5NYY/hWZu9+jS6k5bpXI9gZbySzi31Q312g1DqtRVGB/lGafEfxeWA3x3rKN4L4Lkl1V/EeJnJY4JJSgRB6baaL7l3XbTvQzqKvWeAGRE76nOuCQNnL1NaiYCHTxGXDqMC946VfQya/4vaYm4wGPb3cqkk09EiV1SzpEz5cYZ3BzejGK7QZaSnkPn8GtmEJY9DgPAbOfnEEtYD0VWNNl6ipPsfh50Cfi0D6UgsuxbeRjdPIbPr/mLA7oDMa+Zo/AX/XXDHyUbgvVMWl4xxUZvDcDjlnF8KWXIFk8wxPnN3KCl/HML/omqeWD8Iu0joaw4yrO21V2fkl7t6S2jKA2l7p5T0bzAB5txuhmfrQJH1E1YbkPYZ/PE8htWWoyR9NOU24hA3VLB9HILcvD9IPXh+ihJyXAioJUI63vzH1rFA0H1ABmkN1uZ7BAagqOegsbs5QWoIaIPor8clSUiFlHCkGken8l9Cbz/JmngTrqkUF9g4fjgVvezlQvf5B/iT74VH0qg4phnrvYIOPOXddik1QWtTQnKsUJ4+Xc1df6zjVU5M/4AzDbYlpSDPvCIRgxBS2Y+XMhiPv5zl8IDRzpb9I2URcYIMoJMV5/cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6486002)(53546011)(6506007)(6512007)(26005)(6666004)(36756003)(2616005)(33964004)(478600001)(2906002)(316002)(66946007)(31686004)(6636002)(66476007)(66556008)(38100700002)(110136005)(41300700001)(8936002)(5660300002)(8676002)(4326008)(83380400001)(44832011)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdJNnZTNjFHanZHdjRIVndmc3VDSjI0RzJLUDlkZVRkV21QOEZiYWJ3amxN?=
 =?utf-8?B?SHovQnZFcHFHVjJRSThpeG83L2tUcS9CWGc1VVVUeHM3ZXpCUUpuUzRsSFdv?=
 =?utf-8?B?cGR3ek1rRzVJUEhqTTdsZm84VVBqVjhwZUhZdWdtbTJhc1Z6M0J5clJmdnJT?=
 =?utf-8?B?MVEvV2RqbVFmMUtWSHkvZDhFaWo5R0pMYzBzeDZNV2dENTV0QmcrMldWODN1?=
 =?utf-8?B?bmRlQ3VneUl6YmduM0hqekFpUmlFT3JCbFRCNTdibXBXeU5rYjlFVXkySzZs?=
 =?utf-8?B?NURhSVFwdzBwQ0gyakl0YU5TM2tSOWFRNnhsN1JMa1NlTnJJUlBVY1FkY3ZU?=
 =?utf-8?B?VHpSSXFtc2RWcEsyOVJhSzNzSk5QcjBKNExyOG0wL1lHY3I2M3lsSkxEb3FP?=
 =?utf-8?B?M0RMSzR1MzNiS0hkL2pWQm05dGptTG56WitHUWJxZStJaTM1UzZWdWJCVEJ0?=
 =?utf-8?B?TU1tR05DT3FjRHZqRDF5RjlRTGIzMGFKK3pYZjR0VDRNN3BKbTB3RFVLWmc3?=
 =?utf-8?B?RXFUaUFYYWVPUlVMS0NIMmdyV2ErYlRTeThtMUtFamhxZDZSUzdOVFQxaXJH?=
 =?utf-8?B?My9NWFpNOVc3Nno2dFZmZndIdWJUVGJ2RUM1b1l5TWJqTnYvUm1nK2t5U0J3?=
 =?utf-8?B?M1dpY1hVU2ZLL0JmV3h3T2l6czEyQ0UxRDAxZzhMdVNnUHh2NnVmUm0vK3B2?=
 =?utf-8?B?c3dHVWdzTlVrRTJxbjRSWlJoWFlYMENHaGE0ZGlKNy9IS254Qk0vME9UUnhL?=
 =?utf-8?B?QlQ5dmFldjE5T2tRU2hFblNhWUtUVFJLN3N1dVNLb0EwUnZWK1Y1Z2VoL0c1?=
 =?utf-8?B?TnJjdzFPclZ2czVNV2J1bXFYQjVha2luZTdBL0JEY2ZwbnlrYjlkT2MxVm1t?=
 =?utf-8?B?MnhNdTZSTHJOL2JZZlRodzlNNis4SXhJMjMyclRzWlR5Nk5oMUxsb1I5K2lq?=
 =?utf-8?B?L0NlVzBqSHpFTTgzU1J4bjNsbVRnb29QeUVHQzAzNDh1TE1Qbll1YjE2YmZB?=
 =?utf-8?B?aUhhMjRCcGVEWU5UOEJxWHNDcWllR2hGRjI3VzdzdU5pQjJhSldDTithbEJB?=
 =?utf-8?B?YVRlUlhlZXNIVm1sK1dkNjVhUzUwZDMrN09TR3FoRHlyTUlTTFhWUll6aHZT?=
 =?utf-8?B?L1VKcGladFQ4N1RaTldUVDJNV0NvWmxKY1NaVDFGTHduWHZPRmQzUnpod1Yr?=
 =?utf-8?B?T05heTIyWmVNU1llZjhuRkx4NjV6WGRhdHpRbTBCTEJNRjc0ODZQOFVmVTJq?=
 =?utf-8?B?K09QZVo5TmdQRW5VeHVSTTVWV3kwWjZtQ2VYY2JId3lIYk1LZHFUMHNTQTZh?=
 =?utf-8?B?Tnk0RDhFeHJsRzdmSEg1eDh2WU9JR0hWZng4bGdPTkR1NGUrcEpQVTJCdnNU?=
 =?utf-8?B?VGJmWlgrbTNjVW9uUmcrVU9pblpZMmxmVUg1ZXlyRmxPUkFBWnM2K0RKSEtq?=
 =?utf-8?B?N2NkbVdWK3duK2d6cmhOeXJJR1AxQS85Q29jZWw4WGtLOGt2djlobDBjb09T?=
 =?utf-8?B?VHhzZ2xjbHF0azlTdnF4dVdJbG93cEsyS2UwcUM0Mk1LSUlLdVdGS0hZYXEy?=
 =?utf-8?B?OHp3OGV2S0ZVODBqYlI0TXJCVEgyR0JvSnpNMWlpcmY5Y2hIOGloVWtiR3h0?=
 =?utf-8?B?dzNMWTlrWEVpRmdhM0lrbWpKMmwwWnFKdjBvZDJUR2oweFpvaVowaVV1Sk9J?=
 =?utf-8?B?RlNnc2VZSFYvMXI2WmNoTWUvT3hWWkVZM01HY2VPVVlQbjVTOVVyN3loVjBI?=
 =?utf-8?B?MWhjNmViQTU3cnFPcURuNkRRKytJVHJUMW5YMlpzQmNTWkcrS2JRWmxuMnkw?=
 =?utf-8?B?OHFBOUk1NGZ6K09CZ2RjODVXdVZNN1p0YVpBOTlIYXNwUVVMK2Qra1FXWUZB?=
 =?utf-8?B?UWMydW5jTEZZOXYveEY4dmlwbUZSQk9IamFZU1VxZ3dQRGpqenlzMmI1Mlpi?=
 =?utf-8?B?NWgrZ1BTWjdybzY0Rm5lYlFiN0JscDRoQlhoQTFRQ0xyaXJURXAxWHdMeTB3?=
 =?utf-8?B?RWhjQ1BRSExJL2tHSkxUYkNqNUUvS0hMc2xkbjgrdVBRZnh0VUk0eE1XLzVa?=
 =?utf-8?B?Z2FGRi9vVDRzMlhxaFB5c2VFbzZpdkhiWHFSRVIvRy93U3FUV1RrdFBWelRB?=
 =?utf-8?Q?iPkKYOm0s/Zsyta2o5qScUIa9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae23bcc-4962-497a-4b86-08dbb3f34163
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:49:16.3618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvrzkflSSzv/fN+TH5OIvmKCujqUTnPL51i4boRmRRvagk4Xu4xMLuiSJZzRbBW7P8gcMrW672RNCPFX3HtjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------KtXos1DFO1jRaeVZS3VSBNks
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-09-11 22:52, Lang Yu wrote:
> On 09/11/ , Harish Kasiviswanathan wrote:
>> Heavy-weight TLB flush is required after unmap on all GPUs for
>> correctness and security.
>>
>> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index b315311dfe2a..b9950074aee0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>>   
>>   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>   {
>> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
>> -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>> +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
>>   	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
>>   	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>>   }
> 1, If TLB_FLUSH_HEAVYWEIGHT is required after unmap on all GPUs
> as described in commmit message, why we have this whitelist
> instead of a blacklist?

That was a bug that this patch is fixing. There were specific GPUs and 
firmware versions where the TLB flush after unmap was causing 
intermittent problems in specific tests. This should have always been a 
blacklist.


>
> 2, kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is also called
> in svm_range_unmap_from_gpus(). Why not add this whitelist there?

There was a patch that used kfd_flush_tlb_after_unmap in the SVM code. 
But you reverted that patch, probably because it caused more problems 
than it solved. SVM really must flush TLBs the way it does because it is 
so tightly integrated with Linux's virtual memory management and because 
with XNACK, memory can be unmapped while GPU work is in progress without 
preemting queues (implicitly flushing TLBs and caches):

commit 515d7cebc2e2d2b4f0a276d26f3b790a83cdfe06
Author: Lang Yu<Lang.Yu@amd.com>
Date:   Wed Apr 20 10:24:31 2022 +0800

     Revert "drm/amdkfd: only allow heavy-weight TLB flush on some ASICs for SVM too"
     
     This reverts commit 36bf93216ecbe399c40c5e0486f0f0e3a4afa69e.
     
     It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
     at the moment.
     
     ./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest
     
     Signed-off-by: Lang Yu<Lang.Yu@amd.com>
     Reviewed-by: Philip Yang<Philip.Yang@amd.com>
     Signed-off-by: Alex Deucher<alexander.deucher@amd.com>

Regards,
   Felix


>
> Regards,
> Lang
>
>> -- 
>> 2.34.1
>>
--------------KtXos1DFO1jRaeVZS3VSBNks
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-09-11 22:52, Lang Yu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZP%2FSdUd9am%2Ff2WJw@lang-desktop">
      <pre class="moz-quote-pre" wrap="">On 09/11/ , Harish Kasiviswanathan wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Heavy-weight TLB flush is required after unmap on all GPUs for
correctness and security.

Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b315311dfe2a..b9950074aee0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
-	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	return KFD_GC_VERSION(dev) &gt; IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &amp;&amp; dev-&gt;sdma_fw_version &gt;= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
1, If TLB_FLUSH_HEAVYWEIGHT is required after unmap on all GPUs
as described in commmit message, why we have this whitelist
instead of a blacklist?</pre>
    </blockquote>
    <p>That was a bug that this patch is fixing. There were specific
      GPUs and firmware versions where the TLB flush after unmap was
      causing intermittent problems in specific tests. This should have
      always been a blacklist.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ZP%2FSdUd9am%2Ff2WJw@lang-desktop">
      <pre class="moz-quote-pre" wrap="">

2, kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is also called
in svm_range_unmap_from_gpus(). Why not add this whitelist there?</pre>
    </blockquote>
    <p>There was a patch that used kfd_flush_tlb_after_unmap in the SVM
      code. But you reverted that patch, probably because it caused more
      problems than it solved. SVM really must flush TLBs the way it
      does because it is so tightly integrated with Linux's virtual
      memory management and because with XNACK, memory can be unmapped
      while GPU work is in progress without preemting queues (implicitly
      flushing TLBs and caches):</p>
    <pre>commit 515d7cebc2e2d2b4f0a276d26f3b790a83cdfe06
Author: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
Date:   Wed Apr 20 10:24:31 2022 +0800

    Revert &quot;drm/amdkfd: only allow heavy-weight TLB flush on some ASICs for SVM too&quot;
    
    This reverts commit 36bf93216ecbe399c40c5e0486f0f0e3a4afa69e.
    
    It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
    at the moment.
    
    ./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest
    
    Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
    Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
    Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
</pre>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ZP%2FSdUd9am%2Ff2WJw@lang-desktop">
      <pre class="moz-quote-pre" wrap="">

Regards,
Lang

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-- 
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------KtXos1DFO1jRaeVZS3VSBNks--
