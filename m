Return-Path: <SRS0=MNsS=OC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34663C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Sep 2021 23:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA5C610A3
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Sep 2021 23:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFA5C610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D8D6E083;
	Sun, 12 Sep 2021 23:48:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987A06E083
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Sep 2021 23:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D50X9jR5EK6Zj1VVSCfJq7ImwCFkqpSXE2Ek7RhPE8wMN+iauDXeTvWVcpNIKi79xhxzh9rguw29fEyYpntNG77FAWthWXO5uY8zAcs82LtZMg1Hy6JTks6VzSdNGpi3hw0sqDjXz+uqcFCAh9+zZfyNW0bnPUiIsGBRQAuOv2FAbXmnoPMyd4cztGFYhbvdrGPS9jAHIPFPVXLMNfIXbfhjeuz91qVF3V4Q3LwFqyM6V5cJ2ENZX4UrhDTC8R0tuLQs4NHMKsp9E+P0ICdOkF/IW8iaavGlxgdjgqRq5BxmGItrv29anhPvZJSYy4iV6luWv0fluNa+EU7AkQlpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EgG2JinDFSBAkKAAkbvNZWKl+RXONs+tjDZR0mQidvQ=;
 b=oBPxqQMA10m9qlaOf75lwn4MU8R9ZfmD5R0aBIf1pMyV0aRJ1sMgfDThIlH94DLkAjMwsE/y7mIfSLWFKZg/VhhV9WDYB9DvVwD3I5kShsD252exAJIgGuFZ1tFZKwNnYNvpPLSBepKVYwJuQ50F636O4T/n1/+gXNG9vRngWmn6MIQdaX0NmlRZNuY7zFc6J6Cy57BjtSFAd1oYDkMAZ9yojfNJRKSbMmOcQPY7PFP6ejLKbl0UytAa7ZB0ciN4EdFBi9bcCz0qL53fhHfzWMAHWJdS/KWeIxPaZJUZ0kVpdV1ueAr4g7uKwH+A+VwrJIEriiFHJcJcugXfPWE+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgG2JinDFSBAkKAAkbvNZWKl+RXONs+tjDZR0mQidvQ=;
 b=uiEoQWn0/Sg8UBkiLa3rGJtS7JEyhMUKkf1nC5O4t3YqhcmPx/bVvcS11TYNsO1UBa6zotGav0lvCkDQLm/6LjwtO/NeEsv3zyTxnUq5GGWsM6sYpVlFVJqtSiTZm0VL/8FF0gW8aXYgvJ1rWeCfXAqGlkplNV2oEQhcNXI56d8=
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Sun, 12 Sep
 2021 23:48:33 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::a) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Sun, 12 Sep 2021 23:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Sun, 12 Sep 2021 23:48:33 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 12 Sep
 2021 18:48:31 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix a race of IB test
Date: Mon, 13 Sep 2021 07:48:17 +0800
Message-ID: <20210912234817.13051-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a4db07-4306-4042-d0eb-08d97647d4a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1147C460FF94D6360F4659B587D89@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujT9QcKxgaJq/MRuzsmg9JEknt5XVa9PKhnDdyVX4rOg3bTUaCvtAQutDgVvX8QkN4tu50ZiW97X5PUB+t02ZkTwsUmefms6Pd2V367fSMHkaXMKR92BJUobq3yEf9gdjuyogeaLk580+8riqeUEO6iPKQ/iWr/LaJ9FCU+gpRn3zZpf8yr8nKwmoJjMWW5JqRqlQUNbzikUYioaxpROSF4NcEeCwJpoXQnJQwVJot7GfdrJFJoCN1clxvyriHpN8EiA6obf15mHLnJ73BTVbcZknnprt5bniyz6+9qR/e1SXQoYOaZIBjCphhQ1b4nxUlnihgEjnzm3Z5siVfxHEHRogwJYIhI76mwJYnaKnKyBI4FXL8QskxHx7aat8LDEqVungCMGTInAqI6mj58qZl1nU9Xh7mUDh5HeF6n+f17xj9ncrgebPIgYXnTQizwgpn1DQ9vDOxW/t5a0xPvQ6vGi9DbCx7/m7gQHic8JRepU+f0YpLtexPqoExUKwQZCuDirjWUXS09uy90j3qVLwyMGecrG379vwBpw/RBmMb+5xiKUBsp8YWcW2f9fxqOB1aUh0Y5DlLZOFCQXR/uvN21eNEwb0noOdDVKsbFqM9Y/JqjPH7gcrqg2BWwmShU8VxPT1TtbG3L03LbnXNxsm8fyQPPDZw0tDfM9mHV14TsiNbtISKjoJE0kVhNIhHQdXpdKhQCaiRGSZtJM0sDAirZmYGuB57KcsstFKHPQnzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(478600001)(82310400003)(82740400003)(2616005)(316002)(8936002)(7696005)(336012)(426003)(8676002)(5660300002)(2906002)(356005)(6666004)(83380400001)(26005)(86362001)(70586007)(36756003)(47076005)(4326008)(70206006)(1076003)(16526019)(81166007)(186003)(54906003)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2021 23:48:33.1051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a4db07-4306-4042-d0eb-08d97647d4a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Direct IB submission should be exclusive. So use write lock.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 19323b4cce7b..be5d12ed3db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_read_killable(&adev->reset_sem);
+	r = down_write_killable(&adev->reset_sem);
 	if (r)
 		return r;
 
@@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	up_read(&adev->reset_sem);
+	up_write(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.1

