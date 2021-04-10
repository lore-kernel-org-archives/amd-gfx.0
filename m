Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27CC43460
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AC461178
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AC461178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4D16EC79;
	Sat, 10 Apr 2021 02:05:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299C96EC79
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5qYB93oWtyX/d6lVZ1beL8YjECDw6+2FLkPoPmwwGTdyVDXuLaTIQbpTcukkeLFAQxQrp91PEo/NqzapC1Jb6WsKjTFLfjO0eoRGNW/JtAR/2+nkypMSpmnH0YjYcVf4oa2whIjjzdkKDCpx1KHaVzQGioP32FVffdWiPA+5nu70UDFFK5NQ1rPjCA7LHfGKVn2590vvZZJEu3AH5tnFVFwwKzyMpMSXyGvPzQjXCYiJN4y3oinEZi68PDofC+AEyh2n6tuRpdkpQmwm2do0f93Mp3ZsXE0TozpNMVVTBWLqSwDoEYVihq1YmRuhBG8P9T3696EgeXxInFTeIWdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN3UU2Vg0vF3z5xDLVLfKqn31zl5V6fD7aNzCUSehxA=;
 b=hK9CJXYQBQMj5bCsOroFcdaVnyF6H5rTHtgt+uin4xK2Xf/OV6DHM+7v3l3A5TkeOJsBb5YGkaTMqnaWBmX8G+IiT0sHVDIYvAlAIdmOKW4wvTQBv1JbFmF0DXR5D7zVpHjTho35zkWJ2CtVmtOnDukNphiUxlUEr7rSG99FALUQhLi4QyBvc5rkvmQIziuDmMUWCoDGJwWliCwVLcairySlyBzxkbqVEuNedMnJAJxngcsN0ZcF/2GXMxcSTqqkXPTfzHc0N/43ZE8v/400y3Sl5Rd6l34clAZFzqXDAKVzQgMyo1lfhisVcsXok5jt+4aV4qorZus7MdHrbDCizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN3UU2Vg0vF3z5xDLVLfKqn31zl5V6fD7aNzCUSehxA=;
 b=IQ0EEIhucrQoKzMtFMh/5unhWj775abkxlDU8e/4LwNQ5h/SWbw1VKK4/BJo/pVQtJ+1nuk0MS3W/Ff+4CGPOdDsSonrp6WoduVRquKqYZzL+xpC1BNgMxXgAuAaXjxel9j1VpVW+v888GsO9k7vnHpT+zvifTgUBLZB9JejFLA=
Received: from MWHPR1601CA0001.namprd16.prod.outlook.com
 (2603:10b6:300:da::11) by CH0PR12MB5218.namprd12.prod.outlook.com
 (2603:10b6:610:d1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sat, 10 Apr
 2021 02:05:00 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::5b) by MWHPR1601CA0001.outlook.office365.com
 (2603:10b6:300:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:58 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:58 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: [FW Promotion] Release 0.0.60
Date: Fri, 9 Apr 2021 22:03:57 -0400
Message-ID: <20210410020401.1100228-13-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086ee9dc-d45c-48e4-5800-08d8fbc50bfd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5218:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52186C9C3500E6313B07AAB0F5729@CH0PR12MB5218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3W77Akc+iVL2tkSyQJ4e6SISL6c17dldQChL2f/aJQIxpiGxXDQ8lZqXawprlGmMEctSr+doxqchcMQPQkiofu+GNG8ExQv/4JmeBjUPT6hQx1N6b3TITsB3vs5/xbWMsQuxMR+0P7FWLlGMOJLHE0v2UTXw76av6S6bd8I758dv1NlcBsPlAZSnUbHmsa3/6WwI64rG5Yw2sJmFXi6RBiFK9enPeFdqV+WqfIOpVf5UYc84O/VbEyOn+uQOw9tFi+6oOG6PzxieLULutt3mEjyBllCuLIJ7jbavrICXbx4Bu+6h7+hR2rIaD/nA/dLtQSyJBmtd5HzYkSfgY1M/IqhTV9AOEaNAKkz/1f0+pW3Nv6WRRgrSIKq2F6mbPsOLOe0kSlRQ441CZuprRjb08CBgF8r5v6IoWNk1u/qhb5TBbDP9rhQTIvGhRP3k3FiNqfKhk0Nb4hSo8//yevz2aB4+JLw3j/wsD9LZ0LB4Eex9ZqHnXKxqtrSmOegFloAWMIekLjVOIVcGOSVcXC/iNKCGrE8pzzWNhQ5O64Jo9EIaqmeDfLfFuHkPmT+zJoe3Mw4jjv7fM0Q4owFQLJ3EqKPpj6R+EBN0Hqiuk+6DJZOzUULVPwir1qVKtRRAMqH6pK7N8p3vLD3Mb8g4veY3BSn2SMvx1CeECUVfR7cmjNfrl8I1BBs2G7pnSAe2jzj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(4744005)(36756003)(82310400003)(186003)(5660300002)(8936002)(7696005)(1076003)(86362001)(6916009)(47076005)(26005)(54906003)(478600001)(8676002)(83380400001)(82740400003)(316002)(2616005)(336012)(2906002)(426003)(70206006)(36860700001)(70586007)(356005)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:59.9587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086ee9dc-d45c-48e4-5800-08d8fbc50bfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 44003836fafd..9b3e31103bdd 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x7f2db1846
+#define DMUB_FW_VERSION_GIT_HASH 0x2abb8f41f
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 59
+#define DMUB_FW_VERSION_REVISION 60
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
