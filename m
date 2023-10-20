Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316CCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FE210E587;
	Fri, 20 Oct 2023 07:00:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB6C10E587
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoyTdwfQNePPP5qfquTjqTJb+nof6gzUCl4DivapNlmfiReuAwHFwGMmcfrP0RS4KzocWH1K2WlID1ofnP5wrLTpt7d9H5IBm7UkS8PtAl3/WE9H3AV2svPWqQPRxlOu+ebrOrFulTDU82LOh3yQ2YQ8gOufH6+HvTt9XrttJb1J0WwepvkmkUzXa70Xk3k6CRkAiJ4N8bxdIeb3qbGglo58B1J1q2me5t31X3QqycUrz5tcct9qrCrYWQEXUHYSgfQLT5rPqXjo1UT9nAjo9ZLi1vcwZLE71xHvwtsEFdm+VEBZp32NCRp9zThdEiibTQdndqTiqXiBo+fHg2O40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpbB17TUTPHpWRpC3xMZcyD9UFHA0p9nBRXXZXDDK/w=;
 b=mwL6Jc70orLNtJngakzAEMgehW9S8+Im/zCNIQ9P1a6Ino7GsbcZ6U7/5HhYpNHmkJ1ZEoEJyvB4ppbbgReueZplPod04xuknjHYkFsOLKi/8I9GgphrofEeqid3CLPUbUdrUrL13uNDq8vQyMqkBhJwLiAdgXBb4O+019fSkaiYDiOL0jRV8apuaxZOocEeLtvwyX1n/QS6brLzMx1PH1NafTuLCadDl7te6kFJ7gyv64eZnDnY6L31jmm1DaYCWWAmusr+72Cf/J+n6s6zEaCDKX1SWDx00dnU8d4odf7i9eMSpdTM/mcavqrx29w2J6pl4vjdmjYSGk0qBgtpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpbB17TUTPHpWRpC3xMZcyD9UFHA0p9nBRXXZXDDK/w=;
 b=JiORq1WVEjRR7MllTHs6PTrHspP28wlN9+6byNAY7KDxlWb5JXGzd61aXoJBLEYZycHnananITt9KtHUE7Hr0e6FB+avL4pdWMazssGcGR42F5dgEA4+iw0E/uPjo+M9nFFrjJ2wbcpsKXcP9Ou5/3vxRTaVCAgUxaMh+gpyo9E=
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:00:52 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::6e) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 07:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 07:00:51 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 02:00:48 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix find ras error node error
Date: Fri, 20 Oct 2023 15:00:25 +0800
Message-ID: <20231020070026.1380994-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BY5PR12MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbf2e8a-a9b3-4f8c-94bb-08dbd13a4c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km3gRqJSMgjfOAsZRpb6KZsyrDEsc7Bc5HfImSybL6CqMMShmz1wVK+xuK4jmAOgtIYWtcUxXOVGvxc8gZwjidpTRfSJSDbZE4TeeLnW2N2MUmZLbv/nnbT6WN+5SsqXLBSMyj4xmEv5Tlbk5qzv9B/ymlDX/9mnCvR4uRRX/DCzC0t7/B3J5PDyFkcsTLw1jQPCGsqvCoouOhFzNTNxwocpc6NiPK5vxrNbZmhK8R5TDB8NGoHX8s14yxZbcJZeaGf1ibiSzVhcoTpfjDR2wpmfIuRYT8xZzqOoA1D5ZPfihqmrimWCrOIkZG4S161ijfYyUjZSbfigXMaaSsmagoTJ/ERGvLc0NK53SJCKZFUatlEfh1cYW91jfea0iMxLgSHr7yFGEUI/b+PuoMT07Z/MqS3VDmu/a2PR79BkX6Romn13jQKeiox71BRDkW/p8CMPC8R5LTYhIG7+FSiQJ25N55C7Bh/0cgLGqCjSzDPan67RkcN5vS5vQbrDrLMyUUIJHX581LA1m40aaxHxGgxeywO56RHpxi63plhb7g2whllZWT9LHKQ1+vO0f9u8BcMPl8mVx8t2llUinUs4n41uaTBkiYTG82EHHqe9Aef2W5Qafuzgu70pfhIkWGxfekVTs7zedJT6e5Jil9IMxzhTftWsBXfr13H7FefPQ9uCipKToGdx7wBVBmnNv9RJQU9zgl0ZLRTSLKZMG/jPwAocRtHbWsYbUCT0KldAtX0/PlZzL2y5L5Fzqr3Mjc69csHr2HMOwlgz26BQ+rG0oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(356005)(81166007)(40460700003)(54906003)(82740400003)(40480700001)(36860700001)(4326008)(8676002)(36756003)(2906002)(8936002)(7696005)(6666004)(16526019)(478600001)(41300700001)(1076003)(26005)(426003)(336012)(6916009)(2616005)(316002)(47076005)(5660300002)(70206006)(83380400001)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:00:51.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbf2e8a-a9b3-4f8c-94bb-08dbd13a4c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, candice.li@amd.com,
 Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the origin function might return the wrong node.

Fixes: d479ef0d5fbd ("drm/amdgpu: add ras_err_info to identify RAS error source")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 70dd249f2ba7..d5bcfcf4ced2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3518,11 +3518,10 @@ static struct ras_err_node *amdgpu_ras_error_find_node_by_id(struct ras_err_data
 
 	for_each_ras_error(err_node, err_data) {
 		ref_id = &err_node->err_info.mcm_info;
-		if ((mcm_info->socket_id >= 0 && mcm_info->socket_id != ref_id->socket_id) ||
-		    (mcm_info->die_id >= 0 && mcm_info->die_id != ref_id->die_id))
-			continue;
 
-		return err_node;
+		if (mcm_info->socket_id == ref_id->socket_id &&
+		    mcm_info->die_id == ref_id->die_id)
+			return err_node;
 	}
 
 	return NULL;
-- 
2.34.1

