Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E06C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 09:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE3D10E5B2;
	Fri,  5 May 2023 09:10:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143A010E5B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 09:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/opyEISHxfOCQpYXtSpjaAYf0pxHNDLTnUqwAwN2sO1ePw/HHsOVmEpLUlH9eqifq75oXNJFBlQcY+7zIVYu/sJcYVbM/IpwK3+ZYGR5Mpfu2dgOP46jElEN9pZNMB0T6OkH5a528UQnMAY1EkOFnXwXPhncAgZ3EOmge+pbH4d0sopTNgpKtPYqMtHzpABdkTY5ChLoMopQt55SnY977sUV6bW44mr7Z71oWoRBV6Bh+VxGZOsqjwvE4CJjapVlyId0Xsn8/zQYmEpfcFx1tP5Ilzcz2g6rljbaw2zKMy8GJ6plyjUoMBbXtXN/9SmlAZ1OYj3/FAVOF7RDvFxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fcx0+9Z0S4JVxBmV066Yj50Wk2NkjsWgn1xIElnyY+0=;
 b=dh5VVLyHfsm93vyI3spPY/yW6sJNa6eT09negTz50n4OUGzB9wC9z4bcCsZcvqxqjUZSUJXBPxHr+fjr+vEdVCApH8AXxeBAK0kvALqtlMNijL2AUwVx9212u+dzucXr2VKvVxyeuINvCJLQOXT4qIpgnry62Svg6wZ/6MRiOSzR3rImJ1qx7ZTQwXFpvVij8i38mg6zQdE38PcwOBiZ6mJhsLhmuw4X2iBmXWsBbU+IVhNwIVS2qje6R53i0+MPP9FiwUl/K+s8aHlCDJpdiHBP44+1FTTNgk1hsKspUcjGfwAJk92MFyeCzIJNqLUfcstjP78aQslAm6ra7sMRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcx0+9Z0S4JVxBmV066Yj50Wk2NkjsWgn1xIElnyY+0=;
 b=pyqPchZ3GCXW99Z+ZvoqNJA77W6bJkkpmkZS3zBN4148vPns/8TzX52GfMOP2ojamb0qZwp4P9VBX3rJ3hP3rW4rO8YUEvucEd3Rkqqn4/aOB81O1+hfKjbGmeBGozA4n07rqKm1yQ7QcYMiGTZ1TEnMMW1Hvnj/KQJWfoDmlvY=
Received: from MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::32)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:10:45 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::e0) by MW4P220CA0027.outlook.office365.com
 (2603:10b6:303:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 09:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 09:10:45 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 04:10:43 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: avoid null dereference of fence when using cpu to
 update page tables
Date: Fri, 5 May 2023 17:10:20 +0800
Message-ID: <20230505091020.1383923-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|CO6PR12MB5492:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aad1d0-1c26-4ec0-a712-08db4d489c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /l2SLiqnoWoNZaS0xNgqjAdLPc7uT18mD2N3Q/QSAxh1qlugGX1xK/Ii5T6855WmZrD8w0AQ04bqy2mb91YlINL/pk8wQOsD51DAjjlBLwbo/6gh9g8aLpFMRwyoEV24MeTsPKz9sqYDyIjPT5AOlQnx7gGzAhAhmaOrauja6RUMeXSSj+wAsc90BvfTdc2rwCw7zOYEGjFrJQICEfcPPphv+t/4067kS4XbxUeYpDtMOofUqEEF0nkMa6SqGdUJDd5v4NgsvJhYD4jSxWRIzumDI37rHRVElLmQ5764ihjWqRWr1GgFhye3k0Xx7cnEaqURTKgTtdrW4f/n/j+LKv6dWSjGsqaG93aiOU3dDluoyJQPEepILqX7A3DaHhoGERhxSbv3AZQb6as+fTcxnY22s8nF97uFrLWEYgHQsqJk0t1WecycfwpCfwKoOpgQFEOxpIBCICfnki5d2q3AzF72XXjbC76jLvHfXWi9WraRAA1KAWJ9YHifbdMSzd9z73uUdFhPQmQ++7c5F4Oz65fDzH3qWhowi5eBhQK8Vs5DotGUWa0RnFRZ6lpux8+TmH6fKbzxk6TBu9CargeyL4Uu+zYAOJA1cm/a2t/kz/0Cm+crUSOqM+bi78eSADdGKvLUl2uVCxrlyIQzPxRKgikupeuAFqhepLnGYcPJ4KKtFGpRugKTGgft3oCjXQvq8G1Vx7dJqqJZYviLqNZhFfoNDMACiHM87TV0qRCXBZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(82310400005)(40480700001)(8676002)(8936002)(1076003)(26005)(426003)(336012)(2616005)(2906002)(15650500001)(47076005)(83380400001)(7696005)(41300700001)(16526019)(6916009)(4326008)(70586007)(478600001)(316002)(5660300002)(186003)(70206006)(6666004)(54906003)(36756003)(86362001)(36860700001)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:10:45.5477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aad1d0-1c26-4ec0-a712-08db4d489c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using cpu to update page tables is sychronous, no need to wait fence
and it is NULL in such a case.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f0f00466b59f..197981c4ac7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1043,8 +1043,11 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 
 	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
 
-	dma_fence_wait(gang->process->vm->last_update, false);
-	dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
+	if (gang->process->vm->last_update)
+		dma_fence_wait(gang->process->vm->last_update, false);
+	if (ctx_data->meta_data_va->last_pt_update)
+		dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
+
 	amdgpu_mes_unlock(&adev->mes);
 
 	r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
-- 
2.25.1

