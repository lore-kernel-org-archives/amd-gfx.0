Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3B21073CBD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA76B10E662;
	Wed,  8 Apr 2026 13:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OaH/LOXu";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A96510E65F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go97nUgS6yzciohVwrV+K1nxp8OkaWhmKUZ0s5aoWxirEf9UTn0xp9bNmGHJHmYNY2uQvthq/+7CjGol8SGQauhM+gH/Bhvm7pO/mWxQppVUjKvJI2B3vmn+xFGLM85FsQnDIACYZp+lMqcGGQDpFFEdKVW5xZP2j6vR90xkfI7UOsJisHYqCy3x2CyQAOTqTQC7Y81R3hndPuI6KW6azqRyAvqJsYbK5JN9F4ciH/50w1YBnw95EzKtzCkQX2CWEmQt3rgYSzNrZW8ZL9PTHA7Ht/CPvizh81fSdsk6URo9dSGf0UHYfthKpJLQk/p4k11JDRPcZGQIxjCbG+xEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIX7lpwu9YnCUuu8YhPQerjIxUagi42q10BGCmdIDkY=;
 b=TOGXFJmAdwCN4rR1ZK2dLAbS3IiKMTd026WitsFKhGVQNpKyIFEJR9LuZfZBWtZyll2fptt4H3Y3zlVKz1KsZYWgwHAjUTE6874ErDBwQ25jAYkNcnh6KI5KAMUfaEE84f0iEUAe66xccmY1JDTX7uPdeYZQhWNyEtbytQ8sMJzDLocz3dlynzwJC/t167fceHQsuL5H7amTb0w5pJsQxmH90CJmryeylXwrZPerLObWKwvoZsEh+VoZY+c0tWNzDxB0xMRRv5mVrgEoSNl4h+ljytw2H9Yv7MuJvxwqnkzK/9rmNREeAruB5Uwt/TMHZ1c3gMkGMtFM7hvZQJT4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIX7lpwu9YnCUuu8YhPQerjIxUagi42q10BGCmdIDkY=;
 b=OaH/LOXue+S81spJvyc8gahD5kTGCb3mNFCfBWeUociyWliNkinIFjukFPQps9uppeaCFCwgYSKXOCK0j/JfcwVuUkaWKR1N7ReXhETPA+7qbEG2vdiowYp0U+o7fc3H1wz7ytzCjKjZPgxWHjPXdTrmPtjmJAM5cHhvcKyzVtw=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 13:41:07 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 13:41:07 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Cheng, Benjamin" <Benjamin.Cheng@amd.com>
Subject: RE: [PATCH v3 2/3] drm/amdgpu/vcn4.0.5: Remove unused define
Thread-Topic: [PATCH v3 2/3] drm/amdgpu/vcn4.0.5: Remove unused define
Thread-Index: AQHcx1bfydqyrPbFvk+atI2w7PMmGbXVLAFA
Date: Wed, 8 Apr 2026 13:41:07 +0000
Message-ID: <SJ1PR12MB6194CF79F75C1ECD61DF3BE1955BA@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
 <20260408125426.2118644-2-benjamin.cheng@amd.com>
In-Reply-To: <20260408125426.2118644-2-benjamin.cheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T13:41:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SA1PR12MB8919:EE_
x-ms-office365-filtering-correlation-id: ed6b1e92-2a92-4241-c8d6-08de95747cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: dPrCQ9aHi87K+AInS1NsPYZKspKFkojGP5cUio4NAVhCzN44mYux4zetS8t2Q8+ujWxDUr3F7K+7UmbSiF9Uq8zWhzmdDiqwQqOBiJnleOBuwM5EP7MyIe94waZ2Y6AFMVj4QTFcipTRgkslVe+5USjf/PpkMJAcOydXJTj9U1ggjrjSzVwBjUPCF4THMkp4XyWySRi35TXQE2k986+O0IvWQum4ig2dNHf5ll+7XqNxfznwRGH8fbXPrtMu8JMCmbRFsAwetkhqIKd98R+hamXDfjQ6ZFD9YSGQpszFGV81pW8jlHCWGmafnHmpBQrniWd+ep105AJibAu1GGDra3DAIyc+w73N4Jt5GV7dd2ipmTpfSjIlgeJbU2unafagJUkLqZvhn0yRsTAFwkm2mJ8cjsx/qcxiA9aIyrLvMh01/LbdskwY9LCs4CpDIrvIHQLgp0r+44IFZ3vzMRDaH1qG0w5nwfCmb2f3vorn5g0oPmYjotbks8TBJmpMQVqsDT0x6oX/CZO+PzzBkZwtpq09zaftm581Z/XizYuSiUeLo4eT3BgbbZOs8omMUkbkwu0bSi/mHtVm4B+0KGaHqgoMd/fd4gH43RGb3ASpJYxv/ddpBgigQ+RMvwWIdWbpfBXWNPhgJVDhuRRyaIbho5IamzSd4JoOOIAXWACiFHH8KEMDJXeUu6mG4AknbYM7EwwFi8wPbVIhbVPSpjE+EUIcNewK0Xahr0N8zcbApiSPlJikZsi9cENqlMfUST9wHkJtDtCx5kRj+uh7KdHlauuRHaktGc4jTpi8mkX3kG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FEOHKks1J4Vn0Ov3uiVEy+ToQm6GK6Qq761Pzp9W+KUjjeCOgx64sHos0jiJ?=
 =?us-ascii?Q?ny3ErRxoVFoTUmlaq/DIaVO4y10yez2VNE6S6/S/gZcfkVfZwGOHCToQs6uN?=
 =?us-ascii?Q?ALyHirT6tgQWPkRn02+8pi5UOEecd4ls1tkDABb6ouG0O1sHvkj7EFi5ZoFw?=
 =?us-ascii?Q?e4vyNCkmtdL9JKio3eOIhnebSV4qkRTwe4xBeBxf54fo6rFDE3K6rPuY302V?=
 =?us-ascii?Q?GXANmahULCXaecaSeLYNqhXCBjJIeKn4Us2xSAwRkWU5FMhAYASkke6kLc6b?=
 =?us-ascii?Q?8i50vPOrb+xowG23c7AX9SVufRKmlhe2Xbe3F207DZ7eDh8fO4IsuH/FwPCU?=
 =?us-ascii?Q?SOk4f3Ex19Jak5mpy2K/rEEPit56niobIZdrcZRwgsjpO4ASfDLVpHDIiqdu?=
 =?us-ascii?Q?NHEevH2Ys/rSwUSOQQSsNzChapsQIgnBPqr6++xZVEsoLbjRJF/XUKzta8ze?=
 =?us-ascii?Q?FJ/vHm1Ij4RIMa5/ftlldGwN9qaHltRM/txFIfZ5B4GhjIxtwDP6ygem8Wiy?=
 =?us-ascii?Q?uKbQzjB5XHSRKLLCPp3LrSfAO6co36gd6FEasdzcx0e/+X7gl8bLvxSbJ2M7?=
 =?us-ascii?Q?9WE4BNcCcDQVr1MQ5F7ZFSsrTiVGNvPYQoTL17N0k6knVIdwjlmxb/y9JEaG?=
 =?us-ascii?Q?2PAeSJMKzOhcx/PMEg0Vy3wed6VzyE7oG8CRY1hHksKo71ce/76z4x7zVoNK?=
 =?us-ascii?Q?VuLwBGAMuTKhkvjfyVkl59QMc5itcAkgEKvvZzoN3nkHCYOeXmnVC8cCEV9V?=
 =?us-ascii?Q?IJRGz+n5b1R2RWr1zm89OG8Wq1/OWLefNE/KSrPYnrPJShLqocuYEhSL0L8p?=
 =?us-ascii?Q?Og03CqnjXhLhRTP5A/l4Qmexb/7VtH7BYWeWGIXH1iarHWqOEFQqkXeHwoaq?=
 =?us-ascii?Q?DmIKx4784d1MS9goqG3E9rUe0OGR3ApRlm7uzAiO6tAeddztKGYkvDo01xHX?=
 =?us-ascii?Q?Es6SGZnyQyUe2zbVNjU5e7prpGDr8DkrKIpcVimjn+r1FgLUbecMheFmdIY8?=
 =?us-ascii?Q?cIu4QGptDV9C64hk7XY6DAPToyq4oVF/qoLbuRtt1xPmd/DQmFDCzNS/Kdzb?=
 =?us-ascii?Q?ImI24ZcJCscUPnut7LJwJl+l5QQNxsFT5RjF9XIrTl2jX7EYTq2U+UFhId+q?=
 =?us-ascii?Q?msKIZ/eRHzYwQTdAIMcAwAVkyJuioYci1Rx06cD6HdcW+5QXQm9MNUL1A8iu?=
 =?us-ascii?Q?hOcMBAOPh3LVWfROS2UaVISDNjTvewkiOYzRsN/kGXvG4KAayoUGuFj3F/dZ?=
 =?us-ascii?Q?/IQFqRCLoAm6qoRFj/EgQNEbES6RhBD1CN0XTE1o+Nw7mLFdnsJrQ5Qi7SkU?=
 =?us-ascii?Q?KgdbV/+R+A5gXwws+2uW3+2zEFz8VVcbyy4UCTGJzxyh/UpDF5qma3C1jcX6?=
 =?us-ascii?Q?m40DVhzpBj5q1wK9Ou7c5Xzj5indnhSNqNn2iOmCp3VTtaPu6ZhrzwYZReWz?=
 =?us-ascii?Q?1m1YYoT/i1ORN3ifZxp42pKk4a3dE7tgHnkNLlyU7nLszY4xDNTMZqK7zNvh?=
 =?us-ascii?Q?U7g5gB4dfrxG5tRKtGU+xAg4I5EiJoLTOiuUiRasqc8X7FInjQGCFk977cdJ?=
 =?us-ascii?Q?7MYvQrGy6bc3a3QkU0LjP6/543emDC0UMhX/ZkVH332Jtvx7/Gd2AMF4gxE+?=
 =?us-ascii?Q?onYJtBTkcE68U3UbtMWJSc5AF9qwjM9PTuh/dsTIOws8XubRsgQXN/dj1DS3?=
 =?us-ascii?Q?b0SoipIFwZcVo2PM8NG6v2tEWIMYSZLgHEczc19EmHhEoxm/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6b1e92-2a92-4241-c8d6-08de95747cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 13:41:07.4180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3utWutUpWcQ6pdR9OVRR4JMij+zTbT2rYFv3/O71CEfD6BfWz6PbLxKFC96r+ZOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: Benjamin Cheng <benjamin.cheng@amd.com>
Sent: Wednesday, April 8, 2026 8:54 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedeskto=
p.org
Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Ch=
eng, Benjamin <Benjamin.Cheng@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu/vcn4.0.5: Remove unused define

As part of the previous cleanup, this was noticed to never be used.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_5.c
index cbbc02d68695..a204a0f5c44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -48,8 +48,6 @@
 #define VCN1_VID_SOC_ADDRESS_3_0                                       (0x=
48300 + 0x38000)
 #define VCN1_AON_SOC_ADDRESS_3_0                                       (0x=
48000 + 0x38000)

-#define VCN_HARVEST_MMSCH                                                 =
     0
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] =3D {
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
--
2.53.0

