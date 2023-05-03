Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4A3C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 12:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CF510E28D;
	Wed,  3 May 2023 12:11:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E50F10E28D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 12:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHrE8vEQsV2n3BhJTwjE6B+bJTqY5AsE7b/PE5/1Lyy7n11glLhix1GQUX0K2vVbu73uibs3NTW/htGMehqLE2GC0x4yA+3KZUFOstvY/hkJgwI08OD3vmQMDelCCY/mDLrti2sIppCeJWyxMhsr6k9xOMlyeWUaoEApV9KD5ENuVPEGGU6AH3sBpj5Htf3CYmm4q+qTuuWypAbkMVhn2S41fSwVc8ZwTn10/xX1SonpO1L9KwpmU+PCVZqEgdywSAoKZq4HCA7oRsjf/AJvyY+lEnuTqfUbnKI10guU6hlBG6hQoM2+xWGeDhTtJRsiktO+MaFxJ2Nq6VshM+H/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sglySV52MpPyGeZ+cewszOm+LUiKRmB/DcuCiesjH0=;
 b=eddGgz0QDV1NDEiwf0iSk4tMVg0ITE5qOnJzRY9mpwCXt2xlPDs42hE0RE4q4E95mRxHrEp4Ms6oMtPi3gy3sQHUjJ1iUh81Gl2cJWxO5BF0UT9a7yoPqf8+3vpuvJNswDax0GBN2jFf9/FxgoGvbfDXlSgo/p/DVt9K5v2As3NDBWwMQoSL/SZJqt68LYUDujbwnrfxCxiWG2R2veCXn9eaVJ7JqtahDNFhiVk/LhSqFNdiD+Y7W5Mz0HKisUOFqACFLDftiNy5j7ZMAE19MtNOAWHUWGs/dzau2moxsv5Bir4tag/lHRlnchQBWGjRbYfVEfgPnYDvQQvfN2dOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sglySV52MpPyGeZ+cewszOm+LUiKRmB/DcuCiesjH0=;
 b=YIcZxEe19e1lhDHTnHU4WWz6pVxtuFXvq6q6nQh3V1EQKtIIHS6vNTPqaezVDCH9/tcVBE8SLhiEhWZQWU0l7IhA41CN/5W+tj54Lik6W8ewO9M3YUuTiY8fT8J+Zcczi4Oqfn37HtJSMdGX6H+jV0B47B4HcvGIjpP7NTvbcUE=
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Wed, 3 May
 2023 12:11:13 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::71) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 12:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 12:11:13 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 3 May 2023 07:11:10 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop redundant sched job cleanup when cs is
 aborted
Date: Wed, 3 May 2023 20:10:35 +0800
Message-ID: <20230503121035.974285-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 637dbc20-6d57-4a4e-ce14-08db4bcf7d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vjs6CQkSJ8MbYrTuKbOMtpYc/cshK1p0KnZlFFDmHAe9rF7R6onxsUCgQaa+NB8QaBEFDddKfQKy778Qb/JHi6eg/qM+tjYnu8nASSz+Q43XY9ovRIb7WsOBTsiOWF12MIFH8ZwFGvBaX+Qh+4ezmPR82M8DeR/qhmDZihx2RTvpZgfLihAbg8nxxe+bEujhaX327mXXjmB22FN+fxQz6g0ekRJ0DjG9obeSRE8mB6rqfvUz0Rb38Pk3PK2dTC0EOfm20S8uUpJug4Y4MP9CNcSTuwY9xNbjzGlbMPGgrpNA1uPaKmPLFBmbomoiFXRGSMbsXtTsBwE2BEZw1wl26f6NhoS7C/Hc5Yoj7tUUIg/RanbV8dCLPM7tHJiC58fUyahXUp9ONL6VWnjwAXit7r0nKFLln+tCiEiek+XaVCqryzYHSdVaYAmoFlNoVJWuSpcTJdzg6uqnQpdfzoOZVmxna/hjHVpletg+zbPazPnhGNDUlufEsq1INeydY+4eGWYPKYVaV2V4SJIOFTHY1yn5XrG7rJB5om+RmBaukUGsbAMH+QjZc49FJ/W4jtm+j2ntKR4cdNgS4pe13+NxxKFRItqd58DQ/eP7Qi1QGyoyI5pckZYH5NtDu3yGwvthmCQmJGFjKTzO9ogQ9hV2ErF+68l5DRgw7/JTo/nfTwwLna5COcyzUxG4YQ76wnY5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(81166007)(40460700003)(186003)(16526019)(41300700001)(110136005)(2616005)(8936002)(8676002)(36756003)(86362001)(316002)(336012)(44832011)(36860700001)(83380400001)(82310400005)(2906002)(66574015)(426003)(47076005)(5660300002)(82740400003)(356005)(4326008)(6636002)(40480700001)(70586007)(70206006)(1076003)(478600001)(6666004)(7696005)(26005)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 12:11:13.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637dbc20-6d57-4a4e-ce14-08db4bcf7d47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once command submission failed due to userptr invalidation in
amdgpu_cs_submit, legacy code will perform cleanup of scheduler
job. However, it's not needed at all, as former commit has integrated
job cleanup stuff into amdgpu_job_free. Otherwise, because of double
free, a NULL pointer dereference will occur in such scenario.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2457
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index cb771c73cd07..9879aac3bcdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1303,7 +1303,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		r = drm_sched_job_add_dependency(&leader->base, fence);
 		if (r) {
 			dma_fence_put(fence);
-			goto error_cleanup;
+			return r;
 		}
 	}
 
@@ -1330,7 +1330,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_unlock;
+		mutex_unlock(&p->adev->notifier_lock);
+		return r;
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
@@ -1377,14 +1378,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	mutex_unlock(&p->adev->notifier_lock);
 	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
-
-error_unlock:
-	mutex_unlock(&p->adev->notifier_lock);
-
-error_cleanup:
-	for (i = 0; i < p->gang_size; ++i)
-		drm_sched_job_cleanup(&p->jobs[i]->base);
-	return r;
 }
 
 /* Cleanup the parser structure */
-- 
2.25.1

