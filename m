Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F7C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 21:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F357210E0C6;
	Thu, 11 Jan 2024 21:10:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21EA10E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 21:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn6VBzEnfWczIsk4UPFbhupBzgkh1FCxDevj2BVwA8Od9LGvVcavMC+WYvypFkGh0Kz6fMHlwaRgt4rzWeGqiOweQ9D0fdC26LF21iYdgyL6t+nZeRc05udhYvCBr0ERaYDRmt6RBAW46uE9l63WW2JI+F/UDjTLnxGzviEnWkHcEGfF4dCLm3ExUazBjOnW3/WoDf7rG5Zwt66ptQmru5L+GJrDX2ZU+UdDY347daDd4a2fW5/RdhZEbt+fM1iDJxD/ig9H6n2NKW+KVkdbXq42jJYIKv6PSGn1ZjzoAQ/cF/bfED2J53uMr/crtWi3oYBmlGmpMl6sEBAZxnGjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OHJiewMf3BIZnx64QvXwBFCKlH67rkpY4dJKz8Vy4k=;
 b=HfEyXUJBS28gAbMZCQ3ZVCrhkUMS9HPcr773ugZqCwnABi3LKW2Yz3AkrGl+9dnTNUgsMHmRLiScGBhvkqFqWGxTr5BySJU6zMMnnOubVqhGVThRpk2vGL+ni8cqH6aaBuXJOySNUDrd/OwTC1ts+nfOjGbeA+T1DxrPAeLhxjSIqYbDWGPa7O9zijniLLMH+ot8SV4rs//5iCApYAMKE2Uxg75g8NC8kR4X0FxshNnnwn8MTxLMiBmqBf54vJgS7Al+6ETeuTT/TNfpuW+E1iEr9xciyGF9+csoPfRogok84SN50o1W8gi6YHB97fk83wgtFw3sQVWelG6C4eIDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OHJiewMf3BIZnx64QvXwBFCKlH67rkpY4dJKz8Vy4k=;
 b=RTyHfXwTBmBI2oTQc5vPfRtUw5ByTuQSvCJAv+a6l5RI+a8eV/vCddUf1LJHp0zG0vntRBwnxhDYIo7MtaU5Vdzg7ELNUtspX2mXuYyGJIlVQvOEH5c8SL3RK+ORLXDKkRl4bJkPKrrf+bS6vI5D/AmpEJPOwRzfd258tlJNWHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 21:10:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 21:10:44 +0000
Message-ID: <aad43cef-b3a2-390c-c4f2-f97fd4cbde44@amd.com>
Date: Thu, 11 Jan 2024 16:10:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240110220143.25973-1-Philip.Yang@amd.com>
 <c76951c2-6abc-49a2-be86-301aa87457ce@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <c76951c2-6abc-49a2-be86-301aa87457ce@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ae7775-e5ac-4f27-e6d5-08dc12e9c651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNLgvf+hgZIw+IRwk4niFOyPiojaYwLp04+Rp7lriG8Fuv8xz9RR61V0ViaEeEdQzacsp8K25LiGknwWtNwt3suL73UULK0+6H06AfCQ3f68yYEhmx3LLLRSm5RljiKXV6vcGVSwEXhQ8v5olIyTeUuV+RU5VWuRnGRoWvlgzXQBilDZpQElKtDyxVJEPTeqLdocBpg6Qv7AtPiQmgdBtsm48qR94/wR+vveQYvOUfcVGPU4MvEBnzsQcyMrvyyUGHY/r1WIYa4Hm45Ifs1gxbEkSQmXL++JKMtu3q5aaJESozumeuNB1OucPROPzu2cuGmtGYCWLfHTrX4dWchC3fevXwCHOJFJ6oooHyooPvQxSoJX3s+zDWDnlSWN6eFo84ukk9rJxBC+PPDh8Ag08IhveNGFt35qHAPJnE8iMDbFpfoGknBN4XN9AqNrVTYRqq43EZ3zBSdJ8ERafh2IAbFS8FOgbrcW/nGtqoEDU6iVfnlJY+F9tObV3rjzD1M/i1qVE7A4R71ePfDfCfKUukEQ45Egcby6af49/kTz5B8XSkU+0kPDFgW30p4izbYbRcJX9C///Tt9GRDcsmh6/tS96HjZQwSpMF0t+YTqZO2El2VSEMU9kOTnmQtLAU8WmPxSwJ4IoFP3RRxvLpD4FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(2906002)(5660300002)(478600001)(4326008)(66946007)(316002)(41300700001)(66476007)(36756003)(66556008)(110136005)(53546011)(6486002)(6506007)(2616005)(31696002)(8936002)(6512007)(8676002)(26005)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldhQnd3UW01VmtSQVh1QjBvZWZBcVpub0VmZGcvYjErdFRPcTBjOGhicGhV?=
 =?utf-8?B?SUdxeGZ2U015Nmd5aVNzZXY1OTZOVjZSQUZJUzR5WHNHTEJTeG0zdlFQZXNT?=
 =?utf-8?B?MnB2Ym50UDNoY2krUTVhL2xtYjlxZnFWOVFyTUREczZuOE1PUWtMc1VGUFJm?=
 =?utf-8?B?ZXhxQWEwMzFkOUVid1o5RWJzSGZqV0dwWE0wZEZ3Y01aVyt6bGRyZ0Z1L2dm?=
 =?utf-8?B?bVpBSUZrSDdhWjZyVXViMnB4OVpmZWNzVkVwUmY3MlhqYk8xQUNTckFjYnp0?=
 =?utf-8?B?NzJLaVVHRVpHYnpQeDIvQU0xSWszUDRlLzB2aFdtdklPaHlWeXhhcW1OUzJH?=
 =?utf-8?B?Slp4b1RMSk5XWUxSQkRuNkd1MmU4V1NxQ000OWU1bk1TdzZaRytzTEtheWg1?=
 =?utf-8?B?MkROclIybWozczljYUJMeHArVjFsbU5IZmNueklZS3RPV2kyOHRpcnVmTk1Q?=
 =?utf-8?B?aHk3MjNtWFl6TlhJdmZ6YUdDU0libXlHYWEvd3k2cUlwbnFaNGtKQzNDOFFH?=
 =?utf-8?B?alM4OWFUZ3hjTUFPOExuZ24ydjB2Q2VDUDdHaTRXODJUK0hkenFqd2pRc0xl?=
 =?utf-8?B?aHRkSlcvRWxVZVpHby96eGVJT2VSZjFJbklOczB5a3o5SXNjZytYd0liQjFx?=
 =?utf-8?B?Q1dWSW9FLy9qTTlnejI5NFNRaXU4dE1abnVwb1IxUXhJOENqaG5DVVYyQzIr?=
 =?utf-8?B?NGpNRWhuTmF1MHNuaStxc2pMSHRzZzVWWURoMFFuY2MvZGxTampTeGhBYmlw?=
 =?utf-8?B?TGNicjJhL2VpZklhYmlaU2RyYmhySzhrRnJ6azlreExOelhmYVA5OG4zaUhS?=
 =?utf-8?B?Qll1Uml0b05QWDFhNkUvR3hpbW4raUJNWGVXRVNwOEUwQmRjcG1WMEJSdlYw?=
 =?utf-8?B?SUNwS2YyZWxCWE5nN2E5bmNiZ1g5VXQ3QzF1UVROYWZPdnM4ck5NSDkrKzE5?=
 =?utf-8?B?eFdCWCtaK0dPdjBHditoVE8wcmROaFdFMUhOS0JZVkcyQWd0Y2pLWi90Wksw?=
 =?utf-8?B?UzJ2Q1MyWlcxc29uR29rOUhuNEpPNW1KQkJoMGRKWXJyV3dlQS9pV3h5aTJx?=
 =?utf-8?B?ZW83bSsvVUdWdkQxbmY1TDczWjUrSitFMHhJdVhXVVhRYjZ1ZTJBN090MVZt?=
 =?utf-8?B?eEpHVEFzMTZ1RzY1VUwralB6QjZsK1o2THBpQmxBSTBqdzVkRG41VVF6S0RL?=
 =?utf-8?B?ZW1CbkkzT0lxNHNQL3MxZ2NDMDh2c1ZabGxmdU9qdFM5WElWTGpaN21rblg3?=
 =?utf-8?B?MU5UdTRqZDRDbnhaTUZXeHYrZDJHbUM2a2tTZG0zK1JVTlJNTU5jdkxiUXRD?=
 =?utf-8?B?eVc2Y28xQTFNVnhMN0s5MndSWnZCdGdDaEllZjEvL0VJUlVDN2N4OHRGMDZp?=
 =?utf-8?B?WDE3dFlOSGc1VEpkbGc5MjR3SkFnZ3FqR1RIMCs1RFZENWZEYndmSlFpakpM?=
 =?utf-8?B?c1FXdjVBTENSdmdaMllXZVpoQkkvaURYY1h1VlM1L09kRVRObFRDalg4TFVv?=
 =?utf-8?B?UjA2cWJtWjRYRjlQV2VmTVRRT3ovcEQzWmxOWDR1WkViRVZEc0tZMDAwcVBD?=
 =?utf-8?B?RUxQR1V5QklZZy9kUEt5N2NSM0xUbXdnUXV6c2M1blFIRHRTeStGOEJUMVVi?=
 =?utf-8?B?TFNaSDBIWVEyN2N5cUwrY0svM0ZGUkpDcDkzMTJ2RjRLMzJDandGNS80VW80?=
 =?utf-8?B?Ky9DY0I0NGtjcWtzN2M1ZitCODF6S3JLQ0dIVnFZOTRoRWQ4QTMrd0ptNllD?=
 =?utf-8?B?NXlKb0dMbzkyUVhMRXBxQndmN3J0UUlQQVRGclIveVJaaU11N0ZIbFROSFps?=
 =?utf-8?B?emdES1d2ZFlZZ0hXcTErSTQxbFY5aWtsdXdFelZvUnZrUnpJVVI3eEc0WUl6?=
 =?utf-8?B?dnowbFJvWCtkMFlwbldMNk12UUhYeFBCQWIvM1JxNXEyL1dEWjIrUlNGRm93?=
 =?utf-8?B?NU9JUWQ2WDBoK3QvT1BOYlErN0MvRCs2S2NTK0FYNnVPUHhrd0tnVjBaTkhM?=
 =?utf-8?B?djQ4KzdERmNhQzFJVUhWVlQ1N0Jkb1JUM3hGb0gzU1dWUm5LNmUxUXAvUEFp?=
 =?utf-8?B?OWRwTTlmOG1CSFpCdVlOSTFkSERDZGJOSFpvZnlseS8vZjFuVUh6OHNBa2ZZ?=
 =?utf-8?Q?Th+f1nxTJS4QvnmcIL341pvoJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ae7775-e5ac-4f27-e6d5-08dc12e9c651
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 21:10:44.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9OopNG5MYDRuq/YaA92nVOYqo0KVQr/ssdHhucbDowtVPmGv/D/fKAEdS90rvh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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
Cc: Xiaogang.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-11 11:54, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c76951c2-6abc-49a2-be86-301aa87457ce@amd.com">
      <br>
      On 2024-01-10 17:01, Philip Yang wrote:
      <br>
      <blockquote type="cite">While svm range partial migrating to
        system memory, clear dma_addr vram
        <br>
        domain flag, otherwise the future split will get incorrect
        vram_pages
        <br>
        and actual loc.
        <br>
        <br>
        After range spliting, set new range and old range actual_loc:
        <br>
        new range actual_loc is 0 if new-&gt;vram_pages is 0.
        <br>
        old range actual_loc is 0 if old-&gt;vram_pages -
        new-&gt;vram_pages == 0.
        <br>
        <br>
        new range takes svm_bo ref only if vram_pages not equal to 0.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20
        +++++++++++++++++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 24
        ++++++++++++++----------
        <br>
        &nbsp; 2 files changed, 33 insertions(+), 11 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index f856901055d3..dae05f70257b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -563,18 +563,30 @@ svm_migrate_copy_to_ram(struct
        amdgpu_device *adev, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct migrate_vma *migrate, struct dma_fence
        **mfence,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *scratch, uint64_t npages)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(prange-&gt;svms,
        struct kfd_process, svms);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;
        <br>
        +&nbsp;&nbsp;&nbsp; dma_addr_t *dma_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *src;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *dst;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *dpage;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i = 0, j;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;
        <br>
        +&nbsp;&nbsp;&nbsp; s32 gpuidx;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 offset;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms,
        prange-&gt;start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;last);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; addr = prange-&gt;start &lt;&lt; PAGE_SHIFT;
        <br>
      </blockquote>
      <br>
      Is this another bug fix for partial migration? If so, it may be
      worth making that a separate patch.
      <br>
    </blockquote>
    <p>yes, it is another bug I just noticed, the addr is passed to
      alloc system page along with migrate.vma, but addr is ignored for
      normal path, only used for shmem path, maybe it doesn't matter, I
      will put this into a separate patch anyway.<br>
    </p>
    <blockquote type="cite" cite="mid:c76951c2-6abc-49a2-be86-301aa87457ce@amd.com">
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; gpuidx =
        kfd_process_gpuidx_from_gpuid(p, prange-&gt;actual_loc);
        <br>
        +&nbsp;&nbsp;&nbsp; if (gpuidx &lt; 0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;no GPU id 0x%x found\n&quot;,
        prange-&gt;actual_loc);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; addr = migrate-&gt;start;
        <br>
        +&nbsp;&nbsp;&nbsp; offset = (addr &gt;&gt; PAGE_SHIFT) - prange-&gt;start;
        <br>
        +&nbsp;&nbsp;&nbsp; dma_addr = prange-&gt;dma_addr[gpuidx];
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src = (uint64_t *)(scratch + npages);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst = scratch;
        <br>
        @@ -623,6 +635,12 @@ svm_migrate_copy_to_ram(struct
        amdgpu_device *adev, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_oom;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear VRAM flag when page is migrated to ram, to
        count vram
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pages correctly when spliting the range.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_addr &amp;&amp; (dma_addr[offset + i] &amp;
        SVM_RANGE_VRAM_DOMAIN))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[offset + i] = 0;
        <br>
        +
        <br>
      </blockquote>
      <br>
      I'm not a big fan of messing with the DMA arrays here, but I don't
      have a good alternative. I think what bothers me is, how the DMA
      address array and handling of vram page count is now spread out
      across so many places. It feels fragile.
      <br>
      <br>
      Maybe it would be good to add a helper in kfd_svm.c:
      svm_get_dma_addr_for_page_count(prange, offset). That way you can
      keep the choice of gpuid and offset calculation in one place in
      kfd_svm.c, close to svm_range_copy_array.
      <br>
    </blockquote>
    <p>vram page counting is only used when spliting range, it is good
      idea to add helper and put close to svm range split and copy
      array, not put in the migration path.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:c76951c2-6abc-49a2-be86-301aa87457ce@amd.com">
      <br>
      Other than that, the patch looks good to me.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma
        mapping dst to 0x%llx, pfn 0x%lx\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] &gt;&gt; PAGE_SHIFT,
        page_to_pfn(dpage));
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index cc24f30f88fb..35ee9e648cca 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;child_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;prange-&gt;invalid, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = 0;
        <br>
        -&nbsp;&nbsp;&nbsp; prange-&gt;vram_pages = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
        <br>
        &nbsp; @@ -980,9 +979,14 @@ svm_range_split_pages(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc)
        <br>
        +&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc &amp;&amp; new-&gt;vram_pages) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;vram_pages -= new-&gt;vram_pages;
        <br>
        -
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!old-&gt;vram_pages)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;actual_loc = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; pr_debug(&quot;new-&gt;vram_pages 0x%llx loc 0x%x
        old-&gt;vram_pages 0x%llx loc 0x%x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;vram_pages, new-&gt;actual_loc,
        old-&gt;vram_pages, old-&gt;actual_loc);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1002,13 +1006,14 @@ svm_range_split_nodes(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;offset = old-&gt;offset + npages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (new-&gt;vram_pages) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1058,7 +1063,6 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;granularity = old-&gt;granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access,
        MAX_GPU_INSTANCE);
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
