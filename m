Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C43606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fKUd7Csa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE7110FEAF;
	Wed, 21 Oct 2026 15:46:19 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CD010FEAF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 15:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTEeBUZNxpG+UbnlXsfLgWXPPFDu3K2vp0KIpaeMgBH2sempnsERSxpFPG9Xml0EWu5BYlY2Lg2JC0HS6NtFwivek6BO95MW3jS/l8aYOdfG60bGrvOtYbwu/hpNlVLnY7p3ksI/G3gIzMnn5nDIHuKp0OSZOgMK676HHkWdOtb6tif8BNegHkKRWXPOOKo5wjsWdZDvZ3t0Uv7U/V1xFclbKTrCRj8so4eP3pi132JHFcQEMUmtunPeBmNkeDcR3fvJt7l/IrHiOJT9BnfAI5j7UchNazcmgSjeUn+zXlEPuABHhmByC48koY9pQV1X7waOFoQfxRiQuyvJeFGrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pJVTZ/qiMZDGPlVZkbBUc/wMtYps2zgUplIEIAfFvY=;
 b=tvKiQ8WZrKWBd54vozdOlqx7nqQnD6vn/clgBtDad0SGFbwcHaeDLscGjUWIvbfqXgU7f7sYxYZNDegRdbHX8IUJli2e204VaIsGK1wmhXitAhOxFyhIoShIvjW7lVj9n3UbvtkzuT6DND3QPGS4TTi7Z/00qi+WBuxmUZ1ClcdtqNM9blkh4mFuHjR18WsUIYj8V045LjOHJB0nZFVcFVYMeGMakK+WXV9+0HaPr7Nb5NRVh0pHuuApZPoGBks2IXZatkeU+6NtIzQ7UrZAyn+mMh0DIfrENvzZ5Cu69KJm85ET/CDbhBN1pcSC5V8VqjqQz7LHTA489Ik/mEyz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pJVTZ/qiMZDGPlVZkbBUc/wMtYps2zgUplIEIAfFvY=;
 b=fKUd7CsagtDtQSBnfKW24f9NFnTnzKqLAu+E5QWqUi+4XYNiY3tPwhU93PtzZ7WmQS0XqO9RB39sUtYTJKZWzoNkTMMRZ1ILgvI6Sg8BMFZc53SIGlKSnLYWfPuLSa/AJgg/P7D6ebhkjrGpT07zWKFLgXWJOWP/rLVLwk9NJMQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS3PR12MB460943.namprd12.prod.outlook.com
 (2603:10b6:8:43d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:46:09 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:46:08 +0000
Message-ID: <7f44db02-094c-42db-b278-0b70600df4df@amd.com>
Date: Wed, 21 Oct 2026 11:46:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: send SMI process and VM fault events only
 to allowed clients
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Harish.Kasiviswanathan@amd.com, Amber.Lin@amd.com
References: <20261021083027.3460995-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261021083027.3460995-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::14) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS3PR12MB460943:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e74c25-1b99-40ed-5802-08df2f8a6c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|5023799004|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: TX6qs8enTRk71BxIUndKXQS6bQbfT6HoXgTczHTBWDeiuQexUPOP9jzsEX/0/QX7r6mXg5ISiZgV+pzEvDYrp3RH8AO0L2Iwu5WLUmjFTF09z36OwMpC+QZxlf5AjtMzQ0aEsmwGMp80d/MKR1Sh+T2Gr1/KG7tUNnfX9hpuKG3hgzxNnu3sPas0oy9MJYlfX2UvXkmEiXlUVGisslwUwe3FrDrYfu+94ycTnrbYA2aX6NYy5+Vcola7O7CYSSeZxpuMpFnwTmHjgIWq8/xCPqivQUnTshlVb0Iysj1IQwpFkQaKfQIEvVbafeKK9Ry/Nvk15stYvNtjFIAPDfF55Uiov7gOwD7FhbbUIsqgn3Sn8DjNBNJ+dSmgAZyRT4jDCMswR8weTFhxJLoO2rUgSyqYjlqPDm4PtbPwkaBWg8OsLiPc+zE6sYjRKgbrbfTOoXoOjk1Nov38DyR29KXfjEYCn5uOkFFGzVGLkvAvndAYqd5N9OBwWto2uREC2mqBsWqT6mCVV5Y7DFnGncTjuoFvFQcMOx5u6NKvcVzCafc2OF/ZONKx28BvCehVyx/811MQ6ul4qpP0xb6AEK517uFLmagfJfF27EDX0ohQcQiWRkMSvVyV7V9PHLLWEfKf56dBfOUBAgDNyJik+MW1G84Y7wzjWD8hQbFthvOZAvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdtSmVmY29NVkhoU1JBYXZ4cVZQMzQvS1dTbDZNdVZOa25ZV3FVdmxpejFG?=
 =?utf-8?B?dm9NZ0FOQ21ZdmJtSjRCSW0vaGtYdy9ZL3hGbE1mMS9vYlcwVlNtWXArVTJB?=
 =?utf-8?B?bm5MQ2MvYXQ1NndZdWZCdXcvZndVOWtlZzZTS051QXl3YlFjc2FlcXdROW5T?=
 =?utf-8?B?RVJvaEw5UFZpcmR2U3ppN29UQ2FyMHM4NnNHa1NNTEpGSVFJdkh5OFBWZGRt?=
 =?utf-8?B?UTFIMzNvbUM2Q21YOWplMWRUTTFCb3MxVSs5emlxOU9ILzVFY1NHMFRlQmR1?=
 =?utf-8?B?Vk1QRldsVlpienVvSjF4K3J6dWpQU05XdXpWM3RLK29HSU9ZV296QTEwbUZw?=
 =?utf-8?B?ZHJ3QnM1U3dtbHRjeXNNMnZ3aStlQmF6bVY1cHlPV256TGM1ZEpycW5NOFZC?=
 =?utf-8?B?YjNMYjdxcWVLMnBhcDNSUGFiY2x3TWF3ZlBzNVdpaWVJNm56cFhFOW53T0x0?=
 =?utf-8?B?WVJUOXRiWEw1cXl5VUdLSzE1L0JvT3pRb3R0VGljV0ZoY0FFT05FRkZqL3k4?=
 =?utf-8?B?VVNkaXA2L0lyYmRhTHRuNnRmZUExMlBia3M2MlNGOGgrZ2dxSXNBcmNYN1Jo?=
 =?utf-8?B?d0p6QWYzejJid29Janh1V2ltTWw1dVNTM2ZGNG1YNkNzRlA4TTQwOEVyUTY3?=
 =?utf-8?B?SG9WM3ZMM1JwZElNeHNCOFVOdDVoWnZJalJWV3J0V1hPRzB3Lzg3aDhkbHYr?=
 =?utf-8?B?NUo1M2R4UVU0ZFRhRitiVWJjeXBKWjV2dnFIanowYXFaSEVJMmxEVmsxTlN4?=
 =?utf-8?B?Q3RWcjU0TFVtZi9LYkFNbC8yZTlZaFB3azZTSkNkOUhsWnNId2s5S1d2M3BM?=
 =?utf-8?B?cXNIa0lWeGFBSmpkeEFGMkdFb1VSMHlSQnVuUU1lV1JDUHFWRm9kZEQrb242?=
 =?utf-8?B?aXVWejgrMTFlZDRrTW53dlJsSFc4OG9EZllwQkhjT2J1UGRFQ1ZPclliNjFh?=
 =?utf-8?B?ZUtuYjlaclJ3YkVVM2VRUnhpTlljSDhGUlVKUFVWNFh6T1BSZjU4UWlaZFBB?=
 =?utf-8?B?TEs0bVcxL3VHdGhNMittejFmcHBUakhoUEZ1ZkltdG9MallMdEgzU0ovRm44?=
 =?utf-8?B?cUxEVUtueXU1cmNQRkQzQnV1d01YOFVSM3NoRk1YaHEzN2ZFYmFLK2NMWkpP?=
 =?utf-8?B?ZUFha2pwNHQ4SGZ2QlRtejh0bjlmUGQxeXBiZHRRQjFvNjlHdUNIOE0zZlAw?=
 =?utf-8?B?ckFRdmg0d2ZIVjVSMlBFL2ZYUWd5eXZ4ZjdDTFY2ZUd3cytpd3NSdmVuaVha?=
 =?utf-8?B?Z2hVWUhWUWlvdDM3b2pxMElHZ24wNk9PRHh6N3hWeHh0QkZIbHVrTXFBNkt3?=
 =?utf-8?B?OHhOa3F2cmhZdW1SdFp1YTZOYzd4NEdVR2U4ZDgraHJOZnp0NlcvYVZXbHR6?=
 =?utf-8?B?aDVQMnN6aTZ0MTlKd1JTV1Q4dWFjMXdVd3JjUmpEcDVxNFJqMitUalJCK3lS?=
 =?utf-8?B?dG5CbWNBRy9BaklyMnMzTHVqUjBRWXFPWDQ0S09laXdaVG8vOHlxemRiNDlL?=
 =?utf-8?B?SXE1M3dWSlF1VEJYZTB1b3NoYi8wR1hWSmV6REQ0cHl0SlBadWFkenNINVIy?=
 =?utf-8?B?ajM0WGc1ZWxMTGJTcTA2NjlkbFloMlpYZC93YXQvRzJERDNGVWxkaUJJZVFo?=
 =?utf-8?B?K2xXWWxmbVNPNEo3OU8ra3B2elRSSVNSZXhIMjg3MVNod242WEF4cTdsYWU1?=
 =?utf-8?B?SGVmbXowU3NJUGdsQjI4OHQrWXVCNkpUcHdnUDZ4ZXhnY3E4QzJSNEg1amhE?=
 =?utf-8?B?RVNwT3o5dnpPSVdRS0VoMExnYWtJdHpZRUtwY1dvZ1ZSWDRqdHFRN1pQWmJO?=
 =?utf-8?B?Q09YUjdWMDFOK2hldFJKS3hWZnZLWnFIbms2Tkp5UVU0OG5pQVBqZTE1VWdv?=
 =?utf-8?B?azVGVDkvTFI4SzgycUZpVXNwcndIN1k2T3hDTjZGSDB2dExnZzV4c0pWd0tm?=
 =?utf-8?B?Mm9qWWpoYlRTcEhnVVcwWEp1c0Y5cjROU0VtQytTYWh5a3pVWEp2ZlZvN0tB?=
 =?utf-8?B?cFRQajQ3MjI1VG43ZXZ5c2JSY1dDUUdLaC9jeWdLTFpYNmRCMWkxY3F5eDMw?=
 =?utf-8?B?dG42K1FVeG5YK0I4NGxiTXhydXVOeEtnQm1RRjJkLzJDS016WE50Szk5YXFD?=
 =?utf-8?B?Y3A4NFdHRjR3a05SdUdUZnZ5c0RRV1NqanV1amsvVmdZb0NMZGhZNlNYcGx2?=
 =?utf-8?B?Y01vQjJtZmg4d2VmRFFGZmU3RmxsdG5GbkdNc3M0R0IycUlBWW56d1pZb2Ex?=
 =?utf-8?B?Ynh0NmhkSzE4UEx1a2dUNENYYjVmVi8yR25WYjdjZ0IzZ1JkME5JVW8rSnE0?=
 =?utf-8?B?VEFiT01XcTBnOS80c0E5VzJCYzhzc3lxWG50dW02WFdCS0d5NGRSUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e74c25-1b99-40ed-5802-08df2f8a6c77
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:46:08.3006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCYEpm3anme1HQ7mSfhY3ydlHAvVP5hC3uzsGbaiFv2vgma2rh+2LLQFdu6gWg9TeRmBIh/ScBLP8rH8ot5q3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB460943
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21 04:28, Jesse Zhang wrote:
> Commit a403d3f65c79 ("drm/amdkfd: fix SMI event cross-process
> information leak") made the VMFAULT and PROCESS_START/END SMI events
> carry the pid of the process they are about, so that
> kfd_smi_ev_enabled() only passes them to clients of that process and to
> privileged clients. Commit fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID
> reporting for containers") then switched kfd_smi_event_add() to take a
> task and passed NULL for these events, i.e. pid 0, which every client
> receives again.
>
> On navi31, an unprivileged SMI client (uid 1000) subscribed to
> PROCESS_START/END sees root running rocminfo:
>
>    event: c 223a9 rocminfo
>    event: d 223a9 rocminfo
>
> The same commit also made the filter compare PIDs of different
> namespaces: the client stores its PID in its own namespace and events
> use the PID of the task in the task's namespace, so a client that is
> PID 1 in one container receives the events of PID 1 in another. And an
> exited task has no PID in its namespace anymore, which gives pid 0 for
> PROCESS_END.
>
> Match clients by global TGID, which is unique and stays valid after the
> task exited, and keep showing the namespace PID in the event text. Pass
> the TGID of the process for the process and VM fault events again. With
> this the unprivileged client gets nothing, a root client still gets both
> events, and an unprivileged client that is PID 1 in its own PID
> namespace no longer gets the events of rocminfo running as PID 1 in
> another one.
>
> v2: rename the pid of the clients and of the filter to tgid (Felix)
>
> Fixes: fd406e58b9e6 ("drm/amdkfd: Fix SMI event PID reporting for containers")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 60 ++++++++++++---------
>   1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 6a7b4d959541..c87370a9f5f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -40,7 +40,7 @@ struct kfd_smi_client {
>   	struct kfd_node *dev;
>   	spinlock_t lock;
>   	struct rcu_head rcu;
> -	pid_t pid;
> +	pid_t tgid;
>   	bool suser;
>   };
>   
> @@ -160,18 +160,18 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>   	return 0;
>   }
>   
> -static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
> +static bool kfd_smi_ev_enabled(pid_t tgid, struct kfd_smi_client *client,
>   			       unsigned int event)
>   {
>   	uint64_t events = READ_ONCE(client->events);
>   
> -	if (pid && client->pid != pid && !client->suser)
> +	if (tgid && client->tgid != tgid && !client->suser)
>   		return false;
>   
>   	return events & KFD_SMI_EVENT_MASK_FROM_INDEX(event);
>   }
>   
> -static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
> +static void add_event_to_kfifo(pid_t tgid, struct kfd_node *dev,
>   			       unsigned int smi_event, char *event_msg, int len)
>   {
>   	struct kfd_smi_client *client;
> @@ -179,7 +179,7 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
>   	rcu_read_lock();
>   
>   	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
> -		if (!kfd_smi_ev_enabled(pid, client, smi_event))
> +		if (!kfd_smi_ev_enabled(tgid, client, smi_event))
>   			continue;
>   		spin_lock(&client->lock);
>   		if (kfifo_avail(&client->fifo) >= len) {
> @@ -210,27 +210,33 @@ static inline pid_t kfd_smi_task_to_pid(struct task_struct *task)
>   	return task ? task_tgid_nr_ns(task, task_active_pid_ns(task)) : 0;
>   }
>   
> +/*
> + * Clients are matched by global TGID, which is unique across PID namespaces
> + * and stays valid after the task exited. Events show kfd_smi_task_to_pid().
> + */
> +static inline pid_t kfd_smi_task_tgid(struct task_struct *task)
> +{
> +	return task ? task_tgid_nr(task) : 0;
> +}
> +
>   __printf(4, 5)
> -static void kfd_smi_event_add(struct task_struct *task, struct kfd_node *dev,
> +static void kfd_smi_event_add(pid_t tgid, struct kfd_node *dev,
>   			      unsigned int event, char *fmt, ...)
>   {
>   	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
>   	int len;
>   	va_list args;
> -	pid_t pid;
>   
>   	if (list_empty(&dev->smi_clients))
>   		return;
>   
> -	pid = kfd_smi_task_to_pid(task);
> -
>   	len = scnprintf(fifo_in, sizeof(fifo_in), "%x ", event);
>   
>   	va_start(args, fmt);
>   	len += vscnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
>   	va_end(args);
>   
> -	add_event_to_kfifo(pid, dev, event, fifo_in, len);
> +	add_event_to_kfifo(tgid, dev, event, fifo_in, len);
>   }
>   
>   void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> @@ -252,14 +258,14 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
>   		amdgpu_reset_get_desc(reset_context, reset_cause,
>   				      sizeof(reset_cause));
>   
> -	kfd_smi_event_add(NULL, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
> +	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
>   			  dev->reset_seq_num, reset_cause));
>   }
>   
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   					     uint64_t throttle_bitmask)
>   {
> -	kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
>   			  KFD_EVENT_FMT_THERMAL_THROTTLING(
>   			  throttle_bitmask,
>   			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
> @@ -271,10 +277,14 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   
>   	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>   	if (task_info) {
> -		/* Report VM faults from user applications, not retry from kernel */
> +		/*
> +		 * Report VM faults from user applications, not retry from
> +		 * kernel, and only to clients allowed to see that process.
> +		 */
>   		if (task_info->task.pid)
> -			kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
> -					  task_info->task.pid, task_info->task.comm));
> +			kfd_smi_event_add(task_info->tgid, dev, KFD_SMI_EVENT_VMFAULT,
> +					  KFD_EVENT_FMT_VMFAULT(task_info->task.pid,
> +								task_info->task.comm));
>   		amdgpu_vm_put_task_info(task_info);
>   	}
>   }
> @@ -283,7 +293,7 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *t
>   				    unsigned long address, bool write_fault,
>   				    ktime_t ts)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_START,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_PAGE_FAULT_START,
>   			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),
>   			  kfd_smi_task_to_pid(task), address, node->id,
>   			  write_fault ? 'W' : 'R'));
> @@ -292,7 +302,7 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_struct *t
>   void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struct *task,
>   				  unsigned long address, bool migration)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_END,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_PAGE_FAULT_END,
>   			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), address, node->id,
>   			  migration ? 'M' : 'U'));
> @@ -304,7 +314,7 @@ void kfd_smi_event_migration_start(struct kfd_node *node, struct task_struct *ta
>   				   uint32_t prefetch_loc, uint32_t preferred_loc,
>   				   uint32_t trigger)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_START,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_MIGRATE_START,
>   			  KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), start, end - start, from,
>   			  to, prefetch_loc, preferred_loc, trigger));
> @@ -315,7 +325,7 @@ void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task
>   				 uint32_t from, uint32_t to, uint32_t trigger,
>   				 int error_code)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_END,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_MIGRATE_END,
>   			  KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), start, end - start, from,
>   			  to, trigger, error_code));
> @@ -324,14 +334,14 @@ void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct *task
>   void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struct *task,
>   				  uint32_t trigger)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_EVICTION,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_QUEUE_EVICTION,
>   			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), node->id, trigger));
>   }
>   
>   void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct *task)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_RESTORE,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_QUEUE_RESTORE,
>   			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), node->id, '0'));
>   }
> @@ -348,7 +358,7 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> -		kfd_smi_event_add(p->lead_thread, pdd->dev,
> +		kfd_smi_event_add(kfd_smi_task_tgid(p->lead_thread), pdd->dev,
>   				  KFD_SMI_EVENT_QUEUE_RESTORE,
>   				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
>   				  kfd_smi_task_to_pid(p->lead_thread),
> @@ -361,7 +371,7 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struct *tas
>   				  unsigned long address, unsigned long last,
>   				  uint32_t trigger)
>   {
> -	kfd_smi_event_add(task, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
> +	kfd_smi_event_add(kfd_smi_task_tgid(task), node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
>   			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
>   			  kfd_smi_task_to_pid(task), address,
>   			  last - address + 1, node->id, trigger));
> @@ -379,7 +389,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
>   	task_info = amdgpu_vm_get_task_info_vm(avm);
>   
>   	if (task_info) {
> -		kfd_smi_event_add(NULL, pdd->dev,
> +		kfd_smi_event_add(kfd_smi_task_tgid(pdd->process->lead_thread), pdd->dev,
>   				  start ? KFD_SMI_EVENT_PROCESS_START :
>   				  KFD_SMI_EVENT_PROCESS_END,
>   				  KFD_EVENT_FMT_PROCESS(task_info->task.pid,
> @@ -408,7 +418,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
>   	spin_lock_init(&client->lock);
>   	client->events = 0;
>   	client->dev = dev;
> -	client->pid = kfd_smi_task_to_pid(current);
> +	client->tgid = kfd_smi_task_tgid(current);
>   	client->suser = capable(CAP_SYS_ADMIN);
>   
>   	spin_lock(&dev->smi_lock);
