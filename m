Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16699C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 15:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58C610FD83;
	Thu, 14 Apr 2022 15:15:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2826610FD83
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 15:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P35HavYBvIM+JONPsSgJaO67i6mwVSOnRN8clZ1WZJskSWwCt5bi9Rpif8q8td37VwjHqcQkFQ56qwhXWfhROTO3oh8vDMBKpn5uc9YfQY7OLgweuMR3eVYVS9MVsfh94w9R57RL8h4eIHxxT+irpEURShhRRoep6kRRP8bHxC7nL2pDFmhxiZLoK38zUmQ5j4an6r7zrkD9jHOv2fDvDvnonyFleCWWeyWVZfQNqH2hDdZD6HP6HNizYyGOPH8ri6/Yxc5zmBOfXlQMao2cGyEPE/Nso++YS0FMC5uWiXr0KKeykHPWU/TGhZ8jjnL1Z37mpfala+fWzN9wUvjgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFTxMcaspD45fi/VJTqtsnstlAm675giHW1yWO2uTQ8=;
 b=TXV/d4qKDmOMoEiPlQ0ZelTaIjCL8MBZwaGDQyFGVjD7Rr6QVnQrSKeOHe0a4BrgJ/eiQlyxH2vyy+7gjiEuEi69MoPAruYpoiW2q4rql18rlJeIi/gi6leAPA3PghuF3Rnmkd5DUmQZ9vfH/olMdo04/peEf31+KpMi0NseUANO3o7+rz4VJ2LIA9ac6eB8bwXAAZ0CMKF8cznvKUafhTgzr0wbVP7b3s8QZv83vCwR9oeq7sXynVpi5TMKqJOJo693coMSCnUmepW0sWPG5Hsz1sm7Ax/C8+bk6Fkwxq0xwBwdSArp7n2utPNEtzW1OuSxjrDuZ/1uOus0LwTQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFTxMcaspD45fi/VJTqtsnstlAm675giHW1yWO2uTQ8=;
 b=yEtOQ7+AT5/NLbHJN52kfk2hbVBn5u6NWVGDn1NjXcS/tFcVIbUm6DJzJaQoqEiKfHEuZq07qOdFa8bp8VpSVjQIjDywPefvkdTT356MgZfrrTOYh/ZiY9QbA+X6jY051yY/IcOFR7h/hST5/M9jZ1Li88SYG1JpG+T4PsceijY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (13.101.157.78) by
 DM6PR12MB3340.namprd12.prod.outlook.com (20.178.199.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 15:15:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 15:15:48 +0000
Message-ID: <35cf31c5-3c2b-d232-7b22-fc9bdd31bc9b@amd.com>
Date: Thu, 14 Apr 2022 11:15:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220414081909.796653-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220414081909.796653-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075593e6-3d3a-4293-f20a-08da1e29a7f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3340:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33403A79E0163093A242DA5F92EF9@DM6PR12MB3340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6HIBKwk38ZMg6+rcKEQr5CRaDyl5Ec9uBfJzzxqWPrj14YyzvMyuU+vU+rwUu3KvE7b6y4+SC02nSWmxFOGGFUJjtvCMgKhadpwso8FSiFK9ndkPxl5HSUkK5mcXw4UM5gCnu9Jycr+gErBUq2zOrEO6QfpMZ4PnGN9otxgqb2XEFIknQ4pyV1m0v3Fm3Hxbk6aCH7q6jBYvJ2eXjZHfEoKTteSsYkURVXBWtqauQE2ogxd3E0Y8QR6/vj0u9li/O4Mi1mig2skInCel/5PPOZg48sItYKt5u7vxWyTlU2LebuvU3rsE5bs/kQ0hAr0ABG9YUGPUgYdlFHq5vSQysYFbMcBW4/Lqdm6zmp0vG+Tw+mX4futqhiZxFg5Vb6igl1cz9Lp3L2Dr9iIIoTeSllSDfB3qviW09RDEyO4l1mdOBdrMX7IO1yZf2uTU7DIf5g7OVv3n85ll+ATAA10BUiMAfgmA1yy+/tBUnF8plElT2RiOYOrtkYaiPXTHuabbw8+pM/srAWCg/fw6a46w6ofmy1zlyhfnjVolMV9/vKzv1RZQc9rv+DGkzK/PDHYzZfQ0BuNP8KmmlLpJgOBubUfckFuJxcbwWnLNSmJ/gTJbjGdYwE9DEWwfC4xQ91NxsAiyvo40AYu9aI5SrlqCHJEEbpNbfCk34+obtLpOg7TG40FN1e1MPMknYbzFfOLyCmAQcqbkNFK0WUD248E34qF9Sm8itKsqbSYlXvujYJVRf2kIm96PsJNoq4dgam9HTNT8uDFluugPC3HwzHaeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(31686004)(31696002)(66556008)(8676002)(44832011)(4326008)(54906003)(6506007)(186003)(8936002)(508600001)(316002)(26005)(83380400001)(6486002)(38100700002)(2906002)(36756003)(5660300002)(86362001)(66946007)(6512007)(66476007)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b05IWmh1THBNMGphYnBlOFJSRUxzSmlrajkyU1NvenNDcUpsMFFMakQxSHM5?=
 =?utf-8?B?TDZGdHdPUjk4elBvQ29lZ0NsbnJ1NXR1bEFOMk5CeUIwRE5BMHVFbzVSUFRt?=
 =?utf-8?B?MUxoeWk0UWszc09yY3ByTnNEcEVjWCtTSFlqT1drNHAxRFJCY1F6SVcwYk9B?=
 =?utf-8?B?ZVF3M04zcTk4ek54TXhXWUowM0ZOem9HZXZXejRkNTNwNUFhelJSbGxidHJM?=
 =?utf-8?B?TXAwL2pobWtWSmZwZU5pcGMyeDJUa1VtWjRTWHpyUkFlSXRjN1pqOUVDb1Vz?=
 =?utf-8?B?dGZ0bHdQYVBpdUYzWUVITHZtYmdkVTMvMG5pM3IyQnlQTy9seGxlZVA5VlNx?=
 =?utf-8?B?aCt0TWlVNzJQVzZUa1BaMi9mNmZiQjB3U09CNU5mMGFQWW8xa1pBelF1aDNJ?=
 =?utf-8?B?c1BJelprL2ZBV28vVEcrR2lZMXlkdC9CYldTTDR3bzdwT2U5MkxZWlJLUGhM?=
 =?utf-8?B?L2p2ZE4ycVRyS0czVXFPa1dSZWNObm5TRGlPZ0NxazhadUFoVVc3MlVpckpN?=
 =?utf-8?B?dkg4RUVLZTh3Vm16TUd1MDZBNTRTY0FybTVSUXJEK3ZZY3g5Ujc1ZU9jSk5o?=
 =?utf-8?B?RXovd0JpSEE2ZWgrdmduL0YyeFNCNjdEV0tMQ2U4NldMK0N1Sm14eVF2Z3lW?=
 =?utf-8?B?MHdyczhPV0gxN2F0Z2Q3SmxQbnI4bFVGTlVnMEZuYXpEZGhwZmZ5aExEN2hy?=
 =?utf-8?B?ciszN3hHVjE2cEQrZExqODNKbHpMU1NZZUdLNW45Z0EzVkh4czFNbnEveFQx?=
 =?utf-8?B?eDkvUFBkMnRHY0RIZWxHb2NDd2lNbEJsSTJmd3JLczdRMitnWE9hZVUxYU5H?=
 =?utf-8?B?Q2R5T1pWZldHYnA3ZXRJcmwvKzdVS1hocVFMSHhENWUvNDgwajB6SzYvKzRV?=
 =?utf-8?B?M1lrVDBaT25ENEl4aGUyazllS2tWT0tOSS9lSE03RVh1MHd2SUllcUpCbG51?=
 =?utf-8?B?SFM3UElweUFzbVArOWNaNm1SbVY2TW4rR0w2NzJvakJuYkRiZTBMSkFSbHY4?=
 =?utf-8?B?ZUk2azVrSU9mcStIUjhSNkR4MDZqYWVYdFFac2F5ek40ZVBrT2YxZ1lJWjZo?=
 =?utf-8?B?VE9KbDNoMnZJb0NDWlU1eHpCRXEzM1RGYndrbCtZY1YzZ2xTbjVtU3YrRmF0?=
 =?utf-8?B?Rkt3RjdOZUlSR2ZnSC84NGhqNm9aZXFNMmhJYjE5WkRlaDB5bGxYcXQzckFN?=
 =?utf-8?B?ek0yblYrbFVXNDljTm1IU2h4WVVYUGR2MG9ORVk5eTUvd210d09qUmZ2Nmd2?=
 =?utf-8?B?R3cwNnByd29EMWFGd3NEY2E3QVZyYlJZUGxDUFpYb1RSM2Y1eW5SK2xnUUlI?=
 =?utf-8?B?NkR2amc2cHFXaHRLNmNzV0cydU80bjZjSzUxNWl5elAveHFLNkwwd29EdEVX?=
 =?utf-8?B?YzZ0b2xGYUJWbHh0bkZYMVR5d0JlUkUwTXdrdk5XZDhlclAvemFmMis2TzZQ?=
 =?utf-8?B?QmUwVEFGM3J3bGRnRENpVDdlWnN1V2pkSVR2ek5GUGgzQnVYS09GM2hzeEx5?=
 =?utf-8?B?c1J2Y0ZSOGtIY2JsWlJ2czh5cGgva3haTmt4bzROQktWWVJOUFBlMzF2aklj?=
 =?utf-8?B?eElCZzFoY3VTZHVyanhpSlF6eWs2ajdmUTdLTGxFRGl2ZDV5UEQ0RloxNytJ?=
 =?utf-8?B?ZVE5ekw0SlcwR1hUT25pK3dPUDdMNFYvUmZ6V08yNHU2cERuWGZESlk0RWl4?=
 =?utf-8?B?bTJwck5kR3BGMEZ0UzBsZHNwTm1CUEl5eERhbmh0MEkzc2htTkx4c04xMCth?=
 =?utf-8?B?UW0zbHpSaERnNTRxVzVJSTVEMVNONDcyR2ZHS3NhdVlIbzJSMjRmS0tqdTda?=
 =?utf-8?B?T2JlZytCZ216ZkVMVW5TRnEyOGg5c3Qremo5aFlrb21PSFBCU0ZubURZQUIr?=
 =?utf-8?B?OWdFUUVUVGdGMENiZjEyMkwySjM1RkNUdDZNUkJKbnhteFBOb0l6c2JiMVVt?=
 =?utf-8?B?Ymw4RWR2SHFrMW0yMTUrSnRtZnZiRkd1THQ2a2YrVFhNME80OVdFajJmdjZo?=
 =?utf-8?B?cUdRUG44R2Q2dTM1Y2FhSXgzalBZWktUM2dNeWJESVdPVytwQS9QZHBPMDNT?=
 =?utf-8?B?OGV0ekl1K0dSa1dHZDE1OGJoM3JQT2l3aStXazhUUld1NllhRnRUY0V5WmU4?=
 =?utf-8?B?djluL0piUko0blo5aWkzbXRGU0doZGIwcGticjJuTE1pQ1hoTXJTb2FiMEN3?=
 =?utf-8?B?ekhzb0NpQnFLRWR1SDRPMUVpamIrUFkrMTc3K2xOeU1KRGxZV0RWcUR5Mmdy?=
 =?utf-8?B?eUxybm8ydzhCbFUxQUdDWHhGcHBqTUhQYXZ3UmR2SVFlQnJGU3ZsYVo3MVRN?=
 =?utf-8?B?V3c0aGp3a0RMT2JhT003aE4ycjBRMzY1dWo0cXlpaWFsM2Z2N1psUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075593e6-3d3a-4293-f20a-08da1e29a7f0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 15:15:48.7986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XeRRSYDSGYX6eIf4F5ca8piXB/HRxwRwjGPxmKFhN9uYQNNDmHtf3hb2bWTPBEjnYIA2slqmBRImUKb/o8O1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3340
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-04-14 um 04:19 schrieb Lang Yu:
> The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
> TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
> heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
> on some ASICs when running SVM applications.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 91f82a9ccdaf..459f59e3d0ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>   	return ret;
>   }
>   
> -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> -{
> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> -		dev->adev->sdma.instance[0].fw_version >= 18) ||
> -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> -}
> -
>   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   					struct kfd_process *p, void *data)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 8a43def1f638..aff6f598ff2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
>   
>   void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>   
> +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> +{
> +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
> +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> +}
> +
>   bool kfd_is_locked(void);
>   
>   /* Compute profile */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 459fa07a3bcc..5afe216cf099 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			if (r)
>   				break;
>   		}
> -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +
> +		if (kfd_flush_tlb_after_unmap(pdd->dev))
> +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);

Then you probably need to add another flush_tlb call in 
svm_range_map_to_gpus.

Regards,
   Felix


>   	}
>   
>   	return r;
