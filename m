Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD086CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 10:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8593A10E73C;
	Wed,  4 Sep 2024 10:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YCoR4HNv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D2710E73C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 10:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBZ/IwRj8+navesATZZEh28qFGUgo6xUBYBjBgE7yNCG+RuS2aPAjpHbbkRVNe+CwN9eDAsNcHLsBfjLIVyzLrHJdS648eQ2FFjxQjn88w5WhF9BQrc/ZrOuPWIMkpQ3zRC3OJ2eU6ZJgUx6+Y/3d2WcBB0bdbrQcti3mB9qzOTF0/y0vQ2NhHQW8ZAuRw8AERRWuliLxJokM+GK1w/+6awanwst0MPZdAl07ZtdbdFmrHr4r1DQcPB8Z4tTis8lGercFd99KKbXvodc/0vNUnxUrYd3uvZApBkHp+N9G3xaNwK8/g8+tTWLPH2JRqWTHcNt+X9/T0Ry6xjUCRtaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc57Y8f8ZEcmL3Cc088GEzLHuwAr8QLIZlkbmTVxHWU=;
 b=aIGA+ak2plN6X4q4HOzlIeA4djVRWZdimn9GNKhAp8OHclNce8aF3IGzK0wScGdeKgZC6oi24mgU49Qd/sne9koezLLswW65xmch/3zysP3A/3HRxP6T2pJQJ259Q8sWMYCP3FG1nMY5URxTQI/jYhjtpRCDtNAlyVV+zZy+OiuqYvGasE5fvLp5VFJTM0sFPytkwC6VCJ3snRZbw3QCmgkijYbegT5w76Vb8aRo3FCEnLGW8WzQ20H/m9/jn8R/ECgp695vMGrzzTIu6qJvfmHaQGor+rdSSJ3WoOxsnPq9vv2liF+Tu8HVfDguE5VoGvSC+OfFiNy+Gck/P0sU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc57Y8f8ZEcmL3Cc088GEzLHuwAr8QLIZlkbmTVxHWU=;
 b=YCoR4HNvPqx3z32rbXWMVHJrXQGFK4QB0HWUi/Y9sOpBqdvRFNXm7VNOBjvQtUCG81hdjnM9xvBncikVnq3kmXXMMuaxFi076DusguiDXzxwqIAMC0xAhkr6mpnVcrIYjm77rruR6glYILENg4QMWtrRSvqlrmEIFebO9Wz5zy0=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:06:07 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%7]) with mapi id 15.20.7918.019; Wed, 4 Sep 2024
 10:06:07 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 01/10] drm/amdgpu: Add init levels
Thread-Topic: [PATCH 01/10] drm/amdgpu: Add init levels
Thread-Index: AQHa/QqWDFZm0kusfUy2P3FdMgF81bJHZmpQ
Date: Wed, 4 Sep 2024 10:06:06 +0000
Message-ID: <CH2PR12MB4152599C2FC4A8CA02B52894FE9C2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-2-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bef30d37-cd7b-4014-8da4-0fe0b16ad6a2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-04T09:53:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DS7PR12MB6167:EE_
x-ms-office365-filtering-correlation-id: 409c0a92-6d90-4048-8d7d-08dcccc9317c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zVZPPVFjLcN5RUIvkuJw3jXwHwSHJrRtz4wmr6SAPsf6f6G3Hal/tA6G/4Mb?=
 =?us-ascii?Q?OWlFob0+a2twIwRmFUmeoSntJpejwQPKd82nV/mRlbYw9EWjj7DAcn0+odCi?=
 =?us-ascii?Q?Lqn+eeTxcIvhf4orxDRlqWCJR8oDheHfsigg66MEmGgCcONpV9FndrxIwucJ?=
 =?us-ascii?Q?piYasGFmAlrMU0icYz5pMFuqx8HmfuWMmtQA6sSHtc1a74sSFxXYZBVGQKQP?=
 =?us-ascii?Q?q/EFFvt9ZTLy/+Xh1CTSPnLaGzcDTuLH+FqdkXuSHqnruZSkAwVB5S1gsxaT?=
 =?us-ascii?Q?e947LBiBd+hozSI/VPVmK/qAq4gEl6ma3aYkxL/1Y//tVsyW3MpDCGrMOHSf?=
 =?us-ascii?Q?zbT2k1QwJQCLPJBgKLPqpp7mGsANUivXikNfYJy9MphUAab8MxaEkj+aV6/T?=
 =?us-ascii?Q?rkKV3+O4XciFyz0Dh14DyfxhdIoBfYipgBgKpzJtljAfJjZDdkIdr6BoW+fi?=
 =?us-ascii?Q?t9WAjKhttmKD8YjDF8ZwIbQ1zLqaeUqZuYiTgX6GjcX96H2goGM+6qFdPv7p?=
 =?us-ascii?Q?0vnssCMaN+U9mLc8I2+J6n/C0DTXcJHycEtzxwFLPvz8kPOQwoTlWQrZj03d?=
 =?us-ascii?Q?yDutdHmL+Xhr2OPf80dd7hxrI65r/BNokupltIzIJiupA27nyLe8h4ALMMfn?=
 =?us-ascii?Q?FdU2+ZRIHsAfVMkt+JMoIdDU0tqyI0xE34C4L7vlwa3cjFCnyrDi04fSOBLs?=
 =?us-ascii?Q?u+gBiY6Z5DzIlkoGnl3t18TxMLELY9rdV+Svk435tRtIAdSXyhAN8NfH8yfD?=
 =?us-ascii?Q?iuuUhkQGwzZTw36k1Laj+WIG/7KphpIpdNbC0HlNsFfetEUIxAv++83NjJ5f?=
 =?us-ascii?Q?nR2HyBJbymxppiJpo6akHFZXwGmJPoR6lNct84n+ohQajhtZ2zNdFgvNIuzO?=
 =?us-ascii?Q?XEZe67e12XpOoDHCFjkrQXudvGhTOIY6kyVjIL7DfU8wagJpobFpUOMGk3ZA?=
 =?us-ascii?Q?ti7O4qFfyl4UyR9L+oKcOTLh2G8eRtQVf4QJOkHm1rNdmXseDfXh7Y9JkeFQ?=
 =?us-ascii?Q?9rkopxp6S6lbjoPBwM6bJntNMKWpNEtDoyxzYaUSanVSrGGBuGk+CUfmB1pD?=
 =?us-ascii?Q?4WjU02WJ0Jz2mbANK8PdYG5C0SZ9j7mMPM65ZT87O3hTKz3qAUemkuUYl6aG?=
 =?us-ascii?Q?b/tsH9ECZChsru4pPRxd8bUOah9JEiT8IRAmH9QYRYulwxqykhEkpITsh76X?=
 =?us-ascii?Q?5pyOzH8CZz5ndQ+SrBaKB29DeFhDw5SF7fjuamLZKQhXplW+knyXbkBWGCuH?=
 =?us-ascii?Q?uhj8/MsIOnOkLFEVR5n7Fv7Ex7wm13n8IoK2XBEh7l8ab1qGs+KvKsCzRpNP?=
 =?us-ascii?Q?LnfIAPC9wOFt1N6MDXqYuk1Ynbh8J50AgbdgM40qVT4w2pr/41AeezIxQf22?=
 =?us-ascii?Q?pB+08Qr5wRLsJkjIh/fawRDVOVg505yMVd9fNynELcCVqHVWPg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SiveeComXZsDXx75z6l85XgdAJ68AKezxGSn0cIDcoj8qCR24d5YSuXw6ura?=
 =?us-ascii?Q?HTNpsQml73+RfmijTMlNTTNzwJNsXs6xHvokdY890z3KFgBjwcTQXnc/vfaP?=
 =?us-ascii?Q?DGXu7sAUQyb19UmW1aa4gahXBrzaEboa81Wya3g+MUGxvduj0AtgwZTTKorY?=
 =?us-ascii?Q?hfsdcIQLb/DfgvCR3/PAGJjPdBhlrT+GH4DqcqUQGHds/XHwbQa2WEsC7EN0?=
 =?us-ascii?Q?hVygLmvxNTUCAdhZXI5kJj/3bFYMFXhNuA2Zvf5DEmhPpt5thvl7y/5GbVxA?=
 =?us-ascii?Q?JvTCLzDJo+a+i2YCfmv9H+EnxoJlxqxzbfjdsYrZ6aElz6SIxRMd/BJRL9Po?=
 =?us-ascii?Q?MhHho7LsHJl7RU8q4gyvDIGQylHSCD6+T7E8wRe/LKwlnD8vJJ/RxFQgA9ux?=
 =?us-ascii?Q?mdluSKmDukNUE8uXfEBiV7syE9mjQWaCUIHnDIYOqDhUmBgX320tSbPMyWsv?=
 =?us-ascii?Q?Xwxff35DEabhzX3R+z939zlAGv9hYqCnZPCRcjYFDBgkiAb8vwJW9GRf3SOJ?=
 =?us-ascii?Q?Uw3jOUvhDQ/DV5DXUQeN1yeSDPPfMQ662SagRpvmu6jIZ/tcUp5wtIARPREY?=
 =?us-ascii?Q?XmPJXzJ5itgp9Vt8pPx319KK0fTNnBWUrL2tTDNVvUFzR6DMPiKQ1DQLTTT0?=
 =?us-ascii?Q?MR6jMSmtqG3NTbkmNa1TnghDYL6R1R8/CxNEGFakFTj4Jg+LVCUVdj+sOeD6?=
 =?us-ascii?Q?WuT+EzYCnwRNLrOAI6S1M7Aj5Nci13E396jXBR6AUR2QewfnyQ18+9fM8VCJ?=
 =?us-ascii?Q?YPkq9E60gdYOGD6nMXe4vOi/dGjTb52mI6Y7CocMw/X8l9YMrKa6JA4IriHB?=
 =?us-ascii?Q?/0yteNLYL12fExoLG3SCy7Jn5v4e6/ecle3xum9DUqXDtOX1Rb5p4qnQXKr0?=
 =?us-ascii?Q?+9o/JyveBjkkUlaFcD2+LQzznHq0QQCgZ3mQhSCfPMHeo4NpXwt5dZ/znqoU?=
 =?us-ascii?Q?VZGWHnwqb47uyum9zjp64PujcMy3PvkGW6LoFxpCc5joK2JufbHJXlyt83Sz?=
 =?us-ascii?Q?jl8n9aFUTAeBi2DqMdjq3q4A2vzKniFnemD2IhGFGkP9tcB9XfMVLOcMcfGm?=
 =?us-ascii?Q?0w2rxNHFxWU76TScHsUZqvabWAvjgl5bKPCCUtYPWCyS9R87OIdEHWfEYitQ?=
 =?us-ascii?Q?72ST85KaptCqmIDhQz7yw5dIM/Q887e1xSgIJapKhyP277tkK1tEACYOinma?=
 =?us-ascii?Q?5FqIHnuO5ZBEvrCTLouHO4m3mrr/YdehTEJ3LaPcWjqthg0TaNs5VVICpVcC?=
 =?us-ascii?Q?G73C9ZachYZR/KgiSYOXVvn1Bv7L7TWiUOIf4nAa13tHP65LgtTIO5ru0eLm?=
 =?us-ascii?Q?KbWGDjCW2Qo3/3w6WEdBT0D4JP5f4QWiU6qYzlkyIMVyDLY9GoVYlEPtYdcj?=
 =?us-ascii?Q?Ee3/kC+MqEyLcYk+zTFYIM25jvpMPdxteoRTrjrniAPlPhrNYnCHsqMO/Gmu?=
 =?us-ascii?Q?lD6lDPsncaw7P3mD+sepcmZQC5WL1QXXgnrzHwJ+FZ06ZTNLokpaN9PVmEag?=
 =?us-ascii?Q?IPXQI+MDZbR7gF42mpj0tg8/cgtAOB5ayen0Itj5pBoI96U1sSuHsRjZ9q8R?=
 =?us-ascii?Q?d7UerrWyg6YWAi+h6VU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409c0a92-6d90-4048-8d7d-08dcccc9317c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 10:06:07.0278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 359H2c/OCiMV4Y47dGW6WncDd0MF2ajqbj1SAp/M8r2EDG90l8R40WDxlLOOllNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

Comments inline.

Thanks,
Feifei

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, September 2, 2024 3:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: Add init levels

Add init levels to define the level to which device needs to be initialized=
.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 6e6580ab7e04..fefdace22894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -820,6 +820,16 @@ struct amdgpu_mqd {
                        struct amdgpu_mqd_prop *p);
 };

+enum amdgpu_init_lvl_id {
+       AMDGPU_INIT_LEVEL_DEFAULT,
+       AMDGPU_INIT_LEVEL_MINIMAL,
+};
+
+struct amdgpu_init_level {
+       enum amdgpu_init_lvl_id level;
+       uint32_t hwini_ip_block_mask;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_reset_domain;
@@ -1169,6 +1179,8 @@ struct amdgpu_device {
        bool                            enforce_isolation[MAX_XCP];
        /* Added this mutex for cleaner shader isolation between GFX and co=
mpute processes */
        struct mutex                    enforce_isolation_mutex;
+
+       struct amdgpu_init_level *init_lvl;
 };

 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
 @@ -1623,4 +1635,6 @@ extern const struct attribute_group amdgpu_vram_mgr_=
attr_group;  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;=
  extern const struct attribute_group amdgpu_flash_attr_group;

+void amdgpu_set_init_level(struct amdgpu_device *adev,
+                          enum amdgpu_init_lvl_id lvl);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 61a189e30bcd..4fb09c4fbf22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -144,6 +144,42 @@ const char *amdgpu_asic_name[] =3D {
        "LAST",
 };

+#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
+
+struct amdgpu_init_level amdgpu_init_default =3D {
+       .level =3D AMDGPU_INIT_LEVEL_DEFAULT,
+       .hwini_ip_block_mask =3D AMDGPU_IP_BLK_MASK_ALL, };
+
+struct amdgpu_init_level amdgpu_init_minimal =3D {
+       .level =3D AMDGPU_INIT_LEVEL_MINIMAL,
+       .hwini_ip_block_mask =3D
+               BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
+               BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH) }=
;
+
+static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
+                                            enum amd_ip_block_type block) =
{
+       return (adev->init_lvl->hwini_ip_block_mask & (1U << block)) !=3D 0=
; }
+
+void amdgpu_set_init_level(struct amdgpu_device *adev,
+                          enum amdgpu_init_lvl_id lvl)
+{
+       switch (lvl) {
+       case AMDGPU_INIT_LEVEL_DEFAULT:
+               adev->init_lvl =3D &amdgpu_init_default;
+               break;
+       case AMDGPU_INIT_LEVEL_MINIMAL:
+               adev->init_lvl =3D &amdgpu_init_minimal;
+               break;
+       default:
+               adev->init_lvl =3D &amdgpu_init_default;
+               break;
+       }
+}
+
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device =
*adev);

 /**
@@ -2633,6 +2669,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct amd=
gpu_device *adev)
                        continue;
                if (adev->ip_blocks[i].status.hw)
                        continue;
+               if (!amdgpu_ip_member_of_hwini(
+                           adev, adev->ip_blocks[i].version->type))
+                       continue;

[Feifei]: If xgmi-reset-init (mode1) not applicable to sriov VF, above chec=
k in amdgpu_device_ip_hw_init_phase1() is redundant.
              In amdgpu_device_ip_hw_init_phase1(), it only hw_init 2 ips i=
n BM: AMD_IP_BLOCK_TYPE_COMMON/ AMD_IP_BLOCK_TYPE_IH
        And add one more PSP in VF. In BM, both COMMON and IH are minimal s=
upported ips.
        But harmless to keep it here.

                if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_COMMON ||
                    (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version->=
type =3D=3D AMD_IP_BLOCK_TYPE_PSP)) ||
                    adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_IH) { @@ -2658,6 +2697,9 @@ static int amdgpu_device_ip_hw_init_phase2(s=
truct amdgpu_device *adev)
                        continue;
                if (adev->ip_blocks[i].status.hw)
                        continue;
+               if (!amdgpu_ip_member_of_hwini(
+                           adev, adev->ip_blocks[i].version->type))
+                       continue;
                r =3D adev->ip_blocks[i].version->funcs->hw_init(adev);
                if (r) {
                        DRM_ERROR("hw_init of IP block <%s> failed %d\n", @=
@ -2681,6 +2723,10 @@ static int amdgpu_device_fw_loading(struct amdgpu_dev=
ice *adev)
                        if (adev->ip_blocks[i].version->type !=3D AMD_IP_BL=
OCK_TYPE_PSP)
                                continue;

+                       if (!amdgpu_ip_member_of_hwini(adev,
+                                                      AMD_IP_BLOCK_TYPE_PS=
P))
+                               break;
+
                        if (!adev->ip_blocks[i].status.sw)
                                continue;

@@ -2803,6 +2849,10 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
                }
                adev->ip_blocks[i].status.sw =3D true;

+               if (!amdgpu_ip_member_of_hwini(
+                           adev, adev->ip_blocks[i].version->type))
+                       continue;
+
                if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_COMMON) {
                        /* need to do common hw init early so everything is=
 set up for gmc */
                        r =3D adev->ip_blocks[i].version->funcs->hw_init((v=
oid *)adev); @@ -4196,6 +4246,8 @@ int amdgpu_device_init(struct amdgpu_dev=
ice *adev,

        amdgpu_device_set_mcbp(adev);

+       amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
+       adev->init_lvl =3D &amdgpu_init_default;

[Feifei]: We can just keep amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DE=
FAULT); and drop adev->init_lvl =3D &amdgpu_init_default; They're doing the=
 same thing.

        /* early init functions */
        r =3D amdgpu_device_ip_early_init(adev);
        if (r)
@@ -5473,6 +5525,8 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
        }

        list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+               /* After reset, it's default init level */
+               amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
                if (need_full_reset) {
                        /* post card */
                        amdgpu_ras_set_fed(tmp_adev, false);
--
2.25.1

