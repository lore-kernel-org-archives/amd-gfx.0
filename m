Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05FEC02199
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AFB10EB3A;
	Fri,  7 Feb 2025 15:10:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z5aUS6uI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872DC10EB3A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 15:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH73fADgw9eBvkRlmVrAWKFn85p5vWaB7z8CjObfq4PEpgIi35/027Il/6Ou5lbSvfrcofeUe+QXUwGlD+VTjLaV+5S16lHEBLoQquphR71br53LqszHYa81zc0tkQ7JHcEBAjj0hGLOxo+YE8XEAaMTwtx+YDjHq4pGrzmonDtcmDXm34IwkLG+9heMrJFsM8xKMw8SgG/WtedvVPISsadY/UAuwAu7ymJSzR2YgXRBl8cOVu/opYKdqsMyCKbE+Rm1HyoB+gpHKIZtTssikV84QLYnZUjtnTBYlWL1zCkesLvwuXzVPDCutT4QJAkYL+Ufu0Jt8cKP5H9T90x9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GPKxC64+Jlcgyt8oG/264oFcZNjczKdS1U5UYeXVSw=;
 b=g7ssdFC+yi2Zwmdk88R1r+DoqefRzmHXEiT8MtHDYyS1wH/SFjbcyxkZcOzAPJoIvBGk0mDyhXq/OKdd1IqtdSshnXC7cjfzX/gztDCSVXVrC3STz5EaiWgVBbJ4bLAiqZFgSiWb25bw/5YoMnGvBg3276dNsEhINR11TO66nBtpeAya8Qeqj0V/+gawYcY/0CNaZs4rV3vG45NXZUG9+XAnOQyi4g5JUqs6RU4g0ISZRICRI//+xAd04lD84WevlyLCf00M3GEd0YtsaMQUPAeAy6qpiJjxIa4Saw84pbqhMSIdfQG0ueG0TCJQOhINBAe4ZfECGJ6CikUvign0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GPKxC64+Jlcgyt8oG/264oFcZNjczKdS1U5UYeXVSw=;
 b=Z5aUS6uIgsIJEnPWyaQ8yAvMrTN2E7n9H18Bh5BseQ2FpJwRCGhZwX8IaCafsmLkUoTzN49GaOMURByGRuZkh+uwqX15mDzbCyIgZ09TJAItcFq4U5/fmq5XaFBetQ+sYbHF196M7fglKG1sq/iX2qc5qvuhicFvdJ4RqiGRCXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 15:10:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 15:10:12 +0000
Message-ID: <eb69b9ab-fc68-4bfc-b8af-d0d2e8cc10d6@amd.com>
Date: Fri, 7 Feb 2025 20:40:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-2-lijo.lazar@amd.com>
 <CY8PR12MB74358ACE4AA9BA563D3219E985F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <19728543-a606-41bc-b4fd-464b7a1d7a94@amd.com>
 <CY8PR12MB7435FC10089643A47B4AD02F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435FC10089643A47B4AD02F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f703aa-3aa8-4e1c-280e-08dd47898494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djhnN2xQLzYvblNQZW0rYWNQcXBINHJYbG1FNy90bE5VWXhkVi90ZDlRU3c3?=
 =?utf-8?B?bUFzakVzZjF6R1FITWhaNERnRmRnNklQSFlMUjBHRldlVU51cjdhWFFtSmt1?=
 =?utf-8?B?a2xKYlYxTWhmYTdXeE0wTnlOWWhOWlhKRXNuakMrM1Nmbk5RcDVBTU44K0JX?=
 =?utf-8?B?Mm9SUUF6a0FvL2x5a1FIcXVQVkRRNkdwQXl2a1JEQkJ2azVNdlpra3MreHg0?=
 =?utf-8?B?N21PWHlBUXMzY1BEUnFZYUlLSVZTTVJxT1g0MWswVWlPYzJrRkdsWUozZ0sv?=
 =?utf-8?B?dHNYend4KzBJbWlhTWtVNVlUdUVzaTdLdEwyL0xiYllaVWVsbmo1TFJKQXQy?=
 =?utf-8?B?Y0t6bW9nRjVwak9DSmkzbW9EbXlONVkwenY5NUMzb2NnQllQNXY4UWM5ZGNO?=
 =?utf-8?B?NW40N2lDNms3VXhicmVzM0pPWHFGV1FMTXQ4a0RpaEVKQmpNRkJ5T1NOYS82?=
 =?utf-8?B?cDc0S3IwQVlPaXMxWmIzOUlYNlZzQnVwQnVhSmlzeVowUHRHS2dUSDRRMVBy?=
 =?utf-8?B?ci80MmZhK0kyQXkzYllWSkJIS3Iya0M4RCtRNXB1UGw3anNpTEFJUGNBMW5s?=
 =?utf-8?B?VXFqU3N5ZktjNXptWm00RFBmb2h0a3ZGK2ppdTNqMGNBYld2WHhrN2FGTVA0?=
 =?utf-8?B?QjN3RDRPOGExRCtqcnp4eVc1REFEZ0RkRXo3bjdRZUY2L2t3ek9nZ3lHSWVY?=
 =?utf-8?B?OVloM2IwL3JhY00weFd0ZmJFYjNNZzlRY0hGd0hrM1NUVUpNdXFJTXF1R3ZN?=
 =?utf-8?B?Q21VNjlCNW96TVJQVWdDaENHRlR6bE1ueS9jRm5WTHV1bS9ZdzY1S2FKUjVi?=
 =?utf-8?B?VXY3amVhRFgxUUc4Z05LMFRJamlaazhKazE4K2E2NVF3a3VtTmt5QjV6cFRH?=
 =?utf-8?B?eEtPdGgvSGVUcWdqeEFhNlBzNUplYXZIOFl5SnZwNjlRL3E5RFVxZjZmRU9h?=
 =?utf-8?B?TjJKVTIycVp4QTkydVdWWjNHM2ZzK2lGTEdZaWhFY0x3Q1lJaFhKQlNKZkRx?=
 =?utf-8?B?NlkzOFhIOGg5eGNnOWFicUpNZHNoemZYcGphNGt6QmVMSTlRUzdUTG1Vb0c4?=
 =?utf-8?B?NkpzbmhHeDl6aGRac3ZhOUQzcm5ZQm10bVdKUlp1RmRVclYvNmkrc0htbkZx?=
 =?utf-8?B?c3ZSSTFUZW1hTyt5d2MxVmdwZElLUmJieVpFaFlSVklzRklpYUdnbTZiMFVG?=
 =?utf-8?B?Y0tUZmxEZDR3eTdpZHUrRzRMSzM1emJTdXJGd0Yvby8rQ2RJU3ZsT3dIbW42?=
 =?utf-8?B?NlprbWlzcEsyM2RZV2NpR3RqZHZBbXI1cGRHZlNHUzI3MUlyMG40U3c0SGg4?=
 =?utf-8?B?TDZBMmVFdEQyWFpsR04yZUhlNzFtWEhQZzBYbWRiSTNhak9LZXJ3bjNPSVU4?=
 =?utf-8?B?M2g2WVFwcnNNdkJUdUlkTnNuWTdHMG1CL1pVQ3hsY09aMzZsUmp2V1NVUXUz?=
 =?utf-8?B?YkNXcjFrM2t4aU9OSzc2Qmhuc2YxeExTa2d1QXhqSThNc1doRk9DTFFpMGo0?=
 =?utf-8?B?MTN3NGVSQkg3QmhjNUlXNlVvVFhyclJuSHpoNGhnaGdNMlZGd0xuSnRZbEY3?=
 =?utf-8?B?Qy9hcTVLejltbjhYa2NlV1ZKUTRNa0pLZDNrNnJ2K0hNYzUrYWJTN3BDK3Za?=
 =?utf-8?B?UFhVWEx4NmQ0RFZ5c1pEdGtoOERoNHBoK2UrV2hxdkVaZitQS2tRUnNhV05q?=
 =?utf-8?B?U3prMXV4OHN0MTZaeFZISEgzMTlFWFVncG5TZlJHbldpaFZ6Vm8rZ2VEQkEw?=
 =?utf-8?B?bVZJbFFpSzNJT2R2K0paY1BRemdjZGtLSm5renoxS3kvL09pdzJmTDNTM2lz?=
 =?utf-8?B?bDBnTERoSUJVbmg4bm5uSDM4UEtUZ1pGZldDdmZyRDJwNW16MmloLzc5dVp1?=
 =?utf-8?Q?mSJqWO7nxFrm8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFUcWtGN3dVMC9UcmhrU3pzK0tpRTNRK01uQjkraytVNUVUcjhjUXJUbVBH?=
 =?utf-8?B?U0FiNXh4Sy9XeitiYVZtRzVnVVZWSCt5Y0tPdTVYbGRyTklRQmxBOWpWZ2xP?=
 =?utf-8?B?M2lDMFd1WlplSU1GbS9ObXRieUNqdU5SaU5EY2xWK0R3VVdlSitjblhKWEFh?=
 =?utf-8?B?V3pxT0dML0k3SElvRGU3Sys1MnNOM0dPZVdPajlkdDZxMDRlN0pUVDRCUkQ4?=
 =?utf-8?B?SFNMc3ZMbmNyN3N6R3RDVnFsd2thcUE1cTFScDdUOGlTQnJweFdzWmQyUGFR?=
 =?utf-8?B?dkVsWHlsWE5ndmI4aFl6bzMwcVFFeE12bjFDSjNTNWtKbGZpL0lPVWVWNkxY?=
 =?utf-8?B?OFdmUUdDakVpL01VeVZoM09kME1hYUdac25NODNHdjlHMVpJY0Y3SGlxRnd1?=
 =?utf-8?B?RkR0eHI2RHhGemNQeTJ4azEvb08vYWt0aTZlYUNwQVpJemxaclZVenUycmVl?=
 =?utf-8?B?VW5RZzE4bnE5SGtvVlpUV2FkdVA1a1ZXRXgwSmx6djh3T0czcFZqcFlyK2kz?=
 =?utf-8?B?Nm1FTlFiWVRUSjM1VG51b1pEdXBaRUlYRzE5VVlKdjVHN25sb1JxRTdYWGds?=
 =?utf-8?B?MHZUbEx6dW1tbmhYWXRZdHRsS09aWjc1UXpwN2FDaEg5eCtsKythcEtXWUdl?=
 =?utf-8?B?eEcrdDQrSnBOVjJCWVFaZ2dGSjE5anlYM1JBM1lPWGNhS2VodFdseGtIbVZX?=
 =?utf-8?B?Y3hTTUFhTkFDSEVGb0k1UVRGeFJGQXAvTGJiVGhkOWI0aGRVSjlpcEpuYjJB?=
 =?utf-8?B?RjV2WWdKOVBNaW0xMjNlUGloNDY5b1JvMlFKclZtZGRNaGh5WEF5YjB1U1hw?=
 =?utf-8?B?OFBRZkRjcDlHL2dNcFVMeDN4cW9rYVBwSDZCQ25FSTN3Y1JaekJwTFpGUVVG?=
 =?utf-8?B?Mm8yMzAxUXhxc3NZUGs5ZnVKN2Z1OS93dFl5UEhaU3h1YmZoZXZ4Uklvckl2?=
 =?utf-8?B?RFJpdUl1bFZwRWVLZmFBUHVKME90aDk4MDEwK3JUd1JUMyttRk1HWVRTdzVT?=
 =?utf-8?B?NWtNNTlMRFU5V20xUTdabVRlcm5wZzlBOFBuL3BVbXlsZkFUVHpuK21TamZk?=
 =?utf-8?B?NldBcUhUa2s0N0k4MU1ReStIMmxXRzFMVG9CSkFGN1NkTWFMUWdFeldIR0t5?=
 =?utf-8?B?anZ3c2tjc1BSN3gvbDdYYXVjT2FCU1oyK0FyVUtyQzh4bGwzYVdQaGpRYyt0?=
 =?utf-8?B?QmtQT2htcjBLVlcwN09wUEhNeUxVTFFkZzVCV2M5QU1lazA2TWtSODdHTUpG?=
 =?utf-8?B?U0NEMHc3dHZNNEZTZVFEamx5R21Pa2ZOd3pHOG8wYytqclNRdjhoYi9Jb0RD?=
 =?utf-8?B?clJlMk5sWnFRS0ZWM3RnRTdtNmhxSkFtb0lSd043U29hbzYzdGdROFBqOXRO?=
 =?utf-8?B?bWY5a2tSOTYyR1FhMXRDU21ZbERobXRJSDRxRkxHUGJpVzc1Q29oSnFmd01v?=
 =?utf-8?B?VGVxdUw5enFyMW9CNStTOTNtZDZBODVvMzJpYyt2RGdDMm8wakNlV1JuYW15?=
 =?utf-8?B?ZzRmeCtNSVpDR0lsSnBGckdheEIycDFhUkIzTzdmRGx4NDQrTjFJTlQ3YXFU?=
 =?utf-8?B?WXFqZDJQNWVYTUs2c2h6UDJtLzVYdzgrRG04bm5ydjZFZkFJbDBFdWYzZFpa?=
 =?utf-8?B?Nk1KeExYYXQ1MHBnblNCY0dXM3VRQTBKMElGcmFMNTduMzdxR1IvV1pqSWow?=
 =?utf-8?B?SDdxTGFPU21xVjNmVXBIWUhSKzhmT1lBWHR4ZnY3MHFmemJPbEh2NVFBemZ3?=
 =?utf-8?B?R25KTkRLb0tVOUVtb0JsaFJvcXNTNStWZkNDMVAzSVcvY3dDL3BqM0VKejVk?=
 =?utf-8?B?dk50WGJOdnJubjNkV0JHUFJnQm5TWTh4eC90LytjTWZ6bDhITzlnbWxqWUhs?=
 =?utf-8?B?OGZGN01UTHovU1VvVmQ1eUtXNnpmbDJlR0ZQMGhkSUpJK3A5ZGZzbnl2clpB?=
 =?utf-8?B?aXJBR1NCbm9Pd2FwMVJMdW5Xcm1ITHhHRWNxVXhUR0dnaWUwTjBWL1VkNU5O?=
 =?utf-8?B?WjJ6RThweUZITEQybzFpL0Q3VnlXS3V5dURiK1VROFFEYXBTSERCb2wxZENU?=
 =?utf-8?B?OFd6SlRMbnRkMEVERXpTSGlKQjhtOW9oS2Znc3RkQlJCbnlwUklleCtKQW55?=
 =?utf-8?Q?wBsN4BkcXyzj/OjFljnsHvZRg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f703aa-3aa8-4e1c-280e-08dd47898494
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:10:12.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8l5p3dx4yHQ0KQkFuByVL3R0iK9VGkr0UH3lgyxMJ8pkMj/T3us6nJlI2+++wWk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
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



On 2/7/2025 7:50 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, February 6, 2025 10:51 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
>> Subject: Re: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
>>
>>
>>
>> On 2/7/2025 4:56 AM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, February 6, 2025 8:13 AM
>>>> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
>>>> <Jonathan.Kim@amd.com>
>>>> Subject: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
>>>>
>>>> Add APIs to initialize XGMI speed, width details and get to max
>>>> bandwidth supported. It is assumed that a device only supports same
>>>> generation of XGMI links with uniform width.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 41
>> ++++++++++++++++++++++++
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 11 +++++++
>>>>  2 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> index 03d909c7b14b..edef5763e2b8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> @@ -1679,3 +1679,44 @@ bool amdgpu_xgmi_same_hive(struct
>> amdgpu_device
>>>> *adev,
>>>>               adev->gmc.xgmi.hive_id &&
>>>>               adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
>>>>  }
>>>> +
>>>> +static inline uint32_t
>>>> +__amdgpu_xgmi_get_max_bandwidth(uint8_t link_width,
>>>> +                             enum amdgpu_xgmi_link_speed max_speed)
>>>> +{
>>>> +     /* Returns unidirectional bandwidth in Mbps */
>>>> +     return max_speed * 1000 * link_width;
>>>
>>> Instead of wrapping this in a new static, would it work to declare a new member
>> adev->gmc.xgmi.max_bandwidth?
>>> Then in amdgpu_xgmi_init_info, you can define max_bandwidth directly after the
>> switch.
>>>
>>
>> Link Width/Link speed is generally the standard way to represent link
>> info. Presently, tools like SMI show these for PCIe. Followed the same
>> here and kept a max bandwidth value calculation.
> 
> GMC xGMI info is for internal driver usage as well.
> I don’t see the point of doing extra calculations or having unnecessary wrappers for a static piece of info.
> If you don't want bandwidth in the GMC xGMI info struct, then for your 4th patch (drm/amdgpu: Use xgmi APIs to get bandwidth), just reference speed and link in the caller and do the calculation directly there.
> Going down a wrapper rabbit hole seems like it will make things harder to maintain in the future.
> 
This is again a seggregation problem. It is about keeping xgmi related
information including xgmi bandwidth calculation method in amdgpu_xgmi
files. This is also the reason for moving amdgpu_xgmi struct definitions
from gmc file to xgmi header in the first patch.

In future, this could be called at more places, or xgmi inturn could
obtain through a FW provided method. Keeping at xgmi file may be easier
so that clients always call the same interface.

Thanks,
Lijo

> Jon
> 
>>
>>>> +}
>>>> +
>>>> +/**
>>>> + * amdgpu_xgmi_get_max_bandwidth - Get max possible bandwidth of a single
>>>> XGMI
>>>> + * link of the device in Mbps
>>>> + * @adev: Target device.
>>>> + *
>>>> + * Gets the max possible bandwidth of a single XGMI link of the device in Mbps.
>>>> + * Assumption is all links of the device have the same width and are of the
>>>> + * same XGMI generation.
>>>> + */
>>>> +uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev)
>>>> +{
>>>> +     if (!adev->gmc.xgmi.supported)
>>>> +             return 0;
>>>> +
>>>> +     return __amdgpu_xgmi_get_max_bandwidth(adev->gmc.xgmi.max_width,
>>>> adev->gmc.xgmi.max_speed);
>>>
>>> If you do the suggested above, both tests can be simplified into 1 line as
>>> -> return = xgmi_supported ? max_bandwidth : 0;
>>>
>>
>> Yes, primarily width/speed is chosen to represent link info.
>>
>>>> +}
>>>> +
>>>> +void amdgpu_xgmi_init_info(struct amdgpu_device *adev)
>>>> +{
>>>> +     switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
>>>> +     case IP_VERSION(6, 1, 0):
>>>> +             adev->gmc.xgmi.max_speed = XGMI2_5_SPEED_GT;
>>>> +             adev->gmc.xgmi.max_width = 16;
>>>> +             break;
>>>> +     case IP_VERSION(6, 4, 0):
>>>> +             adev->gmc.xgmi.max_speed = XGMI3_SPEED_GT;
>>>> +             adev->gmc.xgmi.max_width = 16;
>>>> +             break;
>>>> +     default:
>>>> +             break;
>>>> +     }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>>> index 044c4f6be44a..384c4ddef78a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>>> @@ -25,6 +25,12 @@
>>>>  #include <drm/task_barrier.h>
>>>>  #include "amdgpu_ras.h"
>>>>
>>>> +enum amdgpu_xgmi_link_speed {
>>>> +     XGMI2_SPEED_GT = 16,
>>>> +     XGMI2_5_SPEED_GT = 25,
>>>> +     XGMI3_SPEED_GT = 32
>>>
>>> Why not declare and define them as units of Mbps to begin with so you don't have
>> to do the calculation later?
>>
>> Actually, this is also something which is followed from PCIe to
>> represent as GT/s. If bandwidth field alone is kept, then this also
>> won't be required.
>>
>> I'm not so sure if that is a good way to keep things.
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Jon
>>>
>>>> +};
>>>> +
>>>>  struct amdgpu_hive_info {
>>>>       struct kobject kobj;
>>>>       uint64_t hive_id;
>>>> @@ -75,6 +81,8 @@ struct amdgpu_xgmi {
>>>>       struct ras_common_if *ras_if;
>>>>       bool connected_to_cpu;
>>>>       struct amdgpu_xgmi_ras *ras;
>>>> +     enum amdgpu_xgmi_link_speed max_speed;
>>>> +     uint8_t max_width;
>>>>  };
>>>>
>>>>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
>>>> @@ -102,4 +110,7 @@ int amdgpu_xgmi_request_nps_change(struct
>>>> amdgpu_device *adev,
>>>>  int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
>>>>                               int global_link_num);
>>>>
>>>> +void amdgpu_xgmi_init_info(struct amdgpu_device *adev);
>>>> +uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
>>>> +
>>>>  #endif
>>>> --
>>>> 2.25.1
>>>
> 

