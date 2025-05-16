Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0121FC3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 22:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CB010E2A7;
	Fri, 16 May 2025 22:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDEuYInN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3F710E2A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 22:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU6bYGaQPikZtwgFombYqptfptqjk2zYX05jVorQQ1wJ9uNc53kB45zAfYYhrGC0vPixp9MGfFBjY95GIgbPhzAT7DzM63g1EZMUtayEMdj4YiTSlKre2/cFIoMwOFkOkPEDfgMul8PhC8Bgi8afn85/Bt2bjOrP8Rva6meG15VxXPtr6yki9EKQvGqR9JPK3cccxHhtQz49A+vKvERZjcsLvAheuBU/toE62l7Hy7VU7PkP8IVGJZH8dg3iJxJOm/oy0Gzvl0vQ3m38ONjIgaTOv9HiyWYba6iTRcdKreDbSq+/e8w3LFfcKTMhqVAXMXx1VXk6eQXtxfieltwD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7pcCQ+MwftmFpPg3AKUFzA3xUfEsedzOS5JJRfuvxE=;
 b=EG5wZaTNjc+AF9tvBLWsv3xBVdgFiwi9ofbJJnzTHwJ6xxrBbWg9HOSyHfKWFuLWw6+UavsNgdHZitCOs7LhI/lIotV8HSvGr2zB6i+HSCkVNaOzcZ6pLJ5U+vY0Ymzk/VBx01Moj4UfuwwFIfr5GLOksFILBxuYJTIP2l2d6F4PybXuFmvpdJA4qIAcBAq39wTiXIwirKxl/Ii2gX2OhO/xhfVEg/RaEK1SZPu6sHa3U2d3MwoMMGymJXTrbUUAd2v95QczMIK+kqlcYwP+dX0dZRXHF5kCQC8IJljJ1yecG117s1jFBaqDMvWS2WPSdvRTK14pgLPLy5/LQDF5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7pcCQ+MwftmFpPg3AKUFzA3xUfEsedzOS5JJRfuvxE=;
 b=KDEuYInNS1d4avpDcEBE40Z/4mSCzB9G85b/i1C2Ru+eAxxOrpWHKSPpcGIhNG9VNcg0vvivlrnb4LBawffLWFeIwXsZY+HAy3DnHsHo7UER+hJxtO9kQpCX/dYE83FSyXlj5bxlpcPsZA5CKNFeFFjBi9XoWAG4vJ1x6Lcw8OY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 22:17:28 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 22:17:28 +0000
Message-ID: <94110cef-9895-40f8-b623-c26365967c0b@amd.com>
Date: Fri, 16 May 2025 18:17:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/amdgpu: Add GPIO resources required for amdisp
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250516213126.1830572-1-pratap.nirujogi@amd.com>
 <87136b85-d0b4-44e5-b5be-4b589ccd49b8@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <87136b85-d0b4-44e5-b5be-4b589ccd49b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: e60bee23-4d51-499f-ca85-08dd94c77179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3YxMEtteGNJSlA1TkxCanZCYllLdUNDaVhsQWI3aDE5MU9YSGlDK0NsbUM0?=
 =?utf-8?B?bUdsZXY3b1B5TkRZb0hydnZpQXQ3STlYTzBMYlYzaFczdldJd1FSWUdxSjNH?=
 =?utf-8?B?bGpwRmRIN08vQkJkY25ETmhpRDdiYjZwSEx2a3prNThYd0p5cnJzL29Mc0Nh?=
 =?utf-8?B?Y2dsSnExV2pyY1FPYzNSMTZnalA5WnZMbUMrWkdoaTV4dEttVGRRVzVudjkx?=
 =?utf-8?B?c3pRc3BoM0E2R2Q1VCs4aFdtd0FVMnVVNUwwSjVaMWFmQzV4VDlKZUV4UnFm?=
 =?utf-8?B?SmtHTGN2MTRpeEVxVXBsUE1EOHNOcU9UYy9FSkVEdG52Tng3VVJrNTZWWmFR?=
 =?utf-8?B?Q1BnVTluRFpySjI5M2FYU1Y0WXQrbHF2ZGdqV1NVQ2swVUlzMjF4U2N2cXZv?=
 =?utf-8?B?WE02NXJZWGdydUE0NFdjTHMvV0FSL2ZOL0VGS1VWSE9VNldtSXZsY3dVcmxT?=
 =?utf-8?B?aTJnMU5kbmJUNUJNaWs1b21VVGFBM2ptTWgvaGx2bkdaLzlUMGVxU3dtWS9M?=
 =?utf-8?B?NDBmODFweDlGY1hKK3FiQnBJajkvbTZXa0NSRDRjU0dBNHhjalkxTW16MVpz?=
 =?utf-8?B?YXJveVRTM1pSSW5icDgrd1pKZlg1TFVWOHZncTJWMk1ZT05xV2d3eXNBUHIr?=
 =?utf-8?B?SGY5RGNBNUx2QjdBckMrSmwyZEN5UEVNV1FkejFRY1BZckExdlBXWjZISVhm?=
 =?utf-8?B?dFFwUUNhNDY5N2lrTXNTMVdlR090T2lIWDZZVUd4aGtCZ3ZSdFlaZm92aElS?=
 =?utf-8?B?YVlXa25TZitON2ZJRSs4L256KzRoMFh6K2pHMEh5TmpMRHMyMkpZMlc5UUdv?=
 =?utf-8?B?WWhnVkhRUktqSGdtdlprMlN3aEw5WkM4c1gxNU5WR3NhRGpUOVBtRElTaXN4?=
 =?utf-8?B?d0ZLVTF2cU9FMDBhaWowQk51aXdiMjhwWDIwSU9mY3BkMmZGeEoxOHdFUm5s?=
 =?utf-8?B?SjE2MU5XU25hVEh4Y0tBTEdzZGFpcjhWd3ZXQzJyODNtdTNqeTBURTdsbjlN?=
 =?utf-8?B?SXZvZDdzQzBsRXdMaHZFQlZlajUwZ0RsRkNIV1M3SFdmVm94dXRrMVdRdEg2?=
 =?utf-8?B?T1JQMzFkR3EyZk5KaHUrYjBLbUNOWDBaWGNUZkg4MG91bUR4WFVoMDBFay9l?=
 =?utf-8?B?MmoxendKa2luQ1ZzbmJEQlEvT1pmZVJKcTNLZlJ3NlNPWGxMTDF0K0VUSUJF?=
 =?utf-8?B?dkV3NGYwNEc5d1d2amE4YlZ3cWY5eXRld2IxNTdkNzc4MGNCZCtYRkdoK0Ry?=
 =?utf-8?B?VUI4Z0x0NmlMMENKaWxnZE9pZnhydUxudUd3YlF0SWJuMlY5Tlh6UjQ5SmJT?=
 =?utf-8?B?SFBuVjFNNVlKVGxLYThCL0dVRHgvV0RmallpYTEzN2syMFlHMUo0bGl0dzNF?=
 =?utf-8?B?cDd4eUoydzlYelFkd0RDR1ZyQU12a0hDUW8xUkRHcjBNbkltQnJpcEduWkRl?=
 =?utf-8?B?MGdQZTJoUzUxWm1qekNiWkVjSStBWFYvbVpoOEQ5RzRHeE5LZ3M4eUF0a1V5?=
 =?utf-8?B?a3U0blFpTmFSNEZQSjZYU2kvbGF3cWo1QTZ1UWhpVlhDanNkNjhQejFPRDZv?=
 =?utf-8?B?d1UrcmZzRnlNYXR5cTBWa05MeWJYcGZERmZiNVFwSVo0UnY3c3FucGIrMXlT?=
 =?utf-8?B?Mk1rODhoM2t5VjJ6SW1hNVFlbEdacnp3aUhLN1Rlc2xDNUgrNG9KaEF6Ly80?=
 =?utf-8?B?VTlabzJyaTJwcCtNSlAvaHlUMzR3TnhodU5tUDNTNk5SVktTLzNYaFBINndY?=
 =?utf-8?B?R0YrUWV0N2Q5aWJidDNtYUU3RWJOYTBKdEJiUjhvcnI2UWU2OUtURDlwRzBt?=
 =?utf-8?B?VkRGMXpqdjRUL3ExT21CbXJTVFFhNXBBQ01QN0IwNWUvRnY0bG5PVG9IS1hl?=
 =?utf-8?B?R0xjTExVQlBIeXJCSzZWdnNZM1oxZ2grMGlWQTU0VWdkVm1wcUhBbFFGWlpa?=
 =?utf-8?Q?NVHGtfhrF20=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFPMEVIR1RYMno5L3BXQmlDVlVFM1ZnZTJLREMwWkdJRENyQnV0MVkzVXgy?=
 =?utf-8?B?Zm03MjU0cUQ1VnY4TERzdDhVRHI0SHFHY1hNdzkzbUVXVmxyMktyMXlqZEI2?=
 =?utf-8?B?RlhrVmJtUzliVlhVY2IxUXphN3BWTzF3OGRveDdNSXYzSWZnYTdmTEUxc2sw?=
 =?utf-8?B?VFdrNUZRdzh5QWhNcWNIU2dzU1VUcm84MTQxblJSS3AvYW94WnI3TS9xOTc2?=
 =?utf-8?B?ZjFPb0dvS2hCMjVJOVBQWlp0eEkxeGZqOWJrTXpHeVF5QnpZc2ptVmM5bUVX?=
 =?utf-8?B?Ky9mK0RGdU5TcjRSUHRmNWloSWNUWXNUUHJtRmlsL25sSXE0QlF1WFJUMVUx?=
 =?utf-8?B?cUxaV2pvc3l5WWMrY3N0cTFYb3Z0QWJTdzJUK1RXbHJUWjA2MFZhZTlXZi9x?=
 =?utf-8?B?WFUzN2NlblR0V24xN3B4cTFXaGprN3lubXdaY1NxenI3aUgzUUE1UkVCdGxz?=
 =?utf-8?B?R1Fwc1RIVEM4N1ZNVmc4Y2V2WGZjL2theHAvSm5JVE4zZzM0RS8rYkc4NXBy?=
 =?utf-8?B?K2NCOXk3S3hJbzRUWmdrMmRaSUx6OEFvUU1rTGFBSWZtaHFkNWFIR1Nndnlv?=
 =?utf-8?B?N2VDOHhERUJ1WFBBRUo3ZS9qZEhNWVpXNFNNSDNYK0dvSVZxM0FrZHFMS2Rj?=
 =?utf-8?B?RkpaUzJwakl5WFhXL1lBdzF4TEdUcEpwVzlDUXdaOXZ0MjNLOGppL01OQ2ZY?=
 =?utf-8?B?NGRUc3gvLy9mZkJpZGowdEZNdlh6cnRveGlVK0FxdGsza0R5SXBNblhkYzBy?=
 =?utf-8?B?ekxhSUpzNGM5NlZHMW5xQUtMS3pweGF4ZDNjbC85YUpOWVhkVHVILzBZS0pT?=
 =?utf-8?B?QzQ3dGRkTFFqUjcvbnZwVWxXLy9ZdHlZZnlYTmhRdFBxWFprVGptcnNLalY1?=
 =?utf-8?B?NlZrS2MxZnVkN2F4STNLU2FPZVYyRVJqRGhNTGJmMmpoSXFqTzBqdGV4aTV3?=
 =?utf-8?B?WHVOL0dhZWZJcUZwYzZqa0o2Z2hoYlAyNmthREM1TUEvS0k0ZGdsZ0FxVkcw?=
 =?utf-8?B?MWFMUHVBTVIzVzNRbEttNTNFK1lEUzNaU3BtWnk1WGwvK01DbEM5SFNDMjV2?=
 =?utf-8?B?d1hFb2p6NTU3NHZzU2F6WTE0NldpSWY0eW1ST0RpbzYycjZrbUVRemF5VmIy?=
 =?utf-8?B?cHh5Z2M5eEwveHNyN0lMZ2dyMmJCa1VjWHNOdGZlZ3plNWRta3F2NjRmWmNu?=
 =?utf-8?B?SVpXRmUrTGlCWUZhZDQzWmQ5Y3QwVzFRTDNicjMwMmF0SUovZHpGVFVmb1M3?=
 =?utf-8?B?b1o4bm9TMnhmV0N4VWRRWmlJME1DUld1emNLZFllMVFqTFdiMmE5ckJSQVVG?=
 =?utf-8?B?VWE4a0hXbWt0Tko5U3F0dndiQTkwY214aVJ2SXY0N0JxNkVwUVpGTWNWd0Yz?=
 =?utf-8?B?ZmkzaDEwZ0JtWUdsMDMzNjVNTDVlUVRDZWJzMjNIRk5mZmxObUFhUVVqNWpL?=
 =?utf-8?B?Ti9ad0h6bm9LbmdvSjMyczZObjhLd1V3UHBYVFRUczNPd0d1VkVyY2VEc0Z0?=
 =?utf-8?B?MUwyNUx2QUs4bTJma0JvUmJBclhLRkcvYmQ5R2p2dE15K2d5UTB6RWtzK1Fv?=
 =?utf-8?B?dmV5RnlSYmdGL2huOTErcU5oVVNnNmRXbTJXaG5Kd2RGN2U2Z2Exak5iRHMw?=
 =?utf-8?B?NjB1dWRDRENjWUtibE9hOVptQUVGenlNWUs0M2NCcndBSFFGZk1SUW9qTXB2?=
 =?utf-8?B?bWJ5R1hkNDRVWCtTSmJ2bWlDdG45VDVYQkRSbnZ3ZFpzSGJ1NHJYVXA2WHhV?=
 =?utf-8?B?SkU4TVJQd3BTQU9Vb3U2eFJzUEZ2NTFkcDFWRkEzZW1Vc1pvMTVvM3F6MmZS?=
 =?utf-8?B?K3k3V2hXUUMzWkhPWU4wWDFjSnBDZm5vQkRMWjBFTWM0YWdweUVjdGZna2Vs?=
 =?utf-8?B?WXVhRmpDRk9rbWp1WG8zaFpQUEh2S1pNb0VyWFNka1FFdyt0Y0Fmb2d6a1hK?=
 =?utf-8?B?T0ljTnJXdWxlYlordE9HdlpIc0E5eWRJdDY4NDdEcFpjS0IwWk1vRC9kd0x4?=
 =?utf-8?B?NkpPYUI2UURUeWV5SVVxWlhaR2RneGZlS2xhRjYyV3Y3Z1FUald3U0NGejBl?=
 =?utf-8?B?MEpnekJId0d6NVhZeVVDcFZrOTUzWm5KVTBCRDZIQ2crYVUwMVBBUjFXTjNV?=
 =?utf-8?Q?2/3HhF1ayquicq/bL5wzi5f1w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60bee23-4d51-499f-ca85-08dd94c77179
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 22:17:28.1688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MI7eMCIJIZH4Bgu2TFoh4R0Sig+R6hv6aNUOO8R2IOkZmY21QkGVg8NgrjU+L9iOvKXA32wtpbl7pqztO5StA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

On 5/16/2025 5:38 PM, Mario Limonciello wrote:
> On 5/16/2025 4:31 PM, Pratap Nirujogi wrote:
>> ISP is a child device to GFX, and its device specific information
>> is not available in ACPI. Adding the 2 GPIO resources required for
>> ISP_v4_1_1 in amdgpu_isp driver.
>>
>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>> mode.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>> Changes v2 -> v3:
>>
>> * Add NULL check for acpi_device handle in amdgpu_acpi_get_isp4_dev_hid()
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
>>   3 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu.h
>> index cc26cf1bd843..2aa7e89a190e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1657,10 +1657,12 @@ static inline void 
>> amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>>   #else
>>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev) { }
>> +static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
>>   #endif
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index b7f8f2ff143d..78441d5f3231 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1551,4 +1551,35 @@ void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev)
>>           adev->in_s3 = true;
>>   }
>> +static const struct acpi_device_id isp_sensor_ids[] = {
>> +    { "OMNI5C10" },
>> +    { }
>> +};
>> +
>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>> *data)
>> +{
>> +    return acpi_match_device(data, dev) ? 1 : 0;
>> +}
>> +
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
>> +{
>> +    struct acpi_device *acpi_pdev;
>> +    struct device *pdev;
>> +
>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>> +                   isp_match_acpi_device_ids);
>> +    if (!pdev)
>> +        return -EINVAL;
>> +
>> +    acpi_pdev = ACPI_COMPANION(pdev);
>> +    if (!acpi_pdev)
>> +        return -ENODEV;
> 
> There's a slight problem here that put_device() isn't called in this 
> error path.
> 
> Maybe you can use a __free() macro for struct device *pdev?  Otherwise 
> you can jump to a label above the put_device() call below.
> 
Thanks Mario. Somehow I missed it, will use __free() macro to call 
put_device on exit.

Thanks,
Pratap

>> +
>> +    strscpy(*hid, acpi_device_hid(acpi_pdev));
>> +
>> +    put_device(pdev);
>> +
>> +    return 0;
>> +}
>> +
>>   #endif /* CONFIG_SUSPEND */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index 69dd92f6e86d..574880d67009 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -25,6 +25,7 @@
>>    *
>>    */
>> +#include <linux/gpio/machine.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>> @@ -39,15 +40,45 @@ static const unsigned int 
>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>   };
>> +static struct gpiod_lookup_table isp_gpio_table = {
>> +    .dev_id = "amd_isp_capture",
>> +    .table = {
>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>> +    .dev_id = "i2c-ov05c10",
>> +    .table = {
>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       struct amdgpu_device *adev = isp->adev;
>>       int idx, int_idx, num_res, r;
>> +    u8 isp_dev_hid[ACPI_ID_LEN];
>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> +    r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
>> +    if (r) {
>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
>> +        /* allow GPU init to progress */
>> +        return 0;
>> +    }
>> +
>> +    /* add GPIO resources required for OMNI5C10 sensor */
>> +    if (!strcmp("OMNI5C10", isp_dev_hid)) {
>> +        gpiod_add_lookup_table(&isp_gpio_table);
>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>> +    }
>> +
>>       isp_base = adev->rmmio_base;
>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
> 

