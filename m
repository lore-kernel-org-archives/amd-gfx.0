Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7AC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6411561075
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6411561075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93AA6EE3D;
	Fri,  7 May 2021 14:50:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738F66EE3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDGjdsSkX5ZduZMmyjhECg4lfwpu1UjUA0mdV4QAYH2kCLp4A3danRkCG0/6g4qCEegCDXYfEiFsZjNJP9zYazyNf33MAjhEY4v3xEgZ3qm2PNtsTrj8FQEOerh4fjbTOVG34TD2HOhbI/oEeGza8sm1SftKY9UiUNhDwgLhXOCYeLubTXRT1yP804RKbwdUCZCu7/f+q7/CX9CnlcP0ZdfTN1Z3sZJWvVfPsvTUNDcuvf1pq1Y85H5ZcpZFclsJPvVtIM1Xbqs+9zva0eHN+sDGQw8ddtaK8O2W+Z0KWDx6mAEBEE+EOE7TSLRLMguYgUc5IW6yqMPj1VsZUhfr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTkQJGEGDouoVgWohKkdMZworyJtmnFh1dms9rcy71c=;
 b=KB+HeCY71jVdxQa8U9egNWUZ96jjgCE5fJMAnNCJiOnjPAsiPS9h4fILa0MIsns7dyqwtEs9tT57QuEDahk7cJWXssl2EuNESXYNNsBeZkjnr4aSljGpZ8xW7Rc6MHsPSB2GympTafeOfdfP2sRGzvv+En01yhyqHm27H920Hc/DFJQg1VaSZzotPE9059evEHo2hjzvXAa8r1mSOv7xO79hvrTWnpN23hPCevSwLYkU9SrONrlZpNcwI3rqDpDRIAZX9vm13HFqkfj35lBFM6NmC1MHWkYRVrx2Q0F8Df5WUp39Ci99RDUu2OGypsbIbwPE1emSNYEut5oNXMxd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTkQJGEGDouoVgWohKkdMZworyJtmnFh1dms9rcy71c=;
 b=oQK9z4wN4T/PCKOYdqkkF0kyIgGz0iqfqZPNkbAMU8D03FGkMci5Thl+LrBYGWIXUno5mQ/GciO7R/c8IpKBspsoGAHfRIN9r+zsVmVw/ebdQBLXlfbEU3gwjwnuwRdif1LFkQXeX5ZLEP8eUnCo+HSVonQwzQdY5r8T5TS/9Ss=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR1201MB0262.namprd12.prod.outlook.com
 (2603:10b6:910:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 14:50:17 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 14:50:17 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/1] Fix the slowdown for Vega 20 server boards
Thread-Topic: [PATCH 0/1] Fix the slowdown for Vega 20 server boards
Thread-Index: AQHXQgxK0jbrZeCiNEiHVLUBGmLN0qrYHFmJ
Date: Fri, 7 May 2021 14:50:17 +0000
Message-ID: <CY4PR1201MB0072A69FB75239E315B2FD50FB579@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <20210506001038.15150-1-luben.tuikov@amd.com>
In-Reply-To: <20210506001038.15150-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-07T14:50:16.094Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [114.88.229.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15804ac6-45e1-4cd5-1a9d-08d911676dfe
x-ms-traffictypediagnostic: CY4PR1201MB0262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0262C115FF0BEE198511E746FB579@CY4PR1201MB0262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RI1QSmvO2qNsNl42K4zIEhFnuTAKI3ApzlXS41FL4DxywDaEvlDfqyOkgHQ3k152RZ3eC8rYkltN8s8kPANqJ4Hj8PdEpyjVMU2AbaI+Wui6wb4MGVNtcmZ+L9aUkTNCuqXM3vEy19FXm5pVcpw6CIWj7SWQq2w75NlSQqwAOX23qTspJ0fnjVvHvqHxw9hYEw03W7IrBFDgXy3tVYblzhJkfZFLzHFeV0kSQm77pyjvhaXS3/zJUJE+P+4vovEm3S/FY1+2V64umYtOekxckyK0N4CiZC6VWapzdeFvli9nItLP/RkmW8XzRrTSylq/XafOJ8rNEhio6TZf/pknaEm6K8kaxyZKhIxyC4q5pFBcmsSxIjYkzxb3lZbEPF90n4nhgnmdWSe0/fU4x/RqgylMKnqWOCrDSNXgEF0CHTn9Oa7alHVt6U4j9vLkwpXK7q39hnfxL+2vqATgwojj97wz2N/JeH9z3D2v92AU9MIQ4ERnrBLxy4skBXzH2e/unlqHqW8om/NcqvoI1sVe83Cwiaq20l+H0ZithX6+Wxv7gbBTWgBQLec0605iodnI9l9IFka7/2FbQup7EENdH/zSCQ5fz3EGMQ9LJzkN5eo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(4326008)(5660300002)(9686003)(55016002)(2906002)(86362001)(19627405001)(8676002)(52536014)(83380400001)(478600001)(33656002)(76116006)(8936002)(66446008)(64756008)(66556008)(91956017)(66946007)(66476007)(71200400001)(316002)(186003)(38100700002)(110136005)(53546011)(6506007)(7696005)(122000001)(26005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bOhLjkrUYmqqeRc3kJOH+808iaKu/0f2pxv3La3Vb6jHsXDt3wCVXFsmWR?=
 =?iso-8859-1?Q?/AnPX4B7ZHT9j2+LpTdaOnGMub5qmBkcP1A+WfVolRHPCf/nK99kuTUPjH?=
 =?iso-8859-1?Q?HESJFSTwMiCfwe6s0YE22gRfYUudzA9M62n2nhDP0wgtUVFln64AouRxV8?=
 =?iso-8859-1?Q?2Sl448tZiNLlIB9iERERi6dxv6PnCa3Ev26qpXItaeMue2z9KX4vjEFLwC?=
 =?iso-8859-1?Q?n4dx4Yv+j0wDZqXd5bcxBo384cLuJatEISH8FDG0EnUQXqvcLs50GufYCa?=
 =?iso-8859-1?Q?FJOtbF5EDaWUx+y65lOq8Daq4zkrdWoFkHuf3v/DtV7LrDebR6l4N2bjVO?=
 =?iso-8859-1?Q?U2+dvoDwneNCGgcH8KygBvShVKghvjqxzAPBymV8/piDBLGnTd+NczT6UQ?=
 =?iso-8859-1?Q?K9X5Hyh4YC7kXWU5l+7C0WQGb8IK5VFturexSPU9O1q68uAN02aVfhan09?=
 =?iso-8859-1?Q?dXKqbiGYOTTqn9m+wjlk6s3q1Of8F9rmBDznaG3bNCBORy0O7+NslKcBnV?=
 =?iso-8859-1?Q?gdfEjHYWsPcE/vp9gmMoQt7BDK4vsmoz5vf3t53yHj9Ff4DQG96cegFIVF?=
 =?iso-8859-1?Q?Rc3iojYhJWeVmUskq/r+x2dieL1lgZL52WuBoDYG1KkS0ShOtsAdzKm4+S?=
 =?iso-8859-1?Q?69inKEpa1ez8AJenAebK1VWbrfHyrkrm0HjzlNHdRse+w1q5Lt+zspTbak?=
 =?iso-8859-1?Q?KKVOW1ijQuRVdwVBZUlKFCp0YkHac4jBzXQQz3R1+Gjk/TdWVN0wGvXeML?=
 =?iso-8859-1?Q?usDajXCjwnVfbZQB/RuDbCaWl9bdhYAZ4zUgwjUd4PPweicvvMv1kke4sy?=
 =?iso-8859-1?Q?tDyCpuAEwXJV++W2C7dsC+O5iU8d/ECQqq6rMQr0DaoZCAspfsX7M5qDSn?=
 =?iso-8859-1?Q?95fbZ7KYt4D2uKkE32DBf/fY5SeTRISS1bYfiw5Bb9RViXoXya41UwRJqF?=
 =?iso-8859-1?Q?ntcUWL3e+xO5CQZ6m14gw0DzwSz89a0uwspEF7qR0lSzSFax36+bmrn/6z?=
 =?iso-8859-1?Q?ozO6uOVnV4rsNoYKGIp4mgR4FuVCgtRJH5mOGK+s3hGWKRiX8VRO33A45z?=
 =?iso-8859-1?Q?GS/Svbm2uth5IjjaWlw4HWNO1UOfo3dkIJraeWaCbtarw0HWpG7vaXU1jO?=
 =?iso-8859-1?Q?aiU4YMhJG+yW0MAlsWINb7SoZk667zUL8LhSpAvP4/xoERCCrXen63q8ZQ?=
 =?iso-8859-1?Q?qfzzINCuigKqCeixzi9HLiPLX+ybkLvFm/ZlQFCwiebIXByEX2j4dT5He9?=
 =?iso-8859-1?Q?A8L60CooeiJ9P1eDWeab9jp5rSHjBa2IPknUyAmM2mXyFW493tGbFoblhe?=
 =?iso-8859-1?Q?VuwJgm/mM91oqMnMvVdilt+ykUPOq+OxiiEG2MvlYa0dmYU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15804ac6-45e1-4cd5-1a9d-08d911676dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 14:50:17.2739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2dN31jAPECZlfk2rjHG67Oks3TlHUL4VMNanSUqV25bH24j2DFX/iExfYXU5A9QqyeCE9Eoa7amIIiBT1qK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0262
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1498703773=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1498703773==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0072A69FB75239E315B2FD50FB579CY4PR1201MB0072_"

--_000_CY4PR1201MB0072A69FB75239E315B2FD50FB579CY4PR1201MB0072_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Patch is:

Reviewed-by: John Clements <John.Clements@amd.com>

________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Thursday, May 6, 2021 8:10 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawk=
ing.Zhang@amd.com>
Subject: [PATCH 0/1] Fix the slowdown for Vega 20 server boards

This patch fixes the interactive--to the point of
unusability--slowdown when RAS is enabled on Vega 20 server
boards--which support full RAS.

Luben Tuikov (1):
  drm/amdgpu: Poll of RAS errors asynchronously

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 ++--
 5 files changed, 85 insertions(+), 26 deletions(-)

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>

--
2.31.0.97.g1424303384


--_000_CY4PR1201MB0072A69FB75239E315B2FD50FB579CY4PR1201MB0072_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><font size=3D"2"><span style=3D"font-size:11pt">Patch is:<=
br>
</span></font></span><br>
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><font size=3D"2"><span style=3D"font-size:11pt">Reviewed-b=
y: John Clements &lt;John.Clements@amd.com&gt;</span></font></span><br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;L=
uben.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 6, 2021 8:10 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Clements, John &lt;John.Clements@amd.com&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/1] Fix the slowdown for Vega 20 server boards</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This patch fixes the interactive--to the point of<=
br>
unusability--slowdown when RAS is enabled on Vega 20 server<br>
boards--which support full RAS.<br>
<br>
Luben Tuikov (1):<br>
&nbsp; drm/amdgpu: Poll of RAS errors asynchronously<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1=
 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |&nbsp; 9 ++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++++++++---=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 8 ++--<br>
&nbsp;5 files changed, 85 insertions(+), 26 deletions(-)<br>
<br>
Cc: Alexander Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: John Clements &lt;john.clements@amd.com&gt;<br>
Cc: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
-- <br>
2.31.0.97.g1424303384<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR1201MB0072A69FB75239E315B2FD50FB579CY4PR1201MB0072_--

--===============1498703773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1498703773==--
