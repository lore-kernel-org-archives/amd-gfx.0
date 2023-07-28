Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF6DC001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 01:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF1F10E14F;
	Fri, 28 Jul 2023 01:07:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666B610E14F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 01:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXdRr5hWidO1zAOrnnXXlW35colOCa0BiKXC4HXS3I9n4KRp5M58FiRDuJyLbNu7ABJH55EOsoK5fQcxJujHNNR+zUSZdGPiidUB9kMQgrSGri5wRWAYRDSvaJRg0EktMwQETetcI1uPno5tK01lCL3m9X3ENwYBXHWE0iDsXPRdLdApnG2YwtkdSaL+4ysU0ztD1sYwQm3aOU6e95muyFy61IwjN3kJKb131GTiVyByU7HVgEqjlPL3zjJCmGHM9AwzEMbLR+C5KvyWsEhqXrOcYJzZoFY6GgscQpxqBYhX680/hEkLe6pXxOJKfOkPPyvHeEHNZ9d843+e9NuEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmDoO8lhd21A8DLi1otdHsn6gDXa+KA2R/VX69IWj2M=;
 b=dP333v+nvD26dJvzHui45mY9Q206KJp19OyWUndOc0jGyxZbWveX7vVDxkryqzp0xEBjHUl1OYXTiFL7/bP/2bYjRrOrGkK6oyj+06atm84PUudfXUJe3NHUq3s6HlVgPNj7FJ/0b3SEmQhHehNyNUnp4oVXIkkpHP3kj//sPGfY0HB5jtg7+qrQ4b8VZslSPj09y4GDGcJ1+0wrBVajxOgx3xLqfPO0x+F0F0lyLhW+hKgrEBXXAR85E4kcFBVAZn7ibRumX6Hb88+573OQhz9a7hPILUJpDnjFTs7Drb2YCiWFlULcuV0CpAMZKog6ODCZdAtJM+ULw2/HLbC6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmDoO8lhd21A8DLi1otdHsn6gDXa+KA2R/VX69IWj2M=;
 b=NcD+qF1OMbzvOoUyAbxM67cBhnhV2cx8Vmttsv3EnY5yBsaqTg103hZXCjlQu2AkAQPbwmgob6IXAnOEijWSVPNNamAtj6MtDxGsOhN4JypmHbKcNjAfRvYHfVtSGsr/LwhmOjlGbAodnbd3DrbHc4hr+OAL0lNAOeALxAfEkeo=
Received: from SJ0PR03CA0130.namprd03.prod.outlook.com (2603:10b6:a03:33c::15)
 by CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 01:07:20 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::6c) by SJ0PR03CA0130.outlook.office365.com
 (2603:10b6:a03:33c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 01:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 01:07:19 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 20:07:17 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Date: Fri, 28 Jul 2023 09:05:04 +0800
Message-ID: <20230728010504.532158-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|CH0PR12MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c8af57-75f0-4d7a-a157-08db8f06fde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHkp1CtXgW4jCh5yBch2Q4g+qKIqOccOKTZKqNlWT65g0A60cnbgSWsFVtEibraR8mryKnJCSkA0C1Ka9h1ieu325y+7Wg45mzsoLmwylXrZKPCJ+fhYfzILbQOl1IFjtsv3SCQy+wPYeonFvsxqdLUOnTbk4kA7P6iDrQ2vJyyhV/dbFzQ8qrc93s8WFOjqXLCNpGa6C6+k/WI0j+ms/5pLpYX5oucXz+Apdzju04sIAHKHYPcbdlamMAful+MOvoUesLD1Z2CoDTOj6sOzN0T0oZHcSvfqJUy+TKqodjV0zO+AKlk9P4BMBo5K3JKApHr0JvsvMdnrWlOuDL9ru/QxOEwmxVwPXoV6QuF3oZMaAxLH0oMYsLrG8WIheH9JuZtCMgVsbpNpb/mgli0umHj3OXBdIRccKMo6+RcR7DCJHonNYqOxkzZ/bH7ZWLSjVhUmTXt8XPGjkdG/T/BRvxPL+52BfvoSEd+zx8W/ZOwN2anawCpm+CAVkSxrmRndDuQrIV4jNxPWVRiJjBsbXlM9PQz+jDjR2M/XmnvisGnuVYROvBQ5zoWnXYQZG+a2Wl6mINMjW6nbVZgaBDGB7+LwaU7RvQaul+FivjUmYFYGTxKJm47SosNP6YlPiOycAfVO/dGCcksnzdTldcyK9YUDpVYSsOEhOQ/+QlMPrqQfCCS3hQZgCMU2wum8G4JIC8Y0+Rqq3Qq3+8FNLsAD2YMBUb/2ZdGSPtDaBq6vAxGCVop+OTok4Sp+PXfvWjTZ3ViFHdclV32VQHTlAIgDTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(336012)(41300700001)(26005)(36860700001)(86362001)(478600001)(36756003)(4326008)(6916009)(8936002)(8676002)(16526019)(81166007)(70206006)(70586007)(82740400003)(316002)(186003)(40460700003)(2906002)(2616005)(47076005)(356005)(44832011)(83380400001)(54906003)(7696005)(426003)(1076003)(40480700001)(6666004)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:07:19.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c8af57-75f0-4d7a-a157-08db8f06fde5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Mario.Limonciello@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <Tim.Huang@amd.com>

For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
the firmwares will handle that properly.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ce41a8309582..222af2fae745 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_context *smu)
 
 	/*
 	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
-	 * for gpu reset case. Driver involvement is unnecessary.
+	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
 	 */
-	if (amdgpu_in_reset(adev)) {
+	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
 		switch (adev->ip_versions[MP1_HWIP][0]) {
 		case IP_VERSION(13, 0, 4):
 		case IP_VERSION(13, 0, 11):
-- 
2.34.1

