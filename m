Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4B7EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 14:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D755B10E4B7;
	Wed, 19 Jul 2023 14:19:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9207E10E4B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 14:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUk01l6+V5UviSnv6PwV70g03snTZxkDKwPEQ4KA4w/BmKgza/+lmUagA9zfPVcupHKJhZyDVBpiN9rGiqhwjYa52JIMxIYU0MIio/STfsyFS5raJRK2bfTdO/SadpgGHHUQvknki1ek5N5d/xdWftI+zW26pSInTYb8e+4DCl2aYK0qSeyLI4SD4GuoQxRwlIJOshKg5kGonalu+XV9789wduNhAgLYKOfke/K5Xgj0O4ASnO/8jDxVaVN6j1TX06Y1eLxs0p2GtUkY6+EN6Db0YGOj0YNEEkdPgGW9qr5mWQjrGYsb2pzCaVhJHb1nUDmu36BvZm567DLfjuPDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXmgHa9eqKvV3tvKinR6zA6VA5J7Bk46xBmmZdZaiCU=;
 b=daNqSKYAoFEgFaQT9QNS9agIonCpyNwYs490qtDuY145GfafmLMowMDkXZn8jGWV7/7uBshLxwTECCfxVg71hXSHids/2EM69N7iatZEw9HJkpNpMD8Lt3OhNXOM9fsO8oepJruZJ5PrcodvnDrF1tnkfxeCtdwIyvCZQFV2txmx072uk4Oki85HHmoQPc8drjMu7WnwN2XXmyUgrRnxJpo8oOTn7W02Uwd6sWLhvzf/0eSrNILh2V5vAqelbkvJlHiZBB4IHPPjdwjzf9vhZ/kONRsAeAtRsMQFw0WJIeeiZQTA7xw/RfQQdb4BZTRZXMkCVAvYJrEO9nHFSlVqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXmgHa9eqKvV3tvKinR6zA6VA5J7Bk46xBmmZdZaiCU=;
 b=u8GGudMvej+Rn0bW6enqJUNco/6GsGx2MYKkApNIerT1FOprinBthChvr4GAYdb4I1ephYGI9fHybKx+sJOtyVfm83Y9hRySDCzzaGu+Cz1DVcJVZ5ZQtZyB+DQeIuE1OYMSif/0aTROVqaoXWGYFhrIyquDXKJsmw9UzMB9fgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 14:19:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:19:16 +0000
Message-ID: <e918f97c-e11f-3b7e-41c0-27cb9c1d479a@amd.com>
Date: Wed, 19 Jul 2023 10:19:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] drm/amdkfd: fix trap handling work around for
 debugging
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230714093759.3246343-1-jonathan.kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230714093759.3246343-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: b4db877a-1a10-48f2-84ce-08db88632220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uxsFArX78UnPdytwsoU2TGbccVOzDZ/E5HrjJQ+CyDRIYUj3UyQFF75n2p6wwoE7wp0BJWAN5K2wy84pdEVB0B30SRpDXhabDtGnCHimMLA4xrufdhKV3Xgl1LHUGWCf5WZ6RgoSjyrd4RaBF+8gBDc8605qiPzihMx6kREf6uhmY7AmevVyP+IScbBsT9YvKdjFix99fxULvtXahJZzjhW5y92oFVJsn80XojWKK7EPn+XnnMN1GiB9p87FRovg72hn2hgMy95qUiJUtboCn5uHuKJUDHvx3HQl5Ko4NPq+W37j4sLgpwotH0bYqWUn0NQPyEM629jDA94h3CkQvjohjfK3tktSiVhTg3zq6TVmyVtiK2ZSo1Z8uy6WnwBWs04ALTIwVqU+xlVR2zYNBwIJI6CVuZL3ozKBUdPtzRIvq9lD4PLRIlTGyXeE1sYtPY/vEDrTt1lla7z5teeyk/JKjtCFjeHaoetYUY+bc+yVjjVk/k6O73S2GYhZgY/YrazpPS5UPninhVUqB4ot4EG5jaPiiZW1HQttmKWC//hiTilhqO4seauzcWZM0nOYO6E1aDGfXQqXi5m1czUAvcRNOauDZrdRQ+WIMqOv5dP9NPwjKmMKiSTpz+/nyN4tS3Z6OyDd6MswNwX1NQGJ1YLpLoGE0b8aKT7cO4DALydiIMSTZvjaHpOWaMrWXGA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(6512007)(6486002)(6666004)(478600001)(26005)(186003)(6506007)(2906002)(66946007)(2616005)(66476007)(66556008)(8936002)(316002)(44832011)(41300700001)(5660300002)(8676002)(38100700002)(83380400001)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmh6eEJqbkE2cHdoMkpGOXlqWDFNUlhkK0hYUC9tQTRiSW5UUkRGc0NCYnpR?=
 =?utf-8?B?T1lVUHJ3bzFqKzFhcGJUWE5lQVV1Ykcvbno1cThnSU9hZkZmVnRvMDV4T0Nz?=
 =?utf-8?B?UDh5SzlJQmpLdDd4dDN4TmpTWGpwNUdKNUNIUXJRZjJrYXBERFo0SnBhNytX?=
 =?utf-8?B?ZlRHU3dFQXUzZU1wVzQ5UWFqWFpCdk5ZRDRWUjFadHVVS3FKb2dYRHM3a09r?=
 =?utf-8?B?VHhuMDhDZlZFWG55MmJMc204RFg4alBYL1pmaWJ2Qjg3L1pvL0M1VGFheFNO?=
 =?utf-8?B?NkY5a2lja1RwN2FOOE1MbHhtWkUzTmw0Y2dtOGY0b2krVHpYUGcyN1VyUTdZ?=
 =?utf-8?B?dFVXelBHeUpDSHlkejF3bnl1M011cXVsYVRCR29RaTZPSUg5SGtCVnE3UDdx?=
 =?utf-8?B?a2lkcWtMbSs0S09ZVDhWbjdDSVMvdklJdG55Q2JPR1JFZ28xM0VCRTVpYmVr?=
 =?utf-8?B?d0JsM0F0SGw4QnJFRzBGSWpQNVI3Q0lFMWJmUllla3ZnVVFwblVsWEZYVGUy?=
 =?utf-8?B?a1o4WDUxN0hrN0FwWC9nNlNSdkxtZFdDOTFQWVdzQ1VvTEhxM2M2UlRtL2lI?=
 =?utf-8?B?WXJ1cHkwSHRROTBuMjJvTXJhYWZvZnVxVTJFbk1zTEE5aE5ocW1ibG42TUI2?=
 =?utf-8?B?OFJQWDR6NENoNVlFaDFDdk5sWmw1WkxXeUVhSmhPWnkyaWgrZkZ3emVheWRQ?=
 =?utf-8?B?UFNFOVhRZXlkRjBncllGQnZWVUN2ZzZJcEVrS0pxNURlRHhxWVVUcTJUYnVR?=
 =?utf-8?B?eHVjTkJRa3ZoSHV6K1JML1M4WnU4YWNrNWdDMmNXdE9YSDM4WjVnZkx1Yklk?=
 =?utf-8?B?VXNPMjRLZmkxWGJudkQzTVFSdFNQM29ibFJTdlY3Y3JBRTUvbXVyUEd6bWZR?=
 =?utf-8?B?bk9YRENQNUYzcmxlaDJ5OUhzaE1YNWIxRERIenc5SFJCT3BHdy9qV0Z3SDZW?=
 =?utf-8?B?d1V0T2piUmwvd3NkUnMrWFErMTg1MnRZNmJTUmtCQjNtZklZWmtQMXFUVFYy?=
 =?utf-8?B?K1FtcEJiWnVLMmpXNlo0ZnFTTWk2VlVZQVhrV3JDcHZ1bWo2M0FPY00xQWN5?=
 =?utf-8?B?RE9aRk8zMlFFTnp5N1IrSzFzN1FVWk92dWt1UHhRdUJHem5JUmt1eEVid0c5?=
 =?utf-8?B?V3lvcDZmZy9CRWVraTMyT1N6OGF5ZERWMi9FM2t0alFjV3lPakxRaG9lY2VO?=
 =?utf-8?B?c0tueW9WWGYwWG9JSXFnZXBJS21pK1lqWWNEc09IKzN4UE45cGF6MC84S2dj?=
 =?utf-8?B?R213Tk5BSTZJb0cwU0haTmMvbDBBaVBYNk5VbnVCVDBMYTZuY0NFWjlpUGZo?=
 =?utf-8?B?SDVVRW1NY3c4S1V6ZEMxYVNDNkhaSW5PWFFWWEUwdjNTTFhBL3BoUUpBVzh4?=
 =?utf-8?B?bVZQK05ZWXloelVZQ2xwbmlMWDR5SkJtQU05VXBBSEtUeVJac0E4WG5ac3dk?=
 =?utf-8?B?U0JXOE1UMHQxRTJZWTVISVFTL2xxUFErbnhxNzZZTkQ5L0lHUGdqVXNDRVN3?=
 =?utf-8?B?cDN4b0Fxa1hNeEF6N2dQV3d4Qjd2NkFOZTFTVWM4QStPbUR3TmFXaFZ4OXlU?=
 =?utf-8?B?dkg5bFJYdVRVUjJZRUFrekluNnhBRmphNHZvNHBMcnQrRmI5MC8zRjkrem5B?=
 =?utf-8?B?OVh2cWFRMDlHWnBoTUg0SWpCR3VoSG1TVGJEeEFWdTVLZFZWVU9JUDZFZ0xG?=
 =?utf-8?B?V1hnbWNjYWgzQkhZYnJ5dUZZcVhXRzM3WFhrMmhwMVBtZzJjR0xxc05JeC9X?=
 =?utf-8?B?ZWtWektZWnRHYURaazEzcEdScVJZSVVDejdlZ3A0aTdCOXZ6dVZGTGNZUXVO?=
 =?utf-8?B?eUt1Qkhtd1ZEblZkdGVqM3N4QXNob1A0VTUyZGhwRVpzZm9HelVkenhYV2dN?=
 =?utf-8?B?UEhqcThMYWhzakhhSW81ZGVEZHEwNUlGSklaVDFBMWZnd2J6ZDdYLzV4bFo3?=
 =?utf-8?B?N0FTZjAxMTdkenhZQ1pRVyttZWloNWoybkhiOWtNQ29nZTNBbE1DVW92cHJG?=
 =?utf-8?B?VFdDMXdEaHpFdWhOU0krb3ZLdDZSRXQvZFlHVWdCZHFDb2dCSm4vMnBsQkw0?=
 =?utf-8?B?L21UbjgvZ1R4eXY4NFZPYXZWTmkxNmJuYmVnY09EMUMwNlFZa2dCY3FlUUlR?=
 =?utf-8?Q?93oLT/IF7O8B1iOG73j4hmUyn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4db877a-1a10-48f2-84ce-08db88632220
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:19:15.9895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34heDzHDp6OpRS2EfYQQIgKXAE/Kld1tph/H3A9ORgvs7UIJYusmtSHQxOc0uhyrsUMXXp0wALJIrdyRSDt6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
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

Am 2023-07-14 um 05:37 schrieb Jonathan Kim:
> Update the list of devices that require the cwsr trap handling
> workaround for debugging use cases.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c                | 5 ++---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h                | 6 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++----
>   3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 190b03efe5ff..ccfc81f085ce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -302,8 +302,7 @@ static int kfd_dbg_set_queue_workaround(struct queue *q, bool enable)
>   	if (!q)
>   		return 0;
>   
> -	if (KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
> -	    KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0))
> +	if (!kfd_dbg_has_cwsr_workaround(q->device))
>   		return 0;
>   
>   	if (enable && q->properties.is_user_cu_masked)
> @@ -349,7 +348,7 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
>   {
>   	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
>   	uint32_t flags = pdd->process->dbg_flags;
> -	bool sq_trap_en = !!spi_dbg_cntl;
> +	bool sq_trap_en = !!spi_dbg_cntl || !kfd_dbg_has_cwsr_workaround(pdd->dev);
>   
>   	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index ba616ed17dee..586d7f886712 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -101,6 +101,12 @@ static inline bool kfd_dbg_is_rlc_restore_supported(struct kfd_node *dev)
>   		 KFD_GC_VERSION(dev) == IP_VERSION(10, 1, 1));
>   }
>   
> +static inline bool kfd_dbg_has_cwsr_workaround(struct kfd_node *dev)
> +{
> +	return KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
> +	       KFD_GC_VERSION(dev) <= IP_VERSION(11, 0, 3);
> +}
> +
>   static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)
>   {
>   	if ((KFD_GC_VERSION(dev) == IP_VERSION(9, 0, 1)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 31cac1fd0d58..761963ad6154 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -226,8 +226,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.paging = false;
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
> -	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
> -			      KFD_GC_VERSION(q->device) > IP_VERSION(11, 0, 3);
> +	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
>   	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
> @@ -1827,8 +1826,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	 */
>   	q->properties.is_evicted = !!qpd->evicted;
>   	q->properties.is_dbg_wa = qpd->pqm->process->debug_trap_enabled &&
> -			KFD_GC_VERSION(q->device) >= IP_VERSION(11, 0, 0) &&
> -			KFD_GC_VERSION(q->device) <= IP_VERSION(11, 0, 3);
> +				  kfd_dbg_has_cwsr_workaround(q->device);
>   
>   	if (qd)
>   		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
