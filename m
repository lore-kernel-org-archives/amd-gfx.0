Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB756C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 10:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392E910E13E;
	Wed,  2 Nov 2022 10:15:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DCF710E13E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 10:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiluffN4bAUcPrmugDdMm93wbKtp2HhGqLTvgUHJiTEThdho3ftyPq4zKKfdHl1Gh/qKFYxQfoZ2lpHYqwk7XYiS0Xj74rEmWIHpmKbBSVvp9IdvgSyHQBE6G5g7p1l1Wcr51gW1Ig1b+CbahV4Grf9MO+fHyYAm5I2hOq1IE9ThqjJcrM9obi7z045BXrp3z5IF+i3UFFV5+m+fDMLswSuFeU++MLm4MO/zwL470RbKUOnMDnqb2L5KzOnO1PcF5eUMJUMJjHIErLvYHBmBEr9GkfDDeIRaDqRD6TklnrmionagS4G2ccLH9snjiXdaXc8bn76FBqypVXSCTNYQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc5p99S8Vp5/+9CVfdip9I6HnT+SGExrZgyMqs8CxbY=;
 b=ZTOHjlhNGdF6ZwTSCsSzRK1GIpae8NeeiEp0FqdomizxWjTzTjf5uOvdsmLKPpsa8GxDmDNiaPLGk1HCr6MJhtxvlgUhkV8vXQqJlz9fq6vKW4c9wjbWmZizKq5VKtWtZw68GnZaWfl5oSTB4un/AnkzG8eDV782IKPnZMYGSfV/sWygGriylq1Tz4iv0EniGO+Ctvp81qDUFJh0J07/4WGUZGzDkm7nLYk5KxB8VBxpoZO36P/Eb4HpDtGb93GP1CKCYyZi0ZsrNGSNs+0DWPH3ybGR+Ndg0qVPzoJVI/ZKRExNp9VZ8zMKHW65aUr11iNtApB8m3u8qCjSbuDO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc5p99S8Vp5/+9CVfdip9I6HnT+SGExrZgyMqs8CxbY=;
 b=QRylnZwav9MyFhIF5eCK2VEKCyVxO0yHCSMkmNAczcXVXMX+WtHopNViYQzG9kDWOeiPauTRnUXDmayw2GaY2JQxVZNvODOOefBCzzo6B/dulI2dZPnw1Ukj6+Y5EWCJ2uQkGCYdM90DoivhxKZaf4h83YEJLgYGdcPgMUbmklU=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 10:15:03 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::ee) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 10:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:15:03 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 05:15:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 03:15:02 -0700
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Wed, 2 Nov 2022 05:15:01 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: skip ras late init if it is not supported
Date: Wed, 2 Nov 2022 18:14:58 +0800
Message-ID: <20221102101458.1243982-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1770bef3-4b44-430e-bfe2-08dabcbb1b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFWjqmPV//krLJDGEiQ/nHK/yKBON//oPxn9mY8RLovzxhUNnCJ0QPUrHjB28jwU5W06kg9CS26O0AnB0Zu35V8rDhFYPjsyBC0Bliokr4/hQCV3mzSCzkW9BAoMgu2Z4PoAclBCIiUFKvPRr2hzapZFVgYz3Glo0iKMlgxm6ax+5v0xLdCtWIfh7PvkwpNnSXLugt4EntDXUnHGDXgiASfaep4fbs/tROMjoJwP9LuOMm9A1uIfCXck4LRUjZRad/nc9Wto3aQPtr6T9Jx00IK9HHVTfUqtYs+bc5DYegUbZR6Bb+71aBYESwFmGEvCt22ISsvtnIaZFWLheZx8CL3cz5UGVu1yfnEXKGO896rCAw2QynpjPOV+5vQkS718ALShL59qANO2fvmFs9p5wRXfWXwBc8U3wXsT/rlf3EIhCTPTFMzrNVfttNiWoKtTDtSXvAy1QfnWxLiNHlc+80FdDXGuEasU/z3NeSOltG/Z6gS0eMJ84g1atYGZ8elQCzNEQFEIOxxHC+WsdmwxWgdCfAB0nzL49UF6oaYeqa/ccpXllxscn0dlUrlLQeYpJwjeFRVz0zHKltNipYS9ZP0YM8Nzo5fSfSm0S4bQ8uAX4AJ1BN79CE2nFetnc1jVJfphxvjQxqk7ENsimFZMxQQtHpDLmx6NuTtkLR2DF/7QKVImZprgsJarmgBvMfDnsqV/alx+6D5V0lKvYyis5Jk0/VoSnzH7jbul37RjjaEYDSUWnEXAxuFn6g+z/eLM6OeuQTbgOJXGy2oGWtQWOphirjkIlRVh8JFZxN00ATTaxsc7JMTdCx1e0FIIALLr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(8676002)(6916009)(4744005)(36860700001)(44832011)(5660300002)(316002)(86362001)(478600001)(7696005)(4326008)(40460700003)(6666004)(336012)(186003)(2906002)(47076005)(82740400003)(70206006)(83380400001)(40480700001)(70586007)(26005)(2616005)(36756003)(8936002)(356005)(41300700001)(426003)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:15:03.0830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1770bef3-4b44-430e-bfe2-08dabcbb1b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip ras late init on gc_11_0_3 if it is not supported,
in order to prevent the hardware init exception.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 84a76c36d9a7..afe1fadc1e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4707,7 +4707,7 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3) && adev->ras_enabled) {
 		r = gfx_v11_0_ras_late_init(handle);
 		if (r)
 			return r;
-- 
2.25.1

