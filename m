Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CFFC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438ED10EDE5;
	Fri, 28 Apr 2023 19:52:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E981310EDE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+/v2bzUl6zlxehDMMF4pLYXfPvMdQYrfSFZHJoOdw6dzkRzgHQRZmacROPaEkTYx+kXvLS7TOArNTrtw4HKeGVueINd/8av/Lj1+1FpDznbBzrhrRIayWGSaICh7iS/haT+ix0VKsLO7zNHKodrpPcLIXcC7Mk4x8PVnhNQgaQy91y2QN7byJuapbX/ctGekDvuIvTZseRjbiQpIS84X7d+wBw0asLwgXS2h+PS/ldWb4ZVkhjr3IwT06HcYzfO7zR5S6iNWeF+p2x6QogtIK9t9G08aZ+s4+WdMz2bSEhWsX7uKd1oy0pzLdVWqHlVx/gZrOGDvoAT44Z3otIEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyrgDkpw5b0iSznA2qh/N4QhRNOhHcjac50BD/qJsU8=;
 b=oA/OJ42nTLlB470NUX76C0P9RXNbh9BVzVrQU3Ty3VBTvtLP6cNN4WGoX3vpdppJtQ0yPtVsIQ7RwhSw5wIRRYLiP2K/YajV7486h9WjK1ms8h4hK4ceLXDPkEu3Klw5SDdsLGW01GU1NmwtP2JgTv15cB8Bhf316eXpswGpUyEW+ys8GorQtI5OUF6s1liQqEk32fkLDAw3Aug7CyvlIId0BpuOpQ3Q1XaFVTR6NZELUSWurdLdExkaeldyMEuLuHdNUz6hzeLFqMwQFy5zTF1l6OO9Y33Hgv0xlzqaQmxC5Az+RHgKfzjd4oJ3lFS9vV9iCor0ZRiQa0/tWLzdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyrgDkpw5b0iSznA2qh/N4QhRNOhHcjac50BD/qJsU8=;
 b=VkJUfER2t/Q962c62tA8488fKovd3MG1KzawqCN/h3VsMDqZpUcd/Vwxbl/m+X3dBtvTQgs/VFrMZKgYkoOzkQQFamJVnFdLPv5rOGEej0SdDUybh4wgSTtNX87Cu0ymw0OATIF6lD86hVZHp/534Fa2Qj5E/l3hJmFEnxIGZew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 19:52:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 19:52:37 +0000
Message-ID: <3a68453b-a25a-61be-1fa0-87452dc98829@amd.com>
Date: Fri, 28 Apr 2023 14:52:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdkfd: Optimize svm range map to GPU with XNACK on
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424193808.10383-1-Philip.Yang@amd.com>
 <a893e01c-af20-e591-35cf-6ec708cb9cfb@amd.com>
 <e0dce26e-8f1f-bc14-2020-32a85fcbdc59@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <e0dce26e-8f1f-bc14-2020-32a85fcbdc59@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:610:53::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 56da96ab-7989-4b35-ad9b-08db48221e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsP/JifP6KB5X3ahvB8cQhi/KH5NEWOm1+BYhjDqs7s5IMKTyY98OzHpObqPvHcs+CXeReSYE14jy3dNuunCzdGxoIlW05Y4FKqOUhIhWT/O+vsHmaLxN/b6JUO/rkS0x0KM0EuOkWpUUFNo9w46sQSGJL48+V2XKMYKKOoArkcmDOMRldaZ/rAJKqXKC6wSsaszvMPJplBlkl1lXmR+VS/0aSaS+b6SVm9yf/ZQnDJOPtQiCkNTWohFwDgwDg+iqtBcQObDJWTs9RqKZogF9pBo2KmuSn8mpp0LaApcG47Aix4FtwTwPCNgMbQTBepipr1SfxpQvkgF89t/jEWu2Vg6ljDvR/y2YxeRw9/ozfxtzGaBX/lHGtwmejXnmWANEuJHsBtTCqxbbl3W449ZP4MNU/Bb3zz8PuSF3YHgJMt7Tvy4TNZHjuzU8iLPbvOG1lCWL3HzsnH++aKozZ6Eywv8q1Rz9U2m5BD5QJ308TBxi/SxtrCG2cMabyKbOB3G//86KuldgUlhJMn+CzW+gRThHfBsgAuurEtM3if9aCuonoJ3oYOPKpuavae3AwIJDUui7BtHvLArpq0rTDflOds+8MZkWtLvPw3eWKTsYZd29Gxzm8VJofFMNFgq8vfmx888PoaXjIoKZrcH4AH/fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(110136005)(316002)(66946007)(478600001)(66556008)(5660300002)(8936002)(66476007)(8676002)(6486002)(44832011)(2906002)(31686004)(41300700001)(6512007)(6506007)(186003)(26005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEN6alhDR1FrNEgremg4ODR4Y3hFNjlhMHBpUjdFVG9OOE80b0R1QlhDdlRs?=
 =?utf-8?B?RmNWZHNGeW5Pd3lwc2J6dzVSblUxaWp5NTFIL29EaW1jZjQ4bmI5THBURGpa?=
 =?utf-8?B?TFh4M0NzRzVnYm9yUGlzZmZBUG9Sd2VsUlYrUHNKTExuMDNXc2NJcFhscEJu?=
 =?utf-8?B?YWJSLyt5cCsrT2dvRDF3UDZnbWN6ZFFReFRFV3FTMERjK1VYcUhESmtROU9s?=
 =?utf-8?B?OWl3TWVCUHB1U3M5Y2p3cWpiV3JoQ29RSDF1TTFCQlF2dlNHOVNkQmZuZnNo?=
 =?utf-8?B?MS92QmtBUnhFK3NBVHNzSmtkQVRSRXozTXg2WVpBNTZPMUFZSkY0c3pQR2Uy?=
 =?utf-8?B?SGw3dmNWTVRUdXltbVJiWHBuenpUeFE3V3UwZTVMNG5NOFlwSWg1NFhZUGtY?=
 =?utf-8?B?RWNJUnRqVS9DKzFsUkU4dDVuT2JUR016cWdjWDNHdnBibktyK0hBQjFZQ1dM?=
 =?utf-8?B?UWNuMGk4VXNoczNkVXh5ck1JY3V5Yi80T2ZjM3JFU1FoVVBraW5rMkh2Ti9i?=
 =?utf-8?B?TGJXQWIzUlByT0x6dWd0Z0dYVDFrMlVzRWFUZFU5aEJzeUZKRG11WjR5QUNN?=
 =?utf-8?B?M2NiMm15UndoZDFWSDA4VGlObWNCenhQcEJIQzlxbXB0Mlo2YnBjaVJ3L2Zp?=
 =?utf-8?B?bUg1UzJicUVwbnB1VGZOYU9wQXBhNGkxeVV5R1pnSyt6WHh5c2hyYmFEdlY1?=
 =?utf-8?B?ZFdGaTlESzlWVUZ2VXByeTA5ek5ITDhvTlhXZjV2K05UKzZ3eXFITDJYYXp6?=
 =?utf-8?B?d0VjNXRFOUtRY3JjYTRSS0NjSUhudFNhcmxmQlM2ZStBdUduckE4bDZvSFE0?=
 =?utf-8?B?aDlFaVB5OEFwbzJiY05oUldJVVlVSnQrejFNV2o5ZmZXcG4zZ0FrbVZzMW5m?=
 =?utf-8?B?RmZnUy9uNjNNREpCWnJXQ21hVTczMFdjb2oyOS9oRmRFNHdSYVQrUStGdElV?=
 =?utf-8?B?YkwrNFhlV2IxcDFmcVNLUHdyUzdLdXZncFdjUTIrNldOY1dwaG5Iam15a3JL?=
 =?utf-8?B?ZlVSUTUxK3N6eEJ3RDg3eUFsMGdQcHZRSHIvUnpxM1I4Y3VGQWVQeWlObVN2?=
 =?utf-8?B?S3ZCcTdFMUdHM0szSGhONnpqaHlFMW1UQm1ydUtxYWZBZlhXcFlsN0ZWYy9L?=
 =?utf-8?B?S1ZTVEVzNjdzRlVmZkFJaXRlcFJua3JBdUtEQUpJYnN2MmZDd1ZSQ3dmZW9a?=
 =?utf-8?B?YkVNQkNjYVMwU0YwSHRidVBPcFBTQk1lQXBPejQ3VzY4UFg2YTVOYjhOdEsy?=
 =?utf-8?B?c2taSkM0MVM2OFNzQ0c2VlJ1ZVkzY3pwVENvOU9RU2pud2RwWEwrS2lFZU91?=
 =?utf-8?B?Vnk2RzRpUldRWjFxOUFOZE1nNjdBM3NvNlJ2VFlqWkgxdEE5RjVodGFsdS9Y?=
 =?utf-8?B?cU91UUdrZ25YRXdRNCtpS2loY2ZySUszL1ZpZFF6NEFoR1U3aHcrWEFsbXZ0?=
 =?utf-8?B?MkxFT2dCSzBOSDEvQ0JFMVV4VWZkY2VrcDd6UTVCenIrLzNJL21odjBhN0hX?=
 =?utf-8?B?Uk1FNTJpaGNnV2FScEpMTUhuVHBQYjlEWXdEaXV6WmlxVFdJOC96M3NKb3BW?=
 =?utf-8?B?TDBjdkR5aThWc2RWNERXOElseEgySEJCWUlhbWR1cys4RG1kNDFmdkhUMGJB?=
 =?utf-8?B?RUpkNkEzcStXQ3J5cDA2Vnl3WFdGTkFOelgyT1dNRlNwYytBU0FkZklzN3dQ?=
 =?utf-8?B?K1h2N2RXejFGL1M4M3pxQTlqWHlOcFN4NkhqeGQyZTRrcmNsQ3JRcmtSQ2FU?=
 =?utf-8?B?enhVZXI4dEtWdEc2d0ozeVYzMWNyNWpQU2Zpbjl3WHMySkQzUm8rRkIzTVVC?=
 =?utf-8?B?bDlsZVNIdGhZK0UxY0E0OEVZcXVKc0UrVWZmclJmd2tCaHNGbXJtejlxd2Uy?=
 =?utf-8?B?RmhxWjYwNlVtOCtYNlVUZU5HZDNScVF5ekluL1F5YWFmdS9QbUtrNnUvNGZG?=
 =?utf-8?B?VVM0Um1sbXpMR01SYUZsOWxML1VIdzVwQTZicFNjZUoyNlJmN0h6U0Q2SGlp?=
 =?utf-8?B?aC9yUW9zMlhlTHJmODVTK0VTby9iZW1hOUlzbVQyVUl6Snc1aU5OTVpmTndC?=
 =?utf-8?B?bllKcDNSUUZhWVRJNExSNnNHVGdoalBWamVDazlBMUx0UVlnakpkb21iRm1i?=
 =?utf-8?Q?2zMShg529/rHC0m3j6PiWZO4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56da96ab-7989-4b35-ad9b-08db48221e21
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:52:37.6477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBC5TtkbJ4xMq6AoKWNSrN2UUwZJvJho0MMHLvq66+RaxEM5sxIGJcmZUSHdg8oCp6vXjXEOcyMhOZ91NT3i2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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

On 2023-04-28 11:24, Philip Yang wrote:
>
> On 2023-04-27 12:35, Felix Kuehling wrote:
>>
>> On 2023-04-24 14:38, Philip Yang wrote:
>>> With XNACK on if svm_range_set_attr set the range access or
>>> access_in_place attribute, we don't call svm_range_validate_and_map to
>>> update GPU mapping. This avoids prefaulting the range pages on system
>>> memory if the range is not prefetch to VRAM and not mapped to GPUs.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 129ef44f41e9..af7594b1b4c6 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -734,7 +734,9 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>           case KFD_IOCTL_SVM_ATTR_ACCESS:
>>>           case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>>           case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>>> -            *update_mapping = true;
>>> +            if (!p->xnack_enabled)
>>> +                *update_mapping = true;
>>> +
>>
>> For NO_ACCESS we need to update the mapping to ensure that the PTEs 
>> are invalidated. For ACCESS or ACCESS_IN_PLACE we can leave it for a 
>> page fault.
>
> For NO_ACCESS, there is todo comment "TODO: unmap ranges from GPU that 
> lost access", this should be handled by another patch. This patch only 
> address that for XNACK ON, we can setup GPU mapping after page fault, 
> without prefaulting and mapping to GPU for ACCESS or ACCESS_IN_PLACE.

OK. Then you'll probably change the same code again in that follow-up 
patch. This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>>               gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>>                                      attrs[i].value);
>>>               if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
