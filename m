Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08331C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 00:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156D110E4A6;
	Thu, 10 Mar 2022 00:42:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359AB10E2F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 00:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxI/RjJMkPvh7i5pyOxOyZd7tN/qSW8nZt9Wo6cOPDCozHsYBNf48W6G813Mt6F1QauoDJdPC4Rvo3Al+YA4n61Vz0PbxKtF/YJeOb//M7lHbc6LVeYn6Hseunt2k1CyQsqvvCrl5cF6Gz/Q+WH2jvbOR8ScyHOxQuGbkP3T59/bzdrgfMa/+ynD6qup7mlJbFh9lFZtqk5LY8uTOe4BmC7yb/jKGw7fYMPBQKwWciMGkFzrOiUtmIhRsQrnQ5YeuuYKpDvL6k380JbnMT0GlVxhf+FH+o104cnH3NHJ2toMOCcgwb+5mbSx7AsGh7DIoRYvcT1APc4Fj9rsRSujLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBEBEiHJi2rKBEl9ZWGiv6BPIp96lhrt3W7GlAIj2b0=;
 b=kdDW7m32RA1uki09i4ZY3ayim1c29dWBC5SHu/hv+Otrx2rAVCkpUijRqvYk2BoKBuiDbFKzB3IdP2BdGSDP8zsjIXBSxquF4J2SYhq1bxSLs73sOsBGaF7JaV+fvOuMbd7tw93Fp/GH/vDrAFHCkdHBjO6S5BxDDjMNGIc2FdjK0FsJc20eYbhvMmhh4DwxFqG1LDC3Hc3kta9po1yGfvQTBm4/RFsenPPZpwy2ThekAgPBUPgG4MgyeM7eLCyvm1JKg5kxTQgcZDrVOFwM4q1ZfeSUKLRuEfds1pIlKJS0QcVlbvB+vQVuT02fcHtEA2Xnjlq4w4c8Dmo0u0VrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBEBEiHJi2rKBEl9ZWGiv6BPIp96lhrt3W7GlAIj2b0=;
 b=jlWd8fAPVDQ2/suuyF++rRY8dpt4Z+Fliun7VrS5Fs2xdarXGkYudq+PLGhWRDeRU3Lt/HXCuePLNTZWHlaac4HEIVo517ba+eZIuwRw99frXTD5LFbjztePBprRTKb4K9Th2sTofmEO2a7Cwp0/VvkH1ZH1OT1+DfGKXQ/nb3s=
Received: from CO2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:102:2::26)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 00:42:55 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::75) by CO2PR05CA0058.outlook.office365.com
 (2603:10b6:102:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.19 via Frontend
 Transport; Thu, 10 Mar 2022 00:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 00:42:54 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 18:42:50 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] umr: Fix unhandled enumeration value in switch
Date: Wed, 9 Mar 2022 19:42:26 -0500
Message-ID: <20220310004226.50895-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
In-Reply-To: <20220310004226.50895-1-luben.tuikov@amd.com>
References: <20220310004226.50895-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfd17cea-8926-4623-3b6a-08da022ee9f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4453:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB445373D8BD4EBEE044FDB298990B9@MN2PR12MB4453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ma40VrXweBcazZ7m+sAamIP6Z/UXf+Okaeezw7VabMLo7b482FQJlndYjEAwEX5PiKTLHZoUNzgT2TWarTHBWYQzSlvp6ojA4lnw7/YkNvOc3sbGAUtwlRm2wv+4BuTTBAbTtjiF5ahZnBuWOCBsqINGJTA6UBW0RhswvK3Wbtl0ciH9bHEmhwLSqVfbIbdahk0MTgV5EdFfRkUl8vEHvKvGszIvwvwIhaRLIbqx5sO/h71omGP16LYJABHLKPbg1UOsm68sGs7sPTPZTmDIAa6WLlyYPIOMz3XCOcnXDLkO19B1+KP2c5LiM+yaAnUPfk8N9rftqjChZ5BCCGowO2NgOsH0Vt4CaLOraRCXAFT4mre+5LVL2ZW1E/ZCB1azs4eXTJNfl71BAuhLq/posT9+vI2lW8VYbt3UHM/PTWheWhjSIEfXwHblSoo1xTRS0LB8G/m6IfAsGfMOl2bB8mJcOjFlKmFH2U/QfPp7anQpdbDU4ARBgZJr8rg/5P+vEzTUhyJys2mTn/s8+BOvz4fKTU4FAYtvKYnm+5CbNx28uIyoc8kwYDTnQQTZC6Wt4zj1O3311cMzNlI4YGht/ayw12/5AkeHAnQr3EUe7XJLozmCqnqYq4w4Yb8udN8jF/UZvxeBzpC3mb+7rBXahqJs0qZmWbdv/GTKbXJE+aioUFj9W0z3lhOlUhwmV4xTkjfEpJM+9BrWkTBfxsYKVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(70206006)(4326008)(8676002)(44832011)(5660300002)(8936002)(83380400001)(1076003)(336012)(186003)(16526019)(70586007)(2906002)(426003)(2616005)(316002)(54906003)(6916009)(26005)(36756003)(40460700003)(47076005)(81166007)(82310400004)(356005)(86362001)(36860700001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:42:54.1189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd17cea-8926-4623-3b6a-08da022ee9f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a default case in the switch, instead of the last unhandled value,
FAMILY_CONFIGURE. This solves the case when in the future other families
are not handled--they'll all fall into the default case.

Also, in the diagnostic print, print the value of the unhandled
enumeration--this could help debug easily, as opposed to having to
reproduce the issue locally.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/lib/ih_decode_vectors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/ih_decode_vectors.c b/src/lib/ih_decode_vectors.c
index ed5705059c542f..f2057df825f5c0 100644
--- a/src/lib/ih_decode_vectors.c
+++ b/src/lib/ih_decode_vectors.c
@@ -77,11 +77,11 @@ int umr_ih_decode_vectors(struct umr_asic *asic, struct umr_ih_decode_ui *ui, ui
 		}
 		return off / 8;
 
-	case FAMILY_CONFIGURE:
 	case FAMILY_SI:
 	case FAMILY_CIK:
 	case FAMILY_NPI:
-		asic->err_msg("[BUG]: unhandled family case in umr_ih_decode_vectors()\n");
+	default:
+		asic->err_msg("[BUG]: unhandled family case:%d in umr_ih_decode_vectors()\n", asic->family);
 		return -1;
 	}
 	return 0;
-- 
2.35.1.291.gdab1b7905d

