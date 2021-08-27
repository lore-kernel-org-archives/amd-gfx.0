Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04503C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC95C60E93
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC95C60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0A56E9D7;
	Fri, 27 Aug 2021 20:45:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94AA6E9D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbs1GjganK0kjMZoJgL6U4AlYVc5ovmyZ0yM+a/RqQZRZfTh+6lHwYUXZTBc6Bmh6nGSGGvX5HymKhoNzspIisl+M/uFUb9MV6BA4i5Xj9I2MYvyDSmGz0X9LqehrBW20iIow5qYX9BSyyFIKITZ8WakmYN7uAClEFznmDhg6A3tdg+MwvA/RwTZp5lQIHdAsHc9R4cFUfckyf3m/FN7BcSxcP4/TGvLeO9TS0lvdMX2UMuGsUIuaZrT5XG1YFsN5gYnK6mml8Ie3FRJrlpTVxhl55GPlV3u7V0wEc0p+nEwjmsnQv8wX378+jbMlkDSLDPutrkRIFHUyd+1cRWzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7029E8Jl6eWubp0qR/rW2182Z7PN4Go8cwh2ErU5/jM=;
 b=mceIfemeSx2b/65oC3YstzKQ3Of22vWXWNTThKPb2utVyPdrAXZ/Sl+4hfMDo95miBsGUj7Gc4Qp9814eCOwnUwdPTEEQIb/EbMUQs5F3+sm6kVB1UwuAsFc3/Zj3k3QRZxEF5DJHHtHVdJm2Kx2hEfrwHa254Yabd6MjZOJeM0Aq5G9Vds7YELMJb5BYBxtXGyVLaHsmCupA1z/UH1SAHp/R3tCfeLzuEgKZxNQRw94YrcbprFvF2rq5UKg7iYdm7/+Ksf565C8+hbFTR+6ufvBk3CO/sG21vCcpsibJhlAhobp8uu56mZIq++IPdG2/dCCs3H06vj0J+CDlevmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7029E8Jl6eWubp0qR/rW2182Z7PN4Go8cwh2ErU5/jM=;
 b=koFlqlNz3FkoQ726Smzgd/i7LOGkbELTPesOifRn5JF5z1LV9EyB8s7tQNJEwBmNGP36MEQEx/EOKmRTOry/+xGwF/t4IUhShCryFrjxQEZ9OU1PGK6z7Z8UQ2tDCCrSDoXHHkdwCfiAi1E+wzGUbVyOHSzj/NlPZXxzzVWTB9E=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 27 Aug
 2021 20:29:29 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ab) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:29 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:27 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Oliver Logush <oliver.logush@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>
Subject: [PATCH 05/19] drm/amd/display: Drop unused privacy_mask setters and
 getters
Date: Fri, 27 Aug 2021 16:28:56 -0400
Message-ID: <20210827202910.20864-6-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d06ed80d-34ef-4f31-2ffb-08d969995f00
X-MS-TrafficTypeDiagnostic: DM6PR12MB5567:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5567BF1E996A8575F17DAB1EE4C89@DM6PR12MB5567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dob6r5O09u4jwJfGzEhLW9/8UufJrEFavdYLWr6DDNRdFY42Fj/C48u7lF5S6alv1BviLJTL3ym18Yc3V4yml14BCac0mloWSbCcE9xOIVyun1EuITvLkqWXJaZ2pqN7fhf2/ufkxHrzEIikY3MsvedB3mhP/u/G3HapwxiFzuoAvZrlLBqSrszHUlLAZl64NLls08SKQlRZdSkyz2IMNRH1KhO58boOZUlm7QdeziCzf3oJg52o9BsxQ+vfXLrB3m3o/UVq1DDxSd3+AiPkdbbfBwq7OwdXhhVEv0UyCmiILhBEK0h/T7TkEnton6wk+WlWH2jnTVSibqRE8OOEmBlq4OpzsO5lkgVqk8G6T11Xk1gNtUvHfvJUyC3AuTjtkXilQsbRzOHvqHIw79iKd3WE0xMCm88kyYjU1CpexNVXdWucWg6Z2KLYcFW0pmKjLBUP4B3+gjkU1cwbQyt4Dxe+RauPUPgxFZiSFXR8HvP2wKtbg3nWe4m+XCprPw3kWRYqwqffllX7ZC2FWwUgFeXjpAT+fliacOoK92q0uON5ZBzwyhjzN41vTrcu1bX9mb7zmTXcZ2H6i2ux13HChY0r/FzZAkIfpu1x4HEiwyKE32lxWu58RWBX3Oq5JHS3zrhAuWwLBUJvMc1lEn9F90VDGI5Fa0FHoroRoOUYebEDApIFPgbKR1Au+p35BpD3jZJ1tdSf0gX35VyWbuiBxFojotgNn+W2ZhO0qNezQmI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(4744005)(5660300002)(83380400001)(81166007)(478600001)(2616005)(6916009)(82310400003)(2906002)(356005)(316002)(44832011)(16526019)(426003)(26005)(36860700001)(86362001)(8936002)(8676002)(47076005)(6666004)(186003)(36756003)(336012)(1076003)(70586007)(54906003)(4326008)(70206006)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:29.2747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06ed80d-34ef-4f31-2ffb-08d969995f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
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

From: Oliver Logush <oliver.logush@amd.com>

[Why and How]
dwbc_funcs.set/get_privacy_mask isn't being used anymore, drop it

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index ec28cb9c3a8e..587bf4aef4bc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -220,12 +220,6 @@ struct dwbc_funcs {
 		struct dwbc *dwbc,
 		const struct dc_transfer_func *in_transfer_func_dwb_ogam);
 
-	void (*get_privacy_mask)(
-		struct dwbc *dwbc, uint32_t *mask_id);
-
-	void (*set_privacy_mask)(
-		struct dwbc *dwbc, uint32_t mask_id);
-
 	//TODO: merge with output_transfer_func?
 	bool (*dwb_ogam_set_input_transfer_func)(
 		struct dwbc *dwbc,
-- 
2.25.1

