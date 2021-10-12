Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB36C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 03:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190C960F43
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 03:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 190C960F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468C389D2E;
	Tue, 12 Oct 2021 03:31:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F048F89D2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 03:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvfSOJ2JUo5EouDgd3CR4vKBI4yYftvSheBt+EY2O6yqCoJxIRpVmPtVmbZUcnSzUf9n5jIMe3rjHH/S0eVYZ/G4mTdR7U5FDvCsLcI5V8ws+Zz+k2wV7c73NDiFL1q99FOYr2dVSEy5/gOHiDsVi4MYk+5EVIzSvOmrct3KDkl148PFxqQTVUP7C3wpE0aDBbdz66KtrEPi0mYTeaJY7Z0NYc0m6v3UF1bmmgLq1Jn0hF7u2uB0J2xDt5thYfJIEX5rdUOpc0TPJmoNYG9aAyPFz0XEWMVQ9xkRPy3Fn/jaZYxPi7zKzufnygjd3McJIg0b/j3fEsDF2UkpHpmrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsVmjUkvSnM7e7Qh1GKsDOs8y8XORw6NdnH3905kRwU=;
 b=YBvpsRq+uUB5McxAXdBNGphErw1YOSugnzsK4cq5E/pPVKuoVwzhj7ECnwbTMg/+U4yTLZ7e5bBQDEYE/nNlV8MK0xs8lIOdJQuU0SUys2xMX/LzchMUpVRZkjfhLsurBt7Y6RrhGAP10HKtHlDSFAQZ1FmkoP2ZnoOw8Ypd5+bgemPjimP4mjslUV2SGmE7AszNzmjYgIn7J8ZqTzT1PXMsOLibml8YdYbSJOVACgLE5f/ha+YMepPoRJIFIeixq6MQst/tZ/9Ym4WLRP+OajmiipjKG2RbKVZfJ9F8HjpJAiJbISeAmrTa2Ikf1SxY8ksH+ySWL244tPqc6Ojrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsVmjUkvSnM7e7Qh1GKsDOs8y8XORw6NdnH3905kRwU=;
 b=pb/P/VmfaY/Swe7m8aQzCtE8JrtyNe3xtKNHqc59+a2N5yybV/8os9yQnWNDwq1Lf9nTW+R9bDY2ZKRgJzFOLTiSdXjwVUsmmI3s7o5DJ2BYv1BpMQBZRlFtrQNE6XjyB23ZnFn0UBBxOWek+J2eklJ9ZqHONR8Y/kIpW6+CNPg=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 03:31:12 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 03:31:12 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Clements, John" <John.Clements@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable RAS error injection after mode2
 reset on Aldebaran
Thread-Topic: [PATCH 1/2] drm/amdgpu: Enable RAS error injection after mode2
 reset on Aldebaran
Thread-Index: AQHXvxGbIPknKqTrXUGNbLK2ZDWJxKvOtQhN
Date: Tue, 12 Oct 2021 03:31:12 +0000
Message-ID: <DM6PR12MB4650006572BE9F0CF93BD15CB0B69@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211012023343.23935-1-mukul.joshi@amd.com>
In-Reply-To: <20211012023343.23935-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T03:31:11.807Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: b555bca0-6a46-68ab-1c4a-ec3ffe51e874
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e9a50f-da2c-41fc-226b-08d98d30bd79
x-ms-traffictypediagnostic: DM6PR12MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB410599E9807521B5710DB536B0B69@DM6PR12MB4105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USP8IDLynznhX3+6LqLyIdkX5ptTS4SilNG5HT7SK6IXuOqFjZKrLLmgWBnX0x+ytr0bbiFGhJnZXf+v3Z59dGD/yFW7kiTe7bKt984vvsN20KtVxxBDWu76nhE8DVmre1WflU3Zubzfg1HdIG6Yv/dBmv5H1c7SqyFyGWGAws1WjV0HnnL45/g8P1PloZDnPdiwCD9KlgPX0JyDHjDp7mckUnBq+g2U6MO0vnTuT4LdhG1fSU7IsNqQgPZhm0PkVgVtq1ceqndaAJNnBDVBPB8hm7zQ/+yJk1fRuyVcG7lQAmn1DLX0wen0jn7/GCYPS4lrTE0obyINqPeTgYCaAnTCEW7VZdJS2EOG5E8tmC5LAc4BIz/fSso1DrEqIIj4EuEZHZlDM5yDdETcKG96GphIeIoqNDKRAKfDtxEHfEHSsut/pHGXCaD6FU8U7JXEgKEgzFDu4v0nQHxCy2wyJujsnweGqAQrb9scula+0BCDXjTkIIntlFNO1x4Q2gCM32CLczoXWBiqYcX9t+2MYBeXBA8ijbT9Bx8UOYqdDHH8R4AX3yVBhnlvSs0XUk9ht7z5I+DOWbM/5pBAH4JTM0fwpip3r1jn9YGabyPblL9bkEGjuM7IMhGmJ+KrnVi/5AjDMMafQA9PJsGzH8JJZ+koV5x87S1LkmhaOpOvG/BKg3coBcbANcBpPOvQkizPbUE+hQlob9gqQngv4VKQLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(91956017)(38070700005)(64756008)(66446008)(66556008)(66476007)(66946007)(86362001)(71200400001)(38100700002)(122000001)(55016002)(9686003)(4326008)(5660300002)(8936002)(6506007)(26005)(33656002)(186003)(53546011)(508600001)(7696005)(110136005)(316002)(2906002)(52536014)(19627405001)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EAF96UKPj5ZBUVvUaEuxRjuj3TvzHYgPBqE0eqPTiMbt8EhVJUpc/kRxN8wN?=
 =?us-ascii?Q?kbeETE6qu62d/LiZ4DX1euQ/agKx0xvAQ7NlFVRq78gBoJqG5sOkPtPidwqf?=
 =?us-ascii?Q?6kSg12uMb8HqufxB9zUhVxukqGLI6EH78vY/g/SFlkLu2x+Xgvw3JfM2GCc4?=
 =?us-ascii?Q?i8AmDRsGPmgnHbPJQf6Sif4NdpeGVGRuTTc7ut0pqrrk6GeYxHkXoYRZnC1o?=
 =?us-ascii?Q?QaxECcYJaythFXgfP8C8xzmAgPuv6o/UOH09xgr5tTfw/UqvHZjX0TrpXm6T?=
 =?us-ascii?Q?mEemoN/NGTTKD/KPeBujgrgf7bBHH68dj7emEFzuJI5beUlNYAltHpeWbJw+?=
 =?us-ascii?Q?21yZWnQm8t+gIodvrYXwTt+e/5kPbDCDRrrnfS6AW+KdHxCD2XYgnj8Lhe61?=
 =?us-ascii?Q?UVYTx+5Mu6Pg4AKgliDusPeuXqEJz9hQz9BgjD9op6vNJG9DvN7v0IolXj98?=
 =?us-ascii?Q?IaDTBBqZCRDv71Way85Wx+smURRumNa8w7o4XYUB8NPXp/tUJfh8Vzn3oj+n?=
 =?us-ascii?Q?6mtezk//i4WIMz+ZMZozEwF3EFpRLpGbAeG03yh1EI3lSmoK3XQDT+ar98Iy?=
 =?us-ascii?Q?obbmCbfNIljtDiMclCwfe9aVSKRLBjLWZEz9PbmDZgodLxFWONzRulhLUMDP?=
 =?us-ascii?Q?+g/tuXgiaG/KQOg3nQBchXUqtGO+M/JiL+W0/vTDEu2WTPXo79sNKCM5H7SS?=
 =?us-ascii?Q?2nPYd9yg++kcZyMZ9Nf1slBrclS7tCAkIofds/CgqimatNoLDEXpmN79FcBl?=
 =?us-ascii?Q?fzFZZIrSOJ9NF+rNJEVPIG+TSo8LlflSZGK106ym/ArQ1r0POQ3WqXO7oqnh?=
 =?us-ascii?Q?j7vJnBImeK2tUxDUE/LjUfG6hbdw0gTKVMbLrGPSA+RviZDAbbqtPQgPLRa3?=
 =?us-ascii?Q?s8o4Ytq9OxVe9SBwQDr5/6dIUrbdXTRon01u1HPy5ssWPJTJHoUxcBPbQXQK?=
 =?us-ascii?Q?eo3bVirosdpyX4HGx4AB78T4o6+eWmL67zR8r3r5RJt5mjIKZTdU07h+LVE1?=
 =?us-ascii?Q?oc8ZnFmyKGWNmPWeLrSuHsIvu+vdNvMJWuhiPUUBifrjvG9d7C5RpFx6TdTi?=
 =?us-ascii?Q?g1wRSmBC952lcTJRfBXDKTLRzv80MLu1pPNAoHWA0cC2+MJL0ntJddmqxecW?=
 =?us-ascii?Q?frwlbJKs5ZiMG5PIMO6KIMcvgfAmn4t5syhSZLOQgpoewoIdr8a7UGHMixHw?=
 =?us-ascii?Q?m9YVybTIma0ypiKzUxESCaXQCo2N7hV3J5EBHGSrnxT+0n0g+XN6WU0mLzTE?=
 =?us-ascii?Q?1FrFyPAYrrkVHdbbv2ooZOoZOSUg5vZi9+pPsdIA9iSaVyPCE1KbbfgWcOtT?=
 =?us-ascii?Q?l6g=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4650006572BE9F0CF93BD15CB0B69DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e9a50f-da2c-41fc-226b-08d98d30bd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 03:31:12.5025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mJTYsuLVAettVnjNrk2nKrstAWjbsxeOYxxRSZoFBdD0aWOGj5JhHzYwV1W2Gq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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

--_000_DM6PR12MB4650006572BE9F0CF93BD15CB0B69DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Tuesday, October 12, 2021 10:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>;=
 Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable RAS error injection after mode2 res=
et on Aldebaran

Add the missing call to re-enable RAS error injections on the Aldebaran
mode2 reset code path.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 148f6c3343ab..bcfdb63b1d42 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -307,6 +307,8 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_dev=
ice *adev)
                 adev->ip_blocks[i].status.late_initialized =3D true;
         }

+       amdgpu_ras_set_error_query_ready(adev, true);
+
         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
         amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);

--
2.33.0


--_000_DM6PR12MB4650006572BE9F0CF93BD15CB0B69DM6PR12MB4650namp_
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
<span style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:=
white">Reviewed-by: Tao Zhou &lt;</span><a href=3D"mailto:tao.zhou1@amd.com=
" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable"=
 data-linkindex=3D"0" style=3D"margin:0px;font-family:Calibri, sans-serif;b=
ackground-color:white">tao.zhou1@amd.com</a><span style=3D"margin:0px;font-=
family:Calibri, sans-serif;background-color:white">&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joshi, Mukul &lt;Muku=
l.Joshi@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 12, 2021 10:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Clements, John &lt;John.Cl=
ements@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Enable RAS error injection after mo=
de2 reset on Aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add the missing call to re-enable RAS error inject=
ions on the Aldebaran<br>
mode2 reset code path.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/aldebaran.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c<br>
index 148f6c3343ab..bcfdb63b1d42 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<br>
@@ -307,6 +307,8 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.late_initialized =3D tru=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_set_error_query_ready(adev=
, true);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state=
(adev, AMD_CG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state=
(adev, AMD_PG_STATE_GATE);<br>
&nbsp;<br>
-- <br>
2.33.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4650006572BE9F0CF93BD15CB0B69DM6PR12MB4650namp_--
