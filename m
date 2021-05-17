Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB6C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA1661CDE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA1661CDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D8F6E9A6;
	Mon, 17 May 2021 14:39:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF636E9A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0CbfPCK8cmiIFhDrhPFkhByFWaae/J23Gs3cU66bV2VcOvfqExIRqa7ArhhjvRj3SI3s69nJTYKan/Sppm/lkyrd4oNo9jnP3KS22eo60emV50ZLAYESAW/MEmhJutWCBqvJXhO1QxjS4uJURlzbPJ3pH/u2FJVyR1t3SiLeanyVBGbmMOvndWyelhzZHUidMTYYCvaXfgqsswTxZv9hdO0PK2EO4bpOvX+1QVinWOKCpV2FNw/R2f9HagSi6QYJRbS8RhzKe0mBlbHcepSMES92p6vjI/gFrbL4TgCK1+p6bOEhuZLXwwUxCqkhqizXHbNDG03wI2MxG7z43tHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=ZZD4VOWdC2X/eNlTeaH+cDO3/DWzc/Uu5SFamVn7/9gYSxWUDTOTzkX9j4u8hMJQYxBoFxvIkDJpZXy/E9Kq5IenvJeF38ts4g44Qg4tON642rROMYIbdx0FII3MlJTLSHaii6m8Tupyi/dyqlbk3g6Pwz612pw1H/kFPV775TemZKs0CbyxuR+yiXiDpuNSBoGENRaWj4T6xGePIL34wP+oGCkQg+xYafe0YPWesO0cwrGFQYjBCuE/Kxas4YBMa0ojPNo/F9P1AnhWnOdL+3y8JbDcFpTZGhJajW6b29/JSHcv2pXwjWVMi/12zGOKRL2rPpNem+/nBuqHSchZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=TXfa0Q/EyCYGM1vKWFYj9PNPbOy72GQcEklWOPsWvqzl4ktpyIr1gooEsqG/Phf1dsZr7vfIo5h5JMwnkIKAMTylflc94G2twguIGGpRfk9LtG32U434TjFSEQLaDhAAEGOd5217WG+hUSlwKSdDquSMN8S6Ufypq3jTGGK4H1w=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 BYAPR12MB2662.namprd12.prod.outlook.com (2603:10b6:a03:61::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 14:39:31 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::63) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:29 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:28 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 10/10] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in
 SRIOV
Date: Mon, 17 May 2021 22:39:10 +0800
Message-ID: <20210517143910.2125-10-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b124b8fd-d224-4a9d-ec26-08d91941950f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2662:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26623A277F9E6AD647B7AB0EF82D9@BYAPR12MB2662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jw/pTdHXNmHC38QZeYvq/hGZgmchjOVh97CrtoXa8R+/SYvQJOmfo/0ISrQyNuWZKLi8mA98QJ/xjG5pRGeMkaK7wwGeYCQrMpE/uu59XsoPmbhSjiJc8O6I6kyrjWrnidZETK79ouee63LdUjsz9Fxe7AqooPxIzA9WAr9ko4IJmEIXB1AlMC1vGRwTrl729CfGeRzNUX8YAb1okq0jKb7G8eSviLJaKS0IpQyY7sXbhaLS76ZqPSbzLtb1/kRj8Ezqx85qfOS96Jegs3aKDsNovmPKL418KWdbqWxKWWleKZNwNu6GIj+A+2LLzT3nu0gjvvznmc3gR5iqstzjgnCJBkmetKBK75V8+tLvIahdGq+QhnnmFf6MoXoUnY+fCNXYtAtTJJcSjuexBPDOlZlY5Zx/Ee5EdTtkg2jJXdPsqtL759YXPdZg6ceipT3Yu5EO7U+HGCMRhZAejeXB9SLsY8kM28m9fjVZSgpSoYWpbHxj9FUbLdzTHDmpEqmv/50kSBfu8kCa2tO/2dIwvx8knaG9dDo0QUpM0OoqETDv3G+FhzP00ksgNpJvalX/kWPEWv14aAIdp3HxpciB/uIyV18apkkKYr5ZNVoxD7dAKan04P7KZnlURRbjp420ynRkKCb20fWnJF8GyzPJejWc9HXdWMX2kwyhA32gk5N82eYNXYczAFj20aRph4V2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(36840700001)(46966006)(82310400003)(6916009)(186003)(36756003)(426003)(1076003)(82740400003)(8676002)(7696005)(70586007)(70206006)(81166007)(47076005)(36860700001)(478600001)(6666004)(26005)(4326008)(2616005)(2906002)(336012)(356005)(5660300002)(8936002)(86362001)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:31.3053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b124b8fd-d224-4a9d-ec26-08d91941950f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD should not program these registers, the value were
defined in the host, so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index e24225b3d42a..422d106a650b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -197,12 +197,12 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev)) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
