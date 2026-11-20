Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817D606A689
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KWyan5ZH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BF5112D43;
	Fri, 20 Nov 2026 22:25:31 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66357112D43
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 22:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUX0GgKi+cW9vnEJxWtC1dQtVblQZGSpdRtDwh/lErwmO5zLz/41QIp5oxWZmqPU+fKCKF5YoWQiFm320WTwdsYh/O8ZVPfGPZH/QnVzyuQcS/xWnZbTt4aInXnnZoRwSiaBElSuKLkAbZOzF3G6a/Dc7ji/dOnXzWziTRNaNM2jew7lpYLRRU89oSj8WSD/jlS1jrJLJ/d6rXGf8kLjCkdLKePJcTncJiugs3chqU5K1IKCNO5LPglGKyHbJcEu+h0pFyhdlqETkWpXPpnH4U1GAoQwlo3PH3RzXO1wo4CT5QVNxr4H+NnGdVMbbBOBg24VROsgQ6x1QrPleMBYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik0sa0ERMFvl5mNZCXZ0y5d6zpqZPu4yOuwnQCDNtqM=;
 b=naXqSIVVDOkrpXr7eP5TNc6zkcM8wZeHz21/tElILdQzW2AmCWcNCHj3pal/IUrh3wt6nU8Z9qw+Q3WqeD8VzuIXWQB7aqo92n1Ua0ot2OxZ6wJn60sS6wYg1KOZgESF+NyDLBe0x7Zzzqm6s1jyTNfv4+U5h0cVsZr3M6jzNv7yzBdWvauFtoUVRzxVJGZa86guzmKyy6Ar3V8lH+3a7xwcMQv21pFrHA9v6RaxBJYveyaMo0Jd6pmYnXC9TUVUX70Bos/DX/Sgu9m36ckiSgRqmXxQ6Kpmy+uVy0iKJmU7vHeTEepZ4nU5rusyn6J6OvzqmUR0Okrr7QnzH64/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik0sa0ERMFvl5mNZCXZ0y5d6zpqZPu4yOuwnQCDNtqM=;
 b=KWyan5ZH+PIedjRHfLkaeqBl3KnaWcNKmSCaKCZAKM2kUtqUvBRdDvpcL8aDNP+1rSX08NEsRKPk4pCjyMeq+S3bw1KVv6Iv+nBeaUxHB+io0mfT73quUAv8Y0Hc0stfZia2dmDrD+ZQG16JbqK7qJ8QlKH4GWAVdvexaIOOv78=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 22:25:21 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0615.012; Fri, 20 Nov 2026
 22:25:15 +0000
Content-Type: multipart/alternative;
 boundary="------------CA60uR9cfWzVyB6HL5NRPODF"
Message-ID: <20c51458-b30a-4049-9074-b2efe472f088@amd.com>
Date: Fri, 20 Nov 2026 17:25:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't require a VM for the profiler PMC lock
To: Apurv Mishra <Apurv.Mishra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Bing.Ma@amd.com, Benjamin.Welton@amd.com, James.Zhu@amd.com,
 Jason.Tang@amd.com
References: <20261120214925.211726-1-Apurv.Mishra@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20261120214925.211726-1-Apurv.Mishra@amd.com>
X-ClientProxiedBy: YQBPR0101CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::34) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a46f313-3af1-4e68-ea7a-08df47552685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|261009221227099003|22082099003|8096899003|261009223027099003|11063799006|56012099006|261026140227099003|261102123227099003|261022105027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: No9uvU+Hluwo1kakunFG9+FTxWMqT9qZ6JU3g8GdifwNr66KzXZ/8uE5J8UE164co1OHoyVNZoISm9iRmTLRUDDwYD8MbYrdXj3VU8QXsistKKy7mpM96g5MuH1auuC7ukuW8r4tfvbch/jIvVnlpyLWwr89AXxIF9X2NFNnPtKhr4tLVyxq2XRm9ZzOGupt46F4FBF07rtqDkX+8iBFrCJlCxjS1pre03jbD6X9wxgFgrgyk44p8rV5CjDtJs04Z1ih1Hfdr5nUwrbs5BF6WTtlBV++6zb1MVOOL8NgoHl0hAcz39+8gIvgGI14V5LlSJ4byqeBfnxhMbhSf3cC5rKbYwgdVtoZ2ssZpvVG29+rFuPQsqfb3CNHVyr4i0mfGUNdomZZ9jRVA5vunZ3q3QLxQZbI6hEeolCqYWcaBc/9NMUpx71nMjbRCkSRhwVcdJRUGgoyUMDikRqKwMLJcozK5zwiMAR2Gyz2j9GPQwxYgKqbitE2mZMlnZY2H2qB/rAVammhl2ouJEMj8Dzc6+rie7ATGIueNpKUa+dSodTYjk+n5J8S1DZcGqIDcyzCLM+bclG28MZLvKdldT3kMgXOq8rv+9b1FKfZBpyp9bGEiPqct6PgQmpFf4ltBrecLGFMVNZu2PKABKoFV/LHhsLJPrL2YFV0U//BBdrysVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(261009221227099003)(22082099003)(8096899003)(261009223027099003)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJNaUl2bFRTTGt2QWlTcmRDRHc4OXdCREFnV1FpL01oV0IreFBlS1VybjVP?=
 =?utf-8?B?RDlnN0VNUUhRMlVTV0E5ZHgrK3JDTXAwSnM2cEdvZzFQWjRLM1RyV2N3YWdQ?=
 =?utf-8?B?bzdvR1dIMFp0R2sra2NSN3VTVlk0UDI4b2Fjd0k4SG5tSzNmaHE0aVhSQ0o5?=
 =?utf-8?B?eTVpQ2VYZGlZNktxdXMrTVBwMnpGNUhEaVNuWmNqcFpaYTJBakthR25NYjlE?=
 =?utf-8?B?TkhnWUUyaEtpK0RTUFF4MU1KaTB2UFEzdi9aV0grVXhKU2NlcW81Q1drQytq?=
 =?utf-8?B?M1lXdW1jTWVVd1BOd1huQUs4WFozVUpEelhjemdKWXZHOTR4N25sb2pJOVMx?=
 =?utf-8?B?V0Q2RXMrMGp6VmdVUWZ5TEY1MnRHNFZkTENRcEFlUHcvd2J2enlYWDJFcE1U?=
 =?utf-8?B?aHQ3NTZGamI0RCtIVC9KbDBYaGRKdFRVN1FDVTc5dFkrUzArQ3VBQ2JDWGc1?=
 =?utf-8?B?SFQ2VUU5cnhkRDFLMUhxdUEvV25PRmFabVBEYXdDbWVkRlB4MUhPSEVNcGpR?=
 =?utf-8?B?TU94MjNicFpTKzVtNkM2VVU4OGhxM0xKeEErSzhvVkp6M1JEOXl1SVlCN1BE?=
 =?utf-8?B?cGR6dENqdnRTWHhuVVVvSUpibm1Da1pxSmNSajRqQXV2amQ3OTY5RG9aZGg4?=
 =?utf-8?B?QndXcmVtZ0wvZHNpZElId1BEZjUrYzgzSTZ5bGcvMWZxT3FlaXNxbWpYK0gv?=
 =?utf-8?B?c2VCNXdLTS9wZGVJcm1FTWVqWjBTTUNBKzBQMzhKMmRzbVdJZUNqWEgxSU05?=
 =?utf-8?B?VFd6UnM3aG1hSDdBV212QldvSk5DdnU5Tmd0WW5mdDI3S2RmTkJpTElYdW0v?=
 =?utf-8?B?VDFkclFXeU81R21XNTk3a0hYVzhCa0pRNnlSYVdSQ3lyUlpaVmMyUEJXU3JQ?=
 =?utf-8?B?SW9VdmtxWUpZY05yc3poYTdBdDJJN0RyTXB6OEJOeHZ3NFc5MXJjWVFQaita?=
 =?utf-8?B?VXplK3NGSlB5Zk9CcHRzRDhTaXRMcDBrTWpmc2hYS1VQdVRyUEYrY3BxdTZa?=
 =?utf-8?B?SjVIZmdNTE4vaDltRnd4bFNIZE5iOEh6R2JIVVZIbzg4VlNRa0V5Y3B6NlYv?=
 =?utf-8?B?cStmWXJlZ25GWUNTZEpRMXBsRmxicSsxSTZFVFpteTR2dlR1cmNUU0JRMC9J?=
 =?utf-8?B?emRMYWlyQUJzYkhaMzAwSmUxZTkvS1kxMDV4UUVUMit3bkd1U3RaVEY4bktM?=
 =?utf-8?B?WWdPd1lqU2hvd1JUQXlXS2E5ZVlyV3RvVzRvdmVhTHd5L2FXN0FnQjlMQXZs?=
 =?utf-8?B?RTZjdGlpTVh1MHBnSEsvVlF3ZTRSNWNlUHlvRlMxTUVraDA3bFoxZDZFajBG?=
 =?utf-8?B?REdCVGRKeFc3bGs4OTAwaGNXaGMwRkZjbWNxSFo5UVVleHJnK0lhMnh5Zkhy?=
 =?utf-8?B?S2RXMmJjVHJ3YmJvK1lCeTJjb0ltd2lPbUVkaFNOKzlXZmNaNmErd0xoNDJU?=
 =?utf-8?B?WEpUYVNRZFVSUzVVL2luME9CM2ZzeDlUbGNXU2txZjU5SDh0a2JJNzRaMDJp?=
 =?utf-8?B?RkRaRytwdUVQajRXSlk3TjYwa081QjlPdTBFRHV6eCt3eGRIMldEYksxSFg4?=
 =?utf-8?B?M2U3emNQVGROeFBQQjBNbWVCeHVKZ0FWRVV4amkyNWdDcjkrL051UGJacFV4?=
 =?utf-8?B?ZDZYZGpmQnFuN3ZrMUw4ZU1hdWMxRXFBSGwyTUwwT3ZpMG9QRml1RVFySVJo?=
 =?utf-8?B?eVZEUnlyQ09JcDl2MytYeXcvdTY3M1RmNS9MV2FCcENyQmpCaWNDbHJtS3Iw?=
 =?utf-8?B?ZUR2YWRkSEJUdnZ0L1V6c0VjemptZy9aRTlxQnJURjMvdmtaOFFtYys0MWsz?=
 =?utf-8?B?VEh4dmhOSEpSWXRwdWxzSkxIZjZaejdLai9vQXg0QzdwNGk5RmRFUEdDZlpx?=
 =?utf-8?B?SXNtMU9qZ2ZneC9meTBWL29tRUpxdCtDR0g4WXNvbTVUMVhPdEQ3TXRYNS9D?=
 =?utf-8?B?SDEzdzd0ZWZoSG92SFRaTldUMGZHeWZMVmgrRFVWQTR5akE4QkhGWUhsRzZy?=
 =?utf-8?B?d3dreDdvRmxtWjlJU3ZnWFU5cDhPR0JJa2FaZ3JlMGN1YXdMcFJuSnYvRVRn?=
 =?utf-8?B?OFh5UVdBcm1qa1RLRFNJZ3R4ejFpZlhwZjFHTFdNUThTWnFIRXc5NzBpY3p1?=
 =?utf-8?B?ZTBZTjFPK09oY1ZSbzQ1UUdrTEo0TDV1cUwxZFhMakg3U1NMZnBrZDlGQzJ1?=
 =?utf-8?B?UDBSWHZkRURiZDYrbHlXcy9TZkVhbGNvbzRoL1o0ZDBpR21HOTFPNjRJdThl?=
 =?utf-8?B?MVV4YUJXdWlLZ0dEVVhpR3NqOHJ1WXdUb05aR09SRXBqdFMwZHhCR2RXOGwy?=
 =?utf-8?Q?04m/AwYvITj62JolXK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a46f313-3af1-4e68-ea7a-08df47552685
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 22:25:15.6535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKmW56i00aKTkhDe8M0TGtK1Ubg8tC2Pzk0aK5n8+0+M2mabjgOV6xZk7mTq5fG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------CA60uR9cfWzVyB6HL5NRPODF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2026-11-20 16:49, Apurv Mishra wrote:
> The profiler PMC requests now go through kfd_bind_process_to_device() for a
> runtime PM reference, but that also requires a VM on the GPU. A process
> that takes the lock before AMDKFD_IOC_ACQUIRE_VM, as rocprofiler-sdk can,
> now gets -ENODEV.
>
> Take only the runtime PM reference, through a new
> kfd_process_device_runtime_get() method that kfd_bind_process_to_device()
> uses as well.
>
> Signed-off-by: Apurv Mishra<Apurv.Mishra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 ++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 54 ++++++++++++++++--------
>   3 files changed, 46 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d2136adb62b..b48be5743381 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3396,19 +3396,20 @@ static inline int profile_lock_device(struct kfd_process *p,
>   	struct kfd_dev *kfd;
>   	int status = -EINVAL;
>   	struct amdgpu_ptl *ptl;
> +	int r = 0;
>   
>   	if (!p)
>   		return -EINVAL;
>   
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, gpu_id);
> -	/* Bind for the runtime PM reference before programming the perfmon clock */
> +	/* Runtime PM reference only: the caller may have no VM on this GPU yet */
>   	if (pdd && op == 1)
> -		pdd = kfd_bind_process_to_device(pdd->dev, p);
> +		r = kfd_process_device_runtime_get(pdd);
>   	mutex_unlock(&p->mutex);
>   
> -	if (IS_ERR(pdd))
> -		return PTR_ERR(pdd);
> +	if (r)
> +		return r;
>   	if (!pdd || !pdd->dev || !pdd->dev->kfd)
>   		return -EINVAL;
>   
> @@ -3474,13 +3475,13 @@ static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id,
>   
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, gpu_id);
> -	/* Bind for the runtime PM reference before programming the perfmon clock */
> +	/* Runtime PM reference only: the caller may have no VM on this GPU yet */
>   	if (pdd && enable)
> -		pdd = kfd_bind_process_to_device(pdd->dev, p);
> +		r = kfd_process_device_runtime_get(pdd);
>   	mutex_unlock(&p->mutex);
>   
> -	if (IS_ERR(pdd))
> -		return PTR_ERR(pdd);
> +	if (r)
> +		return r;
>   	if (!pdd || !pdd->dev || !pdd->dev->kfd)
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 129363ad4e34..e6291e273599 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1152,6 +1152,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   			       struct file *drm_file);
>   struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
>   						struct kfd_process *p);
> +int kfd_process_device_runtime_get(struct kfd_process_device *pdd);
>   struct kfd_process_device *kfd_get_process_device_data(struct kfd_node *dev,
>   							struct kfd_process *p);
>   struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f959f19d92d2..eb286279bba0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2010,6 +2010,39 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	return ret;
>   }
>   
> +/*
> + * Keep the device out of runtime suspend until the pdd is destroyed. Unlike
> + * kfd_bind_process_to_device(), this doesn't need a VM on the device.
> + *
> + * Assumes that the process lock is held.
> + */
> +int kfd_process_device_runtime_get(struct kfd_process_device *pdd)
> +{
> +	struct device *dev = adev_to_drm(pdd->dev->adev)->dev;
> +	int err;
> +
> +	/*
> +	 * make sure that runtime_usage counter is incremented just once
> +	 * per pdd
> +	 */
> +	if (pdd->runtime_inuse)
> +		return 0;
> +
> +	/*
> +	 * signal runtime-pm system to auto resume and prevent
> +	 * further runtime suspend once device pdd is created until
> +	 * pdd is destroyed.
> +	 */
> +	err = pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		pm_runtime_put_autosuspend(dev);
> +		return err;
> +	}
> +	pdd->runtime_inuse = true;
> +
> +	return 0;
> +}
> +
>   /*
>    * Direct the IOMMU to bind the process (specifically the pasid->mm)
>    * to the device.
> @@ -2032,24 +2065,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
>   	if (!pdd->drm_priv)
>   		return ERR_PTR(-ENODEV);
>   
> -	/*
> -	 * signal runtime-pm system to auto resume and prevent
> -	 * further runtime suspend once device pdd is created until
> -	 * pdd is destroyed.
> -	 */
> -	if (!pdd->runtime_inuse) {
> -		err = pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
> -		if (err < 0) {
> -			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
> -			return ERR_PTR(err);
> -		}
> -	}
> -
> -	/*
> -	 * make sure that runtime_usage counter is incremented just once
> -	 * per pdd
> -	 */
> -	pdd->runtime_inuse = true;
> +	err = kfd_process_device_runtime_get(pdd);
> +	if (err)
> +		return ERR_PTR(err);
>   
>   	return pdd;
>   }
--------------CA60uR9cfWzVyB6HL5NRPODF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style>
</p>
    <div class="moz-cite-prefix">On 2026-11-20 16:49, Apurv Mishra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261120214925.211726-1-Apurv.Mishra@amd.com">
      <pre wrap="" class="moz-quote-pre">The profiler PMC requests now go through kfd_bind_process_to_device() for a
runtime PM reference, but that also requires a VM on the GPU. A process
that takes the lock before AMDKFD_IOC_ACQUIRE_VM, as rocprofiler-sdk can,
now gets -ENODEV.

Take only the runtime PM reference, through a new
kfd_process_device_runtime_get() method that kfd_bind_process_to_device()
uses as well.

Signed-off-by: Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 54 ++++++++++++++++--------
 3 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..b48be5743381 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3396,19 +3396,20 @@ static inline int profile_lock_device(struct kfd_process *p,
 	struct kfd_dev *kfd;
 	int status = -EINVAL;
 	struct amdgpu_ptl *ptl;
+	int r = 0;
 
 	if (!p)
 		return -EINVAL;
 
 	mutex_lock(&amp;p-&gt;mutex);
 	pdd = kfd_process_device_data_by_id(p, gpu_id);
-	/* Bind for the runtime PM reference before programming the perfmon clock */
+	/* Runtime PM reference only: the caller may have no VM on this GPU yet */
 	if (pdd &amp;&amp; op == 1)
-		pdd = kfd_bind_process_to_device(pdd-&gt;dev, p);
+		r = kfd_process_device_runtime_get(pdd);
 	mutex_unlock(&amp;p-&gt;mutex);
 
-	if (IS_ERR(pdd))
-		return PTR_ERR(pdd);
+	if (r)
+		return r;
 	if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt;kfd)
 		return -EINVAL;
 
@@ -3474,13 +3475,13 @@ static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id,
 
 	mutex_lock(&amp;p-&gt;mutex);
 	pdd = kfd_process_device_data_by_id(p, gpu_id);
-	/* Bind for the runtime PM reference before programming the perfmon clock */
+	/* Runtime PM reference only: the caller may have no VM on this GPU yet */
 	if (pdd &amp;&amp; enable)
-		pdd = kfd_bind_process_to_device(pdd-&gt;dev, p);
+		r = kfd_process_device_runtime_get(pdd);
 	mutex_unlock(&amp;p-&gt;mutex);
 
-	if (IS_ERR(pdd))
-		return PTR_ERR(pdd);
+	if (r)
+		return r;
 	if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt;kfd)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 129363ad4e34..e6291e273599 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1152,6 +1152,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 			       struct file *drm_file);
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 						struct kfd_process *p);
+int kfd_process_device_runtime_get(struct kfd_process_device *pdd);
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_node *dev,
 							struct kfd_process *p);
 struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f959f19d92d2..eb286279bba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2010,6 +2010,39 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	return ret;
 }
 
+/*
+ * Keep the device out of runtime suspend until the pdd is destroyed. Unlike
+ * kfd_bind_process_to_device(), this doesn't need a VM on the device.
+ *
+ * Assumes that the process lock is held.
+ */
+int kfd_process_device_runtime_get(struct kfd_process_device *pdd)
+{
+	struct device *dev = adev_to_drm(pdd-&gt;dev-&gt;adev)-&gt;dev;
+	int err;
+
+	/*
+	 * make sure that runtime_usage counter is incremented just once
+	 * per pdd
+	 */
+	if (pdd-&gt;runtime_inuse)
+		return 0;
+
+	/*
+	 * signal runtime-pm system to auto resume and prevent
+	 * further runtime suspend once device pdd is created until
+	 * pdd is destroyed.
+	 */
+	err = pm_runtime_get_sync(dev);
+	if (err &lt; 0) {
+		pm_runtime_put_autosuspend(dev);
+		return err;
+	}
+	pdd-&gt;runtime_inuse = true;
+
+	return 0;
+}
+
 /*
  * Direct the IOMMU to bind the process (specifically the pasid-&gt;mm)
  * to the device.
@@ -2032,24 +2065,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 	if (!pdd-&gt;drm_priv)
 		return ERR_PTR(-ENODEV);
 
-	/*
-	 * signal runtime-pm system to auto resume and prevent
-	 * further runtime suspend once device pdd is created until
-	 * pdd is destroyed.
-	 */
-	if (!pdd-&gt;runtime_inuse) {
-		err = pm_runtime_get_sync(adev_to_drm(dev-&gt;adev)-&gt;dev);
-		if (err &lt; 0) {
-			pm_runtime_put_autosuspend(adev_to_drm(dev-&gt;adev)-&gt;dev);
-			return ERR_PTR(err);
-		}
-	}
-
-	/*
-	 * make sure that runtime_usage counter is incremented just once
-	 * per pdd
-	 */
-	pdd-&gt;runtime_inuse = true;
+	err = kfd_process_device_runtime_get(pdd);
+	if (err)
+		return ERR_PTR(err);
 
 	return pdd;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------CA60uR9cfWzVyB6HL5NRPODF--
