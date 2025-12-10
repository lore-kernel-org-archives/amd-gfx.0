Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57047D3C90E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE86110E0A8;
	Wed, 10 Dec 2025 20:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0yt7joG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D8F10E0A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfoFB52Q3AOfchlvoR7hqhzmF0F6CH7F4qqQXcvE15xvhrlL/BTdGANNTwIGN6qfY2S+wqkVmOtZvXzyJ2u296X5NybaRpRVtXvt2MhLANvyT1jFL9rJ7DtxIWi4BQGTO7VKYM1wDuMsoSUTxU3AHU89R3WYu67HPv3evDt3Q9W/juXEgGdzCCJZBHLG2XrnmyG+GJS5NvPRXA1LBuAvsA3QGu4EoG8iHzaFc3UK2hFZfmaa2+HeP3+uRfZPg1B70PX8bQxBGC7hmfCoeH+JFNiZz4q/IlJa0O5SCNdKEGmQLHBIPcCfnIfBvB4vDDh7vRDnRfYkW9QwdUo0xdNs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWnpMAwIPkHI9bt5Xjgls0rXwDBG7x78pLUj92jlQwM=;
 b=ekm3topIkxIy+YUHHqvwjt8gfGvzNPZzWrP50gvfaJ5GiUh91R9CwVAWOwZyLDOu4FRrv6ps9tmgVQM44p4T7cI96l8MFQ+RB6hOiILyvUguSC/X1rAYJGJtTg7YfEwPD6KU6QOFWa0FBYLngDoxSzKzejUEY7wOmBPKYXugyfFJXdmmka1PDGfvuPfm8sHlX+KlRsUVxo6KTYdgABsDT5fJUf73X9oOFsA2B4qbnOQNh4k52vxdI7bWKSm8YBrR/XV5c+yEU8ZEZ85faDyWeTbpI1630thQuUbV2hJSIza71asQQWONNw4IOImBrKQXY1Cre3VS+DG+TrK4wB3Nwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWnpMAwIPkHI9bt5Xjgls0rXwDBG7x78pLUj92jlQwM=;
 b=A0yt7joGuz1RgK4WYgN+P30xJcKENKxzGCLcYYzoJlju94iBvdaL4DTsgbTegcM2gjqbYUmUuSZ/OLmffrGTfWJhbbyI9BhQFMdH9RUyI0DZAgB4XU9bA7er3xjkRpL0JzYplzXVGPsxQ/D/u3Ma/DDOlVZhGBoToG4pMqy9gcw=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 20:40:28 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 20:40:28 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 3/3] amdkfd: Add device links between kfd device and
 amdgpu device
Thread-Topic: [PATCH v2 3/3] amdkfd: Add device links between kfd device and
 amdgpu device
Thread-Index: AQHcahG8lMtfPXg1yEG0+SsKJzAUpbUbVj1A
Date: Wed, 10 Dec 2025 20:40:28 +0000
Message-ID: <BL1PR12MB589889F0E488AA85EF7E34A885A0A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251210201510.3000-1-superm1@kernel.org>
 <20251210201510.3000-4-superm1@kernel.org>
In-Reply-To: <20251210201510.3000-4-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-10T20:40:25.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SN7PR12MB6671:EE_
x-ms-office365-filtering-correlation-id: db157919-a0bf-4c70-8780-08de382c5ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?en9xWYsSlESbBdOv763Tw8+JrgCiTBl67w5bRBLLTPe7lNy0zOabmPDYc6oE?=
 =?us-ascii?Q?oMT5DW4tPS1ukWS+JRXhSpUEjf6CJQcatFA6TgmIilwTfSmlI8uUEnMNZ3qm?=
 =?us-ascii?Q?jt4keDlNB9ATF6YRgANSfh4/U6hA6DX/oJBKO6VS/i6Pv4IWBOMNguBB8wPZ?=
 =?us-ascii?Q?vXLhvcOFZv/w8bazGMLIkpWZRsPv4yPsvkzmUmyxgigA4+Z40f3dxBK+Q/6Q?=
 =?us-ascii?Q?c1G1i4XJPRMAYrpL4A2ygr5Vs4bAWNnN+r/SHgiCHJ7m0W6XWHVZy7hAKH27?=
 =?us-ascii?Q?zfUlx+f0NvvjXx7E59i2EFgDluiRTb3Hcm1+l1miNL/DyjHH5FHzJjC3M6BM?=
 =?us-ascii?Q?G7r8rWT0oiNq8tHyQfoRQSPmJHtbeWgWsUWqVjvj8lJtAJaGhtO70LmlugMy?=
 =?us-ascii?Q?65J5AbSdASpLPhXjfxZDeQwQZF4+2KbAHYoFtVjQcOIGHPwzw0KlSS+Kh4JI?=
 =?us-ascii?Q?CIvT23mHsENnM0PqgP6xDrWZvbPzruZthSUMtlqGa94i30pNTS7MJQWhSc1e?=
 =?us-ascii?Q?9kUAUIkk1TkUXg+jB/sPOF4WoVrYAtaipFn2KNobTsHPfg4hNJxEOWqqzzRA?=
 =?us-ascii?Q?TpAVrGMn4I0f5oyQdZcnIbT+1SbSYZjgoEX3TCVy0HGdOl/jOVarp8dQVWAI?=
 =?us-ascii?Q?Po7YB9MtWrUr61yatrz+g7qobbQt/P6YalNcrU0yAFXBiua99duYRzqCQWAF?=
 =?us-ascii?Q?p2dPYSLj7xC4yvYwEL7tAno6wn/9dSnMk5tcmtM0C/qt0giAjNiLBTec050l?=
 =?us-ascii?Q?ueNKUc68QhEv3t9uUPUf0yhW3NURqdWrbTylMtZ0bb1T1fI8YDRhnFkTcKQL?=
 =?us-ascii?Q?vOvevZFN/NBTyvLbQvlTH8Y+HAFUPOBs0Ora8skqIj1ngI3RPb07bF44WLeC?=
 =?us-ascii?Q?PJ7chiAzhxtvVcQrSaqS7XDKDbNj6T6NhIQvOMmei4CntIdqM+D2AinLY66C?=
 =?us-ascii?Q?chPhAAbpVAiyp0NKxlB21Y4PeKA1Aw26ciZfoELS91zs/PooV/3uJDBoaWB6?=
 =?us-ascii?Q?P8XiaLl63Bw76+3nSiwnjCbXAsAYn/c6SpAZactj3jRnJ++ICwUwFjjjma2b?=
 =?us-ascii?Q?suKQzxuaJjtTSKaPPB6DBAkoQkLx3HtVTzmK4Bmw1st7FKKNe8sN8qaJktwV?=
 =?us-ascii?Q?mN7rwwCF5kee5vxLYk4YnvwowvpPxYsnfzcBAUnxqymRfVTzp9wHp+hGLrZO?=
 =?us-ascii?Q?ZksUVu84Pyf5p1fmW4IyNnGmqktOjK+PaoG8u4lXdzqMYJDYzaXmcd3mfhNL?=
 =?us-ascii?Q?LPj7YT8m3poZNKM5VG8cndgogCvTXWk0h04eoa0cVhhvP8krlHwuw01ZCzlu?=
 =?us-ascii?Q?tBUlAicIytcIW6nVkCApwwczAw3UrmfarSlPaqKOg1/NKiv8FKEWzigwmpeG?=
 =?us-ascii?Q?sOJlAgDfUDM/4omMiq/kAmQrXTRK4rBToERpDlq7O9/yy7WjdXSOwpZsaB0c?=
 =?us-ascii?Q?HBL1BYFzVMLWrA25khh8TIpj+OVvcai9ULO4qv/xYzF6ar3DE1SO2fQpHWC/?=
 =?us-ascii?Q?dVNqL1ZkABySbUzlA0UbPP/IB4BGHEWOA1LC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jy0mycGbFuU0td/0a8g1G5sGehRcjEjZtiyKYc92zh76hkhjhNYlPGeBSXYg?=
 =?us-ascii?Q?BH6PVqz4iwM78HlaEJd9opo95s09lbyBOLrciAQ/E/83++kFON19fdcXhI4D?=
 =?us-ascii?Q?p3+QoS9NVF+NZnk9Sg/FiOxl3h/UKrk07lOl8UgZPMEH9/v6cQtgC1rf4gAp?=
 =?us-ascii?Q?V1IVnFsSacNdP90YGN7IExpzplkrHTf2MIwRbP4eo6TGCEyLL4t1EryWBnkR?=
 =?us-ascii?Q?1EXF2LvdUkqY61TlDb8rqhWG06lnb2JDcHguCcqJVCgHj7m4/Cf6lHIp7XLH?=
 =?us-ascii?Q?U8k9FAICAy3ovmgEAiOx/X+NHC6GuxX9FXzGEtBvYCcn0gU5/ixVaLGYbkMO?=
 =?us-ascii?Q?5nJuDQ6GM7rDBFFMHBa1e0MmSv+MHdklIq+SQGhLnM7lTMYoBfHDHwgHRCM6?=
 =?us-ascii?Q?1dSOmoCUl3PhXO0QR1qZog45iqZGb9weeXjAlIyojzrWrxmZu/S2ResxWLxg?=
 =?us-ascii?Q?6KZUIyAE5HFU2ySaIPvQbWuQrgcHW/Ju1uVA0yrf0/Ux/pGhgPuy2K/QSI8n?=
 =?us-ascii?Q?4+vKze3e94GGX/H6Kng1WvHY4zcIE2OxsuhI8Afv1htq0DXlZOmxULwnU9it?=
 =?us-ascii?Q?GnVfQaZ35fabAm0YYiVuHUp9vulxzHncR26g+0b6ey0s2CVLZM0Xjn8zs/TW?=
 =?us-ascii?Q?8s4rvVbFn6UXNBiwYrW8Fi3LE1strHuRAEW5ZfVS4f7p2OtcanhBHgB+viIa?=
 =?us-ascii?Q?U57cAVx/3hTjWYDzfKfM+xgQ4nY3YY7g7M46UG7bmeX7fYu5ZVXIvzHgNwRK?=
 =?us-ascii?Q?6nIbXYEu51Gb0fwgCrpxRGbujmhGCE207NmC1/sKU3w87XA/Tr0gSWfdaui/?=
 =?us-ascii?Q?bXm2kWoFXR78gHmApmwx0MDOLC/0eHZYQVoNllnUNqlWyNqVud4XjyLiGtls?=
 =?us-ascii?Q?jCGt5y2lDlk8VQevNHF8dQH0ZIFBR4B5Jw0MV8bWflYfzlb8Y/rY+uC/ryMP?=
 =?us-ascii?Q?NTJ16QmT6jQ99a5K/s1WrSFi1iGIZCxLn6RTFEsYgPcmijfVInDu1eTmxa+f?=
 =?us-ascii?Q?DFgeH9em4zGf/uITwanwFYXrGNhxHkSQuXte6zG4s9chgc+DZHZbe3dVYBeB?=
 =?us-ascii?Q?u/XjCxCYGit00ZmRLOl32dL/INcf6+2gdeEC1muSMbMh3Qu9lwJ8VhufTKJJ?=
 =?us-ascii?Q?NxX6gdzQTTNlpckDLqSTxVV4BK/Tgtl0Jd1vgBiCvpqMYLMMR2fomJzMKBLa?=
 =?us-ascii?Q?5LXOkq4JEEt5gHtqOo9CdDkaRGrmeqUSwdFnQmkrkMBibJYrMMM15kItJMFX?=
 =?us-ascii?Q?xEaW0Jxmk7pIBrl3nPNPh3o2fT06VgAHwZUHshtUsOijB1bKU/WL7oh+b6H2?=
 =?us-ascii?Q?z2BRhGA3xknp6oG4MvmITnvU6VfV8P1rUh30HcBfyyaiyO/KJZCzTqNLK7Ir?=
 =?us-ascii?Q?9qQZ6LtItSJB11qFQyhSs0R965CMyjOEdAwJWaXQNL/CaXAtSz/CW9L1kt87?=
 =?us-ascii?Q?AR86stHgPxkyDWzXhj4LaOxUewdDn+iJtt8fChS9SAPBH+r2RwE7W/LLSbgV?=
 =?us-ascii?Q?hSZvmUD/UIZVp91qXp4ZN0XLXUjQ+XSW8n20Ag/kzW7CY7JPoJ1PI17fQqyh?=
 =?us-ascii?Q?205UlACGR2a5ujSjp7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db157919-a0bf-4c70-8780-08de382c5ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 20:40:28.5439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDP7pi60AMLo5EFpT58mWZYGrNGp070QL4/j5p/xq5SQCgOd0Nz5ZMnj67+5hZH9aAWGMNTzWVLHKVFZjsiyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello (AMD)
> Sent: Wednesday, December 10, 2025 3:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Subject: [PATCH v2 3/3] amdkfd: Add device links between kfd device and a=
mdgpu
> device
>
> Mapping out a KFD device to a GPU can be done manually by looking at the
> domain and location properties.  To make it easier to discover which
> KFD device goes with what GPU add bidirectional links.
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  8 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 36 +++++++++++++++++++
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 ++
>  5 files changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a2879d2b7c8ec..5d6cf3adfa7b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct
> amdgpu_device *adev, uint32_t xcp_id,
>
>       return r;
>  }
> +
> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)
> +{
> +     if (!adev->kfd.init_complete || !adev->kfd.dev)
> +             return 0;
> +
> +     return kgd2kfd_create_sysfs_links(adev->kfd.dev);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index da4575676335f..fd92b227a674b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -272,6 +272,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device
> *adev, uint32_t node_id);
>  int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t
> xcp_id,
>       bool core_override_enable, bool reg_override_enable, bool
> perfmon_override_enable);
>  bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t
> node_id);
> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
>
>
>  /* Read user wptr from a specified user address space with page fault
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a0213a07023d..44c9320d72a56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4947,6 +4947,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        */
>       r =3D amdgpu_device_sys_interface_init(adev);
>
> +     r =3D amdgpu_amdkfd_create_sysfs_links(adev);
> +     if (r)
> +             dev_err(adev->dev, "Failed to create KFD sysfs link: %d\n",=
 r);
> +
>       if (IS_ENABLED(CONFIG_PERF_EVENTS))
>               r =3D amdgpu_pmu_init(adev);
>       if (r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index b65f29294e2d6..796fd411a7dcc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -79,6 +79,37 @@ struct kfd_topology_device
> *kfd_topology_device_by_proximity_domain(
>       return device;
>  }
>
> +int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd)
> +{
> +     struct kfd_topology_device *top_dev;
> +     int ret =3D -ENODEV;
> +
> +     if (!kfd)
> +             return -EINVAL;
> +
> +     down_read(&topology_lock);
> +
> +     list_for_each_entry(top_dev, &topology_device_list, list) {
> +             struct kobject *amdgpu_kobj;
> +
> +             if (!top_dev->gpu || top_dev->gpu->kfd !=3D kfd || !top_dev=
->kobj_node)
> +                     continue;
> +
> +             amdgpu_kobj =3D &top_dev->gpu->adev->dev->kobj;
> +             ret =3D sysfs_create_link(top_dev->kobj_node, amdgpu_kobj, =
"device");
> +             if (ret)
> +                     break;
> +
> +             ret =3D sysfs_create_link(amdgpu_kobj, top_dev->kobj_node, =
"kfd");
> +             if (ret)
> +                     sysfs_remove_link(top_dev->kobj_node, "device");
> +             break;
> +     }
> +
> +     up_read(&topology_lock);
> +     return ret;
> +}
> +
>  struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
>  {
>       struct kfd_topology_device *top_dev =3D NULL;
> @@ -571,6 +602,11 @@ static void kfd_remove_sysfs_node_entry(struct
> kfd_topology_device *dev)
>       struct kfd_mem_properties *mem;
>       struct kfd_perf_properties *perf;
>
> +     if (dev->gpu) {
> +             sysfs_remove_link(dev->kobj_node, "device");
> +             sysfs_remove_link(&dev->gpu->adev->dev->kobj, "kfd");
> +     }
> +
>       if (dev->kobj_iolink) {
>               list_for_each_entry(iolink, &dev->io_link_props, list)
>                       if (iolink->kobj) {
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 9aba8596faa7e..f6db1dc634399 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -335,4 +335,6 @@ struct kfd2kgd_calls {
>                                         int engine, int queue);
>  };
>
> +int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd);
> +
>  #endif       /* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.43.0

