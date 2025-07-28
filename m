Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A67C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 15:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6114B10E530;
	Mon, 28 Jul 2025 15:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fpbw37fi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C9D10E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 15:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJmoji+t48ZVKtEswOtgybFnrf02W7ybtOgvx654L2VtalK29MTZQ+0J2++g8yaajx91Knp4Asv20S3rOv3q1CVOlUvnjS3WId20H5fm2liJLLvEp2zWD6FQcuq1NUV6fMxE6z5UkbofDDN2OF1JniqigzHCyVodFvuxw6vVRRzi7RHj+GUBLsmhxcOuOqptQ3EVtcUr3y2t/gPuj6u5/kSWOHaVYrCfEFYWHk7ArJkVuul6xxvxBXD7N/MKK2OS6VbUXvsWT4Wu4/qZHtiymWuNe0d2tT+55zEakDIzCbYYQCaHEGxjUp1G0FQjBLnBm1iz/UaKm2xotZYpesVLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+n1RwgF9LlWLfDgEKrj1rimlM0+d08FOOW5tM0x8Is=;
 b=xOfxFRWxv5dXQp+JZDkqB6Je5U7X2NVDISqUZVNLB156q9IY3ue+6YoX+jj6qSTBo0kbRwEB6H18z0KlFev8/1XoEZuD3F3mbKBgIGoFdfSJfsagp9MUWkvAMJ1O8WBpRQEceYLLCBYfkkQBbmIzq6ClSyCaszZ+y7N81aRw2La1szegdni3MkDRVr3+fCdV5WIJZXfGoK334AG26PEsOj+0lCx5u3A0cMNPE8ObhlOKSfPDj7W6i4ZrBvNVleuo60LVR/fHWWP5sEz/dQVT4SW1uRxwmIpw+j7yMzVsqg+vjPF9hGVWXyGSPUp2sn1EVT4tFVWaJ2CmoBj0FzcvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+n1RwgF9LlWLfDgEKrj1rimlM0+d08FOOW5tM0x8Is=;
 b=fpbw37fi59dlvvlSrFybQeyHc0FHvKYZ68GKLgR9I6QFMyxVT0wQRvbJalHf1ZuCBOsRbNr4gQE52BqX3bigtwZoRFq8ysvKlbPVBbw2NzJjziWfjCO2S3sVe0mWGMeAOGG150G8ccOX8vN2mMc8DLGl/S+a1JUD9VHZno4W69U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 15:47:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 15:47:11 +0000
Message-ID: <9d629ae8-e41c-4fd7-a979-c329852a50a5@amd.com>
Date: Mon, 28 Jul 2025 11:47:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com
References: <20250724135954.91568-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250724135954.91568-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: cad7af95-17d0-4084-5120-08ddcdee03e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YllCTGE5ZWYvcmRXK2tlUkdqb2xrT2E1cG5QdlByVGxnQlpoK0I2aVZnTzBl?=
 =?utf-8?B?bFNHbUN5aHVpSU5ycXc1NEFOQnEwL2tKSW9wOHUzdUg3bEhqZXNyeHdZUWln?=
 =?utf-8?B?SEtBV1BlWXY0Si9CaFBVZHRTZkRsZCtGRzF2ZEs1V3BmWUNMc01SbXg5c1hK?=
 =?utf-8?B?MUpvVHZQbkltT0dXV0w1bVpXVzNvMXArUTZCVC9XWUJyK0dMMFJsWnVUazl3?=
 =?utf-8?B?RHNSMlQ3WU9vZkxIQXdJcmNZdVByZGczK3E1Yk1mRHhER0YzVnNIcGVpM1lp?=
 =?utf-8?B?bFROVy9wZHZDL2NrcGw3Q0lnTEtaODhWSFJtZ2xDeHk1MXdnaXlTL01KR3Jn?=
 =?utf-8?B?NVZobXhlWjU2YzFjN29UYWJXWStaVmlSWjk1Y2pJTEdnbXN1dTM3Y2VjaGlL?=
 =?utf-8?B?aTZsTXZaTHVjK1V0L1ZYYWl1amROZjRKOG5mUkhIYnA0Q0VxK1Vac0FyejlY?=
 =?utf-8?B?bjM1WUl0TDcrMEk3Zm1XV0VIck5DbTBrQjZFZDZXRHM4dmFFY2l0T1BUVDhV?=
 =?utf-8?B?U0E0WUlwcXVkSlBBaDM0L0QzMmpLd2t4MUVHTkpmNGtiUTdKTW12RzlIdmda?=
 =?utf-8?B?NjhFdCtSTWNjMElPNnVCN3FQeUFLWjFMR0UvSWc3ci8zZTlTVjJtQ0Fubm04?=
 =?utf-8?B?dHBTNEJnV3JTL1g2QzBGRGVUdnRmWDFUbHJPZXl2MFJ0QjU3bFdZWjNTYXR2?=
 =?utf-8?B?MkRmZjdDSXdCb2NGRE5VR1dVU08vUUFvZmNEMmdDV0FSNUdnVlZVMU51U3pt?=
 =?utf-8?B?cGFPZjJuZ2VKekxrbWFWMVRhV0hHWTR2MHE4QTlxUHZNK2lTYXBkcUxoSkVO?=
 =?utf-8?B?TGgvMDVBNGNCUlBXTnFqQ0RjK21aSU1Ia20vaWhhSHQ1Unh4cDNyWG5ubS93?=
 =?utf-8?B?SExwaDFodlZwQjlUaU53UFBnblhTYzBpcUVYK2M3ZEdyV0VFMmFjTDBPTGxR?=
 =?utf-8?B?cFBsZkRWZ08yQXpMY2JsV2ZucmM3RVI0V083VGlsTjJwUHFTeUk4MCthUUJN?=
 =?utf-8?B?eU9DM3VoOFlac0lqT2loRWZJL1ZCZGlmOVhaMGhKa2tmVDVoMVlyQVFqWTBM?=
 =?utf-8?B?ODBmQXNwR1dUVXVEcUtiYWZCRDIzNVhJcktPaHFPb1VabEdYaVRITVBabFZ4?=
 =?utf-8?B?ZmtRa3Y1WFd6Ni9sVWhhNlFnQ2tidE8yR3kza2I1WndORG5wdWY0Q0RyNE83?=
 =?utf-8?B?WFNzbjJqeHFkREk1aUhac0pUamxLU2pxa05VQ00vQzVYV2xKeDJqeEo3bnVr?=
 =?utf-8?B?M1hqRlMySHBheGI4V1MxUnA0d2dNZzhFdjZlaDJGNEtKc2hNbzE3aS9VdVIw?=
 =?utf-8?B?ZzJyUy81eVBiY3lLdGxpeERsVUZkM01MVkNPekE4d3VZV2hMV0NQWXdvY0RQ?=
 =?utf-8?B?ZEpOS2s0K3h4TkRidnd6T1BEeG1ObkpaNkZ2K3VmeHpZMHBnWUZOalpudU9k?=
 =?utf-8?B?YlUyY0hxY0x2bVFEeUZvQkoyNi8wZEd2MVNySVlESkxxNnAza2NwaWdzVVUx?=
 =?utf-8?B?aGtjZHRKSXAvdlhkTGZnQnpTNkU1eUdjTzE3WVZOdDg2UldVcHB1a0NyYVpV?=
 =?utf-8?B?dXdLREFoWDRnQjhFaXpOVzZzZGNKdnR0VUpGVlZsUmlMdGVRcjA1ejg1WmJY?=
 =?utf-8?B?NmNhWVB3ZUxFZFcyc25FYytMK09KOEd2VnBmQmNtWkMzWTVhMTNaY2FBVXh5?=
 =?utf-8?B?L1NFbndaay9mOTdTaGJraEVtTVQwYzJPbm1Kb1dXQTZLTWc0L2ZOTDFlVEVN?=
 =?utf-8?B?M1B6NW4zWFNEdjJiZjF6SGh1UXJPMElFRUZlR3ArSDdzNjQxUGk3eFFieXND?=
 =?utf-8?B?Z0RUSWlxKzY3SWpHMnVLYWoxMDE3MUYwZTlyT3E4Y2xhZ3VibWcwVVRxeEtv?=
 =?utf-8?B?WXJjUDNnTmJKMFFjV1A4c1lLMmI1RGVDeXoyaWxudkVuWjRuYUdINnFUTTMv?=
 =?utf-8?Q?7XiGWdmHiZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdjOXZiUERSOFM2WHdzOXdrQUZnNjQvQjRhZzE1NVNSUG9lSSsxdG04VVY1?=
 =?utf-8?B?UzZucjJsdGxQUitEUXhGQlR1U1VGczFXcGt3dWRoRGNUcGhjN0FML29icHFk?=
 =?utf-8?B?M3I1TDBnSjlrelRIUXBMV1lqNmJNRnA2RDN0elByc3gzUjh5WTJQQzJqUWM4?=
 =?utf-8?B?c3pPOXZMbGE4Mnhvckthb1VnS1hVWlE4YUVzZHZhOE1OMTBzbTdyU0p1Qm1M?=
 =?utf-8?B?eGVZNjhMZEEwSnU1NGdrTGt4ekQ3R0ZsckVQdmtwTUY3UXd2MExHTThTbmUz?=
 =?utf-8?B?VWs0SFZPd0l5dHRqemxXSlV3WEJaUVFMNW9hTEVGQXBqVjVUV1QxWWhwRzFy?=
 =?utf-8?B?djRweU1oaFFhVnI3R0s3Z3V4WkJmcmVCbFNLWU1CMzdFSjRDRDBHb1BBRW04?=
 =?utf-8?B?WWkzeGJvQWNSOEs4TWFYREtFMXFIM3NkaFZwNk9ES0orYjNKQjZqbmJGUnl4?=
 =?utf-8?B?TTN6aG1yN2ZWdUNoQ3laVUFUVENzYXlVQTYzbGFmNVRXMnZicnN2eW9sQ1F3?=
 =?utf-8?B?aFBNbnE3TnEzUDBwUzlFTUZvWG16cmpVS2tlbTdLaE9lams3cUdGUmJzVDZn?=
 =?utf-8?B?WmhJcDhibk02clZHeG1DQktBS0RaNGNqWlFlSGFVTjFiN1JkWFQrdjZkdjdK?=
 =?utf-8?B?a1hyczQzKzk1YlpzRFVJRGw0dzFrcDd1Z1VVQklhRkRqMVJWeTUvNUV2Sk1m?=
 =?utf-8?B?blFsVmVvMGpHNWxUZGNmRFFmVVpTbTd3ZUJQeGczczA5Ykk4QUNldlVtVmJn?=
 =?utf-8?B?YkRITk9leDJUSDFrSFpaYWp5eTNILzB1Qm1SM0ZXVk5oU1dRNWtscFZUNmN3?=
 =?utf-8?B?emd3eHhwVS8vUy84RHdvdnJFTHFCVUJoZEVESVRhWDZ4V25XTHJXekk3SFZL?=
 =?utf-8?B?M1FwNGlyS3Z6NHlXWDZ4dld0Ry9vcXlQWjJjemlIWVhoekFpdjBONWhKUE5V?=
 =?utf-8?B?VHZlS2F1NVJqckYxMXZ3cUJ5UDBud0ttUy9lQWZyVG85UHExeVZSVTRydGYv?=
 =?utf-8?B?eEw0TlV3b0dOSFFFOTJkWldIOVpxK3YrQm1oRUk3ajBySUJNeExlODlvWUpT?=
 =?utf-8?B?MFF0d2NRd2NtL2pUMTFUWmRJOVZONFl3cTB2ZGp6am5ueTh0SWd2NThWVW5z?=
 =?utf-8?B?cDlrTldjdVpvTTl3eHlRZ09HYnRjbGZLdGx4Y01CeFhBVDhOUmlPV005WXFl?=
 =?utf-8?B?QWkwVWhuYkVSZWpURTRGbEFEVEZwY3ZLS01vTnBUbUtWdGJiYUt2SU14ZzFp?=
 =?utf-8?B?VG43aGtqalpLVEI2bnZ5TFlxd1V4MDVDYjNkdHU3YjBmaGM2b1AwaGNRU2F6?=
 =?utf-8?B?Zk5KdjZud2Z2eTVLYTJya3YwUldmaThSUDRmQ0Q0QjcxOU8yQWlJVHk4YnBs?=
 =?utf-8?B?UndhZ0dYazVWTW1sVlZOc1pORC9EelRoblhVVnhueW5CWXNTdStzaU14L0Vu?=
 =?utf-8?B?ZExKQ1pkbTBHWTV2UWtxR2FzaldhMDJqbkozenorTzNReUNmc2I2Z3NqMWFN?=
 =?utf-8?B?L1ZLckVVeHM5TnBIN20vc0tBSjl6UVd0UzBuZGJvS0w2Y3FncXB2SmxEUmdi?=
 =?utf-8?B?Vk1qcDh6TGNYMyt5OVZ1S0w0M1U2Q0puS1lPQjVtcnNSN1RMaUtDYTdleWxC?=
 =?utf-8?B?WnlWWHJWSDcyWGxHVWN1eW5DQjNEeUhuNDJET3paMDJFU1ZqTjFaQWs1SUhz?=
 =?utf-8?B?SlZUa1FrYStPTUhIVjdna20rWVBmbVJBTkQzSitneExZOWorTWRHbmlNWXlk?=
 =?utf-8?B?VThDczJUNHQ4WGJIN2UzTTJCclVpbm5BTFZmNTFkUHJVZWtBV25sQlBBR3NZ?=
 =?utf-8?B?eEFlaFI4WStvUzErYjVEMVdiVzNBQmY0Q1pBL0J6Q25WdFZtam94Mm05Q2tX?=
 =?utf-8?B?R0k2WXZ1R0JiZG4ySmUzems5c3ZhbFhKR0ZuUlU2TENCeklVMnk2MkZFeHpn?=
 =?utf-8?B?dkhNc3E5N2VCQmxCVnAvSHZ6RGFGbHBVdkxxbmEySDVieG5wU3NsZmNCVW5o?=
 =?utf-8?B?UzhSOStmWlFNaTY0cjl1NXkyZnd0Y043SDFrT0xaYXB0VitZNi9SVzBJY3g4?=
 =?utf-8?B?T2ZQUzhrekx1S05UQXZtcnV0TWRLclAwOWhKeWh4MkJkdHBVMXNmOTA3RVl3?=
 =?utf-8?Q?T5OEt+iU7p4r5Ri/NroW9wkrZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad7af95-17d0-4084-5120-08ddcdee03e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:47:11.0743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RDa7tBvcd17iooeZsXRWcgdhee6GHwJIah3/ll5VZXZcOJ7Mg3ZXt6DBGqst50Y1DKb07bO7vr8haTJgsDM0w==
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


On 2025-07-24 09:59, Kent Russell wrote:
> HMM assumes that pages have READ permissions by default. Inside
> svm_range_validate_and_map, we add READ permissions then add WRITE
> permissions if the VMA isn't read-only. This will conflict with regions
> that only have PROT_WRITE or have PROT_NONE. When that happens,
> svm_range_restore_work will continue to retry, silently, giving the
> impression of a hang if pr_debug isn't enabled to show the retries..
>
> If pages don't have READ permissions, simply unmap them and continue. If
> they weren't mapped in the first place, this would be a no-op. Since x86
> doesn't support write-only, and PROT_NONE doesn't allow reads or writes
> anyways, this will allow the svm range validation to continue without
> getting stuck in a loop forever on mappings we can't use with HMM.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e23b5a0f31f2..597b8ac92848 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1713,6 +1713,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			next = min(vma->vm_end, end);
>   			npages = (next - addr) >> PAGE_SHIFT;
> +			/* HMM requires at least READ permissions. If provided with PROT_NONE,
> +			 * unmap the memory. If it's not already mapped, this is a no-op
> +			 * If PROT_WRITE is provided without READ, warn first then unmap
> +			 */
> +			if (!(vma->vm_flags & VM_READ)) {
> +				unsigned long e, s;
> +
> +				if (vma->vm_flags & VM_WRITE)
> +					pr_debug("VM_WRITE without VM_READ is not supported");
> +				s = max(start, prange->start);
> +				e = min(end, prange->last);
> +				if (e >= s)

You need to take svm_range_lock(prange) around svm_range_unmap_from_gpus 
to be safe.

If svm_range_unmap_from_gpus returns an error, we should return that to 
the caller. In that case svm_range_restore_work should retry.

Regards,
   Felix


> +					svm_range_unmap_from_gpus(prange, s, e,
> +						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +				addr = next;
> +				continue;
> +			}
> +
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner, NULL,
