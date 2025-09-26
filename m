Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47F4CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 02:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA3210E9D4;
	Fri, 26 Sep 2025 02:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MU7opI+a";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5882810E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 02:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxFMLT1/uwhdlvFkm/je8Ojc5YAFPm3Hz5lUFaV2TgxuKEW5hsiW3e4oDLNpZYr9C9cm1lcGhQUwy286kYNU9cgv8/CJkPZZtShRKO9b98HEn2iO7d5BXqL33Cq89BegP11awGu0mcuqkKpr46+ZBb5e+ead6dGHMsElnqB08WIA44ZQHrHRi3z4IQbN3qdCYDD2sKRkTxpEJKwWycxp0DRFNKBBegB/NeV5yY93cze1uNJfzp3FZ1qY9kwJtkdYWtxmiqqjhQ09tmQjSKx/WsPA3eXa9PkiarzC8xl1MnRQr6wcgMDG8v+pkmshPTjJBPXsrkIDQ7khk7sDqcfE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIHqnLDEzgFkFHlfnrmJXQUZmMOBsE0ltcy3xgTwp18=;
 b=swpFgdYokvYHOf8qyn9VG0JU0vYvYsfKAsYmCVcUFiOSi36664oEIyO6NeeHVADvltAbt7XVsnezRN83bauppaKWLErhB8ewbfPQwm722LsheaG0ravuPmvIEKzFQycLwKFWl8IgoWnYP21YVx/0CG9oLegzSxSor71p5EGcxdUwSxkU3uGLa7hXmaDvzoL7sehyWVsYjDbH3hhPvKolohsxrHSWlUyOYZd4/82DqD2ehKvnfQbSToSw0fnVGl3jT2Kq36ubYzZHo+8VYLSOPRzrVdioLwa3AH6EO9KWRzOM9bTLGQQJEGitfQwEjgSm8l5jPKH3XgpVX+cWQI8gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIHqnLDEzgFkFHlfnrmJXQUZmMOBsE0ltcy3xgTwp18=;
 b=MU7opI+aAKjZCgbKKK+GAT6bpfAZKIkYjW6KdHbOX6gnnaLiznjAt1iXnXq5nysvQbyYlEmpm8hL3k8UW1JPqqYiC4aUTbK9kL9l25ERm8UKI7EczkOGSj/n83BZcpoOFbnC2zJT4xbInM4hsk4GcyxUi8lAW0SKxQ1D5kJ/M4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 02:51:24 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 02:51:24 +0000
Content-Type: multipart/alternative;
 boundary="------------7920WA7jz0YhGK911pDel48w"
Message-ID: <2cd3a73a-68d0-4606-b02a-2745d8a653f0@amd.com>
Date: Fri, 26 Sep 2025 10:51:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/18] amdkfd: record kfd process id into kfd
 process_info
To: "Kuehling, Felix" <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-15-lingshan.zhu@amd.com>
 <c0997b76-e9ab-4c03-a2ec-16f39de2ee59@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <c0997b76-e9ab-4c03-a2ec-16f39de2ee59@amd.com>
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: e405ad71-9a87-4001-b7ac-08ddfca794c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkZFWnd6WFhqcnMveXNYeDlRbWpCLy9NMDhXcDFSVlJPWHh3NnF3dGVMemJk?=
 =?utf-8?B?MGN5ZU9yeTVuQTlIWWFpMnFFeDZDRlViNUlQeGZnYVAxVGYwWWJkanZ6Rmpp?=
 =?utf-8?B?VHhXaHBLVUhqbUg3MGdDd0NPTStkZmFQQUkzRDRBSUdoQmhDbFkxRThqem0r?=
 =?utf-8?B?NmhyN05IdDJ0azRiS04yUm5FVzk5T1ZnLzhEYnlZS3RCODZTdTF3NGhibVJt?=
 =?utf-8?B?eGtPaUJIL0FyQTE5N1NHQVB4aFN6OGxQWUw0NWN0akttSEJMemxlcmZkeEpZ?=
 =?utf-8?B?NzU4Z2FTaFJhRFk5VUJabmRKT0tqbklaWWNDWjlEc2l5aTR6eEI3RmZyWjV5?=
 =?utf-8?B?N2xnWC80emtleU44ZXIxRVhYZTlsM1cyUkZzaXdwTlp2cFowN1p5UHRpRE5k?=
 =?utf-8?B?ZlpNalFULzVkTyt4Zyt1SHZiaDJORC80RTkwYmJyOVNuZGcwZjdsSWw0UGMx?=
 =?utf-8?B?b3lMK2FFZHZXV2p2U1dEZ2t5ZlArMktPL0VMTDZwU2RaRmlEYW5QTVhDZEto?=
 =?utf-8?B?ZjN3dGY3elBnWHZWY1BUZkx0WWlhY3gzNnVweHBhdnFtWjkzell5cU9sWENO?=
 =?utf-8?B?VVQ0d1FlUmJHUFV6ZW5rdVhQdEV1aDkzb2t4U20rdXJDNEFpTFI3OHFyaldD?=
 =?utf-8?B?MUtFcWtnaTBLbzZXRDhUSVV6VVZnYXlOSXdxU3BhOFRSeG1RZVBkc1dLR0Vt?=
 =?utf-8?B?V2tnV3FBOTd2TVlxTFpERTJ3ZE9Ialpocld6VFAycjk2cGhtVFBCTFdZYWsz?=
 =?utf-8?B?Rkh3WU5tRTBEVDdLaWVIQXFKOHpBekdITnRoTnp0a01SVDB1TTFQd0szUlA3?=
 =?utf-8?B?VVlLeU95UTlEUFlWaUNpSDV4OU1mM1dyUU9mVXlYamM1YnduT29wZTdoWEdL?=
 =?utf-8?B?S0ZCYmhscVlWNGp6QitzbjRtTXN1M1BMT2pmZlAzZ01xdTVzQjFHRmxvOFk1?=
 =?utf-8?B?R2o2czduQzNqUTI2ZDRrNFlVK0orYVQrMk4wdHFJdnBKdkdzMWlzNW5wMHQ4?=
 =?utf-8?B?MDAxaHFiSzhHbEZWdmhnSXRQdnRRdGdoUFdrYVpORUU0Sjd3cmx0eFM1aEpJ?=
 =?utf-8?B?OWV3WkNCS1RBNzFyNjJ5MElxNExwMk0zTFVxZWFSSVJJMER6bDN6RXlobXNL?=
 =?utf-8?B?T3piUDJjRzhSSkRGWEZxUXV3aWlmS1IwZFZBanZRZW5KUnVtR0haK0xWVlkr?=
 =?utf-8?B?dzd5VXV4cllnWU9JQjlLOHdKaW0vRmZBbkVNZ1ZYbk1ZWG5oV3pJOXpLRnlw?=
 =?utf-8?B?VmpLZ00vZlpSWGhMR09WT0ZhamZOVjdkYTE5cVVXRmRwWUNzOVkxRnVSSE9j?=
 =?utf-8?B?RjdRN3FsNEFTckkxUFNjWnpHWDJRckF1V01RZVJLWlBUT2Y1eDBpRTZrNHk4?=
 =?utf-8?B?SHNXbGFEbEp2Snd3TkNid1V3QlhFa2ozdkRnZ1NFbWJ1Zm1VY0FDMlNDZXNX?=
 =?utf-8?B?S0JBZE9hYUhuaUwxWGsvS1MyeEhaQ2RqbHQwRFFCRzJzcmtMTnJUZ1VEWm9z?=
 =?utf-8?B?U05tWkE1Q1lveUcwczhsb2NHSnloYlhYUFh4bjBGSEdhL29NVUJqaGFkSUhR?=
 =?utf-8?B?VUpYWStaNG1lTVpGZ1RTWkVnVEMzVHJpMEZOc0h0bzF2N1ZoejcrS0k0MHZD?=
 =?utf-8?B?THVOcm9hMTZ6UUxuNDQ2M2UzR05MMXdqNzJNVDBWWGlsTEVtNXdnMk51RFh6?=
 =?utf-8?B?RkNRckZqQmdja1p3N0xkckZIc0JvU1FDWit0U0RkMmFtbVNTeGRTaWtvZUNI?=
 =?utf-8?B?ZFR0WWg1eTlLem9TdkdiNHVLUjZ3Y0xFYTVSUWdzcUg0VmJiSi8waWFBZWtY?=
 =?utf-8?B?NEZva3VYYTg2YzZ2NUNOdnVGMEJoMDVPSGZ0V2trTzNVNzkxY1gyUTkyNzNW?=
 =?utf-8?B?WkEzd2RTSFhtdnljZkVDV2dBNkNPcDNLMDRKeFlmQ3VhNHhJNmZ4YUdwQmwy?=
 =?utf-8?Q?Ousrrod5F3EU0kGCMrznGDWgR7wo3k9Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJjdlBuTVJNdU9aZkZqRVVvR216d3Z1akduUW9NNTVESGJUNFRDMVg4emNJ?=
 =?utf-8?B?ZlR6SXBiekhCTjhKSFh2dHFqVlo5dGMzeFFEMStSa3Z1aGg3TVpVUkhQcnkx?=
 =?utf-8?B?Sy9CczVBYlZrVzFScS8rV1UrU2thQnQzejdnZVBuMmE0ejFtZVRXYkNXSEFF?=
 =?utf-8?B?NjdoTzhHd1RVMXlORjA1T3RibmVyVkRtK09jd3JSTk9YMkFMRy92RTNqUURS?=
 =?utf-8?B?ZkYxRmtXY0tjUjRKdHFiNnJ2dDVNNFptUnhuU2FjWXNCQmN2azY0cEFxcXJJ?=
 =?utf-8?B?dGV5aFZPa0VJMkw1U2pZRk8vSGViYzIyRkhDTVlGbGNpMk0rOW03YmZwU0pW?=
 =?utf-8?B?T2ZDY3F0a01DeWhiOC9DZUlpWm1iMEcrOENNK0RvOHZDcENRSFFWVGVobk5n?=
 =?utf-8?B?T0ZjazFMdHJYUGw0alBlUm16T2s5aEpSRFZSaUVQQzNGblAzUEd1V2JtOEJk?=
 =?utf-8?B?VXc4ZVdXWWo2R052TjFnckdrVXluNlEwMjlvcVc1OXpZM3o2cDFWeTZkVE1B?=
 =?utf-8?B?Tlo5aHF2aVRHVVFFblN1WWRlbzBTME14THpQc0NMU1RKcnFYMVZkVCtsRlV0?=
 =?utf-8?B?bXkvaEZ2emNPZjdiTzRaK3UwYjRkSWcwRTRhZ1V4d1NOdEx3L2JBNnMxVm53?=
 =?utf-8?B?VTA0U29JSEhQTis1VnN1N1MxTUpRUlNCbnVoZ2hucWVPRzlhenJWNG93SVJR?=
 =?utf-8?B?ZVhjK0lOZ0tkNHZEYUZqNkFVNXpVMXVPbCt0QkYwcTE0NUVFRnk1ZGt4U01i?=
 =?utf-8?B?Qjd5QnZtayt6MzZTU3NGNHc0RzNuSTNLSTQycXBwNlV1c2lINm9yd2lqcnBy?=
 =?utf-8?B?UUhYTmdsb21BbFdQeWZkNmpWcC9mRmIwZEJoVTM5MFVaZlB4TTJwOXNjM0t1?=
 =?utf-8?B?d2hCZUpZZXNrZ2VOREExbmV6amlnSXB3TGdVekVURFZSWFpKTmNXclQyc2o3?=
 =?utf-8?B?Nmt4c1BFQ0NIcEFwK1hrQ0RmUExWQ2lHd1cvZ2hGcUY1MnBKM0FSeHFvZEc0?=
 =?utf-8?B?bnJhZjk2dERya3RhVVNKL05mTm5GakFHbWg2Y1V1bGtWbjdKbDlWS3RaTzhJ?=
 =?utf-8?B?T2Nad1BybWMxT1dqaXpacHJKU0lXbGl2cmc0ZDFiY1V3YS91dGZ3QWF5Smp5?=
 =?utf-8?B?K3ViemdKUkpBbEtQQVpuR3RwZVRMYndaVWhLeGZ4Tmk2YzJMK1RoT0JabGp3?=
 =?utf-8?B?WGlOQ1dFeStkdENsNTJ5K014MVA1bHNsakRXS0tEemw4eXBOSjkya3IvWTYr?=
 =?utf-8?B?M282aWRVQkJhaXJUdGpoMFNrYUNYV20rc3luSUxMc3NSMXJrU3JIdmRxNjZ3?=
 =?utf-8?B?cGtUZDhYSVVEdldmY3RzUDd2ZlhsY01wbzFTTkl4MFJGdmZMWG95UDFVK2RH?=
 =?utf-8?B?Um5jYUFTb0p5MkNKZG9mcjVWbVQrNmlrQ21TNEdzZEJNNko1V0NsdXdOZURs?=
 =?utf-8?B?MTg2VXhndEhldHZmNmF2bWhvTm9zMXRPQXM1SjBkazZoVmZ4cWJOcm5Dckts?=
 =?utf-8?B?MG5iRDFEa0NWQlFXK3MzMk9RZGRyWnlpYXkvcDhySnE2WVlnMVRTdFhVcGxF?=
 =?utf-8?B?VmttelFzUWplK25EUXZYR0EzS3BLcnRIdlhWZGduVENjNHZQV0sxVkYveFpZ?=
 =?utf-8?B?eWFNL1BjNkYrNURXdjN3T25iUnJYbU9YbXZOc1lhQnFLUEtSQVlKamxCU1kw?=
 =?utf-8?B?czJXYUFiNjcrbk1yTE1Zb3M4OXorU08yQlcyd3JOMzg0UnBWODdQL2FER3VE?=
 =?utf-8?B?T0o2SS83NlpqRHNvVkVCQnZtZDZucEovREtIbUxlRDhldkw0QjRCL2prbXRQ?=
 =?utf-8?B?b0NyQWFCNXh2SlduaUxRVlRwb1FGWjU0c00xV2p6NjB5Rk5BeVBWRlhFMHZW?=
 =?utf-8?B?dWlNOWVmYktsRk9OTlVyclc2QjBRQzF4ZkpTbURxUFVXUmdudGJsRnRXNGty?=
 =?utf-8?B?NmdFTnBxOXVWVDExdGlsaGZDWitHUmVwU2V4dmhEVUEyeVlWNld6aFd0bzd3?=
 =?utf-8?B?bVJMUlhJWmluTVIySGlHVFpJN05EN0pxbXV0MjVKL1grdm1Zbi9GcTMrYTU4?=
 =?utf-8?B?TFRET2N5SnFMME12K3YwUGJxMEIvc3M3STJRSE1nUFc2S0xtd2dER2tma3BV?=
 =?utf-8?Q?7qsGPYaQCn5sEX0h3RiybYAXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e405ad71-9a87-4001-b7ac-08ddfca794c3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:51:24.3330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr19d2kdV/gR1HzcUFfgnNk+Mfx56UOtWV9m/eUkjLsiWoMODZK/V8SWytQC5fQWHtcF4RefFI7xmDW2LPVuMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

--------------7920WA7jz0YhGK911pDel48w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/2025 5:45 AM, Kuehling, Felix wrote:

> On 2025-09-23 03:26, Zhu Lingshan wrote:
>> This commit records the id of the owner
>> kfd_process into a kfd process_info when
>> create it.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index aa88bad7416b..d867984a68da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -146,6 +146,8 @@ struct amdkfd_process_info {
>>       /* MMU-notifier related fields */
>>       struct mutex notifier_lock;
>>       uint32_t evicted_bos;
>> +    /* kfd process id */
>> +    u16 process_id;
>
> The name "process_id" is a bit misleading. I would prefer something
> like "context_id" or "secondary_id" to make it cleare that this
> identifies secondary contexts and has nothing to do with the PID.
> Maybe use the same name in struct kfd_process as well for clarity. 

I will change it to context_id, Thanks!

>
> Regards,
>   Felix
>
>
>>       struct delayed_work restore_userptr_work;
>>       struct pid *pid;
>>       bool block_mmu_notifications;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index b16cce7c22c3..723d34921c12 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1382,8 +1382,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm,
>> void **process_info,
>>                  struct dma_fence **ef)
>>   {
>>       struct amdkfd_process_info *info = NULL;
>> +    struct kfd_process *process = NULL;
>>       int ret;
>>   +    process = container_of(process_info, struct kfd_process,
>> kgd_process_info);
>>       if (!*process_info) {
>>           info = kzalloc(sizeof(*info), GFP_KERNEL);
>>           if (!info)
>> @@ -1410,6 +1412,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm,
>> void **process_info,
>>           INIT_DELAYED_WORK(&info->restore_userptr_work,
>>                     amdgpu_amdkfd_restore_userptr_worker);
>>   +        info->process_id = process->id;
>> +
>>           *process_info = info;
>>       }
>>   
--------------7920WA7jz0YhGK911pDel48w
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/25/2025 5:45 AM, Kuehling, Felix wrote:
</pre>
    <blockquote type="cite" cite="mid:c0997b76-e9ab-4c03-a2ec-16f39de2ee59@amd.com">On
      2025-09-23 03:26, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit records the id of the owner
        <br>
        kfd_process into a kfd process_info when
        <br>
        create it.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
        <br>
        &nbsp; 2 files changed, 6 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        index aa88bad7416b..d867984a68da 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        @@ -146,6 +146,8 @@ struct amdkfd_process_info {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MMU-notifier related fields */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex notifier_lock;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t evicted_bos;
        <br>
        +&nbsp;&nbsp;&nbsp; /* kfd process id */
        <br>
        +&nbsp;&nbsp;&nbsp; u16 process_id;
        <br>
      </blockquote>
      <br>
      The name &quot;process_id&quot; is a bit misleading. I would prefer
      something like &quot;context_id&quot; or &quot;secondary_id&quot; to make it cleare
      that this identifies secondary contexts and has nothing to do with
      the PID. Maybe use the same name in struct kfd_process as well for
      clarity.&nbsp;<br>
    </blockquote>
    <pre>I will change it to context_id, Thanks!</pre>
    <blockquote type="cite" cite="mid:c0997b76-e9ab-4c03-a2ec-16f39de2ee59@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work
        restore_userptr_work;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pid *pid;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool block_mmu_notifications;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index b16cce7c22c3..723d34921c12 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1382,8 +1382,10 @@ static int init_kfd_vm(struct amdgpu_vm
        *vm, void **process_info,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **ef)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdkfd_process_info *info = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *process = NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; process = container_of(process_info, struct kfd_process,
        kgd_process_info);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!*process_info) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info = kzalloc(sizeof(*info), GFP_KERNEL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!info)
        <br>
        @@ -1410,6 +1412,8 @@ static int init_kfd_vm(struct amdgpu_vm
        *vm, void **process_info,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;info-&gt;restore_userptr_work,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_restore_userptr_worker);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;process_id = process-&gt;id;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *process_info = info;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>

--------------7920WA7jz0YhGK911pDel48w--
