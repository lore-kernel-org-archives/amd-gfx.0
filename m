Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE5EC02198
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 01:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C1410E634;
	Tue, 11 Feb 2025 01:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LO926o4N";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73D310E634
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 01:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVJ1TijfwySOcqehEQIWMs1OcDOrQLiUNlCiJfyiPNcnQMFnw5DUoEfSjHk9YD+teRyYYKOW0SBG5Lk+Pmis7/zR3p1sX/bl6ti+Kp418nlW1kmEsaaXLn7zMenFJfz0S9KoBQJQ7wO83URu+yulaZTGW3DEwSc0U62qdfBiPI3qIUv+K1B+ycYhhqbg3Y3mYETNkq0dYNTVNguq9MQ4FDmqCQ4/30/FmuoJdh8z4PpNFGL23HL3KeWiXrbAVqwz3PH7rr5OlXrvg92XJd4LUIrioQaJzfRHwjT72YNsDQy16+n6wwyU75hPJz5p/QBi8T2A9t5//TGxHH9grOhK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNwVjLV5kCQLTarR1L7Uy1RvnirvVnad+y9zbdSbDWU=;
 b=dZAjdpGmiHILZ5vlm2/p/OXN9ZnJzb3bFHMXrANtnawbttUKP5UbHBDB/Pc+W9lfdwg5dm1ZYDBYcpO69hGMgh0mH1og+vBxJBCxZ4tq59ZSmHwx4K6pyL2TLMVhK8OBlr83tOlN5157io/SQd3Wq5xIUrINgcK+ZCWzYjd1L2Jg59ZsSFtLkGn5UexgVVL7iUuIfzxrIkqQuBOUEn+FRBZQH/qV3FoLw3PzBVmJ1rKpwKGQ4Smw0rS/sRkqXdf0LZ+sO45sxqiotcJSy9x/2cdWUdSUc23Hs8eoIWXGYVzbf0dOXgPyvqoT8l1A1WawWSYLphSA6VzahOh36O4wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNwVjLV5kCQLTarR1L7Uy1RvnirvVnad+y9zbdSbDWU=;
 b=LO926o4NHkvB3etsEjfssllTI5AVFsnDx+mmRugLrsbtRYAcmE+gwJy5GZ6U36AjOy9QDmcmZUKUwgjp4Y4vnglkBhk7AnkDW4PsM76O8EvcJgdoIKsh/LPYZQF/KyHxR4jqFTSMvfZWjek9oBZCaW6tlvnfalh2PGoJxu4h2oA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 01:55:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 01:55:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy
Thread-Topic: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy
Thread-Index: AQHbe5IVfx71JXBOCE2eGraJvLHdmLNBWLNw
Date: Tue, 11 Feb 2025 01:55:05 +0000
Message-ID: <BN9PR12MB52576B1DAE0258631428E056FCFD2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250210080149.275167-1-asad.kamal@amd.com>
In-Reply-To: <20250210080149.275167-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ee8b8d1b-4c2e-4ba0-ad3c-ad238df2860e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T01:54:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8757:EE_
x-ms-office365-filtering-correlation-id: b11fe7dc-97c8-4dad-f29c-08dd4a3f1b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7GSB9e9vKUIhZZHZuQApdujdCLV2/kDQtWkDeqoz4og59KdXvqiZutqdocv0?=
 =?us-ascii?Q?x1lwW9+L9TCAWou7OaJMoMBBPsjoUoi0gWpyEYdLtlS7LqSjpjiVp8LCq3GF?=
 =?us-ascii?Q?eMfTB+udOWA2g34Ki2LRdMzmszY30xXW7FnAYW2gNco1zlTAwCZu6IQ2+ESw?=
 =?us-ascii?Q?GC2av3Y2GMzpORTSRGnRE8lf5TXl3/+uINaFlDVCRfXyIlsD2YwMT/Jl+5Ri?=
 =?us-ascii?Q?W+xzwgJfgPLw0IBY3/tgLm5/QydqbQiuQHJnsxh6MAnT8iy2oWU2bAmKB1at?=
 =?us-ascii?Q?bQ+N9XSY0eEKO0cefWtcVaOf0bPtoI5bueTuMq3ibVylKUFDGgzwkxE0EDy0?=
 =?us-ascii?Q?UAsMDCi7qvoGiMVvUpg31atQzZmWH7DHl3LOYsltxF+FpATuvQWo4N9q4i97?=
 =?us-ascii?Q?ddmYxz3giWif0aSymIzgXJMJZ4lRLwS7EKqPTXloism3bRuhMZZ8WSsQHu9r?=
 =?us-ascii?Q?8TxbQ7MjsujKoEeq+q2Ou2LUHFTJnHoDiINWuKaKs535Adieh7LjjWodAcEv?=
 =?us-ascii?Q?AO+wR7maLYUV+TOKqqhfvIeOdrux/ya1e4+T1nJ+GXYz165m0epmbG+lzB9G?=
 =?us-ascii?Q?HqBNkfBnDdv4heEhEoX9uHxaIZXOgdDUu3vvp5h4O2ooFGEWOiSWFJ9mpyBh?=
 =?us-ascii?Q?4rgTfWO754JhcqeOjbmfRSfM1GdzQdQuyMDZry0rzY3sVpdSlyq1CqfPEu4G?=
 =?us-ascii?Q?vrI1kHqLr/MBI5wN+JW1/09eyMkWjcpuTION2CISVksy3tlYpvRKwWrx5MOK?=
 =?us-ascii?Q?2ZUbPGSchOBhovtp8vDJLT+A2aAuVlO9yrgWpQB+XZPeE+HhJca1gbYf40OH?=
 =?us-ascii?Q?qMqB+IKLTsbk6j9lHHmOJX6iF15m//yERD0WmjHVywGxME2juMjgY2hAv+vB?=
 =?us-ascii?Q?sZHeu+UGI+W10Huw+HXqCROMOd1GuzVVLL41cZWLXIdDhAZyUUPirKnG8e+A?=
 =?us-ascii?Q?h7+5jMXqG9/wNMswv6F/BqP3ZODUJgn0nSlXGHsRiefbZ3B5WOvP+XZEuRa9?=
 =?us-ascii?Q?jsF8p/gJg6Idp7XB31dt+eyiCwba/LrdFQlskDdjs7xxZBppE1UWqtXcBtlF?=
 =?us-ascii?Q?6rXAuz7KNpYxP+QgM5FQINDCfX4lSpumuD6G+o/6LXT+RAod8AxpwWkdhsyg?=
 =?us-ascii?Q?tGEaVDEJxT/YRPpBB8IfIrKtw0eHo1PUcX+75fXCHHBCEwJjycnnLpRMbaA2?=
 =?us-ascii?Q?dB3Jp7Zsl1NsE8T8bFs4hRSknJCFHVYQPmUUs4orbjhP3SPHhIquHx8dj0Cq?=
 =?us-ascii?Q?KMd9WrnYYZxtGsWw2DmuREsXqkSS035fSBr36fKXy0/lwvPFqJDcER/TTLZB?=
 =?us-ascii?Q?oUGiDtxIu0u0tUYNC605CFzOaMuq+g8feYiyZUorSH/QROuvzHmMguV4ZWgG?=
 =?us-ascii?Q?0o0+zullJ0B6tGuklCqELHpizh3+H0zxD7qKckowd6nmsixbT2P9+zvOdwEr?=
 =?us-ascii?Q?9oYQhPq8oxAPAx3KVLO66/sFjgIbSPSB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DD5jgpWQOqnzNebUQOYiZUxizXZ6v6ZUmqP4g4DiZd4SLnHfCQMCFNW/ScN5?=
 =?us-ascii?Q?5ZZ8sCrf6rk3AH9Kwm96MZE5XZn/jtCwZD+2486N/Jnwb9CZ0xP0GmRr/H7R?=
 =?us-ascii?Q?KKbSjNGIC0v0xWf/f/jDUVCSFj3/NaeZGQmle4L0K8+l6owpr2iREpRoxwYj?=
 =?us-ascii?Q?LzYgnr0ltFSlvAgvqdCGSdXmf7hRGX8Bfki9LSVG6XiP+BUQhixjCxZTN4GY?=
 =?us-ascii?Q?HstpC37wX/WOYUhvU2Vav2TwSU9dUXdUeV1MUdX4gxKUf2oI2nh2XQ8d7RKE?=
 =?us-ascii?Q?g1N1Rtn/Q5bJGTfM6BXw/d2rj242ftPqyuDYEB2/m4VuDPQU146CvKiuovpT?=
 =?us-ascii?Q?0JgTnDMi/U0WwhBIb8oLTxC1qoc8CX1sFPI24GOchEv0M/mtTUea604ph6t/?=
 =?us-ascii?Q?DJg0Y1Q8XbdHgTJ6LgKAmgQLDrzYVccFi/pj0HNlhS2y6D0BmyIquqwjsZWB?=
 =?us-ascii?Q?C9SlAbWd3IDlkNaP9EVgplQLq6DBbUuxDLsSKQzA10Vj4wWnDXXSTmjfxe1N?=
 =?us-ascii?Q?bur6ah3lLy7HyW0mqCxcsfOBO+VFj8oLq/XoklxUHph4qjEtwQMwwr0xBoZv?=
 =?us-ascii?Q?5XWmGwkMvjjbo422yMYZa51i+1IVSKPGJeDdjbdc+Ldw4CY4thrAtPz58lyf?=
 =?us-ascii?Q?ORs0igqkzbQUu7V2frJ/vF90MbFDR066CdGnFgrBYPT58CIdrTUVqQfVouE4?=
 =?us-ascii?Q?TaYwoTl6vhax+JYpqx9Ue3uTzfDKn1qBtca5laY1fImcGwtNhuDeyhVhuzdd?=
 =?us-ascii?Q?BJcgrwzbb7ik8zHfRamddCwO+LKjrBIhWaVtvA8bnisox9sLz4iih7+Z7m2g?=
 =?us-ascii?Q?0cwRPY5UPu94bKAZR7caN2IkQUK3n3dAvybEcuF5I84BaIPZRsrAcXj4bB6Q?=
 =?us-ascii?Q?XVB/bRz5OFcAyEvw1GkxmC8ZCcscZww28Omsb6M+ySqg58CHpKu8RrMpPzlR?=
 =?us-ascii?Q?1J/hxMBOdF2iTIxGwMTXiX6K0srMhflcc05O82zBuLpBllJ3/6ikhF2xwPI7?=
 =?us-ascii?Q?drHgCyiyDreUI8JfpglQ8MFnO551m3oT1Fy7BJiGL6Fp2QxMupXkI9lSpOmL?=
 =?us-ascii?Q?9fisSIQGBzbEemB4mDvw9lAw6FHnzc55MN3OMSCOhRjrM757Br+UD00DddpG?=
 =?us-ascii?Q?LkXdZNs9NhPn/7Q0AahvOoG2abc/hZVX4kUUYQ00FgX2rMc8gm+V3y1i8PfB?=
 =?us-ascii?Q?FRuVW808r7QPb7ykTzcSQ+AXhE4ihwPM7UhLZRMBd1GBhjmWvKBkm4bVFyNL?=
 =?us-ascii?Q?FRnNJKCyRQPmP2eqnKI60n5hZxM0h4VGEUjOuFsOJ5qcNiE522ljknt+GTtG?=
 =?us-ascii?Q?E39BxRu4zQ72Liiffxrph6BE5HwnemLBp1kwhA/H+w6EhZIKKwIlBjbNsLKC?=
 =?us-ascii?Q?FMq+Bhnxzp/uywpmuBxonUas3NUqK+htrzy5sn1eRTY8QHbS4oy/bVq/Fc4/?=
 =?us-ascii?Q?bJeAYQYzZwDnfstxnkeAjXlrzui9UcT/hpbGicU+6qoMiAfD+oRhLEJltSsL?=
 =?us-ascii?Q?rR2uwGexQJNgZECpF4sEkzxsHvea8xx3MIkynLpOnprf9em1MAu53N/fKkAn?=
 =?us-ascii?Q?6sJwXule/sUuMjj7YQY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11fe7dc-97c8-4dad-f29c-08dd4a3f1b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 01:55:05.9430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7NGq0dmSwoEYeS9Gt0EZYNESCX/wUEcJXjwGSegyOK4PTtGaepH375O1C2cgOveO1OzBozdLPgOGVDVRIfeEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Monday, February 10, 2025 16:02
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy

Rename pmfw message SelectPstatePolicy to SetThrottlingPolicy as per pmfw i=
nterface header for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 147bfb12fd75..288b2576432b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,7 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_Message_Count                         0x4E

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index e4cd6a0d13da..9ccd5a1986d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -273,7 +273,7 @@
        __SMU_DUMMY_MAP(GetMetricsVersion), \
        __SMU_DUMMY_MAP(EnableUCLKShadow), \
        __SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
-       __SMU_DUMMY_MAP(SelectPstatePolicy), \
+       __SMU_DUMMY_MAP(SetThrottlingPolicy), \
        __SMU_DUMMY_MAP(MALLPowerController), \
        __SMU_DUMMY_MAP(MALLPowerState), \
        __SMU_DUMMY_MAP(ResetSDMA),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d645387beaa4..3fa671f4981c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -192,7 +192,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDum=
pDW,                 SMU_MSG_RAS_PRI),
        MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMo=
de,                  0),
        MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),
-       MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstate=
Policy,              0),
+       MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlin=
gPolicy,             0),
        MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,  =
                     0),
 };

@@ -584,7 +584,7 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct =
smu_context *smu,
                return -EINVAL;
        }

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SelectPstatePo=
licy,
+       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+SMU_MSG_SetThrottlingPolicy,
                                              param, NULL);

        if (ret)
--
2.46.0

