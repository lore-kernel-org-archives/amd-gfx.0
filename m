Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3011FCCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 15:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A9D10E5DE;
	Tue, 28 Oct 2025 15:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zkbU8At+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A5810E5DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aw7kbPm6vlWDygqjlmbh3mTA+1U1UIt9gd5I7tz/7ZK7esLbJR6SVWq2+PO5CykSWea8gSLFfjTPEvxPEGAYZVYRxdcS4JKOwn29auV9sf/2nRQXAGgNOGwCd31uBtqI1tHaTHMoeRsxbEJnDKD18LGv8oqiJsXlwuJP+C9TpJj2ApNny14XLD6rDHCCBMNGh8bq741lth2afSqS6HTnyVcj2ZysEU7gPOgNPGbVLvFCuZiiFVZyfPAkGBYHRSP5MfF297LeDN5AEfMnYbkNevmmRITqK3febvcGrABuznDUhGpr2HognC1A/nIhJpOEtEcSLDbmZfqlpz0Ksv9cTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C68BksGihsbnkivyqD6dQey522qSDk5Gn0E+KnYQaN4=;
 b=UXd+a22XN1s2MLrdY901LJXCvuIlXmzoTkPizeVjMN1bv4/Y8I54ATUQA7GtRFCsk5hg0gveJYFdy2ksZFAzZbrDcpVZsQ6WqgQjUUYFmL+T5udpbbEKJHXtLnwP8mR5l//alz+iT/SIMmaMnIFyjyfGsIFMtOSTnotI8nbTnQh6gi3fz6jn6FZREfIke+oCPKV/ZeUY/bn4p8KswJCc0iqhxofUvS8e5HGrApDiXFYnzbVdy4KiuYl4qsMQZOrBYROIOeaobQkRcXSZGZTb5a6pmYZC9Qd+MjjNEZFp40v33lxaxC30gWQ3uB3J6FizeykjMRD67dsdwiZYXYvvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C68BksGihsbnkivyqD6dQey522qSDk5Gn0E+KnYQaN4=;
 b=zkbU8At+aXfkqgkaMGrloZFzPcoVHQsR0znJXERx+uDHmZ8zFk/X0ucgzyXgLZZEqU57VF6kS3juCL/GYrE5M/dvH84f8S71UGKGzG0s1WIwYCCZWtyT/tI0PJ7i8w8sEq/0QYFCcJKzG/2BYbPUFjmwXOL9EZ8V1n21M7tEUe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:10:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 15:10:48 +0000
Message-ID: <a96bb3ad-ea9b-4513-988c-c5ecfbc6e971@amd.com>
Date: Tue, 28 Oct 2025 11:10:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdkfd: clean up the code to free hmm_range
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251028121330.3023032-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251028121330.3023032-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 40579db1-3c15-44f4-6677-08de16342d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0NoazBsczNlRWlEYW9zRWdwZUdDbWJxdGtDTzNUYUpQaHp2RENWNFN6WTVH?=
 =?utf-8?B?UisvY1ZmWSsxT1ZqdEJMNVlTVThmUC9rYzJTNzZ6RStueVlxcThyYVJNNzFx?=
 =?utf-8?B?NlR0MnZ6L3lVeXd3NFBNY1VGVENrKzhNd3BLWXJDaWJ4SUZrM1NYNTE2NytJ?=
 =?utf-8?B?elI4SE1yUE1Pdm1kbDEveUtXQzJmRVNkWmUvMkFkL05lSGZCOGtyTzZWNnBs?=
 =?utf-8?B?YW5rZ2lQc3JWMFZUU00yT3FaL1dCZnp1WktINHQ4L1A0SXRKbk1pRktmWHRa?=
 =?utf-8?B?SG1uQXlqM0tqamNtTXpHem44d2FnSXJjYjZYdU14SUVqL0VLUmJxbWVVU29B?=
 =?utf-8?B?eUFMSzZOWEpXamgzTm1TcmJIQUhZY3JUb2h6UWlxdDl0bEFBQjJnOEZIL2hr?=
 =?utf-8?B?MzdNWXdmWldOWktyNE1WR0ltZmd2SXlhNEIwblVodnpwQi9UN0ZVS0xaWHJU?=
 =?utf-8?B?eWhUZUk5cDBXRnNQclhidkhLVjhRTkhWcDRHVUFSY1pTVzlhNHZsTVlXWVNT?=
 =?utf-8?B?ODh0NmVuTXpOT1BTdFVQNWVoYlpQVlozSUtES2J2UXBGUmk1aFQzNmRBODNF?=
 =?utf-8?B?VUErN2RsdGNCRGU2UDc3TkFUN0Jmc1BhL2xnN2t4VDh6cTBXMHg1dDIvM1Nv?=
 =?utf-8?B?ZEpnaWd5UjVxM3lFQjJlUVc1Zmo0NjJZMnAzdmJnTi9lWXErcUVOUStMVDhr?=
 =?utf-8?B?QXhMdUJhczNrZ0lxVGRqWFZFZGpVM09KKzJtY3VNUU5oT3d2bTFvK2ZHSTFT?=
 =?utf-8?B?SXQvVm9DQ29MZldVVnQ1Y3hhOTBNeC96emRTcXp5LzRabkRUamFnaVAxTWFW?=
 =?utf-8?B?V1pNejR6SkVvbDB2SkVoUU11NU9hTzNkMEFrRGx0VzAyUE1sL0JBb0RtdnZ3?=
 =?utf-8?B?M3Rtd1BSOUxMMGFLa04wSWswcG1ScUk3UVc4dGJiaWkzc3AwUFVyZ3cxbUJM?=
 =?utf-8?B?RTl2R1Y5NUp1K2psanlVdnJIajVQWUdGL3VMMnRLYjZraHJmUUYvUXJaL0pn?=
 =?utf-8?B?R1d0S3lvYjlQdzJ4NXhxeUFSaDhpZ1JlODVkcERPOTJGaUYrOW1rTS9NSDMw?=
 =?utf-8?B?bFhpWk91SHU3UE41YitqbGEzUG9Qb3krVTZjWG9lVlBsMlAyelZrZXFFQWpk?=
 =?utf-8?B?amF6RFF0cFl6L0NpZjl1NHkrK2JrL3hMWnJUOURreHBINWoxcmRGd3RERmg3?=
 =?utf-8?B?UU1panlXcnhkL1d6dmUrdFpPQjVBSXRmZVlCaEsrVlJQMzRSL0FCVkhxQ3Zn?=
 =?utf-8?B?MWQxZ1pmRXhEWjEwVlVZMUg4elNMSE9uMDBqR25DRURad2RVUm8yalVoVTY2?=
 =?utf-8?B?ZVU4MGZyMlcxeGJaQ0NCNmxnakNYZDA2azd2Q3QzRHVxSlNrazE5NURWSVpW?=
 =?utf-8?B?dGVveVRTSEdzblFLdHp1MFYraFFoYnV6eXp4Nk9kVWJaRW1TNUJNa3lsdFU4?=
 =?utf-8?B?ajhRQmQ3NCsrbWpVam14NXRnS2hvdHZOUU5vOFFLZU8ycjlrR1FjMnduY1Zl?=
 =?utf-8?B?ZXFOQXBiV0JMaWFNZFBxd0tiZWdDTmpocWR1QXhvVlJTQ1g4Q0daRWhPVXJB?=
 =?utf-8?B?K0xFaWdVWEdNTEVYUmIwUmhmdllUTHV1ZjIxWmpFYmcyNXFPdllyM3MrS0Iz?=
 =?utf-8?B?clhZVjNvN2N4ZUU1UXBVcmtBR1pJZkdyMTJ5LzFtWHdjREoxZXNTQ3FuakF1?=
 =?utf-8?B?ckxjMlRjU2djbjhQdHlwL0dhN1RrRWtER1ZpSks1UUNnQnk4QWRLd1FMd3Vx?=
 =?utf-8?B?OWJEV3VhUXBMSmg3eHlySUJOMmRsNGJRSVdwRTV3OWxMVzVYcUoxb1hxdnpL?=
 =?utf-8?B?N2hiSHRQano4MTg0ZU8za0hLbUY4SmRNcVliL2RnTTh4M3A2TVEvU2FnSFAz?=
 =?utf-8?B?d25GNG92V242V1hJdXZRZnVOTVBocThpYzQ1MGRmaU9GcWFidm5PekVsTTFW?=
 =?utf-8?Q?1Cr9SuPyTQrKRHQNeBzfCjkV/GvEGpOw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJITGNWNTJVSVJsU0dTL1MvZ2lwdmVYOXNQU1ZnMTh4Rmxabmx4cUN5UnBl?=
 =?utf-8?B?UFVhSEVpZ0NMQ3ZpeVZObE5xUFdMWmZ4cTRvS2loaU9JZVdyTEh1RkN4QWQ1?=
 =?utf-8?B?SUw4VktJSFNLY3F1cmthV1c5aW01VnQrUkZKWFU4SDZFaW44R2hpcFhhakZq?=
 =?utf-8?B?Q3g2OGkrMFErTkpWRXFQdTJ5cUdmRkU5eklIbVBkV1JTbUoxcy96UlZPYWZQ?=
 =?utf-8?B?aVl0WGdSaG9yNG9sK0NUKzJtWnVqZEc4M3REWnNKTW1nbjlseHhGdHhYOTBZ?=
 =?utf-8?B?R1prT3h6ZFpZcSsrSDBrQStNeGJLb1FVY3RXK2VaMnYvN2ZlK3BEcmpxK2Qz?=
 =?utf-8?B?bzlrWElXbVZ6eFB2dldzSTRRVGlSTm4vZ2lBOVdacTFPVUlDdDIxamdWQklr?=
 =?utf-8?B?TEhERVE1b2huNlZaaWRMQUJiY2pPRFhZdFBqb2VQdnoxRldSZk5DeSs5QjFn?=
 =?utf-8?B?UmFOSnE3RlRzbzZKNW5naWdWQS9WYkhZM0VJSmZ6Um1ZdXRYUFh3SXlLMUd5?=
 =?utf-8?B?NFdJU29OcjVyUmRlOVM0ejZ4VDBBVzgxTjhXbzhQK2NNd2RjOVdWbFFNRmY0?=
 =?utf-8?B?QVdjQmo4QXhpd0NES2dPMjhCZzNBU2FRVnZuNnhjYklrU3ptVlB5WU1oczlp?=
 =?utf-8?B?Z3AvMExrWVNtWWZjL3RaVlUvMk9acHIvcGFtdVBVTitxTXBORzdaYmdSdFRQ?=
 =?utf-8?B?TVk0OXBwczl0NWs2aXgvdENvUkJVNlB2clErVW15MXFQUnl2OG8ranEyQ05S?=
 =?utf-8?B?dm1lRjBqQmRyTmNqUU1ka3BRS3lacnpRMkI0alNOUGNQVU1VUFhkQ1B6eWtP?=
 =?utf-8?B?cW14OE5iS1NEc1V1MWpIUENiQ2E1blAxc0FvaDZhb2g3VTVtZDJqTnE0SDk1?=
 =?utf-8?B?aVlLeXMzdzF1U3V6RFVNUmZURXk5QWVRV1g5NDhRQXBtUHplNTJEOWxnRy9G?=
 =?utf-8?B?OGtvTDQxN0xuMUEwZCtRNzdSSjhBRHFWck1GUHFvWTJaN0pxMDAvWmRTbWlh?=
 =?utf-8?B?SzJIcGFVSlNpdW5FZzUyVE9xOXhmN2phY1B1MnNSN2E3SGVjNDF2eVlSdS9o?=
 =?utf-8?B?ZUVqR0RSQWd1aWFPRzdWSU9sUnZsblBTZ3NYaEpDaVEvVHNxWnJoL0dHNHEx?=
 =?utf-8?B?eXN6K3JPd2s3MWVEUG9HcTZISWRhNk5ROEhBZXhWbTNlcEdnNWVGTktqaWVR?=
 =?utf-8?B?VTBxa2dyUVNOamdTM0hmb3FVVHZadXp6UTNGN3pMTFk1eCtWQnRoRXM3T2lL?=
 =?utf-8?B?dG5zY3A0OEdVdk43SVRnRzhsT3lNZGFrQjVRa1B0ZXFlNHNuUVlNbjJ5ZUVK?=
 =?utf-8?B?R0xzMmlaVEJ4OWtkdjY2UGdYTGpmayt1SjdnYTN4TVErdjR2VDJzQi9mYisv?=
 =?utf-8?B?eDF3MHg4WnJJMVd1TmgwQ3FUbDJKTWJXVnAxVWpEcVUrdGxWc2pFQVphZHMw?=
 =?utf-8?B?akxEejJadmxJd0lWd0Fxbkg0aThFV29wL2QyYXVCbk05UjZvc1RVMUFzVGht?=
 =?utf-8?B?aHN4UTNmamdISEpGcWJ4TUF5Z3BYN1BMcU5ZUlVDWXdDTy94QXdCY2xvVjE4?=
 =?utf-8?B?Nk9DZ0tobEg0SjV5c01YV3ZXSEhmejQrc3liUHZQVU9hdnpqVU9SWHZnLzY2?=
 =?utf-8?B?N2Q0WER1bGxEUUFSVERzTEk4am5RQzlBZ3RJeHVBQWw4eUQvem4zZjBFd3JX?=
 =?utf-8?B?SEVYNXJmeEplaFF2TSthcWU0cCtFdW1Qc3BxMElUUEVzdVFRZ0VDSzRxREZz?=
 =?utf-8?B?OEF2M2pwS1JveW5PNWJHM0xYei9kMFhsaFhWbld2NHJ1ZWlkamVxQ1F5cVhX?=
 =?utf-8?B?SmphUHBpb0svTjJndUJrenc1Rkgzc3VleXBVT2lXSDdtajViZGhIaWpDNjdm?=
 =?utf-8?B?U0xKYWV5aVkwR2dkQnNSRmRFUWR4RUJXMTgzcmpNYmgwUDQ1dWZ1cUxXWjNX?=
 =?utf-8?B?a0syazV0ZkZJV3FSb1JlOXpyZk1qS0tpbXZRc21tZnZRTmJIMEdUbXlIb3RZ?=
 =?utf-8?B?eWt1ejJycHRFZGVmdzdHMkhzQWpRVEpJcjhKa3RNR3NFNEZyVDQwME1TZ2tH?=
 =?utf-8?B?QnRaRVJCL2ZiSnd6am1lYzl1K2EwdVY5NmNIV1FCMGFqYzdwVzFyV3V6M21B?=
 =?utf-8?Q?S1Qqyy96gqbxTIB1SCCixRtjd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40579db1-3c15-44f4-6677-08de16342d27
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:10:48.6613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEPvVctyDXZKkM3S5cg9s2HPlLgQMvEWHY8uz4UYWMxvUE8UPtMLh4+5mFPqSRhgJdmezNRFPh9V4YSuYo/WQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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

On 2025-10-28 08:13, Sunil Khatri wrote:
> a. hmm_range is either NULL or a valid pointer so we
> do not need to set range to NULL ever.
>
> b. keep the hmm_range_free in the end irrespective of
> the other conditions to avoid some additional checks
> and also avoid double free issue.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ffb7b36e577c..fb3daa7cd326 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1744,11 +1744,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			else
>   				r = -ENOMEM;
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r) {
> -				amdgpu_hmm_range_free(range);
> -				range = NULL;
> +			if (r)
>   				pr_debug("failed %d to get svm range pages\n", r);
> -			}
>   		} else {
>   			r = -EFAULT;
>   		}
> @@ -1767,14 +1764,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		 * Override return value to TRY AGAIN only if prior returns
>   		 * were successful
>   		 */
> -		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> +		if (range && !amdgpu_hmm_range_valid(range) && !r ) {

Unnecessary whitespace change. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;
>   		}
> -		/* Free the hmm range */
> -		if (range)
> -			amdgpu_hmm_range_free(range);
>   
> +		/* Free the hmm range */
> +		amdgpu_hmm_range_free(range);
>   
>   		if (!r && !list_empty(&prange->child_list)) {
>   			pr_debug("range split by unmap in parallel, validate again\n");
