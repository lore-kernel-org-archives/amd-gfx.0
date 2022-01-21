Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D105DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 16:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D08510EF2B;
	Fri, 21 Jan 2022 16:59:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F037810EF28
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 16:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFjRAmon+bhqhMbsm58aB+mZMqHvBG+PCfYprlpuUKOk1oal6uEyDdqDkGzs16mcqJX3Rv2zrw1rCbrLpWdITgtEuGHdEPzdv/maeUaIFbREWOlbcPr2Ho5BKB7dLBCN3lVVUYmkS+5D0/esVUIxVDRHDOrDKe1TJZqhyurqXXKlHQ0ExgI6iA+gvlFa7EkUTznTXox/hpV3SQkP80woXhm1gp80qQC6Y0mX62ZsVJ+EEm7sLBU4qfvbXWuYBlpExNulH/4SMGdvHwD6ZrTmDFNV1w0sy824ROwtldhsqQ75qhY8hrhUbFtopr3qmxz/a+NJ76O2JH7l9XPRrR0X9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZAyjsI9SgZnCgtG4QB7FZerHOsnn5NE6A9CUfARQxU=;
 b=lYwTAPlUiR0/RI1M3HnKQRIvmERfwDD9yzQOBkndslSvqqG1ZZDLK9WGISsar/Ov9Xp9irV/QUnk03AOSqBt8LyTlmY5GPuBdPv4Rf2dpesMpmI5fb2GLmAWeDHSVUNREE0SHvd++auUVP9ITCT7cqDYhoFI1LKRfUfgNGgdtGBGNnmTtIWz/hweChuwnQchYPNZ5XPLBXi6BO0iRtqRDmwjY7Qgn3dGV1xHn7Im6h5K8/8v1OAkn5yG4c1xVjCoTnCRc47ajAjWVS5lOUOz3GkuixZnJD38sFCRqAq4/Btysi5v/Q3Bb6lcOk/OU8KyPm10dT2oj2aAawHRK2qGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZAyjsI9SgZnCgtG4QB7FZerHOsnn5NE6A9CUfARQxU=;
 b=yOMZk7CYWGPo0ROQ5lVeA2Qw8/B8ZgiBc7FXllktsxAg/n07+U56dyCuiuwFO5DgEtiJWwp6OvHwgftte4KpK5LtFxILFam40K8VIKIcpImLdDYkQ51kTb8dD7aH/fa3prdgLWlauSs3jwwIcLw3ubUbDAB9F6Np3JX9fAJqKzQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MWHPR12MB1744.namprd12.prod.outlook.com (2603:10b6:300:111::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 16:59:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 16:59:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Thread-Index: AQHYDig0XIc/AObvQkqaNwI+pz/o/qxstfsAgAD96tg=
Date: Fri, 21 Jan 2022 16:59:30 +0000
Message-ID: <BL1PR12MB51440AE2886ACA76CD25CE60F75B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220120180429.616236-1-alexander.deucher@amd.com>
 <DM5PR12MB2469737FA78BF772FEE50E59F15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469737FA78BF772FEE50E59F15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T16:59:29.752Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 5a415c1e-956e-57de-9f69-6b1218066fcc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bb7542b-612a-426b-4ad6-08d9dcff647a
x-ms-traffictypediagnostic: MWHPR12MB1744:EE_
x-microsoft-antispam-prvs: <MWHPR12MB17448EFF1C0DF64F32A4ADFCF75B9@MWHPR12MB1744.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpe7zt/5/Mcm+XoCUclpHNAIzPfE2atzin4v8RDKv34JN7bfweY1l/l6l0SinKBiB6v3cR+XK8U3TxCUjpy5zNOk1NJbyTsn39xGUwuz2cyzdFLL9JHGHPnVLHUMSEJJfbpnTPi9HZHdZCKxkpmQ/GKttx7d06wprPiFjyaRPaTg2lBywnZCDMPmgQuamAjl2oeBnOPxf2JE3SC8hcUpEWT47avqMQMmPqZe0fs5lsAbmFqIiJlZi56Llvz1u2F9/mbhbziCck8T0GGc3/XOO5K+xKGMUt1CgHOi6i5/3b9dCyFRePPj6cvlZRWIuUqaJPWyMZL5MKfCl1GRDiz1r9zEmESapgum4UsACJWYoClkv/HY3TBEWGmg1qT3zh6+VV+mFeHk+St4wetL+uHv2JLsYwTE8vruN+3d23dIH6yEAqkLltrxZJzPEL0iiG/Mnie1HsebTjiu5rrNwXphkfyWLwBClxDvognSnf7zHamTdEJhi4stuwHCusV3v1TPllg+EhStEqeNtAJHz0hQzwJVNIWj4NqjqnqdXQGQ/8ii+qPKkSmN1cKgsFWVLPbbSYzIm8nhl35GBCFdXPjSvzWcJaj3ejL0torSy+85LIqdKZgIze5lZrBn4DsA5m+2c3WDldcQU2axG9Yc9ud7gXxiFNsh+m6LIS2fEaXKJmNXdqAMHEItmmOJtCsHonenaR45aBux+r3YiM5XkXHz0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(83380400001)(2906002)(33656002)(8936002)(8676002)(316002)(9686003)(71200400001)(110136005)(55016003)(38070700005)(86362001)(19627405001)(186003)(66476007)(26005)(508600001)(6506007)(53546011)(64756008)(7696005)(52536014)(122000001)(66946007)(66446008)(66556008)(76116006)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zEjHjJ/O0RCXsljtHspiV6WpSdT8QxLtRsir3uYFBxWbWYjVGb1JeHGamNMp?=
 =?us-ascii?Q?1twdnqxkexGc0UjGU0nCoEyUrIw6SnaKk3SstrO9tZyXIIHaCOdjS4Whw9cY?=
 =?us-ascii?Q?yPVtEw4p/dYCpZS78iTgczO0ASL9Dd8RTTrguM/9uFIEcL9rJlubqGl7UMX/?=
 =?us-ascii?Q?Mi6GVTSW9A0x2qQxwMLZGxuEoWuA2fvFbhupjAIGLg6th8ovx1pKnqLfBAdo?=
 =?us-ascii?Q?Tlw580mkH1M19/XgprDlNQ1QIg+n7xVlR3yeMWFwTvKr/Vq9REEnopiF7egT?=
 =?us-ascii?Q?EyKe0KNFxAJ1ZbOn7np0FtJtuEZkZlWmk+9eGP/gOknRto3RSH8DrUkdRatR?=
 =?us-ascii?Q?he16wbYqKYT4Z8f41ZM4gU6knVsFeUZSfIxBg2eVs5xxJdMFFadXoBnPmh9F?=
 =?us-ascii?Q?Ne/BlKwWbr5wr9GqEKEw1ccC2YCu9DsO/45/0+0aWPBSASDPEldY9TDXNYuL?=
 =?us-ascii?Q?SqUqy11Oo0hNIanGCrY31LJdlF4ehB2y58YKSQjcZvEo0MwNqiGvv2/PjoZ7?=
 =?us-ascii?Q?Rb2HsYd4JV2EBhzkkszrTS7TP3uDkkYIckwIcs9TaguTy1qHJoLaCkGFD+6r?=
 =?us-ascii?Q?6o5qRcM+NweRaNEc58BkcthRF51KPgyrkzZg3a6kaKro9PbqW32bZWV7jlCF?=
 =?us-ascii?Q?/s+rlqAE5NCAuHMoJYtTvA97t40HXynZ3oE7cKnKF68jT2WCvnB3GWTxU15k?=
 =?us-ascii?Q?MP6FO5iTtS6D1qvF/kdAccrQu53qJYdKaDCu4Vl+c+X6tWSCGZcaP58+5Co+?=
 =?us-ascii?Q?Fg9Idrhz4Ii53fL8gtW4roBqWXm8rRDEVbn+wjZiD9Hh0txJFso0eUjMb0FH?=
 =?us-ascii?Q?qO1axfNvCpHZq2K1XCEc/LQKaFLD33k9OO7KXCWkMcYt7aW4EjpD6ToHjq/u?=
 =?us-ascii?Q?y0tIzo5T2COJhlwSHuM1UXP0luli5mGxSikcoy6E8ox5SKcGEYtbmaBupzM2?=
 =?us-ascii?Q?ow2CB3eOaxXb0gTHMj4/G2D0eAKrVoFIOe7pKiIJufpXy7/GKaqJ0yqOGB9x?=
 =?us-ascii?Q?9Z7gA5aWuYapaVuH26FZg8TT0c6v9JeSyyo7uLqNoDx7Ee4b93qNyHFgFkmU?=
 =?us-ascii?Q?7b/dMfZP+L/TwFz4fPdY8nK4z6yxFFFcjTxIK6VJVHQFybQHfxBmYYmfhXgf?=
 =?us-ascii?Q?6/uMwOX4d7DqLw5yHvG3meVO5cbGvcvaA59nL8oVHRrFYgB7dngFvvIIhK4a?=
 =?us-ascii?Q?xvV2Bl7R5CeGSPFfAuKO8sGNW1RWkwPlY3aT6jJR6N/rKEj7+jMfTesBmkok?=
 =?us-ascii?Q?cHgYJiFYpWa7g7wtMVIhTDPkBCzjuqA8g3OVqOy43rdplJ+larK9y6JbGN1J?=
 =?us-ascii?Q?YVWChz6U+TgcjGryP3l45+xWUd1P+tSOxA4wps4BWTkMpFcglGsRdeKQfKLm?=
 =?us-ascii?Q?7oYHLZE2FkaPHZT4W3k+NIx8McTeN7R1p0laNobAE4bq5QHPJ+ouwi5ftEHJ?=
 =?us-ascii?Q?qmIIrNK4Pcm5WKKpEWs4db2owgfN2BTJtl9TEIpMXkc5cvPL4BjkB+FogdZG?=
 =?us-ascii?Q?ha0OspCd6yQwVAyfu2tJWaXWsT2Mmbk35jtzFZCT5iXFN7DGZ1W2/KBBwHLl?=
 =?us-ascii?Q?MDBPHLRf7+bqIn1qQAL/Qdf+vjNCT6iwbsESUf6iZ+yRfHC3XOg6gMyZ6kXT?=
 =?us-ascii?Q?mbWgVBz9G6f1F5+2fDrUrk8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440AE2886ACA76CD25CE60F75B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb7542b-612a-426b-4ad6-08d9dcff647a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 16:59:30.9205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzxwTD4hHAgtltqxpIdV+NxrzFrLcGmQ4HU1O1+mLG2CfNiTJNgidMQLNJB2WwBY+H4jr/HZB1M8fwGmRIEyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1744
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

--_000_BL1PR12MB51440AE2886ACA76CD25CE60F75B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

It just changes the limit for when we use msleep vs udelay, not the units.

Alex
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, January 20, 2022 8:49 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait=
_for_training_aux_rd_interval

[Public]

If we change if condition, how about the division by "wait_in_micro_secs/10=
00", as the sleep time is less now. Shall we adjust it as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, January 21, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait_for=
_training_aux_rd_interval

Some architectures (e.g., ARM) have relatively low udelay limits.
On most architectures, anything longer than 2000us is not recommended.
Change the check to align with other similar checks in DC.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c
index 1f8831156bc4..aa1c67c3c386 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -202,7 +202,7 @@ void dp_wait_for_training_aux_rd_interval(
         uint32_t wait_in_micro_secs)
 {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-       if (wait_in_micro_secs > 16000)
+       if (wait_in_micro_secs > 1000)
                 msleep(wait_in_micro_secs/1000);
         else
                 udelay(wait_in_micro_secs);
--
2.34.1

--_000_BL1PR12MB51440AE2886ACA76CD25CE60F75B9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
It just changes the limit for when we use msleep vs udelay, not the units.<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 8:49 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in =
dp_wait_for_training_aux_rd_interval</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
If we change if condition, how about the division by &quot;wait_in_micro_se=
cs/1000&quot;, as the sleep time is less now. Shall we adjust it as well?<b=
r>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Friday, January 21, 2022 2:04 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait_for=
_training_aux_rd_interval<br>
<br>
Some architectures (e.g., ARM) have relatively low udelay limits.<br>
On most architectures, anything longer than 2000us is not recommended.<br>
Change the check to align with other similar checks in DC.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c<br>
index 1f8831156bc4..aa1c67c3c386 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c<br>
@@ -202,7 +202,7 @@ void dp_wait_for_training_aux_rd_interval(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wait_in_micro_sec=
s)<br>
&nbsp;{<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wait_in_micro_secs &gt; 16000)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wait_in_micro_secs &gt; 1000)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; msleep(wait_in_micro_secs/1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; udelay(wait_in_micro_secs);<br>
-- <br>
2.34.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440AE2886ACA76CD25CE60F75B9BL1PR12MB5144namp_--
