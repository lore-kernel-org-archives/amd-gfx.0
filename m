Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA5BC64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 09:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA8510E5ED;
	Wed,  8 Mar 2023 09:34:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D9210E5ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 09:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWMY/QiPdxtrd5hixGdliZVQpybEKS8rIlpJpWJlUep8HeZ2n2yhSihXxLJUZwoYsuonVxCL2b/sVG8td0XagvBIq5DvCX4xFmH4+ejNqjPmVx7PjL3GWH8O1+MUnEQsIRPmzngGqoYXEWhT5L/q+VHpXKbVeFv5xfClbzt4hHZeykEmR4LrgvjK3YDr8sDYa8RhGCX7geC2+jXrj7kWlrnZsWE39AMPONOxUztFE5DQgfhfd1lO9Sm/V+IUkcpK6smTK1kJgdR6RdUwV3o1D7HRmt5/RTHXpYNGGAJrrLnFpZbD5ci2qVES5LBWsKl0IQ3Az3G3f3ZItqVw7+QuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfGIqx2FuRuQHNvr5H6di8EXgr176//MRs/S10oJ38g=;
 b=NagskDA09V4sem72CbM4XpW7tlEj5fRM1vXHvOROV4GXVrHcXabKNGM8E3xhFoB5j9UDwWLaWyNlm2anS++6MaTbBHEAPmUX9rZnxClUjI9Au0qcV+5ZV6HfKv1/IUX0BpPm8+ispX1ArSFybQn4klhDpaE1TNtZHXBN+UWUEa1S8y+3tN3GJzJk97WW9KAc6PrSn9MA95aINLTAbHPzky9xdfYSbEdZExIiJL9EljLR84nfHwY4oULspI+PKoc2daOHvMem/o5dSClvKClxLtViIfG0xSQBXDth3dLSSCqBzFiAqCMz3JboaD/EmELdW/To6rA85HtDiLiAwh++7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfGIqx2FuRuQHNvr5H6di8EXgr176//MRs/S10oJ38g=;
 b=o/CKHUX2DA47QTgcJNNVH2ev03UhBnVyIij8ORAwVsWqXbwaeJTuzNSunvacnvkUyfai7dI6tRPKyZKD5j/VPBb8QGiqK13ecLCReDGgihznHy7INj7VkOo9euSCc7q+bpD7gh6rZvRzWjIiicgEXnOmmcVfnyE1vPrg1K4qBhI=
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 09:34:24 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::14) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 09:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Wed, 8 Mar 2023 09:34:23 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 03:34:22 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/vc4: Fix build error with undefined label
Date: Wed, 8 Mar 2023 04:34:07 -0500
Message-ID: <20230308093408.239331-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: ff252ea0-0b84-424f-1ddd-08db1fb84d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfOjyyE7k3on4622jq2Yg/BvGU/pBF+WcWRmouT2ZofWVpZjIVvoWq8bsOS6uNToh0D0djwVMnY/2kts6lDMUnGKaJdRDj7UdDNlAFaL7tjQEZ5ZYn3tJBZEdj3IrdfOStZcGXVRntjWaknRsjqCopowX6Uj+0M+ltjEyLFcJ89cXVEWlghP1zzEK919h1LcCr8UiN8BGDxv5+pLrHDOQzDexi/E/C0iseC68EMsJGsKO/mxJ+iljY+57Wdv62W6Mww/IqWCshFkdVhkrxLJP9IKl6XS6VybtFwPuW1lVGBp/oyNiNFwwRYnRleSvXl0g0KKPTCETZnuqXvyHVAeIqJEHsIBF8bAJnjbusTDHy7rKURiVmtrrVo2I/GMc0WQsYlcAkukP/S/somhFh4Uyk8x5NgiQWjnI5GSRJcRfgj4Mr/TEsZK9lg697Q/4eP+Ydv3ryyzUXz7rBTvtt4AQ2NEafMnFXXOvWl+RHgW42F9ls0VD8FrWrZihHFz9a3fee6E9zVP/XtITGSVidm7EtfBDFCK7ebDEv5PvuWjQSQY5FCi1DXnY19trjw9i3BHp013IMFWQ8w3Bq07RCFI1lAptGuEhNTVAbKudtui5Ebzha0gBZxhj81gBtt0oSm6ei/W3dsIOLGhCeBkgVv9F9FjBVekl4WmpkD2ypdKgZK9xy2e/TqoD3T13jakb1NZnD4TzkyVDy0mVShkLUOtVwKNIka2Wi0hR+3+Hq498gg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(336012)(82310400005)(47076005)(426003)(6666004)(2906002)(83380400001)(36860700001)(16526019)(186003)(1076003)(26005)(82740400003)(44832011)(478600001)(36756003)(8936002)(4744005)(81166007)(5660300002)(356005)(2616005)(316002)(70206006)(70586007)(6916009)(8676002)(40460700003)(86362001)(41300700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 09:34:23.4395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff252ea0-0b84-424f-1ddd-08db1fb84d60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
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

[Why]
drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_bind’:
drivers/gpu/drm/vc4/vc4_hdmi.c:3448:17: error: label ‘err_disable_runtime_pm’ used but not defined

[How]
update err_disable_runtime_pm to err_put_runtime_pm.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9e145690c480..edf882360d24 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3445,7 +3445,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	 */
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-		goto err_disable_runtime_pm;
+		goto err_put_runtime_pm;
 
 	if ((of_device_is_compatible(dev->of_node, "brcm,bcm2711-hdmi0") ||
 	     of_device_is_compatible(dev->of_node, "brcm,bcm2711-hdmi1")) &&
-- 
2.34.1

