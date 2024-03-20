Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE46C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194F110EEF8;
	Wed, 20 Mar 2024 06:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JxlR7ys3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B6F10EEED
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXyx1311k6fuYfK0qJ+dkJQl+Dlt6eBYYr38Rjxt+Hlr+A4qFez5rg38vzCEyywlp8YHjQ2NcXVT0Sn7/87g2Up4GUxWqhrvUGwR6hGqg2Gp1ubf/ieQDG+w/UgxDiNJSykKS9AJQWwQ76g+YM9oD3d7DqCnI1RRLZGTT5V83FLNTbZzhUcHAHVoeNCRCNP22RzqqfpNAOuNDDREoJ6joAevGGw1CH6IuhTvdHBrcCsxzuyCqRyiB8a+3qQOt5Bev/4Mdom+K/i+cUG4U/Apzp+SbRRGaaDfOGoP209x0cZHjp+gC1PgGI4OEEIkU98T7p6FjiWXWrQTkyr2ev4VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VuQyTv1EdF2LYI1RflxqVbbkusI+s5osqHp24KV+/c=;
 b=AeKGZ6b+xwefHCpYGOwY5+ZkgXoXj1L1fAirYGueLscyOhs0WBs4b6qj2baQpFkNKTwYjw+VKej3o2m5XHHBAgFCpkiFYtd0rb2LTTBamT5TXAK5KcxCWdcWhAvyIJfPhsol6SCAz2mMGBaFQTPSWJwdK9qYIcqVs++A1uXKfWwKnjcecDh844/ku7ait7LwnrIEH3vKgZYfDQw7WTNMEDgtxhLHE17nEy3AcQwQ0ooa/xnr/Zdmg5aubg6mr8auWEyYoeYjlXFqw9LQwFQX+yvYGeSLKuzxb5f/HefTC/1Evo0Z6e5h9aCjvKDBrE9EDP0rFrt77113gqf4zVr2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VuQyTv1EdF2LYI1RflxqVbbkusI+s5osqHp24KV+/c=;
 b=JxlR7ys3Vrb8zWWw63Zc31LU70/y+wyKnxqTmL5L5gmdTAG9YWyNwNAbyKJf1vxah2GxdWPxtx7H6xTK+C856m4ftiEVBeqzDUFguIXK3KRKuS3p4jQxVnWiOdKFHOwVJ6iZSVIrFpE2i3pjtl7Q7BVkhVJ1u+RKjFm6A5TT7v4=
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 06:37:34 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::40) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:31 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:28 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 22/22] drm/amd/display: 3.2.278
Date: Wed, 20 Mar 2024 14:35:56 +0800
Message-ID: <20240320063556.1326615-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: e934867e-479f-45e1-9969-08dc48a839b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2oMFf1k6OB2N6dJvB/DNWOhwDgZpcMSMvuXdGE1phJsmAsdOEs7I2etp4HGVrev/oGTo3qh+JLU3PsoXqOkrtAN0iAdVrCbXkqZoS6vm8l2u3xna3t0j7S1MRjHxIn+Kp06eiMR5Z4QTEu8vleINMOzyjzcHVQSjrAH5Sa3whhwz8On7E3w5q6fauFxe2b7B9SgXFTsbl6CJLxij5xHhsbD6FnuywGUDXsJ2nrGq1Kp9s3DXNojqMGJBNuoe/KQQJbM1141qGWwPcf9U+sSflrEL9KkAsk51nSjovo/o5YPwePQb/vqLzoJI4HLah/No6FlS7CZo0Z4EEyvO3zUGF/K64LTMHksVdcQ5yajjEZy891ik60vs70D2L9FRbsKxtmoIU1dvRF8dHmMIvJm5DUJQwzq/vJWRrdszCTQ95Y4L0ZDohq+oyidHOfEV5pGCW2HLSXlnU4QgnQkb4R5mpRb4z/87P/QH6cLn9Z96xgb8zvygrLjIORU9HJZdmcKf1ltVTBPldAHdhy+tu9oXTFhKMCvmkuWmKUpQIk01ae0oIrq0bsV2/swk0N2ZVfyF2lfKC37aQCxLVX6SCYLXtNf4PnRZzGFe9SiAqEo9RFl2X8kJkj9cwAB8moL/fVFvc6lQ2+zLTWfcI9tfoZXCseUq7ios524BBE2+mZQ/JHG0PDbGZve1EebnioCdDKkIuODcm2UPduY5m6m62aXYt/hF1g1a6qabBUaoKhp7SToHdT4WzQVnSBWK51UhBEc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:33.8945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e934867e-479f-45e1-9969-08dc48a839b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix some bound and NULL check
- Fix nonseamless transition from ODM + MPO to ODM + subvp
- Allow Z8 when stutter threshold is not met
- Remove plane and stream pointers from dc scratch
- Remove read/write to external register
- Increase number of hpo dp link encoders
- Increase clock table size
- Add new IPS config mode
- Build scaling params when a new plane is appended
- Refactor DML2 interfaces
- Allow idle opts for no flip case on PSR panel

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dd54de5f3b2f..6300ae2ea1f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.277"
+#define DC_VER "3.2.278"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

