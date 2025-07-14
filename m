Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2097C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 13:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541AC10E025;
	Mon, 14 Jul 2025 13:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHJiaIfH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3BD10E025
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 13:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itNCEps/OLMn/gm0vCyD7qM2Zszn2y2tR4oXWzc+t7toNOyK4yh7xJo5Vh8ej7ytxh6qkueNMeugH1CO+3lktmxkrZM13W4Jgid3VDkkzV7lmFIWWUpqTXLShgnIuqWSt+YuH5Mb2EfEjvVmnJCgZN2GGHrHDTD43kS8jyaVpGB7gdiSRuGjdtUjcdToaRFf/z2q4RoEYjmM/MHTMKonHlV59f6H25Zih1oRrEta6KG5JxZZYeAVNY3iTkOc4k5Of2qRyb4momAztW9qESiHyqAH8kWgdtQFluw8N3AtWJsK+4P+IMS3zmv8t3BMVkSJkUb6tkcCtx/rtIWQRCOzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lffe+xHN1kwP9XnOSjusgTjPHA0FrmiJ8jYjcBFhVL0=;
 b=Typ8ISeQsKZECricVNZgbI4kULOh6GCl8s4n1e47HWLJLZqscaUEdedRM63BwgtwdK3ZryaMPeFL0oVeAM0Djbmyqa7vojogcONEOkwRN00C6QjMJTRE2gGfX6/0CRZuOR6u/r91woSlDa/8Z8VbnfZsRPYvLa1yfXxjYEfXTqGOFTPmwczgcq+D7daeVWXOedLFVVOw1yyOZgDsymFSb7aB/0DqzWiREQCZmUGJW+U5PiCycG0re4QLxhQEv+TjzO0M2uQESA61c/SaEQCbT+Yf7aaN/RwY8jU/QNGM6rfPtB5SlaEBuP+kH33y1OxFAPwYvovH+Awkf1hmpusAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lffe+xHN1kwP9XnOSjusgTjPHA0FrmiJ8jYjcBFhVL0=;
 b=pHJiaIfHVHX6673bpZAzAYsX5dtYv78uHa3Lq2qYYLO3b6YmOMZovDB1ADr56fPszDtWqOxLGoH206aWl36Y1L25S1K9F8qPe1JME7xEyhOoMXaCdefhVZOwA1CqyKQ3ll3WnbSuZ1jElVZVbm7+0MkbQZygYKNdf+gPVZyqXDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 13:36:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 13:36:19 +0000
Message-ID: <6f876bd4-6b5e-448f-b2ef-bc7cc78a3f69@amd.com>
Date: Mon, 14 Jul 2025 15:36:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] drm/amdgpu: clean up jpeg reset functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711224024.410506-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: e03aecc4-f989-4c86-6da3-08ddc2db6a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alZmZG5oWEViR2hNd1RrWHFLaUxYWS9FZ3p6c2xEN2JObVUrRlNlNXlPVnAv?=
 =?utf-8?B?R2k5WHpzakZ3N3VBMC91TFlFRHRXTlBuK1d2VTJybkJ4OXZWeEtZMnZFVnlF?=
 =?utf-8?B?VytNN1VXWk5UVzh0S1V3b1gxUjhvZU5Oa2V0b3FscWM1ZjVOd3V2aStvVUpY?=
 =?utf-8?B?c1lGRDBvc2FraWZZUHJtOWVZVWl2SlZQVzBEWUEyMitVcVpMcENKMHdZOXox?=
 =?utf-8?B?dSt0OEVmOUEwUWk3K2U4MTBnY0N3b3RQVitOc0ZRbTIxbHloWnJONWpsbVlk?=
 =?utf-8?B?Y2VQT0JhaVluMkhNZFN4QU9kTk00bnpLMGZVdk9haTd6RFBacS9GTHNVdDFr?=
 =?utf-8?B?Z3V5TXAxY3J6WUZwT0JiNS9nZGtOM0VrV00wSzJib0NzTTRHWXF5eGJsbE9s?=
 =?utf-8?B?ck02WmpPckg3Wk9LUmlWVFRackJXN3c4cDUxRWYxd3hFbjhJQnBpTmlaaGtr?=
 =?utf-8?B?R3NnNEdUSFZUelNtcWtST2pxOHViN0k3VWlqU1dUbitIemxyamM5RTFHZGhI?=
 =?utf-8?B?Um1QTi9jYTZzUGVFRVF0d0FiZ0JaeDVzQkVySkI2T1FaWUxRNnBVSG5NOFp0?=
 =?utf-8?B?MThlQnM5YTFKNDRXdWtNTHNhcHdld3UvR0xRRTRHZGYyU2dXclpQNFZZTDhS?=
 =?utf-8?B?WkZoUFNyZythQm0rOEovLzBqUVZidzFqcmxvSExnQ2VZcjJyRjZSVnF4Q0dS?=
 =?utf-8?B?Qi81NUxDdytIQ3Uzb0FwOFRtSWJJUGYvKzN6cmlDays1UTZIT2xQb1FnMW5I?=
 =?utf-8?B?NUZYU0JHa3BnTmZUQVU3TDNucUdoR0NlVEFHNFBYZ2hoY0tPNFpodjBXTkpK?=
 =?utf-8?B?c0k3M3Bub1pIRENrR01XZk9ESDNuWUhEeS9Zb0R5REFMeGRzeUJDcE40RzZj?=
 =?utf-8?B?TWd3c2NuRmI1NDkxaHR6bVhwdllEbkU1eE9iYk5icTV5L2VVRUVjb1BGbUdJ?=
 =?utf-8?B?QTNRTUJ6OFVONG02cjdOUi9yOHJBQkxEUGszRU9sL0w5TVJ1aE1HT0FmVHQz?=
 =?utf-8?B?cGVWQk5HWVd5YW9xTkE5OEFxSk1HaldaTW1VMUwwdHp0MVpYWjJYSTJQM0hs?=
 =?utf-8?B?OUgxUEJCeXFqbjR3ekNHdmNsUEo5SzNvTVgzRlg3enp1WitBNzVNWXJ3L1cz?=
 =?utf-8?B?YWU4N1Qyd3lLVGVLYlEybUljNWJ0Zi9jQnJFUGVKT1FFSERBZWt4RGRTZEsz?=
 =?utf-8?B?cW9ocTB1ZjE4aFhnTjlMU3EzdElRZXZJNWY4K20vK3pBSndhc2h4UHQ5Yy83?=
 =?utf-8?B?QzZ0RVE3N3JBT3dlaENBY2ZNWTl0RE1ab0d2MEZtd0xKQVQ4WXFjRUZhaGtI?=
 =?utf-8?B?QW1SYjllM2JIL0JlWEVMTnFQeUVpNi8zc3EyM2FDdVdkVnpvY3Q2bi9lSzlY?=
 =?utf-8?B?dUhRdnlrcytpeVpLU2ErQ0piL2dvOENFVUZsWmFjZzlGUk1vSmdxWmRHVVVv?=
 =?utf-8?B?bTlKNHNReU9Kd2FVVjYvSHpFUUVMRHRrMkJXTVFpYVVRWVgvYXZpN2hyalRS?=
 =?utf-8?B?bDdYNXFoL1h5ZnlqQVJiTnhyaFBaU1l3ZExBczlSU1A1Wkp4WU9XeVBtWnhR?=
 =?utf-8?B?SGx3SHIrUmd1SmRzOXh5RWtjTTdMN1lFYzVyN2xZWkllS2R3R1lFbXpVZTFi?=
 =?utf-8?B?dmRQVzlpSkZob003OVMwcHpqT2s1NnBaNjJwT2swQjNldENlZWVaLy84bVpK?=
 =?utf-8?B?d0JJS1Y1aFpSancrb1BNR3ZpT1BBQVBaZkdpZFVURUhmeUlSbVlMOWdPK042?=
 =?utf-8?B?K2lQRkUzWVJ5VWdGZWliRXBFUHI4Y2l5a2J4NDAwcXZvS0RaeGd2dVFNYnBj?=
 =?utf-8?B?Wk13bS9zak91U2p3YVdkd1lOZ0ZadUo1UFV4dlFoVGhIMHpyVzc1MVk3Q3RR?=
 =?utf-8?B?aXloY0hJaFpsWFlMa3RlM1NjT2ZwRmNvbUh3WnpDbTFtSGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29HdkVPditrclBtdHZ0UHRoWE1reXNDakpCSTFXRFBickFBcFo4dU12TnBU?=
 =?utf-8?B?Qjh2MDhwalpxWG9aTU05aXErTk82U0hBa0tLYjZVamUxS3B2eHpnaVdiWFVm?=
 =?utf-8?B?UDQ3YXBTMFQ5ZzRlUVZ1a1UwaUVGU21mUlVjcCtJcGo4ZmdtWXZtNEJNUTN0?=
 =?utf-8?B?MzVlM0QwN25RYytmRm9Qc25nSXpmeWs5SzB3anJ3RTNvMUxSNXZFTEtWcmhh?=
 =?utf-8?B?eHZLM29PRFN5UE5jbXBHT1JtUWVrbzNuUXRvMzdnYU93RFAxYk5kMm9qL2dG?=
 =?utf-8?B?RUlzM3hRSmo1OHFiRHhySG9CVEtTdEFRUUhDdW4xY0tKd2F4clpwMCtqdDhL?=
 =?utf-8?B?dEFqWVhoZUIvOFQ5KzQvVS9SMVdqVXdHZXgyb2FGeitzSzJEdkVuemsvSm1Q?=
 =?utf-8?B?aUJOS3V0cnJHcUFSaTV1cWlpT3c5YnN5Qm54VFNjQXRkWnhIWHJDWXhKMG93?=
 =?utf-8?B?c2xwVmI4L1NQWjBKSFNlVWRXWERsWXJuVkZqSzBwSldOQ1ZkWEp1WE52REEy?=
 =?utf-8?B?NUw4UHBNYkdtdXNvRzlQendlSHRjL0JaRXNjOWZHS0Vld0g3N1RoZ0d0Y0hi?=
 =?utf-8?B?SFBTRUJUQXUyelJiR01ENDNZaElXbHQzTWhQZWVlV2tpamFzRllsTjhCVXpa?=
 =?utf-8?B?MU1oQzBzZk9nMFRYWndZQ1dhUmFHMDNEMVo3bjA2aXJ3ZjUyOUFQbVJJVWk3?=
 =?utf-8?B?VjNyOWhPNFM4M05UZ1R0UXZFWXc2TEVpT0xldnlPVUIwVTJqajlZaXFqVFBZ?=
 =?utf-8?B?azF6aWEyelFpZU1zRldPU1NmQ1BVUzdHWC92cDN3WVo3N05MQ1FxOURpZW5v?=
 =?utf-8?B?b3krWkdWTHBSWm90RUJNS0lPSXU3Vk1ycUlaM2UyZ2gvV0o5eXY4OHE3Q3lp?=
 =?utf-8?B?YWpjNzNjS1hQdkdJQURESjJadDUycjBDVkFKaTdoYWJmakZoRjQ1NkY0Sm82?=
 =?utf-8?B?bS9GcW1sWW1UZnlDeXpPM2txekNnNFBiUE1wVVlhMlNNM2tyVG5pV0lHdGlZ?=
 =?utf-8?B?N3NkNXJJR29nTEVqL093TEV0RkhWWlRxN0VEZkw4ejl2QXoyQmM4NnNTVVRq?=
 =?utf-8?B?VC9RSVlKU1ZNZWRrNHI4UjVwV3hQckExUFVsNGgwaFRaTFB5ZnczWWIrRWtl?=
 =?utf-8?B?V3ByaU1HYUw2YitpNUVMUnRrN3BjUjF1dzdOUWpOWkNYdktHV0JCd2VNcTVm?=
 =?utf-8?B?RFVIa1BrUHM3UHVBTHhYd0dtZ09WU0wvVHpndUlYZndvM09SZHppUmxSZCtV?=
 =?utf-8?B?U2VIbkxRekJpeTExeW9JZEQxRzhTcmg1cmhQR2M3OVJZOVpSYjBsM1Z4NFFW?=
 =?utf-8?B?NnJyS0VnV2M3RDdsWVlKeVNzN0hHbU8vaWhzMzdwT29qcHR1UktyZGI0WmJ6?=
 =?utf-8?B?WDNqazBhV2lnWURhcFpKdEdTTG94R3MwVzMwaXE4NllpRXUxbnlGUmZRSVN4?=
 =?utf-8?B?R1BjTDc1TkM0VHdlUzRmSFdVWFNaRWhMNWFSWlg1bkZSS0MxZXo1cGpoeXlC?=
 =?utf-8?B?NEE3dWpSMkZiblVENUloVmdDeTJmNUpYNEZhS0hJMHd2RWJzT1orM0kvcU9S?=
 =?utf-8?B?ZFFzdjVFU3d1dXgvb20rcUxuZFdTN1hXNkVvZWNORG0yREhOU2FmZm40UVM5?=
 =?utf-8?B?OTUvK0V3OUx5WGRIQVZueHhnbTZRTGZPTHJLMGx6Vk9mSEhtQ3RJVXBZZUgx?=
 =?utf-8?B?aTBsdTJOYzc5QjhXTE0rRHFKM3p1ZUFYOW5ybjBteG5HbDZZc1VlbVg0Q2Ir?=
 =?utf-8?B?VUlsd0hXN29vTTJnSnU1N1NDWEsvTElaVXc1VXBjakdTM1E1Tkh1OWpiZVpP?=
 =?utf-8?B?R0MyUlkzTWdXWXRhQktnSnBRWmp3UXVka2k5Tld2cDlvbjNxa1lWd0JMYXBP?=
 =?utf-8?B?N2Q4M3NSWUFVTWt1aDdkVE5UTEtrRmo1UGd5QjAxT1ozcmd4bkEvWkRyMXo1?=
 =?utf-8?B?V1hRT3p2cHQ2VkQ3ZE5RQlJTYzBKbm9pSis1ZVY5d3hOUTRZVFJuZFFCMkZG?=
 =?utf-8?B?K0h2T3JaU1I3RGt3SUwwTm4xZWpZbE9kUk11Mmx6aSsxclFBVDc1b25Benhu?=
 =?utf-8?B?MVd4RzliUEluV0dNNzBYYlBWYlJNd2IvQjBGYjRoYkg0L2p3VzI3c1FFSC9R?=
 =?utf-8?Q?yHL4lUSiZaWRtTrpwFoJgGllC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03aecc4-f989-4c86-6da3-08ddc2db6a0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:36:19.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpXxrQJx5jNvVux2v9qmzd6yQcR4OHj6gI++kAd7gUg7rNv9ePiYId9DxIoZcdu0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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

On 12.07.25 00:39, Alex Deucher wrote:
> Make them consistent and use the reset flags.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I'm not very keen on spreading amdgpu_sriov_vf() around everywere.

But for now Acked-by: Christian König <christian.koenig@amd.com> for patches #6 and #7.

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 7 ++++---
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 5ba1c5ad9a5e1..0b56cb67e8f1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -118,7 +118,8 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> @@ -770,6 +771,9 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>  	drm_sched_wqueue_stop(&ring->sched);
>  	r = jpeg_v2_0_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 5be9cdcae32c1..3d0e61f9f2854 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -167,7 +167,8 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> @@ -649,6 +650,9 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>  	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>  	jpeg_v2_5_start_inst(ring->adev, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 5428930eafa3e..5d54c882d889c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -132,7 +132,8 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> @@ -561,6 +562,9 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>  	drm_sched_wqueue_stop(&ring->sched);
>  	r = jpeg_v3_0_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 78fe1924f3cb7..5485e983a089f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -143,7 +143,8 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> @@ -726,8 +727,8 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> -	if (amdgpu_sriov_vf(ring->adev))
> -		return -EINVAL;
> +	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
>  
>  	drm_sched_wqueue_stop(&ring->sched);
>  	r = jpeg_v4_0_stop(ring->adev);

