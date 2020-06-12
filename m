Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C161C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 22:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB21A206DC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 22:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aFj6Pt6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB21A206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860FF6E1FB;
	Fri, 12 Jun 2020 22:03:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C716E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 22:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYrlb1vjDRhtpOHKp80Ujsn+w8Z3dDLoTL3alYq59zVyA9BTfW/7w9RSZgo1FUfKyF6MV2NNq1LvSzjPfRGFEu2mL4mx73n4rTvbLoRSulAqenhJZvBwDI+gEA1xjRVG8o6hql8JJoNzhGN0bPg9LPZghET+SLZUQ5a+rgDIx5rXc/H7puwenylzexRtkvTuLEqg+bYTR6x/uaJwD3xD/7D/ionL/yuBveNvlZz2T0474G6dFfOuYg2QUicx4h23so6JMWMvswDsU3oxoFAC2eKPfQ/GYHSZXbJJpHstUAl53hpjdEQbkQu4JhQeC+p/aazPnqqeCT6m0BWdp4nSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgMNQ+4HlrLgyJFeSWzqbBKdY5/88+0JbJdKRx6CDQA=;
 b=j7c+ByI7hKNHNXsUTt+RlLkdrnOfAp2dCRUvq4GFUo9+nzGI8UpgYS8v0Tdv7OTPgY+wSlCFSpPMhyR+J8CaD+o4OzNKYBY8302D0F9jXbou0tv738PEDPFIHTPDydoh9Hh/tmnOPzyHzX8Jtg+XHoYNlv4FXfsj4wPt5ZL28DsJtpC4uUk7s1NP/BOtzuUJhQ53iQPTQBukDEjrxNvDD659CJ9STD0AOQLcm5SsWAr4T9B6voVVqQy2Fpp4s/5SmPl6RnwwKC38qrhtVAycgjcYn3sk6doGTF00De5xDopki0FwICgYi4DJk6IQghfIXPvqA7nmtMwDEGd67/Hpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgMNQ+4HlrLgyJFeSWzqbBKdY5/88+0JbJdKRx6CDQA=;
 b=aFj6Pt6rQZeWd5gV2W3RvRqs5kFb3T02FZSnaQvFGDRAyzI3t5Ikj9r83wxzEb35lrt1A+9gWS1As7jw8VWDNsKnjSgFBF5SRijHKRbpGIBdZDKkf0Ex4gmDN0RL/tfGxoUgobUNDXyzIn9GlPe7tick5yKiIcNLn1ejmoSgH0Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.22; Fri, 12 Jun 2020 22:03:04 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::201f:4349:f4ba:abf9]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::201f:4349:f4ba:abf9%7]) with mapi id 15.20.3088.019; Fri, 12 Jun 2020
 22:03:04 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Add eviction debug messages
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200612033422.5682-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <98a97cf1-51d4-fade-95c3-6ed649a53ccf@amd.com>
Date: Fri, 12 Jun 2020 18:03:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200612033422.5682-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.22 via Frontend Transport; Fri, 12 Jun 2020 22:03:03 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95b007b0-00e7-4117-3a7a-08d80f1c615e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3211395D7B5D5C8124D02263E6810@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf0WTpXWmqyAAW8Roygn0KMHnO1+MZcRKdSClysSMljhXp2EUJ5CjGD7LHkb5rk4S3JmYlF3UBq0+xcd5aGsaySuUMC43VujJcUQx3UTjQQVdTm8Gworhw7chKIvOCzRjHbj7LYxAmK27P5rgY1Z/3aCKGTYzBTlZK/OFFivcWwcggUKWvgKsY4ksysolhpXMTPqNa3kpqS0h90hwOHirgPwto9SlkB5E5ZhJHQfjjnkb8vrspU9MOkJivY7s3W8p+J+IqDMOOpD3tr/Z/MyVP/h7Fq54SA3gObLUhog/TxzTSEjRUgpleBCkNsT1RTcgYNmYLvtZxDYRIITZSHJlYazAJGUpxieLIRyxxPyb6IZSdSkTd9yqabRXXlaKmfY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(31686004)(5660300002)(66556008)(2906002)(66476007)(66946007)(31696002)(6486002)(16526019)(16576012)(478600001)(316002)(186003)(36756003)(8936002)(8676002)(4326008)(2616005)(26005)(83380400001)(956004)(53546011)(15650500001)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wk8Y4cwPcj+98UqJ6XSq9hT9gEn+7/5nmK3dSq4UjWzAjTam9uN1s1GWnDYUfxkvrZ3zXOnVAiTiMH7+4OXM7ycut6tCu2t02pkBan4DI661YK+Sh+4Oq8cRP3ihe2ZF24EZkkq28nZJF+zwFDWDaY+eQ1nsPMZz9G5sHhUO+YKVtH2NH7fC6i/shFEE8J3lpptx41YPKCHIjJcuQiyWoHwyJ01Wlt+7xe5f8/MVyFHe1F8+8eX68k58Zfzj/gMD7HSjRA0roTkQAsHuYrw0qGoOiSo+mhgvzQe62NB5Q82vSnTHSfm8B/zwaZlaJwkpPAyJl7AJvuBz8JJ3afy22qBDU9DVYRwg/SCsc1WfE6ELw0+Yy2VOUW9omwxOGH1nqWo6dKGoEDsuCFeL5oAaXwQPdaqSqRhXGc0ezVfEt7s2kFfLtqgd1qW8a/v65aHXGSrRXMlIxwMvd4Mw2PSSIamPyqiryojaxEerXfkapkiWz8ml7vAzxTbJVtfOewcR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b007b0-00e7-4117-3a7a-08d80f1c615e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 22:03:04.4888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emqhI0xSzxNYUBVNgBXxf4Bjfynxri75mQjElIsHQ6jm24kc4g1J6sOgymsds4BA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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
Cc: gang.ba@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's good idea, better to add same print in system memory eviction path 
amdgpu_amdkfd_evict_userptr.

Use WARN_ONCE to avoid duplicate messages.

Regards,

Philip


On 2020-06-11 11:34 p.m., Felix Kuehling wrote:
> Use WARN to print messages with backtrace when evictions are triggered.
> This can help determine the root cause of evictions and help spot driver
> bugs triggering evictions unintentionally, or help with performance tuning
> by avoiding conditions that cause evictions in a specific workload.
>
> The messages are controlled by a new module parameter that can be changed
> at runtime:
>
>    echo Y > /sys/module/amdgpu/parameters/debug_evictions
>    echo N > /sys/module/amdgpu/parameters/debug_evictions
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 5 +++++
>   5 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 10ae92e835f6..6c7dd0a707c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -186,8 +186,10 @@ extern int amdgpu_noretry;
>   extern int amdgpu_force_asic_type;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
> +extern bool debug_evictions;
>   #else
>   static const int sched_policy = KFD_SCHED_POLICY_HWS;
> +static const bool debug_evictions; /* = false */
>   #endif
>   
>   extern int amdgpu_tmz;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d4d7cca1cc72..fdf350d5e7b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -705,6 +705,14 @@ MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false =
>   int queue_preemption_timeout_ms = 9000;
>   module_param(queue_preemption_timeout_ms, int, 0644);
>   MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1 = Minimum, 9000 = default)");
> +
> +/**
> + * DOC: debug_evictions(bool)
> + * Enable extra debug messages to help determine the cause of evictions
> + */
> +bool debug_evictions;
> +module_param(debug_evictions, bool, 0644);
> +MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
>   #endif
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index b87ca171986a..072f0e1185a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -275,6 +275,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>   			continue;
>   		}
>   
> +		WARN(debug_evictions && fence_owner == AMDGPU_FENCE_OWNER_KFD,
> +		     "Adding eviction fence to sync obj");
>   		r = amdgpu_sync_fence(sync, f, false);
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 22348cebaf36..80393e0583bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -942,6 +942,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
>   	if (!p)
>   		return -ESRCH;
>   
> +	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>   	r = kfd_process_evict_queues(p);
>   
>   	kfd_unref_process(p);
> @@ -1009,6 +1010,8 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>   	/* During process initialization eviction_work.dwork is initialized
>   	 * to kfd_evict_bo_worker
>   	 */
> +	WARN(debug_evictions, "Scheduling eviction of pid %d in %ld jiffies",
> +	     p->lead_thread->pid, delay_jiffies);
>   	schedule_delayed_work(&p->eviction_work, delay_jiffies);
>   out:
>   	kfd_unref_process(p);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 173d58b2d81f..51ba2020732e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -177,6 +177,11 @@ extern bool hws_gws_support;
>    */
>   extern int queue_preemption_timeout_ms;
>   
> +/*
> + * Enable eviction debug messages
> + */
> +extern bool debug_evictions;
> +
>   enum cache_policy {
>   	cache_policy_coherent,
>   	cache_policy_noncoherent
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
