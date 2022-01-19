Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B992C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 14:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E303410EBA0;
	Wed, 19 Jan 2022 14:37:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3D910EB9C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 14:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU2ys7M7h6vH7nqZnBp6aZWZgS49WpOltHO9SVth8kxwunxl71viZ5Cu/bezHvq47xOmhVlwOQJD0zgYLSfV8+fA70F8LwF9f449Ve9YqEieYuqhKfWoaixVv2m0ZpqQksaGYbvWa2qxQm/a5jlb5C+JWpv79C68FIeVKvBuHLxPYVYfG49agRddlek3kr6KW2GLbNGxdtav1BrSV8iikQrK3wslHzDnbp34kinjErTRzUTcDl6fg6Y39qpL/4jDSBe2I169Fub/90TH2lMs5sMnYjDjyCUUwShmMWVYdsaeYp5MpV9EctI8qz9c0jWKsZFtkbuhj8b1Ub75TI9JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRoNmSnK5zjmGXde/ghdUWT0FUnau2J8lBX3ZWf4vnY=;
 b=BwkjPsO1mfpVa4o04YTFOp2M56kfqSGrthfh3Fe18BDHjBmihxAfHCR0VXQpUR5TpCNG+eQfHi59/X+OKQcc8qCVoS2r4ydiIqMT1K2hg/rdflS2buV61OCepMB3yQj40n0YuEYGuBqJxpLX9PTw9HtLD+jJydrajym6ytT/n4L0+FZCL6jSyA5dferKaI3xAZYYBU0mJuMN6cueif+GAbWO4ja0lNSMgPF2ZgFnKlcsMwiKprVI0pfAXfiKqU7gFhKHQMlEwhY9egn+OoV5MjNURJASWljwqspPSIaWJhR1TEdLXKgQc5wJMcurM4DVDipRCZ3EEY1Zjux8chbnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRoNmSnK5zjmGXde/ghdUWT0FUnau2J8lBX3ZWf4vnY=;
 b=FCTgy9NnFTj7zw0DcFMZkELZDmsKU62iWEyoztlYnOVLOWACji3KuJZLSMzQM7fpNgR5Ze9NY1/2hBDm8gfqn/Y6gimkCJaCrIVcqgb6dNZ87TKzAZ3dxGtf5rLtWb5y8GjKnH4WiPsLx92p2J6QCAINn/g3J7UyXwwxWVB4mG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Wed, 19 Jan
 2022 14:37:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 14:37:41 +0000
Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118120157.102453-1-christian.koenig@amd.com>
 <DM5PR12MB24692C6D246264672211B712F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <99b919b4-97df-16bc-46c2-682bc03117f4@gmail.com>
 <DM5PR12MB2469F71C6D7237AA6CC28B37F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB24693B64F61260F9F28B326DF1599@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4fce003f-e00f-d3ff-6523-fceb06df57ed@amd.com>
Date: Wed, 19 Jan 2022 15:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB24693B64F61260F9F28B326DF1599@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0148.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c19424d1-7afe-4663-a559-08d9db593f5f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13210CFE2E9C6D837CF24A8E83599@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Y4YjZ8aVzeb/8exERrxJZ8HcmuN1RQHOcoddFy51n4nUCGEcgyWNJoxlzSFxc8xHJB3+/RPJ+HAY9Jv7bRGtCO4MP/87ityaZ15Hq6cA+Xo91u4bcE6dKivRQU1lkgSNRSiSgAE4/laD6IdkMFr7Kpol49o+lcAuMmOiBTBX09ozSULM5RODjAk+u3bbgoENQxH8On6hcjPff42hTghPJN6RkT9W+LfUIX7ztq+mQSalET8lyq8TNE8vpwMcaLCFQndfkh0fQzZbiQkaZ2ciSXdzCWUxVNb+djraaXQN5VI7dNczIh3Gwiile5DOjHagb/nMPWYV87RCpz7FHX/tR5IZOS8kLAI/C6Hf+ObiJhD6dZ8SPJH3DDlyC7gUDEsCaL591n8ABzlcn5RUCQOiiKDYz9ElxqHqNuyCxYgQex0lsRfvZ2QhPVm6gy5DZig+/W0GBFGWHHNHiu7gK8PpsJ0E5KkrgbLqQKQI3gYymiAYeMocA1epIUTGbkV42YtmqdzCiy1hLPLy+AVaO7MwrwTKPi/F9LS4BP+/Umahng3069p1dzgwd7YtO87zS+k12MUAYZ0wK/Dotcuo2gU6B0ck/DJD9xlaJHGgf6DCgxCVia8skzpeBheWRodEdCENOI08zMDnQmdHZHTJCPzNi/vXQ30jYcTVwhA/1k/eMsnyduw3XoVdd/vF9rXXXfOHJJ4HY1GRAeQofKDcaPLuWy36SKItRM6kLWEB2TWyO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(36756003)(31696002)(66556008)(5660300002)(86362001)(6486002)(30864003)(38100700002)(66574015)(6666004)(6512007)(110136005)(2906002)(31686004)(2616005)(8936002)(186003)(53546011)(66946007)(83380400001)(316002)(6506007)(8676002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJtRzRSQ2IwK2JNS0grcmdBMEZoZEFiajFWTEM4alpCMnZOLzRIRXUvTjFY?=
 =?utf-8?B?ZTI4dWlvZm1wNS9aS3JPYTRta0tKTXhWM2NtaFZFYkhSWDZHQzBVY1dBZFBK?=
 =?utf-8?B?RVlNNEFPUWZiR3ZDVkVkekdzeFBJMG5pb05CQnYrM0J4aGVvaGxzejlGN0Nn?=
 =?utf-8?B?TVp5WHQ5YlFMQURObUZYY2ZscHlieUMzRytuT09PcG45WG9XeUNoVXBxNE5U?=
 =?utf-8?B?YTA5ZHdHcGNzeHZad3BUWThlMW45QW1nSndkd1FPdXBSYVRTWVkzWU5EU2xp?=
 =?utf-8?B?MEdYWnpLc1ZRNHpNNTRZbWVuSDBUakYvOGFzdWVVU1B6czF6WGNDTUxsRDdM?=
 =?utf-8?B?ektIbFFiY0FCL0M2UHZVL1BXOUFDVkEveHNOVEg0VzZoVGdIN0pBS2xHR2I0?=
 =?utf-8?B?V1poN2hUSXhueUc4T1hNZ3VJU0NLTysxUnZyWUYrd3BZaUZrNDNsMlBBeXV4?=
 =?utf-8?B?dUkwZHp1TXNuamc4Qm9PNXRza3NEOHlsWUwxV1BrTHRoQ2NjVE9KNEZiVU8y?=
 =?utf-8?B?NHNmT0xQaDhmMmJGSEc5aHVMSEw0cnAwYUd4bWNsb1d5UHRjV21Db0ljUk5G?=
 =?utf-8?B?NXJBbEZpV0luZlJqTFlRMnFUczZjazZjMGQwYktXeFNsL1dPKzlPY2lnOTlX?=
 =?utf-8?B?VkpZM25FVHpueTJSbVJrVkVmMDJ5cjVIejBtUFFzWVlwWmhQRm5qOEhTT3lB?=
 =?utf-8?B?cG00eVNzd2hwRURmTHZ0NGxTbEJ4YWlPL3Bza0ZuT3FacDJKcDFaazNHamFx?=
 =?utf-8?B?cEJjSEJsWWMyMEQ1MWsyVlR2d0RyOXFIWGF5aUI1YVZKRDUrZ3BCWklwcmhj?=
 =?utf-8?B?ZDlnMy80UnRLUEI4VXBqR1lLd214RVhUcWlndWZ0MmFKbkthTktNSGhlWlIw?=
 =?utf-8?B?SDRQQ2xjaVRSbXhrQktwaERjdG5LUm5XdkcrWnJDRlV4d1JnY2N6UEhmNTdD?=
 =?utf-8?B?Z3VnWWtkcW9LL3VMY3lud2ZyeDF0YXg5SGJCOThjbDFCRWJjK0RwK1NOWERs?=
 =?utf-8?B?T2ttVFBpVC9TWmZVa3pIV1VZMG0xSHZkVGJsZUYva1kvbDlvZ3BscmFIbFdJ?=
 =?utf-8?B?Uzg4c3lMTGFjS2RMS1hHM3QvV2VBUkhOQlBrTEFZVEdVYVBQRCtGOWlaY0pX?=
 =?utf-8?B?Z3ZrbzFpV25aZmRkbkVPb0VxNnBQejMvTlBsdzlMK211bjZtd1pYMjNuam96?=
 =?utf-8?B?SlBYcnJmOS85dGpHMk9PMHp2SkFVaUJ5NkcyTUVXZnFyWmZwNlRwSzRjc2ZP?=
 =?utf-8?B?L21INldYL2tEbkRYV0RibUpsUEdUMjgwRDMreEZzcGFUZG40OW9nRUZaYlZx?=
 =?utf-8?B?RUtXemxhWWtZY3MrRDZJV1UwUjJtY3grSzU5amllTEdUWm1RcG9mTW5PMUcv?=
 =?utf-8?B?dWtzVWgyWjVraWlQSDZSOFg3Q05ZbXN1Z1ZmaXBHeWt5NExkbFhHcGM0NGt2?=
 =?utf-8?B?YjdibGhZVVdYeEZhSGl4aGI4a0RoeUlZTWtOUTdzcmJBNTNJcGZrVmFwbEFY?=
 =?utf-8?B?aXlyaUdQdWRrd3JSUjBNL1hLcEhHMjJ6d2lVR05VQmswV3Uxa1loTjFkbU9D?=
 =?utf-8?B?cGMrN0k1V2hEZWNva0w3Y3AyYytjM3pzeTJ4VE9EUWtWdk13VEk3TS9CeldE?=
 =?utf-8?B?alRzOWhTZ0M5bldUcjRYU0N2UHRWTlNBek9ucTI1ZEJxQ2JJOUZTeTVqemdT?=
 =?utf-8?B?QVBWVkJ4eDM0c1lHUjFCdEZXWklZTm9BckNnVGVEUGVwVlh0SXVFMUhqWDFy?=
 =?utf-8?B?R25PRVF6NUYwMjJPTDBPV1c3UFhXUGpkSmdjVmQ2K05TMEsvRTZPSjFTOTZC?=
 =?utf-8?B?QVd0ZkUxRkx3RlBYT0doTkY0NXM3OEptUDROQXg4OUZEb2lOOGdTTHQzbUVN?=
 =?utf-8?B?Wm4wSENMRUZRZUgxQ0VSbzd0cCtKb1VmWERQbTUyRWltUjUzOWJNQW9EcVcx?=
 =?utf-8?B?V2V5TExRRGk1YUJnMzB6NUUzUUtuR1BaYkZGTnNvNU1RZFJvUEwxMy9ndDJK?=
 =?utf-8?B?N1IyQXBxSXBFdjFmQU9RS2Q5dzl6REVXWENKSTdocE12Z3p6aXFmRkpQZTNp?=
 =?utf-8?B?MTMvWFFjTmxnZnozK0tJUEZxZnBVRHBqVFI2RGZTR05TNkNBMGVrcEdqTi9k?=
 =?utf-8?B?NmZienRtdk1HcnFRR3liRGx4WFJzM3RxRVhOMzl1QmpZN20xaG90QXpYQ2l3?=
 =?utf-8?Q?zC4X0LMcESbWFZEOAl5HgPg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19424d1-7afe-4663-a559-08d9db593f5f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 14:37:41.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvhW31TmN+ioVgBwvtZhGz5Ix8TKKII4W3a/cGt8rJAhWyy3EnrWawNUIHpJ5Irk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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

Hi Guchun,

yes, just haven't found time to do this yet.

Regards,
Christian.

Am 19.01.22 um 15:24 schrieb Chen, Guchun:
> [Public]
>
> Hello Christian,
>
> Do you plan to submit your code to drm-next branch?
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Chen, Guchun
> Sent: Tuesday, January 18, 2022 10:22 PM
> To: 'Christian König' <ckoenig.leichtzumerken@gmail.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: remove gart.ready flag
>
> [Public]
>
> Thanks for the clarification. The patch is:
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Tuesday, January 18, 2022 10:10 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>
> Am 18.01.22 um 14:28 schrieb Chen, Guchun:
>> [Public]
>>
>> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>> -		goto skip_pin_bo;
>> -
>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>> -	if (r)
>> -		return r;
>> -
>> -skip_pin_bo:
>>
>> Does deleting skip_pin_bo path cause bo redundant pin in SRIOV case?
> Pinning/unpinning the BO was already removed as well.
>
> See Nirmoy's patches in the git log.
>
> Regards,
> Christian.
>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, January 18, 2022 8:02 PM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: [PATCH] drm/amdgpu: remove gart.ready flag
>>
>> That's just a leftover from old radeon days and was preventing CS and GART bindings before the hardware was initialized. But nowdays that is perfectly valid.
>>
>> The only thing we need to warn about are GART binding before the table is even allocated.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 35 +++-------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    | 15 ++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 +--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 77 ++++++---------------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +-
>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 11 +--
>>    drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  7 +-
>>    drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       |  8 +--
>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  8 +--
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +--
>>    drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  5 +-
>>    11 files changed, 52 insertions(+), 137 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index 645950a653a0..53cc844346f0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -150,7 +150,7 @@ void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
>>     * replaces them with the dummy page (all asics).
>>     * Returns 0 for success, -EINVAL for failure.
>>     */
>> -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>    			int pages)
>>    {
>>    	unsigned t;
>> @@ -161,13 +161,11 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>    	uint64_t flags = 0;
>>    	int idx;
>>    
>> -	if (!adev->gart.ready) {
>> -		WARN(1, "trying to unbind memory from uninitialized GART !\n");
>> -		return -EINVAL;
>> -	}
>> +	if (WARN_ON(!adev->gart.ptr))
>> +		return;
>>    
>>    	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> -		return 0;
>> +		return;
>>    
>>    	t = offset / AMDGPU_GPU_PAGE_SIZE;
>>    	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE; @@ -188,7 +186,6 @@ int
>> amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>    		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>    
>>    	drm_dev_exit(idx);
>> -	return 0;
>>    }
>>    
>>    /**
>> @@ -204,7 +201,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>     * Map the dma_addresses into GART entries (all asics).
>>     * Returns 0 for success, -EINVAL for failure.
>>     */
>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>    		    int pages, dma_addr_t *dma_addr, uint64_t flags,
>>    		    void *dst)
>>    {
>> @@ -212,13 +209,8 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>    	unsigned i, j, t;
>>    	int idx;
>>    
>> -	if (!adev->gart.ready) {
>> -		WARN(1, "trying to bind memory to uninitialized GART !\n");
>> -		return -EINVAL;
>> -	}
>> -
>>    	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> -		return 0;
>> +		return;
>>    
>>    	t = offset / AMDGPU_GPU_PAGE_SIZE;
>>    
>> @@ -230,7 +222,6 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>    		}
>>    	}
>>    	drm_dev_exit(idx);
>> -	return 0;
>>    }
>>    
>>    /**
>> @@ -246,20 +237,14 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>     * (all asics).
>>     * Returns 0 for success, -EINVAL for failure.
>>     */
>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>    		     int pages, dma_addr_t *dma_addr,
>>    		     uint64_t flags)
>>    {
>> -	if (!adev->gart.ready) {
>> -		WARN(1, "trying to bind memory to uninitialized GART !\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	if (!adev->gart.ptr)
>> -		return 0;
>> +	if (WARN_ON(!adev->gart.ptr))
>> +		return;
>>    
>> -	return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>> -			       adev->gart.ptr);
>> +	amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>> +adev->gart.ptr);
>>    }
>>    
>>    /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> index 78895413cf9f..8fea3e04e411 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> @@ -46,7 +46,6 @@ struct amdgpu_gart {
>>    	unsigned			num_gpu_pages;
>>    	unsigned			num_cpu_pages;
>>    	unsigned			table_size;
>> -	bool				ready;
>>    
>>    	/* Asic default pte flags */
>>    	uint64_t			gart_pte_flags;
>> @@ -58,12 +57,12 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);  void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);  int amdgpu_gart_init(struct amdgpu_device *adev);  void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev); -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>> -		       int pages);
>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>> -		    int pages, dma_addr_t *dma_addr, uint64_t flags,
>> -		    void *dst);
>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>> -		     int pages, dma_addr_t *dma_addr, uint64_t flags);
>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>> +			int pages);
>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>> +		     int pages, dma_addr_t *dma_addr, uint64_t flags,
>> +		     void *dst);
>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>> +		      int pages, dma_addr_t *dma_addr, uint64_t flags);
>>    void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index 9151950e0cc3..babdd915c4c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -224,26 +224,21 @@ uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>>     *
>>     * Re-init the gart for each known BO in the GTT.
>>     */
>> -int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>    {
>>    	struct amdgpu_gtt_node *node;
>>    	struct drm_mm_node *mm_node;
>>    	struct amdgpu_device *adev;
>> -	int r = 0;
>>    
>>    	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>    	spin_lock(&mgr->lock);
>>    	drm_mm_for_each_node(mm_node, &mgr->mm) {
>>    		node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
>> -		r = amdgpu_ttm_recover_gart(node->tbo);
>> -		if (r)
>> -			break;
>> +		amdgpu_ttm_recover_gart(node->tbo);
>>    	}
>>    	spin_unlock(&mgr->lock);
>>    
>>    	amdgpu_gart_invalidate_tlb(adev);
>> -
>> -	return r;
>>    }
>>    
>>    /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index b489cd8abe31..9cdb61ec669e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -246,10 +246,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>>    		dma_addr_t *dma_addr;
>>    
>>    		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
>> -		r = amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags,
>> -				    cpu_addr);
>> -		if (r)
>> -			goto error_free;
>> +		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
>>    	} else {
>>    		dma_addr_t dma_address;
>>    
>> @@ -257,11 +254,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>>    		dma_address += adev->vm_manager.vram_base_offset;
>>    
>>    		for (i = 0; i < num_pages; ++i) {
>> -			r = amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
>> -					    &dma_address, flags, cpu_addr);
>> -			if (r)
>> -				goto error_free;
>> -
>> +			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
>> +					flags, cpu_addr);
>>    			dma_address += PAGE_SIZE;
>>    		}
>>    	}
>> @@ -826,14 +820,13 @@ static void amdgpu_ttm_tt_unpin_userptr(struct
>> ttm_device *bdev,  #endif  }
>>    
>> -static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>> -				struct ttm_buffer_object *tbo,
>> -				uint64_t flags)
>> +static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>> +				 struct ttm_buffer_object *tbo,
>> +				 uint64_t flags)
>>    {
>>    	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>>    	struct ttm_tt *ttm = tbo->ttm;
>>    	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>> -	int r;
>>    
>>    	if (amdgpu_bo_encrypted(abo))
>>    		flags |= AMDGPU_PTE_TMZ;
>> @@ -841,10 +834,8 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>    	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>>    		uint64_t page_idx = 1;
>>    
>> -		r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
>> -				gtt->ttm.dma_address, flags);
>> -		if (r)
>> -			goto gart_bind_fail;
>> +		amdgpu_gart_bind(adev, gtt->offset, page_idx,
>> +				 gtt->ttm.dma_address, flags);
>>    
>>    		/* The memory type of the first page defaults to UC. Now
>>    		 * modify the memory type to NC from the second page of @@ -853,21 +844,13 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>    		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
>>    		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>>    
>> -		r = amdgpu_gart_bind(adev,
>> -				gtt->offset + (page_idx << PAGE_SHIFT),
>> -				ttm->num_pages - page_idx,
>> -				&(gtt->ttm.dma_address[page_idx]), flags);
>> +		amdgpu_gart_bind(adev, gtt->offset + (page_idx << PAGE_SHIFT),
>> +				 ttm->num_pages - page_idx,
>> +				 &(gtt->ttm.dma_address[page_idx]), flags);
>>    	} else {
>> -		r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>> -				     gtt->ttm.dma_address, flags);
>> +		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>> +				 gtt->ttm.dma_address, flags);
>>    	}
>> -
>> -gart_bind_fail:
>> -	if (r)
>> -		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>> -			  ttm->num_pages, gtt->offset);
>> -
>> -	return r;
>>    }
>>    
>>    /*
>> @@ -883,7 +866,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>>    	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>    	struct amdgpu_ttm_tt *gtt = (void*)ttm;
>>    	uint64_t flags;
>> -	int r = 0;
>> +	int r;
>>    
>>    	if (!bo_mem)
>>    		return -EINVAL;
>> @@ -930,14 +913,10 @@ static int amdgpu_ttm_backend_bind(struct
>> ttm_device *bdev,
>>    
>>    	/* bind pages into GART page tables */
>>    	gtt->offset = (u64)bo_mem->start << PAGE_SHIFT;
>> -	r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>> -		gtt->ttm.dma_address, flags);
>> -
>> -	if (r)
>> -		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>> -			  ttm->num_pages, gtt->offset);
>> +	amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>> +			 gtt->ttm.dma_address, flags);
>>    	gtt->bound = true;
>> -	return r;
>> +	return 0;
>>    }
>>    
>>    /*
>> @@ -987,12 +966,7 @@ int amdgpu_ttm_alloc_gart(struct
>> ttm_buffer_object *bo)
>>    
>>    	/* Bind pages */
>>    	gtt->offset = (u64)tmp->start << PAGE_SHIFT;
>> -	r = amdgpu_ttm_gart_bind(adev, bo, flags);
>> -	if (unlikely(r)) {
>> -		ttm_resource_free(bo, &tmp);
>> -		return r;
>> -	}
>> -
>> +	amdgpu_ttm_gart_bind(adev, bo, flags);
>>    	amdgpu_gart_invalidate_tlb(adev);
>>    	ttm_resource_free(bo, &bo->resource);
>>    	ttm_bo_assign_mem(bo, tmp);
>> @@ -1006,19 +980,16 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>     * Called by amdgpu_gtt_mgr_recover() from amdgpu_device_reset() to
>>     * rebind GTT pages during a GPU reset.
>>     */
>> -int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>    {
>>    	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>    	uint64_t flags;
>> -	int r;
>>    
>>    	if (!tbo->ttm)
>> -		return 0;
>> +		return;
>>    
>>    	flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm, tbo->resource);
>> -	r = amdgpu_ttm_gart_bind(adev, tbo, flags);
>> -
>> -	return r;
>> +	amdgpu_ttm_gart_bind(adev, tbo, flags);
>>    }
>>    
>>    /*
>> @@ -1032,7 +1003,6 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,  {
>>    	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>    	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>> -	int r;
>>    
>>    	/* if the pages have userptr pinning then clear that first */
>>    	if (gtt->userptr) {
>> @@ -1052,10 +1022,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>>    		return;
>>    
>>    	/* unbind shouldn't be done for GDS/GWS/OA in ttm_bo_clean_mm */
>> -	r = amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>> -	if (r)
>> -		DRM_ERROR("failed to unbind %u pages at 0x%08llX\n",
>> -			  gtt->ttm.num_pages, gtt->offset);
>> +	amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>    	gtt->bound = false;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 084aa49e627d..d9691f262f16 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -119,7 +119,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device
>> *adev);
>>    
>>    bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>> uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr); -int
>> amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>    
>>    uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>>    
>> @@ -162,7 +162,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>    			struct dma_fence **fence);
>>    
>>    int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo); -int
>> amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>    uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev,
>> uint32_t type);
>>    
>>    #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 4f8d356f8432..867c94a1a81a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -1000,14 +1000,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>>    		return -EINVAL;
>>    	}
>>    
>> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>> -		goto skip_pin_bo;
>> -
>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>> -	if (r)
>> -		return r;
>> -
>> -skip_pin_bo:
>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>    	r = adev->gfxhub.funcs->gart_enable(adev);
>>    	if (r)
>>    		return r;
>> @@ -1033,8 +1026,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>>    		 (unsigned)(adev->gmc.gart_size >> 20),
>>    		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
>>    
>> -	adev->gart.ready = true;
>> -
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index cd6c38e083d0..3baece11d74e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -469,16 +469,14 @@ static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)  {
>>    	uint64_t table_addr;
>> -	int r, i;
>>    	u32 field;
>> +	int i;
>>    
>>    	if (adev->gart.bo == NULL) {
>>    		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>    		return -EINVAL;
>>    	}
>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>> -	if (r)
>> -		return r;
>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>    
>>    	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>    
>> @@ -558,7 +556,6 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
>>    	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>    		 (unsigned)(adev->gmc.gart_size >> 20),
>>    		 (unsigned long long)table_addr);
>> -	adev->gart.ready = true;
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index ab8adbff9e2d..cf83f8c258f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -613,17 +613,14 @@ static void gmc_v7_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)  {
>>    	uint64_t table_addr;
>> -	int r, i;
>>    	u32 tmp, field;
>> +	int i;
>>    
>>    	if (adev->gart.bo == NULL) {
>>    		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>    		return -EINVAL;
>>    	}
>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>> -	if (r)
>> -		return r;
>> -
>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>    	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>    
>>    	/* Setup TLB control */
>> @@ -712,7 +709,6 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>>    	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>    		 (unsigned)(adev->gmc.gart_size >> 20),
>>    		 (unsigned long long)table_addr);
>> -	adev->gart.ready = true;
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 054733838292..7cc7c8001734 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -837,17 +837,14 @@ static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)  {
>>    	uint64_t table_addr;
>> -	int r, i;
>>    	u32 tmp, field;
>> +	int i;
>>    
>>    	if (adev->gart.bo == NULL) {
>>    		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>    		return -EINVAL;
>>    	}
>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>> -	if (r)
>> -		return r;
>> -
>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>    	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>    
>>    	/* Setup TLB control */
>> @@ -953,7 +950,6 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>>    	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>    		 (unsigned)(adev->gmc.gart_size >> 20),
>>    		 (unsigned long long)table_addr);
>> -	adev->gart.ready = true;
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index c76ffd1a70cd..9f71f810c2f8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1783,14 +1783,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>>    		return -EINVAL;
>>    	}
>>    
>> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>> -		goto skip_pin_bo;
>> -
>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>> -	if (r)
>> -		return r;
>> -
>> -skip_pin_bo:
>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>    	r = adev->gfxhub.funcs->gart_enable(adev);
>>    	if (r)
>>    		return r;
>> @@ -1807,7 +1800,6 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>>    	DRM_INFO("PTB located at 0x%016llX\n",
>>    			(unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
>>    
>> -	adev->gart.ready = true;
>>    	return 0;
>>    }
>>    
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index d5d2cf2ee788..88db82b3d443 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -86,10 +86,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring,
>> uint64_t npages,
>>    
>>    	cpu_addr = &job->ibs[0].ptr[num_dw];
>>    
>> -	r = amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>> -	if (r)
>> -		goto error_free;
>> -
>> +	amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>    	r = amdgpu_job_submit(job, &adev->mman.entity,
>>    			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>>    	if (r)
>> --
>> 2.25.1

