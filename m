Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882BFCD98CC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 03:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2768810E0CA;
	Fri, 12 Jun 2026 03:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bUJ5jUk";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EEB10E0CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 03:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6E13LYi29H0las2cf3StnajlF0nIi/2GinOBnqY4KVhFxLGFDDxjJC87VCm6/ZxzqaXbJ+inyPVZBsh2KiLKrMwKJaNp5CZ1W4twZJNhwfz6auouLlykKcHxjfL+1MlZnRlnW4ZEZyMXWuGHFklen1+zXemi9oUPaZBKlrx3uBexe0DafmWMFL/ekZgZ89I7mwhd/6P3DBEn4tfjtpaaSNro/bE7ZZW1Ne17+JT2uW3/pwEA1+DzQOHnVBZnr5j+VmjH9dDKYyN4vCJqKxZcZypkdcuWIKkqGr9l077CpNh1mzR3Siljn647yNmjo+ssr3OLYfl24Ere3/hUzEDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yisK5qY3ArCTYvGhESUNpoZyTUkZ2nwXm1lJPuy94iE=;
 b=Sq5k9CeOPl3QVfIEyjSP9TbPsYXa8w6A4uXD6wM6hSi1wYMm1MGSgRgVWujqBbFAYcIb6PycKU63shb+jtZIezhH4kAc7CoIEGA8EKM6osZ7v+CFivv5Xn+7PqVkup6pMYWic5pEBJn2v13NcmUzX9WVJvozE7D3MeHOo89sHiJQdgNZOyGLKFk5EU8BnfRSy0jCid8VnOkOGh4L5f3UAUbt1a7UbZmIZ4L3AA47dFlWN3SEKvthYFfxGT94JW94gV1Pr+ZxOxbBQHVNCScVH4ZN7cNTJm6JqE1sQoWb9jIIEbHgluTVb4utnNkePmmmjeO2bR7mq/RXb/cSC1R/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yisK5qY3ArCTYvGhESUNpoZyTUkZ2nwXm1lJPuy94iE=;
 b=2bUJ5jUkELq2wq48gccC7dRheClwW+H+b5Bk5pfN5eENPcUem4dvbzzegGQ2bPPR9N6tV/HfFfuHen2cG/HezpCsk1GGdMbsdjQy+HMcGdJbjYNLSLcKrSIRP1V+0cB7HqFDJ209Fw/TB9hy+5/5bEOAWRs501CTsHKe/nWO3Kk=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 03:16:53 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 03:16:53 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: make pp_features read-only when scpm is
 enabled
Thread-Topic: [PATCH] drm/amd/pm: make pp_features read-only when scpm is
 enabled
Thread-Index: AQHc+hhcCIMbI9B4a0C0kvilY2fd7LY6P55Q
Date: Fri, 12 Jun 2026 03:16:52 +0000
Message-ID: <DM4PR12MB50382BEBB15DEC2B530987858E182@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260612030437.221920-1-kevinyang.wang@amd.com>
In-Reply-To: <20260612030437.221920-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-12T03:16:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|CY5PR12MB6129:EE_
x-ms-office365-filtering-correlation-id: 3b3ee9ad-77e2-453c-7fdd-08dec8310cf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: YBtkEiXjRoHzhe/qLcfLRHGdIy+c51K9DxOCOK2n5bC3YZOTmqGf7SlHzUp5vfhLJCKvUZ5rjU39eyheLDMLjShsFAqH8dVj3YEaXiQZMsQlDwCSKTYVcAJTYuiagtasmNXlh/rMN2Ao49PkRPeyNAtdwz9PsAe6cnnQzQ1BbmfA2Q1vNyseAbLMAlHzr3MLmVApDAJtfKVg3DcjBBQuzEs/hgEQA4c94YVhZFS7iT2hEk3JAO7KGXqkZdRe8ah41I0EmbQ74JutqC+p54wPOpVAw+uXxxvR47x1RCPfzxfRelZeQRTEWzcaV52nK3VNZIrTw6maoFgMNp6lewxOkFVzNfQ02Ao0jKgA6TLA9+D+jaSanGSwiYYeNGmMGi0IGSDsDA9xzNrgGSb5QkLEmjDQHnYIBonDGLCGXgyooB+WabWXYaoKQ+eJdnFf6ZTzA01gr08PwXh/q6eqsZuaGyimJsfHjlaqHH79AHtBuq1rAw6iczlmm4XumJEnY47ooHm3biTujbrZ1zRbpldLrhZBd/dnHBO1vy3EPu3q4ccV6duZBH3dGkBi4zL1lsMz5FW4fMUx/12ESCMFu03xfQS1hJRKY/Q0FoigK7PB4hxI7MAZ5OUhF9QvlkHSUGEij0ZYxUqgvQe/RpGjwHrs2m38pJrmuv4wlo0QyJHpH1yPoD9rSRzRWl29MQWNGpNJbJAdX96ves6FNDexTQoQA6FcZtq7lojuSvoMcfAM8MVMEa9qFYksd3nNjFcvObfr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CrwUShjlXbGBAx/eQUBL4IJol9MVkXYt+4eot+NpEf5zxkeAf9bpAsZgPRGt?=
 =?us-ascii?Q?7VhbOY9L4QI+dopVao1YKV/6P0g/CF/XHON4L08HEgOPmQvL8cVc36ppfqWY?=
 =?us-ascii?Q?YP0zfFCEwEeUl+v9o9tls/ZqgSi8IH74sw+PedHwhiQk/Il7NPTZKbfmrswy?=
 =?us-ascii?Q?fkxxvXkh7s/M3tZwgbUC7NnemFQ7d1w7r6mvL/ISDsTeLO7C6o+5x3Eqblot?=
 =?us-ascii?Q?SUkEOUbYcXHsrrcLlXCKIAlNuTr7IodnJT3UHZ7iF0FCoacdMLF+lhGfrKYW?=
 =?us-ascii?Q?Cn348ZrCQD+Rq0D7pwVW77doNAj+rk6Ft36kGZWngAvm5YXtQpLPMWuXkJ9T?=
 =?us-ascii?Q?QTn1ssDALij3BcEP4io484J/HjO6QrgUFUpXMR2XwUnrEQh8fg4jhku7cLyb?=
 =?us-ascii?Q?fkJBSLtHy4N1LDtyTSYuJqFmczj/M3BXkhsv26K631KgqMhH7meKPtABEYOt?=
 =?us-ascii?Q?PG6yqeRrwQmCmZeOHwBuL2ZjxHujb8wArD6kSmM3NdfrPm2SH+NLIlZNTRNQ?=
 =?us-ascii?Q?/7oV5pkyzyH7n6Krrjujl1G731taScIKdpK7V5rBtlgS5J38Ab0quNJHaNav?=
 =?us-ascii?Q?xpM9wqtT3B3m96q5yvn8IYQ/icltlMnFfXtM+tpNM0NGfsaOmUQW1euMRvZD?=
 =?us-ascii?Q?+r9wW2LTDB8/Jk4K+GDqIWgs09WTyTrNu05M6RJqm7E+03+bV0HULyQCzsvH?=
 =?us-ascii?Q?m+POVgKY+oX058H5+nKKucjVVY7WI0G+7YssUknoeL1RKp9l6Johnv0BM7gs?=
 =?us-ascii?Q?ymmUKANz5FJUnNavcJWo/EGO36A8DBq+cp8BZpIMzoI4RvyKC2a0K5C8rjft?=
 =?us-ascii?Q?Zuj9asR5q/RLApZGqhA8YTC0fDJxA6qTpdeeClN0UEmA/cR5Y6cy77E/L28L?=
 =?us-ascii?Q?7EkVGUsujrecOX9ZZNvZEwsrpt78QG97UpHOqKyr5ZOGeMY96qmcKXEHo8Yv?=
 =?us-ascii?Q?lV53TwiHz2L5wqFDkVl+rGFo5kiEZ4u3P5fd5XM9zRE79gMv8Zo0j/ARieW/?=
 =?us-ascii?Q?FKu3rOGfDR3ZYqwktBnm8oaOZWy9tmMdR4caIqKIjkR9FPIIHCJo8sBVWcBk?=
 =?us-ascii?Q?KzEkdDxZmXdsu7WOaUNMuChZKmd2OUrwTk2FwB38t2griBVK6vog0Yg5LBMc?=
 =?us-ascii?Q?MlB6kNj1b+AeV2AhMjldbxEBnoEFgr3ZA7OAcwci6WOefUtuFKHIUU/f1EkJ?=
 =?us-ascii?Q?iuzxjg68SgvG5nbmu7inRm4U2/pqG2U0RNbILujrLgb9KF5sGUlaRtu07hz6?=
 =?us-ascii?Q?SiTrgZopNTtvVfZJop5EbfWsu0pNbzqZdPzxiWPqrXgSk2RWk+s0tzqqdKAW?=
 =?us-ascii?Q?3UDVuJJeAcbStKfYmdBfcVeI2L19yX2Jh2RCb0/PfMkkeXkRRwr/USsRKF+o?=
 =?us-ascii?Q?QkkbyjBvRF3aEXW1xoiZ5ny1WLU94UMdSGWigNFgWWgJYoGIJKMeAGacy1lP?=
 =?us-ascii?Q?+c+KbeqNlEOvRJMDrpAdC/XK93sOJt4whMevxl6fYqskMYChz5viM3+vStMy?=
 =?us-ascii?Q?QxoV+I2eVXBG12QPXr25s3sh99CCBxjv4Jm/zB3pEAfk1PqkIAIQYrWeWoRg?=
 =?us-ascii?Q?F51heyTuhg2aULeIWA3jbZiP4xQYrUjTwsZ7BB6rwRpmY1d139CrPnOPj2sR?=
 =?us-ascii?Q?sAuNJ3BvTOsdplQFqAmh9jM5rp7h3uFFWLpqTckHwEyuI35XXZK/LJA3DM6a?=
 =?us-ascii?Q?ZktWObJMcmRA28O8Hjxsi25lA4L0NJ9hcmjMl6kdP7FkLADLe9qoPI7po0Y1?=
 =?us-ascii?Q?83y2VrBnJBo7g3wefoXDZAR0uX9OZ1/sNRqd2r/ifWkqiv64Krnl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3ee9ad-77e2-453c-7fdd-08dec8310cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 03:16:52.8817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpdLSIHCgmASTFl+tj9gFc0NHT334N1Z7yQssWcdG+ejO7gJX6BwxdzumCNdH2l2Scxkj00RwAKI8Po4oB/zSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, June 12, 2026 8:35 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: make pp_features read-only when scpm is enable=
d

SCPM owns power feature control when enabled.

Make pp_features read-only during sysfs setup by clearing its write bits an=
d store callback.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index dfebe67c164d..f69bb77ecbfe 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2696,6 +2696,11 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                     gc_ver !=3D IP_VERSION(9, 4, 3)) ||
                    gc_ver < IP_VERSION(9, 0, 0))
                        *states =3D ATTR_STATE_UNSUPPORTED;
+
+               if (adev->scpm_enabled) {
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               }
        } else if (DEVICE_ATTR_IS(gpu_metrics)) {
                if (gc_ver < IP_VERSION(9, 1, 0))
                        *states =3D ATTR_STATE_UNSUPPORTED;
--
2.47.3

