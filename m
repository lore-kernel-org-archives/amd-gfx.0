Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE41F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D090510E303;
	Fri,  6 Mar 2026 03:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jcoHW0ph";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C4810E303
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqRBXjGkpGwXbzfwRJHR3qn0dzjkW5BzchSFdjyKhHlc0ZV9hY3ecjKzCzA5PMy/pKADtZQa6HEQFnurnFAGhfvyvoAOa4snRljM+7hSAcuOmJj314QOlHuEDxFN2t0fJfwiRWlNvUWUxZOL2ttc6pk3ygSSEw78Bh36UOvnBpYYQ3eAbbj+jp2uIAmJqazTQLII7LsaOK6o1su4reG1VYfZrzX576W6cWxbYnruyLX7fbsilXi4v7/tWmnVjGFRZUjVgLPdOUVh5Tx7CEcYND5N8TUC2lOcGCLX7e5b4UmTQFGzQOWKDdMuEK7QUyNHd4pwgXw9eC1kue/uSVNL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iev2CLFH4iiTyxc3CMbQ8WDm2mWbsxSignzvAxq1lYo=;
 b=A3bonvxir+VepgguJK6QUkRovmoiAB4zr/c1RIwHz8hkjfcj+nRRnZ8+5gGDkrJNTl5LY/GwQgte+e7X1m4AKhs1AM7Wl3sjqj5iyyVIKUxJZ+lq/8HVwOZIZ4EdSfS35UiGCo5jevj6/Vh6qplRyJrKXvIFEWOSR5LvhLOMyVW3c7uEozpYtMIBroa78PIX3sD/AjETRpV+C8jTSynuasjTrhms3FPhoaIPFIw4mgirjZq5l2Dg0XnoLtwLNAcf9mcZ3ce9seuaxh7kPn+ddRcQZ3nbon9/g9jAZr17yBcFrMsUcVlQ7Ht5fQ7t6d1RIgF1XDxEi28zdHkAHl9aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iev2CLFH4iiTyxc3CMbQ8WDm2mWbsxSignzvAxq1lYo=;
 b=jcoHW0phLt30NdFELijkxHtKYgbUHrAb2zGBfS4ov6zYUEK+yr6Z5/WHz1Qk/eL2tj0xv/IxrSelTxT3z2MT0zQAXaY3dgTpSnFjohh6r+qpMD4sPY+nXM3zTj36TvB8raUumOHQCWa0VtBN4Snr+6jR0p9opopLFbh/9KDLG7E=
Received: from BY3PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:217::11)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:26:34 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::fe) by BY3PR04CA0006.outlook.office365.com
 (2603:10b6:a03:217::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 03:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:26:33 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:26:28 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 12/21] drm/amd/display: Add documentation and cleanup DMUB HW
 lock manager
Date: Thu, 5 Mar 2026 20:13:38 -0700
Message-ID: <20260306031932.136179-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: ca63f2ca-20f8-4529-c29f-08de7b302aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: blc5cncOx3NZHR2GHMWMtfaBLOi5z8pXQWIb4GrYIllSu0l76ZQ4Lkc8YIEteIL2mLAqfHA/HoAanx0rN/JkMcIOl5WPC2jrE7hCmY6gT1cWGDXAhJ5GVsXLHaf3704FWLh7Z75KWnHLZn8ChpLbfZshLz6xgrIraHrER0Bm5FiUH3kNELXb8myGysKLXixq3AixEblNO9lbdNLPubV6fv3OAjFCHvcdZb1yGUmulbZXpE+6wPZucnminaUdhM05T1NenZ08Qe+FaGw8guJ42WwNOI4yKkH28hOCiuU9AwNSc9sQwswlT2B1hDqMYXeOaIiFmMFKAPbZCt872Y5unfOXzi/s13qXK5GfmJioBuzOY0I/CfxSXdxTkoRXXb2z0uy1WEdM98/Ef+InIwmV8stEnAGwv+i855d+fdfTVFsS9aM+fSvVtZJB59/TmLiLy2LnQXu9ez6l9uvFKuetyzANgez3lxM+cuprSjyodOfJy7G+JQLZQ8KBs2ABmI8/tEeuXFRlKn8TfsoDzQOHZpaxdmwMcPgw10WGrT8irgX01QQk83H2l5tcPa55rOUauNNmrDuxjsq8x8s48wH1bBaL7ameFFT3yGcWaJeQICBk5UJUzcg8sbiKUPqhy28ElDQp7PsHdYd1cKTPNnebWHMRL3prxUNhD554RcKVwdvDTdw5tZwLCK5kaPP+pOIrOnNNChdb2jayk2ZmKNQGg6OehfURw+b9CEzq9NrdM4jNhTFVkxXL566jAYjhSGbWmA0CvDrmiQDx9QJrs1cF+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SzIrROXXI5MUTmJuVxYXgsKb4TsDpkILNrJIQ45qn78exb995unOfy8twYaFhyrUeHPjG94HZGxbeEAOo05MkUOKhuvSGa3+PLS6cjettfQZ48WqvnP46CvDJ2Z4op+gM/6qp6BbQQgtGNgSkcNcwKeklm0iTKu6Qvby8RpZSZihX+eVUEfgAE66px6WxNsjIO5jN3Rf27VIdZzmwdMt9+x8Rw8E+gbkg6Ulsrbg/vWgPIWHWjTq5mjgRG+c28wYbP+bcC5fVbtNaYb7/dxpkIrq8RePolpLIaQTlz8uNzJUEOSp+I4B2J7+KKJXCPnGouQK1rmOmWUET37uhp16xzTZh3Sim1a0NsOi+UfnoI6I0tAXxwojyId62Ad9Sw9Vlktvti8/XjlylXlfhfOn1Srr1f6B0wCZ/ZJnurmWFXt9KT9ie1NVDA0/pQmneWZf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:26:33.6291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca63f2ca-20f8-4529-c29f-08de7b302aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

To document how the helpers should be used before a subsequent change
adds new locations that these helpers will be used.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
index 4c80ca8484ad..9495857902ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
@@ -46,7 +46,25 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
  * Return: true if the inbox1 lock should be used, false otherwise
  */
 bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link);
+
+/**
+ * dmub_hw_lock_mgr_does_link_require_lock() - Returns true if the link has a feature that needs the HW lock.
+ *
+ * @dc: Pointer to DC object
+ * @link: The link to check
+ *
+ * Return: true if the link has a feature that needs the HW lock, false otherwise
+ */
 bool dmub_hw_lock_mgr_does_link_require_lock(const struct dc *dc, const struct dc_link *link);
+
+/**
+ * dmub_hw_lock_mgr_does_context_require_lock() - Returns true if the context has any stream that needs the HW lock.
+ *
+ * @dc: Pointer to DC object
+ * @context: The context to check
+ *
+ * Return: true if the context has any stream that needs the HW lock, false otherwise
+ */
 bool dmub_hw_lock_mgr_does_context_require_lock(const struct dc *dc, const struct dc_state *context);
 
 #endif /*_DMUB_HW_LOCK_MGR_H_ */
-- 
2.43.0

