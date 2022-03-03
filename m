Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64226C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 15:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C5C10E6DB;
	Thu,  3 Mar 2022 15:33:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C54010E6DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 15:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlDXXY857CfnyQWvdZPSZnwZNPd9mWkQ5qzxH9r1GHWMYzl7GB+PnI45m3zw1XQXXe8ZujnZkKZiUDSeiC2v7FbFy6qEJHJFbjdY7BdlIVSRmc+71EXMN7viH7Gi/nfrcwHKrq9gWntpbIHkdEFz5hsKCQxjMDbAuDzzyUI3y1iXjZdbnC1kFb/A3w2Unuh4d8pPaDJK6ixcFHmyNb3mToIdANhBjDIY9ZOVhLJX4UUW61gA9RbT0UaYu+kSpycIVjRwFxNREwUFSdr5nm9+opBtKEuAT1gQpDH3JlJsINkkEUzw3f/L54Z2Hk8NX0qNxdXkmph2ZxmFA8LmMJoJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IIckRW+8ImBlqo48MHU9CO0Dkr6P5MDJaX4KWpBHTc=;
 b=Yi8uB+U3QaMZUzdxjaPYRBnRSmaizawDQlCo0AxkhPxfoTP4PpN2zMH11rCj4vR9K/iQECxEz3QxcD+uosV+kP5YhZjGgc6Vsf7wQByKbC/PMIJvDLfgixEuTVw5avQef4ATLJiS6GYx+R2HfXFw/KG8/qH6LfrRWc5oeMKW7NusqYMkCMLh4+5hPkVXYJ+fRE16cnl/l7oQmtYltOKNz05gBQXTlNLe5RG0ScmM3Pjwqw3KWNZ5OdMfEAtOniRj2wNN8JHqtrhiW3W+O8M3vULfOqOKdPkiZRQ5B1hp01RhYQrYN7Qa6C/iHwX4Iqi7adRGftBwEnD7WHnymeRZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IIckRW+8ImBlqo48MHU9CO0Dkr6P5MDJaX4KWpBHTc=;
 b=NYmFi+at3FcPgM47XqfjrZ+VryjM6xG2AfMbc1ICz984upckzbiPV7GsUhgoujo7GOrSnMUvPzTbeG+PDKSfPTtnRTREEZI/6nIW8c6haPgtsiI+1HY6IrDJV4iJX2B25ljUQpKWvTy5EPa+fmieEfxrwjUotrjekQt2zoo7Qp4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 15:32:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 15:32:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: implement get_atc_vmid_pasid_mapping_info
 for gfx10.3
Thread-Topic: [PATCH 2/2] drm/amdkfd: implement
 get_atc_vmid_pasid_mapping_info for gfx10.3
Thread-Index: AQHYLtWJBNI5CBA9S02S0K1cKTV6xqytyZ4y
Date: Thu, 3 Mar 2022 15:32:59 +0000
Message-ID: <BL1PR12MB51441441EE693D913349F4E7F7049@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220303080514.680150-1-yifan1.zhang@amd.com>
 <20220303080514.680150-2-yifan1.zhang@amd.com>
In-Reply-To: <20220303080514.680150-2-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-03T15:32:58.349Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: d6f8572b-72f7-1f81-7a7a-8d26c9aca421
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee9e7fbb-bcd4-4d83-6e38-08d9fd2b191e
x-ms-traffictypediagnostic: CY4PR12MB1159:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1159FCC13719E9AF87C198B7F7049@CY4PR12MB1159.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZcsDGlQF64kKs2hYeermYFzJgPqkLx18vp6Woxyq/NRLWETogpozm/yc4OaXkinUVhEfSupAi+ajCEVreqjkyDFNUwgNYNE2Hk1kQCmxva8ksEAsjvL5t3SfyJESoWI7+s3JboRiZM4H6oaVdQZ4L+o4jzKiMdID8NagYhTp3qsDqTL1i+8/fpgM7EA2OlCuMWcJwXgPBRNuCV5C3eDj2ZpbcK7IWF9myxmQoD0Arf6r6/Xd326eKVpr0p/X95bl2c0GG8U2ZMp7N99VnoX+AMEvTbMAcO9x3JzO0YZFedLQo+WCZ0/y8D2f4J+a3OFlINi2GrDatexulSxLPD3ScH6Xqf6N0VgzNOoQp2Lb2WypirsqJOnS4iunxJEF+MZJ+gviL9ju2ywq/J0ZSESCVnwTFjuqDaAhDtCdW33ke1a69nl5dRCwME+bJYR2n6WNgC+VbAoiHW8iLlvIJR3wAsS4hy9HrQJFH6NPlNdjCg6Qa1BfThVRLNia6ezfTqKWgbv7EEVnMDzBg+dlumVdCtr1nPBBW3MYmk4+ysM8hlXR3DeT+LnlvGQKPRw9mYmgLoujzt/ZhnVyDHLAibnM46tLChN9rmlEN6ME0X7yTM+A18qbC5xZ9f0BMQxtde/IaKim3wR6K4EoQWI5IvHMCpuofc5elxmKpmnBTEZVECGq3XFvc5YCsCYUa8EcSQ5VGO7vYOASCUQKLOZiFKOeJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(8936002)(52536014)(5660300002)(38100700002)(316002)(122000001)(19627405001)(110136005)(38070700005)(76116006)(8676002)(83380400001)(71200400001)(66476007)(26005)(66556008)(66946007)(33656002)(4326008)(6506007)(186003)(508600001)(53546011)(2906002)(55016003)(64756008)(7696005)(66446008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?weT/zqbcthqJVH3toBM3NY360I7IsK+0Huc+ILmNcwsvQNEIugVN9NyJOgR/?=
 =?us-ascii?Q?QGdqR/vvAVKgLF3DbKlBIKYir+9blvyfPfz5fGyumsrwvLsuJRA4ymcnVuU9?=
 =?us-ascii?Q?lCM/arcBdCiX/zBLhp9Y6q/Z9or+Vyg/6F9MqIYbXT8zSOBjixsidJqDwYhv?=
 =?us-ascii?Q?EqN2tqAZd/CQ97p47RrZMTOS5frjpq+yZpZR3VlOR12hKp1WRCAZ+1fmFgdN?=
 =?us-ascii?Q?Qp6Sw1lQXUpF1XV8wjun5E9w2CVsCCwGK1rYTaKt7R7oXm9EFyGv/K9L5ugi?=
 =?us-ascii?Q?MrJrscJood5e23rkJttaa7MA1PPCbcsLuO+2E6U22ZpXYv6yaxe/owtzvs2W?=
 =?us-ascii?Q?0ouDW6MpY42pC0fkcwkDKrLrLn3/NW7OE4rrNme+veP7VmONLvT4ons8sA+v?=
 =?us-ascii?Q?9ozp+z2p9E06qN3thXiOoAtzbrZBguLCJDrknmEtZNu7a8996XPCJq8Ly+6v?=
 =?us-ascii?Q?oDwsY3r/yJv1ObAjGky+3w+9bC5JO9Nx3adf/m9Wo1oxpq3C/JBx3ipLJmZB?=
 =?us-ascii?Q?7FIbfFKgjFnIp8zRi9qUm8tf/yZFgTbzoIRLZsN/g7WUTUuSfsTmex+tDmff?=
 =?us-ascii?Q?F/6jrQTCqNNaMyl/UmEy6ZucbPC9Fc3lRSCGic6dmj1EUas8RI0UdqkwTxaV?=
 =?us-ascii?Q?Tovz9VSGZz9alzqBbGKRSFV+etU02klM/irg1ckxfMT5XjlmC1/fpH4FYy3A?=
 =?us-ascii?Q?M0NT7v984TqhfpaSbzu9BEx5axxDqOhncdPd9pv+Dg9ogda+lXQBo8YBp84N?=
 =?us-ascii?Q?h2IJqGK543LJsz091yp/YqqwPZzuodPvlNRs4+EtMfANr2ZeQ30gQWwPzltX?=
 =?us-ascii?Q?gOkMCkFw5PRqo5jRi+MtQv+S25d1Qc54edZB+kqA2M5pPsarZlsfAAidFj5V?=
 =?us-ascii?Q?Ma0cpkuVul6RCP+4qHerk8BFqRntXf+zr75uB7JxmiGj7nv3oxyzrnWPQdCg?=
 =?us-ascii?Q?9C8HxP048+dBqAHoy+of6tHt2OF9fr1A+V6zzzZLzPGh3KYOZ9AH3R9v9edY?=
 =?us-ascii?Q?+RKb4mrplYgj+1I3U5PU5p/J8/PcutqK7Emz4Ktm+umVKTyn6X+wifWbNnNL?=
 =?us-ascii?Q?cJjeYt0OqFGx9ftYWG1kzHEFZI9B7h08qO2G7hsxZKtR1y/HZcDPX1tGTzF9?=
 =?us-ascii?Q?Ngd/fS/YhwOH0Ydv6RfPI52WLUwvkzLcyp08pyJEMMBYISkZeOZvgX7rNOZX?=
 =?us-ascii?Q?xsmKeMgudXdQ+nptsWnTyhdBwrUTCUyArI3tQyNfstSX0wp0+oj/r5KmRQfe?=
 =?us-ascii?Q?ImFaFzKIHsRxkoaGiD9+8KmTiHHTMfLNMSZ8wl8IXTYXVYF8aYkdu+qREZpI?=
 =?us-ascii?Q?g/yi4DweEl8yQ7/7gel5niZTXL/0oDuVwngK1JPc9Cz9DgeM4fsLXGZ8Mq7W?=
 =?us-ascii?Q?vJwfrSy8YASqSPV4csTM+nWRBXyDgfUo6ubi90kHm/y1v3eU8Rooeka0aeQA?=
 =?us-ascii?Q?Ep1en5Avcp7n6FbcNy6m8C/4rsY+qVDOVJfH3JA3jRVOPgilSx90tBA/zLgd?=
 =?us-ascii?Q?mqiWghhsXsI9AIGJiGFOyKWufwXhm64/SsDCgepbjlIRynbg286qIs0zGQGp?=
 =?us-ascii?Q?BgcHtFnc8HZSsJt2mGSERqg61QMZiS0x2dEs2libe1PsEIHRbJvx7wx82vrx?=
 =?us-ascii?Q?2269MMUfalH5vHh7PkQfDmI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441441EE693D913349F4E7F7049BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9e7fbb-bcd4-4d83-6e38-08d9fd2b191e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 15:32:59.5075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9iOQERKrxlQdt7Zf6yJSTBzxPqGBGY7vT2I8JM9KsCQ/pnU9u4aYbLEmWpuReiE8TJM6A74Sdw2TWmRUFgVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51441441EE693D913349F4E7F7049BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Thursday, March 3, 2022 3:05 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@am=
d.com>
Subject: [PATCH 2/2] drm/amdkfd: implement get_atc_vmid_pasid_mapping_info =
for gfx10.3

This patch implements get_atc_vmid_pasid_mapping_info for gfx10.3

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index e9c80ce13f3e..ba21ec6b35e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -26,6 +26,8 @@
 #include "gc/gc_10_3_0_sh_mask.h"
 #include "oss/osssys_5_0_0_offset.h"
 #include "oss/osssys_5_0_0_sh_mask.h"
+#include "athub/athub_2_1_0_offset.h"
+#include "athub/athub_2_1_0_sh_mask.h"
 #include "soc15_common.h"
 #include "v10_structs.h"
 #include "nv.h"
@@ -606,6 +608,18 @@ static int wave_control_execute_v10_3(struct amdgpu_de=
vice *adev,
         return 0;
 }

+static bool get_atc_vmid_pasid_mapping_info_v10_3(struct amdgpu_device *ad=
ev,
+                                       uint8_t vmid, uint16_t *p_pasid)
+{
+       uint32_t value;
+
+       value =3D RREG32(SOC15_REG_OFFSET(ATHUB, 0, mmATC_VMID0_PASID_MAPPI=
NG)
+                    + vmid);
+       *p_pasid =3D value & ATC_VMID0_PASID_MAPPING__PASID_MASK;
+
+       return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
+}
+
 static void set_vm_context_page_table_base_v10_3(struct amdgpu_device *ade=
v,
                 uint32_t vmid, uint64_t page_table_base)
 {
@@ -788,7 +802,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
         .hqd_destroy =3D hqd_destroy_v10_3,
         .hqd_sdma_destroy =3D hqd_sdma_destroy_v10_3,
         .wave_control_execute =3D wave_control_execute_v10_3,
-       .get_atc_vmid_pasid_mapping_info =3D NULL,
+       .get_atc_vmid_pasid_mapping_info =3D get_atc_vmid_pasid_mapping_inf=
o_v10_3,
         .set_vm_context_page_table_base =3D set_vm_context_page_table_base=
_v10_3,
         .program_trap_handler_settings =3D program_trap_handler_settings_v=
10_3,
 #if 0
--
2.25.1


--_000_BL1PR12MB51441441EE693D913349F4E7F7049BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yifan Zhang &lt;yifan1.zhang@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, March 3, 2022 3:05 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: implement get_atc_vmid_pasid_mappin=
g_info for gfx10.3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch implements get_atc_vmid_pasid_mapping_i=
nfo for gfx10.3<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 16 +++++++++++++++=
-<br>
&nbsp;1 file changed, 15 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
index e9c80ce13f3e..ba21ec6b35e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
@@ -26,6 +26,8 @@<br>
&nbsp;#include &quot;gc/gc_10_3_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;oss/osssys_5_0_0_offset.h&quot;<br>
&nbsp;#include &quot;oss/osssys_5_0_0_sh_mask.h&quot;<br>
+#include &quot;athub/athub_2_1_0_offset.h&quot;<br>
+#include &quot;athub/athub_2_1_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;v10_structs.h&quot;<br>
&nbsp;#include &quot;nv.h&quot;<br>
@@ -606,6 +608,18 @@ static int wave_control_execute_v10_3(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static bool get_atc_vmid_pasid_mapping_info_v10_3(struct amdgpu_device *ad=
ev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint8_t vmid, uint16_t *p_pasid)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D RREG32(SOC15_REG_OFFSET(ATH=
UB, 0, mmATC_VMID0_PASID_MAPPING)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + vmid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *p_pasid =3D value &amp; ATC_VMID0_PA=
SID_MAPPING__PASID_MASK;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !!(value &amp; ATC_VMID0_PASID=
_MAPPING__VALID_MASK);<br>
+}<br>
+<br>
&nbsp;static void set_vm_context_page_table_base_v10_3(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint64_t page_table_base)<br>
&nbsp;{<br>
@@ -788,7 +802,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hqd_destroy =3D hqd_destr=
oy_v10_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hqd_sdma_destroy =3D hqd_=
sdma_destroy_v10_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wave_control_execute =3D =
wave_control_execute_v10_3,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mapping_info =3D =
NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mapping_info =3D =
get_atc_vmid_pasid_mapping_info_v10_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D set_vm_context_page_table_base_v10_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_trap_handler_sett=
ings =3D program_trap_handler_settings_v10_3,<br>
&nbsp;#if 0<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441441EE693D913349F4E7F7049BL1PR12MB5144namp_--
