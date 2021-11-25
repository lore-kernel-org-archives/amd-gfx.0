Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C74CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 05:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADE46E116;
	Thu, 25 Nov 2021 05:49:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADEE6E116
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 05:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THGIuWPPrsk6Kl7rhwzKNoRGwXwo15uoGb6nvocR4ZCDZZ0onN3ehNr5IzAcw4smI10ygo+PH2zZDbvrjOQCs/H5KU0l2Tb0RV1ImtoBBHrPFITl/lxmsBBkL4QTm4JpRF2JgfilQLpRKCiOeiibf1D2IOYciSjzcbonAb+sYlXRcbnDhYvvOs1O9EwIFPBIpvk5NRKC2oMZRoiEypYfLpQNI4Sg2Kw1HgZ0J9/wu8sUU6TOGwDfKeDE+MB09e01eKngpJsCYf1eWsZ9hy/cKW4AilXUQ608bcmP+ZDTw61kJS7dpat4I6KTenVlkZQUjta4bFSOkl4Rtn6lO2U/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mHKCWMo9nIfgj69VZzc9LjiDDdjy9bABr4RokryEmA=;
 b=Zy4a7/YKMPqr+atocfQFYl1GXNOw2aZVjJZPeLzekJCpZ3eYEmoNfJEuDgkPuIHc1k0Gv5LdaZnIEAZ0jW/xXLwI9JtCvIz16a7CF50pmXbv+H77c5vr3klqNEhbRv8QbeszjJKOEbArNbsoxRyTpGTA2UPfZRgB7f8eyNR5QrCTtTScTHKuXWL6GTqkBz0EWtZLAFFA4y3oKItMEpVhRTnatzToHA7ZMyl1dkO+1NWULizAmUsM39CrYjgnLFDgDfqxPHfBIUDYwV96b9lcWPRwsASNcyLu7q+hOjaTjAL25s5F2e5UzLM8F409m0NzteP/mtNJDn+ATr+qtAhjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mHKCWMo9nIfgj69VZzc9LjiDDdjy9bABr4RokryEmA=;
 b=dVRbneK3h1Xxx12djnPwUgX5RuR911mDgjTMkV3Cj1CSYsuIkmVdCxNvtF689op6B+Ft4nvPJys1DLaZLRHulhrG5zHJbneR9ANttAGasrN4P/jNnQMBbzWFcx/tIxtBoCzcE+TrutfMwD5rKsDyQcrfmO2wtF3NyP+3OVVrnCo=
Received: from BN6PR13CA0072.namprd13.prod.outlook.com (2603:10b6:404:11::34)
 by DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 05:49:30 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::1) by BN6PR13CA0072.outlook.office365.com
 (2603:10b6:404:11::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend
 Transport; Thu, 25 Nov 2021 05:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 05:49:30 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 23:49:28 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: reset asic after system-wide suspend aborted
 (v3)
Date: Thu, 25 Nov 2021 13:48:11 +0800
Message-ID: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71838cf8-4dc7-4afc-8d51-08d9afd75988
X-MS-TrafficTypeDiagnostic: DM6PR12MB3500:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35007D0BC24160342E257F69FB629@DM6PR12MB3500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkveyZP5mJvNz1F8FM/SHBN/yAywgRgmfg2JgEDhhgtHjaU4Ii789JGS78yFAKXC8ifgwe/WOwRFFaeqlnqPIRpsgl3xV0vFNL3cag+L7aqeKCAM39CTT9ECUpUzSRYgJ+OcBgH6SergpVt3LT5sUifccR18U3XXqSEeGyLQzUtrMl4ruB33gYlY8dZWQAtnxcbRxHUvxB98qeppKPjEngO6rpC0pPJhYBjmppe1SMgUFMvruEgRg30pHGGFUWJA6gPwPcgtFFX1WNbDld7GygTF+fbYsobSxc7b4akYVbMb5XAqDHoPf1CGxjnhQA68bOvAx1U3yyMqk9u+PQFcPTlHweNou1aEKhk3uM5lzFSw65+ndTh+NN4aTzlcdlMoMyDiZeLUkZuDQlqxp878vNBDqZTqWoOBnG6mMXdD2QLTvo5fQzyjDawkS8xSiux5WYr6twJbufnoSAqGFXbq7fZM0iSOI3xlYKUKMBp5jPgTOZYCB8nTdyMZciXngR1cw9cJ9x4Arhoi2GCOa3DUwtoSOsDdwYFROIDZAch3OxWZ8nIFu1KqoFzOGeRgPY2GQ1kBaQMM9fKzQpNRL0DAVuGfyOz99FXF8LyghoVm9O6Zte56HPX3SV9A51fjOyBpXxQsvgRKsHxNoZG6JdPSmzFQJwCn0Js+gyaAHe+jbzQX46XWIdW+Tkd1obSXDUpWYsgRjQGkKvQkts9dR2nE1t0kehhfEzVJXgcpSFH47cM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(16526019)(8676002)(8936002)(5660300002)(316002)(26005)(82310400004)(86362001)(47076005)(54906003)(6666004)(2906002)(15650500001)(336012)(426003)(70586007)(81166007)(83380400001)(508600001)(70206006)(36860700001)(6916009)(36756003)(4326008)(2616005)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 05:49:30.4136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71838cf8-4dc7-4afc-8d51-08d9afd75988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3500
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
to keep AMDGPU in a clean reset state and that can avoid re-initialize
device improperly error. Currently,we just always do asic reset in the
amdgpu resume until sort out the PM abort case.

v2: Remove incomplete PM abort flag and add GPU hive case check for
GPU reset.

v3: Some dGPU reset method not support at the early resume time and
temprorary skip the dGPU case.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7d4115d..f6e1a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3983,6 +3983,14 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (adev->in_s0ix)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
+	/*TODO: In order to not let all-always asic reset affect resume latency
+	 * need sort out the case which really need asic reset in the resume process.
+	 * As to the known issue on the system suspend abort behind the AMDGPU suspend,
+	 * may can sort this case by checking struct suspend_stats which need exported
+	 * firstly.
+	 */
+	if (adev->flags & AMD_IS_APU)
+		amdgpu_asic_reset(adev);
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_device_asic_init(adev);
-- 
2.7.4

