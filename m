Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFFCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC0210E2AF;
	Thu,  5 May 2022 14:23:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAF710E3A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUmhow/WjUihjPoY8+ptIQicFhQsRh0e8gL/lvBpWUm1pQ44ZfDn+K8op6EW1n7GGLwHWN8rQNRRFslKWAy29HUZARiD2yoTNBMjK7Xsooqfw7qQwShcGhPTu46jxFxm9/O++XkUb1dCWQ3FIXkp10Nc2VcykkBpM8TwZa9PHdVcPZpv0hiiHJZJiz/iC7RwXEY3It2GCrr+Lh0NUEgltq5nGLeKAykyTkkBQ3UWSPe0adrHY8WF0D61alzSLAdIO9O3Qk7PMnceDHb4Eywv6z0RXCjn5ATnAfUEp9moDd8Qdm93jasVarz/aJ/Ox4G85Kw43QSJU/4s3RBE2FCV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr4sVRH+iQ6fgOZyONe4GEtAdhtwDCYkq5Z6cF60FC4=;
 b=JjuwmtHzJOudvDsG5jmPFiebwquIe2vMvnb6nRpjvUpxqcTy87NhVy2bxDC1B986+gTDrjswDhTtmj6lFl2DG9370Y0P8WG2cLIGQFTY7O52ljTbvN67AD7b1VVPY5wcVHEvVuBz8S1iCVzLwYZlOiRuthL1AL89w4Fk0DpJdxdX+TSf3w8BXyswuG6N4T1q/oP2uOqycsqY++/+AeWvf8qzzRo9KIqTRjf/Pl4iOqQWh9h3t99de30isWiw7SmvpuJaNX3jU7UV5qwIg0odls1N/5sNc1+f5Epnuh5QN0jrAMur0tjZNnceDwvrybhg23HZ/bva4Yu+13iq9IdCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr4sVRH+iQ6fgOZyONe4GEtAdhtwDCYkq5Z6cF60FC4=;
 b=iVJ2qpK/Pq5cORCo2CV7CYrVTXTF0yGx1a27B2qTEkCAjQT5i+VCI8ZRQqSiyLPIstBlg+PYucZqYUJEA5otN3/YKcLZyu+yhK4oYeTCDfMgwbu/9IseqvfLKXmIMUXvdRbehxcKlvgehU5kcKl0vxT2VNc1Qi7Fpn2/QmRkeHU=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 14:23:51 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::40) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 14:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:51 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:49 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/17] drm/amd/display: Set default value of
 line_capture_indication
Date: Thu, 5 May 2022 10:23:14 -0400
Message-ID: <20220505142323.2566949-9-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cc98207-27d0-4c5f-99f0-08da2ea2e070
X-MS-TrafficTypeDiagnostic: DM4PR12MB5376:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53768282CAA421FA0CBB65DC8DC29@DM4PR12MB5376.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u62gI6uDIamcDul3aAedq7kx3DrAQ7PTGO4+M5h7UgX+TKUMEO9SzkQrAbc+dp1v2k6ffz2CuXCblGV9cbUkaBRRpdw+RSZUC4zwE7Gzc1T3PPF/WrH2SOzrs7lK2jm7xhiVm6JSWB3OHtN0+oiZXj4VyRZ2BS8YQGdDhSHBHo94QUcq8PMKSmFGlm9ml30f8V5WRWtB7mh+H0mkTsSscj949v0cZs1hxoza3wK0Ft5tJZdGTa4miUGHRWm8hVOOFc09g2HGPAyLFHkobR2rLoReJhLYK1iyAH31cnACaN/aP2OtLkPVwsFJCNjzjeo6V4Yl7z6a5qL5e8bISKsfEmu41GavJpdIt3hnjWWMBa6Nu3WSOtxGSQzgLOTiSudRQvjy2BsgUgbGXVC/q4G7yeQDvLBqD7FIUfdthtu0t/AytAD/giPEWM7adN5BCcIKKwW0YCHmPqBLtbvbw2OZ8HYABVLblsD/5wtP89T0uz2W1LdENuEvdFQEzXx1gL5J0U4xsmIiAhqmad7sqCBskhkZCU1MyKnXISoO1FkCjesJ2bOltSOoM6eWNit7EOnMimm216g3dxTuGTZaT1VPb7fOFhSDCob/W0NVNVS55lQG38qRkemUrHsZR+sg9uThN43YjEoI9UBBl1yGPiBfRih8mMZYSuoG7ihBZ5bW/hkyql02DyKQRlad/w+euCqFq4DqDttzvm0VYZk/zq/tFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(70586007)(70206006)(356005)(508600001)(16526019)(8676002)(8936002)(81166007)(186003)(40460700003)(2616005)(36860700001)(2906002)(54906003)(6916009)(36756003)(82310400005)(7696005)(47076005)(336012)(6666004)(426003)(316002)(26005)(4744005)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:51.0464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc98207-27d0-4c5f-99f0-08da2ea2e070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & how]
We only support line capture indication as 0 for PSRSU

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 6883dd5b80d6..bc4943205bce 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -339,6 +339,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	else
 		copy_settings_data->su_y_granularity = psr_context->su_y_granularity;
 
+	copy_settings_data->line_capture_indication = 0;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
-- 
2.25.1

