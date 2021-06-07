Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4467BC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B2761159
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B2761159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8406E8E8;
	Mon,  7 Jun 2021 14:31:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BC86E8E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edlFGbcFjz3WmgZ+6eShYerCw0juAqqT8eD+07IVPFeM4zIJuIB9mmsOWpE0xSCDoiIBG753NX1nsBLk8PM6bI2cDOPtV400+4iX8AHLwrhfW1qPbxbshjckcSFeopitXp5tPz+4CGh1B3EjBjUidy7U0awP49H2wVxvBMT7EDQ77CJI4UcBvlG1chscUIB+Ee/7Bg+1H1d6+ulG3CQFp3Wa2JW17ypQd0vpO1P6oB6gtlXINVQa9I5SeX5WkEHHEmDDeZlnzCbgy8/Wk2Qwl23R4fjbmTRIoC+VNOmP2TIMW1dcfOcxHqi8d2He9sm7sP4BQm+aRtPDfzTlFbmc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/M1hyHUKwcVJkp6ov1GAx8oRfhg3/ocsRBiLRZAxys=;
 b=mu05I+FXfb6gxwnMb698Fi0LArntSaZPRFNHf8grd4YrTE0fw+isyGisVdEbjm4RW5mnPxDD7D6wBUmCIRneJ8U3svFMtAeA0RWlEl4qQukefIK1AMtNyqfvG3LNsxBOvlByYlwZVf4I24l454a96vn2DVBpCINV5JTwKplD35y/3koWPvo42YmaLc0DX+4GkPOL4CH0EhebE/A3AZ4cx/z/zhpQppffhKJUSSDOIb8yo9r6y5qC8Qw4Qa7G7EXmnrfUYU2gvjsqPXahzY10d+1WwQBkhCzCCkE2dHuqLeSahNS3kSzdbNYffU5RMjja5c3vppgVRe8XaMUbjbjfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/M1hyHUKwcVJkp6ov1GAx8oRfhg3/ocsRBiLRZAxys=;
 b=f/Bp3A36yvomtn9TZlhSENrvlSKlIHJRQkZogKL+xMJNj6N9Le8oVnqQCsAE62JEc8BJCHcMf/9tftGGtcJqLtrtjL8utqC8Gr5tYEhMyH7nPxSg25cQkIKXzCGtszaJlxX73oY0qYfUNZvX2YvPtWKAIK0AF0trk8oLxZxmscc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 14:31:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:31:06 +0000
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: Rohit Khaire <rohit.khaire@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Emily Deng <Emily.Deng@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>,
 Horace Chen <Horace.Chen@amd.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
Date: Mon, 7 Jun 2021 16:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210607142343.13509-1-rohit.khaire@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
X-ClientProxiedBy: AM9P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
 (2a02:908:1252:fb60:ce67:4e4d:875d:ffeb) by
 AM9P195CA0009.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 14:31:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5b73bd-d9c7-43e1-af6c-08d929c0e24f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4205AC527901B87E31EB0DE983389@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaCFTNJfLbxx6Ioyala0LLWpzepBrWu3IlwhxHYY5FW/NqXyienCbxdyp/DbQLhP2844+FmNoY7jn1pcL3rd2ZsIM63IwaRg7NH/2h1v4WvPY9phd4pz3vljCwgf3dL0v8aIO27qDDgOoN+35+nS+c8dkfnaXwpQ87zbJJ0rPyM7oSqiW2Q2cLlJF82CORaiDZDqb4HGJiEbXjKyHG6xv9bHwJ/npZ/IpzPETYVVcZ4WXBJxjJrSzUwj2CJiPPmlqYF6/5KGyMCX+9d61UTxVu1ExBmOwOUH7/7Fjspb8OlIMaBZFAmVaBA7jZQKcvbdMztg+2JMu8YJQN0d9LH4mmfyB3apjFFg1NBAI8EwNkw3XN5G2UMciuxZfOZoufboMLhQVQflNn/p6MPQmCl2+seXJkd/n7NrTrvch97d4xpMh11tgL9AUXQVD/aAoUO7Lw9g037V5QZk0ZzpKpgFIZowQer0uKUje4RcphiEMBU/dHBENpsf6XTD0k7rXTEcOvEpPXRfQ8GmoSStO6I6LPSIlZSh00jG8TbQLgKTP0NLAFWCpyHMV6hSE0a78z2Z3j2RLw/PQ248+yoMxoDrlU8WWzugG9rpq9CaoCPqipAUADT0nAmZzMQeaUnPxzQB/r71VLZRfvBBSHHn7yGmSJljAo0rWjlOldSqEv7arEjKRsvH8xKdYakwOtNtMVwu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39850400004)(366004)(346002)(2616005)(6486002)(8676002)(8936002)(86362001)(6666004)(83380400001)(2906002)(5660300002)(31696002)(110136005)(38100700002)(4326008)(316002)(66476007)(66556008)(16526019)(36756003)(186003)(31686004)(6636002)(66946007)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emgvbmtON1ZoMVdTakNwd3ZVYlR5bCtrTE5sNU81RytlanQxTHlBamtBTXdT?=
 =?utf-8?B?T3ppT3NuY0l4SDR4anhjb01qWWZRYWtXbGl5c0dlREhhU3ArdWlBeTlkaHJv?=
 =?utf-8?B?alcydW5mRllQeGtCNVJLVEhYSzJxNFJwaWNmZTFEaHljYlhnNEg5ZnhlSGFJ?=
 =?utf-8?B?SisxQXhLSE5NSDVtSTNQMWhSNkVCODhoeEVlOTFXOUlwNnZtYkZHSlF0bG1z?=
 =?utf-8?B?dmpyd3lndGFxNm9qV014Q0NCamJzZDk1NERWclpZRkw5NXlZekdPKzdHRVB4?=
 =?utf-8?B?TGl1K3BQc0RHZXUxY0RJYk9JV2FPWDR1VzlpWHd1YXpDODROLzVCbmxvbHhq?=
 =?utf-8?B?NXJZSTRTajhkaWlRNitEdDc1YnovSStkeHNyVmsvWmYyZENjaDc4ekM1bmVj?=
 =?utf-8?B?S2pYWWNTM05hbHkzei9KbzFDNjZtcS9LbXloZTA1cTlNbk1OZ2RoZmVMT0pM?=
 =?utf-8?B?YXRwbjlCVkpnanpnejVWd2wwSERTNnhtclN0SWVQdW4vTFVGcTd1alh0T3RI?=
 =?utf-8?B?Z01oL0RXaEVKVjJxYVU0K21NaXhFdG9vV2ZOOG51dE4rY2ZIRTVOcGJyaXQw?=
 =?utf-8?B?SnJ3M3JaR0NUSzZZcU5yanlFb01Jd1B3U2lpdzN0WGhyZ3FDbWhGS0dWTmZj?=
 =?utf-8?B?MjFyWU9FaDIwVnVpaUdSbUNsRFZydTB2NWlOTmo1SEpkbXNaSmYwdXpFeEpw?=
 =?utf-8?B?ckhSc1kxUEpVYjVpZVZKQTh5eDE5WHMzR0xvQzladlZKYkdqcThlaFVUVjVH?=
 =?utf-8?B?THVZanlqZlhzbVRQdW55U0UxKzRidzhPTWpjeHZ4aml1N3Y4SjJtRytXSE5P?=
 =?utf-8?B?TlQ2VWRxLzI2YXA5S2VWWmxsWFRnUjZtTk1rQ1VsRiszWEwwTkhQL3BsVzAz?=
 =?utf-8?B?VmdtR2xMa1F6YUJ2NzJmOUY1WlduVkVRbHIyMGY1eTRSSS9OT280R2ljcXRn?=
 =?utf-8?B?U0hTQllQQm5jaVpoU1RIdmp0eDlmYkM0d0hqaXNWQ1NxMDVSZGlPa0hNQmFE?=
 =?utf-8?B?OFJSV01ieXdYSnB5RFErRVFONk8wVll4c1hKemVvTkg1MHR3U2VhYzBkNXhp?=
 =?utf-8?B?NE9ubGJiMnVYdmh4dWdGL092RDljcnNWY0NlSHkyN3J1QkdrWHoySnJmVlNX?=
 =?utf-8?B?bXNhU2t2MHl0UHRaT0l1aEhEbmR5YmtWcXF6L3FLaFJ6YThRVjUvOTVhUzJP?=
 =?utf-8?B?UnpUZDFLd1EzdGZXQ3BPc3pWb2x6L3d1dU5xaUFaSVlDSjZmcXpkL0cwRWFa?=
 =?utf-8?B?NnZHL1ZMTCs2T0VUSldjTGtLcTNncEhFdHBMbUx3dnBsQ3h1Z2pBZmR4RFgz?=
 =?utf-8?B?TjJYeVNlRlZjb1dydHY5TW5WbHFoZW1nTVJ3L2YrZ0ptbFVFRnBrTDBOUjdU?=
 =?utf-8?B?YSttU2lWaDFZLzZKdDlaVjYxa3Y5L3lNRG5wS2h0dWpzZmUzTHdWNHN3OU4y?=
 =?utf-8?B?QWUrTExSTFd6TU1qYTI2MVNBL3N6cVovSW9WaVUzYnF4WkIvOUdXa2J3SVll?=
 =?utf-8?B?a09Rekh5MGRCdERlT25SZ1c5d20rOUlrQkNVNUhlbUxJa2t6ZXBpK0FQN083?=
 =?utf-8?B?QUlIQ20zVlhiS0FCb1RIV2s4SEtQdHc0TmFjOHlqUm5TV1NvUy92ZFdwVERa?=
 =?utf-8?B?Mk5JUDdlQi9HbW1FdFNjZnpPMUpCcS9QNTBEWXV4L2hXRmlOWGQ3azFTdXhl?=
 =?utf-8?B?dzNmZ2lTOENFY0w1Ly9qbEV4Wjh0TGgxK1VqYVRsZnNOeFJjWENFZ3dZMHFr?=
 =?utf-8?B?Q2QzSjEwclZEcGJyWHlUa0JWY2xvK0dOUGlDYTE5U3IxNnF1R1MyYWQ3TEpV?=
 =?utf-8?B?Nm9mUkpYVlFtc0tyNHJNd2tsTkJqN3lCTEZ5WWp2QTRBb1pjeU5jYUYrQjF2?=
 =?utf-8?Q?VZ/XroQYYhywW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5b73bd-d9c7-43e1-af6c-08d929c0e24f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:31:06.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8UbAJmDSqIsnFwKIcj+MmA+MZmMqi0m4dYSCTeAXv0hfgQaNJ6PpZSmyPEKRpy/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: Davis Ming <Davis.Ming@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Why are the ring 1&2 enabled on SRIOV in the first place?

Christian.

Am 07.06.21 um 16:23 schrieb Rohit Khaire:
> This is similar to IH_RB_CNTL programming in
> navi10_ih_toggle_ring_interrupts
>
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index eac564e8dd52..e41188c04846 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -120,11 +120,27 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>   				   RB_USED_INT_THRESHOLD, threshold);
>   
> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl)) {
> +			DRM_ERROR("PSP program IH_RB_CNTL_RING1 failed!\n");
> +			return;
> +		}
> +	} else {
> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
> +	}
> +
>   	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>   				   RB_USED_INT_THRESHOLD, threshold);
> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl)) {
> +			DRM_ERROR("PSP program IH_RB_CNTL_RING2 failed!\n");
> +			return;
> +		}
> +	} else {
> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
> +	}
> +
>   	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
