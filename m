Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A9C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D6B606A5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D6B606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5577B6E196;
	Mon, 21 Jun 2021 14:46:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AFC6E18E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 14:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXYOcHdpK9gaZAgL0cVruuZGQjOgdbviXjUw/44y7JAzVOdOztLsp445PBOvPvtnkMB7Aa1ZmvNa6xczSyVoR0N+N59UszU9CGo09xszjXhZ1QkqnGOP9tIh6ZAY13RVHYQhBjbO5EyHmd+gTKL2lT+iwUq9HBortY01sAS4kR60MXvBYWkJr7QS1NHZh3mdZ36wstPWpiJMvStMBa6G8Sc1pVev0kBHmZFI6gGiiAQoIJVOhtT06Vg6TbE089+dj6bsv1HzYggr+phpqsIdsfpiiVSbE08Scw4CSX0UsfQEbWt+68IPztLjF0PkMCHx22A/iM3qQg6UbPlJKUeJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqO+fMfirkNyPlyzVj1CpPqOc0o4w3r5kMulWjoMK6A=;
 b=Pn48lV5V/N7z4y/8uoIif7eToU5W1dyRK/1/fRKBcXCRpNQd58xEcIXf4ukGyhW7iKGn0nHgi+cxys7x4W+Yc/g/JWo5Qizmpzk3rLOFLfaPG9DdfOLagFa9MNQ6C8D3i8TKz3x/w82wzaL8ZZSCLFjaqEJ6cN/yepmWYYxkv+dKZVuR3K/h5VhVBrvUscJ01uIHcddAqauyYqiKeayMGgtvoTHiFHuntgeaSET3+h01WwUVDCInb8HWmm6EwXxK6FFiVLU/DWLHQP/soX5n6lhwlowbRZhdzH7GmgG8gJapT3gW4Mli08IbsC+BfectoFnb3KxmUIhAFpwrCMypVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqO+fMfirkNyPlyzVj1CpPqOc0o4w3r5kMulWjoMK6A=;
 b=2fZtkyBNtGC9r8TJ6+RNMD4i1kPYIn5DofRIfqw1ydxyTEEbF2Hgn0ymuSemmHA1flzV3aq41eDWW/CKsKEs2K3bxNhSngU9vUZrbkAeuJPDgzN1FnURgN/no/uwMeIjJ/0exKDRtor0ZYI8Iv6gT+UMao0749HwEsM7I6emQck=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 14:46:36 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 14:46:36 +0000
Subject: Re: [PATCH 08/12] drm/amd/display: Fix edp_bootup_bl_level
 initialization issue
To: Bindu Ramamurthy <bindu.r@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210618190722.650921-8-bindu.r@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <48474d71-7d17-fc28-4f97-1398e2ad4091@amd.com>
Date: Mon, 21 Jun 2021 10:46:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210618190722.650921-8-bindu.r@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 14:46:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe18f59e-57b0-4b84-5ea3-08d934c35e91
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB53935D85C1B345E8B183BB4B8C0A9@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g32JR0YrWJdRzx7AqvXj7hpFPC8a97pRPgLbW9GOlhoIJc1W5uVNTHIE8hNyrKbFTduAk0wUAgpJABp8/BHk+OId0cla1f0GSn/qb23wdZfxAwRrQCqrAutAY5DCKU5ZNNfSfDR4vnfI9IlDydPNJHffqJ/srUQACeEdpLOpH/R17SWOsr+s3q/LHUMP/H+agCZJ3ycnGkI1Ha7uQrWHuWnsa0n0VZIFyD24DUNDATni+oID3fsxAS1mSK0fLNPxpBa1S6mDSpJ2TtwSP5qbuoZQF8Pt0M/Nd00T3LxSkq/iussZZs+4CVpjPtJ6rWQZuIXNNJhjVp24A/Y0SuvtVtxPFlnWherjcScoAZI6uiO9bnCsDKL+O1plDM4g5lXQPgq043crAfwecSJ3dgyeptGLvFNgOrM8qvAIhkXCYM1l8kgB2HcLa9psWvXSyWI8SVt2MZejyjGY7ctfEFuMJzOaFkLv3X4BUcllnRImRhGgIGQMWZEDiQblzCQvlIlpwOXQsZbfLx3p07R+RQJoG9DPPdnIB7bTFlU0hw3T0Epl0KLsgt3guqfPytGzJRylWZEGMRfl9AcMqlQXP2W2j6gdFmlLKciRnOYEUL/uK9N/KW+RJZW1B9Uw3qAA6vISTXhRFXrABRFV6MYzbnlSwnzqR9c9dYR3aY7jMdopOpJl9ozvaDeTCiGY7rtt6+yp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(2906002)(31686004)(8676002)(2616005)(44832011)(956004)(8936002)(5660300002)(31696002)(38100700002)(66556008)(66476007)(66946007)(316002)(86362001)(54906003)(16576012)(53546011)(16526019)(186003)(6486002)(36756003)(83380400001)(6666004)(478600001)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjF3VC9sVHErS0NpWWFKY3J2L1FkODhiUi9DREo4WUJoREN4bWpxbXAzbWc5?=
 =?utf-8?B?dDlzMEVTbjl5eVBiKzN3YVArYUpJek9NSVNhbS85a1F2RkprdXVmeU9EZ000?=
 =?utf-8?B?WEpGMEhSTnJtT2VBemVBdi9XQlgvSXJKT1U4bDlaNGNXeDN2cnBiLzJWWFJp?=
 =?utf-8?B?QjRjam14cm9uenhCZGtQYzJxbXJ1UmtGUDh0Nk9vbEo0Mi9VNnZuY3dnSTNF?=
 =?utf-8?B?SHZ2Qm9yMmlVZTlvWkhDaDNuc0JjYXJ0d1J6bmR1RWRRbmZiM1VoMDFsZklK?=
 =?utf-8?B?Yndsc2VQTC9LSFJoSi9mNjZoWFJSSDFWSituTUtCTmhXYmNuNS9EeWVTUFRG?=
 =?utf-8?B?NlZUVitvN01HVksrd3RUMmNFS29lR0VldkNKZURxL0NHZlJaYzdaYWhnb3Iz?=
 =?utf-8?B?OFYyZzJBRjFMUVA5d2hSUVo5b1J3L2xzMGNUaUZvYmMxNStLTlVxTDQzS3BD?=
 =?utf-8?B?ZlBVTVNwMUcvTGNiSXl2RTd1ZnRydHUvWnFVZzVxcHpTSnBaNmJnY0FoRWxu?=
 =?utf-8?B?dzVKRTVvbjE1NldQTm9YVVlhcW4vTll6L3F3UlRhN1JPUVdyUm1YbUhHRTc0?=
 =?utf-8?B?V3doOEo2bWd1SURVbHFqY3BXZnhKNldENjkwTFg5VFNTTDlxM2t3UzNrMzN0?=
 =?utf-8?B?bVNJbWNDSExVN0ZRWkxZbTEySzc3NCtEN2VQSUJQNG9zM1RqTFVIVjFDRUFR?=
 =?utf-8?B?M3ZiOEFlV3NkZks2TW14L2MzR3F4YkxtczlKK09weGpYeUFmU1VRNE5penNI?=
 =?utf-8?B?aUJPKzg4NVNmUDVweElJNVM2U3lOYitjeG9KUmFIU0Q0VGxreHZJcGtQVG5P?=
 =?utf-8?B?bjdFakhPQkRvZ0hNSElNT25zTSt5bWZGU2xBWFhjTHB6NUV4b2tadlJtYmFN?=
 =?utf-8?B?UWErQWxBWU5pRW8ySW0xQ0M2K1Z5YWtTTGJINmFSMGdkMHdVN3RQSWZiS1Rs?=
 =?utf-8?B?SWJmVWcyaUY1bmdibCs1c0tIdUNxSGhDUnUxdmpyMU9mK0txckE2MXJRbUd6?=
 =?utf-8?B?UTk0YlNXeUYwNkdUakNlWXROQzc5YWJ1Ukd2ZERYSE9BMkNpVU4vZ293UjY4?=
 =?utf-8?B?L24raGlrdTA1ZlgxMFJLbitqWTF2cklIZWNLalVLdGNlSmMrSkJCVWFBMzVO?=
 =?utf-8?B?M1VCb2FXQU9RRUFyVFY5NFJTTHRnMmNXV3Z5VjVJbVJTTFhkOGZ2WktaWDlm?=
 =?utf-8?B?cFN3eDF4M2xtbWZaWXc0MFFYbC9HU3BLeEFhbHJwZXhSWWYzTzVZbjRkZEIy?=
 =?utf-8?B?VjJ6OFFlTGdiUzFQaDlmbVEza01xb1JxRUNxODBrZmJlbHc3T2VqWmdybCtZ?=
 =?utf-8?B?L3FCdi9JVGJGRzM1OGUxKzN5cDhzY2lIMUUwZUhDVkUxMTlNWlJEc3lwd3lY?=
 =?utf-8?B?c1U3dXF4aGRpSDA4S3lPK1c2aGkvcnRLZDZjUTJPNzlsd1pPb3NzdUJJbVFK?=
 =?utf-8?B?MjYrN0R3V3lFcHIvdnRmcGwrT3hOd3RNT3djdzRhdS9JdmN5djR5K3V1TGhs?=
 =?utf-8?B?WWQ2aE1SaTBzV09nTnRsYkVlSVVuc2ZIdDRyQVRtZFl3a1ZvQTFJZ0ozSGM2?=
 =?utf-8?B?cUl1S3llSlVKREpzTW9URkg0b2FCWVFuc3VhVExRK0FFVHkxb2I2YVZrdnB5?=
 =?utf-8?B?NVdqZ29HMS9LRWo5cHBiSXNqWHJ6dGVOMTVqMFNMRmJCVHhiTllYeERHdXVN?=
 =?utf-8?B?TmFld2luaXE0bEx0cUh6bHN3eElQVzE2dW1DNTQyRzVCNWpOVUd6MmZmZTl2?=
 =?utf-8?Q?SjDO2O6ZW7zDRsSropUUw9zXHq3/ODl7woXqQpH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe18f59e-57b0-4b84-5ea3-08d934c35e91
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 14:46:36.1509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFBaTI/r7DZSj8rbVkAGo1GdGnbvHBRAlwLV7jA3KQ/Wra9dMURciA+7IrgEtTfyl312Z/mUwfWDu6oJO0LaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
Cc: Logush Oliver <ollogush@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-06-18 3:07 p.m., Bindu Ramamurthy wrote:
> From: Logush Oliver <ollogush@amd.com>
> 
> [why]
> Updating the file to fix the missing line
> 
> Signed-off-by: Logush Oliver <ollogush@amd.com>
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 7d1c1b76d8d0..840d7aca17cf 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -2140,7 +2140,7 @@ static enum bp_result get_integrated_info_v2_1(
>  		info_v2_1->edp1_info.edp_pwr_down_bloff_to_vary_bloff;
>  	info->edp1_info.edp_panel_bpc =
>  		info_v2_1->edp1_info.edp_panel_bpc;
> -	info->edp1_info.edp_bootup_bl_level =
> +	info->edp1_info.edp_bootup_bl_level = info_v2_1->edp1_info.edp_bootup_bl_level;
>  

This hints at a previous patch not building successfully. Please ensure
all patches in the series are building. It can be easily checked
with 'git rebase -i --exec make'.

Make sure this gets squashed with the faulty patch before merging.

Thanks,
Harry

>  	info->edp2_info.edp_backlight_pwm_hz =
>  	le16_to_cpu(info_v2_1->edp2_info.edp_backlight_pwm_hz);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
