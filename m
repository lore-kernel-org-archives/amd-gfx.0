Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A518C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 13:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A701B10E60D;
	Fri, 20 May 2022 13:20:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4BA10E60D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 13:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz7IBXKogEvhFui36zzC7br/4F1sx9lVPzN2XBL36SfogLOqOS/J027VyK2WZf9F3WxZjF3gnUhRRVfQ7hwhkSmSLEpei2K2pCPCID9nFiP0tS7nmQ5VC3PddXNASf8vi/o+JW3kxzx1hlp1608Tjvj4XR8OR15mH0FxFgLwGjaCDDHmwr4mLg7hPOdD1xY8m4JbRz3ZiV/DhY2B/SdMo0z8iNBoCLCDBfyHqpONh5dZxobcb/A7YTN+1kxdXGXNw8Ov/py+pOMbhKgAa8YgCxnrqMV4SVulilcKMzujloJymGiP3gW3M4wdWbwZuY0xpKEfrBfNbX/NdaBjHBFlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pzU8AIguVv6DX7wS3+3tZW7redgKAB/XgKrCr7vMjw=;
 b=fsm8WfJOymq8n7vP+zJsJG4raf4ZfliDHkrDvJ0ze7AvCgeqFQhtL50hSBnI/kXiCGOxk/O5IcG/8/i39v6P/i/hkLiy23UHdwSNuvXambpw8xn718XmqZCAWRUB+MoE91gp2vqRy85aOjz/d5dE6Di7sLtFr/HbuzLCBSj5d0xyaEBETPokz2NmxOCFmjE36ImMZT2AAv70l4CP1w4EVTK3wGNo9XdPfhSu6cqF1aAM/GCy6ZRn6cyvJn9XJuLE+QNlzQMmNR9C0AItEn+4BemCWs1wNlwPekele4ZkJiMZgJzMaDVVGOP+43NhMdGbHN/yt23sfAyEfdmclHWzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pzU8AIguVv6DX7wS3+3tZW7redgKAB/XgKrCr7vMjw=;
 b=GXrmhsKEgisNVH8CyLgfCK5Na5MaTKS469AEFHdHjkheAuOjGkJ/TW3XwO4xxGCbPRKwNCySW3LIkxsGPv3rBC9GtY7oT6ZIaYEawE8RN9rlWhXR4cMXCzQ5L5UDuxCmpEpZddKhbFstMW8MPf5mpbaSXlqNvWZuK7dMZL7/8JQ=
Received: from BN6PR19CA0100.namprd19.prod.outlook.com (2603:10b6:404:a0::14)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 13:20:52 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::72) by BN6PR19CA0100.outlook.office365.com
 (2603:10b6:404:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Fri, 20 May 2022 13:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 13:20:51 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 08:20:50 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Resolve pcie_bif RAS recovery bug
Date: Fri, 20 May 2022 21:20:33 +0800
Message-ID: <20220520132033.25135-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c86f4a-6b9c-477e-6892-08da3a638ff6
X-MS-TrafficTypeDiagnostic: DS7PR12MB6189:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6189D0D3BD45D71F40FECBD491D39@DS7PR12MB6189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Eqefsh7hIL0shaUimQ0nnK73ekNd5wf+R864ZHs+1ixfuE4HgHq8G0kPELUw7Xo2HOuF9L2tycZwPnc77mTcw44fPlYuPT3F0LkP9wLU6ATOfh7hTJD4c1OAc441tLCgg/tKX3GbRiwbgoPG+fW0z5ut/i/E2ON0K/Ya4ugGFXpFWVsvlYvrlTv/6TcykJmaHGCFxiqfV3gEwFmd8IpCoVo6aK5vNumHK2Xrs50nv/yT0hqw9YbzuljzLX1YuPcGU44Ieo21sRo7MSUgrOe5LBlTyawkWWg4lMuS5IhkmMIE/Rf8LlU2sWGDJ9CuCouL4Lsah9z0xLNUHgvrWf5WlAblx16v1Fa7TyJewXkAjSeYfEyB5VEvEBDD2LKTJQ2tNWhI8z4lPdxiRq9jxZmKBmlbZfLC8bhQJGk/4l0WyoCdOe9rmESRlCACkbpN7uricDySB+RefJgR/+lBteIUmHtPBWJkgEARNib34Z+IdRopEviM6OW+UIkcqG/buQOAFLbz1XwHzLrxxKVwUym0H+RK6YjS90l1c55Jp7gNYVscrdqM4GLsQHHcm2+tpy87sO23M9mToFZafWVMy+ujVA7K8AKLdJz4w6hvCLeRBEtxvRCcTWPBddHlrxwnX5ghp4nT4dhO7BTu5u1h1XmXJLBL8SIlY2JxLt0swD8RrH/a1MuD+DJymmuge9qi5S2LXikdQ/BoefyfBKl+ojKGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(5660300002)(356005)(81166007)(44832011)(316002)(86362001)(2906002)(6916009)(4744005)(8936002)(7696005)(82310400005)(8676002)(70206006)(2616005)(1076003)(40460700003)(47076005)(426003)(336012)(186003)(16526019)(6666004)(26005)(36756003)(83380400001)(4326008)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 13:20:51.7029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c86f4a-6b9c-477e-6892-08da3a638ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check shared buf instead of init flag for xgmi ta shared buf init
during xgmi ta initialization.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 214e4e89a02876..e9411c28d88ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1177,7 +1177,7 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 	psp->xgmi_context.context.mem_context.shared_mem_size = PSP_XGMI_SHARED_MEM_SIZE;
 	psp->xgmi_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->xgmi_context.context.initialized) {
+	if (!psp->xgmi_context.context.mem_context.shared_buf) {
 		ret = psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
 		if (ret)
 			return ret;
-- 
2.17.1

