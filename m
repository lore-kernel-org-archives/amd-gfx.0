Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447D3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 18:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE80F9086D;
	Mon, 11 Jul 2022 18:42:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08ED9086C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 18:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R31ParQpFWpl+xbYNQR/RH9GoIPEg5/Bn2DsY2TRRTk0dw21e5L9cX10Hbep4Bcu2gm9+YHirZd1COVV45MgKvQhYriWIwmCd66wL+d/Cj+8ku+rlV/VJ/n6lDw276FxH+3ptTZL6afcGUv5rdWB7JRdXdFKwP35Ah6nMo2YHgZleF036n6rOJ54h/vRCflgvPc7D21jOj2lGlt5cPdqMb4O1LGS0DQzGPncPXHhI/3HsPqB7GqYur6BBaFAVqdjsaM8R37xsoN3JXM3zkWFok2bBm09U6et8eoxXltOPtCvHg8dIvhQkrSFCXRPcVFh1hxXEAvNzypMPDBGsZmjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt07/a2a7WkZVwlySPV2WClO1r+4ocH2B6jxMjq5qZs=;
 b=RzkxlOQ97FMFSr33LW3M5MNPAFkt9qvTdQm+xYwPd/WbmeNa+lpDhFEeQuojC/s1+cRsk4q+alBUvUDfw8iWZ/Z5rqSraIKA05kaLWquyoESjat6ECmvk4zs8e8dQU9FYE44IrUgqsGsxmXY9zWsjjwA/kGF4QtlCxKkX0r0NqETZIm+C5eufG/30uN12NJO9BlmVaOeHJkb/TUbx9tX7gC1QBzSzXb6AmcVTccOJ7nASii3Kvs2ba9pYZFhVfECNbmtQoeEPEY81UgIgG71wVnTdAXOmVLZnOORmuSgnFcRlL0vF6ab0Hw58RTn2AU66ekYBZo/B591ueTUVZR3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt07/a2a7WkZVwlySPV2WClO1r+4ocH2B6jxMjq5qZs=;
 b=tGjiwuZR+J0Nb68wkmnBLdH/O2EXpBZRfFMCCiezGTyD6fMOQia+sphTE5i+AKajFolxLpZdo0jDl8fmsyLMdPc8wt9DjKO1yb4EotMO19Kix9s7FOPBwoiueljgNdLrgcjmfQ/ChvdPuiXMyHxTcoJPbeNuBVHZuhuK/3mixVM=
Received: from DM6PR04CA0014.namprd04.prod.outlook.com (2603:10b6:5:334::19)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 18:42:23 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::4a) by DM6PR04CA0014.outlook.office365.com
 (2603:10b6:5:334::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Mon, 11 Jul 2022 18:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 18:42:22 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 11 Jul 2022 13:42:21 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore
 memory
Date: Mon, 11 Jul 2022 14:41:51 -0400
Message-ID: <20220711184153.135021-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35c09e0-bd63-4012-514b-08da636d17f0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzQJhUwDXY4FU3vAMWImYHgYCa+1JNmViQyb5VhSKQSyraKVDbrADVQeuH8jgqKQYFYFWdpcYipnXAd0ljqJEfy7xEPZg1pSexKChcLFBEt7PCm2s2H6sZmtrFcEt8N9E8ul3yYReNeZbYRg7p1Tdlcj6YjC7McS/pJynCigoe+SGdKt5sH3xBsSztOgkBYITmJk3nU50Op7hAedDbdAlPnl3ee1+Ud7M0W9zTNxMvYZCKQigMYC+1IPifZLZK0baH9DRIpuwpUHJK7fKM/IvSBCIiq8s55uPn/G5qaGyU0iP4F6DPGqzbFU8iZ4yUbiAdhnjWumYev2HWum16wcYzG2lonYGX6C2PxKxNqlOinmaCtgZIpYzGceyj10pG2ge2suUFoH4z4c720WGAA3yu/bUeW+Baif4sGlrDl+w/JhZ4WBH5S5fCMmdPVomkyLgZdCe7fyM7ylW9BKv2KeBCNY0CuGRUh2c3Q9u81BA3ACqwNRjvKyPrOInYZmpHlknzMeNlJ92T4VFOCvUdAFx1cVJGWXVR4NmQWDtx+qoPY3eoQ6d9zPc5VaYlu8cHmfQdXYJaw/t7wiJkhSY0oCoNYSNIwQjdjA/Iu4N7WOM7WQgFfzhrpTI3FmbvpZhXnZzNxAeg4FXOREaqMHnylZey/Bhgn0bIcYE2JX3SJaFAHTaYMQ0LXirtXiSl4xGiiAkK/oygJP7IfUsxxAX8Xpa65nMrUqPA1durZvGu68llJv33zgG7ht5YQCdQWqxbtLfQ4KtPyApthn0cnPMzSzUt9mbyiRMRYc5vlX7Q8lt7dLgmdaOWQWfMrlw/QIyJK77agAbze0f83GXqrn5Ki8NVYU1+RcTZTV3L/cOVXdgH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(40470700004)(40460700003)(356005)(47076005)(86362001)(83380400001)(81166007)(36860700001)(82740400003)(8936002)(336012)(8676002)(36756003)(4326008)(70206006)(316002)(4744005)(426003)(5660300002)(40480700001)(7696005)(41300700001)(26005)(82310400005)(2616005)(1076003)(2906002)(70586007)(186003)(16526019)(54906003)(6916009)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 18:42:22.9619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35c09e0-bd63-4012-514b-08da636d17f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To expose unified memory for ctx save/resotre area feature
availablity to libhsakmt.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 7a423855a86e..afd8ff29c74f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -36,9 +36,10 @@
  * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
  * - 1.9 - Add available memory ioctl
  * - 1.10 - Add SMI profiler event log
+ * - 1.11 - Add unified memory for ctx save/restore area
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 10
+#define KFD_IOCTL_MINOR_VERSION 11
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

