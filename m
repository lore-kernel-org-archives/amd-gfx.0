Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D0C531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 01:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E155110E63A;
	Fri, 24 Jul 2026 01:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vbx/s1/x";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010051.outbound.protection.outlook.com
 [40.93.198.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FDF10E63C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 01:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRN8XTidSC7t1Yvonws6sRQFKEAv6A+/WSLyfBKri+nPMXp2+6M5y17w8INYF+oBDSwhQNLwFGe3/nrRYfxDKN1HCsFju8dzWDgXUdBkJ1TEX0k0eSTEpL02ClHjWwTqQnGs0v7c8I9JTevxuxE5mVMoGkufqUW+byBBADB68QCi+Ucy14fAnj853DZtkgZTnrcx7+N0hKG+2E4Kgqwq+/FIa75ZSv42jK/zPAAHYbMPCZTD22tnzEYrKS8uQ9Uvb5A92LCUOXwnHxbpP4tbyHUtXeEwlDi7Icy/V8mIUtcPdYBTWVf+4mlBgsyG4fS2Bj8CPBZkay8auZuu+8IFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeS2gtFIEUzzm45R6CikC5is98hwzvcyaiUSFYXmPRM=;
 b=DiQV2jrK8LfQVefhsmY0dgiib3BptAlPcqyNcksmvHxd7ccib8IeXLFOkiAGCV7YqXRKbBXl+jYuLf/e0XHWGCC/HWceWovruZOF3qJ4TeUpTgAyQHIu613E9P0wswo09+3hBhlZRVPtOo0C1NEviSYJ4MlSHTCsxUYBpZ23vxcAfuYaR9Y76TA27MaxWBZ+bZFFCgNvcdA4jaxdExY9u0pDNV8bfOjVKCZUzvEgF74749WsXiJhgeVnaf0IaNgnG2V0ahsjOZ8uLm+v/Vi8vlLvGNg5bQ0npBcY8Kb6cws8jC3PrQ7JyzCa1nl2M8N7QGwH2siL//vTPE69NHLD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeS2gtFIEUzzm45R6CikC5is98hwzvcyaiUSFYXmPRM=;
 b=Vbx/s1/xe+zbopNQNe2/tPdhOuP1Zabi7ZArHWRQWGDI0Q8g9PSf7N6m8OiLO5KMLRnmPjPnFEzVPrTWIzTJv7TO2lICdU0bjjR8lzV1xV4dyNSulo4HMhRpCVlwbDO49c5LURbM315ZnugmMjZz+QCWp88+giqqQPdjkqXAxGs=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 01:56:46 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 01:56:46 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras
 ta runtime command path
Thread-Topic: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras
 ta runtime command path
Thread-Index: AQHdGv9SRWBe7mvC/kSWqXhqFjKpdLZ750Uw
Date: Fri, 24 Jul 2026 01:56:46 +0000
Message-ID: <BN9PR12MB5306AEF4C5587B9B8F7FE989FCCF2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260723235918.1090518-1-cesun102@amd.com>
In-Reply-To: <20260723235918.1090518-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T01:49:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|SJ2PR12MB8848:EE_
x-ms-office365-filtering-correlation-id: ae08099d-df92-4aba-b8a0-08dee926d167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: auX7x1pvrF48eOX5mnbCBckglnO+IN5HRaQzP3mjgpNI+He4XnFAQ99D4FYolG9X/xpKgBcayIe4Hx/sUC7BCr0kU/2xV86ZTwgEs6f1Gn46xPQn65poHehJxFJBVdXqJh58Wu6WHxTB/Yg/FNgG7ohV8uLqxjPPBI+0uDGdVUea1PdV4bRuuAreSFxkgFf9N7a1ai2H24dBCOwyqCcw3tmaYJ08HlKLfx28PFGov7FThIEIqQJqTcaNM+j7qxpvPhKtMC9tPDTN9fRC0WtKA+P3VwIlBGi/hgtMnHLSEnyxB6d/6i5ImRkQTbtU5fpY/wl4VBdxxSDPHqfOQcBTea7uXZBlhYDeWgAdAeBcrj/8QUNM7Js4q0b2QIgs9tdpazb6GaEsRdDp2v+1lNtJEIBKr/6RsRZ19Ih8A3yS3BHGPVFhjyDR9ceYUOD+C8d2C60Pk9CDng174ouAhvtsDCiP/i5xYX+i2iPFBgSu9lEccWM6bg/1KNR+VHNfLq90026KndPnZC3qK0bdsiJ5ygA21ExvGuGTnKRscjcGbFAMNs9SFSLQ14pHz7i1jSASDAqw5+5X17SuW/IKrcKWluUYf0/Wq4AQjY918HqkoXexSfsAqVLd5f3GXlaPmt/gVdRthpOsIP6qDVkwb51h9kn/XCtXdQIAsepP2b+fyn06Q+wxOoQ/WdOgk+oYcIn3BeHMPlKZaryXMbvrwaL9Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7AUPlYx3iPMO1tnIuhvL+xmGO4xZEdgaJQBY15abR5Ti87pJjnijJ0+Ocy3l?=
 =?us-ascii?Q?CprI6MtPQgagkuut88UMRHs7tHHwgekGdYrbbmr/nqaJnRwmB8PYoJd+KlWq?=
 =?us-ascii?Q?dGnGqQKsaAj3IOjjBIfVmzzBvtN+ksN1E69ZShbYCsirjiUWJrqEAzsqIdTg?=
 =?us-ascii?Q?/elSDONpkJ+KvHqK9MP7q1kEdj9+UJhEod/bh+l8LD4qsfyS68OoguatiyhQ?=
 =?us-ascii?Q?3LJOVD8HfzEw1nfhffEz26ndynaK5/Q6zXavCPzT3LLu2XPbP2tQ/bk9N3aD?=
 =?us-ascii?Q?s7DN/q+AROmHUm5Rto1V9TFyAEI0dguLzLeJrxlXLEluEtmDSRu1llygc0bo?=
 =?us-ascii?Q?x8at0Z2alTKKiIGE7U3yM6uM5tNYIF9tnZWzuiPsMLeFGHWGvx6PX5Cyw5e0?=
 =?us-ascii?Q?fS8pEZFpp3f2xMBu/Kg4uIOq4m0rZP03siNSmuWTahc/32DHL90PWWk6qpwI?=
 =?us-ascii?Q?LVEA6AYC3ukDU1IaiOEvyWwHk10rcFu4FVGrNzhfEY0SaeUanig0SoklvJYC?=
 =?us-ascii?Q?MnOBnKqekykXyYBIg5cyUI+0RiKQiYel5PIkJFvMO9cCM1S98QrYRd1r/pas?=
 =?us-ascii?Q?0I7FVZnMOHAaPyPC5aAFokEagbf2HmYG85xzUrOPnX2Yn133dfElCsOFsDXj?=
 =?us-ascii?Q?uzET/eNN3c9U0fwvgEEYsaDwm5sxVTtOPsZ1ij2WenWvHlLHKyrsFUkwigxB?=
 =?us-ascii?Q?+xfg1w6R4wEtL2CpvJvaf20vyuz8Gcr8cUeQLeBjNl4Zowrbb4int4iZt4uo?=
 =?us-ascii?Q?JIaoH0JOnszffN3AIQQ9ndzS91SjbE2Ybeg7zuCSq8Qj+qhJ8V+MGfh2PkpK?=
 =?us-ascii?Q?w+rmZfmcEjiE+8I8Wt/aL9TF2L6XeVqHBSQ3fdEFXb6rmbYlAwt0F2UgNQ1R?=
 =?us-ascii?Q?PDd56BAZEYneigjCtHo7AKEVTKhCvmXRYDaMRTx6mlgBTVMCrLq8XdI9oklM?=
 =?us-ascii?Q?4SmOTDvAhh+BTfqfifZZReMEmbjkMy9Ayx4bCcL4vs6lx4C8DqZkTpWMwTid?=
 =?us-ascii?Q?+8jSm3tqvGsLNwZqBkOFs6EC+OWLWLtlp6vgGv5Ku5xeLMLT58YftyccexQz?=
 =?us-ascii?Q?tBYYA9BoUXS0GVtlGCyD3RhGeVyviGyUQN+o3Ammchpw8PXlQ4eniZBR2/n9?=
 =?us-ascii?Q?xhXtT+5CRXnyy+RpiWQqut+29SpkCuobky07UaIYgb2ZyfRKNPgZL15OManU?=
 =?us-ascii?Q?VTmDGuiUUS5nEifM7a6Kd1UVMJeN+MhLuNOaSfvF9alRYOfI+OrIItzU6O+A?=
 =?us-ascii?Q?9gps3i0UiKRwvqH53uxtJtlYKvhzxscl5H+rIXPW0buGN4R4qgysC5t4x2/y?=
 =?us-ascii?Q?pBGiedHCNQEQvJx363L2CmxNpPv32AfhhUa8+jD/vKf7rOOGQXGE4gZzHZGa?=
 =?us-ascii?Q?6aDmjpSvHZdmHY3b8SIsI55h/R8H3Bt3IvBbdROaQZJgyIrC4HiBk8/pgr3l?=
 =?us-ascii?Q?jQPxp4FnzyL0EbnU2EecMW63NhtvIvmgXBkLLDLMfXjJBF8x8TOsYlo5SLND?=
 =?us-ascii?Q?GyMFdTomCiL9TndCNrATcT2VjNfc+wD7xlSiJHbC8uMj6yR/dd7uaoEH+KGl?=
 =?us-ascii?Q?baueozn+R4ny+0V+0w9KXiKx2SDc1YUm7EbsXjxkEs5hGmkGyOnaFHJI4Ngo?=
 =?us-ascii?Q?tHQOuwYTrFkCDW4wK1rBDoS2Y+O4T6aXSnkWpAq+/2hBevIL7JMd7vH8hylq?=
 =?us-ascii?Q?3VIkAtEgzTykAD8XmqyZpeX3NC9ZJqLuqamXu4eKzbk5RpnJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae08099d-df92-4aba-b8a0-08dee926d167
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 01:56:46.3836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sgz5nlRqe8bfORIXeslNmoHuTu4LbYse7ziSN7aMC1ovUo0SraSs1f5H9zhzsquVOhXI0OhDCnDI8tQGEkT74Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

Cannot send command during GPU reset, which may cause a system exception.

Best Regards,
Thomas
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, July 24, 2026 7:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras t=
a runtime command path

When PMFW enters mode-1 state, it will not respond to incoming messages.
Holding gpu reset lock before dispatching messages to PMFW would defer GPU =
recovery processing, cause undesirable timing skew.

Remove the gpu reset lock acquire and release logic inside send_ras_ta_runt=
ime_cmd, prioritize GPU recovery execution over PMFW message delivery to fi=
x timing dependency problems.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_psp.c
index 358f602b167d..fbe91eb67c0e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -374,11 +374,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_con=
text *ras_core,
        if (!cmd_mem)
                return -ENOMEM;

-       if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
-               ret =3D -EACCES;
-               goto out;
-       }
-
        ras_cmd =3D (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;

        mutex_lock(&ta_ctx->ta_mutex);
@@ -422,7 +417,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_cont=
ext *ras_core,

 unlock:
        mutex_unlock(&ta_ctx->ta_mutex);
-       ras_core_up_gpu_reset_lock(ras_core);
 out:
        ras_psp_put_gpu_mem(ras_core, cmd_mem);
        return ret;
--
2.34.1

