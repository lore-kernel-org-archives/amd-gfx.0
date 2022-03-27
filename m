Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7FAC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8804710E233;
	Sun, 27 Mar 2022 13:47:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F365510E233
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 13:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNa448LjLAsf7RtEYAuASvPmJlP5mnfFCHWkJDbmKmngrV/4FHAXdrLFb4ZWVhvmX3jwgLs/qxm7vt1MqrGl80JM2hLngxyrH3Jbei3PsoQHa6rFmG4sfNVMVoniDUiLrkwKaoBL594BjzNai95852KTf4ZGvVb8HugvT4uqkKm2AO0ZVSQBTMh5QhzYtzOCYGy8AemYFX6HjmZOXdznpl4xqX3hh4y0x5dxLCGqN8xhddsviaFtb1zeOx8AehQ/wOuxatpYMc2iZ85UhyU81ER8MU1orze7ABvJ/ECUJBG1ZA+7R2d1ue9v+ZPQoSc3cfSjsx4zS/tyMD1Mj8GOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkwxVSnzSLgeQ9g9cYRPk29Y8IbkCgAWHcTX4Fux3c4=;
 b=EzMRxh8/OFkANPny0ECFfTU+HuALQLRjZ9hqyrXDtnirAfyUV6TLB9IBxyJgqnSqhUKtLGVLSyL/bD/5CLRym3HtqIHlyzgHafYGyXuEUXkbFDNDajwmpH2Cn3sK3LFQGuWGhDAellwR6GE2ZpebugPA5lMhx0gj01dRSyNuLVMiiKLgk7gRywMte/lgRzJTo+juJjs1XfAEMVQaBJ5lxTAQhfVLeQcrOvN7uDHyPJT2MJRcfSn8j7W6Oh3Xpu1/kiUOBriu8Lr9JmUcr8XVjZd6LPYnKSbXqIHDwr++4Kz2X3A03PgptwM7My5z77hxmR5U0Y86QkyKLKCUMs+o9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkwxVSnzSLgeQ9g9cYRPk29Y8IbkCgAWHcTX4Fux3c4=;
 b=iA4PWYFndfUmkT/QnyMeNeGPFXBnXaoJC7pOxZMUHgYu87fwTZYyLxcmlCk/DjMjJPX4OEM98GkrTR1iCvo8oyf6IZh1ZxNg3PMLqosQH5GU56hXQtJBjhdHnxXqhHt0WLnSWJXrNQfSNVWqxThGiYdJUXJp+haC0+L1Yf1VV3A=
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by CY4PR1201MB0038.namprd12.prod.outlook.com (2603:10b6:910:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Sun, 27 Mar
 2022 13:47:25 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5102.022; Sun, 27 Mar
 2022 13:47:25 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Topic: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Index: AQHYQcx5WiXsAr/8WkiaQ7/5cnpYXKzTPrZM
Date: Sun, 27 Mar 2022 13:47:25 +0000
Message-ID: <DM5PR12MB17539AA139BF9BC96D1AB46EE41C9@DM5PR12MB1753.namprd12.prod.outlook.com>
References: <20220327111857.1372675-1-tianci.yin@amd.com>
In-Reply-To: <20220327111857.1372675-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-27T13:47:24.456Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 0c2c7612-5ce1-d32b-1cfa-295971de258f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20a73daa-bdd9-4a88-d6db-08da0ff8537d
x-ms-traffictypediagnostic: CY4PR1201MB0038:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB0038815862DE0815CDFDE849E41C9@CY4PR1201MB0038.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+ameSRPOd/BmYuA0zIisVJYQLVvNGtAMpEh7FSD2djZnwzi2AmIWg/QI10TFw18PRsqtlDONpxJl0UuInxN57ws/ylKB+vb4k10QQuj3AfdADNrvrv3YymI63C/CemNZRWDJNNHRYy8VCzo7KjZdcI7HdTdo4YYO0+JHvuGWJHRveGNX7GMKrD2opI/qur4RaaRUKEMmErpRgJhu2jVtm0dD++MqVuQreW/UlY1GqD6gqZ4B7pEMERRPWsoksCtYU3mkv8f+KbuDBusgwmkzTmmlzPFfgEsSGYhA1CKr3J4XYnVNVT4kRcypcNI8/i/EmuxmPOdorFCbg4NVnoW97UtqdOaEmjaT9cenHcECDsPzo6a9snDEjW6KAXElqhsQzdHfpKDPsGQ8NLNzlM3A+2DUbnpBZfma+9Pxpr0Gwjg/TeKhJAZkt+JoEg2A5YfP9OAZ2Cm0NMWEbAdspeKcssvbmpKFn86RjaSSpKqPQZthiR89pc+Kb/+YbgF63W8Pf64/7su/Dsa59DX0xZVmoGpJBElbU3Bdpyq1ac/ZtmedeSzL6cZnsB1Pgkdc4LlcCsA8bIAEhSuFjNG23K/OySo0DJwpMH2nOr9Y7ue2OPrKLxfA0DNyzLbsr7YvSzhOFR1faOMsoq1D42xaZPYAGdPm10skonj3pIE7bN5LNwTf/PzwMzwmlGD8vbhMFeCH1PUb7v3Pn1b1CEyOXF7vA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(122000001)(66556008)(508600001)(186003)(19627405001)(38100700002)(5660300002)(8936002)(52536014)(26005)(9686003)(71200400001)(38070700005)(6506007)(7696005)(54906003)(8676002)(110136005)(316002)(66946007)(55016003)(76116006)(4326008)(33656002)(64756008)(91956017)(86362001)(66476007)(53546011)(66446008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M8oGBng+hqsektCHYGB78GyKv4TVylyD1bae6JzE/+3p3C/O85VuHofcReTJ?=
 =?us-ascii?Q?OBnPUr7fTo2G6Mwcyoj3nEEjfp4Uyb/EJm5Qj39nH7OToElsa6zRVtQV8/h/?=
 =?us-ascii?Q?Ncj92BhBIMphv1zum9FenaKAgOAJF454sOKB9eVH15jEDdudInICTZNBqCEB?=
 =?us-ascii?Q?CzFdsf4mswNkfpdvxbwgaGHv/KNOBgQFPohufESPwARalxu8cIHMmYT37xhc?=
 =?us-ascii?Q?/gpOMklZq702TfH9LQTxTW0oMAYWATQcfn63UU/nYP9ZdvGzCcwP/lRrSG7j?=
 =?us-ascii?Q?CxgUXK83HUE725+pT24gt1C9AI7NfYK639VT7RMJCbRP/xTOGv3LZbCo0XJR?=
 =?us-ascii?Q?qP7C1geiHv9SSKOW0ihWQdcNESqAt+si97HiZq/pV2eFxSBH51WaqG+pBhTB?=
 =?us-ascii?Q?xUfXl8MY7Fcx2cMEpz396AG1T1b8Lks6J0W53DxEKkwn7TshvODZMrg2zEbs?=
 =?us-ascii?Q?6IPBECzMhC5zy1811CSoL3d+vgJmgknWefXsDhZCil76MRvSH8Uy6o9BwRBt?=
 =?us-ascii?Q?FfEig4uhHt9jlhzIA0kAqY51al1s0q2jGz7vFfOGF3eGkNSysjK9uD9rDBnu?=
 =?us-ascii?Q?uJEBOQl6NdvPSzcxxA2z9/IBHMQ1QxtuyJlpInMs/wkUDw5s1fwr9XT5TW8c?=
 =?us-ascii?Q?FEFlSLNfQ9Em5WofBDyRHYX5ouEO9/0scehvpO0veGj0wB5vrOXchof7i1CK?=
 =?us-ascii?Q?xj/YycaiaVITF1X0VwYhD9cCMM1eCf2Fxn3MxTlJfNNLCEtJ1otsjCOUcVMj?=
 =?us-ascii?Q?ZF5a06tQjoUANg8csoVYcRrgcHUMcS5/pRSOxCDl0EjRNLjeB9LJwvrmpuat?=
 =?us-ascii?Q?KeBi0SoJF98BfKhw56QGdGJPyoyFpliSS9lVrkaJXQMg32/ZgoOk4z/LODWJ?=
 =?us-ascii?Q?Fuf46jUgCeJRd9CpeGYNVxWEZc8wchHgBfH8LReK2fvwYf4DBRgKXlZMtANk?=
 =?us-ascii?Q?W73pXb5xbYVBkBkCbbAP12r0A6gW1je2/vM3zU++oRMjfMzbb3wulmLknIa8?=
 =?us-ascii?Q?FLts8WFs4TLW0h3+NoodyYAsUpWUb2gUBAQycJVuWhmmnG2lV8osCCbSsZ9P?=
 =?us-ascii?Q?EYA87XWH/zRH6IWA11xeKhB/Xbpo83+eUG1rMX7UFe2i6um1NxiZLD94j7mf?=
 =?us-ascii?Q?gkoA4ZfeXW1SDAdNhb2FACTQr68kSvGji/ZeDzrxxqfePMTK1PXAKowee0SR?=
 =?us-ascii?Q?5rNxd6DeqCS6qVpuq7sZxlT6qwLBmimPtFazjOFfoGCNbjvRd640UFTyJf51?=
 =?us-ascii?Q?u/VN64ay1NM/4MoU4QeJvvGavlY0f6waTQyX4AvFKA0n31Hl+Au7DBllTjkq?=
 =?us-ascii?Q?orKwNnmsHvOloBh+3f8HJC3Uxd/8V5dJThD44ThBidkJX+DPX6dPT4V1AMzg?=
 =?us-ascii?Q?Re37vqyKqIho8hnJWiJ/ICTSc9bJu5OVpylzVwYsZNmK3xg5aWCAPBPbsC2S?=
 =?us-ascii?Q?dwNJM0Vq5DpHZamrt9QS8+QkRh4IK9jqUDI/AIgxfWG4+/77l+yg614qL4z7?=
 =?us-ascii?Q?uvky8COw3eMlMAVTCfdYvYTVgyKhUooJ6GOs7DIZEJBogytcxMRzPSLO8ReF?=
 =?us-ascii?Q?LzB5n9edAvsBUYzJNM+kPF3kSK7lh99UCd22Q4cgZxEEi6hsc+5TCSBVO7Z9?=
 =?us-ascii?Q?DNtL9b4dUsuyBzks+ZsEJEcTT4sle39zin0m06KuMcjD8WZOMRR4NyS+QO3d?=
 =?us-ascii?Q?yIiwXLvkDoS9BMiZr0Mp2D7+4UOhFbRypZNL1tmp0NEX2doQ?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB17539AA139BF9BC96D1AB46EE41C9DM5PR12MB1753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a73daa-bdd9-4a88-d6db-08da0ff8537d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2022 13:47:25.1533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99NF1AskXfHcYTYWwVe5q2saRxsljNSbZafB2GBzCdlvnhhXzXuB+OCQ1N/SfU1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB17539AA139BF9BC96D1AB46EE41C9DM5PR12MB1753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Sunday, March 27, 2022 7:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

From: tiancyin <tianci.yin@amd.com>

Some video card has more than one vcn instance, passing 0 to
vcn_v3_0_pause_dpg_mode is incorrect.

Error msg:
Register(1) [mmUVD_POWER_STATUS] failed to reach value
0x00000001 !=3D 0x00000002

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index e1cca0a10653..cb5f0a12333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)
         struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNP=
AUSE};
         uint32_t tmp;

-       vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+       vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);

         /* Wait for power status to be 1 */
         SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
--
2.25.1


--_000_DM5PR12MB17539AA139BF9BC96D1AB46EE41C9DM5PR12MB1753namp_
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
This<span style=3D"color:silver"> </span>patch<span style=3D"color:silver">=
 </span>is<span style=3D"color:silver">
</span><span data-markjs=3D"true" class=3D"mark32y0ivcxs" data-ogac=3D"" da=
ta-ogab=3D"" data-ogsc=3D"" data-ogsb=3D"">Reviewed-by</span>:<span style=
=3D"color:silver">
</span>James<span style=3D"color:silver"> </span>Zhu<span style=3D"color:si=
lver"> </span>
&lt;James.Zhu@amd.com&gt; <br>
</div>
<div><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tianci Yin &lt;tianci=
.yin@amd.com&gt;<br>
<b>Sent:</b> Sunday, March 27, 2022 7:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhu, James &lt;James.Z=
hu@amd.com&gt;; Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Yin, Tianci (R=
ico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: tiancyin &lt;tianci.yin@amd.com&gt;<br>
<br>
Some video card has more than one vcn instance, passing 0 to<br>
vcn_v3_0_pause_dpg_mode is incorrect.<br>
<br>
Error msg:<br>
Register(1) [mmUVD_POWER_STATUS] failed to reach value<br>
0x00000001 !=3D 0x00000002<br>
<br>
Signed-off-by: tiancyin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index e1cca0a10653..cb5f0a12333f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state sta=
te =3D {.fw_based =3D VCN_DPG_STATE__UNPAUSE};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, 0, &amp=
;state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, inst_id=
x, &amp;state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status t=
o be 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, in=
st_idx, mmUVD_POWER_STATUS, 1,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB17539AA139BF9BC96D1AB46EE41C9DM5PR12MB1753namp_--
