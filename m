Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4171BC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 16:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4CC91E1A;
	Tue,  5 Jul 2022 16:56:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DD591E1A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 16:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XssI52Hc/pvf2XoPJA17i5/5s1lakvNH6ujLTFj78SbdXUOFXTYY2XDC03RQiRPKtk55h79EUw1G8u2pE3Zbjqaxwci3KTXXJczjXL+cieOL24tuwgYn3zC8v2OYORTX4V+xT63oF8O7/NDZLC1N4sS5k7Arj9ALkYHGyAH1rlMctX11wFvslxqHivfERFMLNcbYk4hU7FYOZAsf2x7URU2SO5vf1Pr7ovRRnUQZMeHxbUqv6tUNkdDu1C5JtCf/P1+wdAT/pSZrN3/1S0akWCNL3VI883TTnd48xF2TkxvUgAql1UdDbNrOhpM9JsqoRlOX+UJY+mRK07rvkL23Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feFzPcJa3MmicGMgXwsWjXNuhieRLhf/kYcRfgeriMs=;
 b=JbTewJTt4G3wCpqw8CrIldPuLNzRxccbix4E1b69Fdg2rkPyndQHeM6jcmA1xWmT4seS5N8WoR++FrYOzSZjizXo6zqACATqiZ+QP27bm3vHouVVs/HkFPGp1LhbCwUA7/XidYNJ8uqd+H2bikOcEqJrzStNC9v+lAEVNiF9esWOi3sN+qZr20o0/7pm6hyjR/F4V8/80xdgxcmCOqK2ZgMp/x3MKKlI1B/dDb45DEH3ohI3kB9IQo7f9K1pois9jJiBgyp0BRFuKpHRaXiPHQRNswslZB7WmiWO8hPuTE3YIVYErGm46wvcWDtGgCandsMDaECUXtWOvX53kaCImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feFzPcJa3MmicGMgXwsWjXNuhieRLhf/kYcRfgeriMs=;
 b=5reZahNBsshb/xj3UgGkL2p+ME2TGaYALe11EdctZxFEPCmPcAVv/GOibOZZfa74e6fTncRYc5s9qvxBxh0a/pYnMjRYgXac1cw6M4zHth0tgGC/kUCuNg/LE5wB5BGxRHL59zzAzMBRljoImD0EJARYimsJL1IlnxGjVhvbtuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 16:56:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%5]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 16:56:43 +0000
Message-ID: <d41bcda2-bcc3-cc51-f3da-0b316415ec72@amd.com>
Date: Tue, 5 Jul 2022 12:56:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdgpu: add debugfs for kfd system and ttm mem
 used
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628002347.3982-1-alex.sierra@amd.com>
 <20220628002347.3982-3-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220628002347.3982-3-alex.sierra@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:610:cc::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026e739a-a078-45fd-5b4c-08da5ea7565f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hgEA+x/eOViH4Dgyo7IbmC7QyleJbLw9ZrLI1rkV4RQO9EBkikuFDjxFEXe1rSz+IYIKDnfkfCUqAIWDbDQ2l4TDEKPOaLSDLDGxzdVlJn5KDO2/8n/ywNQOVCWcay/3d2h5uhPNH7f4b65St9JVZ47vcoU5yRaTiq/NGeF3abFIGsBGgEr0Kt7CwMX5zVnoPuZYpPLSkeRhHKYISd0/BBEkaRgdEIeqDxI3aqT8S7faI2sDOzHF3WgO/dRdDBRdUkn6TaRp9fck7u5AqyeTmRA5z6oaZF+Wy41+nn9giu+8JegIDC3wShELEzriz90wZBs2DTh5NhoaeaMNMQj4a62K+ybO7V6EdKKZ5Uyo3htGAgslR148/3P98nig5e3tBxaF/daW1LGqRpFu0O/uW1/F6vI0VqD/SDay6Qz30Sq3iW68JAsCYvYRCDIlQFlgJVgbcGz2AtYLv3dH63es2KanUTmj7Jzm8Bqg7eWGZo+FzMqd2gJI8Ezh2kf2SEp41n0afU8v26Opjv7ssYKbqJKJ65ztOofu7ercJRwPwOebfstPTqlfobtlRz9kBDSqNjkXJtS9s6EAS0gMgGoiXroIsGqC8AsrqsILeizYdGk65WC0a5Iab1yk6JGnxclsR77s2DyI975k9joTPLXWexM8xVhI/Kkez10QQlM8SA0fGAO0yECxhKCTgt3oN1vYV/MIP/Cg4LErpKjh9D086axP3/I3yc9O3h35uWR73LiihKTOe4RF+1H6SZ+FHHuYfTioE+m+sZANp9VsML7ESfEXeGKxoP0A8jV/86DQVJlPqGLDk8gpYouFRhJiJ7GrHKAtA4B5E0RoocUNdD8UhVW1/YMqanOgbHcjV/yzwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(478600001)(6486002)(41300700001)(26005)(6512007)(316002)(8936002)(5660300002)(31696002)(53546011)(31686004)(186003)(4326008)(8676002)(66556008)(66476007)(2616005)(66946007)(36756003)(38100700002)(6506007)(2906002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEIrSkNsN0VJQ095RGwzSlczRnBpNG9WVVJsZkhtek1wMk80UU0vUDZhOTNl?=
 =?utf-8?B?T3I2K1p3aHpJUkZtaTFRU1hhYjJuMml2bVE0czRJbDZoWHhtV3hHWWlmUlMx?=
 =?utf-8?B?YmVuNWVMVjRxS3V3ZHV4Lyt6TEgxMnZWRUNkemxROGNNa3dVZVNGMytmRDg1?=
 =?utf-8?B?L1IxOXdnakdvUldqVXlKUTltOXpkTnVlVDNQalNpN1VkVEJEQ3ljd0R0OWNN?=
 =?utf-8?B?enJUK3NpRkhWamJXVXlUaTdGRVZqcFdaLzVzSDRPOTBvUElhY3pPS2FDdUQ2?=
 =?utf-8?B?ODU5U3ZQSFR4RS80L3lhS0tJTXBZWGwvMy8xTzNJTm9KMUdCSUFLNHJ0aU5G?=
 =?utf-8?B?OUVjeFlNR3UvdVk0OVN1cHU1SDcyUS9mU2xxZkNPcVhtNjI5ZWRvWWczSWdY?=
 =?utf-8?B?MWNSUDVMdGZ2YitUZUdjZHlnWDRoYWt6TWwraHVzWkIzMEJhUWhhWHdWbGt1?=
 =?utf-8?B?TzhYbmpySXNnSjJXajJQVVBrWlk4ZTEyZSs5d0d1QUZDZ2ZwUjRJRzM3YnIx?=
 =?utf-8?B?aW1vMENUQmVVS2tBcm4vSjRvVFoxWUFlK2w2bmR6b241RTV3YTZpQkNKT0lP?=
 =?utf-8?B?NFhwS0JhMWN0UWwzY0hZazhyeDF3ZVNSTmVDMS9YUFJGSk9LMG9NZkNUdGx5?=
 =?utf-8?B?cXRlbjR6N2hEQzNsRCtiQnBWazd6Tzh4WUFVcmZxKzVJY1ppSzZ2aHRYUnAw?=
 =?utf-8?B?bDZjZFNXdWNodDNLSGpxVElhMWhGZHk1Q3gyajMrRmxBdlExdXlhZFRyU09R?=
 =?utf-8?B?a25NeVh3NnY2b0I5amlMMkEyN3JEbzBORjRqWi9aUVM0eWJ2eWROSEFJc1Ew?=
 =?utf-8?B?YVdMK3hIdTB3RnJuWkNXTFliMDNiVTRldEoya1h4NUVzVk1Odjl4TmtnakFy?=
 =?utf-8?B?a2dOQ2p0SmZQeVQwdHJTdFJQcG1kTVNYY01LNWJVQlVVanZqQkRkWkxPNGV3?=
 =?utf-8?B?SDlISGtSS2xlaTFwaG8vOFYzZ2xDZzlyVEM0Z2Zybm9QRFFSNG5hL0RTY2JN?=
 =?utf-8?B?c0p5RXhjQkhBQW9QL3NYdURJczJRaVlPLzltSml2ZzFoZEhYWVJ1eGRkOS8x?=
 =?utf-8?B?UXNMZ1dNZmtmN09vdEhuSytsTi9kUm9ScXFLMkR4UDduZkw4Z0lkdVIrZVp0?=
 =?utf-8?B?QzBCNjV4UGRHM3E3SVVoMGZnS1dRZXRDT0pYdWJ6ZHdIaGFSQ0ozazJPUWIv?=
 =?utf-8?B?ME1yWmV0eHYvdVZ5Qm56OW9ZcEgvc212SXBrSm9PeThVdW16OENmMzJqNGx3?=
 =?utf-8?B?L2twcDBEQmo5THJJQ3BTOGc0dGpGMjY4Y3hxN2lGa1hFVzN3cEhpZVJ1S21o?=
 =?utf-8?B?NzVnRm1tYUxBcklLdGdaaXI1aEU3VzdZTGlBbjlmd2l0MnNRY05aalNGN0Qz?=
 =?utf-8?B?ZmllbEtvNllFbXlMNU8yZzJFczZxQ0lvVmdnS1NENzJhZ1FKNk1rbUxtdnF5?=
 =?utf-8?B?SldrNFI0WldQTXY4OVNEVjR1S1B4TU5LK2s5RDdVTDl0ZVk4c2NoVER2SnZF?=
 =?utf-8?B?V20zRklxWkYxVW9FQU03Um5xeDZnRXVqa09kN0JrYmlRT242SzdBV0o5WWd6?=
 =?utf-8?B?bnRHbkFIQ2Zsa1RITTZUQXl6dVhkeDYwWWQyUklaZk10d2hsc2J4c0hSdE40?=
 =?utf-8?B?UHRnSGlLMmpuVTV2M002SVBFVGJZeGhTNkFzWDJMZWpWRCtpRWl1UGtGNG5Z?=
 =?utf-8?B?RG9HbUExMlJnWnNXYzlVaDBzZDhRTmdMR1hZemZJMCsxVFdLL1NHYUlVS2Yz?=
 =?utf-8?B?N2JmOUVodGlkak4zbmxHanF5em52SU9UU3BadWFMTlhKN01QaHdIVVhRcnRq?=
 =?utf-8?B?bytHcXo1dTFsS1ppdk5GMTRDdkhQRGZ4QmZQUVgvOFMxSU1lM0xPUTZoWWZy?=
 =?utf-8?B?UUkxUFJKV1lCc2k2ZGdGV1BFM213K3hZOHVWZDYvQ1hkSjNqUmpmSS9FWVNS?=
 =?utf-8?B?SkJBZ2xPODRtcjVETjAzRU4zTFRwVEowdVJhM0dRWGptZHJUUmNGYkI4V1BT?=
 =?utf-8?B?VTVHUjViWUxNY1VWOWdHV0plN08vNGJEdGptYnFGNDZRYVlRV3B1Y0U1Wmow?=
 =?utf-8?B?NkJiYW5Sc1l1SzJpTCswUnhYK0tKd0pjYVEwcXQ1SUNZUnN6RVM1R1lSZnJu?=
 =?utf-8?Q?MLq25EwJ/B5JLGIoEa3YeucUy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e739a-a078-45fd-5b4c-08da5ea7565f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 16:56:42.9561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE6UGqG1yW3mjTFbtMEXpoWfEpNAPq6vGxwLKHUW6eiC08MXypTCFdZNX7XeuDMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
    <div class="moz-cite-prefix">On 2022-06-27 20:23, Alex Sierra wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220628002347.3982-3-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">This keeps track of kfd system mem used and kfd ttm mem used.</pre>
    </blockquote>
    <p>We could also dump vram used by checking topology_device_list per
      dev-&gt;vram_used, but it can add later if needed.</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20220628002347.3982-3-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e6244182a3a4..53cdf7f00b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -172,6 +172,9 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
 				struct svm_range_bo *svm_bo);
+#if defined(CONFIG_DEBUG_FS)
+int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
+#endif
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9719577ecc6d..c48557b683c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2935,3 +2935,22 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 	}
 	return false;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+
+int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data)
+{
+
+	spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
+	seq_printf(m, &quot;System mem used %lldM out of %lluM\n&quot;,
+		  (kfd_mem_limit.system_mem_used &gt;&gt; 20),
+		  (kfd_mem_limit.max_system_mem_limit &gt;&gt; 20));
+	seq_printf(m, &quot;TTM mem used %lldM out of %lluM\n&quot;,
+		  (kfd_mem_limit.ttm_mem_used &gt;&gt; 20),
+		  (kfd_mem_limit.max_ttm_mem_limit &gt;&gt; 20));
+	spin_unlock(&amp;kfd_mem_limit.mem_limit_lock);
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 581c3a30fee1..ad5a40a685ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -101,6 +101,8 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_rls_by_device, &amp;kfd_debugfs_fops);
 	debugfs_create_file(&quot;hang_hws&quot;, S_IFREG | 0200, debugfs_root,
 			    kfd_debugfs_hang_hws_read, &amp;kfd_debugfs_hang_hws_fops);
+	debugfs_create_file(&quot;mem_limit&quot;, S_IFREG | 0200, debugfs_root,
+			    kfd_debugfs_kfd_mem_limits, &amp;kfd_debugfs_fops);
 }
 
 void kfd_debugfs_fini(void)
</pre>
    </blockquote>
  </body>
</html>
