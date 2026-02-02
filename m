Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30795E73158
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF41210E4AA;
	Mon,  2 Feb 2026 12:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HZt2kCXO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA2A10E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4toEcYYCnJd5rZRTNBRaYmMY2tJ4ep1ZOw4Jk9gIkaHHhacGlaixCnvO2LCGno7sEnkQXXLmIH7qq2RqABPl3GxxRIVOaXjahJbz4qXNsjhLUTrxCcuAJmRSs1laMzGGkabEAfE7LDYutIFMwaVAo9SlYNvkR19k/MBGHWjfiiLFTWBVm2MV/XIzHLuDLGT5v3ltQzl81vCf8AAwqaIMPYwpiY55JBO2nGOQqKrW5Lwtf9GUoHqhnl270sP1jKxZrgPDmfbX3c9n/nKjTokzhfafZW4qUAiZM3hkKqgqeZ8c4taXHLwePRMWrpdlOslKRloGCZRwZHZZcPT46LX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL1x7KGG7iRSX3WWFzZKRwPdqNubKdmb6BilIUsJhXg=;
 b=tVccqEbN/9d60tlvuV8WVEH0EfUcOf6dDk5syj+16LyvN6up5/8swtRpSNiFF6rOmy1GK5Gt17BKP+eeIkqAbCpcSAGr65jn7DTNT0zhfKmR7yxlVZdQOY7XtpKlsO7W3kunYcYIGvVvanPmyCtFq6ptx6GoqfGDQahhTQC+TllNSMImaSbOgagRA2CARA8lca8xWB8PcFeZVHGPiT7birsPcJ5DzJPdM1xxJ5pV95cpqMdp8TEw6CSkpU8gG8xLtMIJhWXQRtaUjMgrjPhF5cBKtu9H5CzishTwcPxOET1j1RJqULKzPoypQhtJDtHTXcRElzqVcsODGPmnlYLkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL1x7KGG7iRSX3WWFzZKRwPdqNubKdmb6BilIUsJhXg=;
 b=HZt2kCXOpa8VSCRco73nW5kiQAK7T2sAWl4z6dG2Tssbm2nEMbOKx6DiLXsAPzswkS9ZCIM+p4fGW4fLyVJ5PgaAE82gRT71jvanecdvJenNoRh+QAblnzGVezY8wiBpKtbdL+u0wV0toOPDTw1/DIZX6YiYwZZ8OLyxN7+dgRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 12:34:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:34:03 +0000
Message-ID: <05c545db-b6e5-4f0b-b62a-f2ef1570c383@amd.com>
Date: Mon, 2 Feb 2026 13:33:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent
To: Tvrtko Ursulin <tursulin@ursulin.net>, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, Yogesh.Mohanmarimuthu@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com, Sunil.Khatri@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260129125327.11786-1-christian.koenig@amd.com>
 <20260129125327.11786-7-christian.koenig@amd.com>
 <45e5c024-8d21-4d4d-85dc-66fe31c05421@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <45e5c024-8d21-4d4d-85dc-66fe31c05421@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:408:e1::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faa1679-19a2-4160-a0f9-08de6257595d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YStKd0tmcFdqWWNVSUtyYUJWMUdMcVlvMnlqWUNsR0FKTUpWRkcyR2NRRWNI?=
 =?utf-8?B?M29WSzJ6OGZaUFR2aGVMenZ3Zk5vRzZNMm04dkhFR0RyclMxcDhkRmU5dG9I?=
 =?utf-8?B?ckxxSHdpZTlUVjZVa2dEcGxRZ01HaEsrM0RvaysyelVST3FpNzJrNFNjcXNq?=
 =?utf-8?B?bk41OHhiUWVITTY5bVdaQzdGbTJKU25HQlBZS0R2Ukw3RUtZZTlaeUN1ZHli?=
 =?utf-8?B?SWdFQTVlUytmbG9zZFpPK1hmR3o1V2EwY08vNFVnYWhXdkRubFpyK20vclho?=
 =?utf-8?B?bGdvWWZGSDFaYVBmZEJ2WDV1dlROK1pnT0NmUzIyWjl0YVdkV3hQa1kzTm5j?=
 =?utf-8?B?VWErZUprakpWVkQ4RjFaMnBWVUdadEwyMm5VUkFVRHgyMks0bEZnK1Z6NVFk?=
 =?utf-8?B?Mmg3aENDMEhyczZtRmg3akFvakt3cWRFSnI2ekFFOGpiRDBTWXhEaTVWZmF1?=
 =?utf-8?B?MTVEYlhMeEZTSUNNeUhzNG1TU285cW5DWFVsZFpIUWV4Qm5uVzhXUUx2M2h5?=
 =?utf-8?B?Ry8zVldIM2p3SFhwS21xUEFQU04rMEF2OFo0VmFaN1NwVTQrQUp3QTFPVjhE?=
 =?utf-8?B?L2w3OFRnZmVxcXJVZzI4QnZTWXNzZlZ4VUZXMk9IencrSks5cUZ6ZlVadnc1?=
 =?utf-8?B?Z2VGOTN1elNGNzlzOCttYjlQZmtsdHorQ0ZFV0t0R2MyVlUyeFFLSDdZZVhZ?=
 =?utf-8?B?YmtQTVBKQ3BnMHhXRklxVWRKc3dMVU1wZkV5LzFYVVlwV3VEVnNlMGZWRmFz?=
 =?utf-8?B?R0JYWEU5VmV2K3JGeDc3Vm1QOXdodmZsak5YNU1oU2N0SllXbWdnbHMvRGxN?=
 =?utf-8?B?QlBncjlvajNrd3c5QktUR1pZek8zbmVoVFdkdVBrR3lpanltcEdCcHEwNGlo?=
 =?utf-8?B?eWtLQnh3K1NMRFVGVUFucjVZcnJyN1NBZHNjU2h4alhQdFpINHcvSGFJb1dw?=
 =?utf-8?B?WmxyS2tkZTlDU3VWblg1VFg3TzdMbFo5QVdLT2ZiRmRnbmt6TllrcVIwMXZk?=
 =?utf-8?B?b1k3OEs3Z1g5aDZuUVhYZjZlb1NROU9DNWJPL3FidXFQeStzbXE5dWNMQkl6?=
 =?utf-8?B?SStyWDkrbDZSaTlkenpFckIrMmdTY1hqMXVrS3VjdUtmSVl5Y3hKY0VUMTlw?=
 =?utf-8?B?VzVkUlFxbFdWQ3A0MG40Sy9RcEtSeUQ5Zm1yVXBDeEpxdGFqVUQ2T2g2clNW?=
 =?utf-8?B?cFFxeDJoTkJwNnozTTZUQmhnZTQ5UWREcGlzajZ6cHY4Slc3dFRPSnNlRGdM?=
 =?utf-8?B?RXkvSURxblNSUTRKb0t4Wk05NUMvb00rN0tkVTR1OHd4bDFEYnd6bXh6VWEz?=
 =?utf-8?B?cytEZHNUNFE1cFBHU09yS0tUeXBCQkVZY015cUVXTWh0WjBHWnFJVEU0SHpy?=
 =?utf-8?B?dzBNQkJtbWlWREhVSDM5aWxkSGxqNkQxZ2ZNSHdlUGxqYTFxU2VZdVRkRHBa?=
 =?utf-8?B?UU5lKzBqOURpdGxWQUVMVVNJZUNBMmtOYW1Zam1HWnhNZWRpcEhMM0NwQmxv?=
 =?utf-8?B?MUhoM2tNaFhyK2x3ZW5WMVdYOU9SdzVDRk5qUGEwdFE5anBObENwMVM5VFIw?=
 =?utf-8?B?NDVodnRFbUg3ekpjTk9abWlwTW5hUjhaOUFGSDRqM0dHam1iMEg3MFRGOWxV?=
 =?utf-8?B?Ly9MTGZnWStNYjBCWXFLbXJEVHVkUGdRVGhFVXFOTVZhOXRQTlNaV1Q5S0JP?=
 =?utf-8?B?blRzQVd3MjJGQnVuQnhLcU1PYjE3TUo5UDlqdkdGOW4xaDI0cmJZM1JWZStl?=
 =?utf-8?B?R3ZEaWFwRDd6MHIvUlZIZXlrYjd3VzhkR3NPSnZ3NnNhajBkSTNUV2JzWmEw?=
 =?utf-8?B?eGxFSDQwekptSTA0V1ExSTQ3UC91SE52a0ZHaU4xMC9SQ2NMY0hzNllTSnJH?=
 =?utf-8?B?S3VLQ09mVjdrMzJVb2I4K05aWE40TnU5dU9pZGFYYm1kZUxkdDJOMU1nSldP?=
 =?utf-8?B?K1VGMG9XOXlzZ2FaK3JwUS9CSkFpaFMrdGlOOUpTTm1BWDd3Zlo3QnBLVUxX?=
 =?utf-8?B?aUYwVEhKZ0Y5UGxHbEVjOUNKcjhmclA3bGNhTnF0WHVSZ01idHlSVUNCajZH?=
 =?utf-8?B?d1N4T1czZWpheTBTZm1wUU1LME9adXNUaCszbVBOWGovam9sYXoyKzkwb3Yr?=
 =?utf-8?Q?//D8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVld0FRTi9QS0c0OHBGVVNGeFg5TDI4U0VzYmVKVGFxWGRrM0cwWHNxU2lI?=
 =?utf-8?B?Q0JpRTVFSXJMbk5OdThoV0JLT25DREdiZ2tHbTU1WXMrQm9xelp3Vm90eEF3?=
 =?utf-8?B?aWZKdktkbU05NnJxdEhqTDNXYnJJRG1aai9iVUhheXZxa2c3cy9OWGl2R2JR?=
 =?utf-8?B?NFQ3eTlSRmcrcHFwT20wd1FrRXRaQUVqZzlaUGtMMjZkTGRqTnZNYkhtVFJF?=
 =?utf-8?B?RG1yMjdCRTJvem51Ty8yeFBnam93dUNtRkw4Uit6U2REK0VIcFBhY254cFBh?=
 =?utf-8?B?RDBXM0pjSGZhY05rYkNVWXNoTkFvWm1JblZHVTRSTEZPb2JrL1ljZDlPRFJz?=
 =?utf-8?B?NUU3QWRmK1gxSzNheHBGUkhXRjRnUHQwckwwZmJ5YklSVUxjUmRucE1GZnBG?=
 =?utf-8?B?Yk94QmVCc1M5SkY4WHpGZm5tWVJDMXRqMHlLdkJCK0IyZ285UUE0aWFlU0gw?=
 =?utf-8?B?Q2UwZUxJNitUU0dibEtmTHlhS1B2TzJoTGZnZVZQeWh2OXg5OW54d1cySmN1?=
 =?utf-8?B?Y1N4aEREVjhOOHdSamtsdHJhTCtDUFJISnZJL00rL0F1MVRmV09ES05jYmJB?=
 =?utf-8?B?b2x5SDg0ZGQwYUZtZXhHMThaU3J5SGlKQTljSFJ4akRuelF0WHlJUnB3ZzA4?=
 =?utf-8?B?QXlXUnZBWjFYOGdTcFV4ZDNKci9mKzJKOXg5anpITHhYT05ZMFArZEZOcWta?=
 =?utf-8?B?WVNqL2Z5NXhTb01qVjhtaENsaittRWlMdmxKd3NDN0RWWkVUbEV4WHpVcHIx?=
 =?utf-8?B?L2w2MGtFaUlyMFNvQnFRZE45OTBGaktJZVNwem9PQ1lzRGErYVhuZ09EZEpp?=
 =?utf-8?B?Vit5V1pvWlNtVncvSkh6S21ENWtNNXEvblhrSVNsS0ZGWCtUMitsNk9iSm10?=
 =?utf-8?B?RWNXMkhzczlsTmIzK3VXeXFsbzdTaDZkcTNBbzR6VlA3V0wySDY5T1BHUk0v?=
 =?utf-8?B?aGJZNFZxZlVEa0gzcVE1bERtdmJEclFpUjc2R1hjVDdQR2gvS2t3N3ZialRI?=
 =?utf-8?B?b1BjRXFjRWtaSUh2aWVkenhnV0plakNGVERjTXIxRDhmcEZ6RVdsdjBkeXlx?=
 =?utf-8?B?UktCb0VNTXljUVlRUzUzd2hjTFk4eW96Y0xoSGlmRUIyOW9MYzVYYzl4V2JM?=
 =?utf-8?B?Qkx6NDNNcnljMlFsOURYM3ZZSVJkd0hjVU5ROG1WVkVtMHhxQ09jRERzdjM4?=
 =?utf-8?B?d2tzZ01iaUNjOFJmQnkxZEdsT2phbWx2ZmtwQUxnSGJ2Zk5zTzlTbGdaVFNP?=
 =?utf-8?B?UEJPdVFTcTNPcXZMNDBXNFFEQnN3eVJEZ21SUGZxenZOTVA4UjJoc0NiWEhM?=
 =?utf-8?B?OUd2WUdyanBXdkRheFFac3lFaWF6WWRVSGptNUZFMEtGVklTa3VldEhwSWNP?=
 =?utf-8?B?Y2FHU08yd096RVBnQnlLWWtIN2xjSGZZNWVCNW5GZjNaMmtoVGlvVC9xZ21r?=
 =?utf-8?B?K1Bxb3ZOYUVtNEdia05Uc1NvRXRyL3A0K1Z3bm5QdnFlaW04SVZJU3dwK21i?=
 =?utf-8?B?TVVKVXJ2UlZPc3hZNWtPZTJwVjFDOTA4cW1QbmVoNjFiQ3JzbGdYMHh5eFlx?=
 =?utf-8?B?Z0QyUDNBNEh2QmhQYnhkVk93MzJTd01DTkV5YUtWTGpOUjJjVnEzNS9OQWUz?=
 =?utf-8?B?Q3UrZkozQ2llUUVzZVRMNk9HdVhQTFJlWnRSbzdrRUw2eWNTWlEzK3NZWWtB?=
 =?utf-8?B?WWVZaVM0T1NBdHJ6L3R0dnFham1QbndDYXJJR3A4d3dFbmY3dHVvRFFBZnNq?=
 =?utf-8?B?anJkbUVUdjRtRlhoR0xlZ2JuVTl0SzdGNWFZUVJJNzFqcTcwbElUR3lDVWxL?=
 =?utf-8?B?RjIvVC9rTlVtdDgxVTlCZi8vSW9VK1VPUFdXbmRyUG5naXQ5ZENnZm1iSkhC?=
 =?utf-8?B?TW9telg1SEhrQUhxL2M0ZWttSlZ6SjMyS2h2MnBrSG5rRTJpOERaNTIxQUh5?=
 =?utf-8?B?YlM5dGNuMEdCSHJIVG1VNFZpUUlQVXNpNkJtbnh0L1FuTitxWGlrcWlmN0Zm?=
 =?utf-8?B?Wjd1emVCQUJrVUtNZnlQdFg5dmpncDRpdVlEQlRPRFUwWVdSbkhQaldGTDNi?=
 =?utf-8?B?Wm15WkxvaDhXNWFBc3NnTmtldXZNd3pabW02SDFTWTFMMk0wYUZFRDZhNUcw?=
 =?utf-8?B?dFJNSG1tUW1UV3RmS2h0RGg3QjZHaHIyZHRuVG5Ydkhna0ViaEg2RCt2aVMr?=
 =?utf-8?B?cWVtNTFuU3YwS2RBV2l1TDFWS3dvZDB5Y1Y0TGtnZ3cxM0xDN29pbW9pZ1VS?=
 =?utf-8?B?bkp2VkxzeEgrSmEvMmh5S21zelJyQUUycWtKZVIyUU95b3p6ODhSKzh3VG1o?=
 =?utf-8?Q?v6r+6C4MQfqNMLRCV8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faa1679-19a2-4160-a0f9-08de6257595d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:34:03.7222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7jCWgMDvW+qTJK99XwN7Ov6u6/W6VeflUO6jZqNvjBN3KjZjxGVxSR5D0HNv48D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

On 1/29/26 16:16, Tvrtko Ursulin wrote:
> 
> On 29/01/2026 12:53, Christian König wrote:
>> When the memory allocated by userspace isn't sufficient for all the
>> fences then just wait on them instead of returning an error.
> 
> Hmm..
> 
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 52 ++++++++++---------
>>   1 file changed, 28 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index ee8a5fbbd53b..d059712741fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -734,7 +734,7 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>>               num_fences++;
>>       }
>>   -    wait_info->num_fences = num_fences;
>> +    wait_info->num_fences = min(num_fences, USHRT_MAX);
> 
> Oh it is actually a weakness in the uapi with wait_info->num_fences being u16. I did not pick that from the commit message straight away.

No, that's not a weakness. It just doesn't make sense to return so many addr/value pairs.

> De-dup the array when over the uapi limit, and retry?

No, giving back addr/value pairs to userspace is just an optimization and not for technical correctness.

We could wait for everything inside the kernel, but that inserts a CPU bubble when submissions from multiple applications depend on each other.

> Is it userq fences or other fences that cause the spill in practice? If the former then the patch adds a kernel wait where there wasn't one before so de-duping more aggressively could maybe limit that path.

This is actually not a practical issue for performance. We just need to make sure that userspace can't abuse the API to kill X/Wayland for example by giving a BO to display with tons of fences on it.

Thanks for the comments,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>       r = 0;
>>     error_unlock:
>> @@ -743,6 +743,19 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>>       return r;
>>   }
>>   +static int
>> +amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>> +                struct dma_fence **fences, unsigned int *num_fences,
>> +                struct dma_fence *fence)
>> +{
>> +    /* As fallback shouldn't userspace allocate enough space */
>> +    if (*num_fences >= wait_info->num_fences)
>> +        return dma_fence_wait(fence, true);
>> +
>> +    fences[(*num_fences)++] = dma_fence_get(fence);
>> +    return 0;
>> +}
>> +
>>   static int
>>   amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>                       struct drm_amdgpu_userq_wait *wait_info,
>> @@ -786,12 +799,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>               goto free_fences;
>>             dma_fence_unwrap_for_each(f, &iter, fence) {
>> -            if (num_fences >= wait_info->num_fences) {
>> -                r = -EINVAL;
>> +            r = amdgpu_userq_wait_add_fence(wait_info, fences,
>> +                            &num_fences, f);
>> +            if (r)
>>                   goto free_fences;
>> -            }
>> -
>> -            fences[num_fences++] = dma_fence_get(f);
>>           }
>>             dma_fence_put(fence);
>> @@ -808,12 +819,11 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>           if (r)
>>               goto free_fences;
>>   -        if (num_fences >= wait_info->num_fences) {
>> -            r = -EINVAL;
>> +        r = amdgpu_userq_wait_add_fence(wait_info, fences,
>> +                        &num_fences, f);
>> +        if (r)
>>               goto free_fences;
>> -        }
>>   -        fences[num_fences++] = fence;
>>           dma_fence_put(fence);
>>       }
>>   @@ -844,13 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>             dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>>                       DMA_RESV_USAGE_READ, fence) {
>> -            if (num_fences >= wait_info->num_fences) {
>> -                r = -EINVAL;
>> -                goto error_unlock;
>> -            }
>> -
>> -            fences[num_fences++] = fence;
>> -            dma_fence_get(fence);
>> +            r = amdgpu_userq_wait_add_fence(wait_info, fences,
>> +                            &num_fences, f);
>> +            if (r)
>> +                goto free_fences;
>>           }
>>       }
>>   @@ -861,13 +868,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>             dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>>                       DMA_RESV_USAGE_WRITE, fence) {
>> -            if (num_fences >= wait_info->num_fences) {
>> -                r = -EINVAL;
>> -                goto error_unlock;
>> -            }
>> -
>> -            fences[num_fences++] = fence;
>> -            dma_fence_get(fence);
>> +            r = amdgpu_userq_wait_add_fence(wait_info, fences,
>> +                            &num_fences, f);
>> +            if (r)
>> +                goto free_fences;
>>           }
>>       }
>>   
> 

