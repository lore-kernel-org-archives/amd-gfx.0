Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E6C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6082076E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="llvkHO/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6082076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC41989F77;
	Fri, 20 Mar 2020 14:47:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690074.outbound.protection.outlook.com [40.107.69.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C499889F77
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGLGzKldRG428M/bnzsE6zkTLl3XjBPmf6UERK5UnwTDCtxwNNoHXAi/nIM9gQ0NE7KDvPRZx/BPlZyoD4TfieO3k1hfaD6c0sRawiuhateNPY1PPFgyfA36rvILT2tP1TfKjg/IbFLOvNumDy87oiGcPLwhWeZZJXkNHWyQi+qFmplTeweJuIMkIoZIht3ZF6st5/CA1cWWjaEgOk+6KIHMXdLJkbDWrS+cu9NxXstZ7FCU8J6G467Oku9EMGDlE48UcAtmGgBlZkQ0ronCcTeHzNOhYz3Sfzp1ZGyy+OTHSbX7aJySGOZZbFhb2Rc+aUGFjBGiqMeP1vFEWgyVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ3CHfkRR8HVczlJ6ZVGjsv4D368DAqr3AmNQ1279Xk=;
 b=DUDqdWNYRG3yQVG7kawyxddLDDSPUZhfksok3QQ6bs5RdzQhfymHNDTleIXmfaASTn6yC0g0uRWvyoXlOgrq0+2Xq6u2nY2vMEH+0CYCqBBraGvMv9qEkVpbd1ScpKYCzvQwkn8jri3Knwy8K6Qe6LK1xwkjoJJS3BzRhM1yLHp9h3QTBDEmMlRqiyr9alKh3o4Piac5Oo/vay2Yqx6CRG4+EWJstotyRNnnLi6JFNcR66b3KpkY2h5ECwLCiEE5gUwzCiSc5F1eqLfflS/3P6tmqJ8TrGXuxpvOemcPgAypXD5nX8l4tyl81AShFNlwsAZAte/z4xT2KDMwKXvbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ3CHfkRR8HVczlJ6ZVGjsv4D368DAqr3AmNQ1279Xk=;
 b=llvkHO/vMLvBiij5EKTiWLtWaGVhDjt9Mlr2SoSz02e3qWEGrHDZ0vumVPJOgTaGt6xVga76d+vcjUuBJlzamd0bALkYqbeRHDZOL29aKHl3OoS6ZtCLk4UHlPXLtBiNFArqa9gfMyw9c3ivaBcm6Kp50G9pELGyg4cKxQ34ZNU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 14:47:35 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d%5]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 14:47:35 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200320002245.14932-1-alex.sierra@amd.com>
 <MN2PR12MB4488EFB20868482AC55D3C14F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
 <50a79ebd-ab45-927b-a44d-dba313a72953@amd.com>
 <MN2PR12MB4488D6A91C88D614166D13A1F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2a397de2-db82-40ed-9009-fdc38783590d@amd.com>
Date: Fri, 20 Mar 2020 10:47:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <MN2PR12MB4488D6A91C88D614166D13A1F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.21] (142.116.63.128) by
 YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.17 via Frontend Transport; Fri, 20 Mar 2020 14:47:35 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b5a5547-e0aa-4e9b-2747-08d7ccdda0b8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:|DM5PR1201MB0204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02046A697AC5F792DCA969D692F50@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(19627405001)(33964004)(86362001)(53546011)(52116002)(316002)(2616005)(30864003)(16576012)(110136005)(44832011)(956004)(31696002)(966005)(6486002)(16526019)(478600001)(8676002)(81166006)(81156014)(8936002)(45080400002)(6666004)(36756003)(31686004)(66556008)(186003)(66476007)(66946007)(26005)(2906002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0204;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toiza/dDq45pgtxL4/fxag8U2Rv3zuwrTu9kmryLFZkV0cIEgN74vNac3PxGn+C0hXggG3nO/RPQDkmjqYF2hhGuyJ1dDJ5nPFU8F7P/6cXdOr8JdNFVqoVLrCrnDkYvIXG+PbOa7RATQtf2wVf3HPG+GuJXTtgnWCw4oYrsemECK/eV7nfZ/qxxJpe07h0I0tuvYVu+KqHxFLRkJOtgFSVFwXuR+NztchuZ9yO2ArKK5izsAbrgoRE/uwOyHFlR6bmXiAYhRUJ4ZKu9YKZlmzXzaP9cQ51fJPePwKFEdEC25e1jbYH/jVdTpTvuN8GQ+1Ew/TE3gupjYR5vnzNjg7H67GSoI2O8Xv37v1ZFmbqhmsTMoCoz5xuxuqTOfxrtkbhqwznOUoiI86KBtSadE3GxCByS0ZE8qoyS6ABUYL/YMPEPMbNmQXeu0h109G1JW0vLu7nCM6KcXycUlD/NOltr1DCejRaNpfNPvOK4o/U=
X-MS-Exchange-AntiSpam-MessageData: dqqKYuvglvC/OFbF2hx9uABhpph+/ffS/MFmnMUnYJCXQyEgdo86xQ7gBVubKCYp2AReiG2w1w8AGPqRlRlugHbr+0HFBLWnS8f38qeOvr6c6e43HlHn0ki/qcVZNGdLN+uQ72U/fkNf/1QK54rjoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5a5547-e0aa-4e9b-2747-08d7ccdda0b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:47:35.4705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBXNk66CNJkDu+VJi24kohSR71tV8xgqx+okhvc1shGCH1H6HX3B2isyF9YKuvLTz/5q+PWkPS2RYgWlIlaG7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
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
Content-Type: multipart/mixed; boundary="===============2012656587=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2012656587==
Content-Type: multipart/alternative;
 boundary="------------9B68D8F21F8A31A503ECA7AB"
Content-Language: en-US

--------------9B68D8F21F8A31A503ECA7AB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020-03-20 10:39, Deucher, Alexander wrote:
>
> [AMD Public Use]
>
>
> I'm worried we'll miss a register by accident.  We went with per IP 
> sub drivers to avoid handling complexities around IP differences if 
> possible.  Also the scheme seems like kind of a one off compared to 
> what we do for other IPs.  Can we structure it more like how we handle 
> SDMA instancing since it seems to mainly affect IH RB instances?

That's more or less what I had in mind, but haven't looked at the SDMA 
implementation in detail. So do you mean defining macros 
WREG32_IH_RING(ring, offset, value) and RREG32_IH_RING(ring, offset) 
analogous to WREG32_SDMA and RREG32_SDMA? It would only apply to IH 
ring-specific registers. Not to other general IH registers.


Regards,
   Felix


>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Friday, March 20, 2020 10:20 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
> Alejandro (Alex) <Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss 
> ring offsets
> On 2020-03-20 10:06, Deucher, Alexander wrote:
>>
>> [AMD Public Use]
>>
>>
>> This seems kind of complicated and error prone.  I didn't realize the 
>> extent to the changes required.  I think it would be better to either 
>> add arcturus specific versions of these functions or just go with 
>> your original approach and add a new arcturus_ih.c.  If you go with 
>> the second route however, no need to show all your intermediate 
>> steps, just add the new files in one commit.
>
> Hi Alex,
>
>
> I suggested the approach in this patch series since to minimize code 
> duplication and maintain readability of the code. I don't think it's 
> very error prone. I believe this is more maintainable than a separate 
> arcturus_ih.c. I'll have some more specific comments on Alejandro's 
> patches.
>
>
> Regards,
>   Felix
>
>
>>
>> Alex
>>
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> 
>> <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex 
>> Sierra <alex.sierra@amd.com> <mailto:alex.sierra@amd.com>
>> *Sent:* Thursday, March 19, 2020 8:22 PM
>> *To:* amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com> 
>> <mailto:Alex.Sierra@amd.com>
>> *Subject:* [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring 
>> offsets
>> Arcturus and vega10 share the same vega10_ih, however both
>> have different register offsets at the ih ring section.
>> This variable is used to help calculate ih ring register addresses
>> from the osssys, that corresponds to the current asic type.
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com> 
>> <mailto:alex.sierra@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 5ed4227f304b..fa384ae9a9bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -279,6 +279,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>> amdgpu_hotplug_work_func);
>>          }
>>
>> +       if (adev->asic_type == CHIP_ARCTURUS)
>> +               adev->irq.ring_stride = 1;
>> +       else
>> +               adev->irq.ring_stride = 0;
>>          INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
>>          INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> index c718e94a55c9..1ec5b735cd9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> @@ -97,6 +97,7 @@ struct amdgpu_irq {
>>          struct irq_domain               *domain; /* GPU irq 
>> controller domain */
>>          unsigned virq[AMDGPU_MAX_IRQ_SRC_ID];
>>          uint32_t srbm_soft_reset;
>> +       unsigned ring_stride;
>>  };
>>
>>  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202606831789803&amp;sdata=B%2BbtLEKN5A65OEp8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;reserved=0 
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=0>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp;sdata=bil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;reserved=0

--------------9B68D8F21F8A31A503ECA7AB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020-03-20 10:39, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB4488D6A91C88D614166D13A1F7F50@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I'm worried we'll miss a register by accident.&nbsp; We went with
          per IP sub drivers to avoid handling complexities around IP
          differences if possible.&nbsp; Also the scheme seems like kind of a
          one off compared to what we do for other IPs.&nbsp; Can we
          structure it more like how we handle SDMA instancing since it
          seems to mainly affect IH RB instances?&nbsp; <br>
        </div>
      </div>
    </blockquote>
    <p>That's more or less what I had in mind, but haven't looked at the
      SDMA implementation in detail. So do you mean defining macros
      WREG32_IH_RING(ring, offset, value) and RREG32_IH_RING(ring,
      offset) analogous to WREG32_SDMA and RREG32_SDMA? It would only
      apply to IH ring-specific registers. Not to other general IH
      registers.<br>
    </p>
    <p><br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB4488D6A91C88D614166D13A1F7F50@MN2PR12MB4488.namprd12.prod.outlook.com">
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, March 20, 2020 10:20 AM<br>
            <b>To:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sierra Guiza, Alejandro
            (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 1/4] drm/amdgpu: add stride to
            calculate oss ring offsets</font>
          <div>&nbsp;</div>
        </div>
        <div>
          <div class="x_moz-cite-prefix">On 2020-03-20 10:06, Deucher,
            Alexander wrote:<br>
          </div>
          <blockquote type="cite">
            <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
            <p style="font-family:Arial; font-size:10pt; color:#317100;
              margin:15pt" align="Left">
              [AMD Public Use]<br>
            </p>
            <br>
            <div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                This seems kind of complicated and error prone.&nbsp; I
                didn't realize the extent to the changes required.&nbsp; I
                think it would be better to either add arcturus specific
                versions of these functions or just go with your
                original approach and add a new arcturus_ih.c.&nbsp; If you
                go with the second route however, no need to show all
                your intermediate steps, just add the new files in one
                commit.</div>
            </div>
          </blockquote>
          <p>Hi Alex,</p>
          <p><br>
          </p>
          <p>I suggested the approach in this patch series since to
            minimize code duplication and maintain readability of the
            code. I don't think it's very error prone. I believe this is
            more maintainable than a separate arcturus_ih.c. I'll have
            some more specific comments on Alejandro's patches.</p>
          <p><br>
          </p>
          <p>Regards,<br>
            &nbsp; Felix<br>
          </p>
          <p><br>
          </p>
          <blockquote type="cite">
            <div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Alex</div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                &nbsp; <br>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> amd-gfx
                  <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
                  behalf of Alex Sierra <a class="x_moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com" moz-do-not-send="true">
                    &lt;alex.sierra@amd.com&gt;</a><br>
                  <b>Sent:</b> Thursday, March 19, 2020 8:22 PM<br>
                  <b>To:</b> <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Cc:</b> Sierra Guiza, Alejandro (Alex) <a class="x_moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com" moz-do-not-send="true">
                    &lt;Alex.Sierra@amd.com&gt;</a><br>
                  <b>Subject:</b> [PATCH 1/4] drm/amdgpu: add stride to
                  calculate oss ring offsets</font>
                <div>&nbsp;</div>
              </div>
              <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                    <div class="x_PlainText">Arcturus and vega10 share
                      the same vega10_ih, however both<br>
                      have different register offsets at the ih ring
                      section.<br>
                      This variable is used to help calculate ih ring
                      register addresses<br>
                      from the osssys, that corresponds to the current
                      asic type.<br>
                      <br>
                      Signed-off-by: Alex Sierra <a class="x_moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com" moz-do-not-send="true">
                        &lt;alex.sierra@amd.com&gt;</a><br>
                      ---<br>
                      &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 &#43;&#43;&#43;&#43;<br>
                      &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 &#43;<br>
                      &nbsp;2 files changed, 5 insertions(&#43;)<br>
                      <br>
                      diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
                      index 5ed4227f304b..fa384ae9a9bc 100644<br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
                      &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
                      @@ -279,6 &#43;279,10 @@ int amdgpu_irq_init(struct
                      amdgpu_device *adev)<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      amdgpu_hotplug_work_func);<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &nbsp;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type == CHIP_ARCTURUS)<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ring_stride = 1;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ring_stride = 0;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;irq.ih1_work,
                      amdgpu_irq_handle_ih1);<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;irq.ih2_work,
                      amdgpu_irq_handle_ih2);<br>
                      &nbsp;<br>
                      diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
                      index c718e94a55c9..1ec5b735cd9e 100644<br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
                      &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
                      @@ -97,6 &#43;97,7 @@ struct amdgpu_irq {<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_domain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *domain;
                      /* GPU irq controller domain */<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      virq[AMDGPU_MAX_IRQ_SRC_ID];<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      srbm_soft_reset;<br>
                      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      ring_stride;<br>
                      &nbsp;};<br>
                      &nbsp;<br>
                      &nbsp;void amdgpu_irq_disable_all(struct amdgpu_device
                      *adev);<br>
                      -- <br>
                      2.17.1<br>
                      <br>
                      _______________________________________________<br>
                      amd-gfx mailing list<br>
                      <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                      <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="RpptISRMfKBBZP2h2HOxGfxgMoH70rCb&#43;ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUmDwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr&#43;uSoF6bz83ifpZaF1KhW4RGW4V&#43;rHlh2VDoaZ45h4=" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202606831789803&amp;amp;sdata=B%2BbtLEKN5A65OEp8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;amp;reser
 ved=0</a><br>
                    </div>
                  </span></font></div>
            </div>
            <br>
            <fieldset class="x_mimeAttachmentHeader"></fieldset>
            <pre class="x_moz-quote-pre">_______________________________________________
amd-gfx mailing list
<a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="x_moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp;amp;sdata=bil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp;amp;sdata=bil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;amp;reserved=0</a>
</pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------9B68D8F21F8A31A503ECA7AB--

--===============2012656587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2012656587==--
