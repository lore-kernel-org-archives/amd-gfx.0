Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B753AC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B57C23B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B57C23B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF7C893A8;
	Fri, 18 Dec 2020 22:29:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A9A893A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0okBbSDA76O/zXQOYYyu9Q79Y1KQlGI0f0WbnDG8s5Vhik/iBC2nRXxJxv2o7B6hcXrUfrV/eP3ySdF+W3zcCo5Kh7ueQQlKFZjlcizZXaYpnMS+AKBYCJrDFLXwVcMQwe/ng0TaXqeQd8EG9WmGBOZT1Xf2Kims7R6SYmFoOCYJEctdnLQZjBUrjVg10HvaxLhjIR9CnBNth/YdmtGttLRmfgbj4edW9ykLs3j5zf67t2oSbFR3KXgUlZcob3E8aLOSSDj4FJ6HAf0CrD8MIrQUpinoD3/L8Te1xddC8SCzsp3XxwQaknYenA6OwlSpSxgqLa4/BUQ/VLPbeHkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSDEXLdFlK4A1ti2rXJQixzEjTzq5n+py/Q02i7Z3c8=;
 b=GBEu1L54cCYKJbomrdV/aCj5w6mKYuW/J9fQ++MeLbRRYu8r/bYHfevwMtGnYbnorA3KusPkIFjbo9t34Coroxe80LK8M3Tka4rCbGq1SkJr4zwrxX7XYPum6FUR+6BkgMPQppsm7kDBdichUn+r68EeD9j4oxoC7/8TBcar88qgG7RozNLsZiPpG4HI008gD/5ZyamMx0Wxm+qYlln2ujz8vlg8YhXv7a/P+0r3BzwVhsXamQSjGRIrOTMkWN+UGnJjNjGGhThrWQpskVSgSskLg3kReK8OfVsuwf4fEXBZQihMaHyK5ZcN5bXGeZbMCt2nHW9KNjl3ymM2rVCA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSDEXLdFlK4A1ti2rXJQixzEjTzq5n+py/Q02i7Z3c8=;
 b=F4lSy0UoMd3C3GO7AG7WLYfrDR7Z5komlPtDr6Turl8rB7wnqUbydDU3zjWaWl2hvD3BFVyE3CgTe9k0vbcfvT4NbiqgzuBKsvEl/XRwjyaOkKx4NWsau+yBQcf0pvlSJxMc1RogMiUGVHPsVsGmIi1mll7QePLl+WGAUkDkc1A=
Received: from DS7PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:3bb::32)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:29:52 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::dd) by DS7PR03CA0087.outlook.office365.com
 (2603:10b6:5:3bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:50 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:49 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:43 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: handler not correctly checked at
 remove_irq_handler
Date: Fri, 18 Dec 2020 17:28:51 -0500
Message-ID: <20201218222904.393785-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 975041bb-9cc7-4dfa-381b-08d8a3a46ef4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4932:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49325BB0E4F11959244DB1BBF5C30@BL0PR12MB4932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uTMfEBrE41BY5llPHGQvhH2R4uCrIZCRs9wFeEn3yJ4Q/T3XVL4+oyXskf+gIM0D0fN8enMqiLgKk2xfazwp2XQRCtYZPU9iZtI9qdS4FLDXA1CwFSMrYKdiBh8aF/lXhe9c5JPb1AE2Y4fp44IWAK4Q5RfF8mBnaeETdC+kzRwPf5ohF/B8nBSNPHn3mhMUV58nizk8ZcGpAoFw+2uiLRCG1wSh+nGM093q8RxxzPCcMfafkk0q96Wl6DGahT8eIG81Q78rSd4ui/RyoVn/XSI5pq9jw5RyRmTT/sAGV4SHhX3cgk0Yk0ND55PZT1oMhprR2nCdV37d5ydTO5DUMsqJEiB3JwBUY5m6yv1EMxVCt97Arxgd0sUV4x9524Hk0a4bX6cT70yE4DnUVFqOE0hgOrhRFMnBu+p1DjhjnHeqaQxuoIxQaAbbv79QyuogD8pQzrsf0DQXdta5kzUwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966005)(8936002)(82740400003)(82310400003)(83380400001)(7696005)(47076004)(356005)(186003)(426003)(316002)(36756003)(54906003)(26005)(86362001)(1076003)(70586007)(5660300002)(336012)(4326008)(478600001)(6666004)(6916009)(2616005)(8676002)(81166007)(70206006)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:50.3428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975041bb-9cc7-4dfa-381b-08d8a3a46ef4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[why]
handler is supposedly passed in as a function pointer;
however, the entire struct amdgpu_dm_irq_handler_data
gets from the list is used to check match.

[how]
use the interrupt_handler within amdgpu_dm_irq_handler_data
for checking match.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 357778556b06..26ed70e5538a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -165,7 +165,10 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 		handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
 				     list);
 
-		if (ih == handler) {
+		if (handler == NULL)
+			continue;
+
+		if (ih == handler->handler) {
 			/* Found our handler. Remove it from the list. */
 			list_del(&handler->list);
 			handler_removed = true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
