Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9336CC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 10:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230B210E09E;
	Wed, 29 Jan 2025 10:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F269lU4/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB7E10E09E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 10:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtFyKWEQTYBMsRY4nqdRpp0h2fYmGdqBygrUD18yoIesc7KAkxzG9w5MEd79DK0gPChFJ4aAUF40A7suCP/F8bPu8mUJ6bY7O7nM+WDVeYdvxv0zUUCFkkH0rLhybUOStgnWIHTsBo79A1wA4fHYuciPnH/J9Hi8OC+VE3sqDW5RSttxBfPDSCu4S/3Z0GTwrKyw9mhKihIP6fQwH7qNdB3XdgOUN2MatmWRPvvcUxfDqNgPgSOmH4CqQRRJayE+5pmAq4K1+sElfJ4C9KnIRx2FXCeftBXuqRGCrykrQhghj9dNNmC9MwI7/bOpSGa7/yp1BLdikyvInSX+3fm4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKl8oxOZVaecP7lfrz/XyO9jMU6y3fm41jvLkV/Sk8U=;
 b=Jkl9HZ4v17CaZf7qNHyq1CB5Fagl6Z2ss+vNOnjUn1CxcN/hr4GWFlTd5SztRrG4IXvNkoF+oxuCsNUVBMqhaULo7TbTeFSR0WLeiqCfjSBGlnL6nF7SQIz8lmSGFImq/yS/CxaquJSw4v6K6mMxCoOu6k71fLz3x5qnmS2rHYEuFPLRR8k933nskIEuhyyFs5j1rrO7CIHMvYhHwM6fEtJSfh3ey7HClYwVHBfHDqUVEML5jPPOuj8ntvNStthw69y9HWu1hvhL3KIJ1nBh/uveaiIIdQT751ixWCHIz/naDtUPGhp4ExKkRVJGbpsSnNsiAcWzW/UX1oS5vkJzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKl8oxOZVaecP7lfrz/XyO9jMU6y3fm41jvLkV/Sk8U=;
 b=F269lU4/noXWfQzwSukwN1AylfRikUxIZIRCD9MvxbKBr0J8fs6ejegorxc8OhsT5i09LN/TgcnD1iBwTlrbKfIBPeHXmA4xfw85waoNiXRRkYCSLwqmgF05Whye3Dn/GLRlkDbHceCkItU/sYh+dcKpFEUcnWcy3TOK9H3W+bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 10:21:23 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 10:21:23 +0000
Message-ID: <760a02eb-867e-413f-bf50-090a58d8926c@amd.com>
Date: Wed, 29 Jan 2025 15:51:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-3-sathishkumar.sundararaju@amd.com>
 <7ec91b45-2c09-4d90-9d8d-b8e1582c3f29@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <7ec91b45-2c09-4d90-9d8d-b8e1582c3f29@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f975cf-62d4-484d-4713-08dd404eae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ExZFU3OXFkL096Rktyd1pXc1RDNTZlaVBNSHYveFQveTBUcW92aUMrWmxK?=
 =?utf-8?B?RWlxeUU5aE0vRkExUEh2THp2RU1SdWlrZ2RmZTJpMEFsd0lEamVHSUJwNGdP?=
 =?utf-8?B?Nkw1UldndjNFYlNoUGExWmVscDNDNXJvdjN4VG5jbm5HM2gycDhHL3VEK1c3?=
 =?utf-8?B?TFVtdjdLREZnVEwrMVdXdktWZkg1WEpoUkdhbmhTZUlwMmZXeEZTU1hqdEdX?=
 =?utf-8?B?TXZPNVJsRk5ZbGFCQUwwQys0bGtVQmlsMmU1bC8wdWpNVGVRK2tTdDA2YXk0?=
 =?utf-8?B?L1N3c2VTeEludFBCUlNNSUwyTytaN2RVNGl5Z1VuNE5EdHJEZXkzajRrRTZv?=
 =?utf-8?B?cFZaUnJ3UUNnZitaY0wxclBzR2hzSFFMcWRLa3V2Ymg4TFJmS0srdW94RExF?=
 =?utf-8?B?Y3l0SzZ3Z3hVZFZSOGpJSWJYVDFrakNJRXNaREdQRDFYS210aDA1Q3ZWVkJl?=
 =?utf-8?B?Q1JjcG94N3N3N0MybGJpOGRGRGNQNXBPK2Npd2hYTGlnbkF6NUpyaTY2SEkz?=
 =?utf-8?B?UU5BMS93czV2UHU5eTI1SWsrUlh4Q1BjSm5vQ3RGb3Z5ZUI4bUpoYkdkSTBN?=
 =?utf-8?B?alN2SFFMejNrOUFDZ3BBS0xKRWZ1LzRpRlpBRU9pM2ZmVkJiV1hJaXQrWjJ0?=
 =?utf-8?B?ODJydUxhK1RNUFlOSXFPY2J4VDB0UnJyYnBRb3YxNVhkOG91cGxHa25TMDEr?=
 =?utf-8?B?NW1sWEU3Q005bnNabWhxWWhjR3cvQko4WXB3Vmwya1FnbWlZeFFNR3JrVEEr?=
 =?utf-8?B?OUV3VkFJeTZGUk5LRkpPQkk0SEVZYXNyUlFPV3E1QnJDOVU0SHAvTzlCNVZS?=
 =?utf-8?B?dGNWY0YxWVFQR0JtSU9EVmlMd0xiTjlidlZJN0VOYlRDR3E3Y3o2LzQ4Z0Ra?=
 =?utf-8?B?Nm51cy9pQ3E3TnBrcGxKWXpXNnE4cndpWWhMcmdGaTFGOExlVytyU2ZrWUtz?=
 =?utf-8?B?VXBNbCswWDdXOTQzMEN0UVRRR0d3NFFPeHVzcklRcml5WFE3Y2JCaThDYXU4?=
 =?utf-8?B?bEpnRStWdlFBMHFOcDgwaGVEeDFzVW1UaWtGSk5tNnU3aWZNVE5FRnMrL3Rn?=
 =?utf-8?B?Ky9RaGJyKy9nRmVtRW8vZEZobGlaN2EwYTlXTWhZSnNIS1R3VUVNZGw2VTVn?=
 =?utf-8?B?U1lEcXJGOXVEclNlSDJucXpuVzdnUjNYK0YxWWYzL0tERHg5R2ZLMlIycjlt?=
 =?utf-8?B?QWt4OEVodWMvSm50QXdLUEs5cHR2V2dpRGhEVDlrZzhWeGdVQWVaR0tPT3o2?=
 =?utf-8?B?YjlueWpKMDFWUGhsMEQ0UjNyMW1KUCtUT2k2ZUt0OHZIQnJlcWZPZU5FUU5C?=
 =?utf-8?B?bDAwRndjWGhDb2ZrQU51eG5YQUY0L251YXg0Ylp6U0ZLb1locmNUYURYRWth?=
 =?utf-8?B?WUFZVHo2b2NLa3hiVHRYZis4QTZPWHZWaVFnY3VyY253a3VsYVlGcWRObUM2?=
 =?utf-8?B?bXQvaWRCYjFLZVBxbTV6aU1id3NuYU5aeVdqT1RKQ05uU3Z6QkhlMzA2YnRq?=
 =?utf-8?B?d0lOZFRFTis1ZWNyb0dtMUNzS0FGdnBhMnl2VzhQVjhna2xQUGgzMStha1lS?=
 =?utf-8?B?RGVsUlY4NE5tR2NZS1duV3lNNjFtdmlHU2RTOEc1OTlubkRBaDZCTzhxSG9l?=
 =?utf-8?B?R3I4KzZIMGNFQkMveTlrZ0haR2lHQndvQ0ZDdGRwdW1iSjdhL3N0clEvMC9w?=
 =?utf-8?B?Q1ZWNWVFRFpvWWpCaTRNOFRQc3Z3YWE4N2pyazBYdzBDZ0h4K0s2ekFFdGJn?=
 =?utf-8?B?Wk93Q0ZpWWxEYjZ3SUxWY01NQTI3MlRCejZObkxHMHhONXFycUozVUltb3pw?=
 =?utf-8?B?cklEK3hmL1ZXZ2NrdkVHRE5yeWM5amJFdWxOY1NXazJRZDR6ZkVwSWFnZ0pU?=
 =?utf-8?Q?0QwqDcpPuVdto?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFF5cnRLbW9DOEhkWWtCTUJNcmlGYy9WaUp0U3kwOGNHMktrSGFNbW9OS1J6?=
 =?utf-8?B?cDdVMWplWDFjSmVDVUJqY3NSVElzWmdra3B2N0J5SDNWLzRtM2RhMk00bzRP?=
 =?utf-8?B?d1Q2bXRyMC9XeXJMbGhKbHlXNm8ybGJWVTNNM2pUSkxoL2FRTmt0WUtyYWU5?=
 =?utf-8?B?aGRKb1ZZbjBDemxtN0FEZTFYOFYvQ0FwUmJVaE9NRUM3WVlOVUh6cEFPL3Vt?=
 =?utf-8?B?UnlSVHFkbWxXdG5FTzR2ek9zeVZEQWc2RG05b21qMW1XM01wSzl6RUxtSHlx?=
 =?utf-8?B?SmcvdS83NzBrQS9jUVdIUzY5c2Z0M2ZpdTRuTzFaS3FKcDNzRUpEdXFmSHg5?=
 =?utf-8?B?NlJMTjBZWlFUVmkxQkFhY3VGU1RObEVWOGdlS1F4MFBoaU1vZVJGYXNrekFT?=
 =?utf-8?B?ekJzR29pRXdqWEsyenlOZ1dvR0NEbFFrNnBnNEk1aVdhaHZlblFoNiszSUZu?=
 =?utf-8?B?TnhTcDdxTFo0WkV6dGlFb01sTGR3dzcxMTlZbHYxb0dnUE95MmhqSTBqazJB?=
 =?utf-8?B?SEsxWm0yTFNDK2lVYS9nNmcyRmZYNHpNRkJLVCtGVXFUWStaaEtDa3B3Z3hW?=
 =?utf-8?B?UzE2b0RoZmQybmlhRXB0cDZ1K0JTTlU5QkY1L3hiejB0b21JYm9odkhvRExn?=
 =?utf-8?B?dno4cDNzN2ZPbTQxam1MM2V4Q3FVZkRXdWlvTGFJSlQ3OWJlYVF3dU5MVldv?=
 =?utf-8?B?YjRQV0xOWDRYY1loL1g2L0d4c1Y0TUJscllaa0Q2RVVJMitRVjVuSmQvL0wr?=
 =?utf-8?B?eWJKTVJYY1orRFVOV2VuNWRsWmxMd0hUa2NqM0FhYnpwc1FlL0V3VlVIRUs4?=
 =?utf-8?B?enVVdWFDandJNm03V0hqc01ZOFUzWmUrOWJMNnA4bGJaMXBjeDZ6RVplY1lW?=
 =?utf-8?B?Y1NKSlBNaUN3dVVMajlDT09vcStQeHkvV0xLNFJmUUhSQ2lTZWFJcWxVejJw?=
 =?utf-8?B?MGlnZkdGR1NBYm5PRGVYaUk3b2t0V0NUQ1NEZUFRa0crZXliaSs4eHB5eHp2?=
 =?utf-8?B?NVFXVUxWbml3K1FrV2x4azlOdE9SenMzN1R3MWhYOVFaNEU0WHNqRXhEdDM2?=
 =?utf-8?B?RlNxc0dNVmVzWkg5S2g4azd4SFBGSUNETXMwRXcrWFpnWXVnVGpCTnNWa1ZO?=
 =?utf-8?B?blZyeEhad2FoMkkrdDRaYTBITHM2WEZyQW05WDk5dTd5ei95b2R5cnBDL1pU?=
 =?utf-8?B?L2FWR25PUlFJRHJSeEFrZXIxQlVvN2hTYXBSVlNWNnB0M0Vha0hwaFR4T2pU?=
 =?utf-8?B?QU15YzRvMHR3eHVMdHlVbGQzVmJCT0lpd2pHUzlYaWZqdFc2N0owdTVVRUJn?=
 =?utf-8?B?TTRlY1REVW9JSDZaT2RuNCtFYzJScWxXSUd2aXhTNFY5RG15d01VRFllK1Vy?=
 =?utf-8?B?eDJDUTJ5V09JVWJpQ213YTM3V3dYRjhRdmxLYkRwVkxPdGlBM1R4RSs0MEdI?=
 =?utf-8?B?YUExejU0ZnZReDNNeE5qa0NoZER2VmdpSW82RzNTV0VQa3RxK1VNdk55WGFi?=
 =?utf-8?B?bnVIUFVkQVRzRCtQSjZBTnEybUlFaG01RUd5YlZ6SC9kSXBUSGpWSGN6elFx?=
 =?utf-8?B?aldPdFBYSEtjdjljZlhES3ZCcDAzMDFNQlUvalNkclA3T2hyK2o4YVI3Zkll?=
 =?utf-8?B?WmJGMy9jRGFIOWp4N0lJSUlDeU1SRU1UTjhUWmEzc0hFZ0pMWS9mck9NWExQ?=
 =?utf-8?B?V1hLZXN6dWZTL3pLSmREVXllWEJoUTFWMktXQktwa2dueFNieHpMSzRGRGR5?=
 =?utf-8?B?SW01V0owcXZLdGNPV05pcUczSjhrQ2c4bS81WXVRL3J4ODdzeUR2ejBTUTNH?=
 =?utf-8?B?QXl3N245eVpzaTgxc3RzeE9LSStzdkRGd25Pb2FSSlh3NHZoZzUvWndrSEd0?=
 =?utf-8?B?WVdKZlovM0o0ZTV6R0xCa2NyazVNSmV5N1ZudWMzc2UwOEI0SWp5ODNrRTRO?=
 =?utf-8?B?Mk8rVnc0NWFaQXVsQVltamQ5UWlrNXVjamNJTG1OV1RnUTlUN0lhTnM5UzVX?=
 =?utf-8?B?NGErd0dDQTNRbXJGTzduSUl2MmZyNndCT29iRll6WWNWOXhETmFzR1NCWk9j?=
 =?utf-8?B?VmRXbUZUbkVqN0hpc3cvNDM1ZlpjSm03aDQzMVpUSy9OcUtnN1gzNCtYRjB5?=
 =?utf-8?Q?7h2tjztMI0aMM4EKTBOUin70C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f975cf-62d4-484d-4713-08dd404eae29
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:21:23.2931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbfjxJNjxY7XQljMkH1j86ge0HWrsoI7Gd/dCSmpQr38mYYCYHo6aO/l6X1lxJW9dv3+dmKlJGQKazrHUrZK+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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




On 1/29/2025 3:20 PM, Lazar, Lijo wrote:
>
> On 1/29/2025 2:16 PM, Sathishkumar S wrote:
>> Add devcoredump helper functions that can be reused for all jpeg versions.
>>
>> V2: (Lijo)
>>   - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
>>   - use reg_list and reg_count from init() to dump and print registers
>>   - memory allocation and freeing is moved to the init() and fini()
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 80 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 +++
>>   2 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> index b6d2eb049f54..0f9d81e27973 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -452,3 +452,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>   	}
>>   }
>> +
>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>> +			       const struct amdgpu_hwip_reg_entry *reg, u32 count)
>> +{
>> +	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
>> +				     sizeof(uint32_t), GFP_KERNEL);
>> +	if (!adev->jpeg.ip_dump) {
>> +		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
>> +		return -ENOMEM;
>> +	}
>> +	adev->jpeg.reg_list = reg;
>> +	adev->jpeg.reg_count = count;
>> +
>> +	return 0;
>> +}
>> +
>> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
>> +{
>> +	kfree(adev->jpeg.ip_dump);
>> +	adev->jpeg.reg_list = NULL;
>> +	adev->jpeg.reg_count = 0;
>> +}
>> +
>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
>> +{
>> +	struct amdgpu_device *adev = ip_block->adev;
>> +	u32 inst_off, inst_id, is_powered;
>> +	int i, j;
>> +
>> +	if (!adev->jpeg.ip_dump)
>> +		return;
>> +
>> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>> +		if (adev->jpeg.harvest_config & (1 << i))
>> +			continue;
>> +
>> +		inst_id = GET_INST(JPEG, i);
>> +		inst_off = i * adev->jpeg.reg_count;
>> +		/* check power status from UVD_JPEG_POWER_STATUS */
>> +		adev->jpeg.ip_dump[inst_off] =
>> +			RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
>> +							   inst_id));
>> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>> +
>> +		if (is_powered)
>> +			for (j = 1; j < adev->jpeg.reg_count; j++)
>> +				adev->jpeg.ip_dump[inst_off + j] =
>> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[j],
>> +									   inst_id));
>> +	}
>> +}
>> +
>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>> +{
>> +	struct amdgpu_device *adev = ip_block->adev;
>> +	u32 inst_off, is_powered;
>> +	int i, j;
>> +
>> +	if (!adev->jpeg.ip_dump)
>> +		return;
>> +
>> +	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>> +		if (adev->jpeg.harvest_config & (1 << i)) {
>> +			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
>> +			continue;
>> +		}
>> +
>> +		inst_off = i * adev->jpeg.reg_count;
>> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>> +
>> +		if (is_powered) {
>> +			drm_printf(p, "Active Instance:JPEG%d\n", i);
>> +			for (j = 0; j < adev->jpeg.reg_count; j++)
>> +				drm_printf(p, "%-50s \t 0x%08x\n", adev->jpeg.reg_list[j].reg_name,
>> +					   adev->jpeg.ip_dump[inst_off + j]);
>> +		} else
>> +			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>> +	}
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> index eb2096dcf1a6..02886ec4466e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> @@ -92,6 +92,8 @@
>>   		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
>>   	} while (0)
>>   
>> +struct amdgpu_hwip_reg_entry;
>> +
>>   enum amdgpu_jpeg_caps {
>>   	AMDGPU_JPEG_RRMT_ENABLED,
>>   };
>> @@ -137,6 +139,9 @@ struct amdgpu_jpeg {
>>   	bool	indirect_sram;
>>   	uint32_t supported_reset;
>>   	uint32_t caps;
>> +	u32 *ip_dump;
>> +	u32 reg_count;
>> +	const struct amdgpu_hwip_reg_entry *reg_list;
>>   };
>>   
> Thanks, this is almost there. Personally, would still prefer something
> like below and have an instance of this kept inside jpeg_inst (though I
> see your point that jpeg_inst doesn't have an instance id and this will
> also mean duplicating list pointer/num reg info in all instances).
The multiple copies is one reason I am trying to avoid this approach, 
and we can still print only
the affected instance registers in devcoredump in the future if support 
for it comes up.
>
> amdgpu_jpeg_reg_dump {
> 	u32 *ip_dump;
> 	u32 reg_count;
> 	const struct amdgpu_hwip_reg_entry *reg_list;
> };
>
> Ignoring that -
Thank you, would prefer to have single reference of the 
reg_list/reg_count and use inst_id.
>
> With the current way,
>
> amdgpu_jpeg_reg_dump_fini() may be called from within sw_fini(). Just
> wanted to keep a wrapper fini() func to make sure all is cleaned up.
> That would avoid calling this from every IP version.
Can we have it the current way instead ? as few ip_versions do not 
support devcoredump yet and calling
reg_dump_fini() for every ip version irrespective of the  support is 
redundant, if we add that in sw_fini().
>
> Apart from those, leaving it to Leo or someone else from JPEG to take a
> look.
Okay, thank you.

Regards,
Sathish
>
> Regards,
> LIjo
>
>>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>> @@ -161,5 +166,10 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>>   void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>   int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>> +			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
>> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
>>   
>>   #endif /*__AMDGPU_JPEG_H__*/

