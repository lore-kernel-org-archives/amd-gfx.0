Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E325EDEC72
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 15:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F114B10E455;
	Wed, 13 Sep 2023 15:23:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C046710E4CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 15:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMJ6OZPFMtaJbxdSw83cJKBoray0RehUc516Y1z7lY5jHIQqzrRpZXszpNmMclJ/4r8UeRvT3cIj4iHdve7YSgoo3saT0XbNIXxPRYcdgZMjmY2I9bYabhHQ0LxHmdRdD2Y2Ma3DhPb0KlPraACVtsI2OqgdHX2ZSKZUygxkyuDf6+u4agc9hbNF2sQi5c9XXE2Eyy9ExYbcprCUq6O0hIwOQJd2/T7ecv5HAGxBniSayrURTq+4vGwabHa5ChBsF0RsV7yNOU+ooXCQLIBjQVrvt2f+jVgEEq0PXNNHokt/gR4hmALLLtEwQrw1MXrEmRiV0UqyI0aNExMZnbf6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiNUNx2b47ZumdMatdsQaGGj50UhHgEM1uSrZ5r/gRQ=;
 b=RVm0/JVCQxgy8oa/2eZnKZPUK+Srqocctj/kDkUBvhNRRG+7Q2fHNzptDTFfrq1DAkRHPEtgDK2oCsQ4VAViw2Xpfhhdd1Il9GytMgZ3wDn9IYGy261r9YJXXj+nDRflSF8swoMbdgE4hT476YyAhB8rwycfqlvfWiz9nlOn2ROJA/QJqx9z2jrNXI6hhPR9Vz+zFODQU/6k90sPfDGSw6Wmt7Cn8mvH+/TpywN84sCQKdprolzzjcZqIlF/j3bo4zHR3MRgamh2fdD+1seI9EnAuEdP9diTCyanWhAIfJUE6ITuMcZfT9xp/hNJVdi8SMA3OLUxN7naTvPjktCc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiNUNx2b47ZumdMatdsQaGGj50UhHgEM1uSrZ5r/gRQ=;
 b=jTcf3Ktyve+2iBvs8bt5uwYLyfs5yxqYfhulz2ZhqSR2oS8K5TMmicF+w09e5HGjT5s4nPmrVRQbsCtq0ldxmjN4xgUyKxGgslbx0V/wKDLlWUgsfeUBZmDSosZp5AiW5gnZVpH2u62QaAmRmgRXybzFyv5Us7CdJBZnk08lNpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 15:23:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 15:23:05 +0000
Message-ID: <51c7772f-447b-4154-a727-77860bd34e0a@amd.com>
Date: Wed, 13 Sep 2023 11:23:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer APUs
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
References: <20230905192600.32449-1-mario.limonciello@amd.com>
 <20230905192600.32449-5-mario.limonciello@amd.com>
 <BL1PR12MB51442B9145F7143B49458E78F7E8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <e6a7c26c-be62-43f0-9f37-0ae9b87d958c@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <e6a7c26c-be62-43f0-9f37-0ae9b87d958c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bc437f-d95f-45bf-0c5e-08dbb46d53d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYaOaGIrqa3omhiuJTx0+4nKi1cUDUgvInaWNDjbvbCwTerIhuQBCEFU7Q4R8ZXYUs5X/tF91dlADMzAvm9mUdioADecUrz0pbx9z8sNKzvcATQMuAnijjTJJmJJ1pLD28sCdV8A/5zb7l6RQ+q4xHTpt7Q6RUPa+AOV3RslBkPeF3ec6Wgm57UOpjn5znr7PjVE7t3b8ZthXcezoO+g75WAERx8W+7OKLxP6kbdAGJfnG1Cq3UNyxeDMHb/1KekuMkWT5aihG+6UO7mm/gexbBApsxUuSeUt59FjJfhV0gnUlG6ZGsIyYJea+V3ZOg0GbtNrYz423K1XoogLmV3JuOmEp29cZAzQTS4kBb1TcbSaY0ma4Iwd70RtYsIZ1NXcBVLDiXpw4JEJ5rMFCSg2RxDX4xFT2/l44gslgX5nTt4/PHyuaHUmGU9pv4kjoJ6CFTdSRO4zOhGVScr1BhX/xE89AA1DZdGd2jaa7RKuA9nsO9/OIhsoB9Qe3hmma+MEAks/p8NRMMrWFF3UqFzOYZVWoAZIck9eX9WSDlNocCU2kK9rv+ICGBF3dF54BHfAtmYxYrvzfieKq8WADU9fhlx/+XyL25UOIwCYTH8VzKdRCkpUs2TMNgRm0e+CnqaWK+LwEdMgmh0Y17sN+e+Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(6666004)(6512007)(478600001)(2616005)(26005)(2906002)(83380400001)(6636002)(44832011)(66476007)(66946007)(66556008)(316002)(110136005)(5660300002)(8676002)(41300700001)(8936002)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJBY0YyeHd4MHczQkFjaEkvN25WM2IvbERCTkIzandrN2dRWnpUL1VodUh3?=
 =?utf-8?B?cHFCZThHVGJCL0R4bWJOWXJRNTd0a1U2MXdNVjlHUFhRb2pkWVpwWHhQVFNx?=
 =?utf-8?B?ZmhQZVMyb0ZyOHFnQkRDWGxoYTNKaTN1M0tKcXZ0U21MNDJ3SHFSeG5QQzVk?=
 =?utf-8?B?aTR6QmFpbzJvMGlGR0FPQk9ZRUxQU01la2k5MUdCNHFxcnNiUkkzWllaVGRj?=
 =?utf-8?B?NEtqUnBxNkpYenNNV2tGTXBkRFpKS2tRUVQvS2FBZ0VvZVhhSDV5VjFaTVc2?=
 =?utf-8?B?NXRoUGlWWHN3TnhWWkxGcHFFMGpXdUpRa2hzUWFVUHFqK1I2eEVERnF0Ynp3?=
 =?utf-8?B?OEtxNktWelh5cHhZdFVVYTg4dkxZT0RPTUtMd1pRcGlLRWFBRmRkRk1qQzcx?=
 =?utf-8?B?cHo0LzNOZldUTTdjeWJiOURiN2E2M2gwN1Z3bWtuTHdCeExYR1NSOWJNNGtz?=
 =?utf-8?B?V3JtYjFxdEVvZHlTL040YWltU2tpVzliZ1NvTDFxRlR5MXJ0WTU3c2NlUDF6?=
 =?utf-8?B?R0xqMVl5MEJ1dkQxb1RSaFFnb2xKdE1PMEhVcjA3Q2piaWEvbHFIWHQyZkZZ?=
 =?utf-8?B?aW5SRWl5bUczejk3eElkTUdGejBuWW10RjIweWRuMFV0eGR5U3B4ZHRxenkr?=
 =?utf-8?B?bGg0bjR3cmdkRXQ0OHc1d3JWYVhTT1hRbDNPVWRpZUQwcFVnQ3dSR3lDYkZ4?=
 =?utf-8?B?M0xObE5odmVjamVSWHptVzBETnVxclhPcFg1cU9kTTNzNWhIRHR3cWUyVW9V?=
 =?utf-8?B?TWg0WW95dkNrS3pKSHYvcHdZL0ZsYmpOTlhtODh5K1ZvWklnYTFKd3RQRUNK?=
 =?utf-8?B?cXNYRGlHSUxEVUFiMVJ4WDMyZFpubjF2Qm9ibkRKZG5IZGN4eE42QlRQRS8w?=
 =?utf-8?B?cXpONWIzVXczYUhJOS9IOEJweU9EcGwzbGdLQ2lrbU5DZndxNEx0M3NkRnc4?=
 =?utf-8?B?R0xVZGpUZFE0YnBTaFVtditzbWMwTy9RTDlVbURHZlFYbGg3K1EvY2tUYXJG?=
 =?utf-8?B?bWZ0N21DeXA2bnNlS0dUdEJqZUtSc2hFSVYxOHAwMnZPYnhjOGNtN2dQR3FU?=
 =?utf-8?B?dUNkT3BRRUJ5MzBTTUFHTE5NZmpSUmtRM250eFZteEJ1VWY5SDNwQkZpLzFi?=
 =?utf-8?B?emJYNnlVNVVBOUhkQmowL1QrQ3dUbVcxTjd2ODEvV0V5QUkvV1BXeG8weUN6?=
 =?utf-8?B?MzVDSzg1Ti9Wd3pLMy9CdHdRWGNGQWRHdkQ1bDJZT0Z5VVhMQVh2RkFsNHp1?=
 =?utf-8?B?THVHYisxWnZPTmVweVBMTUpnNS9YQXBSa1NjeXRWdFBWYUYvS3I1NHdadnV4?=
 =?utf-8?B?NnJvcFlSa3BVNzB3Q3VzeFJIMlpQWkUrWmh1azhYRFVoU1ZKdkkwazVHUitu?=
 =?utf-8?B?c2tMMWYwQlEreTVpSktIK2NvenFiMTMwMTU2VlRRd3RSc2U2cTd0M3pwUURn?=
 =?utf-8?B?YlFLM0l5N1cwdW1CWkxBTTROQlJzNG9FZWw2Rzl5Z1FRRG0xa1VwUlVsSmlt?=
 =?utf-8?B?NnBKWElkQndDT0VlM29YcE9CSmVoV3BCNWJVVXo4VENIM1pMSDBoSGxMblpi?=
 =?utf-8?B?UnJGZ05kM1ZUa1JOT1ZmMFVrWkxqRm9rcWRYK042UDZ5emIyUGJ1VUNGeUhx?=
 =?utf-8?B?MkE1c28vT0l6NDgyc2d2Z1JtNERLdlBFL2h1aFV1Q2VRNnkvWDBldnJESUVF?=
 =?utf-8?B?bERUTVB0OEdmQURFY1Q0THZVOWxmalcvZFd0aGxNZDBnQitTWThId1dwQjdF?=
 =?utf-8?B?L0srTndabnJIbEVYb0dTdVlLK0duN0dSV0pMcC9kK1M5K3A3NUlhbVlveFh3?=
 =?utf-8?B?Z2hYWTN4OEdHMVUrWmpDNm43czMwRHo3UW5RektoS0d0MGJIenJad0Znb0FO?=
 =?utf-8?B?S3YrUG9MY2luYWh5RUR1L3VzWnhtRDBMSlAyV2FwSFJzdUpHaTQ0eXh4cVlH?=
 =?utf-8?B?ejNHSFUrL1Bpb1NmUm5ianVJMDZZeXBTUmdpS2kxZlBTKzBLQjB4UTlCMUpF?=
 =?utf-8?B?ZmtqelZYR21EVHJiR3E2OWFXSUIxdUNYTlYyeU8yVmVuT2M2aXJVTWhNMHhO?=
 =?utf-8?B?YlBBSWlBT3dHdXZCK3I5ZGdieHl5eVdIK040ZGtqbzhueTF0S2JkUFlENXRk?=
 =?utf-8?Q?300Yb7F7Kfx5IA4plrxZZ3ap4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bc437f-d95f-45bf-0c5e-08dbb46d53d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:23:05.6490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6JiOw4EJFhc4CQxv7WdxP+YPvVDS1xXs59QnXmdRWR3wdgWWvaRcYjQuvwblqp2EZQ/F68Uz3fx9E7SlXwIIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
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



On 2023-09-05 16:13, Mario Limonciello wrote:
> On 9/5/2023 15:07, Deucher, Alexander wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>>> Limonciello
>>> Sent: Tuesday, September 5, 2023 3:26 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Subject: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer
>>> APUs
>>>
>>> IP discovery is a good line in the sand to expand seamless boot to 
>>> more ASICs.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++-------
>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 9159a7b993ab..19265dbe592e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1296,14 +1296,10 @@ bool amdgpu_seamless_boot_supported(struct
>>> amdgpu_device *adev)
>>>        if (adev->mman.keep_stolen_vga_memory)
>>>                return false;
>>
>> This probably needs to be revisited too.  I don't know why this is an 
>> issue.  This flag just means the kernel driver keeps the stolen VGA 
>> region as reserved rather than releasing it back into the pool of 
>> available memory.  I don't think it should directly affect this feature.
>>
>>>
>>> -     switch (adev->ip_versions[DCE_HWIP][0]) {
>>> -     case IP_VERSION(3, 0, 1):
>>> -             return true;
>>> -     default:
>>> -             break;
>>> -     }
>>> +     if (adev->asic_type != CHIP_IP_DISCOVERY)
>>> +             return false;
>>
>> Probably need input from the display team, but I think a number of the 
>> older chips we'd probably want this too.  Maybe base it on the 
>> DCE_HWIP version?  DCN 1.0.0 or newer?  Or maybe  DCN 3.0.0 or newer?
>>
> 
> I think it will only work on the older chips if the 
> adev->mman.keep_stolen_vga_memory check can actually be dropped as some 
> of the older chips explicitly set it to TRUE.
> 
> There are other non-obvious dependencies too like:
> f0882d3afb9a ("drm/amd/display: prevent seamless boot on displays that 
> don't have the preferred dig")
> 6349c73859cb ("drm/amd/display: For ODM seamless transition require AUTO 
> mode")
> 
> So I was trying to be cautious in just enabling a few more things right 
> now.  I think essentially this "only" enables for for Rembrandt, 
> Raphael, Mendocino and Phoenix.  I tested it on Phoenix and Rembrandt.
> 
> But the module parameter is an escape hatch.  Let's see what display 
> team says.
> 

The core code around this should support DCN1+ and DC has logic to check
whether we can actually do a seamless handover 
(mark_seamless_boot_stream). If it's not possible we'll still reprogram
the output (as in the case of that first patch you mention above).

Not sure about the stolen_vga_memory thing. But that's a question
separately from the ASIC generations supported.

I'd be fine to allow seamless boot for DCN1+. Though would it be 
considered a regression if we had to roll this back and only allow
it for newer ASICs? In that case maybe DCN3+ is a good cutoff.

Patches 2 and 3 (with Alex's comment addressed) are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry


>>>
>>> -     return false;
>>> +     return adev->flags & AMD_IS_APU;
>>>   }
>>>
>>>   /*
>>> -- 
>>> 2.34.1
>>
> 
