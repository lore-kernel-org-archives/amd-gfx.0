Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A92C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 16:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E3010E094;
	Mon, 30 May 2022 16:04:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF0810E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 16:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbMyGYTJA7Oa1aq4Ufl1R3wc5Wzam4SWqKitIVMQyN1EYHdfS8XQyssgo7VK32aAe/FbFcWWiSCt+x77LWVXrt+TTE6JHO10kjCcloKChGlhQbqT+y6IBLWhAIKyFLLlEhpr0TpfbxJA7S6JMbi4cC1Y21VxgdMT02rLiDSqY8XhyHvCiY/G89oU2iGs6GIIkoOSX+q2UklP61/i7h0wkiRuLc/vNFzzK6tY3oGyxj7mQa10l2DCLtOCxKBH6qcxnJ/tNhvVGWk8IM/kJuGcQjoq2274sfSikTXv35EHaLnZ26jl9RH7L+E/qk2/lWDLm2UAYrHORit3XxbRuq2axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nY77dmoaovTAHwRotkpvpBZNVIDL01QvNarCfVxYNE=;
 b=aKSVOJghk/XvSwkltqpikxtpY3snJ2t1BbMb/cskRVaEkjNz+XPOVFrQs4V9GM1CRShlJscsFkyQwWhJtE7889WUU7wC8JGF0QcvwJATt8Vx8z/C0yAOHZEwHNM1vANptTo8m9+xlBEyZbVWN9V8deGwuCAKw/6fiRG6jo3EcKgWOvOmtpGzTMksZ4it0NZMKqiRTABJtJ3aoRrIRzEtfwUSDa9+VXFwSqvvlhDzEMOnHeAUxgqiFPBebTvJKRNSgRVlUqB4MeAn8zy70EwZS0iUKjnBlb1Zq1yD/+M/my3Iu6QPO54Mo4xxXY/MsPCBjploj3NneXwRXSDlk3NnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nY77dmoaovTAHwRotkpvpBZNVIDL01QvNarCfVxYNE=;
 b=c7AW9FFshYFdX0z328fQ0D53IjkrQ0vKkUytTHBS48jpRCqWPiFKQ9hSCd6s79Xz433ELbPgqfmIqxKIG23KKXerpp9mOkZMSI7WHw0Oh5cVAsJ8vgv4BKlSd/rMT2xSnNh+ZPVOHHMNLvMNbllzi+PR06FAlBACTMRNUH8D/xE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1168.namprd12.prod.outlook.com (2603:10b6:300:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 16:03:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 16:03:59 +0000
Message-ID: <9147bbd3-63b6-2ef3-83d5-3c700762b9be@amd.com>
Date: Mon, 30 May 2022 12:03:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amdkfd: Use mmget_not_zero in MMU notifier
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220530145701.3881-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220530145701.3881-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53192007-a8b7-4ad2-592b-08da425601fd
X-MS-TrafficTypeDiagnostic: MWHPR12MB1168:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1168F576DC55488EFACEDFA692DD9@MWHPR12MB1168.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzEM0UTFf3g4Z+79l/6F0K1ztIPg3Xci4HdF27hR4YZ1mi8zN4KSuWoXr3IB1j8GY3iLOrGFVpj05PMfPezyvZtML6P3JR1JvYq6lkVVTbgrZgjvtPCYGGmLgnIUw9ts+C/FQZPA9+fkb8LkygPXLxRd8NEelxJ6oGUcSvPmvmC5eZTg/JPA1VineUBjUO/BSM0/Rt6b2WxMH7NUuLaACB6qPk3/dd9RqSnaa0dIE2U9+ztSX9ZElvi+7HNVYbTKXtYFXICXBXqjbl5a2erxs0juyRXS1FMepkdyQXld62V/3a1idRkOZzfPCRy9aEg4AQFg8vUfx5BsOXcxcNWN2j+weku99Mdznum7ErKQ53t7YXbn5/HSCKKKiCJcA3Q/vQQ4725sLiP0DmW1wzCMgVcD0kaeHyw/Jw+xLuuPajFkF0iOeFO3UFxwF2jW8RWz2MUWKlReU3QXOaCSxdY5Yy+/+V8JRMGHdHARlaz5PKOEHcYdUR7GaibYKffVgQiHtEjN9q5KcZsPaqbrYp0Uh7fEbn84Yr0Y8j8Zj1TyMR9A1RTEtWnTcDkxdc6y4W8MYwiyAJqxIr1Yq9UwBReoPTZ+V07h3sXQEWsxOveyup5ShRa/hVov8LkTFQpWE61Cu9tl7pUANU0WUdNfiXhnLepoq22ft6bzLTQ/Vbn8y00iJZt05HeikitufcdicAsSPgRXzuNF/1pkLmypEC2dCAWr/vzvyepOdZpTfchXaRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(186003)(86362001)(2616005)(508600001)(44832011)(2906002)(38100700002)(8936002)(26005)(6512007)(5660300002)(6506007)(31696002)(36756003)(31686004)(316002)(83380400001)(66556008)(66476007)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBCWnptcjRSOTdVMWNNcmxGbmlkQmxwc3NqN3VRZkwyOGdobVgxeG9mREZU?=
 =?utf-8?B?QjhGVkd5anR2RDhHWm12SzhzSXlwOWpiOXArQ3FNTzl2VWF3dXlQeHRwYWoy?=
 =?utf-8?B?ckUzdEVwVG1nYXRJbml0cWMvc2s4alRwb2E4WnE0QktSRzV3cmE4UFIwQmxj?=
 =?utf-8?B?UjdnSWxCdzZLWTh3WFowVHlqUFI0M09RU2lQWWtaT0NIYzIyaDJYRm9kcWpw?=
 =?utf-8?B?TTJDckhIaVNrdStKR1B2MFYyakEvSExzd3p6U1dBWlowMHprZi9SUURLSTA2?=
 =?utf-8?B?WEJNMjkyY3U3QllOMVo0WFpKL0ZEeFlsUEVzOFR2UEU3TmFKejdpSUhCK2NO?=
 =?utf-8?B?VWVydURCeWk2Y0Iza0FzRzZuRC94V25HZDVHZU02NkJkODZKYS9XVWtGZGhT?=
 =?utf-8?B?TVAyZ3pvODB1ZXBkTVFsNTdxUHZvR2tINVY2T20zV0pBOUd6eHZLejlVRjNx?=
 =?utf-8?B?SlJzZkg4MXlmRkZmcFFjUU40L016blZoMFEzZUFXbGVVemlvcWRCZGJHa2Iv?=
 =?utf-8?B?UGxZL2ZxVFlVcHprdWYzV1R2WnAzMWU4OW5iOFN5YWt5aE9yZTVCZ2dmU3VC?=
 =?utf-8?B?YkJrUUNkQnVjdUcwMktTRmQ1elN1NEZRaDlTYi9aUFpOazI5OUR3WUhLUFlX?=
 =?utf-8?B?SXFBVTM4T3hrUzYwNEd3RjhKc2RUbTczd3pzblRvRWVUcktoWDNZb1hQVlJY?=
 =?utf-8?B?Wjl2TFJ6Zll1aUM5a1prdUNPRWNsWkI1TloxQm9DRDd3bWRZMFM5VElrcG9w?=
 =?utf-8?B?d1FweUcrdDhlTUZPeXIzeVc2eS9GUHNtVW0zS3V1UU5pTCtkek5EdVpjYXIw?=
 =?utf-8?B?VEU1N3dVSEFkbzdRWWRwckREVjh0dFFZQ0srZXNKNmlQRWVIaXE4SjBxVkVB?=
 =?utf-8?B?UisrOU1zRytYZ1krMW43NjlSTmQwbzAyR2ZtWnAySTZJWkhyYWtabXhycEpC?=
 =?utf-8?B?cUlZclpTaHNEOFJBeU4rMFUyUU5KRnlLOUIzU3JxVFNsTjg2UEJMKzFEQWQ2?=
 =?utf-8?B?MndkYnA1K1FEM1NGZjNwMko2bGNUeHoyRktSM3VTeXhoWTZWMVRzbm5ucVBj?=
 =?utf-8?B?Y0tKOWVUWWJUdGtUc24xYWNEWFUrOUVkdHFsYlpRU3lKdHFLMUhudkpDcCtY?=
 =?utf-8?B?NlRsZjliM2h0QzdvOXd5S1VrRzBkajlhb0daczZKRmkyUnNlRThDOS83ZVVq?=
 =?utf-8?B?dnFTV1VGUFZ0V2pIVWhqZEhuQTc5WWY0S0NNZjc1MkxSZUNHR2RrdkpoWGpn?=
 =?utf-8?B?MzF1ZHhTQmRFdGMzNENwWFBBKy9DMWVib1N1S3M5RlAxTXdMUlZMWExzUFIy?=
 =?utf-8?B?Q29SYkdtVS94bU9ENE1IT1N2UXNROUVHaWRESDFqMUxXak5KVmRwTjE0Q3l3?=
 =?utf-8?B?Z0pSb2Fxcm1XLzNmcWhBdjhjaFlNNms0WEZPbHdKNWFSQXcxU2hudDBmTlo4?=
 =?utf-8?B?Y2NNeEt1K2FWN2NiY3BFV1RFZ3hvcjd3L2ViS0cvQ0VPWkU4bjBVb2FEY05a?=
 =?utf-8?B?a2R6OWhSbkZOMXgzbmJpNVZnSGQwZkw4aGFTS2daejJvQ2RkRzJkWkhHbVBB?=
 =?utf-8?B?L3JmM1VLRTAwVm0wSTduMG12MUhlYXpFY1YxT2dzQkZGRzYzTUp2ZEVXQ254?=
 =?utf-8?B?ZHBRaVN4U2RFL2orRFRNVzBEdVh3SEJ5emtITHl1WFBEZnF6UVVnRGdHeWhJ?=
 =?utf-8?B?NnN2cHpNQzJONzZJV3V3L2g2anVHelU1a0tCejNKL2JqeTFsZkFNS2dsb1Er?=
 =?utf-8?B?eE1wb1NOZUJPUHgzZnB6eFYra0JvRWRiYkFKWGJUdFE0dTgrQTdubnlERDRt?=
 =?utf-8?B?dkZLSVIwMkc4NWs3U1VTVXNUdDFjZUI0UEorRHdMOXRMNFB4Q292cGoyVWdq?=
 =?utf-8?B?bi9jekJjTEwrNi9BcHJlU1Fqa1VVL1VrZUROaVNZNkh6QS9GNFM4b1pEYWZK?=
 =?utf-8?B?YXI3QUdZMGFwNDhjekVzZlpGMkNkY2duYW5nSHFKallnQUowRVVQbWxKNitH?=
 =?utf-8?B?bk14U1QrWEs5UWE2bmNrKzBkcHd0ak1Oekx1K3RBN1JmTS9PVFlIYVRkT3dt?=
 =?utf-8?B?TmJJRDF2SkxYaFRxdERsV2hSZkgwd1pKSFljakNId3AxTlVZZDE5bENTVHRW?=
 =?utf-8?B?Yk55c1czSFFlN2xGVVUxRWZadGo2bWEvcjVvVFhNQWxzZ0J4OEd0Wktyam5a?=
 =?utf-8?B?TDhxWlFNZmx6ZER1eWZCUUorc0RUTGREaG45cWl4SGR6TlM0TkF0WlgvRzQz?=
 =?utf-8?B?WkY3U3NZMTZhNlJ3UnZPMlNZemZSOEc5eFFwci9lVjQ5NkljVExUeXROYUdL?=
 =?utf-8?B?Tkd5VTNsb3Z2WmtZenVyZWxJZDRZckQ2b2owV0ZqcXRWU3BoWVV6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53192007-a8b7-4ad2-592b-08da425601fd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 16:03:59.5910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GVJbOpQljX2/uLf1EIj9ox4phC//pc3vk5VL+k4uS6FNbGt4/Liag/c17xOlkmvQ5GKe+8c74ys1Yvxvl3Bwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1168
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

Am 2022-05-30 um 10:57 schrieb Philip Yang:
> MMU notifier callback may pass in mm with mm->mm_users==0 when process
> is exiting, use mmget_no_zero to avoid accessing invalid mm in deferred
> list work after mm is gone.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 835b5187f0b8..2ba3de0fb8aa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2307,6 +2307,8 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   
>   	if (range->event == MMU_NOTIFY_RELEASE)
>   		return true;
> +	if (!mmget_not_zero(mni->mm))
> +		return true;
>   
>   	start = mni->interval_tree.start;
>   	last = mni->interval_tree.last;
> @@ -2333,6 +2335,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   	}
>   
>   	svm_range_unlock(prange);
> +	mmput(mni->mm);
>   
>   	return true;
>   }
