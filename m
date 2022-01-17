Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE59C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 06:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DACF310EDF3;
	Mon, 17 Jan 2022 06:32:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A110310EDF3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 06:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA2X8t3XJ3i5yKlHbossBI8GWy0CifwhoJ2E9BMwg0tJR9snqNYsg9tGFlYfcyUwFETaNAjj6abwlqPTWBS/h1OBqKOg/eLCtchu82tgoM4IBZnSalc3V8NM/6g2cOL7vGkzOMvkmGhI3lLuVujihAkuMxmr5PdlPgOp/XpivUd51Ccq/PmYE7LYrZVp5LSQvtCWdLSFHw5kBigAdClMucLpy23W2S/6EimnFsVUzhYbZK/WZRDMF8SlfOk9UIYFODNgo5t/0ujMLW824NU2994JmseXrHQIdfBMa4wNTYeNqJYPnU1og7XteafjO6IiPSKJoQiiCkpi+5UnQnFvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVj0D4VZ9yesK7zO/xFIF4wOvKoh7P+xjdiCsDppx7c=;
 b=WccLLrVjKUo4fVQUY6VkCtSUWIckWajvA4iH+eHppb/3WKfYTlHlNM+N/zgdxyUyOQ5E3D3zBT/Kww+c2yC/WGh47nUIF85sShEnjZCflZDrb+Ojm16fqHCJ0vPhAnrsohpljt2a0OwiPzZwjfsXYpxm33leLaGEqNQuNhFDtIkufwKBko2718pgfBsyjOIltoo72jEXPhtnf/eGKtnyknO9Kccjg4cEU7kha7SK0jOwsVeiN6pz30NxLKp9YslVNcp+ErNGVAt6/Ow3yOv7+vaceqRlqMXG6ajQeJstZcDry3ZVreTwrjBVw1j83OhON/6IXVW/6iwTqdzuTKfsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVj0D4VZ9yesK7zO/xFIF4wOvKoh7P+xjdiCsDppx7c=;
 b=wKKfmV/tUw3pjfMDpxXjcmmJ53+VbdrX0ZlVWelaMci+WnTcZfHE9J8Zrdq0prbzs88FuvGpaHxUdSXCzTqP25GpUJVx8pA36nxN/EpqJssdB5SL4ROnvi569TlFCTM071DnxcjWU8OooNFctrnJjE9XGcNOW1uoXy2aAWmx4IE=
Received: from DM5PR21CA0064.namprd21.prod.outlook.com (2603:10b6:3:129::26)
 by BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 06:32:26 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::73) by DM5PR21CA0064.outlook.office365.com
 (2603:10b6:3:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3 via Frontend
 Transport; Mon, 17 Jan 2022 06:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 06:32:26 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 17 Jan 2022 00:32:23 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: limit the number of dst address in trace
Date: Mon, 17 Jan 2022 12:02:02 +0530
Message-ID: <20220117063202.27628-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f7bbb7-1826-41f0-96c6-08d9d98320bd
X-MS-TrafficTypeDiagnostic: BN8PR12MB4787:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB478789D9DE1EDE5CED5E022DF8579@BN8PR12MB4787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaahj+S/7RzMdGIDaWk4BOTGbm39u8ZH0ZZ2Ego0gvEobWBPSySOvNHFljDCsmSgAzByzn+Tb/J1LLrK37oUQ6VCqVehSd+rnEjp+AtHXRANnD2jwrYmgm+x3BLsGgkTVji8FXnRspbkK/C82KkgtVUITZy+4kgIGvVCslogDtR/QM/Y3Rf64spJiB44PE5SXJocabg4lzdUlV9yu+ljZ6cYIB7xtSz7/N1Rwydzy+s4kG0r/lKNNvlohGldGCRNZrBMI0rk0JLKWYicUlcX2zvoFxAZRU6d+MDyhQ586DdZcYMBMVVsyFt7nlriFA2rsZ8ntuQwC3CoJDByN3j2+SrN4iu9rZneLxutf59sDH7mIgvnkoV62TTJUgGKikwEhGmRn5S6aN4EVfsvt2beIUJochy+jOKNmFnQ/Nbq5vTOm9csKW3oeXvMLcgRzeis0Rkx7Jp2/LH8B7EqR3foHEruricipGtgCylMH/fkRfpn5Xs2jv/xbvO+Zdisj1fPdmN2AbHkFSI9uDQLglYlligxlkXKEOfxRv0ORLaV3wbdEwH0freaaOwmriwjBOl4X6lVWJpEGutSXvaZ83Vkt1yt5Jy/gv7J3pgxqoy1VoIblHSRFdBR6mU2dWKOQV7WPo9qI99QfrsVq568u5uV2yM16x9I9ovE2z+yENmmADlSgmxxmsaxLLweZjhn6WbP+byBWasxORLBYtaBv7mtJHPJ7yiRd7L8Tv16WieLb3hnPEsW5klIOJMXEwrB8rl+rfOtpHkIZDywJPgdLl3+aD2btLbRmvAHweEmMwaAE6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(70206006)(5660300002)(4744005)(6916009)(81166007)(2616005)(86362001)(186003)(54906003)(6666004)(336012)(16526019)(426003)(36756003)(82310400004)(1076003)(508600001)(8676002)(40460700001)(83380400001)(356005)(316002)(8936002)(47076005)(7696005)(26005)(2906002)(36860700001)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 06:32:26.1781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f7bbb7-1826-41f0-96c6-08d9d98320bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4787
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

trace_amdgpu_vm_update_ptes trace unable to log when nptes too large

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e7dc23f78e7..f367fcc5c535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1634,7 +1634,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			nptes = max(nptes, 1u);
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
-						    nptes, dst, incr, upd_flags,
+						    min(nptes, 32u), dst, incr, upd_flags,
 						    vm->task_info.pid,
 						    vm->immediate.fence_context);
 			amdgpu_vm_update_flags(params, to_amdgpu_bo_vm(pt),
-- 
2.25.1

