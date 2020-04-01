Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBCCC43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5BF206F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="103eG/yZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5BF206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8086E8D9;
	Wed,  1 Apr 2020 06:41:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13F96E8D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 06:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzcK0VsYYVQtybgg9HXIpdUREnBie94KlY+HI8BLo6y9ttBQ9B49IZwv01rqulcHnvomqWybPFg5aZpfugh5kJ8qV0q5gBypKerO617d5DHZRfcbvA8kpdIYyx65/79BTycYbqSZqNU+qTgLB8nOscMrf/3auEyMkvIt6SeNIkyjoyvQS/g0WfqwHgbl+uR4yk4em6nPUrn07Vs2H5Wcbqnjoy9eZrgwi4w3AGljVI2DOMy9F0VKt3ezRZ77VBid6pTsAuQtLSWH7mGBlGcXz8x5VHjVIl5wVeP6pRidGAiGDNH8J4DeXD9PW9sgggDzDEPU1YxIMD+NwyW3l/Vkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V12A/Nq4rwI2h3XENx6ymC7tbTLuKFW3MN9kfAfqxbs=;
 b=CCXBlT5V50533m2aF5MtBrmV7RoOa4X3SZnqCRBM6nw41ZqgbLQLDW3103xCCgowy/h8sOpkFxRoADq1FVhD7mSTttWU991ukd58FEucJfup29X743yOBKFPr2fnaKqKzfUvrsEnMJyokMNPI1TECGBBPR4IK2LtAOaciUzMYQwaHjFD+4O5juKlNGnRtWnUc2EplAYtsJCr1SeOKrcdzzcaUx/WuDrRQIQFNEmyE7Udr0BzPq0Rh4qyyIcaMCmL4RajG6iG4CKBwwUuMC8oKMN1XFfVKe6JjRY8ANGJoxd2n4JsC3NMwLjHPzrv3pD1vo5qwC1a8uk4EDJ+CqQhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V12A/Nq4rwI2h3XENx6ymC7tbTLuKFW3MN9kfAfqxbs=;
 b=103eG/yZvUTHGjVhL8G5XNoas+oVelT2je7JIOgpaVlCVUVKPXX4NLcneDf6EPb04N3B4MrrWPJZfMTfd71ZMkHGPUw+gufypofV2YElbCd9fQ3Em1cbVU+mSdZxMVMiTVD2PIqwayncCXqhPRZsvL8OcVmtcDpaGCnBACBG74Q=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (2603:10b6:208:aa::11)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 06:40:58 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::d96e:c154:8fdc:3fb0]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::d96e:c154:8fdc:3fb0%6]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 06:40:58 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK
Thread-Topic: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK
Thread-Index: AQHWB+sp61SQCy4aw0uGt01ObyJCiahjz6dF
Date: Wed, 1 Apr 2020 06:40:58 +0000
Message-ID: <MN2PR12MB3296808841DCC834937AA87AA2C90@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20200401060227.15989-1-Yuxian.Dai@amd.com>
In-Reply-To: <20200401060227.15989-1-Yuxian.Dai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-01T06:40:59.238Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [58.246.141.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c696293-4cae-4e20-e791-08d7d607a314
x-ms-traffictypediagnostic: MN2PR12MB4357:|MN2PR12MB4357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4357496D6A0D60CA06B91AEFA2C90@MN2PR12MB4357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3296.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(26005)(8676002)(5660300002)(64756008)(7696005)(66556008)(52536014)(91956017)(186003)(53546011)(66446008)(66476007)(66946007)(86362001)(6506007)(76116006)(2906002)(966005)(19627405001)(71200400001)(9686003)(55016002)(33656002)(21615005)(15974865002)(81166006)(8936002)(110136005)(45080400002)(316002)(478600001)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hY9KoYhF/uNo8DjHlXA3wDPw+31J0gvUjlIZ+NiEi0qZFpb/Ojf3vNe0TKH92P7LZo/+mbGcz4CP0bZ8aCFNcMPjPVACefZ2AryJtEJwb6FfFJG07IZMeEouB7Syd/S7kzaUgmDDB6ZKPR2dn1ItgolYGb5gDKP8/P4eOyDGlbMQN34gKasLzQAnPesKeCNq0gtB7DAczuUexBO/S7mkouA4AiPFOMIUelzjU0V+8Un8CnMKbN4rZnYSXMzl5XqwUm7OugY/9LnnkD5erPy7Kbu40yqvuc1R7iugxhAj4MyRzYr+w/EJ+z69VkkESTxvkRPHBILTEm4Xu9P9K5zPBbqlV/mbrnxVKeWfNqw3VJJ9pvMWVKqD+FumDs1WCIp+HU0FCDGFJ9VlZiGQsQm1MdKJcrFR2A1tmXBTx2BFLKG8UddU+enG8ovtIBwKBcYO787X2jGeyiKrE6WUuFboDxPmY0x1Dx7CU6p7562FnTW8/LdOJkfKus3jtKZHYL9LwNCspQRYpy9Vvu2g2Yb4cA==
x-ms-exchange-antispam-messagedata: OAc21JitemxDYsf1su0pte/FmmOeuoyQksdv9yQLK+ifXiFrUhh+XjxyyfV9wTeNhnOAX2iiupY5qxxQqHS6lgtBF1r2ZD6qmsJwkckIiCeJpFZVXRxZzETAMRpe9ZRlTunv9jKWpUqSj8fXX6leEA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c696293-4cae-4e20-e791-08d7d607a314
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 06:40:58.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRaxOTTCq6U8lr9ATAe6GeM2E6umak4yGmMlTBLIpAxsMWYWl2Z7jyzD6KuKCWk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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
Content-Type: multipart/mixed; boundary="===============0456789258=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0456789258==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296808841DCC834937AA87AA2C90MN2PR12MB3296namp_"

--_000_MN2PR12MB3296808841DCC834937AA87AA2C90MN2PR12MB3296namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yuxian D=
ai <Yuxian.Dai@amd.com>
Sent: Wednesday, April 1, 2020 2:02 PM
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
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 7bf52ecba01d..5c5d3f974532 100644
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
@@ -297,6 +298,13 @@ static int renoir_print_clk_levels(struct smu_context =
*smu,
                 GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
                 size +=3D sprintf(buf + size, "%d: %uMhz %s\n", i, value,
                                 cur_value =3D=3D value ? "*" : "");
+               if(cur_value =3D=3D value) {
+                       cur_value_match_level =3D true;
+               }
+       }
+
+       if(!cur_value_match_level) {
+               size +=3D sprintf(buf + size, "   %uMhz *\n",cur_value);
         }
[kevin]:
I have a little suggestion about coding style.
"Do not unnecessarily use braces where a single statement will do."
we'd better fix it.
thanks.

https://www.kernel.org/doc/html/latest/process/coding-style.html
Linux kernel coding style =97 The Linux Kernel documentation<https://www.ke=
rnel.org/doc/html/latest/process/coding-style.html>
Linux kernel coding style=B6. This is a short document describing the prefe=
rred coding style for the linux kernel. Coding style is very personal, and =
I won=92t force my views on anybody, but this is what goes for anything tha=
t I have to be able to maintain, and I=92d prefer it for most other things =
too. Please at least consider the points made here.
www.kernel.org


         return size;
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
ang%40amd.com%7Cac64217a79c44e06267008d7d602484e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637213177638342283&amp;sdata=3DiEt1JzC0wcb7rQ%2F2TWBu7Rf=
JGrChPpt%2Fc2jXPfqjruU%3D&amp;reserved=3D0

--_000_MN2PR12MB3296808841DCC834937AA87AA2C90MN2PR12MB3296namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
<b>Sent:</b> Wednesday, April 1, 2020 2:02 PM<br>
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
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 &#43;-<br>
&nbsp;2 files changed, 9 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 7bf52ecba01d..5c5d3f974532 100644<br>
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
@@ -297,6 &#43;298,13 @@ static int renoir_print_clk_levels(struct smu_cont=
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
p;&nbsp;&nbsp; if(cur_value =3D=3D value) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value_ma=
tch_level =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!cur_value_match_level) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;&nbsp;&nbsp; %uM=
hz *\n&quot;,cur_value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText"><span>I have a little suggestion about coding styl=
e.</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; bac=
kground-color: rgb(255, 255, 255); display: inline !important">&quot;Do not=
 unnecessarily
 use braces where a single statement will do.&quot;</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; bac=
kground-color: rgb(255, 255, 255); display: inline !important">we'd better =
fix
 it.</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; bac=
kground-color: rgb(255, 255, 255); display: inline !important">thanks.</spa=
n></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; bac=
kground-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div class=3D"PlainText"><a href=3D"https://www.kernel.org/doc/html/latest/=
process/coding-style.html" id=3D"LPlnk438159">https://www.kernel.org/doc/ht=
ml/latest/process/coding-style.html</a></div>
<div id=3D"LPBorder_GTaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3Qvc=
HJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRtbA.." class=3D"LPBorder234871" contenteditab=
le=3D"false" style=3D"width: 100%; margin-top: 16px; margin-bottom: 16px; p=
osition: relative; max-width: 800px; min-width: 424px;">
<table id=3D"LPContainer234871" role=3D"presentation" style=3D"padding: 12p=
x 36px 12px 12px; width: 100%; border-width: 1px; border-style: solid; bord=
er-color: rgb(200, 200, 200); border-radius: 2px;">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td style=3D"width: 100%;">
<div id=3D"LPTitle234871" style=3D"font-size: 21px; font-weight: 300; margi=
n-right: 8px; font-family: wf_segoe-ui_light, &quot;Segoe UI Light&quot;, &=
quot;Segoe WP Light&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; margin-bottom: 12px;">
<a target=3D"_blank" id=3D"LPUrlAnchor234871" href=3D"https://www.kernel.or=
g/doc/html/latest/process/coding-style.html" style=3D"text-decoration: none=
; color: var(--themePrimary);">Linux kernel coding style =97 The Linux Kern=
el documentation</a></div>
<div id=3D"LPDescription234871" style=3D"font-size: 14px; max-height: 100px=
; color: rgb(102, 102, 102); font-family: wf_segoe-ui_normal, &quot;Segoe U=
I&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; margin-bottom: 12=
px; margin-right: 8px; overflow: hidden;">
Linux kernel coding style=B6. This is a short document describing the prefe=
rred coding style for the linux kernel. Coding style is very personal, and =
I won=92t force my views on anybody, but this is what goes for anything tha=
t I have to be able to maintain, and
 I=92d prefer it for most other things too. Please at least consider the po=
ints made here.</div>
<div id=3D"LPMetadata234871" style=3D"font-size: 14px; font-weight: 400; co=
lor: rgb(166, 166, 166); font-family: wf_segoe-ui_normal, &quot;Segoe UI&qu=
ot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif;">
www.kernel.org</div>
</td>
</tr>
</tbody>
</table>
</div>
<p style=3D"box-sizing: border-box; line-height: 24px; margin: 0px 0px 24px=
; font-size: 16px; color: rgb(0, 0, 0); font-family: serif; background-colo=
r: rgb(252, 252, 252)">
</p>
<div class=3D"PlainText">&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
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
7C01%7CKevin1.Wang%40amd.com%7Cac64217a79c44e06267008d7d602484e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637213177638342283&amp;amp;sdata=3DiEt1Jz=
C0wcb7rQ%2F2TWBu7RfJGrChPpt%2Fc2jXPfqjruU%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%=
40amd.com%7Cac64217a79c44e06267008d7d602484e%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637213177638342283&amp;amp;sdata=3DiEt1JzC0wcb7rQ%2F2TWBu7Rf=
JGrChPpt%2Fc2jXPfqjruU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296808841DCC834937AA87AA2C90MN2PR12MB3296namp_--

--===============0456789258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0456789258==--
