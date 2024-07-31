Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631DFC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 09:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C69010E027;
	Wed, 31 Jul 2024 09:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6hPsP4k";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DECB10E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 09:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1E1tpemdROcqaTtIXRICHN7+QOI884wuegbT38KpbeGbGKaowPxp64OknLsMfz9ZHchZ5Aa3DYpZNuJHDGJJ0HRGCA5izh4dcbHjzmevD8DBLkI+xKl0GL15bi0yVrFCFfMb0RNHN4PdjoqtAad7TzBYZ5ghGyRwRlJft0q8d/j+QEzu1RFqmpAsA24KW+/u7PySLAd2d25W0VnGxXPZsCeJsq4C0PdFy+yygIg1GixC47nJkCpVX+nAwKJaOgOcItAsbQ2p4b7Ejkgu7gawyyDB55KLv5S8LbgFdOwYf3aokk9Q7M5YU7oC4v5Z328c2Qt1ZYCOZbRg8nWJ03j2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joBFcPHk9vHz54fP71SYg6Lo974yVr7wyZxmzFoxB3U=;
 b=xdtLK6afMcVxeoFKJNa4k207KQOroFSyqhdhubedSrnOGovQQXJmrciwo0FXLarZcbRnhoBdxOGC8o2SZZfAqvSO3Cei76OkAA66kwR23C8cfU2UuFJ2Qi+NS0KwPx+6dwx49olKTygEoyPvIhAMLjYYrZiCAo8dLM6v0IIuCEqiKyaQFsPSmZ++XZzrwjgFLQmtJhitooE7+X/KlDI+71rJmxCB+XhmHV88xI6ElQD+6fbTOpbjMgkaE111GvyoSi9Qpw9FKQNXKU57yCjBkofY/gIaPB85qcyRhzNo/eI/6B/Tqk9vWx08/PXTCe9uN2zf99St2PA/eP59mn3D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joBFcPHk9vHz54fP71SYg6Lo974yVr7wyZxmzFoxB3U=;
 b=B6hPsP4kLyo/oRr/uvcF/+J5AEhCuTDPeF7xZ1QxNvGw5VG8T9Z/UKQ2Lg6L8+bwljKeJjvf0X6HKBG2cfTM/gHuYRsiXgquCcpVbnOM+Jopf9VpPcHQR1CHtmdciw1dmjpiHKeqUVtMUX+ZRuMiKUS8E2lFn1x3rJDzXn0cruM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 09:24:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 09:24:22 +0000
Message-ID: <a380ca00-efe0-4cb9-a0eb-667c05d31155@amd.com>
Date: Wed, 31 Jul 2024 11:24:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: do not call insert_nop fn for zero count
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240731081203.25148-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240731081203.25148-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: b066f2b9-3612-4af9-89d2-08dcb1429017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE1RV2JnbXpDUUtzMlFGS2hJZC9FZGlIdDhPWndRb3lHdXY4S3JFbHplc3Nq?=
 =?utf-8?B?Wmhza3RVOVdKQ0duVTdtMGZLMGRscWR4RjZPSHhZRWJBRGxNa1d5OFpsZExG?=
 =?utf-8?B?WENnNlNOeFFDMjZjQmNUVnEyV0pjTTdlZjhwNkhpaXNwS09XK3FHOGhGUVMv?=
 =?utf-8?B?WDdWSlFhMkdHS0NlMy9OalZhRlJKbm5GZmpETFRZdUpaNGlDbS9ub3lXdUNY?=
 =?utf-8?B?cm9YYlNFRC83VHNnOXVQQnFkdDdGSFFkWC9pVUxIQjRvQ1l1eUl6SzkvYXZ3?=
 =?utf-8?B?WmwwVVpLeFY5dnFpM0grakpIS21nVldwWnl4QXFzZXRzaVVlK1BmdXRtenNu?=
 =?utf-8?B?aVZQemNHZlZ6bVZlS3pRcUEwWjB4cXRrd3FXdk9yZzQvV0FkQWVZWFQzNWYz?=
 =?utf-8?B?QllNczBSaDJZWjdzNHdTOTR4U2xxb0NVZHR2d1hVQXVrM1dsVGVjdktXaVIw?=
 =?utf-8?B?OUlUbTdsNGZSNHRXQnlEMk5YUWNBbExicWlHUmtxMVJhQ2dCVW51SHFEZ2hR?=
 =?utf-8?B?dHNBOFlPdTRRWjhGdHNkL1ZTbTg5dVdhaU56YmxGcWoxWGtsTkxObzhaQVBK?=
 =?utf-8?B?QW5LRjQweWtlb0dkRVI3VFQwK1RJeGVLY1hEMjNpcHJIUmpaeWpROUV2Mlpl?=
 =?utf-8?B?N0RMR1N2S0xsZ21BRWg2MW1OaHlUbmw2REQ5c1ZrZzltamVwNG9EV3ZUSS90?=
 =?utf-8?B?M0UrajZVanVoNllWZy9sWUpncTF2MUxwUGh1WFdZMkNNb0kxNExoZXdaMnBv?=
 =?utf-8?B?QlRXalNkZHdDR1AzYmhXTEN1V3hjdHVJejhnOVVyb1NuTTVPVnhWNjBJNzNQ?=
 =?utf-8?B?NFZoSDdOWFRzQndCSVVYM0pSTEwwaGhZMFhDMkpLa1pGdVZRbHBZRXd5dW11?=
 =?utf-8?B?WGV6dlo1S3hZa2U1RHVzSGlRZUxaVUQrUjJTMjJKaUNjZmN0OTNNTWc3TTVm?=
 =?utf-8?B?aDd3RUlwUWxac0ZwUDhrR1h0dG9ZOHpTZ2tPUVBhaVNxd25XSm9WZE5yOU9T?=
 =?utf-8?B?S0l3OE5pM3NwdWIrVFV6dGgxMnZsVzFVMlIvZTFkbHVjeEtZdjNROFNPc1p3?=
 =?utf-8?B?Q3FXbXVOdjBwZmJQZDhOdGVQOSt1OGtEdUxQUGZETm1pczF4c0l2QlErYjF3?=
 =?utf-8?B?eU1KbHkyVkpZOFdxTEVvMFpnZHQ5dXJLam1kd1FsR0ZySVlrOWZlTHdjbTRU?=
 =?utf-8?B?S2RTRmdBcnJmU2dXbmF3V2xqQmtqYVBiWGVsUmd1UDBsTVF2WkVQS2VqQU1m?=
 =?utf-8?B?Nko5Y0NialozUWNmNGhHcXRyN1RvVUIyNDVtN3RnQjkrTm9mR0hnVTRZc1pk?=
 =?utf-8?B?OGRKSW42ZFpyRUx0bVVpMlZYVzU1YTNXM3QvTnpvMTBndjBEUGFoWlEwQzZS?=
 =?utf-8?B?cXVvUDlxc3Y0UFVTdXYvRjd4UHpyZjA5M0tEcE1uQXA0cXM4YVovdzVNdmpL?=
 =?utf-8?B?ZUh0WWFSR2ZrSUNwSFlUVStneGlOQzNXc29sTGNab05QM2tqdXhPdmpScDlT?=
 =?utf-8?B?d1RQdS9pM0UvVGFPNlVyMm8vZFdJT3V1b3J1VllVMDF0eEx4cEFmbFpUeWpw?=
 =?utf-8?B?cEFpdDR1MGkyVlZUUVhxSG1hcXpkQ0FRZ0RSMDl2eWxuZ3JsQzFYNStXUUpw?=
 =?utf-8?B?dmo2UWo3Zk5OTjNqY3N3MXluU01zUUFMU1czRElHcTRHYktFUE5icEQwNEhi?=
 =?utf-8?B?WWR1b3ZnYllLTnNKSzFwSGNIRGVSeWpVUGFpUHF0bll1bFdHMlVpUCtDMUZl?=
 =?utf-8?B?S2VEY2Z4ZERTVjIyU2MrczFKREY1WU9xUEpqMFJrNGJzL0xacmVkVUk0ZkM1?=
 =?utf-8?B?bWVCc1pqeUlBeVp0a0puZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2VZY05BeGVSdVFTbFIrdlFGd0QvZm55WUZxNFJvNjByekpFckc5Q3ZkSG01?=
 =?utf-8?B?b1B0VktYQ2tiWDdFbzV5VW5SWlZLSzlhRU16akJnSi85K2haM0hlK3NzUXRB?=
 =?utf-8?B?NGdmeUF6V0JMSndJMThLaCsySURMazA1TG5PSWR0SUl3QjBGTDEydDRlanh6?=
 =?utf-8?B?bEVFTHFaWVI0NUhjUE1mZ2w3WnNTN29qcXBQUlhObXV1c3JaUjdtb08zS093?=
 =?utf-8?B?RFJPckt1dTNQUEJvckIxYm4rTzcyeFYySWZoUElHNjZtUGpGZGFSeWwyRm9t?=
 =?utf-8?B?SjV5TEh2MDRTT0lWb0FDcHpsVWFiRVo1Vmg1STRVMjdtbG5URFkyWjV3M056?=
 =?utf-8?B?Vy9WQjhUMVoxNGx5d0Rsby8zeldhYUdySmN4UmdtaWRsUmNXRDlGVTF5L0ZZ?=
 =?utf-8?B?TWVBbTZXYXhDV1lsQlluaXo1YmZUTUh2VUdiSjZsRlcvck9HWEpTdkVRYU9W?=
 =?utf-8?B?bVM0c09FcVBxRHFLbktjck9jRFE3VzkxblpHNTMyUk0yaTY3SWtVckJLWUQw?=
 =?utf-8?B?ekRteDhKaWptcWQrNStOY2tlU3lHRzkyNUttZmRkZTVtTGYwcm5LNVJLV28z?=
 =?utf-8?B?ZU5aeHNJL1hLTjNGd3k3YlBRZm1jckJRMXZGRFRSTjBEcHF5M2sreDlUS29G?=
 =?utf-8?B?MURBeE50MU9jZ2ZhOU1NLytxak9hYWhoblp4QnVMS3VCTzhnRTMrM0laVFFY?=
 =?utf-8?B?NVRYT1p2WXliVzJDYlc4aGFXUnZDM24vSGJQK0lYUmZFeWNNV3dTOUY0U1I3?=
 =?utf-8?B?ZkdpU2dmN3lMZTUzcGNoMzcwT3FWNWxDbklBMUhHUDV6THZoYUxpZGlFby9V?=
 =?utf-8?B?b2RNazV1NUV6VjRkWktQNks1VTR1eWYzSklGa0E3UTBtNWFTaGc5UlBpWC9y?=
 =?utf-8?B?UzRKZ3ZBenlFTXFubTFCZVBKMlI0U0k1d0doMkZCZThSUXV5WXRlWDdsZGJI?=
 =?utf-8?B?dnh5eVZYRGs3aEZCTE83VGUraUdGOXYvaGMvZEt4MzhZUjJBZEZNM2wyOFEw?=
 =?utf-8?B?Tml0ZjRWbnUrR0NjMStSdk8rbzE3WmtPdjM0Sy9WL3QyZ1BXSDBVb243Yi9Y?=
 =?utf-8?B?eExLYjlCTWM5RHZXeVJud2NjZGdvWW9TTUw3OU8xMVBJcFBEWmR1V0c0Tnlz?=
 =?utf-8?B?Z3ZTbG41YmhwNE1Ncng4SXNsdkRhSTQ5U3Y1YzVUUlphOUJRVFZMZTRvVGdU?=
 =?utf-8?B?SmxQSkpLd2h4bEhWU2pzUE9XOFY0MVRSTEVzd3BsN2twcHljK2YvanRQeVk3?=
 =?utf-8?B?ZkhQT0VqS0NaUzA5MkwwRlFya1pVaGNJN2tBZUlKblpyK1VUUHZyc0l1M3Qx?=
 =?utf-8?B?a0k0Y2pwWStSdnJPbmF6MmhYWGRPditCL3J2bWdBNU55UzhjWmlMQVBTM2RY?=
 =?utf-8?B?SFlmTTRrZ3JYUVdvTjFHMTZ3WFRxL1RRQ3dDWWxvQzBSN3hEZTVsWjFhbEda?=
 =?utf-8?B?bFR3OWVlaDBRY0VaK0tDOGFyYzg4alZMNWhiam8zbEFIVU9UTjkxbks5M1BS?=
 =?utf-8?B?N1BTbGlZSlFTM25iTE9DSHlmR25IRjY0Ymt3ckZ1SzFLSllKRi9MMSsvM0sx?=
 =?utf-8?B?eFU0MEIvMU51T2thSTBaSUg4eE12RFNCQ0tPb25FcndjcUwwTmp2TXZMSncr?=
 =?utf-8?B?NlZxSmt0V0NQYWp6MEQrWXowTm54dThieDRJN0lZakE4ZnQyMENFWUhlSm9H?=
 =?utf-8?B?MG9qSllhZEV6V1J4dHB0YlZrcUNrSGhWN0JRYnNsV1drVCtGMkYrOXZWL0ts?=
 =?utf-8?B?RjFqNWVPSndLZWNNUFIxNDJjSTdTM0tWM2M3ZGljL0ZQcXJLYnNaUVg4YjAy?=
 =?utf-8?B?S0huSkFQSFpYWm9NaG1RUGFWRDRxYTRTUU9CYkMyTW5UMVkrbVJZeGtEOHBu?=
 =?utf-8?B?Rzl4Y1czZUZ4a0dhU1R4UmtjWGhtRkhldlFwUWZsK2o2YjFtU3B4MDBzckd6?=
 =?utf-8?B?MmhzeTNsREQzUXk0TlhQb3hEMGtMdmhkUlBZcC82ejJzWXJjR2VVUDVGbE5u?=
 =?utf-8?B?dENhNzZrOG8wclFRRG0zTzNNTlVRdUIxeUhaMzhQN01JeEd0NGMxdjFjQXBz?=
 =?utf-8?B?aURpMWxMdWtaZHo3SThXTkhydlc5cFJlK0QzOEdNbDIyQkRMM2J4TUdhdits?=
 =?utf-8?Q?Fl2x4Sis+Dw7dHydqpHQU6CDh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b066f2b9-3612-4af9-89d2-08dcb1429017
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:24:22.5737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVeZmv+DKyUEOgwwLRKggfEI2HOiRWj2hxHV85DpuSdtnPS3hmWJVQJWcRz5yEFN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
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

Adding Tvrtko since he was working on a similar patch.

Am 31.07.24 um 10:12 schrieb Sunil Khatri:
> Do not make a function call for zero size NOP as it
> does not add anything in the ring and is unnecessary
> function call.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Please double check if we have some count==0 handling in some of the NOP 
functions and if possible remove them.

Apart from that this patch set is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ad49cecb20b8..0d72d2cbb64b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -145,7 +145,9 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   	count = ring->funcs->align_mask + 1 -
>   		(ring->wptr & ring->funcs->align_mask);
>   	count %= ring->funcs->align_mask + 1;
> -	ring->funcs->insert_nop(ring, count);
> +
> +	if (count != 0)
> +		ring->funcs->insert_nop(ring, count);
>   
>   	mb();
>   	amdgpu_ring_set_wptr(ring);

