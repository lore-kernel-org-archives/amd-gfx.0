Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B9C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 15:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2073961176
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 15:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2073961176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0226E117;
	Fri, 23 Apr 2021 15:05:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB206EC1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 15:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUPielnkrHx7KIaHfFebQaQ3dzvuxI6RNAx34PK0TKrV7ewoQm1zZPnQZsO8bn9aE9p7bBj2HdVbYG45RWjlklJgKHlEWUsu/EntJF9RW6E7sxRvjMr6Thmsq+RcKuk1F1lCsPBD1iiONJ/NBaKzYblqOEWHOMyGkFCVyPnvbJXjIwh9ggsXA8+Lh+2vk0ZvmqE/3VdXehhicYMpre+vYVA25uq6tqjSBuvjFLW2wiHAr+GnTX6G+25JUAD6OjZnaDllAu+GlHeo7TWGBf0KJzr1hG75cVM2G0NqRGHIIM7VBJXuz0Av/JX/TURrCGygvcCBU4GbZ6ss57cy7IMYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9Eorp1+eb9wTtXqPTMSSUpRS3j8GTcYhvM2pJ9b7HY=;
 b=P8GkfFLTsKGC62I7zLEPZTmfcszXEkv4Hnf3k5wOKXhdNiUTHB5TXvGJH1xna0F8QYy1i5ls5VtzJQ3WLFCpdED0JmxwNqnOTfP67gqHTUxEQjTqpHPw843S5WV4zOncvy7Xn+pCnyR1XmZoDu3ChqpL7Easg39lomSaDhGCend3DufL49zzd0+AcCbFTzern6YeWX1pUI4dHWUI2V8WInX9ok6gJPpfGbDEp285pfcBx+Kg5GZ2V41Y6dtf5vJ/sF/KiLmWbTBSE7UTikPPu+xIesBfoMW2zPjemP2LcXdijtSfZlS5FJO5lpAKUbEUUpoVHxwf0IQWZ9NVn1Hy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9Eorp1+eb9wTtXqPTMSSUpRS3j8GTcYhvM2pJ9b7HY=;
 b=ThaU+nh7WDh30iDvG27lwbX4waYMsq4FolfuIn/5f+osUoz4uOFXBWZoJsu4TjkPqYTk+yCZZB+P/8dO0K/Otm5jeHHCDiIVFTRXa1JbvPnVsvdgaH/QRe/ztNYANunNFu5JJ7ZlWfmElWb4sn2TWQybZvqLdqW+Hu67lLHLPoM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Fri, 23 Apr 2021 15:05:00 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.025; Fri, 23 Apr 2021
 15:05:00 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: address remove from fault filter
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423020357.31102-1-Philip.Yang@amd.com>
 <40afb92c-cdb1-a20b-0976-a7e783462e62@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <78b91732-54b6-596f-697d-7045a7635ee5@amd.com>
Date: Fri, 23 Apr 2021 11:04:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <40afb92c-cdb1-a20b-0976-a7e783462e62@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 15:04:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac16cff-8baf-4c3c-3671-08d906692a13
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB426784CDB7F77E0EDBDA16E5E6459@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UJtRIeRQkTya/5ESe2TG9DdIjaMoglpIIhx6IFwu2yyhnkWxtbEpp8sjs+nLB4/R31T9exXPQHK4sft748NwOKe+BeT0UYiPBYeiu1YZ9Is/e4TFS9EoYiTN0m7erqqrCuMx1A77kS3HZyadNCbhpw7IRUaHS84sfI1iOSJE3cHqRyAVHmPd4ljTYVWKcR0ITMK9NUVtNDO94Brn9bET8PQ3Km0Oy4lBcAFkvMCTo7YgbkvgfNsiv2oMBLiDMCv7eMuY6HOe7rUwDObWpGoWeYzLtLSMjAFHhRHA2grZyOd3urFKEVrPiMIAjXEKlpTB3fWFM17G6KjziDHYbHVWxRlVRJxDf0rD780+i5uvAtVUEyd9cvvDUafCz9knW3cIczrgY4XSoUwkfMLGBCJCUN+6gWPIwx5y9lK7zWv7vYkzXKp2JVbxWSj/PkmKJwWwoeD5MTlDYIBgWxGemXJD6VG0gOLcPdUxoeSRiNaxpN6+EKgfQY32NrDQbeCF97rGbbN3sxen6LHKa+Uqap5U7Tbwy78CJZYfA5OE6ZdV0WeUBmPgmwasfmQ0twzh471nbZD+ktfKTa/rF0bGvxMODJV2WJxWieAFmCb3Vjba59f6bkZmudkZYke+tfGxSItCPYGwxEo5zGFlrc5UGL/2YxOZwZv1j5LGB9pzN5T5p8YzElf71IA4zi8nWieImJh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(2906002)(186003)(16526019)(83380400001)(26005)(36756003)(31686004)(6486002)(31696002)(38100700002)(2616005)(66476007)(66946007)(66556008)(8676002)(478600001)(956004)(53546011)(110136005)(16576012)(5660300002)(316002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGxKbmtQaWZJbDdEdGE0TmJhTkc1eE81R3U2ZTRBdXoyOXk1akxOeVdLaDhv?=
 =?utf-8?B?bk1MMXFjelE0c3FCUzA5Mk42U1ptck1KaVlzQW0xWUw0dXFJWGZNR3BOeXdx?=
 =?utf-8?B?dFI2K1dvYm9aejB5ZDlUK2V6dHd1Rlc1TThBT3NmQ042SGwvK1FGQytuaVJy?=
 =?utf-8?B?TlFSZytGZ2NvUDA3TS9SQUw1cm9jVU1wTndaZFlPMlpVaTN4UW9qSnlvV1Ns?=
 =?utf-8?B?Tm13eTU0ZkpwOEx2bUVpbDhDdG1vOW5zeUd5Sk5GQkFicENCd2QvSk5lK2R2?=
 =?utf-8?B?ellJbXZieXRlUmFEaTJ5aUVxOU14cmhieGpyc083anA4ckpTaUo1ZWZybmRS?=
 =?utf-8?B?dFFuVVBFNGQ5Z1pwUHRoVm9vd2IxVWxqZERKNVpyTG1ER0NYYlZLblYzYXlo?=
 =?utf-8?B?TUZtZDFhNGRKWWpmSXNuQzFtc1hBMEkwKy9vbjJUOWc2NDgwZW9XbGRQVmx3?=
 =?utf-8?B?eVdBL0R4WWExSUFCMldIU2x0UlR6SjFMWmJ1K1RDUHhaUm1OaVo3cGVoZ1pH?=
 =?utf-8?B?d0tMRVhON0tJTTJxSUFnQXF4Uk10d0crMjBKeFRNOEhoVFFjOUVVUVBENUxq?=
 =?utf-8?B?amMwWXljZjlaOSsxU01TaHNJcVVrMThTUWcycENrYmU4UUxwTHpNNXpseUpi?=
 =?utf-8?B?Si90UEo1Ty9pKzhpdzNHQ0xtNm9Kdkxzb1pxVXZWRm02bWN6R1JRT2poUnVY?=
 =?utf-8?B?SmpMeGh2OWFRcW12S2Ftam5nOE80Q0VQNFJzK0pJVHM3OXdzLzA5ckFTSWt4?=
 =?utf-8?B?WG1VMG1rQ05VSmR2WHFpY2xKM1BXZDNWR2FWcGN4R3M5d0F4U2ZaTW45OGVL?=
 =?utf-8?B?M1hJTU1ZcGp6T2RaOE5TbGtCckpUZFg0VHg5RWhFb2YrVGdIRTI4Mm5qZ1Qv?=
 =?utf-8?B?NzFRL3dHTFBPbGZBMlJZdDEwVGowY2FvRy9BMStITzB5N3NEbGJoZ3c5Zk1E?=
 =?utf-8?B?eUk5MDNrT0dnd1hDVXI5cEh1YjZUU3FqS0lhNHBqT3cybXpzZHU4NzE1MjFu?=
 =?utf-8?B?bHNEdzFndGZTRWJDMUJSZWxIUTJKSmRKb1BOeW1hUE9SSUc2b1dvQjlLM3BP?=
 =?utf-8?B?MzN0UERRRG04SU5nRzZuVGFpMTVJVExON0RRUFJGdUxabHRkZHhLOTArM2hj?=
 =?utf-8?B?aFA1YU9tbjh1VkxSYmZmRk1JbUVvZjZXeUFPUllpZjlDaERuTzBmSTFMcDcy?=
 =?utf-8?B?SkhidHpUbFBGN3JLaVkvdkduL0NOSG83MUJnRCtBa2F0S2xkTlM4elEvcnFD?=
 =?utf-8?B?V05RL3lQRkxnWEF0aWpxbWtobG4yQU9rMEo5R3BRbnI2YmgyaklzNXZJUm5Q?=
 =?utf-8?B?bS9rTTlya1IxT2JjWU5nQUhRNGk4RWRQMTdZenV1K2VJMFlPVWZ2QWYwUUlm?=
 =?utf-8?B?K1dpRXhKM0Fmd094N29xTkVETmJrbis5WDh4di9qaUMzRzZ4VmFoaXdnbFVo?=
 =?utf-8?B?N2Q3Y0M1Wlk2cnlEbm5uamxYbm5hdEYxRTNCMXlpSEp0KzRJaDFiMlZjMDFO?=
 =?utf-8?B?d3V3UmtpQVVWa1kyb0REbnFHaUtYaXl0Wk9GUlFSSEIxZXgvaDBTOVJtM1RF?=
 =?utf-8?B?L1ZldlFqb25Sa1RVU0IxUFZibko0OFZsUjhNcVhCYzA5WlFWenlTS1VDRnFp?=
 =?utf-8?B?NmMzZHpUd1IydzRpenpsdkVXYmU2UGhtSWlrUE90RVM1YVAyRkZzK0krU3BQ?=
 =?utf-8?B?b3JnM25BSVZ4bzR6OVo4UTFPc09OeXFMVVQ3NWFmOWJOUDdzRWltNWlZZjR2?=
 =?utf-8?Q?QdYWxB35yCR4/JW4viRQKL8LhIZFJYNfsVYesa5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac16cff-8baf-4c3c-3671-08d906692a13
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 15:05:00.1128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIhj6CEwDrp3Rk1cevnKunThthfM39TGxdL9Jr23+MJrVsSaOmmZsucRAYE9sjuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Content-Type: multipart/mixed; boundary="===============1458263889=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1458263889==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-23 2:03 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:40afb92c-cdb1-a20b-0976-a7e783462e62@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-04-22 um 10:03 p.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add interface to remove address from fault filter ring by resetting
fault ring entry of the fault address timestamp to 0, then future vm
fault on the address will be processed to recover.

Use spinlock to protect fault hash ring access by interrupt handler and
interrupt scheduled deferred work for vg20.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This needs a better explanation. When you say Vega20, I think you're
referring to the lack of HW IH rerouting. In that case
amdgpu_gmc_filter_faults runs in interrupt context before delegating the
IH entries to the SW IH ring.
</pre>
    </blockquote>
    yes, Vega20 uses ih_soft ring, I need add drain retry fault from
    ih_soft ring for Vega20.<br>
    <blockquote type="cite" cite="mid:40afb92c-cdb1-a20b-0976-a7e783462e62@amd.com">
      <pre class="moz-quote-pre" wrap="">
On GPUs that support IH rerouting, amdgpu_gmc_filter_faults runs in the
same thread as the page fault handling, so there is no risk of
concurrently accessing the fault ring assuming that
amdgpu_gmc_filter_faults_remove is only called from the page fault handler.

Christian had an idea to do this without a lock, by using cmpxchg. I
guess that idea didn't work out?
</pre>
    </blockquote>
    <p>cmpxchg cannot use for 52bit fault-&gt;key, which share same
      uint64_t with 8bit fault-&gt;next. This is compilation error:<br>
    </p>
    <p>/home/yangp/git/compute_staging/kernel/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:435:22:
      error: cannot take address of bit-field ‘key’</p>
    &nbsp;&nbsp; if (atomic_cmpxchg(&amp;fault-&gt;key, key, 0) == key)<br>
    <p>Vega20 interrupt handler and deferred work access fault hash
      table and fault ring, not just fault-&gt;key, so I decide to use
      spinlock.<br>
    </p>
    <blockquote type="cite" cite="mid:40afb92c-cdb1-a20b-0976-a7e783462e62@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 66 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c39ed9eb0987..801ea0623453 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 			mc-&gt;agp_size &gt;&gt; 20, mc-&gt;agp_start, mc-&gt;agp_end);
 }
 
+/**
+ * fault_key - get 52bit hask key from vm fault address and pasid
+ *
+ * @addr: 48bit physical address
+ * @pasid: 4 bit
+ */
+static inline uint64_t fault_key(uint64_t addr, uint16_t pasid)
+{
+	return addr &lt;&lt; 4 | pasid;
+}
+
 /**
  * amdgpu_gmc_filter_faults - filter VM faults
  *
@@ -349,15 +360,20 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 {
 	struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
 
-	uint64_t stamp, key = addr &lt;&lt; 4 | pasid;
+	uint64_t stamp, key = fault_key(addr, pasid);
 	struct amdgpu_gmc_fault *fault;
+	unsigned long flags;
 	uint32_t hash;
 
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
-	if (gmc-&gt;fault_ring[gmc-&gt;last_fault].timestamp &gt;= stamp)
+
+	spin_lock_irqsave(&amp;gmc-&gt;fault_lock, flags);
+	if (gmc-&gt;fault_ring[gmc-&gt;last_fault].timestamp &gt;= stamp) {
+		spin_unlock_irqrestore(&amp;gmc-&gt;fault_lock, flags);
 		return true;
+	}
 
 	/* Try to find the fault in the hash */
 	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
@@ -365,8 +381,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	while (fault-&gt;timestamp &gt;= stamp) {
 		uint64_t tmp;
 
-		if (fault-&gt;key == key)
+		if (fault-&gt;key == key) {
+			spin_unlock_irqrestore(&amp;gmc-&gt;fault_lock, flags);
 			return true;
+		}
 
 		tmp = fault-&gt;timestamp;
 		fault = &amp;gmc-&gt;fault_ring[fault-&gt;next];
@@ -384,9 +402,51 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	/* And update the hash */
 	fault-&gt;next = gmc-&gt;fault_hash[hash].idx;
 	gmc-&gt;fault_hash[hash].idx = gmc-&gt;last_fault++;
+	spin_unlock_irqrestore(&amp;gmc-&gt;fault_lock, flags);
 	return false;
 }
 
+/**
+ * amdgpu_gmc_filter_faults_remove - remove address from VM faults filter
+ *
+ * @adev: amdgpu device structure
+ * @addr: address of the VM fault
+ * @pasid: PASID of the process causing the fault
+ *
+ * Remove the address from fault filter, then future vm fault on this address
+ * will pass to retry fault handler to recover.
+ */
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid)
+{
+	struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
+
+	uint64_t key = fault_key(addr, pasid);
+	struct amdgpu_gmc_fault *fault;
+	unsigned long flags;
+	uint32_t hash;
+
+	spin_lock_irqsave(&amp;gmc-&gt;fault_lock, flags);
+	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
+	fault = &amp;gmc-&gt;fault_ring[gmc-&gt;fault_hash[hash].idx];
+	while (true) {
+		uint64_t tmp;
+
+		if (fault-&gt;key == key) {
+			fault-&gt;timestamp = 0;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Setting the timestamp to 0 breaks the chain of interrupts with the same
hash. As you can see in amdgpu_gmc_filter_faults, it uses a closed hash
algorithm that looks for the entry with the correct key until it hits a
time stamp that's too old. So resetting the timestamp will break that
chain and effectively remove all entries with the same hash that have
older timestamps than the one you intended to remove.

I suggested invalidating the fault-&gt;key instead, leaving the timestamp
alone. This would effectively remove the entry from the hash chain but
would still allow amdgpu_gmc_filter_fault to find older entries with the
same hash.</pre>
    </blockquote>
    <p>thanks, I understand how this closed hash table and fault ring
      works now.</p>
    <p>Will send out v3 shortly.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:40afb92c-cdb1-a20b-0976-a7e783462e62@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+			break;
+		}
+
+		tmp = fault-&gt;timestamp;
+		fault = &amp;gmc-&gt;fault_ring[fault-&gt;next];
+
+		/* Check if the entry was reused */
+		if (fault-&gt;timestamp &gt;= tmp)
+			break;
+	}
+	spin_unlock_irqrestore(&amp;gmc-&gt;fault_lock, flags);
+}
+
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9d11c02a3938..0aae3bd01bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -246,6 +246,7 @@ struct amdgpu_gmc {
 		uint64_t	idx:AMDGPU_GMC_FAULT_RING_ORDER;
 	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
 	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
+	spinlock_t		fault_lock;
 
 	bool tmz_enabled;
 
@@ -318,6 +319,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
 bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 498b28a35f5b..7416ad874652 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -839,6 +839,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	adev-&gt;mmhub.funcs-&gt;init(adev);
 
 	spin_lock_init(&amp;adev-&gt;gmc.invalidate_lock);
+	spin_lock_init(&amp;adev-&gt;gmc.fault_lock);
 
 	if ((adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp; amdgpu_emu_mode == 1) {
 		adev-&gt;gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4da8b3d28af2..3290b259a372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1444,6 +1444,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	adev-&gt;mmhub.funcs-&gt;init(adev);
 
 	spin_lock_init(&amp;adev-&gt;gmc.invalidate_lock);
+	spin_lock_init(&amp;adev-&gt;gmc.fault_lock);
 
 	r = amdgpu_atomfirmware_get_vram_info(adev,
 		&amp;vram_width, &amp;vram_type, &amp;vram_vendor);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============1458263889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1458263889==--
