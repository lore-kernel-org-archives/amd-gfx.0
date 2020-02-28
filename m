Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635EBC3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 05:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B2D246A1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 05:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sQjVBsut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B2D246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615686EDD8;
	Fri, 28 Feb 2020 05:08:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8746A6EDD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 05:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6X+SLjy1VQWDtSEbxkGYiJjUK+iXwS62glqI3rZ/Eoel+Ei9UjWtyItO9Qe41BzQ7hK1MhSLm/W+YEgtciQw6tz5GsRD2DiN1c7/FzKfpQQXsJgf7x3g9YzWycuP1LgIg4OeUN3GJPa/A05f98wVe2XxdrU5xkUBY+UFXSPMqx1yyUykX71rJ8qAwk4XuQGCD3gezdsvffzCgxyhNOUxaQTTzW9n++ikuipBC72AmgyfyJECp/04fwqib5rsr3eizZfvjiisb2uc6EZgn+KgRhG8xI5Q4OfYN9y3Pw2c2T6eU/xcnXW7RF674DS2In6HmrxqZCo7WncTm35w/rQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQOOgccDmZlhshZ9FvCk8v5YRG3e28tf05H3Ku6t4qI=;
 b=YNkRNtp9MDyFhaeOzrWV/r+1pN3kXMIkhlCjmHfeWbiu+MDAq7+XO5e7ytwZAL2Bux4J5l/pgoEcxc6V8BoImE5ZnssIjmgTbY5kjtILKkk2jpehuuI6BVniTgfhrOhiZ2OgS6CrARGWxBDdNBJufx+RBZAPJ34UANfgFLU2qPyVa2Fp2sI9B7lGDEjhjacBlCYRzWo3maofdkxcsktBhYe/ktwgWilSVN5Ej3Szs8QaDk7FA/EPbHUl1u0wW0f4anHpF5/+cW2eDPtH9dAAp6kL2nrNCOfZVnj8oGnIrFi+lD+evWjNoYTW9n1pqLz3XJH/Jd62pn71XvtM3/6S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQOOgccDmZlhshZ9FvCk8v5YRG3e28tf05H3Ku6t4qI=;
 b=sQjVBsutRSiVgW5z51/RE/wv+9N3ypbVo6gIxQBkZcI7E1FeYGQu69/oPlgdFwy13kCqE0kjAkUSZOtCGpS4OHitkzka+wvropNTzN9dsfnoOgpOKuS/g/i+IZQSulig8Bi0dUnx4bZqyOo3iswbc+umALLYA+Yx/+syxayH1jE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Fri, 28 Feb
 2020 05:08:04 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 05:08:04 +0000
Subject: Re: [RFC PATCH 2/4] drm/scheduler: implement a function to modify
 sched list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <20200227214012.3383-2-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <46106fdd-55ed-cb09-902e-a1c0cffd7b0d@amd.com>
Date: Fri, 28 Feb 2020 00:08:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200227214012.3383-2-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 05:08:03 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1cd288c-cf70-4139-e189-08d7bc0c30d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:|DM6PR12MB4138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41382262698CB9A5535BA4D299E80@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(66556008)(66946007)(86362001)(52116002)(5660300002)(31696002)(6512007)(4326008)(36756003)(66476007)(44832011)(316002)(2906002)(16526019)(6486002)(956004)(2616005)(478600001)(53546011)(8676002)(81166006)(81156014)(8936002)(6506007)(26005)(31686004)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4138;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOwT4QXgxuEuKoEpLs0c1bzN8rLzOw/7U+zwtVrdsyYMP8gHdMgiiTWNQi2JFf7WYPfsN1jh1mHaeum1HBl+QcHccZQknTivzWZN+PBiVp4mnfdTVmcox8OFod8Vf/VqBGNQFm1zJKstHlD9OJHKibomU2qTR/lGfxqKegzwP6FJFpWC02Dk4s5sOfDfR/yZwqiLxZGTf3D7wo+Pdwqeq8+mooZ9aBgL24e3fPR1QGI7S6/C7S9b8wQRXpmkCMLEi0x7yYVkaztWhfbs6d/M5w84aOrHUdPXyugLsAFSf3AhUz6r+/CZkPNSxnjFtCYUGSqJctS2HLzxHUqykhhmuudJvafE8EuRhp/zVjdcyfBKZ0ry8tP5jKJ+/SkFFYYsz5x8k/Ztuyl2pLEkxveQLwpKQ1vxIDDHaqeN5+Soiat75SeuJoWwTG6Q7mzoZFL0
X-MS-Exchange-AntiSpam-MessageData: 3pxoud7wJinvWFz6kFwYyH2XLkPP0Ecl65lC5Bry2dY/3cOpmU3r8w468XwM0dDDZVAlZzDA3ft9najSV6m8pr3CLM+rMbhN8GbzlbtV9ulo5vSej9ZyiK/O05YputBb557p5yb4qXXZysW9NgW0vQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cd288c-cf70-4139-e189-08d7bc0c30d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 05:08:04.3052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7V8InFJkWFnf8NBJC/UXdc8h7JdJgasEFdrL9FASx+Z6x0oB6oAdTJgJTYdTZpY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-27 4:40 p.m., Nirmoy Das wrote:
> implement drm_sched_entity_modify_sched() which can modify existing
> sched_list with a different one. This is going to be helpful when
> userspace changes priority of a ctx/entity then driver can switch to
> corresponding hw shced list for that priority
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 24 ++++++++++++++++++++++++
>  include/drm/gpu_scheduler.h              |  4 ++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 63bccd201b97..711e9d504bcb 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -83,6 +83,30 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>  }
>  EXPORT_SYMBOL(drm_sched_entity_init);
>  
> +/**
> + * drm_sched_entity_modify_sched - Modify sched of an entity
> + *
> + * @entity: scheduler entity to init
> + * @sched_list: the list of new drm scheds which will replace
> + *		existing entity->sched_list
> + * @num_sched_list: number of drm sched in sched_list
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> +				  struct drm_gpu_scheduler **sched_list,
> +				  unsigned int num_sched_list)
> +{
> +	if (!(entity && sched_list && (num_sched_list == 0 || sched_list[0])))
> +		return -EINVAL;

This seems unmaintainable. I'd write it in its natural form:

int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
				  struct drm_gpu_scheduler **sched_list,
				  unsigned int num_sched_list)
{
	if (entity && sched_list && (num_sched_list == 0 || sched_list[0] != NULL)) {
		entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
		entity->num_sched_list = num_sched_list;
		return 0;
	} else {
		return -EINVAL;
	}
}

That's too heavy. Can we improve the architecture
so we don't have to check for this in leaf functions like this one?
We can just return a parameterization.

Why would this be called with entity being NULL?
Or with sched_list being NULL? Or num_sched_list being not zero
yet sched_list[0] being NULL? Why not make sure that sched_list[0] is
never NULL and that num_sched_list is greater than 0 always?

Does this make it to user space?
Why would the state of execution be one such that this is true/false
for the code to return -EINVAL?
From patch 3/4 it seems that an error is printed inside amdgpu_ctx_priority_override()
and the result is not propagated up the stack.

I think we should improve the code where here this condition above
is never true. Then we can use parameterization for those two
statements below:

> +
> +	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;

So if we're here, we know from the top conditional that
either num_sched_list is 0 or that sched_list[0] not NULL
or both.

So if num_sched_list is 0 or 1 we return NULL?
And if num_sched_list is 2 or greater we return sched_list
of which sched_list[0] could be NULL?

Why not fix the architecture so that this is simply copied? (in which case
we can simply index-parameterize it and simply copy it.
Why are there so many checks everywhere?

> +	entity->num_sched_list = num_sched_list;
> +

I mean, all we're doing in this function is initializing
entity->sched_list and entity->num_sched_list. Why does this
function have to be so complex and do so many checks?
Can we improve/fix the architecture instead?

Regards,
Luben


> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> +
>  /**
>   * drm_sched_entity_is_idle - Check if entity is idle
>   *
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 589be851f8a1..0c164a96d51b 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -297,6 +297,10 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched);
>  int drm_sched_job_init(struct drm_sched_job *job,
>  		       struct drm_sched_entity *entity,
>  		       void *owner);
> +int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> +				  struct drm_gpu_scheduler **sched_list,
> +                                  unsigned int num_sched_list);
> +
>  void drm_sched_job_cleanup(struct drm_sched_job *job);
>  void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>  void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
