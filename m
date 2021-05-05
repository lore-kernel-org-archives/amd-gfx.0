Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597A3C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E735461176
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E735461176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE926E4D0;
	Wed,  5 May 2021 17:54:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241D06E4D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 17:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoDbPgB4GT2vamhusSc9LlNuMlmzGICDIKRTPX2McQSAFuCrwVUcECsbVfhqRQT6otTPpi0UgnQMFTPSWgfP0FO7NuosWK9cRkDpjzbxzCeQCRFOV55s6w26qvaf/ViGrBFNmEedBS++0heKX4XPOXPReAYDC+/QSGAjT42upKGTL1/855wd7PijBwESROyUIV7lanlKYaCVLrCmQODY8KqqFJU9bmr3cuReSRNSkz6n7MdfQShrH7lK6w8Sbe0oPlmp3NjNsEudujH0ecK23gDy0AVV+mYKJ2Q6EF1gyB51L4Mykai0V+aOerTKcFXEYntsDOJ7MSzceieIq/AJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20ZgUOSmGWGqLrhxQEsuagG+W9vlN6Vkwp7cbu4gn/Q=;
 b=aIVlXIRo23LmHSsZGuCmPaokZ5G+nkd/F9+RxVSmK7vgC2wCQGBS2Hsp5AZu1Unw2Ol+SdWZnNfRhLRTSLDlVtibCTsBQWZnX5MF9k5g/cE3ML5yXKaNTqxljUDmuYO27zckQpSNUDj6saz+jRQ2zEt772ZbaZHL+5XG6MjRPfFMxswQAJpHFA0eDFKdGPMj77nLDXw7MAcI2rt8UKfQa4igKlZnXXLsKgNxDMrVtGF2VbqA9qZmoXrRZ7S9MLwYLNrpzSLYuPfkTwB1/08nthlk6dN1vfVYFnoJmC2TnErArWjVZqtAm0QNV6m+NIVPMn8ieQZIvg+UaO0fyc0Y4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20ZgUOSmGWGqLrhxQEsuagG+W9vlN6Vkwp7cbu4gn/Q=;
 b=EnTwAUz7uogqdXu3YONd+oxT94RvYlUDTNXN+SNfTCtCeHC6hnU9+Tpy6TqEX4/X12285Zozu8VKe68R6HNQH61y3EgtmSvTb/458HDeRtZG0HGCQqgLJxIHul3tNBpmVr9oTdDYAsBYwZTsYhfEmvEbm+p4gJg/OSaw02z1/44=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Wed, 5 May 2021 17:54:38 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 17:54:37 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: wait migration done only if migration
 starts
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210429015339.13047-1-Philip.Yang@amd.com>
 <15106a30-9f85-f0ca-5e4c-b53c60c83474@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <74b3acf3-8775-d4dd-e5b0-727c754ec4f0@amd.com>
Date: Wed, 5 May 2021 13:54:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <15106a30-9f85-f0ca-5e4c-b53c60c83474@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Wed, 5 May 2021 17:54:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f9e95e-ccf2-43d0-d741-08d90feed98c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35149E28BE26276112FB5A4DE6599@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jXY/RrRyIvNDVAk4gCCWsCp6dJYvMXaoWHSu+87K8aniBcjlMVqRLSMsD0RBUa6w/bxX3Mc9pP0xtpXMwfPAbuX+CK7uoSi/5WI0ZQYBWycglbIsCav2i/qdzQxK0HuGah8XZkgjoSvbyaB4rom5CxYuure+1/EWlS4z3rZR2N5jyZc+RWG0cX+tM1b2sFDfJisKciBTYct+rMM4L3HXiIy0jVd1/me8EsAY5vmkh5wovgnZVF8PmfUOb5cIL49l8LJkkDOKz0gscKPukU9z5hUE1G0UBj8bWmW8Dl8H/+zUZuMLkkGpzrbAGlD+WxQWFG9ajwo6UpMHeHs8sIGP5+Z/eF5KOc4dTe+xP8+CEYq+v6qt8Pqbys8SYzjgei4diH6/GzFrFa7J65W3bnTSYy18EfTk5V85WCTHlgsSrF0tASMbpaRW7QgkmkFumqZ6JZcT4yZP4+27XY+HwzsYIpc+0lujX8Qg6JGtJnezLuTN8aX/wLeFtJ2rNLD9GsNCwEpe9rEZ2Hlaiw96Xa8ktp+H7bcNOk+zF8Ypl2Skl/iESjpkj3KVWYvEUJcfpi0NUavuNpqVpmNUKCKfqKIRAtVS4U/odnNXQSmfAd3bP7S3Pl9vn0jzUMXmPFxWjJwGte8MXyHFq8yUL7CB6NmAdR+KWmu6v2cF+1rN2sGfzgwnVgfPNgE/lwXKFfgp5j1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(2906002)(66556008)(5660300002)(8676002)(26005)(83380400001)(316002)(36756003)(31696002)(38100700002)(16526019)(110136005)(186003)(16576012)(8936002)(478600001)(45080400002)(956004)(31686004)(6636002)(66476007)(6486002)(66946007)(2616005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZkJGbjRsUDVaM0xvdXhTdkZ5THJOK2UzeHhpWm9JbjU2QUJtaWlTZ05zc01X?=
 =?utf-8?B?RHgvNm9DbzRlOENJeEc1SktaU1VPY3dINkNBcmV2bURnaVlwUWhiTGNZaXBX?=
 =?utf-8?B?WjVQS2NtWGhVZ0g5UExLVVMyYkNPVmtGdWhsam1TZjJZQ3NxOStwRXJkUUk0?=
 =?utf-8?B?c2ZjOGxUNFI3QWNJMnI2VkhMb3Vmcm8vL0M0Y1lOMTVoT2V5MzJsTHUvMStk?=
 =?utf-8?B?Vzd3TndKb0Y3NW9JUWlzWFZOeno1ZGN6UmtRN2tlSVFTMlpCS3NUZUVrNnBL?=
 =?utf-8?B?ZTZUWk9tRk50MlhHN3d3TndXVXBhOFZtaVdRdzFhYWVjRGU0UmZyMnBiaU5m?=
 =?utf-8?B?NUhoWXA2UEVaY1d0S3VsS2tqdThiSk9qSlRyUXVLMFFUc0VlY1pIVkppcnVo?=
 =?utf-8?B?eVp5WUN3MG1zMFh5TXRtUkxPSC9ZbXFxWklKNEhMeXVmNyszMDJacHNaL2xX?=
 =?utf-8?B?aEF5eGgzcnZvd0FJeU4xZGd6Q1ZaRnNLalBTSDlSSUQybkZiRlR3QmpEaDNU?=
 =?utf-8?B?RW1KcTJBcTNuVndVMDFBN3BnTWh6ZHhnMnZzYi8zYlhxbFpGOVp6RnRnbFVv?=
 =?utf-8?B?OTN0bTdpMmZSVnRodmYvc0QyT0RjTjZPSmYrcm5ZMlFKbXBlWU5vOVZvTFhO?=
 =?utf-8?B?N1E5NU9MWCtxYjhETi84TG1jSWpseDlZY1pFTjlVcnJXSDVvZjdKL21HUS96?=
 =?utf-8?B?OHFDYVBoRkVQakdCTGJDU2lTYVh6U2I3UFdleENhNnp3UStZVDVUUHhQNEdE?=
 =?utf-8?B?VndFaXd5c3luMEk1dnhmay9kNUd4T2xLMFUvRlNjQW0zZmpDYnRCQTQ1cmZ3?=
 =?utf-8?B?ck54alp5VVN5a0duVEZlTWpvOWR3dGprVVlLL0NsUjNuQ09ZTUVyZUpiSFFR?=
 =?utf-8?B?M0VkQkNHWUlpeGFITXZRRU8rb0lUWVk0bVcvU0FqczdITmhFSFFwbmF3N0hZ?=
 =?utf-8?B?UXRab2NLVVRiNzBSdGszK1k2VFJBeWNLWkg4M0dBcGQyVVFxR0JGbDQ3bWlU?=
 =?utf-8?B?bVJCNUJoUEdScFp5c0ZGaDZKUDdRSmNFR2g4cXp4dDhxYXo3WFNEdC9Qa2Qr?=
 =?utf-8?B?N1BTS0Z6MmlRMlRvMUNHVmhJa2JHZHM5Skd0d0hJVno3aEtaSUduK05vWVRn?=
 =?utf-8?B?MjhSU05Ic0xSYVFjbkZpL0pFeUNkM1ZjMkI5U2VySHF1TGVITHZSMHp5S0FH?=
 =?utf-8?B?dUovMjFuZmQ0Qm1nNjZxZ3IwNE81S1U0cFNtVEg4NmRyeUlZMk1kMXdycnlP?=
 =?utf-8?B?OFdBNXlDK2huK3RKWXpCMFEzMW1TcWVKa1hxNXdqNk5FQ1RaR056aEVHK3pV?=
 =?utf-8?B?b0xDMW5GT2hxc3N3bnVCM2V3ems4SGRUSTVqTHdHZnIrQ0lsbmRlRUd0Q01X?=
 =?utf-8?B?M1prOG9PMHRWRlNBWWsrN0tTc3QySnl4N0loVkk0eUNySkpuZGFMaHc5U3FY?=
 =?utf-8?B?NExoaitNekhhcW4xMWIrbGJDaWRVbEd2bjU3Umlnd1dBSmk3ZDl0M2c2TGJU?=
 =?utf-8?B?eCtKU1VESG9OdmVVdWRITkxoNW5BRHFUTnh2Sm9iWU54RjV2dWZzdmhGN0pC?=
 =?utf-8?B?QWZIYWpwRlNCSzBvZzRoZFJ4bHI2ZVBUb1J5RGF5bHZZMklLdXRybmxjM08w?=
 =?utf-8?B?SzVrZ2p3bzQwcy8zeFpXU2ZGc3Z5VHgzb0VHWXFkaG9wbnRMZ0owTk9MZVdZ?=
 =?utf-8?B?MC9RamJvU3ZEdmxlNTltR0FlazFjV3c1SHRBdkZVZXViTW90eFBiaUErOThO?=
 =?utf-8?Q?8+Np5JXbNkebP/J0wlUbG3n2iHuLHyCX1mJW0uq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f9e95e-ccf2-43d0-d741-08d90feed98c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:54:37.7774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2EQDT25cXEtd0+OgDfb6PwdajhELLPrIwdN7ysYxSUkNcZVXmOEQFEzPvT/TMGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Content-Type: multipart/mixed; boundary="===============1506509052=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1506509052==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-29 2:10 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:15106a30-9f85-f0ca-5e4c-b53c60c83474@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-04-28 um 9:53 p.m. schrieb Philip Yang:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">If migration vma setup, but failed before start sdma memory copy, e.g.
process is killed, don't wait for sdma fence done.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think you could describe this more generally as &quot;Handle errors
returned by svm_migrate_copy_to_vram/ram&quot;.


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6b810863f6ba..19b08247ba8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -460,10 +460,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	}
 
 	if (migrate.cpages) {
-		svm_migrate_copy_to_vram(adev, prange, &amp;migrate, &amp;mfence,
-					 scratch);
-		migrate_vma_pages(&amp;migrate);
-		svm_migrate_copy_done(adev, mfence);
+		r = svm_migrate_copy_to_vram(adev, prange, &amp;migrate, &amp;mfence,
+					     scratch);
+		if (!r) {
+			migrate_vma_pages(&amp;migrate);
+			svm_migrate_copy_done(adev, mfence);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think there are failure cases where svm_migrate_copy_to_vram
successfully copies some pages but fails somewhere in the middle. I
think in those cases you still want to call migrate_vma_pages and
svm_migrate_copy_done. If the copy never started for some reason, there
should be no mfence and svm_migrate_copy_done should be a no-op.

I probably don't understand the failure scenario you encountered. Can
you explain that in more detail?</pre>
    </blockquote>
    <p>I had below backtrace, but cannot repro it again, use ctrl-c to
      kill process while handling GPU retry fault. I will send new patch
      to fix the WARNING, the &quot;amdgpu: qcm fence wait loop timeout
      expired&quot; and hang issue log is something else, not caused by
      svm_migrate_copy_done wait fence.<br>
    </p>
    <p>[&nbsp;&nbsp; 58.822450] VRAM BO missing during validation<br>
      [&nbsp;&nbsp; 58.822488] WARNING: CPU: 3 PID: 2544 at
/home/yangp/git/compute_staging/kernel/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:1376
      svm_range_validate_and_map+0xeea/0xf30 [amdgpu]<br>
      [&nbsp;&nbsp; 58.822820] Modules linked in: xt_multiport iptable_filter
      ip6table_filter ip6_tables fuse i2c_piix4 k10temp ip_tables
      x_tables amdgpu iommu_v2 gpu_sched ast drm_vram_helper
      drm_ttm_helper ttm<br>
      [&nbsp;&nbsp; 58.822902] CPU: 3 PID: 2544 Comm: kworker/3:2 Not tainted
      5.11.0-kfd-yangp #1420<br>
      [&nbsp;&nbsp; 58.822912] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00,
      BIOS F12 08/05/2019<br>
      [&nbsp;&nbsp; 58.822918] Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]<br>
      [&nbsp;&nbsp; 58.823197] RIP: 0010:svm_range_validate_and_map+0xeea/0xf30
      [amdgpu]<br>
      [&nbsp;&nbsp; 58.823504] Code: 8c b7 41 ec 41 be ea ff ff ff e9 20 fc ff ff
      be 01 00 00 00 e8 57 27 3f ec e9 20 fe ff ff 48 c7 c7 40 7f 61 c0
      e8 d6 54 d7 eb &lt;0f&gt; 0b 41 be ea ff ff ff e9 81 f3 ff ff 89
      c2 48 c7 c6 c8 81 61 c0<br>
      [&nbsp;&nbsp; 58.823513] RSP: 0018:ffffb2f740677850 EFLAGS: 00010286<br>
      [&nbsp;&nbsp; 58.823524] RAX: 0000000000000000 RBX: ffff89a2902aa800 RCX:
      0000000000000027<br>
      [&nbsp;&nbsp; 58.823531] RDX: 0000000000000000 RSI: ffff89a96cc980b0 RDI:
      ffff89a96cc980b8<br>
      [&nbsp;&nbsp; 58.823536] RBP: ffff89a286f9f500 R08: 0000000000000001 R09:
      0000000000000001<br>
      [&nbsp;&nbsp; 58.823542] R10: ffffb2f740677ab8 R11: ffffb2f740677660 R12:
      0000000555558e00<br>
      [&nbsp;&nbsp; 58.823548] R13: ffff89a2902aaca0 R14: ffff89a289209000 R15:
      ffff89a289209000<br>
      [&nbsp;&nbsp; 58.823554] FS:&nbsp; 0000000000000000(0000)
      GS:ffff89a96cc80000(0000) knlGS:0000000000000000<br>
      [&nbsp;&nbsp; 58.823561] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
      [&nbsp;&nbsp; 58.823567] CR2: 00007ffff7d91000 CR3: 000000013930e000 CR4:
      00000000003506e0<br>
      [&nbsp;&nbsp; 58.823573] Call Trace:<br>
      [&nbsp;&nbsp; 58.823587]&nbsp; ? __lock_acquire+0x351/0x1a70<br>
      [&nbsp;&nbsp; 58.823599]&nbsp; ? __lock_acquire+0x351/0x1a70<br>
      [&nbsp;&nbsp; 58.823614]&nbsp; ? __lock_acquire+0x351/0x1a70<br>
      [&nbsp;&nbsp; 58.823634]&nbsp; ? __lock_acquire+0x351/0x1a70<br>
      [&nbsp;&nbsp; 58.823641]&nbsp; ? __lock_acquire+0x351/0x1a70<br>
      [&nbsp;&nbsp; 58.823663]&nbsp; ? lock_acquire+0x242/0x390<br>
      [&nbsp;&nbsp; 58.823670]&nbsp; ? free_one_page+0x3c/0x4b0<br>
      [&nbsp;&nbsp; 58.823687]&nbsp; ? get_object+0x50/0x50<br>
      [&nbsp;&nbsp; 58.823708]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp;&nbsp; 58.823715]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp;&nbsp; 58.823725]&nbsp; ? lockdep_hardirqs_on_prepare+0xd4/0x170<br>
      [&nbsp;&nbsp; 58.823733]&nbsp; ? __free_pages_ok+0x360/0x480<br>
      [&nbsp;&nbsp; 58.823753]&nbsp; ? svm_migrate_ram_to_vram+0x30f/0xa40 [amdgpu]<br>
      [&nbsp;&nbsp; 58.824072]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp;&nbsp; 58.824096]&nbsp; svm_range_restore_pages+0x608/0x950 [amdgpu]<br>
      [&nbsp;&nbsp; 58.824410]&nbsp; amdgpu_vm_handle_fault+0xa9/0x3c0 [amdgpu]<br>
      [&nbsp;&nbsp; 58.824673]&nbsp; gmc_v9_0_process_interrupt+0xa8/0x410 [amdgpu]<br>
      [&nbsp;&nbsp; 58.824945]&nbsp; ? amdgpu_device_skip_hw_access+0x6b/0x70 [amdgpu]<br>
      [&nbsp;&nbsp; 58.825191]&nbsp; ? amdgpu_irq_dispatch+0xc2/0x250 [amdgpu]<br>
      [&nbsp;&nbsp; 58.825462]&nbsp; amdgpu_irq_dispatch+0xc2/0x250 [amdgpu]<br>
      [&nbsp;&nbsp; 58.825743]&nbsp; amdgpu_ih_process+0x7b/0xe0 [amdgpu]<br>
      [&nbsp;&nbsp; 58.826106]&nbsp; process_one_work+0x2a2/0x620<br>
      [&nbsp;&nbsp; 58.826146]&nbsp; ? process_one_work+0x620/0x620<br>
      [&nbsp;&nbsp; 58.826165]&nbsp; worker_thread+0x39/0x3f0<br>
      [&nbsp;&nbsp; 58.826188]&nbsp; ? process_one_work+0x620/0x620<br>
      [&nbsp;&nbsp; 58.826205]&nbsp; kthread+0x131/0x150<br>
      [&nbsp;&nbsp; 58.826223]&nbsp; ? kthread_park+0x90/0x90<br>
      [&nbsp;&nbsp; 58.826245]&nbsp; ret_from_fork+0x1f/0x30<br>
      [&nbsp;&nbsp; 58.826292] irq event stamp: 2358517<br>
      [&nbsp;&nbsp; 58.826301] hardirqs last&nbsp; enabled at (2358523):
      [&lt;ffffffffac100657&gt;] console_unlock+0x487/0x580<br>
      [&nbsp;&nbsp; 58.826313] hardirqs last disabled at (2358528):
      [&lt;ffffffffac1005b3&gt;] console_unlock+0x3e3/0x580<br>
      [&nbsp;&nbsp; 58.826326] softirqs last&nbsp; enabled at (2358470):
      [&lt;ffffffffad000306&gt;] __do_softirq+0x306/0x429<br>
      [&nbsp;&nbsp; 58.826341] softirqs last disabled at (2358449):
      [&lt;fffffffface00f8f&gt;] asm_call_irq_on_stack+0xf/0x20<br>
      [&nbsp;&nbsp; 58.826355] ---[ end trace ddec9ce1cb4ea7fc ]---<br>
      [&nbsp;&nbsp; 67.807478] amdgpu: qcm fence wait loop timeout expired<br>
      [&nbsp; 242.302930] INFO: task khugepaged:514 blocked for more than 120
      seconds.<br>
      [&nbsp; 242.303237]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.11.0-kfd-yangp
      #1420<br>
      [&nbsp; 242.303248] &quot;echo 0 &gt;
      /proc/sys/kernel/hung_task_timeout_secs&quot; disables this message.<br>
      [&nbsp; 242.303256] task:khugepaged&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid:&nbsp; 514
      ppid:&nbsp;&nbsp;&nbsp;&nbsp; 2 flags:0x00004000<br>
      [&nbsp; 242.303270] Call Trace:<br>
      [&nbsp; 242.303281]&nbsp; __schedule+0x31a/0x9f0<br>
      [&nbsp; 242.303300]&nbsp; ? wait_for_completion+0x87/0x120<br>
      [&nbsp; 242.303310]&nbsp; schedule+0x51/0xc0<br>
      [&nbsp; 242.303318]&nbsp; schedule_timeout+0x193/0x360<br>
      [&nbsp; 242.303331]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp; 242.303339]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp; 242.303347]&nbsp; ? wait_for_completion+0x87/0x120<br>
      [&nbsp; 242.303354]&nbsp; ? lockdep_hardirqs_on_prepare+0xd4/0x170<br>
      [&nbsp; 242.303364]&nbsp; ? wait_for_completion+0x87/0x120<br>
      [&nbsp; 242.303372]&nbsp; wait_for_completion+0xba/0x120<br>
      [&nbsp; 242.303385]&nbsp; __flush_work+0x273/0x480<br>
      [&nbsp; 242.303398]&nbsp; ? flush_workqueue_prep_pwqs+0x140/0x140<br>
      [&nbsp; 242.303423]&nbsp; ? lru_add_drain+0x110/0x110<br>
      [&nbsp; 242.303434]&nbsp; lru_add_drain_all+0x172/0x1e0<br>
      [&nbsp; 242.303447]&nbsp; khugepaged+0x68/0x2d10<br>
      [&nbsp; 242.303481]&nbsp; ? wait_woken+0xa0/0xa0<br>
      [&nbsp; 242.303496]&nbsp; ? collapse_pte_mapped_thp+0x3f0/0x3f0<br>
      [&nbsp; 242.303503]&nbsp; kthread+0x131/0x150<br>
      [&nbsp; 242.303512]&nbsp; ? kthread_park+0x90/0x90<br>
      [&nbsp; 242.303523]&nbsp; ret_from_fork+0x1f/0x30<br>
      [&nbsp; 242.303665] <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Showing all locks held in the system:<br>
      [&nbsp; 242.303679] 1 lock held by khungtaskd/508:<br>
      [&nbsp; 242.303684]&nbsp; #0: ffffffffad94f220 (rcu_read_lock){....}-{1:2},
      at: debug_show_all_locks+0xe/0x1b0<br>
      [&nbsp; 242.303713] 1 lock held by khugepaged/514:<br>
      [&nbsp; 242.303718]&nbsp; #0: ffffffffad977c08 (lock#5){+.+.}-{3:3}, at:
      lru_add_drain_all+0x37/0x1e0<br>
      [&nbsp; 242.303756] 6 locks held by kworker/3:2/2544:<br>
      [&nbsp; 242.303764] 1 lock held by in:imklog/2733:<br>
      [&nbsp; 242.303769]&nbsp; #0: ffff89a2928e58f0
      (&amp;f-&gt;f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x45/0x50<br>
      [&nbsp; 242.303838] 1 lock held by dmesg/4262:<br>
      [&nbsp; 242.303843]&nbsp; #0: ffff89a3079980d0
      (&amp;user-&gt;lock){+.+.}-{3:3}, at: devkmsg_read+0x4a/0x2d0<br>
      <br>
      [&nbsp; 242.303875] =============================================<br>
      <br>
      [&nbsp; 311.585542] loop0: detected capacity change from 8 to 0<br>
      [&nbsp; 363.135280] INFO: task khugepaged:514 blocked for more than 241
      seconds.<br>
      [&nbsp; 363.135304]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.11.0-kfd-yangp
      #1420<br>
      [&nbsp; 363.135313] &quot;echo 0 &gt;
      /proc/sys/kernel/hung_task_timeout_secs&quot; disables this message.<br>
      [&nbsp; 363.135321] task:khugepaged&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid:&nbsp; 514
      ppid:&nbsp;&nbsp;&nbsp;&nbsp; 2 flags:0x00004000<br>
      [&nbsp; 363.135336] Call Trace:<br>
      [&nbsp; 363.135347]&nbsp; __schedule+0x31a/0x9f0<br>
      [&nbsp; 363.135365]&nbsp; ? wait_for_completion+0x87/0x120<br>
      [&nbsp; 363.135375]&nbsp; schedule+0x51/0xc0<br>
      [&nbsp; 363.135383]&nbsp; schedule_timeout+0x193/0x360<br>
      [&nbsp; 363.135395]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp; 363.135403]&nbsp; ? mark_held_locks+0x49/0x70<br>
      [&nbsp; 363.135412]&nbsp; ? wait_for_completion+0x87/0x120<br>
      [&nbsp; 363.135419]&nbsp; ? lockdep_hardirqs_on_prepare+0xd4/0x170<br>
      [&nbsp; 363.135428]&nbsp; ? wait_for_completion+0x87/0x120<br>
      [&nbsp; 363.135436]&nbsp; wait_for_completion+0xba/0x120<br>
      [&nbsp; 363.135448]&nbsp; __flush_work+0x273/0x480<br>
      [&nbsp; 363.135462]&nbsp; ? flush_workqueue_prep_pwqs+0x140/0x140<br>
      [&nbsp; 363.135486]&nbsp; ? lru_add_drain+0x110/0x110<br>
      [&nbsp; 363.135498]&nbsp; lru_add_drain_all+0x172/0x1e0<br>
      [&nbsp; 363.135511]&nbsp; khugepaged+0x68/0x2d10<br>
      [&nbsp; 363.135544]&nbsp; ? wait_woken+0xa0/0xa0<br>
      [&nbsp; 363.135558]&nbsp; ? collapse_pte_mapped_thp+0x3f0/0x3f0<br>
      [&nbsp; 363.135566]&nbsp; kthread+0x131/0x150<br>
      [&nbsp; 363.135575]&nbsp; ? kthread_park+0x90/0x90<br>
      [&nbsp; 363.135586]&nbsp; ret_from_fork+0x1f/0x30<br>
      [&nbsp; 363.135718] <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Showing all locks held in the system:<br>
      [&nbsp; 363.135731] 1 lock held by khungtaskd/508:<br>
      [&nbsp; 363.135737]&nbsp; #0: ffffffffad94f220 (rcu_read_lock){....}-{1:2},
      at: debug_show_all_locks+0xe/0x1b0<br>
      [&nbsp; 363.135765] 1 lock held by khugepaged/514:<br>
      [&nbsp; 363.135771]&nbsp; #0: ffffffffad977c08 (lock#5){+.+.}-{3:3}, at:
      lru_add_drain_all+0x37/0x1e0<br>
      [&nbsp; 363.135810] 5 locks held by kworker/3:2/2544:<br>
      [&nbsp; 363.135818] 1 lock held by in:imklog/2733:<br>
      [&nbsp; 363.135823]&nbsp; #0: ffff89a2928e58f0
      (&amp;f-&gt;f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x45/0x50<br>
      [&nbsp; 363.135887] 1 lock held by dmesg/4262:<br>
      [&nbsp; 363.135892]&nbsp; #0: ffff89a3079980d0
      (&amp;user-&gt;lock){+.+.}-{3:3}, at: devkmsg_read+0x4a/0x2d0<br>
    </p>
    <blockquote type="cite" cite="mid:15106a30-9f85-f0ca-5e4c-b53c60c83474@amd.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		}
 		migrate_vma_finalize(&amp;migrate);
 	}
 
@@ -663,10 +665,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	pr_debug(&quot;cpages %ld\n&quot;, migrate.cpages);
 
 	if (migrate.cpages) {
-		svm_migrate_copy_to_ram(adev, prange, &amp;migrate, &amp;mfence,
-					scratch);
-		migrate_vma_pages(&amp;migrate);
-		svm_migrate_copy_done(adev, mfence);
+		r = svm_migrate_copy_to_ram(adev, prange, &amp;migrate, &amp;mfence,
+					    scratch);
+		if (!r) {
+			migrate_vma_pages(&amp;migrate);
+			svm_migrate_copy_done(adev, mfence);
+		}
 		migrate_vma_finalize(&amp;migrate);
 	} else {
 		pr_debug(&quot;failed collect migrate device pages [0x%lx 0x%lx]\n&quot;,
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============1506509052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1506509052==--
