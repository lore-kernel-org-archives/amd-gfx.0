Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51771CA1015
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 12:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6EB10EA25;
	Thu,  4 Sep 2025 12:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uTETgSHy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D38710EA2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 12:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFRXPWZC6I4LYgrV836OKAdgZViALeGW4IL0IdiOflsKw9ulPqxY7TXiGIhL6zyZed2kFrceezlv2WCD5mR2p4Q2qIo4nljSG0VnNLQxiW6uWy0i5BBzFdX5U2oI/OrbF5JfKnqec4z4ObPOqIE/QSV2QocwjM/HrCTY37+jf4epp/Q7KNuQonlm2pCZk97YNvp8isSooedwof2nywzrvg4r0FB2x9CVC+KSz5GPe9FyLbyn4SgSrVbosLmkK3SsS4L/A3k7s0LE+dHXYgBTXxjrQA/7uiMXwOBMoE6gZeyDLaZmdEJtqLagKl4R6ml027NYtC264rDCAI/hj1i2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlmlsfk+qZ+QlycjXEJ66GXwW/RuG0b+78H7xmYHizg=;
 b=JRGF2lLgc6YLTh3jb2FESCpk36BmJTw1qLQq4muaPVtF70YEi5YstEX0mjQgfaG4SZ0UQhqgzTVA/u24ldpQwxgppQ9+xdwvGXD/DB2SLzQvcMAwQ6kGo7BBrUTnzGIJpvU0SJur3Bl+cOSLlylc/3pfuX8ms5cJMkmMI5r4B1xobnAY9XST6bz7ooIhoodF42LLcVIyhPmFc6jw5+nK0IQqzuzreZ0UwBXwx4Zk2ewrND0iRPKtBJ2FKnVNjY5EHYl+N695j6ziff66xNp5s84H9wxQsGjCmUR6VVKEY8za0d4wB9MMbPNDQs/0QRhv6ZPbokUv/HT7A3W9+fnGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rlmlsfk+qZ+QlycjXEJ66GXwW/RuG0b+78H7xmYHizg=;
 b=uTETgSHye7P9pWd7o4vZURnonJioAI5kk79mfEhcDuLNCkUGWs4Z2o3516XfKmHh5qJSyo7okY3xZOWby246jux8KoFan/LkzMcskaZIWKemt1WpEPS5ZymT78CcSgLKs/6p5H+zZmwVZ0vTeTZR4ky/jxJig/Yg712R+CR4Wcc=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 12:55:20 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 12:55:20 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/5] drm/amd/pm: unified smu feature cap interface
Thread-Topic: [PATCH 1/5] drm/amd/pm: unified smu feature cap interface
Thread-Index: AQHcHUniZ0lLxANL5EmHXUPdeGO+a7SC+5og
Date: Thu, 4 Sep 2025 12:55:20 +0000
Message-ID: <DS0PR12MB780426294D32281E46CF2C8D9700A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250904031309.2035678-1-kevinyang.wang@amd.com>
In-Reply-To: <20250904031309.2035678-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-04T12:54:53.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS2PR12MB9567:EE_
x-ms-office365-filtering-correlation-id: 42624cc0-518b-41c2-fa16-08ddebb24e34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gOynRjDluPrA3lB3ImQo130t1bWjLKs/QO+tlH1o9RvHctXVB1YN0VZmN1jV?=
 =?us-ascii?Q?BYtUjodPTssUqnWy8e5lc522/GN3hNkuh5T377nXYuwlbo1SNazvkWBsvHJ+?=
 =?us-ascii?Q?ypfremIFcwucl5vbto6+/0iLB9o25NxAdU/KqFcldFwHkgCk9FqBDVKvHJfK?=
 =?us-ascii?Q?thQDiI38hs4E8DjQZJ3D++YHJPv+yWuGFJ94yiCQanr6DSEE6t6f+GC7yECF?=
 =?us-ascii?Q?z5i7Gz0XMRJlEwf/t/RVMfXsKpakFhI6JU3P0bhXnl0O5CGMV/BPdrWSVjrM?=
 =?us-ascii?Q?LnDzwUgEUvKhzr6IMSpLr7lwgiu4faGfppGX5tR/cpq6LycD0rSy47X+x2ks?=
 =?us-ascii?Q?xOSTo+czdpjnf+pRpAQYamazLQDBwdYIgsEmsFj21D+18GNr9arsPmT2dqSd?=
 =?us-ascii?Q?qYpPO5Z2shzWGP8E+OnGxdF93RbCEMwlU7Zf8vRRfDPwxKcWYSMvQsxPAM81?=
 =?us-ascii?Q?TLj1WNvMVWS1ghiWHMACsa4KDoPt9osmpckjM9EwinO7B68EaIzKM6IJ/lxW?=
 =?us-ascii?Q?2lMsowzadJJSBX/lVXVOzD1xfxwFCK450HZJVeC2Ij/tzrSEFv/E6scCdOTJ?=
 =?us-ascii?Q?mfDLdjZ6ls4jdicJ8DEpgq/WzOlsVswl3y5PxxE5uB3FhnbZxucx37YFjcQX?=
 =?us-ascii?Q?iBXf3p6rWeFu6+KOTCrOtMmF/Srr1QWmWia4SjD/NytSkd2DINze+0KX2S39?=
 =?us-ascii?Q?bKdwLqsKYJXc7/+WOgTQUq66ZuZUVo5yyTnsSwGdno82ZKfZ+lv6tduPyPeh?=
 =?us-ascii?Q?wuUT599L//RBV91arkd+tdM4mE1yExU2z2DoMQwGwFW3SDMhLItpmCnpyuL3?=
 =?us-ascii?Q?qp3MQmTxHFiul1e29REK6/sFLlXUePK53KlxZN1B0VDHad37rfONDnAxv9X5?=
 =?us-ascii?Q?TUfNFK4MGy8drMitbS28MwOGlIYeMLn574OyJXfKKkHRXmmqswSVCsyf3EDv?=
 =?us-ascii?Q?A5VD8iRGf1kxw1kNELZKDMlaplF0qFiN+V8znZX/hkWBhB+IGPOjNEu0rCka?=
 =?us-ascii?Q?Id12MZ0Lnv6F9h37T3+Cq6NhKNI1t8MThyq27nC3JRmtIRG44AMJExtp2qyT?=
 =?us-ascii?Q?2docUynmKKEbGrIJN7f9r6qMK7xsTbh/crT3cBV6nLxxxmyCxph8t+Wymomg?=
 =?us-ascii?Q?MzdjZ41/Z+WpBoBjn14nY9iBPrN+2fvbii0dVdpqXYobrfRf7ZhbjgVstMZO?=
 =?us-ascii?Q?Doe/zkS9Q6vGJpi4X3hZgu9G8cTWHYwkcs+PeLF07DNY5nXjfnPYDz+ajCXS?=
 =?us-ascii?Q?c46pFe4Vad0ZtLdAdtRol7+IR4J4aibP2CabuVmyPTTiOZjXIuSaSp9snEaq?=
 =?us-ascii?Q?lG892rbB6Sz6tVLdwVuX26I7TCsG24qUnBm6c0PQfX4SywvP46qYnS3NKSy6?=
 =?us-ascii?Q?w2bTTXWck7RjQPQvTpMvu269cPpHaR+Q3TyWEHAVE2Guq6IxtAWYbftCWneW?=
 =?us-ascii?Q?UsjB+AD+hxNKkjMqDfLpCblr3kknzlzjQE6MPy+8DpR6HdYMRLtR5DPbgE18?=
 =?us-ascii?Q?yq2SOFqz0/0s778=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Vgof8ix7fRKiXjFo/KYhBalM1Z1OWHBuwT/sP8NHQ9ZVP0X+e0zrdQJfPPg?=
 =?us-ascii?Q?9cZhujYJ5IOTM8xP7+mjs6di2i8by0YpYz575tnOmw+xHgVU9EN40HlmBuGM?=
 =?us-ascii?Q?e8fVhRYwS7zroCT1Kv+EHqYGn5823zlfONH8hUuhbo3mVIm/WWMBnzVWvgct?=
 =?us-ascii?Q?ti7Fh4W7eKUyI8M4jRY3+OwoqrB5zczZEtsgBHMa36sR835C9pIx4GHcOZn+?=
 =?us-ascii?Q?kTBCZ2H5jcW52EWJXOOmyRwAoCORpZ+VkZpBp8qBAfaftpbpQjaB5CLt2fxx?=
 =?us-ascii?Q?iSspaw8WVkGsx+OVAP+Kw00Mz/WovaMn+T3n6fASoaZtQQ8GdINCqTaNovtE?=
 =?us-ascii?Q?j00LkdloP+9CRyCEAfYEPu4npbic6UQT4Ndx31GL+91sNi5YU7vFf04QU/hP?=
 =?us-ascii?Q?YgoQcTJwRUC9O0LVuyjQ/0TS7nc4sfa24S/hkqU5s8dRH87uDQpna2OQ5VWO?=
 =?us-ascii?Q?fLX2JUwhIOfwDcnVC2U0bdEDt0VH7JbwCCK83J29JtNOLytj8FPELzottjek?=
 =?us-ascii?Q?PQ3nojmS/8F3reIRtbWlmemhwK3Jaw6TDSU+EuXb5QjYIszcoDaYxI7G6adQ?=
 =?us-ascii?Q?rYtvLIEh37JTvEQfN3k6TMjdDDdYro77gTclgWAlzTJAHO4KLmZWnWKqbejp?=
 =?us-ascii?Q?CjJq3Oscpq/Oktw4jVU8FRjhr3DN4GAxPlKB8oBoKJFoUS0fTA4veRlXnm6f?=
 =?us-ascii?Q?+j6rUO1pF6nFsFTOz9o5jSBrWXHtjMIkO4FI08dCgfnP0XSllMAOri4JsB63?=
 =?us-ascii?Q?wWAwDfajY0jM/MzvaYn1GH5nRUwd6qaNodFfYKeKWR2Az3s8UOWbtOr8o7af?=
 =?us-ascii?Q?kbygLTr5vv8E58nFFF2LCvTPsbiIvb4mU+V3I2nKM5MayjC8Uay4oD2HCJ9c?=
 =?us-ascii?Q?hOWlalyWBPRp5ePOVXQ9gF0yq2ja3llkgjEFeJ6xqrwqd+XW1Z4tRlH2hMPJ?=
 =?us-ascii?Q?R/4K+54vReGA5AffOhSnTZBvuTEGiB/ghTvqUf55mqBG/5j9OLc3ajlrSBBz?=
 =?us-ascii?Q?4oGot6XpLU7tIvgMFi8CC7rLcBnrLpZRZCk3Mw3R3FNqHwyK4obaOFEO7ckR?=
 =?us-ascii?Q?TodiHUTEX3Rj+yW1RODGKb7bcuCqgUarSUBQyP40WmebYflx52bcppK7sy3Q?=
 =?us-ascii?Q?zDMJQOAmRuoHBBwpFOZvUe1AAbCBh5Q0jdx0rNc4fPhYwp8C8sFAAFXqd2Yf?=
 =?us-ascii?Q?jWJZVuuz3+y3F61N2tsiQR9Jtdqa1h9HsHfql7k+GFdJ7B0w3IL6tgyHp3xg?=
 =?us-ascii?Q?nA/bXRuCNZkf8nIFxbnsiVLYA9Hv63j/tmQfBZ6Al4oChrLjpL7PAr9inyQq?=
 =?us-ascii?Q?upIR4AFTui/q97QYt/Vz2GYRZL52y5u4EhWI0A3onnTSgzwH/ka5A3GtTHaW?=
 =?us-ascii?Q?REXcT8Qm8rf+OgOT80bofsRCdBlO4UKjIW2TNX2mr1w3Ppy0B94urA2l4kAF?=
 =?us-ascii?Q?/DkwwpCW9WVjy2O2WhGn1TdGJJRK2ck2K6XkPr61KlSMm/9T5YQxMe6FQ0y5?=
 =?us-ascii?Q?AGTOJS48gl04QerDUuCTwy64T7YRI27r/QoYt1ZcpM9UecUCm+g2+hgM8K59?=
 =?us-ascii?Q?JHDo5/L4rLG9DTDPXL4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42624cc0-518b-41c2-fa16-08ddebb24e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 12:55:20.4637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KN0XitE4mOWHPCoaTAPsivZf5MF6NkaobLPIh62p1q793y+mq1qVW/IP0Fvr4qmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567
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

Series is -
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, September 4, 2025 8:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: unified smu feature cap interface

add a unified interface to provide smu feature cap set.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 ++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c5965924e7c6..52b93642a26e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1316,6 +1316,33 @@ static void smu_init_power_profile(struct smu_contex=
t *smu)
        smu_power_profile_mode_get(smu, smu->power_profile_mode);  }

+void smu_feature_cap_set(struct smu_context *smu, enum
+smu_feature_cap_id fea_id) {
+       struct smu_feature_cap *fea_cap =3D &smu->fea_cap;
+
+       if (fea_id >=3D SMU_FEATURE_CAP_ID__COUNT)
+               return;
+
+       set_bit(fea_id, fea_cap->cap_map);
+}
+
+bool smu_feature_cap_test(struct smu_context *smu, enum
+smu_feature_cap_id fea_id) {
+       struct smu_feature_cap *fea_cap =3D &smu->fea_cap;
+
+       if (fea_id >=3D SMU_FEATURE_CAP_ID__COUNT)
+               return false;
+
+       return test_bit(fea_id, fea_cap->cap_map); }
+
+static void smu_feature_cap_init(struct smu_context *smu) {
+       struct smu_feature_cap *fea_cap =3D &smu->fea_cap;
+
+       bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT); }
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev; @@ -1348,6 +1375,8 @=
@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
        INIT_DELAYED_WORK(&smu->swctf_delayed_work,
                          smu_swctf_delayed_work_handler);

+       smu_feature_cap_init(smu);
+
        ret =3D smu_smc_table_sw_init(smu);
        if (ret) {
                dev_err(adev->dev, "Failed to sw init smc table!\n"); diff =
--git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd=
/pm/swsmu/inc/amdgpu_smu.h
index 5dd49eca598d..b0f5790051d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -527,6 +527,14 @@ enum smu_fw_status {
  */
 #define SMU_WBRF_EVENT_HANDLING_PACE   10

+enum smu_feature_cap_id {
+       SMU_FEATURE_CAP_ID__COUNT,
+};
+
+struct smu_feature_cap {
+       DECLARE_BITMAP(cap_map, SMU_FEATURE_CAP_ID__COUNT); };
+
 struct smu_context {
        struct amdgpu_device            *adev;
        struct amdgpu_irq_src           irq_source;
@@ -549,6 +557,7 @@ struct smu_context {
        struct amd_pp_display_configuration  *display_config;
        struct smu_baco_context         smu_baco;
        struct smu_temperature_range    thermal_range;
+       struct smu_feature_cap          fea_cap;
        void *od_settings;

        struct smu_umd_pstate_table     pstate_table;
@@ -1787,4 +1796,7 @@ ssize_t smu_get_pm_policy_info(struct smu_context *sm=
u,
                               enum pp_pm_policy p_type, char *sysbuf);

 #endif
+
+void smu_feature_cap_set(struct smu_context *smu, enum
+smu_feature_cap_id fea_id); bool smu_feature_cap_test(struct
+smu_context *smu, enum smu_feature_cap_id fea_id);
 #endif
--
2.34.1

