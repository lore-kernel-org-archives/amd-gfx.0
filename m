Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24DEC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 13:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7951310E624;
	Thu, 20 Mar 2025 13:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTR2NeAW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA3410E619
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 13:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F47kriM9ig5dxsz0EUt5odk/6RYqCLMI3jnb8H9dBHEQCwajdySZkxID9tGAo0pXWO4CyinR+ygvYVjdmUcFzjVfaWHhQhP8ppjlFg6VevCbK3SEJDbIuZ/60a1kaPpFKMSc9KF4vxxMkd50+PBPTcHwqWhMYv5OeOeLjpv9phWKJJFIQHaMgoqo2b2MTpP8QqCgMO11wberkzZujMJ1+JOxBfixnuuEaZFYa7gASdrrO9avvhGAIaxguiGVssssuUDyHVBwfOq0nxHerfRmKPOgTKYDNwFA2R3U0aA3pyH/CneWXjcrMxw6l+aSMO4PWHYAYgXOG+L2fMe6z5IBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE+dyBbEi0d8a3IfCwwTPefxpY4Mg/g0XcO6EpPyGJA=;
 b=xsSKlK58GJ5fsF7st/vId9SMoNygGhiFv8/EHLav8tvyl1+tUG/3q7hKBeWuYMWRKJvvRGTEcO0WHIXcS+0nbfc1Pz2r+KbXyqP/XsCAbKEQDyrlGUZtTHWC7ee3PYLFDRD3zcvJYRGDUZkARxCBlkKi4drHoeEVbUeOS/Q6TLh/jh6HzrO48E0gmKi+WKXZe3p+MnIOx5jMB5Y3XSCxk0EtunrqPCtjPfxQmrPwIhPHCsj5h24hDrcvJ7j2NB+GhEXVNvmDJGJpv3iQrxNh48IhPF3pAvfgNygc7ZaY4NQ4CkDlkDQWsW7vuOC/xZrw92wNqUNHSDaIYw3yDMiCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE+dyBbEi0d8a3IfCwwTPefxpY4Mg/g0XcO6EpPyGJA=;
 b=PTR2NeAW/py2fJf+3zGkpkWJXkPOSM2xHqu7GG9x4Pgf1i0l28+IEgSSaOX0aRBqihc1CLDUa2euVuRamRGoLwrLqF/m8a1DVohl5EXXf2rlVTfnvw4V7O0jVu1AC2MkwRls6ONQoMAjHaGvpjOJM/owTAZ7/1s1IL8sCBHZ6R0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 13:44:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 13:44:08 +0000
Message-ID: <878f6a71-204c-4f3b-becc-c8bb7ef80252@amd.com>
Date: Thu, 20 Mar 2025 19:14:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Shaoyun.liu" <Shaoyun.liu@amd.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
 <CADnq5_Mw834v4AkCFW6tSqwE-i1poAK+83GpKt_cvb8HaHDjRQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Mw834v4AkCFW6tSqwE-i1poAK+83GpKt_cvb8HaHDjRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: ac796dde-14ce-4f89-4691-08dd67b549a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0loM2trNWV1Y3ZQb3ZpRUdmWjgvTE1LS3dHcWdOM2RrNDJtb3NuR2RwRTZU?=
 =?utf-8?B?Y2xNdkNUWW1adkhoKzJHcG52NzdYbXlRaTFwWFlaMGxGUnJlWFY5QUJyNzFV?=
 =?utf-8?B?emNsQ0NHTGg1QUNUYklpa0QwQi9IMXFNQzJ6Y1RWVFpQMzF2dGdJdE1aeFlt?=
 =?utf-8?B?LzZnakxEamV1cXA5ajFDNlp0ajB4cmh2TUp0YmZYNUpqaFRHT0ZRUDNvVmow?=
 =?utf-8?B?NU01Q1czWWxBNnJad3NJeU9rR2ZFQlRDVHhYa2lXL3dhaVBpRjdPY2Q3MUZU?=
 =?utf-8?B?VmNEZGx5OFQ1eUFoV245M0ZSdzZoUU45R1VZK28xWVFRVVRCYzFHcHRaQkls?=
 =?utf-8?B?S3k2UmRkUytwRGNrM1BkOU1nTHovMEdHS1pRUTlxSnM1SWxsV0R1aGZ3cUhD?=
 =?utf-8?B?NzROYTZnMzhrckQ3TEVLM09PQ0JxWDhWU2VlZ00yMGUyWm9FOUNhTzVYZ20z?=
 =?utf-8?B?OEM4U1NuaG1Oc1FpcVUveWRsWGVYNVdxcTQxYTRjVFQ0L3VFOWhEb1crckpU?=
 =?utf-8?B?emJ5Q2g5ZmExNSs4d3BwQnFCRGRReEFaOGpKU0x4aWIweXROMlRLTFF5L1Ar?=
 =?utf-8?B?eTRKc090RzE2WU9MRFI4M1RqL1l6RUtLNzlkWmczZCsxZW5sbm5tYmNiM1JV?=
 =?utf-8?B?blAxamwzajdoajF4NkJRL0VxNEJSeUpMTFIvdjNnM2tSV0M1V3J3alU3UnBv?=
 =?utf-8?B?NnVscEo3SGltVmtsa0pXT1JBbmE4d0FtVzZPZVB4VjgyVmpBS2RmUHZlYW1S?=
 =?utf-8?B?Mk5DVVdOOG1SblRpeDRmUHpLQlN2UHpRYUNqY2JETS9FYkdFaHFUelIzUGdk?=
 =?utf-8?B?eFpPV2wwVGJrVS91RzlNc3BtZlNENXo5cXgzS0x5enhhaXo3endjQXlmWUo4?=
 =?utf-8?B?Nzl1N05iNUgyRDN1dkprdU52cW0wOXNKdkhhSlNKMnF3VnowK3dnWW9ZNXVE?=
 =?utf-8?B?dE5OQzZieVBjUVhrNThtQjRBSmtyT0pRVjlSc0taRnBFcnE2OVFrUGV1S1ZE?=
 =?utf-8?B?VHYzSTFyTmhsa2xHc0VkdTd1ZTlqNytZNXVLTDV3b1lGSGVINXFWNGRLN2xq?=
 =?utf-8?B?czZNUnA3clgyT1lRVmZCeC9JODQwdS9WSm5yZndPL052Q1Y0WTFwQXV0ZnZy?=
 =?utf-8?B?aWxacG83L3dzOHpWYzV0TDRFVVFjVlJMNndJSkRiVWxqTHVvbUZXQWIxVUcr?=
 =?utf-8?B?SE05ejdhVC8zUUNTTVN3aE05RUtTNDVmMnZaSmlDMFV1TEtrYnpkb2JnT1oy?=
 =?utf-8?B?R1orbS9zdXl4TWRYNjBNbUt5WG8wbmdZU1NnOU9ybFFKbWtiWWc3a3orN0VS?=
 =?utf-8?B?WFV4OStYRTFRTmlzemxoOS9TWUZ6SnRLL0VQVHl4OFVRenBBb0J0V1BydnVx?=
 =?utf-8?B?eCtrdThOa1RZb0MzbWZOdmlLSE9xQnpJcnE2bEJwLzRNRzc0aTFjaktML1pB?=
 =?utf-8?B?emlsTko1Q2dKSHI4NHU3Q2hCL296ZExCRyt5Z1JDM0FNZWt1bHFNMStmeG9l?=
 =?utf-8?B?ZEo0NUV2bXM4V0R0ODNHb1VzeFVtSm56em1WM1lkSkFLVVI2R3FmMmd2ZGpp?=
 =?utf-8?B?S2JYYndzekxZWFdWVmxwNEFlTGxCSzE3cVBsc1B5RlBxUExDMDhJZ01mMVJx?=
 =?utf-8?B?MFhXWktKQzZtTjZmdDdGUThZQmk5SmI4Ri9SL2EzV0RQZDUvcTdwWWQ4Szlh?=
 =?utf-8?B?YW93cTRnalFoT21lWit0czUyUU5IYXNSbDg0Qy9GS2pTSEUzVkFTOEtQU24z?=
 =?utf-8?B?c3Jjd2MrQjJnaWdZRC9VbzFpZXdTS1RhWWg3b2RNeU95bjNTSDFEb3FZcit4?=
 =?utf-8?B?Nk9raWtIRDlLOWZmZ3RPUEI1VHRIK0JZTHg0QmFjZnhXR2dDekxOOGVUTWFt?=
 =?utf-8?Q?lULM3nVzJyeym?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk9zTmZabnFINmVtbHZlVU82dEZpUE1hRXFsY0pEaFZOZGYxaHlQYXRKVndj?=
 =?utf-8?B?d1VvRDZBTXlRMVRuL29LZ1FBelpRODhBU1pOOTFGS1JHVU1qMG5Hb1lxSXVV?=
 =?utf-8?B?dE51bEJNWlp2RWdIN2RaNENoSExBdFBFbFBnUlhUdGlZYmRrQzQ1QVUrTyt0?=
 =?utf-8?B?cGF0U2tPSDN3alpuRUkrbUQrMElCM3R0a3c5bzkvcEFZekNOUG1EZlZ5dGZl?=
 =?utf-8?B?SGRoaGZkdXFUNmUzRFdRVGs5QlBTK0Z5WnlVWHArb0lQMGNaWmlnYTR5ZXFP?=
 =?utf-8?B?TmQxM2pQdHlqNVRJWUpxckpjRGxLQUkvbmpLUTVCV0ZaajgrT3Nqbm43L2J0?=
 =?utf-8?B?NEhpVW5QdGwvcE9GTCtvcm1qZ1NGMllhYW0ySFAwdUhQZ0pKQmhuZHRTeE1F?=
 =?utf-8?B?a3dyNEM0Wmo4bmJWUnNoakpEMnl6OHVPWm8zTTE1dWI2MTdydytiNjZ0bVBi?=
 =?utf-8?B?YkJDTWRJbVltWDhIMGU2Rk1VaFZXQTJaTnRGYlJqZ0I4ZG12Z3pvMmV2ckR3?=
 =?utf-8?B?K0w3cW1taUlmQW5rd2NCV3dYRnJhWkErOE5tQm51eGtpQkI5d3ZzTzU2SFVF?=
 =?utf-8?B?R0VIc3lZRmZqN2R4YmFIWUZYS3lkbklXMzJhN1d1a2l5NjFCR0xhOVlwdzQ1?=
 =?utf-8?B?L2ZBVFRHWTlvZjJES0FjNEVZYWh5MEQxc2o3dHk1dVNpMG5RU2VTUVY4N3Jq?=
 =?utf-8?B?ZGR4UEdNeGJyTURxYWhjWU9uY1R0cGc2dGF3SXJoMHpCQThlZzYydDYrVTZq?=
 =?utf-8?B?NUpyV1ZDanFOaXRrWnREeUtBM0JHVWxobDcwaEFieVordm1YSFZRbFRVOVpE?=
 =?utf-8?B?T0ZLMHVPeC9ieDRCQm1Fdk9lTnZyL1U4NXcwdGZOZkNxOFNOdy9iaUM4N1Nu?=
 =?utf-8?B?U1grTmpuL2NtV21SR09FSTR3cU55aitsU0IxbXVzWTF5WEZsQUZ4UmJQS0xX?=
 =?utf-8?B?cmE0dlB5dzVFV3hxNWhmMmEycDY5dUN3bWQ1bWx2UmhTa252YUZJSzgwcDV2?=
 =?utf-8?B?b0tKQUlVWCtuQzl1dVNhL09uR0NhZzdEb2trQW5rUk5mSGl4eHNSUTREdGhG?=
 =?utf-8?B?aVAzcHpEMjZnMllNL1NaL0lPNEIwaVFvNVJkNkpjcWtBa1hiQ1VkS3FxQmZi?=
 =?utf-8?B?algwWE90TmZUTzJvMTZEbVpsZTN5K1M3bWoydVU0NSsrU044VTI0MFBmZ2wv?=
 =?utf-8?B?Q2dxekM3S0hOdmJJakhjNEdQRDJDRm4ySFBCWXRYUUtFbTR3Z3o5RUl6Z2RE?=
 =?utf-8?B?UkV3WnVrRTcxZEFQVXNWQkgxU0Rld2RuQXhrMmFvSFQyVkVhd0pMcWJuckkr?=
 =?utf-8?B?ZERmaW5TV1FUZXdSWWQrQWR6NjJibU9qS3lHVGkzdzhWQWhRV2kzb2ZLVjVC?=
 =?utf-8?B?bFIxMVlLVWNtN05FMWgrTUtzWDl3NzRISXFwNzZVdkprdDhieWx4UE54ZzIr?=
 =?utf-8?B?SHVoUFY2Rkt3Lzl1bVIwU1NXcWZhTFFGdHpEdzEwYTZvT25PUE8vMFA5dHZ5?=
 =?utf-8?B?UDZPdXR5ZzJlUTFlNlJCSmFHQ29hS2U3RHNBUmJGc0Y0RlIwQkhtSkJkMEN5?=
 =?utf-8?B?d3pNTVZRaGl2MTdsdzNKSmJLeWNUMTBrYnJJYWFSZkJhUVFvVGVZdFpDQ0cy?=
 =?utf-8?B?S2c0disyazFET1duYVZPYXEzV2IrZTllTUEvOG44V01CWWduY2V5UGxKU2xR?=
 =?utf-8?B?V1FVSll2VWpzcXVKYTk2UE9uSG10TXFTbDZ6MDV6UitkKzVFZW5XOVlkeVNo?=
 =?utf-8?B?NTZUV0dUYXNzRUpyY1ZGMmU4dXZlb1QwTW5ENWREZUd6VUgvWlZXVUVmdWZ2?=
 =?utf-8?B?NEw4NXFlNzAwMW9WeFl6OGkwaUFjZCsvcnVORzRScGkvQkQ2cEhVOTRLUlI2?=
 =?utf-8?B?VGwwVWpJdFVGdkl6T09nR2w3NzJUeCtXTHNMTDluZkFrS0t3N1p1TE5XdStM?=
 =?utf-8?B?VVVySE5JaDBQVlpNWG9scDIrUTA1ODBDcllNVFhFWG8ySDBRVnYwOHd3NmJy?=
 =?utf-8?B?YVFnREVVWHErMks3dm9kNmpWdTFIMFhQMWx2MmZUcXBpRlIxVXpRcWZRa3lx?=
 =?utf-8?B?dCtRQURlWmVLMjRydlN5bXBBWUc4T3VmdnpyL1BPSTBNTXVEQyt4RUVVdmha?=
 =?utf-8?Q?EnZ4P/LefNnjOiqQQDlq7+I2L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac796dde-14ce-4f89-4691-08dd67b549a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:44:08.0499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrLrMkEdHsW9nhcPe3wHgm63tRA4fYtCyKtIK5E4YZFj4JUEV0PATe9YveMyjI1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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



On 3/20/2025 6:21 PM, Alex Deucher wrote:
> On Thu, Mar 20, 2025 at 7:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 3/20/2025 12:38 AM, Alex Deucher wrote:
>>> Break when we get to the end of the supported pipes
>>> rather than continuing the loop.
>>>
>>> Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 3b83880f9e2cc..10f14bf925778 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>       for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>>
>> Unless I'm not seeing something, why not just keep it i <
>> adev->gfx.mec.num_pipe_per_mec?
> 
> AMDGPU_MES_MAX_COMPUTE_PIPES Is the size of the array and I think it
> is aligned to the max supported by the firmware, so if we had
> num_pipe_per_mec larger than that for some reason this would prevent
> an overflow.
> 

I think it should be kept the other way and array size should be fixed,
otherwise it hides a real problem.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>>               /* use only 1st MEC pipes */
>>>               if (i >= adev->gfx.mec.num_pipe_per_mec)
>>> -                     continue;
>>> +                     break;
>>>               adev->mes.compute_hqd_mask[i] = 0xc;
>>>       }
>>>
>>

