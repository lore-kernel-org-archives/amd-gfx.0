Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBFDC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 08:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9910E6186A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 08:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9910E6186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232F16E073;
	Tue,  2 Mar 2021 08:10:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4266E073
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 08:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrfnFN5t7AXiNlmNx9Ex8FANODZLjqdzvu+DkM/IusK/tvgkBWxYvcD1bV0P05RMwfUR6G+sPRa2AxTXkecsv+Qkch5S87YLc+dFWGHb7uaHykxDvjgirVOQmoqOUwd3/s4CRZGMVZL/5EK5DOc1wNgCK33Hza+mgzF8fogF7PwgnLjpMyqA6SUAcYEzESfOjhbHwZp/CAhR/cNG0gVoYMeDus5SaqmUq/B3vGW5+oVFIo5IIQGDsUHen4LNmKenVKrdZ59kNU3LpcA65abLW+wf0z/Y0IgCNxW4hs/T1pTxLk6lKOpn8mFkpdMH5ZuKxQH4praCf8a2OsEC8NAYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+uGlktQploR/msx3JpinII94qwl6KCsstReBftSZdE=;
 b=Ylecz7hMtCKE4OMvBlqaxIeHeu6Qs0Mxjkqcyb/BSSrJzrLIyA+5jy/bR5Afs6jCKC+FG0Lskz5uNFHbBxVVBxJYA7yGmTT/Im7fRU/wSAifN/BSZVlGc+GJ5OvwUA0ezNwlbWnuNwNQ1zsYqeJDUQd5Kzk7SUcRacqo4VPZNxjxtTYilAnVpfaDaT0u/Un8NvAtKvNT/fuAFAbJm9De3kdmJ73b+ScfEfOWyrd2ZnYrNymkkkdeLUzIZ2Zj7g8AevZ5+FFxG0Q0bF4Q0Uok8b7CHFDXuEgHqFF9WE2w9smYcpZF2bASJNT22N+0do6ewrTSBhnV0cOTWGcpJ2PpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+uGlktQploR/msx3JpinII94qwl6KCsstReBftSZdE=;
 b=wlH64/cE78R7Hf+jXnjFqWNDeHMoOgN+MA8QXlUr841TQvXjdFOzVF0F/sbw55emrYSqx8GPkv6LXr3lX9eeUKS0FBRJt7HhgMSogl5pXHBpVVqAEXHdwX/S2M7uTgwdI3nQg1Z98cHK8zumjYV1IAe9uC5t9ihpkZqypTBaXns=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3615.namprd12.prod.outlook.com (2603:10b6:208:c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 08:10:47 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 08:10:47 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in
 amdgpu_regs_pcie
Thread-Topic: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in
 amdgpu_regs_pcie
Thread-Index: AQHXDzqn8HsaytTYgUiKx+LmPleGfKpwWDSAgAAAYu0=
Date: Tue, 2 Mar 2021 08:10:47 +0000
Message-ID: <MN2PR12MB30223CDC433E867C438A5A1DA2999@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210302080348.7101-1-kevin1.wang@amd.com>,
 <MN2PR12MB4549AD10161346BEBE0D58A797999@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549AD10161346BEBE0D58A797999@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-02T08:10:46.497Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bb1f53a-8628-4018-55e5-08d8dd52af66
x-ms-traffictypediagnostic: MN2PR12MB3615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3615F3738C58514DFF3AAF3CA2999@MN2PR12MB3615.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsau36Lum9EoJOPE/2iKhr8zo5ga5+h0JWClQKN1rfoewRlvXnUHPXOnOBV6x1+0b/X5r3sbUMTvgyJbW4Jz45pol7ZnKVGLTcJlGdhPqtBya+5dB8+/phfTsYH5oa5KfgbThzMphgOI3TkTQvbOyASSfgww4KIwBYJddCtQbqJq308/BemJW2HoXBXedDYruhJlr3h/itNI30z88c9ZQH3tfURJIl20N/PokLV0CmJijzNUoXjOuuCrhMoyo5SFNk+MGKgn3HLAKmsoTe39bi1i7L1Mo/OZmETfhhnv/Gpp/SSqdcSEx6GjEP/WtnlhNCr3bd6k+c0YNEf05VDc1oUFEelM4ZshzPVWWqtDvNm3zVaixnZs8lG3u8I8jVMZxv3eT6EQ7K7dgvcKS5kOS7R42nlHPpgg0wkBTvPG0qZPXchx6V3KTgM3jmuSj6iumx+N2sIE1XjOOVWpKk5tWNG/GAMtyA+w07TzsS5VJ2P0Diwt3pV3FvfKTIyHWcZGE/aOpH2uK9pB8x0Lvet8vg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(64756008)(66476007)(91956017)(52536014)(66556008)(8676002)(6506007)(33656002)(26005)(66946007)(76116006)(66446008)(5660300002)(8936002)(55016002)(19627405001)(7696005)(71200400001)(478600001)(2906002)(9686003)(86362001)(83380400001)(53546011)(4326008)(110136005)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?E8gQ/+WWdHs9A8xec3nnns3nJz9IpnXxRRr7YsyKqwz+BxaaIOguZcF6Ov?=
 =?iso-8859-1?Q?fAapc5xpFr2DfSmmaGnUwIBMXwgewDXr1V8Zy59Ifo7RAP9zbMqaDO+tM/?=
 =?iso-8859-1?Q?jvWVGs7e1Hb2bOLi7qT9bPQGxcZ6rrhlwVpMzky/2U1O5i6dcjPrbOZdWy?=
 =?iso-8859-1?Q?SznpePae76Oo8aJ7S/kVnbw9w/homjYmzLK73vmxudU+2ybpJEjd9+7WBr?=
 =?iso-8859-1?Q?K9HJYi79FJgdWNnwh85Mt0hUGD7quf8MnoPEsLBGN1siXpuvYuZzxg4gJR?=
 =?iso-8859-1?Q?KaUmWJrfIrr7MkInzhCvnKmXaUzKwuKpN04FTDeEKuwon+BeaTThthc8Hu?=
 =?iso-8859-1?Q?cbXDhTn4E5w4GjdhW9MQA/MtVo6BBHL9TID8LpEOBmbSewwhMKhv6g/OSn?=
 =?iso-8859-1?Q?oQm3VFObBwUWIB8U9HiORt71NNMRdWOV6JaTFp5IuK44mJB1/rtHgfAAjX?=
 =?iso-8859-1?Q?W1NQg+jG7x7msz3CNic7Bw7RkfhfWtd+leNWOD5GeMxQ0If/zGrhZliIxH?=
 =?iso-8859-1?Q?w3ZJmAXq9zG7OJF0tKvVHpeCTXznmmV0WN5o8VBbeHE/nkKMoCtUfg907n?=
 =?iso-8859-1?Q?zYpFfycoMLybGoZDCjgLiCoJfdyYWuTPBPbZD3f9tm8XyYqYKsAjqe9td9?=
 =?iso-8859-1?Q?fgOTkQ2sEuBtG4YofH8rfyt7EenrDq9PxFtXHhcgB4cfhn9mME8SyjKvjp?=
 =?iso-8859-1?Q?x5RgJPZrE0J0oePohT/Fx89CKwVWUR8huvMdR2PBF6Dd4MvOK5VANo/TJ9?=
 =?iso-8859-1?Q?RqmqnhMmGLO8TIJZ7XEvrdFV1vI9QcrRjansNnwses1Fsk2/IXO8ZQEHcg?=
 =?iso-8859-1?Q?FAOJlniZQNNPQgsWTr5nfCrzYP0e6NBfg4QqZCBQDuNl1vOLkoJ91/D9VA?=
 =?iso-8859-1?Q?ww7VnX0iG8VH9CgosFUEcwtO18RGav+GkI26ej1ERSteCabmP4J+ud0HH8?=
 =?iso-8859-1?Q?8Yo6XB3Rqc2N7k9DX9mpyfvVxI+mjlhug7f5lYevpRWYsiVUMGZu4pPvOf?=
 =?iso-8859-1?Q?syeDUFxj1T3msoL39QtXD/sGHT6RJZSfR0DNEGnrYJ1UrgLrqTQ4e6ulxF?=
 =?iso-8859-1?Q?PwZnJwvT2jTAFjz978no8KbOji3Xis9EY/nB1cBLYnT79VG/3aGywqOIr4?=
 =?iso-8859-1?Q?kw3hSKbolOFq9lANV3UjeJLVuQgMntWiFXhoN1SVXqyPHwCYvNu7dL3zNs?=
 =?iso-8859-1?Q?N79H+t9U5tu3YrqpEUsATBJ1VAlGhVD3+B1YVvqDh1LsALLIKX/UPc8BAp?=
 =?iso-8859-1?Q?Cdemc/PDrUtYsy9ybMb5y0EuofLyKOEclK/oNnddXkwcahK/DziZCyGR9+?=
 =?iso-8859-1?Q?uMGrG2E+v7QJeGSvOFVQjkawCRdGNnT264JzuF5v5+s+EMk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb1f53a-8628-4018-55e5-08d8dd52af66
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 08:10:47.1721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TN2yQlAWs4wXmAQkSIwdMK1kntiQPYCHp3w61WkQQaAGpBMyrLZ2Ax5ZyCyISQYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1008665965=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1008665965==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30223CDC433E867C438A5A1DA2999MN2PR12MB3022namp_"

--_000_MN2PR12MB30223CDC433E867C438A5A1DA2999MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

yes, thanks lijo.

Best Regards,
Kevin

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, March 2, 2021 4:09 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in am=
dgpu_regs_pcie

[AMD Public Use]

Same can be done for pcie_write also.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Tuesday, March 2, 2021 1:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in amdgpu=
_regs_pcie

the register offset isn't needed division by 4 to pass RREG32_PCIE()

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index a09469f84251..f3434a6f120f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -317,7 +317,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct fil=
e *f, char __user *buf,
         while (size) {
                 uint32_t value;

-               value =3D RREG32_PCIE(*pos >> 2);
+               value =3D RREG32_PCIE(*pos);
                 r =3D put_user(value, (uint32_t *)buf);
                 if (r) {
                         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
--
2.17.1

--_000_MN2PR12MB30223CDC433E867C438A5A1DA2999MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes, thanks lijo.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 2, 2021 4:09 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE(=
) in amdgpu_regs_pcie</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Same can be done for pcie_write also.<br>
<br>
Reviewed-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<br>
-----Original Message-----<br>
From: Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
Sent: Tuesday, March 2, 2021 1:34 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Laza=
r@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in amdgpu=
_regs_pcie<br>
<br>
the register offset isn't needed division by 4 to pass RREG32_PCIE()<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index a09469f84251..f3434a6f120f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -317,7 +317,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct fil=
e *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (size) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D RREG32_PCIE(*pos &gt;&gt; 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D RREG32_PCIE(*pos);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D put_user(value, (uint32_t *)buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_ru=
ntime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
-- <br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30223CDC433E867C438A5A1DA2999MN2PR12MB3022namp_--

--===============1008665965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1008665965==--
