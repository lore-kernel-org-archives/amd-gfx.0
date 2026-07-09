Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99055C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 00:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE8E10F340;
	Thu,  9 Jul 2026 00:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hOdx5/5D";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FC110F340
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 00:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW+1Vgs7I8TfaKElBoA64nGifnMhgatiSSqJQn4UP/pY5Z2XxyqNFQM+Jc3B7gh83iPcs1ZSOOwc+6hH000kKfm4QoomdFzEcT2UE7oso3K+EusdoiHPHs+hcc9u7g1T6ecVw7ujvgePFfWxO9UcX/H+kMqv4OiKKPUngIkppeMrP/nHpLK75bSFgKKNHcrvbQAaqqIKVRa474uzA7FLVyvZpc15jVX+NI9PhcYVLa1caBr/Zm14NohRboWjBmNPsNAeqyTbg4/efX1pU9X3weiWWw16tGiiKSjm2uaWjwyfiTnUN1iUc4rybyuVu5yIWzAzNsbiSyqnkBBj8jJerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKoziMFE58GjMf3v2QVp2ny2dzeKylzcLgWjFF6z7GE=;
 b=XZLzdb5oe3NAuIjmFNdd9DffP8FEEbuwsIimt8+r2JANLQ0tXXVKBsSO7+qoODaS9K/5Z72lnQF3trO4RFBjAK6YNpQCIEXcUcpX8wjPkYD919bh9T15k4r+6hoTi0JfIFw7IZg+efmPGZMDp92aehiOkZq3baa7nA2yCxYqikrcI3GST3ViZz5WAR8Zzc+5UosD8EzYQcKFCybCYFF4xgTGeBnM83OJxSZikeda8JGjM/wduFjibyER7Mo5ZC5r1z7onfJu/SsvH+X884wwWTIzf4GBcXes0D5AFpUk0arrh3N2bjMHKg5bMWae48bhmLSdWvUojmXYbSmJomrdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKoziMFE58GjMf3v2QVp2ny2dzeKylzcLgWjFF6z7GE=;
 b=hOdx5/5DeusPYjuGY3VX+6mlrXO8N5HOT0bcxVE7D3njpG+MiNgDEz1WUrW3bXrUokBsoFjENFf8q4dHEAd/gwDFqZHgLSvIUVC+mdiphpk9Um+4kU9tMT9V9JEOe65KUBrY9JT6kcSIssvK60JRiWbEfWiAZWXPq290jdEufXE=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 00:48:36 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 00:48:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Soliman, Fares" <Fares.Soliman@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liang, Richard qi" <Richardqi.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Topic: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Index: AQHdDYjrkoGx4GfDm0CXzo1KdNcFBLZkXgMy
Date: Thu, 9 Jul 2026 00:48:36 +0000
Message-ID: <CH0PR12MB513999A722B9FA3E2B084792F7FE2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20260706204711.4022513-1-Fares.Soliman@amd.com>
In-Reply-To: <20260706204711.4022513-1-Fares.Soliman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T00:48:35.929Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|PH8PR12MB7278:EE_
x-ms-office365-filtering-correlation-id: 07957184-f4bf-4f8b-5443-08dedd53cf87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|38070700021|8096899003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: cg6C9/BKeJn2ZSkBcag9Z3EKxYv1xdRoIQy48kR/UoD4GMwxaitB3N+9mzkx7A2zWqo92U8VTOymSuFpkNZisObU8YwPPjwvAil40f5QcZvCJzGGq49nYnZYmoRZxSkMoYXUm692wZ0mMwhg4mD1C0vZoJRBxoFeivwnRwnzxHzqQx7XSAazUBbV96lTYgu4Y5g7cYssldI2iw7+O/IOhNKPnvBmbJiha53ihgrPqpVmCB0CTDabz9H9gLKr/d3SJqGt/J2TKMNf0bC5hjygMiO4Y7AGH8380iawfUPvX7CW68q2s26nILTz+5s5FWOszMqceBI8ZvuBCz69j+UNOZrKSpdl1bmskN4CyTu5fcjRgZdcwv7mv3CInpo3DP8REWl9kqWm5v9dq9mPsyZ0aEuYdmu2Ld7MHdJN/gTb7Yo/Ek6nY96PqdV8XrZX4Co7vZTIf0BnV9kNEgmc6gDfyg2Wu//usDFRH1s6fatIynqfm9zVxiQgVpXzBunP+yPU7ve1uMyFMCKdu1Re44wBHfGgqVzSoZB3Co6dos35TeuEHUW/sOjF5IejnysKTnD0LB7rUgAg6+c7RZc/pABqQOKO03sPtEaEb12A14b3CthtOl0nGSGNpXx5ToNtnTsTRmp92DGp7qlyApy8HyTACHnSPJqYe2s1zJR1AudPxRrEmUoxopWfhBhHFI3iB8B4B2bNJitebay9PJ/Mh7XSTrIohNacvyEuflv83eS/c6Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(8096899003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CPxKHqbxxYjtKj0jyeCfVGUtANjTB8SSgR9AM40GDvx0UYha2bxRpE1QE1xz?=
 =?us-ascii?Q?0D09pvPWkUIIk5vOdIUrkW4THEsnM8+0zpgWfWv0CJM42Ye/NTG5AcV2ODiB?=
 =?us-ascii?Q?HKWP5C3y1Wz9Gcg5z5dIwtAW5/qkvlFSKAM1EZjPicPK/YdEy71xi6tSmgLZ?=
 =?us-ascii?Q?+tiijGdZrYme4x0V9fUK3+EoFZmfDQd7gqdipfTLficm0sma0v0zhSZRt/Su?=
 =?us-ascii?Q?qvwmJ/Dl2eDI2h5hXZQLvzjDLOYBOBk3xBSEgQaMHVDeuk2f8Qq1fnxLKef1?=
 =?us-ascii?Q?wSWuQyE8y83ub8hFLYhWZoBFem0x5gySlXpvbzaeSjdhbpdnWEZxbNJYXX6E?=
 =?us-ascii?Q?g/q+tyV2/wgsPrm2+JhdLNhqZgAxvBJwWa8AHHrdteJ3Eo1TOFxt/o0vYHrj?=
 =?us-ascii?Q?eWWNciT9FXAVBqQsE7wv0VyKAm6RP91/FwGB3tYyxXyUYkHREvElYHNveov4?=
 =?us-ascii?Q?dm/jsOsN1NvOOb4bxMXa2v+G2Za+tud06tMpTXpYcpjIT9efg8HoTrxqISFq?=
 =?us-ascii?Q?Bd7Vi0hK+UJr86opXF9zG/9cx98p9e/J5PtuAi6KAcbnXLDdPagCfWEq3I17?=
 =?us-ascii?Q?I4VSQoawT+faQXXG1KJGa5jMdmbHXE9ZU91jkohhQ/E2F7cM0s+Hm0hItGtd?=
 =?us-ascii?Q?GTkEen9EVwshrLWqePQdfN0nOXKnMOd4VhmcRpxTkwEw+SEgBxpKFbxZAb47?=
 =?us-ascii?Q?M8FSLsq3N7Z+Vi4CAUFK0QQkHRkPl5vIN19WHo/g7XfSndnSuTtYozxYbQ7M?=
 =?us-ascii?Q?NVR0bUbiR5n1iEntPgtHT/7LjwFYXntBYKcqRh1JBjQ+ab6b9m6fJoa6RHqF?=
 =?us-ascii?Q?Pha3HPrscnQQOdlp/PGyVuVoQJN65MWPkHT7BlOQ0ag39nc4vB6NwIBmBTYw?=
 =?us-ascii?Q?/opoOaJjzPvC5sLWfvyRUGNoOKW23qcWLnVCSFaxX4R37F4mu5GpvAlFe3DX?=
 =?us-ascii?Q?AUEoYz3rTAtQgDnQGourRhAElpycTlrAW4gQ4yVW59Jw0aAsVnaLF7eVd3Bu?=
 =?us-ascii?Q?YejSiBVUF2Zc2+XZWNEsydzaFg+rOhS4tne+RzkN6figXOukXS3JYC0wrA8R?=
 =?us-ascii?Q?ypJ10TpLQ0RtX/BnaAzuHPYFNMEdlXVBuK37Jx+UG6g9cRjJKhJj5lDEHNnc?=
 =?us-ascii?Q?rzCNUP65jpc3Bx4hRR6sqfP7TaplrnF1W2sVTIhyLtz4XFcok7eWuy3yt/Fk?=
 =?us-ascii?Q?um9AHE14YAvD7dN6x40bk8e6WPAS1qd7h++GCXYps9Q9GWj89KhM7lOz+oWk?=
 =?us-ascii?Q?kKD4uA1beENmYmcUsMEfbBBeULDc9rN7TIYFqzZ/h1HtPjZTt6/vev2HHDfQ?=
 =?us-ascii?Q?x9SvKceAzB2onodA5b/O8XoGIrq/KC2tCqxgixIaVwpyS7PsgxOuMOLN3Ezn?=
 =?us-ascii?Q?qXT+ViaRLR67y5WoZYavyLZaq5dv9zfY5cWQtexj96MJO0A4txHWw8BYmiCd?=
 =?us-ascii?Q?YW5Dg3+YTREBk9ekNg48bp/WMSCb8jZQ8fyOpZtsZsU9fy4XVKpab17lTEZw?=
 =?us-ascii?Q?tIXP+iM/4nAUGpv81Km+h+x3MN7Kcj5LQcp4ojjNFEzSW+mBS4BOsF1H6k5o?=
 =?us-ascii?Q?F9I1l06hXIopTCC0pjMxFOu6vK6fgZ8XQE4HxnBjY8IsyecWi3RG7OwWorGg?=
 =?us-ascii?Q?DJugmsNNU9PbVPDok3uvAvaRGN/68+QNBw/HcC9qS/3sgW9mnDBZwkrsD/y4?=
 =?us-ascii?Q?NglH3CHNxiAUuJ0nkIVzTHz0VVyvbUYlyaRUSN3Gy9enZiQI?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB513999A722B9FA3E2B084792F7FE2CH0PR12MB5139namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07957184-f4bf-4f8b-5443-08dedd53cf87
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 00:48:36.6752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGiN6YqSoYhn7aGg3AwoT/n0ogJuOgjBvQsOGb0bxK0A6getITjnNE0sshJw7OM4brjYW/7wQMrlyYgkjNhIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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

--_000_CH0PR12MB513999A722B9FA3E2B084792F7FE2CH0PR12MB5139namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

I think you need a firmware version check for the new messages otherwise yo=
u'll break systems with old PMFW versions that use the old interface.

Alex


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Fares So=
liman <Fares.Soliman@amd.com>
Sent: Monday, July 6, 2026 4:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Soliman, Fares <Fares.Soliman@amd.com>; Liang, Richard qi <Richardqi.Li=
ang@amd.com>; Soliman, Fares <Fares.Soliman@amd.com>
Subject: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly gather=
 GFXOFF residency logs

Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs
on Van Gogh. Logs are now gathered live rather than starting then
stopping logging and reading an average value afterwards. This is
in accordance to changes made in PMFW.

Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 30 ++++++++++++-------
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 5c4d4ff001ea..46514a1faf1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f=
, char __user *buf,
  * @size: Number of bytes to read
  * @pos:  Offset to seek to
  *
- * Read the last residency value logged. It doesn't auto update, one needs=
 to
- * stop logging before getting the current value.
+ * Read a live GFXOFF residency sample from firmware. One needs to start l=
ogging
+ * before getting the current value.
  */
 static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char _=
_user *buf,
                                                     size_t size, loff_t *p=
os)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 62b5ad4d10b0..1bde0645c6f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3725,7 +3725,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         amdgpu_coredump_init(adev);

         adev->gfx.gfx_off_req_count =3D 1;
-       adev->gfx.gfx_off_residency =3D 0;
         adev->gfx.gfx_off_entrycount =3D 0;
         adev->pm.ac_power =3D power_supply_is_system_supplied() > 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index aefd4f03b443..4c1f8504ee1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -493,7 +493,6 @@ struct amdgpu_gfx {
         struct mutex                    gfx_off_mutex;      /* mutex to ch=
ange gfxoff state */
         uint32_t                        gfx_off_req_count;  /* default 1, =
enable gfx off: dec 1, disable gfx off: add 1 */
         struct delayed_work             gfx_off_delay_work; /* async work =
to set gfx block off */
-       uint32_t                        gfx_off_residency;  /* last logged =
residency */
         uint64_t                        gfx_off_entrycount; /* count of ti=
mes GPU has get into GFXOFF state */

         /* pipe reservation */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index f8fd93999617..d94e3dcf7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1333,7 +1333,7 @@ struct pptable_funcs {
         u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);

         /**
-        * @get_gfx_off_residency: Average GFXOFF residency % during the lo=
gging interval
+        * @get_gfx_off_residency: Live GFXOFF residency percentage
          */
         u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t *re=
sidency);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/d=
rivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..4206514765cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -110,8 +110,10 @@
 #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
 #define PPSMC_MSG_GetGfxOffStatus                      0x50
 #define PPSMC_MSG_GetGfxOffEntryCount                  0x51
-#define PPSMC_MSG_LogGfxOffResidency                  0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_GfxOffResidencyLogReadSample        0x52
+#define PPSMC_MSG_StopGfxOffResidencyLogging            0x53
+#define PPSMC_MSG_StartGfxOffResidencyLogging           0x56
+#define PPSMC_Message_Count                            0x57

 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 636ff90923d9..acf03838d49d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -252,7 +252,9 @@
         __SMU_DUMMY_MAP(DriverMode2Reset), \
         __SMU_DUMMY_MAP(GetGfxOffStatus),                \
         __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
-       __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
+       __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
+       __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),          \
+       __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
         __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),           \
         __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
         __SMU_DUMMY_MAP(AllowGpo),      \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 717ba46c8933..4212abfdbe53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -142,7 +142,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[=
SMU_MSG_MAX_COUNT] =3D {
         MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLi=
mit,                                          0),
         MSG_MAP(GetGfxOffStatus,                    PPSMC_MSG_GetGfxOffSta=
tus,                                           0),
         MSG_MAP(GetGfxOffEntryCount,                PPSMC_MSG_GetGfxOffEnt=
ryCount,                                       0),
-       MSG_MAP(LogGfxOffResidency,                 PPSMC_MSG_LogGfxOffResi=
dency,                                        0),
+       MSG_MAP(StartGfxOffResidencyLogging,  PPSMC_MSG_StartGfxOffResidenc=
yLogging,    0),
+       MSG_MAP(GfxOffResidencyLogReadSample, PPSMC_MSG_GfxOffResidencyLogR=
eadSample,   0),
+       MSG_MAP(StopGfxOffResidencyLogging,   PPSMC_MSG_StopGfxOffResidency=
Logging,             0),
 };

 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT]=
 =3D {
@@ -2450,19 +2452,20 @@ static int vangogh_set_power_limit(struct smu_conte=
xt *smu,
 static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool star=
t)
 {
         int ret =3D 0;
-       u32 residency;
         struct amdgpu_device *adev =3D smu->adev;

         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                 return 0;

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResid=
ency,
-                                             start, &residency);
-       if (ret)
-               return ret;
-
-       if (!start)
-               adev->gfx.gfx_off_residency =3D residency;
+       if (start) {
+               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxOffReside=
ncyLogging, NULL);
+               if (ret)
+                       return ret;
+       } else {
+               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOffResiden=
cyLogging, NULL);
+               if (ret)
+                       return ret;
+       }

         return ret;
 }
@@ -2479,11 +2482,16 @@ static u32 vangogh_set_gfxoff_residency(struct smu_=
context *smu, bool start)
  */
 static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t =
*residency)
 {
+       int ret =3D 0;
         struct amdgpu_device *adev =3D smu->adev;

-       *residency =3D adev->gfx.gfx_off_residency;
+       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+               return 0;

-       return 0;
+       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLogReadSam=
ple,
+                                   residency);
+
+       return ret;
 }

 /**
--
2.43.0


--_000_CH0PR12MB513999A722B9FA3E2B084792F7FE2CH0PR12MB5139namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think you need a firmware version check for the new messages otherwise yo=
u'll break systems with old PMFW versions that use the old interface.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Fares Soliman &lt;Fares.Solim=
an@amd.com&gt;<br>
<b>Sent:</b> Monday, July 6, 2026 4:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Soliman, Fares &lt;Fares.Soliman@amd.com&gt;; Liang, Richard qi =
&lt;Richardqi.Liang@amd.com&gt;; Soliman, Fares &lt;Fares.Soliman@amd.com&g=
t;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly=
 gather GFXOFF residency logs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Updates PPSMC_MSGs and set/get functions for gathe=
ring GFXOFF logs<br>
on Van Gogh. Logs are now gathered live rather than starting then<br>
stopping logging and reading an average value afterwards. This is<br>
in accordance to changes made in PMFW.<br>
<br>
Signed-off-by: Fares Soliman &lt;Fares.Soliman@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp; 4 +--=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; |&nbsp; =
1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 2 +-<br>
&nbsp;.../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h&nbsp;&nbsp;&nbsp; |&nbsp; =
6 ++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp; |&nbsp; 4 ++-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 30 ++++++++++++-=
------<br>
&nbsp;7 files changed, 29 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 5c4d4ff001ea..46514a1faf1f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f=
, char __user *buf,<br>
&nbsp; * @size: Number of bytes to read<br>
&nbsp; * @pos:&nbsp; Offset to seek to<br>
&nbsp; *<br>
- * Read the last residency value logged. It doesn't auto update, one needs=
 to<br>
- * stop logging before getting the current value.<br>
+ * Read a live GFXOFF residency sample from firmware. One needs to start l=
ogging<br>
+ * before getting the current value.<br>
&nbsp; */<br>
&nbsp;static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, c=
har __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; size_t size, loff_t *pos)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 62b5ad4d10b0..1bde0645c6f8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3725,7 +3725,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_coredump_init(adev)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_req_c=
ount =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_residency =3D 0;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_entry=
count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.ac_power =3D p=
ower_supply_is_system_supplied() &gt; 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h<br>
index aefd4f03b443..4c1f8504ee1d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
@@ -493,7 +493,6 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_mutex;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* m=
utex to change gfxoff state */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_req_count;&nbsp; /* d=
efault 1, enable gfx off: dec 1, disable gfx off: add 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_d=
elay_work; /* async work to set gfx block off */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_residency;&nbsp; /* last logged =
residency */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_entrycount; /* count =
of times GPU has get into GFXOFF state */<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pipe reservation */<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index f8fd93999617..d94e3dcf7f9a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -1333,7 +1333,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*set_gfx_off_residenc=
y)(struct smu_context *smu, bool start);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Avera=
ge GFXOFF residency % during the logging interval<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Live =
GFXOFF residency percentage<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_gfx_off_residenc=
y)(struct smu_context *smu, uint32_t *residency);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/d=
rivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
index 7471e2df2828..4206514765cd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
@@ -110,8 +110,10 @@<br>
&nbsp;#define PPSMC_MSG_GetSlowPPTLimit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x4C<br>
&nbsp;#define PPSMC_MSG_GetGfxOffStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x50<br>
&nbsp;#define PPSMC_MSG_GetGfxOffEntryCount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x51=
<br>
-#define PPSMC_MSG_LogGfxOffResidency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x52<br>
-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
+#define PPSMC_MSG_GfxOffResidencyLogReadSample&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x52<br>
+#define PPSMC_MSG_StopGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
+#define PPSMC_MSG_StartGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56<br>
+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x57<br>
&nbsp;<br>
&nbsp;//Argument for PPSMC_MSG_GfxDeviceDriverReset<br>
&nbsp;enum {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h<br>
index 636ff90923d9..acf03838d49d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
@@ -252,7 +252,9 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DriverMode=
2Reset), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffS=
tatus),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffE=
ntryCount),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(LogGfxOffResidency),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StartGfxOffResidencyL=
ogging),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxOffResidencyLogRea=
dSample),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StopGfxOffResidencyLo=
gging),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetNumBadM=
emoryPagesRetired),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetBadMemo=
ryPagesRetiredFlagsPerChannel), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowGpo),=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 717ba46c8933..4212abfdbe53 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -142,7 +142,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[=
SMU_MSG_MAX_COUNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSlowPPTLimit,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSlowPPTLimit,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffStatus,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetGfxOffStatus,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffEntryCoun=
t,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PPSMC_MSG_GetGfxOffEntryCount,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(LogGfxOffResidency,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PPSMC_MSG_LogGfxOffResidency,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StartGfxOffResidencyLogging,&=
nbsp; PPSMC_MSG_StartGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxOffResidencyLogReadSample,=
 PPSMC_MSG_GfxOffResidencyLogReadSample,&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StopGfxOffResidencyLogging,&n=
bsp;&nbsp; PPSMC_MSG_StopGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_C=
OUNT] =3D {<br>
@@ -2450,19 +2452,20 @@ static int vangogh_set_power_limit(struct smu_conte=
xt *smu,<br>
&nbsp;static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool=
 start)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 residency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_featu=
re &amp; PP_GFXOFF_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, SMU_MSG_LogGfxOffResidency,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!start)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.gfx_off_residency =3D residency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (start) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxOffResidencyLo=
gging, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOffResidencyLog=
ging, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -2479,11 +2482,16 @@ static u32 vangogh_set_gfxoff_residency(struct smu_=
context *smu, bool start)<br>
&nbsp; */<br>
&nbsp;static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint=
32_t *residency)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *residency =3D adev-&gt;gfx.gfx_off_r=
esidency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP=
_GFXOFF_MASK))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU=
_MSG_GfxOffResidencyLogReadSample,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; residency);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB513999A722B9FA3E2B084792F7FE2CH0PR12MB5139namp_--
