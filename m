Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229C7EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 18:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA6910E3AA;
	Wed,  5 Jul 2023 18:07:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA8B10E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 18:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW3/CgZrnjXd9+pANRCwfSOIlDonlpVeX2TwCPVR72xZK831I+QRRuMigFgbyxwVT8itzKRcLsG7bizl8J9n86MZkW4+QFxtp3D6qWwTfi17W2qbdWO3lgRyCT3JG8XaSVZpaCJPZE+YYql5PyzG/gVREhqF3FpE4aY0PmJu6DWEH/5tIaUvdTshX5PxIB+kZbQgYWYCcx4hA9cBqRg/+aFUbNlsh9DDVS0fdF3IF1XCtb1yeusNJ0iJqvBqr7Pgc/r2K7HkG3XRQv6Jk3j0OMe5aiwaSfjtCPAAt50jkm7IA5kJOhHUbmurlfNc12IOnAmYCZ91YVf1wC/1LHJXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7lKj1uP6QO6eeFoJ9WKWBFV2nBde4L+ya9ZhBoLna4=;
 b=dEJEIBVCkXl/1rm4o+xQRgPKZuloY6ggfjCT2Ww8FpI0gB9tRionf42rECB7oeQDZwqlRzMIU2lpXM90GQXJbTSkE+0pkPZuEgoztKXpW9kNF7cA3loG9D5AYBJgGfvbVLRWWmYfcQPLgWbsDROf8ZVwlG9+m7IvBSZwL6WnGfVuyE9LXzOql9ks+cSAn4I6SBoM1Kx32wO6CZQ+7CcijMpu7kKyy3mHYD030ULReacEjT6TaohpS/5PPZxFPyr8taXbQwDUvB/Y3CTG+KmG3QndgxpyNpAZb2wbvV5t5dpsPQc4S3o0/+tZMc0J+ezC9h7Qor0S4kAbgUPOxOkeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7lKj1uP6QO6eeFoJ9WKWBFV2nBde4L+ya9ZhBoLna4=;
 b=kKc5zYrD5VE88IvLDPnTwEjZjq59GI+4ynMgq92zeVoYUNoMes9vFTAAxYMgdDjC08jAI+DvsrPNEP/sLU1IemMC6lI0nI/hUdpX8fLKs0R/tNddCkR9BZDhqXKkFFBlGhQIsIlCue/N3NHFBdwKWtNAUFF6f74EykRNUFjGTNs=
Received: from DM6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:40::19) by
 IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 18:07:12 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::39) by DM6PR03CA0006.outlook.office365.com
 (2603:10b6:5:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 18:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 18:07:11 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 13:07:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 2/2] drm/amd: Extend ASPM disablement for Intel Sapphire rapids
 host + AMD dGPU
Date: Wed, 5 Jul 2023 13:06:33 -0500
Message-ID: <20230705180633.21538-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705180633.21538-1-mario.limonciello@amd.com>
References: <20230705180633.21538-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 86153c81-ea11-49ed-13a9-08db7d82a7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNWm1ZYzug7DTogQWtiaVcsFgqhwmoBQkHqOa3ODu6e9nmsDpMV8DIUq+OD70eQ7nzW0ITJ10HylvFKkJZ8GCa439VYJxqbCdk92bR02kf5cGyoLEh9NsswTtgH+xK9dVK9xpOf7x/GiWAsuyauWXl6DbgzqAgrpihQ0lxCMLlgH0NZ2DkGES639892cwSSwjuVGQpfnndooxYd8GxrH+oPwHvsV/w++m1VO+rD5uyp97mBDfCfGg5HNKvnzgqHPlrbz3cc6BeU87oARq4FUzOOf+jFb7A2TZj8gW7Sjj8/GD8BWXZzqLjE66y1tuKnMnc9jT0QKyfMCKM6wqdijfyQLE2O9grvtgYwAJopI8Vu3cXXebipIB5X59NdQdPiLrYVLO9Ol8yr7nAr2RTqWEppRVFneVBPZ3jtBSx60Ny7mbdHPO0QBe0f+jjJimd3aP45yVWp4XjZ9ieHoTrK9QMGCDW2fkBRQKoOz/B17SE8YiBIAut6XHPnOtKqENG6HrJAbGp+UyhoPDrhEDj2tTR53A9MvU9H0iHzCNu5UVBGP0KKD7V28gorCn0Lxa1DVOjw5tiSLgWZz0JSX7JjfWOs12KHuVCim5ufx5Jpo0OlSZW8ZkZZP7UMlOR7ZclyXM+wSYIJibrCv6cEBk5zjVlhN6gHHFOJcHkOrniaXKx+kFnRMR8BZicxfRWQ1qAqsiJZuj7syA1ZBrruq6QfPWFGhbCynyVkY1G56GFHxxErsoYq+P9PbE/wnFerFX00e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(186003)(44832011)(70206006)(6916009)(70586007)(4326008)(316002)(478600001)(36756003)(8936002)(8676002)(5660300002)(2906002)(86362001)(40460700003)(336012)(41300700001)(40480700001)(36860700001)(966005)(54906003)(7696005)(6666004)(82310400005)(26005)(426003)(2616005)(16526019)(1076003)(47076005)(82740400003)(356005)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:07:11.7059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86153c81-ea11-49ed-13a9-08db7d82a7d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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
Cc: koba.ko@canonical.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sapphire rapids is reported to have problems with Navi3x dGPUs where the
screen freezes and the following message is in the logs:
```
[CRTC:56:crtc-0] flip_done timed out
```

These issues go away when ASPM has been disabled. Extend the disablement
for Sapphire Rapids.

Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2663
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef22a0a6065e..e9206993c743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1476,6 +1476,11 @@ static bool amdgpu_device_aspm_support_quirk(void)
 	 *   c08c079692da0 ("drm/amdgpu/nv: Apply ASPM quirk on Intel ADL + AMD Navi")
 	 */
 	case INTEL_FAM6_ALDERLAKE:
+	/* Problems reported for Sapphire Rapids
+	 * Navi 3x:
+	 *   https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+	 */
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		return false;
 	}
 #endif
-- 
2.34.1

