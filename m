Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F41C47DDF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5923110FB15;
	Fri, 26 Jan 2024 15:17:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E652D10FB15
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFYPBUYV62gRm/TASAvxjJ9l3z9+zoNCxe5UKHBve5jnD/IOl5Vrx+ejtBAp9UM8BGZoMLTPxnKmVB+zgLH+l2LoJOPDbuGA2sqBwDcJbM01zJAQXb9VGEE25iAQ7JYrEtvdop2LE1qX7QnOJ3YSCVro6twXYilnjGiCEOE/ohYTUF8odegXjxdnT+2PtHwjjxuoXu+E0LYXk5oGqf6tUhB5z3bP5XpAUkMsKbCX6HqzigHyJjBMIAFR49WUO4e6XaQOv3YHP1jzWJqMyS8ySE2tDRmLxFd3LjEdT5Kvb3vPW9MwYAneXRVX3xyX7KxBq3qq80Xqb+yng8pxwqlV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHGA2CWKVtobuTBEUOvebaFj5LKnso6RXCJf/5gYAZY=;
 b=GFalnAW2Vpg49ZxRN8d7G/SBNXNIzZMrUs9fugFx3wsQaKm1s+CHOSRKeV2Afsb4MHFY3MVagbT2Au2fKxOA3RP58SWubX5v1XYudCGH6LB3TNXtex5l7iMl44b9ynl9dehyi2bQc7UMA4ah72/esk8W0AIMXLzaatPV9SfxIXFOHjptkqHRlF3CUU4bUOv6zIpS4jryfWui466l0bQB3gK8z9VKgge4RDINdkaYd2DelW2X5FOLlUhD3MoB+4ToVC7w6GZf8lW7hudFMD7Bns4eCofftfxFXae1Tpuv6Xfzh7Zm+Nb3TL5pilPmkFMJIQtADKSz9A/ISPY9JD2N6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHGA2CWKVtobuTBEUOvebaFj5LKnso6RXCJf/5gYAZY=;
 b=wDUrrb67G2fY3+Wgwg2cB4bsNhx+4HQS/iEcwy/KAbHTiF4TTiLA9PfWPJIgrFY41ucrPEnEIsGX8ENcHuocLr+pyGei4DWwjKUDTMCtX08VlWj0Q2K7qV12qDkf/TPnLk/VgqtXFGELf8BejIycDMWvRxvJr3ioP/unloKEkcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:17:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7228.028; Fri, 26 Jan 2024
 15:17:34 +0000
Message-ID: <170486a5-ec4b-08cd-a993-3efc569de0c9@amd.com>
Date: Fri, 26 Jan 2024 10:17:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Limit the maximum fragment to granularity size
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240126143830.30586-1-Philip.Yang@amd.com>
 <9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c48fc90-b31b-437b-00ae-08dc1e81ec1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTcMSGUPrQfBOlT+7jW8zXQ9+vRDOyz9B7Joqcj49hY0kgf/mF1qofd9VGNoP96leh5E8/Y5iIUMYGnjHgl7079vmNaEEHp7EuPdUkjYboQ1ZdtaRH2gG7C551EC6Gz56zoqMq3114I5tWNshMs0LVq7k/zujlRJu/G2sIbWtTIkAoP5tXJoRxEf13QeYCZ7MCOxp5pwVvdwJIJs9HQpB8BTtAqbMaEH5+xJg/CigX30g96JeRiou/u+rdDvCEBqIS0JpCgGqPSufOW6sZv3pecROZZJKvaRxqs/hxvMyUXR1d43isMQ+8MUmblVkhCHF2pKkyguG8g+C71lE3rnkuoj6Bbn8EdX+j9oaNuV8Rdv5BxJHMukeLJpS0GtMlc0ONyawhC1wzMZHJDfUSf/Ub7QSW/EmEemKGkQMFjXpX8RymM9lu22NkMmENkE1Igrc6N+lHsQCURBzIjsWej1NeZfSp1YaOBs8O2ZD8wdrSkA8atNIAI2Tw46x8xcf9xxB+ml+Xv0e8x2q6BPZld5f4o1KuL5NC4b23zvCU0orvsGgnwQxIkr3uzHx3hr/j47a5sV5fGP1Aqa5afVGAgwbhprKCKnLXiJ7LjCH24myPZ/77skk1azagSptkwpqcCMOE0LP/RH2wlio5eyvuUmcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(36756003)(2906002)(41300700001)(31696002)(66556008)(66476007)(316002)(53546011)(66946007)(6512007)(478600001)(6506007)(6486002)(6666004)(66574015)(110136005)(5660300002)(2616005)(4326008)(26005)(8936002)(8676002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJKZ2MxZFNoOTVxNCtHNkUxNEdSSFhwQi83ZEtZSjhaV3BDdjY1SlFGUXFu?=
 =?utf-8?B?ZnRTWXVOQ2ZjQ3BGMG02d29BdWNHQ3djQ0U1S0VzRUZrdm5naWlpOUN1NFVK?=
 =?utf-8?B?RkdjNWR2VFV5OFN6bDh5Y2ZRMEhadFpLSTNhMmNTckcveVFhdHN2aVNtTG1x?=
 =?utf-8?B?cy9lTSs3L3YxdnozR3VvbzIrRHpNMFkrQWp1YjFzbnoyZDkwWWlBdEZwaVNn?=
 =?utf-8?B?QmZRM2VXT1B4Vk9HclozSE5xbXBUK213blFHWXJMTE03VFMyN01KeDc3T0F3?=
 =?utf-8?B?RHdJNVAvTjVleVEwOG01ZkxqUFpoMmRoN3BmdlRBc3Jha2k4NkdhMDIybFhJ?=
 =?utf-8?B?TjU2Um9KZzU3WjcvdkppWXZCY0RobWp5N2lsRy83SzB3RFA3K09sTUpYb2xq?=
 =?utf-8?B?ckVpN3FEMktOTWNJWnY4Vk84ZnVCeFdnUytUNmJLeE42ZEM1cUcxNy83QzhE?=
 =?utf-8?B?UlJsRkZZajYxeHlxUkFKbk8wTU5JMldRaE9yY2YrQWJEVHNlZmNoRkhaZFJt?=
 =?utf-8?B?N2NWSVZML0ZPVlRPRTkyZWpxYkVKa2xpdHhzQjkzWUpsN3E0SWZnUkMzcVJi?=
 =?utf-8?B?NjhOYnZheEo2VVVQajN4QlVTb01NdXRYQzgzRkVOZ2w4NG1xcTM4Wm1LMHZj?=
 =?utf-8?B?NEI1VGZNYmt6VURXNng5MnRmM01FREdwVnZKRUpqMGo3UlZtRzAxSjgwWnFZ?=
 =?utf-8?B?TXhuc2drQVd2RU9vRFZ6VWUyemNoZDIwMkZZK2JGR3Y3LzAwUnpZQlQxOFFP?=
 =?utf-8?B?NFlRNjd6dXg0d01aUmFGK3ZZWitVcXU3M0QzY0t1dmNGNHhYREhrUXV4OVhr?=
 =?utf-8?B?Q3RaejIxcUpJV2VVNkdVQjJvN1luUmVuVWhsc0kyK05QVU5IeG4wdzBybWVU?=
 =?utf-8?B?NnR2eDNnRFVZblU4a0t0Vm1uR3RQaWdMSGdkVUVHVUh3TU5vUDg5RFlReWJn?=
 =?utf-8?B?K0pRTkc2SHA1am1RZzk0MDlqbC95L1Ntb3JicUZWT3l2ZGhyS1lkeU10bmNt?=
 =?utf-8?B?UDA4QzdMQVo0dFNkSnBRd1BiZE56ZVZoTkhyR0NoNGJFMmpObHBDNjIyMnhK?=
 =?utf-8?B?TEZsNlk0eWVuV2ZReFE3bzVhbWpvb3ZSRi8xVFJJeE1URUN1dXJlSllPR3lB?=
 =?utf-8?B?NHFDNFY3Uzd3U2lSRFN6RElWMWdZNWFUZzdtVDU5NVFiVHMzT0t3T1RSRGsy?=
 =?utf-8?B?MzNwbFR4Q1JsUkhIcGZ2VGxpQmlRQ2RSNFZ5S1I4enBHWmpvSUlRQ2N4enRv?=
 =?utf-8?B?cHE2QjVhZGJCek9pVDhTOFlKN0VMenF4SVJMakcwSHB3TjBVZ2dpeUNrU1Jw?=
 =?utf-8?B?OUJTUGJncUdwVWVpVnd6VG9hSDJkRU94YU8xTnNNWnhmaVN1ejhxZCtKenhH?=
 =?utf-8?B?K1Fkc1JvdFl0ODlpWXc4LzN1blRaU3hvajFRQk1zQ0pTWGFuemhqM25XZnVt?=
 =?utf-8?B?Z2hzaGpqSi9IbDFpZkNsS2lzR0hjTWh5WmQ0aVpaQUl2OW1FYXV3VjZsRDZz?=
 =?utf-8?B?SHlhSE51VHV3ai9qdDJvQ2pWSkJxVTY0RUYydU11WE4rdzB5ejNYOUNqZjhY?=
 =?utf-8?B?NXpCajY4Y2J5Z1BFMmJwRU50dGVOZXpwNkFvTXJrd25ydEQ4U0NhcFVrZTNt?=
 =?utf-8?B?T3BKSlVGKzFnb0ZsQjdnTWxSRmkyUko2dkFIUjZxdngzUWw1a1dFV2p3aXpN?=
 =?utf-8?B?WjBqa3RBYjRtSHJFejJwa3NNUDNMNTkxc1dXanlpRVd2OGl0VTYwWUhrWkZF?=
 =?utf-8?B?NmJsN3RzTHprdU13VndMQUpDT1hmOFdPN0lwZ0Vtc0wrVDR0eDYzMFpnZlZU?=
 =?utf-8?B?RXBjaDcyb3QraTdpN1RJVTZJNUk4T1NacG9wb3pweUh5UmIrelBaQkl5OXJq?=
 =?utf-8?B?SFZtbUJ1T0w1WUI1V1lDMGFWdzNVdjVHWWhpTUtzQVErUm51Y09CZWFkOVZP?=
 =?utf-8?B?WHBpT0pvSGt3VUdsNEEwVk5xQ3E3L3kwZDQ5cTdETERtRjFpTEZZVkh2VEtW?=
 =?utf-8?B?ZVBGZ3RQQXVNRmIzcEdYcnZaQ1pNSC9YbkNpWUVud1lCeEhTaUtZZnZFTWlw?=
 =?utf-8?B?QW9veDRTVW5vYlpGbDN3d0xsYzdzdThSUG9PU3ViUzlpakJmUlV5ZkU3QWx4?=
 =?utf-8?Q?khZAH4LFg0IlaY/xqoTcYkJHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c48fc90-b31b-437b-00ae-08dc1e81ec1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:17:34.1634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9rvaA8wZpXnYLuyR9H5a99pt/LLnQLQvT9R2FdDjtF3gp7O/D/gA7XfOkCfRHCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-26 09:59, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com">Am
      26.01.24 um 15:38 schrieb Philip Yang:
      <br>
      <blockquote type="cite">svm range support partial migration and
        mapping update, for size 4MB
        <br>
        virtual address 4MB alignment and physical address continuous
        range, if
        <br>
        mapping to GPU with fs=10, after updating mapping of the first
        2MB,
        <br>
        if the second 2MB mapping fs=10 in cache TLB, this causes the
        first 2MB
        <br>
        access to the stale mapping.
        <br>
      </blockquote>
      <br>
      Well that sounds fishy. When that happens with (for example) 4MiB
      and 2MiB, why doesn't it happen with 8KiB and 4KiB as well?
      <br>
    </blockquote>
    <p>unmap svm range is aligned to granularity size, if the range size
      is 8KB (all within one 2MB granularity range), it will be
      mapped/unmapped as 8KB, even if only 4KB is migrated. This is
      handled in another patch series &quot;amd/amdkfd: Unmap range from GPU
      based on granularity&quot;.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com">
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Limit the maximum fragment size to granularity size, 2MB by
        default,
        <br>
        with the mapping and unmapping based on gramularity size, to
        solve this
        <br>
        issue.
        <br>
        <br>
        The change is only for SVM map/unmap range, no change for gfx
        and legacy
        <br>
        API path.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; | 12 +++++++-----
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 22
        ++++++++++++----------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++++----
        <br>
        &nbsp; 4 files changed, 26 insertions(+), 21 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index ed4a8c5d26d7..a2bef94cb959 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -897,6 +897,7 @@ static void amdgpu_vm_tlb_seq_cb(struct
        dma_fence *fence,
        <br>
        &nbsp;&nbsp; * @res: ttm_resource to map
        <br>
        &nbsp;&nbsp; * @pages_addr: DMA addresses to use for mapping
        <br>
        &nbsp;&nbsp; * @fence: optional resulting fence
        <br>
        + * @frag_size: max map fragment size
        <br>
        &nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * Fill in the page table entries between @start and @last.
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -908,7 +909,7 @@ int amdgpu_vm_update_range(struct
        amdgpu_device *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start, uint64_t
        last,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
        vram_base,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
        *pages_addr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, unsigned int
        frag_size)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params params;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_tlb_seq_struct *tlb_cb;
        <br>
        @@ -1016,7 +1017,7 @@ int amdgpu_vm_update_range(struct
        amdgpu_device *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = start + num_entries;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_ptes_update(&amp;params, start, tmp,
        addr, flags);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_ptes_update(&amp;params, start, tmp,
        addr, flags, frag_size);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;
        <br>
        &nbsp; @@ -1197,7 +1198,7 @@ int amdgpu_vm_bo_update(struct
        amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !uncached, resv, mapping-&gt;start,
        mapping-&gt;last,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_flags, mapping-&gt;offset,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base, mem, pages_addr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        @@ -1392,7 +1393,7 @@ int amdgpu_vm_clear_freed(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
        true, false,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
        mapping-&gt;last,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value, 0, 0, NULL, NULL,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;f);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;f, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);
        <br>
        @@ -2733,7 +2734,8 @@ bool amdgpu_vm_handle_fault(struct
        amdgpu_device *adev, u32 pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, true, false, false,
        false,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, addr, addr, flags, value, 0, NULL,
        NULL, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, addr, addr, flags, value, 0, NULL,
        NULL,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        index 666698a57192..b34466b5086f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        @@ -465,7 +465,7 @@ int amdgpu_vm_update_range(struct
        amdgpu_device *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start, uint64_t
        last,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
        vram_base,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
        *pages_addr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, unsigned int
        frag_size);
        <br>
        &nbsp; int amdgpu_vm_bo_update(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool clear);
        <br>
        @@ -531,7 +531,7 @@ int amdgpu_vm_pde_update(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry);
        <br>
        &nbsp; int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params
        *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags, unsigned int
        frag_size);
        <br>
        &nbsp; void amdgpu_vm_pt_free_work(struct work_struct *work);
        <br>
        &nbsp; &nbsp; #if defined(CONFIG_DEBUG_FS)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        index a160265ddc07..4647f700f1c6 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        @@ -860,12 +860,14 @@ static void
        amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params
        *params,
        <br>
        &nbsp;&nbsp; * @flags: hw mapping flags
        <br>
        &nbsp;&nbsp; * @frag: resulting fragment size
        <br>
        &nbsp;&nbsp; * @frag_end: end of this fragment
        <br>
        + * @frag_size: max map fragment size
        <br>
        &nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * Returns the first possible fragment for the start and end
        address.
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; static void amdgpu_vm_pte_fragment(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end, uint64_t
        flags,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *frag, uint64_t *frag_end)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *frag, uint64_t *frag_end,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int frag_size)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The MC L1 TLB supports variable sized pages, based on a
        fragment
        <br>
        @@ -893,7 +895,7 @@ static void amdgpu_vm_pte_fragment(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (params-&gt;adev-&gt;asic_type &lt; CHIP_VEGA10)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_frag =
        params-&gt;adev-&gt;vm_manager.fragment_size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_frag = 31;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_frag = frag_size ? frag_size : 31;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* system pages are non continuously */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (params-&gt;pages_addr) {
        <br>
        @@ -904,12 +906,10 @@ static void amdgpu_vm_pte_fragment(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This intentionally wraps around if no bit is set */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = min_t(unsigned int, ffs(start) - 1, fls64(end -
        start) - 1);
        <br>
        -&nbsp;&nbsp;&nbsp; if (*frag &gt;= max_frag) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (*frag &gt;= max_frag)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = max_frag;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag_end = end &amp; ~((1ULL &lt;&lt; max_frag) - 1);
        <br>
        -&nbsp;&nbsp;&nbsp; } else {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag_end = start + (1 &lt;&lt; *frag);
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; *frag_end = start + (1 &lt;&lt; *frag);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        @@ -920,6 +920,7 @@ static void amdgpu_vm_pte_fragment(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp; * @end: end of GPU address range
        <br>
        &nbsp;&nbsp; * @dst: destination address to map to, the next dst inside
        the function
        <br>
        &nbsp;&nbsp; * @flags: mapping flags
        <br>
        + * @frag_size: max map fragment size
        <br>
        &nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * Update the page tables in the range @start - @end.
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -928,7 +929,7 @@ static void amdgpu_vm_pte_fragment(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params
        *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags, unsigned int
        frag_size)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = params-&gt;adev;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor cursor;
        <br>
        @@ -938,7 +939,7 @@ int amdgpu_vm_ptes_update(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the initial fragment */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params, frag_start, end, flags,
        &amp;frag,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;frag_end);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;frag_end, frag_size);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* walk over the address space and update the PTs */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_start(adev, params-&gt;vm, start,
        &amp;cursor);
        <br>
        @@ -1040,7 +1041,8 @@ int amdgpu_vm_ptes_update(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag_start &gt;= frag_end) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the next fragment */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params, frag_start,
        end,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, &amp;frag,
        &amp;frag_end);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, &amp;frag, &amp;frag_end,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frag_size);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index ed35a490fd9e..d71b2c8bf51a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1488,7 +1488,7 @@ svm_range_get_pte_flags(struct kfd_node
        *node,
        <br>
        &nbsp; static int
        <br>
        &nbsp; svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct
        amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, unsigned int frag_size)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t init_pte_value = 0;
        <br>
        &nbsp; @@ -1496,7 +1496,7 @@ svm_range_unmap_from_gpu(struct
        amdgpu_device *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_update_range(adev, vm, false, true,
        true, false, NULL, start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last, init_pte_value, 0, 0, NULL, NULL,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence, frag_size);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        @@ -1579,7 +1579,7 @@ svm_range_unmap_from_gpus(struct svm_range
        *prange, unsigned long start,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_unmap_from_gpu(pdd-&gt;dev-&gt;adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_priv_to_vm(pdd-&gt;drm_priv),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, &amp;fence);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, &amp;fence,
        prange-&gt;granularity);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp; @@ -1647,7 +1647,8 @@ svm_range_map_to_gpu(struct
        kfd_process_device *pdd, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (last_start - prange-&gt;start)
        &lt;&lt; PAGE_SHIFT,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev ?
        bo_adev-&gt;vm_manager.vram_base_offset : 0,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
        &amp;vm-&gt;last_update);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr, &amp;vm-&gt;last_update,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;granularity);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = last_start - prange-&gt;start; j &lt;= i;
        j++)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[j] |= last_domain;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
