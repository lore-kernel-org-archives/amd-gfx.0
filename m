Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDCC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33381206BA
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33381206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09D96E2E2;
	Mon, 11 Nov 2019 20:43:30 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690062.outbound.protection.outlook.com [40.107.69.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532776E2E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH4E+vvbi0B7t8EmcndNC2sUO3tHFnA/MEs0OPZLeyMZExfEYXcizkR5+dpvnNLx7g5Si/mn5daamI5AN+KJlaOcaozH4Ut/Kzqflsg93yux/xLnRhKUF17kYDYdA1j9eqiaMpSQy3ZrW61HFVOxYXXv9ICDJTH2OUqBXvp4SFaPp/UxKAsmBGaaw0+3Fd9TadGSfNihMJva1JB7q30m1wXE106O+AVc+OWFob6LJawo5NDo7jJub3csIyd0Iw7EHlS5FAoyrhQHdl6/8cXjVqjyqfbyItSlIIDdCpD09BXOG2Tw7C4zuoX8obA8p0rjCqMubHMcrGEctG+jmkZPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzUl6oeWWbNrLxg6Fb6g7lL7GtouyBTCLkrXqFd2Z8c=;
 b=naRx10bhAB4jcN3wqQ2fxQiaEbN7v6W7K/RYbWubvkgUQtnyUVn76z54q4+kYQEf2ypB0ve9d2/u8PHhAqv8bRd3UKZslF31V/I/98iYqBobIne7fRmHtYXdd/QuA0Co0Y/pUUZU10mmpOWpKOSPA3tqod8LN1SIBGl7bl07jImpxFBW+Q4QI1OZ1kMlp/5TpTFiBSTAIEKcaSy0ynwnTXpd1XCjnE2ZtUA17+vObD6Q0zSUV851r6h5Xlci7mhluHO/GoNPyYSO5Z22piivd0zBZUZlq6Buw7xCa5GP09+A3tl4qof+ebGw4PPnHlC/xmGyla7NeyeZBHG67immig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2748.namprd12.prod.outlook.com (20.176.117.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 20:43:28 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 20:43:28 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Avoid using doorbell_off as offset in
 process doorbell pages
To: "Zhao, Yong" <Yong.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191101201016.5973-1-Yong.Zhao@amd.com>
 <20191101201016.5973-2-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a21e8321-51bf-f840-f891-2335be774131@amd.com>
Date: Mon, 11 Nov 2019 15:43:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191101201016.5973-2-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
MIME-Version: 1.0
X-Originating-IP: [142.116.193.252]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a4d305f-5b50-4df2-42a3-08d766e7ce13
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27483611A7C964F233E2362D92740@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(52314003)(76176011)(30864003)(71190400001)(31686004)(5660300002)(236005)(2501003)(6246003)(478600001)(446003)(11346002)(2616005)(486006)(14444005)(54896002)(6512007)(33964004)(476003)(81166006)(81156014)(8936002)(7736002)(229853002)(14454004)(6486002)(8676002)(316002)(66556008)(6116002)(3846002)(66476007)(110136005)(16586007)(37036004)(26005)(186003)(6436002)(36756003)(52116002)(44832011)(2906002)(86362001)(66066001)(65956001)(99286004)(386003)(25786009)(31696002)(65806001)(6506007)(53546011)(58126008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2748;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FyznncALoatiF/jhHk5wtLtaquhBZyXjU/bFZeNLRg4PfhyX8NZfai2ngQ8O7l2tpL1oj1DNv/pgEcsGRklvxZlbIj77l9lyVL8Nwp7efbCVdPYOjgxrwP84pJ4DizxOfFFZSqM4VPmrJHp4rOA8jLNLFxwcUZMkwkjUE6xyKR8SjJh7Yh8QkMlwZOEaXAmTuxot/ba/xQt4m8AcwV541MH1lFL3aWnOD0j0dWXbMIBRRt8tXAaJYpVI8ryV9xhMib59O7sf8bN9k4zInlmdpxrgty+Rg69DsP7JoLXSa2IuzMLRucgGIuzPHWQjEqaUaa+GwBPuF4XBuRWOhDky6x80K3oAhofia3MKSJEGEYSZk3gOtQ+KTCh0bScrzQiEHpRKnFqpnlixprPiIVhlesIdSdUY/wnR5i1mTqCx2Y6SfMBsARVrKMS1BwQhjJ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4d305f-5b50-4df2-42a3-08d766e7ce13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 20:43:27.9210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W63RqpsiU8b5co9GliXJRDE+dQ2ee3Sh201pQZ5puRVq2GvwuJakkhm+bx4tnsJeR4rb4oU0w6Fb3uCvXViMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzUl6oeWWbNrLxg6Fb6g7lL7GtouyBTCLkrXqFd2Z8c=;
 b=qJM21SXjfo0b6a/3Lh9dpQMQqsBvTooSf0HbRVT765DUmLc+7iMFa/zz4/1RKScgZkn4xRA8g2mWVGp6n7EdROnbt/oObYlknpSOaQE1OvYfyyNhBmOYkBCcQg9+gBsvL1tYvp5OzOI3EKWpc0XLU/l+PBMafEaqBKTStZekIlE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1984142243=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111204326.QdRQ4oBsea4WOApu0LRpXV0Zx9SwPmAXFL3E3yqOjc0@z>

--===============1984142243==
Content-Type: multipart/alternative;
 boundary="------------CC5366C46AF467F5E40B6DD6"
Content-Language: en-US

--------------CC5366C46AF467F5E40B6DD6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2019-11-01 16:10, Zhao, Yong wrote:
> dorbell_off in the queue properties is mainly used for the doorbell dw
> offset in pci bar. We should not set it to the doorbell byte offset in
> process doorbell pages. This makes the code much easier to read.

I kind of agree. I think what's confusing is that the queue_properties 
structure is used for two different purposes.

 1. For storing queue properties provided by user mode through KFD ioctls
 2. A subset of struct queue passed to mqd_manager and elsewhere (that's
    why some driver state is creeping into it)

Maybe a follow-up could cleanly separate the queue properties from the 
queue driver state. That would probably change some internal interfaces 
to use struct queue instead of queue_properties.

Anyway, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

> Change-Id: I553045ff9fcb3676900c92d10426f2ceb3660005
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             | 12 ++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c              |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  8 ++++++--
>   4 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index d9e36dbf13d5..b91993753b82 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -258,6 +258,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	unsigned int queue_id;
>   	struct kfd_process_device *pdd;
>   	struct queue_properties q_properties;
> +	uint32_t doorbell_offset_in_process = 0;
>   
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
> @@ -286,7 +287,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id);
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
> +			&doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
>   
> @@ -298,12 +300,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
>   	args->doorbell_offset <<= PAGE_SHIFT;
>   	if (KFD_IS_SOC15(dev->device_info->asic_family))
> -		/* On SOC15 ASICs, doorbell allocation must be
> -		 * per-device, and independent from the per-process
> -		 * queue_id. Return the doorbell offset within the
> -		 * doorbell aperture to user mode.
> +		/* On SOC15 ASICs, include the doorbell offset within the
> +		 * process doorbell frame, which could be 1 page or 2 pages.
>   		 */
> -		args->doorbell_offset |= q_properties.doorbell_off;
> +		args->doorbell_offset |= doorbell_offset_in_process;
>   
>   	mutex_unlock(&p->mutex);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> index d59f2cd056c6..1d33c4f25263 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> @@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
>   	properties.type = KFD_QUEUE_TYPE_DIQ;
>   
>   	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
> -				&properties, &qid);
> +				&properties, &qid, NULL);
>   
>   	if (status) {
>   		pr_err("Failed to create DIQ\n");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 7c561c98f2e2..66bae8f2dad1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -907,7 +907,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct kfd_dev *dev,
>   			    struct file *f,
>   			    struct queue_properties *properties,
> -			    unsigned int *qid);
> +			    unsigned int *qid,
> +			    uint32_t *p_doorbell_offset_in_process);
>   int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
>   int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
>   			struct queue_properties *p);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 8509814a6ff0..48185d2957e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -192,7 +192,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct kfd_dev *dev,
>   			    struct file *f,
>   			    struct queue_properties *properties,
> -			    unsigned int *qid)
> +			    unsigned int *qid,
> +			    uint32_t *p_doorbell_offset_in_process)
>   {
>   	int retval;
>   	struct kfd_process_device *pdd;
> @@ -307,8 +308,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		/* Return the doorbell offset within the doorbell page
>   		 * to the caller so it can be passed up to user mode
>   		 * (in bytes).
> +		 * There are always 1024 doorbells per process, so in case
> +		 * of 8-byte doorbells, there are two doorbell pages per
> +		 * process.
>   		 */
> -		properties->doorbell_off =
> 		*p_doorbell_offset_in_process =

You need a NULL pointer check here because you call this with a NULL 
pointer from the DIQ code.


>   			(q->properties.doorbell_off * sizeof(uint32_t)) &
>   			(kfd_doorbell_process_slice(dev) - 1);
>   

--------------CC5366C46AF467F5E40B6DD6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 2019-11-01 16:10, Zhao, Yong wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao@amd.com">
      <pre class="moz-quote-pre" wrap="">dorbell_off in the queue properties is mainly used for the doorbell dw
offset in pci bar. We should not set it to the doorbell byte offset in
process doorbell pages. This makes the code much easier to read.</pre>
    </blockquote>
    <p>I kind of agree. I think what's confusing is that the
      queue_properties structure is used for two different purposes.</p>
    <ol>
      <li>For storing queue properties provided by user mode through KFD
        ioctls</li>
      <li>A subset of struct queue passed to mqd_manager and elsewhere
        (that's why some driver state is creeping into it)<br>
      </li>
    </ol>
    <p>Maybe a follow-up could cleanly separate the queue properties
      from the queue driver state. That would probably change some
      internal interfaces to use struct queue instead of
      queue_properties.<br>
    </p>
    <p>Anyway, this patch is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao@amd.com">
      <pre class="moz-quote-pre" wrap="">
Change-Id: I553045ff9fcb3676900c92d10426f2ceb3660005
Signed-off-by: Yong Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Yong.Zhao@amd.com">&lt;Yong.Zhao@amd.com&gt;</a>
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
    <p>You need a NULL pointer check here because you call this with a
      NULL pointer from the DIQ code.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			(q-&gt;properties.doorbell_off * sizeof(uint32_t)) &amp;
 			(kfd_doorbell_process_slice(dev) - 1);
 
</pre>
    </blockquote>
  </body>
</html>

--------------CC5366C46AF467F5E40B6DD6--

--===============1984142243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1984142243==--
