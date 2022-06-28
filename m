Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AB9CCA479
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F3210EB27;
	Tue, 28 Jun 2022 21:44:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC63210E822
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHx0GYXH1L4XFF/dppjW5+ifXqdg5a+aDjcg7DNK/p6qXmNun22Zz1uB5nTDoc4GeFycOnLCsZke74J7XJ91geKf7A0jVzJOjiK77LkYcrOEZJo4EQO7/P1cIK6Cd88V2UyH131Sl8RDuCIj8mHKPPeMfTMVlApNhkhWuAM5NJVatqJaiaJdtdC6V9H6wtyPkAtnB/S1JxhUf3RilxaNlOXBH75LMGlEqNG+R+5PUBRe2JcYVs2MshTod4VQTtkMSX8ObTt5glzPTCi+IGCRhKbYYmVBA83YZcQqXsoGya8Gn//3/+ypUKg/7hmUHnbV5OXAaJO0N3p9qNb5+krQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2E4VHLOwoRjyqFTigS/uCiChkc55IwAWyPda6pB544=;
 b=gxM2Q10admLOIiqj46Rgg9vev8G1upMpxTVybwnMd8nHoJukf9mgKrbn8VuLXwXucqaZqcJIksEbwmD/ROTCROhDZOZdvlt7tUYX9ZP/NW9ytzcWRkl0x5xaaFEdQ0jOVcUnK2T5S31KKZGNzm+ocKghOJ1klhlFa5AZKoeH9zLTpVEVDeW7XsmeZ7Y3KXXwuf/bMr8jipmobMubFyGdmz6u4MXqErJ6C/5lWfEiBoA4j+r57lezUZyjrK6olWnojNsjfxFdOw5SLzOlQ1dMWaRgSrNoIQlJA0PWvIzsKdWmWJN/VTJ2wWXsLXTeeB/45oTR74kmBNjbOQM0wmI1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2E4VHLOwoRjyqFTigS/uCiChkc55IwAWyPda6pB544=;
 b=bKDXHog0IKLVkMujfALHGDh8fq1249pSsV6iy8RFTG8SP5t1EzHcgayMjOW2sLmIOhsVa1WiFDOuT4G4Q94YN5dYs4Jaa3/oNrq1dySlL8T/7JnwHeypeN5vfuc2NSWMLSlVXRsEbD02Qg3XsdyEm3f+L6tgD/9de7WXq23dExM=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by CH2PR12MB4021.namprd12.prod.outlook.com (2603:10b6:610:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 21:44:08 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::cc) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 21:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:44:06 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:44:00 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Unified memory for CWSR save restore area
Date: Tue, 28 Jun 2022 17:43:11 -0400
Message-ID: <20220628214315.235160-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75d6756-ea4c-41c9-78a6-08da594f53e4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4021:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jjcj9/6m9eYbm6nCg0x3s49yz4YfVB0Sc3fMmAue3wAqcEIUf4x1viAbqzgPw5iHIB+Gi3KAz60Enh6J8/Scb+5ZpaS86wlXpKH7OCe6aRjajlKvglzEXXL3Re4lS64KttPOTCDNP3wy39zyn9a4/q8XKCkXzTaM4/g42QzHNJ+zn1vwmuMGhJClC/ARoXPZFIvwRXO/W5Ivmv6GcZWYU/Ut3k+J47fB3XorE3f+kXqbt/Bl3RIfdXHPl9Pq8xU8fRuVRfJ7lUSIJrWaF4OCxddVle8Blw5gUCg7JQrEyf6giLQsepg8epc6I4ukja7AF6AAHiFcZZ2153LtxSNhKGTRN8cqWboTA+niTTmE3h+cqi2oTtada3Q+wyk3ZYTh+OiFHVKs4d/FI6h86QmAbCsnBGOLERah0xjrniXjAkgT10J52U/Tmafy1ujSpFCz+FohUSPh8vrlaiNYDshHj2CAOPzJbrTZjKj9s+muTJZ6GCsbR7jwUgzaOI+iP4E6lkQwpg9EdDW7g5Z/t7MMTqy/HA+qwlQcjnGU55YQ5UlnSO/96v0lxMCpRAtsyLQkxMBOSuA5Jq9soC2Ddba8qZK7EN9dz4R/iBGkYVEvOuqM2fJFkTj3BjdjeePC6JdcciE74vYkBd+weHUI+nUR2euDkNrnObz2yCVGiOePFqj2xehnKtpHSvcXOC16afO5OsBjiY1TZOxbcHzZUlNIJwzEKIA32QbfZW9m7Ceqc4dpKNuroVDy1r/fnM1h1gVwpNp6HRqe/g3r2awrz6WNuje1O+hRNn/SS412JeznJVccuVcr6jhkqewzTF148ZVqGuK4WMdEeIhdR/9rNYjmrEQqtyJwo7Q+qAokOddzKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(4744005)(4326008)(8676002)(8936002)(5660300002)(82310400005)(2906002)(40480700001)(40460700003)(70206006)(70586007)(36860700001)(83380400001)(63370400001)(86362001)(36756003)(356005)(82740400003)(63350400001)(966005)(81166007)(478600001)(1076003)(316002)(54906003)(41300700001)(6916009)(186003)(336012)(47076005)(426003)(16526019)(2616005)(7696005)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:44:06.9867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75d6756-ea4c-41c9-78a6-08da594f53e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4021
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdkfd changes:

Eric Huang (2):
  drm/amdkfd: add new flag for svm
  drm/amdkfd: change svm range evict

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++++++--
 include/uapi/linux/kfd_ioctl.h       |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

libhsakmt(thunk) changes:
which are based on https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface

Eric Huang (2):
  libhsakmt: add new flags for svm
  libhsakmt: allocate unified memory for ctx save restore area

 include/hsakmttypes.h     |   1 +
 include/linux/kfd_ioctl.h |   2 +
 src/queues.c              | 109 +++++++++++++++++++++++++++++++++-----
 3 files changed, 98 insertions(+), 14 deletions(-)

-- 
2.25.1

