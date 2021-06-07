Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80363C48BCD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E39B60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E39B60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC2A6E935;
	Mon,  7 Jun 2021 16:48:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5186E935
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlKe67G/GkRKc6heEZWefhWLABKB87RqLhojZcjNI9nxmImMulUtRGqKvfFHGGc2NMBKE0M4gLnMmLHzZZiXalN1FA7ywNT8x4ofiTTgbGYFNZcnGPCczfZ0X8/Bpzlx7BBMmN5/Xbsc75Dew6+XVaaIob+baqk5YFPOkMz2kyELJtuoZa1E/tzl78ACNxJBN7hlYKDzSioTOUHch3o/RHBIjCvD1JWNlN/Ahn+wJjR2wpWdziKxx69vQWfKkdzPPkVxZ8GNxagLQX8271mGMsAhJ0sYCKBrAKVFURJx7uHzZI1ljgNAjki3XOcpFJmjyf4HrQ2+F6j+6dP19g+lTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htjdj+r+H1gZuppHSab73qjy6P4HL1RMIu8twzPh2IY=;
 b=fgTeyZv6AAY05xJXy3M/4Rrw09LeT3N7CXwirVN7p/natg7h9HgxPjqgNJ4sF6AMG0Lw9B/osRR6QI/B4H15Ao7bG2f23kNFWci1V9tgrXg+NYcMPUpLQ0idnU/SeYD0F0oj3dFbOCASlw/dtCvoFvyTClhuILkTES5zKHNFYtyfgfwLRg2C1r0k35MzfeaeqdNC1e7jbGTL9HtqOPiLgiToT6tcDNGL+QToRq1+u0I+zz0f9GMIfjwW74tBx4k3XEThdT8QOAWKi1muhWQJ9z22WfVjVirvbBL4lW+vCq93dSORpe/TEEY4kcFt3bHcDY1NWLFYOPufkbJLUe/efQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htjdj+r+H1gZuppHSab73qjy6P4HL1RMIu8twzPh2IY=;
 b=mJxdPNlb/TEuKTsrsEmAY56EGb1unCfZ2QAGBBPaDzqRRGgjfpGdPiWq8VkkixmKyV6tlW6+UeUnD7q9t/v+Yt/VVqv3zlEWJTq8noOCK+k5qL9ArNcoGSSJjdKQYaR/RqyAv5KKhhJhsL4WNCLEQsUQSFXG5LUliXbKuR++kUc=
Received: from BN6PR1401CA0013.namprd14.prod.outlook.com
 (2603:10b6:405:4b::23) by DM6PR12MB2874.namprd12.prod.outlook.com
 (2603:10b6:5:15e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:48:28 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::eb) by BN6PR1401CA0013.outlook.office365.com
 (2603:10b6:405:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:27 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:23 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/30] drm/amd/display: Remove unused definition of DMUB
 SET_CONFIG
Date: Tue, 8 Jun 2021 00:46:56 +0800
Message-ID: <20210607164714.311325-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e67970ad-7306-49df-5aca-08d929d412a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2874:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28744CDEB10A7BC6EC89896EFF389@DM6PR12MB2874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnoNM7+Jlzwm6L6vNi0ae7QaSan+k1bL6yUSqsltY188jNDFVJM0Vi/rXBmcFvBYSb6OGWv/O2IlFZU4uuZWy0g0KQcU9OidOxDXWzo++DfTDZVfuY+wi+BTpNBP+dIw7wfK7u0UBVx7jMTDS8IQ0XShXnpAnVRaISgnUK2FP/I71Y/Blpl88AWrLYAKvApSM/p7R1JacBOpBGz54F+VlYYUo/qxKSBT8hhwABkE/svuKPI4S3lx0I8ICEwm7mtDe5vMqZXgU6V08Rgtzb3dg6mrnIKAOhJc2cseqCzLqLpxaL5dnuCn2pT0Ug1tsXCRM7wdjZML1i0eLHCKyCWZNgTAbcIz3nxniRUYeKAqjkz1OWd9N5K7rjzfSZDGibEyGeHze0b8WMahfB8DboONNqyzq6I7n/qIl72fTzA/+EIlTC9A/nk5GIpin7FJTZd4Tk45GPrS36S+bEEff6fhA2a36pv44MVKFqzNlKaZtdOpFY5ZLejyr30Af6rstMaVGlVsd69cNeBKDKy24d1f0rFj9a08j8lPZ3Takkk7WhakOQBGSGo9LDfxnPIYxdJl6Pzj4cCyFHqlGRnOaTjFVZ4odCa4LWtI14Qxpsl2g73f6RRnqFrkKOoPlw6jqromMJDTjU0ooY7c7T/h4oIbTUfYvjOPoxeGNiwrIgtPV0Cp2zsPzJlj3maoeOu0+pkP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(498600001)(7696005)(2906002)(2616005)(336012)(6916009)(54906003)(1076003)(4326008)(4744005)(16526019)(186003)(356005)(70206006)(82310400003)(70586007)(44832011)(81166007)(36756003)(36860700001)(5660300002)(86362001)(8936002)(426003)(6666004)(8676002)(83380400001)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:27.1717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67970ad-7306-49df-5aca-08d929d412a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why & How]
SET_CONFIG transactions with DMUB is not used and removed.

Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ac8c366c6e8c..6eae16c27b1d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -631,10 +631,6 @@ enum dmub_out_cmd_type {
 	 * Command type used for DP AUX Reply data notification
 	 */
 	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
-	/**
-	 * Command type used for DP HPD event notification
-	 */
-	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 };
 
 #pragma pack(push, 1)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
