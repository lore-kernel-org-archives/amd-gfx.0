Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA2CD66B9A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 19:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F0B10E2C9;
	Wed, 17 Dec 2025 19:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QQx+p6+V";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030F110E911
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 19:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QStMiJz2cMnuMNnTlc34aFjN5CRGgU7FOjlIhXhloEixjaF+L8oNwLwB0U+qN65ytn0zy3whXHfqa1C8zdf1heiinx4bSZ2DSZ67ZInswmoS58a+a0qKoNFMfbj/FSyWLDO7GUR1IrCsYpCuRIJ8mKtBUqHQcsCqmDm17QlspwIPf0urZ/Pb+iUP/zsWC1Nyaa3PtkNpajHSTZCyhmtWfVpQ4/a1TTwAmNRQiN/jvqvlOamg6N23Ek97OSdH67lpnVUh8kgk2iU1Eeg8fJbDG9jFvlgcFQbp/bJpaEnKAWX/KP4dT3yLV1vt35aUjkIu+EX2fnP+OJntmoSZZnPOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F2aaaPWpKV41xTV8qAy/Sj+skOqxzqL9UAeN6YtuME=;
 b=NGK5EGFxc5XCJUE+orOojp94OujKGDoXhQh+fszZc52Kyv7cZy3lLyos8a99kxJ6R7ka4PeaotDlBnUVs+tnRThAJGVXpsFRNysYTKhJNHxaZ95QXrp/7xqyJmNYzJhCvgipafO2et3+drcBiXW7PBbCKpfLg4QPArC/VPo+Yu0Y44uXh+trUHAjy9qyzDsPDV10PjkTIzPu+fYpTmXoySAyeq8kX0nJl/lR+/D7YgfmQC1K6hINnZOaU/eCLRWi37uuOzjNmSONn0EJb+xrceMk0bRROIAfLTPmZ9OmgEyw+NCkYLebHsXLntcBYCLUxNKLWPL4tJzihF3Yw74qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F2aaaPWpKV41xTV8qAy/Sj+skOqxzqL9UAeN6YtuME=;
 b=QQx+p6+VX8DRJkPUE4cgrCDNlIhAZeeoEucueiDcvAPD6LLeiHauTYBayrCmEWK7F+LF6JGn3VtQbZWA0nz5ol5KpYfBePyy0esFVbFJKit9WFYFzpOuAhvlLF2ffJDu9axyZ5BNOIk8pw86V/ImXPHy/MTmVAVHTZn5OqjvVZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 19:23:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:23:37 +0000
Message-ID: <7ef7c1d6-44f9-4819-8c32-887affc0cbec@amd.com>
Date: Wed, 17 Dec 2025 13:23:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu/discovery: add vcn and jpeg ip block
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
 <20251217153521.2018841-3-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251217153521.2018841-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9)
 To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8cb7cb-ca58-497c-8c9e-08de3da1c6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1VLTFUxTGh4OUVXUGVKUHVyMURNcWlneDV6Rk1tR2dxaXc0L2I0bGcyaWl3?=
 =?utf-8?B?MXRld1FxNlRMK09mRmhzZjZBd3JFbTVTbmlKN1JaYUEvVmRsUUI1N1RCdGUx?=
 =?utf-8?B?eEFtSE0vaHhCSTBNNFpkNGVmSTBsaU92SXVPYm5zT05KdFlFYUlySGJuQnMx?=
 =?utf-8?B?b2U0NmNKeHhteDh6cS9DYUZZa09tU3RGOUxrUlQ5b0FYSGpxdStkUXlXTU5z?=
 =?utf-8?B?Q2tUZWJDQmFZWmVLclNPWkNycklrdlI1UkcreGs2MGhnM1BobnF2ZExwWmNi?=
 =?utf-8?B?anpWMXhldmJQMU9pRzQ1aDROakpkL3lkZDJ0RGp3dWJkbmVOUjJHdnJOMG45?=
 =?utf-8?B?WkRYQWVqcnlDa0VaZDJiWUxORXZ2YzJveWorN2lWSS8rMGVXRUtmZVJqMkxu?=
 =?utf-8?B?a3VMdXRzZEEybTQ3RWFRQVBzbnJzOVFqdTNBamYwU2VFZnkzdVYzY1F1YVZx?=
 =?utf-8?B?M2tSKzdhcDJZUUFLeUkwYzdKRTUyc3R1VlNYc0VMdzZyTnBCVnRCZndSeEhr?=
 =?utf-8?B?aEhDUVZPNzBqSTVGQ3cvU2hZVEM1YS9vcmRtejVDQmRiWllXZVVnTCtqVDNW?=
 =?utf-8?B?bTZramhtcE5KVTE5bTVibTVKRUREQlI2NitCTlFBNFc4R2YzNHU2RklMNElV?=
 =?utf-8?B?K3Z3dGp5a3VPTTUrc2dJYnFGQzdZZWJQY2J2VDY2cjdUMlVVTHh0UC9NdDlU?=
 =?utf-8?B?NC9CQjBqcWxSdVlkRGtmaG9QSFZWQW5uWjVoQXVEYU15UGltWkVRcDhGdloy?=
 =?utf-8?B?ZlIzalBXSjM2Vk9sdHRsMWhGWVIxZU9pYnVPbDB2T2pSd1FTdGdQclNEMWcz?=
 =?utf-8?B?Z2FTbFF6cW5TN014MnZBSjFuclJTaUxoMmZzTGNaSzVjZUkvU1dKaWxwRStS?=
 =?utf-8?B?ZytnSTVDUmFTbXdNWkZQVy9IYWV6Y3VBSy9uc0RTdkhWL2ovOTd2WGptZXlM?=
 =?utf-8?B?Mk5PLzJiZUcreEk4MVhBUkR0NkI3QVBES3N2dlFmUmlDUnhHaUsxc3dsbU1N?=
 =?utf-8?B?eFhrd0NmY2t1UkZxeWRIVHgyajJyaUNYUTc2ZFZwTGc5cnlvQXF4VkV5aHBV?=
 =?utf-8?B?aDc3cXN3WEdwWGt4QjNBdnljSTFBUHVBckVVMWxHWm1WeTBBbHFJeWdObUwx?=
 =?utf-8?B?RWsrZy8zWGNIVlBES3RldnFnTWU2SXRFVlhZSHR5M09jc0FMOWZqZGFGbjlO?=
 =?utf-8?B?Ym9sOU1qWHoyV3RvSXJtOGJmT0U2dnFvVmtXQXRaT2lidGNzckt2RkZzNXFG?=
 =?utf-8?B?bWNZYjJRL2ZBZTNWKzVvbTlQcEhqQk1CbG1Wa3lIUE12T1JqejZveW1DUmhq?=
 =?utf-8?B?TFB1Rk1yRC9pRHlWTXNySVVBdVBhanpRWTVMYUxycHNnOGJpdThqTXNPYWhV?=
 =?utf-8?B?WjVMcHJSUVBKTk8xcE9wTGhLSG5jYk8wZDVLTWI3TTZ4dmdOd1VSMW1GOEVy?=
 =?utf-8?B?bGdpMVg3Y2pPSExYeEtOMDVEZCt4UXNNZmtBUk9qdzN3eUtsREtXK0Fzc3Q0?=
 =?utf-8?B?Z28zQ3JjUWdIbkVQbFhYMGZTR0NZemdlcWxtRXFMSzJjMGpmSktUVUZZcHFE?=
 =?utf-8?B?NHFQbDlZbk9xcHh2eWl5YkRTckFUMVZKNzhCNEhsUUlVSXdpNUpQTTdQVzJV?=
 =?utf-8?B?cVJCYVlQaDR2Z05lQnd2dkhFbkduK1ZmVnJZTFFoYzlSQ1pGYXl2ZzJxYlRJ?=
 =?utf-8?B?aEs5a3VqRHlqS2h5Q0cyTEtwbXFXUldCYlM3TlhlRXkzVjJWeEdPSU42RTNr?=
 =?utf-8?B?bUxqalp2UTk2cTliNU1VeXJCdWYrT1BvRU8ydWtWYXppc3hlWElucWE4WU51?=
 =?utf-8?B?cmlKTkZMNTZQUXZOTG84QmRaSUlTeVFTUTJMbm16dkxKeFJTZlc3am9YKzdz?=
 =?utf-8?B?Q0ZKSGpybWdGUkxhR1VSYlB5aWx6b010bDlrbFlkT2hGUitVemRLd3h4KzYz?=
 =?utf-8?Q?hcJWaiOz/dl+6Uzrdj0lvMwVrwoM4ZAy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9IczlrZ0Y0THRNczJLMEJqUTUyaGJaWFcxMExQU0tlb1BITkFqL1EwSlNF?=
 =?utf-8?B?ZEJJZ0xPVjVHMEY4ZVc0S29xSG8yY1dDZUhFSTJuYnFCQytTSEMxczBvOTl5?=
 =?utf-8?B?N3hqcU92djNFdjQ5SXpxYnZva1dIanVTcTJTdERGTHk3U1RzUmhaVDRzNW5x?=
 =?utf-8?B?RG5uZHA3ZTl2T1pJaTIvdm0rbDlGeVh6TFFsZXJxTnZvditQeGhDZ3l4aUNE?=
 =?utf-8?B?Ujh0Q1VjaEYwcGQ5T0FES29seDEzVTlrTzFwVmN6bGVzLzJXaXN5eCt0bm1u?=
 =?utf-8?B?b0tab1hrS2ZVd0l2MXdTVW1iZlBMSFRuYUhPYXUrNmxQUXZBK1RkTTNsbXFT?=
 =?utf-8?B?eWVLQUZGVUlNcHJjK0xMdkFTQXJWRUN1SWhGVEtnS0hZbURsREhqSzh4Mm4w?=
 =?utf-8?B?YTE4QVdNR253ZnZhNTBmQlV5TlhnWUEvZ3hnMHFtSWdCQUhkL2krTC9Cd2ZL?=
 =?utf-8?B?T0lMRER2bEF5N0xINjRMVmU3SWNWc21IM242cEhMWitQb3dOZVR1bGRtUi9P?=
 =?utf-8?B?U3diZFl6SHUvVE5TdzE4TUZ4UTM2Z2htYVpVeWJUYUZ5cy9ibFFINm9ITno4?=
 =?utf-8?B?VnE3d1dFNTJzZUc2aitXZnJoNUgrUjljU1JhS1hCbktlMVBXeitjd3dkVmhU?=
 =?utf-8?B?U2JpWUtsU1haVE9WazFINEg1U0RZajBuWURrT2Yxc3FxYWZPUkRZZjhBL3gr?=
 =?utf-8?B?N3Q3MEIvVkhzZ1JaZlBnNm1IVWp2cTNFaTgrNzc0Ymk4M2l6c1orMTZ4d290?=
 =?utf-8?B?UEF5dmExbDVxMlRLRTNkRzVZV3A4bnJ3RjhaR3VtV3djNko2cmVOVkNWU3U4?=
 =?utf-8?B?eUhsQjNSMlVZeEFvcjM1aWF6V2w1c3dodm1lQm1aSUc3cldCMWxkcEFqSExO?=
 =?utf-8?B?c0ZGTW12UWtXdUpoVXpZV3UvVnBUdytmMTB3R1I4ZE9YSWtLNVlGekpQNTBq?=
 =?utf-8?B?bjFTdXZqK2Vqd1pJTFJUMVQyb3ZDQ2ovQkVOT09IcHZhVlhYK2NXcmlTcEY0?=
 =?utf-8?B?UTF1cElHdXRwL204UWREL3hRMDk5YzAvVjJ5UExWcjd3ejVQVVRJWitxMXFC?=
 =?utf-8?B?MHJrdVdXWVhzWkdZaDJRSVovMXA1KzhDbjNPREViUmFtS0tKL0dTaStVUUhN?=
 =?utf-8?B?ZUV2YUNxVUNaZUd2c3A2b1Q2dW1KRHVpS1BoVFZrNFFBN1JyMWFZZ2hkN0g2?=
 =?utf-8?B?cFdXTEhVWGxHNkxVMWovdHY3UDMxN1UwSThENHVsaGpGaDNuSWc1UG9Ncnpl?=
 =?utf-8?B?YmVmVFJvNEtZUVpqTk9FU2ZISVJ6RjVSYU5DbVBjYlQxb2dlMGxobDhObUhX?=
 =?utf-8?B?Yjg3OVhaSW1jSERic2ZxOGx5UzAyTXdKNWYvYUNYbmZweG9JUEl3bVZBamNV?=
 =?utf-8?B?ZElGV29sb2lxYXpyQWlpMmowNUQwNklYT1NlU25SZFlWMTJSb09YMWFKMGcv?=
 =?utf-8?B?dHBQenM0UExGQ1VybkxqNzlQZFhEYjFCVnVaUlBWbmd1OU9mS2xEdlg2dXl4?=
 =?utf-8?B?Y3NrWWFERzlNSjYxbVE2eG9wSXRSTUdZVDdlWG9KNFNJMWtFTU9mUXMxNjVZ?=
 =?utf-8?B?WnBpaWNtSGtDeDNUZkRCQldrNG5vUlNVdjFPQjVmQjdmYXRSVGxJbG1tSWI1?=
 =?utf-8?B?T2MrczNVdU9TYXEyQytGNlhNYkRFRlVjdm53K1hIM0lvdjdJYjYreWFWYVlm?=
 =?utf-8?B?SGNqS1I1NkdtNWF4L0ZZeGIxQmVPbzBXUElMRE8vdlp3dFB0Q0ZjOXZWNzAx?=
 =?utf-8?B?NmdaUWxMK1FZMFY1eWhCeTc1T0VCY1BYZURiSWhZY2JSblMrZ1AzSFpKcGhO?=
 =?utf-8?B?UjJVY1RKdFZrekRQdklXalA4S1RXSjE4a1NOd3BhcXRoSnNjMkQrTUdUcS9z?=
 =?utf-8?B?bXAxbzllWmxmZCtZUFpXYXNMYTd6VXJ6R1UyM3VJd3poY3lmNEtLNTRrT2Nt?=
 =?utf-8?B?YlNlYUx1dXd3LzUrWUpWV2grSElFV25EaE9ZWVdOTzU2TnArcnBwdnJYODhq?=
 =?utf-8?B?R08xTWgyVlVZWEFCV1hXRzMzZEtma0hscFBPNklCSGdHaHJSQzVNR2svcDVh?=
 =?utf-8?B?K2prajJscGlTeTkwajIycFA2Z0lkdFNic1JBelNEaHNOMnBmdUcyRlJTQ3ZQ?=
 =?utf-8?Q?Lqwe/zpcIAk1cpLNeTqEqCwOH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8cb7cb-ca58-497c-8c9e-08de3da1c6ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 19:23:37.1121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gwcbQE7YamSRd3OmUEp4F7UeKbVJXxq7i3Xxf+he7pItWlwNv3qV8Ja+oEAmq6vN9UUUMs5Q3KqTY7WhHDkWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

On 12/17/25 9:35 AM, Alex Deucher wrote:
> From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> 
> Add VCN and jpeg IPs v5_3_0 blocks.
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 +
>   drivers/gpu/drm/amd/amdgpu/soc21.c            | 39 +++++++++++++++++--
>   3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ac1b95b9a4f6a..43e6216ca30f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -112,6 +112,8 @@
>   #include "vcn_v5_0_1.h"
>   #include "jpeg_v5_0_0.h"
>   #include "jpeg_v5_0_1.h"
> +#include "jpeg_v5_3_0.h"
> +
>   #include "amdgpu_ras_mgr.h"
>   
>   #include "amdgpu_vpe.h"
> @@ -2538,6 +2540,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_block);
>   			break;
> +		case IP_VERSION(5, 3, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);

This seems like a mistake.  Shouldn't there be a new vcn_v5_3_0_ip_block 
that sets major and minor properly?

> +			amdgpu_device_ip_block_add(adev, &jpeg_v5_3_0_ip_block);
> +			break;
>   		case IP_VERSION(5, 0, 1):
>   			amdgpu_device_ip_block_add(adev, &vcn_v5_0_1_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_1_ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 5e0786ea911b3..75ae9b429420e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -63,6 +63,7 @@
>   #define FIRMWARE_VCN4_0_6_1		"amdgpu/vcn_4_0_6_1.bin"
>   #define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
>   #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
> +#define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
>   
>   MODULE_FIRMWARE(FIRMWARE_RAVEN);
>   MODULE_FIRMWARE(FIRMWARE_PICASSO);
> @@ -90,6 +91,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
>   MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 4e24aeecd9efb..2da733b45c21a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -141,6 +141,31 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_video_codecs_decode_vcn1 = {
>   	.codec_array = sriov_vcn_4_0_0_video_codecs_decode_array_vcn1,
>   };
>   
> +static const struct amdgpu_video_codec_info vcn_5_3_0_video_codecs_encode_array_vcn0[] = {
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
> +};
> +
> +static const struct amdgpu_video_codecs vcn_5_3_0_video_codecs_encode_vcn0 = {
> +        .codec_count = ARRAY_SIZE(vcn_5_3_0_video_codecs_encode_array_vcn0),
> +        .codec_array = vcn_5_3_0_video_codecs_encode_array_vcn0,
> +};
> +
> +static const struct amdgpu_video_codec_info vcn_5_3_0_video_codecs_decode_array_vcn0[] = {
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
> +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
> +};
> +
> +static const struct amdgpu_video_codecs vcn_5_3_0_video_codecs_decode_vcn0 = {
> +        .codec_count = ARRAY_SIZE(vcn_5_3_0_video_codecs_decode_array_vcn0),
> +        .codec_array = vcn_5_3_0_video_codecs_decode_array_vcn0,
> +};
> +
> +
>   static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   				 const struct amdgpu_video_codecs **codecs)
>   {
> @@ -185,6 +210,12 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   		else
>   			*codecs = &vcn_4_0_0_video_codecs_decode_vcn0;
>   		return 0;
> +	case IP_VERSION(5, 3, 0):
> +		if (encode)
> +			*codecs = &vcn_5_3_0_video_codecs_encode_vcn0;
> +		else
> +			*codecs = &vcn_5_3_0_video_codecs_decode_vcn0;
> +		return 0;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -800,9 +831,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   		adev->external_rev_id = adev->rev_id + 0x50;
>   		break;
>   	case IP_VERSION(11, 5, 4):
> -               adev->cg_flags = 0;
> -               adev->pg_flags = 0;
> -               adev->external_rev_id = adev->rev_id + 0x1;
> +		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
> +			AMD_CG_SUPPORT_JPEG_MGCG;
> +		adev->pg_flags = AMD_PG_SUPPORT_VCN |
> +			AMD_PG_SUPPORT_JPEG;
> +		adev->external_rev_id = adev->rev_id + 0x1;
>                  break;
>   	default:
>   		/* FIXME: not supported yet */

