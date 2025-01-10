Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CCFE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 03:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0498310E4D1;
	Fri, 10 Jan 2025 03:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tSNnHHdw";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CDC10E4D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 03:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otScmxe1Cty8x/CBK5FSGVAxajluuAWh3g956khh4ekdcG+9nZ5L/iV3vg6y30uVDSxg+G+Lmsjsy8PapSBbTL0wGEWxzLyv/tdgreMXeAnOxh41HxhEjLAbw/xl7gTpVVJYtbo2FtPFGOl/YRFxWgr+v9zf5HkdppwFH3/5j1nd5UmRsNhLKIU2k3+CSxBJOmrpHCtzpelYFwKNIXEOqHEmdkuKqqQvm/IvbZ71FgZZb5eVrc/NDmw14RoSR96q2rp1XAafc3YGzt3d7+y9dFj2XhmGoI6u+aMtShKL0tYNBLWrj8liBq7SlfeV3jv85Z8N+keWSWeQwP0CjZ2sxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u860wVv6tq8mNsl/l24r429UmDvltQgqnQ0ZROd2ErA=;
 b=vfqWWTI98mDKYFZmyt0hB7J7DrkeiJ+/COqpZlW7+S6KVECzTlri6OSvOEosp0C7iQL4FqvixGNZUQLbGewk8BeVjq8VMg4xUgaS0TJUcliOhpubXZBx0AykumZn309N8N6JpV3hPXj4GGo0JP1+BDEASZ1Z46g6KO/GN2Wl3QDMimLBSjJT0nhRcyLQm810SwaPQWeIWgChFlds8OQ7RlUNjRu0/vB4RFePKwsh6L+KzQGvb7N+uTJNcG1W4Ls+A4QUHavhuq3ZNk+ZjgTJSDoU44KUUT5KP9JYY+LcshjNakWv5bCfPWEa0XxvuPECK3sH6fvdfwTwWHG0f5kOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u860wVv6tq8mNsl/l24r429UmDvltQgqnQ0ZROd2ErA=;
 b=tSNnHHdwyU0aZZ5ufvMzL77K4/P3DWrNqHU6hSchgp+MQNIAbxFAa6Z4xlnmmJvER+v96uUt1HF7+cX4/czTxrcq4kFrzWTc6bQ2P81PSHLM4TLt3mY4Doir0jEWYxLWp41B+WSmhvJWZhobEbvtzf0wKYkzFQO8W7ssSk0YwLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 03:39:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 03:39:02 +0000
Message-ID: <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
Date: Fri, 10 Jan 2025 09:08:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: c0623c05-3101-4d52-8821-08dd312852f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJKMmZJZllhSkkzVHFsd2tBaFdGR09UbitGeU9ENnQ5SGM3dUFBTGVYTEJZ?=
 =?utf-8?B?RFRyR0E2VHlQL2kzK3hMdEpVUFpnVHBHWUh6TW9UVGRPTmlzUUtoMk5YVzE1?=
 =?utf-8?B?dlZOR25DSHpaWHJNQWlDK3p5ZmVJYUlTVjhwM3ZEM1NFSzNZNkNTN3lzbnFG?=
 =?utf-8?B?QTk1RW83bkg0dVAxd0FFa2R5OENLSm9MamFjUXRJTGZvV3hmWFo3ZS8veG1h?=
 =?utf-8?B?SU1peUd3d21qOTNkalE4RWEvUmErbGQ5aFVWQ1Q3S1E3dEZkQm5SdnZ5K0wr?=
 =?utf-8?B?S1gxZWNkWnRva2RaSDVlc3BUVk5wZDdLVzM2cXcxRFNTbDArbEJmQWlLWTRL?=
 =?utf-8?B?M3J3NTkwNnZiRGFZRU5IN0ZWOHd0N3A1SWl5Y1psZnJlQTZWbkdVK1ZQT3hX?=
 =?utf-8?B?QXBaWXFkQVd3blQvMEtaYURWVTZ2UmNCbkZPS2k3Q0dtR0pjUnhjZWRkNVAv?=
 =?utf-8?B?UkFoR1liZk1VZzE2UGRoWjFlUlhnenEweTdNYUxhU0J5RzROYU9GZUJLeFda?=
 =?utf-8?B?MTFXRGZJREFtclF2YkZncXJ0KzVmRXhYWkc3UldDNGxQWGV2ZlVkbjkzQ2l2?=
 =?utf-8?B?STE2cjVSbThFMEcybXJRdElXVFJFM0lsbDV1cGlVL0pzYXhtOG5PUmFRN3FY?=
 =?utf-8?B?RjZRbGFRZDlwdjNTRG52MUczWFFMSTQ5QmEvbXdoRjlMcWRmZ3ZKWW45RnBj?=
 =?utf-8?B?dkliTGRWM0FYbThzbjJBWWZpclhvcG9YRGN3QTZoUjlrMFhjTHNkWkFtbW9R?=
 =?utf-8?B?bE12L04wT2Z5RmR2VFZCcGNENGVQbER4bzkzQUx0M2llbHNiUkw4K2ZYTzNG?=
 =?utf-8?B?TUFIdmd6TTZSV0kybFhHNjE1bHc1bUM4VHBwUEl2RUUyMFRHcUwrbmlTK0U2?=
 =?utf-8?B?c1YxbXBNWFJLeGc2S2wybXJoaUdOemNYK2h3aUVyTE9aVmR6WWhwVnZVTXJT?=
 =?utf-8?B?L1ZoUDZoR3ZnNUhZRUZsTjFCREk4djBFN05KSUxFYlhXMVg0NDBxaURjUExH?=
 =?utf-8?B?b1lRcUdQN3BRODAvY0ljUWxCRnFhY0ExdGRjTlh2cE1TblZCOWdIc2lnUUdW?=
 =?utf-8?B?eXNsa2x3d1FWUVdYUjRPS1M3VlIxK1d3NTRveEg3TGFnbkFKN01HTXJ6TEhx?=
 =?utf-8?B?MHEwdEJ0UHJGeHlQR3hTRUN3anhQQWNoV0lHeG9OeWFCb1BlVnBabGEvT3hX?=
 =?utf-8?B?eWN0RmhwTlIyekpYUWdCMDRwRTlMaHhUSWl0b3VkcThxcm5jUWpldmFmVThv?=
 =?utf-8?B?RjFmOFErcC9rZy9zRjJpa0puR05qMER4Y2ZFdGpyamF4M3cwQjl1UGFIeEs4?=
 =?utf-8?B?aGdSZURDaG9qWEUxTkVyL0c0QTdLY0QzY2ZNTWtBYVZ3ZldtVTYrNFpuUnZj?=
 =?utf-8?B?T3huYnFxWk14bHpBYkp6THg1YnFiQ2wvZjBVVXREWkpGamRzd1g3ZnVEZlEw?=
 =?utf-8?B?UFZROVB3RHVKdEFHUjUrYTNjVHFGbTJ3TmVHeFBWRWljd0xDSE5hWnpDNnBO?=
 =?utf-8?B?YThhVVgvV04yNE9jVUlBVjhPTGZBaXZxVEdkNmJiMkMvTEtIM2dFVWJ2THNF?=
 =?utf-8?B?Zi8rRTJFUFdxd3U2VHBIWTlyelp3Yk80WWFaTUtRREtUNGY1V3RuL1U5QXZq?=
 =?utf-8?B?L3dLbnI4V2N1eDVpQzMzRDAxZnNTbHNlUjRzM1hWUUQwVXFuSCt5YmhNdk5P?=
 =?utf-8?B?bHZad1lXamRjbDdHQ3NXZUVodlhEcDVhUlluS2FZU1ZQbXBqNjd1TEVaYlJJ?=
 =?utf-8?B?UzlZbzlMNnBEczU2aEtENVNrRWRTRVVsVUZrdEtSWlhYNmJQdDBxTUNsK21U?=
 =?utf-8?B?ZkJJejI2QldpMjNyNDFkdzF4VjdpWStScTNrdEVSODVhZi9GMmZhdjd3NS9H?=
 =?utf-8?Q?H1OFFk0iS6mjy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2wydUFDYVpPK1FOQzlJaFM2aWpEVU9zUlNrMU95N2JPZ211VjB2c1phODll?=
 =?utf-8?B?bExWNnl6Nmw2RGc2cGZmbDN0ZE9aclpib2IzK2tqeUNUSVJ1NDloQWo5MVZQ?=
 =?utf-8?B?NFpIRTdQbDErN3h3bG5mZmM5d3pQSVh4ME15b2ZCYlJuVC8xSTVvNVRqd3hn?=
 =?utf-8?B?Sndsc0pDSW1Icm9nSEY4V2VFK2x4Q1N4a0VmRE5xZ0xnL1lGSHEra20reUZR?=
 =?utf-8?B?TWlGMEZtRHV2TGphSm4xeDhaZVdQcjZ6VjlZbm5QUWlyazQ5Lyt1ejNEZFhE?=
 =?utf-8?B?Wit3RXk2MEM0eENtbEJrLzZLdHFDTVErY2JoN0tZcCtRTWpQRXhHVnJjNHEy?=
 =?utf-8?B?ak45Z0QrVklZbml3bmtsZ1B0d1pXWUdVdDlkOURqaEdTZkh3aE9EcnJtOXBM?=
 =?utf-8?B?U05DNkVjbnk5eFVJR3gzNHJvVUhhaFhFNG92dFc1ekYvTm9RNzV4Q3NIRkFI?=
 =?utf-8?B?SGY2Q09JcXUrblV2Nys3RVJzUHNBUjV3dnVEdy96eVFPL1I2SE1TcnBRdTFN?=
 =?utf-8?B?UGpWZ21nNW0vVCtoNEVER2dPeVYzVFhQVnJTd1BJc2V2cGtBbk5mQmxEN3FU?=
 =?utf-8?B?MzFFQVFPUjNYdC85N21YbExmYXZtRXhtbUpKeVpWeWtwaTBOQkhTQ0hUd3BS?=
 =?utf-8?B?WEgycjQ0eTR6TkFmRGNOc29kY3c4Snlrb08rRmtnWGI0dFZpdG04b24wb2RI?=
 =?utf-8?B?djB6bVFaN0kwVUgwc0RuVkJsWmxuclNzdGxnSjJTRWNrQ1pCLzVqWXp3VjA4?=
 =?utf-8?B?T2JranVvVm5qNHZmSmtlRzc5eXdXWm1ZUk12VTZGdUh1VElDenE0WS91WGY1?=
 =?utf-8?B?d2RleEkweitSdjl2dzd6WGdWbGhaMG13aTBNd1VxZDU1aVJWZmpKRnlzWkhS?=
 =?utf-8?B?cWVlempxRFJwVVRRQjR4aEc1Y3czbnZ2cUc0N1ZJcUpHSDljNVY4WDRuVGxx?=
 =?utf-8?B?UDV6WlBUQU1qcnJIK3AycDc3ZUpQNkx3d21xU1dpcU8yQWlHYm1Gc3VZaTdW?=
 =?utf-8?B?Qjk1MFJpeVA2S2VneDgwVGdJcWF3UnBFV3RQV0dBRE5EQ0RCTVh2by8vUUFM?=
 =?utf-8?B?WExtdlErdmhMVU5YWERCdWJ3SkJONWpLVUhPekJLYktKd3dMQlFJQmt1SXlm?=
 =?utf-8?B?Q0llZkh4U3JHS3VnanlVSHhtbDBLVGR4TTlmeWFxZnZ3R3BJUFYxbFozaEp1?=
 =?utf-8?B?VzQ0SHY4cnJvdko4b2JHcklzb09ZOHN4S0F3Y0F4ZEZwOXJmSUFQcVRtMW5t?=
 =?utf-8?B?WlNzN2NVL1dpUlJ2cS90Uy8wL1NBMUorRUI0aTVGblNIZ2pPUmF5YUNlYVJS?=
 =?utf-8?B?UDJEV29TUldaanJKQnk2MHVoeTFsN3JDMFpYbElobGpQY0k1dzNsUHU1RUIz?=
 =?utf-8?B?dWEzQk50NmNWRWtTeElFQ2EyU25ySTZlYXVpekovL0I3Y3ZMaVdKcnc4UnlF?=
 =?utf-8?B?T3lialZGQ1JwQnU2NXBnRXMwK1FZSURFY09Yb0ozNkZTRGdUNmI3cGo5dFBS?=
 =?utf-8?B?K2JrWFhnWHYwL0tvVnVOS1VRZzcycE5EQVlpZDdFVjRtV1B3Q05rYnVCemlL?=
 =?utf-8?B?NDdRSVlHb1lFYkt2VGpxUEZteDNrbVk4VzRvbmhvbU5nUUNvaSswcmYwT3Mx?=
 =?utf-8?B?TUpNSlQyRDRJREZGYkdISksycVBXdGtzWnNtaXJkRDJxMGlUbFhnZkY3TC9E?=
 =?utf-8?B?RXRaTkZja0R0UWhBOXhJUXhZamxXek5NMHhVZStpcUpCWFhiT2RqZnA5U0FC?=
 =?utf-8?B?a1pzMU85NENkNEs1c1pCVUdpWEVvc3A5b1AwMXZRNElDRFUyTmQvSHNWNkIw?=
 =?utf-8?B?QjZ0R2hKNURTOEVOd2c5aWVjeWFaVzJYM1E3V3A4NW1UeUw5RlZjQUhweEhJ?=
 =?utf-8?B?L1UrSmpTSW9zVEZ5czdQUnA2WEdrVU5SSUp3dXlNQTd3b2JzUGdISHVKZkpz?=
 =?utf-8?B?YTM1dGFUbDhyVmwzK2pXUXdvajczdmtZY3NTZElidFFlT3U3Y3l3ZVN1ME00?=
 =?utf-8?B?L2FTc2hWUGh0azcvUjlMcGR0dlhqTU1jOU02MXNsaGpESllUbGIrbkxMMGYv?=
 =?utf-8?B?S3lEc29iVmlmY3hsWmNiU3R1OFhZdFRCYzZwbFhILzhXTWwrUGk2WUorZGhU?=
 =?utf-8?Q?EqZlV6wLdkZuInHFHl9Tynco6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0623c05-3101-4d52-8821-08dd312852f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 03:39:01.9734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A724difZhuwdJfmJqu7VmL/W6urpHv7/qEbqZiMOaUjUuQ/317Y6eE7IAE6zX4ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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



On 1/9/2025 8:27 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, January 9, 2025 1:14 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>
>>
>>
>> On 1/9/2025 1:31 AM, Jonathan Kim wrote:
>>> Per queue reset should be bypassed when gpu recovery is disabled
>>> with module parameter.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>> index cc66ebb7bae1..441568163e20 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
>> amdgpu_device *adev,
>>>     uint32_t low, high;
>>>     uint64_t queue_addr = 0;
>>>
>>> +   if (!amdgpu_gpu_recovery)
>>> +           return 0;
>>> +
>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>
>>> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device
>> *adev,
>>>     uint32_t low, high, pipe_reset_data = 0;
>>>     uint64_t queue_addr = 0;
>>>
>>> +   if (!amdgpu_gpu_recovery)
>>> +           return 0;
>>> +
>>
>> I think the right place for this check is not inside callback, should be
>> from the place where the callback gets called.
> 
> I don't think it really matters.  We're going to have different reset types in the future that my come from different callers.
> It's probably easier to remember to put the bypass where the reset is actually happening.
> 

If I want to define something like amdgpu_gpu_recovery=2 (don't do queue
reset but perform other resets), then it matters.

Since this is a callback, keeping it at the wrapper place may be more
maintainable rather than keeping the check for gfx10/11/12 etc.

Thanks,
Lijo

> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>
> 

