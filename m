Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6C1C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B49210FCB7;
	Wed, 31 Jan 2024 20:15:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C0010FC99
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkRBD9j6BG28+c7laesw3UYH9OJp47+7Ckc/9Le2JiLGZF8Ka4bj0dt++bd0shI6QexrP58SBA/5vog/J1zsH9VeUcvH8731a5IKkXgVytK20HJV4x0ZkQMb2cOqk9KRczzbOy4hYDVy/NPIe7W1KenrrbC9LdVkj1GBK+uxGVDATMX33LHs7fmnUZOj4b2HntEsppjE2Tmk/iSvWgHuIyDrWKeUs4EuT1Cu93tGpaDBwhNNBMzIIbV8Yfc1Gn36oWNonq4+6azcQ4Uf721w98EoF7Qjc38opPKimS/jvJAfUo5WgbPKfiTgT+XoajizeLZa0qdGoHn+eUydv38PiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdgaDNSZO3mEZHPjtJ7sbdSX/KZXhOmumjYmNSnRDnc=;
 b=nhqlcEiykIuFWhX5Tf8MqtBmFepRg8fNvVZYrpr6fFya5ZrH2LqNFnn5IyIggj/uIzZBO8Ye/L1k4nCH8xGmhUl/aJhVaIbilLkFxDEx0759aGpNKEsVV/kR/sWghGvVJahr5wrueFW79+gOIsXe0MtOvT8mzv+megltgM4me30ytpHyOL720tPJm7E6cZeILXFEHZY3NlDY2qRRvi9oU8mP5PR468l0N7Uqfk1pagtzcKmg4DyFImmJ/lNy6HKM7mYcuE3aVCyZzs1u/Hzuk5aN/6V6PEkZ4Bw1wO3v3+mz0aPpjzrdPXd+yD6+f+4+7BtgxdjD5nG9WIWlqTqcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdgaDNSZO3mEZHPjtJ7sbdSX/KZXhOmumjYmNSnRDnc=;
 b=Ux5IyVqOwV3YUE0liuTgwM4SWyeKKhDEnpEkIYjos73nd8idsFGte3qBhLq9q8Jt6J+OgsLGip+uDOK0X18yhUHnCvlzDAbjFNp8il5VIej7wg9t/CfbVqcrRKttqiMVVE/wgNm9dXADZMLcddEeXYrz8EmWCEC9l1xcNA9cmCs=
Received: from SN7PR18CA0027.namprd18.prod.outlook.com (2603:10b6:806:f3::22)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:14:50 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::5f) by SN7PR18CA0027.outlook.office365.com
 (2603:10b6:806:f3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:50 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:47 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amd/display: correct comment in
 set_default_brightness_aux()
Date: Wed, 31 Jan 2024 15:11:17 -0500
Message-ID: <20240131201220.19106-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a55c762-6629-47b1-5bff-08dc22994764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVbBz/TAtTwCEiC1Q6X37j8imRUWuB63A9dtoIH4XXoYfUmFxUhE+u5jem60I+bAkVF23HwMbsr71Lij5l6A5WzmnSTL7kInXTNiJNlMdh6W1crA6okBF/jWhEp/q0H+qcpgucKTvhqtYZfZ3/fLYKF0j17nCvTCyG2x4fIYx2q2pSbN1suUy0/IC0SzFxmxe42IWLAN2+Ft9s+YRfzaWpQK1ErJYfad0br7doiv6H4eVG+JGlWBxt0NKILgREfiahQWbqo3/UtjqzgBGvXGa6Kl/JAFMwpFrjs5ixeNiaclnxP2Zby7Ah1GuXyKeOf3n6r9lROYzvt93pZd1N5PIIEenWr0bZwqDtUB4b7e1ERnq8U6CHStNUROzcJ9eWxgZX9M+7H8eN9wPmUGVChkK91SofrJqUBDmsPcTIZYvaA2gmqzDWSBZrUjKfg8kOD4bG+W6FThTmMgSbejZuxXDU33lD+s+fY39BeHflVN9163ael3fU5i9ALIbeU5G84AM9utabM0AVhj4XLoDMbSQNvW2IGThHi/zJall92Qhk9ueQN1RZgh6prpWalk7oXWgJtLJULuqOxNJTNGCLXgPCQdWAWa8F5OeIyw33V7CPdsW9pxcjFS8mY6ExyPJFrYmXr8gnYZ6A98m2lasarbm7gWr8kGZstcs7dADtO9PxLELt8hQb+JkrszIU+WYz+JtXpElP82ZKtiS2R20EOFdPeAp9nFZtuXTDDAj0e69YAdo/tGy8tUlolzwrKbJxHG8SvK6T8rxlmaj//ypIzmK5BMvdunfna9yXJBLxlbrigVkph7JVr0J8TBFZKFXhKz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(70586007)(54906003)(70206006)(47076005)(44832011)(478600001)(6916009)(8676002)(316002)(6666004)(8936002)(4326008)(1076003)(336012)(2616005)(426003)(2906002)(83380400001)(5660300002)(82740400003)(26005)(36860700001)(16526019)(86362001)(81166007)(356005)(40460700003)(36756003)(40480700001)(41300700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:50.1617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a55c762-6629-47b1-5bff-08dc22994764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, Camille Cho <camille.cho@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Camille Cho <camille.cho@amd.com>

0 nits is a valid default value for OLED panels. So, update the relevant
comment to account for that fact.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Camille Cho <camille.cho@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 046d3e205415..443215b96308 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -287,7 +287,7 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if < 1 nits or > 5000, it might be wrong readback
+		// if > 5000, it might be wrong readback. 0 nits is a valid default value for OLED panel.
 		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000;
 
-- 
2.43.0

