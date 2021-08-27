Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B2C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1510960E93
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1510960E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E5E6E9CC;
	Fri, 27 Aug 2021 20:44:10 +0000 (UTC)
X-Greylist: delayed 877 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 20:44:08 UTC
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C7F6E9C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joh6+mioEcwa8QbNfMzv3UsLfWqBYCfclGSpRIt1n9iP5VrR2T4yKxHBtf71ZMpol1oBLfcWt4jd0WmmCwX9AJXqr8/B1xbupA3tv1aL8AHwKeu9q2o32pe7+ttI7bi7aVkrebS8FwS4E90Pw4bCYTidWFv5TkwjUVxW4To9tvsSrzrmrbE8Z8XRaPEgm+ym3HZhAV+KgTcTNInkOVtc4axDxYPtJzGPHhjzxvokDL3axFlMdLrgIm42nqpi6lQzES4JNyB+8FUftxQ9Pp8nlUExH/J4RIRbejfZS1ysKDnLlvAWsv7LViXsd50pIZq+hX4Yebxpit2YTcHx4FErSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbwBFQl1s4gNgyAGPMzgqW8mkPPkv+VGTD6aTG6OkKM=;
 b=UejNR+6KQjjr/6rPzvSEzW0ON3j+U2ngpVu7p71YFtFTShCIOW9u4HXexMu1cJNXuMB3WytIcWGtsWbKeTD5zuiSl2TJ/sTaCJaP9Gb30Hp5IO+I3eds2w72FIqg7kJvjcYq2ZLhXWdYyuiuIfB44HjAltZraOqIgu5pLCE/ShAiHSiavKiIJGQxDQgh8ojPsICro68Hnb1o34tFFKKlfZdWmc745MF+3e5T/qYOpDqVLpmxK2njPEZWNKYU7YuyUbwYI2ikaYGJA/4LiRA+lcrBbLuUIBEOhCEeKH4a6KIwat4HN48sn/fdtCWk8nndahb9OObGZIqwD8ZHhQOqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbwBFQl1s4gNgyAGPMzgqW8mkPPkv+VGTD6aTG6OkKM=;
 b=npLKJrVx4VZaX5fExREjoB4mh9gPY39QokhutoW8Vm4M+DHnNGkxWyQumTi/ep7ZMwXxBIu13FrWmsnR+QBGJYl1p2+/JIdk+C3iynbv9MpQ+NHI/CpOVUu0S2SNh6ySpavgMaurXIZIZvSAuodf/fZzkDYOLJjEAnDmslqIqNY=
Received: from MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46) by
 PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 27 Aug 2021 20:29:38 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::84) by MW2PR16CA0033.outlook.office365.com
 (2603:10b6:907::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:38 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:36 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>
Subject: [PATCH 12/19] drm/amd/display: Fix false BAD_FREE warning from
 Coverity
Date: Fri, 27 Aug 2021 16:29:03 -0400
Message-ID: <20210827202910.20864-13-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a746c468-4886-4e31-05e3-08d969996449
X-MS-TrafficTypeDiagnostic: PH0PR12MB5466:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5466C52AA564C8BE3C3559BAE4C89@PH0PR12MB5466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QESNm5H3aR3uL2O9CVWGR2eg18dMJRWxRr9H7WtAb0WlUxLQcYmvl3AsY0z+Qo7nDhJuaCPFKd9PzBOZ+G8+TOD0JMhdiDDA9K14sPbKolju9E8cN3L7vgOen6vXelKQFq/c4qkI2njurgG83Gft2M45nR4jzFMXNEsZwgl+b7+pKusY4V+7vDNZyqV4Pq2AOrpi93jlGA6YNrpk31m9KDIOwBtVxZ1RdS652aD/oYHNtHeM73XzT8jzohLmFRWdMIGq+uWCgyxxPf5JZCCW9ZvpL2kODw5S860n5mbWhsFiFhmKatmkdZhjY/89+lRNDCZrg1idnjxurUCJp27MGgqqLbNT1oYXCPSUCHEisdeJPl8jY2eDWMWFWMEx6CarbPlSwgGBRqYzUpQ33PjBt8IKP5Pw7UhUjJc4SKwD6Z7DDaJj4zEvbE2rvgbXf/4Snmy6Im6NtuOsPBDbfzg5NCmPtClWjZd25JxIarF7zIHoQJBZYfRaIAH0kE8sgy7rC2aYrELDU/sfPqp7rNNElAaXw9d0nK60Pw/MI4qzdNENhcUwn9E8KVpEpRLtvdCBhuNDHXgtuZLyizzsN190izj812sTpkUCAeYv7e27r5QTVVt44EupIEqDRt2HM3dmKJMNLkC4xhsGiDkFoHD9JcluCxYJK9PEEsNYyu991wwtfhICrgo80w7pbDovPdcOxFb5VdR8gIUUzID9cZ9dsoX6DQRD8Qi7uWnHbkxyKU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(6666004)(54906003)(2616005)(36756003)(6916009)(82740400003)(4326008)(47076005)(70206006)(44832011)(1076003)(426003)(26005)(86362001)(8936002)(2906002)(8676002)(186003)(81166007)(82310400003)(336012)(478600001)(36860700001)(5660300002)(70586007)(356005)(16526019)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:38.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a746c468-4886-4e31-05e3-08d969996449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
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

From: Anson Jacob <Anson.Jacob@amd.com>

This is an attempt to fix false warning raised by Coverity
via multiple CID's.

Addresses-Coverity-ID: 1487412 ("Free of address-of expression")
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>

Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index 72970e49800a..7f25c11f4248 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -176,12 +176,15 @@ static void dpcd_reduce_address_range(
 		uint8_t * const reduced_data,
 		const uint32_t reduced_size)
 {
-	const uint32_t reduced_end_address = END_ADDRESS(reduced_address, reduced_size);
-	const uint32_t extended_end_address = END_ADDRESS(extended_address, extended_size);
 	const uint32_t offset = reduced_address - extended_address;
 
-	if (extended_end_address == reduced_end_address && extended_address == reduced_address)
-		return; /* extended and reduced address ranges point to the same data */
+	/*
+	 * If the address is same, address was not extended.
+	 * So we do not need to free any memory.
+	 * The data is in original buffer(reduced_data).
+	 */
+	if (extended_data == reduced_data)
+		return;
 
 	memcpy(&extended_data[offset], reduced_data, reduced_size);
 	kfree(extended_data);
-- 
2.25.1

