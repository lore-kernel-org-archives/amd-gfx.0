Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBF2C87FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 18:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3919F10E668;
	Tue, 29 Jul 2025 18:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ciR9McG7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAF210E680
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 18:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDhbi/tMv74a3vtoOXQmCNkpzPk5Okih08exk5cLp8FEq7akZFLGj+qmVH3jExWMKcaxckgxbY0ESUYp9q7ka0Ae9b1XrWRQDTpNq/KnyVPCjBvbNJCiBLB6L0qdvNr9PX/RKTWjr8zv+vUIpFlpfO2o3dnKcAfp1hrL7+a0hwyrT0bF04dGBcqzaslIVWWVPLklqW1pBduW2uFfju41YTfhlC12FeXzlx7h1cfuqjz9nHXsbuSHA4GOvmGoQrAupVzbi8CChWlZkxnkMnL4vj7txrj9Ea1R2VyDROD27Wtez0+gxXzSjjLXn+UT0XwGJRq4hsRpQEwkn+e6x8f+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py3luXJjW5mnF52fZ7pz1cakEA76OsFi4n5kAc+VlG4=;
 b=i0gqrTNHsAB/kfHoZMkpGFAtyx0mCOSt1XGNvzRRRHYamkLdmGmPCYRYTOdmNMZE9zhCudEJ34eO31G5dLvGyjY/WPYWtmBgTp3rBMtAbNy9c1nqCIBHlYzLN/vh5AxMILSNvLkIOYfnXyuWIfjZRBH+nmhxA0mXmZHmxNySqaAnRZdwW0jaFsToxc0a0AM87Nq10moKiBPB0y0n3Qt5GWdrEHwN3mYZQgCT1i3VYnPjwL37nv2EjN6ff9/2dgBHofADxIrUXacjB957TcMu2126fKE5iLptu9lctlLc4VhvAE7Pfsg51oLaeCpKiwz2R15/VhFki77EJpruHcDdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py3luXJjW5mnF52fZ7pz1cakEA76OsFi4n5kAc+VlG4=;
 b=ciR9McG7f9L8IH/+PbdD1smj6BPHzg/WgCWwBnfKIrkn1koYT4xeGNtxnn3DzF5Uk2XlfqhUDJ+b89+7LE/scFbe0cnpkqMkLE65KAaZxbvFqg2QHHUF2hq7zcVdFIuMJ2KVevhhrBPchcC/Zywt+ezS4Sms/npftZeJklpH3Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 18:21:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 18:21:10 +0000
Message-ID: <1ef9ce5a-0b6d-4d0d-834d-d1f6b0dc12bd@amd.com>
Date: Tue, 29 Jul 2025 14:21:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio on
 RGB signals
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-8-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250723155813.9101-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0079.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 04283443-d5fe-479d-d15b-08ddceccb1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STQ2STkrQlRua2NlN1BqOHZ6UGhJMW16RW5rREpxaDZsUmlRSmNpb1NKZnlC?=
 =?utf-8?B?aFdoc0hOalhiV01EUWtiZnlKS29SclEydnhFd3lOWWhHTHVvQ29hZitCQW55?=
 =?utf-8?B?RElCR2R4TWJMRFhKYjArU0hGaGhmN3FpaXNJR3YxeWg1M0h2RndBczVlT1p5?=
 =?utf-8?B?Y3lrTnRHOHBGUHVlczY2aUJoQTVjR1B2NndVNTJyMUVHVDYzNU9EQnliMkp2?=
 =?utf-8?B?YkR6dUhqeTFMMGgrZ0xkek5lU1ZIL09vRStjSlZlS1VzNndnQ2Q2aWIrdnIy?=
 =?utf-8?B?aEZkbS9TWlJiMll2QnVXTkVpTU5wWTgxOUdsL0plK3lzR2NZNXduN3ZmaXJh?=
 =?utf-8?B?ajgrSjJyYnZkNGRwcDBqVmNWRnhzb3FRVUdEVHY5dDRpOXRQNWlxK2t0RU9t?=
 =?utf-8?B?WWt5cW5jRnkzMWx4TlpLVVJLUExkUTNTVFd2em5RQzA4eEtyTmdlSzBmb2k0?=
 =?utf-8?B?V29PNytDRGE5K3NHUWE3Ri9yVi9OWDdhdUtrcjVUSDZwam5sYUVIQWxqTU9z?=
 =?utf-8?B?N3lNU3lKa0k3aVV3K3VGY2VLbktKMEU0MlhXS3RYUVN3ZGNMTFVXRlR2bjRU?=
 =?utf-8?B?TGtCb1JWSWtwK2EzczJqR1p5bk1TTU4yRjNocjl2STBFSWZsQm5uRUJ4NFhM?=
 =?utf-8?B?bkZpeU5ZZVlhSXNYVEZNUytoRnhLU0xma1ZqQ05nckU4KzRaV1pSbU5yRGEr?=
 =?utf-8?B?RXR2eEtPa1cxSWNFNm52bVBhZ1FDeG14QUpKcHA4V1dSVnpnazBZSUx1aGNq?=
 =?utf-8?B?TEV2a3I1RFpVVnF0NGYzeEpOWTNqbVpYVzVpYzVVbkZpZzJaaFVUSS9jck4x?=
 =?utf-8?B?ZDRtMGxybDI1eXNmRFNkdm9Odnlkdzdock5HdytPQzBmV1Bwbm9YckpFRVNi?=
 =?utf-8?B?bHlpUlBVaUVjRUdKOFJMdlhnNExsUWE1Slk5MXhkWENHWGcxVGdkamFwKzdG?=
 =?utf-8?B?Qi93Vll2WEp0Ykg3RjFxbEJ0ZzliREQ0YnIxUHZBTHZKRENCWHhsQVRvdDhT?=
 =?utf-8?B?b0RmcGQ5SldPaWJITjNaSFFwRUZaRWZIWExzeXJEcHhzdXc0UUtZZFcxN29R?=
 =?utf-8?B?MUtzZjhvTitWWVRqaDZoWVBrVWl4eDRXYzI1MTYrRkhyWDh3dENrRi83cmVJ?=
 =?utf-8?B?ek1vUTc1bkpSRUNYK2lEMXNGd0tWaUFWUXZJNC95K0RXVjFqUFpCT3cvMDRC?=
 =?utf-8?B?NEY2N3g1U0dXb1NJUjU3OXNNY3RUT1FxK2xKYU5kZGEwd2xWSDcyM1dUL0ls?=
 =?utf-8?B?VVN0SlIwNHB5Y1pyMmUzVmVHcHFOWkJiK0grQUVURkp3ZUxtSFEyS0Nlc3hQ?=
 =?utf-8?B?K3NTRVlIOUZQYlg2MHBvNnljWkNES0lqTHNhdXM1eUVKK2h2VW41R0VZeENR?=
 =?utf-8?B?a2pZczhJRkRRMldha2tJa2FYeVdZTVFqVllVVmxDa0xldTk0SjNJOCtaUlUx?=
 =?utf-8?B?RTBVcnhqcjFXQVFERlozc21BQy8rWXJwM2wvL1hUbFJBWSt1d0tjTUlObkY2?=
 =?utf-8?B?eEtQQWJtN1MyZjBSTlNNaExGcVdUbEdETFE2bUh3enI4MzFNZkJsL2dscTUx?=
 =?utf-8?B?S1pabU1Dc1JHM3dKQWVTYkl6TkMxazl0RCtiY0VxcFN0Z0JkTHhKdFhWMWNZ?=
 =?utf-8?B?NlNKRit5TzMzSGdOb2QxSkwwNlZsVlNnbHVRMUc5S3o1aEJrMGtxcjF2MFMy?=
 =?utf-8?B?SFF1VlVaanlxZWltTEhtVnhPSGFUaHJqZTU5Mzk0dVMwRS9sZ2Q3cXJkdUU0?=
 =?utf-8?B?c2F3NWpNU0NRVXhNNEJPZjVlNUhCUFUzbGoyVHJMZEcrdG12Q050cTIxc3h1?=
 =?utf-8?B?Z3RyVUJvSlBnQndHaUgwNW93Z3IzdHZVSTFlS0FqUnVheUM0ZXlmYTVKUlIx?=
 =?utf-8?B?a2JXYmRxbnBtbW0wUHY0MDFEcEh1eXVDejdxYndNek4wa2hnR1pOVmdXbVNw?=
 =?utf-8?Q?UNCu7ZUhqbo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZFMFJTNDMyZi9QSzVBL2VJdHFNZ1UxR0ZCZmpiK1dSQ0NYc3FWQzFoWlNM?=
 =?utf-8?B?MkR1MG1ueGc4L2ZJejRhd1J0WHg0c3p0TTdBaHBPZi9OY0JiZnVkencvb3lG?=
 =?utf-8?B?eEtBcGZ5NkRjRlE2SkFDTUR4dFUyYVJqSmorYW9ic2lmWmk5bnRmcDhNYnRD?=
 =?utf-8?B?V1ZnOTZySWhDZXZQd2lURjJDVnU0QnpCM3M4OXp1RHR0VUVyRkR0amdHcThn?=
 =?utf-8?B?VzhEZG96ZFo2YlVEdVNoQXJxU1Y2MHk3ZUlrYU42VWhVUEs0bzhvR3czWWdW?=
 =?utf-8?B?THJJK09PcXNSNlI5T3lZMWFCOGdINTdQUmhXMGZKUkkxVFhDRmpYTGtYMTB2?=
 =?utf-8?B?cmdpUzhsU0RReklueDRyL1ZSTHlUZ3FxRkxFWW5nRDdETnozcVNlaVN4WFZ3?=
 =?utf-8?B?aFRWSVpxTnkvRy84SkROVjJFdFlCazRCaVVIQW9ubFVLcFBkQndkbkM5OW4r?=
 =?utf-8?B?ZVpZSTBrY0FOWmQ1bVNLQWxjb2Y1djU4alBWREthOXQ0Q0dJNlZreTNNOXFj?=
 =?utf-8?B?QTI2NDhwVTh3TUp0UW90MnhBNnNjRVdOMWJqVzNVVk5mN3BuV1lGcmNkNE1P?=
 =?utf-8?B?Qzg1V3hjMTVqSWVwdThOd0NDQTJ2UEppRXYzL1IzaGhtb016VlB4NS9kd0hL?=
 =?utf-8?B?TUVmdUkvaFFzNzIzM0Ewa0pQYWtYZzBLVnJnQ1paNWx2VFhYSlNieHFIS3RZ?=
 =?utf-8?B?OFdvZTBhVDdZUk56TkdtWElKVHk3YWh6WExOVVNwS09QbXIvaWdqMmdMZThW?=
 =?utf-8?B?Z1A5SWlCeU1xZk4xcytBYmdiUTFIeUhEN3ZmQStBanJpV3NhRWJ0VzVVUjQ5?=
 =?utf-8?B?djVleDZJRlRkNzBzZXRMWjVZQ1E5amVrNTYvWGZIYnNjNmsrb1I1dEtoaUla?=
 =?utf-8?B?R3JPOVVOV2VyLzQ0V0QwLzVpVDNpZlpCV0tBR04rQ1g5L3dXWS9xUXN5Uk1x?=
 =?utf-8?B?Y1BybFBRUjZlbGVzTTVXYnVpVCtPaWZQYjVRWk9oVTFkdlhqVTgxU1RraVZF?=
 =?utf-8?B?TjFqYUFkQnYzdEQ4elMwN1Q1K1R5VzVsdUN4S1ZWYVlZZG5YbThldGgxWGN1?=
 =?utf-8?B?bnU2azk0WWpMbUdETVdjZUpZYmoyTGEyMVRuQ1RuWDFqZ0c5a1RjYzhLYXJQ?=
 =?utf-8?B?OU1kQ0tMcUNwVVUzczN3MVVkVkxhbHJOQUZtQys2dDl5dFFRQTlUK29Hclhz?=
 =?utf-8?B?c3ZhWG95akdHVGVQbElOUmJmRGV4ZC93Q2VlRzVkY2ZTVDRaaS9ZaFFCZllD?=
 =?utf-8?B?OFU4bytXNkIwY1VTbUxCSGl2cXFBWmYwSnRKdi9Lb3E3UjVCVzBzUzRFT2dj?=
 =?utf-8?B?ZHpVV25SN2I4MDJEbGlzc2t5U0NrbFdxaHhDbGVGVEwyUDB4bVBjRWZvVGRN?=
 =?utf-8?B?NE5QZGNVa01KQXZhVHJZK0Yva1FxM1VvYU1XTXRyNndhSDVid1ZEbUxzckVB?=
 =?utf-8?B?Yjlva1BWM1ljN1hjcXhabW5DT3Nlb0J3eS85WDFnTDRsVzFmYldqMlZHbVpI?=
 =?utf-8?B?UEhwdHNKWEtYTWY2UXJObnVPQkhuNkQ1eUt1eDFkV0QrZHl6ODNEcTNnVVJl?=
 =?utf-8?B?QWlWR0RMYjNmV21Fcm9aeTNtYVRtR3V3M3dEc2pDeFovQ3d3THRpZll6UTVJ?=
 =?utf-8?B?eTBaRHpqa3FhalIvY056MHAzRlV2ODNsektSdW1PNW9aYlZzTjRYMm9UaUw1?=
 =?utf-8?B?TE1FUXp1b0c2VEE3Z0VrNDlkTWZpUEZNMGgxMThjVmhSNmk0WUtVa1NUSFd4?=
 =?utf-8?B?MURBUlNjNHViZ3IwL0JRZnA4SVJGQWlaWjRIOW4xZWZLOEg0UlVTVUlRWGRz?=
 =?utf-8?B?T3VDSmhBb3BNQmFTaTZqOUpkTUozeVA0bUNXZXRmSHZRTWRNWTFCNDhKRHRD?=
 =?utf-8?B?VUgrSXhlRkZmWmVrUm5xYXZkbDloVjlyaWRjZSswSWVIa0pmT2ZaN29EZHBI?=
 =?utf-8?B?K2lEYkJKZUFsU21IellUL0QrOHZTSk9LT0EwOFN1eHpNdkhUVTlSSCtSYTIr?=
 =?utf-8?B?WFU0ckF6RXJKOEhVN1NtZlc5elF5NzBnRlR4aTRXYmFQcmRFcWJSZE9QMmRs?=
 =?utf-8?B?TzJwQzU4ekkyS0JMTml4NHZUYzMxUFh4Q1d4OTFJcWh3ZGx0ZUdlYzRpNWln?=
 =?utf-8?Q?OBrfyf5IYPtOWu3o52Uw6CmZJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04283443-d5fe-479d-d15b-08ddceccb1a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:21:10.6828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NS8lZbC/Mw0AwAkkvNF4mKnktlkCvRScnUIngX/UvB3Cu2iYyqcMd8EA6At86Fk8epqDvgcL4nb/vt2DTt7ZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
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



On 2025-07-23 11:58, Timur Kristóf wrote:
> Features like stereo sync and audio are not supported by RGB
> signals, so don't try to use them.
> 

Where does it say that?

Harry

> Also add a dc_is_rgb_signal similar to other dc_is_*_signal.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 6 ++++--
>  drivers/gpu/drm/amd/display/include/signal_types.h       | 5 +++++
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> index b68bcc9fca0a..f3470716734d 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> @@ -115,7 +115,8 @@ void setup_dio_stream_attribute(struct pipe_ctx *pipe_ctx)
>  	struct dc_stream_state *stream = pipe_ctx->stream;
>  	struct dc_link *link = stream->link;
>  
> -	if (!dc_is_virtual_signal(stream->signal))
> +	if (!dc_is_virtual_signal(stream->signal) &&
> +		!dc_is_rgb_signal(stream->signal))
>  		stream_encoder->funcs->setup_stereo_sync(
>  				stream_encoder,
>  				pipe_ctx->stream_res.tg->inst,
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 8c8682f743d6..d6b7347c6c11 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2369,7 +2369,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
>  			set_avmute(pipe_ctx, true);
>  	}
>  
> -	dc->hwss.disable_audio_stream(pipe_ctx);
> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		dc->hwss.disable_audio_stream(pipe_ctx);
>  
>  	update_psp_stream_config(pipe_ctx, true);
>  	dc->hwss.blank_stream(pipe_ctx);
> @@ -2656,7 +2657,8 @@ void link_set_dpms_on(
>  		enable_stream_features(pipe_ctx);
>  	update_psp_stream_config(pipe_ctx, false);
>  
> -	dc->hwss.enable_audio_stream(pipe_ctx);
> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		dc->hwss.enable_audio_stream(pipe_ctx);
>  
>  	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
>  		set_avmute(pipe_ctx, false);
> diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
> index a10d6b988aab..825a08fcb125 100644
> --- a/drivers/gpu/drm/amd/display/include/signal_types.h
> +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
> @@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum signal_type signal)
>  	}
>  }
>  
> +static inline bool dc_is_rgb_signal(enum signal_type signal)
> +{
> +	return (signal == SIGNAL_TYPE_RGB);
> +}
> +
>  static inline bool dc_is_tmds_signal(enum signal_type signal)
>  {
>  	switch (signal) {

