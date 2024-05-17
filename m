Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B324C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 05:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705EC10E224;
	Fri, 17 May 2024 05:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MOpZBO2I";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0F810E224
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 05:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3iBhAg7tvoK1let/diV6uAFttvQpqosfG/1Hj7GAhcP3PXa9tj5l4xVSSAs3NUZhGOD/qwx2F687k+xeC73X25jAfnfxcj4fJisWcqxl/llc5IPrJD5lyC6MTGS2bRRuLgdarZwP72bc5NO9MDSc02WKD5uSFurxMa6mnF2LGWsvWQ/Aj64LMCtLdouedjHOakMFqF8EOozsU45+PlKaPuu0YaUuQ6ptgl/2H0ZTJSb/eae2CGsayEbjixTXG/+z4O4l8dQK2oKb5rf1pzGWu/aq2AScp0FQK1t0j+axiZaaR98+WyDdpBkah9xmcRBevJ44UT4WhMVNChPFO1YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXYaL6n/TZBbIpc94+Xqa6dghchIQRCYmtbmThw8SjY=;
 b=HK28IQJ+mQF776ghC3/qggE0GHZ0gihGbsG4/x1Ne5rFzUbq52WG6YE6qkTWJSfBl3t/GMo8oqfTKypp6I4QMM5W3aqYuSL4uWVUp9pp5u5JU6yGoCly6KikVcOHHlBVuqPHZVQ4UY1v6HnasUeOoxbvUq+kW3cnWB3I5enPcvzzyqauV6Ws4yXPCcdERxZ+7iXpal2DmgkV/GtPpLbxcn1sYFNtqkzHeZ5F/S+eBi7c1PVQgVLb0o97wKKUMRRWCoGtTrRfLFjGASTg24mhc2Q5Qh+6Ba4lw0gUSXn80iuAM8dk7bFL9m2rgQZKccRCFf4reEurRzTg51AHxZ3Bhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXYaL6n/TZBbIpc94+Xqa6dghchIQRCYmtbmThw8SjY=;
 b=MOpZBO2I9HWzqpb4YwIO12e335Tffx2jtrK1cGBwXIDrnfiYPwE8kesUoEqbaPbTnNd+molDPSAunme3L/gYKpSPiJIyBvuAugHfZJIMRchlStQWsnvkDPgyj/U/OG681KfURmfuUWDFrzhyngQE+x1Y8SlMRNNywSp8dgT15Zs=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 05:11:59 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 05:11:59 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy documentation
Thread-Topic: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy
 documentation
Thread-Index: AQHap467CcRw8dV+ykK3t9QTcbCmcrGaPtQAgACjc0A=
Date: Fri, 17 May 2024 05:11:59 +0000
Message-ID: <DS7PR12MB6071D08B09A05B5080497FD98EEE2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
 <20240516124318.508785-11-lijo.lazar@amd.com>
 <BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144CFDA5EC4C7D8A9CBA8B5F7ED2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-16T19:26:38.248Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA1PR12MB7541:EE_
x-ms-office365-filtering-correlation-id: 7e58289b-c3b8-4b25-b9f0-08dc762fe144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?AexspICd8mzCAiQE/gBiDLFmqsSEEdGTFVRE0ZChYACyCqSP3WPMfP73z/Xp?=
 =?us-ascii?Q?DNewYpS6mG+oVSaAukob2dKKO+aNCkTgMY0fHDHs0/khkpfXGTgX/HMlcVvc?=
 =?us-ascii?Q?igTBTrTgnMcOHIuUKJjiGMyVE1fKfV4K5S7o42/pBEXWw6JpXYEXZBDY6weB?=
 =?us-ascii?Q?ZdSptVZfqxGjS3lWimnrjyPXg8aGdTmBnhrlQyaE7+0qwCHM6WVwF5SLGz8T?=
 =?us-ascii?Q?srYjsRzyrbOwjC9DYWnwwTif+0+h75tIRorITaFCedgNmr1tmeU9Y9RjRP9u?=
 =?us-ascii?Q?+hqxYw+iH9Ui5xo8B/8O3cO+crM6URcGw4AY/reABpMyodUUow2ozKf3KfzA?=
 =?us-ascii?Q?9mO5nLGCae5MOxiblDG/G/JSgEqfV0OVZARZgDUIfUcSB3lYcH81TxuPDtR2?=
 =?us-ascii?Q?mn5tnGXjkxhOMubrmK7GCg1kDNWdePurBBwSiZixBE16UfFzW+5lF6h+ljYB?=
 =?us-ascii?Q?ls3xRzaEVQ5MpSY3Xb+/tL3LOEvsSsRFHReMqxelDZ+114E2NJ7MQHbdKQoY?=
 =?us-ascii?Q?QLdtMdI8CG2hFxoWSJLiYpiHxuGKIF1mcZrlb7tcKsxCybA8SE2FFzGca6j5?=
 =?us-ascii?Q?NzbSulOJLSDiboau16XeZKvR7XmTPJnW0Vw6nqH/7av0D6qhd670biqK7z66?=
 =?us-ascii?Q?kyjH1wJFciI9f0nlE3xbafisR072jT3dAup35hOgZ/vkGO/jayZgKobqKKGL?=
 =?us-ascii?Q?OTEBWrfRx79RsP6+DFPqgt2ME3XNSQrBAMC3/01McDFrHOA3B9OrRmNp5zr9?=
 =?us-ascii?Q?AeBU62WZd4jg2YyCOq+IZ7/xyyWQnhQucByPiEeDjFK9pjpw16Q8ieqGXIZ/?=
 =?us-ascii?Q?rJFZmCVy8jaFL7vmbwpZSNYHpznRA/JumtAwVwAvrfakWHxJqUo9zi49F/Uf?=
 =?us-ascii?Q?kfGSoe+oE5jntbckWojWUJhUVbV4YiNmGJ3o8dpQfXTlapmJrEV4GxgA+5A9?=
 =?us-ascii?Q?8+/7/6wcqlzczlTIrdaVW+0sazCi4fhc7AkQmiHJxyw20BhuK04gM7nDmodp?=
 =?us-ascii?Q?6GicTWgGyxEL+85WoDAV95GL7GzZjNd+TiujJHydgLQxpt++U8JOuGrRrY1Q?=
 =?us-ascii?Q?KJE2QL2SBBaLPX04WMWrh/Lbr/FwkQvO1QcPP/VoQ+Q8dqHEXRdxyGo0M+vR?=
 =?us-ascii?Q?KOLzXZ0gVsTBcEqozQwhvPOtDfm410OqIGhLKPXevRe/XTAnwEMCXBxsHUn6?=
 =?us-ascii?Q?vdfe80FE5dGU5Kx2C+Hpq8TFuJgWiHT0E9+BiAGC+sKSuLr9ckBdGAl4ycmS?=
 =?us-ascii?Q?Hk2qeaKuFlG9aIpvlJbncZ9IErWlbwvk97eB0Akc7R0D1Ma4euU+ZAv5qYk5?=
 =?us-ascii?Q?i4B/dD4ywwUFMFsq9VRZu9EM00TQuFqmOjOcMEYEdMKx8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bS06onyu6UJhyC2MZfOWjfVd8MrmJRym6lxIJ/01/gGQ7FZMqWFK/J0Ag5OU?=
 =?us-ascii?Q?0y2BQFWhVAPo902SfdBphcufwKTFy5L1SCEkGAVD1s1C7elrDN7/eHrC58l3?=
 =?us-ascii?Q?pFqnSDmSngVsWa74ly7zSokw4vmq3o3avxggqFPtybVssVDu9Uhji9B9gh3R?=
 =?us-ascii?Q?23gerbSV647G0g5ODJ5JW5oUCxbAyGvVOnyq4RVgB2Km1G9OBXtqGnBHSOv1?=
 =?us-ascii?Q?bork9qI80Ql+94pXBSGJD5fU2K4hr/cJSybSpYsJ9b8twx2cEoVEAA4zU4B0?=
 =?us-ascii?Q?M+3Kj/kuaShuvoPb+Dv69xmyH3qYLzO/sSX1OKy8DLbJfG3YaZZeTshuaFRq?=
 =?us-ascii?Q?zhM81iyU7c/AvrlZWwjBVKM5NIX6cElY6YVFLzvJ6gN8nxTKGThaaZUC/7Yj?=
 =?us-ascii?Q?zQ2E/uSebnCGvhPLoVW1R9LbQJJpRCCGjUEvweE1KwQF1CBdokWeOsX04JiG?=
 =?us-ascii?Q?gqEMES08rW8ZF75Q+9hTFeEgBV2pJGHvKkuUNu908Op0ra++QeCLSbZBQOQ3?=
 =?us-ascii?Q?sXzvrZ+3LVQ+o1lwO+p2IhEUd0tRahuDvh2YAyrXkoeD67VD0SMv7Smnd9Rm?=
 =?us-ascii?Q?HgMNCSPpt+AoSkGrCWH5rBpyiGSNMXQIoiRVT8ToSZ4oN3mEEGsnA4AOFsCd?=
 =?us-ascii?Q?rv0MLThupGXu7L2OY8SHW2LNU/Vd3YgF1BzpvxPJaiJTKEwCVOgIi5p3Xml6?=
 =?us-ascii?Q?PkZTHMA1k81gtZGVZZEunN9J9XWlnoAyVdIA/H7lB5jbL9XVgqTMfCvKZRjD?=
 =?us-ascii?Q?frPNP31tZ45AfbW08+TUkLvqYaDrz4OqBJJZTWuZH3mt8udNaWo9NENdEqat?=
 =?us-ascii?Q?iuCy3VLmZAuvv3WbrwIssUJl51lTcg7n2r5/Mdhdn18gkVUAuS2xeVuqq/9X?=
 =?us-ascii?Q?Sb7dEMbHUT7E/PmbmU4n05Zktj5kBm6JxTMk+NBKBVsbEi/oAdktmVI5GnqS?=
 =?us-ascii?Q?fofl24oB0wTtJXgdPK5CteUQTazsT0z1e+yl4iVdyxJcSUB1sIvPIiluoE5N?=
 =?us-ascii?Q?SzSngroiFygHMSgencMo7qzK7bXlesLtSnED6tQECENi0nrWeto2HtiWB31J?=
 =?us-ascii?Q?0GTfSNqTTZ2vtU5ZNRY3CMNMnFlmtTbTJqoOYl8m9iWEm+pLZAs6e+QTe5dD?=
 =?us-ascii?Q?4w1Evm5tKmWvcD06YKOoauptQXrIx774dKcnIqJMC9JxESHswQoC4h+Lf77R?=
 =?us-ascii?Q?VMbDnkFGAZfkrBNgqRMbuIJ5okz5mC4rreJNl6YRg8v4oRG2eepXB1dT2a0G?=
 =?us-ascii?Q?PW1ufoWo3av94FH79yGWQJo1GKFM3dlwJv6Bz8IoDPojQ9sMti9KI7IwtARS?=
 =?us-ascii?Q?/JdNmYBQe5feYyWL1kqm+sJN4ABhp/SAJjSUE0F/fnGQ/xbTI6J7upn/ckaF?=
 =?us-ascii?Q?8HDFX4VMcEiigMOJtzjOT82vTdiQGCA3bjPbVYUcgOJF72FNi7O8DmPmVSg/?=
 =?us-ascii?Q?8ny1M+JIM3nwB9gN+P4FnHCjibob4+dS/M7NtJ/2M8NobRj+JRV0C1Nb5aNo?=
 =?us-ascii?Q?yl1EWAuajRfjlgvsEDU+C9HB9msULb45Vu//Uj9bYZqUoskOF84wz7jE8+jk?=
 =?us-ascii?Q?bPTjnHPqEaIIaA1zRYg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB6071D08B09A05B5080497FD98EEE2DS7PR12MB6071namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e58289b-c3b8-4b25-b9f0-08dc762fe144
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 05:11:59.4094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmG7XnVYPSO/ApJxcdRbS08/7TZn+5ybXHj2KtIpl3+DW202+xdBTSRJ+O2CQkr1sos1e4ck4/wx1NwhT+kBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

--_000_DS7PR12MB6071D08B09A05B5080497FD98EEE2DS7PR12MB6071namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com<mailto:asad.kamal@amd.com>>



Thanks & Regards

Asad

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, May 17, 2024 12:57 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com=
>; Ma, Le <Le.Ma@amd.com>
Subject: Re: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy documenta=
tion


[AMD Official Use Only - AMD Internal Distribution Only]

I didn't have time to go through every patch in detail, but overall it look=
s good to me.  The series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Thursday, May 16, 2024 8:43 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>; Kamal, Asad <Asad.Kamal@amd.com<mailto:Asad.Kamal@amd.com>>; Ma, Le <=
Le.Ma@amd.com<mailto:Le.Ma@amd.com>>
Subject: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy documentation

Add documentation about the newly added pm_policy node in sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
---

v5: Update documentation to reflect pm_policy nodes and sub nodes for each
policy type

 Documentation/gpu/amdgpu/thermal.rst |  6 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c   | 53 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgp=
u/thermal.rst
index 2f6166f81e6a..6d942b5c58f0 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -49,6 +49,12 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_power_profile_mode

+pm_policy
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: pm_policy
+
 \*_busy_percent
 ---------------

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5ff7783dfc43..3e5ffb83f398 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2220,6 +2220,59 @@ struct amdgpu_pm_policy_attr {
         enum pp_pm_policy id;
 };

+/**
+ * DOC: pm_policy
+ *
+ * Certain SOCs can support different power policies to optimize applicati=
on
+ * performance. However, this policy is provided only at SOC level and not=
 at a
+ * per-process level. This is useful especially when entire SOC is utilize=
d for
+ * dedicated workload.
+ *
+ * The amdgpu driver provides a sysfs API for selecting the policy. Presen=
tly,
+ * only two types of policies are supported through this interface.
+ *
+ *  Pstate Policy Selection - This is to select different Pstate profiles =
which
+ *  decides clock/throttling preferences.
+ *
+ *  XGMI PLPD Policy Selection - When multiple devices are connected over =
XGMI,
+ *  this helps to select policy to be applied for per link power down.
+ *
+ * The list of available policies and policy levels vary between SOCs. The=
y can
+ * be viewed under pm_policy node directory. If SOC doesn't support any po=
licy,
+ * this node won't be available. The different policies supported will be
+ * available as separate nodes under pm_policy.
+ *
+ *     cat /sys/bus/pci/devices/.../pm_policy/<policy_type>
+ *
+ * Reading the policy file shows the different levels supported. The level=
 which
+ * is applied presently is denoted by * (asterisk). E.g.,
+ *
+ * .. code-block:: console
+ *
+ *     cat /sys/bus/pci/devices/.../pm_policy/soc_pstate
+ *     0 : soc_pstate_default
+ *     1 : soc_pstate_0
+ *     2 : soc_pstate_1*
+ *     3 : soc_pstate_2
+ *
+ *     cat /sys/bus/pci/devices/.../pm_policy/xgmi_plpd
+ *     0 : plpd_disallow
+ *     1 : plpd_default
+ *     2 : plpd_optimized*
+ *
+ * To apply a specific policy
+ *
+ * "echo  <level> > /sys/bus/pci/devices/.../pm_policy/<policy_type>"
+ *
+ * For the levels listed in the example above, to select "plpd_optimized" =
for
+ * XGMI and "soc_pstate_2" for soc pstate policy -
+ *
+ * .. code-block:: console
+ *
+ *     echo "2" > /sys/bus/pci/devices/.../pm_policy/xgmi_plpd
+ *     echo "3" > /sys/bus/pci/devices/.../pm_policy/soc_pstate
+ *
+ */
 static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)
--
2.25.1

--_000_DS7PR12MB6071D08B09A05B5080497FD98EEE2DS7PR12MB6071namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Series is<o:p></o:p></p>
<p class=3D"MsoPlainText">Reviewed-by: Asad Kamal &lt;<a href=3D"mailto:asa=
d.kamal@amd.com">asad.kamal@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoPlainText">Asad<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, May 17, 2024 12:57 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Kamal, Asad &lt;As=
ad.Kamal@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5 10/10] Documentation/amdgpu: Add PM policy do=
cumentation<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">I didn't have time to go through every pa=
tch in detail, but overall it looks good to me.&nbsp; The series is:<o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Acked-by: Alex Deucher &lt;<a href=3D"mai=
lto:alexander.deucher@amd.com">alexander.deucher@amd.com</a>&gt;<o:p></o:p>=
</span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, May 16, 2024 8:43 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Kamal, Asad &lt;<a h=
ref=3D"mailto:Asad.Kamal@amd.com">Asad.Kamal@amd.com</a>&gt;;
 Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com">Le.Ma@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v5 10/10] Documentation/amdgpu: Add PM policy docume=
ntation</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Add documentation abo=
ut the newly added pm_policy node in sysfs.<br>
<br>
Signed-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.la=
zar@amd.com</a>&gt;<br>
---<br>
<br>
v5: Update documentation to reflect pm_policy nodes and sub nodes for each<=
br>
policy type<br>
<br>
&nbsp;Documentation/gpu/amdgpu/thermal.rst |&nbsp; 6 ++++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp; | 53 +++++++++++++++++=
+++++++++++<br>
&nbsp;2 files changed, 59 insertions(+)<br>
<br>
diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgp=
u/thermal.rst<br>
index 2f6166f81e6a..6d942b5c58f0 100644<br>
--- a/Documentation/gpu/amdgpu/thermal.rst<br>
+++ b/Documentation/gpu/amdgpu/thermal.rst<br>
@@ -49,6 +49,12 @@ pp_power_profile_mode<br>
&nbsp;.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&nbsp;&nbsp;&nbsp; :doc: pp_power_profile_mode<br>
&nbsp;<br>
+pm_policy<br>
+---------------------<br>
+<br>
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+&nbsp;&nbsp; :doc: pm_policy<br>
+<br>
&nbsp;\*_busy_percent<br>
&nbsp;---------------<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 5ff7783dfc43..3e5ffb83f398 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2220,6 +2220,59 @@ struct amdgpu_pm_policy_attr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_pm_policy id;<br>
&nbsp;};<br>
&nbsp;<br>
+/**<br>
+ * DOC: pm_policy<br>
+ *<br>
+ * Certain SOCs can support different power policies to optimize applicati=
on<br>
+ * performance. However, this policy is provided only at SOC level and not=
 at a<br>
+ * per-process level. This is useful especially when entire SOC is utilize=
d for<br>
+ * dedicated workload.<br>
+ *<br>
+ * The amdgpu driver provides a sysfs API for selecting the policy. Presen=
tly,<br>
+ * only two types of policies are supported through this interface.<br>
+ *<br>
+ *&nbsp; Pstate Policy Selection - This is to select different Pstate prof=
iles which<br>
+ *&nbsp; decides clock/throttling preferences.<br>
+ *<br>
+ *&nbsp; XGMI PLPD Policy Selection - When multiple devices are connected =
over XGMI,<br>
+ *&nbsp; this helps to select policy to be applied for per link power down=
.<br>
+ *<br>
+ * The list of available policies and policy levels vary between SOCs. The=
y can<br>
+ * be viewed under pm_policy node directory. If SOC doesn't support any po=
licy,<br>
+ * this node won't be available. The different policies supported will be<=
br>
+ * available as separate nodes under pm_policy.<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/.../pm_policy/&lt;poli=
cy_type&gt;<br>
+ *<br>
+ * Reading the policy file shows the different levels supported. The level=
 which<br>
+ * is applied presently is denoted by * (asterisk). E.g.,<br>
+ *<br>
+ * .. code-block:: console<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/.../pm_policy/soc_psta=
te<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 0 : soc_pstate_default<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 1 : soc_pstate_0<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 2 : soc_pstate_1*<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 3 : soc_pstate_2<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/.../pm_policy/xgmi_plp=
d<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 0 : plpd_disallow<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 1 : plpd_default<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 2 : plpd_optimized*<br>
+ *<br>
+ * To apply a specific policy<br>
+ *<br>
+ * &quot;echo&nbsp; &lt;level&gt; &gt; /sys/bus/pci/devices/.../pm_policy/=
&lt;policy_type&gt;&quot;<br>
+ *<br>
+ * For the levels listed in the example above, to select &quot;plpd_optimi=
zed&quot; for<br>
+ * XGMI and &quot;soc_pstate_2&quot; for soc pstate policy -<br>
+ *<br>
+ * .. code-block:: console<br>
+ *<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;2&quot; &gt; /sys/bus/pci/devices/..=
./pm_policy/xgmi_plpd<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;3&quot; &gt; /sys/bus/pci/devices/..=
./pm_policy/soc_pstate<br>
+ *<br>
+ */<br>
&nbsp;static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB6071D08B09A05B5080497FD98EEE2DS7PR12MB6071namp_--
