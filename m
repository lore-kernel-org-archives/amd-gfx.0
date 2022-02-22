Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC44C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 13:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B1310E7E3;
	Tue, 22 Feb 2022 13:53:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBAA10E7E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4SU8brgWma37H8F1HStSutHv2lJkXAYTFw6Z5yHG7ca3bpV1eURpl92yr0rDZPSQdE3QrIphtiZpDHZa2iPBzqS59jF3q2qMA2BDIav32icDvPHlA7LpmTAy6hmLFz0zrmgQhDpvky9EFbKjphvsgjQ60hSZqsLB87MzlSOAigK86hRCI6zyO6dPCNYbky27tBfKINJdXlmUGIGBfVefWV0w+SrmXsMPThOJAt8XXkAzuFVDL9JfFFt5HAHo3YaqZ7IQCFzBZiA0dAN14mbx+l0fBAIxgyX4w3h+cKptWBseKjlTl1LMCsONwnqiSjQ7PZJMFtysrbEuHZ5AaAnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt9mPXzZKHjIMjyRInn2clgzdysKRPIX49zYtwLv/SY=;
 b=F8a3jmm0bvpWP/MYuRcngkcMRT8gIqts2dZ4/4/ogEc+HE5WKGlZ1AbpO9GmMjy+wLywWcco4IatgweJoz3sepJshAOB+gQGt0t4lypZeFUE8/jB8co4mipwnZMltuOh/dtEs0fPDctEjDPxSu1A6H8g8pw/tNRGwsHG/XNetomOfuWxHWylIeunbTsEAzgNIWO2p0XhMXy2yctFjtiTRfTmQHjUacNjVlMijqT3bzIFOJRSbgrFQ47Wm/5wvBtXeqGWiHpeW43SCS4X9PLx/mUgv5IGKf8zfl2oY7MGFWcSVDywUsH9MPlyNAK7b9gPcTCh2vg0cH8Z9AvaIUC0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt9mPXzZKHjIMjyRInn2clgzdysKRPIX49zYtwLv/SY=;
 b=b9/WHhEfjKuETchg1LEE42Fxmg8Rda4j0DuYGf/W4STt5Azd+trUiT1mVn8IBARpCNHd600nhBDCIY8AqFCOkY/yrXoFzdJIy855QFrEPkfUc/B5H5ug6kYiq72gqmhw2UZmZJnv5CajnYHWrOd/kUdik9E9tkbuSfPXGIQAIco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB3118.namprd12.prod.outlook.com (2603:10b6:208:c6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 13:52:57 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 13:52:57 +0000
Message-ID: <ecbaee85-b44a-85df-accc-fad4d3029b10@amd.com>
Date: Tue, 22 Feb 2022 08:52:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] drm/amd/display: add GTT domain support for dcn 3.1.5
 and 3.1.6
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220222060313.856546-1-yifan1.zhang@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220222060313.856546-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1966412-0f87-4a2d-d4a1-08d9f60aa1a9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3118:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3118ABB951F9D1ABFAD36D8C8C3B9@MN2PR12MB3118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHFlQf3TYOOAuOAw35NM/sRhaO54wgQpJxdTiR3yWNY/rzUicjLkW3eFtoHTijVDPRkkYkVK2JXA4gkQ83yZm9eCvwgo9LOntehb287040Syb8AHwN3tjWW8OANNIX4Ag/dD0e7t5ePxLgOIGsfm6oAidVUUrIrVCevyYONjL+eq3dVmc7aJYkLMB1b0PVO6wxs01qdNAnyhgk4QAUWxqaktmTgPoRl/0jYBR2n4M5OnXFTu9rJRoZcI8IIw1jjJt5qlQ+oS4PbaxdUtqInxwVXNWoYPHs7OUEmKSC/W3KgZLtBntRcz7UyURX/B6aaFDuNtGkS31/93xTE6rdJieM6lEf8R5ziF8kM2LJVmoGuO+Ckp/eIZjXwxolNUMAznQ4SdNYmWFCiI+Mf5xgLosI/2Wk1EmXHbe3rrBdmLj0RNUJW9T4EMGjtRFE9/MqGfm923z3IwmIQwCSIgny35s6ZRjoSuS00k16Ord0RATXC64dlf+zjMT95ndvoVT4INWHl09BF+DVo6fC7JikCTs7SabVdSqmutXNdhl2bKmYjDHR7o7qdeV7IPE/IeW0wUvn+GDPMfPascg/IUerYdIH0k6brysvAN/jLKjithva0nxFbv8hMl9zPThKo6LHP2X6bHBcaNrNBnnK5/ulcytLnAdcEFXTAaayFpWlb0/AZ1aYVhMzvC6i5TsuIKcJtuoGZfpS488ygI32KgGXcBTCjT3qR/D5vPUNlxw0hQs6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66556008)(186003)(8676002)(66946007)(2616005)(6486002)(26005)(316002)(6512007)(38100700002)(508600001)(86362001)(31696002)(2906002)(36756003)(8936002)(31686004)(5660300002)(44832011)(6506007)(53546011)(6666004)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9MZTRlOTVHaVJIQWUxNDlhYkR1djRDb0dtckErM0tWTDBjR0pwVTFLUGtp?=
 =?utf-8?B?VjExSmU1Z2NoejdDVmp6ZXpKYWxWTytJM3pRa1FMWldTZy81WkZETUYySG82?=
 =?utf-8?B?SmEvQUVpTDJuTVBwVVYxQlR5cWRBRmcxMUVsTnY2eWh5MDRTbFJiWWEya1l6?=
 =?utf-8?B?YnkxeldNc0c0NDh2NEcrZ25CMDZoeEJlRVZjNDN0YTBmYmg2djNvN25ZVnJq?=
 =?utf-8?B?M00zdEJKbktaL1BZaExadHVVTk1nZEdmTzRZWEJ4RUF1cXZINmh3ZEF5ODZP?=
 =?utf-8?B?VFAzLyttQVEvYW9WbS9WSW82M1RYRk9EQmt3U052aGlrOWhiZ29BRWxJTTVZ?=
 =?utf-8?B?a3Zta2g0ZTN5MFdxRXljeWdRakQ0SmF0Rk41aVAvRS94UmVVdmNqR0ZkOThH?=
 =?utf-8?B?bkZqODlxUk5XTXpGRmt4eDFxS0k3SGl4QjRicWw3eTVkMEcxdi93bC9lSnZM?=
 =?utf-8?B?WnpKNkp5UUNjL25HVVh5cnVVWWR5MFI0encxZVE3cFFFZ0dLY1Q5Y003Qm1x?=
 =?utf-8?B?ZnMyS2I3MFR4amh1YlV2NklndVpEcHg0VFQ4dzJnRGYwak4xSzB0SFNuR0Fl?=
 =?utf-8?B?MjEvSHBsTVkzbHNMVE82R0M0Umc3Q3VZaHcwaGpkeXBVajY4WERtVmsvMVha?=
 =?utf-8?B?YUFKS09uUFdRc0JDWDhkMksxaStHNFlOa01vOGpURXk0ZkRjUDB3ekt3eUJI?=
 =?utf-8?B?THFDMUJCQ2d4dzNPY3p1U2NxQXBLMko1ajRFN1QxU2hyYjRhdm0yVFp3ME1o?=
 =?utf-8?B?cUU5dUZiYTBLL0NPN29rV1MwYlNRaVp0Ni95aGZ0UE10R24rR3UxdmZoamVF?=
 =?utf-8?B?U0hnQWZyQ0UzekVXNEwvdWViQ0svb1hoa0ZmTHl5VnptdWQ5UXUxYS9tWmhu?=
 =?utf-8?B?WWtwdks5ZlVsc0dnZGpackJKODdyMkR2bXpPMnZxaFZvSlE5SDlOU1RkMjVt?=
 =?utf-8?B?cnNTL0pSOXk1RkZOUWxRUFA5VzFIdlc4dmgvMnZZZDJCM0M4eFV1Mjhqd3hv?=
 =?utf-8?B?OTVDZ3JSTWJuNld6ZXRxaGRGTk16dFFxOXdlWlB5YXZvY1o1em1pM05lcXBI?=
 =?utf-8?B?Z2xqYzV5VGdMZnZ6L3V5bzBMeG9pS0UvSTlNcVVxU2pJRTQ3bWRURFBlb0NO?=
 =?utf-8?B?TWhpNlNjcXNpUU0vT0J0eFc4alJVT3B1VHBrRHRORG9zWGN6RmM2REx2OTZj?=
 =?utf-8?B?NFpBOWhWRnRaR09pRXFTdDNvZ1BrY2x5N0hxeEZ4TndqTDFvYTFnYlRBaW5I?=
 =?utf-8?B?Y3JNWFN5WmtRRlVUMGJXOE5CSG9ZTWoyNVM4OW1YYUNqdWxETUU0bmZ6K05m?=
 =?utf-8?B?WTRZVHl0eTZjOVpVSEtXY2dKQmVubWVQcHZ5ZTRObURGM09uU0FMb3k5MDlm?=
 =?utf-8?B?TzY5U1pybGxzZ0JyL3FmMmRaR1N6U2NsN0QvazlHZHVDQ243TXREaDF1N0Jy?=
 =?utf-8?B?V0lTWWZhcjQ1NkFnM2F0L29qMkhMdndrSmFvcHU5QjlLNU5oTHBmbWFORXVX?=
 =?utf-8?B?Zmx0bnhOV3hBaDVwd1hCbENCMk4zZEJRTnBobTQ2VUlXd1cxVS9FVkF5dldu?=
 =?utf-8?B?U0M3VUdxS0RHa2duU1dFWlhWNzZjbXBWNW5LbEc0Q09adnZUNE9rMW5xTnox?=
 =?utf-8?B?T01WeXJrdkthVWNIY2U4M2l2NzVwUnArc0RBK3FPQWdpc1B0c0d0bWc2aEVF?=
 =?utf-8?B?Q3FoK09mNXZaYy8xbTVMTUFUSER0dnBmNEtKRkxlZXJIOHVoSUh5ZnZlRUNP?=
 =?utf-8?B?Q3ZOSlVVeTluOEpSemhYWDEwZXVWZHl5RzhQTlNsWWg0Vm1pRlF0SGMzVXdX?=
 =?utf-8?B?SGVrQnVod0RoTkxpM2NVZzdjcDd3aHJYVnFNNm82bzFqdGN6WG5EMEZQOHlS?=
 =?utf-8?B?MWo1eVltWHdZaC9RNFVnVDl1OEoyemFBU1RPeGllUzJ1b25VbTFWc0JaTlRJ?=
 =?utf-8?B?UEpEV2tsZnlaemNMZTUwY0R0dFExd0ZmSzhyOFlreEF0ZnNCSUk4WmV5am8v?=
 =?utf-8?B?ay9pMExtYjl2SjhodnBvaFJCMWU0dlNubU1BQVl6dGw4QW5QbE9ldkFSNTd6?=
 =?utf-8?B?aFpMbTVjZlNJcTdqdUptNnpKcmQwQWt1UXMxM0NkTEhFVEJQMzV1aEt3QlFv?=
 =?utf-8?B?d2djUWdhSEdLVms3ekNseUdNTXQ0UEI5MUtWQWdtQ1V2Z0NMQ0JoQ1ZWV0p5?=
 =?utf-8?Q?PyVa6sVme4SXh4Z+UJDjLcU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1966412-0f87-4a2d-d4a1-08d9f60aa1a9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 13:52:57.4502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3Omc8/APqEmnMU8o8i0GIt9b2sHMGEN8w1citYORyZLq/I2/X38Ty3F+TVIMBsFdHIQQPSV+1Do9sn97n6DRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3118
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
Cc: sunpeng.li@amd.com, alexander.deucher@amd.com, prike.liang@amd.com,
 "Tianci.Yin" <tianci.yin@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-22 01:03, Yifan Zhang wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> this patch adds GTT domain support for dcn 3.1.5 and 3.1.6
> 
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 9709368b4915..37f4da219a5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -523,6 +523,8 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>  			case IP_VERSION(3, 0, 1):
>  			case IP_VERSION(3, 1, 2):
>  			case IP_VERSION(3, 1, 3):
> +			case IP_VERSION(3, 1, 5):
> +			case IP_VERSION(3, 1, 6):
>  				domain |= AMDGPU_GEM_DOMAIN_GTT;
>  				break;
>  			default:

