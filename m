Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535D0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882DE10E4BD;
	Fri, 10 Dec 2021 23:05:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407E810E477
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KItMExxmxTYd1e3xgMDWf9RVSuOrxL0+mwdj8EE1xRqEfkRKazVwe89jul3SQihwfbMM548TU3jOsrTK3R/PH319LfmRjQrelX7P/sXd6j10LwD8z/L+AhlpQ5WqquyTOsJdJ3U0VK8KQolRvFC9yYRUSe39w/1NPAkVnkNo48l2E8QSgoRrRTH4EF41xrW0PTOu9uS3QJx49ziMBDR3vdvnWcjNFT6PfKgeRIeu40wxnYSIjU2SnD0LlOfg4MPvgr1Vb9iBMBh9oyIHtbQqDIOB2Un7eIMuq2jyFd9hDTWINdv2tkyHn/aK9RhC9p0i37hfmlOz2oinkZCNaG5sHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSiSnOn5nkY88dlNQgOoUj+0kJTzFDzHeGHFgWdlOvI=;
 b=jn+oOeaIvzxm2U7PZVdoJ91mQFMtlrqh+i+09jbBZYJhCygho58I/WSsyjWDGay5VwLz8NTearlIVrmiUFFvnD+nujTfyWn/G9P3rWu3THRI3WuMQZ+Gns9+0BDPeOpZI0Vqc8oWqH0svhgInDVvnKnOa4vATva7eCQkhxv7vneIJvrmsFeDiRc3+wY/eCxtvKgiNC6PYO3kBsW6xts4+7MHtY+6G9oOcRnc7gAjpw+/ZvVE9OygDvTkqzuzUuBZ/+ouMysECDuRil1GE+4RcrSuokcs9w8lsfOlubQYeaS5EmN8bAxv5v6SISaFx+uivePtfr/Mi12OftH1ZIcxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSiSnOn5nkY88dlNQgOoUj+0kJTzFDzHeGHFgWdlOvI=;
 b=HY2xnl0NMoKyMgq2h4j5OTbsfrEgz52K00nxRpS0QOOz85p1iKH6ZjDBDwGoK/kGFk10NqdYZqX7FFmDW4MmTQVCs9O9hvhC/RTzQ6x7KVhG2HS3lqWzTQJaVDcusQuTti5X7JGJ8t+aNL6FHwiJqTYo1a+A8eAFvMpdgcuvqbc=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Fri, 10 Dec 2021 23:05:23 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::4f) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:22 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:20 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amd/display: Reset DMCUB before HW init
Date: Fri, 10 Dec 2021 15:04:05 -0800
Message-ID: <20211210230408.619373-8-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f23fd013-739d-4cd7-c3f1-08d9bc318b59
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB351670F4CDAEBBD73074A9E8FC719@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFYd/3WNfvuzFO3fBeWX+PBVCcoer3ItDZ15DC1ghV/17BZz7ala21pYKU3Le8StciYkh7Ezr8tsMoxFwDaq2MPdPFU4zv3MybT7cbjkozTgRitvgoxZ7BQHNgdjNII4El1P3sNmgZuPwuTH6zyQlUZIo94u34j/5W6L2BEJh6HC/q2DC/Sw3X9is3EG/FJB/o2mB0N0wdMu8WOrEa6FcoKxu27fmq9/U0R2y0fMLRgcBAMBjJxzaEqXba4YOOekVChd8wDOtlFpZ53/ZEzCMCNg1rQurYqZjTvhVPOFv9Cz7VaVByMqmpvnHodmJfrn3YCtot/LMalJYEG1jDOJtwmJWUkWqV/Ozi56X5GMEXJtii7oclRfUysOLk0bO/bNsJnwYXK0YaHOzaU8X2qSfTPKELupoaIDShbvh8/wC8l9VTe1YofI139hq7FRvq8dU2tABZXWN/jDwHbU2mcOrWysChioBDJSL5d0l/vLBUlFClU825oyPqyc5rorJNVtOwmXcEmqSzlsFuqKqnL9723TwefAsG2HbERbm7iOi6nwe3ZjQpKuK12x2q3wv3tKjSBe3ieR77dBHZPVQ8rgZPWh5+0qxwy+S3y6gktkghbQrAjKFGw4eCyRvZMFPI1bLUhKPV/z4m+uEeDlPJz0WKgkqn6kH6u6BUSYldKE7wF1jybHcShvAOev46Wy6iEHTlpE45ecTtrd57d6YkHRbvm1qK2I1DR2BStqQ1b/T8/J1iYjj3JFBqlKEA5LaY9N2WEzlC5V2DOtXtyAJ35A500dKCQ3unYBLPLqZKVPKLQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(508600001)(8936002)(7696005)(36756003)(70206006)(6666004)(70586007)(1076003)(5660300002)(426003)(40460700001)(2616005)(86362001)(356005)(81166007)(6916009)(336012)(82310400004)(2906002)(54906003)(316002)(16526019)(26005)(8676002)(4326008)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:22.6189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23fd013-739d-4cd7-c3f1-08d9bc318b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If the firmware wasn't reset by PSP or HW and is currently running
then the firmware will hang or perform underfined behavior when we
modify its firmware state underneath it.

[How]
Reset DMCUB before setting up cache windows and performing HW init.

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5818f5dc5e3b..b015fd924faa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1050,6 +1050,11 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
+	/* Reset DMCUB if it was previously running - before we overwrite its memory. */
+	status = dmub_srv_hw_reset(dmub_srv);
+	if (status != DMUB_STATUS_OK)
+		DRM_WARN("Error resetting DMUB HW: %d\n", status);
+
 	hdr = (const struct dmcub_firmware_header_v1_0 *)dmub_fw->data;
 
 	fw_inst_const = dmub_fw->data +
-- 
2.32.0

