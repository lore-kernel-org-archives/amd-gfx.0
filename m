Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F44C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5562610FD75;
	Thu,  2 Jun 2022 13:30:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47E210FD75
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeT9OjYIFhAA+YNpUvpwA8rHY57XstsT6/ztz1HRW9xqYdz/5Y5oKyr9JWwLRbH1JN+q2I1wKcivZ0gtcxViY6RXAgPlC2yiOl2AbfQkx+Awe5cYOsYXmUE6nxIESD0UU7IAJe5Fz1BUTG+lEHPMbZMUWJL7f4XU6W1e31D9m43b5PuK/m9+bsJ+YYBD5Cq1yMyIK65aYzpZUINIGRhT0UsbGaPEAa0P5EYDoRqZ0gxOBGG5aqg3Bd4gYRjz2vd1Rw8ZRVC76Hu7Sc3EXzydRxG1nq2vJZTNn3dik9ZEtGqDP6Sya/blcBhSqb3QFC21BRAqibl/9DX2+BTcYQa1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnd6hloYiFWLIvkDbaExnodG5JDrfQVQru8B/glBFVs=;
 b=Ldi3b20beFgbCmICJhg0LxAZWBFNskErGDHPh782h02ifuSmxhSiaZ+lay/5mj3VvPh0ZoJF3Lv5NnrQZPw7Z9lxhGoj0POp9Gf0VhFeHZdqj2uc9VoppV03cVW1ZEdX5E3ZNebotawBYbY9XhRNItyW6nUJX3LHHBOZ75GdtL7t0Z7LBsa8CtA/EuvXxydULFcKAMosbzynmoivbpAl7ukHaPBN/1meOZBrdtmnlrQmzGSiIDr/tdjOrUCdCjNllGT/mb06UDHQB87ZPXTMv4diQFtXUtYqYktB1Gq8xxu4F1AaBU0mvnOzbVNB1W+Np7yrc9sRDA24nWXDlWyiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnd6hloYiFWLIvkDbaExnodG5JDrfQVQru8B/glBFVs=;
 b=nvsWhSTpWpdPkKVmPcdM2nh+bUIkBFvFR8bKTxJIbDAIpy/FKcNORMhOOSzJTx65/iGy4bCZ7zj4SHl2LDUUn82uRSzKhNLjkJCb2nTNXdJNLs0Ho+eiCZu7em2w7O3DtrmRQciBYe0il5W2QnCyaIE+KM92FK3JBvvdGU0JkrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Thu, 2 Jun
 2022 13:30:20 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 13:30:20 +0000
Message-ID: <dea238ad-8940-d0a4-4969-1017a6ec5341@amd.com>
Date: Thu, 2 Jun 2022 09:29:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dc: Add ACP_DATA register
Content-Language: en-US
To: Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602120229.2731122-1-HaoPing.Liu@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220602120229.2731122-1-HaoPing.Liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c42ab83-9fd8-41a2-20f6-08da449c0a0b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369A5963B16D84B9FDAFE108CDE9@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ahYORS/6YR8Tm3EyUMV/eZ5lz6IQBloK8lzBDfh0STfcDwWl+iKn1wacxCg3YIWDngsR84KGqerE/GT4nUlxtCwuPOAhETxJC08ICmB2saTvq0pa5rD1R+cq3glMc7ZQTPvTMG2m0uzIo3bfkY03C4GcWQmdpCE/nnjZZ6zl5j/YT/+xfBiX/pybp+werG+HXkkKBlfTRPg17S0556mTc0pr5IjViK2twF/i8ywUqxnu8HBPPYIbscKjospCUrcqJoq2xrlTAU3JawqFlM3JGTeVZvSgaMoN9fXC5tuhp7mcWnTh+gGN+XZJkSesqxKuV8ymN402svO95L2NQtzyl3hL1Yj900vE7znEctEaOxUpZ74VguMdfKn/SLEUQNFUIaaFdY0hfScPKcK9B/yljx2Lnkd9sl6+zNReeNYRz/Ww0/PjM4Scq3dQpsJsYOy1sfvjqPzaO5YsGuvSr9/G+rpUz/X5NbhaF8OWzZVnMOunAPn5ZvQi6ijtKzS3I1UYgLIcFK1PLymC6zLS+DeTZ9mGQPT8U3i0MWTC1fWYhPn4wMl8hlTqJZiTbQoFi34xaKMeJi/+dQL1ty9AgCNFM8TyPwo3z35o88GHxNDk6JuhLCZ65oDWRezPTvl7Y3iGpnSAmwgr+GRsrzhrISk54XQt3r/vDLe9xzGaGIuml4ui110sKcFi+xQOtCeKgbXpVle8h0gIF5qlHt/HjHMb0rWd0RwU6AFCfUKmS0lbBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66476007)(8676002)(66556008)(5660300002)(31696002)(36756003)(86362001)(186003)(66946007)(6486002)(508600001)(8936002)(6512007)(38100700002)(26005)(53546011)(6506007)(44832011)(2616005)(6666004)(2906002)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkYyT0hCeEIyRlFuVklHa0F1bnQzMDJGUUNsaDFPQitKT2N0WkE1azkwME9m?=
 =?utf-8?B?WWRraFYvOHlleHBSUzhaU1ljeTBKMXRxQTRlTCt2c2c0V3dPZk9jc011Tkpi?=
 =?utf-8?B?TVBSeFRUd2IxVnhzRGtNdUJETlVJK2h2ZndrSGx6THhzOTIwOC8wK1dOeFBI?=
 =?utf-8?B?YnBwODNIVnJrc0pGVWx5QmFibEgwU0pBUDh6Sy9FT1BaWGtQOElsdEkxb3J3?=
 =?utf-8?B?UDNHRzQ2MC82MitoeCsvSmd6b1kxZ1BUUmlTdVhraGNzbXdwU0ZBb2Qyd2xJ?=
 =?utf-8?B?cEZoeDdsTEd0TUk3TjAvd1ZxWUFNRzRtVEF5UE9oVml0bW9vZTltWmZLcXMx?=
 =?utf-8?B?TW5DQVc0dW5Sc3hZbE5xV0l6dlVnMXE1R3hoYm1oU0pzNnJvVFNzME9XeDk5?=
 =?utf-8?B?ZDcwQlgvTVd3UThjaFU1Zk5LTmRNbUMxUWc1SEU2YlI2VVhBV3ZHdStjdXNY?=
 =?utf-8?B?cEtmR2tYRnE5bDdhTGFMQytjZGh1UHBmYzZubmc2ZnlCZkZsNUxJdGVBUTFz?=
 =?utf-8?B?dXJYNEtpSlFqemx2Sml1WE9NS1JWTG9WSjdpSW5JSUExR0RndlFUM1B1S3l1?=
 =?utf-8?B?Q3V0NWlENjcwZzJQbEFZQmcvWXl3VFk2ZlZ4MVlxZ3N3VGRNWE1NUGRjNmZH?=
 =?utf-8?B?OXFtNW90c25EYjFUNll6VVFWa2JvZWhHc0thUDRaVmw3N3J0Z3NBWHNwZStv?=
 =?utf-8?B?Q2dReno5SEtZZFI0L2dyYy93eVlzVlNqSFFNMWgyaE8ydlZkR0hmM2lkamFl?=
 =?utf-8?B?RVVvYlhkNEFzZHFLY2xpdGdUWUZ3SGVwUzF3SU9uVkZUQ1YwOG55MGp4NlVC?=
 =?utf-8?B?S2hhOUtoVHRpRVRXdVhJblRDQ05EcnhBbmxDbmk5cVRxN3JUcTNJZERocmdP?=
 =?utf-8?B?TWszbVlMeVhCUzV6ZzhhemRyTHBYWmk0Qm5vLzg1Ylg1eFJ6d2lhUGgvVG02?=
 =?utf-8?B?dlZReGtVTUY0RTNOZGl5K2pXMGdlNnJEUzZTY0ZQRXgzSlNkc3pKV0FldGh0?=
 =?utf-8?B?TDlWZHBhaTZybW9Xa3VrMElLcE9zR0NTc3dHdlFaVDVsaXJUbERsYldjZjlV?=
 =?utf-8?B?RElMd1ExRE5aMkpKSjduNHFCNmU1b1lQamRqU21CR0JDWUt2YitjLzlFYWpo?=
 =?utf-8?B?Mmc5eGlRVTAzbCtnMDE1V09Pd1l1MkJTK3ptT3BDdmJQMmI1ZjB6M1BveVdo?=
 =?utf-8?B?bWdrbWxreG9Hcm1RVEpMMzE2MHZvanE4cDMvMk5SNjM4WW8vR1l2NzZpcDRm?=
 =?utf-8?B?bFVsS3p2cXp2TWh1WWlzOWRJRFdnODUvd0VqSUYzWDVZNUZPb3dHeituYUQy?=
 =?utf-8?B?cFUwWWQ0aERhSUVqcmc2eEoxcGxCWlBiVUdCbXAwRjZsYVVMQy85SnRqeERZ?=
 =?utf-8?B?bFFHU1BoRHhhMklSemxaWVdkRklkaXZTZ2Q2cUJpVnh5bWszU2YvL3lVQktX?=
 =?utf-8?B?N1I5ZFFySVZPUEU3ZHhkTWF1U0lCRVIyem5sUmYyc0R3VElBV2F6QVBocm92?=
 =?utf-8?B?RG11Z0VuOWRLUzJrb1Y2WDh3TzRIUDFvcXFwTGRDMG1sV0lEQkthdkpsdEs2?=
 =?utf-8?B?QW14L1FxMU5EbCs2eXU1dkdZMlVOVm5iV3pIK1h0L3Zsc05MRm9XSmE2SGV4?=
 =?utf-8?B?a2RXTXNseEFRWU01NU44MDN1NXBTT1g4a09Jem12TGtFek5yeEtib05obmdM?=
 =?utf-8?B?OThLL0pqeExOeUllYzVYRVpKeWE4alhwVGVVNlBXUmpHcVJDWXl1UzVHZDV2?=
 =?utf-8?B?MThqSEMyMDBiKzVBUG4yV1gyVTEzc1BwN3ZsdDdLOTVMN3dHcUd3YTMrWkNy?=
 =?utf-8?B?S1JhUHB5T3JqMVZseU1LdXZoOXlMdDVRemZSVkxWRHowcGlLeWpjOVpEYmMx?=
 =?utf-8?B?S3F1Q0ZLeTQyeDR4bTJGTXBtOTFGV3IxN0QwMElmZE1FQldqS2V2UngyVGxs?=
 =?utf-8?B?am9tNlBuWTRpRWN3THZMcGdsU1VQUWxVNGZad0lLMmx0RDdmd2NvQ0NvZEMy?=
 =?utf-8?B?UWdNRVVzNC95d0d5dUtUT2xvNkJZZktEYyt1U3UzNXY1VHdoQlN4SGVodGlo?=
 =?utf-8?B?eWtSUXlGRDByTXhpV2EwK240clJ4c3FXNWhucGZCMHBhNGtnQ3ExL1I3VGZn?=
 =?utf-8?B?YlpPdUFvRjlweW9YUUx3dGZVQzBET00rQ3hGdWtDZXVqMWhadEJjZEhoWWZT?=
 =?utf-8?B?S0VETytoN1JZUXZxaUJVYlA2SDVxNW1WOUlBU3JYZVpLM0tobnlFSW5DRGs0?=
 =?utf-8?B?aWlyd1RaVnM0Y3lTMWM5TzRkUVBJNlVIblVwejNlMEZrVXVrUzFpT1poVGEz?=
 =?utf-8?B?WjJncGFVSzZCNnlNZGZHL1M4QVlKdmJpVGxSRy9sZUpVK1NtRXhJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42ab83-9fd8-41a2-20f6-08da449c0a0b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:30:20.2934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqNGIybouorEOZhMtNmd1xJ8H+F9YsA2XgOX+XxPV6Utn+Kh+7GuLfHsbOW78Vo/5FRLIZvKK6levUg9wKly3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
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
Cc: haopiliu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-02 08:02, Alan Liu wrote:
> Define ixAZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA
> Define AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA__SUPPORTS_AI_MASK/SHIFT
> 
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h       | 1 +
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h
> index 6df651a94b0a..581ba639b4ea 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h
> @@ -6981,6 +6981,7 @@
>  #define ixAZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_PIN_SENSE                        0x23
>  #define ixAZALIA_F0_CODEC_PIN_CONTROL_WIDGET_CONTROL                            0x24
>  #define ixAZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER                           0x25
> +#define ixAZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA                                  0x27
>  #define ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0                         0x28
>  #define ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR1                         0x29
>  #define ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR2                         0x2a
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
> index fa1f4374fafe..fd387c7363b6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
> @@ -13639,6 +13639,8 @@
>  #define AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_PIN_SENSE__IMPEDANCE_SENSE__SHIFT 0x0
>  #define AZALIA_F0_CODEC_PIN_CONTROL_WIDGET_CONTROL__OUT_ENABLE_MASK 0x40
>  #define AZALIA_F0_CODEC_PIN_CONTROL_WIDGET_CONTROL__OUT_ENABLE__SHIFT 0x6
> +#define AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA__SUPPORTS_AI_MASK 0x40
> +#define AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA__SUPPORTS_AI__SHIFT 0x6
>  #define AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER__SPEAKER_ALLOCATION_MASK 0x7f
>  #define AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER__SPEAKER_ALLOCATION__SHIFT 0x0
>  #define AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER__CHANNEL_ALLOCATION_MASK 0xff00

