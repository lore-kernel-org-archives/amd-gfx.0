Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27ECCDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7466910E589;
	Fri, 20 Oct 2023 07:02:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EA989BE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niDHCAmf2S5uxb5sYKYBfN0jan7ul2tkz+wAm82EQ52m06vcsAkwVHu+/0F0Mwea6ApJvGp7B39Kez5Tmqg+Ad7HF2Olr30RJtTuTNAvDvB2Pu+6HHGmmrkE6QxsCv2W38DZ7Da0YPrbQnSn4cHxGPFI0F/19SIL77+7LE6+9WVhWSglJZQnTPXGeyEYq30op9sXrQhEYGOjNKS5HTB2uSXXVG7nLIC9cwu2stcsCqYHKeByjLPmcRC1p3L/bNbmvbBpN4DDznR2eimabpzw31KcNaX2bFzCvnqkT7FVuQLqYvPQ1PdrmiiKeUFhnldQfsKVTpowacNYJvG7kofQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I14nuO4Qtcs43FChaOMBygwZM0XB3gJjqOpbqxcB49A=;
 b=TteCCap5xkNinbYftfISD2TB3DjhH8KzxyiDqmEmYyX3JPtNJj+qgElT7Ht+ZlUPD+fSj4fFx8M8quBUKMfJZEpNl8jWaFScW7ksukcal3IUqV09yzfHKAQY2RSaARDzsCuZXSTc/O807TgyPtSabvvXLjlybulwIAQgxK5FbbjNnGvjofW29LOpg+VXdmEm1fYSEVIQHVvY6eg9xGiMYnIRaAZu+q4vGqtxENY0znMPwQHorA1KDUqMwDFI9TinOXBEviHMMxiIMxn2H0kWIfQ8hvSz0Hf7G37lNPXCzOH+0DugH0CVXHHfCPYEp3i7IzBdpRoebRZyuYkYUZQepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I14nuO4Qtcs43FChaOMBygwZM0XB3gJjqOpbqxcB49A=;
 b=BduyQfYCpKZQ1eoYco6UNwbUjg9KCysVEqysVA7tZ9w76t2zew6PIAUTxuz70Y2wPJIPI2Tjz2l4zmpnFpqaw0fQJHjVtSJqTzy6Y5oXkUn6umW/lFrvICwTTsBNp7obBbsP7MOH0Ozwi6dlUfu8HEtrH4a59LHx1AWN6sh0j50=
Received: from DM6PR07CA0120.namprd07.prod.outlook.com (2603:10b6:5:330::10)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:02:16 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::c7) by DM6PR07CA0120.outlook.office365.com
 (2603:10b6:5:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 07:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 07:02:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 02:02:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test
Date: Fri, 20 Oct 2023 12:31:50 +0530
Message-ID: <20231020070150.303423-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f61879-3199-426a-e5dc-08dbd13a7e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJSepVi8wFOprM+hBc9Fmh+3gn5B8t88tSieHuYfyw9dY3JhxppyCR+Q6W+Xc3Ug4S1KVxVIM7AcWXDH1F5VPqkzmbwyobbGgzfqUxpZmj0SvL+UayCUmeDfI5GaP415XhJwr2oy1ijACm0qiTVt/5Rm18x4VqeA7ZoDVFZmjZaOEIVtlCjVOOG0gqxdyeF76zC0drovBCXPO5t8Pi8G+Lkk0mcAS+m/prvMd6jHh4ueexo2KKxdrjoFdkYTVTAbC7fGz1/QyFWBnr0XJzB7K5iYK7Gta9EZ2UnmcWqVPRIKn/dYCibBh/cEglrGrofXmanxB3TSzCGA6AbdwlU/uUsavyc4X/H13YER/0xvtUN48Z6n3xH5d7dQQx1gP4lSrcGoXZYYT82g2SEeQXSU1M1aiZIBJ+8QZRF16YN76KjArFJ2lL2BwC3I7KrgqGHVSxeTasvVkE7bzk4f09ell0MmLsvG7WmyCnpeh4XvSoMT3E7zNuxwQUFLv85zgtVgF1KIHPmS42Mrr5bSTlT0Rypmw9Ul7EaFkC/tM1IJTou92ZgrLJ0jCocynNneOrKQg+bitM55W3Jvj5iwLI24E7SsN6cVbaTGfueZZsWUofV+0G9knvxTZIml/6PG7Ff0zyERyX1hTRb6rQcsSOK0QcNyS/1tE/j1m94ahuNyYUX1AHEDd72SsZk9va7v8QjchaMsaChSPP61HKgCjR7cHigepuEVQ88aVdTu3p9WLPORIElk3BccqzHr/hMreSf+0HEXwt6FH5Nm4lK0ZO3lQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(6916009)(70586007)(70206006)(316002)(54906003)(8936002)(6666004)(8676002)(478600001)(47076005)(4326008)(41300700001)(36756003)(86362001)(83380400001)(44832011)(5660300002)(81166007)(4744005)(7696005)(26005)(36860700001)(2616005)(1076003)(16526019)(356005)(82740400003)(40480700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:02:16.2240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f61879-3199-426a-e5dc-08dbd13a7e75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Issue a read to confirm the register write before ringing doorbell. With
multiple XCCs there is chance for race condition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a1c2c952d882..5861e4d0eda9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -256,6 +256,7 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 	xcc_offset = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
 	scratch_reg0_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, ring->xcc_id), regSCRATCH_REG0);
 	WREG32(scratch_reg0_offset, 0xCAFEDEAD);
+	tmp = RREG32(scratch_reg0_offset);
 
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
-- 
2.25.1

