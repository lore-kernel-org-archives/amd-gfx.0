Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1756DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 15:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F41A10E029;
	Mon,  7 Mar 2022 15:59:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31C910E029
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 15:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCvzjIomo5KQ97NS+LDzLaEYESJf4iElvhCnVl0Y02Kx4jAnG327OnNYS8bJGWWUn5aIuVYyobUQOigY53fpdSt0Gl6dQpcoNF5Qj5NLeYrT7cTkbFzksPxpByLQf4N1H9KWsSNnbbNy/JvB6hwI2pBMq41PKDzqoh0vQzPtDWt0X6chDqrsSP8tkCsZ+6F5ReNJA39HSH0JOwOvCqBws4ogDzwT2mbFCu3ChP6NZL1OYMfbIvH0q6Jd8dr9MUSQBEob13MepfYtszktMu6fP/W5/6QJU4umW3bb7d5R21lDeNQHI4PD5nzQlrVwB1Bx4Cb8UHn4dvOZe4BL2Eg1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRmcYHUNIUf6wsQdgjBa83s7eqFTWwlLNZu7kOG9/tI=;
 b=hZDBAFyf3+X3WuFxfj4J83tEnYJCfoMK+didE5hXu4PFd/674JVGxJYTlroyadwgqXRhcqQ/RyfAJXoDqcU3P8EmYzIOY0pol5iGUGdaLq+zBobGBjVme8eTivbwVmlodKXoJUxpB13Dhcoci99a87yOrbaJxE/rws+YJhgU/r87KIlWrajmI7dEi3FLMzM73bB64xSQFK6x0NDTigHUaKapS1DpqwvhMPlGVIbBom3P/UXsGU9kPAhlBBR7XkxTlOgxokyQWrSbxpoNI1gyJqQ+zBjm/qCeNqyc0KCrdjqzCPzQnOpi32ICxRYJ7fJUPzuem7INY1Hx2AzzYv8twQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRmcYHUNIUf6wsQdgjBa83s7eqFTWwlLNZu7kOG9/tI=;
 b=mhaFeUk0MWyLl9KB/miuEtS+IYc4Js3CxtWZSd6wuPvDKWPkuzGqVo6M019DXMgvnYyx8OTSV3XopFxY5md9UI0wxHGhbrutups1lVsQta1yvVBCGNJLPiyjg0vBvagyt9qQQ2IYkhY9ubo2FQehYb9j1AhqxDHYg2DY4UlMEz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 15:59:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 15:59:46 +0000
Content-Type: multipart/alternative;
 boundary="------------Ngw3hGx5OSrGaRlp7esPNnuO"
Message-ID: <dd6839eb-da19-30fd-1422-6b0aba326e7f@amd.com>
Date: Mon, 7 Mar 2022 16:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-10-christian.koenig@amd.com>
 <9bf49ccf-09a9-15d5-5591-ee2164c07f3c@amd.com>
 <5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com>
 <6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com>
X-ClientProxiedBy: AM6P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::45) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f6a0ad0-a3ae-429a-8090-08da0053800c
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5663:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB56635A3821A153F47E95A80783089@SJ0PR12MB5663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i76414BMUyeMYzURVgu6biCsPealuUMoTeruPZ1D19nMIK93iPcaz+5+e+uUXD4bbVJC97M0TQuwHOOLKFaKah4tPgMB8KigjmVUGQdVebUxR82iKU4hG+Zbm5GitD0KvNbgG0vpxE8Y1/nTD9kMFGXJuKfzWuejT7lkjgUBNAmPgF+nOSrL0kdmewaV8A0oWmz5iiwusiDj36g/niKi/Kd6gSCj17rk0O4tVvpHBM1Nci8NL2PK3k9f0L+Rbqy1C/FeI/Cdl+wEyXtdzwl2zwyAVDuPhXAfeGC0fVAJp62/rHn2nlqKr5sfdM1bERnC/MhucgE0tW/IXdcbchtwC5euWv6edxRqklthNernZX6Ig1UpW6Uvme0uQ/fINOw8EFV89dJk9ln8uUvyECfZiJVElnSePyoU6G83hZ3c/Bl+/+I4R4Q5U2GdxcdD4hWfRtYgQOHtwO7LvGrZb1pr/fhKZys8D/ASLUP5L4bITsvcSkC9SoIOlid1ADz9ZSAIy3O4udM9F1bSlxNGoBbZ4VQZOwDw635M1jau6sBi65yVgVA0mq+Ba3F9o9CEwjflDqj4FTsmaBylCaEAzmWEHScYj3oa08YEqqO+bo489wLZOzpFfKix57PvfZjFQZvEOrdTH7I+9toTsrcTBD2UvBaKdc3lVHagjfaB2zgarFdgktxApGZoDKU1eA7Tuz3Hb1rRULqxk6yzx5n6qWHwKHdefWcVplnfuFGYYT5/Z5AULtyDusaZsY7g6i5BNHmx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(316002)(6636002)(31686004)(508600001)(6486002)(36756003)(66574015)(6506007)(110136005)(186003)(8936002)(6666004)(33964004)(30864003)(2906002)(6512007)(8676002)(5660300002)(38100700002)(2616005)(66556008)(83380400001)(66946007)(31696002)(66476007)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdQcjd6UXRCL09DcTYxcURrN2VEaHVGWWNxbWJIQzZuOWxiL0YyR29odUZI?=
 =?utf-8?B?WHloVjRKVUl4ZlIwenNpWjZIdHpUVVJ1VFpWRHl5ZExvZXh5NEVoVWF5OUtH?=
 =?utf-8?B?VUpQNGEybWlxYmtqenE4ODFkSzZPd2UrYXNuZ3FiV2x1WVR2aDRXVFN6OTh2?=
 =?utf-8?B?T1NIVjlVNDY4N05vWm9VODc1cTd5ZWdVaVhZSlFETVo3RCt5WlE4SzlIK1VG?=
 =?utf-8?B?Um9Va3hjNGEyU1VhcEZ5dDE1cVdlbDJxenhxSEZtN0l5UGhtTjlTYWVvUGtq?=
 =?utf-8?B?b2NxZDZFRjJmQTJpQllqc1lwZzBhTS9hZ3ZhNWNsa0hMYlFsWGVXYUdSZHZC?=
 =?utf-8?B?cTAyOXBVYzc5MmdodjBJa1dVQytEWUJ3WW9HaDQ3SVlaNGFjb25FYkRPNnE0?=
 =?utf-8?B?cWVwWTdCTXN0dVM3NG9qeVFxUGdVWmFYWkJJVFEzZnZENHNoTFVTYjlHQUVr?=
 =?utf-8?B?WDRlc3QvR1FVKzh2SzRwK3d5S1FsOWdwUEo1Qy93ajN6TFY3QXdENCsxQ21D?=
 =?utf-8?B?ajFhYnJjVTM5NmpEeEZnMTNPb2wvQVdYc3UwZGt2cCtES255ZGZ4RUpVTjA0?=
 =?utf-8?B?bDc0aDR3eVRyajBrVkhzRjQvanB5RUw4VGJqdmh3NFZ0a3dHS3ZFdGFGUGN3?=
 =?utf-8?B?MnVXVzlTZXdDL0d5cmdQaSs1dWZmbTNIMGsranlUY0pGcGRzSWhuNnBLdUhS?=
 =?utf-8?B?Qmw0ZzducHFrVmhsSWg1ZlFRSHRHRGx0Z1lHOVJlSE45TDFYejBnb1FXL2M4?=
 =?utf-8?B?bWcvc2xMa25GOHVLeWE5YVR5R1d2eTBJM2IzMjNIcG4xMExWTm1FODhQUVMv?=
 =?utf-8?B?dHpLMjUvRTdDclRlc05mL1dIeWpUN1hmNHZ0QTFNSjNDdGc0SmQ2QnlFSHEv?=
 =?utf-8?B?Z1RuZStmMDE3LzRSQ3JFV3NSdWE1MW9DWDZsSmtrUllGNHZhRkhhcGZIbVRI?=
 =?utf-8?B?UXZTZUFTRzNlaVU2cWYxUCtWeStaT0xEYXAyWGZXMExEczVsaDZRbm54dmpi?=
 =?utf-8?B?TkpsZG9abFZKWnhRUks2QUVOdUZRQzRpTDIvYytoc2dtSHA2VnFWRUxPQjFp?=
 =?utf-8?B?b21JMWlsRVhwT2JMSSttd2VVZmdXcGtTZnVNeVJuMzhLU2lvRjBTMnQxVnJr?=
 =?utf-8?B?RFlpdWRpQm05YVYrdjNqUUdlenVuc2xaUTNkK2lBQXVlWHhBbXFFdldZNTlr?=
 =?utf-8?B?TmozTnc2dG5wV1dhd0IxZU5DSVhCU3BPRXAxMDJuSzRSWU1hekk4Y0Y1eEk1?=
 =?utf-8?B?Yk5uaUl3M3VmRlNmOEVZQkhPeDlkeEJlbldENUF1MjBBdjlSak5WSXFRcVdk?=
 =?utf-8?B?QkRlbSsreXkwWUdobEJCbzBoM2RMUmliZmhNQW9oK2xjcU8vOTJUc1lDOEVC?=
 =?utf-8?B?ditPOXVhN3hhSTJVSmxVLzZScGFWVkNHV1g4bGsxdmRhQWMwa2tyd0Naamgr?=
 =?utf-8?B?TUpONWgzcE52VVhzK2lvMlcyQkt1WUw4d0hOSlB2M3d5dFhINVpGMjJhdlI5?=
 =?utf-8?B?cXRPMFhpK0JqSlpDOUJSWDV3dUpZNVRBcUNnQUlwbkxSaEdlSC9ZUHA1d1pu?=
 =?utf-8?B?Mmc4T00zYmU5cVBHVU1rY0xlVnZEMVZkZGwydExtUEg1RzhudkdIc3h1cHY3?=
 =?utf-8?B?YWd4ajArU1lqQ3l2OEx2d1FYZTlWOWE4ZjJTZm5CdTFjemxMQ1Z2Q045MmFk?=
 =?utf-8?B?UkRiUzg5NzFjRHl1cVNpM3gybW4yUExNMUdUd1h0aWJLdkFvUDhBbSs1WFpi?=
 =?utf-8?B?RnAwalB0U256eEpPbXNSeEFOSWJCY0Q4bVNtRDNGcWQ2djVPa2ZCdFpGTjN1?=
 =?utf-8?B?dTVEM3BIUllzQWZFUVdHTEtzQndlbUFZK2lmUFlLeUFrTWE5RytPOFdEVnY2?=
 =?utf-8?B?TzRRc29YTXhHcXJDVmJ0cGZZdjUwVkJwNy9oY1Zja0J3RC9qWnhpc1ZnZFVP?=
 =?utf-8?B?L1FQYjhwVkpidm9xeDE2OU9zNG00dXpDUHJkVVZLUjRwemE0YkQrcC9scDZH?=
 =?utf-8?B?MGFqRUlBMi9UbmhKa05rczdiZnVxYWp1TXRrdmJqWVlnQjZjWXNTVXpxTCtW?=
 =?utf-8?B?WitVVFRCWGxVU3g1WjRSZ3lNS0dhcHJHSDU2L1pHYi80Qi9QWGtRckF6eDhP?=
 =?utf-8?B?ODZINTdudFlhUUJMRFVBSlV1QkRoQVV4SWc0VjlPNVIzbkhHU1FWSi83R1JF?=
 =?utf-8?Q?Iz1IvbDI39YFEji8OTQzDEE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6a0ad0-a3ae-429a-8090-08da0053800c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 15:59:45.9747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gkYOysInbJRU2ets0a96iNSIrYvKcGt2m7qw4hQUxfPmXoQfCBJBneKSwoM7dOW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

--------------Ngw3hGx5OSrGaRlp7esPNnuO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.03.22 um 16:40 schrieb Andrey Grodzovsky:
>
> On 2022-03-05 13:40, Christian König wrote:
>
>> Am 04.03.22 um 18:10 schrieb Andrey Grodzovsky:
>>>
>>> On 2022-03-03 03:23, Christian König wrote:
>>>> Allows submitting jobs as gang which needs to run on multiple
>>>> engines at the same time.
>>>>
>>>> Basic idea is that we have a global gang submit fence representing 
>>>> when the
>>>> gang leader is finally pushed to run on the hardware last.
>>>>
>>>> Jobs submitted as gang are never re-submitted in case of a GPU 
>>>> reset since this
>>>> won't work and will just deadlock the hardware immediately again.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 
>>>> ++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
>>>>   4 files changed, 66 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 7f447ed7a67f..a664d43d7502 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -852,6 +852,7 @@ struct amdgpu_device {
>>>>       u64                fence_context;
>>>>       unsigned            num_rings;
>>>>       struct amdgpu_ring        *rings[AMDGPU_MAX_RINGS];
>>>> +    struct dma_fence __rcu        *gang_submit;
>>>>       bool                ib_pool_ready;
>>>>       struct amdgpu_sa_manager ib_pools[AMDGPU_IB_POOL_MAX];
>>>>       struct amdgpu_sched 
>>>> gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
>>>> @@ -1233,6 +1234,8 @@ void amdgpu_device_invalidate_hdp(struct 
>>>> amdgpu_device *adev,
>>>>           struct amdgpu_ring *ring);
>>>>     void amdgpu_device_halt(struct amdgpu_device *adev);
>>>> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device 
>>>> *adev,
>>>> +                        struct dma_fence *gang);
>>>>     /* atpx handler */
>>>>   #if defined(CONFIG_VGA_SWITCHEROO)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index d78141e2c509..a116b8c08827 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3512,6 +3512,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>       adev->gmc.gart_size = 512 * 1024 * 1024;
>>>>       adev->accel_working = false;
>>>>       adev->num_rings = 0;
>>>> +    RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>>>>       adev->mman.buffer_funcs = NULL;
>>>>       adev->mman.buffer_funcs_ring = NULL;
>>>>       adev->vm_manager.vm_pte_funcs = NULL;
>>>> @@ -3989,6 +3990,7 @@ void amdgpu_device_fini_sw(struct 
>>>> amdgpu_device *adev)
>>>>       release_firmware(adev->firmware.gpu_info_fw);
>>>>       adev->firmware.gpu_info_fw = NULL;
>>>>       adev->accel_working = false;
>>>> + dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
>>>>         amdgpu_reset_fini(adev);
>>>>   @@ -5744,3 +5746,35 @@ void amdgpu_device_halt(struct 
>>>> amdgpu_device *adev)
>>>>       pci_disable_device(pdev);
>>>>       pci_wait_for_pending_transaction(pdev);
>>>>   }
>>>> +
>>>> +/**
>>>> + * amdgpu_device_switch_gang - switch to a new gang
>>>> + * @adev: amdgpu_device pointer
>>>> + * @gang: the gang to switch to
>>>> + *
>>>> + * Try to switch to a new gang or return a reference to the 
>>>> current gang if that
>>>> + * isn't possible.
>>>> + * Returns: Either NULL if we switched correctly or a reference to 
>>>> the existing
>>>> + * gang.
>>>> + */
>>>> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device 
>>>> *adev,
>>>> +                        struct dma_fence *gang)
>>>> +{
>>>> +    struct dma_fence *old = NULL;
>>>> +
>>>> +    do {
>>>> +        dma_fence_put(old);
>>>> +        old = dma_fence_get_rcu_safe(&adev->gang_submit);
>>>> +
>>>> +        if (old == gang)
>>>> +            break;
>>>> +
>>>> +        if (!dma_fence_is_signaled(old))
>>>> +            return old;
>>>> +
>>>> +    } while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>>>> +             old, gang) != old);
>>>> +
>>>> +    dma_fence_put(old);
>>>> +    return NULL;
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index e07ceae36a5c..059e11c7898c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -169,11 +169,29 @@ static void amdgpu_job_free_cb(struct 
>>>> drm_sched_job *s_job)
>>>>           kfree(job);
>>>>   }
>>>>   +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>>> +                struct amdgpu_job *leader)
>>>> +{
>>>> +    struct dma_fence *fence = &leader->base.s_fence->scheduled;
>>>> +
>>>> +    WARN_ON(job->gang_submit);
>>>> +
>>>> +    /*
>>>> +     * Don't add a reference when we are the gang leader to avoid 
>>>> circle
>>>> +     * dependency.
>>>> +     */
>>>> +    if (job != leader)
>>>> +        dma_fence_get(fence);
>>>> +    job->gang_submit = fence;
>>>> +}
>>>> +
>>>>   void amdgpu_job_free(struct amdgpu_job *job)
>>>>   {
>>>>       amdgpu_job_free_resources(job);
>>>>       amdgpu_sync_free(&job->sync);
>>>>       amdgpu_sync_free(&job->sched_sync);
>>>> +    if (job->gang_submit != &job->base.s_fence->scheduled)
>>>> +        dma_fence_put(job->gang_submit);
>>>>         /* only put the hw fence if has embedded fence */
>>>>       if (job->hw_fence.ops != NULL)
>>>> @@ -247,12 +265,16 @@ static struct dma_fence 
>>>> *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>>>>           fence = amdgpu_sync_get_fence(&job->sync);
>>>>       }
>>>>   +    if (!fence && !job->gang_submit)
>>>> +        fence = amdgpu_device_switch_gang(ring->adev, 
>>>> job->gang_submit);
>>>> +
>>>
>>>
>>> Why job->gang_submit should be NULL in the check above ? Don't you 
>>> want to switch to an actual new gang fence here ?
>>> Jobs that don't have gang_submit fence set are not gang jobs anyway 
>>> and we don't care for this dependency
>>> for them right ?
>>
>> Well exactly that's the point. That a job is not part of a gang 
>> submit is signaled by setting the pointer to NULL.
>
>
> No dispute on this
>
>
>>
>> If we don't check for NULL here we would just crash.
>
>
> But you go into the 'if clause' if job->gang_submit is equal to NULL, 
> i would expect to see here
> if (!fence &&*job->gang_submit*) because you want to switch to an 
> actual new gang (not to NULL)
>

WTF? I'm like 100% that I've fixed that before sending it out.

Thanks for point it out, but yeah I've already stumbled over that typo 
as well.

Christian.

> Andrey
>
>
>>
>> Christian.
>>
>>>
>>> Andrey
>>>
>>>
>>>>       return fence;
>>>>   }
>>>>     static struct dma_fence *amdgpu_job_run(struct drm_sched_job 
>>>> *sched_job)
>>>>   {
>>>>       struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>       struct dma_fence *fence = NULL, *finished;
>>>>       struct amdgpu_job *job;
>>>>       int r = 0;
>>>> @@ -264,8 +286,10 @@ static struct dma_fence *amdgpu_job_run(struct 
>>>> drm_sched_job *sched_job)
>>>>         trace_amdgpu_sched_run_job(job);
>>>>   -    if (job->vram_lost_counter != 
>>>> atomic_read(&ring->adev->vram_lost_counter))
>>>> -        dma_fence_set_error(finished, -ECANCELED);/* skip IB as 
>>>> well if VRAM lost */
>>>> +    /* Skip job if VRAM is lost and never resubmit gangs */
>>>> +    if (job->vram_lost_counter != 
>>>> atomic_read(&adev->vram_lost_counter) ||
>>>> +        (job->job_run_counter && job->gang_submit))
>>>> +        dma_fence_set_error(finished, -ECANCELED);
>>>>         if (finished->error < 0) {
>>>>           DRM_INFO("Skip scheduling IBs!\n");
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> index 0bab8fe0d419..615328130615 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> @@ -51,6 +51,7 @@ struct amdgpu_job {
>>>>       struct amdgpu_sync    sched_sync;
>>>>       struct dma_fence    hw_fence;
>>>>       struct dma_fence    *external_hw_fence;
>>>> +    struct dma_fence    *gang_submit;
>>>>       uint32_t        preamble_status;
>>>>       uint32_t                preemption_status;
>>>>       bool                    vm_needs_flush;
>>>> @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device 
>>>> *adev, unsigned size,
>>>>   void amdgpu_job_set_resources(struct amdgpu_job *job, struct 
>>>> amdgpu_bo *gds,
>>>>                     struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>>>>   void amdgpu_job_free_resources(struct amdgpu_job *job);
>>>> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>>> +                struct amdgpu_job *leader);
>>>>   void amdgpu_job_free(struct amdgpu_job *job);
>>>>   int amdgpu_job_submit(struct amdgpu_job *job, struct 
>>>> drm_sched_entity *entity,
>>>>                 void *owner, struct dma_fence **f);
>>

--------------Ngw3hGx5OSrGaRlp7esPNnuO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 07.03.22 um 16:40 schrieb Andrey Grodzovsky:<br>
    <blockquote type="cite" cite="mid:6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com">
      
      <p>On 2022-03-05 13:40, Christian König wrote:<br>
      </p>
      <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com">Am
        04.03.22 um 18:10 schrieb Andrey Grodzovsky: <br>
        <blockquote type="cite"> <br>
          On 2022-03-03 03:23, Christian König wrote: <br>
          <blockquote type="cite">Allows submitting jobs as gang which
            needs to run on multiple <br>
            engines at the same time. <br>
            <br>
            Basic idea is that we have a global gang submit fence
            representing when the <br>
            gang leader is finally pushed to run on the hardware last. <br>
            <br>
            Jobs submitted as gang are never re-submitted in case of a
            GPU reset since this <br>
            won't work and will just deadlock the hardware immediately
            again. <br>
            <br>
            Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
            <br>
            --- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++ <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34
            ++++++++++++++++++++++ <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp; | 28
            ++++++++++++++++-- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++ <br>
            &nbsp; 4 files changed, 66 insertions(+), 2 deletions(-) <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            index 7f447ed7a67f..a664d43d7502 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            @@ -852,6 +852,7 @@ struct amdgpu_device { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence_context; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_rings; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rings[AMDGPU_MAX_RINGS]; <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence __rcu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gang_submit; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_pool_ready; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sa_manager&nbsp;&nbsp;&nbsp;
            ib_pools[AMDGPU_IB_POOL_MAX]; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sched
            gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX]; <br>
            @@ -1233,6 +1234,8 @@ void
            amdgpu_device_invalidate_hdp(struct amdgpu_device *adev, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring); <br>
            &nbsp; &nbsp; void amdgpu_device_halt(struct amdgpu_device *adev); <br>
            +struct dma_fence *amdgpu_device_switch_gang(struct
            amdgpu_device *adev, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *gang); <br>
            &nbsp; &nbsp; /* atpx handler */ <br>
            &nbsp; #if defined(CONFIG_VGA_SWITCHEROO) <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
            index d78141e2c509..a116b8c08827 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
            @@ -3512,6 +3512,7 @@ int amdgpu_device_init(struct
            amdgpu_device *adev, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.gart_size = 512 * 1024 * 1024; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working = false; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;num_rings = 0; <br>
            +&nbsp;&nbsp;&nbsp; RCU_INIT_POINTER(adev-&gt;gang_submit,
            dma_fence_get_stub()); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.buffer_funcs = NULL; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.buffer_funcs_ring = NULL; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_pte_funcs = NULL; <br>
            @@ -3989,6 +3990,7 @@ void amdgpu_device_fini_sw(struct
            amdgpu_device *adev) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;firmware.gpu_info_fw); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.gpu_info_fw = NULL; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working = false; <br>
            +
            dma_fence_put(rcu_dereference_protected(adev-&gt;gang_submit,
            true)); <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_fini(adev); <br>
            &nbsp; @@ -5744,3 +5746,35 @@ void amdgpu_device_halt(struct
            amdgpu_device *adev) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_disable_device(pdev); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_wait_for_pending_transaction(pdev); <br>
            &nbsp; } <br>
            + <br>
            +/** <br>
            + * amdgpu_device_switch_gang - switch to a new gang <br>
            + * @adev: amdgpu_device pointer <br>
            + * @gang: the gang to switch to <br>
            + * <br>
            + * Try to switch to a new gang or return a reference to the
            current gang if that <br>
            + * isn't possible. <br>
            + * Returns: Either NULL if we switched correctly or a
            reference to the existing <br>
            + * gang. <br>
            + */ <br>
            +struct dma_fence *amdgpu_device_switch_gang(struct
            amdgpu_device *adev, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *gang) <br>
            +{ <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence *old = NULL; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; do { <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(old); <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old =
            dma_fence_get_rcu_safe(&amp;adev-&gt;gang_submit); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old == gang) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dma_fence_is_signaled(old)) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return old; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; } while (cmpxchg((struct dma_fence __force
            **)&amp;adev-&gt;gang_submit, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old, gang) != old); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; dma_fence_put(old); <br>
            +&nbsp;&nbsp;&nbsp; return NULL; <br>
            +} <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c <br>
            index e07ceae36a5c..059e11c7898c 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c <br>
            @@ -169,11 +169,29 @@ static void amdgpu_job_free_cb(struct
            drm_sched_job *s_job) <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(job); <br>
            &nbsp; } <br>
            &nbsp; +void amdgpu_job_set_gang_leader(struct amdgpu_job *job, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *leader) <br>
            +{ <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence *fence =
            &amp;leader-&gt;base.s_fence-&gt;scheduled; <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;gang_submit); <br>
            + <br>
            +&nbsp;&nbsp;&nbsp; /* <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * Don't add a reference when we are the gang leader to
            avoid circle <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * dependency. <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
            +&nbsp;&nbsp;&nbsp; if (job != leader) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_get(fence); <br>
            +&nbsp;&nbsp;&nbsp; job-&gt;gang_submit = fence; <br>
            +} <br>
            + <br>
            &nbsp; void amdgpu_job_free(struct amdgpu_job *job) <br>
            &nbsp; { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_job_free_resources(job); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(&amp;job-&gt;sync); <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(&amp;job-&gt;sched_sync); <br>
            +&nbsp;&nbsp;&nbsp; if (job-&gt;gang_submit !=
            &amp;job-&gt;base.s_fence-&gt;scheduled) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(job-&gt;gang_submit); <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only put the hw fence if has embedded fence */ <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hw_fence.ops != NULL) <br>
            @@ -247,12 +265,16 @@ static struct dma_fence
            *amdgpu_job_dependency(struct drm_sched_job *sched_job, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence = amdgpu_sync_get_fence(&amp;job-&gt;sync);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; if (!fence &amp;&amp; !job-&gt;gang_submit) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence = amdgpu_device_switch_gang(ring-&gt;adev,
            job-&gt;gang_submit); <br>
            + <br>
          </blockquote>
          <br>
          <br>
          Why job-&gt;gang_submit should be NULL in the check above ?
          Don't you want to switch to an actual new gang fence here ? <br>
          Jobs that don't have gang_submit fence set are not gang jobs
          anyway and we don't care for this dependency <br>
          for them right ? <br>
        </blockquote>
        <br>
        Well exactly that's the point. That a job is not part of a gang
        submit is signaled by setting the pointer to NULL. <br>
      </blockquote>
      <p><br>
      </p>
      <p>No dispute on this</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com"> <br>
        If we don't check for NULL here we would just crash. <br>
      </blockquote>
      <p><br>
      </p>
      <p>But you go into the 'if clause' if job-&gt;gang_submit is equal
        to NULL, i would expect to see here<br>
        if (!fence &amp;&amp;<b> job-&gt;gang_submit</b>) because you
        want to switch to an actual new gang (not to NULL)<br>
      </p>
    </blockquote>
    <br>
    WTF? I'm like 100% that I've fixed that before sending it out.<br>
    <br>
    Thanks for point it out, but yeah I've already stumbled over that
    typo as well.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com">
      <p> </p>
      <p>Andrey</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com"> <br>
        Christian. <br>
      </blockquote>
      <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com"> <br>
        <blockquote type="cite"> <br>
          Andrey <br>
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return fence; <br>
            &nbsp; } <br>
            &nbsp; &nbsp; static struct dma_fence *amdgpu_job_run(struct
            drm_sched_job *sched_job) <br>
            &nbsp; { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
            to_amdgpu_ring(sched_job-&gt;sched); <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = ring-&gt;adev; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence = NULL, *finished; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0; <br>
            @@ -264,8 +286,10 @@ static struct dma_fence
            *amdgpu_job_run(struct drm_sched_job *sched_job) <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_sched_run_job(job); <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (job-&gt;vram_lost_counter !=
            atomic_read(&amp;ring-&gt;adev-&gt;vram_lost_counter)) <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(finished, -ECANCELED);/* skip
            IB as well if VRAM lost */ <br>
            +&nbsp;&nbsp;&nbsp; /* Skip job if VRAM is lost and never resubmit gangs */
            <br>
            +&nbsp;&nbsp;&nbsp; if (job-&gt;vram_lost_counter !=
            atomic_read(&amp;adev-&gt;vram_lost_counter) || <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (job-&gt;job_run_counter &amp;&amp;
            job-&gt;gang_submit)) <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(finished, -ECANCELED); <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (finished-&gt;error &lt; 0) { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Skip scheduling IBs!\n&quot;); <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
            index 0bab8fe0d419..615328130615 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
            @@ -51,6 +51,7 @@ struct amdgpu_job { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sync&nbsp;&nbsp;&nbsp; sched_sync; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; hw_fence; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *external_hw_fence; <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *gang_submit; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preamble_status; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preemption_status; <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_needs_flush; <br>
            @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct
            amdgpu_device *adev, unsigned size, <br>
            &nbsp; void amdgpu_job_set_resources(struct amdgpu_job *job,
            struct amdgpu_bo *gds, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *gws, struct amdgpu_bo
            *oa); <br>
            &nbsp; void amdgpu_job_free_resources(struct amdgpu_job *job); <br>
            +void amdgpu_job_set_gang_leader(struct amdgpu_job *job, <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *leader); <br>
            &nbsp; void amdgpu_job_free(struct amdgpu_job *job); <br>
            &nbsp; int amdgpu_job_submit(struct amdgpu_job *job, struct
            drm_sched_entity *entity, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner, struct dma_fence **f); <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------Ngw3hGx5OSrGaRlp7esPNnuO--
