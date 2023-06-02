Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409FCC7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 08:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C481210E202;
	Fri,  2 Jun 2023 08:37:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E3010E202
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 08:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od3fCDs2q0c0OwTUdLS5hfVIedo45ePPfJg7voMRb6G7FGaJhazs1OMV2bUKwKCvrL9CKZNSjLS2uML25r/0vmEktXW9f7PYow9EkxFBQw8ordJBCGyBp5V3ZYsKlVa7xMgmrFrLwq2IDFxZChGrRRnzGZamXDYhi3Oz0owGBHVRg9hfyd+Ytn5Mig1DcFqkuKoEt7dgmgmU7qugXr9eI2TsNVIl8vSpXCzinbzWY2RAdsVkbH3LRBPhkmc5UFm4Dqi/Rc/UqWNojfDxv9i/2dAwKIMoJFt4CAEeaV1hqdrNe2E5u/syhrQO/HvDowrh3uVnmRVDkoa1zKhdYxyOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InKTBSTlWe46SfYqcXEUev2O2jvVGt1PdVh1nzLhHsg=;
 b=JMGD6V7sB5hTGgGVpkoANnSw+ewf23wMusFQpsOZmiQZOESlPY+vsS7n+vCOn0b1DsKmjd0h+kAHqTAyJkXZg6qAoKqByY6CaE9q4tGYxg43kNXaFZlkNAIyvJgTNef3KjwrXya2fPeZpZ/0wdyIxyOJkwNkt7OiFIVrWto1DSV/n/BfaB2T8QqiBLQSY5lNI0ioFa9Ro4vfSvRlSHdvzD8QQeQI1eJMN90gt5t2hHmbWvgtTMXZcc1ywEqJdtrcdHjSYbQYT7NiZYYLQUWJEGB7Dh9b1bToU2hOXG2qZQt9zMqCjAiwbPxx1fCToJMAb50nmzNxjtI6goYMvF1r/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InKTBSTlWe46SfYqcXEUev2O2jvVGt1PdVh1nzLhHsg=;
 b=hqRpfM99wiKW6v2jguP3lHa9fSewcDJ/DdscJ5Z7BuslITEZznCL5psJG21+PRBXdr6RzMIli1BJWzW0O/Jge2Cl7OfqEkfmixyhL55PYE/+Itn0LM8MxCg6/Ja03HXDToxfuaV7Y3khehnHmkiQBuNo4LzlEr1UNu46tbS6C2I=
Received: from BN0PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:e8::15)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 08:37:44 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::6e) by BN0PR04CA0040.outlook.office365.com
 (2603:10b6:408:e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.25 via Frontend
 Transport; Fri, 2 Jun 2023 08:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 08:37:44 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 03:37:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Fix up dcn30_fpu.c kdoc
Date: Fri, 2 Jun 2023 14:07:27 +0530
Message-ID: <20230602083727.1568346-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: f669417b-5f1a-453c-120e-08db6344a2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lfr0ll+cJobi4mhEvxmI58NRh/2yI8Zsm8u8LwRcDAzBoTIQVzxPzsaZZWRbKWbgcesGN0ChE39pJPW4vKPMoxhskI0WqqJeFWxDXwW8v3H3NKsRD46SMN2vg6LhvaUIlF6Pz+20UvQWpDoNsHgqoFxSrT0A4Rct4QZUVREnlGR2dmIgMymaMG5M4N3eIB5kd7z3kx484UlrMxM98l+t0kU8l/5+OKYqSXBryVknYmptL2ol1lvGMYbk86cjoBpgGv3pSIgiKEylswZeZy0JkkPVLLykYg0cG30rNNSQZ4YgZIBFQHNxJqbXOzVqtBvGyWi8w7+L8LbA6XTXPubW77yb6irb8BPbr04XSPNBlzeLkHLiPibdHXF5vA3PH43d+b56ugH1C0skUpWrfIUai05igQle0Ks/ug5fgafcPqU+BP9ywTPoEkkWSiNyRhX2lb9QAOM9VA3yOWAJkpRhReagQXdqaXfOYd1BsrZetppiLWedblnSTCTdff6gfY/q/WxDZCjsHqLeIGFKmfJQV8UHxDgrUkm+n4dSFPF2XM75IS7o+FiXR0AY8nLqF2gE5vN43m1xsfJPPN8h1BjBH506rrzFRm6XIRMLZy8hvZgdYZTWQiyTSMAKQxd4n3ETAjovBtjo5mlvOoz4/dYHqAtRCC9LGGf5qeScQItnuP28dps2bPBsOLwpqlrQQWI2GiCKouf0hXxTXhy3Le+vMWrwe5nSO8GIarKmzrdwd9VKEgkUKH/UemNxDJ27582nRKPziNJ6t+ozerS0/+pPxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(82310400005)(81166007)(40460700003)(86362001)(36756003)(7696005)(40480700001)(356005)(16526019)(6636002)(336012)(1076003)(26005)(426003)(8676002)(186003)(2616005)(2906002)(41300700001)(8936002)(5660300002)(70586007)(54906003)(110136005)(6666004)(478600001)(4326008)(70206006)(316002)(44832011)(36860700001)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:37:44.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f669417b-5f1a-453c-120e-08db6344a2a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

display/dc/dml/dcn30/dcn30_fpu.c:677: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Finds dummy_latency_index when MCLK switching using firmware based
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'dc' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'context' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipes' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipe_cnt' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'vlevel' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index a352c703e258..ccb4ad78f667 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -674,10 +674,19 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
 }
 
 /**
- * Finds dummy_latency_index when MCLK switching using firmware based
- * vblank stretch is enabled. This function will iterate through the
- * table of dummy pstate latencies until the lowest value that allows
+ * dcn30_find_dummy_latency_index_for_fw_based_mclk_switch() - Finds
+ * dummy_latency_index when MCLK switching using firmware based vblank stretch
+ * is enabled. This function will iterate through the table of dummy pstate
+ * latencies until the lowest value that allows
  * dm_allow_self_refresh_and_mclk_switch to happen is found
+ *
+ * @dc: Current DC state
+ * @context: new dc state
+ * @pipes: DML pipe params
+ * @pipe_cnt: number of DML pipes
+ * @vlevel: Voltage level calculated by DML
+ *
+ * Return: lowest dummy_latency_index value
  */
 int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 							    struct dc_state *context,
-- 
2.25.1

