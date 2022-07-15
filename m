Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2938BC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E96710F8E6;
	Sat, 16 Jul 2022 14:35:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B1710E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccKHN93pHYI8vgAIr8a6pAL8pDOBEz8FUjKdyOmSkq9eZYEUfno50W7H7msnM6gSM1aaxQVuNnKjlV0ebPbao/msSvqL4ZsWkmrUE8IR9poHyiRsXZ4rt7RdCNK+IStUzEB5yGf9z55l4AWZgx/MKjyQD9+RWNL3KmAdFlXuPoUJ2ikxM/PEXv9a7G0QwnMdCWIdKKsQkjWCzF1yjl2mf77dD4MOmLFw6e2IDY3Xm6oJhG2NviH4Fsd+ERi50xlad4Tc3yLvCj2sDiD7u5Q9bQ/acnk8f1/dazBBmmB4OVR5I/ybVLUTQUMHk+C9RoZbMdLTk49lzgkhcr4r+rOSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njQT86dV7oEROGZJijjFTpq+0UXBB82dJ7lx7BAda5g=;
 b=oYZTGW0OOCf3J9aeuRbMbz0fe5fCXWb+vkKJhOVQRUjtbHdmDnd1ozIwtcfot3JmX2pLR6SfmD4rRzUF4NvXriHIED80Sp0Ce1u8QNeA0HF9JubTa4W60fdyGsJMJi/nZxJ9K6MMYsMWWxwDaG40sFc8oHRvh6w92Kxe5dn45gdR5cOmJlnBpiQak9zxV5GaX1oLIEzhfZ8vlgjFWLJIbLeclUh+k+Pvn05B8WLlEDXk5zVGDr39uo1bwdaltRoAhDnqfuW30VVFs+XA751B7NtxYoDVZnUabEAfv4AxJe/IWtSdb/Dz1HN5rL4+Fw799GyTKh2KiEbyFe3P3Le94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njQT86dV7oEROGZJijjFTpq+0UXBB82dJ7lx7BAda5g=;
 b=AotukjFrHJ0w2qzOMK1z3i3gn01AC1hNVQMzoAmfsdW7rn0kAGZiWf4Dkbh/0vhDza7eCAKcz6Ty+gLq3PTYqtYR1XZe+dw88sTZDB+O2maJliost7kxAMU7WwVuGEFOyxr4bUZw7RBSKURzYmf52Lc9AZ66RS0Rnm2Hn35qWQg=
Received: from DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:10 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::b9) by DM6PR21CA0020.outlook.office365.com
 (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.11 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:09 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/31] drm/amd/display: Remove unused variable
Date: Fri, 15 Jul 2022 14:16:36 -0400
Message-ID: <20220715181705.1030401-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f20f60-66de-410c-ae07-08da668e3bec
X-MS-TrafficTypeDiagnostic: CH2PR12MB3958:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ES0TPCOPnfk8lQ6cV05NJcjG11bM21G/ozaEd1+w5uvwZQJ+Na4X+nuKLLlO3i5qU//aMe5dcW77VUrTeY6C3FmnFj150I/sNtOo54qXRj2saHMfd44FDc23vpQZIBv3gWafLMUILjnzGgvv/nUyB2vm9wMyBVKmw3d6JsAK42bgZ7DlJEDB6ObtMaeWklQcNBBkiVPEWVheC+9uNEJnJO8q+T016l5WmmiuwhQMrIGSOigd771wruqDWg/GMlWkmteOneWNnWpCOyyO/xlFNqqUr7FLlyj6vLEebQwvW4r+jXfU+G+r+sp9WELGHrTWlOElysiHlq81oOXgcM9q7DooUt4NK5qM/OLe5w9OCBRIP8Xn2wwpKmVgR/uF7xVCVKOhyjtRpK06cTuGK9qlY+bhmZySHDOM856h4p95+Z6xt7/bWXKNV7W1prvIkaiIgUVJuYb/t/vMQydIT7JN+HJeSvcNQQZnO3sLbDRdMWLtUV1a0AHv9ECtZczBHQ/MMNoM1l09Wcdr+e9FU0LG1AROdJes4kj5eQ3d384s+jvTm3wmWB9VaeY4NY1pydkVJ+ZtFOVLw6o/h4dTvm3tDVn59gxo5Ot3pdVKbLutn6vdEIFrSvMSmNH2BI6SLwsXpIFrPNqowc3vhCckHn/Zo4P5w3Ai5dJq4SMBpMviOGR7ve//Lx/69zDnJ2iNDJ4fnzO8/Vc8jAd0STpsTMbPLTu+EaGDxxxweWOx/RYjXxmtwKWzg/FyojLBMpk2xZ6vxzBjg52tj/EksuoMLa1BL+45JLt3MX8aL0uLkZxm/ZeZ5lRuHu7Ztj6fHm06P2ieg1wwCZT+c69xLHvwr0YaZtXhvtTatOf1SYObmjwKdi0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(2906002)(47076005)(186003)(336012)(2616005)(26005)(426003)(83380400001)(1076003)(82740400003)(86362001)(356005)(40460700003)(40480700001)(81166007)(478600001)(6666004)(82310400005)(36860700001)(70586007)(5660300002)(70206006)(316002)(8936002)(36756003)(8676002)(4744005)(4326008)(41300700001)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:10.2008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f20f60-66de-410c-ae07-08da668e3bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3958
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

Remove an unused variable "remove_disconnect_edp" which was a workaround
bit.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Jun Lei <Jun.Lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7c42377f0aae..be41f9fcf1dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -683,7 +683,6 @@ struct dc_debug_options {
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
 	uint32_t edid_read_retry_times;
-	bool remove_disconnect_edp;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
-- 
2.37.0

