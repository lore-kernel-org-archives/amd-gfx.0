Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238F9C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 17:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D7610FA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 17:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D7610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6303E6E2B4;
	Thu,  8 Apr 2021 17:46:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321D36E2B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 17:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKv9Y0CknDAPGovI1NKZWpz3v6y8LDod05U5YV+s1L2WHurt3pRDCuz0rBc8dOrMc501KIePkxJVSaW3qOlN+vJlUQXPCiGXl57Lm7f68eRRF15Czpug+kteEgVzDkUTAlrWWsqnacV5g7dvj8S8OpSsZhVOf8Ed7dl1UT4dk51SQ0t0hib9PQ0MjQ707E7gDaY21m6S/NoOk68A3Y95A4luhhUaXCRFBEAlCbs1bQz4rQFDwRbq86bAnVw3fP34qA6E5Y+0uLk6zfRAeqmUsDNYi+g1/oVKR2xXpTq7tfzEyzySOwAf8YlaKBcLTiCkDrp/N9/98khxHVn5Ai58dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK/kKTMXwl5/LNEVaq6d6QikTTnavCqXpFh8S67Ds1I=;
 b=TVyELLEz44eILoTaxLGGCBGTvZMtI7FNi9lNQythX/R425vWVc6X8DjHkW4ILPbMgo13cNZVFX88FqRTiwzLTrW1H1Uwp8IHAQcuP6em5q4qEyK5GYLLBjKQ6NfMrB031jWuXZNTKh7nOA2eLIlHlvdQRQQoxY0HkApFzeAP48V/TRLq3ob5MyWKcC2t57HdNri00lZ8oMT5w4GJkGAjb5j4T4+txcYRmPbYHfm0iJI5XiFdO5+TLH35LFb+Lfh8uXrY2p0MCX5/Ecl16lnKhWZSY7dbV6i9sktkZAG7+MqisMxtZ4AyXaBpGpwISKwdem1wDjx20Tzgi2MHXzuBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK/kKTMXwl5/LNEVaq6d6QikTTnavCqXpFh8S67Ds1I=;
 b=G9xpkw5s2s0QKnC+Wbop7S909xJ6oZulZh0Pb/eOfvbcoRFl/mBJ53ZBr0+fAySUB6eWW5RhRg4oQtobQ53/VoRoqmI4oMpciEsqvT63PIE8A3JcJeLbRw5xm6miBXTy1POEqA6a0VEW9e6CGI7x6EClj7LLmI04c5CbtraWsKE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 17:46:32 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%8]) with mapi id 15.20.3999.036; Thu, 8 Apr 2021
 17:46:32 +0000
Subject: Re: [PATCH v2] drm/amd/display: Update DCN302 SR Exit Latency
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210408171048.44591-1-aurabindo.pillai@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <f72ee3b2-fc36-bb41-4c15-09f22a683d77@amd.com>
Date: Thu, 8 Apr 2021 13:46:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210408171048.44591-1-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Thu, 8 Apr 2021 17:46:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c9d540-2969-4164-e002-08d8fab63f41
X-MS-TrafficTypeDiagnostic: MW3PR12MB4490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB44905043C59C1B154BE91EA88C749@MW3PR12MB4490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVG26q977SULQIZYgyvCqxXlmxzUvUCHS7V3SZ9efStmVTMtdQnPu7DMDdgtN05oGMlqqWLivPfqmBON+gEbocIWTboDI4CL5Drzq179RyxQDcsKpdOWkPR8U1delFo/OP7TRpXenDbSeySE5wXh3uJePF8jmw8XkiIr7yTpI4mGpOfM2mayDRxk1vPYxCxkyUlSvTQAFEPLhfWfMAEZyaQUerpP+SJD7VhBrg3xGmXWtbdtNbAkISW6qJVMaIbD+CaDs69QB92vRRrDUAWj6isqKNbuX5GR9CYaoH6ZX3OHOIS2uKN5A2Ducc2A+azKd1OHLUMb0aIEHj8WHhS5vvxgmBzwiMLJT+GPKX6Lh0OTbmiaHexYDGEQB8Sf4lJaA6C875EsrVbDOU9cOnvxk7cMj8xmSPOXmER1z9vFZ6whCFsO0U4eIZoYE0JVv8c4FlPSCCsQuXaA9ZI/GUJ0eE4K0/DA+tTawUCCDouhh2brG4VNCIim/ceXcgzbB068sAf5SXLH63N+wk58jK+bDxxgWIHTpHjH8Ov4/xPg0b0tLxHMXoaQRl8+0XsO4K4eo+TTQerN2d7IBCtanvWa3yG/S2a2c5N7O1u2KY4jurvLwl4RL9clgqnQjPaIZ6SSDglD2uMVlY2pt6ySrkN1iD1Z3Y6XGayxwuAxwAl67wM5zHwxOAsD9IpxQCRw7q6p5BFeKH/tPM+g/PbmNLQHvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(6486002)(478600001)(31696002)(66946007)(66556008)(4326008)(66476007)(53546011)(86362001)(38100700001)(6666004)(26005)(8936002)(186003)(16526019)(2906002)(5660300002)(316002)(31686004)(16576012)(36756003)(8676002)(44832011)(956004)(2616005)(83380400001)(15650500001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWJTRVV5bWdUMFNFd3ZvdGM1U0s0S3dINmdBL004VDkzSHhCZ05GaWh4bys0?=
 =?utf-8?B?WFdZSVZOU1BscmdXbTA4YmFid05YTlUwTHpSQ3hsU0xiN0tnNDVxODVTZ1Vo?=
 =?utf-8?B?WFJ0K2ltWXVzWTVFcnpTb0tJMyt5Y0tiRTJDazQ2V0d1eDFFaGovRU1Zc2Rh?=
 =?utf-8?B?SVMzMFlyam5hM1dna0JVd3h3ajFlS3BYUmd0dlI1OG5KTi84VjF6KzZRelUw?=
 =?utf-8?B?VXBRbE1XSWdPWHhyclp2N0gwSW14eVdPUVFDZmVVcEVzMWNKNmdqcFI4OE5S?=
 =?utf-8?B?N3dSbk80ZlV1ODVwV2NrK2VpUkVzbTUwSkFrdWo3YkxBTDZXQVJ1WjdzSzJO?=
 =?utf-8?B?VFNrOSs0VkRLNW42bDRETzczeFYxWHNkZjRqUU5kTWxQUXNzd29VS2lKMml2?=
 =?utf-8?B?dmxZYTV4Y2ppMVhGMWJwMyt4V1lIcEV3dEl2aUVTR09jTmtBRnpremtqcFFi?=
 =?utf-8?B?Y1hZdTFmdk5TdUFjSFk2U254MkxZUExkMUdpL2ZwQS9pa3Nqa3JuS3RVdnhC?=
 =?utf-8?B?MWtkQ2gwMEw3OWc5TzZ1cDJXdmtjcENZZHhyNXNBaTJ0ZEJyejBOeG40K0Qw?=
 =?utf-8?B?ZlhaV2RsVXIwa2pzY2c1dmZrUnpoMG11cDBiSnVHWGtrb0tLaHlmK0FsbWt2?=
 =?utf-8?B?YkFrbXZ3cjR4bDZoY1lnNW1xUmVTQWhZb3lYRnVFZXR0RSs1cW9YZ1VTMXE1?=
 =?utf-8?B?K1lTTVV6ZjV3VUFEQUxnWFR6a09NSlp2clFHK3FOWjJidzN4dld3TXR2Um14?=
 =?utf-8?B?MkNTOS9CMXRaL0hLRjBoTjRZMU1oZUZqbUdGeWtTSElPK0E0NGg0Q011djJ4?=
 =?utf-8?B?Ym9GdEQycGtJU1IySFllaXNFYjJIVFVRSjFGc1I0emRzU2JyMUlkdkNDa3ZN?=
 =?utf-8?B?L2hxcThtS3ozeXY5YW9zSXdVQmxrN2pMWWp6cjJnNXlKWE05OFhxWVowd3du?=
 =?utf-8?B?VjhFTnNvSFErWEtmZW9PeHBMTjQxdUpEYjcyajQ0NGlqWWUvM0J2RkpBV0Yw?=
 =?utf-8?B?eisyczkvT2NCcnkwQmN5Ui9CTXM0dHFDVW4vS0FmVkdNK2lhRVlmd21wSGFE?=
 =?utf-8?B?Tjlrc0ZYMTU5OUl6dWFUMlQzWlBHVHpnZTZvbTJkZXM5NnNNMEM4VXpMbkh1?=
 =?utf-8?B?RHY0Ykt3MmtaVFRjeUJ3SHNDVFdXN2pZTGRPRmw1NFk3N21Ib0h4UlROUnd2?=
 =?utf-8?B?anVkbkZoNmxkQTdiR3dmeTNPZ3VsZUtnd0oyTW5PeXFtb1NRZFVVeGxlQWU0?=
 =?utf-8?B?cHdOQlVKend6TWtjaWxVVG92NGtEZ0prM3JoUzBVWW9MNGJLV0U5VEExZ09V?=
 =?utf-8?B?MGxaZHdIV1JYUU00cDlkQVNxVnIwNk1DWUloQnMwcGNYMElTTnc4ajV2eDVU?=
 =?utf-8?B?SUxXTkRIVWdpL2xLY0hKMUxzeFcreHNocjAzUkh1ek05M0M1b1hWM3d3a1RN?=
 =?utf-8?B?UEt0cExrNkN2YmZPbGF6bFVNZi9UY2tGcUlRemVVV1FCMHlORWwyazVFbTU4?=
 =?utf-8?B?Ujd0OUgwNmQ3Rm9YSUVUWUdvUXduNDZqRUE1Y3dXaG8wUlVqYnVRY2lIamRI?=
 =?utf-8?B?K1BPQm9CZDlKc05zMTVzWkE3K0JNSklOeFJYRUg4ZStEdlJKc3RvcDFUcnE4?=
 =?utf-8?B?MTdEdHlBZHJRNlAwTHlJMlM5Y202czNEOEw1T3JTNUxXN2dZeWFuNHJIY25w?=
 =?utf-8?B?VkVYQjQ5K0FmSFNPOWZHYjBTK1lyMVNkVkgyOXgvdUR0aldMTmRuczVCYkJO?=
 =?utf-8?Q?lxnZW/wKYyviH1eQ7SN0fryB0zbld3fC0Ge6ZVs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c9d540-2969-4164-e002-08d8fab63f41
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 17:46:32.6503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAjgdcCg+8u5K0dxErC12XqakaI94iOdp+KHhlrdcf1kdPuGibURpdVlJagD1OiItoGrLF+MMk94/tTTsJ/NgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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
Cc: Bindu.R@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-08 1:10 p.m., Aurabindo Pillai wrote:
> From: Joshua Aberback <joshua.aberback@amd.com>
> 
> [Why&How]
> Update SR Exit Latency to fix screen flickering caused due to OTG
> underflow. This is the recommended value given by the hardware IP team.
> 
> Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index a928c1d9a557..fc2dea243d1b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -164,7 +164,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
>   
>   		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
>   		.num_states = 1,
> -		.sr_exit_time_us = 12,
> +		.sr_exit_time_us = 15.5,
>   		.sr_enter_plus_exit_time_us = 20,
>   		.urgent_latency_us = 4.0,
>   		.urgent_latency_pixel_data_only_us = 4.0,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
