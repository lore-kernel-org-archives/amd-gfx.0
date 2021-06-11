Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63425C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EB861364
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EB861364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1676EE34;
	Fri, 11 Jun 2021 07:16:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87E06EE34
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUrcMWK45BO3HCFWNSZnwDHQRcTCZj+sQd9MxEBdVHnc/8PuzPxe6UoKDMXbha+Yzh3rLRMRlDe4CINMdYKlOomAEbtBHIsQuirQGlZRkL9uKOFCyBhRlhWDKPoEEQv5SqET8D1BKSJd6635zj4EJ2uqhQcL5LW2lQ6hd9ysNdpBQIfcCzSPwCPrnW4SvV/zhuVaPhen/jOyw3NK73O5TbxHu8VfNFMhWax03lE7euysYKJJJWrSFviDty7XfleXieLZiugKl0NK8zKXdtsTJR/OuDmcEhXtdlAnnfb97pHr36hamvvEspu0itug1SalnhFo9mpRFHnPpOo68wMESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9f6zpRdvx4Wh8ZoFqQgIdDR//Vb5idynR6NKbkO8+w=;
 b=UFvILvoVDVVTeYhMRHaG8vgG/IuybZcwNEJTbHsI3P2W1gAM/k5tV5YQZAg1fwDbAQDI6/j5W/UvYXU4i8Ti8iIKTA98uoCS+xg/6yYG97q2LndlpN9qkFCA+EuCFGccZfTT4NK7RwTmsLvsGCz9RppSRxjvBU+Owjt2+IcC2tL+c0Ifzh9vRvB818PqRQIAcgYMfnwIAQIpUaD59JukIwRHp/Axy7fiF+CXixABFnt5TQdNDC7o7SOL7U73SSg/gdQfHeSC00FTJAeNtitbm54hTG6QeJj5IotqCCI++sNZI44HKEUIbPF0NdbjWhWm/Lxndq48Tu4jzgr+yR+e9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9f6zpRdvx4Wh8ZoFqQgIdDR//Vb5idynR6NKbkO8+w=;
 b=snBnqITXrUZYUeOfbFIp5wAvFa6DiBif+GSePdakCNHxmJSqRxrMTJYgC185a0uevzfj645PWt4RZr45Y226TIOOqE5pU3TSzxSgP/kCwKLbPkmkL58VgPuuuFa5HzYm/DH5Wl+LWV0gIh84Xp16x8nOfPhyOPnqUCtqqajf6IU=
Received: from MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35)
 by DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 07:16:09 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::98) by MW4PR03CA0360.outlook.office365.com
 (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 07:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:16:09 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:16:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 00:16:07 -0700
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 11 Jun 2021 02:16:06 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: enable support error injection broadcast to all
 instances
Date: Fri, 11 Jun 2021 15:15:57 +0800
Message-ID: <20210611071557.12344-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb180e92-e4b4-4eb3-591e-08d92ca8c93f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:
X-Microsoft-Antispam-PRVS: <DM6PR12MB399309602D36E2D47C2B0EADED349@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxptwZteHWVP9XY/1kb+3sC2tZHrrok67Tr3X4ycbGpbFMj/JYCuTw6E++ZbomSKkwT0cVwTm0Vj1RfeO+fGUITPceNYXJDXp/8em8hKedulsToEaBguNjSZSA34oEhq1gymZJo7dR/T8rgprued/SMtyJE5SFvQ80hRiLvBVicrBqBN/yXpBbMQJCBY2aoT7FBqj1UjrO+9WJSX0N3RlhNP01xAqiaTtkw+fcCh6esoh4Fz6TMjiE1M4IBOL89I+OVPXNDxsVSr89xUthknZwA/WRQnWV6cwyATNwwwT2y89UDl3Fu5IVckEcFRvJL3RkdckNDOIq5AfYD8aiYa63bZU99WjqGtuUCLcQLcJEcFdOucW56yfKnIeOG67xXSFzsRER8gwRbAc5BhRi5tmQJSkZKMyHnXy6iwA3kbikMAPs/1xNebW34ox6hvq+6jO+G+XM1JS77lB9puw17Bal4jBDLXlexB5MDl9uPFigM1u0M9nXfKjM/d1vM1+NdcHOZ7epW2AxsxN/XMoCtFsRIrAHUO8YCCvb7PmetHs+S7oLR1qAdVvc7ZtdmpEByd6miXd7KQvDhXGOQEv6+cf7HYq2i0yD04eNYtwmSLfAnfBwAQ5rTtBIfNCd6kuHQ2MFAJcGcMYBQUysguNDP1o+7DaFEXW/NoUf9j4OB49WHo1WoTqU48jD+tHFKcdt2HGuru2cRFyIaI6x5MHxWeVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(82310400003)(36756003)(70206006)(8936002)(316002)(36860700001)(6666004)(356005)(5660300002)(1076003)(4326008)(70586007)(4744005)(86362001)(26005)(2906002)(47076005)(6636002)(336012)(186003)(478600001)(83380400001)(82740400003)(8676002)(7696005)(2616005)(110136005)(426003)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:16:09.0586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb180e92-e4b4-4eb3-591e-08d92ca8c93f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

when the address is -1, TA will do error injection for all instances of
the specail sram.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 885a78301bbf..c828ce9525d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -402,8 +402,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 		ret = amdgpu_ras_feature_enable(adev, &data.head, 1);
 		break;
 	case 2:
-		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
-		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+		if ((data.inject.address != (uint64_t)-1) &&
+			((data.inject.address >= adev->gmc.mc_vram_size) ||
+		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT))) {
 			dev_warn(adev->dev, "RAS WARN: input address "
 					"0x%llx is invalid.",
 					data.inject.address);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
