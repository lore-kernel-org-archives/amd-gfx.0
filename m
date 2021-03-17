Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A5C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 18:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8870D64EE1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 18:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8870D64EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA556E83F;
	Wed, 17 Mar 2021 18:40:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5106E83F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 18:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcoB612BGl1RSyDRofXIPwu3VpsHsd6CGd+kPiyNPb/Z4ICldKn8H7wkOyj/VF7adzRD13RmX6iJihatxhex+7iAKMg7giLbUJA3S+cK50yyW7/jXTVNlz5moosFaoFif5vbfi7/ICm10DCIiKB4m/9ZgMAQ6o59xOfpgCXSVcZUYNM7/H7Qyb5+8IOob7S23gQinSjC/5BeTO58YrzELLbi+CVwf0sxrehA+DkrFPp+M7p5/THa4hdeijsRdnNbwzO/dq6FJhJeihJPZU4VhtGS503B+D/qFfUtSY/M6mRPENRLCMoU0sVBJhRfVWDP1hY7C1/KQN2MKYbHgLmoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEjug7kaa7hr2ZvuZD6d2QiUTHh0Cv0T62qCwFYvx4E=;
 b=OwbrcFXEXBs6yBL9qc2zhQ750wqZ9ougNyT44P/qpNILSPV19r5kzmphcdezdj2jKeJjJbhyffg782Avzlp8IZx5oQGYYXHYoXmWWbyU6LV/8K2dtHAvYZtRfC44QKrms0d61ygTgUS+wENkr4Mv9Tn2umBOYhq7ZC897+AlTqGn3lAPIaYw4ZTJuyjLK3+0zAnffAMmV8CXCwSbHZKYbGSAVX3SLAXWRG3pzD+4vDcH7q3zXza8u64YxhNvSMva1UcmRN/iASpFXr1/tZiSGT7Jm2cXfUymEAGjBw71e4MlSYWyrcePpKI99jmNGoe3MgABQPu5fQz4MOEpwmEE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEjug7kaa7hr2ZvuZD6d2QiUTHh0Cv0T62qCwFYvx4E=;
 b=1K/otpPI31dbKB8YZhp8aXm7P/AUgg1VkmHM2AByaSmQ/fe20dYlY03MxcNzzpuwToTO92459xyIiWLflkZvRpsBv/EEaP9D69IcOH+a6OherCzdEzIVY9kfMWUCjgiVclgjN+mIWM/+5WEvSo7OVEHjQArePfnDNa1Z+ibt64M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1872.namprd12.prod.outlook.com (2603:10b6:300:10d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 18:39:56 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 18:39:56 +0000
Subject: Re: [PATCH] drm/amd/display: Add irq register entry for dmub
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20210317162105.845084-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <ce26de34-a5d4-3750-a7c8-0320c0497b56@amd.com>
Date: Wed, 17 Mar 2021 14:39:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210317162105.845084-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::39) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Wed, 17 Mar 2021 18:39:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 724b54a3-f847-4945-afb1-08d8e9740fb4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1872F3D1CE2BAB99CA24198D8C6A9@MWHPR12MB1872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLc5sGnh/9bI416u0IXQYgodRqmrt6iY7xb3haAIy7VET+0lPI+mfelA7C5um7lOV3z9RNgfKphj04yQESocNAlsPOfOUTSnEmmYgDKWemQ3IXx+xmm8QKHIdykc12QvQKXkXhbrP2/SRmr9zwKaVoKrT226cxfZNKWF27rsBkhQWJVeIHLIU58laAp6YqkldmLSJgUMSeZHigOH1BEjwnwr0yf9LJHCxObUTPkzMhne4gUeVRmK8fdqV1uGDXWDgbO5tr24hpnD3Bo9YSNhqYFnH1dNTySOIjdahRGF+vdunb6/KAnC40ss0LiEVzEPic4Qq+3vCCfQxJAxvo2Q0Ed0CaXgeyTUfXfr0gCMmvr6Xq/n2eTwtUUaVVWxJ+89EB5WS3I5yCMWaOH6ZDN65k24998FaKj8BDC4AZ0kEXJyzGxZP2o6j/IsvHFFS3+/+BPybyenjldxWBNjL/bvQ0eJBs1HKM4vkDLrsLbOS395o92ALpl3/UeSOk7lFMzt83JwE5QzZLvtSOIMcvalRSQPDwK+gWk7pfNhTrDkfM9ozZTi2U8c5N3uURPZJjcj9B3GAWiRV+FttTfxFNNPxrqt0aMHNfw+Nbb9u5VlSpQ3bO7RA/7xEolm9Fhg6bIMJ42m6DaaXgSIB9hFpJMUrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(31696002)(478600001)(86362001)(2906002)(83380400001)(44832011)(6486002)(956004)(2616005)(31686004)(6636002)(36756003)(16526019)(186003)(26005)(4326008)(54906003)(110136005)(16576012)(316002)(53546011)(8676002)(8936002)(66476007)(66556008)(66946007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0hMUnN6S1BPeTl3VWY3c0ZpMDhJT2hMRkp1TDBHeUlYSjQ4TGsrK1pyeDNL?=
 =?utf-8?B?M3ZKZ3ZEc1dhc08wSEZtRmtwa0dYaEl3bFMvZHBhaTlEcHZhazNvZDVyTGlH?=
 =?utf-8?B?QVZwKzJUeC9QakM4V3UzS2l2Tytrb0c4aUxoM05ZaGFZcGJvQnRVQ2xVTTV4?=
 =?utf-8?B?WXJ5TDdBZng0b1ZjN21yaUxXUkFFTHVEcWZhdW9oNHpZWTJOcFdQS0J2eVRu?=
 =?utf-8?B?UGw2bys4MW1wTlM0d0wzclZFRHZldkdFclFDY0pSRmpCRWprWUM2aDJjUzhU?=
 =?utf-8?B?aHp2QkIvd05PSXhYVmlCaXlKa3NKUGZOWE9DclZrNWloUWJOcEFPUU9SNm1i?=
 =?utf-8?B?WjR2NVY4UmYxSDU2WG50NDJ5bWF2amIvd3NwMm5KRnliUzcyc1pmMGVBK2VV?=
 =?utf-8?B?ZU1Gdzlwblh3WnByeXpaUDZSaWtTODFWSXVCYUYrYkdhNGVoS29mS1VjZW1X?=
 =?utf-8?B?MUZLS2d6OGhSblRZTUhrbUZ6N09xRUxOZGprMldEL2U3TGxjSmF0Q0Y2eWdV?=
 =?utf-8?B?ODRpbXFCdGdQMXBnTmlyK0J6NjF2MmVSZ0N5UVFOeDlKQTMwR2tLS1dLNmdz?=
 =?utf-8?B?UzN3NlMxR3RGa3g5NjUvMDZkdXBISUxaakdSTlF6UWNuMmFwbjJDbEUxdExL?=
 =?utf-8?B?ZEZkdlVWbXZiQUNJNzRSRUdiTUJIUndpWTJVaFBQUGR3TFRFTkg0WlI5eVdB?=
 =?utf-8?B?ZjhjaE90VUdiOVMzd3dFOXMrbEtXbEo2UVhidVFwMjdESktsTjNGakRDQWlJ?=
 =?utf-8?B?QmFrYTNybGozc0pPSmRuY28vMzJzRDN5cytKNG11WGFSNC9oR3hGL2xVcGVp?=
 =?utf-8?B?QkJqRnJQQUp5ZDR3ZktOenZ4cXdTWTRqSm43R040eHkzUk5zMnNYeENrZGtC?=
 =?utf-8?B?aFZmRDU0REY5UHlZTG5OYlI2UmZWb1BDMkdpVHE1emF3Y1RhdEE2U2srd204?=
 =?utf-8?B?QzlQOCtBRExTN09RUjltL2tuMVRoK05UK3lGdk52VDRMLy9FOXdsZG41bzZF?=
 =?utf-8?B?R3kvTCtNWHhEMnUvNkpLbFk1ai9Rb2lPQlVvdWRJUm1Jd1FNOTZrcytYZUlm?=
 =?utf-8?B?cjlDdjdSV3YwNENnUi84M2hPR0tTOWVTbVRMTXk2ZWhtbHpRaWIvQWp4RFRh?=
 =?utf-8?B?azRwZ21rR3JlKy9WdXR6UVlSTW0xamxWb0xCMWxEYVZNSnN4dE1mMFB4Z0VP?=
 =?utf-8?B?U09yVVRmUUUxNlJGY05oV0Jxb2E4blBEZjE2UDVHQ1dTVHJSUG1SamdnSTl3?=
 =?utf-8?B?OGNTVkU2dTBVWWhGdUNpamgwanYyRlZveTh1TTlSNmpiUGtpOWYrNDlKR1FP?=
 =?utf-8?B?Vy9jRXdxZWNSb3QzeFhWYzREamNack9mQmFYZmVINWRLN0dhb1JHU2Z3aGlv?=
 =?utf-8?B?M3VBUlJoVlhOR2owRkZhbXdNRFJHay9EcmRCUG5LemUramN5cmFUSUlzVmpN?=
 =?utf-8?B?UEJ4U0thUk52WEhybHloMmRiRS9IczJXMEpJOHdHcmwxZGo2Q2xxZVFtd2VI?=
 =?utf-8?B?bXRJOWVOUUlzWndIM1A3RXp1OFliaENWSHdFUko5UDZlblR1RXJxOCttSCtT?=
 =?utf-8?B?WmRCY0pTZGdvUUI2bWxmRHY3QUxNaHhpaDVxaUNWMnhFQ2hYQk9DYi9VK3B6?=
 =?utf-8?B?Zm5RQlcyRmhybHVZYkx6ejBaNGF3aU5EdkNYVzBMUlI2elhkMVVKUCtNTUFD?=
 =?utf-8?B?S1VScmZiRndUT0Q1bzBjMGl2YXNVN2lRUEFNZE9nbGZrck5iSWp5RDM5VFlF?=
 =?utf-8?Q?02ZRZK2zXRL0MTCWvIwpe8fE3XWv7l9txNatGkg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724b54a3-f847-4945-afb1-08d8e9740fb4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 18:39:56.3844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd1npDj6aXS5ScTScygV/D3gEhCem3B1jUUwKDl/8B7fzGHxCTTT8t8A6gTi1OHNjY0I8JIItwAQbQ+y40nXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1872
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
Cc: Solomon Chiu <solomon.chiu@amd.com>, amd-gfx@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-17 12:21 p.m., Rodrigo Siqueira wrote:
> DCN2.1 and DCN3.0 are missing some macros that register irq entries
> which cause compilation errors. This commit introduces those macros and
> fix the compilation error.
> 
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Solomon Chiu <solomon.chiu@amd.com>
> Fixes: 53e9c0f651421136 ("drm/amd/display: Support vertical interrupt 0 for all dcn ASIC")
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../display/dc/irq/dcn21/irq_service_dcn21.c   | 17 +++++++++++++++++
>   .../display/dc/irq/dcn30/irq_service_dcn30.c   | 18 ++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> index 48a3c360174e..bc1249a9858c 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> @@ -209,6 +209,23 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
>   	BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
>   			mm ## block ## id ## _ ## reg_name
>   
> +#define SRI_DMUB(reg_name)\
> +	BASE(mm ## reg_name ## _BASE_IDX) + \
> +			mm ## reg_name
> +
> +#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
> +	.enable_reg = SRI_DMUB(reg1),\
> +	.enable_mask = \
> +		reg1 ## __ ## mask1 ## _MASK,\
> +	.enable_value = {\
> +		reg1 ## __ ## mask1 ## _MASK,\
> +		~reg1 ## __ ## mask1 ## _MASK \
> +	},\
> +	.ack_reg = SRI_DMUB(reg2),\
> +	.ack_mask = \
> +		reg2 ## __ ## mask2 ## _MASK,\
> +	.ack_value = \
> +		reg2 ## __ ## mask2 ## _MASK \
>   
>   #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
>   	.enable_reg = SRI(reg1, block, reg_num),\
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> index 68f8f554c925..5af52ad49d7c 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> @@ -276,6 +276,24 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
>   		.funcs = &vblank_irq_info_funcs\
>   	}
>   
> +#define SRI_DMUB(reg_name)\
> +	BASE(mm ## reg_name ## _BASE_IDX) + \
> +			mm ## reg_name
> +
> +#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
> +	.enable_reg = SRI_DMUB(reg1),\
> +	.enable_mask = \
> +		reg1 ## __ ## mask1 ## _MASK,\
> +	.enable_value = {\
> +		reg1 ## __ ## mask1 ## _MASK,\
> +		~reg1 ## __ ## mask1 ## _MASK \
> +	},\
> +	.ack_reg = SRI_DMUB(reg2),\
> +	.ack_mask = \
> +		reg2 ## __ ## mask2 ## _MASK,\
> +	.ack_value = \
> +		reg2 ## __ ## mask2 ## _MASK \
> +
>   #define dmub_trace_int_entry()\
>   	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
>   		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
