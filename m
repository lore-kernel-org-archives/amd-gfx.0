Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70723C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 03:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D1E10E30C;
	Fri, 10 May 2024 03:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5KJR7Ndx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFB410E30C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 03:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XThJulO6UIOobMgH09oqhwDgtEQdLgwXBBZVEaupqu2OxNKy91N6U+cArtVpFlIo+d8/pYhrKW0diLYKdo4vmsGQ8725Ct17Le19o/JrgODOG2ju7mjyFnL0oGPU5plVTJMS4/4tIu4l67kBnL1GfB38LgMDz9cwUoKtQq6L27kuCuZDtpRFSxraG2EBxnlyhC5a37WCrXN9ffZCLDT4WOB4wHoylU8lP1qNW7PDj7xDhjopBfEhc2+l+p9ETHSJy+Dj72Eu+arRp3kg3fUbzatpQAG3UeaNrXrBydKvv/paR7Iyd1to4EaXo9YFfz05tvS+COAeI8lPgSykm569lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HrGyIlNiXs/L07n/D7PiuEmk4uP9dGgBN3cZQwED6E=;
 b=BlXCLrlv7Uqg4fD3EhYL78+Q1ddjU/lrvIbsl/Ss6GNZKLWJTt69bccX3j4NYpQBaeY3C5IKA7NwCceQtU4eukEIRAFDwZFu7NzpOlImRM4qpt0Q9ua98hXhH2aS/xXgTUh0tTAYiJbefjPnrrTOVNnpxzeZX5cT3eoELDAsSuMu/olQAc7vEM/miC6viGu1cKd/oKlNxR8R+poFclpvD+w8LVweKDhFoV14Lih4c4u1X3O/SnobkX+IDWiISYd35X4rv+g/iRXdy5e6o43QI+Ul3BCkgsTbiTzKIVfVw2RHZTP7HsUFvo8DiE5i8OAonpZQdvHKYQ2MpFs2+69ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HrGyIlNiXs/L07n/D7PiuEmk4uP9dGgBN3cZQwED6E=;
 b=5KJR7NdxMs71yvmFmHfFVPKHkhdlcKapzaXBAxTFx3mntJpIGdXMJ6l+tBi6ecFIL9/kbec+Mzm9RsfIFzm09P+34UFJ/CGPTvq5DeerEhP7ZXiCIV8e1aFgkcp/rxENEWKH0IkyIPy6M+yk37EGKnBjKRMg7kbEDKHtUnSSg5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 03:29:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:29:48 +0000
Message-ID: <2368ea5f-9d43-4638-824a-fce50eaddd2d@amd.com>
Date: Thu, 9 May 2024 22:29:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amd/amdgpu: Add ISP driver support
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mlimonci@amd.com, benjamin.chan@amd.com,
 king.li@amd.com, bin.du@amd.com
References: <20240509215001.515866-1-pratap.nirujogi@amd.com>
 <20240509215001.515866-3-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240509215001.515866-3-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:806:d2::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ae9243-a7da-4cf4-abd3-08dc70a1721f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2crei9hYWFxVXhYbDBrM0JZa1FzRVhuQjBxMnVoSWVrSjY4MVVXUXlhaXFQ?=
 =?utf-8?B?YUNKNjlJQmF4M2tydXUxYW5BUmgwTkdibnZJMm1LbDZsbnRKdGFBdkJTZUJR?=
 =?utf-8?B?ZTRrc1U3OUtJZUh6d2R3VXNCdlBDRmNuSUw5MlFUK0syR0ZVbUVQR0I2MmNh?=
 =?utf-8?B?Mmx1SjlCZHI3UTI1NzZVelphQVA5YmJ1TWdmUmE2bTE5NGtmWTRVUmhlV09y?=
 =?utf-8?B?SGZsSVRMNjdEOGZBZjNLMllMaGRiOEJnSWZnNE4wNkZjbE8yRUtwaDMwQ21x?=
 =?utf-8?B?RXoyRW9RelNKSEFsSk5ERUlYam8rVWdGMFFBSzNIZnJxQ041Rk5jeSttWllX?=
 =?utf-8?B?SnNNbFc3L1lMaXR2UkxjcnRuMy83bmlnSEdkbnFPNkVaSXNMYlJtZ1V2c2I0?=
 =?utf-8?B?RnBNRUlSWER1R2ltd2Y5SGVIclVPWUlOT0pMczgvbFB2ZVNpakRkU0kxUEdU?=
 =?utf-8?B?RzFaU2t0dkxNMkE3alZnRW5RVk1KODVlYTJtbmNoZGF4c2hFalZTSEw5QkdE?=
 =?utf-8?B?UnpGSmRML2tWbENJL1lNV1BjSXN0ejA5T2cvdWJSNU9rZ2VYa1IrcTcxSWNG?=
 =?utf-8?B?T1ZPdTF1Q3hhUURSRjdzOUFidXdHVHRmeHcxd2FZT1V3Ulg4YmhzeGc2WlVJ?=
 =?utf-8?B?TjZYZ0Y3YUxNM2xMYzR4N3grRUdEd3VVN0VIY0lTZ3ZBU0lZSHcwem9BWkhk?=
 =?utf-8?B?dEFXTzIvZDJ3NkpWMElOcUtUM3JWV0VNVGRUWHZmQkladWd6MFQ0b0hLc1U1?=
 =?utf-8?B?c21GVFpsU0pOanVqUUx0enlYbTE2T3FUM3JkVmtZZ2VmSStKY01MQmVNcGlC?=
 =?utf-8?B?NnBiT1N2dUZQSjNZRjBjYWFLcVJlODkxdGZTb09rM2pZbnlEY3BMdWdId1o2?=
 =?utf-8?B?MVhyamh4dDlaZzNhUjIwbzh5ajd5OXRlMFNwMFoxSDJ0dGJQN3AzdTk1N3lh?=
 =?utf-8?B?SWIvY1BtNUgzd1lpKzJIcG9vbGZYTkN2d1B4MFRqWkRCbWVSTkVXYWRJQW5M?=
 =?utf-8?B?b21JMVhGdFlRUGJiaW1ObEt1RDZSVDZVMWpXa29CamMwNjQxQ1RnS3VVbkJh?=
 =?utf-8?B?VDQ0OHkxaUNaWVBTSGgwRllRMmRrNGJRL3o0dmRZVlZ0UGk5cWlpWldoY1Vt?=
 =?utf-8?B?Y3NTZ3JKRzhjOGhpUGZMckduY0hOTHg0WnJuMVFJVlNrNU8wRTJUYzMxSGxx?=
 =?utf-8?B?RTlDN1poVWdBaWdDSU5PMWxTTk9SS1lVV3JBaWNPblNoSElLLzI4RXhPWUx6?=
 =?utf-8?B?ZUJ6SmdKODlYMHQ1a1hvOVpIUUpRb1JwRDV2ZkdUR3FSU2tuSkpLVmpYMDBG?=
 =?utf-8?B?a3hRQlhFYS91cUJzZ21yVU9UaEl2Tm1MU2pObGh4K3Q5NkxIU1g0UE95UDA5?=
 =?utf-8?B?c1FOV3RqUEJGM1VRcWZDUXY3WFJlVUVoTDJwOTBvVGQzTzcrM1hzUW84U0pT?=
 =?utf-8?B?NThJZVd6RjBBKzc5OEJpWkZjYW9qVUxmZmFCaXY1VjFBdGw1NWdNQVgwYitO?=
 =?utf-8?B?WHF3VVV0T0xWYXp3d1p6Ykp0Q2J5eElhNjJyaDZVUlRNekJwclgzWXVaMS84?=
 =?utf-8?B?UXJuU1hFQnBiNEIvak9mY3lLUm9VZUlJWENBZnllbG1oZDIxVkptZ0RER1RT?=
 =?utf-8?B?enVjZlgwZmxERG9OVmswUGtyL1RoSmFNTkVLdTNoNTE2VjRLYm45Z2ZBWEF3?=
 =?utf-8?B?WUhtbWxUY0pjd2FucExSb28rN3hlMElLNzFjY0NjQWdqeUpYOE9XMlpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhSTmEyU0tTSEplNkdJeFlRTUFNNjNoOXU2aGN0ejRoTndCMU1BdUt0Rmdh?=
 =?utf-8?B?RW9peXhQVjdtUXRJbXN2Vk9XbHo3eVdldEI4bHVXbU1IMitoWG50QWlmNmVh?=
 =?utf-8?B?aXg5dnF5a290Rkg1YkVTRXdnU0VjY0FNd1Q5UE1odlUrUHRYYnhkZld0TE1K?=
 =?utf-8?B?Nm9tZWs4OUJqbzJFc0U0TnVhQWpvdVdvN0twM01yYjM2ckFzcFBPSnU2VXk3?=
 =?utf-8?B?aUhHcnJuV2JGbGFPMTN4bEZSY25oNGdDUXp4SFR3cUc2MjV5R1NTWjNnb0NY?=
 =?utf-8?B?ZFVjT200T2hEdTNuUTBJZkVlcTdDdEJONFhwaDBLQXh3R0VBbjVER2hsd3Vn?=
 =?utf-8?B?eTE4L2xablVVZzJLd01JcXVUcWlPUXlhL3hxSzlLMDMzZkNTTEE0THVKSnhD?=
 =?utf-8?B?WExucjhtSmtmVEVRWjJWOXZxL1NQSVdTOGpFWmtRclpUdVdBWS9WbHh0ZFVR?=
 =?utf-8?B?ZzR6L0JDbU13Uld3NEl5M1hEVGQyMkwrKzZoWUVpVDRIUy9USXZhcHN2RlJE?=
 =?utf-8?B?R1A0YzloUDA1a1A1akVneU9Pc1oreWF5SVlrL0ovYStaOG5ncG1TeVhLeEFE?=
 =?utf-8?B?SUttVWV0WmdFYTNnTG5XdFFoNzBkTWJQUkJ6bmVURkM1M29aQUhtTlBxbUlP?=
 =?utf-8?B?emxVbnFxTzJVenluVzdFc1BSN2NUN2ptYVRzNnhrei9adS9GZ1VIU1RoL29P?=
 =?utf-8?B?MTM1YXRZSkxlcHVjODlkZUJOTlh6YUoyZXRXUXVoRzZHSmVIOGcza2xwWlQ1?=
 =?utf-8?B?bEoyd0txN3RNaUtrQkczbTFSVWhLZzJOc2tlaXF2K3c4b3Vtb1RrTXE5cER6?=
 =?utf-8?B?TE0wckU5NWFuUjF6UGJpYmIxN3A5UHZnU3czajJLRko0YTJQV2I5c3JYdTAw?=
 =?utf-8?B?UGhRakNNcGRHZ0ZMa3J2dXRGYTloMmtTdEFYMnpjWTVBTk9kNElrQXp2YUtO?=
 =?utf-8?B?enBlRUwvOERFeDk3dmdILy9RODBPcHdmQjgxWHpmTTRZQzBGdHMxQlFNQ2ZN?=
 =?utf-8?B?R1NpM3htY0tkeFh0RG95OTF3ZTRoV0ptZ0hiT3Y5WkRLTExSS0VMa3N4L0Rn?=
 =?utf-8?B?ZTFISEN3Rnc3RGlCaGRkbm1ZSHVZaE5VV0pPUDFKNDJwUHg0RklFODhzYnF6?=
 =?utf-8?B?aEdaVjNtSG9WNUdFQmVNNUlwejlqVVViY0JnUXdZblR4NTl2M0xHaGxnRk8z?=
 =?utf-8?B?OFZTMjY4RjB3MnFYbjIvSkRVUHI4M2Zoc0RxYjBtVlZoRXdOU0hxM05uaW1a?=
 =?utf-8?B?VWlibGl0VTkyWHBYbFRoNnJ2eTJJcFQrV21Iakc0M01lTnNiRHJSalM5U2pM?=
 =?utf-8?B?czFZbFRXaWgrMVRvdGtmVTNRRElXd2IrL2RNbk1McDR3T3VERSs1N3BlZzFa?=
 =?utf-8?B?Z3dKM3BwcXB0V2NDTXE2T0l6R0ljZ3lMenFUdXd6M05yMysxa1FOOVp1VmhL?=
 =?utf-8?B?MHVPMGhKRWtSTU1nVWg3REpHN0FoUm9qNWVQYlpPaGVERkRmQVkrWEh3Tnd0?=
 =?utf-8?B?aThjMEprL1lPSG5JNDZIRmJ4SXdyalJkSGsvYkZyaWQxaG5KbkJYaFRLWE9m?=
 =?utf-8?B?SEE1NjIwWGpDbEYwK0lrY2d6cTl0d3dZK2t0T0VRL2YwVlEvVGhVMk1iby8z?=
 =?utf-8?B?RlhJZ3VzeGhRc0RRMWg0TG9Tbk1iRzlYUE0wY1lMUEZkRGRVbXcweHNEQkxD?=
 =?utf-8?B?OWFFRDlRVEdVcHF3c2RzTlRrYlBCRUxJbUZHSzEyM1VKZFRpcWQ5Z3ZuOG1n?=
 =?utf-8?B?QnJZVENJU0hxS1B3Q3gzWkRKb2UxUEwvemtDVW9yWC9Kb1Y5am1VWHBmMjE5?=
 =?utf-8?B?UGwvbmhONzNKamJLSDkzcFJ0VWF3WmJZLzg0UXBnVDVDa2JsenErYTB0TnNF?=
 =?utf-8?B?RVlnRUZkK2tuK3lTWmZKZ2NQbjRqcm51K0xxKzl1U1FtZXZlUWE4YWtGRjRN?=
 =?utf-8?B?TjV5OTJiWXovNUh1NlYwK0JLVjFrUUI0OTdtbVhxcjIvdHNGMkREanNXTmV4?=
 =?utf-8?B?MDNzQzRxVUI3K0RGcTdIblp3U0ZaamlYVVFEWWtxVzh4cFpycWNubkk2YVpw?=
 =?utf-8?B?NUJGd3FOTEhySFFCaEZJTVlSdkdxUUZ3NDB2RjI4OWdzcWx2dCtqMExBQ2tY?=
 =?utf-8?Q?pepIaBqLOyJYdOxGAE3prK3Lf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ae9243-a7da-4cf4-abd3-08dc70a1721f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:29:48.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGWQuXYBwutCnc0+g6Woh9AWkPxr5/dtzfeKOypgv/EoBbIT79jEgrU65x/TO+X71LFHTLEvDxJJAXeMwnAAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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

On 5/9/2024 16:50, Pratap Nirujogi wrote:
> Add the isp driver in amdgpu to support ISP device on the APUs that
> supports ISP IP block. ISP hw block is used for camera front-end, pre
> and post processing operations.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes made in v3:
> 
>    - Remove unwanted header files
>    - Remove suprious lines, duplicate error prints
>    - Fix multi-line comment style
> 
>   drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c   | 278 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h   |  51 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
>   7 files changed, 345 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index de7b76327f5b..12ba76025cb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -324,4 +324,7 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
>   
>   endif
>   
> +# add isp block
> +amdgpu-y += amdgpu_isp.o
> +
>   obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index eb60d28a3a13..6d7f9ef53269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_seq64.h"
>   #include "amdgpu_reg_state.h"
> +#include "amdgpu_isp.h"
>   
>   #define MAX_GPU_INSTANCE		64
>   
> @@ -1045,6 +1046,9 @@ struct amdgpu_device {
>   	/* display related functionality */
>   	struct amdgpu_display_manager dm;
>   
> +	/* isp */
> +	struct amdgpu_isp		isp;
> +
>   	/* mes */
>   	bool                            enable_mes;
>   	bool                            enable_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> new file mode 100644
> index 000000000000..25e88661ac60
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -0,0 +1,278 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/mfd/core.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_isp.h"
> +
> +#define mmDAGB0_WRCLI5_V4_1	0x6811C
> +#define mmDAGB0_WRCLI9_V4_1	0x6812C
> +#define mmDAGB0_WRCLI10_V4_1	0x68130
> +#define mmDAGB0_WRCLI14_V4_1	0x68140
> +#define mmDAGB0_WRCLI19_V4_1	0x68154
> +#define mmDAGB0_WRCLI20_V4_1	0x68158
> +
> +static int isp_sw_init(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	adev->isp.parent = adev->dev;
> +
> +	adev->isp.cgs_device = amdgpu_cgs_create_device(adev);
> +	if (!adev->isp.cgs_device)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int isp_sw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	if (adev->isp.cgs_device)
> +		amdgpu_cgs_destroy_device(adev->isp.cgs_device);
> +
> +	return 0;
> +}
> +
> +/**
> + * isp_hw_init - start and test isp block
> + *
> + * @handle: handle for amdgpu_device pointer
> + *
> + */
> +static int isp_hw_init(void *handle)
> +{
> +	int r;
> +	u64 isp_base;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	const struct amdgpu_ip_block *ip_block =
> +		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
> +
> +	if (!ip_block)
> +		return -EINVAL;
> +
> +	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
> +		return -EINVAL;
> +
> +	isp_base = adev->rmmio_base;
> +
> +	adev->isp.isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
> +	if (!adev->isp.isp_cell) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	adev->isp.isp_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
> +	if (!adev->isp.isp_res) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	adev->isp.isp_pdata = kzalloc(sizeof(*adev->isp.isp_pdata), GFP_KERNEL);
> +	if (!adev->isp.isp_pdata) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	/* initialize isp platform data */
> +	adev->isp.isp_pdata->adev = (void *)adev;
> +	adev->isp.isp_pdata->asic_type = adev->asic_type;
> +	adev->isp.isp_pdata->base_rmmio_size = adev->rmmio_size;
> +
> +	adev->isp.isp_res[0].name = "isp_reg";
> +	adev->isp.isp_res[0].flags = IORESOURCE_MEM;
> +	adev->isp.isp_res[0].start = isp_base;
> +	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
> +
> +	adev->isp.isp_cell[0].name = "amd_isp_capture";
> +	adev->isp.isp_cell[0].num_resources = 1;
> +	adev->isp.isp_cell[0].resources = &adev->isp.isp_res[0];
> +	adev->isp.isp_cell[0].platform_data = adev->isp.isp_pdata;
> +	adev->isp.isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
> +
> +	r = mfd_add_hotplug_devices(adev->isp.parent, adev->isp.isp_cell, 1);
> +	if (r) {
> +		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	/*
> +	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
> +	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
> +	 * using the TLSi path
> +	 */
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
> +
> +	return 0;
> +
> +failure:
> +
> +	kfree(adev->isp.isp_pdata);
> +	kfree(adev->isp.isp_res);
> +	kfree(adev->isp.isp_cell);
> +
> +	return r;
> +}
> +
> +/**
> + * isp_hw_fini - stop the hardware block
> + *
> + * @handle: handle for amdgpu_device pointer
> + *
> + */
> +static int isp_hw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	/* remove isp mfd device */
> +	mfd_remove_devices(adev->isp.parent);
> +
> +	kfree(adev->isp.isp_res);
> +	kfree(adev->isp.isp_cell);
> +	kfree(adev->isp.isp_pdata);
> +
> +	return 0;
> +}
> +
> +static int isp_suspend(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_resume(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_load_fw_by_psp(struct amdgpu_device *adev)
> +{
> +	const struct common_firmware_header *hdr;
> +	char ucode_prefix[30];
> +	char fw_name[40];
> +	int r = 0;
> +
> +	/* get isp fw binary name and path */
> +	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
> +				       sizeof(ucode_prefix));
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
> +
> +	/* read isp fw */
> +	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
> +	if (r) {
> +		amdgpu_ucode_release(&adev->isp.fw);
> +		return r;
> +	}
> +
> +	hdr = (const struct common_firmware_header *)adev->isp.fw->data;
> +
> +	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].ucode_id =
> +		AMDGPU_UCODE_ID_ISP;
> +	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].fw = adev->isp.fw;
> +
> +	adev->firmware.fw_size +=
> +		ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +
> +	return r;
> +}
> +
> +static int isp_early_init(void *handle)
> +{
> +	int ret = 0;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	ret = isp_load_fw_by_psp(adev);
> +	if (ret) {
> +		DRM_WARN("%s: isp fw load failed %d\n", __func__, ret);
> +		/* allow amdgpu init to proceed though isp fw load fails */
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool isp_is_idle(void *handle)
> +{
> +	return true;
> +}
> +
> +static int isp_wait_for_idle(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_soft_reset(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_set_clockgating_state(void *handle,
> +				     enum amd_clockgating_state state)
> +{
> +	return 0;
> +}
> +
> +static int isp_set_powergating_state(void *handle,
> +				     enum amd_powergating_state state)
> +{
> +	return 0;
> +}
> +
> +static const struct amd_ip_funcs isp_ip_funcs = {
> +	.name = "isp_ip",
> +	.early_init = isp_early_init,
> +	.late_init = NULL,
> +	.sw_init = isp_sw_init,
> +	.sw_fini = isp_sw_fini,
> +	.hw_init = isp_hw_init,
> +	.hw_fini = isp_hw_fini,
> +	.suspend = isp_suspend,
> +	.resume = isp_resume,
> +	.is_idle = isp_is_idle,
> +	.wait_for_idle = isp_wait_for_idle,
> +	.soft_reset = isp_soft_reset,
> +	.set_clockgating_state = isp_set_clockgating_state,
> +	.set_powergating_state = isp_set_powergating_state,
> +};
> +
> +const struct amdgpu_ip_block_version isp_ip_block = {
> +	.type = AMD_IP_BLOCK_TYPE_ISP,
> +	.major = 4,
> +	.minor = 1,
> +	.rev = 0,
> +	.funcs = &isp_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> new file mode 100644
> index 000000000000..a11ec0543b93
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#ifndef __AMDGPU_ISP_H__
> +#define __AMDGPU_ISP_H__
> +
> +#define ISP_REGS_OFFSET_END 0x629A4
> +
> +struct isp_platform_data {
> +	void *adev;
> +	u32 asic_type;
> +	resource_size_t base_rmmio_size;
> +};
> +
> +struct amdgpu_isp {
> +	struct device *parent;
> +	struct cgs_device *cgs_device;
> +	struct mfd_cell *isp_cell;
> +	struct resource *isp_res;
> +	struct isp_platform_data *isp_pdata;
> +	unsigned int harvest_config;
> +	const struct firmware	*fw;
> +};
> +
> +extern const struct amdgpu_ip_block_version isp_ip_block;
> +
> +#endif /* __AMDGPU_ISP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 37820dd03cab..b4bd943a7cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2539,6 +2539,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>   	case AMDGPU_UCODE_ID_JPEG_RAM:
>   		*type = GFX_FW_TYPE_JPEG_RAM;
>   		break;
> +	case AMDGPU_UCODE_ID_ISP:
> +		*type = GFX_FW_TYPE_ISP;
> +		break;
>   	case AMDGPU_UCODE_ID_MAXIMUM:
>   	default:
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 75ece8a2f96b..a9de78bb96e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -712,6 +712,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
>   		return "RS64_MEC_P2_STACK";
>   	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
>   		return "RS64_MEC_P3_STACK";
> +	case AMDGPU_UCODE_ID_ISP:
> +		return "ISP";
>   	default:
>   		return "UNKNOWN UCODE";
>   	}
> @@ -1411,6 +1413,9 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	case VPE_HWIP:
>   		ip_name = "vpe";
>   		break;
> +	case ISP_HWIP:
> +		ip_name = "isp";
> +		break;
>   	default:
>   		BUG();
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index a3c04f711099..db745ab7b0c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -523,6 +523,7 @@ enum AMDGPU_UCODE_ID {
>   	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
>   	AMDGPU_UCODE_ID_P2S_TABLE,
>   	AMDGPU_UCODE_ID_JPEG_RAM,
> +	AMDGPU_UCODE_ID_ISP,
>   	AMDGPU_UCODE_ID_MAXIMUM,
>   };
>   

