Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB915610CF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB915610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADE76E8CC;
	Tue,  9 Nov 2021 23:05:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D318F6E88B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 23:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyzJMq1yETn7E8mvgvBmgF7rndFaL2tuXLn6q/JZtYdR3rS4epTacEZGnSXgFSIKXutt5XtrpENh5wdu/itYrVJNI/usD/WiY/rn3cvLXqgysdJP8lXistdBCLBM1KS2DZ3Y4E3QoscKW15Ythlz97LpBt631dd2yGcdbeNC3YQhK6vXcgidZsjdWy/KzwyMKWtWbu0MWe75PWySkuZjxA1HigrkVEOgN7xCVshwNW4zUttdiPOu+pSZQX6lPkcQgAg/IhO39X8yh2biBWBQ9dyVzwdTgNQ1UR0DLcDdLgXvfD5hwMRLcdB6+GJkufgmpJxOkRd+dpuaZ1rSJfXoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hOstC9Y8Dy6KaOEJ0NZZInw6K24u62rDeel8AXnLoo=;
 b=cYl3NqTRjtSvHq2Os9Til3+4PbHtQKmx5jZeprvINzrb44kBo1ZgHeFcFqCy/bh5a/NPEzdDfKYXqFkQGMRVhOKZmaM8srWITfbhMxaxWvP+aAhIZWfQdN5evKaRoT4xnaJK5Pz26NfY4p+BjO4tv1zZvcbLi+Tj6ROIyC2YIh7VmBTkjQqHgYGBXb02A9ikD72nMHjBjKE1IJGkO6+JKTRGQh/gbQ+SizuyEZyl9uqassMZ/Xt35M6Hg1ImoXK1W96D76jje/oyHXyVUuawC6NBzC0bL/VKGUc1w0CI7YPrrj41wEn7g9sTADUDY9R+Urw2wXuABATtzCEMtzmqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hOstC9Y8Dy6KaOEJ0NZZInw6K24u62rDeel8AXnLoo=;
 b=2n/DY3EL9+bqgheH3BFBZIyB35g3II8TEUu8n1fufx/OZoK4Fb39xkTPqdzuqhUtUQASkZVkKAx3WbKJ6UOMERv4GwUmqcEmmq7UX2rkXbrHUpmdJEyOjew5kcn62KvBOUWEEX/HWs6lu1DvNrJ2wmqKZ3qw2LYmKfkzvc4Hkd0=
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by SN6PR12MB2813.namprd12.prod.outlook.com (2603:10b6:805:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 23:04:53 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::5b) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 23:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 23:04:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 17:04:51 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
Date: Tue, 9 Nov 2021 18:04:28 -0500
Message-ID: <20211109230432.3947-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6966cee9-17c9-4d22-3a47-08d9a3d556e8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2813:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2813BF426185411439EDA01CE6929@SN6PR12MB2813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJnXA0tA2f4I31aUgN6+bdoAoxaNoRE3D+kdYswuEP8IKzA6lC/teu4qE2EQiDL9GgB9v6iyLnG6TPI11VUmfT0zrW4nCAch5LQx2iecwnSqC4eSfSRa/pssrP9hh1/9eJEphWq0T+tiim7ON4NhK+mQ/BL5BRAEm30MeFxf1a3ZoXRvizAk8h27tnN1jvJI1n2v7BSKK0LdROBd8Kuya+pINo14ujdBjnbXfFeGMI8lzZ5W7FIXkr0vVzHqF6LasijDhD9iuJ7A0TN8BkoKgW1bfNe6N2EwIWKMiIK6kUcxwBYdi0ZS+0ZNSg5Cw6Ezdyz6hfZ23ceOQLtDmHjZbqEt3NVvG4KYw77zz7YYnPzji1T8KLP4HiOK0ctzhxp52UfLwef48imV7bEzeXr1GczfeOclS8o2uBGOyodezPpvKmZ5n+PcKFPIDR2FqEqom4MmHkzcft1ab98bwAX+J0C7Dm5NXIt0F/+bFsvtW2VAoHWhDT2wcPQqgoD2dJIIAvSG13CpxaaKZ9ZErgj1i+AyzWfDeGIgaIbQauQZyfbgZQkIwPyIeasciJ4JUMk1QBz+7ns123W1XzoyiENEReCRHXxJzbXCdsRrBnXGe0blEKWzM8oU4h28VzhNLP1bBBSvZ2npM3mMQ3z25AoSm5UtmPyRpB47lpKThkY028hpa2kCOvhFwt+Sqitcw/a+97xWwJPVjS1CjFtlq+IrTWSbGLu9llzVRHFZK7SXUt8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(26005)(316002)(70206006)(36756003)(5660300002)(1076003)(83380400001)(70586007)(54906003)(4326008)(186003)(81166007)(82310400003)(86362001)(336012)(16526019)(36860700001)(2906002)(7696005)(6916009)(426003)(508600001)(356005)(2616005)(6666004)(47076005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 23:04:53.0187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6966cee9-17c9-4d22-3a47-08d9a3d556e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IH ring1 is used to process GPU retry fault, overflow is enabled to
drain retry fault before unmapping the range, wptr may pass rptr,
amdgpu_ih_process should check rptr equals to the latest wptr to exit,
otherwise it will continue to recover outdatad retry fault after drain
retry fault is done, and generate false GPU vm fault because range is
unmapped from cpu.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index f3d62e196901..d1ef61811169 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -223,7 +223,7 @@ int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
  */
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 {
-	unsigned int count = AMDGPU_IH_MAX_NUM_IVS;
+	unsigned int count;
 	u32 wptr;
 
 	if (!ih->enabled || adev->shutdown)
@@ -232,6 +232,8 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 	wptr = amdgpu_ih_get_wptr(adev, ih);
 
 restart_ih:
+	count = AMDGPU_IH_MAX_NUM_IVS;
+
 	DRM_DEBUG("%s: rptr %d, wptr %d\n", __func__, ih->rptr, wptr);
 
 	/* Order reading of wptr vs. reading of IH ring data */
@@ -240,6 +242,9 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 	while (ih->rptr != wptr && --count) {
 		amdgpu_irq_dispatch(adev, ih);
 		ih->rptr &= ih->ptr_mask;
+
+		if (ih == &adev->irq.ih1)
+			wptr = amdgpu_ih_get_wptr(adev, ih);
 	}
 
 	amdgpu_ih_set_rptr(adev, ih);
-- 
2.17.1

