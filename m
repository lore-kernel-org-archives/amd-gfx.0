Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C182C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 06:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCC764DA3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 06:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC764DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F966E8C1;
	Tue,  2 Feb 2021 06:17:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8871D6E8C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 06:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI457qCfjJea6J4TuQFyYDSrGRqa+TZVABq3mz1LLndJvpiqNa09aHnHgMp9rs4os9qv9zobMapwGJOpNNnJDRkTZNpc3rlmlzS5y4RqhLUgEFhR+bpKt2HoO8WdxQNC1IiyF1QoGfdeO+/VTO2l5ymWKpIFb2SmuFjiqgKTJq3hLt74PiIg1pwVP0nPYYaQn7ranDzNaK5bve5Y//12hFPUqh/HV0XyTjtcmcFDT1QN/5RF+KTtUjhef8jiMpidYC3rE7acb2BFo87EVgTA0DMyymV0ntGC7lH3/98MdUJO+HR/w1xHrjo4DD2vaSXoDSrmw4NT8O7Jt1xF7JrvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXYp5e2jXmq0izgR5nAuE0rNUFG7/LoN1fgJ4HJw/PA=;
 b=WYKk1s+vmNRoeJdHtkkFjnQwNr9AI08j89Ck/+U1nWwvxIgIo82Ed+rxZQeug4vHp5y6kWeT/CvkHCs4ZahBUX4Zv3xtuUg8mvwZK3ShN5WtJCimnPlAnTH+nN5Go1OKNJT9Uh80aNzeh2PyQZ6bAzqeysYyNXM8dOyUJa/0Xul4I6wxwKYTHEHtWXx3NxraNXLMJXIRVz/FgrFBXj58x9bF/tFLky1aDE9plXlrGrCq5TSwDi2wqOrFxw0Yot/XewlpvWaau+LUUTkwzAgNizOTITh2TOHBaLup7PdPnFKJUNUGDBx7bpvyIrZHktLSu9FCnJvOhUkgV8l9naqsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXYp5e2jXmq0izgR5nAuE0rNUFG7/LoN1fgJ4HJw/PA=;
 b=VrG28Ei0x+zEpKLCOAePNKLSQ+SUwXcotVMhYUKy3/RzP8vcA+mDRTst5IMasfcs90dEhqZNfHOI9uqfhYxfCqP/1mObGQWwMofK3SNCINggUHQ7U+e4SFqzfCW/mdMhMDzVUFkq2OuTVszLD7RIqt7cfC5/F/BCBGElaEIXFTA=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 06:17:30 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::ac) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Tue, 2 Feb 2021 06:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 2 Feb 2021 06:17:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 2 Feb 2021
 00:17:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 2 Feb 2021
 00:17:21 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 2 Feb 2021 00:17:20 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add otg vertical IRQ Source
Date: Tue, 2 Feb 2021 14:15:54 +0800
Message-ID: <20210202061555.5731-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0d4134-0c5b-4130-d1b1-08d8c7423728
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:
X-Microsoft-Antispam-PRVS: <MN2PR12MB427277488049F68219CEA956FCB59@MN2PR12MB4272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9BxHKFHKyMmySpTajvBCSmT0R+zYVp6lCTncjBZ9lHPqmznxgQR3OXDJ77jesafWRr0EI0gj+6qi91+C55tUpuDdt9OGB0U4DhHjO0AaisuZR8IkxdEmgYa10Eie/OR5e0O/DGsFCqEOX5TId+W6h+UxmY9cYqrRHHzYtP+r1u+LXUDVp/WTW4Gq9Mx+qoKnNPxEzm/PjsndKvL1gT22aO4fZASzCNwcAxEaW5MUkZrYHjzlMOJ8ktFfTLHlOqTGHbanbbVVd/MVtkwyxW45gFDqtK5BnmfeNN+wxWCdH5u5NdfjJTdEghtgd2uXZsFifaRVuYHNpyrwAeOougk+I+LbTeKp+1G2gN1mMz7+9LQeFWiImmBDnaSRK0DCuiCnK6HaULyT7++bpxr8vl/jwZCQw0w08zd9UTO0i/eb97tfJYjmpaSPkw7c4o04222foMdpUuETRjxpaMYqflke2Liqw1qYV5ywOmT6Ba8VfmX9KbBuJAiK3g0O5+rFeS2HgwbG6lQ0L6SohQumbTTLQ1BINnlYDhHbAGoN7MG9IdsrYrMZQIWQnfkjvH4VhYUEVJJdzZYMCdOazBO30k7/0pxvaEoy7sfJZX/qC9i4PF28TaYoVFE6ErPIhV3r+XndGJLQxkU+BtFvRYAt1+f3l+Ci5lKBLi6doH8Df2K0e0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(1076003)(81166007)(7696005)(83380400001)(82310400003)(4744005)(4326008)(2906002)(36756003)(54906003)(356005)(70586007)(70206006)(6916009)(47076005)(8676002)(478600001)(26005)(186003)(426003)(336012)(82740400003)(86362001)(36860700001)(5660300002)(2616005)(316002)(8936002)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 06:17:27.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0d4134-0c5b-4130-d1b1-08d8c7423728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Nicholas.Kazlauskas@amd.com, Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
In order to get appropriate timing for registers which
read/write is vertical line sensitive, add new IRQ source variable.
This interrupt is triggered by specific vertical line,

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ece1b41a31f9..3777f18fb1d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -852,6 +852,7 @@ struct amdgpu_device {
 	/* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->dm" */
 	struct work_struct		hotplug_work;
 	struct amdgpu_irq_src		crtc_irq;
+	struct amdgpu_irq_src		vline0_irq;
 	struct amdgpu_irq_src		vupdate_irq;
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
