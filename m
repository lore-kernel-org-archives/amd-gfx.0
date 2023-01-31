Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E416DC636CC
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 18:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8712C10E377;
	Tue, 31 Jan 2023 18:13:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FA810E377
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 18:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0j3lw5+ZmqKHzth+n3prznAfIyLQbfmHJv999ydS2BWqsIVqptXuHZZcJGwRDdRmMXGmLYJsmuHrhtYZTc1tAbOuXZS4AUfkIs0ZizGzFG79FE8l85WngDAr1yKUG7XNsshzVksH1gma2PpthtG16HFJBaRcpI8RXyiNBsTq+Zbx4q2gyppun4Gsv96Bu52yNNPjmYC8zDvTesV4f3aK/rBkW2vUXFnpQMwhnVbjfSOm8Z5jxWeNLupb0GByHpIBQf8sRWhml4FEq7AZevu9b5lhge8QtGi+/DehbQELfrmTa1z9ijcRa4DJyPTfpNUNYg6+t655XAEmonnylT7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBKfmY80pBe/ycQL+saIXQItSw4A/TpI0X7UMQEfJyU=;
 b=W0/Ir0YU7F6IhUMOZ0j2o/w+SELNh8f4XA0kMiAPqW7Zrk6arvBgU0M1zA06KCAI7tVRlM3RHIdCzFme+Do67bZ/EUMbkBTuM/M2CZSmNwvD552cyG6Bdskewm7WY4Z1RCL8fyql3fi1UYFtwnf/SsuWjZqqoBgZOc2RiAFA+Ufye0E5+CAfYboLh37Y/8IKQEdUfNhsWkFpcqAtbM/rb7U1Ui1j5WgYdeLWjXqCKpCjT198kqW+Lzj0PU/fRQ+6Yjjx+RqbrEaoPCHODzZi1mod3RFqw4Tmw6xh8bW8cq53GvCnXj1UBi0UaMQXdr03/XZHx+2ekF9oxLg0l63O8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBKfmY80pBe/ycQL+saIXQItSw4A/TpI0X7UMQEfJyU=;
 b=UxiiYjIIPGZCait+q7N47L9VgA0Q+Gu3GGSM8ZtSfNeHKPIp0HVMuvsQbIAYM6Id2jnLQm7QwFlmZpE23mHiglcmrmXaUitVzXosW3dRKtrht/nzjl4l6q4Wqv3Hipf0GldrWRwB0pVJchohdO958m+DxlaoWCDez1XBuGZtkn4=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:13:53 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::18) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Tue, 31 Jan 2023 18:13:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:13:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] Revert "drm/amd/display: disable S/G display on DCN 3.1.4"
Date: Tue, 31 Jan 2023 13:13:26 -0500
Message-ID: <20230131181326.3507396-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131181326.3507396-1-alexander.deucher@amd.com>
References: <20230131181326.3507396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f13895-6891-45a3-14a5-08db03b6e8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPEz4Kr86+O1z7rLq/NsD4SBQg7YTw1LN6zE5/3LL9MC9PsMDmedt5gX0dwBJ34Gqaii/cGMvS3dTcepgofIlQSFIwD8EQJhiUX0IC0xEu2iigk5ZWxN0K3sfc+i0zVANLJ8N6pUiY2zy6WFQbVyyFP/pJ4k/bY6dZyqmm37MARc+XWBzbHfidAhqfGvaoGmUlxt+s6IY5mVAF8vhtjHgEwOeQrqkXrcCcJ1cn2vzVTSw9BB7dZZqtDaNoHfGwZJ/E6JqcABuUShD4UJ9ipI7aZCKVK+UiCPBpLT9dhzaR3U7bJMlxwc32yD2TdrSHAk2Aldz2rJ9HfcBKzCP0aKxe2Cpy7419FiserCsMfecVoLfR4Q8CsNlO9q96QNewQGIcyLDsPnBC3gd5cOrAbP+QMcEqB1Zi4atLMdDuYIYQ8LIdeF/Ctp93yf5hdIhTJTF1M5pd45v2+GQWsT2ujYIZxgEDWkU4jS6xhySVJTpY3286eJX/8WZkeevHSwt6yDk/oxZwsCdqolq74ry+xgZNgq3WrmTCClaq7ux/6saTGDsBHa0nS08ujDvRKDYwG/jeTHKn65iDtJsfUEsWim1wiPfHqFhRHNED6yPF3E/+NOKl14OxZswV+CvKEsBNM9OWXzXEdibKtUHLKz2/dT0VyZtTRtK/ar+bAvAA7bvKH2wkpDU0i95PW31PgRWW7Q7F94ruQa10EZ20fa7gnaBPeYTXQRaY9sJbwYL8OEbIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(86362001)(40460700003)(70206006)(47076005)(82310400005)(426003)(336012)(41300700001)(6666004)(478600001)(1076003)(316002)(26005)(5660300002)(7696005)(2616005)(186003)(16526019)(8936002)(81166007)(4326008)(40480700001)(356005)(70586007)(6916009)(36860700001)(4744005)(8676002)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:13:52.6734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f13895-6891-45a3-14a5-08db03b6e8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 9aa15370819294beb7eb67c9dcbf654d79ff8790.

This is fixed now so we can re-enable S/G display on DCN
3.1.4.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1f5b9c485dda..3f3b24a22567 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1549,6 +1549,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 				init_data.flags.gpu_vm_support = true;
 			break;
 		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
-- 
2.39.1

