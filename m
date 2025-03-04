Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DE7C282D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 18:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE4510E678;
	Tue,  4 Mar 2025 18:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r9vY96VJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B094210E686
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 18:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNmvssgRsD6aboWU/rEKAEcLiqyFC+jTLPBQjawOltosZAE4qjKkcIDwRAnvCAZjJSF7amVCwgmAxp4EXbLtc7aXBIdmLTYDJsd15cSSto/TOytxwpUww6Qr+MJjDlkm5vs7gnQdGwvupWJrMR6OiWeR9gjV70QxgXdqS34tZ06VMt1QEZIifU8n1KlTXNkpYxv1qjwo6Q188pnhqdeGSZOlkF9hKncSROX2T77QL/CwQw+8+UgaOtDtuN+iwV0AYeQ9E1eUH8reUGDqZgsvLPCvEKMEF7SYio7sAQeOGXm/K3yHIR0wP17vvl//0T6psrkWgXuxzawwWjMHmEHJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9wXYSl97h87m5RROKskJ/wdk5hAl/d0uJSGnPVUcwc=;
 b=QGzlEHwBjjF+u4+mxExkfzngYpfQmvhotMxHtAgX1JbaB3fHK0dFYAcYCNXRn3RizvXfNnxFmGtYz0P31cMP6EQalx/F5BWKkObOtHw7+fV6QEnUn8BVOcsj8wedEW0fWEv6KmYB7FVnmOnSKBFR5rUNGihRHzc8lsmzk9iWGmsAEIqBn2+5ezNp3X3hBOE+3n8f7Y+0dA0eNqLDebxbWMOTABN/o5KOvQ3yW8Jw/YTyGwqIaEJNVz6KuQVtdubVCoExB5YVzhzANuqKk5fuHmPHniYL82D2u7CZzmUBU2BCggHZYU29AyRpbYLD4ETUPbrmlITFWvTg1eYZOnFxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9wXYSl97h87m5RROKskJ/wdk5hAl/d0uJSGnPVUcwc=;
 b=r9vY96VJBQwIr8knj2lSSjowyfb3F4UsOORP7gW0lO6AzTG1M26em0PpOLGjDIBWVl7Gogfo3xs08TnOiHHrdpgjEnEf7HSnUjN8lTDVsgCvcDDOBs+2/qM79sfdNOs6Hev/3JIm5UBzPzAKY2LlDRkGGFnHZT/9VF2AZEd+86k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 18:05:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 18:05:36 +0000
Message-ID: <88360484-cc77-4837-bf9b-fea050f1b929@amd.com>
Date: Tue, 4 Mar 2025 12:05:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Validate return value of pm_runtime_get_sync
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250304175128.368511-1-sunil.khatri@amd.com>
 <52638c55-ba64-4cf0-9bf3-8b7935e42f3e@amd.com>
 <BL1PR12MB57530EA7AEF0BE777E39B93793C82@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB57530EA7AEF0BE777E39B93793C82@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 130e5224-8d97-4849-bb9c-08dd5b472a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGZXUFoxblVaT09paDhSV1RhYy9PS2dsRGdYS2NFTjF3UURoK24rZFFOMXk5?=
 =?utf-8?B?RGhZMHhTUmxvVXRqYW85OVZPZ0Qva2dvNlAwNy9mSjJzdDVuM0pUYTQvT05V?=
 =?utf-8?B?dDBUMkVleWpqZzVFMWFiUUVhcU04UkJwbmhPeXNySXIvVnRiMHU3WHArNDBp?=
 =?utf-8?B?VFRSSzRWS3JiQXh1Z0FIWTdWdEh6NlVkMG1DM1V1S2I1SXdrL0FXbUxmQm1r?=
 =?utf-8?B?NTl4MGdlYVVZcnowRkRuemJoTkhFNFdRMlJ6OVlWWVpxQ1p5anQ5anF4VGVm?=
 =?utf-8?B?dUxPdlJTdDNoSWkxYURYUTNRYzlrSlNXb0w4cVFXM2tZVStQOFFhcHZhN1RE?=
 =?utf-8?B?dzh3bUYwWmhPdEJ5MlFhRGdtRm55bmdXVjdIWEJtMW1WQ3dMajFwdmFPOUsv?=
 =?utf-8?B?aVpRWFo0aENnUVkwd0V6K0FZOU9kMnl2K0d1YzJ5bTIvS1JHSGp4b0dHdEl3?=
 =?utf-8?B?OVdFemhDZVA3UlJhSlc0cXNCRTJrWERqZmp5ODNNZ1k3ajdvWlhhdStXVjVr?=
 =?utf-8?B?MjcrWXdCZVc3WjZpajN2ZFhQR0dncStuQnRUUnNYUjZMT2I5LzhEYVk4ZW1o?=
 =?utf-8?B?dDNmZFpSQ2lPemRIMms2azlrZEhuYzB3VXZwd3o4eGkrNDZhRmhseExqcGht?=
 =?utf-8?B?VFB1L0xiUWs3SXhySFBpbUhsL3BsSFR0bFQ1SThOSW90eExGYldmbXdkeE1C?=
 =?utf-8?B?dUJUL0F6TzdhN016d3VkMzZrRUtNK1BWRDAxZ2ZLMWc3bnU3K2lXZk5ENk9O?=
 =?utf-8?B?QkVwbnRQbXo1Nkd4SDcwVHg1d3NuQ1VHSmtlWmQ2N1ptaDZyRGVVd2lnak40?=
 =?utf-8?B?cmFHbE9uZlAybnlzV2hURFdxTk1kcVpIRklKMUtuMS96L1pPNFh0M1g1VnRw?=
 =?utf-8?B?RElkVXNvVzV1RGEzWStOcHVSWWVIaDhJTjlmVWdkbjhIekV1MWFqSW50WDh5?=
 =?utf-8?B?QWR3bElDeWdUVFpYRGI5WXdYNmFMTkVJbHMwLzdPSnpkV0FRcVNES1hSOHc5?=
 =?utf-8?B?VEtzb0Y2M2FpUUQ0a1llc1BvYUZyM2VLZXlZZEd2VEZBK2h5dVFiaFpGNmI1?=
 =?utf-8?B?K3RGbnNUR1NldnpWbVdRQSsraGozK2dzTW1ERXhDbVdjOFk4QWFRUlFwT1hU?=
 =?utf-8?B?L29BVVVEanl3V1JSUGV5Qk5ULyszYStoVSt4Ky9VRUtJT0g2OWtOTnYrZ3Jo?=
 =?utf-8?B?a2N2bS9OUjMxQ0tYRGZCOVR5a0hBWW1PL096ZGZtSVRRUmkzOUp3US9KQkZU?=
 =?utf-8?B?aThweVVEWUVpYm83dHkxNjdTMk50VVpIbmtpanRWazl1K3hGTWFsYWx5a0FZ?=
 =?utf-8?B?VExPZ1dpRTlXelJIbWVGZGEvWjNYNUhjOStPalprcnBtOXZnMWVvMTBPSTRT?=
 =?utf-8?B?b2lxSTRSckdhM1gyMGpJYnRNbDM1UkllcENycDRZUWJib2wyc2UwNWxGb05x?=
 =?utf-8?B?Z2hScCtXMmd6K29XaEpuZ0IycEF2QU93Z0xsZEI0VWFqL3kzc0pjaUROV0I3?=
 =?utf-8?B?Sit4Rk9jZ2U0ckd2OUlkZzlCbTR4K0ZRR1cxSUJLcDUvRFVmV3EyVHgzZVZH?=
 =?utf-8?B?L3BaeGlHWmdkeCt4cEtDZk8vMzNzaWpvdmZvZ3E5MjZvRWlQMThBSy9HWDBj?=
 =?utf-8?B?S0hCRU9Pd3RYdjZhL3cxMkNGSVZQQTMvczNZL0hkc3pldUxaZzVlbVZaMWlx?=
 =?utf-8?B?WkZRYWE3SFYyRXA2M3Q0c0RScHp1YnVBUnRnNmRYeVluYjd2TmVNWXQzVE5l?=
 =?utf-8?B?dHo2bUhReDJKbGEvSmRlMFFUY3NHNWZ5Tzd5UVc4bFdHcFlWTjNSVDBnMFpM?=
 =?utf-8?B?OFJRRnZSdm50R0N1bHB4QThiRnQ1YUlxV2lHMHBDQzBqNVc2SytFcVZDMldO?=
 =?utf-8?Q?i/urtXj0AoLAV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtsY0c2VG5uZ2lQLzZMM1psa1doRllQOEx1VjNEMUhzSVhHR1k4ZllLQ1FD?=
 =?utf-8?B?QW1mWVhpZnZqb1g0Sk8rZmIxM3ZaVWYwNjVhRXdYc0FQZ09xd0hDeGdKK0ZH?=
 =?utf-8?B?SVVsbnhOK0VRMm9ESkZmanQ4Yjd2SVZqOXhPLzYzOHlUU3h4ZVZ6QUFQaktu?=
 =?utf-8?B?bjlGS1FhMmsyRCtqbXhDb2VnazVaVzBvT3d6S2VqM1ZPYTRXT2plYVk3UjRJ?=
 =?utf-8?B?cXl6d0cxUVB3R0I2alpIanZSR3o5V21xeXBSbXJUenpONUlNNGhzcmY4d0Rw?=
 =?utf-8?B?MGMxOEs4VUpLRmpBbzErdFhiZGtUdTVTbTNVWU9WTm13MHV0MDVvb2ZCd0Q4?=
 =?utf-8?B?WE8vSHI2Ykt1bktSM3R1MW5OSWo2UkthcGFZcTJYOXFUVDlRZXZUUlo2NlZs?=
 =?utf-8?B?eWJvWU1jSG9FQkNpUllodHVwTDY2ZllleHpWSjZ3N3FCZXREZ012MUZSMGVP?=
 =?utf-8?B?eWRid2gyb3pRSEptQUh3SjFwSEFGc3J1M2FrY0RMM2tuaDhKS0dRM2NpUHFD?=
 =?utf-8?B?TTBBWUZjRXNqTW9ha1dkNnNMZDlpdDFnSjVFS2p5U0hqdGNXM0llc1pxUWhu?=
 =?utf-8?B?bTJxQno3Y3VCYUVsZlFEWjJYYTRVYk8xMEtlQnU3eU9iN1hQaXdqSnd2Y0hY?=
 =?utf-8?B?Q3paSU5Wa056V25YS1p1ZnlRTXFpQnBieDk4WG9id3VEQjlFRE5qcmE2bSs4?=
 =?utf-8?B?N09uQzg2MStHM0J6aVJDR0JxbTRFN2JXSkFISTZNZ0RnYTM1emw4QUpabVlC?=
 =?utf-8?B?NmNId1hEcERwMVFnZmNVNkZNS3VyR0QrcTMzTFNnNEN6bytPM2pXSEJVTzhQ?=
 =?utf-8?B?ZVB6cG83TklCWjd2WnZXNitrWk9MZy92aDlidHV2bVMwOEZiMXoweXVzN2FZ?=
 =?utf-8?B?UXE0SDg2Rmh1NnBRRERocmQ5ZENBSjRQcHdyTDR1Z2trVDYwSGVra3JCNXpy?=
 =?utf-8?B?TnJHSG45cXcyMDBqRFo5K0V3WVpxd1RtQnRFL3k5NktEbFVvRXNOTjdCazll?=
 =?utf-8?B?WklKbXkxRDBMRTBYckFUUDVVaHllSnYxbTV6TzlSQzk1aG1pUjRQUlVEaURn?=
 =?utf-8?B?bHRxM0orOUhBdWRoM0FzdlU3dHh1LzBKb3NFWmFINFlyOUJSTmVRdE5NdU43?=
 =?utf-8?B?VUxzdDJjRi9mcmYxc0pGR0RVcDJBbUYrN2pHL0YxcGwrdnVFWDFXU1hDY0ZW?=
 =?utf-8?B?amUrK0hZaVlCall2T0ZWWlNna2R4S1UyR3JxcjV4SGhGdE5VQUhMOVpKRDNW?=
 =?utf-8?B?ZXVTZ2lCQnRZeGJjakZSTW50SkZzMnV5RlZZRit3TmhrMWF5Ym9RVnc5U2Vr?=
 =?utf-8?B?WXJLOU95MXdydU4vVXhoaTQrQkZEZmU2YzdhbHMybHBvK0lRZzIyREczaGo0?=
 =?utf-8?B?dktrNnBlY0JmbVd1ekcrdUNScWthLzdvdDNWY1drUjllK2ZFd1hLbU4ydG5m?=
 =?utf-8?B?cGpCMTdSYnVhZmF2STBxWDJUbnFNTlg4bS9HUitWYWdWTTNoK1VTNUY3d3l6?=
 =?utf-8?B?N1Z5REdTRENpYVB2TFBVdGM2dkc4OEw2dG9CTFV3bVlHVXBZRnJna0dpd29Q?=
 =?utf-8?B?SWNKdVFCcFhLK25Sb2k2cndIcC9RVDMyR0ZYSmJpT1J6VXZpbkVSSW1QMWdQ?=
 =?utf-8?B?aXdQUnBqbWtwbUtqNGhhTEpGUGpGUEdOTnhCNzREWXhibnJOUGg0NDBZVWJM?=
 =?utf-8?B?bEVBdi9CN1BGcjdXeUNaaFNlNGhyOGlESzhNejVJVkF3Ym1PWFcvdVRUekcy?=
 =?utf-8?B?TFJiTFVlOWRxeFltQkp1dzV1Z21oMlF0c21pcEpPRVNkOHZ0ZFliUFo2SWZG?=
 =?utf-8?B?VVZvUHpWelUxcjMrNmNKOHpYVkwrQ2Z4aExjZW9iQy8wUmlEQkRFWGtFa2ps?=
 =?utf-8?B?Z0wzblZMbWhNU2VDV0xZQVdydGYyci96RS9kYlFHbDgxVllFZ3E4OU4rQnZW?=
 =?utf-8?B?MnNId1pLaFBNVWIyN0tVVTMwZEthZ2EvbW91bVMxMndVcURISWxiRlhHcWph?=
 =?utf-8?B?UDNOejRkbnlRMGRUakNhOGZLZHAxSGdyVFRlTWNTdWNRWnVnMmViZHRNN1dF?=
 =?utf-8?B?Uk94bkI0UVNlRDlqK3QyWkNsMU5Ra0RlQkIvT2E4Y29EbWJwNWFwZDV5Ykdx?=
 =?utf-8?Q?P5Q4Oz+40P/PXA2lt8Xb1W4ww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130e5224-8d97-4849-bb9c-08dd5b472a4a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 18:05:36.8436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQO8kOWQOum8dBQ63/Tpc7nsZtV5iltH+saoQzXm5xo+VeOebSZ1rCp0VIRo6HnKmB4ecZ3fB+q2XLgvE9Xf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

On 3/4/2025 12:03, Khatri, Sunil wrote:
> For new code can you please use drm_err() instead of DRM_ERROR()?
> I see drm_err is not used anywhere in amdgpu driver but display is using it. I think it would be better if I take it in a different patch to change instead. Does that sounds ok ?
> 

DRM_ERROR() doesn't give any information on a multi-GPU system which GPU 
had the problem.  drm_err() does.  So it's the preferred macro for errors.

Up to Alex and Christian if they take this as is or spin it, but I think 
it's a very simple change.

> Regards
> Sunil Khatri
> 
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>                goto free_mqd;
>> +     }
>>
>>        r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
>>        if (r) {
> 

