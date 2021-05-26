Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93347C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 19:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECC660720
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 19:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECC660720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F384C6E526;
	Wed, 26 May 2021 19:21:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3C06E526
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 19:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/i7pcgY4u++hECpyvO8uwcqbZTwEwxhvGeydcZpIJMpuD+cO2Ovgn/Hr+FDJqcKhZH45g9EGxUe7INFRLPw9SIT1Z5XY7yKnK3+lv3n7r0QIQRaL9huqt4A5taVsHXptZ39ocdNBjIhNTynzSgslh23L6ILi0X3Hkaxd55bLfJZcvLtlwp5x0QskmWA/HT3LJUK2MyN8ZjmWfw/vZXQ5O5WhUjC8oglqZH9vMHmWkinfcoF0k7GF5JsRJBTTU6gh0OLh1mQNGPKQB0Y/J9jyv0Y8yR+vME3cY1HI+2PX/AlP5LzbrjTVtYGKiA4hWp0szn5hibQU0ykdVU18xMQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG26u6llsQp8zUKQHE6+DAiUrwYptHiCUMI7e05blRQ=;
 b=HVHCHInX/USgILp48fszozGIcQik2zZY9UkloOFzVwZXSHk0BloKkkV4mwFBpY4KUq4YYLj2plm2IA90PdYibVscXGhvrBr4xy7NYBmi84I2amfW7oDw6aC+4+Eehk2mEmAvJxURso2qHQKIMg47AbVcfwIjR2qVQxx/sMAjJcjQR763sQY1XMN0cFGGCjvkBmEahwAPld/4f1Cd3v6V1SO8ujrq6jbX0IPf/BfHH++cl3X1Sunm8quo6KvwMGBK5h63wZ/gDN7b/2vejLHLfmOScD84gxEczYNSPqeqZ8N+LT5FvHsOg3eqvDCW0EeBrw8WLQNgioGfhWnyfQ8s+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG26u6llsQp8zUKQHE6+DAiUrwYptHiCUMI7e05blRQ=;
 b=MiGgv9/YauFm/vGkgV9OxCG74Zy7BT2/yq53mzTY5P2AA8UQBKvwJygNPSyOJ9NnJRiry1vrkWreK/6K2AfkxEOcBT8YMrUr9LNjEAdWvbB2+R9C2LPguLdBcKDTr07Ke9F8Dy+5qjGMrcoz6DL5rZau98ggDp8DzoFU1f4S3OM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 19:21:30 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 19:21:29 +0000
Subject: Re: [PATCH] drm/amdkfd: move flushing TLBs from map to unmap
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
 <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <236a115f-7209-37ea-277a-ec86ec57f9ce@amd.com>
Date: Wed, 26 May 2021 15:21:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
Content-Type: multipart/mixed; boundary="------------DD97DC1848C531FCC6394E59"
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:889c:5e2:3561:6b91]
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:889c:5e2:3561:6b91]
 (2607:9880:2048:122:889c:5e2:3561:6b91) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 19:21:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca05fa95-327c-4663-a224-08d9207b76ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB446608625F47FE107ADD271782249@DM6PR12MB4466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: god9/ycZkqFXWkjgcXrPcKFZ/i8WgmfWm/OkLZdAq+FGm44mmu51LlEboEgwX19A8qmy7RICD6NTKMABEA/HcDXX8UFWBa7Fvx636y4kISm047sOp+xMDeztmXXp657K5rwCIii33J1J7WB1TU7dFl1l9xuXR0QSCGQin1qmn9hZ1xItTORmD2mecXln8UNHucDS764WQah7125xnTy37kTFYTJoQyQ/r6AXPIoFzkhMD6f+ZUw3vKUywc+8sNkOfsEzdmXqXxJROjTkq/3k/MiuKFSV2BGILRnuCbeEHFrkTC0XzEXJc9THa2u5nL0f5PU/aDiYhIABX9+4SgCH9DXxRs7ofipbpaFrDcGvfeME2Gq7SLzkOwpkd6CIRWAT0QeqY61bnYwWh5zP2aABhJrGBMUkBrtZXGe7VeK4OEpO20tK7pT4aRP0KKW7yF89R845pSdwD/rH4zfskwF0/hzQf8WXTFJaBM0uSpRM9iagDhz2nvm/lPz0JUOsYsXTo7WACHJgCuTpivzTr0QJ4tdDfJP3T01BGxbFgD7c2Sx10BwhoF6BxquQf/SGllqfJMpG6jlS9E/3KWQaD6QWLFJYp+VUbXhaJGSrulE6zyABKLsqiyssn/vfM/C9+PIjQvl1kM3Xo3XinUX0otVwn1txI927ejk0yYvOo2Wtg2q1RlpPqImQWcDunj6fGpwrcfn9rExCmK0hLY7JcUN8+6/C5t/z/a3sVsiI80xcLbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(33964004)(83380400001)(31696002)(16526019)(478600001)(2906002)(966005)(316002)(31686004)(5660300002)(6666004)(86362001)(38100700002)(66556008)(66616009)(66946007)(66476007)(186003)(235185007)(36756003)(53546011)(2616005)(8676002)(6486002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmJ6UTdjV085OWhZRlYrQW9Ba2lHdTBnR1JvdHA0ampvWGdaSTZRL3hzV3RR?=
 =?utf-8?B?OEg0NVFsUWpjR3ZjWHVVQUNmU1Npd0x2WFhCc2dWampGbEtudHdZdW5oWUlL?=
 =?utf-8?B?QWNJcXhyajNIL2NFSkZ5WWtTMnRVUEZwMU5jWjF0SDU0azFWYUlVelNXZjd1?=
 =?utf-8?B?dURXU1JXVmhsTm1CR1Z0RVhMajEvT08waXYvSHFEbDJmVVg3b1Arak43cERs?=
 =?utf-8?B?MFR4ektuUisxYWs3dkVoZ3NlNnFJUE1DSytGdEJaVjlqYzZub09ZTzIzMThn?=
 =?utf-8?B?RmxjdXJHQUJHcHl2dUt4Mzlzd3ZsRUNLYlpJRmFHT2F6UHNlcmlVcUdjbUJD?=
 =?utf-8?B?UkZLc25Kand3Tm9WV3lpb1hLWEk0U0dWVmxnTyt5VkltSVdsMW94SmMwMjZ6?=
 =?utf-8?B?RDBucHRJVlR1OU53SGNMdkZ1c1B5b0xzWUd4aG1wYlBONjcva2YxY3NMWjVw?=
 =?utf-8?B?S3VIV1VDMXBBczFHQTBPYVhBZTNXSEJrZldMNGdwUDFad2JFTEdDMy9PYWlI?=
 =?utf-8?B?YUVnUnVFdTZkTkwrY3BHbjFZNVVyRVRISGRPQmIySTl5bUsyV2JhUmFDSkht?=
 =?utf-8?B?V2g0c1Zod01zbVFNUU9wd25DaUFDVURhaDgxV3VCQllRWnp5REVWcUZ4N1J1?=
 =?utf-8?B?V1EwcU8rRnRUakVQbWoyRFpKTnErOUw5WmhUanZFNGpOVGRjS1lyR1pkeHpi?=
 =?utf-8?B?WFFOaEsrOFBNMS81ZzZIc09UdjJseE9MS0d2RXhXWW43cmN4RkJJMWcreEps?=
 =?utf-8?B?NERuYm02WXVmbnNQbWFqWTBmWkpvem53RG5uLzE5MGxWNWhJNVFTQjMyVU80?=
 =?utf-8?B?K08xb2RUTmFYYjJaNldNRy9laHJSWVk5YlNTVEhOMHd0SlZSRVMzRjNWTGs4?=
 =?utf-8?B?Y1VBbDFnZVFXN3FNTnBpeXp4SjRHTllCODNZYkI4a2hYdTVMSHJuZmU4dG9D?=
 =?utf-8?B?QldpaUFtcWYwb3kxTmNTbVJSZlEvVkErQjJPTUF4alMxUzRkOVB5bE1pOEpl?=
 =?utf-8?B?a0ltQ0l6RTRGQVcwNVpaSjZhZzVaTTV0eFVWbG9LWG1JZnlXZGI3Z2VlMkFx?=
 =?utf-8?B?OU91WG9BMzNOdWVtMkdWUVltTDRUMU1NeFN6YmF6M1U5a0NMQWRuQm91bGpJ?=
 =?utf-8?B?SHIyWlp2OEc0YjJjRzVnZm1ndlk2UWdoVWN2Wk9ZVmFuUXYrM015SHp5OEts?=
 =?utf-8?B?MkdLWlU1ZDlzQ1FWVGdqbWxrV250T3FNTElMS01lSVFUc21seEVJeklMdG11?=
 =?utf-8?B?bzhQZUw0UWlwdWpua1FhcE45SjYvQnJWUjVEdmNGZjUrWS81OVBidGNTbzJi?=
 =?utf-8?B?UlZmTGJxNnpKcWhmUXJYOG5KZGlBZmRLWmdzaVltTTNwOVllV0VaS2thbG1i?=
 =?utf-8?B?S1JpUmRKNUppd25wRThIZU9UWG80cFhHdFQrL2ltQlFvWGFWV29MbitrMlJs?=
 =?utf-8?B?TWdxdXFqUUVsdlBTT0RjQmtLVC92akl6UDZqeEpzMmZZQzdRMktLZU1kNy92?=
 =?utf-8?B?Qmg1eUN0Vnk3MUUwQW5RZjFrVkNYYnhtbUQ2amthSk1vMmx3OGtpaGhadjhw?=
 =?utf-8?B?S3lETlRHUEFjODlFcWRjQStCMkxuSHdOUjc5ZURvZWlHRWpCaWtTdmIra29z?=
 =?utf-8?B?bGNja3JRVEZITlgzOVB0Vm5UbStud2g0czBsNFVQaGZsM3p0T2w1NlFJMEJO?=
 =?utf-8?B?TUo1eFFMTURCVVZNSlZoRGNJUzRzbFcrQ1JBNjE3bUlnN0RWS01wY2Ftd3Nl?=
 =?utf-8?B?b09KdENocUdnTG9IUG05WTVMWEthSmROaTlOdVhVUTdSVXAwb2ZGMTl4UUVS?=
 =?utf-8?B?VXAyU3daaE82RjRqeWYvaXoyYS8vMGN5ZHV4R1hScmx4ck55eUcwS1d2N0Fw?=
 =?utf-8?Q?f+fbboWV5sKJp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca05fa95-327c-4663-a224-08d9207b76ce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 19:21:29.7534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqxCZEBLwevcUU2qT22/rDmXcSB7cc4Vw2pC2WgWr9YvUuuIhm/TdnsT1bEDUlOhuSSrp53xFY6Q/vop89sojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

--------------DD97DC1848C531FCC6394E59
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-05-25 3:16 p.m., Felix Kuehling wrote:
> Similar to a recent fix by Philip Yang 76e08b37d0aa ("drm/amdgpu: flush
> TLB if valid PDE turns into PTE"), there needs to be a conditional TLB
> flush after map, if any PDEs were unmapped and turned into PTEs in the
> process. This is currently returned by amdgpu_vm_bo_update_mapping in
> the "table_freed" parameter. This needs to be also returned by
> amdgpu_vm_bo_update and reported back to KFD, so KFD can do the TLB
> flush after map, if needed.
I follow up your suggestion to create another patch (attached) and test 
it. It seems it doesn't improve the latency when memory size is bigger 
than huge page (2M), because table_freed parameter will always be true 
when mapping page is huge page size. I think Philip's patch is to fix 
the case of remapping memory from small page to huge page in HMM, but it 
doesn't consider if the memory is remapped and arbitrarily flushes TLBs 
when mapping huge page.
> kfd_flush_tlb probably needs a new parameter to determine the flush
> type. The flush after map can be a "legacy" flush (type 0). The flush
> after unmap must be a "heavy-weight" flush (type 2) to make sure we
> don't evict cache lines into pages that we no longer own.
>
> Finally, in the ticket I thought about possible optimizations using a
> worker to minimize the impact of TLB flushes on unmap latency. That
> could be a follow up commit.
It is a good idea to use worker, but how do we grantee it done before 
memory is remapped? if remapping depends on it, then more latency will 
be introduced in map.

Regards,
Eric
> Regards,
>    Felix
>
>
> Am 2021-05-25 um 1:53 p.m. schrieb Eric Huang:
>> It it to optimize memory allocation latency.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 960913a35ee4..ab73741edb97 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1657,20 +1657,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct
>> file *filep,
>>                  goto sync_memory_failed;
>>          }
>>
>> -       /* Flush TLBs after waiting for the page table updates to
>> complete */
>> -       for (i = 0; i < args->n_devices; i++) {
>> -               peer = kfd_device_by_id(devices_arr[i]);
>> -               if (WARN_ON_ONCE(!peer))
>> -                       continue;
>> -               peer_pdd = kfd_get_process_device_data(peer, p);
>> -               if (WARN_ON_ONCE(!peer_pdd))
>> -                       continue;
>> -               if (!amdgpu_read_lock(peer->ddev, true)) {
>> -                       kfd_flush_tlb(peer_pdd);
>> -                       amdgpu_read_unlock(peer->ddev);
>> -               }
>> -       }
>> -
>>          kfree(devices_arr);
>>
>>          trace_kfd_map_memory_to_gpu_end(p,
>> @@ -1766,6 +1752,7 @@ static int
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>                          amdgpu_read_unlock(peer->ddev);
>>                          goto unmap_memory_from_gpu_failed;
>>                  }
>> +               kfd_flush_tlb(peer_pdd);
>>                  amdgpu_read_unlock(peer->ddev);
>>                  args->n_success = i+1;
>>          }
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------DD97DC1848C531FCC6394E59
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdkfd-conditionally-flush-TLBs-after-map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdkfd-conditionally-flush-TLBs-after-map.patch"

From 6218597e7117ec2f18cecd9314e196d598497b62 Mon Sep 17 00:00:00 2001
From: Eric Huang <jinhuieric.huang@amd.com>
Date: Wed, 26 May 2021 14:50:52 -0400
Subject: [PATCH] drm/amdkfd: conditionally flush TLBs after map

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 27 ++++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  4 +--
 10 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2560977760b3..997258c24ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -85,6 +85,7 @@ struct kgd_mem {
 
 	bool aql_queue;
 	bool is_imported;
+	bool table_freed;
 };
 
 /* KFD Memory Eviction */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 385c33675227..e445ac7ff2ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1126,7 +1126,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 
 	/* Update the page tables  */
-	ret = amdgpu_vm_bo_update(adev, bo_va, false);
+	ret = amdgpu_vm_bo_update(adev, bo_va, false, &mem->table_freed);
 	if (ret) {
 		pr_err("amdgpu_vm_bo_update failed\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e9f9f462a652..e3df132e53a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -916,7 +916,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
 	if (r)
 		return r;
 
@@ -927,7 +927,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
@@ -946,7 +946,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (bo_va == NULL)
 			continue;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2120a87a949f..eac2fd0048cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -696,7 +696,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0dee2e8797c7..851d128609af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1790,7 +1790,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear)
+			bool clear, bool *table_freed)
 {
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
@@ -1883,7 +1883,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, mem,
-						pages_addr, last_update, NULL,
+						pages_addr, last_update, table_freed,
 						vram_base_offset);
 		if (r)
 			return r;
@@ -2137,7 +2137,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 	}
@@ -2156,7 +2156,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 67bba8462e7d..a53f95958b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -419,7 +419,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
-			bool clear);
+			bool clear, bool *talbe_freed);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 960913a35ee4..0c31ff62d0a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1649,8 +1649,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		args->n_success = i+1;
 	}
 
-	mutex_unlock(&p->mutex);
-
 	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
 	if (err) {
 		pr_debug("Sync memory failed, wait interrupted by user signal\n");
@@ -1658,19 +1656,23 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
-		if (WARN_ON_ONCE(!peer_pdd))
-			continue;
-		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd);
-			amdgpu_read_unlock(peer->ddev);
+	if (((struct kgd_mem *)mem)->table_freed) {
+		for (i = 0; i < args->n_devices; i++) {
+			peer = kfd_device_by_id(devices_arr[i]);
+			if (WARN_ON_ONCE(!peer))
+				continue;
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			if (!amdgpu_read_lock(peer->ddev, true)) {
+				kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+				amdgpu_read_unlock(peer->ddev);
+			}
 		}
+		((struct kgd_mem *)mem)->table_freed = false;
 	}
 
+	mutex_unlock(&p->mutex);
 	kfree(devices_arr);
 
 	trace_kfd_map_memory_to_gpu_end(p,
@@ -1766,6 +1768,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			amdgpu_read_unlock(peer->ddev);
 			goto unmap_memory_from_gpu_failed;
 		}
+		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 		amdgpu_read_unlock(peer->ddev);
 		args->n_success = i+1;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c1bea1f7627b..a4920bc5cfbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -278,7 +278,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
@@ -314,7 +314,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			pr_err("Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->kgd,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd);
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ecdd5e782b81..edce3ecf207d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
-void kfd_flush_tlb(struct kfd_process_device *pdd);
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4ab9da288f90..a03373743a3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2161,7 +2161,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
 }
 
-void kfd_flush_tlb(struct kfd_process_device *pdd)
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 {
 	struct kfd_dev *dev = pdd->dev;
 
@@ -2174,7 +2174,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 							pdd->qpd.vmid);
 	} else {
 		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
-					pdd->process->pasid, TLB_FLUSH_LEGACY);
+					pdd->process->pasid, type);
 	}
 }
 
-- 
2.25.1


--------------DD97DC1848C531FCC6394E59
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------DD97DC1848C531FCC6394E59--
