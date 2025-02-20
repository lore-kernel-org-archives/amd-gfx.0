Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DD6C021AA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 02:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B34C10E03E;
	Thu, 20 Feb 2025 02:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0EtKQb9Q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D5D10E03E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 02:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6RjrENA/CtPshv08zV/IWOfvdUfIG/7p3rPwseJ2I2DefDOp0GqbvuR/B6Y1CaKu2cxf0qi4mj/FiT0wVL5J8LjOC8Al07mqPer8iRsaWVJhpze4BWNAZrtzZYmTJLdarIjb7tz2CK+JL3Tq/Kp0cdH8IrS1Q60xYCXHTLyPAQ24fqhKnOpLbwQUjQUzQ+xSC61hr+VRmOApuK/gFbHkAAKm/JmtIqCdp5fwsy0uB2ZOBNUqA84pR9ofZ3cAvVTMbVgrRlXFDFsMOga/XOiCM+ngMuXdUz7d5F42YVcc/pAaa8JgkHaGsx2J6J+t0o9QmVki9VThnKGkByHF4rtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCqTSKtP2d15ZMbmLKTLbB2zvEFV6S1mX3DvGix7ppY=;
 b=TobMWarGGKloPX0a0PapKAS1PVcDJRVjjrD+4aqoeU1NJEMe1j2cBFWTCqMqfXWJPpCmXYfdl2EFmwBMERghcE/ozX9cNCAplRyEdVz+gucysapDkZumjJbccfc+NIixUNwr59mtYC8i094ngHt2JcyKcKYSLSP507H47JLPywL64wb85BKJTRHGHVkD9QjJb30JdsJGyILzxCrnAvl9y/3LBkNWbXiT/GcjJUmELmkEWLGVq2zEuKjRXIaD6hdIFNrb5rsdhMAzhy33VtBbSux7l29/3NOWB/Meo0fTD9J0HriMj3nMrc74d5VBQbDvKx986z7kTHV4wb3noZG+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCqTSKtP2d15ZMbmLKTLbB2zvEFV6S1mX3DvGix7ppY=;
 b=0EtKQb9QmOpgLkrhkry2cPYYpZJnKRjYRRCXLh0wzimClQRZd/L2H6KVrSr01RFZ8DMFZU1HUIFUKyICz3NKZ80fiudAg3eIS4S5CF94Q7bttptYUHGXukccVD7RYc3clN4/cOulSHlQx9Dg/dObefWEKrRq8h/2i1pPVYjO+pI=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 02:21:54 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%3]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 02:21:54 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct the name of mes_pipe structure
Thread-Topic: [PATCH] drm/amdgpu: correct the name of mes_pipe structure
Thread-Index: AQHbgz2ixbxs5J/rPk2/TlwRk5ijyrNPdNwg
Date: Thu, 20 Feb 2025 02:21:54 +0000
Message-ID: <DM4PR12MB518168087AD1581726911005EFC42@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20250220021725.430123-1-likun.gao@amd.com>
In-Reply-To: <20250220021725.430123-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c74d67f4-e336-4bd0-8d32-a98fcd81bc10;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T02:18:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SJ2PR12MB9242:EE_
x-ms-office365-filtering-correlation-id: 893633af-6ad6-4488-b7ca-08dd515557a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eKBy0sMCLuCU4uAwIpbSZ/izc0hxdBpP7sEWHlxdZJsEqyf7gjpAK1EJm1g0?=
 =?us-ascii?Q?dnhQJ5QTRn4/eNoQo40vyJ0yQFBpJIb61jcyaLbzDgIeMcNflF6yJ57DBzzt?=
 =?us-ascii?Q?jYDH+6E1fv6yybpsrbWCdYu9ENNpgZ7jw8a9H7RwXANCuA/klu/hxo0INomX?=
 =?us-ascii?Q?JzdMAm4EcV9TuYGCc+jf6mFZX0rA1zeVsB7yK2ppgshhYU1A3S4ZbraAWDWi?=
 =?us-ascii?Q?zwn0UZtIeQqTfO3w1cCZNm5d0n4yF9TVtuiLHEsVC79EdYvsnsLo+OLqb8mm?=
 =?us-ascii?Q?1Bzvc8cPUPD33dXFPo1AdZGHh3LM86cYro/vdiYClT5x4M66eQ6o0FtRVWxU?=
 =?us-ascii?Q?dsutqIe+WWgnJ448ycqG4NvVCCWk1vSlbRBCWDj0DO/32CwLCXNI/oj5jHdc?=
 =?us-ascii?Q?MLc5T2cSglyw3wTZ0IA7S+Zvb+vra0F+Diawfa8uVecIgZgMy4zTJ+3g9Gya?=
 =?us-ascii?Q?nzmVOJ5bvzEkjxVmf2Zc0x4Pxe5uipmZgHlEz8k90Ombfo8CDSjmXlNKLxi6?=
 =?us-ascii?Q?D/vAbJZvGATwlwIw59UvfqbQzmLn0NQylY8ic3Y7T9qzhSwZ2rHBHcZD82jo?=
 =?us-ascii?Q?FlhF60OMX70fELbznZgi+ia6LojUJDSBEhPPXR5tqJ+r5c6kyMg2QV6sC1uH?=
 =?us-ascii?Q?rNEW4CHk1ICWyClyQ6/iqMwBpC2+4iNhugfrom1q2aEC88Q24Wag0fkdseE9?=
 =?us-ascii?Q?WyScwXywuUs4yyDcynIQjwWBz6gtuFq2Z+CjtC8SjCrYoxVyInC5s5F/e/YL?=
 =?us-ascii?Q?lyaFeLJtS9belAm6c4VjtXUpjdhQGIQvQKBo4TtL5A9rO3vCXSarJqwjhY51?=
 =?us-ascii?Q?4j9Oi5NiQpUNtGj2QeeMsgj35XAwHMgc1iyM6XMmyUQKz3ZX9WX3Mfkda9e5?=
 =?us-ascii?Q?/c4DrkaV+Nv/K5r3WZLSmjofH2tbotaw6Pfhif5qW1KXUiRBzrov2oblrsbI?=
 =?us-ascii?Q?ETmVdjvdY2HzzJD9tGpFZTBmBETiFLiueveZU+nWhpn8BxZe/D6SL673x6v5?=
 =?us-ascii?Q?l1Zxjfb3MUl41U2JqGPoIjuTPfrhUz6lz4NHJ1OCwOYsUJW4NIoKuSaKAJ6p?=
 =?us-ascii?Q?9ylHl8V44MZ+I8bkQImwZ8eTr0bkPOtR1PXHPBl7nyzKXciAsthjSvpZpKxa?=
 =?us-ascii?Q?XFThsrCEiE2ELPC8uvuMCKhCHWLi7K+6ZbMF+cWjw0F041f+hy6HQyHuSwwE?=
 =?us-ascii?Q?2Xv5b4VHAawrnORCmhBQDEwCNT6IU5Tca57xObX+6bjq8EjhAbx/3xHLDzch?=
 =?us-ascii?Q?POcJO7j+ilv2PUWYy6IWU/r+zhKx+G844Wk/psIPbLI3e5HZlzsXk6ovSitj?=
 =?us-ascii?Q?H7GXNQzYTV8NnvTg2+Cy3KUlX1ohOSHA9lVQNtmMEqdfKIrpcEmvRLW7PdwW?=
 =?us-ascii?Q?HgSMrxQ9WbNqqldqHSBypVyVIhWTURBYt/8KHlavZyHYa+O+7WGKbiUefH4I?=
 =?us-ascii?Q?aDGMoJHvju2V0XJkIK/VBIoSY3s/QF9w?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:lt; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqPvhJvt1TQoVOvliDHTIzQiJsZQEoBKs4LI2svoDERDhiqLTCiArXTDaYfF?=
 =?us-ascii?Q?TxGn0y1HdM3k1zW2eyVI8/45VQu3vXmDVcOuiBG3rUBJE8+U66GSwKMDgM4B?=
 =?us-ascii?Q?x6TOn78kOPYcvDVZvCXtihoYJjJq8KQrmAFjnBYeXyw7GZd/E0JUD6ccufmJ?=
 =?us-ascii?Q?7mRWt5Y1LuafTjA2f5rBDx1m7M2J0AJ1tXOv1eizz/LrDpfJR2xuuz8dPa8O?=
 =?us-ascii?Q?mISp/PCwGtA47zpH6h77eGxCjMSqttoNr/6/2Ycn8yMQ9ZvQYYYunIcyv5JD?=
 =?us-ascii?Q?1irYWg7DLYzU/HX6GUk374Rdb0FaK4OSI415w+FmPMc5W/eFT5YbQ2T4sjeS?=
 =?us-ascii?Q?ogqpE7uw3wvc9j4/7G0P5jc83tpdhTMj4oCXEcP9uBNEdG8vS3vJPebVStEk?=
 =?us-ascii?Q?0JEKkFODDL2WSg+ly1xWtaGapmO70ViutYBDZUEnrd5z9wOCU97COBMx58Y4?=
 =?us-ascii?Q?hBgBMOfysmExYu/9v+ZWdr0Kl5WoK7J19WXFpKKrKnksnQEwQOD0k+0MvLnt?=
 =?us-ascii?Q?18z4PiT6iN7KtXrQN+liERwOm8uf5meB/R8SuWlb8VGQIF/Hra7bPtSn3Ra/?=
 =?us-ascii?Q?LnhQU0U4BpS8PPzElZAVU9vrjXEUGxMbpSvQpFdMonRrH0Pb8DVyKwlcZYy5?=
 =?us-ascii?Q?kRqRcESnYn2vqQowpakqUuLWpwVYln5hG1VBUCpICoIXZB15KpF/mg1G33Dg?=
 =?us-ascii?Q?aGPO631aPSeXAsO8+WtXz9ze7TrvOf+DHoVLMP5a+5JWtw+3c3p9FAm7KmkH?=
 =?us-ascii?Q?Pxa89qvTpZGw+AQ4wPrvzhsod8nRnXEnCvTrQKtkSg9kLEDg+35ZiMBhuEUE?=
 =?us-ascii?Q?JgeryMGhq7rgwBjy/ZXZ07T0OXvpQIMR3VYe+MSwqu6DfBLfT+EwGdLxTVoF?=
 =?us-ascii?Q?92K8S4HaRgzRnB4sWUfbAu8D/F7yWJ2eBIwrwKZAW65tHxxXiJBZu9LgICOM?=
 =?us-ascii?Q?eKUDKni+rPAeA7OhmaSnyMc8X0CjbCn9u4MED5uY9sgjBocNU6OdRWfaA6tj?=
 =?us-ascii?Q?kpyKkpcej/7XZDP2FysCS2E4oYe5IiSij2VxnRqDEb/KIcR3ArLOoK1/a/VI?=
 =?us-ascii?Q?w+wuj0shSvqsAoNlGYmi38Erwh5mtMyPaxe5k4LxL5foYAyP2ilLoWObSal+?=
 =?us-ascii?Q?w6tOSL65LMRr8Z8S8FbDSRK0rgwbsJDcP+2rcBQRODz/OXirK3gqPTE7Bdre?=
 =?us-ascii?Q?NrFblx4OKyRVY4TzuKdSLNVkdjlDxEiFUHmXsoWDj5cxpWSIgNAoa7LuYxZ3?=
 =?us-ascii?Q?1Tuz4PP1YDF3maU8EFD2AJVG/2GP1Q8xioEizcXEJnNP0O/J1NhLOwhVSzH7?=
 =?us-ascii?Q?dWYQKhwyiWM7hA1PJ1Dqg9GEoYUdGCpDpw3SuhEAYqJ8HbhLrR2UE1U6Yo2Q?=
 =?us-ascii?Q?vBeQ+kv42+ePszkE7et7+6Z1BkDBt/UiQFUgqClD+skz8v0cmyVcc2IUkRUb?=
 =?us-ascii?Q?x/HopZLp3sRpsqtgT1f2ap7gQPuKQS8kRzsx2ZTcHVS6Eq7DyN77GfTF2zkI?=
 =?us-ascii?Q?TNUWP/LwgF2wR6ZYpKw8nlgjxABK36Sn4Rb1156QT/nAC1uIjttZATBScKW3?=
 =?us-ascii?Q?tfeI3voY2BceKbuMI4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893633af-6ad6-4488-b7ca-08dd515557a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 02:21:54.0648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlndwVHKrE2XIGTP/wWyQfzhfQ3BLcDiCVdNlQ1dlzk0yMwqtpf3VKipsfi/gSxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

From: Likun Gao <Likun.Gao@amd.com>

Correct the structure name admgpu_mes_pipe to amdgpu_mes_pipe.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-  drivers/gpu/drm/amd/amdgp=
u/mes_v11_0.c  | 14 +++++++-------  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c =
 | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 6a792ffc81e3..044cd325a849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -56,7 +56,7 @@ enum amdgpu_mes_priority_level {

 struct amdgpu_mes_funcs;

-enum admgpu_mes_pipe {
+enum amdgpu_mes_pipe {
        AMDGPU_MES_SCHED_PIPE =3D 0,
        AMDGPU_MES_KIQ_PIPE,
        AMDGPU_MAX_MES_PIPES =3D 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 2af9c69d4b1a..6258a4e0be0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -811,7 +811,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs =
=3D {  };

 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-                                          enum admgpu_mes_pipe pipe)
+                                          enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -846,7 +846,7 @@=
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,  }

 static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,
-                                               enum admgpu_mes_pipe pipe)
+                                               enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -887,7 +887,7 @@=
 static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,  }

 static void mes_v11_0_free_ucode_buffers(struct amdgpu_device *adev,
-                                        enum admgpu_mes_pipe pipe)
+                                        enum amdgpu_mes_pipe pipe)
 {
        amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
                              &adev->mes.data_fw_gpu_addr[pipe],
@@ -985,7 +985,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)

 /* This function is for backdoor MES firmware */  static int mes_v11_0_loa=
d_microcode(struct amdgpu_device *adev,
-                                   enum admgpu_mes_pipe pipe, bool prime_i=
cache)
+                                   enum amdgpu_mes_pipe pipe, bool prime_i=
cache)
 {
        int r;
        uint32_t data;
@@ -1057,7 +1057,7 @@ static int mes_v11_0_load_microcode(struct amdgpu_dev=
ice *adev,  }

 static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
-                                     enum admgpu_mes_pipe pipe)
+                                     enum amdgpu_mes_pipe pipe)
 {
        int r;
        u32 *eop;
@@ -1268,7 +1268,7 @@ static int mes_v11_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)  }

 static int mes_v11_0_queue_init(struct amdgpu_device *adev,
-                               enum admgpu_mes_pipe pipe)
+                               enum amdgpu_mes_pipe pipe)
 {
        struct amdgpu_ring *ring;
        int r;
@@ -1351,7 +1351,7 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_devi=
ce *adev)  }

 static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
-                                enum admgpu_mes_pipe pipe)
+                                enum amdgpu_mes_pipe pipe)
 {
        int r, mqd_size =3D sizeof(struct v11_compute_mqd);
        struct amdgpu_ring *ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 042264767a44..0edd5205d970 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -910,7 +910,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {  };

 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-                                          enum admgpu_mes_pipe pipe)
+                                          enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -944,7 +944,7 @@=
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,  }

 static int mes_v12_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,
-                                               enum admgpu_mes_pipe pipe)
+                                               enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -978,7 +978,7 @@=
 static int mes_v12_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,  }

 static void mes_v12_0_free_ucode_buffers(struct amdgpu_device *adev,
-                                        enum admgpu_mes_pipe pipe)
+                                        enum amdgpu_mes_pipe pipe)
 {
        amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
                              &adev->mes.data_fw_gpu_addr[pipe],
@@ -1084,7 +1084,7 @@ static void mes_v12_0_set_ucode_start_addr(struct amd=
gpu_device *adev)

 /* This function is for backdoor MES firmware */  static int mes_v12_0_loa=
d_microcode(struct amdgpu_device *adev,
-                                   enum admgpu_mes_pipe pipe, bool prime_i=
cache)
+                                   enum amdgpu_mes_pipe pipe, bool prime_i=
cache)
 {
        int r;
        uint32_t data;
@@ -1148,7 +1148,7 @@ static int mes_v12_0_load_microcode(struct amdgpu_dev=
ice *adev,  }

 static int mes_v12_0_allocate_eop_buf(struct amdgpu_device *adev,
-                                     enum admgpu_mes_pipe pipe)
+                                     enum amdgpu_mes_pipe pipe)
 {
        int r;
        u32 *eop;
@@ -1369,7 +1369,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)  }

 static int mes_v12_0_queue_init(struct amdgpu_device *adev,
-                               enum admgpu_mes_pipe pipe)
+                               enum amdgpu_mes_pipe pipe)
 {
        struct amdgpu_ring *ring;
        int r;
@@ -1469,7 +1469,7 @@ static int mes_v12_0_kiq_ring_init(struct amdgpu_devi=
ce *adev)  }

 static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
-                                enum admgpu_mes_pipe pipe)
+                                enum amdgpu_mes_pipe pipe)
 {
        int r, mqd_size =3D sizeof(struct v12_compute_mqd);
        struct amdgpu_ring *ring;
--
2.34.1

