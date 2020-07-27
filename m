Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC448C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 04:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8631720714
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 04:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XtYlUnfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8631720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378C889971;
	Mon, 27 Jul 2020 04:55:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4287989971
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 04:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9UuyGC/ugyFEntyIfTlNBZr5FY5VWvo4FIhw8NUTHy4iITh08OuWN+QJC6PLcwc1bA1Nj6AlyVzO+mGYYam+fL3RisLIiNvwAA6TJSnEBX9wUOQTlto0u7HyUYb0g5zHppIrszTXDIYr8v7PjNgp3h5U0U7z1+closQt1RWsFKKT+Jll7YEZ7VBmyuyYOTBO9ZQe25GBjxCCqP4mrcLouJNMwKHgx6b5Tn4RoOJMXiQ/UDGfuoRtZZF1Ri5kRkDcYAyz2pm1V/XUlgpAcLFGa71gSpCU9+Svy30rYjBFQqJJu6IlE024xwgMQAV7I7IvC25fGxQJRj8FlF/osbfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND7+ZgxRYxfs/gJSAXZr9PPaMIr229zYIJOmQ3m3GZs=;
 b=GMX3hca+9SJ3gLPgJsBM7zHzGHvVy7v7ITCpygNWuxgYZCNzjvbaILogZv/a7yz+Op+LHcEtlnTVTY91IhrX7FpkQa8jPnEWpqolr11+p7opCODWUZPIeAEaOkWry/kRtqcT2YnquWhMi4RuNk8AFb80JmEYc+yk3CSWkR0aTBhBdzd4M2c0/pmLK0L+e5qxWnMCfULqsdUFSqlHKoBqATETjImTr37nlbTyP8vOrSuGRR6eSj/mabp6DnnKY+1qwN81qRwhLfUnUz3yPZtlUIsGAezq9EizDLLTeWgK+ZROEU5vKrInx666OXe0YUkEmX0t8utaW0hcMYTzEvWAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND7+ZgxRYxfs/gJSAXZr9PPaMIr229zYIJOmQ3m3GZs=;
 b=XtYlUnfvm5dbaa2wLMrdYnGYL3ovROKjaHN+cIVR3gy5ujl8fLkCBsIeSa6tGsUo/KrI10YYjqqm6GmsxQi3oi9WFuV6VSI6gIl9otv56GKv0P3KDNbdjexJr6vsGalPwxdJIyHF+l6ykyxrSSdc1pqEXY398tw59ZEio14h8MM=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3134.namprd12.prod.outlook.com (2603:10b6:208:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Mon, 27 Jul
 2020 04:55:21 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 04:55:20 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on
 smu_read_sensor()
Thread-Topic: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on
 smu_read_sensor()
Thread-Index: AQHWY8KjpDk9TOfSVE6Xlhk+KjlRi6kazZaAgAALW54=
Date: Mon, 27 Jul 2020 04:55:20 +0000
Message-ID: <MN2PR12MB3022E8354FB9E74FF37638FBA2720@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200727030528.586004-1-kevin1.wang@amd.com>
 <20200727030528.586004-2-kevin1.wang@amd.com>,
 <DM6PR12MB261904CA92DCEA4DD037F055E4720@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261904CA92DCEA4DD037F055E4720@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-27T04:56:39.930Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e35b2989-8b62-424f-20b6-08d831e943ed
x-ms-traffictypediagnostic: MN2PR12MB3134:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31346A208DCE992F971CD2EEA2720@MN2PR12MB3134.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epUCepVqCniE2ruwbX3T3enhCbLMxpIFro6eynyamMuZlAyaJoE2uHVpSOs74ev/mLp7BGoq6kFi14KYfp7tat0stKXqThE29PQZj4412L7Zl/0UkIAwGFzzWnyDCzt1xDwoEk7nln+VIod5o+5F0Dfs1NPuj/JosEA9Edd4qcENSBuYNwyfZ/jAuDug78KnoV/fHSBxE4BJYYHX6XiHRXDK2qfc7jcTZv3mwpZi1qG07taGnfUjFdf+e1Q+zTyPbocYEZ4cWlUgfI4JNK5wosUxJSq1mOjwm5T9i1sAeSnG373sCwfCX6InXkpDvEpc24shs0X98FAZGXVjfSLsI70buDzSaNlGH3UR3Zamh7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(7696005)(86362001)(5660300002)(52536014)(2906002)(83380400001)(26005)(8676002)(45080400002)(186003)(6506007)(53546011)(8936002)(966005)(478600001)(71200400001)(91956017)(166002)(76116006)(9686003)(66446008)(64756008)(66556008)(66476007)(316002)(110136005)(66946007)(4326008)(33656002)(19627405001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kBV8y5vMwFpPOo7pkgCRSHcnWYo//FKYsI7NLPnP4p8O8NT9lx7Y/VTdJ2uTjVS8mMsHO4FeIxC5+sP8tA92nNz3ZGulvSiLUK81p+znIN53VrCrYXw5j31WFGs2kQ2TdCyIdYPXnc62LBLVOV2pKMxsMXHFCnGz+lr7QkoTrl86r8Tm1zHyvxH9sIkFZg3kzNBZqVoIq5QaKgUIfWcX/X6J8RKvf4dsyZYze6SRsjZUqJrTv2jctfPBovxqTYQPV7V37XLBIXGYUrBGuDUyVpYkz+hQ3C9YwwCNTIGhR9Hmj216qC4snCrPWMFqksnXKrVXh4BEh1wlHPdBsK0jvTyJ7rmTcBFaeROYtMPUCaY/7WWojm+DQbSZFH+3va2hlMp7GIs3ixG5v9m2Fn8idshGryvVqhFw2LWmYvydXA4GdXnO6zPbq68leAx6cgMAhv0dPgrRnzxCB552TGdUafVCX4722R74UGF/OKrGUHRARVGgvhIvxuuZ9y/O1lWg
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35b2989-8b62-424f-20b6-08d831e943ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 04:55:20.8540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPyCoKuz78WjHFBRlnwrtHdo4qZKdUTZksUECI2R5D4H1EB1nYpFGtZVxTq9duFz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1099576083=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1099576083==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022E8354FB9E74FF37638FBA2720MN2PR12MB3022namp_"

--_000_MN2PR12MB3022E8354FB9E74FF37638FBA2720MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

yes, i know what you want to say.
the "smu->mutex" as a global lock in smu driver, and it seems that the lock=
 grain size is a little big.
and it's better to rename it, eg: smu->api_lock, ...

Best Regards,
Kevin
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, July 27, 2020 12:01 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: RE: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on smu_read_s=
ensor()

[AMD Official Use Only - Internal Distribution Only]

It's OK to drop sensor_lock. But please keep smu->mutex in smu_read_sensor.
All top APIs from amdgpu_smu.c come with smu->mutex to avoid potential race=
 issue.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wa=
ng
Sent: Monday, July 27, 2020 11:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on smu_read_senso=
r()

instead "mutex" with "sensor_lock" on smu_read_sensor().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 4 ++--
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 --
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 --
 5 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 55463e7a11e2..69d7f7de9adf 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1946,7 +1946,7 @@ int smu_read_sensor(struct smu_context *smu,
 if (!data || !size)
 return -EINVAL;

-mutex_lock(&smu->mutex);
+mutex_lock(&smu->sensor_lock);

 if (smu->ppt_funcs->read_sensor)
 if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size)) @@ -1988,7 +198=
8,7 @@ int smu_read_sensor(struct smu_context *smu,
 }

 unlock:
-mutex_unlock(&smu->mutex);
+mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index f13979687b9e..5e56509a8f54 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1066,7 +1066,6 @@ static int arcturus_read_sensor(struct smu_context *s=
mu,
 if (!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 *(uint32_t *)data =3D pptable->FanMaximumRpm; @@ -1109,7 +1108,6 @@ static=
 int arcturus_read_sensor(struct smu_context *smu,
 ret =3D -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 6aaf483858a0..ece0f2a37704 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1710,7 +1710,6 @@ static int navi10_read_sensor(struct smu_context *smu=
,
 if(!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 *(uint32_t *)data =3D pptable->FanMaximumRpm; @@ -1749,7 +1748,6 @@ static=
 int navi10_read_sensor(struct smu_context *smu,
 ret =3D -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 575ae4be98a2..3f4de2c30bfc 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -950,7 +950,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 if (!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_GPU_LOAD:
 ret =3D renoir_get_current_activity_percent(smu, sensor, (uint32_t *)data)=
; @@ -974,7 +973,6 @@ static int renoir_read_sensor(struct smu_context *smu=
,
 ret =3D -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dcc5d25a7894..d4e52866e04f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1521,7 +1521,6 @@ static int sienna_cichlid_read_sensor(struct smu_cont=
ext *smu,
 if(!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 *(uint32_t *)data =3D pptable->FanMaximumRpm; @@ -1560,7 +1559,6 @@ static=
 int sienna_cichlid_read_sensor(struct smu_context *smu,
 ret =3D -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cevan.qua=
n%40amd.com%7C59903ad7916e46d3996908d831d9c8fc%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637314158764254291&amp;sdata=3D4oXm1j7KHefIx73tvURU627HeY8=
FNw0N5IjBRfzEmFQ%3D&amp;reserved=3D0

--_000_MN2PR12MB3022E8354FB9E74FF37638FBA2720MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes, i know what you want to say.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">the &quot;smu-&gt;mutex&quot; as a global lo=
ck in smu driver, and i</span><span style=3D"color: rgb(0, 0, 0); font-fami=
ly: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">t
 seems that the lock grain size is a little big.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
and it's better to rename it, eg: smu-&gt;api_lock, ...</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, July 27, 2020 12:01 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Feng, Kenneth &lt=
;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on smu=
_read_sensor()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt">[AMD Official Use Only=
 - Internal Distribution Only]<br>
<br>
It's OK to drop sensor_lock. But please keep smu-&gt;mutex in smu_read_sens=
or.<br>
All top APIs from amdgpu_smu.c come with smu-&gt;mutex to avoid potential r=
ace issue.<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ke=
vin Wang<br>
Sent: Monday, July 27, 2020 11:05 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Feng, Kenneth &lt;Kennet=
h.Feng@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on smu_read_senso=
r()<br>
<br>
instead &quot;mutex&quot; with &quot;sensor_lock&quot; on smu_read_sensor()=
.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 --<br>
&nbsp;5 files changed, 2 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 55463e7a11e2..69d7f7de9adf 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1946,7 +1946,7 @@ int smu_read_sensor(struct smu_context *smu,<br>
&nbsp;if (!data || !size)<br>
&nbsp;return -EINVAL;<br>
<br>
-mutex_lock(&amp;smu-&gt;mutex);<br>
+mutex_lock(&amp;smu-&gt;sensor_lock);<br>
<br>
&nbsp;if (smu-&gt;ppt_funcs-&gt;read_sensor)<br>
&nbsp;if (!smu-&gt;ppt_funcs-&gt;read_sensor(smu, sensor, data, size)) @@ -=
1988,7 +1988,7 @@ int smu_read_sensor(struct smu_context *smu,<br>
&nbsp;}<br>
<br>
&nbsp;unlock:<br>
-mutex_unlock(&amp;smu-&gt;mutex);<br>
+mutex_unlock(&amp;smu-&gt;sensor_lock);<br>
<br>
&nbsp;return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index f13979687b9e..5e56509a8f54 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -1066,7 +1066,6 @@ static int arcturus_read_sensor(struct smu_context *s=
mu,<br>
&nbsp;if (!data || !size)<br>
&nbsp;return -EINVAL;<br>
<br>
-mutex_lock(&amp;smu-&gt;sensor_lock);<br>
&nbsp;switch (sensor) {<br>
&nbsp;case AMDGPU_PP_SENSOR_MAX_FAN_RPM:<br>
&nbsp;*(uint32_t *)data =3D pptable-&gt;FanMaximumRpm; @@ -1109,7 +1108,6 @=
@ static int arcturus_read_sensor(struct smu_context *smu,<br>
&nbsp;ret =3D -EOPNOTSUPP;<br>
&nbsp;break;<br>
&nbsp;}<br>
-mutex_unlock(&amp;smu-&gt;sensor_lock);<br>
<br>
&nbsp;return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 6aaf483858a0..ece0f2a37704 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -1710,7 +1710,6 @@ static int navi10_read_sensor(struct smu_context *smu=
,<br>
&nbsp;if(!data || !size)<br>
&nbsp;return -EINVAL;<br>
<br>
-mutex_lock(&amp;smu-&gt;sensor_lock);<br>
&nbsp;switch (sensor) {<br>
&nbsp;case AMDGPU_PP_SENSOR_MAX_FAN_RPM:<br>
&nbsp;*(uint32_t *)data =3D pptable-&gt;FanMaximumRpm; @@ -1749,7 +1748,6 @=
@ static int navi10_read_sensor(struct smu_context *smu,<br>
&nbsp;ret =3D -EOPNOTSUPP;<br>
&nbsp;break;<br>
&nbsp;}<br>
-mutex_unlock(&amp;smu-&gt;sensor_lock);<br>
<br>
&nbsp;return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 575ae4be98a2..3f4de2c30bfc 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -950,7 +950,6 @@ static int renoir_read_sensor(struct smu_context *smu,<=
br>
&nbsp;if (!data || !size)<br>
&nbsp;return -EINVAL;<br>
<br>
-mutex_lock(&amp;smu-&gt;sensor_lock);<br>
&nbsp;switch (sensor) {<br>
&nbsp;case AMDGPU_PP_SENSOR_GPU_LOAD:<br>
&nbsp;ret =3D renoir_get_current_activity_percent(smu, sensor, (uint32_t *)=
data); @@ -974,7 +973,6 @@ static int renoir_read_sensor(struct smu_context=
 *smu,<br>
&nbsp;ret =3D -EOPNOTSUPP;<br>
&nbsp;break;<br>
&nbsp;}<br>
-mutex_unlock(&amp;smu-&gt;sensor_lock);<br>
<br>
&nbsp;return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
index dcc5d25a7894..d4e52866e04f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
@@ -1521,7 +1521,6 @@ static int sienna_cichlid_read_sensor(struct smu_cont=
ext *smu,<br>
&nbsp;if(!data || !size)<br>
&nbsp;return -EINVAL;<br>
<br>
-mutex_lock(&amp;smu-&gt;sensor_lock);<br>
&nbsp;switch (sensor) {<br>
&nbsp;case AMDGPU_PP_SENSOR_MAX_FAN_RPM:<br>
&nbsp;*(uint32_t *)data =3D pptable-&gt;FanMaximumRpm; @@ -1560,7 +1559,6 @=
@ static int sienna_cichlid_read_sensor(struct smu_context *smu,<br>
&nbsp;ret =3D -EOPNOTSUPP;<br>
&nbsp;break;<br>
&nbsp;}<br>
-mutex_unlock(&amp;smu-&gt;sensor_lock);<br>
<br>
&nbsp;return ret;<br>
&nbsp;}<br>
--<br>
2.27.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cevan.quan%40amd.com%7C59903ad7916e46d3996908d831d9c8fc%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637314158764254291&amp;amp;sdata=3D4oXm1j7K=
HefIx73tvURU627HeY8FNw0N5IjBRfzEmFQ%3D&amp;amp;reserved=3D0">https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org=
%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cevan.quan%40amd.co=
m%7C59903ad7916e46d3996908d831d9c8fc%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637314158764254291&amp;amp;sdata=3D4oXm1j7KHefIx73tvURU627HeY8FNw0N5=
IjBRfzEmFQ%3D&amp;amp;reserved=3D0</a><br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022E8354FB9E74FF37638FBA2720MN2PR12MB3022namp_--

--===============1099576083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1099576083==--
