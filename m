Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB4C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 00:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0112208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 00:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0112208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275046E0C4;
	Fri, 29 Nov 2019 00:35:19 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730053.outbound.protection.outlook.com [40.107.73.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8086E0C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 00:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oablKY5FRjp7J9nDs/UrEqnQqkgyobkNquAT3IBc3yuUI9clYdCgYMx17o9bAA1d30zzfdqRJxGWNKGCjRi/LsqzP1tlPK3JtdF+h53wTPIqKdFC2+kjIcxpI679eB1+bzO6zxBE3Y16hCXpCYnFYJ1PzROWd4o54VT10Zza//RNh21cAIW9UdYt9rXG78GeXPCkqdIK9O9sE6aUQJw4jafunNqSFA8YFXCGz/Y8Sl9OR+tFuKMQpEdnh/lcy9RwSTIVpYw4ERJDfAo5bCanwvRxgdkNbyMlMSDAonY0m0Xu3MT2aAr+v+oyYuZtRypNhuzBYvfxFAlOGYOR40kNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzmfJZQGOnwUsrKwS4VTO76ZEfx3QhPxUjHP0+gqZ2U=;
 b=VintvpUXUUpUQLfNMnA/a9YpMUIxsfV5cnRkZ96icJig4VeqtD62U/Q3OmkQQrjGCePlZl/QNiSZDF+TNhQwYEZrDcvFLgiT6pMaSvCzabgmrNaGqFWjpzW89JBLWe/7TMK1KkKmSygAtNgJvmTbcWVlNxguvL9ztwCAQVsDrm3H7HPm1XHKYciTYnNFDoAWrGwNgIc9rLHMPA7Lmp7aKX2AHCNdh/3JQopcx93FU3HYJvPjMjiPuIRv6fWPSgJOmGFO4KiVYbbMLUubVGwiJHG+qvy3T1cht/1OhB0uOIodH3PYE8DsQrsoSVIk/nrxdJps2T5c3MNe+9+/i6n0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (52.132.199.18) by
 SN1PR12MB2526.namprd12.prod.outlook.com (52.132.197.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Fri, 29 Nov 2019 00:35:15 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::e890:dfdd:c242:b9af]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::e890:dfdd:c242:b9af%4]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 00:35:15 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: Deadlock on PTEs update for HMM
Thread-Topic: Deadlock on PTEs update for HMM
Thread-Index: AdWlMnOsNrqIwkHRSMuzwywKzOgYQQBGlMIw
Date: Fri, 29 Nov 2019 00:35:15 +0000
Message-ID:
 <SN1PR12MB25916EE076E6BF5F5CBE3F8B80460@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-29T00:35:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9887523c-b58a-4a6a-8ac0-0000422ec973;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-29T00:35:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 748d90f9-f7af-42e3-a781-0000b5f40a0b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3f59d72-80b9-4b9d-e6fb-08d7746400f4
x-ms-traffictypediagnostic: SN1PR12MB2526:|SN1PR12MB2526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB252659B5C33FAD30264CA30480460@SN1PR12MB2526.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(51874003)(199004)(189003)(99286004)(6116002)(26005)(110136005)(86362001)(14444005)(8936002)(2420400007)(81166006)(7110500001)(52536014)(446003)(11346002)(6636002)(2906002)(76116006)(6246003)(66476007)(15650500001)(66946007)(5660300002)(66556008)(66446008)(478600001)(33656002)(4326008)(25786009)(790700001)(236005)(53546011)(64756008)(14454004)(74316002)(3846002)(102836004)(76176011)(7696005)(66066001)(6436002)(7736002)(81156014)(229853002)(256004)(8676002)(186003)(6506007)(55016002)(71200400001)(54896002)(316002)(9686003)(6306002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2526;
 H:SN1PR12MB2591.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWPPB1RBUWGbBX4YfEcXFoDwtYpP7zrlEt7QvdNca0d9uXcla/qpX9KOJPLskGhBCCqHmxvOEr6U3nEd2pQ040mjBVb3BtwGXpmtTI/2H2GTpT4hMsYjUV7PbCfG52mCP9EPeOdq1eXm3DRwIJ83TqT22S9O/Oc+cfnwOA7ZoN6eHCEVD09OlATX5WquA0kTZVN957moePHkKlDOdQ6SvHBddx6gklIuSPIl50MczxHW3tZ/k3rhae9spQRK2XUTgS6+4wL2UV76cpChRjhEDanbRvSttybB6ep61enKF7k4Fy8DX0bLkWthmmxSMn8W4i1llFt/Trwj34WPgo6fwM6XLdTLH06P0Ubzbm+23yFAZEmU8PmX+UFOu8G4uT6CjGDyFrJ/ekD81Ehqp6Msk5jV6uf1J/2dWhSTuD+542mAQqe9Njtca5qjRb2v3MLp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f59d72-80b9-4b9d-e6fb-08d7746400f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 00:35:15.6007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gh9Vq6KRDG60rC98sPnBfP4TSvVBAyp+Gr1b8yXQhRRBevOqsbUFHLohlpvApshj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2526
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzmfJZQGOnwUsrKwS4VTO76ZEfx3QhPxUjHP0+gqZ2U=;
 b=cMToaiN0AygYcVoTuGX8U83jSv2HHtTwGVEYxSDGTcvghZztax1yQmNNyFKV+T0dxu3LnRaaoscckzM7hqkYj1MASpsNBfkEpj1464m8qQ6vi6/eQuWTyMIqsbXuwKueXaUizIZnoPxvrNntQP8YrRzSreI5b4PK8mRm7sKjyuM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============0895116236=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191129003515.K6e6id4kPu4CPDDlLRgIGGJr2Ts54wrNxBXX7vBCZTQ@z>

--===============0895116236==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_"

--_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Is kmalloc with GFP_NOWAIT an option here?

Regards,
Oak

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sierra G=
uiza, Alejandro (Alex)
Sent: Wednesday, November 27, 2019 9:55 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Ku=
ehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Deadlock on PTEs update for HMM

Hi Christian,
As you know, we're working on the HMM enablement. Im working on the dGPU pa=
ge table entries invalidation on the userptr mapping case. Currently, the M=
MU notifiers handle stops all user mode queues, schedule a delayed worker t=
o re-validate userptr mappings and restart the queues.
Part of the HMM functionality, we need to invalidate the page table entries=
 instead of stopping the queues. At the same time we need to move the reval=
idation of the userptr mappings into the page fault handler.
We're seeing a deadlock warning after we try to invalidate the PTEs inside =
the MMU notifier handler. More specific, when we try to update the BOs to i=
nvalidate PTEs using amdgpu_vm_bo_update. This uses kmalloc on the amdgpu_j=
ob_alloc which seems to be causing this problem.
Based on @Kuehling, Felix<mailto:Felix.Kuehling@amd.com> comments, kmalloc =
without any special flags can cause memory reclaim. Doing that inside an MM=
U notifier is problematic, because an MMU notifier may be called inside a m=
emory-reclaim operation itself. That would result in recursion. Also, recla=
im shouldn't be done while holding a lock that can be taken in an MMU notif=
ier for the same reason. If you cause a reclaim while holding that lock, th=
en an MMU notifier called by the reclaim can deadlock trying to take the sa=
me lock.
Please let us know if you have any advice to enable this the right way

Thanks in advanced,
Alejandro


--_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:105%;
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is kmalloc with GFP_NOWAIT an option here?<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
Regards,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
<b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; <b>On Be=
half Of </b>
Sierra Guiza, Alejandro (Alex)<br>
<b>Sent:</b> Wednesday, November 27, 2019 9:55 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kuehling, Fe=
lix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Deadlock on PTEs update for HMM<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal">As you know, we&#8217;re working on the HMM enableme=
nt. Im working on the dGPU page table entries invalidation on the userptr m=
apping case. Currently, the MMU notifiers handle stops all user mode queues=
, schedule a delayed worker to re-validate
 userptr mappings and restart the queues. <o:p></o:p></p>
<p class=3D"MsoNormal">Part of the HMM functionality, we need to invalidate=
 the page table entries instead of stopping the queues. At the same time we=
 need to move the revalidation of the userptr mappings into the page fault =
handler.<o:p></o:p></p>
<p class=3D"MsoNormal">We&#8217;re seeing a deadlock warning after we try t=
o invalidate the PTEs inside the MMU notifier handler. More specific, when =
we try to update the BOs to invalidate PTEs using amdgpu_vm_bo_update. This=
 uses kmalloc on the amdgpu_job_alloc which
 seems to be causing this problem.<o:p></o:p></p>
<p class=3D"MsoNormal">Based on <a id=3D"OWAAMBC6F9A316D814AE993661FC111776=
926" href=3D"mailto:Felix.Kuehling@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Kuehling, Felix</span></a> comments,
<span style=3D"font-size:10.5pt;line-height:105%;font-family:&quot;Segoe UI=
&quot;,sans-serif">
kmalloc without any special flags can cause memory reclaim. Doing that insi=
de an MMU notifier is problematic, because an MMU notifier may be called in=
side a memory-reclaim operation itself. That would result in recursion. Als=
o, reclaim shouldn't be done while
 holding a lock that can be taken in an MMU notifier for the same reason. I=
f you cause a reclaim while holding that lock, then an&nbsp;MMU notifier ca=
lled by the reclaim can&nbsp;deadlock trying to take the same lock.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal">Please let us know if you have any advice to enable =
this the right way<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advanced,<o:p></o:p></p>
<p class=3D"MsoNormal">Alejandro<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_--

--===============0895116236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0895116236==--
