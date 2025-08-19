Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DF4CA0EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 05:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A814110E52D;
	Tue, 19 Aug 2025 05:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJhM3O1S";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181FF10E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 05:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEi93A8EISxV2ybkV1S2ddEqT0SLQI5lmVHjK7NPBG+cOHXFlgtMP9svW3Zp4W34Q6SrKiJjqQooRGHB4l3xseSKAWgQ8CqGIhedaqHX7ChtvMSEtpE/VoC9eM9G17ZP4/jFkzvgZAiJdAyzRvRDQS3YlfQike/bP7xhoqwL7qPLdG72zAGy+Gn0v4NrB8E6bjrJqzZjrnsws+VjQmJUC9VnC92kshn9XlfRjcEC6d/U0hPmugf1xbIFmg97ODQnvt36aANZ4R4wgNDe3PeYfR6PfQFofXNQnCJiDmEsr9ZxnU7ROfdAjEiU1lR7pG8zIITRhUjfRKtzsoZixWpklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPzhygAFgaYVOvoyXtX1P5LR9eTNkXDhZMb0wWu6Q7Y=;
 b=n4u49JIBDq5Sf2c89Sh3QR6vZRHQUmnTiZH0U+wgOEg4LsPPwIwogpXzZn6sr5NzAiHEfMX3OYYvWiHeTmuzVsxd3F/EnCy06zu/uHMyN/6TG6wMKl3dzQapwRoE9E0i3Qo+EfjUm8K63vEYCIaeJuPKgFNoIlxuNXEoDO6xYUUU0VvpBPV09vZVr7exZqM4Js3A0uCtj74BC/P+EAdN/1D+3mwWj6UQZzVjJo2qYLVtJ/sYX109Nqlxb9BTMUv8qXS3zfv2us5kE6304EsVMMFw2WsgnQD9enkiJpPAPyhb7VMYaIbvMgIA69HC6fGmWkEfCdbVEQO1H+Ojx83FCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPzhygAFgaYVOvoyXtX1P5LR9eTNkXDhZMb0wWu6Q7Y=;
 b=uJhM3O1SRKCJYuPHPokB5SRa4bPSNs5v1SVyRz1Dngo0ytSsQ+M8nuuFNj0eI71lvNN6UXFWlideMOx18XlqCpY37MijSsRGAAwnH4GtAdiWAMXYbHY0AGMmfynvegLjfHEuCtIVA1bzV8YNmTIZQ2JOVQlsFwejL19wP09XaIs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 05:54:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 05:54:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 4/4 v5] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Topic: [PATCH 4/4 v5] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Index: AQHcEFCIZaSxGITqCE23BLC8FZ7jfrRpesOg
Date: Tue, 19 Aug 2025 05:54:27 +0000
Message-ID: <BN9PR12MB5257DDC91A46359CB440C576FC30A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250818145757.318636-1-cesun102@amd.com>
In-Reply-To: <20250818145757.318636-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Candice.Li@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T05:54:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV3PR12MB9268:EE_
x-ms-office365-filtering-correlation-id: b1e5c656-89fc-4d2b-4278-08dddee4dbbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ihF7ZVbs3MWCFI2mNxVAF5Ytdy2q1M0kgfnDXKwYgYRZKKtgmL+mFKlR/KZ5?=
 =?us-ascii?Q?J9ADSxRLLKDJTdTF8OeNP3NgXt4MA1Rn1CSfK4EsazJic0icHauEUdUCl2LV?=
 =?us-ascii?Q?oFtGr6tPPKYxODl13H3tajQmV05BbC/RfH6fpDwX62tRytqDjzVdcouLaGLn?=
 =?us-ascii?Q?sI9jKhmUqeEWGYzSK9J9t4P+vBHJjjFJ/vNXJxOZ4rYUHdfUkD4oKQ6g8/16?=
 =?us-ascii?Q?ecJVMNhD00hmKqFhv5NWL7aEZmNcRCrxIiJToXvEsqLdTBmpCEN2cMrqlq5W?=
 =?us-ascii?Q?RjVrRCG6hnnnR2ZSXfDZbN2UCAGIyrqhFCNTFcdxLuc9OY8QksEmi4L+DH2H?=
 =?us-ascii?Q?Ypv2Bp7UCXPx0X9bdPyAKVsZV/3iY/G4sYgs8OAf44+8gpGV6qmT9w9qFCaj?=
 =?us-ascii?Q?5yXVgaUdRwwFJ3/CB9Ep79nuTxFWWkYpV8R5NyYWhFqJnqxpbqNKfQxh4oAD?=
 =?us-ascii?Q?u1T3l2blaDMjqm/0OC7t2RV97YOcBaciQw9O0bn/cbGW8iOl8wpD0siHBzoA?=
 =?us-ascii?Q?aFe1KM9yi1iE7pYx3a1H6zxBg3pIXn2uPHOxYlHPlB9MEOKldNKvq69bPDT3?=
 =?us-ascii?Q?+V+UCDi2nkFdX2jo6EOdLXCrStzVr0CgDWOLxBa2pL7AodWkre1kbW1qiKWZ?=
 =?us-ascii?Q?Ip6kPPEK2tSjLt/TPWo1fgxjCrMbBaJ/xv5cyc6sq6LmcjtO10lVGrd+Ta0s?=
 =?us-ascii?Q?CPEIRHcsNZu1CxDa/xV1TSgei932EkiDQmbZLuYZTwlllJfCemSiaKRxpvRM?=
 =?us-ascii?Q?INE3hJIvF3EAm2io7FhS6qkpqkAQSp0xT385RIl0VZQZGT2S+6ZL29oK64EF?=
 =?us-ascii?Q?6xi54R1QWIr64q/y2x4nyZZjcQWlx1/XPs90Ok6UZ2VW7CJS+1LKMyvPiNA1?=
 =?us-ascii?Q?xLL8YJt09z4BmILbJKGMH8iSgyjAos/19/7J+IqAlESKKotv0qJoI1NljRSq?=
 =?us-ascii?Q?xmjIselPAy+oxTSUoFnWtrx4YtC1JV1oEAO1wHb/1M3X2qj+FewZwCVrsVGh?=
 =?us-ascii?Q?Y6Z9PWHP3gmmt2gflfRnLVOP+6/maFZM7z45c65nmhe3GzRGa/6F2ZpkciA+?=
 =?us-ascii?Q?DmlHHnAngupkUDNjAqhN1+rV2xl4cb+GSUbOiceWlDtiP7P2biqjEWJ7PGmM?=
 =?us-ascii?Q?k4H0PxOI8vdnWCfIzoJvCb8Yc74RpTdpJ0Y41azkLVpWzKvO0QKfPZsGnisV?=
 =?us-ascii?Q?ur6/Ws63M73Aef1jwSDBAlJBCY2WxTX+erWI+tbVE2dGMe+N9rt5eo+LVvCN?=
 =?us-ascii?Q?Qc7ChqfIzw3S4d6Sil7YtVYCVbTIgBxJC2+SNeIJju1jNC53i2uog4t8cq5U?=
 =?us-ascii?Q?ZjznBGmL4VRlrj4Ncxm2l4qznjH8fzK/ATsTPwKlNPx+ZiJrTJ79lDDFwMhU?=
 =?us-ascii?Q?ZcxoGJzfnwADvkdmIo144D/zaXd3vLVu+cJ3NZGp94rz6AG+iSg0LEKGDLLY?=
 =?us-ascii?Q?UEGZo7RzO+mdmZHfmWd9IYa1OHkecDJ6kSRXAWV/nQ6H+KAtAWCyFF6jV8Sz?=
 =?us-ascii?Q?CYmN2Ngkm/hjlW4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WUhzoDKcaC7tCRncs+wTOw5aWAxXXfvbAMqUArIcRliu7+NGKQaggsvoWNOw?=
 =?us-ascii?Q?uw1AVA6XUd8QGm9xbFL1OVuIfarxg5oipJ9BKe0aAvLT/OUv7f/U6SKJGvi4?=
 =?us-ascii?Q?IMr8ExnTAth6ppRNZNZ6yWNSsZPfwmdZh5d6duS2aVdTgucyxquEK0OyOY9J?=
 =?us-ascii?Q?GEdMwpWtX5URVXbh40sYHTOqTGA9yDsSWlHIMLzK4/tNQk1fkLIBwiBdYGmN?=
 =?us-ascii?Q?kyvzKBRQrKf8okoX6u4gOVwvXNYJxYrJHYlyg2GKY5kNd+SlWQDMZ6tpeIwC?=
 =?us-ascii?Q?a8sjFLnmbBzxWuSH9EA+oGgWZXApO5OVZg3uss/4gh5g5ORf5iM91xTjTenJ?=
 =?us-ascii?Q?NNusy7bbymjMjUA4KltU1XqfJ9wcF+xGWYEVHZfRBldI1Nr2zH7E+xA7aaD3?=
 =?us-ascii?Q?+kbaEp37ND/XCd1gG89czqkB701eHPnsMqUZf0PFF1IQ4f0Up2+1VoT2DjSX?=
 =?us-ascii?Q?FOTv3kuxtJNuVQjHu+I1XZvNpmkaO4UZjtOYTRVLFIO+sqFHckhepTlfbnK1?=
 =?us-ascii?Q?d7LLG3HpyCqoLNTdkuOaNMdeCvnuqNOk6eRkUKsavJan3veApBN7Q+sYph23?=
 =?us-ascii?Q?kQSSApLCX2PhCRcsBJi0VRk82CJXDwVqEh8AltfZTzTMrTVY5KsUz+OcjWbl?=
 =?us-ascii?Q?6q+XBIFKnbWzwcqqxkyGQ/ORp6szH/07q/KxZIv6RnLvTyNNLPacSt4t7Z8L?=
 =?us-ascii?Q?o/8BM2IwXvPJk4jUk12wkPKyNmABOoT3d2PmZ3B/wsEnsR5YLSDzPWpU+Twy?=
 =?us-ascii?Q?lTXWwAijM3W/rK7V8/fLxAiBUX6oBhQpjTcAK9IEq+T/FLC6j1mUAo+L+Pwv?=
 =?us-ascii?Q?wLt14uIPTVoYylTrTlfcvUWixCbjiOUXcsoCz++t1nrJ8oYcwh7wqHvq7R3J?=
 =?us-ascii?Q?bvBGwWVC1I6Ff2o0pRJyAqWAyn1Lqns7uGkxrmE4sZYTSWKXQhc/krC7aTkS?=
 =?us-ascii?Q?yhBKRYXErLLoMpqPLIYRgaj0yHXE4o5tM4PVTROxa1BVqxmjqSqSGEu/2q5L?=
 =?us-ascii?Q?QDeYdNwyqs8gbqHE7gVtoayYzxI3qyx0qtkavVXnRLeSB5zCYvZ/Fu3PsFv/?=
 =?us-ascii?Q?6qW/aGdxer/org5KMZ08QoSLCDyqja3JIAul3ABx5F4upLHEhWSBGSm8G4Gg?=
 =?us-ascii?Q?zxbiBTr5YdgixwD8qsMLVsieln0gCCHoMK0FW5qUjjXXB7C4jvWrCpVKRoJs?=
 =?us-ascii?Q?zkkhH/cJISsMrLL2WCbN9X9Iw9ZAWk6nh5nxtlQhGM+aMI9HwrF9W1XFupvZ?=
 =?us-ascii?Q?j3hw+jgYV2QULlJelTSx5d3MpAD05205ZpPn6r2fjocF+gSrAPGnMH+riGeh?=
 =?us-ascii?Q?XFSOLtjjsJMODwZux0whCuT+LmaUcHyVmOpR6b6Wc6hfwKx1rjraM/lIMltF?=
 =?us-ascii?Q?D1Y/hkNy+NTnd3pYP8kfinEbyBUhL7iiDlRKvTToVFDp+rHTn4ALkNrld7RF?=
 =?us-ascii?Q?/eJGohS4Ts2vtch/nnw2VfUIm83U7WAfg5yXJcV+R1Uu4DovEewZYHHiP1S9?=
 =?us-ascii?Q?kNfFIQLq/B3uZGMrf7aN/KJcvv834T4GBytkmNQnbJfaOuIkP+PLjh7Joo/S?=
 =?us-ascii?Q?gjWhIrMdVdoy4fmmxUA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257DDC91A46359CB440C576FC30ABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e5c656-89fc-4d2b-4278-08dddee4dbbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 05:54:27.6467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0VsucGPSJDAO1VSdzg14RdPnehqdSsoKDuQfnlzmN9T3FQRGxs53hHYh9QLHmFZJQE6dmaPQswWp6Z4vPGvcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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

--_000_BN9PR12MB5257DDC91A46359CB440C576FC30ABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.=
com>>

Copy @Li, Candice<mailto:Candice.Li@amd.com> for the awareness.

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, August 18, 2025 22:58
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH 4/4 v5] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

v2: add corresponding delay before send msg to SMU to query mca bank info.
(Stanley)

v3: the loop cannot exit. (Thomas)

v4: remove amdgpu_aca_clear_bank_count. (Kevin)

v5: continuously inject ce. If a creation interruption occurs at this time,=
 bank reg info will be lost. (Thomas)
v5: each cycle is delayed by 5ms. (Tao)

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 ++++++++++++++-----------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +-  drivers/gpu/drm/amd/amdgpu/a=
mdgpu_umc.c |  1 +  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  9 ++-
 4 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 31850a47a41f..a779336e2fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  200

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -131,6 +131,8 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 #define BYPASS_ALLOCATED_ADDRESS        0x0
 #define BYPASS_INITIALIZATION_ADDRESS   0x1

+#define MAX_BANK_COUNT 12
+
 enum amdgpu_ras_retire_page_reservation {
        AMDGPU_RAS_RETIRE_PAGE_RESERVED,
        AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -3306,8 +3308,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
+       ecc_log->consumption_q_count =3D 0;
+       ecc_log->creation_de_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3326,8 +3328,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
+       ecc_log->consumption_q_count =3D 0;
+       ecc_log->creation_de_count =3D 0;
 }
 #endif

@@ -3381,49 +3383,50 @@ static int amdgpu_ras_poison_creation_handler(struc=
t amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       struct ras_ecc_log_info *ecc_log;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
+       uint64_t creation_de_count =3D 0;
+       uint64_t consumption_q_count =3D 0;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t bank_count =3D 0;
+       uint32_t new_detect_count, total_detect_count;
+       uint64_t pre_bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;
-
        ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
+
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;
-
-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               creation_de_count =3D ecc_log->creation_de_count;
+               consumption_q_count =3D ecc_log->consumption_q_count;
+
+               bank_count =3D amdgpu_aca_get_bank_count(adev);
+               if (bank_count > pre_bank_count) {
+                       new_detect_count =3D bank_count - pre_bank_count;
+                       pre_bank_count =3D bank_count;
+                       total_detect_count +=3D bank_count;
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
+                       --timeout;
+                       msleep(5);
                }

-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
+               if (creation_de_count && consumption_q_count)
+                       break;

-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
-               }
-       } while (total_detect_count < need_query_count);
+               if (total_detect_count >=3D MAX_BANK_COUNT && consumption_q=
_count)
+                       break;
+       } while (timeout);

-       if (total_detect_count)
+       ecc_log->creation_de_count =3D 0;
+       ecc_log->consumption_q_count =3D 0;
+
+       if (creation_de_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        return 0;
@@ -3516,7 +3519,7 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                                atomic_sub(poison_creation_count, &con->poi=
son_creation_count);
                                atomic_sub(poison_creation_count, &con->pag=
e_retirement_req_cnt);
                        }
-               } while (atomic_read(&con->poison_creation_count));
+               } while (atomic_read(&con->poison_creation_count) &&
+!atomic_read(&con->poison_consumption_count));

 #ifdef HAVE_KFIFO_PUT_NON_POINTER
                if (ret !=3D -EIO) {
@@ -3534,6 +3537,7 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                        /* gpu mode-1 reset is ongoing or just completed ra=
s mode-1 reset */
                        /* Clear poison creation request */
                        atomic_set(&con->poison_creation_count, 0);
+                       atomic_set(&con->poison_consumption_count, 0);

                        /* Clear poison fifo */
                        amdgpu_ras_clear_poison_fifo(adev);
@@ -3558,6 +3562,8 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                                atomic_sub(msg_count, &con->page_retirement=
_req_cnt);
                        }

+                       atomic_set(&con->poison_consumption_count, 0);
+
                        /* Wake up work to save bad pages to eeprom */
                        schedule_delayed_work(&con->page_retirement_dwork, =
0);
                }
@@ -3663,6 +3669,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev, bool init_bp_info)
        init_waitqueue_head(&con->page_retirement_wq);
        atomic_set(&con->page_retirement_req_cnt, 0);
        atomic_set(&con->poison_creation_count, 0);
+       atomic_set(&con->poison_consumption_count, 0);
        con->page_retirement_thread =3D
                kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_p=
age_retirement");
        if (IS_ERR(con->page_retirement_thread)) { @@ -3723,6 +3730,7 @@ st=
atic int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)

        atomic_set(&con->page_retirement_req_cnt, 0);
        atomic_set(&con->poison_creation_count, 0);
+       atomic_set(&con->poison_consumption_count, 0);

        mutex_destroy(&con->page_rsv_lock);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 6265dac0e1c0..f5797e53f966 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,8 @@ struct ras_ecc_err {  struct ras_ecc_log_info {
        struct mutex lock;
        struct radix_tree_root de_page_tree;
-       uint64_t        de_queried_count;
-       uint64_t        prev_de_queried_count;
+       uint64_t consumption_q_count;
+       uint64_t creation_de_count;
 };

 struct amdgpu_ras {
@@ -557,6 +557,7 @@ struct amdgpu_ras {
        struct mutex page_retirement_lock;
        atomic_t page_retirement_req_cnt;
        atomic_t poison_creation_count;
+       atomic_t poison_consumption_count;
        struct mutex page_rsv_lock;
        DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
        struct ras_ecc_log_info  umc_ecc_log;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index bfc86f1e84e5..983a428eddd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -254,6 +254,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_devic=
e *adev,
                        if (!ret) {
 #endif
                                atomic_inc(&con->page_retirement_req_cnt);
+                               atomic_inc(&con->poison_consumption_count);
                                wake_up(&con->page_retirement_wq);
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
                        }
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index e590cbdd8de9..69c22bdaed3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -536,8 +536,11 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_d=
evice *adev,
        hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);

-       if ((hwid !=3D MCA_UMC_HWID_V12_0) || (mcatype !=3D MCA_UMC_MCATYPE=
_V12_0))
+       /* The IP block decode of consumption is SMU */
+       if ((hwid !=3D MCA_UMC_HWID_V12_0) || (mcatype !=3D MCA_UMC_MCATYPE=
_V12_0)) {
+               con->umc_ecc_log.consumption_q_count++;
                return 0;
+       }

        if (!status)
                return 0;
@@ -582,7 +585,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
                if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_queried_count++;
+                       con->umc_ecc_log.creation_de_count++;
                else
                        dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);

@@ -590,7 +593,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
                return ret;
        }

-       con->umc_ecc_log.de_queried_count++;
+       con->umc_ecc_log.creation_de_count++;

        memset(page_pfn, 0, sizeof(page_pfn));
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
--
2.34.1


--_000_BN9PR12MB5257DDC91A46359CB440C576FC30ABN9PR12MB5257namp_
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
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Seri=
es is</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font c=
olor=3D"#467886"><u>Hawking.Zhang@amd.com</u></font></a>&gt;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Copy=
 <a href=3D"mailto:Candice.Li@amd.com"><font color=3D"#2B579A"><span style=
=3D"background-color:#E1DFDD;">@Li, Candice</span></font></a> for the aware=
ness.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt; <br>

Sent: Monday, August 18, 2025 22:58<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; S=
un, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>

Subject: [PATCH 4/4 v5] drm/amdgpu: Correct the loss of aca bank reg info</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">By p=
olling, poll ACA bank count to ensure that valid ACA bank reg info can be o=
btained</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v2: =
add corresponding delay before send msg to SMU to query mca bank info.</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">(Sta=
nley)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v3: =
the loop cannot exit. (Thomas)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v4: =
remove amdgpu_aca_clear_bank_count. (Kevin)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v5: =
continuously inject ce. If a creation interruption occurs at this time, ban=
k reg info will be lost. (Thomas)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">v5: =
each cycle is delayed by 5ms. (Tao)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 ++++++++++++++-----------&nbsp; d=
rivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 5 +-&nbsp; drivers/gpu/drm/a=
md/amdgpu/amdgpu_umc.c |&nbsp; 1 +&nbsp; drivers/gpu/drm/amd/amdgpu/umc_v12=
_0.c&nbsp;
|&nbsp; 9 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 4 f=
iles changed, 51 insertions(+), 38 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 31850a47a41f..a779336e2fd3 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_blo=
ck)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> /* =
typical ECC bad page rate is 1 bad page per 100MB VRAM */</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024ULL)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 300&nbsp; //ms</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 200</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100&nbsp; //ms</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
131,6 +131,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_blo=
ck)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine BYPASS_ALLOCATED_ADDRESS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine BYPASS_INITIALIZATION_ADDRESS&nbsp;&nbsp; 0x1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine MAX_BANK_COUNT 12</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> enu=
m amdgpu_ras_retire_page_reservation {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_RAS_RETIRE_PAGE_RESERVE=
D,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_RAS_RETIRE_PAGE_PENDING=
,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3306,8 +3308,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_in=
fo *ecc_log)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;ecc_log-&gt;lo=
ck);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_RADIX_TREE(&amp;ecc_log-&=
gt;de_page_tree, GFP_KERNEL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D 0;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;consumption_q_count =3D 0;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;creation_de_count =3D 0;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -3326=
,8 +3328,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *=
ecc_log)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;ecc_log-&gt;=
lock);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;ecc_log-&gt=
;lock);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D 0;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;consumption_q_count =3D 0;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;creation_de_count =3D 0;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3381,49 +3383,50 @@ static int amdgpu_ras_poison_creation_handler(struct am=
dgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t poison_creation_count)</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info *ecc_log;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_query_if info;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D 0;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info *ecc_log;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D MAX_UMC_POISON_POLLI=
NG_TIME_ASYNC;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amd=
gpu_ras_get_context(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t de_queried_count;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t new_detect_count, total_detect_c=
ount;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t need_query_count =3D poison_crea=
tion_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t creation_de_count =3D 0;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t consumption_q_count =3D 0;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_event_type type =3D R=
AS_EVENT_TYPE_POISON_CREATION;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bank_count =3D 0;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t new_detect_count, total_detect_c=
ount;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pre_bank_count =3D 0;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(in=
fo));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.head.block =3D AMDGPU_RAS=
_BLOCK__UMC;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log =3D &amp;ras-&gt;umc_e=
cc_log;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D amdgpu_ras_query_error_status_with_event(adev, &a=
mp;info, type);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; de_queried_count =3D ecc_log-&gt;de_queried_count;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (de_queried_count &gt; ecc_log-&gt;prev_de_queried_count) {</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count =3D=
 de_queried_count - ecc_log-&gt;prev_de_queried_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_=
queried_count =3D de_queried_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D 0;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; creation_de_count =3D ecc_log-&gt;creation_de_count;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; consumption_q_count =3D ecc_log-&gt;consumption_q_count;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; bank_count =3D amdgpu_aca_get_bank_count(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (bank_count &gt; pre_bank_count) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count =3D=
 bank_count - pre_bank_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pre_bank_count =3D b=
ank_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count +=
=3D bank_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_UMC_=
POISON_POLLING_TIME_ASYNC;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count =3D=
 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(5);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (new_detect_count) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count +=
=3D new_detect_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout &amp;&a=
mp; need_query_count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (creation_de_count &amp;&amp; consumption_q_count)</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timeout) {</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (!--timeout)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (total_detect_count &lt; need_que=
ry_count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (total_detect_count &gt;=3D MAX_BANK_COUNT &amp;&amp; consumption=
_q_count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (total_detect_count)</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;creation_de_count =3D 0;</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;consumption_q_count =3D 0;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (creation_de_count)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;ras-&gt;page_retirement_dwork,=
 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3516,7 +3519,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_sub(poison_creation_count, &a=
mp;con-&gt;poison_creation_count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_sub(poison_creation_count, &a=
mp;con-&gt;page_retirement_req_cnt);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } while (atomic_read(&amp;con-&gt;poison_creation_count));</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } while (atomic_read(&amp;con-&gt;poison_creation_count) &amp;&amp; =
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+!at=
omic_read(&amp;con-&gt;poison_consumption_count));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #if=
def HAVE_KFIFO_PUT_NON_POINTER</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret !=3D -EIO) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3534,6 +3537,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gpu mo=
de-1 reset is ongoing or just completed ras mode-1 reset */</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear =
poison creation request */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_se=
t(&amp;con-&gt;poison_creation_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-=
&gt;poison_consumption_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear =
poison fifo */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ra=
s_clear_poison_fifo(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3558,6 +3562,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_sub(msg_count, &amp;con-&gt;p=
age_retirement_req_cnt);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-=
&gt;poison_consumption_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wake u=
p work to save bad pages to eeprom */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_=
delayed_work(&amp;con-&gt;page_retirement_dwork, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3663,6 +3669,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, =
bool init_bp_info)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;con-&=
gt;page_retirement_wq);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;page_r=
etirement_req_cnt, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;poison=
_creation_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;poison_consumptio=
n_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;page_retirement_thread=
 =3D</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kthread_run(amdgpu_ras_page_retirement_thread, adev, &quo=
t;umc_page_retirement&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(con-&gt;page_retire=
ment_thread)) { @@ -3723,6 +3730,7 @@ static int amdgpu_ras_recovery_fini(s=
truct amdgpu_device *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;page_r=
etirement_req_cnt, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;poison=
_creation_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;poison_consumptio=
n_count, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;con-&gt;pag=
e_rsv_lock);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6265dac0e1c0..f5797e53f966 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
492,8 +492,8 @@ struct ras_ecc_err {&nbsp; struct ras_ecc_log_info {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct radix_tree_root de_page=
_tree;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; de_queried_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; prev_de_queried_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t consumption_q_count;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t creation_de_count;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> str=
uct amdgpu_ras {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
557,6 +557,7 @@ struct amdgpu_ras {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex page_retirement_l=
ock;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t page_retirement_req_c=
nt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t poison_creation_count=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t poison_consumption_count;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex page_rsv_lock;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_KFIFO(poison_fifo, str=
uct ras_poison_msg, 128);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info&nbsp; =
umc_ecc_log;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x bfc86f1e84e5..983a428eddd4 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
254,6 +254,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *a=
dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)=
 {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;con-&gt;page_retirem=
ent_req_cnt);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;con-&gt;poison_consumption_coun=
t);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up(&amp;con-&gt;page_retirement=
_wq);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #if=
def HAVE_KFIFO_PUT_NON_POINTER</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgp=
u/umc_v12_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x e590cbdd8de9..69c22bdaed3b 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
536,8 +536,11 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_devic=
e *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwid =3D REG_GET_FIELD(ipid, M=
CMP1_IPIDT0, HardwareID);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcatype =3D REG_GET_FIELD(ipid=
, MCMP1_IPIDT0, McaType);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hwid !=3D MCA_UMC_HWID_V12_0) || (mc=
atype !=3D MCA_UMC_MCATYPE_V12_0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The IP block decode of consumption is =
SMU */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hwid !=3D MCA_UMC_HWID_V12_0) || (mc=
atype !=3D MCA_UMC_MCATYPE_V12_0)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; con-&gt;umc_ecc_log.consumption_q_count++;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!status)</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
582,7 +585,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device=
 *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_umc_logs_ecc_er=
r(adev, &amp;con-&gt;umc_ecc_log.de_page_tree, ecc_err);</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret =3D=3D -EEXIST)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_log.=
de_queried_count++;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_log.=
creation_de_count++;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(a=
dev-&gt;dev, &quot;Fail to log ecc error! ret:%d\n&quot;, ret);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
590,7 +593,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device=
 *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_log.de_queried_count++;</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_log.creation_de_count++;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(page_pfn, 0, sizeof(pag=
e_pfn));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D amdgpu_umc_lookup_ba=
d_pages_in_a_row(adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5257DDC91A46359CB440C576FC30ABN9PR12MB5257namp_--
