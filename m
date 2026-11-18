Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF804606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KBJvoRxm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3AE10E177;
	Wed, 18 Nov 2026 06:09:13 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A2610E177
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 06:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaPMQTZ7/yp3g86r0/nVIPu7mOkxSNr7Q5f7mURWTEhCetQBRQOy3YUNfFAId4awJFosy/+drFyDQJ+MZkFEUNjqgOH1eSA4WgmcDS6aP/BJD5I0Cf1PSkhpK5PEtdmKa/+Jau7jiV+H2oWokNwyiVFPue2NjvHnTS+YKhcrCb8HJlyjAa2rYcWMNRDgoY+Pf2P+3q5WXG1iBri9wab59v6dz6YGniunp5/jPt+GfzqppgOVtsSiU7R6CiISgYbPgnxrcEYxvTfjrMWNXxEa39822wPpaLzfDXZzGk19McZdUu9HtakyxmwFvUbe0mCcgxZLm/Ng8Y+E3pJTegIddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBT8Tr7sOTVLPNcmSi/nCfIbhV9B+2nsNT1WSMoOcO8=;
 b=gG3wgF6MO/0qm6TKYHFksK1gQKdyVsqd9W39+pHEBeOqXBLK9a3y8c13+51h9EDHQtcqupP8wrg4x69bfnrw22yXLX/kVdKT7AB6Dfz1txhbW6OpfZTB8DA8ERXlgCi4vKonBStkpj2K8l6016ysYeGhOd7S0jccMDZXvtDfy/gypSb5cCGEA9sZ+C0r8zz/lxFR1ALUMfKYQLc/D5yDVl+Wpz45p8wSdB0W0ds9B3jKnbqqtgPY/75zXwm1feC7gEl0CcGxtUleazsyWwdC6CdtsfR6NNFSxWsSZCKd4yaJrcG0kfXFMvikizWPHPPBmBBPWSbzHKSyJwY7MUNvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBT8Tr7sOTVLPNcmSi/nCfIbhV9B+2nsNT1WSMoOcO8=;
 b=KBJvoRxmGMMhdV0VGulRnnnedxobxXK4aMH9/tK+BRlI/tqvzc/Cetev9eIw/dzWlBey6UxexT5rk1hRjWj1Ps/x/5SFzRaeGIxx11CsDaUORzuXYFUcktkPZ2pQ9pjTnJxhfmplEwkxfHmfPuGVTD05WA0nTwGkRbzyRJ0FqO0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS6PR12MB732632.namprd12.prod.outlook.com (2603:10b6:8:4d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:07:02 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:07:02 +0000
Content-Type: multipart/alternative;
 boundary="------------40FNBv0f9AisP88R0ba6xQAj"
Message-ID: <2fd6830e-2be7-4478-be5a-497e23a7f082@amd.com>
Date: Wed, 18 Nov 2026 14:06:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix context ID cleanup after failures
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261117215714.50191-1-felix.kuehling@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <20261117215714.50191-1-felix.kuehling@amd.com>
X-ClientProxiedBy: TY4P301CA0097.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::8) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DS6PR12MB732632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5694c89a-8264-45db-ddb0-08df453a29be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261102123227099003|10067099003|11063799006|56012099006|261021123027099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: Q8HABY0LhyanZ9Ty85m4z9CMMoeF1YKQwvQ2otuSQuajmX/6iY2Ft3LpaStI+ZpbN4sFZDj+dDDbONBzXm99sw7fDdUyiJG2BLg0bJ3moOSSHpkjeZXuICr4pmz+YksRbAbtXd7q/OmHKjh9BLODUMZstZBLcDF/kjqT7WM1G2HirUg7lrzvwiK9dJ9M0xxccNBpCLqvPrqQIn0aQBs71jyOc2a2rOtTQYGvn0g0oJDCsyXh7BaPXQy5FozMWXdAGFeeA2EUjRtPNgw4yQq6NnxTWqHTfuUiTJnbJdnfeSPY0vqQSf+kt6PYwfx71Hg0Vl7+lLseHbcRop0xwmvIhCz2+lALnZyRYr6B6q6dRbZ+pIO5aOMC2DY4n7NP2ug6jh4ET1TS0UocHdz37+APMc1uci/+ahUnKfVfPDzXl3v+9/meFide0R0el4ZqTfEPVYs92ZwtRO16PrcZkeLrXeJcjOstwGn4cJb5iU5F1DLGONRQ0cc0R3Rb/kiDw0hF8oP3JbRXcaUdo+D6oaViWEByq2Qxebi/p7PQ0ZpHEpu+LAX06fHBIfZIK4HuR10PoFd9XbCRyIjnfdRNlLpxaYbI4OFzuaFBoNnbh7ac6R6dTdhNdFJ0d0nrKzN5avRsmMD/uKzaoYKgn4rikK8xq8NFRZa4epPD1St97p57kiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261102123227099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxoRVhndnp6VC9nNzVDOUhRaS9KbCtlSWRTN20yWWpHVDRqU0dwZ2g4Y2Z0?=
 =?utf-8?B?TnRDUDJzSmNlSjhlcWZ5b2xGb3NjRlZucVo0MDc4b0FKaThycmxDVFBlYTRC?=
 =?utf-8?B?eHYzc0JORDFOQjFFRXFxeitmeDNzYnl5anNQb0JGNTByME1IMW95SXJ1RVNT?=
 =?utf-8?B?ODNmMmkxSWI5SEJTbEpQUnhINEdiaG9MVGd5alovQnEzYWtGdTNyNGRmT2NN?=
 =?utf-8?B?Nnd6RjU3VUZldHFUUm4zU2xmeDNscy9JSkZxV1ZhRFlyTExOVnFUdG9kL1ZW?=
 =?utf-8?B?cEhqdG1MM0VGblUzcG9jZmpMeFNKMS9tS2ViMTI0a1hNcC9Jb1htdVVGOEcr?=
 =?utf-8?B?djcwb1dSZjB3ZmgrSHdySVZ3T2l4NWtWUFF6aytNbW5TL2t6ZXVFUW5wMFNr?=
 =?utf-8?B?cDg3bVJJcU9yeFd1QXVBKzh0UERWdHVQclYvN1FQL001dklKYUkwRC9VT2Jl?=
 =?utf-8?B?ZG9hS1k1aFJjOFREZEZxeW1uSG1xSmpIRzZEbTlwa0ZGZjBLTmF1U2JZZlBH?=
 =?utf-8?B?dko2Zzl5NmRSS2FMZWYzU1JQY004TG9DZ2JtU0tnaGNoTlpNMTNoM0pLdzZj?=
 =?utf-8?B?YVZHbTNGQnAwZUtjekkyNExJcTRsMDl4UU9lT3ZVTTFzTEZ6eEd4ckhldTRn?=
 =?utf-8?B?NVNXQWFCYkw1cjhIS0JObjl4N1VvRVh5alduMjBsNWpUaVVpdi9oU1dFaVY4?=
 =?utf-8?B?cFBmYnBTVitsNTNNU0g3RWVEb2ZQZTRsbFpYK1hTQ2ZkNWg4SVhnR1BFTWdo?=
 =?utf-8?B?MlYrckpWYStuZlFDdHV0Sy9QSk5DQU9uM2Z0OU9JTEM5bjViU2ZFMFdjaWhQ?=
 =?utf-8?B?L2M1WG9JSDkzaHhveGlPd29ENCtkZGxKRnVxV2JtZ0NDZ0IvOXhMRkFBaVIv?=
 =?utf-8?B?UU1MTW1pbU0yMDZVN2dYWVN3MWEySFB4ZHgzdTQ5SVlXb2JPRDZUcUNhWlkz?=
 =?utf-8?B?NTYyaVd6MTlRWHFiRkhWbGUyeE10aFRtbGhROExETmtSckNKZTlTOWFFUDh0?=
 =?utf-8?B?eU5NZzNudVNqeVM4dC9WTmFIVGZBN2xMS3ZNK3crOXVGZEdQdnNxTHBkSWpK?=
 =?utf-8?B?WWpGclFoazV2SmZVUGlRSm16ZmZDWXM2UXUrdEtWNUJXOFErdkxBbFp3OE85?=
 =?utf-8?B?c2NVNmRIZllmU1pvRWVCcTRyVy9BcHlENGkwM3VDL0YzVUdNYTZCSXMzMXZh?=
 =?utf-8?B?dEZ5WXZBbHlsdUU2UlFUZGlMV2paM1pVMFNnSStSaGRIYjJkQmJ0UGRYZGk5?=
 =?utf-8?B?dXl4WHI4ci9RbXV0MHJmN3daYXVBMHF1NHloUXBDRGt6ZGVBNHFCZ2ZFQ2pP?=
 =?utf-8?B?dm1YZ096OHAzRjhCaDhvWDlOUTdPazNvb1ZSNXVhOWJnUWNyTXNlQ0dYaFZh?=
 =?utf-8?B?N29hRkVIU2p3MllYRTNpaW9RaHlZQ3hKdVAwR09XQWVFNW8rUTJVdGhhZlgy?=
 =?utf-8?B?TWN2MVZqMHRFclRZWmJ5T21jL083bEw1R2lZeVFhMDdQaE9reXlHSUZQVHlo?=
 =?utf-8?B?Nk9kbHA2U2F5c2lIYXp6a0RDTjRwRXZVMHJoY0VZOHh6TEg4NldxMDFXMjk4?=
 =?utf-8?B?b2c3c0VVNjNSeVNMTUZZSVFuUEYyU1Z1SlFrb1lxc0N6OFdWa3JBdTdQeHBT?=
 =?utf-8?B?QXdVYWVibnpzcHo3R3RZOU1xeTBNUEpZdGthak5XNENGY2dVSUwxS05YZVV3?=
 =?utf-8?B?VHM3czkvYnVpSFJLd1hpaXJNNnJiWXhWT2MrRkp0UnRwcGgzenJWZHE0OEJV?=
 =?utf-8?B?ckxJL28wMnFXUWhXQTMydWZPRnh4ZFJrZDV6dlhZSGo2VXc2cENrQllnbk43?=
 =?utf-8?B?elZNNzJCTHRaN29EZm9Ha0o3cEJUTWw3RGorejkvcHVLSnp3T0ZlWk5aY2Ji?=
 =?utf-8?B?RDFjWm1oM1M5Y05OUXlKTXRVRE9XMjhoQVF2NGovLzJ1RlpXTkkvR256UVNB?=
 =?utf-8?B?R0pSaEU2dlVsZVZNS0QvbUZtdVljS1NhNFd4MHdxSzNhNDdMbGhSOUY4SDdr?=
 =?utf-8?B?aENFU3k4eHBvOXA5ZElHUnBOS2pGbTdySk1JUFM3ZUR2STBRMmdSMW90Uisy?=
 =?utf-8?B?UU9FbjRsbGJIMnNoa1NkdkVnRnBCeEIzK3c4Q2JHaTF1bzU3bC9oeDVlbFFV?=
 =?utf-8?B?QUc2UTBoNlJ4bmsvdkJ1d2ZhSyt0NkUrWE5raHpOZ3U4UkNKMlY0MllVZzFu?=
 =?utf-8?B?NWxTSEprWGdBRTJySlo5dENkR1Y0c2JRSnRFZldLNWZTSUd6YTVGaWlDZFJX?=
 =?utf-8?B?NVJhdkhGTVFXWVQxNm9ZRXhzZmZFWXV0Z29OeDBzRjNTT0dEdHp2eXFwUUNJ?=
 =?utf-8?B?ZlRIZUxJc0JrVHI1R1NnM0JPZnZORHdjWEtOM1pXR3VSNElxb0JIdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5694c89a-8264-45db-ddb0-08df453a29be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:07:02.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziK2ogJfmUvp9vJXRQgZoWGFfJOXW/ahcCpN0B/I3VAd/Uj4Yt0eet25SYITawak5ecmnQ51jSpm3XFf/OISJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB732632
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

--------------40FNBv0f9AisP88R0ba6xQAj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/2026 5:57 AM, Felix Kuehling wrote:

> If secondary context ID allocation fails, the context ID remains 0. Make
> that distinguishable from a valid context ID to avoid double-freeing
> context IDs.

Thanks and Reviewed-by: Zhu Lingshan <lingshan.zhu@amd.com>

>
> Fixes: fac682a1d1af ("amdkfd: identify a secondary kfd process by its id")
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3292e616d36f..2c8716d45e3f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1083,7 +1083,7 @@ struct kfd_process {
>  
>  #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>  #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
> -#define KFD_CONTEXT_ID_MIN 0
> +#define KFD_CONTEXT_ID_MIN 1
>  
>  extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>  extern struct srcu_struct kfd_processes_srcu;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ffd11576a0bb..d1b6b6305439 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -950,7 +950,8 @@ static void kfd_process_free_id(struct kfd_process *process)
>  {
>  	struct kfd_process *primary_process;
>  
> -	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
> +	if (process->context_id == KFD_CONTEXT_ID_PRIMARY ||
> +	    process->context_id < KFD_CONTEXT_ID_MIN)
>  		return;
>  
>  	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> @@ -1790,7 +1791,6 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>  	return process;
>  
>  err_alloc_id:
> -	kfd_process_free_id(process);
>  err_register_notifier:
>  	/*
>  	 * The process is already in kfd_processes_table, so find_process()
--------------40FNBv0f9AisP88R0ba6xQAj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 11/18/2026 5:57 AM, Felix Kuehling wrote:</pre>
    <blockquote type="cite" cite="mid:20261117215714.50191-1-felix.kuehling@amd.com">
      <pre wrap="" class="moz-quote-pre">If secondary context ID allocation fails, the context ID remains 0. Make
that distinguishable from a valid context ID to avoid double-freeing
context IDs.</pre>
    </blockquote>
    <pre>Thanks and Reviewed-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a></pre>
    <blockquote type="cite" cite="mid:20261117215714.50191-1-felix.kuehling@amd.com">
      <pre wrap="" class="moz-quote-pre">

Fixes: fac682a1d1af (&quot;amdkfd: identify a secondary kfd process by its id&quot;)
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3292e616d36f..2c8716d45e3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1083,7 +1083,7 @@ struct kfd_process {
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
-#define KFD_CONTEXT_ID_MIN 0
+#define KFD_CONTEXT_ID_MIN 1
 
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ffd11576a0bb..d1b6b6305439 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -950,7 +950,8 @@ static void kfd_process_free_id(struct kfd_process *process)
 {
 	struct kfd_process *primary_process;
 
-	if (process-&gt;context_id == KFD_CONTEXT_ID_PRIMARY)
+	if (process-&gt;context_id == KFD_CONTEXT_ID_PRIMARY ||
+	    process-&gt;context_id &lt; KFD_CONTEXT_ID_MIN)
 		return;
 
 	primary_process = kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
@@ -1790,7 +1791,6 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	return process;
 
 err_alloc_id:
-	kfd_process_free_id(process);
 err_register_notifier:
 	/*
 	 * The process is already in kfd_processes_table, so find_process()
</pre>
    </blockquote>
  </body>
</html>

--------------40FNBv0f9AisP88R0ba6xQAj--
