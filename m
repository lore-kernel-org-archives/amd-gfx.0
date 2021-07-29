Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A783CC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7244060F4B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7244060F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E936EE63;
	Thu, 29 Jul 2021 20:37:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD7916EE63
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVMdbI5HuVchxDYzrhjTt1GFxV9yUdI8+nOmAYwG7gtTNBApyKRtGaihognVI3RBpV6NWqtYWQYei/EtAHiQJhpsJDI829xn7eBLDyqjpVSho8BRaYzfdtbDQYUad6byPJEMC3KWZhve2lX+5qOg6GJua/49ZM9piYE+/grpgk2vsRnxDAkuSYfTz0gJLiyny9m1VU9mM+Ow5119EDAtHJPnulejJSUyN3Lg6bumraVSyzxH/V4EMO937OT5+Ph7r7qk0wwAgsJp9uwbspGs0zfTOK9w3Yy4bqy5RXDkp34ykCs28CXEdJmZMLNtoExnq/J/Z1WEKeLlL6jsJ3tUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3F2NwRGlzFUzbyjofOGE6v2xtmhXA1AWylDlu9FTWw=;
 b=Aljktpx/xxVHxwqh/J2ethFbgQpSNKJipDVibh1ErT5DWu5RTEm43e4MeGZIyX3TvyuTYWxl84Bas8rO/A2uxNk1v36fu/+077Ah4Zfl+LN6/cVmEgv4ADq4CfAlnaJO2JZiJAYeg+Wm34DY8EOCP3upLCjqNj8kF30Nx48KXICEN/G6hryBASO6TzhhL7b1FsYuNDi4Mx1pzEloBXJft4tY/ZPuheQhrWsjTNlTW1NRTrZKIcLGYg5yXDu9Xk9nqZE8rgXZKhMNGvvyTKNJfYUhiDJD8oHOtmw5o4FtH4xhjgZ8esGP04CQNBvTEROT6aFl4oLvoi9VIpZ8cz2SyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3F2NwRGlzFUzbyjofOGE6v2xtmhXA1AWylDlu9FTWw=;
 b=PydbwLaBgqHYS8KWyxzMCgiz90BRD7J+mKZyXSk9kK17bQVpiSIW3LUW0xjo6manCkzHu43HjC6rmDbwT6cL+BO3qlUka3XhgHt2D6DLdG1yukCLsjs2uklq2qfmp8QQk4xnvqJwCyY3wGTmQ63MKn2kYV/YQPZQoLSHKdIJxmo=
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 20:37:32 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::56) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:30 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amd/display: 3.2.147
Date: Thu, 29 Jul 2021 16:37:12 -0400
Message-ID: <20210729203712.1566129-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d89279f-1375-43b3-5304-08d952d0b0f0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1688:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1688B2F0D119935E60FAEE7F8BEB9@CY4PR12MB1688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWRf5pSUZKtFdAcsqzHcc/zcdKlMVgRt8NZOvV7B0B6u11cbx6N9V4N9HRilEt6lAnBAHEZN1qWDobdCToMy7vLHpsPE312hee4dg/1D0HV97CITg56+sKAu7Q4J0rPixIAwZvdv7Zit81/cd5IEQ5QtQHMAeYbQ7TEmMD3eAZ2yTpckD7S7PFGrb93EOK2HuBuc2Ia6FIKpSEFUSpZkSORYdHxbXuOZgvY4ahdgXETtquqPcrKPoYBgphB2KS6o5TyCi8AcDGOcfiHSbScyvYIyxXcA25/vOXSBG2ykzf6e9udLgZ0EYb9J4DuFSYqMRF8VBOD1YUsscWBU7fJtBsKQt3mA4h943AOZ4ZDZcCpsPqSMcytqwcmNVWjrHUEjeXrRyvSyIayyHiaWMdtnSY3ypTPKDPI/qsYcgwy4TppT7x5vuzsOYUnCWCBOZMEEBzsa8WRvral/y5pX18oMnSKPf3pq65g6bKBeDYhvVoW+qgsZotjE5OKvwrUX9Icqhv2N6/xg0uxtGpMU6OTuWYxeMyglWiWdy1ke+c5BVyW5+VUfyOIwcQJhDdSwIcpPwh/vlfebeOgZEPrNLv9+adHjC4/yLTvXOGPkgdBsUEdyOC90fpQljGuHNJ2Gr65pderJ0e99sNgS/BDmJg3a3z20PIVKJb7EYRMG6sldpkLe5baYF1B2A9I/ycTG1ku34Q78ehRR1rPUOjngCzFoglAoR7piJdhlpnLp31NR12Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(70586007)(54906003)(2616005)(186003)(316002)(70206006)(36860700001)(26005)(1076003)(5660300002)(6666004)(83380400001)(47076005)(4744005)(8936002)(86362001)(356005)(6916009)(82310400003)(426003)(36756003)(7696005)(2906002)(508600001)(81166007)(4326008)(336012)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:32.4421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d89279f-1375-43b3-5304-08d952d0b0f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1688
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 22e917714fe2..62c222d0402f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.146"
+#define DC_VER "3.2.147"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
