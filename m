Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1348DC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 02:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DA310E4A3;
	Tue, 24 Jun 2025 02:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tgL+vBBu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E575110E4A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 02:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS/8Z8Pih+s9VwR3xnxayecqJ0WiZgv8vharF6EdUwjPx1gsfgam+zYNm2piWt5ga5NRgm89g1X6I2aLHBecxJBrcDyCCwRBCd9SnKBzSba/uEAukGp0tb2P0fLnOLigtmZZdeuO6mGErbdMq8h8XAdIjWeeWsUSgaGv1Lc67lsV6QarKLEHrZlXOfwVKEDrKb49n4FFVrJW+9C7m6xrC5vjfioQFArMjke42gtzw2NVyhvzbhIJCRcY1rEs9IrQtzN6zYDU3pJyrAiybEdfffdubTSQ1eY+myI2xd5m75S62p7At8oq0mp5XxXmB/Kk+3bdN1259s2eFG8MYrlVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7NK6lwn41OFM0Mu5Z3uMmVXa9I6W1qKKSCT5EiFtg8=;
 b=gFVh8TNXSpTY5HvmCEhpJeAKc6NSvJx4mokUJJwqxAv4wTm3D46vcNjhYN2MFCA6QUHaEaBgsKwAkpfwcD0teJlDe7MTFgj4euFVlml2VUW8NmpKpE2GQc2mHysTE4nzgkrI2/znz77tlm5l4bxFKlNzDiGGvbwkSA2afGH3QxJNK7m4lNwmWWnbGKEB2snBTxsS0ffEz+zyJx5Cxi53DVHSi1ECX0Rua7ao5VtgxlUDWU6dyFU0R5DU5tEYQSCd3oqNfpqodDYLF9mrRmiUTozCRCAQTL9TzsxVRW0nFeRY0h+G7sFrh17lzfp9ouYziKD40jZxvrXKkuqDix0ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7NK6lwn41OFM0Mu5Z3uMmVXa9I6W1qKKSCT5EiFtg8=;
 b=tgL+vBBuppHcMZn4p46bY7q2FnnJYLUPcgR/y7y16dcwewzy3c6npiy8ZzhD9v8CiJWMzfYw/MzBlZGoVYxgaoO+WVnr/ImhHFE/xdHY2xenek3u60VeDteiHLGDJQN2qlV9vef9ByDcmy8l2u7ZpYqS4MrlA6/onwo5viJaY9c=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 02:42:02 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 02:42:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma6: add more ucode version checks for userq
 support
Thread-Topic: [PATCH] drm/amdgpu/sdma6: add more ucode version checks for
 userq support
Thread-Index: AQHb5HftgccSiry680WJSFSxm+DpMbQRmitg
Date: Tue, 24 Jun 2025 02:42:02 +0000
Message-ID: <DM4PR12MB515233DF3E08A2842E18EFC2E378A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250623194900.144270-1-alexander.deucher@amd.com>
In-Reply-To: <20250623194900.144270-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-24T02:41:57.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6550:EE_
x-ms-office365-filtering-correlation-id: e5ac1b89-8445-4b6f-9b75-08ddb2c8b2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IJ/8It8JBzFBvgWt9IucywOf/R7Y9M38wlSs9OOEyMfUmpFGKQsYAeV2M+a4?=
 =?us-ascii?Q?g6koWf6f1eqilWF4ov+NGVib5MTA6A7Yvpiml9Y08xw3Gn8PaPjP63d5wKOK?=
 =?us-ascii?Q?9m+EtFie9CEb8uBiAO5e3D+fiVc/9CpoOv6ZHRgHbV+/J3ECMJ6Ej4E8JcOq?=
 =?us-ascii?Q?SOt7e4Y2KjXy82E3kAZrkFlw58MFKZiT7IQtmYZ3kKSHTgIz4Kl3k4wj1x6j?=
 =?us-ascii?Q?2mIh0gcKVNvzZS0KpWMZL1PaTI1EsvZtaBT/24YidqXno9wo756Lu1hK/AdU?=
 =?us-ascii?Q?eVAuk6pPXgb6wdBJs+Il1mLXth+ZRtWQFTurwvWS20Y7Ljb55VjQD7D5R3Cu?=
 =?us-ascii?Q?EIJyfLGlfjnHKwjuODsY1w5FDL+xrVlbPs9+vg46/3BOksNUQjDljbSRf4dM?=
 =?us-ascii?Q?HiBrxuHHjQZxuabGi8wCe1XItzQYhrJOLhEasLwsI54+U5RGyU1m/Du0Zn9s?=
 =?us-ascii?Q?P8NLuOdoU1ung6FgS2u0yARt9cXDorjL1L4+zVxMyOVATsCITxJBHxxv8f6Z?=
 =?us-ascii?Q?X7sQjo+CAA2EUmWb1J2yXrW3E9HZexORgtx9ePx74WwzBcmIMkMXMOgIKZbd?=
 =?us-ascii?Q?wenpPxCEt2FUbhOxBYK1XM9ctSROCzaLy9bmfXCVuKusHD2DaFtYgF6MFBrJ?=
 =?us-ascii?Q?qWos5sqH6aaOXY8PghDtSks9et103CROv9RAD9akd/h82C8bjfJAEYhYusdJ?=
 =?us-ascii?Q?PjSpvFQ4CtxdLwXIEvqqwGK80UIMmaWNve7a1LrNX/GyZfO9GnSk+jvHVpC4?=
 =?us-ascii?Q?uqZLIu3x+e8y30kYLjbedayvrInqV7W1XALfP7nhZLSzknz5t5j2wqTYX4am?=
 =?us-ascii?Q?nfATmW12UbIgrvp6icCIgcAQkEf4NHmu57eYVAymksrkglRg7RewdDQrDgCl?=
 =?us-ascii?Q?Dsrh5jEW1kaT5W8Va1FNLGaKu2oOc4ySCXCiOqFVR2B018jQe6/lwVTfum6p?=
 =?us-ascii?Q?Pi3x9Br+1l4xxZbA5VRY6Z9eZBNZtbCGWHDlamVQbCvKYh0WU39fVFDFm9n7?=
 =?us-ascii?Q?ZEhYy13kLdDjrLsozmTPCowXeA4ScYmvhHvhwmIEKyrbpv7QmRh+kzYKTPWw?=
 =?us-ascii?Q?7EdRpMLCLSl2LGv1KI3xQHjuTeCdxTaVKVi39RPY86BMgG1VLhx2EotgYbul?=
 =?us-ascii?Q?AsTUOo96lebWNoDTQCC0pkP2kbAlWcLDx/smZFRt4QPEPOC0EiVblFLaeNQ9?=
 =?us-ascii?Q?SJTGG7qbzNNHSgZwlcKueQXG7A5ca+WNkgJX9VkuF1KAutweSeQK3tom3LXS?=
 =?us-ascii?Q?gGwFYw6q9zZjQP/0GQa5qgIX42ahMZN/lZDoMPH/bfp+8Y2TEYMANNS8Tryu?=
 =?us-ascii?Q?eMDNlAziS2pQhbFtJiPlZOlZMgbzSVJMlJxQS/UXhjJoDGdZAi7Cy2wZFaE7?=
 =?us-ascii?Q?WQvMrWtsToq8yJfelWRnBOeSj3kDic/TJozPtney4qzorTQhL7aOIF0/8wpI?=
 =?us-ascii?Q?UmgDa3AJd0myxS9d5QCYghzCyhtX1WWu5dNze9nTVTGRpoDAxq8ShQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tbLnsb8qT7IX0zRGBEJlAU9cyIoXELJ2O0cXKqyvHzJxfPLb0KJJwvvB7UU5?=
 =?us-ascii?Q?9BsPQYHZpPJ9Wdn88alUKaOf8FWpp3fwQ6WWYyz1STi1LxxpPIodeIH6nrz8?=
 =?us-ascii?Q?U5SDCL4RotTNp0DpHc5h3v0+P9RUosSMiB34ewFnH7GRiRUbxqqjz3jPtIL3?=
 =?us-ascii?Q?u/wg2vHWXjzJgHp/EGlLDloNHgyYhNfC6X7CzjpY2BpSVjtGbi1+Jddl0W+8?=
 =?us-ascii?Q?V47/ZULg4ezLVGBiqaSHx7mRLTd3+nwlgSaPrYptUB2lA0ljFtguck47vr55?=
 =?us-ascii?Q?8WGIsVUOyPvQFR6TgMhIagkcB3A5O89IIeMtTBbCa1wSQYOFPSwfKehwodTF?=
 =?us-ascii?Q?Y1a0P68ptZKtvQyJbU1aVv7pJvkEykpJm/5p/BeSpQNMlYpn0BO4NhL9rfJV?=
 =?us-ascii?Q?d9G7kb4wc4iWbXJEBABcmsmdor9GdVs8GPLrNzALL++KyYaYZ5zzPHeLD8gq?=
 =?us-ascii?Q?R2qGzc5ZryHdPdsp149ch8RMYsCI58Z55Y+y5OIG4a6nxacriq63u/htVNAn?=
 =?us-ascii?Q?jCnThy8G8vsS98NAXXboZ9ak+NmGdTIOQug0Ka2W8hA3P83wyw+Lsc64qRCM?=
 =?us-ascii?Q?vvqeqVkeerKqoCMIWAcl0ZzuBx1JvyH/it4F5BRwjU5M0elwyp7c6MIc7feL?=
 =?us-ascii?Q?qkv1zaN8LTPY7XYrni2MjauhQCMkx1OwQ3sxBU9+lAV+TjR4kO1c8qjiJmKF?=
 =?us-ascii?Q?w3d7JhgCrXQp3o6Ia9hytCH68xa6lEol1L9LxyPRKFSDXhsI/RToTPcYFf6C?=
 =?us-ascii?Q?dImjs61ag+Sb5aHOs7o4OCuN2+2QDMz5grE9FaCFZbhbKlwOnk7LtOeaHaFd?=
 =?us-ascii?Q?/thlaFee0EtdYQObVA6ENSLw4Z4IKEMEbpbg1i2JOVI3xZf516OdlpL6cgnh?=
 =?us-ascii?Q?ClJoYpleJEkcpxDtgVXyHtjA2Rkvh34snI4AaQDuNOs1MB1PA+EpYc6vMtwv?=
 =?us-ascii?Q?HoAhcNzFowPD/T7QThCGIaUrzCmqcaY/cLQWqdJ3FwFecBAYvnYDMEnX8tC4?=
 =?us-ascii?Q?kREILsGXT0f9y4jd2JQtUn2DsiilYr9C89sxBMl70F4EKYLOU/ee+FEcrQ2C?=
 =?us-ascii?Q?A8apR6Qzxpyf3+dMtxYtEdpIO3ni+mOIAmoJ9K5ngix8rg/suSL0id8PweT8?=
 =?us-ascii?Q?EI3KfXoYuOm32lNUc3pX6qfdIplUk8gTxsXWxMKmKHH8PxoDCJHgqnlH1eic?=
 =?us-ascii?Q?22BmAppKf1pr4RU3fpuzeDiSsa4qMLN01GSQnmhhAbn03NUZYCVMinc5d6Cv?=
 =?us-ascii?Q?bVEeLXE5TUAAQSiTMQLPM2GpKbuZKRQGEdTyp8HPRrBq291dT/3sV1K8AsNM?=
 =?us-ascii?Q?5FJi6ijYOSz12lSaI2AUwyfCZj7M2wAcUSNu7paC1vttE/LxysifB2W8liGl?=
 =?us-ascii?Q?nquVXovjmepxAUvID9n5sMRVcKnkW2k2FXQYR8M8RivdLP3UKNvOChzcL4i0?=
 =?us-ascii?Q?7LQ99q0QUEcDtShp3gjPlMG2Pi6nUez7hB4ug2OHtiZZf5b8ZVDayKTpzBKN?=
 =?us-ascii?Q?k+QL4+811wt2P6U+lAwE3rzIfNFqQkO1GGMZH/Sa7kl1oOdLSETo5togZwUd?=
 =?us-ascii?Q?9oqdpIqe0RYXaMxlIQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac1b89-8445-4b6f-9b75-08ddb2c8b2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 02:42:02.0296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1K70c94YlLnATi1vyh1wbDLai67WA/NOPnKHHd8ro6I/3FYCV82RM9aszWsTNLSNv6W7P9hOLYJ897ZD8iTgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, June 24, 2025 3:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma6: add more ucode version checks for userq =
support

Fill in the SDMA ucode version checks for more SDMA 6.x parts.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index a9bdf8d61d6ce..2f3250d30bb01 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1379,6 +1379,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                if ((adev->sdma.instance[0].fw_version >=3D 24) && !adev->s=
dma.disable_uq)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
                break;
+       case IP_VERSION(6, 0, 1):
+               if ((adev->sdma.instance[0].fw_version >=3D 18) && !adev->s=
dma.disable_uq)
+                       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
+               break;
        case IP_VERSION(6, 0, 2):
                if ((adev->sdma.instance[0].fw_version >=3D 21) && !adev->s=
dma.disable_uq)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs; @@ -1387,6 +1391,18 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip=
_block *ip_block)
                if ((adev->sdma.instance[0].fw_version >=3D 25) && !adev->s=
dma.disable_uq)
                        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
                break;
+       case IP_VERSION(6, 1, 0):
+               if ((adev->sdma.instance[0].fw_version >=3D 11) && !adev->s=
dma.disable_uq)
+                       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
+               break;
+       case IP_VERSION(6, 1, 1):
+               if ((adev->sdma.instance[0].fw_version >=3D 14) && !adev->s=
dma.disable_uq)
+                       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
+               break;
+       case IP_VERSION(6, 1, 2):
+               if ((adev->sdma.instance[0].fw_version >=3D 12) && !adev->s=
dma.disable_uq)
+                       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_=
funcs;
+               break;
        default:
                break;
        }
--
2.49.0

