Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BEDE7AD6E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 15:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3BC10E011;
	Tue,  3 Oct 2023 15:40:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A096110E011
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 15:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNCxRn2CfODDYnR3Pzr8l+dhfsjj3D+e71kpGx9s0z9nd3X0bOPEvQ5p0oTaLSYkAs3X+WmAwSqWajsN9eyBsOMONQZjt+F3+yDqzllcAuBazoXlal6s1qg1jNFDG7zqyWQEK7srcJfI4oSvnozEYDeS2I3kCfqDx2g87e7cYPVzO+YAb9ZOAQyv9hpqlzAkpaR9o/+ZYtcmslIW91K5V15ddHmyWYiUU/j2tLVGuC2MDVGH7tS1azXddchVSiBA48+wnQAwf5fIoq1v4KV4e9tR97jBbo629m/wXTVbcKRmjaIF/v61lUEztAq3lC3GYWCIObUNBtcEunNknXo6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9XHkVBtMNyKJsk1JbCZkxnIYUBArXOTxDtQ4lrxFEg=;
 b=U/rG9u52/gy7MKM0ZNLFNRVHiyHeHOJIIdg2Cf7fN94+EToLXsiY64yljhI2EbGfYtqRalt7KP6ps4cNEw2s2ZE0yUoJzPJbBjfr9Pt3bOfDP2TB/OvOrnGs7x0Ouepo4EtLpeP1gp97LpzAMsWMmqyVdSR2Hhfqltq1OUxbebs06jabSbMzm+mK0EwsfYXflcBxezrLkNg5V7mS6ZVRgL/r0sVhj911/sK5AvRNXuxkUfJjdGE+S1C1Aoxk+IhTF1JW8SOTNmNL86ZgSByUOxf+QIk48CeyRmkS9+SE8vvVset88pMbQfSOjbLDIcRJhsCor2wh5wZezfEkYiO+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9XHkVBtMNyKJsk1JbCZkxnIYUBArXOTxDtQ4lrxFEg=;
 b=qlWitkUSlwe6wurUgooRegEOH/DglexM8ThLA9lSwvELcbMrNEtX3SxbipsQt1I0qPZ3c2rte7d26szAyMYjsx0Yaz/FOw3d0UXV+zbi+WxmQvDMlTyucGwole8OIMZSOFMlhQQPfsujT8p0EjJxdzhyfhzlYcM/PFaI+HRlWY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 15:40:32 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::965c:2865:17b9:fc05]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::965c:2865:17b9:fc05%7]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 15:40:31 +0000
Message-ID: <8fc58d31-a882-46b7-8852-c54a997af7fa@amd.com>
Date: Tue, 3 Oct 2023 11:40:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Content-Language: en-US
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231002174754.1596197-1-ivlipski@amd.com>
 <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
 <PH8PR12MB7279526F77BBC201BA660529F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <PH8PR12MB7279526F77BBC201BA660529F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0096.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::25) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: af7db159-5e75-4de5-0af7-08dbc4271337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkMQBPLzKKdixcUOZgLRDMMdlWFk7FIfqsP11Xsfdc7htYccgM/UbF3F3b3VxC2YWsOEtRRjH7Su1oChO45q5EOYaP2RN4tKyP5/ClvFUQLIPscAWtFfcfxN6fFtmoximAAQazuRJvCENl9+KpmarD7Ieaw1kHsVH47SKr7k1Xc8qA0WT1dUNIipGiW9OCcPoxX/BtsYH5CqBaR7qxzipeaUzEn6wrKnkYvooHMYVef6+oREcra32RwOd9QdMDD2JzmpdDpDbs29mfKpUw3CPKTua5iDpUuxt7vPIVPStUgFfkYHySyUCCSIGnT4hlMHkeuWnpbBaqfPVFXjwVyVwvILdmFJbinhuh9KDiXkWmwdbmOezBba/sRCdlD9jbrz4Fuwqkl+7lo/ddQGGk4+Bw1ViGQvc9a45rnFSdYKbogJDUcKlsdp3TdBW47dhz4rRZjHKaME2x6Oz+YqFljFg4r/AIYqrRyPVRzJLWET2EPukDOAsdAKICpdYjewpRskCaYsXQK8cJO1XpUNw2Ck31tQpZl8tDpMTrqzdklYKmckBoiKuXDDXwMorsKShUpgCB8PVGxqWVakdU68qdFg69/4DyPmYZwHPQhGiEwn+iy2HBHy/X4tPouJtYbUlAYdHK49EzAeFfzO/CbSde79nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(55236004)(478600001)(53546011)(6666004)(6506007)(6486002)(38100700002)(86362001)(31696002)(2906002)(83380400001)(26005)(6512007)(2616005)(36756003)(66556008)(5660300002)(54906003)(41300700001)(110136005)(316002)(66946007)(66476007)(4326008)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9QVTlqaHBqblh6Qzdic090RnJHMWRXbndjSHlnZk1DaHdxSVVWZm1JdC9F?=
 =?utf-8?B?ZHpEaXFuckM3TUVWSzBzV2ZONjFYdTBHaUpyWGRDVDVud1FVQWpqVlFJNlNW?=
 =?utf-8?B?ZWFZNXA2WEZ0VVJUbzFPZ01Tei94RWZMZ1hUMnIwNlN1SmJJQU13OEtjcU4z?=
 =?utf-8?B?SDRHMXFoT2ZBWlgxT2ZCcXhqQnU3VWxLeG41dTRlYXBRNkxBN1N5eXdBNnYv?=
 =?utf-8?B?VllINGNjNmhyTnJIRTJuaW9JSFp1M0VxVC9MR0FRdVdJWFVMU2hmNmpNOG13?=
 =?utf-8?B?VWlSMkZhZGJQZSs3SFpuaEtWQzg2OStlN2ZBQm1mZWdDOWhacURnamR4Z3pX?=
 =?utf-8?B?OHczWFBJQ0Fhb1JwMzBzcHBLZjdZblpOVTBtQ0MxUjhwczVhWkJ0ZU1SeGU1?=
 =?utf-8?B?NXFNMFhydHQrNG5adjlZbGFlc1pBemExUGM1c0ptYjZhQUV0Wllsc1lBZXEx?=
 =?utf-8?B?MnJrRUVkWkxCcXhHSEdsdXgyK2UraExIWWswNTE0VEx2SEVlTnJ3aW5LTmdE?=
 =?utf-8?B?blpzWmk4cnliVU9aTWFRa2gwSjBJSi9UTEhLSE1PeVdoTzROSE96VVU2bnUr?=
 =?utf-8?B?bU1SSzd5ejlyQzMwUkRnSEVEcWF1Z1pIVElEM0xRTmtjaTJkckVxTE0yQmVR?=
 =?utf-8?B?NUlqejBRQlU1K0FzNGVNWnFYSW9tcVlzYnZiQVczdTRvNFZDR1RzUkxrN2JN?=
 =?utf-8?B?RzdodVcrMnB4ZW13Zlp4WDVlWSt1Sm1uR2Zub2Z5Y084NXhqMUs2UWR2WTlk?=
 =?utf-8?B?bGdvK3czaDBnRHQwUjJ0WW9saTNTU0llMWMzcElucHBHcm5nRW5FTmdISjJS?=
 =?utf-8?B?VFRGVnhNNnRNUXREdUxZZUdzNUJZZ3hsR3VlVFFMSmNnQnR5NHUxeVpacWVG?=
 =?utf-8?B?YVo1RFQ2aExaSUJlcTNLdDkyVmZrU0NRRjZZZ1I5ZklVdnV0K3NSclJpYUJQ?=
 =?utf-8?B?Q2hMVG0zeW1OSjdZNjNXS0J3Ung0cVM1UFFMUjlPU282ZlRHM3JlMHFXcTFN?=
 =?utf-8?B?T2NKbXEreE9mcE5lR1V5UndWakxka2Jja3Fya3JxZ1BqRStkZUhkVHJ2OElC?=
 =?utf-8?B?WjRMVTZGTVFLOXJXNlVmNmFmUDVGdU5kSXpVbFB4Z0ZoMGRkR0FBLzNEN3ZP?=
 =?utf-8?B?c0JVMWQ4Vk1hTTFTbVB0czd1bGdsYiszam5KdGRRZGJkRkZGSnk0dEdYVFU1?=
 =?utf-8?B?YVpSNTF0ZHRrbEpseFM4NlhCOEFGbmpMcktXendGRElScVYwVHJ0YWlLNTll?=
 =?utf-8?B?WjZUOGdlWUxpQUN4eklWUFVwUUxlYzhvaVEwd1dKb2RXRjZPU2RWcHB1cFF2?=
 =?utf-8?B?UGx5M0RvYUJhcW1OYXd2MUhkQktZVTcvYUVFa1RZNi9uSmJmUXBBUWJ1ZUZX?=
 =?utf-8?B?SU1BbnIzRXJJMVBKWEhKT0wyck81T0gzOHJQYnFJeWI0MWZDeGpsQS9vYjlF?=
 =?utf-8?B?S0tSMVpZNjltamxxSTFtaVV6L044RUFtKzUydHBIOXJrYUZPbXV1VldLbzFr?=
 =?utf-8?B?dmdnMGtHRnFUamV3YlRBOWdRYkg0SFNubFNBWkdFTUJiZWloV0RPRCtlVjVn?=
 =?utf-8?B?c05WeEY4eTBOcFJrV2hoeEVrTUV2WGZ4TUpUa1I4L1NZWWVaY3Jsb1diblp1?=
 =?utf-8?B?RGZjQjBhRUNUQ3RlYVFBaFNxUDhHYTIxOXJhbTU2RHpkM0FOTVA5Qm45ZzFu?=
 =?utf-8?B?b2FPb1R0SVdEU2dmZ2toUXMxK0pVcVU5TjZFZFBJVG5Ta2gyaVNwZUI1eUF4?=
 =?utf-8?B?TTAwRTVGWlVJa2hvdU8xcEpINDBCQlk0TjM5ZFhVYWcvbHYrMzhjdnI5WTU1?=
 =?utf-8?B?S0dlSW9QMkc5d3hLRURGN0ducFowTDI2cVp0MzhaUFJ5b3NNMUNRYjVSODR3?=
 =?utf-8?B?Qkhtd1V4STh4eC9rZHFuMTltdzBLOTFOdkFmL0tLeC9PK0FWeHF5VkJBNDQ3?=
 =?utf-8?B?MFA3VG1TOGlrdmgxbThSbGdiNTdPVU5KMktiL0dYSEdjc0FZZHE5MTcvRi9V?=
 =?utf-8?B?L0hjcmxrV0FBSUVvc2FBTFhuNUw3UXdBT0RmNW84QkV2Ukt0UlJrSlIrQlE1?=
 =?utf-8?B?eDdFdWo4Nnl2VGlUcitZdlZpa2lkVmkzbVd3WTl4VUo3TUg4L25rZzk3d0wr?=
 =?utf-8?Q?39h8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7db159-5e75-4de5-0af7-08dbc4271337
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 15:40:30.9641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSp+d6uTwFRwEzqLBIpiHFo2RruDQBj0ZKlj0qqyzvA7UrxHrvSzTlv4KiniUen9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:
> [AMD Official Use Only - General]
> 
> 
> Why not just set replay_feature_enabled = true; to false?

Would that be the right fix? If so, we can send out a patch
with that instead.

- Leo

> ------------------------------------------------------------------------
> *From:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> *Sent:* October 3, 2023 11:20 AM
> *To:* Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN 
> <IVAN.LIPSKI@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza 
> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) 
> <ChiaHsuan.Chung@amd.com>
> *Subject:* Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for 
> static screen use cases"
> 
> 
> On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:
>> [AMD Official Use Only - General]
>> 
>> 
>> Any reason for reverting this instead of looking into 
>> "amdgpu_dm_setup_replay()" and "replay_feature_enabled" to see why reply 
>> is being enabled?
> 
> It causes a regression in amd_psr. Unless there's a quick fix, we should
> revert for now. It sounds like this can break existing support for
> PSR/PSR SU.
> 
> Acked-by: Leo Li <sunpeng.li@amd.com>
> 
> - Leo
> 
>> 
>> Bhawan
>> ------------------------------------------------------------------------
>> *From:* LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Sent:* October 2, 2023 1:47 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza 
>> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; 
>> Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; 
>> Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; LIPSKI, IVAN 
>> <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Subject:* [PATCH v2] Revert "drm/amd/display: Enable Replay for static 
>> screen use cases"
>> From: Ivan Lipski <ivlipski@amd.com>
>> 
>> This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.
>> 
>> V2: Reword commit message
>> 
>> [WHY]
>> This commit caused regression in which eDP's with PSR support,
>> but no Replay support (Sink support <= 0x03), failed enabling PSR
>> and all IGT amd_psr tests.
>> 
>> [HOW]
>> Reverted the patch.
>> 
>> Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>>   3 files changed, 1 insertion(+), 33 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 32156609fbcf..f69b2e9ecd98 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -66,7 +66,6 @@
>>   #include "amdgpu_dm_debugfs.h"
>>   #endif
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>> 
>>   #include "ivsrcid/ivsrcid_vislands30.h"
>> 
>> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct 
>> amdgpu_device *adev)
>>           enum dc_connection_type new_connection_type = dc_connection_none;
>>           const struct dc_plane_cap *plane;
>>           bool psr_feature_enabled = false;
>> -       bool replay_feature_enabled = false;
>>           int max_overlay = dm->dc->caps.max_slave_planes;
>> 
>>           dm->display_indexes_num = dm->dc->caps.max_streams;
>> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct 
>> amdgpu_device *adev)
>>                   }
>>           }
>> 
>> -       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
>> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>> -               case IP_VERSION(3, 1, 4):
>> -               case IP_VERSION(3, 1, 5):
>> -               case IP_VERSION(3, 1, 6):
>> -               case IP_VERSION(3, 2, 0):
>> -               case IP_VERSION(3, 2, 1):
>> -               case IP_VERSION(3, 5, 0):
>> -                       replay_feature_enabled = true;
>> -                       break;
>> -               default:
>> -                       replay_feature_enabled = amdgpu_dc_feature_mask 
>> & DC_REPLAY_MASK;
>> -                       break;
>> -               }
>> -       }
>>           /* loops over all connectors on the board */
>>           for (i = 0; i < link_cnt; i++) {
>>                   struct dc_link *link = NULL;
>> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct 
>> amdgpu_device *adev)
>>                                   
>> amdgpu_dm_update_connector_after_detect(aconnector);
>>                                   setup_backlight_device(dm, aconnector);
>> 
>> -                               /*
>> -                                * Disable psr if replay can be enabled
>> -                                */
>> -                               if (replay_feature_enabled && 
>> amdgpu_dm_setup_replay(link, aconnector))
>> -                                       psr_feature_enabled = false;
>> -
>>                                   if (psr_feature_enabled)
>>                                           amdgpu_dm_set_psr_caps(link);
>> 
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index fb51ec4f8d31..440fc0869a34 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -29,7 +29,6 @@
>>   #include "dc.h"
>>   #include "amdgpu.h"
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>   #include "amdgpu_dm_crtc.h"
>>   #include "amdgpu_dm_plane.h"
>>   #include "amdgpu_dm_trace.h"
>> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct 
>> work_struct *work)
>>            * fill_dc_dirty_rects().
>>            */
>>           if (vblank_work->stream && vblank_work->stream->link) {
>> -               /*
>> -                * Prioritize replay, instead of psr
>> -                */
>> -               if 
>> (vblank_work->stream->link->replay_settings.replay_feature_enabled)
>> -                       amdgpu_dm_replay_enable(vblank_work->stream, false);
>> -               else if (vblank_work->enable) {
>> +               if (vblank_work->enable) {
>>                           if 
>> (vblank_work->stream->link->psr_settings.psr_version < 
>> DC_PSR_VERSION_SU_1 &&
>>                               
>> vblank_work->stream->link->psr_settings.psr_allow_active)
>>                                   
>> amdgpu_dm_psr_disable(vblank_work->stream);
>> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct 
>> *work)
>>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>>                              
>> !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>>   #endif
>> -                          
>> vblank_work->stream->link->panel_config.psr.disallow_replay &&
>>                              
>> vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>>                           amdgpu_dm_psr_enable(vblank_work->stream);
>>                   }
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 314fd44ec018..ce75351204bb 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>>           DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
>>           DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
>>           DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by 
>> default
>> -       DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn 
>> < 3.1.4
>>   };
>> 
>>   enum DC_DEBUG_MASK {
>> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>>           DC_DISABLE_PSR = 0x10,
>>           DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>>           DC_DISABLE_MPO = 0x40,
>> -       DC_DISABLE_REPLAY = 0x50,
>>           DC_ENABLE_DPIA_TRACE = 0x80,
>>   };
>> 
>> -- 
>> 2.34.1
>> 
