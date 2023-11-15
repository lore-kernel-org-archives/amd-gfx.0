Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08461C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9880410E594;
	Wed, 15 Nov 2023 19:44:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B218210E590
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxLNYKkX0fQdL0PhMOsT7sal8fqO7PNS5OuNxongq5VM1D+EVd4w0m9c3UaJa8GDNPYuoDY5Vo2RJdCXoisXcOknXlBYBwaCGpnIENS31q7gxDO6R1dnfvVBwo7C0PiHuMtxoxnCdF735W+0cJETd/W41YPGMBdPS+99ZwlAhwvFu1tp3A/NOagVwxJzjSFWdFyqtNYirr25zBfPJ0BSfPke+NBQXzhX59SIcDuNTk6EuZA/4fZ/qCnbvcBdnvYuIiVrg7O+c0pRjnPunW5HH9Y7VB+aFdxZmm3eQBrzEB8WLzN1t2EL5ewYgYV/bobtN/8gFuFEmvp178eWecUUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkc2eHmMapxVylRyYOlhwPTOZl3IS0SaP2GuD0emC0E=;
 b=RQpuW7qyK+sM6bkDSNKHO63oHctfWTfXc07qgcuxf/C5dyuQROMYq3dU6I/JLN2UlqtyKZ0QtyIydrgowAvJI1huI0424vN+OP8+GORJ77kJsxRbB3WwCQ0bKRAy2+kZt894zLqAZdgvVLQdeXSiHRdm4C/PmShcQCN2iQOJemWFXmvVwbFkdxsSy2PV1JA/kERDrbYPle6Lzzoz3sF2aUftv17yi0YeSnBIQNvLnUAmHuslfdAvchadBZQY7sXNqZn9ybzbwQvLGmgJvt6KoLh0z3WI+xDi3jPdT00nvxmgC3Y6XdeShVVdu0Jm2rEHBDCrJMe5X++NQGH9ufStSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkc2eHmMapxVylRyYOlhwPTOZl3IS0SaP2GuD0emC0E=;
 b=z/YNspbokR0jzaDKJ6cibPpN+tpylRnaRfXJy7cXq1Pc9Mdo9axBn2LXj4zJ/OVmCgdkzx+3XyoxgRwtKRJENmM768H+ig0ZJaLcIipS+MSYfNfGK8gE+VyZrrNlWocuHeL15LTrYvtCQZsPE8L4SzkFO/pDaLx+hJ8A9tAfKj0=
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:50 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::76) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:50 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:48 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/35] drm/amd/display: 3.2.261
Date: Wed, 15 Nov 2023 14:40:48 -0500
Message-ID: <20231115194332.39469-36-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: b80b5c79-a208-44a6-52a2-08dbe61354ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEVlUQyi0iaNHEUKnM8+kRt4FdD1IcowcA8bTKnEwp9z3vSIagrXjdIFp6BcJR35EnGAQ3lQq+DsUDwwORwXBxfSpkmP8/Zjxu1gkwT7RD6vIQ/gvyFmR9tScqxOoCHm27ejLER1J4IV6OlYY/8tBFykSZJwBYSSEt7cLSNRp8lTe+2OQn3+6AQOOJFfAGX8+YMLhG897Jnm2unZw81TI5w6nmL0vhBjxuZkY1+U3fRjGIjcA+Z0tzU5fJQIC9KOgGedjzO3PQ8JWQLugSbeFmBapssoZa9G0SfWNm7aObPg6rX6aWD4N+HcbEElQGQmJy95MpsSXnoSbMfwIkNLpQMoTqmshTbZXlanajCK0o3BTclT4jfna4pkDZ3ILn9FG+Ig8JZ0Krus3H5/gxNTHDSYvMktbpn9vgpuZ8c8zXb0w5yPkhmyfWv/RQuVlyVLrLOaTWf3WZ4+cKVOFMSeE+rgngMBDEIoquov0MYn/UXecwCYhuURhjw7SVmVAGAsEsaEGluwfpo2M05ElkLELLlBosz/lrjtxW2jk4hfoxmUjHDJd9SRdt/VVOlhBJI3WAnGqXRcHWkzegQtI8qGU03P7QpaGnNMrnYmVEyYxzVNzauPk+jyB5mEvx7Mzl8xiT/J08kH74WvSamTiZ1lUKwebymeHDL7TS7hzP7OUjMu+lrO8/pCJMQoW4lqywrmkLm4/WvmNO0iQlB4DRjXFfdXhyH/9vCDjmnCjet7aivTTxJteywuxIEAGuVxDGHJkd0A9Pd+uNQZdmMN39NCINO4lYgqsMjzSVbLOktX+JQlgztm6Hr0n0lRyCa1RJWY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(40460700003)(2616005)(83380400001)(8936002)(54906003)(8676002)(47076005)(4326008)(316002)(16526019)(1076003)(26005)(70586007)(70206006)(6916009)(336012)(478600001)(426003)(4744005)(86362001)(81166007)(82740400003)(356005)(41300700001)(5660300002)(36860700001)(2906002)(44832011)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:50.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80b5c79-a208-44a6-52a2-08dbe61354ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
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
Cc: stylon.wang@amd.com, Aric
 Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- DCN314 fixes
- DCN32 fixes
- DCN35 fixes
- DML2 fixes
- eDP fixes
- HDR fixes
- MST fixes
- Replay fixes
- SubVP support for more configs

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index abaf23c1cedd..f3c3e0935ad0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.260"
+#define DC_VER "3.2.261"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.42.0

