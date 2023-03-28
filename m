Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C529EC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0656010E902;
	Tue, 28 Mar 2023 15:06:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09C910E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8cK5r60L3aDsdiloi4VtS+nc1l9rQq0OwT+6/KGVkLrCkyx5mwMUbaQH9xvo+nruFR3kM/+EHlkFbFIM9dYffEFjGQdkM3oDBJGjkOuo2A5+RqmjKSVXSx2HVq6aSbjDeI+U8gr0oAplGjIxP4/fe9co4zL/QByOWrx+2UrkrP5SNAZIpbOLxfZjwaf/i8NOPytWBc8SKfYefUFNYl70aXFCJG2LRrvYNODwcHC5sAXZHR3HmsBugLe9Qu2vRnoVJhJTviCSjoM2r+OIDTF+FfFU5jxJeiejNIGdds2A9tXc1WtuCR4LcIIzd51oIHMoxS+aUkuCDSQbeho6lKDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNUTptVmvs+UBbgy/NR9Y4dvFXJOIRctBT9GVQZqmRg=;
 b=W2keMZzvTkO/sLRWTqnDAagEC2GDlKFcd6aUHAmag/rAdhQ1R47uq2/BlUMYISGeFxchwF/5JE/J29QzAU84gygJpOb1EvDkJg7+CnmnRTkjkVhhVzRPe2OyNl4pOrPdJIClwpltsvi4/EMBk/0U9olA2IGB3bTotgfnpMmtatcbTEoK4HzOlG2XfTNGzhDe9naRAbd2RcavA9H6SXsShDE+a3t/2kH6jK8mkyhiDqYtJ+w0hmnTK90mrrf+TCkvZlIgDE/Mu5VdbWc0mGEywgmuP3aVNvZ5Nf3PG5/CBvqk3+lghHpdxecoTwby5seCHlM5RHAW2bTxYHAKLKIjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNUTptVmvs+UBbgy/NR9Y4dvFXJOIRctBT9GVQZqmRg=;
 b=RFIuu8KXulLLfJ5v8YRTCauayIM0iFnYVzgQTPZqCnH5Mow4Y/Pf4bUIaP0r0Vmxz+2g7ZNZX2fJ/0WjBAjmIZY1K0KeoQo3UOvZ6Y37qwzYqx0t7BCkFZ2E1zQq28T/4QudUx1nVOoT04MbuhyfrjjlArPLXerzIQBKH47NMvg=
Received: from CY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:930:1e::29)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 28 Mar
 2023 15:06:07 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::2d) by CY5PR04CA0022.outlook.office365.com
 (2603:10b6:930:1e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:06:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:06:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: fix vcn doorbell range setting
Date: Tue, 28 Mar 2023 11:05:50 -0400
Message-ID: <20230328150550.1933519-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328150550.1933519-1-alexander.deucher@amd.com>
References: <20230328150550.1933519-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2751cd-b264-4229-46d9-08db2f9df4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uACgx9/qtumrSS+GY6HlXrxtS4cPdvqXY56t0Fmhtn8z9I8MB8uz0d2X5l9LF/oLDIW86MhJQBzo3vcL9tpBlxkI3sD8d5Q4eY43mhTFzQKaX8uiCOdgrA9J50TG9/7COoxlH3Mt5kLGYsl7scu8NFrPMQTr+x28sonmQK8ihwmOCQkS61oUiswKNA7rFcN5gjDsJTpDvirAIAD+nFlUHD+BgCUXA1Pjm7BRcg4uO3YszqYJbdGLz6vdqjFgScVEnT72iF6EDp9741lBDrhX38tqCNnlR1D5tbztwlnZLisvxlSZz22Oml76347n/1dVw+5PPldoM/7TKfTznkAAI3JPwTuA9L8SbepO8m3/ubMIQkjSENiwWOhGlt43j3sefFb8MTAIYRH8sxtcl0vh8owhUTB10sEdJP8SfuCwiEe+yyQq9U48+NkDtpNheUP0aSB1zVLntaLXX4sjJTqFjiE2Llh3sACJXjig+cvUD0QX/rFZTCRSuYFuFbVCbQETTqAtQxHTXBZn/Ly3TYJwwfLcjdcrDLgJ9ouY5CP/WcR6GNg3KzC5biAFVbrPiBsE4CMxLQ1+qrHFfgyqoZJm4YxR8WCI87rDSYz/SscchTsDW+NeVbeb4RsjEsdOc06rRRJLajtTY8Su6ajRVciBVXhA7uiQegu+3VZ4+F536uOgV3b8X9diqnfBDsDIOggVbKcMP0mTp7Bb80BJR8UyPRCUF6TqK4VvTAZu4cLNyYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(8676002)(86362001)(7696005)(426003)(478600001)(54906003)(70586007)(4744005)(356005)(6916009)(2616005)(40480700001)(70206006)(36860700001)(82740400003)(41300700001)(5660300002)(36756003)(16526019)(6666004)(81166007)(316002)(1076003)(26005)(47076005)(82310400005)(336012)(186003)(4326008)(2906002)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:06:06.8573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2751cd-b264-4229-46d9-08db2f9df4fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
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

Should use vcn_ring0_1 instead of doorbell index to
set nbio doorbell range.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 4418c9f05ec4..ae2cc47d344a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -176,7 +176,7 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				ring->doorbell_index, ring->me);
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), ring->me);
 	if (ring->use_doorbell)
 		WREG32_SOC15(VCN, ring->me, regVCN_RB4_DB_CTRL,
 			ring->doorbell_index << VCN_RB4_DB_CTRL__OFFSET__SHIFT |
-- 
2.39.2

