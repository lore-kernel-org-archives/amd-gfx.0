Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1562C001B2
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC2210E630;
	Tue,  7 Nov 2023 16:58:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F2610E046
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnm893pdq/LPbvgGj8uFtH7iG2VbaFuoAfJbdAOhMLDJzjUjw8hdnHiKvjgz0QhJSjcVKlyFQoxJoobzrCCMSv0IFKOfg0BwsxN1HyxrVLUUmZGVy8RYyiP1oPqUrayp2tMxCqQBrkj0XmmpSQn6j1ZFTFbhC4zm+cmzf7jDvPmcii4UxUg+taikkeaXQCh+9Qa7ck6tfwCLq6Tj6J9O49mmBqQzNPdlo6hzDoHJgUguu7xLPVpOuvxoY5qQhqi+U/csOKDeHVwTqTXdkida7Owsynu5AT0j3UPAzmIvEq6Z/YUbJERjUmCn/OaE6Ej8WQdvKg0cAR1zT4zX52xlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq1H8WCJuAL37SctBUPuPK3Kqv6ruPc+2YmbD5MHcdI=;
 b=gPuE3hY76xF5ucR5gBjxzAwMv8wcHx7q6PBo7keuy3XBTgAqN6AaVGTutz0GoucvfvCTQWkPOe1l2k9+VEXJ7K1KaauuZRCNIq9jRzZordu5HFFz1aDSHEOATSmFnkD57bZhXrENtMhtK4xxiOyObq4ONHNixOYQPho4QNGoLptP/JUxr7xAqugu3cSQh1whKrROGlzkgcZ3SSJTSRtbcw+L1iOLUEuKPob1XOOBWc59FMUDxBZa9YOO0pZynmTp3JsdX4KG3+jjDeq8czpfvKUC+NnrHe3llHkUzIZOtl1fvumQX2KEIzoZZ/jEZsoNJPQHqODX7n7ysmr5Vj0J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq1H8WCJuAL37SctBUPuPK3Kqv6ruPc+2YmbD5MHcdI=;
 b=D319fHGTOuSk4DtebeOjqUYw56U9eXZ8EiqOGCtbDR7VtUw3EDvbIEFqdO47yPJVAv1CxQClaNwuWXI6h+DZz7c9zGueyLKlwWF4JdxKWcaQiQgY7UGNWkGA7QpPBxiY5OSTVG/UmM7vpLTzpOJwUfGHKAnzHDTf4Bkhm/+4+rw=
Received: from CH2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:610:4f::22)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 16:58:36 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::98) by CH2PR18CA0012.outlook.office365.com
 (2603:10b6:610:4f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 16:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:58:36 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 10:58:33 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdkfd: Bump KFD ioctl version
Date: Tue, 7 Nov 2023 11:58:14 -0500
Message-ID: <20231107165814.3628510-6-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efcc27b-2533-4cf4-c41f-08dbdfb2c87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pn/YII35N5K4YiEpjkh5Hp+qWIa7dj7Nk/KznMd/CtLstXhA6cxXUTrxoHKAQeXWjcfkbnn0tAGGXYLs5pvfrf9f2aVUAEujwMallvtaP688lMBke/rc7h8SgmYz9yEFKu4VZ43kVBsAj65/oSJFN2ij85mq4Cw4KlCH2+mmElgt428qGQ72wQthOlTWQ56xbLIu6Lpuf0WIXgys0DuCIacL8rxygVArowPrHQMtplBTuwxw+poIDLVxpjfojH7UhZOQJTvvAk7YP3l5PwvrMkyxKH+uLbR3kkOw1mV/nE98gvLghGv6BrYEKH1T5VXtHfgwzb47Piv7bmdvU8fjiNDDaCP38sAYe2WWlnb9HkltY3V5i1bZPtHbx6Z267Qh+1e3qCWESSpuWbvKt6pW+Oq1rJ6dJm1ODALEcLzU1b8wXsACoE/gVYe00/4PxKamnrLoioosYc8BH+oS6qUyZJ+vQakuCqU1cWHnBtJ2n4NDHQC8cITrDLRnOZ5r9JKosxINzBmVBdA4KjL61L+jJ4zHt1r92+hjfwIt/xniMHUtYUweWuJy8zPQdoTmWHDj/xOQGysN29LQnv+6TXWO0YV0LgUFlzA6SQLcufJXOKV+eLmFPbIiKbAfORlX1jF1feZsic6z/e25q2lZIpbiYoguH60rgkbHyotmEHtXyGS2qK2ymfdeZYzd3fCV6aiuDgNVrVJiAuqPmgtuVwg4T925AVXQ1c3aCZ70n/P6mp3Sh2qouILG4JO2a168pS81N+CNyIRPgjxxF3MiTOECtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(426003)(81166007)(336012)(83380400001)(2616005)(82740400003)(16526019)(26005)(6666004)(54906003)(316002)(478600001)(6916009)(70586007)(70206006)(8676002)(8936002)(36756003)(4326008)(36860700001)(4744005)(2906002)(7696005)(41300700001)(86362001)(5660300002)(1076003)(356005)(40480700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:58:36.0790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efcc27b-2533-4cf4-c41f-08dbdfb2c87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not strictly a change in the IOCTL API. This version bump is meant
to indicate to user mode the presence of a number of changes and fixes
that enable the management of VA mappings in compute VMs using the GEM_VA
ioctl for DMABufs exported from KFD.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..9ce46edc62a5 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -40,9 +40,10 @@
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
+ * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 14
+#define KFD_IOCTL_MINOR_VERSION 15
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.34.1

