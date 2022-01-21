Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C369FC4167D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194A110E923;
	Fri, 21 Jan 2022 07:45:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6BC10E94B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGjB1tNbVsqDRyUPIyTg+Ny92b8POLM4f3z188d66BgdhU2EElcylK4i8aynC7/grMLyoNu9BqPK/uIoiyAtf7u06ZI1SuAJjmIkyQFKovfuBJIbb7ANqVfRhUbIUpZ3wXhfMYdil8dHaiW9YHjxXso1P3kiGo42Axy2/8jLCYn1Y0kchA94bJCN1tpA2i3QXvxmQrkXMvaKmncxG7I5imV6PnHmAp/Xgz1WAKHlSTX3vS5tdj2RcpVcxrRw88YvLEt2SUy03zBoXMmZo+RuOf/Of6/J9qYzLPGjvlt7vd/gcPUp+s3ADbGh+ash2MhK1IypHMeEh5r5Jyav6frs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0MnovD/1zK+tgG2blmaeYS1X+0uZxfPdJoRLOy5nc0=;
 b=aG2tQ41xJHreB64nfjCQvPwrvaeqLc0D2pZRvjopCczHAAgqTN95B5KkrtgAonI4f3/2L1tP6j/p4zFZaSWGPQH/0Yc58bFBalnIGWzDByqbJgao5YHmlYwf1XGqN2DQp5ovIJdzch5QRwET+VwPNKafMrpdIwdikmSPshTcZO3cFbk4Dfos2tuBE2sFWUE4lsA2Mg5WrQFRhx+No6FTYHKWUZP+rXOaiTJ+u07XrVt/BTuGt9skSZecklIzeMQbG80WbsOwEWeOyB44Mzj7QSIYbhrtGrdOjblJr1W/byGEZ4gNvFx2tyo16TJ1MoceQ2MFlycWxP9wdJWj8uKCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0MnovD/1zK+tgG2blmaeYS1X+0uZxfPdJoRLOy5nc0=;
 b=DzxGG1ekRKscN8RJCPbTf/StveZTP5I0XgxMqqRzwdSLdo5B7pC7zSyqB2azhx5CJFZ3ctV+3Lp9zpMLxoidrKLiERfQh3MrT8sR0qjQwJGAMqYMI//HixwVK1B0rIoM+lnF5JPbUaweScbx27US0xBc+PcIn3xlU/C0tcmhZ5I=
Received: from MWHPR19CA0011.namprd19.prod.outlook.com (2603:10b6:300:d4::21)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 07:45:18 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::b8) by MWHPR19CA0011.outlook.office365.com
 (2603:10b6:300:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:18 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:15 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd/pm: avoid consecutive retrieving for enabled
 ppfeatures
Date: Fri, 21 Jan 2022 15:44:42 +0800
Message-ID: <20220121074443.639392-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121074443.639392-1-evan.quan@amd.com>
References: <20220121074443.639392-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc446e59-216e-465c-6384-08d9dcb1f86d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2790BF2B4F81F82642EB3693E45B9@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysJAYHeeXaYOjafwxtSgj9uSYUjEWQ4LtuZFDn/gI9z0wtPTA/9fNGiK3c2LNib6ut7KVprwHsnhDMaeTXiFz5GMFQqpF6xK1q5v8Yaoa7TUig3IJ1cK42Qd0reNfC4D5LKF82ZLbyEqo6RENIvLWpY7iBv2wD2ksF2CxjkddBETY89pSwQGNH6k0daTxzzqOEP5UuIQ2abBxfJH0hip9d5yIPeZIYRVGOQ9OGVv9SHhEzNQ7go84w/rZXIglENTs8dV8sLQPMWV4Vm2XuXnZo5epB6gxw5J/xY/GOQb9XmzU+SdappL634QVMAO8sXSm9w32I7U5wrGNbQQteyF32qusIMK/KsR3wle+X92ddNpwTSFVRFHdgdSt8uxfA68Iiys5QJl+LRj+V2uqBboolbaXidu83CAe1RFvPSoT01kUw7fuRropObQ6fLJbsF91S9US/HOdbf5X2eO3YnPhfLyOI2W2fkrfKLxA/Kr1buG5UIlTwKevZXv1JPopFPQZ72VCkRe8JGMiqqcsD2VCYShD7iPox6ptAyPwvc8mMD0dqLT6pcEFWUpi67V+pDxKpTHg2oxU1OYfnAiBkR9DmmdFtVnRvpVQIlAzgs/IhAsENFdEoJRiqhWK8KjhMJabC3idYVyoUGe77cYZLSinpe0vpAyzf8IRLID/jQb3n1vQAACY0XaX5gBJu8Jldez22fqt/oJend4jCIABp1I+TlPBx0VpQm0kl0Kffgu1Tz1zFCmrMq9Qnq/HjSRCm+s7m9sfte/uxAgREZDk/8KP5lCQeu7NtBa3lonAPmIlgNPdfaT97ykMEo2IhnHHn+Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(16526019)(4326008)(186003)(36756003)(8676002)(6916009)(86362001)(83380400001)(40460700001)(54906003)(44832011)(316002)(26005)(1076003)(36860700001)(6666004)(356005)(82310400004)(2906002)(7696005)(47076005)(70586007)(70206006)(8936002)(81166007)(508600001)(2616005)(336012)(5660300002)(426003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:18.3157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc446e59-216e-465c-6384-08d9dcb1f86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the enabled ppfeatures are just retrieved ahead. We can use
that directly instead of retrieving again and again.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I08827437fcbbc52084418c8ca6a90cfa503306a9
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 905d6ddd7479..e54c59f3e8c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -661,6 +661,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	int8_t sort_feature[SMU_FEATURE_COUNT];
 	size_t size = 0;
 	int ret = 0, i;
+	int feature_id;
 
 	ret = smu_cmn_get_enabled_mask(smu,
 				       &feature_mask);
@@ -689,11 +690,18 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 		if (sort_feature[i] < 0)
 			continue;
 
+		/* convert to asic spcific feature ID */
+		feature_id = smu_cmn_to_asic_specific_index(smu,
+							    CMN2ASIC_MAPPING_FEATURE,
+							    sort_feature[i]);
+		if (feature_id < 0)
+			continue;
+
 		size += sysfs_emit_at(buf, size, "%02d. %-20s (%2d) : %s\n",
 				count++,
 				smu_get_feature_name(smu, sort_feature[i]),
 				i,
-				!!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
+				!!test_bit(feature_id, (unsigned long *)&feature_mask) ?
 				"enabled" : "disabled");
 	}
 
-- 
2.29.0

