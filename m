Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B8C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8075010E406;
	Wed, 17 May 2023 11:41:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D1010E406
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTLlL9sWqTM7yYDbCWuV4sOwBjz+aEp5F2o0qSzxCZ+jeVPY0M4MSXlsm+f6Y4ds9k0J1iYzqfbTmZJCgKr5Do/5ktO3GqrRtXEyYSHrnintWtNn1Y0S1Ymg8zil9oEGVcDrUSOU6U81yXWJcTNdG0Yofw5m16fnrdY5Ge2OPPCRboCfVjii+Zf81IvJG/e+qd19ax2E2O1+xkrUlcxCnoG1bBe/quDtR9+0lHj4+GfU+fqALM8iIW1cXzoiBUeB2epuHOJ9yd99bA6sn81NpkezJkRdBi8126mOm4jGxkM+1w5s2E2u+/85/C/6ftm6vlmRu1NBn5lD4jwwOrkf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae7hYXGNZe89SJT4/XFZ8JlBOWuxjt+hJeJQfna3vLs=;
 b=UkSsQ/Hs2k9wtg6TSFIflWIuHhrVqb/Lb38U2Hw5PIWRH4//wlybp50SrxMH0Mm2g/v1nv4vCNnECd+Reok0eni9+HL52UBK8/mCs+2SsYhcKV+BsaPy9mNrPKtAcDLRdckeTKQbNrpN9WBaD35tRPPPfctKGrWBtbz+Ws74yV7iJjrW91KavW++cFuns6FW3GS3MaWCRxO+Fya6Ck8pLB6Yr+E22GnUunrAFIkE1zJlfXnXmNmnT3jx8ZTIpj88oa0d4LAwED3Al2JNqldTjwEII4jqVS+I0ssxvhOUiAnP3kphQ4mMdTfwhZUGz5TBHf/7qZaNDPPYxLfkyl/NdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae7hYXGNZe89SJT4/XFZ8JlBOWuxjt+hJeJQfna3vLs=;
 b=W7b4ipuZV/MbexTQc5symoTnqONJatBEhITAe8p8J+up4QIn7V+g9itDE/iiI+suoeZWCAlBnEJoHzuOvup2/gA1kgZzauF7hEUN29hFVOCuBnO3wuFZBi570dvldaxC3Q2E50homsQa9pu6O21/V5qh+7uTQ8GTpNV+1FPbyXA=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Wed, 17 May
 2023 11:41:17 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:332:cafe::7) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Wed, 17 May 2023 11:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 11:41:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:41:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:40:39 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:40:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/18] drm/amd/display: cache trace buffer size
Date: Wed, 17 May 2023 19:37:22 +0800
Message-ID: <20230517113723.1757259-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c83f2fe-8b59-4fe0-a20b-08db56cba039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVD7+K0l/zxtsLwAiw7Bg4jOw7EIVsul8zDLF+iGekww+8ZLAO/siiD27ASoeqhrpJjKSeDpzNZuDl6QmK/nGgmoFAABh2bXh3UGG1HFqMt/z7MovUbFBAHtYC7u9wN9twUpbNrmXM3UrOFoP4DmPbgqntSsvS6j2tQKyd4h7252n8CTiN2K2S4FIaaUgzLr5XDVcDtBmFo34MFhjXv+FTQnji0NIScm/G2uWs681JBKjQKrb9UEkp/WZjztfV95xu+IQtsagHhEiukiIg8/IcY6tG8HLpmSOdzYQKgZLKz8PMkRtQeHAZsqZmdvhbn0c36Jj2SNk2NugEchdAR7NVTJpKTKN0J9qs4ATzHJF93Ko+sw+SE3upFTL98Z5dc4RBh4Qgmxot8yeOngq4K7zyJPsXCAayCVV0Pj83ev/yUwHzka4phCQKXfQSbjrisuxHqyYPs1PFRiWiAI1ynN11cTjUbpQfHqRkxpoV2D/xTVm/1Mcgog1WgBCDWPVeoSHdiGzgy/wQiSwoTYlLotu5GLNPi5IlpzgEskhBm1rqcIOp1whZP9GPcPMkxwfZQFSkVMmx65wlw2VIu5r7PF/TOwURxTmZLyNKeYw/soykpddffSS6VklHVMw+WdPl+KNQ+HoI+1Xy3Na2qUJBvL0+YSSejkEa1cCcpTsivfZRZUgY1pBfBQbipmUy4WZCqngY23WkItS4UfnGrMknw0bFSws4kQpWAHF4BJTIgAT4BQjoFa/QmQeLhYnoHKL/eo77apkghA9WN6eMb4SxTnsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(2616005)(186003)(41300700001)(1076003)(426003)(336012)(6666004)(7696005)(47076005)(36860700001)(26005)(40460700003)(54906003)(8676002)(478600001)(4326008)(6916009)(40480700001)(81166007)(70586007)(70206006)(356005)(5660300002)(86362001)(316002)(82310400005)(36756003)(2906002)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:41:16.8601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c83f2fe-8b59-4fe0-a20b-08db56cba039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
Cc: stylon.wang@amd.com, Josip Pavic <josip.pavic@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Aric Cyr <aric.cyr@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <josip.pavic@amd.com>

[Why & How]
Cache the trace buffer size retrieved from DMUB FW in the driver

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7c9a2b34bd05..e210cb082ebd 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -428,6 +428,7 @@ struct dmub_srv {
 	enum dmub_asic asic;
 	void *user_ctx;
 	uint32_t fw_version;
+	uint32_t trace_buffer_size;
 	bool is_virtual;
 	struct dmub_fb scratch_mem_fb;
 	volatile const struct dmub_fw_state *fw_state;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9e9a6a44a7ac..8b9af18e84fe 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -427,6 +427,8 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			dmub->fw_version = fw_info->fw_version;
 	}
 
+	dmub->trace_buffer_size = trace_buffer_size;
+
 	trace_buff->base = dmub_align(mail->top, 256);
 	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
-- 
2.25.1

