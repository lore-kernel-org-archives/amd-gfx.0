Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ADCC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616C64D92
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616C64D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D3C6EC4D;
	Fri, 19 Feb 2021 22:17:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0DB6EC4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYV+W2Sc2/uY2fv/HvTcjBMQq7C4JixwN4bZSftyGIb0TrwKDfwwb8qFohiZPgAeLqXatthFSzLA/1h+phxQkVdvXoeKuwqzZ4ptCrdYwQ8Lv6jqKmf9fERwaua8NyqTl9B2eX6JC9kZCe3ZPbn1gsoDWrJeNXU26Pr6kARX3iCdUrHfdJNelkWofRi4hzMXcI19NWg1Wl6DmhtCE8V73y1P2kPKZmiKct9oaCm2L3Jz7OZobKDLSvcSFairKPARrYXn7c4raTiqGKn8+jdUZYkiInAvSQrEFxdQvL+QS0VzkrmJiQnvs7tNsm2W207/McaAEyI1Rrpt1qk5/cFZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIr9Xku2bCqY+DbWBM3QZHuXJVh2Uui4pPMk+ywZ0KQ=;
 b=gDoWjX52UfPYHTGfXsRKj6h0bb8Qy5knd7/b/r42/8RFyCs0gcF94AuZEFRBYbwszcEBzG23zCTkJ5+/IuooGgTuEiuu3Hd9J9QmobbjldxJee9OpAYIEOBoENHjFhHxyzvy87/ks0BxNdLi68neVe079lYyw1J2YCZRKsJs5d9fWoEH18TEtCqwQMUHrGfL2cSEXKvFvnGB1T5fgaDoYfiBNecIpluTjlK3Vq0ptu2hdjYgLxYntObKq2rs6RfjdVaoTl4L5YWVk6J/fhmBc1qk0EDqkzQ3Wm1Zv+dwGbJ0pe0k3W5Rq+DSZxJF8aHZ2QblyKX3FsFC3mSIfhHIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIr9Xku2bCqY+DbWBM3QZHuXJVh2Uui4pPMk+ywZ0KQ=;
 b=iRP/l3iE7AoV21t+bIfdGnf81W1ZIK3dZcGhs+4ocz5osz6ip5yoh1jaGpU2tu7MMoRguouClwLspH6/GRJ1F5rt9zP5ywlHLpOZF698dRlpWyzZXR2XKRT8NI7snP0oeLpGHWxGG1Q5N9SiGb72XAMFpTSgFg2XQ6vnRFY5l2o=
Received: from BN6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:404:f7::14)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 22:17:08 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::fd) by BN6PR11CA0052.outlook.office365.com
 (2603:10b6:404:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:17:07 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:52 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:52 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amd/display: [FW Promotion] Release 0.0.53
Date: Fri, 19 Feb 2021 17:16:10 -0500
Message-ID: <20210219221612.1713328-12-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8344215c-4ccb-4a04-accc-08d8d52417fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35963E132FB058C479CD4F36F5849@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+1CnhmcM7egDlRcFMxrdTz0Sd631ogv1G3txB46M1WPgjGVso2RJcRczXhdcMeVnQa1kF0zerMxehmbgnjemnCsD6zO3SgJzaMTBpFYk6xuAV2i+JNa8tsa7bjJZ3MrKja/iuwuOJvAlak5O3cZOlno0QtNHiKJhWwKJU3Yi/uA+lXkIN9uyvlaggB5XOm4uVjWWjp7uHp9ffq3qb0O6SrlgS+5kM/bCBHjJpLejSoBcFu3cUI9AbkA6l7fknwulQc60GbJ4kCaL3ucTGm3ekGWqRrbvUmuGfu5QLfSMBTYsZmloXRcJ4wH5Y55XfO8rUPPWgPTHXcd61q92/8ICqXHLBw1Y0N4CvR+7tggpyrF9b/MmwO2Yd5Wlzv6CzpaAhUoSVBsNdvRi4gnoo0Bqw3OkZwFjf5ZAdf14GNjWkTNCjZnlGh80TyEouUESlLKkl/EvVfGYGj8ayD4eT49SmQtwvprlg2SX58GtqyygyYK6XqISZElFrqTkJBQ4Crhh2tKcpNxzc+xd9/34B24LY2KzcNxlrygD7Hj8kH57mDNLwHWkZXRBKlhYRcmc4cbUZX+v65JbSgn4YHsSwHGSflCI8cPzB12eDB7SqTDFtDKocw0mGERyWWuOTkztDCq9OP0gJB3fRYqT6hM8jrRWu8LSU0btnNJC10AhqU98WvG2KPsmmfJnRTMZ2seRsKi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(82740400003)(356005)(70586007)(7696005)(70206006)(478600001)(83380400001)(8676002)(8936002)(36756003)(81166007)(6666004)(36860700001)(426003)(5660300002)(47076005)(6916009)(26005)(316002)(4326008)(4744005)(86362001)(186003)(1076003)(2906002)(2616005)(336012)(82310400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:17:07.0338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8344215c-4ccb-4a04-accc-08d8d52417fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 85d6a4849d3a..63111351d1e3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xb959929e3
+#define DMUB_FW_VERSION_GIT_HASH 0x3ac600697
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 52
+#define DMUB_FW_VERSION_REVISION 53
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
