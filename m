Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D94C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 13:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F82B10EEA9;
	Tue,  1 Mar 2022 13:58:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8180C10EEA9
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 13:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUZdtpStclnFnbOQv6mTIo2rZnk9CBZwrCXpWw50mC/9IlLbjRYciKTvdDnEAHYkvU2Sj5tk1uR+4HJc1zFeZO95b32xjGwrnqBRnTBLUwqtuaaRmq9nesHEBgXSvDngk86RI2cvqX0T/S/hJF9b91MU1+tYl/PRA2EdR+zhkEfExrWsys8UyXDHC5zgCE1qgujzIacOrNovunw0QO3e2XxN2Sir/3ibIUHhpUieJjqzB8CFLbMjGRXdTPpAwpRiQXHKt5Kx/6qtBa8razUvzQJoYCdw89luz+eR4ICoM8nuePrQpCC5r9QiMUDXiFjMueIThgOYT0D5K+83IB0jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjy8lfc2xOSVSq/UNpzZnIgTAugJMHaiOOgl9A22avM=;
 b=Fx6OUHopeARCZY3T6/IJZbO+9WSvrMremUn29GnbVgJXZs/YU7480msZGVJAt/wAxuVu4jzmOr5YaM2ko4k16L3RdFCqyMNl5dhAuGK6FYPHo3scrKS6xUVax7+UudAgFXUAx1b1J3qNZnxzm1Z44KhD6h0ypWDAeuXRabO8R4rc/9Vgx/cH1NpUK3C2+g2gRRHRM0074DkloOUvSItt4Jo7YwHM2HuHpRbm1dl2wu2nok7BG64Y2kri1xYAuT+bcrZEmpUAH2ID1ySs/kRFveB/sSkpPamgw75eoSTgXmDjyzvafbJm7LofyYER9nzAZyAjsWy/Nbak54gZxl3Ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjy8lfc2xOSVSq/UNpzZnIgTAugJMHaiOOgl9A22avM=;
 b=QgA0+MKbSmtxD1SfqPpWScfMNi6eEaF0RBxP8ZsOtb7hVqAx4nRPo92GOtlcqxiW7Iv40wx15WPKW+tH3lkXRTPMXNzHglRVpxF+6Y0ukFTHe7683ekrtmItB/a4W4jHBs5l3RGpk59QUEaP7Z8WQr9uf/j5wBGdjsS02oZ0zPo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BYAPR12MB3047.namprd12.prod.outlook.com (2603:10b6:a03:d9::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 13:58:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 13:58:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable gfx clock gating control for GC 10.3.7
Thread-Topic: [PATCH] drm/amdgpu: enable gfx clock gating control for GC 10.3.7
Thread-Index: AQHYLRkBcLEUrjGtIUyz9VpG2i1yPKyqjoJ2
Date: Tue, 1 Mar 2022 13:58:15 +0000
Message-ID: <BL1PR12MB51444A39BA683821AA29E4A2F7029@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1646103687-11492-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1646103687-11492-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-01T13:58:15.154Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 8eb3b347-e724-9d99-8c4e-a978cbd5b632
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8edafc7b-9351-49a4-d066-08d9fb8b8870
x-ms-traffictypediagnostic: BYAPR12MB3047:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3047133A2D66D496D7A4AE86F7029@BYAPR12MB3047.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKnuuHSlh4Y1/7Fv7o0FjbsGqbSVK5xFzaKKPPcO0OIPeKy90afgx0HKIPtyvciXB/8One8CRiOpgZNEpL3Qn/+5wbSe7TkEtivhgr+z68xGcLuAwW58pL060qYLgJnEEOK1r5eMUUBxn1EBqgPQTi4I8c+0RXI+AKYAcJymsPYBEdLSIT45b64oo3g3K2HPuCkSZGtOjHcXl+gPcajxPi9swFsiCwzM747Bi3CQKZ5nSl9oWMvypDVDYwFcIQoeUbiIHssJIDbCNoituMdBW6H0KvvVNC6La0UYSBO12svbfpBE8bDJFQOvPp9F4z044884kHUy2ing4XZlbYLGXCNC73hGUX7GTUD9s9EmjSLvm/+zrxwmIKN/zIBU9/JnQUvn8u95u/3eXSSqBZieH91DlLCRyOA7Ca75qW7oMht91DhnJBC9uIX0SZBC1rgSfA1cWiwrn4wyZSuNf0iB5IgmFU+GO8ULBFjrpEIBrN1f9OusqJITV4gAR+Gz+WxicboKl3yJf2GzeoxwieP9+3ezkCHwMg9IA6oc9syG7OMX6KFeGnnRUci/U8JFMnKnoo5dNQ5du+dU5hBYJaOOSe+hmOtJKCdP+xEPdKs1MSdo8si1kSwdheMCnpxNcyUGvrDBxRFYHNijGWAkceU/KGksE58jfJ61iY+3JobXrLS6NKvEIMEzodsup/9NE+5fLxJjKiVJUkpni9H6ZyOW1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(122000001)(38100700002)(7696005)(6506007)(53546011)(9686003)(19627405001)(2906002)(33656002)(186003)(26005)(5660300002)(86362001)(76116006)(66946007)(66556008)(66446008)(64756008)(8676002)(52536014)(55016003)(4326008)(508600001)(38070700005)(66476007)(8936002)(83380400001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ChnvaLRN4+UCmEb8fvgszqTFU0PwE7CS5YlN84LeE6hzLJ+t/ozFz8gnpso0?=
 =?us-ascii?Q?Vr7dhp8qnz6zoiDpBKHskMDo7Ld1m3tGPYCRK3HgfKFLWpvhuZLfsEv6v2yR?=
 =?us-ascii?Q?Y4jrZPjjPwnbROS6E94SUOqudAGZdQ1To/q+nOvuiKF91oLYdBbqOUPs4Kd5?=
 =?us-ascii?Q?JzlP1G3Y46FfatbLNuj9Kixz1juo1ut9Sv9+Tq5gK4wh6i84CMtD5SCMG4iY?=
 =?us-ascii?Q?GH2hF2xPfvzwhBumifWqeiHr7VPo4fxhRjcYAaXxAlDtgG2JTTDBKUAZqA8f?=
 =?us-ascii?Q?beNXRWyaJ/5jTb1ehw+C2hKwOV3M3LtCKSoJsErYPPPMEAKbWBn2rnjlca/x?=
 =?us-ascii?Q?9FyegKPmFUOlEimKo4UhtfrEvFPn8hEi/B24NKvTwtyNOmRANRIUgOQcOpr8?=
 =?us-ascii?Q?RplBBihkInyYz1GibkjztZmZLtiz7wfxXDPmnQ+/4jYbA0SZp5INi3uhDZoS?=
 =?us-ascii?Q?lyS+umpHb0DUzXQp/T/aiIi7CrkBfZ70+gKQO6xBoiJYFKcIJA6EjuuaesNc?=
 =?us-ascii?Q?/CGQk3wkhRsfkbfIkV/qVlb8uIHJ+I6JLsFcbq3NzSjkrgG2k8fNJc3qfmIw?=
 =?us-ascii?Q?KS0eLdc9oODmv4QVnl4r2Q28nuYYOJcpj+e2zpq+TfVugwep3YDzuQ6uaFMB?=
 =?us-ascii?Q?7OMVhcG62vyD5B1uZcDILOC/DPjsaQ5Z3zgUAkfOR2yzvwkRfylcqSE+UB6H?=
 =?us-ascii?Q?mjmPSAFSldXZs7L6LfXM2t1tBwh3758LsTCpICUWlH2ukpdCDESFQ1Ved1P5?=
 =?us-ascii?Q?XQJ1k5OJjNz8p1O3WbNA0khaSHINIBty2o8ZYisYS+UWmxEflbnYwrUUjCO+?=
 =?us-ascii?Q?21XUhPMHA5w1mj+iv5HDnb1sc771iIAIJkxyeEGUJPf/HyP3m7O+koxjLqGo?=
 =?us-ascii?Q?yVVnlU3drGpE1dj/krI0rdiAT86vsuBb8iZVwYw0rWT2kpXTCrhkdC8VPzY+?=
 =?us-ascii?Q?SI65pqBwd5x7lsT2E4d9PnBkk9mXt/ft8yHPcEdCUbn9ipMvS8Gq7gbGmdYr?=
 =?us-ascii?Q?bOPYhqBdtDTGOjbvzXxFLLvHdzVP3/6ndDEecj7TNUEBhqTGc75xB7lOzb/S?=
 =?us-ascii?Q?UWMB0cNpGfV/xgjk9Q8WV/9Vhd3O2LUTH4SRO8Z0D9TLY0pkmEwX3z/JBoAP?=
 =?us-ascii?Q?lU7VNlB6DyjPiOjJk1gHqt82GUjWNAiX/qmW9QoAClv4bJb5GrLntQWM3L++?=
 =?us-ascii?Q?UhVcwWoaMz4V0csnDTfRjm5AWrKi8mVq6bisvuD7zjlSlGziXoCdkRvEP4K1?=
 =?us-ascii?Q?u5mPH60SJ6WpU5QgwbAx8EFRWh2AoWavzawfijziSJd65vffriheZ+Kz0YxI?=
 =?us-ascii?Q?CdvbUO7CY5d3jrZ2pjosTJoB72791mX3YBDLbDY5xGsr6b6KjrgFpeK8zIby?=
 =?us-ascii?Q?AMxWRyw/ypjXZLh/gPPIelBRTV3raJOOCyjmX0msiISca7JEz56RHcv1xC5k?=
 =?us-ascii?Q?gTqo9l+D3XP0S8lfhoLVL0DTbqtiJ+RsjKfiyeycC7XQE3jgYb7XeczzBF4d?=
 =?us-ascii?Q?AgesaUThv+w+XmOWUaymmalfkoRz14TSh0/ALeNuev0gBq1+xhQT+K/Fe2M+?=
 =?us-ascii?Q?TaVGYUXlGd1JST5dkGW1xImdjMqhtOC5A5HHIg0M1qdNeDPg9WIYNs60Wm3F?=
 =?us-ascii?Q?Pq4cxb3Tsmkb01nbssG2Te4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51444A39BA683821AA29E4A2F7029BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edafc7b-9351-49a4-d066-08d9fb8b8870
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 13:58:15.6819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+fndNDzgi5TIaDWNp+2V1BWbOAK9qCge9lNrO4ewdaDkGBZ+nVlSiofJk79TuVnixdHRhXuaro+/rUkY4WaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51444A39BA683821AA29E4A2F7029BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Monday, February 28, 2022 10:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: enable gfx clock gating control for GC 10.3.7

Enable gfx cg gate/ungate control for GC 10.3.7.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 90158289cd30..fd7ded7799e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8445,6 +8445,7 @@ static int gfx_v10_0_set_clockgating_state(void *hand=
le,
         case IP_VERSION(10, 3, 5):
         case IP_VERSION(10, 3, 6):
         case IP_VERSION(10, 3, 3):
+       case IP_VERSION(10, 3, 7):
                 gfx_v10_0_update_gfx_clock_gating(adev,
                                                  state =3D=3D AMD_CG_STATE=
_GATE);
                 break;
--
2.17.1


--_000_BL1PR12MB51444A39BA683821AA29E4A2F7029BL1PR12MB5144namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Monday, February 28, 2022 10:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable gfx clock gating control for GC =
10.3.7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable gfx cg gate/ungate control for GC 10.3.7.<b=
r>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 90158289cd30..fd7ded7799e2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -8445,6 +8445,7 @@ static int gfx_v10_0_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 5):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_update_gfx_clock_gating(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state=
 =3D=3D AMD_CG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51444A39BA683821AA29E4A2F7029BL1PR12MB5144namp_--
