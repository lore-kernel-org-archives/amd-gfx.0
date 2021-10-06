Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461BD61039
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 461BD61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798D46EDE3;
	Wed,  6 Oct 2021 18:09:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B476EDE3
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 18:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwMJTdZGiKbPBUUfQXl7P6Yx/e1LpsaBmCyIU8ADmfcVXDLpzNZLnwk34vkEG3/7OBEV1SyxBlz/FQrpI47LP0To1R4msvwrSu9dzcrcnZ1MpqCQNBPl3yhOe/p78N0jCTH4kewGfu6+9xEP+Oxt8JEEsoif0tW4EzRgnWbWMn3ISO1YuRC4OJNLEGDLRSWCKky42kHBH/rF7XGawI4h+AeJXLTnVvlrgsn5S4JosCn8aTrLbY02rIRZgQhIT9neg5fFsHtjdMCxFcAew8TwLMYOibz71kqSIKSdiJgwRrHA3AVR2XpUhJ83yl0wiqDUDSe39u54uGJydvwHKcc84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3m0cVfDI5PpWMhURWWGCChKuWz/GNgD8KwUm5rXi8I=;
 b=Zw/lxZQFm62K8GZ2EcPdgJ9k/luhf89qn7DyQOWlIgJNbTQ3zR5ayYC+r3XPquxajRDYn0qv16c9KKzLGkSCIWHdrKcol1sQbELWBumEyMw8BGH4NXoTG71x5gngWo0bUb1NLHqIfiXO3Ho1AaHMf/Ykf8RXFR2JM7L2QL9Svtt6Gyxs4PKG8mctN3WnJNPXgCvQhNod8sNqFA+RqLUnLkUTwn1RW4xYfFouscywoiFyRSHOo5/Gp+Ix9A5p8mV1coOE+8y7rSeHutEuYPFxGj3BTfep+3xb36JXEg1qntH2dVVrnqj8mywqMWz0GXo8WZyg945ymzI1DMGX4C47vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3m0cVfDI5PpWMhURWWGCChKuWz/GNgD8KwUm5rXi8I=;
 b=QGWES+c7Ok6fjakkPx3P00fwxtDITYU3W7980Ov+EDghiEp+ghESk1q+I5Me59TlyrxqICU0b8FyYctLD4W5juCJ1OZWxskT7ufnxIgu0VNRL8ST0t2sVrknoFtv3MFOVdE3F+KgjX9P4qyhPYpfgQQben+j7gNzIs9ETeZWY+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 18:09:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 18:09:04 +0000
Subject: Re: [PATCH 3/4] drm/amdkfd: avoid svm conflicting with userptr address
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
 <20211006143210.4954-3-Philip.Yang@amd.com>
 <5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <7fc4e4e8-a649-0032-b3cb-e575b5c4d8c8@amd.com>
Date: Wed, 6 Oct 2021 14:09:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 18:09:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf68e91-5b37-4c67-8905-08d988f461f4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52625B2360391488B49E881CE6B09@DM4PR12MB5262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wVdr+BJ4GZUk04VSsbwuOcD26Rad7v1JI5WDe9Qh2xv3b4LIiiXNSE0KUlFdeauSFo5JO6/8jTNPlu44sMarg56nf00EB2olzC4wIVs5CKqyVMO3FursylWX3sCEEQwJNjAbQRYtdv8cPic6HvlxYpR5cs/vyozrYp2xEfvNm95Kjp6KxJN5/JSRK9nd3qs8LGOZBzW0rgVCTB2pFw09LACwmLNt2MSSuBgveNbEuzGs6f4vSUEkNYkMeCS9MqsCIyKEl/iuTU4hsucFiVMnyLDOXaEF09JbpdsOq4bHK2qomnMZ4xE3ap/3qqszV7apyr9vYSyQ3g1nNd5wUwGihzfhRTA/3/B9fmt/v17a6xZLNzpATadlNXB+Vn0S2HYU2B8mQ7jl6SoWPAhGgDDw1IlR+kJuybMw1p+2gYwd/UM4B8EWgfz6uiMreOlrUOsJUdIJQYvzDqt8SeatXX0wV/FiAETn7KMJjjpgFeg7INvAacCF0Sl907E82LF2IBeDTvM6tnlW8xblPLcwnrfJ+5iBVJRPHYBijE2NB7lf0Qw1b6+fbVmnhMeR90bh6Wv0HyUapMsk4qWtRudR470SiW8YERzIXhwrt51y80DCfcN+S9vVVWKpedVQqOVmE5MG73N2/OE6eJDSYlQ952RGyEToE2jAnC/kk1D7K9z6lKTCVvBXcl7r+5QhnryklwMUXVwUPSa3GUC2tNyn0+FXcL6RiU2W/0zh+OHDxmFWGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2906002)(5660300002)(31696002)(508600001)(6486002)(53546011)(2616005)(38100700002)(8936002)(36756003)(31686004)(186003)(956004)(110136005)(26005)(16576012)(316002)(66556008)(66946007)(66476007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDQxM3l4K0hpazArNU9jelJScWFwa044cFQrdE9qOWhXNzhTREZVQnVTdFJM?=
 =?utf-8?B?TXdSNEtoeUYyMVpRUzZZaDliNVl6RDJEckk2SU9MSVZJWkFUc21YTGhIL1Z2?=
 =?utf-8?B?Q1htdWxrUDRkZkhXUjBlUHd0VDVlSFZLVUtZblBqMlFBelp5NW5hbkwxNzIz?=
 =?utf-8?B?QnNURWgxVkhUVzNXTWQxSTNJNzhJQ21YUUcyZU1OS3VMWUNtQ1U4ZTczdnJG?=
 =?utf-8?B?YWxuRHR0eTgxbFFDelVLN1lDVWtHWmtKNGpTV1ZhZ0RXenIyRW5WVUdURHYr?=
 =?utf-8?B?SmpuaDBTZitFeUNLZCtVOHpKTW1Jdk1aUWF2dDlleHlEUkZvYXpXWXp3U2RX?=
 =?utf-8?B?ZGMxQ0t0K0NVUDFpaWl3MDJEbzYzK2VFc0l3cGJHSEx5bXNkUmxrVFQ4VEls?=
 =?utf-8?B?RGh3aVZxYW1jMnlzc3hDTnduTkRVQW9rSDd3ZVNBZWFoU2tKdDEwSVpxRGxj?=
 =?utf-8?B?MGF2dTY2SS81dHFxMytOS2hGRTJBek9mYk1aeHRIS2VuTFI4Sjc2TTNOakNT?=
 =?utf-8?B?am0rUUcxelBEZEpDNHlMZFlWMGtpS3h5ci9WOWJ4eHR6SC9TNjlXZEQ2alFD?=
 =?utf-8?B?QkxWcDAwNEJPWFdRTkExQmJoWmxKT3Q2SFRJQzNtTGtjTVB4My8rR2xzYXhL?=
 =?utf-8?B?MDNtUnhtZ0N3c0Q2OUxLdVRMeC9IZHFKNmxhcnhuZDVtUjJtTm1ObWFOSitL?=
 =?utf-8?B?NUloUjZSS3Nrb3F3Q0pJQ3ZFRFJQTWpNL0E2aktaY0JYbzkwdWdsb3BBbW1w?=
 =?utf-8?B?VjlyWFhzRUF6YjlGRmN3YUFUTTdiWWY0Yk4xZ1laaXBHMjlhcnBhTThuTVVr?=
 =?utf-8?B?Y1lOSDVoL1JPMTZQZzdwMFk4K1NyR2pibHZDVzFRd2pFV3Z5NEN0U2tHaTR0?=
 =?utf-8?B?bkVqSCt4Ri95NFhNQ3IxS2hXUXJuVWdsYlZJR09BZ1h2aU1PZXRLamIxalNq?=
 =?utf-8?B?amRPRjNSUFgvcGxjeDJ5TmR0R3Z6dXk2V0NPNythbkRWRWVRWUdpVUtObkJW?=
 =?utf-8?B?bmlWK3ppMWJFRjVmbHF1Y3haMjhxRkhoVXNaY0pnNnprM09zVzBLdXhqaGVH?=
 =?utf-8?B?OHZaY054VDVad3RqWHhqUFBrMjd3eWJUSVc4VFRKOGZvNWFRUVErbTQxZFBv?=
 =?utf-8?B?VW5wWjI2aFhsdDFnVTF3REdielorV0VlTmU2N1gxTGlLODVCWjc0dmFqVXlz?=
 =?utf-8?B?dm52bEtSdlR1RnE3UXJNMzFHZnB5cDNVcTVUeEFsSnEyTHcvQkNib2s2OXRr?=
 =?utf-8?B?RUhIN3N6dHBjU09BMXF5b3dDS2I3T0x2amlkd0xyOENzSjJXdFhJaDBJOThS?=
 =?utf-8?B?cVdGaTlVZ1JtVkM1VEgxL2ZuKzU2MVpDdTkvUWhyU3FzaTYrV2JCRml6WUJ2?=
 =?utf-8?B?SFlKWENIZEVCMkRrVU9KeHBrMmt6bzFsTnVQQ0ExdU9rK2doZjhReE01R3k2?=
 =?utf-8?B?cDJ6NDUwdmJWY1MrVkZaS3NDeWhYMHpGaGpKOFZwL1ozVGErWGdiZ3hrbUk1?=
 =?utf-8?B?a2VHbmJLUDVzQ1paa1BzekU0YnZmb3VXc29yZGlyZjh0cEloM0Y2TlhSYkRs?=
 =?utf-8?B?NklleE9VdFVCeTFCY0tIakRqM1ZUaCtObXZuS2ZBTnZXa216eExRWWpKaCta?=
 =?utf-8?B?dFIvZTF6QXNFRnNkaW96ZlUwenB3QUNCd3ZzNE0xUm1TY253THZ6NzU4WG4y?=
 =?utf-8?B?TnR4dGJpSDh3UDBHbzBWcERydVNhT2FtTmJrZ214d1dxWCszbFdHc2RZdjNY?=
 =?utf-8?Q?zb/RLhK1T4I+67BEobT8UlJA0nwIYmsh0RjTioe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf68e91-5b37-4c67-8905-08d988f461f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:09:04.7514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8RXJGvxV0hkGSGgcA6BOQKGAHLUHWDzvrIOglGI96XvZ8UPW3o4AwJXNMMGXVon
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
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
    <div class="moz-cite-prefix">On 2021-10-06 1:22 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">For ioctl_alloc_memory_of_gpu to alloc userptr bo, check userptr address
does not exist in svm-&gt;objects.

For svm range allocation, look for address in the userptr range of
interval tree VA nodes.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why? The purpose of the check is to prevent the same GPU virtual address
being managed by the two different memory managers. So checking
args-&gt;va_addr should be correct even for userptr BOs. The CPU virtual
address should be OK to be mapped with userptr and SVM at the same time
as long as the userptr uses a distinct GPU virtual address.
</pre>
    </blockquote>
    <p>userptr cpu virtual address is registered to MMU notifier, if svm
      range overlap with userptr, then migration svm range triggers mmu
      notifier to evict userptr and evict user queues, for xnack on,
      this is not correct. And restore userptr will fail if svm range is
      migrated to vram because hmm_range_fault failed to get system
      pages, app will soft hang as queues are not restored.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Change helper svm_range_check_vm to return amdgpu_bo, which will be used
to avoid creating new svm range overlap with bo later.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 55 +++++++++++++++++++-----
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f1e7edeb4e6b..34dfa6a938bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1255,6 +1255,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	long err;
 	uint64_t offset = args-&gt;mmap_offset;
 	uint32_t flags = args-&gt;flags;
+	unsigned long start, last;
 
 	if (args-&gt;size == 0)
 		return -EINVAL;
@@ -1266,11 +1267,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	svm_range_list_lock_and_flush_work(&amp;p-&gt;svms, current-&gt;mm);
 	mutex_lock(&amp;p-&gt;svms.lock);
 	mmap_write_unlock(current-&gt;mm);
-	if (interval_tree_iter_first(&amp;p-&gt;svms.objects,
-				     args-&gt;va_addr &gt;&gt; PAGE_SHIFT,
-				     (args-&gt;va_addr + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT)) {
-		pr_err(&quot;Address: 0x%llx already allocated by SVM\n&quot;,
-			args-&gt;va_addr);
+
+	if (flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+		start = args-&gt;mmap_offset &gt;&gt; PAGE_SHIFT;
+		last = (args-&gt;mmap_offset + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT;
+	} else {
+		start = args-&gt;va_addr &gt;&gt; PAGE_SHIFT;
+		last = (args-&gt;va_addr + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT;
+	}
+
+	if (interval_tree_iter_first(&amp;p-&gt;svms.objects, start, last)) {
+		pr_err(&quot;[0x%lx 0x%lx] already allocated by SVM\n&quot;, start, last);
 		mutex_unlock(&amp;p-&gt;svms.lock);
 		return -EADDRINUSE;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f0743fcfcc3..d49c08618714 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2679,15 +2679,18 @@ int svm_range_list_init(struct kfd_process *p)
  *
  * Context: Process context
  *
- * Return 0 - OK, if the range is not mapped.
+ * Return NULL - if the range is not mapped.
+ * amdgpu_bo - if the range is mapped by old API
  * Otherwise error code:
- * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
  * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
  * a signal. Release all buffer reservations and return to user-space.
  */
-static int
+static struct amdgpu_bo *
 svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 {
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
+	struct amdgpu_bo *bo = NULL;
 	uint32_t i;
 	int r;
 
@@ -2700,16 +2703,42 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 		vm = drm_priv_to_vm(p-&gt;pdds[i]-&gt;drm_priv);
 		r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
 		if (r)
-			return r;
-		if (interval_tree_iter_first(&amp;vm-&gt;va, start, last)) {
-			pr_debug(&quot;Range [0x%llx 0x%llx] already mapped\n&quot;, start, last);
-			amdgpu_bo_unreserve(vm-&gt;root.bo);
-			return -EADDRINUSE;
+			return ERR_PTR(r);
+		node = interval_tree_iter_first(&amp;vm-&gt;va, start, last);
+		if (node) {
+			pr_debug(&quot;range [0x%llx 0x%llx] already TTM mapped\n&quot;,
+				 start, last);
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping-&gt;bo_va-&gt;base.bo;
+			goto out_unreserve;
+		}
+
+		/* Check userptr by searching entire vm-&gt;va interval tree */
+		node = interval_tree_iter_first(&amp;vm-&gt;va, 0, ~0ULL);
+		while (node) {
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping-&gt;bo_va-&gt;base.bo;
+
+			if (amdgpu_ttm_tt_affect_userptr(bo-&gt;tbo.ttm,
+							 start &lt;&lt; PAGE_SHIFT,
+							 last &lt;&lt; PAGE_SHIFT)) {
+				pr_debug(&quot;[0x%llx 0x%llx] userptr mapped\n&quot;,
+					 start, last);
+				goto out_unreserve;
+			}
+			bo = NULL;
+			node = interval_tree_iter_next(node, 0, ~0ULL);
 		}
+
+out_unreserve:
 		amdgpu_bo_unreserve(vm-&gt;root.bo);
+		if (bo)
+			break;
 	}
 
-	return 0;
+	return bo;
 }
 
 /**
@@ -2732,6 +2761,7 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	struct vm_area_struct *vma;
 	unsigned long end;
 	unsigned long start_unchg = start;
+	struct amdgpu_bo *bo;
 
 	start &lt;&lt;= PAGE_SHIFT;
 	end = start + (size &lt;&lt; PAGE_SHIFT);
@@ -2743,7 +2773,12 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma-&gt;vm_end);
 	} while (start &lt; end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT);
+	bo = svm_range_check_vm(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT);
+	if (IS_ERR(bo))
+		return PTR_ERR(bo);
+	if (bo)
+		return -EADDRINUSE;
+	return 0;
 }
 
 /**
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
