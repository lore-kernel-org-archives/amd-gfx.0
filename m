Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3749C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 08:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD14D20719
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 08:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0m4703xT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD14D20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6140B6E22B;
	Wed,  1 Apr 2020 08:27:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133266E22B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 08:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp8A7u8jKh/bmcy88VNFIm3dGilLbql1duWCdUHmQwrhz6RDKNCwiXrr3HHLvere/MQ4LEFUgWSw72Tavj3MRohYsGo1i9iHAgG7vG6Hrdq7elw6gJHHQX1aXOpu4uiY4tRMFBslootg5XmUu7H8Gn9y4bjBNp7Def2eIY2m8M92jEUdGuJbdxYjGWY4ILem2+uoEcPJ6hrZSgzddXxgBTNI+pL0BGL6Fo3FM0zR/EoqMpqPh7zg9R7MjpI3df7gkUzUnaKUaD5aSib8yNVyd/+NwhJyy+mNIA7xjb4jVErrgDEnnDy3vPvrV5sGbjNy0AhuZrzWWpVSymMy5Nspbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcw4HJ8TPFPzdJpe2nVYlmVRyJJBcCBsbZ/jzkabFEU=;
 b=G55lwBSvh5yfsB0FjrpWfunPNREvwSPdgpHci0p3L+jxz0JNYPgCeBGOyjfxav+6pyf5K0vAFXbJvpK5l6An+h8xQIm6R7FkKAydTF0lCIkdwDAcCIyX7qhohXv29+juLBIEuOi2mI0P+9x0YYslA4A3p8UEm67zfmHiLq1eZKTNhQ4UPYByBBSahj+ZmQv3kiso5jcxBdW3DJt1xJj+IPT3282vJDCE8xDa6DcSSV/4cco6eFQmSOxhYWYDblyyzBxVE6nUQ4OBgfcNpmZcuuE2LWSTDe376Y3CqCs7+Yk9g6gElEyPjNJ7T/sAZGxIxV8LZvJzyYEhPp9pIbkRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcw4HJ8TPFPzdJpe2nVYlmVRyJJBcCBsbZ/jzkabFEU=;
 b=0m4703xT+/Rh28RECd85Tu6vPSfJmo+oyFg1FrLuzkdeNzT5hmMQL3S3egfZYK8+Ry0wqTjCX1+pD+h4W0ETZZOgF2lid7+KEzuhulwmFBsm2doU4JdewYQ2DNyETOInNY3m+s3IHPk07GtR+k8AfcZp47gAtKqHrZu7YMby6ZY=
Received: from BN8PR12MB3283.namprd12.prod.outlook.com (2603:10b6:408:9f::28)
 by BN8PR12MB3523.namprd12.prod.outlook.com (2603:10b6:408:69::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 1 Apr
 2020 08:27:06 +0000
Received: from BN8PR12MB3283.namprd12.prod.outlook.com
 ([fe80::f4b1:f244:5157:d457]) by BN8PR12MB3283.namprd12.prod.outlook.com
 ([fe80::f4b1:f244:5157:d457%6]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 08:27:06 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK
Thread-Topic: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK
Thread-Index: AQHWB/VFceQJqCp/wEmLf38qyXu48qhj7nAn
Date: Wed, 1 Apr 2020 08:27:06 +0000
Message-ID: <BN8PR12MB32831806B63D246362F7E3ABA2C90@BN8PR12MB3283.namprd12.prod.outlook.com>
References: <20200401071415.16408-1-Yuxian.Dai@amd.com>
In-Reply-To: <20200401071415.16408-1-Yuxian.Dai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-01T08:27:07.240Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [58.246.141.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5412268b-0fad-4b0b-d8fa-08d7d61676be
x-ms-traffictypediagnostic: BN8PR12MB3523:|BN8PR12MB3523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3523A16B0FD0BF4DAECEE0D6A2C90@BN8PR12MB3523.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(81156014)(81166006)(8676002)(8936002)(186003)(66556008)(86362001)(66476007)(66446008)(64756008)(91956017)(76116006)(66946007)(55016002)(71200400001)(9686003)(478600001)(5660300002)(110136005)(45080400002)(52536014)(316002)(26005)(2906002)(966005)(19627405001)(6506007)(53546011)(7696005)(33656002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wj+8T7QF/axAQCh7rHg4ShXgJD9sE0EGXJE3z8qfNl9Hczl3Ahx+s50WtyE2ULtbq0lrn14TmVridADF6T4aEeTq+LmhUAtAHDSGxh0qfo4wOLaEIEN8nDCO8sa2/LZDztdH96vwyTSXr3WWhpLGRxZor+i62UVAGItlEqDmZWQKs644Rb1PCe/g4K4TJtYG/T3KsJYaPaSIBCkY8tU6QzDhjm4tKHcpUmwpX1dL61LgLUMlKitG2XGApZu2xn5S4+vS8NmM0r9Rt5nNAdRvQ0wNoeJKL4T70li7pMouu/oWxPYdUXAszak1p43OMLhuhKxB/DHaTsyyrVxyl/F+nUtzIUv1osP85CQ8kPY3koP3DZ4NEgQmQ8LQ64E/qcAgzC5REvt3gSnCb+dQMtV4FDE2++/eUwklgxh5FD7e5YqPg92QwkwnqssiDu91pBKmnsx9E2bmB+Uwue99+4VWrFPfObWNSZxx2cOrIJSdCUg=
x-ms-exchange-antispam-messagedata: QH53SftwWwZQELANcEVWRBzXu5F1phJ0x9JL982oIe6Mq7g8HUSbxLfOTE2920mxJQHzmF/5ANffdmB7FFFugBvsT85AgshJQmixIUSXziP4gP3chLzLxEtE79CreN9uNSnoHdHVzrgWUSmbKPJMbQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5412268b-0fad-4b0b-d8fa-08d7d61676be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 08:27:06.2589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzqiOL3dXO2IkXZW/deo2ZBQiV5P/yRysePL1mZ3pgw05ONVuq3xegIHWX1cdHk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3523
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
Content-Type: multipart/mixed; boundary="===============1661446979=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1661446979==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB32831806B63D246362F7E3ABA2C90BN8PR12MB3283namp_"

--_000_BN8PR12MB32831806B63D246362F7E3ABA2C90BN8PR12MB3283namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yuxian D=
ai <Yuxian.Dai@amd.com>
Sent: Wednesday, April 1, 2020 3:14 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Dai, Yuxian (David) <Yuxian.D=
ai@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the =
MCLK

From: "yuxiadai@amd.com" <yuxiadai@amd.com>

1,Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2,we should show the current working clock freqency from clock table metric

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 +++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 7bf52ecba01d..3901b20196d7 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *=
smu,
         uint32_t cur_value =3D 0, value =3D 0, count =3D 0, min =3D 0, max=
 =3D 0;
         DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
         SmuMetrics_t metrics;
+       bool cur_value_match_level =3D false;

         if (!clk_table || clk_type >=3D SMU_CLK_COUNT)
                 return -EINVAL;
@@ -297,7 +298,13 @@ static int renoir_print_clk_levels(struct smu_context =
*smu,
                 GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
                 size +=3D sprintf(buf + size, "%d: %uMhz %s\n", i, value,
                                 cur_value =3D=3D value ? "*" : "");
+               if (cur_value =3D=3D value)
+                       cur_value_match_level =3D true;
         }
+
+       if (!cur_value_match_level)
+               size +=3D sprintf(buf + size, "   %uMhz *\n",cur_value);
+
[kevin]:
after remove this unnecessary blank line,
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

         return size;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu)=
;
                         freq =3D table->SocClocks[dpm_level].Freq;        =
\
                         break;                                          \
                 case SMU_MCLK:                                          \
-                       freq =3D table->MemClocks[dpm_level].Freq;        \
+                       freq =3D table->FClocks[dpm_level].Freq;  \
                         break;                                          \
                 case SMU_DCEFCLK:                                       \
                         freq =3D table->DcfClocks[dpm_level].Freq;        =
\
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C7cef28fc315e4a1f705c08d7d60c542f%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637213221059785929&amp;sdata=3DeUFmm4J6hEfV%2FWJtU5s7hqF=
DSCF0i232Yz6QwoSAj7E%3D&amp;reserved=3D0

--_000_BN8PR12MB32831806B63D246362F7E3ABA2C90BN8PR12MB3283namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yuxian Dai &lt;Yuxian.Dai@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, April 1, 2020 3:14 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Dai, Yuxian (David) &lt;Yuxian.Dai@amd.com&gt;; Dai, Yuxian (Dav=
id) &lt;Yuxian.Dai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to s=
et the MCLK</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: &quot;yuxiadai@amd.com&quot; &lt;yuxiadai@am=
d.com&gt;<br>
<br>
1,Using the FCLK DPM table to set the MCLK for DPM states consist of<br>
three entities:<br>
&nbsp;FCLK<br>
&nbsp;UCLK<br>
&nbsp;MEMCLK<br>
All these three clk change together, MEMCLK from FCLK, so use the fclk<br>
frequency.<br>
2,we should show the current working clock freqency from clock table metric=
<br>
<br>
Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774<br>
Signed-off-by: Yuxian Dai &lt;Yuxian.Dai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 &#43;-<br>
&nbsp;2 files changed, 8 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 7bf52ecba01d..3901b20196d7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -239,6 &#43;239,7 @@ static int renoir_print_clk_levels(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, =
value =3D 0, count =3D 0, min =3D 0, max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmClocks_t *clk_table =3D=
 smu-&gt;smu_table.clocks_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool cur_value_match_level =3D fa=
lse;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clk_table || clk_type=
 &gt;=3D SMU_CLK_COUNT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -297,7 &#43;298,13 @@ static int renoir_print_clk_levels(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz=
 %s\n&quot;, i, value,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D=3D value ? &quot;*=
&quot; : &quot;&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (cur_value =3D=3D value) <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value_ma=
tch_level =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cur_value_match_level)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;&nbsp;&nbsp; %uM=
hz *\n&quot;,cur_value);<br>
&#43;</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText"><span>after remove this unnecessary blank line,</s=
pan></div>
<div class=3D"PlainText"><span>Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.=
com&gt;<br>
</span><span></span>&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h<br>
index 2a390ddd37dd..89cd6da118a3 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
@@ -37,7 &#43;37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *=
smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =
=3D table-&gt;SocClocks[dpm_level].Freq;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_MCLK:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =3D table-&=
gt;MemClocks[dpm_level].Freq;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =3D tab=
le-&gt;FClocks[dpm_level].Freq;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_DCEFCLK:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =
=3D table-&gt;DcfClocks[dpm_level].Freq;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; \<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C7cef28fc315e4a1f705c08d7d60c542f%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637213221059785929&amp;amp;sdata=3DeUFmm4=
J6hEfV%2FWJtU5s7hqFDSCF0i232Yz6QwoSAj7E%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C7cef28fc315e4a1f705c08d7d60c542f%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637213221059785929&amp;amp;sdata=3DeUFmm4J6hEfV%2FWJtU5s7hqFDS=
CF0i232Yz6QwoSAj7E%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN8PR12MB32831806B63D246362F7E3ABA2C90BN8PR12MB3283namp_--

--===============1661446979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1661446979==--
