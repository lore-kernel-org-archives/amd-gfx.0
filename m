Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBABDC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 04:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5DE10E066;
	Thu,  8 Aug 2024 04:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vSf/UxEE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D1110E63B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 04:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6GophyD8A2cS8iIZxrVSyNCoEhfoqUEPs6SoCNrGxhH/T9YfLqu/MJm0Aq/rA5PhnScBh8XGTS5FzZsc9jj0DRnR3wnG+ioMW+7FrP4rXVwlU+DaTRqlFJoRisA6QIudi69l20sE5R6Lxta7h7K8nLehpje+cdLIjEzh5kOAanCIfQef9uofWzZpjN8ikyFcHVcgEwM2KDQf4Cjn043KHSUWivwQ48JpIgRMIgEwzaIhfOf+IprvO45mkMOFxqP8bgksK7f12zb1gMEX1BWbvM4/3P2De+shx3hymY/RUqkzgStFLhgjEG8Og8H+wK8ohLEI62503aeJTghIIPqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk0nKpz9R8JGcV8cNyZG32hF66jwT7wZVHZlh2DepI8=;
 b=wGEO+YptEjoeluWnFwGeJwAwVXpsXTuAyN2PzOFNnJ7zg6SNVpEa6Zh62iO0ScgE1Oj1anLQRoE3oJbMMLU4KB0Fb5aMbuy+Lb6xQDRxc5TTNjWUD5xDfcO6d7Ne0J7Y5EdvYXzo3xmTlpcc50f9OQ6yIVQCVwJG1iNblyVg/1UgsWmrFbCuwtxB+6ozr5PKvRGQdjtYCR+4OOLl7I8AI5nZ+JYQBSGm5CsRVke/Gv+rTkyFijJlUJt/Ktf4mPO0fWY9IMro/lvLSNKFGRPPi4KLoLWEweoUos8qUzzB0GNYa6MU+lJMqS2EIulhX2N6lGyTfuEIlg6F8LRc9OvJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk0nKpz9R8JGcV8cNyZG32hF66jwT7wZVHZlh2DepI8=;
 b=vSf/UxEEe9K8MplBXhmkpt7OkY15iAk8+xejKK1MpH1pg/2F3lddJxu8jE0y0p3xFFk8IMTmtpDhQgr/nBQd3ePyUxA1VBRp2I9Un5xvAkV0XTzmHiu0Y496GjWkLovwRkQuSXH/tlJgfTTfnVGhS4chj2xryizPEq27UfjC4gA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 04:31:08 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 04:31:08 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: add HDP_SD support on gc 12.0.0/1
Thread-Topic: [PATCH] drm/amd/amdgpu: add HDP_SD support on gc 12.0.0/1
Thread-Index: AQHa6UsQ88n281tKDUa6YITBEEkZj7IcxJQQ
Date: Thu, 8 Aug 2024 04:31:08 +0000
Message-ID: <PH7PR12MB599708574DF9EEF9EFF8B7ED82B92@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240808042342.248708-1-kenneth.feng@amd.com>
In-Reply-To: <20240808042342.248708-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ce1c98ab-b2ca-422a-a3c8-794ff9567965;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T04:29:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB8234:EE_
x-ms-office365-filtering-correlation-id: cfc8ff74-6dea-47b8-ba4f-08dcb762ec9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GVkgbnv9DSis/JIrPKdj80GJJGZ76km3feLuoRRy+K9xRTav0N1xhacqT8q7?=
 =?us-ascii?Q?ftElfipj1/q42k3bTu4GDTm3a73NlapWlMOFAz4siNqSrmFoTZ9Yjasq0cMt?=
 =?us-ascii?Q?zGK1KaYa8a8QQdpAT1kw1jRNwK/rOuejJ6cSKMShS4tH8Kp79lgZlbLpjTWS?=
 =?us-ascii?Q?qOQowMUo9HUxdUiMoloGZmjmTTSNE2H5PCh1m1zFywupKifzBCfkHFawgRaC?=
 =?us-ascii?Q?DVholrPFRfA2QT8TcbBUcXhXPWoRCE1HIDbcrN7dMt6QyNzY/feA1/0V2WbN?=
 =?us-ascii?Q?Rr24T4kYZYJ7FlG+RSLY/1dmouc0Ls2M5xyBq2mul0aMl0BogxOLqwtOdNRU?=
 =?us-ascii?Q?O21hLYYh+fJ3OayfbpY+XEaizBhiRfTZo/sILOBG/FosXHsAK0uv9vpnpIE1?=
 =?us-ascii?Q?hivcqEhApZu3lcDNDN4zpZfKDoPpzpoddHP1UHfz3+/bF2rBCcYqCNU3q7p9?=
 =?us-ascii?Q?V1/F/p1I9Of4kt4wLdia1rIPLj62Ggm+8wk/+PLM+rBLsAXAjN5M1cMHhhej?=
 =?us-ascii?Q?uaQF1BgMR5WIcUSG58TRU3Kt9Mot5qQ1FyxexPyQRwpnGV0R7WQ3Rx++bxXT?=
 =?us-ascii?Q?Np7QQfIAOQc8zJHUEnvYbaFWtVD1z6HjCd0R+2y5x9YNn5cQZQOsG+MxoRTF?=
 =?us-ascii?Q?35U0LSdmnRo6v4af9gA/ewDuCxf0gFVlGP/oXU13+NSF5RHbkraxHfTMWZIB?=
 =?us-ascii?Q?EL0IKH2/Vny4wLBONa5JFVFRgJ0+W9av18jjWcfyRVWZlpNDzoyIWHjMEgib?=
 =?us-ascii?Q?/Ni4AumcETschCBItZ3BY97vbjNooLM9GY6vGzJ9DV1Ik4iho0qGPPWvGSK1?=
 =?us-ascii?Q?oLrGpYz/RI7hJYCSQ2OjDZVQt+uiwSkEpj7Yl38Mo7tTrECPVcp5DJ7u/+Ur?=
 =?us-ascii?Q?vJZB/klpv3EjEC3iFqTaiscLLJYzYpWTn3d0+hxwGjWfQvtDiBuUOE4y1i9f?=
 =?us-ascii?Q?BqMr0N5cHaTqXdB8FqaWWRANfxQiP3wBJ2vvAas82uhOE/2HgNF8rJQdU4xz?=
 =?us-ascii?Q?r8PjHJxe0FxJSoPxDj45dBM/S+ckuFJwN5s5eZYDoTdee6qIZyLnVbXM0lCP?=
 =?us-ascii?Q?Srwefqr/MXo6cMc1sb+IqYWg0NOX5FT3kks1PwK7cG+k9n4iPA51AW1SsRLU?=
 =?us-ascii?Q?NxjColA0XWJaTzK0uVWb2pCeaXeIAQuA29Vtkg95KNqZEZEQjPCDNYhdo7WU?=
 =?us-ascii?Q?L1oLAAdRkrEaYFPJqStzu4WA2nlxP9bZ3DbMEUQu/yHb8NBkD/mPKdK6u8M4?=
 =?us-ascii?Q?tEL6QMz0p8koxtT9PEmtkVVikX9AHpSsUy7o1O9KZy802h8oDKUJgP8+fzWk?=
 =?us-ascii?Q?huxNDIkBy+3H4WDUlWPzv0+0ujZoc8oTLjMUhykeSyAlZ96xXAwyuA/FzpAw?=
 =?us-ascii?Q?B2svHdlg9U6xREtVonJkVKpHD5cyg6sODuyb0KaiZEJ/jxrn+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QVRIlBGsYlQTSicV041zSshQRPAQk0VZcHAY9Vrb4bdQXShAClXA0yd/6bHh?=
 =?us-ascii?Q?LQtjn4SKOxGFpHkVr9ldbBTo+WQ2HmFOCJLgS74fkyZChKIwdaZptg0XirqH?=
 =?us-ascii?Q?gi5xnM/pa6CnkuROV0+Mix4NchD18jKtOhEQ+xpua5Ql10YWuvdiRwGkJLXv?=
 =?us-ascii?Q?6U/ZIxVVPkPSGUYR3R+iMKw9KaD8Cjfu9ywSHghQ25Rxhk+mIFYfGYBuaiXS?=
 =?us-ascii?Q?LwJaCZafHro/zMPNNDj9glR0Qo779lhrtRruV8VOHiCMeTY1lTRPsYIuVfzU?=
 =?us-ascii?Q?83Ehf/gX9NraxX5F6QT6yCBS0mnQDVaTqqJnV+gWWvK3ya02/GWflhryxjN7?=
 =?us-ascii?Q?K6o7KjPw0fzLw0Xi1js4Yl33+TYHEaWxz2G0U5OhSTZWPRseUpjs/sbCbbAj?=
 =?us-ascii?Q?9UuA2ZqcE9EqH8EoWyOGr5Yi/HWUcdC0ZIWfc5vh8XHj1sGuSQ+Hpx+psgVh?=
 =?us-ascii?Q?jduEesdh91IOfNYShhcRJ7zjv59+uMwX8Fr3wVLBf9r7vdiSyRm55P00E9mo?=
 =?us-ascii?Q?mxdPNiS47GG5e39aqvBf9SsjOLDSV8jWMkOOzmCBePO+HlDF6Z7pmK3xwnLR?=
 =?us-ascii?Q?dkpYFGceUcwxeTmOkfchaarLQVFTKSLzyOE22MKYswl9g3iDgbx9g8i/qH2f?=
 =?us-ascii?Q?suq4vy4+4ZOSqF9diHYYSP/xIdbNn7+9XduqATml9DZZw5dhufPtHFipZhLI?=
 =?us-ascii?Q?1+oNBtfE4wTMzHdliX7bt0BvH04DDjaPVCoq2mKoCNsiLNyuiipnK8c81b6a?=
 =?us-ascii?Q?Cy5c/nGNHSy8jaH559bY1wXHJehBHdzz1oWkon79W/3vqLsuPsZG4CA6lGAy?=
 =?us-ascii?Q?hFTOsJ9YCcCxvZ2QHEUoiWoW2aYotoFQ2+/bQYoZTcn2xadwG8+xyZXFtMJ5?=
 =?us-ascii?Q?Q4/rtPT15xWU+aVz89zePd04x2xsHLjN1s3yrGk4y2u331x5ZORov3T1j2+D?=
 =?us-ascii?Q?Sx+0iy9T2UtezYeSJRl1ZSkwLIDeuZbtMBmoEagSHX5NHW2XzvtKVw+wfX9d?=
 =?us-ascii?Q?Gpyt0b93fDYu6mGXNdKXRmFSO5To8AXEXRqY/tvqPOVwJPtGWhNJs2fYNAAx?=
 =?us-ascii?Q?gXVaI0LlswFxqR9RJlP8sjWA43pDceuWAkLOSQX1AvxVoOIcNM4IW/IPLO73?=
 =?us-ascii?Q?HtX7VS08tGIEAwCiObR1T9KGK50Q+hJH7Gf6+EzivfO9o7va8+X+BrDBAgBm?=
 =?us-ascii?Q?xHkiZQKZBXQG66+JzXjp0BJzAKKh4Lsy++NOBZobCvle5wIPNbwtPSxSj1w1?=
 =?us-ascii?Q?XMt0axAAn+n+IGfu518wA+L7IUzvzrEE2Qaft5sxHRgLzrSiuFQkJvP4vi5y?=
 =?us-ascii?Q?mrrFhVVpyg8qY5wWRefL+dCAStYbZWCxmm2o3t5kE9QDwM6JZwThB6CS9j8t?=
 =?us-ascii?Q?xGvS7SiLYMFwk0eIKDxW22GSBo6GeERLqGelfXviExK3UkpPZs4PN1ZTHTXd?=
 =?us-ascii?Q?WXgZTxgflxytFczM20N+9goKpooOFoYyHK4LZUffXp7T/3IOGtqugCeLZPHE?=
 =?us-ascii?Q?wVjm2hLAW3fhxBV3tWztQiaOFL/5UPZMqKyl1p9jD1UrXc5fXDdL0XwfK26m?=
 =?us-ascii?Q?hlSAIHIhQ8iDXLUxozA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc8ff74-6dea-47b8-ba4f-08dcb762ec9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 04:31:08.3958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xJptPdtUZFfMNtU0m2t5wiU2gRhZwMfmM44K4k7Q3K4ZDPoZktFmNjYvkBIJ1bR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Thursday, August 8, 2024 12:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add HDP_SD support on gc 12.0.0/1

add HDP_SD support on gc 12.0.0/1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 7d641d0dadba..b0c3678cfb31 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -406,6 +406,7 @@ static int soc24_common_early_init(void *handle)
                        AMD_CG_SUPPORT_ATHUB_MGCG |
                        AMD_CG_SUPPORT_ATHUB_LS |
                        AMD_CG_SUPPORT_MC_MGCG |
+                       AMD_CG_SUPPORT_HDP_SD |
                        AMD_CG_SUPPORT_MC_LS;
                adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_JPEG |
@@ -424,6 +425,7 @@ static int soc24_common_early_init(void *handle)
                        AMD_CG_SUPPORT_ATHUB_MGCG |
                        AMD_CG_SUPPORT_ATHUB_LS |
                        AMD_CG_SUPPORT_MC_MGCG |
+                       AMD_CG_SUPPORT_HDP_SD |
                        AMD_CG_SUPPORT_MC_LS;

                adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
--
2.34.1

