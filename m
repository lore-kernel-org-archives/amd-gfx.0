Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72DCCDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 13:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CCD10E2DB;
	Mon, 22 Jun 2026 13:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X/4QqEGn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD92610E2DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 13:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUTjYHJDM7RPI7DL7Ea0phevfM3I2jOLx2juavnfF/fKxArea5y0W3PczuxvZv9t/lbyRWK/TAcaSiSxWTgmDcoKO85XrYNi+HlIWjBRSKMT+1LVzz8dYiqR1WgYILm8P3LK58lVct5UNKEMAVLoy9AexzP9Lt0HxVL/iQvhV7s2v3BY5vveVSz2k3oUtDqIVkZxWqmAyaG1GJBHkkI+XQQdGmgcKpSln7yxW7Kc+5WyRr9SB9OQm70JiXw7DdfCnREJxOp3ELa7ONNPV78/Dgl1K+1/AGCC3FJpbo33bI33toYuSCjD9jpHFsrR4LCGKfFmARAYMbU7ZJvHtCh3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9j44jxZhZ3aHxSkf5oTypghfaSj4X8dRay0MFTyTr0=;
 b=VstW/l2Fk0i9JL10UT4DvrC91C05MAbvMQ6/BLDBaFH54+crh6gYlfdbNULiGX8wJZk49UtcQ423FqwecFB+nTMOQv0y4R9r19N8tnMNELqxDBwNjIYEDuxCFyK/Y1ud0zQI+su9RZRFO+5pIp8UV8b9hdMyDxIahqeV3n49k/koohpf61erWCxQ+uZZJYbYwHdJSkj+OTZo9yaL3cecZDofJO8f/mNwrg8auiyaVmgPtq3OhbwUbaAcot7PnHq/8/YXYzGnLGWVbXtnixpylAha20KG16P3X03owjvhloAlPOpfS4GRcpdaOhUbzzlZKuW2iofOqN+PrIVXL9jd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9j44jxZhZ3aHxSkf5oTypghfaSj4X8dRay0MFTyTr0=;
 b=X/4QqEGnjwyDYRpfbXs2cwbPXYR7YwYUhubqW7u5Cw52sVJNP3SXaprxMZXa8jBuqAuNLnASoCDLunUcefpgFobORmqC8lvN39kuYSuUu7uLIsH03xZCMfTRcAB/wXr4xJddIbpotbBM522svkdDQxS0aWmUxAbvIFtXaDi204Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 13:04:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 13:04:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: bounds check atom indirect io method
Thread-Topic: [PATCH] drm/amdgpu: bounds check atom indirect io method
Thread-Index: AQHdAinVM6XXC8/D2E+ucBVNXeAZCLZKispA
Date: Mon, 22 Jun 2026 13:04:21 +0000
Message-ID: <BN9PR12MB5257B1CF92DFE0A7DBA6AEADFCEF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260622093037.1311370-1-lijo.lazar@amd.com>
In-Reply-To: <20260622093037.1311370-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T13:03:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: 8d7c6699-a65c-434c-edda-08ded05ec6f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|22082099003|18002099003|11063799006|6133799003|38070700021;
x-microsoft-antispam-message-info: 9m6GzHxgIS3IG5d39KRfQj6HrokoqBhFgIxV6oKLoMSjp/iJX4KEEWdfv+nnvrpA7WQL2uUaP07QdNjs0o/gO14ie3bsa9UqDUfLEFJ0jmct5SqsEjLVepuykrKGOrw41oxlr3U3+GaszuqE44bL9nkdj/XeEppvZ/PF+tROQ5/qxhfKUf2oLimf9t0wqEoyIZjrikCtQYD08ZG99/OURKWonnyY9kjYSuhCGdruE8CIzzEvDjG8vW35ONHymg0mTdedTjVhNgR9hyRB1NIeDT/gbAnv7KsuoFI2hroTfOyS4/0pxck5r1cjPMQH3v1PxxBbZPNsxNwwhoCO1l6w5Jrm84wDUByZP4i/VxwyX0NMYu99cw1F19zXJZyvDGQdP5viD4V49rvofCL/aqd7nbIxjaaS9BOPZLiDPeHJUq/5NXmwyaDHvjS+2HgubTZO2uVdEkiyB0nGwvEy9r5u5CGEKEJUd4MppSam2Qv/NUxfta3ANjmXZneJPHKqvjW3VxjrHCfGCq3Prpra7VF+W3OHJdoHV9a25/GnR1WK2MW9GmUumaTgn/bzBnVpAz3xjIQUCrQPQ0N1ahZZeu3zw21cCGoSFy/iCMVpJy2kOPDoVvJMi8xY48q1rOQWN1Ho0FTfy2UxGOEASzMKved/GAZC4aOB1CAYc/gpUlH8JFBso1hWUp3M9O5mdA+EGECO7DPsoSLOThXqOKlIDYIbyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/+DgYmR4Rkhle1HylAQ0Ep009vuoOvNhNk8dC60Acd2dVzJoHtXf0KjkwPoo?=
 =?us-ascii?Q?6QkxSizESCUUR33PRVWM2x/YeUTlzHEgMWxeG697V9nn4HAPte9sPEhuYZw2?=
 =?us-ascii?Q?tWQEym5YazLZYYP7iIgFW43P4BK4Dossb9p8udCHK7msQeizW2aJPenmVZiR?=
 =?us-ascii?Q?dTyS8+YmAdM4eki8SBXwsgiH4+s5Wxo5PAWwgpzgin8UcQEDd/xiIvIjhSMr?=
 =?us-ascii?Q?idzGu9nPKl++rJTwnfpnd3xJD3Jo3v9jFrv7L9nF1s+cjqL9/BtUHGOpRgK9?=
 =?us-ascii?Q?3G8Xm2Wl755Z39ietEPBlobOp69gKSGLtWlN8bp7H6UYB20lHw6kfPpDkr49?=
 =?us-ascii?Q?qX7WGWlzSfcOIftuGvbuCrZBJiM+tq2rZt1xF+wzZ3Hkvl/Fylu9sD4BQc2D?=
 =?us-ascii?Q?NqzAI2zrfhtlTdKu3CALgGaKuXDIDppv+Z2HQpOMnluOskO7lHer3ODf6M/F?=
 =?us-ascii?Q?m4LuPbhE5rcda7u3x1i8kO6yUpv5H37mKRMKs34mlbFRY5KB6Vby2BoyXcTC?=
 =?us-ascii?Q?qqYcHOJrebizicunovDxInkfW0NPoYjUULrnmH6QMm59W+TV+//bIkmsvWka?=
 =?us-ascii?Q?xVD7jtFTjorfK+qxscuPmh7HsAy4I9jbQdgFrmyzUq1lFOSqtqikxSl5U4+3?=
 =?us-ascii?Q?kkOlwNeOuECOLFl2k19yw4/iJC2GCCnI8w5UFAHMqw0qXGE9TnZLVwqTlTi/?=
 =?us-ascii?Q?65BFDKPrcAlYJ47yiO+7jtsuHNn2xW0OakMffID+EJpCa69QqtJDy8E7CXxW?=
 =?us-ascii?Q?yWu7jK6DCLq+c0So2fNpz/3fNd2JQlNubmgfNplrmENFbbJ9v7XuTCcNWLTb?=
 =?us-ascii?Q?gX6rpK7aHgGN8DFXe7zcoEE/GVAH2ZvNJbUonIZFQZP9A8fXDiHrQQNSDPNd?=
 =?us-ascii?Q?dFoe1sAx7RgRGDNp4zXqkBO6WbhhceggiYI8wbzr5lKjOjlK9RCwYXYpwPRV?=
 =?us-ascii?Q?TljurLcZy6Q+1V28e60KypTPRSZOsxujmRj9oIllryHFFbnIhSyOBcNmg2ry?=
 =?us-ascii?Q?IbpKbcXd3cYX+5IdB3rHAdvzhSHaDDehM3YHx2FTwiGkYAbhxd+YSo63Lr7s?=
 =?us-ascii?Q?WfswUN8GRzLKq5UJRvv1DUzinvS+rHzHg684z/ubR+4yk5G4B7jihh6z2qpK?=
 =?us-ascii?Q?XXvhSWvh/bxyxn4h75iO4JXQQtwIOYe2Y3QJ/9OUq6c/3Qc2kNC/SYXtjV2n?=
 =?us-ascii?Q?I7rsGoLpRkyroocfpKnR1qFpDEWaoIq4j+Sx86W/GYxeS1//USeXM8/snTA8?=
 =?us-ascii?Q?I+0HPkXAnkR3OfGpYNPWa1AsSN72U2Gaa02qE0YpLHFWvLNIawhux729a4+x?=
 =?us-ascii?Q?gONagwuDha7zQ5Z9pjqsYvjAp5wQjFaE8/HoygHskKOuiubBcRA7T0MnVO7x?=
 =?us-ascii?Q?qy1t3epKxD8UUwzyep/cHxO3eTSMokcWs1eFJMLt+o1n0MRrNeAZXuUbJGKW?=
 =?us-ascii?Q?6/VGDB0cv/8+lwED4FP5hh9Aevw9utrAibrdR/RNGC3AOHAsyIjv5O9R28TS?=
 =?us-ascii?Q?iK+GwZNQYiNKfQG9XPQHaBR6PaeP9am2+qYIqcS3yAr3DDGAJntXJh0B936D?=
 =?us-ascii?Q?dhhGZ6wcfogsisbG1OFtg9NHM0VONkMggqDbYOWKS5ERbHndDhKJ6OGSXOCh?=
 =?us-ascii?Q?o14OiZJUA+yHfkwfnZEihUA8DfIc8QIlhSDIbrZjYbc4dOqMV87/Q2ZuUyrc?=
 =?us-ascii?Q?OaFQ1IdReSLq2S3ncAD0KDLpBR/RR/N0szVyIvhGkSr4+Qo7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c6699-a65c-434c-edda-08ded05ec6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 13:04:21.6475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZpyJo8o44ZUDzx4QJ0hjAWvI68WMiYP9uE45FMQhrHRWl5fe3Gri6Zn0ecR0Mil1c2TF/Q548KJleLFKHnacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 22, 2026 5:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check atom indirect io method

Bound indirect io method execution by the BIOS size to avoid out-of-bounds =
reads.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index 0d5be1795972..d4a652d2b453 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -114,8 +114,10 @@ static uint32_t atom_iio_execute(struct atom_context *=
ctx, int base,
                                 uint32_t index, uint32_t data)
 {
        uint32_t temp =3D 0xCDCDCDCD;
+       int start =3D base;

-       while (1)
+       /* IIO opcodes read up to base+3; keep within the BIOS image */
+       while (base + 3 < ctx->bios_size)
                switch (CU8(base)) {
                case ATOM_IIO_NOP:
                        base++;
@@ -180,6 +182,9 @@ static uint32_t atom_iio_execute(struct atom_context *c=
tx, int base,
                        pr_info("Unknown IIO opcode\n");
                        return 0;
                }
+
+       pr_info("IIO method starting at offset %d runs past BIOS image\n", =
start);
+       return 0;
 }

 static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
--
2.49.0

