Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB3EC00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 02:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD64A9AE80;
	Thu, 11 Aug 2022 02:24:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D16D2A5D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 02:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJsF7P0TBbVE7Md5xCg56Zex4gt4rPu8oM/BMxKmfdVFysHrORkYhzBidcaMoY5i5fKbdCE6o2dTa2ID7qEQCss33HrzCFWuIdAeRc9AXCmcaaOQGvkOfjOqvC2Upxf+PS4nUH2m7u0mp8VNnZ2E6IF6frmotLKv93B/9zjDkLmY2BrMDY8hcjj9cFtKZXKflxAjSzU+BIW7fBa4pJnXJSkDES2fqd7qnR+7BFK8fa9+bfLdwNJJC2W0JKdNfaLxF1Un2g+7cRnGCtwmSy5wpgcO4hg87V0NmAdfzcdoaf2dG0G749MwN/BhUk3COujbCOc41JRI7vlAyA1srF6Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iQKWtyW9qDuXsvz/674it9iz5Q4j1n7JHwbmoGva/k=;
 b=INHpxJ2uilBu6pRxu3YymavXzhofSmzMmp4i6x996izz+uXJLk6o528HQpx6xj5ZgcLJWJhtVICOzQac6hJBBo9iyyq1yFYppwWCjTnVuWYrv3tOUqIM87DD+ZqDmlRbSewd4lxu9r59oLJ2Yz/nyKqr3iAjNa380mS7LQ6fuza5ydIiMWtbsT1yPAh6rT/FYWk2Xnduvac/rXrxUUWAUhoDHtuMnZbEoKKV6o5VBucFQ2hkhbxtEGfgni7/+IgqBRbpSuHhxsJlFQRAaa2DopfBWUGvIWd/jdhw0Qwl4P4UnICl5IJ7ae1SrCmiHuR1OBu2L70dhylyGPoI4j/44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iQKWtyW9qDuXsvz/674it9iz5Q4j1n7JHwbmoGva/k=;
 b=SE+lbCdE1ik5ZmmIzintk/6WW7r2/qjuBasLooEi5X2MsNaXf/Kz6SN5Jndy1YmF7u1ehTs3Dd1dLakYbPB/Bz1n51OqkborWbLv5DCkfdf5abCUAc/g+hws16+3jvilL7ClUad/gavMMrxf4QCvFlXPpspkbURdyiPcLSPNsgI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 02:24:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5504.020; Thu, 11 Aug 2022
 02:24:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: add ih cg and hdp sd on smu_v13_0_7
Thread-Topic: [PATCH] drm/amd/amdgpu: add ih cg and hdp sd on smu_v13_0_7
Thread-Index: AQHYrSSvY5iqAHEN7UiZF4idD4Ieka2o+I1g
Date: Thu, 11 Aug 2022 02:24:31 +0000
Message-ID: <BN9PR12MB5257B16EE075411559C12952FC649@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220811014934.1140719-1-kenneth.feng@amd.com>
In-Reply-To: <20220811014934.1140719-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-11T02:24:27Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ee2ef19d-c87a-48ac-acc1-154eda6bab6a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85fec6a9-21c9-44a6-d666-08da7b409fad
x-ms-traffictypediagnostic: BN8PR12MB3378:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3Gh9JXYBu56ROs0PyBx4B6w8uSbobuQ7P0Zgy71KpEsl1n/+P+oPK0fzlWTqwoOvDxEipCnm9fOUMfNGfxsrZCuB6gRB6x2UovVSpgLINi1V8ex0tV/okDlhsV6sf8FNbDxEtkRsdh2GuYU42+9w4JkYfcr/R3wfP7QDsbTRh8bQr4Din5K+5Iwxl8b3LaeYiagUBJGAM0zdYBKhQAGB+jiXzuwbCL2cGF2H8mBt3Kvq6reRLFDTJinoX6SDC3/OmEZHDnBsfDNFQeW7rXMMNAW7xNejzsV0WQ4hda6QRXIGjwIrCMPMvqsxVpCoQ0OLh2hQh3STnECuiKuZ65yO3rL6bktpbLJAJ5UKSw2YytI7BD5NeCEZNQlwVg7hGS5yOL1X6oTh/qDSE/++Jbs/m3UJkdsYE+9aBqpw5LwfLpv2giJCqCZCPkjUXvWjtiKizQe1nIEfScv2LlEVTk4D0Tlz9pzfb/JalmGDVM2TakFf8n9CeoxMdoYsAJdfEaxiE4LQbyxIKui0eGdHHGDLnM05INPHzIDWHf3BjKFm+XMriHVvT6cdBgTv38oxVM+2489QK5NpBWyvlEUeu0S25Zu7O9fAb9d5ylb434Un7FjXqnjubu+mh8S2lQtPuAN+i5V4J2DdA0sEgqneouR/tE6a+EbXS0rDe8Kk58FbHJKbmYoYB06YHMvu6EsBUTLICsFGLtn07fNuTcAGaOKB5Bn/qAnnvo/Rl/icuQ3qUIY/iZoNYRWTMuVkdRLJauapCAWZ7vZezTKiCtUiUEsSd6k7DISxYe0riHavBMCK+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(186003)(122000001)(41300700001)(71200400001)(5660300002)(52536014)(33656002)(8936002)(83380400001)(86362001)(38070700005)(38100700002)(66556008)(64756008)(66446008)(66476007)(66946007)(110136005)(8676002)(478600001)(55016003)(53546011)(2906002)(316002)(26005)(7696005)(6506007)(9686003)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HgoGM2gpyC0cFp5ezJ/AVrLcG7SawnWgDeTUEljQAf4BDkID6jI1tX6njjGv?=
 =?us-ascii?Q?lOiEQZlGr/jHrLkFekA1kRfovjV5Q9DvTYKi6ZWPbR3c3v3gUPOLy2jUWID3?=
 =?us-ascii?Q?9hPpLmQF6eroOYiJWpQCC40bezlddYfoABrwi37eZOqulaxRqztAHzwHF1f7?=
 =?us-ascii?Q?+vWKWmKopaDZgxxZ0eiYIOqRCGBUUczSYcfrpLQgdsN2fwa2dQ1+IvmNHtVl?=
 =?us-ascii?Q?qa/SeGXccP74pIuGuHw/5qTR8W63J0mJLxTdN+dOl7h5sjE0Mh5tc+DuE4Uc?=
 =?us-ascii?Q?ClzGXvDVverEXPljRD4CdDUOL8wlPqq7R+IG8rwRbW9p4ndHxd5pb4Grmzom?=
 =?us-ascii?Q?ROAMcNojvj8CeXh5ywVHsrXuz1kZSjsWK4Vw20VQU+gizQcRjBsvRQD35JTB?=
 =?us-ascii?Q?BKTPBKtLFtynYjCGLkIX9yb5a2Z7a7fdIGNikamn5sCGZB4pXoS9UjCQgxek?=
 =?us-ascii?Q?YfSTSjVAM3OptVBdO3U/Rg4hIP+1/H00lMsMaSoXT4J+V4NxKLaKy9unOinx?=
 =?us-ascii?Q?NJBNfEEvjH5xFBNRS56VgdoRMfMF0HG0s9ZqNd5ExpeCO4y3NDmsMPiAn7/E?=
 =?us-ascii?Q?uUvShjqttji3fnfqQtSzQ1/4NWlTsZg29WsRwYIaKRCtJkhi4LtkYfC9qobr?=
 =?us-ascii?Q?yE6Q/MYN2gfeuORLIfP61Z6u/lR7lZCA0S5/5tQgcz9Njxbfz5k1QpbyiAVB?=
 =?us-ascii?Q?MVKkeVcOxPEOVpc0VZpOPM3MnylsWtMpPfioMHvAlCLhAzWIfe/Swc35WoHr?=
 =?us-ascii?Q?+XjlGS5FFL/ERl7Jl2YwvgiuvNFrokvZ35rMFaB8mZjhvxHH2zNAyiWXVl1y?=
 =?us-ascii?Q?OO1GlJq5IpNSE3V1moTWv1CXo+r2T/hRevn6pcdo8UJg2/5ehx5dSsHaG2lW?=
 =?us-ascii?Q?/y3CK2H/pHdSO5j2iBzlz+GAyrJXT1g+d3D9n8Qt48STUQ5E4Zp9bK56niEP?=
 =?us-ascii?Q?b+fceOLhDEvdBudz17pyscVFm0I4e3jAn470Quda4SE9je1Vb7PJ6rdXhmk0?=
 =?us-ascii?Q?c3McmD7c10Id6CUENJ+5xMwfjy2MNd8FeT/wIDmSD/FAlDfJHa8/H4Y8iHHy?=
 =?us-ascii?Q?/epyz1YASqLBWXgyuAirNLoXvbPsDBCSge0FjwxX8RuMBDPosDWlsbzv4heW?=
 =?us-ascii?Q?r+cQI2HegNG5FtxrfQxILBg+kqQ6BBvM+mUcBPAk9LCCQjc3MXjINb6z2CKI?=
 =?us-ascii?Q?I83/EjHQRyZxBfe/f7LiWvVs/jKB/YkodVvyU8jkxZzDI5ajB7fmdD8BzBZ3?=
 =?us-ascii?Q?ZC0nbdrStk/tr24ZVYMroFNTSDccJTd2LM6vVlRMfN4vLAeXpC8iDIZA9gsL?=
 =?us-ascii?Q?JeJqLrZSyQISQXiBElhaL+AylToPRZDN5X9URSK4y4y3GiVzJABRwFStxXJk?=
 =?us-ascii?Q?jj6GWOiApqmHUaSebfeFTUhXeghtNqlW/IzUbOgf6nCT1NxZulr14GtoIbEm?=
 =?us-ascii?Q?ijhTPj4XKww9MfVKDPgS/xXDdkYVsMye6EZ7OnYz902pvun0W60x6Adj0Hg/?=
 =?us-ascii?Q?qEwTgkHExxhD9fQoEfIgO9GqE9wgFZ8siqXMeucZG3GPtb9YtBqQnE7eVM+S?=
 =?us-ascii?Q?PsBicFNZs2QfG6XBv5K+WLmCjVJGhJCjvK2F30O9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fec6a9-21c9-44a6-d666-08da7b409fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 02:24:31.3127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RJ63UNoSwhGPxsK4/TJaDWZ/U3b8FXSoSoOya23LEABjtMt4K3M7ywSljT3ojxe3kztl66ZUNM3j6ah+mhI5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Thursday, August 11, 2022 09:50
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add ih cg and hdp sd on smu_v13_0_7

add ih cg and hdp sd on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index bbbf760f8ad2..686e17770c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -575,7 +575,9 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS;
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_HDP_SD;
 		adev->pg_flags =3D
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
@@ -690,6 +692,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,
=20
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(4, 3, 0):
+	case IP_VERSION(4, 3, 1):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state =3D=3D AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
--=20
2.25.1
