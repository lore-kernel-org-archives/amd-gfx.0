Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1D7C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4C010E084;
	Wed, 26 Mar 2025 08:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TzBBp0w/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6A810E084
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzKLvIHoQIkor8cL3X/bIeyiL016i5G2C14lsrjTQIHnZYxw9BOgkYP8R9RNREFKcoEIXaRjot1m+0A7ye/kyuZW1mMWy2gHHGHHsJ61flO61pR+X6f9amC6DjQbCJ2/h2R0wXMgEc29zMqZvCS0hRieEHzLUc9P8wns3azPQQvJ1MDtJJZFm5hr8CRhSZWlE7k9qwZ768SJICb/40IWdCGUKolwEY8OLJZmg4Y+pheO6HCMEJDm20ImVFRovPPh82ZWkHylxa5KYWanW/opzLe2sN1scF+7M7xEl7DHbBPqtn5T2tQwqUY4VsUifTjNnkE1eJ5Ziui962sfJSRXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLwk/9oEF6OUGomE800xcfarTEHLOWsatb00hSu/6dY=;
 b=k7pAEoc1BGJ4cGYdMAxvGCbju7p8mqKrkQnQayELR0tuWUP6bxTBJv4ojurqyPU8BP4gwZzfn4cxf0Bfmo1LwkmWLXtSN7A5k/FrVWtyhnrtTyYt10Ut5lVLEoVetf15R5yMgIM0aoM3do7i/0uMAuZs85tearkVXGnm9SMsbCRlkIyIeS9pZkE2g7qLJ8szS2Jpe0RWHdAWyaeIempkqMHqGGq/ViLgTBp86Omtr0yokpNjODweMi2zy5pfghpbWFmPAIY8vBkTcVlB3CUC7DY5N5ILblcamlaX9lrU9kHSPKNIIKFuVScYSrNccBflZ8qVFJ/BuzgDKTTNVwz50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLwk/9oEF6OUGomE800xcfarTEHLOWsatb00hSu/6dY=;
 b=TzBBp0w/mbrLQudsZ3pCljAtwiOep/oeQs9Ur+RxvTAySSL4BIEwLpNxvG74EWUix30RhsC/WD2b1xY9GZHCOM8nRiDEjTG+152UgqsBs4rLj3t9T8Mnqsc4cJnnh/6iaaQsMsnjbpiq6E70y4fbA2Qjy9lGvmb/0Bm0j3TvqBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 08:02:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 26 Mar 2025
 08:02:50 +0000
Message-ID: <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
Date: Wed, 26 Mar 2025 09:02:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3ae6d0-1d11-47be-b638-08dd6c3c9a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnJUcVZyMU03RjBVdGtRMU9YUStzRE5NVWViSlVsc1NONkkwOEZxNWs2SDdS?=
 =?utf-8?B?bjB4cUE2YkVRMEVIa3BONmdULzZ0eFQvazNPOVdCNnFpSk1ZS0Z4NFZoMEo0?=
 =?utf-8?B?TXVqM25VNG5SNnBrZDVUak1yNVBtZUU2ZzdjaksxbGlYZzNnOFFaUFVkVUFu?=
 =?utf-8?B?S3VrUHpaSW4wZ3dPRmR0c0JJZi81Q0NkYi9KaUs5TGlKZXVjQ2hoNEF1dDZY?=
 =?utf-8?B?T0J1SWtoQnh1WXhUM0RBS1F2WVNTN0s0dzdYdjhscUsyNnRMVm9oRldpR1JR?=
 =?utf-8?B?d2lFU2lUcmpDQlRKMkJvZ2owZWpETTdyR2RqVXZBREtGcFRNM2VaSUJURWU3?=
 =?utf-8?B?bldvUEJ1NSsrUWhyWDRMRkxXcWJIc3ZscXNIMEs0eEUvUXpUNWtKaDBQcHN5?=
 =?utf-8?B?S0E2WG9wTkRyOXRDNE5YeTRha0ZsV3cwQ0k4N1I0ZlkzakpBT3p5Skl5aFZL?=
 =?utf-8?B?Yit1OVVwOVQ0MkJHaDl5Rms3cUdnYmI0d3ovZ2NrcjVkRDBnZ3MvMXpMWVdY?=
 =?utf-8?B?SHdHMkpLaVEweEtLTlRnTXVSV282djVwNVhZSjFJY2QzTGp5UDBnUmpRV2ZS?=
 =?utf-8?B?ZEZFWVc2REpPRlhTSG5LWWZJbzN5QXlSSUQ4bGRUOXhLdS9Bak5LUTEvSm14?=
 =?utf-8?B?ajlteDFWV0g2ODBoQlZ4enlVdlc5OGMydmZJZWgzOUpMOEJoemVyeExtOUVr?=
 =?utf-8?B?c3BkenU3NG5WYnB2NUJPaStJYWE2WmFsZm9xN3VBNFY2Q0ZDc2NKR25KVGU1?=
 =?utf-8?B?MVlIOHpYS0xEazhOV0ttd3dDYko5TEhPbGxuT01nSFhhL1dvYlRkYzJMNzBu?=
 =?utf-8?B?RTRnVExIdW5JVG1xUTIyTEpVT2ZkSlBTV201MER0Vys3R0xIMnZ2V1lWVmhn?=
 =?utf-8?B?N2N0RFVaUVh4UU1tZVRHRkR3RlBVSnBhYUNqY2FVRWg5NERET2ZETG1BckNY?=
 =?utf-8?B?T0tYM1pBM3JvMU44WmJiWC9VaHNieVkzRzdRTW1VbXBzamxLMGtYK1BSOFk2?=
 =?utf-8?B?VytDOVdpR1EwOTlHNFhmN0Q2QzI1Q0ZEdXNXczR0MWY0Y1dPcTF5K0ZrY0VG?=
 =?utf-8?B?R0FrMnRvblloK1dBR0V5cThXQWQ3T0lJaHRrMkh2KzkxcjJjQWFCa09LcEZH?=
 =?utf-8?B?dWU2a0VVd0E0Q0lWV1BoSHFBUDZFL09KSlRxMmw3dHF3MjVBTlh5Uk9yUzF5?=
 =?utf-8?B?eFJNQlhuam5oeUNsZTFWZnlSUkhmb2NTRDRUTEpJZzkrQXdFbnFiMWtpakRm?=
 =?utf-8?B?ZkQwajBsOVdNZ2xOaHdnVU1xVFFONWl0SDFMRnRKbHN0RkQwZXVmYzJZZU4z?=
 =?utf-8?B?RVhBaWQwY1VEYkhudndSSU1rRU1sM0U4QVFiaEJ1R1UwN0txR0N3Ty9oK050?=
 =?utf-8?B?OHdUQytwdDlUYzNRZ2RWTjF5Ykx3TmVReWhwSzVCaUlqdjl2M09mVCtacW9C?=
 =?utf-8?B?TnJJVW9ZeUNrL0Rnei85QlRWTUoxYkJ1MkJBZzhqZkpBUHA2dlJoTHBRU2E0?=
 =?utf-8?B?TTZ5bEhQa2pRVUhSZHRYSGZubWY2cTBURlREcFlLdmtjUmhPaWUwSzU3RExr?=
 =?utf-8?B?bFg0dDlGTTRRVWp6b1NFR0FIS1EyUXpjMS9EaXNZeTl3djlZNWhhc3FKRDR6?=
 =?utf-8?B?UHZLRURMQmxQV0cyaHlzcW5pODlQWVVNZFBBcG9nZnNTd2dLanpEaDVkZVdY?=
 =?utf-8?B?aUwxMFN2bXJ3a2VIeXljU0hWcmd4aGhUS3Z6U0xHWDNyU3Q1VEJndGxWRStm?=
 =?utf-8?B?YWttZHBqUFhidUJWNEJCc21OWGlUcHJjQjB3MXdrYXVsb1Bva0VEZk94VVY2?=
 =?utf-8?B?K0FwVncrSFoyTGJVMGtIMW0weWxaSm5UMkhDTytZZG5xVXpCNUltMW1OZnpQ?=
 =?utf-8?Q?FSuDBt7DqL8ZG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVIxU1ZoczRjd09VUFJFWCtEQ2ZLSlNtTzFqNG1YTHMyZ3UyaEFDU0NCNnFF?=
 =?utf-8?B?ZGpoYmNsVlpjdlEwcnU3Vlc4L2RhV3ZwS2Z3R2Z6NDl5b0o5NEFkV0thS3Iz?=
 =?utf-8?B?Rjk4UXdveUZRcUlkdnplTEZ0Wm9vQjcwR3JOZkJwYXJyeWVwZUZ3aTJxQkZT?=
 =?utf-8?B?bnZRVWFLNlFoSm91eVEzK0I1NFl3Mld6b3Fya2RQeHRLdTVaMW5mN0RPb3BU?=
 =?utf-8?B?TEZpZlYxU29vSmh4bW1KajF6WVpaa1pJMlZraXF4enA5S2ViQWpQZElzT0p2?=
 =?utf-8?B?YW5ZOHNOd3o0VDFmQldScVAvRU1yRllzNjI3ZTBZdTRmYUMyd085Z3lXWEE4?=
 =?utf-8?B?eDFqZ0FESUlNN1FqRzVxT0dYYk8zQURXT1J4SEhZeTFYMlE3QW5CanJxWm8v?=
 =?utf-8?B?Y2Jqc25WaEtlODRpSldtdmpkRUV5YjhkNkw5YWQvZ1pITUYvRUlKZWxyVXFu?=
 =?utf-8?B?S2l1dEFjVUU2UVFBR01CMk1MaE1oaUR4MUx3Z1RoNEJzTlgwOXhhTklNc1hz?=
 =?utf-8?B?Tlk5NXdQQW81STI0ZDNWOFJCdFkrZ0Y1b2Vrby81SUQ1VWFJdkZlNmExYzQv?=
 =?utf-8?B?d1dxaTFvb2d3KzF6ejZFNEZlcmNmQUJtanJGY1RtenJFWU5keXdlai9TWmRQ?=
 =?utf-8?B?a09oOUFMQkVwa2xhRUh6cDZhMlNjV0NzQjlvTXVNOUJJSlFaUUlWbzRwbTVL?=
 =?utf-8?B?NFl5RmFWRllyVUF1MUxZcWZIbTRBVGNaZWdoazlkbHM0S1dTeG5MSXYxTi9F?=
 =?utf-8?B?eWNqbml2L3htSDZvL0R2VExndXYxN0ErVHZVTXk2bEd0RzBOalVNQVdVUEp4?=
 =?utf-8?B?WE1vNzM3VGZLdmlIZWVWZ3BDb1hVbUdtV0wrTUQvbVp6cWNwOXhtQ2FhejZo?=
 =?utf-8?B?WkN1dk42SlVWdzh4Q2RvYXljY3Zjd3hjbVJVeWhKZkZYV2l1ZGc2aXJJVUlm?=
 =?utf-8?B?Tm95cldiU2Nhc09vdWY5NU93WVp2dllCTHdnb0NFNkZORUxMQVN4VkNpaUNh?=
 =?utf-8?B?S3dRTkxnc3lQYjY4VTg4N2loSFNTZlVSRVFyZzRtY2F2dDRxMCtqaE95VFo4?=
 =?utf-8?B?ZnZXWTdVeExJNHVwdG9QSWtGdXp0UmlGdHZpSWo1ajljaDF4TmFaWkhvOUp3?=
 =?utf-8?B?NjJJa2g1TkxtaUs2RFd5cEx2OFg4YmRGbGhzWUJyT0N6WDlXbTdKZStmM1RE?=
 =?utf-8?B?eG5BTWN1N3E0THBoUHJNZ002YXYwQlljdnJSMS9NYnU2UWgvbWw3QkRkajFI?=
 =?utf-8?B?bDFlREZyUWZ3ZXVsdktsOTVoL1U4ME1zbEh6L2MyUVdWaFBNaU8zRkIzbHZh?=
 =?utf-8?B?RzhpVEJTc3hnV1VpYmoyWVRVdzJ3QzU0MUhrT3YxcFBSRXJZWDBqVXhITEhJ?=
 =?utf-8?B?VVEveCthWmtwZmFGanhyQlFMd042bDNQUVpCNDdvamV6M1UxR1M4a0dGNDlD?=
 =?utf-8?B?NWdpUWVqVEh5UnEvVWJtSkJCV2RZaURZRmR6UDFEQURBOVJnL2ozdklWRkVT?=
 =?utf-8?B?TWwvVUx3Q0F0dmdiekwvcEJWM2IzV1BwV2s5eUwvaWNzYUdSYVg1M0pJSTQ5?=
 =?utf-8?B?bHpyNVN2ell5Rm9nTG94bGt4Wi9BQi9MKzRxZlV6M0hlRUVEeHpjNERDNXJM?=
 =?utf-8?B?MDA2SGFRNm9HTmdDMTRaWlljZ3VPcVR1Q3BmaDFUdU5SVjFGZFVFMEphOHR4?=
 =?utf-8?B?SGhWRUxDMXBJL1VteEhqdTNvK0ZDekJDZUJzRkIxS3VVcStTa2VHUUhlVXdn?=
 =?utf-8?B?TFY0SDVSem43NnNGZHlpK1RvNGI5T2JKWWF0Y21IZEdxZUhMajg3Zmh4OWhL?=
 =?utf-8?B?b2hJdTVKV0pxK2w1ZkthbDhiTWRWSmtrY1FzanFYUXFUWEdpeWZxL2t1MlVt?=
 =?utf-8?B?S0lJaE83T2w2dHdaZDBaTVlreDJVc1hPRU1TcWtjNENNWWxYUUFmZ0NZaERR?=
 =?utf-8?B?MVFpYzZuVUVYdnNSM2Foc1pXNG1mcmh1MWNtVDdkbVNSOWhNZjgzNFM4aHRt?=
 =?utf-8?B?QVZhK1hGemlVNGRLOFJPQnFhWHdEcjF6NTJKSGJmQWhUM0d0WW15aUNFZ2NP?=
 =?utf-8?B?b1lMeHVmSUptU1VPV0c4T0I4TzB6UGM5QlZJY0dmajU5aDVJVUt2c3k4MXFC?=
 =?utf-8?Q?wKRj5uKAz8HSjZylZzGWZTWgz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3ae6d0-1d11-47be-b638-08dd6c3c9a84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:02:50.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW4adwunFCRMVsM6FTZ4cCt6S88hTAijBlbDozLvqn1JyMSxLumLNZbic8oZrftF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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

Am 25.03.25 um 16:24 schrieb Srinivasan Shanmugam:
> This commit addresses the issue where the cleaner shader was not
> correctly executed during gang submissions due to improper handling of
> the isolation spearhead.
>
> - Enhanced the `amdgpu_gfx_run_cleaner_shader_job` function to
>   initialize `isolation->spearhead` with the job's scheduled fence for
>   cleaner shader calls.
> - Updated the `amdgpu_vm_flush` function to properly initialize
>   `isolation->spearhead` to the job's scheduled fence when the cleaner
>   shader is required.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 72af5e5a894a..807f17093006 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1436,6 +1436,7 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
>  static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>  	struct drm_gpu_scheduler *sched = &ring->sched;
>  	struct drm_sched_entity entity;
>  	struct dma_fence *f;
> @@ -1464,6 +1465,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  		ib->ptr[i] = ring->funcs->nop;
>  	ib->length_dw = ring->funcs->align_mask + 1;
>  
> +	if (job->base.s_fence)
> +		isolation->spearhead = dma_fence_get(&job->base.s_fence->scheduled);
> +

Apart from being very risky because of not grabbing locks that will leak the previous isolation->spearhead fence.

>  	f = amdgpu_job_submit(job);
>  
>  	r = dma_fence_wait(f, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b5ddfcbbc9fc..e23400b53489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -692,8 +692,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (need_pipe_sync)
>  		amdgpu_ring_emit_pipeline_sync(ring);
>  
> -	if (cleaner_shader_needed)
> +	if (cleaner_shader_needed) {
> +		isolation->spearhead = dma_fence_get(&job->base.s_fence->scheduled);

Same here.

Over all this change doesn't seem to make much sense to me.

Why exactly is isolation->spearhead not pointing to the dummy kernel job we submit?

Regards,
Christian.

>  		ring->funcs->emit_cleaner_shader(ring);
> +	}
>  
>  	if (vm_flush_needed) {
>  		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);

