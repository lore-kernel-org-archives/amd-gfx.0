Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52E9CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E62E10EC8E;
	Thu, 18 Jun 2026 05:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIxTrg6O";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED8810EC8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW20DUp0ZIZItjBJ67hoJIAQslDeiKdiK54HkaNc3x+zH//smep+Bp07tdZbfPqO8FQ0PB2jXj/OzDjjyeJaGwvP+aSaNONOA6NXL3Dc7nbDVq+7Hw1HZOZlCRXg60vccI81R8RViQUNuSSovE6ZvxcSI2mUDW50d9ytotwHCKjPjfUv9rGUIc9cGfVPy0NLDxXwk/Dzy7STzSHeLwS39hbrbHZbxJgF3yBZQnCxkDlgo5VorToZcDEoLU9jEiZFdjnTHFvDvyl/NSh3FJzVDq66ymkYeTCiFKpYRJfIiwbHmPs5FD4Pxc3Wm83ee0QCjkcZgSPFAgLIv8ZxeZtoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKtiHTvBUOdGXOQznR1G31/cXAmN4OQqVg1DJC+azus=;
 b=YE60DdyLbOBZdpMbRQ6vVjW6W9wD1YflkUekCYEEiJmg5zVLwUwgdiwxuLwFc3JmTCx6aBEi/h7IO4X3cAA9T+M2CyNIwC0Mu/6f21x2hMhi2DPCuRaFr1OyMbs7kTX93jxe1xqu5IBDwWQAQt8qFJrxLatrwz4l8lDhLq6M+W+82BIO7lBCyQwJxaNTVkF+lwTOnvPwuXfeN8ozjEsi5Rno4qdMfACJjlkFrOYF11AAFH/4jkB5iPLeCVYlCIfuVvObZZnTFUvfhIPVSmtGGWqQl2Ydx+u0vpyu5VYEK7NAtE06aMFzLgQ+dXgw6SvzSD1+b5tbYptw+4VNN99mQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKtiHTvBUOdGXOQznR1G31/cXAmN4OQqVg1DJC+azus=;
 b=dIxTrg6OMC5tSMo6j+h9mw9ffxLBotU6nDF8nGI1Pr+9myFT0g6WywJX76aR2RKknDo9+X4o3AXdxg+UZdRGCJiWXvXF2RGO4g4HyitvzvwzlerIPZ08mcyFZV2HqWa990al7mYn/8bMEBK0M7l5+WgwNubKOxfbStjOo6t+juE=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 05:40:32 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 05:40:31 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: bounds check xcp ip block index
Thread-Topic: [PATCH] drm/amdgpu: bounds check xcp ip block index
Thread-Index: AQHc/uGjqRWvoKAYXkGDj6hdTuB0ALZDzCSg
Date: Thu, 18 Jun 2026 05:40:31 +0000
Message-ID: <DM4PR12MB503899A5BE2369393E0BA2A48EE32@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260618051611.931328-1-lijo.lazar@amd.com>
In-Reply-To: <20260618051611.931328-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T05:40:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|CYYPR12MB8656:EE_
x-ms-office365-filtering-correlation-id: 3281ba2b-f6a9-4dcd-c845-08deccfc1c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: lNL1xghxYxKtidhlSe+dLFRCoOVPGU/HcXGOXhryOw4TXrUodKTcWQFZ2Lcqd74LI8p/dpiLN1+8LTj1Ziv4UJUzAyq9I5cvRZ51utkNibO+kdGmedmiP+v63kj3GjszSrK2X9e2LJMJN0Q8abZa9xqxGH/I6Jbv42I8GdxIwgdMRRJ2vxjx6M6iQpwr1D0YuIQZ9+mnSgEVw1VEQ+Kz537BYhdeZXU/554u+iXVAxm0Ipqfu1qiP91g20/t/EHbmDkETFVHPVO93ou15v4uAbRlBgVbigk7OXqJeI76LG9pJ/dKVqz9opzEDZL/qSvSA7GtjAEzA7PtHFqdsfF47sMIagaLAJws+q2IXLR534uZ5SGiFEwdxDOkQ+UZd1nHQt96Mo8oPuqQ1T4L7mMHuXg60RvDwFw//MNLtieMkpPjfGWSjPQVmRSRG+arsi0iFSLCSw2zn9jN9Xuwqo5Amh2/rAMgzipNqjuMFjTHpZJ++BO6SDu0JYM3oVaalGM4UEpcbzYR+OSB9PI+ZUvWh5xFxV67Yb3pYH8Hzj6cyLLpMLRmDsZbf3zeEQgJ9Npmp8PO83WvmFeOZKib8Gj3mYfY6tBpQjFX6OsY9EB6q9L+9WuwtVK7/b23XkFynWZv687g71Wv/Y+i1R1My9qH+zDs7Jy0gUrvtP1R6wj0aKX98CYXTiUX8jVoBsMKL+we5j5fW830KPKaukXhKWMvldlPXtotfHwPGLAgCGVrQLdnXQBsAf48nzk3eZt4rYY+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kdfBmGLF531HLYNUfg/BurG90YA2WqaSI1aKLWJ70KPwOZWwqri///DnZddw?=
 =?us-ascii?Q?WJXjBNRdz09UE3m2aml/YVJxeq+WPGxrtDYr/th5nwqfT0U44R65YDyv7PWf?=
 =?us-ascii?Q?4r8UuxO9BCeDgcr6vrCQsS9/ytnTc8gaFSh2/vboRaJ52oO1JMzKYp/3WrB/?=
 =?us-ascii?Q?xbBbj2shumELJsXEvamJfK2wjNh+X3KO6IgSz8k1Hz6+jDDCccrZgQhHbpLy?=
 =?us-ascii?Q?5JlSlRUr3+ohcXd7cJhxy93SflfF34FRU0RC0V6EZ+4rX/GVLIfTv4jSBCmc?=
 =?us-ascii?Q?PhCgcAwrOUmoGs8XRtMiQg7Z6CVdfoxs8y3LP1eCXjq5PjkxuU+IV8QGvZeW?=
 =?us-ascii?Q?3z7GVYRKwt8YF+DVYOdYq7/htiCdevm2tiTw1ZUl0Ijpw4s3XHbFAz14vEPJ?=
 =?us-ascii?Q?56+7CLvRSfIPHEOo/m217kBBz4jEBYYOFLyp6WJ+tnVXeuPHYRpRf85ERwY2?=
 =?us-ascii?Q?ftDKGCMFr7Lp0NcN2mw4Jz74KS+2efOwDLUVBkJtHljenf5mG/JV/D3/zWHg?=
 =?us-ascii?Q?soi20YafkWnYcJrffXZOpFfoyfODxQ2C93gnwU19JnZkT5EQz2FQ2Uoah6Yk?=
 =?us-ascii?Q?2dcaj9E6+pJNRHmkJtDVHMbtNsMeffaqqVdZ5P8+XOwi3vQfRpy0NpB2lE1n?=
 =?us-ascii?Q?zx8Nurm30XI79pur/JleBtgYIsFPqZRAiXnpAXl+EcfcaDf9IwbO8l0/yJZ8?=
 =?us-ascii?Q?kf1SpuqHMSRU/OtAkn0iDnHQ5l4OjXu+KJ++SL+gbOhBSWL9Pj+eHqSOwQ54?=
 =?us-ascii?Q?igLUdxhiLJzGWoikF0EGURTFAf6PK7bXSW5EZp0ebT92FpIU7Fy8YVIIxXI0?=
 =?us-ascii?Q?tHeSiEQE5QZhDxbf6GNIr9B1yVw0dnpctqUfAMblW/KJ+2gJzWh2DWhlssiZ?=
 =?us-ascii?Q?djP5NZ4rJSaGY8+FbetrsBQFZYTFWig+7GQflwzYjwbZXcv9o2l7YRS3s8pc?=
 =?us-ascii?Q?50iLP5A75oHXkiWBVrb6nc4jeYOg6wkUjVJYo1WvyCi33+vYcGTAAI4rYXBU?=
 =?us-ascii?Q?NJRiuv9P8P9M/w6WDXhpnhW0l5i+nwVtwuAOjlP4a4vDpEub16D8qFzvPPV2?=
 =?us-ascii?Q?q21L72QmAeReMAUQF7Mupkg09aT6zBMCz54e9rOtQdDhTy/WHA83wTlcLo9s?=
 =?us-ascii?Q?sprMb6A+B8qeZ6W27huF9FfNmbcXM5tVPdX0LopJ17Qm+2Ki9zDEeOqhYwtK?=
 =?us-ascii?Q?OhXPg5/HQRTbkZl/mhfK/lDo8pDPdkSrGaPeXCpOmG/724ffE63y7uYl08U4?=
 =?us-ascii?Q?5jNYShW7q7sCl1Gxj5QnkbixYT28+zQIl4EU8Gs05xp6dd93dQROu61fsk94?=
 =?us-ascii?Q?dvdjh4E/wiYXbG0MPE9A9BueoABt7yFutJJagoJf8jxqvveq3YDfLqe8DaV6?=
 =?us-ascii?Q?VPWOWPUaoc8fdENg9mbvJ/CoAc5Af0vuX/AW4xWCzzTgD82eSaR78fh2mDQv?=
 =?us-ascii?Q?lOxKMquEKfy9JmaYY+UJ0zb5rslF/EaM6LYbyG+2huLtOK4H3gCbeNyejHK6?=
 =?us-ascii?Q?AHIvfEXSolMDCcp4JBkqhmXht2Hi81V1G22N6nele6diJYXwQFTXJ4lk4grd?=
 =?us-ascii?Q?nYlo9mJzdNlYy62XbWU5LFFKuWVO7WaruonAk7oD2j+W2w6vNgTWgWT9JnXV?=
 =?us-ascii?Q?cZJ1a2I1swclVbUj4DO6ulMztUqVZAm0hbUhb5wgx1JSJVSYY0BSoWmjlDbO?=
 =?us-ascii?Q?2ot868+yey/3H3n9bOY5Ge+w1bk0+FCXXNqm2kTavJYLBV2V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3281ba2b-f6a9-4dcd-c845-08deccfc1c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 05:40:31.6340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdULW1WlL8lBSxL7JrnV2UdupFLM0dojiC2jkd+lzbGpw0wQyDOId4p4UwVPm429eXPtnr14T4QQ+cNYtapSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, June 18, 2026 10:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Li, Candice <Candice.Li@=
amd.com>
Subject: [PATCH] drm/amdgpu: bounds check xcp ip block index

Check out of range values for ip block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index d0d494e00cfe..88e6eab91bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -381,7 +381,8 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
                                enum AMDGPU_XCP_IP_BLOCK ip,
                                uint32_t *inst_mask)
 {
-       if (!xcp->valid || !inst_mask || !(xcp->ip[ip].valid))
+       if (!xcp->valid || !inst_mask || ip >=3D AMDGPU_XCP_MAX_BLOCKS ||
+           !(xcp->ip[ip].valid))
                return -EINVAL;

        *inst_mask =3D xcp->ip[ip].inst_mask;
--
2.49.0

