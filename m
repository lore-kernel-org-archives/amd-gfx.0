Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6DEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC45310ED4C;
	Thu, 17 Feb 2022 15:26:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A862F10ED4C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtNwLzUTICHEgzQZw4ZHHpwK7Fa+8Ajk+kA2ZZkfAjaEW6jG80V+heOag+ppidVKAXRsSauyc5XZmwWfh1sVvmJnuXjDt8RUMVg90fbeqjmyJzfgeTc2JOnL2PjL0hz0fzqVwYXTGjLYQggRASHRQF9CpmcsNuxgxZtq19G2DEIc36tGV5sv0hYpzhyIGnBy2rTFPeypq7KvTnmsepeC/2Iz9+MBWk62QVhUdxuuE+/x6RTYXHInr3HZdq7d226yxb5t12PQhjbeSLZUofR7QwAx9xVEEKuKlOeHt8+FKDV9gw0Q1AsErvQAYvrBHElErfi3CJ4AdSZtCffLo7Uu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvBYooqbmCJYo+pxVXciMcE7HB2F5eBh8rUwMRHP8rg=;
 b=J9HMgG63YGjiKnuf8bCj6usR4WXwFG8NyrhFeOuwarrF3o3c5z0DjF9B+EGWZ+x5n6eUj3AkBk4sykHnjy/wwwA1eWMXRhnyRqLfQLZp23Qp+vZrcZ4ZimJ6/JCM252qjzhiff5v5pQ5zdFT0ZsENTjAoi5KmPjcpylOvaegV0V8IfcwHw9WatH7if2OvB/LX6G9pJvQ4Jinnk9urE4ktYHEYj28iTSyNKrUV2GRuY1T3gi7BJ2pzImfngw6MnmQT/uX4ef97WVYixFlYIItGQo4jzfB/7k1L+uiSE+DqzJmi+acVEIfw3UPu994W/Go4QYo5lYPk9eiTPurTuVcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvBYooqbmCJYo+pxVXciMcE7HB2F5eBh8rUwMRHP8rg=;
 b=aRrERFlk+w6jRVAaoBYqeQK5Jjfr7vdyJ1cEfDL3ZuG40EemLichLZuCjYy46U8jzW6LP77zW44/FtfNUBPSyrOH2POBwmE91MqeT5Qiqq7vSANtuFB023zVF8u98IAL+NnUD4ILu90g5eAET3F+OFepubIXrWIo/fd4AwnNYHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 15:26:36 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%4]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 15:26:36 +0000
Message-ID: <5ac96026-1dd1-7c8e-b18a-5ec4a0631147@amd.com>
Date: Thu, 17 Feb 2022 10:26:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/1] Revert "drm/amd/display: extend dcn201 support"
Content-Language: en-US
To: Jasdeep Dhillon <jdhillon@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220217152412.825286-1-jdhillon@amd.com>
 <20220217152412.825286-2-jdhillon@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220217152412.825286-2-jdhillon@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d21fbdc-6171-4fce-8ddc-08d9f229e289
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB576259E635899E391AB7E6AF8C369@MN0PR12MB5762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JHbs0++ntl2/tmRNyDlcCgYxxADNNEXIeIQAT75exuAEdLfrmPUqMPX4zffBAwkSc0R0T6n+/jfihjl1KpjLFKL5vEK92n91AM2uMNq0QPzOWjz7gbtTW10zXnTzYanRXfH/2N4lsgPqnchPoud/wZY5V6lQHMsKKM69DvdriLMjInxOH1Vf40XASe0OPw+/IIuLa/zf7J6QSJVso9bIDrQNdyXQ1EdOce7FVmre4EJOui0w9rEi3GpwLNmejCDVRjJInPUDeXPN6d6T7ijz3cA4RI4MHT/MyEH7XCjPPUmBLC/TvLPuKztS6Oelgw7Qu9aroRdQ+nn7qkYvXohZSNxz9YT8fNF1SWG7biTIqY50B4SaNgpd5OepJR/HHr7eppeHgS9rXBU+u+wlzyOUiA1o9Wf1kv6uGTJjdgJhI4sFtMsjIokEtIwye5X+UV/6ecqAXs+JZS68b5eSzmb39zwnhX3bCfyUjl5HYMow7VPOrm2s/bl0xdcpLb5sd+/ee8kyiG14oenXeCy3UxAM/uC4QU8R3d+CWptVMaYocNBJdzN4MW8sgttQRF3566dI95II/AcqEP6/6Rcg8K1vcARBy6fSBZO/Fjb95cxwDEE6KC6Y6AG4po5vTSnbjqLVoEroLYab8sT65/Nkp5Pd27qSDiMT6Hhtstrpc80Hsb8f7leTvp0RMjBg2G0bI1W4e1bDjqaqAb+ISSRqyq5BrgQTOtXZlFQHGt6SZY9F09QqTtXHtyJDNYo8L8WdnwI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8936002)(6512007)(6666004)(186003)(53546011)(83380400001)(66946007)(2616005)(66556008)(26005)(31686004)(2906002)(6506007)(508600001)(66476007)(38100700002)(36756003)(5660300002)(44832011)(8676002)(316002)(6486002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBsMzlwZHVienBCY210R0RPUCs0U3VuTVBRdGljbk0wc3M5RGIwWmpKWSsr?=
 =?utf-8?B?RUo5NWJpU1NFNWsxZ24wUzcrOTlIRFFlbTBNMUJjdnp0RHBUTXBTZzRVQ2c0?=
 =?utf-8?B?Nm8vT0Y5ekV4TlFRaUhMeHZIanRFUHpneVhQTkV4clh1YzZ0MmxWNWZsbU9j?=
 =?utf-8?B?UEx5WXdUV1lmbjBKVmR0SC9oRk1sbWRLc2VGZWhXV3craHd6K1Ztc2xNZ3RS?=
 =?utf-8?B?Nlo1Q1VwSnZpalBaRnlLakJIMUhpRVlpclRMRHZyZ0Jha1o0bEpBYXdRQ3ly?=
 =?utf-8?B?b3ZiTlBKTTIxcDVFUllLU0tHQ0pYZXpoRlhpcmRPamxQRTNKNzVOaVRSMHo3?=
 =?utf-8?B?R0VEMzhSaUp4ZGZOMmk1ejVqZ1ZFKzhQTmdhaEdKMms5eEpWWk45eGVTaUxM?=
 =?utf-8?B?enV6VDNMS1pNUXNGRjVLZDE1ODV5TklzZnRCY0tqVFVSNCtqdnBvMkU5UHhn?=
 =?utf-8?B?NEtqQVlhNDJ4UmFHZEVvVWx2NGlOb2NIbU5yMGNoamFyK2ZqSGJ0Nm9GYkFP?=
 =?utf-8?B?U3NKWHVWVkdRTnNVNTRFWWlGRUova0ljenJFNi8rKzQzSStLcVIyaHNPbkZZ?=
 =?utf-8?B?TFEvYUdlQjc1SFlVZEEyVk1tWUZRZUNONm5YL0p0TFEyYU9ITUZxdXd4MzJD?=
 =?utf-8?B?OXIyNnJ6Y1A5azRXemdtQ2lrSUlXTDQ1bzVySkQ5R001V1oxbW5wZndnVTdX?=
 =?utf-8?B?ajFOR3pyUC93SVpxMzhhVllzK0FMSzdPM2x3UWZzQVlyVzNma3VZN1pCeGJT?=
 =?utf-8?B?MlVZd1pkdGpXbzRQY1JBMnZTQ0p2dldWeXVWQWMyRGd2WGpGdWs0Q3pwbFRU?=
 =?utf-8?B?all4VnlDVGhuWGxYTDhndUpOcUFPeENHNE9mTmF3elhBVlhvL25JUVFxdy9C?=
 =?utf-8?B?ZHVzNXZ0aDZuYTc3bEJOUkFoOTJFU0hnZFFDQmJyNUkwUjJZTFNoa0pzTytm?=
 =?utf-8?B?dGZHZzBncmVLeENFaHdyRVk1NnlBb3NRa2ZoOFMwQ1NIQ05xWTFnS0pJUmJB?=
 =?utf-8?B?c0RJNFROcUYvL2RzMkkyS1JMaXk4VEJvZUhDcmtaWDlONVJiNVBaaEVaQ3lo?=
 =?utf-8?B?NXJ1MUdxWWErVGFvSzd3aWh6QkhOTkhtbEx5Ty9xYlRwYVVUczRxRlhUcVFi?=
 =?utf-8?B?OHFPMjdHejM5alBKWlI2cVJNRUw4aWk2eGtka0trVkVLa2M1Nk9lR3IxWGZi?=
 =?utf-8?B?YWZadFdsTkMzV0h6ek9TeVVwcmRGMktHbmRXcGdtcGNsTzU5dUZDbFBpQU1o?=
 =?utf-8?B?dzZJTUZ3VWJBQmxHMk5zcUtXQloxMGwzaVZZd0VDS25zV3ZjMGtGNWQwdlhI?=
 =?utf-8?B?T0FxUHlDWWhlREVnNmtZN2cvL3k0Wmx3WVVGOFNob29wT0pyRitpMGtRMVdv?=
 =?utf-8?B?V3J6anZjTEo1bTFsK2FWbXJ3S3FMV2habWlVQyswVFV2ODREQUU2YzZvVUs0?=
 =?utf-8?B?WjZDcWxtclgwcEFJQjRvRmc0S0ViYWZlcWxtUWZTU1dIVjNhU0M5UXVEREFU?=
 =?utf-8?B?T2pObUc3VE5qS1hBcEZSQmU5VGdXUmo0Y2QyQmdtOTBxR2NTSlFLY2ViOEpB?=
 =?utf-8?B?MkIzWk9UaW9aNnkvZ2JCSmpOYWk4YXEwclpKSHl6YkJLMEdnTmEvUlZNNkpm?=
 =?utf-8?B?b0RvSjBNNjRhY3NQYmxLZHlWS3NrNmxlYmlGQlZYNUR4MThqVTNIQVZTVW1D?=
 =?utf-8?B?WTBDbkpZTytnVFlvc1c5anV6dkkrRWtIdElnSEpGRFZMWXJzaHBlOXN6NFNv?=
 =?utf-8?B?dGNmYzhCclZsVWpzcHRQbXYxa0RsQkd3YUNrRy9zckk1Y2xOYzJLZk5UMCsw?=
 =?utf-8?B?cHYvaXR2Vk8yMmRDeUdHR0tLZmpPbkVOd25mL1BObnVVQzVrdUZWMFFheG1T?=
 =?utf-8?B?b25PdDc5SkZEaFJ3NXNJMGFKNDFwWTVlc3VYTG1ha3FHQTB3MFdvYmpqbnNy?=
 =?utf-8?B?ckltUWlHQ29BNkl6ckNnZVFYbTJTY1dCeldPbzN2V215UjVlTWtJVHVUY1BN?=
 =?utf-8?B?MTQvUnlETlh1NUY4NWdvelVxeHJDVVNSVWhWa1pRbWlpL1g4NHZSQjVxTFMr?=
 =?utf-8?B?OW0xdVlJY21GWXoyU2ZYNnNrWVA1NG9JRGl1eDc5bzJ0V2pQbTdLdXBRYW12?=
 =?utf-8?B?V0FwQ0FUazl3S1Z5VW5iQTNlSThDNmZWOTNSUVU3UmRYbWtITVBMWTFCMFJl?=
 =?utf-8?Q?Ibd+NMUnIOAERInZT8UuZqg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d21fbdc-6171-4fce-8ddc-08d9f229e289
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:26:36.0551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwISv4PtGPk3Em1rhaiXKmahoExzvX/PUsd7Ql/ztFYSojJa6LoQyK70u2h4gAPlCAqiILY5/Qrt4xkiuSDYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-17 10:24, Jasdeep Dhillon wrote:
> This reverts commit e4a10691948030fc92b11b563cf62144d8d7cb8b.
> 

It would be good to have a commit description here that mentions
that this is reverting the wrong device ID definition.

> Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>

Either way, this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index a2a25d444574..0d0df7271732 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>  
>  	case FAMILY_NV:
>  		dc_version = DCN_VERSION_2_0;
> -		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_1400) {
> +		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_143F) {
>  			dc_version = DCN_VERSION_2_01;
>  			break;
>  		}
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index a8dcd6d439c6..e672be6327cb 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -212,7 +212,7 @@ enum {
>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>  #endif
>  #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
> -#define DEVICE_ID_NV_1400 0x1400
> +#define DEVICE_ID_NV_143F 0x143F
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
>  #define VANGOGH_A0 0x01

