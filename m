Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C5CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6CB613A6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E6CB613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC85F6ECD0;
	Thu, 21 Oct 2021 16:45:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923866ECCD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNFrpH0nMOK94dMdUnoTY+PG+n2m6XFmsW+PVn4sqbcJRISjdgN0vYwz+SxLFZwffnJ+aaKYrQaN365Xu3u3CjZYacLNhhCvTfEgFDNglQ1BgYLeCth3Rx0ZJL2QARUbmTwjAZvlatwHOBnTC9B/8iZyEk0zDFWOsT86aXL7nFdjsGXnMKt3PuGzCXqYJZSDsCN457KT/PjsEd2byQcK6u/U7gTMJtQGGk/pNEJWwEyWlREFuL9YCGD2mKiMFpj514tRAlw2jle3jO9Ir5gYg+BOF2/hnrXG+uEbXBwag+V/KO9AFCoakkqxEjtzCDzKLhMfdr4KBfEC/GTK9Wd7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih08xge0twCCfvhKqjBiKa7CMONR+eH7UJ7IuQTdSEE=;
 b=JSEevJvX5WmKEh0QAD1vGWZwevPKY/83/0ysX03C6IJe9n8C2G0Elmg7wKxLD3Zj5Ms3koMesM3BD5huPRn+N9YIVi1FX3tFY4lzL+teUEZOcfFtfKq9Go1uetf1ah5cKHBHZ9kwy/SSIBTmgdk9lvgfnhdz9lMBbv5+N42huCyH/VxqAzPIUxoFkcaYSCW0DERL2C+QVUt1i0IilOC9MSF5uNr0plw2JGR+XeLbpnr4EDbOK9UldTG9Wcv75FvcFVc5hXOpnwFRx8e5mK8iLtE5Z33IT9DgdDzW9g+Ei9EU/DAyhSVYNJiVmQK+35Lx6kXBqKUEo+6w0d399cu/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih08xge0twCCfvhKqjBiKa7CMONR+eH7UJ7IuQTdSEE=;
 b=sAJlVx8CF3YgK24HWC4xhLy7jPGShxFMy5gCgHk1xTmlT7xkzkewXKPv+G+Gvtj7yzz40epByDgnXwBgN4twkekSfARxOjY/o24R3Sv3VMGB5+hGEPnIadW37ohUU3eFwzfoOFdvfNO/MgA52xjzsO/XRZ5QrhT7+QDbAnoJgvk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 16:45:46 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 16:45:46 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Add an optional argument into update
 queue operation
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211015084807.2062053-1-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a3c9ce64-3400-9c02-2996-433d6b7595a9@amd.com>
Date: Thu, 21 Oct 2021 12:45:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211015084807.2062053-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::17) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:45:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a395819-64d3-456d-515a-08d994b23b01
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43382113F0788F0E06EB8DEA92BF9@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZ37tiqPpgYWG9qrLaLbqjIT70pGAopkI58Xd93LmKhkc3iUknrOf3iAdqOIM2+pgNdq62u+oCELSR1RTeoMZ0OKnnk4vWZSDYXSMvsG5zEFZIV2xWgyS0wjlTn7LM3qONt7kR0Ozau61koh8awm/I4U0Q8JgGtVjatCJvOONWXCR6RGx4iQGRJj1/Tz0py5LjdkEGpO8ZZ19UAwfJTkgrM80AbjLPhV0ZA475NkUp5ZgsSrhQ8zTZ7eSYWYo0MiSE8lYa1VY9bwxDYl7eMeA+3IQTxYLl2I5prTBzxY7FHGcb3NctBYawm1Vb62c1VxKUe9EMhz+Zh0tG5DAOSR76eyCiZd3n2YPG2LBhKmw+jAkb9SRGv8CiWn/ATlNS0Rvb5UoHpYEVFZKgt7VcE3CqQ8IGg7Diu+d+8h4v5gWzWtS2TBm6QM7OSJDn+AG30dkCfb66KGM6ldpDhCp+rVmaHqak3zQ7c8Y2R17ILq6U1U3zaO0dPxA8FNGO0Q7T51Gf5GVt5wGRDG15AKnth2zhLHZUspcPCrc4bvznnFl3Af+Ph7PjhQezWPDW+k1LziK3vFM9Qvw5zvMkuxWBR/YmPFT3cIHrW/pDU3ndRZdS0qFI/90L79ajvbEs6XtXkf31H6OpmCfhSpc9LxGD9xNVot63LNewBjycQHEx/+rfN2ksQen9ykwQbLTU1wgrpdgq4dmjW6RBlqot6pw/bx5fSqULNAcL1edJLVhoBYBrbSMyGvN4YaYYSjo4wW/Sue
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(31696002)(2616005)(38100700002)(186003)(4326008)(54906003)(956004)(316002)(30864003)(6486002)(4001150100001)(508600001)(86362001)(44832011)(31686004)(16576012)(66556008)(83380400001)(66476007)(36756003)(15650500001)(5660300002)(66946007)(8676002)(26005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFIVGNjWVdLeUs2VzJHalkzMnpzTC8wMmpnaU1PeWxVZW1EdVV1TzhlT3Nu?=
 =?utf-8?B?RU0ybTVzUTJCeUJPU2E2QnpRbVhYdU5hNklXczd6aW5kRGg2TThWVEFYZjFm?=
 =?utf-8?B?cGtrYU96Wlo1T05waTA4NVJYcW9vL1VmVCtwREMwNllvOUlTRXZYakVIWkxm?=
 =?utf-8?B?K3ZzY2M5RXZxQXY3QlB6TWNQcjc1Y3NFakNpei9Uak9PY2RUZmUzQzVldWF0?=
 =?utf-8?B?bnJjSVBvYUFGcTVFcU9VZDlPbHNXTUpuRG1KSG5vZnpTSytuUWcwWGRtMzQw?=
 =?utf-8?B?UlYxMElscDZXajNUbU5FcFRYQUtNTU9uWkJnNkEySEFUa1VQRGRpVENtVDR6?=
 =?utf-8?B?UzkwdHpEa3hlQVk0V0RzNk9ZOE1LeDk2SHNDUlFFTlcraHZuMitIa0hYaTBT?=
 =?utf-8?B?K0lwVU5rbjYwYUdBWmRnbk1hU2gwQjhSM3pHWGJGTEdBWVNMSVArYXY3RDdS?=
 =?utf-8?B?akI5RHlpbkhpaE1SblAxV0FGamc2K0RnaUIxTmE4TU9IYmJDa3JwRVZiTlVp?=
 =?utf-8?B?SVlTSFVHUnA2RWZqS3lRVGhBa3phZlhheVpJR2crSEkvYTdCNFAyK0hYbyty?=
 =?utf-8?B?RkZaSXJpSXF2NW9kTGV3WFVWUEpJdkd4YVlpcDcvbTh4aHVwZ3YzRnRLbTRy?=
 =?utf-8?B?NFlQQ1lmQVhNaHFpWi9sazM3KzNucWhmWmhsYUNsUlphVFZMRjFKZEcwejlB?=
 =?utf-8?B?emdrd3k3R2c0SkxsRmhhTkJJcUhIanRnZzEzaTZHZjljMkt2Z1g4TExuMGs4?=
 =?utf-8?B?d0lpTyt0VkF1WmN4M1FhbVp0NWZ4SVhEM3RUMDhGdVZ6L1F5WnVkaHpBcTV4?=
 =?utf-8?B?YU50V0hNMGlLRWdCdU4yNURJbkY2UElYcGk3MUdaaTdzTFFMb2FyNVdPaFlz?=
 =?utf-8?B?YU9sVzVXVnFCeFdBaUNNOWRJQ2FTU2J3dVZBWWIxWnBRUDV1dlNwcDJ1V1ZR?=
 =?utf-8?B?MGFSbGJJdldiQkphTXVFYUIxbkE2MlV4QU9Tb2gybnhUVWx0T3ZaajRWdjd2?=
 =?utf-8?B?ZDJsVG5PL0tIWVBjd1dlZEFqZE9WNEM3VnZTMVVMYVlENWtpdkJUN1VRTjNq?=
 =?utf-8?B?M01sY09JblBjUE9xd1ZHS3pVRFNDWkg3MktERk1sblFiK0dRaVNWc2hoZUZR?=
 =?utf-8?B?NE1GWkd4d0tHVXZtbWtvWm5jdUdIWDBrVzBuRENmSkQyOW9Fek5aZTZ1OW4x?=
 =?utf-8?B?MHF4VkNyRElJYVZmTTFUdklPdXFjZTVIVGRpLzd1TUg2NFhycUQ4c0VMZG1U?=
 =?utf-8?B?dEp3aGFRSVJxbW82Q0xnSUpIeE5TbGpkbjcrVi94WGZ5eXJScThsYWZXUVJ4?=
 =?utf-8?B?SzFkR3dGZklaUnc4RXFvcVRGYUZnOWFsdUg0cHdoVFhtVXhrS2swc3FJQ0tm?=
 =?utf-8?B?UDgrZmJYQkdHVWxiS1loR05odzJ3bndPb1JtL2FMckUyRU0vOTZaZlE5S2VD?=
 =?utf-8?B?NG9PSHRwQVk1NmJscnluNU0wUWY0clBiMGZQeGRVUlZSeC9waVRVdncrUFNs?=
 =?utf-8?B?ZXlLc2NEdjQ3WnY4empPbFlDcVIxUVhrbHVyRC90c1V4dCtiQmd4bWRVeEFq?=
 =?utf-8?B?Q2NmS1RUMzJzaWxXa0RYY1RGUURYUzRyYlc1ZisrZ3RpVGFEWlBHeFN0dm9w?=
 =?utf-8?B?empWOXR1ZitReUZXZ2ljVlprVElGNEFhZ0dxRWk2NjdJRkgzZFFnTE8zb3Vy?=
 =?utf-8?B?b3NNUzY5VkF6b2J3ODkyNTZMcW95V2FaKytIVmw0R1Nza3p5NnVJdVNPd1dq?=
 =?utf-8?B?R0hiamcyN2dwSFJkMGo3YnpXUnI4ZFlFdzRpTXpGbDVBRnVURkQrdW53K0N2?=
 =?utf-8?B?YmJQODdHTThkcEdEQStKOTl3VUc1alVzNTBHcGhDMkUrRFp4UjdMRy9ISGho?=
 =?utf-8?B?NGlkKzBWVjBZbHAxeG9MM0JKMURTcWFuTmp4dnlSNVlVWnV1MVdVaytiV0lS?=
 =?utf-8?Q?QpAFbmbxGcM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a395819-64d3-456d-515a-08d994b23b01
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:45:46.6686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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


Am 2021-10-15 um 4:48 a.m. schrieb Lang Yu:
> Currently, queue is updated with data stored in queue_properties.
> And all allocated resource in queue_properties will not be freed
> until the queue is destroyed.
>
> But some properties(e.g., cu mask) bring some memory management
> headaches(e.g., memory leak) and make code complex. Actually they
> don't have to persist in queue_properties.
>
> So add an argument into update queue to pass such properties and
> remove them from queue_properties.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  4 ++--
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 18 +++++++--------
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  8 +++----
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 +++----
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 22 +++++++++----------
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  6 ++---
>  8 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f8fce9d05f50..7f6f4937eedb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -557,7 +557,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>  	return retval;
>  }
>  
> -static int update_queue(struct device_queue_manager *dqm, struct queue *q)
> +static int update_queue(struct device_queue_manager *dqm, struct queue *q, void *args)

Please don't use a void * here. If you don't want to declare the struct
queue_update_info in this patch, you can just declare it as an abstract
type:

    struct queue_update_info;

You can cast NULL to (struct queue_update_info *) without requiring the
structure definition.

Regards,
  Felix


>  {
>  	int retval = 0;
>  	struct mqd_manager *mqd_mgr;
> @@ -605,7 +605,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
>  		}
>  	}
>  
> -	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties);
> +	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, args);
>  
>  	/*
>  	 * check active state vs. the previous state and modify
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index c8719682c4da..08cfc2a2fdbb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -93,7 +93,7 @@ struct device_queue_manager_ops {
>  				struct queue *q);
>  
>  	int	(*update_queue)(struct device_queue_manager *dqm,
> -				struct queue *q);
> +				struct queue *q, void *args);
>  
>  	int	(*register_process)(struct device_queue_manager *dqm,
>  					struct qcm_process_device *qpd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 6e6918ccedfd..6ddf93629b8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -80,7 +80,7 @@ struct mqd_manager {
>  				struct mm_struct *mms);
>  
>  	void	(*update_mqd)(struct mqd_manager *mm, void *mqd,
> -				struct queue_properties *q);
> +				struct queue_properties *q, void *args);
>  
>  	int	(*destroy_mqd)(struct mqd_manager *mm, void *mqd,
>  				enum kfd_preempt_type type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 064914e1e8d6..8bb2fd4cba41 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -135,7 +135,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  	*mqd = m;
>  	if (gart_addr)
>  		*gart_addr = addr;
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
> @@ -152,7 +152,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>  	if (gart_addr)
>  		*gart_addr = mqd_mem_obj->gpu_addr;
>  
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static void free_mqd(struct mqd_manager *mm, void *mqd,
> @@ -185,7 +185,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  }
>  
>  static void __update_mqd(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q, unsigned int atc_bit)
> +			struct queue_properties *q, void *args, unsigned int atc_bit)
>  {
>  	struct cik_mqd *m;
>  
> @@ -221,9 +221,9 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>  }
>  
>  static void update_mqd(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct queue_properties *q, void *args)
>  {
> -	__update_mqd(mm, mqd, q, 1);
> +	__update_mqd(mm, mqd, q, args, 1);
>  }
>  
>  static uint32_t read_doorbell_id(void *mqd)
> @@ -234,13 +234,13 @@ static uint32_t read_doorbell_id(void *mqd)
>  }
>  
>  static void update_mqd_hawaii(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct queue_properties *q, void *args)
>  {
> -	__update_mqd(mm, mqd, q, 0);
> +	__update_mqd(mm, mqd, q, args, 0);
>  }
>  
>  static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -				struct queue_properties *q)
> +				struct queue_properties *q, void *args)
>  {
>  	struct cik_sdma_rlc_registers *m;
>  
> @@ -318,7 +318,7 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>  }
>  
>  static void update_mqd_hiq(struct mqd_manager *mm, void *mqd,
> -				struct queue_properties *q)
> +				struct queue_properties *q, void *args)
>  {
>  	struct cik_mqd *m;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index c7fb59ca597f..6d468b6c8d7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -136,7 +136,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  	*mqd = m;
>  	if (gart_addr)
>  		*gart_addr = addr;
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static int load_mqd(struct mqd_manager *mm, void *mqd,
> @@ -162,7 +162,7 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>  }
>  
>  static void update_mqd(struct mqd_manager *mm, void *mqd,
> -		      struct queue_properties *q)
> +		      struct queue_properties *q, void *args)
>  {
>  	struct v10_compute_mqd *m;
>  
> @@ -311,7 +311,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>  	if (gart_addr)
>  		*gart_addr = mqd_mem_obj->gpu_addr;
>  
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -326,7 +326,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  #define SDMA_RLC_DUMMY_DEFAULT 0xf
>  
>  static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		struct queue_properties *q)
> +		struct queue_properties *q, void *args)
>  {
>  	struct v10_sdma_mqd *m;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 7f4e102ff4bd..f6c10b1b5f8b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -188,7 +188,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  	*mqd = m;
>  	if (gart_addr)
>  		*gart_addr = addr;
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static int load_mqd(struct mqd_manager *mm, void *mqd,
> @@ -212,7 +212,7 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
>  }
>  
>  static void update_mqd(struct mqd_manager *mm, void *mqd,
> -		      struct queue_properties *q)
> +		      struct queue_properties *q, void *args)
>  {
>  	struct v9_mqd *m;
>  
> @@ -366,7 +366,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>  	if (gart_addr)
>  		*gart_addr = mqd_mem_obj->gpu_addr;
>  
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -381,7 +381,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  #define SDMA_RLC_DUMMY_DEFAULT 0xf
>  
>  static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		struct queue_properties *q)
> +		struct queue_properties *q, void *args)
>  {
>  	struct v9_sdma_mqd *m;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 33dbd22d290f..bddd6d8fdf32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -150,7 +150,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  	*mqd = m;
>  	if (gart_addr)
>  		*gart_addr = addr;
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static int load_mqd(struct mqd_manager *mm, void *mqd,
> @@ -167,8 +167,8 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>  }
>  
>  static void __update_mqd(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q, unsigned int mtype,
> -			unsigned int atc_bit)
> +			struct queue_properties *q, void *args,
> +			unsigned int mtype, unsigned int atc_bit)
>  {
>  	struct vi_mqd *m;
>  
> @@ -238,9 +238,9 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>  
>  
>  static void update_mqd(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct queue_properties *q, void *args)
>  {
> -	__update_mqd(mm, mqd, q, MTYPE_CC, 1);
> +	__update_mqd(mm, mqd, q, args, MTYPE_CC, 1);
>  }
>  
>  static uint32_t read_doorbell_id(void *mqd)
> @@ -251,9 +251,9 @@ static uint32_t read_doorbell_id(void *mqd)
>  }
>  
>  static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct queue_properties *q, void *args)
>  {
> -	__update_mqd(mm, mqd, q, MTYPE_UC, 0);
> +	__update_mqd(mm, mqd, q, args, MTYPE_UC, 0);
>  }
>  
>  static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> @@ -317,9 +317,9 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>  }
>  
>  static void update_mqd_hiq(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct queue_properties *q, void *args)
>  {
> -	__update_mqd(mm, mqd, q, MTYPE_UC, 0);
> +	__update_mqd(mm, mqd, q, args, MTYPE_UC, 0);
>  }
>  
>  static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
> @@ -336,7 +336,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>  	if (gart_addr)
>  		*gart_addr = mqd_mem_obj->gpu_addr;
>  
> -	mm->update_mqd(mm, m, q);
> +	mm->update_mqd(mm, m, q, NULL);
>  }
>  
>  static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -349,7 +349,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
>  }
>  
>  static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		struct queue_properties *q)
> +		struct queue_properties *q, void *args)
>  {
>  	struct vi_sdma_mqd *m;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 243dd1efcdbf..37529592457d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -121,7 +121,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>  	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->kgd) : 0;
>  
>  	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q);
> +							pqn->q, NULL);
>  }
>  
>  void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
> @@ -429,7 +429,7 @@ int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
>  	pqn->q->properties.priority = p->priority;
>  
>  	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q);
> +							pqn->q, NULL);
>  	if (retval != 0)
>  		return retval;
>  
> @@ -457,7 +457,7 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
>  	pqn->q->properties.cu_mask = p->cu_mask;
>  
>  	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q);
> +							pqn->q, NULL);
>  	if (retval != 0)
>  		return retval;
>  
