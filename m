Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69275C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DFE20724
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XaHNPhyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DFE20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2B66E9C6;
	Fri, 13 Mar 2020 13:46:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E536E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+0ur/kQfuLMut70Rrzw1NpQgrLc7/+gnw73zH2MYaXPGz2KIQotwW/ys7sXB8LhoaTsBK1CJ7UT7Usmpz+OknAIhq4brrqZ/Koy4VT6S65Enhj452yoYwCsFpeijy+TOwNOHIcCxAAM7w0q9bcNEC/ya76q2QGpgpl5+erkEQcBVaBkqkScwrgpcZWG5mL+xRlQxpIQYyVkcld/PWHhqF1pXIlp9JwgUBO+JMkBtXpL5fsERL4aY1X7aKZCAIH83SxDBb4/QpNA2QNsVVjQz4h+SZoGP/PiywDkY6VwyRQdKvbc3G4fSwpQw8ZFlsNb8kJs95kZSJzkRzUKkBjK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O7exQ/copFzpUtOdpL8MYKihmrlcZ0oRCaW6Ju6kyM=;
 b=VSDT8lWrWaFgnAJArBk4fyC83zWHJGI8+nYOju58AtnEAFNAPUIluchjxCRxclCggOPPNCzPCAg9/Q1n81AsCb2fmmA574IJIS21Vw/HS3AY495cCUUgIJGC17Jz95hky3jeEAB/1q0ZizhYaz2sNqIXGqbyZtMu/HK9v/8l+50H/0okM/jsRx4NjepB+zmhW9HBx23O0CgITP11WtjekENCc9ajpMpUF99r8JfhtU82Gs6bYUUoiRCkW3OOFD16VQtWlWxZpFAo5XOeM+zKYRf8FZxQCsPawdra0+PQF0LePuToOujS8ahSnSD73n7VwuY4uWGNS/XtugM/rWOwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O7exQ/copFzpUtOdpL8MYKihmrlcZ0oRCaW6Ju6kyM=;
 b=XaHNPhyvs2j09vEwliNjq/FsYh3TWl4k5cwKKYPNGePXnzOOzeVhKkQi/7H0sOPiZTySNPU4noHTfZr+MAPR9Vv06cCWow+e5B0BVlXRKAfUpxpzngMwxzzJG/FpoN8gdEeXVy0sBtzEhIIIfnz7JCnxQUOFRCfwwnzweKg/zSo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 13:46:36 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 13:46:36 +0000
Subject: Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200313115305.32325-1-xinhui.pan@amd.com>
 <46ae936e-d255-bf37-6491-2ff25757eac3@amd.com>
 <SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a910a52f-b1c7-1cc3-18c5-6048a1074552@amd.com>
Date: Fri, 13 Mar 2020 14:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:1::25) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:208:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend
 Transport; Fri, 13 Mar 2020 13:46:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 196f5744-3fb4-4ae7-7638-08d7c754f2c6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2517:|DM5PR12MB2517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25174528F4C3860534D9CE6383FA0@DM5PR12MB2517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(31686004)(110136005)(8676002)(81166006)(33964004)(53546011)(8936002)(6666004)(81156014)(52116002)(54906003)(66574012)(36756003)(2616005)(86362001)(316002)(6486002)(478600001)(2906002)(5660300002)(4326008)(66556008)(16526019)(186003)(66476007)(66946007)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2517;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSc3Z9RiTQKQEuzDeq2rarCWAkvXvol8D0NPQTA6P0HAyMqO7PomK2VrY22NGnqICLmswf3ZQPmAsVd13qTPfe1jwbxKKZtlAjPZfR7/XQSdswELdvPLcHWO8gVOC/1aque5GUO9tEBvSD0EtpODqqhbFeOhOa2J9+zYP91ADC+RgcNYPb4FRzr0L80wYy56EnOmqAXUTjWnENAr2wxAlC1DSEJ6YCAzhP7C3BDYeuzpHSJyZ8IQ/MhNRzhOy4qHrg5lvpri1Zb5Gm9nVDEix1G+SsFiBU71UbpF7PjuQf2SLm7wZ82k01Rss/BcUh7W3Wj/v8khQlwumJMJ8YNTKdeQYfdll5sWiOKlI328wDwKJEsMUMjtNlJovI1atafem2jlpXkonxQPT8PjtJCcKsg7aaEtQvWlCETo4f9JqxSjczucM2AV0ji6zm8uM5Vb
X-MS-Exchange-AntiSpam-MessageData: o6Zn5pI139WYSEUjCQq74RiPPQvBpoTex83wYprELDroX2Kqw7V8x5oaar0mH4OTYFra1Y/uXgMbitlYhlHlKLC/eJiQR25bdHq4t+h5OjNXMIFTp8ymp6qIabKJ7lCIFbcccgSruTTFDUwGR2VECHzMhEsym/hZeW9HpBXghpa6FD/qdMOVverrGX7LsAqclxviiw9L6n87xmzmdPxWPA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196f5744-3fb4-4ae7-7638-08d7c754f2c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:46:36.2676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KA741iCQNbyH6N2KtcBms/y5DhKYCX9xIq1+T8EGEjjzPo/7shALZQSRdymwK5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2517
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============1058267873=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1058267873==
Content-Type: multipart/alternative;
 boundary="------------8FB8C91B7E07E7851AEB79D7"
Content-Language: en-US

--------------8FB8C91B7E07E7851AEB79D7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, but this is still the wrong resv object :)

See the object passed to amdgpu_vm_sdma_prepare() is the one of the BO 
which is mapped into the page tables and NOT the one of the page tables.

You need to use p->vm->root.base.bo->tbo.base.resv here.

Regards,
Christian.

Am 13.03.20 um 14:43 schrieb Pan, Xinhui:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> page table BOs share same resv.It should be ok using any of them, root 
> bo resv or bo resv.
> I forgot to unref bos which cause problems. not good at rebasing...
>
>
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, March 13, 2020 9:34:42 PM
> *To:* Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv 
> conditionally
> Am 13.03.20 um 12:53 schrieb xinhui pan:
> > If a job need sync the bo resv, it is likely that bo need the job fence
> > to sync with others.
>
> That won't work because this is the wrong resv object :)
>
> You added the fence to the mapped BO and not the page table.
>
> No wonder that this doesn't work,
> Christian.
>
> >
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Suggested-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 5 +++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 9 +++++++++
> >   2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > index b5705fcfc935..ca6021b4200b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -226,6 +226,11 @@ struct amdgpu_vm_update_params {
> >         * @num_dw_left: number of dw left for the IB
> >         */
> >        unsigned int num_dw_left;
> > +
> > +     /**
> > +      * @resv: sync the resv and add job fence to it conditionally.
> > +      */
> > +     struct dma_resv *resv;
> >   };
> >
> >   struct amdgpu_vm_update_funcs {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> > index 4cc7881f438c..0cfac59bff36 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> > @@ -70,6 +70,8 @@ static int amdgpu_vm_sdma_prepare(struct 
> amdgpu_vm_update_params *p,
> >
> >        p->num_dw_left = ndw;
> >
> > +     p->resv = resv;
> > +
> >        if (!resv)
> >                return 0;
> >
> > @@ -111,6 +113,13 @@ static int amdgpu_vm_sdma_commit(struct 
> amdgpu_vm_update_params *p,
> >                swap(p->vm->last_delayed, tmp);
> >        dma_fence_put(tmp);
> >
> > +     /* add job fence to resv.
> > +      * MM notifier path is an exception as we can not grab the
> > +      * resv lock.
> > +      */
> > +     if (!p->direct && p->resv)
> > +             dma_resv_add_shared_fence(p->resv, f);
> > +
> >        if (fence && !p->direct)
> >                swap(*fence, f);
> >        dma_fence_put(f);
>


--------------8FB8C91B7E07E7851AEB79D7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, but this is still the wrong resv
      object :)<br>
      <br>
      See the object passed to amdgpu_vm_sdma_prepare() is the one of
      the BO which is mapped into the page tables and NOT the one of the
      page tables.<br>
      <br>
      You need to use p-&gt;vm-&gt;root.base.bo-&gt;tbo.base.resv here.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.03.20 um 14:43 schrieb Pan, Xinhui:<br>
    </div>
    <blockquote type="cite" cite="mid:SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0@SN6PR12MB2800.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          page table BOs share same resv.It should be ok using any of
          them, root bo resv or bo resv.<br>
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
        </div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          I forgot to unref bos which cause problems. not good at
          rebasing...</div>
        <div dir="auto" style="direction: ltr; margin: 0; padding: 0;
          font-family: sans-serif; font-size: 11pt; color: black; ">
          <br>
        </div>
        <div id="ms-outlook-mobile-signature" dir="auto" style="text-align: left;">
          <div><br>
          </div>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, March 13, 2020 9:34:42 PM<br>
            <b>To:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
            <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 1/2] drm//amdgpu: Add job fence
            to resv conditionally</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Am 13.03.20 um 12:53 schrieb xinhui
                pan:<br>
                &gt; If a job need sync the bo resv, it is likely that
                bo need the job fence<br>
                &gt; to sync with others.<br>
                <br>
                That won't work because this is the wrong resv object :)<br>
                <br>
                You added the fence to the mapped BO and not the page
                table.<br>
                <br>
                No wonder that this doesn't work,<br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Cc: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                &gt; Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                &gt; Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                &gt; Suggested-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                &gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5
                &#43;&#43;&#43;&#43;&#43;<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 9
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
                &gt;&nbsp;&nbsp; 2 files changed, 14 insertions(&#43;)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; index b5705fcfc935..ca6021b4200b 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; @@ -226,6 &#43;226,11 @@ struct amdgpu_vm_update_params
                {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @num_dw_left: number of dw left for the
                IB<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw_left;<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @resv: sync the resv and add job fence to
                it conditionally.<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv;<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; struct amdgpu_vm_update_funcs {<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
                &gt; index 4cc7881f438c..0cfac59bff36 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
                &gt; @@ -70,6 &#43;70,8 @@ static int
                amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params
                *p,<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;num_dw_left = ndw;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;resv = resv;<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!resv)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; @@ -111,6 &#43;113,13 @@ static int
                amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap(p-&gt;vm-&gt;last_delayed,
                tmp);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(tmp);<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* add job fence to resv.<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MM notifier path is an exception as we can
                not grab the<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * resv lock.<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;direct &amp;&amp; p-&gt;resv)<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_add_shared_fence(p-&gt;resv,
                f);<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fence &amp;&amp; !p-&gt;direct)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap(*fence, f);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8FB8C91B7E07E7851AEB79D7--

--===============1058267873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1058267873==--
