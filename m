Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6589C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 08:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4FF10E247;
	Tue,  5 Aug 2025 08:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PLeSjf/6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB3310E247
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 08:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLICIQ0XqxPTXcmeowW26CnXzPHEi/qH26+7eMHZ+OOf3pMdXiS1eXsj4SqZby15neusUzue5RDdPjekZ99a81ul/wxj9yI0g4l2IoFxpgzgMYU++v+3URWKXzxr5Vr4NC/q9xFiGk3fbPLGq1nofhbULyitNZMEY5q4q4l+Rx0LA2aDYkBBlmskqNqPCADZEjT8vb17+O7ZGLjlI/szYut/X/i+AMrlAVarSf/7L39NUV4XE8HZB5sNOmwvSbFerSGEXiFpS/GNNdTA1Jz5t4N2SyIwntnwWAy4vDGzq2E/i+Bzsq5a/rjZUZXy/TOaviyS5ijN5Xb70VtSSl+OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH9eNMha2SG9QA3UOY0vRW7A5EaLFbYjziIcGluS0AA=;
 b=g+eYiPqrZ9OTkfL0KqtLSu6YjRHVYMLkaG7QkCJ3sJo2/nI4ziT+f3VWBHGrqb3bAvPbQ0SkrCkd/2WS/Cenk+oGRaTSeuxgz90YfghQJNZS5NkgUs4aatJfzpKfjbTw0Ht7b983ULokTz6DyJwm1sUca8DGccDYBv0/UdhZFlpDK/BGLP74FOE/Plf+QisgYslcbDmLI91BVQWfkyEzt36/Am+Qr7Sx/aWK3JjOyZdOpmULCQ5L4r2sB0i0r+KgNo45n6GCuqJ8k2L9qm3ra0HV6nW48rBHsODNpFqg2v/5Mrnj6QZBYzgQENi4OZVNo8Gp16IGNJHngsDPedb7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH9eNMha2SG9QA3UOY0vRW7A5EaLFbYjziIcGluS0AA=;
 b=PLeSjf/61Flr5yk3zdyEjUikaKqYlBjf18x7DhRCnR33mnWzXVj/iUsgUhFwleyTK6CyIDw8Valo15RRz8US+V2gNp95mSxYjwu/waVf29NjNsxFdzDxVLV9UE1X87V9wlSopqpKf5G8HelFZP8sPCyFfSAvwzBp+WeNAyIqBck=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 5 Aug
 2025 08:28:54 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:28:54 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Add helpers to set/get unique ids
Thread-Topic: [PATCH 1/4] drm/amdgpu: Add helpers to set/get unique ids
Thread-Index: AQHcBTca9AQY4740lUOJsZHltrYlH7RTu2rw
Date: Tue, 5 Aug 2025 08:28:54 +0000
Message-ID: <DS7PR12MB60710C696FC96D4453AB233A8E22A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250804115808.1758735-1-lijo.lazar@amd.com>
In-Reply-To: <20250804115808.1758735-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-05T08:28:29.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA1PR12MB8918:EE_
x-ms-office365-filtering-correlation-id: 3e12a182-1dd2-4ace-c678-08ddd3fa1d5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DeENJsFnzUc/Emz4emwGHvJtwKW94A9t4SZzLIvz/5IK5j/Nbj6556Wxy6JP?=
 =?us-ascii?Q?/o4B1VjRkaAmwAoJPNjOjUg9/cz9sRYT8wh6Bb+cXO6JRdgqn+7wVqb3qd9H?=
 =?us-ascii?Q?B2SuxdgXHgqA1z+pBPk+GE7sk7YQBYA8kdgyleKBA5A7lOszPx57vyCmkope?=
 =?us-ascii?Q?hvr0/asErx5gP60yhfqZp4VeQieHXtYt+NI1NHx8dDqDNrLVSCGGYkz558L1?=
 =?us-ascii?Q?7Opct2PE68/njvOGzVkxPjvqNoYEHunuWCCaq7h4qDP2crV/9JnfBbys1QJn?=
 =?us-ascii?Q?18u5SHFj+QjC/XV02eXreDdanU7vttjSoxQaMOdGdKvl5KEFwpurveItyFUo?=
 =?us-ascii?Q?+VHFWqIavHcuPm3uNA+004tuIsSygoMYK4AcZ5bc5zhBez55cANVW9xlpNy7?=
 =?us-ascii?Q?gQBrreXJJoiX17RUZCclb8RBFmqF4TSaDaT3+QfgEMoBjsU/wBcrfGpt5GHg?=
 =?us-ascii?Q?17PHXqe0Ns4wkZ1pLk481WoFkcbzraywx+T/qLThoJim4XZhPybVOSXJs/oO?=
 =?us-ascii?Q?bC/OFXPCOdlg2k+59LVdBuKkzMDFZLKWVHsqDMhUBji6zW2FFfLHkxcekmMT?=
 =?us-ascii?Q?DeudNrDnNyiN6ahANcuMSPvhay0VwBqO5veWelDfpfs1kfi8sU5V3LDJtXJw?=
 =?us-ascii?Q?iXGAKDtqBOxCmaAnKPYzi7VU6sLpDygurFtJ4hcOPbjSD4Pdnjpkm23JE0oH?=
 =?us-ascii?Q?IW6pXVcX9xr6E0FaiGlsIGOCsxoPU5n+h05ZqRkmkFz7XQ5nV4NMhZ4bfMd0?=
 =?us-ascii?Q?UW9xg7x5gZmcdnXKVhBUEdwFp+iJVoG6M2C1JiaM+yWWKdu1gxtvjzmzCeUV?=
 =?us-ascii?Q?wSurf8ldmj56Bl4blrREWy3xYcV0oB1CjhoMJLzxIJZ8lEZYvmvUvuL5186t?=
 =?us-ascii?Q?OnNYz/Yb5WWZDqBKB6xZuIuX01m88zxcDmj2qGa9eltHkxociBsrkagEA1pd?=
 =?us-ascii?Q?eKy0DWN5u7Y/YqC7rv1tmE9vl7HTsFiVjqZWVN9/J+WTNEjUjjPbgR6b2aLQ?=
 =?us-ascii?Q?w4aEL96W3pF4oRpgQLhj9vdZDaF12xPNaREe8zxu2yLmSzF5r9OskdyDALTW?=
 =?us-ascii?Q?MfpdGM2At2blmfZ2kRhesteIfqnApBW3xHrNo5RRYek3bQ4YM8HdNSERr7Pp?=
 =?us-ascii?Q?C7M8lvywfgAgfVTFXIQn2shPJc+ScvT1p+lV/dPhnlenyKuAHbrFsk9SfDw3?=
 =?us-ascii?Q?YmbXWMIfQ60BCBW6bZUyss8Bv0oC7iF7b1My9e6Mcm40tVy5rhBGhH37QUND?=
 =?us-ascii?Q?yr5ArdY6Kn4J1h8ZdeHGi5/nJqHF8It/i4LMEGZQNPevaQ+Lk69ZKBP6LMiG?=
 =?us-ascii?Q?W6ijxNKRpM11sWbMkDdWbeOcLJ7mNDrFJOBl4ve3W2XgsXmzliUGuMKEo7NQ?=
 =?us-ascii?Q?/KTVME0QBeLkaCy0lB4yYmQdwCYjoRtnDBw40u+PoSeE+xBkDLy+AZ+/YIv7?=
 =?us-ascii?Q?j4Lxajhck1E+sh2vDFNh/93/ZhsaCz23UHPGZ7gjIcX8Chh6UvjsC8BPtiU4?=
 =?us-ascii?Q?x4G2I5uO+X3t77Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z5tZQHDxwr1aYui31IQutlzMR+0nTdzythGyYpayHb2yx9JJjZgcpT12ZieY?=
 =?us-ascii?Q?Pm0nFJb94/hTpMspnLuIsVVskVyA0rFeES1AJYn/cKEcA+P2vop3DFq/oVR/?=
 =?us-ascii?Q?rmz4SgVCbcShHl4zjdhbJ9oj9ZH7gGGVCICQdh0IlJUW3mze4z8058c2rJF3?=
 =?us-ascii?Q?a3sCQcQ+ifY2YutrzyTrqQPiQiZGf7OzbgK/hmVzEV64wCBvjzIenU2hkjck?=
 =?us-ascii?Q?K9rirX+KwU3ESKOVJeDEikCHPG+yptJvILuaQiRUmna25+DE2lPeHaH42q4s?=
 =?us-ascii?Q?UnFxjvZGVTdvesGzRb3CjISBZM62K+YjJixSAoLUej0weCnWSxSvIRyStO5j?=
 =?us-ascii?Q?o9pDlgHofr2JgAId512cO2IOiBMoy9Y3Qkqqy8hQAgE+2qpWTssdyfqo/8B2?=
 =?us-ascii?Q?MA3MnjV3SrIsYzoxtCzsFNGsVWfpbGnMKyPhhfAvDgVKKh1bnc5Fuvypo1zR?=
 =?us-ascii?Q?8oBYTyV9WxPDYz2abVVqXCtKWxXxKHnf0gHu49/7IEK9ip6ehIEdKwD0MsMC?=
 =?us-ascii?Q?etgiER8M0T2Wn90lItdx1ijiDfbFWgEGh+bqiIgiR3m2ybDuLra/a+ugIJoh?=
 =?us-ascii?Q?jDYJtTBQYdiJ5Uk1xd9VWDFGoJ1D/ivNDCeKnvhoLm0TfOgg3vac3IxdFYUu?=
 =?us-ascii?Q?SIirWa1dLO9EebUJuYFlU4mxGXIFkaa02zNZjy91JaeomEyzkAs9rSmNKHvU?=
 =?us-ascii?Q?RMb84sgpg9s0EMijQFYF43f3+oY7Da/bXzFJ8LrVbHLNCuasZJ4XzQkLJnlX?=
 =?us-ascii?Q?Ju2YMtPAcBZEZ4Z1vIGBKHiAv9stvI8hCO6FjO2r3IQy0XRIIvxGPrx632/T?=
 =?us-ascii?Q?IN+p1DdLBFE1ZM8pI4Hc6LVBDoEBOMrYHSab0mqra7rLK0aAGs2B7DZNnvem?=
 =?us-ascii?Q?EFJ1oupaalhMRxJnguhhXSmkaYXevQdNukPlepOsJZ7SjaDGgqZhCL+5qSVd?=
 =?us-ascii?Q?jx/L61HxXGYIG05N8fIDiyXiFQ9WojhzG1kI5YYNesBZj2+XdCSoc8AyYAus?=
 =?us-ascii?Q?BKt3AxZbmDlzEAMyvk1PsAejZp0eVWgrjdLkYfi8SnGP8kDHWptKxkpRmiFM?=
 =?us-ascii?Q?GM6bPAAtUjJr2wUZAM1QfetO7CJr7Il7kucjtcmaN7hIWLXD6r0PJRFbWIl1?=
 =?us-ascii?Q?+feY30aTDPVZ1689K+ekgC6067ziawYPYCtp6fCQ0ny4Y5LRZenEX5ZI3ImY?=
 =?us-ascii?Q?5XF8DC30NlyyNWf7yHYlczonsxVdqhE0qYN9mlI2TPkoNCwSgqy77h8sNhJa?=
 =?us-ascii?Q?frJoL+LzJBtBYar0fWiBQmbq0mvwedknaag4Fzp8L7fSAvmKsiQkX0cEHEOw?=
 =?us-ascii?Q?+o0Xmd+kO6dbPAsFwQexg6SbOVm2XXtklWTrnk7oPfVtV4N1UgoSAQbW3SCl?=
 =?us-ascii?Q?6C4QbPubmfDCeiwRZLx+AGrgO/qWE03HG8LQJ+fg2h0Jq8lYzuNeOj3B6fLZ?=
 =?us-ascii?Q?RuR3kYI9MNZTNqe4LH7Nj8MpvCfETmdHyA3K1sW8RZK3W7fqTNPCumMb4l3G?=
 =?us-ascii?Q?BHeVunxdkG1YcC6wXUUIk+wZzIiKbXNHT/732hZ85bB/fbrZzuj4yeWpGPvI?=
 =?us-ascii?Q?rHUI7u57L5xKAGMCyco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e12a182-1dd2-4ace-c678-08ddd3fa1d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 08:28:54.4416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmtNag0/tIDKi7OVTm5GOmWyEc2va3IhvoojLZuxgnKIzJA8obBfp/RfcNfvi77hwzrltDEyMGLh5ooeO8Ivyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

Series is
Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, August 4, 2025 5:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Huang, JinHuiEric <JinHu=
iEric.Huang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add helpers to set/get unique ids

Add a struct to store unique id information for each type. Add helper to fe=
tch the unique id.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 20 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 71 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ef3af170dda4..c2771e32d0bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -819,6 +819,20 @@ struct amdgpu_ip_map_info {
                                        uint32_t mask);
 };

+enum amdgpu_uid_type {
+       AMDGPU_UID_TYPE_XCD,
+       AMDGPU_UID_TYPE_AID,
+       AMDGPU_UID_TYPE_SOC,
+       AMDGPU_UID_TYPE_MAX
+};
+
+#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID
+type */
+
+struct amdgpu_uid {
+       uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
+       struct amdgpu_device *adev;
+};
+
 struct amd_powerplay {
        void *pp_handle;
        const struct amd_pm_funcs *pp_funcs;
@@ -1302,6 +1316,7 @@ struct amdgpu_device {
        struct list_head                userq_mgr_list;
        struct mutex                    userq_mutex;
        bool                            userq_halt_for_enforce_isolation;
+       struct amdgpu_uid *uid_info;
 };

 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
 @@ -1785,4 +1800,9 @@ static inline int amdgpu_device_bus_status_check(str=
uct amdgpu_device *adev)
        return 0;
 }

+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+                          enum amdgpu_uid_type type, uint8_t inst,
+                          uint64_t uid);
+uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+                              enum amdgpu_uid_type type, uint8_t inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 370c8daada8c..9eee1d4e1eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2675,6 +2675,24 @@ static int amdgpu_device_parse_gpu_info_fw(struct am=
dgpu_device *adev)
        return err;
 }

+static void amdgpu_uid_init(struct amdgpu_device *adev) {
+       /* Initialize the UID for the device */
+       adev->uid_info =3D kzalloc(sizeof(struct amdgpu_uid), GFP_KERNEL);
+       if (!adev->uid_info) {
+               dev_warn(adev->dev, "Failed to allocate memory for UID\n");
+               return;
+       }
+       adev->uid_info->adev =3D adev;
+}
+
+static void amdgpu_uid_fini(struct amdgpu_device *adev) {
+       /* Free the UID memory */
+       kfree(adev->uid_info);
+       adev->uid_info =3D NULL;
+}
+
 /**
  * amdgpu_device_ip_early_init - run early init for hardware IPs
  *
@@ -2858,6 +2876,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)
        if (adev->gmc.xgmi.supported)
                amdgpu_xgmi_early_init(adev);

+       if (amdgpu_is_multi_aid(adev))
+               amdgpu_uid_init(adev);
        ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_=
GFX);
        if (ip_block->status.valid !=3D false)
                amdgpu_amdkfd_device_probe(adev);
@@ -3648,6 +3668,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
        }

        amdgpu_ras_fini(adev);
+       amdgpu_uid_fini(adev);

        return 0;
 }
@@ -7467,3 +7488,53 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t s=
upported_reset)
        size +=3D sysfs_emit_at(buf, size, "\n");
        return size;
 }
+
+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+                          enum amdgpu_uid_type type, uint8_t inst,
+                          uint64_t uid)
+{
+       if (!uid_info)
+               return;
+
+       if (type >=3D AMDGPU_UID_TYPE_MAX) {
+               dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
+                            type);
+               return;
+       }
+
+       if (inst >=3D AMDGPU_UID_INST_MAX) {
+               dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\=
n",
+                            inst);
+               return;
+       }
+
+       if (uid_info->uid[type][inst] !=3D 0) {
+               dev_warn_once(
+                       uid_info->adev->dev,
+                       "Overwriting existing UID %llu for type %d instance=
 %d\n",
+                       uid_info->uid[type][inst], type, inst);
+       }
+
+       uid_info->uid[type][inst] =3D uid;
+}
+
+u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+                         enum amdgpu_uid_type type, uint8_t inst) {
+       if (!uid_info)
+               return 0;
+
+       if (type >=3D AMDGPU_UID_TYPE_MAX) {
+               dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
+                            type);
+               return 0;
+       }
+
+       if (inst >=3D AMDGPU_UID_INST_MAX) {
+               dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\=
n",
+                            inst);
+               return 0;
+       }
+
+       return uid_info->uid[type][inst];
+}
\ No newline at end of file
--
2.49.0

