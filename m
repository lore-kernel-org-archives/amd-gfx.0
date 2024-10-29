Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48ECD2AB3C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 13:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032D510E658;
	Tue, 29 Oct 2024 13:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kSGGW9Mb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7CA10E65B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 13:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngggQoKv3dNPvOCJ2N0+GD59Vrp7YgvPlotg/++82IyqggwwVIJiqLgGulSE9bZuvQX3xwpGqdERO/99snBiWUJSG4YPfm8UsQDb4rB7U3tppvagYz/TVy2XF03fY6wnLOJfzVqhVtMjjc8LaUD16zP/4YFQo+MKlVyKVMMOikxXCvLLGxbcWeZ44aqEjOAD4Locptups5WPPyCS3rdkDI7FpgBkxCy265hLCzELWU/4tMqPmXku6RX3y1P4Vql+kiRDLmvhw6B2//pV7bhtCfSCX8wyUkH0ZwquQV5nCW7fmceFGx8U0O1emJulgKPEzU7gA3v/jSC85sCyQxCxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha9tYozbO6RWGLYKyNGl/ikKXitEhzFElC+BlJ6BMU0=;
 b=Jv7r5LWqd6nzF2JgBaDibKNtgmxPphT8PZcYUXU/FXV4O8ozL4RiAMwg5r9GosgE25wEhdqaNrm3cBfTa5hIY2zf8RbK3bIxYqDIQ8bEmG25dd1umsoZJa9cc/4aU9MUKMWmu+nVgfuaLOTvzb/cVmP5aKSDHQ0HiMCX6JKJHTP7M1IpMAw4l+lqvgOnMZBnoC/Rn1CZ6Z6TNTVySwjpW11nUsjLfYK+I9axRaUdDNZ/FqMNF/imM/XvnaVaiZ0Kp8bStv4G1usLl1/l4jqZk5ku5LlK7puTci3lyzT/yaOUB85n8QG2qh55VdM0Sh2SVUtsUjthreZ7NfmxWhkfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha9tYozbO6RWGLYKyNGl/ikKXitEhzFElC+BlJ6BMU0=;
 b=kSGGW9MbkU5cn2/duvz8Ynv06Y7aQSZ3xkOL0ogjuEi/TnFfwnn0wtLQeoiK/3FQ84QGeRaiAj20ouZ+gkhIfD11S+TIXrPnlbJlL3VZQh96/hyJwa/nR8tYW87OuYBrcIuf0iPjhJpskdk6QNGLs47LJcWCHa433nH85hQFvhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.28; Tue, 29 Oct 2024 13:37:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 13:37:02 +0000
Message-ID: <0e0c4fa5-2b12-468a-b960-d5b63c2e76ab@amd.com>
Date: Tue, 29 Oct 2024 19:06:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Group gfx sysfs functions
To: Alex Deucher <alexdeucher@gmail.com>,
 SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20241029052700.3164571-1-lijo.lazar@amd.com>
 <93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com>
 <c401ea1c-0b2f-4591-abe9-6a911c55b3a0@amd.com>
 <CADnq5_NhWmJh-4uePmx3biZSAQT26nM_oyQoYzOrm2FQTMnikw@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_NhWmJh-4uePmx3biZSAQT26nM_oyQoYzOrm2FQTMnikw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: dd81a7d8-43a0-4bc2-0eec-08dcf81ec4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDlnNnFkOHBnRWY3NHNVWWQ4eUM4enlFZlRONXVjOXB6MzUrQjFEQStMd3JV?=
 =?utf-8?B?NG1nZ0EvaXNHVWk5L1hDOXBOTllvR2F6VXhZRDZiRFY2ZzR3U2cvVi8wZVNv?=
 =?utf-8?B?RElQRkJ3OElQN016SEdOMUp5UUorbEVldWZTc3RwN0I4ditkQXRITjNEWExh?=
 =?utf-8?B?UnVqU2J5TG1vZlIyTmpXMWNBSURBeW5BdjdXNU9Hdkc5YlRKRTRzenpRcVBF?=
 =?utf-8?B?WHZTZkhrN3RiZjIwZlA5Z1B3dnppUUlZOXZBYmlIbWJzdDhXZ2xDS3BnQ09z?=
 =?utf-8?B?ekJxcDVqRFAzRm5FeU5yT2FTUmE2YWNQa2luM1RKT0Zzb0MyZWF3TEJ5SmlO?=
 =?utf-8?B?RmM0ZEp5Nlp4Zll0N2lQZ1BEajNGUGFwb0FoNWFhSUR4ZHVNT0hValZoU2NZ?=
 =?utf-8?B?UkkrUGZvS3Z6VmNBaFc3cHdEcUhmWFRQMnEvWXR0bUVteEEvOEJSekk5MGda?=
 =?utf-8?B?KzFkTC9sUG9oeStJSW5VNmxPUkRubVU3R0N0TWlkekd3WGdrZ2NFYS9xK2Yr?=
 =?utf-8?B?MWxzUSt6bjJQeFkxRGhid3cxMWptNWJ4Wm9VR0lhN2pSV25zMXZMNXFLbkJ4?=
 =?utf-8?B?aXBWQ0ZaUGh0RTVpN0svNDVKTUpKcnhELysvaDc4Z0pXV0FzNzIvR3R1Ynd4?=
 =?utf-8?B?VDRRL1VPRGpBV1gzY1M0SVRpUkZnTHhCeEc0NEJ6TmtTbC9ha05FNVhXaXoz?=
 =?utf-8?B?NjlKaStTV1RDYi9JRzNzZFk0N3FrMG1JL3BrRXlPMi95MnZtcjBpWUNiMSta?=
 =?utf-8?B?Ui9MZWw4V2VRMm1MVU1FdFk3VWYraUxVdkZ4QVFON3RNR3ZCeW04NlJkQnZ3?=
 =?utf-8?B?K0VycEEwRnRmNnptNTNtZTRHQmU1dWlTNlRtNUpKcUw4bmZzb3FVdTlqWFox?=
 =?utf-8?B?TWxZRy9JeFN0VkQ5TU42UDRJTmdDUmI2algwVFIvL3N5STl6MHhUYUQ1aWpC?=
 =?utf-8?B?UkxQNWFzblRCa0dtcnpXa3dyRXV6UDkxWTkrRGJIR081WXhjV3hIWUtaM0dX?=
 =?utf-8?B?MDR3cU1tRzZPMGpSd1RKZFJFRjE4YVNKM0V3SkllblR6S2NoSzR2OFZYdXlq?=
 =?utf-8?B?K1FxVGE5aGJ5WmFTQ2Y3bjBCNjcvc2pYM01YQ21NdVZmdlFUeU53RjhFMm1r?=
 =?utf-8?B?Rm5WNkdmbFN4WlhDRUkzS2xPTHI2WFBHVVUwcmhTbzhtQTFHcUI0eGo5RnQ3?=
 =?utf-8?B?UU02Y3AveDdRcTNnckJmdUExT1JBMm9pMmN2N3J2VmZIV1ZLeWkrb2dGc0dF?=
 =?utf-8?B?LzhVdm9yM2ZQZWlmQnRNWkdNOWp1bFBITmxXSEJLeklQVFBFMVNLZ3M3WHIv?=
 =?utf-8?B?WFRqa0U3UzM0TTR1MUZnT1BhTGRFVGw5NEJWdTJuZ0xCeEZ2WjdIOEtxZlpZ?=
 =?utf-8?B?VFBKMjRqa3psWUhUZHVDS0t3NGhKdVE1dExoWUE2dHd2K0k1M3R0UE0vcVpw?=
 =?utf-8?B?WXhNcWpLWGxhTHdReHpRem9LRW5OY3RhV0lKeFE2eHRsTHpxWmJ4ZDdZOFM5?=
 =?utf-8?B?blpIbzYyRG0zVmd2eVVqMTN3cTlDYmJBcGRRWHM0aUJEV0NKQjNxbzZBMDFh?=
 =?utf-8?B?L0ZjenEwZ3NKSHpXUW9ESnVpKzdNTEduc0t2U0dCUXI1SGNPUVdNNTdmVmZO?=
 =?utf-8?B?cUNkRUpTRzl3OWlHQmdnUUlpT1Y4SkpVL1Q1ZElmUjdneE5lbXVEejlXcUky?=
 =?utf-8?Q?cdPkbJIDGUYQKg6HfLjg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxMcW12a0dzM3hhUTVNSTNqcm5pelhPRGcrdXZPczR3bVRseHdITm4vK2RZ?=
 =?utf-8?B?VFdoeHFOQythU2ErUFZDcnhWMkM3djR0bVllSStRaGo0UUtJQms5QTdoci9U?=
 =?utf-8?B?dkE1RExwdDA5QWxsaXJQMkplb2IzWVVUeGZ4aFpyMkFEZ0RPTzZRWklLTUxJ?=
 =?utf-8?B?MFB6Q1pMTjJLcEhITDFZRlZxRHVnK284TE1zQ3p4Y3JWM0Z4UCtGWk5rOGYx?=
 =?utf-8?B?WHl0R0JEWkt2cWhxRGIyUEY0Q2RwdjlGUE9Gc2hyU3hLbFZhQWJ5Nm9kaDNK?=
 =?utf-8?B?dUprOGNxVDRTQkdSVmZ4TllwWnBPZ25aMHd3T2p6MXVOdEtUdEtJdjNBMWNi?=
 =?utf-8?B?YWRqQWFqVS9NYU0zNyt2OUpBR3NwcnZlK1k1NWZmdHJTeXFHSzUwYnpodjhp?=
 =?utf-8?B?REpBVWMvN0sybFprR0RZMlBtTlpsM2RHS0N1UkYzU2pmdzFyaXFibzVDZytC?=
 =?utf-8?B?Ty9UQk10ODBreGNaUkYrUXB2bXU0enltd0d5UmZ3RWQ4YUttZkZScXJhM25K?=
 =?utf-8?B?TVJpOVFFclRLWFpWcXh0SlB5QVBka3BMY1ZPK2J1ZWR0NnMzYzZzQnlaMkVC?=
 =?utf-8?B?QXFtUy9yRE5hMk9kNmIva1FoUTNPLy95UG9HTXh4aEE3c1RBUDJUYkM2L2VY?=
 =?utf-8?B?M0N2aEZFa3lUYmJXSjVrbzR3WE1MQUdZVTJyUXBGOVhwcm1URGJSMmFUOXJk?=
 =?utf-8?B?QnZHVjBaMlJOUHNMekxXajdmazhRc0l0dFk4NHRMOWVkZmwzaWNwZ01OcXRy?=
 =?utf-8?B?anArV1JEL0ZHN3pmR1kxV0FXV1VYbzRxbmc5enhicWQzN2VFYUZOYXFMbURS?=
 =?utf-8?B?ZEJ1M2FIUTVPMW1SWWxXTS83Q2ZaTm1aL1lsUEJPU3dLWTNVRjk2bDZrbzZV?=
 =?utf-8?B?VU9NWE1qRlo1d3MvcU0xTERaUG1rdWVwTmNPU3pWQjRncFIxQzEzMzBqNGJW?=
 =?utf-8?B?bjYxdUlid1VBeW1BWTdYQmFvb25QdDluOUxmUitCU25FQUJEWFJvRVlIcmQy?=
 =?utf-8?B?YXBIQUlNNktMYTRoSFJWZk52SXFzZ3dXV2srTjR2M005ZGp1VG1VNFFzUXJa?=
 =?utf-8?B?QzZkSDlTMmx2d2hFNE5ROEQwdWtldVR6OFNUV2hwNnBpOWcwVUpUa2hPaXVz?=
 =?utf-8?B?Tm1UU1RYKzM3eU9NejlURFVRdG9RaHNqUi84NmRoRFNGRThZeno3VnkwTXBk?=
 =?utf-8?B?ajgxOVFuUmFvSmRXeUxiRm9QL3FYS2k4aTVHQzdBTWIxc2Nxd1hQb2tEcWtB?=
 =?utf-8?B?TXAzVFRrVVhpMTJXdlBKK2tNZUR0V2tJUUQ1bW8yZUVnbmpuSnJBeHM5ZUwr?=
 =?utf-8?B?YVltMHAxYml4cXc1c1BwelVpYWpnSC9uUHlUUEdrLzNPdkhTSWxaN090NkdT?=
 =?utf-8?B?TklZeEVoaFFEUDNKTnN3U3d5dkg2ZmJ2R2dHRUZiMnBVT3hNZytVOFBpWWMx?=
 =?utf-8?B?dWZHalMvK1Y4djI2dHd1bjRnaUpmbUtFZjV5RzEvUHp4OHVRNFJGYUFPUUhl?=
 =?utf-8?B?NW1tR0VVYTQvTDZtK2dvczFNeUdqR2Y4ZE01YTZaRmJERit2dU9yNUNONE5Z?=
 =?utf-8?B?MmhmakNCTS9oRGdlbUtNR2NQRGV0SEhOdW0xQUVibVZFUEE2dHhORGN6bmR2?=
 =?utf-8?B?TGVzbFZuMGVrMjhycXlUZ1F1ZDJGK0x6UjhFQjhSY1E2MUtCZHl4dEprVVdh?=
 =?utf-8?B?M0hKWlYrODNNNUswcG1HdFBRYU9rQVVvRFBsMWQ2SVhWVHkvRFZtLy9oTmxa?=
 =?utf-8?B?QjJJRVQ2VzNGNFdVaGluMnB0SW9yRG5KSE43eTBlZWlIMk54Q1hoY1U1VUFF?=
 =?utf-8?B?aEZVbXlLMWo2L0o2NE1lUG9MSXJKRWpOTzRBbUVPQ1hSdXYyaUZEeXNNRkxQ?=
 =?utf-8?B?Qzl3enRudG9xZlZCZ01oUGhYbURiR1dnQ3pMcDBUOG9qNW5kaTJHaDgwbzRL?=
 =?utf-8?B?L0JBWGFsbFFmL3B5WThjYUd4Q2hGWkMwWVhZN25XNXJ6NkhaK2d6OFFpUXdv?=
 =?utf-8?B?STBtSkdiSHRLWk02N0E4aStxaEZnOUxrY0pzaGI0UGdLZDF0RXR3VHZUa0ts?=
 =?utf-8?B?V3VIZ2FYMUhWNVRqa3gvOGhlcHFLVmE1UGpBOFFjbXdWN2R1ZlR6UW1TbGVz?=
 =?utf-8?Q?jpAHp9aMHBzfW1xien9O+tcws?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd81a7d8-43a0-4bc2-0eec-08dcf81ec4d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:37:01.9213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kx14TNfPV8inUwPR+gFoti3IYWRiER8dcRy7aNRD9+pPLRSHFHStMecoe73mYS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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



On 10/29/2024 6:59 PM, Alex Deucher wrote:
> On Tue, Oct 29, 2024 at 2:58 AM SRINIVASAN SHANMUGAM
> <srinivasan.shanmugam@amd.com> wrote:
>>
>>
>> On 10/29/2024 12:07 PM, SRINIVASAN SHANMUGAM wrote:
>>
>>
>> On 10/29/2024 10:57 AM, Lijo Lazar wrote:
>>
>> Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
>> gfx related sysfs nodes.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
>>  7 files changed, 42 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index e96984c53e72..86a6fd3015c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>>  static DEVICE_ATTR(available_compute_partition, 0444,
>>     amdgpu_gfx_get_available_compute_partition, NULL);
>>
>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>> +static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>>  {
>>   struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>   bool xcp_switch_supported;
>> @@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>>   return r;
>>  }
>>
>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>> +static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>>  {
>>   struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>   bool xcp_switch_supported;
>> @@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>     &dev_attr_available_compute_partition);
>>  }
>>
>> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>> +static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>  {
>>   int r;
>>
>> + if (!adev->gfx.enable_cleaner_shader)
>> + return 0;
>> +
>>
>> This check seems to be incorrect here, because enforce_isolation and cleaner shader are two different entities, with this check enforce_isolation node won't be created for some of the ASIC's where we don't load cleaner shader explictly.
>>
>> Correction, this check "
>>
>> !adev->gfx.enable_cleaner_shader" handles for ASIC's where we don't load cleaner shader explictly, but having it here I'm not certain cz I think we expect enforce_isolation node to be created independent of run_cleaner_shader, would request Alex/Christian, to comment onto it further.
>>
> 
> We want sysfs enforce_isolation whether or not there is a cleaner
> shader for a chip yet or not.  It's useful for serializing access to
> gfx.  Before we added the cleaner shader stuff it was still a useful
> option for certain use cases.
> 

Ok, in that case will make the check specific for run_cleaner_shader
attribute.

Thanks,
Lijo

> Alex
> 
>> -Srini
>>
>> And moreover this grouping, its better to be done for all sysfs entires in amdgpu ie., not only gfx, for other modules like even pm etc., so that we can have one common sysfs amdgpu framework, improving code consistency and maintainability
>>
>> I had initiated this https://patchwork.freedesktop.org/patch/595215/ , but I couldn't finish it because of other work commitments.
>>
>>   r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
>>   if (r)
>>   return r;
>> @@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>   return 0;
>>  }
>>
>> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>> +static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>>  {
>> + if (!adev->gfx.enable_cleaner_shader)
>> + return;
>> +
>>
>> Same here
>>
>> -Srini
>>
>>   device_remove_file(adev->dev, &dev_attr_enforce_isolation);
>>   device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>>  }
>>
>> +int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>> +{
>> + int r;
>> +
>> + r = amdgpu_gfx_sysfs_xcp_init(adev);
>> + if (r) {
>> + dev_err(adev->dev, "failed to create xcp sysfs files");
>> + return r;
>> + }
>> +
>> + r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> + if (r)
>> + dev_err(adev->dev, "failed to create isolation sysfs files");
>> +
>> + return r;
>> +}
>> +
>> +void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>> +{
>> + amdgpu_gfx_sysfs_xcp_fini(adev);
>> + amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +}
>> +
>>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>>        unsigned int cleaner_shader_size)
>>  {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index f710178a21bc..b8a2f60688dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
>>  void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>>      unsigned int cleaner_shader_size,
>>      const void *cleaner_shader_ptr);
>> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
>> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 9da95b25e158..d1a18ca584dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v10_0_alloc_ip_dump(adev);
>>
>> - r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> + r = amdgpu_gfx_sysfs_init(adev);
>>   if (r)
>>   return r;
>> +
>>   return 0;
>>  }
>>
>> @@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>   gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>>
>>   gfx_v10_0_free_microcode(adev);
>> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> + amdgpu_gfx_sysfs_fini(adev);
>>
>>   kfree(adev->gfx.ip_dump_core);
>>   kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 5aff8f72de9c..22811b624532 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v11_0_alloc_ip_dump(adev);
>>
>> - r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> + r = amdgpu_gfx_sysfs_init(adev);
>>   if (r)
>>   return r;
>>
>> @@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v11_0_free_microcode(adev);
>>
>> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> + amdgpu_gfx_sysfs_fini(adev);
>>
>>   kfree(adev->gfx.ip_dump_core);
>>   kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 9fec28d8a5fc..1b99f90cd193 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v12_0_alloc_ip_dump(adev);
>>
>> - r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> + r = amdgpu_gfx_sysfs_init(adev);
>>   if (r)
>>   return r;
>>
>> @@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v12_0_free_microcode(adev);
>>
>> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> + amdgpu_gfx_sysfs_fini(adev);
>>
>>   kfree(adev->gfx.ip_dump_core);
>>   kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 66947850d7e4..987e52c47635 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v9_0_alloc_ip_dump(adev);
>>
>> - r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> + r = amdgpu_gfx_sysfs_init(adev);
>>   if (r)
>>   return r;
>>
>> @@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>   }
>>   gfx_v9_0_free_microcode(adev);
>>
>> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> + amdgpu_gfx_sysfs_fini(adev);
>>
>>   kfree(adev->gfx.ip_dump_core);
>>   kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 016290f00592..983088805c3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>>
>>   gfx_v9_4_3_alloc_ip_dump(adev);
>>
>> - r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> - if (r)
>> - return r;
>> -
>>   return 0;
>>  }
>>
>> @@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>>   amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>   gfx_v9_4_3_free_microcode(adev);
>>   amdgpu_gfx_sysfs_fini(adev);
>> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>
>>   kfree(adev->gfx.ip_dump_core);
>>   kfree(adev->gfx.ip_dump_compute_queues);
