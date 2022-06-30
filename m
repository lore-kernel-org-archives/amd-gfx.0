Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE41C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2782A89CAF;
	Thu, 30 Jun 2022 19:03:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EC012A86F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8HmoUDRfLmvpFTHvLg9+hQU4zZ+Bv2n4oFB7Wht6OsWg1gbwdaB9VHL8yYWbCarqISbvyz49eU5qvT0A/ydzv401iQVx7AM05+HPAKNCaZ7zbJSgPgZYqszBxF6s9EKXic2yCx2YJA9B5mkTf/oiGK2VNDMhMV2VF2tG169CcWDobpAft35Qc01Mjo21NG1+8U3Jw9mKm6K7qHVjhUvYmgT6s8883k9sgchnk2pHuAan6isGH/wG54DNc23F34X+QQNYrqttg55NSYiD0AUpccdVXoDlaVyQOEMVvUZ/GB9yrb3PG4uKcLxsn5MQh4qlXHGcDyswA6rCl8iKvMH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfFVsZXlaPe1h8MSGuSt3k3by8pYhqW6qmVujFBcfv8=;
 b=d4iWNv+/7WB9Sodus7vOic8pwBhpTddiXFB6UJ4Fx77yL2BAG0yiwcpvMVggA5+bbFuH5/5VkoWEipfaH/SbWX7ZT4xhjp3mCgKFQAgQo95nTo4lCYESKPgV9tS5RRKLkVx3bBH0upktBirqNeDQyb+aWU4zboV1sPrIl8R6or9HofCinCGeEcWJSHcJc1Lk78LVQ99STjVYFv7SZ+T3e4nKtAORrd8V7zsyQTxynD0UHqxRdrEkbUEqbs3nAtAFTXM2JP/i+J/3M4qVN3yVn+Z9Ph3McQ3bySyUjpHtj4ZobVbYPjNvRwDKf5DocYrjyVXiXFrOo8xir1HDIfgEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfFVsZXlaPe1h8MSGuSt3k3by8pYhqW6qmVujFBcfv8=;
 b=wRaEGIucEjAUA5AohqfApD9bcrYtiy8P2l/VOaf3xUW3RePJMS5TsGGQir6nNovp1SqtJRGw6HrvIBYNFBHntDlS4j8oZkOmXAzMNpMNDh3d0lT/KrLScMU8L5r5KIcNgQP5PxMsWyxADlS4hehm4krj1SAuTVAJOb6K0AhPX5A=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by BYAPR12MB3078.namprd12.prod.outlook.com (2603:10b6:a03:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 19:03:47 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::e2) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:03:46 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 14:03:44 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] libhsakmt: add new flags for svm
Date: Thu, 30 Jun 2022 15:03:08 -0400
Message-ID: <20220630190309.119238-5-jinhuieric.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b3886f9-73da-4fc2-cd99-08da5acb4289
X-MS-TrafficTypeDiagnostic: BYAPR12MB3078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egZN2Edl1lV6LhfuvrJzXfpA/XX1XYwsA3J1NTiK2tDfBpX18uNd/A64zl1VvuOULCD7VTQwhc2gZhwzLjjmc6x1UBwfOXKkQ3HrjB0gHdPHWTzY1C2X9xepMv7q2w/DfgRCb+ZMu+18nM3WV827GZXNKurL2qBmlH9N7u8ZCa75MULflxVC0tGfP58VD9TwpUnxJya1iVHHrmZuUPpkefPE2VGqMCUosi8k3UwEYFg7bsenajYbRl7NcKTKhdpiYin6bgwlkaet9lLJBoBCqHBPSbwa891AyZIpQ//iy7O9ST/fqHaqxYojNfOU0iVA7T3qHFua485vdP/vGT4JLY8nsnP9E+mDz5UP8ag/dfmAwKt9BMb43CEbzzvUGUIqftsAAZNng9Til+Zi27DNZGh5alq5EEl46Mcc2NKPGFRj053I8bIwTk9wqnThD/CxAerZzistI4DSZagnSdjEwUJS0IyVie7OiO3PJqxL4/D11DC8Lx7Q0+lYgCWlLEfuAyMAoDYODzL2psmMPA5w6VeEXL01FxboatwyooR6OYN+E+Q3T2p9kiT+jaPWpuLa/iGfRQQJ+LCDMuSMjgrKomsQReLswVRTT9w9KM3paqxzRpAkcjU1slsmWfqp2WytoKlxrzqwkkUIgsQhzvzXUHNtjbkZN7h93gprbbC4EuThJcK5/kDTZU2ezz04otVsx03zALMRLdaz5rWEdFQMzfzcIQdLxeJQbCSJZItmbwUNRX8GmnfqQBMuH7rwE71tbkIX2uWgDtt7U6h6+9iVGEo35xpvX3M2Yh15eHKJPZYliu/IRCIlmKhsu7G0xdRTHuAYkuebW8DJc2/Da/w73ZsrxXQqiz3icjM0xDL4ZVA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(40470700004)(356005)(478600001)(81166007)(7696005)(47076005)(40480700001)(36756003)(82310400005)(186003)(40460700003)(336012)(5660300002)(16526019)(36860700001)(2906002)(426003)(82740400003)(4744005)(8676002)(6666004)(86362001)(1076003)(70586007)(8936002)(316002)(54906003)(2616005)(41300700001)(4326008)(70206006)(6916009)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:03:46.6441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3886f9-73da-4fc2-cd99-08da5acb4289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3078
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
Change-Id: Iebee35e6de4d52fa29f82dd19f6bbf5640249492
---
 include/linux/kfd_ioctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
index 8a0ed49..5c45f58 100644
--- a/include/linux/kfd_ioctl.h
+++ b/include/linux/kfd_ioctl.h
@@ -1069,6 +1069,8 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

