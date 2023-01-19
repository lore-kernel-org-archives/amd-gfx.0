Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE3CC677F1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 01:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964B110E21A;
	Thu, 19 Jan 2023 01:13:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605B510E21A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 01:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK6avbVWu7JVGWVxVIyoEml5LiCVKxVbXTJZ4DkfgqvhZmNmdWTpJ9O1ldppto0sNZD+IIIG887wzJzYlEil/xYh3U31I+gPlBW/LStubgU3Z7fooCaknaLeuZDW2NvEJfNOVMmifeoj/9mwDHR/SQuSpAGsidRHk2wOeqVTcU5gEsTw182J5S3H6Z3QHCdjBIj8nNuwbS1+YMDjpFDi8lSlCtpeMosJOfiMrFM1i5MdgAMwzp2hUlYjvmeRZLy3tkW6YI66OkPZfIqDASMrBOqalAQsTfs1aMbxTB9A/i4J09DzZR4Qf1Lq3V62QfyeMW8/Cw6II9z0V7P3/lSAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFVCvgAiO2SriVj0FL26a+yKAD8oOWuQ2jWt15p/xWw=;
 b=kGQ9iqwDqiPWQpQwPYWTUAzaYEw9EA0/UzTLfZ/FHIRMzMJmVwC5bp1vONN6R1by5keixl7NPY7IW0CgGeVqLkmdfdyCDYsk5Nt1gs59TuKlKrs6StZeYLG5an7jp6J4t/Ys1GwBS2PvxrgKnfsMTgaNce79BsDLrdePaSqsy2U2xpkkGRH7LmzdwHK8Q36mQ0yFG3THj0K9wEMkqmIYF2zaX+V3AKZXi1iTnjvl7YTXjiHJgwyFyNDxpDEKSapWmFZz6oJPXjBQwrI2FSVXmSHcH0DdS2TocFKGYLIjrIeG3ZWXRN5SRUjmlyVKHnPI5lPZEe899X7QKTSxVO05Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFVCvgAiO2SriVj0FL26a+yKAD8oOWuQ2jWt15p/xWw=;
 b=vWlPJUiGrsmumvrDnH3E9ItEGByJTUBb8q+c+jvi17uEHJxpYp9mcFKdBnFPI72qeXN8rs5TCzN9ZNwBwOwPz/Qi8sH60drOV1YDlUsrloGmvJ45b2PbZVJ0MzXCOoSki6Lc2wnrRU5Lk3MtBU4UEAm0Si4kscSLg5dFMakjLrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 01:12:53 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::6dbf:f425:e4d6:d273]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::6dbf:f425:e4d6:d273%4]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 01:12:47 +0000
Message-ID: <28184a40-6c5e-5552-089d-8c8c261e099f@amd.com>
Date: Wed, 18 Jan 2023 20:12:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] drm/amd: Decrease warning about missing SRAT table to
 debug
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <20230118224711.6832-1-mario.limonciello@amd.com>
 <20230118224711.6832-3-mario.limonciello@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230118224711.6832-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: fb55ceb8-58d7-4f85-ebcf-08daf9ba46b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9fWYMeLisBrA/sRaZpnpI4kcGGEVfX8KL0IPxV+ijmiuKX90RAHMpWj/bwm3VPNfqFgAvauN8HHQPzUKNAcJuuiLTH8cUbHIme951qkjQo/3oDuqON31i59iVIBKwcZ/Cj8H31esl0UEuhzYE2CEWegHRh8amrbQJQiVbNZvoReD4ZeJU7tLyRiodoYmnN9FJxvK0AweituCvK1oGp//IZSkErjG9W+p4LRE5q6vbCPFeGzPHPpPv4ajn4TKbrJMJtg9LpNAXpMXWywPEeszg1cNsGalt4W9yb6MteRqhLmRNTGSTCI88lqEYp6tS7xfJXFGFmqJ4TOrSUpdlikDNaoE89chcpxGODMSZt1MQDtdwAaCOMbZfUf/OmNWioEK6/SPPlWDRQmsvWuZwpo4seOFWQDYbs2q97mttUPPwfBuWLqk+T/jQYlkcAPy+SjN84ETe6tnC7A4/ma37cCdRocp+rLGzvj6YdqUfLOswMcX5gVRN3dO3Z73FPVM1AbJsGndFQek6ZPojy/F09XOaXqmvDB3C0Chs148xlDFQHxiGxptcltaMM/lSR9qMg789vk7sg8hCJyQWgyhrXiie99m/h0Ljxkf9ltaPkijBO3+x/C1o2Welgi41DZNR/0zO7/DruqYFgdJQRqxFbaqjtZwlObY3KD6vl3/SwSIDt/s0OrivLUA//Av2kvOk4KB20xTPgq3L2s5WnxpNQfyHbNLsaKW/92fvdN19DYI/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(186003)(6666004)(2616005)(478600001)(31686004)(26005)(6512007)(38100700002)(316002)(6506007)(37006003)(8676002)(6486002)(6636002)(66476007)(66556008)(66946007)(41300700001)(5660300002)(2906002)(8936002)(6862004)(44832011)(83380400001)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZKem54TnV2anE3andpWEZuYVRsbkNvYk1xcEM2bTE5bWEySFNtZngvY1Jt?=
 =?utf-8?B?b2pOYXI5TkJiS3pIV2lUanFyTTZKT1JLVlJ5SDBja3MwTExJYkp6NlRiZEJM?=
 =?utf-8?B?TFZDZjVTQXhJWms1dkl4NTM1T0w4ZUY2ZXg2azA2OEIxbzJwbnE1TzVhSy9v?=
 =?utf-8?B?ck1RSXQyajVqaDh2SW5iQVloWWRQenVmd2cxa1JyODR2UkNES2tRU2xaKzdM?=
 =?utf-8?B?VHh2RStld21kRE1RYVFMcXJKU0M1RlRSbm1haWtCREdYc2paOVhBcEFzRnJF?=
 =?utf-8?B?S1dyK2NnS2Z3UFZCaGVtTUhxMm5BbmVzb0paZlhIYll6OVlNQ29xOEF2aUYz?=
 =?utf-8?B?S0g3Y2VpUjQwMkpxZ2hHZ0dTcWVTRTV2SDhQUzhtVThXQ243THpSbmxZUTZo?=
 =?utf-8?B?akxTQnZRbVZKK0twYklvaHdKSEVEU2NFZ0pqajFiWi9nWDBDdUNuYzRuejJO?=
 =?utf-8?B?LzYwTjVxM3NzWEFFL0xIZ0xKN0JyZHd5QVVCaGNFN2NyRWlUc1k4a3pNcmto?=
 =?utf-8?B?UEVINDdUbkVWUnZtNy9ZYmF4UlZlallnR0d6UDRBbk9qa3JhdEhuZHlRMUk4?=
 =?utf-8?B?UWJ2U3Q0VXhrVVhtMVdQVHhESVJvUVZMbFUwRTNBdVBkbmZ5RExMeStZc3Za?=
 =?utf-8?B?eVpoc3llTFNQcWdCL0o0S3VWaVFRaXkzTHdweVdQZWtLQ0RCY2E1QXM3WVBx?=
 =?utf-8?B?dFVVdFRpTnpheURodWlkc0EvcWhGWGVWWXFhUCtsNUdhemFWaUlpWFdDRCtN?=
 =?utf-8?B?VUlQZXM0RzJWSCtIZGYzNk9vUnUyencxS2licTJDMlFyUUIzcGwySjJ5QzVT?=
 =?utf-8?B?Y2JuL3ZBT0pBSmZFZHJRcElCMklObVcyVElDekRpZGF2bWlIbjJQZG1MTWtk?=
 =?utf-8?B?dGRTK24yNm1MdW1SZ0xKSHowU0kwL0RGeU5jejZ5bC82YlFlSCtSOC9JNFhB?=
 =?utf-8?B?a0hKT3g3dllQNkFhbWtEdyswWXNOSFhZSW5rSGVOUHdKZ1oyS3F1OTVVWWhE?=
 =?utf-8?B?MWRmOGZrWkxaUDlmLzdjR1RwUjEvMXNYNkMxT2YxM3lTU2pHYzd5YTdvbW1l?=
 =?utf-8?B?d0plZFVBRVZEVzdJdjFyS3pLcFYyamdOeUdSWTlOSGJCT1M5alh3eEMxamlX?=
 =?utf-8?B?Rk5CQ3lXR09uNDZpbkxuc0pxaC9OTkVVZVhMVzI2WDhjN3ROMDl1Qm5FT0dJ?=
 =?utf-8?B?ZjZwdENVTHAyaFozbnpkanZiZmtwN1Q1KzQveUtFd3MrQ0p6UUNoTVIyd1l1?=
 =?utf-8?B?dU8wNmdLQXZIQUpqM0kxN0MrNVNwUGhoMkt2ZmRnaVF2dTJzamthTUZDbWEr?=
 =?utf-8?B?Qk9wVVBxaVJCK2NXQmlzVnB6T3ErMFcrTEs4QXlxYzVpU0tIN3dLVkZCZ2pO?=
 =?utf-8?B?NmFQM2FSbmk5RndtN1ViaENuU3JWT0lpdDJ2WTF5dlJVOWpVdnBxcFF5aUsz?=
 =?utf-8?B?by9jc3ZCa3pKaW5XT0dWcDBXcTlyd2JHaFFjRXROS1BYS2YxclZqSm5OM3Aw?=
 =?utf-8?B?Mm52dGd4Yk83TlREdGlLTHNMU1J3ZkpzV0xLOG5pUTZoZEcwbE9CK1RwVzly?=
 =?utf-8?B?V1NzcWFSNlo5b25xaTlZNVZnZzhLQ2RLR0djQkcvUmh5U3RhMkh2U1p2TFhh?=
 =?utf-8?B?bmorcXNlYXRScDB4K3Jpald1eGxBb3JXUTNzTmkxN0lMai9kTmpwODN3Z0Rh?=
 =?utf-8?B?QXpQcUU5c1V6VmxOV1U0YXFlVlEreml3RytiVmxseXZ0RjVBalJTVFJCRWlT?=
 =?utf-8?B?a1R3SlhPNEl5T3FUa2JIZkdkdDl0bkdyMVB4UmR4c1FWNEdpNU1tSmJVTDRB?=
 =?utf-8?B?N0h3Vy82NzdpOUYvbHd2S0N6bGZWMUN5K2oxMEc2cWYwK3R1RjJUaXhDTWdE?=
 =?utf-8?B?ekVIdWUvaWROcVVUeG5EdFhRTFVLaXdJSkxEc0lDNmxiUnNoN05xaU1mazg3?=
 =?utf-8?B?UUcyMFlZeVlya1BqbEJvRFVwM1VYeXFuTFNzWVRLTnZPa3I2WEJRLzQxUlVi?=
 =?utf-8?B?K3dkWEdQTlgzNVovMEZsa2s5T2lSTzZNM2YxL003bHNXNXo1V3lqMHdCNWpL?=
 =?utf-8?B?MWdianZPWlpMZ2x4RkxZK0tYTFMrY2wwejB6bDgyZWEvTHZEUkR3RCtjcTRD?=
 =?utf-8?Q?dlv+P/sWQdj0BYqeqS++67u/V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb55ceb8-58d7-4f85-ebcf-08daf9ba46b2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 01:12:47.3585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zRJfbTwy6h3skAXO+kNMkUqlVevFdrAwxoH28CwGroNo9sTPS3cmo7I4qjEmGUoApvmjc16N8oyKjfbpcHBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

Am 2023-01-18 um 17:47 schrieb Mario Limonciello:
> As OEMs will control what ACPI tables are on their systems, SRAT
> might not be present. To avoid making an assumption that it is
> there but still be useful for debugging a missing table decrease
> warning about missing table to debug.

Finding out the NUMA node for a device only makes sense on NUMA systems. 
I suspect a Cezanne laptop is not NUMA. So maybe we should update the 
condition that leads to calling kfd_find_numa_node_in_srat:

#ifdef CONFIG_ACPI_NUMA
         if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
                 kfd_find_numa_node_in_srat(kdev);
#endif

To something like this:

#ifdef CONFIG_ACPI_NUMA
         if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE &&
	    num_possible_nodes() > 1)
                 kfd_find_numa_node_in_srat(kdev);
#endif

That way we'd still see a warning if we can't find out the NUMA node of 
a GPU on a NUMA system, but you won't see a warning on non-NUMA systems.

Regards,
   Felix


>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 3251f4783ba10..a309cbc235c61 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1904,7 +1904,7 @@ static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
>   	/* Fetch the SRAT table from ACPI */
>   	status = acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
>   	if (status == AE_NOT_FOUND) {
> -		pr_warn("SRAT table not found\n");
> +		pr_debug("SRAT table not found\n");
>   		return;
>   	} else if (ACPI_FAILURE(status)) {
>   		const char *err = acpi_format_exception(status);
