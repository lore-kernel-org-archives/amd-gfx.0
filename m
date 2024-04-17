Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018D3C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 18:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DBF10F790;
	Wed, 17 Apr 2024 18:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qILFdI+G";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41AE10F790
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 18:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG+PchaeAoV0EmjbwOFG4BIDQsM/YGOde0PEauTvOUIBu22mftPvWg+TQlWREBNXr0FWtUtiP22052sjsqWQVXQjdatnFXkLSGaysRdc0tXIwX5LzbWtAHugwUkzhTPuq8Xbd4w2Ag3zBLOlmtnbBW076rOUii5pQK45/ruCyQv939uLIhBpAzT185UJUvnGSfnvYUjVC9O+7L06GhzOLoF+TDbKSZ7wJKYnbY/Mc0BZosfkJyHxdII8AQrsJKOVqPSVza2sp2TkZL3IgA8mZ3P4FrvHNSlZYBm/RTzR+qRjZPScVmd+bPvkVNFsXP5J9vt/fqLQyzYENqllBzy15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKeGZ66Sben+9edd5jhkI5+AjIHAN/Nl5u7BN6abIZQ=;
 b=PRSolD9O2rKWpGNvuC5mKPUUXxSDx+hngRHcfHktjRngLGDK0oCvRX+4KOrgdROMRvPDA/Hy6UwpZha1Buic4bFZx2oEDpEf6xdQOBK6IMp1fAjsa3Fc9rQnwVQK3EynGWs0GbLjT84Wka4shAAvo6QyvsJnGbmm+QTW+Tfphdb2JZNkvzwSjR0fjQBUtD2LraMb9HfzRkZDEk7AtGLhin+z4Q+RYCDZqKqTmJiUt0Kmfa9Ae48+UOhibZ/pyLdGysouV8l+JsSRzFV2ipmyB4YKdpk9RGsV3FHBrkghc0qs+wDy6uI30yvMTUdF7sz4kvTeTWmyhYpVOycdxb5bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKeGZ66Sben+9edd5jhkI5+AjIHAN/Nl5u7BN6abIZQ=;
 b=qILFdI+GflqzWH8SzqXCoWRpAiQc0Tc3CCHWEJ3LKiRgsCsyJ1bgkvKLBvknHe+v5zWH2E98HSKvmQUfPWSTIF1SRbPH7+MQzuSIvJ/4aDM0G6xP4YUkMbn5Ytcp2Xe4abwyxxf6PIn8yo0TRTl/OXiMRH51y5RnVDiSt+8HSH4=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 18:53:41 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 18:53:41 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, Leo Liu
 <leo.liiu@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than
 numbers
Thread-Topic: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than
 numbers
Thread-Index: AQHakLrMxOmnsszzJkmJM8PxEJiaM7Fsz2Ow
Date: Wed, 17 Apr 2024 18:53:41 +0000
Message-ID: <CH0PR12MB5372C26A2AD6C1170A788515F40F2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
In-Reply-To: <20240417113025.2886905-1-horace.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=34beb942-c038-45dc-a79e-f4240c50c74a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-17T18:52:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SJ1PR12MB6121:EE_
x-ms-office365-filtering-correlation-id: 5e825fef-8aeb-49e4-63cd-08dc5f0fb2ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXZxs52WYKcQOAgHMRNBZW2qKO5qngof0MaEaZ3MR+liDVDtjqaC3dYmiJ70+/PjNEugnvA5Mu/3cOp8jY8ycoQzWMG9JwAm+jdOgRWw9fQToA1sfwhAb7sypnqDvHjFKowdVHE3Z1vul0IZ70RWlp8Kk76JTRGEmBJ1PPI1WeG4VFtKhi9/i7Vlmq25M1s+mmNHpGPAQeWST9gvD4Lgo0gxCdHN8YRzPmh4c+c1q4qliicF3MXowMzX6jnFqpTV2WC1fIyr4f0O7YOajw47F1P90c5S4jnBSFU/ddxGFB1AqC/GL1Xhby3Wah6UqOhq9eXs9wyBSlwGcOO40iZg4GlhgbNvDN6C09fLujFqxHXt+ISQ9P16apWsCtxAsw8SCtcQpsnf02Y0laa8EZj2Rz9GA6WKXXpB46JzOsql07JvMPlKKLjVPIK+eRYUBVb0c0AQqjXCPkVNh71kx1lkvJvOPZJOZRE0ES6qKDHu2B4XDxT/YzwhcKh802PrsTp5cmdttDAc+ovUZXThiM1V2g0t95rpSvHK4vJ7QA7pturJxd97AEf8rV+0avnorbkwJlZ0GVLKnT+1aW+/xI9ar2NYeag7XjP5wFtz4GVEE8BgGQIoHw3I2V65DA0FHassID1rlFV34hfR0Xv90P9gyy3UIK0mBo+1dsE2vqPDtukvvzaQr8oXeEer6CNVvIZgfHIUFgHgRd2J5flFSgpErx7UVKjjihL8f7tv0TnA4kQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mOpkBTM5lX6JiPBQYgvIfy0+sWMtVTlJHtYvQ91drwy7A/pSGpm7WkWO+gnG?=
 =?us-ascii?Q?C92tjF245yIFKe4MQEpKXrebO4BvSqBPC8d4mF+NRVz8ToudKHjz05gNR4g3?=
 =?us-ascii?Q?WingemredReERPipIot7MuJN8nI98WpZ/ZlLeviiaZYfK04BSIbl8zgMVeHG?=
 =?us-ascii?Q?RDFNVDDnb2U4vDu+H1Ch6yorhtzwNQRMQeSaHIIpi8NHLFSgnLoV4uzrI+jt?=
 =?us-ascii?Q?mMLvEwE1eYwlGUFD+Z7p3ViMPmgyDv5IwArtwzeDm+rx5/ugF6Yc6vl2jMub?=
 =?us-ascii?Q?Qx+vdrPL70qV9rrP4HY9e2GXkvPHIGqgWBoB/MLN2ZbJZIAhhB0g5EjYxAVE?=
 =?us-ascii?Q?dABSnsGpcbPDil0mDNykEqdn6ZZ4yAvVaYbBc2C/jhuy0/l87eSI3jbWS7zJ?=
 =?us-ascii?Q?S8ik5mDDKM0OyOw8hSBya/6BJKJTsq4d3ZC/UKgVyRLfgqof00wVLKErQS3n?=
 =?us-ascii?Q?JowYwPyx0IU9zmeYrG+ST+kH5zcdMNGDi2ipUiEs4JTUhxbJSCo7ocx47bHZ?=
 =?us-ascii?Q?A6SgM5hiTIeENfj8L5j3QrWJQyFFpiAVlZOXX0spOSC9xljijOg4hzL+YFFw?=
 =?us-ascii?Q?FoXXKzbOSlHHjIJ2zJcvyA084nAc6C0F9UE+d8z3H+JoUiatO3dikSC6PrgH?=
 =?us-ascii?Q?omSa4eYl1HWj5vDlxD6JPlJ7kc35LDxaHkNKvcJVqLIh2lHebNKGKu25homY?=
 =?us-ascii?Q?VKtnVTcUKEoPQfL3kV14FErdvvKARnmkZIU4fdeKAmdkm8aknDdTXKgYxtW4?=
 =?us-ascii?Q?EjuYnqFLIpOB6PbviqDYqKPa99nes+IyhQhT+DbFJ0C+aSOmZmVqmjZUa62r?=
 =?us-ascii?Q?9H2CpCFzUH/fdC/X9JTO3yeDZXcITxxyeztCNQF1lu7/8HzE1DekwmkVXZno?=
 =?us-ascii?Q?Y4gEwpve5H6II07igAxS52TYvLgAkc2hOXA/EXiRRcGrF2M1/YTcWg6+8PzV?=
 =?us-ascii?Q?v5WgluAYBHdUu0LSFgrO7dZiv4tmHxfUKPQDqXhnuWaSXDDDCIjB9bY+RYtL?=
 =?us-ascii?Q?MsOVgNDv9KWAHA+V0expSPsCx59MGeHtHkyO+gmKl4aVqirSWLOf80SqJhp/?=
 =?us-ascii?Q?yGBwctV4kAAI6PLP+SijmfBwbwANYeQM1L686HWlWjFa2/KF5w+wdllMw10w?=
 =?us-ascii?Q?2fmuvgn/mLNxxbJPsxLY7IJPb3/uN9usD0Wu9frIxsm/1tlfOHhz6KNd4p0k?=
 =?us-ascii?Q?F9YAkDmud/81NH5+iQHxVq3Weq2lyfjMGnD3qC8IS4zSOXmtc+i3RmpOStvw?=
 =?us-ascii?Q?I9Xw8ncdhKaUptZnhpcIpR3Wqtb23Z3Kh5KIJGK+2869KZSrRA8K5W+Ymoj9?=
 =?us-ascii?Q?5CuEEuGBuZ6YV5+9tF1wtKrbb87h8XVKZQXv8+5t2nV+nl87mX1usQ1gmxUP?=
 =?us-ascii?Q?I8RkKMguc5dPHnOeI9kBBy5KbQAf9ZiFBrBjAGewMqhO4mQ0BsgEDK8+DKoZ?=
 =?us-ascii?Q?Kc73OslfhL8OXYfTFnYG236XCPvGx6P8X1TW4fVhciCufkz+TSrcz7zU6unA?=
 =?us-ascii?Q?9aRq5yLlLfXMVehXyAxukztPH7AyHtWjTjOUix2MEUdSNhW7u+5Ic7ckniFw?=
 =?us-ascii?Q?YP/f7/Gjp3q5fgSeFYw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e825fef-8aeb-49e4-63cd-08dc5f0fb2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:53:41.0341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y68LNt8ewSuQ4MPEExVEkLSwFqy3rH/VI06iQ/dXTP1sJ//M/bI3nBXcgGatIfhDPt3q3z/M072pgBKHfj3z7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

[AMD Official Use Only - General]

Looks good to me .
Reviewed by Shaoyun.liu < Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Horace C=
hen
Sent: Wednesday, April 17, 2024 7:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Kuehling, Felix <Felix.K=
uehling@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xi=
ao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, =
Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <Hai=
Jun.Chang@amd.com>; Leo Liu <leo.liiu@amd.com>; Liu, Jenny (Jing) <Jenny-Ji=
ng.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than number=
s

From: Alex Deucher <alexander.deucher@amd.com>

Makes it easier to review the logs when there are MES errors.

v2: use dbg for emitted, add helpers for fetching strings

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 81833395324a..784343fb7470 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_=
funcs =3D {
        .insert_nop =3D amdgpu_ring_insert_nop,
 };

+static const char *mes_v11_0_opcodes[] =3D {
+       "MES_SCH_API_SET_HW_RSRC",
+       "MES_SCH_API_SET_SCHEDULING_CONFIG",
+       "MES_SCH_API_ADD_QUEUE"
+       "MES_SCH_API_REMOVE_QUEUE"
+       "MES_SCH_API_PERFORM_YIELD"
+       "MES_SCH_API_SET_GANG_PRIORITY_LEVEL"
+       "MES_SCH_API_SUSPEND"
+       "MES_SCH_API_RESUME"
+       "MES_SCH_API_RESET"
+       "MES_SCH_API_SET_LOG_BUFFER"
+       "MES_SCH_API_CHANGE_GANG_PRORITY"
+       "MES_SCH_API_QUERY_SCHEDULER_STATUS"
+       "MES_SCH_API_PROGRAM_GDS"
+       "MES_SCH_API_SET_DEBUG_VMID"
+       "MES_SCH_API_MISC"
+       "MES_SCH_API_UPDATE_ROOT_PAGE_TABLE"
+       "MES_SCH_API_AMD_LOG"
+};
+
+static const char *mes_v11_0_misc_opcodes[] =3D {
+       "MESAPI_MISC__WRITE_REG",
+       "MESAPI_MISC__INV_GART",
+       "MESAPI_MISC__QUERY_STATUS",
+       "MESAPI_MISC__READ_REG",
+       "MESAPI_MISC__WAIT_REG_MEM",
+       "MESAPI_MISC__SET_SHADER_DEBUGGER",
+};
+
+static const char *mes_v11_0_get_op_string(union MESAPI__MISC *x_pkt) {
+       const char *op_str =3D NULL;
+
+       if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+               op_str =3D mes_v11_0_opcodes[x_pkt->header.opcode];
+
+       return op_str;
+}
+
+static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC
+*x_pkt) {
+       const char *op_str =3D NULL;
+
+       if ((x_pkt->header.opcode =3D=3D MES_SCH_API_MISC) &&
+           (x_pkt->opcode <=3D ARRAY_SIZE(mes_v11_0_misc_opcodes)))
+               op_str =3D mes_v11_0_misc_opcodes[x_pkt->opcode];
+
+       return op_str;
+}
+
 static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes=
,
                                                    void *pkt, int size,
                                                    int api_status_off)
 {
        int ndw =3D size / 4;
        signed long r;
-       union MESAPI__ADD_QUEUE *x_pkt =3D pkt;
+       union MESAPI__MISC *x_pkt =3D pkt;
        struct MES_API_STATUS *api_status;
        struct amdgpu_device *adev =3D mes->adev;
        struct amdgpu_ring *ring =3D &mes->ring;
        unsigned long flags;
        signed long timeout =3D 3000000; /* 3000 ms */
+       const char *op_str, *misc_op_str;
+
+       if (x_pkt->header.opcode >=3D MES_SCH_API_MAX)
+               return -EINVAL;

        if (amdgpu_emu_mode) {
                timeout *=3D 100;
@@ -135,13 +189,29 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
        amdgpu_ring_commit(ring);
        spin_unlock_irqrestore(&mes->ring_lock, flags);

-       DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
+       op_str =3D mes_v11_0_get_op_string(x_pkt);
+       misc_op_str =3D mes_v11_0_get_misc_op_string(x_pkt);
+
+       if (misc_op_str)
+               dev_dbg(adev->dev, "MES msg=3D%s (%s) was emitted\n", op_st=
r, misc_op_str);
+       else if (op_str)
+               dev_dbg(adev->dev, "MES msg=3D%s was emitted\n", op_str);
+       else
+               dev_dbg(adev->dev, "MES msg=3D%d was emitted\n", x_pkt->hea=
der.opcode);

        r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
                      timeout);
        if (r < 1) {
-               DRM_ERROR("MES failed to response msg=3D%d\n",
-                         x_pkt->header.opcode);
+
+               if (misc_op_str)
+                       dev_err(adev->dev, "MES failed to respond to msg=3D=
%s (%s)\n",
+                               op_str, misc_op_str);
+               else if (op_str)
+                       dev_err(adev->dev, "MES failed to respond to msg=3D=
%s\n",
+                               op_str);
+               else
+                       dev_err(adev->dev, "MES failed to respond to msg=3D=
%d\n",
+                               x_pkt->header.opcode);

                while (halt_if_hws_hang)
                        schedule();
--
2.34.1

