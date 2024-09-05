Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB19CD5BA9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 11:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A7B10E860;
	Thu,  5 Sep 2024 11:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixLoDBvA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDF510E860
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 11:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaxpSgx7L8YnGiaKI+yl7A8hkRKWBGfFOtUEfmZFsa0BAhf4bY3W8Y5ztohc4OlmuoW4Q34zmrVqflNS5UxmsBZpSOE+G8ZhAgksLnteho/2XgVkk5NWa/fO0O6NwiR6V6FSjBQhyr+AHlzst610yFPQ4RLOKdjMpI3DHdfUeq6o7K5XULlXRcI4V6pFatlHis7ki3ivC1Hb6ojWO2PutXVhBu9ebmQv0+KtzE/cp4lkxd1K4Wc8ZnyXh2qgMwb1ZllEmxonSaVE27xJ2MvY1buvmn0UAFILaNqLEL8xIVR2r+ozofA0tCLbjaEtwWblQafGgu+kVLMU+ho0xMiOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28mlK0c0TeEPKJBF7Q/jS/f2+q/TCcJ5imi9fAeDuew=;
 b=hUQCanDBuwD6higKmRS/d2YVbH+ZR13G5Pcy8ow5qnboihdd4d6kSR2epWe8LPSNRsaCK5K/yQcNiIYi4+bg22YLmMf6lDmoIznwxnAlS6uU7hT++pZiFFeASBMFZyP0BC5DN5E/X5IRczv5PBD8Yg8yS8vwPZ/KrKUUjYJkd/w10QewuFhb1q5eWhpyTIj+bXV7Y/m9OrvnbLnHzY+6AcuSo7k2oowEb7RaJZ+idDA85ponT8nCYpWz1l5ZxK72FbhTyKybRGf8xbLYQA6slW389boRU0awSIxTfRF242yP/ec67KJAmmAvzR+pzT/ZnIoeoUvJ8Ah/71Pm2YIEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28mlK0c0TeEPKJBF7Q/jS/f2+q/TCcJ5imi9fAeDuew=;
 b=ixLoDBvAQ9DwlCqkTrAabfJV0CNRkP8Zxwu2hM7e+2AGpf7MG1KWctCp7HoTjoQWP01yAfajp5mJjwCniqmEgvs3j1K7uCDhH2fBLv5vD9uZNtVW2k5rrcCaAyinRnN97Hil0o7luPwpDVLehtI5MlOsECCn5EWsRsR98Jtt7ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 11:21:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:21:00 +0000
Message-ID: <d79341ab-84f0-4d5c-914a-ff27f4097078@amd.com>
Date: Thu, 5 Sep 2024 13:20:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: screen freeze and userq driver crash
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <20240830184322.1238767-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240830184322.1238767-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a789ded-b981-4c37-d03d-08dccd9cd23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rnd6bkZvaFFUR1lJSHZ4QkZMdVJjbkt3NFl1QUNaQi9GckRMYTJQaU1FWmd0?=
 =?utf-8?B?SjNDYURoY2VrUy9KYVU5VXVicnVCZ2pTcC8yTE9kbUpDMm5sQlFaNzJPMFF3?=
 =?utf-8?B?QVoxMHRYOUVDUnhMbVZHTVNrUGJicVhMaGtXZnUyVFlCeVNQNkNrY1UwdmFa?=
 =?utf-8?B?SkUrY2U1R244UmFZV2M4cUkzdHh1ejE5dmhEbFFiaHQ1WjZvYk9JTjl4ZWdG?=
 =?utf-8?B?T2hJTDhaTzdjem1vdm1JV2MxSnVGMm9nT2htbG5uOUdKQldRaFhhT21nS1Zz?=
 =?utf-8?B?dUVJb2gwYWdZTS9CUHdVSzB5bGZnQ0NiWUcvdXNhZGNTb1FQTDB1ZFd2N2Nt?=
 =?utf-8?B?TEp4dXFhWnpuUjhDMERJclhheDFmZHNrRE0vaGJQZTBlNExXK2NSYkpieko4?=
 =?utf-8?B?WFdUeEIwRG00cmhEOEdpaGhEdDZicHBING43S2ZJSWdINGZqZkxpZzNKN2l4?=
 =?utf-8?B?akVTcC9ta05lSzh1RWtTZUhOTGlmVkFlcTFoZ0tQYjRBckdVU2NaZzlrKzAr?=
 =?utf-8?B?TEJBTmxSdHJ2SjFFNllZZFhoR2FBS21DcXlXTEVlOURodGkvU1RxUGpGZzBX?=
 =?utf-8?B?OXlYd05JMWQzVFdtUFlJeDhhdmVzaUdNV1pUSUJBYTJWWUJZZjZCbnJEYklr?=
 =?utf-8?B?Q3haRFBLQlFQMHByMHJpaVp6TlRjL1d4dGo2eld3YlV0eE5WWTRGOG1QcEsz?=
 =?utf-8?B?YlJQOVRZbkV1YzV5Y1pRQ29EZXc0UHRLb0VjdkRKRXNKYWp5L1g4eTY4TnB5?=
 =?utf-8?B?QzYrU1lRWmllRFd3cHdkWXFWMzhLU0d2SFNhVVJBdWx6MCtQZUNUMGF4QTdv?=
 =?utf-8?B?cXZFZ0dsSDBrT0Y2VjJrYnlhS1JxTHFFMDFlOW80MllJTDFkRlNmMTYrYUNH?=
 =?utf-8?B?SFZ2TTFXejlCNWxyZS84RU5wdTdEWGhWcHlpcExXTzNuMEMvbXdQS3R3cXJH?=
 =?utf-8?B?eWhJTWVzTnJBRDk3UW1zbU9zdnBvekdKTGVmYnBDM0owNm9RUWZYR1BQWWtl?=
 =?utf-8?B?Y2xkd1ZRcGZVdEZQVjFVSjhVS2tYSitsMDhyQUtFdkZwOVpGeVlNK0NPSHY3?=
 =?utf-8?B?UGNNNU5SZS93SmF1b0dXeCtZa0tsc3VQTGpja2pCOVlUNUMvcnVES1dZYWZj?=
 =?utf-8?B?Z3JMeC9yTkF3Wk1Ka1loWW0wUHlaWmdqTVZMRzlUbTJyR3FubjVvWDk4M2JJ?=
 =?utf-8?B?YkJ3c0JSMFRXaTJ3cEFnclN1cHAzc3hFN3R4WDZReGR1K3ZsNFZUQW9aWHFV?=
 =?utf-8?B?dXI5cGJnMVphYTIvVkZaVHJoWU12U2V5SEphL2JYK25kelZhakFQUGdBNU9Q?=
 =?utf-8?B?Ukg5cXBycjJyRkkzejNyNklTbmRXdjhRYzNOUEN6V1FmRmlnb3kzV1VuOERF?=
 =?utf-8?B?dXpkcFVnTVBTczI3L0JBNVhoeXBkM2wxdHhab2NJbUNEdVY3UVNiUExSSFls?=
 =?utf-8?B?SGFzeFRGSVNsMWpTL3hZVkd1cTUrMzBFR0ZLU2E5eWgvcWhTZHZxWVNKWmxT?=
 =?utf-8?B?N0FtaEtLd1Zqc3NnWHA4ZVNkTks0andIby9La1R3NitTNHB4ZHh3YlV4TVB5?=
 =?utf-8?B?RnFZeURHUkxwelNDVTNQSDJGVGcrWGZMcDI0eXJWWjQwUyttRy8wSVZZRGIy?=
 =?utf-8?B?eFJ3R0pXcmVtQ3VlZFJQTXV2c1RXWnVGcDZXdUtaSFVadDRTbkdwdXp6dmc1?=
 =?utf-8?B?dHJMUkFwQVAxdzNVOWp1YktRdzdQbDNueC8vR3cyTVF1OUpLOUt4MjJrWWpu?=
 =?utf-8?B?U3RHbTU3Q2xqcCt4R0N4UTlwZ0cxb2wvWUU1bzF6blZ5MXpERkJTdGNUVE1q?=
 =?utf-8?B?dHlKUFYxOVM1VHBMRDExZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emM2bDZMVlFZQ3Jqa2swL08zOVpZWGIxelFJT3JBSFJHR3hsRFdrSXloWWZs?=
 =?utf-8?B?OXZPZis1Ni9TbGl5NzNGeXVWaEFpS3Y0c081dGt4dzkwbWxzNWl3eXEwT1Br?=
 =?utf-8?B?TGNTL0FLV0grOWg2SDh0amFwYkpPUkV5eEZ1bVZ6a3Y4L3ZVQ0NOd01xMktl?=
 =?utf-8?B?QVNWVEtEV011MGZHa255YnlrcGZLM0dlWXBWZkRtcm53VkhCdTVuSHBEdk9F?=
 =?utf-8?B?b2FwQUNxVEx3MkZnb0Z0YzZMNXFvemZGa2ZEdW4zOCt5SzRWZWFudlhQdThO?=
 =?utf-8?B?ZVhYZVFYWm5qWEZ1Q0trdXVaUW5DYkQrSlBMTHVHTzRqR0JqNjNUUWRsZWFj?=
 =?utf-8?B?aG1ybDhJaXRPTGZabWxrcWZ6Y2JTWmJiRnpxUk1YSDVZQkVHczUyL25XUUJC?=
 =?utf-8?B?Q2lGeXgrOVM5TE9qa2hwS1ZqL0EzcFNyeTVqQW55VU9lU0RJU0NsYVdTYzU5?=
 =?utf-8?B?M2V1UWEyendZemdLbDQ3dGMydTd1TG5CQ2dBNVFWUDRlVm1NeVV2RUFYaVZx?=
 =?utf-8?B?UTNNNGpqOTZwVkdrL3NDQW8ra2JUVWpZaXBCeFJ3T0xUdUVrUkpYdC9FR1Uy?=
 =?utf-8?B?L1ZmR0xHSE5rQ09CMWY2KzNWSndzWUltcGtXRHhVd2xNMVVHeXJSVVlrSnZD?=
 =?utf-8?B?MkwyU0hZTFViVnZmV3hsckdqQmJhMFhCcXgyNnQ4QVhqS2ZmcmdlUzUyayty?=
 =?utf-8?B?RS9EV0JwY29TaDhWWkRWdXdCT1BhalVzNVdZSnU5QTVUWjJwVTN5LzRTWDFX?=
 =?utf-8?B?dFF4NkZwV3V6MUpueXd2YjdSUFF2OUtTeENyQ1I2dlpwMllBMm1XcjdxNnVT?=
 =?utf-8?B?Sk8raU5YNWs2bzlWMHpyYlNpNkRGRlhsZGFZM1NiNzlvZS9vaG1tMWJRQTVU?=
 =?utf-8?B?QVFoNjB6QXpsS3BqTVdPcCs0V2hpSHNQdURRR1ZMeEZrTzd5NVprSklQRzFI?=
 =?utf-8?B?RVVEOGx6dUcvRnkxM21xbUlkR3J6RXowNmZibVJsZHZXMk9FOWIzQW93Q1hB?=
 =?utf-8?B?Y2JydDFoa1RQTG5ZM0lMOEdjRitTellYdDF2Y3dFWVAyMFc3VG9jV1I1ZjNl?=
 =?utf-8?B?Vm1RaUtxRDQ2dWt5U29qU0lIV25FR0pIWUdIK0YyMEpjcGsxS293elV1Vkhx?=
 =?utf-8?B?RWRqaEtyV3lnT1kzbnF3QkRydjN2TU5FVHFTekljNHkvb3EreWhVNzNydUdv?=
 =?utf-8?B?dHRUaTBGdnUydENlTTBhQm1ndzJUaWV5ZVdpQzNNNHFQUHRxT2prNWF5RnVi?=
 =?utf-8?B?ZGltQzJ1L1RUblZzQVRFRjVDTWxxdkZjYW1ERTNvc2VLTmNCYXFncUNNckNP?=
 =?utf-8?B?aDVxN1BRREg4c0xvVjI0a08xcnVTWmhPVTgyZHVYb0xkOElIdk01eDlvMkJG?=
 =?utf-8?B?R1VMNk0vKzhMdDdWaS8rQ2xzdGgvTWhENHBlM3ovSWVnQzZnaFV1d0xBQ1hj?=
 =?utf-8?B?Nm9jUVV4bmg1MmpqTGZCTS9LSEtVWEltYWpXcDVnU2UxamphRjVGMlVFSjhy?=
 =?utf-8?B?akI3cVNPckk4cHBDdUlRR1RrOHFBc0RWU1hPUTZ3WS9HL2h3S0pPU3VBblFp?=
 =?utf-8?B?K1FYTmVOM3NlMlpheXQ4S1J3TEtGb0xtQXh6TFZXNVEvRWFERnZZb1M0aU42?=
 =?utf-8?B?OTZiU1BPbXlDRm1zajNLMzVmdThIbExTTmxJUTRXTkozbjd6bEVHNHE3Z3pZ?=
 =?utf-8?B?VGxTeGhaMXFuN0ZMUTR2QURlK0NIMks5R2JPWVd3R1BmSkJLbEJUQzNZZFor?=
 =?utf-8?B?TnFIU0dsUkVoRlN5NFpIWHZiMmludE1iRTBmRTFDam1xVU9ib0dIK2pQako1?=
 =?utf-8?B?WGxpR2FsdDFXTUpyNEpjSXY1YXV2Nm4zeS9SMTFMMWdzL0FGM3lYajZuZ2p6?=
 =?utf-8?B?MUhkSnJtL0lhWGF6clM1OE91RmVWU1g1d3pramNDNVBkVGg2MTc1UTRCYW9a?=
 =?utf-8?B?ZXA4S0doTGlhVXhHTUxsT3lVUTNOQjRqSkw2dU5KZzcxM0p3UlVwZkMraW9t?=
 =?utf-8?B?SmtIUXlzcytNYlVYZUNRemRwZ0JXbFBUblpSMGZIT0QzM3V6MXJ3K1NKNWl3?=
 =?utf-8?B?a2NZaUpRVGZTRUVYa3RaYlJpMEVNNmEzbUNpR1FDZVYrWFFqR0poTFBnOUQ2?=
 =?utf-8?Q?h2A7rB35DFzHVprZU3CkBp8oF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a789ded-b981-4c37-d03d-08dccd9cd23c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:21:00.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: micYUdrBkQa6K+6yHYeL33UHVagOfuxVFgGQ8GD42b6K/sZXvdAFCLJHt8owiJpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
> Screen freeze and userq fence driver crash while playing Xonotic
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index d2e1d0d0f29f..8a3b5374cc1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -187,6 +187,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   	struct amdgpu_userq_fence *userq_fence;
>   	struct dma_fence *fence;
> +	unsigned long flags;
>   
>   	fence_drv = userq->fence_drv;
>   	if (!fence_drv)
> @@ -230,14 +231,15 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   		}
>   	}
>   
> -	spin_lock(&fence_drv->fence_list_lock);
>   	/* Check if hardware has already processed the job */
> -	if (!dma_fence_is_signaled(fence))
> +	if (!dma_fence_is_signaled(fence)) {
> +		spin_lock_irqsave(&fence_drv->fence_list_lock, flags);

As far as I can see that still won't work correctly since you can't 
guarantee that the fence doesn't signal in between testing and grabbing 
the lock.

Christian.



>   		list_add_tail(&userq_fence->link, &fence_drv->fences);
> -	else
> -		dma_fence_put(fence);
>   
> -	spin_unlock(&fence_drv->fence_list_lock);
> +		spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +	} else {
> +		dma_fence_put(fence);
> +	}
>   
>   	*f = fence;
>   

