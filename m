Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF8EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 05:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099EA10E238;
	Wed,  9 Aug 2023 05:47:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C0D10E240
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 05:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGKxypetR2T6AYwkgkpOCoVUzCFaLZx8sYQF4TFNd/200T6S84v0ImF3DSATc4vdR/3g139ViG6PAFP56YR31GOvuasjn+7ADxu4rDvEBXtT9f1RpOTD2INUVfq6d0zFXcf//XE0Oc5Quf9OtrprdtIi/Ub3g2IobF/5jdYADRMXUl/DVFSaXxjdpWEesGt5RyAbXh63GdAzOcqBTWZut1KfxlVMG7Nxo0gMD2nvwNG4CG2bC3zUZoBKOYMjqa8LvVq7/SvpWRqk9JVZ1NTriWf69WrBEPFajjS1pXLsrDd1iyYpA5b+w6/o6ytDpGEx3+YxhItiFxd9/KnSMt+qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib/CwdSwsoDoeRNMAwuD6vVSDpNqeNiD4QyNri6D37s=;
 b=WIV8vy/EFIrq/uf8Aj722Iedt+bIv1763pIo2CaEwoiVEaghr7QmWoqAwcwDgCtZboYP/MNG/NsjQNjHRHbOeDvrEUJJSA8Qj8dbnfBS+T1o4nmww8l/xzs368AF7bA50w89JgA1BxN6cYG7bK2J2jg3hGSLtPxV49Hl8KCkpeIh/LqKvUkjOb8FdMvLrk1T63UvcZc807N0sgra95/s/Cn8cIZ9iCdJTWkGmy0C3Gr8Hg+huzQ4DUqzxyJtGnfUKQMKTpYtPn/Lm3pwZZ9Y8tsOWe7n23KZRfG6onaymDhvGa7ndHue/aNGrMr214JSVLbVrBvZP25tOMxhx95DJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib/CwdSwsoDoeRNMAwuD6vVSDpNqeNiD4QyNri6D37s=;
 b=h00GMwL9PyBe5wqsajqrNj/HcL6uy++EtNVz4rDF/lB0OPt2LiEsi4GzoslZ95POFmQDmyiByfnC8u4JI08X+RbANjPNxXBMNtd+OAS3kZA4Wmn3ii/lpjVaBDRkdb2lDG5J5YLaL+wD/117e8KByEPmu7kfshQsodozDGC6BE8=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Wed, 9 Aug
 2023 05:47:08 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::15) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Wed, 9 Aug 2023 05:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 05:47:07 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 00:47:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix missing comment for mb() in
 'amdgpu_device_aper_access'
Date: Wed, 9 Aug 2023 11:16:45 +0530
Message-ID: <20230809054645.200739-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f922818-dd61-4137-4532-08db989c11a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04EOHT1XqSnz3pRKFj68Z3XbJktEhI8RftZ6mXc6abmAoNqJOTavSk1aTy90on3lLGa0zg85WzRFTHrUl3f98YvrBQMwWQgqalagBPE1YM5+i/YdrIH29rnQ4RSTbwXNylGpeGw5vygEJF3Cv9FLs8OOvGtEW9z9kuHFe1HQ/Hs1OxGmZ7Bep9S/9uv6gioBHN+9rIUYWS16fHpef9uBgZXCwJ/Nu9n2uGXYHp+ZUa+JSaFueP0YOeIlMnLPO/TFg+Y9xx0DHQXT3NASLhr0W6Qo5x4ifpsq0qW8C5nVviStCBad4d/6ZoFAVaoDQsqpFz4j/dTjv0imEiJd2+++TG7pf2OKGT6b4QqJxSg+waujWd0BYvaptMCWYyEnxWI7iqat+R8MM0xvTWFqguyX5hxxgJmfbjcIHu2w0PUqZl+MVXlYI1lPknD9oNxnwgkGz/71yMOSZyx2f7lhCHwGVLI3UreMA/3xl6db2ZpvETfey9DXWtZPsXRP+k00+lVHM8Me6HBK4Q4Sp3o8hgJRqukfiLjQG9FQ1K3pVUTYjfHz6rJncXQfjcuPQmpeh9rDjm/0MWhfNoZqjj/zI7BtPw+Rc+LogNlRqydZ0FpataBxx1j5BQ4rGDk6CK1KHAPQ9MQhYS2aTrLgKNkzmo8fczbn80ApOnnHmcueoA6ewlbRE184Ja975sY6MABAwFsoF5tJemOxn3jCpNFQl05yZ3JtZ6+8vFvkmHBnyR/jYk0cr8Ce9DfzlJbHJV+ley+hXoGX2WMi1owgRvA2/DHkeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(186006)(82310400008)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(426003)(83380400001)(66574015)(36860700001)(47076005)(2616005)(40460700003)(40480700001)(110136005)(2906002)(54906003)(6636002)(4326008)(8676002)(5660300002)(316002)(44832011)(356005)(70206006)(336012)(16526019)(70586007)(8936002)(82740400003)(81166007)(478600001)(6666004)(86362001)(7696005)(41300700001)(36756003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 05:47:07.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f922818-dd61-4137-4532-08db989c11a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds the missing code comment for memory barrier

WARNING: memory barrier without comment
+                       mb();

WARNING: memory barrier without comment
+                       mb();

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3:

Corrected title message 

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4f818f13dc9d..bb65e12ed027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -305,10 +305,17 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 
 		if (write) {
 			memcpy_toio(addr, buf, count);
+			/* Make sure contents of system memory are copied/flushed
+			 * without messing up order of writes to PCI device I/O memory
+			 */
 			mb();
 			amdgpu_device_flush_hdp(adev, NULL);
 		} else {
 			amdgpu_device_invalidate_hdp(adev, NULL);
+			/* Make sure contents of system memory drained/invalidated
+			 * before copying contents from PCI device I/O memory
+			 * to system memory
+			 */
 			mb();
 			memcpy_fromio(buf, addr, count);
 		}
-- 
2.25.1

