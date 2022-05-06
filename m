Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6C0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 07:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B3310E7FD;
	Fri,  6 May 2022 07:52:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 266CF10E7FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 07:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUEO4SEsq35IpNMjT2y02CaIo0G3t7k69nvkO8lFIGqhskHb6ZSkb4Isvy0CQjCk+bn1SOv6DfAdNIaJFL2+P4FwiRFrdKfS0bXo2Sd5u+V1OBCheBA9LLwctXFjThJj2yo623XzT2wv7kiBObPRgoCSLpktJoA6EeG8pcPPvBiXl5PCeYafJLxSHAnLQKSYA8eeM+wrQGmffj2tyRZUKTb/PakmUxbd12McXcFzY0I4iHvVIAg75WmwSZlLQ1UOfnrWqbo35U1YK4d/AA59W/5FWvA9TcWwTcYwP09P0be/yo1trccmCpvClwFP85vufFxFtfVUpOIu50hvOWRdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzeNctPWxisBXWfYDd3y5bMBw9JiWMZrmKQj9pOvvb8=;
 b=Yn6Rw3RYeFq0UiRHJekz0d9MBQb+eJov8VMyTd1QYNsoN2ENZfa/JAfLSymd0j9889/Cdpt3maulOWUz0kJ/LDhZKrsHzjlEsfAU6Spbk56GzlYvVtIpX0N0cGpKTvNdyjLesVJ3tdhwzkG1plCOuCxfXkFrwE1uHy1t2OlrwoMKw1Zk9NkfZIXbuz1mAWm03Qbl1Mi0MhCGbTlUbcTx0CHZc+Ovcc3iVpYaP0hwf4CIXb2MkPAluPhttT9ds8f3dbeXLgF45qngbWVRV+vDewZa3la2rBRtTIQq/k1z7zyC5UwUhPxmiqm80jhCLqLYreRcoMo4g+t8wyIZg0QKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzeNctPWxisBXWfYDd3y5bMBw9JiWMZrmKQj9pOvvb8=;
 b=nfl5BA6eEyeeQN1HTNqSHvb3sDn+RsOtC1yw02Eu14zjqRW8ktv1oUcgfEfrmYQmtog67CkC4T3yI+WQVyh5yn241phXhcay/26TDNVwEXwyie4ayGQ3qWdQUNzMThXo2ZPst0JR/Y8D2RUkAwSpVfNVkK5KxguZS661q5oQsCE=
Received: from BN9PR03CA0221.namprd03.prod.outlook.com (2603:10b6:408:f8::16)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 07:52:46 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8::4) by BN9PR03CA0221.outlook.office365.com
 (2603:10b6:408:f8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 6 May 2022 07:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 07:52:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 02:52:44 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 6 May 2022 02:52:44 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Disable managing power profiles on SRIOV for
 Sienna Cichlid
Date: Fri, 6 May 2022 09:52:39 +0200
Message-ID: <20220506075239.3466527-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b614b03-9492-4ee6-bfa0-08da2f35684a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4209:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4209059F2D370945F80311A198C59@BY5PR12MB4209.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBAPvK17QT8w0AeShKZW67gKgDrh0BafiKdYm28yjAhgnX3wgpCE+d3iwx/x3gRYYkbwRooliTPHVYtGQ1J1eNs12E1P9M8uig8WoWbIK9W5NJxhKUCDATGhBXIxpSYr1lJ6Mswaj2b4Dz1ibK4UNEHP3xznDcbLMes6xaL06Il7vEltJ3rSao9DKbzpjyaoY5TZp4nYEIo+WFXm8ow8ypzdqKz0O2DkaHRzlpVM4SlgfqDEJv6rnsHWSKyWkgGO4H2jV05o8T1Qek7+e8IKhXsVInzgVSMUg5kSG09PuZkDvpSxk+w3a/w8i0+2kQ5WjueF/y7lKi+DBIpyRRZbjiGngqTVT/CqzGaAxjCM5SbNaTCG7UXXza5k98GLrsqwOs+bOZb7aN+FYwARzzyOaG7Px53odN7/8Ll3/N6xvxvYquyjKqcGXFFu+v9jTu3AxXfBrhpOWM1X2D93d/qGkTohkJYKyz+5Nm9T7TRd7t6u7J8YJiwAQt9aDXHY9/Div2mkDgAwakX/8XfoZwiBsg7SYn+4T3Bj6l7oFYG3oFa4NjHIR0O5mx+HbXqOXDwJY4gMXt9fo+CIvfbxPoyp4CPexGk98Rva9BtCs2S9IgFh3N49VZTIqfov7y3U5UU7c797943V1sFotvR2/cFB1Fee4L2IlgOW7ua7a38OQo02h29uaut1YhrTqGe5NFnyvcJojyqXLQs27tLoeTlKJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(7696005)(6916009)(5660300002)(44832011)(2906002)(82310400005)(26005)(70206006)(83380400001)(2616005)(508600001)(186003)(1076003)(81166007)(47076005)(426003)(356005)(336012)(316002)(36860700001)(8676002)(4326008)(8936002)(6666004)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:52:45.5222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b614b03-9492-4ee6-bfa0-08da2f35684a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 70a0aad05426..59a662aeaaf3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2025,6 +2025,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
@@ -2038,6 +2040,13 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			dev_attr->store = NULL;
 		}
 		break;
+	case IP_VERSION(10, 3, 0):
+		if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
+		    amdgpu_sriov_vf(adev)) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

