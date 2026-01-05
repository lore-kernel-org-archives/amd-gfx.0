Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563A9C2A062
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 06:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7A110E14D;
	Mon,  5 Jan 2026 06:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ikBjeP3Q";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA4710E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 06:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8kNhjnxm7QIVV0xwtzsja35W9gyXsbRIF+hGtrmV1T1BcLZgbeV4YlqtTbrrfBPgNnzu2sdFC/hFo8YHRTxyVwF6mKko7e7PFqE0VtouOqUVEslbtZ+zPJrAhofsyUH7haoCm/3hl57LPxFy2/N+DMCgi2NhN0+f4mAdguE/TfXVyuexfiXI4pIYvm5U3Npi4A33qYAlEtcSXyVmiAZohBGqNuayd+lkERT8dCYh2ep/WLyOvxqvBAbx1I8TDaoiYnXyC9Erby34eBXoHsY2NHtjXRmgBuHaUY9jvU5r5/vlhCmRP2nevYGyO4WlAQC/D/oDrYYyU3Foz2T5cEUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm6lwmH7cz87PtE43ucYo9VJWulz3KR2ZVCRtSSYTHU=;
 b=QhRQot1uj+OIfY1CWA53vIuGe9/vrYISONyE56Yq2Nc1/BXztxN9TdxEWagpxRbBxK91K6QZKCk8x5OKCj/rfyxOoeaL6u26u3WvjUeC6tEWk3CLnweailZ4yKoIQu33wUwlXg8/iVYZ0xV7sHOeghKi7on7tXvAyDilwWzlAUuql3WpjTa4Z4eWXunEF9oBvMcn87im07tMWsLNtxL0QA3MXZZM2+bf5uzOAOof11UEMQtoTu+EJGG/LJZ59jolgFj3/tEgBHsECiLCkJ9VdQ9ynmEZ56J8pYX8QI9HQNo4wZWHZXM14lvT5lH31P0I+FD8ZLjtgJkcudufHfL54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm6lwmH7cz87PtE43ucYo9VJWulz3KR2ZVCRtSSYTHU=;
 b=ikBjeP3QPLMpH/JZDF9bWw3coAQUptlUj7LK82lqbpkk5vhKrfzychKFwpvYucCDe3gpvvd2pS5hXnvuQ5BV88VTVUOpS/evAQAd/NceMqiDMk7AwOzedbahCss9kWGupat1n2RppnpX2Yilu9Smarmz2W6ba316FhTRPTZs/2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 06:11:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 06:11:04 +0000
Message-ID: <7f94385d-fde4-400f-839c-3b982caf8f14@amd.com>
Date: Mon, 5 Jan 2026 11:40:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/10] drm/amdgpu: Add ioctl to get cwsr details
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-9-lijo.lazar@amd.com>
 <CADnq5_O5YeGEr5ryrk4eQNJv68aW+B_RpdfVr4C0+g6mWS0dig@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_O5YeGEr5ryrk4eQNJv68aW+B_RpdfVr4C0+g6mWS0dig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd3d661-fc52-48a0-bb4b-08de4c213567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2NIWWw3UDNPN0VxZEl4aHNoRDZjNTY4TWw4RnNDUGxjS2pIQlk5U0Z6NU9R?=
 =?utf-8?B?U0dmaG00eWxlbE44bGx2ZWE5WE1iS1dheGVVZHBZUkk3amxCNUtlcGttRTVs?=
 =?utf-8?B?TU5uL1JFdkNKejlNM0xPOUpteXB5QmY2bFJ3TThvTTNWcTY0L0cvVE1GS0pJ?=
 =?utf-8?B?b2c0cmdmT0J3YmdjRHBLVWlPVFNPamdETXJCOXQvMy81QzNzQlc4ZDBJTDFY?=
 =?utf-8?B?bTZWWHhCY3BkaU9IREx2MkZrdUNRSUQ2VHFua1JJbzhmSHVBV1BBRmFoZERr?=
 =?utf-8?B?Y25jcHBZd2VXTHZkTnY1UmFBaTFHWFJxTmsxYkVhdVFaN21GV3RjMFVDWnFB?=
 =?utf-8?B?a1poMUMxTGRzb2lTblM1MURXektxeXVjQU1YUHNMYisvK1ozcmRHdi9zSUtl?=
 =?utf-8?B?Q01FTnpIckFWTkx4SkpMNUJUZUhVTkZldWtZY2FYMGFlcWd5amlOZUZTUFFS?=
 =?utf-8?B?bjAyaHpLSmhRT2RFakJGTEkybkpiNHAxb0tpTTVqeE9mRlpBUEdJb0xoZE5J?=
 =?utf-8?B?ZXhuL3hZMDlSdEVTV0pwQk52bUtURVRyK29zTFByNnV3MDNnRkFyRi9vOGZn?=
 =?utf-8?B?ZFRXZ3kwM3ZiYkZrVkhaYnFlaFFYY1MxS1pEQS84MFprZTRhcTh4NDhWZkxv?=
 =?utf-8?B?TEY3RHVsSFdLaDlPRzhuRGtrMXgwcTJtQmdXeHB6V2pUcng1NG5qUkNaa0dr?=
 =?utf-8?B?eUlNTUc0STlTTDlzUThZZmJna3JSTUVhUHNjcWtFeEdBOUFuOWlPUWRnWmpC?=
 =?utf-8?B?eWlIZ0hWWktKM1I3alF6MEwyc1VJVXdLWXZXc0pSb3FTVFo1N3pyTkNUYlpN?=
 =?utf-8?B?M281ZUJwK3VXZWdobGYrcFBzME5GUkIxUWhnbFNETTA4UDBMRUN0cDR0S0x1?=
 =?utf-8?B?dzBmWWZGK3R3c0dCenlXN0p6UWU2cEk4aWtYNmxuaEhpWXFtMWRsaHdCM0tj?=
 =?utf-8?B?QjlTaTRUQXpsc1FhYlF1a3dkMWlUdWhYcTF5S3NlRm5hWEpaTU1YOWFmU0tQ?=
 =?utf-8?B?VkVRdUp0S0dYTXJPT1Q2aGZpa1h0WWZ3Qms5engxRmpvNUM3cG42S20wc3d6?=
 =?utf-8?B?bFk3ZVNzeEJudWxraHlyR2tPTDV3WUFrOEdwMXFwNXlYMkxEaDdhOFR4V2R2?=
 =?utf-8?B?T0lKWDN4US9QMnBRdjhPbExwUTV6ZjQ2bmlFZmFXc2w3UzlJVk82b1lEV3ZH?=
 =?utf-8?B?T3pWcFBBSXpXMGVpN2gySGhRalhFbW5uSTVpcUw1RllNTjZzNDNYVTZtVkxS?=
 =?utf-8?B?SDBxc2h1bFZ2ZHlKWnExd1owcFpSRTVjVUJwSWw3cjdWUkpPeGdCU3lnTkFL?=
 =?utf-8?B?ankrY0RqL3JSMVV1ZnZUZGNQclNhb1Fpc2IxQmhZZ2pFazcwSG9VWS9sUEZ4?=
 =?utf-8?B?REw0NzA1cjZtdFdTUWRBMVJGb3JxMVZ4MEkrTmMvSmdjZU04VFNwZ3k0dW1l?=
 =?utf-8?B?ZVdmb21SZmhwRGVaM1ZwakNjRXhOakplM0gza1FhVUVyL2lTc1F0WURnQk5Y?=
 =?utf-8?B?NkVNMXFKdXQycUdwcWhvOW12ZENNRXhydmhrcjNtVmVDa09Kd0pKdHVlK0Zy?=
 =?utf-8?B?NzhtTm5uVlJrU1psSXA5bVdpb1loUFRzRTZneDJFZlpjelJGWVZmUEMyRURz?=
 =?utf-8?B?TWFxbEhEamxuNEZOVzdBdERwajZpVUJTdTFuRFRjZkxtMWdUdkZtYytoOHV1?=
 =?utf-8?B?K25KV3BTeXZ1U2lSUHArOFF0eGJxY3B0RUZaODlSOVlYaXplZ05EQ2doNUNj?=
 =?utf-8?B?SDJhZFZ2TUowRW5jZHRKTThNU3A3dmhlaGh3VzFXeG0vZTR0ZkY4Umk3anBK?=
 =?utf-8?B?MllRcEZJSCs1OEx3d3R1c0FFUEx4N1JQL3kvV2J6dGJYakR5RGxURjJhaEE2?=
 =?utf-8?B?SVhGSGtMSmxtYkRMWXp4QTVzYXlyNXRzVTh0OHN3UFFPMzgvYVFNTnF6Mi82?=
 =?utf-8?B?V3hpZHlWTUUvKzU3NXlFNitFekI2UlRTdHRvb0RiODRUNUE4d0cvKzErTVJ2?=
 =?utf-8?B?Y0ZldFl3S3Z3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJRZEJscytEMXkxVjZ3dXVvMllORS9idnNNMUxLdFo1dDh4SjhQMSt3cU5M?=
 =?utf-8?B?NFRRUVMva0RxL0xUZEJpcUlXSmg4eE9ZTGlpUE5HSFJEUlM3N0g0NnYxZXBs?=
 =?utf-8?B?MmFQQzBMc2t1YW5TVHZPOS9aUVFIV3AvSkc0NTk1YnJNUjhVc2tjaE8yMlR1?=
 =?utf-8?B?OXk5ODI4NVJuV2RxV0dIejVvZXBoRGt4cVk1OUpzODM3SVlDb25qaUxURGoy?=
 =?utf-8?B?cjNENGtWMWxyZnpRSmZ4U2tPQUFZNG1kOE5zekVaZHFkVXppeHZTdGs1VWVO?=
 =?utf-8?B?eU51R05VVkNNcWdhQ0NLR0hWOTJUMjYxbFdWMGZXSlhtdXJMU2V3RlpXSGhp?=
 =?utf-8?B?Y2tibTZ1cy9jMlBGTytweDVQa0s5RDBncTYxLzl2ZFljVTZ6VXA2WUVNZFc1?=
 =?utf-8?B?TW5RUk1pUkZrYlhhNU9XY3g1QlUvTG5qYkFNR1dSUzhkbmNNNFhGa2tNYVAv?=
 =?utf-8?B?VW0yVEE0MWpjdkF6azBZUW1VVkZaVW5LaTVMWSt5WG5KSkQ2OHZsenpHckdv?=
 =?utf-8?B?Nzc1T1FCbHBKK1MvM0FHRUFlME1JZUZITVFKM09JMG45bmtPWFNaNEI1VHdB?=
 =?utf-8?B?WnFpM2pTYk8rY09lZHhyRzhJd0JQVjYxcm5QUGowanlLdG1GeFhTd0NoU3h2?=
 =?utf-8?B?V1NDT2VxZDkvNE5OVlJTUGpFcEU2STlCbVA5cG8wQS81b1c1SEtIVU1Ga0o3?=
 =?utf-8?B?RDRLazZ0Nm1XWk1jOUdDYkJaMWJZczBtalU5cVFiUUt5VU5kSGxrVkZWeEtP?=
 =?utf-8?B?MCtvWHk4UkExaUcrMTEyQTc5aXpreExJNHVMclZHSGpxekJtRGNMeUtpVmVi?=
 =?utf-8?B?ZkM5b3pTdWU0MDB1bzVwNGNRK1JjYlE4SmJQT1lJZ3BXZklCZ2xxUGVMWmNy?=
 =?utf-8?B?OWRZOHlSUHgzSmhNVFdTbjlIeS9CNFhNMkJ6OXY0Z3QydS9TMkExNlZMWlQ0?=
 =?utf-8?B?WHdlN1p4cmhrSDQwVklTOEVxeGdLN2VIeWw3VnRyWStVV0NnTTlKSkd4VDJO?=
 =?utf-8?B?QVFGUXFnakM3NDZCSTBtaXNnblFLR1JEWDg3RFJWc3I4Y2VUOGIxWGoxQmNY?=
 =?utf-8?B?aFRod0lOYkhiZHQrWURORU9tYWpUa2t0NzUzSWF3TXBZcUlwSitDcElHbk9I?=
 =?utf-8?B?YWIzN1FnNnRrVzgzWVFYcFNnbUNJR01MN0QzdFhjZldIQ2hlTDBmZUhOL2ZP?=
 =?utf-8?B?NlNSVFBrZFkrMDhpZmcwWUxxdldSSmIzVHQ5ejdGY2RpZHAxWlB3YWJCR25E?=
 =?utf-8?B?TkVMbyswMGlLV01QcDhHQkNBUzdycjY2c0RwMFBaMmVoK2NPUU9NdW9SVTZD?=
 =?utf-8?B?L0VQcWhaTW5GMDludnNUUzdPZ2QrcTJaTlBDTXVORW0yUFoxRDFTY0N2UXRj?=
 =?utf-8?B?YnNHcTBWaTNKTWp4amt3d2VmNXhvdWRxUWlML0VEaXUzOU96ZTZIVEJpMzh2?=
 =?utf-8?B?cXJUdVBJUDNrTlJEQUZsU3I5MmtBRGpLT0dzV0dLMFNXVDZVVG1XenQ1ODJU?=
 =?utf-8?B?SzBJMndNZTJGK3pnRnZFcDF6Rk1pSDhFc3hLV1B5WG9XcUpNNXUxN1k4TUl6?=
 =?utf-8?B?L2FROVQ0U0dDMUhPb0FZTCtScy9Jd0d2M3psRUh5UDZ0eWh3M0Jvd05CdHNn?=
 =?utf-8?B?czAzVU0ycXYxcW5FSzBnUnZEV1VPaURQZFVLbmhVamxkbzdpZG1NTjdteThY?=
 =?utf-8?B?ejJlR3JaZ3pkeURsQW9hRGFuYWxzcExqdDhmUjA0ZS9LdkN5RzgvKzNCdXov?=
 =?utf-8?B?dFcyQy90ZHpQNU93ZzcvbW5LeUp3VUJJNk03OGxSbTcrNXVpY25CTFd4SVM2?=
 =?utf-8?B?NVNQTmdQZ3dEODlQTWpjNEJLbUR4LzFiMXh3VTYxMVRCNUhPYnFTdm1lRUI4?=
 =?utf-8?B?dFhVcGZFOXBBTS9xYWQ5SitYTFJ1bUVwcXczaW11bE52bkxueFQxKzNMQzVH?=
 =?utf-8?B?MGlIcjZoOEpSRG54Sm4rYzQyYlRyUXRJNU5WZ3RZY01WR2p0Qm9ZNW1NWFdi?=
 =?utf-8?B?Rm5pUjJJSFl0UE9CcHpQeEptTXFNc1o3NzlRblNHU2pPZDhBQWZrZDFIeCtw?=
 =?utf-8?B?aFpXN0I1emRCOGdiRjhYMDhLVm9JN1lXcjhYaXFneGRrOHpITk1heTZac253?=
 =?utf-8?B?Vjdva09oYUsraVF2WnQ4Ni9hcXZsTytyU0FmMjVyNnJxQlN6UkxNRzl1alBQ?=
 =?utf-8?B?djNTczAyRHhjbVVBOUczUWkzV1NVbDBnODhpZEtLRGJIQ2FKT1dSN3ZXazNV?=
 =?utf-8?B?NnVMbnJER2xBUXVjWTNKd1ArMWg0QkVtMmRpcWNtdFNaY3Irei9ZKzAzaE1w?=
 =?utf-8?Q?3869lBF3yRvPFizUUQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd3d661-fc52-48a0-bb4b-08de4c213567
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 06:11:04.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVK3rdZwMLhIKNOTJFQm7uBTGFO14rGuKFIBIc/1JGDqdsFojXXExjFGAosxVHFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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



On 16-Dec-25 10:25 PM, Alex Deucher wrote:
> On Wed, Dec 3, 2025 at 8:05 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> Add an ioctl to return size information required for CWSR regions.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
>>   include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 398d6c8d343c..848405c37bd5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1368,6 +1368,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>                          return -EINVAL;
>>                  }
>>          }
>> +       case AMDGPU_INFO_CWSR: {
>> +               struct drm_amdgpu_info_cwsr cwsr_info;
>> +               int num_xcc, r;
>> +
>> +               fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>> +               if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
>> +                       return -EOPNOTSUPP;
>> +               num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>> +               cwsr_info.ctl_stack_size =
>> +                       adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
>> +               cwsr_info.dbg_mem_size =
>> +                       adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
>> +               cwsr_info.min_save_area_size =
>> +                       adev->cwsr_info->xcc_cwsr_sz * num_xcc;
>> +               r = copy_to_user(out, &cwsr_info,
>> +                                min((size_t)size, sizeof(cwsr_info))) ?
>> +                           -EFAULT :
>> +                           0;
>> +               return r;
>> +       }
>> +
>>          default:
>>                  DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>>                  return -EINVAL;
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index c1336ed4ff75..2bb9daafb560 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -1273,6 +1273,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>   #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>>   /* query FW object size and alignment */
>>   #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
>> +/* query CWSR size and alignment */
>> +#define AMDGPU_INFO_CWSR                       0x25
>>
>>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
>> @@ -1636,6 +1638,20 @@ struct drm_amdgpu_info_uq_metadata {
>>          };
>>   };
>>
>> +/**
>> + * struct drm_amdgpu_info_cwsr - cwsr information
>> + *
>> + * Gives cwsr related size details. User needs to allocate buffer based on this.
>> + */
>> +struct drm_amdgpu_info_cwsr {
>> +       /* Control stack size */
>> +       __u32 ctl_stack_size;
>> +       /* Debug memory area size */
>> +       __u32 dbg_mem_size;
> 
> How should this be used by the application?  Should it be folded into
> the save area or ctl stack, or is it just for future use?
> 

This needs to be accounted into the minimum save area size that should 
be allocated by application.

amdgpu_cwsr_size_needed() =
		return num_xcc *
	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);

xcc_cwsr_size = control stack size + workgroup context size.

This interface provides information about the individual size requirements.

Presently, all of these are also calculated by rocr separately -

https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/libhsakmt/src/queues.c#L342

Ideally, we prefer rocr to get this information from driver.

Thanks,
Lijo

>> +       /* Minimu save area size required */
> 
> Minimum
> 
> Alex
> 
> 
>> +       __u32 min_save_area_size;
>> +};
>> +
>>   /*
>>    * Supported GPU families
>>    */
>> --
>> 2.49.0
>>

