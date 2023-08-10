Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4625BC001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 10:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0A110E0BE;
	Thu, 10 Aug 2023 10:46:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F9610E0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 10:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxrzSxK1n3N+NQJ19cqusQCAiZnemAOcwD8VszmWof+0oKdaE/DU4Bs/I8DN71yd8qBVc/+OLwBcSTMy6P4ny/AzH3XcVetFWRGq9TZFKuSxynH/yjU7adfzLtpRB1rmoHg50B/jOSiYpUqQ3aJUiONtooTlmrk4u1gzH6YK0VU3dPEk+FyVMtopsTEYv7dbqC4PZrv538tvEBK25SXNJaizwDXCeadevh9JdRneBBHv74LTChmRPSdTcR0mUfhWPXiycrArJG0n9h3ur9+YuUVNJ5Q4ggghVCMWzxFJlVvps/QPUs5yEPnWqCvILAq9EfgTRaNUWE+8IlzNjlSiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9VoLFbjbhrpMXu1nOxnYLugINvbpFfH3KCVMtyT9A8=;
 b=Yq7yidGuTiJZSGOSOGzsFW5hN/Js/Gm4EsCtqIyqZd7ow7EZTQ10wZkLCVJtLmP4hFjk+v6ENThRBuuMHXnhgeB0WAI3m2QCafCmjQ4YefkJ2H9IvBOTRUTPNjtuVVNsv+Oi+lRox4xSHeEgxY122MFMUXmwUAt0a51SfhbOXXDV5cORxs1pMaiFYX6iCYbbTJhmpERrEVGCpkBg47xUgZiX3pzSXBgWzaDtdOPHNbWinUiIaWnIUM/efFtSramHD0lbj81grTSaPv9Dkm1GRqXRl70kTgbysakwxONJC36gY53mGtn5GSvNtQsPl2KeAk+6tscnjmIsaVuIsfuPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9VoLFbjbhrpMXu1nOxnYLugINvbpFfH3KCVMtyT9A8=;
 b=QhSJBWAuDcesUtxOJC+uUMBzMJsRv3KG2pdeR/jsQ6W5xJrhOEcqG0VGQX7rdIv6VOxGN3SJujBddhmEKI0CnwW8XPPYRhe3muUl0Ky699PK8RqEKplrPbyLtphEgKMzXiueZGyRlZwXRQcKDS7XYhgFLIuhRjMheh3J0ndsOBc=
Received: from BN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:e6::7)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:45:57 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::ff) by BN0PR03CA0002.outlook.office365.com
 (2603:10b6:408:e6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 10:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.18 via Frontend Transport; Thu, 10 Aug 2023 10:45:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 05:45:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix temperature unit of SMU v13.0.6
Date: Thu, 10 Aug 2023 16:15:36 +0530
Message-ID: <20230810104536.643172-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c21c071-cfa5-4813-7318-08db998efa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hpjjJGts6XSt0V9EluEHd88QUO2swZVGvXN1S1jpq3RA3hgH+m6dxGjARb0ZYd/20got627bIJCfAw4lNthvcY1C9ug40e+H8sjz07HUKXS4I/Lux4Xjlmqcjw6ttnDy18lkVmN/7/Q+P5t6YgDPrlfpQWLav5w8+LqBBo60cnk/pDI15j/YQknbzf87idiYjUTNgEn080vKLkcgppXwkcYK1s7KHcmiQam+f3icGsmLjfJ9FelYNa2iw5mltyMI3/w8RJhL3KXUlLY3nai7w5LWm1/bGsgcftliZIpnhjsaQtmeXnlPW+V81cKvi/TOtTtLe4dJRkudeGdEB4qVggUwg85sKJX8Btje0V8u3l9pwT3kD8mG4H7CB87pucYwYQnjw334W4mdveKo8Uuocy7S/KRUCzioVNNx+HwAkoRRU6uSVabLeA2srmIlbHQ2tSpOTgJORDIxoBIIPOvFIaMHlqeWmWgk9UIYRrjF1TXR7joLBmXphixFsY406IUlg4Bu1IupzT/h+aKF1TufDwhv1051sN/Q+xwnBOur1NnAes0+r/rXFZDn1OAmx6X8NhzBh79GrZo+fGP7j6m77kYz2y8bHqQiPJ9voGTWd+R57/KCNyZem5s7MJ6/LpD5eyazJwN1DP9zJLFVarmRW99rT7QuMjrSdAXgKqTxwROLdmlgSjpmvD/b+FUGYns2dbohUZg8uZyqzIln2+773C8Z1prmhN/KvO1q2hcvDzWlwLXBiO+C9rCnErI+D5LTymAS4wOGm4yUdNlxuajhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2616005)(426003)(478600001)(356005)(6666004)(1076003)(26005)(7696005)(54906003)(82740400003)(81166007)(70206006)(70586007)(83380400001)(36860700001)(336012)(16526019)(6916009)(4326008)(47076005)(44832011)(316002)(8936002)(8676002)(5660300002)(40460700003)(41300700001)(2906002)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:45:56.9066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c21c071-cfa5-4813-7318-08db998efa82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Temperature needs to be reported in millidegree Celsius.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 244e6d31560d..da8ba1aa57eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -708,16 +708,19 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_TO_UINT(metrics->SocketPower) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
+		*value = SMUQ10_TO_UINT(metrics->MaxSocketTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
+		*value = SMUQ10_TO_UINT(metrics->MaxHbmTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature);
+		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	default:
 		*value = UINT_MAX;
-- 
2.25.1

