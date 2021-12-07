Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39480C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 16:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0A4EBED6;
	Tue,  7 Dec 2021 16:58:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635C2EBED7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 16:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykxdv085ElAk2nn0piE4lRjB4BGGYmEfiLdekP01TBPTyWTOBpKz8yYDMAO312N6N/0DQ5qoNtRc07ZXaPQX6KEWMNrw+ouRfR2SEEY62IwaXCGOAjXQYjsdfvI8cWrD0Wft+gfedrzQ+i24cAcsOlq1ERfNUWOGrM0S1mFotSjlf6SJveaMlVLGCsu95qYG2dsCMuJHxg2GIgcb50v2rOOebYdZzm9elaf321t7lo9U30JSc9hhvEzeE66/ryk56gGhLC6iBrAPd5j76VpkJ7U1bl23HWJXzLcIcaURZxh/Nro8LJyOngFqjUXJqkyoKzQ4zIFAFW87MpBAzSYMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zFtdupcSoNsCNQMpddTmraLyebiiUyrH2aBlNDMe0I=;
 b=bzy5LJQX9mwOiwObDgC4Iq+CR8NN5v8GwAGM2U2xtYW/tc4iCDxjtxxwHvQ1YxRVWuHsFaiqLdi6SeDU+jlZ3Y218igxMCN31gtjZna+75y4t3tsxwW13U0wv6mdnIng0DqS9kaArNyz6RZW2IrFjzV8Gg69kRGA0rSadfqxMOQIFB7uYUuPfHawNrUzWdSkql3R4ZjPvUcOHT3+Hhe82YIXMedYtMRQDW9+Alh5o/gQ6crOMelLNbFDau2x8ee9B0cZwnc+GcQ8Xkrncd1FF2Bzmdbr6SRmNuuHE1Bg9LaA3+S52iefOTos0wUuih00jsJ7Z3eb+2bqRDBXZMHBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zFtdupcSoNsCNQMpddTmraLyebiiUyrH2aBlNDMe0I=;
 b=dqRhUBoq5RdXExKXFaBy5pPsxZ8xL/7R4qfQ1Pz2x1nUdL9Zm98wcI57GwvuCNpsLrNsKlhQBhYuokiWP35uUyaanZQd2kYJ77q+AUqgu9QkSpjA22LIJwN4o59Dgm3DZKDWuSSiOq9k0+CLcoPnNE6IBnF2xW0nqeCyykvsraA=
Received: from DM6PR07CA0061.namprd07.prod.outlook.com (2603:10b6:5:74::38) by
 BN6PR12MB1492.namprd12.prod.outlook.com (2603:10b6:405:11::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Tue, 7 Dec 2021 16:58:11 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::33) by DM6PR07CA0061.outlook.office365.com
 (2603:10b6:5:74::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Tue, 7 Dec 2021 16:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 16:58:10 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 10:58:10 -0600
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: initialize XGMI for SRIOV VF during recover
Date: Tue, 7 Dec 2021 11:57:25 -0500
Message-ID: <20211207165727.25109-2-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207165727.25109-1-zhigang.luo@amd.com>
References: <20211207165727.25109-1-zhigang.luo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e441409f-f8f5-4474-bef7-08d9b9a2c036
X-MS-TrafficTypeDiagnostic: BN6PR12MB1492:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1492C05B812332FFD76F9AF8F16E9@BN6PR12MB1492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WI7KVLW++w0wHlFlhqyakFWWlGc2p28vUHT9tTHNa1rPhs8BPmSSqKCZQshjUUMnVwp4tKSho4W4eSoZ9LD37EogK/HU+gfQ16xrbb/nXbO02YVSov8jiiKD7NaGj4jFE+oyaEO29x9eug2dKSQcSyiXZhYvksJA/XdVDmCsQlh3UFnfW+wcjqgaIOXmW8xU/Wn9+/JXDvsSG357x0NgZXc6PNjla7aRdJiqHCmPf3iLqO7FTfbT6yddOQm3DInmppVojs8HWTto17axUnb2EBQiB7VCIInPWd3fQWw/dFmnGP1MivXDJWOL0x7ZJ89MwpHo5MGalSYJPpVFSCxYow0QNvQa4KC+vlENxw43/jaMH2UGKH0zr5xA2YRy7PlCGvQLzw2UssICFkc+Ymg9IUpSjk7zlYcwBaxcmHeyL1RodSLJHXNzoGpq5Gvca7O8Z1IDmaRMz3ng5FNXX9npguJUoyHn9Hy7n59iOJs43JF6Rj8qm45XnYNpcy6FjrDw+DJggHM2MY76yuRxPylTV7Q0C4zHv5l2XrDliS9xPZ8YcijhejFXuA27hJmKpVMclfoLIw/ztUPVGTnqlA9xXrH9II3ehnz8SbcQPEXHzVRvJC+CwGn0/ZJ+RRCjmVSX+KgXqXKUZdjC7yv0aFgReYY27H/b9+MQKXrhEXgoShlJdAdmwNhihWhAqnnsMuEmbOgpV/DFBQ5CjbeD2OMbSv97mtFUIjLoSaIFwlkQaxnQM+FSZoAF99F27Czr6/bH7ZMcqYpsc6l/xkPN1zXBcTAyrZaL+Ufj7Jh0t8LxXtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(81166007)(36756003)(70586007)(44832011)(70206006)(36860700001)(316002)(8936002)(356005)(6916009)(2906002)(6666004)(8676002)(4326008)(82310400004)(426003)(508600001)(2616005)(4744005)(1076003)(83380400001)(5660300002)(16526019)(186003)(336012)(7696005)(26005)(86362001)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:58:10.9195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e441409f-f8f5-4474-bef7-08d9b9a2c036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1492
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SIORV VF, XGMI was not initialized during recover. This change added
XGMI initialization for SRIOV VF during recover.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b48d68d30d80..103bcadbc8b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2452,6 +2452,18 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		return ret;
 	}
 
+	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev)) {
+		if (adev->gmc.xgmi.num_physical_nodes > 1) {
+			ret = psp_xgmi_initialize(psp, false, true);
+			/* Warning the XGMI seesion initialize failure
+			* Instead of stop driver initialization
+			*/
+			if (ret)
+				dev_err(psp->adev->dev,
+					"XGMI: Failed to initialize XGMI session\n");
+		}
+	}
+
 	if (psp->ta_fw) {
 		ret = psp_ras_initialize(psp);
 		if (ret)
-- 
2.17.1

