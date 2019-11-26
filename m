Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A8C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 21:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0A72064B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 21:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0A72064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765CB6E49A;
	Tue, 26 Nov 2019 21:57:29 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740078.outbound.protection.outlook.com [40.107.74.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB566E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 21:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9b/ujYFp1OvVl0UjzAQi2Of9bweeezbuvrU4n7wbus6S1DHAIEK5QXFzHJ1w5HV1aTfJXXP9fPmhTIT8btE8kZ21f9du8Vq2lm3rVDCJLQSsEgM+d/hh7E9WufHfSgagGNLAW9lr6VyhzZ3WLZHBOitpMCkkLZ2JUuCKidBxcABtCH9Oy3z4lPvxWHUyiBko5zlXxy77MQ7B2FYJQL5781xhoc5tzaOt9mB6hNoB5/3ML8TkfGXuieyowrJzTJmnGE9IMVm19mimImBPFi3yt7V2n3MXauUqXkD2KwNUccyMYuPOid3xxyg3G8nCXBsljwAQSU87eNiHYsEjjfXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nJpZw4nhaeqnCR4SNzJwtv806QgOsBpxc91v0okSww=;
 b=SF/svCbxBJZXyUGi9ekB3yuf4ZKbl9fckfYWd7olh5GKuKEepQWzAP1yF3Iqv69c/b8A9b5jHcO9bclB5hXSfGOT5eQT4oWC3hXHrZZO2HkQf7G9F5RLNP4Ltb5kJbmCYyxkCHsZD4RurIyB+k2ROwNVah2AU0pSBOKJXW7rEPzoJ/GuheUFczwd4Btd8Tts09UsTyaW2r03K2SssW9UNO63cAMx/52Cgbko2duV6FGNMi5W8cuDnVp1JrzlhvYZiPu8QGTjIKFSKjQeck6hX4RuIVZZn88B5uOvW7LP9SqlyxYTVk9pp9wnEjdjziiKumF/uK+pkBM172vtlVHNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1507.namprd12.prod.outlook.com (10.172.24.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Tue, 26 Nov 2019 21:57:23 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::a53c:342f:cd6e:a616]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::a53c:342f:cd6e:a616%9]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 21:57:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wu, Hersen" <hersenxs.wu@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/amd/display: Get NV14 specific ip params as needed
Thread-Topic: [PATCH] drm/amd/display: Get NV14 specific ip params as needed
Thread-Index: AQHVpKEKFkIY1BUhmkO0lM27c2WhP6ed/6WL
Date: Tue, 26 Nov 2019 21:57:23 +0000
Message-ID:
 <BN6PR12MB1809C6D92762CA1ADA8E6046F7450@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20191126213222.17728-1-zhan.liu@amd.com>
In-Reply-To: <20191126213222.17728-1-zhan.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ff642ce-f0ff-490d-0ecd-08d772bb9e1e
x-ms-traffictypediagnostic: BN6PR12MB1507:|BN6PR12MB1507:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1507A6CB471AB61C384B0816F7450@BN6PR12MB1507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:176;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(74316002)(99286004)(2501003)(33656002)(71190400001)(7696005)(76176011)(6636002)(7736002)(55016002)(45080400002)(6436002)(71200400001)(606006)(11346002)(446003)(6506007)(229853002)(110136005)(478600001)(6306002)(236005)(9686003)(86362001)(54896002)(966005)(5660300002)(105004)(6116002)(76116006)(26005)(66946007)(66556008)(64756008)(66446008)(14454004)(66476007)(66066001)(3846002)(316002)(2906002)(8936002)(52536014)(81156014)(81166006)(186003)(8676002)(102836004)(256004)(19627405001)(6246003)(91956017)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1507;
 H:BN6PR12MB1809.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WuVgHLh35m/mfC7COCsted1MEw2tsAaYcRVvO6Bf4qSkhTJ5EBrx/jmmVvTMpEFGCCU+lUt4zfmT735vtmnxctEFg368Q2sp5f8MimXgwjw5QueOUwMB6VO/jTFjrUMIS6EdP6sunJgvsfMeO+Keipz501dKrpe490bQaU6S3uh2yYNqkC8H+m43AFb6UXOKNyOmAKE4pn9q4RtuEV7yPywqkhffhrCexVmMED3WOhKXdENhJrGv4VZWL7TSHTuKO6XEcpiUfpqd6pFdVZYWXeao3R84U63bjMkNlqtK6D7TaC71NTe3B5Fu5LnGF3uW2eO5JWOEVZm44Ylex6hccPv0N29qhF5g7I+7Fyejf9dWiL+W1sEsGnr+b1NJMHPFNwCzVUPFHRMlKvMkLZj8c73GWon9DtIBjs3gibyofsb1iIdEtpbKXwXCnYqcOjoepuLeyHlMinBk6Gkbi7R10XlFLt97D/gJ6pfePOHwAM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff642ce-f0ff-490d-0ecd-08d772bb9e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 21:57:23.1766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6Za72ASYsN+QiPwmgpyqbS9ll41GrsEubKr9xTtId7ZpK+h0vBcpU6LRcFIVdcQ+cGwagr1S7fILzisTOF/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1507
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nJpZw4nhaeqnCR4SNzJwtv806QgOsBpxc91v0okSww=;
 b=cuN3bYSIknfSkrmrGyTDEQH3rQM6ESgtcfqcO7R2FL/5JOcmjrak26WimboDjU3OaRBKHf/Ai9WAm0mnzgEkaQPG31zXpub+hixLgXwT/lLdJCJWrXHYXnjxegwibj0eCV07tvDzX4hn/vfD6K+LRVpRvIBeTh5aEstDvNA6XOQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1594095940=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126215723.oP_ox6FEOJQ2YXXHh6PZCfluK6Z7qKGVkKB2U0QIixc@z>

--===============1594095940==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_"

--_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhan Liu=
 <zhan.liu@amd.com>
Sent: Tuesday, November 26, 2019 4:32 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wu, Hers=
en <hersenxs.wu@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Cc: Liu, Zhan <Zhan.Liu@amd.com>
Subject: [PATCH] drm/amd/display: Get NV14 specific ip params as needed

[Why]
NV14 is using its own ip params that's different from other
DCN2.0 ASICs.

[How]
Add ASIC revision check to make sure NV14 gets correct
ip params.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index dbc0a4a7c284..3dd2b2429ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3245,6 +3245,9 @@ static struct _vcs_dpi_soc_bounding_box_st *get_asic_=
rev_soc_bb(
 static struct _vcs_dpi_ip_params_st *get_asic_rev_ip_params(
         uint32_t hw_internal_rev)
 {
+       if (ASICREV_IS_NAVI14_M(hw_internal_rev))
+               return &dcn2_0_nv14_ip;
+
         /* NV12 and NV10 */
         return &dcn2_0_ip;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cbea3a51cb27f4ad9694e08d772b829b4%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637104007649236121&amp;sdata=3Dp72lWgE%2FB63Exu9JF=
i7eQ86mk%2FbBB8%2BE5BkBR0SUwqY%3D&amp;reserved=3D0

--_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhan Liu &lt;zhan.liu@amd.com=
&gt;<br>
<b>Sent:</b> Tuesday, November 26, 2019 4:32 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.=
Siqueira@amd.com&gt;<br>
<b>Cc:</b> Liu, Zhan &lt;Zhan.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Get NV14 specific ip params as nee=
ded</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
NV14 is using its own ip params that's different from other<br>
DCN2.0 ASICs.<br>
<br>
[How]<br>
Add ASIC revision check to make sure NV14 gets correct<br>
ip params.<br>
<br>
Signed-off-by: Zhan Liu &lt;zhan.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 &#43;&#43;&=
#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
index dbc0a4a7c284..3dd2b2429ae2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
@@ -3245,6 &#43;3245,9 @@ static struct _vcs_dpi_soc_bounding_box_st *get_a=
sic_rev_soc_bb(<br>
&nbsp;static struct _vcs_dpi_ip_params_st *get_asic_rev_ip_params(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hw_internal_rev)<=
br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_NAVI14_M(hw_intern=
al_rev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return &amp;dcn2_0_nv14_ip;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NV12 and NV10 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;dcn2_0_ip;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cbea3a51cb27f4ad9694e08d772b829b4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637104007649236121&amp;amp;sdata=3D=
p72lWgE%2FB63Exu9JFi7eQ86mk%2FbBB8%2BE5BkBR0SUwqY%3D&amp;amp;reserved=3D0">=
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Cbea3a51cb27f4ad9694e08d772b829b4%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637104007649236121&amp;amp;sdata=3Dp72lWgE%2FB=
63Exu9JFi7eQ86mk%2FbBB8%2BE5BkBR0SUwqY%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_--

--===============1594095940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1594095940==--
