Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89390C55179
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC37C2075E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GJtKrrMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC37C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228036EDC6;
	Fri, 30 Oct 2020 15:07:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CF16EDC6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 15:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPqHNkm4PGU+EpiAqSs2TBWeY2Zw2A1NIfFPiMyhZgf8og56H78HeXmvSlM5TDR44BIHI1lJ+fMA3be4ciFdM3W5FK1q7oTJ6SVeFHJWtHJ1lBWeAcrX0FgcujLmo5Y4mLZxNA//y+ojirgHQapB7K87KfUpVBndrKcb1voB1bYx+aTQpTKd3uNlkOyQAyhJaJMz/wuUA/nYHSqpdI+QXmiKdzLR+7GDVaoAOYM6pNJarY8ZbYB+o3Hp1FRoDZ2chdP+BXY8WI8SjkdHCgQbbayzqBxvW4lNvly8flyQJXits9JHkkKniY8g0iSiiF6uOIgPcLMLxfga66Jm+XfUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjYYinAZ5MSYrcGFwio9WcF1kFaNQv6tWlI+fgd1rpo=;
 b=U1LUbCvzxY9Vvn4SA0spLrPzAvyde/oxtQoPLIcCxjfZlpyqvn6kWmnyfrmfBvoVP1BFkaFl01jjtetbE+trQGY60KVyNiLbssgYy1Y+Wnf34mY7lDe192mlqR3Hus8IWJRpxDSzIMJ8gL3rDMYEDUOEvYh+BrIEXACyJZcs/S7KhuNAmSTLK2JNqbY+B8I+ePzQ1q/ohT2LEoz2TYenA1Qbc7LdkK18gGcNEzAsbHvC+NUjNhFGcD1q/fyj6vQMvPXmlUHEHHdHkhkBeqCnZKuBPytdqiDRpvoa7zrlh9CdDqizn7jzqunsftlWrh4+fPYnzeXzU4M+YVcvAJnCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjYYinAZ5MSYrcGFwio9WcF1kFaNQv6tWlI+fgd1rpo=;
 b=GJtKrrMwIuo0Yxbr/Rdmlu3vDu/h87dosJ6WZ2AIiD860cKpGWAxqsG7Q8l1QJg+8/Ni0/uPoRMwBJdslIbkgB+Qvbq3glWPMoURQuqtaAQBs9iHncyqZospYDaXTQLgGaMUWQ7BkI8AHjfB2DwWKDvk8q58Psz3RhlJPRSrNoI=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3785.namprd12.prod.outlook.com (2603:10b6:5:1cd::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.28; Fri, 30 Oct 2020 15:07:12 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 15:07:12 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Topic: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Index: AQHWrs4VklGKtzWJlkech+jel2e37KmwPv2g
Date: Fri, 30 Oct 2020 15:07:12 +0000
Message-ID: <DM5PR12MB2517AC4A1480F4CB06933D9AE4150@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20201030150505.133369-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201030150505.133369-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-30T15:07:11.930Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 633fb41c-2704-44ca-6f3b-08d87ce57b0b
x-ms-traffictypediagnostic: DM6PR12MB3785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3785B16FA005A6796D3EF1C4E4150@DM6PR12MB3785.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:277;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LW6LoHPPbqg7WsGVzCu4EKXiRnU3wFIYpQ10kAZ8Lh4nbkk+X8n2bg91iAD2OZDl2sdqUB7D0MYBEMou22IzVq9vbALoB5ym4jDOX+WJ5yTNumbAm40NCrxlrdgVcU1DsrwuPChjVltc/aaUDSv3k4izezvK+Tu8qnL5NCPQ/VIQDGPXfvtpbeOrWGdfXFKsZh7d56CQy6N1blea3mUn7UkV+eEUxrL2RRLPlTnon7yauUgtmwmZh6yF4BXZVAPO+IUiJNl7tIZRO9yVkBttWLHz4Fr7673OdphwijZDHHTDLz5vfJ5w18CRvJ2arPkSQacL6qB/OSgr+/eE/dY0qQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(83380400001)(86362001)(4326008)(316002)(71200400001)(26005)(186003)(478600001)(33656002)(6506007)(91956017)(76116006)(19627405001)(110136005)(66446008)(66556008)(52536014)(55016002)(8936002)(53546011)(66476007)(5660300002)(2906002)(8676002)(66946007)(7696005)(64756008)(9686003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eHb5FL7VJWu7LbmUS+osS1EsH5e4hf2fQhESKIUesjXC/EbHS6sSvTVVa0/MugHJ56HEGAlIDFHozol+rjZJ453Euk2S3jadRg2Tx3VKmE93WP26Z8EYvCBWQhuhEUAK+KwAIw1H7bJTZEUZ54uTPAhDNu6nmnfsuqKPGo85zGI+fpv/rwJUnDI3OqMMV/KtLbfTj9QFv3R+EGbyAvDVJLMMOd+jzIwhPbX0FanqSVBK6TuRCrLFRZCxo22T0LvalaZQ6e8LaJ+8LB4qUi/sUaYQKr1jrzXpB8FixpXZP/haiioQisqbyhqo0vBLHzyylP+KSnHVhjef3Z7FkW3FNAswGAiWO1Y77tux4E4lZo6zjAQvVmRuberMILcYjjG/xiRxRbcUl4gxN5cvXH2SiuYTxLEzkZIg4+MgXuR0iT1gjnnVLyjwDJhpnHQFffGv9hlr/WtFXyx2lCXivn5uYdQ6fCCNiaqkoK7127ePZYSff3bY9a85uZ25N6nULNzKSImET8RwduHvkR7XG/Z9O0mL/iOA+WBtEVYHxr4iKuUGtgVC6KsRIiRW0x4SRZx8eF3QG5o/gTf/bu962dxg2iG4rZJ1Wop8Hi2H6byLUPmYUb4HWSOpyAyUHEsJPR4UM55Bk7KFlTUB0VBiJDhm3Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633fb41c-2704-44ca-6f3b-08d87ce57b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 15:07:12.5257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LdBXkh20oFaW31TnpaBwfXL5VyyzbRat5t/kD5iCRcA537UmEoI0rgVPmaf1fir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0177635031=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0177635031==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2517AC4A1480F4CB06933D9AE4150DM5PR12MB2517namp_"

--_000_DM5PR12MB2517AC4A1480F4CB06933D9AE4150DM5PR12MB2517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>
________________________________
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Friday, October 30, 2020 11:05 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>;=
 Liu, Leo <Leo.Liu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong=
 (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy

Toggle on/off gfxoff during video playback to fix gpu hang.

v2: change sequence to be more compatible with original code.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 277a8435dd06..62d4614d48eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)
         }

         if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+               amdgpu_gfx_off_ctrl(adev, true);
                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_=
TYPE_VCN,
                        AMD_PG_STATE_GATE);
         } else {
@@ -370,7 +371,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)
         struct amdgpu_device *adev =3D ring->adev;

         atomic_inc(&adev->vcn.total_submission_cnt);
-       cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+       if (!cancel_delayed_work_sync(&adev->vcn.idle_work))
+               amdgpu_gfx_off_ctrl(adev, false);

         mutex_lock(&adev->vcn.vcn_pg_lock);
         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN=
,
--
2.25.1


--_000_DM5PR12MB2517AC4A1480F4CB06933D9AE4150DM5PR12MB2517namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
This<span style=3D"color:#c0c0c0"> </span>patch<span style=3D"color:#c0c0c0=
"> </span>
is<span style=3D"color:#c0c0c0"> </span>Reviewed-by:<span style=3D"color:#c=
0c0c0"> </span>
James<span style=3D"color:#c0c0c0"> </span>Zhu<span style=3D"color:#c0c0c0"=
> </span>&lt;James.Zhu@amd.com&gt;
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiansong Chen &lt;Jia=
nsong.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, October 30, 2020 11:05 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhu, James &lt;Jam=
es.Zhu@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;; Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Toggle on/off gfxoff during video playback to fix =
gpu hang.<br>
<br>
v2: change sequence to be more compatible with original code.<br>
<br>
Signed-off-by: Jiansong Chen &lt;Jiansong.Chen@amd.com&gt;<br>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 277a8435dd06..62d4614d48eb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fences &amp;&amp; !at=
omic_read(&amp;adev-&gt;vcn.total_submission_cnt)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_B=
LOCK_TYPE_VCN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STAT=
E_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -370,7 +371,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;adev-&gt;v=
cn.total_submission_cnt);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;vcn.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cancel_delayed_work_sync(&amp;ad=
ev-&gt;vcn.idle_work))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;v=
cn.vcn_pg_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_power=
gating_state(adev, AMD_IP_BLOCK_TYPE_VCN,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB2517AC4A1480F4CB06933D9AE4150DM5PR12MB2517namp_--

--===============0177635031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0177635031==--
