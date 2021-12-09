Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F125CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 19:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6956E10E238;
	Thu,  9 Dec 2021 19:20:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA5A10E238
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 19:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5XqIkocMJwnQlFBZhNqfnYXQIhgY/q1uHG415uwDvJUPQmYwthCyNW2oRKEwwYHVeu6pb397WyOs+tJfHkoKtGOpMFbG/i3gA4ce9Jq4aKlw4ud6MtlVxLsvXU0ijQGPorKGzpgJz8/DBEOHn1WykMJubIEakL9tiS7Ptm4lY+rXuT7WE8zpUvHY3ZiJIkPlUYyckoFrBzn2JLpPK4CxFq3Ydt07F4ZHlTiJBVNP5XpN/UBUfyvsSTaQxrYxhd6PdIxDoj9w+UurvdAhu9q+7/Vt7ndaRFPviV1aPOXxFsYcWDeJT8iBflcETkrQfHC1N9ooHaRSo7zKMFGfEh3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHgJa9mQBPtTFCfsrdxjEJ8Mfv4UqWgLNLw39/ZA8EE=;
 b=YfgVYMzkTZOmd/Nf9x/I3R2ZgbkVAg5EnbkHnD9qSttlXmapulYGeoPZcyRl/1iNo9jFSzIOrKCzMK2kpI5lBzMg698ZdQY0NR/Nj72XtAhq8x4jcjH7Q7iq5NWhZnVbWy9oR/mnVJyMMojKGip5okpbkZtZWFrr/9NhpsaoXLAzHikyIL+Uq5h6hCgIhBmEH/I//1frwlbWdhlDbOGm3rSTxNSSv9jBXjisEU+/yhJqo03kpE/idsAaPB/GwKFE5tGg3IQfNtMhqfCSBKs/9LSkHemmEXO3oaSLWLTzQlMFSN2vx9uxiKFKJIXfpK4uAkzg+Cb3HTr3VQIn3/xPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHgJa9mQBPtTFCfsrdxjEJ8Mfv4UqWgLNLw39/ZA8EE=;
 b=l5kRDu6Q3wBuzdoKVr9kd6FnAOjyux8OYotXSmpSC9z7xLy9iCebESbZWj26VXCBdZeeSwfhu3gRaqZa2E2zhm2pXM8AikRJ1KX5heYW6cpjgcz0rs+OuVIoYyics6l0ppiymfMicXngBbnz17t8RX58JkxZJaB33k661tnDK3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Thu, 9 Dec
 2021 19:20:36 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%5]) with mapi id 15.20.4734.024; Thu, 9 Dec 2021
 19:20:36 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Use prange->update_list head for
 remove_list
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209000340.974954-1-Felix.Kuehling@amd.com>
 <20211209000340.974954-2-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <9d19fe31-2f02-6d69-6ed3-22f5e018930a@amd.com>
Date: Thu, 9 Dec 2021 14:20:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211209000340.974954-2-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:208:32d::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Thu, 9 Dec 2021 19:20:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c478ee-82c9-4bf3-c5a3-08d9bb48fa5d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5181B2F882CC97775A34AE3BE6709@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXD5DvAgUz6bGduzdLF7V92e/VWl1Ar5lLBEN+piwmb84oJSxsGRg4TlPB4qkdR83hlWEsVa0EQ15KrqgKyqWJpB0bTO8uHYDOhmtjnhl9vehuSEr/Ei81BMZFmxX/ESqfoKJvjIOBzzoBK20ZSH3aa14E835cyK/jkdSepjPuRZofDTS94ERvqhcdpt/uqRQwIXOYMnH1zsMs2Ippv3iPDZ8tvACwg1ac4CD0ZtABzJg+aqjKp+H+D4FlkSxIh0HfuhVBncsktPn7MJ6xycu3A3yHRl+7K5V+e78hfS9Vp5ok0XJgraVP9lQj6jHIw1IX3xyXTYe8CI507O3iKmEw4jjnkXIM4NzbS5hPxB/k/gkVsV6aRSUermlbTjAcp8iq1qgctvge0npF8EXckyntzUeDw2cDBKY/Cxgyz6ncInA6W2SACQd9n3lDvSSs9cJAyyrGA3oQFXAzYRCdIfRHzME5WQFAK4I0p9Z7t50FB2xWuVho7hTgLBUwGRq07IbzEthIsY1oCXO61AJaI4VqfXj6eJjxqIi0RPLDH4Q1ahw+WKNEKjH2ufwY42C0wPeGXJbb/5NHpMVvDqco0AWFsHJu29i/RnZn48STMkCMMIEwDkIKdYifYgKpDHw4lrtED6TqfM6x0xpIU0UcLy8wVGZx+uvhp6/fRXQvtoqEQT0xYvSZJpb3sN7hVnLanu0G96jQbKUylu4TKCxH6JRgo5ScsrO/WBOPS0A6pFofSFjcFj+sIFRIawBRza+3Gd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(26005)(31696002)(15650500001)(2906002)(53546011)(36756003)(83380400001)(31686004)(316002)(16576012)(38100700002)(8936002)(6486002)(956004)(2616005)(5660300002)(186003)(66556008)(508600001)(4326008)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emUwY2dSSU4zZU1UNC9iUGZEN0YzSlYyNWdKbEpCVFo1WmdtL0JQdXFNY2dr?=
 =?utf-8?B?U0FxaktzSVZaVHY1OUdFQzJVL1A2em4yNUV6Szc5S1VBblBodjVxZUxrNENx?=
 =?utf-8?B?cjdSS2NMam9kZkNIbCtJZHVmTys2aUd0cXdFSVhjZDhhTDNrVElhaW5MM3Iy?=
 =?utf-8?B?MWo4K25RNU9LeldkMUxiNjdVWkwyME41ekRrVkVreVc4YmU5Y1I4MzBJVXlM?=
 =?utf-8?B?YU5QR0lsM3hiaU9pM25UMlYycW9yOTY2UUk5MWlQa0lJKzdyYlFEZDBqWFdI?=
 =?utf-8?B?SDNHNUNRSEdFVTBmbXhueTRRTHdtb0Y0cGZ2djB2TlhPWVM3bFNuR2IvNkhH?=
 =?utf-8?B?OFdjQmNyd2E4c0NvZ2hmdUVKSWExNEtmQ0s1STZMMzI0NzR0RkdvdmJCazdi?=
 =?utf-8?B?aXZpcEhnaE41c1VLdE9HQlB0KzY4cklXdHZFMXR4OG1mYjN0VWUxdEYyMXhw?=
 =?utf-8?B?VTk2WThkQklUWXVHUHFrYXZNZlhpYmREZFNjNzA4RlI1anBReVlXSjIyRGNt?=
 =?utf-8?B?d0xnUENlUTNjWjVtWGpiVU1iL0VXcU5OM0RMeWEvMEdVd2E1RUd0clZSZmJV?=
 =?utf-8?B?QjlNRnMrVFhzd3JkcW15blhiMEFiOGdRUGdSemxibmk2ZnVWeWNxeUhVc1BK?=
 =?utf-8?B?cnFkL05tb2dsbWhIWXJXT29PVEhSRXFHZE5zMVVuT2lKOGJlejU3d3hVNWNB?=
 =?utf-8?B?WlNaNGhJVWVCdDZ5aHJUSS9YTjBMWDBjVktjNGRDWnU4VjRERFpVUGN3RmIz?=
 =?utf-8?B?VkRVdWEyTTl4aDlSZmJhRVRWUHN1c2xkVmJLa041S3AyWTVlRllDN01wZDN5?=
 =?utf-8?B?ZUwzNDRoWkdQaFJINFRraXIwalRYaEF0cEtqb2hRTHpPQzlKMWFHbFBVL2xl?=
 =?utf-8?B?WndxVmhMaVFxcDFPTFQxUldqaDZHNDY0emFnamZISHh3aTNOSHVYREdiV2V4?=
 =?utf-8?B?bTZ0R3VYTERZYk1kVkh2WkJ1ekJ0MWdWelczWmhGYjhBYk5ORXVXNEhDdmJv?=
 =?utf-8?B?OXJpeE9zVnhzYmlxMDNXZFp6MTB6SDI4dlY2cDZxUHVNeGlUN1dkTldIRW5n?=
 =?utf-8?B?dnZBYzRMYWRtNHA0ekRRMmtWSmlqMXBRLzlyS3Yza0xiTDNYN2NYTnNUV0dE?=
 =?utf-8?B?cWI5U1F4Tlp4L0NNNlBsdTR1andIbmFoRHVwaHZIMjF3dFpOMmd0bGIzWkxy?=
 =?utf-8?B?eXgwRXdnMHVxaFR0c1FRZ0R3UXNobnpMTUc0bVh2azJoNDlyOUhpenB6Uzgw?=
 =?utf-8?B?QmtScmtqcHVWZk94cXVUUVlkb3c1SzZrTy9oTDEvb25XNDk0OXoxV2cvakFW?=
 =?utf-8?B?MHVGS2ZIT0JTK3lZeU1VamcyK1p3UVJXWWVWcm5vMlQvdWlJUHF2N1VXNmZE?=
 =?utf-8?B?cjRkdDI3UkRzY0grenNDVnYxelRFVEZmYUpObHZGdktBM3d3VlRMcVQwRGRO?=
 =?utf-8?B?QkFPYzZVYW5hcmlEVnhXbkZXdWZEZ1JiaVBsWm9HZ29HSmNRa05IV1RBSjdn?=
 =?utf-8?B?UEgrQkRGMkV5MDhaS3lqcndsbUV5MEtYT0w4QnZiYk9RcE16QUprRExGaTNI?=
 =?utf-8?B?czBQUEx5Ym5hdEJuSFFSSWJYN3FzZkNqeTh1SjJmdzhCdnpHUFp4a3orVSti?=
 =?utf-8?B?RU83M0xYS2RPdEJ0MVZ1ZTg0MVNma1B0VmZMb1NLZWk4OGpMTTVPWUgxRk10?=
 =?utf-8?B?MWMxSkxRcTBSK0RqYTJETmFWNE5nWWZmd0Jtd1F5eUQzWFJwOFFRNm9ZTzdi?=
 =?utf-8?B?SWRCL1M4YUFmU1lndjBzeTRnTytuckpVYWY2T2Z1K0NlMDFidjNWYmJNOWl0?=
 =?utf-8?B?cjVOQVg4QjVyQW1tMzRJcytGQ3h5Yk5GaEhiOWJ3c21rcGNIM2pFellySlNY?=
 =?utf-8?B?T1cwaTR0VkF6Qzc0WkdwdHhGOUlEWG1qc3JoYm5peDJ2RmQyY3pHMlBzZlJL?=
 =?utf-8?B?SzUwMk5QcC9pV2lqYnBYRXdSZjdKbXZGZktNaXdEU3o2TkhmbWpHNXFiVEtG?=
 =?utf-8?B?bmtKbE4ydWZ2RS9OOHpLR1hyYXlmYUlZa0VDNWM1eERPV2x5aUFESEl5bGVM?=
 =?utf-8?B?a25OVnpvQ3lidjJMRzF2djdvVEc0V2lWbDhUOE9udFQyUHhUSXd2VURRcUh6?=
 =?utf-8?Q?lDeQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c478ee-82c9-4bf3-c5a3-08d9bb48fa5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:20:36.3130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXWZ59CD8F9Bg87sysKIj1VS3Dwrpmbuycx0PAJfcV3nNzaGcGnGhnd5TTwnAHet
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
Cc: alex.sierra@amd.com, philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-08 7:03 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211209000340.974954-2-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">The remove_list head was only used for keeping track of existing ranges
that are to be removed from the svms-&gt;list. The update_list was used for
new or existing ranges that need updated attributes. These two cases are
mutually exclusive (i.e. the same range will never be on both lists).
Therefore we can use the update_list head to track the remove_list and
save another 16 bytes in the svm_range struct.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a></pre>
    </blockquote>
    <p>one nit-pick below.</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a></p>
    <blockquote type="cite" cite="mid:20211209000340.974954-2-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index dea7c6236be5..ee7e1eb7394a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -295,7 +295,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange-&gt;last = last;
 	INIT_LIST_HEAD(&amp;prange-&gt;list);
 	INIT_LIST_HEAD(&amp;prange-&gt;update_list);
-	INIT_LIST_HEAD(&amp;prange-&gt;remove_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;svm_bo_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;deferred_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;child_list);
@@ -1878,7 +1877,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 				goto out;
 			}
 
-			list_add(&amp;old-&gt;remove_list, remove_list);
+			list_add(&amp;old-&gt;update_list, remove_list);
 			list_add(&amp;prange-&gt;list, insert_list);
 			list_add(&amp;prange-&gt;update_list, update_list);
 
@@ -3225,7 +3224,7 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		/* TODO: unmap ranges from GPU that lost access */
 	}
 	list_for_each_entry_safe(prange, next, &amp;remove_list,
-				remove_list) {
+				update_list) {</pre>
    </blockquote>
    This line can be combined with previous line.<br>
    <blockquote type="cite" cite="mid:20211209000340.974954-2-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		pr_debug(&quot;unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;,
 			 prange-&gt;svms, prange, prange-&gt;start,
 			 prange-&gt;last);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c3738bd35a3e..5edbd7dccad0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -75,7 +75,6 @@ struct svm_work_list_item {
  *              aligned, page size is (last - start + 1)
  * @list:       link list node, used to scan all ranges of svms
  * @update_list:link list node used to add to update_list
- * @remove_list:link list node used to add to remove list
  * @mapping:    bo_va mapping structure to create and update GPU page table
  * @npages:     number of pages
  * @dma_addr:   dma mapping address on each GPU for system memory physical page
@@ -111,7 +110,6 @@ struct svm_range {
 	struct interval_tree_node	it_node;
 	struct list_head		list;
 	struct list_head		update_list;
-	struct list_head		remove_list;
 	uint64_t			npages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
</pre>
    </blockquote>
  </body>
</html>
