Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409C9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 07:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0113160EB4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 07:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0113160EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645438808E;
	Mon, 20 Sep 2021 07:36:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791B46E402
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Sep 2021 07:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgCDLEheSrKgDFnzdARGyM2ZluFlKGS2KhmXjdeFgl8324syrmlWvHHJdfOy+OyKtppLyKigr8LmP8cIq2m5x7ruDf0L0SU6TSFmqsEdZ/bvE4fRCIU7KcQ1IfVoFzcoUaOIKFNS5Cfs3g1NCYOktopj47Ze5RZimtuJUC0FEHAKpy/6CPgT/Wzsz1c5CyS2T/JUPlEFGOk53RJu4ukgZ5YIwKKn7OIsJ42TICQQvNP5q084JJugYF8BC13riZxzib3cIprkmJl5Dc/rX+Ru3MbVBwWCesdxDwoNfYBFSQRkVww7MSqz2qkgGV7ie8nwwWhQU3Smc8pTbMRRgosIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Puj0cQsvu4PhKO0+56CFrzc7AJqFu1dexggOq0u7G4w=;
 b=Q/ON2uuBxh1ta3wSzYyP+sU+1MapBb7u57LkEbTXVd4ykjO+gSKTJfJBPiginQyM+3BPqwWw5iRyOLvfA94YW7z9auzS5V+Th1RlTHym6s193GuYkMup2YSYFnKwPLw0UrJbEwpFjQdKTL744SnPgcoB9c9EcoQPMsQwjIaChUoT8Re9UmAEtXlH9FqQ3dh1q3VU8T+DRZpu6cXPGyvMzNlcZm7agO/LUPBLcCHhJ8p2XHCBoByr3O4jfXeRpdeJKXi6X4we1/u/BOzfXIqnLEdUVpIdgkoin19mUts+E6S1glq8CPrfCQgA7NzJ4R3DytxBjBZHesiqelxh7Ad7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Puj0cQsvu4PhKO0+56CFrzc7AJqFu1dexggOq0u7G4w=;
 b=jLTMu1rpjhbYtkuwYLyEdE8Aqt7mKhsrE/x2elhf4urYqxuiSvu74ALmx8aDkwXSjHElHBJ1xOHK0RnGJFhOBdNkd0ulOptMf7Es6A73qS1qroPH54RZisaZPUITx0dyj5gPBKbVGs/sj//ul3rJzJ/3/BcHdrcUiU2dyTLBY/k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4606.namprd12.prod.outlook.com (2603:10b6:208:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 07:36:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 07:36:25 +0000
Subject: Re: [PATCH] drm/amd/display: move FPU associated DSC code to DML
 folder
To: Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Anson Jacob <Anson.Jacob@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20210907143235.4309-1-qingqing.zhuo@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <42468bcc-0286-381e-0d63-0aa8d16ede76@amd.com>
Date: Mon, 20 Sep 2021 09:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907143235.4309-1-qingqing.zhuo@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:208:be::43) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR04CA0102.eurprd04.prod.outlook.com (2603:10a6:208:be::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 07:36:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c2bd39c-ea84-41e9-73a4-08d97c0959b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4606:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4606155E92C7DD0D9580474E83A09@MN2PR12MB4606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIUp4p8dn0ElvgRX3bT5Zc72yGP3kn2sQBhEBaCjoglwzV5lmQFQEZ6Mx0CK180kUlHeihNh42fj/R7w79xwRdaM/y/YLQeQoe//8BtbcTpe23EX4sk06J9DXir1U2AaDvwUh/Pb7vS+PZArnm73WULX2P62+uCs8WdzqQO0FPxdKqLqyOk2bXfGgouEnh0bKd8aUnptPsU7I9sEjhBHkApYN17pWLEyfde7wrezyXNgq/e7saQXHebGw6tqFfe6Fc0XHw2a47djHCdetPOvnSEOCcn+1g+q6p2KOLGI4xO9My2ETmEiEH8KOiy5xVDEHlnIlAuJ/aP6lV+gK0eWe5ByZCwI+EmtYsGu5g3jpYmNM3hejKdsrM8HpsTnnIPABw9mt5PZ7QpockjCXyQ86hqNwvXW1efOqALndnkVLe9PDVBg80DprZ2HLvcMMVCWtgNDwo17O202gSx1DkmkiofAv3HIC7HYbqtKpCzORJHdDpnl1vFPKCKT3+f4c7okrqNrASqF6ie+nLxi4rTxCOmpQRBEQAvEhWYNipTC4V0520zV29SYmbxpZs3F/lKGLKm64QCj9bn6gsxk9rwyzxwFUjLExK7YGo2XtT4qsqYWyKUtui51d4FrLimrZ0lFisAIHtS47A5Bh6tHB/n/TaUaD96BXFU1z94EOYZ+bTphPyx2YxZuEfh0+jsPcItkhuey0tdPWvlNzxNnKV8Noc2z5gYxSC2WUVbPi19ILRSfa0sq6uLp0OaVGixn80A9M0yFPievxzsaQnD0oxiPjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(31696002)(38100700002)(83380400001)(66476007)(31686004)(6666004)(186003)(66946007)(66556008)(956004)(26005)(966005)(6486002)(5660300002)(54906003)(16576012)(30864003)(316002)(86362001)(36756003)(4326008)(2616005)(8936002)(8676002)(2906002)(478600001)(66574015)(461764006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhMVHdmaWVnWnpBbGh2cmFWWmhTZk1BSDRkNTlBaCtEeElna1l5dkRQalcx?=
 =?utf-8?B?VmpIcVZsOVU4SkovNmNpYjljbW9pTEwrSDBDUGw5dzVpSEs4Zjh3bW1zb3Ez?=
 =?utf-8?B?Sk5TTUM1ODBkd2tpR2llTjlYL0NjN2w5cHZTRXFCdDhCUERUSDFuL0Z1cFQy?=
 =?utf-8?B?em84V1VZdXA2bDFYbXFXS1F4TDEvTjFMdlJndTY1NXVSVzB4MDBsN29YV0JT?=
 =?utf-8?B?ZUpBOHczQVNaZjJBM3lvK2Z4ZjRXUWJxNHRCaStMZkhpOUY3WitiQ0JuVmJO?=
 =?utf-8?B?enVxU2tHdUNXcjBibjlRVWYrNG5WTnN3ZXY0TGtvam9tWlBibmJyNWRjSXlJ?=
 =?utf-8?B?QUV4dVh3WnVvdUpCS2Y4dkN3dEJuSDNGcWpBUEV1dGw4VWV3dGZ2T0htUXk3?=
 =?utf-8?B?MUVSQTczaHRNQjArQUx6M1hURkxjQ0ZCRjRJMUxWQnJvQ3dnb2M3bW10UkZN?=
 =?utf-8?B?aGN2RzlOb3czd3BMT1BaNGM3Q01BSm9iWkdiRTJBYm1EVFpqVk9KV3ZydWRL?=
 =?utf-8?B?VGdDOGh2L1BaRHlPNzF0M0o5dWd0ZWJLNmppaTl3Nkc3RWl2MjVrbVUycjhw?=
 =?utf-8?B?R3JnQjBNeGRVTHVqWXR1MWZmRkFJeGNCVG1yNmVlZW9XTW1kK0o0SjdxRE96?=
 =?utf-8?B?dW4vWFJPc09RL1lnaHp2ODBNU0dYanpUZUljNWUzaHhUb1pMNGJhS2NKR1JT?=
 =?utf-8?B?RjZxYS8ySWhqRHhqTXh0Wit4QUVvUy8wQ3h4cm1kOHBaQk9MemJ1V0tucjdh?=
 =?utf-8?B?ZFlUbk9jTVlaYmQyY05VY01YR3dsY0EwY2xaL1pteXBIQTRRQ0NVeFZJSzlK?=
 =?utf-8?B?cmJIeHErNGJsdE4rSHZlMlluNUVSeEhwM21ZU2FVRkRlM1g4WDhpcnROR0hw?=
 =?utf-8?B?TzM2T2gyMjNtMG1ybTQ4OUVscm5OWE1Talp5Yy9mMjlkeEJaS2pyOE9CSGVq?=
 =?utf-8?B?YWZnVkwvd0M1dVVjU0g2UHRzZ09vZ0NMdGxWSlliSFRGUEpMNk9zYmg1c0Ur?=
 =?utf-8?B?K2xFbXpMckdGZkR2MGJUUmYxM0Rjc1Q1WENaTkF3Q0VjT0FOTHBHdHg3Wm00?=
 =?utf-8?B?VVlkMmtqMmdxNDZCUXp5Q3hpbzZ1Sjg4YUpTMjVuSXQrOFF4L25sS0lsem5u?=
 =?utf-8?B?bjc2V1pLbTBPNW1UeHA0Wkl0aFVCRmxmcGJWeVBORTZmcDRidjFESmpQekZL?=
 =?utf-8?B?U1RjWitBN2pqZGxNOWl3TkVnLzdZeWl3SkRWa3VGd0czSG5HaWt6eGZKQ2M5?=
 =?utf-8?B?Ym1sSkFjcEVycUg2ZmVlTS93Nm9IWTNTTEhnTmFaR2tESDgyZ0tlZDJaWXNB?=
 =?utf-8?B?M0xiY1hpWDg3NnV0NUVleDN0ejRLZTFLTWF6MlAybnJMNC9pSFR3d25SR2F4?=
 =?utf-8?B?OUIzY2FHaTNicUthdXNOY1hNay91MmlSblRtTW9lL3QzeFNJZUU4MzFVaXVS?=
 =?utf-8?B?UHVBNzAvb1h6elhPek93c2xSYlpWN1FMRENhb0g2d3Fhb0hLNVJjZllnNmVZ?=
 =?utf-8?B?MHFkcnJ2NFVVMXhYWnEwWElMVjVyTW9Ld2d4UmpzRTR0eGp6OVRiRHV0Z3Jt?=
 =?utf-8?B?TFRQbnViSDE5dGxtMnpPaU4rZVNLT1ZNc0g3ZTVvWmJKOHpKQjc2R3p5OHZ6?=
 =?utf-8?B?VHpTZGw3bVd2dDNYWXBrQUtqZk1aVXNrcTViWGpJNGIweHNkYzJ5SmQ2V2VR?=
 =?utf-8?B?UFRRVXczTzBJQTVyR0QzZUZQY0toeEdnTXZrQktJeGxyeWlEaFZsditBclVa?=
 =?utf-8?Q?sFAWFuywyVJPOv/pw8Jz3JVALXEBYZKH7Mq8Oqy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2bd39c-ea84-41e9-73a4-08d97c0959b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 07:36:25.4954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSWmDIcv3uPum+wQCyj2JLMY2lAMAfTgU9MwJtFTYB9HAtTfpvBdk94WSuExzWSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4606
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

Feel free to add an Acked-by: Christian König <christian.koenig@amd.com>

Am 07.09.21 um 16:32 schrieb Qingqing Zhuo:
> As part of the FPU isolation work documented in
> https://patchwork.freedesktop.org/series/93042/, isolate
> code that uses FPU in DSC to DML, where all FPU code
> should locate.
>
> This change does not refactor any fuctions but move code
> around.
>
> Cc: Anson Jacob <Anson.Jacob@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
>   .../amd/display/dc/{ => dml}/dsc/qp_tables.h  |   0
>   .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 287 ++++++++++++++++++
>   .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  89 ++++++
>   drivers/gpu/drm/amd/display/dc/dsc/Makefile   |   8 -
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 257 ----------------
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  50 +--
>   .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   1 -
>   8 files changed, 380 insertions(+), 315 deletions(-)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/dsc/qp_tables.h (100%)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 56055df2e8d2..9009b92490f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
> @@ -84,6 +85,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcfla
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
>   endif
>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
> @@ -99,6 +101,7 @@ DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
>   DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
>   DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
>   DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
> +DML += dsc/rc_calc_fpu.o
>   endif
>   
>   AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h
> rename to drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> new file mode 100644
> index 000000000000..0436fc64948f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -0,0 +1,287 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "rc_calc_fpu.h"
> +
> +#include "qp_tables.h"
> +#include "amdgpu_dm/dc_fpu.h"
> +
> +#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
> +
> +#define MODE_SELECT(val444, val422, val420) \
> +	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
> +
> +
> +#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
> +	table = qp_table_##mode##_##bpc##bpc_##max; \
> +	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
> +	break
> +
> +static int median3(int a, int b, int c)
> +{
> +	if (a > b)
> +		swap(a, b);
> +	if (b > c)
> +		swap(b, c);
> +	if (a > b)
> +		swap(b, c);
> +
> +	return b;
> +}
> +
> +static double dsc_roundf(double num)
> +{
> +	if (num < 0.0)
> +		num = num - 0.5;
> +	else
> +		num = num + 0.5;
> +
> +	return (int)(num);
> +}
> +
> +static double dsc_ceil(double num)
> +{
> +	double retval = (int)num;
> +
> +	if (retval != num && num > 0)
> +		retval = num + 1;
> +
> +	return (int)retval;
> +}
> +
> +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
> +		       enum max_min max_min, float bpp)
> +{
> +	int mode = MODE_SELECT(444, 422, 420);
> +	int sel = table_hash(mode, bpc, max_min);
> +	int table_size = 0;
> +	int index;
> +	const struct qp_entry *table = 0L;
> +
> +	// alias enum
> +	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> +	switch (sel) {
> +		TABLE_CASE(444,  8, max);
> +		TABLE_CASE(444,  8, min);
> +		TABLE_CASE(444, 10, max);
> +		TABLE_CASE(444, 10, min);
> +		TABLE_CASE(444, 12, max);
> +		TABLE_CASE(444, 12, min);
> +		TABLE_CASE(422,  8, max);
> +		TABLE_CASE(422,  8, min);
> +		TABLE_CASE(422, 10, max);
> +		TABLE_CASE(422, 10, min);
> +		TABLE_CASE(422, 12, max);
> +		TABLE_CASE(422, 12, min);
> +		TABLE_CASE(420,  8, max);
> +		TABLE_CASE(420,  8, min);
> +		TABLE_CASE(420, 10, max);
> +		TABLE_CASE(420, 10, min);
> +		TABLE_CASE(420, 12, max);
> +		TABLE_CASE(420, 12, min);
> +	}
> +
> +	if (table == 0)
> +		return;
> +
> +	index = (bpp - table[0].bpp) * 2;
> +
> +	/* requested size is bigger than the table */
> +	if (index >= table_size) {
> +		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
> +		return;
> +	}
> +
> +	memcpy(qps, table[index].qps, sizeof(qp_set));
> +}
> +
> +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> +{
> +	int   *p = ofs;
> +
> +	if (mode == CM_444 || mode == CM_RGB) {
> +		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	} else if (mode == CM_422) {
> +		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> +		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> +		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	} else {
> +		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> +		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> +		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	}
> +}
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +			       enum bits_per_comp bpc, u16 drm_bpp,
> +			       bool is_navite_422_or_420,
> +			       int slice_width, int slice_height,
> +			       int minor_version)
> +{
> +	float bpp;
> +	float bpp_group;
> +	float initial_xmit_delay_factor;
> +	int padding_pixels;
> +	int i;
> +
> +	dc_assert_fp_enabled();
> +
> +	bpp = ((float)drm_bpp / 16.0);
> +	/* in native_422 or native_420 modes, the bits_per_pixel is double the
> +	 * target bpp (the latter is what calc_rc_params expects)
> +	 */
> +	if (is_navite_422_or_420)
> +		bpp /= 2.0;
> +
> +	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +
> +	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> +
> +	switch (cm) {
> +	case CM_420:
> +		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
> +		break;
> +	case CM_422:
> +		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = 0;
> +		break;
> +	case CM_444:
> +	case CM_RGB:
> +		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = 0;
> +		break;
> +	}
> +
> +	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
> +	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
> +
> +	if (cm == CM_422 || cm == CM_420)
> +		slice_width /= 2;
> +
> +	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> +	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
> +		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
> +			rc->initial_xmit_delay++;
> +	}
> +
> +	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->flatness_det_thresh = 2 << (bpc - 8);
> +
> +	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> +	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> +	if (cm == CM_444 && minor_version == 1) {
> +		for (i = 0; i < QP_SET_SIZE; ++i) {
> +			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
> +			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
> +		}
> +	}
> +	get_ofs_set(rc->ofs, cm, bpp);
> +
> +	/* fixed parameters */
> +	rc->rc_model_size    = 8192;
> +	rc->rc_edge_factor   = 6;
> +	rc->rc_tgt_offset_hi = 3;
> +	rc->rc_tgt_offset_lo = 3;
> +
> +	rc->rc_buf_thresh[0] = 896;
> +	rc->rc_buf_thresh[1] = 1792;
> +	rc->rc_buf_thresh[2] = 2688;
> +	rc->rc_buf_thresh[3] = 3584;
> +	rc->rc_buf_thresh[4] = 4480;
> +	rc->rc_buf_thresh[5] = 5376;
> +	rc->rc_buf_thresh[6] = 6272;
> +	rc->rc_buf_thresh[7] = 6720;
> +	rc->rc_buf_thresh[8] = 7168;
> +	rc->rc_buf_thresh[9] = 7616;
> +	rc->rc_buf_thresh[10] = 7744;
> +	rc->rc_buf_thresh[11] = 7872;
> +	rc->rc_buf_thresh[12] = 8000;
> +	rc->rc_buf_thresh[13] = 8064;
> +}
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +				    bool is_navite_422_or_420)
> +{
> +	float bpp;
> +	u32 bytes_per_pixel;
> +	double d_bytes_per_pixel;
> +
> +	dc_assert_fp_enabled();
> +
> +	bpp = ((float)drm_bpp / 16.0);
> +	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
> +	// TODO: Make sure the formula for calculating this is precise (ceiling
> +	// vs. floor, and at what point they should be applied)
> +	if (is_navite_422_or_420)
> +		d_bytes_per_pixel /= 2;
> +
> +	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> +
> +	return bytes_per_pixel;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> new file mode 100644
> index 000000000000..d3900ff7fa89
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __RC_CALC_FPU_H__
> +#define __RC_CALC_FPU_H__
> +
> +#include "os_types.h"
> +
> +#define QP_SET_SIZE 15
> +
> +typedef int qp_set[QP_SET_SIZE];
> +
> +struct rc_params {
> +	int      rc_quant_incr_limit0;
> +	int      rc_quant_incr_limit1;
> +	int      initial_fullness_offset;
> +	int      initial_xmit_delay;
> +	int      first_line_bpg_offset;
> +	int      second_line_bpg_offset;
> +	int      flatness_min_qp;
> +	int      flatness_max_qp;
> +	int      flatness_det_thresh;
> +	qp_set   qp_min;
> +	qp_set   qp_max;
> +	qp_set   ofs;
> +	int      rc_model_size;
> +	int      rc_edge_factor;
> +	int      rc_tgt_offset_hi;
> +	int      rc_tgt_offset_lo;
> +	int      rc_buf_thresh[QP_SET_SIZE - 1];
> +};
> +
> +enum colour_mode {
> +	CM_RGB,   /* 444 RGB */
> +	CM_444,   /* 444 YUV or simple 422 */
> +	CM_422,   /* native 422 */
> +	CM_420    /* native 420 */
> +};
> +
> +enum bits_per_comp {
> +	BPC_8  =  8,
> +	BPC_10 = 10,
> +	BPC_12 = 12
> +};
> +
> +enum max_min {
> +	DAL_MM_MIN = 0,
> +	DAL_MM_MAX = 1
> +};
> +
> +struct qp_entry {
> +	float         bpp;
> +	const qp_set  qps;
> +};
> +
> +typedef struct qp_entry qp_table[];
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +				    bool is_navite_422_or_420);
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +			       enum bits_per_comp bpc, u16 drm_bpp,
> +			       bool is_navite_422_or_420,
> +			       int slice_width, int slice_height,
> +			       int minor_version);
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index 8d31eb75c6a6..8d01b8a9fc6a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -2,14 +2,6 @@
>   #
>   # Makefile for the 'dsc' sub-component of DAL.
>   
> -ifdef CONFIG_X86
> -dsc_ccflags := -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dsc_ccflags := -mhard-float -maltivec
> -endif
> -
>   ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> index 7b294f637881..87acec33b8d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> @@ -25,264 +25,7 @@
>    */
>   #include <drm/drm_dsc.h>
>   
> -#include "os_types.h"
>   #include "rc_calc.h"
> -#include "qp_tables.h"
> -
> -#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
> -
> -#define MODE_SELECT(val444, val422, val420) \
> -	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
> -
> -
> -#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
> -	table = qp_table_##mode##_##bpc##bpc_##max; \
> -	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
> -	break
> -
> -
> -static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
> -		       enum max_min max_min, float bpp)
> -{
> -	int mode = MODE_SELECT(444, 422, 420);
> -	int sel = table_hash(mode, bpc, max_min);
> -	int table_size = 0;
> -	int index;
> -	const struct qp_entry *table = 0L;
> -
> -	// alias enum
> -	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> -	switch (sel) {
> -		TABLE_CASE(444,  8, max);
> -		TABLE_CASE(444,  8, min);
> -		TABLE_CASE(444, 10, max);
> -		TABLE_CASE(444, 10, min);
> -		TABLE_CASE(444, 12, max);
> -		TABLE_CASE(444, 12, min);
> -		TABLE_CASE(422,  8, max);
> -		TABLE_CASE(422,  8, min);
> -		TABLE_CASE(422, 10, max);
> -		TABLE_CASE(422, 10, min);
> -		TABLE_CASE(422, 12, max);
> -		TABLE_CASE(422, 12, min);
> -		TABLE_CASE(420,  8, max);
> -		TABLE_CASE(420,  8, min);
> -		TABLE_CASE(420, 10, max);
> -		TABLE_CASE(420, 10, min);
> -		TABLE_CASE(420, 12, max);
> -		TABLE_CASE(420, 12, min);
> -	}
> -
> -	if (table == 0)
> -		return;
> -
> -	index = (bpp - table[0].bpp) * 2;
> -
> -	/* requested size is bigger than the table */
> -	if (index >= table_size) {
> -		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
> -		return;
> -	}
> -
> -	memcpy(qps, table[index].qps, sizeof(qp_set));
> -}
> -
> -static double dsc_roundf(double num)
> -{
> -	if (num < 0.0)
> -		num = num - 0.5;
> -	else
> -		num = num + 0.5;
> -
> -	return (int)(num);
> -}
> -
> -static double dsc_ceil(double num)
> -{
> -	double retval = (int)num;
> -
> -	if (retval != num && num > 0)
> -		retval = num + 1;
> -
> -	return (int)retval;
> -}
> -
> -static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> -{
> -	int   *p = ofs;
> -
> -	if (mode == CM_444 || mode == CM_RGB) {
> -		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	} else if (mode == CM_422) {
> -		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> -		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> -		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	} else {
> -		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> -		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> -		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	}
> -}
> -
> -static int median3(int a, int b, int c)
> -{
> -	if (a > b)
> -		swap(a, b);
> -	if (b > c)
> -		swap(b, c);
> -	if (a > b)
> -		swap(b, c);
> -
> -	return b;
> -}
> -
> -static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> -			       enum bits_per_comp bpc, u16 drm_bpp,
> -			       bool is_navite_422_or_420,
> -			       int slice_width, int slice_height,
> -			       int minor_version)
> -{
> -	float bpp;
> -	float bpp_group;
> -	float initial_xmit_delay_factor;
> -	int padding_pixels;
> -	int i;
> -
> -	bpp = ((float)drm_bpp / 16.0);
> -	/* in native_422 or native_420 modes, the bits_per_pixel is double the
> -	 * target bpp (the latter is what calc_rc_params expects)
> -	 */
> -	if (is_navite_422_or_420)
> -		bpp /= 2.0;
> -
> -	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -
> -	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> -
> -	switch (cm) {
> -	case CM_420:
> -		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
> -		break;
> -	case CM_422:
> -		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = 0;
> -		break;
> -	case CM_444:
> -	case CM_RGB:
> -		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = 0;
> -		break;
> -	}
> -
> -	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
> -	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
> -
> -	if (cm == CM_422 || cm == CM_420)
> -		slice_width /= 2;
> -
> -	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> -	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
> -		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
> -			rc->initial_xmit_delay++;
> -	}
> -
> -	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->flatness_det_thresh = 2 << (bpc - 8);
> -
> -	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> -	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> -	if (cm == CM_444 && minor_version == 1) {
> -		for (i = 0; i < QP_SET_SIZE; ++i) {
> -			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
> -			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
> -		}
> -	}
> -	get_ofs_set(rc->ofs, cm, bpp);
> -
> -	/* fixed parameters */
> -	rc->rc_model_size    = 8192;
> -	rc->rc_edge_factor   = 6;
> -	rc->rc_tgt_offset_hi = 3;
> -	rc->rc_tgt_offset_lo = 3;
> -
> -	rc->rc_buf_thresh[0] = 896;
> -	rc->rc_buf_thresh[1] = 1792;
> -	rc->rc_buf_thresh[2] = 2688;
> -	rc->rc_buf_thresh[3] = 3584;
> -	rc->rc_buf_thresh[4] = 4480;
> -	rc->rc_buf_thresh[5] = 5376;
> -	rc->rc_buf_thresh[6] = 6272;
> -	rc->rc_buf_thresh[7] = 6720;
> -	rc->rc_buf_thresh[8] = 7168;
> -	rc->rc_buf_thresh[9] = 7616;
> -	rc->rc_buf_thresh[10] = 7744;
> -	rc->rc_buf_thresh[11] = 7872;
> -	rc->rc_buf_thresh[12] = 8000;
> -	rc->rc_buf_thresh[13] = 8064;
> -}
> -
> -static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> -				    bool is_navite_422_or_420)
> -{
> -	float bpp;
> -	u32 bytes_per_pixel;
> -	double d_bytes_per_pixel;
> -
> -	bpp = ((float)drm_bpp / 16.0);
> -	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
> -	// TODO: Make sure the formula for calculating this is precise (ceiling
> -	// vs. floor, and at what point they should be applied)
> -	if (is_navite_422_or_420)
> -		d_bytes_per_pixel /= 2;
> -
> -	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> -
> -	return bytes_per_pixel;
> -}
>   
>   /**
>    * calc_rc_params - reads the user's cmdline mode
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> index 262f06afcbf9..c2340e001b57 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> @@ -27,55 +27,7 @@
>   #ifndef __RC_CALC_H__
>   #define __RC_CALC_H__
>   
> -
> -#define QP_SET_SIZE 15
> -
> -typedef int qp_set[QP_SET_SIZE];
> -
> -struct rc_params {
> -	int      rc_quant_incr_limit0;
> -	int      rc_quant_incr_limit1;
> -	int      initial_fullness_offset;
> -	int      initial_xmit_delay;
> -	int      first_line_bpg_offset;
> -	int      second_line_bpg_offset;
> -	int      flatness_min_qp;
> -	int      flatness_max_qp;
> -	int      flatness_det_thresh;
> -	qp_set   qp_min;
> -	qp_set   qp_max;
> -	qp_set   ofs;
> -	int      rc_model_size;
> -	int      rc_edge_factor;
> -	int      rc_tgt_offset_hi;
> -	int      rc_tgt_offset_lo;
> -	int      rc_buf_thresh[QP_SET_SIZE - 1];
> -};
> -
> -enum colour_mode {
> -	CM_RGB,   /* 444 RGB */
> -	CM_444,   /* 444 YUV or simple 422 */
> -	CM_422,   /* native 422 */
> -	CM_420    /* native 420 */
> -};
> -
> -enum bits_per_comp {
> -	BPC_8  =  8,
> -	BPC_10 = 10,
> -	BPC_12 = 12
> -};
> -
> -enum max_min {
> -	DAL_MM_MIN = 0,
> -	DAL_MM_MAX = 1
> -};
> -
> -struct qp_entry {
> -	float         bpp;
> -	const qp_set  qps;
> -};
> -
> -typedef struct qp_entry qp_table[];
> +#include "dml/dsc/rc_calc_fpu.h"
>   
>   void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps);
>   u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> index ef830aded5b1..1e19dd674e5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> @@ -22,7 +22,6 @@
>    * Authors: AMD
>    *
>    */
> -#include "os_types.h"
>   #include <drm/drm_dsc.h>
>   #include "dscc_types.h"
>   #include "rc_calc.h"

