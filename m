Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B38C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 10:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5054F2073A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 10:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wfToHPkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5054F2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2926E84C;
	Wed,  6 May 2020 10:11:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55076E84C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 10:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3uhhqsbENZXVcMGTMFu+OlhyFFFtgmiHOxP+n0KGVME2eu3TFGP44gHBK0N3KDx+65HYx1bkmOc5l/LjBY7VQFSyC8Kj2Bqjx/2oE98AOFIlhb4uUzdh4s1cK4bEr8kNpghmayu1N0aNTyuidKIhJiegsRRsSvTgFxJ5hsf0AGi9PZpY3AX+TB6jk6tpm+nR4omD/zRYf8IQcxX7+IHCfZ5eaYUMiQnZi/1ALn0t3HEJTAzn3XohI/5xH95scSbA/Gb+z9QpKiPM3AOQXHeMqm9A8Pzu/TRSGnmF/MNmtSzhLVVUKbS+T+xSEuJyJjcVuHyK3RDtuFFrM6ZPjLCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o71K5YXy/5W5zbeZqk13Iy9G72XyeRRlipzW+GrYUpk=;
 b=YFwslPDFnA4WGup8VKyQJN2ShUEp4yWBy/ChZlbkZBw4KI5Dt4QpZKdOoHithJTwBMKGWgmkYXd8/HEHUD8FojTwzFN/AIGSEQTMNMkQG+8fA19hFuOTXwqJNBGC7Bws7IBwPoMwE7hjyX3e6haztOjHGcA9dFWlY3REbZIa8E79glYmcZFigja631y75WNeq7JC2kcv9dVmxVx/GuovUwSm4OICwn+fsWwB+TjVw58FmdznUFRbHg3RcbeV8PHxBF6Ifqo3I3yvLNzXBKjjp9DuayCj8eE6DgF3bKEMF4bc392/+PNQo0vi1kHvrN86J1WmJMhheqEe0Lv4vYkTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o71K5YXy/5W5zbeZqk13Iy9G72XyeRRlipzW+GrYUpk=;
 b=wfToHPkMnlI2kY001TcqrVWmpGTszScYfPQIbapRt5NHAgncRApLLt8PszNK+BlriHLVcUfngNI/BTz0MQ9XzNyrf/kd/vlJpcOKFeMR+BSpR0/rmkJAzDys82DybfWvsJrO0+MNZBhge0TpjsVjBLmoQVKvW4yrFyitQSqSgAo=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2527.namprd12.prod.outlook.com (2603:10b6:802:23::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 10:10:57 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 10:10:56 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Thread-Topic: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Thread-Index: AQHWIr1ZHoATYm2B+U+G4L4WnXqlF6iaqcYAgAAfGQCAAA0BNw==
Date: Wed, 6 May 2020 10:10:56 +0000
Message-ID: <SN1PR12MB2558A472D85D6296CE250BBF87A40@SN1PR12MB2558.namprd12.prod.outlook.com>
References: <20200505091239.GA117990@mwanda>
 <BYAPR12MB288896162E5761D45A5077DFB0A40@BYAPR12MB2888.namprd12.prod.outlook.com>,
 <20200506091734.GH1992@kadam>
In-Reply-To: <20200506091734.GH1992@kadam>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T10:04:06.0398757Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.88.247.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb7dda53-0c18-4281-6017-08d7f1a5c4be
x-ms-traffictypediagnostic: SN1PR12MB2527:|SN1PR12MB2527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2527BA0BFED6F677EDB974F887A40@SN1PR12MB2527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQuPUYzrWZKqCgpt7JvI9BTldluJ9B/FjbsM1oWCoxbuDV0pAj5EcZGrx8NJBKqOer4mgrnclUSvBjj2DsPF2casQDVe81achTD8Z/ycovOWi8Z/BTSHFZVc5N7LNptp9lG6exNnztj09Rhidr8pRcchcTChPyUDfO3GRwp+RJxRimdB+TPivWrYm7f/oXYTvFjd+efGPkgk5UgCkTU90Slh440NZr3iw3kkw/sEx/CgDkmD/LOYuf6dhaEMXK4hvLpWq+ozxyGUCXxhCMLv/5cRpRiG9Zz8RzTfe8/Kd3pWz3OvwxtLvPDibcemZii62z8om4fwRmoDjNPNJFzAChyxg205Z32v8G2i0Ak5sjPS2oE3jR/ffAVdPj3Ld7vHw1oCnhgvV1+W10qLZR1/Xlk+tYOzPeoTbbyqnAJhIUDvoSzyqn8y3+oGHNxP0tEZ4QT+lpl6uwORS05a47dDczYF1OVpBd3u+JBYCTbH6YqAZrsjx5eX33l4abEmV4ivLiXxVmHQCiKY3rLHg2EgXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(33430700001)(66556008)(64756008)(66476007)(66446008)(66946007)(7696005)(52536014)(186003)(86362001)(8676002)(26005)(33656002)(71200400001)(53546011)(6506007)(55016002)(478600001)(9686003)(110136005)(33440700001)(4326008)(91956017)(316002)(5660300002)(2906002)(76116006)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mP4+b391xACHxlAVnnNhBPuwsO408KY3QzfOPR3MHCdh6Lnoc1CPbS/Fxxr/Ppa9J1g0Om1fplKGTtDgdN6Aptx6LpNgWnc3FXUaZgxE+CRgsfePZXiaTxlmtbte5hKBVWsexycIUWWGusBCN2KOdK7wB3i/bakd752Din5U1NTHK2KMCkFNFMFCTE5puYPsCSWcfYi452j5UsWs5pT4zlAjJ+hVEPcrVu9I+IJaWiR9SwwbOwin2kTyST/PUsqS/pPYhrCNRr34tD910/M0KHujJUSySMNOT8k41rQVjaCHCS1KQEcMDDBqTrfk77XpAPYKccZgYExHXFjZ7vJsMKk/+R7ode6ymh0GPpeGYjVg5RmlgR+mqiY2ceuQTOpXqy5KLaWcwcT4jq5/bozSCCn/M1M9AuV59J3IedshLNwTeLgAxww6uVItEjW0WhwDEPPlTF3YvRQF8jnAJ+/fLMNm3tf4dzRB7M0CX+jIju2JtYBEfdASeLtiq0OmuCS9Am66DH+AtpzGjpUEtxAQxhXnAgtA9PvhDtkyBQmkk520Yqe299Nb5//6WZA4Hx6LVBZZt27nEmw2RSLr1YBPgabmE6JiZW6bSN10q+9Rjcrsn2QbLRf25Qt0NkBwPEOu1NmZiXJsBX0Xtyd3w38LOKY6hbDsKnj5sYExpu1gBagXOz8fnykgE9MT4JSwBlC8+2pekSFoV/58TCPpZ9nCUjatLX3fgfrhOhV6QGllZgu4uwIFMqq9BTs8PzqCR5PRZxdzwDncAlReVZeiVlnSxnD+lRThptV3ZwFSQJZKW+Y=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7dda53-0c18-4281-6017-08d7f1a5c4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 10:10:56.7354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxkAwJPnTlU1moMG9NlMj6aBg2e1SjtS2zMmbyDj/MdCBrjfUanrJaHl5vQ+EDWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2527
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
Content-Type: multipart/mixed; boundary="===============0664415879=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0664415879==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2558A472D85D6296CE250BBF87A40SN1PR12MB2558namp_"

--_000_SN1PR12MB2558A472D85D6296CE250BBF87A40SN1PR12MB2558namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

no.  below function checks if block is valid or not.
I think you need check your code_checker. or you were checking on a very ol=
d codebase?

/* check if ras is supported on block, say, sdma, gfx */
static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
unsigned int block)
________________________________
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: Wednesday, May 6, 2020 5:17:34 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)

On Wed, May 06, 2020 at 07:26:16AM +0000, Zhou1, Tao wrote:
> [AMD Public Use]
>
> Hi Dan:
>
> Please check the following piece of code in amdgpu_ras_debugfs_ctrl_parse=
_data:
>
>        if (op !=3D -1) {
>                if (amdgpu_ras_find_block_id_by_name(block_name, &block_id=
))
>                        return -EINVAL;
>
>                data->head.block =3D block_id;
>
> amdgpu_ras_find_block_id_by_name will return error directly if someone tr=
y to provide an invalid block_name intentionally via debugfs.
>

No.  It's the line after that which are the problem.

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
   147  static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
   148                  const char __user *buf, size_t size,
   149                  loff_t *pos, struct ras_debug_if *data)
   150  {
   151          ssize_t s =3D min_t(u64, 64, size);
   152          char str[65];
   153          char block_name[33];
   154          char err[9] =3D "ue";
   155          int op =3D -1;
   156          int block_id;
   157          uint32_t sub_block;
   158          u64 address, value;
   159
   160          if (*pos)
   161                  return -EINVAL;
   162          *pos =3D size;
   163
   164          memset(str, 0, sizeof(str));
   165          memset(data, 0, sizeof(*data));
   166
   167          if (copy_from_user(str, buf, s))
   168                  return -EINVAL;
   169
   170          if (sscanf(str, "disable %32s", block_name) =3D=3D 1)
   171                  op =3D 0;
   172          else if (sscanf(str, "enable %32s %8s", block_name, err) =
=3D=3D 2)
   173                  op =3D 1;
   174          else if (sscanf(str, "inject %32s %8s", block_name, err) =
=3D=3D 2)
   175                  op =3D 2;
   176          else if (str[0] && str[1] && str[2] && str[3])
   177                  /* ascii string, but commands are not matched. */

Say we don't write an ascii string.

   178                  return -EINVAL;
   179
   180          if (op !=3D -1) {
   181                  if (amdgpu_ras_find_block_id_by_name(block_name, &b=
lock_id))
   182                          return -EINVAL;
   183
   184                  data->head.block =3D block_id;
   185                  /* only ue and ce errors are supported */
   186                  if (!memcmp("ue", err, 2))
   187                          data->head.type =3D AMDGPU_RAS_ERROR__MULTI=
_UNCORRECTABLE;
   188                  else if (!memcmp("ce", err, 2))
   189                          data->head.type =3D AMDGPU_RAS_ERROR__SINGL=
E_CORRECTABLE;
   190                  else
   191                          return -EINVAL;
   192
   193                  data->op =3D op;
   194
   195                  if (op =3D=3D 2) {
   196                          if (sscanf(str, "%*s %*s %*s %u %llu %llu",
   197                                                  &sub_block, &addres=
s, &value) !=3D 3)
   198                                  if (sscanf(str, "%*s %*s %*s 0x%x 0=
x%llx 0x%llx",
   199                                                          &sub_block,=
 &address, &value) !=3D 3)
   200                                          return -EINVAL;
   201                          data->head.sub_block_index =3D sub_block;
   202                          data->inject.address =3D address;
   203                          data->inject.value =3D value;
   204                  }
   205          } else {
   206                  if (size < sizeof(*data))
   207                          return -EINVAL;
   208
   209                  if (copy_from_user(data, buf, sizeof(*data)))
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This lets us set the data->head.block to whatever we want.  Premusably
there is a trusted app which knows how to write the correct values.
But if it has a bug that will cause a crash and we'll have to find a
way to disable it in the kernel for kernel lock down mode etc so either
way we'll need to do a bit of work.

   210                          return -EINVAL;
   211          }
   212
   213          return 0;
   214  }

regards,
dan carpenter


--_000_SN1PR12MB2558A472D85D6296CE250BBF87A40SN1PR12MB2558namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
no.&nbsp; below function checks if block is valid or not.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I think you need check your code_checker. or you were checking on a very ol=
d codebase?<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
/* check if ras is supported on block, say, sdma, gfx */<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
unsigned int block)<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter@oracle.com&gt;<br>
<b>Sent:</b> Wednesday, May 6, 2020 5:17:34 PM<br>
<b>To:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Cc:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [bug report] drm/amdgpu: add amdgpu_ras.c to support ra=
s (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, May 06, 2020 at 07:26:16AM &#43;0000, Zhou=
1, Tao wrote:<br>
&gt; [AMD Public Use]<br>
&gt; <br>
&gt; Hi Dan:<br>
&gt; <br>
&gt; Please check the following piece of code in amdgpu_ras_debugfs_ctrl_pa=
rse_data:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op !=3D -1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_find_block_id_by_name(block_name, &amp;b=
lock_id))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;head.block =3D block_id;<br>
&gt; <br>
&gt; amdgpu_ras_find_block_id_by_name will return error directly if someone=
 try to provide an invalid block_name intentionally via debugfs.<br>
&gt; <br>
<br>
No.&nbsp; It's the line after that which are the problem.<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&nbsp;&nbsp; 147&nbsp; static int amdgpu_ras_debugfs_ctrl_parse_data(struct=
 file *f,<br>
&nbsp;&nbsp; 148&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *buf, size_t =
size,<br>
&nbsp;&nbsp; 149&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loff_t *pos, struct ras_debug_i=
f *data)<br>
&nbsp;&nbsp; 150&nbsp; {<br>
&nbsp;&nbsp; 151&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssiz=
e_t s =3D min_t(u64, 64, size);<br>
&nbsp;&nbsp; 152&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char=
 str[65];<br>
&nbsp;&nbsp; 153&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char=
 block_name[33];<br>
&nbsp;&nbsp; 154&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char=
 err[9] =3D &quot;ue&quot;;<br>
&nbsp;&nbsp; 155&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
op =3D -1;<br>
&nbsp;&nbsp; 156&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
block_id;<br>
&nbsp;&nbsp; 157&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t sub_block;<br>
&nbsp;&nbsp; 158&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 =
address, value;<br>
&nbsp;&nbsp; 159&nbsp; <br>
&nbsp;&nbsp; 160&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
*pos)<br>
&nbsp;&nbsp; 161&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 162&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pos=
 =3D size;<br>
&nbsp;&nbsp; 163&nbsp; <br>
&nbsp;&nbsp; 164&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mems=
et(str, 0, sizeof(str));<br>
&nbsp;&nbsp; 165&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mems=
et(data, 0, sizeof(*data));<br>
&nbsp;&nbsp; 166&nbsp; <br>
&nbsp;&nbsp; 167&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
copy_from_user(str, buf, s))<br>
&nbsp;&nbsp; 168&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 169&nbsp; <br>
&nbsp;&nbsp; 170&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
sscanf(str, &quot;disable %32s&quot;, block_name) =3D=3D 1)<br>
&nbsp;&nbsp; 171&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op =3D 0;<br>
&nbsp;&nbsp; 172&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else=
 if (sscanf(str, &quot;enable %32s %8s&quot;, block_name, err) =3D=3D 2)<br=
>
&nbsp;&nbsp; 173&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op =3D 1;<br>
&nbsp;&nbsp; 174&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else=
 if (sscanf(str, &quot;inject %32s %8s&quot;, block_name, err) =3D=3D 2)<br=
>
&nbsp;&nbsp; 175&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op =3D 2;<br>
&nbsp;&nbsp; 176&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else=
 if (str[0] &amp;&amp; str[1] &amp;&amp; str[2] &amp;&amp; str[3])<br>
&nbsp;&nbsp; 177&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ascii string, but commands a=
re not matched. */<br>
<br>
Say we don't write an ascii string.<br>
<br>
&nbsp;&nbsp; 178&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 179&nbsp; <br>
&nbsp;&nbsp; 180&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
op !=3D -1) {<br>
&nbsp;&nbsp; 181&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_find_block_id_by=
_name(block_name, &amp;block_id))<br>
&nbsp;&nbsp; 182&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 183&nbsp; <br>
&nbsp;&nbsp; 184&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;head.block =3D block_i=
d;<br>
&nbsp;&nbsp; 185&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only ue and ce errors are su=
pported */<br>
&nbsp;&nbsp; 186&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!memcmp(&quot;ue&quot;, err=
, 2))<br>
&nbsp;&nbsp; 187&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; data-&gt;head.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTAB=
LE;<br>
&nbsp;&nbsp; 188&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (!memcmp(&quot;ce&quot;=
, err, 2))<br>
&nbsp;&nbsp; 189&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; data-&gt;head.type =3D AMDGPU_RAS_ERROR__SINGLE_CORRECTABL=
E;<br>
&nbsp;&nbsp; 190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp; 191&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 192&nbsp; <br>
&nbsp;&nbsp; 193&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;op =3D op;<br>
&nbsp;&nbsp; 194&nbsp; <br>
&nbsp;&nbsp; 195&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op =3D=3D 2) {<br>
&nbsp;&nbsp; 196&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (sscanf(str, &quot;%*s %*s %*s %u %llu %llu&quot;,<br>
&nbsp;&nbsp; 197&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;sub_block, &amp;address, &amp;value) !=3D 3)<br>
&nbsp;&nbsp; 198&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sscanf=
(str, &quot;%*s %*s %*s 0x%x 0x%llx 0x%llx&quot;,<br>
&nbsp;&nbsp; 199&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sub_block, =
&amp;address, &amp;value) !=3D 3)<br>
&nbsp;&nbsp; 200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 201&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; data-&gt;head.sub_block_index =3D sub_block;<br>
&nbsp;&nbsp; 202&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; data-&gt;inject.address =3D address;<br>
&nbsp;&nbsp; 203&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; data-&gt;inject.value =3D value;<br>
&nbsp;&nbsp; 204&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp; 205&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } el=
se {<br>
&nbsp;&nbsp; 206&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &lt; sizeof(*data))<br=
>
&nbsp;&nbsp; 207&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 208&nbsp; <br>
&nbsp;&nbsp; 209&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_from_user(data, buf, s=
izeof(*data)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
This lets us set the data-&gt;head.block to whatever we want.&nbsp; Premusa=
bly<br>
there is a trusted app which knows how to write the correct values.<br>
But if it has a bug that will cause a crash and we'll have to find a<br>
way to disable it in the kernel for kernel lock down mode etc so either<br>
way we'll need to do a bit of work.<br>
<br>
&nbsp;&nbsp; 210&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp; 211&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>
&nbsp;&nbsp; 212&nbsp; <br>
&nbsp;&nbsp; 213&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn 0;<br>
&nbsp;&nbsp; 214&nbsp; }<br>
<br>
regards,<br>
dan carpenter<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN1PR12MB2558A472D85D6296CE250BBF87A40SN1PR12MB2558namp_--

--===============0664415879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0664415879==--
