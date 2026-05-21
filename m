Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC4CCD5BA4
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 11:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B82110E151;
	Thu, 21 May 2026 11:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SsVooeHG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F3E10E151
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 11:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhht1IegwJrYIVCldQ/G9mVad5usCUDUYbXs/f+PemOinq7XQexzXTDnQRShhnBG9x2j+fHqrLh68C9RmkqVjr1GGFk675fX1T/j5njYXPpujw5mP04vLsahmMX2mE2zyAzh3Utrx4fyxBLMecaBfWjK/RhUdxNG3KHYMtnHmHMf5SNk9c1wnmXmhx6boVJjXsaD3Rjc5O7vP8msx9TxspNsC3xyIleqhlgLNb9E0mPEZbD1vRhiFyDVd/+J7yLZMnrgI9Px/KytY54n+kVK1WVUjfJ02YDVEY/C1dWdy1kY5ggDXg31SfH47snR8ZGdKo7XJmjANgqgRCoffTT98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyDPOpMvBilb+ri7dU0pWEVaeHJKsfyN94xr4rNclEA=;
 b=XRruI4NEerJGwPW9RH01zHU3PwelE9ew6Rc1rS3+EJWIuJ8sXaKCSidTFwaGlNVCibQLHU0VdGkuaskS/eDwR/vr3eHnT2oiFyHNlnWssbjRLD9JDNuijioWJAjPetg7S+kYSQFwu3N9J9mL+g8Oe1jD5R8dDiJu+iv+9/a8zfY0AJte1Kd7jo5uo4tBG39n6pPNJXbhOSmqGWXHuu4yBGn4SLA+cd8EfpjJX7Vg/qTiWU19f6OKbyUwdGiJsgClybGTCsint7T6d0zeoDoVCRPXHKfNlwZjHcKOLv/56OWoVvkMVnRfS9M1wo6EoeJkSVE34F7WgKUcjwNQGbqFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyDPOpMvBilb+ri7dU0pWEVaeHJKsfyN94xr4rNclEA=;
 b=SsVooeHGOJvB5s0haAyrPiGBs+NFlGiSy6rzO5tGMbcajDF0o0tm/sKu1PAOyYEj50VuZAjYdQXWjr2xG+J6jzE/kmOyyNBkNhyrvnQXDUkSXRnzOv3Z3rlnefmsmglO85d/RDX6uBJ+FgYZojeS5loUXc8/BOzHPo13SSEqnHI=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 11:25:23 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 11:25:23 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: change VF RAS bad bage space to dynamic
 allocation
Thread-Topic: [PATCH v3] drm/amdgpu: change VF RAS bad bage space to dynamic
 allocation
Thread-Index: AQHc4h3e6ICpTNDZ3UeoqNCoasrzaLYYZMZg
Date: Thu, 21 May 2026 11:25:23 +0000
Message-ID: <BN9PR12MB53066582CECDF8947FD4E9DCFC0E2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260508180705.217683-1-Chenglei.Xie@amd.com>
 <20260512144429.213175-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260512144429.213175-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-21T11:09:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|CY8PR12MB7514:EE_
x-ms-office365-filtering-correlation-id: 0cb160cd-e464-45ab-66a9-08deb72ba654
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info: +6aVdSgz/44ELOFSmwZHWgbMZy+rgI0ZeO/SWX9YVEKSXd7SdRzQp/pfOAxs0tronSo1TOJIVG77IfuU960rhsVAP/qIywEyX/9TY7dGNltClASzzq0957d1tLsRugJYLUBKpJz9JEErU3Wx0kZla5QxkdwOe8n3vNr61pl8jLjGvDkbIH5QU/BMPGTYtVPzpquYROsWy6Y1jBKcUXLETc2yqtnmAGhOYK2rHsKKnMBJQVlB+Wz37ANkpadJIbkxkOcPPJNF8ORHqVsCcd1pkvGWZNFeWQiLw783VQNMDgcECnf6vfspBVAEDSL1+AaYnHLSXJIUPVEWL/GyHk9d2Ee8xZAf/AXyb/r8Xd5PcN6w76ercZYRcvK7Xf3mEiXicio6K69WOfTWY0wxI7wgYhUZb5uMUXOAWpNb9YtLCYqE8FFWZoevuTOCDkQYZOfw2jpSH4l6tESqYpPCizMsV7ecNou10RDoccldVv6hP/4axO/k9xZpai6Is9ZlLOXBDwjV0OItlC3pBmewmZaiNJNFQi1UDX0/+Gh4FC7rYQPf5Ylqx4krvPxlVkGDemGthrnVLR/99ZcWhXGbrVKUTgObG5EIy+JZgs3BzuChwAl5YeLsSBnb6I+LXBcE649jWbNLa1pqm4rDd3Zqk95qwd8RcFQuh+VOfBaY+nt3HXSuGDaIrJ/xZJytTEa/J50pAp9L0aWOjO+Fgfl1O9zYx83TsisumsLG4HP2tj1u86WgSUjD5AcFsixP3EibAnMg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JlFQXAj9LUNv1wSjUgFjSWbruVCnxblV22UmU55cWRc0W6AoQXZiqGOiVMf2?=
 =?us-ascii?Q?/0aZ91CFs+P6Xo5eQ9XunyIaYPekC7tsoJSfjamWSjkqWrcgXXltRstkX5/K?=
 =?us-ascii?Q?21yRpUhj/WVlMb8TT4hI8CCp/4x705FUP03sivBA0qeUJLJUyQG3OPQXQ6p5?=
 =?us-ascii?Q?bMg+RLmRngDDRML76CiTZVpfGSkaz6I4iwAFK6WYovgWKsEuIXBoqsPCmVzD?=
 =?us-ascii?Q?LLwFUX94C6Rb5w9aBbugRM+m30EsRW+sZTLPt1ViVZqdp5t9VF/VYUGuirQz?=
 =?us-ascii?Q?lzRqCo17qDIBgrrvCQd+j27YBH/AbvP+SZi+vrEriB41NupqZWwaWII5tFkw?=
 =?us-ascii?Q?HxO2jkloFNDFU0omQNpdJxR8i5YblYoSZvg+i3iOGZ90w79zvjcgXJt2FKzE?=
 =?us-ascii?Q?Eq/nFTmu24l4OVZ1c0OTYFaCMkffRum6d1/4Lfnj5XAO2DySlK5zCO+27S3p?=
 =?us-ascii?Q?JtPiAHLCVNBdvF23EFrCTaUxwaEhIFlTW+ZuChtOcWFCVvWCsjD7bd15XgeH?=
 =?us-ascii?Q?fNhygfQvfnrpO2odB3hocGYR71wDstb2TenYFsttARpBnWffHKyDTuP4at2+?=
 =?us-ascii?Q?yQAmr8RRt+KXM9eKSgBr0KBSQPdV3ylVOCmDxlvqTNYptwC9YmPTSMTjqHtW?=
 =?us-ascii?Q?VQEdUH82dO2NZkT5gPMw9sTemPjWF9LXFu9iCadXePVju9EqwwTJyXd9oUaY?=
 =?us-ascii?Q?sUzpiSap5dqCX19EYRQGNJvnw0rF6/sM1hqAxEp9SCH7O2YhdFqllRoPsEW2?=
 =?us-ascii?Q?qpiqTYo8+pkZtSr0RzwDy2/9IoSn8GRpbWROPy1al/8l8QuM0T3aEFxbnO1Y?=
 =?us-ascii?Q?NkAniz8U2qvUVIbsA/MIU7qtbJ7+fyjNZawy7NocWTRcRVnU99FYHaB/4R2N?=
 =?us-ascii?Q?q2AsNiHGPYpefBpoFCBDtrzsNwaVEatZnLb9fXW0ebbETWvkA6HMN5gDZHOU?=
 =?us-ascii?Q?BZUbpVidydsKYyaBHiyV5gCIuyvVvROOGWS5z0X+TLn8MusazciIIpWqRC8x?=
 =?us-ascii?Q?awJuhxjvPtDp3O7XTuaXVXuexYYUXkZdVNzy0CMpMxFu+VekOFsVxazO+fmQ?=
 =?us-ascii?Q?kvMFhVdb8b/HG47z5/K77HTWveiGEEA8ocLkd0HaKL9khe+vMqBi/aTL17f8?=
 =?us-ascii?Q?R8C8Fn7XqYhBbnQCfuOxmhFjS0MakK6hllcsZTXRq8v1+DiOAoKIYzIEmm+U?=
 =?us-ascii?Q?KfKPN+7zBiJdiR/c9+wiCMXgggZkyez42SdZHQ8LaTurvgiL+wOzybBc0w+6?=
 =?us-ascii?Q?uFcK09APnJPOJAc1m1MFDwpnaSsZTbMjZKCODxPCB2QLcMOd/eS+R+dw6nMY?=
 =?us-ascii?Q?7VWuVqPMi8UIJpVC/QTrDdq5Dmp26Q8nGAJx29tRyqZa6MiHhTkoI/JyToZa?=
 =?us-ascii?Q?Uxd8rHxaCdIGIaEXXa4/WxW3ja9Rilq+vkQS8wm+CWXf1SnOMWt06SfjjHkH?=
 =?us-ascii?Q?AuHM9Rv8AcNyt0kNTIW66VCSSsWnxZXZoauzF3JWfS/XM3FlRc0itr09d17A?=
 =?us-ascii?Q?iFMv3Kb91utv4/7ss1ggCl2DOYzx/UExycKabiiZkmLo+h9KxNc73A0ORCxP?=
 =?us-ascii?Q?JHwCoesSBXRtd73nXGaba1VqOWYUdivDETE6oVajJYz9+Xn8OwHVDR2anFoB?=
 =?us-ascii?Q?GuQZmMrN5M6WHBNVsx1frb26Me+cKj4wfCZXRCfRkYp4CtXGSb14nB5zy4+y?=
 =?us-ascii?Q?IoJiDhUlagb3GrTri0MB2ZppuI5ZYiA77DaemwGyqTVF7KoD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb160cd-e464-45ab-66a9-08deb72ba654
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 11:25:23.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9LSPOwijOb1/I15nBPFdCAI68lIhHCmQY9Gt4vUBStPrUKW5bWTPFfEpoqDIjYsceNmEe+lo/1awfgraVtYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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

Best Regards,
Thomas
-----Original Message-----
From: Chenglei Xie <Chenglei.Xie@amd.com>
Sent: Tuesday, May 12, 2026 10:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com; zhigang.luo@amd.com; alexander.deucher@amd.com; c=
henglei.xie@amd.com; YiPeng.Chai@amd.com
Subject: [PATCH v3] drm/amdgpu: change VF RAS bad bage space to dynamic all=
ocation

The VF RAS error handler stored bad pages in fixed-size arrays. If the PF2V=
F block described more entries than fit, amdgpu_virt_ras_add_bps() could me=
mcpy past the end of those arrays.

Track table length in a capacity field, allocate a small initial table, and=
 grow bps / bps_bo together when count + pages would exceed capacity.
Keep amdgpu_virt_ras_add_bps() as the single append path: validate the addi=
tion, grow if needed, then memcpy and bump count.

On allocation failure the existing tables are left unchanged and the caller=
 stops ingesting more bad pages from the message.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 109 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |   2 +
 2 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..beb2693e4c704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,63 @@ unsigned int amd_sriov_msg_checksum(void *obj,
        return ret;
 }

+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY   512
+
+/**
+ * amdgpu_virt_ras_realloc_eh_data_space - alloc/realloc VF bad-page
+@data->bps and @data->bps_bo
+ * @adev: amdgpu device
+ * @data: VF RAS error-handler data
+ * @pages: minimum number of new slots to add beyond @data->capacity
+ *
+ * Return: 0 on success, %-ENOMEM on failure.
+ */
+static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *ade=
v,
+               struct amdgpu_virt_ras_err_handler_data *data,
+               int pages)
+{
+       struct eeprom_table_record *new_bps;
+       struct amdgpu_bo **new_bo;
+       unsigned int old_space;
+       unsigned int new_space;
+       unsigned int align_space;
+
+       old_space =3D (unsigned int)data->capacity;
+       new_space =3D old_space + max_t(unsigned int, (unsigned int)pages,
+                                     (unsigned int)AMDGPU_VIRT_RAS_BAD_PAG=
E_TABLE_INIT_CAPACITY);
+       if (new_space < old_space || new_space > INT_MAX)

[Thomas] Using INT_MAX as the upper bound check is too permissive. It shoul=
d be set to the maximum realistically acceptable value instead. The same ap=
plies to the other INT_MAX checks below.

+               return -ENOMEM;
+
+       align_space =3D ALIGN(new_space, AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INI=
T_CAPACITY);
+       if (align_space > INT_MAX)
+               return -ENOMEM;
+
+       new_bps =3D kmalloc_array(align_space, sizeof(*data->bps), GFP_KERN=
EL);
+       new_bo =3D kcalloc(align_space, sizeof(*data->bps_bo), GFP_KERNEL);
+       if (!new_bps || !new_bo) {
+               kfree(new_bps);
+               kfree(new_bo);
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: failed to grow bad page tab=
le to %u slots\n",
+                                    align_space);
+               return -ENOMEM;
+       }
+
+       memcpy(new_bps, data->bps, data->count * sizeof(*data->bps));
+       memcpy(new_bo, data->bps_bo, data->count * sizeof(*data->bps_bo));
+
+       kfree(data->bps);
+       kfree(data->bps_bo);
+       data->bps =3D new_bps;
+       data->bps_bo =3D new_bo;
+       data->capacity =3D (int)align_space;
+
+       return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *ade=
v)  {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data **data =3D &virt->virt_eh_d=
ata;
-       /* GPU will be marked bad on host if bp count more then 10,
-        * so alloc 512 is enough.
-        */
-       unsigned int align_space =3D 512;


[Thomas] If set align_space =3D AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACIT=
Y , can avoid to change so much code in this function ?


        void *bps =3D NULL;
        struct amdgpu_bo **bps_bo =3D NULL;

@@ -298,16 +347,17 @@ static int amdgpu_virt_init_ras_err_handler_data(stru=
ct amdgpu_device *adev)
        if (!*data)
                goto data_failure;

-       bps =3D kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNE=
L);
+       bps =3D kmalloc_array(AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY,
+sizeof(*(*data)->bps), GFP_KERNEL);
        if (!bps)
                goto bps_failure;

-       bps_bo =3D kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP=
_KERNEL);
+       bps_bo =3D kcalloc(AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY,
+sizeof(*(*data)->bps_bo), GFP_KERNEL);
        if (!bps_bo)
                goto bps_bo_failure;

        (*data)->bps =3D bps;
        (*data)->bps_bo =3D bps_bo;
+       (*data)->capacity =3D AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
        (*data)->count =3D 0;
        (*data)->last_reserved =3D 0;

@@ -361,17 +411,32 @@ void amdgpu_virt_release_ras_err_handler_data(struct =
amdgpu_device *adev)
        virt->virt_eh_data =3D NULL;
 }

-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-               struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+               const struct eeprom_table_record *bps, int pages)
 {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_dat=
a;
+       int need;

-       if (!data)
-               return;
+       if (!data || pages <=3D 0)
+               return false;
+
+       if (pages > INT_MAX - data->count) {
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: bad page table size overflo=
w (count=3D%d pages=3D%d)\n",
+                                    data->count, pages);
+               return false;
+       }
+
+       need =3D data->count + pages;
+       if (need > data->capacity &&
+           amdgpu_virt_ras_realloc_eh_data_space(adev, data, need - data->=
capacity))
+               return false;

        memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
        data->count +=3D pages;
+
+       return true;
 }

 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) @@ -44=
3,20 +508,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *=
adev,

        memset(&bp, 0, sizeof(bp));

-       if (bp_block_size) {
-               bp_cnt =3D bp_block_size / sizeof(uint64_t);
-               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
-                       retired_page =3D *(uint64_t *)(vram_usage_va +
-                                       bp_block_offset + bp_idx * sizeof(u=
int64_t));
-                       bp.retired_page =3D retired_page;
+       if (!bp_block_size)
+               return;

-                       if (amdgpu_virt_ras_check_bad_page(adev, retired_pa=
ge))
-                               continue;
+       bp_cnt =3D bp_block_size / sizeof(uint64_t);
+       for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
+               retired_page =3D *(uint64_t *)(vram_usage_va +
+                               bp_block_offset + bp_idx * sizeof(uint64_t)=
);
+               bp.retired_page =3D retired_page;

-                       amdgpu_virt_ras_add_bps(adev, &bp, 1);
+               if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+                       continue;

-                       amdgpu_virt_ras_reserve_bps(adev);
-               }
+               if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+                       break;
+
+               amdgpu_virt_ras_reserve_bps(adev);
        }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 9da0c6e9b8695..af2acf8eee6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -263,6 +263,8 @@ struct amdgpu_virt_ras_err_handler_data {
        struct eeprom_table_record *bps;
        /* point to reserved bo array */
        struct amdgpu_bo **bps_bo;
+       /* number of slots in bps[] / bps_bo[] (always >=3D count) */
+       int capacity;
        /* the count of entries */
        int count;
        /* last reserved entry's index + 1 */
--
2.34.1

