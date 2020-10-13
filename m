Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD4C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 12:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA6622244
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 12:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iUhGPhr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA6622244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE606E30D;
	Tue, 13 Oct 2020 12:22:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC7F6E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 12:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQmjNEcuKgjnvuIPWCxo9GOb8/w2KtRhD13Q3cEdN+tDVWx2MqUrQe9fU1xNvu9/Q7yy2pqpCUAlPwz89gYw4yO8Y7f80bn5s/vSkSQQWOMKco5vvWTVC9MoijFsOm+35KrkRHKiraF9oxz6/2Jw/iOBFOqwIoQ2KM7kik2lx3yoP9XoC/43srPnoxQldkJx8C2WP9soeCa1tb/BDYBw2pFIIVjfVh6RlPS3sPbq6Kks/IqJM+ruhjimEpPknPFdH8P2PFH6MafivwfpPw0AibvpnOOUXKN+yfCeDx0zwz0R4keUxBOdFe7I3G9DoyD1An2wpU+UC7VKL8bps/RYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWRwboFtvpuQle5SpjMD2256SEW7GvoDVOKTBRUnQho=;
 b=aLenDUVfT/DtTY97nlPtzHnIKT6rQvf3Xx3+WK+PErAxUql1QPnFhh0URxTxRGAn91yq+1zEVj0hRKMS6JD/VwIvRee44PLgCDzDIZszHbC4OQYJ9znhv8m8or9qrSWctHIt1+tsP2FBYJCQ9+vxnZhlTig4BKr0SBtoX9RwJvboqIO8tTEW8OXwvH+Z9abAWr7PxDm1jlQ0BcClYp0cFjnLEE0GkmlvPDmTW/j0Vo9N/OL+NWC5Z66LJQ2vrdkw5fxG3MWkuUch9Hnm24kP1Tma8UbYGWI5pNfdYNJNyStGn8l6gDddAm/rqjXK7Sfk0qGd4Y8z3VZPqbmdO0gs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWRwboFtvpuQle5SpjMD2256SEW7GvoDVOKTBRUnQho=;
 b=iUhGPhr8L45zEYy6+MQOKoh+CSuhiDFMEjhrA8YrCPW4RjosNjv9GKAcnNOBSciPFORqppRVRgq4RHkfYAIH01Vu4q1oW3q+O2VzcKHUYSdN9cYsCbnbu1jWTsQdu9YVpTwFTVd52h7MqtkTXmWwhXMWOyjBUIiosG4B6T1BpEA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 12:22:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 12:22:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: increase mclk switch threshold to 200 us
Thread-Topic: [PATCH] drm/amd/pm: increase mclk switch threshold to 200 us
Thread-Index: AQHWoSyGbWQsHUejmky9FSxX8bGMvamVdKpH
Date: Tue, 13 Oct 2020 12:22:39 +0000
Message-ID: <MN2PR12MB4488F4504CFDBF25D7AD9F6BF7040@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201013064543.22320-1-evan.quan@amd.com>
In-Reply-To: <20201013064543.22320-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-13T12:22:38.642Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d82d616a-dd1e-4f9b-6b0d-08d86f72ad29
x-ms-traffictypediagnostic: BL0PR12MB2401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24014169CA6FEECC1A732222F7040@BL0PR12MB2401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZNC9XyMPQNuBmCddRNimxm4yHBA9MCpgC/t8n6hSPBZYv1WuOyudEDuYXJHDyhwND7WuwA+i+ASv2KwOWQpMQzV2w4Veke0ZMY4kZ9Tgr+szwiNFSZZsXktMIWHX/56SKvpn57johuaUVMn3ioJsDsA1csZo2auelFJhC+pwjmsBDviUxY3vpqdGvSDCOoqklyHbc5ASYzWA37mYIZ+vxj1mx2EkCXnVyXtDNYyvHpQKHfEFE2cP/TCw10mgOQJilUbdr1CWsRK+dEWTWRn6X24NVpRK3gMn0vn1178xS7dOAJFdJjX49Zb9ZfcmdADH62KZYADggIpJHdG0gej3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(5660300002)(52536014)(33656002)(83380400001)(110136005)(6506007)(316002)(19627405001)(26005)(53546011)(55016002)(186003)(86362001)(66476007)(9686003)(8936002)(478600001)(8676002)(76116006)(64756008)(71200400001)(66446008)(66556008)(2906002)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1/O45VMlYf33cWtzkCa3rBPEEcTdqvdZY80TvFb2+x/nl7W2Ar6iWydgShOJOEMz5g4CCqchLJAt2n4DpLz2JXbVAyAv4/T1yxvvBfZjAnmiscdaAOKLJZ61VlNzpfBkBKyA0N0kxCaFcT5BxEhkI6Qb69O9m9JN9FYjwNondbHG/IjvXp23VzPiqANdRYwD2Saos1W0IDNECeGL1BHxXkXVO4TOZl726n6YdE9Rno4HJO1WBbBQjVEfEokxlprk2bjy4bScIqmxX5z/Yb/Cn9xmbU/QgG6Z8xLjFJ/KnTTNqjt2Jkf7JWQepZMUzUBYjwdcC0CkUwR2x00+7DZ0jDqGksxSuOE3WKGpeasURGDtc/4yi3TEL1jpfLpbTa7oty1dplyQacssd/R4Vd+p7Xt1EGWAoAnYHUoE9OL03+UcWdFty30dKfYXuVjgDp61o/e+yYKskZQVO/0fFSy9x82Z5gcH9fdcjje/sftTll0Z74MfRQSEBfdZeGxnvFaE48RF3K4jVBwpFxnDhhY9Y3lHf+u1EWxzdQfhiFvqRuR8RxjJCza7+5l6Z3LgXg/R9trP/3RW9XVsgE7MR7DVQWABXvQD8nuixXbB/RExvRf7+y6mK5ovJLTxT/bHtXF1TpzurwWzfEh1+VycJd04vA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82d616a-dd1e-4f9b-6b0d-08d86f72ad29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 12:22:39.2563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LrSPwbcNsFizRmd1Z9N54vW6jXnbKd4oL1ajQZ4mYn+dnRrsNPWmEnLFE+ZstL2d4dYHyOZxLj5dn5qo+8rdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2401
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
Content-Type: multipart/mixed; boundary="===============0206957128=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0206957128==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488F4504CFDBF25D7AD9F6BF7040MN2PR12MB4488namp_"

--_000_MN2PR12MB4488F4504CFDBF25D7AD9F6BF7040MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, October 13, 2020 2:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: increase mclk switch threshold to 200 us

To avoid underflow seen on Polaris10 with some 3440x1440
144Hz displays. As the threshold of 190 us cuts too close
to minVBlankTime of 192 us.

Change-Id: Ieca0dc900f0b5764dc661e397e41e8c277ff13de
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 3bf8be4d107b..1e8919b0acdb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2883,7 +2883,7 @@ static int smu7_vblank_too_short(struct pp_hwmgr *hwm=
gr,
                 if (hwmgr->is_kicker)
                         switch_limit_us =3D data->is_memory_gddr5 ? 450 : =
150;
                 else
-                       switch_limit_us =3D data->is_memory_gddr5 ? 190 : 1=
50;
+                       switch_limit_us =3D data->is_memory_gddr5 ? 200 : 1=
50;
                 break;
         case CHIP_VEGAM:
                 switch_limit_us =3D 30;
--
2.28.0


--_000_MN2PR12MB4488F4504CFDBF25D7AD9F6BF7040MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 13, 2020 2:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: increase mclk switch threshold to 200 u=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To avoid underflow seen on Polaris10 with some 344=
0x1440<br>
144Hz displays. As the threshold of 190 us cuts too close<br>
to minVBlankTime of 192 us.<br>
<br>
Change-Id: Ieca0dc900f0b5764dc661e397e41e8c277ff13de<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
index 3bf8be4d107b..1e8919b0acdb 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -2883,7 +2883,7 @@ static int smu7_vblank_too_short(struct pp_hwmgr *hwm=
gr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;is_kicker)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switc=
h_limit_us =3D data-&gt;is_memory_gddr5 ? 450 : 150;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch_limit_us =
=3D data-&gt;is_memory_gddr5 ? 190 : 150;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch_limit_us =
=3D data-&gt;is_memory_gddr5 ? 200 : 150;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGAM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch_limit_us =3D 30;<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488F4504CFDBF25D7AD9F6BF7040MN2PR12MB4488namp_--

--===============0206957128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0206957128==--
