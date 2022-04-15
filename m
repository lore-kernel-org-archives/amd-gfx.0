Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46492C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 05:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBC610E71D;
	Fri, 15 Apr 2022 05:07:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F6A10E71D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 05:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdkXxRumMWD5YmTXkBmGyUuS1casqf3E7x9ueMODjYG2TKhuJZI1y3fi6tlXuaK8m3TEkwS1LBGZioaEfZ/kKXOgXpcSA7FPClSvReRUTxiv4nxKAwtLh4nJgi0aaYZoApnQ1MF1Fvz3xWhUSp2eB3og/OXLG9oxbECqYYDX/f5CVjtV78++dl0mifzaokesf0FlBwtZUg2SAEPMhRKWsFDN550We+Sdc5Wc3rv+Ezpj27Zxj7aNM5sJbG/QHkGtwTGqnFvJlCSJ8Q/DOmlr+H/YN5PgvWVB6w9YsWKuJh3MbNrCysXOMHxTKj7hx+HUTJLolcH57pHrzfLoUJ7qoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp6uw6jn804/jVy1YytY3O6mh1KO3i+sqErhy5cyd9A=;
 b=m7N/CDoYqcqKAbDfFk1WPy725dKDrgExySIUO1sOAuydvyonbaI4v91F2tI9JRIgD0+wVTEUy4MPaBZeFgLCkf5NuXAzF7ARUfOFwaHi2I9hgV8k5qG39oC6m42KEf3Csuvvl1XzJFeM5Ddhxn8pdvHe87SdYNroPJUiaRsKPoKTCwUiytXfIXiObuaM6RuwHGz6K4UkEyPYTkXAIDHzeC9oA+59Tr28J0b+OJ4My2eqztYruNY0fI6TO7CYWzjmQyrm25KOhguo+xR8Z72U/zWvorNIAyvnN3TsOPVd7FApeevg4lh+GxMbSTtirOQjqv14f3JUypMX5y7UIlkRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp6uw6jn804/jVy1YytY3O6mh1KO3i+sqErhy5cyd9A=;
 b=NDjjHddCU9UfL6rQcWwCVK4e7Fb6PU3RiETsNL8U1lpB9TO95Hw86sr6iifr+QZvuSMj47cmVRVwufObwOfbQqrx4adSKxIfYs8veh/WkaM1SzR0pNTou74xGGneg5zyyRxyPugP1SkBfXz3QfPJAKKK3LPUs9rPohwZQDDYkOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 05:07:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 05:07:28 +0000
Message-ID: <44d5859f-e62c-4219-807e-375510f9ce6c@amd.com>
Date: Fri, 15 Apr 2022 01:07:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220414081909.796653-1-Lang.Yu@amd.com>
 <35cf31c5-3c2b-d232-7b22-fc9bdd31bc9b@amd.com>
 <YljcxNtP+zGB1QJD@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <YljcxNtP+zGB1QJD@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3e619a6-4b21-4dc5-c64a-08da1e9dd641
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31899B802E9136F52388183892EE9@BYAPR12MB3189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwAVW637tj+q4XEerZBe6amInf6uNi/bfVr/Zl4tBSYQ0Y/53i8gqMrfMcnOFmyJT0GG4ArCD96c18D7WKZ4olmlT+UhxPeLy4+eijIQTMhmnjMRmnzaOL4xlKJi/12YGD/1yAcE2Jyt4sihkkC2AeL30P8uvTGjmKq6p7iUF2XH3xsWCUYqUiftPasW2106NMRJzXK4zL8roJhUOeo17OS+zetjRpKOIyDT9o7GQkXfXGSjGqQnDxrY7pX9BZYq04KBjQrhfUqxN0SE8wbVUmaapmF9eRRWp8jQjoZqIiwwQo5mLEEejQJrYXTxlyLl++zdjC+Vj3Nijp4oUJIrABtHd09OG/u3dKP/1V9ZskZGkjyj2q+uKERdKr/WCQyDyEAixvYR4tehzaXEDzaoqlwOuXiBoKORNinJYIMucz48CbtpmdOVL/Eg5Rw4IlL+pANkHxy/1Axjjt5erVPuTopc3myY+aaBOT0l/6Vje7EhtDJAzQoX4Wb54sKIHLIIaoox5buyyQOD9u8hC2fb8LJiUTXbR/HaLFqLDRFUo7Ne2VxoawcBJHD56eIKs+V3849gwDfXR4GIyT7uKLpeA90dTDp/3DrGaDAB5PItJQleRRso65bDXbDdo1knSYU8L31td/Dc0/KEkjIa+xTS7KB/W/c2L0Rn+FmkQCHFVhyO4NHnVjgUPokImnF7t9h4rwi2csGsVY6PlU834b82fNXS46k2J/pw2MJLeBT7nXeN8M3IyUJbf657G7gM1DetwIHaim0YcO1OH7kpMn0QiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(31686004)(5660300002)(44832011)(6486002)(31696002)(508600001)(6512007)(86362001)(66556008)(66476007)(4326008)(8676002)(38100700002)(6862004)(36756003)(37006003)(54906003)(316002)(6636002)(83380400001)(26005)(186003)(2616005)(2906002)(6506007)(8936002)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVZRXNScUtFdWoxQ3lObzBDWnp0UlJzQ2l2UTZlWVBDTVg1di9CMGJLRnB2?=
 =?utf-8?B?S0ZvaHVWNzN4diswRkxMdWVWekRvWkx1eTRGZWpXcGlLMGNUcURjSHE0MmpZ?=
 =?utf-8?B?b3FTVENsMmdxYjBvdGorVjl5ekxBRkJNM1NBWDFDZnpUT2MveVBSczE2c05R?=
 =?utf-8?B?SnhXQnI2Y293UFMwNVBvMUNjUXBYNTkyUWZVcGJ0WVo4bnpiRUwzUGluTXRX?=
 =?utf-8?B?dFhyOWMySlhQWHBMYmVaMFVmc3N5cHBNanQ3ZDZBSjRxQ1dXSkVDbFVEbjVO?=
 =?utf-8?B?S3dlZmY4NE1uVGVkUTlxNXZtaVBGUVV2a0JURUdTaGlqaFJlZFkwNHRJdWlh?=
 =?utf-8?B?N3hRaCtSZ01iSWowRTg2YSt6eWkzaVNXZmNrRmo3V1d1alZIREV1ck1QZmJn?=
 =?utf-8?B?YzFFTXRFb3pmSnJDWWtBM0p4TmZFc1FYQzdOUGJDMkJPZVE1YzgvQkZheFRO?=
 =?utf-8?B?ekYreGNmemlSSG9DRjhBQ0tQVnFPN0JPQitrOXpwQnJpQkdiaG90ZXJzSjhK?=
 =?utf-8?B?MG4zVURmY3BvQjJCd2JaYVBkMkJEakVCWlFHVFdBQUhURUhQN3BWUk8vMlBw?=
 =?utf-8?B?ZEZ5TjBOcjhVeFowQVNMclFVRCtLSHJSQUdUcDh1WDBDS2libzRJdE1XeVB5?=
 =?utf-8?B?dUhCcGdtKzN5MzlyaW1tVEtRRzM4TXVZTHBySmRRUHkwTVZjKzhobHVEMHRL?=
 =?utf-8?B?MGV2U29udGpBZ0lOQzBZTGZmN0RUL1FiZmROU2R0TXVKakJkeTdFN2NPOFF6?=
 =?utf-8?B?c041RTdyakg3eWkwSXFqcDRCeWhlZWgvY1VJcTZRTnh1bEVFT2xLZFhUWkxw?=
 =?utf-8?B?eGtHWmtaZjlKck1Hd2xGdEVMODF5dmdPc004b0ZSamJiaEFBTjBWbTRvWFZu?=
 =?utf-8?B?Q0hnRjZMejc2bHRsa1R1MENyRlpPK3VVZXJNSSt5TG11eURKQWJNOXMvWXEr?=
 =?utf-8?B?NzBTbTVYSHFNdENxbUN3QWtSdS9tNlBNTFZRdCswL0JTV1pJYmpUTG5QQWlC?=
 =?utf-8?B?d3V3dWI4eUltcTBBcXdKeEpia2l6ZEVGNEErZjlBMzRhNkhzVUJkakR3dkJT?=
 =?utf-8?B?Mk0vbTFhZ1NCY2dQREZicCt1RUxGaVRkYkkycFlvR2VmeEo3QXlqR1MyMysz?=
 =?utf-8?B?M2xpbWQ4T1NrSXE0UHBjMXFsS0gzWnBKRGVYSHdBczQ0d29MNzhGQ1l3VUVv?=
 =?utf-8?B?R3BLMDUxejlmWks5OWwwSUs1YnBsdUVOTmkxcXYzeHh4d0NoeTFkeDFucEVO?=
 =?utf-8?B?VGxaZk0yYXg1RG01Z0FsWEo2Ri9naHZ1ZGhRcVRpZHRQMWZnMkpaVk9UUjRv?=
 =?utf-8?B?VjZyMkRNd3p3aXFLYmdsQ0diNVhsNXlOOGRHOTFzU2Yzb3Z4c0N3dldZTjJC?=
 =?utf-8?B?aGF2b0g3MWd3UnZQRlFEamRULzk0SHR6SFdHY2FGdG5lZ1pMK2dmMVkxRzE0?=
 =?utf-8?B?ci84YnZMMU1DbnhzVzAyQVJiL29DRDNqNlpRRmdRWG1MdFJSQ0U0bGx2TW9B?=
 =?utf-8?B?MWRmc3AwaEZFMmhnK1AvNmlxeDh3TC9OVm1OdDBKYjFTeW5scXpPRlRDcWlB?=
 =?utf-8?B?cThjckxhMlZmaWtQR1VwSjBnRlBxS3lRdDFudVRvMThCbjliMHhDTUhVS3pu?=
 =?utf-8?B?RFBMWklxN085R0djQ3NHYi8ydWtWV2dNUVV2Zlh1dUlFelJPQnhLOFFwakJX?=
 =?utf-8?B?aGtIVEtsZGNKK1VhblVqY0M2OXhoU2lWcDF3cmFBSU1XNmtaNTI4eDNtdHVz?=
 =?utf-8?B?L1hIekFmOFBsQXM5ZU1nZGlBNWZVM2dwQ1N6NXFBemNqTXRPb2tLaVJwV0h5?=
 =?utf-8?B?TmlrcUtkMUFMWHhTOEc5eFFJVHpZUlVqeWdzODZDaDVQS2tDS1RZeldVVnNM?=
 =?utf-8?B?OFdrNXF0eGVNd0hlbjQxeVJtYUNuNWtLa09udFhXNDBBQ2d1Sjk3OVhYL3ZR?=
 =?utf-8?B?azNtcEVqNHVNaEpHaUZMVFdnR0pDN2pXdHlMMU4yRzk5NWpXeCtueFB4dkw5?=
 =?utf-8?B?ZTlSeHY0QnBvVFYycTE5ZE52WFB5OVhXQ3lqVzA4c0pJT2FOQTl3cXd2bHRI?=
 =?utf-8?B?VUlEOHUzYVpSZDdtR3JPWDdVeEdnZ0poNWZuV3FkRW9hclg3U2JOTStIc2Zs?=
 =?utf-8?B?b0ltS3dNUnpERTZsSFlVWk9DWTI0QTBtdk8rUjZCVHpVcE53MlpTNndZRi9v?=
 =?utf-8?B?R2hiNk82TERIVEkvd3U2WjJvZytyS0ttZEU4QWw5VXZSNEM4SDl2QVczN21j?=
 =?utf-8?B?RmYzL085bjQxVEdBamg5NDN3dkZlcEJwSTk5SWFMWlJXdHhCZDVFUEp3UnM5?=
 =?utf-8?B?VGtqZXZtMFRCRStGL2h3SlpIS244U3ZVVlNZU1NDT3JVd00xclA2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e619a6-4b21-4dc5-c64a-08da1e9dd641
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 05:07:28.1086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdixCv9hJGgCUcuSntHDZn3GMMXi7Ff/kkE6AczR7LdQuLFbnQhGU2ph6dEJ+Xse+JIs31C2oRsPyYgthIz4BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
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
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-04-14 um 22:47 schrieb Lang Yu:
> On 04/14/ , Felix Kuehling wrote:
>> Am 2022-04-14 um 04:19 schrieb Lang Yu:
>>> The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
>>> TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
>>> heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
>>> on some ASICs when running SVM applications.
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
>>>    3 files changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 91f82a9ccdaf..459f59e3d0ed 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>>    	return ret;
>>>    }
>>> -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>> -{
>>> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>>> -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
>>> -		dev->adev->sdma.instance[0].fw_version >= 18) ||
>>> -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>>> -}
>>> -
>>>    static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>>>    					struct kfd_process *p, void *data)
>>>    {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 8a43def1f638..aff6f598ff2c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
>>>    void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>>> +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>> +{
>>> +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>>> +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
>>> +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
>>> +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>>> +}
>>> +
>>>    bool kfd_is_locked(void);
>>>    /* Compute profile */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 459fa07a3bcc..5afe216cf099 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>>>    			if (r)
>>>    				break;
>>>    		}
>>> -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
>>> +
>>> +		if (kfd_flush_tlb_after_unmap(pdd->dev))
>>> +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
>> Then you probably need to add another flush_tlb call in
>> svm_range_map_to_gpus.
> There is a TLB_FLUSH_LEGACY call in svm_range_map_to_gpus same with
> kfd_ioctl_map_memory_to_gpu. Do we still need to add another one?

Right, I missed that one. I think that should cover it and the patch 
looks good to me.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>>    	}
>>>    	return r;
