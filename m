Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B70DC6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 13:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03A710EDB4;
	Fri,  7 Apr 2023 13:41:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC2F10EDC9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 13:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvelwLD/G1MlPHoZOk3CtVAK19gKbgBwggiQ7wmKxqg/ttjDQ1A5YxNj7BK0PjbyTVDrWXwS3dFIFsBYCGDNz4lEQp6aS6kQF/iz9PP+9ShAhmc5CzocHbsQ/EdyNaF4i5PW8nIQSeC7mFvZTL8bPJteR+tXAuE4pJjL5e5VwrcwJkUAFNM1uedJ7ShZw3R1BHmBbVQeVsKevYUDUrXWuih2cKMUUKbM11F93UybndSgk9Pd4YGzqLYARMKtC0Lf2VTCQf2MfvH0CGIJAZfSqigq4NmWajeonXyhQ1dMgRXbK4AXh4PrfB4qD0usi7fhIEU1JKd2UDJZmTg9oCDpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5ujN0nSfnTKEhDsF5wLeFPt0BzLlLNEKrUcl/6vXxs=;
 b=KOcy6SeDx/IpvpSOA4sDpKYjAn7Vu3X5gmocGFlVR8aezZmWElEdzvQp0ZLt3dkcxTQEB3j6kN+BjIbfVLcEstixgfCET656+//yr9EeLWNc6SmoOON1K4qMvKNfnNELuu6e8RQoZ7ZO4s18SeoG9FERAMeMyxHSAjY8PhsW/a9S2qhzKh4nVxT60O5g2ICOL65y0V8d3Tg3HuvvUamJo/n+QTyHxYxUC5tyK+yMYcJGXcc/M8PFFMbCkpHXOjQf4o63xIqkksv6MwkL+9OMHVOqQtESMfrkGGoX2sp7H7yDuxlSYHiCVlAA3vIXRziKkvMVGpZ7hSP7ZIk8fQIQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5ujN0nSfnTKEhDsF5wLeFPt0BzLlLNEKrUcl/6vXxs=;
 b=33ZxoC86pg0/HdIxB8JHBv2NijD8VluXDUGtypE7dAossZ1C2XtIVpWhB6nzSahyQEL2M6WbdNra+xZib6QfAObsEezfZQWReCZceFTX1u3RdwJca7S6MC6gRetPUaGCo1wey0jMJLaMNrhemiWQ+XQPFTi9q3vt58T7Kn/+ZQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 13:41:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 13:41:50 +0000
Message-ID: <92678c6e-05b8-71b5-4742-828d5571af19@amd.com>
Date: Fri, 7 Apr 2023 08:41:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 0/2] Send message to PMFW when SMT changes
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, evan.quan@amd.com
References: <20230407053822.157046-1-WenYou.Yang@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230407053822.157046-1-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d70cd55-b859-47d0-7543-08db376dd723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNWbI31cwq4XCTakU5u924kWtA5UbSLtul+wnSdJVDYkSUEhRHCuAcijQWcb/c0oAb53eG1U79VfcepSBzfWZtVaB4WmEfSXAPOX4GR8yqbL/gK4yBre0+eOU0ssjUyOBj3tg9hy9oP9yHTJERCzAKd4Aqij3DZLwz5xtdBtDxSi3y4JT7ntCV/LeP7CcqQr8/fllUqs/gSZgST3GTtB7fxNeySCHVWNvok2q0Gx2kBG8C2yz+Hs0sPBYFJRLCvymOd6rNfQTEZr2D9is4DPWS548pmZ/KfzaqXo3cEbIB0RLTydtwFLxo0gpD0bXbe/346oO+19OYJkAvgceqw8P9Lrc+JxSOnykvmPRBEHybYxgbPdMvDUs75zniqVnb2jMWKxSCfcGGmz5I1pJ+w01ZWx9DpkIpiZB4MxbsLVEjgVnPmprLG8sqWpRNB+cXBFNIpyw/7CyHOJd/dfuBPnt2IlFkvd18NMS8+AHnzx3wJJjtiXPcLlErE5mmAFygjKz9Ky263YcqVGCYKkl+PThXOY2GjMCIyvweJPK296/Q4TflCQQDn1dJaIoJIpODK3e/gbWq+Kph5JCi1wuZskXfFZ5Au8VkTPnaWEcGAVIOAyAeVXXgdXTgej5/YI+/JtNJJnsHmWZ6LKJ88d+U4wkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(31686004)(6486002)(66556008)(8676002)(66946007)(41300700001)(478600001)(6636002)(36756003)(66476007)(15650500001)(6506007)(316002)(86362001)(4326008)(38100700002)(83380400001)(6512007)(186003)(31696002)(2616005)(53546011)(26005)(2906002)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBOZzg2V0tPa3I3Uy9VdlY2dEpsQlEwWmI2TWJjZGFVODQ3NVJoSHRBell5?=
 =?utf-8?B?ZjlHdG1uMEZaWG9aa2llaHFIS0R1WHJrRjlIaWZtckdZVzVWVGhjQm5iTVNK?=
 =?utf-8?B?R2dlYnJldnFrQUdLNllUdXl3MEFVdzhiVitXOVF1UGtPeE1iR0o3SHpLUHZ1?=
 =?utf-8?B?UmpMWUhsWFUvQ05TeU00aHA1VE1KSWNkMVh3b2FEWVNNc3EvN3BEM25TUkZL?=
 =?utf-8?B?MEU3MUtXZ01FV04zd2t4aU40U3JwZktSVWhLMVVVaTlCSlJZcG1kT0VMT0tJ?=
 =?utf-8?B?UldoWTJLb3IxMWFmaGEvRlpzeWpycWNqSDZoQXo2RmVFQ3Z2S1ZyazBOOTFw?=
 =?utf-8?B?YXgvWVkydmNqV25qS2RmTnh1MzhZSG1QcHJ3a2tLWXdBY0JzdTNNRlJxRmFu?=
 =?utf-8?B?T3dZOE5nc1pncWdWNFRwaENqQ0doSzlheXRWV1JDcDYvWkwrU2lNZ2NsRko4?=
 =?utf-8?B?OFIyVjRPRUE1NUVGOERldktWTkVLVU1YbGE1NExQMkZscnFyZDZ1VXFodWVN?=
 =?utf-8?B?UUsrTVlPcE1ZL3k2b1Z6elFWWXhDSzhQZUZMd2VobmpzODhJQUQ5aWpCNlEy?=
 =?utf-8?B?dEhudUxqVTMwYmVNWE42MFZsbllKTDRlaXNTYkEwTEZ3bVpZRzE5aFQwamRi?=
 =?utf-8?B?cEYwdC9xQ0U1N1VKZzI5VDZxZWg4RG1HejltWG8zVlZicWw2MitoQzBoSHM2?=
 =?utf-8?B?Wkx4T0IvUDdHUWI2dnpSTStvUzlxdnVOczFjY3dIMjdVTmFQQmkrQXBhbkJN?=
 =?utf-8?B?Z0Q5M3J3Ujhkd09TVmZQQ04rWmErQTVZeFFoT0JsMUpNOUY1MjI4ZWg5ckdw?=
 =?utf-8?B?akFrWGtnQlRYZ3RDcGlTRFJ0MHJ6N1BKL092cUp2NGJxd09pM1ZmclppNHNO?=
 =?utf-8?B?eUJwSzhGeTBtcitSMkowS3pFbTVSY1ZMMGxaMU10ZThVay9jK2ZLVko5UFda?=
 =?utf-8?B?clBQVzlRZzgvQk95cjk4YU02WG9tL1o1cUhtdUxUSnh1WkJGQStndThKZEZu?=
 =?utf-8?B?bExpb0cvWDYxN3JOcGVWZUgxdzhRUEFDMHkzTjlBTnlsSmNYV2xwOXAzTVFv?=
 =?utf-8?B?akllY2wwZEJmWlM0MjJlNVVsT1RVR1U2QURJaG9mazFLc0UvRURTdzQ3ZllT?=
 =?utf-8?B?UHUrYkk2RGt4UG9KMTM0VkJNd3RzcnNSbWpESkg5eTNPYUE4TUtBbkxrZnVT?=
 =?utf-8?B?K0REQlpYeDF4TGRxa29Hc2JpWFJFWGdLL3BMNzVOdFlCOTFON0RidnM4dWFF?=
 =?utf-8?B?VUFLZkVqMkdhbUxQSzdJc3cyL3h2NU5IckR2dVA5RTUvKzBzRTVxRWdxNWhL?=
 =?utf-8?B?akpaU3Q2OHBUNjY4a1FmOXMwRGxtNW1TWEluL3BuL0RXcUs1djhLOWw1QVUz?=
 =?utf-8?B?YTJST3c4dW1JUjBrV0lMTlg5T0pzbnVKd2xYUmgvcUJaQ1BjVTJuWVg4bmJP?=
 =?utf-8?B?SjRQT3BoV1lkQmRCMTVKdlZGd2dOMnZseFRuWVdJclRBZG9NQXdNTEVySUxp?=
 =?utf-8?B?M3FlT0FzQURjeVZ1eUhSb3VaTTZONW14c0FqZEdPRVl2cVRxcU5RUjIrSmo4?=
 =?utf-8?B?eTJ4OHQrYWdDTWpraWJNaWZyVXFDWWVnTS9NQWpvYS9kTHp1NmUyMURieWph?=
 =?utf-8?B?OW9OR04yL29HYW93NStQSFVxNVFsUUF6aS83MUZlcHdFUVJUOE9pdHpkalJG?=
 =?utf-8?B?Nnhqbm5XOWtXVmRqTTFlZXYrbTlSWENKS1Y2RGVXTjRCNXRMbE5PZmZ3aWZx?=
 =?utf-8?B?YjV2MGRMSzNrRFFGMk51enNib0hoSWNTYTcydUsxcEgxQitETjlMbFZIZmZx?=
 =?utf-8?B?YktjR3BWSTQxbGFpeEdwTDlHVVdCcHZIaDB1Nld3dkYyTlhQdytCajhlOE9M?=
 =?utf-8?B?QXpRYTBIaG9aVWlKUWNrRlE5WHpIbk93VVE5bzdycmQ2cEZnek0ySHlFeUt3?=
 =?utf-8?B?M0NaTVpMUldOOCs0OXUzbTN2S091eVlQYXMzTGtRakVNR1B6a1pKMlRaVjBt?=
 =?utf-8?B?RExLYkNSUmhtcnpramxGOVNtTXpVaTYrZlRTd2VtUFkxd01SQ2NaOHFjbEtR?=
 =?utf-8?B?M1ZYNmJyb2RqNGh4bHRpdkhqS1ptQnAxRjlZaVpsankxYzFad2hHMjdyb2Rq?=
 =?utf-8?Q?y9eXIhr/dgp0TAexw3KE6fHw9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d70cd55-b859-47d0-7543-08db376dd723
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 13:41:50.5926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKG1j3CXwltfKVNwN5W8Z/XeS3bvrysxVSq0H0xx6pgfh9ryaq3SuZbMdP4NJsABE+w/J1B3ENPBTtIUMx+tcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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
Cc: kunliu13@amd.com, ying.li@amd.com, weiyuan2@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/7/2023 00:38, Wenyou Yang wrote:
> When the SMT changes on the fly, send the message to the PMFW
> to notify the SMT status changed.
> 
> Changes in v6
> 1./ Update last_smt_active only when the return from
> smu_set_cpu_smt_enable() successfully.
> 2./ Use smu->adev->pm.fw_version to check smu version, if it is not
> assigned, get the smu version and assigned it.
> 3./ Remove the redundant error message print.
> 
> Changes in v5
> 1./ Add a new vangogh_fini_smc_tables() to accommodate the timer fini
> and smu_v11_0_fini_smc_tables().
> 2./ Move the version check of SMU version before initializing the timer.
> 
> Changes in v4
> 1./ Since we didn't find a good solution to handle the case that
> manually offlining all the SMT siblings using
> /sys/devices/system/cpu/cpu*/online to disable or enable SMT.
> Come up with a new solution, add a timer to poll the SMT state
> periodically, if finding that the SMT state is changed, it invokes
> the interface to notify the PMFW.
> 2./ Move the generic code to smu_cmn.c.
> 3./ Add PMFW version check for this feature.
> 
> Changes in v3
> 1./ Because it is only required for Vangogh, move registering notifier
> to vangogh_ppt.c, then remove the patch 2, and the number of patches
> decreased to 2.
> 
> Changes in v2:
> 1/. Embed the smt notifer callback into "struct smu_context" structure.
> 2/. Correct the PPSMC_Message_Count value.
> 3/. Improve several code styles and others.
> 
> Wenyou Yang (2):
>    drm/amd/pm: Add support to check SMT state periodically
>    drm/amd/pm/vangogh: Send SMT enable message to PMFW
> 
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 ++++
>   .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 +++++++++++++-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 44 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  5 +++
>   6 files changed, 92 insertions(+), 3 deletions(-)
> 

For series:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
