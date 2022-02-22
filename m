Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AFFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B212210E782;
	Tue, 22 Feb 2022 14:47:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED18210E782
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRQHxGDS34IwBcaRGY98JBmd2/lDtyKgOrlnPVSNDMsbrxONunq1BP2lCXloaLnwGCQ4UeE3BKYhEWsjdbv3IwFjbTBevW0EewP9/eeWPLQdBc5jVQn3hSwuePTfQCbPquMRENSOBr43axNsPBIQBq6EyGHHKcUOIDArk5JSsYzcpbQYGqrjXCjr89n6wCW5annWsEWD3UlIlRQYxAI/QK2lMPhbJrLydJnLpRz7GEjZcemH+zKtESm2aXy/5n+WPEw83V+4jqoCQdByCYbfIOgmo8iIjarP6ixP93Gz4p8KSHKTD1hrbX1uRMyqxP6dzWS9xM2X3VY4pOCAS0JgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjiAFJQX8Qs6DIJ2O3gOJtTsyWtAEULJdKByWGp6KVY=;
 b=e4WRaXEzyQ1GYYXONTDPdSv59ScOCPN8lOMejHuNoTp7WNpy2FhgindrPeEJfQzaPm5GjmeG4KQ+rpZgWLSyav4iLQx5MFMzfdeq448K9OP1bjZIfqEWn8gDWXc6MM4kPISOzG9OsvewBm5ywAM3syMfDW6XyfZ2L2J2r8pOXV0nxEn7Isu8FAPMhPIgFjDiXPXkL75cD1fGcQecDnAOt1kDLEc9Owd3dr8iJnv0eUgIr997pA9RfYbdjCStDTOkAv1xCHNVZCLt30nRIR3t2RVczu0X8+vbYqJv1PPUkNBBPuVeadVGg+oVdRZeQ//rFQeFR2LT/EFQyLfnPTWo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjiAFJQX8Qs6DIJ2O3gOJtTsyWtAEULJdKByWGp6KVY=;
 b=P4NqCAsG+NRJ50/ekLhX/vNkIgbax3pjElzrdrOa9qVTUTrd255bWdx5oSK40zoe77pVxj/9H0hkJr/fJHTkXVpjDUx2jcNJ6ThA600SKJyeCF6s5by3sBndYAefu8vCN56pn/fzbeRkGTQ2HUDtKQ8bo9s1WcB+ebvmpPZ2sdU=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by BYAPR12MB3093.namprd12.prod.outlook.com (2603:10b6:a03:dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 14:47:44 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0%6]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 14:47:44 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: split dmcu and gpuvm handling
 logic
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: split dmcu and gpuvm handling
 logic
Thread-Index: AQHYJ1za8Fonys3VMkSN+4h1S8X7rKyfpugw
Date: Tue, 22 Feb 2022 14:47:44 +0000
Message-ID: <BN6PR12MB11870C2D90FB23308E7C0D81C13B9@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20220221195355.135192-1-alexander.deucher@amd.com>
In-Reply-To: <20220221195355.135192-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T14:46:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c7fa33d3-a626-41f4-b35d-026c5d6b8bb6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-22T14:47:42Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 07026687-93f8-425a-890e-c0faf7342dd9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736fd74c-90a5-4137-a3d0-08d9f61248fd
x-ms-traffictypediagnostic: BYAPR12MB3093:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3093C6DAA694AE98A62FDFE2C13B9@BYAPR12MB3093.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: haWKOpESGlRIQXgZ5aWUG88sEWvEhHDF/8tUlS/DhD8obrHW/u/1fnw9C8j2pUqQpdP3nl9d1ss7wuqBoqMc0Y2czH67/K7w1LjIdhWURPAe2Vvq3ezkWqhiXSD+Ho9lCH8rG3XzlywL0tpq181lJztFXdNI8evNZdQGQCeDonMHWjKXKANKdbH5iX/8o20eDVLGoUK2qNuTEqaOVJeN24C5SkDUD4KgmOU7aSQTa/IbeMNGbpqHIFKQbKzrZIRs7BeSViF2AXxTnRNmkuRY3QArfYej1pq+Sb/MalnN+SBL5lcYgrBhIL/VD56qL1ufdyP9bnmiPawPyHSqVMmG0UqBHVsxmW0Im6RX931pwi8rovvhgbbSuXvUeqePEt7lpUEIwen8z+OeBkwB0AXSQ8UlDGf+lkxXTYKgsw/Iijl7hpQLD0rY04kfK7+1AOx7pz4q6olfXUDbxQfapLYegP7S68RvrDtWIDHKjIgBt7q4M8p2L5NkaAyR41L6y1YMuF3S7GrSog8hyIcK+nBRWKukMSeRjsb5K3z7GqVTi0MazZRho+favdnKeIy4E9+g2+tleREZyl09n+IEBWSHzpUrQ3TmcOb4YB5SYRup5shPD5PAXNpnFG2TIQ3Uz21I5C1ByDrQqAflleuCAVR5RTOxDQvqqO2DTp7Tr/rlFWFCMZ22jnZKjwxeK+42BjVjANNa/UQIOeIYogPja8Yjbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(76116006)(83380400001)(110136005)(38070700005)(316002)(55016003)(52536014)(66556008)(5660300002)(2906002)(66446008)(8676002)(66476007)(6506007)(9686003)(7696005)(508600001)(38100700002)(8936002)(71200400001)(53546011)(64756008)(66946007)(86362001)(4326008)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t5oUbBZ6XFim5oqC5b+SCg+8qgUyFXZJpcGGIVRsaVUwHmVAfuvvhl0ZznJn?=
 =?us-ascii?Q?PMMilHX+MLeVNkpYw9fBN849ergbL0mrLTkXt4wBmx926Kwx65CI1mK3oF8S?=
 =?us-ascii?Q?85lltDGvbfszUunPFXtucvZTk4LT4tZrhPfGfpk0fvjXozQ/plwxhqFNesTn?=
 =?us-ascii?Q?CJ76CK5ogWn/iw7rm/mnIOyccwukigXOghLAYYsh05AqPiYrZSVd/dezeTtL?=
 =?us-ascii?Q?/WaYDqXvcrWz9CrTr0q1+zPKpagEjDt+B64WqesrFJtRjigJd/SB/ajy2VJ3?=
 =?us-ascii?Q?0GSYruPBLOIiDQ+uKDEj4o1Q138Lu6C4Ujd3aSMnLs/spH1kI1ezcUPjHCHj?=
 =?us-ascii?Q?oQ+XP5VrvCMYJTGsJrSBTOmIKb7rQa68RSeNxe2RIrltbymd7H70FfWg5qfh?=
 =?us-ascii?Q?WLYoWrEAqW+3oc0vEyPPwaKm6uPQvQ0Pr/5JF2Q2q6mWIQ7Eclw6QqYn+h8d?=
 =?us-ascii?Q?xjVntDZUK51IWjrF5TkrJPuBO4ITxUvQ6UGotxzawzolGFEyvZFQyjgWZH3v?=
 =?us-ascii?Q?pd1TsTCzRmOtdVNkAZ4MChWPzxw98zl5hfJ/8m3VhNeFWcSxkDkwXOD5iVOm?=
 =?us-ascii?Q?2h/icqEoOHB1NcU6rJ20b7djOjEtUjeROykjWaCIc+WFcvZHjN/tFodwmlrK?=
 =?us-ascii?Q?3S0VC4srihJwM2wvomByKGRpbwCDaVeqT2V1/mJMu6tBLklqpvpqzORDWYOj?=
 =?us-ascii?Q?qFZeJKs8w3T+kWN8meMZQqKthXnfSqE4RHfA5ZaU2WjXOdxQMHmysyBEO38+?=
 =?us-ascii?Q?Fs+bRasp3dAonEiZLtjNIUxwR9YIp9UV9WB+hLErRcnzjQuCSFIVPmPefOzb?=
 =?us-ascii?Q?2V1rsHA0iAf1Vvh/oNXRxBuvx16mf/VHsN4aNX4DUzxaxbSt9O0ybU0QvTky?=
 =?us-ascii?Q?498q6KUBtr5gROtuagUANBdjyh0sfXWVC2u94uw3KtNfuPwdxwXOuB+Ds9YA?=
 =?us-ascii?Q?dZGqSdhxMVI5CX3imCxTWWBQTQ0tiBmpwxgxytBkUGRI1SKR29qSdjwQPcY+?=
 =?us-ascii?Q?20clXO4A+nJd5EHqLue4M0uFB1TlBzPAWHkL6+CDF7kqvgM1mdCJxIu+bQq0?=
 =?us-ascii?Q?JfvHQzi6q3BvfDR5Kpfw8IrEXFxWqQo7QHSrLydiyTPIZrZ3I4TS5kdOigxe?=
 =?us-ascii?Q?tY9Ts+Wb1johlSgUz5dtb1rVz1W4PTaVMyE6ZjaQzh7XN6Y10J/U5R2zmjVf?=
 =?us-ascii?Q?jXeRnujUwdFZSMww32ux0xANc9BGpZCMv6MLhHGT0M2Ann0wNgmrQ0hmjdFS?=
 =?us-ascii?Q?jOhmu8i7WE05wWxNWptCr1FEOSK5qZpXiKUd5sGI2IC2YqKDVf4UP5FEjYyP?=
 =?us-ascii?Q?8dduN6Nn4Ln5cu53eTXnBMtF7XwL07hKIGwhZIk+ZFgIKiZRxUvUn6oF1tNO?=
 =?us-ascii?Q?j+bkvlVv72dEPNvRvEk8EaYp1C/QEpAg/N5TIPZH1x21m3BzFKdtKxi8Fmo6?=
 =?us-ascii?Q?BcwgogzD9lWKI71UauXD3oEkyHBpjf+tmBFcxwkyhYU1r5QAGO0hYOILee0g?=
 =?us-ascii?Q?Ih1Qs4penRSNdhA6ujBK2MpzQMgrjplFyrg4LvsmgzYNsAwaNhN1hSfmGy3a?=
 =?us-ascii?Q?vK50VHI0y2pCRncahN0iuqNpAg+YAoSxEjR81KowXIr9H/sD7USRqQR1lfCs?=
 =?us-ascii?Q?vndifnXt7Hy9bFCWIG2aRuo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736fd74c-90a5-4137-a3d0-08d9f61248fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:47:44.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNg+Nvnucmf5pypu1snUzCUK5pGikoO7S2mhwO1UcKfoOA68GkgFh2Q+pVSYkhCt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3093
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This series is=20
Acked-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, February 22, 2022 3:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/display: split dmcu and gpuvm handling logi=
c

Separate the logic for each of these features to make the code easier to un=
derstand and update in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 +++++++++++--------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cfe18b92c99..306b321bb70d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1443,6 +1443,25 @@ static int amdgpu_dm_init(struct amdgpu_device *adev=
)
=20
 	init_data.dce_environment =3D DCE_ENV_PRODUCTION_DRV;
=20
+	switch (adev->ip_versions[DCE_HWIP][0]) {
+	case IP_VERSION(2, 1, 0):
+		switch (adev->dm.dmcub_fw_version) {
+		case 0: /* development */
+		case 0x1: /* linux-firmware.git hash 6d9f399 */
+		case 0x01000000: /* linux-firmware.git hash 9a0b0f4 */
+			init_data.flags.disable_dmcu =3D false;
+			break;
+		default:
+			init_data.flags.disable_dmcu =3D true;
+		}
+		break;
+	case IP_VERSION(2, 0, 3):
+		init_data.flags.disable_dmcu =3D true;
+		break;
+	default:
+		break;
+	}
+
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
@@ -1450,29 +1469,15 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
 		break;
 	default:
 		switch (adev->ip_versions[DCE_HWIP][0]) {
-		case IP_VERSION(2, 1, 0):
-			init_data.flags.gpu_vm_support =3D true;
-			switch (adev->dm.dmcub_fw_version) {
-			case 0: /* development */
-			case 0x1: /* linux-firmware.git hash 6d9f399 */
-			case 0x01000000: /* linux-firmware.git hash 9a0b0f4 */
-				init_data.flags.disable_dmcu =3D false;
-				break;
-			default:
-				init_data.flags.disable_dmcu =3D true;
-			}
-			break;
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
+		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 			init_data.flags.gpu_vm_support =3D true;
 			break;
-		case IP_VERSION(2, 0, 3):
-			init_data.flags.disable_dmcu =3D true;
-			break;
 		default:
 			break;
 		}
--
2.35.1
