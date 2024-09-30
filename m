Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CECCCF64A3
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0F210E440;
	Mon, 30 Sep 2024 12:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y071Vntl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1185410E440
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMdyd+VBDUgwEOwYgnWAyzpNsMvkWW25ubaZY4J21O7IwPz1CCcMeirV9gy/aQYSwf+ith2Fk8zkhoOOfC0HLA7sqr45AgNtmDOfV1PraFHcWD3G4vwKf2HQT/Aaz2UEVAkDA3KPLiOfEntnOoRRi/0CfNhkBh6Vw1TPuowpA/fJ3k03wesSjIsLSr59QEZg5/Zda5trIpIL7SU779HWe8gPa7tb3cVlvCKp50IZ49VXnBPlV18mRMdPONCbqALtWHBXPQnA2ovIe89o+jZF/Oumyr0mTP8jaybczwGChgc0Cp8nlgVru8T8zchnt7+Zhwx06RoIddXYz5FHMyx//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m323C1aMjefVt/U48RxABtH78tlpDTu2OYfmBwtEM94=;
 b=D/Ojl6dB1cTmYSsOWpwN/dXTNgm0HVnvEI53w1ZecGR1aEJtblcUkkAi27WBfH5VHkUI5n0PHrEwhykIp3/5qfSzISbUUhL+c72q8NX2LVF/H/wBnvI2Euc70T3T/TfKjYgKDuDQF8VS1pQ55Lv+B8MFDJyag2logzwJ45Boh5Zt7uDUckyIm/qKcdQ4F0AIXbzNw+aJAVGWhqtpdRXVNaY2p9H5jJDadS+jRMeNX7ZaZFgpy0hHcH4QpyMFYhT7aewYdco5HJoSkoU59iInoLuniEXemR+af6au2713vc/8ui5g/81HwqF8NfHlOgXTNByLtGMCqYV/Bhda2VTggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m323C1aMjefVt/U48RxABtH78tlpDTu2OYfmBwtEM94=;
 b=Y071Vntl08W9W0E5CO5wsq5rt9K0ye7ahjpCNIuFpFApO7FNRNpaSr1fsDUMu/wczJVHCtBDifJCT0B4/CnL/xEMsas28mf41S0n7uUevNfTWt2nfvInCdtI+r3FF88yxQbhq3LhW9YUXJG1IXauIpImI9xjqcQPT3ghAaoowpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Mon, 30 Sep
 2024 12:50:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 12:50:42 +0000
Message-ID: <ed092330-de43-4aaf-8448-a1baee333775@amd.com>
Date: Mon, 30 Sep 2024 14:50:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/09] drm/amdgpu: add vm root BO lock before accessing
 the vm
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
 <20240930115906.191060-8-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240930115906.191060-8-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: f677ebe6-3e1d-4aed-5067-08dce14e7e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QURVekxLdnQyVzFuYzIvZldDdjdNN20yWERBMTAwR1Y1aHNtR2kyaHBlVUhv?=
 =?utf-8?B?OEkyaDhXdGkxeWVWQkJvV3NYQld4MjR6ZVpEZG1ScmQ4MWJBYTE3RTFCN2Zt?=
 =?utf-8?B?UVFrVU04TzRjRlJZZUFaa0U5TG82N1dta0pBdWxneDJuakEwQzJQY1BFTjVw?=
 =?utf-8?B?MHVTU2VxSFIzOEtMaW9LSUFoNlpLQ1RsaDB3ZjhmaVF3bVNFV0k1ckxCSUZS?=
 =?utf-8?B?VkRGZU15TXVwU09La0Q5MjZFOXpsbk9XMFNuWHdaRS9MaTNQaWxXcmViaHFx?=
 =?utf-8?B?KzNiL2FjVXo2QlEwVVZrMU9sMzJNTUlqWEozQ3d6Y0o1MFNuZVcxbWZSbDVu?=
 =?utf-8?B?TDlYODNzNkw2UW5UNVFsVDYrMWRDZWFsQUEraGlGNzFGOU5zcUxHWmtjQUZ2?=
 =?utf-8?B?bTFhMCtmSElXU0ZzeDNlUjk3SW1mcW9RQzhuS3paeG92ak1oS0NhQUx2RTEy?=
 =?utf-8?B?bWp3U3Q1c0pYNTJ4ampTRCtwcXViWHNxNmYvc1dXK2RxTG1DOWpTOWF4dW41?=
 =?utf-8?B?a3h6NkdvTDFoUEpPcCtuaGd5OGxtd0RRWVpOeFVJV2NPM0tQWWNEZG5HcWph?=
 =?utf-8?B?Mi9zQmhJd1Z4TjRueFpkaGdxZ1dwSnY5aTdKMXAydWpsbHBtUkZkb21uWE1D?=
 =?utf-8?B?dGlqUXNkQlBiL3JwaGNoRkNHcGxoZ3NKeFNqeVFkVnVNR2xYMXFHQnZKcDlQ?=
 =?utf-8?B?anBuTFp6aWtjSVFaVkpFU2dIdG9jNVptMERkWVg0SmUvS2VqNVVuQ2FGTGZz?=
 =?utf-8?B?anlJZXBXZ3Q4dklJNWJsaHdPQi82RDQ1bi9kSXoycmYrVy9BMHNub21rMTRF?=
 =?utf-8?B?UzVKdlhKd2ppYjJTRzBabCtFR3E0RzllcHpvSHp2Z1RuaHRLQ2lQZzh0REQv?=
 =?utf-8?B?S3RuUjlJSjFnT2R0UHVQVjdDK0xqdVhCc3gwRUlSdHo2a3pQMFJ6YnVaVFdv?=
 =?utf-8?B?UXk5SmF2Z09ySkhwZ2l3TFV3TkNXbkoyN0M0TFNKb3kwcGtkVmVVd3doQWRu?=
 =?utf-8?B?TXUxRXNxOUZocjJoK0UrdEJvcVdqUEVHeFZYVGt5MDFuUTVwVTZzZ09QMlFM?=
 =?utf-8?B?RVlrKzRwcytmTFZvVllaWEoxMkxyOEZWSDl5UHQyWFM1c25aM1FsN3NSY3BM?=
 =?utf-8?B?SzZTTHZiTUZoKzhzYWJ0djFSMWxwVnFaZFVleGdTU1NaWmIxL0NkdERERGp2?=
 =?utf-8?B?QllOc285RUZ6bWJzRFppdWhuNCsza25kZHQrcXgzM3BabEFTNjJDS2IwaVBz?=
 =?utf-8?B?S3RjdTJNU1NKRkJDSlNzQllDbzN5MDlNeGhtUUkwU0kxaDB5R2FDbHkxZlFC?=
 =?utf-8?B?ak5SbmVxRnY0eXJYZGxUcnBMSjE5dzNscGZBMmcvSHNwU3BCeTMyUytSc2th?=
 =?utf-8?B?SkxaYjloM2tBOE45ZHhSUkpCRmxJWFJSM2taMUZVYTgvaWhTSUl3bmFhNlNH?=
 =?utf-8?B?aW9XMmtKY3ZoVXdsT0VxUmxKWWpYcENsUkVzY1YwQ056Wnh3Z0puODJGSFFW?=
 =?utf-8?B?c294b3FrelRXYVQwRUIvalV0VjNPK21UMjhXRE91Y2dtUG41OERXVHBtOFVx?=
 =?utf-8?B?Q0QzbE1XWGo2eHBIVTV5dUkxbFp4V2JjL0dqUUJ5NEt0NitwL0pMZXVtaXpl?=
 =?utf-8?B?SzRlOWRva0lOb2hkdTM2djBNcTZpb3JaaFQra0JadEREdnpIN1F4TFdpY1Jj?=
 =?utf-8?B?bVJBK0VxdGVkWGJYbVVhU05laWdvS0l4cDlHRnpwa01DeG1xWnZQK25RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJYTVl3S2hxSVlINCs5VEFOaDFrS0RZQ3JYUXBudi8zRWVOYmZSd3JDSTU3?=
 =?utf-8?B?VjhRdUxWb05tbDMxSXFTWUkwRXpwTS9uVE1XUWZ0NzVYM3FVMktDRzkvWUFt?=
 =?utf-8?B?blhUYjYrOWg1V2VlNFNoSXRFVDVyWGlxY0ppanlZMzlseTlzcmNqN0VMZzF1?=
 =?utf-8?B?VzZLNXY5Ni9LNW1wOEtqVEJhZUxmWkM5bDJTRWZPcU4ydEZaSzM4TytMemtQ?=
 =?utf-8?B?bnpzOU5GV2d3N2hSMGk4QWROVUtSb2QvYm12NG02Kyt2MGpwdlgrOXE3UTBR?=
 =?utf-8?B?YzlXVWEyS0NYOGdkSGpxUmNyNlA4WFdrblhMNUdvclNsVTJzS0oyU1JwYndx?=
 =?utf-8?B?NS90c0p1Y0Myc0wrUHN0aGp4OXV0RzFNZnppMzFCSmk1clFSSE5vRSs1dy9X?=
 =?utf-8?B?S0NSdGR4bWtVSXJveTJTSGszVlNaZ3kydzZVQlVaU2QwWHExZnovb3Q3ekpY?=
 =?utf-8?B?aFZwcnJ2alZKaTZSRjFPRXRneFBwL3FuVEkzcXpKSWV5dnhyK1BZU3h6NTNI?=
 =?utf-8?B?TTVBUWUyQWdaZkN1cWxyek85bmlROFZKU1pQS1dlQXlucURyWnRDMGVibXlu?=
 =?utf-8?B?WFdTWXkxbVFMbHNTamYzZlN1VmljYzlCcTZqYXZHODIrOVlGejhCT3Jwcjdy?=
 =?utf-8?B?dDZHQjRrMXBvZjhBSk81VkpHUExCcFU0ZTdOTzM3dGIvclcyODdhTEZScmhm?=
 =?utf-8?B?NGFDN3lCVldPbnN3RnVKRmlmV212bXBmQzNXaElqTFJYT1dRQzdsYnlDNEFt?=
 =?utf-8?B?RzZXdHlhVHVhU3lQNExUYWJDK3dDTWZacGNWakMremlyRVhYaWVxcGM4Yld0?=
 =?utf-8?B?NDhBTElLTEVUVXl4L0ltVlBNVTlMRkJINHBnM1lnU2Y2MCs1Zm9wVWZJV1U2?=
 =?utf-8?B?dVpWZmRUWXBZMHlwaVlTRXA1aTZJNWo1MWJrVG0zQnhGR0ZhTE5nZUJUZmZi?=
 =?utf-8?B?aXdpdFhNQlJta0w3SVlUN2d1QjNOc1dGRnphd3ZiYnREeG9ObGdubnlNTU0r?=
 =?utf-8?B?c2daeWJGNGlLYXZBUkZaV0JLNHNNcTBDSlVqbm1JbWthOXpFa1hKSVlhZU90?=
 =?utf-8?B?cTB1a2xKQUt4WnM0aTYwQk03NTVoZzllaElGS2ZKdE00WlljUTNiQUc2Z1JU?=
 =?utf-8?B?d1BNam01UnozVXFTK3lSL2RHTlJwOHVzL3VqeEFkT1BhY0lhY1o0VG41RnBJ?=
 =?utf-8?B?YTN0M2hPWW1DWXUvSFlGKzBXOEVNUW9SeUxVVVNDWExjeEd4SGtuTXlrMlRM?=
 =?utf-8?B?VWhXL2hGV2UzVXBsYXBqeVhIL05ZdFgvZlpSMk9peUZJdkdhTlNoU2FWRGJC?=
 =?utf-8?B?QzE0TmdjOVJaY2NhTUJwKzFjbFlwbEpjd0k4MXd2MmpNSjlqRHdLcHVNbmJq?=
 =?utf-8?B?TXVDdlNqWlM0UGJ2L21iNFZyTVljWm1rOGg4YUVkaUlENFU0dWJGYkJnV0JN?=
 =?utf-8?B?QWhIZWhJUUxpelkvdXZnS2dONTlSWExTMHEwNU9BRkNDa3pMVFhJaStQM055?=
 =?utf-8?B?VWE3eDlZMTN1aE9vV2xBQS90MmJtMG8xejhJZjU5clpEV1JJcFMxajNrOE1V?=
 =?utf-8?B?RitsOHFzdEVKQUJjUTlpTG82MFcxdklORWNFaHVHNUZyM01wbGZrd3VJcEpz?=
 =?utf-8?B?NGR5bnNaV2I0YzBKd1Ayb1dqNDVXTDhGOExZaGR3Yk05VzkxOFA5RVRNVEwx?=
 =?utf-8?B?cXZIMGxzd2tvQW9RdlhjTlJsVFl3WlRhVFJIRGhOR0hNWmNXU01vY1lzOE94?=
 =?utf-8?B?NHhSYjdKN2tNa3dpd28wL3dPK1Mrc2owRnBBU0xReWZTU1VHeDFqazRNZkpi?=
 =?utf-8?B?TFlYWXlGbkhKbnV1aUE1UXErRFp4ekdNU3NqcGcxd1Fhc1NGOExXL3Uyd3g5?=
 =?utf-8?B?by9oaXU1ZjdSSFhtU2M2ZlhNbDZTVFVrYlY1Z1czYU5Fd2dOM1ljZHVCUU5Q?=
 =?utf-8?B?K0FIdW1FZXZ5MVBVQWZwRzd1eEc0ZTc1OW1GN1RMWEhNMDhDUEZXZGovMlJz?=
 =?utf-8?B?TUUvZmsrMjN6aXY4QzBXNmtNZzVadjlydWZuRk11QnFVVHdnMXdJQjBZMk94?=
 =?utf-8?B?YmpncTBLUVpUNW91VDVoOW1aMWxyUFZsMnlIWHBQeGYzcThkTlhpVlVnVUta?=
 =?utf-8?Q?3ISk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f677ebe6-3e1d-4aed-5067-08dce14e7e44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:50:42.2802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPQPB2VT5P6m9iSHAPiVsaHiSP1tR9YPiY/GBL4A8jVdTOmjlQ97ljnk5WjM4nH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

Am 30.09.24 um 13:59 schrieb Arunpravin Paneer Selvam:
> Add a vm root BO lock before accessing the userqueue VM.
>
> v1:(Christian)
>     - Keep the VM locked until you are done with the mapping.
>     - Grab a temporary BO reference, drop the VM lock and acquire the BO.
>       When you are done with everything just drop the BO lock and
>       then the temporary BO reference.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 ++++++++++++-------
>   1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 9ca1910d7a62..0725f28f3484 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -321,7 +321,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   /**
>    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>    *
> - * @filp: drm file private data structure
>    * @queue: user mode queue structure pointer
>    * @wptr: write pointer value
>    *
> @@ -331,25 +330,29 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>    *
>    * Returns wptr value on success, error on failure.
>    */
> -static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> -					struct amdgpu_usermode_queue *queue,
> +static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
>   					u64 *wptr)
>   {
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_bo_va_mapping *mapping;
> -	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo *bo;
>   	u64 addr, *ptr;
>   	int r;
>   
> +	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +	if (r)
> +		return r;
> +
>   	addr = queue->userq_prop->wptr_gpu_addr;
>   	addr &= AMDGPU_GMC_HOLE_MASK;
>   
> -	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
> -	if (!mapping)
> +	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> +	if (!mapping) {
> +		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
>   		return -EINVAL;
> +	}
>   
> -	bo = mapping->bo_va->base.bo;
> +	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
> +	amdgpu_bo_unreserve(queue->vm->root.bo);
>   	r = amdgpu_bo_reserve(bo, true);
>   	if (r) {
>   		DRM_ERROR("Failed to reserve userqueue wptr bo");
> @@ -366,11 +369,14 @@ static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
>   
>   	amdgpu_bo_kunmap(bo);
>   	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_unref(&bo);
>   
>   	return 0;
>   
>   map_error:
>   	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_unref(&bo);
> +
>   	return r;
>   }
>   
> @@ -449,7 +455,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		goto exec_fini;
>   	}
>   
> -	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
>   	if (r)
>   		goto exec_fini;
>   

