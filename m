Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C321C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 18:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0180410E13A;
	Thu,  9 Dec 2021 18:34:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C536910E13A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 18:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OonhHV/LeV/d+OHCoAR05fiBlwXz0DDmfqwOPuQmjIvx4xQCiBclTwC0KcMVwj0htU7bbTv5JrRdzHYHn2/s3ondRVX8wetCpaUOM09TmARNpC/o2h4ywgy+F2ncnmLP2Lu/EDKYfjAboUFcfhkpqxed10L8i78jiXNqEPSpFAR9n5n0VcKS64oyJsiJn+Ih7y6hdtFSSt+hu0uockIYTFpmgkU6VV61RWmrNz381s9MEC2WehOKxBig8o2WPhHFlocWoPXV+ugMQPIMEvVB931iaRiUzJ/Xn7wV+oF97mtB64cHfmALLglQjT803SvVT5RGzM+K5FjU2/Mzms9ClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0L64MXT7a5La1h4wFxgl0/AdWnx9BxInAMs8ectBQM=;
 b=DX0zYvdy+nT6MMIR17961sCMAEK2i0hWMouQLeKFdlkEKrMoWFpYzaeNqEEgPDcqBR/dEo3Do6xazT8K26V58a7KVDGzA5CpGexpsDYci+rSYCpoqNHBDeR/p912YB2IuIK2kbVvHNKn3BgWwAIulzX/KLh4yLu4GBZRQqbB2vZQtbHEzaViRX1CrSIRTynSrDCkhZsLbDdN730bHeJRH8CuURkv38QsCL85gaPMxkAJxO+zphvJF7QLe7i4exRrCNejf9ZecTEhNnfkSag4IrL/bmscvS04sNZVbtgYcqQNseTIw4m7eVaclEbd8+D53fKvkjTB+eCvJLVfWnwI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0L64MXT7a5La1h4wFxgl0/AdWnx9BxInAMs8ectBQM=;
 b=VebbQIfOuu+VPDNiTwMvb5IeSZdCrR8BYdxUHptHmwlNToSp6Y2R3/zmGjKlT7a7M4orW+pCuw4dMLwAOaIiKP+ENAxakdmhdjC9hUbcdDLrVSujEgpbTQGAMtv7JlUho+Vt6KlKbY+FeSscDUVoWe934SiHYRP/G33xeKO5My8=
Received: from DM5PR18CA0062.namprd18.prod.outlook.com (2603:10b6:3:22::24) by
 BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 18:34:00 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::59) by DM5PR18CA0062.outlook.office365.com
 (2603:10b6:3:22::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 9 Dec 2021 18:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 18:33:59 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 12:33:58 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add Navi2x to GWS init conditions
Date: Thu, 9 Dec 2021 13:32:30 -0500
Message-ID: <20211209183230.3564248-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1de59f28-d103-4315-afab-08d9bb427776
X-MS-TrafficTypeDiagnostic: BYAPR12MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35607F6F398F30FF41A6CCE88A709@BYAPR12MB3560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVch+LQEvoSjPhoPb7HjieUQVfvk52avl8wWa8MTNh+zooPCeg/cu7CfJ4e+QJS/2WtTdS8HzqBevPKAyOh/IxU52QLATAaG4nulj9OjZja2CC2MGImOP2jBLwiiVIB6yXLCiCnzSFqxn+Q9xkCYA2AwfLcU/Xvnl3wrb1EckXmJgFIu12cYvam6pzypVi+nB+OEbGkonS7ARUuW7Z2O34HYHVr5qh2pPPhm7F8FtdzCXC9jwZpEpEbVKSaHzkbQBkuGbXBresR6fSXbu5XXAAPpZmhaKcaQHcnfrHUtq60XeHtfM5KY/CYvcCcxsrQcPA7DNLofD8rR/9cfpqdbVLx2DAhYjuajRnkDDhc6dsxc7a5bikQfWZUtas/LfArnL0cvCy5EgLp5j+M7bS8CU9PnilurwYHkJompwsHKFJ63jBKd96BWLzMZSSJWTXNHdizofoQXOKE/Os3ZOfXt5vagZsNzGz/gaSneMhhJMxHocfaXuTMwG4gL7uHcfr0aceUaiWY0Jaq+Ri7ac3OO+ZZX6PsSNoARSz7JqrjEBUhSnDjCNEp5pv6+wofErAftngEPrd98bKwZTqbFZTFSpYFpVtSfQH6j793UDiGNHqYLo5jNfhIhdigR7u/oNx8BERpcxhn4HBAy1MQ3Sw88HMtPeOH7k+28baGD7WLyAwEhXUWrIz4n59aJG/1iC9SDUq/INxxid1tsCXuKWBckAmtipMjNCk5wz7e5HladOpUCBHX8rYX23BuWMrFb3MvjzCTToa/K6vH9GFlKKzqUumLFtktS+iD8imSaLTtQRzk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(2906002)(7696005)(336012)(47076005)(1076003)(316002)(8676002)(8936002)(356005)(54906003)(36756003)(5660300002)(186003)(86362001)(16526019)(81166007)(26005)(82310400004)(36860700001)(2616005)(40460700001)(4744005)(6666004)(6916009)(508600001)(4326008)(426003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 18:33:59.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de59f28-d103-4315-afab-08d9bb427776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
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
Cc: Felix.Kuehling@amd.com, Jonathan.Kim@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initalize GWS on Navi2x with mec2_fw_version >= 0x42.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index facc28f58c1f..67dd94b0b9a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -368,7 +368,10 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
 			&& kfd->mec2_fw_version >= 0x30)   ||
 		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
-			&& kfd->mec2_fw_version >= 0x28))))
+			&& kfd->mec2_fw_version >= 0x28)   ||
+		(KFD_GC_VERSION(kfd) >= IP_VERSION(10, 3, 0)
+			&& KFD_GC_VERSION(kfd) <= IP_VERSION(10, 3, 5)
+			&& kfd->mec2_fw_version >= 0x42))))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				kfd->adev->gds.gws_size, &kfd->gws);
 
-- 
2.25.1

