Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D732BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 02:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF4E10E2EB;
	Tue,  9 Jan 2024 02:58:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BA210E2EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 02:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L98mI0razXpJFY9DkyqL/4OkswHLCr6gF052d8iuhtcbRLP+vfq+aMr9DN5Eip3CW6s3v+vuhCe1vWbxQ5PGCASYkMc3edAD6nLDsBm4OFjtN+J8iqDY/KO8E/uxXcFOd0wPPqunkw+VYvHzYWITPbi2v04j4v9csBtVGBsED9mDeyu49EuwQepeuPiBJnuwk11VDAGDM3+hW0GvW/PGpCrV14lf5kA4RVHTh0Ikd21ewiUH9Omijb4ogGdCWJkSArYAG5EeWEgmwjW85YqWVHOINnCVTY/xcU+cKikPRR2N7U3CwNoyPGdG0HFjg1qJTHDQbPjnxZeTGbTd6nvJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMJa8mzRSts5Oy90/fZhJ6y93DGGBAZIjoEgcHCNWFM=;
 b=PljsbA+Goj98vUPDt/q4uPuW5pF9FxsgVPo1/czs2C9sAcGGyG0ljEloFb+7XNs6wOYpkgt+e77pnIDPRWRqBbEVd4catPBnEy1vc8PhuzKaHQPaJc/Ilx+JmHIi06PEz896lw2n8xfOi9JUYSa9rQ58rsYCvtYC37bYg7Laqvw0tyGXScBV9ql4TLPTe89Nl3vhbY59F+lJzvucpUCGwrq08A6ZJze8gs3Tumx31CvmiFkFKdyF0rpJj7M0KmXVcb/xYDE8LjF/xhnI5wCaCaZgKG4mOkOjJpKrv/PSk6So9Ge2RPdcs6VUS2V+IyAKn5e1uWiBIXTxAhHj14x+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMJa8mzRSts5Oy90/fZhJ6y93DGGBAZIjoEgcHCNWFM=;
 b=N6EkKX2uVrcBZpqGIiEl4GlYPJnJK6raPLTdyhh1+Htd0FgLLjmBJJ8j4XmS8ES0agqALtHCwBaRCPEsFWyoRhlSE8kaQ1qTvShntPZUzUvrAUhFWyZCybqbOn+hkToWKvjGB514xirAo8mDS3FH3GehoKuVbZxJjaetiuuMShY=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:58:04 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::24eb:726d:b108:e03]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::24eb:726d:b108:e03%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:58:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio
 v3.3
Thread-Topic: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio
 v3.3
Thread-Index: AQHaQqCKRgrj+dfqvUCTD/Jlp/G/mLDQyMUg
Date: Tue, 9 Jan 2024 02:58:04 +0000
Message-ID: <CH3PR12MB807474510A50F20E6A09F628F66A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240109020610.1132395-1-yifan1.zhang@amd.com>
 <20240109020610.1132395-2-yifan1.zhang@amd.com>
In-Reply-To: <20240109020610.1132395-2-yifan1.zhang@amd.com>
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
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CH2PR12MB4120:EE_
x-ms-office365-filtering-correlation-id: d4008d49-d9c1-4f3a-d945-08dc10beccaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSOHCzppf9zvLvhVZK3yOlKsJCKmzksVg3Rvy3gCxOWBr/oKVe95X/ICOGBII/52+XQpH+PLNx77FkcP4zWRjP9v6XFaVfgMiCos21x9Tz8SXeZE5wGO3hmE3B67YXYT8Z4plbAah4CmKPCN7ifO7oq4sMgCa06kdBeuX1OXxiN1wGRQwKhimTOr3UDdFhUIqQeOJzUHorgyBeqSex/gm+DHnUQKcvcjcoUOEVzd9erXh41HuU9fnc1zTGcSu9IuL0euCh/56tZ4wrNiqGgWPTQPgsRUiCZyiYyRRJiMnklXfmOLUXCn5ywN6WXZzOkTmbJiSHPOwlRG8KHpTWnReYv6WfC2e4fk+rDdzgvt3wHDYAlE7Ss8O02rlQimZSqpC3A4nDVPUAl9lss7yi207Z7Tx0OkqeAn054097+kFJdnEoxsztN3GmbP78GY/rPnIhtrG+NDlsTfCCCWI6xTqAPyMejNM3CngZV0bnHblpm09la/NnZQrfMt1tyOpqx8w+iun+rIYx9aKqcT17OEJTkFf6RTwGXhazRd+U7JGCpul+aqKx8C5LxGY//zkaRnjxNQsFpiey/tmR5URf+8zpFG1ZZ+FzSlCQtzqIbeHL8jjrJiZ6n0yjWeHnj9d6+b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(15650500001)(5660300002)(2906002)(38100700002)(41300700001)(38070700009)(86362001)(33656002)(122000001)(52536014)(4326008)(66476007)(478600001)(66556008)(71200400001)(55016003)(66446008)(64756008)(316002)(54906003)(66946007)(110136005)(76116006)(8936002)(8676002)(7696005)(6506007)(53546011)(9686003)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WTbVnOAaZqNbPl4S311YJrbJmcwgUT0l+jSMfgqaDtlBgxBamjYtgCqVWpsW?=
 =?us-ascii?Q?dQ6iEQCZGNg4T2Ycrqiasy1nulDuW7Gy/qxzUvMe3fS5/dj+bkJw0tXirwgc?=
 =?us-ascii?Q?aAa5+bg7NbiWHpWPnoD9f12F2wHhwyNBkMzp0xSrEaCGZOFNeVi6wxnjifl8?=
 =?us-ascii?Q?RH8dJ1L1+cCEs0Yama030GoKUJwD4aEytwFkoPz3rlVhaWXpCfeEmC4MaX9k?=
 =?us-ascii?Q?dpYup5zTZpcrESse98qp/psUIBWHAcv9NmS6K7legYxyUcPhHhJpqB/U1R2j?=
 =?us-ascii?Q?hGddcTldpb25LfejZH1oRFoY4W6Stk99QyR0SIvh+88L7+15Yk+LfmQAum97?=
 =?us-ascii?Q?PhS5MMMLb10JyNNG55vPxVaCyatarti70zUAMTuneYwF9Mhpvd9dCFg/xKXt?=
 =?us-ascii?Q?Ebs3coFAjJsKFcEYHCBKmNL6J8nFA4A+3mDzQZszd9kHCzi6uJtOPBax7fD+?=
 =?us-ascii?Q?YciiawmPgOZN8ezVmXCRM9+sfMybPSGpwEdwPNMP+V0j+xXPN3oZ+JxneHoN?=
 =?us-ascii?Q?T2SpM9qGaWbyoA7oJgIWoLY1hmUzBNU/+Ke3WSlP6PcnMYnTHutuLIlxLhIS?=
 =?us-ascii?Q?vpYSeutYgFa68Ru/auiNw/9V7XCZhNoLjdmPwoUZ/zWhfPECX/v2sK1watqi?=
 =?us-ascii?Q?Wk2iGWLITe1cG1SQY7BNe92x6G3QJVEm35sYwyAAmEJkXQ8wWFpquE5A6jfT?=
 =?us-ascii?Q?4IbHGLcshonbU5jV4xaS7bapTjg8rX211ciYevsQY874qfmZzOfehhRvqGOp?=
 =?us-ascii?Q?i1CO5M2apiM17ijiUMK0hLG+O2Lm3qQkNQ/iLeDApuqYfQd0bd/FDsrKTROu?=
 =?us-ascii?Q?fWKrkDJf18YpkNo2Ik+YpKz8UcklhwMJyR0U+ix9nf8Zbm0mkaVSG8HecVM4?=
 =?us-ascii?Q?UoND7dL2XMEL0w6vMDr6AESlh8e3HdRKyE+438TBBx/HEg7nwcTBs9vrkD9e?=
 =?us-ascii?Q?AXo0hcPsHi/+ftHZPtHvcE1XmbTZnVLCU+zH9OEeAOiaDHe6gmHRiMQDp0Nw?=
 =?us-ascii?Q?JiHyFn1898o5WM7TO9SlqRIf9trnMvoygeCn7cZr91o4DjKoqDq+fI1GL9le?=
 =?us-ascii?Q?868xs5+pBYtfvUjkACukWVE658eAtOrEXI9kYR2N46KBVhQ3qjO5Zo8ymWr1?=
 =?us-ascii?Q?5lWPfuioIW0B1oskzVjTAoUaEWtVzyGH5zwgNR5IDoPmeCzUPu5g2fYxKWTv?=
 =?us-ascii?Q?WwzaTBd3DvKd8mfHPlFXF9SXzGDXKjfQbnOhj+ylgZq6YDAxaAv7wh16cG6Y?=
 =?us-ascii?Q?FTcFKikAfe9S/fuH4LBbv4OGCzuIuq+hyVm5f5WfhC26PG0gNeeIurPrzUwu?=
 =?us-ascii?Q?FXm7e5KZUIJ/yjgR9B4bwDz7Sw0iELhq2r/55UQrzqHz1Q77S8Ji/sYq7C8L?=
 =?us-ascii?Q?jXDWs5nJazQCkc4jrzXk/JmQFDjM5mFMk8K8BXkHjTIsdF0spQ5VD6gnZidc?=
 =?us-ascii?Q?qC1YYHLZr4KyIIiL6spubbykRJQgI5Qv/sHSSYc0pJYRnaT9zdpU74rJ5XXN?=
 =?us-ascii?Q?E11HfDZTOHeZw6LO6K5MQpvwAj8P5/G3cYhfaMn1pYdLfpwWDuaaKF0Mmy1e?=
 =?us-ascii?Q?tjF6RpYy2jK4e32nqp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4008d49-d9c1-4f3a-d945-08dc10beccaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 02:58:04.3254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qqNlsAOkv9vsGSYwvRoV3wE6AaSROOBdH3a4slXFBepsY//Gn6X8XMbK8nprh/hAS4Dp2Pl5Qmvlk/+jfCs1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, "Ma,
 Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

