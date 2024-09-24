Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E80CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 12:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982B110E89D;
	Tue, 24 Sep 2024 12:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5R7cvA9p";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C0910E89D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 12:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeGf5mTK48fnf7ieMCZzDdULPBdhsB/BAe1nH8umyyqi8DacBdoWcEHJ7tiJsCtpBxcRUwX+Byd0Mh9rrJ/43YtsYdIsIZ4OCGrwIdn0i3BNGUpOhoGG0b4mau/sm3QcBk46ZKu5+lYCIVd/6VfBP3dLoLKbMGIlDJ9Hrg2T/AUDTM0j0ZWH6lGcytzdDacTzB3w6Ov/OPP4zbKMCIZWt0k0JvI3SvvnjmQ33RFV3nr1HalA8C714P6FsWX3QHw1g4kHqbXa1sLQQu6OAwAej3YSyHlXBPTUkU3dOyF91GthWnzNph0CFl/erN9ko4kyr/5GgeQCNGC9zxz9Rpae3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2JEOnu8GJaVc6i5EvvnrINNZOgC+guNCvNhdTRI0hw=;
 b=YcWznOOcuTojrIlbOUTEJfFMNcTY79rx/6pkckbhJLWKF+KBmweJGR8DCVTMSgvTIept6bJR54T3jXbh7QcHM13TTq7xr0FCAbOjUx/53mEFgOYb9gOLAbHC4xPdF1/9ujZQ63O5oZNqKQo6rGpz2zQBfrhfU9TgzqffIzIVBCJdSgUV239LSpd4/49f2/gCyj++0/r3H81oE04b6fKrhIkpK0ICzkItaIxKdc0jQ/E0VckSSOuC5fgCbCNakCeQkmb0LWx61Q3k+MtsTVImxz5u6kbgqYgeEG7GHnQteTAMTSjP8i6VG6vCCj34zXSwUT6r2E4LigOA4Zfzo4zGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2JEOnu8GJaVc6i5EvvnrINNZOgC+guNCvNhdTRI0hw=;
 b=5R7cvA9pilo4z+eugTlUPQ0atCaxlQtlq8spNQ2RIq+tcH+9EsVHSip5uBoVRXwxZqzWoyprLbmwqFf7Xjp++eYX8IaHV0Tm/i+IKhzFNKFJJFJG8kPD4I7s5pDbZW+T76TJlUa6of9sz3Q7tEq8SwXkwpfZrymCku12/BLyNps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 12:06:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Tue, 24 Sep 2024
 12:06:36 +0000
Message-ID: <6a7005b4-6af3-48e3-be65-353ffb5961f5@amd.com>
Date: Tue, 24 Sep 2024 14:06:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove the while loop from
 amdgpu_job_prepare_job
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240924095145.2281-1-tursulin@igalia.com>
 <20240924095145.2281-3-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240924095145.2281-3-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e280acd-a754-4ca3-8cfb-08dcdc9156e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDk3Y3NKRDh2bS9RclJVTU9sRjJzeGtRN3E1bmxEZDhWeHByQTdqQmp0U2py?=
 =?utf-8?B?ZGdJZVdwbjBRaTRVTnA5NXkrcHRncWQ1RThjS0J2ZmN0OGdPS1grWFQxN1Rm?=
 =?utf-8?B?UlUvZmJrcHRtc1dMbWZiNkJTMmh1dlk5V3Z1REFaUXA4ZWd1c25aUTFEeURY?=
 =?utf-8?B?M0hoQUVHeThZdFMrbGwrZElRMVY2SGE4VjlJSHlJMmJvNVI5NDNOSndrVng3?=
 =?utf-8?B?QjZVMDkxRG1ROTVYZytuQ3U3dEYzZjNWTTN6RDhhYzBRUFdiYklRYncxdWhS?=
 =?utf-8?B?b1B0Z1NrWG9haVBtRUYvbUMxZ2QzUnNsNzdPRUlDd2tMZm9SR3FPRjhzWUhW?=
 =?utf-8?B?RmhrNmFsbEczenQ0M0dyUWovckY4eVowR3R1dVBqOUREZ3RGbVY2bGZyajBX?=
 =?utf-8?B?V2oxRmt0UnBqNWpWdHlHeEQyRGZVczBva0orOHg2UmxScnBHRHZrVW9CVDkv?=
 =?utf-8?B?UDl0NXJUWG9Ga3JrQldVWXRVU0ZTYmh0NVZDMGRNQnNaWVpHQWZIbU4rcVFB?=
 =?utf-8?B?cDlhclVQYXY4dUU2VWdFMGpVWHZsVnZTdlFCZXI4TnZ2MXNoOXVHUE9zeUhv?=
 =?utf-8?B?b2hvdGdMVlc4TE1naWpnT3Y5dXZZVmdlejJKcXBQSkg2eVBKNFpLYU5lcmJQ?=
 =?utf-8?B?ajBTZDBsT2hzQnpEZXBkOVg5bDJtT1A3bkxlU05WeDRhTGFSUi9UTGxSaDVl?=
 =?utf-8?B?dnZEUzJWVWpsRElmbmYrd1E3TW83enMremZaS1hJbE1vUElkYkVHN1dEZjR1?=
 =?utf-8?B?Y3pacFc2MlArTGZIK21tQnlhUWdQSXRwaERuTWxUZ3Q0UXdINVQzYlBjTkRD?=
 =?utf-8?B?OFlLRWxTWlZhVDhDS1hzY3Bwdk5BbmliTWNYREc1YjZBQm54a2prSHZyUzFN?=
 =?utf-8?B?Y1c0OWFHMWdQZ1hzOWlIYkxjcDVxa0pzUEhyN3pyaXd1dEcwQUc0K1R1czlC?=
 =?utf-8?B?ZmcrN0h6U0xPRFdwVVYvK1JRdEdUVXdIeTZ2OFVabUQ0TERWTVBOUzUrRVpn?=
 =?utf-8?B?aXA3cFI5WDJhcTcybUczS3NUSDk1ajRIM3BSd21wV0JsSW5WbTlzQmRlTTFL?=
 =?utf-8?B?Tm9BN1ZVT2UxUUZ0QjhPYS9nOTI2RkV4QzBFTTc2bXRkUEJVRkE1cDF0elN1?=
 =?utf-8?B?V3k3MWRMOFZnR1d5VDAyN0l6ZG0yZmxWTVM2L1B0am44NTBoZERXNWNFSnpT?=
 =?utf-8?B?NGRTL3BkM1pkTlAzWTQyQVVnSVFOU3ArWmtlUENSS3FTTEhTTS84d243YVk4?=
 =?utf-8?B?U2xHWXcvb04xZWpaeG9CSUZHbzNnNTk2M1F5SCtvNVoxODFLams0YjZKSmhz?=
 =?utf-8?B?WHk4WlFaWDNFVmg0b2krVmMwQWZlVnVXazB4ZjFvUDhOYnA4K1NQS3ZOSUlt?=
 =?utf-8?B?WlZJNGNtbUhoc0xjdUxBSG4wemY2UXNwQzVBZkdvcmdmYytNUE9Uc241SGw0?=
 =?utf-8?B?QUpwSU1WeTY3Z2ovWHE1SGNCQlJyZXRheHNqa3Fac3dZSEJaT3dPbmZQbmJh?=
 =?utf-8?B?cFhGMndZQzdOYVA5UncwTVdESng5dXlsTDRPM0tXR2JRckc3ZklNWksrV2hi?=
 =?utf-8?B?dUNFbHhKTUJWWkNTbmxucml1dzc1WWcrS2l6Y05wVzVpY1BNR1pwNEVpcGhn?=
 =?utf-8?B?ZTFUTy9nOS9QYjhOM1NSeVVVdTlSWE9rLytNZW5iaS8yeEZIUFZoUi9GMEhp?=
 =?utf-8?B?RnM3RnBpaTB5Y2lPU1Nxay80TzZzRGk2NHZWRkVBTUdoa0IveCtTYTk1U2kz?=
 =?utf-8?B?WFJ6K0tSc290bkJ0V2RSZmh6WFlSL3V2MXVhK0IxNGlIS1dsK2VBeG1DZEg3?=
 =?utf-8?B?cmExODBjOVdpZTZCLzhQdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJSUEZhbmlXRVhnNkF4YTZpdW9tVE96Nm9WTEx2OFBNQ3FoNlpkOUp1QVls?=
 =?utf-8?B?SUs4RTVOZlp2bGMvT1U3Rk9sdmJZa0gvM28wZXZsT2pvNlBNcW5OaEk3RVNt?=
 =?utf-8?B?eEFXYVljWHVYaGJVcTgvd2FTcTJWbFZCVUFOVHlTeDArWHZ6Y2xXbDc4V2Fj?=
 =?utf-8?B?Nm1SSTlrVGVwMmFCR2VqMEJNblV2VElqcVV2N2ZDY3I4eE01NTZ4c09odHNF?=
 =?utf-8?B?UjEzaUFocVNhbjFrQVdGVzFhWkFSc2IwR3hCYmFxZmphWkVubmJObEVCNThP?=
 =?utf-8?B?YmVlTGJhUm9Xbjk1cTVnQUh1NUVXR3pnbTlIbGlQZS9ielVCSUpRTEsrQ2VJ?=
 =?utf-8?B?c21BTUJMWlgxempSK21KSlRVd2NNZnhxa3NpZmlOelZhNHFyaHNSU216N3dC?=
 =?utf-8?B?ZjgzcEx0Z2M4YVJPd05pLzFzck5yQVl2NHQzU01xWXhtR3VrL25JOTV2YTJm?=
 =?utf-8?B?czVHcmR0MGlwUW43U3NJT2ZreUFLUnhnVVdIM2Q1VkE2aHFnZlMzaXZwS1ho?=
 =?utf-8?B?T1pKRnFwRExydytPS3pmRG5XeEZ0OHh2dXFxa1owQjNhVTB0SUpDc1B4SVVt?=
 =?utf-8?B?NU1MTUtyQk5WTGxyRklQWFNoUE9MS3EzMEp2QktUY3hLcXNWbEdpUDRNNjRC?=
 =?utf-8?B?RTFoZnhONmVUUVV4c1QyTGlDSTBzMkpVZHpoeGx2MmQ3bU43Tnl2TFM5Nk1N?=
 =?utf-8?B?NTM0VERGUnQ4NGhibEpRQ0VQUEtxcktmRUdYMmNJaVJHN0prOUdxTjh2cXQ4?=
 =?utf-8?B?bTdoUXZ4TmwvL2xyM2hxa0VOUGNQRUFVSG9vbTBTSHg5NlR6YTBxZlpKRk5x?=
 =?utf-8?B?NmlSUzZ5OWsyR1JtMm9zNHBGckpLVkcyNENBLzdIZEpEckhhdDRrT2FoL0tl?=
 =?utf-8?B?RXNZYjZPbEowNWRySWhUcFRIbmRaaFlQb1JabXkrM1JWeWVXZ2FzS1lBcngv?=
 =?utf-8?B?S1lMZ0d3RVR0RlhkeTNGMVEwUGs1MTZBTFNDUU5nSFBGbFlJSlFGc0Q2UFVZ?=
 =?utf-8?B?eWhGNWZ6ZVlja21QMjcyaVJuaDVqaUhXZFdEcXFlZFBwZXhhWGQyMlpsWXVi?=
 =?utf-8?B?bVI4dlB6SWI5c0JFMGc4M0NJZ3FnL215NlpvTE5WbkUvRDh1TEtoeWEvdkk2?=
 =?utf-8?B?WmpWVWRTdU1VQ3JGRGE0VG0yZUFnKzlpVUQ5czh3TnhOeGRTa2ZROVBKallm?=
 =?utf-8?B?Wmd6SC8vcU9OWHpVZkcyTVpJOWpoYmFCbXl2K200RlhDV0NjYnZMUXRqbmRh?=
 =?utf-8?B?eTV4SjhkbFlBY2V5V0xyQUxXQlMydDFVdlhKTGV1RENxRXFSKytwSDBuK3lL?=
 =?utf-8?B?YjJHVEo2Y2V0c1FBZXAzWTkrdndVeVNxMVZSSllUYklxci9ZbGxVVzVNWEx3?=
 =?utf-8?B?S1o3UTJVaUNqeld2UVZCNUl0emdzU0o4OVFRTkxnbTU4N1pwRzB4M1Fidm9s?=
 =?utf-8?B?ME0zNElITGZ5NnlzY3ZCQzdycHlkenpYVnI5NVVEMG8wRGJMOTNWUUpVL3Qy?=
 =?utf-8?B?dnBBOTJiMjlqVGNKdUJqZXJLOUVhQ3pQSVNlc2dHUHdmSkJlVGFRUEQzNUg3?=
 =?utf-8?B?czBPQTE1cGxyWFFqNExVYVgwQlBJYmZLdVMvK04za0IwM2VKZkFCYkMra3ZV?=
 =?utf-8?B?eDcrQjF4aWh1RTMvbTNPamRGQlJRYnhIRkRBaU5JeDZjK1dkVDhwYnEzTWFm?=
 =?utf-8?B?N096LzV3czJBTjJmRmhIOWd5Skc0N1FGZ0E4aEowbjhvak1WSk5xWHpkSkgw?=
 =?utf-8?B?TlFuOU0wcHlYa1VLKzRVUzUvUVJDQU45L1dMUkFXMWR0a1FTdkJ1RUc2cUtD?=
 =?utf-8?B?WHdBZWVPbXUvaWtIS0dUZ0VwYkR3aG5KVFM4eTlCYWxGcXZlaENxY2RrWnJk?=
 =?utf-8?B?NUREMUxpY1Vra0RCU1JONDhVZVZCOTdZWlhXdStjT3NXdHNmUXNnZkRqRlVs?=
 =?utf-8?B?RThCd2JFb3hkdk5RWU1QemVwUlN4K00xcXA1enJvVGRSYmpobnZrZ2gySlNT?=
 =?utf-8?B?YzhaYlgxRzJ6L3I1MGdPK3FwZDZ4SWVpaGliK2ZGQUVmMGViVjBHVVRONU5S?=
 =?utf-8?B?cDB4ZSttNUp4RFIwY05RZExSUW96bWFudHlFcjAwWktwbnhWWHJqUmNtWkRP?=
 =?utf-8?Q?9bhtPMf33IyUFkg6epsmgdoxc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e280acd-a754-4ca3-8cfb-08dcdc9156e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:06:36.8646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmm24tY2uuXGolz3c2R8ZuXfAlLPsaa1/qdQhRe6Y/mvZAxSqhWvo/362q+75v/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

Am 24.09.24 um 11:51 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> While loop makes it sound like amdgpu_vmid_grab() potentially needs to be
> called multiple times to produce a fence, while in reality all code paths
> either return an error, assign a valid job->vmid or assign a vmid which
> will be valid once the returned fence signals.
>
> Therefore we can remove the loop to make it clear the call does not need
> to be repeated.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>

Oh yeah that's a leftover from when we still had the dependency handling 
inside all this.

Reviewed-by: Christian König <christian.koenig@amd.com> for the whole 
series.

> ---
> I stared for a good while, going back and forth, and couldn't see that the
> while loop is needed. But maybe I missed something?
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d11cb0ad8c49..85f10b59d09c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -356,7 +356,7 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>   	if (job->gang_submit)
>   		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
>   
> -	while (!fence && job->vm && !job->vmid) {
> +	if (!fence && job->vm && !job->vmid) {
>   		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
>   		if (r) {
>   			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);

