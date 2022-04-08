Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E6BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 01:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F3110E062;
	Fri,  8 Apr 2022 01:22:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354A810E062
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 01:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnYsCGak0jxfSdP4Y0ZxABVIA60FyYAKi9uu9VfnaVerei1g/GeKaYc0OjXnSVjDni6HhkqE52YkRHJj3T/KhoMT8BuX7TFVVrybtfM1tHe11PG1ikIBiL6s4PFMgLXFqjd7QtcijBt869EIcjAHJNZgx6H7cswzNR52a722OJ+QUHGVn+/TCCY/+H8Z3vKSKB23VGDt/+gJ38vC6mBh/G7IHEDLm0KdK3jBvEuZYwox1gZRI9tJiW3xd9PJj+Lq/JbIbwgQTypsveoW3NpZQy/7f29Ss5z7BGhLGguv9yxF0rCU0O4SdTnvqiUTaS1AuEkMVUkRdLaKdg/gnD146Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roZgQavUlnHSwum60C+++6RSiaKsrKIINvvPSCE8daQ=;
 b=Nvh7TgqwPoBK7sOVhRZTT43+vVaL2d2ci9eaJXzgOtpKr+klIRPXmLHlIgkDT9tR/xlnMhGsRxCU5MV32qiDsnoTVOhPp7+Qj3xqo3rHCr4F74iwOqRF7WTsFzbUmoJCYxfveVKtbPbejxJzbBuoriRY52pdinCmtBkHyUmEsbXHBOiMFmShMpPyXLb43Y2H3ea0oBWpoIvCoSb8gvqSgZMU6jiG2M0WS803ra+Ivqw+L5VEKZFX03TMQaAwwYdJqNu3QxzXylk2OdgQivI78Dlm/oNAK6gswuy6XwXu3X7UwaIM2C8ESiJNowrwrWkOd6px3FfmPECC/TeDGTzlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roZgQavUlnHSwum60C+++6RSiaKsrKIINvvPSCE8daQ=;
 b=3gUgchIccqNQUndVyr8MDACuAtabg9LcSu8wRGzwq5N5kXFD04kO1WXp9pbQ4TorsSOvoznqKMRCw42vU96aEzmLVCfoESeIkiy5dABkC3NAz+bUFLiag9brzCgpIkzFsCjp/B0Xr8iM2ZiO65eDmEZ/YnvC9ugriiId2eig9ho=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 01:22:36 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::78) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Fri, 8 Apr 2022 01:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 01:22:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 20:22:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Handle drain retry fault race with XNACK mode
 change
Date: Thu, 7 Apr 2022 21:21:52 -0400
Message-ID: <20220408012152.27045-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a32c1464-03f9-44ab-309b-08da18fe436a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18305452B50AE6778B1E0D9BE6E99@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7W0NcnpEW3wO8ZnhllD/cqkzMD205L9elD8vDcJZjNQeJTzoH99Bn5Kk0Ve8N8Z50WKjxyyrCOHBJhtbSvoRj4VDOGAeBDAusFTKygqWOHbkezRZMY3qfdMZUkfl8xqCQ5baVCHZqnn34NOiihDM7xDPv30B2qELPX30CXojElgZPB945QpVQNKBI48ePQnZaDKkN4VcwGsSArdULuSkUr2PWgZ0boF3AV+EgijTJ0n4thYYo9LIivvNcLtb8yGO+iCGK3jdSRxzdparHXY6l/sBJS6wg/Hfw/yNB7TOkS0FQcj20fcIuyzyqzM8a8c3wl9k2U/D3E9DLe2L1QIvJ64eXj1vRQaWDDrOCD2pxzBjgbtObM274+9i5vbJ+qAhIkWROfhyCvuXA5rQg2c8zwNjJeyy2yjTr4ctXwNPEv6W9wWV37gbExJG3aa9TG99KRttbFt9XLJmDTtyIViYOBcXOo5PR/bP2cljd0m+VGTxkWkLZoArlTUaimLgMY/CNu8K7RxHrMMEioxc4NZhKgu6QGbnQdBDlDTVPVpnU32Be+dhYvI+nbVgsd0qGOVF0JOnm+RfGcqBsKq2x7qnwq6+0ak7UXBCcXRbG2q3MD2xeEuHAs/cmZQZ0T5rRPUFFMMpEemDWOu0v1SxpRZeY9yjVMAadwB2qBOAKSSyHuZ4oFXHihHzyUer+vQw2XIWTVTfrPJwhDvoDLHpDJoww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(82310400005)(6666004)(7696005)(336012)(316002)(6916009)(81166007)(86362001)(70206006)(8936002)(70586007)(356005)(4326008)(83380400001)(5660300002)(26005)(2906002)(426003)(8676002)(16526019)(36860700001)(186003)(508600001)(40460700003)(47076005)(2616005)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 01:22:35.7357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32c1464-03f9-44ab-309b-08da18fe436a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Application could change XNACK enabled to disabled while KFD is draining
stall retry fault, the check for whether to drain retry faults must be
before the check for whether xnack_enabled, to avoid report incorrect vm
fault after application changes XNACK mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d011d620dfe7..c76d29a22e9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2700,11 +2700,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
 		return 0;
 	}
-	if (!p->xnack_enabled) {
-		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
-		r = -EFAULT;
-		goto out;
-	}
 	svms = &p->svms;
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
@@ -2715,6 +2710,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
+	if (!p->xnack_enabled) {
+		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
+		r = -EFAULT;
+		goto out;
+	}
+
 	/* p->lead_thread is available as kfd_process_wq_release flush the work
 	 * before releasing task ref.
 	 */
-- 
2.35.1

