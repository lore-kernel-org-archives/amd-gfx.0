Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C05D2C115
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D0B10E5CC;
	Tue,  5 Nov 2024 14:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eRk6QTVa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2722910E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5Jp95QXNhmNReBjEEVLGxilH5yYEjDsEXxzsNSycpEjB8HMpUbwcemMgiLJ227MsFGgY7v0yyHCwjQgwjPF0kSs5gk+twZeThEif4Nw7GfcNxrhrWTE4mY8aZOIHAeuPF1PvGLt1zujhr/hnaBqVOYdu165mNygTGNJ/lFxPnbOWyTIZ5eL3ULR7QMPAol+7X7608m7q5Y/rR+W+wnEu9nJdHV4bgEMc47PCaYtJEfEtnvs2gs3XZAdKfEE+xatOvmfCQZptTGLnL5ufAKtE+DPaQ4CbRwVu+VHVtA4kQsii//NpLygqT6U0KuumQ7PzswjizFA/cX73Tzq6dNgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ErnXoa1zbru4qHJo9KakOjvJOM9+Ej2xX/qABdg5xk=;
 b=deEFmgBW2XQVaoIYh7MpUai5Sxhppm+aiPQpX1GASFDkVB+JGwuJIFFFHP1VjnZuD+TQ4zf7i4N2FsHpHTLRLLA6M9bSRYvrFIElm8X+6r93AdU8u09jlj+ktWo5bik7T5DMEdZwkgK6M4LVs9b02xB3lf9yuzmYSHOd5fUdCv2lK2M5IU7IZMv4BfG3atjCOussT30tcGIx8iR4R0puc4c5uSXvnMI9kMotCb8L1pxIyN3OhGHyR6IJ6LTSV12mnZWGr7STNoJVO/j1/yLHV1TTU7M/oPCSHpgzHyGUZoY7hfClIV+vvM3dwz04Td/iBPrCxl9P1azu9taFGOH/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ErnXoa1zbru4qHJo9KakOjvJOM9+Ej2xX/qABdg5xk=;
 b=eRk6QTVaii0vv8sSeNKUe2IOOuXJpZVwsV3HozgUGhWEEK99XsrdoUA2Ykjkw5JviaiU05eunq8a5q+zxc4MfXiOf1ljnv2CjK8rAr9uzdv0r2ef1s4EpGJzXdnyHymeL0cpbYeExGEYhyy55jE5VRfQso/CN79qbSjJNrb/WqA=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:48:35 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 14:48:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Poag,
 Charis" <Charis.Poag@amd.com>, "Cheung, Donald" <donald.cheung@amd.com>,
 "Khatir, Sepehr" <sepehr.khatir@amd.com>, "Oliveira, Daniel"
 <Daniel.Oliveira@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Add supported NPS modes node
Thread-Topic: [PATCH v3] drm/amdgpu: Add supported NPS modes node
Thread-Index: AQHbL38X6x83YlfklEGx3lvbk1rVBLKoxHIA
Date: Tue, 5 Nov 2024 14:48:34 +0000
Message-ID: <BL1PR12MB5254F8F66BD298432F2E5367FC522@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20241105123420.872322-1-asad.kamal@amd.com>
In-Reply-To: <20241105123420.872322-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=28d5b967-8c01-4014-a6a0-88cb1906485e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-05T14:48:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|PH7PR12MB6634:EE_
x-ms-office365-filtering-correlation-id: e1eebe0a-f08f-4090-dd41-08dcfda8ecd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HYTwx+glMHkrpGDxbRYJk+N4cb9+CidR7k+XvbpuVrZhPZHEauIM4WUo/ITQ?=
 =?us-ascii?Q?lhVS9Xn2OwKqwelIkraHR0wfPKqMgVSK/lTnpekKkA7EvL/aqd40B/PuFENS?=
 =?us-ascii?Q?sy56b7MS2SkOqX2inRtftYzAbrLpYX5FuFDBpzP0lwOuq/NEKM/9GceJGLxK?=
 =?us-ascii?Q?OGcyW4ldXphpB/+DyZev66bz+b6ni90SMD0y5nXuk+EQzgCJWQkFFAB1L5WI?=
 =?us-ascii?Q?s/e5fK6g/h7Q/Wrc76/DYArDe8Sq8yCXn0o6XaROfQjmSTK1zZf4yWXlzUFj?=
 =?us-ascii?Q?4Y/uZfc0rl6cN4inlxLUQcIeT3FXeKNDbDL+MMU8nlQtHfEX5kq9sXz7USI5?=
 =?us-ascii?Q?mtxskm9SgwSJxhmKNF7K0OIOfbOuEXMCJXSzU9tE/E0knTWzO/8Gzs5SjQLi?=
 =?us-ascii?Q?qw2Y2xws5NnS223UdqbPDm1lhqQ7AsrosT4NJmgAaAiI8wakvvXWdA5SCOzh?=
 =?us-ascii?Q?DdUHfmvmRVdUv6QXldCTtoCGJ7SBHSBWCUlaykxbZDssZV3DemAINxBovmlh?=
 =?us-ascii?Q?HX9ly29fyMvDWzSaGvRSXEgBrCz+zUgJVzjv+8qqnFOG7pb6eJVRbY2fbuEB?=
 =?us-ascii?Q?KkXdU6tuBQuiI7AbdssraMHU5c7Bt8VcblUajq7DKWdtcqtBaLKvYit7oO59?=
 =?us-ascii?Q?xevbzA13oQdPKdo2fsp4wKvgSlscafXjv0NnzM3m35T00FsXI/7kFUXLy1kE?=
 =?us-ascii?Q?sCJhNodaeYxoTX4UP0hd403sB1EAs5E1ioXMYqpJGMUanMI14aB2VlJnbXo0?=
 =?us-ascii?Q?NkrQwsMu8wGHffuStJP4goEy449+i9iXmtFrc2ypYl23uPcYZr86rhAci8lT?=
 =?us-ascii?Q?hc/3ML9zBwe06tjdRLEVVkvNNe+gsXzoxmOQ+dneKaWAS61AAE1cm3XidN7x?=
 =?us-ascii?Q?gVTVeyUtURy3HKfEhbSHtm0PzIu+0y+OVYzN4ketvepoI9siguPifPLmkBn7?=
 =?us-ascii?Q?vxXvIbk3Yw5Op2lEQHcTLBy1/3vQE2jSI02V+HURQP1yH0ramXRa91BfllbD?=
 =?us-ascii?Q?QSF6qJPUvL9Fc8Fczr36WpYeGMR2Knbdfs3+L4byFIKK/Xjp9nuTw09+93Ac?=
 =?us-ascii?Q?4Dot4q7a9hzOKD15Cvzh1VzQBn92WV0ybH2IU8KiyIKE7TJNkOQH4AY6d/PU?=
 =?us-ascii?Q?s1Pu/oSTPhqefoY0fsGgyrnl1V+EgTJXR58ht16ko0impBc5YhSNnkUgr3hW?=
 =?us-ascii?Q?diamSFlV6urcv0j3r61n9sudtWfUP/H3UY5gBvmUfXpcM4akxXr0EeVfSlvU?=
 =?us-ascii?Q?EiiQMJaYLCBdLV3DHiRD/iXuHWxHZT7k1bTlF4ddwaYc06xDPfrsdY6y8CJF?=
 =?us-ascii?Q?t4JJnD+xWdKV8drQbJ4ug2NXQTHwNqSDkPhgPwb5PmCDcEXvprNMdpol57pc?=
 =?us-ascii?Q?rQp+Vpk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gt9lf9B9iuRLyD37ayPsXZPjx3JVFMOss1dLG7z+9GjthHy+mUx0KSGt00BY?=
 =?us-ascii?Q?x/AIOM9R79SociqXaH0hFqSMzOeg0jNSzUc/dMfJdXnx5GGLHg2QUpgREF6A?=
 =?us-ascii?Q?5rlKF704YoYmPoLgidS2l4Z8AZb3Wh4NCZokBGPtJfAeEVqtcNnCDXP54vmE?=
 =?us-ascii?Q?/aS3TmTH0S2ixSeC9ljGAnrN4X/xWtOKygx2RPZloxLzchdTzw2hrMb3/Qac?=
 =?us-ascii?Q?BkhgAg6FoKxLO3w7NwjWTb8mb+EkXJXLTi952xz70y7WFuJRdsleJGI9UkNY?=
 =?us-ascii?Q?fU9Qha5h4TdwZ8sl5iLnwVxf4MgzoVMqBCDf2RHRhHrGpKmmiwwQpyYhsuk3?=
 =?us-ascii?Q?TAwJyOxoxGiUMoiBYx6WxHmvjpJv6Q0M8jr39JCbQeYRofnG8WXCrF/JTusQ?=
 =?us-ascii?Q?Co0CjrtyP6z/4eCbKJj/lbw3RjPPa/qo4cMpDzhfd7qxdRitNcMmC4RmCW9B?=
 =?us-ascii?Q?bplM6QgGtT3FteCOeI5nZ2Uq9ODlnIKR3sWS4tCyZDsLBmkNCvW2XrqXDkCi?=
 =?us-ascii?Q?DLoFNpHrN6DBpteJkyvbp/C/bNWf6fCGYLhyKh0Go/SMtNR3NjvNfSaZdTAA?=
 =?us-ascii?Q?/Gw0XeLAay33zAl1Oop0Bs7XUxpdYslx5oojYgL9SoJ9BlOVdUdm31Kmxcb3?=
 =?us-ascii?Q?5Kbehk3GJStmJg0SE6x2eTAHKHgyXDufYeZRNmkaVwkpecAB0RIsPhmHxm4E?=
 =?us-ascii?Q?rxw3T1M72AruIS+RxvSrIiw5WMXRO9JLxLd0PjsPP/R7pO01JZKjXBNXsQtK?=
 =?us-ascii?Q?DbYNRGDXAurtmI131L8Ouz6mKjAA3ZC3YPizE8EnoqzMxU9Snq8+z6UaY0nA?=
 =?us-ascii?Q?iKD761GI6iM4jvBRxuF9fHBJep6IOXI2iLhdf15Ij8b1/jZbDDOEfMJCvm2e?=
 =?us-ascii?Q?d5wI0wonewQtXABi8Jl9x59m0mars4YAiP340AcibklMP5OZd/sVIxXHUO62?=
 =?us-ascii?Q?9GdleVp2At1Upd3plMfMiZvwrZfzvMWL0Xj2TX3Q+uc0hbXlyFjZ8McVFmj7?=
 =?us-ascii?Q?X0KULY6gzke04PtIjjTxEUBWR/n2mwryoHexDsQ3PUQT3/cbIp5yae3zCNLM?=
 =?us-ascii?Q?A94o2Au+WBD6rJET616RBlkb8COAtVfxfoGtvME4oBm0aBAeRYyOq4Be87No?=
 =?us-ascii?Q?lJhffcBZwAYd0aC2YDn+/iz2vonaoc52ieYEYaP0QFiEhqWdejRxoEE6MXyb?=
 =?us-ascii?Q?ouGBTIVCQt8SRJjIz22iaBHBcAW2GowJAR5jfG7M6az6cT223LeRfZsS8vkR?=
 =?us-ascii?Q?G8UdD5BYEElUwOapxK0LDw+2KzVyF+WIWqJHmCwsaaRw0BZXW/jL8e4xME7n?=
 =?us-ascii?Q?m7+hs4dPGNLAnMFyiy+CD2Tv3cQW2CBg6Ajo8gM5B3ciJsQZzUiffGhL7w/9?=
 =?us-ascii?Q?il1wtt45J1zM43aQ/JD/KgoxfO3TahThNUCfMzc+b7/UxIiAJ0nqEuTyVxua?=
 =?us-ascii?Q?/TM5YUYjbY4BwujBX2by5x4TRN0T8BtmUQ0LRHBhCV14QlsYefygPp+GgWGE?=
 =?us-ascii?Q?I3hqpUx8v0tECEdkWJ84b039zWvMBisVdgd4O8HFJNwzEZ9aymFQD7CxFWCl?=
 =?us-ascii?Q?NFqESNRQKSUixNqFt2ROHxadiJeN2RiVm5PXTxVv?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5254F8F66BD298432F2E5367FC522BL1PR12MB5254namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eebe0a-f08f-4090-dd41-08dcfda8ecd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 14:48:34.9567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUt3vlCimZq5xmmXg/D5Oac5VuGdIyRf4pEwXmYmG7NRLZXwKIZizIqShF3eY3mb3RyauS85oApSuQDcR+I71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
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

--_000_BL1PR12MB5254F8F66BD298432F2E5367FC522BL1PR12MB5254namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, November 5, 2024 20:34
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,=
 Hawking <Hawking.Zhang@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Kamal, Asa=
d <Asad.Kamal@amd.com>; Poag, Charis <Charis.Poag@amd.com>; Cheung, Donald =
<donald.cheung@amd.com>; Khatir, Sepehr <sepehr.khatir@amd.com>; Oliveira, =
Daniel <Daniel.Oliveira@amd.com>
Subject: [PATCH v3] drm/amdgpu: Add supported NPS modes node

Add sysfs node to show supported NPS mode for the partition configuration s=
elected using xcp_config

v2: Hide node if dynamic nps switch not supported

v3: Fix removal of files in case of error

Signed-off-by: Asad Kamal <asad.kamal@amd.com<mailto:asad.kamal@amd.com>>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 48 ++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index 83a16918ea76..e209b5e101df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -471,6 +471,16 @@ static const char *xcp_desc[] =3D {
        [AMDGPU_CPX_PARTITION_MODE] =3D "CPX",
 };

+static const char *nps_desc[] =3D {
+       [UNKNOWN_MEMORY_PARTITION_MODE] =3D "UNKNOWN",
+       [AMDGPU_NPS1_PARTITION_MODE] =3D "NPS1",
+       [AMDGPU_NPS2_PARTITION_MODE] =3D "NPS2",
+       [AMDGPU_NPS3_PARTITION_MODE] =3D "NPS3",
+       [AMDGPU_NPS4_PARTITION_MODE] =3D "NPS4",
+       [AMDGPU_NPS6_PARTITION_MODE] =3D "NPS6",
+       [AMDGPU_NPS8_PARTITION_MODE] =3D "NPS8", };
+
 ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);

 #define to_xcp_attr(x) \
@@ -540,6 +550,26 @@ static ssize_t supported_xcp_configs_show(struct kobje=
ct *kobj,
        return size;
 }

+static ssize_t supported_nps_configs_show(struct kobject *kobj,
+                                         struct kobj_attribute *attr, char=
 *buf) {
+       struct amdgpu_xcp_cfg *xcp_cfg =3D to_xcp_cfg(kobj);
+       int size =3D 0, mode;
+       char *sep =3D "";
+
+       if (!xcp_cfg || !xcp_cfg->compatible_nps_modes)
+               return sysfs_emit(buf, "Not supported\n");
+
+       for_each_inst(mode, xcp_cfg->compatible_nps_modes) {
+               size +=3D sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mo=
de]);
+               sep =3D ", ";
+       }
+
+       size +=3D sysfs_emit_at(buf, size, "\n");
+
+       return size;
+}
+
 static ssize_t xcp_config_show(struct kobject *kobj,
                               struct kobj_attribute *attr, char *buf)  { @=
@ -596,6 +626,9 @@ static const struct kobj_type xcp_cfg_sysfs_ktype =3D { =
 static struct kobj_attribute supp_part_sysfs_mode =3D
        __ATTR_RO(supported_xcp_configs);

+static struct kobj_attribute supp_nps_sysfs_mode =3D
+       __ATTR_RO(supported_nps_configs);
+
 static const struct attribute *xcp_attrs[] =3D {
        &supp_part_sysfs_mode.attr,
        &xcp_cfg_sysfs_mode.attr,
@@ -625,13 +658,24 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *=
adev)
        if (r)
                goto err1;

+       if (adev->gmc.supported_nps_modes !=3D 0) {
+               r =3D sysfs_create_file(&xcp_cfg->kobj, &supp_nps_sysfs_mod=
e.attr);
+               if (r) {
+                       sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
+                       goto err1;
+               }
+       }
+
        mode =3D (xcp_cfg->xcp_mgr->mode =3D=3D
                AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
                       AMDGPU_SPX_PARTITION_MODE :
                       xcp_cfg->xcp_mgr->mode;
        r =3D amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
-       if (r)
+       if (r) {
+               sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr=
);
+               sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
                goto err1;
+       }

        xcp_cfg->mode =3D mode;
        for (i =3D 0; i < xcp_cfg->num_res; i++) { @@ -653,6 +697,7 @@ void=
 amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
                kobject_put(&xcp_res->kobj);
        }

+       sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
        sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 err1:
        kobject_put(&xcp_cfg->kobj);
@@ -673,6 +718,7 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *ad=
ev)
                kobject_put(&xcp_res->kobj);
        }

+       sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
        sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
        kobject_put(&xcp_cfg->kobj);
 }
--
2.46.0


--_000_BL1PR12MB5254F8F66BD298432F2E5367FC522BL1PR12MB5254namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">-----O=
riginal Message-----<br>

From: Kamal, Asad &lt;Asad.Kamal@amd.com&gt; <br>

Sent: Tuesday, November 5, 2024 20:34<br>

To: amd-gfx@lists.freedesktop.org; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; =
Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>

Cc: Ma, Le &lt;Le.Ma@amd.com&gt;; Zhang, Morris &lt;Shiwu.Zhang@amd.com&gt;=
; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Poag, Charis &lt;Charis.Poag@amd.=
com&gt;; Cheung, Donald &lt;donald.cheung@amd.com&gt;; Khatir, Sepehr &lt;s=
epehr.khatir@amd.com&gt;; Oliveira, Daniel &lt;Daniel.Oliveira@amd.com&gt;<=
br>

Subject: [PATCH v3] drm/amdgpu: Add supported NPS modes node</span></font><=
/div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">Add sy=
sfs node to show supported NPS mode for the partition configuration selecte=
d using xcp_config</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">v2: Hi=
de node if dynamic nps switch not supported</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">v3: Fi=
x removal of files in case of error</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">Signed=
-off-by: Asad Kamal &lt;<a href=3D"mailto:asad.kamal@amd.com">asad.kamal@am=
d.com</a>&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">Review=
ed-by: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@amd.=
com</a>&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">---</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> drive=
rs/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 48 ++++++++++++++++++++++++-</span></f=
ont></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> 1 fil=
e changed, 47 insertions(+), 1 deletion(-)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">diff -=
-git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu=
/amdgpu_xcp.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">index =
83a16918ea76..e209b5e101df 100644</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">--- a/=
drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+++ b/=
drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">@@ -47=
1,6 +471,16 @@ static const char *xcp_desc[] =3D {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_CPX_PARTITION_MODE] =3D =
&quot;CPX&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> };</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+stati=
c const char *nps_desc[] =3D {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [UNKNOWN_MEMORY_PARTITION_MODE] =3D &quot;U=
NKNOWN&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_NPS1_PARTITION_MODE] =3D &quot;NPS1=
&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_NPS2_PARTITION_MODE] =3D &quot;NPS2=
&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_NPS3_PARTITION_MODE] =3D &quot;NPS3=
&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_NPS4_PARTITION_MODE] =3D &quot;NPS4=
&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_NPS6_PARTITION_MODE] =3D &quot;NPS6=
&quot;,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMDGPU_NPS8_PARTITION_MODE] =3D &quot;NPS8=
&quot;, };</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> ATTRI=
BUTE_GROUPS(xcp_cfg_res_sysfs);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> #defi=
ne to_xcp_attr(x) \</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">@@ -54=
0,6 +550,26 @@ static ssize_t supported_xcp_configs_show(struct kobject *ko=
bj,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> }</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+stati=
c ssize_t supported_nps_configs_show(struct kobject *kobj,</span></font></d=
iv>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct kobj_attribute *attr, char *buf) {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xcp_cfg *xcp_cfg =3D to_xcp_c=
fg(kobj);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0, mode;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sep =3D &quot;&quot;;</span></font></=
div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xcp_cfg || !xcp_cfg-&gt;compatible_nps=
_modes)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return sysfs_emit(buf, &quot;Not supported\n&quot;);</span></font></di=
v>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_inst(mode, xcp_cfg-&gt;compatible_=
nps_modes) {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; size +=3D sysfs_emit_at(buf, size, &quot;%s%s&quot;, sep, nps_desc[mod=
e]);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sep =3D &quot;, &quot;;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;\n=
&quot;);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+}</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> stati=
c ssize_t xcp_config_show(struct kobject *kobj,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobj_attribute *attr, char *buf)&nbsp=
; { @@ -596,6 +626,9 @@ static const struct kobj_type xcp_cfg_sysfs_ktype =
=3D {&nbsp; static struct kobj_attribute supp_part_sysfs_mode
=3D</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(supported_xcp_configs)=
;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+stati=
c struct kobj_attribute supp_nps_sysfs_mode =3D</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(supported_nps_configs);</span></f=
ont></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> stati=
c const struct attribute *xcp_attrs[] =3D {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;supp_part_sysfs_mode.attr,<=
/span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;xcp_cfg_sysfs_mode.attr,</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">@@ -62=
5,13 +658,24 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)<=
/span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto err1;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.supported_nps_modes !=3D 0=
) {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; r =3D sysfs_create_file(&amp;xcp_cfg-&gt;kobj, &amp;supp_nps_sysfs_mod=
e.attr);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (r) {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_files(&am=
p;xcp_cfg-&gt;kobj, xcp_attrs);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err1;</span></fon=
t></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+</spa=
n></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode =3D (xcp_cfg-&gt;xcp_mgr-&g=
t;mode =3D=3D</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?</span></font></div=
>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SPX_PARTIT=
ION_MODE :</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_cfg-&gt;xcp_m=
gr-&gt;mode;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_xcp_get_res_info(xc=
p_cfg-&gt;xcp_mgr, mode, xcp_cfg);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">-&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sysfs_remove_file(&amp;xcp_cfg-&gt;kobj, &amp;supp_nps_sysfs_mode.attr=
);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sysfs_remove_files(&amp;xcp_cfg-&gt;kobj, xcp_attrs);</span></font></d=
iv>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto err1;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_cfg-&gt;mode =3D mode;</span=
></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; xcp_cfg-&gt=
;num_res; i++) { @@ -653,6 +697,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct =
amdgpu_device *adev)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kobject_put(&amp;xcp_res-&gt;kobj);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(&amp;xcp_cfg-&gt;kobj, &a=
mp;supp_nps_sysfs_mode.attr);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_files(&amp;xcp_cfg-=
&gt;kobj, xcp_attrs);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> err1:=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;xcp_cfg-&gt;kob=
j);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">@@ -67=
3,6 +718,7 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kobject_put(&amp;xcp_res-&gt;kobj);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(&amp;xcp_cfg-&gt;kobj, &a=
mp;supp_nps_sysfs_mode.attr);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_files(&amp;xcp_cfg-=
&gt;kobj, xcp_attrs);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;xcp_cfg-&gt;kob=
j);</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> }</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">--</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">2.46.0=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
</span></font>
</body>
</html>

--_000_BL1PR12MB5254F8F66BD298432F2E5367FC522BL1PR12MB5254namp_--
