Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD8ECCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3390E10E26F;
	Fri, 10 Oct 2025 08:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzdOobSe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33DDE10E26F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkq524uMR9entggNow3J9J+fLZOsLoksEr6BvlIeHdJLiKBWNBQopigB8laH/q73egWZNX2pJ3CFAfX2+sKxMgaDkLEpVXwkIjMAl5xY2c3cBSi6XbmTIgB5qxxFl+Qj9lznXwue2s9z81sPLXO717xT0SEtmpBBDmDAjDO30/3QqaHENJBtBlinpAENshlc7SPrk97L5b6xOUpr22waTc6su2dbaLTVtkEpdro4MCF0C+9cPBmjyM4n1CDZ+5JZzeEFr4uuAAISD1Aha/UUmobqFsesZJFtHHsTTwhUVeCCRxCMR4pCOkMLg4sB17+K0zTOH66djKzVJG7etvAQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8bzFLG3YVicato8AePmOZ3wHz3F3pe5OkMGY8QiFCw=;
 b=x0vl2jvNxftda2feyxf4FEt35/lOkuEOuujku6p2KSS50wVH6a7Fgd3CK9fHP6wII1ICBC0kTukRSHyV85ePNUSXn6fhGZHoNSGVpUiuu30daOXShcDuDumqmDaIxDdWB3OhKanjeC3tWaGlurEfhWpvSgO1ImT1FPM62AASoeQQ3GIH5ys5v2asb4m87MqFBYFUFojN0pkCrRVTZ0ALIancfvZkTxjfcXfJa5v6E8h/x5/DZCG1X3VS5x48MwwnJmTNWq4tY1htvvA+4yCfL5uLNnXSbi1fko+d+M50o7ovGbKYUCf3MVLOhb7QkW5zSyoZRK4HnXA866Z0aYJWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8bzFLG3YVicato8AePmOZ3wHz3F3pe5OkMGY8QiFCw=;
 b=VzdOobSeAA8oAK5FlCOIKNTTZgw6NY7G1ot84SfTbM7gqXni25wwBIEsE3PpjM33WvKZpWt81kaCdhDihXbx/5fPWxhZIE2VSPzzH85l9JLgjYw5hbioS9NHdWoREtNuOx1Lii06mYo5SgQH1dPCSmIa8lZ3Bap7/O4uLzHMLTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:32:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 08:32:32 +0000
Message-ID: <008ec937-877f-4563-a42f-36d79293ffd5@amd.com>
Date: Fri, 10 Oct 2025 10:32:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: Add SRIOV crit_region_version support
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Jeffrey.Chan@amd.com
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-2-yunru.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251010044309.11822-2-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:408:111::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bd1a14-06ac-4ee6-8b22-08de07d78e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2poVVNQQll1VVEvd1JUK25CTC96VWZRRUJxa0gvWkJwR2JOdEY0V2hvbTIr?=
 =?utf-8?B?OEZVTmdrSGltOWpJdy9DaS9vVGhGMmpDdnM2b2R6T211WTVTS2NmUFh4c0tO?=
 =?utf-8?B?VTB3N2NYMFJrb0k1azl1VGY2S2hlc0w1WnpzRUFMalBPK2dXZHZwZGo3anVm?=
 =?utf-8?B?OEh2ZzQ4UzlDN09nOTMxTjAzdlczaHZaa0hYZjcyRjA2dU9DTjFmaFR5a29W?=
 =?utf-8?B?RFcrbTU5V2hIVjA1TEpEQ0VjMHlDcFRBWXZudkUxa0VWTjVYTDcySGg3dVhR?=
 =?utf-8?B?dGJ5eDd5ZkI4M0NVdDZndTR4VTZPMi83cmkzeDY4VjVvN1A2VU5pdHRhUHpJ?=
 =?utf-8?B?UEVjUTRLZzE3L2hzV3BvRkowMjZiTlB3YisvSU41eW9ybXR3di9xUW43RmxD?=
 =?utf-8?B?N0hQZmpxT3YxQ1RkTDhGWDVQTG5Zd200NlU1NmpUK1piTXd2Y3dFcEpPTnNS?=
 =?utf-8?B?L0Y0Z1o0N0liL01XQXp5YUM4NTRUOTcwNlBrTWRJb2hkd1hPVnZMUkdvOEkv?=
 =?utf-8?B?TXlTMlNQNGxuZVlXUkx1ZURuU3RjR3RueFV1dnpqN0haWkdFemhpTVZPYlNu?=
 =?utf-8?B?Q2I1K0J3V2xUbjVheUZWQnJTNnEweUhyVkdWaThucTBWSFdBQlVhSjNndDFY?=
 =?utf-8?B?SkwvZXJueXpiMTZQNmJEd3pUVnBMRVp6dStrYmV1WVdzd0N2Z3R5SU0yU2tR?=
 =?utf-8?B?SFN4Z0VUTEU4WVU4SGorTTR5RURNenF5cG1iM0Q2MU5sdGxjQ0FCbkNkdVZW?=
 =?utf-8?B?cnFweTIxcVVSNFJLYkwyWC84SjBwYXRHWWhIZm5FM3NnMGhOT0RmVXNkU21i?=
 =?utf-8?B?OCsydzdXZDVlUXlyRXRaOU5KR3RsaVFWTVhlNHgzMG5lczRqYjVjTDFmenJI?=
 =?utf-8?B?aHptZmw1QVlJK0xtbDlJc1JhVWs4dVhzQ3FFZEc1aDdBamN5NWorT3p5eVhF?=
 =?utf-8?B?c2U1T3dqTS9SWW9wQU9VczFER2VhTm03cTgzQ1NmQm5XcFVvS1MvYXlreUtH?=
 =?utf-8?B?V2ZIS3lpQ25IdWY4NVhWZGJzMG4rYnZXWStNcU1HdHBQV3hWbmY4ZUFVWS9u?=
 =?utf-8?B?RnlBdWVwalppZVpQcTVjWTJkeUJmazkrZ3V2ZXBJaENmai9VOFBUOFdVVi9j?=
 =?utf-8?B?S0ZBblRwK1d4dko3Y1MxbmYvT1U2SkZBaFNWcTlMTCtYaEdjL2N1NXMwSlFa?=
 =?utf-8?B?dUVIcTRCNVJzU0hnYlJPM0s3WHhMT0xPbGlacHVDb2M2azFCZjRGcGM1eStZ?=
 =?utf-8?B?K2taaC9nL0hMdHFCNTJJUHYvV3NHK0ZkbE05UUIrU2FFZ01yZzRZSDl3bjd0?=
 =?utf-8?B?U0ZLbkt1SnBiQXlJUCtMT3hMOEZDRzJ6NXE0Z003MFA4YjhtTG55S2p4QSt1?=
 =?utf-8?B?SXJMSWNEUDJjVnMyVWx0NEE0ZE1XRHFHK1pNSlEveTdObFFxcW1TM1hSalN4?=
 =?utf-8?B?aW9ZemZucTh5cGNLekE3MENma0xCQkFXd0FvcW9rdzExMmozODNwempodTZt?=
 =?utf-8?B?OFYwbUxLN1BsdGl0NkEzNFhIQlRHRm5lK3BQL2FrSmFScHgxd29VbDkwVHNi?=
 =?utf-8?B?a1NsV0p4Sml0MU94YVBBWEJkTVRpMG9OWnFaMCtIY1Bid1Z1UlNWSkVvSW9j?=
 =?utf-8?B?MWtiM0RwTFN3ZzJ6THdIb3V1cFJpTmtsVEUzbVdOb0grNitXVS9qM01Xb1Vy?=
 =?utf-8?B?MW9NZUM2UWtkTFIwT1FiT0Nua21SbTVuTGtxUnZNenVpYi8zSFhkODRXMHo0?=
 =?utf-8?B?WDJJaW50ZWZSb0k4SHhKaWsyRzZGcnk1Q2pKYXdCQ3BablMzek50Y1UyT3E0?=
 =?utf-8?B?NFhPOVR5K2FGSE1JSE4weTFGY2JzZXE0dmVlb1prUk51Z1JlVE1pZHNVZUMy?=
 =?utf-8?B?bDZmdnJmbkM3SnpvN0pSTElpMHE5MExpNlJDd1l0OHpYM29IS2tIYUQ4czUw?=
 =?utf-8?Q?kH2psuOKx+adFhI4YFOxgqe+drax3A2y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJXRzVmditPWWh0cHJ2UVhFVjBGT2d1MkZoU0h0ODgzN1QvMmRvbXZsdzk3?=
 =?utf-8?B?clE1aG9meHlGa3hyUzc3UHNuTDZ0RW81WUVLVTl6aklqeHN3eE9XWkRvK3Fz?=
 =?utf-8?B?dCt0bnBQSzVoQ084S0QrbVQzdzlqc0M5VndlSDc4b21UV1JxMmh2ZExVZ3B0?=
 =?utf-8?B?dFAxWEpabXJRd24yMWdwT2JOWmxsZlN4NGNsd1M0L09IZUFMUml0MGRoWmFP?=
 =?utf-8?B?UUlGTUc2ajMxdU9PQkJ1a1Fld2xZemdpS0FzOS9vSEdNQ2tyeHdRUWpYZEls?=
 =?utf-8?B?Yms5QTZNWU54SUYxTVRRb25BWWhHNk9lS3VYUFdUUUFESkN6LzE3cFFoUkJK?=
 =?utf-8?B?RGYyTkNWbis5TmdnbXdENlFxcTYvcXdDcXQwL3h4SE5MR0RnTlViMzlTYjJZ?=
 =?utf-8?B?bFp4MzFuZlloU1A5OFRKaStGckVMeGdoWWptckhiQ2dJckt3RnVIM0tvTlRF?=
 =?utf-8?B?R0haOUNTcnhXVm9tY3JPQzVleEllVmJMaEx2VkNYZG9CMFhVdTBkZWxYWjNI?=
 =?utf-8?B?UVFWaEFmNDhyNmpQQWx4SUhnRG9ldHNJR2RQUGxiNDZScUJsUG0vYjF3WHRh?=
 =?utf-8?B?b3BjVWl3VWhuNDRKb2tFd3VDT0hsMDNaVnZLK3lXQ3ArY3V3MlJDVndKU2N1?=
 =?utf-8?B?UExuRWJNRnRBZGZlcGZlbkNnRjd2NTVwbDBuOGxlVmptN1h6ZTlKbHJRNFlt?=
 =?utf-8?B?TmdDWmkxYWJnYWRIazZieFE1dUpqRWRyZjVGUzg4bHJ3Q0ZNTzVCbjAyRUlF?=
 =?utf-8?B?b2lESVIvK1ZoVWN5VENpRmVIZWt1UnhhSnZsSC9EczVHYUl2Slg1bHBxYTFC?=
 =?utf-8?B?K1BIWWhGVDNVRm5GVnJEbDBHTi9YaldFamNaMHVZRHI3WHppZVdDRE52eTR1?=
 =?utf-8?B?clZjU25jRnlXREVJTFc0MDg1OWRleVNwcmVxK3NWdlc4aDVaaGNIUitkR0Ir?=
 =?utf-8?B?M0J6NnlIVlB6eW5raXBxZWU1ZGZHb2lsNi9NaEx5OEV2UlZCS1lucGd5M1BE?=
 =?utf-8?B?a1R4c0NKM0JvZzhKamVlSjR3MjRpM0ZJbzJqZ0pUWlJiR1ZIUys3RTJPbUFG?=
 =?utf-8?B?d3Mza1EzZFRCQlh1Y3YvYzBMRm9PcHJiZGYxNnFVZG01YzlTTGphTnlnaXhQ?=
 =?utf-8?B?WjQrem9zWENzelhYUUhrRWlIOUNoYjRSejBJZThvNzQyN01MTWlXRGFPWEhM?=
 =?utf-8?B?bUw4RFR3YVpjdHlUQVhtc1RLemR5ZzQ1MWNkR3lKcVVSV090TTZkaXg4QVV5?=
 =?utf-8?B?a3F2cTh6dG1DWmVtR1pCOFhDVGFVN0ZYVGVJc3NsRnNRa1ZkekxuMC91S3NC?=
 =?utf-8?B?amxNejdrS09BUjk5a0NsS1BZMjJFTkphMStoZ3RMSXZRM3FvNkh2VUlhdGFv?=
 =?utf-8?B?Q3R2ZExQRXJKSFNLUjkydHVGMmJJSDJNWnBtMHY5QWgwaTFoZXZ3c0lRdUtK?=
 =?utf-8?B?em0vbmc4dlA3UVRsQ2FNRkhsanNrNERxaFJJRGpBM3JKem92RG5tdWxmbGJ5?=
 =?utf-8?B?OWZFRVd0eTlyVXNYYXJOMTUrUWJ3ZmszaHRhamdpZmRuRHE5MFhlbHRyM1RM?=
 =?utf-8?B?eFEzdndvMUFTcUJ0VS9NOHBJR0lBVHFXcXZKUk5FR3VpZGIybEszR0lqTEkz?=
 =?utf-8?B?cVRTbnBRR0tyUzBIZzVQQ3k5Mng0Q3ltc0pkb2RSQWpXb3pXcWQwVExvRXlE?=
 =?utf-8?B?VEsySWpZNFNBTlozeW5rQ1FxVUpPdHNpd1lrZHkwNWZCZThDTlJIemRUY3FN?=
 =?utf-8?B?QVBxTHJ0QXNNK0Y1WGM3WUZaNVVrU09GYjhPdTNmWi9lZGVJZHJkS08wbmlq?=
 =?utf-8?B?aTNGT3dFMGUwM2VTeTlXWmRlRGsrZ2ROUm5TL2tXalJTQXVpZWJ4MnNMTklK?=
 =?utf-8?B?YmV2eDZTb2RBaG1ESklycFpxL054dTJUN0pidjVXdmkxK29HeEdhVDZDcml0?=
 =?utf-8?B?MzFsYXhndCtwQ1dsNC8yTnNMUGR1SHVKalcxWVBkUWFtS3VWWTIzemdPSzNR?=
 =?utf-8?B?Y1V2cXVjU1pVd0h2cTgrVnc5RUtEY3E0RHROamFHS05Yc0RKV0hkM3JWNGhS?=
 =?utf-8?B?YTNRMjRxbThCY3VpVktrQkJDWWpqRjVVVTc5UzdaWHlaLy9QMnphOW1jd2ZH?=
 =?utf-8?Q?hNkhG8hyIX718Yy/q/VRWZ2zN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bd1a14-06ac-4ee6-8b22-08de07d78e44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:32:32.0986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfA8fEgpmnYkulGCnOvZvRUGEnS/sBS455ASOU9BLFSzcYuaUubGzKfFHXw6t7A4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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



On 10.10.25 06:43, Ellen Pan wrote:
> 1. Added enum amd_sriov_crit_region_version to support multi versions
> 2. Added logic in SRIOV mailbox to regonize crit_region version during
>    req_gpu_init_data
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  8 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
>  4 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e95adf0407a0..3a6b0e1084d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
>  		virt->ops->req_init_data(adev);
>  
>  	if (adev->virt.req_init_data_ver > 0)
> -		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
> +		DRM_INFO("host supports REQ_INIT_DATA handshake of critical_region_version %d\n",
> +				 adev->virt.req_init_data_ver);
>  	else
>  		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index d1172c8e58c4..51ff73b1fcd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -262,6 +262,11 @@ struct amdgpu_virt_ras {
>  
>  DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
>  
> +struct amdgpu_virt_region {
> +	uint64_t offset;
> +	uint64_t size_kb;

Are those really 64bit values? You seem to read them from 32bit registers.

Apart from that looks good to me.

Regards,
Christian.

> +};
> +
>  /* GPU virtualization */
>  struct amdgpu_virt {
>  	uint32_t			caps;
> @@ -289,6 +294,9 @@ struct amdgpu_virt {
>  	bool ras_init_done;
>  	uint32_t reg_access;
>  
> +	/* dynamic(v2) critical regions */
> +	struct amdgpu_virt_region init_data_header;
> +
>  	/* vf2pf message */
>  	struct delayed_work vf2pf_work;
>  	uint32_t vf2pf_update_interval_ms;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 3b35154e2df6..b53caab5b706 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -65,6 +65,11 @@
>  	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
>  	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
>  
> +enum amd_sriov_crit_region_version {
> +	GPU_CRIT_REGION_V1 = 1,
> +	GPU_CRIT_REGION_V2 = 2,
> +};
> +
>  /*
>   * PF2VF history log:
>   * v1 defined in amdgim
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index e5282a5d05d9..cd5b2f07edb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>  				adev->virt.req_init_data_ver = 0;
>  		} else {
>  			if (req == IDH_REQ_GPU_INIT_DATA) {
> -				adev->virt.req_init_data_ver =
> -					RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
> -
> -				/* assume V1 in case host doesn't set version number */
> -				if (adev->virt.req_init_data_ver < 1)
> -					adev->virt.req_init_data_ver = 1;
> +				switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
> +				case GPU_CRIT_REGION_V2:
> +					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V2;
> +					adev->virt.init_data_header.offset =
> +						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
> +					adev->virt.init_data_header.size_kb =
> +						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
> +					break;
> +				default:
> +					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
> +					adev->virt.init_data_header.offset = -1;
> +					adev->virt.init_data_header.size_kb = 0;
> +					break;
> +				}
>  			}
>  		}
>  
> @@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
>  
>  static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
>  {
> -	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
> +	return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_INIT_DATA,
> +			0, GPU_CRIT_REGION_V2, 0);
>  }
>  
>  static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,

