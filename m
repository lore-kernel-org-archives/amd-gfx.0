Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6B6CCF9EA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 05:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A1710E247;
	Thu, 30 Oct 2025 05:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VUoPtCu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D41E10E247
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 05:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+5vEsCj6v6OY88cMqzYNVqiZTv3QgYqDcELdAToSm8ttXpe/kMhgeRBmbD0ZrmxKGAuA2xwESD6+fVBTOXRmDIOsI6vyv5Qgr/jh4ajFeGdFHC1eBACt7/3zSg5fJE9Ab17xKVPg8971GLqYzO2SYTrx1Wr3XrBhVNPG8nU9zfGZMPsX7zz5Q3rqTZYtG43J6a8lbNInEe5WdlTPCisa9y4sv84t5HelZYhiZoJnhDSfl39zMh5YXcFtkLfskqZ80Uuajsu/E2qt7t7G7CaFjqQ/nZtVn2FG0HjWf/sHWRacLivfeyE6BVjdFZzb66Hx73wVkDAhlBuWvHeqom9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Bn/T/mYfCFKnu1m4u/ua6gs4tM1j6EEFCoBvFDfpY=;
 b=SZwBBkZfKhhrmbmk0amXOmgWIYANsggqkreVjXO3da7r9mV++aexg3RoammlHuO7RqT1+q9WWO0Om7rNkkRp4mF84E28zxoOA1NjZ/x2W8pyEx467NU5zlyB2w8vXCR0ROI3WMW4tADIAfYXtTzua1SL4Yj+/6LZT/UqpvBBEck9fHlU8BNRCLQbpTcE9mjp2hrNrSnjrhprej73EZm+sTFVMM1ftLOEBlCup641YNg94xmawyLt9SJTCNHyTJnBAG8KdsIVbYXVTEpZbdocFt5SJzRAB1Ep5f2w0NyFW0M2A5en70954EwudgzXC9Dnl6kYfoNdFUPTsbOaFTTclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Bn/T/mYfCFKnu1m4u/ua6gs4tM1j6EEFCoBvFDfpY=;
 b=3VUoPtCuOC2agjv0W9+NbhZEPIB+59QBU0mld3ceXc2uQ/q0/SdIldVO0jlGZGweAgrkoo4OQItq2k2E91REa4SegRBEYASNmEGCJWGTfNBVikC4hlOtmLv6LB8N3KnsADcFNGLV0i+I9YEcmqjriyJ7fyDqFtjq1/BvaN4q93Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 05:21:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 05:21:08 +0000
Message-ID: <087e7bcb-712b-4f6e-99d6-b7f4b604bdfa@amd.com>
Date: Thu, 30 Oct 2025 10:51:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix missing device_attr cleanup in
 amdgpu_pm_sysfs_init()
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251030051110.1441129-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251030051110.1441129-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7c569d-05ce-4da4-6265-08de17742135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmFrQnBKdk12NVlTbXVqMjJ3QVVXZXZaTHVTcGhWazYzVHNrNzl3N3BSYWJv?=
 =?utf-8?B?TFZWdXpHVkFzUGhTTUxxUWlsRzdlWWtPaXFGR1Z5WWJmd0NhQjJmL1h3elli?=
 =?utf-8?B?d0ZDcU53cU1oanR5QUpjazE3RDdiZ0pIeU5RM21NckMzN0V6dXFOR0pDaGJD?=
 =?utf-8?B?RlMzTEhRZ21FUWJkRUxaVDhaeUhrUlpCR0R5TEI5UlJpbGdUWjNmMUhiZm5K?=
 =?utf-8?B?NUFaLzM2R3RKTTBHSzdLSGxyNnhvQ0d1ajBnUzlkUkpCT3Z4MDk4WTNsMGdX?=
 =?utf-8?B?WEV0WDNhekdLbHEzUEh3Nk5yUVlXNitHNGNyRHp3RStxTHlkN0NFMGptVmp3?=
 =?utf-8?B?cTVTRmI0S2ROL2ZtVDJVMTlhQW42c29rQ2VXSm5XVFBvYlhxZkZSRXRsV093?=
 =?utf-8?B?SXNVdmt1djhiQzJWeDR2ay9wVmtwMm53TzNqaEZsWEw0WGlWNVZGKzRPNHlS?=
 =?utf-8?B?WWtQL1BwUFV6ekRNRnI4MTQxTEVnd2E1RkliZnU5ZFNiQkkvVjhaL2h4cngz?=
 =?utf-8?B?WnNsbDNBRmJOYVptWU5NSTdxNkt3czk3TWN0WkZQeFl0UWZvQXBiU3g5bmUw?=
 =?utf-8?B?NWdaMVBJdnV3OWRaMEo0ZDY4Q2xhMm0vWXI2WVJTL25pOUxYTTZVVzlJYmFS?=
 =?utf-8?B?ZFdIRFcxNWRHL3ZVZXFWRlJ2YUZoaWZON1BianRvTEU0aWZhendzUEJwTVJ1?=
 =?utf-8?B?T2ZRWWZ1MDNNNXFZWUplZFVJcUJrYU1VN2lSNUp3ekllc0NoZnlCZ3I2ckJH?=
 =?utf-8?B?L05lSHBaVEZ6THN5eG1GWVRBK1RyWklzUVVyUTFwYUdTRW8vYVlIWnAvMnBj?=
 =?utf-8?B?V1V4S0hNV1VIakZLN3d0d2dtV25TTlFWdjlMTGZrdXpmLzlFVTFHR1VGMjc2?=
 =?utf-8?B?NVV1eVRmWWsrdVFhRlNlK2NRNmUzME9aMGlXMDVmeXNnZ2U3Z1lhZ3pmZ0dh?=
 =?utf-8?B?VElNMFJFZE9PL1BJWm5OcjVkM3B2d21iK0R0Kzg4M3hFRDBGcm53NUxPZ2ZV?=
 =?utf-8?B?YXh6WXlPc3ByamFUakpyUEFJM3VSMEJWQWJmc1dsbXE2UFRhV0t2NzVycC9s?=
 =?utf-8?B?RzZXaEhmMGE5d0MrL3R4cmg3bXJVUmtPY3FhTmxHWlM5Unl1UmFEV3cyY1cz?=
 =?utf-8?B?MFc3U1NmdXVNT1hTb05QNDlBMlNETFFtY3ZSeG1LOHJIb2hVK2I2Y1NpY3RQ?=
 =?utf-8?B?bzlwOVVTbE9Pc0tNZ3JyaDlqeU9McmR5WmNFYkFBVVpYRzFPQ1ZpTi9nd0pL?=
 =?utf-8?B?K3U2M3ZBWTlTalFGbXE0Y0xBKzZHTWpWSXNlOEdFblM0Q0lpNFE0NWo2WGZM?=
 =?utf-8?B?SW1KOWJuOHN5L1VUSzJtdklIYXpSd2ZIWnYybi8rNHFVY1NKd0hMSzluRXJO?=
 =?utf-8?B?RTBWQVRYaWJmQTY3RzVUTExxUHhRVGpYNzV6aG5EaU5KUzRQM3hvakNhWG9X?=
 =?utf-8?B?aW9ubDFaMTZ4Y1E5ekFienY5UDJMWUxHRktBYmt0Mkc4OUNML29oVmp2NmFJ?=
 =?utf-8?B?ZVNmcThKQkxMS2s5bHlPMXY1dkdRdFVkZzhoQVBQS2ZpWk1OTmRjd3VnNmxm?=
 =?utf-8?B?aGQxYkMyczZBWStrODkzSGZOaDB1RnpEajZ5V1R1cWZWRmR0aXNaOThNd01x?=
 =?utf-8?B?NElKdExNTmZaQjQ0QnJWY1lnZGllMVY0VHM5Q1RySEpQbU4veTZxNzNZeHhH?=
 =?utf-8?B?VmhxL2dzK2MwMG5UeE1NTVBkQzc2VFB0elBqMVpSVXZISno4Z0ROa2svNVZS?=
 =?utf-8?B?R1VmVUhiek4xNjhDby9nK3pZeUYwVWYxUDhUMncrYkQ4T051ZjhKT1dKdzM0?=
 =?utf-8?B?eFovNXUxekkzRXFnUWF0dEJJbGZ0RmpGbVpXLzRNNFk1dkQvK2llUkpEYTZY?=
 =?utf-8?B?S01Qa2szOFBiQUhVOVB6Z1Bma0pTQ2pZNG5xL0gyL3FmVXgrYzVMZG04OC9Q?=
 =?utf-8?Q?JT6WfS7/ozZxTCvjuHOJMa6r2/4VfQhi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW9ZY1htVitOM1ZLMGVRNVExV1RkY1BiYmVPbWpvQ01OeWNZYVhuQzh0WU5i?=
 =?utf-8?B?Z0cyUGMvNUo3bFo0TTJmb05DS005MDRhWVI1djNMRTRFdWd3MHRWR1h1SC9o?=
 =?utf-8?B?eStvZmhNL05Sa0dXREpkRnpuYUZvRklHcGN3WVZiUDdqeFJ2RFFIeHVlR1dw?=
 =?utf-8?B?cFo1bitIMHdYTnRHbzJiMFBOSHJCUHBRYzVhbmtHQlgxRUZMNk5sVzRHVlF3?=
 =?utf-8?B?ckFQcXRGZUhYaC9WV3FDOGRUNFdUbHBYWXI5UHpmMTVrVHZKbC9WbllNVUdw?=
 =?utf-8?B?VStwdWtVRzZqaXZhckRJaXdselFiMnN3WVJEYkl5WWRna2l0SVI1NHR0U0dh?=
 =?utf-8?B?VmVMYTluTDU1V3M3a2R3YnBOajBXemp4cVlUeUN0cnBlbmoyK3ZBWXlNSGNE?=
 =?utf-8?B?aG1jZERldTQ4RTllN2FRakZKM3cxc0lCMnhVZU9SMzk2Nkk5aFNYcFByWC9B?=
 =?utf-8?B?emNua0NGT1pEN0Z4SGpDQUtJalcvR3pJaFRlZm5ycDJiaThuWnNVVmhxVkY2?=
 =?utf-8?B?VXRjdzJ4NFpjUkw1ZXM5T1ZBeDJPUHdLcGFoRkhESk4rM0dkOWhCNWFXdHE0?=
 =?utf-8?B?OHg3dUJZaDBjTGJlcEhzdkJ3R3dqdG5qWUZqZGdOZUJDb1BBdjFpNTRHQWEz?=
 =?utf-8?B?eEc0TGZscWhveEFkaUVXcFhETEtnKytrMFBLbjF1SEpLaFh0TEducjg2N3Y4?=
 =?utf-8?B?RXFpWkRWdHV2bzdVdFJRTEFhRmxvMUNBM0NvTUp3TzhkM1hWaldSZGRXRmdO?=
 =?utf-8?B?bzdEOTNySUxVSUVPL00xK3VNdlB4QUZUNDhSaUtKMktHUExpTnlHSmtaRDBD?=
 =?utf-8?B?UFUwKzlsUzFxa2tGd3NVWkdQQ01PbjYxdTVSdkV5SHgrZDRNMTRIZk5FRjlM?=
 =?utf-8?B?bFF6eFJtQ08xZW5YYnY2UTNWcm5MNnI5M2RNVkJoY2VHbHBLMC9Gbmh1bXZB?=
 =?utf-8?B?eG14RXZYUGhTZCswZnBFM0p4TjJQY1BZM25qY09rMzRubWdBUmd4YVpodXlk?=
 =?utf-8?B?em5nUjZoNExLbzY5K1pQN2taUkhkMTBsTVEwdHNMMk8vNDlhWjZrdTZYcGwz?=
 =?utf-8?B?VVNMUmN1MEVnRUtoVndEdkt0Z2w4UEcwMlJmNGExeUpVMVNjREF2WTNlTWJZ?=
 =?utf-8?B?R1p6c1o4Vk96d081Nkk5NFc4NHJyckhGNExDbXo1a2Z6SUNtVDhRVldrUEho?=
 =?utf-8?B?Y25zd3ZlN2gvT2k1K1FvTUJnZENuR1hGYXZxZWRjdE1ueGFrcEdqMTg3WHZh?=
 =?utf-8?B?UGpOS2Zld3dIZFkzbWZLWS9GSDFxV2dRYlJrZ3JjWmhRZHd2MzNtdnJzR0NM?=
 =?utf-8?B?Qy9BOEJkUS8yK0J6V2ZwTnFmTFFxUmVObnluVTNtVzVhNUxiTjhsNnYwRHFE?=
 =?utf-8?B?MDQ5RjlUdXp4bEYrUnlVSy9BVXlUOVVUM281N2hzRmtUamtJME03aWlRWlBq?=
 =?utf-8?B?UnlOMCtPRjkwdVZIU0dIamR0MVUwN1ZoMjhXWWRIL2l1Vzc2RlF1UkhyZElR?=
 =?utf-8?B?NkJzVHRNR3RFcEt4RlR1cXF4dnlTbm5BNXpVNCtJc2k0QmVPM09TYjZxWllJ?=
 =?utf-8?B?WlBBd2tXWitLcHJHd25xZ2wrU05WZE5kMktJR2xudjA2Z0RoLzMweXZvN3cv?=
 =?utf-8?B?MmMwbENwd3pnQ01BNkRLeVU0SmVmTW1qSHFHekdXN09OYVBEY0NsVXdkNFJh?=
 =?utf-8?B?dFJ3YVVtMGt6cHUyQlVRcFBIeVdDK0hHakxndTgwTDROL2xZWGNWR1BMMjVq?=
 =?utf-8?B?OWxhTGRVS0FlK1krbVczNU1wRUJ3aHJreVo3U3RNUXQxc0ZVN1JVNW9CR242?=
 =?utf-8?B?Zzdpb3dtTDcyVUNVK3BLVUdHcy8rcjN6K1F6SXJvK1FXRkZYVUMxVDRlKzYv?=
 =?utf-8?B?eXIzRUtHQnhXbGprdkdIRUVhQmpKVm9ZV24rTmkxa3dYRU5sQUNrYndnb25X?=
 =?utf-8?B?RzhRZmJMN0RjSElvQ3A3SndubUMrc2Q3WjRwaUd0WU5STHdyeFhzYldBUUpO?=
 =?utf-8?B?czI5UEpPcERuelUxU29sQUU1VjVIRURHZHRka3hCNURVNnhZVC9sRDl5M1o2?=
 =?utf-8?B?MDRLdGdKV2REQ2pRUmVJMmdQWk9DZ0xic3NrbVJlNjFwU01Bc2Y2emVnMU9X?=
 =?utf-8?Q?RHUgalrw39zPaGNIvfveUdXjr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7c569d-05ce-4da4-6265-08de17742135
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:21:07.8151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pc1uzpMyPlzdOC4nPTBKuV/vez+O4g8LxbJihJ+cAwSdl5AE8N8PffYi1bhjyQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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



On 10/30/2025 10:41 AM, Yang Wang wrote:
> Use the correct label to complete all cleanup work.
> 
> Fixes: 4d154b1ca580f ("drm/amd/pm: Add support for DPM policies")
> Fixes: d2e690ff5d3cf ("drm/amd/pm: Add temperature metrics sysfs entry")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 3ce9b862e6ed..f9edb80133dc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -4739,14 +4739,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   		ret = devm_device_add_group(adev->dev,
>   					    &amdgpu_pm_policy_attr_group);
>   		if (ret)
> -			goto err_out0;
> +			goto err_out1;
>   	}
>   
>   	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
>   		ret = devm_device_add_group(adev->dev,
>   					    &amdgpu_board_attr_group);
>   		if (ret)
> -			goto err_out0;
> +			goto err_out1;
>   		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
>   						 (void *)&tmp) != -EOPNOTSUPP) {
>   			sysfs_add_file_to_group(&adev->dev->kobj,

