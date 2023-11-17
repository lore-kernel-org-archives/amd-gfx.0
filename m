Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC83C197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 02:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F8410E70E;
	Fri, 17 Nov 2023 02:11:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DA710E70E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 02:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4sO2b/MVKnUSBqhpDRIZL6fFiKMuOj23i3S0fna5I6oIUM1c/CIcdRytnDSAaMogwxAsl9pRunPLVjxiu1VdQq2SExaDcNODxhRkjt/M1pf99aKxiL5vvxiBSOwlc4hThh+eHvMnaxhgV3oZKSY42VRlLzb90DH9HSL/r2FpM7Ur6UYDYnZv2tGHMBYCAke5Ho+MSlLvdm4k0qGrDeYkk1XgMO66bminHXhQPQz97D/7u/sbKKw5Yd4ab6kdsUYtxWrcaOXmm1+B5J45rA/kA8pmmlttAmXdw/4nEs/d0VTkX6b8D8+OxJkg+DAkP6BqEV2Oh6CGKOtbVso5qeCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r309kfGmSlNCd1YmrRhT+fgOgDbalG0jtyeJu9qLtLg=;
 b=ZJRPwT41+QPvrxD9vchihxqXd0Dc52tSt1q426/TZioWxqkS+0p1GA5qCFQuzWeF/XyLVj3UJ4nvt9bdrYiuNziwe7FmwntqVXcc6PEUoD3CkXCEuwyoUSTVbzSGxL5IiIFXiocO+WYMQ4tZjmIMVIpQRYojk5SVUuV44NuyDljhmIWh3hERMhkFcVtMVXSo6xeZzMTNXzmgf/G+PjBN09q2d2rr8idF2LM37uRFLq5tTGtV+ig0SJJv6mJ46sxWjc/zyBGjXvWCLEuseFq8TiiPWxJli7QUqPKKfzzqnaFOhmDpFDkmAEvPCpcaLrTsYt3siktOJHaIz3enCd/7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r309kfGmSlNCd1YmrRhT+fgOgDbalG0jtyeJu9qLtLg=;
 b=DWW7P6td/kwbhcEOwwl2h7nIas8BNRnIuTLKdLq2w5V/cJ5Yz4Niz6B34p/rnJmSCTq6d5+bJFo3VTTNQJK8QgEWLBCJrBx9kjM3K7/lSjzmVdhd8Qy8j9nNVpZhCg5gnxvtF3zyn2voGp+0W/90FwNNhKfC8Zut81qG9WfcOHo=
Received: from CY8PR19CA0044.namprd19.prod.outlook.com (2603:10b6:930:6::13)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Fri, 17 Nov
 2023 02:11:15 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::71) by CY8PR19CA0044.outlook.office365.com
 (2603:10b6:930:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 02:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 02:11:15 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 20:11:12 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/6] drm/amdgpu: add lsdma interrupt src id
Date: Fri, 17 Nov 2023 10:09:42 +0800
Message-ID: <20231117020946.2912865-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231117020946.2912865-1-yifan1.zhang@amd.com>
References: <20231117020946.2912865-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: be4aad0e-d665-41cc-2498-08dbe7127a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdpTGXIGN99Q5qYhP6BkYaKHIDIh96gas5AJlViz18Ijbgn2zKuJC/t4LxyGDydcvMrpn3M6LRB4xOK/vk9LgO682Ocl/svdktNyzfsrAV8Ni7DrZ3IertbHmiDvpCKOswkcPM73huBNuwxTaQ9pNEgfSElNAZP++L4k2lRbfv+ce2j89Ufpxd1Oig8cIxUz+J3wYCiDeKdQNrSXQNl4HKeCaiBZHmjux5ff000nRCzw7W3Zt2j/08xCj1ix4CCRw9EWTF3tyTGYHBXFbRXtCJizsep2MTrnEw/XQTImeVmBvvDa2sNIBpRYxwr0fZ0b+RQ5lfjERB0dmDRyYL/XwFGAVHv4KD2OYBDl99cMWnznWb0gv7+rSdToLjH+W3WdamnbRmdPUD6ZNELznxrurCwWWcvIVZqx8n/uZzJQ9mmjEjjG9A2Prc06TkPsmtSCKJGEHA2M/mHJj5u1d+jYxyNsPrusnatmvnkaZOd9D44SvCA9YS4Hxu3G06BNeqg21+oYvXMrjJd7ro6ngNszd7F30G9yQj1VVmg6yHxGU1VOvjGiOdEPaDPZOtYryBPMkcuBOazNwHxAnmt3Yh1Z7Lyf+O5P9qEKEcUrxRmEo/rUqpdsbUqlGEDqguOdZTytvfoyK6oVAzWAmYj7vxUwCbsZfEF/JMXNXRBsH8q0ZMPiaUB0PrLgTablITQ7cmJlArP0w6IiwcipFWgpjYW93x8YffyDfIbrAt/OaUtEWuXE4tBaeSI05q+r3l8NqAQ/UOzmDjbUH+/ilmhjvKokqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(7696005)(2616005)(4326008)(316002)(6916009)(1076003)(5660300002)(83380400001)(6666004)(86362001)(2906002)(426003)(336012)(4744005)(26005)(70206006)(70586007)(16526019)(8676002)(82740400003)(54906003)(478600001)(8936002)(47076005)(356005)(41300700001)(36756003)(40460700003)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:11:15.3920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4aad0e-d665-41cc-2498-08dbe7127a94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add lsdma interrupt src id.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
index 3a4670bc4449..cbdf46a3c9ab 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
@@ -28,6 +28,8 @@
 #define GFX_11_0_0__SRCID__UTCL2_DATA_POISONING                 1       // UTCL2 for data poisoning
 
 #define GFX_11_0_0__SRCID__MEM_ACCES_MON		                10		// 0x0A EA memory access monitor interrupt
+																		//
+#define GFX_11_0_0__SRCID__LSDMA_TRAP                            49      // 0x31 Trap
 
 #define GFX_11_0_0__SRCID__SDMA_ATOMIC_RTN_DONE                 48      // 0x30 SDMA atomic*_rtn ops complete
 #define GFX_11_0_0__SRCID__SDMA_TRAP                            49      // 0x31 Trap
-- 
2.37.3

