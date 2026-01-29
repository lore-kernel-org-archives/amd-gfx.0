Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AC2D46BF0
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 02:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C42F10E7A3;
	Thu, 29 Jan 2026 02:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQVbuBD/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1A510E7A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 02:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IendKh003+qabIhXaFqIAmkKBZiq2cjNL1cRRplfK7iRXX4iHTQ5lkJXvm0usJ8TXx8RwDFc52zN/asxWutuxxgss2uiHHN+7wFD37X0SXc1PgAFA0eZj7M/6Pb1OmpZvAD8gnKYGkdJzxX8eQaWTKYB10MIXBg6inBbxZ2jrMJraBYV7vAuS1aVmkyggyfEaS/9WVRGRSiUtCCQBP1STWqHEZk8WAku+FB8CFbnPZYo2rBmsgo1pf9Ks89TqoeURH5OxM3ESQ+hPOgtiNgYquhf4uKE18wftaF/HjUPsJf8zLxdWnrLQXrrxJALytRZqsZCkZ40ObplRJBO7DWkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BvjArYbM424HS8NMHSE0HW2vQasxl9kuZ+HRrJfHvI=;
 b=E0bX5h83AYL8N8Pol5KZ4g2SUwbL0jMZicKV2kQ1dJrAPDsItoX3dyweopuJ4/9Zec82L3DKiaOT2pRyeVvrki2rCFuBB3KQA9cNA1k36C5frpOq5L/JEwHGuFeG0TpxD1ujBqvpnjW2UrDNMnZqLhjalWIwDAx4hkEQ1lCKt+RzObqWhf0HnFG0yaev5LBZQW2TNnoEq2fufcNuX61YDp0Qbw4QVSBAwKZSIMvPHGYdYf4He6BqNrjXBK03sulTrfWtVstpFB0/QdY9IrNnBcNjDAXlwX9jXjRCGjz2DRiG+GaeB144uU5fqRK5QKnyZpPNOsmRhhgKoHl020vG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BvjArYbM424HS8NMHSE0HW2vQasxl9kuZ+HRrJfHvI=;
 b=MQVbuBD/OUjAysXw0Bqi0xJOJjKJdfZP6/pBCk9gPh7ZXMX4WGZCXHjuvLKhdVaNIknxe7bPWwOF9Nv7JAoJez/RkUuAS8YHQiQ4GCeU9HVAcbxRBX9CWnoTu4uuIqqfZCJaLh4TJjE2Il06Nd7F1C38ThSLby68sCAbsEskvqM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 02:30:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 02:30:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras
Thread-Topic: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras
Thread-Index: AQHcjnfZFwsBPKgZKUenU/OTciXrwbVocM1A
Date: Thu, 29 Jan 2026 02:30:11 +0000
Message-ID: <PH7PR12MB59971AF2D0DC9FBB360C764D829EA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-2-ganglxie@amd.com>
In-Reply-To: <20260126035527.1108488-2-ganglxie@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T02:27:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7371:EE_
x-ms-office365-filtering-correlation-id: a5203a55-62c7-4913-005c-08de5ede53d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YMA5sm5h/nrEXUzjTvAM7tWL47JKW0yExykg/jWL8nGbo1vUYSFPfPY6kxxL?=
 =?us-ascii?Q?IMdziFdTOku6QVPpGT/d3MaAr89ac3JxsTFmHiwtj8s5yqDBvCrRiijX3ktg?=
 =?us-ascii?Q?IVHZqRsq2tbb9XALwBE3AGZZpRbWkPqLVqS7db+wurght1w2GBTx4qU4ftPB?=
 =?us-ascii?Q?I4qZXLgPa44poaSim57TWU9UWargTGgSJIs50R6kNUg4v+9N2vN/NpIIqr7N?=
 =?us-ascii?Q?ecgiBulqDVVs2y8kvBWHq54Mg050tYzPKrhH/2nQ3IxDSp1FKk4D2BwBpef1?=
 =?us-ascii?Q?MMAAO6bnb8VXHab12ZTTD6sUOeOcj66uaE0MjJdgA8huzgKypESRP7FHhTvp?=
 =?us-ascii?Q?bKee5kt7ukzI14tzNPPN72Cmg9hlZcUZj/Ly8w+31bLFakt+52LmmCSamMm2?=
 =?us-ascii?Q?+CvSoKsyHdtIQD9VNyl+zAmVcg5FF5aVve2TdW3J0G8qgBjz5rBgVwvlQwZQ?=
 =?us-ascii?Q?omyY3imEzX54PYMDJ/7a7tLXcBkUekfeesjCCv9insR+U4D8rWSp9pCngt7J?=
 =?us-ascii?Q?pqIZZc584gNSMdqceB56W8quTn6zgtKKAQEtPvQZGltizM/sDS/xLhjvAE3q?=
 =?us-ascii?Q?bqG96VgIInjXBRuPm3zjI1hjAxPZSvAnD6x8amzVnQ9/a9f+a7h36VVcPfLy?=
 =?us-ascii?Q?HovVfPkODjNlTOoMHvCP/rxvsWO1QoIJBf3kpZHlnjnLSN678aJ2MeG2HJVN?=
 =?us-ascii?Q?iMgFUc5otii88g1ljmPiE+t2Qc793cnsRiR9voxgfUeBPXuUJYBaO+mOg5XB?=
 =?us-ascii?Q?69ENPdHZcMK3KgVI7g6CEbTH/olLbavOq+VH8ohzV0bmJ4r3aezPXlpn2yy0?=
 =?us-ascii?Q?wsbjR0/jioiGe3VDX2bRf9Ge1pgNvKueM8F72H4+DjovE6Wv0H8oXeZZLASB?=
 =?us-ascii?Q?gAZbSNYq1Qqs1YUwScVT974t4fLtsg9NKwiOra+gVdZL1k7znrJ+YyIndx2U?=
 =?us-ascii?Q?YYRlH3sedPJqhCIoDr2Zzx5lCYRQLzxexYEbp7MHjzzAlPKlv+qkfDnXL8Pk?=
 =?us-ascii?Q?hshezOCry+TEEzhRgHcbAnTQ55Y18FZN4Zra2nvqPZVEA4HzNiAEhK+Bh/oZ?=
 =?us-ascii?Q?zYszC8MPI42ZGSgGCXMyWWKX+2EgmHalob2oveIjCBkSf8HNQW/GccJBKhgf?=
 =?us-ascii?Q?lMrvRu7CQNUSJsMvklKbexCMIxM4NBbMx2584X6PG29lnlw8ATRzcU2VNf6T?=
 =?us-ascii?Q?WKFdlpdvRs1ZfZtMJ8trkPshcyWqIbxf7ROhnyJMLUD0h6VInUtSODN0JJR3?=
 =?us-ascii?Q?F/pdNzZBYywtgO1sM63nzoRE2yL6Acz8dJynWQFDi7raz63PhRVmL3l+ZRH9?=
 =?us-ascii?Q?SICh2WFVnxO86DH9+opFOYQYmNkVntN21xlzO/DXF/w/HHuzuO/tlzi401xq?=
 =?us-ascii?Q?s20FHtBxRlDHqwknVwhqcg9nPJe3Ae8N12e8g8qNwhMmLkY7bVGgf0CIwxXy?=
 =?us-ascii?Q?T82rbWoLVXvLAK2l0c2SUf0U8JhP5dG1Eh7ji3PN6cZIhW7FomB9ADdYT+Xf?=
 =?us-ascii?Q?IMbErKZRUdAp1OHM/WwCKp7jMa7LNbyVPAPwGPK5seqMU7c/BbEvfSSyHZoG?=
 =?us-ascii?Q?n3gWAZRr06G5FjZzCB9q/jV+F/AnyFFKNS5HxsFE+aW8Gm05Ztw26feFrnlb?=
 =?us-ascii?Q?c38hMoZXOJn9na+cGyZWEUU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/N5GukGChQmArCLmxO6Scqlh9SVFIoGve5GhdVvXh2grugt5doTnHfjunrwP?=
 =?us-ascii?Q?OCkVroSFZWMbmGxTIb++K963GHyqBUQPl3rrQXMqb1hV8A92PP1n2oigmrBb?=
 =?us-ascii?Q?LZklxWlKURmFQLNNskHltnsjBNo+PT+g0EyG2p3lYbuZF8NtDQYllAchkHp9?=
 =?us-ascii?Q?bdupClWlv59Ak+9Azg72Sztarf/s+nenIKpXY0nzKJw0Agw++rmXff1wBHs2?=
 =?us-ascii?Q?DowaHYP65pn3Hjm8WY+5z/AewwCFpL1j83JPYwj8fxajUM9A+FU6hUy97crC?=
 =?us-ascii?Q?uF0tZzTl/O5iVZIEzoT+ztiaUALjZbanUJQgx8Wwtcdm1NpWqx7sQGwOXQ/9?=
 =?us-ascii?Q?d9pi0bQCfHoS0S7tHiFCGiGEUpfnjJNmEAugxYZfk20QQk2Z+tYzmnxEHj6y?=
 =?us-ascii?Q?C6oXMwOiZiyfFiVLk/6BQEK3GX0qWyGoafFFm1xQQOrfBEdOpecN2a4y81aC?=
 =?us-ascii?Q?nwUAK2AD7hpyalb+1T9ezwTq1wNxIBew/dqEMPHqCGDhE4Ii6aLiHxh/AbFU?=
 =?us-ascii?Q?GERWv522n+jXGuhpfqnvkKr9z5X6RhDJaKs19ZmQWdld8sobcP7Y/pk6/GHD?=
 =?us-ascii?Q?U70B9m0FateQ614Ilfmvef3x349UjwLYk2zo/D8UjN68Q6hOQHakigw+BVi3?=
 =?us-ascii?Q?osvnembZIG0Gs+0N3HHg701gWPYAsFIX+eHGewumShwQklGnpKwx8nCp0WrL?=
 =?us-ascii?Q?jKFh0jRCNxjYvBrfmb88iEYqpt6AOPsb/EgEVCXzg72zisZ+HQPbN+bWIxW/?=
 =?us-ascii?Q?13x5z5NH2SBmiY/5MWJs/fr2QDoaQ1OHrI9M6UOMlgry+aFPmGskOIml4hfL?=
 =?us-ascii?Q?5H9DJa2w8EL5zUJjFuZ6gzS4t0SydCDex9U2GzmAtks1vgQD0rqn4nW1yrLR?=
 =?us-ascii?Q?asmqL3nDoxOumLlk4SS0I4KepRKpJgpcgBUdLhvgPz2btVPKFOvPtneO77gu?=
 =?us-ascii?Q?77neKqt6zHWMfIJKuUswcyBoG0OeRZ6PgrSZUvtr6IxHmlUfCR1ySP3AnlXS?=
 =?us-ascii?Q?2wK7qmikgTeJErgeJRUT6wfWHer8J3e5X6iwH+QPU2pu4p8+TokgUTbPqXLu?=
 =?us-ascii?Q?9la6XN9MNJWxrcL8qlGg/0FC588AoGSeZKaRskeO2ExAb57M0yAircIBrrZE?=
 =?us-ascii?Q?cQNbpejLJ6yIW/8yBMIscNZu41NDmeXZ3uvwInTTV/8IQKu3spIPP9jvJNdE?=
 =?us-ascii?Q?eaVHjo0jV0sLTLD8IJh+8nP/b0X5bF6ZtlQ1dDjH5uFeXEHdmZBjNuPlHOT4?=
 =?us-ascii?Q?AkoP9Yg6lDXslP++7KpCl+2nF8PuisiuglEu02iiRRRrGihZ4ZYdpc37unM0?=
 =?us-ascii?Q?tetqbIr0rFXpO5SB8WrCKy6ua4MoTaoIiEif2knOGPUXcxmp1N69u+BDYunH?=
 =?us-ascii?Q?CfOVecKpZs0ZXZ4q33sETS7WuR8TVI25w7D0Ey54IoXY1VTqcLRZ3if2SF72?=
 =?us-ascii?Q?Xt19Og204ztQmGbmqABL8UNazr8J8nOn3HAdBV8dDSZobengS9qVHv4TlTF7?=
 =?us-ascii?Q?qRxSp8qC79h3IuBqLFOHmZGSoHhv9/w7QFUF6Fps7o6vg5XcrB9giUQZtA2T?=
 =?us-ascii?Q?ulJ3Umo8rhvHf7UYoLXLxdS9OjgKSb9qQBIL4eN9/f7XrD3kvBetw/hvz6O0?=
 =?us-ascii?Q?WO2eTe7ErCjMez8JgIybfjW9PtQOF16RFHRgzrgV0sqZtTeTfX1aDyxzbofJ?=
 =?us-ascii?Q?KqQTNw2DF37F4oLXzXRea5U376RNVuHRkQsRBahs+AAMUUJr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5203a55-62c7-4913-005c-08de5ede53d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 02:30:11.5225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njWQGg/40pke9OMv7IS0StjWJmkwFU2kswA6YYPUhxftxxxZXp9aqAeRAZRBgMl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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

+       int ret =3D -EOPNOTSUPP;

how about replace it with Bool false (0) ? I think it is more reasonable to=
 use false(0) as default return value for this api.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Monday, January 26, 2026 11:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras

add amdgpu_smu_ras_feature_is_enabled to query one feature is supported or =
not

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index a15670e561b5..e2bed345128b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -624,6 +624,18 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev=
, enum smu_message_type ms
        return ret;
 }

+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+                                               enum smu_feature_mask mask)
+{
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (smu->ppt_funcs && smu->ppt_funcs->feature_is_enabled)
+               ret =3D smu->ppt_funcs->feature_is_enabled(smu, mask);
+
+       return ret;
+}
+
 static int smu_sys_get_pp_table(void *handle,
                                char **table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 4d5dfd936ee2..ba8c85f7c90c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1843,6 +1843,8 @@ void amdgpu_smu_phase_det_debugfs_init(struct amdgpu_=
device *adev);

 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_t=
ype msg,
                            uint32_t param, uint32_t *readarg);
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+                                               enum smu_feature_mask mask)=
;
 #endif

 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id =
fea_id);
--
2.34.1

