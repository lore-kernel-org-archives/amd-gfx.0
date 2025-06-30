Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D89FC7EE39
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 08:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D8410E3CD;
	Mon, 30 Jun 2025 08:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhhvhOUS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D70410E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uymxc6iOcu8v7QG72uDQkW1ohptQJf4n7wJALxta4EObQf4OGtE1uQve9XMqIA7HbJoxQl0SwcF37P0xmuqn0ZQhtzjHx+o0l3Nd2vKrEIPX636doju3jcv4q/E1E/5Z25t1zHOhRXXLHRsiu5rw6zja8be/ug1vUWd1L6/PsePhiAp86NpXbv/KHytLI/BnZnfTQpBfguQ6l1mtAmo6izzt0eBZ9dT6/4ql0CvTnkrXGH3zy7zasGdCzbGJSRGUxFE0wnTVk0UI/3fFp1bNj+qgrtKD5Ky+cZOi7BxMOi4yBpBtAEFtZ5098Fl2WFdls4u4W1xcPWa249GLLO1GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQnoWmK/NezXFO/bHjpMbw1npXoLTHWUG70HDFXNi0w=;
 b=WsGz9J8g40KJk8n9ocVg9tHt4CD1QNKFnCEoAw4w5Br1c3r2OA4QGKlpEndfGtiriTQ2No53pYhHEXiB6JNWUuuSpuqDvfAxF/bFWPQuwek6mS9X6FgCr21two70YA9EI2PMU1xzvCtuXaOeP7v/rHSjMVyDs8Q+b8sf07kgeRx3ttHPI5FEIOX07NmUeoYJ2VBtVxZw+ri0AIJGwF5k/z//V/P+zATJH/OngBD5/RhZWd7xBKPXlZpnISASe2+gexZTLzAYY/cNLEI7qhzXZlBK6W8+A8SPkpbwtXf6qk2Qq+B7r7wzvUBaPSqK1hWdjSuxU/aPw9qDqELEA5HI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQnoWmK/NezXFO/bHjpMbw1npXoLTHWUG70HDFXNi0w=;
 b=BhhvhOUSAq29aNesQlyNvKtNv9AHHiy8vUCffQsI2wEyDwecFN/Ee+gTjhZ/hpt1XoRh5nWORFwNGkRDJX+hNphHZMLfgrliiv8RxOwa0X1lAD6MR6kI424W0FBcKZdrjt1ln9FjZNhcfF+TRZ8HoR/NAMmnC2Wr1qLhkGobN98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 08:56:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 08:56:04 +0000
Message-ID: <0667ea52-bbd9-4947-8dc2-fc238cac6325@amd.com>
Date: Mon, 30 Jun 2025 10:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] drm/amdgpu/sdma6: clean up resume code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250627034002.5590-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf74005-7896-484c-6720-08ddb7b3f1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUlHakF4N3ZJWWVLT3dZRCtjZUpKT3VSeXE5ZFk4WU9nMm1uN3VFdXVKc1d6?=
 =?utf-8?B?c0l2bDhrajB6TENsYTBYVVJWT0l6UzBxRWx5UmpmRnpRUGJWam9kSFVuM0dZ?=
 =?utf-8?B?MVZtb2xuMjFZcmJRZjdYZXBrbVRraUhsVzI5M1o4eFE3eDFwOFpmV21nVGN3?=
 =?utf-8?B?MlFJNmtkdWtzZ0NwbzE1eVkyQmF2d2c4bEVEYVZkcmY3dzJidklhNkN4WG8y?=
 =?utf-8?B?aXhnaEk5RlNmYXM4VFpHeDNQaXZrMC9YN3pxOTBncjcweXRkczEzMWxTMElw?=
 =?utf-8?B?VWRZYkpZS2FNc2U4U0JZUWN3UzZaR0JiNTh5Z01XWWZKeTlsekt4enp4Ulow?=
 =?utf-8?B?bjI5ZmVNTWZIdFlBcE41cTBXYkQzQzRlTFVWZERISnUwV0ZEOXVmQitwYWw2?=
 =?utf-8?B?aTBkZTBRcFh0Q3ZodjBDemRCZ2JIMC9uQ1g1cjg5SndYb1VrZjlHTmQrT1Fp?=
 =?utf-8?B?dEtFZUtWanVlOEh4UjZRazJzSy9pTzU1TVdTNit2ck93ZjYyaUZ6WFo4OWdM?=
 =?utf-8?B?WExzbXdpOW51RHJBYzFGb0JDMGJndnJwNUpUYlVIbGw3MnhqL1JzRld5TWJ1?=
 =?utf-8?B?N1BLOC90RjlRem0yM29iQmVpb2ZjQ3NUb016Z1BBSzgzcStZc2pqbjUwTmds?=
 =?utf-8?B?ak9tcmhHTTRabXcxeHdtU1RMVzJRZ1BZRThLSUFKR0pXVlRTb3MxaXN4eXVL?=
 =?utf-8?B?RGRjLzNIbEszdmdCS1hId3BjOWE5RHNCNkd0cXc3WHNDL0lEZWhzbzMvdnFN?=
 =?utf-8?B?b3dRWVFFQ3ZaNEpEaHVNV0Njc1l0bEhtK09xVE5vTURGcVpuOEFwTG5vOFdI?=
 =?utf-8?B?MUtHdTQwN1hjcmtWSFFpYWd3QzR0NWM4S29GbjZiNzFjcDB6czJrRU5UZ083?=
 =?utf-8?B?aUZHald1WXZrcFBTcFhBTVY0MEwyZk5wQjVOT0o1MDRKWm9xanF4eWtNY1RE?=
 =?utf-8?B?UHRVOTUyMEFlUmorNnJreml6NUdQakd2RFlMWmM5VEFuWW0xMHBHY0xHRmwr?=
 =?utf-8?B?MFJDNXI0Wkg2U3VwZW1YSVVFY3luVWNWd2YrM2lIYS85aXRuSGQwQUFmSk5Y?=
 =?utf-8?B?MTJDTXQ0RGNBYnJOUktTMitRRTNPNDdiUFgyb0VTaHhUSzZqdkdMZ2hpblU5?=
 =?utf-8?B?dDhMZi9idTR4bzk1Vzk1ZkpQNm12dHBMZTFmNzVhYzQxRm9EWkhKYWRjaHVF?=
 =?utf-8?B?dk5HY1hYK3luTWNReFl3b05ERDhxcmdBVjBGTk1tSjFld200WW5JcUtKbVA2?=
 =?utf-8?B?WkM2cUhDZ2tLUSs3WFAzUHRGV0s4Z3llVEZkSExjZGlkWmhQcEVIWUxmMmZv?=
 =?utf-8?B?T003UHJiSXVoSUI3UytHVEliNjRhV3BjdVQ5YW44VnJzZEZTdzVPZ2NZQUhh?=
 =?utf-8?B?Z2ZiczVkMlhsZ1FINEtReGVsRGlWbDlCVU42YjEwQmFyazNtK2RXU2hMN3N3?=
 =?utf-8?B?L1ZOcnZYS0o0K0lPR3c2TnBZd2NUMkEzMTZwSXQxK1lMdnFKVkhVR3NBWjF5?=
 =?utf-8?B?UmlkQXpjdUE4Y2RqZXpxV0d2OTRRZ1RiMnIxWW4zRmFRSkZzYTIwbkhtMTNS?=
 =?utf-8?B?VVhqWmhjdzc2OUdlQ2RjTk5LNjJxS2tvRDJnVDJlT0ZETmFmZUdnSEFXaTJ2?=
 =?utf-8?B?MGNJbEMrSE84NWVUL0dBUFl6WURrM0hNTmxXbVBOOTIydklnT0dQK1lwRzdM?=
 =?utf-8?B?VGtTWWpJVER4Z1Baa1FmREtlbUM5Q2RlYlpBbms3T3lPVjA5RE9ocVZtV2pl?=
 =?utf-8?B?U1FjL05qLzlXeUdWeFBndEwvMmxLL2lrNnh5bExHQk1tWTkzK0lqUnl6SU92?=
 =?utf-8?B?VzBzZnNjT09kZTJaUkovVmhOZW03Z21ubW51cHpJTGxVYWdQQWJneXBBNFpU?=
 =?utf-8?B?QVBNUVR0VytReEZ0ZUlmNllKTk02OVNmQjA5b09BWHJHTFV3cFVKMGZPR1hV?=
 =?utf-8?Q?Puu3ejr+G8c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhlUHNhOFpneDMxZWJzZzBsOG05dkpsYTZsQlRhM2wzbURTaGczaFlnakhx?=
 =?utf-8?B?WVVtRFY4K29jWHlyTjh6cnIyQk14TjRRUWhnakpTc0pWLzgwMlM1T0JtWmlK?=
 =?utf-8?B?c1haYjh2OXpEMVQwSUJCMy9Oc0NINlRFZEl2OWhldTJueWJQd3BCMWc2Zi9B?=
 =?utf-8?B?N29UekRRMjlNWlpwNjVqQU90OWdtT1lMam0vdncwbTdvL05WR3hzNG9YTEF0?=
 =?utf-8?B?am9XMUplTEkvVVhmK3JXK0QvR0lDQ3hhK0JvYlRMblZwMEZhMUlEdlNuVzNW?=
 =?utf-8?B?Mm9sd1VNMjlkWHVCcUJiUTJOTVJCd1pWWE9jS0N1WkVTVFlCRmFBRDhXTjlV?=
 =?utf-8?B?aE0waG5IQ2xsNjcycTlGNkFTSlZ5VUZCQUR6M2dHdHJOL0xaOUs0VVhOOU53?=
 =?utf-8?B?YnVCcFUwbzM0RnVQM2hERDM3WFNjT2Ezemk2Z0QrVGNFeU1CVGhQUEd2d2pN?=
 =?utf-8?B?VlNySFhLUEFjU3c4WEF5RWN5Y3lmWVh1R1hPRmtVY0Rkbzl3a3JINVk1WER6?=
 =?utf-8?B?aTdrdE5pWUcxa2orSUR0RDFBNUZqMitjYnVRdTlyUXJOYXJwb0FNNnJ4YUtV?=
 =?utf-8?B?YzZrcFdITVZIK1JWcEFFRGQzR0FCakJ5d1k2V1c1eERLU1ZZdklhbkY3Vjlr?=
 =?utf-8?B?MEtTeTU4VjJiWDhOMHpYc20rUGMwYWdvUnJKRnFwRzEwYXNwNXljUHNYcm95?=
 =?utf-8?B?T3pJUEQ5L2FvUnoxb3ZWV0lpc2ZCSVJDSE1pdWhTRFV6LzFXem1VWmxPeUI3?=
 =?utf-8?B?UHR0dElyOWJGYVJDK2E3TDhpUHpXb2VrSERSOGNIRmw2bXZMTFJ1MGZwUTZS?=
 =?utf-8?B?cHg2NDRkb3p1TXdISEZyNFZNOU9ROExtanF6MUVwR2xpekR3K1ZGdlJ3N1o2?=
 =?utf-8?B?QjJobE93VTlBd2VOVkpOemNIbkJDMHJ4SnRhSWMxcHZoZG9hOVBURC9OL2sy?=
 =?utf-8?B?WGZ2VFVhSEJxVWRwaytpZzJ2cE0zVUlMQzdYSmlUTU9yYmhTOTF4QThhS0R5?=
 =?utf-8?B?MW92cjRNdWYvRzhZeXFiWm1FTFRTWms0dUtDUEFOL2pxWDU0WTFlZUFkVUlp?=
 =?utf-8?B?elRtZW0vNTZvMERVb2JOYS9ESW5VVnNHMERSRjRwSGlzblEraUtROHZ5U2lH?=
 =?utf-8?B?VEI1TExBUWcrMy9uM1RQcGtGTHhLMXd1SmlhNUNEeXJhcVJPZVlTcjVPcklT?=
 =?utf-8?B?YUVqRWtzTm42ZEI3c0IvdzdLVStJN2hZMVB3Mmd0eGhNbkd4aDRqSGlyM0x0?=
 =?utf-8?B?MVdyamkvOTBrbEczbWowMnVXSW1mVEVRbWtGSEJCNDhaNmdhcDkvcVFYTXBl?=
 =?utf-8?B?K1hKMExDQnFDM3RSNDcyYTZOUmRjZ3BMaEZTL2VpbUdMQjA3UkpkZndFeTJ3?=
 =?utf-8?B?eEN6b0N5bUtsSGIrVzhhbmFxdHBENzQ4N0VaaTlRN0ZEQmxlQXlPTGZrbFQ0?=
 =?utf-8?B?WU9admh2b0hNUVUzT1U5OXEvalB0bXptQ3BHTjQ4RGNlNkthN2t1QXdBKzhD?=
 =?utf-8?B?N2ZoQnNKaHdsUCtLV2hiMFFkUUYyZFNyQUVHKzFzVUtlemV6NVhBdzdvb2V3?=
 =?utf-8?B?Z3NFNzhsYmo4UlVmb2EyYWhyR0NkL1hQNzFCR3ZhZzcvK0tWeHhheDdCUUFY?=
 =?utf-8?B?S1dkZmRFbUJKUUJKcnFCWXhBanVTR0d2UUozb1FDZzZNbkM5L2xLamJTbjY4?=
 =?utf-8?B?N0hwK09ZQy9MTzdxSlg4WWRKKzBDc0lUcFYyLzJ5MVdsRTl4RkxSMHpzNGd6?=
 =?utf-8?B?K3JKdkQvRUZKTHMza1hUNXZTTVhGOVJUbGc4WEZTV1pjckpqcXEwZDJPTFZR?=
 =?utf-8?B?ajU2QW04Y1k5TythaU83OXRYNDVzeFk3Q25LMWEydnF5ZG9rV3AzRXJTUncz?=
 =?utf-8?B?ZURycFZYb3FxTTlGRGNTdjB5Y1FrRFRpazJKUG55VGh3c3ZPK1BseWozV2pl?=
 =?utf-8?B?SXBuUlFXNis2TXg0Q3l5UkhFZHhnUzlZd2dZZmxVNDV3WjBmaUhzOE9IeGFH?=
 =?utf-8?B?eWVWemRLbnhYQlI2aU5lbFJLaWdMWW9lNHFkVEtYT3l3bHEzY1RYVis3Vkls?=
 =?utf-8?B?ZmQyeUZWNVpKbm1uQzFtd3FjYjRVU01GQS9ZVnVHcEkzd0RETEI5RmpCQU4r?=
 =?utf-8?Q?F+jSZ15xeo+sj+J8HlWoAMCI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf74005-7896-484c-6720-08ddb7b3f1ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:56:04.4519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd2E4mZhiNYD5I+OCJGCCIo1/cP/7fKQh1bdalxkkr+Etkn/jZbiqF8V8QY93aCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597
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

On 27.06.25 05:39, Alex Deucher wrote:
> There no need to save the ring ptrs.  Just reset them.
> This cleans up a conditional in the resume code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 27 +++++++++-----------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 103e5ec7aa63b..455f1a8a07ad4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -474,12 +474,11 @@ static void sdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance
> - * @restore: used to restore wptr when restart
>   *
> - * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
> + * Set up the gfx DMA ring buffers and enable them.
>   * Return 0 for success.
>   */
> -static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
> +static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i)
>  {
>  	struct amdgpu_ring *ring;
>  	u32 rb_cntl, ib_cntl;
> @@ -506,17 +505,10 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	if (restore) {
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> -	} else {
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
> -	}
> +	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
> +	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
>  	/* setup the wptr shadow polling */
>  	wptr_gpu_addr = ring->wptr_gpu_addr;
>  	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
> @@ -537,8 +529,7 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
>  	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
>  
> -	if (!restore)
> -		ring->wptr = 0;
> +	ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
> @@ -633,7 +624,7 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		r = sdma_v6_0_gfx_resume_instance(adev, i, false);
> +		r = sdma_v6_0_gfx_resume_instance(adev, i);
>  		if (r)
>  			return r;
>  	}
> @@ -1592,7 +1583,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v6_0_gfx_resume_instance(adev, i);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);

