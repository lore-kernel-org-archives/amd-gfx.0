Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32324C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 23:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC4610E340;
	Mon, 14 Feb 2022 23:22:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7032C10E33D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 23:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG6jA1VV9cs4Vai0EwPGO8feCOlBDpev4CTmXjSv68oMkQvfjOCfouhvPhscrlgKtOmKiNF6izsDUau0Kko1BMZ/yDnkQp/rGE0uS8SjlKiFo8oqzCoymDB4sWz31wsDJXR37zaaPtUfy+gLiB9hrGYnJEeAPzzED/fbe+QYdsAsdi54bfps+YOHowjDZ9OvsaNQaSFsKoZkEnF2CQUuc08UflUk+X0AFy/vLZUHdTKkzs+Z2cg0Yun2hObVg30qugLuxxdDSAziX6BOJq+NmJR0Zgds6sglN2JvE3tX4xo3aLsCPsceh2BiPd3BbS3KAlppCNP5/yDVOsM+ehEToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtBaCoFjcX8lYfnZyYEelxLvarJYe65Hw/Lj8DzCuGk=;
 b=JwnLDVB/4SBnt20bLjAljmwEkqdN01zhDbARi6xrQ8g2jYdbwt3jUlzih1aRv7nom7W8KN13aY2F5bZSYzxuyhDEGsnxDOsVTYeHXS05NEftyrS4XxUmlFSALAc8uSSV5Frw8yolgXFfMMgu5zSNXaplX5vZ2WDez1hKAkf4yq96FRvRWgaewuUj+B1w0t7RtHTzfqkv8t3Tgss4MQ/hA4lC4E5vEzw9NymKMZD13FNORvyxI03XT6cEVdY53NQeWXyCZsqG2e21RSfNy3OSE07ogH66parU3LtCExq1gck7KNASUGXRz5ieNAwspnAVw+DMpDCQysLj5EPHB01U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtBaCoFjcX8lYfnZyYEelxLvarJYe65Hw/Lj8DzCuGk=;
 b=hncwZ6cA1M+P20mtlmPyK5slrZnm+dUoMGgDljcAYX0JrQ2fkonhz+OFb4a5mWokSoYfC7PTYWxMMcmyY3kXHmMNnRCJkuQ1kPzm3GVXDgxx0Vqyh4PQLyA8k8QZ3XjpqZcP+BPEFwsQJZZBo+bcKkJewQTQXhLTYVqj7abkeHw=
Received: from MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12) by
 SN6PR12MB4624.namprd12.prod.outlook.com (2603:10b6:805:e7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Mon, 14 Feb 2022 23:22:14 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::7b) by MWHPR01CA0026.outlook.office365.com
 (2603:10b6:300:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 23:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 23:22:13 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Feb 2022 17:22:12 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Date: Mon, 14 Feb 2022 18:21:54 -0500
Message-ID: <20220214232154.6421-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.102.g2b9c120970
In-Reply-To: <20220214231857.5129-1-luben.tuikov@amd.com>
References: <20220214231857.5129-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a29127-e665-4bfc-6fe7-08d9f010d548
X-MS-TrafficTypeDiagnostic: SN6PR12MB4624:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB462450A27583A67EDD6302B399339@SN6PR12MB4624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59sxp7Uwt9DWdaj484Dd14TMGj3KT8OZmYm8jJVs7IU4Kgv5caekRijUubmZs9r8Im+HbnVrwd+t5SHsd9pbwAfVw4RATiM6+uiAwBCn0uaGI9JRdA2SQkqeJ68++SjoxtUclidB5p11HMGCmNC6Ctf/d8Wbdf48/903vAN62bYYlBh694W2LqZapIOcIVNkZ5CjhBrGHcq5kqnNzuLk6yPKNCtYfypvThTum7laM9y9qqchMLdlXqLvwHPsl2rj8tDEtL8PYVQ2JZS1Hu7hnR8nqkryGgKnlH8gKbKzmH7RGS/uM22MZP9iYReis2oLMp4l/OG07gVyScFDWieUPUVqXqX2gaoAC/zGT5qr4sLiAwyrkohBG35vnjfsG83XoVJ3I1gZeIUuKj+WK91sqsascQxbnb0JEEWiM/As+1FGcJ/WSddi8xEFjyhJ+Dr6wHZEzpwlTnaKo+Wi//k8t5nmrqYFTx0FOASvFWbow9/9rHQqRvJdjWkPAasGC1GB/6WxsSA0xHW7BsD5oIwmD5jJwAm/58DzswmLW2FJ+aH9qf8N18GR/GrVykTwwMO+8QVFT+WCdVllTL1QvwAvXGnjUTcq2Jjd1qRM1AxmWVLpDc0EN0bKFSmTb70Rx8q3aLsDGblMKcVLaJQUEjZvUtGSByFpqQftKTvziVSHk7n0/u4QlUcoVkLtAAMnrqHHpFYKmnZ99Uz472OnUzQ3Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(2906002)(6666004)(5660300002)(8936002)(44832011)(7696005)(82310400004)(8676002)(47076005)(40460700003)(54906003)(508600001)(36860700001)(26005)(6916009)(356005)(81166007)(4326008)(2616005)(36756003)(316002)(70586007)(70206006)(426003)(1076003)(16526019)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:22:13.6666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a29127-e665-4bfc-6fe7-08d9f010d548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4624
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
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the "harvest" field to the IP attributes in
the IP discovery sysfs visualization, as this
field is present in the binary data.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c8dbdb78988ce0..0496d369504641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -393,6 +393,7 @@ struct ip_hw_instance {
 	int hw_id;
 	u8  num_instance;
 	u8  major, minor, revision;
+	u8  harvest;
 
 	int num_base_addresses;
 	u32 base_addr[];
@@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
 	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
 }
 
+static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char *buf)
+{
+	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
+}
+
 static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
@@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
 	__ATTR_RO(major),
 	__ATTR_RO(minor),
 	__ATTR_RO(revision),
+	__ATTR_RO(harvest),
 	__ATTR_RO(num_base_addresses),
 	__ATTR_RO(base_addr),
 };
@@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			ip_hw_instance->major = ip->major;
 			ip_hw_instance->minor = ip->minor;
 			ip_hw_instance->revision = ip->revision;
+			ip_hw_instance->harvest = ip->harvest;
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
 			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)

base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
-- 
2.35.1.102.g2b9c120970

