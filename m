Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 14:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A7A10E140;
	Thu, 13 Jan 2022 14:40:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D4E10E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 14:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJBmgMGU/LRv0lCAYDwzvQwC6aLBCIjYpJly5DlKFFcKatPrHsOPMs6Q6RrNy4eZmN48qm2bJXF5nC48VC4BbMS3TwhhVtSPGER7yg/SZ7qjTfgrz+ZbvC7bdoLJUoqn1Nh5+ju6N1YX09LgDyiPUSYWd7WmeWNtRTKioNWCWd61/UwPVCioStgMfIYvzrNQU3Ll9jX6zsXxkH9ddQ6dcgR28PdzN+hoY8CyESY1/Q8kLOJxCEZJbln4iLm6QXjPgiB9kV2ADEuqW5nIEf/f7JuexOZSA+gMsZ2RkXLo0jU0IjlNs62yy27lQUA08sb0EeW3vu3b8rtZpNRMW5YZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDtoHTQZ3OuFcduP0uPpBDGB3Lx2F+9DpmljIcWchZw=;
 b=LUw4qdkUAXjNh9Dnoz9D2cTie1DhIaeUcqglTFK+XP9QQnGnfhR+QD4oJpnog14uF9MMQb+K7LKX8hb1GAKba1eiQbzQO9XYvxdmA6HxgPm1INwkmZNmNUGuOsjlhiNKNzdCkKhG6w6+qU7Sjh/r/bm3k78GRVwLcLpwj+aPzjC58sVxMX8ZiuPTEBc0QKo52LtsLh2Mh6Yc7aAQ210lgIcGj6gshfsHMCRaaMbDkrNM6DTygvZz/6qKrjJCQit2e4iAWMBR8IU6/bufIq28ZIRWmhmk5E0rRlklX+OzpeHxK/wvhkN5rrsGLud6nmYLz9zd0i6U1cuIyK7mnUX/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDtoHTQZ3OuFcduP0uPpBDGB3Lx2F+9DpmljIcWchZw=;
 b=pGX3ul/5o3n/JkeV0t4Uzr6erYILULBmXD4yegrXokNjiJ97FyVJpzS1Bvh+PLOY19LcnpNE+ZWPqRiTg0DEX9DzRGp/VoaA+Og14EWTMJmYrR9wFXvfARXujBftsGdSA4Kn/VW6EeTcUDM1dAalUjcbOcQ/W/vDuWU6kbhXY4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 14:39:57 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 14:39:57 +0000
Message-ID: <21fafcd9-ba68-5373-a66f-57dba908fb39@amd.com>
Date: Thu, 13 Jan 2022 08:39:54 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amdgpu: don't do resets on APUs which don't support it
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220113040103.311160-1-alexander.deucher@amd.com>
 <1586c31f-9e84-c63b-8abc-1862b08cf707@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <1586c31f-9e84-c63b-8abc-1862b08cf707@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26caabab-5f99-4a6a-c2d8-08d9d6a291b0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5175A38080397DDF14A3AFC0E2539@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3z05hHR/iQxmaZeP7P0/PccW5ZFQ6WHPLRPJ8GG0r4+et6HXA567DTh314cjqmf35wrpPk7FIO8EuoJAtVqDU+1GgzM7MzXaOLSbT3mh6t7L7q3uJQiTB1rl3PWTyThW8PqfekhgdhyF/BIkcZUB+orC9Fryc6kzMAVyDitdqQfPiTsi5B4GuGNx0kTmBkRrOmOyllkplOZE6r6vWWZdUhOUmU3sUef35QJaA3b+KK+3aKgg6NnUhhjulJU4PTKsDjyE+giTBApFlNZAy7NlYC9VcWr+nn3w5k/JNJk6jGHhq/kKXp8vlHHDgDYsZKmiEUCp7an6ofwlclsHJke67lD8SSl5edx6pXb/wXbNAZZSI9McZKFQsQhNDqnYvBxFoUaNEGj+EYx4LbzUTBAHrQXbLP5RUjM5A5ALdqpp+GmdCWYU4CsnxExyjXZZjgwH+rlHF/D1XB08rwuYRfagYyC4QwcTk6yPss2IZh6fp0zGtGdfAKJsOrzmNP2U10Gqg8SpkTyCSDiJf8ZeWgNFbJ6murjmjVHTOSAhLyUMCxJIoQJLuvfJ865cAXodpC5rUya7dOtItZkXpJ4YAyrci1LaSaWiPzcS+6bapZVEOezXazcReCje1y1q9GC5JS6Z6in5hmf8yHUOGpzqUw1AioOk1bTus/4TC0xZ2e9uNG7t/GGmyxnZGRzZDMZojIho8BFI7YV3teWs1b6bXYJBglZQK7gMjTelL8SPtskZpwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(86362001)(53546011)(186003)(110136005)(31696002)(2906002)(508600001)(6506007)(316002)(36756003)(5660300002)(8676002)(966005)(66556008)(8936002)(83380400001)(66946007)(6486002)(66476007)(31686004)(6512007)(26005)(6666004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBGZndHcG9VQXI1a2pEWWFxNHd1cFJHYnJSQjJES3ZVQjBtOXZtdlhCRWxt?=
 =?utf-8?B?Y1Vnazh5cHpFSHpLeTdtMFVENXRka2I2dFZDZS9VNERyU2ZyU3U2NXI4QzBh?=
 =?utf-8?B?S1lteEhQOHNQNTM2TDloS1dQVXV2Y0dQN2FyWUxITWgwTmZxSkF2djA5Vzdh?=
 =?utf-8?B?RW1qOGxTbWdTR3VINEtvM2V3L1pOMTZ5em85QlRwUU0rM2N3K1RNTGZwUnZS?=
 =?utf-8?B?ZldPaU1uSTFVbFl6TkUwcno2d3o3Mmx2TXN2WmNZcStiOWJZbXQ4d3h1RTdD?=
 =?utf-8?B?SzI2L0NjZ0xRVWZmOWMvNWV6VnJKZWEyTHhiaC9CR1dncXp4YVMvUDZaaGE1?=
 =?utf-8?B?S3lXTkZkclhHM3lWVlNHVmdGOS85WmFqMkpGTS8zUHY1RWl3eFlKZmZnbFgw?=
 =?utf-8?B?b25DNEdmMXdhR1ZGdDlXOXpFbXdGRXIwaU50anhqck1PMHZGN3BnamY1Q1JR?=
 =?utf-8?B?WWRJRjRVWmNUK2V3K1Uyc2lTNy9pMEE3L3A2ZEVoaS9Jc0xmRnZTd1hvNzlN?=
 =?utf-8?B?dnlmSFcyTS9aYVppVVBheVVTeEFaQW81WUJQTjZDZ3ovYVZidmw4SndLcVhH?=
 =?utf-8?B?RjlyYlJQYVRaWmNVQ2d1VU9rMVJGL3lNdWd1UGRYbnJzTUVtYk9ia1E1NVNU?=
 =?utf-8?B?ZE9WekR2N3RuYzVXbks4SUhkVGU5VlpIYVFlWGxuTi9uWGVrWUc3a2xvTGlH?=
 =?utf-8?B?dnpwRS81YndGaXNWaVVVYUc5UEdUSU8wVU1rUU9aeWRvYXlIWG1sYXRkdzl4?=
 =?utf-8?B?V3N2UUFac2d2VjFKTVhBTXRGWWlWOUlBRXcrbEl1VjRRV3hoWVFGWndSTnlk?=
 =?utf-8?B?ck5KZVRTSURPRys5WVhVM1dDRDJ3cnhDSnptVE9jaS92dGlWcWw5NXBqa0hq?=
 =?utf-8?B?cFc1azl1K2lHbUxwNUFmb1E5NEVYMUhIYVNDeGZuY294MHMwWUhPN1R1cVg4?=
 =?utf-8?B?aVFQY1VPa05yYUdMRUN1V0R4S2Y2NFd1UjFqSVM4NEZnRHJRSS9qTDVlN0pt?=
 =?utf-8?B?cDh4QjFMOVJIUUUyTUNPSWk1d1JmV01IK0sxSWZBQ204em8wQUV5TmNrMFI5?=
 =?utf-8?B?QUdxMllFK2w0OExuL3piM003eXJuYUZsYjBDbmVscnl1aDZrMUkxVnk1Slgr?=
 =?utf-8?B?RW04aklTL0d6M0J1cjNWZ2dEdThRQXZhcmZBSU9uNk1KVjJxTi9mcWUyMEpB?=
 =?utf-8?B?NGRNbjdZRTl2cC82YWljL3RHTDZUNnFwTEp3TlRKdDFJSk4xWG5CbnN6Qzd6?=
 =?utf-8?B?aTVWM0w2d0JBNHcySVF2aXJmRXZqUVlvV1FkMUZKeit2REFnRnZsN3JsYUpu?=
 =?utf-8?B?US9WbmNsUVRkV1VVcmZtMVFBMk5sR0dGcUUzdVE2WXlnUnJvVThKZm01aWJs?=
 =?utf-8?B?OGswT0ZTT3dzUmwzSHVkb2tENGxvSVFyWXhqNEFhK0VmQmNRN0Fla2xPc094?=
 =?utf-8?B?bEowK1lvTEhDeVdUQi9RVEo5M3lvVzJWT0hLZEt0ck9OOUhZUGQ2S2tTMnZ1?=
 =?utf-8?B?L0VkK3lnYW9vM1dQRmpxOFV3SjJ2aHhPTjFORHBWMVdtYW1qUjdDamFIUUN3?=
 =?utf-8?B?K1drcXhvL3FxNVU5UHA0VWRpZGEzS1k5UlZTRjllSVlGN0cwY00zK1EyNUN5?=
 =?utf-8?B?ejlBTkl2QWFYcU40anh1WjlXVUo4dDNFeFdhL0xVbnJrMjlRaTNSTGtnbklz?=
 =?utf-8?B?UXdOU3NFZGQwVWZLYkszb253T3A3UXIvUlNRbFk1UkQ4bm9NRzRuMjJjWW1Q?=
 =?utf-8?B?d2h3VHNMY1h6djYwamt3WkFhRjRVQkNQNU91VDU3QTlwUUx1VS96UU1pM2pH?=
 =?utf-8?B?QVUxTnEzMWdITzY1Q096TXROOGE0bnRDeUpIaHk2aVlsaDRIcDVEYzIwbUVC?=
 =?utf-8?B?a2xacnBXenpjTFdZT2tqVkVCMm83UGVOUFRjT2V3STNVMmlzU1BhZ085S0Rz?=
 =?utf-8?B?RjcvcFlFWC9XaWZMWGd1aHFscWw0ZUZoSGxUTlk1UVNPMktSbVovTEpOeUZi?=
 =?utf-8?B?aTFwTm13MUhXTzMybGRJS0xrVmNQcmVzUXJCOHZEWTlRZ25LOE9vd0c3YitY?=
 =?utf-8?B?d0thWjlmcWszVE5vM0dJaUpaaStRQVhaNGcxV0pJVi9jcm1zKy96TmY1UE10?=
 =?utf-8?B?OERKejc1dVB6TlFYUXJnTUlrT3g0QUs3ZzZNUGcrOXdWYmVZR2lITGhmWXBM?=
 =?utf-8?Q?6jmS2fNYWmwbw8SkDNnDqa4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26caabab-5f99-4a6a-c2d8-08d9d6a291b0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 14:39:56.9149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPjU+lNfUAF+16t+CuXtuCgZ2LIZ3G4YiwzPrHBD3fN2H5KGgTltiZEy8DDlIfAbirQxUVjPtmZM5dG1RPb+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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

On 1/13/2022 00:56, Lazar, Lijo wrote:
> Hi Alex,
> 
> What about something like this?
> 
> bool amdgpu_device_reset_on_suspend(struct amdgpu_device *adev)
> {
>          if (adev->in_s0ix || adev->gmc.xgmi.num_physical_nodes > 1)
>                  return false;
> 
>          switch (amdgpu_asic_reset_method(adev)) {
>          case AMD_RESET_METHOD_BACO:
>          case AMD_RESET_METHOD_MODE1:
>          case AMD_RESET_METHOD_MODE2:
>                  return true;
>          }
> 
>          return false;
> }
> 

I think the approach that Alex shared *might* be more flexible to also 
be used in the aborted suspend case too on s0ix.  There is some 
discussions going on for that right now.

> Thanks,
> Lijo
> 
> On 1/13/2022 9:31 AM, Alex Deucher wrote:
>> It can cause a hang.  This is normally not enabled for GPU
>> hangs on these asics, but was recently enabled for handling
>> aborted suspends.  This causes hangs on some platforms
>> on suspend.
>>
>> Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend 
>> (v2)")
>> Cc: stable@vger.kernel.org
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1858
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/cik.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/vi.c  | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>> index 54f28c075f21..f10ce740a29c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>> @@ -1428,6 +1428,10 @@ static int cik_asic_reset(struct amdgpu_device 
>> *adev)
>>   {
>>       int r;
>> +    /* APUs don't have full asic reset */
>> +    if (adev->flags & AMD_IS_APU)
>> +        return 0;
>> +
>>       if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
>>           dev_info(adev->dev, "BACO reset\n");
>>           r = amdgpu_dpm_baco_reset(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>> index fe9a7cc8d9eb..6645ebbd2696 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>> @@ -956,6 +956,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)
>>   {
>>       int r;
>> +    /* APUs don't have full asic reset */
>> +    if (adev->flags & AMD_IS_APU)
>> +        return 0;
>> +
>>       if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
>>           dev_info(adev->dev, "BACO reset\n");
>>           r = amdgpu_dpm_baco_reset(adev);
>>
> 

