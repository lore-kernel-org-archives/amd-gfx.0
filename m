Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A7CC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 05:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F1610E27F;
	Fri, 17 Jan 2025 05:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8XY9Awj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9EA910E27F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 05:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umGDcYQ0ADIfw9UL2AtTTE2QgI6fwrMoWZztGmfUJGwGzL/3rSfQqdp0pMlP3VKieuYSXnJxVpEhVLgdzbB8qGjjV6OrC+uCy/ZMxRgTaOjs+qnF28yyYnXx4ZifHchYkVOmj+KQn5UdWeDc3IpAvzL2oCjEJAPoi7SZ6Gw1i4wjs2myMfoRRZX51G2XNqEd+AKhGiNZP9FNq8iPrHagv+PZLntTpEZJf0IguOKIVoL4H0fjs2AXeTA80oKiDnLi7yz2FK3/BCjh10k6JHsXzLVmrVhj9DUgMrLUB3Tlwcz/jnESE45aHR3t+fkQl675iLwx4EQeT45lm9Yjsr55Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AlczjxLuRGWSuOsrDwBjpSud9SBhOJh0eSqZ0QWnU0=;
 b=g37E0DfusqwnVlBtxx4VR5Z9IHVsuWXIvYr3Gd4VJNWOiM02AhoXGjRMXqPF7SkXLgPeKCwvmDa4Ed4KmYtKrS/X+z2ySv7A3R7rROw+U6v2KhdhFDAKx58E74b4H4aj9APLU+HBzTf0sLMM2FZ5mJ7Bwnjb9i8FcLbZ6IY3ARspKBnmHCgPyPwWKxDWDHFMNP12xXM2JNqIi9vGQmGCj+IYWQoOfpIrhWPpTr7QID8KLHvPsQ/TN5wZaYYEQJ23bs8vO7xV6Zwde1+kCSpBDHOcJSalIrDtnfZBXBHUveDy21Hj755vpeQhZ8AYpzN++T1wponyIOEPtqp0bsVdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AlczjxLuRGWSuOsrDwBjpSud9SBhOJh0eSqZ0QWnU0=;
 b=y8XY9Awj2G9fVLG8kxkETrNutbAOnLMEQm0B82RYU/Hsdi7sCPdzHutJJ4cxl2CSxOLgR3FPz0Sk5MMY68QcYTBJs0MA2qqetw2+IPughhYm79U/hQZj6ydC/fY3VtAzMzYNkGBVRT6MVkDFoS2Prts+6QGHcwyuH2DrP4zr5y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Fri, 17 Jan 2025 05:54:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 05:54:49 +0000
Message-ID: <5a50b0c9-10b0-4743-9a63-1a039ad44ebd@amd.com>
Date: Fri, 17 Jan 2025 11:24:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/15] drm/amdgpu: enhance amdgpu_ras_block_late_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <7634784000446c054de53387a352812e74f337eb.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7634784000446c054de53387a352812e74f337eb.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfcce2d-08b7-48cd-1c09-08dd36bb7443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjRZendFai96RGorVEE4RjdJaWRNdFk4cVhxMjlOb3VnaktwaDBIMDFDYUUx?=
 =?utf-8?B?R0lIZEVxQUFkUXpqT3dUY05JZjQwcHEyM2pjVnFoNjNJVDZGd2xjcHRxRTdF?=
 =?utf-8?B?YW15bThvMS9tcHlmQi9mZHhnN0hoNXJvMC8zakpPcUlKR1ZKaEFrOUQ1OFY3?=
 =?utf-8?B?RS9aK3MrRVlxTmpON3RmWlZiMnAyVWNmNi9UTUFpcmtLbFBuYWx2ZzEvZnFK?=
 =?utf-8?B?QStRaHJFaTVwMnp1NlU4aGVYODRIaDBocXAxZTJTSXN6L21EMVVoNHVUcDQ4?=
 =?utf-8?B?dXQ3VGc4ejBEcmZvVGllOFoySU9RSDRXcDhkenZWSUc0T25lY2hEVHZmLzJl?=
 =?utf-8?B?YXV1dkdpeGtUcjdOZ01VVmZUR0gvWHpmK2NZWExQU243WVJ3ZmtFSEJsVFNV?=
 =?utf-8?B?c0NkYVBwdUZOWU5lNTJzbzljS1AyZkJReWxIUlpvaFRnK05vaUdzWmVGTFpM?=
 =?utf-8?B?SmcvdFhSMDc2QTcvZVFXWnYxczBNbFVYTks1WjdZZnlqRkFPOWN3ZEl5ekZk?=
 =?utf-8?B?Q3V0MmZPaTRoUVhvbTAzY0hvNDQ5ZXRvdXU1L0RiNmx5KzdNUWJKZkZwenRN?=
 =?utf-8?B?OGt6OTkxWXBQTlhXVU5oS0F3ZFlLWkJYZ3RBVWdibU12Z3EwZ2swYmtCSzBo?=
 =?utf-8?B?dUFjbWM4ckJodTdkQ2FUUDdFdTNnaG8ramZDOTU0alVjQmJoV1hPb3MzcWZr?=
 =?utf-8?B?UTRQTlFzYnlMd29PN081SXA1eHlFbzBjZ1VkeHB6L2QrQmJFMFlHOERobno4?=
 =?utf-8?B?WjNsL2RPcGlrOVdZa1FDbzIzZFBKQmozYlZCTEZ0TExYeS9EelF1eGs0bXZy?=
 =?utf-8?B?NHczeHNUY3E0L2xGajFPRmVqMHc5QlY5MHFKQ3Y1dXpudVkrQi80R0FOdDZI?=
 =?utf-8?B?Y1Y1L3ZOYVNZM2dHcitSNDM4VEdWMGtCZHFYTCt1dzBZa0JrZE0wSjBrNmxa?=
 =?utf-8?B?L1U3akJJb2kzQ0dSU1hiYWNUa0p1L3ZPY3ptdndKeHJoaHFrNkdFckZDM2Ey?=
 =?utf-8?B?bHE1NFc3WjRhQnU4bVBORDdaT0dqeXJ0VFBtdXl3UkpqTXJkdng1d2s3Y2NF?=
 =?utf-8?B?TGtqSFJ4TFdaTW5NcjNYR0E3Q2l2TmFrbittQkFnbHlFbStNWFp1Nm1PbGlW?=
 =?utf-8?B?SUYydUkrcTlSdXRlcmVGTkhOSlZpQWFkdU1WaDNzc1N5TDIxSTVnUDhORVZs?=
 =?utf-8?B?bVIzOUhTUDlqQjBFdldZYnl1MmgyZ21hUUJvL1B0dHpOUkRETy9HbEJoMFJT?=
 =?utf-8?B?OUlETlR4UlNKdEFjWlg3Z0M0U0hjUmpLKzE1bmVDcTNTTFJURkdHM3lralVH?=
 =?utf-8?B?QTBqU0ZrUXRJQ1ljT2pXRzd0cjBPYkdGc0NRazlaZE5WUlk1cllDRkVPNFBm?=
 =?utf-8?B?S1hjWStDT3lCYmVHSTNxRCtUenhnMDZZbVQwV0xYYjdkMWtSclRGMDZtRnRq?=
 =?utf-8?B?dmFOcEhYc2JxKzQyd21GM1F1QWwwNC90OXErQnVxTjI5N3NKZWVTNGFtbGs1?=
 =?utf-8?B?WG9RWWRoWUlESTl2MGorcVZrd3FHNUd0T2NGdS9WWUJaY1JYYTU3akxWenJC?=
 =?utf-8?B?bXJqRWw0bHdES1Jrc1BHWUlHVEZLclF4akZhdGM4L01DVjF2VnY4a3lnc3dL?=
 =?utf-8?B?RDhLam1yZ3crdmsxcDVvY00vQkFTT0VqcERnZUVBZ1Zhd2pVWjBXUCtoVUtL?=
 =?utf-8?B?MUgyNnk4MEdreGRWdTJZSEVCMktZbmZLa0xWMXVhNzdVSFMvOUJYSWRWVHht?=
 =?utf-8?B?S3QwN0wxb3RWSXVrZmwxMFdtQTlZY0NUOC9NMm1OVjErQVJ4bW54NW03TUdR?=
 =?utf-8?B?Wk9naFpmb2F5WXBEQXVsV3lza0dnUHRqYW9PREt5NjdYdGUrM0RpTjBYTm13?=
 =?utf-8?B?dVZKaVR3TkNiandCVHlLb3FQSnFSZ0V6QmZlWHZEc1BObWlhZ0VnSm9kR2tW?=
 =?utf-8?Q?sRvkgVqHZpY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhPY282QkVHc1FIK1NIcUtIbCtiYmVTWU1Jb2JISWpkUW1yY0EyK1B1MVBP?=
 =?utf-8?B?VFV0TitXN0o1NmVXeURlbmN5QkVXb1VURHRaWnJJVTJhdGJaUFptN21zcjFt?=
 =?utf-8?B?SXZNVjc0MWJkTGpqQndOcWtUbzdWelh4b0JBcFZ5K1hNdVkxRW9sbnZuNkJR?=
 =?utf-8?B?NkxVZHVZVWZsS0xHdUtlbElHT0dFTlZmQUc5bkVJMWsvclNWRkZUcDR4RDBj?=
 =?utf-8?B?cG8rY2hkc2dma1UyUHdlelk2ZjJCZVduVTNkdm9DRktCWGRiUDVqalpUWWZZ?=
 =?utf-8?B?bmFoK0lBWVhNQ2F3eE1nYmZ5QndYdTJDV1N6N2RTSHRtWnJRcmRaQlloL28r?=
 =?utf-8?B?NVpBb2tsdUpYTlNvM25HU2pxZHlJWm82dFo2SkJRWDBwWnhtcDg3QjdkZ0FY?=
 =?utf-8?B?NjVlVXc2Y1pQY1dnczlYaDJyZTNRNjEvRDArQ1Z6ayt4Y0dnR2FocksvMzhh?=
 =?utf-8?B?Z0xOUWZSL0NWZlRQL1g1TDRmZ205SW9HemUxcUxYOUFQZlY4MVFyR1UvdXNa?=
 =?utf-8?B?TVFhalVOTksrVWwzNVN4OUpmOW55UnpNVno5Vng4cnNsYUtvcVFwdmFYemtK?=
 =?utf-8?B?MVByNWY4U0pzUC9WOU5nSWYyWGc3YWpKTitReTFaTThobFJ4aTBSaUlHcGVX?=
 =?utf-8?B?MkhlV2tlSjd4L2wzMDVxL2x0Y2h4MjlSMzJndHNSaWlENEU2aG5FaXVoUVdS?=
 =?utf-8?B?MUh6bDJWdjlwQkVMVkk2S3NOL2FpOFNFS2g3NHFIK1ZDSmlsaVlmN1hzZ2I5?=
 =?utf-8?B?T0lqVk9vMVFCMUdhRzZFU0VhbU5FeFphTVpIUElXUVlkRllXaWFRR3ZkemdE?=
 =?utf-8?B?WERyZlk5QTkzSTY4NjFQZTVhYkJtemEyTmk5UHNZOUh3dGpNbVI0a292dFF6?=
 =?utf-8?B?VW9za1F6b0tCcE11ekgreXFNRE9lZkdHT3Vwd3JzL1pBeXFJamwydDJqRFp1?=
 =?utf-8?B?RitCK1dFTVBLdmh1UFJ3OGZVcS9ZRFZoUUJuczlqRkNPd3JkUDBYWFI1VU1J?=
 =?utf-8?B?NEZRa29TVkp4dEZzendpV0IvSzZhQTVjRlU2SnJtQXZBdVJqQWJITmVNSjkr?=
 =?utf-8?B?RFRydU5EWTN0ZVhtZGw1VGlNSEU4bTkwMXJPcGd6ZlJyRnRiTzI1aHNyQ1V2?=
 =?utf-8?B?cUZ4NTkxb2dXc3VUcGQ5U1dUQnRqL3Ura1I5ZXE3czlKMWViVzRVRUsybjVK?=
 =?utf-8?B?RDE1Vm5FeTVHMXE3d0wzSUM5UGpDTjNuRndCSFlJMmMwSDQxUld1S2hzK1dV?=
 =?utf-8?B?RGF0QnNNZERvSHpoUmFvZ0ZnOVFOVDc4bE45cUQ2eFU3WFRFaUVQbi95RXFK?=
 =?utf-8?B?MU44bGlRRHM4RVNiS0V4d2pNSTlkZkp5ZWdPVFNEZ2c4NkJLdVB0WUk0VmNU?=
 =?utf-8?B?M09JUnV5c25scEVlMWVVTVFESmROMkFjZEJYdmkxUXY4OWxTSmJXY3gyVEtY?=
 =?utf-8?B?RTV0cnZROWZycGt5VFk0K2tldVBMS3Z6aUdqZ3ZVZTN1NG9WUlcvM1dUMVlT?=
 =?utf-8?B?cmxlT1ZxUHRIWUhxUUhBTi8vc3N6blBkbm9xSmtYaVFGS2FPMWVQOHVyeU5z?=
 =?utf-8?B?a3Z1aXUvU1NYT3ZDdXlxQXByRjZoQUVqVlZtM0E2dVA2UEZzUnhPMDZqMVJS?=
 =?utf-8?B?eVBPOXNackRiVjNSanRaMVViRllzcGRsanFkOUJpYTZVaWFnTGpXamh0Sjl1?=
 =?utf-8?B?bWUzOTB4bXovVWt3RVh0bGFQODYxUUE2aDhWY1hONlNBR2YvY0Q3SEdmdmhs?=
 =?utf-8?B?SUtjMERZcXlWREh5a2pxa3pvNEFvSTFvRGhUSEpyNStmRTQvYVdqQjk0dnl5?=
 =?utf-8?B?TnVuMlNVYnp1bS9PL1hxNGpyMklwdlZNL1YyaERNTExSWW1pTnlyWGJpb0ZP?=
 =?utf-8?B?Ym1sZ1cvMWdEbmZ5MnFORlBoTG5td05hcUZIZzBHbll4d2JjeTZUYS9GeW9x?=
 =?utf-8?B?MlZVRWpaMFczc1JrWllmb2U0Qzd5b3BTSjlJbmwxU2FkcFUrMlk2VkhWemNM?=
 =?utf-8?B?QXpXcEZBbnJJMi9QQm1oeVp6d3pEemlwZjl4ZHVzdklFV0xIbERmTnZ2QkMy?=
 =?utf-8?B?WkNKc0hRY09iNFZpN29HVGFDVnBrRU5iajB6dGlPRTBQdkZHc0pTZVRTZUt6?=
 =?utf-8?Q?fDIDzT0t7Bxs5F48XRJccL0fH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfcce2d-08b7-48cd-1c09-08dd36bb7443
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 05:54:49.7163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87x7jqQDF4nuxf0aO8PvyG96cck/D3N8sxPRBDaBxgF20IyhXPQVva/KwPuRkoV5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Enhance amdgpu_ras_block_late_fini() to revert what has been done
> by amdgpu_ras_block_late_init(), and fix a possible resource leakage
> in function amdgpu_ras_block_late_init().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f0cd14ff78a7..7bbab7297c97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4104,13 +4104,13 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>  	     ras_obj->hw_ops->query_ras_error_status)) {
>  		r = amdgpu_ras_sysfs_create(adev, ras_block);
>  		if (r)
> -			goto interrupt;
> +			goto cleanup;
>  
>  		/* Those are the cached values at init.
>  		 */
>  		query_info = kzalloc(sizeof(*query_info), GFP_KERNEL);
>  		if (!query_info)
> -			return -ENOMEM;
> +			goto cleanup;
>  		memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
>  
>  		if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, query_info) == 0) {
> @@ -4123,11 +4123,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>  
>  	return 0;
>  
> -interrupt:
> -	if (ras_obj->ras_cb)
> -		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
>  cleanup:
> -	amdgpu_ras_feature_enable(adev, ras_block, 0);
> +	amdgpu_ras_block_late_fini(adev, ras_block);
>  	return r;
>  }
>  
> @@ -4142,9 +4139,16 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block)
>  {
>  	struct amdgpu_ras_block_object *ras_obj;
> +
>  	if (!ras_block)
>  		return;
>  
> +	amdgpu_ras_feature_enable(adev, ras_block, 0);
> +
> +	/* in resume/reset phase, no need to delete ras fs node */
> +	if (adev->in_suspend || amdgpu_in_reset(adev))
> +		return;
> +

I guess late_init will get called during resume or after reset. Won't it
go to sysfs creation logic that time?

Thanks,
Lijo

>  	amdgpu_ras_sysfs_remove(adev, ras_block);
>  
>  	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);

