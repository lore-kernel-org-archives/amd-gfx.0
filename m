Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CBBC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jun 2022 16:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C887610E124;
	Fri, 24 Jun 2022 16:03:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7F710E124
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jun 2022 16:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYt+N9JZE0HzpfT/7perxq/cY0geeAU76JsJlZ+S9ZYCrZ7iFIwzrRkXZ4zR9KR8h5OWZiN2qElV+Cf9v44JOQsWl8BLStNFxhqzDE++sqf1ZTGHAeud9sDEnCxObKlAdb8J36WZX4o93igtwNinZ3ydyrmm97SspF3iA/zN5vWV5748MdgQlhQVpelTuNsNIBTTJwDmC/Q/WOnTox1u7JJ5h3ouysUu3W36j7tsHuB1hkYjGg564VD44dWzz+h58Yahw4ViFN49ePG+yGqtCC8s9IcAim1umfPQzWowNXKOoZ7rEvLSEgxgiu6tdpgGH/Nf+8fA8vQFXYt7ga40gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq2fPa06TceYEPjX5vrIE6VhJymY24Brox6evupoCNw=;
 b=Rm3VqSHVl1erNjHvctFCRVLewXs8v/GmzT0FG4Pp9tfAUue5iLQbwOPLqoV4icD/AKFFcCnSnT+e/tEkO28lhpAw2qC2hAMglU56aqLjsY+zyH0TLgNgJ4ju9mmjUt10g65CN+mrpsevjtkwvnweMS1fW7nExsNoZf1Bw6P7rGkPwo4dXGlyuU5u97aO/wr8J84Hl5tLPCHSFx6VXICJGUpMkN0RASjT3EsQ25W/kumwFyGRAeDOGziMiAzCc/FpUtW+GBRgLXFA5s/0UKTpKQ0PBRDHrPFfUTnr3VIr9ODxCh6MobqICvp5mBOtRto+UoVMb1NU7El6ekkEccDCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq2fPa06TceYEPjX5vrIE6VhJymY24Brox6evupoCNw=;
 b=ZkX3smj4DZ0KjuaiHqV4v/7J/NCAVDmuKHe1M0o0Re4/uwnyrngdHPTG+Q0PBe3IGjTzb7jc8rM0XI28XMi+lwjQvaiPMdaf3/cMOz4V7tM5cqaTGkTqfqjVVnZc+gps1UUiPYH0dnnMIFUrIiQqoDsUw1cAtVAb/tfukczGan8=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 16:03:08 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::21) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Fri, 24 Jun 2022 16:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 16:03:08 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 24 Jun 2022 11:03:07 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: add new flags for svm
Date: Fri, 24 Jun 2022 12:02:41 -0400
Message-ID: <20220624160243.83693-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72a566b6-ad5a-4bd7-1fb8-08da55fb080e
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJkbFPQuswtMA857X7K7UuGc96nrlrOHQSO8yGmWQuW9lpCYRRI5Lev/YFU0BtbrPwV9B10W6smobn1rH/MnOpDBxrWDHZpapKjd2jvAjNHy1yjP7ImEx6A7DcAR8hmVKghUkVwzHeafenCbUQTwSgv488Zvx8VV30v0U43pjsupd8einxo7iHNbYGh/jIdx9PmafiHUnKphn+gPJ40BfjhLr/7XJd3TS6RAMDN1XYoqtAEXbkdDDMsBliw7J3ojUzRixSvACZT1Rh+tTQf6KMF9lxoL86QHuPUguzvzo+PGgvCQt0+3yKCC+y2Da0rdlBmRoW06cLmy7NmcimF6OjrHCidYF8AIpY5yQhFRq5qAIN+JH/mwED2Oiu/QgZ5V2ju3Zbsl6jcJzZ9d5X5iB3Mpzgk4ovu84RDktVlLKer8sJBNW84mTl/DTWWkP1iObJKwNfDK3HYWXttxNnVkReKPZF5uB6n5jbdV+RM8RSaDgf9tstK4FaZqOSdIMwUXrr9csGYWwWg4NEsuC6dj01EjEUpd/Mv8fHsVhoGjusYAacF961VEm3p3z4MmKeh3J1KLnBK2Qr2QxYAvoUE3d7I/WAytFfy97Mmfjg0DmVF5lYCOOok5wLKEVOQgbnqYfA6vDfCgctISBHUHFKxl2FjarAXAPaO9lInxyF1CT9Kwyeq0oGoB4eLSytdN00j8Nol7gee4LfdLIjg7lN5UuLlm9oAdByagKrMDLc2o+GdAiwi3ak0GWX7tJ67C4DQ6g1K+spdCF4aTm3zt07MU/pyFS4XhdynZ4hCSUEUufmwj1QeYrXiTzg8ZGIMHFIAhyD8F+CPPBiK91ZgXXsZE5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(186003)(16526019)(81166007)(82310400005)(7696005)(70206006)(478600001)(26005)(1076003)(4326008)(8936002)(8676002)(5660300002)(2616005)(2906002)(40480700001)(70586007)(6666004)(426003)(6916009)(86362001)(54906003)(356005)(316002)(47076005)(336012)(36860700001)(82740400003)(4744005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 16:03:08.5860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a566b6-ad5a-4bd7-1fb8-08da55fb080e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to add new options for always keeping gpu mapping
and custom of coarse grain allocation intead of fine
grain as default.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index fd49dde4d5f4..9dbf215675a0 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Allow set custom flags instead of defaults */
+#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

