Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4478AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 03:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E296860EE9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 03:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E296860EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C2789A6D;
	Mon,  1 Nov 2021 03:41:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2353989A6D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 03:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr7sBx+vQPqnMtlcNvhhZK221kOSMoLs7m2Lx1JPSMlk0Rr4WVax0ApOidCXhFH26Dxe98Tz+4QwBkZwZGyou5gyz6O5OZtLr+k6d9Z/YSsivlp1mkh4w+tKbmsOF6biUSQxs5k8sHB1DlBpL4Xe8l3YsybpXHA2GcxTWN/qxm6t4Gu6/Gh2tKCOAPZjPDdtrAE1d0Vq0Rq4rysoDeDVq3eflViIPIVOjtSKbSEACoeIokgK/chkaWPMgW29MmaDkiTUdsOLsBsAo7ZHLPujEZPa44CmUDPRcpq/Kt/ZWEVODa3J8upe4uijYU6Yezzal04vqF6hGB4HPoyWcYLw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NWXZNB7b5b9LvHUdPfh/Y2rkyvaNfkvWKa+8vU0oN4=;
 b=I3fpIV+gejpKOV2dwHV+LfffnF3eJGkWRkavySpiKEOYd8BV4a4/5t6yflK+OYHrbMDpYrHFcrZdX5K3GQ/wvaHiPL5mMZVP4bTWUUSbRV0npXgYvEdJPAYjcakpe2Ah5/NRJ0MWG68Ewn4OGKftg4ibjODVx3iNXnoNeszz4uvwE4m0WfuaSJqPoJfrw6pJ6+l3TSgtZov26RbycFbM+9j/IyJU+a/tax4hmmqxfTLiGdflQc0AeE+6xkmO9HimXA0vodw0yykpKP0N4bfFeK/bmrtgIRvYZE4FeINKmuZLoojvVq8r9PGGpKsqmaOCGBKjrf3VGED4/HjN3HkY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NWXZNB7b5b9LvHUdPfh/Y2rkyvaNfkvWKa+8vU0oN4=;
 b=t495fWoSmIPZZE7lGkidyfnKFgdO/YTzQm6IQYht6SpAhU8yuUa1cz2bPh4VJmULifKHWqn1ssdDB6sIQ76HMfsfXSRqjApRR4abWmiDJRy+VByuiAN+B6bgKu5qzCvkQJiw2XJnit8d91U3lolBFHwPQJqqU1MGpJ/fjUEynFE=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 03:41:25 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 03:41:25 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Topic: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Index: AQHXzQpiIf9c19Z+W0GxY0VJfXQSjKvq55aygAC2rgCAAAaGeIACVnaAgAANn04=
Date: Mon, 1 Nov 2021 03:41:25 +0000
Message-ID: <DM6PR12MB3930080025C79479A766EAFF978A9@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211029211717.28519-1-mario.limonciello@amd.com>
 <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_PDhA61gJYTPg3Dn=zy0hrt2ZJJN4TYm5WJRQfACrjDbg@mail.gmail.com>
 <DM6PR12MB3930BB63A500C4E548B697FD97889@DM6PR12MB3930.namprd12.prod.outlook.com>
 <SA0PR12MB4510B9D577B9B4FE3608AD30E28A9@SA0PR12MB4510.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB4510B9D577B9B4FE3608AD30E28A9@SA0PR12MB4510.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-01T02:46:26.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d4cf3e-dbb1-4021-81ce-08d99ce97aea
x-ms-traffictypediagnostic: DM5PR12MB2581:
x-microsoft-antispam-prvs: <DM5PR12MB25814C64DA2DDB2F4509B2CD978A9@DM5PR12MB2581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0ePF3llflMjS/2zE2Sw+ZSua3eGeZz0TivF1+SeDZEUK0HY6ub3SzCuXFmQMMBoyXaUHFhUyeMdAz2GTmZ30gOP7k9+kbf0oJ7xjEErBzKFn7lAImA1ZFuTNqNKZEfNd0ehvGFjBDAhRkpTXuxMFOE6/YSzbXdACnoCvQmTEP3bsSUrG9Hssw+48xMyOZpTXBFOPX6Z+uwFum26j4jRX63b7THGeVppAJWasHqq/+GiTEGl/kyf92+LdrX92WrlLjtZbAvoUM5hoRWxmEiNB02lPiab2jA556MlEixrrniSVuuf4AT0oh9M5Axu1C1lElLLbuETmIvCqkY+Ss01tDU1TWRXKpELbz+B8Lyd/7kwtuzszfvNK5T0qWPty/73qYRqZ47U0F9gvHioPuS6lCDvviHTaU1UQzl5WFsog2/LIRhmhcYA0zYa1P2NtbQvgmB/ZbqB5hKtOieM6w/zSA2I3nMthBH3X6XvNN4UwWl0chjurm6jk+P/ybrjwpe7fPJiw6hcjJ7Df4i3uKAK0IDc9cjk7AP6CUvtdudUtrITJ+5BplYJHrp2GpyIMIl5MVWqop7IMKXviBCL4xACIdjJdFAl4gjmJsuN1YW9IdU8hwgYxKx03PnRg4gNjIX/ZNKkNAIQS4lt5VZdqve62688CqxGQfPh9qiPrDSPEbh7qL37SY61CdzjQzcDP83p0ImK/Uy2kJjX1zBdL12Ymg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(19627235002)(86362001)(55016002)(64756008)(5660300002)(91956017)(66446008)(71200400001)(66556008)(76116006)(66476007)(66946007)(52536014)(508600001)(9686003)(110136005)(26005)(8676002)(4326008)(186003)(33656002)(53546011)(6506007)(2906002)(54906003)(316002)(38100700002)(122000001)(38070700005)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?4Jf/f4WLiMbFvvtzpFW6Hxla5z/62qsRWT6bDJkkvb5As78gjSVIYOKF?=
 =?Windows-1252?Q?aqo2r4Efz5utyeP72IKFxJdb3jqn2BNvskh96gSiYmTidRlIBEd33V0d?=
 =?Windows-1252?Q?oxCPZ1WbyYEzRlEKatQ5tl47+4LrovgOLWykyOg03h6uOwqsQW8ljLSF?=
 =?Windows-1252?Q?GdN+ua8ZzJp+1PQ4vBwC/yq5skRU/ScWaYRx+cGXcACcxP2E/jw6P4l8?=
 =?Windows-1252?Q?6I30FbDFF8HskxUyJuXu2BWsXzkv6syrzRJA9K0TaqY6rcYtUDsHToPd?=
 =?Windows-1252?Q?lZu8K5j2/mLeF9C1iRin2e6vvKcdMzmwEs8tV76sHmRImU642FPZY/CI?=
 =?Windows-1252?Q?KDan8tFY/4FUUPNdF3BnKByCunZ2X4j4B2HW+H6Lu5xQOoEXg+1mUR+d?=
 =?Windows-1252?Q?AR0z8QxIgF2PbxNVyThzOdmAopfhu5uWjFMTISCaiuUaQICM4rMtf0w1?=
 =?Windows-1252?Q?rauZsbqR+MHsUrCldrvBp/OfHmmXdKw4LVzLDghVoEdwEI9g0POsi3xt?=
 =?Windows-1252?Q?m7bkrjNKSTzigsMDLYUmX6ZQNxXUWTR4j/Ra9Gf2k/vmnHz+qwunMycf?=
 =?Windows-1252?Q?m86zpXv7ThR6hysA7Ko16gFUdTvi1p+e+4cBxY/3v66+gIHUEFQIESag?=
 =?Windows-1252?Q?dnYMjA6WWr1HXxtDtlwSE0No1JfzG5VUX8c1Gh0WB7WVF5EliZOOUj/P?=
 =?Windows-1252?Q?WJc4V7vCAq4yHWlD8L6gREWS7YTKuzXMW5ORG016K5mColPJRlZ06JcY?=
 =?Windows-1252?Q?xE19/upKMslhWFZ5hzeA2+0F5KsnpTJsD85c0xTXpByrJcwrHRzVoTMv?=
 =?Windows-1252?Q?loXvw8ImF4ojj0LLvG1OszUvfK5wHp4FPKRGLC5LbB3eHCTyivBSSE4i?=
 =?Windows-1252?Q?ApX9DQ5XDC+8Mn+sgYupDFOX30VhQoqnkieHRs13+UNN477vp8Pf88v8?=
 =?Windows-1252?Q?9OT0WEEfex3lyaA14Bf4avWvxcbkmrcr74g0b/gHRe64hpLrulUTb/Pe?=
 =?Windows-1252?Q?rrAsH2B9lS377Pd6zTAx2R0h/JoJr6PONv32frd8lI7LIOXASJ8+akg/?=
 =?Windows-1252?Q?Bc3bvjFhR+IMjUICxmc/OtND0/HhH4bwVhRq/3nTSHYO8RWg2UmZJHhY?=
 =?Windows-1252?Q?yg/q/VorG5wIBNAsjFqoCvqx4kkSqzqsYjgj8K/qN4WbbK9UcwL1Yrhu?=
 =?Windows-1252?Q?Q9bM/ZFi++LI9HEJMnPimEM/7+VsJSve1DRg2O8HTQI39XpeBoxMlEar?=
 =?Windows-1252?Q?36HwHwMtuQHNYgSyQyNzoWA2NQIAAU7gzx8nTxj14ipF8w3X4+Vl2n/D?=
 =?Windows-1252?Q?FkQJkXLAGK7c3jjXs6KyIsPMd126M3W0nRFd+eHoRCQ1EzmQrAHgmHYZ?=
 =?Windows-1252?Q?NF2hpB/HgWofT/IroCKVmIAYUQNrBM6oORTcegaugh9fpormIUZr8x9k?=
 =?Windows-1252?Q?q9liheb4SbBQP8KudETdX8y5gHaK5xctumlCmZYhUB7FszeX9k4YEwAT?=
 =?Windows-1252?Q?PJPDIYZ3TXC5PWZ/SycXLwzAWm8IQvz+rEg0375dKYKuwY0HUzadunR3?=
 =?Windows-1252?Q?xPIozxizS2H7YL+ZXXFccd7GK6Yhp846uOYvRsJxIp2xTzvYglWYh3k4?=
 =?Windows-1252?Q?zr51t2tCjwzIzZhf3VpxuRHvL9L8Df03bklGx4f0cXDklUzGftBbx1MN?=
 =?Windows-1252?Q?uFJ/sePgx3pKttvMv1ucyAfA5vtsc5A2?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3930080025C79479A766EAFF978A9DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d4cf3e-dbb1-4021-81ce-08d99ce97aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 03:41:25.1568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVchmkOllalpYwLcnYHHCDlQwxFxGNZFqsGcRy6q+FmYzOXYSEvLLtAgD+gPaOup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
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

--_000_DM6PR12MB3930080025C79479A766EAFF978A9DM6PR12MB3930namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

There are two subsystems - powerplay and swsmu. The subsystem implementatio=
n details are hidden from amdgpu_pm funcs. I thought Alex is talking about =
that.

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Monday, November 1, 2021 8:16:27 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC=
 and later APUs


[Public]



smu_get_power_profile_mode actually calls smu->ppt_funcs->get_power_profile=
_mode



So shouldn=92t it be sufficient to do this?



        } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {

                if (!adev->smu.ppt_funcs->get_power_profile_mode)

                        *states =3D ATTR_STATE_UNSUPPORTED;

        }





From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Saturday, October 30, 2021 10:06
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC=
 and later APUs



[Public]



For swsmu, we could add a helper macro like smu_is_supported(x) that checks=
 if ppt func is not NULL.



Thanks,
Lijo

--_000_DM6PR12MB3930080025C79479A766EAFF978A9DM6PR12MB3930namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
There are two subsystems - powerplay and swsmu. The subsystem implementatio=
n details are hidden from amdgpu_pm funcs. I thought Alex is talking about =
that.</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, November 1, 2021 8:16:27 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Alex Deucher &lt;alexdeu=
cher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode=
 for YC and later APUs</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Fira Code"}
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
<p class=3D"x_MsoNormal">smu_get_power_profile_mode actually calls smu-&gt;=
ppt_funcs-&gt;get_power_profile_mode</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">So shouldn=92t it be sufficient to do this?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"line-height:14.25pt; background:#1E1E1E">=
<span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#=
D4D4D4">&nbsp; &nbsp; &nbsp; &nbsp; }
</span><span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; =
color:#C586C0">else</span><span style=3D"font-size:10.5pt; font-family:&quo=
t;Fira Code&quot;; color:#D4D4D4">
</span><span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; =
color:#C586C0">if</span><span style=3D"font-size:10.5pt; font-family:&quot;=
Fira Code&quot;; color:#D4D4D4"> (</span><span style=3D"font-size:10.5pt; f=
ont-family:&quot;Fira Code&quot;; color:#569CD6">DEVICE_ATTR_IS</span><span=
 style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#D4D4D=
4">(pp_power_profile_mode))
 {</span></p>
<p class=3D"x_MsoNormal" style=3D"line-height:14.25pt; background:#1E1E1E">=
<span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#=
D4D4D4">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span><span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; =
color:#C586C0">if</span><span style=3D"font-size:10.5pt; font-family:&quot;=
Fira Code&quot;; color:#D4D4D4"> (!</span><span style=3D"font-size:10.5pt; =
font-family:&quot;Fira Code&quot;; color:#9CDCFE">adev</span><span style=3D=
"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#D4D4D4">-&gt;<=
/span><span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; c=
olor:#9CDCFE">smu</span><span style=3D"font-size:10.5pt; font-family:&quot;=
Fira Code&quot;; color:#D4D4D4">.</span><span style=3D"font-size:10.5pt; fo=
nt-family:&quot;Fira Code&quot;; color:#9CDCFE">ppt_funcs</span><span style=
=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#D4D4D4">-&g=
t;</span><span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;=
; color:#9CDCFE">get_power_profile_mode</span><span style=3D"font-size:10.5=
pt; font-family:&quot;Fira Code&quot;; color:#D4D4D4">)</span></p>
<p class=3D"x_MsoNormal" style=3D"line-height:14.25pt; background:#1E1E1E">=
<span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#=
D4D4D4">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; *</span><span style=3D"font-size:10.5pt; font-family:&quot=
;Fira Code&quot;; color:#9CDCFE">states</span><span style=3D"font-size:10.5=
pt; font-family:&quot;Fira Code&quot;; color:#D4D4D4">
 =3D </span><span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&qu=
ot;; color:#4FC1FF">ATTR_STATE_UNSUPPORTED</span><span style=3D"font-size:1=
0.5pt; font-family:&quot;Fira Code&quot;; color:#D4D4D4">;</span></p>
<p class=3D"x_MsoNormal" style=3D"line-height:14.25pt; background:#1E1E1E">=
<span style=3D"font-size:10.5pt; font-family:&quot;Fira Code&quot;; color:#=
D4D4D4">&nbsp; &nbsp; &nbsp; &nbsp; }</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt=
; <br>
<b>Sent:</b> Saturday, October 30, 2021 10:06<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<b=
r>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode=
 for YC and later APUs</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">For swsmu, we could add a helper macro like smu_is_supported(x) that=
 checks if ppt func is not NULL.</span></p>
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
</body>
</html>

--_000_DM6PR12MB3930080025C79479A766EAFF978A9DM6PR12MB3930namp_--
