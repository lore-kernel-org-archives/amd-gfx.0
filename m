Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD12DEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 07:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E75C10E012;
	Mon,  7 Aug 2023 07:54:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF2610E04E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 07:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhCMFeN54y5AYYNPd0voWJRfhhAAiuQElzYEMTAo6JCnU1sObifKCPKbp6lUPlmYU+xh6cF43FxPuv1XBVS/9XEth1FaYeM17qh4oknNcdyN0dcfWcmoItTaRwmymbn7flV2LVkPG+TGnSh5lDuqQzvtHvpP0PvCkeC/wtZYwQ2UP0JGGO4+Hgrm+xGJXBzs2e67IkegTHGm3/WzbT8rT77sBm6roABpj6/KZ5v23W3RSdGglqrX7zdv+qcuUUma42Z2IU2rRl/EwR+p4ga/TUWYsIpz6yFDSFvNLWMOFjIy6ziamMJ5GDDNeV4xBfdzjeUez/5p7iU/oMbAITb95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpYap3aujxa/iDqRiF/qlTBfogxW3eOgwtloaq1XBcY=;
 b=fHyLdeJmEeMVtqDnrsBeNWcOE50oEw+qEVCXP0DBQNIxiCcr2U9XoYkK7YG6IdECZq+LXFh/xQV+pZxjng3TafUIVP9xIfJ18qx5CUFCEJYHMfqv8lscYLfHOEuiRqZnVqhn2or7BwTYphqJrhXjjxQG64MUCs/vcf20EmCS1TZJxSKT1EeZZpXvPyPUoPrCM/1rXfQS8IdAlLoqcqQzNmejwcxFqy9txhHVGcvPEU8jVArximubt2egru017Wawxo+LjokRg3LQByFAMpjGogPZZsbVfejeg5XghNejbmnR0h+wH5mCw25Uqgo7EDW9Mv8VS1fMw7JCm8iRx6rMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpYap3aujxa/iDqRiF/qlTBfogxW3eOgwtloaq1XBcY=;
 b=uN0Aln6+sDV7BXi5KT7u9SVwpTHFQPUX7wsqL9cLaGQCdfVBOeiaiAifwUG/uT+FxdfaHY2h6K5XAKRAWRGUmzYrOvWEkksWvTIduYtOyMa5wb+x8u77Zu3zTnXvWVyxhllzQysFcZpexNq3CTTjbeJMSEz68a+e8CjRENG0PDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 07:54:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 07:54:19 +0000
Message-ID: <b210c774-94fa-7856-ff94-be1142bb30dd@amd.com>
Date: Mon, 7 Aug 2023 09:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Fix identation issues in
 'kgd_gfx_v9_program_trap_handler_settings'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230807072352.117420-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230807072352.117420-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: aefb611e-2c6c-4499-967f-08db971b8115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sfP9FowKR/G1TROvN1kx7vnL7MlhW8d1aVygXfqwPneu/4wSVEgLeuveUJsy27Cm0IMSCnrX2R6Tem4yJOjUjHdPzuewyoMdKh4Yq3W66LzJA+8RahP+ukFdllSmx6ai+gRQMVBGir1PDmzRiCBrluOf742jnIgqP2MZmUMytFdYRy7fLnNepBzinUuqCUvjuvdzO1I92iCaQ5kwKq4LLVlR3t43NxqOXeJ0uh7yj5qzkZYRlzXrVWFK357KDaC0gbwj+Fuo9ex4KCISMRhGba85EWqhlAn0G3uPTPrX9Ad+Qr0pZr8OMyKubF/hAje1+kFqqZKI8re5uzMTPlAzBLFNys5QODs+Tud0MPAWCWPDgi3BmeKjbDsDU8sYV4bYfPyzL74stKoty+SWUZZ/OaRhmNmkp/Zs5O4GLmVdI/bUBBnNuSBEQFaQxqYWl4DSz0ygN4XUXtZuv3JuR3PRneRrBhjGBULhYLlUqZq5q8d4OfeKoJk6KL9omTkuS6iO+esY14t4rOuD0foLahtgJ/RzGwUymBdddIRzty5zvpcbO3u34YU2iBGY5ESDZ4XJ+qcYaMf/J1bvtAMbaf7ojDOwGE7ZmO40lLlBCSytJxRsXLQ2+V1QjEh8knFN8c24Y/K1BOrK5NzAiK4/FP4Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(186006)(1800799003)(83380400001)(66574015)(31686004)(2616005)(110136005)(4326008)(38100700002)(6636002)(2906002)(5660300002)(316002)(8676002)(8936002)(66946007)(66556008)(66476007)(6512007)(478600001)(86362001)(31696002)(6666004)(6486002)(41300700001)(36756003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG10Zk90WVY0U2ZGU2pGOTY5OTdsY2dCSVNoSTJrRGVtcXdwRitYclozTXJm?=
 =?utf-8?B?bXZIekJpRE92QjNoREhDM3d4cXZqMDRtSHNLN3Z1RXpBNm1GUUZkWmZqSUlK?=
 =?utf-8?B?UjVTcTBlZENscmh3Z1VUUUVYenpucFRuV0NNKzdPSHIyQUlzRlJQbUFVcVlO?=
 =?utf-8?B?L29EcEhDcFNpTW5KTW5yZ1hsRVlTd3A2UXl4Z0JuQmFMdmdGSVhBVUNWR0Ru?=
 =?utf-8?B?UnZYOWtEdFBjMXVocFV2d1BuamRtU2o0UXoyTzRRYkFkV3hDdFRmd0J5WnV5?=
 =?utf-8?B?dE9rQnc5R1F6V2FaLzFvckZGTHpoZmJDOENLQUZ0MFpoR0RNYlIrVDJrNVp3?=
 =?utf-8?B?aVl2SWNjeFdtalR5RFFZZStLQm5FcUlkQUZiNFVFTm93STFiQnNXeEQwNCt1?=
 =?utf-8?B?RDFrSjN1bFR3eURNcUdoQzMxOXJZRDllbHBmb2Fma21PS0g2aEs0RGJ6S0li?=
 =?utf-8?B?NUpuMjVRUUFOWFVYMFVGSHlqZkkyK0pEN2hYL2xmbS9peHVRcllsTUJGaVlJ?=
 =?utf-8?B?cFRRSlNTaGh1L0J2NFRiYTJZazFMeGYyU002N1BUMVNXVkpXSE92RDdhYzJv?=
 =?utf-8?B?MUVKczFuUXJpeVZOZG9ic0dUNVFYRmZ5QkxmVzJwRWMwdHJ1UXVvTW5uQnhj?=
 =?utf-8?B?NDBKWTV4aVY5Nm5aM1hrRG5QVHZneERMTEMvVzdjVktod2VGeVBJcTVvajFT?=
 =?utf-8?B?dmYvYURjSUhjSXgyNCt2VW9tSllkRXpYSVAzWmo2Uk5kUlM2dkxzcmdEdlBt?=
 =?utf-8?B?ZlY3UjQ0dVhkbmxCbWRIUXQ4RmhUcENnRVAwNzF4dkhmejdzUEdrUzV2ZE1J?=
 =?utf-8?B?WTQvRnE5cDNTTGFwenREWm5vUjdSVDVaVVRIRWFaR3hVZzIzY2NpK1gyMm5D?=
 =?utf-8?B?MGdtaDhtL2RQSzJsRTFUWWdqME5DblU0ZlBMNXhWWnBUOU50U2VXOFAvdHRC?=
 =?utf-8?B?aVlNakZSTk5kN1JiZEkzRzZ4ZVNtNVFZNllJQU9oK0dTZHVCT1ppVG95YWVW?=
 =?utf-8?B?RlBESVpMcEp6cHZ1dnF2YVdUbys0TU1vTXdhTlMrVHRGdnJQRGdxNUxiKytC?=
 =?utf-8?B?SFZjVmxZVDRDRURGaDFBb0JRY2FnbTdnckZMZ0NhM0pZUi9QMEZ6b0pGcnA0?=
 =?utf-8?B?RExxMjkydWYvQTFUVE91Qmwwa0dKN2RwOGRQZU0yNkhSbTk5RCs4N2k2UXIx?=
 =?utf-8?B?bmhJSzVaVjZLOXF2RlUyVVQyTG01R1c1TFo1MWMzMC9vR3BBd2VqK0RXRE5s?=
 =?utf-8?B?UUltYUdoMXA4d1JkTXpNZlFLaWVoRmRmQ2FZc1Yrck5PL3VXWUpRblhnN05X?=
 =?utf-8?B?cEd5OW1idVJHSVpERWZpSFcwK1FxdDg0blgzTmdOZkRYLytNZnhzbXR1QmFK?=
 =?utf-8?B?R3Y0OEZ1Ty9rMUJkSW44NDlOTFk0bWJ6Tk9FQ216Z0drSEw0VW5JMVV4UWo1?=
 =?utf-8?B?azArMXRReHBsVUhibkdvRTVMVk5NUjJQenFmTVhhSnpZYzc4bkJ0Y2xFdmdG?=
 =?utf-8?B?YlFLZmFPOVFBQ2xId3BrWmF3NFkvTEIyNkFBZDdXWWZwY0NCNlM0MnpaYVIv?=
 =?utf-8?B?K1ZpUW1wOVg1QmR3YSs1MVpFcVZ2dUp6bnJwcGRNd2JqU2hQaUFTQU9mZldj?=
 =?utf-8?B?ZytkOEFEV2l3dnhWTnNOZHlIcW1UeVhMZlJBZTlEa0F4NTZBVC8wc1B3dW43?=
 =?utf-8?B?enBSLzUwWDQ5Z3pLWU9wMG9pL254M2xmUlZsY0FlVEx5NlRUVnQ0VzdzRzZS?=
 =?utf-8?B?WHhwc1BPZWRYR2lHZWlHaHBHcW12TUgzU1hrUXRtR09MNkVTajZtaEJ4aFBo?=
 =?utf-8?B?SnZzVVI0S0hPbTVVWTllaWd2aVk4dUREMzd2UFBCVnZTNFY1aGZtTlgrVXhL?=
 =?utf-8?B?dmNmUFBSN2lsNTZFaGVWR0g2c25nWjlHRXdGbUNjRVlheGg4N2VhbDA1NHBW?=
 =?utf-8?B?WG9yOEJEWWR1bnU2TFZPZXI1eHZVbFBCelZiako3cWhtT01lUFpyektlcEFE?=
 =?utf-8?B?RVgzdTNNV0l0VGszaDJyYU9YOVh6ZlRnOVVDS2JXMzhRNlRRb0hCdG82WStD?=
 =?utf-8?B?MVExV2RoQVNjeE5naHdDeHlEVkpkakVCTDgzb3UrVmtuR2IwL3FLMlpJaDBR?=
 =?utf-8?B?dEVxN3c4QjJyVnpDamJLVXBWQ0xGWDRmMW1PZCs0dURwM0VmRGdjWmtlMk9U?=
 =?utf-8?Q?SVxho7tJvRfDMbLoXbFL1Tn71wDSqb6GBa4W8kayyKDB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefb611e-2c6c-4499-967f-08db971b8115
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 07:54:19.0728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRlSiSN33KTqYsyGMVHPUEnq9R0IsKKQStoFe6fzpvJMX+ypE6rrTmJ4heaTNTs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.08.23 um 09:23 schrieb Srinivasan Shanmugam:
> Fixes the following:
>
> ERROR: code indent should use tabs where possible
> WARNING: please, no spaces at the start of a line
>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 28963726bc97..fa5ee96f8845 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1133,9 +1133,9 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>   	 * Program TBA registers
>   	 */
>   	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TBA_LO,
> -                        lower_32_bits(tba_addr >> 8));
> +			lower_32_bits(tba_addr >> 8));
>   	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TBA_HI,
> -                        upper_32_bits(tba_addr >> 8));
> +			upper_32_bits(tba_addr >> 8));
>   
>   	/*
>   	 * Program TMA registers

