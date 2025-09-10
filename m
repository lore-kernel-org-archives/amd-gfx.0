Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA770CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 19:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AD410E9D5;
	Wed, 10 Sep 2025 19:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5HYIBxX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699D610E9D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5QrDW3rOlc+x9tXzn8rL8iLiVgE4zwoclJWqt/+I6xgnwGk4YBzieM3tZORPXpi27CVVcXBaQOexk8utI12L/b4HuuGsasxwdvozsPFpFUJhhlEtY8VeMrAwwNCTb2JdKDp1+BVJZgWGDlLjbL6jTccM6XuvCkItIPvKvJdCtCZ7ewLKmcPgaBcLr1+UH6NodWWdYSANbMLut/fA0lvfv/MYPW/eKK8pTVgA13Opz5NesnX9NjwYJSebMiNjxAgOxsW7pC6NTWTZsOkrbDliNKyIjQelPlBPBVAirqF3qR9LO/ImDo34TQEsDgiqBH0DnleNdmTXEjal39uEf7rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ+op79PZDC9QRONwqDdsMIdif2JTUnzYF87NmSXjbU=;
 b=D+oyN8mmi1ruVmi0huLgZHJ5gks9dEsHldtSTSucK5su/UuDd+d/2nJpJ7Q/u5dlrzCONaLPqA8zeA3fd0La+0R4Bc93vFGDDfWPNGEG7ZKzwqFT0zY4vgf73zXBNocK9qLm8O+sswxwP8lcgCsIGsR/NLmIGbsjV6l40Y8kBE6iMlUgu5Td7YSWBIIuuTFGdQPVjcOp0KoVOQbcJBIsD0J8Jh9dzSZzFn/m4GU24oAtaFreaqs0B1Huj6U9kBC7W9CjhRtU1qSVzPPlE/SRaBykkgxhDWfKYvq7Pl08fyO1oIYmR88bi7qrVG77l+1TryjdgOsk/7UX13XTP8lk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ+op79PZDC9QRONwqDdsMIdif2JTUnzYF87NmSXjbU=;
 b=E5HYIBxXa3RP+dZIECSAzrNIwQVoe+81Akoo9wVfSUyOYvwiCrWPXnY1sV/Km5Xe8dPaGvRmb+YLHX8QWpaX6OMKQs2Y2J2XJc31eDsHzvjyzv+/8QrFOgTPuBdbeupCf7CwUcaNuiiEYDhj8/yfLevBbriDHY4dUXzc1lWzaEY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:49:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:49:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Add virtual device capabilities
Thread-Topic: [PATCH 2/3] drm/amdgpu: Add virtual device capabilities
Thread-Index: AQHcHh+kCVvW7WXJ+UKuvdL8YZvNHrSM25+Q
Date: Wed, 10 Sep 2025 19:49:15 +0000
Message-ID: <BN9PR12MB5257E887F2D1474CC38E3694FC0EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250905044301.1947978-1-asad.kamal@amd.com>
 <20250905044301.1947978-2-asad.kamal@amd.com>
In-Reply-To: <20250905044301.1947978-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-10T19:48:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5653:EE_
x-ms-office365-filtering-correlation-id: 55c0a695-26f6-4e22-14a9-08ddf0a31f67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8v0ZWbtHnJ4kI+XvogV4083YTy3PLJcZuQCdGdG62B8XuZDSLnzcozaVspkD?=
 =?us-ascii?Q?+i1/rDSE5+f/+sgaffi2xDTS0ojdTd8ED1RaPtVdWkbt+FrHGLMbVcN++sVZ?=
 =?us-ascii?Q?7YQsTJ247dWls9Y/VivHWCgiBrzMfJPhjlGPDqHtNFX8f2Fin2UArLs+Ao0i?=
 =?us-ascii?Q?7AoMOeU09ck3L/MPV5hG8/yJ4KihQ3agDuXfQJOv7yNuv8+eKiZIWmBoxX9x?=
 =?us-ascii?Q?Cc9po2Gbbs86prAx/LFjRAXqHiU8UeE9tGE6Jbq45cC9QwP7FYO+A3NWfTBd?=
 =?us-ascii?Q?nTN6gSIs4j0XSXqIv4LjLUPsPqjsuVm/LqHoOcGqxCESMv3n9ni0O+G6xzf+?=
 =?us-ascii?Q?d/wBujXCEMVJZZYejHBtVN6JOXyfmBaeQOYpUQotjKYm1yY5Rq+1VqeyCL9Z?=
 =?us-ascii?Q?WNrDMQlcdkis/bamNmLBfyg23fohWolhOUMVYONgm6PzUQczznsGJsbRUPeC?=
 =?us-ascii?Q?ZtlreAhiJ1VpvNJZGba4tlQwppNh6335nPTZ5P5Xv2DWx+ClqmEwCPDLGN7f?=
 =?us-ascii?Q?CxMBQt3y4urFTRG9Qw5olwGJVgprTUrassa2EJR7RpPKFar7CiiIP80N1pyN?=
 =?us-ascii?Q?hp+fBV6HQ6WqYJ1uIdscpe/Bfq8JNBR3G6FK8dj+Tu2BBNLEV/y3GUtU/SFF?=
 =?us-ascii?Q?m4+FRi2zawVCJ+BfGwG9lFIsxUKw5n04cFTji3n2MaLrHKJYa40NnJ6U45V7?=
 =?us-ascii?Q?VRsngyIq5cvMuCIid/JlurBCJJZkcGzuRoxfka8XK/O7xLtt3Ps0BFXPn2o4?=
 =?us-ascii?Q?L+KQGU1IcoJTS1Tjwx1VJIUEEx8Olz69KqGJlu1XisI/ieEfYJggGhZz31N6?=
 =?us-ascii?Q?AuBU7HxSLYQGRL1XG40k4dHCglXs77uBpkGCZJ2syDnysH+ZFXAaeuCj8ddh?=
 =?us-ascii?Q?GWGbnRyBlXkUf/oxCQF2d5aHJGIRWmjXdCWLOIet9t77meUaX6io43mo3pcO?=
 =?us-ascii?Q?z0nledJYBNEch5lLh93COr8Y4KmSGPYJ4Bf9CguMze3acF5mwax2BlIPj1+Y?=
 =?us-ascii?Q?V2mlfEzsCgz9xqeMLfXc8fM+y8hVDsxUWh4MKEM8vJC6xK8HxzxKDlGIIlTW?=
 =?us-ascii?Q?P5MT5KWHNiXy03emgpUAl0trrcxrjP59otwA4W/oaPZCNlhLJLNloh3Q8fCA?=
 =?us-ascii?Q?iaqd9Psl0tyLph/t49UChEyUCj9HpVkTm246RPuwn/PVrHbT/iXFz3GABP7i?=
 =?us-ascii?Q?rf80aNic29sqa+Y9FWTaPaKtcKIAkbE7cz36vernACAbVGPUFshOKZMl7+Ed?=
 =?us-ascii?Q?0ZfJ0EkyZhbufLxzU+FR3vtAANYpcFzlrRp4krWdZRSIVjVSJV2I0Q6wrGTl?=
 =?us-ascii?Q?WoCERDyi1NYxC/EtGjRxnpfsq6CKMg2P62ugV3MVL34oQnnFzBVt0gOGVTat?=
 =?us-ascii?Q?rIrCCVf2z69n39pzASpaAy5RgcrKB6cy2nVUgwPfmI72Y9IL6xUcPmblz7jB?=
 =?us-ascii?Q?LC2Um1tgc0FiEvPvj3bdehYe7C6NFs4H1TeroGGhw85VIoHoePjavA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8cunKWnhHCtnE4+n/ubi/kDe0F24YgXXNUKI5HxAPPj+3OvFeEugPk+S4pWp?=
 =?us-ascii?Q?TcVC0/NHmkI30icXeA17y8JRLughY17Fk3+W3DukEKyVrGopJMryKhr8ryt+?=
 =?us-ascii?Q?WMv4o6NDT/51AngI4hU9UGdflmDaj0ZqGKrgYIkyturrBSBtH7SuTzJkmrvq?=
 =?us-ascii?Q?6OpRvN1m0VWuiiGLPpqWjpqBJjZyB7ZlQGeeKXZHCbnIF+tQGdEaAYdnqu10?=
 =?us-ascii?Q?Rpgbe0yd4zf7hNC7aKjOKZtNP4j47w8boNO0LYsijVW2HJiNVBmzk0RFU46a?=
 =?us-ascii?Q?UCxwGKgsuK5IpYnAlbwIdzf0gUtFhfE7kMVJb+fizxfKLdBJ0VioB5Hp0MEF?=
 =?us-ascii?Q?xHmcvsOYsZnqpzGnUfOBVHsSu3qrGfPPYGPcpKXbwSMrb3uiqYEMWjQ2kq1x?=
 =?us-ascii?Q?z40ewg9DEb0etHS0WlR1VkNJtNllIPEogD0dtnewKuxriQR9CDS6BBQDNBvE?=
 =?us-ascii?Q?XZM8/7ILiiW4zPw2cFNNL3sG2wqiA/2PuRzqIu5xdq6MHm+PzlWQ7zkN+5Za?=
 =?us-ascii?Q?cxRe3M62DaeUqjKcfD/ZGmeJIETn8MRoB0HcTWyBK3w8n/W8+XweToP5RxxE?=
 =?us-ascii?Q?NcoNSEdvId9bgEcC77hYWCyEOefmAJpbJ8Dbp26U27Q5bmr79B/RNnK4+crN?=
 =?us-ascii?Q?X0SNNUGjs2L/icuzNn6gVs6zi7G8Xnu04UxDbavoj0isyE/vS9SJki+TXNKw?=
 =?us-ascii?Q?I2tuqYpxrM/nw2Z5apg8QdRC1Wg3LD0BEieeo6X6rfVQJoxpB4K81lBUFKfd?=
 =?us-ascii?Q?wQmAlzAdivHN3QOEB6JnofR7Ajpi/rIB0/xU4f8Nbgo612luR4/Jp+qaAuT9?=
 =?us-ascii?Q?dgl4bVJYEkNu7ifLu1YBGxsBXXIPvxKdxYVHkQ0o39W2A3Ze5jvgsn2Qw9Up?=
 =?us-ascii?Q?Y9GJ/An9rY4ppKa0tbXWPUhfqcMiAwquBAGFui9/6ykifaNESmNXKpXjvbU5?=
 =?us-ascii?Q?Jn7SDAWvV/U49okyv5l7uCOHMX47qhxLa3bhl1vWoHuOiDGDTDsQ1AUlgvwh?=
 =?us-ascii?Q?LX1vra8dO4awQdyPdLyB0CStgY7wVIu8ileSrB3/VA8Vg3s7hXYoE3WInKt3?=
 =?us-ascii?Q?2ds2cVwfIdYRlNN4PFSbkv1Yy52ZwHgDj0l5lUPaDR9agN/s7b0QHERy4jTg?=
 =?us-ascii?Q?jVM1TKlCD8JHb1Xd88/i0t3XXrgAXP+F36h2YiqXQGu0T6oeVjuqnn9VDoTd?=
 =?us-ascii?Q?g7CyAPhTeHLiS1lygC7NO5lWBm8G3p6/y7MqaLWpbxmCqMDslUIbu64GigCJ?=
 =?us-ascii?Q?2Kkl0Wn4kj5mRNXPOyRpo7Y/44646ne+5m3md0VCrlMq7GL37pSvhTb2/gwZ?=
 =?us-ascii?Q?1/GFFBhmao9oiqBxvu165FbXJwWs70HoqIuxulZKz2L3iqr27WHCl7KTTAht?=
 =?us-ascii?Q?U9Wtsm6skVjTUfd5ciP8i0I1PgBxqZARDm/fDmgG0NsNXb9bscEnxH/bRomY?=
 =?us-ascii?Q?W9P8Hatqx/j0IDDKKu93qjjGTrTp/2oKa1WfzAp1lmJ0R5roB9MrXFexx0Zp?=
 =?us-ascii?Q?fuIInzdxVNI0U0R2CDIiCOj91guc6NZvAea4Wc8fKY9YYEz4fcXy4RJsVRAl?=
 =?us-ascii?Q?VoAYrlmurY07JcOXaq0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c0a695-26f6-4e22-14a9-08ddf0a31f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 19:49:15.3545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQ1utfPdctimUzIntfQ30DlqXDuaMoEFQemZVBGwwc89y4REAvrupteHryl6KocaJDux8j6eOawp50FpPrbxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, September 5, 2025 00:43
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add virtual device capabilities

From: Lijo Lazar <lijo.lazar@amd.com>

Add a member to define the capabilities of virtual device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 58accf2259b3..3afbdf7b487a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -256,6 +256,10 @@ struct amdgpu_virt_ras {
        uint64_t cper_rptr;
 };

+#define AMDGPU_VIRT_CAPS_LIST(X) X(AMDGPU_VIRT_CAP_POWER_LIMIT)
+
+DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
+
 /* GPU virtualization */
 struct amdgpu_virt {
        uint32_t                        caps;
@@ -274,6 +278,7 @@ struct amdgpu_virt {
        const struct amdgpu_virt_ops    *ops;
        struct amdgpu_vf_error_buffer   vf_errors;
        struct amdgpu_virt_fw_reserve   fw_reserve;
+       struct amdgpu_virt_caps virt_caps;
        uint32_t gim_feature;
        uint32_t reg_access_mode;
        int req_init_data_ver;
--
2.46.0

