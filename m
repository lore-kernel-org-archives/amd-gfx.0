Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F02C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF5A10E2AC;
	Tue, 17 Jun 2025 15:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lUnUuTWG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF0F10E2AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc+KNMRKMINjBFTbMtKnXP3MLIqLDtRtIn6xRkx5Y0tirBYuvi5lk/ZooSkGhSuEsN7ZO1NCjJapSXx2e18MQtvLZHVCQQISBwgF2PYXcThaAcqoqWOwQodk2tJbbI5CBZy++FVQ7ev6rso5zwR+gh+ugClhppStuTgH5ku7kKLfzW2mnjL3fZGmdnQ0WOrJ9HrodBDvzXNqcHfKtICGxH5H+vYwuXMpX/eFdgpn1CLjNsPJrbOz9GBr7wHgkz6LzDAIH+7+ISPLwirIM4MI+lgGF1ZApXdFkaRt1wHMg6RaP8/t1afr0w7xG8ojvYYiWT85+q+bxUNZySDL4JTbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmzBQjS8L9iaTGPqZzBvaNPBbPj2cAA6IiJ/3CyOCHQ=;
 b=dFowrvsK+z4SyRVKca6Sr3I84Oyf6AM2ZEAzsrq7hGhdfl23uTxmcA3GzQJ+mQxP+ggYb4hjMTmwgMBJSdpCLbsZvJg8wnpjf6swci/ovKWOQqqq5ATLQK2uToonPwYNAt+DSUTXom5epHYhPP4pfy85MCUBerGBsR3yLMDkCTiIlCkp4Og2wJQoyARq0xdQ/fuk7GWkP8+Z1OZ7kQ+Djf39LfVKENR9vPk2od9mmvkv6/V8Vtmt9vAMpO7qWgCgWCk9aTnvKaS4+bhuu2bE64hDY4g7sxmb7VH0IqgNFjooks/2FQ1pja8nfajczWNHMblP8HWS0RJktRo14XR2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmzBQjS8L9iaTGPqZzBvaNPBbPj2cAA6IiJ/3CyOCHQ=;
 b=lUnUuTWGUrp6ochOYPLSRZa/Z0dXDVLWpzHrK63yaFMAFYQsFpsSy6T8xVWVkCTTqd1/OJy7jP85ejGCMn80oRFWFF5bibiXJ+dgRtufYz8FiCZH1BkHacJKFMFqB8DuniW3afDsMu5gvUiv5z6fAecDSYbKB5npFYCI0aPSTp4=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 15:16:15 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:16:14 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix race in GWS queue scheduling
Thread-Topic: [PATCH] drm/amdkfd: Fix race in GWS queue scheduling
Thread-Index: AQHb2uFL+iMq3SaxokyCSAFBUjJJ77QHf6AA
Date: Tue, 17 Jun 2025 15:16:14 +0000
Message-ID: <CY8PR12MB70998BEFD1B9DA50A2F1669E8C73A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250611145806.3919952-1-jay.cornwall@amd.com>
In-Reply-To: <20250611145806.3919952-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-17T15:16:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM6PR12MB4106:EE_
x-ms-office365-filtering-correlation-id: 07442ef5-e9c9-465b-0371-08ddadb1e6c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FFk2DSw9JA/MaYBgBdu/DngN1o+nUZua3D+5rX8Qs3kOJzvt8+IkR2iqiJsh?=
 =?us-ascii?Q?MX9tOm5JzKpBBsomucaf5e+/TJNctCDNcZLZLRfeXK7LwiPBBFKkmhUhfcRy?=
 =?us-ascii?Q?ygqHQpe06/KM2lBT6Drksaj+qKiYymy3FwKaNeYXnBGh0Ib5eyapVmtwAvrT?=
 =?us-ascii?Q?zm2BXyaxhPQ9xfZK3v0xSPh+vfJ6UGvK4WOUqtgm4oO2SgKZCvSKXnN4TxYP?=
 =?us-ascii?Q?qp3F4HDa016ojicmh8E7a9rTPb+RAWIN83dusaRUYI8kOnlu+BVO4DJpHzoi?=
 =?us-ascii?Q?DqAjAhvoPr8cfke2DUP/85fu3Vn25jRHZWsu6vLZCyrOwQOADGspyw6QT3lM?=
 =?us-ascii?Q?0EuDVF4tkyRxtRSdFq43MvBaJPpxOZlbLp/lPyimdKV+sqdGT+4jbLc8hiit?=
 =?us-ascii?Q?cWOZOdG0GZj3K/S5Ghg2+XGzmVSAujz90wYZKkJTCp0ZIu+utcl1veXYlbpo?=
 =?us-ascii?Q?/iu5oqm6CoqI3+WjS/RJOCepYzSI6Ogn1lZb+y9MzSpOYpo9Rg532Eb2N9u6?=
 =?us-ascii?Q?n2jItWe4B3iPRfdDx9u/YbspqKfFSoRnx2fLBBblFXZ7gGbhnPabuLeADaKZ?=
 =?us-ascii?Q?5rtWWxqG+rr+1O6ETQ6x4p/G0zSmjTowFwZaRFH0nO87NfOq9P3gH4tYThbf?=
 =?us-ascii?Q?/8yhIrw61nv9nvrnpprVAh3iB5pNL5/o5q4bOHkBYAeTFdkswqWkxBjEyI21?=
 =?us-ascii?Q?SDyP9CVYF7dXxDDSYqieai+zzlFzd8T5Tq48iqa3otCtkt9JwatYyhxFCj8q?=
 =?us-ascii?Q?1+rybMg31o2xP+oyE2OwGKFHQpNcMNbE4GJGiNsoJrIoytieAFoy6BiMw/IU?=
 =?us-ascii?Q?+CILXrxPw9HEKi6M/f43jOGBvSZa5ViwVmQgddus5F5ahhK1vNO+SRDtPylL?=
 =?us-ascii?Q?LGT9+sP4BfNC1hSo+np6nd8S+Y3ABkO+sMOOZVZz0byFNyABiTOuwBBhwFkI?=
 =?us-ascii?Q?nX5LiPv9s7KUWxatpKN7T0/XY7BdwbY08y20uhPQm0jXSh9POwiumW3TyZTI?=
 =?us-ascii?Q?4VioN/6k3zU013okE/JtoWr3Lcc3PmFP02iKne+sOVme/s4PQ8BHpesOQx/G?=
 =?us-ascii?Q?BNO3k3pK/wxV22cH1bm3Yk8M3h2/DKRxV98N63//U22U70XruXuYh7al7M/e?=
 =?us-ascii?Q?/qeudGdkAQYvhFwQ1piBD0OpD1qPpsV27Id8C5jFlQoz84iZDAKw2oPtYtPh?=
 =?us-ascii?Q?v560msuwfHRoO4Lb42C2gFfu/+BMVKPj4tI9n9yBVkPzsxUP9p4tl0N1uTxM?=
 =?us-ascii?Q?AZ4qXaYhUHr3TpBimbXQJJyX+tJuXQnm4TPA4baElnrco5yIVop/YlFadWgV?=
 =?us-ascii?Q?RX9HXOAJbwXBtZZkvP4ApgabINXA9LBdh9qCpnnTIoMmWHUrQXp7RMgPZv8z?=
 =?us-ascii?Q?Iff08otvnIVq4hLdVjGRtw5znqJD3GiZoRa5Qf2w6q+eKcyPwCmcD1MYxPWu?=
 =?us-ascii?Q?SWlNMvyWle+KzyvXxpLfAoe923ngFD6Tfi76FLt0TQCbyAl1nttfeQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7oP93RLrvIESnXMLNQDB7ckmVnkZ8Esj9tfdja0dgRRTxwh77DVO/MEwdwxm?=
 =?us-ascii?Q?mHFDQZWAUq7iIG0nGzl8tzfmp3m5rWeDuRGrS+gmYlu6g40PQIRYRDnXcWAx?=
 =?us-ascii?Q?6CfHUC09aqlT5KoeD3D4vBhjM2QWkCk5J2u+JnPzlPVKHxlQi684acEuqS8W?=
 =?us-ascii?Q?qgcYa5HL6D4MJspNQ0UwPYD/CZ19sL8ZQsmVUGP5JOOtT4upbN3vzMp4cgr4?=
 =?us-ascii?Q?wwXQ1Hx5hlKIJgPecpJyuHPpJeTtFi9PERt6lqk4ccDHf7fCJc+qhs8zPfMM?=
 =?us-ascii?Q?KvQiMGwdhrtAk21QpoESI6stT0F0TP9c2/KefzRtQ6MHoG0+y02QlKN97BBL?=
 =?us-ascii?Q?GDB4rMldgWpsobHeJiBdDBvkAS7qxSvC8byoEWFSciuPZHQ8T8dEAwBtl+bH?=
 =?us-ascii?Q?zHwoM7nSt7MlOawX4SMXY/Np+XAzxswq89NXlzu9T38niUHmidqXVNFG5kAr?=
 =?us-ascii?Q?l4zm3TPPPxAhp9dqO5FB2eWJo4UdfNGmNLwS3aiTZPNxf3o9WfOM3Apfj/93?=
 =?us-ascii?Q?H7e7Oxp9NCdWzZlKSv0OF5YnJ+8pIXpaQ/vJ9WsSNvuKH99x8o/aNVYqgoEs?=
 =?us-ascii?Q?gETyLpkfymM6bI7Hyr6Z9kDwednFpPjpMQLaiieAUSyV/PjR111wJlh7mDwR?=
 =?us-ascii?Q?Q0tpmNj010DWJvpKzk9Hc5Olh6GBFwIIsr8U3Qgvyc29IMmsvMihDztdAoBm?=
 =?us-ascii?Q?dFhLdzMj6ttg/rsuaQrsm3G1REY10QdEshMBkyVw7+MvQalLYBjijiQpBYIg?=
 =?us-ascii?Q?96NwH4nQmB50MNjzbc6u4dTWH5W7Bhyviw16dwn68/aTsO1SFHSRYDS6iP83?=
 =?us-ascii?Q?8bKtL4os064OBgAWKG4JPAbcA/ZHKljHpZGFp6+7CHnTY7x2LI1bc2sMiLkU?=
 =?us-ascii?Q?pajvb85IdtfAEWrL5J/Wa6zq08H2tQ4W21OYX49pU8H5sFGs6Tf4MCaBZRoz?=
 =?us-ascii?Q?tQYZgkYi12RPSK1zJ5cM2LPedQzN2o2mPBQyM+OKTXNa8hpQshCNfJdEbd5/?=
 =?us-ascii?Q?K7ojY9MjEdvZcD8doWS90I6I5Ds9pNnUi6hB/tHSoqzBsBW2KJyKRo7TNJay?=
 =?us-ascii?Q?9inYLbT5FCvtad72e1v9aOx9uFAdgxt4TrkxmGnkntqOEeLwIbdvXUMc73Ko?=
 =?us-ascii?Q?eYGYi6CFG8cVqJv6+pIo9avH4Vhmkqx+VelLFG05cRLZ/srQ03MbDgG7fG2K?=
 =?us-ascii?Q?5TUe+hBW7f/L//eEypcXmtWE9Sg45a/5PvzRCyrUC5wr6jfGwTxx1TdMAIDE?=
 =?us-ascii?Q?s/Qf7VgBkh374i4AaZwlUCu4RXXOAsElpne6EWB+roNVXWatsTT1RhUPiW/z?=
 =?us-ascii?Q?sKQXj6ai+ZVuOiBs79FsSEY61DcVMVtyhR/bMD63i02GW9BDucwgk5C9Nu6l?=
 =?us-ascii?Q?fONKFQCgGbLX4XpPStMMw4NuP4JR1wEVix5eYhXrE29bS4oTQGO7g9nosZqC?=
 =?us-ascii?Q?Z35Cb4kvrfo7mrBVbLt/FsAxDN0M3O8aemDCeALjpQAlH+VEIt6RMZz9khVo?=
 =?us-ascii?Q?3qoZGVT5LJiXnoPdBU5jndHDOLA3d8KE3z0f23dBIK4hPm0CJdFNmv7h9BQK?=
 =?us-ascii?Q?j4XsAUccoXJwNeaP5sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07442ef5-e9c9-465b-0371-08ddadb1e6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:16:14.8445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K31LOX9YU54VosCaS5USBNUHCTyV2FR4UtEN4cyJRzNOVb0M19Kul+3uCnyIod33Iq3BrY2Vq6GVNGyS+M1s4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jay Corn=
wall
Sent: Wednesday, June 11, 2025 10:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>
Subject: [PATCH] drm/amdkfd: Fix race in GWS queue scheduling

q->gws is not updated atomically with qpd->mapped_gws_queue. If a
runlist is created between pqm_set_gws and update_queue it will
contain a queue which uses GWS in a process with no GWS allocated.
This will result in a scheduler hang.

Use q->properties.is_gws which is changed while holding the DQM lock.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fa6489b6f5d..505036968a77 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -240,7 +240,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, =
uint32_t *buffer,

        packet->bitfields2.engine_sel =3D
                engine_sel__mes_map_queues__compute_vi;
-       packet->bitfields2.gws_control_queue =3D q->gws ? 1 : 0;
+       packet->bitfields2.gws_control_queue =3D q->properties.is_gws ? 1 :=
 0;
        packet->bitfields2.extended_engine_sel =3D
                extended_engine_sel__mes_map_queues__legacy_engine_sel;
        packet->bitfields2.queue_type =3D
--
2.34.1

