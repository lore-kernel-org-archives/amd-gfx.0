Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BF9C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 12:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6706D10E74D;
	Wed, 30 Apr 2025 12:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeRRdpk9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EA710E74D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 12:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGN5vCIEcODkIyNjnKK/oUK2JIzj0yUVPfJaw7Nw/ijAcdT7naHeiw37fO+VkmwTBd55YKE/pWHoOZuy3wZeiUFxqwpijn/6inKs7flXeirfKcQ+1lGif9TbuqCmKnqXCoTW59D+5uCL3J0pWKRqWYqGK/TWu3g3K1qHfvXCmj8A0zzTs4aEK1Vep44+SZ3wJ3U+sfjf/Ca5tC4BpUTZMeJnRlZFdoqVNcpiu9Ch+6crj+2ipaFH7ANZ+eqJvmrS2fy5A+IiCBUiQKYGSxoDYMGO6lb6RI1+Xt5qkZkz2QIshIsY/PJ1qhFJ+6PnNe+zDaULBX98MyC57M+MXTqeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpFx9fGPhxFYrlJmYMRp5531sjUfBTcgTOxZ4Fw7SqY=;
 b=VijAnEYKQLAKJHv/fSAjp4Kebvaww2O7iU8VCatymOB2SG92VhWisTWN7IMtInBdCsFQAcqA6pMQanTmeB9wqi/ASZRkNlZ3hsDv8KpS0vzMrGmo7aWxdvkAemvhI7Od4fSNYMpZgi5EljYBaEoqg7d465TRc8AjBbfSZPPW4jkvh8SSiRLpvY8uwMLdPSJJYMF5PDuIuidzqoSEKlLA3hoqOBX48UCQayp5NKDmupSrq49eHyNxlMj32VrZbhhf67WcY9cCWtO+njms/sXKYYjN/36XhKgOEnWICba7D6XYxt+9y2fmyQvYRsbhM5avxugJhDTXstceNh8MkHc43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpFx9fGPhxFYrlJmYMRp5531sjUfBTcgTOxZ4Fw7SqY=;
 b=GeRRdpk9oBQCvgKL+YGOtS+mj3PtrudBOWT/JszS02o1DcBRXeCLlndrferC48YIxrd15owMxY5OT9p0mMFna4mYhXCYlKeNAGTDbq2RdDcwlDMX1NNeADW1sIUyemv1IpMibMVcTYsmTQPyT0IOBwLWJeKWDpAdZvioNUMow9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:04:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:04:02 +0000
Message-ID: <76e2cd19-b08c-42e6-95d3-41d5821ae74b@amd.com>
Date: Wed, 30 Apr 2025 14:03:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/amdgpu: lock the eviction fence before
 signaling it
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-5-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430024054.4093239-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 04853c9d-eaec-44cb-ea20-08dd87df18d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmxDQzlXcWxVZklJb1ZjKzBrYS9iWmZET2Jkcy8vR3JCKzNFOHFIQUxTODQ4?=
 =?utf-8?B?Zk4zOXA0RVNyd2d5cW1YK2xBMThIdXNXdk0xUlBHTCtPTEIrUnp0dlNFNjBV?=
 =?utf-8?B?TVNOVkNtZTdWaDNSckJLZ3FLQmZpV2lWRWh0TWRsMi9ESXRBK25uMjBER2JW?=
 =?utf-8?B?U2tNTS9tcEFVU04ySVBabU1oVUJZSTFHam5UQ1d6Vy9yRFV0bFpGTisyTGxl?=
 =?utf-8?B?NHY2VndIWm9CMnJEa3BXeU1mdzdUYm5GZWw1cHZPWHA2b2tnLzBZQ1hnRGlv?=
 =?utf-8?B?QVN5aTJTclU1QjlSaFpkUlpOWWxQdDIxSkJVSyt2dnpQL0o4eXJsTzcxdjdm?=
 =?utf-8?B?WHFGeUhnWTBMcGhQUnlXU1VSNm4yaEV6RXVCUHJKUG1KamhxZ2s2N1BPZllY?=
 =?utf-8?B?bktGMGpBR09LMG8xd0kwQ0RKTTJySVUvUlZBQ0xidHhKTDNpTFlVb25RSWVh?=
 =?utf-8?B?WS9RVS8raEVQRXQrZ2JtQ3BGZ0ZLb3RiNkNmYWs2ZTBtQmtXanNIQnRZRjR1?=
 =?utf-8?B?RmRxQWF3S0U0eUVuRXlLQjA1d2VmYklZSXduOU1XVTlCajFSTkJ0WXhZYzVS?=
 =?utf-8?B?ZlZtVGxRRkZuOVNqUVMyU3hKcW9pN3dObHFBVHlsNU9lbVF1S1hGayt2cFFr?=
 =?utf-8?B?RFRHUWt4aDZ5Q3FRZkF2cVphTmM3THVoVkpTV24waFdZN0plY1dNRnlJMldn?=
 =?utf-8?B?YjJCZldxSElxSjdoTXhQcXp4RTVLQkpvYmU1bEZKQjJJc3hVZTdneHB6eEtq?=
 =?utf-8?B?Y2lyWmNQNUc0alk5OS8zWko4VkpGTUxNUzR1VFpEd1psZkNtMlgvNVBacEJO?=
 =?utf-8?B?K2tuMGg0MzNEQUUraEZKTlhjSWdLeW9JY2FoMFIydGsvbDVOdTNSVEhUTDBM?=
 =?utf-8?B?Vk03TXNqb1dYWkhOaVpkYXZIdnNxaW01OG1rMHRNL3N3UnRLeWo2ejJuYWZL?=
 =?utf-8?B?L1hDNjlZMDhoeUlydHU4bGRWMk1XSXU3MVVnSzBjQkRiTWdDaUNvRzF6cG9u?=
 =?utf-8?B?Ym1TcG9VRW40c3M2UllsK0QzS0ZaT2syMzE3Q3BnV2ZXNTZDd1o2UkF0NUJV?=
 =?utf-8?B?QWlZdVhBMWt4WnA4aGl4alRNMEpaY3hKTk1jNnRqRXRhUFpOWWxRV2tJSlhZ?=
 =?utf-8?B?UzZHbjNEVnMxdy9kUkN1Qk9jaFB5ajhnYXc0a1NJRHlidjM2U0xOU1MvUUhY?=
 =?utf-8?B?bjVUWnVYMzBaVlFyK25zSkxhcXk5b0Y2YXh6VXVRQkdTWEFtQ1QreDRueCtJ?=
 =?utf-8?B?RzdTQVlrZm8reTFrMXRMU0xzVHhKTmN6V2RhWVBxVVpiQTFXTlErV3BRVk9K?=
 =?utf-8?B?UkpBWDFJMDBjVDI2cytzbkdTZDg2MFdZY2hGS29rRjl2a0RxUkpIUitHdWVQ?=
 =?utf-8?B?ZzlsL2RRZG9PbGd1UFlwTk9IUjFlU3llVDJ3Q2d3N1gvOWQyeFFISzFza2xJ?=
 =?utf-8?B?dmY1aWVuMkpFcVBvVGZPQlFwbFlMenBKNENpbklpWFV2dnRaYlFXL3E0SHVo?=
 =?utf-8?B?NG5pcmFrRkx4MlR1ZkNzNGxCY25YN0lVOG42RXlKeEdONWxsbFF5eTNLMzMx?=
 =?utf-8?B?K1ZCRUZ6eno1bUNaVG1wU2VuQlFKRjg5akF2OGxMQzVTMXI4eVFnTGVsQVJx?=
 =?utf-8?B?V2RkZWpKVGxXZThUN3NQY0pHVFhMU0ZhTlpYOHZDNzVESjg5MnNJc0hhYUIv?=
 =?utf-8?B?ZDExT0oxaDFzQytMS01GVXErZnF3MnI5cGhrbHJ6OVRtM3FjTFF4RWppM2ZY?=
 =?utf-8?B?ZDg4RVl0SytpNFZCS3Ezd0FjQXppU0lKaWk2Y016dHphVTM5dXdoZDY0QzY3?=
 =?utf-8?B?aHltdEJUSEFLcXZHYXNTRDh2YWU0RzlBQkQzTVB6dzRKUHZRT1J6c2hqOWRM?=
 =?utf-8?B?b1hSSnVwNktRY1RNUS95alJxcEhabXpKTkFGN21obFE3QzBvWGJKVHI2ZDlj?=
 =?utf-8?Q?Y72MchFIVJw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpiaG5MMjBGRXVsWkJhemIzQkZUMFlRcXlFYU5EWVNpUm45NTJoS2hta3dI?=
 =?utf-8?B?RHltUVBoWjBReDY1NmpMUGxJMTgwQnpQRWUxVVFjRXphUEE0NGEydjFWSE96?=
 =?utf-8?B?dEpvZFNvK3l2aFY1UE5ISXIrR1VKYlY1Wnp3V1dVaEFlemRrcTJJOVVvOUxI?=
 =?utf-8?B?UTdVdzNaWDhXWThvRHVVZUd5dWthdFFqOTVIYmdzN3RzcDMxZ1NJdmg2REg1?=
 =?utf-8?B?Rm5JRlQ5c0w0UjVvTXg5Qk8wZlA3V2ZPc1pidGlnVUxZb0xRdGpXTjZrNjFp?=
 =?utf-8?B?QXV4RHlCc2RGcElpM01LQXV1QWk3aGF0WTlqUEtBTkQ5d3hHamV6MHRYc2kx?=
 =?utf-8?B?cWxSWXFkcG44UGFRYkhPWEpHc2REcGZ6aUdEUzYzWEc1dUtna3I5MVh6K2JB?=
 =?utf-8?B?aGY3SUJTZ1hWRmE3dnpFZFNwTVB4UXVQTFp2TnF3Wjh5VXlpNGRrcnR3YkZM?=
 =?utf-8?B?MzlsL1JCUk5OOG9YcEQ5VCtrSVpVaXRmZnVMaThadXZibTJmZVFvS05vVXMx?=
 =?utf-8?B?WG9YSkhua0RBR3JUdEZoaUtaSnVlV1dXT3ZGOWlwMVZORkkxRjhTUC9WSHh5?=
 =?utf-8?B?ZnBlWllONVVpMWw4N2swdGtqaEFzWlJNMkFPcVFVVDl3L0lpWHkwaVIyQXpr?=
 =?utf-8?B?UUsvaEE0QVozY2VVWGIzaGdxbldJa0swcDZzeHZQQTBXWk83MWhaNS9Rc0Yz?=
 =?utf-8?B?MVNUZEVDRjF0U2FNeFFGTGh0bFJLZTNGWFdKMVNiN3Ria3dsazRoM2JNVmtM?=
 =?utf-8?B?QlkrTDRPZ2RkMnB4cFVrdkl6c2tNNEE5YUdMNEZGM1NhMjFtc09wYTFRNnky?=
 =?utf-8?B?Sm01Unp3Sno4dnRyTGxBSlY3Q0I0azA0UFVYNjc2UkZqL09pNGM1d0wvdzZT?=
 =?utf-8?B?SnZPbyt3M3hqOGR0ejh6MWlSYU9oaEE1ZmlCUTMxTnVFSEh5aGp3TXpCMWR0?=
 =?utf-8?B?OXk2ZlQySEF3cHdleHBXcWwrOURJSTVUbkdZcEF6M0RQOW10ZmNiai81REpz?=
 =?utf-8?B?cW9yeXc4S1l4aDVqWDYzZWlyU1ovQWZMZkd4SVNSeGVORWlWSkN0RGI2V1Fj?=
 =?utf-8?B?MHdITVN2citCSGtvVFBteit0bjZYNjBpWHZWakdPTjV5NXNZRXFaUmNxbmpI?=
 =?utf-8?B?ZHdKWVRSdmRFYVBjMWkzRGJPNkM5a3g4ODcvbEZDS1lKNUlHV3RJdk9pL0RT?=
 =?utf-8?B?L1JXUjJzclI1QmdsOVV3eXd1UU5UTFE3Nmpwc1g4Z2pFQjRianpva1prMVNo?=
 =?utf-8?B?WjRiK2l5aHNoTVVCTnB5V3cyRWdYZ3laTks4RE8wUkxLb1BJbCtUbDRtR1NN?=
 =?utf-8?B?a3hNZTBmc2o3cTQ3VGYyeSt4VGJ5aFNyR3NOditCVkV5ZkcvWkhhUW0wQ0p0?=
 =?utf-8?B?SjBqc3M2VFRrQTk3ZE9kL0RsWU1WV3ZOTWZrUVAxekNLQnlQdjF4eEwwLy9U?=
 =?utf-8?B?VWdvS01RNWRralY5YnA2R3dIelVPVVkrNWxDYUs3TWFOQ0J2V2dKMDZ5bXdv?=
 =?utf-8?B?NjMyRXJvTWUyOHNaWEt1bkZXcDZUUjZ2bEZRYUlna2VraDBMczdxZ0lEUXNj?=
 =?utf-8?B?TnowVGVBSnM0eEFhVEIwUjJDRnRRTmxuQjRDVFBvZ2RJYnRGUU1OTVRrd2xH?=
 =?utf-8?B?TTRsWVRTUU1iMm1NSVhkd0t1Q1VIZnJNcU9ZTk02V21ad2ZJdFV4QkJKNDBy?=
 =?utf-8?B?YXVxSndwYW9qejh0SmdRQXRBN0tmcC9YSkxCR0w1c05Oa1M2cFVBRDNiN0Rq?=
 =?utf-8?B?ZlNLdEpCaEMrSzk3Vm1VcjRhSms5amZlREpaK3FJcDBZd0xzUHoyemRjSFBB?=
 =?utf-8?B?aG1XVXRWYm9za2d1a3FudkNYMWhFZGZ1V3VMQ1doY21WNk1jZHdIODltQ0lJ?=
 =?utf-8?B?SXlTN0lSbnN0MXBVT2tKVS9XWktLWlkyWTI5V1RrbWhmaU9UaWFvZVpHM0R0?=
 =?utf-8?B?SlU3SU41OTVkZm9wNzd3bmV5REJwWGhpTGRzYnNMZk5CYmpGb0RKQ2V0R21r?=
 =?utf-8?B?K2ZXZ0IrZ3BuUDltSlRQWnZsVm1rb2tLWXRZV1dIQzVWSll4S1ZwcjloVEJ2?=
 =?utf-8?B?WlVXVi81OGM0YXUvMmxFTWdoL21BNlhCKzdnMGdlbHZIclV3a3pQcUJpdWVW?=
 =?utf-8?Q?ferOUpRv0o/GQuq+A3H7vufbq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04853c9d-eaec-44cb-ea20-08dd87df18d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:04:02.3316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtaK7Lv4lUPCOvMvPiUN6wkHISv1yMbn+E18M7gef6OPou1muUnvdlU8nVdH2mN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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

On 4/30/25 04:40, Prike Liang wrote:
> Lock the eviction fence before trying to signal it.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 242bfb91c4f7..fed065892568 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -108,7 +108,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct amdgpu_eviction_fence *ev_fence;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
> +	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
> +	spin_unlock(&evf_mgr->ev_fence_lock);

That's a good catch, but won't work like this.

You need to grab a reference to the fence while holding the lock, e.g. something like dma_fence_get(evf_mgr->ev_fence);

Regards,
Christian.

>  	if (!ev_fence)
>  		goto unlock;
>  

