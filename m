Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF830ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 14:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B828710EDF6;
	Fri,  9 Sep 2022 14:53:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE91610EDF6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 14:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVJfnwLRBXEKvL8SxPfqjEBwXqca030jelDiSdbOn4TXFYdnKH2v0x75NKKS9jCvjjw/L+kVKx1KDiZVCUW8m8QDRV9pqbRqRuVqMn31Igbuv0tGYfbnqsNSZ7YpiSowcJ+RyaEOo4Aki7omUnzVxAaweMlvqHeQ30ZaloviJvjtdE+cetzsfqRrGvojK431E5CVoDNqFuf5vcyPSRs4LUbuDTW4hqIAMSAL6QgDK96b8SNyU6kruvsoaoZUxKgAGXksEf7feuQwlsckRa1SqcEt1EKNS4cnSI5kt63iqJbUhZxOLUJKuaFmrKa1Ibe1Dwch3k6XLl7aEQkuHRI/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6oj+kmI9id8OUPuSIJuZbwzTU2ViW5yPBwwj1gi1Ys=;
 b=j9aglML6un1qgHKg5GO9eNxECwIEjOgXh+Uhv07yAtOiJnwGqcoAnqvo7kmo32edtLIuAlAwmSMNc/lf1yGTg2hZolKYI6SopowD1npKdVRh/gGy1A1DKhVGbAme1b4QTw5WekehMq+kbKNhaA1TWrgcQjaYkoBFPsfR4c616qIGC8KqhpqeyIcfNf/RO0+IB8cCH4lCu3TE6mb9miKFIoEM1o2UHcifbWc28k6P/cbsnqKXUyaX0oWYcstyPaHYVwLVDQRX1fkL9EANWdb9QjKWogDb1CsJx3ykx/jSwtKAlEtr8Is3x1QCXTUKV92Dqvl4s+jS5X0eXNOfFm/KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6oj+kmI9id8OUPuSIJuZbwzTU2ViW5yPBwwj1gi1Ys=;
 b=GoH9u1kggzBKvT8Yfzi+0T/orwvxj7MNCtkBCRMBAs+wzYCZ67psw+nEm/F74mYnci+29AESJRlzgWukhsWsHBlB+hfcx9cwD/HllTYvqF8vz0sDTC6kW5cE6l2DFLQgIEfYuzd3eyiHWhiCggtI655bNxmppGMCtGF+ILMtwlI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Fri, 9 Sep
 2022 14:53:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 14:53:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3 3/3] drm/amd/pm: Remove redundant check condition
Thread-Topic: [PATCH V3 3/3] drm/amd/pm: Remove redundant check condition
Thread-Index: AQHYw18hho0yAdaA2EqzMKeiJ+U2tq3XMBu+
Date: Fri, 9 Sep 2022 14:53:43 +0000
Message-ID: <BN9PR12MB5257B956B25C6055FB42B860FC439@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220908084236.110566-1-YiPeng.Chai@amd.com>
 <20220908084236.110566-3-YiPeng.Chai@amd.com>
In-Reply-To: <20220908084236.110566-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-09T14:49:55.1284248Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4581:EE_
x-ms-office365-filtering-correlation-id: 58470e03-7781-44d7-33bd-08da92731743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RnrqVuBb0nFvGlJX2NtqkU8OSVdJ/Wi5O554QOR0YI0Byoh2rNRT4PQyykbiEROrJ45hrNLlSD6tJthklC8AyaLzS5y5a58O5+UzFUlLjoBm7zE3aIwtETcLd4Dsy7K0VMo4xFSWC7gsDRXzQoMeLHuFYQMnYHTSl4NzP+NCnbShBurk1g1zilJleKIeUZViLUGHsJQdntbGZTaSBsUt19I+m6qru/smZvxVl6g9yOAPIpb82cSJlTY4z3mpl0eWoGCHKZomt+DgiCwUQcZ3qUVg2lSHk1GBfEOwHEAt2TlBFGU+lFEh50J1XC3y4pm8HygshCWymdYUnTnNH1yTs6LFx5XnIEcjDWONpI/d07mR/2ARlVpwUIee62va4eanU2OvNnKNwTso0HHalpoACEZ1QHs7oPRCmi5cgUhSgm74864pK2OQ/R7u3fxH5gRrsoC7KZvastdPVANfzYaVXQM4/haDCgrztIKSlBIigUJ/KGsEeBTZTjfPmaNUjJcZztp2Ef4QKp1coXxQCW3U7E7dSMpvku+TfRSzPHLpJij/kXlVwAmzUDfBbPYI7rmfGwB2dNiYesI3s+L+OrBk2RUp1HvUtx9UrE48u5A9Vrlnj2CCxTKIqyjkaZ4DsxuRlZ3fuW2rFbNDCijumO5FJ3VfLtutYB2cI/kaeBsGw8gH5Y79/Smgww2+kIFyCGVR6Fl+RKPeTbJg1/FpvHiiL9EvsPMmSxOcULSK9cLiQcKxl56pNS+h0owxzAtOMmEtnw8cxVvteVfbSKImJTewaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(478600001)(7696005)(186003)(26005)(9686003)(53546011)(6506007)(86362001)(2906002)(33656002)(71200400001)(8936002)(5660300002)(38070700005)(52536014)(54906003)(110136005)(316002)(8676002)(64756008)(66556008)(66946007)(66476007)(66446008)(41300700001)(83380400001)(122000001)(4326008)(91956017)(55016003)(38100700002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JoYRL7Tsxnr7n8l+xR8we+mxc9lqQC9JvX8EI6PWYrthaRg85YuIdUlFAAcf?=
 =?us-ascii?Q?N8ygHxQGK3Hp4XFMIZ6d03Id68CG3s3NiMATGqgYwSzfvBIQdb4BQKN6Ys8b?=
 =?us-ascii?Q?SVvILl8JAAyop3e/4b52eb4zgGt+H79vyd9uGFnCo1N4qnJC4qtp0YNqMHJI?=
 =?us-ascii?Q?xruSQ1n7w9Ieo5nOmEqgqjQ1umVkFDfhklhTj+S+qZNVbaY7tF/FaqpHbR9G?=
 =?us-ascii?Q?lJdwCKx4w9QNdwIVjxWGpcUyXBQkZPSaYopJS6P5U7yD0RO+ZT4mZcn9MQZC?=
 =?us-ascii?Q?sZhSdpjlss0D5YeYoRSCPmZPdmjF2VtKEqNCo3xqGkRQPLJ8hLWTHznWkduR?=
 =?us-ascii?Q?nrx3mXl+nuGIgM9Hj2hxMTaJiyxfjNbaINKsL/D/8L4BSrg54lrkuMDwf7Fr?=
 =?us-ascii?Q?c9LyCeNDkLvR//NU57RwBVePcNgaLf4P5zyTI3SkgyrrMJ/lvAbQiptxaGug?=
 =?us-ascii?Q?hl/hzSxuMuKoL6+wvadNJpGIcEps/NYIitoW0VWoRpQoNPDRRh7L1gwTYRt7?=
 =?us-ascii?Q?izdPWJJKWSudyHfEAKhxDt0pQpAmANpc7Dtkf89lSelhKnucp+eN662hZv0B?=
 =?us-ascii?Q?NYXz8YzuNXfl9p1pXSGk54vRNijCy1RhfN7QJca5H3LRU6TVyXOLByHzHqxq?=
 =?us-ascii?Q?QkJbesDfsxlrgZKp20HlkazjGJYeV5PzyJkzGdUEMDBBy22d1tg89y7HfZyT?=
 =?us-ascii?Q?Kjaf+q5XVk+HBB0IUYF6tIYWJRBQfDOVIVNkf/J23iSAQfixx4VdBqP3AvFa?=
 =?us-ascii?Q?qLY/uBA+xOL1m2U6E7n3BlC//yMkkQ9PQ6LK6cGxu6nbqbL/h/BEUlyig7aB?=
 =?us-ascii?Q?5n5dcw0xrYJvzqCLm9+v+OYyoFI7l/FM1UiMBXrpzg8lDN9w3m81GICsWo/1?=
 =?us-ascii?Q?TbcEIu9rmOVWvMuX7NvbwGZU0/B27L6Uqm940wAvUxe+KAO+C/NGw2f08uZ0?=
 =?us-ascii?Q?lIQPGuYF6OQQNCsTaL5L96GYYy6ASpXGzTpKRvK4sVJyEAyGP+ujW1++8K2S?=
 =?us-ascii?Q?eZJqxlDuM4HqmULZpNomKCD9LkEc89IA6NFKhxu0v2i2iHXBJjUSDM3hjJKS?=
 =?us-ascii?Q?DfsoCIEbxB/3iiHdpjIqfJMJy2LDK9XqJdaWWYGGcdkHq1aeSUdlwm4WHv1+?=
 =?us-ascii?Q?CBNZKMp8CALiGNTGAO4PaqldNFnmi8YXfM7RSxtPmQ6gf54v9Se4PvFpPNPR?=
 =?us-ascii?Q?bfWQV10TPCALQgaDjCpxSxGTOFpeb1j1Ci5NcWYsWWm7WMeakVGRjZkBpuAk?=
 =?us-ascii?Q?MQjWh/g3hN13sNgELxsUWmho2V+urL/2l4csJS9QJDYV3+IilW0A1p5GGJHQ?=
 =?us-ascii?Q?1Um1i1R7L9kpUyrM6jmSCvvviNfwR4W50LbeMRMRHWrQVtwXpuy69cPX/HKs?=
 =?us-ascii?Q?Nqyoef7nfu8d1PiqZ5eB3DyvaLKReUdmNIt5HcUqmQPBk9yP9KH3SW6950rw?=
 =?us-ascii?Q?/bSE/efqWyNO4mFT2scblaDyvnzh/pTZ8bbMWUG/pkm51ptCmCO/+LiGMP7R?=
 =?us-ascii?Q?MdQu1l484bfaovudnHlrTe+kjg8mCr+YhbI0w55Yv7CPGtshlk48ns70ABns?=
 =?us-ascii?Q?MHnDlRXKMxuVRRaSY5tEuNd72cksR08uJQqW5rVYFrPp79iEayP/ASk3fv9g?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257B956B25C6055FB42B860FC439BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58470e03-7781-44d7-33bd-08da92731743
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:53:43.4896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AR7GBNlX/cWsduxf0af8s4gmTpS+43HdVwXQxYmfHgJHEl1giOkqGTKnQsrhV2ZtlpPWiDOcCACZrKMSWnQSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257B956B25C6055FB42B860FC439BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Chai, Thomas <YiPeng.Chai@amd.com>
Date: Thursday, September 8, 2022 at 16:43
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>, Zhang, Hawking <Hawking.Zhang@amd.c=
om>, Zhou1, Tao <Tao.Zhou1@amd.com>, Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>, Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V3 3/3] drm/amd/pm: Remove redundant check condition
V3:
[Why]:
  Since ASICs using smu v13_0_2 have called smu
.suspend before calling amdgpu_pm_sysfs_fini,
pm.dpm_enabled was already set to 0 when smu
.suspend was called. This makes it impossible
to delete all pm sys nodes.

[How]:
  Since all functions in amdgpu_pm_sysfs_fini
have their own condition checks, so the first
conditional check in amdgpu_pm_sysfs_fini can
be removed.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5e318b3f6c0f..948cc75376f8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3405,9 +3405,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)

 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
-       if (adev->pm.dpm_enabled =3D=3D 0)
-               return;
-
         if (adev->pm.int_hwmon_dev)
                 hwmon_device_unregister(adev->pm.int_hwmon_dev);

--
2.25.1

--_000_BN9PR12MB5257B956B25C6055FB42B860FC439BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Series is<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Chai, Thomas &lt;Yi=
Peng.Chai@amd.com&gt;<br>
<b>Date: </b>Thursday, September 8, 2022 at 16:43<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;, Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;, Wang, Yang(Ke=
vin) &lt;KevinYang.Wang@amd.com&gt;, Chai, Thomas &lt;YiPeng.Chai@amd.com&g=
t;<br>
<b>Subject: </b>[PATCH V3 3/3] drm/amd/pm: Remove redundant check condition=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">V3:<br>
[Why]:<br>
&nbsp; Since ASICs using smu v13_0_2 have called smu<br>
.suspend before calling amdgpu_pm_sysfs_fini,<br>
pm.dpm_enabled was already set to 0 when smu<br>
.suspend was called. This makes it impossible<br>
to delete all pm sys nodes.<br>
<br>
[How]:<br>
&nbsp; Since all functions in amdgpu_pm_sysfs_fini<br>
have their own condition checks, so the first<br>
conditional check in amdgpu_pm_sysfs_fini can<br>
be removed.<br>
<br>
Signed-off-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 5e318b3f6c0f..948cc75376f8 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -3405,9 +3405,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)<=
br>
&nbsp;<br>
&nbsp;void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled =3D=3D 0)=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.int_hwmon_=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmon_device_unregister(adev-&gt;pm.int_hwmon_dev);<b=
r>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257B956B25C6055FB42B860FC439BN9PR12MB5257namp_--
