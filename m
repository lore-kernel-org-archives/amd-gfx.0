Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61129C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 18:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C295310E223;
	Thu,  9 Dec 2021 18:40:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9988A10E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 18:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO9UALlxOdUYgLBdEjqmmhfJuX9MdCkWhQ7x//A2Eos9+d92zJEptc16DW2pkbx0sneC061tgqSgU1E6e4rBrbZWXotzktcEJGkS/8uqtK8ddsIFFrSbCPRpLv7xGcIEzGoRbEVbrsHBo522qIH3EXUoA1yIy/6ad3zytxpPf50QarLnvv+846lffW4M2G2Dl48/qwDZq9Y3kcv4WPkJ1C4r6hEC+xtXQ57b4MV3U+tG0uaveccEmqm9sD84ZwsF4RL3nl2iZHuv/ASH9nNe1zQS9R8UwXKS5sndX0cDyMFDsOt7yYCJEQ/o3zaHTOyJxklRp7EKWBvOSq8hzDew6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmBHkTnJN/K6MvZfxCnwL5bYIa5qshTmvuvoOm5XKoM=;
 b=aoup0y4vGykhUEcf49uYGEqBjImjXi+nCgDNijdm2w1MPswIXNjqQw/xoFCWh8XhLqrj8BEpCwFyMmKidfcO0KkWGQtrVIJmcgEM+uk7Dqnl3RrYy+J2lo44MDyzydte3XneJu8c/Fi0VIprZlGZEeQjdawgLCTGhUJDvQb4AcHNhd3fqqOH7mqPt62jT3/M1ufhHog6c6GE9IFm7hxlBEb5csGz2+Gfq4/tTVbEY/OsLqnDsKvvGPNwM765to92Ic9qm1qlH8AKrRTGV5d9DrTFlgf3l2towgAVd0AnJHw6B9QAQlf2G9DGLDmHn8Ecm+xIfix9XgztVyjtHCuNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmBHkTnJN/K6MvZfxCnwL5bYIa5qshTmvuvoOm5XKoM=;
 b=x8IC2MJQfuRdj7Q2ZvqtgHQVpYFyIRPNxBe40ils7yBgS4NCccLZvubIJCBfvMLcrEQ1L/j111EPN9mXnScwJdUG/o6RUnWsAd68f/TozQ0aSvf46k3rSlq16juq2sHRuUkKKJLV7OrGpA/mH9ly1a3ngDbQ7EodmAhCTVSFXxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 18:40:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 18:40:22 +0000
Subject: Re: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes
 under /sys
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209074918.1555320-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
Date: Thu, 9 Dec 2021 13:40:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211209074918.1555320-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 18:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 619ebc4c-9503-45b4-4e3a-08d9bb435b59
X-MS-TrafficTypeDiagnostic: BN9PR12MB5193:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5193DD9079436CED640D6ACC92709@BN9PR12MB5193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzREFMwnKZ0+F9ZPXk4eI9+nRQksdeMtPoSXDz5tnvH2jV85owM8x8oYmVrWh17EGDXZv+qrKB02xp/BBjjYBbzCuCPLut5INMOZuOEoyYLpJnog7yxEzKQd8xAXRnrRWMwp806WN9Sgs/Zl0r1+jatuQHQOLstF/NYRQHkRE6ZHsaCeMo8V0U4Okg6hdqQ9Vdc7MmFhUXHdze402NsJ73XDG37qzCs+KtzA8ocggSO2M523GETUPziJFq6IG5GLLXzo/UgxxWirc/UHZ5AWcNy+QmaBSw11VlscoZcwjlL0cg6sUyOR0v658md43y/YQ+Xn1nWWuQigTxJbGAqKymv6SmNRM2TlihGIq3o1XlMMxT9gsvfwrVVPZ/+v723nv7oXyvfLMqRc1mq7idI4oU25XbLqyvcOB/e6xQFR94xE583QFNkHtgBXsTldS3ygZHuREk0xKqvltA+1l570tCa+stDOLXeFivsz+izkiFPq8nwnf9aXwKyxc7R+PAofzYUr7SIxtXlnvKXRL0/+3Rl0bYWNDhkFkzQaohRW2DkTAPTpIwOl2Q48zq0wl022qzu5od4W3EpI7//G4bzErZE8f2fXyTO27winvnJ6R/cDnPB17oVeT49YroC+Yt9d3IyOTDhde90/K+6ZvoX+Ndc1tx3y+codqED0fq4TontYxQRci2c6RGALjWXBWxw4+kuY8QxbO5mLLSDOak+gPfnZ20kyld6DvxftdhWsRLhrhtyuJMTX9Hi52mX71vG5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(36756003)(86362001)(31696002)(5660300002)(31686004)(2616005)(956004)(8936002)(44832011)(186003)(2906002)(26005)(8676002)(316002)(66946007)(66556008)(16576012)(66476007)(508600001)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZaejAxUzlDNGdrVXRJYzFySGVHZytxeFVtdTRKWkF2NHZCd0F1TGNKbXZK?=
 =?utf-8?B?cnoza1JMYUF0b0NPSnB6SjQ2dUh4L3FkWS8xYThUYmhsM05wRzZmTE1XQUxk?=
 =?utf-8?B?Q3ZDNCs3NDU1MzdaMVQrTmN5L1pJZnlGdGxEMEp4RWppOXppNzJicHZDaWRx?=
 =?utf-8?B?VUo5THVoalVMOUNBb2tJV1BGc0ZjMkF5R1ZVQ0ZEQnBkV3hGOTczLzZveFhV?=
 =?utf-8?B?SGdERlVtY0FwbCtoSmlnTC80bjh1S1FUZGRRa25ZbmpPT2ExejB1OWhzVzBn?=
 =?utf-8?B?bVdHWkJvcE1OYW04Z1lEWCt3L1NGM3JodWx3Q041djNWajcvN3dYSDlTMlZI?=
 =?utf-8?B?ZkxVdVlFVW1tN1puK2luanlsZWE1b1lUb01KMUNzZVI1WmVia1RzaHAxc1NG?=
 =?utf-8?B?RXlBdXdSNFNMVldxTGlDb2VWVDhSMHI1d01iNVFrNjVzd1psbXg4a055NVMw?=
 =?utf-8?B?a0NzUi9zRTRtMjVJT2gzUHVOV1JSNzNxWCtCSStlcS9yeThxUXF3VmJKdXpr?=
 =?utf-8?B?YnpWY3dnNUxtTis2dXlNTCtLUGV1SXk3bHhjNEkvUVFEa0JRbTFrdE9aTm1w?=
 =?utf-8?B?dGQ4ZGE2RUpPWC9HdGExdXoyV2E3ZnR0S3RDZzJRU2pHdi9aRmEwOWd4QU9i?=
 =?utf-8?B?aFlGcTZMbThlRHJ0bnNzUHljbkszT1M1SnQ3UzZsQzZRdVhhZ0h0TmRCTHlP?=
 =?utf-8?B?OWw4bDV6RzJ5bWRTRWRORURMcGlDMTlybUZ5dnhMcXhHL1BiT0UzcHpZUSsv?=
 =?utf-8?B?K3VpeVIxQUx2VjRuVWVwSTVpWGtjZzhqamhRT1NFYndINzdOQTZzVTVPSWRr?=
 =?utf-8?B?dWFNUVpYYXJxWHRJS3N4MXh6UHZ3SzFGb3c1cWhhWTdvOW5GK0hvNW42ajhU?=
 =?utf-8?B?Vm5KVElUa3V5NDFCb25rNDE1bjUwUGJ0emQ1RytMeHpoY09tSHA3Q2dsRHV2?=
 =?utf-8?B?TG1wTkxzQXM1eERHdkY4bStnbFV5S0JrVkgxZHZhc1hsOWFnUXdpYmVoR1Zv?=
 =?utf-8?B?cXN0VVhTUUpVa3FlQWRHRGwySmdJblp2UlRkUHZOaDZ2TlBoN2J5QUx3WUlL?=
 =?utf-8?B?bEtac21jRU1XcjFiODRhSURSME5WeHZEWWxUNGVLRDFnMWFXTUJ4TEJBaGxv?=
 =?utf-8?B?ejc0SzVyb2xLbnlDQjBaSkpSelZNSjdRWERIVXNLR09HZDZ5Sk8vQ1I0aHlz?=
 =?utf-8?B?aldsVWxxL01wWWpFdHJsOWlvbkxQWHV2QWF1a2hMdXlDVG1tSnd0dVVwNUFX?=
 =?utf-8?B?WXlJRTNWK0xaVUJBU0kza2RtMjdXbG12d3VUMUtreGZGd3JPay8yNndIL0lV?=
 =?utf-8?B?OWl4WDVJRXZ2QXZ4bW1oTnVDL2k3bHNvV0c1cnRIRDhnakttcmZEK2YzTmlm?=
 =?utf-8?B?VU04V3VobmZmSjZSZHZKM3NoaWRiR2Ewd2JjUHhRU0s4Rm5sM0RibjVQbGpY?=
 =?utf-8?B?SDBUUmltMUc5Tkk3QkNBT3U5cGljNXRtNFRibitvc0NydmR3VmpJSXNXa3dP?=
 =?utf-8?B?SXNscWp2VjV6NDJoQUE0SFlHak9oUW1lS3JORENwSWVTY05NemRUUWRXZW1q?=
 =?utf-8?B?R092eVVTSms1eXJqYzErNFc5VWhialV1Nzk2L0Ryb1NoR0R5SldjdGttNDlL?=
 =?utf-8?B?WDY2VnUybTFidHczOWlsWk1JTXRCdGNFRmMrVnZ3YzRPYlFWYmlUMzhFYk55?=
 =?utf-8?B?Um9yYjZXbDBiVkdGTSthdEY1VXVPSUlwdVNza0N3MHlOeVZSTkp6VUloN2NE?=
 =?utf-8?B?a09yVDRjUWxMSml6ei9QenI0aFpKTVQ3YkhlLzQ0OEpEeWNrenRybXh3ekxU?=
 =?utf-8?B?bGgxWDMwTHpqZk1qUlp5djdzdXcvSTgxUFhUMW95YTBwN0dMVlludUFPbmcy?=
 =?utf-8?B?QUs5TW01WHFWbHBnZDkzNVR1bUtQZFJSVVkxS1ppdkJHS1dyZDYzTG92ZXh4?=
 =?utf-8?B?eENsQi9FTS9OZU55TlpORWgzTkx2bDJma3EyK2ZDM3llVkF6bnYyakFuVndY?=
 =?utf-8?B?V3dIK2tGQXorVU5pWnMrSEpMN1NabW1SV1pLOHRLZE9ySDhKc3lXd3FxWEUr?=
 =?utf-8?B?TEJnQjQ5ZmZlRTE0SmU1YjMrMk5LdG8xVXVxc05ENkkxYVJ0OHpnQlFUZHlL?=
 =?utf-8?B?Sys0YWQwLzlYejlORHBDTmdEOGJyUW51cWk1U0NtM2wzTm5ZNTlKVGF3bkMz?=
 =?utf-8?Q?gISzHkragWyAEr3GE0Aggbw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619ebc4c-9503-45b4-4e3a-08d9bb435b59
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 18:40:22.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+ckKhpoy/xbl+mVWQk3mCR5sJtRpld0obj5u6OpLOnQtXySczmaAjhi8gLGZXtt+EQX4/tZHJHVC/rexqUk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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

Am 2021-12-09 um 2:49 a.m. schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When application is about finish it destroys queues it has created by
> an ioctl. Driver deletes queue entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
> which is directory including this queue all attributes. Low level kernel
> code deletes all attributes under this directory. The lock from kernel is
> on queue entry, not its attributes. At meantime another user space application
> can read the attributes. There is possibility that the application can
> hold/read the attributes while kernel is deleting the queue entry, cause
> the application have invalid memory access, then killed by kernel.
>
> Driver changes: explicitly create/destroy each attribute for each queue,
> let kernel put lock on each attribute too.

Is this working around a bug in kobject_del? Shouldn't that code take
care of the necessary locking itself?

Regards,
  Felix


>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33 +++++++-----------------
>  2 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 0c3f911e3bf4..045da300749e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -546,6 +546,9 @@ struct queue {
>  
>  	/* procfs */
>  	struct kobject kobj;
> +	struct attribute attr_guid;
> +	struct attribute attr_size;
> +	struct attribute attr_type;
>  };
>  
>  enum KFD_MQD_TYPE {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 9158f9754a24..04a5638f9196 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -73,6 +73,8 @@ static void evict_process_worker(struct work_struct *work);
>  static void restore_process_worker(struct work_struct *work);
>  
>  static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd);
> +static void kfd_sysfs_create_file(struct kobject *kobj, struct attribute *attr,
> +				char *name);
>  
>  struct kfd_procfs_tree {
>  	struct kobject *kobj;
> @@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct kobject *kobj,
>  	return 0;
>  }
>  
> -static struct attribute attr_queue_size = {
> -	.name = "size",
> -	.mode = KFD_SYSFS_FILE_MODE
> -};
> -
> -static struct attribute attr_queue_type = {
> -	.name = "type",
> -	.mode = KFD_SYSFS_FILE_MODE
> -};
> -
> -static struct attribute attr_queue_gpuid = {
> -	.name = "gpuid",
> -	.mode = KFD_SYSFS_FILE_MODE
> -};
> -
> -static struct attribute *procfs_queue_attrs[] = {
> -	&attr_queue_size,
> -	&attr_queue_type,
> -	&attr_queue_gpuid,
> -	NULL
> -};
> -
>  static const struct sysfs_ops procfs_queue_ops = {
>  	.show = kfd_procfs_queue_show,
>  };
>  
>  static struct kobj_type procfs_queue_type = {
>  	.sysfs_ops = &procfs_queue_ops,
> -	.default_attrs = procfs_queue_attrs,
>  };
>  
>  static const struct sysfs_ops procfs_stats_ops = {
> @@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
>  		return ret;
>  	}
>  
> +	kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
> +	kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
> +	kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
> +
>  	return 0;
>  }
>  
> @@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
>  	if (!q)
>  		return;
>  
> +	sysfs_remove_file(&q->kobj, &q->attr_guid);
> +	sysfs_remove_file(&q->kobj, &q->attr_size);
> +	sysfs_remove_file(&q->kobj, &q->attr_type);
> +
>  	kobject_del(&q->kobj);
>  	kobject_put(&q->kobj);
>  }
