Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D5CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED74F10E44E;
	Tue, 15 Feb 2022 21:23:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0BF10E42F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwPhHGPYKUI6vlTFCl/GqNQa8SDNCtKsvaJVAfAAv/gpP+jgWJWunBRG9Wrg6R3FhdgUCXjiJF3xc+frQILJkxLxY9ZRnjUuZqtolaUwa6VoH1CfhF6Ac/xZRypYHyK/jN10ePXfvPOr0ySSo73a1fyVKRn/twt2ZnWb0x9nCyyoT56TL+9Riv8hGn25+9CPyQEJJj3nuwRqBR9QEL2904pk+sl9rRJkvhzNkIPbrt+yrsqmDuH2MHpCsuXsWSjCaKr7cNTmAhVCA5xtSlG97q8mRgSwSJ1CKr1B7UU8S/nwl0XWA/WEOiN24MugflrrK+J0D0DT3WwW5Z5DOwBRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsPEi2001EMnCcC8RZ/J6HsgzkwwrF9pj1thl8NvMGo=;
 b=iLOHiUmKZkS5exeuQVSIkH7tA3JLjJqq3ZaNUC0QgscFE3985WFAgQee5kB9AL/C/JcCuKC2kkSuawZBpz2C3aWrNJTh380DNVpNNGbzvL42qaIiPthKLAkI3EUn9iz6UDehsGQQCbyV4eJNEywEucSyQ7AAoWGxtdIG2QdXWpOviJ0ujZV3t0y7NKMRP31GBvqQgxyF3QiOXDDKT7Zjy4s8JaVTJkHJdVhKinSDPqEBLbZzAS6QjuE73MYqdS6rzzYvDcj+gNZ+PTwdU/TR9lSDFYyzo4TUAkxwOGCT2GNfSlhgRAlOLrPi78Dj+r9hp3rKL7qhPzVPF/hR0iMYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsPEi2001EMnCcC8RZ/J6HsgzkwwrF9pj1thl8NvMGo=;
 b=QFGV35YVYGo1jmxv6QGk2F0Ez9A/Xw36sFV7jFpHC2dB1kEMNGuRlBbUMnFE+4C3PK4X3cQ0VRJiZHuL+7eEFVeGB9cCKQWBEKmGplroIC12pyNoHy+4yOwIyTwKciE/dBke0cVQdhSIT5VRZEbcbTuB/I8qu3N+IaXJr7y9IEI=
Received: from CO2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:104:2::17)
 by BN8PR12MB2978.namprd12.prod.outlook.com (2603:10b6:408:42::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 21:23:12 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::39) by CO2PR18CA0049.outlook.office365.com
 (2603:10b6:104:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.24 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 8/8] drm/amdkfd: Bump KFD API version for SMI profiling
 event
Date: Tue, 15 Feb 2022 16:22:47 -0500
Message-ID: <20220215212247.16228-9-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d1f6519-7399-47de-3946-08d9f0c95f42
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2978D3C251D7D66C759969D1E6349@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyGl6SBz2jtMd5KWdk+NDSmHTR98DTqAC945ahX5AuyKN9ZxUBch9/NI47gdZpqlFwPNCUVlJVz3ELJAh7BxlQWmT7eLI5D2dUYXuT3Gvdv8websaCV2m7Tm4I5z9MrZyRWwwf9IPbua421COd5QMJD4077/l3m2ldPOuDWMcKtnzGCAH5Rii/aOR9LTG0kqW7MhrdjLgbgQNTbD2/qq8lVHJ0DuFbDGJVfhSNPWMXycs6FUZ1U0e2RhaX+8sgAR0ELefkNNRatL2OK4SSw6Z+1asNDamOcE5wbhRuTUoiBl27ELhIcAqPy85yktlVGXKA6bwW8EtQjTXMSvRpJWVFVVHY8tXfveZvyPbsUTJ+GsAuCrHC3mESg146UsedXXF0g3VY0NBuaHkOMoephKpskBpWZn9Rmiyvo4UKu80BnQlE+g772UxOZmwDrpzWl20c9yR8iEyzgWJ/DAKtAgXOEPKZDF/jx+zPAhJRqjqMD22skwokvqROeH2GBQisrbngfk96vObclgFix1Y3VzxX7wtsZao8ss2N6qJsC7ulpnO53c2gy6fkvVjbURRrp3aDh4bQTEdYDfSLeYCZyKHkACbk2ejRsCacQ6R7fgT0u+59B2CW8IF9j6ARiRZdNqepu9IpGLq3GVhd+jBHsRxN0pPYVYlx0Sdm7Fi3fis5laVh/GdH3/bRrYdYqoYJNBesicsRNJjdQjHqY1QQbsAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(186003)(86362001)(6916009)(16526019)(36860700001)(2906002)(40460700003)(36756003)(2616005)(54906003)(336012)(426003)(508600001)(47076005)(6666004)(4744005)(1076003)(5660300002)(316002)(83380400001)(8676002)(356005)(81166007)(8936002)(4326008)(7696005)(82310400004)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:12.5497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1f6519-7399-47de-3946-08d9f0c95f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Indicate SMI profiling events available,

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index fcb6c8aa826b..4f4caa558fae 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -33,9 +33,10 @@
  * - 1.5 - Add SVM API
  * - 1.6 - Query clear flags in SVM get_attr API
  * - 1.7 - Checkpoint Restore (CRIU) API
+ * - 1.8 - Add SMI profiler event log
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 7
+#define KFD_IOCTL_MINOR_VERSION 8
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.17.1

