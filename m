Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D769DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EDB61283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3EDB61283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9CD6E3D3;
	Fri, 19 Nov 2021 19:43:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AD46E21D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzsEvQ7vQybpW81owjIHPTFebiXDWUBlub6+oBX4ZRrA5hDdJYIjcE9gqw4yuFmWVO1tQlIApe5RvRvbzY8ksLfwAqKucKSpL+nefy0VDju+JrWI+lkf+bpQr6lrXLLIw2WYM9aMgP4RBdZuhBEasPrC4kCkOQYrDlFZGauHz7j98av/f1REiAAlBJK1M4XL3o8W40R9DOLyVvmkJSom1yYjS7X2jgd/g9YTV2APrIEd/gm7nzax7CiePpFerZoQ8kNDF9lA69txvITBrxwpFK4OOHkR0sKCXgEbKvxTGg1NwA6uq054f8Ygv163uaCdcDE/e5xvMtgOZomXYMbl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRnsj7ZEHmslzq6k3AhoJW0heSwiSPqUUN0tbbVDHl4=;
 b=hmZ5eqF4mK8i7JkJHLjNT2tlogMnEZAN6Ztj9NAJRxavEPu6BS14/5CRuTPRljIvp1UK9FUPv9Vl82awKx0GSLJP5minNdbY6IH40xoA1YQgQZ7XR+xgioK11yAgM7OkBviv9KbTafN4hd8PI/K32V4E21Dz68ynJ69XPt3Oqt7OJbi/D9QubLPMNs/aKBrRkBonZ3anGMxQ9zVwefySdWwe9KZw9rZBujhGWoQXaJiZaFlPqWhj2qCk0+SOq21HuOjgDG3xyX33tUfFKmCXjlHFGSBosgHF/K9HPDVY2Gfol7ext4ar9mfRb5FNY7A0v8TUjOyNBJ0gavUen8ydQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRnsj7ZEHmslzq6k3AhoJW0heSwiSPqUUN0tbbVDHl4=;
 b=v2cRw/oN9+jJAYM1abFHIcAxgjuWMOKcrpyJvZnitdApQTJtIM+vh5eklPRHv1P7PwK+NDYBNUq/gg0qyPXASNpq51PbMDog5ssCUDVplveQS55cawuyfPB/OcSxh+8l7/UsFWyWz2E4pMKLyLG0f5/Y3KjPurGUH5Ps6eYjL7o=
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 19 Nov
 2021 19:43:50 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::d9) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:50 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:48 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Fix DPIA outbox timeout after GPU reset
Date: Fri, 19 Nov 2021 14:43:24 -0500
Message-ID: <20211119194339.97573-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bca12ff0-4347-4939-bcc6-08d9ab94e929
X-MS-TrafficTypeDiagnostic: CH2PR12MB4054:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40545B98D3AF3BA8AA9ADD9DFB9C9@CH2PR12MB4054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZadE5WVa4Nj6DFax+OB/wJpInNpd6qhzfeaL4wzG1H0y+roaEMTUnb8u8WFzlUseioRqmURgui541FoipEgS3yeMDu4+lV9tnSJ5OTIwF0Ts5ViYMAaqZL1p6z2KnW4tGN85I00FznVdlqqMNDD6n7RSPg6bke/A56rQsKiyW0pXls2CQ2APyVm7nqYHXIZkJejkqw18fluIhRN5v/b43AJOQlcfMTpXr0yVlyLwInXC3a4lL9Y+pNeGk7SsqAbmQRRb00g/Br1bVTjgqXCcw+BlqyIKKfsphjCXpevD2WsqjKRo7VCPFnlCRPGLtGvSnS24A2prtky20dYZio8VAGN8s8pdAkLiPj+R0c8fupevi5EuDRtpSBrnLSxkfvD9UpT3NmOFenYk3wVAx/Jhi3yk5q1z7IJsGwV4iEVfsSeEqEjydWnHL9fZlvCxbH8rp2tLInxNEX/dUy46K2VqkKBSriY08r+vNhHj1R9Bqe8CwDLjyvFy0kdtBp8ZwEWD55MqC8I62STYJYRgAcUj2l+ju17ntrCmWvaszzddZM7M95GpLL7EsUSp7KbjXbNm1TjHP5ioAkK6R+Jumign2Jc5la6fwkW4jg4SqyYzL815ucsoIk5j13SyRs59/ptkNtRdTd5y5zhbOMfKYqgtGDDGNTVTzopLTl0Ff9RlzYMYRlj4y57GzJvYzdKhhAPeBMlarzknSRNFHGvyF3XXfUTgDMA3UuuzBW5QmAdK9k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(2906002)(186003)(36860700001)(508600001)(8936002)(1076003)(36756003)(26005)(81166007)(83380400001)(47076005)(356005)(44832011)(8676002)(6916009)(6666004)(86362001)(4326008)(54906003)(2616005)(70586007)(316002)(336012)(426003)(82310400003)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:50.3452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca12ff0-4347-4939-bcc6-08d9ab94e929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jude Shih <Jude.Shih@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The HW interrupt gets disabled after GPU reset so we don't receive
notifications for HPD or AUX from DMUB - leading to timeout and
black screen with (or without) DPIA links connected.

[How]
Re-enable the interrupt after GPU reset like we do for the other
DC interrupts.

Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")

Reviewed-by: Jude Shih <Jude.Shih@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 26fcc8911698..c88054f8c583 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2562,6 +2562,8 @@ static int dm_resume(void *handle)
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
 
+		amdgpu_dm_outbox_init(adev);
+
 		r = dm_dmub_hw_init(adev);
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
-- 
2.25.1

