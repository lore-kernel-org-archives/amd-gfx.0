Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F184C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E86610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39E86610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE296E223;
	Fri, 24 Sep 2021 19:10:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B096E223
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8mXcbG2SnMnowypqpgYOE/4k5ee8Owr6eFWb3vKstOnRGzdy/oyoUacFjd9SLkrgzRVsTgmoNyJS4z3ASIRdjQVV6vt90kI9nnJx+E9BXUXKuKtPbMQYwHJSFr0zQCUMN6Ku22owfwsH75fE20/HM0pT3CP4LIFFjny603tAp4s96uOqQ+tg08EpMIlaubBm7tZ/ITRdcAinhpYFf8+qTu/pohw7cqsTcwYF1uaM1PPRAb+zNTKS9a2b/4cYUNuKmZBVzFz2thi3Q9h4lTcPlmDN4McuIRfON/nnthJuVBIK8uExl7cIQtzEXm9IYY0pMBc9Lg2BxgndMK43RVFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=AgtSwv5UZQkdJx8Qr+CNg3QlSMNp1TPKonoUOAZdz1k=;
 b=LY5p1c2OCP4iJuv89EaxPXg6NJjR92fBEL8xqJOo9bodUj4JuhitLX44T+LwXc7lq1VMwkrXQMAmhIlbWbszdam6YdGUyJg96Lekpw6hJ5Rb1AiuisNfstHVUoaYu5KE6M4HK5CydTDekNgM/6zcCtG4D2uZc+R75Q9fv9kz/Qq74b8HEWc5MSrc/vPAROgTp+5kGWAJ42/D+4rgp0rkZU7OVth2o8xaA+OmgSW/eOSbKvuJ63fZzBnSWX+Ddzt3k3zVfidmHzEYOg6xsWrEjjh0yRvDArPN2+4w+VlGtTP95PZEAYUP4XVYQlvn+bsPeDXjIv+qbhPuvhLsd1clsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgtSwv5UZQkdJx8Qr+CNg3QlSMNp1TPKonoUOAZdz1k=;
 b=R4euTrl3Y7XSqxDZ1gJrNoUHlqxQl6Le7J2RVtjfhk47Ltige7CiShz4E3ydisem/mlpXMgUldemiPFUkXOFb7njH/lbHBDElWlxMfsL243kj7ejXhWBXGwWIkLbiOFcJ8Kl44X4kLq8/ZzanbBHRQH+sidgtg8AxWk8OMqbM/Q=
Received: from DM5PR07CA0083.namprd07.prod.outlook.com (2603:10b6:4:ad::48) by
 MWHPR12MB1950.namprd12.prod.outlook.com (2603:10b6:300:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:38 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::9e) by DM5PR07CA0083.outlook.office365.com
 (2603:10b6:4:ad::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:37 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:30 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Josip Pavic
 <Josip.Pavic@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 20/24] drm/amd/display: initialize backlight_ramping_override
 to false
Date: Fri, 24 Sep 2021 15:09:30 -0400
Message-ID: <20210924190934.1193379-21-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ddde50-5125-4e31-6c1a-08d97f8efea4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1950:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1950057364E37B6EA13AD46EEBA49@MWHPR12MB1950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tPnnsLJiSzeCLh7s5PxFlY9Bju1PY9h0+eo5t0P2nV6leQ5KsUZDGMd8lUIuP6BisHPSYc32Yqunv3Qv2IYYYrNQY6LBVq7gCt9RQgMribu4/Z8lJbm8no+J4zSrzgB0ZIr3yndDHH32k8mk7II0lmrDxFlpKJdXnhgMn2xnG+beBg4wmOXkFel8khOYT9/OUOCtROK2nvWI83JbNNpbe96f14mR/LtXk3GEoYYYkjWfLtGj5Sr0Z5Wyih48RsFuJofusDkMTsrqxZ0/aBujcJ1ZcpQJMAGvg45zEBnuNE6IKK8Ah1w9kqDpxL0Qp6zde8Zom/Z23n6aZdKSLLvkM/ohcwAyVOGkU9DBlZPics86HmrIXV2Q9BHF5Jr6e7ZgMs5XtPRPjxIVUk1JznTcnpue79QOkIVZlv8kPG47TUGj4ga6CQ57MahZLsw7C2nS3yQ7yPHikknSXx6OhcJzvQXx5xJR0sT3UX1DQNNzQtd0FHnSEvkGu3mBxyQZkO+ox9WLXunMG4CaPi58EzOVCUqrBcHxyo4zDEwIMte/18uBVdv7TVQcj25l9uZzAatt6Vky+7333MXJHzoEzIbfyyuiOoWlBN1Luyqrq5T1NL+PEX6N+E6488rRMhkVmyQzrfjcLbh/YoTR4y3XqPMhxvNxXhsjxItA9CVrSqym/XD6esQyCRgM97w0aChDQM2OsYE7Ma7+vXikpQpVLVGDZds+ttRemZselefD2NB0iQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(186003)(6916009)(36756003)(81166007)(1076003)(86362001)(36860700001)(336012)(47076005)(356005)(2906002)(7696005)(70586007)(316002)(4744005)(54906003)(508600001)(4326008)(8676002)(8936002)(426003)(70206006)(2616005)(82310400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:38.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ddde50-5125-4e31-6c1a-08d97f8efea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1950
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
Stack variable params.backlight_ramping_override is uninitialized, so it
contains junk data

[How]
Initialize the variable to false

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 07adac1a8c42..18899a391597 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1961,6 +1961,7 @@ static int dm_late_init(void *handle)
 		linear_lut[i] = 0xFFFF * i / 15;
 
 	params.set = 0;
+	params.backlight_ramping_override = false;
 	params.backlight_ramping_start = 0xCCCC;
 	params.backlight_ramping_reduction = 0xCCCCCCCC;
 	params.backlight_lut_array_size = 16;
-- 
2.25.1

