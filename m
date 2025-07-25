Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3016EC87FCE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 20:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B559D10E050;
	Fri, 25 Jul 2025 20:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b3kb2hYg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA4710E050
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 20:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8uB6i2SKXcERButoSwLykUJf/Su1qOeYmwxNoJReNi1wTaiD2npjr0yCIBKs75cCuOiohAt7til4XiXUshMtAwMeH9wqbLsHXg3K5MBL+Pt4631yQ/KCn9qgyu65vJYqu8tT3vHX6d5zy41LDEhU2xBh7pF/D/8GLmyCiR1CIhISSOVSjx6kYXK9vsFC6tLEcniWJK2r5BxM10fwIPyBBvYhwhkzykkypGoPaEcUUaZ0ujlA2eSKt1AnSdpHaMpjlK1DBOA0l+PE5C4GeiTtaMe0Y+SzqlczPM6XqwkwKrRACmICrRbEx5EDEuCwGXDhQ94Ca8/SgutR1zPXjN56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxTikUKmVP6zt6HkNImOpRN58AgLCfHPm2a4RPEdpQs=;
 b=J/cZoSpv8fmJ5xzPA5j5xJxgn+/0m6nofKhSe6TvrPW9c1jOwO7OjXj4Q5Tysmo+eBxDu43y5KiWJDeethIG++hUXxb5IXk6Fe8y66kNmc7Yvu9hb0RNg2n2gzrUYC69EqUGjyoYKMdDk03x1KD7nKJJ/i7j7AuN/faoh4kY4U6LWPGaWf8TJaF4vP5UbAnqg+lAPNE+KAlAPDmeDpTgxx9O0Yqs+TBpxp0Aa+PjZEdsuielOBpfdYEv3jII4VqhShbZs6htdU3Ow1GilaMytq08SVb0BTyEdTwZe1pEUUjejSCX1bH3U9ICINeCAla/EXuHxhIX2yznh8U8fvG5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxTikUKmVP6zt6HkNImOpRN58AgLCfHPm2a4RPEdpQs=;
 b=b3kb2hYg99BhePIv7jrMj4NxmvWVxeVqxtceTopH5HWcbcOZ6NDP0uxVEVsSYtncTYW4fNhtc96CAhX3/R7fLE/ygS0PGehY6ghnB4//7fs7bc4wt/oPcXyEmxoTPlDUJ6P5H7bPq09/+ZeczGVAeV106Ts0M/8d3hbP7dDDaX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 20:26:37 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 20:26:36 +0000
Message-ID: <017ac59e-1945-4951-bc86-9357a1f868f4@amd.com>
Date: Fri, 25 Jul 2025 14:26:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: Fix refactored DSC cap calculation
To: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-2-timur.kristof@gmail.com>
 <kzydigo7sq2odubrh5cci54lw2htowj56g3ihg6hn5pynnnq6u@oof6cdqts3h3>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <kzydigo7sq2odubrh5cci54lw2htowj56g3ihg6hn5pynnnq6u@oof6cdqts3h3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 467c6c79-d67d-4b6c-cd0d-08ddcbb98dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UC91VnphZzhaR3NVWUhaMGh2YXluMVlvdEt3SGN5MXBtdjFJanBaLzIxOXRI?=
 =?utf-8?B?NEN3b1FqZG5mQVJzS0Yxc2Jld0ZOTXROeG5TcGVQRXo2Y0hDQ2QreWhmWndB?=
 =?utf-8?B?Zlovell6dG0rSDJQK1VGbXFEOCtVVUJLR3FYWkVjbTgzcEpyS0wrSVkyeWxy?=
 =?utf-8?B?Tjg4UzVDT01IcCt2R0JWb3ZXOUpFOGk1ZmJFdzBqclI0QmJkeFByWjg4MWcr?=
 =?utf-8?B?WkF0eWx4K0ZMOTh5MHJTZHlKQWxTS1B4NjR2a1REWHorQzdETFlzY0VaWEpk?=
 =?utf-8?B?c2R5c2EwZkR2b0NPbWc2NkYwV0Vvc2ZHbXQraWRVdVhzUWRZbEllOXI1QUlZ?=
 =?utf-8?B?U1JKNHBUNC80a2RiTmJHMWdOTEVhNVA5OUR2bUkvQTAzeUVHWlkxUHkrK0hj?=
 =?utf-8?B?K0I0RTlSbmR4QmphRktIRVhXTHVuMUFGSDlZeHpxdStmdW05eFVDQ2FJNDJK?=
 =?utf-8?B?ZmF4RnFFOXl5SFNUY3BXUHlDR2kraDdCMXpnZ3NQUzNTSDJPMHd1SUF5Rjg3?=
 =?utf-8?B?aGxFRlZRRjE5T1lhdkxFbkMvajVteXF1OUlseXFEd01MT1REZmIwU2w3ZHoz?=
 =?utf-8?B?VktVQkNaN2ErQklXR1R6MEtNa0l0Um1wNWJPelBaQjlnQnhDcW11VDVsbXh2?=
 =?utf-8?B?dERnN2xsTW1jNXJINDB1Yk5kSFlid21MWi9EWjR4RmdNNlkzdzNDMEFnNnR6?=
 =?utf-8?B?NFNwTWJYQVp4Y1pPa1E5R1FwSElEbFMzaFhRbFg5RXRQaUNJaFRGczQ0WGgr?=
 =?utf-8?B?ZXRYV1BVOVdsL0ltak16VE51YXgvZnJxL0lueWtBcXhUekl6bWRUM09LV01Q?=
 =?utf-8?B?VWwrd1V3blIyY1BWY2htZ1NXZFV4RHlDNU0wa1U0Q3p4cUZRY2RMQ0kxc29H?=
 =?utf-8?B?LzVJRmF4VkFIMkh1RlpXbm9GUFRBa1FqWWpuZVNybFVTRWdFTEdrR0tjaHNY?=
 =?utf-8?B?cEtudEsxaklJbmEvamxzcmhtRWc5TTJwWHB5Vi9abGRHdVkycm9GUVh4dGFT?=
 =?utf-8?B?RTlxMFc0UjNFSHNLUFRUWVdmanpnWnlaZGN6dVk0YzVYOU54MG5oWUxKSTNz?=
 =?utf-8?B?MDN3QUdCcHVJT2Z0VnFoZ3pYbi9wMGxUYm5HUXo2TXZoUDRWTm1DZ1pjUFNX?=
 =?utf-8?B?UTdwejZSTVFPZTM5dTR0TWsyb0xNUHVXc3FHYTh0ZEJCeVZLNDd1eEl0aXVw?=
 =?utf-8?B?a0NBdU94amlaNkw5M0lwbXF2Z3hLYVRXV0dhaDZZeWxHUWhPZkQ2M0dvK3B0?=
 =?utf-8?B?NEFtVWFvYXlEMHVUWUsxdllsMlNNSFp6eU1aS21leDlXblBlaDNIMmlmcFlR?=
 =?utf-8?B?RHRCYWlsZkY0Z1dOV0hUdUVyZFdoYktnQitXSFFrbXl1dnNGY2g3cGd5TThv?=
 =?utf-8?B?S0s0OFhkb0UzLzROOXc1Q0VuMmltNnBtNGFKRTVrRWprS2FubENNTFE4eU9F?=
 =?utf-8?B?ZDNlZ3RkcjZwK2JXbUQwVTdrQ3ZKWFlJTndTc3IrRG82RnlxM0M5QzdnZE1x?=
 =?utf-8?B?d0htcWtIMlRDR2k2akhiQWdGTlk4NjVBbTlqVHpjMVNudzNQVlBDMjJ3VVRv?=
 =?utf-8?B?VStEdkErbTJnSi9zdDdkbHlaRjRkT2hNb001UkVUZGV0Wmg2QWpjZGFIY3kv?=
 =?utf-8?B?bStoQ1k4dGVKK3Nrb3psbGNpdzNzZERWVUZVeFlqUUM5bXM0S2xrRzdDazBZ?=
 =?utf-8?B?ZnR1Mlh4OW9QTWFvRU9yZW5OK2t5d2NydVJJZ2pOZTF3eU1lRWtjTENHUlZ4?=
 =?utf-8?B?SDk4Q2xqV2YrNE5lWmg5VUpPVWVBY2VqR2dFQ0dUeHhkUnJZeFVTM0VzSFEz?=
 =?utf-8?Q?e7Nifw95SV9TE+vZHUMbb26n6yNBojB1P/GdM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWtNMkZNN2huekZFVWUzZzRlQUtGbkZxc0xJUTBTVFdNcXUyUEdYWTRuNm16?=
 =?utf-8?B?RTBIT3lHNlM2bktzWm5UeEFJUmlBZy9LQXBuTE5mTFNFM0dPaGszNzlIK0xJ?=
 =?utf-8?B?NitVUVZ3Nnd6ZTMyUkF3bXdHd0NZQmlIc3lFRnFSeFQzT05KZjlDNjI5d21n?=
 =?utf-8?B?RGVQK21XdzYwajhwbkhiQ3YwYkYwd2NGblNhL3ZIN0dYNzdGWlhoUnkzZUxT?=
 =?utf-8?B?WkFXR1MwTUkzU2V4Uk1rclRMbTB2eWVxQ2JyQjBkeDdraVR4eW5NY3E0TmRR?=
 =?utf-8?B?bEhmS1drRHJ1TllZdHRwTEpjTFZIcnhTeEZJSHF2QlpoVzZoL0dYTEYwUzJj?=
 =?utf-8?B?cWNUekpuRDJFOElIOUJtWmlrMnV5TlJRSFV1d25tSmE5ZVM3ZDd1akkvRkdI?=
 =?utf-8?B?Y2pid0psSUttK05rVDAvMitCZUtZYlpqUE1Mellsc1QxLzlQMThCNlVjZWFQ?=
 =?utf-8?B?WXY4aUFoMjhUdkp6aU5IT3YxWDdKa3ZmeStjakZSSVlycGE0ZE80N0pTRGZU?=
 =?utf-8?B?eGRZdVNsUkp2ZEc0SmN6VzAxM2FBVms4Z3RmVEJYWFZ5WGphYW9zYTA0blVr?=
 =?utf-8?B?STVySm5Ec1BTak1wb05oczEvVHhjMGt4elkxd3VHVjFMbHVQd2grMVpVUDIv?=
 =?utf-8?B?STl0cGFMcytLQXk3eGt6cHBOMHlYa2JYSDJmbzZvUDFPSC9sZCtCRTdFY2tU?=
 =?utf-8?B?SFpxSTRtVDI4eXhZOFlnUEJsS0lVeExma1IvRmxRdURjS0d5Rk9DR0FIbFd1?=
 =?utf-8?B?MXBtdHFkV281Ri94MGkwTERWbEtxSkxLeUgySmMzNTF3bFF5OHVtYmpFZHRO?=
 =?utf-8?B?SHhsM3NhdVZtQmlzN3pGaHdFZlhRcUt0NkNBcnhBWVFrb214Wi95SHVXOGYw?=
 =?utf-8?B?RGV5RE5yN0VLNkczTG9JbzdRZTFFVmNvNTRIYlF5b1pJT2lIdVBPMU4vREVw?=
 =?utf-8?B?RW1vWHZRY2xMWFZINjlYM1RZejFtZHpNR0xWZTIvUXJpOTRLZXJNQyt4QUNo?=
 =?utf-8?B?amN3YXNDazJ6QVg4SjdLNzVRTDBxSnhHTkFQMkJkYnQ2cXlzZGtNcTVlSkpK?=
 =?utf-8?B?SkV3Mnd2cS95VW80aG1UbU1YS3JLeVVHNWFzTmEvVThMb1RFdEs1S3FjcEd2?=
 =?utf-8?B?OVprd1M1VjR3d0ZseUg0dDdha01ZcGVUR0FnYnVqSTVzU1ROWW5nM0llRWFW?=
 =?utf-8?B?c2dBcFNaMkx1UElHUlBoampJNVlmZGdIakZYUElSSlRUaHdxaTczc2Z0SlZC?=
 =?utf-8?B?WU01QjdpeXN4ZXZ0ZktubFl2ZVprSkRiTEREWExWdU5kK29RSC9ZTmVYNHpN?=
 =?utf-8?B?dFc4TnZLTVE4SXozRytpTGcvUXFIYUY1cFJsOTZJTDBUc0dtREFDYktzQ3l0?=
 =?utf-8?B?Z1pJU2NEME5FYTMvcEtFY1drM0djWjFaUmdRNVIwSlFKOFlCaE1ySDhNZWxx?=
 =?utf-8?B?ZUFaZ25ML2dKejFRbTBFaHNmbWg5KzRidkdBdGc4WC9hY1BDQkp6SUNoT2R3?=
 =?utf-8?B?S0wvRWpHazRyUmVmb1Z5bm1uUDJsc0Z5MFlCbU9iSlczcjl4WHFNZXNCa3BW?=
 =?utf-8?B?R3M5dHdEenMyR040U3FSQ1owZU9BNGdOeVFQdTk0bU84NUZXSnIwazhkVVFz?=
 =?utf-8?B?VXl6K0oreFRVOEtqZ1JOS2lZcE5zMDJVTVg0UXdoNXRiWnNTZzVuaWNPODVZ?=
 =?utf-8?B?K0FldnVyeXlLenBvMFhmUzVqKzI4TUo2NDJpM3FRYWFLQ2ordWpZSFc2OEtm?=
 =?utf-8?B?R2d6VmZYdmxnR0dEZFJ4UmNCdi9jdUdMOGphYUpsd0E5Ryt2UXQ1UGNoMGxC?=
 =?utf-8?B?QUlUUTlHNlUyK01xUXpZNWh3NThGcTdXRk5GL2VqdE05TDJ5TU1kZTIyRlZJ?=
 =?utf-8?B?YXoyQVFCVzZjN2FXVm02Ym1oZzkwL1R3WGQ0dVM1MnpxYlBzUk52cFdVQzBX?=
 =?utf-8?B?SS9hNGo3MHhDclhwYjc4M2x0bno5d3J6eE93MGxUN0ZjQVhJa2dDRkVBc3Aw?=
 =?utf-8?B?UkthYkFwTzVSWHlvRVVPTEJqcFRXU0xHaFB3cFJ4OHRIQXpleXQyTVhyUmlt?=
 =?utf-8?B?MmNzNU5oOWwzcUk0Ylo2VFp6SWd2ZzVBclYxRnFma0JjakgreHRsNW5CeFU5?=
 =?utf-8?Q?DgJZrpvBNn+f+Dh1gKiE9x0o1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467c6c79-d67d-4b6c-cd0d-08ddcbb98dc2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 20:26:36.6474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bjslyZGx2naAtekaLsP8UmnHJgJLF4NFdRExke0pjnOj0lK9bQneCEIMQt1RaBpT2zNYnSq73CF4dHkNNtjgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

This patch may be related and conflict to 
https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg125873.html

amd-staging-drm-next should include the above patch but it is not 
updated for 2 weeks, so let's wait for ASDN to be updated.


On 7/24/25 16:32, Rodrigo Siqueira wrote:
> On 010/22, Timur Kristóf wrote:
>> After refactoring the DSC capability calculation, the
>> get_min_slice_count_for_odm could crash on some GPUs due to a
>> division by zero when max_total_throughput_mps was zero.
>> As a result, DC was broken when connecting a GPU that doesn't
>> support DSC to a monitor that supports DSC.
>> Tested on Oland (DCE 6) and Fiji (DCE 10).
>>
>> This commit fixes it by returning zero instead.
>>
>> Fixes: 4909b8b3846c ("drm/amd/display: Refactor DSC cap calculations")
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
>> index a454d16e6586..4169ece9c535 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
>> @@ -642,14 +642,15 @@ static unsigned int get_min_slice_count_for_odm(
>>   	unsigned int max_dispclk_khz;
>>   
>>   	/* get max pixel rate and combine caps */
>> -	max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
>> -	if (dsc && dsc->ctx->dc) {
>> -		if (dsc->ctx->dc->clk_mgr &&
>> -			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz) {
>> -			/* dispclk is available */
>> -			max_dispclk_khz = dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
>> -		}
>> -	}
>> +	if (dsc && dsc->ctx->dc && dsc->ctx->dc->clk_mgr &&
>> +		dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz)
>> +		max_dispclk_khz =
>> +			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(
>> +				dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
>> +	else if (dsc_enc_caps->max_total_throughput_mps)
>> +		max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
>> +	else
>> +		return 0;
>>   
>>   	/* consider minimum odm slices required due to
>>   	 * 1) display pipe throughput (dispclk)
>> -- 
>> 2.50.1
>>
> 
> This patch lgtm.
> 
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> 
> I added other display folks to this patch.
> 
> I'm not sure if the original modification (4909b8b3846c) is already in
> the stable kernel; if so, it could be a good idea to send this fix to
> the stable kernel as well.
> 
> Thanks
> 

