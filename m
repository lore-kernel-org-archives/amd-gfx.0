Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52776C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1714060E73
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1714060E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7E46FA3A;
	Fri, 23 Jul 2021 04:10:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429686FA3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 04:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/F+jCf8kLUAuGELDOJn7JLMDhC+MzLrlfb/cZOiEh42WmbNaMxbkP1657P4gQrQr8tweiOOSEKj7gd+AsWvuR8VtBPW4IsSSuU6tOcnFxGKDb9k9n5RTWGo+lwesrsCv6EQ+tk4aLCBWZ8nuPWVsFjgZ6ly9mLwsNIaJP9qhTrTaCTTu/mejB376dsbYrbOAMtCO/pwd/aRxgG8DV2YgyIOV60HVfyN9vFvUfLwsWbusiIc8uS7APpX7pJy0p5Dwjj7MSdppEgy4xPTMlnxk/1a31zn/rg2GwjTJ1uRuNPXdJqoAnjsAfdZ6k+b7SqZ8xYMHd+MivYYWrFXFbzjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqvuSWu7PLzdS4BDLvFyydzCqEd2UXvsBEqlpCq/Sok=;
 b=e4BzCO7OkQ7+JHWwShVmYg0LuoV514+GfwphvSftlMrUMQfrxk/XXJlG/MHDXJ+4Zf0AMmykzErP0GEPGAQDIS6R2H+vOVoB8NsJLPOHy2kZQpFj4yUbK/r0L8QiZhO5+9fIy9S58tsPxOcywr0VwAmc0zoXXXZZG659GUIvvEPWXHNfyJEUGZ+07YshaO4rX3sO1tksSMzY4qy7XDazmGNo66KyqoG1X5urIz04N/Xalb0pg1L7YLqfn0PuxgJknj+F/iqIa6gL36D00TbMOrZUBruC8bGhtUR6vqFG9Se2c/0XQ/XIgQT+RZELOrat/zCta+JlfqySg0ZrzuUlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqvuSWu7PLzdS4BDLvFyydzCqEd2UXvsBEqlpCq/Sok=;
 b=rE/ksYocKRPtqhpX6iRUmGqGJdblNw8pkTM0qHWxI06UVENDnBXQsZzQJb0nzushdf90HDwVKBNdtkb5QoufH1q68EYyy03ClOHC/470R3Io3ETTWlTpWW+xZdwzT7Bz/LAPy3spntB9MnZ0lp08pZDzj34WvMBCf30lKClfjc8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 23 Jul
 2021 04:10:26 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 04:10:26 +0000
Subject: Re: [PATCH] drm/amdgpu: Check pmops for desired suspend state
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <060fa79b-e4d2-d0ba-13ed-fad18b4432aa@amd.com>
Date: Fri, 23 Jul 2021 09:40:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 04:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 607f0679-6c76-476d-891a-08d94d8fcd02
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047FFFCAE0116484DA055E697E59@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6hdk/TX+Ub8ledGUCuiD81cdwN8/yZxmuMozupGrc2SvRM+15hP/bnLyoZ4RwAyG5rclujwqfVe5cIb/Wnls9TdtnKJrE/0jb2fzN0wiB68tbRnllgaV+iDLOLzt+L9pxedypzxo7n7FzkP3eQ0x+shsiEkfXroGVGmInfecGm9r+SSzkp2Oy0F2w07XXSxyU3PX/k1HWqu8hjwb75zdUUYpC5gXJ0k0xzGlKf87s71PNMaA6/xZIR+xw9yUIFQNMK8FPhgwgzxGzueJCTQ0mgmVPrUyQ+7fS4M5pwCsqP0IehDywrOZ89jEuP4f66kfOoo7hhaWm8mkS28Fj5gKKhxSkweuZHy7R54CliwQlRa2bEBzy/r8WKTUx6tEpfEYFAVcdXc99jVpZSwOushny0iCT6GkHzhAh0orHPf8/+yukjQxnA7pwpZjES787BbTk+nu/xtvYha7MQb1Y6U8btq3GygN4uXFSDIN2ReLN/+k4DxgllxWaK4YY0avk2B0WjmqMtpe6JcRW+NmLiJ7EygXOjGKODnkPg99/afVLAnbeJCquYJ9JzFGi/Z5woM7ODm0D/J2vSU2VLB1S9PMB1RjPku9LfAlJB3Q903mwRdtSN+Qa7fEQyT4e18FrOhPKUtU3ZyQQ/VbiQl0l6Hr7pOgLlmPKF08gFWVZZX7yMDvOcuKCukeXETipdZoR8GUjsiYWg95xM0cpqyqUmgqd3YRs7X71c9TbbTqqq/0pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(5660300002)(316002)(66556008)(186003)(31696002)(26005)(16576012)(6666004)(86362001)(38100700002)(66946007)(66476007)(2616005)(8676002)(15650500001)(53546011)(956004)(31686004)(8936002)(6486002)(2906002)(36756003)(83380400001)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hlK29Fek1rajJvUEsyK2k5cExPbnJLbks1OGNzVVZKL2I4SjhGWlFnQWYy?=
 =?utf-8?B?NWQvbzZLUW5Cdm5zSGJuMFNVNE9wS09BVSs4c1NBSSs1eTcwckhOR3BFNVhX?=
 =?utf-8?B?YnJHSzEzUXJPZE9iUWJ4SWhmQ1p4VDhEdVVBVmt3aDhuZVkydSsxMkQrdXdT?=
 =?utf-8?B?My94M1laME5KOEpENFRxdGpMUW9mN2hSbXo4OXNuSHdkcmw4U0hObDVCdGta?=
 =?utf-8?B?T0VUOHgrazJERnNxVGU0UUM5ZE9qaUNHUE1hcVZyT2gwRDd6L2lTVkl4NkN6?=
 =?utf-8?B?UStPSUl6S0JWQm00SFcyNXFoL015OW54OGxtUThkblhkK3d1S2djYXJLUFRK?=
 =?utf-8?B?MGhwTWtXK25JeDU0VHB1QnV6Vmh1aisvbUFGT2RXYXp1ZllFU21RUy9PcWI2?=
 =?utf-8?B?R1J5MmUwQ1hlcWtpQVpTWnNOUlB3NXJDL0hrTmtTSGlwYVBiT3BZK1dtTHlE?=
 =?utf-8?B?TVdNdk92d3hTWTBZVDBlalE0YklUMVU0ZlFxSmc5YTFGRVI2K29LUGZTaU1t?=
 =?utf-8?B?MmRFUTd1a0xIckJUWTkzR1VaOElIV3ptTi9UblBWbzR1djhIOFl6cDE4dFMw?=
 =?utf-8?B?R3NjWERLZmhnRHplQUlnd0RMb05SY1k2cTkySGdSWkFNNUdBc3JXOFdZeDJ1?=
 =?utf-8?B?SFlUSHdxSnIwS3JzZkpHUE9xUTRDcWN4STM1dTNPUnBVb01UWW1EUTRMZDY2?=
 =?utf-8?B?Qk9GTEpPV0U0cStvN1l3Zkh5YVZ1bkh4c3RMVWdOQUdvRWloa0gwSGpmMkdj?=
 =?utf-8?B?RzBQdUNSZllKajJZQ1B0YXZPVGp2TG5MYlJRMVRCQU5La3lLOUg1TEFpbXFC?=
 =?utf-8?B?WWZkOHVUODFWN1FPM1ovdzZURFJGRlVvdTZCeWRWNUJVT3crWmdqc3RteU8v?=
 =?utf-8?B?eE1SYmVCY0JtbFFLMzhqcm1URkFPLyswSEdCVFhtZDVYY3AvTVhQZVNIUER2?=
 =?utf-8?B?MUZZbGZTN3NDQ3pESldHTFRMaDg2L1VQWnNqUytoT2M4MlR1M0I4VlB2TWky?=
 =?utf-8?B?WmhBTXdvYWQ1ZmgrWDZVZHNSdVlIVWJqd2F1eUZoL0sxM05vU0crZmRyZzZN?=
 =?utf-8?B?L3BJVkZyR3c5V2M1eWpGRGlhL3BhV2x2UEV2TjIvbnF4cXhhQmxvY2dxaXRw?=
 =?utf-8?B?amRmNjhjNi8xYi80RDd2RDl0ZEU0TEVuTGxGblJROFc3cWliQUxKbFFoSjha?=
 =?utf-8?B?d3hsMWhCdlhCbk03V0g0Q1pDYlpDdGFpRUFzRFgzbGt6clNzWlNaOTlDajZl?=
 =?utf-8?B?RVI0SHFSUnU5UnNBc2JxNEtmdDFPVmh1WkllYlNCWGhXcVY1ZjBWa0RtdFIy?=
 =?utf-8?B?cmVLdWtDbjJvMGNrdTVBS0lyZ3hVSjdhcjBoS29EbnkzTGdobDk2K1RpL1Vt?=
 =?utf-8?B?QnBVMUdYS3FnN2M0aHcwZE5xOTJtRlp6R0FrcmVDQUUrZ3I3NitoaXpCMUQ4?=
 =?utf-8?B?OWFIa20vemJFVGN0KzYrdk1YZEFCV21HNm14VUpUWHE4c09NalZMUTdtQytV?=
 =?utf-8?B?TllJTTJpSG1YamM3OUVGS3VZZnBuVCtoZEcvRU1jSXY0ZW04dnV3cUx4dWxv?=
 =?utf-8?B?STBJSDAzOENGeFVFWHhMbG5PK3JPMnpLNkMzU3NlR0E1bXNHWUpsclYzR29D?=
 =?utf-8?B?MDFCWkNPQ1MwdllyQWgyOHl6dk9ZRnlmQzJZcWJWb1BaUWk1N3Ewcko2VDlC?=
 =?utf-8?B?M2pyWGc2MmhDQlJQN1lNZmpseXZlTUdidnFFcE5OV3MwQlBHamZRdXY1MTI2?=
 =?utf-8?Q?Fn/EnwMgaDHSoRtgAb5RcY3edv5zxw6pdffiJQz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607f0679-6c76-476d-891a-08d94d8fcd02
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 04:10:26.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmXJeDoOZHA5Qy1KHdgsnel7qopNYSvjCcDPX8lab+HnYRFvHQtZ9LqaG6YRhE56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/22/2021 10:57 AM, Pratik Vishwakarma wrote:
> [Why]
> User might set mem_sleep as deep and it will result
> in amdgpu resume errors.
> 
> [How]
> Check with pm for default suspend state
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index af1710971ff3..d92196429741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1468,7 +1468,8 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   	int r;
>   
> -	if (amdgpu_acpi_is_s0ix_supported(adev))
> +	if (amdgpu_acpi_is_s0ix_supported(adev)
> +		&& pm_suspend_default_s2idle())

A better way would be to use the exported pm_suspend_target_state - 
(pm_suspend_target_state == PM_SUSPEND_TO_IDLE)

Thanks,
Lijo

>   		adev->in_s0ix = true;
>   	adev->in_s3 = true;
>   	r = amdgpu_device_suspend(drm_dev, true);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
