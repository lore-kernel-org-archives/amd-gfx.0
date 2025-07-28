Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E3C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 15:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF6B10E531;
	Mon, 28 Jul 2025 15:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ORunJLK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED0610E52A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 15:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdKfen49J3+phcQA54dduXqWnEkyoP/wbKX2mg4zmSRIhZzfW6JlWESbcsJr7FBJREb54ltkdGyoOBJdDRYQdEUJgAlN40CqFw9rludTUTAcS942vLu1bmby5ZC8Zw4Cj+NQ5KnCtn1udIIM0tsN7wc+YLC5sjtdewqMLjtBNlbfcEVQGl9LyLsUsbaBQp0wIdWSSzm6N/sCGBKPEgYKEAqGzYqmiXIYhD2ifZlYBBKWupV8FxUhH16YeNrVvw/nCdFwm4Bd4TmkvD3ksqr6LSZsRx/RfKx++exprECsI6uo89fX3+2B/Rs1T9vRx7lJCviCkaBetJfieiOqOpbO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l56jaC7XKrsyavjbPd+GNntB/dlnIEqC2FWthq0o6ys=;
 b=HkikTC42i8u9sRC03hfQR9EoU7UTXha8BMNFvrAcy2rqxy2cDtTgCjAJlW7TZ3L+BYu/UA8fY5Z8Y5By773iOw9WErqRzvGtVE77wNjUFnImHRRW1yUorZ6Z1pRnOLxvi60ZfJ4s+gcqzfWP0s6Yo1Gx2BBwC37xJuk7UFmEuuU/WgwbVdrBt6JYFB2LdvT77I5dIUNT0KPXZhsHlZ8WKfRGyHjDCM6/MwsNTJ21EmiMyAythEVvF6kNRWkYkYTDSp2P1HH0yKChoy9/Hwo6pZeVBC0OUTHoaSK6WznViHKfmWmPFrU9xd7F1JtP2GOA598A6kjxmjgzuLXc7tk9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l56jaC7XKrsyavjbPd+GNntB/dlnIEqC2FWthq0o6ys=;
 b=4ORunJLKunRQ3VVW8/k0U6Gh8u4AC4ooDe80+OSs0WpoE+UfgNNprBH9W5xBLcTsKlxYescWp4eJL+j0CksiuwJEKK0JnMb8aGB9bwmB0BxyV8fqapHi13Qw5MVHUHQyYmXhSmQxKpY4xQSP9+uPJq4X09AuBHtuVsMpJR9jMbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 28 Jul
 2025 15:58:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 15:58:03 +0000
Message-ID: <faa11cfa-980e-4cf1-957d-899088a5ecd2@amd.com>
Date: Mon, 28 Jul 2025 11:58:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Restore SDMA queues with engine_id
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Rajneesh.Bhardwaj@amd.com
References: <20250722174712.450292-1-David.YatSin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250722174712.450292-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:930:4d::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6aee10-326a-4caa-a0d2-08ddcdef888f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTFZRUtkdVZuVThjcHpERGYreERZRnBnck1Qek5rc0wvVTI4LzVYMThyckVa?=
 =?utf-8?B?Z1k5ZHFPOGxDYUZYSTRaTzJiZ3dPdTErQm5ob1hVbXVkQTBrekJodjVQYk5t?=
 =?utf-8?B?TGtYS2NQQnNKbGE5Vks3ZTMvRFJxUkthTkROWWlhbHNkUndVK0dlcTVkbkFQ?=
 =?utf-8?B?RXZOcTdMN1ArUi90dDA3b3JDNDgvSmdUZmF3QU9VQno2cnQvb2RSNkNMeFZV?=
 =?utf-8?B?dUQ3L280UERRZS9QVGp1MFN5UDNTOW5MdjNPYlp5Z3dNdk8vZ1hCdTFCS0R2?=
 =?utf-8?B?cWY1WmlmUjBDSjRzOStlVXJZUDNvQmQ2dDVSbEdtTUErY3IvR0RqelVCMzg2?=
 =?utf-8?B?eWMwaW00eE1FUitBcHdUYWlFMUs4N296YnZrb0pzbFJWQ3NNeW5ZemVUeVVZ?=
 =?utf-8?B?WStMc2oxS29EM09yK2lsU0lzOENvT2l3RE9Ja0tuV2Z0TDZyeThscHdoME5u?=
 =?utf-8?B?cUZJbGdjRjVNQzk4YWRtd0N0RXRCeUZsbWdSWEllcTUvVUw0RWNLeTVkbXlZ?=
 =?utf-8?B?RDdya1k5UFM3cExBODRoa2g2QmxTdUIyV1p6YkMyVFJEa2Fvanp3Sm5vRTIw?=
 =?utf-8?B?WVR2ak1PYmtwd3duNjRsRDRNbEU3dTBIVldVMmJoeXVIdTBxOXMwV3lJS0RF?=
 =?utf-8?B?TUxicU9USUFRTXEyenloWmkvcFYyOU83S0lPc3Jzc01TOFdtcnE0b1lDTWR2?=
 =?utf-8?B?UDFyWGFZTTlBNkxsaDhzbGdOYTlGeHhRa0JpQXQ5ZTI5eW9vUFpiVTNITmVT?=
 =?utf-8?B?ZWUxbjcyTE9lUkN4YnlLNnFGSjZyNzBlUm15VlVvTEJYTW5Rb3RiNUt0NnZJ?=
 =?utf-8?B?OU4wL0dacHg5L3lwSTlGMEp1VDVqclE3YmJ5R0J3SzFpd1kyWkNJL0pRY0ti?=
 =?utf-8?B?dHJhRWdIQ05UMlB1QVJMYkg1bkY5SkRteU1NeXNLYUg1dUJZR3NqaVRLWWxQ?=
 =?utf-8?B?ZXp0eEFtVUR6dEpwbW9pZWhpVWFtaloyUFFhNzY1VEVVVlRxeThVSWlhY3Jj?=
 =?utf-8?B?UjdxN1ArUmxMZ3NHb1Jtb3RMaElWdC8yR2ZMRTJ3eHVISzhwM0FNVFE5NE9m?=
 =?utf-8?B?ZTJIdDZUNzlMWFNsUy9Iano5NjBzUVgvRXprTU52OFh6SmZ4S1ZlenFwa3lC?=
 =?utf-8?B?ckRnZGlDdjFURmFPaUpNeVJYNkpkcXJ0K2F0RDUvMis0cGt3WWdTOCs1c2Nv?=
 =?utf-8?B?YzdyNUtFZldGVUZrdFhKSnJsWEhYMFJQbzVyWFdhTGV6WDhPVVNaNW5ZNnVJ?=
 =?utf-8?B?RVZjWUl0cXN1STdCVGt1YmJoL085SEVWSDAvOHMyYWJWalRBVFkxNWNaMXlT?=
 =?utf-8?B?cmxQaWxDWmNnTFFtNzBmbUVSVGd4b0dFUHR1aHljTHFUZ2hzN1Z0My9KbkpN?=
 =?utf-8?B?RnBRZGlCY2IzbWIrTXI3TTdFUzAyU3BaTjl3QzlVUlNGci9wanVZd3grOXVl?=
 =?utf-8?B?ZkRibzMvaFdyRFY5bGhvQUdMZlJuaERscXVjZ3RWL0JaRzZHdFFkZ3l4QnZU?=
 =?utf-8?B?bjAvbnhRRGVQeWFxZUNxMVZsV1RTZTN1dFZmQnE3K3VyRHl4NkxzTVQ2OGph?=
 =?utf-8?B?SUNadzQ5RUpYNmVxUEowSXA5RHhYMDlMOTFOcnhVUWFHbzI4Z2dhMy96eUJn?=
 =?utf-8?B?U1QrZ21lUStNeUQxUCtmSzJIOFpBUEtUVmNwT0h0L0pvNDNzTVRtdGlseTFz?=
 =?utf-8?B?UDEvcFk5MTYyaENSMmxmbHRsd1hBbXYwTWFmNG0zRTJCSFowRXprMjVsMGwz?=
 =?utf-8?B?VHFrNkMrNEQyNWlJOFdmSEo1T0ZmQkx5R3RaVm16VnB6K1pqWTZIOU94d1Zv?=
 =?utf-8?B?cXdwZmd5RHFGU1VHdHBFSGI0N3k3NnlDQ2cwc2J1dGZSY3dGSXdiWFBUYi9H?=
 =?utf-8?B?b2xVbFBrQVFCbEhtYTRIZ2Z3d29kcE9SY21McDQ2SmJWbEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZQMXllL2hMeW1Fald2dHhPbTNBc1c5blMzcXRRdVBKV28vWGZ2THA2amha?=
 =?utf-8?B?QzRqajR6Uml5aThYa0ZOZ0RzNTFvTkZRV0hpMWs3SjZmc2s2SFBGWGx2aGcz?=
 =?utf-8?B?Zi9WdmhXcDNpZ0dGMVFYOWozZGREdUJIdE9McUdZUlZ6VDBsZUM2TDV4OWNs?=
 =?utf-8?B?ai95Q0lzbXdPcGhNWnFrNWIxRG5yRS93OVZYN1kva01Lcmh3UU1zYTRaaXVD?=
 =?utf-8?B?MU43eXJHcjRLRUhpT3lDN2VOU1YzbXVaVko1WEcwa2FkRTdncW94NTRoWXFO?=
 =?utf-8?B?Vy8rSjllNEU5QUhlN2RpWnRqUE9Nclh2S3FISHk2TTlXT1pPUEpuUDg4dmZM?=
 =?utf-8?B?QmVLK2NBMHVRL0xablI4bGdlLy9lUFROa3o1NThrcE5VaEV1c2oxTHp3ckNh?=
 =?utf-8?B?cTViTkxITzYrUmY0dW9Wa2QwT1pWVkdIRkxIaFNsK3lRRGd1MFVYRWt1b2Zh?=
 =?utf-8?B?Y0N6WTZ0RzFCUGxlTnI0NmpmeEJCcFNsNlYxVXZ2dU9WTklTdHJxU2o5MERE?=
 =?utf-8?B?azlNQUJZNE1FR1QreEdBZXQxRW5ENjdzajgxQm51eU1SWlJVcmVxQTRMOUJZ?=
 =?utf-8?B?Z3loTENmS3gvWGp4eVQvTldXUjBFZ2tPWHZLc3BPdDRISExHTE1kUEVWV0ZW?=
 =?utf-8?B?VFQ3MTZEeG81WFZsUHllYlBoSWc5bWF6SzBadUo4WWZ4a01jeGtBMlBrcTlu?=
 =?utf-8?B?aS9PNE1qRVEvSkQ0Y09TNTI5TWFEQU43UFlEcnRMbVRONnJkMUZWRnppdFp1?=
 =?utf-8?B?dXhxRkUyY2NIcnVLaVpkL0Q5UjVPUnFpM2EzSVFqQjdVOWREUnZmMzFURUZw?=
 =?utf-8?B?Rjk2Nm5UbjhRU0xDemw5Zkw4blFZb0wybXFhdzhIK1VBdVRxbTFzZEZOMmha?=
 =?utf-8?B?dWp4TXlTdnE0dDJ1YUpLMSs0SGtmVFFHOFNrMlM5bkpST0c5bTRMUjg4ZldY?=
 =?utf-8?B?ZDdaRUFVOVlOYzNjUUQ2MEdlYUtnTllRZXd6WllIZ3RlbWluZnR3Zml0ZHR4?=
 =?utf-8?B?eS9RWlJqU1ZVaXU0UkRVZW5CWEI2UHg2TVcxdjl5MmJpRUN3MTNjN043TnNZ?=
 =?utf-8?B?U0wxdHloS0hFWnhCL1pGQnJVeWNqL3JGYklCVVovYzZDUXYwMm03VzVOWXY5?=
 =?utf-8?B?U2dnRHdXZkNEeFpmbUc4MFJEYVVVeEZ3U0IwcldzenFFU1RodTladkVYSEQr?=
 =?utf-8?B?amkvL3hpdTlBb3d4eWg0dmt2SkpFZWNWUHdGN1lVV1ZSQkk4Wm00U2NMNWll?=
 =?utf-8?B?Y1ArMm5PVWFuV3JBUFJPc2FSYzczbjlXdVlWeldLVDFlMkVxYkRvWkRTeFRi?=
 =?utf-8?B?TGVLZVMrZUdYYURrUlpmam5XL2RpWDlHRUtiNTIwT0ExdDdTSFZlTEFsb212?=
 =?utf-8?B?Q0psbStZcEZVQUExb0JVcHdnQ3ZrYklNdEpVWHl2cEpuRHEyK0hFcjZXVHF3?=
 =?utf-8?B?djRlVEx2US8wRDJrWUVnTFFPa2FIZlRVUVRoKzMwVkt2dXBUK201Ulp2cS9v?=
 =?utf-8?B?YjBqNWNZMm0ydkJISityMEw2emN6TmRrbUVmNmtLK1hZMFNpWjVKcWNDZC83?=
 =?utf-8?B?OHpjOVdwSWxXRFQydFR6Q2FaeFZjVEJrblNjcCtSSjYrSndxQk1lNkJHSUow?=
 =?utf-8?B?SElMakRRTWY3em55bTB3OVVMTzlRK283Q0EvRW9JNEhlMDhrTEc5WWdzSzNN?=
 =?utf-8?B?YXgwc2tadTkvWlZ6cVY3dXQrTFNUNStyUlNBL1ZRN0Q2ZDhad3NGQ29ha044?=
 =?utf-8?B?VWUzSG55TUxYdHBWVHN3Uk0yVFRjRUhvVXM1SnU4NndRR0k3dHFDakRXSGxJ?=
 =?utf-8?B?TEdxb2YxWFBhQloyc1lIdkdVbHpCYWo5NDlzaEdjbEk4TUFqV041RFIrcE5a?=
 =?utf-8?B?c25Xb1o4SnJucXY1QW9telgyNldsS2Z0WmI1bm5LejBLZndhMnhFWTdhaGpl?=
 =?utf-8?B?b3dzVTdUcDBEaDdiR0tQQ1FSdHNKTzB2ZjBMV3BFa3A0KzlXVFprUG4zNVhH?=
 =?utf-8?B?VGZlUXh2R0RZUktvQjlpTC9oY3QrbVNHRENxKzB1aUliS1Z3VE96cTIrcXQw?=
 =?utf-8?B?VEVUYkUrYk1ITVVSSHIwNm9NNTVvOUMrblBuUCtrTXJNTXA3UmpQKzk5dFp1?=
 =?utf-8?Q?vkQ5OFKrdKjczPyiBC8aVdOzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6aee10-326a-4caa-a0d2-08ddcdef888f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:58:02.9927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w60o4nDtC54GJQl3tb9AR2/IYOer+UANYsytprQllBxxJpwqzAMoL7xVxRbpI4Hu5Jqlc5ihT7fYxwIeyyMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

On 2025-07-22 13:47, David Yat Sin wrote:
> Add support for checkpoint/restore for SDMA queues of type
> KFD_QUEUE_TYPE_SDMA_BY_ENG_ID.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 67694bcd9464..837da09b5bec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1261,6 +1261,7 @@ struct kfd_criu_queue_priv_data {
>   	uint32_t doorbell_id;
>   	uint32_t gws;
>   	uint32_t sdma_id;
> +	uint32_t sdma_engine_id;
>   	uint32_t eop_ring_buffer_size;
>   	uint32_t ctx_save_restore_area_size;
>   	uint32_t ctl_stack_size;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c643e0ccec52..fe4c48930aad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -846,6 +846,14 @@ static int criu_checkpoint_queue(struct kfd_process_device *pdd,
>   
>   	q_data->sdma_id = q->sdma_id;
>   
> +	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> +		 q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> +		&& q->properties.sdma_engine_id) {
> +		q_data->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
> +	}
> +
> +	q_data->sdma_engine_id = q->properties.sdma_engine_id;

Is this really needed? Isn't the sdma engine ID implied by the sdma_id? 
That should be sufficient to ensure that SDMA queues are restored on the 
same engine.

I think we should never see KFD_QUEUE_TYPE_SDMA_BY_ENG_ID when we take a 
CRIU checkpoint because that gets replaced by either KFD_QUEUE_TYPE_SDMA 
or KFD_QUEUE_TYPE_SDMA_XGMI in allocate_sdma_queue.

Regards,
   Felix


> +
>   	q_data->eop_ring_buffer_address =
>   		q->properties.eop_ring_buffer_address;
>   
> @@ -972,6 +980,7 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>   	qp->queue_size = q_data->q_size;
>   	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
>   	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
> +	qp->sdma_engine_id = q_data->sdma_engine_id;
>   	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
>   	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
>   	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
