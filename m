Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BCFC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 16:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F94C206E2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ysgYR9P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F94C206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204966E096;
	Tue,  3 Mar 2020 16:09:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CF56E096
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 16:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYD0TmgH0TDnCyAOeyX0JE8y9Kou1EL+3EXFBbuGxOWUpbtxu9K0FkeUXeNPmdzNx9V/7kJ6cr0AFG6c4UynLcJEi7eYsMCm6PXOCqaynBgGWKmB5ZTl6RmvJc5g0s1o3522CPpurbmidLdyW75yfT0/JL8IqGil8hOBj6lDLPoAcEYclth+ftQSbiPlBtxec0jzchz4wakili+Af2eON1FGatFMbdFL5dJyv0bmNv9D6JuJYiOCpgpS8f2QolqSZWqT4TzIAGwWTxY2aos5koM8M7Hi+wqBFeODwo5qD6aaK1fluWgjXLYn2oxM/TuWqSrQ+ZhAiCLwLYaVJJyUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y1eIBJbejx0Oxy7ZW5FXLukl8mVvN/rfUXX0sQ0ehk=;
 b=UsW7vp2A8sFYe6agbrGxj5LE7twidCS+J4cErNF+JEoP/562I/WMR5Rf+UrTrwDVQeGpxMZxzmP5z4t7wjznc3KgL2/JoULvEtmko01x7rnFsUoMrHumHl6HJrLBG+dLrPQ1nbphMLirDCPW0FfjSxcilp4A/HUoCaETeyS91Hz3wi8KDLKY7QUqU9sQFhURzi//4DQO/C+TL3e1mYjri8KiONeD1KYRTrxj8LRE4o/DzkXy9hrlwCt8r28sCPPFJnLt5xKC80CEWuI6CjpkzuLoiOm7JTeq8R7/EIm4t7cd7dJY/eoyrSbeuv6n9fWc3XSmVrhBIm6qiBJbrIcvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y1eIBJbejx0Oxy7ZW5FXLukl8mVvN/rfUXX0sQ0ehk=;
 b=ysgYR9P2XiaV4I2CGDDdoJ3SALd+8WZWXlsvzCL6JHphuAWusVOB99wsPQYJPHEywS/MrworOnqUGAPUcME6tWm7ScHTY13h7bzb2DchN4sVn0c/40mBixl4IrkZjN5U2dYHdk0x6RpOedsszmLvSGsfePLErB91O++B4lvj3AY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1180.namprd12.prod.outlook.com (2603:10b6:3:74::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 16:09:44 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 16:09:44 +0000
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
To: "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200302053529.5736-1-jacob.he@amd.com>
 <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
 <MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
 <06d9d31f-87c5-b1f1-da93-992531dd57ad@amd.com>
 <MN2PR12MB3376F4FF11CA27726C7A7CE29BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
 <21a8a363-1ebe-a4cb-150d-f84442f322fc@amd.com>
 <MN2PR12MB33768819020B42D37DFDB6809BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2830d70f-1292-a880-f952-98533056d5d1@amd.com>
Date: Tue, 3 Mar 2020 17:09:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB33768819020B42D37DFDB6809BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 16:09:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f0f2b48-e151-48a3-e948-08d7bf8d49b7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:|DM5PR12MB1180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11809C13FB9B196178D07C9883E40@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(186003)(16526019)(86362001)(66556008)(66946007)(478600001)(2616005)(66476007)(15650500001)(81156014)(6666004)(8676002)(31686004)(2906002)(6486002)(316002)(31696002)(5660300002)(52116002)(81166006)(66574012)(53546011)(36756003)(110136005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1180;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/UqZA4n+Wh5oIuEW30t3PSC1L7fkvLgupLnr1tr0FP5njLiQm8YunZ1gHybQcyKSt3MXHs3dLs0y1pGtsoviB76xYNpam8eFil1EC7Tp8bVgOf/BIzBnb92wcPNqTxUCckPfzkj6QweO2E5mSMlyVQLbuT5yj73IAVNES+oE51A7wa0R/PqeYPB+ECuWpDQPmmpV1oIRGY4XtauggbBsF6tzFMPOH6Is1CGL2V8DaSDpIR99Oj/FvpiGtNUGptyOCJg/TEiSZmuu1zgSX2gBjBSgNdl0wBqwAo1X2+KOdNXuIS3KOussMWyEgMz5LlVH/3hBMWSFACjTvhZT+7dU0eTk36zyH/ngwi+bfi7SVMN5+9K+bqGM/zfLsWVzXyF7wva4CYvIoaip3ArlDau1+30jQcEhM+6n89X0188Sji/ljoJ6+vfzTTbVYBnB20W
X-MS-Exchange-AntiSpam-MessageData: h7giq1Ne2jD0qSDO3zbpWiT3uT4eeQzmP+u56QCyx6K1DeG5A9r5ypSOq1IZQvv2FXLU0fnivLFW69UfAmIGDNr1v6mqe6JUlrxVhnT2k3T7lBHdQ53gYdWngxkG+/BDc2hxDhrCgfF8xFDdky7Z1PtcrvfmEe1ETYyjs21xScheqY4RLw0uDR8qIexb/GcmLk1CCvYUFXFgIZVipy7v5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f2b48-e151-48a3-e948-08d7bf8d49b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 16:09:44.7566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W7wSPh+rr7UgwdD8aqH72ejIp6WUKWLNSagmpDXIM/AV3acHoR08yU51PsjrD6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Content-Type: multipart/mixed; boundary="===============0523672243=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0523672243==
Content-Type: multipart/alternative;
 boundary="------------45402F27B48E6B52971C02E4"
Content-Language: en-US

--------------45402F27B48E6B52971C02E4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.03.20 um 17:07 schrieb He, Jacob:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Oh, you are right! If SPM_VMID is updated by other process while the 
> SPM enabled commands is executing, that will cause VM fault.
>
> Is the wait vm idle right before unreserve vmid still necessary if 
> using asynchroneously setting SPM_VMID?
>

No, that are alternative approaches.

Updating the VMID asynchronously sounds a bit cleaner to me, but feel 
free to pick whatever is easier for you to implement.

Regards,
Christian.

> Thanks
>
> Jacob
>
> *From: *Koenig, Christian <mailto:Christian.Koenig@amd.com>
> *Sent: *Tuesday, March 3, 2020 11:36 PM
> *To: *He, Jacob <mailto:Jacob.He@amd.com>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> *Subject: *Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid 
> when application reserves the vmid
>
> See the SPM buffer address is set using CP commands as well, right? 
> And those execute asynchronously.
>
> When we now synchronously update the SPM VMID we risk that we switch 
> from one process to another while the new process is not ready yet 
> with its setup.
>
> That could have quite a bunch of unforeseen consequences, including 
> accidentally writing SPM data into the new process address space at 
> whatever buffer address was used before.
>
> This is something we at least should try to avoid.
>
> Regards,
> Christian.
>
> Am 03.03.20 um 16:28 schrieb He, Jacob:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     Thanks!  Could you please take an example of trouble  “This way we
>     avoid a bunch of trouble when one process drops the VMID
>     reservation and another one grabs it.”?
>
>     Thanks
>
>     Jacob
>
>     *From: *Koenig, Christian <mailto:Christian.Koenig@amd.com>
>     *Sent: *Tuesday, March 3, 2020 11:03 PM
>     *To: *He, Jacob <mailto:Jacob.He@amd.com>;
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     *Subject: *Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's
>     vmid when application reserves the vmid
>
>     Am 03.03.20 um 15:34 schrieb He, Jacob:
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         /It would be better if we could do that asynchronously with a
>         register
>         write on the ring./
>
>         Sorry, I don’t get your point. Could you please elaborate more?
>
>
>     You pass the ring from amdgpu_vm_flush() to the
>     *_update_spm_vmid() functions.
>
>     And then instead of using WREG32() you call
>     amdgpu_ring_emit_wreg() to make the write asynchronously on the
>     ring buffer using a CP command.
>
>     This way we avoid a bunch of trouble when one process drops the
>     VMID reservation and another one grabs it.
>
>     Regards,
>     Christian.
>
>
>
>         Thanks
>
>         Jacob
>
>         *From: *Christian König <mailto:ckoenig.leichtzumerken@gmail.com>
>         *Sent: *Tuesday, March 3, 2020 10:16 PM
>         *To: *He, Jacob <mailto:Jacob.He@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Subject: *Re: [PATCH] drm/amdgpu: Update SPM_VMID with the
>         job's vmid when application reserves the vmid
>
>         Am 02.03.20 um 06:35 schrieb Jacob He:
>         > SPM access the video memory according to SPM_VMID. It should
>         be updated
>         > with the job's vmid right before the job is scheduled.
>         SPM_VMID is a
>         > global resource
>         >
>         > Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
>         > Signed-off-by: Jacob He <jacob.he@amd.com>
>         <mailto:jacob.he@amd.com>
>         > ---
>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>         >   1 file changed, 4 insertions(+)
>         >
>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>         > index c00696f3017e..c761d3a0b6e8 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>         > @@ -1080,8 +1080,12 @@ int amdgpu_vm_flush(struct
>         amdgpu_ring *ring, struct amdgpu_job *job,
>         >        struct dma_fence *fence = NULL;
>         >        bool pasid_mapping_needed = false;
>         >        unsigned patch_offset = 0;
>         > +     bool update_spm_vmid_needed = (job->vm &&
>         (job->vm->reserved_vmid[vmhub] != NULL));
>         >        int r;
>         >
>         > +     if (update_spm_vmid_needed &&
>         adev->gfx.rlc.funcs->update_spm_vmid)
>         > + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>         > +
>
>         It would be better if we could do that asynchronously with a
>         register
>         write on the ring.
>
>         The alternative is that we block for the VM to be idle in
>         amdgpu_vm_ioctl() before unreserving the VMID.
>
>         In other words lock the reservation object of the root PD and
>         call
>         amdgpu_vm_wait_idle() before calling amdgpu_vmid_free_reserved().
>
>         Regards,
>         Christian.
>
>         >        if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>         >                gds_switch_needed = true;
>         >                vm_flush_needed = true;
>


--------------45402F27B48E6B52971C02E4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 03.03.20 um 17:07 schrieb He, Jacob:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB33768819020B42D37DFDB6809BE40@MN2PR12MB3376.namprd12.prod.outlook.com">
      
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
@font-face
	{font-family:"Bookman Old Style \,serif";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
          <p class="MsoNormal">Oh, you are right! If SPM_VMID is updated
            by other process while the SPM enabled commands is
            executing, that will cause VM fault.</p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Is the wait vm idle right before
            unreserve vmid still necessary if using asynchroneously
            setting SPM_VMID?</p>
        </div>
      </div>
    </blockquote>
    <br>
    No, that are alternative approaches.<br>
    <br>
    Updating the VMID asynchronously sounds a bit cleaner to me, but
    feel free to pick whatever is easier for you to implement.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:MN2PR12MB33768819020B42D37DFDB6809BE40@MN2PR12MB3376.namprd12.prod.outlook.com">
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
              </b><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Koenig, Christian</a><br>
              <b>Sent: </b>Tuesday, March 3, 2020 11:36 PM<br>
              <b>To: </b><a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He, Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID
              with the job's vmid when application reserves the vmid</p>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">See the SPM buffer address is set using
            CP commands as well, right? And those execute
            asynchronously.<br>
            <br>
            When we now synchronously update the SPM VMID we risk that
            we switch from one process to another while the new process
            is not ready yet with its setup.<br>
            <br>
            That could have quite a bunch of unforeseen consequences,
            including accidentally writing SPM data into the new process
            address space at whatever buffer address was used before.<br>
            <br>
            This is something we at least should try to avoid.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 03.03.20 um 16:28 schrieb He, Jacob:<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                Official Use Only - Internal Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
            <div>
              <p class="MsoNormal">Thanks! &nbsp;Could you please take an
                example of trouble &nbsp;“<span style="color:black">This way
                  we avoid a bunch of trouble when one process drops the
                  VMID reservation and another one grabs it.</span>”?<o:p></o:p></p>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman Old
                  Style ,serif&quot;,serif">Thanks</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman Old
                  Style ,serif&quot;,serif">Jacob</span><o:p></o:p></p>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From: </b><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Koenig, Christian</a><br>
                  <b>Sent: </b>Tuesday, March 3, 2020 11:03 PM<br>
                  <b>To: </b><a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He, Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a><br>
                  <b>Subject: </b>Re: [PATCH] drm/amdgpu: Update
                  SPM_VMID with the job's vmid when application reserves
                  the vmid<o:p></o:p></p>
              </div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal"><span style="color:black">Am 03.03.20
                  um 15:34 schrieb He, Jacob:</span><o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                    Official Use Only - Internal Distribution Only]</span></p>
                <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
                <div>
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><i><span style="color:black">It would be better if we
                        could do that asynchronously with a register
                        <br>
                        write on the ring.</span></i><o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:black">Sorry,
                      I don’t get your point. Could you please elaborate
                      more?
                    </span><o:p></o:p></p>
                </div>
              </blockquote>
              <p class="MsoNormal"><span style="color:black"><br>
                  You pass the ring from amdgpu_vm_flush() to the
                  *_update_spm_vmid() functions.<br>
                  <br>
                  And then instead of using WREG32() you call
                  amdgpu_ring_emit_wreg() to make the write
                  asynchronously on the ring buffer using a CP command.<br>
                  <br>
                  This way we avoid a bunch of trouble when one process
                  drops the VMID reservation and another one grabs it.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  <br>
                  <br>
                </span><o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <div>
                  <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman
                      Old Style&quot;,serif">Thanks</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman
                      Old Style&quot;,serif">Jacob</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b><span style="color:black">From:
                        </span></b><span style="color:black"><a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">Christian König</a><br>
                        <b>Sent: </b>Tuesday, March 3, 2020 10:16 PM<br>
                        <b>To: </b><a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He, Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                          amd-gfx@lists.freedesktop.org</a><br>
                        <b>Subject: </b>Re: [PATCH] drm/amdgpu: Update
                        SPM_VMID with the job's vmid when application
                        reserves the vmid</span><o:p></o:p></p>
                  </div>
                  <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><span style="color:black">Am 02.03.20 um 06:35 schrieb
                      Jacob He:<br>
                      &gt; SPM access the video memory according to
                      SPM_VMID. It should be updated<br>
                      &gt; with the job's vmid right before the job is
                      scheduled. SPM_VMID is a<br>
                      &gt; global resource<br>
                      &gt;<br>
                      &gt; Change-Id:
                      Id3881908960398f87e7c95026a54ff83ff826700<br>
                      &gt; Signed-off-by: Jacob He <a href="mailto:jacob.he@amd.com" moz-do-not-send="true">&lt;jacob.he@amd.com&gt;</a><br>
                      &gt; ---<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4
                      &#43;&#43;&#43;&#43;<br>
                      &gt;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      &gt; index c00696f3017e..c761d3a0b6e8 100644<br>
                      &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      &gt; @@ -1080,8 &#43;1080,12 @@ int
                      amdgpu_vm_flush(struct amdgpu_ring *ring, struct
                      amdgpu_job *job,<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence = NULL;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pasid_mapping_needed = false;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned patch_offset = 0;<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid_needed =
                      (job-&gt;vm &amp;&amp;
                      (job-&gt;vm-&gt;reserved_vmid[vmhub] != NULL));<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (update_spm_vmid_needed &amp;&amp;
                      adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)<br>
                      &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev,
                      job-&gt;vmid);<br>
                      &gt; &#43;<br>
                      <br>
                      It would be better if we could do that
                      asynchronously with a register <br>
                      write on the ring.<br>
                      <br>
                      The alternative is that we block for the VM to be
                      idle in <br>
                      amdgpu_vm_ioctl() before unreserving the VMID.<br>
                      <br>
                      In other words lock the reservation object of the
                      root PD and call <br>
                      amdgpu_vm_wait_idle() before calling
                      amdgpu_vmid_free_reserved().<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vmid_had_gpu_reset(adev,
                      id)) {<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_switch_needed = true;<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_flush_needed = true;</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
                </div>
              </blockquote>
              <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="color:black">&nbsp;</span><o:p></o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------45402F27B48E6B52971C02E4--

--===============0523672243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0523672243==--
