Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BC1C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 05:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0673910E73B;
	Thu,  1 Aug 2024 05:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGAL4vg+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E488D10E73B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 05:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPyV+dUj5SyyGMNzYo1M8PXOATo2tvaCqXpjU/TKSfX5QEMyhBn3Kej/37Ps1qUJEMIBmUATsUDZ1fq+AVeCBY6Nm+6pm9qnbYlppnB89f/zPIfN3iUmxspw0bx5WAfhCLSsw4I8AcHIxYoFCXzvbXzq8pgVx3meV9kfEJR8mF5HujRf2DNfq9qBCE6QGmCg0JlcDJlHr1LYn4IG33LMdZy1j0mZoJtyp1zkYvTfwk2afBwf8SWsYK2kw5hZmpetF5iYu0G8r9V4kWlvM8hQ+WEo9aT5TAxJ3aq1b/5wia1vA7I4v8OtKIm7bWxRl6Twy2BHltGZVrpAbHoq7qQGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njeUi1MDDr9Si3XIv8LYMT4F830cU3oKQGrGXbzFDzo=;
 b=s0YaRe8EIEkcFUKnds8eztRRsKyF8CG1V+pl0l6ESiVXqjXmUwyQ+VJCG3pEg5/OZopuDT+VqxfVhlYQu9Sy6fQNw/lMPuVBY4f4VmB09/uSnXrq2jQvuZnCwLR8ETSA7/X4SVx/SiRgdd7cO1LZyX/rBbbuD4I7t0bgmeo5QlauXT5m2w0craFErdUoKi/2Lqn4cHKBLCGxZu7Imj9BuCX3tsf89e4JfGJWpKYF5BVu8v/rbqCyda87rGroS7fB5M9FxPcwTG1Xnm2VHDaiqpLJABNfTpe196zGE+z8BbKBbFLSWYD5aQu2Fiu/KcIx0wjAhEvNXf8AiDdogdaFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njeUi1MDDr9Si3XIv8LYMT4F830cU3oKQGrGXbzFDzo=;
 b=eGAL4vg+sTwVVSe3VCRqecHQB9RJ6V+dULmeAPpjO83wciH+woGntkjxc50AVO2tGrsMxewuhruRC7b0igNcRYYuts/fcbaSoygRDv6vSnkKmuuO7gBco/Attexzt1JP7HYfdabWpbcBFpIAQEtAgMJERriFx7U3aKLhK+84tyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 05:23:13 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 05:23:13 +0000
Message-ID: <41947a26-1cdd-43ce-b5a9-fc9336dc17bb@amd.com>
Date: Thu, 1 Aug 2024 13:23:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Add NULL check for function pointer
 in dcn401_set_output_transfer_func
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
 <20240731075733.1025866-3-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240731075733.1025866-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: c0496b6f-6084-41e0-a80b-08dcb1ea0a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1Y5ZWZreC9POC9PNjk5cktyUTIyZVoybkM1RllKVVZXUUx3Rm5FbEd2Nktn?=
 =?utf-8?B?c0VjNFNxYVQwZUhXYTBOSzJJcUkvYlRadjMwanJhcFVwTjNxdmxFeGVLSXps?=
 =?utf-8?B?SXBxZWV4TXV4dXNJRVpHaC9ScEpkNkhCclJ2eVZrUEF0WGRtY0I1a0UzV25x?=
 =?utf-8?B?UGo4OTRoWWZYVFJhZE92TXA1aExxTnFLc04zajE3ZldCUnBRM25lUThLZzl3?=
 =?utf-8?B?b2RqeldWbWozMUVhR29hTjdYYVZ6YUtzVDMyM2NUTUFNYWxySGM4R21wbG5r?=
 =?utf-8?B?TXN5eldHK3Z3dWlZSHBVT3ZqbFRTdDdmeWFSOEVyYUFsbFJRd0NiRWhpY0c5?=
 =?utf-8?B?Q3ZyaFdFV0l2QXpUVG8xYzUrK2hpUUU2d0Nia1QrMmQ0UmNaTTkzb2pQMWRt?=
 =?utf-8?B?dzNOZXMwcWdFa0JVdG1zOUlaOTQwanlIbnpTSTgrckVoSUk0amU4QTR0aTBz?=
 =?utf-8?B?Ymk4UG5NWVpEZ3lPTlpPaElSUUxaOWtVMnh4UmZPaEEyWW50TkVGZk9aVldw?=
 =?utf-8?B?elI3cWlmQnl5ODhlaHVUS1NqV0YxYkpmbTFrMmc1WVJQZys0VytIZjZGcHlB?=
 =?utf-8?B?S2sydHpJbW1TMklPbzM4UGlxcmNhU0JrajVNZUFDaDlHWG9CbmdFbnQxTmov?=
 =?utf-8?B?aFpybDNObFlZSUJ6cjVxUnE0bUhWWTNjK1FKclExMERBTUJYdTBuSTF0dEhw?=
 =?utf-8?B?aGRiV3Fia3U0TlYzTlFrdnB3ajlmMXJPWXozaGc1cXQ4dnZjRi9Oajc2ZXpW?=
 =?utf-8?B?Ky9oV1p4emMxSW9jZFBhUE5XTWQyZzhRNHZHbFlhekd0UnRqSlpsMUc0OFBP?=
 =?utf-8?B?Q2RweHBrNDVXVmdCamdBeFYyUUtKTy9EWHcvZWNoWm5CdG9uRjdtU2ViWDVG?=
 =?utf-8?B?QUhpV05RSGZZc002NkR4a0RWd25DbDBCSFhWMUFyYXZZN0pkbkJ5UU5CM1VM?=
 =?utf-8?B?QU5idU9OOWpLYXdkTm1rdzFnWGtiUFN5eE5BaXJxTkdwSUlnZmRDRUFHekd1?=
 =?utf-8?B?V3gycnV3KzdaazR0aGw2RVYySENrNHl4NzJKZUdCNVBuRjg4REcyUDVqRnNO?=
 =?utf-8?B?a2tXc0JjRTVXc0djamlta0dzUEd6SllXdWY1NzN6R3dNaExEcDhRVEIrL1JO?=
 =?utf-8?B?YUMrd0FSMVRMYjVEN2lxWDhoeCtITncremFTNlplQzBGeU1jR0J5MHMyRjFr?=
 =?utf-8?B?UWN1Q1J0eWVPTFZQSURicWhNaFNXcm15K2RmSU9GN204QTg3MUovTXFmZEhr?=
 =?utf-8?B?NDI3NGFZRmtJcXFTblV6WFVRdHFrV0p6a0N1dTdIRXNFampiZE9MVk1IT2hQ?=
 =?utf-8?B?WEQ2TlVDY2FwYlpxM2xVN0lpRUVZeC90KzVUOHBKUTNHVVBGRGxlc1RMOXNz?=
 =?utf-8?B?OHFIekQ1N1RiZHVoS1FQb1VCa2JUSzdIRjJOYWFvdjBDNEFXWjU5aUJIa2E0?=
 =?utf-8?B?cFRFL0xIaGl5TzRQNFB4L2NaZkZmcEFSM0ZQYzIzS2RQRFpQSUVPUU5uR0Ir?=
 =?utf-8?B?WjBsSWp5RmtsVG4wMXY4TTFvZ1dteENNNmN3S2pPNTV0MGpMQzVXNHBINzdO?=
 =?utf-8?B?YnNvaTM1eG9KMzZ4NG9ONWxlSG4yUnU0TlMzanp6RnQ1aXdmeFpvNDFXNVRp?=
 =?utf-8?B?RmVWOEZNSzNQRWxOQnVkRit6SXBOYUMvc1E1RFpRZkhNb2tHV281dzhsQ2Jh?=
 =?utf-8?B?ZEYycFlTNlhiK3EyUklVWlpuYjE4ZU9lb3ZFMFZwcHV6RHJFRkE0WThRKzha?=
 =?utf-8?B?a295YmY5UjNZQi91OUF5bTlTdmNEUEM3blFTVnhpSnMzUC9Ib29USjNoaG1I?=
 =?utf-8?B?R1lXNTFYV2FJKzhFckU0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MThoMlNKSXdFZVVCc3hLSWV2ZElidFJMTE9nSFg2K1pScHJJbGpvdlovMlg3?=
 =?utf-8?B?MkY1a3ArM3BQcEkwWEJKZlVJSXVoYU1QL2lXOHdKam1SbnYyVWRqTjRYL29V?=
 =?utf-8?B?SGVEaEI5OGN3elp5N2hDaFU4T0U5bk5aNXc5SEQzVjZzN0lMWFhRTkpudDht?=
 =?utf-8?B?L1EwdC84Q1JMNVYrcFFkcEtCaUIzYVFLZnBUVHU2cEFFN0RzU2hYMkxlUm1r?=
 =?utf-8?B?Qll6cGovNEhEbEEwbXZqdXI0ZE1aaFdUUXpzdktISERvSXpzcVhoM1FsT2cr?=
 =?utf-8?B?cFRLR1kwS3VydWVIYmJKVkpEU3R0a2hRT1NWVUYyOXdMUHNyTndjdWxuL2FH?=
 =?utf-8?B?SEdIbnBLT1dIYzBZVTNNRm02b0NQTGQ0Q1ZBSmJRbG9qdTVjR1JPUUJFZEZP?=
 =?utf-8?B?MlQyU29NTVdMNHB1N3F3bDN3S1BHQzc3Z1A4alRoQzhGSGVObEJPcEZSc0ZQ?=
 =?utf-8?B?Z2ppNUZIMmJ6R0NUTTVJWERoenhCa1dGekRkQ0xFM1NtTXVwb1AvdVFVTnZY?=
 =?utf-8?B?bERaQ1czb21zZVk3akRhNnhmREtqYU9DSm9Yc3lTNG9ZK0JHZ2x3WHB1VHZC?=
 =?utf-8?B?RUdOczVtdzhveElhTWdidExkcWxRZjcwVW92blJhdnFNaDNVNE5iRndPWC9H?=
 =?utf-8?B?a0FXTlkyL1NZSzFaYU5ZREx6Qm12ZE5hYmtKbld4YnJSd1g5Ym9wSGxVaWdB?=
 =?utf-8?B?cThXUVE5cmRLdjFJZll4UWVlTEZVV295YzVBaVJUV21IYTViUEkvZi9XeFZE?=
 =?utf-8?B?SE4ybkI3VUVYdXpIQTRzL3YxclNZN2dyS3VEUkNJbzlaeEt5R0pUZ2hRRmpG?=
 =?utf-8?B?ajQzR21uMnlkaDNDVlpYU3docll0cVYzR2dmWXRWNU9TM2JiblBQaTFhVHVD?=
 =?utf-8?B?UjQ3ckUwYUdnZGNpZzU3Tjk2WnJmRTV5WG5MZU9tdEFyeFo3RE1yTm9tM3Fn?=
 =?utf-8?B?U045R3ZsSUU0WXJaMlVVYytiUW5Zbmx4QUhVbmh2WW8zSkxmR2hlbEJiTHEy?=
 =?utf-8?B?YzY3R3NYemxReE5DNXc1SWlJRWlnZVJuMXg0Y1VEUDVtT3l4Z3A3WFA0Wk12?=
 =?utf-8?B?LzZxTzQrMWJPMHZURkJ3RWxKYTNPbDU1VDBvL25UdTNSSUdjd3NXd1FyVVNQ?=
 =?utf-8?B?dDdKbVFoUmJuR05YZ2NiRnVGUEJwZzJlQThraFVURzVEZzBuV3JqRmlPOVJW?=
 =?utf-8?B?M3VJN1lvZmlzeVp3bWFkbTJWMzNsUENFeFd2RVNZUmRabGZRWlRSclJicXli?=
 =?utf-8?B?QktnbXZtb0tYWXpWcW85dGg5Q2M4NndHY3BxWlRKeXMwWmI4aHM1MC84cGp5?=
 =?utf-8?B?WEZYZTZoV3JkTS82ejk0M3M0VFZ6WDZGTlE4Uk5ZWmI0ejR3VjhpTjVNVkpz?=
 =?utf-8?B?WUR4WW1hZ2EzLythWThoV09RZzhRRm8zWUJZUkRIMEV3VnJFdDQ4aFN1Qm90?=
 =?utf-8?B?dXh3VnR6cXlvVEZDRkgwT0VKWXhpMU1WdEhrTXo1RDlEeTg5Y081VkwzWUNB?=
 =?utf-8?B?OHlzRmoxSXV3MVZYRTBmd3RXN1ZieGNzQXF2YlorU0Q4RGs5VGJtUFN6Q1Aw?=
 =?utf-8?B?UnhPaXAxM3FtamkzS21iWkdLUkUwTHlsRmdhQjdoYkdkSHQycDBiZjR5MzI4?=
 =?utf-8?B?dStNZTN1QjhENFZvUXZ0YmMyaXU4blM3YjZRYWNzRE0yNzl5QWlsQ2cxbi9N?=
 =?utf-8?B?MnFaS0pESHpNSkN0TTFIQzFpSzZHYnlmNzRmV0dKRzhOUUQ2MWhlVGNoNTl4?=
 =?utf-8?B?NWU5VU13UndodFg0Q1c1SXV0T3I0dThKazl0azdIaDZQNGhjb0lLdEMzQnpY?=
 =?utf-8?B?dzFuQXhYN1ViU1ZjVzlBSFIzTGFxNC91UFEzYnp4cng0YU9xRGJ1ZUIrWnpG?=
 =?utf-8?B?dU1jbXZSUDFyMitKT3VPWncyVzh3S2pYcTRmNkZYb3hmeW1KZmhmZzJLOWxR?=
 =?utf-8?B?cmNWUkM4SDNyK3ZRalBoNVBDZHBzZVNZVzVPNzJpcTlGUE9JZFBMU1l2T05D?=
 =?utf-8?B?YzBMYzRCMXVJSFpHTnRLbGVoRjNhWTM0aUpjQlc3Zi9PUnRoSktJRjZvMW1F?=
 =?utf-8?B?UzIvWDZjZEpzb2dBemJnbjNGdGZtdzJvS2MvT014ZjlobzVac3BJYm5MUStK?=
 =?utf-8?Q?JZ0I/f4D/yPOQ9QU+JNbbKhP0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0496b6f-6084-41e0-a80b-08dcb1ea0a38
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 05:23:13.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0xLGh19ppUpPklv+qmMIq8IElm59jqx92k3eJVSptXQ2Oh4l+TcQLOoI+eswEhTmVnUN3uSBhWRvcNAx9y0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/31/2024 3:57 PM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the set_output_gamma function pointer
> in the dcn401_set_output_transfer_func function. Previously,
> set_output_gamma was being checked for null, but then it was being
> dereferenced without any null check. This could lead to a null pointer
> dereference if set_output_gamma is null.
>
> To fix this, we now ensure that set_output_gamma is not null before
> dereferencing it. We do this by adding a null check for set_output_gamma
> before the call to set_output_gamma.
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> index ceaaa8df3641..77489bbcda02 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> @@ -743,7 +743,9 @@ bool dcn401_set_output_transfer_func(struct dc *dc,
>   		}
>   	}
>   
> -	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	if (mpc->funcs->set_output_gamma)
> +		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +
>   	return ret;
>   }
>   
