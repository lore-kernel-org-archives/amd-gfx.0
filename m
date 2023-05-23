Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD887C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 18:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7DC10E118;
	Tue, 23 May 2023 18:12:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C26D10E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 18:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7c7jsn7s4BuIUPcRbas/OsRr3b2srAXEK8836sIgiKpD4LA3XeLxTLwFqiGS32ErZtkfAL5Ju4KXUz+3GZrdwG0dCL+wF5cKSg170z3gT1Ra6yaxVjGZYCNl72P/mJ99IuVljfrdGyb1uc33k81qQX/huaxvRkt1xu30+kLAxfwTApMHCem13k6hmeSSrBHCl5MiTSVtYhDJxsu+i3TBHkhh4SxY1GTpQRC65fex23mspAGQp1WJHbzJfAHgRh695XidlOuRDGKzwou8C6cgo3/bU2kMKs9a9Dtw4Sc3BV2t2A++l8G/eN0ZPS1JRE/zPuhZPDrkgSSPWF7Z1htqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+7Z9t/le9KUkotB25n70KfaSAYj94WZf/r6giqzUXs=;
 b=PLYiWggyWU0g4+gl9SnVfJWXVjPTIp65gcF4PTJM+NGRdAqJs1CfslHEAJBzj3r0hVQDMngQh4sm0TBwrD/KzF32dqQzfYJPpWU5S1CNPLUSOK1GSubA545v1amc8bkynI/Hxn8t6UGVATNmrKzvrMSMmY6/Bhmno7/SJUy8YjVtL+59uGhnwDnmK1MA4VfAELcGKP4DlLLG9g4313tkRKQUVeg0RzoFEYIYWHbmK27nuoVsjr7xrrtW39GXe244woPwYbGGRe6PQLZ4G8qdCnx78SjTFd5gDwS3jZQFR8MNjUy6TEzk1K0FXufwFWCqVwr2jocKaiUz7l4wF8PQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+7Z9t/le9KUkotB25n70KfaSAYj94WZf/r6giqzUXs=;
 b=l2IbQXCuBGUSa8goAxWUIDv3yPiLzsoC73vMrkBgpI/miYzk+oPdIeh9UlpALtGwmrPn5WecG0Dl4+YgjY9rqbEih4mr+ujQs8PLFvfbFhTwT29TuNNbvfz1GRIyzif7Z5giYblM/m6wkCpq8DPyAIAY4PqmosY9ejBtwUccpKE=
Received: from MW4PR03CA0211.namprd03.prod.outlook.com (2603:10b6:303:b9::6)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 18:12:31 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::7a) by MW4PR03CA0211.outlook.office365.com
 (2603:10b6:303:b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 18:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 18:12:30 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 13:12:28 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Set event interrupt class for GFX 9.4.3
Date: Tue, 23 May 2023 14:12:12 -0400
Message-ID: <20230523181212.697303-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cecbf5-1675-4ecf-36d1-08db5bb94630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yrBhn3FStzjXZEA+7ZeW9q7xxjlUd1phtuvVTfTxhUoNKIHRMZYOmJtv13t1up3NX6FGV+sXG97Gxi7mkRSel2+P9O8rx0xj/ueCJZU/G2nyHpCxymdWPs1y+1eSzbU4+fodTqk3SZ0Mlr1QLMebLOSENEMaeOSobFXnxnbDwh+CJLtTmETgHDOoMDEiUrmYcxn9Qo0kP71in3cUekkxIhBV5uvrzO0t/uE9teqXa8Yd4XBbvt+A39gA2fPAQ6NBavJVtF2S842zpOI0SvWu/FvbGArXkW09wrF/vQcnhXxEhJY88cfG3zsSyXmiAwizIDjbrCBgr1G6SePFt/zRxko5QQB04WGEASgfw9WUJcagIsNucIVRvhk9/2CdStiwt3eEAUCwDEpjxVnOE7neuvS8hhFvHJSB7VmZ7tqZxEAF1PQRrFbYU6+/C8Ba5q+vgCYP4Bptnu7d71ErEsRYU/WxdVKnrsNWmyX0FGdP0N0xzJhumkcqMHdmDBOVd4UovLrpQ8vEs6hhW2faLh5TX9KLr+2A8cd9xQzvUlPqS1NdJT1f1KD5xuNHLvx/IwNvnfALOXowEhzwwm3djcu5+H+w1wquiyM8B6a6gqgEdvgbUL086CzuIQtwjzWU9HqpkuUvpv/oTcIn7+2K3Y0HwVbwGHD8YswsawB6N6c2KTww9G1RYFmP//gNHDQJ83tQyp7aWEDZpjIiW68BU3v+QJW5KXcjifSVeYNYe7YvSY4fKRbsV+GXLGFtvqxOTbBF5XtECH9Q5tt1FNHfbAHaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(82310400005)(4326008)(70586007)(6916009)(70206006)(478600001)(7696005)(41300700001)(54906003)(6666004)(316002)(5660300002)(8676002)(8936002)(44832011)(1076003)(26005)(356005)(40460700003)(186003)(16526019)(81166007)(82740400003)(426003)(83380400001)(40480700001)(2906002)(4744005)(2616005)(36756003)(336012)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 18:12:30.6293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cecbf5-1675-4ecf-36d1-08db5bb94630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
Cc: alexander.deucher@amd.com, Mukul Joshi <mukul.joshi@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning during driver load because the event
interrupt class is not set for GFX9.4.3.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e92b93b2c14c..862a50f7b490 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -139,6 +139,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(9, 4, 0): /* VEGA20 */
 	case IP_VERSION(9, 4, 1): /* ARCTURUS */
 	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
+	case IP_VERSION(9, 4, 3): /* GC 9.4.3 */
 	case IP_VERSION(10, 3, 1): /* VANGOGH */
 	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
 	case IP_VERSION(10, 3, 6): /* GC 10.3.6 */
-- 
2.35.1

