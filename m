Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B941C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176FF60E8B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 176FF60E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88A189DCF;
	Tue, 12 Oct 2021 14:34:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD1A6E9A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7MlwxnQRk0Z//7gisLK4nIjVuQmESRCEunnCPVMQww5RWDJ6xhLLCThK+qswGUS1R/yQ6EARbmX92Aid+Bijp6kjVMFaHZ4q0pNGY1EaFVzfmfU69zLLLnXwHIptQD8pROVf/wqwRULYXnBNl1XpMiuYlRmI+cNXp8CLKh6D5YSobCxK7tgsXgItBAl5pYJAQX1/GapG0skGRiH7QoU8febXsk11sX8gMEfiJjWYxJcZ2JrV0U5aO2tCPhp1dyuYulhi8mQMJWBttGR4UF85etYTs7lyynBPGfHP4IrxfoT5ofoFv8e5Gp6Izs7biNEGCONfKYAgetGIQaX97BoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eInzKZAEfA3cBRq8u+l9bJ1ht3zM9+8BgD9CRBIX0s=;
 b=S8j4mRmZ6IAKikoByv6dl9oiEYzOTrEMvJNIx7aUsRQU1aws1jXr+hLgZ0k7Ezpc0ED2FuQIZKuE+EZSal1K3ZtcZ6hYqRTcq8Z8YqLVYlpX/8oAkRSbGkgrtlzMRKZQx9uGh7XdRD/WYHnHqvnQ7UC8awxqBAbF3jzPksHx1Z3dijVBMfdOaYOVHjf4+EEZNX04IzVXea0DyjaURjKZfhvrArgWpkQ1SvE7R9gEM7Imy9CDgsgEcg9zSttgOhzewubRMYgVUODcTHSIYZvJf7PTC5iBcBB7+Q9eDfJQvByNbgESpcQyHeeVWQlk72xkrUBbDH42/+6JzyMlGiJWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eInzKZAEfA3cBRq8u+l9bJ1ht3zM9+8BgD9CRBIX0s=;
 b=0CJS9+/X1wXSpSUsjnn+n1RkjvY0zPyULSmqmVOcYLb5hV7fV7jdx7zT0LK07EKG6fWMrErEuJ7ugCkTA4GjgdeLdTQkz1ZQX2ohibWAkvX3DpMD7jILbRCvInU9Ki25tRE7Uz8WXsQzQKRz+EWWJBL3sCGtfR9L9/d9+rBFrYE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 14:34:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 14:34:54 +0000
Message-ID: <9149508b-9203-e5c5-373a-4ddbf5aefbc7@amd.com>
Date: Tue, 12 Oct 2021 10:34:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] drm/amd/display: fix null pointer deref when plugging in
 display
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211012132642.246950-1-aurabindo.pillai@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211012132642.246950-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 14:34:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb3b2aa-ceae-459b-c71c-08d98d8d74d9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5425BB5512E68DB583C44DB48CB69@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dn9Qz8RztWVSijmwugzPuahHwN62ovZal8qzHkMCYEQFpjQMPQS8Boa6Ym2WEjXGDHbNdErR1QqPI9Zt7iHAapyuqy9cv3XDrsBxbtUA/Nxy2MHSmZYuHJ7Ha5tLYFShfYd1MVsk8n/8NUJqG5pJE6Dg15hDY7i23GTWIshw4gecyXUsWUnBSEB2vgYe/JYo0ZC8Nj/H+jbzfdqhJEHMDnq6s2vU9Qazw7aKE5Yzicc44f6P5PJX9zC8auUXMDzjMYFy0tzkEK4qDvDmc4OZ+rZOHcd+PAYpzpgThp0iQcOACz+UdbLolGquz59FAlIy8XuzB77cxGNEJ3IKRGdKQW55jtyzBKBK/D0lrrFxRtK8sJKVunbYgWcpOMzrY+zcyqG4VrTibdZfMOHB7vC1NdClotGFOL6jR2Eo7ri4fEehm1v12GOgi1SzodEDG1v/Yq01dSAuTfzFVqsgrvVzMkPZx4/HY78cdJMWqV1qPT2M/psr677IVrThFyGu3kiuHLehADj2ybcClzDKaI4ZP2GX5269rPI8OYM0cxkE8O8uutEtiKenc95wR6aSy6reP8vEHqEUKS2nnk+N1AP3HpgBsPli3sSwOi7BfJUNwCv+6f2yW0WsMkuOu86mIMsjzLMY6FP93RMJN9wuT3P5SYu+as1rUAHYncIvE0jRIvh0rbrlm6eEVok7gO+kC/jsevx0xvx/tb6dtwbhUIJVzGnqV/ZBhoFJtAqvX6TMfko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(31696002)(8676002)(316002)(16576012)(44832011)(508600001)(2906002)(4001150100001)(956004)(2616005)(38100700002)(26005)(83380400001)(36756003)(186003)(6486002)(66946007)(86362001)(53546011)(31686004)(66476007)(66556008)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRvNXJKanhKM1JxKzZqV082NWRCb3NGOHNneGhiK0lTQmQ1SmlrYTBodys1?=
 =?utf-8?B?OUFKcHgwd0RxTzZsR1l6MnA3bnQyVnZTanQ2MUVNSklHOHZVUHlVc0YwMzB1?=
 =?utf-8?B?MTZVbmYyK3k5ZDg1amRaVW1HbkZtbnArRzU3S2xVMUZ1T25kTFpoUWZTRjN4?=
 =?utf-8?B?b0tMcmsxYXh4cUNSMGxVYnhVemI0WXBtdjJpZG5DNURZdkVwVjMyelNyQkFk?=
 =?utf-8?B?ckV3MzNjRU1vSDlCYS84WUovRm9CSENrWkVMaGNJdDB0SU1WTmhhWVh3eFlK?=
 =?utf-8?B?c1p3Wk9nM1BXUFJIVHJjZlRhcWRWQ0hnbnQzVmFlbCs3NzZYdHZRR3ppdFJ0?=
 =?utf-8?B?eXhoQkhkVWdCSVR6Z1lnZ0llcHpKNFQxUkMrWGlFVGlla1hkV3ZkUXBPYlFa?=
 =?utf-8?B?N05iRWI4ak9OTlg2QmRuS2ZyeEVwZmMxQjJGTEpjVkNIRG5iRGZGMjRXWnJq?=
 =?utf-8?B?TzRxbmNKeHRqUzROTTVBSk83b1ZQZzhyOFJvUExSbUtnclFGUEI1SXZLTG91?=
 =?utf-8?B?bFFSaW9hQUI0ZTUreDJVMkZJYzc5enVCWnRaMjFtTTdmZ0JYeXVUYUkzenE3?=
 =?utf-8?B?ZGhUNndtNVZtU01pUFRHT3ptNFp5Y0lid01Sb0FRaGxhZmdMZHpEWnljNlp3?=
 =?utf-8?B?dnZMUHdYdWR1b2xJTGlIa2NzT0o4VWJtaUVNNnlwY1k4Z1V5VC9FdVMvVUpZ?=
 =?utf-8?B?V2xhc1RBU3ZVazlKWWFFNlVBaURhT0FoN1J0bldKcnkrUVJ2NVNZcnlyWXdV?=
 =?utf-8?B?b2x3VHVBdkZZdHFJd0ZmajRTczdEMzBJcG1SalJCeDlQc0sxYm50Z3d6RVQr?=
 =?utf-8?B?dkFqS0g1dllMbXV5aWF0MXdxb0x1ZGxSN3BScHZrZW5QSXpQOHhCd1N2T0JB?=
 =?utf-8?B?ejBaWmlhN1p1SkZrd2tHWkZuK2l4SWVGSFZQblhtelFiOTBXZks2Y050OWZt?=
 =?utf-8?B?disvZFM3VitSRDVVR0txdVYxNE1FNTgrYUVFeEg1dnNHdi9DNVpvMGlvRkkx?=
 =?utf-8?B?c0V0SGJ3VEJJQ2FJcGp6MUtneFlIeWhTYXc1V3NnWHVKOWhpbVZSSTVkZzBR?=
 =?utf-8?B?eUlsbnIrdmRWQncyWXk3Z1d6YXYwcm14UVl2ZjhmbWlwS2YyejEwMEc2N2dl?=
 =?utf-8?B?V25iSDlxcEt2Lzh6RG1ZSUZ1M0JJbE1EVWozRGVSa21hK2duZ0lUcFhDMHpY?=
 =?utf-8?B?ZU5pVDhjenRLcVFLam9yZFJNOU5GUWFBdmtmRENzQkFkeEFqUDRkU04wT09z?=
 =?utf-8?B?S0M4bGRLazMxS1RWaWkrK3dOWWl4ZktHQzBpNTMxQ2VGNi9SMTZiMWdhcVZY?=
 =?utf-8?B?S2c1anhCc0J1dGkyWXV5c0FUSzFqVHN2M0xoQjZPNlgzaUNJUXNCZmVJQ0Qz?=
 =?utf-8?B?R3ZzNDRWbzJuQVJQZzVHMUxPd1Z2dDNLY1Z5RTk4ZjR5MGRXQjhNVGFSanZN?=
 =?utf-8?B?WVdRQ3hTYXZlZzNnVitvL3QwUlRCR1FPYXBkcGJIT2xPWnc1Vm5iekJ2SlVE?=
 =?utf-8?B?NE9pZmF2ZklNcXE0YVJLK1ByZzNqSEU4K2lNdDNTTmx2NTJTSVdhUTJIRlFT?=
 =?utf-8?B?VmR4czY2Y29DdDBGaGJpOHFPcng5NndGT3QwSndCUjl1eDZRQ3VZT2JwNFRw?=
 =?utf-8?B?OTV2eTVJQmZLSjhXak9kZllWbk95TVNGUGswYmk0dWhxazg1ako2R2twcHlG?=
 =?utf-8?B?bkJlNTQ0bmJFUU5SamZSbndWbkFQeFpCcDJyWTI0bEx1cDF4VC9ubTh0cCth?=
 =?utf-8?Q?Nc+hr3Tn+m0N5i2aRXobBlPCQgiGbhqCM5czGo3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb3b2aa-ceae-459b-c71c-08d98d8d74d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 14:34:54.2310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL32BuuUMYzsK6Vscpsma/NmcsD3J87Ghb6A14RBFL1G8s5Nc8ERjkEX5o3g3xiAimrV9dAUV8ozVe+zZktGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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

On 2021-10-12 09:26, Aurabindo Pillai wrote:
> [Why&How]
> When system boots in headless mode, connecting a 4k display creates a
> null pointer dereference due to hubp for a certain plane being null.
> Add a condition to check for null hubp before dereferencing it.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 01a90badd173..2936a334cd64 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -969,7 +969,8 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>  		/* turning off DPG */
>  		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
>  		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
> +			if (mpcc_pipe->plane_res.hubp)
> +				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
>  
>  		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
>  				color_depth, solid_color, width, height, offset);
> 

