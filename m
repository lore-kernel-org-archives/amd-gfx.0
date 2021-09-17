Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB2DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6456761164
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6456761164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4BA6EE90;
	Fri, 17 Sep 2021 19:59:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BAD56EE90
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe3dWwhQn7Q6UJqIuU9l/gvxuF7tXlBQ/kWeCzgPAdJnXxDXtjO3hnVFdmY4Y38e+cz06xMnGr+8ZG0eMKUCSOD2pQVUNyu8EwlKV6y1GtOGX60WfVBXIuXYbfrSWUJBD3S8fhFRUzGjdWCHBSPcaTq4yl6b88l3gn+8Nd/vj304xQpxk37kjyfXJBuEm506N5qc3Lv1c2Die+crcQxFecY7K56x2EJF3IkGMeCUEK7oKFlDeWWN0W5gVxOzBVf5u9KPyWNZtaKWxWS1k41n71cLu0h9imCIv2kvyb65tt+M/1TV48YEoYM9UMkZXZ0xWd8c8Qs4oclSQWEM2bhjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vzqiIYAS6aLqIfHWOvzWz6KZnWjWRecbfzsFKaCXJOg=;
 b=Yvi0giHXoBhFIDurCilfKHQ884W5jPj4GN+XDuO/i0cKkikenlTPdmVYkodo+W6os+YbBY6fpxgffTLW+fD71oaSEwtI/j1RT3s+QRepAjLjtHEazNjgqTqbSFzQ/DLMSq5CXfqbktvcvs1lonCE9NU84IMnhY0+LP+W7C/YfbzD7jp8CVf5xefHIqfGZdcAYu5tYnwk59XKrFBZvBctd1MLrti4Gt+jpigUdjtWIW9xN/9VBQ9N5wXbu+NX44uQAxoJsMBWrDm6/F7u0iSQ0pL6G+iZDCjlUdNAT+rPWImXton2OFhZibBcck0AuI1RMC3PaF3KIJ3z/tnegCXWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzqiIYAS6aLqIfHWOvzWz6KZnWjWRecbfzsFKaCXJOg=;
 b=CK+G752xcBodY65CsT6oHZR4teZwOCCZB3UHiwE/iPrlnIK+JUsf+bMuUsSj2zi+Uv5+WTHJrDWdWpJlHadPvzz/zFk/VhH3QQnuxQDF9YnhfQa7yZFsr4uMuY5dN2i45Rm4G+wttE0hO3bQaYgwXQHSb9GB9VJTl25tpVBRjzE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:59:25 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 19:59:25 +0000
Subject: Re: [PATCH v3] drm/amdkfd: fix dma mapping leaking warning
To: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20210917180436.13923-1-Philip.Yang@amd.com>
 <4b03b58c-bc8a-19cf-94db-dd9f4b27c109@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <8f032e85-61b0-ae03-a515-f5a1a1428da4@amd.com>
Date: Fri, 17 Sep 2021 15:59:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4b03b58c-bc8a-19cf-94db-dd9f4b27c109@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::43) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:59:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9b68ac-2ecf-4d9d-41b0-08d97a15a681
X-MS-TrafficTypeDiagnostic: BN9PR12MB5081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50813144162F30355554736892DD9@BN9PR12MB5081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhir3lr5YqcCkCgNDB15mJX5M4bse/DGnWX3+tEJKBzitOBDceqxFe7zJ8g9WVdkCkO1inN9No+2IPswB5lXnsyZMoAy9wRtoh7NJWrFPDGeNHdeh1Wr1j1aldoVusL+8rMt8hiw6X8X+0mbcO955Tm30hySiOnNNEUAConoK0vyzIENa0zynYPj8s9NoInFSC7QnLGdO4qK6utW7U6iWu0bd7e47A1iDC+HZ3J2oq/WizLbh5IcrIEeRlULeEIDMdJ1dlVMJ9ikQOvxkyNsCES3Zq0YB+jH0P7K/ju8K/pdoEmVI0RCIih4pqfGlqtKTPz8oK5rsNcCvDIueRie/GyII+rKxi3XTiUjVi/zo9Tl4xTdbLM2w4RaODu0+Z86v+Xi5xsXIcRspA938GC7iZUpGPuJ2Z6hSLUT69YgsPytFurd8t6fNLTQG6aAtbUzZbJ0Fphuds56CCW2m52jkh7t5MamqdlE2cE2OoLyUnewIVhrrBJxfYW7et2znQjQbfNJqsr+6pBcAkYh5xqY/SXQl6voToKP8FWXaqHUxKBzvnXSJqccxFGwaJdFVXQgC5BQ58d6VE8IZzWmgAJfZJBlNpt37T45xNwFZnYxVNWlBH2JI/LTFbH/Mca4ou+ddMS0d7xXFfDBvsZYChjBb3usIm+IQNtlcUxtegf8N63Euf/oG+ppEhd9KH7F+0PeiSWuqs18B0hOPMPtCCKQA0UdBqgyzhxQ6UIFyKX8lGVaMS0i2BGaV3al+/XqO/h7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(6862004)(186003)(956004)(2616005)(4326008)(2906002)(44832011)(37006003)(36756003)(54906003)(66556008)(66946007)(316002)(66476007)(16576012)(83380400001)(6486002)(31686004)(8936002)(8676002)(38100700002)(53546011)(86362001)(5660300002)(31696002)(6636002)(36916002)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZkWnNIRkVoWThWTnp4WFRrUFNLSXRsVVkvNTNOQldXVlRxekRLWDVZL3JG?=
 =?utf-8?B?aEt5NTN2LzF2UDFJRDdBWk1FdG0wZjlLeVdYUkFVQUVjM1VlN0xLTXRUY3J2?=
 =?utf-8?B?VVI0WlF1Ymh4cFMyZDR4U1RKUWc2cHFGbkJHdThOL2ZzU0NQbFdLWmxKRlpu?=
 =?utf-8?B?V1Z0Uy80WDQvc2N6OU5yNzcxREx6RW0vaXAvWG9YeWFrRzFOa2lvTlc5RWVJ?=
 =?utf-8?B?cUlKcEMyYjNZYVBreVV1Q1dGenFTbHg4ZUJ4ZEI1SzZoK3crWTV0dWpMUXVW?=
 =?utf-8?B?dFgvWEhHSWRlUENpaGVvZTRndXkrOFJhem8xZU9scDlEOHp5NnYvelhURUJG?=
 =?utf-8?B?Yzl4NDVsR2x2VUcxaHVEb1pVUUp0dkwyU2J1ME00ZzVMakV4eHk3Nm55MUVm?=
 =?utf-8?B?MVRycWlBQ1ozS1dVeEI3L0RBbk1jUGUvczRBNGc0ZHhLQVZZYU95ZEVkNUov?=
 =?utf-8?B?NWNaY3FPdk8yQXlCTU8xT2oxMkpCNWxsRWpuZGkwRTNoeU1NNDdoYVN1Z1dy?=
 =?utf-8?B?RE5IZ2NLVDZKS2JRRzMyb1pWZmVrbUtlWmN3T3JyeXBKd2Qyanl6b1B1KzJX?=
 =?utf-8?B?eHpOc0hKQTBpVUtHV3dqRXZxb29aaWdvUm5RQVR2azg4MlV4OWR3Y0Z5SmxH?=
 =?utf-8?B?K2pPa2trRmJrNTJnOVgzeVEySTFnUWpKMVZuVGg2bjJKSEUvM2hiY3VGYnZi?=
 =?utf-8?B?bTdZWXNRb1I5enp4Mk9WOFl5MU9uY2VLRDFFcE9qNEV2ZXllK045THBhanRR?=
 =?utf-8?B?bDM0RGtqdC9tRmQvaXRzV2NuRWVzN01mamVnNENtNFQvR1BHOGZLNW5RWlg0?=
 =?utf-8?B?ZjVFSXRpUm5IQWVLUk5RWlR3bkVqOGZjQ0ViSUJra292Z2pzMW1ieVNXQmR0?=
 =?utf-8?B?VDE2a0JPWDcwbS8yQzV2eDlZK0hDRHVnRm5DNmtGOGt6S3VTNzkyRHptb01z?=
 =?utf-8?B?SFpRWnZRNDZpT2dYKzIvdXdtVWZDTmFOWHhRRjhodVJsKzZWVkl6eVQ2NXB2?=
 =?utf-8?B?Vm9aVkJqWnNnY05EM3JKTTZLeU9oc0JKTlhnb3dXVFNHS0xEMjgzcFNQa0dQ?=
 =?utf-8?B?YUVUcnF6eUw0aG10WXdLYUg0Rk94cXVKeTR6eTl5WjFSYTRsRTFTM3g4eTB1?=
 =?utf-8?B?a1RJTENIOVVYZWxoQ0M4bk5GdFJ0UytRVlgzMFNBbElpU3VyWnNCRE5rdlNQ?=
 =?utf-8?B?TzlwaVFFNnh6aXlvRnRZaFpJcnZySkRPZW50L2NlV3JZUlg0VTQrY0N2cnUz?=
 =?utf-8?B?U3FlbzlrZm10TVplU0hNWDBQTFpPUnFJbVA2bFlvZ1ZoT0VVMlNpR2loeEpR?=
 =?utf-8?B?MWtQdEd4MEw0cHl4eVBCL29UcXFlbUlXclU2QnlmajhQbXo2cTM0VDdzbWQ5?=
 =?utf-8?B?TlN3VVVPRThzSmVHZlpBT3NUZlFHdnc1MGZleHpTdXI0ZUw1byt3aDJzaTZa?=
 =?utf-8?B?NDlxZUtIb052WjVwWEhaRDh0S20zKy9HREI1Z3RRbkRUelNKWDBlMGJQbGR2?=
 =?utf-8?B?ZlI0NkZId290VVF0cWxtc2tEMFZydGU0QU9aV2x3VmViaW5iVTZzbEFQc2pL?=
 =?utf-8?B?TlorQ0JGQjM2R1E2NkFOTnJYR3JkZ3VIdVZOV3dlYkMvL0g1azBSVE1SQVNC?=
 =?utf-8?B?SXlLSU1UTEl4WTlhVDdpN0RkMmZJcTJFdEU3M3dWZXV5WWZEN3J6aFJ1TkJK?=
 =?utf-8?B?QzBYdExqb3RRYnNocjIzdERQWXhxUUtNRHZLeHJPT1RvaE9NT3Y2SGVqV1FN?=
 =?utf-8?Q?g2tXCdPS1ppZ1TKfVw6QluQ5xG+/fQsNRFVjhIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b68ac-2ecf-4d9d-41b0-08d97a15a681
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:59:25.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQXWeY9z/tAYzimK6VHa1XXuVkqNhePJo1CwYsUMxRQEBJY7dObpFG79I3eXcjKLOv+pXwCxf8XoCLjF6j6KLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

Can you also add a Fixes: tag to make it easier to identify stable 
branches for backports? I think it's this commit:

commit 1d5dbfe6c06a5269b535f8e6b13569f32c42ea60
Author: Alex Sierra <alex.sierra@amd.com>
Date:   Wed May 5 14:15:50 2021 -0500

     drm/amdkfd: classify and map mixed svm range pages in GPU

     [Why]
     svm ranges can have mixed pages from device or system memory.
     A good example is, after a prange has been allocated in VRAM and a
     copy-on-write is triggered by a fork. This invalidates some pages
     inside the prange. Endding up in mixed pages.

     [How]
     By classifying each page inside a prange, based on its type. Device or
     system memory, during dma mapping call. If page corresponds
     to VRAM domain, a flag is set to its dma_addr entry for each GPU.
     Then, at the GPU page table mapping. All group of contiguous pages 
within
     the same type are mapped with their proper pte flags.

     v2:
     Instead of using ttm_res to calculate vram pfns in the svm_range. 
It is now
     done by setting the vram real physical address into drm_addr array.
     This makes more flexible VRAM management, plus removes the need to have
     a BO reference in the svm_range.

     v3:
     Remove mapping member from svm_range

     Signed-off-by: Alex Sierra <alex.sierra@amd.com>
     Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


Thanks,
   Felix


On 2021-09-17 3:52 p.m., Felix Kuehling wrote:
> On 2021-09-17 2:04 p.m., Philip Yang wrote:
>> For xnack off, restore work dma unmap previous system memory page, and
>> dma map the updated system memory page to update GPU mapping, this is
>> not dma mapping leaking, remove the WARN_ONCE for dma mapping leaking.
>>
>> prange->dma_addr store the VRAM page pfn after the range migrated to
>> VRAM, should not dma unmap VRAM page when updating GPU mapping or
>> remove prange. Add helper svm_is_valid_dma_mapping_addr to check VRAM
>> page and error cases.
>>
>> Mask out SVM_RANGE_VRAM_DOMAIN flag in dma_addr before calling amdgpu vm
>> update to avoid BUG_ON(*addr & 0xFFFF00000000003FULL), and set it again
>> immediately after. This flag is used to know the type of page later to
>> dma unmapping system memory page.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 57318edc4020..e47f1219ad84 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -118,6 +118,13 @@ static void svm_range_remove_notifier(struct 
>> svm_range *prange)
>> mmu_interval_notifier_remove(&prange->notifier);
>>   }
>>   +static bool
>> +svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>> +{
>> +    return dma_addr && !dma_mapping_error(dev, dma_addr) &&
>> +           !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
>> +}
>> +
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range 
>> *prange,
>>                 unsigned long offset, unsigned long npages,
>> @@ -139,8 +146,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, 
>> struct svm_range *prange,
>>         addr += offset;
>>       for (i = 0; i < npages; i++) {
>> -        if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
>> -                  "leaking dma mapping\n"))
>> +        if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
>>               dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>>             page = hmm_pfn_to_page(hmm_pfns[i]);
>> @@ -209,7 +215,7 @@ void svm_range_dma_unmap(struct device *dev, 
>> dma_addr_t *dma_addr,
>>           return;
>>         for (i = offset; i < offset + npages; i++) {
>> -        if (!dma_addr[i] || dma_mapping_error(dev, dma_addr[i]))
>> +        if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>>               continue;
>>           pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
>>           dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>> @@ -1165,7 +1171,7 @@ svm_range_map_to_gpu(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       unsigned long last_start;
>>       int last_domain;
>>       int r = 0;
>> -    int64_t i;
>> +    int64_t i, j;
>>         last_start = prange->start + offset;
>>   @@ -1205,6 +1211,10 @@ svm_range_map_to_gpu(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>                           NULL, dma_addr,
>>                           &vm->last_update,
>>                           &table_freed);
>> +
>> +        for (j = last_start; j <= prange->start + i; j++)
>> +            dma_addr[j - prange->start] |= last_domain;
>
> This would be slightly more readable like this:
>
>     for (j = last_start - prange->start; j <= i; j++)
>         dma_addr[j] |= last_domain;
>
> Other than that, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>> +
>>           if (r) {
>>               pr_debug("failed %d to map to gpu 0x%lx\n", r, 
>> prange->start);
>>               goto out;
