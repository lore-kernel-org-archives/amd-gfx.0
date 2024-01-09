Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3694CC3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 03:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12B310E35C;
	Tue,  9 Jan 2024 03:00:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAB110E35C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 03:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN3cNb7I8gqhYQSFyd1oj64qbsmhoG0jtvNfB7gbe3JjGfX1aaXq3B4jr7z/83zKE+MoDatxKrm+P+GXYIcAJrUDrIwcav5TahxJ+gJc4XqS01FKShOLFeDxPw8j5qy9uh+IPx23NWI0ogBj7IqApWkV+ZeAXgAXglkvS7CExvO0hNU417nFhFqiwjYE3OmmRT7fKlx7JTeLJBi9KFIrNKfZEYOhRODOvhiSzdJkdp/Y7lmCXJocw6obkKeR0vvOVgQsVWGGNvPVT7cXuNmAEF/0CaeutfpGxkcoSkPnA7NzR99hrEVZNhON3JImwqi4pLZX3GEMQiGkq34OsGOGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4Nyaso+qwW05AbYETaIS74+ChuUdh5ofXB9ipsxh+s=;
 b=Y8VuCVTI/BUeDtuotxW5w0kGugBnN1spvLLMWZrqqHjhv2Yn6MT5vlfsXrfZikBEDKDhbEp0VoN+voaVDWiVDGa1pS7BXVySQqHgbB8Ru6UkLT1EukzjrkjDr/W4wGFUgFaFeSqaEaC2uFY/M2WZ90e9IMWn6enbWCLCCnhkXxU0eqpXH/QhosGzS9Y+q4xqw2gtJvJnda3/1GwnKr3gmiKB3td/HeO2hXZ6MDza4vQ33RFTKkO8SYHbodmmfWJ3eez8+T9QC18PutNCCvxtTuKtgnM9iyg7abZhrT24WGugBQZFss/mu1+rxjXkW0U/igyxdsaVOUjmmV3pefSTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Nyaso+qwW05AbYETaIS74+ChuUdh5ofXB9ipsxh+s=;
 b=V9CNVVRnBJlcmSxoQTlvRsC2XKWKmulAgx1Gfvs2w+Yj1mK1xfFWLh1hqCfKgBMJNHCdax121xrW+qK+GOoddbnDOpDQkILqdkDeUIWmL5kMUXSNbFrqLsj3bHQfxAw9zp8/7cSSVrtVzdQTmRSJH2uKGz5bMy7hlpZFyDyJPeU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 03:00:18 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::ec84:35cd:334f:7f8a]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::ec84:35cd:334f:7f8a%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 03:00:18 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio
 v3.3
Thread-Topic: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio
 v3.3
Thread-Index: AQHaQqCJXeQorWQedU2TnFJxIDv+wrDQyhIAgAAAiAA=
Date: Tue, 9 Jan 2024 03:00:18 +0000
Message-ID: <CY5PR12MB6369CA8DD0B5A212D3D84399C16A2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240109020610.1132395-1-yifan1.zhang@amd.com>
 <20240109020610.1132395-2-yifan1.zhang@amd.com>
 <CH3PR12MB807474510A50F20E6A09F628F66A2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB807474510A50F20E6A09F628F66A2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22882299-888f-491f-b062-33000141b489;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-09T02:53:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: c277d705-c540-4835-f216-08dc10bf1c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMsraEhUSjL6mvEQ8Xa4H2dI3qiCk4kV1vYsXTadWBeDmPXY+6A6QQpkC21P6WyER1J720n79sc4X5Gv8wz9hi0QP8sCbcRXJRjWGW86BOIjgl6aEYo58NopSo6crvsuTIuXatYVzJ1ccgDPpHAjgRKimhp3ZC5n3gXstgMK3LtgV/BbPcEe+eO9KPYUbqEAOa7yVQORpU7OwHRnQiLgC1ykz7tTub+HFajKKmPDWTFte7+yR8KNEstRZnnfwouBCDCQq1sYum98Y5pyu3+ktA1ywN3dC1Yp2Zt1q4WypKiLugX0NQnEVMiLmG9XE7ODfRgj7m3PyT1Ep87qwjM1L80PK2X0xXHVHbYhGJKMJffyYrKP1dd5GyJ61ZiWuForge24yZo6XVZ2aT1LYrmsxGKMxu4x7zGKGzPz6McYTcB7LW2/fmCBeOQJgVEOo0weumhs5dKQBRakCNIxcZzazmRnrPEya9PQ2J7qtP8HofFUejkt9OtnezNBxIc/50sf2AHYVjhWZ3iW+xIgZQfkkql3WoQoxB2a/2TszF4a9+TFup7cEV6mWzMxbDrNrsONJNkbobwnIV8W9WXFpWn3uGxq4R/x4o464ig1JQYfxwo/cti3e/lP9/07l1V988CI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(9686003)(53546011)(71200400001)(6506007)(478600001)(7696005)(26005)(122000001)(38100700002)(86362001)(33656002)(15650500001)(2906002)(41300700001)(66476007)(66446008)(5660300002)(83380400001)(38070700009)(76116006)(66946007)(4326008)(110136005)(54906003)(64756008)(316002)(8936002)(52536014)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YF2tQFtm8yvWLIDIyGfLbj3zrIa0P3Fq+ngnqU/PSXdkmHBspah6AQgH3tW5?=
 =?us-ascii?Q?OxHwzb1Qw38TkXcq6aHpi1tADmpEAcw0TbaleE4pb4lPPGmWRNfLTDuyAUaF?=
 =?us-ascii?Q?TRkiaMdx5tM6+SXAA6K6VrJaR5UOLIIbG0miJIeEMVOmyzJB1QwHz9B9Q5YV?=
 =?us-ascii?Q?D8N4Kgn9GaeJQjF+iq+ivKEaaal4UavFwdTdVnrsFcyeY2UUnUhjV+my2x2u?=
 =?us-ascii?Q?URm9MBXhSHlAP4cKJdOz6k7qN0Vea2PRsliEycYmzKGhRmMkrMOLx8SPpsru?=
 =?us-ascii?Q?MmTk7x7DE6qBxxBWFK8o/JCoxSobHYHY23COzYQzvoAblgW91K5N8LhcROKi?=
 =?us-ascii?Q?Cu65Z49zPrdcAaeZokW0dPDe0lOLOlqvJti8lAPqAv31zDPdQxDJK92A49kh?=
 =?us-ascii?Q?SpFNuUBXSL0DI1CfkIxkjDj3aYmzOUwF0xCGZBaLOfTFiR94DUz43sNMCHVF?=
 =?us-ascii?Q?GkAK/ixCnMrbitoQXsuUn7dGRarC71/a0V0DuCzABRgBhtPOesaJe/vprBqc?=
 =?us-ascii?Q?px2VQtOVaGlsSSSCLtD+75Yp+xEISsBGy5D8OTMU2FpypWus+tM9h7KeHkoB?=
 =?us-ascii?Q?ZfyI3FlIGLVoHvo9kN9dz8sZvydW8+Mw4T9Jb8Bu0y/juFjLgyVak92TOxau?=
 =?us-ascii?Q?WeNtaKdAM2gObCrCE594QJnAMgn8modH/jd8VL5cM/B5OaY3nxoI6wOqBcE4?=
 =?us-ascii?Q?KwnthTMZN5MiDAkQi5hNE345wF+k44w3KPJ1ufVTqWJA5NTaasWTykssva1p?=
 =?us-ascii?Q?PSBBJ9JjysuVRx71xOaY/pnG2D5NABfkOLolmmJOOwQ3ibZccLgZisiNkSJz?=
 =?us-ascii?Q?BPweQ2982umJMZprlFMKxD0+dVpc3kUuDA3IEGqF/WnzT0XY21RZRpeZ+KC2?=
 =?us-ascii?Q?STVUxqrdQQnlw+/c+WzUISBzr+zir6wz9/ptqYV1fsyp1FiZvE0g5p3Mwi9M?=
 =?us-ascii?Q?JtODuoEZuQywhhdFlbGhKJt8cBEyz4unW2IEP4HcuwbQN1HtzH0EYDLMw7YF?=
 =?us-ascii?Q?/mUr79rl5lG0ZO6D5+DA9LIZjE7z9JfRn8b86fFxm5GUROhSxSZAOTODorGf?=
 =?us-ascii?Q?5I3REQ9TeB4I+ohUAPdhutJ4uPlpu1rypnsy+KG7QM1JHwbou5hxbWU4mk7b?=
 =?us-ascii?Q?4OevY+/puTlg7qYJFUiq9mv8YB/olonGF+m1s6KZTFmFb2LxYJBxMfeykvrZ?=
 =?us-ascii?Q?myW07GRDcEaSScEXiWfWtdvyQ2SlFTgzihSjavMX4Xv8nxYfWRdChdn4E0I6?=
 =?us-ascii?Q?42k88/WIF0bKo+WJtstoSGFw78KmCRA2Rj7sRgWGJ2e75PJD9YfPxwYfi36B?=
 =?us-ascii?Q?QFrE4zrcrTYMdruIK44YW6y48oREurPuRtWb3dBebbN64Hi6f3tFyTWHbpgM?=
 =?us-ascii?Q?fmUVI+wVYeTiKDHu/3XWSZYQSA2svaoBLn2hiHDSwlqHNyVK0LKt7Pr95Js2?=
 =?us-ascii?Q?vc0vwzB/gnd/hC8EZRwJj+Zz+rBlnbgMCv4/J9rrU5bOzoIs1QR/QVKxmdqK?=
 =?us-ascii?Q?ZPPzJLK+0nJwXEkWwEImgnsJvnRwE0go3PLzPQ93Wmkh+tYgmm5KrtJvUfCL?=
 =?us-ascii?Q?iIQu9Vmpmd1QzQkOz5w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c277d705-c540-4835-f216-08dc10bf1c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 03:00:18.1322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSt6pf+hhM3BDcGuSOf/SINGdYrjCPYNhopA8qtWrKvJUe4hqmgBCyoBT+7+kuCG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Tim,

Thanks for pointing this out. Will change it in V2.

Best Regards,
Yifan

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, January 9, 2024 10:58 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio=
 v3.3

[AMD Official Use Only - General]

Hi Yifan,

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Tuesday, January 9, 2024 10:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio v3.=
3

This patch to update ATHUB_MISC_CNTL offset for nbio v3.3

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v3_0.c
index f0737fb3a999..644dbae9f1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -30,6 +30,8 @@

 #define regATHUB_MISC_CNTL_V3_0_1                      0x00d7
 #define regATHUB_MISC_CNTL_V3_0_1_BASE_IDX             0
+#define regATHUB_MISC_CNTL_V3_3_0                      0x00d8
+#define regATHUB_MISC_CNTL_V3_3_0_BASE_IDX             0


 static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev) @@ -40,=
6 +42,9 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *ade=
v)
        case IP_VERSION(3, 0, 1):
                data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1);
                break;
+       case IP_VERSION(3, 3, 0):
+               data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);
+               break;
        default:
                data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
                break;
@@ -53,6 +58,9 @@ static void athub_v3_0_set_cg_cntl(struct amdgpu_device *=
adev, uint32_t data)
        case IP_VERSION(3, 0, 1):
                WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
                break;
+       case IP_VERSION(3, 3, 0):
+               data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);

                            Is this a typo? It should be WREG32_SOC15. Than=
ks.

                Best Regards,
                Tim Huang

+               break;
        default:
                WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
                break;
--
2.37.3


