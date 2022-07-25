Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4AFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 02:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3FF10FF29;
	Mon, 25 Jul 2022 02:00:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFDB10FF29
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 01:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLaEDaFS6lKFiABe97NFlhKQaO0FeLzQwsi2ZV92Mvf8Bym4elr9ooeV8Af1xKw/+XZyCwhI9H1oDjzD085FUGEJ6iUMCDA6vda6JUH+v4SQpm9udpgxu6wBleDaUl6NoTdmMn3dlT+YBwnxQHDRQAN56AyMZ1D6A57xwiq02wbB6NZxyBXSdgXTW9YYyiBIcRYmcwd3fKj7AZ1NcTojIj6uY35Q8SNE49HRCzU7daBqEERAPSSM7zVw1G9biB9QQzJsobXuTu5EhKX3Jg/GHD7tcZkwgQjIQRJoxZmDTV2jAXVt2JOM/0w30Xkiw8EEg8GA7q7kPBdu7orf/jA8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQFwNTWBNsr3iFNvM+xD/85R9NsrCWAqjU2liRhuuvk=;
 b=VpvKgmdwzG7q0wKd/mvUrVKR0AQz9Ii9Apg2elhFxe637u6juNYOOHBPkcY/eJNgTfeeKi8eZhW6Zn18x7erInkQM/yeixxqZn+WF0kyCD2DoBdnJDKEIqngiLN/0oyHRCPOsuHqy6osdqL/3cC4dZuCyEPNG2k4H1cJEjNmIagRJcLdUZYUA6UnMyFpHRrDuo110XkqrxgAjIsmOzIA3VgoPMGLSvyc7CHLjD8CiHSqTcXpLzhrUqKPSV9MVnrVVbQjfH9559U8uta5lLNOU6qlwsEMVsXlYeNm3oyVGdYN21ZZ8X5mK3QsZXOVi5Ps2ykwZTWwfwsZtSrjcRR99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQFwNTWBNsr3iFNvM+xD/85R9NsrCWAqjU2liRhuuvk=;
 b=dtWtNSRTL+sOsmz/mRa6QGPNHkLOaUhzqq2CStuUBUu5D8GQfJZSQw/RRYiTY1s3UZknqNOINhFiRoCPxQw4oNJmgBkCXaSTqLxOMxFJrKRYztt/HQ6sEslbN6mtT1XnJ+w77wSaRZCYDbkkZ0qO+biBWakT/eiONIajXg7StJg=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 01:59:56 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::f9) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22 via Frontend
 Transport; Mon, 25 Jul 2022 01:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 01:59:56 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 24 Jul
 2022 20:59:54 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: enable swiotlb for gmc 11.0
Date: Mon, 25 Jul 2022 09:59:08 +0800
Message-ID: <20220725015908.1434478-2-aaron.liu@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220725015908.1434478-1-aaron.liu@amd.com>
References: <20220725015908.1434478-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10846628-5b89-4f31-4805-08da6de15f59
X-MS-TrafficTypeDiagnostic: SN7PR12MB6768:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJtPZKPLArcX1R87FVliHwJnYMYJLnvZc4AIbUSQkSlKlcPW6ZZy+JfGD3T1nzST1zel/N6PUUtv3V4gw9glTQ72WNLn+Nr5z8P2TvfxJ38CdCMRS/YxHG2JBDRYVaCsSsJXpGU0d+N/ESZBOJjwLXlRNU9LKM6z8IL2asbQSg0vvsBLxFN8AgXFg1kT1BggprQMd+jCjD2hpVMmDldtdtdXwxF1JvfVxkR7h/XsBRfLBcTgBD1IMcfw9+IJM6zjpESYu0ZEkituQCAbL4ZBxnQd0cIUXmyDNA5caDn/OAKEeBJ0+vA6B78uribk7H62sCRHEre0ibka9nIg6ynA+iHXfwxqZuexAnmsufNWcEdlpomQkxhlYNjzRLHabdBYFXU89xMdJuFN2H7Z5j7vtChFs0rB6+KFHNljze53lvemWS/tu6Fbc4R9T0c7d28ivaRZZI4dmpnGY3JbeJEogGifrWBoH5RmxeYobTMhzipHZVAk+XD8Hz3xJeSapll3fh4jH7QGjAG8Fv4VypYp5MvO2DQs9xFRxArIPNhmRV9m2BLosqNwQAhv43x2Oml3Z1BTNtj4/RuXO1x5zSKsxtfdB+59CL1wikREJ9aFkDueEd+Rj2NnUiL+xFPKKZT7Zj46WTacTVWw4AEpGfXygmja9/O3wr8peuC5i49fmIb4DnoflvWb57+jFHZtMG4ammNVSgwXh7wDom1jPeLPqws8kejsZDncW39r8hv1/bxkgOWOZpKrfaCWUQxfx17clmqM+8IzKBvFIcJ0rhjEcq59ABymE8ZoQPz+BpHUn/2pEFuB/n9wEGOC3ZU6JjPmvprdCTejHhdUPujwlTmZlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(54906003)(6916009)(81166007)(70206006)(82740400003)(36756003)(82310400005)(186003)(16526019)(316002)(44832011)(356005)(36860700001)(4326008)(7696005)(8676002)(2616005)(86362001)(40480700001)(70586007)(8936002)(1076003)(478600001)(5660300002)(2906002)(26005)(4744005)(336012)(426003)(40460700003)(47076005)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 01:59:56.0477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10846628-5b89-4f31-4805-08da6de15f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable swiotlb for gmc 11.0.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 503e40a90319..1471bfb9ae38 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -22,6 +22,9 @@
  */
 #include <linux/firmware.h>
 #include <linux/pci.h>
+
+#include <drm/drm_cache.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
@@ -775,6 +778,8 @@ static int gmc_v11_0_sw_init(void *handle)
 		return r;
 	}
 
+	adev->need_swiotlb = drm_need_swiotlb(44);
+
 	r = gmc_v11_0_mc_init(adev);
 	if (r)
 		return r;
-- 
2.37.0

