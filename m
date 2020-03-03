Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097CFC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC8E20828
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SZRalVA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC8E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D31C6EA87;
	Tue,  3 Mar 2020 15:03:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD516EA87
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 15:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iISn5Rx9B33KxZT3smBnf6XtGAaMQWIxwt/5HQkAxMLlMHewd5K1ovkbQwIcXVY2uYF3hDHUw5P0KVYZOPjqzLk5vjm+8ygpaF/QbpqpJWI7SQi/KKJDpUV5Jmsa79C/GTyS+FlzLdddyqJ7jFXfRa5dGjju9POCScxAxFkjOLiJmIJWw880Uwm+SL0PMUUZp7LByWtUaZHzDWGiImC3r7pPtC/ZKy9xqG0OUWY/iwjrj1Swj78zvf1SdDB8RyWRMavZ+Vjfy0PZauMJvnJ5497EVs7L6gD0gDiAdOpYDpVDpPS6obyO0Xszs/4IxPCVgWd/4VBVGaYaLSWU29ORyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GFYtvQCvaQkdweMwa1LxJtlHDf0kaOBjNiEqXFtqc4=;
 b=fJFcsuHHwTdcCw2nH3M0pf8oapHRjWf335OLDK2/t8v8WzbUFQ/xme5PXX16nKY6mbOpe3rdGlE7TRGb2Zdxt3Bh3AhsP72UIADnlovH2Sj9BfgZlKQyrItVJtm+Byw46GuZOJ1Wdf1G77j58IAu3n87FpLYvI5MAqI10Mt5OTnfKmXjPqFK/89d5lks5GKD7/sOCpXZJ+egd6vGagdW50wplNJc5sx4nFJkbsJ5KQFHI01bx2pKJi+WCq4xZcvGrTXafHqNX5TQbJeV5ucNQqA3pwgoPwxFBxvPhE+nJ6ywHPf3D6zete2Ch99FSrDBuzCNasydc0QrlbsSYzG1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GFYtvQCvaQkdweMwa1LxJtlHDf0kaOBjNiEqXFtqc4=;
 b=SZRalVA/KI/2ESwvm3Fb3+3e90kV6X42jbf8WLc+Vt7lmY0rFW3sFh7X9fPYKS6adV3hMWsFuECUFp632+cKkGlLZiXoECzP7r7PPiW3hNKcA6dyBf+h2Ib4SVf9ux86o9/KyqDocJHQHUJ97Dkszsyw8aPCpSx9KyMtQu2o4fM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Tue, 3 Mar 2020 15:03:54 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 15:03:54 +0000
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
To: "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200302053529.5736-1-jacob.he@amd.com>
 <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
 <MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <06d9d31f-87c5-b1f1-da93-992531dd57ad@amd.com>
Date: Tue, 3 Mar 2020 16:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::27) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0101CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19 via Frontend
 Transport; Tue, 3 Mar 2020 15:03:53 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 836d5ccc-55c8-427b-234f-08d7bf8416f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:|DM5PR12MB1594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594C8082FB62656CDB209EB83E40@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(110136005)(498600001)(2906002)(52116002)(86362001)(31686004)(31696002)(186003)(6666004)(5660300002)(16526019)(53546011)(81156014)(8676002)(81166006)(36756003)(2616005)(8936002)(66946007)(66556008)(66476007)(66574012)(6486002)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1594;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvUND/gPZjcTO1jvx8ybdhdWWt2yWsM59aDpqI404iEqfbdBjAv3c+LEOgoD1fJBS4mdyYiltWzVy6qKIQTjymu2jahM2rzYORJHDhOnY7A/N/cASuSQmeNEmcEJOKErC/FdJaSNhqvFINZpYqkPEnci1FoX7WEJNmrhCVGEAJA/ruyGjA7lA1qd1Z+Hhz6ELAvLzMI4e1n6z9jjxhgEFNXKgtqfwFGmx6jXAX66Bjj9VRTG32aouJvbApXnCCzAFY/jXWStzUxRiYWBPaCl29Oo4sNzN0KyEF2dP5u85PqWyB1hQpVak/4vBSBqvTVFmx+mTGKrBReidSBd49hELJDZzLlj/NBafubIjVtOkU1YP/WYXIAxd+DyEYqrINYI1Jcv6cl3Ti97r+Dwz73X8uVc769Zr82blO6Fkh6R71PFFlK+M1bVeB2XocJR+HQS
X-MS-Exchange-AntiSpam-MessageData: iSKTCjgFK+glf81aWwvJQQrkVrjzVlRMd3wE4ILM1KgRfJAC6kNoQsn02+KWKJIU02WYOAzZsMJK86Njd9O9IBAtckLYnEdjoTGAV0Y80R1m/VBIfNETQbZFkiztaC6fib+dKxL2wGAKK/5LPpPdFpGULExdxbKiRjxugZ7aZ5HY3ITXNOqWEso5jDWv+MdmkxNAT2VJaHH/5z7BCGQCfA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836d5ccc-55c8-427b-234f-08d7bf8416f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 15:03:54.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe8jrBWH4eNwRkFK4wzJEtA+eS5ohx3wKCFBayRHa6XNmi00e88MchGslBvqMPEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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
Content-Type: multipart/mixed; boundary="===============0350382127=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0350382127==
Content-Type: multipart/alternative;
 boundary="------------1C2AF555694E0F8C8C0669B6"
Content-Language: en-US

--------------1C2AF555694E0F8C8C0669B6
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.03.20 um 15:34 schrieb He, Jacob:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> /It would be better if we could do that asynchronously with a register
> write on the ring.
>
> /
>
> Sorry, I don’t get your point. Could you please elaborate more?
>

You pass the ring from amdgpu_vm_flush() to the *_update_spm_vmid() 
functions.

And then instead of using WREG32() you call amdgpu_ring_emit_wreg() to 
make the write asynchronously on the ring buffer using a CP command.

This way we avoid a bunch of trouble when one process drops the VMID 
reservation and another one grabs it.

Regards,
Christian.

> Thanks
>
> Jacob
>
> *From: *Christian König <mailto:ckoenig.leichtzumerken@gmail.com>
> *Sent: *Tuesday, March 3, 2020 10:16 PM
> *To: *He, Jacob <mailto:Jacob.He@amd.com>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> *Subject: *Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid 
> when application reserves the vmid
>
> Am 02.03.20 um 06:35 schrieb Jacob He:
> > SPM access the video memory according to SPM_VMID. It should be updated
> > with the job's vmid right before the job is scheduled. SPM_VMID is a
> > global resource
> >
> > Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
> > Signed-off-by: Jacob He <jacob.he@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index c00696f3017e..c761d3a0b6e8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1080,8 +1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
> struct amdgpu_job *job,
> >        struct dma_fence *fence = NULL;
> >        bool pasid_mapping_needed = false;
> >        unsigned patch_offset = 0;
> > +     bool update_spm_vmid_needed = (job->vm && 
> (job->vm->reserved_vmid[vmhub] != NULL));
> >        int r;
> >
> > +     if (update_spm_vmid_needed && 
> adev->gfx.rlc.funcs->update_spm_vmid)
> > + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
> > +
>
> It would be better if we could do that asynchronously with a register
> write on the ring.
>
> The alternative is that we block for the VM to be idle in
> amdgpu_vm_ioctl() before unreserving the VMID.
>
> In other words lock the reservation object of the root PD and call
> amdgpu_vm_wait_idle() before calling amdgpu_vmid_free_reserved().
>
> Regards,
> Christian.
>
> >        if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> >                gds_switch_needed = true;
> >                vm_flush_needed = true;
>


--------------1C2AF555694E0F8C8C0669B6
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 03.03.20 um 15:34 schrieb He, Jacob:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><i>It would be better if we could do that
              asynchronously with a register
              <br>
              write on the ring.<br>
              <br>
            </i></p>
          <p class="MsoNormal">Sorry, I don’t get your point. Could you
            please elaborate more?
          </p>
        </div>
      </div>
    </blockquote>
    <br>
    You pass the ring from amdgpu_vm_flush() to the *_update_spm_vmid()
    functions.<br>
    <br>
    And then instead of using WREG32() you call amdgpu_ring_emit_wreg()
    to make the write asynchronously on the ring buffer using a CP
    command.<br>
    <br>
    This way we avoid a bunch of trouble when one process drops the VMID
    reservation and another one grabs it.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman Old
              Style&quot;,serif">Thanks<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman Old
              Style&quot;,serif">Jacob<o:p></o:p></span></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="mso-element:para-border-div;border:none;border-top:solid
            #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal" style="border:none;padding:0in"><b>From:
              </b><a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">Christian König</a><br>
              <b>Sent: </b>Tuesday, March 3, 2020 10:16 PM<br>
              <b>To: </b><a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He, Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID
              with the job's vmid when application reserves the vmid</p>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt">Am 02.03.20
            um 06:35 schrieb Jacob He:<br>
            &gt; SPM access the video memory according to SPM_VMID. It
            should be updated<br>
            &gt; with the job's vmid right before the job is scheduled.
            SPM_VMID is a<br>
            &gt; global resource<br>
            &gt;<br>
            &gt; Change-Id: Id3881908960398f87e7c95026a54ff83ff826700<br>
            &gt; Signed-off-by: Jacob He <a class="moz-txt-link-rfc2396E" href="mailto:jacob.he@amd.com">&lt;jacob.he@amd.com&gt;</a><br>
            &gt; ---<br>
            &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 &#43;&#43;&#43;&#43;<br>
            &gt;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; index c00696f3017e..c761d3a0b6e8 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; @@ -1080,8 &#43;1080,12 @@ int amdgpu_vm_flush(struct
            amdgpu_ring *ring, struct amdgpu_job *job,<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence = NULL;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pasid_mapping_needed = false;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned patch_offset = 0;<br>
            &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid_needed = (job-&gt;vm
            &amp;&amp; (job-&gt;vm-&gt;reserved_vmid[vmhub] != NULL));<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
            &gt;&nbsp;&nbsp; <br>
            &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (update_spm_vmid_needed &amp;&amp;
            adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)<br>
            &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev,
            job-&gt;vmid);<br>
            &gt; &#43;<br>
            <br>
            It would be better if we could do that asynchronously with a
            register <br>
            write on the ring.<br>
            <br>
            The alternative is that we block for the VM to be idle in <br>
            amdgpu_vm_ioctl() before unreserving the VMID.<br>
            <br>
            In other words lock the reservation object of the root PD
            and call <br>
            amdgpu_vm_wait_idle() before calling
            amdgpu_vmid_free_reserved().<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vmid_had_gpu_reset(adev, id)) {<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_switch_needed = true;<br>
            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_flush_needed = true;<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------1C2AF555694E0F8C8C0669B6--

--===============0350382127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0350382127==--
