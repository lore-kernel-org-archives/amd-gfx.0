Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5A3C71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 08:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C4210E2DB;
	Mon, 16 Jun 2025 08:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WaNDZ37D";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DE210E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 08:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwdygdudAX6myiYcymxl7urpQpzzO/m5KXQO0kIzVlZBgnqh2tarYYBG+lVBWID63C7c6KmtmCC0ffJIIXP0hzVVENiRVj4H+ECvdc6Lpv9/yme7BsAf5HeMDM6vECgIXwd64AtaCdEYI3QrGudHlc41q4d2p5DQqQpskl+v/yNFIb/uLSDPXybQcw55ffmH+GgRLdA3dUu2pQnObS4jmVZHCmNukfH8F4ENHv7Vll++E8uoH5kEBEkONAH+JI19vupehFCZ7/0/iesuEh4rwZYjf+KtMZRNk+yFs0xrVirgekMMYJm/9EnuOx7RxH2sCg7tIzGgDp/jMzNOEMfTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO3F2sGDLpWaUO2iN1X156Sw7w3HC8r8Ztq1PFKuj2g=;
 b=jKO7PnFXP60orwMZWX7yDrFmRS5XdefEd7MwL+8VHmx7XkSV0LfchStoRXNCGiEis96jUyCAbCIhkaFYHLTVGCpx8OS96WeVWUMe3zW6ExEmSEXNcngulFKHa1nbxK7ViiMskqXbsHwo5C+tZzbZvqhLruTWAJvdK1vmAST3lMsO5fCPgs91CbB5tNsOw6f7hT75Aqv8v1R3l+FzGgE/SeVZq9FLFfWp+akhAldl17F0o+OJAFpeni6WBLETi++8YK5Q5TXMZUiOROOGOuZamaUcwqf1uSMYuRKnr2FLdxnkWz8fSPMh2gz2VIXnpc+pB/Mw5Kq+GMtd2MPRrYhMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO3F2sGDLpWaUO2iN1X156Sw7w3HC8r8Ztq1PFKuj2g=;
 b=WaNDZ37DyYV3ndpwvPfphRTDX/549IyJLZbAQGfUmcTD9MUbvcvhHpgVmaen5zA54U+8/q03i97JGEc7izx5t3OMZFQM1Nuk2lYsQMV8n8WtiqflXD/hAY+7/BVEgIXRHR6F3PzcTv68tBd8rLw8qx0vO1bDvhScu6N48LOvb1o=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 08:06:08 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 08:06:08 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Release reset locks during failures
Thread-Topic: [PATCH] drm/amdgpu: Release reset locks during failures
Thread-Index: AQHb1rJpW6XAPUCAc0i+1N2ofWMWn7QFfWZE
Date: Mon, 16 Jun 2025 08:06:08 +0000
Message-ID: <SJ0PR12MB6967EE4D7F3F1228F9562BD29D70A@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250606071234.146175-1-cesun102@amd.com>
In-Reply-To: <20250606071234.146175-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T08:06:08.1540000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: 77084377-f19e-4054-c4f4-08ddacaca69a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ceD2eZBu64Iucs5Ly9dywGav5hsA/nVJBpAkrnvF4OkcY1c1ixIMe+Q/xLj6?=
 =?us-ascii?Q?s1lJ3kFHrVk9egvAIsO2uiS0+zXJksKsEZKnrYrcibUofSqjeZxQOMlAajOd?=
 =?us-ascii?Q?I1+uYg7xhQgUwHKTuHWKgSwKIJOXZs+r+9CbOv15yyFfUY/QumsdIGfeKpC/?=
 =?us-ascii?Q?WgP9LM2aMjhopzPQb8XYdzJrCRpjPCUMbbdvBFGZ1dhbHU/yBjLocO2WTTqL?=
 =?us-ascii?Q?WulCaDxBFP5v3z7gAfm9DaA2+R8vtX+MkiGVpFjjnfFWqqFrXe4/FyRSSNBW?=
 =?us-ascii?Q?l6pjMJAAPiFId9T4VlXUz8Lki2UXwLUYvC5Ms8qZMVeNHABCYp7HFT+OQCOj?=
 =?us-ascii?Q?cmOFkj7PHIgZ3d60rVwymV5Cb2xbw04a2oeTxhwHq/EiFtmsZ5/5qMWp+UeX?=
 =?us-ascii?Q?lIp62LJokLer50gI412CA9GQEKb34uaniVV2OoF1GVNcxYRBqQoOYBz8QzHb?=
 =?us-ascii?Q?kcsqooK/7BBv8mx1NKPt3s7016yfjrzqrmznqnG/uwcR5ksY/4snPwLlZRoa?=
 =?us-ascii?Q?kaS9v3cKj4ZsBRI89HzmrC8Q9RZoKx4mhMh+GwfEv6fWGDEOTiN9MGpJLxm/?=
 =?us-ascii?Q?+zpkWh3N+6pK1btH+y0DasupL49WoEcv5ZQ2uH/CKgpH2rlWxIL+IXvl1Cy/?=
 =?us-ascii?Q?wEwEy1cNZN+jIJlEaA5zjqhDCZ4m/keNOYq1Fd4HEqgNwFgAVevmfapNJf+i?=
 =?us-ascii?Q?2z8hFVUOAlo/lPN12ZSFNGsez7zVmWFMo1neWNvkU15Ou8SfZ97mpUlqFiNa?=
 =?us-ascii?Q?6rub4Q22awggk+/ND1PwxrJAPvuyEhqcIrCj3DHEJJJ8b8ypIaTyt7d9Y4Qm?=
 =?us-ascii?Q?4UzipOPBfwUUC4t6bie4PEHrbZ+kLeysZq0Gf89dBaOWWeXzROOuqX/K/bly?=
 =?us-ascii?Q?pLz0cUZKPkGqpmooqMQgSbq9gN6sWCewcUrnlUX9EdloC/ieQG5YOKllBJs+?=
 =?us-ascii?Q?zHWBoogKkA1jV/13qOR5v1ayX43pFZbCjs92mSNeG05ufjr65l5Y/HgprDpE?=
 =?us-ascii?Q?pnGrXnT6AqTqrlzHSbDOxX8nV7XBvlOG+t4awR9aJTKj96EGXCz0NKW+ojMS?=
 =?us-ascii?Q?sUMQy2KWb3XJ3FrjtytI0qncd6VGLYMciI7Ar2L7tDq3Rrfw4II3O2zsf5gm?=
 =?us-ascii?Q?r5sXl1MsJlIEZbCypsXGnpfR77XX/Q20rWTyixYR8X5Nl2BQKVh9nFsqCYqE?=
 =?us-ascii?Q?K3nqqE47+VQ0Q8YsJuS+mtfneYVSEmHXMcLS71v5qCI+NuwVUPq0gThuzC9M?=
 =?us-ascii?Q?0ICuFM4acbdGd7EcRocG5HekmIhlhh0ZltZmxR9XGLLDigRCLETEohDLNNOT?=
 =?us-ascii?Q?P+LB+gtD8g5GChrwb2wTzTrRYDfYfdzUYU5r13pbooPKlKIV+VA+ydPwxqCl?=
 =?us-ascii?Q?CbHoiY87JI0u0Hx7FW8eBPo9S33YEVryYyhTKT0atxO9JP8HnM6WMsEMV30N?=
 =?us-ascii?Q?zKyownmum2kUf6TORuWl+EgKk4bDUjBJxrweDPTUC08Ncuq7roboHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7TjNSTnUHOZZOIGhVK4iK8M6w86MtFS/5B0NkrtaAHHLyGlfCiH1ATCUZMNx?=
 =?us-ascii?Q?VYd7GqBeNG5RnseFu6dYVh2mIKSHYG2rh88035ZrvR2bQIZYDyUtog83AtAj?=
 =?us-ascii?Q?1OG1WEZVYmffyMC7R1CozvbsN//0b4iTs9WdfoRUzZLnGJlgK8ETpqIUL18o?=
 =?us-ascii?Q?Z+vWZJLX4W7JTIy2RXNBJ+apNsMbv0M/XvxMyLaoP+173DBpIyfVU1PPE58D?=
 =?us-ascii?Q?6comk5X3/Ta2LWiu+NTwG933i1CeUm9e9FqaML0v4CaPtTzQJUWedAG58eeP?=
 =?us-ascii?Q?gbkcCAt4IHSYSH0Odx/6zUu0Ql63WXinyI4gHU086uT716p2nrndHWs++TJq?=
 =?us-ascii?Q?Gj8q+AyBxH4zLHFz3YIvoeKqJOOE8/H4Z/9+SkOAFYojUg9Mp2pWXMF+rh9M?=
 =?us-ascii?Q?2y+aEu63CBN8BA2BHrSlKA08l+6lrfr9ttjo8fw4lVqIUWFX+MPa9xF9Np4p?=
 =?us-ascii?Q?Ig28FNRTlTETS/KL7ZJGVvfUcJqCuhadb5AM/mVMGu2n/Uk1puc8zzivZr2R?=
 =?us-ascii?Q?iaWraB3uH3OPg6hzXVg7LyWw4vB2FbFMZjxMd5EhDy2y648HOSNml8Pb6h7m?=
 =?us-ascii?Q?vnM5V504AHi+iPD44kwsbIQbk/RTOKMbbo06AYuHH85IUf22UQvbBcfvvB7U?=
 =?us-ascii?Q?DwCd5K0nCw9vcL9UWRfpSLsYw9AMpSHlHxvHwLBaEY64BFecHYo2IrKpBbW7?=
 =?us-ascii?Q?2zVy1sTv2aO0saIoyvHvk7+COJOuqZ9+P/RfDVWNGZ1dirl3bhg7Xba2JmC2?=
 =?us-ascii?Q?tnp8GTQfLa4nhg4VgIIeEty3ULSxYyViXMmtYyKM7RfIGCXjKgz2XkcZ/8ap?=
 =?us-ascii?Q?V4S3w4M9Vjkk5ilYD7BNYid5vPGFaA2piBPVlQupmS7jqqy4DmH9Avz6SNAe?=
 =?us-ascii?Q?hgaKTcZSwLohLosxJHKZ/DUl4bwXz1ZX5dPXHmbEEbttQ2NEm5hPXm9yfw1h?=
 =?us-ascii?Q?WMlLexm39Ng7JGVSgkoiXpFCDakrGFHcU6aj0GLIFONUDdO/LGybHhCGSLwa?=
 =?us-ascii?Q?FeWnQrRblPCl/sxPuc3r6T+6b2FkZ3zbggYMjx2i+kaBB7Y92YS1yPZSDM6W?=
 =?us-ascii?Q?F2jNThv70CixvIXzQm3xYuYqrJto6lXRLz4JWeXcfDXSb+wtTI0KQ/HMyPfz?=
 =?us-ascii?Q?8IIa365EypZCdsNTRJZIKgrUPrdzbr7lCZ/8mz2BwVs3RqCVQzPK8Pd+wdiY?=
 =?us-ascii?Q?s2XiioColN69KOv2UBEuXbcTyqjWZ6+jCPLvOzcdN/srDSGqZLt1R4jFl95I?=
 =?us-ascii?Q?t+6gQA7ymTtRnX03uVY1G22fZcgPCl/SIbyQIB6frv4+sjMoR0EHZjxmMAiR?=
 =?us-ascii?Q?90iQcBHKJeTBWYa5Ipw3x1GkWVw1wYtA5zVJZF32GELVwu+giANVpE0l8QRB?=
 =?us-ascii?Q?qvhRz5mmt/1VSyviMIs3we+BG5+qT9NoVyPjOD83gQzQ9x+S+cK8S8p3MLhX?=
 =?us-ascii?Q?SYxI/8tNtApGSvJgl2VjbufoFCQmRHR2oslaGzof5lVkybXkOfV+/j1tz8uu?=
 =?us-ascii?Q?3k2kvptlyUs2A+fpvjH9VY2g4HXT8gM8xjUMMS4Pl6+NM82a3OfkQK89sTPz?=
 =?us-ascii?Q?4mAkhUG3ML21XzYQXf0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967EE4D7F3F1228F9562BD29D70ASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77084377-f19e-4054-c4f4-08ddacaca69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 08:06:08.5952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3xpjfsyRLJ6LbTiGwBGQWdvrSwxIuYKy5yEubhZ2Kml7TLAbh2L1/OcwVP5pd5tPD0bBBZzLTZaQaXD4IwDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

--_000_SJ0PR12MB6967EE4D7F3F1228F9562BD29D70ASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping...







Regards,
Ce, Sun


________________________________
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, June 6, 2025 3:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Sun,=
 Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Release reset locks during failures

From: Lijo Lazar <lijo.lazar@amd.com>

Make sure to release reset domain lock in case of failures.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ce Sun <cesun102@amd.com>

Fixes: 0f936e23cf9d ("drm/amdgpu: refactor amdgpu_device_gpu_recover")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++-------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2b84df8da61a..85509cd4cab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6068,16 +6068,12 @@ static int amdgpu_device_health_check(struct list_h=
ead *device_list_handle)
         return ret;
 }

-static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
-                             struct amdgpu_job *job,
-                             struct amdgpu_reset_context *reset_context,
-                             struct list_head *device_list,
-                             struct amdgpu_hive_info *hive,
-                             bool need_emergency_restart)
+static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
+                                         struct list_head *device_list,
+                                         struct amdgpu_hive_info *hive)
 {
-       struct list_head *device_list_handle =3D  NULL;
         struct amdgpu_device *tmp_adev =3D NULL;
-       int i, r =3D 0;
+       int r;

         /*
          * Build list of devices to reset.
@@ -6094,26 +6090,54 @@ static int amdgpu_device_halt_activities(struct amd=
gpu_device *adev,
                 }
                 if (!list_is_first(&adev->reset_list, device_list))
                         list_rotate_to_front(&adev->reset_list, device_lis=
t);
-               device_list_handle =3D device_list;
         } else {
                 list_add_tail(&adev->reset_list, device_list);
-               device_list_handle =3D device_list;
         }

         if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) =
{
-               r =3D amdgpu_device_health_check(device_list_handle);
+               r =3D amdgpu_device_health_check(device_list);
                 if (r)
                         return r;
         }

-       /* We need to lock reset domain only once both for XGMI and single =
device */
-       tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_dev=
ice,
-                                   reset_list);
+       return 0;
+}
+
+static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *ad=
ev,
+                                                 struct list_head *device_=
list)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;
+
+       if (list_empty(device_list))
+               return;
+       tmp_adev =3D
+               list_first_entry(device_list, struct amdgpu_device, reset_l=
ist);
         amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+}

-       /* block all schedulers and reset given job's ring */
-       list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+static void amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *ad=
ev,
+                                                 struct list_head *device_=
list)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;

+       if (list_empty(device_list))
+               return;
+       tmp_adev =3D
+               list_first_entry(device_list, struct amdgpu_device, reset_l=
ist);
+       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
+}
+
+static int amdgpu_device_halt_activities(
+       struct amdgpu_device *adev, struct amdgpu_job *job,
+       struct amdgpu_reset_context *reset_context,
+       struct list_head *device_list, struct amdgpu_hive_info *hive,
+       bool need_emergency_restart)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;
+       int i, r =3D 0;
+
+       /* block all schedulers and reset given job's ring */
+       list_for_each_entry(tmp_adev, device_list, reset_list) {
                 amdgpu_device_set_mp1_state(tmp_adev);

                 /*
@@ -6301,11 +6325,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_d=
evice *adev,
                 amdgpu_ras_set_error_query_ready(tmp_adev, true);

         }
-
-       tmp_adev =3D list_first_entry(device_list, struct amdgpu_device,
-                                           reset_list);
-       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
-
 }


@@ -6376,10 +6395,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
         reset_context->hive =3D hive;
         INIT_LIST_HEAD(&device_list);

+       if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
+               goto end_reset;
+
+       /* We need to lock reset domain only once both for XGMI and single =
device */
+       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
+
         r =3D amdgpu_device_halt_activities(adev, job, reset_context, &dev=
ice_list,
                                          hive, need_emergency_restart);
         if (r)
-               goto end_reset;
+               goto reset_unlock;

         if (need_emergency_restart)
                 goto skip_sched_resume;
@@ -6397,13 +6422,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,

         r =3D amdgpu_device_asic_reset(adev, &device_list, reset_context);
         if (r)
-               goto end_reset;
+               goto reset_unlock;
 skip_hw_reset:
         r =3D amdgpu_device_sched_resume(&device_list, reset_context, job_=
signaled);
         if (r)
-               goto end_reset;
+               goto reset_unlock;
 skip_sched_resume:
         amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restar=
t);
+reset_unlock:
+       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 end_reset:
         if (hive) {
                 mutex_unlock(&hive->hive_lock);
@@ -6821,6 +6848,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta
                 memset(&reset_context, 0, sizeof(reset_context));
                 INIT_LIST_HEAD(&device_list);

+               amdgpu_device_recovery_prepare(adev, &device_list, hive);
+               amdgpu_device_recovery_get_reset_lock(adev, &device_list);
                 r =3D amdgpu_device_halt_activities(adev, NULL, &reset_con=
text, &device_list,
                                          hive, false);
                 if (hive) {
@@ -6938,8 +6967,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev=
 *pdev)
                 if (hive) {
                         list_for_each_entry(tmp_adev, &device_list, reset_=
list)
                                 amdgpu_device_unset_mp1_state(tmp_adev);
-                       amdgpu_device_unlock_reset_domain(adev->reset_domai=
n);
                 }
+               amdgpu_device_recovery_put_reset_lock(adev, &device_list);
         }

         if (hive) {
@@ -6985,6 +7014,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)

         amdgpu_device_sched_resume(&device_list, NULL, NULL);
         amdgpu_device_gpu_resume(adev, &device_list, false);
+       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
         adev->pcie_reset_ctx.occurs_dpc =3D false;

         if (hive) {
--
2.34.1


--_000_SJ0PR12MB6967EE4D7F3F1228F9562BD29D70ASJ0PR12MB6967namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ping...</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: white; margin: 0px; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif, ser=
if, EmojiFont; font-size: 12pt; color: black;">
Regards,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: white; margin: 0px; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif, ser=
if, EmojiFont; font-size: 12pt; color: black;">
Ce, Sun</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sun, Ce(Overlord) &lt=
;Ce.Sun@amd.com&gt;<br>
<b>Sent:</b> Friday, June 6, 2025 3:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Lazar, Lijo &=
lt;Lijo.Lazar@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Release reset locks during failures</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<br>
Make sure to release reset domain lock in case of failures.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
<br>
Fixes: 0f936e23cf9d (&quot;drm/amdgpu: refactor amdgpu_device_gpu_recover&q=
uot;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++------=
-<br>
&nbsp;1 file changed, 55 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 2b84df8da61a..85509cd4cab8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6068,16 +6068,12 @@ static int amdgpu_device_health_check(struct list_h=
ead *device_list_handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int amdgpu_device_halt_activities(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_context,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct list_head *device_list,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bool need_emergency_restart)<br>
+static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct list_head *device_list,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *device_list_handle =
=3D&nbsp; NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Build list of devi=
ces to reset.<br>
@@ -6094,26 +6090,54 @@ static int amdgpu_device_halt_activities(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!list_is_first(&amp;adev-&gt;reset_list, device_l=
ist))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
rotate_to_front(&amp;adev-&gt;reset_list, device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_list_handle =3D device_list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev-&gt;reset_list, device_list);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_list_handle =3D device_list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
 &amp;&amp; (!adev-&gt;pcie_reset_ctx.occurs_dpc)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_device_health_check(device_list_handle);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_device_health_check(device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to lock reset domain only =
once both for XGMI and single device */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_entry(device_=
list_handle, struct amdgpu_device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *ad=
ev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct lis=
t_head *device_list)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =3D NU=
LL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(device_list))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_first_entry(device_list, struct amdgpu_device, reset_list);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_lock_reset_d=
omain(tmp_adev-&gt;reset_domain);<br>
+}<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset giv=
en job's ring */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, device_=
list_handle, reset_list) {<br>
+static void amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *ad=
ev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct lis=
t_head *device_list)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =3D NU=
LL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(device_list))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_first_entry(device_list, struct amdgpu_device, reset_list);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset_domain(tmp=
_adev-&gt;reset_domain);<br>
+}<br>
+<br>
+static int amdgpu_device_halt_activities(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev, struct am=
dgpu_job *job,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_co=
ntext,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *device_list, struct=
 amdgpu_hive_info *hive,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =3D NU=
LL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset giv=
en job's ring */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, device_=
list, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_mp1_state(tmp_adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
@@ -6301,11 +6325,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_set_error_query_ready(tmp_adev, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_entry(device_=
list, struct amdgpu_device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset_domain(tmp=
_adev-&gt;reset_domain);<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
@@ -6376,10 +6395,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context-&gt;hive =3D=
 hive;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device=
_list);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_recovery_prepare(ad=
ev, &amp;device_list, hive))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end_reset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to lock reset domain only =
once both for XGMI and single device */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_recovery_get_reset_lock=
(adev, &amp;device_list);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_halt_a=
ctivities(adev, job, reset_context, &amp;device_list,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hive, need_emergency_restart);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end_reset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto reset_unlock;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_emergency_restart=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto skip_sched_resume;<br>
@@ -6397,13 +6422,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_asic_r=
eset(adev, &amp;device_list, reset_context);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end_reset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto reset_unlock;<br>
&nbsp;skip_hw_reset:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_sched_=
resume(&amp;device_list, reset_context, job_signaled);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end_reset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto reset_unlock;<br>
&nbsp;skip_sched_resume:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_resume(a=
dev, &amp;device_list, need_emergency_restart);<br>
+reset_unlock:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_recovery_put_reset_lock=
(adev, &amp;device_list);<br>
&nbsp;end_reset:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hive-&gt;hive_lock);<br>
@@ -6821,6 +6848,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context, 0, sizeof(reset_context));=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_recovery_prepare(adev, &amp;device_list, hive);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_recovery_get_reset_lock(adev, &amp;device_list);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_halt_activities(adev, NULL, &amp;=
reset_context, &amp;device_list,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hive, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
@@ -6938,8 +6967,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev=
 *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
for_each_entry(tmp_adev, &amp;device_list, reset_list)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unset_mp1_state(tm=
p_adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_un=
lock_reset_domain(adev-&gt;reset_domain);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_recovery_put_reset_lock(adev, &amp;device_list);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
@@ -6985,6 +7014,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_sched_resume=
(&amp;device_list, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_resume(a=
dev, &amp;device_list, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_recovery_put_reset_lock=
(adev, &amp;device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.oc=
curs_dpc =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive) {<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6967EE4D7F3F1228F9562BD29D70ASJ0PR12MB6967namp_--
