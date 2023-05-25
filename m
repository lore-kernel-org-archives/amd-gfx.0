Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACEAC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 08:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C269C10E7E5;
	Thu, 25 May 2023 08:03:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8640410E7E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 08:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm6iWw9aGsJ5pkQZx7DMBVSE8/O658b7dPXaDHUlt7Zb2z5r9IrTgw5cS5LFuM/FvGWP/JEfrY3nm2rg8vQo9HyWgx+EDwYEcALjtIpB6GPqfWR98ruJsPDUTYnkzBQA7iruMptwpIBFTHylornLKgVdXg0gu85VtWS/0/iVpqTRlvBl/98svcU/CFHtMKFMfFo83iwZ1Nih05WdzzRt60DnQifD5/Q/zkV1YQoPnp3QlqWn6fuecV1s5lAF8iVXzxr7AwFo55hjvUshJwCgo1vmFOWNdo9w5JTbe/lj9TXvFbcNlrygzIPcTRSR9ViypXpB47xZOxRV7wF6h2+7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbz4fwjAiOArD0d9Qoy1EPcr+I01bT5kBbHgRdkLkgQ=;
 b=FBezG8yebZgN0rD85kZSKA589wfQZpKlvhmaNsY72cTdY0t2tOYyUqf2pKx/bixkMedsk1Kqpjz1nE+NNLcnnQX15RoqSPMHVz2w6tXWfrQlCyEUr4YNwtX5k4kTJ/RII35rLfAzK7jo4AdZcHrDzQhF/Dm/le572ubGk8BXK7jwDqO7Aa4dP16Tu1Hl9wrJH9FdoRsIuEL2vbyLs5N1qSZJVAFb+8YoJO9GMpZQE4vimy3QW+2pYbmvGs5la1rAG18XMdVl/0sNNx2ESN+oXD2efh5y9M4BaOkgUIeWcmgOokja/U6Stjdfpnbouh45HX2u+5ekvnvSiPG32SH7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbz4fwjAiOArD0d9Qoy1EPcr+I01bT5kBbHgRdkLkgQ=;
 b=oY4XJ23Lr1ZJAnfGqbCRob5tqTnff6g0Erz1XI1tAqxkMnLs9SIaZmEF6bdHAmCCj+yFDLEPAFzofJNUpiwG7cIV3qhOWmSuTCw6RmvgmVyVxxekNdhNSEw3L14NWch9rRyQSUspXV4AIKuDeJPVGHOLBgzarm1WCPiiFq49PsQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:02:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99%3]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 08:02:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: set the APU flag based on package type
Thread-Topic: [PATCH 3/3] drm/amdgpu: set the APU flag based on package type
Thread-Index: AQHZjt0Wqkr7m+s2hUugGNKPXMzFmK9qoMzg
Date: Thu, 25 May 2023 08:02:57 +0000
Message-ID: <BN9PR12MB525748536E1E0AE81BA1174FFC469@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230525074545.24166-1-shiwu.zhang@amd.com>
 <20230525074545.24166-3-shiwu.zhang@amd.com>
In-Reply-To: <20230525074545.24166-3-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-25T08:02:54Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e588b793-1f32-42f3-8734-d61a7fdd57b3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV3PR12MB9167:EE_
x-ms-office365-filtering-correlation-id: 41e373c2-ad50-4d8f-757a-08db5cf6737b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42AnNz/bYNLMPZCAQ7lqcRulAp+nFwDvJm3yRnomzBPYL6sM0Sqo7bKpCvt3iVAaH3F4l5QAm9afpZe6F0qU+8uxGeAEBY4QTXj+rPc01cbL42fO0BlCS2Lf+ZZVyhG9IWl+/apqrDlx+h+Q25lZ0vqadEuw5djcmLJQ3sVSiVDs7HbJRHd56vTLKQI1vOg0XBGWbk/CC+mgN4wAfcvvJFKzDMVMCPJSfhWTa9GoLvfNjUomkxh4b/Oyxo1CLGTUvRd8WWvig05a/peBWurCSzHQEVjLVrge7pHc8WKV+WD5Q1jy46IWHQVO4WJAQ1PF9LGt+GTHQhCIPvFb2Z3xPpDbJ4vvHbuYQVFgLgB7Clwx4Q9JQhXS74ksRaAAQLZ62hw12nLq9OBwpMS0DXX6rSlHBg0ad3d9r6N8gr5WBkSnX8i1WldoOXpeMWxupHlZ5vwFjM2IGEhCP+ci6O+9IZhOHSaYwaUfdfgvR3j/1c6Ri6WzyUCZ9ghK3FogVSvi+oEvnjIWJwYFpqs41w5Q78lVPd46SJiaAySEBtv+Vt1NgisYc2CgMo5+gY0s6l4p3mY9ufx+Nzu6Vw1md46aqhKNJD8Uqg4tynYCTZPupKfVcnT7AcZ8cw9DUbA6LC1u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(110136005)(38100700002)(38070700005)(122000001)(66446008)(66946007)(66476007)(66556008)(76116006)(478600001)(86362001)(64756008)(71200400001)(33656002)(7696005)(83380400001)(41300700001)(316002)(186003)(2906002)(9686003)(53546011)(26005)(6506007)(52536014)(5660300002)(8936002)(8676002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YLgHjrved9q666CivmN45XVbP+FpHa7nY7AwlhmQMgY/0IMWyaI3fFFB1Sbm?=
 =?us-ascii?Q?eud0OyO5SFAz9j03wsAXoXcjIu/PRZAYnKXvogXUEgZkVtwcC8Phwmz2oGDZ?=
 =?us-ascii?Q?RHcWzz8suDIOBh978DJuP4NDE/mMvD8HIPI7rpNjjGQuAeJsni2ELJR3lhM7?=
 =?us-ascii?Q?9efbo+4QHvVDyPraB7lbP1hfVdGn6bba2px/S5NdxQNsHFZcN7cLnsrlPIje?=
 =?us-ascii?Q?iutF4aU06fPNYI93sRvnK+sBf9bYURNq8Y2138EfqsuEHZt3vPRDGMyzmx8B?=
 =?us-ascii?Q?6v2OcfiLyr1kX0UFiz6xjR0Ixuv+QXclBpNkXuzYuKWyH/CszdRXFruXWNGf?=
 =?us-ascii?Q?n5264gkCXzF5qBgtqDS+vskP+Efl92/VIAsXnxXmSKd5Lf1ZvUzwseCrbkDa?=
 =?us-ascii?Q?5xDsuqwYms8oYf6t30JHNNvTFYUaoM49Ec6+4jePBjq3QBZA6d+S4rwtnb0o?=
 =?us-ascii?Q?7eG76ZqVlLwLFcOE52A5ifiue9ZUAOO0jHzempWVBo8IVQ0Wxqo3rdwCqPSV?=
 =?us-ascii?Q?aX9uDFUEFgZqqRfLoqYpjCwZZqx9QAuacFfouhJqafCxE/F3WBzfdmXOLLDt?=
 =?us-ascii?Q?BvjEauWglnBNMY38j8IWH1pzD385a6MJIyVlvH2mUpJ4hWoUNtVaXdDK7dnk?=
 =?us-ascii?Q?UPncFHZOkYXsAa43ym7fvyA6q9R7eS2HMcgbxcg3ECF2v+HYVFcVhD0BOvdI?=
 =?us-ascii?Q?zlQqjXXGlPxn2EuyYmdFz118guI3KIvBuVORKAgC5CfRC1vD91HmLWx+cg7G?=
 =?us-ascii?Q?yTeVHov9fb/asSEeT75rtMCVGFx3KcG9Zp79NTHwSKYNpENnJyGQ2N5hu+Cv?=
 =?us-ascii?Q?IropZwc6KcVMMwWumsuQrUi97Z8VVb9phcUyspJ5Tom+kZqTyewQA4VS/R6m?=
 =?us-ascii?Q?qESUzrB2tFjr+PDY3PVGwGJN84GojgNfqDIL5KuDGzXQ0X/OCa5wrTuCgMDo?=
 =?us-ascii?Q?lgyY1PoKZI9Gwxlsam2q5Wkzg5FH7t2k+/w3VnTq0XO+FKCWj1RLxoaFh6xC?=
 =?us-ascii?Q?SJQzCp1qigxyJPZb2jtFMPslcm4C0ZhMcEoJFcir7uynjC9TGlPaCFqDV8LK?=
 =?us-ascii?Q?B16aw8inxwIq5ZqICRWZUQvcGaqowfZNB3GDDHMYVrFZQotFp0zPysxJ/QhR?=
 =?us-ascii?Q?Ry+J148tEyAarTOBIqULyC0MqlMlQbwI43OELIl6A2S8M+SNBqNbIxGk49Ld?=
 =?us-ascii?Q?gjcEMIANZo68vGLOcD+DjcDrX/d6USxNtIH/qBtXyFTwvoWP2euNybuVEFwO?=
 =?us-ascii?Q?tT/VDMPJM0x4+J9zXwBVO8yZBSy0KdTfMdtNZ+jiCzxQfA/+GBd2+YXzUHpy?=
 =?us-ascii?Q?5eygwRNORnAnbGZcQ79q3SBdZ5+I8FeqkzV59OD2IiJXVTNg6M+4jkEF8xKE?=
 =?us-ascii?Q?oVwoU58BvTkUsYbANOiYRg5UT3ax2K76SFonlvwy1fmaF2b0XFUroQq5vDZ3?=
 =?us-ascii?Q?WU2aQWq7FxB3DakTeRkKbRNMW+FPuEoD0dlbdaXtMoKvGVbAaMudeH46cAfq?=
 =?us-ascii?Q?DVzP0Gut/j4TFarPoRZWSe8Omf+S+aeHEpjCnYOQk8QKd0YzpAY1XDpvn11x?=
 =?us-ascii?Q?V+MY1Qcu4WNfVo+prmxF6OVvhE2pzDGiNmw8ibE7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e373c2-ad50-4d8f-757a-08db5cf6737b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:02:57.1645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1U37BSqD9ZAv0xDT1oykzakHuMHJNeJiVLyolQubWrmugntqgdl00hmXRqb6s+637COIH7LWntHp6YO0TFNRnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Thursday, May 25, 2023 15:46
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: set the APU flag based on package type

Since currently APU and dGPU share the same pcie class while gmc init needs=
 the flag to set up correctly for upcomming memory allocations

v2: call get_pkg_type in smuio 13_0_3 is enough (hawking)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index a0685a5ebda6..859882109f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2500,6 +2500,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
 		break;
 	case IP_VERSION(13, 0, 3):
 		adev->smuio.funcs =3D &smuio_v13_0_3_funcs;
+		if (adev->smuio.funcs->get_pkg_type(adev) =3D=3D AMDGPU_PKG_TYPE_APU) {
+			adev->flags |=3D AMD_IS_APU;
+		}
 		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 8):
--
2.17.1
