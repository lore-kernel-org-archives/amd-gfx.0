Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF2AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E0B10E6B1;
	Wed, 23 Mar 2022 11:49:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3261F89FA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLfZLGYyX8T14C7BXvex8y+4E5fLKPelRmw48FkVKdoD4W5C0CKCwd5fJRY/3cXFQ63PXRLo1i3gqYEWIiy6ZWSe4FAki4+g57g9kGitNRwpKvQi69K80Uid4fBGUmn4EpaoJ4L0RsN/b1zvBrThFfkpMcizj2omsfv6DHLcrE2CieSOm5vsWPEot4ByGqXFSQOkZJl9XcyKoYXryKax3kq2wtfIlIGa+gzM2YaxcDx7WzGRzrLE8ccxXPYS3QCkVjRuG1Spn0LQa9OsQQRzzdCjzalNMWHRU0OWE6vgjWx1KgrQSAPe8ExjcwS6XcB4fhq+eYIseiolBz0xUGIgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjfZKJ37M+VkKP9g276PUmMnjzA1fvki9q7RuOJ9aa0=;
 b=hOh0kBSLX8Kyvw0aRo9VsuDxzlJtZKklqoLvgrdOx25PX97wjK3ryYxIvbVe+WKhHiC1dYgb37DZHWbl0u/nyZ0rpuvZqNrWk80cPrTkaeK+tSWrQUFVuWP60aRtaWL0Pl9vgr8qP3TVKOL+ymvri0pWkUMwlh9UwjPx9o/38wBE2fE/IbmmAs9g/6RnX48obfdDi0QHp+jWJJNBwm2zqR7n7/5GUykW7FW44kgWUqyWhxnnTNfgE+MB+ZcVoEpn1FWumbRUdvQWqDSHYQVlJMQWqYtGM7zc2ikScMcsLMdl5exzQ267hH1DhiIGXvm7mlLoa6aORpLLz+IWBeImhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjfZKJ37M+VkKP9g276PUmMnjzA1fvki9q7RuOJ9aa0=;
 b=BBIcVUeVjneBp+2SGUdE6qObqMvHXntj5O1VzyJnZK9iZhEstVWHW5Nk3FkoIVVL88Ma6pR5G5l5fIHkAbTG2xE3E+a1VEK8g9pdx2v68Cheq5FDHabPZZH0s3FuK8quNQ4qD8dD4jrc7TYCfiNkwkwtBdRHmOaKIZDw8+raqwo=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 11:49:15 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ce) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:15 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:10 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] umr: Rename completion function
Date: Wed, 23 Mar 2022 07:48:38 -0400
Message-ID: <20220323114842.78516-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220323114842.78516-1-luben.tuikov@amd.com>
References: <20220323114842.78516-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaab3e0a-b28d-42a8-6d5a-08da0cc3281c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB260066B07436FBAEEE19D42499189@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbJ++YD2hD6rcEO1aPNhvwBCOarwXc4YS31OIDV0Vak5T/1YDmPDWR8COIpkLRuaCWDl1+vs32ejnupbFAfnHrmrGONcaldHJ+mCgyTkFzjKQayNnpPKCPrj0wZtvLzXl3NzuVhuSt9GNQ+TQrhWSQvueHfpFRAoOvwvG5vbYbMdPPziErA+3tNRDRJCRmg8svYlSNoq+JoXgJv1mUpBs3KxhJEFzO5mjYktLbW4s6ov8rq9UDsW5aq4TZ/zcb/k77/j8RIJ798kpCPPA3DMsbr4gQgnxie0Yp8InrRwTwZ1XKQ0CPYbD4+lzo8otjzK6PZgpZujifKOFIGyYA3PbsCInVKayAbRCsVAKpYyEYv5lLfWP6gg+gGUiPlGsh7dSXr27Nwzjy6rFLU6mZt0x6PxBd6cmuIMmjL7+SZbaGsLhULVKIPCR5wjL8Qe8DaitbFUDUEkgD2VbGWJosOkirTh8x+Ha7O/cjTflyMVEsrilwWpH80Mb+bo3HUn1AwiObr3IAVrxipsD24exSiVpTC5oBptuXZm/nbtuw2hEDHliQJLvVf7xowxwiuadABRuCksF1gksslxP4xmmfy6I6TZPylGN/IoshHT0m7SjHOWnsNHdc4XndSGrXyI0N7w8N0cXpkMMzFMwgMpYrN9QxX/Mk+q8yEhtqfaLykbh5M2BQpwrK4kxEU8sYNNC4X89l0o0OVxBcPvYCoX92r1hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(4744005)(44832011)(6666004)(6916009)(83380400001)(8936002)(2906002)(316002)(54906003)(26005)(16526019)(1076003)(186003)(2616005)(336012)(36756003)(426003)(86362001)(4326008)(508600001)(40460700003)(82310400004)(47076005)(36860700001)(8676002)(70206006)(70586007)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:15.6516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaab3e0a-b28d-42a8-6d5a-08da0cc3281c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom StDenis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename the completion function "_umr" to "_umr_completion" to fall in line
with similar completion functions from other packages.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 9cd1fe1e979fb5..79972949b9861e 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -60,7 +60,7 @@ _comp_regs()
     fi
 }
 
-_umr()
+_umr_completion()
 {
     local cur prev 
 
@@ -79,5 +79,5 @@ _umr()
             ;;
     esac
 }
-complete -F _umr umr
 
+complete -F _umr_completion umr
-- 
2.35.1.607.gf01e51a7cf

