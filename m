Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1433CC4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 20:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B5E613F9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 20:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B5E613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C4F6E332;
	Fri,  4 Jun 2021 20:10:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE926E332
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 20:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET7FMPOtEZNC1Z73HZVngtnaUXJ58Qvm5P3OMWymDG8ChxZVazoJ4uN+6+djSmgLbQpZKLeCmxSbBohWvOpadcpMy9g4D3KRM2Rpm5/1d2LJRClWsHbp+9M32adInraJ5Hj2oTmCivNSSt7B4YLVFA+d8wo8iIewWk9MM0gc4YyqL8kHH/mKxluTKjKGAQvmVlPMC97DftRDn5zyptKT4Oih238DulSuBi+lc76jeUtARolS9lhr4m1ZjPl4cIsOF9UTCuULzp+D5vrRRHIU69fZTcIOAEsqd5EpQjPS68y0MqsoEcbUmF1ypwXlevFCRfUifM7mhXshlEjovJV+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px8yny32xeVxZfT52NfNz2wXC8y7W1V9y5goLsm4h1o=;
 b=Y9WtwgfdenAYP4082XamMGXGB9RpkOeoY3V2s0kh7QlWzh5oibOo6WGwMP+S+KiWa51pI0vyLl5ZjDD7QX0Zs8BysYkbQRMR8Udmm+1lM43nb1AVSmGV4MBwHq77zM/9+zQ071NNxFBROs/JD1HLdBgxGiZ3dFbXiT0FWRrVYks5WFvrlKPujpL4feggarK3NZvx8vd4PVq/0Ugp35XT/N+rkEceuxUk/N6f3DK2TaRDaU6GCaOYtb9M1d3V3m3Zs9Opsb1EFS6NS9IadrTaf/Jyae3h64G16Y/qVpDwjo3T0Waj46hw9gjv6jLS0g4V7UWgtMTgCqUnQ6N3Kl/Wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px8yny32xeVxZfT52NfNz2wXC8y7W1V9y5goLsm4h1o=;
 b=2llDCArDO+apEc+jpcP7cvb7M2Hm7Xuge+dPauIYgeebVV2J47n71ddwB2vfYCpkVrsmkb4JW9jMzakjLoQ8AEoReoX8vx0/e7QHbBEN7DHUXjXmW8vKrn+3YDF3APfm/SsQhRtKq9I9L9sN/wOrXMkf8wJWgNisy4o3DzO/3sc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 20:10:12 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753%3]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 20:10:12 +0000
Subject: Re: [PATCH] drm/amdgpu/dc: remove unused variables in
 dcn31_dio_link_encoder.c
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210604200731.1480447-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <922604e6-81f8-dcd3-4975-8d61b20dcf11@amd.com>
Date: Fri, 4 Jun 2021 16:10:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210604200731.1480447-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR0101CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0151.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27 via Frontend
 Transport; Fri, 4 Jun 2021 20:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6980042-27a8-412a-c647-08d92794c29c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5426C8C9237901B81F0EF0CD8C3B9@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBURtf7iEsKjr5ijYNhDTZ5myra4Q9HafGO34+QvTwLIXhK2T4zEDK+Hm4iHONrGfoFVLgqTcvBzH3B6wVKzn8L/lGeW9SPEKNSC02yb4qcf7TnC6iYA0nvmfd3D4N+D/laSFMPC1zUwtBw8wQW1AkCV1y1KTKy6x/9gt+XZwpgxxU4N8Id408Sy+2oTFM9r5HTFV7Pg7ZlGNAD7moKlo0i+DwA7kGnirTQqEO/mucspKEYAmPhugdfsoWUSB3rhsM68wH5Pno1k+DUmbyUPmg7Tj0Soo3LWAHeZeyJAplfwrm98Um5cpusZ4qrs/ZbMOmIwVMdc2tY9K8LrhtOsDwja3P7hpCs2slDjdopeqNJyloPnkXYTY8W778SUA3dsiJEPNBOhKjk3819ZT6BB0iBrJVhhEnQ6dJOzxwfiW3sjgaCGoJMB10az5XUjs6xIG72H1SdRRGCDkGcStlccjMowTM6qrm3XW5ron9P97SVLfM6sFObU0N9Ih1Ezwv6hwunVm6QsD4K260RvhpngEpZIujwMATSLQRwnPleM9zfYmnzQzVd6WxA7CrHNUN39afZMHSjo3aNRH6OlOaEl9Lt6FYhJpM3XskQWAe515H6yI7jn2rGpZnlumq+OKz2n4OVbHJ4Uc2YvBuzYxuYoQRosx1ZyJQiFv36t2JetMsZeB4nMx9R72blEjtfcPQHG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(956004)(16576012)(53546011)(316002)(66476007)(66556008)(44832011)(66946007)(2616005)(5660300002)(26005)(186003)(16526019)(478600001)(31686004)(8676002)(31696002)(6486002)(8936002)(86362001)(2906002)(38100700002)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3VWSkIyeCtqWjJkWitaKzZ2N0lpU1Vwckp0UzdYNkhpN2UyUmFCQlIxaXZk?=
 =?utf-8?B?c0xGU2dSWnlQTnhQOE1ZNVcyU2JQQWMzSENVMWxlc0hHVGF0T0xjQ0hlTDA2?=
 =?utf-8?B?UXBFNTVRSi9jbTk2ak9LeGxnRWZReHVaeUJwbFNsL2xPWURPWHBJZEpWbitq?=
 =?utf-8?B?TGdVR1hTNHQvb2EvK25jeWdEanVDRTNKZlZWSDlJcy9KSG03R1M0S01HYWdR?=
 =?utf-8?B?S24zTnYxTjd4VUlXdm53YjBWTWw4YnBiSDFDTVVxWEVMak9tbFFWaENBM3RD?=
 =?utf-8?B?bEFnN0Q3djFUbzcyaDBZekw1bjlYelR6RDA0UVhtRWl6YkNUSVRwWVFIdjRD?=
 =?utf-8?B?d0pPTlh1OGR4aTVWT3BMU3YrTlp4V0xselZLRjVwdUVBT1RVeHYySWRSajdp?=
 =?utf-8?B?TjVwMmMrbTV6czFRWUYwRVlaRTRCb2x6dk5VS1NRQTZVdW9HeGZzOEhSU0JS?=
 =?utf-8?B?RFd2TE5LU0dkUnpvcFZtWTFRKzlQYm9kUE5mRU1YbitXOHh1SlNFU0NSMnNW?=
 =?utf-8?B?RCtjbzNpVW1jeGw2Z2c1VFFpUzdUZkhITHJRMXA1UlRwNEJFb1EzVDFlNjZU?=
 =?utf-8?B?TGpNbWNtZk4vVlhHTk16UkVSTkwybE5ZdC9ldDFaa1R2Wm5ndXV1TjZDaFJs?=
 =?utf-8?B?K2VVU0h1VzJCaFozWUVJTlkvWWtScnd6TUhRYTNmMmlialZ1TU1JekkvUDBG?=
 =?utf-8?B?M0ZWc3pZVWVrdFlGektPQkRJL1RQaDZCWWlMeEczUHJML2ZpbHNqTlc4dldn?=
 =?utf-8?B?ei9jNGRZRGUrS1N0TTBtYzI1T1hla1ZmRlFZaHNOK1RMMytPYWMxeDR5SUlT?=
 =?utf-8?B?aEFnQnNFdC8rdUlrbTBNMlduNmpwU0JOU0w2Y1laQ3VROVYvY1RaSHRnM3du?=
 =?utf-8?B?K2FPQXNGdXhzQUUwcjVRMWZuWTJVZzMwdTlydk5KU0I4Ry90Vnp3aWRaTWUw?=
 =?utf-8?B?UjVOVms3TG1QWGJpQjNiaHlEbjZzVXhHb3VOd1ZzREpEa0pHeCtqVzhZM1Yy?=
 =?utf-8?B?bmNmNFEyU3ZnMHJya01VSGRvUWhPVVZRYW9qV1kyRFpIUTVzSTlxSGJVR25I?=
 =?utf-8?B?K3U3ZGFBcDB2RXJ6bVliQk11ZVlEbGRFRm13TTE2THdseTBOaldscTR4NHln?=
 =?utf-8?B?eTFEdUJDbk9jSkFyQldOeGsxK1RpM0RUUEpwQUhSbCs2Tjh4Q3lyd2EvK3JM?=
 =?utf-8?B?M1Fqd1d6bHdqWTFndmJiV3ZqUzAyYTdMYWN2MG9tdDFOV3pncElEKy9vbXhx?=
 =?utf-8?B?RHlpTGtCdFVaZUVLN3lmOHRPN3M4SlAvSjRyUlV3S3ZrOHYyRVVRVGlZK3BL?=
 =?utf-8?B?OEhqdWJySG96V002anMyVWRVSzBwb0ZUTW4wTTVMejNPaE9UcWRhbE91MDVq?=
 =?utf-8?B?NkJPK1NocWtTK3lYRDlVQTljSlp6RnFjbVgvY0JjUXFXcmN3V2Y3b2poYW9Q?=
 =?utf-8?B?MUNkNTQwYXhHUWEvcS9hMmp1aDFYZEFrUUNtcC9HUWpUZFZkY05ucytVblZk?=
 =?utf-8?B?UVdUaE5mWDlCQkZpM0JLZEZzQUVEdTBEdEtNZlNIbXFnZEdLYnU1Rjc2WWsy?=
 =?utf-8?B?M2FYZWVqbmhDZXNSWUYzWFV4L2JQSjJhZzN6UXJQUDUyQlpCakpINmtIeTA3?=
 =?utf-8?B?dUViUDRCODNZMjdHR3d1ekFmTmNDazBVdEFRVitSMHRILzFKcHloWFFjRHBT?=
 =?utf-8?B?SHE5bUxya1Rwcy84ZU9PNmoyU3I0YkM2V0JmRVQ3KzBnL3ovOEt2ZXVDT2xX?=
 =?utf-8?Q?YfnCTuRpeQbamBxYHmlQq5HBrWaflEvTmftKdYF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6980042-27a8-412a-c647-08d92794c29c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 20:10:12.4647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8D3inc2HFrnDGM7ZBLTlRvKzoErSaQbbxrKt6/M9NMgK0bs8oN5/+xjuDQvIaSQ2t13ZM3ZlUGuWDnyThOCjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-04 4:07 p.m., Alex Deucher wrote:
> Unused so remove them.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c   | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
> index b281a4ad152a..90127c1f9e35 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
> @@ -362,8 +362,6 @@ void dcn31_link_encoder_enable_dp_output(
>  	const struct dc_link_settings *link_settings,
>  	enum clock_source_id clock_source)
>  {
> -	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
> -
>  	/* Enable transmitter and encoder. */
>  	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
>  
> @@ -380,8 +378,6 @@ void dcn31_link_encoder_enable_dp_mst_output(
>  	const struct dc_link_settings *link_settings,
>  	enum clock_source_id clock_source)
>  {
> -	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
> -
>  	/* Enable transmitter and encoder. */
>  	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
>  
> @@ -397,8 +393,6 @@ void dcn31_link_encoder_disable_output(
>  	struct link_encoder *enc,
>  	enum signal_type signal)
>  {
> -	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
> -
>  	/* Disable transmitter and encoder. */
>  	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
