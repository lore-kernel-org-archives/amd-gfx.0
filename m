Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5BEE6BF1B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 15:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5831510EA08;
	Fri, 30 Jan 2026 15:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RZ9TVra7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E90C10EA08
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 15:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR25700Clzx7QKPGIpkjIUvfUoZcPKZo1cYq7LbEi/N/fdAZzf9NM4mT7DGYsJp7ZwuG+2NdLVZZjgOq7z1THxZqmZRnIVlmheUJtcVh28QOluH3+39+pvGnc0wSPea6rBI6++PYojSUm9c2JlVNLNgfWFrCPBrTubnDXwZ5s4FHnVCkilTxstZIEozufKXXNkpkG+ZCSz8u1sVnd9uzt0Pjr+w+SrwhgiQe3KYHB1tv6FV03m7RfAE4Pb3A1Sio2StMqkL6elGHjDQR5lpPDQ2oXubNq2FnVhqY2fYteTsSNE0rR6C4eexN7BKyDJnT1o7duWvdyzaULAr2IFgBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOJ9FS63J5+E0uluEdbhBnN2SkCvncN8iCJ6qeEe6zU=;
 b=mVdyV/qqqypsvrD2pdu5UoEJBK+R9jeOh6f2lnqvb+DxSa9wdSvHadwMavp1nZOBjgsUJaYMjsjLNs10L+vYYxeYBIWfKpiPAnA9rs3CIbON+w/UnlbD4LOlpPrmFGjpcUNOGnZCDdNG/NYoCzgxJcGBFPuyqVmxnUosbj9gbSkoluj176Xld30Hii3pbooyK4k4Y8100QCI/MZhszPpNfN28t0walXQVt3m9aAaDhHwH1cjeNlnKTADqvPE1pNkQj+l02QorbDe+XlFCfeCYxNRsqaSTOTvFDzGlo9mBfv+hxc2cDk4AhRnd3bcs5mMSJurOnHC4KLpz+Cb/t8Q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOJ9FS63J5+E0uluEdbhBnN2SkCvncN8iCJ6qeEe6zU=;
 b=RZ9TVra7kLW6p7dH+33mEj8w7mltyq0HEoXhxVy2Pm/9fV1sB8WNBmjYfBLr+dyGWj7FKiG7mfjfUEhlxoJVuyKESAtCaTufJyxPH87ejBQdpWbZ1q9HzZ3b3l/F6a9aBypRsq91Pgy02bCyky/uviLaWnmkDTsXVjwim0aiFhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 15:05:16 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 15:05:16 +0000
Message-ID: <42191bbf-6f92-4883-8aa9-9e808fae3e8d@amd.com>
Date: Fri, 30 Jan 2026 20:35:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Yifan Zhang <yifan1.zhang@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
 <CADnq5_NU4Swq_n12A6HXD+YRRcXahFMYxa4pLHT2-WX33tfgzg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_NU4Swq_n12A6HXD+YRRcXahFMYxa4pLHT2-WX33tfgzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d05dd21-9f7a-4a91-abaf-08de6010f9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yjg0MkJNeVdjbUt1WFR4RlZJWkJmV3RXb0FNeUdWRDE1MnJVbjZzNjZ6RnNZ?=
 =?utf-8?B?dGZQVUNtTjRUcE5WK2IveHI0KzFkbGNRMGw0ZVI5OXFtNHVBVEd6b1EwK1I0?=
 =?utf-8?B?akh1bThIRXVINHRTdXF2WEVvNjJOQUM0TnRpODRaTk5rVXN0MlV6SVRTUG9V?=
 =?utf-8?B?blBLYUxhZTF6QlhIdFdudTFYZHAxaHlUWm9wUytGOHpEd0dabmVhQlBtNmc1?=
 =?utf-8?B?MXMxb0h5cmJpZFU1UTU1aXkydC9EaDUvMDloVUxPOFE0cU1PWm5UcWh6TW10?=
 =?utf-8?B?QU9pZnZKYjFOR0M3VXpQVFZCY09uaGE2QUNpY1lpejU5RVoxZFM0aEtmb2c3?=
 =?utf-8?B?c3hWM2RiejArTTlQcXMwSTIwNDdMVm1KOWpZY2FDTnpBL2FZS3J5a3BrbVJU?=
 =?utf-8?B?VndkVUFDRnJoODI3UWFQYzRkYVZaU0xUVldmS3RyMjk5bjhwMktQeWZQMzRW?=
 =?utf-8?B?b2N0RkFna0VwMVpnYXZ2UEtZNzJqRGY1UnlvUkh0UUZnMmJZTFEydDdWQ1kw?=
 =?utf-8?B?cnI1Wmp5QmJaZ0Nhd3I2QnJrTit3T2ZaaEUwcG1XV2NiOEJPcERJa1JQZGYz?=
 =?utf-8?B?VW5lZzJiTE5ONWhFTnpZYzNqMzY3bHZJbEx3cFA0OFRnbGs0UVBtREk1VzVI?=
 =?utf-8?B?d1FhbW9PYlZjcTFic0ZEZk5WQUVOOGUySlVZa2R1VWorWmZLQ1FzZU1JUzJU?=
 =?utf-8?B?c2lKdmhpbmx5SGhOU1V0QnFzSUpZbkFTaTlTMGkrS2NqUzBYWldSR3IwSWlt?=
 =?utf-8?B?UzFaODB3UUZVZEw1RU9FYTZFNmRaeFk4ZWRxYnRoZ0RyT2xlOGVKb1VBK1cr?=
 =?utf-8?B?S0pNZHNJdW5KOU5JQjY2bi9JNHZmVGYyOSs2Y0plWS9JRVRQbzk4WlFNYTQ2?=
 =?utf-8?B?TmZiK2szTDNad0I4clN0Zy9acDlPRlNtOXB0QlRHSXEvNnVsYWp2Zm1tUHJp?=
 =?utf-8?B?d0FkdVMvdk9OTzFwS2d6MWs0aThEcEdoUUFoL3hhclBmNlcveEljVVAwL3ZE?=
 =?utf-8?B?S3gxNUh1dUZzZ2E3eXFrTUN5aXNtT0k5STd2R1Vxc2w2V0hmN0JQYmViRWlF?=
 =?utf-8?B?MDdXaGp3c2NGbDdXWXR5S0REbXBPc2ZBQVA2eDUrVy9VRDdxNjR3azBhdmhL?=
 =?utf-8?B?emhZWCt6aHlLVnN1VFBTaCtaekFKTGUydTB5emNsVnppTzBEYk40ZTdNWk1O?=
 =?utf-8?B?VjdFL1R4Tk14bnpKMGxVWGRyQzFaNVRWWk54dTJjY3Iybkh3aVV0L2JXalpV?=
 =?utf-8?B?Sm8yR1pLRDc1Rko0c054THQvMHN2VzllR0VEZWpveTV2UnpPa2ozNWZ5RmxG?=
 =?utf-8?B?TTlmVVZNMTd4UlEwenE1TGc3OXhybXRXNEozSzVIeVF6VzYyVHZENW83TEZw?=
 =?utf-8?B?alcwUUFTMm4wdG13eDVjZVJmWjU0dkZEZWxXelJqT25rcDkrdXdFTVVtdDZq?=
 =?utf-8?B?dlRWbFFJQ0p5MnhqZTVMTFFiUEd1VkgxUUNSbzFXeHdZUFNlUS95MFNSRWx2?=
 =?utf-8?B?aHlCNmtuMm9uRlVlUUozTjRxdVZTQ1Ezd0tnc2VzYmdaOHJISnFtdmYwaWtj?=
 =?utf-8?B?L093VlE4ZEVyN2RCa3gwMU42UnVoQkxPL09IRGQ3cEI5MkVtNGxVTHFvRFJU?=
 =?utf-8?B?VDJEUlc2bUpIU0ZuWEZ3RFhpYTdFQzk3Ukh1K1BUL2YyanRDa1RWRHBuUlJ0?=
 =?utf-8?B?alBnSVZxLytwRWtKb1pMeDFiU1pUWmN1d0p6czJHT1FxYVgzY2FTK05vQ0Mr?=
 =?utf-8?B?aDBSNVpScHIvVGY5bitpWUpreVF0d2JicERxNlEyWTlxbTdxbUpIcnJlaGpE?=
 =?utf-8?B?VVJXMWthTXZocEJZU1p4VEd4aENlRFZPZnQyaUlwRW85UHFSdlhOS0FyaW44?=
 =?utf-8?B?U0E2aDN3UDVLRklJZUg1UEFyaGV4amJ3eFpiRUVXNi8xZ2kwZllBUllZQ1E0?=
 =?utf-8?B?blY5MDY2VnRycjFiQWZPait5S3pjR0I4UmlDWnh5UW1oRnp1bnh6eldXLzZl?=
 =?utf-8?B?Rlc0ZGx3a2xqbTdaVmV4QnIxNjBuVU8xYVRLeENaem1keFNDUU03UStvS1VI?=
 =?utf-8?B?UlZDaDFDdWlvYUNJS01VUzh6MGJSOHJCRWdrYnJ5Qm1MNG9vNU01eWJoY1Ba?=
 =?utf-8?Q?uaRI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZsSVQrWDVVQnVLQkkzTnJMUSt5eExYOFJpWmsrRWdXNHZrR0YxQ3pFUS9V?=
 =?utf-8?B?eHBLR3F3Wm1aY3MrWkJlRk8zSmI1ODhSSFJGbG5Eb2xWZmg3aXpjM0xneHp2?=
 =?utf-8?B?UUhGOEIvZ3BOQjRaMHFaeHRBOHhhT2wvRmhOQVZGYnZ1TVV1SnZFSy9nc2hB?=
 =?utf-8?B?a1QyMCtSaVJiU2NGM0x5UXo3K2o1WFdmWkhuVXF5bjY1Rm9jT2VqZ2c1MTJ2?=
 =?utf-8?B?Ky9OVWQzMnVDMktKTHppYjRNeEV5YmRLSWNaSHkyZjFKeW1ZVGxSajRUMEhV?=
 =?utf-8?B?UG8yUXBOUnBlRU9SVFRDcGVZdmVaYjQ3MGx5TnMzRVh2QVEvUXFEcU1xcGha?=
 =?utf-8?B?L3MvQWVLOXN6QlB5Q1JrL1VqajlYVE5FaitRNll6RXFhdGRSUWRUajAxYWF6?=
 =?utf-8?B?WmhiZlJGVk4yWldZTEQ3cGk2b2xiRGRkUTRUS25DQytURDRDbWhvNWZqejF3?=
 =?utf-8?B?YjhuVDRXazdXRldDbDhLbXhFWDN0SFZKTTBZb2hXMmkzcGFaV09XaFJzc0hX?=
 =?utf-8?B?UitCRlA2aFBPcnlnR1lsSFY4YThmSjdCRUhJM0NMNkljT0gvWHppNzJ4NTRr?=
 =?utf-8?B?QWs0VmhPVGxkbW5HZjJUY1l6WmhYWDhkbG5ZVWZtdDVEdEkzZWNhOW5wRFdM?=
 =?utf-8?B?aEVGSmkwakZ1UWFUWGxLOElOZlpFeHg3WVVoYXFxZ3pmd01lcndiMW1uOW9W?=
 =?utf-8?B?dFB5TmpnWmhCTkFXVG5KYW1taVhvcE9LVlBxSFBJWWw5OEFnRjY3RGxpQU42?=
 =?utf-8?B?RXZsenFaNURDOHU4UUhlK2hndWE4aWdzRnVXMVo0R2toVnlXa1ZPYUxKZ3BZ?=
 =?utf-8?B?V2ZZcXZoQ1ZkUS9DNHBra1MzQ2hXU3BXemJ2OGJLV0s3WlpoOUpaSU5zdDN1?=
 =?utf-8?B?NW1xL1lINzE2a0h1VlJLQXU4N2xrTlJHc3B5RTRSMm9JZTcyTHRjN2hhTFRu?=
 =?utf-8?B?aG96RVdsZmYzVGFLNXpNZkZ4SHB4ZUJ2UEpXa0NwenBONGF1Z2RzS1JmZ3ha?=
 =?utf-8?B?YW1jMzZoa3ZuOGNUZjFQOUZyV2hqR2UrTnVEM0ZzY2wzTDlOY2o4OWFXOGMr?=
 =?utf-8?B?b3BMLzFBQVpNelUrZEh4NnExZVUwbnNGUlk3R0hoTnNDMkk0WnZPVjBaMVJJ?=
 =?utf-8?B?aURDdjhpNU54RVdKRENsd055d2hnVzQ0OWpaeGRpZTAvL0tmeU5FUTlFYWNS?=
 =?utf-8?B?QlZjOTNjSHdnazd2NFdhOUk1ZFBkWlhGTWVtWTN3aDl3RmlLclpteksyWW5C?=
 =?utf-8?B?QVBpVEVNOURndW8rM01SZk8rUHgvM3ZiVndieFlLZmZMelRlb2NPZU9FT2FY?=
 =?utf-8?B?alhpaVAyOVMrNmp1R3lkejNGMGNTQ2VGYVhkSnRpNEJKZ3hXcm80Z1pzcG5J?=
 =?utf-8?B?NlJ5NVM2UXllK0V1cWdNS1Z3K2ZLR3QxNnpQRVRiSGRHaFA0dURIREQxMXdq?=
 =?utf-8?B?b1BtZVpJZGVIYW5LTnNKQXJTRk01eTJkTmVLZXpUSGJ2WWx4N05IMk1DRStQ?=
 =?utf-8?B?SDJ5ODFXZzFaMVp1YzhkZXhHbDR3N1A4dWNwbVRiWjJrbnUydk9LMWM2VHo5?=
 =?utf-8?B?NEJuVTlDZWc4emZTelNGVUhvSjZ2dXpUajIrOXZMOVpkLzdmOURCTFY3QzRE?=
 =?utf-8?B?NThON3RWZFlQTHhvbVVUTCtGb2RkdExhcEJlcEwvT2dSbnJFRnZKdFRBMlRa?=
 =?utf-8?B?bFlxemJCNWpuNHZKN1FiQjQvRWxkcTNWbWpOSnZjU0FNeE9tNVkybkN1SXh6?=
 =?utf-8?B?OEdZTjRsbHcyNEkwRHNRd1BVSnJTbWcwUk50YTE1dENhTE5MN0FlbXFFZmxY?=
 =?utf-8?B?cFZzOGRyUk05c2c0K2o1QTRyeUdXb1Q2V1ErMnNiSXhTNUdzMnBya1ZaOVBS?=
 =?utf-8?B?aTJtU3JkVUxTUkhLdVFaZFZUbCtHVGJCUUhEMXBTTVowSzBzS0V4bE9kNStV?=
 =?utf-8?B?U2tPbDVWL2NPMVBRcEU5YUg5WUFkZGh6SDdjM1ZJQ1pqclN5SmNidVVWNW1W?=
 =?utf-8?B?SnJsS01lUXgvNmRrNTNjZHUwZWxsV2dPMzU0YlNUdzF1cXE3eUkzSUpTNU15?=
 =?utf-8?B?RVcrWjVlaG8zUHdFQmhlaFN2UmJzQ1hwczZZdnJTY05oUjR6REowS0dOWitR?=
 =?utf-8?B?RVY1UWg3cndsZTl6V08wUFE3MUpWT2lwZVJNWGlJcTRFU3VkSHZsbkJZYm12?=
 =?utf-8?B?RmZsK01Gazg0TEJqL3NyUnY3SmZjZjkzRTZTYkQ5VXBwVDdNNHhHNEx5NXlY?=
 =?utf-8?B?MWIyZEVTbjgvbmJTTjVEZWZVdTh4SDlxOHhJalJReWpyenVvRHgzWnp6dzNr?=
 =?utf-8?B?cmFiaG45SDVDOEdCUklOVFRUSHFpNUFyeXI3R1UwUGV4T0FGZGFpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d05dd21-9f7a-4a91-abaf-08de6010f9c6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:05:16.3143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYwC1avkVsyUBZZz0scxrWKahqW3F10EGwKg4J2+Hs8r6ixm3HWcdBEhpMw5pZUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091
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



On 30-Jan-26 8:18 PM, Alex Deucher wrote:
> On Tue, Jan 27, 2026 at 12:02 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 27-Jan-26 1:37 AM, Alex Deucher wrote:
>>> Need to make sure gfxoff is disallowed when we touch GC
>>> registers over MMIO.
>>>
>>
>> I think interrupt enable/disable sequence is only supposed to be done
>> under ip power/clock ungate sequence like in hw init/resume/suspend
>> sequences. The fix probably should be in the higher level sequence which
>> doesn't take care of that.
> 
> In that case, Yifan's original patch is probably fine as is.  Someone
> should still double check all of the call paths though.
> 

Original one is also not correct. For example, if this is happening 
after reset re initialization, only that sequence needs to be modified 
to keep the affected IPs ungated during reinit.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Cc: Yifan Zhang <yifan1.zhang@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index 36f0300a21bfa..05178ee8e0e3a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -6056,6 +6056,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>>>        u32 cp_int_cntl_reg, cp_int_cntl;
>>>        int i, j;
>>>
>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>        switch (state) {
>>>        case AMDGPU_IRQ_STATE_DISABLE:
>>>        case AMDGPU_IRQ_STATE_ENABLE:
>>> @@ -6080,6 +6081,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>>>        default:
>>>                break;
>>>        }
>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>
>>>        return 0;
>>>    }
>>> @@ -6092,6 +6094,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
>>>        u32 cp_int_cntl_reg, cp_int_cntl;
>>>        int i, j;
>>>
>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>        switch (state) {
>>>        case AMDGPU_IRQ_STATE_DISABLE:
>>>        case AMDGPU_IRQ_STATE_ENABLE:
>>> @@ -6116,6 +6119,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
>>>        default:
>>>                break;
>>>        }
>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>
>>>        return 0;
>>>    }
>>> @@ -6125,6 +6129,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>>>                                              unsigned type,
>>>                                              enum amdgpu_interrupt_state state)
>>>    {
>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>        switch (state) {
>>>        case AMDGPU_IRQ_STATE_DISABLE:
>>>        case AMDGPU_IRQ_STATE_ENABLE:
>>> @@ -6135,6 +6140,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>>>        default:
>>>                break;
>>>        }
>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>
>>>        return 0;
>>>    }
>>> @@ -6152,6 +6158,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
>>>                                              unsigned type,
>>>                                              enum amdgpu_interrupt_state state)
>>>    {
>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>        switch (state) {
>>>        case AMDGPU_IRQ_STATE_DISABLE:
>>>                WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
>>> @@ -6173,6 +6180,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
>>>        default:
>>>                break;
>>>        }
>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>
>>>        return 0;
>>>    }
>>> @@ -6183,6 +6191,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>>>                                            unsigned type,
>>>                                            enum amdgpu_interrupt_state state)
>>>    {
>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>        switch (type) {
>>>        case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
>>>                gfx_v9_0_set_gfx_eop_interrupt_state(adev, state);
>>> @@ -6214,6 +6223,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>>>        default:
>>>                break;
>>>        }
>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>        return 0;
>>>    }
>>>
>>

