Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BEAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD62410E4E5;
	Thu, 20 Oct 2022 15:50:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654DF10E636
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMY3bla2rs0BZVzMAu4xRJGmS13VcQKjL+hqcpQvUq76Crgs7a1ntpFzSRDvZgr1YVCokbE5jq4V0Kl9wIADBghQfpA1ubMEe1r5u0kDo6RjFvL0pTecqvJFlQ4Z3d57Fj6n6oySTluw1t8i2RBSZAUIlH5Qlg93qkb7AW6FvfI31Mf6cNyUUI0WE6iB9kKbW7FCoz6RSI7IqAu9u/Tddp8TtziFVIN2+ajyNIVwWjjmC3Rz0zjRy28W2iRbT2XMVBTwn2WRpAw0qI6GcKky9OWqjnVfbfEcxvUUTlEbwSRKo9lLdnRcOaDZwPDx2p/okZdscPc8ZNr3Ay1QuEevbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxAMJjAOtgvCxHF/YrMvmxwNEFs5XuYssESrEv4ufQI=;
 b=cN5svZ6tcsNfG/ObkHjYHSy2G1BZuImMdnT1q1TEr1ic9XtPU7cbcgpR0pz5WcNEZLWxauRXGoJd6aTxgS5w6J0Oulu8Vx4yZGKln/3oDhaJz4k429DKLhoODlGUSBAGz2ftF3tgsSL51GB2ePHdN+5sc5+HAlnaeUyNcEUJa1ER+Zpo7Tp2F1P4gP1SFckhajAAlDkna9FY//Jvu7BA8B8GU3xIUMFt7Dv0TmK1o9DgsiiyT989vrH8kO9pBG+d5JDsFw351aiE1KdY/rXzthYX2qwfeeleVlkpa6HWKik8wNnYHmp0aouUhTfZYkYH+1fQi+bP12oDlED59DhDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxAMJjAOtgvCxHF/YrMvmxwNEFs5XuYssESrEv4ufQI=;
 b=ehFEfTSIY2dkgu7r1BRxnhQ3dSaqVzNKlDsoPyDEAu7/04LL+icxJHmYEkvOUj9VAIN5ySzzSVFZNQBeF9nvZHA+91k0x/NcjHuUK/4wvm16OQHtKDNzZvStCFY9+/F6NihckQo2EWThPk678MuyVRJsIvfwG2QBv+Vo90j8CxE=
Received: from DS7PR03CA0125.namprd03.prod.outlook.com (2603:10b6:5:3b4::10)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:48:17 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::17) by DS7PR03CA0125.outlook.office365.com
 (2603:10b6:5:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:17 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/33] drm/amd/display: Add DEC/CRB basic doc
Date: Thu, 20 Oct 2022 11:46:58 -0400
Message-ID: <20221020154702.503934-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc69214-c526-422c-7ffc-08dab2b28176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TdDkRrS4MxlwT8/WzmoTK0LJ/1WhWg1ZnGno5T1FBmsteMwC0HFY2bptVNbPssmnxsUcqGIOK/YnuOZlsoDr8xdFa7doa33nApG+6ZqV1NyDCZ/1ftpZ4vNOzHf3nrZTc5Ju7RceVfaPh80oK1Am9X7NY3fF0zUGdSN+e2FxXLC2bELVPgjwq7bkOLj09uKo6GXK3lFo6nq8Ev0WsNp/gpWYahycCIStPo+vA5aEQc46NvzPzScffpwOqZOCiU+ZIZVK58kMTSGOiSbHg/oTjIPNKl0NufDTPKK6yv5oub216GbhmPLP53sq4SPF1AAYxZsr5yc0UEp+W1/sG0ZMcmUEHx2eCiFEUPkYkpZcFGSFfNS/2ZYxl+AUugoIZKqaCU98tj/o/8tlU1ybO/ew2iqF5VlxejNrZeVgoP3izn0CxSFrDVZTVh0DoIp0+dw5evs3iv/piTR41KM0NGRNmWyJk1xgw9Lh4n6lZ/Hc5nS3aSQjkHNdCO4zO11hrTAC1tf04dRsBLKsSjldDgzOreSxbdgerG246QDUxEpPmpSNEf0WkKzaNFI+mkobv2OjD5AJAAHBuGiQex6ybQK3ZvzWObhdnd0d3iEkJRQstvMzF7+BKIqgeKoFQqNBdAvLhi4RavAYRfFvhfph9uwr0PccFtfFK3ROa1UxcfDvk7agzEqHWRSEV6fjPoY9Qzz5D6nuD64YvKj0IbAjCJFY5tgS1s1arOtylNmA37P+CiRVzPsz1wahCpbfsYQRwKWnEeV83v7TuIKr2w4AJDD3TqwdoPyaEl0/A8n7xTskcPW1L0L1QL8kbrYf2eRhUdZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(26005)(316002)(86362001)(70206006)(70586007)(2616005)(16526019)(4326008)(1076003)(8676002)(186003)(7696005)(478600001)(426003)(47076005)(82310400005)(5660300002)(6666004)(40480700001)(336012)(41300700001)(36756003)(6916009)(40460700003)(356005)(54906003)(82740400003)(36860700001)(2906002)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:17.1671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc69214-c526-422c-7ffc-08dab2b28176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a kernel-doc to the DE-Tile function hook.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h  | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 9fbb72369c10..a88a71460521 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -41,6 +41,10 @@
 #define FN(reg_name, field_name) \
 	hubbub2->shifts->field_name, hubbub2->masks->field_name
 
+/**
+ * @DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
+ * DCN32
+ */
 #define DCN32_CRB_SEGMENT_SIZE_KB 64
 
 static void dcn32_init_crb(struct hubbub *hubbub)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index e7571c6f5ead..58f758fcbce1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -167,6 +167,21 @@ struct hubbub_funcs {
 	void (*force_pstate_change_control)(struct hubbub *hubbub, bool force, bool allow);
 
 	void (*init_watermarks)(struct hubbub *hubbub);
+
+	/**
+	 * @program_det_size:
+	 *
+	 * DE-Tile buffers (DET) is a memory that is used to convert the tiled
+	 * data into linear, which the rest of the display can use to generate
+	 * the graphics output. One of the main features of this component is
+	 * that each pipe has a configurable DET buffer which means that when a
+	 * pipe is not enabled, the device can assign the memory to other
+	 * enabled pipes to try to be more efficient.
+	 *
+	 * DET logic is handled by dchubbub. Some ASICs provide a feature named
+	 * Configurable Return Buffer (CRB) segments which can be allocated to
+	 * compressed or detiled buffers.
+	 */
 	void (*program_det_size)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_in_kbyte);
 	void (*program_compbuf_size)(struct hubbub *hubbub, unsigned compbuf_size_kb, bool safe_to_increase);
 	void (*init_crb)(struct hubbub *hubbub);
-- 
2.35.1

