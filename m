Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDA7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 15:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E9410EDA0;
	Mon, 28 Mar 2022 15:48:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B69110EDA0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 15:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOc7gUS/1cNRgp1xQTPSETgVGsF+emmyPm9QzEqTdLbaqR3ZO1sCd3zeQ4gvook16vr9XtLU5CKpyZoTGWHy5IZ0jP4UjVHrtRvqf6FcvAJBYsljEgWOTWghKGJJwkcArRxSHSHZIbrkES+8VChZfE5qcE7prDEqRdEcPTmaYPS2okQI80Ew8AMKnNz4N7w6HcO4ut/FPg5J1ZbeLdo7EDlcmDmGGiiNNZyob99G88i8A4lpKaeXKYIsAGJ3eXBCbWkzCbymSA5nhfeP1tfzJL3Bk9tevbRYxIAFIIYyBHXc87OvNaXke1wprAnGIORwdVBcjk2aqaZ/BoNQTfIsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCu0qoogpRRIS+ptHhYa87ut2Vnl0f+aJEdctKwQpGo=;
 b=f+ItM3k3Mo9wo1XaqIxxPSQduHqqBHXm3/foF2nz9wtxabDkppQSYhjZSk/d/bMVcDy+XWgephmoL7wIBxgXM1W+b9jex36WdHIEnOWk+WUoeM4PfedfZopVXuHpk2ri8EziS5FB4ntuG3i+/ehpgf6/FRhRzDCSQ1fIXI/rzLoGCBEOtBio/SuDR8BbQe8GJ3JUvk1Y2JKSCP+p5elBh0jENn4NuZcNLmy3ygiHllwQuoK4dTVmBRVZDbKaMXSe0MsLUw/u2VEOVYIdxncrdzpsHBJm4srceZEtNRHgbv5ZoKjoK5H86QDUjDICvlfCysSfEUrD2E1vL0PyQPWWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCu0qoogpRRIS+ptHhYa87ut2Vnl0f+aJEdctKwQpGo=;
 b=Ewz9UzlfY5nsvirXHIjg2OJkBaoLSr4Nikq9+++zKEIrIN8daUaWozNKf/7CqSNI5imTx/ovwhhoyQjx2AMC5JF0EwQS7uMadzlg+iUjIE2L9vtkqHQnNB1qD6O0pIWjRt+CwZ7d4ZBHNFnaOzCOybu54fDc1S6/W9hVb7mQuVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3824.namprd12.prod.outlook.com (2603:10b6:208:16a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 15:48:40 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 15:48:40 +0000
Message-ID: <c319f4e0-c01a-d355-9878-7f09a5f33b49@amd.com>
Date: Mon, 28 Mar 2022 21:18:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220328143518.1253762-1-kent.russell@amd.com>
 <20220328143518.1253762-2-kent.russell@amd.com>
 <80529a89-effc-368a-da12-14d7e44c860d@amd.com>
 <DM5PR12MB1308FBF96617FF1DDE124158851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB1308FBF96617FF1DDE124158851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a727dd-19d1-4d1f-8466-08da10d26d9a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3824:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB382441C4D0E97FC71E29538F971D9@MN2PR12MB3824.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTac017lCZICddIQMLCvVf9rwM4Y594NuVaPUko/Cxu+S1wO0PwjgTExNpRQ0BQqmfmllc4TLnpsm+thUM+/Qd+tb29+m1v9qUs98uprmwZr772J1XvHTrGbAtYDeKuXtuQ8IhWjIt46ILAM3mPMHjrDu8Tz4r2i/okqFJLa2Cf/nVLYiX6MWJ6FkcULMk3fGQYKPodPZblR+cj6EItzOKnpxk9T+ie6g1a4BWezvBJFVLYNu5I+VHj9RvoZg9HzgxQcsPZcv2R/5BNHCxws8jspsHmylVSV+wnvZcL1sRhXxREeQtbTBySKU5FdbRElfj+xYHKef1O3Um7sCOXmiM2ZrVy96GM86Uy6++xhVPnUNOVyqzbK2KeENgfsb4rmD2/LkcXADMxMAV1tZ5n1+HgUhP0so7Re2CqhPIwk/6Xxey5zS/QffFL0A9JLPKachifCriulmkRolI33s5iUczg1V9DTO+3/pV+aIXEnrbi66UhvJnH6drg/yRFcVi9/UmgTs0u2lu3XEdxAgp40WKu6SOGQbPV2aXrBfzi3guCgbdrfQnoGGSfjIjqoL0w+t4z9sp9Bvlp0lzKd8pbpM4sCZzFfRlN0do4IN30lOF0FzJthUc12rsWFbwIDDXIJWCn+2hdTgcPh0zEVg6+ADbVReqK/78GzmZup8mUWAA5zjbFCUXsM//uNz2LMR34yY3T9n3TPPRwmMp8u+VUzrMI5JtxCADHuN6kA76p3V8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31696002)(2906002)(316002)(6506007)(26005)(6512007)(6666004)(53546011)(2616005)(186003)(110136005)(86362001)(66946007)(38100700002)(66476007)(66556008)(4326008)(8676002)(31686004)(508600001)(6486002)(36756003)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RCNms0SklBNDNDbW04L2IwSWptSzZ1OThBREgzc0huckZYbnBZNlZFTmdM?=
 =?utf-8?B?K3d2NUFCRkJYbFNzaWxHUFh3cUNJR3F5aHBGVGJpRmxXc1JjS2hmUnlUVlBt?=
 =?utf-8?B?TlQ5czRxbkZXQ240V2prQlR5ZlpGMlAwWW0zak83RytjQmFEeXpFdnZLNDJx?=
 =?utf-8?B?bzJYYzhYdVJJMFVLQ0xIbWJNeFVTdDBtUHhNSVQyOUlNK1JTYmtCYTQ5K0U3?=
 =?utf-8?B?K0g1UCtkT1Noa2pUejNWTVdxaUV2YnpqZWVBK21xTFlFZUxNcElzZEsxWTVq?=
 =?utf-8?B?bVR0RnRVRCswQWVEelkwRFNZZFlzSjlYS05DcFVyazFUUms5Qmhia3dqRGZJ?=
 =?utf-8?B?OHMzMHFaUTdockVSaDBJekJkbHMzUGFXYUJLTTViOVdzU3ZoRUFmT0g3Tnlj?=
 =?utf-8?B?dERQcDhlQmFuWVRqNmFZSStwUGNCNlNWcVFUakNra1YreU9hN2xtZDNtendk?=
 =?utf-8?B?elcrNWRYSXowNGY5VlhKMnp3N0owTDRkaGdyRkVTUTFHdnFLU2krNWhuWHJo?=
 =?utf-8?B?cWlDSFhLQk5FbW9xNzhtcHc5aDJNcFF1VHFGWVViTC9pQzROcHVwRjlPb0xN?=
 =?utf-8?B?WXZMVzlTdzUyOGVkZTlhM3dVT1dwYkxTZzltYlRMbXRoaGxSb0ZRSkxFTzlY?=
 =?utf-8?B?OUJLbGNGY1YyQkpVSW11Znhmd05NckRtOUt1TjhsaHp4aGpCQ1FlMGhsSGRL?=
 =?utf-8?B?L2VOVWhTZjFUWStGYkgzSi9Mb2NYazBaNzlyR1N5RWdaZDRYMkhrcjYvVWNJ?=
 =?utf-8?B?SWw3TlZZVjV3NGVhK0Q5MkNOVFY2ZU92VTZZc2dkMm55d2pGYkF4WmRrdFhv?=
 =?utf-8?B?NzNPNFpXUGtJQW95QkxtTUVvcGYvd0xKWlNlTlE5djdwM2JrdzBWSXF4WkZN?=
 =?utf-8?B?WE93enl1KzRZS2YzVDFvd3dhcml3Ylo0ZHhzUXZRMThPeHozdjBhMUJsWnRu?=
 =?utf-8?B?TUJNSUpHK3ZmalovdkpwWXhEd0pLUVMycGlzWnY1TWc5QWFBamMrMDFUYWNz?=
 =?utf-8?B?cXVLQ3lNVVA1bkhkUWdFcVNZYWdQT3NEcFFRQjBEbERkNTEvQmhYZm9tQ2gw?=
 =?utf-8?B?enRzWnpZa0dXL1Nza0JpUDJJbjd1ZFlxWlQyaktmREJvTXhydGk4QTZpMjNl?=
 =?utf-8?B?VXRCMDQ2MXR5azFyNm5GWHRpL2xuOHpockJsS2VWT2txK0s1R0RTV1dyc1Vv?=
 =?utf-8?B?d3JOTUtyVkhxMUhJV3g4TCtMVWNoTko3RDFvZldMRnRqdUxXczlWK25Fb243?=
 =?utf-8?B?TE1Xc0RPOUZKb0Y2OU9CUjE2SWFwRFJNKzVkY2NWYXJtaVJ1M3pxUnFqSUFH?=
 =?utf-8?B?bDV5a0VKcEMxVGJoZGowa0F3T1ZZdEI1TTBFVUZRSmpaOUhxajQwNFM1VmhS?=
 =?utf-8?B?eFFLbmE5QURCTWg5MVZKUWtvYnhIME0xRXFaUzY0ejJQU1pFQkwrbUlNU3RL?=
 =?utf-8?B?TzFYSnNIRjcycXZINzZ3QTA1RmF1cVZ6V1B2WEJWcjkxUmp6Mngxc3RXQjYw?=
 =?utf-8?B?SDg2a3hISDd6eDhpN2Z0cnVxWGJFYnphT0E5ckRMeG5mbGJOZUYvaGhycW4v?=
 =?utf-8?B?SzRQSlkzZjNlVzMrdUVBKzF4QlJvakF4MGg2V1pnb003Y0VYOFJVN3FPRHBV?=
 =?utf-8?B?ZnJLYkJwU2ZPYWJIMjUwWGVYYXdVS0IvMjYvRGJaSTZjZGJUa0ErcXVNTjZh?=
 =?utf-8?B?SERSbEpJVmxNNGlsMkROUUd1bUlqdmhOTFE1VzRTOXJ3YmJ0MkhWWk1IOXJu?=
 =?utf-8?B?MkZyTkF2K3psUUg1czFLUjhKUlFOR0RXMWJ6REJxMzJGd2Z0aDRMZkF5SDJK?=
 =?utf-8?B?cG82OFhVN3pHMjh2R3diSEhEUERyWEdpc2lSN2o3QzQvK3JGUkQ5cXlmV1NX?=
 =?utf-8?B?Nzkva3lGTFQ3Q0tPRHpydC9JTHdvNGdhRHphYW9CSnZCOEpaQXlMWVFqQytN?=
 =?utf-8?B?Qm0wVjcrUXdNL3pGUDVKZjZaVnhTV3AvazlMWFBqZkRjbUM3M25heFFZQ3RY?=
 =?utf-8?B?VXYxSk9HRHhGS3lZWUVZM3pZWVFDRk4ySUprMnVBZUpQbnpoOHB2bFdib0lF?=
 =?utf-8?B?KzNyaWxIeWlTTUpoYzNpVVFpQnZtbEdQNStaQVZ1VmN3TkJwdllpWGxRU2Yw?=
 =?utf-8?B?M2JTOHdqSzh2WUR3c2dHa01RNEJOT2NLR0cvaXc0bmFqclBsSWFUT2gxRjFq?=
 =?utf-8?B?SkdJU2dpUVFjMkczeWFyTFBEU0Z4ZHlGa0U3bmlyOG03VFhxcy9rdGNubFgy?=
 =?utf-8?B?bHVtRW50akxkbjlHY1Zzb0dRS1BWT1BDTmJ2cmZNRksrRGE5S2dIMm5ZeTBC?=
 =?utf-8?B?QmVuTDFqVzBFUWk5VUprTnVTTzdCeFdQS09GLy9zYnlsUDRKSWI1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a727dd-19d1-4d1f-8466-08da10d26d9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 15:48:40.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hy3DzsX5kON2Tc8eO7tV028P5RAR+OCzzeact3gSlSuY3KimJfLcyg6UI+h4noGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3824
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/28/2022 9:12 PM, Russell, Kent wrote:
> [AMD Official Use Only]
> 
> Responses inline
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, March 28, 2022 11:18 AM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
>>
>>
>>
>> On 3/28/2022 8:05 PM, Kent Russell wrote:
>>> This is being added to SMU Metrics, so add the required tie-ins in the
>>> kernel. Also create the corresponding unique_id sysfs file.
>>>
>>> v2: Add FW version check, remove SMU mutex
>>> v3: Fix style warning
>>>
>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
>>>    .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 36 +++++++++++++++++++
>>>    3 files changed, 47 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index 4151db2678fb..4a9aabc16fbc 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_device *adev,
>> struct amdgpu_device_
>>>              case IP_VERSION(9, 4, 0):
>>>              case IP_VERSION(9, 4, 1):
>>>              case IP_VERSION(9, 4, 2):
>>> +           case IP_VERSION(10, 3, 0):
>>>                      *states = ATTR_STATE_SUPPORTED;
>>>                      break;
>>>              default:
>>> diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
>>> index 3e4a314ef925..58f977320d06 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
>>> @@ -1419,8 +1419,12 @@ typedef struct {
>>>      uint8_t  PcieRate               ;
>>>      uint8_t  PcieWidth              ;
>>>      uint16_t AverageGfxclkFrequencyTarget;
>>> -  uint16_t Padding16_2;
>>>
>>> +  //PMFW-8711
>>> +  uint32_t PublicSerialNumLower32;
>>> +  uint32_t PublicSerialNumUpper32;
>>> +
>>> +  uint16_t Padding16_2;
>>>    } SmuMetrics_t;
>>>
>>>    typedef struct {
>>> @@ -1476,8 +1480,12 @@ typedef struct {
>>>      uint8_t  PcieRate               ;
>>>      uint8_t  PcieWidth              ;
>>>      uint16_t AverageGfxclkFrequencyTarget;
>>> -  uint16_t Padding16_2;
>>>
>>> +  //PMFW-8711
>>> +  uint32_t PublicSerialNumLower32;
>>> +  uint32_t PublicSerialNumUpper32;
>>> +
>>
>> Is this the case for other ASICs also which share the metrics data with
>> Sienna?
> 
> No, only for Sienna Cichlid. The PMFW guys didn't implement it for Navy Flounder or Dimgrey Cavefish.
> 
>>
>>> +  uint16_t Padding16_2;
>>>    } SmuMetrics_V2_t;
>>>
>>>    typedef struct {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index 38f04836c82f..550458f6246a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -481,6 +481,41 @@ static int sienna_cichlid_setup_pptable(struct smu_context
>> *smu)
>>>      return sienna_cichlid_patch_pptable_quirk(smu);
>>>    }
>>>
>>> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
>>> +{
>>> +   struct amdgpu_device *adev = smu->adev;
>>> +   struct smu_table_context *smu_table = &smu->smu_table;
>>> +   SmuMetrics_t *metrics =
>>> +           &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
>>> +   SmuMetrics_V2_t *metrics_v2 =
>>> +           &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
>>> +   uint32_t upper32 = 0, lower32 = 0;
>>> +   bool use_metrics_v2;
>>> +   int ret;
>>> +
>>> +   /* Only supported as of version 0.58.83.0 */
>>> +   if (smu->smc_fw_version < 0x3A5300)
>>> +           return;
>>> +
>>
>> Since this is shared with other ASICs, I guess this check itself may not
>> be enough. This function may be skipped if it's not MP1 11.0.7 or GC 10.3.0?
>>
> 
> Since the sysfs file is only supported on Sienna Cichlid (10.3.0), is it a concern since the tie-in won't exist on the other SMU11-based ASICs? And this function is only referenced by sienna_cichlid, unless I misunderstood something (and someone else uses sienna_cichlid_tables_init).
> 

This function also gets called as part of common init sequence - 
smu_get_unique_id.
If PMFW version of Navi Flounder/Dimgrey ASIC is greater than Sienna, 
then it may go to the path which is not intended to be executed on that 
ASIC.

Thanks,
Lijo

>   Kent
> 
>> Thanks,
>> Lijo
>>
>>> +   ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>> +   if (ret)
>>> +           goto out_unlock;
>>> +
>>> +   use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0,
>> 7)) &&
>>> +           (smu->smc_fw_version >= 0x3A4300)) ? true : false;
>>> +
>>> +   upper32 = use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
>>> +                              metrics->PublicSerialNumUpper32;
>>> +   lower32 = use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
>>> +                              metrics->PublicSerialNumLower32;
>>> +
>>> +out_unlock:
>>> +
>>> +   adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
>>> +   if (adev->serial[0] == '\0')
>>> +           sprintf(adev->serial, "%016llx", adev->unique_id);
>>> +}
>>> +
>>>    static int sienna_cichlid_tables_init(struct smu_context *smu)
>>>    {
>>>      struct smu_table_context *smu_table = &smu->smu_table;
>>> @@ -4182,6 +4217,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>>>      .get_ecc_info = sienna_cichlid_get_ecc_info,
>>>      .get_default_config_table_settings =
>> sienna_cichlid_get_default_config_table_settings,
>>>      .set_config_table = sienna_cichlid_set_config_table,
>>> +   .get_unique_id = sienna_cichlid_get_unique_id,
>>>    };
>>>
>>>    void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
>>>
