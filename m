Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD3CEFC3D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 18:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20F710E588;
	Tue,  8 Oct 2024 18:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nzt2iH78";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBDC10E588
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 18:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS+m2O1Jon/5rZvYAVFa/tnNPb4Q4F/Ar8wIkG2+kQ1HxM2TMy4zAaF+jOTj2GP80/vjApO9fcjxSfSAy1uvg0vL2enQuIEEzXtdNInzAdrknLDn62XBSAXOHsKZPxuoYzrw0cNiIA2IT4XPA/ocxRhsbyh8dW9F0tTYZPCjzFP6yMaEQErbQQwqeflFRK1OMl93SW4I1ptUXxfLfmiz/E/Qd5HEkOjCuoED73SSTBlMDRUUC2eNwECuMhNvijfk/vu/ro/4dbfFAN6+Rn13BdXt2wK618jx5ktieiAOtgJa0hcBNhDR/N40+tAkz9lASWoPdz2IAu8Ms2lfzBUNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6GPchwpH2LRRBCZMcL7mFTqhZ3i+0Ex+urZSBxyf/E=;
 b=LgUly6yy54NHBLdNIygEPn/CLMxaU8PiJIUKFZdYMe0FumLoA0c8b6a2T0CgwcUYFreCL0TGXeNfoF0Dn0jOt9RIZu+85ayaBichPQai1A8kZYTmZ+UzMrKm2erxiKUc6eZjeNLLNXuxPKZT2NjnyINQZzb0zVCc80uIltoS22D4jYaQuRQ8dHGUSr7uXvV6uj7lukYle1mrX4dDjLzSVn+dfV9IzK6x87aOpQccKxDrDkM/Qor29VXWlUa7wudQnnYv7dID09oqjRRPgI840oUj5egQAriPQnO1Ep7fYX7qFQ7m4aVzWSDcmaGRYoOcBazJMDuSyEH32pQ1bhc4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6GPchwpH2LRRBCZMcL7mFTqhZ3i+0Ex+urZSBxyf/E=;
 b=Nzt2iH78xbHtzdAicAUQudyhh6A/3p+5ohDvT3Yl3Rz7qvvAD7slCtTL2u2vuqqDDOI8T+dRBgu5R5d6QHogMXjIYeV472MdP6xD0NyGrixIBHpRjv7J1qDit4lJXUS2qZjgS3jyhorntMPlxhft1mW1suFjYzDzgT5L2ME2j+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:38:33 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 18:38:32 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: drop volatile from ring buffer
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, tursulin@igalia.com
References: <20241008181134.1350-1-christian.koenig@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <888bff96-7417-0514-1d19-bac88c6b843f@amd.com>
Date: Wed, 9 Oct 2024 00:08:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241008181134.1350-1-christian.koenig@amd.com>
Content-Type: multipart/alternative;
 boundary="------------07C6498759F348733C6F1765"
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f632e2-24ac-4d61-c1d7-08dce7c86954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmRvT3dDeGVjUHVGaUpYN2tVWGRDdGgvVnNmWEdzbjdLNUI4dDhPd2RoMW9R?=
 =?utf-8?B?M3kzVzQvako2SVR6bjczRzYxblU4UjlTTnlBaGtNdHVTRnBzaEhuNUVWdml3?=
 =?utf-8?B?c1d4Mm1KT2pSS1ZOUmhNNWhQRGtyYzROeXJ1K2xGdkR3eWVJSU5pWFE0OEtw?=
 =?utf-8?B?b1R2cUkzVTA0STJ6Smh0MVJuR216b2c3NXNrWjZZM1VaQ0JSb2xjUjNmeTNt?=
 =?utf-8?B?UkxrUW5mWFIzYXlTaEVSNm5UcWErWk96R05iNDJ5TDFjVkVWQWJiVFY0Q2VR?=
 =?utf-8?B?MnFLRUtRcGY2Tm05WHBoaDhVR0hIZENwTWNmeThpSUUySERvYVdpdVVjdVFP?=
 =?utf-8?B?cTRkajRpbXpHaXMySGNDR3I2UG9CQks3WEFUa29tcVdaMHplUVRPdTlPUXVh?=
 =?utf-8?B?REl3bjBkdEtuM1RtL0l4L05lWVNVSk9qa1c2c3FGUEllbGNmVGc5UjZ6SG1L?=
 =?utf-8?B?U21KYnBENElIbmREdlUwODVtcWNrTWhWYmdhTjAxL052VnY3dXRSVkZGNTJP?=
 =?utf-8?B?OFcwMUtJazY4b2xEQjZVYmcydlJsZUFDZlNKQlpYZlY0TFVKSEpNOE9uSExn?=
 =?utf-8?B?NnA2RDlISHB1SFVWWmcrakR5VFFvcWhwa2FnLzZ3OWlZMGhYZFBDZ3FCeDBT?=
 =?utf-8?B?K3VnL3lXUGhhdFoyYnQzMWZEUU14S0FuN1U2QmJTeEFnbXF5NUxjVnZ5Skxz?=
 =?utf-8?B?bTRzRmRUeW9rcXpCV2NYQ1JpTmZWZHpLang1aWhwdTduWWFjcjVrQ0FMNVZR?=
 =?utf-8?B?c0dsU2hTVHM4bUhsUVF3WmlmcFNrVWJDMGFsL3JFR3VKQldBTWlYR3lUWi81?=
 =?utf-8?B?Z2d5RmZHTjI3OVUrcmZ5NnpPeDdkSFRKb1VvSmdzN3FJM0p3M2ZJRXNHN0d6?=
 =?utf-8?B?SWw3anhablZVY253aGQrWG9SU2RzclB2dWJReDNZaGZNWVFaUXlMTGw5Umoy?=
 =?utf-8?B?K3JHMUJpVUdoak9EMWxhUmlzTmdQK3dwbzcvWUUwTjBTWFpudlRYUExCdkZ3?=
 =?utf-8?B?SWtOMHhveERxc09rWHpQN1gvZVlSYlpySTVjTW9Ybk5wZ3k0QzAwdXh5cEd5?=
 =?utf-8?B?SFJuOU9PQzZuMTlPTGlKR0JpSXJoMExqR1pZM29VMDJPUElvQ2wweXhBNU4y?=
 =?utf-8?B?VjIrZmZHY0tod2o0VXpxOW85MXNyTkg4L2tpQS9McjRmcDZqUkxoeUR6Z1Vp?=
 =?utf-8?B?dkcwcjAxMC80ZkZRbmpsODlXeXprcmQvL0MzVkE3ZmxCMFFrSjV6RUh5RWVn?=
 =?utf-8?B?engzSUpTVmR0TVJQemdmS1RVNGtzWVRKbVQ2UmlnamxIb3MyVExqaC9FMER0?=
 =?utf-8?B?di9JQkNraHJGUWh4d3dNN3FPS3ZpV1JlT0svNXAzN2c4eExRbHQzdFhkMGps?=
 =?utf-8?B?SXM0NjU2YXpORmtOdG9Ia2cveWQrUVFJL0ZRTmVmYXgwNHZhZjJlbDZjQ3ZS?=
 =?utf-8?B?V3UzQkxVS0lMMzI3em1JYm1BWUYzd0RKMWRKVkFUZndqNVJxdE1mU1B1dnpU?=
 =?utf-8?B?N2FDcEI0L0hsaGo3bmZMS1pWT3pseUJNUkNSemxQcm1YOVRLOHdMQXl5TFFS?=
 =?utf-8?B?eFVUUU51Qmpqa052enJrRXhxMnA4djJoUjdORmRKYkFrbGJVbEFsam9hb2hq?=
 =?utf-8?B?RVY4WXhqRHlNYXhQaWtwQTB6L0N4bSthSWJnbnl5MGFTbDZyZnhCeTB0azZI?=
 =?utf-8?B?TlJyS05FLy9CNVphRnhpdFpWeEE2L0ZyQUxTdVZoaUIzU2xqNFFjTnh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHArcFJ1bnFoeFB3Qk1IaVFueDcremRQeVlrVnBGOWYyWHlGS3BLb3BFT3pl?=
 =?utf-8?B?UkJFM3BBZTlTQUpScy9iemU3eUdqaEtmNUE1VXNGZ290ZjVOUHFoMHQzS3NL?=
 =?utf-8?B?ZGg5anJRZlQxVjlNRHFjK093K092andsc2FQK2pRU2ZHQmplVWJZNGNFcnY3?=
 =?utf-8?B?NE5Sc2VwVGZVMjVUUzF6elFKTGZvdmEzRldkTlVtSVlWS0tySVdqOVRLVW5D?=
 =?utf-8?B?TDhpWmthOGNKOG4xZGV3NlY5Vi9nd3dMNHFnSVh6czNKZXhUVjBVcEY4TjNQ?=
 =?utf-8?B?SzZ0YW1sRitmdnYzeDMxV0duZDNmRE94NTRYNHZyU3RzdGNNMGI4d3BMSldV?=
 =?utf-8?B?a2NUSURGblNGNERhRTY0dGVudFdmK0FJd01CcVdqQXBBeUkwWUhLZENJT0lv?=
 =?utf-8?B?SUMvZjhhUzE2b1dIQWxkTHdpU2pXQmtjZjVtcTd4eW81M3pTNGZWcCs5cEJN?=
 =?utf-8?B?WnFYRVVnZVBKbXFPdUNuTmdaYnNkUFNucnIrazV1b21DVmpmbjRoelk1ZEMr?=
 =?utf-8?B?U05jS1MyRXZEQnN3ZGdsVlo2WWU5WG1PS253ZjdKcU40SERNbmszMW9zZ2FL?=
 =?utf-8?B?WGNzVlJ2SWJCZkJmcnZMRnFXRE5URkVCRW1OUXVpOTViMVhMM1FrdWs4YTBV?=
 =?utf-8?B?bTlnUEN3S091ZGFDVFhsWWpUOEpKMG4rQ0M3R01vUTRSYTVDZEl0bnlmMTY5?=
 =?utf-8?B?Mm1tNHczSytXTWcvWnRqVGxGMElmcUZFYm9yVFlUVTNRUlF2RlRGVHoyMnFq?=
 =?utf-8?B?L3JNTW1INXl2cHNKd2Y2c2JIVXN6N3daQWdwZkdxNndneEZhSnJ2czhYMHo2?=
 =?utf-8?B?d1VQVjd3ZVd0Q1h2KzdoS2lydlV4c0dDMEp5dlBHbk9vbGRVM1VQaS9OYVp5?=
 =?utf-8?B?ZzE5bjFMNmlUZU9wSWpPUmlSc1o4LzBaZEtGZTRPQk9VNDgvNzF6dmNGM1Nw?=
 =?utf-8?B?aWNHdGFiL3M4MHJ0MUZ3ME5lRnA0YVU5ckV1U3JSWGU0b3hjK21OZzZBWDZl?=
 =?utf-8?B?MWYwNHhweERTTk1lRWJscXJzdVJBVjRkN21WTWh0cXRHMjhzSGtzb1B6U0Jr?=
 =?utf-8?B?SDgweXVBdmQ5b0dYRVpkaGovUE9iWUt6OE8zaElUUVE3WitnMk1SOXUvdTlL?=
 =?utf-8?B?Q01sVDRnbytvYkE0TTNEK3g1bDNnc3k5ZEF6dHQ5OGJtN2lnVE10YldzdlNM?=
 =?utf-8?B?STRvdGFFNXhPN1ZHazRPdGNHZ2J2dzlmUTd0VHZHbnVuVWJ6aVNxaUpIZjUz?=
 =?utf-8?B?YURPdmNqMXYvU3FPY2tOQWJjZEFEYVRORmtoazQ4aGViRmM0eDlCamtEV01N?=
 =?utf-8?B?Vy83a2hrUHlreUx6TlVnMjNjNncwM2MwUWlzSUc3WERKYndBNGdYSUk4bWc1?=
 =?utf-8?B?SlRUS1U5bU5zempFTVMrbWtJQldQb1lvbHJOOVpQdWE2V2tvdUpkckFQUGxH?=
 =?utf-8?B?dVlBa3lNbUtLM1prZ2FpakEvczRKZUkySzB0SVBtSWgxak93Y1JudkdRRktV?=
 =?utf-8?B?WXNMOTVnbUNLTXNHRHBNMkE4SVVNWmJteFBzVnFYdlA3MENrMmhKM3lnT0RG?=
 =?utf-8?B?eUdhTnVKTEl2TkRiWmF4YWFpZnVjbWhxM1dYckszYTNyV29vMGVMeHN4aTRT?=
 =?utf-8?B?Z0UzTkRXOXB3aXhhc29iUXl2Zi9jbzhoemdKaW1xRWVBanpzQXB6UHBZUjR1?=
 =?utf-8?B?MWgzU2dWdmhlbkoxbitzOVBPcWk2RFJTSUVpMzQremhld0ZMb0EvZ3dtUWFu?=
 =?utf-8?B?L0t5aFEzUWJuSUl3Tzl1R2h2aWMwRDI5bXZkT0tTamt4eVBRYXFkOUdqQXZZ?=
 =?utf-8?B?OTU4aEdYamJENkYrNG5aSm5QUmNkZGEwOWVHcTBJbDl0dVJyUE5XWnl5OFox?=
 =?utf-8?B?RTFJNlcyenA4WnJ1RndSOVdnRXhFTVN6SUI0eUFDUUtHeWZQWmc4RmZKUVNk?=
 =?utf-8?B?bVgwK0pQcnY0MjBReTdSdUZNZVNMems5c2d6ZFhQSDhJMDJvRC9xSU85enRL?=
 =?utf-8?B?c0tEemVXek5wdGdudTJxQnQvWEVRM2YvVEZyeVhoZitmbjM5aXdJeUxVUGgz?=
 =?utf-8?B?eU45dDB0QVo3N1R5azZ5djVGM1hnbzRqS2xsUjFTaWtCR2VUUmFkMjNMOHVn?=
 =?utf-8?Q?S6TH8/zMxLp0s18orjiipQw5E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f632e2-24ac-4d61-c1d7-08dce7c86954
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:38:32.9044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F+9Af+3IHIdl+wBsVnv2k84ZxCDxtVyYsjjEcRExOhZj7kHw1ijy5MSzU5Pgv2rnukDglJjqgiLa8jPpTVe3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
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

--------------07C6498759F348733C6F1765
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 10/8/2024 11:41 PM, Christian König wrote:
> Volatile only prevents the compiler from re-ordering reads and writes.
> Since we always only modify the ring buffer from one CPU thread and have
> an explicit barrier before signaling the HW this should have no effect at
> all and just prevents compiler optimisations.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 ++++-------
>   2 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 910293664902..a6e28fe3f8d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -109,21 +109,17 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
>   	uint32_t occupied, chunk1, chunk2;
> -	uint32_t *dst;
>   
>   	occupied = ring->wptr & ring->buf_mask;
> -	dst = &ring->ring[occupied];
>   	chunk1 = ring->buf_mask + 1 - occupied;
>   	chunk1 = (chunk1 >= count) ? count : chunk1;
>   	chunk2 = count - chunk1;
>   
>   	if (chunk1)
> -		memset32(dst, ring->funcs->nop, chunk1);
> +		memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
>   
> -	if (chunk2) {
> -		dst = ring->ring;
> -		memset32(dst, ring->funcs->nop, chunk2);
> -	}
> +	if (chunk2)
> +		memset32(ring->ring, ring->funcs->nop, chunk2);
>   
>   	ring->wptr += count;
>   	ring->wptr &= ring->ptr_mask;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 574336d6714a..36fc9578c53c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -246,7 +246,7 @@ struct amdgpu_ring {
>   	struct drm_gpu_scheduler	sched;
>   
>   	struct amdgpu_bo	*ring_obj;
> -	volatile uint32_t	*ring;
> +	uint32_t		*ring;
>   	unsigned		rptr_offs;
>   	u64			rptr_gpu_addr;
>   	volatile u32		*rptr_cpu_addr;
> @@ -288,7 +288,7 @@ struct amdgpu_ring {
>   	u64			cond_exe_gpu_addr;
>   	volatile u32		*cond_exe_cpu_addr;
>   	unsigned int		set_q_mode_offs;
> -	volatile u32		*set_q_mode_ptr;
> +	u32			*set_q_mode_ptr;
>   	u64			set_q_mode_token;
>   	unsigned		vm_hub;
>   	unsigned		vm_inv_eng;
> @@ -386,10 +386,8 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   					      void *src, int count_dw)
>   {
>   	unsigned occupied, chunk1, chunk2;
> -	void *dst;
>   
>   	occupied = ring->wptr & ring->buf_mask;
> -	dst = (void *)&ring->ring[occupied];
>   	chunk1 = ring->buf_mask + 1 - occupied;
>   	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
>   	chunk2 = count_dw - chunk1;
> @@ -397,12 +395,11 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   	chunk2 <<= 2;
>   
>   	if (chunk1)
> -		memcpy(dst, src, chunk1);
> +		memcpy(&ring->ring[occupied], src, chunk1);
>   
>   	if (chunk2) {
>   		src += chunk1;
> -		dst = (void *)ring->ring;
> -		memcpy(dst, src, chunk2);
> +		memcpy(ring->ring, src, chunk2);
>   	}
>   
>   	ring->wptr += count_dw;

--------------07C6498759F348733C6F1765
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;
mso-ascii-theme-font:minor-latin;mso-fareast-font-family:Aptos;mso-fareast-theme-font:
minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:&quot;Times
        New Roman&quot;;
mso-bidi-theme-font:minor-bidi;mso-ansi-language:EN-US;mso-fareast-language:
        EN-US;mso-bidi-language:AR-SA">Reviewed-by: Sunil Khatri
        <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><br>
      </span><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 10/8/2024 11:41 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241008181134.1350-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">Volatile only prevents the compiler from re-ordering reads and writes.
Since we always only modify the ring buffer from one CPU thread and have
an explicit barrier before signaling the HW this should have no effect at
all and just prevents compiler optimisations.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 ++++-------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 910293664902..a6e28fe3f8d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -109,21 +109,17 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	uint32_t occupied, chunk1, chunk2;
-	uint32_t *dst;
 
 	occupied = ring-&gt;wptr &amp; ring-&gt;buf_mask;
-	dst = &amp;ring-&gt;ring[occupied];
 	chunk1 = ring-&gt;buf_mask + 1 - occupied;
 	chunk1 = (chunk1 &gt;= count) ? count : chunk1;
 	chunk2 = count - chunk1;
 
 	if (chunk1)
-		memset32(dst, ring-&gt;funcs-&gt;nop, chunk1);
+		memset32(&amp;ring-&gt;ring[occupied], ring-&gt;funcs-&gt;nop, chunk1);
 
-	if (chunk2) {
-		dst = ring-&gt;ring;
-		memset32(dst, ring-&gt;funcs-&gt;nop, chunk2);
-	}
+	if (chunk2)
+		memset32(ring-&gt;ring, ring-&gt;funcs-&gt;nop, chunk2);
 
 	ring-&gt;wptr += count;
 	ring-&gt;wptr &amp;= ring-&gt;ptr_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 574336d6714a..36fc9578c53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -246,7 +246,7 @@ struct amdgpu_ring {
 	struct drm_gpu_scheduler	sched;
 
 	struct amdgpu_bo	*ring_obj;
-	volatile uint32_t	*ring;
+	uint32_t		*ring;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -288,7 +288,7 @@ struct amdgpu_ring {
 	u64			cond_exe_gpu_addr;
 	volatile u32		*cond_exe_cpu_addr;
 	unsigned int		set_q_mode_offs;
-	volatile u32		*set_q_mode_ptr;
+	u32			*set_q_mode_ptr;
 	u64			set_q_mode_token;
 	unsigned		vm_hub;
 	unsigned		vm_inv_eng;
@@ -386,10 +386,8 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 					      void *src, int count_dw)
 {
 	unsigned occupied, chunk1, chunk2;
-	void *dst;
 
 	occupied = ring-&gt;wptr &amp; ring-&gt;buf_mask;
-	dst = (void *)&amp;ring-&gt;ring[occupied];
 	chunk1 = ring-&gt;buf_mask + 1 - occupied;
 	chunk1 = (chunk1 &gt;= count_dw) ? count_dw : chunk1;
 	chunk2 = count_dw - chunk1;
@@ -397,12 +395,11 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	chunk2 &lt;&lt;= 2;
 
 	if (chunk1)
-		memcpy(dst, src, chunk1);
+		memcpy(&amp;ring-&gt;ring[occupied], src, chunk1);
 
 	if (chunk2) {
 		src += chunk1;
-		dst = (void *)ring-&gt;ring;
-		memcpy(dst, src, chunk2);
+		memcpy(ring-&gt;ring, src, chunk2);
 	}
 
 	ring-&gt;wptr += count_dw;
</pre>
    </blockquote>
  </body>
</html>

--------------07C6498759F348733C6F1765--
