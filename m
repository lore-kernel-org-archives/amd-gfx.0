Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E81C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 14:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3416EB4F;
	Tue, 23 Nov 2021 14:24:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256F66EB4F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 14:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuYmy0U9sFSJSrVRT3/3fDSTiNefLIzgZs2NHfH8vgApL4UrVoGxEy0B89qqSy8VpOLfbInPOjETHALlI+Ej7oLxKsCw9TpRBtYd//as0BujoGVQZ62LXQmQRQA6iZv308yWhG1u4qSXQ8jqG9tTqiUkLl/AF4DQmlPMbsZdVDsU+30L3KPFLHG2Xz1iBkEMX+QJbko8qsj7hvlJXNyNEe6qN98f7dLkHMNOUDjWhRaF9kuql/1ioDhbF9C/e4m459elMTHb+S4Tj0TanU+Xhv2Tyo+lmeEBDyZokH44gduTFkhJbUAbHtHcLnmUMa0i77E3bhDALTFd3T+C963I0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of7/DDC5aYSXe9oMkDwud2gZG5EtC2/YhOMfPnvmDic=;
 b=YLav4PBwdSRQnqA4pzK+zFFdyW9L2ipKcfLhaVJ5nREJ7h2j61WcZndvTYTercjTvOQ0joCLyC57XJT+3YqTtjdMpUnR5UI0vW+PA0Vi4/TxfWr2FueaP+eAzFb9wbPBS0Qn0ebsetA7v4GcTiZFdOHcjuShRWdZwnhLKFo3HhB3G2vodKudQLOSuvYA2/Y0NagF+1RvYHeSDmeqL63kOx/w/eL2PuuXnTF4VEKDC1JSn69GfJPdjUIrJRaTROSIvebu9WldZ5G8Xt1/ctt6sS8fDErPv08nZZwsb6oAQMGmgtXAd5uaLXl+8KaE7LjBBAo7fo/PMKQCXscX0Vw8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of7/DDC5aYSXe9oMkDwud2gZG5EtC2/YhOMfPnvmDic=;
 b=oxTXyp1w5DD+8ugeBlNTxB/+ihizgPzdRdr5wyDc3NmcePsIqOL7lEnJc7I/3INrPJC4CyvvuQuB+7WSpVW3CQA68SSMTVgjH2B0wkKWKOhtyn3dLF0Fl2IsndudzDZIWeCdC6lHNKY9ESIDm3ZXm0JPGECN6WLl6h5IiYDl2Ik=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 14:24:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 14:24:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: Print the error on command submission
Thread-Topic: [PATCH 3/3] drm/amd/pm: Print the error on command submission
Thread-Index: AQHX3+/hftUby85MJU2O40csgX8JbawRK5ZA
Date: Tue, 23 Nov 2021 14:24:08 +0000
Message-ID: <BL1PR12MB5144AC44017C728C30B5E14EF7609@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211122222512.58886-1-luben.tuikov@amd.com>
 <20211122222512.58886-3-luben.tuikov@amd.com>
In-Reply-To: <20211122222512.58886-3-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-23T14:24:08.509Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 93f92ea4-8da0-d852-88a8-15adc54ad7ee
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ac9ed79-afaf-4676-aafc-08d9ae8ce9e5
x-ms-traffictypediagnostic: BL1PR12MB5112:
x-microsoft-antispam-prvs: <BL1PR12MB51121FC09AA9E27D4E661301F7609@BL1PR12MB5112.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bh02zSk2VRdP6L5Vc/6mLUYCA72tkXaGX2ZsXR7QXeu+b0jyKttanA8BPxG1vvEdVBXNb+ICqLQrBm50Z8EXXGDi0rDvF7mRy/4pmX+nz1qF3z3I7wP8ggKRIg9BdLndHzqY9IUso7p23iv+BZM+2x62KH/vswT5G31j/C5f2H1pV1p983Qkzu7NwzlXm4oT2asyxnLPDIaPu/cuJZzOMM/C0umLYa0dC1gONu4XjdqQWURymYDvIlQRvFOrbWls1+mm+xq9hVBNF2b2v/uRUW6U4jpReUFfXK3JUnjQ6aNYuQsQGnHu2/43mGvbPxw48awdKA1ZtEuFCW5HCYQGbVj0GMilhrAAznxRCRatLcw7EVVYLtil+2pHo9KurShlg3SBD/Ls/DTyxqp0+6HOfAwfgz/D2RlSucgL03aeu3aoEHDA2bv0SttiXlueGWXamKGvXjclBS+ONKgLK7QV9At5O+TDy7j/6yDOpeqwCbCctIAyyBAvF3ighu8Cb9NNVJObBjWZtEpCarhCk21J+59at8THGvsoqCSPUic/Klqr9xWZXIqBJVflB8S2rBGqQS5NTebou77tBXkzNXf0EzmcCDuSwGsPdA15GvGXkNxfkq1h+5rjKRUJIHGM81lvAd6C840dbyAGyT9Umv6ukv3q9sClmYjdMz/wLTwdw6taAn2YUulGYa63cIcNx+302z4nPKCuwploqfR5n6zoCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66946007)(66556008)(64756008)(66476007)(76116006)(26005)(110136005)(6506007)(83380400001)(33656002)(186003)(8936002)(38070700005)(9686003)(86362001)(71200400001)(508600001)(2906002)(316002)(8676002)(38100700002)(5660300002)(122000001)(52536014)(7696005)(53546011)(19627405001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bur+clwd6zoUvG+kR9YKrHqQW/+asHr+7e8DHySCpV5x/5aAkBzZgbvRs15K?=
 =?us-ascii?Q?BWAkBL+1iOWIq1VVnT8CgXht9njE5oDgcaUPHs3N+MMtKA1nsefON7dppEaA?=
 =?us-ascii?Q?IKluRSovOq0nGyU0UzLBFSbReqBTbO2L8eu0yOd4TOGmLYUTHyNWy0m5sSwC?=
 =?us-ascii?Q?akv3ty70O6855acLUGx6xG574MbewtKkS9M89K5/q/kvdDifRUbPKEvDjifL?=
 =?us-ascii?Q?6Y/OuMKQMBATJY+5SpM148EaZG90t9chuI8qHsam504QPgOSyT8tCi69fcw3?=
 =?us-ascii?Q?xyQkqfk9HgFXovhGU9XleGL3s/9fuRmlSYv8WiZLFu7rTrxJtaD3RKF9phvR?=
 =?us-ascii?Q?EUGM5LMdPh80scWTh/h0Qihp1YN7XcyABUJqit671MIWRaSo1tu3IvGG7c/4?=
 =?us-ascii?Q?7K0RS+SSRtR0+WbVzuj7iMQEAbQleFqoWUuMXmBxxdrh7YZBsiPNknc/1jmR?=
 =?us-ascii?Q?3yLLmUPbPq/0GCJqzi5s1HkdQLNAWw3TOa0j6hi/z/fGIs7oZhn7xNOQi5Go?=
 =?us-ascii?Q?Y2S7yPuEgA1uOTmYEoMssDVSsBya6oxMA++C3k/Cpy7FBAWF9xNarrlFcB8k?=
 =?us-ascii?Q?VPumNFa96269zeGlHQa3xfI9Y09oxB145oAL9oycmb3dLQuRfi1AGZ7fdxB4?=
 =?us-ascii?Q?qi+zM6cKEM56sVoegrjekQUX+EWXBCTxQChr7LdZy6NvAIO1zc1EVZP2EmrU?=
 =?us-ascii?Q?rXwJxm3ALer9aKYkvAGmpGmUXaXFnXXJZTBk0Gb/FSlCr6qoXucb6oEW3Yf8?=
 =?us-ascii?Q?eQwn4RvKebiAFRbqCnSGEZFUhLzr5Y4DvqHYX1Aqxx5B+Ll8UsIKHWJ1Lww2?=
 =?us-ascii?Q?Jy2AnWgvf19n5IOKVUfyPB2/p6JMq1OwMgsenryrfoO7Iz2E38qSh85kQad4?=
 =?us-ascii?Q?w1salZEdyNCHmb4EE66XbX35oMIFPDFajzyVahVT8bX2AAnXLdIJ4dEkVHFa?=
 =?us-ascii?Q?jCzNE8kLFb8utf5SJ5YQQPolcEfnxPCIYWRc8mHJznOYDP2USDk92wBQGpGH?=
 =?us-ascii?Q?84ZeL2C7FEQq87ZFwLMsx+BhE6Nbd6uWHUjIfbsYb3IKj1xgC2SnLMJOBoyE?=
 =?us-ascii?Q?AxeSzdpyIb6qssayv8pQAB1ET7CNHd+WujvnAF+lfkBkFAheu1bpD8ugx51i?=
 =?us-ascii?Q?fXpQ8Yns5y+7fL5yrUdUstKb8vVU4gAoQs/mIQCf2mHa4QDVkgFi5rqv+TuN?=
 =?us-ascii?Q?REMhgsftBcMZULVruB4uT1lEfr20vNiC7yvLnuC0FdsOIjLM3kGZj716dNup?=
 =?us-ascii?Q?qQ+mp0RGRlqPgprEsOEeiVbgAwG4/bBxaAB3+l++tepT3xDhZxqRzfcNYQDe?=
 =?us-ascii?Q?6ALp/VxR1xcdSWdwojxnhZhsytO+bf5xvAxcxd/QoNOT0m1mU/j9Y1QdeekJ?=
 =?us-ascii?Q?NGefLroD9HQuZWwNbPP2Xq4Q3QO/ZOJEcWTrVQcY7XSxaYtYPthiq80sAMdA?=
 =?us-ascii?Q?xA9zdKMAHOZOA4PwH5Y2KnXp2Vw1My8pvJwE58X1LEsSKnYTSKqwSBBVoxhx?=
 =?us-ascii?Q?pfpF6j6CmppuAJxfU8ppCEd0VMTWMYnX4B4mol8BWUW4PGP/jAlio27aWh2H?=
 =?us-ascii?Q?kyl0ykT9vRFo1mUAz0ZBWWabbC6nedVKPie6zRHVPk0lfetllDztJoxmjOFi?=
 =?us-ascii?Q?5+veqzGQ63ul50+o1/NMwD4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AC44017C728C30B5E14EF7609BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac9ed79-afaf-4676-aafc-08d9ae8ce9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 14:24:09.0003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxxerOn1TxfoIDsmmPA3q/DIQvdSH0EzU/bc73rHKDHIRCJNes9yKN/gjVCIkyIZKQoLyPNy/PWAS7gFU2vKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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

--_000_BL1PR12MB5144AC44017C728C30B5E14EF7609BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Monday, November 22, 2021 5:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Print the error on command submission

Print the error on command submission immediately after submitting to
the SMU. This is rate-limited. It helps to immediately know there was an
error on command submission, rather than leave it up to clients to report
the error, as sometimes they do not.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index f9a42a07eeaebf..048ca16738638f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -352,7 +352,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
         __smu_cmn_send_msg(smu, (uint16_t) index, param);
         reg =3D __smu_cmn_poll_stat(smu);
         res =3D __smu_cmn_reg2errno(smu, reg);
-       if (res =3D=3D -EREMOTEIO)
+       if (res !=3D 0)
                 __smu_cmn_reg_print_error(smu, reg, index, param, msg);
         if (read_arg)
                 smu_cmn_read_arg(smu, read_arg);
--
2.34.0


--_000_BL1PR12MB5144AC44017C728C30B5E14EF7609BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Monday, November 22, 2021 5:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/pm: Print the error on command submissi=
on</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Print the error on command submission immediately =
after submitting to<br>
the SMU. This is rate-limited. It helps to immediately know there was an<br=
>
error on command submission, rather than leave it up to clients to report<b=
r>
the error, as sometimes they do not.<br>
<br>
Cc: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
Acked-by: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index f9a42a07eeaebf..048ca16738638f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -352,7 +352,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __smu_cmn_send_msg(smu, (u=
int16_t) index, param);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D __smu_cmn_poll_sta=
t(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D __smu_cmn_reg2errn=
o(smu, reg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res =3D=3D -EREMOTEIO)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __smu_cmn_reg_print_error(smu, reg, index, param, msg=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_arg)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_read_arg(smu, read_arg);<br>
-- <br>
2.34.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AC44017C728C30B5E14EF7609BL1PR12MB5144namp_--
