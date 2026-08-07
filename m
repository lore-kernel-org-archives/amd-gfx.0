Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B62C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 08:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1D510E3F0;
	Fri,  7 Aug 2026 08:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TazraN5Y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F2710E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 08:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w80UPVPPtUimax4s/pEV4C37BWgx//43vyrFjyRaWAcJPopb9p4B9gOxdPEn4UXeqmkdc5G8G7MQ12BxZd0nUfmbvpYSagoGo6u+/KU/rZDk6XXgotrm+ddN5Sf8Kq8tJw3ofbxo/s1YoUt05c3crjzmVKFgzhMEMdvnLGXDQxpNvS2bIspwA5pBiQ4+SufbSNCDdfxKhnMW7uUliihGMSuJjHw5cjgqS/Mji7s8pRhyOWj94LJdblE8u04GgdyLcH2qqdmBj0lGUTbIZTTIqZWzRlSVk/6D/ycVEb6ySjJdNHFeTodzhnizcc7NzKx7Bq4Iz3Vl76vr5KeDFo6ySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mzDejrId4PnyEup0NvAk6na4udtxUW+L6EMImynNus=;
 b=RX7BBEMRLUOoea6QDEpCWfdAF2ZLdeIbsx4yZTHQD2GgTQQHjK6RpcN3Bi+Pp//jDH0ONxP6j482+7sqDC1P31BjP9DSgv7FTReEbuwo27VgVaQMkEtYuVHKzyD0SdiFfdtBANY/iWXvT8IYQADwFfooJ7AmpZYVUd2GGLwd7NInvosFVkdd+90L23fKJzA0y4mokyeuN5pW1sXphqrg25AcBzd4FM7zi2Vv2vZ7JG8iQXO+ab9CmpSnPgJP/yBLoh+JugTPhmB4vdDGRQJkgk6FYBffsfWkp6LAvw0INWuWFaRloBMjtW8CWxoegF7f8MN+doHrafvKa4+is13NuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mzDejrId4PnyEup0NvAk6na4udtxUW+L6EMImynNus=;
 b=TazraN5YfYVxYof9MdJTYMwFhQBuKjg5cxGnMlogyKhQGqvVxKDjJrMrPkeKEuwg5CgKrjb1n7MHeRiuCWX5lJsF+E9CHa0p9jH8u0RDymfMhB0pugscMWawX5TGRTlvrxq1hRkajf763/BRPUB1v77BLTfftWPvq2SzsNc5vO0=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SA0PR12MB7001.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 08:30:08 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:30:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to
 cover single socket case
Thread-Topic: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to
 cover single socket case
Thread-Index: AQHdJjgbNhJWA7/JFkqGjnAIBj6kW7aSQHFwgAAA5mA=
Date: Fri, 7 Aug 2026 08:30:08 +0000
Message-ID: <EAYPR12MB99915874299212554445399803FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260807064330.3070081-1-tao.zhou1@amd.com>
 <EAYPR12MB999158E3E80368DECD21043639FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
In-Reply-To: <EAYPR12MB999158E3E80368DECD21043639FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T08:26:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SA0PR12MB7001:EE_
x-ms-office365-filtering-correlation-id: daac20a0-4c4d-4bb8-eaf6-08def45e1749
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: sbJiP+xlf52ZndzF6YNvG77hoV/WEV82O3uluAq6g3cMKLWto9J4GcQZ1iDndDsi7XH3Z60z0KzKWoNtecjD1wKkfoSY50A/D464SRsQFNRIXhizJrX5w0K1skWQQ2rW7uH8N41hxQK7wwnAYQfyeWcChBK+Kz4tjysJEVN1lj+h5tlaK+SJbXs1nM/t9DAvG9M54p5ePtVGa6KC7rnwfjlLTz8TLscP8Rc/2wprPUiUeEe8QWDpVhWzNEx/HovvGV/WELwpKNbpaYtBBSwXxg/45k77ldV+AmLSpiaXl5qX0re/L9K08qMzAs8Vb7mc58NXc5w9FcxcoXvn+rV1YURqQc0z9RGxipkAuBimgVN0MDOnOMUmszp/Ae9nRMprYs5bQUpuUjoVEgXW3zVdz4e7TELFSs6z5E/tTpKrUsfBaDKCsdKrD2l0yBRhJ5aKrP8nqAqeaIkGTJegJ3spPkW3TTYReUMr9wcRu5bR/6NoABRaxGlDyP4jMvtXoTtGCkhXqAb82y5k6ZNYFChDkxZ85uktjw3IKseg0jVG7Z/p7eag/ticvTr9tIR1P3v/nbXgbbHJlJjy3jUdn8PBfPB1HsRwdEBRBgKuzgM6cFYm1elDuW5uyCZc2C1gLcv0I2WUwayKkC0qMoXy1G4Ze+HuS92SlXtIU+CJg8ByPsBS629BGSpfH4eg7t5nm3Fvdrt83IvqassjnRDGkw34jhwxGzt5h17d5+/4cjWOIF8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hyhfVpJZWvAgmNC5VEiF8tuSqRk+MgX8sADq1tTBrYpGeyOfidAnwcjxZcDH?=
 =?us-ascii?Q?XuQ80nLsk9OQYYwdd1UhLiiwRBdtXriFujhdHY8t4tSr7HlrwSWzr7/N/mwE?=
 =?us-ascii?Q?3fX94UiBBvrf+uGPnpixP2f6ZhP6zF0edIhY6DPhyItCKKQ/qriSKBcC8+Rq?=
 =?us-ascii?Q?CqKWbM5HA9Xts1X6BcMus/GVm1zJO2oa/wnMbmPqbLkA5URbp1gLDD/YjOz4?=
 =?us-ascii?Q?HrAmakouT4azqGbJeR8YCx3+Dq27YoZEtB1LWgjsG8avYIvhYcVR0Z8VV+kq?=
 =?us-ascii?Q?PqtYsRjmWrwgAhTmguoiX4fihRK9gKRhEYymX0UzS0/oLdeKMRAQLioPiPro?=
 =?us-ascii?Q?qg/dJTXNhynwml/eTOVJQ7y1Gk5pUGbNkK35mAkNjoeNR7fTLOVaqPkD/vKh?=
 =?us-ascii?Q?5EWU3Zv7mMKIKr9FC6XnPZG4DJd91vk7JUf9NtZ2EU3AWCMMyvMNySDeCm/f?=
 =?us-ascii?Q?ZRLLPKox6Bf+QR/b1EuwlsKcZJWSxTdueSAJFlXDI/Rx8IHv11EesaHTNGQL?=
 =?us-ascii?Q?SUknfdqYu7TPYlvYYMOqc9oKsRQwkO5A7SFcui8ROFXZmWWB2lAwMvF8j7ql?=
 =?us-ascii?Q?fE4sEUKcKc8vOe0pMbPj4KmEJm1PDOiGwHpTodea3ccFbPBoBoMOe7eBnVPh?=
 =?us-ascii?Q?if/VyvZoYlXa66eFba6yBe8bWKWnbj1GXy+KeK5W9M4NoS3aZs2tYnDHUa8r?=
 =?us-ascii?Q?kQqsaQKPfBVEfh8iZOR29ZEex/P8E0hXQVBA1LZLE8ruAMknJcKw1wSPhfaH?=
 =?us-ascii?Q?yYHL6V6HQH0TK+a1WIUylvew9s6arKry8xKkE57hUJEqx6VPaBAcKW7L20Fv?=
 =?us-ascii?Q?J1LV77Y2ezlm1K6k8gJeTjL34RzLxb6DM7UiVdwgPOi6g/1Exf7WhtxKeDZF?=
 =?us-ascii?Q?L78oklVUF8rGjLT3QhOPNSMRCUTBKnLoMOxcqN+2qCHk9vRLFyWuA5wZIujY?=
 =?us-ascii?Q?jdVWdEz31F01rH3OEbIUl7Bgti7DYQ1EkO1oBpXiso3NVXYKpJISJzc++149?=
 =?us-ascii?Q?fo9vUtXvyuoEd1jXBX/7cxQYVFvv8cgaX3EQsCtfLmjQZ3A12VxpsuY8Jx2M?=
 =?us-ascii?Q?RVcO7JIC8mub1uPEsqY435+vJQr5hbkwNAfo2TwCvNocQ2diWT5/QcOStfyb?=
 =?us-ascii?Q?LDTjGfiEE116iyi6RCbkTVuClmINGNtZf92rMutqT1RZroC/8bD/7MXN2BR/?=
 =?us-ascii?Q?mA+rgj0JJJ19/zlhoFCVbyfC793ecInMBoBPUnMg56WqpQvMst5D4KTZ1ksd?=
 =?us-ascii?Q?EhNTyUJ/ZSull4iHFlG7odXBm5zNz04iDHZ3FTueAFweyq7VFmf/vIfjLLv1?=
 =?us-ascii?Q?/G9DVbj202IRTzErEvEwNs24fmJ4tTYN6Xz/5LXL+TdGf+S8xOt2J7o9sPBv?=
 =?us-ascii?Q?hPE/sWYsFR813USUsMu/bFMSeFPcard8TMwE4w8AabPIzZQFd6cYZsIFvMY0?=
 =?us-ascii?Q?MAq+OWayD/5HSdla2YCVnQvifgwHp1l5MIfvMQQZ5fR9EPR1kz7eg8PxAqvm?=
 =?us-ascii?Q?bCBjCrwaeGlEAo87DF/0X8ttkX5hcnSz99SAtJIIUXs9kCZjWWRg5IUpHpNs?=
 =?us-ascii?Q?SiZuawWAoxy08kTSe26gCcM7j0tkHT32Rsap9spSOu6/DFx/KZ+JvO7K1UiG?=
 =?us-ascii?Q?RWspOSMR+OXEdqnFQxVXQlyeBgA5dSCjh9PdSMxpHp+roz8IXo6gihRA5NFq?=
 =?us-ascii?Q?aAWaLGOlHqEwzQwD4DWvtu/6Bs7JEqWXjyQneqjg9uGzDKFx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daac20a0-4c4d-4bb8-eaf6-08def45e1749
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:30:08.7774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXtTV94IQKZpHMnzaRUK/l62j794O3NFJzNGaaLogJsDS+ImV5E/u1bA90nFai+1K+J8DfBhAt9bXpCtxmEiVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

AMD General

To be accurate, I meant multiple-GPU platforms.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Friday, August 7, 2026 4:29 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to c=
over single socket case

AMD General

Shouldn't amdgpu_xgmi_get_relative_phy_addr only be invoked on multi-socket=
 platforms?

I'm trying to understand why this function is needed even on single-socket =
platforms.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, August 7, 2026 2:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to cover=
 single socket case

For single socket, the xgmi offset for memory address is 0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index c180c35e3622..9df32785f365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1249,7 +1249,11 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct am=
dgpu_device *adev,
                                           uint64_t addr)  {
        struct amdgpu_xgmi *xgmi =3D &adev->gmc.xgmi;
-       return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
+
+       if (xgmi->num_physical_nodes > 1)
+               return (addr + xgmi->physical_node_id * xgmi->node_segment_=
size);
+       else
+               return addr;
 }

 static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_stat=
us_reg)
--
2.34.1

