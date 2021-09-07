Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BB960F6D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8BB960F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4DA89CD3;
	Tue,  7 Sep 2021 07:04:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA68289CD3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 07:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFzccB2q/cTBwanHZe2TFDagSHePvFcR9bj8FhovzIe5EvhNmUw+x7rwGo1ZI5Q/2glZB6uKyfzNGy5iO2F6APGQIlPo/qdmPpIDeIOEPIHaDv6aWMrKEGAhmHCPogzHXcYbbEf+SXFFiyUk4yK1LTaRb+8sMKo163it4KnVBvgBqwPx50GAYGQ/gX05S3xyVCem9nd+vMkN5mJ2lwehH2XWexFoXXg2QaaMG9CTizN7f8EroKn27M8g8pZCwUp/nlK7S3j0Kbt4YH2lI9O0EMoWi7eGn3WdCFDouoaf+9lp669X+i5nOJdik4+C/sk3oVo2P46/JVzNc06LDDO27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fU7WUzwJ3A/kyXfWxEt2Xax6NnaoJq00ic4DQlRdrjY=;
 b=hWG6RPNi3JWOMzWF0PO5xxMDqUCux/a9yU2kDAAPV1JDTS3fTzs3uwoEHEFvgVQDZiLDKPX299qI1BZLYx743shSMi+EagEBY7S5uagZUrlKISg1AK1TAt6PXfPdk8wK2mMsoSzxLzV+fkTP8iCjz2s6tqE+bgpWtJOa5wRrl9COi4s+oc2Osu0/GQmHhbpiVCWn0uO+Iz7r5WCEXeP8U6d6pj8psyeY2JJN6UF9bOvpjkGifqrUP5MP6N1gvy72xuwOcy3UEjFmRId7NkyxJ9JNKPyJkXBLR0BWm3+6cLlDitq1yEZ8yXCePLhfBwpuu1hkZC7NccdTnZMbyScvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU7WUzwJ3A/kyXfWxEt2Xax6NnaoJq00ic4DQlRdrjY=;
 b=DckiiuIM3qKNXQT5ZLI2YS8L0xRavZiOntb9IjRIlEbFQuWM3qiEPQuZR7TOAX5R4LNHkoiTIAHL8QyEhQClun9XEoTV1oHI22ki8zLhmIn/+P1R+BuDZJl4i0ohsuLAU9QwxiXOv9ZKCwNmOzjXcyFIxOPQPyjzW5xY2YGOMh0=
Received: from MWHPR18CA0046.namprd18.prod.outlook.com (2603:10b6:320:31::32)
 by DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 07:04:16 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::25) by MWHPR18CA0046.outlook.office365.com
 (2603:10b6:320:31::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Tue, 7 Sep 2021 07:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 07:04:15 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 02:04:13 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <alexander.deucher@amd.com>, Kevin Wang
 <kevin1.wang@amd.com>
Subject: [PATCH] drm/amd/display: fix missing cleanup for remove s3_debug in
 dm_early_fini()
Date: Tue, 7 Sep 2021 15:04:00 +0800
Message-ID: <20210907070400.223166-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4875f0e2-a8d6-426d-6773-08d971cdb485
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-Microsoft-Antispam-PRVS: <DM6PR12MB498777AF072D1180E7531B66A2D39@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxoGyrJc8L8Ck7uZzowK9tC3bvXPJA2Mg1+kpfPnO+zQeuDnXRWRKhz91ERTj5qMT9WHod3py8EVtvXeuK33xYE9Q3oNvlFbBI+7m/XxkhLbx4GGmSfGyxB2Ox8rJUQo98JgSpSJgzxO9+gdl7+Nz9539q1EVJG+pZbBNEUbutEVC3nuADiqCYkXFDTJ4QIcs+9ep3ysXV6a6Zejz4SIKdPL+KNJ9rIYFqmyhd4+6S3ycSrL8/K2q/k/liXWI3xnY7FwZv2txW+JAuJl5V2pgnYtqaiwQ3/slwyg7vZqu6oQa0Y2p7dl+wl1+PwGP6gVjA42M2jFQ6Uo7Zcms7QR0ZpQX4VeWQpI838M5Sq3mCsNvqOw++XnnNnPDYFPqylXqLcCvcQ2uqQH0IyOhsxVvfL1arJbV3q1SX1E6ihOapS92V31wnWMkBZ9oUefWxzoFijZy9ywSAAUbV9VkGSXk44ZFcldf4IL3woxQ1BzAY7Pow+AwdPb75qY1rmTORcCryLryczVEHzsKPEjqqaB83BIo/+XHJoUz4ibO7DZZ+FmrDFB8XVcZRU10hSGZBxn5qRbO7O1bKSVnVMvGXEg++mhBUX5e3bcBko9hP5LSNH6ZDm/kNqISvjJQRMUJ3tELzFDkpg5eqyM63KJgnAzLH+V6h6DJGGdQ2s6TQ9gDNIoSrLUin/YrM5/Wdh3b90NTRqyi3LT5cL2mAcGWLC8051wRPHLboT4W0Rzi2oC4fw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(54906003)(36860700001)(70206006)(4326008)(336012)(1076003)(70586007)(2616005)(2906002)(36756003)(82310400003)(7696005)(186003)(316002)(26005)(426003)(5660300002)(8936002)(16526019)(8676002)(6666004)(47076005)(6916009)(81166007)(478600001)(4744005)(82740400003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 07:04:15.8839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4875f0e2-a8d6-426d-6773-08d971cdb485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8837259215d9..2c12385e0e4f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1436,6 +1436,12 @@ static int amdgpu_dm_early_fini(void *handle)
 
 	amdgpu_dm_audio_fini(adev);
 
+#if defined(CONFIG_DEBUG_KERNEL_DC)
+	device_create_file(
+		adev_to_drm(adev)->dev,
+		&dev_attr_s3_debug);
+#endif
+
 	return 0;
 }
 
-- 
2.25.1

