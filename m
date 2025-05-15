Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD2C3ABDD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 18:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D9610E945;
	Thu, 15 May 2025 18:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VcxDQWkF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B80210E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 18:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQxPEMbreJ9CZ027FPDSAepZve5+6EpFSenHnW5Jt7jZ/dlL1t4WYr5Zyp5OLosro/hnPSH7HoJTmNVje37oPsMugzrhybCvGZtxhDQDt4NMdic/BlTpDpGuXJ1bMrmaNh+gZ5l9G0JgsbvFDzlbULex1euJTczGOQ2ZuU7TMIYJpw1+IfZs/JQpWGVLluN1TYGbGhb/8zD+GQhmfEer7Qvokz9S2sm8nfnsoAAFx10nPtUhS+3s71ERr0gghgPdRzQRu1U3YW18iMKFc0vO4sj/SwbHqK2vh0GdOYYHUq6QTWPa/ZMvWT4vN3w6Dey1p+H9Vu1mLiG+oNk0mUd3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMB7aE4MICGBkoZXLxfTgASioO+fg/rR8JahYSM/3rY=;
 b=NmTEmFzXqL+UStp0bi7Yjr8jQ2ShJWOGS+Bpw3T+6WwpRsgG18ekNHUGRJibsHzO1m72BEC2oy/umv8AyrafQBhzjJtMMZebjYGvGHERmyCL0VqnYu67c0CBVz2Y2Ks3N+kbinPZCadldjjktTC2NYujYEOZ6fnsy1/eyDvq3LPY67u8lT1tpQ36WxKV0JVUR0qwdBAHMT7CWXL6rib3cO57ncDPNlQwIJsaiqQxwi3vK3sJ2ohOYgxInW4e9B7JnnsCzskMtcvpuCBUxziPwpr2jET8dnOvmRpj7+XAN4h6jfJtzCSRYUhxSeItUWYxmbnLm2bpk2A6f5Zmcz95Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMB7aE4MICGBkoZXLxfTgASioO+fg/rR8JahYSM/3rY=;
 b=VcxDQWkFr4RFOd5aCyIS9F0bsyhknhG42V3t9EYGKCwVgduKwMSMcS2fLNIAVqE/jJJmtlGajLXDScRI58fUvf5XR5Ew9DIU0N8StbTKQFXBAmGP4esAVvC7J4IOXIMCE6mhY/8TxVN7lkR5JSqBHsn9/VrLU8PAg3HEpaYx1Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 18:02:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:02:50 +0000
Message-ID: <9fb6bd11-4855-404b-af11-004a7b2bf65a@amd.com>
Date: Thu, 15 May 2025 13:02:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250514213721.519943-1-pratap.nirujogi@amd.com>
 <f2d33475-53e8-43ec-9095-95081e480989@amd.com>
 <6088b764-cf5b-4c21-be95-4695730456e3@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6088b764-cf5b-4c21-be95-4695730456e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a62a27-ef2f-4e90-5dc8-08dd93dab4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUkzV1RLQm5wUld2TUJicXFWWnRFUlFsRE04bDlqbjcyRS9oSVJEWUhGNWhv?=
 =?utf-8?B?OU54eUdVbjlVczFSTDd3bU9ldGdsZ2U1cktZbEFDcklpbzNKVndNYVEzOFcv?=
 =?utf-8?B?TmloWmh1TitaeWwrNWdxMTdEU0dtTmhxaE05aGdldnlYWGFFczVLY21tRTBz?=
 =?utf-8?B?RTNlNjM0T3hDNDJuSWZOanhBWkIvQmsxVHZRaFV1QWhjNEFTWEF0M0p1RSs5?=
 =?utf-8?B?VWkwNWxjNDdyQVZCOU1meVg1TDVIaWN2eUFIVHZ0K1o1c2k2SmdqWU5QOGo4?=
 =?utf-8?B?bG85cFVRb05hQ3c5K0RSTjJBeUt2MzQ1Z0dtMm9OSkFTaXRJOWJ3aWFiQnZ1?=
 =?utf-8?B?UjVPY2I4dTFiZHptMUZmMEhQUTJwUk1XZXlLQ1pMYU1KUHA0Y01ZV3BTaDY2?=
 =?utf-8?B?UnFXNGpJRWlLZms3S1Vpa0RDQ1hnbHlCb2k5OTZFZ1FGTGUrSU9QWTB6Ykh0?=
 =?utf-8?B?UTVNN0o0aGVTeDc0WHpXWlVBY1lRT1FqWkNpTitzSXpCQndQaFNSUmt2Y21G?=
 =?utf-8?B?UDFIMkZwR0RuM0FHRTZxWmhVbGNqcEIzVVUwTU5YRUVGQWpGUnp0N0M1RHhJ?=
 =?utf-8?B?SzdsamFKUS9DYTUxRlRZODZLeTJSM2lmUzlNVU82dndvZkV4MUJ4ZnQ2MDQ5?=
 =?utf-8?B?NTNnYUZpOFJxWmgwWDZmaEJjSFBCc3I1SXp5dEQ3T3R2QVlxbi9XdFRTdFBS?=
 =?utf-8?B?cTJLSmcrdGxwSGNNdUVZWEFKNFhTWkd0OHduUzUwaElPd1Q2Zld0Z3FCL05v?=
 =?utf-8?B?b3ZxVitQTTQxcndZRFVMTitWK3R2MmVpNmVsN3YwY0FlZFBzbHJqVFFDaWQy?=
 =?utf-8?B?NUkxck04Tm8rK3VUUHhORFFNRHkxdzMrdElTWU1nSEY1SlpOa1pGcThCOGpS?=
 =?utf-8?B?dUsycGs2NThTd1JrcTFJUFNEZTVqTEVjZEtUWW9kYkprL284SmpEUHl2OFAy?=
 =?utf-8?B?YWFsSGlLVjdyNGxZalZYQlh2cjE2QXFjdkMzUFJ5RzZpS1R0UW43UTdzWExx?=
 =?utf-8?B?MG4wT25pRFphcmp0SHFCNzQvOEZCTkVwbFQ1NDFNQkVPMlJ6YW5DZEtobVdJ?=
 =?utf-8?B?TWcwbXZTcUd4SUNZOWZrU0lieTBRWEpoNkc1QUc5NjVBR2pEeFpZSm1sbEht?=
 =?utf-8?B?d00wK2VGTUx3ZjJ6MjkwN3dVQkNhZWg3QWc1Z1VBcTAvYlNhMlVVbWxlcGlx?=
 =?utf-8?B?V21aUjY1UVlobFlQakpwWHNhSnMyeUttMHgwWFNlU3ZHQmx2SzlpeE93Qy9x?=
 =?utf-8?B?MlF4bTA4VWo0dGgrOHFYaUdKcHBNTWdpN1ZFWFZpb1V6RDR0TC8wQTRRTExk?=
 =?utf-8?B?Wk1GWjI0ZjM5Zk41YmxYNitidWxsTUxiNm5OVDdNNWpBR0x1L2J5Sy9URW1z?=
 =?utf-8?B?T2trQUwyd21Lc1djandKN2w1WldYUU92S1d2TXBSa28vbEJsakt6SkZFV041?=
 =?utf-8?B?N0xrdHdNZjBQWjNxTDE0S3RsQnl4MWR6ZzgrZ2k4NXhFWlVUT3NIajYwOXJZ?=
 =?utf-8?B?dk80SUZPVVJVQ0ZublBRcms5UFRSd3V1Y0JXNGYwUzczSTFaS0x0Q2ZZSFpS?=
 =?utf-8?B?bG9mVkZ4SlN5RmcxV2ZiaTI5amVSSDBGSTJwMW5DUVIrMEJKMVNuMFZLdWlo?=
 =?utf-8?B?Sk02dGVuSkNyRW9BVFZCYWhuaDg2V2RzQUtJcmxXS20xaSs4dklaMzZ1bmsv?=
 =?utf-8?B?bmpkRW43aHFtSWRlQU5pazFBY3U4RzFISjlDcU53SmlRMUxnTndxRXRrbVo0?=
 =?utf-8?B?SG5teS83UFltbC9hQjduT01reUFJR3Vmb0tSaG1mT3A4TkQ0bjBkMGxyNmJO?=
 =?utf-8?B?a0RCREhrTzBtTlRMUklEd3JQNUVQVkYrVnlPd3JubzhPQmZGNXBDMmJMNUN5?=
 =?utf-8?B?UHRMMnM5Q0JkTElFWncxWThQN2gwbTkrMXZqRFBiQVdlNDRjZkQvUDFTOXRB?=
 =?utf-8?Q?CVndcB6LpYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNkQ3FFNlp0R3FkckRKYUs5SGNuQzFlNFI5bktZVDhMWUNkbVhRNVI3T09J?=
 =?utf-8?B?OTdFNDZiVFR6MkxRRnQvTXExZFZUZEl2QzVyY2diZnNMV09vdThpWkM4SHhQ?=
 =?utf-8?B?MzliR2kvbEorZkF1eG5sdUJLeFovdkZJRWExbmRVeVdWY3l1SDYxLzRNNWJ3?=
 =?utf-8?B?dFhRZysxRzZrR2lvQ2w0OGs3aE90b1RGbU5RUS9EWXMrSkxjVkYvT0IycTM4?=
 =?utf-8?B?T3pYNTdnNHNJc000WlcxVTdnMUFGR1poeFZyOXRxMmN1VkFRWDFEMTQ3YzY5?=
 =?utf-8?B?ZVl1ODVXaWwyS052Z0VLK0tyYnpQdUVMV0hkQ0EyT1B1UythcFF2cVNHREJn?=
 =?utf-8?B?UkMzYUlkNytLNUkwbXpzbkdyU3RicDZHMHdFbURReGxhTGZVOUtSMlh3NG9k?=
 =?utf-8?B?enBUc0lCcFE1WndRbXM0N1ErL1Z4NExKQ25MYTl4WVBxZVlhL2Y3eUZVTnps?=
 =?utf-8?B?Ty9Damd0Q29XTHhJUFBUQXFFRUZFMFFVWGtJNlFqUFR6M25rWDBIWEFJNnFr?=
 =?utf-8?B?a0orNm9zZ1NIWnJPTTFlS24wVXFoZTJFdi9MQ3AyOTBHK1FVNWxuWWlFU3Av?=
 =?utf-8?B?bGQ4ZXJsdWtwdFZUd0hwcVNmQStON0t5SVpNMjlSTjlsbTF0WFNmWVZyL2VX?=
 =?utf-8?B?Ri9reGp2UGNiQUozVWRWeEJ2R3o4WGFDcjFVODh0RzRNbmtzV3Z0UCtuNGJk?=
 =?utf-8?B?bkVzbWJLQklIdmtVL3lnUXpkRm5BM0NkVnZzVU5NTlQxNy9XUmY1ZVE4cHBw?=
 =?utf-8?B?aGZzVno5U1RTd200V1AyRmhVZCtxa3hpUTNwcUUzbUpVVGMvV05DdkQraTU0?=
 =?utf-8?B?Z3UwODk4QjNQU3ZuY09sWUhhby9ZU0FWOGhtN0kyTTBvVmlySXdJM2MvWE1j?=
 =?utf-8?B?MEl4UnhuVEFZQTJkL3M4WDhSRWdQV1pFZFZQcXljaFlIbElldnVYTEFBRVpX?=
 =?utf-8?B?RWJrRm9QSkJ4NWIrNFBMSTJmVkV6MWd4YWtFaTRlUUcxdWtHQ2kyTDk2N3Mr?=
 =?utf-8?B?N1BrM1l2L2Fkb1FFalRBVEx4dGhPK3l2Wjg3K2l6cGl1U3duK20zSHpwYjdJ?=
 =?utf-8?B?YTArbGRleEJXdjgxQXlVZGlTTEdDdGxZRWZva09jZEJHUmkzUkQ5aDdSU1FU?=
 =?utf-8?B?OGFid25JSVM1MVFpbDI4UE1pRlFtVyszaTlPcHJlTjhXMHFMUjk3QXFjY01q?=
 =?utf-8?B?bFZ1UW50TEphYnltejhHZ0hib0swSmNNamwweEQ1OVRqT09lSUVPRVF0VG94?=
 =?utf-8?B?M05sN1ppdFdZTGZ6bkVNNEJBK1BUQ1QxVzhhL0ZDZTRqdENlQVVyTWNRaDlz?=
 =?utf-8?B?UmE3UjE5WUFIMXlDd291SUY5MFNxZW9TTGRqQXUxZjhNZ2hwb0F1UlpPU0Rl?=
 =?utf-8?B?QnQ4eFV4dytVeE5YSUptTW1XRnNGRytSWkhhTUthV1BNc1J5anpQVEhBM25J?=
 =?utf-8?B?Wi9lVUN0eWJmcFpZOTRneDJjcnJsOUZhYkRKRjliREtyQWcyN1Rva1NUbC9G?=
 =?utf-8?B?cE4xMVdKbHZLUjU3a0JobDBkWHBJc3orS0tDQys4amRlWFJxL3dmc3NsZXB3?=
 =?utf-8?B?bmpGYUp3KzhxMUJmY3hLR2J6QXFFcVk4akxGUVJKTUpQdnJHbHFSZ25najlU?=
 =?utf-8?B?Ym5TYWN5SHMrenR4NVBQNGdXVkFKMFFaRjU2OUVpT1ZuWEdtNmR6L04vSEts?=
 =?utf-8?B?UjZmNkcxclFzQ0RjaTlNOGxuaThIU3ltRys3N1p5WTBiL1R5VzlnNTRWRVpq?=
 =?utf-8?B?TnZHNTRLN05EVm1jblB1QTJWd0dlSkJ3ZU5MdURHbDF1Y0p4UjlWSDROeFRJ?=
 =?utf-8?B?UlNGaEU3ajk2eUs1NFhTNXVqZFp0WjdhUW1wTjNtQVd4YTRmdGdhNnAwQXZM?=
 =?utf-8?B?TkRSRUowdStOcHFPcWp2bXN6c1Bpa2RpL0VOYWM5ejdGNWFFSTJwbzFvS3Ur?=
 =?utf-8?B?enJYaGhQdGRoVTN3WkpibHhOUmxkY2dGSXc4S3hvbFI2V0VqVEd3M0VmTFJW?=
 =?utf-8?B?OXFxaHlSdTlvYTFnZHRVV2Q1bHN1T0Ftc1kyU2lLV0hNSWRYZldJV0tOOWNX?=
 =?utf-8?B?c2taMXNBWHdsVzBNN0R4bS9yL0xmL2R1Z0c5c1JKNXJ3TlFUZmR0WU11VWdR?=
 =?utf-8?Q?5Ewg3lBVODxolkMakEEQecFc4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a62a27-ef2f-4e90-5dc8-08dd93dab4c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:02:50.3726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw7XZdHGZ6UFpaDclz203+JrPjrliilhLdiN1u0TRqYiXvlRBoLbf8+iHj7VnUfcTl8DjF0do3RybHJy1lXI4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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

On 5/15/2025 12:47 PM, Nirujogi, Pratap wrote:
> Hi Mario,
> 
> On 5/14/2025 6:05 PM, Mario Limonciello wrote:
>> On 5/14/2025 4:35 PM, Pratap Nirujogi wrote:
>>> ISP is a child device to GFX, and its device specific information
>>> is not available in ACPI. Adding the 2 GPIO resources required for
>>> ISP_v4_1_1 in amdgpu_isp driver.
>>>
>>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>>> mode.
>>>
>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 46 +++++++++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/isp_v4_1_1.c
>>> index 69dd92f6e86d..c488af6c8013 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>> @@ -25,6 +25,7 @@
>>>    *
>>>    */
>>> +#include <linux/gpio/machine.h>
>>>   #include "amdgpu.h"
>>>   #include "isp_v4_1_1.h"
>>> @@ -39,15 +40,60 @@ static const unsigned int 
>>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>>   };
>>> +static struct gpiod_lookup_table isp_gpio_table = {
>>> +    .dev_id = "amd_isp_capture",
>>> +    .table = {
>>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>>> +        { }
>>> +    },
>>> +};
>>> +
>>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>>> +    .dev_id = "i2c-ov05c10",
>>> +    .table = {
>>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>>> +        { }
>>> +    },
>>> +};
>>> +
>>> +static const struct acpi_device_id isp_sensor_ids[] = {
>>> +    { "OMNI5C10" },
>>> +    { }
>>> +};
>>> +
>>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>>> *data)
>>> +{
>>> +    return acpi_match_device(data, dev) ? 1 : 0;
>>> +}
>>> +
>>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>>   {
>>>       struct amdgpu_device *adev = isp->adev;
>>> +    struct acpi_device *acpi_pdev;
>>>       int idx, int_idx, num_res, r;
>>> +    struct device *pdev;
>>>       u64 isp_base;
>>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>>           return -EINVAL;
>>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>>> +                   isp_match_acpi_device_ids);
>>> +    if (!pdev) {
>>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected:%ld",
>>> +            PTR_ERR(pdev));
>>> +        /* allow GPU init to progress */
>>> +        return 0;
>>> +    }
>>> +    acpi_pdev = ACPI_COMPANION(pdev);
>>> +
>>> +    /* add GPIO resources required for OMNI5C10 sensor */
>>> +    if (!strcmp("OMNI5C10", acpi_device_hid(acpi_pdev))) {
>>> +        gpiod_add_lookup_table(&isp_gpio_table);
>>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>>> +    }
>>> +    put_device(pdev);
>>> +
>>
>> Can you please move this into a helper in amdgpu_acpi.c?  We try not 
>> to have ACPI code outside of there in case someone compiles without 
>> CONFIG_ACPI.
>>
>> Sorry I should have mentioned this sooner.
>>
> sure, I will add "int amdgpu_acpi_get_isp4_dev_hid(char **hid)", which 
> takes care of:
> 
> 1. finding the matching isp4 platform device(pdev) using bus_find_device()
> 2. gets acpi device handle(acpi_pdev) for the matching pdev and returns 
> valid hid incase of no failures.
> 
> Is this approach okay? hope this function signature makes sense. Please 
> let me know if any comments or suggestions on this approach.
> 
> Thanks,
> Pratap

I think this approach is fine, but it would be good to get Alex's 
comments on this.

> 
>>>       isp_base = adev->rmmio_base;
>>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
>>
> 

