Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163FC4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 23:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491C9613EC
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 23:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491C9613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E919D6E41B;
	Fri,  4 Jun 2021 23:16:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332876E41B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 23:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWCAGygNB6Q1Nqt39U9jdzU8MYmcG42+79d2k2fPW3Vhq3F/OzM15AUgS6d0+BpF6GvTHKafl00QT6hvVI/6vViRTI9vkn34m2JqxJRloi1P30XrtAIL2WRmcMn37SUb6OOV4IglrEkdNXDNKspQm0o+0ZQj9bWpv0q5YnQplaXT+GSnncwnUiVIPepenlIPgoHGzpnPxFvSuz4V52soPVkzy6z+no9k91UKB3qnCqf0x+ZoaDFkMq4oIEQ223Io6E8P2MTn6fXKwS9poHmuHQOiqJ6s4Jsd+4Jm8dKW8vtSy94tdKdYU/wzrEQ3WfyKDZlRcdQLBDGoFAAC2BiPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pngB1OrWe5jqJNAjUONZjX2W8Wx43W7W/vNmj2VyTOU=;
 b=lahFNKZvv5MQFeZHX4xnVC1vT71Xb0C58Rn9TIuf5yCfHGaYpF4sv/ODu8LF02YOXFYoQj79bs3MdhvYxusTwEZ4qJuMg4VeGWBxJ4gD/cgmMWQ3OA2JrNWnXsE2tDTuiNakBe3ZJc9MlwfaVzGQQkL9FdhatCqsi/YMzyY6N1ASChEh0OWDA5NRC0tJDSwR1Gtdus6dArnT3wQMBP7BzF6cg3Xk+wTULBzu3cPXxP6JlSLs50e1sAAQ3nEXDabQvKUz08iyqFAJjhMNh2+t3LfiQEIP/9uaBHAZskOdB01YFL4mz7VWmdt+yd+lczjlwvhqGGH58279fb3xFH6GqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pngB1OrWe5jqJNAjUONZjX2W8Wx43W7W/vNmj2VyTOU=;
 b=Vy4OsX3fvRK0YFFWBm1UOUUwxa4XQPSk3SGbW/hr2t9cHX5jp8bo3JyuQvq+cM5H8nbFxy5KO8Mu0f28BIU3pvwCYtDEmB+rhVSKp3s6xcXT+FVy5DNjagB6ooC4jlpueWzLTFDc27vlT1cIN3pwGxSW1Jqfmug+mOnZJvlNqqw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 23:16:08 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 23:16:08 +0000
Subject: Re: [PATCH] drm/amdkfd: pages_addr offset must be 0 for system range
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210604231039.27518-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5d4d8539-0b62-ef5b-f029-034c3ece13ec@amd.com>
Date: Fri, 4 Jun 2021 19:16:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210604231039.27518-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Fri, 4 Jun 2021 23:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1cecab0-5d4e-4856-5919-08d927aebc23
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5337075F8D90BC280DEC0A87923B9@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cvp6+MhvoQg5pHmpxpydiejMDtVFDRHlU47vY9imsowS2TkybB46lWSdDjKanON6A8KioA/ITptxGFKMiGeX7JDAfaUrhfNP3nYI4W4AjWzNA5Z67iQlZ5kyGaaGjMUSegczbSka+wNfmloA9XFydrisUhu2ZL6GneZeb8UNTIEF8GjH8M8kqc8/lepHweadcN8L/+TvktnSqHKA3nJhbBZizcNCZ2KcJcxKoxLkbzNTuSD4RtJ+b5PJija1O6DMioTUnVITvgtS8qh05cYL53jAXBjsukLXJZWTn1jR3zKsEVqtQtcIs4R+jPUBgKQD3Aq3a80xAhaQ1py3g7TieOg5fhSe7DxHM1W5HiKeYsNcL02PN/SxkejmXo9DMK7T1H1w2/HxO/EJfB8b1QVA/MHszeSGSbx82VgDCvbPmbUUbp4AWXA5H8txALvPKCPnUIxdj06EYDHncDuzOc57xhbOR9lQ04So0G/G8eFPO+c//S/iumUK25ksH+5IBNJ1rG59oAi1LL09ouHqKl1VOuTwdCJMqIT3MnXvHb6Ky430h9KtW1X0//JMdvVrwYQiP5N055YanE8dKFgazPyLXQYpZdA8PQ+i97wYk/VVvfxPRJYtjeOLiLkdrd8GOccHYdjmdcWVDDffxPgsqsrsIseVJQEKUF07urP+bORneI9+wfZEsv21nanvn3PDxcvb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(8936002)(86362001)(31686004)(83380400001)(31696002)(478600001)(6486002)(8676002)(5660300002)(26005)(66476007)(66556008)(66946007)(16526019)(186003)(2616005)(956004)(38100700002)(44832011)(2906002)(16576012)(36756003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZFZPS3NmUW4xUy8vNGRSM3V0N0hwbEFSVGs3TnM3M3JDWjdlQkZBSmJobHU4?=
 =?utf-8?B?N2NSMlZnQklvVXhPaC96aEtRRjJlOXM2WC9EeWZyTEkxK0k1WTFFZTlsL0JW?=
 =?utf-8?B?dlFaWEdGZ3A3TFNsMHJ5WDMvSkVsQlVzUlZ5QUFXV1Z1N3FHOTJJYTg4dUEr?=
 =?utf-8?B?ZkRaV3pORlBRTHJpSFY4dmdMWTk2SFUxaUtoU3Q5eURzdnNaSWZRZFIrMmhy?=
 =?utf-8?B?dzhGWTF4MFNkdW1ESzBrd1JubnpDWXBTSGk1cFp3WWlhRnpEeHIvWEZPRDNV?=
 =?utf-8?B?TFhhbGdPVlFWVHFuT0JTL01oc2s5NUtRaFNQMzlOZk9zUitOVHIxR2QrY1N3?=
 =?utf-8?B?YTZ0ZW14QmdyRGZITE55eUZGQUlxZkhsSzF6NjZCNWhJQlBjRHdBeExJUWpw?=
 =?utf-8?B?RkJqYWZRbzVrMTRBeFFFenhrcFZxbUhRTUozcWdLdEpPRElLWnN1RjU1cjJz?=
 =?utf-8?B?My9xcmhhRXRxaVo1VU9hYk5abW5GT0d2MkY3K1ErQi93RnBEdEdrNkcrN0R3?=
 =?utf-8?B?UjhEc0p2Ly82WnNjRm51ZDB0YUYxR3pwZ3kwRlVRWS9Oclo2c2ZHS254L0hU?=
 =?utf-8?B?NEhZbzF2SVdDNVNqaGVkS0lERkhYeWxOUVk3T2RDOHN5Szkrb2V2UTI0N0Ix?=
 =?utf-8?B?eDVhRjU4T0NCK2pOcVVza1ZpRWM3cDh2S2RXOS9SMjZRcXBuWDdqckl2Mjk0?=
 =?utf-8?B?N3RMc3RrUFhKUGpyeGNNK2tTOS90emhUQlBtRVB2SzEvTW12Vis0NTNNTW9x?=
 =?utf-8?B?RVhwMXJGckZmYUV3UEFVYUNXdXNvTlUyb1hHQkh2MnUwa1NITGV6QWZmT3dF?=
 =?utf-8?B?c1A1c1U5Rmd3aVpDS3ZqbmVaMzdsYzZsTkpXcHdFYjY5V3QzVCt3VHdOMkRO?=
 =?utf-8?B?SSt1SjhNVGsrVWFHN3pyTmJxSFNOK2NLMG9JTGxhN0dxa1VEUU92NU9MR1F2?=
 =?utf-8?B?OFdEVlEzWktYaUxVOUF0NlgyUGRPMmkrTUVnbWE1ck9VMGlZTzU1SE1CR0Fv?=
 =?utf-8?B?cG94blIwYmlaTERFek9zdURSSTQxL2Z2N0tIcWVpQzBWbE1vNWpWMFlIb3FI?=
 =?utf-8?B?M2lRK2tOSGFJQWNoWXpVZTkvNFFKSnpFdk1RODRJdlBDZEFlUExkUlFtR3hs?=
 =?utf-8?B?Q1NQZDBGUDhkcElkNnFpS1lXVHZmZjR0RDVpdlhOU0dUUkg0L1pVUWJoL2Vw?=
 =?utf-8?B?NlFoVDBaZzM0QU03TnBuVUZUU3cvV0VVQWc3K2dKbWxzOS9GY0RIQU1GR2d2?=
 =?utf-8?B?cnNxWi9JNjVoSkdHdkJZZ3ljb2NJMHQxTllOKzFqZHF1NmNjdk5rbEFKc3pm?=
 =?utf-8?B?TWNYM1FYbTF4KzQrK3hWSGxPRGxWTlIvN3ZoSjE3ZmxDNWx1R0NFZGYyZ1Zm?=
 =?utf-8?B?bWhoSWlGNStWS3lTdnV3dWtCVWF0RlF6SWFSM2NaeWpjT2hwZXp5NUNHZmRq?=
 =?utf-8?B?Wml0YVVOTDhTNFdkTjFKdkM2ak9hT0JpNWRObTNUNklna1hwNkExRDVXY25K?=
 =?utf-8?B?ODlEOGQvTGVKR1ZIRjlxcm5LZGhjNXo0aTZqbEVNUnVMMDVxckpSUllKaWhv?=
 =?utf-8?B?ZFBEdHpJcXRaRmlETzVoa2Mxd2plN05pc0oxSGxkTkpjblJvM2FzNDV6QUtC?=
 =?utf-8?B?U2R3NmI4V05wNGNBTG56YmZiOVZaYU9XVy95THY0NlBtZkRlZnFDUzBpSkVy?=
 =?utf-8?B?UUJlY0hOTStuYnowNnJuSWY1MjdEc3pzL1haaUp0dnhDdks3OG9FcDE0MjlQ?=
 =?utf-8?B?eUpaYzViZXBOMXJBQlpvZHVGM1FxalhVNmQ2MHoxQkpWbWVrTi9xRXJxemY4?=
 =?utf-8?B?dTFXRzRuT2pnWmNRUjRDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cecab0-5d4e-4856-5919-08d927aebc23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 23:16:08.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mj6E09HB06CFeBgEpf8vIGrri0cIJO/OHHDc+xWff9F4oaHZCgl9n7mgTY8BTG+5AVDqDdkSGjiRi2BQRcUiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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

Am 2021-06-04 um 7:10 p.m. schrieb Philip Yang:
> prange->offset is for VRAM range mm_nodes, if multiple ranges share same
> mm_nodes, migrate range back to VRAM will reuse the VRAM at offset of
> the same mm_nodes. For system memory pages_addr array, the offset is
> always 0, otherwise, update GPU mapping will use incorrect system memory
> page, and cause system memory corruption.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2901e7a993e..0f18bd0dc64e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1153,7 +1153,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	prange->mapping.start = prange->start;
>  	prange->mapping.last = prange->last;
> -	prange->mapping.offset = prange->offset;
> +	prange->mapping.offset = prange->ttm_res ? prange->offset : 0;
>  	pte_flags = svm_range_get_pte_flags(adev, prange);
>  
>  	r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
