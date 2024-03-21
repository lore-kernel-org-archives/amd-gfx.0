Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523DFC54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 17:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A144210F1A8;
	Thu, 21 Mar 2024 17:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qtxp4gAU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3697210F1A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 17:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcDj9UvANuKNEd7Yl0bm442LIzA7g5ITRZMIE1Mfo5lFoN39bn4rDsnFOLLw6IOJ5fVSN0Y3ry4mUOjMc0FrQXrOXn23MSkBJ7jYRm3bN54/iLWp+q4fOWUkbjvdWLW8nERm1jJ3Y5oufxk/8saEwH6dxhoCb9OVK/ktgFn7Q1c1XQ9C9HcQYenkti2fYnTIBnUHwQt0bwRSKgCsKsMvxwKpFGIPjeaubsYzkzIvIDD5x7Ub1R+hdDbkuG3wkZZtfT5Kx4LuAfBbtSP8fUGGc9pE9qSmjmgr0KVywCf6jYebny69EJc1W7g4hjZC18XWpLBlJIP7og/eQ4y68eL/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Quu4B8udR0f/Gsagx4dbqxpzsTC43ezM09JQ6r9AdIk=;
 b=DuFian2ZKlJIp/aS2Fzn9ddDU5fpuxT8JoZRG6w38tpVLs+buJ9v0cb0Jzl4RzQylr6PHlp+rulkR45yfZeALB9k/2J2Cm3ZjCpmb0DFD6DSLtjfeot1e/g8FI6iMA1EB6MkMGfDCMoJifNh9ZBOzYblAeP2pPkU4g0Q2rmq6rbl/hDw5ZHjwt3y1w+AlCl8a7QRwU+N/XakdoP9SKbFDj7ofQYmBPyBOu/DxqgPUsSLA6DgWml/TEZgfjb5Hw5Qk0v4OHpdCY1eLFcthTDRWLWZSFjTqqa0pwZ7ETES9lhol1qXySDBlUBFJd2FO3KwRhaAjM2RvgQqS6rxUgq9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Quu4B8udR0f/Gsagx4dbqxpzsTC43ezM09JQ6r9AdIk=;
 b=Qtxp4gAUPh2/B7YfopOkKZIkAvNeCTtKjhex4f1atJE3iDC2FmXb/cWJzDcG8p0XGRg+n8M1OjSafYWYGp+HgQRUdXdbLIaZtGimNjGvFRVehF1FU3FE6S1Af/q1Yo7McCttBF1wwvG1vhe8HDjpXnijVq53YwdA5p0IRv+uiyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 17:01:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 17:01:59 +0000
Message-ID: <e23a0e94-f31e-4711-ad3b-93caca180286@amd.com>
Date: Thu, 21 Mar 2024 13:01:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Cleanup workqueue during module unload
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240320225248.754671-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240320225248.754671-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0056.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9494df-bf6a-4017-27dd-08dc49c89f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GS6++T/Lt18EMxg0oA4seLuWwt18NVImEYb3+7qnEHvnbfJePa2GCOvkmx0/EQx9XVoN5qFOvrs9HkbcBuO98x0NYzyVuhqXpXAR7FSzpi7s5ZxlYkhz/U4skHJly5ksOnXkmeMp0a+XiQZFsbM4r9hDLP98JODp1HDfJvWYAriQ6I7qkHUQm3nx5Pw+ZhwM5ewPTdx/cwtRUdvzr+vBG50MsgTB9SC0CNYXfHL3dqI+C2DGYgpLKPeAAcQv6B+rxeRipJ2OkfK9DNv4Sg4FZhJIMqonth+vc3N/hmos0vatrx+086Z0MKdThOteuh31yBtaj1itmO9e70PVZh4fTLX1hJO8fTSRd2E/6nVzkAA7ZhV1GTX/tv/6nGr7WXx8bz8XE1qBT8eWhPHBnFRgv22YW8yz2Mxq8gQxiyU2C99pS+33mro1QYkwo2JUdpZk3FKkwPOydA7WtfqKP8AjIpnrWZNlJTdT4VnAAzgc1ERpMJgccnywvRktpW018BUm3PtvUSGDfto++XPPL77xgvaPgvggE5ezIbzElOsGbmME4uDIoXuz4VlQG+MG8iWJxY4uTpR2TaNZrVnD/Btd/INBNb4SDQ1yFYSAN+jbzeTi3EVeNy+TP3r0i42h9YZIUh3xtliDK6/CNA+aTiCUHd3H1xjp6O2VR0gc4QHXUoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9CREEweUczNkRkalArYUJnMTJuTUdQNm4ya2d6ZUhzb2w2OHM1Q1h6bktv?=
 =?utf-8?B?ZDIzZCtkS3NiVzBjS1ZEVDhhUHRMWVRsNW1uRkhVVVdlbFRUZ2VjQldBbGd3?=
 =?utf-8?B?dnVGcmkrM3E1Umd3TDliU25WRXdWdVpzejE3K2hCZGhXUHh5VklQSjBkUkcz?=
 =?utf-8?B?NlNzTzVwamE1cllrLzVIOWp4Nm0za25VdS9RSm9vSEVSb01JRzNmNUthZk9y?=
 =?utf-8?B?a2UrWVdXMUFkTEZ1LzcxQ1VvT0tPVzZVb2hMbHZ2MWZ2QWhGR1FFSjJYRDlL?=
 =?utf-8?B?TnVrQXhjcVhxRURPYStXVmg2ZEtFZWNwSmo0UXZnZVdKL2Zhcno5NktZM0Nx?=
 =?utf-8?B?Uk8vNXFSYkdjN1pKbHVEN3VJeFozYTBsaWEwZTI2ckVvaXE2MTBPbkhqeUc3?=
 =?utf-8?B?Ykd6RE1GUlYvUWxBRllzRDZOTk9obkZUWjFyc3VpM3M1NkQrNWlGM01hSGY3?=
 =?utf-8?B?UTNlRXF2SXZ2L2VXSXFocXBxREVFdXVlOHR1OHAwL2tmSmRhNDBxZXlid2FH?=
 =?utf-8?B?M3VKZ3pTZDBhNUpwVk9pVURjdFltWVV3RjI1cXZjcjA3dmV0YlhMTmVqdWFs?=
 =?utf-8?B?TlkrbjhNdnhtSlZSRXlZWmswZCttY0RDenBUZmNKcFNEbmliVEFtSGxMZ0lh?=
 =?utf-8?B?WnA1REg2QUg2dzhrKzFnbjBsakJQNWpJWGg5NFlPcU5Mb1NEZTUrbFNZem1E?=
 =?utf-8?B?QVRKUUJBb3hJcUljYnR4cEFNUGwzTG5DaCtKSHlvYTdhYUtzWVkrOUJCa2hz?=
 =?utf-8?B?WmZiNHRRakdUS1Z2R1QrN0lVWW90TU9UWXhXZGZsU3ZtV241bVVSQzNLVFlt?=
 =?utf-8?B?UVNIc3VLWUlQUmE3eEd2MUdPZTMrZ2w3dXVFNXlwd3Zqbk1xNjFSWStVdDIv?=
 =?utf-8?B?R09qUmJycHdjcFRoMUhRcFBHWXBKbkJqQzcrRWN0dHk3MGFVbzMzOFMraC9X?=
 =?utf-8?B?c1MzcVRGa2RIekd3alY0THlKUkVGQ0pKeDRlS3RMSkRVdlpPMGhpQlIxZFNs?=
 =?utf-8?B?N0ZTR1FGNFdmNS9wTkMyclZlUFJFRmZqb045Q0ZpYjQ4UUIya1BwNVVERzVn?=
 =?utf-8?B?ZC9YNEY2Rjhsc2gyN3NvTEVLQm96ZFNzNmgvbUd0UGE5bUVlV3M0V2dSQXRm?=
 =?utf-8?B?ZlRNVjdrYmpob2ttbHkxQmlhR1FxMThjaCswZndYQnZEa3VtdFg0eFhBYWtm?=
 =?utf-8?B?RUdTbWdYRmpLU0hQWm8rTzNwL01IYUtFM1FackFRK05kU1RqWUpTZEYxTFFp?=
 =?utf-8?B?SjlKeFpCK2lwT2tKQTIvN2NSNVVBTllNTnBRMW1aZDVyUUxJbUNnQVVxdElv?=
 =?utf-8?B?ZG9WV3FBTXd2TFhlcm1TMGI3T1BHU0hDMG1hT2drMnBXaTlSZXlGbHZIbmsw?=
 =?utf-8?B?UitsOTFMR016b2NQcmZDZHQzb1VGS1JRdE1iVlBZQk1xdTBDcmdxS1VOUXZR?=
 =?utf-8?B?NEFoTk9RdklYVU1hdHRRTG1aTEhOMlN2OFlUWDhEeUhJMTBkZWRRTUs1MWk2?=
 =?utf-8?B?bHVtUjVDa1BoOXgrYTIwaVhZUlJYczJ2cC9VVWxESlMzYjJKbFl2aWsxUjMw?=
 =?utf-8?B?a1lwTW52WVFMMTJKSStUMktXMjJhMTlHaTVuazlna2U3djIvYkVHYkpWbVVX?=
 =?utf-8?B?N3JJUElhVytlN3ZTY0NHMGZRY2s1VEpCL0dtSVpUM1Jvc2Y1TjBLNUhOSVNE?=
 =?utf-8?B?RTl5cXA5TXE4TE5MSWs3em5YUzdZMlB1V1I1Q0pDVkVPL0dpMm9oMlBlWEFl?=
 =?utf-8?B?ME01SVJzYTl0YjdpWk1TN3l6SjhNZjJKNUUwcElaN0FTbWpZbUtZSXFSSnFw?=
 =?utf-8?B?K00xSlpmS2hRa1Qvc0t3WU9DMFozY1BGNEVVZVJndC9YcWVHZHJNZ0VpL1JE?=
 =?utf-8?B?ZVpLREltanVxZWRibElicUhYMU1QbllMeVNVdVp3ZE4rRHA4RGNnYnJBTXdr?=
 =?utf-8?B?S0p5RG1URWJVaksxRjV6bUliWlRiYTZtR3BocUVCeGNxTVpyaDh6M0pzaEpO?=
 =?utf-8?B?bjZlWTZ0N09GNXpPWUlORGlsVVFZYXgzUGRIa3IxRTdtY2JUWHZRcEdPNDZJ?=
 =?utf-8?B?QTQ4UzQ1ejJGa1AwcStNR0lQVnc2NHd1Rm51QjNxU0FjeUsrUWpGMUJKUit5?=
 =?utf-8?Q?f8PDBnlPAo1+h0tIxz9qzqNNe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9494df-bf6a-4017-27dd-08dc49c89f5c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 17:01:59.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nca4iv5Lcvn6AnC15L+/QJ/1HxxU9odxvA4//gIoMB+iEupbR2EyaMdWf+GY5VgDQ0rzddcie1HhfovIQA5GnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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


On 2024-03-20 18:52, Mukul Joshi wrote:
> Destroy the high priority workqueue that handles interrupts
> during KFD node cleanup.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index dd3c43c1ad70..9b6b6e882593 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -104,6 +104,8 @@ void kfd_interrupt_exit(struct kfd_node *node)
>   	 */
>   	flush_workqueue(node->ih_wq);
>   
> +	destroy_workqueue(node->ih_wq);
> +
>   	kfifo_free(&node->ih_fifo);
>   }
>   
