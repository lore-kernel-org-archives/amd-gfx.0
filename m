Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B69CD6A221
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 19:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD48E10E35D;
	Thu, 14 Nov 2024 19:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o7RuT67v";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A69610E35D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 19:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDcSNKF7jGzE4kzc5fPsQYyzHxit3YShnykXWZMkf7d4kIgd38KdgoL6gK7aYtO/ZHGycrJyftJK7vOyMpQXSmXXoq+/nJVA2vI78PnLuI53rxPtdPtJbadVphovyOns/psTE87e4MWv6rmL3P9MOCIaWFN8z/oRiwd5Q+Omt23Tg2Ob7Hy6+WuhYqs7HT6JbPBKtrJau7ML2CNANUmmqN3mEAU8Dc8eQfe9Bo1CYYO0W882jP5JUgKL4PntlYOEyz8JLgElOTgBVsR1LpJSYsRxoPIvTwFfYsl1CjoEXuHqZ81ScTk9IdQ4LEi21QYBHzBS8aZHUQr3Q3+RoTWvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiVApElk8XxZaSCcPj5/5UpAxBGuktix9jo/CvTzZYQ=;
 b=IHuopHA/ClwdtrKIYom6VxpZBo+i6CvTVR59F8VYf2pRtdbwuWauGnGYnBLWBMsRBw4DAWRSkR6nAjKnM00c3SbKxzttKUVvevcfaiBERXx+WFOZFrGQbmEWsYtq1ZW5sKqNzXdFDPrPQBM7/e87bh8iws2ZxKg7PWeacy/MRkxFu81/scroeHTTt6KH7x8AeRfN44CcsbVLS8AI/UykJiC8Q2b+L0Mn3LU0zvv8aRElwPR5mMG7dSXf/3ZjAMb9SjJjxjO1ab2mr1IMhBnq8kWQnhCJ2pZ+didAKBypLRqxBdeDqvenKh5IEVTB39q6IAVPVnXALqfvDEUK36RFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiVApElk8XxZaSCcPj5/5UpAxBGuktix9jo/CvTzZYQ=;
 b=o7RuT67vALlOZcBlDRrRVzqHniPvrI7Y7e9YBHSfqpH0z1vs62avTU1LUMdFpTZjyjxccFieodN8j8fDMWq85F3AZjLTxVkllehlyyu/dVPie/sZ97a0Dv54Dkjh1PODqMRZNdQaKMZXSE0Yuc3WDA9RUgyexntdPdJ/QUD9JLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 19:04:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 19:04:11 +0000
Message-ID: <61209a80-9796-42db-8d3d-0b5de317c338@amd.com>
Date: Thu, 14 Nov 2024 13:04:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
To: Zaeem Mohamed <zaeem.mohamed@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Melissa Wen <mwen@igalia.com>
References: <20241114143741.627128-1-zaeem.mohamed@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241114143741.627128-1-zaeem.mohamed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a635a8-d962-4c0c-5b1a-08dd04df1faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODdzc2RIczJTL0IraFNxQVIrWUc1U0Y4SEUyNTJOZzZNSVJlbklHclFobGIx?=
 =?utf-8?B?L2JzNlBBYVFrL2JjY3Y1Y1RnK2p1V3JhNlR0eTdvZGRlODhXK2ZETWY0Uzdw?=
 =?utf-8?B?d3pDam5LaVFUbDdtcUg5V056RFk5ci9BK2ZGY2Z1UXo0cTlraWdicDFYcEM0?=
 =?utf-8?B?TkQ5QWd3bUVYaU9DR1BUOGpOd0wzZGk4Mmk0S3FhRDFLRXlKU0FUQ1dCS0lM?=
 =?utf-8?B?c21vY2I3TTJvMUxlRjlIeWNNbC8rTDdDbmNZZzdLSkl4ckVWQW5XY2M3QUN6?=
 =?utf-8?B?MkI4dE1kcXRZWE1PNlVFWisrMUhNMzFiVXhzK2xmTkpmWHdBMEpZVlpGRmdy?=
 =?utf-8?B?bkRmWUtlVm1WcG15NUpyMFovUHFFR3RqN21SRnNvL2JUa29DWjgvSWVkNHdF?=
 =?utf-8?B?Um9JOHBURFR1R1ErWm1JeDJIT1ZHeW0yRjNIczM4dDdvMW9aRy90Q1h2cTE3?=
 =?utf-8?B?RG9aQmV3UFd3S25wS09rd0hlYTBkeEtrS2xKeUUrcG5tZ2krVnlSTGRkY0cr?=
 =?utf-8?B?T2E5dTdnYlV3YVJrUUhveXl5VG00dmozOVpQUUdyTFd1VHNVM3BkUmFnMTFa?=
 =?utf-8?B?UHZjZEYrekc2YVpZakJUMlZkSFZIQVpwZmJOUEQ3RW5KaWZSa1ltUEUyWHVK?=
 =?utf-8?B?QzMxaDlXY2trZUkva2NyM01qdG5aYURET3VTRlIwMUNRbFUrSUZoNzM0Q3Jr?=
 =?utf-8?B?eEdEUTd0a2JOblFMTHBVOVZENWthR0RibnlYUXNQVStrdVJ5ZjJPaDl4eUY1?=
 =?utf-8?B?cEcyMjBOVGJqRTFZUkNSQWF2cEdkak1rL3NVdWJ5YlNkMXkvYmh6NklnekJQ?=
 =?utf-8?B?K08yejBPWDRNRStMSzRlZjN6UFdFS3ZmbTVIanJ3Y09KajVlMHhGRnJwZFF0?=
 =?utf-8?B?L09Xa1drdlZKK3BIeGpyTU9WVlNNZDVaajBjMVZqNGE2TWdEcnkwUkJadjZX?=
 =?utf-8?B?YWd4SWxmTE55dDZsQi9oNVNjcHArRmZZay9UZVQrR09CVGFydEJkYzE3NmNR?=
 =?utf-8?B?a2d6b0ZsMGZ5V2ttN3RjR21LUTA4NUdnbC9xektJbnhabDN1aEp6cHdzOEVN?=
 =?utf-8?B?bmVFR3RDbkNpU1NsaFd3Q3pSdzFBM1pKZkJDanBpZFQvcnFYanhzWlFpZ053?=
 =?utf-8?B?ZUpTclZpSWs4dHBXa1JxdkI0TTZYc2VRNDJ3b05KR2p1SnlRZk01TUQvRTFG?=
 =?utf-8?B?bVZtNVdncjc2dTlrNXM5K0t1eWNQS3l1T0xYNUhYSkRYNDdDVEg2MXMyOWln?=
 =?utf-8?B?Yjl6NUN4ekhUb0FYQjVIMm9IVFBHNHJJT09zVmZ6a2JiZGhmTlozNFoyS00w?=
 =?utf-8?B?aWtxNE5wanlaZzdDMVBHK1NKRTE5eWFWRG15T2tNOXZZa1lPVkRiajBlMUpi?=
 =?utf-8?B?aisxZUJpRnlOaGl4K3lta2xKNnc1ODBMQW1qZU45anE1UGRCTjFxaTVDSGZr?=
 =?utf-8?B?ZDZNRU5mRGJYN2J6NGFXaFYvSGtSZDBKa1owOUJ3Q25BUEFsY2E3MGdodmJB?=
 =?utf-8?B?L0dhaTFabFVVQWFnNWw3NDAyOUlxdjNXQUdKUnBVNUdoUk4rc3VDck1LUUxt?=
 =?utf-8?B?RmVDRG9lKytqODNKVXIxUXpNQ0N6OXRMSVBWUWRWblBLRkJYaHF2OHpaZHNS?=
 =?utf-8?B?NmVZdTg3TVJoWnRMN0ZwRDBpQlBOQVNyZFFlVVhvWld2WHQyT1JJTWtGdVFk?=
 =?utf-8?B?bWNQVVVNV2pLMUZjTUg5NHRTVTBOaGMzS01kUDNxRGtUNFUzR3h4OTJDOXpa?=
 =?utf-8?Q?PFllCSZcvoBw7PE/dJLVeujI6szuAvceLaHUSfo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdhQTRUOWV5Q0hSMHc0QWVLelJkR1JuZys0RUlSRDZIeUM2SitYd0NPak4v?=
 =?utf-8?B?NFl0akRxQyt5bytnRmxlSmM5NTlnWU5OKzF4Wm1ROWFyREh6Tm9Rd05oTXVa?=
 =?utf-8?B?VU1SZE5aYjhJa05UQmM5bnprVlBYc0pEdkxyUmtlUEdxK1BYdEczbGdPRUl5?=
 =?utf-8?B?YUtmdEttYkk4dXRHZUIvWkxZOVhBTFZpOVRMTmJnbDB2QytOOVh3ODRnOWd2?=
 =?utf-8?B?eWxjS2U0SXB4VUFMdnZZOTg0Vng3ZUV4ZllpR1hPdUJRekFBRWFBSC81ZW9J?=
 =?utf-8?B?NHJKQnc3YlFRRjJ1dllqUGY0NE56NXZOa3Y4eDZZZHByTnkwV0xsTWh4TW1R?=
 =?utf-8?B?SEVSSkU1VWpUTEZNbGhMUWp6UVRPSlVUL09JODA3UWlXZGIwUXVyTE9FSkJx?=
 =?utf-8?B?N293QVN4aWQrYTQybno3dTNsZXNSQ2lZVTYvYWMxekpmU1RHZDArQTJsZENj?=
 =?utf-8?B?NnYyWHg4K1VMMW1IR3FvVGVkMFZ4ZUEySlhoSXJUK3I4bk9uR2ljcXhXYTZw?=
 =?utf-8?B?MmtXak1uNzNnb21sSHhuTkV5aVRoVDV6bzNRYjd5S1EvZG0wc1hhU2JWcDBT?=
 =?utf-8?B?ejFLT2o0YUJpK0NQUXE1bkg5cGx6M1ZyV1VJTGVTUVg1azQvN0xBd3MzUjdR?=
 =?utf-8?B?VHVTdVcxZ0lmbjJpSXRiZHZ1QXRwWCs2Zzc0c2ZBaHZ6YVR2LzJNU2phb3di?=
 =?utf-8?B?WDd6ZXBtc0tuZU1ER01wMllQRFBMTjN4MHRkb2VmV1RURjZHTjBuc2lNc0hQ?=
 =?utf-8?B?U0FsWWxDUks3Q2dldnJCV085blQyVVd4dkJxZkRKS3RqK3ovSHY0S0dvUHZm?=
 =?utf-8?B?OFIxc3BCb2NYY1Ixd21vMXJtekdTbVlNVjJTWkg1QkJLd1VZTEovOXVVcXRX?=
 =?utf-8?B?VTk2SEpGTVdIMjd4My9ndWl3V0lYcDFZdUwxVllVSE5zQUl4VW5wZDJXSEJM?=
 =?utf-8?B?YmJxN1lkWU9ocHQyUndUc25DTmRwM2Z5aTc1cUt0MHBvSUdjVVh2d0NoVlFR?=
 =?utf-8?B?L0UxWFB5V0VSM2tUK01SMjkxbU1pbHZEWG0xTHQxaGhZdk9La1Jlb0UrdjZB?=
 =?utf-8?B?WFVXcDlyMm9JQW9SY1NHM1gyZTdJZjFaZXplNTZTQlJuS2EwMXhZNDN1ajA0?=
 =?utf-8?B?M25HZEIyc05idjRDL2RDQkdPWCtKVnpueEhtK1hPL05hMmozN2pyL0ExbVJ1?=
 =?utf-8?B?M1VyalBRbGhaa2ZIc1RjNW55d2s4OUVLWEZkdkU0eVlnbTQ4bGFjNUR5MUxO?=
 =?utf-8?B?Z3NHWFJXdHZKZ2pDdnNoSTROWmtxL2J5MFBZdTBXY3ZTWHJSQmYzZzA2WWI0?=
 =?utf-8?B?MkRYWllXMC9ETWFUK0JLcGpJRklYRVJza3lIWUdCanc5a2NrNDFRRUsyL1BK?=
 =?utf-8?B?SXJQSDVIdXh6NGU1TW1IQjkzZ3p6S25QdUl0Vy9SdnpzdytLVCtMeVFOYlFX?=
 =?utf-8?B?blpkZ3hqSWdJdHZRSDU1MWdJRUU2UGxwOFpEdnN6RjQrelMxcGFJVFVqcGxU?=
 =?utf-8?B?b05XaGlRanJtTHA2SXlmRXBCbUFLQ01Nek56aWdDYkNxTW53TWhuS25SMk05?=
 =?utf-8?B?ZW5Hd1lpb3FMODdBdE1wMDBsOXdUbTI1bzN2YUxZK3ppTTlZeXJCMElYcE9N?=
 =?utf-8?B?ajAzUEdpOUZFSit3WmRGS3N3SnIxSU55M2MxQ3krR1JHMEVuaEpya2ZNbDRp?=
 =?utf-8?B?NkNhUmRBb3dVNHFuWWxRNVIyUUlEOTBpYncwTDN3cVd5WUdSZm5mL2JUR1dO?=
 =?utf-8?B?NVNVeHNSMVJORkVPckFhZGxtdEN0ZnRrVXREOXl0RWFMM1JOL2RBN2ZGRmJJ?=
 =?utf-8?B?TnFEQkFiTDk5SHdLUGNjTzYyamtQV2JnYXhxd2lyckhBd2lhUDRMRkhUemNW?=
 =?utf-8?B?NEUvbHNOamkyZUtRVUZvQzhiOXQ1eTlmclZmKzRRVGpyRFZDaU1GWmg5N1lI?=
 =?utf-8?B?K0ZpMVN6dEpIc3llWHZ6d3BTdWRPdVkrUnI1LzJrbW14S0dXcEErSGw5c0FY?=
 =?utf-8?B?WExOQXptcFVwOTVIT2lrUFJtWVAyM083b0pCczNFdUFjN0ljZFZHMzBPMERO?=
 =?utf-8?B?VkxOMk5nT1RaVTJ5d05oV3dsQlEvYnVYdGYrVjY1dVFQaXN1S1hYLzRDc09m?=
 =?utf-8?Q?lhXWRvc9L8AyfXIOm1GfBzaWc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a635a8-d962-4c0c-5b1a-08dd04df1faa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:04:11.4825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/mu3qyKuElwFVm4ZgqmSiyFWO2eox+CZbFQUiyxTsszcPH5k0lmRb0jZnhjUoz+yLIQvl1cUNEzCA1LxQZZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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

Although it's really useful information for AMD people, the Jira 
shouldn't be in the "title" of the commit message.

"If" we want to get into the habit of including this information for 
display code we should come up with a prescriptive field that goes into 
the commit message during promotion and it should be part of all patches 
in the promotion that have it.

Something like this:

AMD-Jira: SWDEV-476969

Probably need to align that with other stakeholders though before 
starting that way.

On 11/14/2024 08:37, Zaeem Mohamed wrote:
> [why]
> Prevent index-out-of-bounds due to requiring cursor overlay when
> plane_count is MAX_SURFACES.
> 
> [how]
> Bounds check on plane_count when requiring overlay cursor.
> 

Any link to failing bugs or anything like that you can include?

> Co-developed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>

You're missing Melisaa's SoB for a co-developed patch.
IIRC this should fail checkpatch.

> ---
>   amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c
> index 97e0a1bbba..964497c613 100644
> --- a/amdgpu_dm/amdgpu_dm.c
> +++ b/amdgpu_dm/amdgpu_dm.c
> @@ -11821,8 +11821,16 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   		/* Overlay cusor not subject to native cursor restrictions */
>   		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> -		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
> +		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
> +			if (dc->current_state->stream_status->plane_count > MAX_SURFACES) {
> +				drm_dbg_driver(crtc->dev,
> +				       "Can't enable cursor plane with %d planes\n", MAX_SURFACES);
> +				ret = -EINVAL;
> +				goto fail;
> +			}
> +
>   			continue;
> +		}
>   
>   		/* Check if rotation or scaling is enabled on DCN401 */
>   		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&

