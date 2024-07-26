Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77974C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 07:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AC710E93E;
	Fri, 26 Jul 2024 07:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZNE4wil";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F29010E939
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 07:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1vi3CL4b//5kvfpPCAjn38Xq4NQJI/2nxPOn6f1V1IKTotnBN9q+tqxl0+fG1wUn3OCqUHO+FWyLI/R8AzmERMclvLSlkgjxTa0g/MkVyuEpvmao2isb8xPk85K5+uHf5ea2InfIms+7sWnBEDSOYLjRjT4FB4CFjeH7CnLsB/a7zsE7smahBP5d2kBvW706K0TXFVF0lmbSbc32+hnRzhMBF5g74lNI/+X1CldNzhQsHi/VHZE0SoVE816mkcgkL2/EJDUm69hG5YB2AlMf9oyohxPQgDCjJcW7EhuC2JDynSeS1/aFj2jE9NkbCzLDKrCt5I4c0aYq8+iq9mQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsEfoeDE3XygHtYll4XH6TNAtHoSNA6oSFMStlwf6s4=;
 b=wvV9VS3u9tQrarG6GTlRSEoF4t1nDEA+RxD1gZnsv/ZVI54TdKq6OLERuL1KqRrMCgxpVwYHRQ4lR2ddW/BNVLBKh/itWg8dYbHLhXqI4Y4zf90D/PGuZxqd2Yqtg+SVBA1Yk7Z9vya5Vd+EU0rSXKC27Hu8IIr+qyNobPYpNY40nQnC8lQpn8oAwRGK91sCl/SIA9xhnVa57mifNI9JMklXzfvyYyOz920jqDOXJ6zTHw10HMRDd7mCLFcxm46wXprTq4iO3ihKfhLVnmeRgYdAqWmCwPhdDPcO3Fdu17kNs/LcKHTgjCpZ4BXVjxdzVxJvpGW72gxbYJKAR2mP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsEfoeDE3XygHtYll4XH6TNAtHoSNA6oSFMStlwf6s4=;
 b=5ZNE4wil/gIvia2BTRgKHKySuHCIhGf+n3EhrvB12fTafGzwQo6gPkSWbItJ74jKfdguRVt+z9Dh+igpks+yieMLfSxsm8GyJS3QJLoFWq4dsUEzwMuAxpT9XGMc/AXwunnjSQN9oSxaueM1AacTt2NS3UlakJm4oN98MchOoqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 07:18:43 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:18:43 +0000
Message-ID: <a85258db-0b36-4050-be0c-2f97752a6984@amd.com>
Date: Fri, 26 Jul 2024 15:18:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null check for top_pipe_to_program
 in commit_planes_for_stream
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240725025409.1507764-1-srinivasan.shanmugam@amd.com>
 <20240725025409.1507764-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240725025409.1507764-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::8) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 24efad63-c8df-41cd-4a60-08dcad432e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlFGZjNBOXFKZ0RhSzN1a1d4Sit3L3VaQnoyZlBBa09EbzZ5Vno4Q0xrZnYz?=
 =?utf-8?B?dFNYTVVLd2VBWmtBSUt2elZwYTZNRlNuZVh4NCtvcG1HUTh4MG8wSGltYmxD?=
 =?utf-8?B?Y1dBSWttaENxUmtuejhVZ0Q1Vzl1ekxyUE9OZ1l3RW9pV0psMHlpeEdmYjFS?=
 =?utf-8?B?eFAzcGNuUHBubDlZVENLMkxjM3d0Q0Q3NGJ4ZXZ5S0UxSzRZSnJRekxORDFL?=
 =?utf-8?B?NUUxaThxOUtyTWdoTzY4YmlML1pDeWVVVitUQkVJbW8vMmVTQ1N3ZklRSHFT?=
 =?utf-8?B?WGFRS1ZIYUMvUk5WL2R3Ui9KVFJBYTVPN3JXZ3poOEw3QmlBV1pIa0dJeW5L?=
 =?utf-8?B?S2FvRXJYMFBmRVF0Q29VSlljb0liZzRMOThOK3hONERZSWdOR1haKzJIQ0Fl?=
 =?utf-8?B?bjZlVE1XL0J0dWZvTFk0VkdpTDE2K0JHQk5LU2N1dGwxeTR4d0JrdDBLa0VB?=
 =?utf-8?B?SkowbnAxeXVleUhZekJVd0NpaVF5ZEVhdjF2eVVTZlpSbEE2UzlLc1BmQmJF?=
 =?utf-8?B?b1FiQ3FIUHhaeWtyc2pHbmRGaGc0QXNGSlpnOXd3V0xOb01nZkM2Yy9jVUh5?=
 =?utf-8?B?d0YvTmtjYis0aXhPVjJaS1Vmb01ZS0JlUVIzdEV0YkhaVkQyUmJ4bDJNeWJt?=
 =?utf-8?B?NTBhRUN3Z3NUNHA1clJjNldWcG15MDNSNzBFRG1zemRhSXVSeXdxSkc4YjJQ?=
 =?utf-8?B?SWY0dm5WMTRrU1ZSeFZxZ2Nxa0h5QmVYcVdkV00rQ3FqOXR2SG9EcVR1QUxX?=
 =?utf-8?B?aTJNaUdxTWNRL1ZtcUtpVVlLb2lXU1BjTnA3emIrenNWYTIvT051ZUdYT0Qr?=
 =?utf-8?B?YkpoMEN3VmV1eHFPWWRDRXVNcGdhQjV0T1FyVkxFR3RVKzY4QXI1ZXJtYlhl?=
 =?utf-8?B?R3RhcE9XMVljN0FFRDBweFBrUlZ2VXZxRkxpdSttRmFKUlJ2MU1tWDArcTQw?=
 =?utf-8?B?VnVnTGwvSHZFbW1ZZGM3aFdYZmJlTXpCMlpjYk9mYjN1Z0VlVnFab1pKUTNv?=
 =?utf-8?B?ams4Q1pPZDZveWE2UExxMHZqb3ltT3RNZ2pBQ0dyaE1zVlhJamJpNkZvUkxI?=
 =?utf-8?B?NWZFRlpHV2hZcXkxbW55Vm9ibVZ2WEdoSkExUnJBT1BaTS9QTWNtZHVoemhF?=
 =?utf-8?B?SlFkYVY0aWhmbUVjQUlaQzhab0pncml5Tmc5NGtuOC93dkg1Nmt2emk0Q05v?=
 =?utf-8?B?cDJFb2Jmb0ZpTW9pVE5VbFFZT2dBVHFkUjlkam1JQTk4b1hHamUyMzVuN2Rx?=
 =?utf-8?B?ZFgrVmVyN3NtNjJZQ3RHV2lVeDFTUFdrcTVOZnZYRy8wczBXSURxZm9Gbzc3?=
 =?utf-8?B?cUkyWFVSVTRKMjhRSWVWcWVaQ3dEenF0RnpuL25QYzN5bDJldmhwMlo1K3Zs?=
 =?utf-8?B?MWY1Z0NncFVYbkNvaTk4L2lVeUdwWEdZYTdUZzAzRmtXd24wN253WGNzWitw?=
 =?utf-8?B?RXJ3NnQ3b29tMGtUSHI0NTFDSUZ0bXlPSGhlN3E3c2JYT0dqR0hkeDVibGU3?=
 =?utf-8?B?clRnKzMvbmtwa2RVNE1qOXRMSUd6YmdIeUhUMVZoWGNCNXZEdlQvUWlGN1NW?=
 =?utf-8?B?NEhsd1FJKzRpZUZGeTlieEEwdU5WRUpZZnNQR2d6ZVJSSFNINzdyczhYZmN1?=
 =?utf-8?B?aUk3cmVBTmUzTllLdnBNaExNVWFKUVd1c1RWbUsxbTFuRUI4SEVmK2pXWlZz?=
 =?utf-8?B?R0poR0IyeDZ1Q1krSytTK21obE8yY0NzYmdmMlNFYWN0YldlZW1vWDBvTHYy?=
 =?utf-8?B?YS9xME95cFEwRk5IQ1VTMnFuUElXNk9zaWRjQXBGYnk1K2JTd2xPNWpkOWUr?=
 =?utf-8?B?bUZBbzNCRTVLR20zSWNWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJqaWhTWW82WmxWMVVZTGxlTW5SVkMxRVowRjVxaHJyMk5wb240NXJVTkxX?=
 =?utf-8?B?Z0EycEtYTE80dStxdnlMenlwc3oxaGRNdEsrclBXYmRUWkxFZjEvTngwU3pN?=
 =?utf-8?B?SmFHaktrYmNmbURoZFd6SGIrdzhocjA2QThzMWpOV2dTS0F0MGEzY1NpRTJa?=
 =?utf-8?B?SUhHK1NHU2V2blZIOG13Tk11aldHMUpCS3FsZ0pUbjRPdzVlUVk5T3llY0F1?=
 =?utf-8?B?TUxVRVloRXJHZXdycTdiN1hDL0FnTHB1TTdGQjd0TXBLTHEzVGhobVdScUdS?=
 =?utf-8?B?aEdMR3BQWDRCQk8zalFFdWF3U25KSmcrNG4xRUQvU1ZlR3dMN3Z2c0JQUDFx?=
 =?utf-8?B?bEY4czl1RE43SVJFZ054OTZ5MTNjTGkwN2ZXWlhzWmFVNG1Ibm1vdERtYXVD?=
 =?utf-8?B?bU1tQmgvY2VrY2NyZ2tNMnV0Q2JmeUhiYTMrNjNnUTE2cm5aNWRMNnlSTGVR?=
 =?utf-8?B?RE5jdFRJRFZCV09tdTN0TU9WK1RFaHJFNzRSMzE4SjNkaHVaLzltYWNjYnpQ?=
 =?utf-8?B?YWlFRENlRW8xYnVGbXBoZFZ3Zm1KRTVYcmEzQnJVV3FWVE0vc3JnWVBzWFRt?=
 =?utf-8?B?blZRQkEwN3NNSlJJQnZZb1o2WkVrSjI5L1ZrQzBrcU1jZUtpV0JiTS81QnJT?=
 =?utf-8?B?MnRSKzhzNmgzUFROVURlNFl5WlpmNWRZSEYxTS8rRUd5VVllcExGeS92M0Y1?=
 =?utf-8?B?L1ZhTks4akZ5OGVVbmNnWDhGZk5HY1BDVDdtTkxpaHdCSzgvdFZLVEwrQ2E1?=
 =?utf-8?B?M1ZPWHVRZGlHVC9pbnpsZ29rZmlTbmhXTkVEaGREdTUzeTg0NVNiU0lURzNj?=
 =?utf-8?B?TVlXdEQ2aGF5YThDVnZtU3U4YzAzczAwQkFKRC9MUi85NkdNOStSYTBDM25z?=
 =?utf-8?B?UWhYSzdHWjhuZHl0RFE4R3FzVFF0WEc2SWVwemVieXBoS0NNQllxZXJaRzZa?=
 =?utf-8?B?a1VDem9GRTJ6VC9qVXVEZFY2YnAvTGFPLzN0c245MTlueithRnNVRlZpSkI5?=
 =?utf-8?B?Sjk1cXRPSWZhbVA5RVJsWEM4WWtscTdLaW9ZRmVBaWJWbkh2ODJ1ZWVWWnVU?=
 =?utf-8?B?WDlGQzFzMGx6aWkwVFFKOFE3cVg5OE1EcDYvMHRiRVVtYVY1OWU5QjAxL1NP?=
 =?utf-8?B?Vmd6WnFGdStjYzBkdDNEYWVmVkdVR0Z1bXJBZDh0Z3JYeldncmJGakRaYjFM?=
 =?utf-8?B?UmRrVS95amRMb1ZEUUdadUJkMmNDRk5PemJHdGtubnkxSisvVzcwbkxoeFVw?=
 =?utf-8?B?OXFYam8rZWtFYkd1aTlXbEk4WTBGeGczR0xLQ2VDVmhBN0l4ZHRhci9MNVJx?=
 =?utf-8?B?UWd3aDg0QjlYaG0yV1dkN010SGNrZEhteUFOMytiM3hDQm5SWVhSeDZPUVM5?=
 =?utf-8?B?anN5M3EwVUhQVExVVTFFRTh3c3ZtWGpjaCszaVZ6U2Y2ZnkyZldsYTBZZlcx?=
 =?utf-8?B?b1hRbUFubTBBNllNNjVQdXJrQm5XdTlVejQ5L0lXNFM5bDRKZSswTndvUG1u?=
 =?utf-8?B?d0lUYnNpMXdvRnFJY0h1d2syMUYrZy8yOFd0SjA4ajVLS084dGp0dHhlQmND?=
 =?utf-8?B?MFc4TXZsZFFselFkalpWT21LQURBeDZVQ1dkUmF3NE5BcWN2T0x5QXhJbjRG?=
 =?utf-8?B?aHZKOG04M1NUUVI2aTFQSEE0bEZIZkNCV0hROHdMK0ZSSzYybEJ2cGtSd0Zv?=
 =?utf-8?B?Nlh0cG14RDY1QnU3NkFLdklQMURWSE54OTkyL09pUWhISVdVdllsN2tER1pm?=
 =?utf-8?B?NWxPcGdhcitCbG9KOC8weU1ucEZQQk5tcDBwOE5hcGF0YTJmWExFRFdJelRw?=
 =?utf-8?B?Mzk1OEVwWUtBS2pEcXh0d2ZWSFpRa0k3L0ZaVWpXWHdoMVhvU3VaWjlaWExS?=
 =?utf-8?B?eVVlR1NwR0ZWcFc4aWpYTHFUTUtvRVYvZHpUM20wRkpWVU5nbkd4N2E1eklj?=
 =?utf-8?B?VGNmZHJ5VWdNWDRBL3BlU1NROTNxMXZKSHBFZG16NlpSN2dpVFdjbDJ3dXVr?=
 =?utf-8?B?SXo3dHBVSlFZTTlwRTY2WEZOS1A0d2IvYzNaVnpBMWNyMHYwQWtod09tRFRM?=
 =?utf-8?B?YmRzaWFrVW1RdzZ1eTV4cXN4ODJpTkdvY3VtdlVQTUlOcVp6Mk1GWm16a2Fv?=
 =?utf-8?Q?Wu4oCAWK4GJmybPQMvPPiutKf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24efad63-c8df-41cd-4a60-08dcad432e51
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:18:43.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOss05ceZnMINxqev3KIgRghdBQDhsNCDL12DDEevxG7yO13Czbf6RHWSWC11T2xFuJYVq778wirXZpd+ACIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/25/2024 10:54 AM, Srinivasan Shanmugam wrote:
> This commit addresses a null pointer dereference issue in the
> `commit_planes_for_stream` function at line 4140. The issue could occur
> when `top_pipe_to_program` is null.
>
> The fix adds a check to ensure `top_pipe_to_program` is not null before
> accessing its stream_res. This prevents a null pointer dereference.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4140 commit_planes_for_stream() error: we previously assumed 'top_pipe_to_program' could be null (see line 3906)
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index b8a6c062426d..95d6e29d5e47 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4137,7 +4137,8 @@ static void commit_planes_for_stream(struct dc *dc,
>   	}
>   
>   	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
> -		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> +		if (top_pipe_to_program &&
> +		    top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
>   			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
>   				top_pipe_to_program->stream_res.tg,
>   				CRTC_STATE_VACTIVE);
