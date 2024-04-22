Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF429C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D071129E5;
	Mon, 22 Apr 2024 11:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SyNARnAf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0B01129E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3nPMoRzm6jI6SLdu4aJaRw53E2C3S+lw0fpq6Sx0vFpuab2KoRASoGoRtvXCRBiQfmxo3FOtC1ryBrg6bvmvAyqSl1z+OLG5p3EtnYrtArFp4K1yJCKbLVasgffHBVnHRLILtcxI+cZK4zGjDHpBEUV0Q6yijiwzTdbRCSQGDMNhQMQ/NHzoMAk8bb5cS5LX8C21J3N1Lse19wYAR4J612UzW3biFPdUWlSuYbiUSLpIkCmO2HtuQbkVKJGmehsU/okF13J30GqDRLO1+OHfi7YSBk6mLbz4+D79a7SkLrGXrFxCeA1zBkwYJwC9MurQQGtb89ZEG6YkzrHmAhbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI44sxoM0fWmdoLLsq1/ZpzrsG1BpC9MGQb+bVW9acI=;
 b=S8aWv1vf0t2E4hfBu21wgAtyVcnZhTgAp9JzeixQl0PMoiIa5U89GO9NJrhSsiZaLeA86Z+AqelB5rj3zMGX+d/Jjr1+8f3v8rNpw0IMWHR8IgyJLZhblr0XlnFI4BkRWsHGvlFNmh5Q/pB7f05ajm9opjwNqw4iHxFqIVDR05VQxay4Baf0LT8OCL2UE/45/x0veZlTFNxYVKLzY7YRhtW3OkrbUYEFcK/kF+UI2NecsNCWUPgwKNEkLIkXJKdJ99WZYpNwgzzJT+HD86LhsYec5PChJEutGHuMM2rE7duGzjnF1lhrN2HUb3elZahLkAhSAHT+2W9pvev8lPrHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI44sxoM0fWmdoLLsq1/ZpzrsG1BpC9MGQb+bVW9acI=;
 b=SyNARnAf0kltks5wfgpp+h7k67srrteEBJ4rn0ZigEjy07PSLWcdh/PRMe0BLrfVTBIxU3KNlHyBDTCMXlKm24SLCpzsVxoOO3cShs3HcC85EKhwOAP8naL4iWH0Mtk+PNIc3Z+rKh7It1uivXeAfcHxiqiMCuWW3h3NliYIt5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 11:22:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:22:20 +0000
Message-ID: <7437f8dc-3199-45a2-9279-f64a5e49e130@amd.com>
Date: Mon, 22 Apr 2024 13:22:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free issue
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
References: <20240422084707.3803306-1-Jack.Xiao@amd.com>
 <cd234b95-5ab9-4c39-a815-503161d4bad2@amd.com>
 <6a3ff35f-09a2-429c-b8d2-d061dd3c92a7@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6a3ff35f-09a2-429c-b8d2-d061dd3c92a7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2ec866-97ab-4c7f-7862-08dc62be795e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3ZSOWcvTFV1OEc5UU1XVTArVEhlODkvSERPMXZycFpvWWViUVM3N3EyZkVr?=
 =?utf-8?B?MlZMMGswSm1WSE9VdlAzUUs0U2V5emNRM1hHWUMwSmJGcjBzVWRnb2lxYndN?=
 =?utf-8?B?S0o3cWRMcTI2Tm9rdVQ1TGxHRStyNmVIdTI3ekVqRi9vMU1VSll6Z1RVMUFH?=
 =?utf-8?B?MGdOTlVtOWtuNkpWS1Y5ZmdSNHZ3RW04ZTcvcmRwYWpnZ0JldHhLcVZPeVFU?=
 =?utf-8?B?dXNTeGtveldyUFRSQVJRTERIKzhnOHdRU0xSbUkvbnViRk9ZcU4vZFNOQWF6?=
 =?utf-8?B?ZWVKSnYvUU5lMG1PUTlzRzRyVG1QV1Y4aG9PenJ1TnR6QzJEdHZrRWF4a2dU?=
 =?utf-8?B?blVBS09QeDRpOUNrVVhGd0Yvd1k3YWhDd3M4Vml5c3R4bS9URlVaS3JHNVdX?=
 =?utf-8?B?ZXMvMFJIK0xKMHp1aHVHNGdnOFQzempxa1lEN2V4em5sWVpGMU9xazRNVmN4?=
 =?utf-8?B?VkNiYjZndU5yYjhMSkswa2ZIQWJBVE5MQXhIRlM3NnJ5Q0lVOFNwMDZXZUJB?=
 =?utf-8?B?cVhodEg5a0F6Q0NMVml1aUtYNlpES3hyNHY2Ny93QTdkVzh3bHJQenZKeGY4?=
 =?utf-8?B?aDJRcnE3RjVQNy90VUxJOGxUVnRQeDVmTUZmQW5WT3ZJZll4ZnNkMmc2Qk5I?=
 =?utf-8?B?VElZNjkzQjI4Y2lvWmFjeXI4VDlIQ3J1WlBBZ2tZWFZHcUZMay82NnRmSE1s?=
 =?utf-8?B?SXFqS3U0SStPL0FqT2E1SDJWc1prUDBrTllZN1dMWVpyRlJKOWhFSnFoL2Rl?=
 =?utf-8?B?dmN2M3IzaGtMcmZBOGhNbzhVY1U5R2VzQ0cvL2VWMDNvazltRkZsbFRPbm9D?=
 =?utf-8?B?aTFCS01sZENwTVRzSjM3VmIxNFB2bGlWd0ZEaVZpTDJ4NmdQa1hyUnRYYVdt?=
 =?utf-8?B?T3YvVUlLc0tUOW1zR013dFZjMjNLcktHU2FZeVBYOExrSjJoL29wWkpZSGFO?=
 =?utf-8?B?UmtkazFVaUU3Sk5SSk1FbFAvRDVVSmRmRlE3L1hvWGJaZzE0WGFoUlhaYy91?=
 =?utf-8?B?aXptY2FCYzFYOXpWOFh2L1d5a2NhM01YNmxLZ2VwZzJFTFNOWmEwdUJ6NkZv?=
 =?utf-8?B?eXJIUGx1bFF3L0VtaUtNUitqbFMvUVljZFZRT001MzdhbzdKWnhPRy96WEJu?=
 =?utf-8?B?a05ZQVh2N2hQM0xNQk9ieHdSdDVjTWpzeFNOOHF3Z3hoSVJJYit0RUVhalN4?=
 =?utf-8?B?MW1BSWsxREoxMTBkM3FNNVdOZ2ZPUU5TZWxYTzVVU0VDM3lHVUZvT0VGM0Nh?=
 =?utf-8?B?QVB2M0piUkFRTHRWUVdDN0o3RlJVWGlNMElWT2owVzBXK2UwTStMSHlZcUIz?=
 =?utf-8?B?ZFh0TThvSFFzekh0VklSSTh0N2VQWHNoVDRwVkhuMjN3b09wcUY3emlRbkVj?=
 =?utf-8?B?Z3ZWS2lrOHUrSVMrbGVqRENIbXVOTGJqQytCald2Q2pPaVc3U202VjRHdEdq?=
 =?utf-8?B?eXZNYzlxTnorQVVyb29GZjVnc1lYUTU0dUJWeEFKSlZwM0NZYnBOUmQvWm1r?=
 =?utf-8?B?cWxNejVDb3A2Sjl4bFpETkdaRGxleGc3ajVtMEVVdVh3Zlp6OWt5dU9xWEx3?=
 =?utf-8?B?TTMxM2RqWG1hOFllL0l0cktiV2lXbEVCSDhKbGttR1czdEdqK0dHWEpDemtm?=
 =?utf-8?B?OXo0cXVHMDBzWkpBbmM4bW9iOXJxUVAwbmpNQ2ZldDBSUFVucm05dkNYV1VE?=
 =?utf-8?B?NkFBb2hEa0FCZUZ6NnpnbHNmWHpEdnV5bE5JZzgrU2lQd1lGMmhBeDlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJyc08zSUo2QUZla1JWMC9YM1NUbEtReFNHTmk4ZjhreTFRdUQydnFYQmZa?=
 =?utf-8?B?ZjhQT0dxeGFGeUF0MldiemF3aS9ZNnBvdHcvYzZMZnQrYXJBdEZwb0tDSU9k?=
 =?utf-8?B?ak5IRXZiYmxHcFR1Tk9DQWxjTmtBL05xSXhiUEVyOElZOU5PLzc2V0RnVkZ6?=
 =?utf-8?B?Vjk3SXFtZXduTm1XL09jR2ZiZWhXT2FjeEFTVkMyWXplODBRSnJ6L0RHUGt2?=
 =?utf-8?B?SHBYeXVYcW9OYVUzZEF6TE1hYXNjVFFGcC81TlZpbThPS0NEdlhOdjgrQlVh?=
 =?utf-8?B?aG1BTDRuRkFaQXFUNTFYblFIM3JlNHF3WVJNbEo0bWNEQ2dGcmQ3dDZaZFRx?=
 =?utf-8?B?L0s3Zk9TT1gyU1A5c2VuQko5VUZDYVNWZzZOTXcvTmt3czRMRnFWNFkranRG?=
 =?utf-8?B?SC9EZDhMT2FjU3BsMHY1QzlVSk1sSno1YkNFMWZQYzQ3ZHF1d2Z6MFRTenAr?=
 =?utf-8?B?Q29yam5jZFl3K3VaNEFubVF3Vm5vSzVvUlk4VDlKZ2l1bnZiMmFWakJvbHBx?=
 =?utf-8?B?R3ppeEZuVFpkZlRBbmpKanlvU0pLM3hROHhZbkZKWGQrcStpN2d6ZCtBTldq?=
 =?utf-8?B?OVRteE1yNWpySU9OK0JIOGZjR3FpcHNKQ0hleC85YW53aUVla1JRTWdQbnRY?=
 =?utf-8?B?RWNGQWFhV2lNempnazJyUnFIdk02VUFKQzc0d0h2RHB2MVJ2RXNjT2NVMnB4?=
 =?utf-8?B?RThNUm5YVWl1MDUvM3JrTDI3YXd0QXZiNXhqTDBzOHgyMXdOdjY1L3ptOGcz?=
 =?utf-8?B?Vm03TXN1VUY3b09vbThHK29XeklUYStEMEI3QkNwKytmdHBVVVpQSXIrTVRQ?=
 =?utf-8?B?akVBTDhRYnYvUjZsM1ptZ09QVkFBQ25tZFN0R1Y2VnhNNmpXSTAwRmRwZitk?=
 =?utf-8?B?WEx6VVlUTmgyZUZydmJCcU1JdytibWYraURTOTMvVGhRR2dpMmlQeW1ES2Rx?=
 =?utf-8?B?cHJZT2dGMHpTZFhKVnNJQVoyQmFsTnhwcXZNVXNxMDhlTWxnSzY2Vm9tYXV4?=
 =?utf-8?B?dWdtQVhZQ1VmRHNlWmhCNkN6SFoxVGxTZTBxTkhuVkVSTjNWMVdTQ3BjK2lj?=
 =?utf-8?B?bHFNbGVuVGlNOTYzYS84OXJBcXJFTzBWNHdCVDROQm1GL2JUaWRDZGUzcDdS?=
 =?utf-8?B?ZWQzbFM1eU5Ya1ZmdStaRElKMEk3OXpHd0M1RSs1L0JxQUFGSmxhVHVCQTlk?=
 =?utf-8?B?SVFxVzJrYVc3YU1rOXNJZ0VZNmxqUVBVZkduYmlMNmhySWpMQkYxc3FTTW51?=
 =?utf-8?B?QVZ0RUxZQ1pCb0RZWE82VDNPdkorOExTalV5Skg5OGlNTnJkMlZLK2p4bEdq?=
 =?utf-8?B?ZFI3cHQzUmxsaUxzVXJxbDhKTVJGd1lodmFBT0ZvenZlckI3bWhuMjRBSm02?=
 =?utf-8?B?YTJSRENVSXBIT1ltSi9uWCtDdkp5bkE5ejJCbk5HZnlUNll1RlVBVTJldmUx?=
 =?utf-8?B?RmJDM2kwQTNpNG42bmRTMEZRUnFBT2VzNkE1bytRVjNLWWFUUURxSmhsY1Qx?=
 =?utf-8?B?bzEvQzVQdUZ5dWcxSTlndllUb0ZaYmZlYzhrNUlQQmE1RitTMGxOaHJ1SGlh?=
 =?utf-8?B?TzhhOVBxb1JDYXE1RjFqc0FwUFBFM1NXOFJIT0dnQUtHazdFMTRmYUYxcEQz?=
 =?utf-8?B?bEF0ZWVZTVV5SklEZXRDVkVERzMyWnFLdFNoYmpPRElveXJUbHppVEpHVVBP?=
 =?utf-8?B?RHBWRlhGdzBZenFGeDZNUUJIczF4Y0Z2OE5BSXRtdzFMUGEvRk9YVm84WmZM?=
 =?utf-8?B?d1dUam1zMUFZWXFXS0NheHVyc1F6eVAzMyt4d3dSVVJRSklTU3hPUklaUVJo?=
 =?utf-8?B?L0FkdFIzRFJCcmE5SGJxOU1LUTM5dW9tN2lrbHRHQkhaUFBOYmFQQ29tMmtS?=
 =?utf-8?B?dVg5blBOU1hBcnZOUXJIUGk5MkEyblUxSkR4UWJxUTZqYk44Rlk3S3ZCYU5V?=
 =?utf-8?B?MFNIWVAyVWhaZXQvNGViZzFvSnc2OWgrNXVwT2tCUXNNbG9wUUxURVl5QjBX?=
 =?utf-8?B?dE4yVkpTdWVhUmZBM0kvRmlhUjgxTXRIT1NtME9ZMHVFSkVaSThnMk9oZ3N4?=
 =?utf-8?B?RnZtTDM0cURpa1FJVDZPalFyQm1DMnhtMWIwS0hVTGZTaWVWbGJpWkpUV2FL?=
 =?utf-8?Q?mvFU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2ec866-97ab-4c7f-7862-08dc62be795e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:22:20.2103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PU8jcWu/2QNb2L+hYRkutXZAxkuTceVqL8ud01xdWe4H99wRCGKmyOLDgfauxlx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

Am 22.04.24 um 11:37 schrieb Lazar, Lijo:
>
> On 4/22/2024 2:59 PM, Christian König wrote:
>> Am 22.04.24 um 10:47 schrieb Jack Xiao:
>>> Delete fence fallback timer to fix the ramdom
>>> use-after-free issue.
>> That's already done in amdgpu_fence_driver_hw_fini() and absolutely
>> shouldn't be in amdgpu_ring_fini().
>>
>> And the kfree(ring->fence_drv.fences); shouldn't be there either since
>> that is done in amdgpu_fence_driver_sw_fini().
>>
> In the present logic, these are part of special rings dynamically
> created for mes self tests with amdgpu_mes_add_ring/amdgpu_mes_remove_ring.

Ok, we should probably stop doing that altogether.

Shashanks work of utilizing the MES in userspace is nearly finished and 
we don't really need the MES test in the kernel any more.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 06f0a6534a94..93ab9faa2d72 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -390,6 +390,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>>                          &ring->gpu_addr,
>>>                          (void **)&ring->ring);
>>>        } else {
>>> +        del_timer_sync(&ring->fence_drv.fallback_timer);
>>>            kfree(ring->fence_drv.fences);
>>>        }
>>>    

