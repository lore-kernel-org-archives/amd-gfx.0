Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23A0C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 04:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371E110FD42;
	Fri, 19 Apr 2024 04:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="btU9Z8KG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29A610FD42
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 04:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9sZ2dV99gvbEiuvQT3DTqTng2f/g8v8rCJgIPVeiYOPN+pafmQudO6aKODWBOTDOOxk/jtms5DsiBVnXRaX+slBHbiXKfzggZsTxeWHFViWzFZKry/HNRonWbfpkmujAOfrAOxytxsjwL8S/2OX9lZtEPAetrzuYV16WBR4LBylWiWQudLQOQUaRCzYFi7kcy3ZeIL5clujzkLli6s+XYiJMbbr+2lSbL5lTIXh11VbVeTyH24wy+y/9vUjkmfceLLr7recnMA+ULaYWfz4GVzgNs1w3dH59KB4SU02G3NCaPYWeAalEE3JGz1/EeQmgeWdT6YieW/IczGVSY220g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2NRwC07EcPDgRTrxfmOnjMLkNHyuZnsOaRCGmbSsGo=;
 b=Z6hCu/zjjnUoBCG94Lurl3tP681h4OJY4tbEWJw2DsFWrZHyCO+S0sM7ji8xgT0ULDJoiQb553IDYK4aSIRQpXuuAmxDjQFbQHu6bHIZWS3mM1DpsScK4h33jDdwdmbMvSZvyo+7hLnDKxZyvuijpx00NBWI8uv0UUU03XPYA268XVdC2n+8EoeXDeJC03UvEEJ0gUSDPqb7cgznlJpFNKpfqgYd7Gq/aT/SkVxFev5HlJkAZmEJ8qMmD5zlz310LaWF4tw6hC90v2LRJ/JelTBXtxT34r6QEYquIdkC0EpMN5bKBgrWnFWN3HU+Nqmd4x0/fPji/+IyQwXdyw9oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2NRwC07EcPDgRTrxfmOnjMLkNHyuZnsOaRCGmbSsGo=;
 b=btU9Z8KGIDCnv/I834PYj298Ywpk7x3OmAGiShXmSP5P0fIlXKP2JxEqhAwzMdA3Oh7ME9ONXmhFGFaTK2Ntl9kwp86JFpvprWY8OEZQOkSNanf065vUTsckYiaqXdtpog2Wc8Ap03ciSX77UsWXXQLJ4IMh3K9GWV8N8pxrrL4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 04:29:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 04:29:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lee, Peyton" <Peyton.Lee@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed
Thread-Topic: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed
Thread-Index: AQHakU6JwwXggk0l4Uiv4iCOJ/FNAbFvAZZ0
Date: Fri, 19 Apr 2024 04:29:30 +0000
Message-ID: <BL1PR12MB5144758B19DB4DF3EAF1F8B6F70D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240418051244.2329177-1-peytolee@amd.com>
In-Reply-To: <20240418051244.2329177-1-peytolee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-19T04:29:30.251Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB8572:EE_
x-ms-office365-filtering-correlation-id: 4e5ccea1-f274-4d01-75b9-08dc60294e85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?ubkq+bXoCxzuJ/V2zjQ4Yr+Buddtz71pT/p9hzyFHhDPk/86ReCkj9E9WwD1?=
 =?us-ascii?Q?TCNbCs8psvfK0bkYBumVkOaqt11dbruW8kdWCogumqpqbgpU/ulwo391ioPA?=
 =?us-ascii?Q?Ab1oCiOr16vB9BZQDqUebwRCWXuE+3inW3TgoFvkghHtvOkMuYo0ObaUGyaS?=
 =?us-ascii?Q?JB86nLHuB9LXCJn1o7XHD2RBaJdNdje4LA24cGFuGHltW1K16SaRSkTLdaii?=
 =?us-ascii?Q?UKlUfXNTT3UdXd/FVqgeM8S8bIvtWrPmHr8TRkE0iJ2uzOu8mSV1LDpq8nPC?=
 =?us-ascii?Q?OqY3zngHwiWfbvcsMMwg9s1Z6lu8iqL1SAjtPJv8v6l3fUxO2oVkoOIjvXME?=
 =?us-ascii?Q?0+Om61PzTIcaHh/CRB4FZNyOSUz0pHRYLMsYuvCkm50xU3ljFafEDfXhQRIm?=
 =?us-ascii?Q?Jn+2AFhJ+JRouYcx/ACyNiYPabkCFaXRGOIKo5UCPqUR5nx7JPyJGXXmiMOV?=
 =?us-ascii?Q?S/5kdPBCmk4TdE5H0g6dkv4mZjyXcmEBu0SJKsRcdRexCC4PgGrEgKSiG4CU?=
 =?us-ascii?Q?adLYXRvVq6DEJ7UloGhU2rKmTh17sutCjKJ7ZBJg5msBfH9cNLLcRe/qmBv9?=
 =?us-ascii?Q?T4av7Fcztaz67txjiwzLPprDZr2ZvU+uZDkcP0lwiXDthd/IOsSnRWTyIKmK?=
 =?us-ascii?Q?Q6O+UAKD8rBquZos2+iOlcRx4MTvZ3qZxI74eX5Cvq+OBA6Ey5EPAJunApd4?=
 =?us-ascii?Q?6ExUczpbz85dM0Jqbi7iajbeUOtK7PN7/qZGrPc1prtKru5sTyXgACfnu4j2?=
 =?us-ascii?Q?Zpa9b+8rNGHSfmBNeqXjRb/4nqWJEq8E3iUKVEVAwus4kExBMa6uGsTgoumk?=
 =?us-ascii?Q?ZFwR7DGNg1NG1CF1wfFJsApDKV2F223c5sO709hjchslhHV7wqY+EfYiQFM3?=
 =?us-ascii?Q?YAvSB782sSbXbNJI4UBXwmcgwtjvdE19ihXI8X1dtQ6N4qEOzLBpzdNNkLYk?=
 =?us-ascii?Q?0rs2m9Afa0oVh18ONxFDCUSxS/5BuP6LuZj6b8qolwodk/O7imYNdr5DfdZz?=
 =?us-ascii?Q?XVoYnLeKJg/JyM6PTATfPgStNc7OvYnmiUrgIA92geLm/8iy+m+VRTFo9Mvn?=
 =?us-ascii?Q?bwI9ol5niRVeqx/Ln0a7M9rhnNfRg2p+HryAYhmsLor/Hc0jy2/0Zs1ZVbDM?=
 =?us-ascii?Q?MkqRJOIdwgOVZmCpltdO/Ai2vcrmRPldVQFs4hfhEfV1bQELysyDk9WowYbj?=
 =?us-ascii?Q?D9cPWM5sxRRSzCF26yD8FylbdIqIr4ucDSv3CdqpL0j/gtU7ojTVjiQWyl6Y?=
 =?us-ascii?Q?Pq7I5ziAqGVBX1qBHAaKZbfqNJvVRdNb1FWJwJXK6/8e1it4xCDJqfJO/BLD?=
 =?us-ascii?Q?vdmU7XPs9cMFE9/XUuhzbD5zewlmefzWLNdga9WOT3b3/g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9goMAzbJfSuW8eZY+HmOFRfbnAG//0vFkujtZfBgc7lC2Gnk7MCRA4OXnkyW?=
 =?us-ascii?Q?kwc38p+GwMooFKb3nC3fQNwEb9UqcEZbxNsStwmjpVjaxkDlNw6gjzoUFgKM?=
 =?us-ascii?Q?8Jr1/wB/FwOjcZzSzwhPREhVjPznJGLLTpcGrD4B1m4yFTJ+iq7xiOPWTFxm?=
 =?us-ascii?Q?oV97mbYlLjQjqdmEDgBMI4zcioMJGuED7q0qiBXRQE7meyBXt7rSoWZhznD8?=
 =?us-ascii?Q?OGf27rPR3jgE8LJwV6K4vQWQXYCr399KuPbnRMxh8pHEEzJjbLIHsoPb+1hY?=
 =?us-ascii?Q?xyYBDIYPnqcjX7BrEbuorGo9Vwqq0jc7TPiFe/soAI65tojzUf+cofeHUtJe?=
 =?us-ascii?Q?Yo/9hf1hgut75njz0ffNv46j9xyUsqzewtP6jkSCRQuhKWqCDgEmIW8QUyZX?=
 =?us-ascii?Q?jidMqkfaeo8vOtFbuAaOXCrlhuy9zBrfLyaCHDsD0A0rXsISQ1Canzc4jmml?=
 =?us-ascii?Q?TI7F7kCOHRa9xcx36UtGjELrgnVs+qmqgGCW3hI/kGNewAof/G6kbbAkya/e?=
 =?us-ascii?Q?RG9vLvczQyTfk6qVKdbYq69vxCiDcYUqJgxahJD9wUQs+9y/h4EGbxrHdWVZ?=
 =?us-ascii?Q?3t2BETUQ15/rT9Kk87XOxejCsqS1R64QxA7zPJAjwHzUppOf0XxOM+FyOrC/?=
 =?us-ascii?Q?MhTOA/ZQfP0VJdw8KjcvymXhbNkf7ZJEOIgnmiGNTmbmw6nYpzY3Qg2Gb3jW?=
 =?us-ascii?Q?vDUNJkmHqNvlcSNlC2lYX/r6jp2tddS97yoeNo1xpu9v/FDcov0kOMTF9BSx?=
 =?us-ascii?Q?PYiJjVIIjsa4IFdrbR7ie0uJeaoic9QEMCizyoHXjGjJfaQXZ5oPoIQL/ffh?=
 =?us-ascii?Q?+3Jzg9fOtlYtpad0zNfOcsXgFR5Qv8Eu16V3QvbUM/sRSYx2/o8cGGefaSST?=
 =?us-ascii?Q?IYIpRt3z1nR4JM8pBdqnQ1Kh6ydAWmFsJkfQM3VZSnAt+4grnmp3Pf+eNMHS?=
 =?us-ascii?Q?DffVHkoxt07uBO5PWoYMt8HfRvGvLTGH3t4oTCj7iIwglPRIVLtoSSAnSR+Q?=
 =?us-ascii?Q?Q5WLiOc2myws4+FMFInqzYOPgGLe+joBDnphBm0/IFWTgOYzOOZ99+DKdNId?=
 =?us-ascii?Q?FwwBcSt9WsRRa9OtBRfezhk/qsedK/OaXN797leOordIX6KH0iNs1ATFnfBy?=
 =?us-ascii?Q?Q5mFYAc3NePwcQu6Iq05pfBbXEhkqbrnZB0V2lGu9lVyvclR5F/ZnWQd+LOF?=
 =?us-ascii?Q?SzTG/yEKeXCr/ujwwOJh59HG+xyiuNo0rUasBGu2kYz6036vb8EL4UrfKbTx?=
 =?us-ascii?Q?2lw0nAdQSVnL9puw+0cLKb/N3IqhVbNCYLofJ6RSCkDdgJZZN3ehqg6KJD9I?=
 =?us-ascii?Q?HuY/LoUKsb62WQlRtdhtYqrMa0rbRkx+SL0JwWcPvyvDP3QldfqvJq66ZbNa?=
 =?us-ascii?Q?rNUWDsFKvxO2uOxmtKNib5LxyGoOFtyezXx5nOxrh698FZCjfWYwU+k4cucE?=
 =?us-ascii?Q?sgxzpz2cBEU1FnmH1WK2fCl3/UkKXdbch4BqLdz3Puj+HlVVfE4gq3yA3X1f?=
 =?us-ascii?Q?1fuujwBpABK0x5HJ/rPKPoncQnaDXKL3daUm6Wh98fITX8SqccPWosbK2AjN?=
 =?us-ascii?Q?bWulPa886fmV13ypf/0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144758B19DB4DF3EAF1F8B6F70D2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5ccea1-f274-4d01-75b9-08dc60294e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 04:29:30.6581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/ckQtgwYfCVqPeR1flcY8kdwMuwZDieRrUTb6EMvscAkPV9EAMLNI/o0WZo8YjXCpKg4bZduRj4r7RKnbwfrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

--_000_BL1PR12MB5144758B19DB4DF3EAF1F8B6F70D2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lee, Peyton <Peyton.Lee@amd.com>
Sent: Thursday, April 18, 2024 1:12 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, HaoPing (Alan) <Ha=
oPing.Liu@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Lee, Peyton <Peyton.Lee@amd=
.com>
Subject: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed

The vpe dpm settings should be done before firmware is loaded.
Otherwise, the frequency cannot be successfully raised.

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c
index 6695481f870f..c23d97d34b7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -205,7 +205,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
         dpm_ctl &=3D 0xfffffffe; /* Disable DPM */
         WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable), dpm_ctl);
         dev_dbg(adev->dev, "%s: disable vpe dpm\n", __func__);
-       return 0;
+       return -EINVAL;
 }

 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c
index 769eb8f7bb3c..09315dd5a1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -144,6 +144,12 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *=
vpe)
                         WREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL), r=
et);
         }

+       /* setup collaborate mode */
+       vpe_v6_1_set_collaborate_mode(vpe, true);
+       /* setup DPM */
+       if (amdgpu_vpe_configure_dpm(vpe))
+               dev_warn(adev->dev, "VPE failed to enable DPM\n");
+
         /*
          * For VPE 6.1.1, still only need to add master's offset, and psp =
will apply it to slave as well.
          * Here use instance 0 as master.
@@ -159,11 +165,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *=
vpe)
                 adev->vpe.cmdbuf_cpu_addr[0] =3D f32_offset;
                 adev->vpe.cmdbuf_cpu_addr[1] =3D f32_cntl;

-               amdgpu_vpe_psp_update_sram(adev);
-               vpe_v6_1_set_collaborate_mode(vpe, true);
-               amdgpu_vpe_configure_dpm(vpe);
-
-               return 0;
+               return amdgpu_vpe_psp_update_sram(adev);
         }

         vpe_hdr =3D (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw-=
>data;
@@ -196,8 +198,6 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *v=
pe)
         }

         vpe_v6_1_halt(vpe, false);
-       vpe_v6_1_set_collaborate_mode(vpe, true);
-       amdgpu_vpe_configure_dpm(vpe);

         return 0;
 }
--
2.34.1


--_000_BL1PR12MB5144758B19DB4DF3EAF1F8B6F70D2BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lee, Peyton &lt;Peyto=
n.Lee@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 18, 2024 1:12 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, HaoPi=
ng (Alan) &lt;HaoPing.Liu@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; Le=
e, Peyton &lt;Peyton.Lee@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The vpe dpm settings should be done before firmwar=
e is loaded.<br>
Otherwise, the frequency cannot be successfully raised.<br>
<br>
Signed-off-by: Peyton Lee &lt;peytolee@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c&nbsp;&nbsp; | 14 +++++++-------=
<br>
&nbsp;2 files changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c<br>
index 6695481f870f..c23d97d34b7e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c<br>
@@ -205,7 +205,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_ctl &amp;=3D 0xfffffff=
e; /* Disable DPM */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(vpe_get_reg_offset(=
vpe, 0, vpe-&gt;regs.dpm_enable), dpm_ctl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quo=
t;%s: disable vpe dpm\n&quot;, __func__);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c<br>
index 769eb8f7bb3c..09315dd5a1ec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c<br>
@@ -144,6 +144,12 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *=
vpe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2(vpe_get_reg_offset(vpe, j, regVPEC_CNTL), ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup collaborate mode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe_v6_1_set_collaborate_mode(vpe, tr=
ue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup DPM */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vpe_configure_dpm(vpe))<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;VPE failed to enable DPM\n&quot;);<=
br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For VPE 6.1.1, sti=
ll only need to add master's offset, and psp will apply it to slave as well=
.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Here use instance =
0 as master.<br>
@@ -159,11 +165,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *=
vpe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vpe.cmdbuf_cpu_addr[0] =3D f32_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vpe.cmdbuf_cpu_addr[1] =3D f32_cntl;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_vpe_psp_update_sram(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vpe_v6_1_set_collaborate_mode(vpe, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_vpe_configure_dpm(vpe);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return amdgpu_vpe_psp_update_sram(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe_hdr =3D (const struct =
vpe_firmware_header_v1_0 *)adev-&gt;vpe.fw-&gt;data;<br>
@@ -196,8 +198,6 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *v=
pe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe_v6_1_halt(vpe, false);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe_v6_1_set_collaborate_mode(vpe, tr=
ue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vpe_configure_dpm(vpe);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144758B19DB4DF3EAF1F8B6F70D2BL1PR12MB5144namp_--
