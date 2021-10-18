Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B12BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 11:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A3561351
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22A3561351
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96076E86C;
	Mon, 18 Oct 2021 11:55:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53DE6E86C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 11:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/XJ8CkxDn5v+wYsRDPTunnAijL3ZYlYMcEGbkSZHgCrvzeKAwBx071HwI7P9h6s9c0vQj66rM+E0U2baEcRSV9nsRIUVvUb1u8IaHDCqldGGXe3oPJRAD40kjULynfnmKWteZWNnxYXXR/Y7nSX4NY2gUuXKoJuNQin1y4N60HmqFYaDzRv8Gk7wArXtC8UDLY5vM8yjxlDFiyZ4AnYBVNEOy5DZ4jIlPdXupipYWlOCJ9ArYnHO1Wx/uhKB7sEn9PvGw8k31Cd0H9z4iBie6LhbmFY/CYRfbPsVrEzs7gEVkhlFJw3jeMR46kmJQ2LQ9rzzlkDMMBJ68cm7Cj5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0tqrlLN/IK/IafmSzQPvSDcHxUCIpvdybPn5KpwW7Q=;
 b=j49VILP5X13M/4R6KwmFdulvjz/o1ZlSqNrtMemLAej7QGXKD784ot2eh0Jqh0c8ktmVcjsznFDK6hswbJ07x6Vv0sMJsOPERILZpkxY8Kcq0ntbq7aRwR4AJTeFrhHo+U5rn16Ddb2ZR3szsWXk16dQwM3AO5JHhGpogdMYFvIwcjdhDPezuokW2IxMhm8x/iIyIB9IZNIf4Tz9CFcRdSqQPNwguWi/ndfVUYsHdbVw4HWiDy5olDosjE2jOUDjkLjQtkHeHWzRJ+Ha4DzcDDULqYnVkY0nB98Z19uT3Uhw+4ROK9AxRguRQaztbVeoEkcG7bY0zUfJyfP2pAIuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0tqrlLN/IK/IafmSzQPvSDcHxUCIpvdybPn5KpwW7Q=;
 b=HSEO8Y2+4qhoMx/eOfHTrMHluvigRtJ++IEomJDkSOTBVSK0hW/ucj6Dpu/hfy4OtPodpoAzFZpycJw6zFyr9TR2OM5HO6J8Sz2pnUsg2pF86pyojCTDrEYuR3dfOVIm+vsCVKdki2yqWYQjtGepA8bp6SAyTzsDy2cnWJY1MSw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 11:55:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 11:55:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: output warning for unsupported ras error
 inject (v2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: output warning for unsupported ras error
 inject (v2)
Thread-Index: AQHXxA3rEB8uThrXpE+apNG2nbwL0KvYpeEA
Date: Mon, 18 Oct 2021 11:55:25 +0000
Message-ID: <BN9PR12MB52570B0CF0150F5FBE3BFEF3FCBC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211018104949.17814-1-tao.zhou1@amd.com>
 <20211018104949.17814-2-tao.zhou1@amd.com>
In-Reply-To: <20211018104949.17814-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-18T11:55:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a9ecda7a-315f-45ce-81b2-bd0b66825ca9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce07514-3288-4d78-8167-08d9922e2c60
x-ms-traffictypediagnostic: BN9PR12MB5382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5382217E2894647B18B01A03FCBC9@BN9PR12MB5382.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdo3fUh0N6cMe35KKX7M6Mp1zSVuYlIOx6YI24BFuNGrVLK7+rBBBRfTgTqcb8Z6khQfmrBE3fPsr9Pp1V7NyJu3xZ4h1+8/10Wex2JDLCaEaYG85AFI6bnm7XNjB8lMjrKu41gvcf3rWClvH6S99Y0toE6JwRx6lJ3QokUYHBRliYZo7UrQKWrQxj20yWH1V1NpcYt8EeM7YBrxazWv1z1HwAdjOqq0uCl1WREKNW1K5Bg2b7ZfuTAQrBAmZ4X6wplO6a0sHnF+FDRBQgGRMIuHuMrtmHgCORLcPdtDXbMVrWFKpcDU/M1OVUnq/5pWWZFJHFYfr5y0IaXJBx4kX93+N5qB/69FAfJITBTIlJ9t5Nk6c57xIo5AJeRtrnQDQm7QjHB9VWPmYpYJ14++z89ESizv6nQp6dQOLe51RNnri6DNa/jPPDXNldTkBL5uYCIBGFSONJXgsTkTQhmHEWBpCimWU8NpjOXUuErjGz/EXEaKpnG5zAY6o6nwlSpV6qE+4ngnrkf9FZ5hOT2g3mm+4vT9WpH/26cAwH9aWRC2yBvsLUZ2+VRaWbSlVriAdCFKUXNN0hgM8jlrQs/v+9JCpsZhDBss4R1APnRk1/Lz9bI/XHMmlfwn+l4IZrTKak4SGqPhC7rTItS3irih0a04XG0Bune8fGCDdhy2D+iHWMyOx5XuPciWCyHapNrLaYmkhdSLsaytfkyq0pP7Ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(9686003)(52536014)(8936002)(55016002)(53546011)(6506007)(66476007)(26005)(86362001)(76116006)(33656002)(186003)(7696005)(122000001)(38100700002)(83380400001)(8676002)(316002)(66946007)(64756008)(6636002)(66446008)(110136005)(66556008)(71200400001)(5660300002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V55YM35dnpghT5SY93RE4THOSsVnhi1RS2+yRxS5ptqXJloZIyXHpxKPS1N0?=
 =?us-ascii?Q?XZCECqYANzafGEjZ+s2a5eD1EXijLYmO+Wt9uHNfJaaZArxhQDveND+8BzJv?=
 =?us-ascii?Q?gYcYW9Y/kpJkD2V+GDpIGZ1k2vL3/nDbG+XfLZqERfA5Gyr+s4WYHeL1Vqcl?=
 =?us-ascii?Q?0umCLJ99Jf4O5qdzi7eMrip5GxTie/BxfmRZxirYxL6k3jexEKaFsWWoj1U0?=
 =?us-ascii?Q?ohRV2dUlHNKzpsSPaDY1wjSdEmLWr7+EMZQB83KBZyRy7yKuEIqNEQ3BCSqc?=
 =?us-ascii?Q?KhFr+tQwcaaGHRfHw8OoA0w/0e1f9jZyDg70gNQEmA96BiMU6224GgGD2hTu?=
 =?us-ascii?Q?gWuay8fKqdGFFNJxn+dZ4UW18en9tGH/1xbRH1rt0+ft2+L56FJyMvsUCCld?=
 =?us-ascii?Q?dGLvPkv+jVPFJToF0FvPdYLXTFA8ji2MrtdvBm5wbeFhtU0H4PD6ETaSC6NO?=
 =?us-ascii?Q?qeG0j+agROMjG/uU3+OcV3ShVVyOX3jSVaRP6X5pnFhCrBe1XHNgO8nwlVLG?=
 =?us-ascii?Q?XbGHJ+1S6sZd8gckJNB0edk449ptZ8xIBrh3etdGXJAp1rmm+lRrK5RNQ3Re?=
 =?us-ascii?Q?KMe+JbwNIWde0CuqItmIiHS3QofdgCUxjLZs8F1TRDqHC4WWs89CZAvxzBmH?=
 =?us-ascii?Q?XKX8BfCmzA75/ItgRHpkBNAZSUsVLV6y8Z8hmz1c37+NrA1r0zijkUcraHzb?=
 =?us-ascii?Q?ULH/Eclte3/eP2pusvqBkMUE+BMVMj6N2B157b+5QFbmqUtCYl4/pYGC++Y4?=
 =?us-ascii?Q?pWnuHJ/rKeM9JYMPLIpqOPemGJ3BVkG4HZGPkmyYQo8ulHByWC1JPGNuziKp?=
 =?us-ascii?Q?rP2W15Gc4ogll9t9iP351INivxcAF/qeQS8F75gpxxC5tDJjsi/0MZt68tpm?=
 =?us-ascii?Q?9b3V4kX37SNiGodtV+eThbHL7zIhMKfIKN/cT1v60qKyhsayqUF+ujQOUU6B?=
 =?us-ascii?Q?bgmHDbMh7LzmjcdVIK5P8ygSF+RvLfPYIQfCkqlQdoQJsNBJQyOfLt8iIxJw?=
 =?us-ascii?Q?W2TLO2nO3vKWMKaGCGH3Yhvi1G58BWrd8QFlnQwOqGQBINDjhKHOFiLrzWTX?=
 =?us-ascii?Q?eI+Sw/IIryCOzF6c6vEAOAAM42I7aHLfDMw2+rR4f8LUulakUaYZxrJikp+Q?=
 =?us-ascii?Q?RZpJBatmAIVtN51xrPVoYIMzpFwGMQ2a95U1ZySYZHgN03ZLXusmtir2cCsy?=
 =?us-ascii?Q?TANuSnBSOqootLSDt+Ehp0Nx8K1qzYbMW+u+SgJJxw0Ue+shCF7n/JG7sbX4?=
 =?us-ascii?Q?o/pDXKgwZE9zd1Q3g9/ZBNP2mR/fOAH/EaRETcre+iDbWp4cTi57PHuLXnCv?=
 =?us-ascii?Q?rSMoH4Fqor1vSEdhZgxx9cMG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce07514-3288-4d78-8167-08d9922e2c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 11:55:25.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOdr3afZhtlZv6uaoEm+y9/+LMnDUjdBJfvlFA1sMaIQ1xN8ApuHnTdYhrL8HMVyarR88Zw3044xidP+Mb+ZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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

[AMD Official Use Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, October 18, 2021 18:50
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: output warning for unsupported ras error i=
nject (v2)

Output a warning message if RAS TA returns UNSUPPORTED_ERROR_INJ status.

v2: implement it in psp_ras_ta_check_status function.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++  drivers/gpu/drm/amd/amdg=
pu/ta_ras_if.h  | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index bcf95982f6fa..fd04e83031d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1302,6 +1302,10 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
 		dev_warn(psp->adev->dev,
 				"RAS WARNING: cmd failed due to unsupported ip\n");
 		break;
+	case TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
+		dev_warn(psp->adev->dev,
+				"RAS WARNING: cmd failed due to unsupported error injection\n");
+		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h
index de24a0a97d5e..5093826a43d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -59,7 +59,12 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_SYS_DRV_REG_ACCESS         =3D 0xA011,
 	TA_RAS_STATUS__ERROR_RAS_READ_WRITE             =3D 0xA012,
 	TA_RAS_STATUS__ERROR_NULL_PTR                   =3D 0xA013,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             =3D 0xA014
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             =3D 0xA014,
+	TA_RAS_STATUS__ERROR_PCS_STATE_QUIET            =3D 0xA015,
+	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            =3D 0xA016,
+	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             =3D 0xA017,
+	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          =3D 0xA018,
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019
 };
=20
 enum ta_ras_block {
--
2.17.1
