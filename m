Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB26C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 14:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7242073E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 14:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qb6RfmWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7242073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D741E6E07D;
	Tue,  7 Jul 2020 14:34:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690080.outbound.protection.outlook.com [40.107.69.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041996E07D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 14:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbuHW2XVt9Jgkqn6+SkDMkrux8gQS7oEu8d+z/HXImv2ItuW0Zx2VW4ZEdDGXjBKyNaDwcqcpatIO3artEEZgJpxz/3WBdfESC7XeX9tZFb2DbXKmjhazqLXyRVzYWH9MelJWEbH23YjBITcvnaV808zDsEdSmLbe6eMZYsQkjrPNto6JvJnGipgiZTUQ59ZpSW56l+NhmxG86dkRho7MmEfoXzd1DWc1I8/QGtbxQJ82hh5FqL3BesYh7Yd7pMwLUNsT6TZORFUarssvWaasD9DYReWkqwgYcOYctYiEQrJ2R38XWLrQH8dhb8COIzqvLR+qsU/hEnfWDdneNRceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS7nfNBMeI2gOfpDQxTUN4mNsLko9dfAqojW30POlTA=;
 b=CZiInzb1A5oxb92bVQEBUnCtle7IlYOEYxckSpv8wNrm2vAUFoGc23JEGrYJPvXK9R0jQcH5OeG7WODnOjuhg8wNPgWp3UINcqIvgzboSwNRBfyX/VwK5pR3jn6FAM/kY4X6VcQLf8SSz6bqYmqj+bSjlWNhOSWCNiB9tuJ2boV0sfF1A2RYUg178eklD35QCAeqMAfnBK0h4fecNKRlm094ERd6Eom2mPG6DyRqR1BrI2gBxCbf3RuxtXn5GzL9U5/TU7l467tAN9+SINBdYgQhaCXd+sUWCD+Ict66aSYorZGCwe65FstiVeXXgUQq9YkYR1AYO0LbRXO/jfa63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS7nfNBMeI2gOfpDQxTUN4mNsLko9dfAqojW30POlTA=;
 b=Qb6RfmWYnA2JojSD9qZlB494fD2pqEKM1XEylExBndQCVhx6RplJJFPrhJG76+FHHqCnDfDhOihN0+LlYY9bjQRlYm6pUcAEcoE4uTquGMK6J6LtaVUbzhsZHY48JXJYPjt0SLLzOeWnodFA9/mWaHU+9RLNdxRvc9IiOP5/f40=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Tue, 7 Jul
 2020 14:34:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 14:34:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state
Thread-Topic: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state
Thread-Index: AQHWU8n5eWofJz4pEEKwO+l25d2P8qj7VTyAgADahNY=
Date: Tue, 7 Jul 2020 14:34:33 +0000
Message-ID: <MN2PR12MB4488D3E9B2BC91713762A344F7660@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200706191629.564683-1-alexander.deucher@amd.com>,
 <DM6PR12MB261991937DD86B08A1C0F277E4660@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261991937DD86B08A1C0F277E4660@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-07T14:34:33.207Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.187.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 126555a4-523b-48e2-3b3e-08d82282ddf3
x-ms-traffictypediagnostic: MN2PR12MB4064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40649D89630D696BBEA56260F7660@MN2PR12MB4064.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O49yG7NfanaeKoz9aeWrfzcdllrR9DYMpQwnf42LBLmbvR8VyzAcGneICgYyiuH6SuzsClO6f08J/bkn8gkkKN41S+WwC57H5VI028JEfmk45qHrMhHHbOd0HBsiAFW18dddwAINEIMWogPn44UJHe7Vq8xlcYMDHEASYMw22AfnThUhi6rsFHXrnmoBUghUM6l6VkyYWR8LcaXlxZawashUVBlxhEzXhcMwzFpSs1ndTztGh9oqHikO47T8dV+h27u4o+YcxGkT530oK4C397gYpL3HFJ05F4bYnebu8ZlH7CaxRKTCU/+QIxuW4d2D8WUdyse1VglvAC2S3WToLoHJuwxmVLi+ojhrumEDGrw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(53546011)(83380400001)(76116006)(316002)(8676002)(66946007)(66446008)(66556008)(66476007)(64756008)(478600001)(71200400001)(55016002)(7696005)(45080400002)(52536014)(33656002)(5660300002)(966005)(9686003)(86362001)(26005)(19627405001)(6506007)(8936002)(110136005)(166002)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: B1YO+BSpYCEQ56wKD/4Q3WhSkF2tkX2R0U2/y0+DYyU69N25od6AIkHdVGDlpw3U5yzFMX3sJqRWmqPjjhgGzCdC7HULk+keugkEjLGRm3AlWjFcoLrpsvFi8Gsp6hSawp37fJbPr3pxqpjS8uxyeR2Pa9uppno0lfdQyJHSsLuBSadZEq9oY04MYdIgKg5K3vgtA0Rl5vI55Tido1ZtS6pwFInUIT6ysG965Y4oJ049hstNv5+uPbAFi57LLIlgtscF8ed59ZqmXeI3Q15VxM5n9QsFHVzwZR0L+lCfAwujkknrIrS4iKDrU1U29mrWQa9frNXvp+qVrAHPoGn/ITiGDRsH4qLZ1wY9Rwxwwl4hqRBJ43cWytPGJ5/Ce4VxavrzUsDkHgS57T8/9izpHqMlkTqlUkRO01jhsxfiEao02uxMHELWjgYHZE2Wi2n8GbcT8VwS6BPOyZUG98sJNdLM970Bw4hmeF7DeXoQ4XiXCiGhvfjuJwLUtx0OhNgy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126555a4-523b-48e2-3b3e-08d82282ddf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 14:34:33.6209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEzTVrvt03ojDO8CyNKJYTTW0HxNPJGE0JuUSkU7voQ6JbnwtN6ibmvYYo4iY+Dn7F3wLfkRHDaAmuaS18wF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
Content-Type: multipart/mixed; boundary="===============0050474627=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0050474627==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D3E9B2BC91713762A344F7660MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D3E9B2BC91713762A344F7660MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Ah, yes, indeed.

Thanks,

Alex
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, July 6, 2020 9:31 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 sta=
te

[AMD Official Use Only - Internal Distribution Only]

I think you may wrongly treated the "pm_enabled" as "dpm_enabled".
pm_enabled should be always true unless user specifies "dpm=3D0" on module =
loading.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, July 7, 2020 3:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state

We need to set the mp1 state in PCI shutdown and certain reset cases which =
happens after we've already suspended the SMU.  SMU suspend sets pm_enabled=
 to false which prevents this code from being run.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index fe4948aa662f..0ed75a9897eb 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1924,9 +1924,6 @@ int smu_set_mp1_state(struct smu_context *smu,
 uint16_t msg;
 int ret;

-if (!smu->pm_enabled)
-return -EOPNOTSUPP;
-
 mutex_lock(&smu->mutex);

 switch (mp1_state) {
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cevan.qua=
n%40amd.com%7C833334723b854666ac1f08d821e11cf8%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637296598083021484&amp;sdata=3DbD1UlSdYqXuPoDoTCvGZHRJr2F6=
DoJu2LHN6v5p4%2FoA%3D&amp;reserved=3D0

--_000_MN2PR12MB4488D3E9B2BC91713762A344F7660MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ah, yes, indeed.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, July 6, 2020 9:31 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set =
mp1 state</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - Internal Distribution Only]<br>
<br>
I think you may wrongly treated the &quot;pm_enabled&quot; as &quot;dpm_ena=
bled&quot;.<br>
pm_enabled should be always true unless user specifies &quot;dpm=3D0&quot; =
on module loading.<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Tuesday, July 7, 2020 3:16 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu/swSMU: drop pm_enabled check in set mp1 state<b=
r>
<br>
We need to set the mp1 state in PCI shutdown and certain reset cases which =
happens after we've already suspended the SMU.&nbsp; SMU suspend sets pm_en=
abled to false which prevents this code from being run.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index fe4948aa662f..0ed75a9897eb 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1924,9 &#43;1924,6 @@ int smu_set_mp1_state(struct smu_context *smu,<br=
>
&nbsp;uint16_t msg;<br>
&nbsp;int ret;<br>
<br>
-if (!smu-&gt;pm_enabled)<br>
-return -EOPNOTSUPP;<br>
-<br>
&nbsp;mutex_lock(&amp;smu-&gt;mutex);<br>
<br>
&nbsp;switch (mp1_state) {<br>
--<br>
2.25.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cevan.quan%40amd.com%7C833334723b854666ac1f08d821e11cf8%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637296598083021484&amp;amp;sdata=3DbD1UlSdY=
qXuPoDoTCvGZHRJr2F6DoJu2LHN6v5p4%2FoA%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cevan.quan%40amd.=
com%7C833334723b854666ac1f08d821e11cf8%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637296598083021484&amp;amp;sdata=3DbD1UlSdYqXuPoDoTCvGZHRJr2F6DoJu=
2LHN6v5p4%2FoA%3D&amp;amp;reserved=3D0</a><br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D3E9B2BC91713762A344F7660MN2PR12MB4488namp_--

--===============0050474627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0050474627==--
