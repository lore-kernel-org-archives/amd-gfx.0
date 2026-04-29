Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAA6FF887E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 23:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F87910E09E;
	Wed, 29 Apr 2026 23:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uEUyMGyn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DE210E09E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 23:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiM+nKOmYsPd4Edsrq99r6v7ErG8UOwGDVdmF09oC8XBVrxJA/5/OnJuTvqLMsqmFLgAqz/PATBDV/Y2vTtspuVb8c4S9uCfmbDggQsle1ZFJMfTSgIC1L3bUPTkOWrGXx8eUMXuVTf9Tcuuna3KNLLrxT17phEdMqwmfKd/2BN0JKI/DvhGfTqC1BeLtI64siSc8plg5kVC9KwzKkjxvktGcgw9jccWqiIJgWrJH1Erz0SL8RqzOEI/JfkdAp5wsIzMQpeKNugkLQb0/7h2GJkHkZHTG1m4qQMV9+OqgnuWaxo282CQs5LFQBmj8+U5ovDASxxYJUxQo18VYQ85MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaDNp7pt9os2/VWNOVPcl+pSjJCnaKsUrV7jlAzY3aI=;
 b=S824ZwzfhvSHkWh20DoQszOvKWTyveF6EfnE5wrMGdk5H+NDKRdpr7UwYOBuXCD65ZaKVbtMtPJVCAGTlIsOS1xghLKMY4I09YOBFYg2h9W89rJUWOfHTqKSvLrpGdBbZi+jG2Tcf6B1ydYsKGZ4QNdLNTaODu5/ZL2TZ3FwEJen1mSHGUKRTB5qaQTOE+F8L26bqJUHDfdXWkZBcDQN3Db/1psAtoWPgIdA7E1UnvsBSjnXwUKe+Lb3mXnYQ4mUDcPJn4qjNRbPoSrjw0xSEzFUJ/OVaaxKQ9+AJtPDIatoUl9F4ek6Iz2Fnap3Ih5zET2Xrk6xMnWoS19n080uzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaDNp7pt9os2/VWNOVPcl+pSjJCnaKsUrV7jlAzY3aI=;
 b=uEUyMGynM47ZSrY+TpY7JZGLgjj0C6J+1b2szTl9ZBy8JfZYTHV1udlSIa2UNmBNSQMCZsEjDTSwHEk2ABivQbUy9SLi1U1S7HYG8O9Fgwvsew/hFoMXkJzvORLqKhq3azPMNM2hSc3Gs2WkYDd9KqSGiAgHFKrrF2jdrJnjnaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 23:04:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 23:04:34 +0000
Message-ID: <58de85fc-3774-440d-87a8-e8adc1bba263@amd.com>
Date: Wed, 29 Apr 2026 19:04:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Check if there are kfd porcesses using adev
 by kfd_processes_count
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260424191107.2146398-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260424191107.2146398-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0193.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fc0587-8812-478d-3990-08dea643adef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 764+z5cdDzP7o+fd/ogNR+0PQvXT4/Y/ELVDcCqXPvzZsJZPQy11v1lVGhdAkgTKcZ82AGudkckQhqNT3zcYfyDIcNsd8rtIGIrVocldedDqBLjS4Gx6CzOTzuWF15IkutiKq91+1OGVHjlAGtgLy85DXcmj3tkq1IDCON7Cxn9K2mbkEOKMZ9hI/dlwkIoVN8gAMcseBGaIYnNXoLNVzFTMLixH8GtQmBB/4ld+VWqaa2VGn/W6m/VMAyrtltJakBhtzbQmg/4ANsaNAju+2t9MWlF1+KiwlN4UJRVWJcvkudqllQDLlY6v+/2EkRBrJG47FY6qkjivAOGP4BqcWJ01hYfKeRXB+cA1a/Du5R0zKXfQOgoygb8ocplvvs3LKMD6pWmlTItTzuWay+DBcM5TLJHgquDUydvuc9P361eNayGarCucWwN49XJ6aJII9DkjLPdmlXkpFrQxmKVekDlTBjkTkEtsPSFYRty+l3aG0vLMgJMd4ndx5pvtua35uR0/6JdcEQk2RAzyl2c4DocsZvq59s+uSMvcUtsgsCeNrGtjfFnbPPBOlKcKoFuA4gZOwxtHTzV79COUousKbLWDnsh1CmkWfUPJbh7J1Ycr1BH/M7VmfHuMIYLavEOUuQRlEKBt06npfuZK+UUMppeSSdtmhpHlgVzOGgxY+poNbmC43CFJqgs/usK6nS4hfJgP4laxOpUGukKEdNtNtyYcDor7EN6r8cRaZju08yQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZJTll4WTROV0JWMThMMTg1YTFhZW9hYlJkTHJrQVdmQXE2alprRUhBTkNU?=
 =?utf-8?B?cXQ0dXJ1Y0IvTWU5ZExKdGVleFdNS2YvZnlXNm9SRGRjdXdFQ3dZbmlBVktj?=
 =?utf-8?B?bjBTVFlNR0dtR1pNRWo1THVhaDlySWs2QU0vQ2pHVUxUUXVJeGV0NHlvRW5T?=
 =?utf-8?B?UkhsT1F3ZHl1VmU3WHdZUjJ1cVVFMXZGS2F2WFNSY1Y4SFh6RzVUZDNaSm91?=
 =?utf-8?B?anZPUElvdFFxdGNjbHZJdTZWU1g1RWpoZE00c2VlK1BIcFhNMkczSVp6ZXh5?=
 =?utf-8?B?L2p4dmxpREIzUnpuc0t6NEdUZEZJWkJDT25pckJnbk1hZjBrb200OFZaRit1?=
 =?utf-8?B?M01pdGZkVVhnaDVjclB5akZtNm5Gd3FhbVpWMUZ3eklzTHhpY2tETWJ4VTQ3?=
 =?utf-8?B?c1JGbUdhd3BuU3hhb3dEWUlDZGFJK0FGejBDWk9lMUJnYUdBcER3SVA4OEw1?=
 =?utf-8?B?NVBBa210OEl3aDlxdVQrK255dDc0YW1LWmlUcktBNUlNaFJNNlhlanRFMmJZ?=
 =?utf-8?B?anRSSzZuVzU5d2J5Rm5jSDJqdGNYS3hDeEphR1pkdUJNUklFa3hOTU9zOStV?=
 =?utf-8?B?VEhiY2grWUMvVXdOWTQyUS9LTFE4NmFTVzZBQ1huc3NrUE1WMStCY1VNZ3lX?=
 =?utf-8?B?N0g1VEhMMEp0WWFtbERxdTNkOFdtK1ZLeEM3TEFEMFZEQms4c1VXSEI5TFE2?=
 =?utf-8?B?MUJjSHVzZEYwVitEcC9DWVhlL1pyMFpadTUraHpSUVkxaVNRSjFOU0RQd2py?=
 =?utf-8?B?VWJsUWZTTmJodUo3b2tkLzcwWlpDWnRRa1pVNUtuOXdadE9IUUdlbkhiWEw4?=
 =?utf-8?B?c1hsS09kcThkQm1tTUUvVWZucURYUU1XdFNmMitpcDB0NkNNb296MGllM3lY?=
 =?utf-8?B?SmhQc0pQVERxeFhEbGp3S3FaeGowREplNVlqd3kxTU9ndEFzMkVINkhUNFV5?=
 =?utf-8?B?NGVyVXJHdWc0U2Q1N1JRTWVIL1h6VnRwbmMxZUVXOW1vT3VJdzhwd2lnVGdI?=
 =?utf-8?B?c1IvSDB0TkRabW5lbytoN0Y3YWUxak12VkR2MnEyUEM1bisvT1AxV0I0VDJI?=
 =?utf-8?B?ajhpNTBnT1VkdWFSTzNwaFZDVytRa1pydmMyaWVJb1dycU1EdEt0SFBrajVv?=
 =?utf-8?B?cDFTT3paSGtKcTZrajl6N0dtOUREMG4rdDdxRXAwdVNJK1VXZkdacWlSRFVF?=
 =?utf-8?B?Z3c3ZWhKaVlHZU43RDRsUXUvUEdMU3M2ak9hY2toSDRPWS9VNzVTZjVNbXp1?=
 =?utf-8?B?SFhveU5NakMxR2JFTlc1UVFOMUlXTDR3dXlEaGlsRW5PRGdXbDhWZnpEeDk3?=
 =?utf-8?B?ZDdrbDdzNFFMblVHWWhFOEk2QUNoQ1BENzBWTmhkckhhbndXbFh0R0lWWVNJ?=
 =?utf-8?B?RnZMd0ZDcElmdEh4UDJNV0NveExjNTlGc3YwQW45aTQ2ZzU2dWVZRnhSZHMw?=
 =?utf-8?B?dW9lK2dUbGpMakVHMHRNUytiRGxXMW56am1VMGJ0Z1M3dVRoYWdNV084T1hx?=
 =?utf-8?B?cnpwc2s4SEFWOXVKWm5jUEpBUVFDUkJiTEFZUUk4QkFRT2cyUXJ0Tk9ibWx4?=
 =?utf-8?B?KzZsV0ljeVdZZy9RRThXOUQxUmFqWUJJbWRGMlRhSXlFOFY3ZHNxSXJFMVhm?=
 =?utf-8?B?YUVuaHhzNlpxaDZVT3duTC8vT2dOaEdBOUI5NWZmSC9nYkh0eDg5Zlo3amZE?=
 =?utf-8?B?OW82ZnV6TzJLQURHc3ZHeFJyZmtuM2pSdFNPc01ZSVh0bythbjFSODg4SFVm?=
 =?utf-8?B?ZnhPSFlWVDBqejVnMGpTVDBjZDB1VThVMS9zRm1oTlJYQjVxNEZiaWtmK1hC?=
 =?utf-8?B?M0xSRjdBT080UFpxaURYdENPVEVSYVFqYXV4R3FUWlFPbFRLdFNFdEJ0alJQ?=
 =?utf-8?B?UkpNZ0FJUmtCc0hOVk5ETldpSyt0SUVhMVppazlsM1BhS1N3c0FrVWFiMWdh?=
 =?utf-8?B?WVJCNUIxNC9DL1BNTlZnQTY5NkVLN3JUSWJ1M25lcU9aYTJ5WXU5RWtSUWht?=
 =?utf-8?B?V2k5L0grOTROZzBFblpsZEFnUFZLVm9ua0F2RUxhYmxrU05Pa0tsTFRxb2Zo?=
 =?utf-8?B?cVdrcDl5NmN0NzJVb2FYSzhQb2c1aXV4YUJYMWNpN0ZRMW40dmttWG40SDg3?=
 =?utf-8?B?LzYrSWROYjJwVzVTMUE3QzAxaVFISy9sVFdmSWpuVit1cGl2Sk1tK002cWZs?=
 =?utf-8?B?cWVxYTIxL016K0VYK0E5T29zQlI2M2ZXTzlqalR6RHoxVW5uTkx5UEFUWjk0?=
 =?utf-8?B?VGMxNk90bUVGTXJHeWUxS3pkWkZCWTFnSVR1MUVPeHpxQ1JPbHpBc3dVdDJI?=
 =?utf-8?B?clpLc0F2TGF5K3VKSDBiQTBlSXVIVkY0OGJ3a1RtVytzalVnMnJhZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fc0587-8812-478d-3990-08dea643adef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 23:04:34.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJumZTm/Xq+PYMyRt3O/1DrNnE7s21az6HHo2+pei+JFk3/xyduaLtQputDdv5Lf6PnNnvLmFJK0S/U9qva3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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


On 2026-04-24 15:11, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 6cca686dfce7("drm/amdkfd: kfd driver supports hot unplug/replug
> amdgpu devices")
>
> During gpu hot-unplug need check if there are kfd porcesses still using the
> being removed gpu before clean resources of the device. Current driver checks
> if kfd_processes_table is empty. kfd processes are not terminated after
> removed from kfd_processes_table immediately. They are still alive and may
> access the device until kfd_process_wq work queue got ran.
>
> Check kfd->kfd_processes_count value that is updated after kfd process got
> uninitialized when its ref becomes zero.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 33 +------------------------
>   1 file changed, 1 insertion(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9a66ee661e57..71fd3b1d0b3a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1737,37 +1737,6 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
>   	return false;
>   }
>   
> -/* check if there is kfd process still uses adev */
> -static bool kgd2kfd_check_device_idle(struct amdgpu_device *adev)
> -{
> -	struct kfd_process *p;
> -	struct hlist_node *p_temp;
> -	unsigned int temp;
> -	struct kfd_node *dev;
> -
> -	mutex_lock(&kfd_processes_mutex);
> -
> -	if (hash_empty(kfd_processes_table)) {
> -		mutex_unlock(&kfd_processes_mutex);
> -		return true;
> -	}
> -
> -	/* check if there is device still use adev */
> -	hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_processes) {
> -		for (int i = 0; i < p->n_pdds; i++) {
> -			dev = p->pdds[i]->dev;
> -			if (dev->adev == adev) {
> -				mutex_unlock(&kfd_processes_mutex);
> -				return false;
> -			}
> -		}
> -	}
> -
> -	mutex_unlock(&kfd_processes_mutex);
> -
> -	return true;
> -}
> -
>   /** kgd2kfd_teardown_processes - gracefully tear down existing
>    *  kfd processes that use adev
>    *
> @@ -1800,7 +1769,7 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>   	mutex_unlock(&kfd_processes_mutex);
>   
>   	/* wait all kfd processes use adev terminate */
> -	while (!kgd2kfd_check_device_idle(adev))
> +	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
>   		cond_resched();
>   }
>   
