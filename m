Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D204EC47079
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A16510E230;
	Wed,  3 Jan 2024 08:03:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD9610E230
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUiArDNtJOZfmkJ8IRu4GKQk00k69TFA5mxdMkxFRVU4tW4+L6dgirnFksiRfY0s/SskhY51MKuxLJ7Hw84beWaKz5/I/CNU4+oUvDowE2OWsdoSSwEGxaoKOAxFnjzZofXHrnnP3kIyFNFv0Aa6qjIUXnL3syTLB84JJGTgs5A5ybAhJO73H3zvcZWrMgqP2BGB8YBUkMiCABnWZNgZnSLdg+932pEXqWR6M7AVqwBpbSCTOmlFUgOiiYklCoQYcVrHHgpq36y//MGvUT7duzXfmGAc847BVzptGbv4UT/iL0+N6KC5+MwxR6IzpyuOwcz9Zgq4JCit6uvYHjQ8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MQNfcBWAb6YuN9l6kw155JoPhzASWFoB1xQdH1eo4=;
 b=TzF0bevuwKitZoY54O2/xepvD/v2Bo6S8pcWLTRnRMQ2TLeXHljS8X7JjWZQ+Cq/8s+mP30igpbh1a5Kbsnh+fTCmKV2DKv/2azsohy9DWq6CGEgx14wphUFtQkluSP4YW7Aj2XFJCjQn6KNkNbV2i0tKFG4TIUNQL/xX4VNlqQl6iWZ954YQEyW36ifPiK6BUrBz1PlzvOnjb0TmM2i9QwjC1NLkZ46Y9tADLtmhoCeRL4i7QnIKB/LQFCe+wANxfKs0WECvd6foBFsJICtLpwysr44YoTUdPqcDVx5Ph4Fs9Ki/fCXAojd2LxBlUFd5UrCI4faYgtRr5znquqfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MQNfcBWAb6YuN9l6kw155JoPhzASWFoB1xQdH1eo4=;
 b=WSIUhxyrKSKMqXUxMHHVzc1I3ZOgX4FvXcsJoT8u2lp3dI8HcR3TlfzvFbmHNoZHKOXKPNGFhpQEguiv+FZk9jqv9HQMBT6R43rGegBQkPmqWqcbcddEiVPJAbIsgnZWmi7Ar9bFmqG0M2FijHemEhTfduUeKhj0IMXQ4OnSyqE=
Received: from BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.25; Wed, 3 Jan 2024 08:03:09 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::b5) by BYAPR07CA0035.outlook.office365.com
 (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:08 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:06 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log support
Date: Wed, 3 Jan 2024 16:02:08 +0800
Message-ID: <20240103080220.2815115-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d923ebf-db1b-4c27-9b4d-08dc0c326ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCC2DqzUGmQHi9kJ91aFgXwG54lSJYWSABhMb3T24prXqkEjDs7OjbZ39A7PRJcyoU/GoCsoIkHJV7vf5Ae3PQ7s2k40ItGF3yDD0RZgNF5TGKf2MYGT/iqtkFbLCZOKOSJTRvV3oN/aaAdOt7pzKy7bvXS1dnJ0oLRE77bgYeFFrBQgk+mTvSTBbxQDDKEm/zx1Fexkj0QQf3/Au3jXF9/xJdTjsqs1FldeCA+5H+PqX84IxqDs5r5hwYzV9GSpGp4xdvPg2QFVrTf9mvVJgnaJBhXh3taYzYz3qZb53XyrdTjgFCA2NmzA94knYfgNsT34GS8GJBe73qUA0hjGtJAZyLG/x8XV36W3liReX4KKnidnodpZDrlcnqZt16AWommZUnEOZZts/157dc9QDnc3wqlf7C+/nTqtt1kjtD2Aq3NMPXbuSsU7Dsy6tAszs6EFFyxnYN00NKg/PTuweLV1edvZDK1a0SHoK8s2goWvNXxD2Ki6+5oe+ZIw5NinwySbYvaU7z0mFIikYpn2sctdBuqVumI03n2DjcQxNW5TaosO7r/oaD1Y0djiaL8+zLUZyedIyVqlhUoVKA9X1Ij4AryS4NlBaAeWZao+IdJpuhZxwpwWNzTmkr8BhqRzdDRr2AS9zokiucqSjeL4lAPJxfzGot0DLKmqyvHG2ZNCJR50M+CfJklClEtGklrn5MI7SpoCUkRUKBFub7yKy4aQb9b4K4aRWOzVJVekZcoN2SBiuov90/EW5METX+EnNKGwwn9uuikUoYaCxkoDEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(8676002)(8936002)(4326008)(5660300002)(54906003)(6916009)(36756003)(316002)(86362001)(478600001)(40480700001)(40460700003)(41300700001)(7696005)(16526019)(26005)(426003)(2616005)(336012)(1076003)(83380400001)(356005)(81166007)(70206006)(70586007)(47076005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:08.9142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d923ebf-db1b-4c27-9b4d-08dc0c326ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add ACA kernel hardware error log support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 6a6f167b5380..cadeda64eded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum aca_erro
 	return smu_funcs->get_valid_aca_count(adev, type, count);
 }
 
+static struct aca_regs_dump {
+	const char *name;
+	int reg_idx;
+} aca_regs[] = {
+	{"CONTROL",		ACA_REG_IDX_CTL},
+	{"STATUS",		ACA_REG_IDX_STATUS},
+	{"ADDR",		ACA_REG_IDX_ADDR},
+	{"MISC",		ACA_REG_IDX_MISC0},
+	{"CONFIG",		ACA_REG_IDX_CONFG},
+	{"IPID",		ACA_REG_IDX_IPID},
+	{"SYND",		ACA_REG_IDX_SYND},
+	{"DESTAT",		ACA_REG_IDX_DESTAT},
+	{"DEADDR",		ACA_REG_IDX_DEADDR},
+	{"CONTROL_MASK",	ACA_REG_IDX_CTL_MASK},
+};
+
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank)
+{
+	int i;
+
+	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture events logged\n");
+	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
+		dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=0x%016llx\n",
+			 idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_error_type type,
 				       int start, int count,
 				       struct aca_banks *banks)
@@ -137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_erro
 		if (ret)
 			return ret;
 
+		aca_smu_bank_dump(adev, i, count, &bank);
+
 		ret = aca_banks_add_bank(banks, &bank);
 		if (ret)
 			return ret;
-- 
2.34.1

