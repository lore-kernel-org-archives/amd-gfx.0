Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF33C6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 15:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9B110EC2C;
	Thu, 22 Sep 2022 15:42:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A00910EC2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 15:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGwde9/tNrOe2UkbRZ0JXCeLYAD46MOxMBtfTmQcBWqnWkg28V88HIyfq7oachCBdrzLZa7c6C/gLqMsCOuqSpQrXNq9MaCw/kI9ypQwnCGcIoSpA7gdixMbvD+Ef3+tz+5v+PVut4nM4xqdfbuAvxrNwG17EBozgyQzfCJykwkFetYEqfK6ashn3nQ0Mew8aQlnwZmjVf0nJ+4tfP5SXkSOXe6DK4OCPvK4kUQTyPyFBa9YR6rJirvUBAarLbsRpXD4NyfAMOBz798OyWyBmA8C7N8oduK1UqfuV2w8ybz47NrfoCKGDPkZjReJ4pU+og96KO5Csx4FCJovtHp1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF6paP1a4DttHz8x1oWAM6JuG2SHuri8xjSQ7esD7GU=;
 b=QpvALTN9wLLJ5d/Na/AUpyjE6BIX9JewWcsjxIZZuAfmEjVCr9jKIOvBktVAqoVTQlJjz3NmKkDQNGf29CXDs1yQLQwO7vSp1KKeb1gGHuYEAyiNtR5VAZqQI7OvJRVD4v4Dshfhy5YMpSEymLVmzrUMOGfEt/3ElPUhJIW1bajJ+S+A66DEuNUZ27eqvOpYch/QHiUbEcLAOoR/yh2zX+kRI98UCVd+WcVXouk/sqtnrjWZDgGYGEWjbefRTfNscNvhV7WurhFEvYPZOrWUHN4SMcuTJHnBl6DfEMW1PvpKIckwuhH3Aehr2oZHpHPONkJegHQAJn/XnmoOQJkfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF6paP1a4DttHz8x1oWAM6JuG2SHuri8xjSQ7esD7GU=;
 b=iwbvSiU2wHZDkMB/755oP6heTTEXWMRAvq27OhdYCbNouZ+TgR5gxePElY+4uINhUJvLebHcVnsQMWt9l+ksfliliI2i1eNYABqC6757vMD1jn+hG7t6cQz0E+fYNA5PBuosjGBpAyEeonyR8IT8hGXsWUZj+4GLK8fbbTZo6zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 15:42:22 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6cf:60a9:3ed3:7be3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6cf:60a9:3ed3:7be3%9]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 15:42:22 +0000
Message-ID: <3be971e6-7f2c-e6ad-3a07-77fa92b56f47@amd.com>
Date: Thu, 22 Sep 2022 21:12:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM eviction issue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220922151447.265696-1-Arunpravin.PaneerSelvam@amd.com>
 <dd3ac270-a338-888d-4bd3-1716504b7a8f@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <dd3ac270-a338-888d-4bd3-1716504b7a8f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|CH0PR12MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: ceeca78e-221f-48e0-922f-08da9cb10a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcJPICRpnIi4mYMp+yrrDkQXJpt7F4I4N2gjZK2c0hVGuBjnCfCS6LFXZrqIRS8zNe/1MqaiToOtepMRzihoNEyv7MO2e/wpG48bicFH1FdGLjSufuBzQA9Vc1l2lq2pQKT1JdeqVgV8dSqqLyAP93nwtTOkoDIT6IIamADOjPBx9npnDEctB1QRteok25KdglXXNfBJVbesK1Y7m2Vjoj5OXWMjl5Ap4b2hWI0IqbqfsFpCebxS7HsijfqyUPkQtLiRRoDklKfuMwWjOnoCkBYBtZyCaoeLsfFZKOklDgDx0pi9uuFbICMRU25Y/SMXL37jkZd55J1WhP8dnSgsvBgX15DfVdxifStNCw/1+CUwtcnHwWVNCyXoN0bOUoYbSqbDitGoUYBC5yXfhCavCL3odUuPFkXaKq9ox1PvjtYHahqcRF/7ZkOjCLnxZMrxn1OKcEjeXHBnbVS4FK2auc2Zzv1fP9lB34wUbYJnMyi3FlYbaIrYBNstdLQgHcY9seNOlJ6yMHEH/Frmc5HmEj7h4wd6lO2iLjgZNntRVO2RNcNkrgqE+YXowBwU1J0mxXpCaNLdaYfGergsHSJzQQT6MJD0/qbQGiGIGhmWS+LVV1fgpJyazmI2/+ECg9WWXUEHYHiPpO4f3aiFOaAwRRVpaFwSSSmS9vX0s60xS0dxsIOcCzXQXj2RpnG2GElW8Qgf/DAMWYToLd6KG25UVPfRC6vAfu4TDZt0MDqyjwdeiFKfFQwIWRTjl3wWDUN6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(478600001)(36756003)(5660300002)(6666004)(2616005)(316002)(26005)(8936002)(6512007)(41300700001)(53546011)(86362001)(6506007)(8676002)(966005)(6486002)(2906002)(186003)(83380400001)(31696002)(66574015)(38100700002)(31686004)(66946007)(66556008)(66476007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T015VE5iYnVwYytmZ0pEbk9ic0tXSnlhSmcyY0N5MDI1SXZzQlVQREFjeVpy?=
 =?utf-8?B?ZmhGSWs5THM2cFpUVGh2MXQ5T3FLWG5mM2dtNmFwNDN0QjZyNWxmMEw3KzN3?=
 =?utf-8?B?ZXZsVzhMN3FoOGV0WmE2dDlpbTNvVGZLSDB6aE9teElWYld3YUkvWGpsc1R6?=
 =?utf-8?B?REFyN1FHS0lubVpuVkJhOXRBcmNodWlFYU1BNEhOVncxSW81Q3R5NkRIVnZm?=
 =?utf-8?B?ZnQ1ZDZRZ1oyWHNRZzVoR0J1U3RoZnlDTHp4bnZqOFNrRUVZeU8zZE9PVUJS?=
 =?utf-8?B?RzM1bG5Oc2hDeW1ZemZ4QTRFeEp6NHJWZFhLMVh0QnlnREFtWnRYVmpUblhP?=
 =?utf-8?B?RENjZDZJZ2UwclNXRVU2MWpWY3I0TGJ4dFd2VXd3M3VFbk9lVGgwekR1cklM?=
 =?utf-8?B?VDFkZzRTMjZGV3NIL0Qwc2hHY1B2Q2tSSzBiWWh5OGxqbTlDUHVRTlAwMExN?=
 =?utf-8?B?QWdlc3RmbzFhb29pT0xTMS9Iay9YNkE5bnFkcmxyMHdjZWtjdEpNclFXQ3h3?=
 =?utf-8?B?QlVBNTRKV1ZiTUQ3THBqMzB6YnYzeEZBY2xTdG82dzBST2wwTUNjUFhyMG53?=
 =?utf-8?B?ajMvRWlVamhmMFVtUlJaK1JWTzRsQ3h4UWNmdE01SmNBUHZEMFg4NFJxNEY5?=
 =?utf-8?B?L3h1RWF2QTRRYzVwQlJjSXRaWEZwaHBieWdPU2tLVHJqMVpqU3NzYnd0ZThG?=
 =?utf-8?B?VTNhTVhscEVPdTVWa2pvMVJXZ2dzSmEyRmJHZ3RwVFp2UG1WUk43OXlncThN?=
 =?utf-8?B?TVgzbUVjNGJjbEpOcUVHNWhGZE9Gakt2N3o5MFJ2TlRwcWZHNGEwM1Z6bHpq?=
 =?utf-8?B?cXFmNFFTa3dwdjZrWktla2tDQWxlc3RHWWtaRGw4bDVyZjU1ZnhYbWZXaW1s?=
 =?utf-8?B?aDR0OGhyMC9obG5nSU0zQUcyWCs0R0VjblNyV3dseW5JUHJOSHF6K3dpSTdL?=
 =?utf-8?B?ODh1eThkblVyckhLTjhLQmlIcFJHeER2cGMwSzdQTlNKTnZrbUtyQkE5bkl2?=
 =?utf-8?B?RzgwUTkvTjhXam50a2pSb2ZBTi81UTlSN2FSY0I0a0xib3JubXhTVDNrTDJj?=
 =?utf-8?B?aXZjcisxbGYrbmdKalJOcGttQzAxek5xRnFJVFBneHJZOXFLUmFjdFBYZzl0?=
 =?utf-8?B?R2k0NlFmN3RXVHk5OVh4VHZDbFdja3Z0c0YyM1pPL2dKbitsNTNtZ21CQmdR?=
 =?utf-8?B?MG5EVHlJUDl4WGpMZGEvUzh2Z3EweXZXVkxGdWNzMGVXaUFUWEVxWUI5Vkxk?=
 =?utf-8?B?cXk2VXk2VCtVMXFWZXpBVHNvN1BZc3F0Q1IzMm5hWjdmYWtYZkZzOUxJUHdt?=
 =?utf-8?B?YjROMHdJS0h5QnozWUI4Mm1lQXgrMWpla1d1cXdxbWVCcWxLZjllMnFnZkxH?=
 =?utf-8?B?SEErcHc5R1g3TlliSHNCK1ZoNy9heERjaUxLSTFjVWt2Q2RENzB5OE4xbHdJ?=
 =?utf-8?B?T3Y3dXZxU1A0ZVA5MHRaYXdtQm55bTU2MTM4aHpxNkZOSGRscmdQTTlib3I2?=
 =?utf-8?B?RklVZlB1RGFFYTZockZ0aGxvQVpSN3Z1cGhSVmJialRxWkVXMzd5RTRqY052?=
 =?utf-8?B?d2JmM0lHOTRYZDlGRHVCTElCWFB4eUp4aEV0dk9MSzl4VDk2L3FSckNsck5W?=
 =?utf-8?B?UjlzR0xqbHR1RmJwWHdmdkJiRDkwNG8wbGM1Wk9DYzJMQ1BYeWt1VVlKQml0?=
 =?utf-8?B?Y1JyZzBxMlgvSU43MHpIZjJ1cXZDRkh0dWhaNkdDUEMwY2VEQlNaMzBVTUVI?=
 =?utf-8?B?QkV4SnpsQ1VjRG42OHhRT1Y5T3lTMmF4RG8rUXM0eDV0OURjN3Qzc1pHRDhT?=
 =?utf-8?B?Z3J1SHZVNC80QlNSTzhyTnBMUm9pUXJqYkxvdW1Ma2dpaE1lZzhOT1phVEZ2?=
 =?utf-8?B?eWp5Nkx4Z1B6R21tV3JkZlNDUWQ5eTR3RGNlYTRUQXFBbzVheGxKakR2ZWtG?=
 =?utf-8?B?aXdzck5vdEhhVHkycFUvMWQveks2anFqa1pqWlNGaXlhUlFwc3VsUlBQMUhr?=
 =?utf-8?B?YTR4Yk8zeC9ORnZtZklydjB4dHNYK1BGZHo2N0RnLzQ4OFNJSGxUUVo2RGFI?=
 =?utf-8?B?NWJhVVkxUDFVSkovUUZwUTRtU1YvdVk2SDRXSjJZMGFQSkNyRmg0VjJSL3hM?=
 =?utf-8?Q?mlEqTxpT6q1rsDe2N7Co3+Jhd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeca78e-221f-48e0-922f-08da9cb10a11
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:22.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1OCZ5KE5YUjYdLS5/VtBB0ooKBwqb+hQjZLqvon0ZjHzKTvnYO8Djrkt1RCcgt7bmQe8XkLLkALXJhxEMRT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/22/2022 9:01 PM, Christian König wrote:
> Am 22.09.22 um 17:14 schrieb Arunpravin Paneer Selvam:
>> A user reported that when he starts a game (MTGA) with wine,
>> he observed an error msg failed to pin framebuffer with error -12.
>> Found an issue with the VRAM mem type eviction decision condition
>> logic. This patch will fix the if condition code error.
>>
>> Gitlab bug link:
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2159
>>
>> Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible 
>> functions")
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Can you push it yourself now?
No, I didn't get the commit rights yet.

Thanks,
Arun
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index d1a2619fa89f..73a517bcf5c1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -746,7 +746,7 @@ static bool amdgpu_vram_mgr_intersects(struct 
>> ttm_resource_manager *man,
>>               (amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
>>             if (place->fpfn < lpfn &&
>> -            (place->lpfn && place->lpfn > fpfn))
>> +            (!place->lpfn || place->lpfn > fpfn))
>>               return true;
>>       }
>

