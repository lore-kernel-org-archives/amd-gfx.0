Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686CAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6E110E9C1;
	Mon, 28 Mar 2022 13:44:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F9710E9C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7Omqj1Q879vYANinZ2Nu+zmBNQF27a3Gzd/Y1Pa+XTpi3F7xjSr8A46TIlcaEMEVJ/prVQZp+9HkDU/8DU/A3zpXYSSVNB2+3TkFkebViL5bStptoBGpH0PH6tdIIQIM54RxqfmF6uKxLGOObEwOe0DEK8yrxVMVvCLGnL2I/mUiLHWuMCf1QljtZJ/dM0QuF5b8s/4SexQZnaCdQQ1hr3aozBFtd3xIiE6Fh+LYD1OokrUkVwNNEM+47Acqo9YCZJ5mbwh6k6U/85DXPAd5nBfA++9wyG4HNEAbDrWdEGg/9lCENI1a9RwmB58JTRnXdJ60M6gMGaLl3HfAegarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRwvR3saTrBM4UCwDQ0vdBmVBxnHAvkZyQibcBat3oQ=;
 b=lrNi2lPd4HYWgfDcjKeg+vh9LPgNDxQAvLq19uu/6OdeBV/wzRjY23XQZacXw32HNyX20bjVal+hTW1sABqNzSRcWFjTDR7EovZnV3/karnwZizDFrfqMosTm5cNWkKOI5XB5AQCVrN//TYZfFch1vS3m9wfDnGHUCjAsk0t21qRL8Hid4p6PU2f+8Xsnh0Rf8d/tKyWQKy2TVwR6XqtT008NdIj+AS2xp3tJZItOVryjxT+XhWmEuv3H9A0X5LkXFXwHYwO0twKEz8NbW3yia9THvAQagxbbo4jtf/YyHv3hTb5396F1CHBDULKGtc9dRV6Jx+8aOtPvv552G8ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRwvR3saTrBM4UCwDQ0vdBmVBxnHAvkZyQibcBat3oQ=;
 b=Zwf4OlJJEVxeOSY7fUzq0gxLvB3/zQlpKo6HspxqQaDZdY0x3DXIPvogQADo7ytB1w57zhhd9d1mDA2fIfUCMC8OSEufTyRibGCSWxYP8QMBYWS1CF83AmgT99ieaxFpvaNtZRMd+t7/v8kMbJEEM0Ev0Dsy8xOmJUakGUc77AE=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN2PR12MB3678.namprd12.prod.outlook.com (2603:10b6:208:158::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:44:51 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::3837:2bf1:d487:9faa]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::3837:2bf1:d487:9faa%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:44:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Change unique_id to use IP_VERSION
Thread-Topic: [PATCH 1/2] drm/amdgpu: Change unique_id to use IP_VERSION
Thread-Index: AQHYQqS7zd2Y7Foc70KWBUNgvHnyuqzUzp5g
Date: Mon, 28 Mar 2022 13:44:51 +0000
Message-ID: <BN9PR12MB5146F1EC67BC900EF55C6941F71D9@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20220328130646.1226563-1-kent.russell@amd.com>
In-Reply-To: <20220328130646.1226563-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-28T13:44:50.740Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 3199e1e1-a824-751e-5655-1ebdb474c83e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dcf4c6e-7e0e-42df-aa99-08da10c12239
x-ms-traffictypediagnostic: MN2PR12MB3678:EE_
x-microsoft-antispam-prvs: <MN2PR12MB367847070B7111857329EAC3F71D9@MN2PR12MB3678.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIfoZ1AReGrM5yhhDFztKLf9GqOHRtPDRnOKUCqLKkc/3vjr8AqcS9a7FiXRdtonUIS3RvY6aS+DV8O+0R8NpRiBTsTtH2bGxZp3JdmFxy8yJNXETxfRtG7Pga24Eh5FuUVFXZl+VmUTeBWGb3QfOLLVcDSHC8kmfucMJsvIavO+eiHsxflzmD9BFI7FnEuCbCsBPhbAjrSYtskyXtHTp4IS2MEte7fFiF/3WXvAhU1gr3SUb2L6bpfDZyiJyRQJhsKZznaip8ChjZCj1BN53jFpum5R9dwlGIm00vnpAhzqsh/liXhATDrCWnpTLquK84bwX0iKrRLAWygkM+Xq9QbnxZuBoWFghkqyqYwiNv/oZVLQPwzHMTRncay/MS4DeJP3ctA1Pxf7u2zWHd0hL+H2XKePQ4R6qTRhU/tw7Dc899qEeS3O5Upks86JBDScsS4+LRlPMrMBl+YGUbjmLI7qJIVsjKT5DuGpzcYtpTguCuiIm4R+Ewn0y1GBI4biAe4a7B4yMU6bt5Vl81qqtVQMVLrkLc8mkx5c+PTF5+te5zi1JGe5cCMW2qrvDJZcKgfhOawWenw8sKmRXAjLmskKWlzacStE7kkJzhe6D9lcox0SXa/eKWw/oIajMxMmi5F6K50UtOeNjCbXvWRI6uvTcxBHFu6Hix95YzJdAQ6SUAPxgWQWKsu1ABmIUe/nRz9V0YWBH8/kbrbZ1d9ZLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(55016003)(71200400001)(8676002)(186003)(5660300002)(508600001)(64756008)(66476007)(91956017)(66946007)(76116006)(19627405001)(316002)(66446008)(66556008)(26005)(83380400001)(2906002)(8936002)(9686003)(86362001)(6506007)(38070700005)(52536014)(53546011)(7696005)(122000001)(38100700002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?11pciCl73MXqVpge9oXaLDiKD9LBSTWS8RFC7LpkKpwkbOhdA+Q3uFZpF9Hy?=
 =?us-ascii?Q?Y5vUQ4d1qIKVSoINzTDoHtgglI9MO8Xlx1r82a+Ajl4sx6hv0rlXFrxxItor?=
 =?us-ascii?Q?elHpxR3hpylw8dnpmHeWbTNEF+oZJEysh+z6ZZXzvFlZrpl0go9qY8oVNugv?=
 =?us-ascii?Q?l0KSk7GdMYJ94Yk6L0hsxCQff0XQ8iZh5SwssnKwKKb7bX13nlqFBxv9KppL?=
 =?us-ascii?Q?2WNFI8RspH8ZsgHhtxpQ1NSc3yx8a/tExkr5TklT7nbsr2iLhmJWFbS9pAly?=
 =?us-ascii?Q?cRYTnX3WZ+AIC/mxisDGAfugHJtGCNC1t1+SUSLYgZWAU0y2LjhVfjtzna74?=
 =?us-ascii?Q?H/rsdq3tfMkd4DvOsrbudPBnD9cKh2lNS/vm8Z366hgRqtuU2JroqiK8bX6X?=
 =?us-ascii?Q?tT6ElkFYvbpIKQSwmmZ+hDs6pBRABLcU3VJ/HEkDPVL+WGTvuOLK1U6ig4F3?=
 =?us-ascii?Q?fuPeCG3ANxFEq2pZTJKw4JX2qZwNnuWlaYHvaBUy4qqgfBtxJgvSnynL2BN8?=
 =?us-ascii?Q?GNm/njFh1r/0fMfRiidy4fW7StDyUyGzC0qd5YrbJuHs10uYTTBJOAmscP1G?=
 =?us-ascii?Q?K370+PUqpnfTItWpUoMWenaokoJUQBDAHI8UKgU3D0QeynwlK0CzzXOPxdTZ?=
 =?us-ascii?Q?fCYa4cMA3KvJVCSSodjfcLUSNDJxv8EOXbveeKPFb2Al3okIMNamu29DXoaV?=
 =?us-ascii?Q?FpWq12jjX01rfq/88EU8EBbEkwful2CwjlFkba5LB5n6iV4d6m1o3Sueb8Wl?=
 =?us-ascii?Q?B/1omk2OFbTRNZH0nrDh2bFDBQdPH+YGZILSHGhTN7RdaJzRt2/eOsqcAkty?=
 =?us-ascii?Q?sRCP1TlN/Kg0qG5St5zlPybcvfc5mj8lGuCCt1aq+8g60FBSH+AiDuYGHW15?=
 =?us-ascii?Q?tUgRSUco7iFwwN888BMGsvNm4ENKCUtKG9F5jyYmfQpfzEj2S0Hd/S2kTr9S?=
 =?us-ascii?Q?SOR6yaXzPtfw9QwUJnxaNKvbJX88Dia5v+Dv+UmGOHn0YdLbEIXEyd9vICr1?=
 =?us-ascii?Q?WlwK4RXbqiREdlB8YjHObv5Rj9dcl9yXM6ATAxZaRv4NWodCzP32D/L+y02D?=
 =?us-ascii?Q?8ObXYJMMA5WacNiW5UwH7jRBPHPqQvF4kN1/CWOXwPsjRZYoC0mzd+LoZtLr?=
 =?us-ascii?Q?yuK3UHV1lvFe4j8tB58xcLvkG9+8ompTXgECk6HGGMtHIxy5tYVuN4xXTEXg?=
 =?us-ascii?Q?fyJQVoveQT4Dr9cC8GiiWTkc6KtNHVVPAFgss1/uMy5Q2cI6FDu5klQWFp8b?=
 =?us-ascii?Q?+IPIGohgeeArZ5uVwuGaUXo1PKvLFN3vGXnwq5RAs09p5PGyzWOYCREX9hfv?=
 =?us-ascii?Q?IRTBQnQbfbcoh1CJCSMqPdLtxYEnwst+GrCb0AZOZppxGwkz+kgJnovzQEi/?=
 =?us-ascii?Q?Vo/4sJlyn+BaMCzmhJtj2I4H2NwEq3zeoAUq6p3r2rXld7LZASOr1T5Kdpun?=
 =?us-ascii?Q?S/4jNvqas3rhiG+IzI9lKE3LCTJmXbCEE6kjpjLqpz7BfqA06GYq5P8rOKSr?=
 =?us-ascii?Q?ihmQEt0TH92BXMHxWeHqXZw0EpuYBUfA3SO8habOFP29cclDS6mvL9hzS0Uq?=
 =?us-ascii?Q?mc3AFdLv5/ZVItiIyR9BZNcaeVtYXtt+MeqehOX+hB32h3eDzefWM2MYHyUF?=
 =?us-ascii?Q?2afNkM2pnIwlq31p45ZSEXepy4XDZ1YEqaTFWjOEnhEPcN4VrBeFRecDtQH1?=
 =?us-ascii?Q?+oadt/GauEWtwrghOZEnGbjrFior9IesaovNlNlT24E0kVXn?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5146F1EC67BC900EF55C6941F71D9BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcf4c6e-7e0e-42df-aa99-08da10c12239
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:44:51.3408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6dHYiuW+nisGqfJ1OGkNbHt67CWnZkrphvM02oPevJoNhdO1KeofLQzdZ49ZHQ9XVnlrQYt8CHKxikW+GSY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3678
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

--_000_BN9PR12MB5146F1EC67BC900EF55C6941F71D9BN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Monday, March 28, 2022 9:06 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Change unique_id to use IP_VERSION

This is transitioning throughout amdgpu, so we may as well get it
started now. This also cleans up the logic on what IP_VERSIONs do or
don't support unique_id.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5cd67ddf8495..a5216c0f5c2b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1987,11 +1987,15 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
                 if (adev->flags & AMD_IS_APU)
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(unique_id)) {
-               if (asic_type !=3D CHIP_VEGA10 &&
-                   asic_type !=3D CHIP_VEGA20 &&
-                   asic_type !=3D CHIP_ARCTURUS &&
-                   asic_type !=3D CHIP_ALDEBARAN)
+               switch (adev->ip_versions[GC_HWIP][0]) {
+               case IP_VERSION(9, 0, 1):
+               case IP_VERSION(9, 4, 0):
+               case IP_VERSION(9, 4, 1):
+               case IP_VERSION(9, 4, 2):
+                       *states =3D ATTR_STATE_SUPPORTED;
+               default:
                         *states =3D ATTR_STATE_UNSUPPORTED;
+               }
         } else if (DEVICE_ATTR_IS(pp_features)) {
                 if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
                         *states =3D ATTR_STATE_UNSUPPORTED;
--
2.25.1


--_000_BN9PR12MB5146F1EC67BC900EF55C6941F71D9BN9PR12MB5146namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Monday, March 28, 2022 9:06 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Change unique_id to use IP_VERSION<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is transitioning throughout amdgpu, so we may=
 as well get it<br>
started now. This also cleans up the logic on what IP_VERSIONs do or<br>
don't support unique_id.<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 ++++++++----<br>
&nbsp;1 file changed, 8 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 5cd67ddf8495..a5216c0f5c2b 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -1987,11 +1987,15 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
unique_id)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type !=3D CHIP_VEGA10 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type !=3D CHIP_VEGA20 &amp;&amp;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type !=3D CHIP_ARCTURUS &amp;&amp;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type !=3D CHIP_ALDEBARAN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(9, 0, 1):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(9, 4, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(9, 4, 1):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR=
_STATE_SUPPORTED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_features)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU || asic_type &lt;=
 CHIP_VEGA10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5146F1EC67BC900EF55C6941F71D9BN9PR12MB5146namp_--
