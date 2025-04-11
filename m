Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F2FC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 04:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9979310EADA;
	Fri, 11 Apr 2025 04:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jn6cPjnT";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0B110EADA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 04:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0aqTXpEFpbwq7BVCFP/PHtqa6odqWrQ1E/lTCz0uTmEAPcxTnj7XRTlP9wUZiCUWD5FoBYYczAufOJNq0b5Al1JDSBoR8PzY3oAtHf+0ydneCJuXu5X8F0EvjuPiTZHfkZX+QVN0BwvAjonPGoZBsiEFRGPAkO+tgdcfGi/Ou4cVisZTZkdh8j0OSn+0K/vqXE4hggUlHi8VQM8kswTMUNI+kwJLr/l8HI7O3vsrVqzUNSuw6IiR+J8wR/J60cpADXFAvziUvWR9Nhp9mcrVYb04u15+UOWl98dtclg/5tEJQJMJ8c7MvvPhya1Rm4MQgJ5Adal0NBUbQMvUKQnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym5J09aWaPE7xBHTUTf0ILnFc/yGYgbXCQjUSZUvqf0=;
 b=iWEiye193NK+Non5XqbVT9horT+AIcAEFJra8GsPjeLhuIgdCjkW2zOq3gqNvY6jo0/IWtsaJd/02z3ZyOKFbdPRTiWgY6DdwyG8ZWTaDGf34JT9cVi8O5JZDD99ClcTP1r8Pkp7KA9INj7eUZ21ruZqpbVoHPM8T/B941gpBOF4GYI1z/45EW1P6VSBGRTyNZH4U6vYrBr4Vj2lh3iHogzzCDMVL7FdDDv9azRw1T9pCIYfQA3ZHvH/ZUI8JZETa6cKSgWPoVNFGZiktg5mdxMwAiXeP8enqzcTA+e3mNT5ioJN3QYa1C/m1rqe3fbCITPsnPWPzPMjoOi6M/hWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym5J09aWaPE7xBHTUTf0ILnFc/yGYgbXCQjUSZUvqf0=;
 b=jn6cPjnTb+JYgSRdXcI9zOAGjHp8Ph8sJn9kU9xZDfIR4ZhTxcz/BvR2Nkmc6L8uhfeF5BzqLmWKQeMUD4BrEP234dXPxjOOS1Tw1wfJ2awRzbjDcBtRjE9LUezdafYMLEKYCnrdZE3m3SuSEIEOQw3Yl0/OfvxqlN9pqowYI8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 04:54:08 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 04:54:07 +0000
Subject: Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, sunil.khatri@amd.com, shashank.sharma@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250410145750.51421-1-Arvind.Yadav@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <204b9b11-9045-d180-927e-ba1cb015b368@amd.com>
Date: Fri, 11 Apr 2025 10:24:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250410145750.51421-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: d18ac159-c969-4361-7b52-08dd78b4e416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUxKSmJIRG5WRG9UOXM5Mk84b2xodkRGaTIxeDUzUnB6MDlIdWw5dTYyYTBx?=
 =?utf-8?B?bXcySGQyYzNRb2lwS2xUVzBwK2Q0OHJVWGUvaFl2enlnc3pNekkyV3M4YVhB?=
 =?utf-8?B?S21QakdxZVQ4MFVjRWo5WVJwVk9QWVF2dWpMTU5Tb0ZUbkVpczN3TnAwVU9D?=
 =?utf-8?B?S1Q1akFzNkRaMDhDM0RhTGpKSDRkVEJycWMzckFXZ0NPSXlHc1YzY3MxbFZK?=
 =?utf-8?B?anBlTWo1OTg5NlBkbkZ6U2ExaFd6cFBuU3ZrcW5BdlVETkJ6QTg4MnZaMFIy?=
 =?utf-8?B?b0QxaWZLYllBQUdFanJZSUQxaFdYU09EQWExR2lxaHNnZW5tbXlIaHhXVCt5?=
 =?utf-8?B?WW5lQ2xob1NiVHdrZjN5TnRKVUtPS1p0NlRzWXZwMU14dno1RExrNlFEb25W?=
 =?utf-8?B?M3BIbWNpVTFZSFNiMVNVSTRrZm1BeUtoWlBub0hZOHlsNWl3bDgxVEhJMm1n?=
 =?utf-8?B?cE9aaGMzTUwwakdIMWZiMHZrcFJMK0dDMXVGUU1lMjM5dHNMV3NYZmZ2RFdZ?=
 =?utf-8?B?SzZwR25EMWxMR01lUHFTKzdsSWhITmozdGZJNVVqSGx3a2ZyY0ZSZzUyd2VC?=
 =?utf-8?B?NTVvampJNmI0T2htb1lzWmRHelVYeW5mZGcwUU9mNllSQ29FV1QvWDJDSUd0?=
 =?utf-8?B?Y0o0OW5ONWRrQm1vRXJKNjJTZkhZQlkrZWVNdkRFdmRxTllqeVNNMERuZDRl?=
 =?utf-8?B?c3d5amQrRCtqS3RvV1JXZFlSNWN4ZlhLcHd1Zm5UOUNyeGZvQWJjdVhSWWxr?=
 =?utf-8?B?MjV3L1BPMHJScXdZNG1SbmpxKzVYOU12NGJydFVnR2RzTm1FeGhrQmZjZG9K?=
 =?utf-8?B?Y2hWc3FqeDhscVFuNmpJSmJvWHk2aVBiRDZtU0J6Q3o0bVJGbk11eEpqcTU3?=
 =?utf-8?B?cEJLTGFUUGJjUGQ4ejhobEFRdnp0UXZteGxNN3R2RGVmTVpKR2ZDSGc2T1JS?=
 =?utf-8?B?MDhBaVpxNEIySUR3a1pjSm0xb3YwR0dHU0dsa3U2UEdSaGRlZTIwYUJON01N?=
 =?utf-8?B?WHJlNlV5ZFk3QWk4cWh0SHA5QVVWUFFRcndMZjRKZHVaemR5ckd6YjRldzdZ?=
 =?utf-8?B?bVZqSGZDYjN6UUt1Mzd4c3lNY3NGblFpaHJKNzhPSk5UTFZ6QnQ1cURZOTZY?=
 =?utf-8?B?OCs2QzFSYkJjUWUzanhaMEJ6bEdWUzVvZHlrNEsxeEttZjRyU2prd29nT2hs?=
 =?utf-8?B?OXhGdVFkSGNpVmpKd0NiMTNmeURuSnpMZ2ZUbWpQM1IyTWNoN0lXT1RCZzQ4?=
 =?utf-8?B?SlRkRjRoNDJwbmFhOFdPdFhIdUtyZjkyTlZ6TDFmSXBXbnNTRmd2UmpwWEYz?=
 =?utf-8?B?Rm40UGJtY1lKMHNRckFtSE52bkxCVUZFY3BHQVFwcEwvVlR6L0NQNWxsVEFD?=
 =?utf-8?B?cHpHS1dqRk0wWXFyRVBzR3p1NlQvQndNbjlzYjd4V3RsRlVCeGhPdGI1YXdI?=
 =?utf-8?B?MWZrVjJpSWViOTMvU0V0ZDVnNzVtMFJtTUYyTFhpdFY1Tzk3QkdvRmdEVjUz?=
 =?utf-8?B?U1NSc2lnUjA0M2lNbmFxc0R6UElSNnVOVThvNnBBY2pLZWJidzNhZXpOMkZF?=
 =?utf-8?B?MDY3YThMZ2JiTytXNXpjNlJiTHRJRzV1OFJ3Q0lpY3VaR05RYVFNUEpVUkVS?=
 =?utf-8?B?aU1mUWk3cDBKWmYzWndsN0pYNndGVjN6ZTFOZVQ0WU5yZmFYUzdhQm8vbk55?=
 =?utf-8?B?VHZmUkRodTd2Znh5ZjV2cktkWFlTNkxOSWN1Qk9JN2VVZDY0a1BZZFFRMzNk?=
 =?utf-8?B?Z2Y5eE5xKzhKMGFYZWtER2lrTnlFdk85M2JJQTMvdy9HRWVySDYrdlNac3VH?=
 =?utf-8?B?N0VPelBPZlFWeCt5Y0NKNjV6eEM3a0VHcDlVUnBxRkRQU0V6aStwYkVXaUd0?=
 =?utf-8?Q?7YqEzcBeOmnq7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pudTBrQnhMN2xvalRHUGJ5YjFQdUhTV1E3cHhtTDFrbENpcktYdzBYeWY5?=
 =?utf-8?B?R3krajZTVE5NM2MrUFV4MkMrbEU1MU1OMmY4LzQ3Q2J6TG14VDA2RFROSmcv?=
 =?utf-8?B?TUxMbVZSZ0Y4MEhGQUdnbFBQMmpRNllQQmlwTE5lSFU3UDNwQXRBVHVEdVhF?=
 =?utf-8?B?cjhxRnhsYVZiWEVnUWdCYmptMjhrYm0wL1VkLy9PNUlnUFE0cm44R2NNcnVj?=
 =?utf-8?B?MTgxUXE2bHovTjlYR1IyVXZxRnQwUjQ0eUxFUUZ3cVRPQjRkN2pPM1B0Y29l?=
 =?utf-8?B?ZlgxdHN6RlRpaUtvdG52eGVyeVFrdVJZVi9rdGp2ak9VNmZnSWJ0MlhkN1RR?=
 =?utf-8?B?R01ENFVKWUhScG1OVG9XRFZTUDdnZmE3L1NuOVY3UEU5VFhlQ2Z0eVhSRTYr?=
 =?utf-8?B?b1VpdS9STEhqRTlwdCtsMTZYQ09TY1Z5VW44MUpSUjdiSjFxU3EvNmVSbXE3?=
 =?utf-8?B?NXNrc2hFZTJuTVNOMWdwZXpNcjBTMVI0YkxZWk1XMm96ckVPK3ZUSWhHL1lw?=
 =?utf-8?B?dnpPc2xWWTV2UEZrYUZyYVg0SUt3cklxM3owMnlLM2h3cHJvdlJVZWE5OFdS?=
 =?utf-8?B?eHJJSXd3ajF2RERzbkY0b2pER1crZzRrQnFBNGw1TnF1bVdHYU1Nd0tWYXpl?=
 =?utf-8?B?S3pTR2FiR3NLV2ZWM25TK1BvRUg3R1Y1ZzlxZ0s3VmZHd2FPcFQ4aS8yajNE?=
 =?utf-8?B?MXQ4WGVwb0s5UHBSR1R5QjFXdi9GUUZPc2ZsbDc4VC9kMitxRUhEVnlnNC9U?=
 =?utf-8?B?cUpDc05CSy9vK29MUnBBVDNuQ1NCQTczMlpRZFg3a0g5OW5Ed28ybjJOMVh1?=
 =?utf-8?B?Mnd2TlA1YmRIZlIvcDJYL2J0S0F3ckxQam1DTUJjbk1iNnpKMmRHT01TQnB3?=
 =?utf-8?B?NEdOajRsZ1hQeXdIcDRITU1iVmxOOXdhZjh5VE1wMVl4Wk9oWVp2TWNadGJa?=
 =?utf-8?B?UzQxb1F5eC8vN0lrSVBobFAzbjZFaGxYa04yWnZaMjZTOGNFcncxekM1aldY?=
 =?utf-8?B?dDNnRnNSZitVc0pNeHh4VFN3ZE1XcEE4WDhuck9qbDN5REhVSFRlbmNKUUVu?=
 =?utf-8?B?eXhCVytoUDJSSEhYZ2czdzVzSlVaVjJSM3cwaUlpcGNRUjlFQlJwMkJ2TWNV?=
 =?utf-8?B?aDZmclZjYjkweWF5TXZrZkg4a3p1V0tGQms3M2F0WUJkVnUxSGdGbGJTc25P?=
 =?utf-8?B?VDZ6am5XSk1LQ21Xd2VaMk9HdmluZCtHWmdoZ2l2dUJFZTduMDRuVDNoT0sr?=
 =?utf-8?B?MVBpUW1tclFrRmtxb3ZaVHJwTkJ3YWE0QUFiQVhsY0p4Y3QzNFFnNFp4cUp3?=
 =?utf-8?B?Q1RlY0F5d0Q4TlBzNkNJU2FCc09WY2ErMjFUd0ErRjV6aTZsYVNBSnpCM0Yx?=
 =?utf-8?B?a0UvZFg5ZlBZYWwxRDU2UVlwdjJQYWhyK1BheG0wQUxnVVpCaS9INDB1cVAz?=
 =?utf-8?B?VlZoV3d6Y3FLRWsvTjZhUXVzL29ZRlJTSjlRNk5LL294cWNlNkVGOGtkUTU1?=
 =?utf-8?B?YkZtT0ErbkpxVStIUHNiem94Sy9FMStTNkdPbzlKS3hsYlpwa0Q3WnJMK3Zr?=
 =?utf-8?B?M0dKWWJ5QlpLS25yUkFQRERoeG1RL1lOZFVzZWZjbEZZNkl0RHNGUXFJQWg1?=
 =?utf-8?B?T0JXc0hoV0s5TEZEUnpWaDZsbGFZRmR0V3E4M3hUV3pROVBBZ3NDTTl4WVNY?=
 =?utf-8?B?Ky9BMlVrWHF4aWNBeWdaalRYNjhrTjRTOERWbDRob2xJOHBYOWlVR0pSTDVY?=
 =?utf-8?B?TTZPTlozNUUvZldWendJWGZUNUFhWXNBU2R4ZEJ5bXM5Mm5vZ3ZXbXFqSkNr?=
 =?utf-8?B?NUlnMmxLK1p2aEpGZXdZbDd4bWJGTTRJZHFlcWpPQ2ZoUi8wU3F1SEMvTjdj?=
 =?utf-8?B?ZUpJbDZ2VnpQRGgrWVh0ZHFtSS9QR3ZGWld1Z0xyeGp3WUdFd0d2bjVLdTF3?=
 =?utf-8?B?VTJsaEw0b1ppWVpuQTEyb2hSbFJYS1lQVDhYaWwwU0pZb0xJRkJUVngxVmdr?=
 =?utf-8?B?bHpSemNyZE1xWWU4UnVZYVY3N01lY21NVU81T0tQTlZsK0Rrakl3REtsWXBL?=
 =?utf-8?B?UFlEWHIwWlgva0pmQmpWcHNhNlc0U3Zmb1VFYkNEczdsWS9kcEVqK0ZTaS9E?=
 =?utf-8?Q?2pOKWiceD0JYPiBHcO+2pdp9+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18ac159-c969-4361-7b52-08dd78b4e416
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 04:54:07.7360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnIqM3QiHiRr+dhho7S01AU2/8DLE8XsWl14s5jggYGtIa9K5eyLrQFJhs3JXZODAwSiiMhUPXBC/jVWGDss9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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

Alex,
This is v2 of 2/2 patch. Please review this.

~arvind

On 4/10/2025 8:27 PM, Arvind Yadav wrote:
> This patch is load usermode queue based on FW support for gfx12.
> CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 3050, MES = 123]
>
> v2: Addressed review comments from Alex
>     - Just check the firmware versions directly.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 3d87e445270e..3165fdfeca6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1418,7 +1418,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(12, 0, 1):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (adev->gfx.me_fw_version  >= 2780 &&
> +		    adev->gfx.pfp_fw_version >= 2840 &&
> +		    adev->gfx.mec_fw_version >= 3050 &&
> +		    adev->mes.fw_version[0] >= 123) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
