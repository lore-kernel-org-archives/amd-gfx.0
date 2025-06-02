Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029A4C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 12:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A4410E2A0;
	Mon,  2 Jun 2025 12:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDJLSARg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AD310E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 12:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1k0RoRImSek8/HlpaK1tNCgxukSShOV2whT6cNTQ6BMHZFeJ95FrNa8kePBMZPaHqqkUDaV9kb/ry6+NZ2I+xn/q4HLO9xtn4vB61K/az1NVnjD0zWtMGTR26NKF01QPZriUqN8nbklHzYcVKwAo9vjZ07GwI/olqMWFCAd4iDPzj7DMGTWqQrOWKI5Ha0az93USHrPHt/KhS4ZLafDqIviTuT8NtdHiAE+7FuKTbpUtowHf90+aQzYS5EZiEiAF98uSFjy+lfV5PFrDDkPFlR1iU1b9VXRpb7YLrtBtMsRJ8UPK4Uf91XA4PphsqWSHLtDogxnptj80ZpJsE5wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHoL2qfYLe0eCW3+Bvi/xVtUJ3AcSB/O5bM2LjpoLZo=;
 b=dazz1VMwiFGebIUdkV//6fVak65KJByrO835tEobpcLS9LbJn8lCZlRxBBPBRk3LOjaNaqsNoPo/2mmcsiGYDv6PPWGmRuX2IT3kFlUWYuY5VVSdBrOGqVXMPqJI0xhhQ0mwfRz8p925xg2FrGBsAILy8ILsbnwxwP0r9N8hYA4UoJYHTsL+ARuiBY8KdN2xJF+UT3RXvzo3IEaE2wKMaumbVby7gUYHDxnhSvI9jdp8KoTtCEv2OsaGK1C7vzkEjilku5z4bpsVnvJjUea1vXlT6lSWRD3ErGRpLTDFTD7a/+D93pDvNt7H5ch5MBcmfQkNFPWYGBmWoXNFIT67Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHoL2qfYLe0eCW3+Bvi/xVtUJ3AcSB/O5bM2LjpoLZo=;
 b=VDJLSARgejIAVyQ8c4lA0p9FUMwCyycdGB/sIGiZgxTMWRZOv7wJ06E9x9l98aPfyHXRFtmxVJX5PKhzbG7fQnROoaiRQxFNIhy7s9kZCiChANotOZYwjZdfrKxedyzzBJ5WHBS+6Bi5qUeE1ya1/QkXIFpygkITRXc2TJVNmCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 12:47:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 12:47:47 +0000
Message-ID: <bacfb6ea-68bc-4581-a08c-c3019b558ce3@amd.com>
Date: Mon, 2 Jun 2025 14:47:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/28] drm/amdgpu/gfx7: drop reset_kgq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250529200758.6326-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ae00fe-35fb-48ed-4cec-08dda1d3acf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDNUTTNPZ2ZIQlhXSWs4WDk0QlJHenp2eGZpVG9MTktNSThQcjErOW9pUGZF?=
 =?utf-8?B?VmxuT29CSzdYZWlVOTVaai9lYXNVZEwwNS94a0dWZDVpWDg2bytxTmlPaVUy?=
 =?utf-8?B?aTgyL00ybllLR0JqNXkzd3EwVUFibUtUa0FzZm5FSWp3bEtsQ2J4dXRMZ3lU?=
 =?utf-8?B?SThKUHRya0NhdEF6ZXdlNDNvTVgyVWV4eFZ0REtJODJJWmJYdWNnN0c1OGQ3?=
 =?utf-8?B?UnhXaThMNlZRWUZOdmZQT204SnE3MWlmenFpZWZqMTN0Y1NCd1dJQ0F2QVhj?=
 =?utf-8?B?dk03SjFzNHdwWVJ6aUp0MXBpcDlQOU8vY3BtcTVFbS83cWdvQ0xwYlpjWnRK?=
 =?utf-8?B?cVIyT3VHRTB5Ly9nZWFXKzZ0Vmc4blQ3SVRJQ0xmcVVHK0RqbGxSOE9iT1Ar?=
 =?utf-8?B?NVZQWEk2ZzR0ZHRBUEpaZWZSVmhnRFRNbDY3Y2JSeHpXRCtCSjlDTmI2UjFJ?=
 =?utf-8?B?Q3lQalRicjNqbFZ4UjVlRFFyNUZpeGVNL2lGTTdYYnhKUkY0V2YxS2FiYkZT?=
 =?utf-8?B?cHRhZURZcnFmcFZKMzBaUEhSNmRmRkxpcmFMMXFWaVI0RlJZc3RtTDhKYmYx?=
 =?utf-8?B?ZUZOM1E1aHhFYi91WjdVWGI0RnRKMnJzRVpCMVRXN0h2QjY4eS9BOGpxYWlE?=
 =?utf-8?B?dWRoWU5haWh6ZUxNQUgzS3ArVjduZFpVV0pHVkpXOFYxOXBTUkk5bW83ZXdJ?=
 =?utf-8?B?QzNKZUhDcTR1eGhOQ2JVcmpZSUp3bzhpN2ZTL2dPeVBhVCt4cjVBQXVQSEJY?=
 =?utf-8?B?VGpUVmJpYjMvVlUrWUVFNUpUUWNialhoajBHL2h6QmZjT0JTZjVyUWRvaGlB?=
 =?utf-8?B?UUdCTk1jWXV5b0RlelcrZlUrTi96c21mUVBTcmU3bkFQMDBTSEtEZG9UT0tt?=
 =?utf-8?B?OWlNQXJGWGhvRnYwY0sybEY4bDJMQm84SXVUdllLVVpSaFdYaWg2Wkc2K2NM?=
 =?utf-8?B?YWZHWFdycW5IUWlWRHgxTWRKakpyWGlnVGxKakpwamMzOFRRNC8zWnMxY2t2?=
 =?utf-8?B?WHl3V2hWTk5SK3RMRGd4MXlJMHloOUxzU2hvSFdreHlSTnlFMFp4Nm5idE1u?=
 =?utf-8?B?elAwSWVLbUdZVmZLRHBBWnAwQUJTQlRpY3JiQjZzTG5zUWNiYUwzSmxLc24r?=
 =?utf-8?B?b2R1RG5ZQncrVVZqTjF0QTdhbmxFRWRBU2J0Z1VwaGRENzhZMlAzZm5vdHUx?=
 =?utf-8?B?Qm92N2U4N09ieGpoSWZBSURtR290MkRkUERHdDRGVlFINGQxVm5iUGd1dEk1?=
 =?utf-8?B?ekJQRURPUTBpNGxXeDV6NGdqY2JVZGkrZ1VwcWhnMVB5N2Iwamd0a0RNbCt3?=
 =?utf-8?B?ZzEyZHkwS3MxYmUweEFjTExVc3VybkRoaGpYVFNYcXJHWTByMHBUWUhVMW5D?=
 =?utf-8?B?QTZXbVk4SHRLMjg5RWE0andVczgybUMzbHpDV25VODEwZWo0ampJTWZ5aHpH?=
 =?utf-8?B?Mmd1WnFydGxSdnhnZ0g3cWJHMWV2SkoxNHN3ZVArSnhBZzM1UGtBd0gxUUtO?=
 =?utf-8?B?M2V3bS9nWEc4UExVcmhNNCtISDlEZzZpMXlzS3Q0VUthRHo0eTFqQ21WaTYy?=
 =?utf-8?B?QnFjaGNHSzVPQm9wQVhpanBVbk5YQVBYTkpNS0NTOU5HaWtaY1loakpVaTJY?=
 =?utf-8?B?MXJXT0ptaWF2MXlRNmk2R2xyRzhtTDFubEZ3cWdvK3lFLzdEL2lBREN6eFFJ?=
 =?utf-8?B?UjNPWTBRVm9Ya3hVWmtHVFhyQldDWkFxQXpuamRmNzF1dXBNUWlqek5wRDNV?=
 =?utf-8?B?cDc4ckR0blVzVHVSaVUvcFh5Vmt6Z1R2Zm1DVHA1OTJsL2NveHRUK0p1NnhT?=
 =?utf-8?B?cFZ2bzlpaVNyN0kvUVJYS1EzVW8rK29sQzE2L0ZLVDlMc2JnM3dBczA1Ykoz?=
 =?utf-8?B?aDJPYWM0NDJPOGQ1d2szR2ZoRm5WVTBVUnlibG0vTmlIQi96QjViM1JkVTBZ?=
 =?utf-8?Q?Wbq5L6VyKBY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmk3R1ZtMzlucEJ2eWhNdFpveWtxMDRSNTNCME1YcmVyRlliUktNT0RQQm5E?=
 =?utf-8?B?a1lick0wMEdPYzhUWTVzbXg2RWY5NEt5RklocmdUVjNMQjJBeVlKTUFUTFlR?=
 =?utf-8?B?RVBKcEdrWEZrVjlUSnFaSUJPWktMNzV2aGpYL2VSS0p3Q2JnbGE0UDVQQlNo?=
 =?utf-8?B?UGtJYlVTWXBhc1RZNHZQanFadlFrelNLNWVNZVNSSXR6L00zMnZyMHJreDB6?=
 =?utf-8?B?YkE4c2hVeWNyVlZFTVJmaWRsK284b0tRRGdoSWZxTVNXRVNaKzhWWkhrTzFt?=
 =?utf-8?B?dmIvcU1UcmdONmJ4RmxlbVRGckFQTlErTFhQcS9OeWFFbnJ0UTBoT1p1cGZI?=
 =?utf-8?B?K250OG9ZUXJocHhuVnBCclAyTDV5WUpPNnQ3VG1COGdyWWl3T09YTnZGWlZI?=
 =?utf-8?B?T3VqOVo0WU95djAwRmhpNFBWV2NNSDBmbjRrUFVOSDNiVlhnWHcvaitZaUly?=
 =?utf-8?B?K3BXaTFrYnNKam5xaVJqQy84VXdvYUFBWHViL2FtQXNXK3R6eG9FSERsdUgr?=
 =?utf-8?B?Ym1KSERadE9pWTluL3BrZUhqblJncDR6QnlBUml5bzd0RVgwandNYmo3VDU0?=
 =?utf-8?B?NGFRbXlBalJXMmE5WGc1WEF1cWlhSDlRd0RxUmwxNWNTZ2szVU9yMmxXc3Yx?=
 =?utf-8?B?QVJROHlnckpUQU1hS3pQZjJzcHhrQVJlL2xNZ2YxdXBtTytmdUdOeGpaZDVq?=
 =?utf-8?B?NVA2SEUwalFQZXZ3THVpaEY1bmxxQi83dEp2dlF0Qk9zeXBRdTA4VUpPbVdZ?=
 =?utf-8?B?d3NlQUhJWHc3WHk3bE1jZDNHRSsxY0s0NENCVVdwbmdLSGpaTUFjcWJqMEUw?=
 =?utf-8?B?Yklnd1lXVTZoZkRmdnN2REVETWNvL3lwdWUwc0hBU0lDazgxV2hBbHV0Qk9h?=
 =?utf-8?B?Z0lGM0EvcHJqTERLY3hpS0xKd2RzbDlHUnk4RkE3QWlFbkhqcEsxdGVIVXBi?=
 =?utf-8?B?Tk9HL1RadDFZVzcyNlcvMXlFYWxWR3U3aFg2SSsrMkxNcUR2SU5pMDNBT2RB?=
 =?utf-8?B?WDMyNlZzeXN2aDhtSzExazRYVlNqMXFVd1JtalU5TEhMSDZaNXQxSnNvZGNj?=
 =?utf-8?B?eDNKdWpTNWNBR1NpaVRCdnBMaU84OWJBaDNpMlQzWGlma2lCR1c4ZlozZi9G?=
 =?utf-8?B?QS9LR3dFREZnaFZWblZ5bSt4d3Q1U0ZyeGlOalFNRUFuRVRwMEluSWwwU1dX?=
 =?utf-8?B?L1dLYm1xM29TYmlySjRmN2NGdDMwNXdKNUQ3NnQvQi8zTHJKcmRoU1RtcVBR?=
 =?utf-8?B?Wkw0MHhjRzltSVdoRFRzYjRNbVJDL3cwL3dFR2RZaEpXVFJHcjJYV3VjTDVU?=
 =?utf-8?B?S3NJWlFicmRxMUFZcUtadlhaVXBhWHUxSnhBT2NNcFRLL3JuRlNEVVlvN0NL?=
 =?utf-8?B?UE9tZnQ1RlhrK3UxaFozUEIxT29PL3NIQTNGc0FtTzZibm1xeTRucW5vYmxO?=
 =?utf-8?B?MWRRYTY2VHJ4SlJmNjJIbEQ0NXZsSi84N3B1Q21aa2RZd09xSmVaRzh5aTAz?=
 =?utf-8?B?QU9JekhBK0NDNlRWM0p4QkVCUThDaXIyQ2w3ZzB2eHRaQklVT3g4dnJNajNS?=
 =?utf-8?B?OUxrenR2NWdyaHp0YTltUW5lTkIwTTFVbmZHNDNFbnEzdkllVW8ySnJSM3JN?=
 =?utf-8?B?SnhjZ1dSRHF3cFlCNFUyWm83aGFMVGJlYThDR1Q1ZUpMR09LTWZxcytDR051?=
 =?utf-8?B?VENGSk94b0xGMnJkeFNIWVBId0FsWjRlejZYbVFXRGlmZ3JYTGF3cUFDVWda?=
 =?utf-8?B?Q1d6cG5XODk3SExPNU5FOUJnY2s5WUJsSFRRZWdVdjJLZWl6TWhXemlBNXB4?=
 =?utf-8?B?aGtJaXl2SHpxMFcwV21ET2hUbW1PakVtQ0xwMW1KNHZmMDhNbHhZdHhJUFMz?=
 =?utf-8?B?KzNsMjhGQ3dFVXBZT3dIRy9sYjhzeStIamxsaEt1ZU9iY2Vkb0JKY09VU2JT?=
 =?utf-8?B?aS8vQ2VLVm5lOC91VDZrZlFER3dvZHFjYzNaVGdTemlSNndoazg5SU9xenND?=
 =?utf-8?B?QmRDWE9lYnRBVmo4Rnp2aWh6MU5IZTBNRVpRRzE0ZDNWRmJteUdDMC9UeVAz?=
 =?utf-8?B?UTR4UkVzN0JSZVROSEMvckgwb01EMWRFZHhMZUhiZWhUaytuUVlyTVFIMkxC?=
 =?utf-8?Q?B/ZcJiey/xWeP2V3Yo8ox2IsJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ae00fe-35fb-48ed-4cec-08dda1d3acf9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:47:47.0120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9iaBxRx62P14zaIK78RngM/PttvX5OwMQbRz+5RQwPthTvOG4E1ZMW/SMzTVheP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
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

On 5/29/25 22:07, Alex Deucher wrote:
> It doesn't work reliably and we have soft recover and
> full adapter reset so drop this.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I was really hoping that this would be more reliable than soft recovery at some point. And from my testing on gfx9 it seems to work rather reliable.

Are you sure we should just drop that?

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 71 ---------------------------
>  1 file changed, 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index da0534ff1271a..2aa323dab34e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4884,76 +4884,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
>  }
>  
> -static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
> -				  int mem_space, int opt, uint32_t addr0,
> -				  uint32_t addr1, uint32_t ref, uint32_t mask,
> -				  uint32_t inv)
> -{
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
> -	amdgpu_ring_write(ring,
> -			  /* memory (1) or register (0) */
> -			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
> -			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
> -			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
> -			   WAIT_REG_MEM_ENGINE(eng_sel)));
> -
> -	if (mem_space)
> -		BUG_ON(addr0 & 0x3); /* Dword align */
> -	amdgpu_ring_write(ring, addr0);
> -	amdgpu_ring_write(ring, addr1);
> -	amdgpu_ring_write(ring, ref);
> -	amdgpu_ring_write(ring, mask);
> -	amdgpu_ring_write(ring, inv); /* poll interval */
> -}
> -
> -static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> -					uint32_t val, uint32_t mask)
> -{
> -	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> -}
> -
> -static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -	struct amdgpu_ring *kiq_ring = &kiq->ring;
> -	unsigned long flags;
> -	u32 tmp;
> -	int r;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> -
> -	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -		return -EINVAL;
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -	if (amdgpu_ring_alloc(kiq_ring, 5)) {
> -		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -		return -ENOMEM;
> -	}
> -
> -	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> -	gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
> -	amdgpu_ring_commit(kiq_ring);
> -
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	r = amdgpu_ring_test_ring(kiq_ring);
> -	if (r)
> -		return r;
> -
> -	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
> -		return -ENOMEM;
> -	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
> -				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
> -	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> -	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
> -
> -	return amdgpu_ring_test_ring(ring);
> -}
> -
>  static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
>  	.name = "gfx_v7_0",
>  	.early_init = gfx_v7_0_early_init,
> @@ -5003,7 +4933,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
>  	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>  	.soft_recovery = gfx_v7_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
> -	.reset = gfx_v7_0_reset_kgq,
>  };
>  
>  static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {

