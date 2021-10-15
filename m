Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F72CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC9C61041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AC9C61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3616EDC2;
	Fri, 15 Oct 2021 18:44:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD936EDBC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSX2RWwnZDfGpP/dze/gqgplhy0zU2mUYm8ksfu6u5tQcVZBIaO3tBrUpD7B5eOrbX+t0We2G4dS7lrk6j/xyOs0i+8/In25bYU/jnzRZanUkIOAVggR5u18ix00upx2xP+mB5HpYLAOLDi8BbGr/wl+51ii73eGu2lQfq2hKfYh6rqAcTc0+sg6HvPFez9YqgjsH/6mBYoUdyvO67LoPxQq4uIGSUwyUrgCfMSDSPSws7PdTe65+jzKVLNjZuo2NYLuTl+z4mwpzDXrSJSP1uWvBfopkM0Y1Qos7iIsgpEmiecQUpJAfRj+VG/IIqVb36OMUW07Dbuo6dgCfi6QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEoRLpDkRuARcV4yj+ts/g+dok7GpvMkgocSAxXgKpw=;
 b=BaCG3ouX2vH6quXDlYYiTz4bLvZRbtjcK6gKygjadLPNb8kdu4+NQphewwbln4dUPD6gIRlt3A7/f9WfqAsSkCqgq8o5CsAH9BmauIIB5a9+QVBgFo29ZuT4na7IRsiG9fU54uoRng+04vW+nwK5nQsT+9+6gMzl5XhuxIfNAxchgcKtAytB3/9WAXqGRbeqS0uN6ELKhy0oFwtIJFEi6VBnmZYCjE21/Ur9G6c8I5fjpenGAWwbdbtq2gkb83Z34KL056KoDFyWVECAAu7LfXe+ctSDYdyGyg2GrqUtqqGe5emwldQXsAANh/cRKUupqkNTmY8uMR98rNA70kqXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEoRLpDkRuARcV4yj+ts/g+dok7GpvMkgocSAxXgKpw=;
 b=mW7nyoeiu4lv33l2C8zJXCKxBYWIFpGLJTOVqGD3zKZg8FFxWU7D/jz7c3MKdeUukH1X5CqwvTNsAVHqaezuNYwAyDatlZNlGfmt36Xy2GarziLLo5wziEO7NVuaahrjNyp3Ik7QuZl0SlAhdE5zfuXMDIKyj3QxUTxuXJ9A2Y8=
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 CY4PR12MB1125.namprd12.prod.outlook.com (2603:10b6:903:43::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.24; Fri, 15 Oct 2021 18:43:57 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f6) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:56 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:54 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>, Josip Pavic
 <Josip.Pavic@amd.com>
Subject: [PATCH 08/27] drm/amd/display: Validate plane rects before use
Date: Fri, 15 Oct 2021 14:43:13 -0400
Message-ID: <20211015184332.221091-9-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343a698b-1e4a-4fe1-80ca-08d9900bbe94
X-MS-TrafficTypeDiagnostic: CY4PR12MB1125:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11251002BCC41BD2C701DB9FF5B99@CY4PR12MB1125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwsxzGhYmquhIBVXMpHT5LZxLAzxYGivoAW0+mUPmsDYFETJr+i87kl4zlWHsu7XJOqX6bhVVd5wHQEq/FW+7wD8UVawO02IFRpOR0n9UUWkzAMylnjqSHUT+ORaLdD/a9hNn5IyGwJ+ShrpHOBO6NBghbV8pJpkYy+B8zsLaSRZFDZgsR0SDXguO4Q3xmAEvNtECkfb/Pkqu6Prx6Db102IWpZLRV0T8gL3itO+8v1gOo0BDUJIk2pS7flBsUGyA26Iq3ZGXdMJw9rBguq8b5p/pbcOO9vpQZzF+3RXEa6aeysNdVfQU9knuE1NfZvlSvSuOXrge5yTXOvup7nIJdbc1zYhGL4+yeU0TZ1Uelx6z2IKl9gtgo8uHfrty11AA/+/8n9RFXLgzrMDzun8KyT+M5LZjQFQAvELWtqeAL58lmNZzBcqHOwbfS4V6M7JwJ5FOmCN5Wx5DkCA8rIOyai0TUBcriPEVSLGJJoU9NsY8x61q8b+f+LAbblaAgCEQ8ucAZursAIMnpfXSjAqj/466XToKpP5WWgDumtUUFGKM1x5lLTIRca6PRJgzzL6UeYohdaNCoRO2/Sv0wXxUeu4t7V2mcMQSIyFeQ9MCy/mDeAJK0OtVys5LiOVx59GcHjbw2H2vgS+wyfIxXz6uW4uQaubsltlW90+bF8BonFncaMCrz8H4BrhEcZai2SfPctb/7R3hzK4tnAvXzGZ4qKxc4VWImJjhqRNgWfy9rI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(70206006)(16526019)(36756003)(81166007)(26005)(5660300002)(8676002)(4326008)(8936002)(70586007)(82310400003)(47076005)(6666004)(2616005)(83380400001)(44832011)(2906002)(15650500001)(54906003)(508600001)(356005)(86362001)(36860700001)(336012)(316002)(426003)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:56.5269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343a698b-1e4a-4fe1-80ca-08d9900bbe94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1125
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

[Why]
Calculation of scaling ratio can result in a crash due to zero'd src or
dst plane rects.

[How]
Validate that src and dst rects are valid before using for scaling
calculations.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 561c10a92bb5..9e83fd54e2ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3009,6 +3009,11 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
 {
 	enum dc_status res = DC_OK;
 
+	/* check if surface has invalid dimensions */
+	if (plane_state->src_rect.width == 0 || plane_state->src_rect.height == 0 ||
+		plane_state->dst_rect.width == 0 || plane_state->dst_rect.height == 0)
+		return DC_FAIL_SURFACE_VALIDATE;
+
 	/* TODO For now validates pixel format only */
 	if (dc->res_pool->funcs->validate_plane)
 		return dc->res_pool->funcs->validate_plane(plane_state, &dc->caps);
-- 
2.25.1

