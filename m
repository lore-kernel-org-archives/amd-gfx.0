Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DDBC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 19:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F27A610A7
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 19:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F27A610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06396E512;
	Wed,  5 May 2021 19:59:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738636E509
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 19:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVH5eGlrldJREYdDKiyr9AYEPcQh0MyWGfTFwTMpZKnyT7xfY7zVOmoHoCNRk/rowAy4J/llHiSQAaJ+05zs9nqf0f9/ySdFzj9jbHqs1caecPwnui4j0+xiYspmq4rrNmEOYlt7YjUzz91cQNfQcQx6QxaahjQc1LaimWJrlAIA3ItcFRxOOdS9h3sIm7QCdFtzKQ5t7V/FipnpzSarhf2dT8m0wBpdcHHEFnSU3iatKEC39ZU656PhdRExRRGaOxRlKpbAT/V2hk0f78dDDbBfBv2Suak6AAVMRWM7016ejL6+6SoGZkdi5r+t9Uldui5ooONm5cQ2N+2tafU1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1utLzNf83dzQNkyYoMNvTL5i31QnENiyzZbBHq1hBIs=;
 b=ij6hr12H8mKYGdeC59KWwRZ4FFA7IeCqXSnyiv+Sz0B1Gvz674X5rt5EciJNwJ/Nzoe1FBYXMYoQpg8LCmPerMfucuT3LeYtUuNEICBvASU20Yk+r1aitiT1lstPMdCxI8XZkVYrQvAqbF40Z2gKzN7JSgBvf5oir0Q4Fuzk4eBjJ7z/pyD4LvJT1YuVhV5DZKe1vNcMt8+uZkWFzweZ6HdLzs+wMuUxfjXK80WPq87NGYlmt7LkuVZSprcbeL6WybSg8KDzG0vcvx6v3FZN8VTJdDpmYxIwrHMn5F54LyXJwvFw0pKhkChmnayxQsGoxgpwlpsdpk6AkvYSUbNqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1utLzNf83dzQNkyYoMNvTL5i31QnENiyzZbBHq1hBIs=;
 b=ocFe4zzyaFXsQCXMi5SS6FXpbmFxQfiyilKkeFwQ17oXf2nIgzA6cqHlQQjYxbjsJxfThRXnwPiHZUg83gxFXAdPnZBI+Wene9Z8JDMWbo6mYrVysf8WRt+fgw5R1p0ubR/JrEGZSszdQfms2QvBuwIR2P0H/aP0JKbbXOBOZaY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 5 May
 2021 19:59:06 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab%3]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 19:59:06 +0000
Subject: Re: [PATCH] drm/amdgpu: update vcn1.0 Non-DPG suspend sequence
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210504151004.13749-1-sathishkumar.sundararaju@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <42a96eb9-33c9-00a7-b54e-797d3be3c4d7@amd.com>
Date: Wed, 5 May 2021 15:59:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210504151004.13749-1-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:e9a3:7447:e8de:9f4]
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:e9a3:7447:e8de:9f4]
 (2607:9880:2088:19:e9a3:7447:e8de:9f4) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Wed, 5 May 2021 19:59:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03d15d3-328f-45bf-0533-08d910003d46
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01699D2FF17741E1BCE45A57E5599@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfzD8q15Up873m/3Kf3L2VyznuDNHGu2MHdzPXDAJp8vL+YjEW/4y1ooho+z1DXG+WYeMEbgeZJ0/BkIERtYJDSn6Imb/wYmHcuVzsiaR+EsIJY1foHv7HDuWbxn2tvQgP6xqizOT1+EF/7+thdKVJlplbSamJcmxRtDVPvp8mkuuhQBrj57Lz4parKHzQprffP20oi8xf01iNgeGKZTpHb/jsWPwMhtj1V+AnESWh7tCeKEy1MPLnz1CaI1IdVJj9tAzEpABjqeeKhqzYMk46IevKegqtC2QieWn8WO8q8HXp5tqldWyujkbCGya4ntZkdwcV+/pjwxCRg/vVrRnslA8LPBJQ1PJxoixFRMQwQYQALQBgTxLIu+4ghOBtQZxfg8SIRrRMJwje6n0Uvhats2eTC970y2xJRkFPvlnR/pWL1DdhLJQFicbwL32wgWdpAxn4toa3+rLVH6H+pUC68dZ17iz74Kj0EZqJk41EfWsMvGjkrNnAg0A0I4RNkHPmxvxyasMmkGC6cBpJhEHk9NtvNaWxfDK3Kzelwbmygi1ZAGcHYPi/Hg8ojPt/RA3GCrdw/aFbqeDL7GwjkMyIKT0oLdShe78oOogltvBpe+3XoP0elFk5Z+tKyILVdlrL7G0xN5zHQw+JZOV/6Q0eb+STw4X9uL8UhGntedqz8Eyx+i5fE6mxEtsmeNhurQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(53546011)(66946007)(186003)(66556008)(16526019)(52116002)(316002)(44832011)(66476007)(5660300002)(36756003)(4326008)(478600001)(2616005)(6486002)(15650500001)(86362001)(2906002)(8936002)(38100700002)(8676002)(31686004)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SzBIQ3ZsTENqUzJSS1plY0t6cDRkT0pGVkMvWXduS0JaS1J5REV2bCs5U1hs?=
 =?utf-8?B?VWczTmxFSlQ1OWJoRjJIcUtHZFJJaWRkZU5TY3ZVYms5SW56RXlLNkFTVXBl?=
 =?utf-8?B?WFFFelBUV3U2Y3M0WGZqUHdvdXRZSjhmUHJQVndzcUs5NjBSWEFYd0pPUStr?=
 =?utf-8?B?Uk90WFJ3UHZpWlV6Nm5VOUFWZ2QvWEtiMWltb1hZanQ3WlBqaEhKb1pjMnJq?=
 =?utf-8?B?S3lhWFd6N2ZvcFFyWWl2YnpwQmRTQjhUdFZjVzhRNUJRYVdmUWloQjdYM1B3?=
 =?utf-8?B?dTJsKzFpdHhjVkxJWis2b3VmS1lMVG1ETnQzMFI5SklqVEtTUVJpQTJ0c2Ur?=
 =?utf-8?B?aisvUzlPelZGSWNHN1NYYmxrMGZOTXovYVBCVTJnZllBNXJ3Zkt5RE4wbFdH?=
 =?utf-8?B?WVNQSk9GY0ZGS3FRMi9ocWRZSjBPTUNaVFFKeCtzV1pJNU5NWlhxN3B1U2Zt?=
 =?utf-8?B?ZHlKZ0xINm10QXhWZnNsQ3RrZGJQUFV3UWVKTHBUcUFiUjNPYkxTNXVDSWR5?=
 =?utf-8?B?dHd4YnVjTjByYXNoTXNPQWVGdG9XZFlsdE4rUVNlUXdvemNnbW5ReDdkbjVD?=
 =?utf-8?B?ejEvNkpyVnRpanpISUFyWm91dHRUSTdwUGhrSnYvNE1CSkhWcFFvZVFtUjRC?=
 =?utf-8?B?U0lUYlhkbWlLbFFJb096dGNjMXRpV3pKK0lKQzBaVlJjQitQT3FHaURSb2lp?=
 =?utf-8?B?U2Z6NFp4bE1zcnJIOFZ4VGlIUC9oWDlxRUh2eWtuRjAxejZWaUlzL1FoRWpI?=
 =?utf-8?B?NU5YLzM4dHh5RkpZNnU3eDR2NXQ3WWhxUGJtL3Fuc3VuWGc4NkkvSmlkdUJR?=
 =?utf-8?B?b3FEbGdMME1qYnp5ckgrS3NWUW5XejZPTHQrQloxU09WayszKzg4enViL1R4?=
 =?utf-8?B?TE1tS2tkYTY1YXVSQnVMNDRjTVJPL2x4QXdvMXl4enFKT1RrVm1ONVJtT0la?=
 =?utf-8?B?czU0c3Mvd3A2YndIUWp6c2tWaE1nbzU3bU5IaEhsVm1mZU1od1lZQ294THhC?=
 =?utf-8?B?SS9vR1FhOWJDSFI0S2RwcXdWcFQ1VU1KcndUT0M2MEErNzNKWEwwY0RuRm04?=
 =?utf-8?B?UFBXSk9KMGRoUGRURW50MGJzdFRhTUpUTGNyOXhqQnR0Si9rK0N2bDBYdGRr?=
 =?utf-8?B?cVBnNzZDdFB6QmRGdmgrT2Z4OURaMnc1NWg0ZFhnQk1iRUNteVVPYWxrdjB2?=
 =?utf-8?B?ZzBzVzRnUEJkK1AwN1lCbW9lTUZVaXQ0NDBVZk1iUzd4KzFscHdOREk5M2Z4?=
 =?utf-8?B?dmUvVHhGMEhjV3JCNW43N1ByWWNjZjljSzlCY09MdWF5cFFod2tUdnd5Smdp?=
 =?utf-8?B?OTRibEVKcUlhQWlSd2ZOR2FObTEySTNIakF2N3B0SjhIMVdINm9TNE0vaXpD?=
 =?utf-8?B?RHFUME5tL2NpRVZLTEFJbEo5RHdXdW9HYXpPZCsvV2tGbTVUNGtXY01XS3Jm?=
 =?utf-8?B?cDl2NWIrbEFtK1ZPTDNKeFk5L3lCVEJldyszbyt5N3VWYkphQ1RxdkZsb1pW?=
 =?utf-8?B?NUdaTFZvRmtXVE1tTElFMW02SVd0Y1ZZQk02MGx4RDNVSksyT3A0ck16RXN6?=
 =?utf-8?B?cjBQbzlkdWwvRHB0b0ZXcTkwMTBQdTk4aExPN1BscHhrdXorM0tGUkVGSnN0?=
 =?utf-8?B?MkpsWTAwNktBanpRLzhuckQ5a1VRSzVERkE5VnBhaDlMVm1YeUdQVk8yWFM3?=
 =?utf-8?B?empOeWlmeVhYaHFZcnJpY3FoRW1mNGtxbjUzRHlIK1dFUFlSTHpUeG5DaUNS?=
 =?utf-8?B?MUZQNExlRGh1TkE1Zy9jKzEvSXh4aTBzVnVWNzliUkljMFZ3VTRzSDl1N1Zk?=
 =?utf-8?B?MGYyODMzaEVHQ3hjaE5nem15ZFZ5OXNMK1gvSlJMeWFqMGpsSVY2WmRuekdx?=
 =?utf-8?Q?y1Rm1pB7pJAOG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03d15d3-328f-45bf-0533-08d910003d46
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 19:59:06.5778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0kMqoY1vfnMvBQnGDXEM04bhI4fQ0ZeldRlEZXEm6vkG79iPN7VgDM/3Eb67X+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>


On 2021-05-04 11:10 a.m., Sathishkumar S wrote:
> update suspend register settings in Non-DPG mode.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 51a773a37a35..0c1beefa3e49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1119,10 +1119,10 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
>   		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>   	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_LMI_STATUS, tmp, tmp);
>   
> -	/* put VCPU into reset */
> -	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
> -		UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
> -		~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
> +	/* stall UMC channel */
> +	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_LMI_CTRL2),
> +		UVD_LMI_CTRL2__STALL_ARB_UMC_MASK,
> +		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>   
>   	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
>   		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> @@ -1141,6 +1141,11 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
>   		UVD_SOFT_RESET__LMI_SOFT_RESET_MASK,
>   		~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK);
>   
> +	/* put VCPU into reset */
> +	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
> +		UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
> +		~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
> +
>   	WREG32_SOC15(UVD, 0, mmUVD_STATUS, 0);
>   
>   	vcn_v1_0_enable_clock_gating(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
