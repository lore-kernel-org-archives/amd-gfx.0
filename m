Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201B7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A799310EA40;
	Tue, 10 May 2022 20:46:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7DC10EA40
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0quEipySCkzMc6qExp7I8BEMgqZs37hy4uuFaCKfny6pmytkeDZkW4S0HWy0YQLs3fv6H4BAFlZbPPAgZgV+dYtSAu8wrAR9nbiZeMfOhWgFoycfN7Y8/CprT10OwtuZwtvalnSyemblFmgaHcLNOy7ctl5wRgEcsR+q1hivepiP0FGWR6t5NJ7jGFjMABDGVuuu6HXQo49YM0qiiLIK17/OnUV9YWO9pbfYrkOzJH3M3Zse5CfMY+NbDEaJ25QhrKvm/FX8n+DbgjVdKPjUklT77eccWboNgr8KL5Bwio4xtN3fYyq8K62NDgro6+BrTpIDTn1GjCZ0StUVMrT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STeAet7EGdu6Xppa7aOi5MtamkdmHN1guITFmpV5eII=;
 b=Kp4z5+Ln8AjjTX1nUZKLXGq3XEz5CgX3FBC2CGbMFGsItJD6LWCMFejYq1MTFfaKH2I8j+mqhVVtGNySWEiigy1MayjA81s1A8SAfXxQp4DY3gew0ObEtI/T9Z6L4hodm3Rsax4TUQHtO7+glIIQt9eaU5eOqaBir7TqFRSx9ocX1bBASaS5Y07oi6qeZH1mnq/CxtY5I8jQpMV7QXpJNNp733FdQX0rlsZWUl0YN7xdm8bnVCZ93KJkqS20efu/XEvcLwmIpI7T7lhPwX9RAjPtf678WN2tgWWt2olkr2S5K/hRnX9+q4PZ5S60w4YCRVqpWdBItEGAOYhqW/lHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STeAet7EGdu6Xppa7aOi5MtamkdmHN1guITFmpV5eII=;
 b=RfCbZ/+CdP9jwzhoUeVMg/wBOzQlSWEhSo2S0qpEadZv+2hFFNOO6ej1slDfmmDLepwrzVoAyRJbF999BCzkbTI66rOF/MMivYxbSzgk81igryzLwvalBwb9T5VAcwYNTnCGLaGp4uUtS7W1YACpAvtm01c/eVZiXHuVjHq0fEI=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by BN8PR12MB3283.namprd12.prod.outlook.com (2603:10b6:408:9f::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:46:52 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5b) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 20:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:49 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:47 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 18/19] drm/amd/display: expose AMD source specific DPCD for
 FreeSync PSR support
Date: Tue, 10 May 2022 16:45:07 -0400
Message-ID: <20220510204508.506089-19-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 989012f5-26fa-4d4d-c1de-08da32c635af
X-MS-TrafficTypeDiagnostic: BN8PR12MB3283:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3283D7AE295C2662934525DC8DC99@BN8PR12MB3283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1Fz0y8Zh3keY0TFW4jV3wpa9Xr6fGEisvgH5p0mQqhBV73pAM4t+lNtn7H3M7L+FDorzTrP3ctASvUWcKSeZWd5zyd1sTXgXFyzL/M57endCPWgB38/gumuZ6vBygEWOTq2RpSKkLyF11lZr6kx96uWAb6LmXQlicFNeeWolXuDbSWBIpYIcRi49pgAKVqJgt4o85ejX5EwcCa4B72GUCn4wkb2BcKL7w0vvvvIQdsLuSQ1ha/oXWojrr83XJzjjMtJyG9P2YFTQZ5BSfz5e186Qf7rbxi48+2GJqwzpT8wzrCw8z1lvEzvfHT1u1BF33WHEb0GxhA0/eCe46IzPsfdLAXtZpA9AgvUV9gSpgD4EXfg3h+tik1RQOnQ9tW4dzK3ekx+KzAoSurzRW4ZvGSzPawBaJessjK0CPceUiZX0ClHhq8C5tq4LnDzDDuDIar0Vt5fRcxHlrztNVQbEQIdB0xoevHhPAKPrDgEvuFXU5G3AvxbAlsXTs3AvFzXFJn7iaK+OkuGkPYjOX4Qpbk94h/b7j7Zc6I+5E32lxGBfzHMMM/RgZZW6zK2crLGtUmR0Nw84ssFWGGq4veUZMjuvHmwPrG/bdytwHRKIDWXcudFoaluYBMPe+JoeVS+eQltXwxF8JqTN+yFjlPDIOvNVe9d/PHpsCdtcQiSpjyD0ZOGJrAOvMSX79sR3iRiMSaHbhkrGm4CgFmjptDJPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(426003)(186003)(36756003)(82310400005)(336012)(36860700001)(70586007)(8936002)(40460700003)(26005)(5660300002)(2616005)(8676002)(4744005)(4326008)(1076003)(54906003)(86362001)(508600001)(6916009)(7696005)(81166007)(6666004)(2906002)(316002)(356005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:51.0096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989012f5-26fa-4d4d-c1de-08da32c635af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3283
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
The source specific DPCD exposure which is to set the sink device PSR
active vtotal control mode.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 73b9e0a87e54..054253286886 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -40,6 +40,7 @@
 
 #define DP_DEVICE_ID_38EC11 0x38EC11
 #define DP_FORCE_PSRSU_CAPABILITY 0x40F
+#define DP_SINK_PSR_ACTIVE_VTOTAL_CONTROL_MODE 0x375
 
 enum ddc_result {
 	DDC_RESULT_UNKNOWN = 0,
-- 
2.25.1

