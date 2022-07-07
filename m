Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60B2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 13:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5806910E484;
	Thu,  7 Jul 2022 13:39:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB6710E466
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 13:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnplXcVRNdvaLWssr/KOlWbZ8A2QJDu411u2v5LpLa1BhhK07Nm8riAerJ0aAzfvSioO7b+KDTR5LZ4R0TNTRxa2kkx3yQRbOa7rUc4bjHy6+VmfTQju8nBKChv5/0gjXFwByQpZlD3tGk0OZFfXZrgfFWzgjJgLgKgDaZSdQKRUYXrId/Lq7suDq5X200gWP5ISGmDxstVIQp5FihsvYntkcPNhSwhaqhWAkeZC2usmpmc3Wuq1bFrYJBWKwl4doj77owXP9GHoj/1xafM387s6+iJuIGe1vu2cZ3jD96r7I5J/uxebb4+FIMIjKupq0ftl2tL/Iqu0zfq+2vCBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0Ju9PX8bOq6PWuQdich593h0UoXbiY/ebrq9ogMGZ0=;
 b=ZiD6f3f45y7g0Qzhd7zIqVMuO864tpw9hYEdV5hT6+rUfq6W5Mz3cg9+WwH3lohEj94M8/ORD6mnisJnLv2NmMmqC3eJyyyoICxTj/Wks5sgFsku8xdykG6GW+/1cpzS7QOcBoYk9xm+8XbOde/IeeWxCDKvxCss3+kltXP6yc4kwU1jWqTvFTrJSzzywLfpf9MsZPP1gcHZj67uNFnpa59EkiJliL6Qi/D4IeyFbwRpC2v0tZ4clLjuGCy5W4dLuryldQ+zwZX1ghhu1yhz2g1op9zjCRU/CI+UArYpcGdXQmew8iub6CEHMxAiglTxIhgt97F8OaeDP5LuCyxw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0Ju9PX8bOq6PWuQdich593h0UoXbiY/ebrq9ogMGZ0=;
 b=k00RZa29JRHD1qDVir3ulmxao6uLs9tQkW7EmKwhZTqyWoQTMT3DJzz/TFwuD5gH/N8wwGiKyHgTknKgBXsy1JobOXDlkcwXZq2P/E3R9hk1Oy7BkmKocFiv9nDhVQt8bB+LioLZJRNui4RBE7Pv9u1/84j/YhxML3y5ZjjezDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 13:39:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 13:39:43 +0000
Message-ID: <a56b3b2e-8a98-68a5-4bc8-6c8a72786e4a@amd.com>
Date: Thu, 7 Jul 2022 09:39:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix one list corruption when create queue
 fails
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707102800.8035-1-xinhui.pan@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220707102800.8035-1-xinhui.pan@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1166e8e1-e5b6-4fb4-2b1e-08da601e2618
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOGfUv8ny25TuzUIlMQkE/qPFcYkFqdCsY3VxixdNZ738WfVWJ8LlhjzEb6E7D3h3gstPR5duWrUKH4c4+Uw9zmSfG7JyQSds5u08S72tWNR5twxDtHs2iptg0K7l2ktvJE8mkCrH/wM6am87Ej12YeMpNVVSR+PQVDS/4fXHWIulQ2/a2tU7uHD2V0y6ieUR4ydgMAbKlWaD6gW2k5mD//ZPcy1DsVk0gjrk2p3wd8zvzCmxOCNnk+i+l0FDKlS6/aqakLE08+gw4nYwc0UIyLB+pxdcNFIg/0Wdya/F2XibgsSFy2RRtwavyi0vbh25zj07UiW0E0ocVA3lpV3JDqEFs154/g+IqUBqsjInvhB/z1pN8fu9G0uLghl1CBemXzXxchHLSjiX3UoJJpxuttTGueVm95JOa5jo0BKChgCGo0/jkT5rMO+klXsxSrRjMo5nAwxlF3aN4hm9eeqnNd9tmAZ4LqIDGKzZOjFaciYsYEXAYqmkd0gljeCdbNFgVNbakFU9bCHd7c4Zi4ZUcAUILMQGw5cn4h4nBZIhS/lzcx8nxSmXgU+mc/zElz428YyDcWNu4dyetyBl2oREsKGYR7KM0ORwYCd6TAXiIl21qr8V+idTuZ1Ae7v6tAql7rqgr+yhIsj5N0Q93m0GgbYCI6tYc7pzuDj0/RQw26yIVY9xgciJV0VY6tSG5/2xLZOLiAVlhz59mcgex2uH8PrLvkDyBXw3kOpIpmycPlPVpBTRzC3/BK5yXq+gTwuaULQ7TDh1TSHnAlBwQs5bJdrJGu0g/Ubwb9LQNvU+flf03QJYIEklMKXQQH8W/1ftsXkov+kcn3GctzDFEYUSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(2906002)(53546011)(6506007)(31696002)(31686004)(186003)(316002)(38100700002)(26005)(2616005)(5660300002)(6512007)(6486002)(83380400001)(8936002)(41300700001)(36756003)(4326008)(478600001)(8676002)(66476007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5tdjVGNFVHZk1iVjdCZFlXL0ZsampmYVJHcGM3NkZhamQ0aFdmd1lPVXZU?=
 =?utf-8?B?WnhGMXpmVEM0R08weTJEZ21RZ3VubTJkV1BBTmExUVdZMXc5NUM4VWFWOU5x?=
 =?utf-8?B?aXJMZUN5aXhndEk3Mm9hTVRjbXJhLzF3QkgzZUdPVW0wOHhjbXB3ck1nTU1Y?=
 =?utf-8?B?WkxxMzdTODM3dkxlTUl2Y3B6dEMzT3lVQ3hDQ3hmcThlbGRNTGh5bmxSSzcr?=
 =?utf-8?B?TFpPS1RVVzl3dXl3aXFDU3VlUzc0V0dlUXdrWEtSdEVPNTR0OWN5ZDNBZkZP?=
 =?utf-8?B?eXBab3hmRlhtcGd4WWZsOFR6MEQ4djRNNTBkRjFUbzhOa09yN2pHK3YrdlIx?=
 =?utf-8?B?dlp4WmJZK0pmbkN5b0w1QUFycGtLcWZDbHRIRW04amxjd2kyZUZlWloxSWsw?=
 =?utf-8?B?bzk2QjVDR2YvTzcyYitpVkVqMWFRdGFSeTVlMnBEL0krb2l2RG9mTVpKbzUx?=
 =?utf-8?B?T1Q4N2J5WGYxenFSQVlReGhvTy9uK1RmN2R1TFZLT2txNEc5UC9SZFRQM3lN?=
 =?utf-8?B?V0dKcHNsMWlMOWdOemNkdHZDYTZLNTRMRUROUUZUUHlReDZTZ2pJYzhzZk1K?=
 =?utf-8?B?TnhWamJJMWM4ems5cytVNEZVY3diaElTNW1XQmkzTjhrRnRWZExSN1VwSkJj?=
 =?utf-8?B?NFVPclBzTXdSUTEvWDdOdkxvM0NJdm9RVkhLV0xua2hlQUZzK0lmaHVRclVi?=
 =?utf-8?B?dFVzeVpIN3dTN2ZPK3BKZEtrQXdIWVVFS0lTMDhaRHd1LzJPSGgyQ3kzZkJS?=
 =?utf-8?B?UzNKVHh4NUY1MTU5UkhaM2FCeDYxWjNBdFVpOUxuODB5S0Y0cHA4VlVPelgw?=
 =?utf-8?B?R213OTN2ZDVoZ1l5Q3NvWDVwY0RFMmJBckdtRkk5UzJrYTJ5RjdqSFNwTFJS?=
 =?utf-8?B?Skg3ajBJc1doa0h0Smo4c3hObmZVc3hsUWhOWHlOYUVFd1pVZHk0dHhPUEtF?=
 =?utf-8?B?alJNMkZMTEVTU3dmRGpuSi80YmJuZkcvNUVCOHZzRU9Hc2Q3Qy9xRTBSZ1E1?=
 =?utf-8?B?enoxSFNjRGQvU2k3NWJtUUVFNkNWYTk0dG9MSUpxQnBsVEpWb21yc0pYcDhC?=
 =?utf-8?B?WUtERnc5azJHRGRhS1lQZ1dET0FBTWkzSGkxR2RzelhlYWVVa3h4MnNmRUdG?=
 =?utf-8?B?Vm9tS1pPcFdYU1lnbVZPSThVQ2dEekhEQXV3bmZUaitKSG1LeDZsYkI1bXJi?=
 =?utf-8?B?UU1yUjN5bjRueW8rc0t3a1FORlJMS2d4TUwwM0dLeC9HcTBjQThPYUhNSncr?=
 =?utf-8?B?UEZpOEN1WXl4cE5EejZvUXFqd0dkanMwV1Bjd2phbW4xSjc2YWtaTU95NXRC?=
 =?utf-8?B?YkFHTk9xcE9RUEFZMHNHYVpFMmlQSkRWeTNKVlk0eE83eStFWE0vdkdyRGtt?=
 =?utf-8?B?MVNMZ0dPTU5DRGtkTzE0cGJWRjBvU0xudjZUZi94b3Fsd09xQVU2VlpIVnQ1?=
 =?utf-8?B?NlVqQW94N2YyUkFFYjRtaGtWVTRxOVdYRjFBNzFZWGIwNm8zbGx1azlpdUVU?=
 =?utf-8?B?VXNpbGRGcDY3Z0Z5MmR6RllCMWhUdWRQSmZBZVlvamxFOWtYbVZBeG9jb2l5?=
 =?utf-8?B?OEpXSGVFeXNDcDc2NTQ0T2kyK25LaGY2R2dNR1FtOStBQ2VmYTlyNFZhRXFr?=
 =?utf-8?B?QThhem5TZ0hEQlJISFRva1VoNm9xbncxMmV5RlRzQ0xaV2lhNzNBQlEyY2xr?=
 =?utf-8?B?cWVNUncxYVRKbk0xK2dRNGgvOFJTZUtORElXVU5iQnYvSUdLOVl6UkszUTYz?=
 =?utf-8?B?cVNNVVlwVSt0NktiQmM4T3IvUE96WkRiczI5ZGlmU0YwZmFSMm0vSlJTWGRU?=
 =?utf-8?B?QjhJQ2l4aUcvclFZc0wrdVhyMTIwcEE1bjlRVy9iR2R2ZHB5K01CTnUzcGQ2?=
 =?utf-8?B?aTVsdVBxTGx1MnA0WS9uM1ZqRitacHA2NnNEOXhvSkdZL282QTAwRFVYWjZh?=
 =?utf-8?B?KzdLNXdxUTBlYXhSek9wYytVbzB2c01rbUlIZUlldmFLS3RYUTBaK0NnazBt?=
 =?utf-8?B?WTRzTGRlMWQ0MGkrUHJSRWM5UTZnOVFoSERGUjFRNTBKSFRFTlZTLzhueDl1?=
 =?utf-8?B?bldEbWFFOG4vYnZUUXA2bnhzT0Rqa1d3U09sQjlOcFpEcFZ4U2VacG5JZk1u?=
 =?utf-8?Q?VxTU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1166e8e1-e5b6-4fb4-2b1e-08da601e2618
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 13:39:43.2468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpKAJ/Gpw9vjM78e7uG56detcaZOURZx6qKDE4NalhrmMjN8SbJqZX1s9MmMDefD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-07-07 06:28, xinhui pan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220707102800.8035-1-xinhui.pan@amd.com">
      <pre class="moz-quote-pre" wrap="">Queue would be freed when create_queue_cpsch fails
So lets do queue cleanup otherwise various list and memory issues
happen.
</pre>
    </blockquote>
    <p>This bug was introduced when adding MES support, as we used to
      ignore execute_queues_cpsch return value. Cleanup and return error
      to user space looks good to me.</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20220707102800.8035-1-xinhui.pan@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: xinhui pan <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 93a0b6995430..e83725a28106 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1674,14 +1674,13 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q-&gt;properties.is_active) {
 		increment_queue_count(dqm, qpd, q);
 
-		if (!dqm-&gt;dev-&gt;shared_resources.enable_mes) {
+		if (!dqm-&gt;dev-&gt;shared_resources.enable_mes)
 			retval = execute_queues_cpsch(dqm,
-					     KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-		} else {
+					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+		else
 			retval = add_queue_mes(dqm, q, qpd);
-			if (retval)
-				goto cleanup_queue;
-		}
+		if (retval)
+			goto cleanup_queue;
 	}
 
 	/*
</pre>
    </blockquote>
  </body>
</html>
