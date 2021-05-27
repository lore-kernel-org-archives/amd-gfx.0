Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA8C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78423613C5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78423613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BED96E04B;
	Thu, 27 May 2021 14:05:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61B86E04B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 14:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpJTNTA/rpOtcj9Ds93iogEfTjoEFMzVOJAgZaexY9txY5+e5KS1pJKvFOf70fdYPvI+eKz4Spf0VEaS+sEkevAe2XgfOTvADh+HWhU5Qh6vpsUbfun3Ie/IkHD5fjK7NWCtBe+WepZ/p5/734tL5k/PpujhLk1f4HPBu78ELR9rLDqeLUC9DnvDpINtbY3nC6fSBtmzu5E8EHdaFHG1hFM3ede44iCL5i+eKsjngaY672S/Y3f7onrLfvUN32wqTbecMBbZD/qvRR4DHwuvvhf6chPNlElbyJdIqetYqYTxPPFC/xw0OGSKBIGfTMqB8gpMKlki4DxC9Zxt3DMYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2FHoFcYO02nZzh2aM8q3+PwQ3MaMJamDU2fdqbJQ2Q=;
 b=J/UIrDiCbmyt67aBvC1/EgNcg1G+d7r5BaLMC2shABM2w/enAJRYnOYrDckyeR5MDq9rvHFN3GhBQM5cBHEOfLp0SKNoMYAEEceXDtamBDyqeH55A6FB8hil7yyPPQWo90FztWKG5i8alj9WW9Frm6v/HddN4+1SO7YQSohWOw4xebPIH6ncGVCa3VMn3KOpcZEnCiAP6BIwDaHC/4SbY6TX6D3U8ylAOIKtLRw5025FoxZbmziTc2gZ+E+cKl9PsuHNMwoYsvH50CmvGHb82cClivWdTknl117wmpGj38N2tK93IA0yf/ro3WnKD4gTTL0g8ioJrNGZZLUBBU8Prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2FHoFcYO02nZzh2aM8q3+PwQ3MaMJamDU2fdqbJQ2Q=;
 b=ytGwt6giZto6JjoG2heHUxq7i/lKXYIKHdzOkxApeabdCxFCljYcfKT7rRITHYJH8E3vaWfI5Z3ByCNAS/nArt4ueRZ6dkjmoLOX0oAaytH67sV/lM9hQpqApUocp8o98TdSDSk8hvhQ1O0FNQs91Q9j9pU2EmCmgs3c1Z2xIhU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 14:05:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 14:05:12 +0000
Subject: Re: [PATCH] drm/amdkfd: move flushing TLBs from map to unmap
To: Felix Kuehling <felix.kuehling@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
 <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
 <236a115f-7209-37ea-277a-ec86ec57f9ce@amd.com>
 <80a52ee7-0a94-0861-128e-ab23d209987e@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <9a71e303-f582-f658-f62c-dcda29c182d3@amd.com>
Date: Thu, 27 May 2021 10:05:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <80a52ee7-0a94-0861-128e-ab23d209987e@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Thu, 27 May 2021 14:05:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e336041-2103-4a2e-00ab-08d9211871d6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52614CB15404C5FFFCB0FC23E6239@DM4PR12MB5261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1C+7wrb7ldmKB68ecF71vYUJ4BNw/8y6Z6J0QgcYLXeaxmPkQFtt7K287jilRvl+X3ZOG0xrJcT+Tg2QI7V9zjI8jQzrbBv5LOu38sAByRjh2TA/dyXqrhDga+79vyEtH13qYhujZ9T6umFcqnKgpuTlb0m7tW1JrXMrV2Dv8zn+SaNNJXC2e6durmkQbdkMj/GesDZuIwCB4eMC8GdYzEgNxRp+QMSXtFM0bVeDdy14pg5mnpL5yU7G45SSZcl2uKk0Smq3n+oIS23yDjMaNH9p3ZUUtxSPnj1YzYJ4ARCwaK0aBxyj1EWWiFsfAeVquIXKKGJO8n+RCpw+pADqeHLlxHDULiW3/8MZOxYyn2eQ6af/We1+hmvdTaQsoCKK1ifOwGZOht5Y00eNUHuZo8y58EGcfE6YYzjY7p1hl9fOENxmEUfvzpuOOH4Ux7vse2IlfmyRWerfe5NjhOh70PJbTGT/QPbponZAtfgBxiMTZpFBNSEzY36pEuRfFerh9Co+xDdtlDCNq2jZ4TAkCBWzzmV2DchCb9AYNCnMh1U69FyJNZ32pXAnAIJH2/i196nW05eZZO1asU8K1g9pINcwD64oZoZ7nqvUKw7WZLrEtO6a4drHqUvLQiEvISx/c0kWJKdVTg/jBbLdGkeY0gvoHQBMB+HIxCfNIMOM5bt1+EnWdZvONSE+685HIpkpNHPTY2Onp6kypjfcLduXTvAToTK5saYU8aNRpiJIYMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(966005)(31686004)(8936002)(83380400001)(31696002)(478600001)(36756003)(38100700002)(166002)(16576012)(6486002)(2906002)(45080400002)(2616005)(186003)(16526019)(956004)(316002)(53546011)(66476007)(66556008)(66946007)(110136005)(5660300002)(8676002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Yk80bjJTclg4QXorb2I1eEQzVHlLbUZCT1JHYzhlZzRHUXcxbXFWQWtzcnY4?=
 =?utf-8?B?RkhHeDNsd1V2UU11aVVnSWNVRWkxWXZYQWVnSXN4NXJlWDBhMXpielk0S1NX?=
 =?utf-8?B?Q2tmOTNLNzFXL1o5N05aZWFHUGNXaHRPWVQ1dFFDREVQTjRQTlZ3cVRSK3FJ?=
 =?utf-8?B?Uy9yby94clhuUmhVdDZVR3BmaGtIYzN3cnpHZnQzUXdraTN1eWYxSFRTajdo?=
 =?utf-8?B?aVFWeHc3azBmLzd5cXdWaVZFdEFoYm9aZEhVeTM4UEQrTlZpbkxXTXlidGla?=
 =?utf-8?B?TklhYURRTEI0ZGtUYWt3WFhodFdpUzBFRS9vMGVsV2lWNXZBMS9iNWxaTkF6?=
 =?utf-8?B?K0VRSHBTYjNCa2JwSUlrVFUweHJKYXdRWWRPRVdJTkdUTVhjaEdZRi9OYUIy?=
 =?utf-8?B?TDVUL0Nuc1RqUGwxWmhIU2lBL1Z1Nnk0RlhIRnBtazR6OHVVakNIeGhBVk4v?=
 =?utf-8?B?OStFengyTGNqZWNKbHBaZ0UxcEEwUzFnTTRGTHVKT1RKZ2FFZTJYSVd1Z0ll?=
 =?utf-8?B?ZUdPZnJCWTA3NlkySlVIYlEycElVZDRsZ0FYMVd4V1NJdFptTlpUYlVCQ2ps?=
 =?utf-8?B?bXNtMTQ0aFE2ekQ0S25jdFB5N1pLVHdKenBHMTFHaS9KMzNwSEZmRmxKL09V?=
 =?utf-8?B?TkZ4K3hkV25CTytONDBPNlBmdXNiYTlKRGVYbnRzQ3ZXVzVkWWtaQjFEbStx?=
 =?utf-8?B?L1NIcDRzRTU2MUxhMjgzenVUUkFPUU8yZzBlSUcxbXhBa0ErV3FkUmVTYm95?=
 =?utf-8?B?SDVyUWhVbGVNM00vOEMrdlBWV0NXR3BzYUpPeW9KRjk4VXVXOVZQWlJCcDhn?=
 =?utf-8?B?YmRSdXIxMCtkNTRRR3d6QjVlM01OOWdKWThtTTk4MElKdzE1T1MvZWQvYmFq?=
 =?utf-8?B?TmZYcGNYaTY3U3R1VXFCb0VQUG9hNTQrU0dWYmFqMC9aUjBDTTR3bGdsNzJ0?=
 =?utf-8?B?YVB1bXR3Rzg5eWVsZzBWa3FQem1LbGcwcVJldVhwb1BST0FYQzdmUVRwT0Jn?=
 =?utf-8?B?a285WWdRb2hMSzlpQjdqVWl6ci9YMTJ2S2pldDB2RnZsaS9oNXkvVzRqRzJB?=
 =?utf-8?B?YmRKTFFSbWNOUUswRzNjZ2xpUjZuWW5la1l0dVcxVllYREUyNXJialBSV0pi?=
 =?utf-8?B?ejBodWVyTk45OUhVVllZd0R4N3hValJFNDA3aWQ3RHdHK0YzV1RHNlRNczE2?=
 =?utf-8?B?eS9zK01UaXZqSW9oVzJuOUdMUkZJb3lBNE5kbXp5NVY2bFE0bWR4bjJ2bVFH?=
 =?utf-8?B?RkRoWkRHalM5ZndoN3RONWp6RGlBYkxuUnRNOUx4UjBXRy9BbnVCelRTS0VT?=
 =?utf-8?B?RmpFbDRhaGJKelFkWXdNS1BKdU9ZY0lvTEtmdGZtRzlwS0lwVXlXU0FFTStn?=
 =?utf-8?B?NEptTm5yR0xNdzhUWXYwWDB0M0tQU2xvUVh4V2NSQlV1Y0hIb1NpcVhBamNu?=
 =?utf-8?B?elVCR3pNdmduaFl2TkdWemJWUnlsK1hjM2trYTJHZXhmU2JhRVdnMExFM0Zw?=
 =?utf-8?B?QmJaWWE2bUxZa0N5cFpRQ1BEb0N3ZHpEd1VGcWZsRUxyeHhhSHhPYnBtNmFB?=
 =?utf-8?B?TlJINzc3b3Zvb1NXekxmK1hRSitVUzFvSy9oUnRNVWN3alYzNEZ2Q1Fyb3hu?=
 =?utf-8?B?MWFzdGxIOGpvbGdpbHVWVDIvOSs1TndSTE9PQzN6SmwreTg2L3JQQ1JSSTZz?=
 =?utf-8?B?U3VrdkJyaTZUMVJZT04zbDg5S05qdllVcVJtbmx4Rk1hTTlKTGtSY1Z5Y1Nr?=
 =?utf-8?Q?ZZLutnMUaiNaWkO2i7DB51KW8+hDJvpZZRRn9ZZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e336041-2103-4a2e-00ab-08d9211871d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:05:12.5474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEFaOB4cBM4l1PEPLhlAHhPGKA/4OZiUL9Fu5tErIhK8/aqRYwCaio3Q7prOQcjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
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
Content-Type: multipart/mixed; boundary="===============1776117730=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1776117730==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-26 5:25 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:80a52ee7-0a94-0861-128e-ab23d209987e@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-05-26 um 3:21 p.m. schrieb Eric Huang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 2021-05-25 3:16 p.m., Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Similar to a recent fix by Philip Yang 76e08b37d0aa (&quot;drm/amdgpu: flush
TLB if valid PDE turns into PTE&quot;), there needs to be a conditional TLB
flush after map, if any PDEs were unmapped and turned into PTEs in the
process. This is currently returned by amdgpu_vm_bo_update_mapping in
the &quot;table_freed&quot; parameter. This needs to be also returned by
amdgpu_vm_bo_update and reported back to KFD, so KFD can do the TLB
flush after map, if needed.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I follow up your suggestion to create another patch (attached) and
test it. It seems it doesn't improve the latency when memory size is
bigger than huge page (2M), because table_freed parameter will always
be true when mapping page is huge page size. I think Philip's patch is
to fix the case of remapping memory from small page to huge page in
HMM, but it doesn't consider if the memory is remapped and arbitrarily
flushes TLBs when mapping huge page.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
That's unexpected. Turning an invalid PDE into a valid (huge) PTE should
not trigger a TLB flush.</pre>
    </blockquote>
    <p>table_freed will be true if PDE has been used by previous
      mapping, unmap the previous mapping will clear the PTEs, leave PDE
      unchanged as P=0, V=1 (in memory and TLB), then huge page mapping
      turns PDE to PTE (P=1, V=1) in memory, and free PTE page.</p>
    <p>For example, test map 0x7ffe37401000, unmap it, and then map
      0x7ffe3740000 2MB huge page, table_freed will be true, means that
      flush TLB is needed after mapping huge page.</p>
    <p>You can change the test, don't unmap previous mapping, then 2MB
      huge page will get new GPU virtual address, or closeKFD, openKFD
      again to create new GPU vm.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:80a52ee7-0a94-0861-128e-ab23d209987e@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">kfd_flush_tlb probably needs a new parameter to determine the flush
type. The flush after map can be a &quot;legacy&quot; flush (type 0). The flush
after unmap must be a &quot;heavy-weight&quot; flush (type 2) to make sure we
don't evict cache lines into pages that we no longer own.

Finally, in the ticket I thought about possible optimizations using a
worker to minimize the impact of TLB flushes on unmap latency. That
could be a follow up commit.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">It is a good idea to use worker, but how do we grantee it done before
memory is remapped? if remapping depends on it, then more latency will
be introduced in map.

Regards,
Eric
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Regards,
&nbsp;&nbsp; Felix


Am 2021-05-25 um 1:53 p.m. schrieb Eric Huang:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">It it to optimize memory allocation latency.

Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 960913a35ee4..ab73741edb97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1657,20 +1657,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct
file *filep,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto sync_memory_failed;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }

-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Flush TLBs after waiting for the page table updates to
complete */
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; args-&gt;n_devices; i++) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer = kfd_device_by_id(devices_arr[i]);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer))
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_pdd = kfd_get_process_device_data(peer, p);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer_pdd))
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_read_lock(peer-&gt;ddev, true)) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_read_unlock(peer-&gt;ddev);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
-
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(devices_arr);

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_kfd_map_memory_to_gpu_end(p,
@@ -1766,6 +1752,7 @@ static int
kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_read_unlock(peer-&gt;ddev);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unmap_memory_from_gpu_failed;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_read_unlock(peer-&gt;ddev);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;n_success = i+1;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0</a>
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
  </body>
</html>

--===============1776117730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1776117730==--
