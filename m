Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB6C636C8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCA6613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCA6613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BA96E8E6;
	Fri, 16 Jul 2021 03:27:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3546E8E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 03:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/UxkAjukyVH7x9E8ceXfu8/HIKg6AC7jbcnjZlK0L9D4aKKJAZ9nBysbvafi4cnF+w3ZfwMSYzufiPgMWYZTLTr0IVUkk8YBKu6kA+Hj9fkK5nWUQt3lmLEAZ3FF+8j9cW6LxfyhHjPAzL86ZvvnyuMe2FRHA9yszvSGPSMfHQ4jJ4qLr7AkYKDiMnyl2Xwmb6ZvMgEmGQIvMTVTpLZaQRCIEVnK1rDSOGzp+LPvm71/15bAiO8WVR8rcz+qCmwuAp1vhGjR6dwFtmCf/pY092xseaHWctj9tQFaRoJ/b5robZ3MOgOwrNhWHYAROwJr6HepH++KS4dNLyyHPa2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5Vf+6ib+osAFrtN58dlOu2QeGuyjvqD2XEnH0YkQac=;
 b=bKnvorW2Ho1RaVibzfvIULOxPj7qUlBWi/l1KhTynSzbB16Xo3XqI8ae6pVaeiqijcH8N2As8AYdHh0k5srs4Sh+WSn/XIgkHbjCuDz2Vi4JvHDC0bKu2/wZ5fzJ9MrOjUUsUIa3V4cTcG/igEKgKNkompGPqxy56k4xOrb2+ouFvsbamRp43DGWtUHZHF2bPr/A7xSZyQtV7aecqIL8IIzMbMEIAONf9G4rtdbQH/niky/OVgPwER6TKMR3qlpRiPlRXECH540ItQIXjxpvBa/FonaWGF8kfkTBV30cvY+huYURT0JXp1gsRmez5zzOraj89cI/cV26aHGf61zH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5Vf+6ib+osAFrtN58dlOu2QeGuyjvqD2XEnH0YkQac=;
 b=znB07m9e4umrzS3jpeIqMqjPAFtL+AGW5/2qvyceEb5VT9t6yXnpvvGwBFHr9eiE5+fRq+TP3x4uwV9xc7829L8v/5nfgYZkPybrg25wzpa70/jP0tv07lR7RWu5lGuQmqeIugKWm44PcNAu2JGsAHuGgLKg3qdMOQ9jPda3gt4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 03:27:19 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 03:27:19 +0000
Subject: Re: [PATCH 5/5] drm/amdkfd: Fix a concurrency issue during kfd
 recovery
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
 <1626399273-21347-6-git-send-email-Oak.Zeng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <6cd36a02-1cc8-d43a-f827-3728f0153200@amd.com>
Date: Fri, 16 Jul 2021 08:57:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1626399273-21347-6-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 03:27:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90feeb9b-b91c-4888-56fa-08d948099da2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55210931E9F0E65493A9025997119@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5HbeFFzLWJ8aqoD8EAXPfOmUpcUPgGsB2jMk82TiilWkUaHt/7Ae7JrySLGNjiLAK5VjzmPcDJAjHPr+mWctc82guLDKzuLYBflTl9rRngTQZ07sj+8X1c6Fvxn8JcJsiEKLyj+fCzqAhUfvMIeSpRwhSGLMhq5+fqTgZOVc5bHBbedJkRzgYKn5thGQAUq4qwABA6XkIW3CjALjDNMkQuhh1W82t+iAO05wSpGEvHiw9LybLta10ThN2Q8wlKDfq8Q7cuvWPsHsse/jLVlgd2kNkAmjqBM71WwVYcnYOf8fIxDdKualieOL0JfzIrit3YEDPRgjLMOx1w0undrz63IZBM3YLPZ/sy65TIOTcQT/xraM/pk8985aZJLQJ+vuuN2Kkl6yyeNp1HmISujFCxKdfwQjOkoIj221PZiD7gtSmK/ipHWlOp2WVYeEedsHzVwYsuBxfNL3yD7wQiw7YtPMv9jJF9uGLZ8VB9Oon/felIwP0UOGl++3LgH39eZ+MhFrGmZaR4e5fKri3qHjTgKGYL1jKOsyJzLFUeMCkHOy/ZNReQRRIzeR6/UkuIpDwKTiKMAjJnRosMkXwicBphNqKS1F5eXINTXHC6YazNN2U8esgBymaFWSYABQtdjkPRXo2jFsiP464RjGabTYKMX4JqF4vg+n+ww78kgbqJmF1Jn7DEY3XgvuyKq+zX+byFNxHGfqF/9b0EFUX4lG9VWSHKi8ExsrVnwXM8+vYsPkfGm8UWcEFp6tq1WX9x+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(31686004)(16576012)(956004)(2616005)(316002)(8676002)(83380400001)(2906002)(4326008)(66556008)(8936002)(66946007)(66476007)(86362001)(53546011)(26005)(6486002)(478600001)(38100700002)(36756003)(6666004)(186003)(31696002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VEeEYzNkMzL2xnOEZTYVFGM1MxNWhUdXdwQlJ3QXNQdmNIZVJNSTNkZ2tL?=
 =?utf-8?B?NldSc2FNdU9MemU5RnJoc3Z6NUltT3ZsdTdjS3NqNnVhTU5BZlBnckp3U2ds?=
 =?utf-8?B?a2JnYys2WDFQd2hGK3NVZiszTHp0MUxLU01QL093YXRicHA3dWFJc1FSaFY5?=
 =?utf-8?B?cXBleXhPbEVBNmVBUG9HVGRyRnlta2RNS3YzWDVwODVPWEE5TGVIZUxwMk4v?=
 =?utf-8?B?T2R3V3ZhcjVlWis2SXkwNnVLb2VyODJreDE1aUV5bGY2NlA0NWgzZVlhalZI?=
 =?utf-8?B?WUVjdGZZanpoYzJtUjV0NE5jaXVONUt1SmtqNVl3S3hJOUhvdVRGc0F6ZW5r?=
 =?utf-8?B?U3Bpb1RqMHVHckRtNm9Db1ZqZCt1K0ZVNk8rSUdMMUJOVGNOZVdyWXRKeFBr?=
 =?utf-8?B?RjdramRWNXBQYVZrTDNvdk0yU252bXBJbHlkdkpBRmR0ZmdZTTc1MnluUUlu?=
 =?utf-8?B?WXVlcGFaNEhEd3k2Z2c0U2ZpMENWMHYvTEMrTTVZMnBuMEZpaDA2ZFowTDdZ?=
 =?utf-8?B?UW4wcCtONlExbVJvZFEyL3FQU0FxV3FqUmxEYTVyRFpsVjJ3bDV1SEtxQ3VT?=
 =?utf-8?B?MDFiTG85cUJpQi9SMkpvaWdURG9MVkNSK09TZXF0VHYyK0N6b1pWQ1NjZGE5?=
 =?utf-8?B?MjRGWFJzMTZDYy9lbW9RY2gvTUE2d25kY0tac0tjQTlBNjREVTVEcUo5Wkdr?=
 =?utf-8?B?N29JeWlEZk5EVWYxaUJkMWNIOXZCY3FhTGl4djYrbEd3Mkl2QVhiQURybUlw?=
 =?utf-8?B?a2NXa2hNSm5Vb3lKVGt2REVrTkJSQ3dzSStiOFZjd1dCZjhtWkdVZHNTZ3h4?=
 =?utf-8?B?OVBZaHZFeGRUWlFmQ1E4bGtKcnBpcjFsN01HMzBkMExhQk1rbGJNN2Z4V1RL?=
 =?utf-8?B?YkpYYUkvRTRhQnFLWUx6OWJ5ODRIN3VJV1YyaXFEbU5FckZWOHR1NlgyZWNl?=
 =?utf-8?B?Uy9OdGRxZi9jem1SWDZWalViMC9GdGhBNE1uZllaVzNqYVdmSEp2Q1E1STk0?=
 =?utf-8?B?MFdrZ1lreGFJMEl6dk9XVmdrTHJvaU5lSkJpZWZFUVU3ZUE2eXlDR3lCR1dV?=
 =?utf-8?B?UlROYmJwS2dISWZtZHArdmRlemZIcklpdjA3SndTVGxVeFIwY0kzeUJnS0VI?=
 =?utf-8?B?dTdDbzdOUWt2dkZlWjJpVXdjMjlZaE9wNy8yMmorYVpWYldXOERGN2JzcVgy?=
 =?utf-8?B?dlcrZ0NRbGVqY0lFaTk5YXdMbDY0VWc5QklTelR5YVo3TFJZZnkvSXJCTGJJ?=
 =?utf-8?B?Si9nTHpTM2xPdG93U1RVWVdZWFFWSjdIMGkzME5seHpuWHNGM3QzaXB3ckhV?=
 =?utf-8?B?dVliWW96YURubmhqdlBvOEhhalEzMkRTc2VwczA3aUhTbTVwMWxpbzZoSU5X?=
 =?utf-8?B?YVMvSUlrOHgwaHYrTFRkZ3MzSk9LajZEbExIUDJBMHNCSnpTNEdlOFdFcEUx?=
 =?utf-8?B?MUwrNXhyeHlmeG1LTGtQZXlrK3c3VWdSa0ZucXFSMThMdHpsd09lOVRHQjc0?=
 =?utf-8?B?eFhqQStUOVd2VlR3anlPUFZFWUVzTGQ3YVZXNW8wRWdjdnJxUTA5ajZid0hV?=
 =?utf-8?B?L2VkRmFEK0xtaGlKUWJsbGQweWZQc1RzbGpETG5ZWmlUbEpzVTQwaVd1dVJK?=
 =?utf-8?B?ekI4UGlMV21LYzdQVjlGS2hGRkhsUm9ISW5nZG5HMExRZk1XdzNqTTBnSjlG?=
 =?utf-8?B?WkhVM3A5MXNIUytOQ1ArV3lXYkdHbFVxR3ZFbkdkU3dybkRNOUJUSmxXNVZF?=
 =?utf-8?Q?RFK4WQzQ9JnfRhVJxseBUrngtUqQNGduPeetMS1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90feeb9b-b91c-4888-56fa-08d948099da2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 03:27:18.9608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09ifNKE0qR5LRTRulqqRC2lJA2+E7sXHGTqOJiQTiKAPtansD1V7wh9cjrwdabuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/16/2021 7:04 AM, Oak Zeng wrote:
> start_cpsch and stop_cpsch can be called during kfd device
> initialization or during gpu reset/recovery. So they can
> run concurrently. Currently in start_cpsch and stop_cpsch,
> pm_init and pm_uninit is not protected by the dpm lock.
> Imagine such a case that user use packet manager's function
> to submit a pm4 packet to hang hws (ie through command
> cat /sys/class/kfd/kfd/topology/nodes/1/gpu_id | sudo tee
> /sys/kernel/debug/kfd/hang_hws), while kfd device is under
> device reset/recovery so packet manager can be not initialized.
> There will be unpredictable protection fault in such case.
> 
> This patch moves pm_init/uninit inside the dpm lock and check
> packet manager is initialized before using packet manager
> function.
> 
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c               |  8 +-------
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       |  3 +++
>   3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index c51402b..adc2342 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1383,18 +1383,12 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
>    */
>   int kfd_debugfs_hang_hws(struct kfd_dev *dev)
>   {
> -	int r = 0;
> -
>   	if (dev->dqm->sched_policy != KFD_SCHED_POLICY_HWS) {
>   		pr_err("HWS is not enabled");
>   		return -EINVAL;
>   	}
>   
> -	r = pm_debugfs_hang_hws(&dev->dqm->dpm);
> -	if (!r)
> -		r = dqm_debugfs_execute_queues(dev->dqm);
> -
> -	return r;
> +	return dqm_debugfs_execute_queues(dev->dqm);
>   }
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f2984d3..44136d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1164,6 +1164,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   
>   	retval = 0;
>   
> +	dqm_lock(dqm);
>   	retval = pm_init(&dqm->dpm, dqm);
>   	if (retval)
>   		goto fail_packet_manager_init;
> @@ -1186,7 +1187,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   
>   	init_interrupts(dqm);
>   
> -	dqm_lock(dqm);
>   	/* clear hang status when driver try to start the hw scheduler */
>   	dqm->is_hws_hang = false;
>   	dqm->is_resetting = false;
> @@ -1199,6 +1199,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   fail_set_sched_resources:
>   	pm_uninit(&dqm->dpm, false);
>   fail_packet_manager_init:
> +	dqm_unlock(dqm);
>   	return retval;
>   }
>   
> @@ -1211,12 +1212,12 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>   	hanging = dqm->is_hws_hang || dqm->is_resetting;
>   	dqm->sched_running = false;
> -	dqm_unlock(dqm);
>   
>   	pm_release_ib(&dqm->dpm);
>   
>   	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>   	pm_uninit(&dqm->dpm, hanging);
> +	dqm_unlock(dqm);
>   
>   	return 0;
>   }
> @@ -2104,6 +2105,11 @@ int dqm_debugfs_execute_queues(struct device_queue_manager *dqm)
>   	int r = 0;
>   
>   	dqm_lock(dqm);
> +	r = pm_debugfs_hang_hws(&dqm->dpm);

execute_queues look like a misnomer now as it combines the logic to hang 
HWS.

> +	if (r) {
> +		dqm_unlock(dqm);
> +		return r;
> +	}
>   	dqm->active_runlist = true;
>   	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>   	dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index b130cc0..0123e64 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -448,6 +448,9 @@ int pm_debugfs_hang_hws(struct packet_manager *pm)
>   	uint32_t *buffer, size;
>   	int r = 0;
>   
> +	if (!pm->priv_queue)
> +		return -EBUSY;
> +

EAGAIN may be more appropriate

Thanks,
Lijo

>   	size = pm->pmf->query_status_size;
>   	mutex_lock(&pm->lock);
>   	kq_acquire_packet_buffer(pm->priv_queue,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
