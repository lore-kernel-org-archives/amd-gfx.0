Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE08EE645D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 14:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E815810E637;
	Fri, 15 Sep 2023 14:03:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB6110E635
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 14:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFZ4iDfobNNXynECP78Exv0bxtCVsU/Dx5brvdqEbBk0TVz6ccFyfudkyEtBizx4fBj24HOYCVMF6/3evc9YGLqbbjb5RI+vkBrFIPoPYbFt3H6G/yTJr44dfajxafK9AcoP4yFNfV2svuFo5jA9GMNg0kXmEiCu0RwpzMGeMybpBe0FrCM/IzMISxEc6gimQ0q2kIVR9+Gvm7dUwZcXaYq6J0alstIzV5VsDHVpHrEWTGQ7ogmSv0gjBHPZYXVc5a0uySEhNmoI9xvctaaUqf0U9gtb7Hyj9858HbL8pCvKR/MKY++QStSgenaiuo1vKw9lYQgIXh7x6papCH8wCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE4ijbVJyY37gynpBj2lnURDY4C7//8YCnv5Lo7ONl4=;
 b=i49CAxuwI4dcAh9dX1X7v9Xt/4GsNn7Won58bA0kpXRv+YTZNbMTu/3z6xbA6elBHQj3DYxLFjU8huwlI3ZlF5Enjj7Pgt4FT5x92cWJEkEqoGAl0+ffpg1DhF5d+enJvK3IFnzhzFGEtvcLciTM/bd97Qgu8050fLRPXsWuvwBV/9gd0/VBOqonWQvIvIJBEOy5F+ib6QjppQJJzS/uYHKXu4xWiAXHs2Zw78sLekDvf32NlIQvtng6CAYK6gW5oL+kW0jcHIP7XLa9C2WEzOTsaCflFu+hkG9Kh2q9O9ChW8pBRZFjYe/36Ja1rZ8tE/Pnft6VO0DedUIBG2ZWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE4ijbVJyY37gynpBj2lnURDY4C7//8YCnv5Lo7ONl4=;
 b=PjTUM4S8LMgSNPJBMEA2qSl6Pu4YceDm1y4nJaSYHxLcSq4BoAOr9i3iyWpqmek+1U75ajr9TU5TduGUTqMOiMkfsPs+ZA+LYKOzLnsiGnD/aor4AwuLfD9d0hUQ7GbO2DvVjn8Isx6JzV7ejSse7yxD69unFPAvA8RA0T/bJ9c=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 14:02:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 14:02:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update IP count INFO query
Thread-Topic: [PATCH] drm/amdgpu: update IP count INFO query
Thread-Index: AQHZ5ySwqfU39905/E26pZJOLvtUlbAb69p3
Date: Fri, 15 Sep 2023 14:02:59 +0000
Message-ID: <BL1PR12MB514444896B3183F907CCBD07F7F6A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230914160050.2672457-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20230914160050.2672457-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-15T14:02:19.759Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: 07e112c7-f5b6-4077-69dd-08dbb5f47838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrxK9XnRbSqyhsLmM+tq2s6JxCQrNjgYlLlIKalhObj09qwEtFIJCqEa+dmGzBlMcpC/66vsZOeND/yYZGd+vBe5IjBjjzy6eWFOw0pQxcV78epljTAl70eKTK4p/N07eQemuqYBd6p25VPKPiIUmkzdFTQsc9/ungpDQ3fXdPDU4WiegaLRqb+rJ0fGw6w/k8WvNOV+QFhj3i3dfAYY/pE/IppFBXBOnuS+8KrNUqMCMpRBr9FDiZYlvOLvtg//P5hklo79AyIk2RybW5xgaVaxEPTg6rjQ8kdKv59Yf3bkhm3XCZP9Voe9pMjV85NOscO+LW6q5ysRM/U6PZK/u2MT4Xs/a07tqhQFJkK3EayikLlc25eJn6307osvlTgVA4AshSW5CUIz23KXx5vtc1HbFVGBBe7Bn3YVOi587w7x7yiyCqcITKq4sfujLg64+SqOioXQ+DIgDYFFvqF+weM/ha8qJWfrskcft56C4mUskocl9iDah3MR+43CAFevFPD3W1phrAmYTlJMQYWbw0wdZyU6yguSNEhAhSjfB0yIK/UQVcL6O/IyNUqN4eOcKcLNhNxUGdyRlDLnZIjV9Fyidssjp+ENynnnhVN6//dHr/28H355MliCPY1ur/Cp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199024)(186009)(1800799009)(122000001)(38070700005)(38100700002)(86362001)(33656002)(19627405001)(55016003)(7696005)(6506007)(9686003)(2906002)(478600001)(52536014)(8676002)(110136005)(8936002)(15650500001)(41300700001)(5660300002)(4326008)(53546011)(71200400001)(83380400001)(54906003)(316002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PXWzNH+yncBtRtrjaTb/3+YRgcAXYib99zmtb2BM4EqZz5fXopJ7Ug1yDSps?=
 =?us-ascii?Q?BfMa36mdX2K8HyUBpMM5R43WNN3zvxLjaFFnhr16gSMUnItmAnzBW0bZqbzv?=
 =?us-ascii?Q?3/GgkN1VfMDE/Qsm5zlYR+cxPAyCpoJjGL2/kGi1P1TbaWrW1XryMnIg32Iq?=
 =?us-ascii?Q?20dTDXURdUlxKQrpXjJzVqGz26edQtuXyfVRc4vRA4qx6canebTWe0Ra/+ma?=
 =?us-ascii?Q?kO6IYU6Z23lLCps1LfZ3i1Scqoli7UHiIEnAssUlCPlo4vbjcdXZO7jHJghC?=
 =?us-ascii?Q?OEpLY12cyppqqQPPvLxaV+nyZehAM9K0Cee9q17QXbI/JRQjYOqVk03WX2U2?=
 =?us-ascii?Q?DdHxZzX5QdsIdF+OdD5N2FHWZeERF1rOMXk0lCwp0sWu2Kpu6g/i4rVOCefZ?=
 =?us-ascii?Q?ia9dk+x6jeInIrK2cKmATdA9kEzAGXRrgX8mGpZxl6EO91dlwhjCCrawvZwb?=
 =?us-ascii?Q?PRdF9khjQgSWzpMJAiX+xB7n8PArqk20zT/uX2q/gHm+oTUQAD9ztyTvfMhx?=
 =?us-ascii?Q?2VfzwEFwDkxztbdWaNZK6DyvYPUQPtS2kOxSBBqUcUFonyIjjtfaED43aOZf?=
 =?us-ascii?Q?XFa7Zd5P9Yqa5G6R69QKVqsJlr45z0U4+DaI+BULDABssbnPdc09BBqBaceU?=
 =?us-ascii?Q?NztszYYbLngXH/mI6qfK23Ky0jfpUi9msRTzobLUt0TWR+3p6oXKABjc16Z5?=
 =?us-ascii?Q?wNJTElxJi5JGDyrikKumej+bo7Beuroq9JKrfODSOX7vlqDHWMOcsTGb+mH3?=
 =?us-ascii?Q?bCfzSUdxQ+y0cyTUR+lGSVnDxOIZftM8NNcs6J6BhQfueIpPEv9amZq/esuU?=
 =?us-ascii?Q?mfZ2w8bZiD6Ml4jthKsYToY5RtNpxxI8B3KWWyD8mPuO+yKkU6Kcx1nz1DcB?=
 =?us-ascii?Q?DdC2xsfSC1BKI3QBWfwbN9lncKgXeq/PY1s73CZDdfoo4Ba9JveX7WT0MXFK?=
 =?us-ascii?Q?G1mGEnFNd39pspClP68t69BX7oj9/qFtaPX5erRMHXKiAjA1qZZTu4Fp8Dcp?=
 =?us-ascii?Q?T4+26JtuFzioGK54N0+g+cz3L8EIqJgGAClMm+6ttA1Js2pWvt4nrLrCwJha?=
 =?us-ascii?Q?hgVqQTSKmWXwg15xuY7gvraoT5eFLofMr49xanZO3cOYKR6CxsxtfJUAZs0X?=
 =?us-ascii?Q?l/l/SYpUEOHzU7A6Q9zp9MWw0z47hQYTMum0dcuKAqp9p2/bw0joAZOotz3w?=
 =?us-ascii?Q?tUsGI8Ysy3epLmz+xqRzWrfC1dSYvccPqse8rZQUkr8W1oUYbhDt3prpzFti?=
 =?us-ascii?Q?mbR1F5IuAO5jRUOyQlNbseaRc1LsduBSHEWvBRcbw5pQWV3xxdCWkJsHz72T?=
 =?us-ascii?Q?4kFIoMMYFYkuQ/FTRCotoPaXSAa36MSCLblzm+qVTlilqP+q0LtoYLh+CMI7?=
 =?us-ascii?Q?9f5V+w7cNiFNGjZzrFDrlJItx5UiGkB8b822COOfKqHErnXrpNS6n68r8OKR?=
 =?us-ascii?Q?o/mJjMSVBlkqmT6G+s3VrVhaRC96QS/YTXg5W9gz40OOzbu/3za3gTsNLY30?=
 =?us-ascii?Q?sNMzbTLQU6IydkZIqyASMUTVMKGcvvLKO0E7bqUW65YF2X9zuoaGgKU0QgsE?=
 =?us-ascii?Q?DDHH2sskywDvUag0CzY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514444896B3183F907CCBD07F7F6ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e112c7-f5b6-4077-69dd-08dbb5f47838
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 14:02:59.6117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXgBZJ5OENN36IPOmVZIKwPPQWCecwLhz+rffmkyPOBfIkxW4tYoJOGJFVJpjk0TaUFbuhXVDu588fwMPuJJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514444896B3183F907CCBD07F7F6ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

For jpeg, if the rings actually represent independent JPEG engines, we prob=
ably want to expose adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings.

Alex
________________________________
From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Sent: Thursday, September 14, 2023 12:00 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Sundararaju, Sathishkuma=
r <Sathishkumar.Sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: update IP count INFO query

update the query to return the number of functional
instances where there is more than an instance of the requested
type and for others continue to return one.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 90 +++++++++++++++++--------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 3a48bec10aea..9521fa7a1bf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -200,6 +200,44 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev,=
 unsigned long flags)
         return r;
 }

+static enum amd_ip_block_type amdgpu_ip_get_block_type(
+               struct amdgpu_device *adev, uint32_t ip)
+{
+       enum amd_ip_block_type type;
+
+       switch (ip) {
+       case AMDGPU_HW_IP_GFX:
+               type =3D AMD_IP_BLOCK_TYPE_GFX;
+               break;
+       case AMDGPU_HW_IP_COMPUTE:
+               type =3D AMD_IP_BLOCK_TYPE_GFX;
+               break;
+       case AMDGPU_HW_IP_DMA:
+               type =3D AMD_IP_BLOCK_TYPE_SDMA;
+               break;
+       case AMDGPU_HW_IP_UVD:
+       case AMDGPU_HW_IP_UVD_ENC:
+               type =3D AMD_IP_BLOCK_TYPE_UVD;
+               break;
+       case AMDGPU_HW_IP_VCE:
+               type =3D AMD_IP_BLOCK_TYPE_VCE;
+               break;
+       case AMDGPU_HW_IP_VCN_DEC:
+       case AMDGPU_HW_IP_VCN_ENC:
+               type =3D AMD_IP_BLOCK_TYPE_VCN;
+               break;
+       case AMDGPU_HW_IP_VCN_JPEG:
+               type =3D (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_=
TYPE_JPEG)) ?
+                                  AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TY=
PE_VCN;
+               break;
+       default:
+               type =3D AMD_IP_BLOCK_TYPE_NUM;
+               break;
+       }
+
+       return type;
+}
+
 static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
                                 struct drm_amdgpu_query_fw *query_fw,
                                 struct amdgpu_device *adev)
@@ -592,45 +630,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
         }
         case AMDGPU_INFO_HW_IP_COUNT: {
                 enum amd_ip_block_type type;
+               struct amdgpu_ip_block *ip_block =3D NULL;
                 uint32_t count =3D 0;

-               switch (info->query_hw_ip.type) {
-               case AMDGPU_HW_IP_GFX:
-                       type =3D AMD_IP_BLOCK_TYPE_GFX;
-                       break;
-               case AMDGPU_HW_IP_COMPUTE:
-                       type =3D AMD_IP_BLOCK_TYPE_GFX;
-                       break;
-               case AMDGPU_HW_IP_DMA:
-                       type =3D AMD_IP_BLOCK_TYPE_SDMA;
-                       break;
-               case AMDGPU_HW_IP_UVD:
-                       type =3D AMD_IP_BLOCK_TYPE_UVD;
+               type =3D amdgpu_ip_get_block_type(adev, info->query_hw_ip.t=
ype);
+               ip_block =3D amdgpu_device_ip_get_ip_block(adev, type);
+               if (!ip_block || !ip_block->status.valid)
+                       return -EINVAL;
+
+               switch (type) {
+               case AMD_IP_BLOCK_TYPE_GFX:
+               case AMD_IP_BLOCK_TYPE_VCE:
+                       count =3D 1;
                         break;
-               case AMDGPU_HW_IP_VCE:
-                       type =3D AMD_IP_BLOCK_TYPE_VCE;
+               case AMD_IP_BLOCK_TYPE_SDMA:
+                       count =3D adev->sdma.num_instances;
                         break;
-               case AMDGPU_HW_IP_UVD_ENC:
-                       type =3D AMD_IP_BLOCK_TYPE_UVD;
+               case AMD_IP_BLOCK_TYPE_JPEG:
+                       count =3D adev->jpeg.num_jpeg_inst;
                         break;
-               case AMDGPU_HW_IP_VCN_DEC:
-               case AMDGPU_HW_IP_VCN_ENC:
-                       type =3D AMD_IP_BLOCK_TYPE_VCN;
+               case AMD_IP_BLOCK_TYPE_VCN:
+                       count =3D adev->vcn.num_vcn_inst;
                         break;
-               case AMDGPU_HW_IP_VCN_JPEG:
-                       type =3D (amdgpu_device_ip_get_ip_block(adev, AMD_I=
P_BLOCK_TYPE_JPEG)) ?
-                               AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_=
VCN;
+               case AMD_IP_BLOCK_TYPE_UVD:
+                       count =3D adev->uvd.num_uvd_inst;
                         break;
+               /* For all other IP block types not listed in the switch st=
atement
+                * the ip status is valid here and the instance count is on=
e.
+                */
                 default:
-                       return -EINVAL;
+                       count =3D 1;
+                       break;
                 }

-               for (i =3D 0; i < adev->num_ip_blocks; i++)
-                       if (adev->ip_blocks[i].version->type =3D=3D type &&
-                           adev->ip_blocks[i].status.valid &&
-                           count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
-                               count++;
-
                 return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT =
: 0;
         }
         case AMDGPU_INFO_TIMESTAMP:
--
2.25.1


--_000_BL1PR12MB514444896B3183F907CCBD07F7F6ABL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
For jpeg, if the rings actually represent independent JPEG engines, we prob=
ably want to expose
<font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12pt"><f=
ont size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted0">adev=
-&gt;jpeg.num_jpeg_inst</span></font></span></font> *
<font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12pt"><f=
ont size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted1">adev=
-&gt;jpeg.num_jpeg_rings.</span></font></span></font></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12pt"><f=
ont size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted1"><br>
</span></font></span></font></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12pt"><f=
ont size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted1">Alex=
<br>
</span></font></span></font></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sundararaju, Sathishk=
umar &lt;Sathishkumar.Sundararaju@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 14, 2023 12:00 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;;=
 Sundararaju, Sathishkumar &lt;Sathishkumar.Sundararaju@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update IP count INFO query</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">update the query to return the number of functiona=
l<br>
instances where there is more than an instance of the requested<br>
type and for others continue to return one.<br>
<br>
Signed-off-by: Sathishkumar S &lt;sathishkumar.sundararaju@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 90 +++++++++++++++++-------=
-<br>
&nbsp;1 file changed, 61 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 3a48bec10aea..9521fa7a1bf9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -200,6 +200,44 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev,=
 unsigned long flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+static enum amd_ip_block_type amdgpu_ip_get_block_type(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_device *adev, uint32_t ip)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type type;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ip) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_GFX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_GFX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_COMPUTE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_GFX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_DMA:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_SDMA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_UVD:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_UVD_ENC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_UVD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_VCE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_VCE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_VCN_DEC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_VCN_ENC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_VCN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_VCN_JPEG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_=
JPEG)) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_JPEG : =
AMD_IP_BLOCK_TYPE_VCN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D AMD_IP_BLOCK_TYPE_NUM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return type;<br>
+}<br>
+<br>
&nbsp;static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_i=
nfo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_query_fw *quer=
y_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev)<br>
@@ -592,45 +630,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_INFO_HW_IP_COU=
NT: {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type type;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_ip_block *ip_block =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t count =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (info-&gt;query_hw_ip.type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_GFX:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_GFX;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_COMPUTE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_GFX;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_DMA:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_SDMA;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_UVD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_UVD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; type =3D amdgpu_ip_get_block_type(adev, info-&gt;query_hw_ip.typ=
e);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_block =3D amdgpu_device_ip_get_ip_block(adev, type);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ip_block || !ip_block-&gt;status.valid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_GFX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_VCE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_VCE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_SDMA:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D adev-&=
gt;sdma.num_instances;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_UVD_ENC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_UVD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_JPEG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D adev-&=
gt;jpeg.num_jpeg_inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_VCN_DEC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_VCN_ENC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D AMD_IP_=
BLOCK_TYPE_VCN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D adev-&=
gt;vcn.num_vcn_inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMDGPU_HW_IP_VCN_JPEG:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D (amdgpu=
_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_=
VCN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case AMD_IP_BLOCK_TYPE_UVD:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D adev-&=
gt;uvd.num_uvd_inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* For all other IP block types not listed in the switch stateme=
nt<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * the ip status is valid here and the instance count is on=
e.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_blocks; i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
blocks[i].version-&gt;type =3D=3D type &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;ip_blocks[i].status.valid &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; count &lt; AMDGPU_HW_IP_INSTANCE_MAX_COUNT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;count, min(size, 4u)) ?=
 -EFAULT : 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_INFO_TIMESTAMP=
:<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514444896B3183F907CCBD07F7F6ABL1PR12MB5144namp_--
