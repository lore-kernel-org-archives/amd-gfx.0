Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B10FA373D
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 05:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0432E10E087;
	Tue,  1 Nov 2022 05:16:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B9010E087
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 05:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz3c64Uky0coTt9JMnt1hzAUUxWfsNpkZ9KMQHKrz9L4oAMs4zp/eeHvW9Neri3YSiSCZUlQkg2FfWNCTA49FgN2pTSFiRrCgGXmJJknOqWlBa7vkZgCpiyrX+OPmvrUBn8GX3m4BI6FZJr837Drxazjvt0mx4EVCpzC8j+AGgg02lzUwvb3pqzgUiThZs8xkzzJR6YN9n2lbYLk8U/McBb/8K0DY0P7hpfN7f+4mIrtZ+DX6x8Z8llhC/bOZ0IC5nJo9TJT8X3OhIRrrVtiROMpX9+EB71jkUq+w3qGiQpGpS+EolD4vnzMFWtbFKfUNyqhhVf8NggKtGTrvHRHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m688JOvoPxba1cUuexXI9WYtkbLjSpym4xqCU4c8RPY=;
 b=IterG5VbCPoMyIO/xRq2kmZr1T4JCN6rtqvzQRKDcyaTE7uMK5euDgHYnRlnJ0j0DYkTiuE5rZQ934KFOJiPwqNI9vXF1Ahq8oAKJs6UT75Tye3K+62odO0LpN7qR54LwttsslLbsRJ07DKZ3ilA8SzysW3TcyYZOXeX62b8PGhr3iW0YlW24n5yq4utHjPrMn5kA0tdAGU3yQXSD66GzuVvcYwR/qXiX/OcrwtJqcL14RSpQTwHHUwTjJUBSEHmDW4s6uGbqYB5TqsK6VOL7uGZ5+NLX25QBXcWfYhrtWK8/7t9ulznCU9pszvWUhKHXhiBafBYnlFdcB+qdjoO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m688JOvoPxba1cUuexXI9WYtkbLjSpym4xqCU4c8RPY=;
 b=hdyYytPwEnqFSEGTMfWu3gjGdMJ2OEt9MOvHIFglBzoOsZR+nKUuqc+qCYYTOLUBKVWPKukcUCfz7nBJJ1EjHz8/jeekDgnX+hq0V1UpuT2/cFkW8u7I5oLDKFzRuKLV/CoZnhimO2I6Sn9O1BLxsSBE2KVOqx9xbxpY7Hsrmzc=
Received: from DM6PR13CA0044.namprd13.prod.outlook.com (2603:10b6:5:134::21)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 05:16:06 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::64) by DM6PR13CA0044.outlook.office365.com
 (2603:10b6:5:134::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.19 via Frontend
 Transport; Tue, 1 Nov 2022 05:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 05:16:06 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 00:16:00 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove the DID of Vangogh from pciidlist
Date: Tue, 1 Nov 2022 13:14:49 +0800
Message-ID: <20221101051450.1261693-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: e948f6e1-5267-4f15-20e2-08dabbc82df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1tD9PyHwqhW1bAuZ7BTnYTwI2u0Go6nOIZb1nnoAO0x/bfIrholp6jLeRefF9kGEuvC4THOTxFWbxDrLU3SPYQTafodbbXHNGNZW6T1YVTDEr1GBUft1tsPIkggxoKZ8CttKevaBNqb/0Ot8fjr527EpAME9JecyU1/TebI9n7UAactl/6ze4VdbAsA7s8Ug1FaqTx8Ch7ar6+G5xpWmnYB1qrSadUQn2SdH7UzQqT5CL5nQqmlkuxBm1HrCbnN9KEO0o56+69ItHl0rtmfSUcJaPgq4wN4PSUFFXMHT14m2LWIRPIHXsmgsXmVTV5Ha/RGJ+eEMMTTBJ2S3ykqKahictKkyrvvs1LfnhEZTpyD0HisJK5+hy2Q+ayer+laRjfLHmx92N3CPcuF2C5Kd0KHzQa5NTJULiExHM2osJZvbFNm1nBuW7m90K0AGOIvRhcqalEIDs0vZ/y1irEjERe0wE+PyLC3Hn3gMkdvqN0Jr6KdNEMUZVc+RWtpphO27DPPZmR7IlU1VPfpIfuqT/lMkbhKWAvX2r0a+3uHtCS2EnepCgwl3FNsx+1DwxSf+SAx0DVyLMjgMzSFPFPAOu+Fv8BKXR1BFObolaHb5JbxGa7gaY8G2Tc50oeqWrUdwKQ1SrvSVcpJi0WdWXS374WFlWS9N2IJ6tl3CZV465dIoJyDT53PKDU1c/WEBdQalDkN7EeILqdYOpWATQXdMltACNIsfw7KEfYE5xU1f8vf53EJnLzz3TVeDZ10uUY/h8pENpnmDBuHtjrVstM12kzVP7s45+i6MoOl0M1MUhI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(86362001)(82740400003)(356005)(36860700001)(81166007)(16526019)(83380400001)(47076005)(336012)(186003)(426003)(1076003)(26005)(7696005)(478600001)(6666004)(40460700003)(6916009)(70586007)(82310400005)(70206006)(54906003)(8676002)(40480700001)(8936002)(316002)(4326008)(2906002)(41300700001)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:16:06.4261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e948f6e1-5267-4f15-20e2-08dabbc82df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com, Shimmer.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change the vangogh family to use IP discovery path to initialize IP
list, this needs to remove the DID from the PCI ID list to allow the IP
discovery path to set all the IP versions correctly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3c9fecdd6b2f..ac00e2b24a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1924,9 +1924,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 
-	/* Van Gogh */
-	{0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
-
 	/* Yellow Carp */
 	{0x1002, 0x164D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
 	{0x1002, 0x1681, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
-- 
2.34.1

