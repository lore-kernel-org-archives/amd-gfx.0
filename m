Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB1C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 18:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B51206E9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 18:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="McEo4EBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B51206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9E26EA92;
	Thu, 16 Apr 2020 18:43:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625936EA92
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 18:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHpDrkDRgWsJgRdOZtgfDBQ+97TaUD3VwlaOYU5CmgIzwDkwMfYZHiPZ90MmARAYE3Pp0vfFbT25h0VakF/OKXSCbhP1Gw9CqmCsrexpg2Fl3kA3xA7Zr6tBWXamfYYIy8jgtIidEIDpdI5Z3er38XyE4dvJhYejD0HZl8NTKkcahz8jPZfnzzYPW1Eb4KJH3hpUviP09aSfDYGPCR6pLj0QKd62Joj0GWSfEeWw7sVrqvNMTTF5ED1bUVAAny0IDqLNmyoK44od3kJbOAAoSMSTKGz7JwI1c/oJ2FChB67WAWg6wtQdCyDg5lHVj3NH+qXFls4HHkuUTwOn0T95gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K/wWAZ1xD/6wxwGB44apaYihCink27ENLcQLTgisOg=;
 b=QUnu/1VXU49atstmZvs20NmVBVgUr+0xEVewX60sqHTdlkBBs5OZC9ZRGyOtoPnoxfra2Ngvngn/LKT/4fXr8emg6DAFBaUHfK2RnyagAua6FX/Ijq7UFcm21l1KKPSD+rWMDLd/bNsoNsMnRgYGsNGEeEa0/gw9naIJ4ocdwJL4oZNBwxLRZxyvgoIx5/aix5Edi/gJYIl5mLcwGqA/rbVm0A12bCz4afCAHppmd68X6EvAe6/Kha87/d0g3Z6XnN0tg2S+RvwtLmoC6IyZjI+mlKfk3VjH6pm/jXkvNrHfFGCkZEH/pqtIZz8/Kp4v8OvnQwE/tN9r7RxZ5niIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K/wWAZ1xD/6wxwGB44apaYihCink27ENLcQLTgisOg=;
 b=McEo4EBpbFol9ES5mX5Tm9qPIoq+5wHh9xPLtAlzgiHbk20fkCYz3QANZQ0yo1flPb7RXT/8FVu6HwCtKWusJCwEPN2IumbCdqozyh4A60wB2knXMNEcJIaz7QzwtHkIr+srQf/dO4n2uSZAHRlmftZrfirdAtr53POvSsP6Q+8=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 16 Apr
 2020 18:43:04 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::758f:7609:b573:448d]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::758f:7609:b573:448d%6]) with mapi id 15.20.2921.024; Thu, 16 Apr 2020
 18:43:04 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] drm/amd/display: Add HDCP module
Thread-Topic: [bug report] drm/amd/display: Add HDCP module
Thread-Index: AQHWE/JY6In4jWCQrE2xvM8YOwU6Qah8FUb+
Date: Thu, 16 Apr 2020 18:43:04 +0000
Message-ID: <MW3PR12MB455448E77485AFA60BB8F3F8F9D80@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200416132413.GA628534@mwanda>
In-Reply-To: <20200416132413.GA628534@mwanda>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-16T18:43:03.179Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
x-originating-ip: [99.252.25.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64fe0042-efc7-410d-9274-08d7e235ff79
x-ms-traffictypediagnostic: MW3PR12MB4364:
x-microsoft-antispam-prvs: <MW3PR12MB43640E30248CD918747E2101F9D80@MW3PR12MB4364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(66446008)(9686003)(52536014)(55016002)(76116006)(2906002)(64756008)(66556008)(66476007)(86362001)(66946007)(33656002)(7696005)(6916009)(478600001)(53546011)(81156014)(8676002)(71200400001)(26005)(4326008)(316002)(6506007)(5660300002)(8936002)(19627405001)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIMPIIg4YsTFsSQUbKKbhG4zmv3lz45/8cy4jKfhMquSY0FH/EC3FV1n9Q8OWod6jp7TmC5fwqMl7noJeKD9ZGrvC/0iEvA9F1BjiggfWpN9SH+f4dRZThE/AXnR2UQnmg6KqxOCpSPCZk4UnSjdeXAg0HiIjk05CLlOIOK/kVV/k0W92NahHF7v42pX7tK1b+CA1+Dn9m+l4wIYUOxd4DyUB6Nid9OF/3joGharkOWNxIiEowZkmbMWnef0BNnhYPuE2+eK0+wTdaypdbdmodTsoO76BrlJkgA8zMjIuJhnEMl7KZ+jNtwOibtoibgbANegP4AZvT93t0DvOoTVUB9TA/sZ7GF0SE4QnXkDQz3uyBmRDm8dBzj+6j4fiGSgmNmGvXjAnFiK8Z2u6i7RsOlu29Ahu1XiSjLrrgCpkSSj5mJJYKft21fTpt9vOVVa
x-ms-exchange-antispam-messagedata: +afVBro7nZ9HWjqVFJ4u8o73DSFfwWmMHloqwylBRE+X32oHw93u7WUowUpR2m/UGzVhUVjVQDb49GWZfYjM3aCp0xq1z7S9+ahjYMnoNI+LwHJon+MxfDAPh34jPrTa9vTopqVQWEZCgzYoH5/k3w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fe0042-efc7-410d-9274-08d7e235ff79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 18:43:04.2311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQnon98N1KQn6AutpkEIJAuC3/41O9jOHVTfg0NGpYyZeLR7YOKCu4jpxe50Hr3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0596627088=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0596627088==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB455448E77485AFA60BB8F3F8F9D80MW3PR12MB4554namp_"

--_000_MW3PR12MB455448E77485AFA60BB8F3F8F9D80MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi,

I will look into it, thanks.

Bhawan
________________________________
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: April 16, 2020 9:24 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [bug report] drm/amd/display: Add HDCP module

Hello Bhawanpreet Lakha,

The patch 4c283fdac08a: "drm/amd/display: Add HDCP module" from Aug
6, 2019, leads to the following static checker warning:

        drivers/gpu/drm/amd/amdgpu/../display/dc/hdcp/hdcp_msg.c:132 hdmi_1=
4_process_transaction()
        error: buffer overflow 'hdcp_i2c_offsets' 32 <=3D 32

drivers/gpu/drm/amd/amdgpu/../display/dc/hdcp/hdcp_msg.c
    77
    78  static const uint8_t hdcp_i2c_offsets[] =3D {
    79          [HDCP_MESSAGE_ID_READ_BKSV] =3D 0x0,
    80          [HDCP_MESSAGE_ID_READ_RI_R0] =3D 0x8,
    81          [HDCP_MESSAGE_ID_READ_PJ] =3D 0xA,
    82          [HDCP_MESSAGE_ID_WRITE_AKSV] =3D 0x10,
    83          [HDCP_MESSAGE_ID_WRITE_AINFO] =3D 0x15,
    84          [HDCP_MESSAGE_ID_WRITE_AN] =3D 0x18,
    85          [HDCP_MESSAGE_ID_READ_VH_X] =3D 0x20,
    86          [HDCP_MESSAGE_ID_READ_VH_0] =3D 0x20,
    87          [HDCP_MESSAGE_ID_READ_VH_1] =3D 0x24,
    88          [HDCP_MESSAGE_ID_READ_VH_2] =3D 0x28,
    89          [HDCP_MESSAGE_ID_READ_VH_3] =3D 0x2C,
    90          [HDCP_MESSAGE_ID_READ_VH_4] =3D 0x30,
    91          [HDCP_MESSAGE_ID_READ_BCAPS] =3D 0x40,
    92          [HDCP_MESSAGE_ID_READ_BSTATUS] =3D 0x41,
    93          [HDCP_MESSAGE_ID_READ_KSV_FIFO] =3D 0x43,
    94          [HDCP_MESSAGE_ID_READ_BINFO] =3D 0xFF,
    95          [HDCP_MESSAGE_ID_HDCP2VERSION] =3D 0x50,
    96          [HDCP_MESSAGE_ID_WRITE_AKE_INIT] =3D 0x60,
    97          [HDCP_MESSAGE_ID_READ_AKE_SEND_CERT] =3D 0x80,
    98          [HDCP_MESSAGE_ID_WRITE_AKE_NO_STORED_KM] =3D 0x60,
    99          [HDCP_MESSAGE_ID_WRITE_AKE_STORED_KM] =3D 0x60,
   100          [HDCP_MESSAGE_ID_READ_AKE_SEND_H_PRIME] =3D 0x80,
   101          [HDCP_MESSAGE_ID_READ_AKE_SEND_PAIRING_INFO] =3D 0x80,
   102          [HDCP_MESSAGE_ID_WRITE_LC_INIT] =3D 0x60,
   103          [HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME] =3D 0x80,
   104          [HDCP_MESSAGE_ID_WRITE_SKE_SEND_EKS] =3D 0x60,
   105          [HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST] =
=3D 0x80,
   106          [HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_SEND_ACK] =3D 0x60,
   107          [HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] =3D 0x6=
0,
   108          [HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] =3D 0x80,
   109          [HDCP_MESSAGE_ID_READ_RXSTATUS] =3D 0x70

HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE is missing.  This array should
have HDCP_MESSAGE_ID_MAX elements.

   110  };
   111
   112  struct protection_properties {
   113          bool supported;
   114          bool (*process_transaction)(
   115                  struct dc_link *link,
   116                  struct hdcp_protection_message *message_info);
   117  };
   118
   119  static const struct protection_properties non_supported_protection =
=3D {
   120          .supported =3D false
   121  };
   122
   123  static bool hdmi_14_process_transaction(
   124          struct dc_link *link,
   125          struct hdcp_protection_message *message_info)
   126  {
   127          uint8_t *buff =3D NULL;
   128          bool result;
   129          const uint8_t hdcp_i2c_addr_link_primary =3D 0x3a; /* 0x74 =
>> 1*/
   130          const uint8_t hdcp_i2c_addr_link_secondary =3D 0x3b; /* 0x7=
6 >> 1*/
   131          struct i2c_command i2c_command;
   132          uint8_t offset =3D hdcp_i2c_offsets[message_info->msg_id];
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Potential out of bounds access.

   133          struct i2c_payload i2c_payloads[] =3D {
   134                  { true, 0, 1, &offset },
   135                  /* actual hdcp payload, will be filled later, zeroe=
d for now*/
   136                  { 0 }
   137          };
   138

regards,
dan carpenter

--_000_MW3PR12MB455448E77485AFA60BB8F3F8F9D80MW3PR12MB4554namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I will look into it, thanks.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter@oracle.com&gt;<br>
<b>Sent:</b> April 16, 2020 9:24 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [bug report] drm/amd/display: Add HDCP module</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Bhawanpreet Lakha,<br>
<br>
The patch 4c283fdac08a: &quot;drm/amd/display: Add HDCP module&quot; from A=
ug<br>
6, 2019, leads to the following static checker warning:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../di=
splay/dc/hdcp/hdcp_msg.c:132 hdmi_14_process_transaction()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error: buffer overflow 'hdcp_i2c=
_offsets' 32 &lt;=3D 32<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/hdcp/hdcp_msg.c<br>
&nbsp;&nbsp;&nbsp; 77&nbsp; <br>
&nbsp;&nbsp;&nbsp; 78&nbsp; static const uint8_t hdcp_i2c_offsets[] =3D {<b=
r>
&nbsp;&nbsp;&nbsp; 79&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_BKSV] =3D 0x0,<br>
&nbsp;&nbsp;&nbsp; 80&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_RI_R0] =3D 0x8,<br>
&nbsp;&nbsp;&nbsp; 81&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_PJ] =3D 0xA,<br>
&nbsp;&nbsp;&nbsp; 82&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_WRITE_AKSV] =3D 0x10,<br>
&nbsp;&nbsp;&nbsp; 83&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_WRITE_AINFO] =3D 0x15,<br>
&nbsp;&nbsp;&nbsp; 84&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_WRITE_AN] =3D 0x18,<br>
&nbsp;&nbsp;&nbsp; 85&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_VH_X] =3D 0x20,<br>
&nbsp;&nbsp;&nbsp; 86&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_VH_0] =3D 0x20,<br>
&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_VH_1] =3D 0x24,<br>
&nbsp;&nbsp;&nbsp; 88&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_VH_2] =3D 0x28,<br>
&nbsp;&nbsp;&nbsp; 89&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_VH_3] =3D 0x2C,<br>
&nbsp;&nbsp;&nbsp; 90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_VH_4] =3D 0x30,<br>
&nbsp;&nbsp;&nbsp; 91&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_BCAPS] =3D 0x40,<br>
&nbsp;&nbsp;&nbsp; 92&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_BSTATUS] =3D 0x41,<br>
&nbsp;&nbsp;&nbsp; 93&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_KSV_FIFO] =3D 0x43,<br>
&nbsp;&nbsp;&nbsp; 94&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_BINFO] =3D 0xFF,<br>
&nbsp;&nbsp;&nbsp; 95&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_HDCP2VERSION] =3D 0x50,<br>
&nbsp;&nbsp;&nbsp; 96&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_WRITE_AKE_INIT] =3D 0x60,<br>
&nbsp;&nbsp;&nbsp; 97&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_READ_AKE_SEND_CERT] =3D 0x80,<br>
&nbsp;&nbsp;&nbsp; 98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_WRITE_AKE_NO_STORED_KM] =3D 0x60,<br>
&nbsp;&nbsp;&nbsp; 99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [HDCP_MESSAGE_ID_WRITE_AKE_STORED_KM] =3D 0x60,<br>
&nbsp;&nbsp; 100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_READ_AKE_SEND_H_PRIME] =3D 0x80,<br>
&nbsp;&nbsp; 101&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_READ_AKE_SEND_PAIRING_INFO] =3D 0x80,<br>
&nbsp;&nbsp; 102&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_WRITE_LC_INIT] =3D 0x60,<br>
&nbsp;&nbsp; 103&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_READ_LC_SEND_L_PRIME] =3D 0x80,<br>
&nbsp;&nbsp; 104&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_WRITE_SKE_SEND_EKS] =3D 0x60,<br>
&nbsp;&nbsp; 105&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST] =3D 0x80,<br>
&nbsp;&nbsp; 106&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_WRITE_REPEATER_AUTH_SEND_ACK] =3D 0x60,<br>
&nbsp;&nbsp; 107&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] =3D 0x60,<br>
&nbsp;&nbsp; 108&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] =3D 0x80,<br>
&nbsp;&nbsp; 109&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDC=
P_MESSAGE_ID_READ_RXSTATUS] =3D 0x70<br>
<br>
HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE is missing.&nbsp; This array shou=
ld<br>
have HDCP_MESSAGE_ID_MAX elements.<br>
<br>
&nbsp;&nbsp; 110&nbsp; };<br>
&nbsp;&nbsp; 111&nbsp; <br>
&nbsp;&nbsp; 112&nbsp; struct protection_properties {<br>
&nbsp;&nbsp; 113&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 supported;<br>
&nbsp;&nbsp; 114&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 (*process_transaction)(<br>
&nbsp;&nbsp; 115&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link,<br>
&nbsp;&nbsp; 116&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_protection_message =
*message_info);<br>
&nbsp;&nbsp; 117&nbsp; };<br>
&nbsp;&nbsp; 118&nbsp; <br>
&nbsp;&nbsp; 119&nbsp; static const struct protection_properties non_suppor=
ted_protection =3D {<br>
&nbsp;&nbsp; 120&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sup=
ported =3D false<br>
&nbsp;&nbsp; 121&nbsp; };<br>
&nbsp;&nbsp; 122&nbsp; <br>
&nbsp;&nbsp; 123&nbsp; static bool hdmi_14_process_transaction(<br>
&nbsp;&nbsp; 124&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct dc_link *link,<br>
&nbsp;&nbsp; 125&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct hdcp_protection_message *message_info)<br>
&nbsp;&nbsp; 126&nbsp; {<br>
&nbsp;&nbsp; 127&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
8_t *buff =3D NULL;<br>
&nbsp;&nbsp; 128&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 result;<br>
&nbsp;&nbsp; 129&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t uint8_t hdcp_i2c_addr_link_primary =3D 0x3a; /* 0x74 &gt;&gt; 1*/<br>
&nbsp;&nbsp; 130&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t uint8_t hdcp_i2c_addr_link_secondary =3D 0x3b; /* 0x76 &gt;&gt; 1*/<br>
&nbsp;&nbsp; 131&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct i2c_command i2c_command;<br>
&nbsp;&nbsp; 132&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
8_t offset =3D hdcp_i2c_offsets[message_info-&gt;msg_id];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^<br>
Potential out of bounds access.<br>
<br>
&nbsp;&nbsp; 133&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct i2c_payload i2c_payloads[] =3D {<br>
&nbsp;&nbsp; 134&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { true, 0, 1, &amp;offset },<br=
>
&nbsp;&nbsp; 135&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* actual hdcp payload, will be=
 filled later, zeroed for now*/<br>
&nbsp;&nbsp; 136&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0 }<br>
&nbsp;&nbsp; 137&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<b=
r>
&nbsp;&nbsp; 138&nbsp; <br>
<br>
regards,<br>
dan carpenter<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB455448E77485AFA60BB8F3F8F9D80MW3PR12MB4554namp_--

--===============0596627088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0596627088==--
