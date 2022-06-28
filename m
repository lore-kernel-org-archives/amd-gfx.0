Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BF8C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 23:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0128113D92;
	Tue, 28 Jun 2022 23:41:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3153113951
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 23:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir/54pd1LDQ8uGDAHHLOkNs7qmolaQzoesN9Cy3VBAZ655zUb6+LQS0VT28Axt5Xdo7REZTc1k4JNlO5xZqHnlqT5E7EBbyL51SPsmmT/WOQSCpiAX6LTQ/1qGnZfxf+CyfHhvIEcgUd/jirazgfwk5mSxr3E0arF4N3GpAqfBhSlC46ZfE2QZbSXB23Jt9amIh6mBwtlvmZjyXsblAR4OJ1h/QN9+0s4tfnr+dXeVEyuB7eOyNDbSwq+arWNzAxWP+xfUvIbA2IqX+8dRSozMxTSjTj4sE8yR8HdmfLEu/QWyrmy1mg5xIWKOhQ7udd5wBs+Texz8qd0rGDDu8wTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLytvyzFKx3I+98U9fxEj7B15zzwrSKp+Ot0ZWc5ikU=;
 b=k5Nzs7UUeYcNku6okmGp3heNYM689uuYKbhRLr/Kn0sJfWFxrLWKMwlOjApbsbcnALEVXn4TyomKHNx5CH1bWCg1pIZP2R/+qDq2f6FI4D/N9KL9lhltdNjpIdd9rPRdcZvLyW2vCkF1WCbNTrV3PWE9dmNRI9w4L8drjmeq8YL4m2rTtLihXrzJAmecPgkjEqWUZHb9IYJr+1RiSPy5kzyfElYWDqmxsxW7CX6eAH/600BZ9riWfnZRFywHvfgtCRV/zuAyuaAPOf6wA06v+3K54brCRsPi6x/rI3Vi5MpXuZnruyKc3rN13HsiTdLseSAf5cfW8emdD+g9hkJ7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLytvyzFKx3I+98U9fxEj7B15zzwrSKp+Ot0ZWc5ikU=;
 b=dBf22ae8qDL7k2DQ+6cJ0ReKIBCjwX23nA2SS2dalooN468vLjwRBMlQn6g9HuLNxGimTxvtqxfy3u31G5Gpx+QmCdW9cMzFZgIcp/iCz7eqyU1NjwWveVdF8Iz8ueGZRPMlcZiIm7I8UDBIB5OASkiLoXnhsxBN547TGCT2OGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 23:41:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5373.016; Tue, 28 Jun 2022
 23:41:11 +0000
Message-ID: <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
Date: Tue, 28 Jun 2022 19:41:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org, 
 dan.carpenter@oracle.com
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dadeda66-d733-4b24-def2-08da595fae62
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXwFbGOwBIVnbTponBOEFSZIbWkrHAINYgZwynGjXV/sKn4aSpSwytKTexXW+kUd/Qqz4fWdFC9p/WpkMngXQFKmHZ9N/OaRtkWsRvIPMsrO8SNFlkpYMvBLGPycQ4/OngBV92ZSpGUExaF8JXB2ami7PVTVeHfiMoQB1X8EH4v+6iXf7dIpSDxX7CTgHwfkylfSCC1vC21B6XVG+Y94T9643c+DViWp5NBct52qvORYnrfrEndy/7I77OqjjJCeQqnM3a+AMb29Jy0i6XFpHDuPjQBMBITB3HIzviFOif7g4kgd7uXUk2IrkhF5MDGeBcR8NIMVMDwggkLf3Adc6z4+kFc7H1gK6EXtV2n1v3pWV8zh+0mRXm0IvZbGAxi56+ClP5WYCiYo7HCsSnZJlBwVezRi44DNCEHaJ0QxY71vvcXVMV5dCqZyumcj6m4StZNNWm5KwonNWpsxGAbUMCE/KG9xU9qZVsdJjFy2DE3d9J759vHVnsKCQf6GR0zisZQrU5Z85PwwY3eBapeBz0ElWoK4fI9khjH6nzUXydOci699+a7UzIJUhTZfB/0FnmLlO6wUmiHTxA4bOLkgJAq9UWakmpaCd3VE867mw27HkfRbaJxGx6uVfV9St0ndzBfZg0926BbA9TyAG5LFu/PMHUmnd0zM6u3pfcYyxm+YeyAVfAMwbsdEumIq4DdM26gPlRGZb3sBsg+oTpC2cyjzQubpzeQ0Q9h9F4E0+8pQmqad5VFrBPusmNqpTHjtJpFw29YsQE6S1VFKMX7IrV3KhnJe3BfWr6QMeiqpzI8fo91pPBOC+K8JL9gLqYBHNu/d5wGQqQzhpl4K+4fjEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(31686004)(36756003)(44832011)(38100700002)(5660300002)(478600001)(6486002)(66476007)(66556008)(86362001)(2906002)(316002)(83380400001)(8936002)(66946007)(8676002)(186003)(41300700001)(6506007)(2616005)(31696002)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K016RmE3NGRhakFPYUJKZlZVR3pQT2tKNUQ3T1RRRnNKMmM4T2VTQyt1ZlJq?=
 =?utf-8?B?SDlhWms5OTlIajVLSndpUlNIWWpubzYvbWJ2cFRQWjZJUjlvZGFaQldHMEN6?=
 =?utf-8?B?SlFhQThqMmp5SitIczdEYTEraWFLaUU3YlgyRit1US9zcmJGUXE4K1VEVW1p?=
 =?utf-8?B?Wm1LSlA0V3QrbS9mdnRpSGhBQW5ycDhHSnVBRUV5MVNpaTRRN05ZeGpuUlBN?=
 =?utf-8?B?dTZraGUwdkxQSVRCODJZMjV4dUxpdmpjQVBpVGtRdCtVWTBCaWpIc0pVZERK?=
 =?utf-8?B?djR4RjJpazdpVUNXRm5DeWxvaEVNMnB0Ujh6Vjl6aVdLWW5Cb2JNTnkvL3Bo?=
 =?utf-8?B?TGM2eG0wOEo5b0J2OFVobjdpK0RUZWtMU1NNZXdNUWxoZUhVdEVPNTRPMXNF?=
 =?utf-8?B?NnlJZHd1Y3gxaHUxckpFQnptQjBQdTVaS3BHeG16YW5NaWZOMS9wQ0V5eGxH?=
 =?utf-8?B?MGVhZHovOTlZQ1orWGFJek5IWFhRUGxaZ0dWYlNxZlN6bUlKdXdPdVB2UDUy?=
 =?utf-8?B?QzZVdFhsNEpGWEh0dGtQZTlBb3pGRmlHeVROVG5zZTFOaFdUcEw1Tk9jeURw?=
 =?utf-8?B?SzBBMGlOcGFHd0Y4cEIvc1Jtb3llUFVZWHJtcFFSNWtqS2hwS3ZzSkZ0emhM?=
 =?utf-8?B?VnJKR2k4WXRGLzAvRVB5NXZ5T2dRSUYzRG83QkJWSHFGOFBKWFZtaXpxalk1?=
 =?utf-8?B?TjY3MGNyU1M0SWJ0OWZwcTVIM0NGK1VLbFhZazZDVkMyRXBLYUJ4a3VlQnRj?=
 =?utf-8?B?c09XM2p6QnNMK2ZGVUF1ZFkyVitBZklsODFGNVRpNUl2dm1TNzQrUVRRcjh4?=
 =?utf-8?B?akJLb1kxMEJWTUpiWGZITVcwb2JKL1VpTExxeTNXSytra21ZWm41T3ZWMlBQ?=
 =?utf-8?B?T1NnRHk4S3czaHZ0ZlV5VmhFUTZ3SDZ4NmJpUE51aUFUK1k2SktzMHNaT3JX?=
 =?utf-8?B?K1M3Tkp0OEwwUUk4NDRaTklreVZGWHVEYm1xTUR0eHBJVjBzMHFFYkJ0c1pL?=
 =?utf-8?B?dFgvZUJIaFhZUW1GaHFWQlpUSEZ3bk55eVNVRVRCZkhHbGl5MC9wL09PUy9Y?=
 =?utf-8?B?TUZFdTh3TUR3V3ppM2JLNE9tNWFsYU41OWpZenB1SVNvMy9veHEyUWZSTkV6?=
 =?utf-8?B?b2tiUWh0TmZGYmh3QzRyQmF1c05mbEloaGU2VUhzbktIcG9wRmNWWEpOVnVM?=
 =?utf-8?B?ckt5eU5lRzBwR2U2ZnpXcHZwbzFsWFJqRzczUlM5ckZuUW5LSm81d3lESFZk?=
 =?utf-8?B?Z1pDUnhBSnFUY21CcFgxbm00OG1ZK1BwVm94dDc3RFhNV3QvTUFUZFRyZGVP?=
 =?utf-8?B?bEc4RGtaNzFSQjkySHZ6R253UXk2c2xrRGlxL2xWR0tFWDltUUFmRjlZV1hV?=
 =?utf-8?B?T2pmd2JRUGxDSkRkYm1tRytyU2lJYXEzR1RqZjN5blJRRnIyUGlDYmJOQktU?=
 =?utf-8?B?d002STI3MFFFbHJGQ1RUeXFpNTVzNHhnL3FLVEdDaUhtRUhTNzhIcTBxODFp?=
 =?utf-8?B?cHpMNFhZVWp5cms2RENBQWd2M1FYWjl4VVJEK0J0NWNGOXhab01USmN6dG9h?=
 =?utf-8?B?QUIrSXlYMlRnQnBibndDbjdUMW1wdmQxWXVGQ0tZRzVWVFoyWjNmVUpPOENr?=
 =?utf-8?B?ZUhlbUlkd055OW84eGh4Q3FjOGFuS21MRmJqSHJlZ3E0dEd3bk9oYVBqZk9K?=
 =?utf-8?B?eVNoZDE1UlI0OTBuVlArMDNhMWRGUjU2R2RwZzkxcXpRbHRsV21WZStrcDRM?=
 =?utf-8?B?RS9xdC9sS0UwNFFib2pSRGc5K2xZKysvQU1kVzBnSko1cXFqdGtJK3VGeU16?=
 =?utf-8?B?aWFndmlHN2NkQURVaGJXYmZzSTczS1NoNlRWSDMyZ1lwV2wvWlk4aEJuVDNN?=
 =?utf-8?B?K2I0djQ1RTZDQlVGNUJXc01hQUxzeG1KY3R0S0tEVElaNDdlYS9TVGR3VHdP?=
 =?utf-8?B?bkpmMGZrbXpsbzFnaDY4TEsrcEg1dTRieEJDZDZ2Yk5jTmFSSno2cldIUFZw?=
 =?utf-8?B?T3kzT29WTEQyN20vcms5NGVJb2EwdFZNUCtBalpmMVJVQWlWRFlZb0Fsd1lh?=
 =?utf-8?B?QUozV0IxYTliNHdCOTlrVWZEeThXWUR1VXIrL0t6U0F4TmlzeUExUlZVdGF5?=
 =?utf-8?Q?Y7YGZh4PzMPDUy+un4l0/NUKL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadeda66-d733-4b24-def2-08da595fae62
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 23:41:11.0076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9qMhTA47LYDIhMyx009z+ehkeYL3W/NbbBYAV+Pae6wxIqvQ8fG80YolpPwKCF4VXbtlChAmz7jEzIf461m8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3270
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


Am 2022-06-28 um 19:25 schrieb Ramesh Errabolu:
> The patch fixes couple of warnings, as reported by Smatch
> a static analyzer
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 36 ++++++++++++-----------
>   1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 25990bec600d..9d7b9ad70bc8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1417,15 +1417,17 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   
>   		/* find CPU <-->  CPU links */
>   		cpu_dev = kfd_topology_device_by_proximity_domain(i);
> -		if (cpu_dev) {
> -			list_for_each_entry(cpu_link,
> -					&cpu_dev->io_link_props, list) {
> -				if (cpu_link->node_to == gpu_link->node_to)
> -					break;
> -			}
> -		}
> +		if (!cpu_dev)
> +			continue;
> +
> +		cpu_link = NULL;

This initialization is unnecessary. list_for_each_entry will always 
initialize it.


> +		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
> +			if (cpu_link->node_to == gpu_link->node_to)
> +				break;
>   
> -		if (cpu_link->node_to != gpu_link->node_to)
> +		/* Ensures we didn't exit from list search with no hits */
> +		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list) ||
> +			(cpu_link->node_to != gpu_link->node_to))

The second condition is redundant. If the list entry is not the head, 
the node_to must have already matched in the loop.

But I'm no sure this solution is going to satisfy the static checker. It 
objects to using the iterator (cpu_link) outside the loop. I think a 
proper solution, that doesn't make any assumptions about how 
list_for_each_entry is implemented, would be to declare a separate 
variable as the iterator, and assign cpu_link in the loop only if there 
is a match.

Regards,
   Felix


>   			return -ENOMEM;
>   
>   		/* CPU <--> CPU <--> GPU, GPU node*/
> @@ -1510,16 +1512,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
>   		if (cpu_dev) {
>   			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
> -				if (iolink3->node_to == iolink2->node_to)
> +				if (iolink3->node_to == iolink2->node_to) {
> +					props->weight += iolink3->weight;
> +					props->min_latency += iolink3->min_latency;
> +					props->max_latency += iolink3->max_latency;
> +					props->min_bandwidth = min(props->min_bandwidth,
> +									iolink3->min_bandwidth);
> +					props->max_bandwidth = min(props->max_bandwidth,
> +									iolink3->max_bandwidth);
>   					break;
> -
> -			props->weight += iolink3->weight;
> -			props->min_latency += iolink3->min_latency;
> -			props->max_latency += iolink3->max_latency;
> -			props->min_bandwidth = min(props->min_bandwidth,
> -							iolink3->min_bandwidth);
> -			props->max_bandwidth = min(props->max_bandwidth,
> -							iolink3->max_bandwidth);
> +				}
>   		} else {
>   			WARN(1, "CPU node not found");
>   		}
