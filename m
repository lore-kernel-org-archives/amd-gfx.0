Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC7BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 10:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2554E10E7A3;
	Mon, 13 Dec 2021 10:40:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2964310E7A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 10:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVB+FiGwsn2F/koAySyie8hTKwRGiZxH8niYGEEbaRdKuBO8ZVmUndNMoV2gzm3U4XIFxk56Pc3+m4WDNEcVbdJ7ZzULbDlav2n5H+FciWuL5wClaUo7koSc04yU1Ybq/J3jyI3p+Po5z9DsdrPAnLAuBQ2ab3hgg/TPoRSNptYSmvo9fHlm0/wUzNKij85Kc4nCwMB/zLFchcqE2OVJSd1Y5aHMxcm9ae/X4p194RWZMC2m7kv1WhzoWnkOQOreg1+jdLy9n5toCyfgSDeOt8K9P8uRZ3UknnfAz91jy8gEu6CroT8ri1iTDLHBXdYfrccXRT3yezHbAqk3bp1ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a+KH5C8ROuHr6S88GIoRo2nFb1LqS0ABll12xtyVKw=;
 b=eNfsRnxpz3Mq7yzXF5actPb0REyKcwBUBwLabwmFdZ5k8IRv00rYbBCAgFWapDf8M7RjaFidXfcDHj6y2RmM6iFaFJUVBj8PIYRW0s8J++67D/rXzj2FsD/2JiVxlOMxT11P/ThAguUPOgsIq96Z0Erw6E+seAcmiHl8ttvMdLz+6xK8VC1DhDtmPKaEiFSlEJiy+I+a2zJO67oiUOpzFmBMbmcp2aMiDiW1GPsXYZiXDSdZEMrBKf3bRKal8XcJmuNPOVKLG2vD0LzD3odADSo1UyPsJ8FRZLg93cgvStYNFw5/Pj3cz/g9njtcnsE+rDDPRsq3wkgMqHHJo0Sk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a+KH5C8ROuHr6S88GIoRo2nFb1LqS0ABll12xtyVKw=;
 b=FCSb9l6nhwpaXO48eI5xi3y8LZHw4ttEhfDNlci/u96gFbBCqh1T31Q63D1V8I3wUXrg3VJaXADiAqhFxugEUF0OeGeLk9VGOO8SiZ+Cm2WNco46Q2CgHQhP2zjY4PaEwFuqpGPlplxo2nl6F4tVM3+rbBd2ccZd3owQaF3VAMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 10:39:56 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 10:39:56 +0000
Message-ID: <272c25b0-918b-a49b-2611-18f197c561ac@amd.com>
Date: Mon, 13 Dec 2021 16:09:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] drm/amdgpu: move smu_debug_mask to a more proper place
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211213071959.793698-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211213071959.793698-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9034e509-2e9d-4c0d-80b8-08d9be24e75c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943600C85FE3EA35616FEB097749@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x78cDKdLpOLiE1AquUako9lRe+YU1uXhkFw5frAFOUWSUkgUMlsmukKDYjojHkIpqEiwxuKmajxELrqAqrLJpjhMHI4M+rUlExy93lBynKLQ64a3G7vkkmnejzYg0sJa6el9GvFu5v22OywHNzlIhiQnzc+re0ecq+/Hcz+dXgFhYJvrMFKvWD8jee7WCzNSq5IyvLQ1TdIsNkNfvwsrjEtDONFecHslP/VI4uo+Hasd3MPJAM5sDhqUYi0rFXgrU9569nIZj9bHZ8pLtokAKkQtgJTKqVM576jD+qDX5pBDjwCA8n6kyfSAqR/UpH3xnQtTsfLQ68qnvIT9pbQhgn3OUeJTOh4GeTfVY9HdlWEKYCmE0ZHbbYTw9AdJhi/0PoXMXh+D0A1nyRy9Omn438tUUykZ4To3tgoUJ/JkKT+6vQtyoZcyd76+f8/WqVIBFr4dp/OGlz81zpKTEjf9gTWqE+b3t8idsqH93atYBIIVwfx5P0gZnuZ8bDxIQUEn4QjBheULVl+izNPUPb0Epw+TN4JlJ6HlJC2bqTZinxpVR3D5xL4R4fdGilRkv+WVQEle8jw8iKIM9cErEL6xDvQsg4XyO4dfcrCdq/OkRtrIF84ekf0b+9yutmNYkq57t/GSRWsBMQUdO+5aZsfZHLgoiOQrjqsZBC9TO1h9hG5493hFFxQTJ8sgtVO7z6V8RLaizVyDRIYVFhim5ea7hF2mpDVoaUXOaGj1//atfE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(6666004)(316002)(6512007)(36756003)(8936002)(186003)(6486002)(8676002)(2616005)(31686004)(508600001)(53546011)(6506007)(86362001)(4326008)(31696002)(5660300002)(66946007)(66556008)(26005)(38100700002)(66476007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNyYlhzQmpqVEJEQk13UW9pbkRQdms3S0l1Umd1ejgzU0cxSm4wMjBwS0pn?=
 =?utf-8?B?Zy9yS1NqVng3UjZGSGdGbjhQTmxYaDlnMGsrQWtFUTZ2WXkwSmhySlQ1cSty?=
 =?utf-8?B?U0R3ZEpiSFlqZ1czOGtmSVlGald6N2ttR25wTnNiYjYzdktyV2ZINnBRNVh0?=
 =?utf-8?B?dytuNldreEJiMTBYR2JzRGZVbjJHZ3hkVkk2RWVDT2hpVWZ3aERKQW1MaW9k?=
 =?utf-8?B?cTJtNFAvVXRNNDBCTE1naHpGZ0NRK3c1L2NkWFhMUFFHbmc5NlBnN3FIcFlo?=
 =?utf-8?B?M3FwNG1VWkc3dzMybjFjRHBrVmpST0pobXRGSFJvaENXR1VtRGNUUmlzdHBy?=
 =?utf-8?B?UjVCTW1HcURucEFFWGdQN04xSDVJREkyZCt6eThIWjNxNTI2ZytOQmlRcnJW?=
 =?utf-8?B?Vnhtd1J4NjgzOXJINjFERVJJL0paNlJOZlpmODNvMEpXei9JN2xpamcwYTJ5?=
 =?utf-8?B?cmlKNFBDcC9yZlpRYmNUa01EM3FFdHJoRDl1bm5PdjZFbkdXbkVRTGk4NkxC?=
 =?utf-8?B?amk2M3J4WEFjSzNiQVozb09QbTJGcVN2MDdPTHVJczFHbkZYZThJMVh1U3BM?=
 =?utf-8?B?NzFnS0ZuV3VlL3paQ3UwcUh4WW9IS1BTdHFJeGZGcXpOKzJLOXZZc0RGb0J6?=
 =?utf-8?B?bHY4eU5SMUJEdFFJdzNRZmVjWjVBZE9yN0hTN0ZSSm5nbXByWTJQS3NlY1lK?=
 =?utf-8?B?RXVTVExvZXdEcG5majNsVTdYWXRHL1BUWEl2UHA2cHAwN0Y5TDU5dytCcEpH?=
 =?utf-8?B?Um43cnZic0xneUJTa0JDbWp2ZG51YzlaSjJQT1dHekpuTkc3RTJlR2FJU01q?=
 =?utf-8?B?U0VTZWJnNDN5M0JhcDNFZDJCV0pzUU13dzZPdGZsOEladkVvNXBQTXV3Zzdq?=
 =?utf-8?B?ZUN1NG1NcWdRRUZ1dElxZHlZMmplN1F1M1Avc3dGWWF4RUxQcitQNTdNaDYx?=
 =?utf-8?B?aEM4cVU2VU9pek1xdVlJR3EvbkljYjViWUMvejdPRWJvRm0wVHRLcFBPWDRM?=
 =?utf-8?B?Mndac20rblR4VnlkUWZtOTVwUDBJRTA3em9obU1MTnJKY0s0cUpQMnpmRk1n?=
 =?utf-8?B?V0h0cUFNMWplNTVydVN0dkxwSzNvNVVlSCtOT3Q1dm9lbjZLQzBIR21NRnMr?=
 =?utf-8?B?QXJYaTBHQmtkbjRVejVDSi85WFJjbTZlWllWYUpEYS9RaU45TVNWVUp0eE83?=
 =?utf-8?B?VG5BY2FlbSs5UFhPWlA0czR6OHlBcXh2QTFaN2RKYjhLVDZZNFZUaEdzWUsx?=
 =?utf-8?B?SUs5S0dHN0dNeCtlSzVsYUQ1Sjd3WlIyZFpRaTQ5Y21mSEh0UTJHcFBWb3Fw?=
 =?utf-8?B?UFZEMERLaU9xdjNFdTJreXVTMjlIbnJwclNBZWxscG1HazYwT3d1WGNwM2NE?=
 =?utf-8?B?NFFyNXMvZ0xpcEZVSENYbCtjT1UvMmo2NC9iQWlXL1VRN2JnK2Rka2hPQTJG?=
 =?utf-8?B?QVdRQ2ppSjAyK2M4TTMveXdPZzEzSFBFSjlBRTdSMjBHRUNJUDd1b01tbG9s?=
 =?utf-8?B?WGt1dXlVQmgvb2I1S09lV2loYlFJMmZ6bDBlZ1hJVnVmUHgrb0ZLREFMT3o5?=
 =?utf-8?B?SGJraU8wWXkrcHZ3MjdYTVJQOEY4cUp2UHZTUk0rVkZwZDA5WWpFMEh1VFNU?=
 =?utf-8?B?TThoRXM1YnlmeWJsWStOb3hTdFh0aVJvR2FEWVFNRGtqelFzMFByS0ZOUVl5?=
 =?utf-8?B?am9Cb29uU0FsSkNtdHpYNmM4bjFRUWhjZG83cTl6UlZybE8xSG1OVXZlNitX?=
 =?utf-8?B?aGd4RnV3VFloeDJJZUxiMkxnN2xrcjBqTi9la3A2bVZzWVo4SFRPYWErT1pP?=
 =?utf-8?B?OFpjMFcrYlkxcHV4ZzRCa0JLaGtid1VlbEZkNVhyMHdWVmJ4a3lyOHRzQm4z?=
 =?utf-8?B?N0puY1FFNFBPdUI2c285bjR3d0hTd1lzUGFDR3VXNnQ3TDlEa1JwRzhyV3Bq?=
 =?utf-8?B?ZFdaMDFERHU4T3N6UHVFK29IREVtNlo4WmF3QVp6QmQwRC8ybkg0aXZpRnUv?=
 =?utf-8?B?Ym9pRllGb3hFRkpWN0tXbEFTYzRNUG5ScjVvUW92S3lSTzlqQjcwd2g4UE44?=
 =?utf-8?B?NHBhaTJEcWM3ZFFMb2dNYXVsdnNxZ21GTDdpejdZL1J3bGFBTHlHYS82Rnk4?=
 =?utf-8?Q?ZHFI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9034e509-2e9d-4c0d-80b8-08d9be24e75c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 10:39:56.3442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CryWEL8lAiYXTEiWZKoTxB1a6fC5bjDcS4KYov3UqX20+hdgOqZ5iHlS0uUGQoWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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
Cc: Alexander.Deucher@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/13/2021 12:49 PM, Evan Quan wrote:
> As the smu_context will be invisible from outside(of power). Also,
> the smu_debug_mask can be shared around all power code instead of
> some specific framework(swSMU) only.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> --
> v1->v2:
>    - drop non-necessary intermediate adev(Guchun)
>    - move smu_debug_mask inside struct amdgpu_pm(Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h     |  8 ++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  8 --------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 16 +++++++++-------
>   4 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 9dfccb20fedd..25e2e5bf90eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		return 0;
>   
>   	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
> -			   &adev->smu.smu_debug_mask);
> +			   &adev->pm.smu_debug_mask);
>   
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 16e3f72d31b9..c464a045000d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -423,6 +423,9 @@ enum ip_power_state {
>   	POWER_STATE_OFF,
>   };
>   
> +/* Used to mask smu debug modes */
> +#define SMU_DEBUG_HALT_ON_ERROR		0x1
> +
>   struct amdgpu_pm {
>   	struct mutex		mutex;
>   	u32                     current_sclk;
> @@ -460,6 +463,11 @@ struct amdgpu_pm {
>   	struct list_head	pm_attr_list;
>   
>   	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
> +
> +	/*
> +	 * 0 = disabled (default), otherwise enable corresponding debug mode
> +	 */
> +	uint32_t		smu_debug_mask;
>   };
>   
>   #define R600_SSTU_DFLT                               0
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 12e67ad9a3b2..2b9b9a7ba97a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -482,9 +482,6 @@ struct stb_context {
>   
>   #define WORKLOAD_POLICY_MAX 7
>   
> -/* Used to mask smu debug modes */
> -#define SMU_DEBUG_HALT_ON_ERROR		0x1
> -
>   struct smu_context
>   {
>   	struct amdgpu_device            *adev;
> @@ -573,11 +570,6 @@ struct smu_context
>   	struct smu_user_dpm_profile user_dpm_profile;
>   
>   	struct stb_context stb_context;
> -
> -	/*
> -	 * 0 = disabled (default), otherwise enable corresponding debug mode
> -	 */
> -	uint32_t smu_debug_mask;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 43637d55fe29..735e1a1e365d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -257,10 +257,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   				     uint16_t msg_index,
>   				     uint32_t param)
>   {
> +	struct amdgpu_device *adev = smu->adev;
>   	u32 reg;
>   	int res;
>   
> -	if (smu->adev->no_hw_access)
> +	if (adev->no_hw_access)
>   		return 0;
>   
>   	reg = __smu_cmn_poll_stat(smu);
> @@ -272,9 +273,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   	__smu_cmn_send_msg(smu, msg_index, param);
>   	res = 0;
>   Out:
> -	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
>   	    res && (res != -ETIME)) {
> -		amdgpu_device_halt(smu->adev);
> +		amdgpu_device_halt(adev);
>   		WARN_ON(1);
>   	}
>   
> @@ -299,7 +300,7 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>   	reg = __smu_cmn_poll_stat(smu);
>   	res = __smu_cmn_reg2errno(smu, reg);
>   
> -	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
>   	    res && (res != -ETIME)) {
>   		amdgpu_device_halt(smu->adev);
>   		WARN_ON(1);
> @@ -343,10 +344,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    uint32_t param,
>   				    uint32_t *read_arg)
>   {
> +	struct amdgpu_device *adev = smu->adev;
>   	int res, index;
>   	u32 reg;
>   
> -	if (smu->adev->no_hw_access)
> +	if (adev->no_hw_access)
>   		return 0;
>   
>   	index = smu_cmn_to_asic_specific_index(smu,
> @@ -372,8 +374,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
> -	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
> -		amdgpu_device_halt(smu->adev);
> +	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
> +		amdgpu_device_halt(adev);
>   		WARN_ON(1);
>   	}
>   
> 
