Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB756C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 16:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3933D10E3F7;
	Wed,  7 Dec 2022 16:32:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F26410E3F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 16:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krhmz/KnM9VikYac8YjmzNoH9rzBlk8GQ9ne2pwB7A3QDMhAjBkMYl+HZ3pfpkxYvr96VqCWNKdgFluhfKEfKBXcKKHyCsdLVb4PhfrEVgs6r/iFLO063KqwJmfF0cmbv0CsQUtPBbYK/l+NWxq868xR0fxne4cl8ylUFDJeoCmuskpwoCHLh2ZAAN52Sy8PvYzjNl3F1YrRSJN+p5Qp+yoNePYMJkYM0Eje5STlLW7mIWtOt8SZ2V8ZHEpftv5IDD2L/XSZH+At0VFEcIUPd943NqvRkTz/o8ehWLurggrzXmKt0ZUb+VjDhzoJt0FQJ/s4GyftCDuknl1OldKFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4FFRPPdyGRp2jsx1YD5otNUDN29mzbEOGKApddSyJg=;
 b=lPIZ+VsyNUFEfSaaXTp/Yl8pHpYjDrKaurrU8i1rzLibkhm8GydLkKQS+GRRzRA1XMqlKWKTMlCjVIPx5GOxiK11BaWaHKe7RRNneJLDuWbWUHhNIqLFGS6D1tCz9drpE7C2/mEqA77y0dSEcsSAN1GVUzi+w6dt7nddWorKsr81xfrXLH5RsEcn0lMpZ2hQyqjZsFAY/nlsbhYRblSN8JFYQ1EyCQqu4wfTnQX/fGnlqw5ENHHTPkva/jNJr4LPBg67EdZriwMiXq6/nKWIV2z1UkKtkjyaJyHnnG5XbMIibqqU4SnmyiIyyioxn1cfUqyksCrECc/Ms8y9US3c7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4FFRPPdyGRp2jsx1YD5otNUDN29mzbEOGKApddSyJg=;
 b=WZ6CawjwO8uXDohzJHpaMsGABSoZGG6enKcrTJX+vG4oeqsq5XCiN1QEOkDCDfPGw2Ey0t5rnRFQFrS300niMYpciXlxz8rjlRLuIBvpNQfTQW5uaBL7yQQx1cBfhkPBZ61Pxju7j+jgtvU1ipnxBj7JdPk7bkR1Fts4GaE75Ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 16:32:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:32:35 +0000
Message-ID: <021697fb-8c0c-f078-fb04-9d09ae4d9d19@amd.com>
Date: Wed, 7 Dec 2022 11:32:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: fixx NULL pointer deref in gmc_v9_0_get_vm_pte
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 vprosyak@amd.com, Kenny.Ho@amd.com, Alexander.Deucher@amd.com
References: <20221207074936.1347543-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221207074936.1347543-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: a344ddd9-7db1-4c64-91a1-08dad870a4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbDB1UHwX5ukVyWyJ0VyQeM4ggk5VpggnlmCKXWVmXyK0Tlk1QZnaW0hAnX/zV52PDEZr2qE6WP0pcU2GKUxqfxJmd7QTqvdqQdtmIIcnkM8YsBT03IjmRN+uxJ9iuEt+6pGKen3f3qNi/y2fY/Bd6sVqDkVRgo+G8SlgOBvnQi3OX77cVd3Pea8u+l4953eAN1M1sZ1jDWS4zdVoAi6OPjZ5LpLLCYLJu0wMWuIo1S57+qPXlFi7J4iSlwV2R6lvlpw7NsydzD3zHF45s2J1QUloLJ8kZclKi94X/eCMmqHamQm7eDlCUwBQJEjnnYq9ML0rV2k3y9aE5wGMgYluNOR3ROWB5c/CTP0Iv0jYgqCX//Eohps5A7MtpuhjC0GTPfkcMr35geEkJ2XC89lcnxbdPSHA4F4EdHPoNL8cvFhjMosgE878AYk1Pux1tqzFzW1St1fFwUaC64uF0TWNrbXpTkCwsxQg5rKetwYfhV9/iaWoTDonAaVUfjNDCYVEIheRGFNrAN3wjCzeD/4J8bqQutjUiqqBWuma+5VUH5qpobKzdXkMtFzilFSVC3hQLFFSLORkidL718cEbu8vR8R3x4HctTfn+mKvCcVoJe7ht3smzcV3sVkr6xaAFUlAh/BHHxMpUvpUwUvsWSuMg/TB9LbnhxsoI2b73WM9i8Ky+Cgipgu7bwF5ABouDyr7OBdLFvrtqEutWJwxKok2Vf/em9KU9ISAU9Aa2Jir6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(66946007)(8676002)(41300700001)(66476007)(4326008)(8936002)(44832011)(31686004)(316002)(6636002)(5660300002)(66556008)(6506007)(6486002)(6512007)(478600001)(38100700002)(26005)(186003)(6666004)(2906002)(36756003)(2616005)(83380400001)(66574015)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hVVllTdnR6T2NMc2hWRStCWUVXWnRCRjd0aG1yRFpHNHl4K2xnSGlaS2k0?=
 =?utf-8?B?SDBkYVZ6NjdFN2dDRWdhcjBrSEVXYi9xQS9qcE5YZURuT1NpcnlpWGZQNTc5?=
 =?utf-8?B?QWZzdStVK3BwZnM4WHFQU0FQc1Y3UjBobmlrSnlBakwrTDlwZ0V2Mzhtekc0?=
 =?utf-8?B?VVhmVUwrM0NJYWNLRldoaEhObUpPc2grRUtYT2RtdTM4ZEh1dXpZVGVuSXRF?=
 =?utf-8?B?WDFmYVI2UXlxU0hubll1SExCOXJ0MXlCaVVTUEk0YzBCR2N1LzFmMkFxTUEv?=
 =?utf-8?B?WmVWNDVCRDFucUhpUnJZaDlYT29kUlozVmR2NlNwdW02TlpPdXEra09ZeGpQ?=
 =?utf-8?B?WnJ5T3MxVVRWUmZXZ0ZyUGhFZlRiTnZ6eW9xZ2tDV2Zvd2tubTdpMWNTNllE?=
 =?utf-8?B?bjdTZWJGMmpJT3dCRHJiK0dpWE9maUZoOGI3eXhFRzBVWnR3allIYkxYQXpq?=
 =?utf-8?B?OEJmL0IwTGN6bGpiSnAzZndkRnNoditBWjZsMThXU1d3V2RYWEJHUDFvMlNm?=
 =?utf-8?B?cWF6L3k5RlY0QzZBVDZUb2Z6eHVLdC8zeHlxenk5QkZJK1lVV3A0VG9Ndy83?=
 =?utf-8?B?MVVnc3JCZllyZU5UQWFReDFpWnVpRFdqNUZGNkF3QzNlTUZMcmIrWVNXeGh1?=
 =?utf-8?B?OVJaUzhOczdGekk5M0J2N2pKMkQ0aVpTeU9wSUpDR1B3YXR1VmVvTmRUYi9h?=
 =?utf-8?B?S3VqdU9zendpS1ZZajZYRWl6dkNVWkxjZy9WRlIvSG5jekI4Q0hrUjRXblZE?=
 =?utf-8?B?OGY1djRVRU44Q3ZMdi9MQlBDMTBUL3REYUNCZnRVNEtLSmd2SEU0TXEwRXY4?=
 =?utf-8?B?ajFoclBBMGdtdWtXMFBnSmIyR2gwclRNbkpHaFRod0VoOTRmWmxmTEhrNmdx?=
 =?utf-8?B?Z0JJN2txbHMvUUxMS05PS1g1L05PcGRDMWlLZlpITktiMVdrU1J1ZjkwQm5l?=
 =?utf-8?B?VWY3SERGT0tPZG4wOFEvaUdNY1ZTQk0wcGRTSStGbDNPUEt5L1U1T2ZRWElU?=
 =?utf-8?B?UnZqMiszSmVUVHJnaUV2SnFvdW1waDI5TjNvRTMvNVJLWUdPSVkxVi80VEVF?=
 =?utf-8?B?SE9rdzZQandNUXNnVWNFaFl5eGFWUFhNVXdNYUhYM2txRmNHOWQ2SEdyU1A3?=
 =?utf-8?B?S0JRVkFuNjdQNWorM1l6Z08xZTRqdHplRGljOVVENnpYVHJYc1A5cmxNdTM3?=
 =?utf-8?B?UjdVZkRIS0U3SkxqTEVpUG1EdFI4M2J3L2Z2N0Fod2dtUkVTNHgrWW9ldHZW?=
 =?utf-8?B?NGE1MEZtbU1ZcUZRV2lhR3U4NzRPMzRYRmJBcktlV0QvVjFuWlF4WlluRWlj?=
 =?utf-8?B?c1h3ZXpUWVNpOTkwTEZLOTRDa0tDTzgrL2tIaGNCNGZRNkY3OEZwRXpPR2d1?=
 =?utf-8?B?cERhYmFQcHNCaU9vV0loOUF5MUNNekQvV1Y2RVo1NS84bzlNSXNpMjUzdDFS?=
 =?utf-8?B?cEwwbk84WExpSkxwZTJmUlF3Mk0xbmlFeXFpYitOVnRHSWV1bi8zMDN4S1lU?=
 =?utf-8?B?eWsvaFRta2hoUW5lQzUxYjNuQ1dNWWJwMkFxQ0srTFowdFFGOVczYkJROXFL?=
 =?utf-8?B?NGxvTWtDVUVHNEFKbWE1Y2FlUEJRbDhJbHlDcHJyc0pTemVTTGRrTjM3SDdm?=
 =?utf-8?B?ZUd3SFVqcFZJTHlST1BJQWcyMDhYU2JTVmN1VHFRaUtFRDJrMk1Ydk8xdEdK?=
 =?utf-8?B?VDJFcUx1bzRVVXdOSEgvbGxidUhsdmNQaU4ya0diNU84T1Rud1k0NElwcnl2?=
 =?utf-8?B?MmkvQXlJVTRFeE5YbUF5SmtHOTIwRTlUaER2UVVkYnB4UlFBTDBlWm9tZ1Fr?=
 =?utf-8?B?Wnh1MzFmZW5wc0hWRGozVnEzYzhsbEhmdUhpUC91ckdVNDNwNjYwK3ZYT1Iy?=
 =?utf-8?B?SjkwdjJHUDN1WlRDek1XYW10bG1tcUEwK09ma0hEZ011MWF4QTNmUk9IdERu?=
 =?utf-8?B?RmlSbGZmMzdYMDdpTFlheWwrMXBDQVdBSWxlckJuaFIwZU5sSmF0OVBmNWxj?=
 =?utf-8?B?R2R4VElwM3JRVzMrS1QreUtQZ3k2Z2NYVGFvUFZlTW4veEJrTVZkTjZ2bEhC?=
 =?utf-8?B?VzMza01sYmxuZHg1d1N5dlc2UzQ0SmR6NXlxVkF5NTJiNGxlWnR4YStGSTBq?=
 =?utf-8?Q?5N9L/sxpLv8Fad9wl+V6XPE7l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a344ddd9-7db1-4c64-91a1-08dad870a4d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:32:35.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPQumxywQH0R+M5f9y0arVc1DP9WqtQFVlpim+RXTVVg4njD5xRAs1N+KpYWXKBh1rXB09LtUagt6dfly2AJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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

Am 2022-12-07 um 02:49 schrieb Christian König:
> We not only need to make sure that we have a BO, but also that the BO
> has some backing store.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Mea culpa.

Fixes: d1a372af1c3d ("drm/amdgpu: Set MTYPE in PTE based on BO flags")

(using the commit hash from drm-next, not amd-staging-drm-next) Other 
than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 50386eb2eec8..afc0cfed5065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1185,6 +1185,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   				struct amdgpu_bo_va_mapping *mapping,
>   				uint64_t *flags)
>   {
> +	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
>   
> @@ -1196,7 +1198,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
> -	if (mapping->bo_va->base.bo)
> +	if (bo && bo->resource)
>   		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.bo,
>   					     mapping, flags);
>   }
