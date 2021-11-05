Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 15:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38147603E8
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 15:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38147603E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45416EB5E;
	Fri,  5 Nov 2021 15:04:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412506EB5E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 15:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmO3qTbFHwJ35/K9iD8lBwZIa51hQ1AznC0zgZ0xJqWpQ4kRCFdgyM0ke462HwvjJYulZ6bmvJUNhWqZdXeEKRMfKAA/NqsMjc2kJyqSEF4TWOeH0FkWN33LgVmktuEJQlFCC3kUkXCvM5EpRMK5aOozo+4MD6IEEJPL38kcUAn8SWNGYmyJ7UI5WCZsmzv4OGXKojxAOfhbPAjENPh4/jegiv6B9iQLN9AktbT/q3MQSVusz2HHgODGWGwX4FPpvhfpsOiQcJC+xH5ZWlV1O1JQHyiAgkGLBIU21FhWvBdrQ6oSH2xmD1xDFFSf5lBNKdvNE4rVJHtoLu3V5cF8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dw0Uhp4ItbFu+xhB3qL/MwI8epi+PPvj/zyg7oBL47I=;
 b=YrleA7CTWTdjIi0RH7nH/Ph6IDqVyJCKgROIA8k1QdVipBo0FVH6BxojcefxJ9qixystq/URrkMVwNoa7gu2qAqVkZdJ35Qzag46EihsrFIAQzTiM41ARiiju5A3ilVWaQTCbObpgo1KP1JNjscf8ZywOD23rMxZryuYgVYYVIlTw/Yxue1QgP/Liz8rNMWJwF47wJW7L7PYkTfllMjH5gnV103omKlf66kPYTfONPbN2doGw68pmFGwOMQ8LSAVVuTj+Ekj0WBKIrD1kEkNeLJI4ri/Pmxk+Yu86pyu9gXyJySOV4ySLKQj64Xj683073wPheVJOVo3JNjCiBpksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw0Uhp4ItbFu+xhB3qL/MwI8epi+PPvj/zyg7oBL47I=;
 b=PqOd6Jm0c/2q5M4zjCKN5bPnQzFi/9I/OQfUgayOTI3Fkr0Ds5ALzGaK7mHTIv4F7h5lDLt6xavqe1t7k/yYbu/Kk65z8JP6OAYNgQvRO3y/xGyEqX0r9mpJ3kRiQEk/8ysnhGHP0RTlkLoFsTgZZk5HheQkWzx9AnGKaZPVclo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 15:04:20 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 15:04:20 +0000
Subject: Re: [PATCH] drm/amd/amdkfd: Don't sent command to HWS on kfd reset
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104165331.26614-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c41d16e4-c3cb-39f8-9074-1d635036a0ac@amd.com>
Date: Fri, 5 Nov 2021 11:04:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211104165331.26614-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::25) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 15:04:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fff3b2ca-975d-443f-2925-08d9a06d8b47
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4578FD19189035A2826B2621928E9@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+IUf6YXkOSzUIPCCHMnDbL8T5dueRZXWH+VHDcbgTIjKLcpYURGj3uzSox9Rehepm+XOlh2FJ6EC+E4rpmHZvie9CVAq1YuZ5Zd9u3K3MPAwIVUm/1JSFnjwbCApyfwbrSyEi/rLjwHF9lIzagUjIGY55PgiHVCh2778YEDoD/4seNDorI3YIk9WIEkgwkgXEUpszb4sNAhjy6oLXn4KZJ0cp1Z/XEUGaBl7jWDxDLX2DsG4MX6uMKDPxtFo7ccfKYZHMGo4LKMGeiPeBVuEirWw/LLD+Y3kplox5xVe4vCuc9X6TiuZTZUjH1Pd08KTS6XvI8pQtaKSdarXsaHwekvGZhz7m4Gc10+34gyv/MrmV9ifihbAtbJLzXpTYoWd4DQvdaIGwgysbu6MD82l356xofruKz7sGL39Gr00xHTi2miISsdxVw1ckieqBtNRO7JcNG8WqVERaFomO/LZ/xxM4crelSvWvTAymAB+xopVbQ8Hv/CvlvwvX068cS5S3odl2oEiq1Yl4OmkBPDaAm4gOkpg4t+ZH6f6zi5cvN8796sXu8kAoyyr45/CUi56n84YOX3Mxzx+8gp445r1jC0e15T39Mq+Mt4S/sH5zhfyq4ACTmTyQOJPii0/BuGycWt3LoM5b3Hhq5jwzSFqmFfqfeC5ijfpWRJLfQjHr58yGdpWRktno4UjZU4YWbWH/MiNa1OeqeVPo+7Ww07xnVoQ5xksxiwbPfX3BfouV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(86362001)(26005)(508600001)(44832011)(8936002)(31696002)(5660300002)(186003)(36756003)(31686004)(16576012)(316002)(83380400001)(6486002)(38100700002)(66556008)(66946007)(66476007)(2616005)(956004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHIzK1ZLRE01L3BLYjJoamlpQ0t4ZlRvVi8rYUY5OG9sNE41a0dzdDdDcnhq?=
 =?utf-8?B?aC9XRW5LdHVWYnNBaHRwc2duYzhia2pVb2Q1bHNILzZDdThEUExCYjVpaVl5?=
 =?utf-8?B?TFNJQmxSVGFwYmJ1eE9mcGE2NUZ5L2FpNEt1Mkg3eXk1Q1VIQk5MUTB0N0Jo?=
 =?utf-8?B?OFlBZWt3RUFCL2QzaVJYdzRheGsyNXVrSVIyS0FSQjd4NUdVZHNaVzZOMnMx?=
 =?utf-8?B?ek9FWGc5NFA4L1lITkp1SG1CQmRTdDJQdE53R3dyOTJFeEE1M1RESmVOd0N2?=
 =?utf-8?B?Y2tUTUpzeGNaOHh6ZFZteVJqVFpaWTVhcXpKVE94VkhrWjdDR0R2VnRJbGcv?=
 =?utf-8?B?SVpmalp3VmZJYzgxWFBRQjhsQUFsUmcvaVNJcVpPV21hZ2VmTW41MXppcVJH?=
 =?utf-8?B?RCtHVXB0VkVTaEV5ZThZcDdzY0lzSGplWEducFQ3eG5raW40QW1vcUhWeXNo?=
 =?utf-8?B?QzlMVHAySkE3bUt6Z2dQeGVjUklMb2xFMEhSQ2FYMWcxRmtNNTVTUTRQNC80?=
 =?utf-8?B?dTdtbUJTMDNrVUMrOU1wOTZJQWN3YyttTVhlMVNZZytjOElpN1JIbmJjblJy?=
 =?utf-8?B?dkFDMTB2NzVsbE5NaHdnMHJJWHBCQnVLOTQvcnBycFc4c3ZvNUR2YVoyZzFm?=
 =?utf-8?B?VjJHS1ZZSll6R0RNLzFJL1ViMXJiNWhhci9JcU5vOWxRVWdHV3piRzVhQnB1?=
 =?utf-8?B?Wkl5bHk4eXRuSkZvWHBtaUZNOHc4N2tSL0xTYU0zeDlQVWU5RENOZzdJRHZa?=
 =?utf-8?B?VFhTNmVwaVNTWWlzVkRGa1JQSktZQkp4YktVUm1ZK2NnT0hYRHRSUVVNZGty?=
 =?utf-8?B?d1JJQTlIaytFYU92WXdFdU5PNXhpREhUenBKVUV6c0pEOTJOVVFNVmVVMThp?=
 =?utf-8?B?eEh3NXhha1p2Sm1EcnlsZ1Jtb1pUam94ZVVtbk9TV3FrTWlFbG1LVEJNV2pH?=
 =?utf-8?B?SnB6V3FwRUd0VDZJN0NtckNlUE42ekkrRGlKcFVhUlZ6RklwRWZvb2h5dW4w?=
 =?utf-8?B?SCtYanJQbzgwVlJidzJ0Rktkd1o4NmtGaVg1allMc3Z6ZW4xNEt1ZzJqV3lJ?=
 =?utf-8?B?OEVSSzR4KzZTSEM2MGN2aGZVV2hNVTZESTdmNDFCUTg0NDU3bWZpSk9QQXpQ?=
 =?utf-8?B?d1ZhUFVuZEVIUWduSDE1ZzhZclFLbGZkMU5GSFJ3aEZmc3BBNmdma2tDeE1U?=
 =?utf-8?B?MVMrZmlML1pVYUhiZ2l4NmVJZHpGQ0ZaTk5TY0NzcWx2QitKWWJGdDZubCtO?=
 =?utf-8?B?d0JwcnFXQWFVRnNiY29zSVZ5c2tZc2FLdWlIS0owUmtzaUZ0R3lRUFBTV0t1?=
 =?utf-8?B?V0o2dHRYUVdtcXJRdVJnaGd3MkszRDB5WXAvZlBUc2ppSTlZYzBSYlR2a3RB?=
 =?utf-8?B?bGE1RGVaQ29OVFdEU2dxcSsxOG5VNmRMUit6RUpaUFh4aWFudGZjcW9sTDVr?=
 =?utf-8?B?NmdGWXRRMWE3WUFhZ29abFBIMHpuVy9vZURpSitIbWNwMVFpN2Yxa2JnRHdE?=
 =?utf-8?B?Z1BwOVY3K1Q0UVNFWkMvTCswTFg2aTFhVWg5ejBvRDN2NFlYODNzOFpwak1Z?=
 =?utf-8?B?anJFYTVkTlJNMjRnbnVXNmQ1S2dwTWtWSDlyNVJ0NnpUYlUwRGd0RStqcFll?=
 =?utf-8?B?NWFwdGNPZlRHOWNCWmU0TE13OGFsK1AyUXdQSTNUUE56QjlwMFdLYm8xamsr?=
 =?utf-8?B?YmpFTHNHK1lERXBnTXZTUkxNbnlpeUlkYk9RbVRaeHl0ekVBNUQ1TUZKZ3hu?=
 =?utf-8?B?UU45bTBFd295ZVFnWS91dkxtSGtWVjRJSnp2NVg2RDlUdXIwMjZzdHNMeHVv?=
 =?utf-8?B?MzFZRjNqVlFaUUpFVndVR0ZhdnJiOThHenF6dHIzOVhWY2xMSVduK09Ubk5o?=
 =?utf-8?B?MHQrVTkzc250RHB2bDhyL0ZHOTFPZGlaK3dlT25HTTVtVVRUQlhoNTg0WTJJ?=
 =?utf-8?B?cXFlR1F2M21FTnJnT01vYlpLNm8yVmUra011aGlOazR4eSszeGh0M1ZyZFlO?=
 =?utf-8?B?c2F1b1JuaUFSUDdmbXdGM2xjWktNVGltWXlUU2NYenVtbzJWanJmNllKYlJU?=
 =?utf-8?B?NDRMeS9nVVlZenNleDdtc0FqTUtFNitFejd3a010eUNHTXU3SzFGS2RkSW5x?=
 =?utf-8?B?U1U3dkRPMTBvSXF5Z21tRUtzUTlUUHRoNjZUWkFwMTYyZUhxUHVzUDVqWm9i?=
 =?utf-8?Q?ksNJjQT1vnqOfVHEnPSJNjg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff3b2ca-975d-443f-2925-08d9a06d8b47
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 15:04:20.0121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+r+P100a8sjlbJzF4A7FLU/YntMxuV7S7GOJHB10WgfIRobfQ8/8nbFy8pFQxcs8R2ZmgRrlZPpcaA5qE6lIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
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


Am 2021-11-04 um 12:53 p.m. schrieb shaoyunl:
> When kfd need to be reset, sent command to HWS might cause hang and get unnecessary timeout.
> This change try not to touch HW in pre_reset and keep queues to be in the evicted state
> when the reset is done, so they are not put back on the runlist. These queues will be destroied
> on process termination.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e9601d4dfb77..0a60317509c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1430,7 +1430,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>  
>  	if (!dqm->sched_running)
>  		return 0;
> -	if (dqm->is_hws_hang)
> +	if (dqm->is_hws_hang || dqm->is_resetting)
>  		return -EIO;
>  	if (!dqm->active_runlist)
>  		return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f8a8fdb95832..f29b3932e3dc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1715,7 +1715,11 @@ int kfd_process_evict_queues(struct kfd_process *p)
>  
>  		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>  							    &pdd->qpd);
> -		if (r) {
> +		/* evict return -EIO if HWS is hang or asic is resetting, in this case
> +		 * we would like to set all the queues to be in evicted state to prevent
> +		 * them been add back since they actually not be saved right now.
> +		 */
> +		if (r && r != -EIO) {
>  			pr_err("Failed to evict process queues\n");
>  			goto fail;
>  		}
