Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6289CEEB56E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 20:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCE110E201;
	Fri,  8 Sep 2023 20:30:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29B110E201
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 20:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGRoguEuecmY32DAHBzHUu+uQX0bPR54zipVHGiwbKvEjuRLApejx1TIzAH5awriaqTSzE4+r4ZUlnmKFfy5fB/n7REXPvY6bAAHvm9XV7kObY7jSwOgVg2O4eDPK3yV0HVvdhw+gR+xP6n32M+Q4BAUD45SxzZFjRs4HCB5xei51CPf0uCI9epweUGQxxIx7V8OFw0yHqWbDdoaZEvkQ5cFjeeIAuQ+wfGe8sW6Q/sWdTegW939oQXjG/j0koI+r43LQ6DDxnGi6jF+U39jXF8cS2hYF2SRdLdTAkSTdvaG/8fhh7EMjtK4Bwpyq5+/72uPIxuoDZZ6oUoApxIQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7c0LWTsHHLUuRt3omYOXjfZgiBN7iyhR2rqQgGdy/Q=;
 b=LQ5Z9G3DebZlpfd4D3G7j0Hq7+SjuQPseoD/mGoDwgBy3stLIflewq7VhPeV+AAhnPPbnOBpxP8qhGhbkcRKcjK5YP4vVuTpTbh/hHN1wOqg8lQxiBEmnVnKB8VJY1t91bbyw+Zg7iNg1xbA6ii7wlf2uXsvH3OdsknfSIxMABRvT0vt3EobnyiD7latAXQnFhb9hjEu9pne2MeWKIqDmi/nB5JZNe7qFzGoGJBQsXlZkrimcdLAQlcXdVo3Z+sVBSMR6b9xnDEXfHD5WKN6lt6NFojuPu8QMuEf6DhHE1pvZsqmYRqrjvrk9u063j9Sm+WPuLdzrktZUjWNnjfEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7c0LWTsHHLUuRt3omYOXjfZgiBN7iyhR2rqQgGdy/Q=;
 b=hUp476WcTXN2hl5e74qm4F1XmbFWMK9QI7epZaWGEssIGrigBYjxmA8uy09GwYpvDgLZEYkV5+YxW7+YSiE/JqqZOwjPub82vjCErB/E5K5FbJVLbEERZCVbzoPs8xMO8yXZzYUut8+7eQUb6KeVCk0oUrsMY9SnNCFv+HFczg8=
Received: from SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::19)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 20:30:49 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::7d) by SA1P222CA0194.outlook.office365.com
 (2603:10b6:806:3c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 20:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 20:30:49 +0000
Received: from user-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 8 Sep 2023 15:30:35 -0500
From: Timmy Tsai <timmtsai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd : Add HDP flush during jpeg init
Date: Fri, 8 Sep 2023 16:29:50 -0400
Message-ID: <20230908202950.117169-1-timmtsai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c5110a-fd6b-4e9a-3137-08dbb0aa7d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV8OJ5JTkAtg4n1DLfg891wHD26LCSI9Q/714y9dgQQGRdiWgQLuf2DsQWs7zlxn1sdpe//jt51DKkrwK9uSkKiWVI+aYcx7TVYmv6MjAdwbverI1OOBlmPmJVA8vDPP3wn8D8mCg+TwZ9IIvPe7SapM7cRzmHiYML2H0yZjUkxoy3pJv9GfsQse2tUK3vWbenOm8cQvk9dpLNsmqtWUBtzULU0xCbcjdytYm+d6pIaD1hu7I8lvDCnGAO2Cf6JVkssH/rXrjPSYXS4B3BDCp6jLmQThUkL9wQz6Re7h7YGE/pDjAgRKbbi4kK+cq6Yi9vhp5B1fMm549E6LwXfzFalaZXlXKm2ObtJfoLx3aKAhhRi3Q4nkHJFB9px8f7pB9k0YV3R2kbKMcmIIgNDQaR5KuJSAmAlbPy/r/VmKPHCrkFTeae7hv2umksa/ZS3ZGnqR6CTb1p5PhDggfxpar2+CsJu6sHF/1tFLDy5nGFY+fAhJW2/Bq6fTpOYKYTNmCoZAfx3jEehPdujN1DdEbc/RSMuer8UfoJSu9Fv+ppKjpT50osGYdYU8nd6rt2ayNMerzwTxAa7SKA5mZ5M6j7pTVzENnSp1ii6f+pEZyIA2G9fyN8BSk456LcOqHYIRgLE+V6nqZe0yOGpMRRcIKoVNtaLaUJce58+A+R8G4Hnl6NnLgJSlgy8MrURKZpGcW4pDvUGJZTTFsYYipbpbVcxxlec1ec/mQgzkzoCEXRdrQgB1csRBVGpCgOAZ5fQJgXZ4xT5n929EVKZb7jv3Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(26005)(40460700003)(2616005)(81166007)(356005)(16526019)(82740400003)(1076003)(47076005)(36756003)(426003)(7696005)(336012)(36860700001)(40480700001)(83380400001)(5660300002)(8676002)(4326008)(478600001)(4744005)(8936002)(70206006)(70586007)(6916009)(316002)(6666004)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:30:49.0787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5110a-fd6b-4e9a-3137-08dbb0aa7d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
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
Cc: Timmy Tsai <timmtsai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During jpeg init, CPU writes to frame buffer which can be cached by HDP,
occasionally causing invalid header to be sent to MMSCH.  Perform HDP flush
after writing to frame buffer before continuing with jpeg init sequence.

Signed-off-by: Timmy Tsai <timmtsai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3eb3dcd56..02b8eca91 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -468,6 +468,9 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 	table_loc = (uint32_t *)table->cpu_addr;
 	memcpy((void *)table_loc, &header, size);
 
+	/* Perform HDP flush before writing to MMSCH registers */
+	amdgpu_device_flush_hdp(adev, NULL);
+
 	/* message MMSCH (in VCN[0]) to initialize this client
 	 * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
 	 * of memory descriptor location
-- 
2.34.1

