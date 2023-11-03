Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F85C4167D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31E310E9D7;
	Fri,  3 Nov 2023 13:12:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A63E10E9CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3PFwKhjzIouC6dykPna9XBmgRzdVergqU42fQlUgdcq1X6NBKeIAJ9LP/Jp8qd08gE7PQP0X1OqtVRjUG35p8O+6rU00LTWDAFfVhW20mzDvDLVd3ZQ3gUduZKpyMbdWZhdiIv1FA//Qj1vlH5XqkMNmKKABYhW5z+6+2PqGwJOk50MUEMKo9vyg7Mb7hDiRAuK8PIymnzQaT3QjjHMEmlIfIOWa56a8L8zQjqit3LhipYxwYjbnB1UhskAF2DBKFzGhzm9y7RapLAldROCVcSKbGqXB1VPW6TlPTSmokedppmt4GCsy+yl0TDarQ0VfZxtQ5Lv5gLmDEOhzHTkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJQkEXwxkYHQFVpByrEXmBQkysmf/DFOg0sq+o2klG0=;
 b=T17cTiiO+ovOme7QBBzTemkEvKKq26BFc69C/lSsSW04V6yBSAuN7PqGPnPHWoUnlbMy85sQki/AV0M7UC9E81S3J+iM4cU8Lq77UCQUyUxfikiugKOoxYXCiBoMZQXuxL2ugaD06CEbPgM4ed9alM7FNQZ/KAlXxiJgxSMFq4NSgJfRewaYcUIeSLy4opv0valQXtFwhzE3y3Uhs5THrY06PaJXI23Qm6aMXBSVTHGxmAzXRpOGE0T+Y8c8BvRtvV+8Xq+PAYtyfLM5TZLcw9lW6f3YR7TnyY6mDDX+M+DdUKtn4jdgwF8Qk5wTR8rey/GKacEx5MalktNJ7OtEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJQkEXwxkYHQFVpByrEXmBQkysmf/DFOg0sq+o2klG0=;
 b=MOrdlLyBbwid9aHiHRHLDRGIUKLomhEo9cFODBEQVorMYvQTuQatyFLFOoBayzrGyCV51R+hamR+Zyd1CUyUU/KjC9Ojz5Ks6KHke7zSwWsH185E7auBthnH1xklK7m51FTuRO8jQJr8CMvfXFCtwEBe1N+QFaOGqzS+mgXMoMw=
Received: from DS7PR03CA0113.namprd03.prod.outlook.com (2603:10b6:5:3b7::28)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Fri, 3 Nov 2023 13:12:13 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::75) by DS7PR03CA0113.outlook.office365.com
 (2603:10b6:5:3b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:13 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:10 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/24] drm/amdkfd: bump kfd ioctl minor version for pc
 sampling availability
Date: Fri, 3 Nov 2023 09:11:39 -0400
Message-ID: <20231103131139.766920-25-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3cf402-8a40-4510-9fbe-08dbdc6e7ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Garxfz4k/uV5O4JbJHbyOF3Jk+TTchwLE9aW4w/GoTKMGB6vV9dyv0p/AY/uGVd5q7pFEhlnyk80EqauSgDLiVEIoc/RxsCpDkC0gbxZ/84djeVrciW12v6Tv40IW7qoGRowzQtFE7tLIVL99Ua3dSRrunyLMfBohPFgFVaUf2Ybz1wRDrslxqcp2HYm8sjmoxPmuBhRpjmIIW5ht47wdy9xhDFIkE1bijPJqYzqsnGsvT+475RFlHy4dQbdw3hkFyGRl0z7PM/wyfkNiA5KZ19y73RnbsrpB87VfVAs2T35C0bMv5hizogIT6Qw0x/meaVlZ239Dvzwk2R5jutz0dOX/HCs2/Qm+6+nFdtWxWNKvAcO90KCbeacT7XRuLxbFbO/KKklXLLKGKbuQ21LMgwt0iqHdQEmYELVLBe/5nlQXpbYnBsuRt8vZ4TEIMcXCWSxPyTO/gtx0HHxUFl8F+FDHGnb8Dd3lp3Vg/iuzqZm1knufJXGJirMJ1drLetDUBEO50FsbthwZuamnRRpSzDyH/89aHJdBbcHBZS4Z6nUYkx7HqvC2bOOdzoVp3+tUjsD354vdwysbiNdZc2gyalhZpKlGIWTm451qiVPP9bC4SC9i+WGCxIkHHgsm7xwNslwK2l6p38UMGJGAELfMG6Kbpl0dFJfxn/o2SPqlenlPD30o1JYZ0rgzhKUOwa1uHHvkTsWMtsRpFlUVJZa0EzH8sudDeETZdm//YIKRrg62PK3bfRx1gcHZVOmDopBTjYHhmPC6d6Kl/8xdaSpng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(336012)(426003)(54906003)(70206006)(70586007)(26005)(16526019)(86362001)(83380400001)(8936002)(8676002)(36756003)(40480700001)(4326008)(1076003)(6916009)(478600001)(7696005)(316002)(2616005)(6666004)(47076005)(4744005)(40460700003)(36860700001)(5660300002)(2906002)(41300700001)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:13.1547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3cf402-8a40-4510-9fbe-08dbdc6e7ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    Bump the minor version to declare pc sampling feature is now
    available.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 5202e29c9560..682ed27134af 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -40,9 +40,10 @@
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
+ * - 1.15 - Add PC Sampling ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 14
+#define KFD_IOCTL_MINOR_VERSION 15
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

