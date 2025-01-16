Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F795C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2771E10EA09;
	Thu, 16 Jan 2025 21:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKgCEHxA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F1A10EA1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8Kxkw+9UiHG6Mo8+Cly0j5OCoN4PAFxkpyqeAcam7w5474c5JxgGo2FvSrbvSlvPr8W5JS0OvxjvIB5f24YN+WUS1BTWbPATbv9zqB8curHnHoK9PIaTaccIgU4CG5gHpbYqKYWVfGWdWhHBvlk4OOQou6yEllKmrC4O5aFD2GcOf8vsfbLP0JRtIEZBicWJD9oA01Y6D7hDZDL5ytrww5tTptA75LinUILHkBmoO8IKaLyGkggHaG+qZ+yHlyedRi09xQrdm5ez4H9M8DGEn69Mf0sGpWcTXa/qbKRsHAGG2uEFnzsTK4DSCObDk9e35wuhEhCc8aMv7+VFyi0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igg3hfQuhF1ZwoZ5K1MgriRLc0VVd2+jCA1fg6Mrumg=;
 b=q6HnhKv9ZOf2NUv/mZTYPFs+FN3/yMf6xPAkdf7c2dBuRiaaGZryvWnEP6adItLBpM/NUZ0OcD7VLfidW7le0w9P3hUIGnlPz64ukFsjRciCn/a5yPoXtUwFitWU+yV4ggt0ApeJEaQcthynY2+vaw90+268KioYaxC3t0aX5rZbV1nVvdCOzNyK2B8HNg31uVMeNYor0RbIctxf00mVsVGJTHdWD8kVsetsPav4orctmgr+l4kGr5tPHXRfwPRMXLg2c5QJPTPGyAq0/zaspDCoSMBSE5o6YBav6sKGXCuSHh2rEbmCk79w33w5LgJq7JfJMrzWRIwNBrKh6JfTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igg3hfQuhF1ZwoZ5K1MgriRLc0VVd2+jCA1fg6Mrumg=;
 b=hKgCEHxAFwBIrmuPzW1gTw/kY6zx81MqXFsEjpWKhqK4a8ArrgrHZnhQ8CWDHryq0AWE4E1Xwtps1Yf0MP09kZiSxU8JZ2bCd4CLowWo6t2PbJnvz0Q9D3+yCRIH72aUyqO7vk/Jvisn0oFWYeXrlQRtlAgGs/u36VQaUK9837g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 16 Jan
 2025 21:10:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 21:10:41 +0000
Message-ID: <ad5875eb-9bde-480e-b7d0-44c87deb66a9@amd.com>
Date: Thu, 16 Jan 2025 15:10:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/15] drm/amdgpu: enhance amdgpu_ras_block_late_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <7634784000446c054de53387a352812e74f337eb.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7634784000446c054de53387a352812e74f337eb.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f580871-118c-4e88-db40-08dd36723bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTJGRkxqNWxrMktPOGppeW9IeUtXU0xEOTJUb0NrU08xRFZhU2k0NEQ2SWRm?=
 =?utf-8?B?bmc5MldwNm1mNVdKY2YzaTByQU9JczBDVUEvWU1IUlZ3cmo5Z2hOVjc0SnJw?=
 =?utf-8?B?eUkwVFZUK2trci9XWWhTUnJsclJUdlRUWUlmR1NzeGgxdnNlcVQ5WDVqVzVB?=
 =?utf-8?B?MmZrSnM2Z0NlLzh0MlA4clNiVEtVTWx3VXhJZHA2S051VGNPMUY1dFlubStn?=
 =?utf-8?B?Wk1jSFcrY3cyWWZNUkFlbE5Pdm1xWlJObmcvSFdlSDk0c2pnZkRhTjJkZGNF?=
 =?utf-8?B?WGFXcmQ5OFdyRHg1WkszK01WSVJDYlVjQVAxeC8zYlErTkZGQjA2Uld0VzhR?=
 =?utf-8?B?U0NHUEt4ekZCbHUvMmdkaU10TjIwS1BVWGllNEk3YVZ3NnpPRXFKdE1DRDc0?=
 =?utf-8?B?VzJORVhZN2JtbWVQanYxQmFzeklYNk5tSlBmaHFubFNVQnVLdXJrUGFuRzJj?=
 =?utf-8?B?Mk9yaFdNd3lleUNKdlZJNjZyQlREWGhlK1RmdCsrRnlReC8weE1LZUMvakt3?=
 =?utf-8?B?RFFrVjQxazU0TW42YXFBN0orRnpBdDVlM2xPbWNJSWRmWHFjRWVrb1J4QWpj?=
 =?utf-8?B?M0VXcHFjTW0wVXlRZWFRU2JzQnIzRXlXSUc5ZXBTS0tCVk5nOU1yRk4xQVEr?=
 =?utf-8?B?VHE4Ny9mU3JvRHNXWGtkWWlOME5HZGVLUUNQRGw0NVV5a05nalVwV0Z4ZU1y?=
 =?utf-8?B?Z3lyeUNRY2RzWnRuZERDajN0OHFOMTZsVWNWVWRQR3Rqb1czQXJwKzBwNktu?=
 =?utf-8?B?OTg4TDlyaWpMWHRYdnJ2c2hjRm9HTzF1cUt0ZTJGazlEblM2RXoxZWFIQ2VR?=
 =?utf-8?B?eFkyaU9uUGEyVzZMNnlOSU5oWmxZT2xGOVcrM1VEODJBNy9ySndMSlFtVEp5?=
 =?utf-8?B?bUw1TnVvMzB6aHJLbDRCTTQzUnJWREJ4V0d3WHZGdExJMUNQdDhaRHQ5RDVS?=
 =?utf-8?B?Z0FRZDZQSXByVGJ5MEI3VXpsWWhBR3haRWpsN3I2Zzh4ckFYRWhRL2dzSlVI?=
 =?utf-8?B?cHQrdWJSV0hTZk1SRkpyZ2Jnamo5eWI3YVBBeGV4bkJIQW45TTNWOW1WTTAx?=
 =?utf-8?B?UkoyOVpWNnpheE13aUk2UmFWNkcxTkFUNjQyVThYRHpFMlNLWjdPcXovMGYw?=
 =?utf-8?B?a2UvUGhsMWdwSzdKTWFmM2Z2WGlaRUc1eXNaZGxGb2cySHRkdzNXVXVMSnN5?=
 =?utf-8?B?SDlEcHRkSmhxT3dRVVhEdDlRcHFOeDF0aGpVbDRNK1B3Q29wWDVNYXVBem44?=
 =?utf-8?B?M3kyRmlYREl0QVlnYlBSakhCeGRMbVhiZnhXRGd1MjRYR1lKOVQ4aWx6djk2?=
 =?utf-8?B?MDZqRWcrRjNCSTRncWx0ZDE4R2JNNlFEM0lyRkE5dG1XMUU0aEp3K2pPUDVo?=
 =?utf-8?B?dXR4dldBK3VYVjdUTTkzYVRFcEJzMWtQWU5uenorb1piQzBCVXpsMFBZK3Zq?=
 =?utf-8?B?NWt0aHJlNlVGZFZVcjZmbng3K0gwai8veC8zSUJod3hjVmZNcWpTaVZIWVhu?=
 =?utf-8?B?czlZenVvb21Xa1M2NkdTRi9MVDJiUXlNSnJZV3lCeVlpdnd6a09rQUNCbWxP?=
 =?utf-8?B?d3hqRkhJdkFlTjdiczFoaGlpR3l0Q3FxTkJ1TmxiN0o4T1lCNFRzQnN3cnB0?=
 =?utf-8?B?U1Q0eFZHY2NLUCtsY002VloyUTFhVXVXdDF3bDZORDRvdzdkVlhNYnk5aFVv?=
 =?utf-8?B?RTJJd1g0cG5LS201R3NrbDI0eGtCUmFuZ2JvNW1qenF4YVp6UEgrRmpqcmcr?=
 =?utf-8?B?cWRiR09VRmlCdUdyVFZ0eDN1RDhHVnF5UGJtV3pEa0Z1Q012ME5paTRXbFRN?=
 =?utf-8?B?bVpPclpCVWdkeTdUMmwyZytGWlFiQUtUNVVKM1FxeFdYOUhXVm1va1JwUU9w?=
 =?utf-8?B?K215dWNqVlg3bVdHd0gveEFVN0ZEN3VxQU5lTk01YldkaWtKRHBQRkFRVFBi?=
 =?utf-8?Q?ffRczSygoiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUkyQkl4NDNMOWRxa01NeGFLcXNjZkJmc281T0lVVHZvSEFYb3gxR2diZXdn?=
 =?utf-8?B?RWZsejZsUkoxVHdsMUI2TEdZbFlCcTlZVG1EVzhuOTRXbTE1SEFSNmxkVUV1?=
 =?utf-8?B?UDBqVEpFSEZaTVFVc05oNWpWTWEzbXdLQzVEcDRlNlRXRjVsNEJGRnUvQXdq?=
 =?utf-8?B?OG5MNFFXTWk3eFI1bFBTNEplLzVab2NSYlZQT0VnaklwSkdJb2JuRkRuSkZN?=
 =?utf-8?B?K2lrQjRWUEZIU3hTZnYxNUlGKzhOOG51U2F0QnJraDY5M2Z4OXNUMklLMTdQ?=
 =?utf-8?B?STF4TXUzOENDRDN0b3k5a0ZwcDRHYUZDbU1xc2N0SVFrRUM2QXlkR0ZkbFBu?=
 =?utf-8?B?TEJJYVFFVXZSQlcyM0NTcGpjMUxtUDRWTWdnN2xsZ1NyZjVqQzlwMEhOa1NT?=
 =?utf-8?B?NzBONnJRUHQ1QVZlMFNqOTdJazhlbEtFRE1Ia0hJaVVhbUU0VmttbkoyRHNq?=
 =?utf-8?B?ZjQwOEt6d3lwUVQ1NmhmSUprUDJwaGVaS3Y0TDR0bE9EcURDcWo2Y2RFWC9s?=
 =?utf-8?B?V2JWUUlkR0RIeUdsM0tpTjRFQXBGUkZ0aldSbEVlS2FKa2hFUHVEekIzdWFR?=
 =?utf-8?B?cjU4L3BEY1JMUGdmczdaVHFpVFF6cnVGUS9tcml6MzdsYW1uOENEOFJqQXlK?=
 =?utf-8?B?YnYzdFZoN1VUUGY5NCthNGs0SGNGaHdYNHJ6dUQ3KzhqczR0b2VWdHI5L3Fs?=
 =?utf-8?B?bzk2WndIaXIzZHFGaS9RVzJUNURyTExMOU9iZHFKVGVQVGhRTWVuM1RrNXhz?=
 =?utf-8?B?QmZBMkJ1RzBQOTNHclo0M1MvTWZ0cnFVQ0N0RnRxU1ZMWjlrbTJpdWh2SWRi?=
 =?utf-8?B?cWRiUkxzSWNQdW11UG9UWXAycjZjajNkRXRwQzNCbk5aREJwNEFVaDRkM1BU?=
 =?utf-8?B?Y2VlR2VJcVdaWFM4RlRaRk00K2FIMVdsWjdoYkt1YTdQWEE1YmEwb2tDclRK?=
 =?utf-8?B?UDlnRTJaY3lMK2VKcUdpUHFTNE5KNmZoek0vK0IwZkxuM1NlWlN1WFNubkJp?=
 =?utf-8?B?clhBV1kzRUk1cTRpRkxKZURiOW1QZ1FnYTZ4dTFlYXRlOU5vYjVnZzhJTE5R?=
 =?utf-8?B?OEd4Qkt5L3BoQjRFK0JPZjNxNExEVzh5aEh1Tm5LL2FaaTRaM0pRcUd2K0pH?=
 =?utf-8?B?TXByeUUvaXdpd096RUhaOXBsNTQ3TDFJL1dkaXo2aFQ2cjlOQklKZEYvY1Qz?=
 =?utf-8?B?SWUzdWc4ZUd6RGVYMHNnUUN1V3BvOVFMeUdPYW5KSGJUNVhkRUpPMW1ueGhC?=
 =?utf-8?B?ekUxcFNIR3dndUowUjg3NFgzdDJFNXM3NW9saTI0MTFRUWdicm9yd2UydGxi?=
 =?utf-8?B?aWFudlROeHBmRFdFTjV0RHZTZzRYNWdNUmFBbUFIam95dVRaalRjMTExdlBx?=
 =?utf-8?B?Qy9pSDdkOERPSWYrT1JiVWo3YWhjOHJ1UTd1SVFYajdBeE5nYk1LUlYvdnFZ?=
 =?utf-8?B?SXFyS2VES1VYQVVMR0h1aTcxcGVkTzhhR0ZUN0RQUm1RaVgvWXkybTVNWWZS?=
 =?utf-8?B?anJ6MEFiZ210ZDhLbDVRT2tzeXNVdVkzNnNtMWZRQmtjRzhYNU1JSDUxNVVx?=
 =?utf-8?B?dGpDN21CeGc2ZS83d0huVnpPRVExbmNndWdlVDR1R1VwUEhYT1krczAzeUJQ?=
 =?utf-8?B?VTMzMU1RRmM5Um9nY09maVlBNjI4K3ErYktxb0t6aDQ2V3prTkJiRzh5UmF0?=
 =?utf-8?B?QVZRTStha0FIZDFlMUdXTmpVa0pTb1B2RENGRW8zSVJRN0o1OFpIVER4MzVO?=
 =?utf-8?B?aWdrV3Q2QldiQkgwMHlJQkZ4YmYrWGRaVkpTM1lRQUxMS1FvTUk0dGFmay9p?=
 =?utf-8?B?b3ZweFRDYjhQL3ZWUzZaSUx0U0NYNFF3VVdQRWo0VFVDSmtNZ2ttaEtmR3hj?=
 =?utf-8?B?dE85MGZoYXArWGZVemNoOW9XaUZ0cEtRVXlXYWZKRGo3RWwvWERUUlpEcXNM?=
 =?utf-8?B?Q0pRYVo5UmlmazlvZmRRRGkvNEpnMXdmRXdTQ2lQOGF3ci9VNWFaSitZSzlF?=
 =?utf-8?B?dm02aCtwUnNTMnUvQlNNbmoyK1UyMGlTaUUxdXlHTFNCMGg1OTdRbURPTkhq?=
 =?utf-8?B?dnlEbEh1VXJzY2pVUkorTU5yVVdSK01melpGcGdObjNUSm1lVVh3OWJXSEVL?=
 =?utf-8?Q?srCu4Z5WT8lWctKI28xpTlzk2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f580871-118c-4e88-db40-08dd36723bf5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:41.7924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtpg/bNyUf2eKP/KxaTcm3bmxyUiJZqb3GYRyUG8b+/1QO3HtTW6EFWH7Wajmhz0ARVOvHDy+mmx0p7EKgQs3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Enhance amdgpu_ras_block_late_fini() to revert what has been done
> by amdgpu_ras_block_late_init(), and fix a possible resource leakage
> in function amdgpu_ras_block_late_init().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f0cd14ff78a7..7bbab7297c97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4104,13 +4104,13 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>   	     ras_obj->hw_ops->query_ras_error_status)) {
>   		r = amdgpu_ras_sysfs_create(adev, ras_block);
>   		if (r)
> -			goto interrupt;
> +			goto cleanup;
>   
>   		/* Those are the cached values at init.
>   		 */
>   		query_info = kzalloc(sizeof(*query_info), GFP_KERNEL);
>   		if (!query_info)
> -			return -ENOMEM;
> +			goto cleanup;

AFAICT  you still need to set "r = -ENOMEM" here for this error flow.

>   		memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
>   
>   		if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, query_info) == 0) {
> @@ -4123,11 +4123,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>   
>   	return 0;
>   
> -interrupt:
> -	if (ras_obj->ras_cb)
> -		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
>   cleanup:
> -	amdgpu_ras_feature_enable(adev, ras_block, 0);
> +	amdgpu_ras_block_late_fini(adev, ras_block);
>   	return r;
>   }
>   
> @@ -4142,9 +4139,16 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
>   			  struct ras_common_if *ras_block)
>   {
>   	struct amdgpu_ras_block_object *ras_obj;
> +
>   	if (!ras_block)
>   		return;
>   
> +	amdgpu_ras_feature_enable(adev, ras_block, 0);
> +
> +	/* in resume/reset phase, no need to delete ras fs node */
> +	if (adev->in_suspend || amdgpu_in_reset(adev))
> +		return;
> +
>   	amdgpu_ras_sysfs_remove(adev, ras_block);
>   
>   	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);

