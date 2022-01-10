Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C717C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0367C10E6E7;
	Mon, 10 Jan 2022 20:33:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B9510E6E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFn+eI76M1Jtc+eGkQ5PWwFdUfW+qCYv6GvYax8YOaymyJnsAeb6r+Y0tZCMqxy/34O+rqRLZdhz3TJHronyOqRs6rTpIzlruUaXL7coeKizZIoSaWNOkaflrfhGxSi9QR3X4TBCbMum4PSm9K2E8kc/9k1WRDLyuYzEYi+aWg0usAw83hDjM0QCLXKM9oCNc0//S+Wht0nnhffBtjJSE6kT4XH6qU9kBz1l8D3mz51qaPWHvBfWGjPClirF26+6+Ti8t67YqPw8Qk0XQaSA8Fi/syIPY4n80/wOKE4SFZjxBkVwHoGsIqE9QMDzLBn3F9Lt8ZFx/P1HH9mNPTGbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRB3z0YyDUFvyke9FIMcdo1X2jYr5FZaxFdfVUKnZ84=;
 b=iACpsveKhCXi4cvNEvVF95HLL1knPeNHswf28xpGwp2vpiGwAAZwrjyClxMDrwlLYTY4dFoiH2ooiRB53fDS3vcd7FTHh5BUQxhD5zASPc4Wh6wcB+gKiJgxmfhQUNbEmcO+zkVcoVaI5wEno4uvj5StmKhZ71bi0KBU0SgsPctinSis9PkNmuR87rLRd2CMpKzeNU2Dd9C+mflVs24wZ4xAlAi6gwm1Mn5cGVJ9o6NmELTwApqD4JSZQS4Gm7yMjAQ/EAs0jOfzFkjLOB1WvNL+8HK1hmXoY5Ng4P1GAD0C6Gy8b3Rjg6h16LkI+Jw8MyVKvQ9DQUy4mHyRpJW5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRB3z0YyDUFvyke9FIMcdo1X2jYr5FZaxFdfVUKnZ84=;
 b=AK92Iyr/OylNh+xxO5/twYLPb//A1bU3bB1u/0rRkV7LpNmGRoab7Td/nN5mqhavFI5Fai8wsBaZrNQkOVU5tn5yRhNG8/hgsb+AwQ5MQh0FoR3fXxbqEu2AME+PKTxsL2YsrfIy5h2RNJ55rwAP+Py3XgfU31N59VXpk8edvws=
Received: from DM6PR13CA0030.namprd13.prod.outlook.com (2603:10b6:5:bc::43) by
 DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Mon, 10 Jan 2022 20:33:23 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::f) by DM6PR13CA0030.outlook.office365.com
 (2603:10b6:5:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.7 via Frontend
 Transport; Mon, 10 Jan 2022 20:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:33:23 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:33:21 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix unused variable warning
Date: Mon, 10 Jan 2022 15:32:55 -0500
Message-ID: <20220110203255.95468-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4e80f28-bb94-46b3-2640-08d9d478729b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32119D76719E2C2B5F0C457A99509@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:31;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIjHOrfz7uECexZvrV2EpsrQghtwmVpAAWBD1W8eyOI2ud21alCY30wfeCX+u5W0+rT+vzCXF5UZcwAl7arG6DVOq+kRSgHR0MXb6Q2xjtendyG0ZEFxUeUlzCAhmkUffXOw54hNgc3Q3bS457fGGk+oOypHSk4ajLExjpYF+kY7OFEsIEHJBg596NmENag/UxXWXvmvIaciLs5mmkRP8g80HhEi/GU1aXOuY7/6OuDybODF45usLy/rz7WaFFPCnl0yKnahdQHcO4SQzg9tkC8YQqpnsQgfBTJeBV44rwtMB1jcT2kegugKUbsUEzuKwTmVc2QAXReTWYUA+ooPHgKRIiu1pZ6iDcDzvA/b8AhkuAaiOFyLba+GRWExHsTWEqCyJDs44E6XsF82dmyfIMm67BQQXJ+if0QyAGz7LTzBX5xspYTQ5ruDkVmAHM58wk8aFeQPjrKShRlWONTS2+mkgb9kc3U/2p4pceuMOwyjnpCdrskobDWA8MeaXBk46Rawz2TsiQAiF6fdUtRasifD9RP3YCF4UM+PWy53Z09LuK5Y/AKGKE23sSHPh9OJTz31FS2wi3ELt3aQDwajLRk2dAW5D/Fx8EW6s8609+lsDt2c/yK0ZyvZYGhTSgQZOJLghFrlOvWyhRb25RP9k0w9j6ykrRBIxHK61ZaWw/kUNcxXvYb5+ZoMqcKagTqoIfHOarIcYOZvSvNI/0p4+tH4PZ64cwU+yPRerjgR71kfIaZri9dLx0fpWoW/LSZyndssKv9aDbj974MLyjTN09FS7GWCA+DDJiDqCt5wtY8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(7696005)(83380400001)(36860700001)(40460700001)(70206006)(47076005)(6916009)(70586007)(8936002)(8676002)(4326008)(186003)(5660300002)(316002)(4744005)(16526019)(54906003)(44832011)(26005)(1076003)(508600001)(2906002)(426003)(2616005)(336012)(81166007)(82310400004)(356005)(86362001)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:33:23.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e80f28-bb94-46b3-2640-08d9d478729b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix this:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function ‘amdgpu_ras_query_error_status’:
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:945:6: warning: unused variable ‘i’ [-Wunused-variable]
  945 |  int i;

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1bedfd4febc4b..517650d286a722 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -942,7 +942,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	struct amdgpu_ras_block_object* block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
-	int i;
 
 	if (!obj)
 		return -EINVAL;

base-commit: 9b7d59707fe1ff51cdfa0a048629446ff3945bfd
-- 
2.34.0

