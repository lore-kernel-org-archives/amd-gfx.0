Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DFC3ABC0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 12:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C14F10E680;
	Tue,  6 May 2025 12:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t3Hw+gVA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0A710E67F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 12:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx0fk8oj63j2z0FSIH0xlK8dRiFx1uI98PZYxO6TxVHrOsHTi1AWnTVDUfOj9xw65xhcdoPZn2D/DRlPwQ0qgSHeafAr/WLpaKZcszkR8ISYQ+IKJGiLclFANaLar29Q3I7RcoOndMJlqvlQR9s/eo4V55bwGqHIMRU1ZKH7fZ6nA2Pa2n4SFrSoKgb9CjeJir1Rnm+cPAojnE3Q7UaG5fkVMbb479O6zxvRzgD3JDIr3w07/GrGu4IGm4IwBHuf0+ndcP46v3EsCKBbQwC2enFDHBFxhvmBlTs2m8YYFiLLvXwLRXeVhOL5YFdi++kRFc+t9DPrlx2seAunrA4r3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qxw5HcCM+TmJblAN81Nbt2X1Xt2+xDg85aMeGVNI8E=;
 b=UG3kfCuku/YGjzDkgIILgbr3tLnOssq/zTFQ0Elreo7RCX4kEdYRgPxKu49PWDtFl+aFzLjuLdFLHWWCvmL4SeMAkUuiWBVFkG/rvHkoag456LytYbgBbqWNRGPQY/uqHWzLADBflwRpG29wfjOxY06kW+rCHBVSxyzO5zQAnOJGPLQ1SLFz+1wZ+T/m0JNVwCPLYcoGm/NIgK02XLfJg+NxCH0dfTxhn2HAXWGkGBnjbBXWlVOKok8CboAAfnw6TXmEb8/aJIQh5hFaIk7SffmCqjRdHcue+4ZSbMCgsRPNASKwSHrjgt9+lCbNKqx9keiPxsHZ6z0Q5464f5qgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qxw5HcCM+TmJblAN81Nbt2X1Xt2+xDg85aMeGVNI8E=;
 b=t3Hw+gVAYhisK/drrwqIyxwxfg1EHs02AHr/8x+nS6HolxfQ203+L11Bs6Ttou2elwee/W5yaVSJwSDYutbdqXjO3zgZo01miS8T/8yHACzFYe1lW3Blfh3Rtl12ZBnq/yfmPRdaY/UdjdYNHKjhfmXVuQJjbkiMvM9LdfA7pRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 12:32:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 12:32:17 +0000
Message-ID: <8c0b30d8-3e90-4e76-beca-f0a74efa7d14@amd.com>
Date: Tue, 6 May 2025 14:32:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 lijo.lazar@amd.com
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <20250506093629.249792-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250506093629.249792-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c10cf2-c735-4fbb-39cc-08dd8c9a097c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVZVlpHNlhZRmdVWkUrb1AyNXh2cTA4eEZqN3d0T3J2VUZjRlFUT2pGeWxj?=
 =?utf-8?B?LzFZNll0LzhJaUNFM2xiRHkyNS91KzBwSndDaTFMeW85VUxPS3RXUHVQUTZz?=
 =?utf-8?B?dWNIUTNTV3djL1hXbWRLZ2UvWGUxV0gyTVNPbWx4NVlRL0w1MGV4QVVueksv?=
 =?utf-8?B?Nm5iWkxoblVtU2pPd3EwRENjN0VRaTQ1YTFwdDVhR0JIZ2lYYUpvbkJrSEcz?=
 =?utf-8?B?U3N6dmJiK0JMSjVVcTJ4UWVoeGxvMjJ6Y1Q5VC9XVVQrb291TS8wRHBnUzla?=
 =?utf-8?B?TUYrTVNWR2lZRXM3MTkwRFVxckFCN1FsRWtPdGZLSWtaVUFBK0FkMWNDUUJT?=
 =?utf-8?B?UWxJdXRXK2ttZFVoOGJaZXpLc093bk1GUWZwQWtLTEdqWDhDcWFuNzJac0xi?=
 =?utf-8?B?eVhaL3hHc203aHZ0SnFISWtLcnkxdmE3eGpZdThCdW5qd2N6RHdmNVpkYWJX?=
 =?utf-8?B?dUVlbnQxWFczRDIxUTNiU2xiZXUyQ054dUJwbVRkY2VSdVVnT3daM0lMNzJ5?=
 =?utf-8?B?WUFOUnRlL2pBNlJZKzlVcE04bjF2bENyTkdrajRqTkhhMTZMaHY0ckJxOFdF?=
 =?utf-8?B?Z2RhM1BlTlVnRkhxMFl3d3NRblMwTDRGSS9SU2lEakdVSCtrSGdwYUVjUWFu?=
 =?utf-8?B?N21UZi9BanBXTDFoK3ZLSWw1RHBLVUhCTlZTMXorVWgvd3hPcDlTbDNnc2FH?=
 =?utf-8?B?UTdSdGlhMEZ4ckxETytrNXlpV1RocTU5WFg0UWJsQUpkbUFlbzVuUVhSbHBy?=
 =?utf-8?B?bkN1ZSsrdFcvTys0Nldwa0d4RUN6czJkSjJhMFBrQkZSQnpCSGV2RzdkK3VZ?=
 =?utf-8?B?Z0JVTWdrdlhuTmt0azVTRDZndUd6QmNkanl6cDFnRVQ3ZFE5V1BlK0J0SWp3?=
 =?utf-8?B?anR6RElrVGRDbnBEOTZjSnV2Yy8veG5lQVRnejA3QjZoRURkVU5MNDdoZ291?=
 =?utf-8?B?SkdkbGpqcnA1WWNzWjVOcTNqNC9IemVNd0hrZjBvQXhIVVFDamtGbTRMMy9Y?=
 =?utf-8?B?RVJjR2tNWUdFdjVxOGlra2ZPQk1IZE1kSDJGSS9hY1RxQVpvNi9lNzhweTli?=
 =?utf-8?B?bDFESVpGcXNSbmxRcm9LQmJlZVpSc3dwcWszR1FGZURHUVhPVDI5blVsVUNZ?=
 =?utf-8?B?eTJiVzNBM0t6amF3WnBzZkZBOUsvWkpXMmJ4d0QwVmxxaXBlVmcva25hU3pn?=
 =?utf-8?B?b3NnMjltWWs5REJEbERENzlvdzBRVFdCYXBNTWVKd3NWRVYzVXpacnh3aUhw?=
 =?utf-8?B?aFFaWGx0ZmNYeU9IZHJxOVJlL0lORzEwcVYxbFEvT1EwMWJPV1U1QTQ5VHZJ?=
 =?utf-8?B?cCt2ZUxzR0dHMzdOWG5TS2xHVWRTZkMyekloa2c3bWs2REdSYXVSR00xVEo2?=
 =?utf-8?B?cjFnTVMyR3g0dElGODNUbktRRjZjV0dRai9EUm4yNFZlZFcybFpvQTR5MGV1?=
 =?utf-8?B?OFlYdEZ5dFludVNJWjZnWHM3aklWeSt1UGFHVk5TdjJHWm9XSmg5RWhkU3Bs?=
 =?utf-8?B?d0dFVUd0clRzbjhEQVFOZzBkcEVNNEdnckpQSXpOczBscHUyK3JFZTZjSlFy?=
 =?utf-8?B?eUJmMlErWk1RRnhDempyRmpGTXp0cE13cE5vL0liUUVMQ3YwUXRlL2FjcVVS?=
 =?utf-8?B?TjdyNndmdi9JdFQ1Qk5lWVd4UGFwVDBsUXQ4SWd4dElhL000emFhdnZuVDBQ?=
 =?utf-8?B?bW4xVzJpNWxqQkJKK1hFc3gxTjZrcmtCTzE2VjlKQTlxMnpQZVZmbDdwZ3FM?=
 =?utf-8?B?QjByODlBZlpiVlBIMFZWblYwVGR0bjM4dEdNMHNuY29mV29qUEcyUHphQzY4?=
 =?utf-8?B?aDcrSTlWTDVCV2ErcmFNY2w5cy8yZE81NzF5K0NwV3l4OWR1eHZTV1JMZHJB?=
 =?utf-8?B?Y01HUXF3aDZNQlUvMWhtTVd1K3NJRTNCaDg1T09GRjBSTTJOQ1RmSjNiemdY?=
 =?utf-8?Q?F2hCx2CHQbQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNoOUVKcmJ4bFRRUDU1S0tIUUNNM1grY2xZa3ZlM0QvaXhqOCs4ZklJeHpH?=
 =?utf-8?B?OGE3enFXZUJMdms3S2RqWXJTSnkvVVpRRTA0SGFudEpPMk5hbXVLb295OXdZ?=
 =?utf-8?B?SEhMTm1MQnhldGg1OGdhY0tVczcvMTN6ZitKVHZhV3JQb0t2L0hmWnl5Z3N2?=
 =?utf-8?B?bWYwWjlrUHh6UXc4U0xhRFUzZjlSQjArWmZHK0Y2NG1pejJGNDg5WWV4aEpH?=
 =?utf-8?B?K2ZrY2lPVGpyeTZvb1JQazBhV2xJOUNuUDl1V3IzYU1JOElKTUdEZGlRQklq?=
 =?utf-8?B?MFA5U0IydExRTEwyVmpBZ1JMdlhPSkhXMFBBUjhoWldQc2JiVjcyQmg2VlVl?=
 =?utf-8?B?czV0a0pWdEJZcHloc2RhN3Q2N1d3b0s1dWU0T3haczhiWFJNQ2FJOWlDbVNZ?=
 =?utf-8?B?WjVWT3U0ajlZeUs3R3ZxeEF3QVdMU05UbFhBR2xZWk5MUU85Y01WS2RhZnBy?=
 =?utf-8?B?aEVCTFJtaDlORW1vbXdEUFRLejM5WlpSWmlVUDR1c3huSHd5YTNKSjBjdjdP?=
 =?utf-8?B?T29uaEtLREdxdHdQUHlSYURVdjkvQktQSjdPOE1IWkQ3M3l3ZVFzNllsU1hQ?=
 =?utf-8?B?WmIvQXhwQnlqTTlQb1BVMDM1TlhIK0dIQXA1QTE2ZmUyRlMydTBPdDVCVVdz?=
 =?utf-8?B?OStoS051cXZnSmxCOXBtcm5IUFZYWnNacVVhUjF0VnVDM3ZMbFQwQjNabGVT?=
 =?utf-8?B?MVczVEM3d3R1Rms2Rml5azB1Z3JyVXJtaEhMTFZpNFhPSnhjOXVXbi8rM3NS?=
 =?utf-8?B?d0hybTF1WENRUzNTR0pVNUhPZTF3NkljSjNJUkorWHJPdFlqTUtDaVVmUjhG?=
 =?utf-8?B?ZjNISWdjckZIY3hqa3AvcExnTWhHZWZoOVZVbGRDRGRNYk5tbnpZaGhrNXpC?=
 =?utf-8?B?aXk4Y0Y2bGdhMnpGcWJJWHVCNmpCRnVmdXNaaUlXWGVXRGU3cXhIeXRPQTBN?=
 =?utf-8?B?c25CQ0pxZWhjOWU4aXY3V09tblovYVRMVGdPUmxkVmRiMWhkRzVJQXc2Tmo3?=
 =?utf-8?B?cnZIMHY4ODBDZnNyNnR6SUUvWnFDTUpVOVRVVzVlQlFqQVZmUFk4NWVIcnhu?=
 =?utf-8?B?ZXUwVTNRSmNoQTlrUXZpWDdJWk90Mjl4V1lnc3d3Q3FiNElKdkRLRFFFaEpT?=
 =?utf-8?B?eVE1UDUzb0dhc0VHR2trV0Q2T2tMSkxNSlJDSm9FYmtrUkExcERpVVNYMXJO?=
 =?utf-8?B?MCs2VFl1YXpmaWh0RW1ZMHJwTG1qTE5FOFlZZUhDWDY4aHFaNWk2YXd2Vnhk?=
 =?utf-8?B?Z01Zb25Ocm9SbXhOeEYzdDdibWNSRVl4ZTA0QXlhbVZma2xLSmtwWFJycEhR?=
 =?utf-8?B?K25rWHdocm56dVZzMmFER25aMWdqTlhvamxaYXdCWk1oaVI0SHVjbmhQc2tx?=
 =?utf-8?B?cXhlUDRXUitmS3lrMHlOSDdzeFpqTGpmRGJzSDlyaXJ2SEVkZlZmZDk1Tnhk?=
 =?utf-8?B?Tmp2WithYmhNQ3V4c3dFVURMZlY5akRncDllSWhzN085bkdta3dwSzAzS29t?=
 =?utf-8?B?ZVM5Uk1XaFN2TjdZNjhzYytvY0lvaUxZM1F2U0VLNVVISnM5UUtVQzVROU9L?=
 =?utf-8?B?OUJscGV2TGlzdFJFZWQ5ZmxPQWV4WmV3aTdVc0JZVE9rc0VjUE5QVmZOQ0lu?=
 =?utf-8?B?b3FZZXZZOHErSXBCV1NOeUV6STloT2N3VWN2QTJ3eDJ3MnpOeWxQL09EL1RH?=
 =?utf-8?B?YWtGMFh3SFZ6a3MxZDBOT2VhK3RMWngzeGdZZENnQ3hPcVFRYW9FQ2VCOXZE?=
 =?utf-8?B?RHhEcG13clJKRHRPendCa2FYR1ZLVlRyWXJEaWNwOHlMNXBCQSttbmxHRHlS?=
 =?utf-8?B?d0NrWlJQdmRFUE5GV0RPR0RTamVhcktSSG0wcjNKMFBvSnp1LzFYMkZyWHdr?=
 =?utf-8?B?WFJjKzNNcldDUWhwY0s3bE5IY05Eck96UTdPSTBrN3NFVE1qdVZDaEJGMS9y?=
 =?utf-8?B?NWxIcHQyTXJ0TnFsc0tNU2dUWllIZTZFTm5XMU43aFlINWxUTktIZmNML3Rw?=
 =?utf-8?B?OVdnOEM0VXpVWWoxVkRXaDNVdFNRWmZ1S2M0akhKY3FBaGdyWXkvQWNSemtS?=
 =?utf-8?B?d3lOYVdYWU5UZHY4YzJSWEdFTGZ5b2pWVDNJRHIzT0pLM3JDaUdHTjZSdXJE?=
 =?utf-8?Q?aM4OSholYWQhQ5Ss1RYkbc2U2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c10cf2-c735-4fbb-39cc-08dd8c9a097c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:32:17.1342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZV7qkzFn3DIuMAg8qBlP+6mbMpdQYffmioiAMkQe1OHcEBAVrNFs5wX30xQihSKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
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

On 5/6/25 11:36, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
> 
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to updated
> to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated after resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

At least of hand that looks like it should work.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>

But I think Lijo or somebody else familiar with the PSP/SMU code should take a look as well.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
>  5 files changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..3dde57cd5b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>  
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:	amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	uint64_t offset, fb_base;
> +
> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> +
> +	fb_base = adev->mmhub.funcs->get_fb_location(adev);
> +	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
> +	return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:	amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e1e658a97b36..bdab40b42983 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}
> +	if (psp->tmr_bo)
> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>  
>  	return ret;
>  }
> @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
>  	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
>  
> +	if (context->mem_context.shared_bo)
> +		context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> +
>  	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
>  		lower_32_bits(context->mem_context.shared_mc_addr);
>  	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
> @@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
> +	}
> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  
> +	psp_update_gpu_addresses(adev);
> +
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if ((is_psp_fw_valid(psp->kdb)) &&
>  		    (psp->funcs->bootloader_load_kdb != NULL)) {
> @@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
>  
>  	mutex_lock(&adev->psp.mutex);
> +	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>  	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
>  	mutex_unlock(&adev->psp.mutex);
>  
> @@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>  	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
>  
>  	mutex_lock(&adev->psp.mutex);
> +	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>  	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
>  	mutex_unlock(&adev->psp.mutex);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..f3b56c219e7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>  	}
>  
> +	if (adev->firmware.fw_buf)
> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
> +
>  	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>  		ucode = &adev->firmware.ucode[i];
>  		if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..dfdda98cf0c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
> +	struct smu_table *driver_table = &(smu_table->driver_table);
> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
> +
> +	if (pm_status_table->bo)
> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
> +	if (driver_table->bo)
> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
> +	if (dummy_read_1_table->bo)
> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	smu_update_gpu_addresses(smu);
> +
>  	smu->smc_fw_state = SMU_FW_INIT;
>  
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {

