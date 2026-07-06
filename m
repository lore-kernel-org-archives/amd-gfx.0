Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E15FC43602
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 18:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD90310EA37;
	Mon,  6 Jul 2026 18:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLUzmxBU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924A110E1CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 18:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTNDAk9HafFRZTzT3dmM2dxF8vIGy7lcgieMp89lhO9Zutx6TXfxhbq8dLuKeoECawXBTp2Sbwv6ct+OIVUS2JO05gXDLqIwQuftfqloTVT/j4dEJN0A1f4c8dIMyQkcUdLJRy3OHDbRfZiFWtfJCDD71QMMKim4BJoKQGyuM0mnVcBr6yfc7+3eSJIz7z7ac33LmSZNVNLpw4E21RojDkhiQDFXODb5KRCEgFsBtaLGfBvFPZoz/xaBw2phrE1gxuVcwNP9Ke/CZ7nuVuOlFrQMauCAFYya2fwrJnlAviJT6fqI/0oL+ESik6bHxcQS1mrUbMJhvTmZeraodSMYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaLVwBseUHFR30mqLvw2ORuTcbgKiNGjU2zg52ubZm8=;
 b=OatYUDECvyKAA/uFzFIyzDQzjS+ZCaDW9tsNM61XhFUV2XmlepEdehhDyJ/Quiom0qYaH6dPO0Ddk3VUfEFDgd1szLEeRmfwM6fwMIhmnYS4fNz7NAfoyOuRcNZAhoM92n379XcRs+/ARkm0FKDtQveiAV1GwqBmPCIKY9H/zmbR4Xm7NaqFpqsjgFi17kz4GFr/WasXImCHzKcf/R+dScKbL87gZi2EukdYyplPNVgM4Kk+xHslMVL5kgvI6XYKizqSqsf2YGqJLsmrdDADQbFuF7wU921Q1oxz8CWLRPAM+RG7iBmkXbCtTs3hY46Y+OMBKZPePU2vpUvwiCQikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaLVwBseUHFR30mqLvw2ORuTcbgKiNGjU2zg52ubZm8=;
 b=GLUzmxBUOsxfeZ5Tnl4sPsFIuV7ZTrGBtd1nGc81KsainbLmf38aRT3uD/w04DtwyWg/4BVKJobbNaby927dsvB4K2VCwLGnPwAelwZ156kahAIlv7tZI/eFPkp7NREi005fMDCW6w2hNcgz94Ok/8E78qCKGaD61Bk9a5bjnb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH7PR12MB7455.namprd12.prod.outlook.com
 (2603:10b6:510:20e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 6 Jul
 2026 18:15:12 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:15:12 +0000
Message-ID: <44417b66-afd1-4d56-abcc-d8dc903bfa9d@amd.com>
Date: Mon, 6 Jul 2026 14:15:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: expose pasid of secondary contexts by debugfs
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260701040649.8836-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260701040649.8836-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::28) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: a68eaac9-7c63-424a-8389-08dedb8a856a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 10CP/TzMTlQSFR2g7eYU6oJyezVyEjWanQlRqr8VLf5RMRdtvO8pKdEyWOHqqGyh6AKZ95j+LB62NHmasA2fstbbmTMp64b87HvOZ5S5oaOPVKoT7CksROl9QclGX1vVoLle6QjFFe2aqFCnZyJCqH2mqBcKmEZ/EO9aZULQn/IJULwpuq8hrDKPlWqobsTRUXdX1hD3efM89hOo+devJBkJf/wqySil3L+3ZhoPq+Z6mdaEqcFVTcTqqaZUaBZBMOes/T7gkV5sGVIVPz7ixtvTxGmxPcgW+dNHIub3nqPD7TZ8U01hWi/d7Ycxk7LCM2FY3JXrr+Gud82e0XPv5GhGB5yM3Amre2lG5kFkA3hVM0Zasm938T8S2yXr5vY8sW1/tOZMT6uEzWiGWopWo+cmY5SrKiW0D1uR9z8jdcWRymWGR4Rz/tloC2KuJWpdKp1yC/C6sninXGwXlREItxWBtvzwbDoniT2BsLr0IEqcBl+7FWARqUfLLXpH5Mq/yE1mOjLEZxeUHOfm1hU1cvGJWx+lTTelJYKcth1rgFiJLLWOiSow2oJkt+oDqWqP8z20Qp+/f1WuyHfAPjqYEjyQcyMRDmFEjYiJWqi0sbxzWLaN0aeJ21zE/Ov4sAnfoaafjwppsxnJ6IjPhzzzQJzdXU8C/rfAZ/bFU7jboRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25COFhiMlZiUVdwMDkzR3c5cWxHU1gzbHlkMDNLYUtFRmpkRTVLVm5KN09m?=
 =?utf-8?B?UWo0SWd4QlZ3enA4aTdrSTZTemwxRlZDNWhVaFBoQmpWVTFUMGdjaEczQ0VR?=
 =?utf-8?B?ZVdFN0ZMb1hNd29nQjY0TmN2RFpiK3p2VWdOdnp2NGI1clg0Y0JYMEZUVDJ2?=
 =?utf-8?B?eTdVOWxQZUw5SVMwZC9LeE9WeWNqU3JoVmRpaE1hNDdTYzU1ZU9zRmdGb2Iz?=
 =?utf-8?B?U2ZtY3phdWZUaC94b1pEWStSeE5tK3BXMWlDMEYrRTUyUkVIZTIweStpRFM0?=
 =?utf-8?B?aU9DU00zbWFJbEM5MGlud2s3cmNwOTIrYVlIczBIa2dOc1d4RjNPZjhnVzVk?=
 =?utf-8?B?ejh4c3ZJWjRvUWpCK0wxdnFiVjdETkg3UWE1eWRmdmxBRWViR29MK3diSCtj?=
 =?utf-8?B?RlBBRWxkU2tvU1I4K1NGeHphYTZaY3QzMFRZaFF1a0I4Rk1MdHFRMVNENFho?=
 =?utf-8?B?b0tGYkJWWlBmeE9KTEhBcklwL2Z3UUY0bHJFZTN0NS9wTFcxY2lDY2kwK1Bu?=
 =?utf-8?B?aC8yNWhTK0RyLzZXMlo2T1RjLzBJdXhnUForU3ZCaEZtWnBadEQyUHA3aVN3?=
 =?utf-8?B?bkNmREhWRzdGZ1NXaklmb3I3Tlc3bTYyNW5OK0QyMzY0L2h5bDF0OStHc3Rm?=
 =?utf-8?B?eVZTcVdNNEhtT0hOUTF4YUg5TlhmbVRrVElnWTVsWkdlVkhtazMyTW9obnl4?=
 =?utf-8?B?dVpZdDcxRlo3dnFQeTJ4dkRVV3o4bEZRem9lU01HQTlER2xNb0UxdUtyRDla?=
 =?utf-8?B?am1CMzJxNHBsUmdSNU5ha0Ezc2N3VFVCNTZWeTFMWlU1NTQrS3hFSVV6UVky?=
 =?utf-8?B?eHZaOUExMUx1MEh6cWNFZ2pXMUNMWnlCT2V5Rnl3SWdZMWNMelBGZEFzSXU5?=
 =?utf-8?B?TlluMFlaU0VIYzhvdVN0cmtRVDU5bVgzU1JVS0hDaENkWEt4cDRlL1ZXWVY4?=
 =?utf-8?B?STl0TW1ZNVVZazhSZkRVQmFkWitaZzA4RURlSVEzZkpET1BNcEdLdEt6aHVQ?=
 =?utf-8?B?ck1QQXA4QkpxTjJ2WTlTMEowWVF0UzB1OG1DbmFhNFdMQnEyTnA4VVYrWTU4?=
 =?utf-8?B?NDJtL3lBak1jUGdEUGczS2FVZHhMNTZyRmZXeFJSNEpuM055aFI1VjBJdEVT?=
 =?utf-8?B?eXo1c1EyM0o3emYzU1cxdG9qcHNkd05ET2Q3eFE3KzZzTEF4ZFlZR3dqeXIy?=
 =?utf-8?B?aUlJcnEzQk5FbXBJNjJEcUQ5QkptbVBMb0tVN2VxWTBWTnRBU2tpbkVwdTVy?=
 =?utf-8?B?bGsxOWFYa0toZFRVSDZCUzRra0huc3ZLT3d1REVDeitEN1gvY2dYdjNKSVFj?=
 =?utf-8?B?bWdjVXVxSHVhYTE5VFYxQ0ZiL1YydDR1eE1zSW1HeGFoU0o1UUYxUWtlalQ0?=
 =?utf-8?B?ZU91L0lrUEVGR0dPSlhVdWZqNkpCQmJGL0VWQzUzbG9tNXgrTUxIanJnMDU5?=
 =?utf-8?B?TjU3cEVsbkpHMitpbS9JTG1sK0Y3QW1yYTFRdjVzUWV0ejFYbVd3SGU1a3dQ?=
 =?utf-8?B?Y2xDeXZrc1JpR1hmakhrVFgvcXBOcko1bldsejI5ZUZHSGMrdGkwWEU5MnJw?=
 =?utf-8?B?ZVFydWZqVWNmcEo2bUN5WUdwQzB0UUlRcWQvbzVRckhxZHo0UjN4NnNST2Nr?=
 =?utf-8?B?NTZMYkpwZGdDVFlPNm9acExHemNVcTB2bUs0Nk9HVlMvaVgzcTA1TUlDb2dn?=
 =?utf-8?B?N0xWTHdMY2ZoZlpESEFKMXBhWjN1YjVLM2JIZ0s1dlUveDMrZThETFgzcGk2?=
 =?utf-8?B?K0d3dkx5QmUrandHU0NCSmxTa3BWbG9ZS1RRSU1jTHZwWHVmMVVHaUFRRUtP?=
 =?utf-8?B?Z3pJMEtFL3UzUU9Nb0N4S0NSNFNkbmRQcFFJdUxkS2JuczZ5RlpsbkdDdUlE?=
 =?utf-8?B?NzVqV1NKUGdacVZnRmx6OWVhZU5OeklFTHBhY3FDUDdyanJvMjRmSzBrVkpx?=
 =?utf-8?B?amVnVmx0RktoanV3NXYvSWl4dlczLzdkcnU2NEhNbEtLTkNUSndiaHhEZUky?=
 =?utf-8?B?RDFmVUM2aVAwNUtZb2t1WnNSQWpkOU1SNVZBaUNFREdqdGp6QmNUY2JKYkZu?=
 =?utf-8?B?TW4yMndiTk5IR2VMNjZ3N3N1SDI3cHZLcGs3dzk5dmJielZLZk0yYlRQeVQ5?=
 =?utf-8?B?dGVDRlY5Y0l0aG53NzUrWjRmUkxuTHJhM3c4Yi81VkllTU9Lc0t3akNscVR1?=
 =?utf-8?B?Q2Fua1BOeVk0M25kVUdqR3pGZ0lUdy9rTlYyQ2VNbEcxSFlZc05QZHVVQlRn?=
 =?utf-8?B?TVowdDRSRGtQNENUSHYxTGowY1dvV0pBY0dPUllRZllla0k0NktiajVKeUww?=
 =?utf-8?B?eWsxemFZaDJacjVCeTAyU05SMGRrWTBrTUxWU0IvLzRkK3BqNzNadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68eaac9-7c63-424a-8389-08dedb8a856a
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:15:12.4429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPdnmM/Eecksx97KjpsMhttnpM38JQwmA9C9jaAzwvnw3psEJfmRO/e5Yzwos7DcDBc+QDcSAXlQIh9INU22Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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


On 2026-07-01 00:06, Zhu Lingshan wrote:
> Current kfd debugfs interfaces only expose pasid
> of the primary process, this commit exposes
> pasid of secondary contexts by debugfs
>
> Just like entries under sysfs,
> the secondary contexts are named as
> context_<id> under its primary kfd process.
>
> The layout:
> /sys/kernel/debug/kfd/proc# tree
> .
> └── 5802
>      ├── context_0
>      │   ├── pasid_1025
>      │   └── pasid_63266
>      ├── context_1
>      │   ├── pasid_1025
>      │   └── pasid_63266
>      ├── pasid_1025
>      └── pasid_63266
>
> Another fix is, kfd_debugfs_add_process may fail,
> this commit change it to return a meaningful
> value other than void
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   5 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 113 +++++++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |   5 +-
>   4 files changed, 104 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ab9e53dc8deb..2635218188cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3303,6 +3303,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
>   	}
>   
>   	filep->private_data = process;
> +	ret = kfd_debugfs_add_process(process);
> +	if (ret)
> +		pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
> +			ret);
> +
>   	mutex_unlock(&kfd_processes_mutex);
>   
>   	ret = kfd_create_process_sysfs(process);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 9bde2c64540f..02673f01b448 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -33,6 +33,7 @@ static struct list_head procs;
>   struct debugfs_proc_entry {
>   	struct list_head list;
>   	struct dentry *proc_dentry;
> +	struct kfd_process *process;
>   	pid_t pid;
>   };
>   
> @@ -140,34 +141,97 @@ static const struct file_operations kfd_debugfs_pasid_fops = {
>   	.read = kfd_debugfs_pasid_read,
>   };
>   
> -void kfd_debugfs_add_process(struct kfd_process *p)
> +/* This helper locates the debugfs entry of a kfd process */
> +static struct debugfs_proc_entry *kfd_debugfs_find_process_entry(struct kfd_process *p)
>   {
> +	struct debugfs_proc_entry *entry;
> +
> +	list_for_each_entry(entry, &procs, list) {
> +		if (entry->process == p)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* This helper creates pasid file of a kfd process under debugfs */
> +static void kfd_debugfs_create_pasid_files(struct kfd_process *p,
> +					   struct dentry *dir)
> +{
> +	char name[MAX_DEBUGFS_FILENAME_LEN];
> +	struct kfd_process_device *pdd;
>   	int i;
> +
> +	/* create pasid file for each GPU */
> +	for (i = 0; i < p->n_pdds; i++) {
> +		pdd = p->pdds[i];
> +		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "pasid_%u", pdd->dev->id);
> +		debugfs_create_file((const char *)name, S_IFREG | 0444,
> +				    dir, pdd, &kfd_debugfs_pasid_fops);
> +	}
> +}
> +
> +int kfd_debugfs_add_process(struct kfd_process *p)
> +{
> +	struct debugfs_proc_entry *primary_entry;
>   	char name[MAX_DEBUGFS_FILENAME_LEN];
> +	struct kfd_process *primary_process;
>   	struct debugfs_proc_entry *entry;
> +	int ret;
>   
>   	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>   	if (!entry)
> -		return;
> +		return -ENOMEM;
>   
> -	list_add(&entry->list, &procs);
> +	entry->process = p;
>   	entry->pid = p->lead_thread->pid;
> -	snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
> -		 (int)entry->pid);
> -	entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
>   
> -	/* Create debugfs files for each GPU:
> -	 * - proc/<pid>/pasid_<gpuid>
> -	 */
> -	for (i = 0; i < p->n_pdds; i++) {
> -		struct kfd_process_device *pdd = p->pdds[i];
> +	if (p->context_id == KFD_CONTEXT_ID_PRIMARY) {
> +		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
> +			 (int)entry->pid);
> +		entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
> +	} else {
> +		primary_process = kfd_lookup_process_by_mm(p->lead_thread->mm);
> +		if (!primary_process) {
> +			ret = -ESRCH;
> +			goto err_free_entry;
> +		}
>   
> -		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "pasid_%u",
> -			 pdd->dev->id);
> -		debugfs_create_file((const char *)name, S_IFREG | 0444,
> -				    entry->proc_dentry, pdd,
> -				    &kfd_debugfs_pasid_fops);
> +		primary_entry = kfd_debugfs_find_process_entry(primary_process);
> +		kfd_unref_process(primary_process);
> +		if (!primary_entry) {
> +			pr_warn("Failed to find the primary debugfs entry for pid %d\n",
> +				entry->pid);
> +			ret = -ENOENT;
> +			goto err_free_entry;
> +		}
> +
> +		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "context_%u",
> +			 p->context_id);
> +		entry->proc_dentry = debugfs_create_dir(name,
> +							primary_entry->proc_dentry);
>   	}
> +	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
> +		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
> +		goto err_free_entry;
> +	}
> +
> +	list_add(&entry->list, &procs);
> +	kfd_debugfs_create_pasid_files(p, entry->proc_dentry);
> +
> +	return 0;
> +
> +err_free_entry:
> +	kfree(entry);
> +	return ret;
> +}
> +
> +/* This helper removes a debugfs entry and its sub-entries */
> +static void kfd_debugfs_remove_entry(struct debugfs_proc_entry *entry)
> +{
> +	debugfs_remove(entry->proc_dentry);
> +	list_del(&entry->list);
> +	kfree(entry);
>   }
>   
>   void kfd_debugfs_remove_process(struct kfd_process *p)
> @@ -175,13 +239,22 @@ void kfd_debugfs_remove_process(struct kfd_process *p)
>   	struct debugfs_proc_entry *entry, *next;
>   
>   	mutex_lock(&kfd_processes_mutex);
> +	if (p->context_id == KFD_CONTEXT_ID_PRIMARY) {
> +		/* remove entries of secondary contexts */
> +		list_for_each_entry_safe(entry, next, &procs, list) {
> +			if (entry->pid != p->lead_thread->pid || entry->process == p)
> +				continue;
> +
> +			kfd_debugfs_remove_entry(entry);
> +		}
> +	}
> +
>   	list_for_each_entry_safe(entry, next, &procs, list) {
> -		if (entry->pid != p->lead_thread->pid)
> +		if (entry->process != p)
>   			continue;
>   
> -		debugfs_remove_recursive(entry->proc_dentry);
> -		list_del(&entry->list);
> -		kfree(entry);
> +		kfd_debugfs_remove_entry(entry);
>   	}
> +
>   	mutex_unlock(&kfd_processes_mutex);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ad4897f094a2..365c6289b05d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1649,14 +1649,14 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev);
>   int pm_debugfs_hang_hws(struct packet_manager *pm);
>   int dqm_debugfs_hang_hws(struct device_queue_manager *dqm);
>   
> -void kfd_debugfs_add_process(struct kfd_process *p);
> +int kfd_debugfs_add_process(struct kfd_process *p);
>   void kfd_debugfs_remove_process(struct kfd_process *p);
>   
>   #else
>   
>   static inline void kfd_debugfs_init(void) {}
>   static inline void kfd_debugfs_fini(void) {}
> -static inline void kfd_debugfs_add_process(struct kfd_process *p) {}
> +static inline int kfd_debugfs_add_process(struct kfd_process *p) { return 0; }
>   static inline void kfd_debugfs_remove_process(struct kfd_process *p) {}
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8e701dcda8ec..a87878aee0f1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1002,7 +1002,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		if (ret)
>   			pr_warn("Failed to create sysfs entry for the kfd_process");
>   
> -		kfd_debugfs_add_process(process);
> +		ret = kfd_debugfs_add_process(process);
> +		if (ret)
> +			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
> +				ret);
>   
>   		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>
