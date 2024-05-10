Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C9DC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 13:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194E910E451;
	Fri, 10 May 2024 13:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jfpofy9R";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE6810E451
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 13:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4jH4J1CSMVxcPVF/blxyh8nHaTwaI2zhSnBj9W+0OOgBLKM3dEMOYL4aVl/qz2YhLj1Jhp8PmrCvbKMaIpNNIb+F7g0laqrj4UYvXQ8oCJRdlIQZnklqz/ykVD44Dhk4GWMdwitLSDnrxxbyFjoEdfv197gRyIeOqCfQXwa5cWo1G+cfBYZVSDxGaM2pGOF2gvtEdH+MybgELSFnUy+UYVNnKdGYM0QZahlY7eOoD/z5wYWVPWHzvLq0OvEtZDgk39fPcteOP749TUMaaWcDGzFK3mILGMA8/FGT7fieLB5f/T/asfvtUjFA31173+JldACSqcSGZgqv4A5tHD87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEbVcJvDmWMxbod+2ie+c3Ht0lq7OLN5/FhN9BzBa1U=;
 b=AGzMjO24UV58uaOM+iPu7D8PuVX/KzBopR2PXGUjLiTqycaPzxQcSSGaMp6S2tRQ9wK4UmA1aHVANrlJ0kLj/XQMvAboMHEMi9QZUe8/ngQsH3nT/qXltGsugSeN9jZQc61v+m6D/pXv2aVpPX35c9dMssfu6w9cmWzifcpIxOVab6A2UTOIbNcJJ9VVaiOdwpkdDA8ZMF0WsReOiVTazkXDSwEfTv05Wc+4DeCqA2maccbYUMqzxzj4+/HN1zQEqY8xT8XO3sS7SQnSYRl2WT8+objDxZ8HvCvLVaNLwOp0GWMUX1pQUgvSTa9fB/+/goN38D1ZPali+w/9/qpfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEbVcJvDmWMxbod+2ie+c3Ht0lq7OLN5/FhN9BzBa1U=;
 b=Jfpofy9RQJfF/aOCRxnuynLmtKzxshpeJk2Z0yMBnW3eIuPfu84Vr0IVvq1ojwSnZ0UFbfBHbFLYq73fdW14bArflr8j7wT2D6fH1CVHsWEU6mvHK5eXrf4h84OIiptA4wMiWdIv5RyKDsEyaF2REWcURhorJOmQsApEu6Ut72g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:06:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:06:09 +0000
Message-ID: <ef38bafe-5ed0-4584-9701-dcf9a99e7c65@amd.com>
Date: Fri, 10 May 2024 18:36:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure gpu_id is unique
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240509200626.497769-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240509200626.497769-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fa243b-079a-4dcd-0b0f-08dc70f1f564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkVaQTh6V1pxOTZnRlc3Y0M4NkpmNVlPVHk5YTJwR3RJcVBTWFlNSjhFK2Z6?=
 =?utf-8?B?cmtEVnp2em93aTg1czQ3NFVTN0VvY1N6elZFNythOWZSb2ZmTS91L1Z3UHJ0?=
 =?utf-8?B?dXRFTFZYeTZqYXBNMGNodzVubnRsbElJZTVXZTVWeW1taWVjazJOd1JlSVA2?=
 =?utf-8?B?YkFieWdtK3VBREYyNVNYZVBxK0ZZM2lrUEdnUGN5cU13ZVhadENFRE9OcWI2?=
 =?utf-8?B?eTdiWU56MkR4alJEYTJoeTltZ3h4dFpTNzJ6TEdqNCtTbHdBS2VHTUJ3UGJl?=
 =?utf-8?B?d2s2U3RQV0JlSm9VdVJzNG93ZVBxQzdZQmsxcnQvVzRITm1WSjV3aFlZWFlU?=
 =?utf-8?B?MWdLYkV3NXRUUDZRVlZTT3poa1hSbjBsMXUzY3NVRUczK0dVbUJubXhjUlE3?=
 =?utf-8?B?RW15NUdqTUt4dWJsM0lHeFRPK3lEdG05N0luTGJtQUM1RXJYTjJUZFpGNHFk?=
 =?utf-8?B?S1BtcTUrN2VBZmxhbTRJdXAxd0lTYWI4SkpmUHc5WmtUMHA0aHpZQVY4R0VG?=
 =?utf-8?B?TlN4RVBSQkEydTRVQkYvN1ZLZGIvR2V3dW8xN0NMbnVVd0EyTEdhRHFkNUQv?=
 =?utf-8?B?eGlTRjBsK1oxZGJ3Ym50cGhBbFhYSndtc080M2RMQXBvdllNUXhEMXZIR0dr?=
 =?utf-8?B?cEQ1d3Q3NmpxOGhQMjVKZTBGS2hCby9OSjdJbHZpVTBEejBScGRkc0FPQ3hn?=
 =?utf-8?B?eEd2NFZwMm1rbG1WNDBNOHBLeXhnc2Q2ZmdNeHZ6aVl4V2ozRlgxcExSbUI2?=
 =?utf-8?B?Qk5BOTNQb0EwOW41cVdhQm5hY3djOGEzZThIQ29nR2h2L0ZpRFRoZUVYU3Jo?=
 =?utf-8?B?SlBZUi9GL3RKalFsSDBzMndVWnl6U3FKaFpkVk1KWk5rc2pvckMvUktZcHhN?=
 =?utf-8?B?VjJXSVFZWWtTazdQbDYyVnNIV2J5clowMEhsMHhRbm1sdUY0WmZYYWZLSmht?=
 =?utf-8?B?Q2Q1MGJ2UHhIV2hlVEpmT0xUT2JqVXpWZDBkOWc3d1h1bHNpYWR2bU9TczF6?=
 =?utf-8?B?ZGlkb1RBRWtoM2hMaTlyd20xL0doNGRySHptUTFmZy94VUIvTk9zbTRkVzVL?=
 =?utf-8?B?T0FKRld1K21qYWYrRXNJN055bEVJNG15Q2hISW50em80YkpDazRSaUQ4WVQ1?=
 =?utf-8?B?U3pKdWZqd3lSY1FUbWF6TGtodzMxVDZwRHBMSVVsYTFNUHErSkZrY1g4S29t?=
 =?utf-8?B?ckFTNlZWWVpxY25YL1UrMEZXZWVubjNjU2xmNzFKbmxHaTFEb2U1d3ZrcFpr?=
 =?utf-8?B?bUc3dEo3Q00vNWpjTzhNWUJSdWwxNnlFRXBWOWo5eEsySEM1MGUwYUl4UXht?=
 =?utf-8?B?MzJDSTlPQVlxRHB4L3dnbXpMSGRoTXdRa1dXQVRvb2pjRHZhcDAvemNGbE5D?=
 =?utf-8?B?eUhDZ2hJaElMUmhEQ3d5RUhyTDNNdmxmUU11VS9wTmh4bkRZZUE1NEhvS2JU?=
 =?utf-8?B?YTUxN3NUSXdEMDJXbGhsTEFqRmVxUitWZm1ENFRGeDhiaERkTmdZaDVhTG85?=
 =?utf-8?B?OUN3NUxPK2ZucTBUdlJqQWREZGFEcThCRFNmMHV6K3ZpdEhJSUcyL1hCQ1Fu?=
 =?utf-8?B?aXVEYkh3UFNxV2NkYXphRWF0NVdOZXVCelVyaXE3RlhmMEM0MWNxVC9rUUZz?=
 =?utf-8?B?OXJMcEpTK1doS3dqUVg5WGNKOVFNa05QN0tTTHBiTUI1UjhDY3RQNTQ3a1pQ?=
 =?utf-8?B?WUJiRzArbTVya3cxb3JubFdOSHhHUUZtdjVpaEVFd0FjRk56cEovRjBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2VrSWhia2cxUnFScWszNTJEbDNUTGx0SVd3YnBhVVRkaEEvVU9mSHhCQi9S?=
 =?utf-8?B?YnVGUFE2Zk9oSDJqWkg3clZlN09kK2NLZGJ6Y0FrZ01aMUt6SCtPbFVIR3dP?=
 =?utf-8?B?WHBWNXV2TDNTNEo2RUtsRGVFMkFCbC9NUHpkM3lPdjc2aHFxT1dwVzQ4d0Ey?=
 =?utf-8?B?OEl4MXlUTTN3NDk4ZkNkMG9CVEdTQmFWSGpjZUZTMlpwblE4NjNSY1BCUUFZ?=
 =?utf-8?B?MFQ5NjA4WXZGemhtWXNRUXFtQU1YWFNlSThnSzgrNitoNUNKaklGK3hIREVB?=
 =?utf-8?B?ci8xYWN5emFXa3NqSUxXeDlXTVFrY3FHQ2NzK3p1NzZFUUlRbGdaQnk5WFZm?=
 =?utf-8?B?TkhLQmZaWSsrWXhvZ2tINU9oMzRJMzFQZW9XQ2JsdkF4UzV5K3htYThveW9P?=
 =?utf-8?B?UFlEdUpXMStHSlc0VUNBSGhzV1NCVmxUd1J4d0lEbStiR0dpeVhEZFNLY3ZV?=
 =?utf-8?B?VGc2ZU9WaDFaMW4xc1loWWZVRVZldjFpU094c3g2d0dadGlUSVUxQzNHUitK?=
 =?utf-8?B?Z1Q4RyszUkhVL3d1dmFvdFl4bEMrNXFiVmFhdHZJaUlSQTZLand6QzlBbTdr?=
 =?utf-8?B?U0VtK3I4SzVlcHRoY2VibFc3YUs5VmpmbUYrSW9Xblg2RHNkQ2ZFYm84ZVdH?=
 =?utf-8?B?UVcxNVVOYmdrNDZ3MUUwcnJWbDdjWnBkb1BBZFBnYnI1RFkrcTY2YzMxQ0M5?=
 =?utf-8?B?ZHNJUTFSUzlsYUx0M095TWFZT3ltVDk3RjU4bXZNby9qbld6ZVg2eUp1M0tZ?=
 =?utf-8?B?UjNUVkxJM0Z4cWo3aWo4VmhVRXI4VmNlTmhVNUlXdm5iNUJXazkweSszUmgw?=
 =?utf-8?B?VjNNeWtPak9WZXpWZ1daVDM4TDBoazFjd25ic0QvMDBZZTA3QmJPWnQ3aElm?=
 =?utf-8?B?eHNIYXlNT0FieUo5aVR0ZldoS3Y3U2MwTFJ2b2d0VmxHQ2VscWZaY2l5VGV4?=
 =?utf-8?B?eEFYc2hCUGJvSWZ5QzlhZFQxSWovU25aeDduWklRR2NNVXVYV2lpRldvWi9i?=
 =?utf-8?B?Skl1ZXg1c0VPSnR4b2dVdHJLcm5NS0IwM0MrNmh1VDFoc3czMFA4ZnpKU09p?=
 =?utf-8?B?cHVkTTF4cjBRejZRdDdPWndHWjc2WVhIem1EZ2dDTXVobHI4S2s2ak9aL3ZZ?=
 =?utf-8?B?ZXY5UmtXR0prM25ObDV1WUdnTmg3QUVCeERmVEhuTFByRm45d25DcHM3cmtu?=
 =?utf-8?B?aEtGTnlGTGFCbTRKYzUwZS93bE5Ka2h6d3ZnWGdlcUlOdzNtTzRIUGZHUlg4?=
 =?utf-8?B?Q0JFc2MwcllxcU4vZFlxcGZhTG5MbkRUSFhoVnZxQnJ2SWtCczlKVXd4bERo?=
 =?utf-8?B?endYVFR4RlozMDZVMDY3YkZVb2ZlaFFMcWY1cno3bmt4Z2dYZ3k1T1dVNHp5?=
 =?utf-8?B?dytUMHp2OHdEZmZoS0tseEhBSmVoYnlCQTdmZGd4S1N4WHhvdEVCWEtQcVlC?=
 =?utf-8?B?N0ZiVEN3bWowZjZ1WFBFSEEyNXQwcEtxZkN4U0J1ZnRjRlljUnYrWDRhUGNv?=
 =?utf-8?B?dkFwNFVWZXZrRjZRQUJ6M1Q0Q0t1dkVGcVBsSk5Gb0VkVUtCdTA4Zk01enNV?=
 =?utf-8?B?MzJJaFp3bHhTR3IvOEtMa1RrRENhWjFBYjJMaTBLTm9lTFgwVDBCNnNaazB0?=
 =?utf-8?B?cDZDMFhtNEVzbzJYQm1GU1VEMEVhTVN1WmlDVThxY2Z4M2hScHdKY0l3ak0y?=
 =?utf-8?B?R1hzcjZvc3l6dzVoRUJWcFBUcGlCQzdPYVBVQi92L01nQU52T3lzUGZidkUy?=
 =?utf-8?B?NHlSY2t3SmFIcWZNRnpwZUtkMlovNGVVMTQzNFVMeklFZXZKQlRQQUp0d3RS?=
 =?utf-8?B?Sjh0dnFRaXkrUXp3NUNHSENOd3BMaTUzbkQ1Y2xTK1hXYU9PeWxWeFJkanNp?=
 =?utf-8?B?Yjk3Tzc3bEFZUzlQWXhNWXBzN1cxK1kwNjMzdVZta3A2WDBvZThmaUExdDhq?=
 =?utf-8?B?NlYwTUdMNG5hQnFWbC84S3NySjRlZTlQOWcwYmYzRWdkVTNkY1Q5NzNiczBN?=
 =?utf-8?B?V3pMTFhERnk0Z3U4cWo4T2NLNHZKNHYwbTNOUGVhY2Y3L3creUM4bStVRDJt?=
 =?utf-8?B?NkgzQldteTZLRHhOS0NTdi9sTkd4SWtyQWJHbGx0a2N0SnNXd1RvTUlzYTR3?=
 =?utf-8?Q?wB299hVgiHQRk+WQItzqKcOQs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fa243b-079a-4dcd-0b0f-08dc70f1f564
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:06:09.0013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcW8SD4LXcXE6MB4ZnqIynBaJYyANU5ursPQtGkroncgvRZ2ejjfR3kG2BGS4hAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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



On 5/10/2024 1:36 AM, Harish Kasiviswanathan wrote:
> gpu_id needs to be unique for user space to identify GPUs via KFD
> interface. In the current implementation there is a very small
> probability of having non unique gpu_ids.
> 
> v2: Add check to confirm if gpu_id is unique. If not unique, find one
>     Changed commit header to reflect the above
> v3: Use crc16 as suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>     Ensure that gpu_id != 0
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 40 +++++++++++++++++++----
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 219dcf504f24..4954a3021f70 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -31,6 +31,7 @@
>  #include <linux/log2.h>
>  #include <linux/dmi.h>
>  #include <linux/atomic.h>
> +#include <linux/crc16.h>
>  
>  #include "kfd_priv.h"
>  #include "kfd_crat.h"
> @@ -1091,14 +1092,17 @@ void kfd_topology_shutdown(void)
>  
>  static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>  {
> -	uint32_t hashout;
> +	uint32_t gpu_id;
>  	uint32_t buf[8];
>  	uint64_t local_mem_size;
> -	int i;
> +	struct kfd_topology_device *dev;
> +	bool is_unique;
> +	uint8_t *crc_buf;
>  
>  	if (!gpu)
>  		return 0;
>  
> +	crc_buf = (uint8_t*)&buf;
>  	local_mem_size = gpu->local_mem_info.local_mem_size_private +
>  			gpu->local_mem_info.local_mem_size_public;
>  	buf[0] = gpu->adev->pdev->devfn;
> @@ -1111,10 +1115,34 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>  	buf[6] = upper_32_bits(local_mem_size);
>  	buf[7] = (ffs(gpu->xcc_mask) - 1) | (NUM_XCC(gpu->xcc_mask) << 16);
>  
> -	for (i = 0, hashout = 0; i < 8; i++)
> -		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
> +	gpu_id = crc16(0, crc_buf, sizeof(buf)) &
> +		 ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
>  
> -	return hashout;
> +	/* There is a very small possibility when generating a
> +	 * 16 (KFD_GPU_ID_HASH_WIDTH) bit value from 8 word buffer
> +	 * that the value could be 0 or non-unique. So, check if
> +	 * it is unique and non-zero. If not unique increment till
> +	 * unique one is found. In case of overflow, restart from 1
> +	 */
> +
> +	down_read(&topology_lock);
> +	do {
> +		is_unique = true;
> +		if (!gpu_id)
> +			gpu_id = 1;
> +		list_for_each_entry(dev, &topology_device_list, list) {
> +			if (dev->gpu && dev->gpu_id == gpu_id) {
> +				is_unique = false;
> +				break;
> +			}
> +		}
> +		if (unlikely(!is_unique))
> +			gpu_id = (gpu_id + 1) &
> +				  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
> +	} while (!is_unique);
> +	up_read(&topology_lock);
> +
> +	return gpu_id;
>  }
>  /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
>   *		the GPU device is not already present in the topology device
> @@ -1945,7 +1973,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>  	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>  
> -	gpu_id = kfd_generate_gpu_id(gpu);
>  	if (gpu->xcp && !gpu->xcp->ddev) {
>  		dev_warn(gpu->adev->dev,
>  			 "Won't add GPU to topology since it has no drm node assigned.");
> @@ -1968,6 +1995,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	if (res)
>  		return res;
>  
> +	gpu_id = kfd_generate_gpu_id(gpu);
>  	dev->gpu_id = gpu_id;
>  	gpu->id = gpu_id;
>  
