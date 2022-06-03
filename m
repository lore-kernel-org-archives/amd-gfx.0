Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03485C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7315E1123F9;
	Fri,  3 Jun 2022 20:12:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3E1112419
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM6cRLcJOeTag29/hr63aQfAwZfZvayUhkNQTubwh8GUwLLEUoKcZdNBwlhoe3X77okCMkfPeKTZ7Z+1d5jH45pJlIA6pyk3Bt9NXi2UOhdSUAJX4bf8LdWgf50VQqvyc/rIzUsca0NY9xLtf04oVMYvjV2NzC6suYFevN4EmM0IsSlKgcpkG66Hy6QiQE4vzgi9NwIB1K4Xyelg6Co7Nwcv2v1VI5XeygQyMm4H9DiRPQ79121BL4cwEtFLNKWzisZHIMa8nSIgIU2M4+2+x2HmUJz0K6GlktinU9jML9XkVWy2wJz5X2jtQAVBRkscb9wscRMlFXmlp4yRfhghKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U1J3i2k9L0FQ1rhAXlnOb6iJLhuKGWrpskOcwkhuVw=;
 b=Z41/EzO4e0ayS6Z8U15w9ONilBKC0S/PkHTqcugXUdpybQGOqRWRBFqH/gbLa26jPmZFFZmTT0ww4oOd74UdahLMkiYhGS/tch9osgtJCCSdveFZONVDPyvo+zM1DS6e/fDcsTMxBrDTOeCndgiznl8MGieMQZ20smPiK96o8AdHHaPwjUgzUi/UnPPk/VEopfuU0QZ97qXmvm12dy73cnuzMFpDVU5lnjWWK46CimWiuP4Wcq3D3yz4i2IYTRmAugLiPlPD9ikFShY89INpZl3gU4p1uIErlwCs7GjYhCEWk5zkwxZlgNxuaX1gTx7BwKSQ13o28KNfCsdsGu6UxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U1J3i2k9L0FQ1rhAXlnOb6iJLhuKGWrpskOcwkhuVw=;
 b=nqVT0xvwSATv7rZ3nyzmrsQHS/dHrIsJauHfYnfztC58g4D0X8RxBGjtIFPhDmqoil1c92EaG0tMT5JRtZjC8FgRFptRdLqZX5N4T8bF7H12xe7KoSih3d9fVVuUitjvZjv0z+B5xTWw68q+ve+9H5KL+dp+DrG6ATm3bqJAR5A=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by DM5PR1201MB0074.namprd12.prod.outlook.com (2603:10b6:4:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 20:12:40 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::af) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.6 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:38 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: [FW Promotion] Release 0.0.119.0
Date: Fri, 3 Jun 2022 16:11:40 -0400
Message-ID: <20220603201147.121817-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f919eacd-781d-4e8f-faf3-08da459d68fb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0074:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0074478184D8F41E34E2660AF4A19@DM5PR1201MB0074.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toHFWFivDynTCcEgNk0QJvcSVFd7l7ULHlb+hUMJECosqh6Mr4bqW/Q5ZPxidj/6XvpLXxCmj81iPw6h2+K1+/Cl/ezAC/9k+4nkO55B2IR3hn1OQiXNlrRR5Lr37am4FCJ097tiNEFVx5y6gdryIGbhk0RpgJxCUJn0YaJGNbo50ktjkF/uI82BE4tfdgg1tbPR7vxsUhOjTyYodxAQOSliy2tqkdp86m3dlLdfmV7mWxvG0zZTibLeYObmMcE8jCKJxp3bciaic3jBhpuM3HHRE7e+SXiRaRQp6IfMfB1SKCICHwkDwszRsUf1F2iAmbJnXhikadwFppIHQ3Rc0EmJkggsHIA8v/LYm/SXNDPBP+m4pADMa4C5rDR+Js7whge5Svdv5pA7V7LusIwMM/0OsaS5eo9BNlRiTrCcsi4zhoqDZtLDPYQlOLvxHAG4voDnWkIYxMm+Y5zdc0jR7+lIYX+ySS0S6comvWM6vFyVD+/VaSh8x5PEHado+N1tlQmVG9mFGpVx9vQKvFklySQfg+QJDDj1T0z7lp9RsQnEZPvqXupbZKQO+EyOX6eI37INvL3rB1cE+5P5hsB8auobBm3WfCpm88DH0uTIdWMilq0moBdV/5MVtfHM83vxwT7RNFOLXD4wqhREmS2P+4tz+Ndww6IfSP8UJKW6MD6HnHQbacMP+thR4paGSMQiQs7FFIbTb09QlIkvQJrUSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(1076003)(16526019)(508600001)(356005)(336012)(40460700003)(6666004)(8936002)(186003)(82310400005)(6916009)(54906003)(36756003)(86362001)(316002)(5660300002)(47076005)(4744005)(70586007)(36860700001)(426003)(26005)(2906002)(44832011)(8676002)(4326008)(2616005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:39.8935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f919eacd-781d-4e8f-faf3-08da459d68fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0074
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 385c28238beb..46ac6d2c5ff6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1363,6 +1363,7 @@ struct dmub_rb_cmd_dp_set_config_reply {
 struct dmub_cmd_hpd_state_query_data {
 	uint8_t instance; /**< HPD instance or DPIA instance */
 	uint8_t result; /**< For returning HPD state */
+	uint16_t pad; /** < Alignment */
 	enum aux_channel_type ch_type; /**< enum aux_channel_type */
 	enum aux_return_code_type status; /**< for returning the status of command */
 };
-- 
2.36.1

