Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED98C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 15:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C769F2063A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 15:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LTz09LdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C769F2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689C06E187;
	Fri, 21 Aug 2020 15:31:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3796E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 15:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCpUhohP3H9U0Ahm6AKbwmWku2bJwCPwhtjzygtp3YVVnzy5nked2dqzM+qVUx47PWKls4iNEfFV4J7PLWvrtvl0/IiCi2AkTgehzet4Y/L+J/MD7Fb8Ka2v3JB28DJ4sIInf54qq4+KF1+f2V7Sp8DFaYe3Mylk8TQGrkY33QLUbK/k4tNkCigdFInqu81MeXZWD5gBq2yG65dfObffhoN4nivLS22Kpc5hFyFSVdQjGqUEgQQwwUXrKmi3CkOIc4n5WRMg9jOiT5+Pvces5X6zJydE0X0dAnpWqGpbVlDRS18Fsj6IwUEGKwL2GcbVznBaSWiKHlSOkb88QpaT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09PiexFk0cKPaGsGgxUAThJ7684gYmjoHy37YeFgEbU=;
 b=SGN4gMANbYslA/MRTFP4RRwnd2IGtXglCQDVuU+/0PEzWxNdjSbAjgtQIhiodNLY8oWpxSoU9XkQhQhzhy5vaUAk/1jmOflUJpHocn0UWP0Lhp0QgxjsFJBDn5VP/HDkTO7Y9TdTupusIcmpgVzTAU4PLF6xOK8XItN+Krd2/qYWKVSVwXFLV7sK41XFu/25F2lbbE+PBZa8qT6SLv12pPZUl6ZujqSBUzWnL7QEzx/QX6PGkkBxb+YkFevCWpKrozMfeUV4fRv6oLGx+hbbUG4Cz39Sz4JTqoIc4HkNkinf7cMc+1a7RcuBpiuxGh6w4sHQVdNHWIaJMQLAkYzx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09PiexFk0cKPaGsGgxUAThJ7684gYmjoHy37YeFgEbU=;
 b=LTz09LdM0/zQPfYhZOvIrSkKc9mH7R7VRAS07YSX06ycExqPwCcpsrwSRFlteyPNECyYyA8/J6v1UrGjiEnD7Irrl9F1RGW2AMtZrpYRZ6BGzSspmonOwG3fGn5CxCmUrkUfmmZ82C6d5F+o/N962YGxeWtWPurStns5QkH/rrU=
Received: from DM5PR04CA0067.namprd04.prod.outlook.com (2603:10b6:3:ef::29) by
 DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 15:31:50 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::d2) by DM5PR04CA0067.outlook.office365.com
 (2603:10b6:3:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 15:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 15:31:50 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 10:31:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 10:31:49 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: Fix hardmins not being sent to SMU for RV
Date: Fri, 21 Aug 2020 11:31:45 -0400
Message-ID: <20200821153145.498408-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b35c341-4816-4663-9242-08d845e75307
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811B9CC108BA839F145C604EC5B0@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ/niywazvjp4FMWuQer9ztU1hy5Y5FSp7BZB5yT5elX88qeGVusYxQutGgxJAtEy5pcxS0/yxr3cqGeWBmBwWfccrvLc22zGy3uihgH3+XvZEwvhkLbkTNov/vYy3orRz67xFP+ZAIISkHAqTSp77PMhv9t8S1I9FqtSU9n5OQ+dxAc4MGF9nN+1B7U03NP4rbH8GTr8AKtQ1AE4L3IzreY3b/O1TWgHp5UaiFFmOoQZ/Y60zpmLxAsfyukaDcNgde4T2yDhdMwKWqau4TbpQnQ9yJ91baHMqTBQNJSGUArcsCZfzFatFYMqvVUKYusVk1Z4Yu1g/XSo1XeXR3LvRexi0450X09JtdpdYiFKEa8GVIzfVvuOStDqdGlnP8bOtaXZ3wp7DKGKLPgeGtLYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(186003)(83380400001)(81166007)(356005)(54906003)(82310400002)(82740400003)(336012)(2616005)(70206006)(36756003)(4326008)(6916009)(70586007)(47076004)(426003)(86362001)(2906002)(6666004)(8936002)(316002)(1076003)(5660300002)(478600001)(8676002)(44832011)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 15:31:50.4852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b35c341-4816-4663-9242-08d845e75307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DC uses these to raise the voltage as needed for higher dispclk/dppclk
and to ensure that we have enough bandwidth to drive the displays.

There's a bug preventing these from actuially sending messages since
it's checking the actual clock (which is 0) instead of the incoming
clock (which shouldn't be 0) when deciding to send the hardmin.

[How]
Check the clocks != 0 instead of the actual clocks.

Fixes: 9ed9203c3ee7 ("drm/amd/powerplay: rv dal-pplib interface refactor powerplay part")
Cc: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index c9cfe90a2947..9ee8cf8267c8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -204,8 +204,7 @@ static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t clo
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
 
-	if (smu10_data->need_min_deep_sleep_dcefclk &&
-		smu10_data->deep_sleep_dcefclk != clock) {
+	if (clock && smu10_data->deep_sleep_dcefclk != clock) {
 		smu10_data->deep_sleep_dcefclk = clock;
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetMinDeepSleepDcefclk,
@@ -219,8 +218,7 @@ static int smu10_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t c
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
 
-	if (smu10_data->dcf_actual_hard_min_freq &&
-		smu10_data->dcf_actual_hard_min_freq != clock) {
+	if (clock && smu10_data->dcf_actual_hard_min_freq != clock) {
 		smu10_data->dcf_actual_hard_min_freq = clock;
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetHardMinDcefclkByFreq,
@@ -234,8 +232,7 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t cloc
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
 
-	if (smu10_data->f_actual_hard_min_freq &&
-		smu10_data->f_actual_hard_min_freq != clock) {
+	if (clock && smu10_data->f_actual_hard_min_freq != clock) {
 		smu10_data->f_actual_hard_min_freq = clock;
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_SetHardMinFclkByFreq,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
