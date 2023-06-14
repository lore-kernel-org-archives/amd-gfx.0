Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D9FEB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954A010E152;
	Wed, 14 Jun 2023 17:58:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7039E10E155
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7r30iEkamLLwIcbGC/KioSA1ccYS1z/anHYHetwTU0oeRW2KRCns0mRmT+FcWA5T8x9eK+bv7y1OJzoMSr83mJcutqwqKLDIU6LU9IaN079TNpKBkC9cpa4pTeKaA1epMZYs466fFrO3s3uqOe7ojn7nJ+oAPdtwQnFXCSSIcN9xXR/nBOrA8BiV9y4kBIAmKRdMizjEIANby+PvuMf2c45H6tHfWegFaqzmJ1Qt78ap07BVG/mYNi4ggRk6AELR/6d+kJ8S19SfPDmTpYmnNGL5dADn3w4Biemsw/p6pfbt3MtqD8dAIYpQ1EhP/eqJT7q7/9mSTpEO3DV8nrkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1esJqwJmS/3OThKG6T1JBwGRsUpm5n5n5H5AFGlVvY=;
 b=KMyBntmZfEboP6qOGXUjL1fAbX0n5ap7wv/zFs4lmwR9P+ilj6m5drqbhoAU3uXuYuBcby+sLEsJQiD/khWM6VZs2HBajWQu4Wp2tZLzBvbynsI9OqKrzKFehZ5zCozHt+p/MXP3QKVjJ4AhNWCYLafMZ9td0z+A0aAsmkzIB/ASG57JCZudVzTQkGn2YOEbllt38nna/iPb3xg8+m9P/APrbF1EwKunO7His/RVyFK6If3aMhnEqjsVMPIjE4FOoHMURgnFQExhgA5Fh78gjfLiygumfqqDfxOYUqY3XVPv14Nmr74m5tTbErvGVWoIu/wpjNvOqiV/wsL4VQMWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1esJqwJmS/3OThKG6T1JBwGRsUpm5n5n5H5AFGlVvY=;
 b=16qrHst81F60pUOrdGwPFbRstBQ7eSJG8t0KQOqsADfYy/4qrQwY9QyCLVHV9fFQUgLoGHhkoQ+ibvSkGXzN59QL8LDhVUyjHqlJvplL7Jl4sJBPj8UOcjPT6INcAkdJ3xSTSG/QYrgBIa2+Cqle/GLUAp8mjoDzRuI85AOxcbI=
Received: from MW4PR04CA0165.namprd04.prod.outlook.com (2603:10b6:303:85::20)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 17:58:20 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::ce) by MW4PR04CA0165.outlook.office365.com
 (2603:10b6:303:85::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:19 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:17 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/17] drm/amd/display: add missing ABM registers
Date: Wed, 14 Jun 2023 13:57:39 -0400
Message-ID: <20230614175750.43359-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e39ce34-32a5-415d-4e20-08db6d00eff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsO24y9y2JkS3GOr9ayeh0doGrNWHsGZX0ebVu6fUTwplsalH7UVDFlKoOABRHJPQdgf/TacMHIpRNbj/KdBO0XPR+CGwgmOVDolsudzDmLr80L+dIedZf7OYyxZdd5yxPIbCGB/SztEKpcC2CmgcA1xSckgrXHGzeL+b1XLZn15ByNKBULQuOyM3OwDXOwJs81PKRBqjEwokykqEMw4hEqY3+if4olvN/9tZFq7UjN+a+GNiLyhlWzwlUF1oI+lEZhm+g9bI7FYPWvQWmft9RqQwYN0YHustOmqK96pFpdyNe6bF6V21YBCaJbbn6M5V2UqvqKWkv4RWGe3UCjAhAwodLYX7RNXbH50/A45jLOiJej11Q/P4aLC2bU+0pMEvMuV1fw+f5MrCulylc2nmfFHA0Nl7KVwDhYixXDOA6LQBkR9WjG9cO9DOp+PkSgz+Dkvw/QcJTWONWxaiqCL6v7uYi8LANUN+8nLAolLJpidlL6A7Opy7TVxSWlV767S8cXRf9TwKPdL4zxRB9ZucFNfG6GQBDMhzYa2qaxQMGRdBMYyA127vAiMNooTC7/BtnHifBnOmlGuvDUfDuYJI5fzi9tIgh4d9LyViKJoPA+FFV5NCaAVWvrzIuabixMDu/isG3yoeC/IkMCNh7KGfrWSYZ/VXxl1FdaXkBLV/nCVfmHdDfxkvksJNTv30vtS97pZAKAfKmysKEFozkdPxgF921KOAUtyckBZ+7CxjC3s4Ic5DYRRtu2uI8RliL/MUoGSWbf9q61nw/F3FQ2rpehskiKBoQcAaV5VFOlzhugk/PisXD4zPUs3qJVbf2MbGzYkTno/HZDe4lbiysiWpAs5kkcwjKLD45/rksRIPDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(8676002)(4326008)(70206006)(70586007)(54906003)(44832011)(6666004)(8936002)(6916009)(1076003)(26005)(316002)(186003)(41300700001)(16526019)(36860700001)(356005)(82740400003)(336012)(426003)(83380400001)(47076005)(2616005)(40460700003)(478600001)(40480700001)(36756003)(86362001)(81166007)(82310400005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:19.4581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e39ce34-32a5-415d-4e20-08db6d00eff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Sridevi Arvindekar <sridevi.arvindekar@amd.com>, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sridevi Arvindekar <sridevi.arvindekar@amd.com>

[Why]
We are currently missing some ABM registers.

[How]
Add the missing registers to dce_abm.h.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h | 29 +++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index e6c06325742a..168cb7094c95 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -266,7 +266,24 @@
 	type MASTER_COMM_INTERRUPT; \
 	type MASTER_COMM_CMD_REG_BYTE0; \
 	type MASTER_COMM_CMD_REG_BYTE1; \
-	type MASTER_COMM_CMD_REG_BYTE2
+	type MASTER_COMM_CMD_REG_BYTE2; \
+	type ABM1_HG_BIN_33_40_SHIFT_INDEX; \
+	type ABM1_HG_BIN_33_64_SHIFT_FLAG; \
+	type ABM1_HG_BIN_41_48_SHIFT_INDEX; \
+	type ABM1_HG_BIN_49_56_SHIFT_INDEX; \
+	type ABM1_HG_BIN_57_64_SHIFT_INDEX; \
+	type ABM1_HG_RESULT_DATA; \
+	type ABM1_HG_RESULT_INDEX; \
+	type ABM1_ACE_SLOPE_DATA; \
+	type ABM1_ACE_OFFSET_DATA; \
+	type ABM1_ACE_OFFSET_SLOPE_INDEX; \
+	type ABM1_ACE_THRES_INDEX; \
+	type ABM1_ACE_IGNORE_MASTER_LOCK_EN; \
+	type ABM1_ACE_READBACK_DB_REG_VALUE_EN; \
+	type ABM1_ACE_DBUF_REG_UPDATE_PENDING; \
+	type ABM1_ACE_LOCK; \
+	type ABM1_ACE_THRES_DATA_1; \
+	type ABM1_ACE_THRES_DATA_2
 
 struct dce_abm_shift {
 	ABM_REG_FIELD_LIST(uint8_t);
@@ -288,6 +305,16 @@ struct dce_abm_registers {
 	uint32_t DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES;
 	uint32_t DC_ABM1_HGLS_REG_READ_PROGRESS;
 	uint32_t DC_ABM1_ACE_OFFSET_SLOPE_0;
+	uint32_t DC_ABM1_ACE_OFFSET_SLOPE_DATA;
+	uint32_t DC_ABM1_ACE_PWL_CNTL;
+	uint32_t DC_ABM1_HG_BIN_33_40_SHIFT_INDEX;
+	uint32_t DC_ABM1_HG_BIN_33_64_SHIFT_FLAG;
+	uint32_t DC_ABM1_HG_BIN_41_48_SHIFT_INDEX;
+	uint32_t DC_ABM1_HG_BIN_49_56_SHIFT_INDEX;
+	uint32_t DC_ABM1_HG_BIN_57_64_SHIFT_INDEX;
+	uint32_t DC_ABM1_HG_RESULT_DATA;
+	uint32_t DC_ABM1_HG_RESULT_INDEX;
+	uint32_t DC_ABM1_ACE_THRES_DATA;
 	uint32_t DC_ABM1_ACE_THRES_12;
 	uint32_t MASTER_COMM_CNTL_REG;
 	uint32_t MASTER_COMM_CMD_REG;
-- 
2.40.1

