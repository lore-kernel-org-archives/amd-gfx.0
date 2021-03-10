Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443DEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 07:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E791060190
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 07:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E791060190
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684216E9CE;
	Wed, 10 Mar 2021 07:46:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A456E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 07:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXF+3LQh4vKt5cQN+v9NXESyTZUwKF8OKY7/tlEE/FMDOJcRh24VEFAuUljqHvnG0LRhSddfaTcGFFxuyi8KOLbVnhikoZB3w5BXE4CXFBvM3vtY3kaZih0HBNf5UH90QIFayKOi00G0H7v6M1IImDadefBocBJnmWyg8Bjhd5jszONlJ/3fdMtNts/ZWwmhKVeTmamgr6l8sn+Bs5mfz/bg9tsgYHy9s3r+8L9iCgpOuV0yrY0aHgC5I3yW0qa74xAsKMzMpEVWyZddKmsF4ItaifVmnJv7Z3Wl8icppes7sOMRhjoxscDGqlhjkj5vd4O1lENX1aoGXSwdT7OHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GNK70JyoNYAL2dbcBi3kXwnBiRIitAkvkOpUPiGxw4=;
 b=S7Fmj0fsLud5k6TWey6e98Cghy7MA5hvKoFBo3nk4O9Mb2JNK+Uekg7F9b6EQHxauOT/BrRQq8t6w6zMsQbfuOwmzj9go9G8ihc67tT/U8f7t3Dou81ReIHeYIlxtH/GI3aenTmhcbfF4FmjClTu2nbCuC6Seu6pU7PtTRo9wZpQRTMa98QqrEIb6hBx0sVPNpGKztx1/WMzO/qs3yB2QYrjRTjIwwpJMIjQ317c4ytLgiWkQsZ/lzBhVUPpnP0xucI2sTa1gzTsta5NlKi2LFqztBOYtueFCATus58xwyOqIjI803LlMw9ma/tEcTwZ9QgvB7t2lIqhnUTmAK7hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GNK70JyoNYAL2dbcBi3kXwnBiRIitAkvkOpUPiGxw4=;
 b=4GtbtHetlmbDpn0F2mg3cs3lOBmmXQ0bEi4pdvg8S1uP5nprsHYYmimQjZMlGdflz7aYIQ+sz1AKiWCM1OXYSDu5eDhEl5Q8Nist1aFsSdCnVX/navL8Qjlpy+dM8awb7cXREjraEJBxh9N1HvzVxMRdFne4RC+9MeBu7LQY63M=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Wed, 10 Mar
 2021 07:46:15 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 07:46:15 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: correct the gpu metrics version
Thread-Topic: [PATCH] drm/amd/pm: correct the gpu metrics version
Thread-Index: AQHXFX/PuZ8ZBveTMUOjzju4AMDGPKp819NZ
Date: Wed, 10 Mar 2021 07:46:15 +0000
Message-ID: <MN2PR12MB3022F84E1413A485EFDB7D12A2919@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210310073401.815536-1-evan.quan@amd.com>
In-Reply-To: <20210310073401.815536-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T07:46:14.312Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01e90453-7608-4cc5-4939-08d8e3989569
x-ms-traffictypediagnostic: MN2PR12MB2943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2943685DE33B80BEC8E57662A2919@MN2PR12MB2943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkkiYd+PfWazlQUQZS8WJy7FeDcwg729eptUS4ufvHxWH50hO1JMWIuvjvqvJfsSo5xzWXV7s/UBbU3kVIntRSf2x+aBugcQQCDSNVI0MsKMrLOpt1y0Wsy1C8TWxyX5dpP9byltRa6894WKsB6lopxujMJLbG/3kCqd9NweZYFMKcJGsx0p4mkZyaF2lm83nC2h5qp4uSLQ2tKKoLKpRbjpUs6CMMW6iJZXy41PoMWAlnubpRYBBQm6G9qclz4rFgkLj/5lxCd7vhG7VuYHtB08b4VX9FwQ/9EDU34EqK7IeBRmUh3DanEF7Rj5K805WiQsvrB/LgT6zQG0JmsttepmNmMLT1xb74xBGSrUp5RPwq/hEHvqMhl1ykcvKlNvIP2zuLJb3u4U6+yHkNAFfm+sCmw24xEF5bSV8RFsFybeRW6gSiiiPuXQo0C/m+jFMOSWZmX4L/ct30uevyZ53yvrFi/eeTobH5KWVQmnNercjDRxDL5Ij+ZaPDIZCF590lV2aQw6Qu4/kWW5F9k2whK5EOa7nWP1BjsBrhENMEaqJJqWJYP0RqXE6fIdToUp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39850400004)(376002)(9686003)(2906002)(186003)(966005)(166002)(83380400001)(4326008)(7696005)(33656002)(19627405001)(66556008)(66446008)(53546011)(8676002)(45080400002)(71200400001)(5660300002)(6506007)(55016002)(66476007)(66946007)(64756008)(76116006)(110136005)(91956017)(26005)(478600001)(8936002)(52536014)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9czPOtA+eDTrIwTVyajXeTGy/FdTwzTFxzs6tcwqa9/H1ZsZJ48B/zSUw+?=
 =?iso-8859-1?Q?VuHNZ1gTa6mOQGQaE1feczir5TW7qBeOSF91RIBKqY0J4PVx+VN0PvNC5l?=
 =?iso-8859-1?Q?9mLRCMH6blwzAKpvuBnM65JjN3mj9Ry4v5tmnwGfiE4RR/bQDnAdkxQKQ/?=
 =?iso-8859-1?Q?1gxSGaRSayOquWOursm4MRudHfe3eNCwx+ZqwKE9F4KJ5X7zXqEub80eBv?=
 =?iso-8859-1?Q?4cb5wS3GLa0xH34ipbvkqwos8u0pi8c/WVyZ4OxXy8jWqaMU/dWGok8VTw?=
 =?iso-8859-1?Q?s2mS8upaygGAu7ygQqkOpxyl3FZA/gNAvJPrpmxRlyes6rghA/5HCHhbVs?=
 =?iso-8859-1?Q?/14kohjCODuRXloybZ5ARxd2LyKu6+R7pKzPratWiVx7EFO75EWFgqPeUH?=
 =?iso-8859-1?Q?poqClynVafDgr3mEz57TWw/xi+EeYV8VWDEQvJKBE1kHZDC1yepYNvFsuu?=
 =?iso-8859-1?Q?MOOZd08PDK5rXtZobf8beyLjQnXfdYp7d2Ined8MjvcP/7p8olHnEX0eIl?=
 =?iso-8859-1?Q?RjlW/g+DfR255nVO6oIR3JLoQZqM+cHxAfLsidVKVQjul2UPw5CEfXmtZ5?=
 =?iso-8859-1?Q?Nd7YRmMKnNepQbvrg/Boih88TZxB05ZcfJ+USTjgXylIXAwEYtRN188ncX?=
 =?iso-8859-1?Q?F3dsgEfzpI3kE1dRDpuVGUN3U4If4SlKoRB99NA6iPtNSx2f1j5FNFHUjA?=
 =?iso-8859-1?Q?emCeQzX8MPGLiS2geteqkE6o2l1NjXtyfyteBcgEntcKgMQYC3ulxRdJOa?=
 =?iso-8859-1?Q?RYkpPkoKcFdpTgbSMdU3Y0g0rI8Fhhwrgn900Ju7dvKhIj4uGniawfyyWR?=
 =?iso-8859-1?Q?NzQlzr8hiVdGKn4u0jvQYov+O/ygNhG/Gfu1R6vCKMWIzuGgALclFviM4F?=
 =?iso-8859-1?Q?XvuLt3iFZy+kD9tAQ1t/LNxPgeJp4NnTTT7zAjYmtnCTELygAGgmnG+kmk?=
 =?iso-8859-1?Q?Qf34kRaNsL1igzfXH8O5mvjat3/uTLq/qnQ4BJzh8Okz89YO+H5yv/N2KP?=
 =?iso-8859-1?Q?DIaKU3j86f9mqe4V/2YX1v2YobA+uCCc0ixb629Fs7WXIIKsYsiQGgW3IH?=
 =?iso-8859-1?Q?+D5KgU7XuvwOUfO+nGNwtaqd1bWxbFtrW/M29Z3JDpiLA42kS5M7wSwwJw?=
 =?iso-8859-1?Q?yxkgRaetuH73N7h/L3oEWc6mGoNlRe4T961Sp5zbchjJZMA3A0lQJQ6ySo?=
 =?iso-8859-1?Q?BEgnX8u3rZDET2XZVI0xjUd3DS7JsVysEDyhoFAiBNzZF9PqzLlwUajSax?=
 =?iso-8859-1?Q?RoEqh6v+o/d6AQYexk3qa8c8b8YUooptjPkPQN4C0gXyvQgHpLXhcgGJNh?=
 =?iso-8859-1?Q?TULEcWLHDUbUPBCp8g7MLkqgCkDXSf48FU395DHKLDf1ZH2vCwMkHZo7Eo?=
 =?iso-8859-1?Q?DIbQSxquep?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e90453-7608-4cc5-4939-08d8e3989569
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 07:46:15.3155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qskFj0RY8mRrcyqil5qLi+gkIHEEgKYBrrzKDCo707pfc+Fh5fnl49MBbdni1QsF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0689566272=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0689566272==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022F84E1413A485EFDB7D12A2919MN2PR12MB3022namp_"

--_000_MN2PR12MB3022F84E1413A485EFDB7D12A2919MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Wednesday, March 10, 2021 3:34 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: correct the gpu metrics version

For V1_0 and V1_1, they come with different size. Misuse may cause
out of memory access.

Change-Id: Icd06e673b9259d8d381301c145f0e9eff3408ee5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 740025ee7f78..9b0bc570d31a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -206,7 +206,7 @@ static int aldebaran_tables_init(struct smu_context *sm=
u)
                 return -ENOMEM;
         smu_table->metrics_time =3D 0;

-       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
0);
+       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
1);
         smu_table->gpu_metrics_table =3D kzalloc(smu_table->gpu_metrics_ta=
ble_size, GFP_KERNEL);
         if (!smu_table->gpu_metrics_table) {
                 kfree(smu_table->metrics_table);
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Cc31b1fd942bb40c1588608d8e396f111%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637509584725486440%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DS3=
QQf%2FepFOcCSvDcU%2BGQVgXFTJcqlt5DCfueMArlIBg%3D&amp;reserved=3D0

--_000_MN2PR12MB3022F84E1413A485EFDB7D12A2919MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
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
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, March 10, 2021 3:34 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: correct the gpu metrics version</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">For V1_0 and V1_1, they come with different size. =
Misuse may cause<br>
out of memory access.<br>
<br>
Change-Id: Icd06e673b9259d8d381301c145f0e9eff3408ee5<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index 740025ee7f78..9b0bc570d31a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -206,7 +206,7 @@ static int aldebaran_tables_init(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_time=
 =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_table_size =
=3D sizeof(struct gpu_metrics_v1_0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_table_size =
=3D sizeof(struct gpu_metrics_v1_1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_=
table =3D kzalloc(smu_table-&gt;gpu_metrics_table_size, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;gpu_met=
rics_table) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;metrics_table);<br>
-- <br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cc31b1fd942bb40c1588608d8e396f111%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637509584725486440%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DS3QQf%2FepFOcCSvDcU%2BGQVgXFTJcqlt5DCfueMArlIBg%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7Cc31b1fd942bb40c1588608d8e396f111%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509584725486440%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DS3QQf%2FepFOcCSvDcU%2BGQVgXFTJcqlt5DCfueMArlIBg%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022F84E1413A485EFDB7D12A2919MN2PR12MB3022namp_--

--===============0689566272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0689566272==--
