Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DD7D2ED14
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 12:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A232910E008;
	Thu, 22 Jan 2026 12:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xe8BZuCj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CCD10E008
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 12:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJaB7GZZR/UPG29onaAfeTZo2QiApm8UK7+l8XguFKdLi1XWhLrMIU8QwdiKgvOZj4fNWJnc8HsgCQUUmLtUL/YuoWRR/FyYU4Uk9Cop5RqD6EAte+pCqud58aqDGbVNNzVsZDclkx6wiAEwYk+IYXYx8qGXqTanJ6VCRYp0YO7AYDACuGnL812wpKez8WKobmfF8WcVTftCkoRUF2fLf+IzUuF7Il/iuCER5KJJZefHdN622lYf8MEM/DHmjDWjz+yu7HTFVmkfC3EiVxZbNtU9pD4b02n2oGDXlGm1RrrhnJ75ioP1Tdg7O7xsYyquYcwvDDuFUyvxX3xLpXYZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LPrT9hOIphCXFMWB3WFXldZw4MVKODIuSQ1HdDHHZc=;
 b=daxuZ/59JYKd4fe4LC1AAZoHNSiyaEaA/vEiSqA/iEAnEbQsuctS53PgOTCKHMqnn686mtreerSRO7gaRNUd6Pw+64imBnNNbwGjCojIrl6OV5WsI0ZDGbxR5aS2F9NpUBetKbK+FIbV7D9YZ4B2ASFJSkkNovUzm4FMGKJXOV1lrcn1wq0/sWEpTxBPSBZep2lL4YHmMQrmbcnvTQKrsGa2ZAnAMMlJMMtrMma8mXOKt+oqyOZeJI3ukP9Au8Zk0soTfbRBDaVb0AMLfJ36vEHC5kMgytogh/wWDL1kMkVie5dLsBf8/6lgqCSrvNwGh/9rrt36p6L2za9oPQ2AEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LPrT9hOIphCXFMWB3WFXldZw4MVKODIuSQ1HdDHHZc=;
 b=xe8BZuCj62+WWErtWsDhdyuzUSQ1o8D5nlW+vRMvPVUYdsS4FFc9MgLEs3ddGdcR+sZFDVxKTWhuG7J1QP1jzK2ufwL/WQtQPUeg+pczOkVf+lPm8GptDQY/IHq5ejWKW6+fg7LvhOjx7OpPTzQtGlzuGG9MuxGEA+0OGQDFOOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:54:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:54:04 +0000
Message-ID: <aeede61e-2c03-4711-8d77-efd551d17b29@amd.com>
Date: Thu, 22 Jan 2026 13:53:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
 <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
 <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
 <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
 <1a0dab04-cb13-9307-2853-38221193e38e@loongson.cn>
 <434e6332-2520-4ed7-9dea-8f5118dbb02e@amd.com>
 <f7303e86-2f1e-24ae-5c66-c33893896e8f@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f7303e86-2f1e-24ae-5c66-c33893896e8f@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0897.namprd03.prod.outlook.com
 (2603:10b6:408:13c::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5a5b6a-3a22-445f-dc7d-08de59b55249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXNkdDBUQnZrdVpUeTRnakZLNFk4bXNNb3VPSE0yN0dBOTQ1Q3N6Uzl3Sndw?=
 =?utf-8?B?VWRnZ280MjhQVHluU3NHMkhPMWFIL3pQTXlMc3R4WFk2dlNzdUNVZ0JycHVE?=
 =?utf-8?B?TE9jbC91Y0xqR2VXZkdsMnNENko3ZFBjUENWWDlETk5sc3Vzb2xDd2w3Nk53?=
 =?utf-8?B?Z2JKOVIwa0hiLytrT0g4UlhKbjduKy9OakhWQW5FaUJ4YVFDSW45SjAwMExr?=
 =?utf-8?B?UlhjSWlHOHlYMXo0QmFjSjFCVXduSUFEUlk5TFgzYzdxcmVyR3dmYi9tTTVo?=
 =?utf-8?B?amwvaEFONFZNTmJ0V3VEa1lPRW5ua1RIb0pNN2NGN20yUHZNNkZ1R2t6MTdD?=
 =?utf-8?B?QnBQUW52aFM3ekx2dUdaaG9zbzZpU3R3UE9NaGJxQkFSMVBlMVQ5YThnM09t?=
 =?utf-8?B?NmtqWERUYUh0cVZTdU42ZlJvK293TDYwdXR3OFE4N1pDNHgzcmRYMkFLVlJs?=
 =?utf-8?B?SmpFeHlLZDFPZXdkRzBtTWR3bE5TK3Y1d3V1d3QzY1JRa3Q5bU9hR0ZiZ3Rz?=
 =?utf-8?B?SDFLSWl4UWxzMmlVQjNMeis1WXdJTS9yVTY0bUd3azVMZDZOSTZFcFpZQVhn?=
 =?utf-8?B?R29nMm1OWEhFYlMyY2tJV1BMaC9peEhMVFdNcTIxamppdEdZM01EamVrb3Q2?=
 =?utf-8?B?Rk5wZWRLTnVlZUVSNVcwU3hXZmhiYUFwbkJvS0JjbFFEV2dTdk1oTmF6NDJq?=
 =?utf-8?B?NlZrVU9YUlh6OFJKMng4eHMyMkVkWW1rNmNpblIybXljaGhDMmE0Nms1ait4?=
 =?utf-8?B?eFBpcEhkbldHelhoWjBSa09sNU1UYWdxT2VOaWNVeGl3VWcrTVF3TTRRcUR5?=
 =?utf-8?B?emo0cTB0dFV1Rjc2Z056YWYzZFE5YjFYNXFhU1NNUUZ3cXdleHc5VDdiSHpB?=
 =?utf-8?B?dVVvcHgwaENMNFhZTzV3RXdDd0c3RTJhRG50Y3UyT2x4eFI4Q2RPUHcvMXF2?=
 =?utf-8?B?OC9vZGdyd2IvQVQzN0tXcnpqeFFPR3dUcHltL084VFBhZnhIUHBRN0RpcStX?=
 =?utf-8?B?WG9pVW5hUGZYcTNiYTZUam9IQ3NjdlNsOHJCZlU4MVZGMVN6YUs0Uzk1ZlZT?=
 =?utf-8?B?SmI5eEpEUVRyOEcwUVFBZlY0OXVzVnJkTU9LMzFKZTJrdGY2REJvQ3hveEdU?=
 =?utf-8?B?MHNYSWo5RkdOdk9YZnlST09mYUVLZHNoTVdZWS9ralpnYVJHRmVaOFB3cDBp?=
 =?utf-8?B?dURMdmJiWWVUUGxOaUdyNDdpZnBTUVMvM2sxRGIrOG1wTXR0WEpYL0JWNm5D?=
 =?utf-8?B?MXZvWWIyajVoaGwyZUpJVFZFbVpHMWxrRndvVWlnREo4enM5VUEzT09KcVRJ?=
 =?utf-8?B?WGJXSk9CQ1dhTkYvK0p6ZHNPUUZaY0RNaDlGZTNRWmV5bGdNcTlSeW1SanZ3?=
 =?utf-8?B?Rmk2WGR1d3liVzJjUTd4ZHVXVjlRZW5LZlJrN3RHbGVYd2tqVWZ6VW50dVEr?=
 =?utf-8?B?SkF0S0ZoQW9ueldVbGlRbUdDb2ptdkdVNXVtcGZZY1d3d1ltR3NJZnlTWlYx?=
 =?utf-8?B?WVJ2Ynl6LzU0R041aERkMkVRRmVHdVdRTFQ4Rkh5cDJHL3pQMjZPZVhzd0s5?=
 =?utf-8?B?d0VKL1d5eVIzZWtXTWM4M25oMzJqN21mYzN0VTZiYkh5aURVdEtJdWtoY0ZW?=
 =?utf-8?B?Szk0bUNtc3FVSzdJUlE4czZOUm84WXpNUEdwcFU0czY4ZDZCV2NVc2ZBNVhG?=
 =?utf-8?B?VUVyc1J6dmNUMVU2emZnMjFGR09jbnp0R0JIVmduNEN2T3cycmpvOUlDcG9C?=
 =?utf-8?B?djhjTTBEdVBrdXpwNWdSOHYxUTZ4SGExT1pZZXZuZzd4WjVLb0IrRGNiTUVq?=
 =?utf-8?B?UU0wUkIvWmFOVmRYNGxBYXYvekdvaTkvNCtRZXFrVXkyOWtHTFlxT1pQUkx6?=
 =?utf-8?B?eVVLWmJCYVZFcDMxaFozUGtBZW9jK1ZidlJqK0tJQ0I4VmVpZ2IrK1prckVC?=
 =?utf-8?B?eE1RUUtCRHlVWGN0QzViUFB5bjVOYkh5aTNWSktlMXNpdFcwMDlSWEJmR2lE?=
 =?utf-8?B?Q2ZPb2hRZUhXQVk4UlM3Z0FkdXNTY3NiYldGaWlRK1FFQ2pnYnJQL1B3bXJm?=
 =?utf-8?B?ZTBMWHN5MHBTbTRZVm14UWU0MXR6Vm4rZGZRekhqUUFLVkJWTlhjS1BJRGti?=
 =?utf-8?Q?hyCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRXdnVoRkdlSGJ2Y2pqVzloQTZsL0lpazNDTEhYT0l4SWQ1MG92VGZoRE5M?=
 =?utf-8?B?elBDVTc2dGlxOUtiYVg0dG1rZE9taWNhQlMwbkY3WG56VzBwcEFSTnh1NVRS?=
 =?utf-8?B?dy93elJEOUdoNlBYeUpXWTZQc2JXMDlIWEtaWkJmTUNIZkpVZmh3L0RsYVdt?=
 =?utf-8?B?Yy96Y1FmSGN5SVJmVVViSG1jUjR2dnlFTUlxRlZ4dmNlYzdpbHlZbjJtMkRE?=
 =?utf-8?B?OGZjMHZtYUJ5emRZL3NjWTJ0dzBTYzZ3bms1T0ZMc3l4OEphQkVaNVYzVjhj?=
 =?utf-8?B?SmVHWENZRFJBSU9JZU1zbXJSS1BVL09ORStvR2hzY1JhdGRTVUg5ME5tbkJJ?=
 =?utf-8?B?TjY0S3pGa0pjNm04YXkrOUFIcnN4bkRnOEhlOTVITlV5R2pUcVYwMXIzc2o4?=
 =?utf-8?B?UjNDOXZKZ3g0dis4VGoxNGkzNmxnLzZCUmFBcWhhaWxFbzkxTFRESzREUlQ5?=
 =?utf-8?B?ZEwyWXhtb0M4WEJsUkJEOFRWblFVRmV3Q3REUWsxRFBLNXBWamRoYkNDb2I1?=
 =?utf-8?B?SzNLUVFJQ214V2U4VG1qRXdtbG03Y3k4cjU3aDczTS8rak10S2M0V29GY01E?=
 =?utf-8?B?b3JIc3pSMFhWclVmOERsT0NTRkNEUmluNEZ2MGdydzlGakVIcGtqWGp6YnRu?=
 =?utf-8?B?U3NlR2w3UDVqaHBzblp4ZHI5NGxZNlQ3S3pYQTg5Q2piKyt1dlFFNFdadzRP?=
 =?utf-8?B?U0xLdCt3RmdwaTFIQ3ZpaGdydEt1YTI5YzhkTnNXY3BiazVWYVRQS1J0a2xS?=
 =?utf-8?B?WGg1Vk1VaGcweWtzQW1TeXIrKy83NjVxS0JCUTBTT1VZcXZtVWdsNVNGeHhS?=
 =?utf-8?B?QmVCNS92OC8yVUpWOEQzY0QrTElYTDFvYnVFWU9DTVNSOEdhcG5jRDk4UUxR?=
 =?utf-8?B?QjBLNHhPblBJWmU3ZDNONlhXaXVMUkRkM2M5YkxEWG9MZmxRT0FLVGtoMlNR?=
 =?utf-8?B?SnE4R3Y5QXNYRDJOWUhXaG5ndkQ5Y3pUbnp0TGJ3a2xCMXBHUEp4MDlmT2U2?=
 =?utf-8?B?MUh0bGpYN3pRRXdLbUhVNWQ1ZFJZcU1kVWIvRWpEVFdacGc1NUdTV3pMQUpF?=
 =?utf-8?B?VW9DTC80czhPSUMzZCsxaUhwTlVXYkF5NFRDS1pSeWxaMXpKY3kyNHZ6bytx?=
 =?utf-8?B?SGlMd1REeVM3LzVMcjJmbmt2TGtpcFhRZVdMRUF0SFZHcUpmOWxGdTlYRk84?=
 =?utf-8?B?NUJIUjFEd0xrZ0pmY1RpWkFJSUp0cldYWUpVOHIwQXVpVGxRU3lrSmk3UExV?=
 =?utf-8?B?MVo5WlVlSVB0bk9vVjVZWjNXUjhQSitzZENVSTdmWmQ2YjFPenltKzFkWXZY?=
 =?utf-8?B?aXhXd0MzSnpGT0hZSEtuK21abjZ2Szc0aXNjaEZHUGRzZ0VMSHVSeDZ6cXdM?=
 =?utf-8?B?ZldyMjREUUdQZThHdlMrRUFzcFZvR2FjTnZYaUF6QWhCL1NPU29zd3VrZVhi?=
 =?utf-8?B?WExuVlRpNC9mRm9JK1dXTEwzeFFWVnl3cGtGZFc4dEhCQkk1VGZjNEs2VnZB?=
 =?utf-8?B?RlYzZCtudjV0RDBmYUs3dmdtck1ZcWVlcTUrMGpLNkZrOXkwTkFlak9MRU9w?=
 =?utf-8?B?T3lGTW9JNTlXNWRvYUJ1cE9rRXl3SjQ2K2xvUkQ2VjgrVllyQnk5NEtmT1VU?=
 =?utf-8?B?TTdPVW1uNWd1RUZxK1FyNVAzSVc1RVFrRTJNRXF3VFI4by9HOFFqZjNvbzlI?=
 =?utf-8?B?MmhYU0lJV2t4M3grdmV0MVdpNDRuRXF1RGJpalAzYmJlRUxwMkxNTUxlbFZY?=
 =?utf-8?B?VnlaSXpGNVVYWEd6aDkvbFgzd2t1K3dGNm1GZGs3OTdpejI0WTJkMjhJcVh0?=
 =?utf-8?B?cjdpNzZ3V2JCdDBjTFE1R3gvY1J6UkxyTXYzeEVLRkR1Qm03RXZuZ3dvb0Zl?=
 =?utf-8?B?akgvYWgvTG5kRGVpRmo3NHB4ZTF5OXcxcmdZZldMZ3FubWNOZFNDVEl4OEVj?=
 =?utf-8?B?Wk1nUHZFWE5NcW5XVUYwR3pwRENvb3NNNGZ5U253bTlEaWZLb3JJQWxhVDh6?=
 =?utf-8?B?S2h1bFB1T2gyWE9zVFhudFhVUGJlWFE1ZVJ4emVvcUl4OXdlaHRjaDF3VFpt?=
 =?utf-8?B?NlY2MisxY2xCSGt3cjB2TXgveHdra1JFL1VQS2xUNXFFRUFvbms0MWZqYm4z?=
 =?utf-8?B?YW1FcTBmeFZheG5OREk1enFhTk9FUDNaLzY1em0zRUtRTGMwZG1aRXg2ZDI2?=
 =?utf-8?B?eldMUlJMQ29Ld3VPRFFrbC9sWHdDZzdlRldYMlowU2JiUjZyZWlmcXZLMnEw?=
 =?utf-8?B?Z3hvVTRSQXdZY0NaWDFUUi9tdnhRM0hrcStjUHZMNTRZT0pDZFBTcEhOMkta?=
 =?utf-8?Q?PRHpccdxuX+2IDbDop?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5a5b6a-3a22-445f-dc7d-08de59b55249
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:54:03.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHmrxyWEJcCSC1/LxjEIeRPrkOjEEDxEX1sGVtB9OLSUfV0F3m+JHmUqTXpx1GxL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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

On 1/22/26 10:37, Tiezhu Yang wrote:
> On 2026/1/19 下午6:45, Christian König wrote:
>> On 1/19/26 09:53, Tiezhu Yang wrote:
>>> On 2026/1/16 下午6:03, Christian König wrote:
>>>> On 1/16/26 02:20, Tiezhu Yang wrote:
>>>>> On 2026/1/15 下午9:47, Christian König wrote:
>>>>>> On 1/15/26 02:28, Tiezhu Yang wrote:
>>>>>>> Currently, there are many Call Traces when booting kernel on LoongArch,
>>>>>>> here are the trimmed kernel log messages:
>>>>>>>
>>>>>>>      amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
>>>>>>>      amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
>>>>>>>      amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
>>>>>>>      amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
>>>>>>>      ------------[ cut here ]------------
>>>>>>>      WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
>>>>>>>      ...
>>>>>>>      Call Trace:
>>>
>>> ...
>>>
>>>> The warning can basically only be triggered by two conditions:
>>>> 1. A fatal problem while loading the driver and the error handling is not 100% clean.
>>>> 2. A driver coding error.
>>>>
>>>> And we really need to catch all of those, so there is no real rational to limit the warning.
>>>>
>>>> I mean when you run into any of those they should potentially be fixed at some point.
>>>
>>> I did the following change and it can fix the problem, given that I am
>>> not familiar with amdgpu driver, could you please check it? If it is OK,
>>> I will send a formal patch later.
>>>
>>> ----->8-----
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index 8112ffc85995..ac19565e7c45 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -138,6 +138,9 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>>>                          if (!src || !src->funcs->set || !src->num_types)
>>>                                  continue;
>>>
>>> +                       kfree(src->enabled_types);
>>> +                       src->enabled_types = NULL;
>>> +
>>
>> Mhm, I need to double check that but that looks like not such a bad idea of hand.
> 
> Please let me know whether the above change is OK, if yes I will send a
> patch ASAP before the coming merge window.

Well, this has absolutely lowest priority. So don't expect anything in the near term.

Christian.

> 
> Thanks,
> Tiezhu
> 

