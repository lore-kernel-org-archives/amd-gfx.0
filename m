Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A57C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C30110E44D;
	Wed, 17 May 2023 16:22:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7BF10E44D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwvMEjJbzaQu6vuhDwl9GynqkMn2BHX4aHma3F2eLktVc62hZv/EAYAxThFxfZuP4tld+fxPbSWREJr/5iJVkKuVMQJVzAcQWAL01qaX1tlzWIkMgyLT0fMiZ4UhRP7Wr2YLicnf7C2+Oe3TZB3QhCvj00CfHBbf5M29HuCGZU4T1H52ubLaJdRSUG7Oy3Ai0zqq5N+QSfRlq0Zs4ipb6UtJqfbnKmdec8lpQjLhXGizKq+rgbACAMMWnvMdzZRjBgSRY4nGM+iFZDkg9B8sfYSzPZMMMqGxTYEa2ZWrqBDwSN2ra4KcH7iQGD5cznwus4Pu8uZPm4rR6wQ2V2kdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7XYYIH16n+PQ8gzIRGizK2o7tIetQflHkUm9iTqqvI=;
 b=f0iEZsf83UPC6MG+aN4wLcKcj+iuFNBjBFeHLZxpHY6mr3F3snyhgk925zfWpVdCnPdjo7bsALPhcp3vI8M0RwK5l1Et31zPJq1XZPiMnSAo3fskvD1pOiLZFKIJSf6a6Tt5kueolrRe5/LINtCW6BCIluRllPB30SBKdRn1bMJ8AuB5fLWWKOayW8WXP3wMaSoIZbFc66lXbofqoYD1hD95dzb/x+G1wgz2Y3VZ6nauT0hu3lBoshUTKFMGjlNVvKbYx20oiR3jMhHDn2o7wQGVFC+mYsYzlfPKCG368WH0tgc3AGSYrTqFRpMjnBMFbMl8KPqQ/pQ2dnGFnQf1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7XYYIH16n+PQ8gzIRGizK2o7tIetQflHkUm9iTqqvI=;
 b=Fi+81GYctuV8M1LgydYU98tcYEEOtF8EcQ71HES82CnG4FTVU2e3lIpO1oEpGR7NmlF5Yoes8fTE3RW/enh94hMptzSvUKvm0hOiuV19Ie0Od/WvEhVcU9bcvJmLKhUQGr8p1djoviexGlOafT/op0TXqb0TetYHOOIeuCjieZw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Wed, 17 May
 2023 16:22:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:22:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: disable extra gfx943 legacy flush on rev1+
Thread-Topic: [PATCH] drm/amdgpu: disable extra gfx943 legacy flush on rev1+
Thread-Index: AQHZiNthHrMIT3prJk274wgCDlAM2K9epdsd
Date: Wed, 17 May 2023 16:22:50 +0000
Message-ID: <BL1PR12MB5144DF8538CB9ABE2AEB13B4F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230517161909.359715-1-Graham.Sider@amd.com>
In-Reply-To: <20230517161909.359715-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T16:22:49.630Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB6669:EE_
x-ms-office365-filtering-correlation-id: 3aa2986a-4be0-435a-13e8-08db56f2f55d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: joaFVBM/yN/01gKbTAeKpEVfYS1wIEmj2tgMmWPctcTiENWM4m7L6R5a++TpVBQJVC9wvWRSqjqUCFXBF/0+Lb7TTJka229ZJ87tdUgDgd52xWkeLoE4MOQOTmZnIL4V3vjqauriAJ2FavBYSSLJ3iyNZCOjjx3hilYYcL5R2uUwonKa35PFtHpusd9iW64rMhmZlEflc3m0h3u4Ag0hCtNg14C6tnDJXFFEQZ5vsxZ24nyfSFMX6KhznE7bDuxMmKe4xoZ7Suq+gsRRY1c35+dkvci1A0ApIbL8LtmW6iAAjjsf2+cstT7NCSKdk4dnp8EzDB7VsdSzYQnnPgg7sAXHPTtI0DrMN5btVM0nCkb4wDsu2Pj+MBImklyuIuWrjC45RHWN5DqQYzoLFi5KBCZlUjcuiaEFsDqGmBYm7XLizwVYPL5UzZYB0T85K0n56wHqMybna6qtRrv4a0PBGHHuPyMo039CEJfoNkrWxr5stsQVNz4RkT4poNLTMwG0wxSWBzwxAAYa/xbhIyu3xfPndvnRL9fP30IJ9hsZIssXHC+wbS5Ck/nO41D5NLazYSOEGOYkw0AnwYiIZibJ6neHcI5TXIUgIP3VT43izu7zTgGDz66aEwOghZOx1xdj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(110136005)(66556008)(64756008)(66476007)(66946007)(66446008)(478600001)(76116006)(316002)(71200400001)(55016003)(41300700001)(8676002)(8936002)(2906002)(7696005)(52536014)(26005)(5660300002)(122000001)(33656002)(86362001)(38070700005)(38100700002)(6506007)(53546011)(186003)(83380400001)(9686003)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uYINlJgDI7mANWqQyE7pqEiaQsfN0ndcsrgu26Ne7dpp7Rnq52XB/dMB/ar7?=
 =?us-ascii?Q?SXV8T2dFglV2upLDHWbxxGRbEty5k0ML/T5Ry/yWa6/QsIz6Hu06UB4NCejW?=
 =?us-ascii?Q?lzqB/27WO4TeQJOuDVvmsY/08hZHyChzPEVW7vfSsaRcCLhnAxpGS6DxPCBD?=
 =?us-ascii?Q?hhu1Yw1+Wwp9r60mWY536uqFb9kx7gxEZmGPYQsrULhkIQ0wYw186Pdu8Vvh?=
 =?us-ascii?Q?VYmWM7fF5+qUKrvZOY0fTo3c02HmLfZWgO1gH5SCoc9US3bVLpUPsW2E4Lju?=
 =?us-ascii?Q?2LY/lg5G7v/t9e7PnIymc7eKn3onXP3cPmnPkBKakg7oLbq+s4y0sWrIYUM1?=
 =?us-ascii?Q?y4EoomdYgZPNX5FM1GF9mHBoay2XTL/i9Q84dICkP/74VGSb2s97xKS3Jgk4?=
 =?us-ascii?Q?zmht3Op/Psa4OUS/eNv854LBC5kM4vY2/uGfErxZw6cmQ9Y8aXcX7DsIWrdE?=
 =?us-ascii?Q?CGQJHgca2DBCUJAXTEGE3xvgsha3jTN2YYLL3XdPe0jYXSMxS2czhxACobGl?=
 =?us-ascii?Q?dTJcs9cIRlxT02p4N9GigprXEmn13POyQs26SQE4kfvASOBFKNTwhsoaa4lh?=
 =?us-ascii?Q?ogsk0wKnMx6MpLSrghm1ER6tizWpaatRRTCXz20XyqutJgQvP25PdCZtWbCB?=
 =?us-ascii?Q?U/4d0fXMkli48ufHsgL8LstrpZG2ips3RrL5MUSeo0CVGXKpD/IljRl/TbTg?=
 =?us-ascii?Q?wOdyVtqDsM2azF+Z4davkYVLOmlVQyDh7V/U4DC38REGQyfwOQaz3xFq0Ug9?=
 =?us-ascii?Q?oL1GkGHK5HrMO/LYhZa1vb11PnBFaqaJFHB1rpTGPEK4m20N/wRqKN8z6SBD?=
 =?us-ascii?Q?9TC82wGYW3YWTrCEkLXgYKyaEniWl5jmPwobgCRc6Emm4zDK0hglBOPX3sFu?=
 =?us-ascii?Q?61ZKpA7BTdpCHMHG7Bvu6XgY4pOkzCZz1AYbLWhAS0gruPiLMT09cvgsgiA3?=
 =?us-ascii?Q?1UGnvvm2FO1jUfaTKkd9opyQ/4D0oWn1hpoJwr/daq3sLzIjtnTQ2jA7200N?=
 =?us-ascii?Q?5GS9omDLd+JDMeCrd1kT/7d13A3Ilv7j2dSSyMHLHKurVQSfHL1a+crNwh1P?=
 =?us-ascii?Q?1VZWWMK80Tt+iuy++NleoNzJYl3nUZf6p+YhVea1+i2sZrRvPCskGKA4o0Cg?=
 =?us-ascii?Q?1vHJ3kGXvP2390rfY9lpgmd3MZpyKMiqxZ0npqR9mZ9Yc9wGCLFScG5CKFXv?=
 =?us-ascii?Q?2s+mGYAQBUdeDMoFYfvATUsPq5KQFYnx9hgIinHYkvF1Dl3w8+xaTXYk79NB?=
 =?us-ascii?Q?LnwFI6sJGyU+d3h+qvQgw/QSn/3Ps1HPX8poFTwKUnRyor2mvmVKP+JVor/i?=
 =?us-ascii?Q?t2Xp0KxAE+y6OlWfIjfbaknise8ak7RE1Qf59xRhdKr76khMoWfjiDDpW9Pt?=
 =?us-ascii?Q?kNP9/HN0Dun7oLLvrXtD+s7L+Pg0Un2SL9Vffx1+9ZuxSjwdzm8wLLj3+bD6?=
 =?us-ascii?Q?1vDhFL6E0EzQmaADK3vX/3MXjVIS8jsOXofDVTT+NoIsQQ7zO/uMVV/DbSqV?=
 =?us-ascii?Q?iD84s0+tjkrzp57HAkmK38NDIBcAs4BeA7rgxjWlh9uvIqnH73s9BYMK1cns?=
 =?us-ascii?Q?RoJm7DaQ4LPN8kR9SOk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DF8538CB9ABE2AEB13B4F77E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa2986a-4be0-435a-13e8-08db56f2f55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 16:22:50.1496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X7yCZg1Cc3hQDMn1VhZligsd1fG6Cfq4Wm9eq6f9E1O0PBsDgGoqgeqZRv8lIJdCuIwFItA1u3Tz9+gLqnT5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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

--_000_BL1PR12MB5144DF8538CB9ABE2AEB13B4F77E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Graham S=
ider <Graham.Sider@amd.com>
Sent: Wednesday, May 17, 2023 12:19 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdgpu: disable extra gfx943 legacy flush on rev1+

The extra legacy TLB flush mitigation is only required on rev0.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 38e4828f574e..ba8251b6b279 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -844,11 +844,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
                 inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 2);
                 inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_type)=
;
         } else if (flush_type =3D=3D 2 &&
-                  adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)=
) {
-               /* FIXME: Temporarily add a legacy flush (type 0) before he=
avyweight
-                * flush for gfx943 to mitigate a bug which causes CPC UTCL=
1 to return
-                * stale translations even after TLB heavyweight flush.
-                */
+                  adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)=
 &&
+                  adev->rev_id =3D=3D 0) {
                 inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 0);
                 inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_type)=
;
         } else {
@@ -993,11 +990,9 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,
                         kiq->pmf->kiq_invalidate_tlbs(ring,
                                                       pasid, 2, all_hub);

-               /* FIXME: Temporarily add a legacy flush (type 0) before he=
avyweight
-                * flush for gfx943 to mitigate a bug which causes CPC UTCL=
1 to return
-                * stale translations even after TLB heavyweight flush.
-                */
-               if (flush_type =3D=3D 2 && adev->ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3))
+               if (flush_type =3D=3D 2 &&
+                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3=
) &&
+                   adev->rev_id =3D=3D 0)
                         kiq->pmf->kiq_invalidate_tlbs(ring,
                                                 pasid, 0, all_hub);

--
2.25.1


--_000_BL1PR12MB5144DF8538CB9ABE2AEB13B4F77E9BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Graham Sider &lt;Graham.Sider=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 17, 2023 12:19 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sider, Graham &lt;Graham.Sider@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable extra gfx943 legacy flush on re=
v1+</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The extra legacy TLB flush mitigation is only requ=
ired on rev0.<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 15 +++++----------<br>
&nbsp;1 file changed, 5 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 38e4828f574e..ba8251b6b279 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -844,11 +844,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_=
type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flush_type =3D=
=3D 2 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(9, 4, 3)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* FIXME: Temporarily add a legacy flush (type 0) before heavywe=
ight<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * flush for gfx943 to mitigate a bug which causes CPC UTCL=
1 to return<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * stale translations even after TLB heavyweight flush.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(9, 4, 3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_=
type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -993,11 +990,9 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&=
gt;pmf-&gt;kiq_invalidate_tlbs(ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; pasid, 2, all_hub);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* FIXME: Temporarily add a legacy flush (type 0) before heavywe=
ight<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * flush for gfx943 to mitigate a bug which causes CPC UTCL=
1 to return<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * stale translations even after TLB heavyweight flush.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (flush_type =3D=3D 2 &amp;&amp; adev-&gt;ip_versions[GC_HWIP]=
[0] =3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (flush_type =3D=3D 2 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(9, 4, 3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&=
gt;pmf-&gt;kiq_invalidate_tlbs(ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid, 0, a=
ll_hub);<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DF8538CB9ABE2AEB13B4F77E9BL1PR12MB5144namp_--
