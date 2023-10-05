Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7195AE92733
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FA910E48A;
	Thu,  5 Oct 2023 19:42:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA27810E48A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaOucWtCgq/xn21UYheJBk7pblCgRiCfZ38b4gU4qoVh7FldhFr7zZuh8lcs5956gUA01MXzx/emOVDxWn7ac7b2IPVjd3MXFEZCpqey07UqeeZmUO+WhbhmucFwyQ4ndZAoA81p24R+JSc2nuyFg+x/zP6S6q6cMZ8SKYkP4at2s+7J8YEWtz/Ne9ta1F66FeXHqFFESY5iTk+WDhFTEA8Y5ENaFw8MJKiwmJOu6pqT5iNITjAqjR+0h5w0oIQqkbMfnoAxEoyCrcPK/DADpEiFxOkT/9wWFO6D33tgO/p2hIbMxs/3OxL2BQRZcwg02OGzbERDWwL1v+pHqcl9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi+enL7m246uvHBhbktuVSlTFAlI1IaeUE9dkr+B8d8=;
 b=kvH2LHBMnvXAOQhoEgtyZwUeMYM5Y3cTu74eLy303HKt9IoQREo0trZfA82lQdLcnXuCScd6LQA2C4+nOQgC5Uvo5yaNN7/RvMBhxns9yptqhC6Q5G9GaDRuxsPfkdz75G6fDm7iEUm7SIxBkfryJC5Y7oAgFD8XkttZcZlGPCYmd5MCd6uesD6lK0hik37WkERtlrnFqurboUFbRLnP8BG7dktuU+/ietPwHi81AqQyAexfdsZs0qS6WTPG2zhB4pyjrfDTvZt9KiYfkUi/kBe6g5Bzf8dT+W0cSfa+wJvSeZ/a53fP9CqgrLVfg1LNtFTUEa/xiq0wTzQ/VSymfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi+enL7m246uvHBhbktuVSlTFAlI1IaeUE9dkr+B8d8=;
 b=LbfH4G8gXgnhfYBbHmniLRMY/eHs6q/x9zwi9SuGv185fi7wbxoQYkdZSn5GUxPHElsPsPg2A2I4ARuBnQ3HHGU/zdLn+yzOwHUI6g4FMP4RvreNp64E6024WrhXO1pDWLKPBkmdRFZFmlcJ17cR7HSkMb8eQpZyEQTorwhNwBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 19:42:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:42:41 +0000
Message-ID: <844d1ffc-156d-1aff-ac4c-6525d9147470@amd.com>
Date: Thu, 5 Oct 2023 15:42:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: Check bitmap_mapped flag to skip retry
 fault
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-3-Philip.Yang@amd.com>
 <678650fb-8fb1-7f2c-cdb9-6a01d9095a34@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <678650fb-8fb1-7f2c-cdb9-6a01d9095a34@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc77f59-5555-4b69-dc83-08dbc5db3cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETglTwuMmz9MiqZxwMcJ1jPv1u8nrfPicHzF3wycjyGQtcSBPHW/wZIsuEXAeH6yByUklM5UwHlOc/7mYkdhxLt16xk3en1BYuyfCXePj8cEZJvn/m9mYif0/OT1lwKGflGm8qasMiSoZ4Dw9GF3s1IQRA34xZArkfLn2R3lG3nifPR7zwFwy4TXXiS4KDJrb06a3Hw1Uxq7miEUD2pPLn7Ox5EX5i10J3D8IUOxuCF2hQbcd8cHhK92kpOqDlFy49sTU3ytNoZMRIpdomRiVA48pUxxqTo+3hvE6B9UZ145MXEoJBCHOCbQg77TsRZBnCWz1VgWNpFOnD8uUVakmoO1XuqtlXbAWoODYEOhJIAOwd8V147h1WKM87BD7RdyPEENNgp2NEepx6dxktxVYDLRluk0zlhYrErhBTxaNRoV1YtFK4oymgkTMCQrk2sGM1Qfuf2JDbndTTuBdX18Fg9RCynvyMtaLLVAuOn7j4FoBM7iOhrs5IBQ8ebejlMaI7v7FUxIE1DPM4QNz0ilx7xsehKt4H+wwYsvztcS8ZUKEPUGTuNXV52ys2+F9HOWPxlLYlDXCLK7w/6AAYIrIU6WIapfpiogVVdRaHg46wi2W2sgYKJDI7TqsdZVia/7aDL0HkU1ba2YXSbZ/IkA3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(6506007)(53546011)(6486002)(478600001)(83380400001)(8676002)(6512007)(26005)(2616005)(316002)(2906002)(41300700001)(66476007)(66946007)(66556008)(110136005)(4326008)(8936002)(36756003)(5660300002)(38100700002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC9BclZTRnJSeG1ZblNKbmdEbHg4OVg2TWx2K3hmWWFiUDA0RnNBb1dJR2tu?=
 =?utf-8?B?VWJ3ZHlNdXpMTlAwVUk3dyt2LzZYdDlleE0wSG5iK0doT3BHVjJOaFdPaHBt?=
 =?utf-8?B?dnhzNE1IbnFJK3NENGNBdmVRMTd0TUZSMXNtbGdnNkVnUHNJblRrQVRYUUc1?=
 =?utf-8?B?dU1qWmtnKzltT3lWc2NPdzFwQ3kwZVNDTWdhb09rYW1wVHVJKy9odG44V05P?=
 =?utf-8?B?RmhScVVkbzIvcCtVZWVPdUEyV1BvUkVidDI0UTVxOCs4aUhsSGFyQ2pYaTMv?=
 =?utf-8?B?d0piVDV1UTJIZjFhQ3VDTlBlaUM1Q1h4ZWF4RVpwTVlib1B2Und3YklqY2JB?=
 =?utf-8?B?TVRZZFh1VW5yMzBzV0hrV3FidlM5TGZqR2NRVUw2OVlITHpIK1psQlhBQzdh?=
 =?utf-8?B?VzJPeVVYWm92T2YzQm1RenB4NHMydktwTGhOVU5RSU14MGYzYXp2QW53ZzdD?=
 =?utf-8?B?MTBpYVdYZGt0NGtzMER2N2pndW92bk5OQ2JnTzBqVk93NFJuV1BRUGMxRGxp?=
 =?utf-8?B?TUg5emNhaUJmOG45c0NLTmtqcy9MT1AyNGorU2JGN0JQL3RhVGFPckRrelZH?=
 =?utf-8?B?TC9ZZjVIaDY1V2hiVkhjT3pUdmZ6UjJCTnYwWjRsNGFIZkd4WHU4cEt5WE1J?=
 =?utf-8?B?SFlmdUJXUmp6VzdyQytxVHJML0ZnUm9DVG9pV21rRzBaSlFVb0czcmgzZTIv?=
 =?utf-8?B?ZmxQOS9sano4TWJ3Qmw5UTNBRWV1S29SR0FreHlMZ0Z1eGZXU0tQd1V0VStY?=
 =?utf-8?B?cXR5V29KVWRJVGloYVpSZ2VvUXUxcXlORDE3eFh1OU0zdUtCZEtUTXFldENF?=
 =?utf-8?B?TnV3QjAvaVhyZjhaNG5YdzNRMmlwTTdWYVdnRWE0MWFacWtwbVRLM2VzUGM2?=
 =?utf-8?B?dmdIQ2xQMjNxY0JUYmZuYURUcjFhSjJ6OHl0dlB0bVZCZDdUNW1nVmo3TEF4?=
 =?utf-8?B?Y2JncU4zRjVrVkg2aWNyOEZFQVpvaWxPYk1jWjJPSTZURVNlMTZCZCtCVG9B?=
 =?utf-8?B?dzJKbTdtb0hrSzBwdkdiQ091eHNkcHdJSUR1bzhudEx2NjAxSXNMTGY5K0dG?=
 =?utf-8?B?WnFXS2ZZM0lXM0RIMmxvRnJrc3BVUzVCcCtHeWQ2bHJMbWxyci9BRStwaXdh?=
 =?utf-8?B?NjVKL2d3NGxzb2FiZFk0SzlRbW1yMk9Ud1Ryb0hWYlRwZkM3ZEVTVE1QdE4z?=
 =?utf-8?B?alJEUzdzTWt3WWl4a25XR0t6M2hTR255YlIzbmc5Vk5QVUY0dDR6bWtsVlFW?=
 =?utf-8?B?c3pFUVFBZmVLRGZrN2RWaHJSZzNQNGV3T01UM2FKTjZuVVQwUFpvakJHdHBD?=
 =?utf-8?B?cUUvTjgwc3Q3Sm5mWk1pNHhrTmp5NVB6Z0xzWDBYM25EZWt3R0ZkWnN0QmJt?=
 =?utf-8?B?MjlqdytnL0pnRXpyTEdvVnFOVUhoZmozdE1oR3B1NDV4UVFpR2dtSHdtdG4v?=
 =?utf-8?B?dld2MGtiMk5iNkh3akZDL2Rua2FSSDRBc2NqWWdlTTJrNGY4QXhEOVk0ak5t?=
 =?utf-8?B?SU1DSUorV1lXMXVvbjJCS2J5NHlNYnUydkJoZ2hhK2ZtQTVCdEd2V1RoZUpu?=
 =?utf-8?B?Q1FvZjJ5SXZmWDlielA0ZEZBaHBZNHJRb0ZSZ2k4WENjb2VPTEEyVUxsY0Fz?=
 =?utf-8?B?bTBDZ3F4bFpMbWw0NEVZdmdERHBheFViWnUyMldqZGZWSGc1dXIvcng2b0Fl?=
 =?utf-8?B?SE81M1k0VkIzdVpuVVNGVytXL2JkTHcyanpFbEdDYjNXQXRuaVhGQzRwSnhR?=
 =?utf-8?B?bUlQQkxHcE03Uk5BOU5HVHRzYytyR2lrTkRsZ2h0WlZsM2J0NzJia05ENEN0?=
 =?utf-8?B?VExWTlRIdklTU2lZTkx0TkRTa3NzZ2FDNEM4Y0txUzlpYzlKSGk0dXUwU25G?=
 =?utf-8?B?SktiTVM0T1g5NEFvT3VxN0R3VWRUdWxPUXJGOTl6NlExOFFId2lLKzEvRFJk?=
 =?utf-8?B?RlF1VFMvclhwSWF1b0pmb0JYVGtnak1uVGtwMDJ2b3hXaS9lVTcrdytnVkpS?=
 =?utf-8?B?NzJ4QnZ3MGIvZ28xVmdob01wSEZFUGZDTDZwL0YxOVR2MmZSYjhzUVBYbldn?=
 =?utf-8?B?UWg0VG9rUndzd1JaQjU3R1Z2YnJhTlNGM0Ryd0FFTU1QNk5WT2JjLzBBemFV?=
 =?utf-8?Q?U14Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc77f59-5555-4b69-dc83-08dbc5db3cda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:42:41.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lJEcuArWQHgzuNYBtV142wWlaSyavyuYB0xx8aVmQvRQObLHUlFPxE0SoiGGVJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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
    <div class="moz-cite-prefix">On 2023-10-02 13:08, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:678650fb-8fb1-7f2c-cdb9-6a01d9095a34@amd.com">
      <br>
      On 9/29/2023 9:11 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        Use bitmap_mapped flag to check if range already mapped to the
        specific
        <br>
        GPU, to skip the retry fault from different page of the same
        range.
        <br>
        <br>
        Remove prange validate_timestamp which is not accurate for
        multiple
        <br>
        GPUs.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24
        ++++++++----------------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h |&nbsp; 1 -
        <br>
        &nbsp; 2 files changed, 8 insertions(+), 17 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index ac65bf25c685..5e063d902a46 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -43,10 +43,6 @@
        <br>
        <br>
        &nbsp; #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
        <br>
        <br>
        -/* Long enough to ensure no retry fault comes after svm range
        is restored and
        <br>
        - * page table is updated.
        <br>
        - */
        <br>
        -#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING&nbsp;&nbsp; (2UL *
        NSEC_PER_MSEC)
        <br>
        &nbsp; #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
        <br>
        &nbsp; #define dynamic_svm_range_dump(svms) \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _dynamic_func_call_no_desc(&quot;svm_range_dump&quot;,
        svm_range_debug_dump, svms)
        <br>
        @@ -365,7 +361,6 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;deferred_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;child_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;prange-&gt;invalid, 0);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
        <br>
        <br>
        @@ -1876,8 +1871,6 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unreserve_bos(ctx);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp =
        ktime_get_boottime();
        <br>
        <br>
        &nbsp; free_ctx:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ctx);
        <br>
        @@ -3162,15 +3155,6 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip duplicate vm fault on different pages of same
        range */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ktime_before(timestamp,
        ktime_add_ns(prange-&gt;validate_timestamp,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx %lx] already
        restored\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, prange-&gt;start,
        prange-&gt;last);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* __do_munmap removed VMA, return success as we are
        handling stale
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * retry fault.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        @@ -3196,6 +3180,14 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip duplicate vm fault on different pages of same
        range */
        <br>
      </blockquote>
      <br>
      I think the following call means if the prange-&gt;granularity
      range that the addr is in is mapped on gpuidex already, not
      different pages of same range.
      <br>
    </blockquote>
    yes, the comment should update to &quot;skip duplicate vm fault on
    different pages of same granularity range&quot;
    <blockquote type="cite" cite="mid:678650fb-8fb1-7f2c-cdb9-6a01d9095a34@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx %lx] already restored
        on gpu %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, prange-&gt;start,
        prange-&gt;last, gpuidx);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms %p [0x%lx 0x%lx] best restore 0x%x,
        actual loc 0x%x\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, prange-&gt;start, prange-&gt;last,
        best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 10c92c5e23a7..3afc33a3dd30 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -125,7 +125,6 @@ struct svm_range {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invalid;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validate_timestamp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmu_interval_notifier&nbsp;&nbsp;&nbsp; notifier;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_work_list_item&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_item;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deferred_list;
        <br>
        --
        <br>
        2.35.1
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
