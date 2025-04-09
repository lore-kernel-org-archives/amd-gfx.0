Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D19C369A4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 14:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3928F10E8F6;
	Wed,  9 Apr 2025 14:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RlG4lU+i";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7758B10E8F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 14:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amA53w5nLJQvx5brZiwWaEwut2Xhrv+oKe8aQMtFeUVIn/N/rZhEJwoqgkmqeQXheu+UtOvkqBSalJ7Heez+TKpCAXbyeImkSG9oOHVNoFVyXAj5Oo7B4JL/oOsXBKG9gjJXe63/jttbZn5jz/5fnlmGGi4WQ2rj1ggeKg7yWcrrs5saI78POjXrrvzgiAlzYJi37BPNVoXvNKvVuaVI3McTYitifwyGv5QjRcZoMJXH4OxN4/YtWALm2E33csouWJSoloBdBqO8sS2Ctvfu61m+3vtoBmfA9nwe9GUVzo1OcyVZwNXmNOhjaeZXbd5G5HzUP/ZAO7aGdALmEtH9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZGJIzqIW8BA7v7GIcSwFD2E5yXM2VT+7VNTtojTT9E=;
 b=l9UGkqAskRykadNY35Lteio3zND3R2FejHNvKmxo/HKu9opHBcbQGr0ZBp8jseQHgX6XTPCY8/4rck3QP33qij4z54WyhwBoZ+CPUyFYWW7kKrs/p6N2AoQxNd2UNR1n1ZyiYLnLDqLXCAKZLa/097KZdh6zDT/xt0XWoYIpdX8Hj1j2K/EoFMNS4H0O36zemSwg46wyJFQp5na5ndGDgO6C5lPEIh1VCkBOO+p5no0dyWKmm+hqiul3HKBNJ4B9IM4Sxpfbt5NUzX6lgBsmfMnhdJVnAm/NKedtA+x88jyACdYjZzHZe9KXya052LB9EYwmIw2yNL/PLuG3W4+uGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZGJIzqIW8BA7v7GIcSwFD2E5yXM2VT+7VNTtojTT9E=;
 b=RlG4lU+i0NbUuz13+eMVYmHFuLJbQhfYUT5Z0uPvx3CUrGDQsLfPnb9adFl6Rkz2TS+kGTcynZxaYX1OY6QG6OYwflJZ2zqnwTz0kk63k+bGzSoLBK7n5UnVY7r8RIfDtdyUFDIvc4q5ZuN4+Ldtj+uoldZPEJwVa7vxF1hwJzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 14:36:01 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 14:36:00 +0000
Message-ID: <243270dd-f7a6-4eee-a5c7-904085b25472@amd.com>
Date: Wed, 9 Apr 2025 20:05:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: adjust enforce_isolation handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250408160000.3149409-1-alexander.deucher@amd.com>
 <20250408160000.3149409-3-alexander.deucher@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250408160000.3149409-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b6debe-1669-42c7-7696-08dd7773d8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWFtQjRHaFhNTzNJb25CV0NmanZzWEU1ZDhWcEU0M3RNNW9UbEV4eWhGeXJ3?=
 =?utf-8?B?cnViNVZ2aXY4aVNLWDYwYlVMV1JkVXpDSVB1RkxjeXVyT1dENTlaTmd3RDBC?=
 =?utf-8?B?dFFIYXBtY2V1TjR4V2JDeEJGRzVQMm1paE1GenU3RHVFd2R6WTRxMHBNVlo5?=
 =?utf-8?B?T2M2dncvMEo2dEtCNzBnQVIxeW1QbEhTVTYzaHl2TUZKSVA4emZzUFc1b2VM?=
 =?utf-8?B?TXY4T210OUJBN2g5MW9qZzUvVkxWSWZUS0VRaHpnQTlMYzk5azI4QmRROEEy?=
 =?utf-8?B?d2I1b2duRHF4dzJiR3k4c29mYmVzT1lEOEhSQzVWaFI5TXlkTjh3Zk4xMHZ0?=
 =?utf-8?B?Ukc4bytSNDlTcUVpSmxGQnBLK0lWRzRlRzVGMW1vTTZ0c0x4OW9sVUZJZk9l?=
 =?utf-8?B?S3lubE55S25QSHJxdm1MZ1pNNnJwS2s2M0tmKzcwTnhzVUhPUkVkMUl3c1hD?=
 =?utf-8?B?Z1lZbllGTkdPcTloQy83Nnl3NWtPOGNQUGV1bFdvYVk3REUyTFFOekZOdXRh?=
 =?utf-8?B?ZGRTc2VvNll1UEtIQ3ZPc2J5SzJJVURLeE5MTDlNLzkyZ2lRamdWMWpoM2lW?=
 =?utf-8?B?L0tGc0djVkRDZTRIaVVrRjQxM0IxZTBjOUliMU10SUZ3cWV0RUQzV0ZTckt2?=
 =?utf-8?B?bzhnQ2g5WllnT0RUcG1HdkUwcEk1bHBjNHhtc3JPU1pzMkw1QW96ZFNxL2xk?=
 =?utf-8?B?cHRhWG9NcWVoMWpXUVFBOFEzL0ZCZUx6QllFWGZnRGdkWEcwQkZtVXJVRytv?=
 =?utf-8?B?MXk3TUVQTWFtVWpXNEoxblg0eFJJNEdOYUw0eEYvWFhGdWVXTGZVampmcStj?=
 =?utf-8?B?Q1p2TTlWWktndjhpNVl0UUdWRTlvUFpUQ0F0RW9US0JieGhzU2VDWTdsVWVm?=
 =?utf-8?B?SXNhTDUrL0RkNmFyL0hpVFVQVXBYT3ZHNGU2UEt2MlVSSFlXMWIweHhaUmRJ?=
 =?utf-8?B?d04zdi92V3FIU1lTYnlhOGt3NTQrYW1LdHNwSXZrTzhLbXpnaFUrRTI3ZUVW?=
 =?utf-8?B?WUlLN2dTSTZkNUdUQ21pSFFkOEEwWXRtZ1FTQ3RqTC94K0FScDliNkRyL3du?=
 =?utf-8?B?QkN0Q09lYmFRZXZVRkxoTnZWbitISGI3MTNQcDg5bkg2L2xXbkhOT3ViOWcx?=
 =?utf-8?B?Qi9CdXdTWmxJb2VHRCttZE9UYVhSQ212LzIyZ1RkVmhZTjM0MG90T0ZYWmFG?=
 =?utf-8?B?MUJhbldYRTgvem1LdkhBYzcyckdZZ2g5ZjIvRW9jYjhTakxIMHhTK1EzTUd1?=
 =?utf-8?B?aG1sQVZhMHFNOXJwTHNKb0hhZEJ1ZGtOajVOekp6WnhXaFJSbUVZb09UOFJD?=
 =?utf-8?B?RUt2bFdXMXdjdlcvWWkwR2hxdlRCTnQ1Vm9rWC95L1ZOTC9KWWdTN3l5QVJr?=
 =?utf-8?B?RjNKUGswaVMvMWlNZDRtbDF6M2lRTTRhcEVXQUNrNlFCc3lGa1l2Sm5IZkk2?=
 =?utf-8?B?cE40cm5Hb1FMRFdINlBOdi9qcTh0MWE0cEpBUVJ3YzdsanZLdTRmQkQvREp6?=
 =?utf-8?B?TEhkdmdHdFVBM2xEU1kwcFBCNk9tTnQ0NUxKNGJGYzFGUHE1aThOclRjSVRj?=
 =?utf-8?B?THQ2WlVFb1o1UkFOc2VyZW9zQkhUaCt0SWNSakFValB6N2J4WUV5TnBsSXpp?=
 =?utf-8?B?ekt0TDlWWUptcEQwSHk0aGJlZTExQytpZjNwclpma0J0Z3hXamJaek1md1J1?=
 =?utf-8?B?SXI4RnVtb3BhcTRyeXcxcWo1ZFVDWjhQZGdCZ3QxbDlwVEVQUWpjMXcwdUdM?=
 =?utf-8?B?a0JRbnRnTWFpSGxmamM1N1BSaUtQL3k4bjZPU0FWTHRVbUwxWEd0Zjd3QXFQ?=
 =?utf-8?B?S0Y1czltN0wzOTZaVHExKy9HMi9zNFFNRzlEOUhieDlwUXE4Q1lBZ3F0alpM?=
 =?utf-8?B?dXU3QytuVUwycUF2R2xINmJyalhBRWVvYTZCU3dVOWFSSFFBZjRtMk5KUmRP?=
 =?utf-8?Q?6tWRkHj1+sQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThhVEMrbXM2RnNEMmJheWs1UTdtTVdLTjlyd0hPUVRNY3JoODVHNFYyUUIy?=
 =?utf-8?B?VW5PYXpaWGd4NGZnV1A3WmMvUkt5NzUwVEdWVy91dE40NjZMd3ZjdzhYYmht?=
 =?utf-8?B?dTVGeVpoQXN4MUFPSkVmUCs2bUc5Tnc5OVpFM0Y0Q3dZa3BuZ0pzR3FNZDN1?=
 =?utf-8?B?TXU5RlB1WU5aNjArWVg2SUlJaytOOVNNbHBITkRPWUlad3l6VFQzcWlkVjU2?=
 =?utf-8?B?M0lXMWt5R0Y5MUVXdmZXYjRrRXlyTUp3MnE1WVNJU3BiU1lCQ2JYS2N1LzVY?=
 =?utf-8?B?WVExd21nUFVGTU81NDExZmVXeUpWYWU5NVpLYUtuNHYxcnBOTGpGZXNxRVdG?=
 =?utf-8?B?a3dYZVRReitGMHY0K0tMRkVPRjFCZm9WazhXYVhMK1pxejRsVTkySDA5emNi?=
 =?utf-8?B?QmdOMUI5dHpQd0NQNzM0L2tUUVZLM2Y5Qmt0MklxbXlHUVlYbHhBSi9ISzhV?=
 =?utf-8?B?QTF3RDQ3RjBsa1V1MXc3YVV1ZzdjaTZvUlNCMmlJQmJSWHpXbTEwZTNTdzUy?=
 =?utf-8?B?ai9HODNwanhYTFd4UjhwdnVuY25DOTlRSEJYek9UbkNjWllobHRUZ2xTQm0v?=
 =?utf-8?B?Q0xBalJRUFQ5MWxUdndWSWZOVGI1ZUNTK0R3dm51VWFldnFHRTF2NExCb0Qy?=
 =?utf-8?B?Vlg0UWR5dXAwRnBYdi9mbUE2VUx0Q09GZzhTNFhxNWc0YWVYNUVDN0I2Q2x5?=
 =?utf-8?B?cVFnaU1WTWg1YzN5Y2VNQ20rb0ZmdDB6dEJwcVNpbmZKYlV4NjBkb25qbGw4?=
 =?utf-8?B?cHJxektzbGNaQnJ6a2tSeU51RXZqak1XMFdFYW1NMWlFZ0xVNU9OVFZJZXRs?=
 =?utf-8?B?aWNuaTVwQmFSR1MrMjVYZUEyRy9mbGV6bCt6TEFsdXE1TzRsRG9YUnJGeEFI?=
 =?utf-8?B?WlB3RFlEUU5OT3hQRHdmc25rWE1rM28wSVpJRUR2OE0xYzF4Q2FjWHBEeExI?=
 =?utf-8?B?b0g0a21DVGcrTHhqZE82eDY4TjZjeGNOdlAzdnZUK2EvaC9ubmZYdS9EN1F4?=
 =?utf-8?B?bXZRcVJlelVqa0tvbTQzbnViZmlmR2drRkVTMVBGMlFXYVZEOFNHRVJqc0Zp?=
 =?utf-8?B?OHFoK2o1K0dvMzVvVXREMW9KMTcrbDYvZFE4YlNjblNoLytVN3lTMlRFaUZH?=
 =?utf-8?B?ZHNpc0lIWmw3ZzJsUi9Kc0lBVlY1T3hwNFAyRnJWeEt0UXhUdGRMR2tiUEkw?=
 =?utf-8?B?RUwxVnF0Wk52SnBnN21oT0IzaWVjRDZYQ29pRkV6L0NCc21WTWt0bjBPK21X?=
 =?utf-8?B?WFVIUStIM21sNW8zUng5SXAyWGZzcU12NGRyREVDdGczaHQvQlR5dnJWejd1?=
 =?utf-8?B?STU5ZE5qWHkrQ245bTRMVjR4dmpRVTZNdlJPMTRvbm1DMWhTUVFZa3hOcUk1?=
 =?utf-8?B?TlFxcTl5R1hxa0FITENkTW0yTHJoL2p0NHhtZDNNYWw2ZVVFSEQzb2F2cUdG?=
 =?utf-8?B?c3hBTEFpaG9DbkluTDhwcmQrYVM5U3lkOGFvL0lsV0dnRXJEbElESXRINzg3?=
 =?utf-8?B?cFpQclNmN3hrYS9wTzFlMGpTdnQ5ZG81T2lDejhPNlFuTkZjbHY3ekVPZkZB?=
 =?utf-8?B?QTJQN1pVNXVwbDlDekVNRFFpMkxwWk5uMkJMN1duWmxOTnhPakVwK1JnWUFK?=
 =?utf-8?B?aDVxaGo3YkNjeWZUSzBYOGRMYWhBaG5GNWhWYVl4Nlc1OXJxZ2xXRUIzMytR?=
 =?utf-8?B?N0szTzRlamhFZnNWVm9vcXRBejdXSjNNMi9pUjQ3UXNOb1ZwM0hETVdjK1E5?=
 =?utf-8?B?V2gycnJvNzdaUVJITStVdTh2Q3B3SW0xMThZRytoYWZtTWdncTFuZmY3bkhM?=
 =?utf-8?B?TUY0MGVjTXBiTDZ0MzBMRWNBRVFGMGdYSFBvWncrTHNrM3pFRzY1SHNPc0dU?=
 =?utf-8?B?SlJER0Z4VHZUUUtvWS9GZlhhRnFueklSeGFJVDNVTXpldHpPRU05RVBjZm1Y?=
 =?utf-8?B?bzUxb3luOVFPRVRXekxBblFJaDBvNnVlVGQxSkRwQVZScmR5NXFGVnlsQWtm?=
 =?utf-8?B?SXpjSXRlSmx0R1VtTjJiTkRKQUt5T28wUFZjTFNDODhLNWNYVXM3Y0NBS3Rz?=
 =?utf-8?B?RDNFNUVxZ3dkcTF4NmxUTXg2ZzlYN2lWaEVxbi9RWjBMaEtHYVNoY1VvbHVs?=
 =?utf-8?Q?zEEFdFpC0Xe1lOZi7DorILHbO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b6debe-1669-42c7-7696-08dd7773d8fe
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:36:00.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKc5ryWSPav2CsuRzUzQ30o4Q1v4KWj6WyDtMoQdS3hC/Hxy5BqIpdk+E07GZcYNrKNk5UOVFs4giEvLeQNlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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


On 4/8/2025 9:30 PM, Alex Deucher wrote:
> Switch from a bool to an enum and allow more options
> for enforce isolation.  There are now 3 modes of operation:
> - Disabled (0)
> - Enabled (serialization and cleaner shader) (1)
> - Enabled in legacy mode (no serialization or cleaner shader) (2)
> This provides better flexibility for more use cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 16 +++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 39 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 11 +++---
>   12 files changed, 93 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 804d377037095..468c6ce09e3ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -230,7 +230,7 @@ extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
>   extern int amdgpu_use_xgmi_p2p;
>   extern int amdgpu_mtype_local;
> -extern bool enforce_isolation;
> +extern int amdgpu_enforce_isolation;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> @@ -873,6 +873,13 @@ struct amdgpu_init_level {
>   struct amdgpu_reset_domain;
>   struct amdgpu_fru_info;
>   
> +enum amdgpu_enforce_isolation_mode {
> +	AMDGPU_ENFORCE_ISOLATION_DISABLE = 0,
> +	AMDGPU_ENFORCE_ISOLATION_ENABLE = 1,
> +	AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY = 2,
> +};
> +
> +
>   /*
>    * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
>    */
> @@ -1224,7 +1231,7 @@ struct amdgpu_device {
>   
>   	/* Protection for the following isolation structure */
>   	struct mutex                    enforce_isolation_mutex;
> -	bool				enforce_isolation[MAX_XCP];
> +	enum amdgpu_enforce_isolation_mode	enforce_isolation[MAX_XCP];
>   	struct amdgpu_isolation {
>   		void			*owner;
>   		struct dma_fence	*spearhead;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 4a5cd7a111fc4..34a688fc5bf35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -296,7 +296,21 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   				       num_ibs[i], &p->jobs[i]);
>   		if (ret)
>   			goto free_all_kdata;
> -		p->jobs[i]->enforce_isolation = p->adev->enforce_isolation[fpriv->xcp_id];
> +		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
> +		case AMDGPU_ENFORCE_ISOLATION_DISABLE:
> +		default:
> +			p->jobs[i]->enforce_isolation = false;
> +			p->jobs[i]->run_cleaner_shader = false;
> +			break;
> +		case AMDGPU_ENFORCE_ISOLATION_ENABLE:
> +			p->jobs[i]->enforce_isolation = true;
> +			p->jobs[i]->run_cleaner_shader = true;
> +			break;
> +		case AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY:
> +			p->jobs[i]->enforce_isolation = true;
> +			p->jobs[i]->run_cleaner_shader = false;


Hi Alex,

Even for legacy enforce_isolation, just to double check, we expect 
cleaner shader to run, cz by default when we trigger modprobe amdgpu 
enforce_isolation = 1, for this usecase, we expect cleaner shader to be 
triggered that means legacy , am I correct pls?

Best regards,
Srini


> +			break;
> +		}
>   	}
>   	p->gang_leader = p->jobs[p->gang_leader_idx];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8b43f350447a9..700304bbe3982 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2115,8 +2115,26 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   
>   	adev->firmware.load_type = amdgpu_ucode_get_load_type(adev, amdgpu_fw_load_type);
>   
> -	for (i = 0; i < MAX_XCP; i++)
> -		adev->enforce_isolation[i] = !!enforce_isolation;
> +	for (i = 0; i < MAX_XCP; i++) {
> +		switch (amdgpu_enforce_isolation) {
> +		case -1:
> +		case 0:
> +		default:
> +			/* disable */
> +			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
> +			break;
> +		case 1:
> +			/* enable */
> +			adev->enforce_isolation[i] =
> +				AMDGPU_ENFORCE_ISOLATION_ENABLE;
> +			break;
> +		case 2:
> +			/* enable legacy mode */
> +			adev->enforce_isolation[i] =
> +				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
> +			break;
> +		}
> +	}
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d7b27b7a0d519..5132003d85a29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -179,7 +179,7 @@ uint amdgpu_pg_mask = 0xffffffff;
>   uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
> -bool enforce_isolation;
> +int amdgpu_enforce_isolation = -1;
>   int amdgpu_modeset = -1;
>   
>   /* Specifies the default granularity for SVM, used in buffer
> @@ -1038,11 +1038,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>   
>   
>   /**
> - * DOC: enforce_isolation (bool)
> - * enforce process isolation between graphics and compute via using the same reserved vmid.
> + * DOC: enforce_isolation (int)
> + * enforce process isolation between graphics and compute.
> + * (-1 = auto, 0 = disable, 1 = enable, 2 = enable legacy mode)
>    */
> -module_param(enforce_isolation, bool, 0444);
> -MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
> +module_param_named(enforce_isolation, amdgpu_enforce_isolation, int, 0444);
> +MODULE_PARM_DESC(enforce_isolation,
> +"enforce process isolation between graphics and compute. (-1 = auto, 0 = disable, 1 = enable, 2 = enable legacy mode)");
>   
>   /**
>    * DOC: modeset (int)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index ff53401aae5a4..9b4272fbc470c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1460,6 +1460,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   		goto err;
>   
>   	job->enforce_isolation = true;
> +	/* always run the cleaner shader */
> +	job->run_cleaner_shader = true;
>   
>   	ib = &job->ibs[0];
>   	for (i = 0; i <= ring->funcs->align_mask; ++i)
> @@ -1591,7 +1593,7 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
>    * Provides the sysfs read interface to get the current settings of the 'enforce_isolation'
>    * feature for each GPU partition. Reading from the 'enforce_isolation'
>    * sysfs file returns the isolation settings for all partitions, where '0'
> - * indicates disabled and '1' indicates enabled.
> + * indicates disabled, '1' indicates enabled, and '2' indicates enabled in legacy mode.
>    *
>    * Return: The number of bytes read from the sysfs file.
>    */
> @@ -1626,9 +1628,10 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
>    * @count: The size of the input data
>    *
>    * This function allows control over the 'enforce_isolation' feature, which
> - * serializes access to the graphics engine. Writing '1' or '0' to the
> - * 'enforce_isolation' sysfs file enables or disables process isolation for
> - * each partition. The input should specify the setting for all partitions.
> + * serializes access to the graphics engine. Writing '1', '2', or '0' to the
> + * 'enforce_isolation' sysfs file enables (full or legacy) or disables process
> + * isolation for each partition. The input should specify the setting for all
> + * partitions.
>    *
>    * Return: The number of bytes written to the sysfs file.
>    */
> @@ -1665,13 +1668,29 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   		return -EINVAL;
>   
>   	for (i = 0; i < num_partitions; i++) {
> -		if (partition_values[i] != 0 && partition_values[i] != 1)
> +		if (partition_values[i] != 0 &&
> +		    partition_values[i] != 1 &&
> +		    partition_values[i] != 2)
>   			return -EINVAL;
>   	}
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -	for (i = 0; i < num_partitions; i++)
> -		adev->enforce_isolation[i] = partition_values[i];
> +	for (i = 0; i < num_partitions; i++) {
> +		switch (partition_values[i]) {
> +		case 0:
> +		default:
> +			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
> +			break;
> +		case 1:
> +			adev->enforce_isolation[i] =
> +				AMDGPU_ENFORCE_ISOLATION_ENABLE;
> +			break;
> +		case 2:
> +			adev->enforce_isolation[i] =
> +				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
> +			break;
> +		}
> +	}
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   
>   	amdgpu_mes_update_enforce_isolation(adev);
> @@ -2026,7 +2045,7 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
>   	bool wait = false;
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -	if (adev->enforce_isolation[idx]) {
> +	if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
>   		/* set the initial values if nothing is set */
>   		if (!adev->gfx.enforce_isolation_jiffies[idx]) {
>   			adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
> @@ -2093,7 +2112,7 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
>   	amdgpu_gfx_enforce_isolation_wait_for_kfd(adev, idx);
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -	if (adev->enforce_isolation[idx]) {
> +	if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
>   		if (adev->kfd.init_complete)
>   			sched_work = true;
>   	}
> @@ -2130,7 +2149,7 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>   		return;
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -	if (adev->enforce_isolation[idx]) {
> +	if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
>   		if (adev->kfd.init_complete)
>   			sched_work = true;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 4c4e087230ac5..359c19de9a5b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -588,7 +588,7 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   	}
>   	/* alloc a default reserved vmid to enforce isolation */
>   	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
> -		if (adev->enforce_isolation[i])
> +		if (adev->enforce_isolation[i] != AMDGPU_ENFORCE_ISOLATION_DISABLE)
>   			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index ce6b9ba967fff..f2c049129661f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -78,6 +78,7 @@ struct amdgpu_job {
>   
>   	/* enforce isolation */
>   	bool			enforce_isolation;
> +	bool			run_cleaner_shader;
>   
>   	uint32_t		num_ibs;
>   	struct amdgpu_ib	ibs[];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 36f2e87161264..38ea64d87a0ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -768,7 +768,7 @@ int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
>   	if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
>   		mutex_lock(&adev->enforce_isolation_mutex);
>   		for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
> -			if (adev->enforce_isolation[i])
> +			if (adev->enforce_isolation[i] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>   				r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
>   			else
>   				r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b5ddfcbbc9fc9..dadf6715b98be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -676,7 +676,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
>   
> -	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
> +	cleaner_shader_needed = job->run_cleaner_shader &&
> +		adev->gfx.enable_cleaner_shader &&
>   		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>   		&job->base.s_fence->scheduled == isolation->spearhead;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 344d32268c3cd..f7aa45775eadb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -724,7 +724,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   					mes->event_log_gpu_addr;
>   	}
>   
> -	if (adev->enforce_isolation[0])
> +	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>   		mes_set_hw_res_pkt.limit_single_process = 1;
>   
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index be43e19b7b7fa..b0e042a4cea19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -762,7 +762,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>   				pipe * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
>   	}
>   
> -	if (adev->enforce_isolation[0])
> +	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>   		mes_set_hw_res_pkt.limit_single_process = 1;
>   
>   	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 2893fd5e5d003..fa28c57692b86 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -43,7 +43,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>   	memset(buffer, 0, sizeof(struct pm4_mes_map_process));
>   	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>   					sizeof(struct pm4_mes_map_process));
> -	if (adev->enforce_isolation[kfd->node_id])
> +	if (adev->enforce_isolation[kfd->node_id] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
>   		packet->bitfields2.exec_cleaner_shader = 1;
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> @@ -102,7 +102,8 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>   	memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
>   	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>   			sizeof(struct pm4_mes_map_process_aldebaran));
> -	if (adev->enforce_isolation[knode->node_id])
> +	if (adev->enforce_isolation[knode->node_id] ==
> +	    AMDGPU_ENFORCE_ISOLATION_ENABLE)
>   		packet->bitfields2.exec_cleaner_shader = 1;
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> @@ -165,9 +166,9 @@ static int pm_runlist_v9(struct packet_manager *pm, uint32_t *buffer,
>   	 * hws_max_conc_proc has been done in
>   	 * kgd2kfd_device_init().
>   	 */
> -	concurrent_proc_cnt = adev->enforce_isolation[kfd->node_id] ?
> -			1 : min(pm->dqm->processes_count,
> -			kfd->max_proc_per_quantum);
> +	concurrent_proc_cnt = (adev->enforce_isolation[kfd->node_id] ==
> +			       AMDGPU_ENFORCE_ISOLATION_ENABLE) ?
> +		1 : min(pm->dqm->processes_count, kfd->max_proc_per_quantum);
>   
>   	packet = (struct pm4_mes_runlist *)buffer;
>   
