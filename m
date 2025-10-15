Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F4CCCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCB010E8F6;
	Wed, 15 Oct 2025 21:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/IOIPzO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8EB10E8F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws5DHHM5/mAhWZl/tdigq449gld8GxKibupqzeGMhh+QZtK/ekOkBJgcKbRPQVnQwx56+u6+eRc+NP6aFOvkzoVs5DgF9bHHvABWr8a/8TXCsRv/OjAPgb+nWuR54nhfpmOeWOjORvIfuz9sO8RnpJfsiB3KPBbIVpUbtYWSlPXzBPdF3LpiCDVe0Ta6teg1Tdhs3FuDAJqS6SqCzruY/Gbu7FbjQ4WhhVPf/TKjWG7faK/YwqE0CkXYFCialRdQjxO6q4V2Uk5fBWFy/B3ez9fa4a4hs0jQGRE6/CFj5jA7JKK3mVkF+SHU6QtvVcncYVzoUpb3cyKnbb9cfIDLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l65aEj7AIGF+HU4pt77obfw7HYJaUU+V2Kk+ajVTgZs=;
 b=WMeIdshSuEai33OuMeY9Y/JNmWAQ7Yb0eO/Vog7MD6BoInvXwxR/XBdt50oHNwG3WRW3ZvGpsa5yOUq+P6brnKbSHrwlaePuuhzfO+bP1PjPpX28zhQLvR/329pjeQcZPrTQWSyz6qhFuLI4S4B6wMqsr3hNlECyfAb4J7olj99fJS/WiiJFAJv5h6Ou3wpAxS8EhY0tS6heq90D5pN8RRtgaBrLU6rhrPMqRUq98uh8zLVAatDMPalRZVX8d4NbulkNVpmXTL4IVrjHdubpDx1ElqqwwNwxPsMHT3tC9qizmVDzakzSjYIFEejX7i2XnzLfhfldehZj5W7OzeapJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l65aEj7AIGF+HU4pt77obfw7HYJaUU+V2Kk+ajVTgZs=;
 b=m/IOIPzOsftQv6y+38BBW1gcWtAhgjX4FXYmdMViX56xyuDUUxg1VvJUlnwlcN7ZJ047PBmMIaLnnXkGKV+0IJhgnWUreLESnU+J/ZYGVjVctKQV5s+SgtjctZri//P/0Dz00EjKqs8KF/smlLWASiUthyLxYgcQvbtHvW4GIAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 21:01:23 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 21:01:23 +0000
Message-ID: <682f9477-ae2c-4022-be84-620cb02e388a@amd.com>
Date: Wed, 15 Oct 2025 16:01:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251015201134.2540-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: a8de0690-9490-485e-14f2-08de0c2dff40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2gvSzJRK0hKZWh0NXMreVllN2NRRDBacVlYTU5Bd1ZMcUFuQkRiWUQyS3dN?=
 =?utf-8?B?ZzNHTHROdE9HNEVxTkpXSXFLU1FBc0M4a2FQSHRUU2JLZktDR2dpNFJsNWlH?=
 =?utf-8?B?a05MWSt0eGJuaWcxN3FLeXQrYkt3S3U1dXVPbGZaUE8xWWg5bDM0cmhVVnFx?=
 =?utf-8?B?c1VUN3dEZzNmdzNNbXRFVzFhZ2xNL0FOT3F0ZzNpdlNDNjE5bmJ1UXVhdXdu?=
 =?utf-8?B?Q0hibnlTVnNScHlnQVY4cUtLeUp6Mk11djhjbDZWNkU4bFlQSDhCdjdvUmM2?=
 =?utf-8?B?QzJBNHliMDZINFlWRCtJZGRJUXlUdUdJUVQ1akNEbS9aUytWY3dHTFBZUkNn?=
 =?utf-8?B?Uk1wNlJtckZha0djclFUTGNKTDZOc0FkZkNJTHpqNmdyT0Njc3ROVUNNTDJu?=
 =?utf-8?B?akFqWFdiWUF4SGdVSW51eHE3cThja0hXMWswTVg1Ym1kT1Z0WDAxQXY3MXVw?=
 =?utf-8?B?N3V3UXBmR29aRWVCT0xGSmVGOHJGcHRuNHZ4V2NBMERPR1dnWHFYbGxuMllK?=
 =?utf-8?B?VGFpTEFwSjZHRkxGSjlyY21zL1AzTTl5WURxdVhROGlENFNYbkJ3UVUrd293?=
 =?utf-8?B?N0VQaUJmb3BVbWJBeUVzK0tHYUFxVTZDYWNlajFnUjFKMm5QNUJrTkhqQk9x?=
 =?utf-8?B?SW41dDhVOGNjQ3IyZUtSN2E5cHBuY05jNnZRYzY5L29qVlBjMk1zRHh3MjM4?=
 =?utf-8?B?TGZYWFc5ak9KOEZuUVNkNVExQ3NPMTFZYlRHY2s1dzQ1K3RHZ0FEaHRsNnRP?=
 =?utf-8?B?YmgzZUNYRzZtb2dFWndHZVYwU1RnV3BRSXV2U3lFaGhadk4zbmJ0eDIrS0Iv?=
 =?utf-8?B?TkZSMHpoSkhNU1VWVmt3aDBRUG1waEVwQ2x4UW9EM2pYWWJFUlIyME54NmZP?=
 =?utf-8?B?RFFFbFhkUHBsNUZValZCc0I1MFJxekJNNmRoc09NTlpFMDlVYnR0T2pYOWJl?=
 =?utf-8?B?dmIwT2plcW9aRXVLV29Sd2hVaStSRnRLRVNQczhKQmtreEI1WG5ZVnQ0ODN3?=
 =?utf-8?B?cm1uOVcrdWIrZG9RM1BIaXI0TlZYN0lqRXY4eXRKQ1dYVjk2aVJKZkszOGYy?=
 =?utf-8?B?a2RZWU1lUnZkVkxtZFFQR0xzLzRMcWVEN0REWGFVTlJGdzArU0RPZkI5NGtS?=
 =?utf-8?B?YnZRVThhaDJxeEE4NTJZK083Y2FwMHlwdDE3R09wT3l5ajZXWHhSOExFUUlw?=
 =?utf-8?B?eWl3REx2VjExT0N4MlR1SjRBU0kzd2t1aFcxblVLK1VBOURpQzZ1WXNPWlA5?=
 =?utf-8?B?clByYW84NTdhWEFkc1BzNXduaCtZa1ZUcVV5OERhNVNFUWRMaFZWSHhEaUJo?=
 =?utf-8?B?UFdrNlJZeE1vKzRkNGwwd1pINDBsVGtScytKYUs5NFhiWk1ndkcrMVdKRXJa?=
 =?utf-8?B?YmE0QVN5WjN6eHNFZXZxMmVHcG9MN1NTQnh6VVlBcjVNYUZWeWJMVnhwanRZ?=
 =?utf-8?B?NjJUWlgwdG0wMllKeFBCUGZNWExuTDl6ZEhMWS9TcGdhSnpEMzEveC9pdmlN?=
 =?utf-8?B?SU0zcUxad01ESUp2a0lvZjk3T0p6SURIcjRadkQ2T25EaUdNMWlJYk1YYktM?=
 =?utf-8?B?MlV5UEZxQXNTWGNFdmxCUDlHUFpFcnp2dkhHWC9rMWxLV3d0YTl1L1ZnMWYw?=
 =?utf-8?B?V25nSkxoMkM0UUpZSVcrMStxWjJ3WVNwREIzT1lCcFJyc0gzNG1XNnZLdG8v?=
 =?utf-8?B?aHpKa0UwS1pESGxyRktRTDdQeGJwaXdpaHdWRTh1cFBhNDVVWHRQN2FFbnNC?=
 =?utf-8?B?UVBSUGxoQmY0U2VmTlBmWVFaMG5wSC9sWVRNWnlsRVl0cU01WVhObnhqMS8w?=
 =?utf-8?B?VWdKZ2UwK050YTMreWdqS0hIclREcm9lL0VlNHVZMTVYSkIvYTFWamRMRndp?=
 =?utf-8?B?Tlh1YnRXcXRqTmdtcjJMT0dYNUJ4VVZRQk1NSldqWm1lZktIRU5Pd1puWm8y?=
 =?utf-8?Q?7xD0y5iCkF98Ay73GfNqbT3MWHEivc67?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCtjSUZ5ZXZmanlnVUNyKzgvZ0NWTkRiOXJzUFJCVGYwWDV1QVRHZWZCMWJm?=
 =?utf-8?B?dHBnZjhCUU1tMDU2WWVLN3ozcmE1bHlFZTV1K29TNUgxNnF6dDdlYXd5ZlhL?=
 =?utf-8?B?TDJUdEh3OUxwVG5VUUNIR3Z4R2tjWU42cU5JeHgyRkowM0twUEMrQUEvTTdI?=
 =?utf-8?B?QW1ISGZPZm11Zlk2Ynl3T2x2REloY0lOSWJYU2c3Tmd3V0RvQVQ1SkZ6N0hF?=
 =?utf-8?B?NXEvMEJUQ2h2aGNzQ3FpMHRLU2pLVXNNV2Q1aXk3U0ZHY2dHa21hSnVEQ0Q2?=
 =?utf-8?B?MVhPSlYyaEVrMlp0Y0lUb1BxL1h1UndiaFFZaktCWlpobzE0bDEwc3ZVSzVR?=
 =?utf-8?B?c0hYUUxzWUJqdEFKY1RCQ3FKNUdMbDVOK0RsRWJMSm8yNzZxN1Z3L0gzK2s1?=
 =?utf-8?B?V1RPMzFrL2xvZnFWRjdOQTc3cEhlUDRZWTBKVkJTV0lVRXlTaitKSDgzVHJP?=
 =?utf-8?B?YXlFdjRsTUpPSEJkZlhIQVBoRStCS3RNSTNheGovQU1yaWR0S1ZDSzFtT1cy?=
 =?utf-8?B?amwvV21EM0U1b0FyZFRtSno5TjRNcXQ5SHFkQ25FRHhyckJEdVJnZUxxbE9Q?=
 =?utf-8?B?VWpnaXBVQ05Pd0JheGVGNkVyS21LZzMwY3N2STFEc3gySS9Ka2pvaVl0cXFW?=
 =?utf-8?B?S1NVcjZoOURQV3Y0Z3ZvQUQ3bTNyOWxjU2VMR0oyeEEyVm9QVVVVbEVIQjZi?=
 =?utf-8?B?YWRxelE3UVRONFJScDVzQytGdkg0REtON0p0U3Y3by9sS0RlQW9Gc1h6dHpG?=
 =?utf-8?B?UTZSOEFNYm1kZFJSVjNNamdLaUdYNyt1Q0ZPV05pcEdLb25ITnJaMGpFTWtR?=
 =?utf-8?B?aVRqaDJLRWdPcXMyVlMvN29uM2tOWlRCUktwVEVYTU5oTERsRnMraW1nN29Z?=
 =?utf-8?B?RGdqVy9RVTNTOEdING9FbXNhM2xYSVpHa3ZVLzVadCtTTEJYNm8xLzEyci9U?=
 =?utf-8?B?RjE3ZW5EOVR0VGpOWTU2M1Rwa3VkckNqY3AvcVRoVUVYbkJwTmZVTkdnMlR5?=
 =?utf-8?B?aVUybE4rL1J6WkZia2xZbVpjL2tkaVU1K2t5RHI4OGRJNXNhcHNBL0dLVWpw?=
 =?utf-8?B?QkVtZ2tyUTA3bDB0NkJ1WGFvSVhHZW1wY0ZMVFJqS3hEWUhBUnJBdTI0cUFP?=
 =?utf-8?B?Qkg2RFY1Wk9uUzJNVmZQUzJuOFExTDlLVjZkRzZ6NUpFcm9NZzZpck1pbzNp?=
 =?utf-8?B?ZWlJcFdNM1lobXNvVjR0RWRlcDN4dnVrbW0weXhJR0lnR3Ric0VYditWTkFZ?=
 =?utf-8?B?UG04QjZ5T0NEZTZZb082dCtwaWRoODM4Tmk4d2p5WlU1cko4NSt6TVdzMUFq?=
 =?utf-8?B?eTdmWCtNQWFleGEvZmtmWEZjQjQ4VnpqOTZJRm9iNmpab1h1ckVYeTZHK1pV?=
 =?utf-8?B?VXMxVGhvZ2dzb0NMVUNqQzBMRW1iZURoQkJrckdHTm01b1RhdnBmeFVtREZX?=
 =?utf-8?B?MjJWN2lVTkFmeU5SZ2FMeUlYeENENXlYdEVQRjlHZTlwMUY4SVlraG4zejhN?=
 =?utf-8?B?UGNzc3NXRysrcWFmblRPSmxScVZEajd5VmZYbjk1RjhkNXM4WU14d1A4bjQr?=
 =?utf-8?B?MWxmeFRQQTZpOHFmZmgxbzVZVlFtMHd6dGcvUmp4R01pL3QwUjBqRzd0bFhT?=
 =?utf-8?B?OEUxK3hmTVBxQ1k5ODk5WTRxalBVK1EzSkw1cHljRGhzaWhoeCs4N05nc282?=
 =?utf-8?B?RDhiZFlscWJMZjcrdytrbkV6VnBGbDM0TE5FK0ZxTDhGSzJZTXB1c3pxNmsw?=
 =?utf-8?B?MFlIS250QUxFZitCNjBlSEZ5bzBFbmJLWUJ1blk2Y2E5cER4NWVNU2Mrd0ha?=
 =?utf-8?B?a24wajA1Yko2Zlo2ZVZyQW1jRnhucE54ZkFYZkJyc01helNKSHUyYURJdWpj?=
 =?utf-8?B?K0V6TXNQVTdZbkVqNDBZWnZaeW8zSnhaVVhUUk5QSVZyQ25yYU80dURtV3g0?=
 =?utf-8?B?UlRhWVRHaHdvVnlwUzJvMHJhNmZUUk8zektTK3I2L3JRTGFCUDNoNVJnZk9l?=
 =?utf-8?B?eVRMUUlsZldGMkNBczdiQUhLYVUydUh0YWF0NFpxTlpFendtMjRUWHN0a21I?=
 =?utf-8?B?dmI1R000dHJ4c2M5TFhUc0dwaDhuMlRKYVVvLzRhaDFPTGpDdHdSbUxzVmgr?=
 =?utf-8?Q?3dzo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8de0690-9490-485e-14f2-08de0c2dff40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:01:23.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qa1J04Eu7qTPbQlvy5WT2s5OhD3J5tfCFQRWpWTszWNxMpa4jUUU3zBviM+lK9NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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


On 10/15/2025 3:11 PM, Philip Yang wrote:
> Only show warning message if process mm is still alive when queue
> buffer is freed to evcit the queues.
>
> If kfd_lookup_process_by_mm return NULL, means the process is already
> exited and mm is gone, it is fine to free queue buffer.

But another question is why a prange is still alive, its kfd process is 
gone?

When unmap a prange the queues that use it should have been stopped. If 
not, there is problem somewhere. This warning message need be sent no 
matter kfd process exists or not.

I think a real problem here is kfd process need be alive as long as any 
of its resource is still alive. In this case since prange is still alive 
its kfd process should not be released(p should not be null). If not we 
need wait all pranges from this process got released, then release this 
kfd process.

Regards

Xiaogang

>
> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 4d4a47313f5b..d1b2f8525f80 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	bool unmap_parent;
>   	uint32_t i;
>   
> -	if (atomic_read(&prange->queue_refcount)) {
> +	p = kfd_lookup_process_by_mm(mm);
> +
> +	if (p && atomic_read(&prange->queue_refcount)) {
>   		int r;
>   
>   		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   			pr_debug("failed %d to quiesce KFD queues\n", r);
>   	}
>   
> -	p = kfd_lookup_process_by_mm(mm);
>   	if (!p)
>   		return;
>   	svms = &p->svms;
