Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E905C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D714B112904;
	Tue, 12 Jul 2022 15:28:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D06211A154
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWqxYYx571Z3dxoLc8NtdJstL6Vy0NfpRw+0FWg1ShPWZn1fxXtNnSahfFbfdwU2TDpIDZmxjUR6MMYQFV3ff/3y86Dj9K24X6eVf7MYb01eUVsDWdGZcpQQ5MwurXzrcX7nB9umq19Je8jSfjJ/IfOKwsVA2zU/vQb7lrpBZdYHt4FpIEStKVVBkqgZmvW5IIoK+WfiOXFbWea02A6K1lIkOa2z2/vixOJBMq+444v8/gy1dcT8lnW3PuZrAU/llX+M1ERQ0IRsdrabtAUhIO0O14K7+StSk563IzqPgfYBy4UXirUxTMyJgJ9Ne3RUOiL54YBAx/poxxlZ3uq1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzD2p1oOy6Kaq/2QIXJDC4WY6WyCEqnvO+hKlOGNO2o=;
 b=enV4w00+jMnxSs0JeCQEuS4WuYvyoU1dRZLQVAM5fdnuSyAK6ZonftgKzoSi29EvzFnaCTmutHNNjPWAP2ZmZ1hzH+JiERQSN8kpezFwE/Tl33U0tiKfB9sxylNCoj+hIH9Y/67Cp4q2sIuh+s9k4TJQaB4Bgf7t0Lo/j6eSgvf0huGkS1UJ7ytZ9LNJnGKH2xFUXyWGdLFP5b3+9mompBvEdke8oRSBrQoafMbbjeeFHi8Lf460ODSbnRLQ8SC47mFTmJxM61ElEAqxdrgUhFN4QHEwmh2hccKgTjJjmPKsizx+6B2YhMh1dNWKyp7MhUvd9hjlwLrHk81i8lh8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzD2p1oOy6Kaq/2QIXJDC4WY6WyCEqnvO+hKlOGNO2o=;
 b=QX6ifR3BGQere0GWFeHQRjcn//xHkysbETDw9S+zfcNo9DO0o1P5wCmg5T21CrvedR1AZrqNaOla3gm02yi1NZ+HnSeTwOeF342pKO68pivzWTKig+9Z+iKG+qfHgETIJfQ8LlAgValXHHZddUW8aWeCvfPyTw9SqE2h0xknKEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 15:28:21 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:28:21 +0000
Message-ID: <5281eff0-cae0-6b25-c0b1-7bbdd3b6a285@amd.com>
Date: Tue, 12 Jul 2022 11:28:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] drm/amd/display: make to_dal_irq_source_dcn314 static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712143159.2700970-1-alexander.deucher@amd.com>
 <20220712143159.2700970-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220712143159.2700970-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 234b4f4e-130f-4c5d-ff36-08da641b270b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZsR5BS+fQdKHPsGGG8rHcUgBz5g4ZrpaW/45d7AwW/h+13wmPM8evJfCUbwH6vNh69D1hBmB+qHx8M9YtQD/nHR76iQoOER7gRKyD7wXevI+E/xx7/my/Wy4sSF7RFw8fMbtPghG/gJaiNEuG7UkX2YntFYwFbF/1MHUiE1JdLk1IZGVjOwx7GkRTlR0ezA7hcbu08TdkJtc80OL1j5qjRbR5ohcnWBEqTkh/z0Dc2WBM8kFTobsXQ1nxwHFrzcahmXMRC/2HOI2RjSACFXsSjjewzvewXQOlpegdMsmCEkdeErv/jPODw6ntTX2PTuuyi5LoSSc9PQwlct/umFEQNWBcjLRRUfeUZ0e+Qn/cJvR9Z31mrkXGKBNLhCRRYU85U20gcoV3+UK/0O3+eueRr5J9XAyrcGTWj35GgMDnyGmOHiEV+t9W7glXXYFaf2XRIsyGTHMomqy30WWKnql72WKa8Q9Gk0VAIXgdmbqyAJV5zkipR7R3iEvPir96vslEyP5Vj5DBBYLYTkcY3fADuilNtnkSIEK64ctWD30ufUcNvI9R8DmA5M+TtI3ETz4m1rugHrGFYlRwYRMqCuopVv08kZXBzAvQSjxAPkGJ9I0XOPNidphLefELB5hPwffQpUss11qODZEV5HerNKrnofVa05W8TK/2ZMmv+TPJY5J1K5Uw22MGpQ656Si/K1uhDOX9Qrb6zg5ev8mzFaaKYdIvUHM83nT+5IZK2bXFFV77zOtICk3PP5Uwi9RlHOGSY9EGaZwCqFgxpzv8D0lQL9cG7E0/C/ekBMglf93qlrL9+GCVdN3yX4uV2w2GH5arZSCMy096NeoIlKGfJFMoWUWjn1kwTbW59HR8p+29o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(4744005)(41300700001)(478600001)(2906002)(31686004)(38100700002)(44832011)(6486002)(8936002)(6666004)(36756003)(86362001)(186003)(26005)(6512007)(5660300002)(66556008)(83380400001)(4326008)(316002)(8676002)(66946007)(6506007)(66476007)(31696002)(2616005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1hZWhmdkQvQnZna3pwQVhxNFNRdndlK21aOEx1aVc2bEREWkhybXg5MjZZ?=
 =?utf-8?B?YVkvRDFPWnpRbjlZVWdTM1BjcDQzUFVtbmxLNHppY3RvWG9MQVIya2lHWkx6?=
 =?utf-8?B?NmtzdjQySmozWlRpMVlkVXZqQXNnNld1S0hBdWdEb0syUldrMWpOd0U5d0hH?=
 =?utf-8?B?WTF0dndxQUg2d2x4a1pTRWVDM0pnbjAxK0hjcU9NSWRvYWxnV2ZaZFUwcy9l?=
 =?utf-8?B?bGY0am05WEJhN21sbFh2TThDdkFnbW5QbTBaMFhranliK2dGVVVLbFRyaFgx?=
 =?utf-8?B?VmtHZTNjUHhJbzMyRG0zQTgxc0RuM3I2ZjFmTTVnWFB4Zk9Ya2F3MzJURFJa?=
 =?utf-8?B?OXB4dkpWVC81SllHUzRyWXJqeDZQRlZIS2FHTXp3T2tOTkx3VFQ3L3FLZXp3?=
 =?utf-8?B?Kzc0eVZQQ0Z5dWNaVERBKzAxQWxDWGh2UnU5ckgxamVhS0phZmFkb0hXMEZS?=
 =?utf-8?B?cTFiNXZlVUtqR3FZWEkvSGR1QXUzYk1udU9mbHRsSzNFRTZyaFBMMGRFWVZE?=
 =?utf-8?B?elpMazhmS2ZDT3FtUFo2NzZMMVNJdHZHTDBUNjR3eFE3UGFYa0dKbldya2Vm?=
 =?utf-8?B?RmM2OGU3VFdzWVZ1OFFuSDFGQURudUFDaGdsVmEybE8yUFArbjdxVGtkOWpN?=
 =?utf-8?B?VkZpZHpGcDRCNnd6ZDZ0S2ZKUnlsZjE4R0dVWUFUV1VOSzVFVzMwM2hWV29S?=
 =?utf-8?B?OUpaaHZBYTNERDVzeTVSbkwwVVpBVk9UWERJcjgydXUvekcyUi9BaU1qYTRX?=
 =?utf-8?B?QnJUNTBZczJvcVdKOVFJaUluQ2pkV3VaZjF6VzdrL01xaldyRXlXT3BmS1Nz?=
 =?utf-8?B?S1RDUUowYnVIOXBuR2pMTFRWblZQYlNCSmZEM3dkR2FWcG5nRno3VHFHQWti?=
 =?utf-8?B?aWdxaUo3Sjl0YTBOdUd3YWIzM0U2ZjcrN0dBUy9uLy85OVlTc2sxSVZQdmJF?=
 =?utf-8?B?RTFjcC9abWhtWm9oVjZWazB1Qk1lVTFEN1l2KzZGR2pwMFZUTTFxRVEwbmZR?=
 =?utf-8?B?VWFVWU9CS2ptanNYN3FBUEpscDRCekc2eEl0dDNyMkVEWENOVzUwVVVoR3dG?=
 =?utf-8?B?WW43M3gvbHlFQVFZWVlZK1d5MWNRQVlhUlBNWk5oc3VQRmNNdVM0RDJZL2Uy?=
 =?utf-8?B?ZGNhTjVLaksvUHM5L09STXhLME9HMTg0UnZiTzNtNGtEeW9rU0JvMG94QXFy?=
 =?utf-8?B?aFZ3T1diUXoxdmdpZVIvTzBRaHBCaWFubGVzNEorai9YYWpza0xuQmJ4ZG9J?=
 =?utf-8?B?Wko2clZaWHQyL0dSa0laSWJqeUx5MTNiTmJxQzN3bHpXdmFrb2ZpSkM1SjFW?=
 =?utf-8?B?c3RQQ241VklKL2ZkS1MzKzJQQmlFZUNCWWFKQUp0S0g3bFJlVVlBay96M2tr?=
 =?utf-8?B?S25YQ3E3VzFtMVcweUZDbVFMc1djT0JGS3Z2YkgvOFFaTHdyNjFvb0VIUStI?=
 =?utf-8?B?QjhaSmwvTllsWFZhRkJ3eU5KcnByWWJjcE8zcUt1TzVLenFDTVg1dUt4VW5P?=
 =?utf-8?B?YXBJYzJONGhEMEY4RlBHT2tqRHhhaHlUYnNURUx5SHFqNkQ1Q3dtNHhkd05o?=
 =?utf-8?B?VSttRGNFRkRKR0N4OGJXeWVxc0JjZW1iZ0YyVFNQNSthcGhzcWtiUGZUeURt?=
 =?utf-8?B?TkJ5S2RVNUFHRDJuWkoxWVhlWGh2VW1CME8yNmhlZTY3MXp1MFJlYmJqMnpo?=
 =?utf-8?B?VkNFZEZaR3Z2T0l2QW9rN05UK3lkM3Uvc09HdURDWDl4QWJBT3FYYUFLNVNE?=
 =?utf-8?B?bVRlS25yUGRFaUI5U3BBSVdkZVlkRHJLZ3FyWEpWcjZqUkk0K1IwVnJuSGtX?=
 =?utf-8?B?U2pESVNlTGFCUzJWV1hkb2ROYmdhVTJOWkdrS3lJdXpmcHdVbHpSM08wb3hM?=
 =?utf-8?B?U2J5bTNWbjhFVktSdmFxc1JSeDFnQlZzaFB5RHExUERUZzVDV2luMDdVOHVr?=
 =?utf-8?B?Sk1sV3Y4UnQwMzBTZDlPWElZNUszaEMzU1JUZHNDQU9LclVvcGlNYlNXZUN5?=
 =?utf-8?B?SDlwR09tNEtSS1V6TTlZY0Z2VzZyaWZoc2VJanR0OUxFa2lIMVpiK2JmNWdp?=
 =?utf-8?B?bjBIblZOV1VhcDZRMitLakxrQmo5ZE9EVmVMbmw1Z2xTaVJQVGs4U1hrMlIz?=
 =?utf-8?Q?7mGHeKLJjSzvTfwAePvf0/0UQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b4f4e-130f-4c5d-ff36-08da641b270b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:28:21.0057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mo1/n+tFOcXswteZ694tPWY+ixvzUXALUWS3DKRwpUnr6DDgPRg8qVHQuGZt8Ai52yxDIMcgHIhF04Bw3MCZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-12 10:31, Alex Deucher wrote:
> It's not used outside of irq_service_dcn314.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
> index bea6f157cbb7..c923b2af8510 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
> @@ -38,7 +38,7 @@
>  
>  #define DCN_BASE__INST0_SEG2                       0x000034C0
>  
> -enum dc_irq_source to_dal_irq_source_dcn314(
> +static enum dc_irq_source to_dal_irq_source_dcn314(
>  		struct irq_service *irq_service,
>  		uint32_t src_id,
>  		uint32_t ext_id)

