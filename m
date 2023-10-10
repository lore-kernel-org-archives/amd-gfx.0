Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEEACD8C95
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E8510E166;
	Tue, 10 Oct 2023 14:40:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFAE10E166
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC8pC6FPZ6QuL75fLpO0fJHh2kCEJpLXB2Q6fcJfpOTs4ssUu1lntCUB9PB4bA+kUPRmHXbLmrYpqnPcVfYvGk5feDD106ZOpgFPS1Q0YjRRH/1zZYLK8T7v+pJAs9cZMjYH3PNdR7u0ueEqU4Zonanwji/eHO+Z3w+2ghKfPW2idQclJIIZtA4FC82zKcywX4U0ZeocABZEcCjNz1GaN+GPnwOGa9OdUw9WwG/IRI9qumjrCbhueB5sWMKIOV3Y91OLk3V+AAzrZDu9WU6IAY2XH9lauCBZNArMOWQI0GURbHEU8cyz21BULkCwWJopRnNaIJhZEIDNY0x4DYc/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M+afc6kZ1ZD782ah7MN5E8JetGOxzqX9xE4/QjAH5c=;
 b=JMrR6xzX/R/o/NPWsc2xMzg0t4qyFOLF7JypPht9IaCP63TBBSwVePlhIKlCBD5IfpyL1ZJyAUipsKhyOUmWtCpnamInldg5icaVedxDaQ9YxUUe1Ln9kYEen6KoesPQOFgv/Kf2bROV5KrWIKXHhyQg25xnNN9aQTMBw2lEbKQXxKdNPRtmYBAlEm9NN1HSbksX96n+aTxaQglZ4L8e7QxbI3RuObAETGWYCKXQ+MlKc7ADLHpSpp4ezFoGkpsOdY1i7Dnf4+THbhdJT24DAk3Xw/j+jtnMSvvnaTxc205dz9ysugahaYCGWR/5N3uizx8X1SiRvJJRXijYbzkyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M+afc6kZ1ZD782ah7MN5E8JetGOxzqX9xE4/QjAH5c=;
 b=IW0zHh5baADo4KhaqP7yuonRFRm13kdeQw4rYnQZ+0RjLJ3LzS90JLHp0JBAkA5FBdWIe+bgNGXRm3IvIhmeR5yWfc3CjYbX785GlfZ5qkX4sUcr9I7IiLNF5s0RzDID2TVYRd0rKJ4rRHLc2+MMPNjxk0yG6k688QCf+00kiBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:40:16 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::ac5b:fd08:f368:9ee0]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::ac5b:fd08:f368:9ee0%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:40:15 +0000
Message-ID: <169a1b66-c266-193e-876d-79cd62b3d63e@amd.com>
Date: Tue, 10 Oct 2023 10:40:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable fast plane updates on DCN3.2 and
 above when state->allow_modeset = true
Content-Language: en-CA
To: Mario Limonciello <mario.limonciello@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231007054127.229441-1-tianci.yin@amd.com>
 <56432038-4728-4dfb-b327-ea003a059907@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <56432038-4728-4dfb-b327-ea003a059907@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::38) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df26078-9815-464c-93bb-08dbc99ed139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNPctc0Jz2bj6+rc+ZDhROeg7mqa0ImwU0BGcpK5Eku4YiNhjeWrRx7lh3oyHhrnjrxW8o0s83rmb5TJhwB6OrEQYqa0gX2QzxFJRoMNyfSySNXyszL62nkVfCtqZ5ixniYozjTaJn5VkHQV1wpt4+5dd7+xUudE1Byk2rkSM8oUE4UOVBYkzZA2fu+kMBeGVpAu7cUrrdVHHsmKCAn4dA8W9bwcxpVTSYX6jefkA/KBbgBWqjiW15OHeIXOG6pEa9y5Oz0UV5oU1Fb2+kYNfcfmbAISrspy0P1p6DvPtI2r7HePJs0rSN9ELB8+Wv5KPDYHxRmYet//56Y/iaVPcDwZD913vy6kvwpflBRRz7FwMyS8boLs6R4xaPdVsAUSNHg0ijeiCrc/NhVVnBAX4TyuCw6VAhyP6QUTs//JlFRX4itpj5+HFOaTngFyuFQ5TzuybOOvYWXXxE821oFpGL5fVhxbFEdViNEp15+QUG+1p9Dw25zfk2/MU/Dvw1jcye5OtH+lPk00pRDuCyYR60xXcw7TqlvE4mmBXooam9emx2tv/jEkGAVZ5h1OCfobJXIZJG8unHUjabnfCnL0JPgzZ4vbXpC1sFOJ6YcnsXc3LAWhl/rsfSabg7cvCAhGhMZHupNR+gT7Fd0p3yq86w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(6486002)(54906003)(26005)(38100700002)(8676002)(4326008)(83380400001)(8936002)(6666004)(41300700001)(66556008)(66476007)(110136005)(15650500001)(66946007)(44832011)(2906002)(5660300002)(53546011)(6512007)(6506007)(478600001)(2616005)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnIzTmd6R1piUThhbGFGbkI4MWkvcjd2dzdKR29HQnpqRDlUUWRRQ3hCMUNQ?=
 =?utf-8?B?Ylg3cFFsT3JBVHMyMDhTbDVmRWdheCtPcm12Y0tQTlJ6bVRZUkowd0t5K2JV?=
 =?utf-8?B?d1RxSXg0NW14S1VrZ2xhVUIvTDlRV3h6a0NJNm01Zks4c2Z2VHQweWphUnlq?=
 =?utf-8?B?OEZQVFNFUThqakdrUitMZ1VlaGdiSjlMWHJDb3ZFSHV3MGZkVFk1eGk1U1dl?=
 =?utf-8?B?Tm9PWmdBNXhrMHNheE5uQWN4UE52dDhsaVIvNEZibHJmR1QvaSt0OTZKNUFa?=
 =?utf-8?B?M1VQTTAzbjBUWnlyQm5pNTNpYWdvcmxacW1EeElDK0VrZzY4VHNYVE16M1Vy?=
 =?utf-8?B?dmtBZVRYZHZrdXJjZDdjQWd0c3lMMkdHR09yV1VnZHlzWEdSTlJ3ckM5WU9p?=
 =?utf-8?B?WDgwZ2tqTkNTZURqVVZxMmpya1VmSU9OS1hCd1Rsb2dVNEp3K2hvZlZXQmtI?=
 =?utf-8?B?MEF6ZzMwVTFRK1FvdEh3ZlhGRWtWTHlBQWpOSUloZ2RMV2J3WUlzVlFVbVZ1?=
 =?utf-8?B?aDR4cktrYTlZMVBPREIzZmpXMWpXR2dqK2N2bGVnYXlEMktDR0ViMjRESVdP?=
 =?utf-8?B?bXUxSU5vVFRJbWhUV0NXM1d5eDBiTGJPL3Vld0o3L0ZpSSt2TC9KbkVUVTNu?=
 =?utf-8?B?dHU2QXVYU0FTTjJwcVpKRHFWcjVHMDRnWk9XTk81aXlzQXFSeHdVR3VzMUJK?=
 =?utf-8?B?RnZnaDZBYkVab2JyMEtjbzFxam5ha3plUEJSb0JDV1RaQVd5ZXFyYUJWU1ZV?=
 =?utf-8?B?SFEwOEdZbC9jVlV1ZkMrQXlHTFh5Ykl2NG1IVHdTcmpjVzFjdkJSZ0V2OUl5?=
 =?utf-8?B?amdrVHl2VzBKQ2VzMHEzVzIyMmJvOTUyek0wdU1lUzVydFlVK2VUNmNlWnFW?=
 =?utf-8?B?MldueUdFaGhtNEFiUEpGOEdLQU96WHFGNlJwN0tIQitFd3FSSFJOWTBBR0F3?=
 =?utf-8?B?Mkh3SmdFdStQZnJHcGVkWjVQVmUrenBlUVRhSnd5Wm1TTXZvVFl0bDM4Yk5y?=
 =?utf-8?B?SmVMeFJZMkdsd3hyNDBraldZN1hubTlualdDUitrM2c3Rm5aOS80S2pzTktw?=
 =?utf-8?B?L21rWVpBWk9IaXRTaUE2UHZPWEFSci94QmFwcXF2QUgvS1pnMm5DalVaVjhl?=
 =?utf-8?B?NStUdFhRa0dLVDk1UmJMZE5QUHR3SFdXMnZsZGlaQ3FBY3I1bTg5NTUrYmxy?=
 =?utf-8?B?V002NlkzM25TblF0UUZOVDRVWU9kaXYyVzZBOWR5MEVTVy9OMnQ2b0twcE5B?=
 =?utf-8?B?MlcyL0g3VTZLdzNTYUhQZUU0TFUyUXpkVnFTT1pNSmRTZ1I2dDkxaDhiWXVN?=
 =?utf-8?B?RzJHSXV6MDBaYXpBbllqbEJYazVuaTJtY0lBZnJOQ1Nwdkk4Z0UyU1A0VFdi?=
 =?utf-8?B?RDgxWVZ2Tzdmdk9tRU9vNmpoOGwzeHlJMTNBQVBob1lPVnBkYTdWVzZXaTdO?=
 =?utf-8?B?allmQkU5a2RJQS9HNkhpQW81Yk1mcmQ4M3dVZFBQU1l4OFhrS3hoY3FETnNo?=
 =?utf-8?B?azNUaTA1RlpQUVZZNkxsTGlSS2VkWjRQcVhGVW8yZmhiNlJ0R09kbFdzTlov?=
 =?utf-8?B?ZXNET2M3d0RZVncyOFZ5eXB5SWVwbXhSWk5FUzlZS3VuUStiQ2hSa0tiT0Ey?=
 =?utf-8?B?YlN5QTVIeFd3VjY5RTZtYzhia0dlT2grU0o1Q29vVFJnN1YvNzZuN054QWxh?=
 =?utf-8?B?OGNKNGtra2FyNEJ6aHpUZ0JXbDVyZUhjdjFuMDlXVzR2bmVCUGpmMFNpVmpi?=
 =?utf-8?B?QW53WVJlVGo1Y3prNHkvVkdQenBvS0pmeDZEcEM5ZjArc05UazZRR1VCZmxG?=
 =?utf-8?B?OGpac3gvZnRBczA1M1ZwR2VmTjFZSzZ3dUFsOGhMbmtSUjMxdXh3VEU1T05Q?=
 =?utf-8?B?YVlQVmczRTJlZmYwOHo1TmUzWjlDNVNrNlNZR0F6TzRaTldqaCtSTVZyUjVZ?=
 =?utf-8?B?OEJyUitjOHlnSHZYckVWVlZDS3FtcnpUbk1rVkJNK1Q3R0tCL2IwNjVsV3RK?=
 =?utf-8?B?WVdQV2ZQRGRzSEdIMkhHaDMvbmZLVWxWOFpadDAxQUJiZk02aWhyL24xdzR5?=
 =?utf-8?B?ZlVXZDhmc0tzWmhNWm1sSUpNdklLaFFkTWdNK1ZxajNiOE1jVEVma2FqblpD?=
 =?utf-8?Q?s9dE1VvjkguMjwfGcmcnNeSDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df26078-9815-464c-93bb-08dbc99ed139
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:40:15.7032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFpy9FjfpA/ZKDHn7+ZZ3p7aXY0FuuQLPrz4qvJa1iPQegBYkCIfDOyKqfyEn57XuZFlS5twXziU0J9inYo/tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/9/2023 6:36 PM, Mario Limonciello wrote:
> On 10/7/2023 00:41, Tianci Yin wrote:
>> From: tiancyin <tianci.yin@amd.com>
>>
>> [why]
>> When cursor moves across screen boarder, lag cursor observed,
>> since subvp settings need to sync up with vblank, that cause
>> cursor updates being delayed.
>>
>> [how]
>> Enable fast plane updates on DCN3.2 to fix it.
>>
>> Signed-off-by: tiancyin <tianci.yin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index c21726bdbca2..25a0bd314fe5 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9879,6 +9879,7 @@ static bool should_reset_plane(struct 
>> drm_atomic_state *state,
>>       struct drm_plane *other;
>>       struct drm_plane_state *old_other_state, *new_other_state;
>>       struct drm_crtc_state *new_crtc_state;
>> +    struct amdgpu_device *adev = drm_to_adev(plane->dev);
>>       int i;
>>       /*
>> @@ -9886,7 +9887,7 @@ static bool should_reset_plane(struct 
>> drm_atomic_state *state,
>>        * enough to determine when we need to reset all the planes on
>>        * the stream.
>>        */
>> -    if (state->allow_modeset)
>> +    if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && 
>> state->allow_modeset)
>>           return true;
>>       /* Exit early if we know that we're adding or removing the 
>> plane. */
> 
> The comment associated with this says that this hack should go when 
> there are sufficient checks.
> 
> If there are enough checks for DCN3.2, isn't it likely there are enough 
> for earlier products too?  None of the rest of the code checks a 
> specific IP version.
> 
> Maybe the whole commit/block should go?
> 

The lag issue was only seen on DCN32 though. We could potentially try to 
enable it for all asic, but its very likely to create regressions. I'm 
okay with adding a TODO comment for now, stating that this needs to be 
enabled on other DCN version too. So just DCN32+ looks like a good start.

With the TODO comment added, the patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
