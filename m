Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496F2C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 13:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B040810F596;
	Fri, 26 Jun 2026 13:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aee1T0Ys";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFC910ED85
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 13:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsfsiF3noMVJFNYJTna6v2BjOlTv3xWgW1aGwOsMzHG3BCzKAiig+AqQFrVeZJ9p+0ljQr3fcwYooQ22of1UYQePY4rTB+xDpm6BSkjdvaBeFxJw1aXbDJiK5dgqlJfY+MdUjldF7RCy0H9ajwFhGAVaUWHdTfIn7uRbtYxlFg2HOt/z6TXGd45tdYTIJwyCn/RFiByosHv+K+H0CWXeN+tzUBGbBfJWviNpmYZnVga3m0Xfam8Fki6X78xGJRfWE96z/gas23wiCBa2+XwWomqqZUtb63c2obSP67fT7h9HVgjZdB+m8QsgPVWCGC+lhfJqA9av1wlhA3FMvQuszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8y+wKtsAXvy7oHOXNt/DuJoTeEufhNN+z+PL/6dV00=;
 b=ebGilPiRSwH9VuGcKU7R2QJMLRRoIPXX9kJUo0lL2zOFoAY5euoRZPGiNXFs+eXscNeSzO6m1PS5mJPemvALSiCrvhult4prfru9Wze/qro0jnnWkG/nU7jBoR1jBAGrYcyrhHyaStmxaU7dN3krRDnKYzJlZZstz3ASXJZ311wLEFOTJnHUm8ScsitJCRAkOAtwwnGDFTnvDqE9VZJs2d+pfBvmCnZOTb2i2vWyoNNrmZLTE+24S96UzGv08xJJ54ZlFXpP0MI9o+VMPFUpXNuPlCFYc5ruZqyLboTjcDa+UZHRxZaVKik24H8LMO1pG8GFnRunWJ8+fgFiPMV52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8y+wKtsAXvy7oHOXNt/DuJoTeEufhNN+z+PL/6dV00=;
 b=aee1T0YsdyCvkC4YcHNJxz/QdP2iiAco7PaEJnvJSuoMbcLd36g9xWQkz8GQ3cb6/SUyDXZRkhAOerbNpiF4J3mU3lB1OksIodl+1SiRiKkkgoDow2X+rmVmDX335TI8IoYPjN4P2rwDdWvSi+RkWH4zNK0kIFx4/JewNXm7mRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 13:25:01 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 13:25:01 +0000
Message-ID: <09b3fa57-cc41-41b6-b117-69a05ec212ce@amd.com>
Date: Fri, 26 Jun 2026 18:54:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
 dynamic switch
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260626071752.192163-1-Stanley.Yang@amd.com>
 <d06a5c88-63cb-491f-8090-6df38325acdb@amd.com>
 <DS7PR12MB832415758449F9B1FE398BD59AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
 <a518c22d-35c0-4e05-98b1-de95d8f31fa2@amd.com>
 <DS7PR12MB8324DFB3CC667353307A93869AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
 <4569930e-6507-42c0-8470-e33cb69af088@amd.com>
 <DS7PR12MB83247FF0E7C66B49072AA0789AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB83247FF0E7C66B49072AA0789AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0159.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::13) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0e89f7-58ad-4e4d-5087-08ded3865331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: TvveDmPBhNoKfsPvT3XafhQtebTnudpi+lT207Tg2jnO+6aCeOmxviPRAbHqwvoJT2MM4FeWUfPwU0R0qsy+JwtIhyQgFjB8pc3Tm8LuYi1u3jx7Fnt1DLZHEMQVvvRC+M9fHJqxzYHoXGez8A4p8ZFvjM3cdtNufpo4nD6f+a35JbVVMGZgcBK/jxkw9VW9tWBE/p6xXi1DTINStpelh4baSsuxphfRj8bh2KDWvHDEIu+9fsTkux5bVIpwD1rYP8dcxDJ19Jbr9fIh4bqEhy45/RrNuboKE1zlp5IjdS3ceg3P5NJV6rLYcMkEWwgnzJIHfEUwl7UW3MeZd14/+RRzMHCUjdkgXBwMuwAcvwoGseMBUvP7gVJShIfC1bmA6uzHjnZaFXrY7UTywEyDhHQFbXLwCxX2r1Yl6vAEyDIAscBrrD7JIAsTaUP0eKtliz+Nmks3IVUVs1UKRJVh5U9rfS5rRc8HEx2LS8SFwLhvpXqsl5/+oPooOvd16ry2pN4+BmI4GF8QReMrb39LQoPajsIoSIKn4I5csWxolHbS+fvt1rWbCneJ1Bn3lvp7lFLpbgBXdslVMTEaUV1i0br8x5ETGNdBvywUXt332FxRevqUlgzp3DVZzKeba2EP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEd3Tm16TlhiZkE3L3Y1cGJob3B3anlMS2xVVS9WcHZHcjcraWVCL3pnK1Ex?=
 =?utf-8?B?MXB1NWdnK1pWVE5ocXZFakVwS2lIbzZsUHBSSTNBb04yNXpsNWNxUG81bDJJ?=
 =?utf-8?B?ZDBnMHRNVmt1LzJrTFV2bEp1NXJCL1d0czhWRVlRQ0NGRSt0WUI5SjQwVVYr?=
 =?utf-8?B?S1hVYzMvNGh3bTMvdU0rdHZMdHhZYXhFV3VUeDhoWnY3MXZuRG9VdzltSC9s?=
 =?utf-8?B?UEtrN3ZoQmtpK0FhTlpBMWpmNmt6dHI2T2NLWXFhWkpyUEtnZ1ozWDB3Uml3?=
 =?utf-8?B?K0RZczdKTDBxYVpVemJmelVIKzZMSml1M0wyS0hLNW1zTmpRZUNTLy80MVg3?=
 =?utf-8?B?eXYzc3RvYmFwL1RqNWI4b1JFMzBUNWdEZVhFdEZsZGRFZnVCU1laVEt3T3Ft?=
 =?utf-8?B?UkJiUzNrTGgzaldjcjJNQ09USXJzNUdYNEZsNlZEQmFrc1JxSWlQdHJOS2xu?=
 =?utf-8?B?dW53ZTNtR2pqbk1zTWlqQmRBY2F3Z2E4a3N3SmxJUlpISFhueVZwa0F2ZUFX?=
 =?utf-8?B?Mlk4bXVFeGVQYk1FWGtNMzh5dUV6d2l5b1RlL3ZyQllLM0tzd3ZRN1d0TVNW?=
 =?utf-8?B?K2EzbkRQVFNUMjZKNDlzcUpDbVIyZ2l1Q1J3TU1ib3RRY3ZaNDJvZ0NianlK?=
 =?utf-8?B?RHlmM04vTUpkSXYwekJrWkVWT1NsbFVOMVFZTENRekF5S2U1VWN3OW9GYVMw?=
 =?utf-8?B?c3hjRXJQT01CVGFuSnU0T0c0cS9XZkpVdzBSdzhZOHZGZkdreVJ6NlozMDQy?=
 =?utf-8?B?UDBvQjdlVnlFb3VHbUVhK3hOS0VpSUxranZTVk9PeUJGMkRMY2Y1aUk2Q2FR?=
 =?utf-8?B?bHY5SkNFbnlBalgrbnNWV3BMaWJnSm5HVnRFUGJkOURicnk0N1J1cHEzNU1I?=
 =?utf-8?B?YzZrL0MrQnV3YXVpRHpQOGZlTE0zejlXMnVSRXZYemhrejBuUTd2Y1c0NWda?=
 =?utf-8?B?S1R3aEJsbW5wS2FpZERDQU14ckFLTXhWWENCNEdaZDVRRHQ1OEFDakJCT0lJ?=
 =?utf-8?B?R3NtQy9HTG9NbHZjZEd0eloxYkJYaHpPL2JKMjJuTTNLMzhzbTZSZDNKYW4r?=
 =?utf-8?B?UE00RHV2K2ZreVdIR0NXd1V1cEhCRFNTcEpVazNEZk5INDcyYWpXV3JiUWNV?=
 =?utf-8?B?dzZxVGtmcGtIeWFWQmZtU1lRRFdwRXlickwzU0FqUE1wUXY2cXc1eVBEZXA4?=
 =?utf-8?B?cnR6QUEzNlVEakFRZHBQdm9wZTEwcSt3MU5YdU8wTmxXMVFhaUMxcGszZ3dM?=
 =?utf-8?B?QzQ2ejJwV1NZdE1KVnQyV2h0ckJob2Q3YkJVNlhteGI0eXgwOFROdys0eXFR?=
 =?utf-8?B?Wm1lOXBSbEs4aWhTcjRDbFRzV3BpaVY3WWNZRGExMWp2S0FZYmkvOGhsYWpV?=
 =?utf-8?B?d2hxb2ZGZFRRUmFkZVQzTmdvazUwayt6WXMzM2liNW5HcmhUYXVYcjJsT2c0?=
 =?utf-8?B?aWtIZkZQZklNSWE2djJwRDduQTA1Wlhhdit5V2xSeURVSVVKV05xUm1YeEo0?=
 =?utf-8?B?WW9IZ3ZVMFh1dWRuY0srSzR5WkZkUS81Ymd2T0FhLzlYUWV2L2RVSm9uaWkr?=
 =?utf-8?B?UG9xWTJta1lnYmtoeDc0ZTdFa0p4WWMyODd0dzFVaWdRdEV4RUlnOEdoVVNR?=
 =?utf-8?B?VWVuMmFSd2sxTlQzZ0pyeDJaWklvblJYOUI1ZDVmV1ZPbVBIU3VCb1JLVnhP?=
 =?utf-8?B?MWsxMTdRUGhtTTUwOVgzM3NGWlBwdzY4TEJ4UW1Mb2YrWWtYVGJNZjhsVlpn?=
 =?utf-8?B?YitwVlhYV1MxMDJGODB0RnU5bXV0OENTNDVTdFoxeU1EMWV0WklSMmtndWdO?=
 =?utf-8?B?dVJhMm94ekNTNlh4ZVFHWHFkb0lQZ2FUSXFNbXJXeStMTGlWU25SUUJjUGdW?=
 =?utf-8?B?RVo3aVVLUWY0R3ZsQmdleVhYZzFaQlpRc2I4RkRyNGNOMVltTjdtY013R3FX?=
 =?utf-8?B?WDBmU0RBY2dFRVNTUFRIM3QrY1ZEd3ZEQTdFUEFhTlRDWGlHMFJKZGVsb24z?=
 =?utf-8?B?Nmh6WFVZaVZOaGFLWXd3UzdRUVFvc0cxQllyeHJrb3NqUzR5d01ZTW1XaHY4?=
 =?utf-8?B?bTdCYURaVC82S29iK3YxVmc2MjlTMFd5NEdUTnhHODIybmFnT3c4c3hxSzVt?=
 =?utf-8?B?R2VtYjBOSnJ3OWNxcXJvaUR1Skt3SFdsRkREazRHVkpZVE9UQ2hMQ2ZNekk5?=
 =?utf-8?B?QkZIUnBZOTI0dlNJOTdvTnRtV2sza290UUlTQVpCUHZDWjhyR2tnSUU4cHRo?=
 =?utf-8?B?NlcxT1dTOVR3T1NtSDV4YmczeHFBeU5JRG9XY1UwOW50ME56dWhoQXBzS0ND?=
 =?utf-8?B?MUtXZkswSjhEY2cvVUJoQTBtdmlUMWo5QXNXUVNVUXRxZTB3UHRIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0e89f7-58ad-4e4d-5087-08ded3865331
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:25:01.0050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GG6xF39tFIRxJ+sLUFUi9j5t3YwLDjF6hy8SX/FQ8Bsw5VEXnffk8/zxTrfoCZZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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



On 26-Jun-26 5:15 PM, Yang, Stanley wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, June 26, 2026 7:37 PM
>> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
>> dynamic switch
>>
>>
>>
>> On 26-Jun-26 3:56 PM, Yang, Stanley wrote:
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, June 26, 2026 5:44 PM
>>>> To: Yang, Stanley <Stanley.Yang@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during
>>>> nps dynamic switch
>>>>
>>>>
>>>>
>>>> On 26-Jun-26 2:04 PM, Yang, Stanley wrote:
>>>>> AMD General
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Friday, June 26, 2026 4:16 PM
>>>>>> To: Yang, Stanley <Stanley.Yang@amd.com>;
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init
>>>>>> during nps dynamic switch
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 26-Jun-26 12:47 PM, Stanley.Yang wrote:
>>>>>>> On an XGMI reset-on-init (NPS memory patition mode swith), RAS IP
>>>>>>> hw fini, sw fini is called but hw init is skipped due to RAS IP
>>>>>>> block is not included in hwinit mask, so need call RAS IP hw init
>>>>>>> during XGMI reset-on-init.
>>>>>>>
>>>>>>
>>>>>> After reset, we set it to default level.
>>>>>>
>>>>>>
>>>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amd
>>>>>> g
>>>>>> pu/amdgpu_device.c#L5211
>>>>>>
>>>>>> The default level includes all IP blocks, hence it's supposed to
>>>>>> resume all blocks.
>>>>>>
>>>>>> With RAS as a separate ip block, ideally it should have resumed.
>>>>>> Could you check why/how RAS IP block is missed?
>>>>>
>>>>> static const struct amd_ip_funcs __maybe_unused ras_v1_0_ip_funcs = {
>>>>>        .name = "ras_v1_0",
>>>>>        .sw_init = amdgpu_ras_mgr_sw_init,
>>>>>        .sw_fini = amdgpu_ras_mgr_sw_fini,
>>>>>        .hw_init = amdgpu_ras_mgr_hw_init,
>>>>>        .hw_fini = amdgpu_ras_mgr_hw_fini, };
>>>>>
>>>>> The RAS IP block does not register suspend and resume callback
>>>>> function, so
>>>> RAS IP block hw init function missed under this case.
>>>>>
>>>>
>>>> How does it work for regular reset? For regular reset also, driver
>>>> calls the resume sequence for the IP block.
>>>>
>>>> I think the proper fix is to add a resume sequence which calls
>>>> hw_init (if those paths are identical).
>>>
>>> [Stanley]: Normal cold start is at the DEFAULT init level, and RAS hw_init is
>> executing normally, so uniras is enabled; Normal GPU reset, because there is
>> no. suspend, ras_is_read remains true and the state is preserved - so only NPS
>> switching to this XGMI reset on int path will trigger this bug.
>>>
>>> Not suggest add .resume sequence because during RAS IP block hw_init
>> process need hold reset domain semaphore but the semaphore has already
>> hold before, the other reason is adding .resume will break regular reset, it
>> doesn't need to be reinitialized due to all RAS error info is cached.
>>>
>>
>> Then a dedicated resume sequence needs to be added which checks if device is
>> in reset (being resumed from a reset) before taking hold of the semaphore.
> 
> Yes, controlling the semaphore by checking if it is in the reset state can indeed solve the semaphore problem, but as I said there is no need to suspend and then resume the RAS IP block in regular reset.
> 

Right. Eventually ras block also will need suspend/resume sequence like 
others for other cases like S3 suspend/resume (or during VF migration 
sequence). It's better to add a TODO comment (remove this once 
suspend/resume sequence is added or similar) in the existing code.

With that change

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo


> Regards,
> Stanley
>>
>> As an IP block, it will need suspend/resume for other scenarios like device
>> runtime pm or system suspend/resume. This can be used only as a temporary
>> workaround till that point.
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Stanley
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Regards,
>>>>> Stanley
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 14
>> +++++++++++-
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 10 +++++++++
>>>>>>>      .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22
>>>>>> +++++++++++++++++++
>>>>>>>      .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
>>>>>>>      5 files changed, 47 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>>> index 7ef7c54ab982..e11c542a01b6 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>>> @@ -3857,7 +3857,14 @@ int amdgpu_ras_init_badpage_info(struct
>>>>>> amdgpu_device *adev)
>>>>>>>        if (!con || amdgpu_sriov_vf(adev))
>>>>>>>                return 0;
>>>>>>>
>>>>>>> -   if (amdgpu_uniras_enabled(adev))
>>>>>>> +   /*
>>>>>>> +    * For the reset-on-init path (e.g. an NPS memory partition,
>>>>>>> +    * switch) the RAS IP block hw_init has not been enabled and
>>>>>>> +    * the amdgpu_uniras_enabled return false, check amdgpu ras
>>>>>>> +    * context uniras_enabled flag, eepron init will be called
>>>>>>> +    * during RAS IP block hw_init.
>>>>>>> +    */
>>>>>>> +   if (amdgpu_uniras_enabled(adev) || con->uniras_enabled)
>>>>>>>                return 0;
>>>>>>>
>>>>>>>        control = &con->eeprom_control; @@ -5859,3 +5866,8 @@ void
>>>>>>> amdgpu_ras_post_reset(struct
>>>>>> amdgpu_device *adev,
>>>>>>>                        amdgpu_ras_mgr_post_reset(tmp_adev);
>>>>>>>        }
>>>>>>>      }
>>>>>>> +
>>>>>>> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev) {
>>>>>>> +   amdgpu_ras_mgr_resume_after_reset(adev);
>>>>>>> +}
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>>>> index a86ab65aa2f0..ad24c7cf8936 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>>>> @@ -1045,4 +1045,5 @@ void amdgpu_ras_pre_reset(struct
>>>>>> amdgpu_device *adev,
>>>>>>>                                          struct list_head *device_list);
>>>>>>>      void amdgpu_ras_post_reset(struct amdgpu_device *adev,
>>>>>>>                                          struct list_head
>>>>>>> *device_list);
>>>>>>> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
>>>>>>>      #endif
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>>>> index 9a4e8715742a..f175c8987aeb 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>>>> @@ -1669,6 +1669,16 @@ static void
>>>>>> amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>>>>>>>                if (r && r != -EHWPOISON)
>>>>>>>                        dev_err(tmp_adev->dev,
>>>>>>>                                "error during bad page data
>>>>>>> initialization");
>>>>>>> +
>>>>>>> +           /*
>>>>>>> +            * For the reset-on-init path (e.g. an NPS memory partition
>>>>>>> +            * switch) the RAS IP block hw_init was skipped under the
>>>>>>> +            * minimal init level, so uniras was never enabled. Bring it
>>>>>>> +            * up now that the reset domain has been unlocked. This is a
>>>>>>> +            * no-op for any other reset path where RAS is already
>>>>>>> +            * initialized, and for non-uniras devices.
>>>>>>> +            */
>>>>>>> +           amdgpu_ras_resume_after_reset(tmp_adev);
>>>>>>>        }
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>>>> index f627a97797ed..a70e532b3d00 100644
>>>>>>> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>>>> @@ -465,6 +465,28 @@ static int amdgpu_ras_mgr_hw_fini(struct
>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>        return 0;
>>>>>>>      }
>>>>>>>
>>>>>>> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device
>> *adev) {
>>>>>>> +   struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>>>>> +   struct amdgpu_ras_mgr *ras_mgr =
>>>>>> amdgpu_ras_mgr_get_context(adev);
>>>>>>> +   struct amdgpu_ip_block *ip_block;
>>>>>>> +
>>>>>>> +   if (!con || !con->uniras_enabled)
>>>>>>> +           return 0;
>>>>>>> +
>>>>>>> +   if (!ras_mgr || !ras_mgr->ras_core)
>>>>>>> +           return -EINVAL;
>>>>>>> +
>>>>>>> +   if (ras_mgr->ras_is_ready)
>>>>>>> +           return 0;
>>>>>>> +
>>>>>>> +   ip_block = amdgpu_device_ip_get_ip_block(adev,
>>>>>> AMD_IP_BLOCK_TYPE_RAS);
>>>>>>> +   if (!ip_block)
>>>>>>> +           return -EINVAL;
>>>>>>> +
>>>>>>> +   return amdgpu_ras_mgr_hw_init(ip_block); }
>>>>>>> +
>>>>>>>      struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct
>>>>>> amdgpu_device *adev)
>>>>>>>      {
>>>>>>>        if (!adev || !adev->psp.ras_context.ras) diff --git
>>>>>>> a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>>>> index 4f44a917d48b..3f80b9f1f0ac 100644
>>>>>>> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>>>> @@ -82,6 +82,7 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct
>>>>>> amdgpu_device *adev,
>>>>>>>                void *output, uint32_t out_size);
>>>>>>>      int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
>>>>>>>      int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
>>>>>>> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device
>>>>>>> +*adev);
>>>>>>>      int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct
>>>> amdgpu_device
>>>>>> *adev,
>>>>>>>                uint64_t addr, uint64_t *nps_page_addr, uint32_t
>>>>>> max_page_count);
>>>>>>>      #endif
>>>>>
>>>
> 

