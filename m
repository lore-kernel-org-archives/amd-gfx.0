Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FC0C83F1D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 03:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2651910E1D8;
	Mon, 14 Jul 2025 03:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BWHt4PO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7A610E1D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 03:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU7vG2tkH//TbdBm3Tv54DDPhm+gjnRto9EIUGAgA2Pb70wROWMEYCY+hi0WFmVuMjiQTh1U4HqjOsxOVY5+C8hztkALVHncUnzbk03Ia9VKOViEeGCSo8CGvLAuM4m7+fMrYzlISx9zq1FRWU02dHdQeXB6R8stleTS7C3nkhRyOGLvHs4kdjQJbVOZvw+mh1lVSevDk0OHQJ5VQMpvLhNLuqZVt/AN7wtJpljl+3o31GcydqRS2n7a+l/yeEcvCJT32N4hKjN2ApHebCXFaj+rSatqtQSUZ+XX1sanHYDlBItQqgQv8bAZJBs+axit7+Is/0qLMcWmTU++Dw6YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH0+T9lWDhhcdKV+hjUs/FWpY9EetbYhLHoeWoSoexo=;
 b=bNIshIiZUyWkH5Syn235sO2tSVBiJSxR/pFhgbl2IgqpiPAkoCG7UbLrMJvYuvbCjj2vK2XAQJRVR6v+zgOGFSGPZbZaBp7XGZ1ehuqQqCxMTX+EADVuwa9nCQSZ1Os6lgLTTi78ak3fqxUv7Nd/EogS2EZuAmPSK7IyH05r2myEhW/9W3Uw3UIHj+qyxPxbibPeeWXNN18SE3GGQ+GIqQWoeMcoEeBYL4noOsv3iF7bs6LMnBcTrtKH6O1QByKrfkvUpdimuPr4iNj/vypWpa/n9etVqoQ9yFOpudHU2qtXaFZDzoycvWIx4/rGMKSlxoH1tlDM5Bzt3egk95VXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH0+T9lWDhhcdKV+hjUs/FWpY9EetbYhLHoeWoSoexo=;
 b=1BWHt4PO3bz6p8m+uRv8n+WWuDJ0FS4O/iIoqZNX/lD4cXCMJVuHFGqsVgHG2dv4vf7xLuPvdD7hoKzZ7FGc9TVoGMH6AhGjicTL0uqOFpbJecvmxp+DeytXMjtw/2MzmaBnX+5CLMU7ClEEY+GGXZSFRm78GlClOLa5EpjnpGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 03:02:09 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 03:02:09 +0000
Message-ID: <8f974ec3-8e75-8285-7166-05772eed352c@amd.com>
Date: Mon, 14 Jul 2025 08:32:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 04/33] drm/amdgpu/jpeg4: add additional ring reset error
 checking
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-5-alexander.deucher@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250711224024.410506-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: af0b3435-2877-4930-5a9f-08ddc282d268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFJ2RUt1dzZJMG9CaHZreGoreU5WK2grdmNYS3JZQmlRTjVERjFpMHFZeklE?=
 =?utf-8?B?bC8wdzNCd1VxeXRkc2ZqOVdjVXFWWGxMUXZPY1V3Q3l3S0pOYkY3N2ptaTBR?=
 =?utf-8?B?a0FaY05tTlBnSkp5YnBKVFUvM0ovMC9IeXMvK2NMcDBlWUliTFo1WHlYTE03?=
 =?utf-8?B?QnhQUkh0Z3I4UnpyaWRRSFhjNzVZVHRyYlYwQWlienBZbHhTaTJHVUJISi9t?=
 =?utf-8?B?RmdZMEx3a1NUMjFkaEtNUjd2TitHZnd3R0NlZS9uWXNEZnAwUmVscFo3L2lp?=
 =?utf-8?B?S2RpYVhvREllZFFTTHpYS2VvV3VvNU9SU3BXZFByV2xnNWx2UjNqR3dwdDhT?=
 =?utf-8?B?WWtpUGFXSVhzNUU2VlN4NGRlcDhZZ3U2aWdVT1hKZEhDK1dicjU4eG1zbU0y?=
 =?utf-8?B?b1BHWW5RZTZEZjhvTGZMeEUybitFOFdyc2I1bXV6UnFzNjhYSkZkT2RTaWVZ?=
 =?utf-8?B?Mi95cGk2Zzltd0w5azBBYTlPOXBuQ3R0c1Q0Zk5KNkdZUkRsbVpOam5rZENB?=
 =?utf-8?B?ZmpzeElJL28wZXRabXBIdDVXSndBSi82bmxmOWVMZGFXMGdMZ1lYR1lLZnVy?=
 =?utf-8?B?M0E5YXpTczNCZWxGUUdIVUJJK0xsV25XekZocnh2a09FeXdiOGEzaVhlYkN1?=
 =?utf-8?B?Yk1sRW9WVXI1dE4wM3VrcDhjNGVZMzU0SzlnemVwN2pPbzNxcWsxUDhSNzRx?=
 =?utf-8?B?eUd3VFNkR2VOeFdWRWxldVdGMkdnRnlBQXVIalMvRytSY21VV1Y1RURCdjRZ?=
 =?utf-8?B?ZWQxVTdKa0xGK3lMZWFRMjRRdElBOUt3bHRhWE1yWHZ3QkNoMk5tMWVDNmln?=
 =?utf-8?B?UkVpa0NOb3NHbWdRTDQrRjgrRjNNRUJvczU2TGdYckU4RENGQUo2aWRNcmxO?=
 =?utf-8?B?dm1QTkd2d0VkUWxNcGpQd3JGR3NmNG94ZTZ6K0JmU2xXRWg3cUJEVTBibVhB?=
 =?utf-8?B?bi96WFVVZVVnS0s2WEthQjZCTE1ObSs0L2o2ZHFDQktieWNiUVMvMzcwQjBv?=
 =?utf-8?B?N1hQMlZzNU9KUHE2YWFXTHdFRmpMZDh3TXYxV1ZYUjhvUW4zT21RNzZzYm4x?=
 =?utf-8?B?QVRNZ0VaUytXUEhueVRvdHM5ZDFOd3RJSGlLSjNRL3ppTXk0MEZEdUNCK3VF?=
 =?utf-8?B?bFdNRExmMG9xelRndDZrM3ZQZGkzTVl1eGVjQ25KN2ZFSHRqUldDcS9uQjNl?=
 =?utf-8?B?ZnYyYStLMDcxZkZERmJvUlNYeEJwWElMV2R6dytGWGl4NGFVdng0dTd2L25Z?=
 =?utf-8?B?ZHAxNUcvK0Z6K2NBU3dhN0tHcW5YaEk0T2ZrZEszS3I0MWFOTTExQVRHdVRR?=
 =?utf-8?B?TG8rNmhNZDVoajFqK1dTZUoyMURzZWloSjFiZ0d3SWQybUIwOUV0dWdMU21H?=
 =?utf-8?B?ajdXdHVmME1Xb0xib1VTa0F4R2F3dWtleEhSSXdTSGRaMlNiUTF1ZC9Xa1pC?=
 =?utf-8?B?V1hxWDFoQ1lOa2pLa05hUVh0T0UyaWszVEZpOGczb09QRVcycEpTOGlvdlJa?=
 =?utf-8?B?TVBkZ0xhUHczK2lrVldpeGdwQmdrNmVtcVBFQWJ1Vnl4cDZ2TE5sc0o2aVNZ?=
 =?utf-8?B?TUJGMTdBUnBpY0psMmpzUXV4N3BFTXRGVG1acU5QeXZEd3crTVhxaVRYeEEr?=
 =?utf-8?B?TzREMGRzdUNzcCtBZWtkYUNNN0h0NDBBdldpcWVKNnNmeEw3UTByOTByR0JK?=
 =?utf-8?B?Z1NZS043MnloZTJBVWJ6eWx5WW9CVkFlNUZ1emt0VWt0ajJoUVlCaHlTaUtJ?=
 =?utf-8?B?cndseERCcXFnZVJjMHl1T0lRSnM5ZXUyM2ZqZ0RWc0czeTFNc2dJYmtVa1l5?=
 =?utf-8?B?YVZ6ZGJ0cHVUcFk0Y3NSeU1SZVV0Zm1ERXhnSHFncGRENHF0TVAwOGk2VDFn?=
 =?utf-8?B?YWx4QkNGbVlQczdzbWV3SmFFejJMbzh0SmxvamdSY2FMRmdmcmcxazJ3QzVh?=
 =?utf-8?Q?EfGgFz8Sz50=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStkUjhDVWc0QVExNURYSG9nb1dYTWpUZk9md05TWE16UkZMdlBXNXBwWkhO?=
 =?utf-8?B?bVNEODRWaThzY01SdnNxS0ZYendTcFI2aUFPblRneDlPY2tQdVp2S3R5eG4y?=
 =?utf-8?B?L1lCUHRPOUthNWU3V3RFcm53RDVxVnhRVzJsVHcybjVPVi9nUFVSL3BLcndx?=
 =?utf-8?B?OVJXWDZ3UEcxYWJpZGY3N3lKUlE2M085S2Q3S0l2QnlzbXczS29zckJ6UjZx?=
 =?utf-8?B?TDY0T3RBdXBzc0d5MDBjaE92WWMzZTlaOHpZMWNDbVBWT3JZbmtGdTVZc08y?=
 =?utf-8?B?VUNuRDI5dDdnSFNKa3BBY3FXZWpMQStGcWROSUM5c3Evc1dCNU1wK3RpQTlr?=
 =?utf-8?B?RXpKTFNmaHVSakN2QVBlajE4UUhoL2NHcVhTRzN0OGFCNlVaNGd4WlJSdUdm?=
 =?utf-8?B?bXkxSnV4QjdlSWZwY1ZTR1pCZ3F5MUJwSjhhNWZDWnVwU2lJZ01CUlozSEJM?=
 =?utf-8?B?bjcwa0w3NGRuVlk4MFRjcGJ0dVFGeDhFc2pDdnFlZmFCY04rUWhUZWZTa3FK?=
 =?utf-8?B?NUM0TGVOZHZjUlB6VVdLUTVDdngzVnlTUE4veC9WejA1N1JESllSV000UHpP?=
 =?utf-8?B?bnVDbWg1VlYxbnRIaE1ic3J5bEFBZXVXNG5BTFNjRkwzY2pCMnJHTG1KSnNR?=
 =?utf-8?B?NVgrQmh4TmEvSDNoM1lHTk9WUzJVMEN5ZzhqeE1PdGFhTVVNM0JOZmFNeEk1?=
 =?utf-8?B?SjdKZUNVQ2pqY0xaMURxVmdwWFI3KzJtY3dSOEFnTzZXT0l5dGRQWHRWWTcy?=
 =?utf-8?B?cytEVDB4blFoeGl2OFJqc0YwTUdFc3RpQVJsSnQxb2NQSEh0dHQ4UzdHWmps?=
 =?utf-8?B?Q1MzakZPUkwyY3NKTEhUVjJJMmxJOFZheG9Scm9hdkhFUmxZUkZiMmhRcENK?=
 =?utf-8?B?YnFmQTVVN1MxTmRsbnRVNjNjbjdQN0FEbkhFWlptL2NiczFuSFhUZnRPWlhY?=
 =?utf-8?B?cFlEZXBqQ2w3MXVWM0hDRllURFBRQ1F6SkdLaUtTbDAvTmlzSVcxWnNROWVz?=
 =?utf-8?B?d2NiYzAwUThjanZiMDRxRmFtQm1TOXNEU3VhWm9hZGsva2VsL1E3b1dtU0s4?=
 =?utf-8?B?SmVaamxUMzU4Yi9EUm01T2FmQTh3S29sSWZoV0h6ZEl5elBHdEY1cW96bW1q?=
 =?utf-8?B?OWJaaXh5cFgvUm5xOElOampBSTk2dkpGMEV4NUZJd2VPckdYOW5JczV4eGVF?=
 =?utf-8?B?L2o1UUc4Z05acFBYSlNkQXBvcEJSQjZ6TTBZYXJxZWV5RXpSV0swQ0FnTm5R?=
 =?utf-8?B?dS9zMmNsZXBmNWpjQmR6VGlWK0o0bmU1Y3JpbU0zTzNVTFpjQk5HVFQ3MzhJ?=
 =?utf-8?B?QmFubW41QUtNMnBlL0wvZG1PUFJ6WXJzRjk5ZTFjc3MwelRrdmtqT3RtM2gr?=
 =?utf-8?B?S2ZLTWJSdjJkMGJSK1BwTkNlenIrNVNJa1ZTMGY0eHJkbFJUZzJjYjhUVWM2?=
 =?utf-8?B?NjJNcjdrVEZkNU1MMyt1N2twWXVlaTluSmtscFZyYWFzODd1bTdJbVhwOWZY?=
 =?utf-8?B?cmZKL29jeVI2bU9Sc2dHWTNKMzlnYUhCUFpzRnFTc05FSElmelFLYnJpWUNk?=
 =?utf-8?B?aVd2VDJQVXdETnh1UGwxY2xjc2NVbFBSbkdmN0dYak92U0JPeDBYTzZwakQ1?=
 =?utf-8?B?UGRybUtKdEZNUU9mM1ZrdFhES2lueEhPYXdiM2lrOTBiN3cyem9pNjNmQUNl?=
 =?utf-8?B?cmJ0SnljeTFuRE56WDIwRVB2N3B0SWVIQnRFaWlYRzFYeTcrWGFYdS9sMkM2?=
 =?utf-8?B?ZlVSNmdGSlNqUGw0TGI2dDlhQy9hamNnTWJqY0l5dWcxaGFSYmFsQWMySjBO?=
 =?utf-8?B?U3ZHOXF4OTVsdjRpcDFFZkUwZnVzdTl0ZEV3YzQwbHhGOGdBWmFWTWZuQ2ZH?=
 =?utf-8?B?VEZoSitDTHZucmtmV0U0elNXYUw1Q29CdnBkcmR2a2NIdWZaSFRLQzRVYUpt?=
 =?utf-8?B?c2RuRllqWGVIREIwLy9DT2JvMnlPWS9zQnMrczc2WUJoQ3NQRXREK1ZsWFQx?=
 =?utf-8?B?Mjg2cHAvTjRJdzhhZ3V0aHlOMU5xTzVhTXNNQzVIVEVDYzVFRGJJODFmdXBV?=
 =?utf-8?B?TGRxVlZIRDJKTWRnTW1hQXJwaHNCWW1qeVBqSmdSenFoaTY1S3hhTm8wS3pv?=
 =?utf-8?Q?GEWbXaQPSjeC/Td2k2kAXxZfB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0b3435-2877-4930-5a9f-08ddc282d268
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 03:02:09.1520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWk1T6FdKkpOmLfhFYa8i6FEruwuweHBV7yVuo2bIAErgHAlNddK1KO+YlN6fEuHvMNkDqg7ztPpBsoODE/Oug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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


This patch is :-
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

On 7/12/2025 4:09 AM, Alex Deucher wrote:
> Start and stop can fail, so add checks.
>
> Fixes: 74894ffc7d0c ("drm/amdgpu: Add ring reset callback for JPEG4_0_0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 1d4edd77837d0..78fe1924f3cb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -730,8 +730,12 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>   		return -EINVAL;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
> -	jpeg_v4_0_stop(ring->adev);
> -	jpeg_v4_0_start(ring->adev);
> +	r = jpeg_v4_0_stop(ring->adev);
> +	if (r)
> +		return r;
> +	r = jpeg_v4_0_start(ring->adev);
> +	if (r)
> +		return r;
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
>   		return r;
