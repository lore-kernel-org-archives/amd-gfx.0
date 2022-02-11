Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AD4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 04:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EAE310E218;
	Fri, 11 Feb 2022 04:30:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4DC10E218
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 04:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFJQderN2n5N3YYN5BJ6gGW26y26Qbj5UeW+2MLhdhiDVN1ktoarYZCxmxtD219sE4VuhUveebCFPiFldxxTnLL3fAWoTPcmH6stSnI+m3hyE7p5YpkgBxb33v4q92nI+MLrcy5zkMUbtVTSaaljCAyVRIs15uDlK6IkkLTQjADYYWWCpDXuUK5baS155auKfXSrqTk2I/GooasDwBnQQqbArfuvKViAykomD7ZVcundMIrGigw0hMO8+UO9Tt/27AavRP4/dcPhMKO23jPrHa8HLNo2BVSt36JTkIP0vZTqOU0jNCyt3IMl7r1dGQHwNVw32HpjJDStwdAbMldllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7bHAAJ5JdvfxN/IHzzw8+aMlVrE4RrnUU+Qa4gTFJ4=;
 b=RBDG0aM1rzlYAuz0ocuoN//zH5wkXWWKDtD7DhPinwZtL8k1FXK+gvqxbma8oGdQJKzAeRaXTKNoRw6ln4FK/0yx/CKlOgGjZ6siBhMa4pUWBjRs2PipOKxOaUIu8RbiQzl9PhSo9bwRZh8XDCgdLAP/3E6coISHC34m4uIvAn7o9PhmtDZK1xwWvv/ON8nbLIlhr4T6qfvtizERZi6n1hto0nmt7Ln2KRGDHADMXCfsgj01B0g+GtyX2yOfDVIuJKG3dsCtBRE9dKxQG7xr3muy51qykPOpGs3gGfGC4yRwY9sMp4m+Wv5wniro9zvkcmBfJpcfT5nsUzK5utCX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7bHAAJ5JdvfxN/IHzzw8+aMlVrE4RrnUU+Qa4gTFJ4=;
 b=zhWmHQrRPY7tUpctoc1f05eaB/IKFYtf9nV2T4MFDHCT5RG+vhR2DEozpmqAN9N2K/OqnCm0/aKNHgDut1GFrinlnmSP+KLYaDp//YccPlLixzbfLhYFAVdVDo6xPvrYUjhoNyt11BJXxqC7Khx7DcpUXk+LRb9C4Qbsw0z/KEc=
Received: from DM5PR10CA0019.namprd10.prod.outlook.com (2603:10b6:4:2::29) by
 BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 04:30:51 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::dc) by DM5PR10CA0019.outlook.office365.com
 (2603:10b6:4:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 04:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 04:30:50 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 22:30:48 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix prototype warning for get_process_num_bos
Date: Thu, 10 Feb 2022 23:30:35 -0500
Message-ID: <20220211043035.13284-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211043035.13284-1-rajneesh.bhardwaj@amd.com>
References: <20220211043035.13284-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30a95c55-2b87-4861-f2c0-08d9ed1748c3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5244532F808722F30D39E25EFE309@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYx9UQExxJOjqkxtqw0eYVaaVVqKGydpEPfZZBgx2TkQBObTmaNXOG2ETMmAYa2z2udI0dAyntffuIvhHyKRwRP3PY2QRlAfhbuOPU+nK1gyBkYnNieJBLuzW+NsS3huIioFu5dfZgqCdI+gbkIlTnZDB1remtb1as9oUSWoS5bY56E170RkueO0o92+CPkIdM3YpW3Ub02yAN5PeX4FIQkE97g68r57ZvAcwJSi8mZMxcVTpnWA6bfCuAVhpM7bbaf3trC3T7RQIliT8LS6nZWhc+t1u4eA6m9WrZeuTTG0UcnghkCjVvcQR4PuYihUfX1p0zZ/dB3RTx+A2gBy8JMJyMNlArTgCUdCzEuvqzyaor9re6wp23dRpniLDKU5M6Js86DFN/9BHyLlL/9pm3KzBMcaFEb3B7EB9oKwdR7gXzpNlxvXiqVuJ9xY0l8cbVOkCNQgpSHwFK7Md66qz+JR5QrHSD0+yVQxA9CERDFVC56ltFxA29r1AsyFw946ycmGek2DbR3fYkbOeE6wzGwI/XRM7nKbuJmXqv0GzDa8gm1nb49TD+lrRO7+54YOZeHkXvGqEqB+8h+OHv1fweX/Qm5a378RScas+VEFUFr/hS0IWSjdBWtgKGt7WVGaIu6Xa5xN+qCOIYmHeiIRQLjh+XWcLQZ/51pNWazlBUzdiyq5CznuejIbTK/ZKg2HwLE2cSErd2E1TdRa5gNiFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(8676002)(4326008)(356005)(2906002)(81166007)(82310400004)(70586007)(70206006)(316002)(5660300002)(8936002)(54906003)(6916009)(44832011)(4744005)(7696005)(47076005)(6666004)(426003)(83380400001)(1076003)(26005)(40460700003)(36860700001)(508600001)(2616005)(186003)(36756003)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 04:30:50.9374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a95c55-2b87-4861-f2c0-08d9ed1748c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning: no previous prototype for 'get_process_num_bos'
[-Wmissing-prototypes]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d5699aa79578..54d997f304b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1648,7 +1648,7 @@ static int criu_checkpoint_devices(struct kfd_process *p,
 	return ret;
 }
 
-uint32_t get_process_num_bos(struct kfd_process *p)
+static uint32_t get_process_num_bos(struct kfd_process *p)
 {
 	uint32_t num_of_bos = 0;
 	int i;
-- 
2.17.1

