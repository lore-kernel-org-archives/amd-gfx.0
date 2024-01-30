Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84F9C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 12:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D6E113041;
	Tue, 30 Jan 2024 12:10:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC55113041
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 12:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6nYeh82y+EkiEHFjqsQ2IQt4b/Yc5I6WxU6ny3eOw3dNOc6kxKc0ln9PB9lPHs25jyGDBwAYXLHofNY16vBUwZF9xEN86Iom7mpVwGa4a/jWhB8db6WlQtFB2GWQ0U9ZaiDYSzmaUkaJfMYDzt7ffkOuZnNzc3KtUB7+7+j+tYlfsXxuBQ3N2Q8d2F8oNbBmKcVvwQqwaH/1rHHYauBnN+YPddHoRNx6l9A5jArrMQPBiEdmuzsRtI4b5EuzVr5hNJrJHPPKGDKZuqJFORhqVswbVOUn6erdJfYOD/Y2AW25G1oL2vN7wHKK/BgW1hUWoABfh9HiWluhRr0wAo7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19HaWyudd5aicMznaBXgD6tgNi8Qn+84V/A1mCc8Kkk=;
 b=C9TjOhmclA7N3EcC3LQIUZ4to2wjFhLI4sy2tUYCcIE+kfrVJo5nEHcTwbmkDwmEqshvTrZPB2fqKQe5+sATyODnCXUdeR9+Y8J5DZidA0PMnCdFnfrdzqyDxoYVZRa9d0wnodvZ1gXjeu/xxV6G2Vt5r/sxysxcIZhkuZj0cBoV06plfV1YlzgSSsc2dMAYt4zu/84VmF/MtqVaAPIUK2Gj1xQyuJ8/MZ1sNtY5EI5PqJYtu1Eth6zDxOBs6mS10LEdgdQcz+dWwwr7+IcJN7NZjTAIO1PqkENLB4dvjPCawOGqY52SGWD4s6ZvoxWQ3WtqmVhfi0crzSoYGuZXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19HaWyudd5aicMznaBXgD6tgNi8Qn+84V/A1mCc8Kkk=;
 b=LAcANsrB835hYzJvRPua+H7yOUUDrTFRzamigi9pjImsUa42IkZZsbvhM5tEDP7v6oyFJJlJ1m5s+jP/vQytxWAgV1TwImzTY1HqEbT0lDPnTfd7dtU7xG84cq0b1ISDvzXbzkshk1BrPnkpGoSR6ftEdOwP9nSd14Pj8blTkm0=
Received: from SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) by IA1PR12MB6626.namprd12.prod.outlook.com
 (2603:10b6:208:3a2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:10:44 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::14) by SN4PR0501CA0131.outlook.office365.com
 (2603:10b6:803:42::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 12:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 12:10:44 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 06:10:39 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Need to resume ras during gpu reset for gfx
 v9_4_3 sriov
Date: Tue, 30 Jan 2024 20:09:58 +0800
Message-ID: <20240130120958.3007422-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: a57b27d3-3714-4bcc-91a1-08dc218c7c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22Pd/5Hn4PuuQpps+aaLgLV8q4BOyh4/UEKh2RC56/kZVSQpZdnkzRTv+Umwa9qfa7zNms8F/XqzOightD+mn+Sh7SAYF44DvOx5ODFY+7DnAZ/kGxuardubPYmwzesjG/+FfWAaFc8eHYMa9Z9Ndrhu74p7qG6HDBMcrWYwBY3Lvnqjh2M8Mq/gOcp6WtgO9tjMKYTyTCpZHCNeQzlwke1Mm2btLQVsM/KPvdXJaN1ZwuectcMvloT92/E/sZxBPbV1hawYCi4ntAYuFvxTsMlDkJXR2MTc0jK+zrtL5iEin1NS16V9i9LYIgulGgdqaf3Td5DXgtGhwmWCziBY/XwrobUDVEH2iSznMZ8ST/P+clQJnQTWI8t6iR/KkP3GECg1mpen2mEozE+yn8XYcIS4ubBxBWBaVwc083xHcVxnvdFOHH1ovik+bZlWYdk8+6xJaOBjZveTPkyLi6BriKQPOCuZU5C8U/87Hn7rlUPn4TwJFF4VuxmvneSD7axADs0OPwOoSF9nZEJQsa8qFIcbUN832ymzKaIUQrdByT6dCK92zGF4Tgc/+HsuPl/mfEUy+SUYaXPu3Ayb+hdgK/kkjcTL4v5+tz746Br6QDujik4oEziJABS+gGEAU8KJZTuowAhvhJqaJPZspmX5PGfkJ7cldZusGIfn/jhg1M2kCaNgNFW3YieFf5vjhOpPMhVpMm+9wntOzZjLQn16BgK+kd/fpLiC1lTJ+xNFRuzMSwp2zNg/zFz6r9qaQxZ/Wvx1qr6BHbavgmQmVCJJpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(7696005)(47076005)(86362001)(70586007)(6916009)(70206006)(54906003)(316002)(2616005)(6666004)(40480700001)(40460700003)(478600001)(356005)(82740400003)(81166007)(26005)(36860700001)(8936002)(336012)(16526019)(1076003)(426003)(4326008)(8676002)(2906002)(5660300002)(4744005)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:10:44.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a57b27d3-3714-4bcc-91a1-08dc218c7c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to resume ras during gpu reset for
gfx v9_4_3 sriov

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index afc0b4eb7f8e..3c393d7d9672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5724,6 +5724,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		/* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume ras during reset */
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) ==
 			    IP_VERSION(9, 4, 2) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
 			amdgpu_ras_resume(adev);
 	} else {
-- 
2.34.1

