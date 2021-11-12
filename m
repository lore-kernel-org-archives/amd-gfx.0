Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87527C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E54061213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E54061213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E65E6EADE;
	Fri, 12 Nov 2021 00:56:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E926EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amjWDRPAGzdj3Z+zvJUPh8YVmUHeXQ0M+Qj79O3e95gKJWJd1GUO1bzN1rZaV50xSs2RMwA9ceNdrOfD/zTCkNwAIAObtbRGKzJBjPw3TWZCVKyCqiJUkaNnCYESoQbpIkHp0CObCDZ4953EOYl0LCz1dliVXhxzYZJFhyHGrX3dGG/rAIFTxKD8S2JKy5yzyqgftMr/qag01jv3V3+Jx0ENegeeUNQJcZu5hMynr9CZSAVtJLaSrzeDLlT5SLPpVmMBGjh3hBpD0Z2bDl/WWptgCA3UWNInkjfVlgqSUudYh1ef9tdhApOP4IGsy4BxBew11TMmjZUzYv18bfa+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDm/QDFkCyalq5ibr24TyV+kkpJm8oZAZD+rE0leYVc=;
 b=enFhNUdtWhE7MJ36Gdo7lWQUAyR8tKMd22+Vso1L1u4eFJFgMI/xFTPK67rCZm4e9/3diGpA2Cpcj/8o8Y+uK9kafEBXD/xS3W1fBszAsFmxuLaJ+9XcQKP6QtXjxlhQlS7ttuqNHKyfdTPSzZww9yOe3df2/GE2SjWxxpR9tuR+/RDOyuoUR2xQ5HqVer8NgFi/vG1Lh+lqQ5OB6CkGP1GS0J+NzsZJ95S1lDUFRDtRlFvNmx26XYxoDafsMKm184vXdSxOBy38wtJT1YZ8lR176RsKECQ8Vzh6LDrqqZ+78t93+IqIh8oWvWmWxSlfkEVRn/M7uOzfBg3W197O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDm/QDFkCyalq5ibr24TyV+kkpJm8oZAZD+rE0leYVc=;
 b=hF3IysCePn153zqWMK5AyKjMCvZ2eBpfxh2ItujwcH5PfQPxVYYe0Tkn7uHJiretTHmGok9cvM0vywObEBxcUXSIPJbwBQ8R3sVwxV5FIpvTMPk5qVaq4orbDHvphV3K7mpD6mMeGiYWbBGWfdgtCYFQsOdReXQcwJcAAzrw8QQ=
Received: from MWHPR14CA0054.namprd14.prod.outlook.com (2603:10b6:300:81::16)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Fri, 12 Nov
 2021 00:56:01 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::f1) by MWHPR14CA0054.outlook.office365.com
 (2603:10b6:300:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 12 Nov 2021 00:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:58 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:54 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: 3.2.162
Date: Fri, 12 Nov 2021 08:54:37 +0800
Message-ID: <20211112005438.5505-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0917ef23-ea1c-49f0-c50a-08d9a577316b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4200:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42000295E00871383067CB8DFC959@CH2PR12MB4200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OakHUBp5pnrAxUZzw4SOsQQPHvmRXDk96gvZA1ahsf0PzUBO93bFujnVDFNr75mfXwG81zXB4JnkFOCPmQ1OzSD7TA5zuNRgydpesecb0ew1suDAoHLHt36xQvHTKanihVC8orxuJpTC3cfVQiMYzWpAnwuW4smMWP4k6as1nCmpSyyTJ3/tAhBeclWRDQUivU1p2CAUXlhM2OGMyQL21/VVnrppV4/uV8RmTXCzpDvyBSSfOfmhO6mdCYRN9EZG+e40Kd1JdPdhZRvsKrnhNXi9PlRrnph3HabSCyG4mecMxdDT7BJnXH4BSoFw2cMb/JOAbmS9l/CBtkxhxpx/3yURG7h4iW9rxfb3mXlqWFTw7QlsoOOYHMmOnpiHh8yfoblGuV6qELXxf+HoixK4GLRusS0JysGBIAXPVb30k9QYSERlenX0rIgQ3kelTxvLNkY6wKwSaAMsCnZVHxOHygkgWkCcXuBOj/JaUyPYF0q0IqtraTX36GyvCsC+54iQfkFFrbcpHhWrtNy25rw382hq+/RzGma30nbZGy4p4J1c41V8rKkKJK/dszpVygKtgDlfQy3bMU0YQvFXwldutgD1kHoG/zShNq7ua/ofZk5WHkcTz1d7Shi5T7DIFywcu0zCoRsDu5VulVcqSV1mORUUF5H9K795M9WqVjJxHuik/KNtk9U/ig/cm+KOnjl5ECoRcIO4hGXlIjHxgPo9vywMh3gUlSyz0BDcxJAO0tM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(7696005)(8936002)(83380400001)(336012)(356005)(6916009)(36756003)(82310400003)(81166007)(86362001)(1076003)(426003)(2616005)(47076005)(70206006)(508600001)(36860700001)(5660300002)(2906002)(54906003)(186003)(6666004)(70586007)(26005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:59.6934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0917ef23-ea1c-49f0-c50a-08d9a577316b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix issue that secondary display goes blank on Non DCN31.
- Adjust flushing data in DMCUB
- Revert patches which cause regression in hadnling MPO/Link encoder assignment
- Correct the setting within MSA of DP2.0
- Adjustment for DML isolation
- Fix FIFO erro in fast boot sequence
- Enable DSC over eDP
- Adjust the DSC power off sequence

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6b4c9e9705c0..a43583c6e90e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.161"
+#define DC_VER "3.2.162"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

