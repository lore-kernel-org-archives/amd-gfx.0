Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D72C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 17:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE30010E580;
	Tue, 16 Jul 2024 17:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="va9zsUIV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E495910E580
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 17:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=worcZP/shKWQbagbXRqgmrDA4M+hSkr5umme+mmyg8qprbk9RZ0arVmCijP0u7tElax02ImSnZlIdGT1HHfNCBphfifoYYVSqzHA1xlwWzkEGYmq0DJIAE6qv0PBxyZ6MZeyNqK2+xi94Tjb0ZECDIjRTOUsHEGAtsOYvk1XlK1CNCxj+CKeI1lmaRN3bx2Ksr+T+j97Tia1Zmfyd6NLjrF69RrD1TDU3fLkeIRVR0u6bdtZO9idqrxjuQ05+bqqiUS9Lgfqy/Tg+hvw6e3KH8zMoMCcsLnzdNJaH4cKIUz/Zp4uOSKcqvucB1TE3s8i7D96VvqINE7d1Z/KRq1tdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/oEoaxRwiv+1RLYtFk3XmloSsTVfcgyJzJoEkhovsU=;
 b=vtNkAjRJxN+4Gz96hV0w7RRzMDXJqRl0ik+N4e1PBSLNJTKaGDkE3xZ17UBZhYQObposS7yQUgyf8YBv0cwbH7vKpZg2k3IQx8sVT78/Ch3GQVc7DZO5akzFcMF/JRpUcxpNtzCB4tMQFlxS8r0l2zj6B2SyZ5AVGmS7CFx4b9iNMP5CYUgpX7DdT1H4l40AjL6ZBEvP6YkYxtpE+ySv3HL/Pwd9WM+71ZM23HDuZxMksY5V2c8m7PIlEqjmisQfo2U5AsQ6rQMhng/JcU+duk/DghQtoOqz6lo6k4VybnP8wMxDy+MpckHQo5gGETTxoTK4ooBUTPToqmqYwlaukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/oEoaxRwiv+1RLYtFk3XmloSsTVfcgyJzJoEkhovsU=;
 b=va9zsUIVtmIoho580jxac/+v61lhKkT3T87FGNmrWdJ+GwSEB+rbUqpXED9TX1vpFnh0A0lv6xenV9eZW43fBGoqiKgM3wJW7DgjbZ1hGkX311Geym8+uS6N1WHitZ3LY5HHmkM+WWPSq9cGb9uZmMC7g9v1/RVdpAzoa4BpbC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 17:47:54 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 17:47:54 +0000
Message-ID: <3e3db9ba-5cf6-451b-8845-a881a9387e01@amd.com>
Date: Tue, 16 Jul 2024 11:47:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix corruption with high refresh rates
 on DCN 3.0
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Cc: mikhail.v.gavrilov@gmail.com
References: <20240716173322.4061791-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240716173322.4061791-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::7) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 524129d6-e8b0-4b20-a51e-08dca5bf6b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXRsQ1h1dDRabGxUUjF2WDRuQmNOdEtEOERFOElyUm5wQno1UlNzUVlaSCs3?=
 =?utf-8?B?bmovRjduMkRmQmxqVjN1c3U0aHB1UVJvM2V4a0VIaTBtSUNvakZYcVN0V2Rt?=
 =?utf-8?B?bXdDc2hCcU1na0JKVnBUVk1aVmthWSthc05oZnV0S09ZY1psS1lCUlZ0YnlJ?=
 =?utf-8?B?MTYxYzBhT1QzYWxpZHpWTzlMdU9lcTNDazk1dCtsSVNpOHhwSzZzaWxyeWph?=
 =?utf-8?B?R3pjbyszMmV1TmwrQjBucThsR08zR2tUQVNqT1p4K1RKQjVSMW42aCtkYllj?=
 =?utf-8?B?eEZtMk9SdmhiaTBERXJLQmp2bEp4dVpBaGlOMDJHOEJFZ1NLNWF5WlBIZmhD?=
 =?utf-8?B?OElyYjNiTlJPWFpBMUhOSUMrMHJyZVhzZk5EeUxxd1kwRytBOU9ScDhHZFRF?=
 =?utf-8?B?ejZQVThPV1d4UGZJQUMwRGdQUXRqTzNvNzg3a0V2V1c5TVMycEovVE04YTdp?=
 =?utf-8?B?S2pTVWVEOFRiVjlJRC9iS1JmM010MlQ5RzJFV1RGcGx3QXFjSjBUQmE3VFZx?=
 =?utf-8?B?bWVUZW9vaDkxWXFpczdMYmdnb1ZSZ25Fb05scDc3T3lQbXkwcEgvQTRLMXhB?=
 =?utf-8?B?bklheUZXek94cUZGUW5VWVgxSzlmcElJRldsTjdxTDFkbTFkK2p4OHhrZW1I?=
 =?utf-8?B?ZjhTNmlybWQ0aG9rNTFyeThJaDlmKzdHRE82L3NjYi9EVnl6Wk9WZjUyenNi?=
 =?utf-8?B?ZmFaOU9UV3ZLTC9SOTlMd2c4aEk5aXdDLzZSSS9zZVU5RXhjbS9JMkx2dTMz?=
 =?utf-8?B?SkRoM1BDSDVWNWdaamtaQ0gvZ2lFYlNtUjJjeWVRRmtmQnpMNklEWTVvTlA5?=
 =?utf-8?B?bC96MHdaV1BDcE5YZmZSc0M1NnBFeGQxZEFmV1FaVHlJZXB4WG8zbC8veG82?=
 =?utf-8?B?UjFseks3Vi9oM3JjcW5yRVhzU1ExV3o5THY5L3VJdHNZMWdUM3U5V3VEL2cz?=
 =?utf-8?B?N0NLTzNlU2E3dTNJd2pVU0FTcHpiNXV4clZqcWF1eW5jTjRmU0tvb0NLM095?=
 =?utf-8?B?Tk9IdXdSVk53ZkJtQXVEZXZkWkxGTndjZnF1M200N3psZ0VvZDVDQzh6QXZ5?=
 =?utf-8?B?ajJZSFBUQ1U2ZkROZlBlOWl1TUlPQVhVVUdQQVBDbTZoWWp3d2NZeUVGYjZ2?=
 =?utf-8?B?U3hVYmM5U3lLblhmV1p3ajNScFVwWUlpeTcvbERtVEU2cFUwQ201dCtwdEd5?=
 =?utf-8?B?cW54L1p6RjRONWtRTU9FeHpWdDNPdWJwMjRGQkVLRFhESFNOSDMzdTJyMDZh?=
 =?utf-8?B?cE5XRStPREd5b1RiSGpiSVRNMDhqNldkYVhURkpQZmJZYkMrTVBBSGx6dko1?=
 =?utf-8?B?ZDMzYkFLc0xSZDFNaEtSQmtXSk9obUZ5TXlBTjlTandIYkhlT05mOG41VDNZ?=
 =?utf-8?B?ZWNDUng1d1ZhY2JTVGdUV3JPY1pHYmlraDltOG82NzRnSFp2SmJNQ080M21V?=
 =?utf-8?B?Q0FIU0R6SjhFeTZEdmlDaEl3QmdTbmt3ZEZ3TVFWTC9VV0M1MURpeHZRcU8x?=
 =?utf-8?B?N0lzemJncjYza2pjVVRnYW9UZm55eU9wR2tVWGNBS2RmaEE3diswWlAyZ1E5?=
 =?utf-8?B?d1FRRDZNUE1QeU8xWkxWaHVXQUJnY0lOT1JqZnBKZXp3eGpVUE1ySW05NFBP?=
 =?utf-8?B?bzZFQXc2NE85M25rcy9Fc0djeU1hT0UxQWJOcytMeUlPVytwbStXQUhaLzBi?=
 =?utf-8?B?dWF5aTJ0L2lEcXVPcitxZ3JJUnRjTE1BRmVnbHA0MWpicDAvRjhRejFaWVNH?=
 =?utf-8?Q?VFO788q2Wm5H6FOTpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXlSeGE3dzlYcjl3NlFQRlpUMGxzS0FqMXIyd1h1RmlVbHZpWUxSL1ozL0pm?=
 =?utf-8?B?YXIyRWlMWFIySG5qTlVzL3NQaUdlVTJsNS96SVRBbHRQU1JlTDJLK1grWHl2?=
 =?utf-8?B?UFRZbHFSRzVsZFRwQi9YNjNTb0tTSm1pN2UrWjYrYTU4L0xOeEgxQVNKVGla?=
 =?utf-8?B?Z0FySjdmbVliY1FXSWZGd1FuMEFXSFhyTHR5bTkrU2s5anpVYkdHR05Oa0th?=
 =?utf-8?B?dHFnUXFrYWRwQ1hMMk9TN3RtTmNFZlpsZUl5V0lkMkhRekJBbm5FY2lNczBa?=
 =?utf-8?B?VFBQZWVNbWJia003K3ptb3FNb2J6Q0oyaVJZZUdaNnZaRlpxTUxrT0Z0WnpH?=
 =?utf-8?B?OHdUaEsxRUZTMXo2eVUvcWFGYUZjNzhDTVYzS1EyNGtiVXBPdzcxVmdENVlr?=
 =?utf-8?B?VllNY1VMMHYra0RGejg3UUlhZ2h0YWY4bmZaOHNGSEcxUE5tbE9qUHpnQklU?=
 =?utf-8?B?R3BtMW5QSWN0LzRJczd0VkE3bWU5Y1FRa0xSMEo3enVHdkI0UnVrZFd3NmZ1?=
 =?utf-8?B?TFpNZVVrU2hhZjBYZ05zUFo0WTBVSG0ySDd2VURrclpkVXArcVNocGdUOGhm?=
 =?utf-8?B?TjFTN1FWQ0JDRWE5ZEJqVDlDc3B1WVQxU1hLb2hVUWViSzZSMEVOT1l0OW8z?=
 =?utf-8?B?MWpzYXB4R1BiVGNBaytITnNPSjV0L0pyNlZvOVNzTHdSYnp1U1N5MmEvcklR?=
 =?utf-8?B?WGlwbm5tRGdIM1F3MFJoa0d0NnA0bldqMUNDS09YeW41RXhocmJZMHUyL3k4?=
 =?utf-8?B?Ni84UWpIZ2F0UWY4aEJ0U0E2eGQwbHJaUFQ0eFBsNUxDNWFFN0pkR0VPVFlq?=
 =?utf-8?B?QzZ6eWdBaENVbTEzc2NBNVpFNjhXNDZ1S1lna3VBOHR1ZUNYZXhmVm11OXNj?=
 =?utf-8?B?NEFNNWRqekNBWThHT2Urc1phU3dsTzNGZ1RCR2Z5dUdReUF3WXBVL0RZaHlB?=
 =?utf-8?B?bG1CVk9OWWFhamZ0ZHdheU9qbFBCYi9JdU5vM1NjMzBXeVFlTUdXeDNnYSsr?=
 =?utf-8?B?VVQ3TVBSblRHeXlOdk5TVzN5emdMZUp4Ym9adnpRYnRPc21jV3FsMmdEdkJ6?=
 =?utf-8?B?ZzJmTFBKamFqK2JYWVNOT3lWUFp0Wk4rWnFNNit3d0p3QldGUERhNHJpTjBF?=
 =?utf-8?B?UUVpR0lyVC9xM29xOEphaGZaZWZYdC9iOW52empQQXE2bFF3azd4cU1KVHBl?=
 =?utf-8?B?bHFFbDlocHpmb2RtSS9UWHg2bUliQW1yaHNON2kwVUJ2aEFyVjcrZWlad0ho?=
 =?utf-8?B?RkRKNlNFQ0VBNGVHcmxFemtsZnFlQ1dIUVdmaG1PYlBlWXV1WDR0L0RGMXpX?=
 =?utf-8?B?VmNuTmRXQVVsUHRGWng0UXVSWHBEak1VWngrbktYRnZRcDg0cFR6RFdDcGRF?=
 =?utf-8?B?Vkx3c3h5SURLT0wwNHl4Ykd5SzdKRHdESXJKMkYvTFZoYUEwME9WbHExQzg0?=
 =?utf-8?B?MytTY2F0NXhxajRlV1p1Z2ZxUjlieVp1ckZkcUVYQVhkZWptamVkT2t6ZThn?=
 =?utf-8?B?N2ZkdGxxSTJ4YWlIdGZZNkdidWxqVSt3WGNmb0drL2dkemhFTEppa3JhL0JQ?=
 =?utf-8?B?YmRWNm9UcDRPdExrODhqRUdUcnVGdzNybk9HRU9QN1JraHpsem1GQVZ0enRW?=
 =?utf-8?B?QmlSMWo0N29wQjhIV3FYc1VocFdRd2gwVGplUm1NbUI0ZTN4VGNvWVFaL3Jp?=
 =?utf-8?B?bHBQN1Z5UjUyK1NRMzAvM0RYaHBVQnp6dzhZcEpSajNLTnptSFFQQmFIZ0xF?=
 =?utf-8?B?ZUg3VE1yMGJzZ214LzVXRmp5VExqOEozV3RMYlM0T0x0TnJmRzRqTWkzQmho?=
 =?utf-8?B?aDRJdWVWbjFpSjZ1M0ZWTThRc2VGZWJpSkZZZFkzQ21sTWx5SER5Wk5JNEVa?=
 =?utf-8?B?Q0VORDNiK2ZCWFZ1b1hkb2NKQkpXWVFTYWw5ZG4xTFVLcGNVYW9Icmd4cjhp?=
 =?utf-8?B?YisveldFRHFzWjNxZkxjQUhlaU9DeGxHeWJleFlmYWJLWitwM3RtM3RDclg2?=
 =?utf-8?B?MXplSWgvR2dEbEI4SzE2NWxnN2JDblIrMFJjUzdWWnRIRUFJSDBvSWZWVVVz?=
 =?utf-8?B?eStKN2VxdUsyZThZVVlPOEZzQnFpVTVCYlVVUTd4dDVyTWFEaG1MdHRPUGpw?=
 =?utf-8?Q?2mCg4aYAYjpHDh6NXhNbtuy3R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524129d6-e8b0-4b20-a51e-08dca5bf6b87
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 17:47:54.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThIOxvxFIzCoE3qBunrfp//nIUPoX+uaPOoCaGYtvh41dKFZ3NcWkAoDUYzc4qluAZBTCxRSyf64ULdzOI845Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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



On 7/16/24 11:33 AM, Alex Deucher wrote:
> This reverts commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 and the
> register changes from commit 6d4279cb99ac4f51d10409501d29969f687ac8dc.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3478
> Cc: mikhail.v.gavrilov@gmail.com
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../drm/amd/display/dc/optc/dcn10/dcn10_optc.c    | 15 +++------------
>   .../drm/amd/display/dc/optc/dcn20/dcn20_optc.c    | 10 ++++++++++
>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> index 4f82146d94b1..f00d27b7c6fe 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> @@ -950,19 +950,10 @@ void optc1_set_drr(
>   				OTG_FORCE_LOCK_ON_EVENT, 0,
>   				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
>   				OTG_SET_V_TOTAL_MIN_MASK, 0);
> -
> -		// Setup manual flow control for EOF via TRIG_A
> -		optc->funcs->setup_manual_trigger(optc);
> -
> -	} else {
> -		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> -				OTG_SET_V_TOTAL_MIN_MASK, 0,
> -				OTG_V_TOTAL_MIN_SEL, 0,
> -				OTG_V_TOTAL_MAX_SEL, 0,
> -				OTG_FORCE_LOCK_ON_EVENT, 0);
> -
> -		optc->funcs->set_vtotal_min_max(optc, 0, 0);
>   	}
> +
> +	// Setup manual flow control for EOF via TRIG_A
> +	optc->funcs->setup_manual_trigger(optc);
>   }
>   
>   void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
> index 43417cff2c9b..b4694985a40a 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
> @@ -453,6 +453,16 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
>   {
>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>   
> +	/* Set the min/max selectors unconditionally so that
> +	 * DMCUB fw may change OTG timings when necessary
> +	 * TODO: Remove the w/a after fixing the issue in DMCUB firmware
> +	 */
> +	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> +				 OTG_V_TOTAL_MIN_SEL, 1,
> +				 OTG_V_TOTAL_MAX_SEL, 1,
> +				 OTG_FORCE_LOCK_ON_EVENT, 0,
> +				 OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
> +
>   	REG_SET_8(OTG_TRIGA_CNTL, 0,
>   			OTG_TRIGA_SOURCE_SELECT, 21,
>   			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,

(+Jay)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
