Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF162C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD2960E98
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FD2960E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2C16FCF4;
	Tue,  2 Nov 2021 15:04:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E58F6FCF4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 15:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBV4NnFmeUoao/5taex2NGcKOgTFfPdK3BWkrYD8e8EpJIuAYfN4CO+G+Qc4g67CD2WwYtMSVWqv7XpJ1ue6CJG/S54sQcQo71iYZn95aBYZrTV4UsNw3RqKGM+XtoyHU4yyZDxthGl3JR8qSByxJm1MzpTKv5Igk46YdCAVv7EiMSLUJ1+XfTKrnZfFXokKM5SBcpXRo0UppBFhYYPGdaKTMb9wS39D5vdHRlX0LzXl7stpE9DtQlQiO0hSzgK65Oo5LAL4huBMfNCAWgjGm8qXZY/r/I9Zu90FGGYJSKwu/aK330sipFb96nj+Zu41kCymsLfj8glhc3oT5U2ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WAUgRdQQv9LL3CaObdl1EytoMZ3T1yPXPUi68YysgE=;
 b=kcKzDavz9Pd+P+KmmqRD0yLPzK6S9uwzyVYzkR4jfNubtOoNTsfwAoMxJHcVMSudKS7d5R946ZcJja45DTjzDA48VOxaLYdJBRaBE8BUk0NF2KJELQ8zycnJWEwFdVGJEbD5DTL5gLlsNNLPTGDfTvb1hwNSS/j6JNfUf1DDGUNU78LaX2aZ6IS2PpmyWPdf8sdJQ6mh8+S6NQvKokeIBpnIQItkNR2Nj430zCuTgvJ2V4zxCt5P94FdwpTX1e+mCaswNlI11YjA01haTeVFolJ4bbQ5tc7/EXsfJRslo98oHsQoZl4FLdSasmhKwcXY2XLXhLRoKCh1Ohe2L5d1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WAUgRdQQv9LL3CaObdl1EytoMZ3T1yPXPUi68YysgE=;
 b=hAYIxDMExjNnEHPfmThDnrbA33FSqeyjeHTsC2ZXWq7OTBTTKsIseS6UymyicR9FANjkntbQcBAYD1v9KxDM5wBzxbQ5Ja7KWvD7J+s6CyvJj+WdxrgNJhP5nR1FErUDFMxEK/vr/P1FE7EtgS/mAc6C+2qfLAuq0bdfB7fGl+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 15:04:15 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%6]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 15:04:15 +0000
Subject: Re: [PATCH] drm/amdkfd: avoid recursive lock in migrations back to RAM
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211102024040.11666-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <86db53c1-538a-c479-fffd-88888141c2e6@amd.com>
Date: Tue, 2 Nov 2021 11:04:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211102024040.11666-1-alex.sierra@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 15:04:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a5951a-fc8d-401d-c42e-08d99e120988
X-MS-TrafficTypeDiagnostic: DM4PR12MB5197:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5197C404582D521EE4A4E817E68B9@DM4PR12MB5197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bGhVgylrTI0kUYaKWxoJo/DXAol8lNGXlr8zcHuC69WUdiJIUy0oK7N3pL5Ae9QDhsqf9Iawod58kfxgb13aQUzOFxfBu5szIpFeMGJ3D8kBGqRc+FALp63YsOeo6W5eGJPM0V1x8infHSK1ZeHLvIMHZz+Qk85YsUg1fRbhKvMTTn4hcVw9HzY9hgLtd3X/CW7+X2PD7bE7FRDebEuK8eYTJJ3TA4mjfthS5T+b3ocE/2DtAGreU1IupgdxsTLGEiBi9I+yJYyh8ECKLLZ6PiN4syMV+2ME5BoJNjsZjhjHC2qU2DQ9S52EWfmuo3qhYwsO0IG/SQqR9R7rVh5vV0k+jlsOh0psJXImPoPiaeCKHJ8dmsrF8IKx0DRIXN7gjdcfx43SArJMro0s+GYezZih/qU7kbOBX9S8y/idcweKmSwG4UOjW4O9+eMbE+Q2c91ZSYlkKQTu+116BZlbfTA6gJ5p7uWpvc/bhzbMYC+J5U2cdaTv8xe9W90fFjul4LF5ig9O1jFbQ0HIfIbRPm1d6qr8BDJCKd/AMjfJyVgQmQY7DbkbeMY1Ub3CHvGHINNNEMOxYLBPJfkzHchYfL8ynjkMERo0iiBW3ebJpjRABoeve9qwxOx/0TtjBkkI/oQ1lXh4hp26ZE/KeYOvJC0Ps6WbyF5zmRM5Rqkk/nA7xxZUsJHZXzD1vpCBWQzRjn/B9h86S3jWz+RIXc6uWjTOQF5O1cK3yYnrCsveKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(66946007)(2616005)(53546011)(956004)(8676002)(2906002)(31696002)(186003)(5660300002)(38100700002)(83380400001)(66476007)(31686004)(16576012)(6666004)(508600001)(316002)(8936002)(66556008)(36756003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJBMlNUb1RkNFZscVpxMnVzdGN3eTdZNUF5c2lxbmdoNGk3MmxhZFlzVUJB?=
 =?utf-8?B?MmtKVFZyRWFpMzhHSVNQVDd3NXB6eDd0NWFMVllHOE93blF6RTIwck5Db0FP?=
 =?utf-8?B?RWd0cjVucTNaYklIR2tyNGtoZVhOdEhJY01JdnJOY05HVVhMRVNFcmlPTEZ1?=
 =?utf-8?B?TUxTSEpvVjFvTkFQdmJwbXBvczAxZHJyd1dQd1Z2ZUZlckV5RlpKYS9xL0h1?=
 =?utf-8?B?QlVqeFA4SForM1RxZnJ0cEI5Y0lzRGd3RG1NR2VjbXJ5U3JLTVE0c0J6OWFB?=
 =?utf-8?B?MlV6MjY3cUVVS3lVRDVjeDhON1ZDOGJma0JyYmdCV2NpVEdWOG9Ob0tBcm8w?=
 =?utf-8?B?dW1Wai9UUkhhaWhrMUhlaFVFQUhzTDlEaWxSeDJITWlSTWtkcUJlcHVuNVM2?=
 =?utf-8?B?bUxjNkJ0UTZ4bnpMckZZRWhzdW1IOE5OSUtKRzk1aHJvTTl5OWlLRllNMTlm?=
 =?utf-8?B?N2hVS1plYmlaVHhnR3FwVEFWUHo0dUpkOUtwMHBxbTRmWFY1MUo5SEFOT2FV?=
 =?utf-8?B?OVRUdDJ6YmI4eGpRWWlBKzJDS0RVdU5tQ0djbjZ5emNxRDNYcnNoTzVSN252?=
 =?utf-8?B?UEZ6Y0YrUkJ5K2VoeG1pZUszZUNLYlhiZnY5UWdtYmtjQ1hMYVVBT09WSENu?=
 =?utf-8?B?VGhRbC9UVTVDdUtGKy9XWVNBK3JieWd2S2VvT2ZERHpvQ25yRnRhNGhsd2V4?=
 =?utf-8?B?OG4yblY5TWxxY0RaWkNNVEhJekE5V2k2dFhWaEpQWklpWjF2bUc3QWFBU2hx?=
 =?utf-8?B?QWpXY3BmNUVjNWxKQ2lWR202NlJRcGkyQVJlNUdYUm4vTEpVOXB6SzQ4Nm44?=
 =?utf-8?B?M2NuNTkrZVBSOUQraE5KMVczTlhWZ0RUMnNHWVlUSHEwQ041N2NEMENiNXdv?=
 =?utf-8?B?WS9jaVJDV1Q4bFlDVTZ6K0t6S0FUQ0ErTk4waWo0R0RzNXZ3dldoMXFId0RZ?=
 =?utf-8?B?MUdkVVoyVVM1NmsyLzJ5NXExNklHVzk2TzEvR0d3aDY4bkFDbjVncTIyZW96?=
 =?utf-8?B?dTd0WHpPZDhGTVhNUUROdk9aNmM4blB3L2doMkdYeFRnLzNyM04vK0tTVGlz?=
 =?utf-8?B?UmZnZDlIbmFUNzJoQTBRdVBWWWFzU1BpSnBVdmhlS1NiYWp4MDU1ZkFoelNE?=
 =?utf-8?B?WTZVTkpXbTZ5aEpyVnByQ1FmZklNL2l4M2hIZmVnK3Y5VlhjNk83RDdXYnFn?=
 =?utf-8?B?MXZrVTN4NTVnMUdLTFRPTUdJcWdiUEpvTkloaEJEQXQwclNzNW0yaHpqekpK?=
 =?utf-8?B?UG1DMVQwaU9NUkIrcS9UdGU3TGJ5RFh6UkNHVVNhVVZIMFBhT0s2YktNa1dn?=
 =?utf-8?B?N0lwM0pKZXFFQi9raDRNUStCTUxmLzNkaGY2em9KcGVjK3lZYWppMkZ6c3NC?=
 =?utf-8?B?eFRTVU1PNGZFT2ZmbEQ3d3cxaldtSXpHUS9JUnZOcU1oYUVCaExTeUhSSVVJ?=
 =?utf-8?B?T1R4cERzMHB3NWZEWDJPaEdmK2hHaDlBZWxUUUljc20ydDFFaUpLZGhSR1Fz?=
 =?utf-8?B?UU5ORjFiN1EzZGVkRm1LSWd0bThIQlJTSlpnMzUzRDd1VFA0SHFneWlyVFBW?=
 =?utf-8?B?am85U2ZOVzdYKzhSTUpmdlgyNlBjK3pSMVRwS0RJK0RDMU8wS0ozNklaaFFu?=
 =?utf-8?B?dWZ1TlRaRVZFRnErVWczemFKQy8rSm5Tbm1XbEZFMFVwdHdmd0VsdWtHV1NE?=
 =?utf-8?B?RnJWbkc1bHpTK1VpZ3l3M2lTVmtKN21pVmRWcGtCYXRNRngwVHNwQ2toaFRU?=
 =?utf-8?B?NmR0OVUxcVIrS1ZZTmkvR2Q5ZmZzMHFhOHhWWXVSUHc5Q1BGL1pndlplY0Vx?=
 =?utf-8?B?dGY5VGQ4RDZ4QWxOakJyN2gva2lZVUFhVHBLQnZxMktrS3lqUGRqSStpdGZU?=
 =?utf-8?B?VW5Ic3E0TWw1cDA4K0tuOTdiaXhzbTNWZHBtMC8zT3V5NWNJaW5lTFhnTHJw?=
 =?utf-8?B?YlBJUEc1YTlJSmluK05HV3pTTFNtMEMyT0xTU0MrSjY0VkQyRTc5bXBHcEgz?=
 =?utf-8?B?QkpBYmwrclV4YUFZV0oySnN2VE1ZMklpZU1CbGlxbmtybDB5djdNUHVhRVpJ?=
 =?utf-8?B?Y2hDeWFiRDBFS0kzMDZBZFJnRllZOEpiV01BVEtFNUlJUjFTQ0I0SWx3ek03?=
 =?utf-8?Q?8ixE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a5951a-fc8d-401d-c42e-08d99e120988
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 15:04:15.7667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwnda5oPArfuhwyu9VWaazA0HV0BYdi3ypLT6Ycm1gQ+iLp/tQfE8qnPR3RNT08w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
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
    <div class="moz-cite-prefix">On 2021-11-01 10:40 p.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211102024040.11666-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">[Why]:
When we call hmm_range_fault to map memory after a migration, we don't
expect memory to be migrated again as a result of hmm_range_fault. The
driver ensures that all memory is in GPU-accessible locations so that
no migration should be needed. However, there is one corner case where
hmm_range_fault can unexpectedly cause a migration from DEVICE_PRIVATE
back to system memory due to a write-fault when a system memory page in
the same range was mapped read-only (e.g. COW). Ranges with individual
pages in different locations are usually the result of failed page
migrations (e.g. page lock contention). The unexpected migration back
to system memory causes a deadlock from recursive locking in our
driver.

[How]:
Creating a task reference new member under svm_range_list_init struct.
Setting this with &quot;current&quot; reference, right before the hmm_range_fault
is called. This member is checked against &quot;current&quot; reference at
svm_migrate_to_ram callback function. If equal, the migration will be
ignored.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bff40e8bca67..eb19f44ec86d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -936,6 +936,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		pr_debug(&quot;failed find process at fault address 0x%lx\n&quot;, addr);
 		return VM_FAULT_SIGBUS;
 	}
+	if (READ_ONCE(p-&gt;svms.faulting_task) == current) {
+		pr_debug(&quot;skipping ram migration\n&quot;);</pre>
    </blockquote>
    <p>need release refcount to avoid process leaking</p>
    <p>kfd_unref_process(p);</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20211102024040.11666-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		return 0;
+	}
 	addr &gt;&gt;= PAGE_SHIFT;
 	pr_debug(&quot;CPU page fault svms 0x%p address 0x%lx\n&quot;, &amp;p-&gt;svms, addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f88666bdf57c..7b41a58b1ade 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -858,6 +858,7 @@ struct svm_range_list {
 	atomic_t			evicted_ranges;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
+	struct task_struct 		*faulting_task;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 939c863315ba..4031c2a67af4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1492,9 +1492,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		next = min(vma-&gt;vm_end, end);
 		npages = (next - addr) &gt;&gt; PAGE_SHIFT;
+		WRITE_ONCE(p-&gt;svms.faulting_task, current);
 		r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, mm, NULL,
 					       addr, npages, &amp;hmm_range,
 					       readonly, true, owner);
+		WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
 		if (r) {
 			pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
 			goto unreserve_out;
</pre>
    </blockquote>
  </body>
</html>
