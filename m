Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C709C7EE31
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 11:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0508A89FA5;
	Tue, 24 Jun 2025 11:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q3vMAj8D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA5889FA5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 11:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOGjQeHnWpEja4u0FH+yWoG/lAt5ljEPrKXpH0PhbmXGPL4ofRyGufayiKEPkPm5H1ShU49lxjnC/0CjOOKmfbertB+fgq7ScuNvYKuGp3Q08mTKtOsK19dqElPECT5116LWO5Vji6tlzJzJGc7topa1kGvhOYGalphfWFqlbxnQl/CBySDlEgast2WQNChyp/hOG8b1KfOIk01lT0iFFJo0GUFm4QyR63Y3eFo2MjJn+VRvU5fy5mA44aDW4WI//+Dnv5qER3W4yWTDKEYCtflrBpCgQnGNfVRlF3r3tc6/wrcPsN0gLigxEkMAOlrFR0PmM0RCEKAkqPFCPKTkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq/h0OIH/oKMXJ0o5MNU9bBYzAhbORmN26sBevjyaF4=;
 b=jo+0AwRQkQUUVT2GLPYo5ADmFinzX47rFonE9Sdq3x/xnYApMdyJ3wRuUPxWGdEttAPhrP3wo9hC78sUgXJGT32SCBJSuj8gwdsFwr1IciXK/dHQgQkmn5zBx9+OIiya/ptTQ109pT0rPNYwZHKApQKeWZaUoqLmdk3TyuRwaD3VyIG64MZPW9CPws4fV+wlWj4mshMD0uNMdBrnnrL/YJ5x43Ju4SZI9KTqHOcaDzAViiHRhjos042c/jgEz/aYKuQpJkOr7UpGhwoLnFwB7GQvoXAF/RmYTe0a2DbUsWNYfQV21ExhUysRTY02txJTbErJhNZJMGiFPvgCrZHVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq/h0OIH/oKMXJ0o5MNU9bBYzAhbORmN26sBevjyaF4=;
 b=Q3vMAj8DhC3SnZJjmUyE6TL0mD/h3rz90QQ7W8wsbvGfiVJk3jQQguTHYdavOCW8jGTzUnFGHh+Ky6hVh+KnYCt7HS9CRz1HnwKa0Vb6Sl5UKK2afEFwWviD9iRaG5/eVedGX0Ik7SdO4q9yoJ0ywxmgLg+41CKIx0Lcy9CKtXk=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Tue, 24 Jun 2025 11:43:39 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 11:43:39 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Convert from DRM_* to dev_*
Thread-Topic: [PATCH] drm/amdgpu: Convert from DRM_* to dev_*
Thread-Index: AQHb5OBwDjxmkQOXHEqH2c5qloCQXrQSMKLw
Date: Tue, 24 Jun 2025 11:43:39 +0000
Message-ID: <DS7PR12MB6071E73737362A9CCD6DDE4A8E78A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250624081709.1157943-1-lijo.lazar@amd.com>
In-Reply-To: <20250624081709.1157943-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-24T11:43:24.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS7PR12MB9552:EE_
x-ms-office365-filtering-correlation-id: ea78e9b5-78da-48ef-fee3-08ddb3145cc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AH0A8YhXu0HvHBQBgr8tHUiL4d/u5BH7uBlQFEsxCo55xTs9+MfcZUln0hJO?=
 =?us-ascii?Q?U9+ehz3iYQXb+tCa7dR8MJe1iK2dIKb6172c1kISQJgCYcQ0rhIa6ml1ZFgm?=
 =?us-ascii?Q?xEtAUFj0n5xg/k1r8USTtQ/rC3tT4z9yNRFahADjdPEq9Pr6OGBwzAzkW+zF?=
 =?us-ascii?Q?45fBLXJtAb5WD3f5IDUDuKk57/F/lSo/OuIgy7dTQRrusqYS4TSzbAzKBcnL?=
 =?us-ascii?Q?f3xY3qUcjFIvjY7sCzLc3se9DrHpAim5SfqVxXDES+LfV8x9/JIZGV1DDtz0?=
 =?us-ascii?Q?jOMKune0IXIFaRaQgRhF9BBPEjXue9/5tQKlBdOS7ew4Dc4wHhC7x6wSP9Do?=
 =?us-ascii?Q?aIJcK3JvYU25F50ZwhIhf5GSN/H8ux4g8HS4aoU0RZnMrfgZ6n8RnRbuTxxK?=
 =?us-ascii?Q?0HXAXhA/GUq5AwkH2okvH6fszj2VAmO5m3gTfMNypoBPG7fHuRpm+nwaOFp5?=
 =?us-ascii?Q?Pb5RqwLPxruB/iEhXwvFcNsUfdhttYcU3HQ7BAPd/mgMNwVeczCkHR97X7s/?=
 =?us-ascii?Q?pXTPpAZHKgwsJSjYvVRFPPHdA8dR4mk2Rc4SM+/Agyk5Ov/c3U1ZdTCNiFsV?=
 =?us-ascii?Q?gNUz7GyBSMrClBzl20KoBOJT8dtExiMq35aTV6juaxDwkFf5ac27dnxy7TwU?=
 =?us-ascii?Q?OBpl6EnNn3K7lhEAdtWmp0SscWoKJY5b0vcZUStGC0iAjIZXKE/fRzk2X8/4?=
 =?us-ascii?Q?hk8t9I8GI8JUzhReq1FJUUcqCEcKktH8xIidhErnbMhl1JXqvM4RCWdVh1im?=
 =?us-ascii?Q?5bFgbRE4uwruLi6t3DnuziIDJL+fXJe0bsQ1UK4DubMcvalShLLCkdScA1MU?=
 =?us-ascii?Q?n/So9HzbQoqtvmBnp5m4fFspagJVphDX8HQk+V6o9zECpFJ7ZMzFXAnA+BrS?=
 =?us-ascii?Q?e7N1ADTCHad71P6D1l/HZsghEpeOwnxwFTUi7RviNk8MOB4dtDN44mbsQSFq?=
 =?us-ascii?Q?J3GHXi2lY+TJRx55OxFGNRKnDWnCzw+lmy+HK6bKPv+wk+WoE+oQ5ZggfYeh?=
 =?us-ascii?Q?3XVjK7y7g4sdUStSDiRd6/aXCNKCN4+ynM3xH7VL687WAFIoSgDLHZ1ND8r3?=
 =?us-ascii?Q?da5QdjGnuRVpoHeGpdTBMPk8kaFF4+9uR9VNgBFBvgWdY/7T+fGcWs4X3riu?=
 =?us-ascii?Q?X2I64TcsUr02B564gKLnm79ykAQLhURwe6H0iA1ZfUzrJpi4b0nxSxGP+9js?=
 =?us-ascii?Q?D7lxHnPXAgV3UMeu+y0q/PDqVU2YupHXQmpLRuaTOYyoEJ3KPM2wGU/UcrFs?=
 =?us-ascii?Q?vQnv0HdyuGc1G8LNGXbRG59SWkcTq7xD/YzjM6EO3CA5dOG89KmhJan9eov/?=
 =?us-ascii?Q?6lpbfmi4vThJObkLgSJEQInW++vjTRcVsdAVD4GMvg8EQxav7Hj/FK+UDwPo?=
 =?us-ascii?Q?Eo11vFhPGif24PPQC0TVy3q3niEmfeVW/tX0pOgGbgSkjWJgXejBx3R79b2V?=
 =?us-ascii?Q?BpdPfQVThniJD4PAQ0WqOJilThpa6qV7oFSw7UcfbjR8QWh3omSRUHZAiE7w?=
 =?us-ascii?Q?EkY0XdnBJhUgEiU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZmxA3PAaAxl7rPMBpOaF+ASxXoSLa7i+uhnc+XsXnoBl6SFBppp2RqE0zR5o?=
 =?us-ascii?Q?Ats6EcCyL9WkiSwgImVAJ5yqOar6CpaWijGaN+naMp0QzEjCMAaanAyU2+H+?=
 =?us-ascii?Q?2qKjY+K6z4zh91h08dhKealpsX/ANImRMh6Hqd0u5YPGYIiTMO6o2ZhHNiNZ?=
 =?us-ascii?Q?b7vhydy4F7TR3fGQtYZkBH+OJ2szfBzmd4dlkERojB1mBOl0vBOju2yKuZPE?=
 =?us-ascii?Q?X/s98xmiAP1nILYSNGPnZ/o6KPo0I8XNQMGd1y63NOvCbLWUniEq9HacMxXv?=
 =?us-ascii?Q?APg6FCoIa7soGUdYdmx2zWytxziNRx9j1jQJPG7C0+dZrwde3JXIMQGo9Mfv?=
 =?us-ascii?Q?3sVLtDkbdrMGq1/5iDr72f5Pk9emuraMlJcNdDfwZoqHurSBowq+4aN3vTZi?=
 =?us-ascii?Q?u9TyT/w1guCk1tLD8bquMtEZTGzg7uAKTB46ZasJRHtpDtu5fraFnCq25m/q?=
 =?us-ascii?Q?WfkCX4hmAxwp+Q8DaNj9V4pX0tvQulQ9E3VPY5Jm38NKbGmkNguonAeAxF0K?=
 =?us-ascii?Q?v+FsFYem+smDdNbZFzxdPoqpBPgOuI80LpD5RPXfg813pOx0bVe6LQmCbMpr?=
 =?us-ascii?Q?hrdXyMYmEmjzlPHEJSsOmo3rra9sr0cS2tnjY07LDO82X9biQtiFtj3t+3OM?=
 =?us-ascii?Q?mvR3B1pp91yquU1DhdY2LOJ4iDk6fwwvMyerskfqLXXDcX2tOFaV8v05BKoT?=
 =?us-ascii?Q?Q4v13NFrusp8Bmdzmf7W25IiYFXIQUsHK/lwIB7fEeWpG+xQ5Wx6SIO/JJND?=
 =?us-ascii?Q?TSuxCvoIBVubvP88v9dPhUfpIqTEAqlmOr7eHZIp+5h48QBGHIRJNtLJ+GV4?=
 =?us-ascii?Q?B37qUmU2GcCQVWEXdna4eP5NUzze6rT4Oy2F20DcSruPsAVtVMn9LNJj4IMn?=
 =?us-ascii?Q?6YI88kvz6PoIS8bQpYJE/dAVVY141zP8Mgf0Vy421tEuTsNXD77CVLtd5CVi?=
 =?us-ascii?Q?uLYg/Dop4aSSG0BWyrtUN3ZEkKmry+Egl+KHaCwl7zjciqib4sJnUpD2F4ib?=
 =?us-ascii?Q?WtYYahG5osbZZKppmTwrzpdbYzbDRmKEAppylGolx/xRT2CuTgacJ90T1y5I?=
 =?us-ascii?Q?aXCGCEA1vG5FhT4OUhLvfj7ZFyHv8Vha7PmFT33qz17VF2daQGFjabjd6C3V?=
 =?us-ascii?Q?TLTm4QtL49pDdoU7wwntdfuQvPvJqxJZJeel/pZaYbqt4TxcLh5byIzXq1tr?=
 =?us-ascii?Q?sSqn76uKj/L6xU467ZPPaq72jCj7VcngKare/Nd9maS/PXkMEFenuiGlWOYS?=
 =?us-ascii?Q?2t35Lo0L0/qZHXXJ4aAHqwreIL7EWwfjkqo5MTFcT5V7c458Wr/irN+ZMDhA?=
 =?us-ascii?Q?OrmNwhl4ga1GxWMqP4SkynC9AaEFqwbWxmVdvMJAg3iPy091kzw6dPqtgQh6?=
 =?us-ascii?Q?+slLfxy0c6a/O/MM7n8I56f91fkVuTBPefyWOB+IK3KwT7fGpPl5dPNvSGtA?=
 =?us-ascii?Q?ZMBJKv2jXoCtS2Ld/oR68gd4T4QIIyswsEA5AGrkGEw8fxSayKsnCwcaxZiK?=
 =?us-ascii?Q?nQuxB5vNqtayUmC3CYFoLyVfm8r8dBRAEjf3veK7yWkYh/J11IW3u3CMJ6ru?=
 =?us-ascii?Q?aPOOM6RqUVmkld2dVAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea78e9b5-78da-48ef-fee3-08ddb3145cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 11:43:39.3397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMs4HS+Rb+3eWNCCU95vXmAE23mD70SsZAYDVGm9k+pTkkilLoxtLavlzoDM1Mg/ByIx4wj9ndJiL3wuzGws0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 24, 2025 1:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Convert from DRM_* to dev_*

Convert from generic DRM_* to dev_* calls to have device context info.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 271 +++++++++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  22 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  77 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  56 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  21 +-
 12 files changed, 320 insertions(+), 219 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c8a6b3689dea..334e442c95ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1288,14 +1288,14 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *=
adev)
  */
 static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint32_t r=
eg)
 {
-       DRM_ERROR("Invalid callback to read register 0x%04X\n", reg);
+       dev_err(adev->dev, "Invalid callback to read register 0x%04X\n", re=
g);
        BUG();
        return 0;
 }

 static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64=
_t reg)
 {
-       DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+       dev_err(adev->dev, "Invalid callback to read register 0x%llX\n", re=
g);
        BUG();
        return 0;
 }
@@ -1312,15 +1312,17 @@ static uint32_t amdgpu_invalid_rreg_ext(struct amdg=
pu_device *adev, uint64_t reg
  */
 static void amdgpu_invalid_wreg(struct amdgpu_device *adev, uint32_t reg, =
uint32_t v)
 {
-       DRM_ERROR("Invalid callback to write register 0x%04X with 0x%08X\n"=
,
-                 reg, v);
+       dev_err(adev->dev,
+               "Invalid callback to write register 0x%04X with 0x%08X\n", =
reg,
+               v);
        BUG();
 }

 static void amdgpu_invalid_wreg_ext(struct amdgpu_device *adev, uint64_t r=
eg, uint32_t v)
 {
-       DRM_ERROR("Invalid callback to write register 0x%llX with 0x%08X\n"=
,
-                 reg, v);
+       dev_err(adev->dev,
+               "Invalid callback to write register 0x%llX with 0x%08X\n", =
reg,
+               v);
        BUG();
 }

@@ -1336,14 +1338,15 @@ static void amdgpu_invalid_wreg_ext(struct amdgpu_d=
evice *adev, uint64_t reg, ui
  */
 static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uint32_t=
 reg)
 {
-       DRM_ERROR("Invalid callback to read 64 bit register 0x%04X\n", reg)=
;
+       dev_err(adev->dev, "Invalid callback to read 64 bit register 0x%04X=
\n",
+               reg);
        BUG();
        return 0;
 }

 static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint=
64_t reg)
 {
-       DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+       dev_err(adev->dev, "Invalid callback to read register 0x%llX\n", re=
g);
        BUG();
        return 0;
 }
@@ -1360,15 +1363,17 @@ static uint64_t amdgpu_invalid_rreg64_ext(struct am=
dgpu_device *adev, uint64_t r
  */
 static void amdgpu_invalid_wreg64(struct amdgpu_device *adev, uint32_t reg=
, uint64_t v)
 {
-       DRM_ERROR("Invalid callback to write 64 bit register 0x%04X with 0x=
%08llX\n",
-                 reg, v);
+       dev_err(adev->dev,
+               "Invalid callback to write 64 bit register 0x%04X with 0x%0=
8llX\n",
+               reg, v);
        BUG();
 }

 static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t=
 reg, uint64_t v)
 {
-       DRM_ERROR("Invalid callback to write 64 bit register 0x%llX with 0x=
%08llX\n",
-                 reg, v);
+       dev_err(adev->dev,
+               "Invalid callback to write 64 bit register 0x%llX with 0x%0=
8llX\n",
+               reg, v);
        BUG();
 }

@@ -1386,8 +1391,9 @@ static void amdgpu_invalid_wreg64_ext(struct amdgpu_d=
evice *adev, uint64_t reg,
 static uint32_t amdgpu_block_invalid_rreg(struct amdgpu_device *adev,
                                          uint32_t block, uint32_t reg)
 {
-       DRM_ERROR("Invalid callback to read register 0x%04X in block 0x%04X=
\n",
-                 reg, block);
+       dev_err(adev->dev,
+               "Invalid callback to read register 0x%04X in block 0x%04X\n=
",
+               reg, block);
        BUG();
        return 0;
 }
@@ -1407,8 +1413,9 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_d=
evice *adev,
                                      uint32_t block,
                                      uint32_t reg, uint32_t v)
 {
-       DRM_ERROR("Invalid block callback to write register 0x%04X in block=
 0x%04X with 0x%08X\n",
-                 reg, block, v);
+       dev_err(adev->dev,
+               "Invalid block callback to write register 0x%04X in block 0=
x%04X with 0x%08X\n",
+               reg, block, v);
        BUG();
 }

@@ -1694,7 +1701,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device =
*adev)

        /* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
        if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
-               DRM_WARN("System can't access extended configuration space,=
 please check!!\n");
+               dev_warn(
+                       adev->dev,
+                       "System can't access extended configuration space, =
please check!!\n");

        /* skip if the bios has already enabled large BAR */
        if (adev->gmc.real_vram_size &&
@@ -1734,9 +1743,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device=
 *adev)

        r =3D pci_resize_resource(adev->pdev, 0, rbar_size);
        if (r =3D=3D -ENOSPC)
-               DRM_INFO("Not enough PCI address space for a large BAR.");
+               dev_info(adev->dev,
+                        "Not enough PCI address space for a large BAR.");
        else if (r && r !=3D -ENOTSUPP)
-               DRM_ERROR("Problem resizing BAR0 (%d).", r);
+               dev_err(adev->dev, "Problem resizing BAR0 (%d).", r);

        pci_assign_unassigned_bus_resources(adev->pdev->bus);

@@ -1838,8 +1848,8 @@ bool amdgpu_device_seamless_boot_supported(struct amd=
gpu_device *adev)
        case 0:
                return false;
        default:
-               DRM_ERROR("Invalid value for amdgpu.seamless: %d\n",
-                         amdgpu_seamless);
+               dev_err(adev->dev, "Invalid value for amdgpu.seamless: %d\n=
",
+                       amdgpu_seamless);
                return false;
        }

@@ -2015,7 +2025,7 @@ static void amdgpu_device_check_smu_prv_buffer_size(s=
truct amdgpu_device *adev)
                return;

        if (!is_os_64) {
-               DRM_WARN("Not 64-bit OS, feature not supported\n");
+               dev_warn(adev->dev, "Not 64-bit OS, feature not supported\n=
");
                goto def_value;
        }
        si_meminfo(&si);
@@ -2030,7 +2040,7 @@ static void amdgpu_device_check_smu_prv_buffer_size(s=
truct amdgpu_device *adev)
                if (total_memory < dram_size_seven_GB)
                        goto def_value1;
        } else {
-               DRM_WARN("Smu memory pool size not supported\n");
+               dev_warn(adev->dev, "Smu memory pool size not supported\n")=
;
                goto def_value;
        }
        adev->pm.smu_prv_buffer_size =3D amdgpu_smu_memory_pool_size << 28;
@@ -2038,7 +2048,7 @@ static void amdgpu_device_check_smu_prv_buffer_size(s=
truct amdgpu_device *adev)
        return;

 def_value1:
-       DRM_WARN("No enough system memory\n");
+       dev_warn(adev->dev, "No enough system memory\n");
 def_value:
        adev->pm.smu_prv_buffer_size =3D 0;
 }
@@ -2202,12 +2212,13 @@ static void amdgpu_switcheroo_set_state(struct pci_=
dev *pdev,
                amdgpu_device_load_pci_state(pdev);
                r =3D pci_enable_device(pdev);
                if (r)
-                       DRM_WARN("pci_enable_device failed (%d)\n", r);
+                       dev_warn(&pdev->dev, "pci_enable_device failed (%d)=
\n",
+                                r);
                amdgpu_device_resume(dev, true);

                dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
        } else {
-               pr_info("switched off\n");
+               dev_info(&pdev->dev, "switched off\n");
                dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
                amdgpu_device_prepare(dev);
                amdgpu_device_suspend(dev, true);
@@ -2274,8 +2285,9 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
                r =3D adev->ip_blocks[i].version->funcs->set_clockgating_st=
ate(
                        &adev->ip_blocks[i], state);
                if (r)
-                       DRM_ERROR("set_clockgating_state of IP block <%s> f=
ailed %d\n",
-                                 adev->ip_blocks[i].version->funcs->name, =
r);
+                       dev_err(adev->dev,
+                               "set_clockgating_state of IP block <%s> fai=
led %d\n",
+                               adev->ip_blocks[i].version->funcs->name, r)=
;
        }
        return r;
 }
@@ -2308,8 +2320,9 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
                r =3D adev->ip_blocks[i].version->funcs->set_powergating_st=
ate(
                        &adev->ip_blocks[i], state);
                if (r)
-                       DRM_ERROR("set_powergating_state of IP block <%s> f=
ailed %d\n",
-                                 adev->ip_blocks[i].version->funcs->name, =
r);
+                       dev_err(adev->dev,
+                               "set_powergating_state of IP block <%s> fai=
led %d\n",
+                               adev->ip_blocks[i].version->funcs->name, r)=
;
        }
        return r;
 }
@@ -2525,9 +2538,11 @@ static void amdgpu_device_enable_virtual_display(str=
uct amdgpu_device *adev)
                        }
                }

-               DRM_INFO("virtual display string:%s, %s:virtual_display:%d,=
 num_crtc:%d\n",
-                        amdgpu_virtual_display, pci_address_name,
-                        adev->enable_virtual_display, adev->mode_info.num_=
crtc);
+               dev_info(
+                       adev->dev,
+                       "virtual display string:%s, %s:virtual_display:%d, =
num_crtc:%d\n",
+                       amdgpu_virtual_display, pci_address_name,
+                       adev->enable_virtual_display, adev->mode_info.num_c=
rtc);

                kfree(pciaddstr);
        }
@@ -2538,8 +2553,9 @@ void amdgpu_device_set_sriov_virtual_display(struct a=
mdgpu_device *adev)
        if (amdgpu_sriov_vf(adev) && !adev->enable_virtual_display) {
                adev->mode_info.num_crtc =3D 1;
                adev->enable_virtual_display =3D true;
-               DRM_INFO("virtual_display:%d, num_crtc:%d\n",
-                        adev->enable_virtual_display, adev->mode_info.num_=
crtc);
+               dev_info(adev->dev, "virtual_display:%d, num_crtc:%d\n",
+                        adev->enable_virtual_display,
+                        adev->mode_info.num_crtc);
        }
 }

@@ -2784,16 +2800,18 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
                ip_block =3D &adev->ip_blocks[i];

                if ((amdgpu_ip_block_mask & (1 << i)) =3D=3D 0) {
-                       DRM_WARN("disabled ip block: %d <%s>\n",
-                                 i, adev->ip_blocks[i].version->funcs->nam=
e);
+                       dev_warn(adev->dev, "disabled ip block: %d <%s>\n",=
 i,
+                                adev->ip_blocks[i].version->funcs->name);
                        adev->ip_blocks[i].status.valid =3D false;
                } else if (ip_block->version->funcs->early_init) {
                        r =3D ip_block->version->funcs->early_init(ip_block=
);
                        if (r =3D=3D -ENOENT) {
                                adev->ip_blocks[i].status.valid =3D false;
                        } else if (r) {
-                               DRM_ERROR("early_init of IP block <%s> fail=
ed %d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_err(adev->dev,
+                                       "early_init of IP block <%s> failed=
 %d\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                                total =3D false;
                        } else {
                                adev->ip_blocks[i].status.valid =3D true;
@@ -2874,8 +2892,10 @@ static int amdgpu_device_ip_hw_init_phase1(struct am=
dgpu_device *adev)
                    adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_IH) {
                        r =3D adev->ip_blocks[i].version->funcs->hw_init(&a=
dev->ip_blocks[i]);
                        if (r) {
-                               DRM_ERROR("hw_init of IP block <%s> failed =
%d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_err(adev->dev,
+                                       "hw_init of IP block <%s> failed %d=
\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                                return r;
                        }
                        adev->ip_blocks[i].status.hw =3D true;
@@ -2899,8 +2919,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct amd=
gpu_device *adev)
                        continue;
                r =3D adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_=
blocks[i]);
                if (r) {
-                       DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-                                 adev->ip_blocks[i].version->funcs->name, =
r);
+                       dev_err(adev->dev,
+                               "hw_init of IP block <%s> failed %d\n",
+                               adev->ip_blocks[i].version->funcs->name, r)=
;
                        return r;
                }
                adev->ip_blocks[i].status.hw =3D true;
@@ -2938,8 +2959,11 @@ static int amdgpu_device_fw_loading(struct amdgpu_de=
vice *adev)
                        } else {
                                r =3D adev->ip_blocks[i].version->funcs->hw=
_init(&adev->ip_blocks[i]);
                                if (r) {
-                                       DRM_ERROR("hw_init of IP block <%s>=
 failed %d\n",
-                                                         adev->ip_blocks[i=
].version->funcs->name, r);
+                                       dev_err(adev->dev,
+                                               "hw_init of IP block <%s> f=
ailed %d\n",
+                                               adev->ip_blocks[i]
+                                                       .version->funcs->na=
me,
+                                               r);
                                        return r;
                                }
                                adev->ip_blocks[i].status.hw =3D true;
@@ -2994,20 +3018,23 @@ static int amdgpu_device_init_schedulers(struct amd=
gpu_device *adev)

                r =3D drm_sched_init(&ring->sched, &args);
                if (r) {
-                       DRM_ERROR("Failed to create scheduler on ring %s.\n=
",
-                                 ring->name);
+                       dev_err(adev->dev,
+                               "Failed to create scheduler on ring %s.\n",
+                               ring->name);
                        return r;
                }
                r =3D amdgpu_uvd_entity_init(adev, ring);
                if (r) {
-                       DRM_ERROR("Failed to create UVD scheduling entity o=
n ring %s.\n",
-                                 ring->name);
+                       dev_err(adev->dev,
+                               "Failed to create UVD scheduling entity on =
ring %s.\n",
+                               ring->name);
                        return r;
                }
                r =3D amdgpu_vce_entity_init(adev, ring);
                if (r) {
-                       DRM_ERROR("Failed to create VCE scheduling entity o=
n ring %s.\n",
-                                 ring->name);
+                       dev_err(adev->dev,
+                               "Failed to create VCE scheduling entity on =
ring %s.\n",
+                               ring->name);
                        return r;
                }
        }
@@ -3045,8 +3072,10 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
                if (adev->ip_blocks[i].version->funcs->sw_init) {
                        r =3D adev->ip_blocks[i].version->funcs->sw_init(&a=
dev->ip_blocks[i]);
                        if (r) {
-                               DRM_ERROR("sw_init of IP block <%s> failed =
%d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_err(adev->dev,
+                                       "sw_init of IP block <%s> failed %d=
\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                                goto init_failed;
                        }
                }
@@ -3060,7 +3089,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)
                        /* need to do common hw init early so everything is=
 set up for gmc */
                        r =3D adev->ip_blocks[i].version->funcs->hw_init(&a=
dev->ip_blocks[i]);
                        if (r) {
-                               DRM_ERROR("hw_init %d failed %d\n", i, r);
+                               dev_err(adev->dev, "hw_init %d failed %d\n"=
, i,
+                                       r);
                                goto init_failed;
                        }
                        adev->ip_blocks[i].status.hw =3D true;
@@ -3072,17 +3102,21 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)

                        r =3D amdgpu_device_mem_scratch_init(adev);
                        if (r) {
-                               DRM_ERROR("amdgpu_mem_scratch_init failed %=
d\n", r);
+                               dev_err(adev->dev,
+                                       "amdgpu_mem_scratch_init failed %d\=
n",
+                                       r);
                                goto init_failed;
                        }
                        r =3D adev->ip_blocks[i].version->funcs->hw_init(&a=
dev->ip_blocks[i]);
                        if (r) {
-                               DRM_ERROR("hw_init %d failed %d\n", i, r);
+                               dev_err(adev->dev, "hw_init %d failed %d\n"=
, i,
+                                       r);
                                goto init_failed;
                        }
                        r =3D amdgpu_device_wb_init(adev);
                        if (r) {
-                               DRM_ERROR("amdgpu_device_wb_init failed %d\=
n", r);
+                               dev_err(adev->dev,
+                                       "amdgpu_device_wb_init failed %d\n"=
, r);
                                goto init_failed;
                        }
                        adev->ip_blocks[i].status.hw =3D true;
@@ -3094,14 +3128,16 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
                                                               AMDGPU_GEM_D=
OMAIN_GTT,
                                                               AMDGPU_CSA_S=
IZE);
                                if (r) {
-                                       DRM_ERROR("allocate CSA failed %d\n=
", r);
+                                       dev_err(adev->dev,
+                                               "allocate CSA failed %d\n",=
 r);
                                        goto init_failed;
                                }
                        }

                        r =3D amdgpu_seq64_init(adev);
                        if (r) {
-                               DRM_ERROR("allocate seq64 failed %d\n", r);
+                               dev_err(adev->dev, "allocate seq64 failed %=
d\n",
+                                       r);
                                goto init_failed;
                        }
                }
@@ -3291,8 +3327,10 @@ int amdgpu_device_set_cg_state(struct amdgpu_device =
*adev,
                        r =3D adev->ip_blocks[i].version->funcs->set_clockg=
ating_state(&adev->ip_blocks[i],
                                                                           =
          state);
                        if (r) {
-                               DRM_ERROR("set_clockgating_state(gate) of I=
P block <%s> failed %d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_err(adev->dev,
+                                       "set_clockgating_state(gate) of IP =
block <%s> failed %d\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                                return r;
                        }
                }
@@ -3328,8 +3366,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_device =
*adev,
                        r =3D adev->ip_blocks[i].version->funcs->set_powerg=
ating_state(&adev->ip_blocks[i],
                                                                           =
             state);
                        if (r) {
-                               DRM_ERROR("set_powergating_state(gate) of I=
P block <%s> failed %d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_err(adev->dev,
+                                       "set_powergating_state(gate) of IP =
block <%s> failed %d\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                                return r;
                        }
                }
@@ -3395,8 +3435,10 @@ static int amdgpu_device_ip_late_init(struct amdgpu_=
device *adev)
                if (adev->ip_blocks[i].version->funcs->late_init) {
                        r =3D adev->ip_blocks[i].version->funcs->late_init(=
&adev->ip_blocks[i]);
                        if (r) {
-                               DRM_ERROR("late_init of IP block <%s> faile=
d %d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_err(adev->dev,
+                                       "late_init of IP block <%s> failed =
%d\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                                return r;
                        }
                }
@@ -3405,7 +3447,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)

        r =3D amdgpu_ras_late_init(adev);
        if (r) {
-               DRM_ERROR("amdgpu_ras_late_init failed %d", r);
+               dev_err(adev->dev, "amdgpu_ras_late_init failed %d", r);
                return r;
        }

@@ -3419,7 +3461,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)

        r =3D amdgpu_device_enable_mgpu_fan_boost();
        if (r)
-               DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
+               dev_err(adev->dev, "enable mgpu fan boost failed (%d).\n", =
r);

        /* For passthrough configuration on arcturus and aldebaran, enable =
special handling SBR */
        if (amdgpu_passthrough(adev) &&
@@ -3452,7 +3494,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
                                r =3D amdgpu_xgmi_set_pstate(gpu_instance->=
adev,
                                                AMDGPU_XGMI_PSTATE_MIN);
                                if (r) {
-                                       DRM_ERROR("pstate setting failed (%=
d).\n", r);
+                                       dev_err(adev->dev,
+                                               "pstate setting failed (%d)=
.\n",
+                                               r);
                                        break;
                                }
                        }
@@ -3466,17 +3510,19 @@ static int amdgpu_device_ip_late_init(struct amdgpu=
_device *adev)

 static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+       struct amdgpu_device *adev =3D ip_block->adev;
        int r;

        if (!ip_block->version->funcs->hw_fini) {
-               DRM_ERROR("hw_fini of IP block <%s> not defined\n",
-                         ip_block->version->funcs->name);
+               dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n"=
,
+                       ip_block->version->funcs->name);
        } else {
                r =3D ip_block->version->funcs->hw_fini(ip_block);
                /* XXX handle errors */
                if (r) {
-                       DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
-                                 ip_block->version->funcs->name, r);
+                       dev_dbg(adev->dev,
+                               "hw_fini of IP block <%s> failed %d\n",
+                               ip_block->version->funcs->name, r);
                }
        }

@@ -3517,8 +3563,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)

                r =3D adev->ip_blocks[i].version->funcs->early_fini(&adev->=
ip_blocks[i]);
                if (r) {
-                       DRM_DEBUG("early_fini of IP block <%s> failed %d\n"=
,
-                                 adev->ip_blocks[i].version->funcs->name, =
r);
+                       dev_dbg(adev->dev,
+                               "early_fini of IP block <%s> failed %d\n",
+                               adev->ip_blocks[i].version->funcs->name, r)=
;
                }
        }

@@ -3540,7 +3587,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)

        if (amdgpu_sriov_vf(adev)) {
                if (amdgpu_virt_release_full_gpu(adev, false))
-                       DRM_ERROR("failed to release exclusive mode on fini=
\n");
+                       dev_err(adev->dev,
+                               "failed to release exclusive mode on fini\n=
");
        }

        return 0;
@@ -3588,8 +3636,10 @@ static int amdgpu_device_ip_fini(struct amdgpu_devic=
e *adev)
                        r =3D adev->ip_blocks[i].version->funcs->sw_fini(&a=
dev->ip_blocks[i]);
                        /* XXX handle errors */
                        if (r) {
-                               DRM_DEBUG("sw_fini of IP block <%s> failed =
%d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                               dev_dbg(adev->dev,
+                                       "sw_fini of IP block <%s> failed %d=
\n",
+                                       adev->ip_blocks[i].version->funcs->=
name,
+                                       r);
                        }
                }
                adev->ip_blocks[i].status.sw =3D false;
@@ -3622,7 +3672,7 @@ static void amdgpu_device_delayed_init_work_handler(s=
truct work_struct *work)

        r =3D amdgpu_ib_ring_tests(adev);
        if (r)
-               DRM_ERROR("ib ring test failed (%d).\n", r);
+               dev_err(adev->dev, "ib ring test failed (%d).\n", r);
 }

 static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
@@ -3763,8 +3813,9 @@ static int amdgpu_device_ip_suspend_phase2(struct amd=
gpu_device *adev)
                        if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_=
BLOCK_TYPE_SMC) {
                                r =3D amdgpu_dpm_set_mp1_state(adev, adev->=
mp1_state);
                                if (r) {
-                                       DRM_ERROR("SMC failed to set mp1 st=
ate %d, %d\n",
-                                                       adev->mp1_state, r)=
;
+                                       dev_err(adev->dev,
+                                               "SMC failed to set mp1 stat=
e %d, %d\n",
+                                               adev->mp1_state, r);
                                        return r;
                                }
                        }
@@ -4096,7 +4147,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_=
type asic_type)
 #else
        default:
                if (amdgpu_dc > 0)
-                       DRM_INFO_ONCE("Display Core has been requested via =
kernel parameter but isn't supported by ASIC, ignoring\n");
+                       dev_info_once(
+                               adev->dev,
+                               "Display Core has been requested via kernel=
 parameter but isn't supported by ASIC, ignoring\n");
                return false;
 #endif
        }
@@ -4157,7 +4210,8 @@ static void amdgpu_device_xgmi_reset_func(struct work=
_struct *__work)

 fail:
        if (adev->asic_reset_res)
-               DRM_WARN("ASIC reset failed with error, %d for drm dev, %s"=
,
+               dev_warn(adev->dev,
+                        "ASIC reset failed with error, %d for drm dev, %s"=
,
                         adev->asic_reset_res, adev_to_drm(adev)->unique);
        amdgpu_put_xgmi_hive(hive);
 }
@@ -4281,7 +4335,7 @@ static void amdgpu_device_set_mcbp(struct amdgpu_devi=
ce *adev)
                adev->gfx.mcbp =3D true;

        if (adev->gfx.mcbp)
-               DRM_INFO("MCBP is enabled\n");
+               dev_info(adev->dev, "MCBP is enabled\n");
 }

 /**
@@ -4349,9 +4403,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        adev->audio_endpt_rreg =3D &amdgpu_block_invalid_rreg;
        adev->audio_endpt_wreg =3D &amdgpu_block_invalid_wreg;

-       DRM_INFO("initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:=
0x%04X 0x%02X).\n",
-                amdgpu_asic_name[adev->asic_type], pdev->vendor, pdev->dev=
ice,
-                pdev->subsystem_vendor, pdev->subsystem_device, pdev->revi=
sion);
+       dev_info(
+               adev->dev,
+               "initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0=
x%04X 0x%02X).\n",
+               amdgpu_asic_name[adev->asic_type], pdev->vendor, pdev->devi=
ce,
+               pdev->subsystem_vendor, pdev->subsystem_device, pdev->revis=
ion);

        /* mutex initialization are all done here so we
         * can recall function without having locking issues
@@ -4468,8 +4524,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (!adev->rmmio)
                return -ENOMEM;

-       DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base=
);
-       DRM_INFO("register mmio size: %u\n", (unsigned int)adev->rmmio_size=
);
+       dev_info(adev->dev, "register mmio base: 0x%08X\n",
+                (uint32_t)adev->rmmio_base);
+       dev_info(adev->dev, "register mmio size: %u\n",
+                (unsigned int)adev->rmmio_size);

        /*
         * Reset domain needs to be present early, before XGMI hive discove=
red
@@ -4606,7 +4664,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                        r =3D -EINVAL;
                        goto failed;
                }
-               DRM_INFO("GPU posting now...\n");
+               dev_info(adev->dev, "GPU posting now...\n");
                r =3D amdgpu_device_asic_init(adev);
                if (r) {
                        dev_err(adev->dev, "gpu post error!\n");
@@ -4716,12 +4774,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,

        r =3D amdgpu_pm_sysfs_init(adev);
        if (r)
-               DRM_ERROR("registering pm sysfs failed (%d).\n", r);
+               dev_err(adev->dev, "registering pm sysfs failed (%d).\n", r=
);

        r =3D amdgpu_ucode_sysfs_init(adev);
        if (r) {
                adev->ucode_sysfs_en =3D false;
-               DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
+               dev_err(adev->dev, "Creating firmware sysfs failed (%d).\n"=
, r);
        } else
                adev->ucode_sysfs_en =3D true;

@@ -4970,7 +5028,7 @@ static int amdgpu_device_evict_resources(struct amdgp=
u_device *adev)

        ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
        if (ret)
-               DRM_WARN("evicting device resources failed\n");
+               dev_warn(adev->dev, "evicting device resources failed\n");
        return ret;
 }

@@ -5093,7 +5151,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l notify_clients)
        }

        if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
-               DRM_WARN("smart shift update failed\n");
+               dev_warn(adev->dev, "smart shift update failed\n");

        if (notify_clients)
                drm_client_dev_suspend(adev_to_drm(adev), false);
@@ -5262,7 +5320,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 notify_clients)
        adev->in_suspend =3D false;

        if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
-               DRM_WARN("smart shift update failed\n");
+               dev_warn(adev->dev, "smart shift update failed\n");

        return 0;
 }
@@ -5793,7 +5851,9 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_re=
set_context *reset_context)
                                        amdgpu_coredump(tmp_adev, false, vr=
am_lost, reset_context->job);

                                if (vram_lost) {
-                                       DRM_INFO("VRAM is lost due to GPU r=
eset!\n");
+                                       dev_info(
+                                               tmp_adev->dev,
+                                               "VRAM is lost due to GPU re=
set!\n");
                                        amdgpu_inc_vram_lost(tmp_adev);
                                }

@@ -6305,7 +6365,8 @@ static int amdgpu_device_sched_resume(struct list_hea=
d *device_list,
                } else {
                        dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n=
", atomic_read(&tmp_adev->gpu_reset_counter));
                        if (amdgpu_acpi_smart_shift_update(adev_to_drm(tmp_=
adev), AMDGPU_SS_DEV_D0))
-                               DRM_WARN("smart shift update failed\n");
+                               dev_warn(tmp_adev->dev,
+                                        "smart shift update failed\n");
                }
        }

@@ -6386,7 +6447,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
         */
        if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
                amdgpu_ras_get_context(adev)->reboot) {
-               DRM_WARN("Emergency reboot.");
+               dev_warn(adev->dev, "Emergency reboot.");

                ksys_sync_helper();
                emergency_restart();
@@ -7042,11 +7103,11 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *=
pdev)
                adev->pci_state =3D pci_store_saved_state(pdev);

                if (!adev->pci_state) {
-                       DRM_ERROR("Failed to store PCI saved state");
+                       dev_err(adev->dev, "Failed to store PCI saved state=
");
                        return false;
                }
        } else {
-               DRM_WARN("Failed to save PCI state, err:%d\n", r);
+               dev_warn(adev->dev, "Failed to save PCI state, err:%d\n", r=
);
                return false;
        }

@@ -7067,7 +7128,7 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pde=
v)
        if (!r) {
                pci_restore_state(pdev);
        } else {
-               DRM_WARN("Failed to load PCI state, err:%d\n", r);
+               dev_warn(adev->dev, "Failed to load PCI state, err:%d\n", r=
);
                return false;
        }

@@ -7313,7 +7374,7 @@ struct dma_fence *amdgpu_device_enforce_isolation(str=
uct amdgpu_device *adev,
        dep =3D amdgpu_sync_peek_fence(&isolation->prev, ring);
        r =3D amdgpu_sync_fence(&isolation->active, &f->finished, GFP_NOWAI=
T);
        if (r)
-               DRM_WARN("OOM tracking isolation\n");
+               dev_warn(adev->dev, "OOM tracking isolation\n");

 out_grab_ref:
        dma_fence_get(dep);
@@ -7381,9 +7442,11 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_de=
vice *adev,
                tmp_ =3D RREG32(reg_addr);
                loop--;
                if (!loop) {
-                       DRM_WARN("Register(%d) [%s] failed to reach value 0=
x%08x !=3D 0x%08xn",
-                                 inst, reg_name, (uint32_t)expected_value,
-                                 (uint32_t)(tmp_ & (mask)));
+                       dev_warn(
+                               adev->dev,
+                               "Register(%d) [%s] failed to reach value 0x=
%08x !=3D 0x%08xn",
+                               inst, reg_name, (uint32_t)expected_value,
+                               (uint32_t)(tmp_ & (mask)));
                        ret =3D -ETIMEDOUT;
                        break;
                }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 3f3662e8b871..3040437d99c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -41,7 +41,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 i=
ndex)
        if (index < adev->doorbell.num_kernel_doorbells)
                return readl(adev->doorbell.cpu_addr + index);

-       DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+       dev_err(adev->dev, "reading beyond doorbell aperture: 0x%08x!\n",
+               index);
        return 0;
 }

@@ -63,7 +64,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 =
index, u32 v)
        if (index < adev->doorbell.num_kernel_doorbells)
                writel(v, adev->doorbell.cpu_addr + index);
        else
-               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", in=
dex);
+               dev_err(adev->dev,
+                       "writing beyond doorbell aperture: 0x%08x!\n", inde=
x);
 }

 /**
@@ -83,7 +85,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32=
 index)
        if (index < adev->doorbell.num_kernel_doorbells)
                return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr=
 + index));

-       DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+       dev_err(adev->dev, "reading beyond doorbell aperture: 0x%08x!\n",
+               index);
        return 0;
 }

@@ -105,7 +108,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, =
u32 index, u64 v)
        if (index < adev->doorbell.num_kernel_doorbells)
                atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + index=
), v);
        else
-               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", in=
dex);
+               dev_err(adev->dev,
+                       "writing beyond doorbell aperture: 0x%08x!\n", inde=
x);
 }

 /**
@@ -166,7 +170,8 @@ int amdgpu_doorbell_create_kernel_doorbells(struct amdg=
pu_device *adev)
                                    NULL,
                                    (void **)&adev->doorbell.cpu_addr);
        if (r) {
-               DRM_ERROR("Failed to allocate kernel doorbells, err=3D%d\n"=
, r);
+               dev_err(adev->dev,
+                       "Failed to allocate kernel doorbells, err=3D%d\n", =
r);
                return r;
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 59ac6afa4db2..dc92952bf126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -295,7 +295,9 @@ static void amdgpu_fence_fallback(struct timer_list *t)
                                              fence_drv.fallback_timer);

        if (amdgpu_fence_process(ring))
-               DRM_WARN("Fence fallback timer expired on ring %s\n", ring-=
>name);
+               dev_warn(ring->adev->dev,
+                        "Fence fallback timer expired on ring %s\n",
+                        ring->name);
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 1ae88c459da5..b0082aa7f3c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -144,7 +144,8 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)

        /* If algo exists, it means that the i2c_adapter's initialized */
        if (!adev->pm.fru_eeprom_i2c_bus || !adev->pm.fru_eeprom_i2c_bus->a=
lgo) {
-               DRM_WARN("Cannot access FRU, EEPROM accessor not initialize=
d");
+               dev_warn(adev->dev,
+                        "Cannot access FRU, EEPROM accessor not initialize=
d");
                return -ENODEV;
        }

@@ -152,19 +153,22 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
        len =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, fru_addr, b=
uf,
                                 sizeof(buf));
        if (len !=3D 8) {
-               DRM_ERROR("Couldn't read the IPMI Common Header: %d", len);
+               dev_err(adev->dev, "Couldn't read the IPMI Common Header: %=
d",
+                       len);
                return len < 0 ? len : -EIO;
        }

        if (buf[0] !=3D 1) {
-               DRM_ERROR("Bad IPMI Common Header version: 0x%02x", buf[0])=
;
+               dev_err(adev->dev, "Bad IPMI Common Header version: 0x%02x"=
,
+                       buf[0]);
                return -EIO;
        }

        for (csum =3D 0; len > 0; len--)
                csum +=3D buf[len - 1];
        if (csum) {
-               DRM_ERROR("Bad IPMI Common Header checksum: 0x%02x", csum);
+               dev_err(adev->dev, "Bad IPMI Common Header checksum: 0x%02x=
",
+                       csum);
                return -EIO;
        }

@@ -179,12 +183,14 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
        /* Read the header of the PIA. */
        len =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, buf, =
3);
        if (len !=3D 3) {
-               DRM_ERROR("Couldn't read the Product Info Area header: %d",=
 len);
+               dev_err(adev->dev,
+                       "Couldn't read the Product Info Area header: %d", l=
en);
                return len < 0 ? len : -EIO;
        }

        if (buf[0] !=3D 1) {
-               DRM_ERROR("Bad IPMI Product Info Area version: 0x%02x", buf=
[0]);
+               dev_err(adev->dev, "Bad IPMI Product Info Area version: 0x%=
02x",
+                       buf[0]);
                return -EIO;
        }

@@ -197,14 +203,16 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
        len =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, =
size);
        if (len !=3D size) {
                kfree(pia);
-               DRM_ERROR("Couldn't read the Product Info Area: %d", len);
+               dev_err(adev->dev, "Couldn't read the Product Info Area: %d=
",
+                       len);
                return len < 0 ? len : -EIO;
        }

        for (csum =3D 0; size > 0; size--)
                csum +=3D pia[size - 1];
        if (csum) {
-               DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
+               dev_err(adev->dev, "Bad Product Info Area checksum: 0x%02x"=
,
+                       csum);
                kfree(pia);
                return -EIO;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index c5646af055ab..c80c8f543532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -149,7 +149,7 @@ static bool amdgpu_gfx_is_graphics_multipipe_capable(st=
ruct amdgpu_device *adev)
 static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device *=
adev)
 {
        if (amdgpu_compute_multipipe !=3D -1) {
-               DRM_INFO("amdgpu: forcing compute pipe policy %d\n",
+               dev_info(adev->dev, "amdgpu: forcing compute pipe policy %d=
\n",
                         amdgpu_compute_multipipe);
                return amdgpu_compute_multipipe =3D=3D 1;
        }
@@ -674,7 +674,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, i=
nt xcc_id)
                 * generation exposes more than 64 queues. If so, the
                 * definition of queue_mask needs updating */
                if (WARN_ON(i > (sizeof(queue_mask)*8))) {
-                       DRM_ERROR("Invalid KCQ enabled: %d\n", i);
+                       dev_err(adev->dev, "Invalid KCQ enabled: %d\n", i);
                        break;
                }

@@ -683,15 +683,15 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)

        amdgpu_device_flush_hdp(adev, NULL);

-       DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->=
pipe,
-                kiq_ring->queue);
+       dev_info(adev->dev, "kiq ring mec %d pipe %d q %d\n", kiq_ring->me,
+                kiq_ring->pipe, kiq_ring->queue);

        spin_lock(&kiq->ring_lock);
        r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
                                        adev->gfx.num_compute_rings +
                                        kiq->pmf->set_resources_size);
        if (r) {
-               DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+               dev_err(adev->dev, "Failed to lock KIQ (%d).\n", r);
                spin_unlock(&kiq->ring_lock);
                return r;
        }
@@ -712,7 +712,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, i=
nt xcc_id)
        r =3D amdgpu_ring_test_helper(kiq_ring);
        spin_unlock(&kiq->ring_lock);
        if (r)
-               DRM_ERROR("KCQ enable failed\n");
+               dev_err(adev->dev, "KCQ enable failed\n");

        return r;
 }
@@ -734,7 +734,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)
                        r =3D amdgpu_mes_map_legacy_queue(adev,
                                                        &adev->gfx.gfx_ring=
[j]);
                        if (r) {
-                               DRM_ERROR("failed to map gfx queue\n");
+                               dev_err(adev->dev, "failed to map gfx queue=
\n");
                                return r;
                        }
                }
@@ -748,7 +748,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)
                r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size=
 *
                                                adev->gfx.num_gfx_rings);
                if (r) {
-                       DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+                       dev_err(adev->dev, "Failed to lock KIQ (%d).\n", r)=
;
                        spin_unlock(&kiq->ring_lock);
                        return r;
                }
@@ -769,7 +769,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)
        r =3D amdgpu_ring_test_helper(kiq_ring);
        spin_unlock(&kiq->ring_lock);
        if (r)
-               DRM_ERROR("KGQ enable failed\n");
+               dev_err(adev->dev, "KGQ enable failed\n");

        return r;
 }
@@ -1030,7 +1030,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device =
*adev,

        ih_data.head =3D *ras_if;

-       DRM_ERROR("CP ECC ERROR IRQ\n");
+       dev_err(adev->dev, "CP ECC ERROR IRQ\n");
        amdgpu_ras_interrupt_dispatch(adev, &ih_data);
        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ih.c
index 30f16968b578..a6419246e9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -218,7 +218,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struc=
t amdgpu_ih_ring *ih)

 restart_ih:
        count  =3D AMDGPU_IH_MAX_NUM_IVS;
-       DRM_DEBUG("%s: rptr %d, wptr %d\n", __func__, ih->rptr, wptr);
+       dev_dbg(adev->dev, "%s: rptr %d, wptr %d\n", __func__, ih->rptr, wp=
tr);

        /* Order reading of wptr vs. reading of IH ring data */
        rmb();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c
index 56d973faca41..cf988077a3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -142,8 +142,9 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
                                r =3D src->funcs->set(adev, src, k,
                                                    AMDGPU_IRQ_STATE_DISABL=
E);
                                if (r)
-                                       DRM_ERROR("error disabling interrup=
t (%d)\n",
-                                                 r);
+                                       dev_err(adev->dev,
+                                               "error disabling interrupt =
(%d)\n",
+                                               r);
                        }
                }
        }
@@ -315,7 +316,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
        adev->irq.irq =3D irq;
        adev_to_drm(adev)->max_vblank_count =3D 0x00ffffff;

-       DRM_DEBUG("amdgpu: irq initialized.\n");
+       dev_dbg(adev->dev, "amdgpu: irq initialized.\n");
        return 0;

 free_vectors:
@@ -461,10 +462,10 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
        src_id =3D entry.src_id;

        if (client_id >=3D AMDGPU_IRQ_CLIENTID_MAX) {
-               DRM_DEBUG("Invalid client_id in IV: %d\n", client_id);
+               dev_dbg(adev->dev, "Invalid client_id in IV: %d\n", client_=
id);

        } else  if (src_id >=3D AMDGPU_MAX_IRQ_SRC_ID) {
-               DRM_DEBUG("Invalid src_id in IV: %d\n", src_id);
+               dev_dbg(adev->dev, "Invalid src_id in IV: %d\n", src_id);

        } else if (((client_id =3D=3D AMDGPU_IRQ_CLIENTID_LEGACY) ||
                    (client_id =3D=3D SOC15_IH_CLIENTID_ISP)) &&
@@ -472,18 +473,21 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
                generic_handle_domain_irq(adev->irq.domain, src_id);

        } else if (!adev->irq.client[client_id].sources) {
-               DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %d\=
n",
-                         client_id, src_id);
+               dev_dbg(adev->dev,
+                       "Unregistered interrupt client_id: %d src_id: %d\n"=
,
+                       client_id, src_id);

        } else if ((src =3D adev->irq.client[client_id].sources[src_id])) {
                r =3D src->funcs->process(adev, src, &entry);
                if (r < 0)
-                       DRM_ERROR("error processing interrupt (%d)\n", r);
+                       dev_err(adev->dev, "error processing interrupt (%d)=
\n",
+                               r);
                else if (r)
                        handled =3D true;

        } else {
-               DRM_DEBUG("Unregistered interrupt src_id: %d of client_id:%=
d\n",
+               dev_dbg(adev->dev,
+                       "Unregistered interrupt src_id: %d of client_id:%d\=
n",
                        src_id, client_id);
        }

@@ -732,7 +736,7 @@ int amdgpu_irq_add_domain(struct amdgpu_device *adev)
        adev->irq.domain =3D irq_domain_add_linear(NULL, AMDGPU_MAX_IRQ_SRC=
_ID,
                                                 &amdgpu_hw_irqdomain_ops, =
adev);
        if (!adev->irq.domain) {
-               DRM_ERROR("GPU irq add domain failed\n");
+               dev_err(adev->dev, "GPU irq add domain failed\n");
                return -ENODEV;
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_jpeg.c
index dda29132dfb2..82d58ac7afb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -463,7 +463,8 @@ int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *ade=
v,
        adev->jpeg.ip_dump =3D kcalloc(adev->jpeg.num_jpeg_inst * count,
                                     sizeof(uint32_t), GFP_KERNEL);
        if (!adev->jpeg.ip_dump) {
-               DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+               dev_err(adev->dev,
+                       "Failed to allocate memory for JPEG IP Dump\n");
                return -ENOMEM;
        }
        adev->jpeg.reg_list =3D reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 6fa9fa11c8f3..135598502c8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -47,7 +47,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device =
*adev)
        /* Bitmap for dynamic allocation of kernel doorbells */
        mes->doorbell_bitmap =3D bitmap_zalloc(PAGE_SIZE / sizeof(u32), GFP=
_KERNEL);
        if (!mes->doorbell_bitmap) {
-               DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
+               dev_err(adev->dev, "Failed to allocate MES doorbell bitmap\=
n");
                return -ENOMEM;
        }

@@ -256,7 +256,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
        r =3D adev->mes.funcs->suspend_gang(&adev->mes, &input);
        amdgpu_mes_unlock(&adev->mes);
        if (r)
-               DRM_ERROR("failed to suspend all gangs");
+               dev_err(adev->dev, "failed to suspend all gangs");

        return r;
 }
@@ -280,7 +280,7 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
        r =3D adev->mes.funcs->resume_gang(&adev->mes, &input);
        amdgpu_mes_unlock(&adev->mes);
        if (r)
-               DRM_ERROR("failed to resume all gangs");
+               dev_err(adev->dev, "failed to resume all gangs");

        return r;
 }
@@ -304,7 +304,7 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *a=
dev,
        r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
        amdgpu_mes_unlock(&adev->mes);
        if (r)
-               DRM_ERROR("failed to map legacy queue\n");
+               dev_err(adev->dev, "failed to map legacy queue\n");

        return r;
 }
@@ -329,7 +329,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device =
*adev,
        r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input)=
;
        amdgpu_mes_unlock(&adev->mes);
        if (r)
-               DRM_ERROR("failed to unmap legacy queue\n");
+               dev_err(adev->dev, "failed to unmap legacy queue\n");

        return r;
 }
@@ -361,7 +361,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,
        r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
        amdgpu_mes_unlock(&adev->mes);
        if (r)
-               DRM_ERROR("failed to reset legacy queue\n");
+               dev_err(adev->dev, "failed to reset legacy queue\n");

        return r;
 }
@@ -469,7 +469,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device=
 *adev,
        int r;

        if (!adev->mes.funcs->misc_op) {
-               DRM_ERROR("mes set shader debugger is not supported!\n");
+               dev_err(adev->dev,
+                       "mes set shader debugger is not supported!\n");
                return -EINVAL;
        }

@@ -493,7 +494,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device=
 *adev,

        r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
        if (r)
-               DRM_ERROR("failed to set_shader_debugger\n");
+               dev_err(adev->dev, "failed to set_shader_debugger\n");

        amdgpu_mes_unlock(&adev->mes);

@@ -507,7 +508,8 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_devi=
ce *adev,
        int r;

        if (!adev->mes.funcs->misc_op) {
-               DRM_ERROR("mes flush shader debugger is not supported!\n");
+               dev_err(adev->dev,
+                       "mes flush shader debugger is not supported!\n");
                return -EINVAL;
        }

@@ -519,7 +521,7 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_devi=
ce *adev,

        r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
        if (r)
-               DRM_ERROR("failed to set_shader_debugger\n");
+               dev_err(adev->dev, "failed to set_shader_debugger\n");

        amdgpu_mes_unlock(&adev->mes);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2af14c369bb9..54838746f97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -277,10 +277,11 @@ static int __write_table_header(struct amdgpu_ras_eep=
rom_control *control)
        up_read(&adev->reset_domain->sem);

        if (res < 0) {
-               DRM_ERROR("Failed to write EEPROM table header:%d", res);
+               dev_err(adev->dev, "Failed to write EEPROM table header:%d"=
,
+                       res);
        } else if (res < RAS_TABLE_HEADER_SIZE) {
-               DRM_ERROR("Short write:%d out of %d\n",
-                         res, RAS_TABLE_HEADER_SIZE);
+               dev_err(adev->dev, "Short write:%d out of %d\n", res,
+                       RAS_TABLE_HEADER_SIZE);
                res =3D -EIO;
        } else {
                res =3D 0;
@@ -323,7 +324,8 @@ static int __write_table_ras_info(struct amdgpu_ras_eep=
rom_control *control)

        buf =3D kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
        if (!buf) {
-               DRM_ERROR("Failed to alloc buf to write table ras info\n");
+               dev_err(adev->dev,
+                       "Failed to alloc buf to write table ras info\n");
                return -ENOMEM;
        }

@@ -338,10 +340,11 @@ static int __write_table_ras_info(struct amdgpu_ras_e=
eprom_control *control)
        up_read(&adev->reset_domain->sem);

        if (res < 0) {
-               DRM_ERROR("Failed to write EEPROM table ras info:%d", res);
+               dev_err(adev->dev, "Failed to write EEPROM table ras info:%=
d",
+                       res);
        } else if (res < RAS_TABLE_V2_1_INFO_SIZE) {
-               DRM_ERROR("Short write:%d out of %d\n",
-                         res, RAS_TABLE_V2_1_INFO_SIZE);
+               dev_err(adev->dev, "Short write:%d out of %d\n", res,
+                       RAS_TABLE_V2_1_INFO_SIZE);
                res =3D -EIO;
        } else {
                res =3D 0;
@@ -609,13 +612,13 @@ static int __amdgpu_ras_eeprom_write(struct amdgpu_ra=
s_eeprom_control *control,
                                  buf, buf_size);
        up_read(&adev->reset_domain->sem);
        if (res < 0) {
-               DRM_ERROR("Writing %d EEPROM table records error:%d",
-                         num, res);
+               dev_err(adev->dev, "Writing %d EEPROM table records error:%=
d",
+                       num, res);
        } else if (res < buf_size) {
                /* Short write, return error.
                 */
-               DRM_ERROR("Wrote %d records out of %d",
-                         res / RAS_TABLE_RECORD_SIZE, num);
+               dev_err(adev->dev, "Wrote %d records out of %d",
+                       res / RAS_TABLE_RECORD_SIZE, num);
                res =3D -EIO;
        } else {
                res =3D 0;
@@ -788,8 +791,9 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)
        buf_size =3D control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
        buf =3D kcalloc(control->ras_num_recs, RAS_TABLE_RECORD_SIZE, GFP_K=
ERNEL);
        if (!buf) {
-               DRM_ERROR("allocating memory for table of size %d bytes fai=
led\n",
-                         control->tbl_hdr.tbl_size);
+               dev_err(adev->dev,
+                       "allocating memory for table of size %d bytes faile=
d\n",
+                       control->tbl_hdr.tbl_size);
                res =3D -ENOMEM;
                goto Out;
        }
@@ -801,12 +805,11 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)
                                 buf, buf_size);
        up_read(&adev->reset_domain->sem);
        if (res < 0) {
-               DRM_ERROR("EEPROM failed reading records:%d\n",
-                         res);
+               dev_err(adev->dev, "EEPROM failed reading records:%d\n", re=
s);
                goto Out;
        } else if (res < buf_size) {
-               DRM_ERROR("EEPROM read %d out of %d bytes\n",
-                         res, buf_size);
+               dev_err(adev->dev, "EEPROM read %d out of %d bytes\n", res,
+                       buf_size);
                res =3D -EIO;
                goto Out;
        }
@@ -867,11 +870,12 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom=
_control *control,
                return 0;

        if (num =3D=3D 0) {
-               DRM_ERROR("will not append 0 records\n");
+               dev_err(adev->dev, "will not append 0 records\n");
                return -EINVAL;
        } else if (num > control->ras_max_record_count) {
-               DRM_ERROR("cannot append %d records than the size of table =
%d\n",
-                         num, control->ras_max_record_count);
+               dev_err(adev->dev,
+                       "cannot append %d records than the size of table %d=
\n",
+                       num, control->ras_max_record_count);
                return -EINVAL;
        }

@@ -925,13 +929,13 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras=
_eeprom_control *control,
                                 buf, buf_size);
        up_read(&adev->reset_domain->sem);
        if (res < 0) {
-               DRM_ERROR("Reading %d EEPROM table records error:%d",
-                         num, res);
+               dev_err(adev->dev, "Reading %d EEPROM table records error:%=
d",
+                       num, res);
        } else if (res < buf_size) {
                /* Short read, return error.
                 */
-               DRM_ERROR("Read %d records out of %d",
-                         res / RAS_TABLE_RECORD_SIZE, num);
+               dev_err(adev->dev, "Read %d records out of %d",
+                       res / RAS_TABLE_RECORD_SIZE, num);
                res =3D -EIO;
        } else {
                res =3D 0;
@@ -965,11 +969,11 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_c=
ontrol *control,
                return 0;

        if (num =3D=3D 0) {
-               DRM_ERROR("will not read 0 records\n");
+               dev_err(adev->dev, "will not read 0 records\n");
                return -EINVAL;
        } else if (num > control->ras_num_recs) {
-               DRM_ERROR("too many records to read:%d available:%d\n",
-                         num, control->ras_num_recs);
+               dev_err(adev->dev, "too many records to read:%d available:%=
d\n",
+                       num, control->ras_num_recs);
                return -EINVAL;
        }

@@ -1301,7 +1305,8 @@ static int __verify_ras_table_checksum(struct amdgpu_=
ras_eeprom_control *control

        buf =3D kzalloc(buf_size, GFP_KERNEL);
        if (!buf) {
-               DRM_ERROR("Out of memory checking RAS table checksum.\n");
+               dev_err(adev->dev,
+                       "Out of memory checking RAS table checksum.\n");
                return -ENOMEM;
        }

@@ -1310,7 +1315,7 @@ static int __verify_ras_table_checksum(struct amdgpu_=
ras_eeprom_control *control
                                 control->ras_header_offset,
                                 buf, buf_size);
        if (res < buf_size) {
-               DRM_ERROR("Partial read for checksum, res:%d\n", res);
+               dev_err(adev->dev, "Partial read for checksum, res:%d\n", r=
es);
                /* On partial reads, return -EIO.
                 */
                if (res >=3D 0)
@@ -1335,7 +1340,8 @@ static int __read_table_ras_info(struct amdgpu_ras_ee=
prom_control *control)

        buf =3D kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
        if (!buf) {
-               DRM_ERROR("Failed to alloc buf to read EEPROM table ras inf=
o\n");
+               dev_err(adev->dev,
+                       "Failed to alloc buf to read EEPROM table ras info\=
n");
                return -ENOMEM;
        }

@@ -1347,7 +1353,8 @@ static int __read_table_ras_info(struct amdgpu_ras_ee=
prom_control *control)
                                 control->i2c_address + control->ras_info_o=
ffset,
                                 buf, RAS_TABLE_V2_1_INFO_SIZE);
        if (res < RAS_TABLE_V2_1_INFO_SIZE) {
-               DRM_ERROR("Failed to read EEPROM table ras info, res:%d", r=
es);
+               dev_err(adev->dev,
+                       "Failed to read EEPROM table ras info, res:%d", res=
);
                res =3D res >=3D 0 ? -EIO : res;
                goto Out;
        }
@@ -1388,7 +1395,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_c=
ontrol *control)
                                 control->i2c_address + control->ras_header=
_offset,
                                 buf, RAS_TABLE_HEADER_SIZE);
        if (res < RAS_TABLE_HEADER_SIZE) {
-               DRM_ERROR("Failed to read EEPROM table header, res:%d", res=
);
+               dev_err(adev->dev, "Failed to read EEPROM table header, res=
:%d",
+                       res);
                return res >=3D 0 ? -EIO : res;
        }

@@ -1453,8 +1461,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                        control->ras_num_mca_recs * adev->umc.retire_unit;

        if (hdr->header =3D=3D RAS_TABLE_HDR_VAL) {
-               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d recor=
ds",
-                                control->ras_num_bad_pages);
+               dev_dbg(adev->dev,
+                       "Found existing EEPROM table with %d records",
+                       control->ras_num_bad_pages);

                if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                        res =3D __read_table_ras_info(control);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 984fe8c6d480..80a5fc375da3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -299,7 +299,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *ad=
ev,
        struct amdgpu_bo *abo_src, *abo_dst;

        if (!adev->mman.buffer_funcs_enabled) {
-               DRM_ERROR("Trying to move memory with ring turned off.\n");
+               dev_err(adev->dev,
+                       "Trying to move memory with ring turned off.\n");
                return -EINVAL;
        }

@@ -934,7 +935,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *b=
dev,
        if (gtt->userptr) {
                r =3D amdgpu_ttm_tt_pin_userptr(bdev, ttm);
                if (r) {
-                       DRM_ERROR("failed to pin userptr\n");
+                       dev_err(adev->dev, "failed to pin userptr\n");
                        return r;
                }
        } else if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL) {
@@ -1781,7 +1782,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_devic=
e *adev)
                                                 &ctx->c2p_bo,
                                                 NULL);
                if (ret) {
-                       DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
+                       dev_err(adev->dev, "alloc c2p_bo failed(%d)!\n", re=
t);
                        amdgpu_ttm_training_reserve_vram_fini(adev);
                        return ret;
                }
@@ -1793,7 +1794,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_devic=
e *adev)
                        adev, adev->gmc.real_vram_size - reserve_size,
                        reserve_size, &adev->mman.fw_reserved_memory, NULL)=
;
                if (ret) {
-                       DRM_ERROR("alloc tmr failed(%d)!\n", ret);
+                       dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
                        amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memor=
y,
                                              NULL, NULL);
                        return ret;
@@ -1864,13 +1865,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
                               adev->need_swiotlb,
                               dma_addressing_limited(adev->dev));
        if (r) {
-               DRM_ERROR("failed initializing buffer object driver(%d).\n"=
, r);
+               dev_err(adev->dev,
+                       "failed initializing buffer object driver(%d).\n", =
r);
                return r;
        }

        r =3D amdgpu_ttm_pools_init(adev);
        if (r) {
-               DRM_ERROR("failed to init ttm pools(%d).\n", r);
+               dev_err(adev->dev, "failed to init ttm pools(%d).\n", r);
                return r;
        }
        adev->mman.initialized =3D true;
@@ -1878,7 +1880,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
        /* Initialize VRAM pool with all of VRAM divided into pages */
        r =3D amdgpu_vram_mgr_init(adev);
        if (r) {
-               DRM_ERROR("Failed initializing VRAM heap.\n");
+               dev_err(adev->dev, "Failed initializing VRAM heap.\n");
                return r;
        }

@@ -1958,7 +1960,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
                DRM_DEBUG_DRIVER("Skipped stolen memory reservation\n");
        }

-       DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
+       dev_info(adev->dev, "amdgpu: %uM of VRAM memory ready\n",
                 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));

        /* Compute GTT size, either based on TTM limit
@@ -1981,10 +1983,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
        /* Initialize GTT memory pool */
        r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
        if (r) {
-               DRM_ERROR("Failed initializing GTT heap.\n");
+               dev_err(adev->dev, "Failed initializing GTT heap.\n");
                return r;
        }
-       DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
+       dev_info(adev->dev, "amdgpu: %uM of GTT memory ready.\n",
                 (unsigned int)(gtt_size / (1024 * 1024)));

        if (adev->flags & AMD_IS_APU) {
@@ -1995,40 +1997,40 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
        /* Initialize doorbell pool on PCI BAR */
        r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorb=
ell.size / PAGE_SIZE);
        if (r) {
-               DRM_ERROR("Failed initializing doorbell heap.\n");
+               dev_err(adev->dev, "Failed initializing doorbell heap.\n");
                return r;
        }

        /* Create a boorbell page for kernel usages */
        r =3D amdgpu_doorbell_create_kernel_doorbells(adev);
        if (r) {
-               DRM_ERROR("Failed to initialize kernel doorbells.\n");
+               dev_err(adev->dev, "Failed to initialize kernel doorbells.\=
n");
                return r;
        }

        /* Initialize preemptible memory pool */
        r =3D amdgpu_preempt_mgr_init(adev);
        if (r) {
-               DRM_ERROR("Failed initializing PREEMPT heap.\n");
+               dev_err(adev->dev, "Failed initializing PREEMPT heap.\n");
                return r;
        }

        /* Initialize various on-chip memory pools */
        r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_GDS, adev->gds.gds_si=
ze);
        if (r) {
-               DRM_ERROR("Failed initializing GDS heap.\n");
+               dev_err(adev->dev, "Failed initializing GDS heap.\n");
                return r;
        }

        r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_GWS, adev->gds.gws_si=
ze);
        if (r) {
-               DRM_ERROR("Failed initializing gws heap.\n");
+               dev_err(adev->dev, "Failed initializing gws heap.\n");
                return r;
        }

        r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_OA, adev->gds.oa_size=
);
        if (r) {
-               DRM_ERROR("Failed initializing oa heap.\n");
+               dev_err(adev->dev, "Failed initializing oa heap.\n");
                return r;
        }
        if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
@@ -2091,7 +2093,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
        ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
        ttm_device_fini(&adev->mman.bdev);
        adev->mman.initialized =3D false;
-       DRM_INFO("amdgpu: ttm finalized\n");
+       dev_info(adev->dev, "amdgpu: ttm finalized\n");
 }

 /**
@@ -2123,8 +2125,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu=
_device *adev, bool enable)
                                          DRM_SCHED_PRIORITY_KERNEL, &sched=
,
                                          1, NULL);
                if (r) {
-                       DRM_ERROR("Failed setting up TTM BO move entity (%d=
)\n",
-                                 r);
+                       dev_err(adev->dev,
+                               "Failed setting up TTM BO move entity (%d)\=
n",
+                               r);
                        return;
                }

@@ -2132,8 +2135,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu=
_device *adev, bool enable)
                                          DRM_SCHED_PRIORITY_NORMAL, &sched=
,
                                          1, NULL);
                if (r) {
-                       DRM_ERROR("Failed setting up TTM BO move entity (%d=
)\n",
-                                 r);
+                       dev_err(adev->dev,
+                               "Failed setting up TTM BO move entity (%d)\=
n",
+                               r);
                        goto error_free_entity;
                }
        } else {
@@ -2204,7 +2208,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint=
64_t src_offset,
        int r;

        if (!direct_submit && !ring->sched.ready) {
-               DRM_ERROR("Trying to move memory with ring turned off.\n");
+               dev_err(adev->dev,
+                       "Trying to move memory with ring turned off.\n");
                return -EINVAL;
        }

@@ -2239,7 +2244,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint=
64_t src_offset,

 error_free:
        amdgpu_job_free(job);
-       DRM_ERROR("Error scheduling IBs (%d)\n", r);
+       dev_err(adev->dev, "Error scheduling IBs (%d)\n", r);
        return r;
 }

@@ -2358,7 +2363,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
        int r;

        if (!adev->mman.buffer_funcs_enabled) {
-               DRM_ERROR("Trying to clear memory with ring turned off.\n")=
;
+               dev_err(adev->dev,
+                       "Trying to clear memory with ring turned off.\n");
                return -EINVAL;
        }

@@ -2418,7 +2424,7 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *=
adev, int mem_type)
                man =3D ttm_manager_type(&adev->mman.bdev, mem_type);
                break;
        default:
-               DRM_ERROR("Trying to evict invalid memory type\n");
+               dev_err(adev->dev, "Trying to evict invalid memory type\n")=
;
                return -EINVAL;
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 3911c78f8282..20ad57f7815d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2395,10 +2395,11 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *ad=
ev, uint32_t min_vm_size,
        else
                adev->vm_manager.fragment_size =3D amdgpu_vm_fragment_size;

-       DRM_INFO("vm size is %u GB, %u levels, block size is %u-bit, fragme=
nt size is %u-bit\n",
-                vm_size, adev->vm_manager.num_level + 1,
-                adev->vm_manager.block_size,
-                adev->vm_manager.fragment_size);
+       dev_info(
+               adev->dev,
+               "vm size is %u GB, %u levels, block size is %u-bit, fragmen=
t size is %u-bit\n",
+               vm_size, adev->vm_manager.num_level + 1,
+               adev->vm_manager.block_size, adev->vm_manager.fragment_size=
);
 }

 /**
@@ -2564,8 +2565,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm,
        vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                    AMDGPU_VM_USE_CPU_FOR_GFX);

-       DRM_DEBUG_DRIVER("VM update mode is %s\n",
-                        vm->use_cpu_for_update ? "CPU" : "SDMA");
+       dev_dbg(adev->dev, "VM update mode is %s\n",
+               vm->use_cpu_for_update ? "CPU" : "SDMA");
        WARN_ONCE((vm->use_cpu_for_update &&
                   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
                  "CPU update of VM recommended only for large BAR system\n=
");
@@ -2607,7 +2608,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm,

        r =3D amdgpu_vm_create_task_info(vm);
        if (r)
-               DRM_DEBUG("Failed to create task info for VM\n");
+               dev_dbg(adev->dev, "Failed to create task info for VM\n");

        amdgpu_bo_unreserve(vm->root.bo);
        amdgpu_bo_unref(&root_bo);
@@ -2658,8 +2659,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev=
, struct amdgpu_vm *vm)
        /* Update VM state */
        vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
-       DRM_DEBUG_DRIVER("VM update mode is %s\n",
-                        vm->use_cpu_for_update ? "CPU" : "SDMA");
+       dev_dbg(adev->dev, "VM update mode is %s\n",
+               vm->use_cpu_for_update ? "CPU" : "SDMA");
        WARN_ONCE((vm->use_cpu_for_update &&
                   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
                  "CPU update of VM recommended only for large BAR system\n=
");
@@ -2982,7 +2983,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *ade=
v, u32 pasid,
 error_unlock:
        amdgpu_bo_unreserve(root);
        if (r < 0)
-               DRM_ERROR("Can't handle page fault (%d)\n", r);
+               dev_err(adev->dev, "Can't handle page fault (%d)\n", r);

 error_unref:
        amdgpu_bo_unref(&root);
--
2.49.0

