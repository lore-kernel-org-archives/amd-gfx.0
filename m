Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A715C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 11:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47ED310FA1B;
	Wed, 27 Mar 2024 11:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RpHYZCob";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4870010FA15
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 11:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlQxqwABxmoxodUibSwf8k419hh56+LC6RkuthMLO/vT+51GWrgckPXK0Jy9TeUsKr3jv+BD0eFhsiQ38JqfVx2+kE0rxi+Qdqr1dsn8BEBHaVo5ZXoKFUReuvEt0p7jBEN5rz3IJUOI/nNAY37iXm7bdZawAt+6CKhLhojm1dA4ugv9u323X3pp4P3yV5HPh+DY/gYMhF9d3vEDH+L7X2CVUIQOX8RQhp4iFoa6ku2gJpGdmevUUOqueiz/Paj+i24OZmvBhLv4ccszff9E4hd1TNtlXX7ShKHWNpTOPet/0tOOQJtUOhJqWNvBp1rE9eZDAYan8uPabVv9+yRWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U64rxFg9bCX1pRwJPhUBvFU1svYzO6nOZBfaPLURv6w=;
 b=T90HSXg+p9yVhEFx+oHDpCw5/HXsiWQQMAqPnBS56tCjLHcRICXi9Y4DyLR0l1bhGT+42eKlGtKnnPLg4ajDnNvkG5aMyvwMQvDqfBk9DpsfqvAsklLeZIxUK33AY3dokTd5gLd7NpRKnkHgVQqC2nuAUh0vgz1yq80/i5eD5luDSa//QSqIl749PFMydYQzp64A60oo7yuwavYtasP/N99to2Fa2WupDowSkfaCBrZtvwcreTEGRDE1/lBPVRkV9iPNhmlT+8RB6J+UMxlh7Kr0U5NuLVw3Ui3UG/vMiQIRcIMgoOJ/OZj6iEY+mx5G7pkNzKkpXe6BDMBUYlP7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U64rxFg9bCX1pRwJPhUBvFU1svYzO6nOZBfaPLURv6w=;
 b=RpHYZCob9MHKF6SSaJ3HKtj1qbK5QY5k3xXHOhBt286iRTfHn1wyDTJxkkUdAbMgeoJJypYgRqHux53e/w6xdEI3A+Pon5zcqU/kSXkBTQSOfDLexks/58C19tVCI+UXz/1XCu2YJwV41NvMLxHiVC9XhkmYzzlfkAZm4UdtJZc=
Received: from BN0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:408:ea::13)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 11:11:22 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::84) by BN0PR04CA0068.outlook.office365.com
 (2603:10b6:408:ea::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 11:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 11:11:22 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 06:11:17 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu: Add a new runtime mode definition
Date: Wed, 27 Mar 2024 19:10:05 +0800
Message-ID: <20240327111009.2994297-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 476e9e08-ea01-4885-38b8-08dc4e4ea2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOfd9HdOvcp35k+dqXB/0n5XR1PlW7kC2cpIZrmVUedd06JmMQLdYtCXcuD3D6V4lNDJsAl0VJGsnAWHh95+Ewq3iTZj73e/+V3/YgAD2BZ3IpbSgOzk+5VcHJbYO2JQsbgu8+WpAkO6Xbb+ron1oCsWfS6RZCltr5nEP+tpEOp72cIi8VcHQfm/Vb/MmK4+WQWjrTLjr0rSkeHmtVU2VpT3OANTXFP1tKd661ygO7JGgNoHcCsjlu80Em60KSqQbT6MZhTgFtMCyZofDeplxKLCeE4iBTtr5ZrZtEPVqfMHzUzROQaZDlBaym0KaxdXyUn8fnE38puRfk2rynk1zcZMX7EbrhEpGNR8XJNPhkvFoPH9Le9ETeJJhaG8EM1pyvZ970HXDS2rUrYrO9hrgyfozTVUIiRfYrOkxR/qGoxXOHkK338s38QPagA4o5Dmu6JyU8yNoQWlhmNBESBYqBWKTdjTWcC0Wfk8rzvlnVRRv9OF5vKNJoqPS7kDSLD1KVpuF+tpX7zir/8yroGx9JvJUgeEQC0mNnvGVcZOS4sHESX0UUZ22cP/qD6AMFlfUsKAp/a9QTjYBBtV68Tg8CCdaF530HwadfJw6mXBQM6XjsP80zbAt+W9XHTYwoPUueiifpbh4wvQ746Ek83DGL49cjNgC1RP/4DDw+1/YjjiUWfXmFT6+ZAqdqi2UeXEdL1SrEYEjLX3v4kO1Zp1CDfIPRVrbxqEwxAlRG9PB4vOOQdbP7T6GUvYcLiGq7CS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:11:22.2123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476e9e08-ea01-4885-38b8-08dc4e4ea2a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

Add a new runtime pm mode AMDGPU_RUNPM_BAMACO
and related macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 621200e0823f..e6cad9f7aaeb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -50,8 +50,12 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_PX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
+	AMDGPU_RUNPM_BAMACO,
 };
 
+#define BACO_SUPPORT (1<<0)
+#define MACO_SUPPORT (1<<1)
+
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
-- 
2.34.1

