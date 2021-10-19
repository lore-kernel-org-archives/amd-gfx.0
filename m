Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C02C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E3E6103D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69E3E6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17516E1B2;
	Tue, 19 Oct 2021 17:51:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE446E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 17:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoh+ImcMbR16tjBl1xpFFPPQjgw3vV/92Hvry5sVG20vluDJ5Cb35Z1idxYrhMJn2qte8d1KIO2Po/DZzjnNKviz3T3ZI7/K6vX45U1VGHJpSShFhCDqnQtkp4mYzfQBS/HwrVThOaSuypuk2gYriMxD/Y5SLW3ni7lcpHngjuJNwVy+UJv5NMZeNkNq3inSI0nxWTXtow6ZMRzCXc7abiW1uaznOj16rvbS5EwIIckE9abW9M8pRtRkZoyz2o+7YWnZPzatGSnh2TpWv2h5781of3ZAzvQwB35QfpgclxetvVj9XkX/qOO+I8TtSjUh7mL5V+LysPzci0Oo2vCMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orDHhMmU37pqqtgXm1Pqu3zFXtxpeN9v/ahlxqshjSc=;
 b=i1iSjbqu+HFqvzcMTNxnhBKCx4xXlD1NYMrt3BNjwYkuk7iC1Z1DjpDwvteBX5UUTjE+4Cjzsoot+a1OZbQjJL6O8teu7vS/1YPs9EHxLdiBh0yEfZqOuqOw4DxhK7byMznjBxakd2b0WdUma3+qfx/mV9qp34PAeLXQArWpod6bMF1RfOt0zH7FKPs2e38LUZh6N2NeWYtfNs7fTe8vyQaQ0Qw/v9RDmukFe/DGG5LVx6Zhq61gN3+mSRhfLpDbZsurqcPEATD0MPGXajN+YIRaBOvtOe0rq6kLanbqYybVThiAqAGYyRfCxc+XYTo29aq7DQiq2teR9c2B0Z/JIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orDHhMmU37pqqtgXm1Pqu3zFXtxpeN9v/ahlxqshjSc=;
 b=TM/cdPlqEiFAX3vFhBGQjYo3eLYvJ2xf+513ecdfuORH3j6f5RkcComnmQBH2ENlCgX4JzHk+S1dTvxkVeL2uXWNokO8UG2EMYoa4RX6PmbATouRy8ur4oxixssrytOebARKMQFo5NsgioOZFdvcCDk/xOeuvnyJ9OL1Nk2A8Cw=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Tue, 19 Oct 2021 17:51:10 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::9e) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 17:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 17:51:10 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 12:51:09 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Implement ignore_bad_page_threshold parameter
Date: Tue, 19 Oct 2021 13:50:50 -0400
Message-ID: <20211019175050.934527-4-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019175050.934527-1-kent.russell@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d08c2c-586b-4fe2-ec93-08d993290923
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:
X-Microsoft-Antispam-PRVS: <MW2PR12MB23967BE809703DC2F3D9DEBB85BD9@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaoDZchdYE3fJTom09z5zRrLIIujUwuYHqYp2ZAE/si8RZRaUea+y+NQiegZ6dsKHb+05fEd7jd12cIkG2oV2/Ciz4vQEb//QrYp1gRcNnBzgGBPp74N5drkPQxQuog7a5k3lHdRDr/x8OpRJ6Qda44Hkg7d+1ZYHNGSuKGr+NoLbJAETqeyRgXyNjsHYrrRTYLw7XeSrnQLlseNj4A2cbJo1j65uooVTJmTN2EMqvsvrAGkHhMyHkEd4iWNqeyXM9A42bljsmt2g2B9L3dNXsdxPdeUimR1a3hi7hQzbxiNeplRC9GkQBDvEO8wlvjxkBQbFglfuTMFrGBijYxusXNUMr0tHPT9CmswpiFtHiA4QpZ8liEBV6/WS8LStk1rK3lOHbN0SstAW3vC2gDIeoJ6c37WjvaS3yo2z5viKQvwpEYILzIs5aQmXFnL1/dcBJjrHRpdHv9M9TYwI02odX+3TKaf7/1iu77QEpmgqI279c1K7K46We/Gcg+Vhvd20mAxRAHOXgCru57FUZNHtZTJ8eKtxZaP2u4PGIrc105m2HFiBB1D65RXVy9IkIIghdH+1RDM8Jg+Bb6dzqe+lSQVHSnJWq7qW5Q+qLkUb/AUdUSQpBQ+lDRLxPxrBoDD5nQeNeVpKwAlbAak5t8zcOJdQCcrcvTJzfBaQS7wyEF3HvFH1MRb6vKuDuq38uHgZoRfy1L/5SOweIWmqIRNzh8FB56+8zfhDaKLokKnDJ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(54906003)(5660300002)(81166007)(44832011)(316002)(47076005)(70586007)(7696005)(70206006)(4326008)(8676002)(82310400003)(426003)(6916009)(86362001)(186003)(8936002)(36756003)(6666004)(16526019)(508600001)(2906002)(336012)(83380400001)(26005)(36860700001)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 17:51:10.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d08c2c-586b-4fe2-ec93-08d993290923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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

If the ignore_bad_page_threshold kernel parameter is set to true,
continue to post the GPU. Print an warning to dmesg that this action has
been done, and that page retirement will obviously not work for said GPU

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 7bb506a0ebd6..63a0548a05bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1108,11 +1108,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
-			*exceed_err_limit = true;
-			dev_err(adev->dev,
-				"RAS records:%d exceed threshold:%d, "
-				"GPU will not be initialized. Replace this GPU or increase the threshold",
+			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
 				control->ras_num_recs, ras->bad_page_cnt_threshold);
+			if (amdgpu_ignore_bad_page_threshold) {
+				dev_warn(adev->dev, "GPU will be initialized due to ignore_bad_page_threshold.");
+				dev_warn(adev->dev, "Page retirement will not work for this GPU in this state.");
+				res = 0;
+			} else {
+				*exceed_err_limit = true;
+				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
+			}
 		}
 	} else {
 		DRM_INFO("Creating a new EEPROM table");
-- 
2.25.1

