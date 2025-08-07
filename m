Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8975C87FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 07:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D67410E7F3;
	Thu,  7 Aug 2025 07:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5iIAea2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDB410E7F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 07:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAkyibhGqWIkcVxzwb7gJ+yBWfKantscUDEKFCOmUFEerIC1BhRP3xBhUwDgOs8YFPOiBRIP/YsrS2gm86PQnF/wfgzGiav/P+p3uISi2cuP0/p3lcmbbFxwwJQPBAkaKpY7BWbYeGe6d17d8ORDyrELDG+U1BontiSkJ31jhqLqFLEyKkJI6voUhnhaUahpNvyA2aBZj31LX/bwuheEU+d+t8tHMgNV9GNAqtPsVaOFRrGoLZ2+p0SE4pPAbUYW5w9ZNH+pFupp7jpxqhb+l6y2BHDL3ZUagE091Ck1g0/aI78RY4k2jFsbMpnygT+q8D+giHPQHt9ipABOG7XP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AFnm0zh4PfJYVofyLL9lN90yHI9rbc2APthcDJkO/M=;
 b=T/qjUIDSOKxcUL9RzOWMfeHiW+3awvv3cBVY2YqftMYy5Vi6WTvY65zVPiUy0WI+1HwSC43YFRPNJf2XvN1MaC2fqvg71L22hreqx4xXm4w+XYMzpNd331WM+Oyg0eClBdxeH7Rfa6UaDoao4vqxOpBm3PNwQFrfeEEU2ZahnK9DqR1ZKR2AMCxgMWMYjMtxZspD6GpNE8bzBJvlJ6iQxugrqNNCsftjLPcxh0XuJXqusEIjQhl8PEnsPKlxvAVIXy7Wu1R6rcGy1h/xqIM2TVZsNUfb/xI3Ly1YtJDkJoWxbTpyxY7/YJrTwXsAJ3TUZmZuMON6LUx05FHbXWymnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AFnm0zh4PfJYVofyLL9lN90yHI9rbc2APthcDJkO/M=;
 b=K5iIAea2kAbPdk1pcdtzY6cGPE9+5F9DSnjL6QPd9lFTR1ziqf6xRLltnB64Qj7hXOkpu6lSzXDH4q8mBPGwkMGokMkxJaiK6zaBcQoR9MAfngMeaiM6xOrZk6/3pTBIZfWMfwWjuvYKan1UTH7iycLrnWNmC7HPh1IrxQsbT7o=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 07:33:44 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%7]) with mapi id 15.20.8989.017; Thu, 7 Aug 2025
 07:33:44 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Save and restore switch state
Thread-Topic: [PATCH] drm/amdgpu: Save and restore switch state
Thread-Index: AQHcArWy5GAVvd+740Ko/XY2srcdjLRW1XBG
Date: Thu, 7 Aug 2025 07:33:44 +0000
Message-ID: <SJ0PR12MB696772D817E9CF022CB73AA09D2CA@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250801072651.1703020-1-lijo.lazar@amd.com>
In-Reply-To: <20250801072651.1703020-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-07T07:33:43.9640000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|LV8PR12MB9084:EE_
x-ms-office365-filtering-correlation-id: cd8f3221-44ba-4a01-abde-08ddd584bd4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OMXH3BnDHrd57pSYtOz/GEE7rqPdB0M3YowRQpBAxgkM+7Oqie3BwvPFWUMi?=
 =?us-ascii?Q?tHtLx/DdVfyUzQOZ3x89Co2HxzJ+EAG9XLXs0+P2BVLMx3PqWOmZOlrBt8Ys?=
 =?us-ascii?Q?mW+kzZLWJ4uNoxxnECgk5CSGcdriqd7pdnHUFct5wsxO774mOgeqGeuBPh0c?=
 =?us-ascii?Q?tPVoD5/WOWybCMJH535FL19bwu7grkE+UyvEGfxuuvr7A7CAZAAYvAGaJxce?=
 =?us-ascii?Q?s1G6wUinaJ5SAPr06dl5iMlT2O6cj6CI0deNzrBpqzrfA6x6NE1yGfplg0e9?=
 =?us-ascii?Q?+4s+dalLeumY3mOA//ojGr5SioBbSxqAYspK2CremjU1gzhL3N7IWSl5vNRW?=
 =?us-ascii?Q?5WxN0PNDxp57Dg4bLHKHzSiO2VeWkb0MvLcrKuj1J9VNx+6GQ7vc3+bQi/fn?=
 =?us-ascii?Q?ggcLG/7GTUdpv2hy55ud3NoehZaHC8UbMdQQvRGH+UQZA1JPGUIPqUgAajx1?=
 =?us-ascii?Q?i+okfkmLzT4uXszs631EOfa6fSqcEPQ42pzrjPF+fjha+U3Nz+ITJq8QCmAj?=
 =?us-ascii?Q?jJyABgUxAaezCYbgCubAleRtMr2QBNlxSffNxjwdQtHCzUdYCvdDm4GYnGHY?=
 =?us-ascii?Q?uobBHR4sI06hbUdhDbsnGfT8dlapJYLiIIdpQZc71BNto5cIbpTvttnXiLu5?=
 =?us-ascii?Q?rNHFgVsOHcjdTidc2UVau/0OYgDVJ+ZzP02Z6znV/tfwglL7XsCjQoehnuMK?=
 =?us-ascii?Q?Qk7PGb6QF3uFb6b1/PE7UsQ8Wb0/2tlfLqgBiT090KkCNl49ZUl3BXLVaNJ8?=
 =?us-ascii?Q?eITQe1RrmkYeEw6vRJnUz5caOX2KqL26+kY2cMguZDXCdNuBflf6FzTVymFl?=
 =?us-ascii?Q?kuToDLbmOY9mXODx5eq2UBwBowLxWtABGfcDb0O1KG/jV99pxLEGqpltmGtJ?=
 =?us-ascii?Q?vyTxoGGrd6oMIF+5bInLK5I916DkvrbDTAS/z+W+g0h3oSEn/vFN7IYFmLjf?=
 =?us-ascii?Q?vvZS7McGU4m72Ff16yZXw+qusGyNFMTx4pjQoZxulMpsBcCvVqwRKw+WB2YD?=
 =?us-ascii?Q?AXP0EXR2HBB7lyzSKwkHzfxzJNZcA2UoT6qACESRIO1XkjQ79FnO8lxxbU+i?=
 =?us-ascii?Q?DAKD2YOkD7HoQJ760wybWVLwneNdAGCsBiq5dSCl9zaurZh8MTvuYfSA1JGs?=
 =?us-ascii?Q?bhCjDWVpE+8PGZXiL4LQWiWedw7sTSAg7lv0RMFZihBYO/3g+qABzn6RrtJO?=
 =?us-ascii?Q?mrBphhzvYYYj0ya7tGNvlt/6MnaUT7NIIpQ3O1SLU/VERRZ4z0Mt3drOUTWt?=
 =?us-ascii?Q?suKTuNDl5Tb7p5fgXeZ9HEIN2J8RA/UsToLVmmvtsC2HAZmSTiWOna29E/g/?=
 =?us-ascii?Q?g7nEkuLZ6/xCWxHpaGdkyfGZI5qxyrbItBvXxlBC7iQJW3Acjcdezgv1JuPN?=
 =?us-ascii?Q?AP8HKLEQdFiqCl0hu5eOyZdkjkjMx4e7JojITDRqpyyONsBEoAQ6j40HAUHu?=
 =?us-ascii?Q?aLoP5Cb6NMiG19VK2/AiKbGXrIJivBJ+W0YYRNhblsLlwRd8NLaF9HivFW0F?=
 =?us-ascii?Q?ci1WsQMpExfUIPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CRr3lXCgEH1Zy2rWPEXDIrWJjTPx9jx39OOXcFmrD6zjFDt1lwzdjeMUP1+y?=
 =?us-ascii?Q?LM6hTgzFik7V0rrxYDMIOUFucW3RvwfcalJ6tvYaMvA4eSGeB/B1EGe8AhSG?=
 =?us-ascii?Q?W/u3qbUeJljT3lKfCgrp9ssx3wQ5XIY8UyAlClKHM54CspPkKaVfFsKlmVVD?=
 =?us-ascii?Q?c6ZGIrP1cbTUQtvCF8nkhfJn5RxC4MzvAsgyFWhsvvakLxME8jmlqws/9/sr?=
 =?us-ascii?Q?NTg8J3yRXstuU2ctG0YRuO+pep0gEKNauMO34UX5laG/oXxig8PEXvAwq3Us?=
 =?us-ascii?Q?poXdpoS+Zr1dM93bZKMUUlJAgxZSfXat2G9vt5HbKAcjx1YhI36kyPLEiAgq?=
 =?us-ascii?Q?wdJSH4/XvpD5O6pDytQUEr5nFnfqFOOE/RT3mW1Eca9Sy3ZKIRwr2CdgcvYF?=
 =?us-ascii?Q?eZD4TDaPKZFSyIWgfvRZCVYy2bV0w0Y8tvXREbUTX89MpGAS3/JOVZRbZXtb?=
 =?us-ascii?Q?dl4YZncC31ZAD5rSEvC+AI7md51wF5VvAwc7Zrrkonv3g99zCBk/BOkc+OLY?=
 =?us-ascii?Q?Hgg9xB3oN17PxlrRPygeuVXayUk9wkDbABVKil4bh4IxQmM56ti7lg2qG/5z?=
 =?us-ascii?Q?ahwH+4FJ7zoX6alL1/xmcRe3nYoya1FLK/vqU59FYcmyb+TK259qtrhgFD7u?=
 =?us-ascii?Q?mvnyBsUMupXEQ2GLP4louXb+LLn0brDepWxlDxra3peeEzsqSAkLJftEjMeh?=
 =?us-ascii?Q?7O0Xfx6dSUN1havCIYHs1NI2E5pcgAGapfdTJBUG6KPUlWcbq7gKTifgxjYw?=
 =?us-ascii?Q?zdIEzulaYhmeo/DeSz26kII/Bkb8wrHmumWeJa+xFQ7unJu52eQzNwuCPgCt?=
 =?us-ascii?Q?ratcyL6mLvDa39sfzl3i3m31Z1uwIJHcD5pcDY0ALiJ7Gq4rI/SnqPjckO8T?=
 =?us-ascii?Q?BOBYHyfaDqaMlGKINhAYutGQCtJ5KxWM+Q96kVd4Q4M/Q+iiuOnL5dZX5c2I?=
 =?us-ascii?Q?t4UbwJ0LHZDoeZP/88+O2OnrUOFED6MbVgcZ96OYPZtxVMbgbt00VX0cHT3Y?=
 =?us-ascii?Q?SeKNduFpJGOHOKpR5eBNvdbpbnogap8Me2PiHSchuni12kiPZ1SLKpkhnVXQ?=
 =?us-ascii?Q?+Gh5LTZti3GKqBhyTSN8YIa7OS19GSAg4hu6G4r/1q3k0XeiRCoPZ0lZoK+N?=
 =?us-ascii?Q?X1MXeOjDb1XoYJDZscqUltLbKksMt8xVm9wxp9HMTNFEgFlW0D9k7qoOXnmq?=
 =?us-ascii?Q?PPedBvqu953WaRxS8PwpP9bt2QndYfFHg6n22GdGCisX1phVBN1jpXtL+OOH?=
 =?us-ascii?Q?nbqbm9oI2vlF3YC6SZqc3RxeDPO4HbH0B0iXjeMYZICKBgMwwkw63sNBdZIO?=
 =?us-ascii?Q?opDruAen6TkO3ojDnxQE7xv0J1Nt41EfwYMG5H14xoJKTZ1+hQCgP7WLJCnb?=
 =?us-ascii?Q?XRz3M9VVp4uaAOOE3HHTbmVeZxVT0uPnCZFTladBGACK2SpSotrtdg3asDvc?=
 =?us-ascii?Q?yk+bn9qW1+zL3vulh9O6vunIcHH5ObBT0z4XJZR9E77TBCvxZW1hMvxF4Bv8?=
 =?us-ascii?Q?DUt1f99ZQZh9Wn3FkDBjHYebzL9i95QV/t2SI4AuCC0jt/6Ul1iTdo7PEqQK?=
 =?us-ascii?Q?dPnn97oIXlawpFixDec=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB696772D817E9CF022CB73AA09D2CASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8f3221-44ba-4a01-abde-08ddd584bd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 07:33:44.4524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMZBOef/RjmUS7tLydX57ZialRORiDzulaf/xJ8T6mcW8fAq0gVCSXBdWIp+FwWSSAvcPwrsAIhOrNK7iIid+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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

--_000_SJ0PR12MB696772D817E9CF022CB73AA09D2CASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: Ce Sun <cesun102@amd.com>










Thanks
Ce Sun
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 1, 2025 3:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Save and restore switch state

During a DPC error kernel waits for the link to be active before
notifying downstream devices. On certain platforms with Broadcom switch
in synthetiic mode, switch responds with values even though the link is
not fully ready. The config space restoration done by pcie port driver
for SWUS/DS of dGPU is thus not effective as the switch is still doing
internal enumeration.

As a workaround, save state of SWUS/DS device in driver. Add additional
check to see if link is active and restore the values during DPC error
callbacks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78 +++++++++++++++++++++-
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3550c2fac184..96d772aadb04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -904,6 +904,9 @@ struct amdgpu_pcie_reset_ctx {
         bool in_link_reset;
         bool occurs_dpc;
         bool audio_suspended;
+       struct pci_dev *swus;
+       struct pci_saved_state *swus_pcistate;
+       struct pci_saved_state *swds_pcistate;
 };

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cfd72faec16e..962c57a3ec93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =3D {
                 BIT(AMD_IP_BLOCK_TYPE_PSP)
 };

+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
+
 static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
                                              enum amd_ip_block_type block)
 {
@@ -5006,7 +5008,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)
         adev->reset_domain =3D NULL;

         kfree(adev->pci_state);
-
+       kfree(adev->pcie_reset_ctx.swds_pcistate);
+       kfree(adev->pcie_reset_ctx.swus_pcistate);
 }

 /**
@@ -6963,16 +6966,31 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)
         struct amdgpu_device *tmp_adev;
         struct amdgpu_hive_info *hive;
         struct list_head device_list;
+       struct pci_dev *link_dev;
         int r =3D 0, i;
         u32 memsize;
+       u16 status;

         dev_info(adev->dev, "PCI error: slot reset callback!!\n");

         memset(&reset_context, 0, sizeof(reset_context));

+       if (adev->pcie_reset_ctx.swus)
+               link_dev =3D adev->pcie_reset_ctx.swus;
+       else
+               link_dev =3D adev->pdev;
         /* wait for asic to come out of reset */
-       msleep(700);
-
+       i =3D 0;
+       do {
+               msleep(10);
+               r =3D pci_read_config_word(link_dev, PCI_VENDOR_ID, &status=
);
+               if (i % 100 =3D=3D 0)
+                       dev_info(adev->dev, "read status :%x r: %d", status=
, r);
+               ++i;
+       } while ((status !=3D PCI_VENDOR_ID_ATI) &&
+                (status !=3D PCI_VENDOR_ID_AMD));
+
+       amdgpu_device_load_switch_state(adev);
         /* Restore PCI confspace */
         amdgpu_device_load_pci_state(pdev);

@@ -7074,6 +7092,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
         }
 }

+static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
+{
+       struct pci_dev *parent =3D pci_upstream_bridge(adev->pdev);
+       int r;
+
+       if (parent->vendor !=3D PCI_VENDOR_ID_ATI)
+               return;
+
+       /* If already saved, return */
+       if (adev->pcie_reset_ctx.swus)
+               return;
+       /* Upstream bridge is ATI, assume it's SWUS/DS architecture */
+       r =3D pci_save_state(parent);
+       if (r)
+               return;
+       adev->pcie_reset_ctx.swds_pcistate =3D pci_store_saved_state(parent=
);
+
+       parent =3D pci_upstream_bridge(parent);
+       r =3D pci_save_state(parent);
+       if (r)
+               return;
+       adev->pcie_reset_ctx.swus_pcistate =3D pci_store_saved_state(parent=
);
+
+       adev->pcie_reset_ctx.swus =3D parent;
+}
+
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)
+{
+       struct pci_dev *pdev;
+       int r;
+
+       if (!adev->pcie_reset_ctx.swds_pcistate ||
+           !adev->pcie_reset_ctx.swus_pcistate)
+               return;
+
+       pdev =3D adev->pcie_reset_ctx.swus;
+       r =3D pci_load_saved_state(pdev, adev->pcie_reset_ctx.swus_pcistate=
);
+       if (!r) {
+               pci_restore_state(pdev);
+       } else {
+               dev_warn(adev->dev, "Failed to load SWUS state, err:%d\n", =
r);
+               return;
+       }
+
+       pdev =3D pci_upstream_bridge(adev->pdev);
+       r =3D pci_load_saved_state(pdev, adev->pcie_reset_ctx.swds_pcistate=
);
+       if (!r)
+               pci_restore_state(pdev);
+       else
+               dev_warn(adev->dev, "Failed to load SWDS state, err:%d\n", =
r);
+}
+
 bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 {
         struct drm_device *dev =3D pci_get_drvdata(pdev);
@@ -7098,6 +7168,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pd=
ev)
                 return false;
         }

+       amdgpu_device_cache_switch_state(adev);
+
         return true;
 }

--
2.49.0


--_000_SJ0PR12MB696772D817E9CF022CB73AA09D2CASJ0PR12MB6967namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Tested-by: Ce Sun &lt;cesun102@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Ce Sun</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, August 1, 2025 3:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Save and restore switch state</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">During a DPC error kernel waits for the link to be=
 active before<br>
notifying downstream devices. On certain platforms with Broadcom switch<br>
in synthetiic mode, switch responds with values even though the link is<br>
not fully ready. The config space restoration done by pcie port driver<br>
for SWUS/DS of dGPU is thus not effective as the switch is still doing<br>
internal enumeration.<br>
<br>
As a workaround, save state of SWUS/DS device in driver. Add additional<br>
check to see if link is active and restore the values during DPC error<br>
callbacks.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78 +++++++++++++++++++++=
-<br>
&nbsp;2 files changed, 78 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3550c2fac184..96d772aadb04 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -904,6 +904,9 @@ struct amdgpu_pcie_reset_ctx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool in_link_reset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool occurs_dpc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *swus;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state *swus_pcistate=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state *swds_pcistate=
;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/*<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index cfd72faec16e..962c57a3ec93 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BIT(AMD_IP_BLOCK_TYPE_PSP)<br>
&nbsp;};<br>
&nbsp;<br>
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);<b=
r>
+<br>
&nbsp;static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type block)=
<br>
&nbsp;{<br>
@@ -5006,7 +5008,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_domain =3D =
NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);=
<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pc=
istate);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pc=
istate);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -6963,16 +6966,31 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *h=
ive;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head device_li=
st;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *link_dev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0, i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 memsize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 status;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;PCI error: slot reset callback!!\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context,=
 0, sizeof(reset_context));<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ctx.swus)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_dev =3D adev-&gt;pcie_reset_ctx.swus;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_dev =3D adev-&gt;pdev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come o=
ut of reset */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(700);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; msleep(10);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D pci_read_config_word(link_dev, PCI_VENDOR_ID, &amp;status)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i % 100 =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&g=
t;dev, &quot;read status :%x r: %d&quot;, status, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ++i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while ((status !=3D PCI_VENDOR_ID_A=
TI) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (status !=3D PCI_VENDOR_ID_AMD));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_switch_state(adev)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restore PCI confspace *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_sta=
te(pdev);<br>
&nbsp;<br>
@@ -7074,6 +7092,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)<b=
r>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *parent =3D pci_upstre=
am_bridge(adev-&gt;pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (parent-&gt;vendor !=3D PCI_VENDOR=
_ID_ATI)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If already saved, return */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ctx.swus)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Upstream bridge is ATI, assume it'=
s SWUS/DS architecture */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(parent);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swds_pcistate=
 =3D pci_store_saved_state(parent);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parent =3D pci_upstream_bridge(parent=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(parent);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swus_pcistate=
 =3D pci_store_saved_state(parent);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swus =3D pare=
nt;<br>
+}<br>
+<br>
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pcie_reset_ctx.swds_pci=
state ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;pci=
e_reset_ctx.swus_pcistate)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev =3D adev-&gt;pcie_reset_ctx.swus=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(pdev, adev=
-&gt;pcie_reset_ctx.swus_pcistate);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pci_restore_state(pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Failed to load SWUS state, err:%d\n=
&quot;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev =3D pci_upstream_bridge(adev-&gt=
;pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(pdev, adev=
-&gt;pcie_reset_ctx.swds_pcistate);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pci_restore_state(pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Failed to load SWDS state, err:%d\n=
&quot;, r);<br>
+}<br>
+<br>
&nbsp;bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D=
 pci_get_drvdata(pdev);<br>
@@ -7098,6 +7168,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pd=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_switch_state(adev=
);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB696772D817E9CF022CB73AA09D2CASJ0PR12MB6967namp_--
