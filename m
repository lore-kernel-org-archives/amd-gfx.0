Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E067C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 12:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CBE10F5A8;
	Thu,  9 Jul 2026 12:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VStLgTjq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B76910F59F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 12:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgjrRQNDeSLe5k29kmrjCt7t/mG9dkcp1BKWrIyRw0DSrBFQXCxNJO9kWoVv6qMZPBP2wGeEePAHurYt0kd5cnDO88hxkjMCx5YDa6lPwlzn6ECfOs+rKGeSWEWhVYwRGEGVfgG28LoLQkZRHTMpFr5Ng39Wd6khpITZwwM4OVxy5Kd9IgUuoI/3WOawYdK3Va0vzwgOa7G/O4WFoFbsf1TKXWJc/mXClT+2wW9pUj2cKO/bqVYgAVXouywMpUSIcd8mKq/IDVtmnm6t8zbeNnwC3swNPTHdmq089wIFrJoWet4L6jNFCnfPKz64Kczh4zJ5ergcsgYcD0ffBKlCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlvlzS26D8sI/9KGn7as+0ViGoAovnwcKdvqCSysbmo=;
 b=xNlrTiyZUNyqOuPtQk02fLZtIzSHlNIq5qLbmE99BHJ22lEXxSd8uGP3k99cCRPQzN8bAW84ZU5pdm1BwCQxnSelOaqqAKh90QOZqQr5zu2goj355FY9YSNGaATTv7cVmLsvlV2ufPBu24AYWRfoTr7X7oRlrWTV5QwEdku5/vuQq1/ownELFxfgNqNrFp8ZMAC2PsXdctLdggUz2rAC0wwkKyVV5sRY7O2yR4KlUC4SoiWUs1RjwkulGRdloXrEjBeBcHg8IQBFBshrIAqYgt9b8jODI7xC1ghVxqPfnE3Tbdc/n8/Yg7DNicyockpe2wMGJbkIwKfFGWqKfWUc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlvlzS26D8sI/9KGn7as+0ViGoAovnwcKdvqCSysbmo=;
 b=VStLgTjqdVFsQE/LUteuu9dwQEkIiEcgfdEosnK2T2+uNsjkM1Tx6IvEmprikUxHnY2N51l80XTN1d55MIYogDZVj/62zuXofv+AUZH5DqhD3+coHV2+FCquwZhaSbuI2ifTk4fbQs8M60RPThVqwmK+YRbEOJ12z2VWglVdzDw=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 9 Jul 2026 12:26:58 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::95) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Thu, 9
 Jul 2026 12:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 12:26:57 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 07:26:54 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Update smu_v15_0_8 gpu metrics
Date: Thu, 9 Jul 2026 20:26:33 +0800
Message-ID: <20260709122633.1788432-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260709122633.1788432-1-asad.kamal@amd.com>
References: <20260709122633.1788432-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd08bca-b33b-4ab9-6595-08deddb55eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: raRpqril/y9qUB/Izl96a7vbreoD7WnjBmUHPaO54rulWkPvAKxUvaYZkdSlgYp+s91zyKeGbfuAE9ukEHfrkc3Y/U3e8Y354dEjMI7E/mvXfSHtSO3zE0mlMMg6db+b9gItVkZMBrQEEnycAsD1sn62aDBYuQ7Lw6GatKiHbo+HKanOZDzEZkj93FtlKnJTF4mAmVno7aT0IM43uL2ShRTjvS2fx/UZ2W6PlDM5QuB3rDU6jNzNG6jnFHTmsk91A+AbM6jMLTiOVkXABiQ9XjyS1aUq1mkuuHSNH7mrmsTOFPZtFvUX0Ma2w6w2o6pFDWYaLr1YGULMOAXKGexS4KpHNh4gzaSBta/WmWH97zeIkwqhseY4JMtZ+8XdjTwKQOmXvpiWiyd0MrhwB+2aVFFnTqPHWpMb754DPPirmqAqfkzqbkzT4UNPGydhF5o1Fd/6w8+JZ+q4C6d1Q2JenrEbh18aY+3W45GrabVA+XBGXWI6Zba/OGt1cwX4AbBSl3ixU1BozFTEJHFRW0I8g0HjVLe0rbwhxJKIOMtHoQCg+6CP9p0weJeZ93UNyG2pI2gsRJve6EOGhztmDLIF40KfeqhHycRI2OMF7DhBFonjRvuLKNB932TZt2/Gp0sIucpScY8McccYXU5lhsnNPoOILexAfOr3fw7n7oevNU4S828tNHmF/McUnSzR14SVwbc1QUyjXXvVApPjheX6nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V7rYUjiZm8BAc5y+t3nLzu4d4nyRdEqk4GLRGhLvtiJWK3M3WW2Ukil6bx5hSrcbiLU3E+yayk97M6Jrvo/3EsPnqS1JFSqlubrlg2u1XyU8TNMqX6Fo6kLh/R2QqBK/LYyLTmn42VWEEE1QIL9BlTqNfYRbMfx/qLAciLnEcNwHlrcKe9K894fFQySJMB95G2Cl64FKiFpdmCRl4sHoIjz/B4ygObgYrY299FcZSN1DIFAGvG39wdTDrwr3OzsKDcvkvOr+iOyupysqiBWZP8bgn/YdBMTQpdcClmyIEQ/KX0eRP6ElmEgYYZ9JawKPVklv1SxcHpM3swEJabhdLDYOxDaVYoOqDhOx2WPVe1AW7BA19azQoAKFQpyoUVjg4exQu+lSvJABnwGfw9bUuXboJ50+mAZHi6toOLuHwohSnuDzkWkZhh3MCa4RnZHU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:26:57.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd08bca-b33b-4ab9-6595-08deddb55eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
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

Widen pcie_bandwidth_inst from U32 to U64 to be consistent with
the smu_v13_0_6 definition.

v2: Remove percent conversion (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 4dfc40aaffcb..46fce0a79c21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -125,7 +125,7 @@ typedef struct {
 	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(NONE),              \
 		  SMU_MTYPE(U64), pcie_bandwidth_acc, SMU_15_0_8_MAX_MID);     \
 	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),             \
-		  SMU_MTYPE(U32), pcie_bandwidth_inst, SMU_15_0_8_MAX_MID);    \
+		  SMU_MTYPE(U64), pcie_bandwidth_inst, SMU_15_0_8_MAX_MID);    \
 	SMU_SCALAR(SMU_MATTR(PCIE_L0_TO_RECOV_COUNT_ACC), SMU_MUNIT(NONE),     \
 		   SMU_MTYPE(U64), pcie_l0_to_recov_count_acc);                \
 	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_COUNT_ACC), SMU_MUNIT(NONE),          \
-- 
2.46.0

