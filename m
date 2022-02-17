Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6646CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 04:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98A810E8BB;
	Thu, 17 Feb 2022 04:56:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022B610E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 04:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc7kxjUk1xGGvff50uUgC3coaBswJBckv5W7hc/IRWIGkxofkc1MhcO45A6EWVp4cBGTr7vzDjbGvOmoBa6aT4qQvqVNfe2NBKMK2IfD5KY29OcfksPQSVCYCJvkrLL2dI9ElXCiW9pc4yA4sXnpReYM6yPiWBOiCNEvzgrr9D+7JY97/R9Fl8M5QkOUBQVjD9UDIpb/Y8u06Eikog25HBInzz1XUlTLa30YgfvXnnb/yFQWEe9MVDM6YeCo1yTk7a6e4UoE7rBrmZuJ3i3lDJMqS7jIuMSaPSmU6khduoyBys+vY4Yf67HJN0WnG1mNJ6Yl3Wke5mXAGz97ofC3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2xs6suJGQV8R8gKsRLrXIrT8atIYdho40bR3EEfnhQ=;
 b=CzRFbv9nRxq6I539dCXyz45yEa8KzXYhHvzWEZkdNb0T7NmRqO8aIBEFAdpTUQ6y1YZhsNAHnJpwx0852fOgkqzCos4prtz0LDa0O0Zj8E2b272RsI5aUE6mle4eCS7r64aTbQnRNG4jsjFc4jPGf8mGmmzBhuooI1+3Ebk2qxvEi+d2ULXb+vzO0ZPWaJvEiuiijGqUqO8X5CDgtzHfLsnsV5e/pMuI9BSYSZVCtOZI/VqwPiV7rAI8Yynt3f/Do2PK/OU57lbvdmvcuP+V2HGMzIwqLo+0OORZ2tlQuTE/ktMhDJXdaPVQ5sFYIh5t/ErHdH1DuiDKq18BqGLePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2xs6suJGQV8R8gKsRLrXIrT8atIYdho40bR3EEfnhQ=;
 b=K0+LGyrxrQOLjVDiF9uPoAHmwOJjfMAnOWuYSLRxTN2N8xmUFQRb7E5VRcqZhAemp8y5CpKylyUAkxWbowbTssHubPzfsOoz948J09gSPctJ/JPSGIANsQhsNxseLcMjZt8FCL04UoqJPHpC6uzqtNPSiOvHffopEhtGTlQwCZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 04:56:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 04:56:04 +0000
Message-ID: <9898c66f-3538-87f0-1f5c-6d6812ad883a@amd.com>
Date: Thu, 17 Feb 2022 10:25:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 05/12] drm/amd/pm: move the check for dpm enablement to
 amdgpu_dpm.c
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220211075209.894833-1-evan.quan@amd.com>
 <20220211075209.894833-5-evan.quan@amd.com>
 <a0d93ed1-31cf-6f38-b50a-8a565d7b1970@amd.com>
 <DM6PR12MB2619608CC405FBD172031C4BE4369@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619608CC405FBD172031C4BE4369@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::30) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b888f1f2-4693-4bf2-cab0-08d9f1d1ccbe
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38480D5ECE7EA8FAFFDB631397369@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYCwLo4ozqvTZotGHkiPv+Z9EAUomp4y03LZ9sLXPXR/Anb17CV/rRruQdtMVkQ/xkeqARLiUld+VTRUIlC8+jw7o8Qw/zI0B8JOKm3lWeDPNgPceIoXH9ukuVCU2OZlQyuv0Wdrv6ObanNvgWxP6SXI8y7WM8i1iYRAj6IDU0nGJzLSEaAH5JgOpd5NNil/J98b2iw7ilh1aXyUnxMkMfY306iR03tAWbnCsVtClsUvqN4XV1gzKiOr4LU2IpehF4aohJS20uAISWDNNnF+Mv/QiVae6noej07wlfXbPfMCuYrWzsvZn8b2hSJOraa2t/6tShh73tw1O5Ph0IN3E5X68GtxGBtso4/o5jiU4H1hfym7zTfbdHmHy6eVPG/UlwpE4P0/z7NYTZ4FIm1+iGvIEzsv3v+tVXSULXd6xN9ieXw3CXdaxFDCsrPMtZL9x5n65cE2BhPQ0SFkVJzYB8iXci80BOCsm0Xg7RwwfQou5cE/g8eVfjUrVPujJX7MZBtfePFumTF4Bn1KqzCQOSe0McpDVdC6mU11yoEf3eVvi+goyV7LyNhOVcKwVFuPIuOgMq554WRQFfSGV+LhaN6WFx18hqHV3mv64skNd+tyL1hRl76eVI6xBdAIr25eXK1DmKELiHoBSsI4gYL0fAwf25Y3eYETbzsqLQz+gbMUZ7qfX2wuG3RJgfd48gkMwMuAXqetW/v+0pN/H+o1srr5KbvokI0C+XmzMasOGso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(38100700002)(110136005)(6506007)(316002)(6486002)(186003)(53546011)(2906002)(6666004)(26005)(8936002)(86362001)(30864003)(4326008)(8676002)(508600001)(66476007)(6512007)(31696002)(66556008)(31686004)(5660300002)(83380400001)(36756003)(2616005)(66946007)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1qamtyVFVVMWNUUnNGRkovWm5ZbCt4ckxHdGlyYk5FSy9xSWRlZjhvcnJT?=
 =?utf-8?B?VWg3NmwyeWErMDFZSkR0SHoxS1hoSnRvaEJ1bnlYNTlXdlBZMUVWeWNSODZT?=
 =?utf-8?B?VE5yR0ZacmdLQzU1blMrODBERndSanZENm01bnFVcnZ0WlR4eE9VY2JhM1hW?=
 =?utf-8?B?OFVVZ21Ta0JwcmRIR0FBU3BUNG9MM0dOSVRPZDY5bVAyMVFXaS9xRG1YVytv?=
 =?utf-8?B?U2M5aTBzMU5xQmU2bVNuZjJUSUJUSTVrWWdRa0NPK0lCblZIM2Fmbk94dUJG?=
 =?utf-8?B?em9wYWErbS9sTUdZMXBaeFMwU1IvR05yQW4rdWxnYkpadjB1OTB3Y2tGaDI1?=
 =?utf-8?B?c1J5UTVJUVpRNENyZVpyM1ZaRmdoakJ3eiszdG5PaVdXeXhnLzdiMjMxZUVt?=
 =?utf-8?B?cWwzL3hETFNUcGlReVIxcmQ0azRXaXQxZ3NqSC9zbWZIRkVMYnJ0aW5mVGpm?=
 =?utf-8?B?NTd1Y09kbGcybjNoQi8xUXBvKzVFS3hoeXRZdVcxcDdPTHB5ZVBiZVk1WGZh?=
 =?utf-8?B?R3daNGQwNitLWENIczl6aE1qWnpsQ2tkVExFSFVFMHdoYVpRdW9Ca1hQd3Zv?=
 =?utf-8?B?YU5pUDArVURkeHd0TTMwcHpJdFB2WTF6K2JScG51NnViMTlRZGE5enBGUlNN?=
 =?utf-8?B?dXNRZDljbVpLb3ZMbFI1SkpzcHFnZHo2ZHhZMTNWNlhFQWUyRHdtRmJvbkVH?=
 =?utf-8?B?eExkdTlnVi9sYzVnZmtONU9jbGlLS0paK1VSbi9oVHRHTk1DaDAyOFpOdllT?=
 =?utf-8?B?T2t5Y0FDVjg5RUwxcExLUVhEVDFPZHJJRXhicVJ0MGFkQTdHZnVaTHcxa1Yy?=
 =?utf-8?B?aER6dXlkVDczVzNzdjl5VGpRMStObnNIcFZpQVFBZHNzQ3phNEhrbjFBM25l?=
 =?utf-8?B?cGFWZVVsNVRqWWg2TDBhOTN1dHNRR2tNRVYrRnVDcndoOWtnS2hrREZheWdB?=
 =?utf-8?B?UXZvN1ExdHo5bW56NHJmdCtaM1NWdWpSNGpuSDVzd1FYcFAwbjRLWklLS1Z1?=
 =?utf-8?B?bkExUUlqSFNuaGNCWGhiTU13L21CcTJxaVRqbWFpL0haeC9pRWZyN0pSSGFW?=
 =?utf-8?B?Rk9GblJsNkZKQjJLbGhkemY5cHJtN29wTjBHVXg5dzlJTmpKL2FFYzdEL0t6?=
 =?utf-8?B?UnhPNjlsZGJselJ6QVMwZFd4TmNUenRnZjgyNHVBR1kzVUVWMFQvRTBaQ0th?=
 =?utf-8?B?RDMvUHBOK0toOTdSUUoweTJiZFFFNU1sOU0vdVZPRU5tek82RGhuckRvVTFn?=
 =?utf-8?B?eVpFUDgrNmpVQUFGYmZyZjhYemZscjc3a2M0SDE1QXVRVjUwOWJneDBwNUIr?=
 =?utf-8?B?VDJxL2Y0K2tVdU94MXFsT0JNTE05VGxDWHFOT2hUa1orNkVoSHVESjU1cU93?=
 =?utf-8?B?T1F1ZS80eitiWmx5M2hyREJHWkk5MG5KUUJvVzE0UHNoTXVoMm82RXNIVGcx?=
 =?utf-8?B?a2VwVWxWWU84ak0zb0ROUlk4dmxMaFhMYVdSbkxqMlF5Mjg1cTg5OHpxekFt?=
 =?utf-8?B?UnpIWTZ6em9vMDh1ZUd5cDBaZDVWbjBCSU92Q093NDc2dFlwWHRJVU9UZ2d0?=
 =?utf-8?B?bkJYSnphWFRzWldhSzFPckdKSHNXU2duckZ6ek50MklZN3V4blprMTRyM2JK?=
 =?utf-8?B?RU5WaUhKaWRodWlubUZPR3lrVEI1Qm9yOVhoL1lyUDY1aW5xYXU5VExESEo5?=
 =?utf-8?B?cFI3RjFubDRkYk52STVkSHZraDZLZngrRWkyc1NlQktoc2hiTlVUYVJWTEJ3?=
 =?utf-8?B?RjlnWG9KYVlpSUFiUEgxTkRrTHUvZGdhckhqT3EybStmZlZ6OS8rd3hIYVFZ?=
 =?utf-8?B?NXJJbVN3SXNYaFJVL3loODk2TjUzd3I0Z2QzU0l3UEwyVmVPcEk3Zm8raCtD?=
 =?utf-8?B?a2ZPTE9aZ0FSYnhlaUZ4KzJEbDRabzRiRjk5OVFiRTExak1nSjBuaGN3STdD?=
 =?utf-8?B?dmUrd084SDRDTVJTODE4K01lNTM1bGFTU3hPK3liTncwbVFhQ3RnUTNKMzFQ?=
 =?utf-8?B?cXNTbU9UOTJROStvOW9Mc2lVY1prbnRLc3AwNlpzLzVpMy9BRGE1ck1IeG5N?=
 =?utf-8?B?WkFzbzhVdlJKY2R4NVg2SUlNSTBjR0llbldMUW1lUWVHYlpVQzdkNDFjQ3FD?=
 =?utf-8?Q?mBFk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b888f1f2-4693-4bf2-cab0-08d9f1d1ccbe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 04:56:04.1556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/ZxD0iHdb7poqeYuXMYBaMilYjDHD6cn2A65aIK2TAZmzMmcSOfd4GBhJk7vOQg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "rui.huang@amd.com" <rui.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/17/2022 8:05 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 11, 2022 9:40 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>> rui.huang@amd.com
>> Subject: Re: [PATCH 05/12] drm/amd/pm: move the check for dpm
>> enablement to amdgpu_dpm.c
>>
>>
>>
>> On 2/11/2022 1:22 PM, Evan Quan wrote:
>>> Instead of checking this in every instance(framework), moving that check
>> to
>>> amdgpu_dpm.c is more proper. And that can make code clean and tidy.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I2f83a3b860e8aa12cc86f119011f520fbe21a301
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |   5 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  16 +-
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 277
>> ++++++++++++++++--
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  25 +-
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  12 +-
>>>    .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |   4 -
>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 117 ++++----
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 135 +--------
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
>>>    9 files changed, 352 insertions(+), 240 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index 2c929fa40379..fff0e6a3882e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -261,11 +261,14 @@ static int amdgpu_ctx_get_stable_pstate(struct
>> amdgpu_ctx *ctx,
>>>    {
>>>    	struct amdgpu_device *adev = ctx->adev;
>>>    	enum amd_dpm_forced_level current_level;
>>> +	int ret = 0;
>>>
>>>    	if (!ctx)
>>>    		return -EINVAL;
>>>
>>> -	current_level = amdgpu_dpm_get_performance_level(adev);
>>> +	ret = amdgpu_dpm_get_performance_level(adev, &current_level);
>>> +	if (ret)
>>> +		return ret;
>>>
>>>    	switch (current_level) {
>>>    	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 9f985bd463be..56144f25b720 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -813,15 +813,17 @@ int amdgpu_info_ioctl(struct drm_device *dev,
>> void *data, struct drm_file *filp)
>>>    		unsigned i;
>>>    		struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
>>>    		struct amd_vce_state *vce_state;
>>> +		int ret = 0;
>>>
>>>    		for (i = 0; i < AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {
>>> -			vce_state =
>> amdgpu_dpm_get_vce_clock_state(adev, i);
>>> -			if (vce_state) {
>>> -				vce_clk_table.entries[i].sclk = vce_state-
>>> sclk;
>>> -				vce_clk_table.entries[i].mclk = vce_state-
>>> mclk;
>>> -				vce_clk_table.entries[i].eclk = vce_state-
>>> evclk;
>>> -				vce_clk_table.num_valid_entries++;
>>> -			}
>>> +			ret = amdgpu_dpm_get_vce_clock_state(adev, i,
>> vce_state);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			vce_clk_table.entries[i].sclk = vce_state->sclk;
>>> +			vce_clk_table.entries[i].mclk = vce_state->mclk;
>>> +			vce_clk_table.entries[i].eclk = vce_state->evclk;
>>> +			vce_clk_table.num_valid_entries++;
>>>    		}
>>>
>>>    		return copy_to_user(out, &vce_clk_table,
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 1d63f1e8884c..b46ae0063047 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -41,6 +41,9 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device
>> *adev, bool low)
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return 0;
>>> +
>>>    	if (!pp_funcs->get_sclk)
>>>    		return 0;
>>>
>>> @@ -57,6 +60,9 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device
>> *adev, bool low)
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return 0;
>>> +
>>>    	if (!pp_funcs->get_mclk)
>>>    		return 0;
>>>
>>> @@ -74,6 +80,13 @@ int amdgpu_dpm_set_powergating_by_smu(struct
>> amdgpu_device *adev, uint32_t block
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF :
>> POWER_STATE_ON;
>>>
>>> +	if (!adev->pm.dpm_enabled) {
>>> +		dev_WARN(adev->dev,
>>> +			 "SMU uninitialized but power %s requested
>> for %u!\n",
>>> +			 gate ? "gate" : "ungate", block_type);
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>>    	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
>>>    		dev_dbg(adev->dev, "IP block%d already in the target %s
>> state!",
>>>    				block_type, gate ? "gate" : "ungate");
>>> @@ -261,6 +274,9 @@ int amdgpu_dpm_switch_power_profile(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		return 0;
>>>
>>> @@ -280,6 +296,9 @@ int amdgpu_dpm_set_xgmi_pstate(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = pp_funcs->set_xgmi_pstate(adev-
>>> powerplay.pp_handle,
>>> @@ -297,6 +316,9 @@ int amdgpu_dpm_set_df_cstate(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	void *pp_handle = adev->powerplay.pp_handle;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (pp_funcs && pp_funcs->set_df_cstate) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
>>> @@ -311,6 +333,9 @@ int amdgpu_dpm_allow_xgmi_power_down(struct
>> amdgpu_device *adev, bool en)
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (is_support_sw_smu(adev)) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = smu_allow_xgmi_power_down(smu, en);
>>> @@ -327,6 +352,9 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct
>> amdgpu_device *adev)
>>>    			adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
>>> @@ -344,6 +372,9 @@ int amdgpu_dpm_set_clockgating_by_smu(struct
>> amdgpu_device *adev,
>>>    			adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
>>> @@ -362,6 +393,9 @@ int amdgpu_dpm_smu_i2c_bus_access(struct
>> amdgpu_device *adev,
>>>    			adev->powerplay.pp_funcs;
>>>    	int ret = -EOPNOTSUPP;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>
>> I2C bus access doesn't need DPM to be enabled.
> [Quan, Evan] The "adev->pm.dpm_enabled" flag is a little confusing. It does not actually mean DPM features need to be enabled.
> Instead, it just tells the SMU ip initialization process has been fully completed and the API is designed to be supported under such scenario.
> 
> Unless the API is expected to be supported under the following scenarios also, otherwise it needs to be guarded by "adev->pm.dpm_enabled".
> - Even DPM is disabled explicitly (by module parameter "dpm=0")
>    - some initial setups related APUs(smu_dpm_set_vcn/ jpeg_enable) fall into above scenario
> - The deinitialization was performed but reinitialization has not yet been kicked (resuming from suspend)
>    - those gpu reset related APIs fall into above scenario
> 
> As I cannot see any reason to support the I2C bus access API under the two scenarios above.
> So I think the guard "adev->pm.dpm_enabled" is reasonable here.

For I2C usage, it only needs the FW to be loaded. RAS uses i2c transfers 
and RAS may be enabled even if dpm=0. Similar is the case for any FRU 
access.

Thanks,
Lijo

>>
>>>    	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
>>> @@ -398,6 +432,9 @@ int amdgpu_dpm_read_sensor(struct
>> amdgpu_device *adev, enum amd_pp_sensors senso
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = -EINVAL;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!data || !size)
>>>    		return -EINVAL;
>>>
>>> @@ -485,6 +522,9 @@ int amdgpu_dpm_handle_passthrough_sbr(struct
>> amdgpu_device *adev, bool enable)
>>>    {
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>
>> Please double check on this one also.
>>
>>>    	if (is_support_sw_smu(adev)) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = smu_handle_passthrough_sbr(adev-
>>> powerplay.pp_handle,
>>> @@ -500,6 +540,9 @@ int
>> amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev,
>> uint32_t size)
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	ret = smu_send_hbm_bad_pages_num(smu, size);
>>>    	mutex_unlock(&adev->pm.mutex);
>>> @@ -514,6 +557,9 @@ int amdgpu_dpm_get_dpm_freq_range(struct
>> amdgpu_device *adev,
>>>    {
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (type != PP_SCLK)
>>>    		return -EINVAL;
>>>
>>> @@ -538,6 +584,9 @@ int amdgpu_dpm_set_soft_freq_range(struct
>> amdgpu_device *adev,
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (type != PP_SCLK)
>>>    		return -EINVAL;
>>>
>>> @@ -556,14 +605,18 @@ int amdgpu_dpm_set_soft_freq_range(struct
>> amdgpu_device *adev,
>>>
>>>    int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
>>>    {
>>> -	struct smu_context *smu = adev->powerplay.pp_handle;
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return 0;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> -	ret = smu_write_watermarks_table(smu);
>>> +	ret = pp_funcs->set_watermarks_for_clock_ranges(adev-
>>> powerplay.pp_handle,
>>> +							NULL);
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>>    	return ret;
>>> @@ -576,6 +629,9 @@ int amdgpu_dpm_wait_for_event(struct
>> amdgpu_device *adev,
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>
>> In this case also DPM doesn't need to be enabled.
> [Quan, Evan] This seems used by mode2 reset only. Maybe using the guard "amdgpu_dpm_is_smc_alive" implemented in patch7 is more proper.
>>
>> In general this patch assumes DPM interfaces to continue. There was a
>> discussion around getting rid of dpm and moving to smu component based
>> interface. This patch goes in the opposite direction.
> [Quan, Evan] No, they do not conflict. We can still advance in that way.
> I do not want to put those swsmu based interfaces into an intermediate state(some have "dpm_enabled" guard in amdgpu_dpm.c while others in amdgpu_smu.c).
> That was my only consideration.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    	if (!is_support_sw_smu(adev))
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -591,6 +647,9 @@ int amdgpu_dpm_get_status_gfxoff(struct
>> amdgpu_device *adev, uint32_t *value)
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -605,6 +664,9 @@ uint64_t
>> amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device
>> *adev)
>>>    {
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return 0;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return 0;
>>>
>>> @@ -619,6 +681,9 @@ uint64_t
>> amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device
>> *adev)
>>>    void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
>>>    				 enum gfx_change_state state)
>>>    {
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	if (adev->powerplay.pp_funcs &&
>>>    	    adev->powerplay.pp_funcs->gfx_state_change_set)
>>> @@ -632,27 +697,33 @@ int amdgpu_dpm_get_ecc_info(struct
>> amdgpu_device *adev,
>>>    {
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return -EOPNOTSUPP;
>>>
>>>    	return smu_get_ecc_info(smu, umc_ecc);
>>>    }
>>>
>>> -struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
>> amdgpu_device *adev,
>>> -						     uint32_t idx)
>>> +int amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
>>> +				   uint32_t idx,
>>> +				   struct amd_vce_state *vstate)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> -	struct amd_vce_state *vstate = NULL;
>>> +
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	if (!pp_funcs->get_vce_clock_state)
>>> -		return NULL;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	vstate = pp_funcs->get_vce_clock_state(adev-
>>> powerplay.pp_handle,
>>>    					       idx);
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>> -	return vstate;
>>> +	return 0;
>>>    }
>>>
>>>    void amdgpu_dpm_get_current_power_state(struct amdgpu_device
>> *adev,
>>> @@ -660,6 +731,9 @@ void
>> amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>>
>>>    	if (!pp_funcs->get_current_power_state) {
>>> @@ -679,6 +753,9 @@ void
>> amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
>>>    void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>>>    				enum amd_pm_state_type state)
>>>    {
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	adev->pm.dpm.user_state = state;
>>>    	mutex_unlock(&adev->pm.mutex);
>>> @@ -692,19 +769,22 @@ void amdgpu_dpm_set_power_state(struct
>> amdgpu_device *adev,
>>>    		amdgpu_dpm_compute_clocks(adev);
>>>    }
>>>
>>> -enum amd_dpm_forced_level
>> amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
>>> +int amdgpu_dpm_get_performance_level(struct amdgpu_device *adev,
>>> +				     enum amd_dpm_forced_level *level)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> -	enum amd_dpm_forced_level level;
>>> +
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	if (pp_funcs->get_performance_level)
>>> -		level = pp_funcs->get_performance_level(adev-
>>> powerplay.pp_handle);
>>> +		*level = pp_funcs->get_performance_level(adev-
>>> powerplay.pp_handle);
>>>    	else
>>> -		level = adev->pm.dpm.forced_level;
>>> +		*level = adev->pm.dpm.forced_level;
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>> -	return level;
>>> +	return 0;
>>>    }
>>>
>>>    int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>>> @@ -717,13 +797,16 @@ int
>> amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>>>
>> 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
>>>
>> 	AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->force_performance_level)
>>>    		return 0;
>>>
>>>    	if (adev->pm.dpm.thermal_active)
>>>    		return -EINVAL;
>>>
>>> -	current_level = amdgpu_dpm_get_performance_level(adev);
>>> +	amdgpu_dpm_get_performance_level(adev, &current_level);
>>>    	if (current_level == level)
>>>    		return 0;
>>>
>>> @@ -783,6 +866,9 @@ int amdgpu_dpm_get_pp_num_states(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_pp_num_states)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -801,6 +887,9 @@ int amdgpu_dpm_dispatch_task(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->dispatch_tasks)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -818,6 +907,9 @@ int amdgpu_dpm_get_pp_table(struct
>> amdgpu_device *adev, char **table)
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_pp_table)
>>>    		return 0;
>>>
>>> @@ -837,6 +929,9 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_fine_grain_clk_vol)
>>>    		return 0;
>>>
>>> @@ -858,6 +953,9 @@ int amdgpu_dpm_odn_edit_dpm_table(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->odn_edit_dpm_table)
>>>    		return 0;
>>>
>>> @@ -878,6 +976,9 @@ int amdgpu_dpm_print_clock_levels(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->print_clock_levels)
>>>    		return 0;
>>>
>>> @@ -917,6 +1018,9 @@ int amdgpu_dpm_set_ppfeature_status(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_ppfeature_status)
>>>    		return 0;
>>>
>>> @@ -933,6 +1037,9 @@ int amdgpu_dpm_get_ppfeature_status(struct
>> amdgpu_device *adev, char *buf)
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_ppfeature_status)
>>>    		return 0;
>>>
>>> @@ -951,6 +1058,9 @@ int amdgpu_dpm_force_clock_level(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->force_clock_level)
>>>    		return 0;
>>>
>>> @@ -963,27 +1073,33 @@ int amdgpu_dpm_force_clock_level(struct
>> amdgpu_device *adev,
>>>    	return ret;
>>>    }
>>>
>>> -int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
>>> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev,
>>> +			   uint32_t *value)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> -	int ret = 0;
>>> +
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	if (!pp_funcs->get_sclk_od)
>>> -		return 0;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> -	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
>>> +	*value = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>> -	return ret;
>>> +	return 0;
>>>    }
>>>
>>>    int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t
>> value)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (is_support_sw_smu(adev))
>>> -		return 0;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	if (pp_funcs->set_sclk_od)
>>> @@ -1000,27 +1116,33 @@ int amdgpu_dpm_set_sclk_od(struct
>> amdgpu_device *adev, uint32_t value)
>>>    	return 0;
>>>    }
>>>
>>> -int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
>>> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev,
>>> +			   uint32_t *value)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> -	int ret = 0;
>>> +
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	if (!pp_funcs->get_mclk_od)
>>> -		return 0;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> -	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
>>> +	*value = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>> -	return ret;
>>> +	return 0;
>>>    }
>>>
>>>    int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t
>> value)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (is_support_sw_smu(adev))
>>> -		return 0;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	if (pp_funcs->set_mclk_od)
>>> @@ -1043,6 +1165,9 @@ int
>> amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_power_profile_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1060,6 +1185,9 @@ int
>> amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_power_profile_mode)
>>>    		return 0;
>>>
>>> @@ -1077,6 +1205,9 @@ int amdgpu_dpm_get_gpu_metrics(struct
>> amdgpu_device *adev, void **table)
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_gpu_metrics)
>>>    		return 0;
>>>
>>> @@ -1094,6 +1225,9 @@ int amdgpu_dpm_get_fan_control_mode(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_fan_control_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1111,6 +1245,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_fan_speed_pwm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1128,6 +1265,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_fan_speed_pwm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1145,6 +1285,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_fan_speed_rpm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1162,6 +1305,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_fan_speed_rpm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1179,6 +1325,9 @@ int amdgpu_dpm_set_fan_control_mode(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_fan_control_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1198,6 +1347,9 @@ int amdgpu_dpm_get_power_limit(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_power_limit)
>>>    		return -ENODATA;
>>>
>>> @@ -1217,6 +1369,9 @@ int amdgpu_dpm_set_power_limit(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_power_limit)
>>>    		return -EINVAL;
>>>
>>> @@ -1232,6 +1387,9 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct
>> amdgpu_device *adev)
>>>    {
>>>    	bool cclk_dpm_supported = false;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return false;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return false;
>>>
>>> @@ -1247,6 +1405,9 @@ int
>> amdgpu_dpm_debugfs_print_current_performance_level(struct
>> amdgpu_device *ade
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->debugfs_print_current_performance_level)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1265,6 +1426,9 @@ int
>> amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_smu_prv_buf_details)
>>>    		return -ENOSYS;
>>>
>>> @@ -1282,6 +1446,9 @@ int amdgpu_dpm_is_overdrive_supported(struct
>> amdgpu_device *adev)
>>>    	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return false;
>>> +
>>>    	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
>>>    	    (is_support_sw_smu(adev) && smu->is_apu) ||
>>>    		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
>>> @@ -1297,6 +1464,9 @@ int amdgpu_dpm_set_pp_table(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_pp_table)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1313,6 +1483,9 @@ int amdgpu_dpm_get_num_cpu_cores(struct
>> amdgpu_device *adev)
>>>    {
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return INT_MAX;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return INT_MAX;
>>>
>>> @@ -1321,6 +1494,9 @@ int amdgpu_dpm_get_num_cpu_cores(struct
>> amdgpu_device *adev)
>>>
>>>    void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
>>>    {
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	if (!is_support_sw_smu(adev))
>>>    		return;
>>>
>>> @@ -1333,6 +1509,9 @@ int
>> amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->display_configuration_change)
>>>    		return 0;
>>>
>>> @@ -1351,6 +1530,9 @@ int amdgpu_dpm_get_clock_by_type(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_clock_by_type)
>>>    		return 0;
>>>
>>> @@ -1369,6 +1551,9 @@ int
>> amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device
>> *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_display_mode_validation_clocks)
>>>    		return 0;
>>>
>>> @@ -1387,6 +1572,9 @@ int
>> amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device
>> *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_clock_by_type_with_latency)
>>>    		return 0;
>>>
>>> @@ -1406,6 +1594,9 @@ int
>> amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device
>> *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_clock_by_type_with_voltage)
>>>    		return 0;
>>>
>>> @@ -1424,6 +1615,9 @@ int
>> amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device
>> *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_watermarks_for_clocks_ranges)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1441,6 +1635,9 @@ int
>> amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->display_clock_voltage_request)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1458,6 +1655,9 @@ int amdgpu_dpm_get_current_clocks(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_current_clocks)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1473,6 +1673,9 @@ void
>> amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	if (!pp_funcs->notify_smu_enable_pwe)
>>>    		return;
>>>
>>> @@ -1487,6 +1690,9 @@ int
>> amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_active_display_count)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1504,6 +1710,9 @@ int
>> amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->set_min_deep_sleep_dcefclk)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1520,6 +1729,9 @@ void
>> amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
>>>    		return;
>>>
>>> @@ -1534,6 +1746,9 @@ void
>> amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return;
>>> +
>>>    	if (!pp_funcs->set_hard_min_fclk_by_freq)
>>>    		return;
>>>
>>> @@ -1549,6 +1764,9 @@ int
>> amdgpu_dpm_display_disable_memory_clock_switch(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->display_disable_memory_clock_switch)
>>>    		return 0;
>>>
>>> @@ -1566,6 +1784,9 @@ int
>> amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device
>> *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1584,6 +1805,9 @@ enum pp_smu_status
>> amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_uclk_dpm_states)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -1602,6 +1826,9 @@ int amdgpu_dpm_get_dpm_clock_table(struct
>> amdgpu_device *adev,
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int ret = 0;
>>>
>>> +	if (!adev->pm.dpm_enabled)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs->get_dpm_clock_table)
>>>    		return -EOPNOTSUPP;
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index b0243068212b..84aab3bb9bdc 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -273,11 +273,14 @@ static ssize_t
>> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	level = amdgpu_dpm_get_performance_level(adev);
>>> +	ret = amdgpu_dpm_get_performance_level(adev, &level);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return sysfs_emit(buf, "%s\n",
>>>    			  (level == AMD_DPM_FORCED_LEVEL_AUTO) ?
>> "auto" :
>>>    			  (level == AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
>>> @@ -1241,11 +1244,14 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	value = amdgpu_dpm_get_sclk_od(adev);
>>> +	ret = amdgpu_dpm_get_sclk_od(adev, &value);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return sysfs_emit(buf, "%d\n", value);
>>>    }
>>>
>>> @@ -1275,11 +1281,14 @@ static ssize_t amdgpu_set_pp_sclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>>> +	ret = amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return count;
>>>    }
>>>
>>> @@ -1303,11 +1312,14 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	value = amdgpu_dpm_get_mclk_od(adev);
>>> +	ret = amdgpu_dpm_get_mclk_od(adev, &value);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return sysfs_emit(buf, "%d\n", value);
>>>    }
>>>
>>> @@ -1337,11 +1349,14 @@ static ssize_t amdgpu_set_pp_mclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>>> +	ret = amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return count;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> index ddfa55b59d02..49488aebd350 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> @@ -429,12 +429,14 @@ void amdgpu_dpm_gfx_state_change(struct
>> amdgpu_device *adev,
>>>    				 enum gfx_change_state state);
>>>    int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>>>    			    void *umc_ecc);
>>> -struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
>> amdgpu_device *adev,
>>> -						     uint32_t idx);
>>> +int amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
>>> +				   uint32_t idx,
>>> +				   struct amd_vce_state *vstate);
>>>    void amdgpu_dpm_get_current_power_state(struct amdgpu_device
>> *adev, enum amd_pm_state_type *state);
>>>    void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>>>    				enum amd_pm_state_type state);
>>> -enum amd_dpm_forced_level
>> amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_get_performance_level(struct amdgpu_device *adev,
>>> +				     enum amd_dpm_forced_level *level);
>>>    int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>>>    				       enum amd_dpm_forced_level level);
>>>    int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
>>> @@ -464,9 +466,9 @@ int amdgpu_dpm_get_ppfeature_status(struct
>> amdgpu_device *adev, char *buf);
>>>    int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
>>>    				 enum pp_clock_type type,
>>>    				 uint32_t mask);
>>> -int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev, uint32_t
>> *value);
>>>    int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t
>> value);
>>> -int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev, uint32_t
>> *value);
>>>    int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t
>> value);
>>>    int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device
>> *adev,
>>>    				      char *buf);
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> index 9613c6181c17..59550617cf54 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> @@ -959,10 +959,6 @@ static int
>> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>>>    	int ret;
>>>    	bool equal = false;
>>>
>>> -	/* if dpm init failed */
>>> -	if (!adev->pm.dpm_enabled)
>>> -		return 0;
>>> -
>>>    	if (adev->pm.dpm.user_state != adev->pm.dpm.state) {
>>>    		/* add other state override checks here */
>>>    		if ((!adev->pm.dpm.thermal_active) &&
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index 991ac4adb263..bba923cfe08c 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -295,7 +295,7 @@ static int pp_set_clockgating_by_smu(void *handle,
>> uint32_t msg_id)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->update_clock_gatings == NULL) {
>>> @@ -335,7 +335,7 @@ static int pp_dpm_force_performance_level(void
>> *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (level == hwmgr->dpm_level)
>>> @@ -353,7 +353,7 @@ static enum amd_dpm_forced_level
>> pp_dpm_get_performance_level(
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	return hwmgr->dpm_level;
>>> @@ -363,7 +363,7 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool
>> low)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return 0;
>>>
>>>    	if (hwmgr->hwmgr_func->get_sclk == NULL) {
>>> @@ -377,7 +377,7 @@ static uint32_t pp_dpm_get_mclk(void *handle,
>> bool low)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return 0;
>>>
>>>    	if (hwmgr->hwmgr_func->get_mclk == NULL) {
>>> @@ -391,7 +391,7 @@ static void pp_dpm_powergate_vce(void *handle,
>> bool gate)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return;
>>>
>>>    	if (hwmgr->hwmgr_func->powergate_vce == NULL) {
>>> @@ -405,7 +405,7 @@ static void pp_dpm_powergate_uvd(void *handle,
>> bool gate)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return;
>>>
>>>    	if (hwmgr->hwmgr_func->powergate_uvd == NULL) {
>>> @@ -420,7 +420,7 @@ static int pp_dpm_dispatch_tasks(void *handle,
>> enum amd_pp_task task_id,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	return hwmgr_handle_task(hwmgr, task_id, user_state);
>>> @@ -432,7 +432,7 @@ static enum amd_pm_state_type
>> pp_dpm_get_current_power_state(void *handle)
>>>    	struct pp_power_state *state;
>>>    	enum amd_pm_state_type pm_type;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled || !hwmgr->current_ps)
>>> +	if (!hwmgr || !hwmgr->current_ps)
>>>    		return -EINVAL;
>>>
>>>    	state = hwmgr->current_ps;
>>> @@ -462,7 +462,7 @@ static int pp_dpm_set_fan_control_mode(void
>> *handle, uint32_t mode)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
>>> @@ -480,7 +480,7 @@ static int pp_dpm_get_fan_control_mode(void
>> *handle, uint32_t *fan_mode)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
>>> @@ -497,7 +497,7 @@ static int pp_dpm_set_fan_speed_pwm(void
>> *handle, uint32_t speed)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
>>> @@ -513,7 +513,7 @@ static int pp_dpm_get_fan_speed_pwm(void
>> *handle, uint32_t *speed)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
>>> @@ -529,7 +529,7 @@ static int pp_dpm_get_fan_speed_rpm(void
>> *handle, uint32_t *rpm)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
>>> @@ -545,7 +545,7 @@ static int pp_dpm_set_fan_speed_rpm(void
>> *handle, uint32_t rpm)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
>>> @@ -565,7 +565,7 @@ static int pp_dpm_get_pp_num_states(void
>> *handle,
>>>
>>>    	memset(data, 0, sizeof(*data));
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!hwmgr->ps)
>>> +	if (!hwmgr || !hwmgr->ps)
>>>    		return -EINVAL;
>>>
>>>    	data->nums = hwmgr->num_ps;
>>> @@ -597,7 +597,7 @@ static int pp_dpm_get_pp_table(void *handle, char
>> **table)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!hwmgr->soft_pp_table)
>>> +	if (!hwmgr || !hwmgr->soft_pp_table)
>>>    		return -EINVAL;
>>>
>>>    	*table = (char *)hwmgr->soft_pp_table;
>>> @@ -625,7 +625,7 @@ static int pp_dpm_set_pp_table(void *handle,
>> const char *buf, size_t size)
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	int ret = -ENOMEM;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (!hwmgr->hardcode_pp_table) {
>>> @@ -655,7 +655,7 @@ static int pp_dpm_force_clock_level(void *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->force_clock_level == NULL) {
>>> @@ -676,7 +676,7 @@ static int pp_dpm_print_clock_levels(void *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->print_clock_levels == NULL) {
>>> @@ -690,7 +690,7 @@ static int pp_dpm_get_sclk_od(void *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->get_sclk_od == NULL) {
>>> @@ -704,7 +704,7 @@ static int pp_dpm_set_sclk_od(void *handle,
>> uint32_t value)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_sclk_od == NULL) {
>>> @@ -719,7 +719,7 @@ static int pp_dpm_get_mclk_od(void *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->get_mclk_od == NULL) {
>>> @@ -733,7 +733,7 @@ static int pp_dpm_set_mclk_od(void *handle,
>> uint32_t value)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_mclk_od == NULL) {
>>> @@ -748,7 +748,7 @@ static int pp_dpm_read_sensor(void *handle, int
>> idx,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled || !value)
>>> +	if (!hwmgr || !value)
>>>    		return -EINVAL;
>>>
>>>    	switch (idx) {
>>> @@ -774,7 +774,7 @@ pp_dpm_get_vce_clock_state(void *handle,
>> unsigned idx)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return NULL;
>>>
>>>    	if (idx < hwmgr->num_vce_state_tables)
>>> @@ -786,7 +786,7 @@ static int pp_get_power_profile_mode(void
>> *handle, char *buf)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled || !hwmgr->hwmgr_func->get_power_profile_mode)
>>> +	if (!hwmgr || !hwmgr->hwmgr_func->get_power_profile_mode)
>>>    		return -EOPNOTSUPP;
>>>    	if (!buf)
>>>    		return -EINVAL;
>>> @@ -798,7 +798,7 @@ static int pp_set_power_profile_mode(void
>> *handle, long *input, uint32_t size)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled || !hwmgr->hwmgr_func->set_power_profile_mode)
>>> +	if (!hwmgr || !hwmgr->hwmgr_func->set_power_profile_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
>>> @@ -813,7 +813,7 @@ static int pp_set_fine_grain_clk_vol(void *handle,
>> uint32_t type, long *input, u
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_fine_grain_clk_vol == NULL)
>>> @@ -826,7 +826,7 @@ static int pp_odn_edit_dpm_table(void *handle,
>> uint32_t type, long *input, uint3
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->odn_edit_dpm_table == NULL) {
>>> @@ -860,7 +860,7 @@ static int pp_dpm_switch_power_profile(void
>> *handle,
>>>    	long workload;
>>>    	uint32_t index;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
>>> @@ -900,7 +900,7 @@ static int pp_set_power_limit(void *handle,
>> uint32_t limit)
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	uint32_t max_power_limit;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_power_limit == NULL) {
>>> @@ -932,7 +932,7 @@ static int pp_get_power_limit(void *handle,
>> uint32_t *limit,
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!limit)
>>> +	if (!hwmgr || !limit)
>>>    		return -EINVAL;
>>>
>>>    	if (power_type != PP_PWR_TYPE_SUSTAINED)
>>> @@ -965,7 +965,7 @@ static int pp_display_configuration_change(void
>> *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	phm_store_dal_configuration_data(hwmgr, display_config);
>>> @@ -977,7 +977,7 @@ static int pp_get_display_power_level(void *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!output)
>>> +	if (!hwmgr || !output)
>>>    		return -EINVAL;
>>>
>>>    	return phm_get_dal_power_level(hwmgr, output);
>>> @@ -991,7 +991,7 @@ static int pp_get_current_clocks(void *handle,
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	phm_get_dal_power_level(hwmgr, &simple_clocks);
>>> @@ -1035,7 +1035,7 @@ static int pp_get_clock_by_type(void *handle,
>> enum amd_pp_clock_type type, struc
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (clocks == NULL)
>>> @@ -1050,7 +1050,7 @@ static int
>> pp_get_clock_by_type_with_latency(void *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!clocks)
>>> +	if (!hwmgr || !clocks)
>>>    		return -EINVAL;
>>>
>>>    	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
>>> @@ -1062,7 +1062,7 @@ static int
>> pp_get_clock_by_type_with_voltage(void *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!clocks)
>>> +	if (!hwmgr || !clocks)
>>>    		return -EINVAL;
>>>
>>>    	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
>>> @@ -1073,7 +1073,7 @@ static int
>> pp_set_watermarks_for_clocks_ranges(void *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled || !clock_ranges)
>>> +	if (!hwmgr || !clock_ranges)
>>>    		return -EINVAL;
>>>
>>>    	return phm_set_watermarks_for_clocks_ranges(hwmgr,
>>> @@ -1085,7 +1085,7 @@ static int pp_display_clock_voltage_request(void
>> *handle,
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!clock)
>>> +	if (!hwmgr || !clock)
>>>    		return -EINVAL;
>>>
>>>    	return phm_display_clock_voltage_request(hwmgr, clock);
>>> @@ -1097,7 +1097,7 @@ static int
>> pp_get_display_mode_validation_clocks(void *handle,
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled ||!clocks)
>>> +	if (!hwmgr || !clocks)
>>>    		return -EINVAL;
>>>
>>>    	clocks->level = PP_DAL_POWERLEVEL_7;
>>> @@ -1112,7 +1112,7 @@ static int pp_dpm_powergate_mmhub(void
>> *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->powergate_mmhub == NULL) {
>>> @@ -1127,7 +1127,7 @@ static int pp_dpm_powergate_gfx(void *handle,
>> bool gate)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return 0;
>>>
>>>    	if (hwmgr->hwmgr_func->powergate_gfx == NULL) {
>>> @@ -1142,7 +1142,7 @@ static void pp_dpm_powergate_acp(void *handle,
>> bool gate)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return;
>>>
>>>    	if (hwmgr->hwmgr_func->powergate_acp == NULL) {
>>> @@ -1208,7 +1208,7 @@ static int pp_notify_smu_enable_pwe(void
>> *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->smus_notify_pwe == NULL) {
>>> @@ -1228,8 +1228,7 @@ static int pp_enable_mgpu_fan_boost(void
>> *handle)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||
>>> -	     hwmgr->hwmgr_func->enable_mgpu_fan_boost == NULL)
>>> +	if (hwmgr->hwmgr_func->enable_mgpu_fan_boost == NULL)
>>>    		return 0;
>>>
>>>    	hwmgr->hwmgr_func->enable_mgpu_fan_boost(hwmgr);
>>> @@ -1241,7 +1240,7 @@ static int pp_set_min_deep_sleep_dcefclk(void
>> *handle, uint32_t clock)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk == NULL) {
>>> @@ -1258,7 +1257,7 @@ static int pp_set_hard_min_dcefclk_by_freq(void
>> *handle, uint32_t clock)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq == NULL)
>> {
>>> @@ -1275,7 +1274,7 @@ static int pp_set_hard_min_fclk_by_freq(void
>> *handle, uint32_t clock)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_hard_min_fclk_by_freq == NULL) {
>>> @@ -1292,7 +1291,7 @@ static int pp_set_active_display_count(void
>> *handle, uint32_t count)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	return phm_set_active_display_count(hwmgr, count);
>>> @@ -1350,7 +1349,7 @@ static int pp_get_ppfeature_status(void *handle,
>> char *buf)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled || !buf)
>>> +	if (!hwmgr || !buf)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->get_ppfeature_status == NULL) {
>>> @@ -1365,7 +1364,7 @@ static int pp_set_ppfeature_status(void *handle,
>> uint64_t ppfeature_masks)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->set_ppfeature_status == NULL) {
>>> @@ -1395,7 +1394,7 @@ static int pp_smu_i2c_bus_access(void *handle,
>> bool acquire)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->smu_i2c_bus_access == NULL) {
>>> @@ -1413,7 +1412,7 @@ static int pp_set_df_cstate(void *handle, enum
>> pp_df_cstate state)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled
>> || !hwmgr->hwmgr_func->set_df_cstate)
>>> +	if (!hwmgr->hwmgr_func->set_df_cstate)
>>>    		return 0;
>>>
>>>    	hwmgr->hwmgr_func->set_df_cstate(hwmgr, state);
>>> @@ -1428,7 +1427,7 @@ static int pp_set_xgmi_pstate(void *handle,
>> uint32_t pstate)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled
>> || !hwmgr->hwmgr_func->set_xgmi_pstate)
>>> +	if (!hwmgr->hwmgr_func->set_xgmi_pstate)
>>>    		return 0;
>>>
>>>    	hwmgr->hwmgr_func->set_xgmi_pstate(hwmgr, pstate);
>>> @@ -1443,7 +1442,7 @@ static ssize_t pp_get_gpu_metrics(void *handle,
>> void **table)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled
>> || !hwmgr->hwmgr_func->get_gpu_metrics)
>>> +	if (!hwmgr->hwmgr_func->get_gpu_metrics)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	return hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
>>> @@ -1453,7 +1452,7 @@ static int pp_gfx_state_change_set(void *handle,
>> uint32_t state)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)-
>>> pm.dpm_enabled)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 96a3388c2cb7..97c57a6cf314 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -68,9 +68,6 @@ static int smu_sys_get_pp_feature_mask(void
>> *handle,
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	return smu_get_pp_feature_mask(smu, buf);
>>>    }
>>>
>>> @@ -79,9 +76,6 @@ static int smu_sys_set_pp_feature_mask(void
>> *handle,
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	return smu_set_pp_feature_mask(smu, new_mask);
>>>    }
>>>
>>> @@ -219,13 +213,6 @@ static int smu_dpm_set_power_gate(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled) {
>>> -		dev_WARN(smu->adev->dev,
>>> -			 "SMU uninitialized but power %s requested
>> for %u!\n",
>>> -			 gate ? "gate" : "ungate", block_type);
>>> -		return -EOPNOTSUPP;
>>> -	}
>>> -
>>>    	switch (block_type) {
>>>    	/*
>>>    	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
>>> @@ -315,9 +302,6 @@ static void smu_restore_dpm_user_profile(struct
>> smu_context *smu)
>>>    	if (!smu->adev->in_suspend)
>>>    		return;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return;
>>> -
>>>    	/* Enable restore flag */
>>>    	smu->user_dpm_profile.flags |=
>> SMU_DPM_USER_PROFILE_RESTORE;
>>>
>>> @@ -428,9 +412,6 @@ static int smu_sys_get_pp_table(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	struct smu_table_context *smu_table = &smu->smu_table;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu_table->power_play_table && !smu_table-
>>> hardcode_pptable)
>>>    		return -EINVAL;
>>>
>>> @@ -451,9 +432,6 @@ static int smu_sys_set_pp_table(void *handle,
>>>    	ATOM_COMMON_TABLE_HEADER *header =
>> (ATOM_COMMON_TABLE_HEADER *)buf;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (header->usStructureSize != size) {
>>>    		dev_err(smu->adev->dev, "pp table size not matched !\n");
>>>    		return -EIO;
>>> @@ -1564,9 +1542,6 @@ static int smu_display_configuration_change(void
>> *handle,
>>>    	int index = 0;
>>>    	int num_of_active_display = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!display_config)
>>>    		return -EINVAL;
>>>
>>> @@ -1704,9 +1679,6 @@ static int smu_handle_task(struct smu_context
>> *smu,
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	switch (task_id) {
>>>    	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
>>>    		ret = smu_pre_display_config_changed(smu);
>>> @@ -1745,9 +1717,6 @@ static int smu_switch_power_profile(void
>> *handle,
>>>    	long workload;
>>>    	uint32_t index;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>>>    		return -EINVAL;
>>>
>>> @@ -1775,9 +1744,6 @@ static enum amd_dpm_forced_level
>> smu_get_performance_level(void *handle)
>>>    	struct smu_context *smu = handle;
>>>    	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>>>    		return -EINVAL;
>>>
>>> @@ -1791,9 +1757,6 @@ static int smu_force_performance_level(void
>> *handle,
>>>    	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>>>    		return -EINVAL;
>>>
>>> @@ -1817,9 +1780,6 @@ static int smu_set_display_count(void *handle,
>> uint32_t count)
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	return smu_init_display_count(smu, count);
>>>    }
>>>
>>> @@ -1830,9 +1790,6 @@ static int smu_force_smuclk_levels(struct
>> smu_context *smu,
>>>    	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu_dpm_ctx->dpm_level !=
>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>    		dev_dbg(smu->adev->dev, "force clock level is for dpm
>> manual mode only.\n");
>>>    		return -EINVAL;
>>> @@ -1917,9 +1874,6 @@ static int smu_set_df_cstate(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
>>>    		return 0;
>>>
>>> @@ -1934,9 +1888,6 @@ int smu_allow_xgmi_power_down(struct
>> smu_context *smu, bool en)
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
>>>    		return 0;
>>>
>>> @@ -1947,22 +1898,11 @@ int smu_allow_xgmi_power_down(struct
>> smu_context *smu, bool en)
>>>    	return ret;
>>>    }
>>>
>>> -int smu_write_watermarks_table(struct smu_context *smu)
>>> -{
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>> -	return smu_set_watermarks_table(smu, NULL);
>>> -}
>>> -
>>>    static int smu_set_watermarks_for_clock_ranges(void *handle,
>>>    					       struct pp_smu_wm_range_sets
>> *clock_ranges)
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->disable_watermark)
>>>    		return 0;
>>>
>>> @@ -1973,9 +1913,6 @@ int smu_set_ac_dc(struct smu_context *smu)
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	/* controlled by firmware */
>>>    	if (smu->dc_controlled_by_gpio)
>>>    		return 0;
>>> @@ -2083,9 +2020,6 @@ static int smu_set_fan_speed_rpm(void *handle,
>> uint32_t speed)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->set_fan_speed_rpm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2126,9 +2060,6 @@ int smu_get_power_limit(void *handle,
>>>    	uint32_t limit_type;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	switch(pp_power_type) {
>>>    	case PP_PWR_TYPE_SUSTAINED:
>>>    		limit_type = SMU_DEFAULT_PPT_LIMIT;
>>> @@ -2199,9 +2130,6 @@ static int smu_set_power_limit(void *handle,
>> uint32_t limit)
>>>    	uint32_t limit_type = limit >> 24;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	limit &= (1<<24)-1;
>>>    	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
>>>    		if (smu->ppt_funcs->set_power_limit)
>>> @@ -2230,9 +2158,6 @@ static int smu_print_smuclk_levels(struct
>> smu_context *smu, enum smu_clk_type cl
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->print_clk_levels)
>>>    		ret = smu->ppt_funcs->print_clk_levels(smu, clk_type, buf);
>>>
>>> @@ -2319,9 +2244,6 @@ static int smu_od_edit_dpm_table(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->od_edit_dpm_table) {
>>>    		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input,
>> size);
>>>    	}
>>> @@ -2340,9 +2262,6 @@ static int smu_read_sensor(void *handle,
>>>    	int ret = 0;
>>>    	uint32_t *size, size_val;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!data || !size_arg)
>>>    		return -EINVAL;
>>>
>>> @@ -2399,8 +2318,7 @@ static int smu_get_power_profile_mode(void
>> *handle, char *buf)
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled ||
>>> -	    !smu->ppt_funcs->get_power_profile_mode)
>>> +	if (!smu->ppt_funcs->get_power_profile_mode)
>>>    		return -EOPNOTSUPP;
>>>    	if (!buf)
>>>    		return -EINVAL;
>>> @@ -2414,8 +2332,7 @@ static int smu_set_power_profile_mode(void
>> *handle,
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled ||
>>> -	    !smu->ppt_funcs->set_power_profile_mode)
>>> +	if (!smu->ppt_funcs->set_power_profile_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	return smu_bump_power_profile_mode(smu, param, param_size);
>>> @@ -2426,9 +2343,6 @@ static int smu_get_fan_control_mode(void
>> *handle, u32 *fan_mode)
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->get_fan_control_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2445,9 +2359,6 @@ static int smu_set_fan_control_mode(void
>> *handle, u32 value)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->set_fan_control_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2478,9 +2389,6 @@ static int smu_get_fan_speed_pwm(void
>> *handle, u32 *speed)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->get_fan_speed_pwm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2497,9 +2405,6 @@ static int smu_set_fan_speed_pwm(void *handle,
>> u32 speed)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->set_fan_speed_pwm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2524,9 +2429,6 @@ static int smu_get_fan_speed_rpm(void *handle,
>> uint32_t *speed)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->get_fan_speed_rpm)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2542,9 +2444,6 @@ static int smu_set_deep_sleep_dcefclk(void
>> *handle, uint32_t clk)
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	return smu_set_min_dcef_deep_sleep(smu, clk);
>>>    }
>>>
>>> @@ -2556,9 +2455,6 @@ static int
>> smu_get_clock_by_type_with_latency(void *handle,
>>>    	enum smu_clk_type clk_type;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
>>>    		switch (type) {
>>>    		case amd_pp_sys_clock:
>>> @@ -2590,9 +2486,6 @@ static int
>> smu_display_clock_voltage_request(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->display_clock_voltage_request)
>>>    		ret = smu->ppt_funcs->display_clock_voltage_request(smu,
>> clock_req);
>>>
>>> @@ -2606,9 +2499,6 @@ static int
>> smu_display_disable_memory_clock_switch(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = -EINVAL;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->display_disable_memory_clock_switch)
>>>    		ret = smu->ppt_funcs-
>>> display_disable_memory_clock_switch(smu,
>> disable_memory_clock_switch);
>>>
>>> @@ -2621,9 +2511,6 @@ static int smu_set_xgmi_pstate(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->set_xgmi_pstate)
>>>    		ret = smu->ppt_funcs->set_xgmi_pstate(smu, pstate);
>>>
>>> @@ -2722,9 +2609,6 @@ static int
>> smu_get_max_sustainable_clocks_by_dc(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
>>>    		ret = smu->ppt_funcs-
>>> get_max_sustainable_clocks_by_dc(smu, max_clocks);
>>>
>>> @@ -2738,9 +2622,6 @@ static int smu_get_uclk_dpm_states(void
>> *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->get_uclk_dpm_states)
>>>    		ret = smu->ppt_funcs->get_uclk_dpm_states(smu,
>> clock_values_in_khz, num_states);
>>>
>>> @@ -2752,9 +2633,6 @@ static enum amd_pm_state_type
>> smu_get_current_power_state(void *handle)
>>>    	struct smu_context *smu = handle;
>>>    	enum amd_pm_state_type pm_state =
>> POWER_STATE_TYPE_DEFAULT;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->get_current_power_state)
>>>    		pm_state = smu->ppt_funcs-
>>> get_current_power_state(smu);
>>>
>>> @@ -2767,9 +2645,6 @@ static int smu_get_dpm_clock_table(void
>> *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->get_dpm_clock_table)
>>>    		ret = smu->ppt_funcs->get_dpm_clock_table(smu,
>> clock_table);
>>>
>>> @@ -2780,9 +2655,6 @@ static ssize_t smu_sys_get_gpu_metrics(void
>> *handle, void **table)
>>>    {
>>>    	struct smu_context *smu = handle;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (!smu->ppt_funcs->get_gpu_metrics)
>>>    		return -EOPNOTSUPP;
>>>
>>> @@ -2794,9 +2666,6 @@ static int smu_enable_mgpu_fan_boost(void
>> *handle)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->adev->pm.dpm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->enable_mgpu_fan_boost)
>>>    		ret = smu->ppt_funcs->enable_mgpu_fan_boost(smu);
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index 39d169440d15..bced761f3f96 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -1399,7 +1399,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
>>>
>>>    bool is_support_sw_smu(struct amdgpu_device *adev);
>>>    bool is_support_cclk_dpm(struct amdgpu_device *adev);
>>> -int smu_write_watermarks_table(struct smu_context *smu);
>>>
>>>    int smu_get_dpm_freq_range(struct smu_context *smu, enum
>> smu_clk_type clk_type,
>>>    			   uint32_t *min, uint32_t *max);
>>>
