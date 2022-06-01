Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92873C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 15:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B3A10E71B;
	Wed,  1 Jun 2022 15:45:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7B910E008
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 15:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPdUos+pmy+GpLbCkyln+kigfpUZOiTudryYMW5saSCItYvQNzINB+iBW9NW6dyqzFvxdBbcxyzDqGCv4W72q8oyQaImk9JJDoaZgJBvdpQWeVnvd3nfR9PKkVA0mamlmBOmSwmORilS0ht53ov7KGX4FLlzKDMLDrU9xwlyaO9V9yWa/+rZsgSveo2VCA8AQegVajyULyIdF0JqXnFVg7sPTZPjBWOalD6sA5PxFZd7Tdyovsufw7ewWAZLUGycIBgUnKxb5tDGgMdFe2CjrNZw1ElOpYI3zyfv8+cW/0uc0mVv30Yrr2OngBxrJuknYe+9J6I2uEHxAY84TH0roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXA3vcvp7c+rfHzgk8vQ6px7jWGeaf1SGqZmR0IkeWQ=;
 b=U7XgF3l3loCwrfHEDsYTszc/z8m6xFNoTpEO5q4RXctSpWFjrRhw8wCCh2VmCPPtXT4lkraw7eJg5qmvFiTLUmA07XNtdlCNH8xuHz63FSZIHMW6TglmcfsR8kS8y4xUXuaf/0khmkpcaIQz/pzupu2k6weSzNSYn3lycyzpXfoGyZWVoEwOuUXfwZ8fdKFH9pvjd7VExkw4TB6qezXggQQ8zGC+CIovUtZmBiTV+P+5wVITs84OtVDVeJ3JtDFBPb9EitEC4Mph8O/7zDESvxEfHjjDQ+4bdkIrLmqg42Cy69wCDk53W+v0lkkf1xgCmU+nnsYg8uAkU3kPaytKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXA3vcvp7c+rfHzgk8vQ6px7jWGeaf1SGqZmR0IkeWQ=;
 b=MVd5XriyPVQItQsMIIrAaq3eBgQVMKNpsTQKD0jQfkSz9mirRiVbdjdKlkgWZXoi/vATaufrE773bwozIQozMhLCsFbDwuCgD94ufqEqYdJlYi3MPs2VcZPv2iQy/mu/VK1wHCeKr5j1f0HNpYQULdX/NqZkG3m71uVymK5QiVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Wed, 1 Jun
 2022 15:45:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 15:45:16 +0000
Message-ID: <f6d7a96a-1550-8513-8590-ebeb79943d08@amd.com>
Date: Wed, 1 Jun 2022 11:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] drm/amdkfd: Define config HSA_AMD_P2P to support
 peer-to-peer
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220531170237.809884-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220531170237.809884-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c58ec0f-b787-4765-1efc-08da43e5b97b
X-MS-TrafficTypeDiagnostic: CH2PR12MB5017:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5017F2B5821632D2484DDD6592DF9@CH2PR12MB5017.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBI/U3EdZOsw0lugodXcllXSonSVLU0BpfLQyhkHUpelk/BMvtVjsYYAgk0UBd7IdR6xOQ/VSrW1SIqE4Y+akvIWgDWWxGO5CSMMgU4XMAV/XjonjOcGQstw9S5Qkr4XuJIfSRJei9F4CCyEvPsW37dYxldGnDDsTq+Bpy20PiTXrysp47rRjcwCyr2xlLAZs4IYakFDE6Zbr6qaZMUCgbDdBW9M0TEoy2L4NhBF7UiI2Aq5JnFqMlcdXluFtY1espQTtf8DFBZP5pUWk9B0Q0oLzxhat92Z7GbcPQLqwKI5zVz8xI4YbZTkka87TSKWyxiMC/g9KWK+Z5hXaDw4jprIM5mwUEHHdYTnwHfkAR70QLLgcG+qWZ+2CxS86wyTnBKPsPhKiZZfwn15KUSovQ473f2t/NQHkIESmv+Vjtk07GsAf379U/GN3U7aiqFBk8JvZjZJh1mX9+Z0fkHWgFvhKap/iMJZ49vg92DGJ3uNQilnU8OsQzqY2BwdSBa8f4pVQfYuckNhHCsoaN8xa5lSbU4CI6dQLvMoBosq0tBTDe6Ut0hju7vKm/PYR82Gqk1Nq5kiyIJmF3GY4+Yvn9R33Gll+1wHUlX/i4R4gZEgcNbfwIZiCQDn3V1LrwSc16gQXqukXuWGKmWmlmxlpuBig5kA632VyecBVGDDq5kERePwExBzw6KJnLVpPJett1IYR88mwCLgcmDMF6eY++O7TvkGNovs/H3SHqJaKCcUtjMvPy15vbft7IRJQm97
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(186003)(8676002)(66476007)(66556008)(66946007)(2616005)(36756003)(6486002)(26005)(6512007)(6506007)(508600001)(316002)(86362001)(5660300002)(2906002)(31686004)(83380400001)(44832011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU11NkdVdU02ZjZhOURRV3hENGkzQ2F2WlNDRFlQYUNrbktCbXQyVC8xdGlW?=
 =?utf-8?B?MGsxZURUS2pMbzdXQ0hhV2lQT1NlajBGOVV1ZEZKb1oyeXNsVE84VkpVdnBZ?=
 =?utf-8?B?SkpDVjVaeGF1QmkyVDh3dzZXQlNkODREOFFja09jRVZHelNZc3FBaGVLM2l2?=
 =?utf-8?B?WmtUUC9yMWprTlNnNldVNUkyS1FFMlZycWhWVVdiV1FDaGJhYTNkZjY3dnJI?=
 =?utf-8?B?U3N6dlI1RktZVmcwNWN5TVo4VDZJYlVZVkE0ZlFLQU9yalRSUUtOYWpZZTlY?=
 =?utf-8?B?RFJKeGg3d1JPMnhDeG5zWkhadkdXV2lCSHgwcHV1WEtud2lJanV1VGJvSEdi?=
 =?utf-8?B?MFp0bzZlZkRVR000WTdJeTJ6YSttb0h4WUpvVENqaTduSkx1M1YrZGhzd2pi?=
 =?utf-8?B?cHpPTDZ6VmhvYyt2anc2Uy80a1gzK3UyUyt4NU9RcWVJSU1vSWVGb1F4YkEr?=
 =?utf-8?B?OVkzZi9vMU11YTV0ZndPdnFJcURkZ2ZuK1hBaGRUTjd3RkFzcXdWdCtvWDhH?=
 =?utf-8?B?L0JoYy9JeFVkRUFZczBKTThJbDE1U0JJejBVb1lOL0VDVWVQaGFRbmVFOFBZ?=
 =?utf-8?B?RDZmK3hPaFZkL3psanZaNzNqdGlHM1RzWTR1UkMzbkxhQVV0eU92N2VTQjVX?=
 =?utf-8?B?T2Q3WEcyeTNQT2JPWW9kN0ltTU5KRkFrV3d4cjJGYzNTbHF2NW0zV2dEVkpa?=
 =?utf-8?B?Qk4zd1NoV2hVTGNBMVlzdk5NRys3M1duc1RNQWhtTk9QaHFZeFFXUm1PNjM4?=
 =?utf-8?B?amExZ3lRWSsvVmpQSTIxZXVGb2UybFhWSUN1Zlh6LzZDa1pJZGdYNW5RWjd5?=
 =?utf-8?B?YlNJRXRWQlVBTGxXdHU4bXd6bTF1OXNtcFRrNmJ4MU9zZUcyRTlGYTNpWDN5?=
 =?utf-8?B?d1R3c1JiRmxSUmhOeGg1UG55RFlqRVRSVEh1ZVZPNVFOd0ZzUG1LVHhWNUd3?=
 =?utf-8?B?bEFLSEUvOEtDckFNZ3VzT3pRaTR0ZkNkVEZKRXlXUi9MbldqellmRXFCcGRy?=
 =?utf-8?B?b29xWHZTY0FaczZVejliQlVyTEZqeVVTK1ZHSGs0QlJIRlhJaUtjMy9adXJw?=
 =?utf-8?B?V2NpSTV6SkszdEJsbG9tQ3RoRWRkMHNTUnlrcFE5ZWJVV3NUdGdVckhKbzQx?=
 =?utf-8?B?K2xMUG93OEVScWU0Yy9XbVhmMlJxMXF0OTIwS2tQci8vY053QXRGVVpJSzhV?=
 =?utf-8?B?YlRKellGZXJLQVJDWFZaM3pzMVJoTXVTZWp1diswbUJwSUszYXpSZUJSUGxJ?=
 =?utf-8?B?ZmR1V3JWdTRqWHBhckMvWHNnL09YNTgyaTdPQnNacEUxL1U3TXlacWRiSTJq?=
 =?utf-8?B?ZGpocldFMDIvaGNoaWNqbVRrTlA2Q1VnOVRiS0NCbHRvTnVSdmtpbk1xTW1y?=
 =?utf-8?B?ZHVVeVgrMWNJNlVrbC82Y3FHWU82MjhPRVdMQ0JnODI2QWJOUy9PUU9KT0o0?=
 =?utf-8?B?TngyVFpYQkJtZ2p6WkZmVm1qM2wrSzBMaDlhYk5rcXhyVDREWW9sU0NYRmR1?=
 =?utf-8?B?czBCcVFBTkJvR1hoNDd3cWRtczY2enJVZjBkOEpCa1lBZnpicW1waW41ZGVJ?=
 =?utf-8?B?cTNWU1pKSXdIaWpvNUh3YXhrREhSNzBzakZRK3c0a1FRaUFrb3hreGVIdjRt?=
 =?utf-8?B?MklKVENsalVZRE5teFdOeitlbXlHN2ZXZTdkamp0ZWliRXd3VlVzS096Z1U3?=
 =?utf-8?B?dUx0OG12ZVVrTUxhS3BNWit1OGVQS0hwOEtpTE45UldVOENhT2ZmRmUwT3d6?=
 =?utf-8?B?bW56QkFTYWdoa0x5T3JMRnM3Q3o2NXhtbzZHVmZLOXBjUUlTeHIxMzIwY05G?=
 =?utf-8?B?Zy8rUEdGR09kUUZ6L1lPODFMZ2hjVUs4RlgxRmJPNGVpLzVWUENCV0QvUWFp?=
 =?utf-8?B?bHNRalBVc1I4UUdyZWNsMmpyN2FrcTBuc1U5QTZVckpNWDJEc1l0MnhYdjdH?=
 =?utf-8?B?ZStReGNtTktZRjZkRlhESHFWMHNsUUZMUWQyTWltZlRoZStTRmQ3Qm5JUklL?=
 =?utf-8?B?WlNRWGZDS2FlVzlTTmp3c0pTYU0zemxqMEpyZWFhVXZ0emxKSzVoMDkyc0lP?=
 =?utf-8?B?cFhaR0xtM3dUUUYrTWJwRXVaUmJNRFozSTg1WFpvb09TVTcxd04vZDJ6ZUtX?=
 =?utf-8?B?T2E3OXU1QTcxTzdqME9hMXFlY2J6Q2ZqdFoza3hvQ2Uzek5SMU9rMStTTDdL?=
 =?utf-8?B?aGFKVUFIK0xGYW85NHl5eUh0U1MrUEZpa1Y0cUxoM3R2OUwxbEVFN3dMZkhB?=
 =?utf-8?B?dUpKQVcyekdFbURYVlJ2NDlUSng5dkVVaXAxc1dLN055Mm1oS1VSWGJkamhG?=
 =?utf-8?B?UXhoZDU1Qm1lZXpEMXB2MExxVkxhNlRVN3g1d2pnVkFmb1VEWFltQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c58ec0f-b787-4765-1efc-08da43e5b97b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 15:45:16.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: za8TEEJeyc9nHEHGPiLCZjpRATjoeqMPh2HMZJBB45BPF6rGaqYBRytyNVqjo9AVAuAmQbvsKbspzNKqcrKqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
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

Am 2022-05-31 um 13:02 schrieb Ramesh Errabolu:
> Extend current kernel config requirements of amdgpu by adding
> config HSA_AMD_P2P. Enabling HSA_AMD_P2P is REQUIRED to support
> peer-to-peer communication, in both data and control planes, among
> AMD GPU devices that are connected via PCIe and have large BAR vBIOS
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/Kconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index 8cc0a76ddf9f..26614f5f20ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -25,3 +25,11 @@ config HSA_AMD_SVM
>   	  preemptions and one based on page faults. To enable page fault
>   	  based memory management on most GFXv9 GPUs, set the module
>   	  parameter amdgpu.noretry=0.
> +
> +config HSA_AMD_P2P
> +	bool "HSA kernel driver support for peer-to-peer for AMD GPU devices"
> +	depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
> +	help
> +	  Enable this if you want to access AMD GPU peer devices, in both data
> +	  and control planes, that are connected via PCIe and have large BAR vBIOS

I have not seen the terms "data plane" and "control plane" used in the 
context of GPUs. As far as I can tell, this terminology is more common 
in the context network routing. I think it could cause confusion to 
introduce these terms without an explanation to users.

The sentence "... if you want to access AMD GPU peer devices ..." seems 
to address someone writing an application. This help message is meant 
for users and admins building a kernel, who may want to run compute 
applications, not for compute application developers.

I would also not mention large-BAR VBIOSes because the BAR can often be 
resized even with a small-BAR VBIOS.

Therefore I would recommend an alternative text here that avoids 
uncommon terminology and addresses the concerns of users rather than 
application developers:

    Enable peer-to-peer (P2P) communication between AMD GPUs over the
    PCIe bus. This can improve performance of multi-GPU compute
    applications and libraries by enabling GPUs to access data directly
    in peer GPUs' memory without intermediate copies in system memory.

    This P2P feature is only enabled on compatible chipsets, and between
    GPUs with large memory BARs that expose the entire VRAM in PCI bus
    address space within the physical address limits of the GPUs.

Regards,
   Felix


> +
