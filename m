Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6116CD37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A0310E803;
	Thu, 17 Oct 2024 12:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qNU5RkZn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B7810E803
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q06dudm1+Rqh7MsNtKgxf3KSRtmJjziRhfGa9bb+PnYoR7XkJuNzaN3kLz/WQSljsnFLEElIfBuI3urhjwsixIpUa17h9uiuPP3bAuZG9e+7iosfqDsfSsHnkZPxduXd1FJye7/3++tZaxGF3vBmJaa7FLjdYv2GsUC7kpp1koc1+TjJV+bsNSCnRDEnJvsYPrbr27VW10O/d8StF3udUwLB/EMpTTsd+sR5ruAw9P1gX7AONgSrMcLdoIquNMl8YM3QuCxrMJWa8Hj3PI53AboWAsXzsfjBZBLz0jM8ysOsWe13dTghMHWcuBVntKOELSQJFofaS3VV4dDsh0KAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BebT2nLhpYLvb5EzoUf27wprdQ399dqV5D+r7ng6U6I=;
 b=K1xcjXE3vXFZqSESHT6t6d9pADZwqzmVxHAvUKDJc/fKL/DOHFi9Yf4znLk/+4QJOVWPX7R3gwzoyey6ANQ+UzIdBNrSp15uQe8ZIi2rEA3FTUmBruFxoa9yNH1xchntPF9+uJYLfBQb3S7Mkhj1o1XjcQLmJ+Ca3xATng1c8iNbQ06YK1kH8CffXKEOny7FzyR6JSc97EcAiOBcG53jOfcaWRa34Up6H3kQvlpOEPPdMiLZbjeEaP4RUY8xX3EDgMYKywJ3XhkKJX3R06bdragUMwmWs8chPgv8VH7cr8GwncW/baz5C93SR7Q4yGbU4ZkrB1D62MrREzBceb2aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BebT2nLhpYLvb5EzoUf27wprdQ399dqV5D+r7ng6U6I=;
 b=qNU5RkZnMHg9M7m2a8AC2f6OxkjW4sKDtgs2si8lAPNzJQRmlqihnOJ+Ltg8fohdDpXiF2H7szr+QsmBfTfgHkd/UBgzaGUcsRPbaqp3lKwV3JKAE8rZE3A+4r9jNdZxrp37Yolf5ApDZcZAEsLv/oCm4tk9bZuj1ZhqrGZW1e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 12:47:48 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:47:48 +0000
Subject: Re: [PATCH v4 11/15] drm/amdgpu: clean the dummy hw_fini functions
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-12-sunil.khatri@amd.com>
 <6c44c6b7-bdb9-483b-9027-8e93380a710c@gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <87e03559-bf7a-5435-bedd-1ce1fc979c57@amd.com>
Date: Thu, 17 Oct 2024 18:17:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6c44c6b7-bdb9-483b-9027-8e93380a710c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c23785d-1916-44f7-2beb-08dceea9e759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wks2cXRkRXkvMUl3U3grU01wbkwvaEVkU3BJNlVvWE51emxWblNLR1QxeGsy?=
 =?utf-8?B?TStDSElFUlIvcTZ4N0FSSDZZWTh1WjdnYzlucXZCUVp5WHZFckpoVFNDQ25o?=
 =?utf-8?B?a25ldXMxK2hEL2QwdmdpZ3pweUc2N3lBaDAxaDk5TFBBT3ByNGlFdlQ0aFNj?=
 =?utf-8?B?RHRVZmUrQTVlamVGd1pwL096ZVdFWmM0a1BsNTU4cDV1UTV3Q1ZDUlB5d3JQ?=
 =?utf-8?B?WG5IUXdJSlFnZlhpMExIVy84TFc5VDU1N0YrYitmVUpOcEF0QVJPNGs1QVhx?=
 =?utf-8?B?WDBoZlB4THhJOUoxMm00djNwTy95Njk0WE9JYnlJY2J4anpTaDZKa2JkaXd3?=
 =?utf-8?B?cG1hNGhycFcwTUZUeTJrQ242QWRORlhwZ3J5dVdNTHBXM3FRek81c3JmcGdn?=
 =?utf-8?B?QUFhc0hhZE8xMlZnaHUrNjlhdTNjQU80VzdoZDdLMmJEeWJNTkJ4ZVJyVEVS?=
 =?utf-8?B?Yks3Ymw0MjdtTVRIMzRkdmVkaGVpYjErbFFFVlFuSlBjMFlNUTBHZ1RzL3Y5?=
 =?utf-8?B?ZFdKTGZzVHFiaWtteGxUaDBQVlNOY0xrVVZWekxTVy80ZG95MGxnZzZ5K2Na?=
 =?utf-8?B?MzZLc3J5b2lhcFpWalczUXRMd1JtbGVHbHJTNUxiSGhyTnpYb2VaSUsveGtv?=
 =?utf-8?B?UjAvYi9Pbm00Zmc0U2RKbURpWlBQd3NiNlk5T0gxSXY5YXVWU2F5TktLc2l6?=
 =?utf-8?B?QjNoRlJqWUVUS0pReDAvam83NVd6V1EzYmFjU3Y3a1V6Z0hmSi9sT1hqaklR?=
 =?utf-8?B?V2lTcVhYZGV1VmEvOStJS0tkSHppSWV4NnVwN0hobHRUYXA4ZGtWaE5VeHd3?=
 =?utf-8?B?czFXWUZKSGQwK2VXQkszeXhXVDFzbFJBN0Rscm5xWUtmekVoM2YraElpK3dB?=
 =?utf-8?B?NDRIQXE4ZXB1TmY1N3AvdlNoUTFla2ljaUpML1RJRTBHeTBIcGcrRjlWdE4r?=
 =?utf-8?B?Y1BXdHAvWVllbEJ3azB5NkJYVFZSd3VaMSsyZU9pWmp5ZVV0Sk5GV2F4cnl2?=
 =?utf-8?B?c2JORXFxT2dWdWJFRmJRelYzZzlZSTM5U3Z3aDJEeUZlajFmaG5EK2JjVGd0?=
 =?utf-8?B?bXN0blZZN0xpMUt6b0EvMG5PWGNMY2RQWCtCbS9aTUdtcGxLcXloTEdJd0VP?=
 =?utf-8?B?dm8rd3dPTlVRQjh5emI0Y3lpSGd1d2YvVkR6Q00rZHNkSnc5QVJDY0pBZzhR?=
 =?utf-8?B?VmYvSkZrYS9RNm9aZW5wQ2IyZ01PbUUzdkdUclYxeVM3b1l1YXZjV2w4VWkz?=
 =?utf-8?B?T0FveU1LcGJySVUzV1JDS3hscnFDY0RqYzdvYXNQVlVNQ2hXQjh1YUwxaG1p?=
 =?utf-8?B?OHRjaXJPVkJiUk43STBhV20zLzA0QUpseHlUOHlFNFJ3QmxwZWdQUlJ2SDVU?=
 =?utf-8?B?MkV3UkJSbGNJNjNHcVVMVGFJUjEyV09iSGQ4V3hJQWtSL25sYng3WVFoOE94?=
 =?utf-8?B?RVNJZFRpMG9QVHVQV0xlK2hWbXl4QjdQKzZmWmRWOFJ4T3c3TkhsRUs2S2NR?=
 =?utf-8?B?N2liN2EwMkxWRGwyT3k4dTBoT0R0NFR3NENIQ2s0dU54WnZpaklhZ0VwU2Vo?=
 =?utf-8?B?b1p0M2t0OTBsc1NsMTFZeFk0cUE5KzRLWWt6S2loeHJhNHVIMXh4bE5DZC9D?=
 =?utf-8?B?KzNJb2RiUEFOSEFielA1TGlHOGhZTWVYN2MwSlZkQ2dCV2VFZnVENldtL0RR?=
 =?utf-8?B?RWF4K0RMRnh1blFwMWZvUXNwL1pwMVdtZGNPQU5JQ2o1RnhtN2pUcCtyUEl5?=
 =?utf-8?Q?AEzP5fp1ecZSpR7y3vBkgFju1xvgzu/acqQdRC7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01Lb1owZDIxM2IrYmlyWkpWNGZQS3FVcHF0aVNlQXZTYmJZajd4NTNCSWEv?=
 =?utf-8?B?QzdGaFB4a2pFbUVjTkU0ZlVXYUh3ZUltc1hoVmptR2JDR3A3WXVkUUNWUXdI?=
 =?utf-8?B?Rkg4cUd2dFExWlBCZmhySXBmazhFTmMxaGlnRGVoOHVZT1diT0theE5HZDBW?=
 =?utf-8?B?UDhKQnhRUlRqdGdwb3dpUllYbGJBVWQrWUFDcjRpRTVYL2Q5S0ltRTBpcS9I?=
 =?utf-8?B?TGFuaHRMd1lHdFJWd2dCRjM3dGdBVDhvZ1RnN28rMVlMcUQyL2Z0RFZZdVlx?=
 =?utf-8?B?bzhVaE1OUG1sZVZiVkxoc0RaNkhFdllZd1JhbjlaZG9ZblFmYzZ6SGV6SERG?=
 =?utf-8?B?TWNiSHNaVEFjRzRHUzRRZFpiNmh4RHNoWUxlVld5WmJmN2hWOE0rdHFJeUJ4?=
 =?utf-8?B?VnQ1RVd2MU45UmZXQVplMTdaUWIwOVpsTmlSemUyVjdoRGtYcTJ4bExQalZN?=
 =?utf-8?B?WmRmU04yV3BJRDdKL1oycEppSEFYTld4ZVppTDBKaGllY1VNVTRraGRqcisr?=
 =?utf-8?B?aG1xNmtkSFRxT014Z0ZKV0cwZllJWGdkczV3eVk2cmREUWJsc1d6aE91QmFW?=
 =?utf-8?B?eW55dERiaXpmSzArVUZFYVdpSHZRbHNOMmM2VFk4MkxkT1pMeFJXeXNGL2JH?=
 =?utf-8?B?bm96ZVp2NkRob3lOb2F5ZEM2ZnZGdlRlVzlOWjhpbnVmczQvYmIrVkxrOUpR?=
 =?utf-8?B?bHR4Rzg5Umo4bDNUdUIwL0FlTWkraTNocktwdG9VVzFDSnFtTUY3aEdrZEx4?=
 =?utf-8?B?OE9OUWduaFd1d2tjVTQ5TE5yMkc4Z1NOMEo5V21IRk1CcXg4dU1LaWgvVEhZ?=
 =?utf-8?B?eWpIN0lra0l6QzRHZE9nRUpqRiszWVhENWNjcXNrZ1FFaFlJendyM3dRNlVP?=
 =?utf-8?B?K2VPU0lyQ3BpbVpKT2lTVitvaEp5WVBjUGp6MGdVME9GNFFmQUxLR0hqWTQy?=
 =?utf-8?B?T3Btb3RMZ3NGTFdjdVpKb1dMMUI3Qmc4NkhOOFVFeEZqWG0zT0pyeFZSYTJ3?=
 =?utf-8?B?U3owdzhUYXY4ajYzRng1bE9FUGlUT1I1S0thOExZc1RCNnJFdlRvLzRFZDBz?=
 =?utf-8?B?aUtvZ3hJVGFjRko5L1BpQkdYa0RPbXdnWWFaOGx1MlRxVldJUGR5ZkU1ZXpN?=
 =?utf-8?B?aE9DSDJUTUdlV0RCR09qbTZYSWVjMlM4eFpZb2IvdGVSdzVVVzY3SE9tNDFG?=
 =?utf-8?B?TkFBTFpGQUJib2cyZnBxWVhWakYxcDlXZ0N5VEJ1dlh4Z2JHQkV0azlYTUlj?=
 =?utf-8?B?MDArVWFHM2pIaDJSVndoZEROV3FYbFFQa3ZxckRGN21ONzF5eHRXditQY0VM?=
 =?utf-8?B?Wkx5U1FvUDltdlQvZWNJQ3RnWjdZY2JybHBkK1h4YzBtMjBIOWVlcXJIVjYz?=
 =?utf-8?B?L1dZem10QncvMkNRenM3T1VtVXVOZEtLckwrSSs0clFxeXJJUXBVV0x0Uytq?=
 =?utf-8?B?dUpOMUl3YkVNeVBnOFpOQktwempsQkRCQkJjdGI1TEE3UW1VTEpEanFZYzll?=
 =?utf-8?B?M29yWXMrWDkvYS9wdzdHK3hvbnhLdVdDQ05yM0JTd3pGc1BVUXRZUEViZUUy?=
 =?utf-8?B?VWlPTnFQYkNFU3NDdjhZR1Y5b3BnNzNOdVBaaUI4WHJSSjRmUGpUSm90S29L?=
 =?utf-8?B?TG92Q0VFUEpSdlRXY0ZlbWFxK05GV3NEdmcrbjhWbUJVUkhNM0VuMlBRdFdB?=
 =?utf-8?B?aTBwZGhDTUFOTTM1alQ3TGphT29wai9BRmpRaVpDOGloMmh2eE53Ymk1RDNh?=
 =?utf-8?B?OURGUktrWGYzUjZSVHcvS092eFVoMHBHQXphdlNjUjFieXp6eG1BYVpVbGhm?=
 =?utf-8?B?VGFoQWp4Zm9tN3RKMXU0MTF1ZnZPT0FQN05xVjlZc2FxZ1R4djBxd0tWdHVF?=
 =?utf-8?B?YjNMbDB4TWpmV3k2T2Z4L1ErQk14RGVxVWtYMmFTQ1NhLzZoWTJ5NjYzSEVw?=
 =?utf-8?B?c0FjSDVSMWNPNUNIc1p0VVZLMUdWUHdmYXB5TC9STnBYNFpVdWdkRFYreXhx?=
 =?utf-8?B?UDZaTDVJTnZyelJKYzRUdTFabDBJYmxvREM3cFdNSXo4ZTRUdTVGaHF0Wnl3?=
 =?utf-8?B?YVcyejRoOEVxS2lzWjkzNjFLWGlYSnFlcFN1MFcxb1YvT0RaN0tPTDdvVERn?=
 =?utf-8?Q?rTO9lGKaO5Oz0rs3rzEwtrZEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c23785d-1916-44f7-2beb-08dceea9e759
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:47:48.0646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bp9sm+ExwSZF2wSKuqi/WhVLv3UOvXc5s9sMu70FT9DLRnmFxL1MdVsoo5q7TplXCdufAxDS8oNihG1EmDknBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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


On 10/17/2024 5:28 PM, Christian König wrote:
> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>> Remove the dummy hw_fini functions for all
>> ip blocks.
>
> As discussed on the call hw_init() and hw_fini() are the only two 
> functions I consider mandatory.
>
> So please drop this patch here and as a follow up task maybe look into 
> why vkms and mes_v12 don't have a hw_fini function.
>
> For SI and CIK we probably don't care any more since those are to old.
>
Sure will drop this patch and will see the reason first before cleaning 
this up. Will push new patch set for this after understanding the reason 
if needed.

Thanks Sunil

> Regards,
> Christian.
>
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c |  6 ------
>>   drivers/gpu/drm/amd/amdgpu/cik.c         |  6 ------
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 11 +----------
>>   drivers/gpu/drm/amd/amdgpu/si.c          |  6 ------
>>   4 files changed, 1 insertion(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> index ed8015313827..e3a399bfab61 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> @@ -600,11 +600,6 @@ static int amdgpu_vkms_hw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
>>   {
>>       struct amdgpu_device *adev = ip_block->adev;
>> @@ -661,7 +656,6 @@ static const struct amd_ip_funcs 
>> amdgpu_vkms_ip_funcs = {
>>       .sw_init = amdgpu_vkms_sw_init,
>>       .sw_fini = amdgpu_vkms_sw_fini,
>>       .hw_init = amdgpu_vkms_hw_init,
>> -    .hw_fini = amdgpu_vkms_hw_fini,
>>       .suspend = amdgpu_vkms_suspend,
>>       .resume = amdgpu_vkms_resume,
>>       .is_idle = amdgpu_vkms_is_idle,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>> index c8fb592f13df..9cb25d0d1051 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>> @@ -2138,11 +2138,6 @@ static int cik_common_hw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int cik_common_hw_fini(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int cik_common_resume(struct amdgpu_ip_block *ip_block)
>>   {
>>       return cik_common_hw_init(ip_block);
>> @@ -2181,7 +2176,6 @@ static const struct amd_ip_funcs 
>> cik_common_ip_funcs = {
>>       .early_init = cik_common_early_init,
>>       .late_init = NULL,
>>       .hw_init = cik_common_hw_init,
>> -    .hw_fini = cik_common_hw_fini,
>>       .resume = cik_common_resume,
>>       .is_idle = cik_common_is_idle,
>>       .wait_for_idle = cik_common_wait_for_idle,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> index 9d0e342a2f81..a1af5c90f79a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -40,7 +40,6 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes1.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_12_0_1_uni_mes.bin");
>>     static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block);
>> -static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block);
>>   static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev);
>>   static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
>>   @@ -1516,7 +1515,6 @@ static int mes_v12_0_kiq_hw_init(struct 
>> amdgpu_device *adev)
>>       return r;
>>     failure:
>> -    mes_v12_0_hw_fini(ip_block);
>>       return r;
>>   }
>>   @@ -1600,15 +1598,9 @@ static int mes_v12_0_hw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>     failure:
>> -    mes_v12_0_hw_fini(ip_block);
>>       return r;
>>   }
>>   -static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
>>   {
>>       int r;
>> @@ -1617,7 +1609,7 @@ static int mes_v12_0_suspend(struct 
>> amdgpu_ip_block *ip_block)
>>       if (r)
>>           return r;
>>   -    return mes_v12_0_hw_fini(ip_block);
>> +    return 0;
>>   }
>>     static int mes_v12_0_resume(struct amdgpu_ip_block *ip_block)
>> @@ -1663,7 +1655,6 @@ static const struct amd_ip_funcs 
>> mes_v12_0_ip_funcs = {
>>       .sw_init = mes_v12_0_sw_init,
>>       .sw_fini = mes_v12_0_sw_fini,
>>       .hw_init = mes_v12_0_hw_init,
>> -    .hw_fini = mes_v12_0_hw_fini,
>>       .suspend = mes_v12_0_suspend,
>>       .resume = mes_v12_0_resume,
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c 
>> b/drivers/gpu/drm/amd/amdgpu/si.c
>> index 66ccb76eb72a..e1b3bef6992a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>> @@ -2634,11 +2634,6 @@ static int si_common_hw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int si_common_hw_fini(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int si_common_resume(struct amdgpu_ip_block *ip_block)
>>   {
>>       return si_common_hw_init(ip_block);
>> @@ -2676,7 +2671,6 @@ static const struct amd_ip_funcs 
>> si_common_ip_funcs = {
>>       .early_init = si_common_early_init,
>>       .late_init = NULL,
>>       .hw_init = si_common_hw_init,
>> -    .hw_fini = si_common_hw_fini,
>>       .resume = si_common_resume,
>>       .is_idle = si_common_is_idle,
>>       .wait_for_idle = si_common_wait_for_idle,
>
