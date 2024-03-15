Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A59C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 05:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AAB10F307;
	Fri, 15 Mar 2024 05:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5VmdV1Cf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F333210F307
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 05:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL8Jld8PNj5pIrBba0qxfpDvUSFbD/S7cN51I9viVbxw6KNt8aKRsXSQUjpABoH5O0RP418MgBqpg3Aa9iqEDpgQMLZL9Lg8sPnzul1PBfDr88gmzOfAHd8dczjpRkqfytQQEqAp56UfoylpODx0IS1aV2H36XLXptQE4c8EztTAxZWwroWoBtlCO17k9ykdScjWkvO3uh0HBgdtHAvVJA51e+0Bi4DeHTg8Q+AdHgXTVLwTmxrfvJfLNI0g2iowCpcNNC+NsZDkVCYghHv7mcqVUdpGm7fseqGp8MVk4WlDgzd3IVMyJZVswQ56FDTYPVoIeoXxXv0dWGzN4Vd0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuBd/2WeBfVUoUNKuK8tcH0Y/iwrc00w/Y3wJTaIBXE=;
 b=Tyb351MF21APKX4NiY7roCU9WyoPGuZQIoWbwX1GJGTJrKZEGd7yJAf08/rak8PsClUkAd5/rrbnSMrx+wba7JRifUoa5v+ZdfwAHSgXzMw7xrsk58SFaoc510ZgpnFhksufuyynTpE3Y/mPOV8FJTuiNsBDJkYn48sZ8XmhQCpMtdg1KreJ0I4QUir1hQ75/QbPuUIzse7dsxHpMBpG59cbz6ln/akbnhsUUHPrn+oPTaaRcWmlBN1CBEj2vCMgFmdOUDIGphVk7fvRSFY8eih51X9BPI8tRA6GHOikmXkUcxuiCc92w47oDqUNDaY9MFP3fatOM2uiAgcCj3Q7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuBd/2WeBfVUoUNKuK8tcH0Y/iwrc00w/Y3wJTaIBXE=;
 b=5VmdV1CfJfzqGyEL6pXlgxq2jiBVH62cWlm1UvzBov3G7PW62EDisODbnZ/7ZqqigWYO3ykRvW1j2VzhsZiS/8mirpsVix3pAVmvquya0ZMwHOXXeRX3iSA64sWrnogIxUTjwj+vvLx2e+KqGLvG6V4pXWd+Tzt4T0LMTP8CK84=
Received: from BY3PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:39a::24)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 05:17:47 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::10) by BY3PR03CA0019.outlook.office365.com
 (2603:10b6:a03:39a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 05:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 05:17:46 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 00:17:44 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <srinivasan.shanmugam@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the iounmap error of rmmio
Date: Fri, 15 Mar 2024 13:17:25 +0800
Message-ID: <20240315051725.2450734-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 5109fdf4-2ef8-4be7-8e79-08dc44af407a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9et/d6D+OwCPDw2m+B6sUKntlUhEg3XePTHugkSnXRPfLtZixiWQQUCRFDfeEn5hOBNDYT/m5G1n+8DLTpt9lALvhOk3xR4lY1DiJX5uHmRe41ojFQxWOmx/6xydISHYsUjlra3BcXLgcC7KZaGiqY+MzwUgwczsRW4oL42r9nllo3VItYVj4FO2JV+KWRDGEyTXXYoQRWb/cwVAlwybGyj1Q/gji81700aRYe/orWa34/jkadkb0lseXVrcfvHdo8rktq17qRHgNfkz0lTUwDsYmOsEqcSUGbe3wqRB8/rr0GX3aizg4yGpNiTbTCumgswOOSqf6b0gbEVTG4+tZy4gMi/dHXX/jxQVMHBGjLEWabdgUXzeDabhovGrFr3Rz4TxCFCEyZE8MJvUFw/WzmS46i6ZUoi5aiVTU4V2o5bCbz657xyehhW4XRJo+lGV//Qfn/XH4ejKGQGVo4v9RFI7KipojFC6TWb/JtrsZhFJ2ASPXhBgSnbfsZKG3O8mOCxPXWZVOrS97rX6EiOnuqxtpt9Dp4DJ/q/jsS3yOa24dRXnY8ekE8AZVKOdqu+vMJwS9UC51QPDiTamF94nZ339djMaeXqcVjOZqXDx/+bolLC89lKj11gYVRDP3MomgMMKCsW+4Xe2lUSB3ndGIqooCGcsOSGZErMMU53BDRnHX7tWLRgoI8dVs52vWm2dS3McR4WHVwjASrsmTP4k1IT01ShrlwAjrc0wq0v6yjTKXGdUZl3wwrGms8pCE7S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 05:17:46.9788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5109fdf4-2ef8-4be7-8e79-08dc44af407a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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

Setting the rmmio pointer to NULL to fix the following
iounmap error and calltrace.
iounmap: bad address 00000000d0b3631f

Fixes: 923f7a82d2e1 ("drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()")
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 39dd76e57154..d65a6aabefbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4383,6 +4383,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 unmap_memory:
 	iounmap(adev->rmmio);
+	adev->rmmio = NULL;
 	return r;
 }
 
@@ -4514,9 +4515,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 #endif
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (adev->rmmio) {
+			iounmap(adev->rmmio);
+			adev->rmmio = NULL;
+		}
 
-		iounmap(adev->rmmio);
-		adev->rmmio = NULL;
 		amdgpu_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
-- 
2.34.1

