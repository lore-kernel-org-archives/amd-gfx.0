Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDE4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D724D10F047;
	Tue,  3 May 2022 20:29:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0919710F0B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYBGxU7yNiBt7mkqR3JS4jMUihN0hsraM1MCz74JkZ4euK42Po5EL0+qswIjRPnfbUFTnA2iKn6XtlHD+kkTPt6nlS3vfCeNb3IpkcpS2JColKDHsQCvb8NCCLG/j+61rIE/F74BA0N73W4TWHWx6UdvsT9fxh2cQdJqCNuSONNR2dREevDUdoYTjRlgwV9+dx2acqd0NA2hw6xkuzdKGTzhy4QE1xGLy5JW/lek5N12ChCGetmp45hrst+x4jyleDENcsirdXOhqBWzDjK5iTQf2XEHBR/BGLTgjgwp/IjsdEMwEQfVKI9Vzr14X4KVobwMhtYGcJodm1VE5AuiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Cyln4RHGJiAHDkH5/pdXr173RsPMKrc14mre2QWoYc=;
 b=GbXQau0C6OS393KoIsxQ+gOHawlFBeQ0fG5GfK44EHTTvPdHkN/SWxD6C55vil/J6qHb5M12gd5GPDNbUXhr7Du8/xXtIJIWBfhGUeHxQvyVotpi9k6WCAgWgmMkN1XMvSeNZ4V2ZlWKIuYtxKc1oQujKRiH7/Kc+m0i9nfluEdF3k977fA4aM5VEi5h4OevtjL80hlE6GTAhI4Um8/MW12yTvDZSsTzLybIdzEQDAjv1GY4/fCpB1pzw/iC6akYNP5pIJfnpJyAR+vfX869zQkcL+acWyY9NaolSh7zfikKOpXUrnYDqSQXXoxUYDyO66m9GwQd5AqnJq7s2AEbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cyln4RHGJiAHDkH5/pdXr173RsPMKrc14mre2QWoYc=;
 b=bKGRfvpiNX/nhP6VP5Q1HPFwwWD8SdC1yaKurbCX/9cTIDRea3VrjWERn2H/qKngRpLpBfJOBGbGqIwdCDlSBtO212fY/TKHqUq6FWdD4QKf6P9gVpDbmEijiO1Cir3zOhTtNNZ5WIEyfuhhUd7wfAMmPTt4YkdLKSamzxHpu7w=
Received: from DM6PR13CA0023.namprd13.prod.outlook.com (2603:10b6:5:bc::36) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:29:31 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::45) by DM6PR13CA0023.outlook.office365.com
 (2603:10b6:5:bc::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.14 via Frontend
 Transport; Tue, 3 May 2022 20:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: enable VCN DPG mode for VCN4_0_4
Date: Tue, 3 May 2022 16:28:58 -0400
Message-ID: <20220503202912.1211009-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83c00c6-bffd-4b26-29ae-08da2d43a142
X-MS-TrafficTypeDiagnostic: BY5PR12MB4162:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4162D25B04A4BFD5FDDB5043F7C09@BY5PR12MB4162.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvB5/0kO5p+TyAOzYJCwEb6i/6RoUMUM6emFn4EMxPXOaCvyQStsGMaD7oaxULB18AeTKs/5cne2F5nbpBB12hAjXs7EL7xsqIh3SQaio8r47D5i7ksGAuh3f5mZzvi93R3LWo3qRcsJSD090I4bVWhpQrGjYBguy4Dr8VArP9j5Cihq8jJAdElPWV6BoqathtfrhhT3k4y5UzHdGp6ZERibpFkMdzMEtDmb71sd6hHKFfvH07lRXQJM53qzeG5jK25PVJKEui1HQAX+hnboC74gbHjPYfPyn3crb1z2Msrp6t09g54tWUlSXgDa+mbi4lq97m5REUT8ruWuD6vrPCY/x1fOpcP6fPRcT5hVdVw9x82YTpuH2CYvkeJ6LOOG09KpS43G/cmuT6hV9X6wQ4S8BgU2wch7cli4/m2sBxgES8fk7te987mCpkUlHVoeP5ZC5UZMkZZopRk+LWHDK6lUYl0AV7vZe9zCrbt6Md8+0W8r2CseiWvXYGjyFeK9nFAuYgovi6Tn9ulX2CT0rMn1c64oPgcw74ksKrmG2jRfBlJQ4H/IFuUoMV8ouERzwjhE3lEvcmPtMYjLmw9m5Kyt/xA/W98M4IxJALhTDWGuFN5Xd5Nqf1i5aY8NbI3EVSC2Y79ZkEKmbmRYhKGpju6/L/I7MbhYaCqV0zlD0vsU5QXELRrPwu8lbwMBy/qhGE4oLWCp+8c79H+6lJCVMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(6666004)(356005)(6916009)(26005)(316002)(54906003)(81166007)(1076003)(47076005)(186003)(508600001)(336012)(86362001)(426003)(2616005)(16526019)(40460700003)(36756003)(36860700001)(7696005)(82310400005)(5660300002)(8936002)(8676002)(4744005)(4326008)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:31.6935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c00c6-bffd-4b26-29ae-08da2d43a142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable VCN DPG mode for VCN4_0_4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b72bbad753f5..7bafc146aa55 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -553,6 +553,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
-- 
2.35.1

