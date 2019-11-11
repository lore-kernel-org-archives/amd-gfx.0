Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4005EC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D582D214DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D582D214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CC66E329;
	Mon, 11 Nov 2019 23:06:25 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820058.outbound.protection.outlook.com [40.107.82.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A516E329
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 23:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJM1OBHIYhjLWhlqOdgAPdfKe5a9xyIHXEplOPyUMoGZmVGXBG6iACJAhCgKPkKua0AxyYqFT0VHTbzQ2RgsGogeR71DijqEwl23p3aj4Sje96g6HgPHklTKnMAfTJYsWJWD9qgwCCeraoOgHSJ56AjR6dNiGFIVo52OBHBWU9F1eW/17iy34WY5SXuUc5IyyvtMVJttr8d8PW4S6tCEItSC1Nuospt+5ptF9pTOz26CUu1xFRz+dYBGUeVdcUhPVsqr02DHgD56zhg3+mdINWKIO+G++i1eZOLU4cK/CtvwNnGIcSWxnmd+cVI95FWBSpGYw3RUPx5QnWQEYgVRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT80w2D1bNo7fjFhqNdjpyD2w6x00Mdl1wgHZhizmZI=;
 b=CGW46H0RwKmb2K5oVPPo5Y8HOGzjp1ReFsOVtRjnsh9frK0vX4lufuGQcBIlP53OS3T19ldTOtHNLjW7IOydYBNRuc7lCICRcjoaAW+qxu+3mdpF+sL8O/pgEhC/Ehn/4/Mj5kAlK2wxpUssftbv5ytviGbPpEF+haZfgNzV67wbL+M1DXKjIc11cBJwNuNhj8KDMOSTebaKYRkMpDSEy3UZ5+eqLiB0T8LoUtLfjL4/JGpfx/0r0SO1XN4PHkoxcgvaYBIb6hvb7YPPEOnrtdSFaekZ9xXh/nIw0s239xXdxKX3WXhQlpdG4y8RKocGW8PRJrKwNqaBQouMPiiWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3115.namprd12.prod.outlook.com (20.178.31.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 23:06:22 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 23:06:22 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Avoid using doorbell_off as offset in
 process doorbell pages
To: Felix Kuehling <felix.kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191101201016.5973-1-Yong.Zhao@amd.com>
 <20191101201016.5973-2-Yong.Zhao@amd.com>
 <a21e8321-51bf-f840-f891-2335be774131@amd.com>
 <78f9e381-e490-5555-c84d-ca76dcee7c83@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <c532747d-394a-0e3f-6ee2-91155e217134@amd.com>
Date: Mon, 11 Nov 2019 18:06:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <78f9e381-e490-5555-c84d-ca76dcee7c83@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83b8cf40-bc63-4376-f987-08d766fbc495
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3115DFF11AE17A7B898746F4F0740@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(52314003)(236005)(6116002)(2906002)(31686004)(52116002)(66476007)(66946007)(229853002)(81156014)(76176011)(53546011)(33964004)(66556008)(6506007)(386003)(476003)(486006)(26005)(2501003)(71190400001)(6486002)(6436002)(2616005)(31696002)(14444005)(3846002)(6512007)(966005)(6306002)(54896002)(478600001)(14454004)(86362001)(8936002)(8676002)(81166006)(25786009)(5660300002)(58126008)(16586007)(37036004)(316002)(606006)(36756003)(6246003)(186003)(44832011)(30864003)(446003)(11346002)(66066001)(65956001)(65806001)(99286004)(4001150100001)(7736002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3115;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYgswsav8aTzuazFc3fpRML6cP66LHcn3lYjvxwokhVROm4YWtqaiXnMBx/OkOV6zdYxPyiZ7CoMs9rtxH4vFBE/eUpllLDYdemYnoAz4f3mLR8o86bX0k8lUAYS60FHpgvcgEUtKqwXqr+SEk6jM02RjmXiQeQ62HiA/IQP8SV9UyPwYyYVyLbaJoPE/uLlWjWQpQl4xPWt38qM2/RRT9Ijq77vrFhlR7K3KCxFemmv9xrrZn+rtG/Xi9+/J1I17AivRDbRfX+xu8moam6fqVX2ZIeKqFY/BJfa2dPhW5ryHHJn61mOEIx3NOAOeiA5ev2IJ0TzcK9kxPpPrDIXuyWh+/ofQGqirPECrUVGGtNCQpzUbx7pVdmKgPY2tcp9NcIIudbFeVO/r+UEsa4Qxzat1+mqFcUS4yG3egGs7y5H5aipKJH50dlwJMrtNRXyQZfPrWqgxYfjXeFPGfjX7tA1txLrGDU539m6+LYFbhE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b8cf40-bc63-4376-f987-08d766fbc495
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 23:06:21.9300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b94r0+Nv5WejXsUjrdg+PwEMNWQKE3owUxCLslTCcYW1aEdyP80GV7WYDbd7snNg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT80w2D1bNo7fjFhqNdjpyD2w6x00Mdl1wgHZhizmZI=;
 b=rS7SLVXURMFpEWGyhgAsnLqX6TGbRe81uWUAJx/GGqRM0lYqVYWe+ade7wokw30ZkBS6iaVYFFEnaeGrEN+ylK+yQjY/clR1hHnHKAtJS1mYtzi9wsih39F7RvKCLTC62jEbxyq+lUEKPNOHIJNRjEkgxMc1gtHKH4ujiNBixLw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1706475245=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111230620.NcrPnyBO0Egd3kS0PAg8h2SlQUu6djbIu1ukobdRCfk@z>

--===============1706475245==
Content-Type: multipart/alternative;
 boundary="------------AEBF45F7BD0687A7EC0DE7BC"
Content-Language: en-US

--------------AEBF45F7BD0687A7EC0DE7BC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The NULL pointer is not an issue, because for DIQ, the if (q) condition, 
which guards the section but is now shown, will never be satisfied. 
Anyway, I still added the NULL pointer check.

With that, I have pushed the change.


Yong

On 2019-11-11 3:51 p.m., Felix Kuehling wrote:
> On 2019-11-11 15:43, Felix Kuehling wrote:
>> On 2019-11-01 16:10, Zhao, Yong wrote:
>>> dorbell_off in the queue properties is mainly used for the doorbell dw
>>> offset in pci bar. We should not set it to the doorbell byte offset in
>>> process doorbell pages. This makes the code much easier to read.
>>
>> I kind of agree. I think what's confusing is that the 
>> queue_properties structure is used for two different purposes.
>>
>>  1. For storing queue properties provided by user mode through KFD ioctls
>>  2. A subset of struct queue passed to mqd_manager and elsewhere
>>     (that's why some driver state is creeping into it)
>>
>> Maybe a follow-up could cleanly separate the queue properties from 
>> the queue driver state. That would probably change some internal 
>> interfaces to use struct queue instead of queue_properties.
>>
>> Anyway, this patch is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
> I pointed out a missing NULL pointer check inline near the end of the 
> patch. I should have mentioned it here. Please fix that before you submit.
>
> Thanks,
>   Felix
>
>
>>> Change-Id: I553045ff9fcb3676900c92d10426f2ceb3660005
>>> Signed-off-by: Yong Zhao<Yong.Zhao@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             | 12 ++++++------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c              |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  3 ++-
>>>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  8 ++++++--
>>>   4 files changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index d9e36dbf13d5..b91993753b82 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -258,6 +258,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>   	unsigned int queue_id;
>>>   	struct kfd_process_device *pdd;
>>>   	struct queue_properties q_properties;
>>> +	uint32_t doorbell_offset_in_process = 0;
>>>   
>>>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>>>   
>>> @@ -286,7 +287,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>   			p->pasid,
>>>   			dev->id);
>>>   
>>> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id);
>>> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
>>> +			&doorbell_offset_in_process);
>>>   	if (err != 0)
>>>   		goto err_create_queue;
>>>   
>>> @@ -298,12 +300,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>   	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
>>>   	args->doorbell_offset <<= PAGE_SHIFT;
>>>   	if (KFD_IS_SOC15(dev->device_info->asic_family))
>>> -		/* On SOC15 ASICs, doorbell allocation must be
>>> -		 * per-device, and independent from the per-process
>>> -		 * queue_id. Return the doorbell offset within the
>>> -		 * doorbell aperture to user mode.
>>> +		/* On SOC15 ASICs, include the doorbell offset within the
>>> +		 * process doorbell frame, which could be 1 page or 2 pages.
>>>   		 */
>>> -		args->doorbell_offset |= q_properties.doorbell_off;
>>> +		args->doorbell_offset |= doorbell_offset_in_process;
>>>   
>>>   	mutex_unlock(&p->mutex);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
>>> index d59f2cd056c6..1d33c4f25263 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
>>> @@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
>>>   	properties.type = KFD_QUEUE_TYPE_DIQ;
>>>   
>>>   	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
>>> -				&properties, &qid);
>>> +				&properties, &qid, NULL);
>>>   
>>>   	if (status) {
>>>   		pr_err("Failed to create DIQ\n");
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 7c561c98f2e2..66bae8f2dad1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -907,7 +907,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>   			    struct kfd_dev *dev,
>>>   			    struct file *f,
>>>   			    struct queue_properties *properties,
>>> -			    unsigned int *qid);
>>> +			    unsigned int *qid,
>>> +			    uint32_t *p_doorbell_offset_in_process);
>>>   int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
>>>   int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
>>>   			struct queue_properties *p);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 8509814a6ff0..48185d2957e9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -192,7 +192,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>   			    struct kfd_dev *dev,
>>>   			    struct file *f,
>>>   			    struct queue_properties *properties,
>>> -			    unsigned int *qid)
>>> +			    unsigned int *qid,
>>> +			    uint32_t *p_doorbell_offset_in_process)
>>>   {
>>>   	int retval;
>>>   	struct kfd_process_device *pdd;
>>> @@ -307,8 +308,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>   		/* Return the doorbell offset within the doorbell page
>>>   		 * to the caller so it can be passed up to user mode
>>>   		 * (in bytes).
>>> +		 * There are always 1024 doorbells per process, so in case
>>> +		 * of 8-byte doorbells, there are two doorbell pages per
>>> +		 * process.
>>>   		 */
>>> -		properties->doorbell_off =
>>> 		*p_doorbell_offset_in_process =
>>
>> You need a NULL pointer check here because you call this with a NULL 
>> pointer from the DIQ code.
>>
It is not an issue, because for DIQ, the if (q) condition, which guards 
this section but is now shown, will never be satisfied. Anyway, I still 
added the NULL pointer check.

With that, I have pushed the change.

>>
>>>   			(q->properties.doorbell_off * sizeof(uint32_t)) &
>>>   			(kfd_doorbell_process_slice(dev) - 1);
>>>   
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------AEBF45F7BD0687A7EC0DE7BC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>The NULL pointer is not an issue, because for DIQ, the if (q)
      condition, which guards the section but is now shown, will never
      be satisfied. Anyway, I still added the NULL pointer check.</p>
    <p>With that, I have pushed the change.</p>
    <p><br>
    </p>
    <p>Yong<br>
    </p>
    <div class="moz-cite-prefix">On 2019-11-11 3:51 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:78f9e381-e490-5555-c84d-ca76dcee7c83@amd.com">
      
      <div class="moz-cite-prefix">On 2019-11-11 15:43, Felix Kuehling
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:a21e8321-51bf-f840-f891-2335be774131@amd.com">
        <div class="moz-cite-prefix">On 2019-11-01 16:10, Zhao, Yong
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao@amd.com">
          <pre class="moz-quote-pre" wrap="">dorbell_off in the queue properties is mainly used for the doorbell dw
offset in pci bar. We should not set it to the doorbell byte offset in
process doorbell pages. This makes the code much easier to read.</pre>
        </blockquote>
        <p>I kind of agree. I think what's confusing is that the
          queue_properties structure is used for two different purposes.</p>
        <ol>
          <li>For storing queue properties provided by user mode through
            KFD ioctls</li>
          <li>A subset of struct queue passed to mqd_manager and
            elsewhere (that's why some driver state is creeping into it)<br>
          </li>
        </ol>
        <p>Maybe a follow-up could cleanly separate the queue properties
          from the queue driver state. That would probably change some
          internal interfaces to use struct queue instead of
          queue_properties.<br>
        </p>
        <p>Anyway, this patch is</p>
        <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><br>
        </p>
      </blockquote>
      <p>I pointed out a missing NULL pointer check inline near the end
        of the patch. I should have mentioned it here. Please fix that
        before you submit.</p>
      <p>Thanks,<br>
        &nbsp; Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:a21e8321-51bf-f840-f891-2335be774131@amd.com">
        <p> </p>
        <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao@amd.com">
          <pre class="moz-quote-pre" wrap="">Change-Id: I553045ff9fcb3676900c92d10426f2ceb3660005
Signed-off-by: Yong Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Yong.Zhao@amd.com" moz-do-not-send="true">&lt;Yong.Zhao@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             | 12 &#43;&#43;&#43;&#43;&#43;&#43;------
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c              |  2 &#43;-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  3 &#43;&#43;-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  8 &#43;&#43;&#43;&#43;&#43;&#43;--
 4 files changed, 15 insertions(&#43;), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d9e36dbf13d5..b91993753b82 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -258,6 &#43;258,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	unsigned int queue_id;
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
&#43;	uint32_t doorbell_offset_in_process = 0;
 
 	memset(&amp;q_properties, 0, sizeof(struct queue_properties));
 
@@ -286,7 &#43;287,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			p-&gt;pasid,
 			dev-&gt;id);
 
-	err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &amp;queue_id);
&#43;	err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &amp;queue_id,
&#43;			&amp;doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
 
@@ -298,12 &#43;300,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	args-&gt;doorbell_offset |= KFD_MMAP_GPU_ID(args-&gt;gpu_id);
 	args-&gt;doorbell_offset &lt;&lt;= PAGE_SHIFT;
 	if (KFD_IS_SOC15(dev-&gt;device_info-&gt;asic_family))
-		/* On SOC15 ASICs, doorbell allocation must be
-		 * per-device, and independent from the per-process
-		 * queue_id. Return the doorbell offset within the
-		 * doorbell aperture to user mode.
&#43;		/* On SOC15 ASICs, include the doorbell offset within the
&#43;		 * process doorbell frame, which could be 1 page or 2 pages.
 		 */
-		args-&gt;doorbell_offset |= q_properties.doorbell_off;
&#43;		args-&gt;doorbell_offset |= doorbell_offset_in_process;
 
 	mutex_unlock(&amp;p-&gt;mutex);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index d59f2cd056c6..1d33c4f25263 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 &#43;185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev-&gt;pqm, dbgdev-&gt;dev, NULL,
-				&amp;properties, &amp;qid);
&#43;				&amp;properties, &amp;qid, NULL);
 
 	if (status) {
 		pr_err(&quot;Failed to create DIQ\n&quot;);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7c561c98f2e2..66bae8f2dad1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -907,7 &#43;907,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct kfd_dev *dev,
 			    struct file *f,
 			    struct queue_properties *properties,
-			    unsigned int *qid);
&#43;			    unsigned int *qid,
&#43;			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
 			struct queue_properties *p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8509814a6ff0..48185d2957e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -192,7 &#43;192,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct kfd_dev *dev,
 			    struct file *f,
 			    struct queue_properties *properties,
-			    unsigned int *qid)
&#43;			    unsigned int *qid,
&#43;			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
 	struct kfd_process_device *pdd;
@@ -307,8 &#43;308,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		/* Return the doorbell offset within the doorbell page
 		 * to the caller so it can be passed up to user mode
 		 * (in bytes).
&#43;		 * There are always 1024 doorbells per process, so in case
&#43;		 * of 8-byte doorbells, there are two doorbell pages per
&#43;		 * process.
 		 */
-		properties-&gt;doorbell_off =
		*p_doorbell_offset_in_process =</pre>
        </blockquote>
        <p>You need a NULL pointer check here because you call this with
          a NULL pointer from the DIQ code.<br>
        </p>
      </blockquote>
    </blockquote>
    <p>It is not an issue, because for DIQ, the if (q) condition, which
      guards this section but is now shown, will never be satisfied.
      Anyway, I still added the NULL pointer check.</p>
    <p>With that, I have pushed the change.<br>
    </p>
    <blockquote type="cite" cite="mid:78f9e381-e490-5555-c84d-ca76dcee7c83@amd.com">
      <blockquote type="cite" cite="mid:a21e8321-51bf-f840-f891-2335be774131@amd.com">
        <p> </p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao@amd.com">
          <pre class="moz-quote-pre" wrap=""> 			(q-&gt;properties.doorbell_off * sizeof(uint32_t)) &amp;
 			(kfd_doorbell_process_slice(dev) - 1);
 
</pre>
        </blockquote>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------AEBF45F7BD0687A7EC0DE7BC--

--===============1706475245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1706475245==--
