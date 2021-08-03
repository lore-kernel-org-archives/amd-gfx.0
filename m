Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 14:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CF660EE7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 14:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93CF660EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5BA6E872;
	Tue,  3 Aug 2021 14:06:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4A06E877
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 14:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3GRQAU4rxjAtfAOoq6xeWq3zRgpUIME17ksaI/zicboaULbbRKT83af/2LhdOeNDJj8BkBzq8j42RA+02HCWxOHwqr0gWqG99ZYnEHmqMKB74DdwOiS2fS8AvhmRvGhCjeC+4hZ+x9sIMCA+E7HvFjT3IgxT7dqwPM/UrgGG8nzspxKQqUtU+V1EUjS8xU6UqMP3FwPFMI8UBdwHsiwxjMcEYRR+kPGNxftvzdRgylVqxpeOvdwoi4t7X9e83jExonuSmT6UHDwk1IE3PhOxlSahmR2ONonpKX2fdQpMJJ3MFnXTbN1ccHP6w16gDUML2OpPb8e6dNzN7utmU/Dzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZljcqC3lPXv4cEvz4VlBIgMuUTwajB0vtDHJq8vQng=;
 b=HtNBdpfkNYdBH/vgdLkGomK+tYQOpwLSSv32GRFRGPfVYfhRjlqt3+RkkHvqCcJHKWhgXLemTe6v1toFSwk1KW3B5S5C/afch70LCmvlTNmY1EbT6aeFxAvBuK1asaOe9ymRujLUcDf4K9V77Lo7lvVxY8ewjO+b2f/r8rfy+Q/x8P+N+fST8rEuZIcf4ymPMlxdEDEpp+rse6nsi7jj4VSUKEwpu+2/AWGnQPGWjtU1KVQB2/hBNni7IcHELHVT4Amzw7AspCe36paS2+ioYzcdqOivMTbJas6z9GuH2unydrbvUt0rumHhNN6N94z6NFXXLk44DuGBsQ8lh1XdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZljcqC3lPXv4cEvz4VlBIgMuUTwajB0vtDHJq8vQng=;
 b=mYR/gzGN32aW4tnjFd2Z8JvmFO5nv6cnPH0Aag5pK4SdGUGiPfEXNYCyPogNr5hWKG1irdg12JRp7dTGr3whdDZdrup0yggoJ/ZbXTwPLgppBHHylOiEZRSpuDEDwQATrUG13khmxxDQUSd1mSw2zQ81/WZWlpofrLNkzP13e4Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 14:06:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 14:06:05 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix fdinfo race with process exit
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210730021321.7953-1-Philip.Yang@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <00330732-4232-3d3e-e271-47df226514ad@amd.com>
Date: Tue, 3 Aug 2021 10:06:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210730021321.7953-1-Philip.Yang@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 3 Aug 2021 14:06:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34156059-4568-4909-f287-08d95687d59c
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55509DCFE6C777A062750C60E6F09@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsdZJED5OSN/zWxGYUzRYNBzaKb798Kc3xramKtObCn8J6SAsLE7OmElECBbaut5JVWKvCyi6V/6f5+C/MGtgq/xSfeJtLIZruGbkGVEDlr55BpmoY3b0bIM40uQnlA+VVfAYll6HTRardwXcm05Fos5QmQhTU7WgFC3jcn8cqUwGuPhi76TbnQScVSvzRFSyelyYvqlenGPmDMSzH3Y6GZFZ0q4LpY6x0t28AgjjMF/+u8F+0z1oHpB5PtGaQcScO4WSsQoUx3tJYyhLnXP3f7AblAmNyLpPpI7Errjsyd/cRBefpighLcSxmaTD50CRiB+X+bsKY63C7bpq5KERGHGnuYP9HzR7kMsA1UmPMs4IJ9gRDz/wApDUqLBR524F0UKFnSd9Yd7MUt6eoTQX1hm7+zAjKW7QVJeFOejifhw2Ym24tBTHuNfDnjKN0vExfDKcDtHeSRaJyKbPvqFV6urbdeZhb93EYKJNJdynKqdtwLCPgIY1qpiBfUi97DO9SyptqQl0wQDJZX6PdDB2kaNtgHELEfW0UDRDNdz5u3SGfFiuAPCyJSkPKjfwIKbiMlZ+KqKjS7juT9ezKpRnwrpF6lqD11CZJgA/utqX2WwJV80ejlxh1CYq4n67e5OCgk6sxx2ur7qvpjpcpr45f4ZqaNIvhT0X8wR1C+DWGygh+0sWig+TyT0ik0OrLkEd1Ivbso7jIaRpf2B/m/mxGxlIENMCZ/TE3cpdHC4e4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(2906002)(956004)(2616005)(6486002)(8676002)(36756003)(83380400001)(16576012)(316002)(31696002)(26005)(5660300002)(478600001)(38100700002)(8936002)(66946007)(186003)(66476007)(66556008)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzV3TjF6MjZmZWw2NnJyTkt1U2VYVGwzTUlSM1d3WlZkK1BiSnQxMUp5cnBm?=
 =?utf-8?B?MHIrc3RWMzlSL1FWbnNIZ2FCSXRJMDdtWk9lVTdocGROcjN1eGh5N0ZXNjBX?=
 =?utf-8?B?QmlxVFJPTWdBcXp5OG9Nek5Nc25GSkpvcWs3S1FSaFRGRit5Y0dsN042UnNZ?=
 =?utf-8?B?TE5wS1ZTWm5DbDAzcWJDaFVvcWE1VzNCZkdFNG5qY3JWbjFYSzVkWHRtSysv?=
 =?utf-8?B?SDE3NzhCb2xOVU56dlJ4Q042b2Ria2wwZDBBUWhWUmdoeFRsRGpNaFpHeHh0?=
 =?utf-8?B?NjRyYTJkUkxvS0g2cXNRWnB1UW0wZkhJTExCNUZKUjUxYXgwazRWektpVnV5?=
 =?utf-8?B?UTJFTGFNYlhSQXlldUR2ajA3QlQ2c0NFdEJSTE5FSldGZ05POTFON0J5cnlv?=
 =?utf-8?B?RjdLZWNCS3loNGVuWE5pQ1dESUh5UTcyWFNocGFLRFFwQ3FEais3S25KWmsr?=
 =?utf-8?B?UXhablI5VFlrWUhMMVppWTlMUnpsSHRTOEUwWlhnZ29XR2o2bERxSUVrNFor?=
 =?utf-8?B?cm00cHFtWWVZUEFlQzNjbDVsbkhQNTAremRnS0hZZnJBMERSWkpMTFQ0SmFO?=
 =?utf-8?B?YnNQWi91aHdGSG9JZml2TlF3b1I3REdsZm1PWDgzMk9ZK1d2MGtVcWJVS2tU?=
 =?utf-8?B?N28yYUZ2anNCMDBOZXBrUjIzUldSSVlZbnkrRm1UVjIxZlRvc1NkTzExdHZz?=
 =?utf-8?B?c05ZcWYrbG1XUXhncUZob0FVZUNQdXdjeExiZ3ZHa25oWXJiTVU2RXdKMmFU?=
 =?utf-8?B?bHFTNHJFZmk2UHZneHRFVXEwdWhLR2grV05TRU9QcDlGWGkzZUFBVXZpU1lZ?=
 =?utf-8?B?MnVyc0tXSW1QVUM0SERuK1ZTeHpuc29qVjdjMXhHQ2E5U1M4M1pHUkxuOVFP?=
 =?utf-8?B?ZkN2cmU0L29qU0puOXRtQ2FuTXdDQTdmeTNhakxwemZIQWlmSkxoWXIvZnEr?=
 =?utf-8?B?dmdDMHRWc1VGak96RmNMSm1qUXdtWUhEU2RtaHdIVHZ6WWNFNnBZZEk2OFZD?=
 =?utf-8?B?OGJPTldvU3pWa0tBM2VZUHA3cHR2VTZlY3c2TFlPTDhmZkNxR1BnY1I3SGZk?=
 =?utf-8?B?MVBwc3E3ZDFwL2psS3p5ZnNZMlBnY0RqYXQyRFNPSXFzZDB3TGdxMlNqQ3hz?=
 =?utf-8?B?dFRkM1AyemhyczJETmJZcGNtNXZPanhvd1FJN3JnZHEwTGg2bWRlWTRwaHI0?=
 =?utf-8?B?YnNaSXNWOE1uQkxuM25vbE96OVhaeXladzE1aXY1WDcwdzhraHpRSWs2NXdL?=
 =?utf-8?B?S3pSQks0ZmtkZFUzQzl0MzF2ZjNHcGxiZk5tcVk0SElOb1p2R1JXbnllQnJa?=
 =?utf-8?B?b1doais2ZHc4eFU2MWNIMTd3VEduUjMvMEJvajQ3YjBWVlBscGoxdVpkck5s?=
 =?utf-8?B?V1pyb1dkdmIrQmgvVURkeHZKcEJ1enU0cEppeUhocWx0ODg3elljUHFiZlNr?=
 =?utf-8?B?T3Z3V0hmelUrMjdGazFqVTNGV0p2bzVsSGxubkE3QldLaEo3TURabjg0S1dj?=
 =?utf-8?B?ZU5IeC9jMzAvQlJPTmNHWW9ITUVaZ1YzUUcxQ2huUXVtcDdCMkU4ZmFRVkZx?=
 =?utf-8?B?NVlJdzM1VFJlSXZMckUvaDZ1MUV5eGZwV1lhSGluakM1M2VKRGZmQjVtQnc1?=
 =?utf-8?B?bDlWajVnY0hhbWMzZk9mSXI0Z3BBSlZsQmlNSFZrS2d4Si9HVW5rUE5jcDg3?=
 =?utf-8?B?TnVTckp4NnRGT0xXN25yNUM4WU41azRCT3JyMEYrMWpMSWxPZ1BmWVp0ZkNV?=
 =?utf-8?Q?8FIBnFzz5UaiehTJx3ISU34+IfKrw/qpER7qd8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34156059-4568-4909-f287-08d95687d59c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 14:06:05.5914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjCT17j57phjDgzLNR9WWaBLpw1rOqQSse0p9lZ8LpNjQ5e19iVeaTiYshxKWYtJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>ping?<br>
    </p>
    <div class="moz-cite-prefix">On 2021-07-29 10:13 p.m., Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210730021321.7953-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">Get process vm root BO ref in case process is exiting and root BO is
freed, to avoid NULL pointer dereference backtrace:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
Call Trace:
amdgpu_show_fdinfo+0xfe/0x2a0 [amdgpu]
seq_show+0x12c/0x180
seq_read+0x153/0x410
vfs_read+0x91/0x140[ 3427.206183]  ksys_read+0x4f/0xb0
do_syscall_64+0x5b/0x1a0
entry_SYSCALL_64_after_hwframe+0x65/0xca

v2: rebase to staging

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index d94c5419ec25..5a6857c44bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -59,6 +59,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	struct drm_file *file = f-&gt;private_data;
 	struct amdgpu_device *adev = drm_to_adev(file-&gt;minor-&gt;dev);
+	struct amdgpu_bo *root;
 	int ret;
 
 	ret = amdgpu_file_to_fpriv(f, &amp;fpriv);
@@ -69,13 +70,19 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	dev = PCI_SLOT(adev-&gt;pdev-&gt;devfn);
 	fn = PCI_FUNC(adev-&gt;pdev-&gt;devfn);
 
-	ret = amdgpu_bo_reserve(fpriv-&gt;vm.root.bo, false);
+	root = amdgpu_bo_ref(fpriv-&gt;vm.root.bo);
+	if (!root)
+		return;
+
+	ret = amdgpu_bo_reserve(root, false);
 	if (ret) {
 		DRM_ERROR(&quot;Fail to reserve bo\n&quot;);
 		return;
 	}
 	amdgpu_vm_get_memory(&amp;fpriv-&gt;vm, &amp;vram_mem, &amp;gtt_mem, &amp;cpu_mem);
-	amdgpu_bo_unreserve(fpriv-&gt;vm.root.bo);
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&amp;root);
+
 	seq_printf(m, &quot;pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n&quot;, domain, bus,
 			dev, fn, fpriv-&gt;vm.pasid);
 	seq_printf(m, &quot;vram mem:\t%llu kB\n&quot;, vram_mem/1024UL);
</pre>
    </blockquote>
  </body>
</html>
