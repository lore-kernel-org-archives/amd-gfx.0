Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A31D3E79A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 07:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AB110E766;
	Thu, 11 Dec 2025 07:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hhO1Tj+a";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403C710E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 07:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUpOF6sks4d9BSbBirnIGD7lC8u6y4xOPkzyqI+QeVcAvcrCY4tu8WJm9tPeUidQ87nGSWKjwPv6f/kCV4jpVoo9ryLosdibCUFzZE6JY+zJBceMBngC4nWRnTnVaE2yRQurgVLYScBX0OdzYIS+kNQom9xOiS+6lpp0D5yFONxFfuy0pwbBCuuGGNaJNZErmFo/YA4738WGnIvz2o5ZXOB2AIggOqFgBAhOpVC3xS9Ra3XbAXEqEN5rPn2aYNMv0nn3JwMcC7szUV8tbaHZB+Z9IhD25uj1BRGqM4yTUfaxbWVW39dSU/kbvaZ4y89oUTsK3WFgXBkGUGyaXGLHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM3ok0iZTHuJRRD3mhvntU/2znsP6RBQINvrUCpqiUo=;
 b=rLzyZBUWKqBW4DmZdze56JNHtmTKAHFdxZYVx5FZouD0MDxgapR9J7riSdvLyQWaXmVoWeLT3MFdkLkHwpbMyKLnBE72OsVKndo8iuv554HFXvDaD7PPLYsl0Xnue21AtXpoRNIAgfuVyjEG7BgJ7JlGBJvId7Wm8Y1aWpkFr5ixDXNtQFQXsFl7gF5EGO9MGTj8ydaNx4EfHlmV2S/StEB9NW/+cMatOL8CQ32Db4Utrw8B9ZseEp4Ynt0mmvQRct4AYJsMjDhgRK4thTNc7wZ0Q7utoNzzBcUAwq/IZrUC2XQOL3SIMh6pQm+YwC9IiVvtL6ZbXf9XoOkiVBjikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM3ok0iZTHuJRRD3mhvntU/2znsP6RBQINvrUCpqiUo=;
 b=hhO1Tj+aWVVJ2+GcI4lOGNwc0QNDlicWwGuKzWkL543K51eJyHyhhS0bP3dJKHCmIVuSIDon2Xiat8Ccoov263d+7OEfOHiS1lyjMGlIxx2Pm34zMPn5CpaOe1w29nIaV9R3x0HnSXrZXAwjeG30BOsxjVo2r4VnYyNofmNB/CI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 07:46:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:46:43 +0000
Message-ID: <dde64384-e87d-47d2-bec3-5f096540d2ff@amd.com>
Date: Thu, 11 Dec 2025 13:16:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: add smu pcie dpm cap & width convert
 helper
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251211051555.652129-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251211051555.652129-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e831ee-2534-434f-f727-08de38896d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2wwMDNhUHg2cVoxNXRLU0NBYm5oMnJKc08rQ1lBWWh1U1p4UytjVkQwZ3do?=
 =?utf-8?B?a1g3cTc0N0t3T1pNeUQzRU9RQnR1U2dwV0g5d1l4YmdpWHh3WUNqN21QZk1X?=
 =?utf-8?B?ekJENVhlbTcrSzAvVWpZWVhUNnZ1RG9lbnhVWVYzUmtkMGJLM0oxRXFNU3ov?=
 =?utf-8?B?ZzhrUlIvZGJHNThHNk42STdYaWRhdU1UZSt1U1cyaC93RkRpZ3BnbU5mR3I5?=
 =?utf-8?B?cGNQK3hFVnF3d1RTSHdnUE03Z2UySk82TWNqTlhjZkVyS1IzZ29CR0ZsUlFE?=
 =?utf-8?B?NkovMjg4T09rS3JkSGJuRHRlaDREMlNReVVhRHJjNTUzUmtUNmhTb05rbkhK?=
 =?utf-8?B?K0JTN0t5SkROVkh2RElJajJEL3cvR0tmbXF3Nm5acW5wUUUwbDhiQm1ReEl1?=
 =?utf-8?B?dHdERUFOcWtSQ2phQk9XYS9YdW85QnI1N1RRNVpGd1JYaEN1Zm9iQ05YaEh4?=
 =?utf-8?B?TlUweEZxNDd4a0dscmI4MHJ6UW9BNEFScytQUkxiMlMzSjNuYlVIOGN0d1Yz?=
 =?utf-8?B?T2dRWDNrNmdRa2tjS09qOFo0R0pkRzd6NFdKdk9ZUEJsSXVsR2xWRzRzaWFF?=
 =?utf-8?B?ZmxTVHRTYWpVcThMRlZIYmJvN3NneStmUWMyVC9mVlNoZUYvazFnVUxkSCt1?=
 =?utf-8?B?bFVXMjRtUWx2K1dhczd2WGpkQjN5L1gyNHczZE1RWi9ZemVjdXVTY0xnaFNo?=
 =?utf-8?B?c1M0T0t2ak8xVnVCaEw1L3JleGpRbnE2T2NLandneTlUOVhDNEZwbjJwYjBV?=
 =?utf-8?B?R2NiNjRGZjFLNkluVEFkRFVjNDlxejluS3NQYkNKdFNaMGFPWmF1d3Q4WnFO?=
 =?utf-8?B?OXlQejZGeW5zbzJabTB6YllBTEErVkdPb2tGd2R2MHI3QmhTdTU5KzhQSTRq?=
 =?utf-8?B?RTVaNUozZUtsRVdGS3B0c1BJWW9OczlVaGh6TkM4VjR1d0pTVnZDVzI4U2J5?=
 =?utf-8?B?WUpSdVVvU3BKWEtRTC9tNGZKZys4SEo3ekE2WkJDcTZZWmVsdzMzZzUvVWJG?=
 =?utf-8?B?SlRUUnhrV3l0VzY0UjBDUHdaVkltTjB6Uk5MWE9UOGJJUi9uUmZVZ004UU1Z?=
 =?utf-8?B?L2lPa2ZPWXRjNkUrRGVodkh1M3VKOXY5UVgwams5ajVza0t5QTEzWGMzL2h3?=
 =?utf-8?B?WG9NeFFXUE9YbXZvOFFsS3M1VGFVRUFlWndZbENwUkxDU0RmREE3b1F4dkZw?=
 =?utf-8?B?ckkxU2ZrUjBSV2RqVzRkUkxTVFdiYTVvY2orTjBYMHAwNU1kU3VPNHJ0KzFU?=
 =?utf-8?B?MDNYaGdIZzZ3UUkwQ05taXczMGdTcjVoVTNDaFQ3bFNwZURnYWwvWURnVk1J?=
 =?utf-8?B?SUdacW9YTFdtdnZ3RXJGMXpZeTh3R3NqUnNmaVFWTVNvRmNGb3drVEtnaGQ0?=
 =?utf-8?B?NStpVm9ZUlVoTk1KSlluRHROeWVQQlFpTGhSdjVlQVdON3RYOHJLYldWeFk3?=
 =?utf-8?B?RTVyMUtFUXRsdmtqYnMraGtwMHF1VkFyNmhHOHlpK2kzYTN2YlB4SVRrZHZO?=
 =?utf-8?B?K2NkSjBSNVlsQjF5M3RaYytRUi9XWHUySm1GWk52R3VlaXF1elNRaDBDYWdK?=
 =?utf-8?B?L3VidDdEbHlwRGFpTGVGdzdYSU1lTm5IOElVRlhRWFFubEdzSUszeVB6QkpE?=
 =?utf-8?B?R1RkQmRrdTZXem1Uc1BTcmNnY1dOWGZXN0R5ZGYzVXdsTVc3WkpQWUFHeVFT?=
 =?utf-8?B?R0RBTTV2NG1Va1REUTE1TzlETW8zc2FqVnBsczlJZzcvLzBCOUR4dTg1enNk?=
 =?utf-8?B?cmFUVFV4SkNRblJ4YlFDT0lIdURBNE5aMC9jemh5bmsydFo1Q3NtRHRGNEFV?=
 =?utf-8?B?b3NWSm5GZHJIL1RJSmh0QXJQNXJwenczOVFTUk9HSzE4cGU3S3NTOWIwVnV4?=
 =?utf-8?B?N01IWVdOcFF2cE1CZ1BqU1BXdGcxcHE4cGRvRGtmbXZVdlRZSTM0cnlLSXpG?=
 =?utf-8?Q?7GJS+2XLTFZ8me1fHwrShCkcyVxUgp3z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFQNWxvUGFzZ3NrMFpORGRqQ1pWSHNIQkpsbDZmYm4yVHRPZmIvTm15TzAr?=
 =?utf-8?B?RW1YeGxvSGhBZ1phZUxGWjVEczl2Ny81ZERuVkY5dDU1NG15MWNlTTN1WjdU?=
 =?utf-8?B?OTlUeEo4bEhCZDNaR0JKNEZUQ211dWptWXNjSkdMc3ZaTTZEZ2ppWVJRbGxj?=
 =?utf-8?B?WUlXajJ1ZTRadTNPQllJd3VJajd3YXZSSThHQXg1R0ZzUUNpblJvcTk3TDNN?=
 =?utf-8?B?bUNPQUJKRlNwUFJsSmp0UU56YndBQXBBOGFYTng3b05zemtSVENKbXZnZVUw?=
 =?utf-8?B?VUI4UjF0cUhHc21yOTlnNFNqMXpFaUNaMEUrN3pieUV1TldCeFo2U1h4cWxJ?=
 =?utf-8?B?SGNsU1F0ZFptNXZacDMxeFFNanFvb2RkaU5uaklhampyaXJIeU1vR1hnYlFP?=
 =?utf-8?B?MWc0ME41NFQyQnBRanB1eFhvVHYxbTJsUnYybndzRnJiNW0zcjJuaitRejdi?=
 =?utf-8?B?c2hmVEdFRTA0NnRsMkhtTzFTemlWV054TU1EK3hqa3FlQkdvSWkxZ3phc1ZR?=
 =?utf-8?B?WnNLYjVmb095d0RpOUtDeklTdElUSHpRY2lJOGpXaUpYWlhuR0h0cTQ3MUN6?=
 =?utf-8?B?aVcxQnhTMFJtUlMwQzhQQks4U2g0L0tIZWZkakQyaFBSeFBmRGI3MEJGWWQr?=
 =?utf-8?B?VkVRTCsydGtJTXZhb3ptT1ZuZUdlczUyOVpaY09nZmI0WEtqakVyd0Z5R3Jm?=
 =?utf-8?B?NlVBemlNVGpIK3Q5Mi8yaEE3ZldaeXVHOHlrMnc3ZllwM0dnem0rZFRnMXB5?=
 =?utf-8?B?cWFJMDNoUDBaWk56clBPN213Yk9SQmI4Wks2UzJxVnlvNjRUeUYxRDV6d0JQ?=
 =?utf-8?B?NVVjRk9vdjJRVTdWaWRUeUxWSHZoZVUvLzFhcS9rNGdweDJaVlc2b0ZYcDZn?=
 =?utf-8?B?Z1Z0R0lSNGVrOGRrK3BLQ3FHRndCNTUxeGJtY3JQTGMvRkhBSWpqVGhITUZz?=
 =?utf-8?B?TE5FVWJvMVRkQ2pnUGlMbnZZWFdSaWR5SGxsLzN3Y05IUVltcU5UdXBoUkpH?=
 =?utf-8?B?MStnMjJsQzlqVjRUSHRUWFZYOWpvSVVoeGJXNjNtTnhUcEQ4MEJ2TU1xSi9K?=
 =?utf-8?B?TVF5SDFzczZGKzIxOHROZGY5cGo0VDlTU2xabTNYMTcrYzFGLzBJeEI1OXM1?=
 =?utf-8?B?empua2JRK3lUUHIvT1h6ZkZYK2JwaURZbmF0dlZ4c2lBbUZhT01iRmcvRjAr?=
 =?utf-8?B?WlgyZzMwVnJvMDhGNFVqamFIOGhPRk5lV3J3Z2JyRk5Yb0VOeW5nVm4vc3cv?=
 =?utf-8?B?VEQxSFRTMmV2S1I4YzNibWYwYXZ5MEdyRllnejBHb3pGSlprbFpXZVFwa1Jt?=
 =?utf-8?B?TzVRS1JINDhWWDRLdXJNNDNwQ2oxeU9KdWpnM0NCcitjQnJYWklqZ0tYeDE1?=
 =?utf-8?B?Z1l0aWhOYk5XcTlWc1RwbmpSV3IrVDRKT0hjOFIrOFlCZ2FTbFNoLzE2K1dV?=
 =?utf-8?B?M3YwMWNRcUJiWlE5LzYzOWdxTUE5Rk1PeUt5ZEdpUS9kbGlpYk5BbVhoc1ZC?=
 =?utf-8?B?WDQ5eFA5UXV4UnBCMmVCRVZDWnNCNDdBUkxENHNIR2x4MVlDNDlMSENMN3hN?=
 =?utf-8?B?eUR6MFRvNlp3NE9ETUVqWkVRQk01elZzMzhaTE9PVVlIaDdueVRzSENKZ0lM?=
 =?utf-8?B?L3FOakhHM0ZMYWRYakFCN0ZpQStxS0RlOTVsR1JHRkR1b2VZbHJaaEdXM2Ft?=
 =?utf-8?B?MHNiUUg1VitmNVVYVzNWZUxIRGl0WWx2OXkzS3hwZkEzUnlRMjg4RmljckJt?=
 =?utf-8?B?VWRML1ErMTIvWkF3am5Sc1dTSnlCM1NaZHA0blNUVHF6bExOVWhKbjA0SzhR?=
 =?utf-8?B?QWlrczN0Vmcxb0dtZmhOMVc0RE5iemZWR3k2SFBYL2lEL2V3S0d4L0hRcjZu?=
 =?utf-8?B?UFloSTJxV0k5NFF0V3dVYkdIdWxOck1nQURSdzdQOHo4VEVoNFpTT3F3YXVG?=
 =?utf-8?B?Q3lhaVlPRFUvbUhCL1J0VjBhUmVoaW5IUnBoV0JrNEcrWTVkSjdKUExBMGNp?=
 =?utf-8?B?bTNvWFNoQzg3TnMvczRxdWsvVTdMQmM1RUM5K29pOUFmZjQ3bFBDQmVZbWho?=
 =?utf-8?B?dkhwbXRGdXp3aTkydXlwZ05hMDhwaXpTZWtORWxjR2FCWFpYOXBUSUVGZUI4?=
 =?utf-8?Q?SXBXWoKjZwiza4jLMS9t4sETO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e831ee-2534-434f-f727-08de38896d54
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:46:43.2163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 286sp8RDAMbAba8WN9Gf5tP3Ysb4WEKtaP6gr8p5ugnvyQNDHOVsDI+ZAWpVBpxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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



On 12/11/2025 10:45 AM, Yang Wang wrote:
> define following heler to convert pmfw pcie dpm index to smu index.
> - SMU_DPM_PCIE_GEN_IDX(gen)
> - SMU_DPM_PCIE_WIDTH_IDX(width)
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 50 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  6 ++++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b606829a1f3f..732dadc4ebbf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1346,3 +1346,53 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
>   
>   	return 0;
>   }
> +
> +int smu_cmn_dpm_pcie_gen_idx(int gen)
> +{
> +	int ret;
> +
> +	switch (gen) {
> +	case 1 ... 5:
> +		ret = gen - 1;
> +		break;
> +	default:
> +		ret = -1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int smu_cmn_dpm_pcie_width_idx(int width)
> +{
> +	int ret;
> +
> +	switch (width) {
> +	case 1:
> +		ret = 1;
> +		break;
> +	case 2:
> +		ret = 2;
> +		break;
> +	case 4:
> +		ret = 3;
> +		break;
> +	case 8:
> +		ret = 4;
> +		break;
> +	case 12:
> +		ret = 5;
> +		break;
> +	case 16:
> +		ret = 6;
> +		break;
> +	case 32:
> +		ret = 7;
> +		break;
> +	default:
> +		ret = -1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index f458125e8d4e..3a8d05afa654 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -93,6 +93,9 @@
>   		header->structure_size = sizeof(*tmp);                          \
>   	} while (0)
>   
> +#define SMU_DPM_PCIE_GEN_IDX(gen)	smu_cmn_dpm_pcie_gen_idx((gen))
> +#define SMU_DPM_PCIE_WIDTH_IDX(width)	smu_cmn_dpm_pcie_width_idx((width))

Are these macros really needed, can't the functions be directly used?

Regardless, series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +
>   extern const int link_speed[];
>   
>   /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
> @@ -212,6 +215,9 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
>   			       uint32_t cur_gen, uint32_t cur_lane,
>   			       char *buf, int *offset);
>   
> +int smu_cmn_dpm_pcie_gen_idx(int gen);
> +int smu_cmn_dpm_pcie_width_idx(int width);
> +
>   /*SMU gpu metrics */
>   
>   /* Attribute ID mapping */

