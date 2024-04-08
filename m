Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1281ECD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 06:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3135E112142;
	Mon,  8 Apr 2024 06:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n40rP9Q3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2101.outbound.protection.outlook.com [40.107.223.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997B9112142
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 06:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIlmrUhycuAlQW1NhcirKj7jivcH6xm2Natb1OnoZHVeCXCeMcqlgb9ZgtwPq7A5y7zsw0WKEGHrhTTcfq2VDrxz8isjXimFasx8nK4+DiXMxZizBtQje09UnHMdU2MaJ1imtxnx+3aHips9jkgN1iD/at4msTjMiFO3NHfF6QnmaxeJPqeaqT4NwgB1oCcLpnEBoU4EQIcvTYucMsTrzzt4ONC511/1uC87pgfUTHkiV8eTz3knguAvSywi1h/fQ/Q1yEjIsYo/MjjokH7bs9K4gNvD512rNRqng/qgPXOBNtf2rud55SB0wC3p7fS2+1QeaEOJJqyX5LOvEFX/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bJmYcFbXM+f+v/CKqrL3Z94vDA86SAhMkTzCTABoTk=;
 b=Nyn/YqnXYHvJ2c6QhzTomwy/X0slpuhUROjL/bD0P8j82V7EdXaSvquVSAX7onQYoOJNj0AYVJM7B2rp3ZGmE4pz9/h0GuDsHlpGtFIzSD4A0AZ3thSKygIykgiEKyIQUmG9so9PJp6U5BHYRBLe5ElmJTtO6u/vPDQb7DDFCQR6SXsEZoS2ETBPnNmTa+nlOcBi82XgySAIXKbWe9NXI0u3HWK8qC1/q2g3cAu9TVT/aA1wwb2FkNvCI+10YXiV/8x1C5K9BpYWNkqetPJXPXIJbTm1/AeniKkzvD5wcpQimfLz9bz+RKLjvUpXEWbpib0esZSyDgDf3QFjriHZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bJmYcFbXM+f+v/CKqrL3Z94vDA86SAhMkTzCTABoTk=;
 b=n40rP9Q336Th/MtlpDg6B6e8e/D+9ZNuX5NvbE5+0YjKluindZ6GulBFQvaYE0V6m/VvJ0j/V3Q4uoDrabCt0/tcpI/77gq3W5EbUhi7WMqIS+vh2fFXj/78jSkxsknsmsBXF0dnb/WBLmo13t9G4sY2V7p7J7ZgxJdbFH77ZOg=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 06:42:16 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7224:9db3:7279:9439]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7224:9db3:7279:9439%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 06:42:16 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: differentiate exteranl rev id for gfx 11.5.0
Thread-Topic: [PATCH] drm/amdgpu: differentiate exteranl rev id for gfx 11.5.0
Thread-Index: AQHaiPVdpwiifSCel0K0m5KclSzacrFd7EzA
Date: Mon, 8 Apr 2024 06:42:16 +0000
Message-ID: <CH3PR12MB80747285EB10724986FAA061F6002@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240407141017.3831131-1-yifan1.zhang@amd.com>
In-Reply-To: <20240407141017.3831131-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5d4e85fc-1fa4-4359-8a98-7106a5218e9e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-08T06:38:47Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MN2PR12MB4222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUCCzSCyLuK1IOsLwH7jUr2/6hRjb4hNGGZEL36JiKbBc2GpCMW7qLoeEM9AlGpj+obviVewZWabAgHq1tWkFV9rkGrlegh5rlUqjXvSaU5GmE8kcJsLXJP1pQslstxUi0bwgh/tsUs/wiHfcIAuTUuYuCUIyRrXrARaMBYAiqZia/DUhQSsK3KM3PXIgFT5liCBcF8r/A8sGbP+oee5zM/zNLp/Q2loc4Y2Py8napu8ntbndjLsaIwXSXBVobaEBqkZvCq2+HEfcyP91H0jGbeTJbPMh2JE+Za8j+7KA5mvyhbpm/81zAHZd/qUckL8rvjnsOzhtrx6v+Bhk9fSzWUhusnNxDZ+iDL7/RnZ4Va1GqmQBAEd/+2tV/u92iRkHDTAJ50pIAehX8xSuUVRuHw2RRU9z/SVp+ta7Rfexcop/0aAdLa2soc/djKBtZa5GrmP5xmiPj6KeD16nJ9iiWLWwpjHnwpJNmCbOvOsvtreTFqOXegiWr7hk/Ts2xLiJzN+SvPKZBsLbQg6qMNYQfMsLIxQTIXbGPkvk4pLDKptt8oMe2/0WMNLDxde47FI5BoVQxZoxTFp6xtMK7BjP9Qv1fvxRCoUWPQ3rh33hX0RW+WHXiCnfJu5Ia6mojN6dxwD7J9Lk6MLWblObp33qdEWhZXvi6dSoRBTNMi5zv8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mYUX512qY+oqJpQNXkEDmFXtvqSuJz1vpIM++gS6/7t1mjSCchl/AhKdg5NX?=
 =?us-ascii?Q?SFhnvDZIBfPr6qZU8gmANPQfRAK1fOKnMqjE5bzIht91M2G4odcKiS48mKDI?=
 =?us-ascii?Q?Pp+KvAoZZzepv3jaFZLefDFn0c0w4i1PILUm3+sFOobXyzCoDJoZ4Jniinfi?=
 =?us-ascii?Q?JWa0DTBn43euM0EWohq1IG25tZGkwRFwEW4NxbJ5Br0Z/Qwb2nL+P0b5Djoz?=
 =?us-ascii?Q?HoWd+BFistEeGd8gOjxj6iYqAgKPRK8tvQnZ+r+zw8NiQzEsQYg22K+y7KBm?=
 =?us-ascii?Q?c1WEzDepw5iS01WFVEwruh9xpEBFV9ASaZx5EHIwA2kL+bFoF5WbCX7CVwLf?=
 =?us-ascii?Q?Ia5t2BAXHKFARHl6chx3OB9W86dO4seOoOtgEPz8WoDxLXhu1QU/WwKkOLe9?=
 =?us-ascii?Q?qgOlwcCT37B8NF0ltjMCzbadlSx0LASmtW4LwFKwNC/Sa+eHqHKxeu5QRIQq?=
 =?us-ascii?Q?BF+9IgjUI6uAFhh3GZPrnEfRAb3d66pxxzoy04jotL/lXx4qKf/7A87X9Ls6?=
 =?us-ascii?Q?2jp1nqtqmbqWaknyzI21no6oXEYowg9puZnwrjzeQ9bZR5EQO0C1HwAKkBEM?=
 =?us-ascii?Q?cmMNBmH2kIfd5aLcaxYmC74Yy3g9QSk/CM6+d0gpwzSgLteofVIWxIZIzcM5?=
 =?us-ascii?Q?0D+J7bRdKPM1bVz+GGfGkBHQeB4Ng2A1P1w5RjovlwBsM2GNU2Zc6K7D4H9m?=
 =?us-ascii?Q?ZuNUGuN6E8isxQQwgIbFGtNHtfuhVTPwnOs6nj3KRAbGX1bT4L12lMPm7RbM?=
 =?us-ascii?Q?W2ieR0GEmsZxmZ+468ylyA1l98JGC8WrdnrO8SmUz0rZ2ogel8svCIYTDa9r?=
 =?us-ascii?Q?WVj/GhAdEBWYIkCK0V+PulwpVXZV1gWPtKOF+4WnKiiFt0cUL0NY/z1EFprv?=
 =?us-ascii?Q?DQ65kidJMStiIgj+oMN8NPRxjUDzFJmdGELKJfw0dYWiY+A9M85ZlbNXlUWt?=
 =?us-ascii?Q?/jbngnLtxoCIWF3j3d5D16vFQeO9NcdLuLrcL0ZbkK1JDBEYHsIKwioxd9G9?=
 =?us-ascii?Q?KKT7+l/ezCEyjnggzzXvLPEj7FEe6CTuDfK4CM59fCDDmWAN7oEw6ky3aNsL?=
 =?us-ascii?Q?AczV1lwSvCV04B+Fxk7f+5Haxcs7p84tB7ck6pFA0gGXpNAbjqb9NfL2MLOO?=
 =?us-ascii?Q?zLA3CgKdmZC2/JkyhZPDJo3i+vd0RWDbfKa5wnKM24g9j4KhevcNY+j4Vr3v?=
 =?us-ascii?Q?AGFGFq5FpBaIxyLg64kqkZALuGQRjyRdyF96yYT/7rPkUtnWOSJIkYt3Qbkj?=
 =?us-ascii?Q?Q6iifhAWy/uxXc7cKxwvXtvwEg4F7SLubEmA/WRPzpPCIwXkBV5nlw+p6Lfv?=
 =?us-ascii?Q?sDsgm/YuN+3Z3JZTeaSiqy1wRjraW8ybnwR/fk173yqmRayKikUZ65AxxXy2?=
 =?us-ascii?Q?rgnjaIw3QbCYr+ADIUPBdvX1+t7iqc5tIt6I2Zx9Kbf4GJ9Wqh7XAmQUD40G?=
 =?us-ascii?Q?W2hA3HB+OMkGaVfzZrgrid6OnwyczDrVCjuwjw7VIIUmQixgqt+trWLnx4G+?=
 =?us-ascii?Q?PDVGWE5tjWxMKADsulJ6yO0r4zh80rpai3YyDBL6BizA55Iy283SBda6bf5y?=
 =?us-ascii?Q?+9Q/MXldmHxTzoFBlFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adceca72-beee-4ae4-f846-08dc579707d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:42:16.2849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPWqpa5nKOQeqeEm3laUQjObm+f7zdC4asSArvS0dadQCv453UNmWxmMlml8lELnirOK6EYOzcABVfn9HEGZSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

[Public]

Hi Yifan,

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Sunday, April 7, 2024 10:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Ma, Li <Li.Ma@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: differentiate exteranl rev id for gfx 11.5.0

> This patch to differentiate exteranl rev id for gfx 11.5.0.

With the typo " exteranl " fixed, this patch is

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index abe319b0f063..43ca63fe85ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -720,7 +720,10 @@ static int soc21_common_early_init(void *handle)
                        AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_JPEG |
                        AMD_PG_SUPPORT_GFX_PG;
-               adev->external_rev_id =3D adev->rev_id + 0x1;
+               if (adev->rev_id =3D=3D 0)
+                       adev->external_rev_id =3D 0x1;
+               else
+                       adev->external_rev_id =3D adev->rev_id + 0x10;
                break;
        case IP_VERSION(11, 5, 1):
                adev->cg_flags =3D
--
2.37.3

