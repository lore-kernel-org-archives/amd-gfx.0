Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE31BC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 22:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592FE1121F7;
	Fri,  3 Jun 2022 22:39:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE811121F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 22:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HayX4TkJ80Eun6+zeoBWk8sAKf3MpJSwgZrcfsQTCocmjCJX6FhFZjAj6pRZOSHh7h0lPnv34iISsgHCAus79Z75Rbqv+IjyYihfDtB2T23Gt96Z1A6Al73t+QPy0WFSNt3iDUcXBKmM5QsmFPVTcC2Chc1bqVXA5n4j+oIJG/FwBFaALq3zVVOM6bI2gZe9Y4iiGzp/1LQ+zooxuslX93hx/mGzZO72LrdF5Lzu+lZb6QLwFwm7q9XG6J2Hzl5xuqakOL6FAY4xiVZgQkuxcWWdRmcwn7fSFJQofKd+YkKiMHSXW7lDl4BthVUVLCT3110bPxackKnRlBHTSnWgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK/MO/B5cOnOTspsz8+eClaNZ0caej1r4DOMmgFCKZw=;
 b=msWpHCGEeokoAT+XC/oDtWUbjnRZTWHpKzWGBhsO9eYXj5L2X7jY5CniIWpZIGOg+jt6+yCUewEWJ+B6oRR/kgZkX+H0vUFnYrz8NV4j5yoBzfGxgT/tIcRWenxR0L/sscsuqTzbsRYFpeDj2fQ/hT4i38uVqItKMfbXn8exRccouFU/AipPYSw2pdZU+2d3LkeiCFsWk4u8DNG6oQ1RqLtL9SKKpkZ1P9F3A53tS3LlzrSOUU5YoA/33h+h4DFUlz2H2JH5qFritfLj3D5gCNzNlFxlvSRME48Hjb4GvGemD8f1uCzl/z00JIaIhUZmIiUiUjp+f2tosI2qrwat0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK/MO/B5cOnOTspsz8+eClaNZ0caej1r4DOMmgFCKZw=;
 b=5OsIGUCvowWXQArrT5fuNvGNWpidYikqh+8yGO/Bj8qHttmXC0nrPtFbSI3wcCvkzLBS+lNoDLTExxP0gWyXRoYm2tzBO0KAIfy7N2caSCPt+PT7Cgsbi6038M/H7LT7bNTKGL8MvbUvETY0cVyfWWdKao5m2ZclSoBGDZ4Ldg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (13.101.157.78) by
 DM6PR12MB3099.namprd12.prod.outlook.com (20.178.198.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.18; Fri, 3 Jun 2022 22:39:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.016; Fri, 3 Jun 2022
 22:39:19 +0000
Message-ID: <5e595f1a-6887-4791-3d6a-222d69cf5c45@amd.com>
Date: Fri, 3 Jun 2022 18:39:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] drm/amdkfd: Define config HSA_AMD_P2P to support
 peer-to-peer
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603105203.3353654-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220603105203.3353654-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:610:cc::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b00d5f-ade4-45a6-4af8-08da45b1e5cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30995C07315CA80BD34CED3492A19@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4C+zch1kCQk+gjb+d3lbaF8pV9cTglv7U5zVklSqF13C7dFz597IPAHfmJLpv8d2vpy3nEJNGpoepp0yVRTExyf3wadwq0UL21cDljYuBQ2vgNLDoJweBUaiSNJ5SUxWmFAD1trCbRb4No/BrBuql4HEsXYTu0gEkn4YBYrkfMg5QPUzKw4o+Fq54nNtv00H/ZXUMsHeu3xhEgPrnOAnGIf0nSd8jaWcLOJ0Vr5ykFsegIDv+gozL/10awXXt9wz5QdanTY+RN0Q4Md70QoGiQKW9ic9pAqtCdN7SrPI1+rdYT9cRLLH8fZksTHBS4aLwRfJnb90UXhtMl5oo4lfg8sQgYPDXwhmlecVx090U5qXsMdItq4xC5I7XBXHtQLp27pr6hRbyrYzNswzwtyEY+8IZ/WHKYDLHpoM625kaSUmKjfThiEOrnVbXLQLI9IPyfrUUnST772wFlvVVnsqQpeaZXArOXGhIfoBf0m8OOYIS71vmKFb0ohTToZaggSHgMZTdnCZn7jZN/ym/v+b908kaWjoaRGuIVtOpdWxZXCIX8PdBejLByoPXB0bfu8sM4BO7qAblNz/N+j8yAk58BI7Rr6i/qOz/B8a56+are1i3MVKntSf4I8fyFSOJQFflLMpT9eDtpMyHRN8p3tcTIgqeaYesMktFcrNaN7cG8rX1Au+oFFM6OQiYRTN53NS7aWAq2eJuAAKChrlQV4vVKCrLJpqYCkmXOamZnZjf1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6506007)(2616005)(31686004)(44832011)(6486002)(316002)(36756003)(66556008)(83380400001)(66476007)(8676002)(66946007)(53546011)(186003)(38100700002)(508600001)(86362001)(8936002)(26005)(6512007)(5660300002)(2906002)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRDeGxqTmNyL3lGd1liTEgxL3VNTTE0SGF0eU9yNDNLd20rRVNRK2FCOGNE?=
 =?utf-8?B?YTFTQWNDUTRMb255TXRnTnlQd2V2UFV2WERNc3VFeDREY081eUptTmNWQmpU?=
 =?utf-8?B?Zm4xYXJyNWVINGJOUWt6TXVNK1FkTG9UeUE3MDdlaE13eTRqdjY1OURsWFY2?=
 =?utf-8?B?VnQ5ckE1K2JkUGJLOTA4bkkvVFZXWGlzc0prTzdZM3dSb1hKU0l3Qno0U1F6?=
 =?utf-8?B?YVl3b0tGeWxPVjFqUnZxcnEzN3U0NnUybnRCa3FwM1o5UVplcWFvQXgrTHd3?=
 =?utf-8?B?VTdQVjIwOTZRa0k2eUxQWmxqa3JidndwRHFkeGFZbVEyaVlWY0N5NkFhcWtI?=
 =?utf-8?B?WmZzR1Y0d0JSazlsQmphZHJjTjJPT2FYdXFMaFV2Mk9xVVhTQ29IdCs5dStZ?=
 =?utf-8?B?KytWajBwL2V5bDM3UmNBYnEvQ3hlRHBHd1IrbnJLSXZUU2pOdFQrMWJkU0c1?=
 =?utf-8?B?Zll1WGw1SjBGanM5VkM3T3lrbHp1RWZPWmU3T0F3c21DSVhFRndLWFJFMWtm?=
 =?utf-8?B?cTBnZTdTdWVkTVRodWhMUTN1Q2k0UWszTFdjZGZCMUFGRllQT1hnTHZvNFRj?=
 =?utf-8?B?Q3o3V0VEcGN6TlA1SUZOcVJMNlFYYjloYk9NSkhkc3B6bGZtaTJldlhIRFNB?=
 =?utf-8?B?QjNsVmVpYzJZSlRuTUhCbTZrTWI3ODBsRzB1OFcxVUJESjUvYlFBdzVCTWpL?=
 =?utf-8?B?Q3hvak9YSHZlU1JPRlNLVVNqWTEwaUlPMWx5T0RjblhyU3R0a3NxWVVWSHc4?=
 =?utf-8?B?MUsya2ZFS3FpUXBiUk83ZE43QjdTY2lLWlpxMUJxalR1REJlanBiWUNTdWlX?=
 =?utf-8?B?aDNsVldHOXVtWnlVd3k0RGpzU1RvQ1BzVHlzdzRxQnVjMDZFaTZhckRiOXQ4?=
 =?utf-8?B?b0xlNU1ONkRjK09EL3ZWaVdTTktoc0lrOVJaVy9WZVpnaGZqV3dIYS9VaEhj?=
 =?utf-8?B?L0laazR5Ni9mWWdWaGc0aU9qNlI0TFZpUTFvekhpb3FXN3NzKzc4cmUvNGxF?=
 =?utf-8?B?VnNCOUZkSDE0Q2JZS1dwK0RJZnlTMFFOd215cmRhd1p2SHpza3NUaGNkMFU2?=
 =?utf-8?B?Y0ZWVWVBM2FZcUg0MGxGaE56b2xpZEhXbmN3N3JHS2I0Wkh1aUF3S1NIQlRy?=
 =?utf-8?B?OEc0dUdqV2JwcHlVeTRZVXZITjJHQkpTelI0T3I5K2YzV2FHc3JMcGEwN1Bo?=
 =?utf-8?B?S29GOHVQU055bjI5ZGcyRnFycTZJUGI3elg3YVRZbExSOE1rZ1N5ODBkekc5?=
 =?utf-8?B?dFNlZmU0dU5Ma0lyeG81ZWVRSmdYNEVKUGdRakkwM3R3MHBueFZtNUJCR0VQ?=
 =?utf-8?B?NU03ZUEyMkxrZ2pIZ2NTTGJFRkd5dXlOaS9iSDI1ZnEwQUJ6NWlWbHJoanVG?=
 =?utf-8?B?Tkoya0QxTHNnZURheTVnbTVZQm90WWF0MGUyVkkxa3Iyai9XbjN3MWNyMGJ6?=
 =?utf-8?B?SS92ZHpDNGE4dFR0SEZ4bm9KeER5RnBCZ2xjRFE2ZFNmbmc3bURDK1ZPNEFG?=
 =?utf-8?B?MllHdHlLSmpzZEtwc1VVVDlzOG11SFozK0NwNHJNSGNSNkZhQ21NTjhZRWpF?=
 =?utf-8?B?TlJTMTNoU0ZqTjQrQVhJSm9Ma3RWZ0dHZGoyemMwSVZyQVpPRkxCVmI3NHpJ?=
 =?utf-8?B?dHBBTzc2RURlc3lZVXR0bmUvdTMwdDlhQy9maW04VENLZ3ZzMzMrTGpOcmJB?=
 =?utf-8?B?NWozeGZrV0lDbmdZeStLeEpDU0V3ekV1bWtZVTNHWTlJWU90SDJ2Z0FVcU1Y?=
 =?utf-8?B?T2dpSmJTVzZnWHJab25SSDZCcDNYZmpHTjk3dTRmWlk5dDExRDdjQXBGdXgz?=
 =?utf-8?B?bTlZc1RJbXdBcE9QN2RLRlVvZmo2bVdGWTFQcTFrNzJhNnF5cmkxNkQ5MHFa?=
 =?utf-8?B?ekRHQTZUMSs4ZkJvaGJpYmVMVk1seFQ2RGNqbXh5ZVdCeEV2bnlsakg2M0hW?=
 =?utf-8?B?U3pUanN1U0p5ZEd5U3JUcENudjNaM243R01qTmxyQWszclM2QUNTQytZYmFP?=
 =?utf-8?B?Y1FBc0xabHBmbDJLeTBsTU80bFNNeGxOQmp2WVErMm1Xa0lyb3dVTUlwZDcx?=
 =?utf-8?B?elViRGNvaklNRmw1MVh5bGEvTUtlVUZualE1V09PdHZvM1dxcm50Q3JONTk3?=
 =?utf-8?B?UnRJN2NIVXJCN2lHL1NoT1ZIYnZiZThjYnFTdHkwZXlPdDhtd2VOYXVrTnU2?=
 =?utf-8?B?Z0kxKzM4cWwwaW9PaDlMTUpoL252cVhNNHU3ZWxhc2xOU2d3L0YzdEpWWWNM?=
 =?utf-8?B?WXM3NkZCbmVXWTRzU0VyOFBkdklnVDQ5alhJdHFLeWY3UExRQnR0a1htcy9i?=
 =?utf-8?B?aFNlK2xmbFB2LzZGTnhyckxmbDZZeGdHalVNeGtnaFpwNEkzOTdpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b00d5f-ade4-45a6-4af8-08da45b1e5cb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 22:39:19.4429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIfZNYX10tJjL9ZHA0sGcs/QnwAKmZe3hx8g6crFlCjEqGbJMIlsycUTBhlsyVsTt6F4HpkWqEgqonxtDfduBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-06-03 06:52, Ramesh Errabolu wrote:
> Extend current kernel config requirements of amdgpu by adding config
> HSA_AMD_P2P. Enabling HSA_AMD_P2P is REQUIRED to support peer-to-peer
> communication between AMD GPU devices over PCIe bus
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/Kconfig | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index 8cc0a76ddf9f..93bd4eda0d94 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -25,3 +25,17 @@ config HSA_AMD_SVM
>   	  preemptions and one based on page faults. To enable page fault
>   	  based memory management on most GFXv9 GPUs, set the module
>   	  parameter amdgpu.noretry=0.
> +
> +config HSA_AMD_P2P
> +	bool "HSA kernel driver support for peer-to-peer for AMD GPU devices"
> +	depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
> +	help
> +	  Enable peer-to-peer (P2P) communication between AMD GPUs over
> +	  the PCIe bus. This can improve performance of multi-GPU compute
> +	  applications and libraries by enabling GPUs to access data directly
> +	  in peer GPUs' memory without intermediate copies in system memory.
> +
> +	  This P2P feature is only enabled on compatible chipsets, and between
> +	  GPUs with large memory BARs that expose the entire VRAM in PCIe bus
> +	  address space within the physical address limits of the GPUs.
> +
