Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E00BE6C60C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 06:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C224210E903;
	Tue,  3 Dec 2024 06:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RefjbliE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278C310E903
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 06:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvmtrhDG7VWe48hg/t/ib/k6QwVbuJu5oDFQJiH49hDaE8/5fUZwOXilMnLAKaWyRAX4iig4qj8Y8anIYCZQpyPQZgFyZJuZmKDX19BWzfDy+pmNSVZAPDZmpglvYBuaqPKnhxSHyxn2r+bLAtklwK11Fd8sNCg74NyvJ5gfuSCyptg8qX3xeHS4uBX1Fqhu26X4z/HUgLPtx6R1uL2t+5ceCNmbNuSy3lNnLFbV/HEwzgOeZKs0DyZfYpYlRRXBB+Bg7rDOX2K+vRuBmr3A254ESvGjgODlb0LsaoxZjHjJvpNAqiWLqj0vTCVkR67zv+omTFe22mlUskRW50sWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdlJ5zGMHhuDb0weQho7c8l7QTzXF+lCCzzn0lQdGOs=;
 b=u+IQsu7rQvWOyhKbb4YTgetPF0spIlxMF91jMYWl2n5XDIj2NqUsg9baY6q4uVYg5JvJuvdNLDPZMeyJLK5ZrmIEKTK9qvopaikGGU3EhJfqhRIosOBbhUOf/aLDO4GzdxzmxzS8tnVj/+MpXKp7tLU/TB+qlGSAe+2mxxaFGFtr2xcrPERlXiZHkFIsucmaMc2WaChyDWmd1ijjdXAOgnrXgvvz8SxL6FxOeGGfmL30r+bM6GaQ7UbrRJE5WxfzFREskjRYxpn2NRcfv6dDpuK57GkExSjKtC6/2DELjvPgyEor3G7WLg07Oer5WVyxQr+TuMUoW5iGzwyXaIVZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdlJ5zGMHhuDb0weQho7c8l7QTzXF+lCCzzn0lQdGOs=;
 b=RefjbliESy4Yn0DiOY7zbsZSn/spLvuN+bX/vxxy1YP0ECkX4Nmz+sWd7hu3SVTAKyTlsxU7/mDdjbjXl8IYN4ooeEuF/jKPBnezDkIrbYGgUdA5t5aJd9iSiClDnNXWAraqDJOjbqIsF/nDx+Up9BKfPDgYQdCn/qXlII+W9zE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 06:29:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 06:29:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: correct the calculation of RAS bad page
Thread-Topic: [PATCH 2/2] drm/amdgpu: correct the calculation of RAS bad page
Thread-Index: AQHbRKRx88Pfr0emDUi+Vi4dG32dQLLUDzmg
Date: Tue, 3 Dec 2024 06:29:36 +0000
Message-ID: <BN9PR12MB5257DF46EB0694904033CAD2FC362@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241202102433.117496-1-tao.zhou1@amd.com>
 <20241202102433.117496-2-tao.zhou1@amd.com>
In-Reply-To: <20241202102433.117496-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ff41664a-c54e-45c3-816c-e9a877b0da73;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-03T06:26:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9419:EE_
x-ms-office365-filtering-correlation-id: ecb1b5f6-3703-43c4-7084-08dd1363dbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IyOOwrsasViZYsc77atpbLU1xWrTFrRSMQHI1ffbwWaX8nFqhIV6cJ1UR4Az?=
 =?us-ascii?Q?i+AfmfgWpDwIvbI6pM/5gGM5HdFKFiqQkIYbiI1a5ag3Q4k/Ee1DYUCl1fRK?=
 =?us-ascii?Q?vBZHXEEO8p0bcxwN9EALfwDRZ3Vwxpxi3EQW9VeuinwLM8Omcuq1w22FuOh8?=
 =?us-ascii?Q?NEyepxesGi7Dcw2OvWbmf3hlHS6I5Pbd65lis4rVgmv+JEW7UNtVIDmqGClS?=
 =?us-ascii?Q?joDEKKSFxpnfqqxo+JOTh6aaJEsYaD7bySP77QVAvuWXL1tvNBc85vFFw2b3?=
 =?us-ascii?Q?ZIAWYZOXmsdazOUuYg/l493xr3t24SjFhhbeWA4iHjqRTE0LI/mwnnP08g7T?=
 =?us-ascii?Q?jbIM81pY+R4UHYXthjB4r4JxopFKqwxcpnS2NUijtJjc61QFIMRh+TZt4V9+?=
 =?us-ascii?Q?l302ohHmS2gV30Yw3zw9WrB6W2F8N6vUM0IXKfnQ9ZpMpv3WtOR/+ehfGn2e?=
 =?us-ascii?Q?rEX3zBLjyHC8Dd5LVrLQurxhS4ULeEDSHpu+XIB9ZHx6q2TAvb/WwhZBPfJJ?=
 =?us-ascii?Q?7Le+Rqh7rUkoXI+Swikub89CeYYlM3oVZjFI6rB0Pbxre7I8P0eAak02Ad4E?=
 =?us-ascii?Q?qlGA6YOVlSX+ZpxJFA1KNodY3d2oKDZQSxfEpd/W7tUVEDWAOGVFRzD873iY?=
 =?us-ascii?Q?1bfiRmzJcErWdqu9Cu8kqk23E2o99Chd6OBg05ozbOstjHxqH3FMtRzXz87r?=
 =?us-ascii?Q?RKrjkoZC3M8PeZYmh8M/H0RPwOGMauXmXT9oFBJeu/Y/a5ehfozE58pQhPul?=
 =?us-ascii?Q?9ArOHTWizncbTNzxaeMkw56tKhqfC5VEW+WkwDezWuFdEBfV6T4sMcqX7OwQ?=
 =?us-ascii?Q?CCUu1hbt/amBmhdiBuZr6w2XMkKEtV3PcESbVYu6kX1ffq10+D+UrAmF1c5z?=
 =?us-ascii?Q?JVKZrs3g8B3Bzrw0yN5W+BZJHXaWed+l9obM5I7TNkOC6lPhzx/fr2L7vp8n?=
 =?us-ascii?Q?C6gV2n8XtHi6nTZB5ZgVRlg22sEVv10ADYtlsykgOphkWadlDGz/mbih040X?=
 =?us-ascii?Q?i6KYkzVev+8QhEp5m2y34Yk9Njq4rfunH/crfG/hxpibxQXSTBrVhYh7YgwR?=
 =?us-ascii?Q?KzV1pYFUkZ8xFOMs1pERs6y4H+6ZnUQKWxEdzMsrU7SGKrQlf0k1W5Ysz2SR?=
 =?us-ascii?Q?gqR29r7a9uKbOQUAvWrCA9HJ+/KW5NC4cUZu0vdMJe8rn1FIdbRu48W0meQi?=
 =?us-ascii?Q?24+ZdyEej4ujAwa4idWJ+SkmZ/3aoVuKnpLXkhSylZuXtmNnjkA1q9ZlFglb?=
 =?us-ascii?Q?JFoo5JI+GZTtm4uRfOpFotZGV3EE0LiBZuvzWR5wBFcAHNj10GUpntxYUxP/?=
 =?us-ascii?Q?i2zrIrLlSga+IWkQ/pCGfLXiqcopM4dlsGlLAd7JFoll84rXGLHiPbIyQl3H?=
 =?us-ascii?Q?uYfzxa+7KBM+C6fOuhItIE9gka2v3lD8ClQON21bP6w3V8vQiQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xDsN9SYBMDCaeK1K1F0PNjdGpg29e1WMmSuVKPYx4WKWXmAPZxWhwF2LU7J0?=
 =?us-ascii?Q?Td1lKCR9umMZ1LpzDU+z08hGX9UnWNVu9DwL8LRgG03woUd48I/IBZiQ+QNx?=
 =?us-ascii?Q?QBkChjFS460yCwtOpNHl5PzY2WFz1Gs/73vWr33NJrdOEJB/jDdTkBoekgHE?=
 =?us-ascii?Q?xfV5iCYlLYxcPdW03VHbZoTI+tFCe6+6pJxbssieyju7hXg0F2pVHd3zWap5?=
 =?us-ascii?Q?z4qtYuw0P4M9W+yttjF4YrsHSldfX5yZqmxMa0/sje2L33zQmfPeJVPan5hO?=
 =?us-ascii?Q?uyRsVn9UXfuiyuUKy5k+i3xJnxWIsxIGyRHr7Tbjka0gch8uz6l8HFTyGI2t?=
 =?us-ascii?Q?gDYqiQEbsZv7BAuA785bV9a+0CLyRClBl1z1chi9rZP025J9ZYSkGStVRZBW?=
 =?us-ascii?Q?KD9lAVplG9D74QpfYXDoog7tdwkvtW/uhMkDuF3GFYSbapy2UcoFECQFM8Ww?=
 =?us-ascii?Q?dgwSW9E5RGuuiCV7Z7EB6o//3ZWcvBAw4iTs/Ig+Oy32AYvxm0j875zx28sF?=
 =?us-ascii?Q?sJMu4AWDCS1CtQR6e3Fq672a0F/vKxWC1azqLhs8Ialb3NzqqJsNhTZq96U5?=
 =?us-ascii?Q?tMXQtzcZybRMoTsgIRXhuE7ne5FtmuYkURqcc02ab+0ESvgAvOLq7AkdKn1L?=
 =?us-ascii?Q?Zi/yXr13gG5jQvtZk7q1WXyWJkfaxmF0WKG6f8Tk/Kqj+T6oXH06Zf/DbDU7?=
 =?us-ascii?Q?iZA8IaMi3zSr/jCmNGJ6brZ9k9WMiBI25xlLEBZoWo4A+2BPjsTwCjXvywxh?=
 =?us-ascii?Q?B22T+o4PaCuJxiGfu2rC7Of3ynWbSodYEIrYnfUSIIIBqk/FGMN6ZLidtTep?=
 =?us-ascii?Q?O4eJGkGRUBb2+qQmRPCjap2yn1nZqsTY/PXS9BKJqNeYCaj/VqpDeChQjxwh?=
 =?us-ascii?Q?m/6ntoQe1/EjfcCL8aoDpOSWDVZHgSeNDl9Eds1y2Rmn2TjkoF3RF+vbQcC5?=
 =?us-ascii?Q?ovwFCab1LevZA/WK6ohOZkZ5MU/7Eh1LuaHNimQTDMuYIp0H2kmXqc9IFEYz?=
 =?us-ascii?Q?Ki5UGZaZ8z2x2txKntz0JNPL0viOfHTreasZQEaouy0V3LrjlX+k/FAnpTj2?=
 =?us-ascii?Q?Jrzxn+5NFgUxOKIDO2yMgBzsZUaZzVbeIY1rQQjS/yvDEKqpfr7FRQSBUIuP?=
 =?us-ascii?Q?TCHfe0Z5d9qRBysDGuEi19/Z7ocU0daPgGKu9SwkDcJipUv4bnqnB6l1QHcp?=
 =?us-ascii?Q?6W5ARyEOWorXKfp8ALc2DOkC3dscTc/0eMiwoonu/RGyjjx/8o/YU94TXSJC?=
 =?us-ascii?Q?igSH4CIH6wi0B5w16iuHrm7OOJwJno+fXF7ALe9JHMWbFcROGA9XThddswHa?=
 =?us-ascii?Q?MM4FEOUiJdroyzEFqPC1D4OqAKdFcqtaq7/KLjorJDnvw9pJKJFQEUczzf+2?=
 =?us-ascii?Q?6sRZWejAzhFVIpCCK6rQwy7mFDaV5PelqxRb3AhQgUBHkv/wZNlWyxVpmU8w?=
 =?us-ascii?Q?78JLvb3C5fd+1/dzr/hbPOmVPmCCoFvcqqOe2xQR4GWbUM5+TsYAZvHKRJJ7?=
 =?us-ascii?Q?Q8W7CLe7Cdpi5hkh5J6niXjCzIgztEfg6KARsJrytr/zK05nFs5Q0QhyQXyA?=
 =?us-ascii?Q?CZxkVpPMXNW1GSbpAyHyu8zECG0W4t6XncOe+d2F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb1b5f6-3703-43c4-7084-08dd1363dbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 06:29:36.7543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZprAdtDGsSl0W02QO6iEsP8KqtBc/CMYsSCrV2jiV5kdhJG1fh3UhP/4XXuPVFyEBE5tjioM9rJJviSHoJBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, December 2, 2024 18:25
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: correct the calculation of RAS bad page

After the introduction of NPS RAS, one bad page record on eeprom may be rel=
ated to 1 or 16 bad pages, so the bad page record and bad page are two diff=
erent concepts, define a new variable to store bad page number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 +----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 40 +++++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 +-
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index da072ab3fb5c..d03e4ae708dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2934,13 +2934,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *=
adev,
        mutex_lock(&con->recovery_lock);
        control =3D &con->eeprom_control;
        data =3D con->eh_data;
-       bad_page_num =3D control->ras_num_recs;
-       /* one record on eeprom stands for all pages in one memory row
-        * in this mode
-        */
-       if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_MCA)
-               bad_page_num =3D control->ras_num_recs * adev->umc.retire_u=
nit;
-
+       bad_page_num =3D control->ras_num_bad_pages;
        save_count =3D data->count - bad_page_num;
        mutex_unlock(&con->recovery_lock);

@@ -3432,7 +3426,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device=
 *adev)
                        return ret;

                amdgpu_dpm_send_hbm_bad_pages_num(
-                       adev, control->ras_num_recs);
+                       adev, control->ras_num_bad_pages);

                if (con->update_channel_flag =3D=3D true) {
                        amdgpu_dpm_send_hbm_bad_channel_flag(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9dae4ac2f5d0..0b15f0370b67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -470,9 +470,10 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_ee=
prom_control *control)
                res =3D __write_table_ras_info(control);

        control->ras_num_recs =3D 0;
+       control->ras_num_bad_pages =3D 0;
        control->ras_fri =3D 0;

-       amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_recs);
+       amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_bad_pages)=
;

        control->bad_channel_bitmap =3D 0;
        amdgpu_dpm_send_hbm_bad_channel_flag(adev, control->bad_channel_bit=
map); @@ -559,7 +560,7 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct=
 amdgpu_device *adev)
        if (con->eeprom_control.tbl_hdr.header =3D=3D RAS_TABLE_HDR_BAD) {
                if (amdgpu_bad_page_threshold =3D=3D -1) {
                        dev_warn(adev->dev, "RAS records:%d exceed threshol=
d:%d",
-                               con->eeprom_control.ras_num_recs, con->bad_=
page_cnt_threshold);
+                               con->eeprom_control.ras_num_bad_pages,
+con->bad_page_cnt_threshold);
                        dev_warn(adev->dev,
                                "But GPU can be operated due to bad_page_th=
reshold =3D -1.\n");
                        return false;
@@ -621,6 +622,7 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom=
_control *control,
                               const u32 num)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(to_amdgpu_device(=
control));
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
        u32 a, b, i;
        u8 *buf, *pp;
        int res;
@@ -723,6 +725,12 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eepro=
m_control *control,
        control->ras_num_recs =3D 1 + (control->ras_max_record_count + b
                                     - control->ras_fri)
                % control->ras_max_record_count;
+
+       if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA)
+               control->ras_num_bad_pages =3D control->ras_num_recs;
+       else
+               control->ras_num_bad_pages =3D
+                       control->ras_num_recs * adev->umc.retire_unit;
 Out:
        kfree(buf);
        return res;
@@ -740,10 +748,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)
        /* Modify the header if it exceeds.
         */
        if (amdgpu_bad_page_threshold !=3D 0 &&
-           control->ras_num_recs >=3D ras->bad_page_cnt_threshold) {
+           control->ras_num_bad_pages >=3D ras->bad_page_cnt_threshold) {
                dev_warn(adev->dev,
                        "Saved bad pages %d reaches threshold value %d\n",
-                       control->ras_num_recs, ras->bad_page_cnt_threshold)=
;
+                       control->ras_num_bad_pages, ras->bad_page_cnt_thres=
hold);
                control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
                if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
                        control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD; @@ -798,9 +806,9 @@ amdgpu_ras_eeprom_update_header(struct a=
mdgpu_ras_eeprom_control *control)
         */
        if (amdgpu_bad_page_threshold !=3D 0 &&
            control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
-           control->ras_num_recs < ras->bad_page_cnt_threshold)
+           control->ras_num_bad_pages < ras->bad_page_cnt_threshold)
                control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_thr=
eshold -
-                                                  control->ras_num_recs) *=
 100) /
+                                                  control->ras_num_bad_pag=
es) * 100) /
                                                   ras->bad_page_cnt_thresh=
old;

        /* Recalc the checksum.
@@ -1402,9 +1410,15 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom=
_control *control)
        if (!__get_eeprom_i2c_addr(adev, control))
                return -EINVAL;

+       if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA)
+               control->ras_num_bad_pages =3D control->ras_num_recs;
+       else
+               control->ras_num_bad_pages =3D
+                       control->ras_num_recs * adev->umc.retire_unit;
+
        if (hdr->header =3D=3D RAS_TABLE_HDR_VAL) {
                DRM_DEBUG_DRIVER("Found existing EEPROM table with %d recor=
ds",
-                                control->ras_num_recs);
+                                control->ras_num_bad_pages);

                if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
                        res =3D __read_table_ras_info(control); @@ -1419,9 =
+1433,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *co=
ntrol)

                /* Warn if we are at 90% of the threshold or above
                 */
-               if (10 * control->ras_num_recs >=3D 9 * ras->bad_page_cnt_t=
hreshold)
+               if (10 * control->ras_num_bad_pages >=3D 9 *
+ras->bad_page_cnt_threshold)
                        dev_warn(adev->dev, "RAS records:%u exceeds 90%% of=
 threshold:%d",
-                                       control->ras_num_recs,
+                                       control->ras_num_bad_pages,
                                        ras->bad_page_cnt_threshold);
        } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
                   amdgpu_bad_page_threshold !=3D 0) {
@@ -1435,7 +1449,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                if (res)
                        DRM_ERROR("RAS Table incorrect checksum or error:%d=
\n",
                                  res);
-               if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
+               if (ras->bad_page_cnt_threshold > control->ras_num_bad_page=
s) {
                        /* This means that, the threshold was increased sin=
ce
                         * the last time the system was booted, and now,
                         * ras->bad_page_cnt_threshold - control->num_recs =
> 0, @@ -1445,13 +1459,13 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_=
eeprom_control *control)
                        dev_info(adev->dev,
                                 "records:%d threshold:%d, resetting "
                                 "RAS table header signature",
-                                control->ras_num_recs,
+                                control->ras_num_bad_pages,
                                 ras->bad_page_cnt_threshold);
                        res =3D amdgpu_ras_eeprom_correct_header_tag(contro=
l,
                                                                   RAS_TABL=
E_HDR_VAL);
                } else {
                        dev_err(adev->dev, "RAS records:%d exceed threshold=
:%d",
-                               control->ras_num_recs, ras->bad_page_cnt_th=
reshold);
+                               control->ras_num_bad_pages, ras->bad_page_c=
nt_threshold);
                        if (amdgpu_bad_page_threshold =3D=3D -1) {
                                dev_warn(adev->dev, "GPU will be initialize=
d due to bad_page_threshold =3D -1.");
                                res =3D 0;
@@ -1460,7 +1474,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                                dev_err(adev->dev,
                                        "RAS records:%d exceed threshold:%d=
, "
                                        "GPU will not be initialized. Repla=
ce this GPU or increase the threshold",
-                                       control->ras_num_recs, ras->bad_pag=
e_cnt_threshold);
+                                       control->ras_num_bad_pages, ras->ba=
d_page_cnt_threshold);
                        }
                }
        } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.h
index b87422df52fd..81d55cb7b397 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -95,6 +95,11 @@ struct amdgpu_ras_eeprom_control {
         */
        u32 ras_num_recs;

+       /* the bad page number is ras_num_recs or
+        * ras_num_recs * umc.retire_unit
+        */
+       u32 ras_num_bad_pages;
+
        /* First record index to read, 0-based.
         * Range is [0, num_recs-1]. This is
         * an absolute index, starting right after diff --git a/drivers/gpu=
/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1881bcd040c7..cffe22b86118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,7 +169,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *=
adev,
                                                err_data->err_addr_cnt, fal=
se);
                        amdgpu_ras_save_bad_pages(adev, &err_count);

-                       amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom=
_control.ras_num_recs);
+                       amdgpu_dpm_send_hbm_bad_pages_num(adev,
+con->eeprom_control.ras_num_bad_pages);

                        if (con->update_channel_flag =3D=3D true) {
                                amdgpu_dpm_send_hbm_bad_channel_flag(adev, =
con->eeprom_control.bad_channel_bitmap);
--
2.34.1

