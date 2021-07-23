Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC99C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 13:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC9560E8C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 13:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EC9560E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFA76E8B5;
	Fri, 23 Jul 2021 13:08:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4376E8B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 13:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYgbWfDdhwcnOBFr/day+SOVV6yz0+7pwyvI6HDGJh/BJOfWsi27f3k1KCwibRQBdhrOEntkZ8zxmAkEFs57JFAf3cD2As/3Wh9wbwTjEEB2xxypS7iElCHVDDz8fjOSHGQM4IW6CLHlzHxZGspB/O/TiZIeuhHq6x6nzZujb+RcnVh2ITsWqTVnrqGELT3FKPho1N2Zm4yBOdmPxn4apfc4n22qxJXNEV1dCmryj5v266wSBxXFaIxe8THCf9kI3EjzBAfDWrwdEQw8rpFNAdraNab3+pGS1FqAQCRHM4FKbnl59zkWMQlT+7eg/+ClAfQbanu/1RXDtg+A/aevfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8YwpvP2AIMypDVSgEUGKEs86ltHgHHOgXUrJpldIs8=;
 b=nZB6xL3ZD6hWyWZdMqo5wG1g0kKfmVz4o0e68ILeCz/pDQQbybfttxfw3KNLvanj5CS8k26XmxcQ9Yc7c41lCaqV5uzSi4BucFdBwBcwKOUr+Fs2jkq5l7vSZ4oeDPgrK4QTkop8PxGqVi/2Z9gnhRnneevsYROAtpW1ueVQkEjU/ujK+igdAtCDhQYcpP0fUuCVFVcM9tLruVeYeLDGEdPqycmzkt6IJGb8z5T8dt7nghLp2bk8xACxT2a2Yvpw/HWt4qkTxWHxEnj0R/Op2pttddjCBz6I4Zvoys5Rqux/UZUVJ8kSzKLe8eFjwpGLGeijhRkaAIc1l0YZDhXr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8YwpvP2AIMypDVSgEUGKEs86ltHgHHOgXUrJpldIs8=;
 b=tA6JvSEiWpf7hm2uzLW2DsGQzsUZLGalJhOeNw5d+CwwUBARJIWbO0NstWPJHVTRQPNJi098Up3wIsmb4/fXA9ApVdphRu0f+Usi8YjKxjlrIL8tw13UswJ5CksNear3k4mXNNRputL3n6lc8RIP+fHj6OVUC11yhsWVZiw3I8M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 13:08:06 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 13:08:06 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Check pmops for desired suspend state
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20210723124822.1137722-1-Pratik.Vishwakarma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <8c44059b-4cbd-b0e7-34db-54c394df1b23@amd.com>
Date: Fri, 23 Jul 2021 18:37:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210723124822.1137722-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 13:08:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5d03bb-620f-4b22-7e01-08d94ddae91c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52716718E746200EC256749997E59@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gv8gt+HWUuYoyomKfZNBojsdGLr+2yt18Y3ykDP6Ku0d1pJDkgMiOozGIShVwO3wSokmUEu3HYVYxKgMVvKrSICOH2OPhsfV3m5u+YjN1MEDRolCfXBjtIjfB3h8hdLZZYPAayVhBIKPPwAxoU93Zwk9pPlfRDdyVvfCcpts+0DLF1hbFZvnhVD5j8Lnaxf4nI5FJxUtGP+oGwgO0f3rF3otz4VIDMQo9yi/HshPsJEMC4oq63aQNU0bv17JsDUKsb/bLnk8rnfIydMzR27n5Ue7ZfvrV+e6G6uImyuuJYpTHORU0PInN1bOXfPeDFHcfebPftg33oPhVCv6/ffk05RREH2OrKnx+r+5qNS9WUF7K7s8Tscixwk8SqLs4JtzqXEHS7yGuuyH6JqbCZj+89rPsxo0FJWTxRPE57rtipxF+xtPOEVbTVORY3n7ceI6nET8Usc5SyyeGJz61DHztNZlaD+V0zpYBsg68WhqHCoeyqYAK1vPOhoumqlwRehuWnfupZA+5i5OcjMblila5RmSzUvSFqxFYVJzFc5IgRwNWYigzsiYEHnAKCVCDmdudVO2B+K7wATz6/QSTIiTMV0rhZtraZM0dA2cY+sOJaSDP8RVKR3E2BseJflTouSs36frpynt/UadcUtX52x8JeEja9/osCuHiMrii/CvCL2/0qdGW0CmTO9nze5czutusI3ApiWkUfrpiCU0UJuDYxefOsO2OkZwZUMIgCKjEyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6486002)(508600001)(2906002)(8936002)(31696002)(186003)(86362001)(31686004)(8676002)(53546011)(26005)(16576012)(36756003)(66946007)(6666004)(956004)(15650500001)(5660300002)(66556008)(66476007)(2616005)(316002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWphN0RwMzhnUHc1U2hTdkl2aGxBQksrSEhrTFFtdXhZcmdtVlMxYjRlTmQ3?=
 =?utf-8?B?Vk5kNUdoS0EvVVkvYVUrVjQrbnVLMFQ5MDl1b3NQNlgxREU1RmhFa1h6cEEx?=
 =?utf-8?B?Mm4zcFhraEEwZW5hSGlFVGJoNFFOTEw0S0tNM1l6YVdSTDc5azlDc3huQ1ZQ?=
 =?utf-8?B?eXRVSWEzK2J4cDNVQ2JZd1grTExGakhnSVNiWUpNOTY1c0RRQ1R4MURqd3NH?=
 =?utf-8?B?eVQ5aVVpWXhvVXRRa21saW9MVS9oZFRLTk45ak1NM0hkVk4ySllRampvdWFQ?=
 =?utf-8?B?U0ppQnUvQUk3SG1mcjJiNlh0dnJtZER1R2ZsMmwrcmFCMjJRRHp1elRMck1t?=
 =?utf-8?B?K0d4VytCV0FmdDBTaEFZYW9OcENtMnpNakUxSHFFc3BzeW5HVEx6M0ZWS0lB?=
 =?utf-8?B?R2YvZjliajRWTFEyblovVVNGVGJ3d3dlNGl5YTNtTElGQUxQVDBzOTNCK3ls?=
 =?utf-8?B?YndES0t2TDEyWFlVSkpjOVcxeU5TUmNRVWtGNkRnZkVmVm5vbkJybmRXUGhE?=
 =?utf-8?B?QnpEYzFjMHdYTmpuTjQ0YjJFeU1XeVRMc0llMEh1ekNLZzlXU1o2RGxSbTAx?=
 =?utf-8?B?VElGcE42RjAva2ZnRWpOK1BhWmthTU03eXA2Wlp3dnpNS3lCamprNnVBc2Ni?=
 =?utf-8?B?a1Fyd010N1dCbXlGN2hCSmZXaWxaOGMvclNhYWs1QzdENFlDTlAyQW1YOHZD?=
 =?utf-8?B?ZWxoWDA1OThReFFiRWFZcjdobzVtZFlqRVBwQzVZM0dhWjdOUkc2NTNtZks3?=
 =?utf-8?B?STRWa3pReGl3T3ppNWZMWnV0WDRydEhiS05ySGNwMndkeDM1MmFKUVVTTlU0?=
 =?utf-8?B?Szd6clpQYVVJdWVFYUl0bG1HVzYyOVR2UVB2NjRDTlE3UEtZNHQwTWJsQVdq?=
 =?utf-8?B?NktUYTFlcHU4NUhBUXdZUUhRQjBYMlkvUlFOaWVtRlFMZ2R3VlVzYWUyYW5h?=
 =?utf-8?B?NElpcGg1NmFjOWZISkE4dGxqTTU4VmI0V1BqL1pvRTZkdWxFak81SE9YTUpP?=
 =?utf-8?B?TXRPa2pZeWdkZkl3K0VmaFNlVmhpU1JzRG5IRWZ2ejJDUXFqSnptZG40aWw1?=
 =?utf-8?B?Q3VhUFFkRGc5ckp6MjVqei9NenVZdUJRSmlHVzBmSE4zTk41S3BTWW16SGIr?=
 =?utf-8?B?WTE2VCtZZFdlcDhjdUlQbXU3TjJ2eXRNcTFMWkc0YVZQMnRvN1dxUDdvUXM4?=
 =?utf-8?B?dHIzT01SajV5VVU2cFVIRXpjTkhHYmw0UHVvdzlLRzZIYk42WnRGVGVUVWFO?=
 =?utf-8?B?M3RqYWdZaCtIZVo3T1A0MnlJOU5XRTZEZkZKQ2w3ZlhUT2FVSkx5TDRrRzlR?=
 =?utf-8?B?Q3FRQXZDdEJ4Yldxa21zUCtzTFNzU1Z2Z2w5WFpjaWo3eGZ4WHQwRDlCdDBR?=
 =?utf-8?B?OXlCZXFxQ25BNUVmUGVSdEx3Z2Z3RmNSNVNlUnBmWUpudGMySENQZWFYQkg1?=
 =?utf-8?B?UkVLYTNOcDNKdHlOd2pOUTdPWElNaUlzbm1KNm9YdHNaczVNSXo4UEE4a0FN?=
 =?utf-8?B?c3hnZXRsRERDSm85WTh5MVYyYjUzNVhUamx2bVVaczk2VU12MzY5WW1idkkw?=
 =?utf-8?B?ajRvaUFZLzA4Q2NWaTAyZnNNV2lOQjByOVVoVUdrVERkL2dlckVWbVZwc0dQ?=
 =?utf-8?B?NG44MmxjZ3FDT09sY2lOMTFhd2c5S016USt0L0p2Mi9kVUtNSkxTcnJ2R3BK?=
 =?utf-8?B?ZVQ3UUhnNEJUNVc0aC9rUEtMQzZxdXhmUUh4RlBWdU5QRGw3cXZHdGtPdEEv?=
 =?utf-8?Q?k1igKXwZbEcmSytIpLde0KPsKLVRnQgQLRwNedo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5d03bb-620f-4b22-7e01-08d94ddae91c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 13:08:06.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XF3lhNbHPczNq2yMqdVfbeTq+7ZlgFuL/TMx9BUa+suGp/NuPUK6MNc/winJiMrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
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



On 7/23/2021 6:18 PM, Pratik Vishwakarma wrote:
> [Why]
> User might change the suspend behaviour from OS.
> 
> [How]
> Check with pm for target suspend state and set s0ix
> flag only for s2idle state.
> 
> v2: User might change default suspend state, use target state
> Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 84a1b4bc9bb4..bf59bb263816 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1042,7 +1042,7 @@ bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
>   #if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
>   	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>   		if (adev->flags & AMD_IS_APU)
> -			return true;
> +			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;

Not sure if this is the right place, the name _is_s0ix_supported() gives 
the sense of a static check - whether the feature is supported.

pm_suspend_target_state is a dynamic one - actual suspend state to which 
transition happens. Ex: s0ix may be supported, but user may choose 
suspend to RAM.

Maybe rename to is_s0ix_transition? Will let Alex to comment as he added 
this function originally.

Thanks,
Lijo

>   	}
>   #endif
>   	return false;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
