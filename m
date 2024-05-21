Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC22AC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 05:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCF710E9B1;
	Tue, 21 May 2024 05:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X0bh7TSf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9815D10E9B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 05:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3b5fFXt+Mjx3f+1YWLi0e5dgrwP0F93+y8/HtavCVE4Twv/fiS2KcSASljn7gtPlG2V5rBnkUaSUy4UJbxMw26xOS6o0Kr2zsTmC5cYHPPtQGNNaK85UGEAJKZX0wWMgO4nVpcSrg4OSHEOIauvbS6EYLNc29NtQ+fUUmbizw2FttaasYno47BzxQdjg5zYsJql6ZQHB1RznKtApNTLUtaILsGTYXm1NQqAIcXF0xAaaz2q1cAc7fYn5IikRCLLtWnMuFiwo47wFgqe2tVZbh/NOYTM1zRLgIhms44gNPmiFSc6bH+FKahqiUtyoqdGxdw34TQVBGV3MIMG0K48+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQQpULtDSb5vU9nBbtiE7VikCp87tCx0IMXXwFyr/XQ=;
 b=Y3Xy3Ne559ufVphPeVSQpyDBWhI8lSXcwaXQS0+4Pq6I7/Rak76qTl+o1YW3jpjF3VrDauuZxqChq7C9KWtIxnxBfFUq2BZlkIYQJdtdH5JThuInBrLq2bNNQAJ68pmhEr3C+8WDRfTO3QPZ3Uvg4JBkv9H26kTh4Gh9+WZpR/Y/QewAEJ/Wakz/wv4KdJqon9c0QHAU6lHCq7pjjsbop69KPnQRVEgE5sHcf9cvKYdYdD6UlRq5wDssgIhCvKD3ZW2MFYXlZHbCZeF0fpnAfNLjYr9h+w3UiQb+Rg+NIzjNZUZsikl636Itx7XYdDIrZeeFK7ZZISlpfs23ceZKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQQpULtDSb5vU9nBbtiE7VikCp87tCx0IMXXwFyr/XQ=;
 b=X0bh7TSfEycoPqcsMdN7XA+nxuvQZZn1ckztdC0Ib/bjy+MO4le3CVrnVe2IIgzdvBodX7TfJZepTASZmso74sgNyGTfaZyAFUVmPLRF4Undc0tTN+BdQ6vVkJs5ZkdRnHCmcPSBGUIsO8uU3D9M6rhfCGI0u+hGw1Yu/DMD1lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 05:46:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 05:46:26 +0000
Message-ID: <57639b4e-6cfe-4de4-865d-05c585871f32@amd.com>
Date: Tue, 21 May 2024 11:16:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix snprintf usage in amdgpu_gfx_kiq_init_ring
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240521044331.3735728-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240521044331.3735728-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: ff740c9b-e11e-4c32-4a17-08dc79595a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zi9oNG1DbkVhUGVFNGsxN25haFl0K3FwR29pYnV0RGE3NmIwNFBCU0JDRjlD?=
 =?utf-8?B?ZUFtNXpCeHAzS0FiUUZCRVF3VXNqWEJvd2FFUTVxRUJLS05IdWs1Q2Vha3pr?=
 =?utf-8?B?QUJoTzhVUGNkVWZuNGRudHhPT1gyOE9UR200TDArNGg2SnZPazVZWGtYUlJP?=
 =?utf-8?B?ZVVIWWI1UUtGNis4RW53MzZJbWRqZlo2SzVNUE1nWUpiMHNVWXJGM1pJNkdR?=
 =?utf-8?B?cmVrQVhPbXp5UEFhN2ZQNGNnY0JEWXN6UkRuT2RoY1dsN2srM0JGajZqd00w?=
 =?utf-8?B?K2Y4d25kb1ZsRTJ4RmVUOHhTZlFHWFBRemF6WnYzRnJ3ZHNZYXcydDhDYjJ5?=
 =?utf-8?B?NnJUZTY5OGYyeDliMXZ5UXlBdi9ISjFDWXhCK0pyTWl2N1A0R210YjB0ZHdu?=
 =?utf-8?B?QzJhdG5FSm9QMmRaQ2I1cmpVaVhPRy9WWFNxUzBJVjJoZTM0WElUamh0aGlz?=
 =?utf-8?B?dkZqeEhQa3JOMlFsamUyRG4vKzdDQVRlbnJ3WXlnU2FuYUp2RUxaZ0x3UjdY?=
 =?utf-8?B?SlRTOWVrdXkxZnRMbDFBR2EzT1RwNDh4Sk4vVFQveHdpam13REhPbCttczNR?=
 =?utf-8?B?T3EvZUZPTzU0RkFVM254VzhuTUVQUThSUU5BZWVmRnc2UW5IVi9Hdm0xR1kv?=
 =?utf-8?B?dHZzbG0xWnVYYkRSZ2YxSVJyR2t3Y3g5ellUSWxTTjFJUUNLZ3RSa1hNV0k0?=
 =?utf-8?B?dFhqZHZNeHNpK2lPNnJwak9wcDdubHRTZStCMDJPQUI1SnUzYUw3TVpQUnNk?=
 =?utf-8?B?NjluYWNYZGljb1BsMFU4WWIrTVJveWhHYzFRa2lkUUpVTWpuSEp0bHo3Rnl0?=
 =?utf-8?B?Si9jR2dZWHFmOUdhN0U4SnBDTjI5bDlOZXZEMElaVXQzRGxJUlJVaFQ5dWEr?=
 =?utf-8?B?aitNbDJDdkxBQmRFV1ZLc3FNQkFZQ3ViUUJwLzlRUXJVSmJNcVo1ajJFSHoz?=
 =?utf-8?B?TTBDUGhwUk01N1dvUXFmVUR5QjJ3M0o4RnhHY1pYL2NBQmRKUEhIQlVMVnFJ?=
 =?utf-8?B?c2hBMDhWS3EwV09XTWtsdklQSnBoY0k1OHIvSWhlTVdTTFpvZk9HWmZnQkJu?=
 =?utf-8?B?Zzd4T0F2NVJGV2UrTWZVb2RwQ1BjdkJta0ZhMCtJZ1FpaTdnUHE0bWkrVGV2?=
 =?utf-8?B?Uy9Wd3ZOZS9RUW9ReTNmRWpnOG9OUXVyblFYSTNHTjNIOEtmTzJYWWd5eVRz?=
 =?utf-8?B?aWRweXVuTGlIVjBXNjhEUS9SaUlQYVRscXROanV5b2llR204azk5UGgwb25C?=
 =?utf-8?B?M1l5VGZZZ1FwM1VTbThaT0ZGYmx6WUpabmdpdTJIMHdOeEJ0U2svZExuVEVj?=
 =?utf-8?B?NSt3MEd0SlY1NUpGdTh3TlRiVzdiS1p5enhHVS9XVjhxcTFMMkQrR2tCRTFX?=
 =?utf-8?B?UmZMMWE1ZnJ3NTJSUkVHS1Q3d1Z0UjNDRERMa0VLVHVJd3dVNnF3STVTcG5N?=
 =?utf-8?B?blVCZWtwRG5sUjBtcmpxUy93RjRpMlR4NjJ3MUhZQ0tpdnYrTVI2UW9zM3lY?=
 =?utf-8?B?WW5hMlZ2elo1UG1YVzh4NVZ6YWRoamVJQmtIWjh2ckJMTGlMTWVTT1pkeGZ5?=
 =?utf-8?B?YmRFT3JoSUxoYkhuempaS0NzdnEvVS9WczhpOGx6ZFVkZ0wvVS9pdy9ZdytV?=
 =?utf-8?B?cW05bi95UFBkbWxUT215elp1Q0l5T25VSXhBVEdXaUxpakg2WVlTRW1QcnZq?=
 =?utf-8?B?bGlabVJpeDQ4UlZLQ2dMNnNXcDZCNG1JTkFTNG10RDl2ZFNibng2K2R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djk5eU1Nd09SbU1yYVg3b0ZGVnRudDNvRStlVXRyV0toTnRMMmRlZnZzNnI3?=
 =?utf-8?B?ZzhRTlRsNCtWNFRvaWVxZURUakpVeEhnSFdvR29GODRiQW5sdERJTi93cnlD?=
 =?utf-8?B?cHIxQytNeWUwUmsrajd5VkR5RzVOYloxOHdOcC92UXcrZGNvZ1hMTHg5THZl?=
 =?utf-8?B?MlJKT0ZyYUhlK2FRUS9xOXlvWW96NHprNGowUUFLcUhKYnk3eHZVdm4wOVda?=
 =?utf-8?B?aE40bXl0Um1TUXZmajF4bXRhdE1kMnEva29GNlhwZk1ubWdjRXZGdDdCdXNJ?=
 =?utf-8?B?aTcxblE5aHQ3aWczSEpmSHVsRnBpcVV4KytaRXRubGxHRmF5N1NMSW5xWEdV?=
 =?utf-8?B?dlI5YmZjZUlmYlBjcDdlT203NXBsZWpRSHFrUzVDSzlub2g2Wm5QMjF3OWRF?=
 =?utf-8?B?cTl2Uk40OGpWWUR0YmhmT2NMdDR2c3NNMmRQWWtSVHNld29UdnRQSkJ1TStn?=
 =?utf-8?B?Ri8va25YaUZkV3dYUnlGSjNtUGZGeWFXUmlxc2VCb2k1ajh6NHZucTZLUFNz?=
 =?utf-8?B?UlNVZ0FzMlhyYlBSVExGVlBFT3FVaDZTL3NyRm5WOXc1ZEJZSDY3U0k5U3hz?=
 =?utf-8?B?b1NuNVZ4ZzlLbjlwbGhSUjVkNjBMRTJYRjd3aFpaZ01rcS8rbWJZbStiM2NF?=
 =?utf-8?B?b3RaU3dVeG5BOEtmL2g4OWZMeEt4eEpTUFo5Wm5nSE9uYnpBQml2QTlYdHVw?=
 =?utf-8?B?eXc3dldWcldLOG43WnVTeDNjWVhCaUtHOFNIQ0JYNlRYTm5ZOVJPZEZSQlpR?=
 =?utf-8?B?LzJZakMxUkJ6eDJibjREb2ZxMW5SNlRsbGFuVnFGNzVqdEU0MHlWUWgzRm13?=
 =?utf-8?B?MGpudW5CYm1tZml6SHZkdVFpUDhhMGhETjR0cHVnRURDczNTdE5uTmhubm9x?=
 =?utf-8?B?R05xc0RreHhzUmRYSzdXMGh1bU4rTEs3QmtYeEk4MFZXZEkySFhzWk1hcEpD?=
 =?utf-8?B?a0JpdEd4djg3TXNxVkUrK0M3ZUcxeFFkbWVtcG9hZW1raDIvT3dLOGtMVis5?=
 =?utf-8?B?a0RySVlhbmQ5bloyeFNGaWRrQm92S0p4dlJGQkdrMXNKdWFBVW1OMjVyZDA4?=
 =?utf-8?B?U0xlcllCL1VrT3FOK2xaNkpZS1dDd0dGMmVrTnZRb2oxQ0NFVXVjTENlRksy?=
 =?utf-8?B?dFErdEZrSWZSb2V3VWdrWXRtcy9lVU9jaDBWQnNERUhncG43cnlPTmZOdk5C?=
 =?utf-8?B?a2ZHa1hZRlVoRW95aWkyWlM0YzZ1WndHa3Ixem5UT2JOOHJidWtUK3NGM0lW?=
 =?utf-8?B?YWNtYkpVeUVMb0M3c2xvbTJDOStnMllCM2QzY2YraGlmcTkzeERXWkpDMFNy?=
 =?utf-8?B?RkRYWG4xLzNwUUdlM21RamJDMi8wYkw0dHhXVStaUWYvY1EwOFZ0bzRIaVhs?=
 =?utf-8?B?eWRiMU04L0N2c25HOTJ4NDFaS0NtaE1BKzIrcUpoRkNXS3hqTm9WQTdEUmVZ?=
 =?utf-8?B?VUhLR1d3MVcxdnV1bFRKUllQQWdqeThDMHFmUjlGSTBOY05FNWlxeDJKdzIw?=
 =?utf-8?B?bUNXckwvVkJWNWQvTG5XN1hwQXJoY1hDSDkwWlUyQmh3YlE1SVZPbm9IbUZ3?=
 =?utf-8?B?VUFTa2tWNForeHZOaGZHWGFQN3k4c3ZTOXo4U1dKZlFWdWo3TzRza1dUOWRQ?=
 =?utf-8?B?RXVtRlIwQ1VlWHQ1M0VwRWpTRHdYNWI2OTFQSDZoSXhrV1JIWFNXY3phTWg2?=
 =?utf-8?B?bWdIVGd6Z1NHRWJ2QzU1Y04yV1plL3p3eGJKT3lxbndWS1A4MFdubW1hem5a?=
 =?utf-8?B?YStQZFlQOENwMHZCRmVYSnZEckYvZjRhNk1MRms5S21YWmJaVU9ENHZycGZj?=
 =?utf-8?B?aWhNY21Ra3lzUTMwUFFLTEZPcnVJVmNVTkhUUE85dnc4c0lIRTJuVzIxVTFn?=
 =?utf-8?B?SXUvRDF5U2NuZkU0VmdlWkVZay8xQnFmdFY4SXZLVjcrZTdOTE1HcTZ0ZTI4?=
 =?utf-8?B?WUlTMmdwR0U1bklQclNreG9jRjRuRHZTbjlaWmtyTUs1N0M4UVZSc0hlcnll?=
 =?utf-8?B?WGxGUzdmYjJicWtTSkNkdmRNRHR5M3FFVnJlRlBVcnY4TVRzWU9rUUNQaTdR?=
 =?utf-8?B?dlpTTkhpYVl1ZWVkbGc5RG9WQURwM2pGRzE5ektPY0RMNDJHTllURUc1b3I5?=
 =?utf-8?Q?TcRyVjlphFrQp38RDv0iNe+8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff740c9b-e11e-4c32-4a17-08dc79595a6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 05:46:25.9685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlgEjs2FYxkWovNcSE/j5J/R62synZyoxRe/vypLrpyXHEldSIbV/K0xgLaq9wNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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



On 5/21/2024 10:13 AM, Srinivasan Shanmugam wrote:
> This commit fixes a format truncation issue arosed by the snprintf
> function potentially writing more characters into the ring->name buffer
> than it can hold, in the amdgpu_gfx_kiq_init_ring function
> 
> The issue occurred because the '%d' format specifier could write between
> 1 and 10 bytes into a region of size between 0 and 8, depending on the
>   values of xcc_id, ring->me, ring->pipe, and ring->queue. The snprintf
> function could output between 12 and 41 bytes into a destination of size
> 16, leading to potential truncation.
> 
> To resolve this, the snprintf line was modified to use the '%3d' and
> '%1hhd' format specifiers. The '%3d' specifier is used for xcc_id and
> ensures that it is always printed with a width of 3 characters. The> '%1hhd' specifier is used for ring->me, ring->pipe, and ring->queue, and


Width specifier only guarantees minimum width. It doesn't offer any
truncation. %1 also doesn't matter as that is the default minimum. What
about just using %hhu?

Thanks,
Lijo


> ensures that these values are printed as single digit numbers. This is
> achieved by casting these values to unsigned char before passing them to
> snprintf, which ensures that these values will always be in the range of
> 0 to 9.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_kiq_init_ring’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:61: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 8 [-Wformat-truncation=]
>   332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
>       |                                                             ^~
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:50: note: directive argument in the range [0, 2147483647]
>   332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
>       |                                                  ^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 16
>   332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   333 |                  xcc_id, ring->me, ring->pipe, ring->queue);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 345a36c4f1ba ("drm/amdgpu: prefer snprintf over sprintf")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 9b7dc61c331d..88da17c0340b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -329,8 +329,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
>  
>  	ring->eop_gpu_addr = kiq->eop_gpu_addr;
>  	ring->no_scheduler = true;
> -	snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
> -		 xcc_id, ring->me, ring->pipe, ring->queue);
> +	snprintf(ring->name, sizeof(ring->name), "kiq_%3d.%1hhd.%1hhd.%1hhd",
> +		 xcc_id, (unsigned char)ring->me, (unsigned char)ring->pipe,
> +		 (unsigned char)ring->queue);
>  	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
>  			     AMDGPU_RING_PRIO_DEFAULT, NULL);
>  	if (r)
