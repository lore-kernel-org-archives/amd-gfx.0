Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF3C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 14:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EDF10E2C7;
	Wed, 29 May 2024 14:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hxwHFLxj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E395F10E992
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 14:35:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H28UpywRPxJNUxb1l51/jSi+HMgQG3DvfLVch7cr3AVsggnG8TJNItlEnU7KHZ68MjhQZ5KYYTAGFTfxPD1U6VCwjdQDJN0ggE/8SxsL+qtaJuMc7amhk6xTo5tQXnjb2K951Y3o0ElsG/JBisGr17JXi8JPOpDGq0+jHD2C4l7YQxlwm9MKCX4U/jvB5c9JrG2SpdvtQJrVS4yrJZK1WIW0cP7r4VwT5TW//ZLDKQK2zaB08E3wQEL11b5ImzcXrRMd2C5MJcPCQP+iAFgUPkdnsJ3SdFYDPSG5cE//rcQs8XtTXsFZaMWWjrj+8mV1+h4goxJkYZ1roS4dXcrI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo4K+9Cyf5V92Es3lZCU7k+PJtjjprRRBomQZwDF1/o=;
 b=L458LBQ/Mg+iWEA+2y2QQVnqndlbV/Df3vvYrH5FnaZoCJo/kR5TDY7wxlV4IfpDbOlp0Oz6zw97vQpAI7aw1uFFff32j00gY0sL/pW71sq3YLTsz4YK+6CbxEXXCEZOEf1fEc1IW2XOuLwIQ6C84EOApoMfMjekvjz9YhXtFczP5TA9H9AR85f31xGF3/4c7A22vw2SmBm+mM2XlskQTflgDJVNxpqRevbybtvmhPcXIfAI0Tp4oYHbaR5RVo2VsrqBG1QY5mcuaT4svHMxbQOYiYoK0T6dGrJYz+ughh+WK5qMnmp585g2v6XuzLWRy+ZM9LDJvh8LgfZd5Yf7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo4K+9Cyf5V92Es3lZCU7k+PJtjjprRRBomQZwDF1/o=;
 b=hxwHFLxjivcmc2y1l82l34MTPBYrYhuvBvqdWxdAraqdvWvEgRlmMY7RsHVb4IFaDJrpNUIaNus2V17dhkOtADViChpMMQWXYVrY3ZhSzR9a6quCGG7wVpKf/C9eibwCT3bUEQ7W8EqC6z4i0DKkn0CdgWSSg1GCnJlMvA5SBFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 29 May
 2024 14:35:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 14:35:13 +0000
Message-ID: <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
Date: Wed, 29 May 2024 16:35:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: de8399ea-0544-49dd-9fef-08dc7fec8cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZkUDJQSytTV056Y2J1OHFacVZabHpuSkFzRWVkMGI0L2F3MVJqWlp6MmE3?=
 =?utf-8?B?T21XQUw2UnFReEhRRkVOV3hPQ0xrcGpFTzlJK3UyNktqOW92V3pSSU9UNXFP?=
 =?utf-8?B?cmlwRm1kMDJZekk1ZUNQcUZIdnFvcGExb3YvUzg1OENKSHNmWkJjNks0UXBt?=
 =?utf-8?B?ZmZRMnlqYTUzNzhkaDIvRHg1VVV2NEdiWkp0bFV2azFzWUpGK1pEK1VpNldt?=
 =?utf-8?B?cHljbTg0WHBpYm9LbW1OSjExTjR5VElmWHp3UGpZc2dZUVNqcGxrcHdUWHpY?=
 =?utf-8?B?NUNVS0lOODZHOGxwRWZ3WWljTEdvR0tJcUdaTEJSSitlaUVIRU9FUC82d1Fm?=
 =?utf-8?B?OFlqWmVtNi80ZTdqWFhGMEhucjlnTXovQ2I5aG9UQXJoSzc1VS8rMXhzUDMw?=
 =?utf-8?B?NkgvT3BIK3RXRTZ2dFE1RE5FSEZlaWwyVGZHclFsQk5RaGxveGJBbmd2Wmlq?=
 =?utf-8?B?K0hPT2lsRnkweUczaEczOUxyUUt1R1JYRnpRdWxEcTFqWU9XK3N5TmdxN0hk?=
 =?utf-8?B?MzhQMFlROW9vdFFzMTFkdWRLNXB1b1BQVGtlRnptWCtUV0paSC9RNHNRUDBT?=
 =?utf-8?B?UEhGbCtJaVFmVEpEUXZTTUFueE90dlEva0ZXV1E1YU1RTkVNNG4rd3pldEpC?=
 =?utf-8?B?TjdmSmtLcHpuQ2tBWjl1OFNDSDkzRGlqOXRJTjI1K29BS01XTVV1Vzk0UjV1?=
 =?utf-8?B?bnZTZEw0ajZ3SlpYeG91NkRmYjVmZERIQ3owdlZxSW9oci94c0Q2WlJWL2h6?=
 =?utf-8?B?YnRaN0dBcGZxeWxOYktRY1dwWUNXQitKN2YxazRrTSswdWRtSEF2d1JMeVBC?=
 =?utf-8?B?UXNMQ3JNL3B3SC95V091NHpWLzZqRGdhT0g0WGtJaFZMOFdrdzF6aFdNNFdG?=
 =?utf-8?B?MHQ5UHFTNGJReW5SR2l2UDliNy9DbFg1L2JVZHlZcktmRkwwSEtBSnY2bmFB?=
 =?utf-8?B?Vk4rdDlQUXBWWkJ0MFZ1eFIwV0JPSjMzdENnOEEyRWZmYTdIZmxoeGYwWFZL?=
 =?utf-8?B?OGpCRzVHSDMwTHIyUngybjJ6NkYybEtTSVV0cUhqb3Q1VjRlN1Y1ekVwdXdw?=
 =?utf-8?B?cGlTdzlxWkFaNlJFRDczYkFYOGwwVDJCRk9td2lsVXFFdWJ6KzZZa2hBTllI?=
 =?utf-8?B?NlpnaWxrcTBKRnZMcVlVbm13Y3liYXpvVjlpRm5rQnBvS3VaSzhvSGpJVUYx?=
 =?utf-8?B?R21BQWdoTzM3ZEJzUUw5Qk1xVEp2WS9TRzBSVEx4TW1lYmFNbWRsK2hxNWcr?=
 =?utf-8?B?Rzc2VkF4eGQrSCswaWZ4SjNXM1plZ1FQdnpDdW5sd01Kd2l1VXFzWW1VT2xu?=
 =?utf-8?B?Zzk4Wnk0OE5FS0c0OFUxRTB6clJDc1MxSGxnbUZKNkVNRWxDTVZUNlZFaGE4?=
 =?utf-8?B?ditEQThMTVhDenp3QXlPV0diM1JpazVYbDNYY2Q1dmt0KzBBV3ZuNHVwWFZL?=
 =?utf-8?B?cVFXRFdtZDVZTTBTd21aeGEwRzNUZUZYazlZazNIT1ZNUDI4dW5TczRtRTQw?=
 =?utf-8?B?VGF0b3RjTDBjSlVoM09PZmx1aWJaOGJFVTZSUWxsWG1TOVRqb2VyQU95cStL?=
 =?utf-8?B?YXhBd3lUWS9OanRZT2s0TTZZVmZDekFwbUhLaXRTRmk3YmdOTmpMcXppbHVZ?=
 =?utf-8?B?MFJheGd3R3A1Sm1xemIycVlQYm1TUXdrZzJ4UFJUbk9XTG41NHpQNlJhdDk3?=
 =?utf-8?B?OUVOZWZXSUJyNGRGME1QYUxYWjByb3VxY2s5L2YwLzZCQ0Nad3MrTllBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2RQZ29FbzQwWkdEaXVQUTYyUVRTZ2VQUk9KcVVXMXl0M3JWVVV3TzNtMU1o?=
 =?utf-8?B?ckU2YVJPNFgvMzdHYnk3VWIwdEhpdzk2UGNpVndvRDllckI5NU9sbDMwRzUw?=
 =?utf-8?B?UjNoUVh4NHk1aFBmRURtelJyVk55elVLNzRLd2NoRUFIMjhIUkorQ0h6Z0VB?=
 =?utf-8?B?YXlSNmVnWmFGVTdnNzBaK2hPN1hGTU43K09oNkFFWUdnbDNDeVJ4K0dlRHJI?=
 =?utf-8?B?a2w5M2dydTZwaWtUdDdjRmdCZCtnYU40RGNjZkRtZlJSSmRPb0JNRkFWT2Rr?=
 =?utf-8?B?aVFncHd4SVR1b1pQTWJEOVVOcFBKSTM3ZVpweXNZU29vRDdmYWpaZmtiaDU2?=
 =?utf-8?B?MnVtU0JMMUE4L0Q0YzU5UkJiNzFML0MwblZKWk94dXU2eGhKYmdQSTJPeTYy?=
 =?utf-8?B?UTF0NElUclg5WkgyWTI2RTFtLzVCSElGbDV2bEo1UGJpa1BCK2prSndsNkxH?=
 =?utf-8?B?Qnkzd3FGUzNIQzkvd2dPclh0UVZVTTVxNHUxQVZMeDFBazVyVmFSeGdzbnEw?=
 =?utf-8?B?WmxHRFgxWk00UnRKaENRcG4xbHlVdld5S1E5YUJKemdSbGJRMU5tZjIxbGhj?=
 =?utf-8?B?eUgyeWo3U2xEYU53TVVUSytGNGgwRWtnQTFFbUxLTFRzeCsvSmxEOW9VaVdW?=
 =?utf-8?B?VWtQR3RUWElUZWtOWDRIbFJLRHRHUGtvek93WjZFUm5QVHQ2TjV4ekJWQ0hs?=
 =?utf-8?B?bzhLZ3UwUDU1RWRFUTNZUm1aYm5LZGZueHkxUjNhZzhGYk44VWZ2TzRVbDhC?=
 =?utf-8?B?MHFNb1h3M1B4US9qQmtpMVAyMmZSNEpxdDUwYWxkUkRDcXczTnkwSWl0TWNs?=
 =?utf-8?B?bTI3elQxNGxXekEzQjFOeEJCQ0tweGNoK0xGTlFYdDFzZGoyUWtZN2Z1Tzg5?=
 =?utf-8?B?ZUIybThmekxWc0tNYkpOQmRVZzMrS0UrcDllWm5zOE84a2xtSlArQUgxUEhM?=
 =?utf-8?B?VGRlc3lvUmZkSGxObkxHQWw5L1VsSGNwT0dKOXJpang3YzYrZjI1NWFPVkwz?=
 =?utf-8?B?ODhNdWhZR3NKNnlZU2E0NGV6SjkrNVdNTXZWOGxaQzZGdWtWZ2Y3bXZNQjls?=
 =?utf-8?B?VU9ZTkZiWW1qVk1LMEUva0lhYjRuM3RUZ3phdUdzclJOK0ZBYnBGVmErYkR2?=
 =?utf-8?B?TEFoMm44M01Db3BQVnZUaERMS0tQY1Z5VGdCTkFaV3JVYUxWUkhhc3JXVXlB?=
 =?utf-8?B?b3FXYVExempwMnRDUzhBeHEyZ1JZc2VlaEZqNW80aWdGeUhJMzdIdGtNRHI4?=
 =?utf-8?B?b2ZsMDNCREdQRHVBYTJmdG1kMFJhZlVDc1Z0WlhOR0JUeVpteENIZkRUOEl4?=
 =?utf-8?B?SkhKQllHcWN1c3ZMOE56bWhlNHVLT1R4UXFVSVlyZWZUR3cvMXBDS24vUU9z?=
 =?utf-8?B?VElHUUtsWGJScWgwS1dLQlczREJmb0FCMHFicEU1dmJxaVovcURRU3ZpcklE?=
 =?utf-8?B?S0JOb3BNb1p5Rkhab3ZNRk9WVGxkem5XcVd3bzdScWxIOTcvMkRLb0dsaGZK?=
 =?utf-8?B?SytPV09hbC9NMVpXdTg0SUFSdDdSR1BNbjcvcWVhM1huUGYwdDhLcTdybTgy?=
 =?utf-8?B?VS9KVzZDM2dEdkRRaldWa2ZVWG1TZ05vWEY3VW5OdnJxVjZOVHk5M3JSYklr?=
 =?utf-8?B?ZlZUZWFhVlR3WnUzRFc5ckVidDA2akZEYUFQVTN3NHlCWlhVcjZmQmdoc01J?=
 =?utf-8?B?NVYreG1zZ1VXU09SVTlINGhjS1p4dUYrUGJQUlV0R0hKQ2NtVHp4QkhLSU5U?=
 =?utf-8?B?clZlOU9yVG8xcGNOWjU5Uk1xZ3VKNmRwQ0FGNU9qaTg2MzJTU3hTMVppZnUx?=
 =?utf-8?B?TXNLUzMwWldEaEpxU044WU1wSXRZV2ZsWWt4SW9LdzNVTHlVYzYycjRFdXYr?=
 =?utf-8?B?N0pHOWhzaEJyTWVSNks2NlR4a01SbWdOQlVYWm11OEFidjhwZm1lTjBxRFNw?=
 =?utf-8?B?OVNRVTlodUljVW40MmlXaGV1MThVUHVRcnBWeUdSK0dKR1cwMkU4TFNUWFpK?=
 =?utf-8?B?aXlQdUVTdnlaTmVIRGpOWXYyY0RjQmVXYWp4N2t2MzROcGFWWmlIdGpjcG8z?=
 =?utf-8?B?cDR6NnFoNUVqeEltY0h3UkhYT2pPWXRNZGJYQ1h5SHFzaERBSGxJRjdBMDZ6?=
 =?utf-8?Q?d+YXGaX+ih/2pNFq668SPRvLU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8399ea-0544-49dd-9fef-08dc7fec8cd4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:35:13.4214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3q/g5/mzpYwc6U349stQrWfdgIrfl7D+iLGZfBw77Y/6Djb7bimrj6D+s5Edre3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

Am 29.05.24 um 16:31 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> The problem is that we don't force complete the non scheduler rings, e.g. MES,
>> KIQ etc...
>>
>> Try to remove this check here from the loop in
>> amdgpu_device_pre_asic_reset():
>>
>>                   if (!amdgpu_ring_sched_ready(ring))
>>                           continue;
> Ah, I see. Though I don't think this would work for the mes case, since each submission grabs their own wb address rather than using the ring.

Yeah, I know. That's one of the reason I've pointed out on the patch 
adding that that this behavior is actually completely broken.

If you run into issues with the MES because of this then please suggest 
a revert of that patch.

Regards,
Christian.
