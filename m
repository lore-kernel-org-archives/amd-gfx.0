Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92FC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 14:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5632420774
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 14:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QIb0YHUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5632420774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067C4896ED;
	Tue, 24 Mar 2020 14:52:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947C6896ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 14:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh9KgluAcD/xkjWPuvCDCx/+RN3kNhlMfTB1mIiX0jWuONHKFsGaj0XggWDAd2pbGFsZdv93nlojlL1dy0l4WNeXFq98w7iRj30g5Uy4oahjusgk/xTajinTQG2hvGSWi1V55ovXE2nXYK1YiUiDcdJZInaabnvhSrFgl+X1RQa16RlrZ78PtHqgka5BgWl/RSMC8m9nG0GlSI5U9Yfd7dkiHgXf5rp4cU7jC1ZKLjZwi0/rozogZzkx1Vko5ZwTeHIdrcXo/8UBuXW3MgB0ScH9CDI8ZlGC93BfWYoB/+rgpYtws+Jd+YLUKNNlnk8RaXfaamdFnvwIpWC4YGg+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/WQ5wnltzCBAzbnb9nq5tX1hpvlVwBfVupk//6+KU=;
 b=B7TOCLgcZ+UZA6fe8IJBwSN4b3DNIgSowokacPDzo56WakRTVwa+LfV9qbod7uHBZTwThk6d19UDkCRQ04Z8rLLJp+pEabZMGVL5JVaNT91UE8X6M69u9+6S7tpLrvfUH+dTD6xR07UWtM/Z1IUETk9H0E493lUZOd92EheCGlxwR95Fk3EPBYwc4qeigWlt7qv4EDw8/wNv8hnEtkYjHgpaYh3vpa7zkLeG/BAR3jKFuTc52t5+yuymYKWjx0kUuYz+F3ddSrZPugR1IpT9epuiGoGUUtk8XCN0Dmt8E4zDimi40puG4ki1QNk9b7aFsknRQn/PKntjicEV3BjU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/WQ5wnltzCBAzbnb9nq5tX1hpvlVwBfVupk//6+KU=;
 b=QIb0YHUE+LYP5EBAog2HTe+U2G9iklTXln3hhOXx9ZDAm744mZRiPJwBaNTYsTkJ5GABpa5EVnh3rkv1OeZeOtR9vXAXQn/OS+SyBzk1VjwM38b1R4zGQipmWO6+MfqcP+PtG23rvZqYV82+LFgb4qu1+YDtBpyxuhA4kQN3u2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1536.namprd12.prod.outlook.com (2603:10b6:301:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 14:52:34 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 14:52:34 +0000
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200323142247.3175-1-yttao@amd.com>
 <2a6a579f-062c-3911-d06a-d4e51f5815a3@amd.com>
 <SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <be0e40cf-3ecf-ebe8-2d73-1dd937450c18@amd.com>
Date: Tue, 24 Mar 2020 10:52:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR19CA0087.namprd19.prod.outlook.com
 (2603:10b6:404:133::25) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:fc00:e58d:714:7e27:7c05]
 (2607:fea8:3edf:fc00:e58d:714:7e27:7c05) by
 BN6PR19CA0087.namprd19.prod.outlook.com (2603:10b6:404:133::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 24 Mar 2020 14:52:31 +0000
X-Originating-IP: [2607:fea8:3edf:fc00:e58d:714:7e27:7c05]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8327e29-614d-42c8-55e8-08d7d002fc57
X-MS-TrafficTypeDiagnostic: MWHPR12MB1536:|MWHPR12MB1536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB153633077DDEC51EEC821FE3EAF10@MWHPR12MB1536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(52116002)(31696002)(2906002)(6666004)(110136005)(86362001)(81166006)(316002)(6486002)(81156014)(8936002)(8676002)(478600001)(186003)(66556008)(6636002)(966005)(5660300002)(66476007)(31686004)(53546011)(4326008)(2616005)(36756003)(66946007)(45080400002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1536;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0FrhZL96c7iiKTxOxbkaXcHg+DSS3BpVswxAm/SkrmX3VV/qSL/53J7ZlUV8H0Dsr6PWQhgt+0uDcVKoN2S53hHXbwl6O8xyCgxGX8EROCRb7V3L+99cwAE/SiqySscvpyr5MaX4xJL9ACXxk/GKk8zFmAUpkVgYgbS2te9VIVrSblTjbyoUNiLmhbllt0XrOO9AVzhvx7cnAXBRBr9pKVNWNOKhiE1E0KKbM43+XAkQG9l/Ig9JV22pp6T4DW+VchkDM7TYnh5sCXT+Br/HzXxH+NZfpHAKF4BQ2iMu7doF5y8hGngek3AX8oDKEQJj9Sm9BdE0DvHc1H3WqFWuKrEbis6ddHw+cnRodXLXno/0xxyJujB9Dkmy+5ENna8a82985fK7kUunnCzKdAzKDDQDQBlXYIMNIFKsoUNb2gD8cin4Jwsv+4xzt2u06ObXZ624ssRj/cECTuIuvssLti7TMxmdxaJECKYNO4va8I=
X-MS-Exchange-AntiSpam-MessageData: yv+scfxo8OZvpdOfq4EVcrLP2x0mW2z0ZbiShROvFvits+lR6U61TcoJxyV1y9yNx/TOnjl0wKRplLRku8Ptg1qS9iUAGRQrXAdR7M7hDDYn/ByA0I2FAnzUWYZ1WB8JKpGR2zKMMYh408gBAHwxlm5K1zJMUd7l5Jyxt2h7kzL6BjwEmPVEwC2kWT7jmJTkTxDw0694gq/ozsb3QnCL5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8327e29-614d-42c8-55e8-08d7d002fc57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 14:52:34.1157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaIvqYTOthBqwcKVGb+xtVt7GVb4KsIy5LmS+gEwHaWQrrWOlC1QSmo1RyYGRp/0T6vpXA0bW8PydqX8aR0g0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1035603618=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1035603618==
Content-Type: multipart/alternative;
 boundary="------------0E9BCFC898928B0F3BA1E091"
Content-Language: en-US

--------------0E9BCFC898928B0F3BA1E091
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

This is only for the guilty job which was removed from the 
ring_mirror_list due to completion and hence will not be resubmitted by 
recovery and will not be freed by the usual flow in 
drm_sched_get_cleanup_job (see drm_sched_stop)

Andrey

On 3/24/20 10:45 AM, Pan, Xinhui wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Does this issue occur when gpu recovery?
> I just check the code,  fence timedout will free job and put its 
> fence. but gpu recovery might resubmit job.
> Correct me if I am wrong.
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> *Sent:* Tuesday, March 24, 2020 11:40:06 AM
> *To:* Tao, Yintian <Yintian.Tao@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH] drm/amdgpu: hold the reference of finished fence
>
> On 3/23/20 10:22 AM, Yintian Tao wrote:
> > There is one one corner case at dma_fence_signal_locked
> > which will raise the NULL pointer problem just like below.
> > ->dma_fence_signal
> >      ->dma_fence_signal_locked
> >        ->test_and_set_bit
> > here trigger dma_fence_release happen due to the zero of fence refcount.
>
>
> Did you find out why the zero refcount on the finished fence happens
> before the fence was signaled ? The finished fence is created with
> refcount set to 1 in drm_sched_fence_create->dma_fence_init and then the
> refcount is decremented in
> drm_sched_main->amdgpu_job_free_cb->drm_sched_job_cleanup. This should
> only happen after fence is already signaled (see
> drm_sched_get_cleanup_job). On top of that the finished fence is
> referenced from other places (e.g. entity->last_scheduled e.t.c)...
>
>
> >
> > ->dma_fence_put
> >      ->dma_fence_release
> >        ->drm_sched_fence_release_scheduled
> >            ->call_rcu
> > here make the union fled “cb_list” at finished fence
> > to NULL because struct rcu_head contains two pointer
> > which is same as struct list_head cb_list
> >
> > Therefore, to hold the reference of finished fence at 
> drm_sched_process_job
> > to prevent the null pointer during finished fence dma_fence_signal
> >
> > [  732.912867] BUG: kernel NULL pointer dereference, address: 
> 0000000000000008
> > [  732.914815] #PF: supervisor write access in kernel mode
> > [  732.915731] #PF: error_code(0x0002) - not-present page
> > [  732.916621] PGD 0 P4D 0
> > [  732.917072] Oops: 0002 [#1] SMP PTI
> > [  732.917682] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G           
> OE     5.4.0-rc7 #1
> > [  732.918980] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> > [  732.920906] RIP: 0010:dma_fence_signal_locked+0x3e/0x100
> > [  732.938569] Call Trace:
> > [  732.939003]  <IRQ>
> > [  732.939364]  dma_fence_signal+0x29/0x50
> > [  732.940036]  drm_sched_fence_finished+0x12/0x20 [gpu_sched]
> > [  732.940996]  drm_sched_process_job+0x34/0xa0 [gpu_sched]
> > [  732.941910]  dma_fence_signal_locked+0x85/0x100
> > [  732.942692]  dma_fence_signal+0x29/0x50
> > [  732.943457]  amdgpu_fence_process+0x99/0x120 [amdgpu]
> > [  732.944393] sdma_v4_0_process_trap_irq+0x81/0xa0 [amdgpu]
> >
> > v2: hold the finished fence at drm_sched_process_job instead of
> >      amdgpu_fence_process
> > v3: resume the blank line
> >
> > Signed-off-by: Yintian Tao <yttao@amd.com>
> > ---
> >   drivers/gpu/drm/scheduler/sched_main.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
> b/drivers/gpu/drm/scheduler/sched_main.c
> > index a18eabf692e4..8e731ed0d9d9 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -651,7 +651,9 @@ static void drm_sched_process_job(struct 
> dma_fence *f, struct dma_fence_cb *cb)
> >
> >        trace_drm_sched_process_job(s_fence);
> >
> > +     dma_fence_get(&s_fence->finished);
> >        drm_sched_fence_finished(s_fence);
>
>
> If the fence was already released during call to
> drm_sched_fence_finished->dma_fence_signal->... why is it safe to
> reference the s_fence just before that call ? Can't it already be
> released by this time ?
>
> Andrey
>
>
>
> > +     dma_fence_put(&s_fence->finished);
> > wake_up_interruptible(&sched->wake_up_worker);
> >   }
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;sdata=z6ec%2BcWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;reserved=0

--------------0E9BCFC898928B0F3BA1E091
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>This is only for the guilty job which was removed from the
      ring_mirror_list due to completion and hence will not be
      resubmitted by recovery and will not be freed by the usual flow in
      drm_sched_get_cleanup_job (see drm_sched_stop)</p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 3/24/20 10:45 AM, Pan, Xinhui wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          Does this issue occur when gpu recovery?<br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          I just check the code,&nbsp; fence timedout will free job and put
          its fence. but gpu recovery might resubmit job.
          <br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          Correct me if I am wrong.</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Andrey Grodzovsky
            <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, March 24, 2020 11:40:06 AM<br>
            <b>To:</b> Tao, Yintian <a class="moz-txt-link-rfc2396E" href="mailto:Yintian.Tao@amd.com">&lt;Yintian.Tao@amd.com&gt;</a>; Koenig,
            Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher,
            Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: hold the reference
            of finished fence</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText"><br>
                On 3/23/20 10:22 AM, Yintian Tao wrote:<br>
                &gt; There is one one corner case at
                dma_fence_signal_locked<br>
                &gt; which will raise the NULL pointer problem just like
                below.<br>
                &gt; -&gt;dma_fence_signal<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dma_fence_signal_locked<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;test_and_set_bit<br>
                &gt; here trigger dma_fence_release happen due to the
                zero of fence refcount.<br>
                <br>
                <br>
                Did you find out why the zero refcount on the finished
                fence happens <br>
                before the fence was signaled ? The finished fence is
                created with <br>
                refcount set to 1 in
                drm_sched_fence_create-&gt;dma_fence_init and then the <br>
                refcount is decremented in <br>
drm_sched_main-&gt;amdgpu_job_free_cb-&gt;drm_sched_job_cleanup. This
                should <br>
                only happen after fence is already signaled (see <br>
                drm_sched_get_cleanup_job). On top of that the finished
                fence is <br>
                referenced from other places (e.g.
                entity-&gt;last_scheduled e.t.c)...<br>
                <br>
                <br>
                &gt;<br>
                &gt; -&gt;dma_fence_put<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dma_fence_release<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;drm_sched_fence_release_scheduled<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;call_rcu<br>
                &gt; here make the union fled “cb_list” at finished
                fence<br>
                &gt; to NULL because struct rcu_head contains two
                pointer<br>
                &gt; which is same as struct list_head cb_list<br>
                &gt;<br>
                &gt; Therefore, to hold the reference of finished fence
                at drm_sched_process_job<br>
                &gt; to prevent the null pointer during finished fence
                dma_fence_signal<br>
                &gt;<br>
                &gt; [&nbsp; 732.912867] BUG: kernel NULL pointer
                dereference, address: 0000000000000008<br>
                &gt; [&nbsp; 732.914815] #PF: supervisor write access in
                kernel mode<br>
                &gt; [&nbsp; 732.915731] #PF: error_code(0x0002) -
                not-present page<br>
                &gt; [&nbsp; 732.916621] PGD 0 P4D 0<br>
                &gt; [&nbsp; 732.917072] Oops: 0002 [#1] SMP PTI<br>
                &gt; [&nbsp; 732.917682] CPU: 7 PID: 0 Comm: swapper/7
                Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.4.0-rc7 #1<br>
                &gt; [&nbsp; 732.918980] Hardware name: QEMU Standard PC
                (i440FX &#43; PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by
                qemu-project.org 04/01/2014<br>
                &gt; [&nbsp; 732.920906] RIP:
                0010:dma_fence_signal_locked&#43;0x3e/0x100<br>
                &gt; [&nbsp; 732.938569] Call Trace:<br>
                &gt; [&nbsp; 732.939003]&nbsp; &lt;IRQ&gt;<br>
                &gt; [&nbsp; 732.939364]&nbsp; dma_fence_signal&#43;0x29/0x50<br>
                &gt; [&nbsp; 732.940036]&nbsp; drm_sched_fence_finished&#43;0x12/0x20
                [gpu_sched]<br>
                &gt; [&nbsp; 732.940996]&nbsp; drm_sched_process_job&#43;0x34/0xa0
                [gpu_sched]<br>
                &gt; [&nbsp; 732.941910]&nbsp; dma_fence_signal_locked&#43;0x85/0x100<br>
                &gt; [&nbsp; 732.942692]&nbsp; dma_fence_signal&#43;0x29/0x50<br>
                &gt; [&nbsp; 732.943457]&nbsp; amdgpu_fence_process&#43;0x99/0x120
                [amdgpu]<br>
                &gt; [&nbsp; 732.944393]&nbsp;
                sdma_v4_0_process_trap_irq&#43;0x81/0xa0 [amdgpu]<br>
                &gt;<br>
                &gt; v2: hold the finished fence at
                drm_sched_process_job instead of<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_process<br>
                &gt; v3: resume the blank line<br>
                &gt;<br>
                &gt; Signed-off-by: Yintian Tao <a class="moz-txt-link-rfc2396E" href="mailto:yttao@amd.com">&lt;yttao@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 2 &#43;&#43;<br>
                &gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c
                b/drivers/gpu/drm/scheduler/sched_main.c<br>
                &gt; index a18eabf692e4..8e731ed0d9d9 100644<br>
                &gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/scheduler/sched_main.c<br>
                &gt; @@ -651,7 &#43;651,9 @@ static void
                drm_sched_process_job(struct dma_fence *f, struct
                dma_fence_cb *cb)<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_drm_sched_process_job(s_fence);<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_get(&amp;s_fence-&gt;finished);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(s_fence);<br>
                <br>
                <br>
                If the fence was already released during call to <br>
                drm_sched_fence_finished-&gt;dma_fence_signal-&gt;...
                why is it safe to <br>
                reference the s_fence just before that call ? Can't it
                already be <br>
                released by this time ?<br>
                <br>
                Andrey<br>
                <br>
                <br>
                <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(&amp;s_fence-&gt;finished);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                wake_up_interruptible(&amp;sched-&gt;wake_up_worker);<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;amp;sdata=z6ec%2BcWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;amp;sdata=z6ec%2BcWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;amp;reserved=0</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------0E9BCFC898928B0F3BA1E091--

--===============1035603618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1035603618==--
