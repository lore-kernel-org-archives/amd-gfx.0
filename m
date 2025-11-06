Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5234FCCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED0410E94B;
	Thu,  6 Nov 2025 16:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JGyyRi7N";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52E210E94B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZB0PXzBqeYpan9kax6y159K47JhbdmvyWjULWhuzeDPBSlyWTb+HqjWriXA5ZZqjBEWd76tzaEyMpdusMkCve8k3H5lgECcMvgJKFeT8FGTa35ERCeA4Wh7qNUHOQ6j4yR4TCLHk1e6HTHmXCqEZZ46epbdblFZ5vT5IqUY+h+vLN8sYCeIZwGnxaV+VsSugQxIbOgXhuj+YEDmyobTbpPY/z3VOFRRoc1/BaT5Su+EzJvdZFeoXzzfnU6qSM+lRxiwGbd1n27CF67W0Zw5XMSrWCmecFE6D/egD5sSO3UvuejPqI3fZSZHREV8K+VOnxjOaBhijAlBHPvVkoYVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82MEcIngSeT9jrtr7aihyTgA5JguYhd5oJOzrHCtXMk=;
 b=R12EnIUeIxmxrxCUPTs1Td00xwtQTIuZHJ5e6TYGrF4iRfyitYoUna5J94Y4XTWFxrAk0QttO1dSPTrQPBUDqayymal4pyOMfCPByuZGTgjuk2izQOQzcVp0PMwbJS7noIqNeUsvCJW7Pq+2rVfMSN8mR0cwJsVqzCx9pKFJ2jpcxbjnv47GIie0izEE2Bfekh3GfM8ngtWrYhqPhkTB1jg+OME5y11wJWu7JvRbeeLThtv9xsOEJIkSB8WTIHYVYzwU9Coyf4HEeppuXyVg+plbO8kHkdPZdXKZPIZoU9BsIGopOgEGM3uKoaUuEzIn7wUyewisjBRJ7gMvGR795A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82MEcIngSeT9jrtr7aihyTgA5JguYhd5oJOzrHCtXMk=;
 b=JGyyRi7NRny8K07JosD5bviH77vioszpd3GTr1LWXMzvKNsnP8w/xNUjPpdOJCYOqKOqZJF0hsJRSxCbereI0uASCD06nmo9yG4zeWc6WeIwPDV2UujQVbLfeqr1NVz+SccBaLrOoYH41XvF6DYMITSxTRiJbzwEy9BtKgqpDdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Thu, 6 Nov 2025 16:27:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 16:27:23 +0000
Message-ID: <adf9b644-d109-485e-8a88-63b2d06c008e@amd.com>
Date: Thu, 6 Nov 2025 21:57:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Refactor sriov xgmi topology filling to
 common code
To: "Aitken, Will" <Will.Aitken@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
References: <20251008133225.1238028-1-will.aitken@amd.com>
 <13375ad8-468d-4995-ab35-7180b36e33e5@amd.com>
 <MW4PR12MB71918A5EFF20C239743AC346F1FAA@MW4PR12MB7191.namprd12.prod.outlook.com>
 <MW4PR12MB71913256030F17C82B6298C2F1C7A@MW4PR12MB7191.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <MW4PR12MB71913256030F17C82B6298C2F1C7A@MW4PR12MB7191.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: ea908d0d-e0f0-4bb4-b42e-08de1d515d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFBGblhDdXU1TDJTSVB1Q1E0cU1ZbHhvTHV5VVdjTEhzRnRBU1JhbEVEYmdX?=
 =?utf-8?B?Vm9ML09qQkpmSURMMzc2OUUwM2trcEExQXkzMEVSb0N5WHJmVXozVEVmK0Z0?=
 =?utf-8?B?NDcrVEhQVHVFeG5Rb0dVK2JEeUJFaW9jNUJmRzRiL1BmVStPWmptbis3U1Ri?=
 =?utf-8?B?MXZzSCtzVHFXL0l6MFJYeDVrcDJJcnl3WGM5UmJ0YnNvYlJuT2lQNndLdUpa?=
 =?utf-8?B?ZHl0U2cycjFlc2ZMd0d3Q1FPSjdGVFZzQ1JKZ3c0Vkx2UnRGT3YxU1FmS0dh?=
 =?utf-8?B?WTJxTE52RWo1czlaZEJkNHI4ZlFjdG5NRm81QzFYK2ZQWlhkQnVlTEc4VEhH?=
 =?utf-8?B?Ni93ZzdxNEhpdU9EZWdXdkxUanhkN3J4VlpZa0I1U0ZTR2JUNWs0Ri9zNUJa?=
 =?utf-8?B?MmZJUFhCcUxzaU00dlhXcHZlaG93MXJhK3dycktrK2Q1b2hJTkV2bHY5Y3Bq?=
 =?utf-8?B?N0tyM1Z2L1ZXOE12cWJHaHRaSVBFVkxxcXFnWjRQVlh2Q0VzNm5ucUVRaG84?=
 =?utf-8?B?NGh5M2docy8rZndpOHhSQjFOdW1BTjBPMC8zMWJaTWszMGQrMk52ZGVrR0pP?=
 =?utf-8?B?Qm1aL1VwaDYzdFI5U0Q2bEUxZ1phUEdNS0x2b0ZiaHRRK2p0cS9iVUJ2Smpl?=
 =?utf-8?B?bzFCTlJMenV1Y2VMR3RFb0thNHNISzJVM01KNkwxY0VOdEdvT3JBeGFESlJD?=
 =?utf-8?B?QUpCNVFwMWZrdjYzeWtPOVZXMHJERmpsYS9tL3V1a25Pdm04SnhPMmRlY2tw?=
 =?utf-8?B?cDViSGg1Z1ZrWktOMndieWowUCtYSUZ1KzZjaTJ0dUNNWlRoWXA3STRtWWZq?=
 =?utf-8?B?emZpWVdxVHdGUG45S2UwWSt2dUp2czVzVk1nRCs3eUVFN1FTQjZGL01HTlFt?=
 =?utf-8?B?VjgxZ0lSaDNwS3JXR0NVcUNIWUpBci8zWlN2UXpEVFc1R1lCRTdIQUMrOWFC?=
 =?utf-8?B?T2tTckNjS05WbG84Y0hubGsrZ3pjazFWR0V5N0Z0NWZpd2hVdWVMRXVWemR1?=
 =?utf-8?B?anZyMVBMeEZ5RnRadUZQeTVYc1pOdjJ0Y1c4a0FNZkVSdXdvbnZKb2VsQ1hp?=
 =?utf-8?B?ZnJnc1BQUTNJUHhNYlkrdkI4eXBDSzRTblp0elB2dDhXSFhCZ201eUtiYnJ2?=
 =?utf-8?B?VEUxRm9xeTVFcUduOE9sbXRIZWlRTWNva3REL3Q2OWgxMHRjYmlKZGs1TjdC?=
 =?utf-8?B?VndTWmJsamV3SS9tSGFibUluc2JMTVJKRnE3R1QxZmcvbGlGWndWbzY4Y21X?=
 =?utf-8?B?cEpQL3prOWpCTHBGSzlqT0RDRXdHbXFVUXNxcDdYTi9sOVUrYjJIODlLNldj?=
 =?utf-8?B?dS9sUUFpT2R6QzdFb3RDUGphbzJiMVU2eGFhaXZ2YW0zWGZNY2o5RTg1dm1D?=
 =?utf-8?B?Sy8vWU9TQ2FKcHZBM0UyQTNBRUdEdzVkNlUrS0NFRFZ5M3dHSzJkeXZyQ3Np?=
 =?utf-8?B?ZWkwYy81RkNlN20wcXdWZS9zVStZMkM2VHdQQ3VzcEJtQU9tMFpMait6aTVr?=
 =?utf-8?B?MnNjWFpNc3JiOFAxazFrek0yRm5YTXNBVXNHZjY4dmtRdlcwMWp0djRoZ1la?=
 =?utf-8?B?amJQSDV6b04zRjB1VUk4S2c1Ly9EOUsxWUpGTUJ2cmFTWWduNUd5Yk1JWVJ5?=
 =?utf-8?B?KzhyWUZSNHUzTmx4a1Z2cFdGVGdUYlVJNEhPTjRjRnJLZS9LUENlUnp5RWha?=
 =?utf-8?B?YUhHOVd5Y01FUFd4enBhc3ExN1kwRUJsR2FtMU5QNFBDQkNWSkZRNnVFUkVY?=
 =?utf-8?B?VDFWTkNtY3hXa2VpSi9FMW1IcS9vNlhWUHVJdVhzdU14NklQblJPYkFZU0p0?=
 =?utf-8?B?UlUybjIycUM5U092ZlY0ODIzWkVlaGl6WDlLUzBZVDNpZWh4ZDhTZEN0UGRw?=
 =?utf-8?B?V0d0Uml4NEdVb1VNdXFOd20vNDd4bnlPOGdocG9YRlFBSXM3WjVIZHc3REhQ?=
 =?utf-8?Q?4UMlQxIlhJOy1sqJHOEvwP/ciS/OTqzx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBueU9ic1VqSmpRaXZrYkUwVVVURWp5eHB0YWYyd2ZLV0xXOFQzZER4SEtp?=
 =?utf-8?B?WHdzN3REM1RGR1hqS2pvZVRYbU9yOHgwUWRvNWs4VzhrN2dkc1YzTlZQaDdC?=
 =?utf-8?B?cCtjUW9wbjUzeGxKU0Z3bXRMaHJ4VWpPUVc0Znk3cnpnR000UjUvbm9wQWFV?=
 =?utf-8?B?MjVMckdta3hseXY0eExmblE2Mm13YlZRNU8rdU9sOE94SWoxOVBURFlRdWFa?=
 =?utf-8?B?SEFSVlNMOEp6S0hDYm5TRjBOL3FxQTlYV2FMRWtHNEMvZnBTV2N4YmpFVHNO?=
 =?utf-8?B?RmZuUVgwTEVWcVA5ZlU2bEtBTC9LS2svS0V0bHBpN016ekVFYWZEK0RMa0Rn?=
 =?utf-8?B?cjVjemdkdGIwS3FsMFQ5UHNOR3NjbkloNEtyYWp4WUJBeUd0SW9iZk5vT3Vi?=
 =?utf-8?B?WjZ0K3RvL0FZaGNkWkZ2bzdZRzYrQURibTdiT1BSQW02Q3B6VWVkbkFqSUVy?=
 =?utf-8?B?TkJWNVNsUEhnWDFLMUlDVVNBVVpHYXpKYStGQzZBUGYveG9qVDlMT2xXa3RH?=
 =?utf-8?B?NGdDOENZejhuVnZGZktHTUY5SFZ4SmVnU0NYclRzWTYyd2YwR3BPYytzK2Zz?=
 =?utf-8?B?WVdwdzhObHdRemlSS0JXTGdBbGR6a3R5VlBvTWl5Q3Q0alcyS1Fjd2NUVkw4?=
 =?utf-8?B?TFNHSTBxS3h2VmJYWGdFUVRCMm8zaVhMb2I4ZU92NUhwN3JYTHFVYnFGMUkx?=
 =?utf-8?B?aFBjdlUxck50dmxjcDV1SmFucCtxNnZ5SEkrSkFUTzFZRUpuT0ppY1FMV3VT?=
 =?utf-8?B?aEtoSFlSaGY5RDZONmhVZUVUdFgwb0VrYVJ1TFU3dkgvSWtzeDZDRUNYUXpO?=
 =?utf-8?B?QlVJZ094R2ZoaG13NFBqekpLRVJ2MnV0T0tkdW1mTFl6RWlmbjVOVGUxa0hm?=
 =?utf-8?B?NEpYTStQRzZQbVRIYXZCaEhUN3BLR01RdnRwcnAva09wWlFjbHVqZ1dNZStJ?=
 =?utf-8?B?VDZJeVdBdFNGbVJiNVlkWHFmWFVRSytDWGJ3K0RETTZrVWorVnlTNTVKRHVO?=
 =?utf-8?B?MGxJREhxaVZmbTBLTC9oYm9CQWVtZGhuWUFEdURmQ3pLTmMxa2ZjRnhTM2pl?=
 =?utf-8?B?VWhLRXpLSWtocStvcUlqbmhyOTJDQTAzMTF6V213cE90R0lTYS92RzgweXox?=
 =?utf-8?B?VXl3Q0NrT0FITVFvOXlUQU8vcU1HZThYUk80TXpXOG9VMm5JR2NMbkxFVXB4?=
 =?utf-8?B?TFpBTWtkMlkxTGFZTEJMZWI1Z3d3eGZ3dHF6MTVsbGNSck9jekxOYm85YXFq?=
 =?utf-8?B?MG81Z285QW1hTFJLWFBXSnN4ZWk0UXhTSmFkMmx6UU9qQXZRK3p2TXZHajZO?=
 =?utf-8?B?d2UyQTFabXdqWGZxUkpXNm4yUld0VURKZTFiL3hnUEhOOUxPSXl0T2VFZWQ4?=
 =?utf-8?B?c25IaHBScmF6d0M0Z3ljMXFUOE9YR2VvbnVOUFA1QmtiSXE2UVRBelZhUmZJ?=
 =?utf-8?B?MGZCNGJERjZha0d3NkYrZzhzalA5azAzL3NTVWREV0JiL0pYMFpyeEd6SU1n?=
 =?utf-8?B?RFFrMGhCK2V4WGo5UlpTN1NhdUJ2eU5CL1hVbXpFSG1TUXU0ZUw3QkhmRGVo?=
 =?utf-8?B?Mm1iMm1nTEJtaTAzNHJpSkRzNndsUzdZRWRuVU9NTDg0L1ZRZyt4L2k5Yjla?=
 =?utf-8?B?U3YxMXlZTVdEdkpDNHBEZkY1Vng2TSs4TmhieVZkWXk4WjJEdkQrbGRzOUVR?=
 =?utf-8?B?REg5MitJMEVIUlhray9PMlExSHBDOVlISnhTZVhmTUtDUUVqV3o5cDdpWVpj?=
 =?utf-8?B?U29DVGszc0tUVU94VzB0amU2YmhucnJkZVVXaG9FbHBKOCtLMnBFTk1DQmls?=
 =?utf-8?B?b3doZC95TDM2ZEcyOURWQ0lIYURtK0dkcFJocDVHVS9HdVBrbFljU1dZcWNk?=
 =?utf-8?B?YUdyNzNzc2RGaDQrTGNMN2xzdkhJRm11MEdRWWhCekRYSkIycVg3VzZTSVJG?=
 =?utf-8?B?SUtzaVd1RmdVTEwwbTlpM0VKR3k0NUlpdXAvdjFmc0w3anNaWjMwa0hjN2FJ?=
 =?utf-8?B?ekZjallyUmRPVXlRbm5YQm5QQlI0MWN2UlM0c0o1bWhZUlR2MVJycWhCbHJu?=
 =?utf-8?B?YmpReE1LT0tmMmlKZUErQWYrUk8vbUhWcFIyTmtsT2NJaTRjS1U0dkJjQ1ds?=
 =?utf-8?Q?mPCbTkeO3eQVYOeK+UD0S+eqc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea908d0d-e0f0-4bb4-b42e-08de1d515d26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:27:23.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAhvS1spdExUlEYjwhGkWjy2Eqd1EwSyYH+kIdO7C9YjVa68MdX3tX2+I4clDrcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

Hi Will/Victor,

Thanks for all the clarifications. As discussed offline, sharing 
disabled scenario can be taken up separately.

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

On 11/4/2025 1:54 AM, Aitken, Will wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo,
> 
> Just ran some tests and yes, I think we should still reflect everything. Even with extended peer link command disabled, if we do not reflect, the table will only be filled beneath the diagonal (e.g. attached). So I think the patch is good as is for that concern.
> 
> Let me know if there's anything else you want me to look into.
> Thanks,
> Will
> -----Original Message-----
> From: Aitken, Will
> Sent: Wednesday, October 29, 2025 9:16 AM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Subject: RE: [PATCH 1/3] drm/amdgpu: Refactor sriov xgmi topology filling to common code
> 
> Hi Lijo,
> 
> Thank for reviewing. Good question. I don't think it's necessary since it wasn't being done before (the equivalent xgmi_fill function was only called if sharing was enabled). I don't think it hurts to do it, but it might be redundant (the port num copying at least would be zeros for the other nodes since it does not receive extended data). Not sure about the is_sharing_enabled. I will run some experiments and add checks to only reflect if necessary.
> 
> Thanks,
> Will
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, October 28, 2025 9:16 AM
> To: Aitken, Will <Will.Aitken@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Aitken, Will <Will.Aitken@amd.com>
> Subject: Re: [PATCH 1/3] drm/amdgpu: Refactor sriov xgmi topology filling to common code
> 
> 
> 
> On 10/8/2025 7:02 PM, will.aitken@amd.com wrote:
>> From: Will Aitken <wiaitken@amd.com>
>>
>> amdgpu_xgmi_fill_topology_info and psp_xgmi_reflect_topology_info
>> perform the same logic of copying topology info of one node to every
>> other node in the hive. Instead of having two functions that purport
>> to do the same thing, this refactoring moves the logic of the fill
>> function to the reflect function and adds reflecting port number info
>> as well for complete functionality.
>>
>> Signed-off-by: Will Aitken <wiaitken@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 19 ++++++++++++-----
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 ------------------------
>>    2 files changed, 14 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 6208a49c9f23..82500ade240d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -1539,6 +1539,7 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
>>        uint64_t src_node_id = psp->adev->gmc.xgmi.node_id;
>>        uint64_t dst_node_id = node_info.node_id;
>>        uint8_t dst_num_hops = node_info.num_hops;
>> +     uint8_t dst_is_sharing_enabled = node_info.is_sharing_enabled;
>>        uint8_t dst_num_links = node_info.num_links;
>>
>>        hive = amdgpu_get_xgmi_hive(psp->adev); @@ -1558,13 +1559,20 @@
>> static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
>>                                continue;
>>
>>                        mirror_top_info->nodes[j].num_hops = dst_num_hops;
>> -                     /*
>> -                      * prevent 0 num_links value re-reflection since reflection
>> +                     mirror_top_info->nodes[j].is_sharing_enabled = dst_is_sharing_enabled;
>> +                     /* prevent 0 num_links value re-reflection since reflection
>>                         * criteria is based on num_hops (direct or indirect).
>> -                      *
>>                         */
>> -                     if (dst_num_links)
>> +                     if (dst_num_links) {
> 
> Patches look fine. One clarification - do you need to fill this information if sharing is disabled?
> 
> Thanks,
> Lijo
> 
>>                                mirror_top_info->nodes[j].num_links = dst_num_links;
>> +                             /* swap src and dst due to frame of reference */
>> +                             for (int k = 0; k < dst_num_links; k++) {
>> +                                     mirror_top_info->nodes[j].port_num[k].src_xgmi_port_num =
>> +                                             node_info.port_num[k].dst_xgmi_port_num;
>> +                                     mirror_top_info->nodes[j].port_num[k].dst_xgmi_port_num =
>> +                                             node_info.port_num[k].src_xgmi_port_num;
>> +                             }
>> +                     }
>>
>>                        break;
>>                }
>> @@ -1639,7 +1647,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
>>                        amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
>>                                IP_VERSION(13, 0, 6) ||
>>                        amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
>> -                             IP_VERSION(13, 0, 14);
>> +                             IP_VERSION(13, 0, 14) ||
>> +                     amdgpu_sriov_vf(psp->adev);
>>                bool ta_port_num_support = amdgpu_sriov_vf(psp->adev) ? 0 :
>>                                psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index 1ede308a7c67..2e70b84a8c3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -958,28 +958,6 @@ static int amdgpu_xgmi_initialize_hive_get_data_partition(struct amdgpu_hive_inf
>>        return 0;
>>    }
>>
>> -static void amdgpu_xgmi_fill_topology_info(struct amdgpu_device *adev,
>> -     struct amdgpu_device *peer_adev)
>> -{
>> -     struct psp_xgmi_topology_info *top_info = &adev->psp.xgmi_context.top_info;
>> -     struct psp_xgmi_topology_info *peer_info = &peer_adev->psp.xgmi_context.top_info;
>> -
>> -     for (int i = 0; i < peer_info->num_nodes; i++) {
>> -             if (peer_info->nodes[i].node_id == adev->gmc.xgmi.node_id) {
>> -                     for (int j = 0; j < top_info->num_nodes; j++) {
>> -                             if (top_info->nodes[j].node_id == peer_adev->gmc.xgmi.node_id) {
>> -                                     peer_info->nodes[i].num_hops = top_info->nodes[j].num_hops;
>> -                                     peer_info->nodes[i].is_sharing_enabled =
>> -                                                     top_info->nodes[j].is_sharing_enabled;
>> -                                     peer_info->nodes[i].num_links =
>> -                                                     top_info->nodes[j].num_links;
>> -                                     return;
>> -                             }
>> -                     }
>> -             }
>> -     }
>> -}
>> -
>>    int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    {
>>        struct psp_xgmi_topology_info *top_info; @@ -1065,11 +1043,6 @@ int
>> amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>                                /* To do: continue with some node failed or disable the whole hive*/
>>                                goto exit_unlock;
>>                        }
>> -
>> -                     /* fill the topology info for peers instead of getting from PSP */
>> -                     list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>> -                             amdgpu_xgmi_fill_topology_info(adev, tmp_adev);
>> -                     }
>>                } else {
>>                        /* get latest topology info for each device from psp */
>>                        list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
>> {
> 

