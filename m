Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCBFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 17:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C53A6F9B9;
	Wed,  8 Dec 2021 17:44:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5476F9B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 17:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFJjMof0xKbVRXyQ6m4TB6QMrG8l+fGgWv+oPJ4GNW87D8dRjJ8GnzeJgJ4xelH0vNUe4OZUMNBXtGNeTb0P/Gu3uH+TCCdD68N2m9EOPV7ISiHsu1hulzbPf3jzp0B/Qjp+uqIH9Ur61x4Q4ahumhqMkCiKFU6RthYj386AK4TxvLOqJZeLP6AhA2qGShpwkeXh2XX9u9DbUNp8Z14jQeVFctFF9rT+Hlw/dypnB9vNx6zUoJQCYE4cSXZ2adQT1N3Qzzl990FbjQPxKn416s0pSHVBPgsb84oZPm14j55lrJUptJnnoDs6NGMrx5Pn8T0+22yIPdL7wNrf0X738A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbbGWj1xeUUDQGPIOLOWK12iLJDzmN+xT4ET43ww1zY=;
 b=PpvtzynA5VPmeRpbWXvh/fXFLDuql4r7zQ935TqEiaIQ7hBpoMrEtj2lAwkgN4d/QW3uRvK9z1eH0FgULdrU1Zbl3aPO1QWlr9w9iTGYZA+rPS0glnHdGLMCCc+yu2eGs4G/xT7m5SAwess2s7vz98wEKLiasxEEhR9E28bEoHL+MXsrhz+/WX2s2QI+5vuME5l8DmOCRcqI8jiqG7ZfuLOjZmCzRNPFeDuJpFSdswKI0ddqNAhM90FjMX3Dy87vnb1ouDxynpkmeqcveqiQdYERkiWRecLskikGRc27fepV+7CUg64AXg7nTkKvi4bvtorTJtw5Ek1lZnC8wQ2oVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbbGWj1xeUUDQGPIOLOWK12iLJDzmN+xT4ET43ww1zY=;
 b=Qud7ofgkuYNNzwS5Zem0MzygqHRuQa7QJkfJZt5s6HuCmXpY3cPYfiBFNfzVqNxnfcPpxP22qw12tfgwyye9SlpiYbnkMvjxxLGoPfXWRbgO+bvQDw6O5RJdGFYLj40RIZsl8s7RCmf2iwdTNVXJnOGeI/kV+dUH66gUba80ByU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 17:44:56 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::d3e:78b2:716a:3302]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::d3e:78b2:716a:3302%6]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:44:56 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: Don't split unchanged SVM ranges
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211208082457.918004-1-Felix.Kuehling@amd.com>
 <20211208082457.918004-3-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <fbcab4e7-e611-1ed0-6aff-4b3d150e192f@amd.com>
Date: Wed, 8 Dec 2021 12:44:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211208082457.918004-3-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:610:53::37) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 CH2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:610:53::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20 via Frontend Transport; Wed, 8 Dec 2021 17:44:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e3d848-ca6a-47ba-2f24-08d9ba7272ba
X-MS-TrafficTypeDiagnostic: CH0PR12MB5202:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52022F56E66CBF7A6212453BE66F9@CH0PR12MB5202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3FmKG/NsPAWdoO/TsN4/kWPKRb3zRM4LOiOc5HCLvAur297K9k8sD62a98Ce2hWIbbu4cZRU8aQLAWFpz6G0p7nIViDWzx8LSwKNyicnBxY5CGSk0sL5/UE+vFZO0yAnGjfUyTqllAKbEiJU0t/GUNjdPq7ocxUL9okXZoKey9sElD2er0DWQrxN11Lk0+AsPJIaSf1lySbySNHqCr8nytmLQQuoeJSntEBqVaD3h80/cZsbxYs8mPfCVduvqMs2ooUM8zNnvB0wXVbxyfZd/BhpHwbpMwkY7srsevnJNdd0CAGqpJOkGA3I9wFPQN4hY5a9ukwB2ZD6L5H8AFzSUaRnUH0NqImslyacCAbVvmTP6CVZKrjWxLPs32bUpY0B41/LRFG7IITiX/MXqHONNZNEDNp/uLE5bX2xeBCm87V2PpYCGkVFEU0XJKjg6VqhIFXi8MQdbupTtGAOZlubsfLM3b9kLBapey4fHCS5flr/xsMwgoo6IEgZN/l9T7p9Km6XBtSDkt3l9QPLekSSFuUoYBI+zpUPhZUaLdbgFU4RwYd41/XZ3yBByy+RGFjXvJCbWTl8mnGqi6paN0vcp0QQq1Jjf7B7o8cxoU5mP5D67l6He/P5DW1WtpIMkJlH6dvF1GC1ix6Tetj3+CnjZAsaz44XKRJiNxsyvJbPO0r1tls1IGhCloa1yrLwIdJRk1Otr+jpAcCaqCQg+UgXrpu+uJA8/gU+P5AEnZ4Dgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(508600001)(36756003)(66556008)(31696002)(26005)(2616005)(5660300002)(31686004)(66476007)(186003)(956004)(83380400001)(53546011)(6486002)(8676002)(316002)(16576012)(2906002)(8936002)(38100700002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZWMjRsZ0FZYi95N2haWlFhcjQ3Rkp6ZjB3K2VkYi9WTnMvQUJRalR1WVNw?=
 =?utf-8?B?WEtUNzdTR0F3OGduOUpIbGRRakdKSUMxTXEyTjVDYmtzTFFGbms0a095VGFF?=
 =?utf-8?B?MU9ORTZzVXJ6Sjdyekg0bDJ1Y3pyWnJLaXc1V1dYZ1hFK2o0QVVXV29KSXlF?=
 =?utf-8?B?TFgra2VuZWZLRHFHQlBSMkZrR1NGRThnUW0ySzE0Y1N1MVM5cXk3UDg3M2d6?=
 =?utf-8?B?MmJwYkFSekpaajE0QjZ3aExqc1JrWXZjVnhWUDMvN1JDTEc0V1R6eDRUV3kx?=
 =?utf-8?B?Z0J1Y2RGT0FSSHoyNFhoeTlzZHp1WThYZGtvTE5PeXNoNWNLazV3MElBUUVV?=
 =?utf-8?B?c0tmVzhXUHNIanNqMlVUdnp6VmlRcHVwUEFIdFA3OHg5a2kzTVhRRisySTFx?=
 =?utf-8?B?ejZVZ3Q5eFRrcTdRTkhheGxkNElxcWg2QXBZQmxpN1dRUDZRU0ttZUZoMmta?=
 =?utf-8?B?VXhRYzU3c1hrNm9HTGlOYlRKWG5FMGpSc1BzZElkejZJdlljZXJsa25FaGR2?=
 =?utf-8?B?Z05pUG9oZHE4S25Nc2xkeVYyNHhJUENteFlvQmY5dGNRaDlseXlIaE9jZzRW?=
 =?utf-8?B?bDNnK3h6R2J3dTFCWlhvQS9RVTlyTGttbzdoSjEvSDYzTFFweWR1S09PK3k4?=
 =?utf-8?B?aUJ2TjY1cXlZNklueFhyVE5tSmpVSHdOS1Jsd0liNGswRHlET3pGSm5RSEJB?=
 =?utf-8?B?cWplRm1hWlpBZUdBL2w3WE8wV0VJalFvT0xDVEVVSnd4N1ZTSVFqVmw4Wk85?=
 =?utf-8?B?Tjl4djQvVExCSHoxWU1qTi9FYnROT25kcEF6TEZLL3pYdVBCdW9Wa2RIOEg3?=
 =?utf-8?B?NDdpZ3paazlTMGVVVHVDY2QxNFBKRGQyY2RpYlhMS25XZVdiSmZ2Z3hDcU8x?=
 =?utf-8?B?L1p5Y3RqbE1wNVAvREhpZHlhRGdSRXA2UHhIUnhUZUhScUUweUQySUJDVWk4?=
 =?utf-8?B?TUVzZG9uNHZnZzgyUk1Kck5uT2x4VHV5SVMzZzlqU1pYVGdhQnM4UHhoTGNH?=
 =?utf-8?B?c1p2MGtESUdNaW92MkhzTjBRYWJFTDJkd0o1VHVpblJtODFBQzVxUVNJTzBt?=
 =?utf-8?B?OWpHbldKMmRrdThybGl5RDIrSzF2MVhMUCtZdkcxaVpqMmFQT3MzenhuYTJK?=
 =?utf-8?B?cXNZM28ybHBjSHNrUTlpOGRFVnhCOHFKUlRDKy9xUkZ0R3ZBMTM1Z1ZmZWJS?=
 =?utf-8?B?alRkdktrdTgrZ0xZVnRZMU1ZazRrN096RzN2cDFhMjFRN1dOMnFwZ3dMeDV3?=
 =?utf-8?B?WFUzMDVJL3dFYlZxR3pmK2RjTWNsZzR4dklLUW43cFFPbzRRVnYrRk1lRTV0?=
 =?utf-8?B?LzAxSnFIMWtTUTRjRHlzZlAzTVY4VGhobGhYa1hobG1uczNFL2JaWVNydFVV?=
 =?utf-8?B?elZEY0JRTGh2bWtTd0FIN2VxRkRtK2NIUWRvRDNWaDRVUythMVF3eHZ2eUZ5?=
 =?utf-8?B?QkxTd3R6ZG0yL0poVTEzRFVuemV5bDhmbTU4SSs5YURrNnNoNnVrSms5NlFL?=
 =?utf-8?B?MVMzNTFsc0tiblJGeExaQk9TV3l1cEw2eUFxMGRZSVNLNWNJTEpuQlZMTkQz?=
 =?utf-8?B?ckpNS3grazNCb25WMGFSSXZxZGttTnNiTlZ0dFRJVmI3MS9zSFE4c0RXSjhH?=
 =?utf-8?B?WTZHbWxzNkg4U0hQOWFwWGVqM0tGREI5WkczajZOQUFVYjh0SmRLUWZtQW5i?=
 =?utf-8?B?RVk5bnpBL2llSGZtZHRPYVQwS0dzRHUrRkNzK1oxYkx5MnB5QjNJalpCczF0?=
 =?utf-8?B?YlVsbjZTaUlmdzF1WGhwUlFVZVZLd2h6amhFZExBT0hwaVNsekZjdUFReU9C?=
 =?utf-8?B?MEpEWDMrUTRLeG5EenB2KzJJejhUcVFKTXZTcEZTcXZrMW8vZEpnL05mODNY?=
 =?utf-8?B?RkFoZkp6Y1lLbnJHY2JjSm9GU1J5bCtnRWlIaWdVV3B3L0xhbVdJSms0Tk5x?=
 =?utf-8?B?ZFZkVitJZk9qUTJXYnVDUnNMSUJMWEppaG16ZDhZR2lqSEVRZzhtVGNMREdU?=
 =?utf-8?B?dTZqNHFiMm1wUzFTZnhkeFpjV1lsakRob1hnTkZNSGUyVFRqY1BlN0Q2MGhW?=
 =?utf-8?B?Q1c5ZDZwRFFrZWZ6cy9iR3I4S0R5YVpLcGlvSm5zYXZMTHhXcjNhWnVjdDR2?=
 =?utf-8?Q?J7UU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e3d848-ca6a-47ba-2f24-08d9ba7272ba
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:44:56.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/5arVkEoLUzqvvxO8hsT8kkUiSeXoRt1pUQubKRtIO8EwI3sxRhhVvEq+hXhNfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202
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
    <div class="moz-cite-prefix">On 2021-12-08 3:24 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211208082457.918004-3-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">If an existing SVM range overlaps an svm_range_set_attr call, we would
normally split it in order to update only the overlapping part.
However, if the attributes of the existing range would not be changed
splitting it is unnecessary.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20211208082457.918004-3-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9ea3981545e5..c93a26e6318b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1853,18 +1853,24 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	while (node) {
 		struct interval_tree_node *next;
-		struct svm_range *old;
 		unsigned long next_start;
 
 		pr_debug(&quot;found overlap node [0x%lx 0x%lx]\n&quot;, node-&gt;start,
 			 node-&gt;last);
 
-		old = container_of(node, struct svm_range, it_node);
+		prange = container_of(node, struct svm_range, it_node);
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node-&gt;last, last) + 1;
 
-		if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
-			/* node intersects the updated range, clone+split it */
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+			/* nothing to do */
+		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
+			/* node intersects the update range and its attributes
+			 * will change. Clone and split it, apply updates only
+			 * to the overlapping part
+			 */
+			struct svm_range *old = prange;
+
 			prange = svm_range_clone(old);
 			if (!prange) {
 				r = -ENOMEM;
@@ -1873,6 +1879,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 			list_add(&amp;old-&gt;remove_list, remove_list);
 			list_add(&amp;prange-&gt;insert_list, insert_list);
+			list_add(&amp;prange-&gt;update_list, update_list);
 
 			if (node-&gt;start &lt; start) {
 				pr_debug(&quot;change old range start\n&quot;);
@@ -1892,16 +1899,12 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			/* The node is contained within start..last,
 			 * just update it
 			 */
-			prange = old;
-		}
-
-		if (!svm_range_is_same_attrs(p, prange, nattr, attrs))
 			list_add(&amp;prange-&gt;update_list, update_list);
+		}
 
 		/* insert a new node if needed */
 		if (node-&gt;start &gt; start) {
-			prange = svm_range_new(prange-&gt;svms, start,
-					       node-&gt;start - 1);
+			prange = svm_range_new(svms, start, node-&gt;start - 1);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
</pre>
    </blockquote>
  </body>
</html>
