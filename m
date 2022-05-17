Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C4BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B1811270A;
	Tue, 17 May 2022 16:51:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAE711270A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT6/QmDfbl99DBh5kq0n18avm9l8ANvcrJPXIRU0k29mV/j2kOpgYsOf4x6MDI8X3+mSGijkL6pU1pSxLUHALj+Il/Ji1CNbl2gHO4PfYGHXdq6e0wOEFQbg9k3bBcBEIGCXPxnIg0yobgnicKoUAp//0vcT14oeiMX/5rjLQiFEFCJVlFbdcay3/KtMuW1+WIsuNOEErt80hgZozsKo3x0WgwLzlfP+VL/oS1BQXU7tzBXxQEFmjJCPawLlOPFTWChk/RxjaJtZhMGobaGF+g7CoYXr0OyWPFFr4BlK6JWQZqRSLzlg0cVkDh1AUo6RL0L/xtkDPXYCPgZdeTL54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHJ9J8zFl/0k/wS9T6F7a048RQbbGATRwnJ/q0baMJg=;
 b=cGJcL2DAGFJVXIsST52j4OOZwwOiFsfjkdIPc1TYqbFp+ZJS42YDV0M9dQhFPsQEx70imXaw1YJ1siwQiMXEjG0PbHZpo1AyLqtgxsq9DvTnPl+Z340R7wj3+pEp3AIHdZOQraikGFmbmiXOvp2PJb9jLqc5lshduX2tKb6LKkAIZfYTpSKufKz5duo+vnPJDZO311HeLlhKG2lE+27nW7BvmfG0TirQiJUbGZIco9QLmk9vuozisEA7OXb5J2YcWu6TgfQpAiNl7WW38+u0NnJ89k5Seuu49BSSvszBx+iFeF5TyTSuVMUOgPDOzdGQ82TF60LFCgANq1a8CMe0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHJ9J8zFl/0k/wS9T6F7a048RQbbGATRwnJ/q0baMJg=;
 b=F85BY6qdVUxUEat/cuzXkLjqvKGFkxbrN6xzo9p/lH9CnzieqWPCvTMIi+p/7XzK8I3jDFZFE5W/bNGLKgkmNX94oV+3uLTDJrFpIKxYRa/0OE2t7HFukl15evFSC2d3NAnLTYF2AnjGsyLK9a0R47ghdRY7b5dVuZK5l/rKN8E=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN8PR12MB3441.namprd12.prod.outlook.com (2603:10b6:408:49::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 16:50:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:50:57 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Topic: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Index: AQHYafOabcB0THH+VEiSkjObHdhCGq0jQKcWgAACOQCAAATN3g==
Date: Tue, 17 May 2022 16:50:57 +0000
Message-ID: <BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220517133944.25612-1-mario.limonciello@amd.com>
 <BYAPR12MB461409FFEB1FE826259EAC9097CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <MN0PR12MB6101B804A6C68D3ED85262C7E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101B804A6C68D3ED85262C7E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-17T16:30:14.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a01c44-9f2c-4b5e-2940-08da38256a8c
x-ms-traffictypediagnostic: BN8PR12MB3441:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3441063B30DF0E85F166BEC997CE9@BN8PR12MB3441.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYkg4Wwbmnjx/7s3964E77JjKIGqt2/SG//BG44EMZx0P5CoO4jnFmoZ4TKHEaYsyxbBL/mvKkdUrZo0uEbjUCU3Up6x99NWGia707ao5WbVhIuDu73vzNZUw5ingZT324y9eZFKP797+8kmyXHgepUMrjJDfbPbThjdaCrAZEJckM88wiFvM0T+KTpiUZs083TL2yvjPySv60E6igE22JQsaD1zfKD9SQeF9U4CHXg3LHXi1RxnFN4bJ2vrgzEJUqS3Rf1QRXlr4McS+5jcAPcntXrhtuJrAupkbJVtXkaUNXVneTUp7B2svDJeTxcKYno2fU0YMv4ruxMk2EJr9FcMldlCsBhs6h/0i1UCO0o1o9Ac+yxEntmf0iCV1haFv+iaImdDg83ise3/+A92Juiid0UzXD3tgbNSGylPErzpIxNBr5SSDpnxMqMbGz4kCgarISCx+o52jklUjvx8mPTPcLGvnrK0jJE3SCUnZI7Zk2sLq7wxzFrBvmUTe+D2cLQXkqGi+agn4yHJMLI8ruxrTaS1gZYAAJze6PSGnsIxvbTpipEXxdxtrPZ7itzu/0BAmUzfh120XKp4s6M6JsBUqwakvdvFQqz9KPf9BTOwEyUAzrXiUD+r2QlkkKHnbqQIt3oQjxiJJ5JCCFnj2kk9aUBc8qwSHiPQaqF/lN/UdPQtEsyjeJThdcn8K7QnoQxYOFgj9t+/NcKjOVfaBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(186003)(9686003)(66946007)(66556008)(91956017)(110136005)(26005)(19627235002)(38100700002)(316002)(55016003)(8936002)(38070700005)(86362001)(52536014)(33656002)(76116006)(2906002)(5660300002)(64756008)(66476007)(66446008)(7696005)(8676002)(6506007)(122000001)(83380400001)(508600001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?EisLm8rLB3MpccYtmCJJ64yD+H5iedbRQSe5lPpbmLhUQ03Y6dCwW7CB?=
 =?Windows-1252?Q?/kS9aDKIM+0PxXCb2sLjYVmoMwUML5ypSDyEjvFAjhTRTiLLRoclyQYn?=
 =?Windows-1252?Q?GMCUpuMAlAO3/UzexFkpBy1zg/7wFqsgXuyOJMT2hRF92DUfI7i8Xlaa?=
 =?Windows-1252?Q?Z28ou6i9mt6WoFV+1xLsqp0BqJ89ElN3UYxS4XADCnecmgGAIYW2waUp?=
 =?Windows-1252?Q?xx3Ho5t+P7g5ebGoW/KJYcvG8WYnDEk6U5SgYyF1aYHK92oYr64G3Br2?=
 =?Windows-1252?Q?OrjyE7Ojtvz92z3hyibgDgGd57nmN8LR8LT4Yi8fr0gx1Bkjo70StsmO?=
 =?Windows-1252?Q?7DeG6gS1F6HPvWxjz94GB9qojdn4Lm8B8lHecn5JLn+JybK7cyOO2xmn?=
 =?Windows-1252?Q?GRPDVqv8MfbSdlBdVUqEGQT2skqNDSua99IKAfYFPp72PHAmo1aoI12r?=
 =?Windows-1252?Q?QYT/UoduLeGTKDvFWQrMCweLXg1cru5M9j9aKurQrV/ikDXbU6lFXUPd?=
 =?Windows-1252?Q?BrrGzi1hormCO6SsN8gRUVeBgyriPdmpx5j6dnfSjQRc5rTd6sA0GBbO?=
 =?Windows-1252?Q?aXnCmAFSS/Jyu79EH0N8CJ/BXqVGbsjLT9CqL5qBV4FCSdtyGiYx+4fC?=
 =?Windows-1252?Q?2d3YkvPreUt3GwRSiM2Fpsm97lTINB8/2d/7K3VPBnmORum8JF0xwVji?=
 =?Windows-1252?Q?3D6nweoTtyDPVZAbpTDrEzK1rlSrvYB1UFoSHnpUNef0BO2MpnQLH44m?=
 =?Windows-1252?Q?eymj/AWausSm4OaKirNhzBDJgrkQaYx3wArF1Ov0hs3LdD5gqJnPmUah?=
 =?Windows-1252?Q?dQEwvtf5mQtPc5JfeT/9878DJ7lBkI0OL9Lz6VkQvfcVMsOpsluoX7Xy?=
 =?Windows-1252?Q?rVWRmI1kDRhcy9idQ0OU7vFvYE/87d2QWsFY2FU3GAvn32InBQWlz8Li?=
 =?Windows-1252?Q?zDRTItiJfV0NGm+fiW/u6lvY2dT5bGW7Hq4z1QEPcfK/bxTisRMPz0hn?=
 =?Windows-1252?Q?TVTbdds24RR7qs9q9Uj2aSozWvX2Cl4ziJ4Q2Ior1lXUPd7Zc4cXeJkv?=
 =?Windows-1252?Q?Ogeffk78P84B7hL29VxQbXQ0dWva2gBCBJU/qnFPk62xZx1wxZXFPybt?=
 =?Windows-1252?Q?6rko1rj1vaAyQDs+IJ3k/iXPs9FZQKPPsbeD0wHQtJvYc0kA9sA57c7t?=
 =?Windows-1252?Q?2chEMguuIzCwYUALjLRO8b6O+I3QANnschPbXYc/WLiNX+TllHrIuO01?=
 =?Windows-1252?Q?pF979EbujdaWP9TYBWIV9cSwCmrdWD8emFeeACpLA470PW/iGsaWecCf?=
 =?Windows-1252?Q?+vt5qXHSDTCA1HJhtAtY76m9otpoIV/UacsLQWTKjpsJNOiPKw0fK801?=
 =?Windows-1252?Q?uzQG0tM2XsnEdpTYJtP02CHD2hOrWRTV2LDMNUvCJFSOymcybnzjnKwv?=
 =?Windows-1252?Q?SVE9gYpDtAeyS/l7415SvO52sesOT+b08lS53wZeIW9BtYgil+hU829f?=
 =?Windows-1252?Q?kQbAdKx2PhWBUHcWDOWHiwPLAo4cd0pe0TLQzvnNmOkhFTgqKrM02c+a?=
 =?Windows-1252?Q?gF/WB8kQmvYvHzIaCXzX7sMU6A8A2igxXHZMgHtRHXW6KJHtDkG/s/+3?=
 =?Windows-1252?Q?mowqi8CFllzvScbuSJADa9HsHt4Ab8KZagVh/vtsFHppuPoRkLXtc9m4?=
 =?Windows-1252?Q?uvNDoXegGMKkRqyzCK+BMRfiRk6hzsiJabEMPar9zZ76hZyLinrjubGm?=
 =?Windows-1252?Q?j3BWoi8/TUc2+bbbjrZIb9vUfhLAwOrsK7GqBO7rFLX1GNgldou4SyID?=
 =?Windows-1252?Q?msa3S/brxXNBNOwHqNtDjh/OVlrvIidetLgPLX8bU1BdHxZX39N2f+xj?=
 =?Windows-1252?Q?SQXgdHxP4fwq++kfUqxDh00jLjKAtB9aVY8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a01c44-9f2c-4b5e-2940-08da38256a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 16:50:57.8706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRAKibnVfVdtNVWMLi/qTHN7ifjzUePvH10q5fQN16AlOMNnV9PYkm+0ky++dJOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3441
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9BYAPR12MB4614namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Ya, second is too lengthy.  Better to leave it as it is.

BTW, is this specific to reset by BACO? BACO entry/exit may take longer (be=
tter chance of suspend entry abort by some wake-up source).

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Tuesday, May 17, 2022 10:00:16 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s=
2idle


[Public]



> PM_SUSPEND_TO_IDLE should be under a compile guard



It is actually.  All of the amdgpu_acpi_* are.  It=92s not obvious though l=
ooking at the patch, you need to apply it to notice it.



> It makes sense to rename to something like amdgpu_need_reset_on_suspend()=
 as it decides on reset only for a suspend situation.



Remember it=92s in amdgpu_acpi.c.  So it would be amdgpu_acpi_need_reset_on=
_suspend()?  It=92s a bit lengthy.



From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 17, 2022 11:25
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s=
2idle



[Public]



A couple of things -



PM_SUSPEND_TO_IDLE should be under a compile guard



It makes sense to rename to something like amdgpu_need_reset_on_suspend() a=
s it decides on reset only for a suspend situation.



Thanks,
Lijo

--_000_BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9BYAPR12MB4614namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Ya, second is too lengthy.&nbsp; Better to leave it as it is.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
BTW, is this specific to reset by BACO? BACO entry/exit may take longer (be=
tter chance of suspend entry abort by some wake-up source).</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 17, 2022 10:00:16 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd: Don't reset dGPUs if the system is goi=
ng to s2idle</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheaderc10f11a2, li.x_msipheaderc10f11a2, div.x_msipheaderc10f11a2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Public=
]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:bl=
ack">&gt;</span><span style=3D"color:#212121"> PM_SUSPEND_TO_IDLE should be=
 under a compile guard</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">It is actually.&nbsp; All of the amdgpu_acpi_* are=
.&nbsp; It=92s not obvious though looking at the patch, you need to apply i=
t to notice it.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:bl=
ack">&gt;</span><span style=3D"color:#212121"> It makes sense to rename to =
something like amdgpu_need_reset_on_suspend() as it decides on reset only f=
or a suspend situation.</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Remember it=92s in amdgpu_acpi.c.&nbsp; So it woul=
d be amdgpu_acpi_need_reset_on_suspend()?&nbsp; It=92s a bit lengthy.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt=
; <br>
<b>Sent:</b> Tuesday, May 17, 2022 11:25<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd: Don't reset dGPUs if the system is goi=
ng to s2idle</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">A couple of things -</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">PM_SUSPEND_TO_IDLE should be under a compile guard</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">It makes sense to rename to something like amdgpu_need_reset_on_susp=
end() as it decides on reset only for a suspend situation.</span></p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<p class=3D"x_MsoNormal">Thanks,<br>
Lijo</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9BYAPR12MB4614namp_--
