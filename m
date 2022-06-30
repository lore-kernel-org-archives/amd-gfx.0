Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D98C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB2712A872;
	Thu, 30 Jun 2022 19:03:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2DC12A86F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aecgxqx97QqSQvJ6LfufC7RPgpysL+akjEHBkTm59kkg0gPx7rCUCrmOLiICREf3VYsYBrZTz36RCiTe5eVikZBbWgCrPwTNukzMSzlXqZs83Y1biXWBrMflit/tSJoZjZGPsYb1dQKxUaryNCozBJbnpZjbp2LauMF8Ih+ipOUWTAyXE0FeymLgICQo/pNTgxoD53eR1zqjqqwWsOeCoqPSSOKRgmwvXuFyhlRYQqW/HNFQ4j318tYUmTihnEWiu6+aPfJD6/aLjdpURwASUnTMGifIPUaw/Ukbm3URu/mi9FxdxpFTzCauKrcwin0TJBfjk8hjQdObq5VshlN3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGufrzNTkNDHTBUVerDzv22p9pOVzBBqHvLoPu+Vt9M=;
 b=lpSinGTw8NaYnjTeDpR5uoL+1nnd+7L96GGUZ89lY/b6gvW+JqbPzl7xnhaSPqcb+B0xukH8zOovDq4uFjT8vd1zg29G4LO9qlZ+AGIJgwKhxfOAz9eDM8tmYvyzBtzsqVKXFqgi2sC89ZPs5CAWbjWnayLpmS1DALxhwZ4fopvIBRj8dinXKNK3V8DdcV5asCvABm6GMW+m4iFdDT+1APyjX5B2cnoqkeaAXFczucCM6HcYiCkToIZp8eHr+bYhoK3AwdMruftHJLuhRfEyRrFH28i6UfXjWSpGIEuFF7ef5tyId51LcqoQ/SwcC9xjBSrQc3q3shQ0weBWnUWHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGufrzNTkNDHTBUVerDzv22p9pOVzBBqHvLoPu+Vt9M=;
 b=xaZ55Wy+Sho61LLuawRJJPRa7a9oOp8rDgdBK1FahfAC97pq0L6PttyJp/O4J1X2QysQoydL3hHKvY+Xrad4dXQUcGLnz55YD72jVU2ILzwBt40MAjCfg39rF4Hnu8diwgVB6bBXnszH3Ln0yR4I9Ro1ZIWMiqlPEwSR35tw/yY=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:03:44 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8f) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Thu, 30 Jun 2022 19:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:03:44 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 14:03:42 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdkfd: add new flag for svm
Date: Thu, 30 Jun 2022 15:03:05 -0400
Message-ID: <20220630190309.119238-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630190309.119238-1-jinhuieric.huang@amd.com>
References: <20220630190309.119238-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b26a96-b9d1-458c-5b97-08da5acb410c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy0EwoMx42XbT8DjYGz22cT8M/NvjWWheg1mnHtbcKUtg3xOP8mWBqkdmCkSlHRzZalmVgKDp7OoxRgqaRjSyJmG7BqvSbfCdrHlJDu7jO7nawYY4nnrqR0miE4kiyBwmqw2bYEdms7zQzWhB+vUJczy+28qX5vRtGmtmicNi1ooy9PBF+KdKjnHAb03LSVer3n0qyrcYEcRE0x3yYBDpgyB1ezUd0UNMS/RI4/cWMOVBKAcwD1/m6d+grGUruOBfTAhho5uYEQeBDqZ70OwAhTrkTMRK8eVUNlL+w1LHAtLEY5iZbxUEZfqajoTzjoV9WF/jVWafdlR+XfGfsSLhsarTvKDh18bW83xUJBvPX4dgTDOKd6mq38I7Uv5131E5/viQAiWgr6EuUDJRz0pFFUN11xpKoecwbUh7ihslHHCHjX1IGACgZcEXVj5YtvnQPGFw5H55JfZZ0sD0K34n3tfl5a2Ib8NM7UwAJhbCTDbyKhqxKaegGKl6sVOAZ3TMMF1LM8mhyXBLcYPJvJRRJjdc6UG50w3dZckAmEs4iXWc2v5FtckYs+W2rzqF6mNQoXFrna9WjJ9oGhW1PbLW5OKcdduCk6wQlOfeb4MteZi62fq0WrgOmIGxC04gi7mPYJsVmmDcvRqjkhxeYEQC9JJXLv95N+/ouRIwlw5zK1Mad+RiTGB5+UAY2/iTAyuvqaGDhyT+6AdvbgaWUBUBxmPGALYRu5u8QvgoYvVaGHQmahg8hAorzK9k4g/4ovSN7mbMLmdh3LNT/homdxoSUkU0lk402czVFcGTEP//Csx76eDISD0JHhEyJEQ2pjvmaDYSBSBgxBICoNADfbGJ2+/kU4zX4IjWkhN8Gx75kE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(40470700004)(46966006)(316002)(4326008)(5660300002)(86362001)(36756003)(36860700001)(40480700001)(8936002)(40460700003)(2906002)(4744005)(82310400005)(70206006)(54906003)(478600001)(1076003)(41300700001)(6666004)(186003)(47076005)(81166007)(426003)(16526019)(6916009)(70586007)(7696005)(356005)(2616005)(26005)(336012)(8676002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:03:44.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b26a96-b9d1-458c-5b97-08da5acb410c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to add new option for always keeping gpu mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index fd49dde4d5f4..eba04ebfd9a8 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1076,6 +1076,8 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

