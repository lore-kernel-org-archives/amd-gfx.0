Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20839CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 09:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B108710E0C2;
	Tue, 23 Sep 2025 09:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIQ/ScFy";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A4910E0C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 09:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW9378YxUj76NB36vIrrNdCXLRq//nqaKnfnUPdIGhyL2j0MgQB4RJCJoRCm+ybJflk4NnttXsvmPEHNlwLRCL+tp/6uHaAuOQfwqJwzQw0XqvOrGi9hR7ggDzUEZDPdTc4YP/Dfr5PchHh1BoiGh3/iVg3QlMJWsyxJeg4DliUCnNllSWH0aHvuhaTM9dLzCT42jU8JYkxyxh8+OacpngxZxc+KwAkfJ2Ule5YtkwiPHWaogZLhGg9LWJnS7Cl4TPBWBoZlMMg/QO0RywYSyYf40Oi7NU/xHF0OD0GCDI40Rhc6AEk6gGOZFS4OIQnoo1aV9d4WUe8L2wZUWA8TqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p8nmoO8irJiR5fl8iLaS11qCeDcVduc+j4igYWcL9s=;
 b=c2keG1sanJkorvya22Jnso5KpngimV8OSDf8DbB8XUzoOPPif6CTCe0wjhTAGK2RPVdyZNvgucbnaeEYItz4or0lJ/L8qTm6jwDTo16PR/RxIWbOvOayBPqiTgmtrWva0w+GfUMYEXu9i5CDUEp90noJGHdA/dZG2N2AWfaeqTlhMWj5I0Fy4IfDtc6IUaxR30hfbHUzj4/nPTTJIgbrDDshVEwVpFzXkxvznl6YmGTD/z5T6tTBkaXyIpiSgKhaRRBNfjhwfHPB5Ed1WChWNpfv78cq2FWUfwFeEEnoDiXZqPK+pVW525uJ5IUNtFCLwyp76lL3FzOSdN9tG/84rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p8nmoO8irJiR5fl8iLaS11qCeDcVduc+j4igYWcL9s=;
 b=GIQ/ScFy8b7Ze9Y7WG72oY7QU2ZlhuNXKNFbB3m1GKg9WO7W40019dAs4A85Y2pAMqzAApZOCdSpFP1kqmjMxZfazWVSmknvaCc9RnRezdQ1uqhRYdpOQvbA0niG5k0HBs7bQeVuqww/R+jJn4YODhW6NH8GyxFgSsYJovw/ECM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:52:41 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 09:52:41 +0000
Message-ID: <a021ab79-b09f-45d9-ab57-600cc6efbfdd@amd.com>
Date: Tue, 23 Sep 2025 11:52:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: Fix reading timeline points in wait
 ioctl
To: amd-gfx@lists.freedesktop.org
References: <20250915062056.6436-3-david.rosca@amd.com>
Content-Language: en-US
Cc: Christian.Koenig@amd.com
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20250915062056.6436-3-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::18) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da642c2-af50-4053-df7f-08ddfa86ef81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3Y3cDEwVEd1VVdQUnNnRjE1WmN6RkE1eWlLUlNiUjFiSU9temNIMDF3RlIy?=
 =?utf-8?B?ditBRzV5Vkc3cjVUSHptWVNwYmQ3aGxTYTBmcUhNbjI3QXI0cWZUN2toWFJC?=
 =?utf-8?B?Y1NtN3BjT3VBdzN4ajViNlh4dEd2Z3FnL3pZd1liMnpGdnJuOGZMbmIwcytE?=
 =?utf-8?B?UENPQVVQai83RSs2aXh5RjdXQ2p6L2VZcHpDOE1NMnRrc2hhdmQ2OFl0b2g1?=
 =?utf-8?B?VUdRZlVFUFFHcjUxUFhHTWVkQ2ovdlJoaG1za2FldHZSTlNzbGlTd2RzdStx?=
 =?utf-8?B?S0hwSHMyc1VQbUFuVWVDU2VYTFJoanlVSTZ2VUF4WjNNNW4zU3ZJZnYxdnRE?=
 =?utf-8?B?OUNTMHNEeUZjUEJJNVEwWk1vZTl4NWVyY1V6TUhFL2g2MWx0MVRQdVd1Ui92?=
 =?utf-8?B?amFsTHJKazluek81eWszTUl0NVBybk1jcDgyVnQ5Y3FLd0VrKzViZTJaaXBs?=
 =?utf-8?B?SzNKMk9BeWJLSU9wVlY1ZzFhN043aG8zU3haUFhLRUdSbGJvc3NnTlY3S3N2?=
 =?utf-8?B?UjVReC9XcmM1cFJ2QUNkbnNkZmZncUlHRGFZNHpzLzcvdjdyQlJSc3ZHbEw3?=
 =?utf-8?B?Q25EUVU5QjJwSitzOVVRVEsxa0NpUEt5NzJjdlFqR2RveDlkSFVqQWRZWjE0?=
 =?utf-8?B?VmJkbmJUcXNjWTJpMTlFQmFCYXVCZ216dFBpeGs5R2x2MDVGYlNKdEpzai8y?=
 =?utf-8?B?RnFZZWRmdGgySWxZQWNpRjVpOS9HTVhhcHNxNnBsNDd4TlNvTDZldFhRWHcz?=
 =?utf-8?B?VDVRN04zazBTMFdsWTMzK2ljN0VJNlV5VSt2UkFTMUVmQVdXUmxtNFFVL2Vz?=
 =?utf-8?B?bFcvWVlsNkl0ejZWalRBclE5d1hRUWZaM1VoOVRjNGxPaVl0alY3dlBoQ1Vv?=
 =?utf-8?B?bDVFWkU5ZEZZSTJIM0tFa3gxUTJLQ1pGVHRMc0ZmRmJLckVldDZKeklacHUw?=
 =?utf-8?B?WllHa0pWMGlpOGxzaUpOckdFRTZsZDRUSkhyZmRyQU1FRUJoZ1VrT0JnL2Vw?=
 =?utf-8?B?WmtTVW5wN3h3YkZac0NBSXNySXo3enMrQll4SVlxNXYvWkhGWUZpNFNLL0VF?=
 =?utf-8?B?OVJpdWNBb1ZCV1FYUVpsVmNNVnZKelZmMnZtOGI0ZG9IaktRWi9aYmRNei9w?=
 =?utf-8?B?WmIwSmV6eERQSlFrNkF6SkhJNzdkZGs2Rm9kZXJ4cDdlVzBvbmZQd2JpcytO?=
 =?utf-8?B?OUxReDB6bnhiQTl3SHRtM2I4Tm5KKzFsa3NIdTB6NGQyNFNhZmJGQVdhNHdI?=
 =?utf-8?B?MEkzMHEzYnVLczBlV2cwVStaaW1JKzV6ZCtta3dUTVUyNUkyNmRqY3dxNFdz?=
 =?utf-8?B?Vi9lenVLU2hvRytWMW9EK2NPSG02UlJxUnFxYzgvdkN4ZDlKbTE2aVZ1YW5h?=
 =?utf-8?B?WTJZY2tIVGkwUDJHUTNoQUZsSkhKWWlzdkpPTnhJYjF0ci9iUG1IZXdTcVJa?=
 =?utf-8?B?T2tZaGNZTlhENnRjVlpDOHFUTy9jNDhuR2hidGJmVU1iOGNUSUZwUldlRGU2?=
 =?utf-8?B?bjhoY1ZHUGdXelcrK3VCWURkclFOQXh2NUtDRDJ3M2w3SStnNERPZVdkSzVL?=
 =?utf-8?B?WC9WVVA5b1J3Zlh4QXZiOGpGcEpnSTF4d3VwaCtFWndaV0xqNE5MamdhT1hs?=
 =?utf-8?B?MEtvYkRLUndQdVkwUE5RVldKYTAvNzFVWEZrNU02SzF6TDM3U29xcFJ5cEQ0?=
 =?utf-8?B?S1Q0Z2VYbkRjYTk2YWtEamVSbzEvVzN5RWFtekV2cHdIOUxkN1hjVnhoWmZ0?=
 =?utf-8?B?c3hCNHV3dnlXbFNJZE1iQVVKcFJMUlIyc3plbFVsUUdodHlRaWlOM1dwa3hQ?=
 =?utf-8?B?TldqYUIveTl0QUh4aml4YVVhTGRISVlrMjhSN0JXMVZVcFNtZVNTd2gvcVpY?=
 =?utf-8?B?aWRxakdoQWFJd2xrNEJGZTc3OTNJc01oTFRzZS9PZDBaNGFhb3VKQ1VmMGFy?=
 =?utf-8?Q?h6WyPiD6DUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThMZWVQNWRQSCs4WDUzcy85eEsyd0g0WjZJcUNiNnRIZEE2RDlFRERSRTFR?=
 =?utf-8?B?UHk3Vk56RWdRelFkWThNczZ0RFRWcFd1d01PYUt3M2l3VVVSdm52UmVmS3g4?=
 =?utf-8?B?aHhLN0lMZmdxclJWa2UxcDRlanFUaXgvd0psa1pBaFd4bFZIelVxbTJKTlVl?=
 =?utf-8?B?NFFGbmlGb2lKUWFpN1VPRGxsdjZYeUVWenJMdHJlS2R6QlZkdGZYU1BZSWpO?=
 =?utf-8?B?UEs3MU9Dbnk2ZHpkbFA4ek42Zjh2SzRsRTJ3bXRsNzFQVkp5VSszTFdTV3I3?=
 =?utf-8?B?Q2NKekpaam9LcnBMclc4aTZFM2l1NmhsWlF4eDdPTk1ZRU50TnhCL2NkS21B?=
 =?utf-8?B?KzRjWTB6ZTVJN3Jxd0pTT3RrZS9tTnFhV3gxd0swd2NDWTRva1JHdUhyYWVu?=
 =?utf-8?B?YjZpWGdyYVNmR1E1RnRXZ3JPN0xoazJ3cjBybzlLemNyVERTbXNaOXJ5d3I4?=
 =?utf-8?B?ay9ybnlYNU5NLytObmdzWW8vSHFxRGNjbzRMN0xUM1hweWFiSGJob3pnamRQ?=
 =?utf-8?B?R2FtQ0dvdGQ0QVQxcU4rTmZBR1BPeC9BT24xanVZTjRpdVBYUlg1VlFFd1kz?=
 =?utf-8?B?eVpHdkZ6N3N3YUcyOHY0T1EzbnIyZHdLZkYyV05kbzVrYnlGVVBQNTZtZk5w?=
 =?utf-8?B?WlBUV25aMm5pa09uUVo2cTc4MUNtSDhhVXp0aktzc055V09BZ2tPR2xFdTVZ?=
 =?utf-8?B?eWZGcUQ0cTFtbU9VT1dNY2xnd2lCSVFmT3hrZlBvV1kzWUFESnM4QjJWOFlr?=
 =?utf-8?B?UlVkMys5bXR5MG1kYk8zTkVFdVVPMFRGc25oNXFOSzByU2Qxbis1MHFYUmt0?=
 =?utf-8?B?T0ZXZURRc2ZxRlpqeTk3cnVKK3VCc0VIb0dBenZrY3JsVzdmTDdaVFNaM0R1?=
 =?utf-8?B?Sll2aVQ5YlpqQmJXVzRDWWl4b2g3MjJnNHB5aTV0L1ZDOHdtN1R5REFCUklO?=
 =?utf-8?B?dmY0cFZkRE5lL3BHMDdWQ1VLVHh5Q2p6bHdEY284aHgxVnppU0lUaTVidWlK?=
 =?utf-8?B?RG1laUF6WitWS0QwWGFScWN1VUxDWFgrY1I5LzVENi9lZnR6cmxDb0JjNlMx?=
 =?utf-8?B?c1J0bEh2TWhIVUcvbzR2NGd5UWdkZEFETjd3S1dNc0pkUVdub3R3RWRRZE1T?=
 =?utf-8?B?LzVXcjFJUWVhck9CbmxyQ3BRZDJybTA5ZDBVaGp0Rmlmdkt0aXlZcHJEMlg3?=
 =?utf-8?B?TXhmYXh5ODROOEwraUpaZEUrcGt3bzdDQnJoTHRpNFMxZlJIL3pCQXk0THJ5?=
 =?utf-8?B?Z2dab0dydEs3UmJzVWoycGJGMk4zY3IzVkRyZlU4R3FFVGIxdGZMZVVlcGFP?=
 =?utf-8?B?RUdxVzNLbXZpVFJHdFdLNkpCVEorQlpibnNqMDk5Uzd0RFVteVdiTms3Nk52?=
 =?utf-8?B?S1owYlh1YUEvWkF3bG1Vcld0SHE4aGpWNzRCdC96V0VOM1FubjQxc0RFMC9U?=
 =?utf-8?B?TnlpUU1yN3VLcG9lR3pBU2x5YWF5eXorb3hlS0FxbnZDTEFaSk9iSXRrQVNF?=
 =?utf-8?B?TVBGVUhWVStBY08yekh2N2ZJYTQ5QkdLbHZOck9RVzV0TVY5aDVWMjI2SXRH?=
 =?utf-8?B?Zkd0TUZ2T0UwTld4M1Q0MktLckdUSjBNd1M3RUtCdS9reDFPcjhwb2h2OWJq?=
 =?utf-8?B?ZW4vNC9jcDZZQ1llZTc1Qlc4MTVmc2prT25JRnBqZExtRi9zVjFmeDZFZkJv?=
 =?utf-8?B?Y2VrdXA1TjJHK2ZXaWN3UHp0ckpTcDBEQXVnZXdSTFErd0ZBbmNsTFBzTjZL?=
 =?utf-8?B?dEswYXFuYW9WUTFZbGViV0dJdmNDZXVpOERHdjduQUlYVmc5R0F0TkE5dHJT?=
 =?utf-8?B?VDgxa05rUWpZdXluakdmb1d6UitZeXM0cmdzdDVXY2FaUStyQVFyd2swWkhQ?=
 =?utf-8?B?SFVSc2U0OTRYbFJrRy9rb1BIVysrdXQxRWJZNnNHUlFITHd6ZDJ4Y0JVdERx?=
 =?utf-8?B?Z3F2M1FuUHFFMWNramFQUG5sREFXNVBGSllseElHcUxPYTJTeHJZVjhDQ0I2?=
 =?utf-8?B?eGZzWGErM2IzbDNSZHJtSi9YbjdtRldEZEh1U0w0Q2NIcUR0VTZpamtKKzN3?=
 =?utf-8?B?RUljSTN1LzY4NytPbzdBWXBJeDIwTnV4QjdvSWJkMzdRMmFEaGNDY0VlcnhC?=
 =?utf-8?Q?Cva84iUMOzFRL9pLrxIB5tDnP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da642c2-af50-4053-df7f-08ddfa86ef81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:52:41.1757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoGmSYWc4v+vAqOig78cIrH6JOryGkcTWcNFGge6uLhfwiKZxFr54SvL641MSyxbpZ5GASztUprFQYeNN4AADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Cc Christian

On 15. 09. 25 8:20, David Rosca wrote:
> Use correct u64 type.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 95e91d1dc58a..729f0f358398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -637,7 +637,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> -	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
> +	u32 *syncobj_handles, *timeline_handles, *bo_handles_read, *bo_handles_write;
> +	u64 *timeline_points;
>   	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
>   	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct drm_amdgpu_userq_wait *wait_info = data;
> @@ -682,7 +683,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -				      sizeof(u32) * num_points);
> +				      sizeof(u64) * num_points);
>   	if (IS_ERR(timeline_points)) {
>   		r = PTR_ERR(timeline_points);
>   		goto free_timeline_handles;
