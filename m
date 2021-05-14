Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F9BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 08:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6945B61408
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 08:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6945B61408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EEA6E249;
	Fri, 14 May 2021 08:16:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756226E249
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 08:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me+6IW6fK8ppMBYGdmFWcN0jeFVFG8xUqmWbr31om4WerYMsCpEJWHUI/9dXfSyvVdDUzltG2Zt+SFyes/2DSGUaitUoPYbZmylPVT+yFeltV6TGMYEH1UNcX9uNW3Pq/5x36ML3D8ALnZcysbBZsTY2uAPxqdmO10LA6N21qnH8CorRk7SGu5+wMV3a1PGec8ss7WCgNmKfzwAw9PdJ021lkGwGQLwu0du+AAAXI1QZofOPp9UwGlxPzME3sVCVFDbvi/r44vUw6KB7SPOsXRgGZn/QEe350+U0hw1ILA/xUnBmQLR4A9ejLtjL9+2nHQ/OMMowO+rjSpKVkCQQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeqoZtk/xHsH29/FmrsWMcnzQ0X81usICEXad1XcDi4=;
 b=PkqusI/xSJ9qenW1tOulTMotOncMcBLXaMLPhX5WsIgIu5kr2Sa7R0wJr8ntNKF3pXxGnnpbgFCl6GzMtKGyUOiP/ub4le9NzbJtur1l5wQAluz2h15VRhXWpSv311RACPrzqjvbANCcKH0RfGkPxq2Ef50FF+EJPsZy6cJ4v3x5ix5tteKlDQjDxZSetGdERb7GtVaq1QbAm2sltAZcs3ul6a2i7m910WE0OivEwNOVzRrNyncdgw8sW6kgjZRr0Z/leXNYDIneRYuOgRLM9Juolkap3eaY3WQTwa3wkMBh63A+lNtbO8pRC2KhyuHOd3ClCQ7TI5CC6Ek2aa2cUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeqoZtk/xHsH29/FmrsWMcnzQ0X81usICEXad1XcDi4=;
 b=P/I1mcu5fb97pp96KKgr9nWDBhClZ38rxYMUq+DTk2hV9cZoXmY4hhnBu/hi+mPdf/cfJz1it5bK9C3z4e6Z6oeFU0Q7fNKcREEzq8X2ux3e8YYQQtkE9n8/DILP2LMhd1HBZVOtQEqlwD8Tdfp/i5M4Do5gW+AYN8JIc0BdDkg=
Received: from MWHPR15CA0033.namprd15.prod.outlook.com (2603:10b6:300:ad::19)
 by SJ0PR12MB5440.namprd12.prod.outlook.com (2603:10b6:a03:3ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 08:16:55 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::66) by MWHPR15CA0033.outlook.office365.com
 (2603:10b6:300:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 08:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 08:16:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 03:16:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 03:16:54 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 03:16:52 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Date: Fri, 14 May 2021 16:16:45 +0800
Message-ID: <20210514081645.25863-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432c738c-1d28-477c-ea46-08d916b0a2b1
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5440:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5440F78F0CB63ECEB9CDF265F8509@SJ0PR12MB5440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V93enhqdPb09gy1vCw1x2mDMhJYNT+lAFR1QLvzP5e57A4YYZN5VUZyDoJWencpnW5totNeZyagg2myUgHhw7Vcs6L6+HLvn5dZ5dvMHafmV1piP650kU/pDSOFPTy0ffN8V3ODsZ6ytW3FuXr6CzwGqQOQOy41mUA1AoomvU8x0/LxhIx17GEH1o3RcWPVgAiTUMfdA5p/wO13G89bjv4xC7o0FJZOVTf9kIp7++6/RWZIwWm1HPWQUggw6xNgrot5cfly7ggClhgD0Q7bBFdiA5C2hGhV8vyfjW8T2fSZKSu6QEuyXw293Ya9QOKT33oLxGlXLFlyr64MML65brtccx6ui9/+Qp8ZRnHxXOvxF3VHAfyKJ4yTgAZ2PzR8YITAu0yDiNHNTFFbjKF7wI2IddsmcfwYlpchgi4/9YGBUTnhJ+xkZk70AeCTXEyi0VwmWuyIpvv07461i88Ch2JIssgut/+Y6zEDi/I1FEayTCDjekTJLdF+uQpQOTkT/BtDiqdu3rZuORhob1KX6eimLbGd0AcXHlv66d+774DvsH429+PNoNTd6tclv+46oWo9r9+lw7H4hhz8GDrkNpyZ0owcQRk+J0uLt2QF3cM9lPVHstVk9Ob4xmFkfWK43pGeYXS2AH87OKW3Vh9kaEHQGXNVb+mu7rsunrWi2xisGj4Djt5iO4Owu177cfBjY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(7696005)(2906002)(4326008)(1076003)(26005)(336012)(82740400003)(36756003)(47076005)(8676002)(86362001)(6916009)(356005)(478600001)(81166007)(70206006)(426003)(82310400003)(83380400001)(8936002)(70586007)(2616005)(186003)(6666004)(54906003)(316002)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 08:16:54.7710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 432c738c-1d28-477c-ea46-08d916b0a2b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5440
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
Cc: alexander.deucher@amd.com, emily.deng@amd.com,
 Jiawei Gu <Jiawei.Gu@amd.com>, david.nieto@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize unique_id from PF2VF under virtualization.

V2: skip smu_get_unique_id() under virtualization

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a57842689d42..96e269cbe326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
 		adev->virt.reg_access =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
+		adev->unique_id =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 32dadeee9514..9243e5de5bb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -686,7 +686,8 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	smu_get_unique_id(smu);
+	if (!amdgpu_sriov_vf(adev))
+		smu_get_unique_id(smu);
 
 	smu_get_fan_parameters(smu);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
