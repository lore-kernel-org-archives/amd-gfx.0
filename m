Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B89C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 22:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910ED10E5FD;
	Thu,  1 Jun 2023 22:49:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A40610E5FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 22:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFXEt5QSrn7zsLSpHwTZtDNo3JRRRXleBAGMv7VzA/FlpeWvk8ZaOd/PmGJsjs+woB62OjcSOoSQd39/KE7Aw5SNiPwSHFI8XIFpmgotEAJsAloZZ9jbWAG+dNtoir2JI8KJg/3kAmZHdVbZ01ldM2l9re7Km+OD2ZvV2d1v1s0Rq7/eLjOxjO3JafRvrv1Lged3+HKa7Fz4shgcn3yOQ9g9z0vc6tqWgX+MSsRl48lCoj4iQxNxn3j2dlnzcs7LnMF+Id8SxIRr4865emuMc24AlXLdW4F7viEByXhEl3tkQIE+Ab7l8D5Bc46qchscmYjpt39+XgO3O6iTD4ZIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuJLzjJFChCRLzQTryII4hvQtz79+4d6cu0+rXxHRsk=;
 b=euX2q0LvXVztBrol5D449u8rOE7uvGMEV3ObTiko3sPFs/PVQIU60g1r0eUCwTUY9KbZL5gr+Eg61pm7PsiqbdSrMjfYyEB9+r1lelAQS96o8FANTyTsfENBqOBkm7PhXjJzp2sMbmLx6KuQJTBt3L5T49UPmjhu7qU+1thzvJVXCR3+M2D6RKhQcZQ0X+uc7N26wqMlKvOAQBtQo96xXScBgxWYzS2/BRW831WDzySfgUaN1XTk+nwnd58Wmq6LFySathr5FwNGRbffLQ1Mkp25/IS7j0TMOUQRZtm8rGai/I50r0+hdY5UrKeWhzrxTDV2GO8TxFWE8z9Ugg0K4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuJLzjJFChCRLzQTryII4hvQtz79+4d6cu0+rXxHRsk=;
 b=Hm7LNX2IpSI0EBbTRd9U/85Ar8mkRlwab8r0es7/XmpqStxMEl9AGgY4Of70iZkCvQ0cPVCfdT9PUrhmnQTGPCZmgXTqa/gshxaH4c7TKb2peydImk3hTyWKXESEa9A87eNFlpVceKJTAViNnaQN4v4ryd9lGEdh6ZphAp5y2Cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 22:49:05 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 22:49:05 +0000
Message-ID: <b354bd1e-cc68-ebe1-c9d2-14dbc63eacea@amd.com>
Date: Thu, 1 Jun 2023 16:49:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally for DCN1+
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230601170944.1770501-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230601170944.1770501-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 976c9953-1aa6-455d-f618-08db62f2670a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEAt8eeqHIQs/dxMUCFAUnzHK+Z7chEcPsh0dtgwcEQvS+AZNXEQ3+U/FYgWy3UbHa8i0qLeUSa0Y6I7WIcFhfDnMeg64Y1Rja4TpmCzFuJ1dhPeXpj8t/iMJQXGU/rTPUHELf13BnK9O1OcFjYYUWnbcCMGoE2TrhfJTWd5/XQaQPwLa879SwkSdHSXnJF09w0rPOWZkFwlCUpRbzIGNhPa9LelRL8CxFNwvm+Daq1SBKJ4mwll33BOZgOblJ1h2SNxlKYtiMl2Zz6yao7yUVc245becvbJ83UbzbkwIgPVyCZC5BpbSBg7X7URchA/s/LU4dbSMJ82P57pCh/DV9FlSCm7BPb0vt3HtC1cmE30SyGbFCSnrJ2VO8hYqc9fIwO19xfFl/iXf0L8cHqaoTrbwAIxpNWLu38tdTOu63Px21qdRIncyfjErUbkzsK9CA14wFvYgDdlDNpuSG88ORx0858Nrsiw/R2Kx/jsfnDztEv4dcD3eJlu6gnwUYTSbYHwWY/bDjU9VjBYcnxymV3sR74stHags3uenar8S60ERgXhbR4QuwmqFmhOFifMc0hU047vSAaRBQbLz/dpsAF/yQ0FCKmB0SBeOTmlAABpmeUqeePrPA2ooD7G3rhJ6vpb+MVMtK2gYMDCrpicig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(66556008)(66476007)(31696002)(66946007)(6486002)(86362001)(53546011)(6506007)(478600001)(6512007)(6666004)(37006003)(186003)(5660300002)(83380400001)(8676002)(6862004)(8936002)(2906002)(316002)(31686004)(6636002)(2616005)(4326008)(41300700001)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1Bwc21BNmFKbmNweHBxaFQzbE52VzZJY2p0R3d6eUFocVBMcWJsT2pKeHkx?=
 =?utf-8?B?N1poS2lBK0d0WTBucGN2WXZwSnloeEtXVUxlMWJESTE5bzh6NzIvdEIzRW5S?=
 =?utf-8?B?aFRVU2xsYmFJNGoxNmR2eEVJRTZ0YU1JM1NNV0dwck5sZmtQYml3UUdtTzND?=
 =?utf-8?B?YWRxTjI3SUcyKyt3dnQvemtxS2N2MGpDY2M4eXllSkpzTC9tbE1tKzRHOVhz?=
 =?utf-8?B?U3p4OVQ4ekQyNUZ5akkzb3lNVFQwS3FiNjNVbTVycUEvbzVtQVo2cFZscm1O?=
 =?utf-8?B?MG1lMnVqaHcrR0VWQXFJVUF3QTc2dVlheG5LbDRHMFliSnl0ZjJYSDkwWTRG?=
 =?utf-8?B?NDR6MmIwdm00MGxpczcxUWJERDJRN2U4aWRpNm9ISnIrRHJNQU9XdWZDOENB?=
 =?utf-8?B?dXBRMnVRaW4xaThMYXhUZnZQQ21URHJLS2lRK0dKTmtEMUtWVHREM1RnM1M5?=
 =?utf-8?B?NzNacGhlVWkvV0VQYW13anlxWFl0RXVXSlkxTHZCdVJmQVNhSkUyVElkb3pT?=
 =?utf-8?B?Y1ZyTVRBRm9IYmh5akd4Mm55dVEvR2Y4SWRHNll5YTIyS3NnSVJyeGJtaXJl?=
 =?utf-8?B?VmVqMVN1eHZkY1pRUmY3ZkozTUIrZFpIcTJ3Wk1JWFpIQjc0UDVNY1hyY05M?=
 =?utf-8?B?RUVYWTd6MTg2VXU4QnFEWnlJeFl4RWFtalA4K2xKK2hzSmd3cmhwNGkxbXpj?=
 =?utf-8?B?NG14RiszOGwzZTdnUGRsVUoxUkNMVHdkZjhjbkJPRVZVWERkSHY0UEJhbnpS?=
 =?utf-8?B?Q0Qwd1pDTVlJOU9hS1ZsMFdJK0dBcUt6TUJrYUtNdkE2VnFOZTZOOHNBT3Fz?=
 =?utf-8?B?Lzl0aXhiTzRFeHFxdWxmV05rVS9VeElvUVpNai9QVTFFOEVaWmZINENIQzRP?=
 =?utf-8?B?dm1pOHVVTlQva3VzMXJSbTVKZUpZQ3BZV29CY3NETzhIbElYb0tiT2FIZXNr?=
 =?utf-8?B?Zks4RVVFU210WGUyYURIYnFNVlRTLzFhRDhrZUs1aHJ0RHcwVjJsRENwNHFz?=
 =?utf-8?B?VDlicEtJZVBWc1FjVTFJdTRraWZTekdJeGpYVXF0dGhNTUg2MmhDaXBBSjZY?=
 =?utf-8?B?R0ZLQ3RkTEhQNWRqRG4yZnJmTkdmZng1aHNSZ3JjMlBwYlIybTlIRFBOejc1?=
 =?utf-8?B?aFB1Sk1qMng5cHNROVhEY0RzbVJ1M3VIZ011cUxHZkRaeGFWU0NTUmEvL3Y0?=
 =?utf-8?B?bFNxVzZMRW9aSjVBSGFreVpjeXVQYkdDZGY0Z3I5eFAxQThCbHJwNDBZSnd4?=
 =?utf-8?B?d0Y3eTdjbytWK0xOU0taN1NONjI5dzVtSi9ONkRTNU5UYXVCRHVkTjJhK1JW?=
 =?utf-8?B?NHg0am1pYitkNkZUT0YweGVsbjA1NXBVc2pZZldPakZpOTJ3MC83Qjg1T2Vz?=
 =?utf-8?B?OEZoZTloanpUbE1oRkt4bVNKdk4zSk5vc0FhdEE1T1pVZERKOE5zbVlWcTNS?=
 =?utf-8?B?Nml6MUZpYTBWYzZNSk9haGRaeExiMENlM1hBbUd1N3k5VmU1Rkp1c3ZBcGRS?=
 =?utf-8?B?V2s0VVVReTZScXBJb1VZRjJtZlVDYk9DMjJ2VFdoMGs1cllzTHNLVTJ5WEhz?=
 =?utf-8?B?R1h6TE1xL0lUektENUM2RWl0QjRkNTVMRWZ0VWs2dWpkVzZJeXlXdmJVZWlF?=
 =?utf-8?B?QXhld0xVZVJ6SUpEb291NHJQTzFxU3NDb0RxZGJEVU1vNEh1NXhjbjZwNzFJ?=
 =?utf-8?B?bUJJTGZPVmVwY2tKS1dvN3N5dEJ1WGVwQmE3eFBSbVN5MHgzS09zL2IzdytT?=
 =?utf-8?B?NE83eHZxR0x3MU1zaGhwZVBiR1NkK0pUbmdsVzZ0NHhiV3Yxd1hLK2haMkk0?=
 =?utf-8?B?Z0U2OHVod3BhSkFGTDI3VTZxNzVvbzdrQ2NnZDA2aUp6VmQ2d2NSWjlGb3Q4?=
 =?utf-8?B?N1owcEc2YnJMYkNFRTdrWUloWEZnNDNsMk9jaHVUdjdZamhYQ25GQjh6ZHFY?=
 =?utf-8?B?cVNNU1FVTUVRbERIY2FkU09SNHY5djZ2a1hsSmVRcTlMeGxJNlB0MHdnY295?=
 =?utf-8?B?b0N3cUwwY0tMWDNtSzhaQ21FVEUxMjIweXd2WEt2SHFhR3hMSkJrTEhzMXZv?=
 =?utf-8?B?YnZncDI2bExwMzJOQys0MGlmN3JjaUdUeWdSVWdtWXZ2bWxNejdJQTF0d0FS?=
 =?utf-8?B?VWxpempqdkV6bEJFTldicG1xMmZsTHFCYktCN09NWnlWMVhrOGZzaVpuY3g2?=
 =?utf-8?Q?4LsoD6GEG6VedzdENhj+w2sLqQnlTGhmMNgvyozjPAql?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976c9953-1aa6-455d-f618-08db62f2670a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:49:05.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grKqaqfz5YxlKEFy8NB/pabGVLJ6V4iBi7ozAeBDqv4WrH/Ewa8cMk8fX5Fvli3d3gegC+e2d6FZi3HmuFnFgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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
Cc: harry.wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jay,

On 6/1/23 11:09, Aurabindo Pillai wrote:
> Due to FPO, firmware will try to change OTG timings, which would only
> latch if min/max selectors for vtotal are written by the driver.

Could you elaborate a little bit more about this issue? Right now, do we 
have some sort of race between firmware and driver? Is this situation 
causing some problems that we can reproduce? If so, could you also 
describe it?

> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++------------
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  6 ++++++
>   2 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> index e1975991e075..633989fd2514 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> @@ -930,19 +930,10 @@ void optc1_set_drr(
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
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> index e0edc163d767..042ce082965f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> @@ -455,6 +455,12 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
>   {
>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>   
> +	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,

Could you align the below registers right after the open parenthesis?

> +                                OTG_V_TOTAL_MIN_SEL, 1,
> +                                OTG_V_TOTAL_MAX_SEL, 1,
> +                                OTG_FORCE_LOCK_ON_EVENT, 0,

Could you add a comment that describes why we want to set the above values?

> +                                OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */

Why do you use (1 << 1)? Why not set the value directly here? Also, in 
the comment, I guess it should be TRIG_A.

> +
>   	REG_SET_8(OTG_TRIGA_CNTL, 0,
>   			OTG_TRIGA_SOURCE_SELECT, 21,
>   			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,

