Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4786139E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F4786139E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6256E46B;
	Thu, 21 Oct 2021 16:31:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9143F6E46B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDCX/dwqUSzU+bGURWBxW1Sofumlbzshp3/aqjgtlXmxECeuCKzgDVSNtlzDa4KebQVCrLCZqwJz16mbc8NVDYprxQrxYdCLuCnbT/S9IvPh8V5UGUAxiZNgAqrKoru8bVT4zvDf4w4/pe5EWvdkR9T6u5aNf1WIAwYNC0ZuBiEXJtRuYMAGK8dDGACfGNOlZCEu37AWaHin2VhH/VWLONFa/e5jO8PZd7JU8MHapWLRuoLLI8J6EssFusQ+syWllz7R1u6F9AuASnZgVxf1OwSv5qxXqS5Z0PAnM391IrH40bwGjQdEOaTNrZnj0FxJgtzK02z5UkjT11KqRy7z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4oFQrBngfZdoxXCsmWQz+K4/gcmwzCPyp0RSg1XBDk=;
 b=kMoxQlnYCkMvAP0bffQWMUPa+AcM+ZK5x/qLZlN5KeSRLJ3tsSrbpZS5Cl+NLy91kqIIpyshm+o2HhBJtbfkQaxbRLP7qzCDtuJfXeNbpUmeUjBPeg7rvDmMdHi6nbWJHeveAFeBNJcTzllxQXl05ua1eueOh6yZ0RrrFTMZB4g/dxtvHDb91e9erSxD7fM6oRYtyOB5ztrAK6eeflOLe6/c+qgCJ7mR0IpsTPzyMw0nJ60scLdHfcXbVmmgIta3EBfJAc/HzWpaIkWESSFmzpBMPyy3xa+70e8MW6hVx6pc1iEWRg+sulPIhBao7frcm9urDFjosuOSlYYQx9hTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4oFQrBngfZdoxXCsmWQz+K4/gcmwzCPyp0RSg1XBDk=;
 b=RSesqPpru04zwd6/4oJ8c9vzzWNl4dlDncCbiImuKsEJOoxzJZ6WtfhRGUEZSb6cWm9uE6ldL7R6ke/GUbgbTth8eUplTKstyFvtWOyyBPe5SpSittMfAe2IU9wHrK9yhPIXzOZwI2r5spNeCoSQCNkBmRa93rWGNLj0EjBxhUw=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 16:31:24 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 16:31:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Thread-Topic: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Thread-Index: AQHXxpRhYojk6G82Ak6FSEAVsNusmavdpKsK
Date: Thu, 21 Oct 2021 16:31:24 +0000
Message-ID: <DM6PR12MB3930E947DA9C82EFA8DD53C797BF9@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
In-Reply-To: <20211021155711.1191830-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-21T16:31:09.5948587Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7399d25a-975a-449a-bea7-08d994b03918
x-ms-traffictypediagnostic: DM6PR12MB4497:
x-microsoft-antispam-prvs: <DM6PR12MB4497FD84D14871403F9FCFE697BF9@DM6PR12MB4497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipKLDv6OmG7s4qbpcg+Wgylv/h5NFLPvuzVBoaL/ODCvIXFNhq2qkWkGKOeoROro6vBtsM4S0YYAIcYjhKrZTnjuzQp6H4vTQgFUHi5Q/k+xg4vQselffnu2QK0LTIWWwztZxa5gjOQ6tWk6/iynrq1t/UQQHZbLilsaQxd/1Rm93bgZo5Hhu9fcpIjM5HP2qjiH3dQ1yRiBLld+dX194gMC5HQodDMetvVPPN231DEhWMv1Ju7i2TzbTMfe2VABIe+pVqvGaypgBHsQTim0xAGwXGuL8JqwqSSBzBcPEx+iBp/GPH/UzqD75zUDxOYG6M54Q2BjcOFRRtHiZuKlI9zvABx0wESl08416kpnoqX6duBPTv2ZOugMTB5dtLk+XpUldUDrOD309i54H2Yq2hjQpmAK9v25HLEb/xWBHBKfeFfC2GZdRf5s+E93p5C+MDhEVRFgxYF+P5EIhCjqU3AfoswyczbhW9/zm1m81sZIYpyHjGStzBcd6Egvt0ymbROKK+siSFmGt3ZN8mghkcuDT4efzB8+OzAdbuEO8dD/entD0YonzMHLadraN/Zy3UwHNkHw4Y+z/VMNVxmSMhY3lnbxZzcRIHE63CN7eReNlTf+LDyEfKphFoyOjE2xA8ILIILe7C3GnuHwhHtElwySd68VTFFTZDaF8LgMEQiTPejsrmUNZC2Q5kmWsEcskvAYtFD0vb5CFGRhg4tkPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(2906002)(5660300002)(86362001)(83380400001)(8676002)(91956017)(76116006)(8936002)(7696005)(186003)(53546011)(71200400001)(64756008)(6506007)(52536014)(66476007)(66556008)(66446008)(66946007)(54906003)(26005)(9686003)(508600001)(55016002)(38100700002)(110136005)(4326008)(33656002)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?owLL5KNLt2sdn0Bh3B4lDQ2iiJ4zXVR25Tel4XzBZ0MVNZsZq32cnSXaf8PW?=
 =?us-ascii?Q?A/To22j/4xIDUBW5sXTP9ah7znNOGtlHhqAPiw4McwZkLRdmcvTTgfz9yxDL?=
 =?us-ascii?Q?5gWVdR6SzyFzNp4xkhdBfkWOO4P0qxfPC1T6nLeE5rFluXV2QdZ87bBTfg9N?=
 =?us-ascii?Q?ECRp+5pQ4xyAzGzQ8wtpqhSKHdwcW3F6uB7pjlkBmM7izGHLzPLBzd5HYXRO?=
 =?us-ascii?Q?MJHgzvl4rVg5YEKS+b3wdnoGVyq5XpwaM2rA0RHSDt2C+cygzt/+GzP15nI5?=
 =?us-ascii?Q?wNLYhputwZrSw72titkzfz51jtC3zUmSog3NN6qOMKnWFoz3M0ID0igX5kKP?=
 =?us-ascii?Q?JBdsV5KI46nosM2jkJnu22HfbeFw/xfKwzEIhiV9AXelqW/P+hZu5zgzSeEf?=
 =?us-ascii?Q?aEJT81OLoVLIihpXR2da0MxR3rrf0Keg2TQLaOhj/plRvsOfv48tfxsWzEcT?=
 =?us-ascii?Q?YD6Z81YG9RLZXgqwOeRCqTxp3B/HaZVof/b4nUoGrzbes/bfwjaYM6c6TH21?=
 =?us-ascii?Q?hX3ZDT1y/mVyBo92vPNy24E/tvatBTXZnbyjbKc9P1pQ03uqrjUG0ofwxk7J?=
 =?us-ascii?Q?7YL5raIWnnjCcf3yRJJZ8lrCdjaxxoxaDYIjVD/YjbEzEvX4AvLongCJKU/K?=
 =?us-ascii?Q?yR93I7iPAHq17xZD/pd8hB9ie6L3cmVgT9JAOd+whKr1ccviMCLHmDbz+yZV?=
 =?us-ascii?Q?/8OlIM29m5fPL7SZZgRhaojKBdYYTW87Gnmp0kIYY4dcWploDzTq9dqTGcld?=
 =?us-ascii?Q?xSiNQKmT1iG9eowFrNu2evmfIl2Po5hjIOUDvwlwlVZXSnELfaUtmfFaHdoh?=
 =?us-ascii?Q?vnJAk5qiAT9yadBsRL1JqT2rIG9nWJx4ErSnisMRMMrf7S6tzCDQfr/MWD2E?=
 =?us-ascii?Q?QzBRXc32GdEZQCLJ+UM34AjFceB1+gTtHvrd5f8b8pEeKV8XpYJzMJFD1Cn5?=
 =?us-ascii?Q?m8SVKUxkLUVojOMJieBfKtTmYuUTFiCEEYNmvopnevvEBNZN5UHye3lQYzKP?=
 =?us-ascii?Q?KUsVN8i1X9TS3t+UK2w3ulgA8Uwxdd9r2acUp4YtBbZ/usiVl4trhhNi33eh?=
 =?us-ascii?Q?JwZkygVqXYITlqgjWecxrPjrHzcCeotZjmrHH8HJ0S91Xj844XcCZIOdAj1h?=
 =?us-ascii?Q?Uj49yC/D/ufz9gV0DL3nqQ9WNB21zZsEPhLpTuBgdXxlacwfYTCFUTQn4Tk7?=
 =?us-ascii?Q?u5towTSQ8Jiq+fNHwBlpnYd/OKK/O8Y/xrZSw7RZ+ax4stvXyFqFDnrQZvlS?=
 =?us-ascii?Q?yVsV6wNCUc2nAa7SjmlUwbPPhcgRzpNZAjJqEYqc7gUmGkIkmanT+C9xpuDe?=
 =?us-ascii?Q?oDkbIGF9SZjqEASp+WCOSvC+Tl0pVYWqBfTqWrlqAx+JrJDYkdrGFVvRH7ag?=
 =?us-ascii?Q?btFFehheA1FWGJuHc3KzYVEUg7IsOABgy98D/6D7tsMhEHIfZ2+H7tfBTqN7?=
 =?us-ascii?Q?ERHCcrlNATY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3930E947DA9C82EFA8DD53C797BF9DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7399d25a-975a-449a-bea7-08d994b03918
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 16:31:24.0724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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

--_000_DM6PR12MB3930E947DA9C82EFA8DD53C797BF9DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Nit pick - suggest to use dev_warn for easy identification of the device.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Thursday, October 21, 2021 9:27:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.c=
om>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90% thresho=
ld

dmesg doesn't warn when the number of bad pages approaches the
threshold for page retirement. WARN when the number of bad pages
is at 90% or greater for easier checks and planning, instead of waiting
until the GPU is full of bad pages.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4c05ff4b26c..ce5089216474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control,
                 if (res)
                         DRM_ERROR("RAS table incorrect checksum or error:%=
d\n",
                                   res);
+
+               /* Warn if we are at 90% of the threshold or above */
+               if ((10 * control->ras_num_recs) >=3D (ras->bad_page_cnt_th=
reshold * 9))
+                       DRM_WARN("RAS records:%u exceeds 90%% of threshold:=
%d",
+                                       control->ras_num_recs,
+                                       ras->bad_page_cnt_threshold);
         } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
                    amdgpu_bad_page_threshold !=3D 0) {
                 res =3D __verify_ras_table_checksum(control);
--
2.25.1


--_000_DM6PR12MB3930E947DA9C82EFA8DD53C797BF9DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Nit pick - suggest to use dev_warn for easy identification of the device.</=
div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 21, 2021 9:27:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; Tuikov, Luben &lt;Lu=
ben.Tuikov@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90% =
threshold</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">dmesg doesn't warn when the number of bad pages ap=
proaches the<br>
threshold for page retirement. WARN when the number of bad pages<br>
is at 90% or greater for easier checks and planning, instead of waiting<br>
until the GPU is full of bad pages.<br>
<br>
Cc: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
Cc: Mukul Joshi &lt;Mukul.Joshi@amd.com&gt;<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index f4c05ff4b26c..ce5089216474 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (res)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;RAS table incorrect checksum or error:%d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Warn if we are at 90% of the threshold or above */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((10 * control-&gt;ras_num_recs) &gt;=3D (ras-&gt;bad_page_cn=
t_threshold * 9))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;R=
AS records:%u exceeds 90%% of threshold:%d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; control-&gt;ras_num_recs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ras-&gt;bad_page_cnt_threshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;header =
=3D=3D RAS_TABLE_HDR_BAD &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bad_page_threshold !=3D 0) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; res =3D __verify_ras_table_checksum(control);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB3930E947DA9C82EFA8DD53C797BF9DM6PR12MB3930namp_--
