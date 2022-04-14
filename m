Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880F4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 13:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D3110FCA5;
	Thu, 14 Apr 2022 13:44:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBF310FCA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 13:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFExiFWdMxhP70ROx9xPf4R7x/X9JuWd2e3bDbtZKTGadSMUrBDiIwEk7UAr0UsyTcEoHM8S6d0/1EUln/VTkHaKgsPgXfo+/LVFXaUNSn2VuvUBr4tRW2jEcIs4WYmgDuRzdYedBpZuMSeJ85f5I8YTUo4E8XUdtwXFY+fSLFduIVyAsBmRS/AD2SAcPuMCMak3WhIewEESR3R9vRZuRMVbcWi5d3X/Q3EVoaOjAUHQMDPQL0K1Lb2v7ZSP7rp/R0Ec21LhOID4Cit/76NyMIjJOCHuHCCsSCPiXyu60rCoBh3mozO6zqqlU+sTmPWHFK2PibzuRFyo/4h1jrSDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcLpVQcInJOSEutOQHk4TiMzZAk2EKBnofGomAtF9Y8=;
 b=h8VsWBbxVSFFX5K+3aYKy6lDn16JLx0HJgQ+new9pShwzYXGIGJAnomMKg9coU1ikhQUbtXkJAq6qvyUyzEc3TP+46BEamzNEYsRL8rz4aSsByNKjpjAUpSUNMLnJHP5xdlu2p9W3sRR56YdINQVfXUK/aCMNhMoRUqjPVG+QsN9q4Z0fv3/51NjcUK+Hv2Fv2/dtBNG61hkbLOKDGE9gTNz/5k9Ledon0RAwYuRFfsDh68WykDwhWFLg4gc/CkJt73ABIuXmja02l3/EnDKvmNLsElWGmRxEsGKzW9lT9h2H1J0Tf+Xu2MgXpXglNDECYvs+8LB5VUFD7sUGldgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcLpVQcInJOSEutOQHk4TiMzZAk2EKBnofGomAtF9Y8=;
 b=x7xFFymcVgEMSvAtV/GwhlcmzQqg7CRAkw1tY1qN/OYg6bUzTLGUIPJx1aAhZ4TiQDOTgBiudAw+Ng20N8zxCL+WF8jeyJjRnpJKapH0j0LTPrAOu5XPF9Tos02yNb660hYnA4UwdlJ4A6Le3977YBx0KEiFgYhvvTf7w3IN7XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MWHPR12MB1776.namprd12.prod.outlook.com (2603:10b6:300:113::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 13:44:13 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::40e8:dfe7:d7d0:de85]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::40e8:dfe7:d7d0:de85%8]) with mapi id 15.20.5164.021; Thu, 14 Apr 2022
 13:44:13 +0000
Message-ID: <037fabb7-01a5-1a02-ffed-5c9f54a10510@amd.com>
Date: Thu, 14 Apr 2022 09:44:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220414081909.796653-1-Lang.Yu@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20220414081909.796653-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::19) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f793877c-daa3-402e-1730-08da1e1cdc26
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776E6987B8FF3360397FBDD82EF9@MWHPR12MB1776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4kj/QK8HglTE+WDY5N5tgnfXqiCVmBSWPr7weE4yzamm+2UJ6MsWCJnw/EwI06e+UK3lfW/0zwvhnHs/dzmS/U/6e5wmALk349WVKbzpZzHjcMvwf9L5hEsF4D0+ZNAMdNrw3ak6GCqLjTdcHcNIJxD2pZK5G1E/qBQlNRxQUeWq4Yow5tSlzIcBzf1fluzWqXv/d02kGtbaWrPTUTrhulakFxBN6Gm7xtcc8BEmyxM5trz4lVxMOzqy0Moni37RdkhbTdCU5/juLr5SIojuW20h6DAXifoI+oehhpsulny9T1vw/wdRlgdycSLZ3x5J6V7NOE/GHrS0Agi41YK76mw84pXJ5Yf9XBWePspnG62L2sIlXHbdlAqvLAg4gH0Bqce9SgStK+RJQYrrMztuJzjmO1Q07E+j6hj9BlCnbxSZfosmrvHwoA4ytJ8yysftUPHw+E5+NwqiHUl+/Y/AG3vYMAIayJkiQf1bMpu/MCv7S8IsRLVGL2JVw/Pnzo5VHpIboG++kPGsdx0U3aE9ys2NRFMgYOt6JWDc/P4VWodbf7q/4SBBxaOuzFIvxLYr8h/MYhM/EA95SJb9XudiobBEblzdtCOo7kolbiztj8dyLvF01uQCrpuacAvLVhJiyOKVu08yayiKEaFz6F/EVbu1c7FvcV3YN2Zxfb9Hqn4F3ibptOTprP/inUbSgFL/FfKECS3pQ7aL33ls09IRv36sPwXQKjGp7KAH49fg1RcEU1yFxczferBwFNG1Upc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(2616005)(2906002)(54906003)(5660300002)(186003)(31686004)(86362001)(53546011)(6486002)(508600001)(31696002)(38100700002)(6506007)(6512007)(316002)(26005)(66476007)(8676002)(66946007)(4326008)(66556008)(8936002)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um41YlhRZVIvc3RYelVGVWNqR1lQMytBaStkN3QrL1BuQi9EaGQyaUhJRDIz?=
 =?utf-8?B?YkRrOFlUdC9rR0w2RnEyaUdudG1TOEdXa3RRQVhJOEE1d1BjbmpMdHN3K1pN?=
 =?utf-8?B?MlFHUkM1TVB0cHIvR2QwV1pyc1JLSm1wd2daak9uOEpPKzIrRmR6R013eU5h?=
 =?utf-8?B?VmpyMlA2aVlKWkxyV3VNemN3eXBwNkhaaTBVSzZIR29OSEFNcnpmaVJTWWcz?=
 =?utf-8?B?ejhGNFZIRDNvcFVFaEl1TkZ6Yy9aSFdEVFhTbU01MHNyeWhmNUxuSUJCUjB5?=
 =?utf-8?B?V3BvK1labVBiUWJQN1BrVzNiZG5PeWcvdExjK01POGdjazl5RThFQ0xNN3c4?=
 =?utf-8?B?WlpoZkEwZmx3NmphQjdDRm82MHNQUjVycm9waUwzcmhTeFRua1pLUzNCTjBS?=
 =?utf-8?B?WWU2eEg4b0wzWGkzeWZtWEtSZjVyRHRVa2VFM2d1c2ZpdDIzUWdPdld2aG13?=
 =?utf-8?B?RHR4SG1mdlRQeVJnSmFhSXpNRjRqaitKb1phVXZLc1hEdlhiTkVPZXlhWnNG?=
 =?utf-8?B?WkRURmNhT1BMUGRWQzdMUEZzS2tFa0RjdjNSRTFUQlpsVndTM3diNHRiQjl3?=
 =?utf-8?B?Qi9iUU55WldyMy9RQ2RDVVVGeTg4NThuMFhkcTNBRzN2dUlScmR1ZUlZb0pD?=
 =?utf-8?B?MTBLQzR4amJCM1E3cXdLZ2loekhZdXl2N3FhdkVQMHNPQ3MzM1JSKzFqZmhV?=
 =?utf-8?B?NFlIaXVOWXFhV2V5UE5nTTJ2ckZXczFuYmg1UTdpbEdTbkNsQWRsVklCRSs4?=
 =?utf-8?B?dmFuck5MZW1GNlJDbkVQekp2a2tDRC9uYm52SXBBalIxZVprUEVRaHJ2Qzg2?=
 =?utf-8?B?UVZkQjFkMTZ4Z2d0aHYrRlBRU0JKZ0lSVnhNMXFDamxGcVZRWi9maHVxYlRa?=
 =?utf-8?B?dE93cmNxdDVuSDdIVFRzOFVEaWNUUEt6TXNJa1JlTDlZRktiTzhQemQvRnRH?=
 =?utf-8?B?WEpCaVlVSGFZcWI0RFh5bUhrQUwzWVJHYmJpYW5tQTFBWTVQL3kxRnp5eklu?=
 =?utf-8?B?WmVPY1RaNng5SjdBcHJMVVdjZWZEanlwRnFUbU9scVRrK1dOYXpVU0lGampv?=
 =?utf-8?B?dHl2WW1HVC9MOU0wRFlKVWpuRFExbzlJeE13WW04Qy91ODdHdkdHQmp0Z25T?=
 =?utf-8?B?TS9uL3phYkJTYVRYWkxGdEhpUGc0Qis5eDQvYTFSczZIbTdOL0daQnR2OFBM?=
 =?utf-8?B?WTNMZ0FsQmJ2WUVlOHVEbTRnT0FuUGNrT0pwRlZQZVl0QW1rdVlRMkNXMU1v?=
 =?utf-8?B?NlRwcG13bFNsNWt6d1krOGZwYTU5TkI2YlVPcGpXdGJPQ2JSK0haNmRHZ0Jo?=
 =?utf-8?B?VkkvZlprUHIwMEhobkFIUGtIQ1REUTBlRkNwSnZOOUdsYThxMng3czk0MXVC?=
 =?utf-8?B?ZHFCcElvczN1dmZTU3JnVUZvTi9Kd1lZQUNjOUJzNVZkaHlkZkNQOUJpTzlQ?=
 =?utf-8?B?T0xjV1ZIcEdNT1B3U2FxSEI0TmFQY1luMTJuMGwwbzVYa2xTQ043S295clgz?=
 =?utf-8?B?cTFjNGdhNFVWVmo1L2NIakJqMW5SWFovOGZES0UrcWNGNk9kVlBtL001ZzdD?=
 =?utf-8?B?YXBCdVJBZVNubGJ4clhnVXZhbDRZYTg1K1R2OW5NZFpGNnd3d2J5ZDJqVHJI?=
 =?utf-8?B?M3pjUU54Z3JxWlJPSlE5dHVodGhhRGpibE14NjV6NGVtd25QYU4rMExKVUE1?=
 =?utf-8?B?VWdXRk5tWnd0enZFcklVSC9KVVBZTUF1bHR6MHMvWnZ6T0dIZGxka3FmaXVX?=
 =?utf-8?B?STZxclFIcm5PaktUYllvcStnTHZVSEhlV3RHTENNTVR4WW05RXc3Tzh1Y25a?=
 =?utf-8?B?ZkpyQURKa1JFRmZUQS92SllpakdCWkk5NlJzMVVJeTNMLzF1RnJwVzVZcWEw?=
 =?utf-8?B?L3VmL1AvM1BNeWM5OGF2NVM5b1Q2V05OdkRhNFNIU2k5L3BFOWxRM3VZV2NG?=
 =?utf-8?B?RmxXNkp2cTFrMVFpNTJEOHBST1hQaHB0c1NSc1lsTUJmTTVpbzNKbjJXMUQx?=
 =?utf-8?B?d1VXNFdSK0NvcWpocGxzdWhnK3VoQit2bVI4V0g3QWR1NlU2OCs5UEo4Sk04?=
 =?utf-8?B?eC9wMzdjRTB0ZnBtbUdYNmRKZDExU3pYODdteEJCTVptUlZadUlVczIrUUIr?=
 =?utf-8?B?eTJ5aEVNWGwvUVF5RWt1c09nQ280d2s3U0YwNSsvVi90eWw5Sk82cUQ2a1Fa?=
 =?utf-8?B?THo1RHZkbURHN3cwTG8zQkhmekh1cklnd3VKemtzUVM3c0NTQmFKdW55amRR?=
 =?utf-8?B?ckM3dDdObnJLcmRwd3FQT2IzUGJnMkp2YmdIRXRqUGJoVnp2dE05ZnJsSWd0?=
 =?utf-8?B?b0w5WlBnQkJPYXFWRFZuKzVoV3FUdzlpWE9vTHhhRTBvMlMvM3F0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f793877c-daa3-402e-1730-08da1e1cdc26
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 13:44:13.0415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cj1RirHKxKBe5IT9xd9qdLLnNFMstArVExJSHngLfSND2h1BecnbZpEi/XKYchGB4uci8INuXdt+bugzBbL1Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-04-14 04:19, Lang Yu wrote:
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
It is a cosmetic change for function kfd_flush_tlb_after_unmap, and not 
related to the topic. You can separate that into another patch.

Regards,
Eric
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
>   	}
>   
>   	return r;

