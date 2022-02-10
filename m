Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 14:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EC310E28B;
	Thu, 10 Feb 2022 14:56:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6A610E28B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 14:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDSvB9omWy0vxcnEAtO8CGJo6TVnbzEIajcz9l+c0wtnE1r8+4cns42LIVrKQWZmBWob1FHh8wkmn3LB16vLIE6cYJSYUvz548xPS9Qh2tZpON5kYjhkbAnuEYhNXPikrtKv5X6C9Kb/FUmfrV+JuC11VRcqYq/rPp+jGXU3i3Y0ihaG5CUzqlwq4imj1DeQ8gqqBYkLa8nbCa5WesHmPxgr59VLT6S65MEKIJ2G5j7ntZFyCAz8ygYd2mn5xhame01u8yZyAkTGkInM8V/idc2YaINN3OptPK80wWfLL8b/eZv8K95ZUIhh6Zi8+geVau3OFAP7GGbdWuJFmqJ3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pICw8saQu+pgyWH0gWSzLRzry7OmSL1DHl0Wd4akVjY=;
 b=EQZMm0+InQP/hqA79WZis+km2NJujqwsOEmJAQZoNxe/MB//nu+wWdc0tuziHeQ2vETU/m1HWY2kuAdoKoQyhabWYeTwRV3g33+6SS3NhSBtDmCoNuHHYWNWZT0MsrxtY33E0A9Rn7gY7kOksv9a7v7Bz8+A6qnWMDwYL1aAEqjuSc5Sv6TPYqZbHsU2Iw3IWg0HWqfURD56Dke5wmiQcmp1WS3x3vujapohwPGus2yQsgRhebDc42h2CLxIqUHgHJEjl1HgGVMobxH8IcMUVdhe/r93yWTvC8pMW3m3Dh3WvHcQArE13OSK0V7pn+l9aQZ3l/sptyzE1R3LSqHN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pICw8saQu+pgyWH0gWSzLRzry7OmSL1DHl0Wd4akVjY=;
 b=PbtPYD43W7rJyJqioHOQZwW4wyu1XSDTpxlEY6cuxmPulwpIgUr7LTDpXUuUgIppbwhRnfCgLplXlQmtSHmm7RNVffDEChA9HAky7YcMTSC4mORlmsnUDCZ4+lSRVJJDfek4RQt9hWpRfcoxvyQ7dvCbAiQ+ZxcWFebFPBrubzY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 14:56:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 14:56:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add support for GC 10.1.4
Thread-Topic: [PATCH] drm/amdgpu: add support for GC 10.1.4
Thread-Index: AQHYHkbK1GbA8SWhbUOOBL/BEAuD7ayM4Dbz
Date: Thu, 10 Feb 2022 14:56:47 +0000
Message-ID: <BL1PR12MB51448852FA8F45E1F8F64219F72F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220210062015.3798430-1-Lang.Yu@amd.com>
In-Reply-To: <20220210062015.3798430-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T14:56:46.719Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 9b74af51-d45b-d948-9969-d591f73b1011
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cd0caf5-2115-41c7-94a1-08d9eca58fb8
x-ms-traffictypediagnostic: CH2PR12MB4248:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4248D9284B8C402F183B18EEF72F9@CH2PR12MB4248.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:62;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38fbxen0hTfiKsfpoBI/CaupjfS1jrgaHc3AZW6cSorQAAWmoIWNXNui6SIVC7RBG77D0hMUHqbdDQc3/ZyxOjZytW7pR3b/Jpy3GeLad8u8/ACTuIB2KX3HbRAUOkcu4tQxfXGTmVJrpUlqfI1Os+hDHoxR26m16VlEzM8nuCwlZ0RpSLBlm50o4RoGzdwBNH+lsQ1CxbFcnM8fu5nZJzXUvOEZ104DSs1WxACiphiAzyTF8S8wsKmfgNqU8CSMLBt4sRmHn1u9HlE9TNbH0rNZsyTqKmlJg4e0loqUpwYz4Qy8s3fDV6aG4RiBu6OiQeEoKS3HSndyoPQDbzxeBs0z8nwFXunmzVKTnbhj9tDkPKiwQGvvrNGEug+ktRnk/C/nktFJqCYOFauVcdc2TeamqlPUofTpnowEvfQ9Ff4K2jJsuAxwReEOWnwPPbC6Y/Q+g/CmUYJJWbyjcrovfXsy0oC4UO/OeTan6lUoavPbWa+VJU3zfh5wavZviM50o2iusuOCUtzsrcRdEumGVQuipNdxpMRkWz6Yd5ES9ePas3N9FoqjzHtHTqT+XXK/LD3K+rcfHQXYBXZKJgcGkaTiC9hNyd8VeQGhpFKHAHfJ8I+duK7sjBRDhtaaqLtKlZqa2M4VPcVVzTgcfoKP4+IYdOHgxhBe5BgM4Mhop+Is8YPdOOZUCx86+eXU4sW9PWcuS2QO4ybgYxoqlTjilA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(8676002)(4326008)(110136005)(66446008)(66946007)(19627405001)(2906002)(66556008)(64756008)(5660300002)(76116006)(8936002)(52536014)(66476007)(53546011)(9686003)(7696005)(86362001)(6506007)(316002)(508600001)(83380400001)(38100700002)(122000001)(186003)(26005)(38070700005)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?73Fp0SbJiI/J/hQvgKHhBQhQby2vSoCAeqH0YnBgH2ODPOshJRbYtulHod/C?=
 =?us-ascii?Q?UtuvvS4uZj6b4Pw7ysV9w1cCrhnuyDf+0RoHRmu18NysS6mtFExj1WJm1Bg0?=
 =?us-ascii?Q?PoEhpJthslQpjAQVjlS1/VqXHCI3br67z/JqIKjqzGabCgu1ZSFBQsm6tBWG?=
 =?us-ascii?Q?qYfjOMUeVYqecmPs9I+/uhWakthLyMlnddhD/eZ02LC0XyZ98fAuyvQjxDbB?=
 =?us-ascii?Q?u8yZ87GoaWe4BnvJLdaIM4UWZ9KC9G9QatK/ysCdCTQJa09//XekjLjI3f2B?=
 =?us-ascii?Q?cvWZA0zJEt3fmIc6PWY8gld/KPtTBv9Btr+/xPbPRLRx2bU0WixxcEUJL5pA?=
 =?us-ascii?Q?DXL2IbMJhL89rpn9L8E7G/pxe2mD0q2PywQFxx0jSITr/hByIiHKvC85toud?=
 =?us-ascii?Q?AeAm0BZ9hdbcySnZOF1ITToADrIJTjLb+9amE5ZzKUGbYGMEJ6A64E7NE4h/?=
 =?us-ascii?Q?SBuD1deX/ADujzon6bQODy67SSEGUgJQuS6P9e6fBwy4XjLOOt2KQjx4AgQa?=
 =?us-ascii?Q?WxImrocgkWbrJk0XNHGEdZXil5HZYg1Wdsx/B23KfSNOTJgiHASGb4Qbapbk?=
 =?us-ascii?Q?bCeW54Ng7Tz/+UFn11Q10NFZ2h+zRupt6jfvI/t8yYIrG8wm6LskPM1WT12c?=
 =?us-ascii?Q?P5dE7XNCsZidEaQsVsiC34MbFF1Za0zU9YCd7g4FOKEnB+DugSiseeRsJlN9?=
 =?us-ascii?Q?vS9p3HHr57R38v73HiUL31tAuWHjkld08TTPAEosfBwoi9EIonaVLhpTQCcu?=
 =?us-ascii?Q?ZVimRbQEvia8ygx1zMst8mCBlnthL/iHVrS3zBUG5UrAV7EYtOX4ay6jpzZU?=
 =?us-ascii?Q?5eQDMM0ZrF4CpwHyLAzXNS7IKmD1AzDvjL9xAWizVEsW5kXxSt9y0XP4Oo81?=
 =?us-ascii?Q?H5ng3i7Lj8nlp8fQyiYcL47pLw//6jp9T2cQOI25hG9ndttNdxVVRqXpKKhH?=
 =?us-ascii?Q?OcFKl8YgMMyteQEDu7dvaPXJNOFAlwRu2EZElic1zMAm7kPTgDlSCh7MXcf8?=
 =?us-ascii?Q?5Qvc0cT8QjdAyGeP31t0Ofne6cunTskL28gi/g45DNCfvuPY4rh0rg/RLGSM?=
 =?us-ascii?Q?D3j5rh+5PM8NHI1HL5uHetA4CRAZ+WyXEy81UGB2lZWnLNoQS6mhaEg4sG3K?=
 =?us-ascii?Q?SYZhIjwJzM5Nk1ZBvEfnTjECmyHk32iin+ddU59pQ+f1bVERYz64al8bHB3n?=
 =?us-ascii?Q?pikPRHccwc6ASWdD23oUyktnKVuhjYjWTlMmUVpN0W7Vo0PfG4Uph8GSzbTq?=
 =?us-ascii?Q?1dZDJFEpVUetY8G5p2gvk7ftrsWL18Zy+aOBxCPkn74bHS6TGUT9YFPWD5n7?=
 =?us-ascii?Q?HsVKZXkQCByhPGAfw3c8SriANMhPopWFsJZ3S4UHBn9wPFf80uxvXMpi2RjN?=
 =?us-ascii?Q?/K8pkvl5VHbHJjE22rs9p/xQTNIOF3zWFZn26g41F7vF2NuI3yBjaAHdjX3s?=
 =?us-ascii?Q?E5X1K5RPvb6MjUjQJO2VyiH4E9NHdxpNLjoVvpAAKV6LxTKvRQVBHR1H97+V?=
 =?us-ascii?Q?najeLv4HHvP5Teovs82Jlqdx01nfjOl6l50xGRQSiH4ADv8N9+4zB2SbVpKN?=
 =?us-ascii?Q?dzVJBkaeDg71Ns8u4xpHLJG6tMJ9FV2yCNb/ykgqiOm3bn9jhiSRukQHzZLF?=
 =?us-ascii?Q?w9XCQ3xBLKawODtJpAdhetI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448852FA8F45E1F8F64219F72F9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd0caf5-2115-41c7-94a1-08d9eca58fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 14:56:47.3215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDgEPIDDPZMXgIHrRBY5c/9/rMgUnZrSFMwFZbr7oik5AtK3ldMr7rLT4Z5naowkx7Wv81laeuGunVmQS/CpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51448852FA8F45E1F8F64219F72F9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, February 10, 2022 1:20 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: add support for GC 10.1.4

Add basic support for GC 10.1.4,
it uses same IP blocks with GC 10.1.3

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 4 +++-
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 2 ++
 8 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index eb4b7059633d..cd7e8522c130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -674,6 +674,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct=
 amdgpu_device *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 2):
@@ -709,6 +710,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct am=
dgpu_device *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 2):
@@ -910,6 +912,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amd=
gpu_device *adev)
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -1044,6 +1047,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 2):
@@ -1243,6 +1247,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 4):
@@ -1264,6 +1269,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
         case IP_VERSION(9, 2, 2):
         case IP_VERSION(9, 3, 0):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 3):
                 adev->flags |=3D AMD_IS_APU;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index f2806959736a..9bc9155cbf06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -137,7 +137,8 @@ static int psp_early_init(void *handle)
                 psp->autoload_supported =3D true;
                 break;
         case IP_VERSION(11, 0, 8):
-               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
+                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, =
4)) {
                         psp_v11_0_8_set_psp_funcs(psp);
                         psp->autoload_supported =3D false;
                 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 3d8c5fea572e..8fb4528c741f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3641,6 +3641,7 @@ static void gfx_v10_0_init_golden_registers(struct am=
dgpu_device *adev)
                                                 (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_3_5));
                 break;
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_gc_10_0_cy=
an_skillfish,
                                                 (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_0_cyan_skillfish));
@@ -3819,6 +3820,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdg=
pu_device *adev)
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 if ((adev->gfx.me_fw_version >=3D 0x00000046) &&
                     (adev->gfx.me_feature_version >=3D 27) &&
                     (adev->gfx.pfp_fw_version >=3D 0x00000068) &&
@@ -3959,6 +3961,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)
                 else
                         chip_name =3D "cyan_skillfish";
                 break;
+       case IP_VERSION(10, 1, 4):
+               chip_name =3D "cyan_skillfish2";
+               break;
         default:
                 BUG();
         }
@@ -4565,6 +4570,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_de=
vice *adev)
                         1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG,=
 NUM_PKRS);
                 break;
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->gfx.config.max_hw_contexts =3D 8;
                 adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
                 adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100;
@@ -4677,6 +4683,7 @@ static int gfx_v10_0_sw_init(void *handle)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->gfx.me.num_me =3D 1;
                 adev->gfx.me.num_pipe_per_me =3D 1;
                 adev->gfx.me.num_queue_per_pipe =3D 1;
@@ -7658,6 +7665,7 @@ static int gfx_v10_0_early_init(void *handle)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->gfx.num_gfx_rings =3D GFX10_NUM_GFX_RINGS_NV1X;
                 break;
         case IP_VERSION(10, 3, 0):
@@ -9418,6 +9426,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index bddaf2417344..c64e3a391c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -881,6 +881,7 @@ static int gmc_v10_0_sw_init(void *handle)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -1156,7 +1157,8 @@ static void gmc_v10_0_get_clockgating_state(void *han=
dle, u32 *flags)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 3))
+       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 3) ||
+           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 4))
                 return;

         adev->mmhub.funcs->get_clockgating(adev, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index f76834085b34..5e9ab31fee6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -902,6 +902,7 @@ static int nv_common_early_init(void *handle)
                         adev->external_rev_id =3D adev->rev_id + 0x01;
                 break;
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->cg_flags =3D 0;
                 adev->pg_flags =3D 0;
                 adev->external_rev_id =3D adev->rev_id + 0x82;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 81e033549dda..45e10d5028c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -264,7 +264,8 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)
                 chip_name =3D "navi12";
                 break;
         case IP_VERSION(5, 0, 1):
-               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
+                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, =
4))
                         chip_name =3D "cyan_skillfish2";
                 else
                         chip_name =3D "cyan_skillfish";
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 9624bbe8b501..bb6e49661d13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1411,6 +1411,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kd=
ev,
                 case IP_VERSION(10, 1, 10):
                 case IP_VERSION(10, 1, 2):
                 case IP_VERSION(10, 1, 3):
+               case IP_VERSION(10, 1, 4):
                         pcache_info =3D navi10_cache_info;
                         num_of_cache_types =3D ARRAY_SIZE(navi10_cache_inf=
o);
                         break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index dbb877fba724..7f1746289989 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -110,6 +110,7 @@ static void kfd_device_info_set_event_interrupt_class(s=
truct kfd_dev *kfd)
         case IP_VERSION(10, 3, 1): /* VANGOGH */
         case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
         case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 1, 10): /* NAVI10 */
         case IP_VERSION(10, 1, 2): /* NAVI12 */
         case IP_VERSION(10, 1, 1): /* NAVI14 */
@@ -307,6 +308,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)
                         break;
                 /* Cyan Skillfish */
                 case IP_VERSION(10, 1, 3):
+               case IP_VERSION(10, 1, 4):
                         gfx_target_version =3D 100103;
                         if (!vf)
                                 f2g =3D &gfx_v10_kfd2kgd;
--
2.25.1


--_000_BL1PR12MB51448852FA8F45E1F8F64219F72F9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, February 10, 2022 1:20 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add support for GC 10.1.4</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add basic support for GC 10.1.4,<br>
it uses same IP blocks with GC 10.1.3<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 9 +++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 2 ++<br>
&nbsp;8 files changed, 26 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index eb4b7059633d..cd7e8522c130 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -674,6 +674,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
@@ -709,6 +710,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
@@ -910,6 +912,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -1044,6 +1047,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
@@ -1243,6 +1247,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 4):=
<br>
@@ -1264,6 +1269,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;flags |=3D AMD_IS_APU;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index f2806959736a..9bc9155cbf06 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -137,7 +137,8 @@ static int psp_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;autoload_supported =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 8):=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(10, 1, 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_v=
11_0_8_set_psp_funcs(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&=
gt;autoload_supported =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 3d8c5fea572e..8fb4528c741f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3641,6 +3641,7 @@ static void gfx_v10_0_init_golden_registers(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)=
ARRAY_SIZE(golden_settings_gc_10_3_5));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_gc_10_0_cyan_skillfish,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)=
ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));<br>
@@ -3819,6 +3820,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;gfx.me_fw_version &gt;=3D 0x00000046) &=
amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.me_feature_vers=
ion &gt;=3D 27) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.pfp_fw_version =
&gt;=3D 0x00000068) &amp;&amp;<br>
@@ -3959,6 +3961,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_=
name =3D &quot;cyan_skillfish&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; chip_name =3D &quot;cyan_skillfish2&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -4565,6 +4570,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt=
;&lt; REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_hw_contexts =3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.sc_prim_fifo_size_frontend =3D 0x=
20;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.sc_prim_fifo_size_backend =3D 0x1=
00;<br>
@@ -4677,6 +4683,7 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_queue_per_pipe =3D 1;<br>
@@ -7658,6 +7665,7 @@ static int gfx_v10_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D GFX10_NUM_GFX_RINGS_NV=
1X;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
@@ -9418,6 +9426,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 4):=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index bddaf2417344..c64e3a391c99 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -881,6 +881,7 @@ static int gmc_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -1156,7 +1157,8 @@ static void gmc_v10_0_get_clockgating_state(void *han=
dle, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.funcs-&gt;g=
et_clockgating(adev, flags);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index f76834085b34..5e9ab31fee6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -902,6 +902,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;external_rev_id =3D adev-&gt;rev_id + 0x01;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x82;<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 81e033549dda..45e10d5028c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -264,7 +264,8 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;navi12&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 1):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(10, 1, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_=
name =3D &quot;cyan_skillfish2&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_=
name =3D &quot;cyan_skillfish&quot;;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index 9624bbe8b501..bb6e49661d13 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -1411,6 +1411,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kd=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcach=
e_info =3D navi10_cache_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_o=
f_cache_types =3D ARRAY_SIZE(navi10_cache_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index dbb877fba724..7f1746289989 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -110,6 +110,7 @@ static void kfd_device_info_set_event_interrupt_class(s=
truct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
 /* VANGOGH */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
 /* YELLOW_CARP */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
 /* CYAN_SKILLFISH */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
: /* NAVI10 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
 /* NAVI12 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
 /* NAVI14 */<br>
@@ -307,6 +308,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Cyan Skillfish */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_t=
arget_version =3D 100103;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f2g =3D &amp;gfx_v10_kfd2kgd;<br=
>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448852FA8F45E1F8F64219F72F9BL1PR12MB5144namp_--
