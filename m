Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64837C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 21:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63CA10E2D7;
	Tue, 14 May 2024 21:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SdalW9pl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E328E10E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 21:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl3kwtxtzdbm4YKL3V4Wta9xPcFQ6mD+wUbcMvZFGU4REbudoUJuFtqsLBVBfeX0Fvd7VtnRDxRsJLhC//zbRuAfrAZPSD2XQlThPqWNZpCNJU1aX3Aeg2Tba1J/097BRy6WrcimZ2iLKOIkMK3VJBHjRMYMholhxSqAT/+6DziMITOt8SJi/ZqQMDFpTeZ31IMXxhZ73ekvfpRXkWRpvGtq0WeOMiiD4RMKFUr4VdfaUMb/5cqR1ODhJTXSqlrlNfqtfpKdWQeNQN94K7nKne+HxNOK0ccWkaG0Ze5fHrOvieWpcPl6FqHxlsUqi8/ejewKVe1fToaVluHpnW6U8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKwV5G8tnIMLttL5PPgUhM8vBOUlwdcvWr+4rv7IX4s=;
 b=aBQ/gFFWQ6jomAzfcuvcMl8xtAN64EfR80XcufHLYhmLVsxepjA93PgDf9Yp5Y/DcJEREWm4Vyj+ywL41sKgHeDAeMaUJ0ebGtefkqeCPmeX6SJpTdRWnhB7T/DxB+i+DGrHlqFDuS01sh0yUhivTVCwY1R1gXlUWaF3ZehlkgISWf2UBX2fz+lKIPS3eFul7LhUBLR9a4ogbrmgOLPWcCEXz1Umy/cUzYcHpnepumJj0iCiRYCM4PlcIVSr5Q5JA+ZZhntcEw6nXREUE2L0wzEFe04K+DenzZgouAZLOGWrZLrMm19I0u3lZzpRG04+vj7xTpU1xMnskE5/iB8K/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKwV5G8tnIMLttL5PPgUhM8vBOUlwdcvWr+4rv7IX4s=;
 b=SdalW9plGB3A/lFwsyuEWHI83rQll1I3vwXGWR72e6uYxJ74Mkt5TNbz7SnCVuXvgW7IqiVrWvmuKx1fgENs228sluwT7JXavs4LtNLllR5Lkn3KOpYbCE+DhCEcriJFrqbkU8d8uWCCAQr+qolksmNeiVtF083ByOPT9lUoDr8=
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 21:32:54 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::2e76:1977:c456:6faf]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::2e76:1977:c456:6faf%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 21:32:54 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix Kconfig for ISP v2
Thread-Topic: [PATCH] drm/amdgpu: fix Kconfig for ISP v2
Thread-Index: AQHapkWs0/OgSijVQU2IwgOSqUUgYbGXP5sQ
Date: Tue, 14 May 2024 21:32:54 +0000
Message-ID: <CY5PR12MB64290E4C60D653A7C964E500FEE32@CY5PR12MB6429.namprd12.prod.outlook.com>
References: <20240514212815.1259421-1-alexander.deucher@amd.com>
In-Reply-To: <20240514212815.1259421-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=74ddec9f-5e52-486b-8173-3d4885c5c83d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T21:31:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6429:EE_|MW4PR12MB8610:EE_
x-ms-office365-filtering-correlation-id: e5d172d6-f25d-4eea-5481-08dc745d6a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?n6Pnq7ufmmECT1HspfHyHKxo2GfOf50Q3b6oiCVgImmWpT0Oj1lq7tsM4x5A?=
 =?us-ascii?Q?yC/dGMZ8Hqf1HmxVo7rZ3/W6gmQLU0tkXY3NWd0byuUWKWzW8IEsKbR8fP/M?=
 =?us-ascii?Q?FxXMvM1EHjEqH3O0uRe025I/SNKNCSXl6vHM2iIbI+9RFnv2KWNpDwBGItPl?=
 =?us-ascii?Q?r1rSt+GrnR/4DkUiifn9Xll6hbYev9SbOx1522q3JK2CEEmf+6ZgQB/vJipY?=
 =?us-ascii?Q?Qw8iDm3qsxTl20m/X/codHoKhaKi6KTtepPQlrURoucX3rhts++FkIS5ejEE?=
 =?us-ascii?Q?pxDVfbbrS82jX1S861keenJbjU63yyoKaWDkcBoJ4lGZ6Da6OXXIPdLTv2iR?=
 =?us-ascii?Q?ySA9M45cr2bx58jH8hbxBoZdq3LDkDLI/GO2D32eVOn3nVIz5f2mmDEoDlLS?=
 =?us-ascii?Q?q8pmVtH4sMjtQqXbptutzEyCoEciyqypYZmyCeAOy6JRGIK9IRnTBzrRchyS?=
 =?us-ascii?Q?y9g3Ydeweueb0idCd3DnPSO9OvnSkjRyXVNO8ch0PUCrJUB/xX1LqQ1M6gCL?=
 =?us-ascii?Q?YoIcnPuPbN9ENPBebjf1PG2gv9ZsINwAiUaq1c6iNHHa1p4cctMflpX7nwnQ?=
 =?us-ascii?Q?LB2xvT4t8AckTvJZO459yQDFj/pE/Sc0nC1oThq+gVxEbwZKXpflChDIIs1n?=
 =?us-ascii?Q?sIvI7Dxz6WOpV3S9yWFstEOgs87+RwVX//WWo0o+yxf03pc5FvNHvGYDJzym?=
 =?us-ascii?Q?09ZLX4K8zTU9+FnmyV5FZt2qkjo1Uf5ONRadUa36VjDJSdOXWMQMbQYFDOKf?=
 =?us-ascii?Q?qg3Ccmn5ofT9f2DgIBi++2mcvx04Gp1mv7cJmLN5eEHf1k8skGPCb9G17CKo?=
 =?us-ascii?Q?jUtGC70eI91LKFhBhm2ooTUKTlZC6qI1kmerByqmk2+l/b+F+bGZ4fBsJDi1?=
 =?us-ascii?Q?1fmu6n8k5DJWdA0EBHx8Ow5qR6oVGgNDD1iEaF9qTRBbYtpIgX+7rIdYijl+?=
 =?us-ascii?Q?Ol0834RXnWDUNeKqVgQ7sRNomeCnONH3EJhqA62wRM4RnZUsW62FSKL3F6PN?=
 =?us-ascii?Q?a9ehpiba6RAyiyK34YDV3Ucs6TaTDUrEXs4aEvY8Fkh5acz01iKNoQZNfUHu?=
 =?us-ascii?Q?+32iqoVF63kWx5nvaqXnUmsRdh0CnvQ6c9GCOkMTpplOxbgA1qs5BgeiC1K+?=
 =?us-ascii?Q?g3MKxU8NNkj/uILVtSM8tvbbZfIcIJrRN6U49fhjr2Ez7uVx/6aRGieGRB/W?=
 =?us-ascii?Q?V0FXSdsHCJrZDNskKifxFtOzahdHU+II8mfr1QRlkPqu49RSlmgfCWce8uiF?=
 =?us-ascii?Q?PMJn8pjH/R20qsb9/f4F9tCPDVwLFhjCeQHl+NpIr144jFfgDl7ZRAU9lt6p?=
 =?us-ascii?Q?x53l0LTstDLCZiNaqYwVkne5T5vqZedVpedsg8MlYypg8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iM3KCapjjmOeNM4ff5gB6S9Sc96F9xNetBxXGNCG15I44MTMNpzIZcClBlwq?=
 =?us-ascii?Q?kkbODeFV0By/Fnd8BPpfDuSP442JYB+x/M3oLsZLYpp/u8bbOAJLHKlDV+dR?=
 =?us-ascii?Q?z0eEqlQLq2OqncgjgpLTh3KyIJ7aXrt5vyE4thtNVaQRRiEbjGQachu/nwgf?=
 =?us-ascii?Q?gDPlnDolfA2j/e9HQRkGgEEqrWIX2pcuGexsKhBXBjGDy+yCtFdxeyzlKjt7?=
 =?us-ascii?Q?0pn4A78Z1F/9KpNu0dY5zI+Ywh1N1pjYFynRs87J4gAP7ua5P0drJv8iZ9MX?=
 =?us-ascii?Q?+h1OhPvNQr5pNOr2bWAqYCpLb67RREebN8M9Im8fJj/hFJfEOY+JVWhSNqRm?=
 =?us-ascii?Q?rALa9I4mLtiupC2ELoU+J/WZAuNFoQ91hNCHIT7w6FvviiNEZ1MHiuW/LEoK?=
 =?us-ascii?Q?bqIk5lQgfXfj2cytX0hq7+LJKiH7TOtldwB1DdUyKuXRvQwE4V8S8nIse0pZ?=
 =?us-ascii?Q?67fRw95yVbDhN7K3uCxlqSLZ9zEPlboZ0qllJSN2noIlwN//1VcrjExhgHI5?=
 =?us-ascii?Q?Xkf2PEfkQ4LZBdgQD8ixG5r8TZkkYjGyzbXcS4t3y2Bz36fnp1h14VI0a2ky?=
 =?us-ascii?Q?u1UrqRxfqkT10M+D5mvZyFhI53BUksMBe4hQFTeEYOQeE3/Get2XvgPgL0yR?=
 =?us-ascii?Q?nhK7A7Z4hLstbHWD8AX4fSo2ghvabo7EXROAVL4pMOHAAuAvT17zBNGkh3JK?=
 =?us-ascii?Q?ccc+PlYaIc0OqqM+SYXO1XKC/ZbHOyK4CU4XANW3rTt1mn5dmHOpbMonBkUg?=
 =?us-ascii?Q?ZGaBQA6P6CEjsc1Ui6r/I0EmL5Z5ftvIBsIFhIE9S5wcB7JzjWtMM/xeR/yu?=
 =?us-ascii?Q?lFlMuiu+GsuIntEDSvJJcuCzSxJ/iopD8ZSUfWl5FM6ypuZ5G8RJi4e3bHiU?=
 =?us-ascii?Q?xd3RHSETlM6Q/mj0IwlbwE/VlRMehjnf8RncKFX6P4YlibqBv4YJ7awWk6xn?=
 =?us-ascii?Q?9hVUxCzHvlDsFbHWfj1eqNFhokZCRM+w7yIWPlEiYODoWBvmXaKJguBIzZOt?=
 =?us-ascii?Q?zo2VonxHOADVqF0fz3S8vt9JHnyHb+SRMkDCH2M1KUOActk6QIhwjXWEnrTJ?=
 =?us-ascii?Q?BFn8fy/fLVe1s1wRTEarxF8LNrIbdw87pmBPLyHwUeEWsuHwd2L+qqK5gQ1Y?=
 =?us-ascii?Q?HDZodTrbb2fVOT12bOahY42d03zdE1PE5TUVotuZ85LSbRBqW/gnSdxD5hf9?=
 =?us-ascii?Q?E9MRIqJiizZ136Rq/JZjlvOQVEHLMdRmr/PFc+WbqZrJGjtdSC3T8heAZiX1?=
 =?us-ascii?Q?B17rRyalrrwl5OrQKFXVWI57TTvud/gOjJ0G7vmf/QTbTqRahyJuDnZ/HZsx?=
 =?us-ascii?Q?ZU/YXWQyZ/p4FVS1aK9Y4FubGyc0XCVbly1fXnpWH41jfEErxARWHjxomLTt?=
 =?us-ascii?Q?ajv1/N1Ph8YYT8YJJO2GQBg7oJqiIY4aSEyIeAN72ItOYiKL/LWYmhN9gNza?=
 =?us-ascii?Q?0Rl+RAMFt7qbIRUyltqPnZ9/t2144vSNH6nWFhp0ksCGNIIOnI4gl02qYgpJ?=
 =?us-ascii?Q?fWmIQx2JFA6v/tRQi+iutcupSBKdcQND4wtLHe1ho+Q88gZZ7aN5r4VhVOPq?=
 =?us-ascii?Q?RYhscsuK1QGk5Ig84FM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d172d6-f25d-4eea-5481-08dc745d6a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 21:32:54.4547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5suBB06ijTgqnaFy2lOV2KKJSYitJ+R37t0Rb9pg8u/n9bJY2t3Rq+JMkEs4k5uJG6I3iDCLHjXgQW6H4TMFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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

Thanks Alex!

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, May 14, 2024 5:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Nirujogi, Pratap <Prata=
p.Nirujogi@amd.com>
Subject: [PATCH] drm/amdgpu: fix Kconfig for ISP v2

Add new config option and set proper dependencies for ISP.

v2: add missed guards, drop separate Kconfig

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig            | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgp=
u/Kconfig
index 22d88f8ef5279..0cd9d29394072 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -70,6 +70,17 @@ config DRM_AMDGPU_USERPTR
          This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
          isn't already selected to enabled full userptr support.

+config DRM_AMD_ISP
+       bool "Enable AMD Image Signal Processor IP support"
+       depends on DRM_AMDGPU
+       select MFD_CORE
+       select PM_GENERIC_DOMAINS if PM
+       help
+       Choose this option to enable ISP IP support for AMD SOCs.
+       This adds the ISP (Image Signal Processor) IP driver and wires
+       it up into the amdgpu driver.  It is required for cameras
+       on APUs which utilize mipi cameras.
+
 config DRM_AMDGPU_WERROR
        bool "Force the compiler to throw an error instead of a warning whe=
n compiling"
        depends on DRM_AMDGPU
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 12ba76025cb7c..c95ec19a38264 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -325,6 +325,8 @@ amdgpu-y +=3D $(AMD_DISPLAY_FILES)  endif

 # add isp block
+ifneq ($(CONFIG_DRM_AMD_ISP),)
 amdgpu-y +=3D amdgpu_isp.o
+endif

 obj-$(CONFIG_DRM_AMDGPU)+=3D amdgpu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 846c3550fbda8..936ed3c10c884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -113,7 +113,9 @@
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
 #include "amdgpu_umsch_mm.h"
+#if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
+#endif

 #define MAX_GPU_INSTANCE               64

@@ -1049,8 +1051,10 @@ struct amdgpu_device {
        /* display related functionality */
        struct amdgpu_display_manager dm;

+#if defined(CONFIG_DRM_AMD_ISP)
        /* isp */
        struct amdgpu_isp               isp;
+#endif

        /* mes */
        bool                            enable_mes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 378d5a5cda917..1bab8dd37d621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -107,7 +107,9 @@
 #include "jpeg_v5_0_0.h"

 #include "amdgpu_vpe.h"
+#if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
+#endif

 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
@@ -712,10 +714,12 @@ static void amdgpu_discovery_read_from_harvest_table(=
struct amdgpu_device *adev,
                        adev->sdma.sdma_mask &=3D
                                ~(1U << harvest_info->list[i].number_instan=
ce);
                        break;
+#if defined(CONFIG_DRM_AMD_ISP)
                case ISP_HWID:
                        adev->isp.harvest_config |=3D
                                ~(1U << harvest_info->list[i].number_instan=
ce);
                        break;
+#endif
                default:
                        break;
                }
@@ -2402,6 +2406,7 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(st=
ruct amdgpu_device *adev)

 static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev) =
 {
+#if defined(CONFIG_DRM_AMD_ISP)
        switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
        case IP_VERSION(4, 1, 0):
        case IP_VERSION(4, 1, 1):
@@ -2410,6 +2415,7 @@ static int amdgpu_discovery_set_isp_ip_blocks(struct =
amdgpu_device *adev)
        default:
                break;
        }
+#endif

        return 0;
 }
--
2.45.0

