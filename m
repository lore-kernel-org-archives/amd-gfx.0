Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1693C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 15:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC67820665
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 15:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC67820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A6B6E312;
	Wed, 27 Nov 2019 15:02:10 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700073.outbound.protection.outlook.com [40.107.70.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2846E312
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 15:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC6QHwDsbHID2Q3+tEY3m5KKkEWTGgm143GM0BDbbQzkLGtDU3kbqy5EO/MWOsLb+WImX90KztOjpziPoT6ywxH/ZKVLN5GfPdJCbkM/09upSlKh6B/9Q/XWnlB+JIEeMf0aUC2VT6wwFcyc3ASduIF9nkwnz/tjV1siDZp18urBt6Kr5GbOhpEKo2pj9jKx6Khvvo/wK2fG55NZb7Q7ShyZnH6iJRYfSv5NtY8uHyfXszfFsANP+BbXHeQrY1ET1/3VzcnC3JncEtfh1KSBWzoEer9t3+gVHtjAkGuyEOfG3E63k3eIe//5to95VYt62DpKw2hpFALy0vKGdISq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZUMdmUZfKTnHtwJokQc+21k/VlnHvamIZuY4NDnP4k=;
 b=jLQYChvD1JnpKt1/zZ/qUUiWWjm2lds4mbVmDWxpD/jjYTk12wyQMJkBwSP9ikcrEWpJ+sN16VeLcmRlP5gCO46xZxv2YoPuZ5d0PkMx07gj9BzhWTmeb8RaVuTwbJrJTEHj1HajculNrhVsTMH1JYK0oT9XC1ubgfQhD/0s8Vy9dXjMKuAXwZsyrqqtJtiWK6xY4w9MUnBr/YkooMpa4q0rl/JmIe9hSQsRnmVm1AuwsUO7vWq+3GP2m7cStb7hU89PffjRj7U1k+Q0Xq1jmnrq058VL+v3Q8TZ6//WG0QlVv97sLu1WQj8OZlH2mVeoFR7BJGrGSpp2jhujQPmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2407.namprd12.prod.outlook.com (52.132.141.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 27 Nov 2019 15:02:07 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 15:02:07 +0000
Subject: Re: Deadlock on PTEs update for HMM
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <10b23ec2-f91e-51db-6d31-ba8a654e78bb@amd.com>
Date: Wed, 27 Nov 2019 16:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0116.eurprd07.prod.outlook.com
 (2603:10a6:207:7::26) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfdedce3-5b6d-483f-2a5e-08d7734ac54b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2407:|DM5PR12MB2407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24072BBA1A2717F878E1D4F583440@DM5PR12MB2407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(51874003)(189003)(199004)(31696002)(81156014)(37036004)(66556008)(66476007)(186003)(46003)(16586007)(8676002)(236005)(6512007)(6486002)(14454004)(8936002)(110136005)(6636002)(14444005)(66946007)(76176011)(386003)(6506007)(65956001)(316002)(33964004)(52116002)(65806001)(478600001)(31686004)(4326008)(2616005)(54896002)(6666004)(36756003)(81166006)(229853002)(6116002)(11346002)(58126008)(71190400001)(25786009)(790700001)(446003)(5660300002)(99286004)(7736002)(86362001)(6246003)(2906002)(6436002)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2407;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1rwVLboRi60zJ0qjnNhs6CU18txpGpbJHVuHAyZz2w45DVAxms10dXUWnnR03fYMj+z7Ig0vbUwPU03Ec1gbSwNfeog1qpsTwrl/zV1pzihMAJd9l+9Dc4+4BSKNEZ3NjwFMdAuFn9Si6CDuoBFJE+aNOEecerjhPbpKw5k+leauM5hDhCsIO8BWw1dTO2niare4TmFicnslkyqmieaHcR1Jmaviy5IINsoGKn7NSzrs6pDYKOgASKdSbnb9H722nXz9vYEIKn3rekw5fz4BHl53W+kEBukgaW8HGQ+vPfyPFzprbC5h9xUiR7ahw7L5E4wT9rKuUS7r5mLiZ5oQY9OyCg1jdn57fmEF30NvU5F9xwOIj5561/1JkRdBNu1c0jvGRjmxYJ4PeQmyTOQrkeukmP+YcjgiOLaQ/B+ke4YlnNPWo/Trf0joajO0T9I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdedce3-5b6d-483f-2a5e-08d7734ac54b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 15:02:07.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2uzwszUKIm774Wlmyd481wtFiAOhkhnqXhTvUGp3ptSN8LkCdxLQSAKoz07PkdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZUMdmUZfKTnHtwJokQc+21k/VlnHvamIZuY4NDnP4k=;
 b=FwVkjCJrpMwC0SZ7fA2kHCHTFMOQfF6sN8lcy11ENXcYsqaovIcktCQZNFUXIWE0stopEoI3LisURmIN4wEdayDZ5e5prCvV5Gxo+6QxWk6th0lBd1Z+4X2jNHMi36K7RytIQYUEtq/0fbwQMFcFkbWVpcY14654CY7k5/rhV0s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0874596129=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127150200.FLWTVOVONVT8K-YWVqsgWjJAaXC8Lle4pVCPFsuOaMU@z>

--===============0874596129==
Content-Type: multipart/alternative;
 boundary="------------71D9C9EA1D2E0834E3097FCF"
Content-Language: en-US

--------------71D9C9EA1D2E0834E3097FCF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alejandro,

yes I'm very aware of this issue, but unfortunately can't give an easy 
solution either.

I'm working for over a year now on getting this fixed, but unfortunately 
it turned out that this problem is much bigger than initially thought.

Setting the appropriate GFP flags for the job allocation is actually the 
trivial part.

The really really hard thing is that we somehow need to add a lock to 
prevent the page tables from being evicted. And as you also figured out 
that lock can't be taken easily anywhere else.

I've already wrote a prototype for this, but didn't had time to hammer 
it into shape for upstreaming yet.

Regards,
Christian.

Am 27.11.19 um 15:55 schrieb Sierra Guiza, Alejandro (Alex):
>
> Hi Christian,
>
> As you know, we’re working on the HMM enablement. Im working on the 
> dGPU page table entries invalidation on the userptr mapping case. 
> Currently, the MMU notifiers handle stops all user mode queues, 
> schedule a delayed worker to re-validate userptr mappings and restart 
> the queues.
>
> Part of the HMM functionality, we need to invalidate the page table 
> entries instead of stopping the queues. At the same time we need to 
> move the revalidation of the userptr mappings into the page fault handler.
>
> We’re seeing a deadlock warning after we try to invalidate the PTEs 
> inside the MMU notifier handler. More specific, when we try to update 
> the BOs to invalidate PTEs using amdgpu_vm_bo_update. This uses 
> kmalloc on the amdgpu_job_alloc which seems to be causing this problem.
>
> Based on @Kuehling, Felix <mailto:Felix.Kuehling@amd.com> comments, 
> kmalloc without any special flags can cause memory reclaim. Doing that 
> inside an MMU notifier is problematic, because an MMU notifier may be 
> called inside a memory-reclaim operation itself. That would result in 
> recursion. Also, reclaim shouldn't be done while holding a lock that 
> can be taken in an MMU notifier for the same reason. If you cause a 
> reclaim while holding that lock, then an MMU notifier called by the 
> reclaim can deadlock trying to take the same lock.
>
> Please let us know if you have any advice to enable this the right way
>
> Thanks in advanced,
>
> Alejandro
>


--------------71D9C9EA1D2E0834E3097FCF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Alejandro,<br>
      <br>
      yes I'm very aware of this issue, but unfortunately can't give an
      easy solution either.<br>
      <br>
      I'm working for over a year now on getting this fixed, but
      unfortunately it turned out that this problem is much bigger than
      initially thought.<br>
      <br>
      Setting the appropriate GFP flags for the job allocation is
      actually the trivial part.<br>
      <br>
      The really really hard thing is that we somehow need to add a lock
      to prevent the page tables from being evicted. And as you also
      figured out that lock can't be taken easily anywhere else.<br>
      <br>
      I've already wrote a prototype for this, but didn't had time to
      hammer it into shape for upstreaming yet.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 27.11.19 um 15:55 schrieb Sierra Guiza, Alejandro (Alex):<br>
    </div>
    <blockquote type="cite" cite="mid:SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:106%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">Hi Christian,<o:p></o:p></p>
        <p class="MsoNormal">As you know, we’re working on the HMM
          enablement. Im working on the dGPU page table entries
          invalidation on the userptr mapping case. Currently, the MMU
          notifiers handle stops all user mode queues, schedule a
          delayed worker to re-validate userptr mappings and restart the
          queues. <o:p></o:p></p>
        <p class="MsoNormal">Part of the HMM functionality, we need to
          invalidate the page table entries instead of stopping the
          queues. At the same time we need to move the revalidation of
          the userptr mappings into the page fault handler.<o:p></o:p></p>
        <p class="MsoNormal">We’re seeing a deadlock warning after we
          try to invalidate the PTEs inside the MMU notifier handler.
          More specific, when we try to update the BOs to invalidate
          PTEs using amdgpu_vm_bo_update. This uses kmalloc on the
          amdgpu_job_alloc which seems to be causing this problem.<o:p></o:p></p>
        <p class="MsoNormal">Based on <a id="OWAAMBC6F9A316D814AE993661FC111776926" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">
            <span style="font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Kuehling,
              Felix</span></a> comments,
          <span style="font-size:10.5pt;line-height:106%;font-family:&quot;Segoe
            UI&quot;,sans-serif">
            kmalloc without any special flags can cause memory reclaim.
            Doing that inside an MMU notifier is problematic, because an
            MMU notifier may be called inside a memory-reclaim operation
            itself. That would result in recursion. Also, reclaim
            shouldn't be done while holding a lock that can be taken in
            an MMU notifier for the same reason. If you cause a reclaim
            while holding that lock, then an&nbsp;MMU notifier called by the
            reclaim can&nbsp;deadlock trying to take the same lock.<o:p></o:p></span></p>
        <p class="MsoNormal">Please let us know if you have any advice
          to enable this the right way<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Thanks in advanced,<o:p></o:p></p>
        <p class="MsoNormal">Alejandro<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------71D9C9EA1D2E0834E3097FCF--

--===============0874596129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0874596129==--
