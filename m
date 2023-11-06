Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AAFC001DD
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 10:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C5F10E2BA;
	Mon,  6 Nov 2023 10:40:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6738A10E2BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 10:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iypKUZNZoo2aCbaG80GWBkgMpahNJ8VqKCg0S2iwAtxiT7BhdJnvoLwLuAQfcJuCBmlzStg1BUhL36fNxEcrasPucC9wJKM/EL22CxzXB7d2/V485HSHaGpmzD1U7sWUCT5BIUQveMwAYnkwPOYy+neA1MR6w9kaRoRKhH72A1cDFU3rSFbjhmoy2ft5xBitmqEWLW0gJPJhsu7NW8oLfZDesIHxR3dLbXjTO/2UvHajotgqz3OvqQBzYzBAE1xerB/pg3i3bPCdBwmzeWzryEgjK49btfp22f7ClnSkRGZ5WcOrJZdaJirWudBXDlkVT9Q4DaxvjHu3dVlPeLGw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvFye0MR5Qi+5lFU5jSxIjsotyK64SgL27N8GFvB+Sw=;
 b=iyHkwjnWwD3gmU5a4CRrPHzNjC7WGOKhpb2jGI/R+tc9qHdguA1siDYFyyrFzRQKjxXuFVDFPazokDpqzLav4cbSCICDjU4vqU8HmEiEks6IxZYqTcz8HBx95ryT0gZghANuqgl/LXgUB5c+Wsdj6QeFR5sXsFToNLNOnLzHUzYERfNeNdd+eT4sGdYQXUQLE9JTtOTpZuAYJn//7A0o6d9lRO252jE+YClv3qV9j3pk+Nq7SpgfkQXG++BC9wGnRCXotGY/TK48CzfHiYoQu/Rvee4he34s1w+8/LhZj4eWLAKH0p3je5Jf1D4WadDAHyZS8wCvOSXwCo67aSLaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvFye0MR5Qi+5lFU5jSxIjsotyK64SgL27N8GFvB+Sw=;
 b=Ue6mW9vnU26A6YuZK0HnyVqr4c0QiYY8dasVRtwC87NixrWYXYYEBteo+6iUx3zDDdM/tIqIzUM3I9Do0Ksg7yQsTP9ucqFfXMnbFzPCU4aP+l06MAK7Afqf28R14bHrZ2WdEA3jxFQ48NK2/0gEbzH9Sa0BkZqdFpoqpKbNxmo=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 10:40:25 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::20) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 10:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 10:40:24 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 04:40:21 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Date: Mon, 6 Nov 2023 18:40:07 +0800
Message-ID: <20231106104007.3938395-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ff756a-ffce-49bc-be1c-08dbdeb4c8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOs8eY3D7h7iH4yRv03ORToxJqLC12ei4QyVwn7UmBaNhCVOTw6xi4UawucUWv0dyNpzfVgQ31vZxaMEdmPQjLyA6LGTUR8sn2frSQg5M/oQ7urqRgCWowOn1Oq6kqZVhq9nlyesyyuwwNDAt5yl60CJyQmKaQcYrKeXJdqzq+SewtI3O8rLl54Ms0eOByp3pbTaC88pJeW70QdWWwwVNSaecqiJ1vOmO1CksWOjxVRLVO17RIifM0AtcbtEtJ/SjOReCBSP/4wVM+ACVdHb/HPUk608UIA0VGilpJSOgHFTRB4fi9aRxZCHJTdNC7uyjdHInt4g8NGqdNk4ewZ1kMhL1VGwFzMMyc9r9md2KbNlWmnc9gJWwC5OQxESP+mlf+qzSvRcYyU6IjuGy7b/B4RwM6Ibgud+38hqqOdjbGDZffibgsuyt3U8JJUt8HZsf21X7Fd4WjrEPp7naidaHqpxqcIHD0D9/zdZ9ZQe0m+cvx8kWRcdWhOqe4UYo3XR8ysXGVWc5lC2580e2io8WEYreSMo09tP4blVlyZ83mwkaGtle9doYTtcSgACUAL0EPjuCE84ocYr6AeRKsZgUpuIKTq8pjt6Og6aOpOmfJq7YAEyfDUL21NIA5y/UGaoRguiihJ4XPb0xHMrkuTKdCOGVAEESluzKS+HzYVTBG9Ppgu4MyQmc/EZCBB0GZ+QcQyBt6SZ515l2vg2mB+nc3LCIoI7OHxGwxgBk66CJgQ9q+3v2uh9sicNJSMKfbLBln70HQjinWzuGVkXiKLSmUDIzUso5LsnDt/QhrAX7PN/1l7kjzpOu8VsZ/T/fW5W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(426003)(336012)(41300700001)(16526019)(26005)(2616005)(47076005)(7696005)(6666004)(1076003)(81166007)(356005)(36756003)(82740400003)(86362001)(5660300002)(2906002)(36860700001)(83380400001)(8936002)(4326008)(8676002)(54906003)(70206006)(6916009)(478600001)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:40:24.3617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ff756a-ffce-49bc-be1c-08dbdeb4c8a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, felix.kuehling@amd.com, chong.li@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
There will be a warning trace when cleaning up the gtt
drm_mm allocator during unloading driver since gang_ctx_bo
and wptr_bo do not get freed.

[How]
Free gang_ctx_bo and wptr_bo in pqm_uninit.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 77649392e233..fdb03b08df72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -179,6 +179,14 @@ void pqm_uninit(struct process_queue_manager *pqm)
 		    !pqn->q->device->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
 				pqn->q->gws);
+
+		if (pqn->q->device->kfd->shared_resources.enable_mes) {
+			amdgpu_amdkfd_free_gtt_mem(pqn->q->device->kfd->adev,
+						   pqn->q->gang_ctx_bo);
+			if (pqn->q->wptr_bo)
+				amdgpu_amdkfd_free_gtt_mem(pqn->q->device->kfd->adev, pqn->q->wptr_bo);
+		}
+
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
-- 
2.35.1

