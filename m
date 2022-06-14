Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86613C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 08:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D0510F7D7;
	Tue, 14 Jun 2022 08:25:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCE510F927
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 08:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZP4QS5dL6O6yfarEWwPU9MwWZJvvvCK8klYpp6A28wnoIQjN+pP/04gVl6F4nJWJ3HC3iCvDhA4s1bmS7aT+FJKNmYc0Sj7rRL2VML3t698TeEE2iOYxu8pPGXhY5AaTmdzC0Bd83/+BUmjUzIR7GLkjK41Pm7dHpAV//NYAotrKP/Dkm3IM/rPnisi8gg1j7mJ5Ci4Kprdl1XgXCe2JWuNpR4VbRqZ6UH1sDF2M/iFpM1wNEyGEgEFdxpmsw9Avaitfc+BkINX/NKEP0xUq92tZJH2cZdCCeY40IdPPe1Sw34tJQmMmpRpf982VhgdWiOoVRbfU5v5JVVVHOPqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKwKD8gxeUFXvIVSCLUyQvOopjBY20LTUGv+7DvhCQc=;
 b=HfM3k2UAoL7Sh9Hr4uHJeeYD54K+ITCMywJyv4qL2dnJMjeIT5oOqu7c5lfXCuzIqj+VXNvP3E5QRsc9VL5U+yKj/A4obFCl7rRn2YFy9zsvKIRx9wgiQnxWiFzMa24RoxHofsafDN2wYccZiB9ZY/3bg65X8Z2ojK7ZZALQnXv7spkEBVNaQHLY/e9JaYaUuh7E6WuO/MhHMSU1eM6+kigzxxzMtb6XJY/bOZfO95zxqBqu8jlbN4q9+5DE5EZQlM6yQgUUGq/rhv90wuUsTjCMEEaJNV2/WAuM4DD/uDLeyzCUktST1+z2TvIa7XJiwmbsCRDS02DeIfg6SRYKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKwKD8gxeUFXvIVSCLUyQvOopjBY20LTUGv+7DvhCQc=;
 b=N2dhHLGF0mcSGyavrEZNrMMfrjLXNkW+tbMaJYhFCO7SOHql0z1HG3ZeXewuFmlN0vZAVgLLi0V5Xj0dG4DxQuDkrFZ/4NQN2UAfEuGTd/Ps93Iz2/xRgO1pBhoKvK8NrCP2TvS4b3dgOUy8qCksgpYjaPpQcJ9XZTlLQjN4Oms=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 08:25:14 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:25:14 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions
Thread-Topic: [PATCH v3 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions
Thread-Index: AQHYfzkbnJMQ2hogtk27h7QyGQufta1OkhNW
Date: Tue, 14 Jun 2022 08:25:14 +0000
Message-ID: <MW3PR12MB4458890E5BF9B0A50495AEA6EFAA9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
In-Reply-To: <20220613152001.3045911-1-Graham.Sider@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-14T08:25:13.916Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: 99a3aa16-d05b-b9fa-261b-3bbad0b02e0b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59032f4b-52d3-4739-3868-08da4ddf6821
x-ms-traffictypediagnostic: MN0PR12MB6104:EE_
x-microsoft-antispam-prvs: <MN0PR12MB6104314289175E42A93DC842EFAA9@MN0PR12MB6104.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsh5uRBMXYfYsI0VjfVNWslCpIQiBvN1WjbJ2vCSZaksfxeUwBIzz+z7bWtZzAlvQhEIfWc5RAIqSAqL7y6Mr0NT3at+p7jEuopD9i2VtSzjShqyG3zNezS0d/Vcan1Op5UYau/9DMZOPGEaWM+TaehNtjQfJfpSsCgFPERnlPBNSx6/1vSAoZzUWcH2n2k02D3XUOv+QdIE1Jktmo2NVrjV+BJya+KcSzWc/KRsa/Oy88O/1N2nKJIzVey+WBTLC0KBGIk1UzCe4YMRUyHdTTNqupEmqRtWL6NSscB7UK3mjpQynEOfH0ztM86Lt9UN2ufl+Va5uTeswsbkLjmygxyeZPM+vByRHPdPJl1ZPZiFi8/0ZlZNhRAsLlCRBlAwwUXzSJ0LuWEFG+WNUOFbtKVsSWEZz7wN2nByALQlDO0hrCnAvLWc8/syrwoN/P1OHjnmD6bj3NFiGM47qMFiexNoE3tWcoDb8ogy1vFPcKIHD9tsWujQQj7YQugsYhzZFBZldOwrbyVR7brVI+nNWeTks3HhSu66HFMIijn4J8321zccQ84072eXS0E30zG5xgTIg/vB3/iVsfIhOltti73zMiKczOp1+iO+CLnl36MJOGK5cbrbnZPktzhSF5ZszAkhS6QCyUXCZ1RYh7Cv2wj+t7EnLAnyxBVFMfYoO4zdr6NKpDtpj49uULv7Q1AHP57VKAG3dKnVx/v5EEzQNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66476007)(66946007)(76116006)(91956017)(4326008)(8676002)(64756008)(66446008)(66556008)(52536014)(38100700002)(53546011)(8936002)(33656002)(38070700005)(71200400001)(2906002)(6506007)(5660300002)(7696005)(26005)(316002)(9686003)(86362001)(110136005)(54906003)(55016003)(186003)(19627405001)(83380400001)(122000001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Osz7i09zSA2l6fRFsGIpfP+6yxqx/tMZseAgWKtOREq+cNDNIVM1bqY3cz0B?=
 =?us-ascii?Q?NiBRKL6ORDDhRcA669IRdmEtCPghsWYK+oVtFl/R9eY10BF8UNYam+xO2w14?=
 =?us-ascii?Q?NQf+72vCZZzHlzgy0+LaLxfgBytxSj9w5WCZ/vKzIsF4fYfIaRzyyCQAWFL/?=
 =?us-ascii?Q?RyJIPGOjQQEbU1/QLNnHTUbLo4DXx528v6AHJma73USZ6+d6/1wNshHiZlL+?=
 =?us-ascii?Q?ZHFxxFr1aHJxpkRfue1PZohxVHELr/9jgSyc6RMwp64kuN14bVuFYwGzL/KO?=
 =?us-ascii?Q?J6MLqmsmt0do0PwVLez7r9hUvUoGgg4oKrN3N/czn+OvltbWB8zLBQL0Vvk1?=
 =?us-ascii?Q?2H8pg1AFbrdj07Wk1O4srhVtlfG4rLrTyylKTbm59vrFahIV6F7qTJGSXUmS?=
 =?us-ascii?Q?zyp2Ulhk6akIEKSkjAK2wI0/QvbduBe8UpeJnglWJcRXGTAPvqPmyfjTT+V+?=
 =?us-ascii?Q?xfQ7gziO243MlAoiI1yLnEBz2Its0BiXgeqhVhhwluyt25F85PIe9s+SgGTd?=
 =?us-ascii?Q?j0MhAg+uqk99XTMzXQ8ZRlDdsEGZJhJHa4X7/X4riip8Ry5PaT7kQBwunM3E?=
 =?us-ascii?Q?T24A5oVZAkgU6bMEMW2h25q66YTrMjW3dlr/M550cpgEAcJLE/qEBxljO0t7?=
 =?us-ascii?Q?QBVWj4hAM2ktHAEWIz/USdF53Uyq8c+QYAeD+mlNdKTUdL7Q5l4iwudB1rjl?=
 =?us-ascii?Q?7mHjzs3pF8RNpTP2wIB9szidCmAQSz6ep1faoD0Jw68GPd3Kve5udH1zfSDY?=
 =?us-ascii?Q?bDZf89IhTRS/4xV9yKh6CjUBb/gGf+m/bkx37b86eWA0G52PFnDJo8PUW0hq?=
 =?us-ascii?Q?X+Z1sNOQaCwaAQblkN0hBSnBItf5NDdMM6BxdObRxzkFMXJ8xzJ23M5N4wDM?=
 =?us-ascii?Q?laAmbgbKevtLcsck1z+BEzFAqDYtRGYEcc89Z/LTMhedoYCN6p05PVyF//wo?=
 =?us-ascii?Q?nFQs3MY0cgnUCqez+U3G/6JeiYcZDBH7cHbP0gZV6r90sLG8buZOB6j0Uq8v?=
 =?us-ascii?Q?FBLbVnYCJbQU0aHX6doatu8XTfGnrIyy/JYC7v+8H1/A/LJEW3mh7A55jARb?=
 =?us-ascii?Q?I+CkMntluCgvK12VothPYuOhbimpMzLW4hSlQyoIVg6YX9n9hQxYZZYvEBc/?=
 =?us-ascii?Q?YsNDAcfa80VtdbanHdOnOJK1sOtKokZYc5hkov7mzETOySWig+/erlxIBSIE?=
 =?us-ascii?Q?hYI7piuiZM8wQCRqj4+tMFei88Jr0I5tEQdhAqZjqfurqSC2QKKpleSXzwjs?=
 =?us-ascii?Q?8b/VNYwhryHvpM5U2lvH1Y73tU6tLajVK2OijJGChgpO4CW5ptoBtMcvX9SV?=
 =?us-ascii?Q?a3goQpU8FQcMUsAuRC3e3RV61dP8xf9GWhwyofF1lEdQMdHvnNRg7Mxgg7/w?=
 =?us-ascii?Q?8fhL47P9OMuUp8uqfJUY1/1AshIdAVHqSlG5MzDcyJvWC9msCVx9c27A8OX3?=
 =?us-ascii?Q?vwPzSlg3nFWJPF+874M5iyi8L6TsqNTsgcGD85bv6xvpbHRGmjP/j5wrfHDY?=
 =?us-ascii?Q?GF1trUZ06TB7hQT9Gm/D1K33RvD345WJ2W1uYOus+fDrYhURPExRe6+pY1y7?=
 =?us-ascii?Q?lUFzgpgsec7as04EUcor6zwsm7sbTtgouNLW5FyGKoviBkmGipB72i97PF5m?=
 =?us-ascii?Q?TPA8e5pH6rxAWzH504XkrrAWr2omlcaU5eKS3ywhTQO9b8cn7itcmvey1e+f?=
 =?us-ascii?Q?8+TLfHXZ+wW4sQtnSjRmkqoz2AzTCaZfmtgyRSWu981sruUJ?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB4458890E5BF9B0A50495AEA6EFAA9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59032f4b-52d3-4739-3868-08da4ddf6821
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:25:14.5774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVryTBMQsxQkldyJoFldT/qf9eU0xewnbVTP5pet99up8V7ueGnmKlomS2u3kb0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB4458890E5BF9B0A50495AEA6EFAA9MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>

Regards,
Jack
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Graham S=
ider <Graham.Sider@amd.com>
Sent: Monday, 13 June 2022 23:19
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>; Sider, Graham <Graham.Sider@amd.com>; Yang, Philip <Philip.Yang@amd.=
com>
Subject: [PATCH v3 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions

Store MES scheduler and MES KIQ version numbers in amdgpu_mes for GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 92ddee5e33db..aa06c8396ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -64,6 +64,9 @@ struct amdgpu_mes {

         spinlock_t                      queue_id_lock;

+       uint32_t                        sched_version;
+       uint32_t                        kiq_version;
+
         uint32_t                        total_max_queue;
         uint32_t                        doorbell_id_offset;
         uint32_t                        max_doorbell_slices;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index e4eb87689f7f..2a9ef308e71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -890,6 +890,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *=
adev,
                 mes_v11_0_queue_init_register(ring);
         }

+       /* get MES scheduler/KIQ versions */
+       mutex_lock(&adev->srbm_mutex);
+       soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+       if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
+               adev->mes.sched_version =3D RREG32_SOC15(GC, 0, regCP_MES_G=
P3_LO);
+       else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+               adev->mes.kiq_version =3D RREG32_SOC15(GC, 0, regCP_MES_GP3=
_LO);
+
+       soc21_grbm_select(adev, 0, 0, 0, 0);
+       mutex_unlock(&adev->srbm_mutex);
+
         return 0;
 }

--
2.25.1


--_000_MW3PR12MB4458890E5BF9B0A50495AEA6EFAA9MW3PR12MB4458namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"margin:0px;font-size:12pt;color:black !important;background-=
color:rgb(255, 255, 255)">Reviewed-by:&nbsp;Jack Xiao &lt;Jack.Xiao@amd.com=
&gt;</span>
<div style=3D"margin:0px;font-size:12pt;color:black !important;background-c=
olor:rgb(255, 255, 255)">
<br>
</div>
<div style=3D"margin:0px;font-size:12pt;color:black !important;background-c=
olor:rgb(255, 255, 255)">
Regards,</div>
<span style=3D"margin:0px;font-size:12pt;color:black !important;background-=
color:rgb(255, 255, 255)">Jack</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Graham Sider &lt;Graham.Sider=
@amd.com&gt;<br>
<b>Sent:</b> Monday, 13 June 2022 23:19<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;; Kuehling, Felix &lt;Fe=
lix.Kuehling@amd.com&gt;; Sider, Graham &lt;Graham.Sider@amd.com&gt;; Yang,=
 Philip &lt;Philip.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Store MES scheduler and MES KIQ version numbers in=
 amdgpu_mes for GFX11.<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; | 12 ++++++++++++<br>
&nbsp;2 files changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index 92ddee5e33db..aa06c8396ee0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -64,6 +64,9 @@ struct amdgpu_mes {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id_lock;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_version;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq_version;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_max_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; doorbell_id_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_doorbell_slices;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index e4eb87689f7f..2a9ef308e71c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -890,6 +890,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes_v11_0_queue_init_register(ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get MES scheduler/KIQ versions */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 3, pipe, 0, 0=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.sched_version =3D RREG32_SOC15(GC, 0, regCP_MES_GP3=
_LO);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (pipe =3D=3D AMDGPU_MES_KIQ_P=
IPE &amp;&amp; adev-&gt;enable_mes_kiq)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.kiq_version =3D RREG32_SOC15(GC, 0, regCP_MES_GP3_L=
O);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0, 0, 0, 0);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4458890E5BF9B0A50495AEA6EFAA9MW3PR12MB4458namp_--
