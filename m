Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99B5C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 20:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648D210E33D;
	Wed, 26 Aug 2026 20:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yB4Ll6Nu";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D82610E33D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 20:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuWyFAjEWVKEOjzY/JY3Nv+28jdYBHKwuck6qtpNtRH+3RFS/FgrPF9n2A0T3TtN9uSmR6elVpbhbs5JwWKXdnM0fAjT/gfJne7+5n7ixcWGKdP1ESEevZNUD/+LeVmtfeAu2dX5nuHs+2jBhWCmdyEl9B8aSvOS7cDRSuT0Lq8ucBpPMyBPR4JpIDTGs/Jw3PB9d6vKi+CQM17xkyHdL8Kl2PWzpbn/K+i9Fon0OjohgkFnTf+hs5PKKB04V6XfPL1w9eFP0SaxGJX71uDppOi7NvpHZaLZPdq3KRocNM0mTNFIUyIufVcAf49wsdtQzxDl58Zn2pMMxmMtQD1rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp1+i1J9PKx6j87Xum2C+t4Fj2ONxsM2kMMGTDdmDnQ=;
 b=Ye3uY7NhfhAAawqnnxjGXykLLOgu1R1ZCXuG0LB5dAqwhli21zN8Mvv7oORRnZ0mxetGFPG20KUexfzMQkBq+/VCj/N7QtFnPz4PdFb9K8j0JeC2Bw8YPWXXwUcp/2kJmb93mY7M82Eh09VLtmM5cq8Yoj4oceQoBdXcBMIqd7Oyv/8nmrrRnJY2PpeNuez1vDAjfosy4t5TgvmwvTA6YKg2UUbIKNmhpomRtsXw5p62ANMuXGhe/Ar8kPLn7xfcDu2k4eWPlfN9t5lNEc8jtfhC7p/gbWWfiSWfHygiZI+Uo4Ec1Tv4nYsXKhONuOwBLoTjHbUTefBBP+ynF4r1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp1+i1J9PKx6j87Xum2C+t4Fj2ONxsM2kMMGTDdmDnQ=;
 b=yB4Ll6NuzjUk3pc19GPCVJK5XZAXBhrX4cNKo7rF1wmPzDEMdee1QYV+16hMTr03hM8e/vnjtjt9WiCLpp1pE2+DnWgp7IDGU5hoKUOdWuDtJQTu8ePwSOuDasfGmo6EEbh08HexU/tpd6fKAa0K2nnuCzZxuvEln3Ijs7nmX+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 20:30:00 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Wed, 26 Aug 2026
 20:30:00 +0000
Message-ID: <6e42f6b3-0e68-487c-8633-e5550d778715@amd.com>
Date: Wed, 26 Aug 2026 15:29:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: correct oversubscription timer inverval
 for gfx11
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Lin, Leo" <Leo.Lin@amd.com>
Cc: Tishko.Araz@amd.com
References: <20260826202748.316188-1-jinhuieric.huang@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260826202748.316188-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0060.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: b70ccfea-3eb7-45e6-a799-08df03b0cd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: riDGt+Q24nR9Is1ERkesBTWc1yUc8RyRCrjJ+xfEa7GwLXCiE4/ipVC2suK6FlLMgaZlwa4cdnvcsO+rzrGCreP8sM4FwcFYQzq1iVHW5iBbK7FVmgfRqU34AGyZ7xUaFkDCyO9hk+98+Ig8QbjR/I1qzQ0qvVvXwHjiBolQoh+0TVYoSXbDUJLTr6X8GouFYn2us1vzXno7+Vwl/gdJKIpX6/UxB4J2sFygPkHtc45KZkxxNnecXWWLcDAeIeASsM5iBtwDjRx1nK6b4dezqNtbR29frVUlDgOqLuguy3N7T61QtBFANMN192N5Zunfk5b3nzjG4SAoRRlm6KoQUgIVIZlYJW+VOgrg4hv0HApCKVayVKgZAV/04iZMRNUala2Oj/0yq7TQ5VKs0jC1stN4B82hWa3Y02Bg2r0QtdBpRgFylfS6P3JOfUCw0sGNF3jMMNg16rrtPZCgvosDhbasBFn4mGZpGMC25PptyELa048GDR0Uw/yjoSgMhKHKpGBtZ7WqbIkdugvtDIPHTALRKqsSogC+adfIlz9HHlv9EnqH7QHOygd5uNNy93PKqkafIOapgZ5T+OVL5Nm46Qi1dYQYQP+Zh81clOo0APCUVynwf/opWwmrc/9KDOM4xhKTUHO/P/LhEbPYcHvIWX6I7zawuPcJSzfV0x5sSN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9iaVN5YmVxSk16V2laakpPdCtVbkUvSHVHYURmdTRVa3NBTitHdFd0ZmhL?=
 =?utf-8?B?VUlsUEJ5QXo2TW5zR3VmaCtzREZtRnFkbTlCWjJjbmVoUnpoNmZaQmRmWHZD?=
 =?utf-8?B?RDBrL2NmNGhrdWdadzUrejM3OEdKbitKS1RXdjZ2MUo5c0RldUlrOTlreE4r?=
 =?utf-8?B?YXJXTHIxdlg1T0o5OGtWdktlVXpMQ0V4blJEdGZnRUJXOXJ6MEdHOFM3MlNT?=
 =?utf-8?B?WmMyOWsxK3hObWs2TysvT3pKUlc2UElIOG9IbmtWMEZPRDQybGpOZnB1STNu?=
 =?utf-8?B?WTlEc2NEVmJSTG8ybDNTWVZJMnBaZkxRVytDaFBYSnV2eWZUelhlNzFMOHQw?=
 =?utf-8?B?dDZ3NWU1MURsN1BzczF3ekZvdHRuSHJGdkFBdUU1OTdRWHpyVEtMWDJ6R0lN?=
 =?utf-8?B?UEtiUzlZTzkva0cyQWJvY1Nqb2liSU5jQjIvREZFU1F0SWN6NTROZU9NNlJR?=
 =?utf-8?B?V29XTVdTc1lBUlZ1eGlNdUkyZG50d0YvelVvQzZLRmxIeFhKcTAwQmRWcGpH?=
 =?utf-8?B?Vldtb3JXeHpHL3JvTDVXVXNhckpJVnhKZmdPc1J3L2creFRWRmpQYVdrUXgx?=
 =?utf-8?B?MTJpRkhHQUVNekRVU0gwRVlaMVdZUGlCTGVOcGNOMmZPZC9LVEFhdFlyNkdG?=
 =?utf-8?B?QkluRkMyNHI4dFZzbkRSd1NCMlE5d1RvUmNWSlM1RmhKMllyVjNyK2tCbHho?=
 =?utf-8?B?NHZUeHJSa1RjU0xqMktkMjhhVmlCRnM1allwbDNiL2MzRW1HcmVyT2tVQjNh?=
 =?utf-8?B?cnFQekZLVmI1MEhFVXpuNElISGh0UWVBdVNPdGFPM3pNNUFGS3hjWGdDTFNx?=
 =?utf-8?B?SExLalppdElZZ2JFOU5MME5STGlBQ25ZdS9veFZBczd0a0QxTG1OTjd4OUVD?=
 =?utf-8?B?MmdmRVpPQVNGa3JGYjFnOTBrOUQ1ZDNqS3FXbGdvRnRadGVPdWFPdC94WUVv?=
 =?utf-8?B?WkpCUUVaTkNlbWlRYk9uajlPclhldEVhS1NSS2R6c2lWVXJpeHhjOUczYWJO?=
 =?utf-8?B?NkNxblczcldHMFE3TnNtVUhYL3g0OE9MSUUxRXdKUEpWalRzZlBGNGI3L3V5?=
 =?utf-8?B?cnFYSGIxZzVhRHdLV05hMGcvb3QxTTQxbmYxTWtNQUNGb3Jab1Y2Z3pGZkFQ?=
 =?utf-8?B?V0RvRzJUei9PM3dldUp6R08zOHdLWTUvd0Z6QTA4T3V3OUY2ZFZoODJ3SHZz?=
 =?utf-8?B?RVRmSkNSOHB6UkFONTkveW5UaCtqQ1lvTks0cmx4WjRaZUZWdDN1TzNzNExy?=
 =?utf-8?B?Lyt6L2UwSW1XSzl1dXVCUEtIaDh5eDVoNlNMbUlGclAyRTdPclFaeVJhRWNp?=
 =?utf-8?B?d3ZSZ3dpb2cxTktOWHZRaVNocVRsNTZxQm5xNnNjOWYwVWtuRi82eGx5amlo?=
 =?utf-8?B?bjF1dnpWN2d2cU9JS051Sm9HZURCTkdWUEdBUWpKRFJrVmViZE9tbThxLzRl?=
 =?utf-8?B?UWtITE41R2dvVHliN1VMZzVqeUxpb3NCeGJOdGNkTDRzSGFZaVkxMWQxbkdo?=
 =?utf-8?B?cWNNbWJPLzV5aHlQWG1lZTV2MmVUQWlaN3MvMlVYNXNWdGlkRUJwVm94T1l3?=
 =?utf-8?B?UHdVRUtHMVYrdHpPVms4NUgxaWxlRGJ2MW9GMUxvMEJOaEU5eVJzSk94YnpD?=
 =?utf-8?B?N3BvWDkyWlZoT2pLcHh5WFlXWFkvVm9OamwrNkNRVDFMUEc1dHhTckdjblpR?=
 =?utf-8?B?OXBWK1Z3dkF1VHVYZ3VkQzdqMGFPWHRwOFBoaGlXeDhSRm92cThWbWhJaWNZ?=
 =?utf-8?B?S25WbzE0Q1dNcEtLelcrK0FlMmQzRHNlY2pRY00zRDgyYjZaM29kN0lxUVlV?=
 =?utf-8?B?V01TdmFEYUU3b2k4OXZLMW5jZlhRbnlZNEROSlpYRDlFd3FlbWNxcUlhVDMx?=
 =?utf-8?B?dzlxd3RnT09EVnIvZmszcEdwODZFZXo0Zy9VSUt2OHE2TjFxcnQ2azJUeG52?=
 =?utf-8?B?bm9aT2IwUXc2MjVJVlhKakZCTWdVcEhLK2JWejQwakhHYmRwU1dVNnNDV1R0?=
 =?utf-8?B?SFRPTTBWVStmQ0FSK2k5TGZ2L0s3dVMvdkZPYmdiOUVWd05VT3BPUHlFWWFG?=
 =?utf-8?B?eHBXSnZEN3BFa3V1M0lFc2RiUVpWc2dDc0puUVRHaW5mMThCbm14NEFjVzZI?=
 =?utf-8?B?eWZ3NTZ1QWJvcW8xN3JLZ3FPV0d2SUgyUlBScnJnU1FiK0tlUXFLL0dpSDg1?=
 =?utf-8?B?bFhnSzJJUTdCWU1rbE02UEVFTXZQcTNKUTNtQXhoelczUEUwa1NZd3gwTmRr?=
 =?utf-8?B?T0FrK0lXQ3VEZ0d3TzFEOGNsbGlpTHRUYVM0NndONU5TYkFlQTVwODJ3M1lF?=
 =?utf-8?B?ck94K3MzSjdFWUdPc2ZqVmNMYjNPTWFqVTJFa1VjU05uZnkrSnlxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70ccfea-3eb7-45e6-a799-08df03b0cd5b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 20:30:00.5925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKK/p29ccGpBED/nkjusUUuH5RvPGNCd0PyWDaiFjnZTTEnm+TqBp+5g9ttwea6lZzazNaktBfL76WLlMEFQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

On 8/26/26 15:27, Eric Huang wrote:
> oversubscription_timer in MES is in micro second, so change the
> timer's interval in KFD/useq to micro second.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Suggeted-by: Leo Lin <Leo.Lin@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index e0e38d6bcafc..5cf1bb1c2085 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1171,7 +1171,7 @@ int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
>   }
>   
>   /* Interval for notifying MES of work on unmapped queues during oversubscription */
> -#define AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS 50
> +#define AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_US 50
>   
>   static unsigned int amdgpu_mes_userq_hw_queue_num(struct amdgpu_device *adev)
>   {
> @@ -1198,7 +1198,7 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>   	if (atomic_read(&mes->userq_hw_queue_count) >
>   	    amdgpu_mes_userq_hw_queue_num(adev))
>   		queue_delayed_work(system_wq, &mes->userq_notify_unmap_work,
> -				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
> +				   usecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_US));
>   }
>   
>   /*
> @@ -1215,7 +1215,7 @@ void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
>   	if (atomic_inc_return(&adev->mes.userq_hw_queue_count) >
>   	    amdgpu_mes_userq_hw_queue_num(adev))
>   		queue_delayed_work(system_wq, &adev->mes.userq_notify_unmap_work,
> -				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
> +				   usecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_US));
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 69cd4441e240..b37aed34a72c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -48,7 +48,7 @@
>   #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>   
>   /* Interval for notifying MES of work on unmapped queues during oversubscription */
> -#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
> +#define DQM_MES_UNMAP_NOTIFY_DELAY_US 50
>   
>   static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>   				  u32 pasid, unsigned int vmid);
> @@ -287,7 +287,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
>   	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
>   		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> -				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
> +				   usecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_US));
>   
>   	return r;
>   }
> @@ -3275,7 +3275,7 @@ static void mes_notify_unmap_work_handler(struct work_struct *work)
>   	/* Re-arm if still oversubscribed */
>   	if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm))
>   		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> -				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
> +				   usecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_US));
>   }
>   
>   struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)

