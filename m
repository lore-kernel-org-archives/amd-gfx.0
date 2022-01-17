Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E90C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 16:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FD910ED0B;
	Mon, 17 Jan 2022 16:16:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4E710ED0B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 16:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiFmCnNr4T0SMYOSVbBEYZOPH4ubOsX13IKO2CXlTU8fee/XmqVFZyjjQIHHqk8eKHJ3JlTVomTpdsCuwzHWgm/sXbKxMZGgGayym5/zwKYw7alBXZcoil5eha+Uyh2nyAI2R4NdsiBrH//aYow5RAXw/3mNzMoMXcVeqCD6PwzVMdOo5DzYQaF8a9JRHO7nOxDbi/ficisHSR0zGdyM72YlUcyu+ZNGOUX0D1hsMkOo30QkVHhpyT5bGh65oF36mNPy11eXCkvjrgPTJfTy2ceAw/bzKiPh7G6YKZGXpKdEH/7HfVGL94L8ct51itcynLDTHraRqsfldaa3eTmgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPy9nnurccOKSr4KV95OyRr8MZvIOL8ti2/duveyQ1o=;
 b=dQ7u3vsMot7EgLidFmKmkpKDAchtrukNFJiLCf0n29FuQIhvf20ouzDsPs1RA98O5L57qYM3hD0f/HrpxBSzG2bn10u6ck++YZqRXgsz4IiuPCTxw0woVOidcojuj5p5NuwnB+p/8kDI8EEwLwitoXhts5v46OD7nWcrPWv/Txa+h4w4tl2JHPPyUqpnu10UHax0JPW/wr6Rwr2q8/zoV8FUg1yuYZVQxfOGgFD1KF/wRSL0R1VEUe3L/MCJid5kQPEJ4z+TDM64qKl7vrc+4qPQO7O0IffMY2qEZPJufhvdsXyTtxrZJ/kbNoTzwT/yRaMSCA8X+EXlYUjER5nc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPy9nnurccOKSr4KV95OyRr8MZvIOL8ti2/duveyQ1o=;
 b=ouqUJowifSvPlfxktkvUHZVhmU5eBVfbUq5WZQnWU6LqVsyvzXr3PIqN+Ixfz9/OTwsdJ/sVTN86Rd8ROII8bgy37he1VUGAXKOyT6dTSM0WXiWoj+k679E6EilWB5KmcjVSQrY68SKLdG7mUQtDR+brNn+UM1L4QDHYul3Wryg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 16:16:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::14cd:f56f:bac0:a862]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::14cd:f56f:bac0:a862%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 16:16:05 +0000
Subject: Re: [PATCH 3/5] drm/amdkfd: add page fault SMI event
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220114203839.21707-1-Philip.Yang@amd.com>
 <20220114203839.21707-4-Philip.Yang@amd.com>
 <47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <3089a563-d1ba-a509-9e1d-a4dba3bf3ddb@amd.com>
Date: Mon, 17 Jan 2022 11:16:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17c5fc0f-2551-4709-1f60-08d9d9d4a95e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4360BB7B545673264AE81A0DE6579@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OFbp9O5zPgRGj21aZhweafr8CtcAT+xT3+Wwz+szpk5FbFZKyYknA27kvgVqIC0ssseYsz6YyXZPy8LHVe9tzWtTG90YWE4WzFdjzRKyKekdxuiD1mcdOg9aLHoI/DIzL+y/GTJEpCOn6h15+QO99CcMsBAZ9OVR48AcDsYucHCHbfngcRQaZSsfNdWQd2ssvdmkcUtXPVNY8X6Q+B0kEtxf4Hezk/Y8juIMUBP0ks3UDJQGgtB3LzzD6PI/Nt5ab5/bK+V2fzu2yd9V4FgvZLuntrZW1K5a3+QlEMo9dQ6Bylt5sK2hVLHk7oHzvFnscrfzsnvJQRqSBXD5uMvM68D3LZiyVJj4j9zB6Src44tEM6dr7pzFUC62DE7WyB8osRKUh2DTKyX4WUD6CMjsEuaGOZU4iC2EKsLU/EZGy05iuisw5P+qbJQqKZU8yRg+y7bR7nSB8tm4r+/4RRK+lwnEXcP2aPARSeRlfl56NHw6ROel8co8s0IKhKIGBG6xEB5weV/Dmsc9m++S6CRDwmxoOOoj1SDcT+DIuxFfP54mg9V6ivJYwBwPBE+rfOXoJQssotUt7LKizhF2vcKebWeJa3vBG+j2v26DOlbPPKbSRapkaeUAlxk16u6LCDqI5lzyyiFJMIEtbV8Bl+aNbr2L/jrpPSnC10WMGlpPVm3ztLiVvdhfAIMpREloIBHQnrOdDHiZuOf5SPNTGLbzz05kyIeOI3h0+c6PbPz4EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6512007)(2616005)(6506007)(53546011)(6486002)(5660300002)(186003)(26005)(31696002)(36756003)(38100700002)(2906002)(83380400001)(66946007)(31686004)(110136005)(316002)(8676002)(8936002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZuWFJUejc0aEtuT0Y3SmpWNjVsTUErM2xPM3hlTVNFWXNibFNVVHpoQ1Zo?=
 =?utf-8?B?VUlWak1WVUxtd2RXbjU2VnYxZitaNEZDVEpyb3VyTHdsN0ozQ3pGRmtlS3FL?=
 =?utf-8?B?eGJpWTZaNVBzY2lyM29UaERzVWN0QVRnRGZSSStmTzNPTjVzWWJYOTRtNVVF?=
 =?utf-8?B?MU1GbGM4eEt2TTJlU28xTERpVzlNWi8zMlJweTJOb0lJRUVRWHRHYWp5WGZz?=
 =?utf-8?B?enBib1ZzWDNtZnl2b21DeVY0Sm80bEQydklNMXlIbkM5N01SZDZiMXp1eStr?=
 =?utf-8?B?ZXJPLzNITVd0NHVHYU94RFhIOTBLWHdzWS82dzZCMU5ZeUJSSUs4YnR1VFdF?=
 =?utf-8?B?azBwb28yY0FhbTVzY2p2L2k3bEpaYTVaTVgzZWFwZVB6eUY1UkU1dkJyeHcx?=
 =?utf-8?B?UVNlaUFKd0N3UVlMZ3dUL2EvK2VQblFFd05OQWpYOVkzeVZBSkRCUVZwZ1VJ?=
 =?utf-8?B?eUNnNEJLV3d6VmJNcFRhMEwra2piT3dpSGhQVjBJd1VUemdjZ3Q5R2hVYy9U?=
 =?utf-8?B?SDVreGpwWHBpdGZ0ZlN5dGZKcVMzdzZsVGxIZzRva2xDdTlGN0JXR0pXdm85?=
 =?utf-8?B?bHpWUUsvQzdVTW44dEtQRVhRdkdoeHBaMkNzUVg5bkRWclE5NzVGM3J0bUhy?=
 =?utf-8?B?UjBsUW5MaTRQbHFETkowd1N1Wm9GRW9XOXpXWWpvR0xMN3FRN0ZOZUNHRno3?=
 =?utf-8?B?cm1XQktWa3A0azBzQ2YrakRtb1NMb0FQTzJZbUg3QXk1YVpxVVI3UHVVbmpG?=
 =?utf-8?B?MmtjWWNEelpISy9Da2haUWYrOHFRdTdjSm1IaXFVNm1jb1l4Y1Z0aGhOQkpV?=
 =?utf-8?B?SWZOQUZlWXduRE9zQjlpM0tsVDVUaFBZbG5UNU9JUWh6THc5WlBUc0RSTHM1?=
 =?utf-8?B?RE5kb2NFVlh1czdFRzFEUm5zT3h3dE1ULzB4MXVVMkJDUzEzYmhBZkNFQWhk?=
 =?utf-8?B?Wm96Nlkyc0s1R3kxLzhvakNjVktNWnNDQVVqa3BNSTVpMjRkRVlOdUpDdUZD?=
 =?utf-8?B?N0h1L1BBVnY1SVV5WXFXaDU0QU5VWHVjZVZOTEJINXJvalRPajdRUGRHSUYz?=
 =?utf-8?B?RTA3cEM1YmI5RC9jME43T21aNVhCcXlGYSttcHA1RkdYRGtqOXJsZjYwZXVE?=
 =?utf-8?B?THZVeUFyVWxvOTFGd3BjeHhFdW1MNzQrUUt4UHh4L0hjNWFjaWd1bUhkWGJT?=
 =?utf-8?B?YnR2VUFFY0JTT0JFYmpnMHVnbTI3dlI1cmlOWTkvSDJEUkZMQmJwNXhhYU9y?=
 =?utf-8?B?T2hwcWdTK3VwVUk4U1dMUmdmczk4bktVTlYvTEFmQVJSZGc1L0pibkFGdGFV?=
 =?utf-8?B?dXBvSCt4SlVWdkZFd0lyUUVxSm1WcDRJZlZ5ejYyaUNKcDdxVzZBM3JVNTNm?=
 =?utf-8?B?MjJ6UWtUNTBkTUlzdWNCL3FEbGtIYVZBam1LQnNhZUxSNEVEaHZTejZDazFD?=
 =?utf-8?B?eXB1dUtObVBiNlN6T1dNcS9DOFBsVlkwa1FJOW5WaTlTWXhxTHBidUE4KzZs?=
 =?utf-8?B?TkpKRUJPSU56Q29BczhGWFBma0VMSWxWY0xLdjc0UTFGVjMzYmprNnBsbW9y?=
 =?utf-8?B?QjBiOU1XUzVaTXJRT0F2TnhsV0RoQXMvZHlyYkhDNUlWa2RUQWNRdnpJclh5?=
 =?utf-8?B?M0ErZytqemlvdkt1ODIxWXVaSUVtU0p6WEsxWGo1a1BMdUQ5bVVjUnRnWkxy?=
 =?utf-8?B?U3MwQndnbGtiWXp2NEJpb0RxSEVuSHY3NjNCQ3h4QmhOdDlzaW4xNWJraEhw?=
 =?utf-8?B?emFkN2lQaTVnNUxPVG5tMm51VG9laHd6Si9pWmhmaWFsNjBuRSswRk9XUTZy?=
 =?utf-8?B?RUpBZWdWSmdhcEtFeVdxUnhCczZVZGJPMUxyL0tVajJ0V25WV25WcWM2WXhV?=
 =?utf-8?B?UFJEZ0ZXc1ZDK0l2am1jdG1CcDFZb0VYNmhCd0t3REllaXhqdlpwQlkvV1BJ?=
 =?utf-8?B?WVFjYmE4bmo4WWFPMDYzRHp0dG5SbEFOSGl3K2x2WFU4N1hMRTRUb1k5WDhL?=
 =?utf-8?B?ajlCRWw2cndBaU9pM21INjJsa01NT25SbE9DRlFuTmQwNXIyLzUvWktEYkpj?=
 =?utf-8?B?YkJrS1N3enVQYnhyWC9qcGNBMWdBZnoxRWloRjlKWEkzQ0V2NTJqRzV6YXBM?=
 =?utf-8?Q?Jszw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c5fc0f-2551-4709-1f60-08d9d9d4a95e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 16:16:04.9635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAkYIsemgYlgEetI1aOOmwIgms6fmfh3sRwT8u7jHdfzEA11kCGErrSPYWSpP2m5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-01-14 5:37 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2022-01-14 um 3:38 p.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">After GPU page fault is recovered, output timestamp when fault is
received, duration to recover the fault, if migration or only
GPU page table is updated, fault address, read or write fault.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 41 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 12 ++++--
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 5818ea8ad4ce..6ed3d85348d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -265,6 +265,47 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	add_event_to_kfifo(task_info.pid, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
+static bool kfd_smi_event_pid_duration(struct kfd_dev *dev, uint16_t pasid,
+				       pid_t *pid, uint64_t ts,
+				       uint64_t *duration)
+{
+	struct amdgpu_task_info task_info = {0};
+
+	if (list_empty(&amp;dev-&gt;smi_clients))
+		return false;
+
+	amdgpu_vm_get_task_info(dev-&gt;adev, pasid, &amp;task_info);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The caller (svm_range_restore_pages) already knows the kfd_process. It
should be able to provide the pid directly from p-&gt;lead_thread.pid. No
need to look that up from the pasid and vm task info.</pre>
    </blockquote>
    yes, I can use p-&gt;lead_thread.pid for other events as well.<br>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	if (!task_info.pid) {
+		pr_debug(&quot;task is gone\n&quot;);
+		return false;
+	}
+	if (pid)
+		*pid = task_info.pid;
+	if (duration)
+		*duration = ktime_get_ns() - ts;
+	return true;
+}
+
+void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
+			      unsigned long address, bool migration,
+			      bool write_fault, uint64_t ts)
+{
+	char fifo_in[128];
+	uint64_t duration;
+	pid_t pid;
+	int len;
+
+	if (!kfd_smi_event_pid_duration(dev, pasid, &amp;pid, ts, &amp;duration))
+		return;
+
+	len = snprintf(fifo_in, sizeof(fifo_in), &quot;%d ts=%lld duration=%lld&quot;
+		       &quot; pid=%d pfn=0x%lx write=%d migration=%d\n&quot;,
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Please don't break the string over several lines. I believe that would
also trigger a checkpatch warning.</pre>
    </blockquote>
    It does trigger checkpatch warning, although I saw other places
    using multiple lines format, but this is not good to grep string by
    line, I will short it and use one line format.<br>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		       KFD_SMI_EVENT_PAGE_FAULT, ts, duration, pid, address,
+		       write_fault, migration);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The existing events use %x for all numbers, including event number and
pid. Maybe better to stick with that convention for consistency. At
least for the event number.
</pre>
    </blockquote>
    Will output event number as hex.<br>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">
The existing events seems to favor a very compact layout. I could think
of ways to make this event more compact as well (still using decimal for
some things for readability):

&quot;%x %d(%d)-%d @%x %c%c&quot;, KFD_SMI_EVENT_PAGE_FAULT, ts, duration, pid,
address, write ? 'W' : 'w', migration ? 'M' : 'm'

</pre>
    </blockquote>
    good idea to short the format and message.<br>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT, fifo_in, len);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index bffd0c32b060..fa3a8fdad69f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -28,5 +28,8 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
+void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
+			      unsigned long address, bool migration,
+			      bool write_fault, uint64_t ts);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 37b3191615b6..b81667162dc1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -32,6 +32,7 @@
 #include &quot;kfd_priv.h&quot;
 #include &quot;kfd_svm.h&quot;
 #include &quot;kfd_migrate.h&quot;
+#include &quot;kfd_smi_events.h&quot;
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -2657,11 +2658,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
-	uint64_t timestamp;
+	uint64_t timestamp = ktime_get_ns();
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
kfd_ioctl_get_clock_counters uses ktime_get_boottime_ns for the
system_clock_counter. We should use the same here (and in the duration
calculation) to make it possible to correlate timestamps from different
KFD APIs.
</pre>
    </blockquote>
    ok<br>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
+	bool migration = false;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev-&gt;kfd.dev)) {
@@ -2737,9 +2739,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	timestamp = ktime_to_us(ktime_get()) - prange-&gt;validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
-	if (timestamp &lt; AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
+	if ((ktime_to_us(timestamp) -  prange-&gt;validate_timestamp) &lt;
+	    AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
ktime_to_us takes a ktime_t. But timestamp is just a time in
nanoseconds. I think the correct conversion is just div_u64(timestamp,
1000).</pre>
    </blockquote>
    <p>prange-&gt;validate_timestamp will change to
      ktime_get_boottime_ns as well.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 		pr_debug(&quot;svms 0x%p [0x%lx %lx] already restored\n&quot;,
 			 svms, prange-&gt;start, prange-&gt;last);
 		r = 0;
@@ -2776,6 +2778,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 prange-&gt;actual_loc);
 
 	if (prange-&gt;actual_loc != best_loc) {
+		migration = true;
 		if (best_loc) {
 			r = svm_migrate_to_vram(prange, best_loc, mm);
 			if (r) {
@@ -2804,6 +2807,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n&quot;,
 			 r, svms, prange-&gt;start, prange-&gt;last);
 
+	kfd_smi_event_page_fault(adev-&gt;kfd.dev, p-&gt;pasid, addr, migration,
+				 write_fault, timestamp);
+
 out_unlock_range:
 	mutex_unlock(&amp;prange-&gt;migrate_mutex);
 out_unlock_svms:
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
