Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99EEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 22:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEA010E7F4;
	Thu, 27 Jan 2022 22:59:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C37F10E7F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 22:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vaeugg2N/8VizgNoiEiOiYyT2/xii/UJr8YfVhSaRezmsKk+3MbvukyIhNiqrbbKGcJzh3BYBzlZEZYduk+n1iM6TCLpwZBv5mDKxwSYN+6RnBWaw9EnfF/CipTYrJlbV4k+JAo3XoOIb47my11ON2Q8csBiUXL/8oyj4f3FlAtW16Rd0Z9p/USrYG9z5K0sFZVnmuwquRL0Pu2pLUm6xerkSGSIQuaczQQ/AJGLQh3drv/D04bHoHAyKuWqm4cmFnEgxchITQhsSEJ3XlXRkqvnUIyxeWK74T4ZCFr/5CHv+BPGMhBREPkTbJphHhlxt3whZJBxWblftdk+27G7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuNZy+VkeGikXF77UUQlblT+CSPGZlza+SU2+cDY//w=;
 b=knbbsfuR9R55kp4kOff0pXghh5TIb5b8NwoplZE8OYiXiTe1cU+LcStM30GsF6OVoRV4iBHSbraUhWKW2DQFJXmovcjR7KgRxGfGXyZ/xUwOiXPM7ztWXJZx6rRKQdB+Xgh8NUhsSmmW5lRMNk3qtupbKY7ppiCER39uWPmcv9eC/x0eVx/waonDk2eqeL+/I2f3hNfY1uSOdf3kgxTjHvxKxHTaEqQfc+GZwTuudbBUzJ0HD+zp53usFc726RHg4h+sX+Oq4Gx/wU2bLNdlSbWDbefrmzCM1heOnd8nHbqtub2mB6JvXwMEf/2BkM0jjSB5A0aQ14jnT6FzGHx7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuNZy+VkeGikXF77UUQlblT+CSPGZlza+SU2+cDY//w=;
 b=PQaYBu9Bs0qSUpzFFPu8lSNGI189DUg5N8iIl6Jxbj8YFIV4mS7n9ALC07WUSBQus9piL7P6A5qwS/izrObEYOM5UILN1FdI2VSq8Gz3I2ZFTnKyZoabhOTqyapnvb+Ur+pF5QpStzy0Cvusdnnrnfv0XpBNvztl6Ai0hh6DZ2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB2969.namprd12.prod.outlook.com (2603:10b6:5:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 22:59:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 22:59:08 +0000
Message-ID: <bdf1fbc7-b458-6bb8-7f2c-494887ee1158@amd.com>
Date: Thu, 27 Jan 2022 17:59:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/8] drm/amdkfd: Enable per process SMI event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120231322.10321-1-Philip.Yang@amd.com>
 <20220120231322.10321-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220120231322.10321-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44fd7eed-0328-4033-fcf1-08d9e1e8a013
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2969DCA5C7E7F278499C1E5892219@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH/oNkcfJBvtC7C/2D75mn09Pzm3E1ImI+7XzXTh4VBESwWIEsqDhgV351oQPpe0opS/iusB2Z5oZUw2M5eeXmkSQX7EmGWhYvZPLnCQnECjc4wvV2QMWOn3sIxGkdX4l+Q7eshMRUp3P4jCfN1hubAxGgjJH/rK2kPEy5C9ahuxHDmKBKdOy1fYv065M7eof5RzL1aG+Z+xCttFU5FA8FH7elupV/jw2HuatyuHkDzwvaTWF0jnBZrMdya00+Sh236B2REpWJXqdgBACf3vr8iYN0Pc5J030Vf/Gfw/jDuO1wiw8TKWdf5Ce7t0W2RdbJB+DkAj+hQiUe/4RDei6YCASesofhwwcSULQBkZAe5cRAwj6010QIdLVB4dXj1V5MTo4FCKPB3EBLm8bQthCgEEWUlpGmVAVBtWhxQ09KxqsektuVioq4JCKUtDl8fHD9jVuIh5fEow06x2CmyspPX+DhM3MrgaVReLgxhTDht+8osjc8qNam9YApMuPkViAOPAOV3KhVjhyHNl3+zi9wNb0liDxOFQr44i2YQX2MyBf/W/PXJAGzv2ENI0Ux9bTNYKCYWSWrp7165j/VPGP59aTN6GONVMe5w3psMhXeqIhfaonUrGKy6ugrWpAFt0Ozkl9D3tuk7rZxXc/DLxZ5mQxZZmkc8f5Md3J3LF630+QftDxdNwK/HBaDnGqlhFYflw7+VeqyW9QvbMmm/YDaOSy1+ZjyHM2EOwsbAp0RW4wxvdka67fGsYBIw4tTZT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6506007)(31686004)(36756003)(2616005)(44832011)(2906002)(26005)(38100700002)(86362001)(6512007)(6486002)(508600001)(83380400001)(316002)(5660300002)(8676002)(66476007)(8936002)(66556008)(66946007)(186003)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1YeFpOMEFlTFc4d05kWktqdDJUdDlXWUlhYUFwblBnWnNsN3k2ckZ6cmJt?=
 =?utf-8?B?cFoxbWMzTXBrZDkwc25oQnk1NW9ZNjI1S3dOT2NHYVhvb3NHblRVYm91NDFH?=
 =?utf-8?B?aVk0L2E3S3VZT1Y2eWZBait4QzlkTnRJeURUNXdSQkNRbmJBUzJFV2NFcGZJ?=
 =?utf-8?B?NXJncTBneE9VRkpsb0VrSHRNZ3o2dTVXNjFtQmY4QW5SRFJRWDBYazVBbURv?=
 =?utf-8?B?bjA4a2NzbzcxeG9QdjAwczN2NUxVN2VYQzdTNzJTeWMzWE5ac2swa3F4QVdT?=
 =?utf-8?B?TkdFUk1PUTdGWXd2aHVrZFRLZW5CQ2dISWxFS0JHM3Z5Vnd6Mno0TG16SUU3?=
 =?utf-8?B?cGdndzNRd1VGMXpDcFlodDRkaUdXVnJYb3R1UDQxU1lnMGhzMU1oT3FhbUEv?=
 =?utf-8?B?cDJpVkFaUDBneU9sbEN5Rks0WkovR0VETmV4akxxOUpyVjJDUG5vQmtQa25Z?=
 =?utf-8?B?UXB3WHArQmdtOFpZa3FkUGJGRjQyUVhZejdwZmxOdjBEYXFHWnhEVTFCZGJD?=
 =?utf-8?B?azY5UTl2MTN0RXJKc3lRNXFqTk9yekQ2cmp6YndaQ2tUUGZhQ2NDdml4c3R4?=
 =?utf-8?B?cklRYkN6NG4reDk3aDdzVXVaMlFSRTRTdkdrQXR4K0JIbWhRVzNzNlo0Z25i?=
 =?utf-8?B?Y3lIZnJGK0JlNDVCSHllNGt3dEJoUmgwdkQ2anZzeHI0cXJQTVRzcjVuaHI1?=
 =?utf-8?B?eHp6akZ0dWE5dFpFTkxEU0tPUlgyT3JMNzBPYUJSNlRWK1E4V1FRTUFJNFRU?=
 =?utf-8?B?cm9xeXA4M0gvaXFIWHhzQ0R6WnRmb3pMT1lSbERaNlIrQkt1bm5EU3RBYzd2?=
 =?utf-8?B?S0JmcVdUQXVCZEdLb2pna3Y2ektvRW9Da3psYyt5RDFSRllXNkZ3YklJbzJ0?=
 =?utf-8?B?RFBYdE5MTlp5c3NCZnM2Sk1Tb2tKVnB2UmZCMFBHWTJldEpiYWMyK2krYWZU?=
 =?utf-8?B?U0cxMkRiNE82SGFneTNMVGdIVTJxZHozWm04ckg1UnZQR2sxcTN0cDlybDE2?=
 =?utf-8?B?VmJMQkx1dy9Xb3pzdkJxN0ZqMXRRanRGU01kNlVId3VNVmlnRXhvTXdFNklG?=
 =?utf-8?B?SzVYT283cFBQNXZjclhnOXorbDRtL2RMYlpnZzZIQnBleDlQaFkraW4xek9t?=
 =?utf-8?B?UUhDSm5LUnZLZXZXWjRiWmJwSUVqenhoaUhZRnpGUEx6OFJ3RldCdWhzSDdo?=
 =?utf-8?B?Wm9KbGVZMjJReGc5ZWVCc2M2eXFMbVlsMTMxQnJBcERjb3dkVVFUTE1wbEV4?=
 =?utf-8?B?cU45QlF2SURwakJDaDR6bU42VGNieW80TUZoelYxYXlJMVA0YTNKVFYxZFZp?=
 =?utf-8?B?TmZ3MWhPWWdtTFJYWjQzbTA2K09aWDl0WHNiWEtmaitzY082Rm0yRWJyQUJh?=
 =?utf-8?B?Z1hmTnl0NForWmJwVDZZK0ZlQXg2VGY3MC95UUdkRlBkWHZOdnhISlY2R29O?=
 =?utf-8?B?OXJTVytDZXdjSWxWZGFkN1NHVWo4MlNaRjJ1QUdpNWEzMXMxSE9sekt2ZkJP?=
 =?utf-8?B?d3dMWHo4Zm5wVnNJZFptMnl5RkVEaHYweDFvcGJRNGR0MUZVY2IxNkg4Y1Q2?=
 =?utf-8?B?NVVPbHpXNFJnVXJTL3JYbVpLaDYxMENoYlBjdERKcVZLeStUdEZsU0Y1Mmts?=
 =?utf-8?B?TkxpVFRpc3NWcUVnQ290Sy93TGN4VVVnUXVFUFVpZzhPcE9Td3FhSTdBL2dR?=
 =?utf-8?B?RnRMVnRLbUdWQ0JIQWZtaXFuT296Rjk1V1JjSUxJNlRXY1czbHh3WEpmZzdG?=
 =?utf-8?B?aERVK1YrWWFPM2FCakc3WTBmSW1kdDBZZmNuTWkzOElHd2c5eEFPaEM1Znpv?=
 =?utf-8?B?MDNDeTlFM1BYOTdLSzdCSExrR0dNTjlMS1gzY2w4cDNpaGFudnFFVjlvYm9M?=
 =?utf-8?B?QXFnOXFZeEsveWFyR205SjlYVXpnbHlVRUZFM2ZiaGtrMXB1eEpBendsK3Bu?=
 =?utf-8?B?VzFFcFpyd2hsWG9TZVc4cnlqQUVKb0lBd0kxZGZoOVpzNXovTlpOc2ozRk9K?=
 =?utf-8?B?Y0pkampreTIwUFhnWXpOWG5QTEdsMmw4WUl4dm5WMVlZVnVLc0ZTMndMMzRO?=
 =?utf-8?B?Sy9xMGNMZjdEbSs4RkdodThJN0FSODZwcjltRFJSM083QXJEMFMzVUFxZVlu?=
 =?utf-8?B?eWFOOUJIbTJGTUdqTEZMVFFuV3g1NUc2dEV2bG5qcUhtejl6R1QvWXZxQ2FN?=
 =?utf-8?Q?lYAIxirOhQY/mrvmpfJ2tOU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fd7eed-0328-4033-fcf1-08d9e1e8a013
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 22:59:08.6930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abC3dPBSa+3z9ae6qmtxE8CEwT7FfjfhcJSMCbjHQph8corkHmWR+aN7fWLV8BbOn8XI4nsM6EQp2BOt4qg1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
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


Am 2022-01-20 um 18:13 schrieb Philip Yang:
> Process receive event from same process by default. Add a flag to be
> able to receive event from all processes, this requires super user
> permission.
>
> Event with pid 0 send to all processes, to keep the default behavior of
> existing SMI events.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 29 ++++++++++++++++-----
>   1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 18ed1b72f0f7..68c93701c5f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -37,6 +37,8 @@ struct kfd_smi_client {
>   	uint64_t events;
>   	struct kfd_dev *dev;
>   	spinlock_t lock;
> +	pid_t pid;
> +	bool suser;
>   };
>   
>   #define MAX_KFIFO_SIZE	1024
> @@ -150,16 +152,27 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>   	return 0;
>   }
>   
> -static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
> -			      char *event_msg, int len)
> +static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
> +			       unsigned int event)
> +{
> +	uint64_t all = KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS);
> +	uint64_t events = READ_ONCE(client->events);
> +
> +	if (pid && client->pid != pid && !(client->suser && (events & all)))
> +		return false;
> +
> +	return events & KFD_SMI_EVENT_MASK_FROM_INDEX(event);
> +}
> +
> +static void add_event_to_kfifo(pid_t pid, struct kfd_dev *dev,
> +			       unsigned int smi_event, char *event_msg, int len)
>   {
>   	struct kfd_smi_client *client;
>   
>   	rcu_read_lock();
>   
>   	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
> -		if (!(READ_ONCE(client->events) &
> -				KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event)))
> +		if (!kfd_smi_ev_enabled(pid, client, smi_event))
>   			continue;
>   		spin_lock(&client->lock);
>   		if (kfifo_avail(&client->fifo) >= len) {
> @@ -202,7 +215,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
>   	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
>   						dev->reset_seq_num);
>   
> -	add_event_to_kfifo(dev, event, fifo_in, len);
> +	add_event_to_kfifo(0, dev, event, fifo_in, len);
>   }
>   
>   void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
> @@ -225,7 +238,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>   		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
>   		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
>   
> -	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
> +	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
>   }
>   
>   void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
> @@ -250,7 +263,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
>   		task_info.pid, task_info.task_name);
>   
> -	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
> +	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
>   }
>   
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> @@ -282,6 +295,8 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   	spin_lock_init(&client->lock);
>   	client->events = 0;
>   	client->dev = dev;
> +	client->pid = current->pid;
> +	client->suser = capable(CAP_SYS_ADMIN);
>   
>   	spin_lock(&dev->smi_lock);
>   	list_add_rcu(&client->list, &dev->smi_clients);
