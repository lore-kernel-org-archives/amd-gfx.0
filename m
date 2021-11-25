Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682D0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 15:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC226E49C;
	Thu, 25 Nov 2021 15:09:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5886A6E431
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 15:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGvVAvthcT1gbE5MV7oCZOFkAsbim0vXFQYfE8EKZHd/21y7o64kajoxj5JZCPX6JU1Pm2ELjV4yOYL62meHdulDYm9h18apbtl5k3FVD7OGkCGUeB62zknbtFmm4ZvH7i7S0RuTQHq1u8iUisQnNY3CptlYGS1SAz5CLH1UIidDemsBGhGdc5mPfic9Id3hLBoslCop82mZ2Lsz1NttljfrLN5fxPckhBgSCvacU36EaIgWk6/PCjltKWLbFnrJFtSEH98Y9uknXBvzspan+L8nT4UNE4ZfJfEHHN1MGr7ZaUyjJkuh8E0CNm6Rn5Yuq6EFJuXWG6SxUb1lDk1LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYTUT1wJqALcIpKNgH/NIcPDFLqdR2cIhXMTtUAw2J8=;
 b=jQdtL1KCbbedm2RtJKDFVvVnVD/NM9w4x0HLVe6t2GGNmk1EBq8L0HaHe0LZp0t9ISOMUwUCbWHMDdZK2uRIvdvDrm3NfW6DrLYD2/vKHAPfKeomvRISNvFzqGdmynGkg5b22zUoD4AJzCKlZSGwuZplhOeug6qRPc+/l4IZOH4HSCGmpccSHCvnV/gE0aEO+RQ8eIV4iW6PwYnj5RiV2ZehE0KUP4nuDBcH4vSwjxave22TBWfb+63pAZmzqxiTafeHULrqwwlRvLVEj6T06c88+Xv27biuHCaZp6POyhhpZ6vhf5W4OIM5/Kvnh1vx7ZuJkOkv5Gel3kPLxc7LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYTUT1wJqALcIpKNgH/NIcPDFLqdR2cIhXMTtUAw2J8=;
 b=ZTvkNo03qIORqUu9At6pgoGUfLdefPTD0LqgIF+V+XtYu3QxXkmwWe6WDR9tjyRj1r1RgEv9jyw4JqpwB9Gwz6/E6ov9/0TtFulg79VXrCe8He1Gi+gLJnVypdTM0Dd/lOEEwQEK8S9U4v38KGO6NJHDSDrLPCYhO9hwBPBYW58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 15:09:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 15:09:25 +0000
Subject: Re: [PATCH v6] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211124225827.26232-1-Philip.Yang@amd.com>
 <dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <75008e5f-ef7b-4ab0-cf68-19efbbb0b649@amd.com>
Date: Thu, 25 Nov 2021 10:09:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:208:2be::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.8 via Frontend Transport; Thu, 25 Nov 2021 15:09:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8617efbb-3b5d-4624-a37f-08d9b025918c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5181116EC8F3D2008AC06557E6629@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzTEVmpE5VAfdpqCHl6+BboqZybCic1i8YS5yxU6YMr2bD5vex/M9P2s6M+wMHhRTEiuwNNoI/moVmYecgRBHZaJXqqqOTgYxo3Clu2qheEVbWRwFuaSeM4kXTY9N2Up3COLoGW8tEOa2jxJKcRt1vS6N3XT21pG7fqvpz+GCt8ndB9DOe3rFi3w9+AB534ZbWoTW3t1v6DrE2LaeS0zz7JgoZFjE405Vr9XLGUcpcxeL1Ttbvr8PLZvva1t4KiEweMBGLtM4C8hTSOijSVl0TzEOXhxz/qTJ9uLwIW14/gDo1msOj9Ph50K9XhoMvWp2NJbJwJsw8i650vr86kE0vpnEuZ0HHGPuwhZPF8L5ViWKsScg1W9I9S3LadvjunNnV3NZ/9ARqsQg3z5tPUnVL/XrZ6RW403/7tTlonkvx0MSj9e9TU2RHT2MO8TL0a7PJvhWWSMNIDTcZdf3YV9RmTSHvhXVLsISqUwCBFKd7VqnRNcX6UdIkNJ8u360nMypnLw6eki56axdze+wfBK/m1Y6EXgfrAYk+jYnOwW1E2k6rZPAN/sGAE0gGxSGuyGb2gWbs/gp3Z2rWGNNfNtfuvKD+LHdFOESqMKR0fm4LT1ceCUwqvIWP56ePb1SxcScaKRswRW1MPvlN5BYRClL+Skj/Lw9mhObkbiTIchsPGHVMwyTwPttjKaoy06ruZEYB+oRV+NYO460A4VckkayDUxTXsvtcspwUXdRgeGWPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(956004)(16576012)(186003)(2616005)(8936002)(36756003)(8676002)(316002)(6486002)(31696002)(5660300002)(66476007)(66946007)(31686004)(66556008)(38100700002)(508600001)(4326008)(2906002)(30864003)(83380400001)(26005)(53546011)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hXMXhxZDM4K2FqVCswYVlQR0Z1UzIwZVhSMzdNRmJqUFA2K1BraWU5aVND?=
 =?utf-8?B?dVBRMmRKZllEeGFDM1VBb3JHbUtUbHdSRWg2ajNJTGpHd2xpVFNndk5aYk5h?=
 =?utf-8?B?WERwMUhpbTlwWTdNWlExR3pobEcrMDdOdmo4N1UzbDgycTBRbHE4cCtJZXJx?=
 =?utf-8?B?Sm5tRytZOGFkSjhWcVZzYjNwekVDOUVjNjdQTlE2cDkvM29pdEtDdW9zK0kv?=
 =?utf-8?B?ZHQ5eHBkS1BKSlMwQlVpbkFqVnFxb2l0SVR5Ykc3Q1ByZ3hqMDRFZTRYdjVj?=
 =?utf-8?B?ZGxUQ1htaUpJaTF2clNiRkJTTXhVMjg0ZUc4WkEzVFlrREZMMmZPNkJGdnRh?=
 =?utf-8?B?Mi91akY4SzZLQ2djOE9JenkwKzUrd2MwNlphNSs5T2NaRkJZUGJOdDZRMjhG?=
 =?utf-8?B?L2FLMWIyTXkwREpBOSt2aXpyL29PVDZVOGVYL0t0bFdnbmthMUJldjB6N0J5?=
 =?utf-8?B?eXhFZjVnWHZtVXVxVjUxQ3d1eEtvZm84ZnUvUzdkNC9LSGV3UjZDS0wweEs2?=
 =?utf-8?B?a1JBVmpsdnRQL0E0YnlaQ1R3UUJYNlF3L0xETEhFL3F2angySk8yeFJoT2JW?=
 =?utf-8?B?N25MN1VEb0dJUTdDQjB3dm9Oai9qZ2lTUG5FNFpId3pVTnEwQTV2ZWJ5dEhZ?=
 =?utf-8?B?VjBhN1d0dHhxWklhckFqdTY3SHVRUktJRDhTcEFTeGhkbGtoeHhGOE1BKzMy?=
 =?utf-8?B?NVVJY3N6Ynl6MmhnUWpnY3ROSDFnVFUyeEZOUjNlZ2t6djVWT2VhKzhIWEJQ?=
 =?utf-8?B?MkdUZC9YMld4ZVhQT1pUL1p6QjMzS29oblEwMlQrRzRwU0dud0l1T1RYVitj?=
 =?utf-8?B?L0hpNDBTUHZCdngzQ1ZOdDNBbExJREI0UWI1bEt1ZE9KaTRqOFVNSkJHWDda?=
 =?utf-8?B?QTNJT3YwcVFjcWlXeWR6NVRvaW8rWXYyR243MHVOZkxtb1RQdTVXdFBjUTFk?=
 =?utf-8?B?Myt1ZElMbmFFS1ZvckZPdVBzWjl1WmJ0TFZpODhjUzc2cXhCazNoZzFVejVM?=
 =?utf-8?B?bUNIMFl3dVBaZnYrbHF5OTR0TlZUbVFaU1B6VTl6d0hPYkFqbXc3MTFUWjhu?=
 =?utf-8?B?NFpnVUVxbGg0T3FuRUtlN3JtYXFla0tQd2cxMk1HNWxBR3VSS1haQy9GZmRT?=
 =?utf-8?B?M0ZMZys3ZFZTMFdjNTRVRUhjM05NdVo1ZXpvZXZIdUtqbHpqMHF5SHkwVFBi?=
 =?utf-8?B?Z29qMUJ6cTNMUStLVURtRW1KZHFEOE5USnkrYjkxZW1IenkrZCtuZmIxVERD?=
 =?utf-8?B?MHJScHIwWmhCNHV2eWlkcnVaQVNHcmlHL3orM0E2YktDV3JJem53YVhOQk9R?=
 =?utf-8?B?VitSSDBqaFp3WVFibHgzczMyU1NjOWYxZmxEdnJRZWFpdEZ3SjdlemZwaVgx?=
 =?utf-8?B?OTJ6U2M2bjN6djMwNHlJemFSdEZ5Vjk2RFRjNGl4ZzVmb3dEMkI2d3VNWllo?=
 =?utf-8?B?bnlEYUJTelBkaEhCZDRSdlVBZzBnVDYxUjdDd3BPUHlkMUt6MjBjZEF4cHVM?=
 =?utf-8?B?RWhkNGdENml4L0d5Z002NlJYU1FwektUUlQ0UitrTGU3NWxRc045SVl6Z1FZ?=
 =?utf-8?B?a2NYWVBpeWZzM0ZuRTJSdnhGdU1jeTVwM0ZtbDVkc0ZkVFRTMk9xMTUwa0pa?=
 =?utf-8?B?TFRrNStpWWQzcTFHU3lZL1lwdEpOWTVoN20wQ1lwZkQrWWd0WkRnSDNTSDRq?=
 =?utf-8?B?T0ZyRXJTSFNLYWxvb1VDVmpneDRLTHJETENvcENEbjNCamhiR2cxMTNHRG41?=
 =?utf-8?B?YlVBcGpPQVdlTWZPKy90c3h2VEV2NzRuYzN4R1lJTjVaQWQ1TWJQMGtuNzFZ?=
 =?utf-8?B?UmpSeXFQQkUwbHhEdGtYb1A3SHhYbnRLdWpWbmhJaXoweHNyMXVDWHNYdkdH?=
 =?utf-8?B?MHJDbm5RMGpsSnR3UHIwbDAvOEIySHo5UkMxUTVVdW9ZeXMwZUxjM2d0TjZL?=
 =?utf-8?B?RE9YV3djT3BYYlhEMmpGNnVuTml4TVF4d2huUUJ1NThBQXNWb2tWMjBDRTQw?=
 =?utf-8?B?bEFwdVp4V0NrVzJkdmxzUjlubDE2TDFDcFZGZ2V3VmltbExoSnl3WVVrM0lX?=
 =?utf-8?B?RHJwdGZRQi9VN2ZuVzhkMmUxVk4xcnduZlJoWUF5T1JrNXRKcXhZU2ZMa0pw?=
 =?utf-8?Q?tTqk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8617efbb-3b5d-4624-a37f-08d9b025918c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 15:09:25.5740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR0q4ngFpQvBbGuKsC538m7olkoAjxttduz4D8gdGdq1VUYOuvIf2MBZZ6ZE5P5n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-24 8:56 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-11-24 um 5:58 p.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">IH ring1 is used to process GPU retry fault, overflow is enabled to
drain retry fault because we want receive other interrupts while
handling retry fault to recover range. There is no overflow flag set
when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
and drain retry fault.

Add amdgpu_ih_function interface decode_iv_ts for different chips to get
timestamp from IV entry with different iv size and timestamp offset.
amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.

Drain retry fault is done if processed_timestamp is equal to or larger
than checkpoint timestamp. Page fault handler skips retry fault entry if
entry timestamp goes backward.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 58 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 16 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  2 +-
 8 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 0c7963dfacad..3e043acaab82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -164,52 +164,32 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
-/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
-static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih,
-					uint32_t checkpoint_wptr,
-					uint32_t *prev_rptr)
-{
-	uint32_t cur_rptr = ih-&gt;rptr | (*prev_rptr &amp; ~ih-&gt;ptr_mask);
-
-	/* rptr has wrapped. */
-	if (cur_rptr &lt; *prev_rptr)
-		cur_rptr += ih-&gt;ptr_mask + 1;
-	*prev_rptr = cur_rptr;
-
-	/* check ring is empty to workaround missing wptr overflow flag */
-	return cur_rptr &gt;= checkpoint_wptr ||
-	       (cur_rptr &amp; ih-&gt;ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
-}
-
 /**
- * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
+ * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
  *
  * @adev: amdgpu_device pointer
  * @ih: ih ring to process
  *
  * Used to ensure ring has processed IVs up to the checkpoint write pointer.
  */
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					struct amdgpu_ih_ring *ih)
 {
-	uint32_t checkpoint_wptr, rptr;
+	uint32_t checkpoint_wptr;
+	uint64_t checkpoint_ts;
+	long timeout = HZ;
 
 	if (!ih-&gt;enabled || adev-&gt;shutdown)
 		return -ENODEV;
 
 	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-	/* Order wptr with rptr. */
+	/* Order wptr with ring data. */
 	rmb();
-	rptr = READ_ONCE(ih-&gt;rptr);
-
-	/* wptr has wrapped. */
-	if (rptr &gt; checkpoint_wptr)
-		checkpoint_wptr += ih-&gt;ptr_mask + 1;
+	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
 
-	return wait_event_interruptible(ih-&gt;wait_process,
-				amdgpu_ih_has_checkpoint_processed(adev, ih,
-						checkpoint_wptr, &amp;rptr));
+	return wait_event_interruptible_timeout(ih-&gt;wait_process,
+		    !amdgpu_ih_ts_after(ih-&gt;processed_timestamp, checkpoint_ts),
+		    timeout);
 }
 
 /**
@@ -298,4 +278,22 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 
 	/* wptr/rptr are in bytes! */
 	ih-&gt;rptr += 32;
+	if (ih == &amp;adev-&gt;irq.ih1 &amp;&amp;
+	    amdgpu_ih_ts_after(ih-&gt;processed_timestamp, entry-&gt;timestamp))
+		ih-&gt;processed_timestamp = entry-&gt;timestamp;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'd call this &quot;latest_decoded_timestamp&quot;. At this point it hasn't been
processed yet.

Also, I think it would be safe and cheap enough to do this on all IH
rings, in case someone finds it useful for something else, e.g. using
amdgpu_ih_wait_on_checkpoint_process_ts on IH ring 0.
</pre>
    </blockquote>
    Thanks, yes, vega20 uses ring0, do this on all IH rings.<br>
    <blockquote type="cite" cite="mid:dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+}
+
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset)
+{
+	uint32_t iv_size = 32;
+	uint32_t dw1, dw2;
+	uint32_t index;
+
+	rptr += iv_size * offset;
+	index = (rptr &amp; ih-&gt;ptr_mask) &gt;&gt; 2;
+
+	dw1 = le32_to_cpu(ih-&gt;ring[index + 1]);
+	dw2 = le32_to_cpu(ih-&gt;ring[index + 2]);
+	return dw1 | ((u64)(dw2 &amp; 0xffff) &lt;&lt; 32);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 0649b59830a5..dd1c2eded6b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
 
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
+	uint64_t		processed_timestamp;
 };
 
+/* return true if time stamp t2 is after t1 with 48bit wrap around */
+#define amdgpu_ih_ts_after(t1, t2) \
+		(((int64_t)((t2) &lt;&lt; 16) - (int64_t)((t1) &lt;&lt; 16)) &gt; 0LL)
+
 /* provided by the ih block */
 struct amdgpu_ih_funcs {
 	/* ring read/write ptr handling, called from interrupt context */
 	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			  struct amdgpu_iv_entry *entry);
+	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
+				 signed int offset);
 	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 };
 
 #define amdgpu_ih_get_wptr(adev, ih) (adev)-&gt;irq.ih_funcs-&gt;get_wptr((adev), (ih))
 #define amdgpu_ih_decode_iv(adev, iv) \
 	(adev)-&gt;irq.ih_funcs-&gt;decode_iv((adev), (ih), (iv))
+#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
+	(WARN_ON_ONCE(!(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts) ? 0 : \
+	(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts((ih), (rptr), (offset)))
 #define amdgpu_ih_set_rptr(adev, ih) (adev)-&gt;irq.ih_funcs-&gt;set_rptr((adev), (ih))
 
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
@@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
-int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
-					struct amdgpu_ih_ring *ih);
+int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
+					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
 				struct amdgpu_iv_entry *entry);
+uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
+				       signed int offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..b129898db433 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -119,6 +119,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 		}
 
+		/* Stale retry fault if timestamp goes backward */
+		if (entry-&gt;ih == &amp;adev-&gt;irq.ih1 &amp;&amp;
+		    amdgpu_ih_ts_after(entry-&gt;timestamp, entry-&gt;ih-&gt;processed_timestamp))
+			return 1;
+
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This check should go before amdgpu_gmc_filter_faults. Otherwise
amdgpu_gmc_filter_faults may later drop a real fault because it added a
stale fault in its hash table.</pre>
    </blockquote>
    <p>Will use Christian's idea to add the check into
      amdgpu_gmc_filter.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..c0d9b254bbb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -535,6 +535,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 		}
 
+		/* Stale retry fault if timestamp goes backward */
+		if (entry-&gt;ih == &amp;adev-&gt;irq.ih1 &amp;&amp;
+		    amdgpu_ih_ts_after(entry-&gt;timestamp, entry-&gt;ih-&gt;processed_timestamp))
+			return 1;
+
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Same as above.

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 38241cf0e1f1..8ce5b8ca1fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs navi10_ih_funcs = {
 	.get_wptr = navi10_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = navi10_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index a9ca6988009e..3070466f54e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs vega10_ih_funcs = {
 	.get_wptr = vega10_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = vega10_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index f51dfc38ac65..3b4eb8285943 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
 static const struct amdgpu_ih_funcs vega20_ih_funcs = {
 	.get_wptr = vega20_ih_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = vega20_ih_set_rptr
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10868d5b549f..663489ae56d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms %p\n&quot;, i, svms);
 
-		amdgpu_ih_wait_on_checkpoint_process(pdd-&gt;dev-&gt;adev,
+		amdgpu_ih_wait_on_checkpoint_process_ts(pdd-&gt;dev-&gt;adev,
 						     &amp;pdd-&gt;dev-&gt;adev-&gt;irq.ih1);
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
