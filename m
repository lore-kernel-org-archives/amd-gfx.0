Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F26C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF8DD10E181;
	Mon, 17 Mar 2025 14:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gEPPpwX3";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDF310E181
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9entziySBSPUNNPKtwwS2NH0ik5ngOJs3KoXgvqv+NYAWoceUDknWopU1FbNHeYC0KR7flpoEQis5jspL1BvLnJI66fcTfxz0kqP6vvK3l9GoZnrpYdEytOSd8y9UVUgZAecUGtiMRlZa/SJNTs2ZXr8pvSJIFA8hsFN2MeWYgbkPa9A8sjLodkhX6dAz/i2MoTiVrcJLQ2XCgaOpYMUhG8wb7/eXHMJrILUZ2eM4nJSXdMjh3uHNoefBXZz7sDq/E9eIz7x+LGXuXfc9Va7n/xQCaRsm1asSTDtuUhYnIf9Rd4IDoSawKTQJM0PbYEwwDclMCep3mW9uSUJlP7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x9MTpxM1HFcZx+Id4qVYbMk3Brpr9f3gnqQiIE987M=;
 b=NEwiVqKhrv09ueDI4QVoYvbR4fAT+/omhWPNSvp8z5Yu8GQoaNA0A1xDtbxPnrZ0aZRdHIW4O1MZQ2PXUcVHLaSyVudEHRK8Ck9F2E8xFn5Aoj1poYgoj8SPiV1V068OwGAbZc8TUp4S0t50dcv1pNcOjDsusM2TFIjqAf8DmgYSfgMtY1UcBN6r519NULZuYCBLblUkouLhdqvqwwnwarXhQnFFHT9RoGIpXv17GuYeL+dysPkIm7+CX9apaO+/hAfjxp25VACsW1lvhYRzszxknnKIIm11pksxOHuY06m3TUcuctOd4Q1Z6u09IpF/WNa+iWU+jdXJamGf8HhC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x9MTpxM1HFcZx+Id4qVYbMk3Brpr9f3gnqQiIE987M=;
 b=gEPPpwX31D20gBAWguUsNQ7P442OCfKDLyUY54XT4nIhgUPgpa38e/e89ltW8ZRoKjdnPeXzbB/i8MH0dYwhCzcECdsMBaJEc7L7ECq5C4BYoeu4OaY0DZ9+fyX/Ifj5IwTvyN1ByfYKELYOtqg38ZFTwkquRSHHKz+x/Lk4E+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 14:40:42 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:40:42 +0000
Message-ID: <6fa6d314-3da3-477f-bdbc-31632cb3c774@amd.com>
Date: Mon, 17 Mar 2025 20:10:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
 <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
 <6face0d4-8adf-488f-84c8-12a012bdde15@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <6face0d4-8adf-488f-84c8-12a012bdde15@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6ff52f-bf70-4907-8457-08dd6561b157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0N6U3kzRkNLRnZSSThaZzFLbHFNY0FpcEpTcXZSNHNKc1Vra1J5Y2F3Ukdx?=
 =?utf-8?B?WHA5bjZhc1pQaFpRdFBjbTI5K1pDams0R0hoYWc0eDhvQ0UrakpOV3djbnJn?=
 =?utf-8?B?bHMvRzFlVFYvM2FuUlZrWFFoQ2doUi96MFJ0Z0RiUlRpNm53S2xuZWNRNzdW?=
 =?utf-8?B?MmxyYXpaakVUVkxTalJzZDB0eWVRWFNOaFVFZHVvY2xzMkcwcmptSEs1cE82?=
 =?utf-8?B?cnNTaUVzZ1FFdGpLSzhwZzYwdkUrYmtNNzdsb3A3L1h0NDI5dnU2WmZydlFa?=
 =?utf-8?B?ZmZxQlJ5T2dvZHB0VDI4YlZ5SzVLL0pxeCtwNXpjNHR5UHhyNnlTdjRlNzds?=
 =?utf-8?B?d1dvYURoYXRDeUp4dW9vWkVCb2FWK2lUVEdpQkIyYUs5SVpPR2g1aFNMRUxP?=
 =?utf-8?B?V083WTdqOW1ueEN0Wkt3cmZxTDlQTWQ4UzhTZVFnZmJ2ZS96REFDaThZR012?=
 =?utf-8?B?RnF1bitNMmdmQnQ0bjFGUzRsa1lHK0c0S2lFOEQvNFYyNEp0WXVVKzVpUzlO?=
 =?utf-8?B?MUp5UXBGdFVFRkc5eHdoVFdsUnBTRlJqdUNPMU1HSWpkYkRacC9UVlVsaEJP?=
 =?utf-8?B?TiticjZxSld1RDMzZjEwVXIxYVMxY1Nhd2pDVTA4LzltRDZ4aVJ4ZE1ub2xV?=
 =?utf-8?B?Vjg5YWRsdGUvZGU2Rzlaa3NmYlhZUkJrVEdFMUs5L3VIdkVhYzdFUlRWTmtZ?=
 =?utf-8?B?L0ZTZW1TZkVCVDdtNzZiZTFQa2JiaTNOVVlIdS9qVlgwMFljbHZqTUV6dFcw?=
 =?utf-8?B?dDJlZHRONmFROFBTUmhCYmF1eWdReUZUU2N6Njd1OWltQng3RmZrbDNKRDRI?=
 =?utf-8?B?dWtXYlN0ZjBObVI0ZE5xVGRlRGx4SkZwWS9WM3E3YjJEWmJyeVhnTmNNbEti?=
 =?utf-8?B?SjlxR1dvMElRaXFYTjBIakFnckpRcFFwbzQzUW1jYWIycTdibEdrM1VrdENm?=
 =?utf-8?B?OGtVcW1oTExMbnBScGk5OUhHN1ZxUHJSMEl5V3pNMm85dVo4OCtWNm9ULzB4?=
 =?utf-8?B?MlBXNG95TVJQL0RubC9qUkFjMFpQb2dReFRVSWw3RzN3M2x2M3hyM1VMeVBU?=
 =?utf-8?B?MFJOT084TDdrU2R2REpKMkJCU0piVGFuTFhjc21jK1c5bEV3WVZvOVhERWVj?=
 =?utf-8?B?U2MvdDIwUkJsUGJ1cTVRTjRMMkFzZkVaQkVweWt3S3hVN3JKMy80MHBPZjd3?=
 =?utf-8?B?TjFGNWE0TXlZNXFCaEJBakZhR0crN0o4Vi9mUHNQcjRTenRaZXpna09WUmRJ?=
 =?utf-8?B?SEhMV2xVYTRTelcyQXVST3RlWjAyaGl3RVg1UlcrSVF4QVVOb2duUEkxWC9R?=
 =?utf-8?B?SjJWYnI2ZUxTZzJxOEhkREtEdGI2aVlDeUF3SG53TVUzalV6dW5TemFpS05L?=
 =?utf-8?B?RXUwbkt4eHRsY0Z1QUZkbkd5MEQ3QWl5QVhSdlQ2VXV5M3ZWWStnVXRiMHVX?=
 =?utf-8?B?WXF3N1gycTFWYTFKOXlodnZseUFDTHl3cHdPZ3J0SmRyK2ZLc3ltd3FBMXYz?=
 =?utf-8?B?YWJ3VFpiT21OY3FEcWNqY1hPeVE4Qk1jRFdpZ1R0SWlodmNXZklwbTdjczlr?=
 =?utf-8?B?M0Z0emZoUjBPNXpyZ21YSUkwRFl4cUtHTE9FSEI4dGZWa3ZoZFoxWGd1RUNw?=
 =?utf-8?B?TE11ZDhFMnVSQXNSWFpiS0xUYXFKYTg5Vi83OEtDOWJSK2E2b1lBeUdmaGk2?=
 =?utf-8?B?UjVjWTBhRU1oOGFHTjB3SnhRc2xnVU11azVPL01peWxQUHI4N1pqbVFUK0NQ?=
 =?utf-8?B?WFRMTmFYRHprdmVDN1VGNU9QZUF2cjlnTlIxZEw5NTd1YlhsWWNDbUJKU25Y?=
 =?utf-8?B?ai9aRjViT1BNUWRsTWU5NENrdEp4Ulc2OWpqQ2taZVFCcEhOdEk4Y3JYaGlI?=
 =?utf-8?Q?kTpcLFv1fJs1W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXVqbW93U2M2YXhQd09wR0lGN3FjamVENXpuQXIwb3hRbk1CUVdzczhmaUNH?=
 =?utf-8?B?YWkzNEtoK0M5SmV5dmV0ZVQ2cGJYS05FdlhhRXBlVUJHMVlDaDFqTzJXclV3?=
 =?utf-8?B?dHdtMjhMSmtyM3hkd3ZTVDVtbWkrUnFmakR0UHE4aTYvOVlzVlJ2NXJLMGFp?=
 =?utf-8?B?djY0REVsYUp3UitUZlVSWXMxcXdmbnlPZ2RjU215MDF0Y1p4WCsrZXZlRjcy?=
 =?utf-8?B?R1dVTzgvamlxY01aeWtmbG81Z05MZmczRk9rbGpZN0h1R01XLzVkREd0L2FK?=
 =?utf-8?B?MkFxbDg0UjFCQlpLZURYUFBDd1YvYWFNMTJOWU1qRjkvQ1YrdGhnK2hTQy9F?=
 =?utf-8?B?SEkyTE54RHZrTHFUOTd1L1pWUGltRTYwOEVJNW90NkZVb1JzV20zSSt6TTgv?=
 =?utf-8?B?ZG12UEFOTHR2azhkMVRGSEFPZ1Y4SS94U0dUV1FJdWc5V3ozckNKU3NxVjV1?=
 =?utf-8?B?bFJWZG9Tc091aXMvUlIvRnArR1p3M3UyaUNBVW1hZ0k3OXJ5ZTN3UjlJL0lw?=
 =?utf-8?B?OS83TGU3NGN2ZUZSa2Yrek1qdlk3UnZ1RGptYWlQeEFSNlBiRHRvT3Jpem11?=
 =?utf-8?B?eGowTEY3VnhNSUFtTWIzRWQzRVdRRFFVczdZdTZHR3YvcVBEQ1R5b0grdlE2?=
 =?utf-8?B?azgrSjdYcDVzazRnS25hWnNHVngvZzl5cFRRYXZGL0pvMXFqcEpsbVVwam5D?=
 =?utf-8?B?ODFqT3daenBzc3JUcWFTQnkwcnZkcGVNak5xd2lPVXVXWS9ENkpSazZveEti?=
 =?utf-8?B?V1BTbFNkMThOekRmblpteXpXUmR3blBKcjNwZlFOZDlhYVpwcWRCN2VDTkd4?=
 =?utf-8?B?VVRwTXA3V3dlUkZsQTJackpuaWExblNEeDVoMS85Mlc4L1E4azRneXlKMkdW?=
 =?utf-8?B?Q1lieTlvYTVmNlU1LzZLUDdDZmhWNTdPczg1NVM1aE1jYm1EOEJacC9vN1J6?=
 =?utf-8?B?NEVxMkY3NTgvRDNwNEoraHU2SXh4UlBqTUY5b2g1ZVdPdDdQa2oyWS9Nblk0?=
 =?utf-8?B?anNoaEhKS21ZbjJMNnp0M2VtSjRYY1JxaFBtbTdwOHlRQ3RUR3J4ZVM0RHZN?=
 =?utf-8?B?ZDBDYmUvcmd6TDdKYXRWbGVYM3dzWkF2Z0R5ckFYaHR0M3p6RnZsazRMNXRI?=
 =?utf-8?B?cGZodWNYRXQ3MmpiamVIT2FiR3JEaWtTSERKVEZRMkdITHdjZ1hldUFUWHNn?=
 =?utf-8?B?elhaWXphRlRLUmU2dUl2U0Y4MW9zWGozSy8wWSt1K09Qak5ORFNiZDEweC9T?=
 =?utf-8?B?RGl0OUJ1aXF0Mk8vN2x1T3JPZDE4dG9BeG1QWUQ1cTFDYXk1Ty92OExESU5H?=
 =?utf-8?B?a1BxL1o1bVlwZVh5VVFqcXlKLy92NWNQbHlSWXJncCt0Vm9iZHNjTnpsVHRs?=
 =?utf-8?B?eDdzb0xLNko1Qmc4dVdPUkc5Yi8wWTlwdTR1bUJ1QWU5WmxVM0pWdklLWW9j?=
 =?utf-8?B?aVBsdzUwc2FMc0g2TXNXMWVFNmxrTmJib2p2SjNiamJuZkc4c3l6bWdSRHJa?=
 =?utf-8?B?aFgxL1laY1gySHYrR2NjeGxVME1QcUY2VVJLanpvY3FoV3dLTm8xWG1DZHJJ?=
 =?utf-8?B?UituOFYvTW5OTDNhZDlySC9SUWk4eGlyaTdNaVBZMWozMTV5ZXJZT3RIOWxp?=
 =?utf-8?B?VElBbFczZEhnRTNTa0RkWDhRdUFHTGRtL0hES21QOEJ6NGdIUzdlQ1JkZGVB?=
 =?utf-8?B?b3czTnBXeHF5UmVTUHBBbVdQWDJiZXg0ckU1VjJnek54SEg5RGlaZmVIbVg1?=
 =?utf-8?B?eFNiNWFLVVUvM0x3YmZwdkZra3J3S2pqU0xob09iM2p5cVg5dkVKSlFaTjlm?=
 =?utf-8?B?Y0xzZE1YSFJxWGFqUVJRS3lmdlpON2RWNXhMQnM3ZnNDVFgySDFaWGc5RTh4?=
 =?utf-8?B?Ny9CTHRCdlBwdUJPOGNvSER2MXR0dW5EQTdEdC9iVGZqVVJFa01Nd1BYYmd1?=
 =?utf-8?B?OXEvVFU2ZWZkY1hoUTRYQldtRjdlKzgvKy9Fa1Y3cUdaRE9CcVd5S1VrR1J3?=
 =?utf-8?B?cGtGR3FtVDQxWFNEK2FMT1ZoQUhYQXIzWUMzNkhqMHp3NFZjYVJmL1lYWE1Q?=
 =?utf-8?B?ODA4UWovaWc5QmNjL2NHRUozYnB6Q3hsN2xwWmsrVldmK3JqWDFvUnVzVjFj?=
 =?utf-8?Q?qSJF2PQI/1J/lCR+fsrKv0IlO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6ff52f-bf70-4907-8457-08dd6561b157
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:40:42.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH8gI/AFezSp/ihzZPnram8QxAgHP8rani0IWJmo0PYZuMu6Ez16BYTdIStSPV2+COYGAq8A26r0TK28OevwvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

Hi Christian,

On 3/17/2025 7:33 PM, Christian König wrote:
> Am 16.03.25 um 16:36 schrieb Sathishkumar S:
>> Wait for vm page table updates to finish before resuming user queues.
>> Resume must follow after completion of pte updates to avoid page faults.
>>
>> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
>> amdgpu:  in process  pid 0 thread  pid 0)
>> amdgpu:   in page starting at address 0x0000800105405000 from client 10
>> amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
>> amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
>> amdgpu:      MORE_FAULTS: 0x1
>> amdgpu:      WALKER_ERROR: 0x0
>> amdgpu:      PERMISSION_FAULTS: 0x5
>> amdgpu:      MAPPING_ERROR: 0x0
>> amdgpu:      RW: 0x1
>> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
>> amdgpu:  in process  pid 0 thread  pid 0)
>> amdgpu:   in page starting at address 0x0000800105404000 from client 10
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index f1d4e29772a5..4c3edd988a05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>>   static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>>   {
>>   	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>> +	struct amdgpu_eviction_fence *ev_fence;
>>   	int ret;
>>   
>>   	mutex_lock(&uq_mgr->userq_mutex);
>>   
>> +	spin_lock(&evf_mgr->ev_fence_lock);
>> +	ev_fence = evf_mgr->ev_fence;
>> +	spin_unlock(&evf_mgr->ev_fence_lock);
>> +	if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
>> +	/* Wait for the prior vm updates to complete before proceeding with resume */
>> +		dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
>> +				      DMA_RESV_USAGE_BOOKKEEP,
>> +				      true,
>> +				      msecs_to_jiffies(AMDGPU_FENCE_JIFFIES_TIMEOUT));
>> +	}
> In general I agree that we need for PTE updates before resuming userqueues, but this here is just nonsense.

Okay, but the reason for adding this is, I was able to verify that 
corresponding vm sdma job fence is signaled few microseconds after the 
resume queue call in the timeline in tracing. I verified this by adding 
resume trace point after amdgpu_userqueue_validate_bos has completed 
(hoping this should do the waiting part), but observed that resume 
timestamp is before the sdma job fence signal timestamp.
Whereas after adding the dma_resv_wait on root.bo, the resume happens 
after sdma job fence is signalled, and was also able to see that page 
faults stopped after adding this check. Regards, Sathish
>
>>   	ret = amdgpu_userqueue_validate_bos(uq_mgr);
> This call here is validating the BOs, updating the PTEs *and* making sure that we wait for this update to finish.
>
> Waiting before that just doesn't make any sense as far as I can see.
>
> Regards,
> Christian.
>
>>   	if (ret) {
>>   		DRM_ERROR("Failed to validate BOs to restore\n");

