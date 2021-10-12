Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DC7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593796101D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 593796101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C5F6E99C;
	Tue, 12 Oct 2021 14:30:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A255E6E99C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWQ9fXK8RQgyRJCKAY0tjAT4tPLmzvLaTz+t7dDiItydeHpvtwdMVUWK87SbHb6kvot5ITti/CSAt+gaLJevByPQedcjNncLVZ/BVagXDZw2ob0Om9kXwEFk7TPJviy128SL8Ok1rbdX9fMASxhoDO2PV+btnVEnuRrh7NCLL8G4PiMlFrxUgelKe3FvIa3hWN1kdZ14LUxQW2DmfjQN3ifWpEUzPXx4Y2yeKgXD6s4ofPvWF6+/bDWpmm48An73ANDSXGeie9mrQJvdEx0PM+xIYKbULW3pFJQvtvQgNPjh/1g7RhseWit17ZCFT/3UBcKibmFFiylCZ6VB2/0weA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H4PUBY5sTvwJxedInAURstku6DvYDall9lg08dIYbg=;
 b=LSHE8Ob3WwMFOjWd/UIqgM/D+WeGUztmRmip5M0pZHz4ODk2UXEJAglh3MyTj6VvbKxTuQvX57uo7999E8Yj4NcevDmxdtyhI0ODGdgmzRT/4m4TzoxhHsDF3OFIVyEGSsoFCbYSU5xp6EHitNMYqV00R8zFfYCoKn+bcfbNKPpnc8ZJoLGRt+EiAAGwbg0BF686qp7djOhVnZK4SjFra+Zv1XtB0WlrbMJUFpc23D8ev3BQbVBUTWKD3OgalOPk9WY6HxAYRMpTa2S6bKP7u+4zpjK7cSpfSA1XRPIxBAA7nLFU9fybgDRCxn2HLharIs7f9TCKrhMQmxM8L1s9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H4PUBY5sTvwJxedInAURstku6DvYDall9lg08dIYbg=;
 b=EwvbSwst707MR9iD75dZh3IwibXhX0PtvL0bzLsd8+xkPDAh5LNNvce/k3/E1rYFIr4I74GjzypdIN5DwO5E5VvdN9et8JdozxZcBrwB0nlVpqCh9PRKidTwRrPB0SBIvZxy0H0zSn8UdccQAq5CISnXFmJ6E0PFgBxRTptEL08=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 14:30:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 14:30:34 +0000
Message-ID: <2065536b-1dfc-e461-8d1e-c257e41c3f0e@amd.com>
Date: Tue, 12 Oct 2021 10:30:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] drm/amd/display: Fix surface optimization regression on
 Carrizo
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Tom St Denis <tom.stdenis@amd.com>
References: <20211012141102.4590-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211012141102.4590-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Tue, 12 Oct 2021 14:30:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c6e6142-4069-46c5-347c-08d98d8cd9cb
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54735C99B350B2B7B84525878CB69@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQoado1DTWAgQUs44Ge1Udi9eSkpTOetcBlOyoZauSii34wKLCrGVjLJNdhq6X0h4mU03G7XwccBt+MVA1ITYbvkdfUWvY6KuecwfyEeUXBeG1gsoxG8vodZf+hNOg8DyyyURns6uP6lam36gY8myP8DhcJMd+aRprDeiS3D4sd9NhYWfHJTmezf2HvAw0MUJbRCovr9MwpjgqjnWHOT1NG0mS8AqJn5jb6g1CM784G28FeDD0Ah1f/Pp/BYAbTi/l1EjPl64OSXfARkURQIOUG9u9mxPE9cK17UKJ2NS3WCtGivmZryhGTP8AaAXh3IWJYUyf/TLAwuwryxFqmNXKgX+al1i+GGzuuYVf4h7sARu6nSTHLrA9cRxkPNmQ5ulOAmiP2pyumTfZXMTQl9ZLOEb999j+EROWCqMd58/FOhHnLEvXMI5o/ndAToPb3ob/dE/D9CFFv0pYsxduLDw2Oj/4nc4AFp0rbChD5+o6JPtBXLmajTjkJPEk8A+DEk6GjEWRCeHl+2+kHuzkzLdxKrmYVt20a5/o6d5/O4nWFdVfv9VqXgP8m9SPVz5+YZwNHZ+C2c1KX7UftiIxGsoTPlrEnIPVCzJtlysivODwmMMED9ffojzvzJx02P8mrmw0RzZ5gmUY2B7yvQrvY4ROgUj9rJhZcHozFZwPGx8H4w9yqGGC7WzZ3H1s7nhBJJgr7eNOhyp33V2/wSjDnIrE5k6PV430suONDj3wi5qZltbHDH+l8zvGtZewsLGupi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(86362001)(54906003)(508600001)(16576012)(5660300002)(26005)(4326008)(4001150100001)(53546011)(44832011)(6486002)(316002)(36756003)(66556008)(83380400001)(2906002)(8936002)(66476007)(66946007)(6666004)(31686004)(956004)(2616005)(186003)(8676002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RGbW5NWkRSQWJsRXZsZERSellYVy9RTlNjSktocHZxSUszaFptUGdyUjgw?=
 =?utf-8?B?dEs2UG83cm96bTZKbDlDUVEzNnBtOGM3Vms4ODhiRklBOUNHWWw2ZGxZU0Zt?=
 =?utf-8?B?QWlMR21IbE5SUWo5S2Rub1ZZVGpEdUtLM3d4aEZJU1ZnVG9iM000TXdrVmFu?=
 =?utf-8?B?VURKRC80N3cyUnIrejhJRG9zdEplZWVtcndQeDVpMkxMYlNyYXNZYWlLTkpt?=
 =?utf-8?B?SjBtVVJWd2hCYkk3QUkxQm9TUDArSlM1NGhOamRVaElVRnZ5azMvY0JoVVIv?=
 =?utf-8?B?TTdXb1JiRU9GcXJMMW1tUWd1MjdmNkMyYkZ6NEJKRjlEOU1pcVpCTU16dkgx?=
 =?utf-8?B?SUZlMlgzSWlvakVmT25LYlU5UFlweERRcjlhUlFpeng5ME5IdTkwbjV2TGV6?=
 =?utf-8?B?MHFHejc0VjdpSGRvRkdhcnhpWXIzYnVwSXNGUUFFSjhaNjQ3eEMwUVBJWng5?=
 =?utf-8?B?K2pvNDE1YXpsc0U0Y0cyNGE4VW5XVWVxMmw1YnVaQ3dVN2ZzVmc3QUFzWnhv?=
 =?utf-8?B?cTU5ejVxK05Dd01KM3pvZUFzZ0U4a3ZsalNBYzVNOE9IM0RJRW54emlhWFZR?=
 =?utf-8?B?Zm9tOUlnWXpRbGJLTFI4TWszVVFCcm1VYit5YWtZaEdtNTJBbmQrZ2ZFemZl?=
 =?utf-8?B?WUFrMmpMdlJlUGdiQzAxNG5VZTZJU2lIanVHdGN6bHVoeGxTczVzV2xuelcx?=
 =?utf-8?B?QmNsN2tDd3RHdlFKY0RtVEltdDYrdVZLYUtueXJ3SU9sUTVubXY0VGlEVC9v?=
 =?utf-8?B?MmRPVTZPVzNtQmhRamhsSVkvaW5ZbXptWStHVlZCSVBUams4aElDVXRqQmt5?=
 =?utf-8?B?ZEl4VmxuVzZEV1VxRFdybFNtaisrMWloOTQyUVJYWmZBOUVLRVI2N3hjNEZT?=
 =?utf-8?B?SkJ5aHczb2wydHpWOVp0NGY0WkN0L09DbXczMjBybGwxS0h3aXFWRExFZjZy?=
 =?utf-8?B?R1ZMa0tvd0pMNnRuS3BBZFNIaWt1NTBmOWN0MGY4UTQ0RVUybzhWUjdiRmF5?=
 =?utf-8?B?b1RzS2ZNUmhCUXhVNm5tSlU4WUwxRkdOWm0zejVDckZPeUU4VEhBVzQ5NkNN?=
 =?utf-8?B?eEpzbXhGQTdKbEVKTFRPc3d5U2lXRUZvbjc4MVhiNkIxNTB5VDA2bjFxTWtm?=
 =?utf-8?B?OU5lR3JoN1BTcG00N2VyOTZHYlBDeHg3dFJDTnowcDNyaVQ3NTJWQTZlbkZZ?=
 =?utf-8?B?WjJPWDY5cGdibXFJeGFjblk1L0VtZC8rTFJWbDZBWGdUeWpUa1ZuNDJjS3JF?=
 =?utf-8?B?VWVWSEFQY2xBbGU5VldRT3NwWS9zUzZwMFJXVGkvK0paZGZNS05qRnpOa09M?=
 =?utf-8?B?Z3VzdWhSQ3JCb3RBQ29yMldEYkllTVlmQXRVYXVZVmE1SUhrbUY3V3ZFbWJH?=
 =?utf-8?B?Uld3ZXVHQkxMUHlIZnBydFRSMHVxUUlMS0FWU2o2MXZReW1FbnV0SHBKR2V3?=
 =?utf-8?B?SmptanBMcTA0RlFtTlRXRWp6SGpiVk54UFArSlo1bmNYZEc0bnJGekVZQTU2?=
 =?utf-8?B?QUQ5Y3NqMjk1d2R0SGR6N2JDdFYxVVNIKzRJRkx1b0Y3a2pqV1NiRHc3T2VN?=
 =?utf-8?B?Y2VXNGF4Q04zdkNpZ0pVVlJvMGhvK3Q1eTcxZjF3WVZQOG16QStSYUpNYS9R?=
 =?utf-8?B?ZzB0TkRLS1dIQ2UwQ2kzTlRRTE8wcytvbXFrT2ZxYnZSTHdrbk93b2pEcWNa?=
 =?utf-8?B?MXd6OWxUcXFEK21VRE11MUgvOTZFdk14QVNNVGNwZUpnWXpCVXh1aEg2ckgz?=
 =?utf-8?Q?3TYK3yISpEujIbJcd+ez/QpZdTXdYnyzeXa0Wh4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6e6142-4069-46c5-347c-08d98d8cd9cb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 14:30:34.1961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq+VXhMSpFV5X+OCPm9qwLsZvqOpEh8gnoHEVgDg4lKDV66Klu59hKGHQx73lifxsGfPw5PLuYGCKHsuJTSuSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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



On 2021-10-12 10:11, Nicholas Kazlauskas wrote:
> [Why]
> DCE legacy optimization path isn't well tested under new DC optimization
> flow which can result in underflow occuring when initializing X11 on
> Carrizo.
> 
> [How]
> Retain the legacy optimization flow for DCE and keep the new one for DCN
> to satisfy optimizations being correctly applied for ASIC that can
> support it.
> 
> Fixes: ab37c6527bb1 ("drm/amd/display: Optimize bandwidth on following fast update")
> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Reported-by: Tom St Denis <tom.stdenis@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index da942e9f5142..f9876e429f26 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3118,8 +3118,13 @@ void dc_commit_updates_for_stream(struct dc *dc,
>  			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
>  				new_pipe->plane_state->force_full_update = true;
>  		}
> -	} else if (update_type == UPDATE_TYPE_FAST) {
> -		/* Previous frame finished and HW is ready for optimization. */
> +	} else if (update_type == UPDATE_TYPE_FAST && dc_ctx->dce_version >= DCE_VERSION_MAX) {
> +		/*
> +		 * Previous frame finished and HW is ready for optimization.
> +		 *
> +		 * Only relevant for DCN behavior where we can guarantee the optimization
> +		 * is safe to apply - retain the legacy behavior for DCE.
> +		 */
>  		dc_post_update_surfaces_to_stream(dc);
>  	}
>  
> @@ -3178,6 +3183,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
>  		}
>  	}
>  
> +	/* Legacy optimization path for DCE. */
> +	if (update_type >= UPDATE_TYPE_FULL && dc_ctx->dce_version < DCE_VERSION_MAX) {
> +		dc_post_update_surfaces_to_stream(dc);
> +		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
> +	}
> +
>  	return;
>  
>  }
> 

