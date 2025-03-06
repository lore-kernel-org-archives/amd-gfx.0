Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0162C19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 00:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E414A10E87C;
	Thu,  6 Mar 2025 00:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Yt0qjYo";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AE610E87C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 00:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM5/ZqH0oS9kEQj7iv6aNnzYB29xhK+kqKUvP7YUt7oGCqd224U7DbwDQNGsE1Qea6zS4TQAihSAlsFq4soFxeShzQCPmkJPdek/5Wq/cFbZ+xNEtbkq70QDLHswADEcrBETcHggozoXgwXb6TME55W6+6UNYeopj1qhcwXf9piOheUCx3631ld7Gm8qOWqjx2IRehut7x+7IFSW34v3Qynr0ggt0bkjgmyJuNIqsfhFukTvm6BG5u13C26/ZGW9fy+wW5xt8FUptcOLDXbEXyM4hHrGaNGKwz/pYQTVHBiSoFJCFHjyDRMGNpUQ8QRlokFsC6eKKH4iu0FQfpexCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGeqSKwH2/pzNMdapB4OO0lFUrSWg9VhSE+9AdBlYKY=;
 b=TwL4snQFPWXvLTIympBlNXticD5Utz1/e9ieDULrvp3UCkdbw/UH7YvYwBArVzbeSnH5UWAxMfcJXsxl4Nmg1uvePRBgw1nliFfAVOwm/e+WbiUkE3gAS81ZT/q1nlKzu68ySPPxXLQGOQTTiKEu9bVLvn7Rbvu7LpZC8y9McsAKjKHtUrALxhJmEkVl6QM7lcMW/jIYGICiLbzJK/Tday4S1kezmZFoyBhDqu2lPillGPi9V94pDsDcihy0DWn6AUhs4nOMEjjYPmZbMadNBrXFZdTTLYMruyAzBiNp5lEXhxzP+DYirKdBBKn/jA4anOhxcZmGz0xIGG0KU4wkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGeqSKwH2/pzNMdapB4OO0lFUrSWg9VhSE+9AdBlYKY=;
 b=4Yt0qjYo4UrjGw1qHLvVy3tLRmc+g6z3azZefweQ3uIGSlxiZjnB906MOJZD/g9mGTTEwHY0MHOx3eUtNrIY5x4GF/eM6PxgYYoe2fqz9DpaO21EEv2rj8B+g7YRZBBnRmo41JTLLyeT7SpFBVuUVUXc88UuIsCGFR/eoIK9m7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 00:52:56 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:52:56 +0000
Message-ID: <a58319df-7f75-4757-973b-462aedd2b099@amd.com>
Date: Wed, 5 Mar 2025 19:52:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the race condition for draining retry
 fault
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250306004932.3219705-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250306004932.3219705-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb71c6d-4694-41fc-bdf0-08dd5c493bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDFzNkQyUDIvSEVsY2xMN1Frekl6RW5VTUkydmhjVVZJTnRLK1dDemVadEVw?=
 =?utf-8?B?WHRyZnVPMk15TFZYeklBQkJjY1c4aXZ0ZW5TOGI3SjgxUWNiNGREV2dGTy93?=
 =?utf-8?B?cVdUaG9NSmtzbERGWHhKY3I4MTd0QkcvdmErR3JiQTVURFN1OEpvcU5sbXJE?=
 =?utf-8?B?ZlNhR3JGa1RJK0hoYzBqUS9Sa0xXL0o2cERyVWs0VmF0TWJXRFZ4WVRrblJ2?=
 =?utf-8?B?aEJiVHFYUFpIRW9MNWxJUkNLZ0dPUkpaSW1xUFloRTVoclJPRU1UVkxsNUds?=
 =?utf-8?B?RWxnSGp3WFdKTGlCYUlyL1hGU0dSTFFRMVJqbldGZ1RxSW5kaENCZGJRRmh5?=
 =?utf-8?B?ZitzZ2RjL2Z1RTEyZGV0amF3eEVVb1VXSlRWL2RIRUhYbjc5Y0Z6UzFJWUlK?=
 =?utf-8?B?TXd6NytNQllaVWV6VnNQMkp6bnpzNnAvWU5CcUw3MVZ5YkhoR05YeUNGSnFR?=
 =?utf-8?B?V21EM3pmMDhXWThEeFNWaXIzSHkvOUhwZUJRL1U2YjNSNzJIWnJ0VGNsUzdu?=
 =?utf-8?B?eTlqN0ttWTBzQ0UzU0tnV0VjYlQ5QWlmbnM4NTE3R1NyVmlKVnhiUFlERlJ2?=
 =?utf-8?B?YlBYRnB6U1NENklhSDNNMHFGU0JWTm1PNXR0b3hJcXJCMXFkVWhHVmYxZ0t1?=
 =?utf-8?B?c3F5Vm55YjF6dXRta1VzeFYzalBjd3A1SGNnNEVVODhEOEtxQ2VvMFVDSzFo?=
 =?utf-8?B?STFINU5DRkNRN1kzbGZTd3F4WHFsTS9raERuQUlQaWg4aURyandEVVB2M0xR?=
 =?utf-8?B?QmpqVFpLWjJQRnJ3S1puOHByVUFNU2VCMHVOVkJkZDVRK0JJcm5vTkI2ZWVv?=
 =?utf-8?B?Q1g2aUs4TDRlMWlTUk5jempMbnBmeXpHVDR4WHcvK01kTDg4dks5VTQ4Nmgy?=
 =?utf-8?B?VG9jWTNJR0orY3BGVjRVeitrWUJUQS9rZXJMMWU2OHhSczR2ZDBrb0VNdkNZ?=
 =?utf-8?B?UDhkczBHVnJucjR1dnlXUXZ6SUF0R29GOHZ3NDA5SGZKcDRwaHE1dHNYa2Ux?=
 =?utf-8?B?TjZINTF1aTlGa3Yvb1VQSC9ramxFckEwQkw5ekxhM0d4ZzQ2YWlSckRacHZh?=
 =?utf-8?B?cWc3L1cvM0Qrd1lTRjVqcmtic2ZRUHZkeDd4dVZoT3k2K04wYm9PaFp5d3RF?=
 =?utf-8?B?Mm9KcDBaWGQzVmxOWFo4a1d6TUxWOFo4dmJCUndpMGlPSWxpajBCcHFTTy9a?=
 =?utf-8?B?WHJEUkFzSCtnUDh0eGpEZ29yejNrRzIrSmZWS1Y3Q1BwVjhEY3VRYkptZTZm?=
 =?utf-8?B?dlR0K2toNExaUjY2NUN6TitWMEpvYXE0ODBUWEwrVzZIREZBdzd1aXJqakVj?=
 =?utf-8?B?VTJkRzRTUkhjT1VOT2RBWVlKNkNuU1dyRmNKU1hId3diaDN0NExnL2ZFb0pK?=
 =?utf-8?B?aFNVaVVuYlg3WjJNMXU2ek1TRXNnK2lLemxSU25HejU1MXFsRE4zc3IxUnhs?=
 =?utf-8?B?WWRYTDFrOWhXSldqVHpLVldRd01hVExsUGlHVWZsbmpacGRZUSt5ZVRiSm4x?=
 =?utf-8?B?UmJWRUlQOU5IQmFkd0FQdnRwVnRlU0VKY25wNEJmTUNJSU5FVHJJd08ycnZv?=
 =?utf-8?B?L0lyWUNyUzlsTlhXZHVkdU4wTzVybzFiQzVWR1ZwUVc5d29rTFptMDV6clNr?=
 =?utf-8?B?TW5IYjJid3U3YkRNWlZzaCs0bTlOREczOHRKckRsV1FvdHZVQ3pQTjNUam56?=
 =?utf-8?B?NzU0OVJwaFMxZkI4ZWt2ZEtYMUtlTXRxMVdBTTcrcTROeUgvSDBCUDZBVzlk?=
 =?utf-8?B?SWtwckZYZ0pWSjBlZjNrME5EdnRZaWZrVEl2d3hMYVNQUG8rRVV6cUx1dHhT?=
 =?utf-8?B?cFBnUW9wUnM3ZlFONTJBenhLK25xa3FzU3FMRkU5aXI0Qmc1Mmw4azdzSFBW?=
 =?utf-8?Q?f8bYJ7pklLTKN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1U0NWV2KytMcjBPZWlSK2tNN0ppbGRWYlE3UHpOU3JUUmowRWk2QUFMZ25m?=
 =?utf-8?B?U21xWlFkTWZJY1U0N1FFR1hjYUhGTGk2YllwbzNpUWJWL0RkTWZqZFJJdWhm?=
 =?utf-8?B?VHBTbkUrSEtnNWRvOXltOXdLSU5NS2RKWFlHYTg1T3VZUVJiRFhOQzIzcElv?=
 =?utf-8?B?TE91Vzg2SzdEVC82eCtXZXVvRmt2SlUwc0NBR2I4SnAyTWdMYTNGazNGdjdP?=
 =?utf-8?B?b3NRT3pLTGFjVzhrQWV1MFBSdjBsRU1uZzRnRHVweFVSVDVnNXNRM1BmWmo1?=
 =?utf-8?B?UkJpRTlzNkJBdCtYbHd4Q3huZWY1WjNsWmVIY1ptUklJSWM0UVprL3Zlc3hn?=
 =?utf-8?B?bHJNYnVyYmNxVU1wd0xxcDUrMUxCVkRQaVh0MDZtQjUzbDM1UmtwNFVVdk5v?=
 =?utf-8?B?ZFh6aEdxdS9NY1Nkclc1ZWZTVG9NNURoL0FRR0puOStzQVZScmRnMFJyTnZO?=
 =?utf-8?B?c1JpMEZJRHNjeWdGZERFTjMrcFIveGJpZG5YRXlsSlhQMnZDWFM2RG96elFT?=
 =?utf-8?B?ZFh4cHVOWHFNSklCTHcrakt2ZGI4QTRDZU9ieGM1RHF4NjI1VEJ5bU1nNDB1?=
 =?utf-8?B?Y1QyYkRieU95MGZmdWJhZCtLY1YyaU5xdGMyaFpkZkJ2SG5tTzJ1L09QOTFs?=
 =?utf-8?B?TkNkeC8rRGpnaUZxbDN5Zm9qNjQrZUdsbkZuMnFBOVR6SHVvSUNVdHVDSUZi?=
 =?utf-8?B?SW5mS0JodkE1clMxOC9yZm83SG4yUnk4cXlTV2hFd1p0M05iKzIxY3dDSDcy?=
 =?utf-8?B?S2ZrdGlUMlFvSjZPMXFqQ3JoQ2lIZTBqUTNSR3Rhb2lUYi9VUFU2M05rbnVW?=
 =?utf-8?B?NEtSdXFScXJwdlJKWHlDQnk4cUxGdEIxNkFvQXFocStKYklmYURuTndycTA2?=
 =?utf-8?B?QTJhRkVtWk8xeDZhbEI5WGVrVExWcUJQRGRnd2dPN21IdjNud2p5VzdnUkxP?=
 =?utf-8?B?bjhsYUxoUDl6RXFWa0hGTzZqeFYzSmJUM2hVK3dDc3NXSkJlb2MwcW5Eb3Zt?=
 =?utf-8?B?VGpxWjlkajVkYmpZNFJMSWVkS2diS1M5KzFhT1BMNnR0byt2NHNhSzhmUFFU?=
 =?utf-8?B?ZEl5NVNhaUZhQVNTbmcza1lGcC9yUkNseGlnTmR6VG1RTWkwRXAxb1J0Q0ZI?=
 =?utf-8?B?WmxSbnh1ZGNrem4zM0haVlUvb3YzaDk5VStqSVU3Qm1wSThWdGJ4QzJiUmtE?=
 =?utf-8?B?T3QySjFweXMzZUhUNXFSTWdBRFlIU2FQdFlmeEdncldidVJod283U1VOalNq?=
 =?utf-8?B?bGFxZCtZeXdFdTZIQ2g3NVg0dlJZR0tITUdGaElQYTdQQUNIcDZNL0M3dUVC?=
 =?utf-8?B?M29pbmtHam04L1BZQkViODRyRzJqUVhPUTRCNlJpdjZjc3g4QWtYb2tJdUVD?=
 =?utf-8?B?aVJFeXZwdUw1UlY3Z1YzQWd4UFBqamxudW1kWlJSQ1ZBRUcrckh5WUhMNW1Y?=
 =?utf-8?B?YkY4dlpEUGZmUUMrV2d1c3FFVDk4aW5wc3pFY1RnN2pmVVNzekRTYXhCZ2wv?=
 =?utf-8?B?TWVZbG9WRWdiK25tVFVDMGpEMTF6ZmlMRmI1LzFhbjY5UHc1Q1pETUgzVzhS?=
 =?utf-8?B?cmFaNVNrU1ViL1hpdGFmQVlod0ZMejVrS3VyMk9WOVdsRS8vQ2pkKzNKTUpm?=
 =?utf-8?B?dWNGWlhWU1VJOVZxNTdaUllncTVyZU5uUFJsazJtc0NLVGJZdU4vMWd5aVVC?=
 =?utf-8?B?RlU5ZEtqUitHQ1I2RXFBaDJYTjBRbnpuMFlPamEwbXF4cEF0MVdJby91SDdJ?=
 =?utf-8?B?bXR3azhsbFBieStCZ3hqRkJCZUVGQlV5ck5HWTRlTURvUXhOUUx0QkFpdjQw?=
 =?utf-8?B?T3hIVS9DY0JqYnFUWGlEUjF5TVBsdjF2SHVjU0EyTi8zbnpxSTVxdjVaVS9L?=
 =?utf-8?B?S3BjRVBnUjNONmlDS2w3SXZYZVhaaitrZWtDbkZXbENFdFovNjJtaHg2L3RG?=
 =?utf-8?B?SVNPcHh4enVxMmpRUlY3REg1YTJGNW5OaW9Mak1HMklQNWVoVkI2K1hQRFlZ?=
 =?utf-8?B?UDFSUGlpRG9kV1ZrRzFlb0NzWjh2bVZUWUthdkhwUkdLTVI0TnJweEZpbld4?=
 =?utf-8?B?a2hrcmJDcDlFcVR2enJVL052QTNEemY4eFFES1lKM2RZMjAyVEhNelBGUldE?=
 =?utf-8?Q?kK0+7x8eQrKUS8rEALl0Ha5B/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb71c6d-4694-41fc-bdf0-08dd5c493bca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:52:56.3094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trcqdrqefWf6vx0Bud8imXSQVhWUVKhq6wFQwxu9ZCy9BoZeP872eyyr8tPJSsPPmOGccozyCxK47sK9+IYahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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


On 2025-03-05 19:49, Emily Deng wrote:
> Issue:
> In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>   has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
> is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
> continues execution and reaches svm_range_from_addr. This results in
> a "failed to find prange..." error, causing the page recovery to fail.
>
> How to fix:
> Move the timestamp check code under the protection of svm->lock.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d04725583f19..c99c10e247ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out;
>   	}
>   
> -	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> -			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> -			r = 0;
> -			goto out;
> -		} else
> -			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> -			 * to zero to avoid following ts wrap around give wrong comparing
> -			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> -	}
> -
>   	if (!p->xnack_enabled) {
>   		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>   		r = -EFAULT;
> @@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mmap_read_lock(mm);
>   retry_write_locked:
>   	mutex_lock(&svms->lock);
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (svms->checkpoint_ts[gpuidx] != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +			r = 0;
> +			goto out;

I believe you need to goto out_unlock_svms here to make sure all the 
right locks are released.

Regards,
   Felix


> +		} else
> +			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> +			 * to zero to avoid following ts wrap around give wrong comparing
> +			 */
> +			svms->checkpoint_ts[gpuidx] = 0;
> +	}
> +
>   	prange = svm_range_from_addr(svms, addr, NULL);
>   	if (!prange) {
>   		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
