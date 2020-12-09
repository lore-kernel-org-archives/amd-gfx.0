Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EDCC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 02:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE5123B28
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 02:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE5123B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1696089EEB;
	Wed,  9 Dec 2020 02:19:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FA489EEB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 02:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zji9CyvXdBdfnXVlGqn+pWf4yNclxiu+jU6e+NI6aUPkeNhxzWC2RXpCG634taD5o5zfmVsOkqNDlJb9wDGvFaax5NkLWhGBE0YWfBgEQkfaAxfk8/FPe/0OpQzquA+7gbzNL4D3NxHe518emHlvNw3lvMkft9EelPozIpd6CpuRqHegL9e/btboKblCVpUJNhoSP++aH2Hi3Wbq7eCcCzw5iNM/KaoUUqsjgT6vGcY8ba/qa8iy6SWcuCl9H2UdQh2zwOD5tUQ68dYhg2AWi7WqVS/LOVKTOug/n/6ECXkiwnMcxNsOVDscY3LZJ54Jm4TeDInLLnbgcr0zIil4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iuPT8bMosQcN13CXTS0STzVfnCYGyK9Bs0oRGM1I04=;
 b=aDpd5JyrJW3J1U/lbog/vrSFcFavG7XYs8lMcGeLxf6OAX6dxK6VlLeWfBh2X3XM1nJc4d9jRfYu9B1kpuujBzQvHqaAMp3hubgfyV+jv1sE/Rdx/6cgF3AueZ6J75VDw/+b/EbtjRN+SqKCSqX+9QnF7ZNqt91obQYihFPZLwiqd9X3dNPMythCmF25U0rG3cMEMJRnzyIsbsf8IVtD5n54vAq3G4YndO+xIu5AZIY6vg/jH1Iqkrd9qj9RqOKeRamkXUfbSHpo6D3Sg/AuR1rmPFAqMWEkq4wxX0QP8gMswXbBHeXN4EvmWiiFmuKwYfXv4w1x9EW3Vjuig1sGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iuPT8bMosQcN13CXTS0STzVfnCYGyK9Bs0oRGM1I04=;
 b=h+4OG3yGgAZDY19CE33+RrLrYacLZI1/i4L9NxboBx5qCs1GbzJdKgz8Wrwc4rpsdaceSqwDPccSjLkQCBJO4oh3gmygZou7/lOm5xh8DDYDYbhHJrq84+taviXQ5CV3rrZ07kOiyprXHr1HtXfHZ3lpv9qe08ill+0SoQX6cYI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 02:19:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Wed, 9 Dec 2020
 02:19:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for
 raven
Thread-Topic: [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for
 raven
Thread-Index: AQHWzdANY7dYNtJ9OUqv9nwyZPX4uKnuB5Gx
Date: Wed, 9 Dec 2020 02:19:24 +0000
Message-ID: <MN2PR12MB4488A42C699D71E4578E42E0F7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201209020656.7285-1-changfeng.zhu@amd.com>
In-Reply-To: <20201209020656.7285-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-09T02:19:23.677Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df03c059-efe7-4d59-84ab-08d89be8d8c2
x-ms-traffictypediagnostic: MN2PR12MB4567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4567675F82185C972F909FB3F7CC0@MN2PR12MB4567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukYW2MFARIJWW/Bj4FmQ0dhios28qzIfZC+lMSwjqwdNpYkp+q9/tNd6zBzoRpENfm8PC+cdBILTNVsyKKIn8G93hB4r+SSdVw0yOx/8scS5DKlNT4Rz5Hhpn8RRs5mTdTQubjMJQb5Sv0rVpHOUVyMFcpShAy8UshM5Wv1ASgW61IJhECG8F/2P7hvaAMwUdwC04Xn+fO7col++mVw+UkCRamoFW6Zj8nZQ5OtWBgiBoxtlN1jrWf90tWnFQh9mykoHNZj36kB8B4emBSaAciZHPeQ34arKZ2JlO4M81qMrco0pQ4OidbKDTRgZYfBomP4EZAA9lOEeOg1sC29ErWj4oaVihG+LGpiv8m0/PDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(966005)(83380400001)(64756008)(66476007)(5660300002)(86362001)(166002)(52536014)(26005)(110136005)(66446008)(76116006)(15650500001)(508600001)(19627405001)(66946007)(45080400002)(186003)(66556008)(6636002)(71200400001)(55016002)(6506007)(7696005)(8936002)(53546011)(33656002)(8676002)(2906002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?B/t531qRRVZLnhHawgABHKXQoEMfvLTcvdNrbGk6fx08duUStFlMffCPBp?=
 =?iso-8859-1?Q?l+BNN7HxvjQPizATG3pH727E1ZI1RyPFu5zx/cjYDIG933trD1YdaRFdNk?=
 =?iso-8859-1?Q?oERwiIEsFRI8rVXYLnzNzzuCH7GllUE91zsFDu7hkSGRAaj1eV6YBgXE+e?=
 =?iso-8859-1?Q?URjdwIfvbwoet80fALU5rUFEn624CrqP1xEiu6Iq9qMak3lQ1OacC1i2iv?=
 =?iso-8859-1?Q?OfRgKSTc8FQiQgvwgaPkqfKyTi49kSnnmQaVnlx9vip1fU4D4w3lJwZxI9?=
 =?iso-8859-1?Q?IZsKZgzc535F4v9qXk6zEAs2645kwt5c1088+my2Cz+TExMyc3MBh2TCav?=
 =?iso-8859-1?Q?J+5vtPzG+6eOjMdbq0ybGbsMIVo463k8N103t29z5cAE9SSUFIuAxa/E5k?=
 =?iso-8859-1?Q?Jm9V0aujEWhzLgiDHAnLIc73QhOx4+lY/swrYuIqhWeW1+1lDx/ipCiJSf?=
 =?iso-8859-1?Q?xCMuoY3P6acYC5N9uphs6kXTcQIZ8yfnJ3zb1N1QifpxB9bbip/Hzf1gXj?=
 =?iso-8859-1?Q?IYWxTr/D3FKHNCB0UZZnn3o8RGQeVatCam49ZticBqZlXiyGM6/KfAu5Ft?=
 =?iso-8859-1?Q?rH5b/WWuAdbh2Xg8RMJJgwAys39yWA+3YQVvVpJqvRffnNda49rN61f3Bf?=
 =?iso-8859-1?Q?J8TkyV6wwerLYgVVpHcjHkxzcJrZqIcHbRfjxBkVWXRLLhyhKy6kRsWidh?=
 =?iso-8859-1?Q?BUWSyQlzlaCobJOqDzwnrWYRyW7sZutcFtWOJGpIwR2hmeePbifuycktUO?=
 =?iso-8859-1?Q?l+jVXDeReVwxygfrKX7pKUb3ApEq7H/TbjTrjYBr9Nl/GXMAgjKP3o4wvJ?=
 =?iso-8859-1?Q?wPhCV1KFNxL/szUJErMgNyp7QR/mN73xE2A6HpRg0YV98ky2FvtVYsk2Ow?=
 =?iso-8859-1?Q?GMun1LwY+e86aR8O8ViRrVbjH1KzZmcdS1/+GkAaY6SxOT5+D86e8JQBq2?=
 =?iso-8859-1?Q?gpb9dfnbxLnkp2ZsKinzHJ7Y7OKQfQL2atbHPHc3blNAmQqLHRVTty2Amn?=
 =?iso-8859-1?Q?bDHIu81qZqVVhGe4Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df03c059-efe7-4d59-84ab-08d89be8d8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 02:19:24.2945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b46pZ/eKzxfadg8fNq5xi34BiLKpfD+RvOdLJ6LwB5cx0PMTxfi644YrjB43/8Rr3BmXF+UGHt0ZpbLJApVotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
Content-Type: multipart/mixed; boundary="===============1980684332=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1980684332==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488A42C699D71E4578E42E0F7CC0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488A42C699D71E4578E42E0F7CC0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Changfen=
g.Zhu <changfeng.zhu@amd.com>
Sent: Tuesday, December 8, 2020 9:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Huang, R=
ay <Ray.Huang@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for rave=
n

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

When using old WORKLOAD_PPLIB setting in smu10.h, there is problem that
it can't be able to switch to mak gpu clk during compute workload.
It needs to update WORKLOAD_PPLIB setting to fix this issue.

Change-Id: Id2160a7b4a6cb8808d100de25e999714a7ccaebd
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu10.h                 | 14 ++++++--------
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  9 +++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/in=
c/smu10.h
index b96520528240..9e837a5014c5 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu10.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu10.h
@@ -136,14 +136,12 @@
 #define FEATURE_CORE_CSTATES_MASK     (1 << FEATURE_CORE_CSTATES_BIT)

 /* Workload bits */
-#define WORKLOAD_DEFAULT_BIT              0
-#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
-#define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
-#define WORKLOAD_PPLIB_VIDEO_BIT          3
-#define WORKLOAD_PPLIB_VR_BIT             4
-#define WORKLOAD_PPLIB_COMPUTE_BIT        5
-#define WORKLOAD_PPLIB_CUSTOM_BIT         6
-#define WORKLOAD_PPLIB_COUNT              7
+#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
+#define WORKLOAD_PPLIB_VIDEO_BIT          2
+#define WORKLOAD_PPLIB_VR_BIT             3
+#define WORKLOAD_PPLIB_COMPUTE_BIT        4
+#define WORKLOAD_PPLIB_CUSTOM_BIT         5
+#define WORKLOAD_PPLIB_COUNT              6

 typedef struct {
         /* MP1_EXT_SCRATCH0 */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 04226b1544e4..e57e64bbacdc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1298,15 +1298,9 @@ static int conv_power_profile_to_pplib_workload(int =
power_profile)
         int pplib_workload =3D 0;

         switch (power_profile) {
-       case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT:
-               pplib_workload =3D WORKLOAD_DEFAULT_BIT;
-               break;
         case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
                 pplib_workload =3D WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
                 break;
-       case PP_SMC_POWER_PROFILE_POWERSAVING:
-               pplib_workload =3D WORKLOAD_PPLIB_POWER_SAVING_BIT;
-               break;
         case PP_SMC_POWER_PROFILE_VIDEO:
                 pplib_workload =3D WORKLOAD_PPLIB_VIDEO_BIT;
                 break;
@@ -1316,6 +1310,9 @@ static int conv_power_profile_to_pplib_workload(int p=
ower_profile)
         case PP_SMC_POWER_PROFILE_COMPUTE:
                 pplib_workload =3D WORKLOAD_PPLIB_COMPUTE_BIT;
                 break;
+       case PP_SMC_POWER_PROFILE_CUSTOM:
+               pplib_workload =3D WORKLOAD_PPLIB_CUSTOM_BIT;
+               break;
         }

         return pplib_workload;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C2f57b9a4012a424d574908d89be7299b%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637430764514589029%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DOWntFjcijTjJa0Qrsi7YTvrEWQcIXM8dHsXxhOaKsng%3D&amp;reserved=3D0

--_000_MN2PR12MB4488A42C699D71E4578E42E0F7CC0MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Changfeng.Zhu &lt;changfeng=
.zhu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 8, 2020 9:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting f=
or raven</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
From: Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
When using old WORKLOAD_PPLIB setting in smu10.h, there is problem that<br>
it can't be able to switch to mak gpu clk during compute workload.<br>
It needs to update WORKLOAD_PPLIB setting to fix this issue.<br>
<br>
Change-Id: Id2160a7b4a6cb8808d100de25e999714a7ccaebd<br>
Signed-off-by: Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu10.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 ++++++--=
------<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c&nbsp;&nbsp; |&nbsp; =
9 +++------<br>
&nbsp;2 files changed, 9 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/in=
c/smu10.h<br>
index b96520528240..9e837a5014c5 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu10.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu10.h<br>
@@ -136,14 +136,12 @@<br>
&nbsp;#define FEATURE_CORE_CSTATES_MASK&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt;=
 FEATURE_CORE_CSTATES_BIT)<br>
&nbsp;<br>
&nbsp;/* Workload bits */<br>
-#define WORKLOAD_DEFAULT_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
-#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1<br>
-#define WORKLOAD_PPLIB_POWER_SAVING_BIT&nbsp;&nbsp; 2<br>
-#define WORKLOAD_PPLIB_VIDEO_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 3<br>
-#define WORKLOAD_PPLIB_VR_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
-#define WORKLOAD_PPLIB_COMPUTE_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 5<br>
-#define WORKLOAD_PPLIB_CUSTOM_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 6<br>
-#define WORKLOAD_PPLIB_COUNT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br>
+#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0<br>
+#define WORKLOAD_PPLIB_VIDEO_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 2<br>
+#define WORKLOAD_PPLIB_VR_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br>
+#define WORKLOAD_PPLIB_COMPUTE_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 4<br>
+#define WORKLOAD_PPLIB_CUSTOM_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 5<br>
+#define WORKLOAD_PPLIB_COUNT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<br>
&nbsp;<br>
&nbsp;typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MP1_EXT_SCRATCH0 */<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 04226b1544e4..e57e64bbacdc 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -1298,15 +1298,9 @@ static int conv_power_profile_to_pplib_workload(int =
power_profile)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pplib_workload =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (power_profile) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_BOOTUP_DEFA=
ULT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pplib_workload =3D WORKLOAD_DEFAULT_BIT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_=
FULLSCREEN3D:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_POWERSAVING=
:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_POWER_SAVING_BIT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_=
VIDEO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_VIDEO_BIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1316,6 +1310,9 @@ static int conv_power_profile_to_pplib_workload(int p=
ower_profile)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_=
COMPUTE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_COMPUTE_BIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_CUSTOM:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_CUSTOM_BIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pplib_workload;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C2f57b9a4012a424d574908d89be7299b%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430764514589029%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DOWntFjcijTjJa0Qrsi7YTvrEWQcIXM8dHsXxhOaKsng%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C2f57b9a4012a424d574908d89be7299b=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430764514589029%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DOWntFjcijTjJa0Qrsi7YTvrEWQcIXM8dHsXxhOaKsng%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488A42C699D71E4578E42E0F7CC0MN2PR12MB4488namp_--

--===============1980684332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1980684332==--
