Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9746C4707E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFD4611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFD4611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26EC46E52D;
	Fri, 21 May 2021 17:37:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F916E520
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH/SphkErnkOV1B4w+29HNzFF/yDvNl1D7iWXH6MMUFrstv4PgrbwKzcCfQeNM9xrLewFrFkzMpU+tKBFHI8xJg4FI9P4RCzFBZMhdxCCLYUtbbyYt/tVfs9irFlnpjFsx5dZG4F2xt0waIJYsbTTJZyQxXI0Z2cryfSVXn7jJKL612ojVsNysC5Oqw/rJvteiYy3ATG9sYY5MUvXIOgSxdK4YfkdlqBQNBbTxFM9a3iDXC9H/HLRZSk4onqMTJr1ViJxEG2HotTsSIvxRDmVIs3tuWOWJbw0SfcJspwIe1frwrifGpllrrVAirLi/wYQnAyF8g5aXgQ/LJHTou0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2lGQN3cxp3i1xD7dAh2CcYle9WZ6Bv2hYPhacuOCGg=;
 b=EXm5Ocga3gBANXZ/QtCjcc3oLx/Fg/NEVchZgRuRbIrZkXcQ8GPRzsh6x2ZD9oXIF29ZRlydbExpJE/Ugc4cOP8xkUPzN3V+QPAcCC1QuLfPI5bIqL4/tP+ed+JEcjnuo7qWBDOzsGAMuNOoCh6FH3uCLR8mLlJTayCsX7GkXDzJkQjfU+T40CA85EqUD7A+dVGalB4V/83LvfR/0T1QmCemtDDqS0mxlEMmyFdt++Fs4Kgx/FYS7TKEHgs3IZBnp+MQcla2GGiaOUoIOzxihMvMN2G9VwkMDaA/lFDgjdkkuO4hLa3L1MR/vSUY3epTdC/OYoVr51KKAXZkqPLTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2lGQN3cxp3i1xD7dAh2CcYle9WZ6Bv2hYPhacuOCGg=;
 b=EIyMMCKsAv/894Pl2AYr/+uDrwWU1MOHlWXSMMPicx4z2z55k6iro2FGMLfkkszZW5MB8Ixlw+ACwop+g++/7bj9fSy3Ul6fkCEkdS2oBHMNn4F5ENOpKqqNM63EZvLj53muwTLL7xATziy+kG+WC0LgSn1fRdLylz//F7hD2Ro=
Received: from BN8PR15CA0068.namprd15.prod.outlook.com (2603:10b6:408:80::45)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:37:10 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::5d) by BN8PR15CA0068.outlook.office365.com
 (2603:10b6:408:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Fri, 21 May 2021 17:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:08 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/15] drm/amd/display: 3.2.137
Date: Fri, 21 May 2021 13:36:45 -0400
Message-ID: <20210521173646.1140586-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b62161f2-3aca-4c69-59d0-08d91c7f0fd5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52840CA5682715793A2E87AAFB299@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3ElG2VvSec/FbNJH6FenoDPtN0lZZdBH+svKGCNiCZ0dV6NjWf1jhRbrK6+QQtu1Y/bKSEdUf8vUP88XESwPt+zr6nyUNoz3woFHiJK8HslYB5cHJiqxjr3nanSWUEtzqHYnOrRv3Tklur1xsPihl04otKUpv0P7zxCP59Q5/HQ3yeDMav8dDlZAIfet8hxMgHBTcdofSnucFH3BbG29sha+YuDIbkIIDAN/foEZSGktVAizqmdZojCXfS0gVMGZ1lmSKhF+rDhUAql2xTtR7ewcDQv1Z56IKljcXyyH74H/PHtEqFe1c8hoeAyojNawpRex8RmmpzX2iC/JrQucnNGnsLkrmXQNmW47jkfLU6ptrM9XnYTeRNpOgEYxHCbQBHFJu/hUX+46oxN+rNH2aLxoTXNFPpMmJdYgE052GgJZuBfLbg06KsTeP87TbOQvNTZMc5kVixgG6amrBMgiYM9QEdlgIcZ3c2j0ZcEVjTW1BW+Rt1roBVqbX/WVW1UUO24dXNFKs1+zWkD3N9RYzFU80FujwKC+O9aTVS95LhTYW9dCufJ5i5y6N4QbhbUj90viFIlbWW1v+haszCwdgHTWqk+2a/zCF1Va61yjJRCJ/hERNJhzPYCYdpb25nPUCc8t0GLB/Rxot35+jhQ2qclRnsqrHpJeqijoBgLQGSo1j+9BmV4a3I3seQUi9cq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(316002)(6916009)(1076003)(6666004)(4326008)(426003)(86362001)(44832011)(36860700001)(82740400003)(83380400001)(36756003)(26005)(8936002)(2906002)(70586007)(478600001)(336012)(81166007)(8676002)(356005)(82310400003)(16526019)(186003)(70206006)(47076005)(2616005)(4744005)(54906003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:10.1270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62161f2-3aca-4c69-59d0-08d91c7f0fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.137 brings improvements in multiple areas.
In summary, we highlight:

- Updates on DP configurations and clock recovery API
- Improvements on DSC, link training sequence, etc.
- Fixes on memory leak, ODM scaling, etc.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7da5e7a2e88d..1b923172244e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.136"
+#define DC_VER "3.2.137"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
