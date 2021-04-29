Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C54C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0171B61090
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171B61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08ED6EC80;
	Thu, 29 Apr 2021 06:11:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C6E6EC80
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUE+iZ7A0LCIQJd+x7dFFBvF5R7hwYT5vJulroLUpJc46G9twOiF9MUimx0MbwVvPIMj3ykOc4Gnkg3zrHP/ePi/gA9/+8RtVZodG+C5AYPIIDdYc0YuMA1P4XOxaJyB7g6jvqB6cjO2mgQgpLzI1dglVdiK5eyptl6YXGtgP5+0k4m/QOzrVLXzQfVHU16OoXL6CEgeuVXuFBJklwDAGeAUHirIichoUBh0aCPzr8q7M/y9ciSGehDbDB9iubAwmo+xoPJDViVlYddvAGoOtIhyLgS3Gt9rDo5tSdX2RhB7gtzrAKIzo0c7Oj6vX3Cj2GF4p+x5a+5rpBTyn2qiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2ZYwWT2RM7IqBHMs3wrlr73Bgt4SVEvHhRwOuRPG/Y=;
 b=ULULnwvJMZsrN1T+I9bTV5tAi4/yLVS7AM4VQh9v3b4Z7s2F5K9NKc4l5R1bKEtZAGjP6bHwhPd+rsbFNnbwOK2O1cOe6lN476mXG3CCa4ELVRFyvDVz3opru7qZ0H6QirFfvkFizQU5MIYHlFwjvkVCJTkAhxgoX8wNWUxICAzAvoekOeel9yXnndNQJw48IYSLKlyHJ+o+qXsxgZsY/lkexxZJJk/ylsBAHHUgTEAx5ui1DnR1UY/QJin02mhuupnult22xMrLcpGL/KPG8+yzd5VjNeGxpCg5Y8re0k2zJ7eQsXEG020AcZHgEQWhG/rO/rdMCCX57KEQoaduJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2ZYwWT2RM7IqBHMs3wrlr73Bgt4SVEvHhRwOuRPG/Y=;
 b=oZWYey8hbKIC/Y2imi9hGh6/vV8wmIoe9xtWaFyphUbzdV2N86rDakFinJVMFs92ygXIHmMJ5Fvm9qWXRUIAythDPQFxG88IYcPvHJm3eSG8hRyHitWCr6voXvpCgFG/v041Yicgcwa6SUWjb1PE0CP3sDXhzPo5ih+4GYdnNpM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:11:15 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 06:11:15 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: flush TLB after updating GPU page table
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210429015339.13047-1-Philip.Yang@amd.com>
 <20210429015339.13047-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3ba303ba-c9f0-24c1-0b23-9b40e38d2935@amd.com>
Date: Thu, 29 Apr 2021 02:11:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429015339.13047-2-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 06:11:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2209cf68-5533-4f2c-1da3-08d90ad59878
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679686FC089BBFCD686845E925F9@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItZ+CAbKMm0wng7Q6LVfTmVE/XNHDMsSnjVtxcwnrlYzFU5e8j+DHSMNI4s0fj57yjQEJ1bTCB9ESAF4qGWYPA6PcAvHQoUuQYoDjLd8v+r6cFJsbzwl5l5c0BbgERYpqewISa9vDr2i/7nCK52SkdSbFdDNTSKoiSHMGpz+53BoFW8uClIzaxXk1hQqOwZl5ADmlulKLhML4hiGKX2ptEjgdAFp+mchJ3nBNqT0LhQ3aEDkWOYRV2yadQi3SAY5Kx2gFMHtkSd6kB73WH1xjHq8yVhnUNiXbkOuGNdXMIAqK5DZDLx4eY6LpablJM161/xkal/wcpjQ+qYptq4JjTOmGmtDwWhzI+PQN/LgC/36X2oxtilOFkZqFWWTqkgQ+aGxIl6LARaFwcf14QF7XgrffnW7XAROpltZiinXOGeyBkml+IH+9eISXIlORRFX/nX8mFw+t9Kjmow2O9X5eqTJ0IwdJl12ojF1py9srb+loEVBTgI1nVr6c6/TR3U8NnWhc5hyFQCV4i6bnV3lWPlvJOYn8AJ13mbzZCbWbSWo1nfRl1URa9S7V0XmheQqFxZpMEB8sRSLy/dBHaHMuv8Nzcn22+2KtYPzULmyijtp+vQGAJZZXKKOU+OJ9TdVz+JKl3mHH3XLFI1YVmTxi0MShZacczXSlN9YvKjmB+EVDvIzK80TAMz9C3L8foIk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(956004)(83380400001)(8936002)(6486002)(36756003)(2906002)(2616005)(16576012)(316002)(66476007)(8676002)(38100700002)(26005)(44832011)(6666004)(66946007)(86362001)(186003)(31686004)(16526019)(478600001)(4744005)(5660300002)(66556008)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TTZZOUFLRkY1andld0I4Z09sVU80ZWNHUnp3ZUJCZzVOM0Jsa2F6Umg1bStL?=
 =?utf-8?B?OVVudk13aDVvR2kyWXdvdVR5SDF6eTg4SHU3RldmWHFUZVE0RFN2bllIbVky?=
 =?utf-8?B?Qm5JdFlKMlhNdkRyM3RNUlhhc0VZM0FFVzRBczYvd3F3ZnhpRzFmOEZwQjR1?=
 =?utf-8?B?M2lpbjlEVkFkQlNUdVBrQ2FBTjVkWWxqZzM5OGYzemZhRWgrazBiM3RFbjVF?=
 =?utf-8?B?Sllsdi9pWHlMR0pydis1eHAzVGEvZkNBbTFqeTZIcjVKcEszaDRjN3dOMkcr?=
 =?utf-8?B?bVQ4bnpNaHNvTjVHQ0hCREh2eGRrd09RUEpnbEp0U0wvNCt3TEJUbFVTQ0FB?=
 =?utf-8?B?eldmL3h5aDNjdisvMWxuTjBOUGlVV2liaTNyR1hNZjV2KzRLR2YxYzliMmIy?=
 =?utf-8?B?cVQ5bUs0SHRyYUZ1cEwvNWEyeU50WlBrcHVDSnQ1S0x0UmY2bk5KL1NvRWwy?=
 =?utf-8?B?WWFBODMwajNNVkEvNEZOZWpEaFQwbE5Ud2dJN0hmS3BLQ283YVQxWTNXemsy?=
 =?utf-8?B?YzBoT1ZMQkZraE9uSkd4Y0Z2RlJobDA2LzdPUWFtM1dEazUzTU9WMHZRTll0?=
 =?utf-8?B?RVJ4K010RkhmKzc1NFZ3QXlWT1d3bHpMdFZBR1JCUnYzU290c09ZK2c0eEtS?=
 =?utf-8?B?RG1ZdTRLZUdtU0dTTzl1MWN3ek1aaFg0eGIrWUwzNHpSTk54MDhXMXVoZUdT?=
 =?utf-8?B?TmtVVnpTZTl4VkEwNVl4OXlDNzB0a0ZMQnh2MVVkSmRnM2MwSU9JdGxZMlhW?=
 =?utf-8?B?a2VhdnFxb09HZW82V21BQXdRdFVEVFF1eTZuYS9pbld1OHo3alJSbEFLNU1r?=
 =?utf-8?B?Yk0yQVNrNE9ZUGFFVGRTemlKY28zSHY0RC9uRXlGL21WWnpwUkVNNkRxdDRW?=
 =?utf-8?B?dUlOZlgzUCtPV2R4Tk1tV1pWQnlncU4yRXluVzQ4WkVnTWVzMzhnMi9CL2Ev?=
 =?utf-8?B?cFhwaW1OYWo5K1FsVmVhQ055Y0wzMU1hVW1XRnJrdExiMnEwZFJERWk5R3l2?=
 =?utf-8?B?eXFCTUh6TlFYZmpQdm5Kajl0SERqL2NJdGRtZXU3ZE1TYWNwVkRhdFdINFVH?=
 =?utf-8?B?TU1aZ1huNkpJT1lyS3BpdGNrbGEzb25QaEtKWmZLc2hrUHpZbll6SzF6b3JE?=
 =?utf-8?B?ckdVZTZzcXFCbXF6TWVxK2hjL3NzUUFvbWJWbWxFdmZJZktiVmlybHl3QTlk?=
 =?utf-8?B?UjVlNU4vLytmcnpMUFE3STFWa05uNEJMU3NRdlhnTGRwYmd4RlRhbTBPL3dt?=
 =?utf-8?B?Y1RuTmdSSWRwdGFNbGhRQ1g2VWd4SXJZSFNKbjJ0U0ZqOUtSSzJYT0VTZXVR?=
 =?utf-8?B?YUl5QU1kS3czSFZVZzhmQjRleU5FVDdqRnNYTHRxM0g0R3pXNnRJUkNjWUts?=
 =?utf-8?B?Y0MvSE8vT0lrT3N3SjBTUDlJYXlNa1FNcGQ4VWhBODR3OWhhUEVIY1pBSSsr?=
 =?utf-8?B?RGd1cG8ySWpJWjdPeXdpbjVMenErcjZJSWwyRDNlODRXSjRYK215M0JLRzhh?=
 =?utf-8?B?TnJTai9lQ3ZWVzRsUkREZHNia0JPK2NyeUJRUXZNM3BNVVU3T25HN2d0RGht?=
 =?utf-8?B?Z25valIwaTJoc0l2T0dxUVZMMWliZzFScU01QWFzUzZMb1dUWDZLQ2RsU2hL?=
 =?utf-8?B?WGVZMHdzUlJpaUtoSWdQcnY5Wm9BNHhoU2F5UEZUSHNzOEpDWDdscGdXaVg4?=
 =?utf-8?B?Y0doZHRiQ0FURTVTNWR6Skp6dFltdnUvbVRvTkpOR1liYzRPK0paWVNaaXlw?=
 =?utf-8?Q?PqjlFazGutufIVKebYZ88SK5N31Yc2A9Fkalbe8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2209cf68-5533-4f2c-1da3-08d90ad59878
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:11:15.3858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+iPU3a0NYByC5H0PhJn3LUL7px/pN4rGXJZSCT4SZwWqI0CYNC/L5YRHTd2ATH2Tz+x5LpRFhuIftvqoqzPjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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

Am 2021-04-28 um 9:53 p.m. schrieb Philip Yang:
> To workaround the situation that vm retry fault keep coming after page
> table update. We are investigating the root cause, but once this issue
> happens, application will stuck and sometimes have to reboot to recover.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d9111fea724b..a165e51c4a1c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1225,6 +1225,9 @@ static int svm_range_map_to_gpus(struct svm_range *prange,
>  				break;
>  			}
>  		}
> +
> +		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> +						  p->pasid);
>  	}
>  
>  	return r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
