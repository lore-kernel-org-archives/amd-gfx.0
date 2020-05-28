Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97302C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 18:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64855207D3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LiwYfNBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64855207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6CD6E18E;
	Thu, 28 May 2020 18:12:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138F76E5CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 18:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTfnhxZktBIgGDuE+/LdOjWonj2aQ/QN/zz+vET/zd3SAZqjF/p8dj5aHDoQvUtDqXHJ2GAH/oDacTHdILcC+tSk4o6Gd8US8LGX/gTSa2txw16tv6iYgtNgBdwhsG6gu3VXwAfkgn+oDTkJ3SquGx8lNtUKWIc3kBiaYIyQoJDdMzYZ5baz397/WhNLCNEBM2aeRpc1qm8Y5p5hzPQEWXJp+YfCcA6xHg+Tfd0i92RW7HNmEbPM/vvbc3qN26XFY0pDlWlwdiWREI4qf9sWdhyZOyKtCizzGoMNkelk36TB4fPtzvovxC1mgU3CtblfMFVinXaFa8nZSfNx7v1ZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8SZFJwAMvXi5TAenXYObqYDD6WYHxK6BciSYQxtGxU=;
 b=Cq3aICilvrW50P5pv/g4qeoLi3rOIcVstMKKTRyXtIrUxZS5LNufH0E9dIWsfPbjlm4XTZE7wQf45RYZDse2+9UmGESxtRggMCW1hr9CQ2FLzSkyCmIuQPTep0OlfSBPuB2DvDKls3D7WpXHKaVC5d4cw+QV4Q2sz5TZwReUtW8ZqHIv3UBOqv/+M71H4pCYhGUzB3CnHpqeoBbxSkTvDJr9RfH9Wl//OAhIzyJQLSbgAVR/9iQu6YgRZ69bkAjQb3yGCAgHTRWxsu8nxjR5VgdUWXLCzKUK1xo/+3N99cHCPU/ASX9k9FtVlaCMC54u3fAP3My3n6eIIE67UYxTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8SZFJwAMvXi5TAenXYObqYDD6WYHxK6BciSYQxtGxU=;
 b=LiwYfNBToMgpkQnENPY2AG6ZX/aQSwUTL41qQLQvDBkMaPrUpyHH7D6fjtewBS4nvsYU5RCpy/Kv8y7gxxx9jhhbzXwEZKewmtqWQwyk8u1ckEztdXZ0ykX8bpLdxqmZcEKNTTlF9B+OIfVYnzj1B84YK88ZceZ1e3K8HjZi82Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Thu, 28 May
 2020 18:12:20 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 18:12:20 +0000
Subject: Re: amdgpu doesn't do implicit sync, requires drivers to do it in IBs
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
 <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
 <1b4cc0a0-b690-3f54-d983-76975fe788bf@gmail.com>
 <e2f2843b-db9f-bba3-1925-55af2a68432d@daenzer.net>
 <1adb6ee4-7472-fa3e-fd67-6e5c6668cbc3@amd.com>
 <CAAxE2A4-5RT==eUzsO+jciucJ1t1aw+Fb=zoi9YB9q2fz1ZaSQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c352b59e-b0ba-390d-f532-71c0380760e4@amd.com>
Date: Thu, 28 May 2020 20:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAAxE2A4-5RT==eUzsO+jciucJ1t1aw+Fb=zoi9YB9q2fz1ZaSQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 18:12:18 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1be6a4b9-bc09-4179-cb8d-08d80332a958
X-MS-TrafficTypeDiagnostic: DM6PR12MB3753:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3753C64DC5FF81D823712A42838E0@DM6PR12MB3753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUBsYZDT0UqM0vQ+MO2xcOuSFpGZVb93Y4dmJAfDiK1aW595Ih1HgjpspxK6ivqhOhr5Ah/jdjeqMQUufd8QQvFFUkbGt42uWNP/kuC1qEOionwkg1ohfdq6sn+8mzWw+tnJN+o5pzSWn8SyRBKhzbtfJ85Fb/WYn7rYl8kW9FsHgjbKiymrEK6gncCPEIjZyI1r3p3tt8JbA2479eq5t3ELfynDvSkZfW/8xNM75nTWkPdcDqiub9QeJ07IVUAbywdY+HfdSq9cPlnyF6sjhcOHe8hMOb+mozgcti5UaWIIbLcLSxHsPVocM6sQsqsrgl9pyRki1WkFeUHLmwCbcODOPJMKXwDhsNbqEL6DVCnVpRtHlDTitmb76Yz/1ZDy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(54906003)(66556008)(66476007)(66946007)(8676002)(4326008)(31696002)(2906002)(316002)(86362001)(83380400001)(36756003)(478600001)(6666004)(6916009)(6486002)(2616005)(8936002)(186003)(52116002)(33964004)(31686004)(53546011)(16526019)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LUWMXSi2JPd3kHgXVT/C4EhKkVHT/trbT2/c1a9chdgyIyhlDU6TEzB6pdCxwKH7xumZVCxsFREgQG54sP3vDvMB5FvWXAD+sceZt2qW57YC0DPb/F70OShBxzR8TGg4CDoQaqqCX0saRLZU3GRt/5Cwh95zh63ZP40rmCwFL/3gT0dM/hzbAtOr+yHzyMfq/x64nuyrzzFF2iJ55S+WNBJ1BXopHtth6+5GO4TheOco7th8o2/mmicALjEVID7Qnj1xxWBmcc4bVCoRQGNLv5EjQhbJk5NhtP8F+B1zBkEIZgUwz+Azu8/3wetT+46aIQXZBTflaojDbGPWT+lkkCD39ce0YHanoewS4ldftEJPltfalk6lgJt7iEFau8qpkQ5CnX1QhNxQMQkxkSLZLvjN+TF4e35iYebtpgMbaWnXzMJPV3+206HON0wH33iVM/L3ZahqCMZaDjKgwBVM+FlH+CJC3fGCReMnTvDi0PJnvVaeuVEV6wVt75aLEQ7oSW2rddWgZsgKvknj5H0s/QAZ5mxjmJLv0lCigT3wOi1QOBxhx44W5BIj1e+/NX17
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be6a4b9-bc09-4179-cb8d-08d80332a958
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 18:12:20.0090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lb/9VUSN8qXtOU8PtWrKu8uZ1DonOrt111S15000Jb57PLvAAwi99mkQ/OpIn5s2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
Content-Type: multipart/mixed; boundary="===============0184641879=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0184641879==
Content-Type: multipart/alternative;
 boundary="------------D2AA2E412AC36998B25B5C3E"
Content-Language: en-US

--------------D2AA2E412AC36998B25B5C3E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.05.20 um 18:06 schrieb Marek Olšák:
> On Thu, May 28, 2020 at 10:40 AM Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Am 28.05.20 um 12:06 schrieb Michel Dänzer:
>     > On 2020-05-28 11:11 a.m., Christian König wrote:
>     >> Well we still need implicit sync [...]
>     > Yeah, this isn't about "we don't want implicit sync", it's about
>     "amdgpu
>     > doesn't ensure later jobs fully see the effects of previous
>     implicitly
>     > synced jobs", requiring userspace to do pessimistic flushing.
>
>     Yes, exactly that.
>
>     For the background: We also do this flushing for explicit syncs. And
>     when this was implemented 2-3 years ago we first did the flushing for
>     implicit sync as well.
>
>     That was immediately reverted and then implemented differently
>     because
>     it caused severe performance problems in some use cases.
>
>     I'm not sure of the root cause of this performance problems. My
>     assumption was always that we then insert to many pipeline syncs, but
>     Marek doesn't seem to think it could be that.
>
>     On the one hand I'm rather keen to remove the extra handling and just
>     always use the explicit handling for everything because it simplifies
>     the kernel code quite a bit. On the other hand I don't want to run
>     into
>     this performance problem again.
>
>     Additional to that what the kernel does is a "full" pipeline sync,
>     e.g.
>     we busy wait for the full hardware pipeline to drain. That might be
>     overkill if you just want to do some flushing so that the next shader
>     sees the stuff written, but I'm not an expert on that.
>
>
> Do we busy-wait on the CPU or in WAIT_REG_MEM?
>
> WAIT_REG_MEM is what UMDs do and should be faster.

We use WAIT_REG_MEM to wait for an EOP fence value to reach memory.

We use this for a couple of things, especially to make sure that the 
hardware is idle before changing VMID to page table associations.

What about your idea of having an extra dw in the shared BOs indicating 
that they are flushed?

As far as I understand it an EOS or other event might be sufficient for 
the caches as well. And you could insert the WAIT_REG_MEM directly 
before the first draw using the texture and not before the whole IB.

Could be that we can optimize this even more than what we do in the kernel.

Christian.

>
> Marek


--------------D2AA2E412AC36998B25B5C3E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 28.05.20 um 18:06 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A4-5RT==eUzsO&#43;jciucJ1t1aw&#43;Fb=zoi9YB9q2fz1ZaSQ@mail.gmail.com">
      
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Thu, May 28, 2020 at
            10:40 AM Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Am 28.05.20 um 12:06
            schrieb Michel Dänzer:<br>
            &gt; On 2020-05-28 11:11 a.m., Christian König wrote:<br>
            &gt;&gt; Well we still need implicit sync [...]<br>
            &gt; Yeah, this isn't about &quot;we don't want implicit sync&quot;,
            it's about &quot;amdgpu<br>
            &gt; doesn't ensure later jobs fully see the effects of
            previous implicitly<br>
            &gt; synced jobs&quot;, requiring userspace to do pessimistic
            flushing.<br>
            <br>
            Yes, exactly that.<br>
            <br>
            For the background: We also do this flushing for explicit
            syncs. And <br>
            when this was implemented 2-3 years ago we first did the
            flushing for <br>
            implicit sync as well.<br>
            <br>
            That was immediately reverted and then implemented
            differently because <br>
            it caused severe performance problems in some use cases.<br>
            <br>
            I'm not sure of the root cause of this performance problems.
            My <br>
            assumption was always that we then insert to many pipeline
            syncs, but <br>
            Marek doesn't seem to think it could be that.<br>
            <br>
            On the one hand I'm rather keen to remove the extra handling
            and just <br>
            always use the explicit handling for everything because it
            simplifies <br>
            the kernel code quite a bit. On the other hand I don't want
            to run into <br>
            this performance problem again.<br>
            <br>
            Additional to that what the kernel does is a &quot;full&quot; pipeline
            sync, e.g. <br>
            we busy wait for the full hardware pipeline to drain. That
            might be <br>
            overkill if you just want to do some flushing so that the
            next shader <br>
            sees the stuff written, but I'm not an expert on that.<br>
          </blockquote>
          <div><br>
          </div>
          <div>Do we busy-wait on the CPU or in WAIT_REG_MEM?</div>
          <div><br>
          </div>
          <div>WAIT_REG_MEM is what UMDs do and should be faster.</div>
        </div>
      </div>
    </blockquote>
    <br>
    We use WAIT_REG_MEM to wait for an EOP fence value to reach memory.<br>
    <br>
    We use this for a couple of things, especially to make sure that the
    hardware is idle before changing VMID to page table associations.<br>
    <br>
    What about your idea of having an extra dw in the shared BOs
    indicating that they are flushed?<br>
    <br>
    As far as I understand it an EOS or other event might be sufficient
    for the caches as well. And you could insert the WAIT_REG_MEM
    directly before the first draw using the texture and not before the
    whole IB.<br>
    <br>
    Could be that we can optimize this even more than what we do in the
    kernel.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CAAxE2A4-5RT==eUzsO&#43;jciucJ1t1aw&#43;Fb=zoi9YB9q2fz1ZaSQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Marek</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------D2AA2E412AC36998B25B5C3E--

--===============0184641879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0184641879==--
