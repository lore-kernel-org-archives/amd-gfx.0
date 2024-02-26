Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89748C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 11:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1298A10E574;
	Mon, 26 Feb 2024 11:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l6FJ+dkt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC4210E586
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 11:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di173ytxw9MM2kY+BjeqsyXEKuHQAUKu49kTZHjr4Kcwtfdam3JPLETmRXkdxDA8fcJb/OGR4042eLrH2CqdOPI4H2nbMTNfKXK52XoRD6THLKvsggHkLEUbFwugpYpRyomt99po0aFilgHBJt7kqM2A2t84S6P1/Q2P32D3A1tELEvGeDHmFdNrNvuX6tvVQJmSJtnDb72g0cxlCDGXC5tyAxglvLFhue5TvoVtsp0jFwv8w8AbaaWh0GHMv4CwPiGP8STxNOaN+6BBUPKscAl/xlEYz4W8wfbiO1KD508YQTmnuiJFlObuAZKN/5ZlXpOkV5EXSDu1wyUkVvjaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpW+S3ndlRpe9c8AVbhYo5G1DsLKH31OVYJING613CY=;
 b=NVf0r8xdMGe8blOVRENa4mNBBIaHJ55w6PpueGFEilLWT9dORVePTSMP+UDIBzYBjUNsb6zVgFIkdpbVUcqgvznkAMppCJ/IKjdEuJfACGnluxP9vWIkXuG/docgpWEmzhoaMVJxqBIx7BwrGOUTNR9DjtBQojUyOT4RZVVqmhuT+KVRaTV8mO13zg3PO+S1lCfrryLgT1nNhF33GnhakhfuM12CgjOgGiLrDkLA0picE7/l7bdp7lMEatTmVRF3iyEFaeMNSC2AILUhv9TdMK265U0XtaPqF5rAmBs4d+KK/Bp0XN4pyAVGAVXxcs8ogDJhjh7f1zkY3D3Yobkp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpW+S3ndlRpe9c8AVbhYo5G1DsLKH31OVYJING613CY=;
 b=l6FJ+dktlhl6slBSaiIJxuJlMxfUF6vY4G7dsbG2O14ILjaeqTbjrSBos+Ge2NrkUNILri9edNZN/z7HLpQZPcuERMlGKxkcguPjvN+3dKsH0ydo5ydf9IgGTlM6NLiql0/DLLgrUdixg21qzU6/1BBI9zFjsz7A0zZNLa/311A=
Received: from MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 11:39:09 +0000
Received: from MN0PR12MB6077.namprd12.prod.outlook.com
 ([fe80::f564:5376:6f5d:7e75]) by MN0PR12MB6077.namprd12.prod.outlook.com
 ([fe80::f564:5376:6f5d:7e75%4]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 11:39:09 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Increase SMUv13.0.6 mode-2 reset time
Thread-Topic: [PATCH] drm/amd/pm: Increase SMUv13.0.6 mode-2 reset time
Thread-Index: AQHaaJ/nHKPO3HUnc0SoPbZc8FZeXrEcf3xQ
Date: Mon, 26 Feb 2024 11:39:09 +0000
Message-ID: <MN0PR12MB607773EB05B5BDF563BD77398E5A2@MN0PR12MB6077.namprd12.prod.outlook.com>
References: <20240226103756.196437-1-lijo.lazar@amd.com>
In-Reply-To: <20240226103756.196437-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2448ccc7-3ed6-437c-a761-882195d5b824;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-26T11:38:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6077:EE_|MW6PR12MB9017:EE_
x-ms-office365-filtering-correlation-id: 4591cd46-d5d7-491c-52b7-08dc36bf8bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8wkOGqxtgU5SvUiQqcalw1GsHnGSuaPMKomemRX9UdlHp2s264uy5WimU3u+cR7juYkneDCxEVNYKnRjZhl1LWArhky5u6vapAUuVqLdYajUVdvY+t4crk8sAhWa3/P8SdZa0W6Lrhj/Wzkf9HYvtGn4vqW9fMMQIGhXBivzW3E9lwy6heCrJs7igks5XRb9M+39u+wSTvVtPW2wBqoW3N57idrqu2uupQpuMmXHMN0ZvAth/UI1lx/oIo2bmLSBUCXOjM35cs6f8znvXO8jIOBaZsR/kK9vQdqY4yp9CUXKtKSY5ByZcqlgJQ0NSmyspUcgZL6Q0j8LO44/glhV/+mtDpG8y07/W0R/aD18HOdgnwFoB7mEsXHNKjF9IVq5MRQy672lJPfGHSs+kqdkqff+LU9Q5kGdQdAs0YZKxkTZhFBOl7xU2fkbGKMLY5XDF0Hsz0Z+z7tgyABKRn2VQQQEU0HeJSb8Y8xxp97sO1YQYGIIMnzWDnz7A+AKR3jHwtdyVg7ZjdVLzqyZSVLRKvv8JONT1lx+LUqNbsBmXdqorvzVYgjrdt1NoVhO/JJQh7wqOpp465ZHTcWVtePuqK8j/ZJhR/PNhIKwYfBnbTimksNdBiYukcUWn1jsPLztJcQrk1V5BN1T1+GbFtq4P8CAdNodn0rBL8SwXphYyaVV+O9rzZQ58nKDrsUU7viB/T7eSEFgceRe9EzZj3yq8nK5MGGTV0UX++n457HNA60=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RB8lTEpqezBBdUnSYhGlRou5Ogg5bsrOWDM6CzuhMXQ4asgJRAwliTIPKYAZ?=
 =?us-ascii?Q?sYtHP7A5g4BU076IwHZr1bkvyondn9yl1BjJq28Blvg6MIFNZJWt4ROwvg+A?=
 =?us-ascii?Q?swrjOmoexRn/nygBKusPWeUNFSqMWeIUD2PzjuiJaRLgu32qLBstBNWVAUsh?=
 =?us-ascii?Q?z2FacUxYBZdXBJYISA1RAJhiRu8dXQ2dOrrwHGEj33zKZQcyS4RgNl21HWVP?=
 =?us-ascii?Q?ln0Gry6/7TTf0lD2SqtHwt+MIpgxlPdilxNKe5v3aQuQe7IlF4TGSbmxqbAV?=
 =?us-ascii?Q?GCMbIC7/kWJpxNgYSrwQz3FcY2XzAdLAJzBjvydpdBogB73FOIvf2fN16gDS?=
 =?us-ascii?Q?Z6E+VzM4q+Ckna1X6Q41nQ9NWnC6aWKAksz8fYYfZXuiX7n9aeSBPOqnvTLJ?=
 =?us-ascii?Q?J5cgFPbJsyn0e2wu9aaWPHCnSxlp3DcFJksLyR5UB3SGwMrXpMxOr2ull29x?=
 =?us-ascii?Q?8rQLvw8ItgQxn72TgkUgaOYZYhz2D+EqKOxEY3YoWuiFFeJWYCJiuShkEyg0?=
 =?us-ascii?Q?+CtGns1wL7NzUbY3pU3QQwwPfEItt/O9qgYeMsr4Afda3i7CHDOyadL+5YgB?=
 =?us-ascii?Q?cFJ+rJ2gdr/pOcPWJNQdsNqsxrhFD9JusTJwPXFlwtVclUKJ9HwMNvUFnFQN?=
 =?us-ascii?Q?ZNhEKVhLUnnUx/trylWdoR6mAAc4KYp+9/RsbPL4SQpT9A/DSimU4KltQNtj?=
 =?us-ascii?Q?tWMRbx9WpxC069wnLpUQwz7//+fdLfOa0kkK4wB4zRSkykeL4//Wlk7JNK9+?=
 =?us-ascii?Q?7its3q1L41JpUSgtJ826K1Ov3qAgHFIIWrhBqAgj0CnDR+DhH5rQoGAmtWxL?=
 =?us-ascii?Q?koU//O3RoeVmwYZwrcEMfPK4GR0gPm8OFabgsfeigOiW1oZZOYkvD28t8Pw6?=
 =?us-ascii?Q?ip9IBeb6uLQ/KSS5G0grhUxE+R2OTdS7KSw+zRshhP+eaLREK+1UEjjJjXAq?=
 =?us-ascii?Q?VgQPIFxlM+rDQ3dk3bIApdXjTEAZtVy9up6rgkcZrCTk4lEVuMri7OsElWjt?=
 =?us-ascii?Q?Gssja9ErcpyEfRQUz65CX8FEwsUuz8F1vnEr/AkXroCx/oHAXCkM3nhGHL7d?=
 =?us-ascii?Q?Kjl+dJoZyFM3IePvdd8uEDsLmELesGv7yKVAPx6TvRiWsUaaA7p5ZY1r+xr6?=
 =?us-ascii?Q?e4K5i+ugx4/lHbmtlppGtpJX0UM2ZXW53ZcFcCyql6GnFkXNte2HKc8HivaL?=
 =?us-ascii?Q?U2XYCKepCjfd2gy7FomNr+s4ZJVpQZ9s4VuGtLYY8uuxyQWxcq9fViI1uo8q?=
 =?us-ascii?Q?9QiXE7Zh+KlhR2FI9ZbAXl4y2fnKlCcpUm78VbBN+bsqNwFieFn/gpobv0Cz?=
 =?us-ascii?Q?K2v3YaIt/I92AQdWLCMCbpHM20tcyAcTexaTBM234ZXyN4qj8LqYmPfsET/8?=
 =?us-ascii?Q?zEPSlwOYTATl8bnfz37y5AjF3gDTbzuY8vxEw+40ksggVmI8mRLpxsIU0RBy?=
 =?us-ascii?Q?AaRTiF5cDf3K0FeXkdbBOBhVsHQ0XNyGMsMgRgW6ARUpIYV6n/EmcSoic0iH?=
 =?us-ascii?Q?UMLQa8XPTQrbXUlJeYyht2heaYlxxASGnSVGYJ5c0ZoUsJ0S7mmcJHJ1MsSF?=
 =?us-ascii?Q?ozUE930g4QHuv6oTtNE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4591cd46-d5d7-491c-52b7-08dc36bf8bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 11:39:09.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyiXkO/Ej/5A+DdlbNqFn1POuWb/kvqbfJbOXnjdPVf12XARUBZpuVog2wZCq15QxLCEIo3K0b92M87IAN9BPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, February 26, 2024 4:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Increase SMUv13.0.6 mode-2 reset time

On SOCs with SMUv13.0.6, mode-2 reset takes a bit longer. Wait for 200ms be=
fore trying to restore config space after mode-2 reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 29c102fe650d..2b7a60b23d6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2307,8 +2307,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context=
 *smu)
        ret =3D smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
                                               SMU_RESET_MODE_2);

-       /* This is similar to FLR, wait till max FLR timeout */
-       msleep(100);
+       /* Reset takes a bit longer, wait for 200ms. */
+       msleep(200);

        dev_dbg(smu->adev->dev, "restore config space...\n");
        /* Restore the config space saved during init */
--
2.25.1

