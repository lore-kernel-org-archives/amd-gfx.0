Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60821CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78BE10EEED;
	Wed, 13 May 2026 14:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Do1GCj2g";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB76210EED6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO4V18wM8bVN3obpMX+QQalEq3S5WC/JggDfFdbK94FwD6oM3fdFOMD0JiVRR/Jl717e9YRaUygfHY0tgkcHOYGHdmZRJGi3dwGfW1nRhaewH6sOOq13vxDz4F030qvEVHBQiD9e248yTyVsfg5SXNoNL0ZM+dgA4L25RbKVy1oijlnIVkNj34FpSdK4qeF0gOzLWUsU0UFbhOn3EU+FoH/CmaHtMuCqic7XlHDYGjbPGkXwatFn/YXmJf41sH2S0RIbqmvaoLFtqWJDM9OgY4vZOKsMozt3LGGSm3xHK7PUF+2hNk1uRPvnD/y1IAJLbjZ5/xMZRp5ml9sTRx/Ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHL1trruVb2p6zd7Sf+rlTn6Lv7FLtcFfIi3Jbb7CtA=;
 b=gLNO1G5jJnd5O6PkreAp0/lzuH1Lao4nazSENNSezB/DZTc9CvmfM/OoZt3rmscnqEcUJ7n7peNYJ6XzNU/FSMGn2Ucdjez8+hptwe/go2mIcGIyICtiaLgVBvEYqbXAC72Zl7ehpWWC4aqjJpX1E71++o+RDN/qM48sa1S8vDbIzoq1lZ0npnPXqsPAYGLStJscOD0ve6ucUpTgiKL+1WSE4G6EsraL8aL/uBb5iaHTHFvS4DO0nmfmiAUKl10ua7hIzk9HHnRc8dgAs6n7CVpmK6CP1vnRbvZc5hh+6Ck3QK4dtpbAgkH23L8ooXjNumlGm3ozazj9nNfCaPku+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHL1trruVb2p6zd7Sf+rlTn6Lv7FLtcFfIi3Jbb7CtA=;
 b=Do1GCj2gU1sY8/ciRTa0H21teY56GjHwoljYvVuTXUMz+UQEq659v6rS1YR2xcbjC8efitnG25JrJ3iAvw2NLQQApVeZhSqJsvkgzIxOelSoGIgJMjDf0fA6ohT9cwMD5oYQqPyURfiCtKQKuSqoSMI6BKCAotAmmt3eZSs9hGY=
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Wed, 13 May
 2026 14:33:31 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::a5) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:22 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:21 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/28] drm/amd/display: Enable dcn42 pstate pmo
Date: Wed, 13 May 2026 10:29:34 -0400
Message-ID: <20260513143213.1852892-14-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 474559e8-1dae-4acb-1dca-08deb0fc9b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: ho0wrKJTGxNxklaUn41CafW55lZZtMGQyXY8vdLPJE/s6omL5+orAiBBnBODmpHFtAi/Nd1OpQP+4wNgNvzOWwo6/7bAC8Pg0Asiu8+wVIRJEytyFNmyXSWz10zhnAkKHT76OPuvHvw/7aBB4BXvZzlYU5akNBYa8xRAT+HUkuopz0KE9+eF+rnVd2OnU8xwbRvvVZYPVv2onr5JWWo3OGqoP/e92cP3zN7kbs9dMgYOPpT8TeQWdw62AhyTsH9q9B9ID0m3VmKDQc+Aa+lTaSXFr5kQjEgyrtGLRitiu7J/1GnPXlsI10v5qjUejz4iQmmzIYGrc7UoGx1obchetbQg2KCXHb48mYF3DbO8+YUbDB03I+SVqAJx3R7jKnZGR96mXnxE7SHaHv6NBiJaen2ATtQ+mJ6zyqDjOzirqnHC1pZf1WLs/n3ATbnni3ptnw1XqeFMA5iE6Ffy7wFdM532g+dhfG3PofispArP1eAsz3IsY0CHekvJsJcb58uGnoxGIlFJyEfKYV5Ti39WjYDHJAaHM6IXfexPdM97Id/oOBrW5Tjo3VQxXXSzgPKAqXduzfapyICcIeBlW5KwOdAYHC3WhqdBlNd9zjoKHmUqjcKK6RYAQBcThnblapCuxrrqc3Fnv8uEAnL1nWOk9GJSlcr6cxWjA4dB7tDUH+xHOK3sjQjBu/4ESqffl7B/5mo5U71W2WxeaOqlg9DCNkGVzHobm3Xu8xhpOmNp9Lg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GbmjaQTKQ8ZA9EZ6di1Lapd3fNIf9B2Sun5KLWBjwSO/BD4TRck3BC/6mQIuRGeMWrG9aBnLjaYJiza4IRPoNHvFU/vuEIcEalrvGU/7RuQExL1nB7pkRdT2pKT51CbYH8NfJJvmL1jQo2q/4wXCblXGubUt6UrBTBmEL7MjXYZEeXuL4loMEvCHO4YRArYjznEjMeSNHjC+Stt2ZTO8Lm28JVbFa9s1ZKzj27Ey3LZHHPAE07ySA5edG0I94mAh265jyvVNf1KM0Pm1AeDH7Wq4ZLbycToXPu51CVfJz1j+ZxLRlip4/WeS3DYblWJJ+5Qoea1rC+/UEYyX2/Ksl8TCo9CT6tJ27d3odNuAnldswtxYGBumQcjvlxBXJk91dDszbSSdSkrJTOr2Uy13QOg23pBue2FWAe+98ccdVbJ4lVeP6U2ip2M3vdHfyet2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:31.4741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 474559e8-1dae-4acb-1dca-08deb0fc9b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why&How]
Set a flag to enable pstate pmo, we want to always allow pstate
support on dcn42

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 1fc457cec293..efe025ca4ed3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2290,6 +2290,8 @@ static bool dcn42_resource_construct(
 	dc->dml2_options.gpuvm_enable = true;
 	dc->dml2_options.hostvm_enable = true;
 
+	dc->dml2_options.pmo.force_mandatory_uclk_pstate_support = true;
+
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
 
-- 
2.43.0

