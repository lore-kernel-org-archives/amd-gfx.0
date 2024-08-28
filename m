Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEEBC5B54A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 14:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F81910E0D6;
	Wed, 28 Aug 2024 14:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OchOvo5J";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0410710E0D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 14:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVSfoeBtmNjDRIEDnUzvbmwHK2ndfNZW/1h4eVG15K0Z4p7Z5W+mRxaukikXZvabS5BeCUELuL1qDE+l6f63xi7f18Mn8t1IbWe9iE7+fbLidbJ6CwVAm7ebmsqfdp6BmNDhwfMdO0bny03h9OStsPlNOQXGmGypEdLNIk8dXbB8okjLbLaOwrGJDo/hHRX/Sud/CppT1yCn/SiUHEx/VL/WIsBS2OkSlsxkmhL9bTG6AS03SKxv9hQnt0XhJ+mJmt9UnhjUNZY1/qbub4hiZ2ll5BPmSJlTvWvvXZ54pm38VyzqFLebvWuWLBTPK+y3BNdytZInSun5hQjTh6CHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4ns9ETCJkgtxw3BTjUHa96DE19W8AimRZvwTzH0Isk=;
 b=PGaAZ6a62Lj6QO8+bnayLSywqDya9e/Z52VdbBGkKcs4EZ5LvojCuPTaTuun99t6WlFoZW75EhFIagh11RFchMCQkjUU65cTIrptJW+qrVgVqUMUJnQYRNk6fMcFRazS3V5eBX/xfdqSzWaMW4wHEDT2xzjKSNxegPpP9T/bTiGO8vXxAqC4u9IYVYe0XBsF02CmTfukqjzrydHh9+TsJCMcH44b/rqUw6HPooRjBoRJX8Ny9ozV5uxP1qGTgLYgDPXOxRrID7rBkVTVM8TbTVX1gBgeDo2sw7sT0+lv4NPWGPzeAFGqv8tU3wXaErXJqYkZvRX1AfejbEDLmD2TCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4ns9ETCJkgtxw3BTjUHa96DE19W8AimRZvwTzH0Isk=;
 b=OchOvo5J97tHaZcsDH5eE9PzhFmJqd18zL1Ua48BOOYSXOmw8IxU9JUE2ibw7gFip4DGkV6PACSgWW6dt+ls3Mni7jDAL/rBinHkwd1/m16HecpUQISHy0CCCsyBNz/Xgmw+rp16/f7w2ejOLJNVNJGJmHuQFCaBUmSjfo4CRO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Wed, 28 Aug 2024 14:56:24 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%3]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 14:56:24 +0000
Message-ID: <08385264-5387-4871-848f-5136826925f5@amd.com>
Date: Wed, 28 Aug 2024 10:56:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Determine IPS mode by ASIC and PMFW
 versions
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: chiahsuan.chung@amd.com, hamza.mahfooz@amd.com, roman.li@amd.com,
 aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
References: <20240827195308.92171-1-sunpeng.li@amd.com>
 <94137de1-b91f-489a-a5f6-5be49a19030c@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <94137de1-b91f-489a-a5f6-5be49a19030c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::19) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 9babb879-c89f-427f-7311-08dcc7719633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWhqL1IvSmhjWVhTOUF0SlNYVUZleC8wNnJVZzlGcGVZVWhLeGRZRWplWHJ0?=
 =?utf-8?B?VGJrRUpycElZMUFleXRodEpGb2xKWEx2VUdWWVRveGNXUlQrbTVHbW51LzN0?=
 =?utf-8?B?NEFlU3ZERUNma1VaRW9kbEtmKzVIQWpMbjRJTTh2aTVXWnhWRGZQTlZYUnc1?=
 =?utf-8?B?R0p3OFRtbkxRVFpIUjVQRlJNUTYzV2VwZnpXb05NWFBXd2NENnhaQWRCSXN0?=
 =?utf-8?B?dVhzeUdhU2gwMFUvZmtPNmxGc2JUWXBvNXpORENYN3RiNHFJN2JsRnlUSzgw?=
 =?utf-8?B?c0NKcWlvK2UrNVFmUCtsRVRQRFZldm9oaUxMZGdhRWE4QnA2YWNGM0JHZktV?=
 =?utf-8?B?eXRRVjlSaVFWSktrN2dQaU5ma0k2djNHUS9TK3RvWmhEaHFzRFdwUHdtdFRl?=
 =?utf-8?B?OHJwTDZuNjhLNitiVklJWWVBclIyUEx6Q2lmczZUSmVCQ2Z3N2EwRzI2L09Z?=
 =?utf-8?B?c1hBcDV6WnY5MDA5RTZwK0t6V0wxQmIrajBNR05NaFcyOGpsTkp4ZVVlbnVh?=
 =?utf-8?B?YXlDa0pjMklOWGpjQlVBQ2R6cy9RMkZiSEZoKzRFOHBvS0pEZXJZcG0rQUNu?=
 =?utf-8?B?dWtsZnBydUtxOWUvckxaUjROLzU3SDB0WTJuSUFCaGIycmpvZEVHVm9XWTA3?=
 =?utf-8?B?MktWdTNKK3l2U0pDeGg0SjRxTTI2M0t2Z2RWQnlEbVlXZFNEdlJoNHFyaXll?=
 =?utf-8?B?S0RJWkMvQXhvb0tKMU14b0JIRXp0NldMb1VrSnErMUFrdWJmNVBzQ3FoU0c2?=
 =?utf-8?B?dXkyU3hsdzlmQUpIMnRIL3N4QzZpelRHODVSWWpialZneTVxR3F5T2F6TCtu?=
 =?utf-8?B?VDJYK0VYdU1VRzdOMjZOVkwvUUlRcnZHdWhTRW1HMWpnQzRON2w3WS93VnlH?=
 =?utf-8?B?OXRUYWh5cjh6eVBoMnRadzFDWWRSQmZvMmFieDlaR1o1UU0vN2RDM2tZWDdI?=
 =?utf-8?B?Rm0zUjZ3dmVnMllWdGdYQzMxcTBod1VwbHJPT3FxenYvVXpqM0FVcFU0TzZI?=
 =?utf-8?B?cFpYVS9yY1hWdldsdHFPeUNtS2tNR1k1VEJnaVN4YnRDZDNIZmExL1NWbFQ2?=
 =?utf-8?B?UVZvcTVDTWczODNwOVRnNzliampneGhpd3Z3WnR3bVc2S2FxNFdjM3dNMmRY?=
 =?utf-8?B?YmxJU2p4b3BCZ0Z5RGQ2YnJuRjBlQk83bU8vU0NhZmNkRG8xZDRXc3YvcGtF?=
 =?utf-8?B?bVE3bGFaM0NFZ0x2eXBzaEtoK3RwT3IxV0liRW5oZkl3T0wvMFd5TFN2bGRY?=
 =?utf-8?B?Qk1GZVRqOGt2MDgwOEc0Y2hsT2NyS2hodTdLVy8zK2g5UzBSOVZ2SWlxY2NK?=
 =?utf-8?B?a2RXZlE4N0VEK0NhRTZhZWRWUUxRQ2xVQ2VkY1FPOTB5ZHlhblBqeTVyT2p6?=
 =?utf-8?B?M0ZqM2lVRllIMWt6ZlJRRTg3WTRqRExPcC9vRHNYM1NEc3BudFBBRXZnSk1s?=
 =?utf-8?B?V0JoV0dhd3lKRlBEWVkvaHNQdG1RMG5yLzlnQUM1d0dnTk5TdFJCSHFxaENh?=
 =?utf-8?B?MzcxVlBteWk2ZjhibVpVZ0lTeEVvbkNYZVlBMFF3T0hHbll6aDJUMXpxR0s2?=
 =?utf-8?B?YTBrdDhaR3Q0eVN2Ulc2NGNoQkNxK2RTRkNrRmNoUXpiRlY2cS9DQlVRcGlJ?=
 =?utf-8?B?L01OVTBSenRUT0NEbFMzSFBUSmhmdkJvaGd4L1FYOVgxeDdDdVZ5Z2hWRDZm?=
 =?utf-8?B?UWZxTTQ5aWFEWEdSUUhoQ1dIODFsMmQ5bXI1RjhuL0ljZE45dXA0MldnRkZy?=
 =?utf-8?B?Z1RuUDlLVnloZ09kOFF4UzBJdURlTUtHVWFwVERCVVV6czBoUzUxckYxT3ZS?=
 =?utf-8?B?OURRRkpWTHJ2emhvYU5qQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNDMFg1RHd5RkNNTWZTc2xMbU41V0R3RkYwL05IcWVHZlVuS05TS085Ukdy?=
 =?utf-8?B?b1pCbkdBVWsxZlo0aWRlUnVlbzhIWkt1WFdCMmZLZEFhaTBiS3ZhNmxaWUlI?=
 =?utf-8?B?Wi9obllYT2JlKzYrRnp3Y1VuMllDS3FvdjFPVVJBT2o1RDNtc0t5TDlxYjJ1?=
 =?utf-8?B?ZG5UYVVOSGhFV1ZsKzVsRWxyODQ2eGN2MjJpeU94cWdCTldJZEkzaXBDMHB2?=
 =?utf-8?B?TFVxNm5uNUNvV2Nua0wyd3RxaXhLQW1DMzZIK3F4RE5Fd2FMZ2FjSkIvc1Zm?=
 =?utf-8?B?OWh6VFJac3JVNGxQeU1BRUJEbktPaXNqRFQ4eTV5OWpRbm9DWndLdFZiSW9v?=
 =?utf-8?B?WXI0STNBRmpIYzg1OFlKd3Rvcy9xcVQ5N2MraTRBNnQ3R09kWEJBcmx6YVR5?=
 =?utf-8?B?ZjVsaytpeHRpOFg5S2Z6TmFEWVVxZVFnTGk3M3FLL09aRWV2Z1BIS09tV1kr?=
 =?utf-8?B?YlM1Sng0RmVjVGEzSWl3bzdxUG5DbVdvTzk3N2lpeTVhNXUxNFl3SlA1TEtk?=
 =?utf-8?B?OHVtMzIzVHZyTk4yTTFlbnZrbFdZTzJCY09VQ0NvM1QyQ0krcDVscExJRjBD?=
 =?utf-8?B?K2NhZUVyNEM2YUN3WjJ5MFFVL3RWTWdKbktqY0pkbERzcFZ3eE1Na2w1Vk82?=
 =?utf-8?B?Y1RaN3FjS3JTNmlnOE92TDIwNTlsTTd3K01ScDRvemZPM2ZnbmV2NzE3U3hO?=
 =?utf-8?B?MS9XRnlBK1B2anJ2VmtIL0s0aEl5QnlVeEtiM1dRRDZPNlhhbjRXUVM5eFo4?=
 =?utf-8?B?SkNQWG55dWkveTBsTzR4eUJ1UDg2S2d2OHFVeWUyTkxhc3VHT1VPSjk2eEFG?=
 =?utf-8?B?UXJtUmd1c0pNUGFVUzVKWnYzdk5YYTBVZXRUQU1hYlVUclMzWWdqa2hadEJq?=
 =?utf-8?B?YjRtTk1BSTMzMnpZeFNlLytGRkpKclZBakRlZzNwNnRFbi93MURwTEN0bUc3?=
 =?utf-8?B?SHVEMmRaQW1qWkxJZHV4MzduYWZMVnJFTzVCczJlWlZVczRyazhxbERuMXRM?=
 =?utf-8?B?K2E1QkZzQmRiZDFnZHI2Nmp1OEFTY1NnaEI5ZGJFTGIwZ0NWK0RtMnNaa2hh?=
 =?utf-8?B?VjI2RXhta3k2SFQ0bElqL1VTNlhHRWJsU2pkby9oQzAzOWhjQWpTU21ISkxq?=
 =?utf-8?B?aEM4R3AxL2xKUGJWZkNEN2I0Y3hUN1J4MUFKUFlNeWpGeWU1UjRhcjhuUjU5?=
 =?utf-8?B?SjdEUld2T0twSjQwL1NyeDhvQlgxYVBycUVEVWU3eFMvamF4S1RrV0laZTN6?=
 =?utf-8?B?WHJBblVkOEEyYUt0VzdBZzR5ZzFSazN1WDNRbE5LV2xEZ3ZqQlE5NC9EeWtW?=
 =?utf-8?B?ejVPMHN3Sm9Td1FDaUZyMVk5UG1HcW1FaUowVVhycEhWbTVXamt6N0szZ1VJ?=
 =?utf-8?B?UVE2Vjl4NG0zeXV1WHc4WXJYTkJ1QXVMVFk4ZWNzV2FzNVBvck1oME1na0dq?=
 =?utf-8?B?SG5WZXFRck1GNjhDM1g3eEowQ1lQd3lqVlg0UDBzL3NwRlY4MGthSjY5UUkx?=
 =?utf-8?B?WEZVVG1RRUJ1c1drUnJ0N1hiOUNEN3BuS3FmR0Jmc2c2WXhuZjBULzNRQ080?=
 =?utf-8?B?d2ZtQ2J6OWk1b3NmRE5lei9CaGdXSXFXQkxwMjRQdnBSUU9sUFhZWSswbHhX?=
 =?utf-8?B?RDdXYVEwRjhialZPeGtTNEJYMkY1VVZtMEowKzlYWHcyazBhVWtMWG9XM0t6?=
 =?utf-8?B?SnBqU2hkRG50cGExVDBFSnF1N1cyYmdTUG5xVlc5NTBXOXZjcjIzbitqTTY3?=
 =?utf-8?B?U3dNcG9WL2JBU2gySzhYaXdoT1dxWHFVR3ZZbUtPQzdjelM5MWFBZVFyczJY?=
 =?utf-8?B?RjJLWi95QVFJdzV5SCsycDBpVnVJbTZRSUlLTWRMSE1CbDNSMXlmMDZmdGNW?=
 =?utf-8?B?dm9OV3pTV1VmNnBTeHhzenhoSmR6WEoxckxud1NNMkw1OCsyUjdZdDdibU91?=
 =?utf-8?B?bllnTDRNdGFNaWQ4dS9ndUtzUUs4Q2xoc1JDYmYva1QvZnlPOFFpaGphT0Ft?=
 =?utf-8?B?bEtSUC9icWdLdGwzc3EzZmVHaWxrd0hNQmFoc21mdC9hamZVWDgyTUJ1VzBL?=
 =?utf-8?B?YnFSazA2MzVaaVorM0hvckEyMG5wZGdPQ3lkYUlaRTM4UlBLN1M2N0xSNlhC?=
 =?utf-8?Q?KFYO+mGGeaURJ9i6d6kIUf0/U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9babb879-c89f-427f-7311-08dcc7719633
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 14:56:24.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQa3zf+c0UuC8dnLkRuFPFq6p2BmEBbQggt9698ujDurFLIfbQbioA6fqMuYt6fQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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



On 2024-08-27 16:38, Harry Wentland wrote:
> 
> 
> On 2024-08-27 15:53, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> DCN IPS interoperates with other system idle power features, such as
>> Zstates.
>>
>> On DCN35, there is a known issue where system Z8 + DCN IPS2 causes a
>> hard hang. We observe this on systems where the SBIOS allows Z8.
>>
>> Though there is a SBIOS fix, there's no guarantee that users will get it
>> any time soon, or even install it. A workaround is needed to prevent
>> this from rearing its head in the wild.
>>
>> [How]
>>
>> For DCN35, check the pmfw version to determine whether the SBIOS has the
>> fix. If not, set IPS1+RCG as the deepest possible state in all cases
>> except for s0ix and display off (DPMS). Otherwise, enable all IPS
>>
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry

Applied, thanks!
- Leo
> 
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a18ecf8607232..a2e4973a4f6e3 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1754,6 +1754,30 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
>>   	return bb;
>>   }
>>   
>> +static enum dmub_ips_disable_type dm_get_default_ips_mode(
>> +	struct amdgpu_device *adev)
>> +{
>> +	/*
>> +	 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
>> +	 * cause a hard hang. A fix exists for newer PMFW.
>> +	 *
>> +	 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
>> +	 * IPS state in all cases, except for s0ix and all displays off (DPMS),
>> +	 * where IPS2 is allowed.
>> +	 *
>> +	 * When checking pmfw version, use the major and minor only.
>> +	 */
>> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 5, 0) &&
>> +	    (adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
>> +		return DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
>> +
>> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
>> +		return DMUB_IPS_ENABLE;
>> +
>> +	/* ASICs older than DCN35 do not have IPSs */
>> +	return DMUB_IPS_DISABLE_ALL;
>> +}
>> +
>>   static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   {
>>   	struct dc_init_data init_data;
>> @@ -1871,7 +1895,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
>>   		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>>   	else
>> -		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>> +		init_data.flags.disable_ips = dm_get_default_ips_mode(adev);
>>   
>>   	init_data.flags.disable_ips_in_vpb = 0;
>>   
> 
