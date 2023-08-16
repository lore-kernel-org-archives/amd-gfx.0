Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456EC27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D3410E3D2;
	Wed, 16 Aug 2023 21:48:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717E010E3D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GV7QtcgL3Cu9fES4LGolVcEtEJMHLmaiyi1tnrr7GOyk9+npYaGu3UAl3uAKY656VOGrCsIOV+VbvlWAinePoGsf6UpPm5x+5brQcvA+d5ibx4AJA8J+o1H///CiYn954Eqw6EEgC9/o1PhN+UD5PW8NE5yPxgD2OPcKBXrZVeM5uGzCRgU+WtN+K636+6uLE+7QkWlP/JovL95hsGzF41OoySY8Rj+zL5EEDolKDPiodUVjuLcCS7fxSxuc1og4YUToCikATyPfEBRJ/KzVZRHCrqrW8kGD/cqNjxHZV7bVqs69Fts3b9+IDIq+2TQH2SSFFmxFHIpZSEIUv+YkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ+vz572/cWYtzoOYNohxRSXACnwmhXkRWu+y2FwTxA=;
 b=KBc5VtaI3pmrH2XkzdlJh+Dxh5u7Cy5SPcX48sT76d7Ovlz4i/dftiwAbosy99xw6rC5nmDDjr/iymFej8LgeaG7DCQrWVCN077CcCebEGa5mM6vxGJ63+vuncJfUMVOgqMUEdpPnwqCZdGhKCJFBPK5tNv2OM1xFadpNTWOuIqNB1BQYR+u7onU/iDcMbYI7BIs8aEnCiHR/vPf+xATvtTWN71I+HHmX+JP56d96g6gE1N9A3GKuBGNKxXC6XfIB0zrmRXb+oUGGx7sSfLV0jVN1BEqpAlGZZY1Oc2UmjtvMgY5vOkjzvt10P6oXEhIXDo6RkF7VdzaH0YyeN91WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ+vz572/cWYtzoOYNohxRSXACnwmhXkRWu+y2FwTxA=;
 b=Khc4/czbNgWqYgt7rr9RTEhTjD1RqXfyVnRVBivSKIh4xYOP/DNRT+o1mG6HCaSruaDkHc2Mlh9NrLDy4q1hJSCDH6CmuKyrKgDrfutgqsp9TvJyULEjbk3sXDIhMXc1GnUTUE9JHG6ZSeUN3qJ5yoa0JvB5IuZ7QInvsBFL5l8=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:48:12 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::19) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:48:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:48:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/soc21: add initial GC 11.5.0 soc21 support
Date: Wed, 16 Aug 2023 17:47:53 -0400
Message-ID: <20230816214754.826506-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816214754.826506-1-alexander.deucher@amd.com>
References: <20230816214754.826506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 51112b50-bffa-4ded-f003-08db9ea27c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyNsjR62/7fg89L1w+vJ0bBi+s3+nWNt6qhqyYVPk2zqfJ/GhLky4N3ZX2j7wHeeKvLZTn1Onze/64bvEs+HtW/H5f+BDe7aHfEtfM/LDxfkHhnkDDfo92z/0QC/BYps95xRtwYb3PYVRi4aWNGWw8I8ZecV34AWiHcgkGec375t1nHbrqSkt18IsWYUkxSaJKluUNx/toL7SmzkUPNfKUydLLUftDQrCWhUybs5xbIiVxhMyYiLlCZc1iUUTrTxVpOk0AA0RbnBA3MTSQIsVJWJL1kbl21b2RkhxIHfX/e7VQJN2I6rWLRcK0A939nakvzLh7uqlgAacT9trJAbnT14UWYTJKY03Uf01k9pi6D/4O728MhfLJjkmVRwHYaBhxaIeqONqTDpzbtK6g4WGzOrfXEf9Xznigw5v20S/9xuHN9QZ0uywLPYBnHHYvpoco5Y8beKDrRHtyleGu9MUvuwNrFWllbNKuJXX7NR7yID0nwRsSbsEncZLxaSVyzjZXCITn9Sac42gFOsemMa+BJWr+RmKRrE9c6ziTrvNtJ1RySTxrphoEprMbVemseBAAwUA9PnCC2kMwCizslE8CUzys6wnHakv4t/PQ4khcznSA4WdEwsoDL3wnTbOGHEPnCzmuQVFXUP8ise6rT6ZU+3f9wvBlF0pmcTA3N6DLaa2Nk/5Vr8bBNcnPLE9bpnd4xv61KhpcSGTqe+s9/0bh03JNIanKSrzuh875/K92YmUOBwcSVJ/jGF1tfPC51vvQseM3BajE7LrOPaMR45LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(4744005)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:48:11.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51112b50-bffa-4ded-f003-08db9ea27c8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Disable clock gating and power gating on the early bring up phase.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 40d23738ee4e..a920bcb9f5b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -688,6 +688,12 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x80;
 		break;
 
+
+	case IP_VERSION(11, 5, 0):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x1;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.41.0

