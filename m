Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 09:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962C1207BC
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2dHLY2D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962C1207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC146E8AA;
	Fri, 29 May 2020 09:05:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103D76E8AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 09:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6bJYVKOoxjECMU8LSks0N2nnBq6usn/r/ngbeG9jU4FoPPq+6NU/ettfgtw5W2DPc/hxLPCSC6cIuRdCEuVTuSHm+QgWEKmUMsiia29MO7xUjVrvAKMv19IFF9UIubFk1VamOH+SjQYFiM2WVi/o01/UBu/PYtkRWdPGzbq92NgpeQg2g7KhylTR2ngWgHVFbt88OJd+fHGsX3WkW5c+XXbOxhMtZoCLKf57c5uB+kfLxEhGNgv1KXsdjOSUmHp+680+52M/MRNB0CUEDrvhxuviARdujYX7g0WTJX7/8l4g3DtuqA55upeJx1+VM3Gh0NePBd9FR3/tR01JgLwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDpWHvgDfdYHk+sBQgYO/GxRNfcSv4Mt25KUHFtrbn8=;
 b=OFswtwB01slzM48ApXiYbeKnPZ91d41UhAw8hqe5Z04TxmCi+/NcHTVLQ/SRpI2DXwqcWthCfPU4Acj1EK4iKWEu8NRsq6FgUl3Pya5UIl5YXRSh6lTNxKdcg5F7WLCgaY2f7TBbjqJmwHcEE56ZG1g5MF1aAKl2tdZM2gvNdFCSJ0m4H5f9w8Q3gmKXRFaRviDetB7bfYLGEbSD3quuItsfR5g98woZJC6lUKWcgY16JcNlbBTgmX5ajWyzfWl8QDoCTqSBd/nlX+cDr4UUGFcpbQFTQgG85wbncY5Mdck71rNnD36mwfX8k/T2clseobIvj0SfUPiEC1Z54a1SZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDpWHvgDfdYHk+sBQgYO/GxRNfcSv4Mt25KUHFtrbn8=;
 b=2dHLY2D1slrTxTxgE7oxnZ4G9ZLDkOR3E20Qb0U5cVfDeM2yRMCT+LaSAlpC4j4jlwciqA8yqu5TIwjjs6OpSAczCu6H+ViScysmBCvPeQYvGY3yjwyDL2RMcoDOksCOIiY7zAmUo1wbqP+9fFIcAOQCmx1Gs+D1ClT7pN4g4VI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 09:05:45 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 09:05:45 +0000
Subject: Re: amdgpu doesn't do implicit sync, requires drivers to do it in IBs
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
 <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
 <1b4cc0a0-b690-3f54-d983-76975fe788bf@gmail.com>
 <e2f2843b-db9f-bba3-1925-55af2a68432d@daenzer.net>
 <1adb6ee4-7472-fa3e-fd67-6e5c6668cbc3@amd.com>
 <CAAxE2A4-5RT==eUzsO+jciucJ1t1aw+Fb=zoi9YB9q2fz1ZaSQ@mail.gmail.com>
 <c352b59e-b0ba-390d-f532-71c0380760e4@amd.com>
 <CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4+w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <52ef44a6-b7e3-73e9-fb70-5c9470274373@amd.com>
Date: Fri, 29 May 2020 11:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4+w@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 09:05:44 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ee3b256-7704-4212-a19a-08d803af7890
X-MS-TrafficTypeDiagnostic: DM6PR12MB3067:
X-Microsoft-Antispam-PRVS: <DM6PR12MB306781B928EFD57E4E7AA926838F0@DM6PR12MB3067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sd4EicEgLow5/KoOZC1zMGcOz0mhteOaHD6I9GImzSwWG0W5CNmU+aMjL0UM/ykI7qVDbxp2hAcnCS15VV02MnIPzsowqtLcywfZlwl8I2pM7zzH1W7M8hiyOx2agZ5UPZLGR8eYa4gpCcbqbLX3eIb+z8WQJNswHxkMTkNMwLHhwsoRNt9/OTPGyhTCsx5xurD+7tbyZuqiW6RTYs8rMdyBylcYY24y+HBE/baK7ZHbL8XhXWuU8v4F6SjEYsV0ztXe8OBu5wvu+8YdmsbYZis81aFooGYFhVsiK+/9tbucLTPPQoMvQCngc86RIRqsfJWlyHo1nJjMlCcFosjs1uOHqs/pIgK9xxW17S0lSXerxLSLAbLrnqInYLdGKoW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(316002)(8936002)(54906003)(5660300002)(2616005)(8676002)(66476007)(2906002)(6486002)(66946007)(66556008)(66574014)(31696002)(36756003)(86362001)(6666004)(31686004)(4326008)(83380400001)(6916009)(186003)(53546011)(478600001)(33964004)(52116002)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ni6lRv1tMWROT4cLPRfCHujMYUXaOLQdv3fPqT89BEMnzO2Ir4ZKmSqeAEoTEJNSll5wGtXONXu5k40E7OLEzZkNHCmcT13s1AjiP3cT/Wy2szcGN52+T66Pb8NcB1oKiyuV6h++Mcqdkq03d9TBJc8Z28Q/2yIlHrbTHzt1r8hMT49R3A7e87nbg/WXT2Jm4TyGrohREWH2aTJjZ7xc/6chbCyhwQEHnZto4QnuSALKTMDoaU+4+BP4i0Kvp2sXOWAo5BgoUuUYNOn42LAnMTxRRBNKUl+boh9HpMK81fNh+9fWmrvVFlRUorHLnd70+0k+LCliNd3H4+KRQ0j6/wA+awvPijkPAdvadB/dt8vYZTBxcTDgLzyk5duoL60FUa1WV7w8mMMG17M2crky0dpMC6PSm/hQ6RNMwMpeSDDCohmTIIixEARviZCSPuxaA/pzu4g69LSHxl8GvxEdGI5TSCc5KhVKTuB0UjIaAL/xZF5Ls4z1QMNBWR95smAW/R443FGiIbVZ2O6J8GpBMgvBHce+eIPgVxBjaaQqcJTRgClhm4brrdGeGhEWhubI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee3b256-7704-4212-a19a-08d803af7890
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 09:05:45.1263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+6MqEyJ2de9StHFi4GQvJAEu09EC5OcaCPKYktMYsqAXtsYm0AReDzYKzMpA5nd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
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
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/mixed; boundary="===============1332264012=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1332264012==
Content-Type: multipart/alternative;
 boundary="------------99E46E7E857283D074691B96"
Content-Language: en-US

--------------99E46E7E857283D074691B96
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.05.20 um 21:35 schrieb Marek Olšák:
> On Thu, May 28, 2020 at 2:12 PM Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Am 28.05.20 um 18:06 schrieb Marek Olšák:
>>     On Thu, May 28, 2020 at 10:40 AM Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Am 28.05.20 um 12:06 schrieb Michel Dänzer:
>>         > On 2020-05-28 11:11 a.m., Christian König wrote:
>>         >> Well we still need implicit sync [...]
>>         > Yeah, this isn't about "we don't want implicit sync", it's
>>         about "amdgpu
>>         > doesn't ensure later jobs fully see the effects of previous
>>         implicitly
>>         > synced jobs", requiring userspace to do pessimistic flushing.
>>
>>         Yes, exactly that.
>>
>>         For the background: We also do this flushing for explicit
>>         syncs. And
>>         when this was implemented 2-3 years ago we first did the
>>         flushing for
>>         implicit sync as well.
>>
>>         That was immediately reverted and then implemented
>>         differently because
>>         it caused severe performance problems in some use cases.
>>
>>         I'm not sure of the root cause of this performance problems. My
>>         assumption was always that we then insert to many pipeline
>>         syncs, but
>>         Marek doesn't seem to think it could be that.
>>
>>         On the one hand I'm rather keen to remove the extra handling
>>         and just
>>         always use the explicit handling for everything because it
>>         simplifies
>>         the kernel code quite a bit. On the other hand I don't want
>>         to run into
>>         this performance problem again.
>>
>>         Additional to that what the kernel does is a "full" pipeline
>>         sync, e.g.
>>         we busy wait for the full hardware pipeline to drain. That
>>         might be
>>         overkill if you just want to do some flushing so that the
>>         next shader
>>         sees the stuff written, but I'm not an expert on that.
>>
>>
>>     Do we busy-wait on the CPU or in WAIT_REG_MEM?
>>
>>     WAIT_REG_MEM is what UMDs do and should be faster.
>
>     We use WAIT_REG_MEM to wait for an EOP fence value to reach memory.
>
>     We use this for a couple of things, especially to make sure that
>     the hardware is idle before changing VMID to page table associations.
>
>     What about your idea of having an extra dw in the shared BOs
>     indicating that they are flushed?
>
>     As far as I understand it an EOS or other event might be
>     sufficient for the caches as well. And you could insert the
>     WAIT_REG_MEM directly before the first draw using the texture and
>     not before the whole IB.
>
>     Could be that we can optimize this even more than what we do in
>     the kernel.
>
>     Christian.
>
>
> Adding fences into BOs would be bad, because all UMDs would have to 
> handle them.

Yeah, already assumed that this is the biggest blocker.

> Is it possible to do this in the ring buffer:
> if (fence_signalled) {
>    indirect_buffer(dependent_IB);
>    indirect_buffer(other_IB);
> } else {
>    indirect_buffer(other_IB);
>    wait_reg_mem(fence);
>    indirect_buffer(dependent_IB);
> }

That's maybe possible, but at least not easily implementable.

> Or we might have to wait for a hw scheduler.

I'm still fine doing the pipeline sync for implicit sync as well, I just 
need somebody to confirm me that this doesn't backfire in some case.

>
> Does the kernel sync when the driver fd is different, or when the 
> context is different?

Only when the driver fd is different.

Christian.

>
> Marek


--------------99E46E7E857283D074691B96
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 28.05.20 um 21:35 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4&#43;w@mail.gmail.com">
      
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Thu, May 28, 2020 at 2:12
            PM Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div bgcolor="#FFFFFF">
              <div>Am 28.05.20 um 18:06 schrieb Marek Olšák:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Thu, May 28,
                      2020 at 10:40 AM Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class="gmail_quote" style="margin:0px
                      0px 0px 0.8ex;border-left:1px solid
                      rgb(204,204,204);padding-left:1ex">Am 28.05.20 um
                      12:06 schrieb Michel Dänzer:<br>
                      &gt; On 2020-05-28 11:11 a.m., Christian König
                      wrote:<br>
                      &gt;&gt; Well we still need implicit sync [...]<br>
                      &gt; Yeah, this isn't about &quot;we don't want
                      implicit sync&quot;, it's about &quot;amdgpu<br>
                      &gt; doesn't ensure later jobs fully see the
                      effects of previous implicitly<br>
                      &gt; synced jobs&quot;, requiring userspace to do
                      pessimistic flushing.<br>
                      <br>
                      Yes, exactly that.<br>
                      <br>
                      For the background: We also do this flushing for
                      explicit syncs. And <br>
                      when this was implemented 2-3 years ago we first
                      did the flushing for <br>
                      implicit sync as well.<br>
                      <br>
                      That was immediately reverted and then implemented
                      differently because <br>
                      it caused severe performance problems in some use
                      cases.<br>
                      <br>
                      I'm not sure of the root cause of this performance
                      problems. My <br>
                      assumption was always that we then insert to many
                      pipeline syncs, but <br>
                      Marek doesn't seem to think it could be that.<br>
                      <br>
                      On the one hand I'm rather keen to remove the
                      extra handling and just <br>
                      always use the explicit handling for everything
                      because it simplifies <br>
                      the kernel code quite a bit. On the other hand I
                      don't want to run into <br>
                      this performance problem again.<br>
                      <br>
                      Additional to that what the kernel does is a
                      &quot;full&quot; pipeline sync, e.g. <br>
                      we busy wait for the full hardware pipeline to
                      drain. That might be <br>
                      overkill if you just want to do some flushing so
                      that the next shader <br>
                      sees the stuff written, but I'm not an expert on
                      that.<br>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>Do we busy-wait on the CPU or in WAIT_REG_MEM?</div>
                    <div><br>
                    </div>
                    <div>WAIT_REG_MEM is what UMDs do and should be
                      faster.</div>
                  </div>
                </div>
              </blockquote>
              <br>
              We use WAIT_REG_MEM to wait for an EOP fence value to
              reach memory.<br>
              <br>
              We use this for a couple of things, especially to make
              sure that the hardware is idle before changing VMID to
              page table associations.<br>
              <br>
              What about your idea of having an extra dw in the shared
              BOs indicating that they are flushed?<br>
              <br>
              As far as I understand it an EOS or other event might be
              sufficient for the caches as well. And you could insert
              the WAIT_REG_MEM directly before the first draw using the
              texture and not before the whole IB.<br>
              <br>
              Could be that we can optimize this even more than what we
              do in the kernel.<br>
              <br>
              Christian.<br>
            </div>
          </blockquote>
          <div><br>
          </div>
          Adding fences into BOs would be bad, because all UMDs would
          have to handle them.</div>
      </div>
    </blockquote>
    <br>
    Yeah, already assumed that this is the biggest blocker.<br>
    <br>
    <blockquote type="cite" cite="mid:CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4&#43;w@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">Is it possible to do this in the ring
          buffer:</div>
        <div class="gmail_quote">if (fence_signalled) {</div>
        <div class="gmail_quote">
          <div class="gmail_quote">&nbsp;&nbsp; indirect_buffer(dependent_IB);<br>
          </div>
          &nbsp;&nbsp; indirect_buffer(other_IB);<br>
        </div>
        <div class="gmail_quote">} else {</div>
        <div class="gmail_quote">&nbsp;&nbsp; indirect_buffer(other_IB);</div>
        <div class="gmail_quote">&nbsp;&nbsp; wait_reg_mem(fence);<br>
        </div>
        <div class="gmail_quote">&nbsp;&nbsp; indirect_buffer(dependent_IB);<br>
        </div>
        }</div>
    </blockquote>
    <br>
    That's maybe possible, but at least not easily implementable.<br>
    <br>
    <blockquote type="cite" cite="mid:CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4&#43;w@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">Or we might have to wait for a hw
          scheduler.<br>
        </div>
      </div>
    </blockquote>
    <br>
    I'm still fine doing the pipeline sync for implicit sync as well, I
    just need somebody to confirm me that this doesn't backfire in some
    case.<br>
    <br>
    <blockquote type="cite" cite="mid:CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4&#43;w@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote"><br>
        </div>
        <div class="gmail_quote">
          <div class="gmail_quote">Does the kernel sync when the driver
            fd is different, or when the context is different?</div>
        </div>
      </div>
    </blockquote>
    <br>
    Only when the driver fd is different.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4&#43;w@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div class="gmail_quote"><br>
          </div>
        </div>
        <div class="gmail_quote">Marek<br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------99E46E7E857283D074691B96--

--===============1332264012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1332264012==--
