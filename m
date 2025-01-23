Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA84C02182
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2025 03:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F61B10E13E;
	Thu, 23 Jan 2025 03:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXEtjD65";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8535310E13E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 03:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYkY3NVmQoNqSqGQv8anx5eKhQIpom0FZnEKC4Tld4TJeqbQHVDWcBHaqIytfTwUaUeQfHb121nF5B+LCIQhrC3kmc/Cy9P3NKPj/dUE0M/whocFB8UNMtCTaaQ8VgAOqHQHfEtOnNenWes0kcLvbHS0KUxmf017ktJr2s75Ff70o3R63X6rCA/GuQv5ms+VXWIR49K3ENnSTUhdT7W4SWl4KzgczHSJ+lgQSTVpFFQuf50vShG5E5RLJ1DZALx4SddOQRjVKSOr4b0VaT4YbA/bA1z/khhiulpXIBFbG7ICHC17fjca6TDz8Wm7soW63EHEzTDaciXHT7893wWcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfQqNDCwc82688zuQYn/gszXLUdiLkpIUUeJXh7G3EU=;
 b=pmAJLGwiCJdw1Imv5onq4BB+lpTk9h4RRaRTtKJob9QmXoqvmduzEe1ICq4Y5gsJ2ohtw6mEGVlBxD8bn2wSU+B7ikQsaD5qrlLr0u5q5p+2NF6hi0iCql45gxyn1RryMcHznZDvhcwkyEc2UM7kdW3Bh4wyT1aQkNYmyBnpv4BwPdUqARkCPFE202tsEPTlIh77Bjhx6MX3jT+BzxU7otnpCaQ9Vk8P2IQRNBz/KUIEGcomoW+PKn0KTd1THYP2ZxDJeNzvs4wgxPxLgruIee7hNzzpY1twPWUgPJ6VDLbchWPIs6/WRizDVprnhlqztTHfl7xiQzCTzl97/fauuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfQqNDCwc82688zuQYn/gszXLUdiLkpIUUeJXh7G3EU=;
 b=eXEtjD65vL+hyyq4USJbPF6LyVsP+sWCZfpP3Bd9jOXW/2eKoK5VfnYCcbsYAlfWOPeQ/mo35eKAnHTb1dRQSu+fhzKF20ffeAemMGLBY4gKp4h86NyKy1DG7E8pk9Kx6Ms1w+MCQ7+dozjzIhGo8YH05PPFJ2fQlPBH/N70Uro=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 03:43:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:43:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip err_count sysfs creation on VF
 unsupported RAS blocks
Thread-Topic: [PATCH] drm/amdgpu: Skip err_count sysfs creation on VF
 unsupported RAS blocks
Thread-Index: AQHbbRkS6Ut/oTJEMUmt9i5vzcsghbMjto9w
Date: Thu, 23 Jan 2025 03:43:22 +0000
Message-ID: <BN9PR12MB525755B7B5DCD40F369370A1FCE02@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250122215956.421185-1-victor.skvortsov@amd.com>
In-Reply-To: <20250122215956.421185-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9e39ba00-1333-45ed-9ebf-044bd981debf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-23T03:39:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9172:EE_
x-ms-office365-filtering-correlation-id: a51a0cb9-de00-43f7-584a-08dd3b6015a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SuBQNKxxwv0qJMl3piKr1c4pDDMFYxb3NZathICBK0DCLWHj8y1upa/Hg6/h?=
 =?us-ascii?Q?+wpdFEw/VfzNJKWxmVCNBHPFQFNtqA0iy4NCswMihy7TPkbu4a8orJrv75E+?=
 =?us-ascii?Q?ytFbkCqr+gjGqR2aUdfwmoQraqTqhZ4YlMLdJN07VDpzaZct3HFE0YpR2Xil?=
 =?us-ascii?Q?hpdqGPlx7ypvUu/O7ydTB+7WbVAoFhgFuH03mOlujUIEkanRrutW0XG98b7R?=
 =?us-ascii?Q?+pIIycFvgiJzLM9d8N4susvUF0EQfEKbozQDOpneZ9rs3N7wfUyRxK9K6woB?=
 =?us-ascii?Q?gGpb8Z5XuhXJRckeezYrFrKam4iONVF5JEuK/UfRq6ngzBQpBEelmPjSGqfe?=
 =?us-ascii?Q?kt7zBUzImagw2iHG/ZjsRFpVNHPA2cNvAAdFeNCf/uX6Wc1sTvDU1kdkrC5C?=
 =?us-ascii?Q?YlhJ0LAi8ixAQ5O7qCFx/JKQnAJ3R4D/UkG6ZE7Z1bnTsngI5UW1JvgbAomb?=
 =?us-ascii?Q?ZYV/UvXz+FcCrBFgPhhFRTxLj0h1mga0GlH6I1NIneri4/XrEVmqZ6dnUmY5?=
 =?us-ascii?Q?NT3wnOf/AZCFrMdrojq7JWVY/QvVrGCW3wUDhAeI8fEG/prjaxmNM8VyXNiI?=
 =?us-ascii?Q?CRYKDdd6koWLgt3nls44FYfLilqnCmNlkjP610byZWNwXIp9JT6wGYbtFwWJ?=
 =?us-ascii?Q?ErgIGyNwvF5Tg5uyIl+QvhbmjuRa1/OqI53cN/mX+q/JPkagSVcv39124h+l?=
 =?us-ascii?Q?5GHRwQx5+s6zXdTsbJuLwCVx51jWk+f7pCUW5WcWcBXJXH7DMUHIXcsuIRdj?=
 =?us-ascii?Q?+FW4RuzUk6rVcsRTuEmDlR8McMsaBFgbjqAfcuphELXNVfVtOj4j38Ap5ftL?=
 =?us-ascii?Q?27rbu6P+VZDi5jKQOBUsid7fDk+quNVh83H6gQp8hhS+WeMh40qwb0MTQxIe?=
 =?us-ascii?Q?pwsrpAAVrMzNU9/leMze29Q9il74uXMr7LdkkLmlSh8dApoZ30jfh6ANB/2R?=
 =?us-ascii?Q?IndnqhB4bd2K7BRKklMNiTEKecVr+ssrZmsoo15E6+eZ3QhhVuyjzneISl3o?=
 =?us-ascii?Q?mvB/meHYmyRRJ3FjreRUFNCeI0C8QyoQBKCP/Ml3usfYAffK/KW1uYtZG+0m?=
 =?us-ascii?Q?JeqdpwsfEv0/a/L6nFXjSHtyaJ7WZUjj4Ln8UnooJJOhrEYGjDkFb96/XThc?=
 =?us-ascii?Q?ffg+z4re+hOih6/N3Sh2Z8T/lFu1t6IJLcZruiu4rsenx/cQHQOV+2yTplXl?=
 =?us-ascii?Q?607D0I84NMKfrp2YQ5DMx6nGuR/kbgv4oWKIlzjt1UKx1NmHrILrBCuk5QLC?=
 =?us-ascii?Q?7euOpZOHxoUS09K/NwINkjLJ7q5yg88JMuENPNs8zmXv/elngATHVUSGhXoM?=
 =?us-ascii?Q?upRKYCR7+swQCOHjPgGq4S8a+1e+ZYnORXRZmzqGw+X7koZyCYpcGU5jDTlw?=
 =?us-ascii?Q?bM8U/BO211u8u3SNrwor0bthFNd6ubzrJFWeYJXCpCQEDWYtBchnia9/iz5P?=
 =?us-ascii?Q?EKvKfxesk7l+oa2lsQtGhWDNfEaEg0TQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zmtcdchabV5tb4eOVCDlTyiVcWhdhzfgFBGjgBpzaPfhYZFl9dO16HuTDeCH?=
 =?us-ascii?Q?f3YTLSfBz4H/46+OadO05ne6L2Ot0/NPZ/UBxCxU2JQ1Ai/aqQ4Lzih0nYeq?=
 =?us-ascii?Q?zzsDXVtHIz5cJjKIGU+yACYHEEqsTHCtIjJYypjAmz1radla4kYmbVFKZy07?=
 =?us-ascii?Q?KRmAzEchtiQs42stvLY1EAKlKY2sOGboxmMytDVHYSOh5YmTbNzQWg+aRzbb?=
 =?us-ascii?Q?xSJNM5/AbtMD1fhP+KqT2YyW5nTUNnaKjNyGng2ooOixizyrerag0SS1gai2?=
 =?us-ascii?Q?o+NnXRc8MZg4WRoWyYczp+5dX/dg3JQdID4QXGoerNCHIWAGbso8GrhSbfO/?=
 =?us-ascii?Q?Nd7jClx5ioXhnaiRU1rEcn2ShYKpkCneq9BN+ZAMFzU+YpdQFcqUj81XhX+e?=
 =?us-ascii?Q?iXciHDyVt65t0EvewHsW7XvS2WWI/XyZXIr0okAWanY7ND8hLU+rugcHakgt?=
 =?us-ascii?Q?249vUD8Q5FNPxOI84cBWzC9hmE1Sga1dvkk23Zuwq8ByLcNJaLOnApgkkNdE?=
 =?us-ascii?Q?aiUmZsG25Xgh9tR0L9W/tMv1VJsrm2p/QVI+ZQTVb7PSR/0roADuvUN+S/dP?=
 =?us-ascii?Q?sxe5wI9XiSz0+2JFpzSoNIezHl3QmGfz6mDIjP0bm5KPWyIlZ6q8d5i+OnKr?=
 =?us-ascii?Q?GiqL2eGqIIfzTAsPABIC5u2ocrp3dcNNoBuh7vF0vNrSUaLhLie3sYMHieeP?=
 =?us-ascii?Q?o6UV6TfftPozlew+2DRYu/bEqz/2d4GCHSU02GU0U5VQSIhfh7xi49cwXaYM?=
 =?us-ascii?Q?POLiBAi2LnrJSe3weay81jVyzy7Ah91gEorRrNLomQVyQoHw8RalAYXbIYdh?=
 =?us-ascii?Q?KhRZEEJoYtCxhYORSKLv97EOeSipzeaJgReEcIhu/H0oqP1fsZ/6WLf968+d?=
 =?us-ascii?Q?CYGn/ZaG6wCf98Nx6McVck5GU91ly3a2566fSbs1dzcgwA2ohaQPm0bySuIu?=
 =?us-ascii?Q?sfphk1yQJGjeMTlLFTV2kzOHaAWE3wnDRNkih/F7+f+bztZU3OAyekkNqkfI?=
 =?us-ascii?Q?PHcpkM/uBdNbPekaDo6fpFQFbilz5UJz7viEOxheJy2aVCjRjiozhWHIUNWg?=
 =?us-ascii?Q?gBjcIJbvvV2ZqeaNgOe0t2k0GrLr61Rtgkp3gjqLuhmwJqDZvRcZLqf6ml8j?=
 =?us-ascii?Q?4Gl5AKYy6BFlZeOf/Nn+aIuGJMEMliJfZfnr0i0H0MD5NpdAB/C+/8TjQwGE?=
 =?us-ascii?Q?BVutoAZunNwFY5bM6iKX8DQtXvwr1fRMYAlL8Mr3gBpzx/wWmHcVJZWf1YNR?=
 =?us-ascii?Q?gYAN+CNWMenERM+k7/mVy781DCyV/J7nQzbWy4y9WLOmpdywEfB4afqUDr82?=
 =?us-ascii?Q?L9QPNWFf2aqtN//hsbQGt3xifdiEgr9gLERMPrGXgLRxjWheAJBoljmz1WIK?=
 =?us-ascii?Q?l7o9x1yuESU+PVP2SONOPO+qep1nOXKe+6j7OY05sHZO5L8jjtLtqwAO+/aS?=
 =?us-ascii?Q?pcd24v5y5+f6k7ZiR23dY/+NBmLSZO5NDai+c3PxZj/til+ZW7ukGmB0Rtdq?=
 =?us-ascii?Q?8/ep6HFW/KJujb/LkXq+68W2Xh7KWMDygHWlDh6iSdyxZGmTVtITTMSb9Ojr?=
 =?us-ascii?Q?1tgpXjIUotP4PGX2OSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51a0cb9-de00-43f7-584a-08dd3b6015a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 03:43:22.2588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwa0OmmkMIiYUq8mx1wvMyr+rqYdMY0cRtzdgJPR05DOrdc+E68WPadJXIcFu7paFtzxTFnBZEMmW9OrdPtz8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

+               DRM_DEV_DEBUG(adev->dev, "Unsupported SRIOV RAS telemetry b=
lock
+0x%x\n", block);

You may still want to keep dev_err, other that that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, January 23, 2025 06:00
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip err_count sysfs creation on VF unsupporte=
d RAS blocks

VFs are not able to query error counts for all RAS blocks. Rather than retu=
rning error for queries on these blocks, skip sysfs the creation all togeth=
er.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  3 +++  drivers/gpu/drm/amd/amd=
gpu/amdgpu_virt.c | 16 +++++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_=
virt.h |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f0924aa3f4e4..0c338dcdde48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1864,6 +1864,9 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *ade=
v,
        if (!obj || obj->attr_inuse)
                return -EINVAL;

+       if (amdgpu_sriov_vf(adev) && !amdgpu_virt_ras_telemetry_block_en(ad=
ev, head->block))
+               return 0;
+
        get_obj(obj);

        snprintf(obj->fs_data.sysfs_name, sizeof(obj->fs_data.sysfs_name), =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 0af469ec6fcc..51ec98501aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1246,7 +1246,7 @@ amdgpu_ras_block_to_sriov(struct amdgpu_device *adev,=
 enum amdgpu_ras_block bloc
        case AMDGPU_RAS_BLOCK__MPIO:
                return RAS_TELEMETRY_GPU_BLOCK_MPIO;
        default:
-               dev_err(adev->dev, "Unsupported SRIOV RAS telemetry block 0=
x%x\n", block);
+               DRM_DEV_DEBUG(adev->dev, "Unsupported SRIOV RAS telemetry b=
lock
+0x%x\n", block);
                return RAS_TELEMETRY_GPU_BLOCK_COUNT;
        }
 }
@@ -1331,3 +1331,17 @@ int amdgpu_virt_ras_telemetry_post_reset(struct amdg=
pu_device *adev)

        return 0;
 }
+
+bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
+                                       enum amdgpu_ras_block block)
+{
+       enum amd_sriov_ras_telemetry_gpu_block sriov_block;
+
+       sriov_block =3D amdgpu_ras_block_to_sriov(adev, block);
+
+       if (sriov_block >=3D RAS_TELEMETRY_GPU_BLOCK_COUNT ||
+           !amdgpu_sriov_ras_telemetry_block_en(adev, sriov_block))
+               return false;
+
+       return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 5381b8d596e6..270a032e2d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -406,4 +406,6 @@ bool amdgpu_virt_get_ras_capability(struct amdgpu_devic=
e *adev);  int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, en=
um amdgpu_ras_block block,
                                  struct ras_err_data *err_data);
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
+bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
+                                       enum amdgpu_ras_block block);
 #endif
--
2.34.1

