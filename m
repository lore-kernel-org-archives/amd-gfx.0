Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70EFC02196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535FD10E854;
	Thu,  6 Feb 2025 13:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5L22DNx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF8C10E850
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvQ9dG8Q+BXcpIkXwVc/AvK6kULBmFOmnjBNK3cg1VTeaZnsEu1f53vn4lQQ1/Zx8C/+MdcObdq4fhvYj4Y4rNxCadn1AbYtaoHxn/otcg4ir9FNzVbHb/sZ185Ssp8B0NNtK1Zvya+uHHuJjo/LJAEyDX3AOnCwYj+iOruHTGLnir+QAiJR8V3AYu3wHuqke6JtSPosIqIQzplA7FS9ufZQYk4LAZHMVEnm1uRX6qxJcqhSDmJkCykpuaSm31XRuewM0zx/eOUUng+qYFxaCn2v7oumMo43uZGakeNqNFKp6aD+hkyrNzUPjFY1iRffASVxNjmXR2pf+eXDJqNxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q39oNBmK5tnXU361ecUdZMyolHOgkd54FuVPGxWKw50=;
 b=SwSB/niCANDg71mk/GSUgyBJ/NENF6mcHsU7cJ2b8pOUlPXOpfJwR7majkaEHgWy/HjfWt1HTticpfQFuc2xaxUIGhFLHggN9jqlxkJt/xjANOzEwHVbM75Lusj/ac1MYMUKM7O06pQ2FSWL4MDG0DpVqwAAlf8WrYpoOhdRCNnIyM/ITIm8ylZjkd2DzgXuGJdmSU7xN2g/+9jC0asJMtA8GiK7fhNo3MOGLxNdX4RTwqh4d0KJf3nw+LPVBwoUDFFKbFwyvZvvGSotBmgvy8oEIzhEfo0c7H+YbL1W4vPViQre4D4HZs0zfltiiJl2VzbBjS2Z0N+k8zvD7pwH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q39oNBmK5tnXU361ecUdZMyolHOgkd54FuVPGxWKw50=;
 b=F5L22DNxczYX+hsuTaHQxhYzTshiPcg/lGQAlRPUcF3YnYWaEJ09KogO/T2I2Z5jShtsVph0V4jIu1R2QeafDcj+DzgpTC7kQQr4P0IwjwUSGWZqdieFbBwNHV/EHcCfFDBWGxFD3EbQrXXt4zEHwSBTyXdw7Aca9s7+214eE4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:54:31 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:54:31 +0000
Content-Type: multipart/alternative;
 boundary="------------Xp9yJImNOhPyxlTqaklouDfe"
Message-ID: <a89761ff-8852-45c1-9cfd-34d51fb4ee55@amd.com>
Date: Thu, 6 Feb 2025 08:54:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/44] drm/amdgpu/vcn: add a generic helper for
 set_power_gating_state
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-34-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-34-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::18) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: eebf3343-4c3e-41a6-8344-08dd46b5c7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjllM3dBNGZHUVdaLzk2NGMvSHIrV2oyWlN0SmF4UmZEK2dkNjN5M3NQcTdF?=
 =?utf-8?B?SUZRMFlqSktXZGNIL0RPK0xjcTlvenpsbXB3NUtpWElONDRYdGVVUllDNlk3?=
 =?utf-8?B?c3RudENsdGZ5OGhLMmhLaG01Q0MwZ1hHK2tHQmN1OGR4bU9pUzdSZHh0cEtn?=
 =?utf-8?B?c25VL3dlcHlJRDN6cTIzTFBKVUhLQjl4TkxONkJLNWpUeDhNUHNqV0tZK21w?=
 =?utf-8?B?UC9KenhJRERCUW0vYTkvN0s5TGd2V1N5NHdxNGJpZ3g0eVF0THpJTDh3c2VM?=
 =?utf-8?B?alhWbXk5SndxSzhaYUpyWEt6SjJrT0pEMUJPZzVianB4T1RIRE1OM2ZNQXVQ?=
 =?utf-8?B?bEVyVUwvRW8wcmNJY0xZZnR1a2ZtMmxqaU95WDFLTXVCWmFWaXNZZnF2aHFM?=
 =?utf-8?B?Sm1NbmxiVWd1S0RrRTNxSVpVMTI1eTVmU1g2Nk5oY2RHU2d4eVJsTk1EaGM2?=
 =?utf-8?B?emN3WDNKU0xGN01UUXU1TDJYem5yWjd3SkcveFBLSXE3MFpjTEVYMk1YeUVm?=
 =?utf-8?B?R3FicStjdGp3UlRJOWsyZ1F2c1Y4WEJtd2p0NUdNbFczUm1oOWplbHM1ekh5?=
 =?utf-8?B?WEE2dUxRc2VHMnVDZXFNSnJKYVYyV1paTnE0RGpJVmdORHJwTGxWMGlpUjk4?=
 =?utf-8?B?elREN01uOE5sQWtPTFBNcm9JbytoenY4MTRNZWZsZGtjaHR5V01JRGpXQUMy?=
 =?utf-8?B?UUNBQVZyR1NvR1Jyd28wZjZETEtIakhFVkt0THZDdGhHZVBaeVJ4ZnVaWTEz?=
 =?utf-8?B?MzFLbVBkbEo3ZE5hSU4xY2h1MXdQSVNxNkNwdlBnamFRaXJOYS9LMTBVbHhn?=
 =?utf-8?B?UnR5RCsyd0xHZSthcUlTTUc4Ung2bFdRelFZV3dEU2J2NFRjUXVFc0JsR3hJ?=
 =?utf-8?B?YU5BYUwrMmw1NWVwakxaWEp4WHExQmxYZFRrRk1zNkpFSXRHaTAxSzF4aVc2?=
 =?utf-8?B?RFQ2ZmdsZHVJbE9KUEg4a216aTdIRThHRFBGUmhXTlVta1VqUWdTL3RRTXlr?=
 =?utf-8?B?YS9lU3B5YiswTklBamVkS2FCV0dRaEdydXFFZUtKbnVVdmhzSUhpekVyaWMv?=
 =?utf-8?B?S214V2g5UHNzZStxS1V3N21XRUpuTWQvSng1YkVPelJTU3Y2TlJ0ZFRvWkl6?=
 =?utf-8?B?L0xGRTV1a2U3YVlNVW83a1BXQVpha1Zwa2JyaVlCUUZMdjVXMS9wdGJtbnlt?=
 =?utf-8?B?UmduWEJyamlmUnVVVHhFeFh4ZzRpVE1CWkFDQWZXWWFCaGdtY1lOSEkvdWx4?=
 =?utf-8?B?cW1ZbUtEMkIwdmJjWmxuWXV4anJEaGNGUm9tQlpySUNSdjhGR0xRQnlJY0VU?=
 =?utf-8?B?aGhhZU1qRmhPRzlPR3FuRklLS3VQcHlzNzdSaU9IbkRzSXBKakFUc3FzaDZx?=
 =?utf-8?B?aTNiYkxiWC9ESndKaW1nclNhUlhaREhlcFl6bXE3bWFyRk1LL2U5OW8rTUpM?=
 =?utf-8?B?WW5CL0JwT2F3Q0d1Qkl2UUdrUzNtMHVDQ3hncUVha1dJY1lBL3l5ZUFUMkFS?=
 =?utf-8?B?UnVOSXJiY2FlWEVyWVB5SG13bWFNMVhFSmpDTk1ZTnNmbXIyTU45OE9xYXZV?=
 =?utf-8?B?N2xRZjQyQTMxaTFicHZwNmZZK1FrK2RCVWtOajd0UEIwT0ZQYjNvNnZZRWs5?=
 =?utf-8?B?RTlTT1p0Vit1cG1ldXhDc2NpSThVMDI5YW5JTVVKQi9ZNk1aSWQwU0J6NHZV?=
 =?utf-8?B?ZjIwY05uMUZKRFBueUFSMUlYNHlqNUJZcHZNaVhtcVBCWXI4SDJmSnNhYmNB?=
 =?utf-8?B?bHJlVVV1TkovOEozWXhmc0U0eFdxTmQ3NmRkTzNETzBKb3Y1U21FRjMwbGNl?=
 =?utf-8?B?ZXZjdHZnZTBibS90WVV1MWxXZldOVThFYmNrZ0NWVzdMVUsyYnZrUmFCckto?=
 =?utf-8?Q?pqPE/a94hUmnB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhMc1FzZ2NDdVRrM1BSQXFodGwyaXB5YlBEOTA3TlhsUGNOWUd5TVJod1lB?=
 =?utf-8?B?Y1NoNkx5em41bzl5eUV5MFJ3SUlaRDBsZWJmNFBBaHh1dzl2ZU92eHFSc3Ex?=
 =?utf-8?B?UGozelZEa1dUVWV0c3AzWHQ0RWFoSGhpZFRLdXpRN1pWaEVBd29JTERTckUx?=
 =?utf-8?B?aWM3Y0loZytnMlFCVFlzbjB0NHoyMmVheGx2WkFucjNwQ29RVXNLTEw4QkM4?=
 =?utf-8?B?MTc1OUU5eVRqNXZSQWNpRlA3OVVOenZmWnZlVENHWW95bVRYTXNxUTZjMEkv?=
 =?utf-8?B?YkI1OVBnOVIwc2hxWE4wcE42U0hqVlRBb2tROFhJRUM1TEVXbUNRNEVoVFFV?=
 =?utf-8?B?Q0Y2d01RRWV3NC9PcmJJeU9RdHpGTitna3h4dkFyTVlJUDNYWXhId3hPSVM5?=
 =?utf-8?B?M0ZQQmNVcTFHQmZiNENCYVJWOTRNWnBWUnRMQ1YraHBnaGU3b1JHaDlGTXB6?=
 =?utf-8?B?MTMxNFQxTDRVUFhVMUpleUVsZlFIT1FEMENxSEd3Rk9sblZ6UkkvZ0Y1Tjc4?=
 =?utf-8?B?TENXU3BFRi9HSUFsMGtVbGFOdDR1cFV2Wkg2S1lDVVBCaEZtU3NvY0NkVHNs?=
 =?utf-8?B?bnNxSVQvZFlDTHNJUU8wa3RtbHBTSTdEc3N1ZHF3WHdRVzdQcTZVUTkxRjRL?=
 =?utf-8?B?MERQS1UxKzVXcmxpQlRyNXFiSG1IOVpIcFVJN2VpS1dmdmNRejVBRUNkMEgr?=
 =?utf-8?B?MExrQ2ZMTGNadUhQck9UZmlxRmVVdjFiN2cvaTgyNE9sUFhJVVA1TjVEVm5O?=
 =?utf-8?B?ZUFZQ1NTOXluaVdOcG1QQmxSRHl6K2Rxai9ZYTJWZmk3YkNRdGRVNERkeTFF?=
 =?utf-8?B?ZnhCQkxDTUYwMHpvMmFCeWpyaTBrVFBLQ2tjVHhUZUVTbnZZeGJlZ0dGNGFG?=
 =?utf-8?B?ajY2S3VLSXArZExhZUxzYnZ3cXFVRktqZkFMTmt1UjdyckZQc0gvSndad2RH?=
 =?utf-8?B?V3RSa1J2bE9hbzIvRWhrUlRiTzlMSWFFeXRoRmxsWlh0Q2UwMkFGWG9MYXV6?=
 =?utf-8?B?NWxOcFpDY21BNERCZnlZcnBYYU4rR0JyM3FEaHVwb3lnbnZZQ1lDdGoybmlI?=
 =?utf-8?B?NnBjSzRCdGRjSURlb09mN1lJZWp6V3A2eFJiYS91UG5SQ0hnRFd3a1EwZW9P?=
 =?utf-8?B?dHd4cCt3MVFTUUJnc05FY2IxUXIrOVQzUjAwakc3UTdNa3hUNjZ4VWhjYlJs?=
 =?utf-8?B?NG9KOURic254RmFUZ3A0Q3ZLOEJhSndlWVZyMmRVWHZGN3NLZzllK0wxUGp4?=
 =?utf-8?B?QTZFNFJvM1F5dlI2dFN6ank2OVFnWmx2c3BBcTFzTGhTdytHVWdvdDdqL0oy?=
 =?utf-8?B?QW5wTkVDaVZiUnZlc2RVZmhRWGUzR1I3anZKY1dmMnJRU255SnRTcWVYMHZt?=
 =?utf-8?B?eEZ1cDdFVTF6OXl2ekJicE13KzNGY0t0RnNFTXRYSnFtL0xLYnNMRnRnQ2J5?=
 =?utf-8?B?T2JWM3VIVmNaL0pSQmx2VWNVNXlvOEd5VVZCaVl4NGtLdHg1Z3RuQ21yL1J0?=
 =?utf-8?B?QXZKOWtuNTh0NzVpTGNTb3hsdmRCWW5YYk1Gbm9SdzNpM0dHeVhvcE5xZk9x?=
 =?utf-8?B?Zk9uMGhIWFZyWnB0WlZqbVRuS0dWcHc0V1JLd0RZb3h3eHdrQit3cDFYUjRJ?=
 =?utf-8?B?WldzTy9yandHV256ZkVCb3VJSkF4N1VVcEM4Q0R1SlUzVExyUWV2cHZKRStZ?=
 =?utf-8?B?d0xyNmxTby9ocm5uQUp6Z05PQjBuYWcxTWhyZFg1eHZ3aWF6MEowRC9Sam1B?=
 =?utf-8?B?Sk1KaDRQcVN4V2lWMDN5cXI4R0hoY1NWQTZuM2g4SXZHdEFNblFYcHlVMTNX?=
 =?utf-8?B?eThKS2FreSsrQWVWV0VWZ1BJK0VaeFNGRG5TT1ZYRytyNUpKTzNJTTVmVG9t?=
 =?utf-8?B?SFVyRkZCVVVNSlRNSzQrUERtL1d0V29ObXYzZFA4c1UyeFM5bUZaYmhoUXd5?=
 =?utf-8?B?Kzc0bUF5SWVFaS81RXl1U2N6Y0F3ck5jV0ZGa1E3OWNiMTQ4WGtLVU5sRE1m?=
 =?utf-8?B?b2crZXRkSHcxNlB3L08rZFhXYmpGdWdETmxjK3lVRGdQL2lXZnd0emxNWHpu?=
 =?utf-8?B?a1FaRVBwZzFyMXlzWWpwL1FYS3B0Nm9wd003SzVuS2RDekZ5Znh4MTRxbXJa?=
 =?utf-8?Q?NegzJJsLuucQkiAL6A05D6/4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebf3343-4c3e-41a6-8344-08dd46b5c7e5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:54:31.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMyi4f6n8ZUrqU6mclOfHR7HnYO9KM+sGWHJ+/8wkuHxHFHcmTraX2NVGkaVrGU2jBlZkx7ogHwJQwXHGtK0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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

--------------Xp9yJImNOhPyxlTqaklouDfe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> It's common for all VCN variants.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Patches 33-42 are

Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 81bfd8a9d8268..e4ef0fb970b29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1397,3 +1397,26 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_vcn_sched_mask_fops);
>   #endif
>   }
> +
> +/**
> + * vcn_set_powergating_state - set VCN block powergating state
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +			      enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
> +		ret |= vinst->set_pg_state(vinst, state);
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 508fa022df78c..a023f46ec904a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -546,4 +546,7 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
>   void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
>   
> +int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +			      enum amd_powergating_state state);
> +
>   #endif
--------------Xp9yJImNOhPyxlTqaklouDfe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-34-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">It's common for all VCN variants.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p>Patches 33-42 are</p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-34-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 81bfd8a9d8268..e4ef0fb970b29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1397,3 +1397,26 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
 			    &amp;amdgpu_debugfs_vcn_sched_mask_fops);
 #endif
 }
+
+/**
+ * vcn_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			      enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0, i;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
+		ret |= vinst-&gt;set_pg_state(vinst, state);
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 508fa022df78c..a023f46ec904a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -546,4 +546,7 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
+int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
+			      enum amd_powergating_state state);
+
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------Xp9yJImNOhPyxlTqaklouDfe--
