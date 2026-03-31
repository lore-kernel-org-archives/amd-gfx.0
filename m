Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DB2109B474
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEDF10E383;
	Tue, 31 Mar 2026 14:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4lB6tie";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D9B10E383
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzHRBSGfsZ7tGSHSX8tYZUrWPX1DypNRwA28lyOut5EQYYcxABNaD7wr+n8oKb9PzeZ3Wdj7M9PmyL6HT7zZcYRLPpnpRcVCXnexI1odVO4Ga9tTpImhLyzMh5xIU1YhRwpF6Kyn+DyE7itD5yT4wWNJx253xJ4fA6JQEQSO4K8hpK/nwbdA0AqQhhdRPv+TU+ngwRheaFxAZeACnftCfbe+05Qrc74A2gZgYUyR4tK4XWTwk8tX0e3doTNbEBA1G2v0lotPybIcP4FU+e6Q3FkunecYcZeW/oWrkw3E1QShzKYa2yBiqOtZ/Oeq4FR3WZSVAKczXZ9QLwunz8bmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTdcL6uWoaeWblRlMNwsoNlA1KpFpobKLhScQwz9oNA=;
 b=nToxUdx1khWGg6Z2WqmYzG6aYuSyAIKd5dzNY5Vu7gI9Mr4X82+WYQKh3wYt4AUo9wlXnePXJYd96Ij8f6sevO9VPxwoQI3Ms0slJXG2Ho3sDGVrw7XTvi9sYAUd5tFKc5ZqFFIbzJLHsHg31aOWWkiYzHkJwHNVHG/jBtCO4yzeyrwvzSMhSSgzmPoJX3mpHvJjsTn+YAHYHIYMGEbGlBUiQ11WZaKGt6qroIub8kOhN35BD5AXeLnc/TQki/DMtPQhzoXRbcloe78NQGJovTZwu607YOpLLpafkm4fQg2P90xQppqF+nwYZiA3Cw20DGgJJCf+MnFCPof5aw0GIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTdcL6uWoaeWblRlMNwsoNlA1KpFpobKLhScQwz9oNA=;
 b=V4lB6tieOcvuHxJQc7+xxOYqs+6whdzZ7DtnaAbX3tJUNCiRm1hPx4j3gt1BU+MiWSu2eDlpTXlQNr31KYyeRympbUCttTWJ2Vmfz6fhNBGX1CFoCC2JKUKyf5dK3VTqqo8BxnW2ZrO9xAl7dIgxXM2p7QsatQ2mmUkhnZ2dZ38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 14:27:41 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.016; Tue, 31 Mar 2026
 14:27:41 +0000
Message-ID: <9d95d727-3e5b-4084-9bdb-c7b213849d97@amd.com>
Date: Tue, 31 Mar 2026 10:27:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] drm/amdkfd: Reset queue/pipe in MES
To: amd-gfx@lists.freedesktop.org, alexdeucher@gmail.com
Cc: Jonathan Kim <jonathan.kim@amd.com>
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
 <20260327203152.1578828-2-Amber.Lin@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20260327203152.1578828-2-Amber.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::13) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: f65cfacf-953d-4e64-9a39-08de8f31aa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: cYMEEX6rkLit5TQ7gxb2xklUiNS9jSVYdnrsZJd0GEx68lHQzrmARjY+OPaVLsO0UdPZT5j4eu+XUOvzgk9gZJEXkOJ6hyjmAb0GsDwvAPuSxTIVkv1cxkGYh+jPRplTHYFCVMa3b4XLOLFCucOLdSlWZgCjeJkNygUagjqdwONBtm+lM+DCpHbR/Y3LHuVkB0Z1NeNYMrfv8newY7NeIRSRqiqc3OGUrdaeJYKlcaFayiQRA3rsAUhhcl/ep+d4UMjsbIgfv8RoQllgJaZw/GhlzHhuWoiphSpOMPIb+FwfTvyP0tUfITXveu8OZHP2oHWMIwPuwzUKine+pHkf1uxYl6K0UCssDWX81o0kKI/TgFVug/hlzEfCNqyxLgeg9/+PZehEgqzjkq6XOpiX4dQ26vlddtdhPD0LMmD9fa9JzWFij+aHTk0KVLx0MskLJnBPRt6iyzXghuDgJTPCRfbpkh7wzP08hQDY25QkF8CdYV2Ve53qz0isrZpIwhrEWjIatm27+Z80rExtmlpfkOfpkH4k/j8xROcKVx0oqRqiJ5IzhLwacz3sJhG8Bio4VyhubDBIHXIutUwLawWoH17zr/tnJGfluwX3MauWt72wu85vuhJ68cT84tXkZmV+uzwbOLE5abRVp4hftJ0/SnyAjZtIoH1l7dJtIJXJ7vaGzzVN7wnn7dPRLw8MmNBJn795k2uCNZml49x3eDil4BzRXd1KRSmpkcSqc3Pj0AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVDbUN2c2VZdHpGd2h5TkF6aHRVNFFUY1VCQ29GVW1pOE96WTFleHN2WjNE?=
 =?utf-8?B?WjhVSGg1VUxnMU9zMVU3Z3NZTFBSeDBBYXZ6dlE3WUpBWDZGVjRiVFZmWHNj?=
 =?utf-8?B?SHNOZkt1MVptU0EwMTlwMmFCSTRscWIzdjFCallBb0I1OW1QQ2FPMW00RWZp?=
 =?utf-8?B?ZGVIbVJ3Q3AzL1NWQkRYQXpWM0ZNdzhYa2EvWEhQWEg4dlJpeFZPZDBjREZG?=
 =?utf-8?B?KzFlSGlLdDNINlZTMjB5MUhmRGpqM3M4Vm1Vdmd3U1V3emVpZURGWUNTdmZE?=
 =?utf-8?B?ZUFSN0piLytlTmNmVFZESk04SEdMOVIxQ3A1QWRzQUcvbHpXNlFQQW5PWkxB?=
 =?utf-8?B?eXlSWFdWWG00OXkzV2FjSFV0Q2dCNUxUY2NRaWNrR3cxQ1BQZ3c1ZDZ1TFo1?=
 =?utf-8?B?NFVEMFgzWkNmQ1V3Y3o0V1dtbHhjb1pQbG5meS9mV2kzN1RkdU1JSFc0MnBz?=
 =?utf-8?B?WmpRemJsNGxJQWtLaldlaTVVQXR4STAwajkvamw5Q21tbnR3M1BnSklaVnBJ?=
 =?utf-8?B?MnZOY2g2aG1MMlRIdFZGMERNOHVHVGIzQXdQYVhFSTFXRTNHbnAzNzgrbFVz?=
 =?utf-8?B?aDRwT3UxMXRXTVV3YkgwejF5Mk4ycFBwWjFjUklpbC9saHlsd2xMYk55dWxo?=
 =?utf-8?B?TThGUlZEK01RditGWU54d2tsbm9KSE1aR1F4UERhUms1TjFnK2lTS2FraEdS?=
 =?utf-8?B?eFhzZTFoTXhKbXBETGY3bU1hV2NhWXBYbGMyRFcrKzZVWjU2Y3BrYjdrQlgz?=
 =?utf-8?B?S1J5U2J1dTY3RUoyTXBHTXpib25Fc0ViUjNnc1RmVUtPdXk0cTk0Q3JSUStE?=
 =?utf-8?B?T1VFWXExQkdOS1lQTEk3QUUxeU93QnVJalVhV3F0SDhrTW9kcDJ4YXZnRDJo?=
 =?utf-8?B?cGNhVyttN0pUK2N1LzQ2Tm5Ba2w3WDR3elFhSlp4V2k2U2hjMHRpSC9STGlX?=
 =?utf-8?B?SzVreTZ1dDIvTjV5UUNRemc2M0F4d2c4aTl5dmJEZjZDZTQyYzdnYllFZHMz?=
 =?utf-8?B?dm9kNVJOdVN4OW5nNmw2anFDK2dmWmJtdTduVTMzZTlNVjB6SzRVN1NnU1lG?=
 =?utf-8?B?S3RJcS9NTENWZDR3SEQ1YkxpZnZNQ1JJandFRk5XdzQvOGo5U01LamR5cGI5?=
 =?utf-8?B?OFVUNWoveUcvYks0WHdqSjMxMnRwemxUZFFFdXRvdWtvdTNmcEtaMC9iN2wy?=
 =?utf-8?B?VGV6OFQwOUg3bWRWbHIxa0FqeUJDU2o2TXdRV1lqcFphaEZmVkZHWDBDWCtO?=
 =?utf-8?B?OTFLN3ZScG1JYWUyTkFHWmUvdXZEYmhPbzBKWVp2T3NEYm1pME50WGs1QlJD?=
 =?utf-8?B?UU5QTlhaZGVWUUJpQldTUHBRQWY0a3cvTWlsRGNwUlk1bW1EWW9xemVGUHht?=
 =?utf-8?B?RUtxSEhBWFRRd2ZrZjNNNkdzL292UHNncnlocjhXaENYRFQrMHNHdVM5OGYw?=
 =?utf-8?B?bnRCbEdBbmFQc3owYVBhSSt0bklaL2c1d0ZmczA0a0ZvUHRYQzVvOXpoZmlP?=
 =?utf-8?B?M2ZqTUR2Umw3WGRQU3UvNndNTDJEaHgrY21mUWt0WldLclI5OWR5TjlyVDc5?=
 =?utf-8?B?ZmZTMThKRklHREFEL3ZnNnlWZDE5eVh3YzdVYlc3Zkd6MjBJbDJuTkFlWjZP?=
 =?utf-8?B?VzFXVWN3T2lnQVBzRlhTbE1QdEFkemNXWFJwUDRJSE1DZG9tVldjWjlocG1n?=
 =?utf-8?B?MkRia1ZNaXorVGlXdEpDajlRUm9ETXV3aFBzbi90RWJpU1lLcFRTWlZ1VEJa?=
 =?utf-8?B?UTRINGxpWHpJWVpPSk1MejYyTzIzVUpNcmFBMlNkVllIb05KM3pha3NKelMr?=
 =?utf-8?B?VVdnbTRiUE5mS1B2dlhxSjRXNDQ4M3QrWW9JSlBobWNCcmVnSFdNSlcyTHY0?=
 =?utf-8?B?U3lNbXVXaEJ1S0x2MGpFblR3emRjRk43Rk5pTDhxRkNvdHZ6OHBRSHZhTVZY?=
 =?utf-8?B?bElYc25Yc2p5NTFPR0tUMm9MYVJGbmlsWE1qTUFUT0R5NVh0Q0o1d1Z5Vnpz?=
 =?utf-8?B?MUQxODg3T0pWTDhDM2dSU1h2V29Qd0dsSlAva2JGdHBzNjJFNlBtQXhFZXd3?=
 =?utf-8?B?OE1JQXZHSzl4VzRQRUJZUkJ3Q2dISkhqUk95R2V6ZzI2MFdSN3ZBSURzTGNr?=
 =?utf-8?B?NkovbkR3Y2VNK0xPKzBKRDIzMEtHbTAvSnQ0YVBDQ2tVVFA2djBCMm5rUm1G?=
 =?utf-8?B?WjFOZkcrMmdEVm4wa0xla01VSDZLVU1KbDVnVUhTZTBEMFZnbzVhbU5rVXRZ?=
 =?utf-8?B?YTNOLzlPVFlmSGtaTytmVUVLdE9kem5PazhwcVplRlM4cEZ3RG1xNFhWTHM4?=
 =?utf-8?Q?hRWrnSohMlnIO6twMe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65cfacf-953d-4e64-9a39-08de8f31aa93
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:27:41.3058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mYDFJEEj+2U65j7bUfCX9sgupv1NVr3ZVZQZtDpUF3xSQe5eQTQvTUvvjOckAAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
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

ping.

Please let me know if re-sending the whole series is preferred instead 
of only sending review pending patches. Thanks.

Regards,
Amber


On 3/27/26 16:31, Amber Lin wrote:
> When removing queues fails, KFD calls amdgpu_mes to detect and reset
> hung queues, then cleans up those hung queues in KFD.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>   5 files changed, 156 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index fb7fdf5d0973..75720d247b4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>   		amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0));
>   }
>   
> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
> +{
> +	return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
> +		(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73);
> +}
> +
>   /* Fix me -- node_id is used to identify the correct MES instances in the future */
>   static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>   					    uint32_t node_id, bool enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 643b4f8d757a..44fa4d73bce8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
>   }
>   
>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev);
>   
>   int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ec8d7f4be840..2670741f3e53 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   				struct queue *q, const uint32_t *restore_sdma_id);
>   
>   static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
> +static int resume_all_queues_mes(struct device_queue_manager *dqm);
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm);
> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
> +						   uint32_t doorbell_offset);
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
> +			       struct qcm_process_device *qpd);
>   
>   static inline
>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
> @@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	return r;
>   }
>   
> -static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
> -			struct qcm_process_device *qpd)
> +static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
> +					    struct qcm_process_device *qpd,
> +					    bool is_for_reset,
> +					    bool flush_mes_queue)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>   	int r;
>   	struct mes_remove_queue_input queue_input;
>   
> +	/* queue was already removed during reset */
> +	if (q->properties.is_reset)
> +		return 0;
> +
>   	if (!dqm->sched_running || dqm->sched_halt)
>   		return 0;
>   	if (!down_read_trylock(&adev->reset_domain->sem))
> @@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>   	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
> +	queue_input.remove_queue_after_reset = flush_mes_queue;
>   	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>   
>   	amdgpu_mes_lock(&adev->mes);
> @@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	amdgpu_mes_unlock(&adev->mes);
>   	up_read(&adev->reset_domain->sem);
>   
> +	if (is_for_reset)
> +		return r;
> +
>   	if (r) {
> +		if (!suspend_all_queues_mes(dqm))
> +			return resume_all_queues_mes(dqm);
> +
>   		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
>   			q->properties.doorbell_off);
>   		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
> @@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	return r;
>   }
>   
> +static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
> +			    struct qcm_process_device *qpd)
> +{
> +	return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
> +}
> +
>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct device_process_node *cur;
> @@ -359,6 +384,92 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static int reset_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
> +	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
> +	uint32_t *hung_array = dqm->hung_db_array;
> +	struct amdgpu_mes_hung_queue_hqd_info *hqd_info = dqm->hqd_info;
> +	struct kfd_process_device *pdd;
> +	struct queue *q;
> +
> +	if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
> +		r = -ENOTRECOVERABLE;
> +		goto fail;
> +	}
> +
> +	/* reset should be used only in dqm locked queue reset */
> +	if (WARN_ON(dqm->detect_hang_count > 0))
> +		return 0;
> +
> +	if (!amdgpu_gpu_recovery) {
> +		r = -ENOTRECOVERABLE;
> +		goto fail;
> +	}
> +
> +	if (!hung_array || !hqd_info) {
> +		r = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info));
> +
> +	/*
> +	 * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
> +	 * post suspend_all as reset & detect will return all hung queue types.
> +	 *
> +	 * Passed parameter is for targeting queues not scheduled by MES add_queue.
> +	 */
> +	r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
> +		false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
> +
> +	if (!num_hung || r) {
> +		r = -ENOTRECOVERABLE;
> +		goto fail;
> +	}
> +
> +	/* MES resets queue/pipe and cleans up internally */
> +	for (i = 0; i < num_hung; i++) {
> +		hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
> +		pipe = hqd_info[i].pipe_index;
> +		queue = hqd_info[i].queue_index;
> +		queue_type = hqd_info[i].queue_type;
> +
> +		if (queue_type != MES_QUEUE_TYPE_COMPUTE &&
> +		    queue_type != MES_QUEUE_TYPE_SDMA) {
> +			pr_warn("Unsupported hung queue reset type: %d\n", queue_type);
> +			hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
> +			continue;
> +		}
> +
> +		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
> +		if (!q) {
> +			r = -ENOTRECOVERABLE;
> +			goto fail;
> +		}
> +
> +		pdd = kfd_get_process_device_data(q->device, q->process);
> +		if (!pdd) {
> +			r = -ENODEV;
> +			goto fail;
> +		}
> +
> +		pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
> +				hung_array[i], pipe, queue, queue_type);
> +		/* Proceed remove_queue with reset=true */
> +		remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
> +		set_queue_as_reset(dqm, q, &pdd->qpd);
> +	}
> +
> +	dqm->detect_hang_count = num_hung;
> +	kfd_signal_reset_event(dqm->dev);
> +
> +fail:
> +	dqm->detect_hang_count = 0;
> +	return r;
> +}
> +
>   static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> @@ -371,6 +482,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>   	up_read(&adev->reset_domain->sem);
>   
>   	if (r) {
> +		if (!reset_queues_mes(dqm))
> +			return 0;
> +
>   		dev_err(adev->dev, "failed to suspend gangs from MES\n");
>   		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
> @@ -1821,6 +1935,9 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   {
>   	struct device *dev = dqm->dev->adev->dev;
>   	int retval, num_hw_queue_slots;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	int hung_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
> +	int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
>   
>   	dqm_lock(dqm);
>   
> @@ -1870,6 +1987,11 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   		goto fail_detect_hang_buffer;
>   	}
>   
> +	dqm->hung_db_array = kzalloc(hung_array_size * sizeof(uint32_t), GFP_KERNEL);
> +	dqm->hqd_info = kzalloc(
> +		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
> +		GFP_KERNEL);
> +
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -1910,6 +2032,9 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   		pm_uninit(&dqm->packet_mgr);
>   	kfree(dqm->detect_hang_info);
>   	dqm->detect_hang_info = NULL;
> +	kfree(dqm->hung_db_array);
> +	kfree(dqm->hqd_info);
> +
>   	dqm_unlock(dqm);
>   
>   	return ret;
> @@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>   		q->properties.queue_id, pdd->process->lead_thread->pid);
>   
>   	pdd->has_reset_queue = true;
> +	q->properties.is_reset = true;
>   	if (q->properties.is_active) {
>   		q->properties.is_active = false;
>   		decrement_queue_count(dqm, qpd, q);
> @@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
>   	return NULL;
>   }
>   
> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm, uint32_t doorbell_offset)
> +{
> +	struct device_process_node *cur;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			if (doorbell_offset == q->properties.doorbell_off)
> +				return q;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>   static int reset_hung_queues(struct device_queue_manager *dqm)
>   {
>   	int r = 0, reset_count = 0, i;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 3272328da11f..e6eca38cae4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -32,7 +32,6 @@
>   #include "kfd_priv.h"
>   #include "kfd_mqd_manager.h"
>   
> -
>   #define VMID_NUM 16
>   
>   #define KFD_MES_PROCESS_QUANTUM		100000
> @@ -285,6 +284,9 @@ struct device_queue_manager {
>   	struct dqm_detect_hang_info *detect_hang_info;
>   	size_t detect_hang_info_size;
>   	int detect_hang_count;
> +	/* for per-queue reset with mes */
> +	uint32_t *hung_db_array;
> +	struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
>   };
>   
>   void device_queue_manager_init_cik(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 27e4859e4ad7..6cb33f6d71e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -523,6 +523,7 @@ struct queue_properties {
>   	uint32_t pm4_target_xcc;
>   	bool is_dbg_wa;
>   	bool is_user_cu_masked;
> +	bool is_reset;
>   	/* Not relevant for user mode queues in cp scheduling */
>   	unsigned int vmid;
>   	/* Relevant only for sdma queues*/

