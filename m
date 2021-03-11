Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202CC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 08:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C016264FA8
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 08:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C016264FA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F326EB2E;
	Thu, 11 Mar 2021 08:53:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBA36EB2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 08:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3mSUqlQYiY5WnIRmja/juUqE1lSv/5hekNWrgMUMU1ocDM+CEBDxlcBkWu9LXbROdwT+tu9uk7GZrPcm6Y/38f/k2pqoLLoOCSjSOdMoFnjkExFbqE4B6Xu63Cjf9bZZQxS/uLw5e9gE5912SqyrTTqAxoSrDu5N/ZVZpUyoSYg8nAqky8r4f3dYCfF88i+Dkv1zbkyR+ZoPhM+LYS7lvUi8Pawnmvwyvo7AfsWQoJq1DFiKbEzUMnTRQfl0G3KYDXbieChIMX6LqrNTc5QPrCQayXgSCthnKEpr1eEmiNQmqVMC1nNovz8xdxfR7zhMXprEURheXtJnB/4i1Ma0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq8hDA5gYz/p05uY1tZu2ZbVe+doLk+XkfMgEWJxQfA=;
 b=XlSOdmXW/6ROcCV39ncZF2G1BEdhQy88Eydatq6j/pUEqa39ynLsvkWtEukeuncIqp1fNurSeJPE/rGSf74iSuz48a89PfCXCpiiXIWmpnKwtnQfbLCYEuc/jlkk+vjOICR2bvx7PqTtUSKGC/y2f+1uN0gs5+rO2GujnYcZh13bKU3RLYj0FEcWM8SRxOxNFTl8VvYWGDdwYwbup1Dnw/8H4C4yCE4L/PKYj5Rl34VZLj0E/i/zgQH1ITbcifKPM0L7cFRIT+IsndLNjxIPzVC4+iBHYYatZfBUFjwcNfkjKxCMItV3+0q6eEyPV0qoqfhex5v+JEJZYxeBur3GIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq8hDA5gYz/p05uY1tZu2ZbVe+doLk+XkfMgEWJxQfA=;
 b=yXPvIn7IFStbkfYLNuUeMCKfg1KNKypcozPqJQwheZ7XeW+Phgh0pR8COT9c8sFtR6YI4wojQcUpW8nfKrWccIGKYL7Euy+JbVLlZAgzUsZD/QP/wzF57LXFdFtpi9qlyvSvFr12lJOiu0hM447T8lJY2N7OXUueweWRv9lHDY0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 08:52:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 08:52:59 +0000
Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20210310133302.933854-1-Jack.Zhang1@amd.com>
 <8c1b4379-6068-e2f4-5994-531d731548de@amd.com>
 <DM5PR1201MB02040D6A57CEFFE820528441BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
 <SN6PR12MB462321467D1D08B5180004D8EA909@SN6PR12MB4623.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a51960fa-b305-e1fc-53e8-c0cf97bbfe38@amd.com>
Date: Thu, 11 Mar 2021 09:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <SN6PR12MB462321467D1D08B5180004D8EA909@SN6PR12MB4623.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e21c:b1e1:cff0:2c70]
X-ClientProxiedBy: AM0PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:208:be::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e21c:b1e1:cff0:2c70]
 (2a02:908:1252:fb60:e21c:b1e1:cff0:2c70) by
 AM0PR04CA0088.eurprd04.prod.outlook.com (2603:10a6:208:be::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 08:52:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d14c1b91-fe58-45ac-03cc-08d8e46b1219
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4206ACFABAF27A200F07E58683909@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TpEyWWY53xIJK7TQMU0Owzqbpd3OoJe6fegMUBcFSqEMrIGKrUtwr8KBuxp5Ls7EtnD4t4OyHB3miDzwDD6woFkLgL4SSCTb/OqlytzLZ7fZ5Lf0Ee7gP6JrCdr49qHn/IP+65wTdZE+/vB7KaA6Ob0vxRCovbpiFE6cUDvDhCNjyAsouz61dHByqGrGSf8sPX736YCrPpaY2BP9SriTL6rfs7DlkjA52nz1kEkC1iuY5+Koy1+VoDYXTV/luqg12XIPvK0VQMY5ICPwzwYBTinP9gKUwYLCIfw96oKkxGLwMJxhoceAI9jduRCA7TWBCglydqwAqN9PMmIH6K25fWr2G2WDkevAUyulUMZrepCwDi8/vxOAYn5GaglIL6Y64JAV2DmeDrOEWZhfCmNQR4167dE8PAb0WAYeL8MSnqzLmbkc64GO8JG4rfoMSWkgFVfT4wSpT+yKgHChDpQeQCwOAbmhpev7plVVLJv+NE/053p8qg8EzDnosXCvouitRFKrCtjG5deCnEPv0AHkQ3f/YvQOjj4yA9xpNz5GT+oAjckB3/2Ffd6/0W/ikGol6phIbb6YSnn43ETbdh/U7avWibhsSrKQbs0Tj/gvnqepS5nyL+H0l8eXxkqAUIpxN2+ZbtuotgOx0WDMGH/wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(316002)(31696002)(83380400001)(36756003)(8936002)(30864003)(6666004)(86362001)(186003)(6486002)(16526019)(31686004)(53546011)(478600001)(5660300002)(66946007)(110136005)(2616005)(66556008)(8676002)(2906002)(66476007)(6636002)(52116002)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?wFoCguyjMkznvW0wSQMnqm1vxjNcrnw/sI58o/YyGKDQrAtsnWM68Mdo?=
 =?Windows-1252?Q?0xyhXBBcjQipZumrUk2FzkK1D7PrGiDjccT1jSYiuR+5wzQ84dH0gGpt?=
 =?Windows-1252?Q?hyEjq7lq6z9a3DJ/yJrTdihwN8NYi3NjhIGtuO7CjzkbRXSNdUYUz3KA?=
 =?Windows-1252?Q?viz2o4hp70YrqnYlqwnaMhlfqKi16JTXo3yNysy8cHdfIifpxv/56COY?=
 =?Windows-1252?Q?mB9EdVH4cPMVvHwbbLmJW1wa5anQt0TsfC9vPo0Wx7ttgejb91FZypZ2?=
 =?Windows-1252?Q?eisqqEDpdNQuOxmAJsdP9JCiBZci7OQUrW4d3wUYAWUX0toOalZ/87i8?=
 =?Windows-1252?Q?oTi0iIlqsQbfh/SG6pCvf69pC0UQhcR1gDSbvcTMLNufiwbITWBLNVNQ?=
 =?Windows-1252?Q?q0Gv0T7sx96Qx4HcWe2xhwB+GFNfXDIKfm42Z1bm5OqdP7tEWWIYig46?=
 =?Windows-1252?Q?AXAsPtLubiaDoDneappTNOMeAM+7HDcSsRjID+54qsTlQCZryE95PFR4?=
 =?Windows-1252?Q?dFm0omoyEbm4Z4vgZvCeTYkRJzWtyYm9o51Ce1CX1+qUDuHa96LcvnOP?=
 =?Windows-1252?Q?3NKduwDR/kSkkXllRf4MfQgiKxHLqTBCwuj4uiKzcslVrqOaoPQm1qSr?=
 =?Windows-1252?Q?yV50/pvBAnE2E9shP+Lz3jSRT4jo4BkVrVuUrqiNeOsAB15kzwX5e4Ex?=
 =?Windows-1252?Q?oAC2Zv6QDmhisuBAaU6YaqPqLoMXDDCJfxGccNqEdZAZJJJgy7ONGRQU?=
 =?Windows-1252?Q?ckD7yzqv4t5vtZRsbjcpR1hjyFY3CHbdQaC334CQOap+DfygfLZVwFuS?=
 =?Windows-1252?Q?2fLyx9cuiHOfJupat590OZi0f/uCJ7A2tDuUw/Tsk4x4MqkLD+/eYrxr?=
 =?Windows-1252?Q?1xgrLQLDI9To2OSVipiad20JFp1TsrTFHmCrTjZilwXxT7t2edxzVZsA?=
 =?Windows-1252?Q?PjvYdxF8vTNigNpntS1nn0ISx4zL0+MN9ViClMx/uGfLDuvNJmlI90Rp?=
 =?Windows-1252?Q?a2diFx2V6H+tM2wS3LK0yShk920xIeshg71BF8Id0Mbz+7bZg1twCj/X?=
 =?Windows-1252?Q?6mRw4w0GZFlprwU4XAugxbc0FGKNFEo3m8QrGUu7cFJ+FmctH0kifZ8F?=
 =?Windows-1252?Q?uzaAHu+vAI0RJAzFTB4imwAVXvLTSAedTnk5c+Wa5ttG11NFoF1fmGVy?=
 =?Windows-1252?Q?Ywcr+MnTP0CERTaQXn1jdzdY7NTy/7sFjRzF0b+hVUAc9vWYCDgmCwYX?=
 =?Windows-1252?Q?Nl+MnxDbjkCu/LA0yXmxmA5ToF/fy5r5OyWtvOJDosAKjmhRZtd1M+KP?=
 =?Windows-1252?Q?r8JzJ8nYYGM2wfKqDZSrt12qVePbA4a3rnUMu9IF2rwXFZkn3QZUFSeS?=
 =?Windows-1252?Q?PPudxbOviqm/q4cgLKoTdU6gxAc0DEVQhYmV3Q5eLslnPwNBfwH308fq?=
 =?Windows-1252?Q?osDJM6PB/m6cnjQwOmwNFCy4iFv3NKADCDvVssYv12/gIeXvguYLYvmT?=
 =?Windows-1252?Q?O4C6xEZC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14c1b91-fe58-45ac-03cc-08d8e46b1219
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 08:52:59.4914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc16GRj+MPkqo1cRwmJ9zCIqcTpnEnJByjz6v7ZaCHaS1Ez4Ksz240zDqE4Cws0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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
Content-Type: multipart/mixed; boundary="===============1442005341=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1442005341==
Content-Type: multipart/alternative;
 boundary="------------BB75EFCED798872F02E5D4A1"
Content-Language: en-US

--------------BB75EFCED798872F02E5D4A1
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Alternatively changing all callers to give MAX_INT as parameter when 
they don't care is the preferred variant, but a bit more work.

Christian.

Am 11.03.21 um 04:24 schrieb Grodzovsky, Andrey:
> You can just rename drm_sched_resubmit_jobs to 
> drm_sched_resubmit_jobs_imp and create a wrapper 
> functiondrm_sched_resubmit_jobs which will call that function with 
> MAX_INT and so no need for code change in other driver will be needed. 
> For amdgpu you call directly drm_sched_resubmit_jobs_imp with 1 and 
> MAX_INT.
>
> Andrey
>
> ------------------------------------------------------------------------
> *From:* Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *Sent:* 10 March 2021 22:05
> *To:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; 
> Deng, Emily <Emily.Deng@amd.com>
> *Subject:* RE: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Andrey,
>
> Thank you for your review.
>
> >> This is identical to drm_sched_resubmit_jobs in all but the 'int 
> max' handling, can't you reuse drm_sched_resubmit_jobs by passing max 
> argument==1 for the find guilty run and then, for the later normal run 
> passing max==MAX_INT to avoid break the iteration to early ?
>
> Due to C language doesn't support function overloading, we couldn’t 
> define function like the following(compiler error):
> void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched, int max 
> = INT_MAX);
>
> We have to rewrite every vender's  code where call the 
> drm_sched_resubmit_jobs if we defined the function like this.
> void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched, int max);
>
> Meanwhile, I also explored the Variable Arguments in C, But it still 
> cannot meet the needs very well.
>
> Do you know some other methods that could help us to make this happen?
> Otherwise, I'm afraid we have to define a separate ways as patch V6 did.
>
> Thanks,
> Jack
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Thursday, March 11, 2021 12:19 AM
> To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; 
> amd-gfx@lists.freedesktop.org; Koenig, Christian 
> <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily 
> <Emily.Deng@amd.com>
> Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode
>
>
>
> On 2021-03-10 8:33 a.m., Jack Zhang wrote:
> > [Why]
> > Previous tdr design treats the first job in job_timeout as the bad job.
> > But sometimes a later bad compute job can block a good gfx job and
> > cause an unexpected gfx job timeout because gfx and compute ring share
> > internal GC HW mutually.
> >
> > [How]
> > This patch implements an advanced tdr mode.It involves an additinal
> > synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
> > step in order to find the real bad job.
> >
> > 1. At Step0 Resubmit stage, it synchronously submits and pends for the
> > first job being signaled. If it gets timeout, we identify it as guilty
> > and do hw reset. After that, we would do the normal resubmit step to
> > resubmit left jobs.
> >
> > 2. Re-insert Bailing job to mirror_list, and leave it to be handled by
> > the main reset thread.
> >
> > 3. For whole gpu reset(vram lost), do resubmit as the old way.
> >
> > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
> >   drivers/gpu/drm/scheduler/sched_main.c     | 75 ++++++++++++++++++++++
> >   include/drm/gpu_scheduler.h                |  2 +
> >   4 files changed, 148 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e247c3a2ec08..dac0a242e5f5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct 
> amdgpu_device *adev,
> >   int i, r = 0;
> >   bool need_emergency_restart = false;
> >   bool audio_suspended = false;
> > +int tmp_vram_lost_counter;
> >
> >   /*
> >    * Special case: RAS triggered and full reset isn't supported @@
> > -4689,9 +4690,14 @@ int amdgpu_device_gpu_recover(struct 
> amdgpu_device *adev,
> >   dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another 
> already in progress",
> >   job ? job->base.id : -1);
> >
> > -/* even we skipped this reset, still need to set the job to guilty */
> > -if (job)
> > +if (job) {
> > +/* re-insert node to avoid memory leak */
> > +spin_lock(&job->base.sched->job_list_lock);
> > +list_add(&job->base.node, &job->base.sched->pending_list);
> > +spin_unlock(&job->base.sched->job_list_lock);
> > +/* even we skipped this reset, still need to set the job to guilty
> > +*/
> >   drm_sched_increase_karma(&job->base);
> > +}
>
> I think this piece should be in a standalone patch as it comes to fix 
> a bug of leaking jobs and not directly related to find actual guilty 
> job. Also, this is not the only place where the problem arises - it 
> also arises in other drivers where they check that guilty job's fence 
> already signaled and bail out before reinsertion of bad job to mirror 
> list. Seems to me better fix would be to handle this within scheduler 
> code by adding specific return value to 
> drm_sched_backend_ops.timedout_job marking that the code terminated 
> early - before calling drm_sched_stop and so drm_sched_job_timedout 
> would know this and then reinsert the job back to mirror_list itself.
>
> >   goto skip_recovery;
> >   }
> >
> > @@ -4788,6 +4794,7 @@ int amdgpu_device_gpu_recover(struct 
> amdgpu_device *adev,
> >   }
> >   }
> >
> > +tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
> >   /* Actual ASIC resets if needed.*/
> >   /* TODO Implement XGMI hive reset logic for SRIOV */
> >   if (amdgpu_sriov_vf(adev)) {
> > @@ -4805,6 +4812,67 @@ int amdgpu_device_gpu_recover(struct 
> amdgpu_device *adev,
> >   /* Post ASIC reset for all devs .*/
> >   list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> >
> > +if (amdgpu_gpu_recovery == 2 &&
> > +!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)))
> > +{
> > +
> > +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> > +struct amdgpu_ring *ring = tmp_adev->rings[i];
> > +int ret = 0;
> > +struct drm_sched_job *s_job;
> > +
> > +if (!ring || !ring->sched.thread)
> > +continue;
> > +
> > +/* No point to resubmit jobs if we didn't HW reset*/
> > +if (!tmp_adev->asic_reset_res && !job_signaled) {
> > +
> > +s_job = list_first_entry_or_null(&ring->sched.pending_list, struct 
> drm_sched_job, list);
> > +if (s_job == NULL)
> > +continue;
> > +
> > +/* clear job's guilty and depend the folowing step to decide the 
> real one */
> > +drm_sched_reset_karma(s_job);
> > +drm_sched_resubmit_jobs2(&ring->sched, 1);
> > +ret = dma_fence_wait_timeout(s_job->s_fence->parent, false,
> > +ring->sched.timeout);
> > +
> > +if (ret == 0) { /* timeout */
> > +DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", 
> ring->sched.name, s_job->id);
> > +/* set guilty */
> > +drm_sched_increase_karma(s_job);
> > +
> > +/* do hw reset */
> > +if (amdgpu_sriov_vf(adev)) {
> > +amdgpu_virt_fini_data_exchange(adev);
> > +r = amdgpu_device_reset_sriov(adev, false);
> > +if (r)
> > +adev->asic_reset_res = r;
> > +} else {
> > +r  = amdgpu_do_asic_reset(hive, device_list_handle, 
> &need_full_reset, false);
> > +if (r && r == -EAGAIN)
> > +goto retry;
> > +}
> > +
> > +/* add reset counter so that the following resubmitted job could 
> flush vmid */
> > +atomic_inc(&tmp_adev->gpu_reset_counter);
> > +continue;
> > +}
> > +
> > +/* got the hw fence, signal finished fence */
> > +atomic_dec(&ring->sched.num_jobs);
> > +dma_fence_get(&s_job->s_fence->finished);
> > +dma_fence_signal(&s_job->s_fence->finished);
> > +dma_fence_put(&s_job->s_fence->finished);
> > +
> > +
> > +/* remove node from list and free the job */
> > +spin_lock(&ring->sched.job_list_lock);
> > +list_del_init(&s_job->node);
> > +spin_unlock(&ring->sched.job_list_lock);
> > +ring->sched.ops->free_job(s_job);
> > +}
> > +}
> > +}
> > +
> >   for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> >   struct amdgpu_ring *ring = tmp_adev->rings[i];
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 865f924772b0..9c3f4edb7532 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, 
> amdgpu_compute_multipipe, int, 0444);
> >    * DOC: gpu_recovery (int)
> >    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). 
> The default is -1 (auto, disabled except SRIOV).
> >    */
> > -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =
> > enable, 0 = disable, -1 = auto)");
> > +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 =
> > +advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
> >   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
> >
> >   /**
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index d82a7ebf6099..340a193b4fb9 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct 
> drm_sched_job *bad)
> >   }
> >   EXPORT_SYMBOL(drm_sched_increase_karma);
> >
> > +
> > +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int
> > +max) {
> > +struct drm_sched_job *s_job, *tmp;
> > +uint64_t guilty_context;
> > +bool found_guilty = false;
> > +struct dma_fence *fence;
> > +int i = 0;
> > +
> > +list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
> > +struct drm_sched_fence *s_fence = s_job->s_fence;
> > +
> > +if (i >= max)
> > +break;
> > +
> > +if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
> > +found_guilty = true;
> > +guilty_context = s_job->s_fence->scheduled.context;
> > +}
> > +
> > +if (found_guilty && s_job->s_fence->scheduled.context == 
> guilty_context)
> > +dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > +
> > +dma_fence_put(s_job->s_fence->parent);
> > +fence = sched->ops->run_job(s_job);
> > +i++;
> > +
> > +if (IS_ERR_OR_NULL(fence)) {
> > +if (IS_ERR(fence))
> > +dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> > +
> > +s_job->s_fence->parent = NULL;
> > +} else {
> > +s_job->s_fence->parent = fence;
> > +}
> > +}
> > +}
> > +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);
>
> This is identical to drm_sched_resubmit_jobs in all but the 'int max' 
> handling, can't you reuse drm_sched_resubmit_jobs by passing max 
> argument==1 for the find guilty run and then, for the later normal run 
> passing max==MAX_INT to avoid break the iteration to early ?
>
> > +
> > +
> > +
> > +void drm_sched_reset_karma(struct drm_sched_job *bad) {
> > +int i;
> > +struct drm_sched_entity *tmp;
> > +struct drm_sched_entity *entity;
> > +struct drm_gpu_scheduler *sched = bad->sched;
> > +
> > +/* don't reset @bad's karma if it's from KERNEL RQ,
> > + * because sometimes GPU hang would cause kernel jobs (like VM 
> updating jobs)
> > + * corrupt but keep in mind that kernel jobs always considered good.
> > + */
> > +if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> > +atomic_set(&bad->karma, 0);
> > +for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> > +     i++) {
> > +struct drm_sched_rq *rq = &sched->sched_rq[i];
> > +
> > +spin_lock(&rq->lock);
> > +list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> > +if (bad->s_fence->scheduled.context ==
> > +entity->fence_context) {
> > +if (entity->guilty)
> > +atomic_set(entity->guilty, 0);
> > +break;
> > +}
> > +}
> > +spin_unlock(&rq->lock);
> > +if (&entity->list != &rq->entities)
> > +break;
> > +}
> > +}
> > +}
> > +EXPORT_SYMBOL(drm_sched_reset_karma);
>
> Same as above, very similar drm_sched_increase_karma, I would add a 
> flag and just reuse code instead of duplucation.
>
> Andrey
>
> > +
> >   /**
> >    * drm_sched_stop - stop the scheduler
> >    *
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index 1c815e0a14ed..01c609149731 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler 
> *sched);
> >   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct 
> drm_sched_job *bad);
> >   void drm_sched_start(struct drm_gpu_scheduler *sched, bool 
> full_recovery);
> >   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> > +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int
> > +max);
> >   void drm_sched_increase_karma(struct drm_sched_job *bad);
> > +void drm_sched_reset_karma(struct drm_sched_job *bad);
> >   bool drm_sched_dependency_optimized(struct dma_fence* fence,
> >       struct drm_sched_entity *entity);
> >   void drm_sched_fault(struct drm_gpu_scheduler *sched);
> >


--------------BB75EFCED798872F02E5D4A1
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    Alternatively changing all callers to give MAX_INT as parameter when
    they don't care is the preferred variant, but a bit more work.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 11.03.21 um 04:24 schrieb
      Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite" cite="mid:SN6PR12MB462321467D1D08B5180004D8EA909@SN6PR12MB4623.namprd12.prod.outlook.com">
      
      <div style="color: rgb(0, 0, 0);"><font face="segoe ui
          westeuropean, segoe ui, helvetica, arial, sans-serif"><span style="font-size: 12pt;">You can just rename
            drm_sched_resubmit_jobs to&nbsp;</span></font><span style="font-family: &quot;Times New Roman&quot;; font-size:
          14.6667px; background-color: rgb(255, 255, 255); display:
          inline !important;">drm_sched_resubmit_jobs_imp and create a
          wrapper function</span><span style="background-color: rgb(255,
          255, 255); display: inline !important;">&nbsp;<span style="font-family: &quot;Times New Roman&quot;; font-size:
            14.6667px; background-color: rgb(255, 255, 255); display:
            inline !important">drm_sched_resubmit_jobs which will call
            that function with MAX_INT and so no need for code change in
            other driver will be needed. For amdgpu you call directly&nbsp;<span style="font-family: &quot;Times New Roman&quot;;
              background-color: rgb(255, 255, 255); display: inline
              !important">drm_sched_resubmit_jobs_imp with 1 and
              MAX_INT.</span></span></span></div>
      <div style="color: rgb(0, 0, 0);"><span style="background-color:
          rgb(255, 255, 255); display: inline !important;"><span style="font-family: &quot;Times New Roman&quot;; font-size:
            14.6667px; background-color: rgb(255, 255, 255); display:
            inline !important"><span style="font-family: &quot;Times New
              Roman&quot;; background-color: rgb(255, 255, 255);
              display: inline !important"><br>
            </span></span></span></div>
      <div style="color: rgb(0, 0, 0);"><span style="background-color:
          rgb(255, 255, 255); display: inline !important;"><span style="font-family: &quot;Times New Roman&quot;; font-size:
            14.6667px; background-color: rgb(255, 255, 255); display:
            inline !important"><span style="font-family: &quot;Times New
              Roman&quot;; background-color: rgb(255, 255, 255);
              display: inline !important">Andrey</span></span></span></div>
      <div><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Zhang,
          Jack (Jian) <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
          <b>Sent:</b> 10 March 2021 22:05<br>
          <b>To:</b> Grodzovsky, Andrey
          <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Koenig, Christian
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Liu, Monk
          <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Deng, Emily
          <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
          <b>Subject:</b> RE: [PATCH v6] drm/amd/amdgpu implement tdr
          advanced mode</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="3" face="Times New Roman"><span style="font-size:12pt;"><a name="BM_BEGIN" moz-do-not-send="true"></a>
            <div><font size="2"><span style="font-size:11pt;">[AMD
                  Official Use Only - Internal Distribution Only]<br>
                  <br>
                  Hi, Andrey,<br>
                  <br>
                  Thank you for your review.<br>
                  <br>
                  &gt;&gt; This is identical to drm_sched_resubmit_jobs
                  in all but the 'int max' handling, can't you reuse
                  drm_sched_resubmit_jobs by passing max argument==1 for
                  the find guilty run and then, for the later normal run
                  passing max==MAX_INT to avoid break the iteration to
                  early ?<br>
                  <br>
                  Due to C language doesn't support function
                  overloading, we couldn’t define function like the
                  following(compiler error):<br>
                  void drm_sched_resubmit_jobs(struct drm_gpu_scheduler
                  *sched, int max = INT_MAX);<br>
                  <br>
                  We have to rewrite every vender's&nbsp; code where call the
                  drm_sched_resubmit_jobs if we defined the function
                  like this.<br>
                  void drm_sched_resubmit_jobs(struct drm_gpu_scheduler
                  *sched, int max);<br>
                  <br>
                  Meanwhile, I also explored the Variable Arguments in
                  C, But it still cannot meet the needs very well.<br>
                  <br>
                  Do you know some other methods that could help us to
                  make this happen?<br>
                  Otherwise, I'm afraid we have to define a separate
                  ways as patch V6 did.<br>
                  <br>
                  Thanks,<br>
                  Jack<br>
                  <br>
                  -----Original Message-----<br>
                  From: Grodzovsky, Andrey
                  <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
                  Sent: Thursday, March 11, 2021 12:19 AM<br>
                  To: Zhang, Jack (Jian) <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Liu, Monk
                  <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Deng, Emily
                  <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
                  Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr
                  advanced mode<br>
                  <br>
                  <br>
                  <br>
                  On 2021-03-10 8:33 a.m., Jack Zhang wrote:<br>
                  &gt; [Why]<br>
                  &gt; Previous tdr design treats the first job in
                  job_timeout as the bad job.<br>
                  &gt; But sometimes a later bad compute job can block a
                  good gfx job and<br>
                  &gt; cause an unexpected gfx job timeout because gfx
                  and compute ring share<br>
                  &gt; internal GC HW mutually.<br>
                  &gt;<br>
                  &gt; [How]<br>
                  &gt; This patch implements an advanced tdr mode.It
                  involves an additinal<br>
                  &gt; synchronous pre-resubmit step(Step0 Resubmit)
                  before normal resubmit<br>
                  &gt; step in order to find the real bad job.<br>
                  &gt;<br>
                  &gt; 1. At Step0 Resubmit stage, it synchronously
                  submits and pends for the<br>
                  &gt; first job being signaled. If it gets timeout, we
                  identify it as guilty<br>
                  &gt; and do hw reset. After that, we would do the
                  normal resubmit step to<br>
                  &gt; resubmit left jobs.<br>
                  &gt;<br>
                  &gt; 2. Re-insert Bailing job to mirror_list, and
                  leave it to be handled by<br>
                  &gt; the main reset thread.<br>
                  &gt;<br>
                  &gt; 3. For whole gpu reset(vram lost), do resubmit as
                  the old way.<br>
                  &gt;<br>
                  &gt; Signed-off-by: Jack Zhang
                  <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                  &gt; ---<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72
                  ++++++++++++++++++++-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; |&nbsp; 2
                  +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&nbsp; | 75
                  ++++++++++++++++++++++<br>
                  &gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2
                  +<br>
                  &gt;&nbsp;&nbsp; 4 files changed, 148 insertions(+), 3
                  deletions(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; index e247c3a2ec08..dac0a242e5f5 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; @@ -4639,6 +4639,7 @@ int
                  amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                  &gt;&nbsp;&nbsp; int i, r = 0;<br>
                  &gt;&nbsp;&nbsp; bool need_emergency_restart = false;<br>
                  &gt;&nbsp;&nbsp; bool audio_suspended = false;<br>
                  &gt; +int tmp_vram_lost_counter;<br>
                  &gt;<br>
                  &gt;&nbsp;&nbsp; /*<br>
                  &gt;&nbsp;&nbsp;&nbsp; * Special case: RAS triggered and full reset
                  isn't supported @@<br>
                  &gt; -4689,9 +4690,14 @@ int
                  amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                  &gt;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Bailing on TDR for
                  s_job:%llx, as another already in progress&quot;,<br>
                  &gt;&nbsp;&nbsp; job ? job-&gt;base.id : -1);<br>
                  &gt;<br>
                  &gt; -/* even we skipped this reset, still need to set
                  the job to guilty */<br>
                  &gt; -if (job)<br>
                  &gt; +if (job) {<br>
                  &gt; +/* re-insert node to avoid memory leak */<br>
                  &gt;
                  +spin_lock(&amp;job-&gt;base.sched-&gt;job_list_lock);<br>
                  &gt; +list_add(&amp;job-&gt;base.node,
                  &amp;job-&gt;base.sched-&gt;pending_list);<br>
                  &gt;
                  +spin_unlock(&amp;job-&gt;base.sched-&gt;job_list_lock);<br>
                  &gt; +/* even we skipped this reset, still need to set
                  the job to guilty<br>
                  &gt; +*/<br>
                  &gt;&nbsp;&nbsp; drm_sched_increase_karma(&amp;job-&gt;base);<br>
                  &gt; +}<br>
                  <br>
                  I think this piece should be in a standalone patch as
                  it comes to fix a bug of leaking jobs and not directly
                  related to find actual guilty job. Also, this is not
                  the only place where the problem arises - it also
                  arises in other drivers where they check that guilty
                  job's fence already signaled and bail out before
                  reinsertion of bad job to mirror list. Seems to me
                  better fix would be to handle this within scheduler
                  code by adding specific return value to
                  drm_sched_backend_ops.timedout_job marking that the
                  code terminated early - before calling drm_sched_stop
                  and so drm_sched_job_timedout would know this and then
                  reinsert the job back to mirror_list itself.<br>
                  <br>
                  &gt;&nbsp;&nbsp; goto skip_recovery;<br>
                  &gt;&nbsp;&nbsp; }<br>
                  &gt;<br>
                  &gt; @@ -4788,6 +4794,7 @@ int
                  amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                  &gt;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp; }<br>
                  &gt;<br>
                  &gt; +tmp_vram_lost_counter =
                  atomic_read(&amp;((adev)-&gt;vram_lost_counter));<br>
                  &gt;&nbsp;&nbsp; /* Actual ASIC resets if needed.*/<br>
                  &gt;&nbsp;&nbsp; /* TODO Implement XGMI hive reset logic for
                  SRIOV */<br>
                  &gt;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
                  &gt; @@ -4805,6 +4812,67 @@ int
                  amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                  &gt;&nbsp;&nbsp; /* Post ASIC reset for all devs .*/<br>
                  &gt;&nbsp;&nbsp; list_for_each_entry(tmp_adev,
                  device_list_handle, gmc.xgmi.head) {<br>
                  &gt;<br>
                  &gt; +if (amdgpu_gpu_recovery == 2 &amp;&amp;<br>
                  &gt; +!(tmp_vram_lost_counter &lt;
                  atomic_read(&amp;adev-&gt;vram_lost_counter)))<br>
                  &gt; +{<br>
                  &gt; +<br>
                  &gt; +for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                  &gt; +struct amdgpu_ring *ring =
                  tmp_adev-&gt;rings[i];<br>
                  &gt; +int ret = 0;<br>
                  &gt; +struct drm_sched_job *s_job;<br>
                  &gt; +<br>
                  &gt; +if (!ring || !ring-&gt;sched.thread)<br>
                  &gt; +continue;<br>
                  &gt; +<br>
                  &gt; +/* No point to resubmit jobs if we didn't HW
                  reset*/<br>
                  &gt; +if (!tmp_adev-&gt;asic_reset_res &amp;&amp;
                  !job_signaled) {<br>
                  &gt; +<br>
                  &gt; +s_job =
                  list_first_entry_or_null(&amp;ring-&gt;sched.pending_list,
                  struct drm_sched_job, list);<br>
                  &gt; +if (s_job == NULL)<br>
                  &gt; +continue;<br>
                  &gt; +<br>
                  &gt; +/* clear job's guilty and depend the folowing
                  step to decide the real one */<br>
                  &gt; +drm_sched_reset_karma(s_job);<br>
                  &gt; +drm_sched_resubmit_jobs2(&amp;ring-&gt;sched,
                  1);<br>
                  &gt; +ret =
                  dma_fence_wait_timeout(s_job-&gt;s_fence-&gt;parent,
                  false,<br>
                  &gt; +ring-&gt;sched.timeout);<br>
                  &gt; +<br>
                  &gt; +if (ret == 0) { /* timeout */<br>
                  &gt; +DRM_ERROR(&quot;Found the real bad job! ring:%s,
                  job_id:%llx\n&quot;, ring-&gt;sched.name, s_job-&gt;id);<br>
                  &gt; +/* set guilty */<br>
                  &gt; +drm_sched_increase_karma(s_job);<br>
                  &gt; +<br>
                  &gt; +/* do hw reset */<br>
                  &gt; +if (amdgpu_sriov_vf(adev)) {<br>
                  &gt; +amdgpu_virt_fini_data_exchange(adev);<br>
                  &gt; +r = amdgpu_device_reset_sriov(adev, false);<br>
                  &gt; +if (r)<br>
                  &gt; +adev-&gt;asic_reset_res = r;<br>
                  &gt; +} else {<br>
                  &gt; +r&nbsp; = amdgpu_do_asic_reset(hive,
                  device_list_handle, &amp;need_full_reset, false);<br>
                  &gt; +if (r &amp;&amp; r == -EAGAIN)<br>
                  &gt; +goto retry;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +/* add reset counter so that the following
                  resubmitted job could flush vmid */<br>
                  &gt; +atomic_inc(&amp;tmp_adev-&gt;gpu_reset_counter);<br>
                  &gt; +continue;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +/* got the hw fence, signal finished fence */<br>
                  &gt; +atomic_dec(&amp;ring-&gt;sched.num_jobs);<br>
                  &gt;
                  +dma_fence_get(&amp;s_job-&gt;s_fence-&gt;finished);<br>
                  &gt;
                  +dma_fence_signal(&amp;s_job-&gt;s_fence-&gt;finished);<br>
                  &gt;
                  +dma_fence_put(&amp;s_job-&gt;s_fence-&gt;finished);<br>
                  &gt; +<br>
                  &gt; +<br>
                  &gt; +/* remove node from list and free the job */<br>
                  &gt; +spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
                  &gt; +list_del_init(&amp;s_job-&gt;node);<br>
                  &gt; +spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
                  &gt; +ring-&gt;sched.ops-&gt;free_job(s_job);<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                  &gt;&nbsp;&nbsp; struct amdgpu_ring *ring =
                  tmp_adev-&gt;rings[i];<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt; index 865f924772b0..9c3f4edb7532 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt; @@ -509,7 +509,7 @@
                  module_param_named(compute_multipipe,
                  amdgpu_compute_multipipe, int, 0444);<br>
                  &gt;&nbsp;&nbsp;&nbsp; * DOC: gpu_recovery (int)<br>
                  &gt;&nbsp;&nbsp;&nbsp; * Set to enable GPU recovery mechanism (1 =
                  enable, 0 = disable). The default is -1 (auto,
                  disabled except SRIOV).<br>
                  &gt;&nbsp;&nbsp;&nbsp; */<br>
                  &gt; -MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU
                  recovery mechanism, (1 =<br>
                  &gt; enable, 0 = disable, -1 = auto)&quot;);<br>
                  &gt; +MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU
                  recovery mechanism, (2 =<br>
                  &gt; +advanced tdr mode, 1 = enable, 0 = disable, -1 =
                  auto)&quot;);<br>
                  &gt;&nbsp;&nbsp; module_param_named(gpu_recovery,
                  amdgpu_gpu_recovery, int, 0444);<br>
                  &gt;<br>
                  &gt;&nbsp;&nbsp; /**<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; b/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; index d82a7ebf6099..340a193b4fb9 100644<br>
                  &gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
                  &gt; @@ -395,6 +395,81 @@ void
                  drm_sched_increase_karma(struct drm_sched_job *bad)<br>
                  &gt;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
                  &gt;<br>
                  &gt; +<br>
                  &gt; +void drm_sched_resubmit_jobs2(struct
                  drm_gpu_scheduler *sched, int<br>
                  &gt; +max) {<br>
                  &gt; +struct drm_sched_job *s_job, *tmp;<br>
                  &gt; +uint64_t guilty_context;<br>
                  &gt; +bool found_guilty = false;<br>
                  &gt; +struct dma_fence *fence;<br>
                  &gt; +int i = 0;<br>
                  &gt; +<br>
                  &gt; +list_for_each_entry_safe(s_job, tmp,
                  &amp;sched-&gt;pending_list, list) {<br>
                  &gt; +struct drm_sched_fence *s_fence =
                  s_job-&gt;s_fence;<br>
                  &gt; +<br>
                  &gt; +if (i &gt;= max)<br>
                  &gt; +break;<br>
                  &gt; +<br>
                  &gt; +if (!found_guilty &amp;&amp;
                  atomic_read(&amp;s_job-&gt;karma) &gt;
                  sched-&gt;hang_limit) {<br>
                  &gt; +found_guilty = true;<br>
                  &gt; +guilty_context =
                  s_job-&gt;s_fence-&gt;scheduled.context;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +if (found_guilty &amp;&amp;
                  s_job-&gt;s_fence-&gt;scheduled.context ==
                  guilty_context)<br>
                  &gt; +dma_fence_set_error(&amp;s_fence-&gt;finished,
                  -ECANCELED);<br>
                  &gt; +<br>
                  &gt; +dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
                  &gt; +fence = sched-&gt;ops-&gt;run_job(s_job);<br>
                  &gt; +i++;<br>
                  &gt; +<br>
                  &gt; +if (IS_ERR_OR_NULL(fence)) {<br>
                  &gt; +if (IS_ERR(fence))<br>
                  &gt; +dma_fence_set_error(&amp;s_fence-&gt;finished,
                  PTR_ERR(fence));<br>
                  &gt; +<br>
                  &gt; +s_job-&gt;s_fence-&gt;parent = NULL;<br>
                  &gt; +} else {<br>
                  &gt; +s_job-&gt;s_fence-&gt;parent = fence;<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);<br>
                  <br>
                  This is identical to drm_sched_resubmit_jobs in all
                  but the 'int max' handling, can't you reuse
                  drm_sched_resubmit_jobs by passing max argument==1 for
                  the find guilty run and then, for the later normal run
                  passing max==MAX_INT to avoid break the iteration to
                  early ?<br>
                  <br>
                  &gt; +<br>
                  &gt; +<br>
                  &gt; +<br>
                  &gt; +void drm_sched_reset_karma(struct drm_sched_job
                  *bad) {<br>
                  &gt; +int i;<br>
                  &gt; +struct drm_sched_entity *tmp;<br>
                  &gt; +struct drm_sched_entity *entity;<br>
                  &gt; +struct drm_gpu_scheduler *sched = bad-&gt;sched;<br>
                  &gt; +<br>
                  &gt; +/* don't reset @bad's karma if it's from KERNEL
                  RQ,<br>
                  &gt; + * because sometimes GPU hang would cause kernel
                  jobs (like VM updating jobs)<br>
                  &gt; + * corrupt but keep in mind that kernel jobs
                  always considered good.<br>
                  &gt; + */<br>
                  &gt; +if (bad-&gt;s_priority !=
                  DRM_SCHED_PRIORITY_KERNEL) {<br>
                  &gt; +atomic_set(&amp;bad-&gt;karma, 0);<br>
                  &gt; +for (i = DRM_SCHED_PRIORITY_MIN; i &lt;
                  DRM_SCHED_PRIORITY_KERNEL;<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
                  &gt; +struct drm_sched_rq *rq =
                  &amp;sched-&gt;sched_rq[i];<br>
                  &gt; +<br>
                  &gt; +spin_lock(&amp;rq-&gt;lock);<br>
                  &gt; +list_for_each_entry_safe(entity, tmp,
                  &amp;rq-&gt;entities, list) {<br>
                  &gt; +if (bad-&gt;s_fence-&gt;scheduled.context ==<br>
                  &gt; +entity-&gt;fence_context) {<br>
                  &gt; +if (entity-&gt;guilty)<br>
                  &gt; +atomic_set(entity-&gt;guilty, 0);<br>
                  &gt; +break;<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +spin_unlock(&amp;rq-&gt;lock);<br>
                  &gt; +if (&amp;entity-&gt;list !=
                  &amp;rq-&gt;entities)<br>
                  &gt; +break;<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +}<br>
                  &gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
                  <br>
                  Same as above, very similar drm_sched_increase_karma,
                  I would add a flag and just reuse code instead of
                  duplucation.<br>
                  <br>
                  Andrey<br>
                  <br>
                  &gt; +<br>
                  &gt;&nbsp;&nbsp; /**<br>
                  &gt;&nbsp;&nbsp;&nbsp; * drm_sched_stop - stop the scheduler<br>
                  &gt;&nbsp;&nbsp;&nbsp; *<br>
                  &gt; diff --git a/include/drm/gpu_scheduler.h
                  b/include/drm/gpu_scheduler.h<br>
                  &gt; index 1c815e0a14ed..01c609149731 100644<br>
                  &gt; --- a/include/drm/gpu_scheduler.h<br>
                  &gt; +++ b/include/drm/gpu_scheduler.h<br>
                  &gt; @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct
                  drm_gpu_scheduler *sched);<br>
                  &gt;&nbsp;&nbsp; void drm_sched_stop(struct drm_gpu_scheduler
                  *sched, struct drm_sched_job *bad);<br>
                  &gt;&nbsp;&nbsp; void drm_sched_start(struct drm_gpu_scheduler
                  *sched, bool full_recovery);<br>
                  &gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct
                  drm_gpu_scheduler *sched);<br>
                  &gt; +void drm_sched_resubmit_jobs2(struct
                  drm_gpu_scheduler *sched, int<br>
                  &gt; +max);<br>
                  &gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct
                  drm_sched_job *bad);<br>
                  &gt; +void drm_sched_reset_karma(struct drm_sched_job
                  *bad);<br>
                  &gt;&nbsp;&nbsp; bool drm_sched_dependency_optimized(struct
                  dma_fence* fence,<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity);<br>
                  &gt;&nbsp;&nbsp; void drm_sched_fault(struct drm_gpu_scheduler
                  *sched);<br>
                  &gt;<br>
                </span></font></div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------BB75EFCED798872F02E5D4A1--

--===============1442005341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1442005341==--
