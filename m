Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABBAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029B2610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 029B2610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4FF6E115;
	Fri, 29 Oct 2021 15:09:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFAC6E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1S3Kn3Q/WTyf2v6WRQuhL1zYPPCGrqEyUYhma3Hqc4ampvl/qNEjWyomV8iW+35FwW4zFbNg2fGrouym8COxweC7/Pk1Ij7DZIpRsi7JkJNGa8G92QFwELBVFTk8FIN9EBaf1AZPUlMqNavrqZdIXK1aiafiu8Zb4/LXi06ARcxkbXsHNpIv3RrVReTjpGKz5NKRoWh/M0W0ziwYq+V7bL9Hh1GWSnG5d/f0Slunmg2jq3P1ZSVjMYyTDGeBSfrsu5DsXajIoGWfiOq27ANSy4gdp7n7IVYrwlFWSqsM3tNakkLJi0weZ89Li/6RzMwL8Ntgokm8N9E1WVi08vaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDpXWR3/cdCfn2Y6QcKUp7zxfSMcWkANRdrVezhuE8Y=;
 b=W7aBFSDiGeYssP2ahV7nFQBV23G6x1rLqvqdfsAPFH+8iB0L6abh3sISMzLc2+UBmf4IqTGCVckC7GT3pi3tA3Ezofpy6v/0j3o7r3AhA2wdwt+jmMZB/ZRJSwGRgU0A/1qin4FWZunolz9BZ0+9L73OEsT+GBYH2V52m+pRp52L+fzchTPOtlW5N7AKBt+3Tk5JE13+v+it4Qg+lmedFULK8kd6xKRx6GFrQEWlKR3owbLnGSONuGDokJBjxzUAPcWYbqoNY8g4di5sySOasCGuttHXpZMHjAcFkY41x+OIBh5mGmJJROIdkRm399IRW/VhxTDt5ETQigh0nqKJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDpXWR3/cdCfn2Y6QcKUp7zxfSMcWkANRdrVezhuE8Y=;
 b=lMhM1mYThmKXXO+NMth5XwZ6ZgbmqBcc4lnIwxkbr6Z1qsblWL7w0Sr1U6VbT48NE0Nx6dIuMiHrdh8J+WmY7ofb8fdnJARFNOwSQUs1VXENAtMVGlwR5w+24f0PxipuSyK09jbjQx9sAmKZWYuNWgG79dt+AN6cFRTow0WXD2M=
Received: from MWHPR21CA0042.namprd21.prod.outlook.com (2603:10b6:300:129::28)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:09:31 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::1f) by MWHPR21CA0042.outlook.office365.com
 (2603:10b6:300:129::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend
 Transport; Fri, 29 Oct 2021 15:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:09:30 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:09:28 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
Date: Fri, 29 Oct 2021 17:09:17 +0200
Message-ID: <20211029150917.4462-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9778d8e-660c-48c3-d7d2-08d99aee1bed
X-MS-TrafficTypeDiagnostic: DM6PR12MB4912:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49125980DE7DC0103E6663328B879@DM6PR12MB4912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM2yt6gmqTeUiit+cb0OldG6txZAnSOiAybSXgKMsmaQxSZJa4zP1nhnuUZqjvn2YNQtD54EeX+2hTau9jP7FTVfWPK3bRXQUVXhc4thRYkCEtTs5uco5CZzviP5/fg6WY1xkOW0kduN6iggs9gbtFBejH6mM2dIUC54SJzbAflwdojGDtH3oMDYs5CYnnelfxj1pMknhLRG//R8y6LFTWicpLTBddAvcRKvRFVweUvvLYGg26g1r+G5RV5ktJmA2VWMGUokFliontoOreL2J1IjhEgPIBddEGOfbqQnGySoLu0eV/ax7UArClLYQc902f0plNr7E6Ca6WAYVf4++8IOmNbu4pBj2Mhzbs6Ua5/DymyuzjyVAIw06zPbcUmjMaChfZhlkhX/1U/Qe1yCQLJ0UtpkuZKffh4oAKhHrJ+Fsv8tRS6I8yOKTmjRLm81vs8r0oZm0f9v0fuemm1ReUsvnhcBHpPXvjxA8mdxA/m+3RNWQ9I8+yca2WBrDD6bNTq9Iob6bzMCSB4YlRyTh5dXvK6F0DiB+GDyxdIm1fRV3SCd3eZfrmsg9rYekKLLduDXGOeOHUhywaGwnEibp1nzErqXkQgIuJvIFOeHeB8tsadDaNfH4VvSjZeG/XVGJymft7yWTw/S7AHC8m7HuL6bRQhOQLeUAxTjorJzPIEFvN4hb7BlwnxBw1oZ1ZTS33rbTWzi1xz+IUnG3ikoRgRIap3d6vF9033vdZPqWZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(82310400003)(81166007)(8936002)(186003)(16526019)(83380400001)(70206006)(8676002)(6916009)(508600001)(426003)(26005)(356005)(336012)(70586007)(44832011)(47076005)(54906003)(86362001)(2616005)(316002)(7696005)(2906002)(1076003)(6666004)(4326008)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:09:30.9322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9778d8e-660c-48c3-d7d2-08d99aee1bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We set WC memtype for aper_base but don't check return value
of arch_io_reserve_memtype_wc(). Be more defensive and return
early on error.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 073ba2af0b9c..6b25982a9077 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		/* reserve PAT memory space to WC for VRAM */
-		arch_io_reserve_memtype_wc(adev->gmc.aper_base,
+		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
 				adev->gmc.aper_size);
 
+		if (r) {
+			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
+			return r;
+		}
+
 		/* Add an MTRR for the VRAM */
 		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
 				adev->gmc.aper_size);
-- 
2.33.1

