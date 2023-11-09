Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B15C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 17:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D9F10E91A;
	Thu,  9 Nov 2023 17:26:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B7E10E0E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 17:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3dAErd/okWfQR+jyltJkQvd1iDPM8tA3lbrgoFm7I5c+YzZSvDiDjwKI3Pem0ToyW4JH4cikZRAyn0nbkngFIELI8cQnGNWzpSNE2Q6D+U4LIvBExn8iSvoRErB1UUIztP+TaFTMerdO2q3/z+xBzGGPW6MCWe1ZUanuh+Hira2L572ho1CL8lgp8YFf/pwSl6bX+yDA7bK8ry++BFdZjoQZnLqFe8aijwnDUhU7QW99KX3jK/cb8AcJxAoPhRVI4Z9aGVnDGQKdtwqoOAr/otRxF6oMTB+CqnNXcB2NguF6wBD7b38KYOMb2L8b1Votq2/xeOztuvpyMcGbrhEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYoj2xSGky9k0beAADawxJxDa66OoEBRw6GupfT6uvA=;
 b=A6ESuw1UI4i7QT6jt5arzNAqdvMnDO/L3ZLep0/ncfYJQsG6H46xfV1ykQIEPjE9su9JsqzCdXWZFeK7StUFr9fGbp6kSMMd/v5cHktvSy56VSEfMBA8KTzMRFloFfiI54Wj/3v5itw2ooyQygE112bF8tNwBbLVF3XncuBrEBKsFFsaQ500qUTyOtF6TFud7dh+wxLxMqmwrkDfFtMowouLi2zmXJq2KGnI5aNoVImD1TKMMiu8robPDz0WCqapsy/jEWQhA32Dyr5JoY2V9xwGveODT3d+0+yC0q6qfMnO8CqZ2mWnKH+r0VuzZ167XyhGgb9LaRxyIoaxvk65ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYoj2xSGky9k0beAADawxJxDa66OoEBRw6GupfT6uvA=;
 b=m5+d0KMq9PqB6Y5tommfhCDbx5kzUt3SV9mZSe5VWDCcSZ40ZjrnhiBNCSUewCRJpVnfBfH3xofm+kt/DpMiKEYAFygjfZZub1dTvf/I7yg+PUsq4Mb3aThRU2WxYxkPq75krX7C1/p7I0wyo/A/gc2pDuXyp381XDtagnKFt6I=
Received: from BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:26:07 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::b1) by BL0PR02CA0014.outlook.office365.com
 (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 17:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 17:26:07 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 11:26:06 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Change extended-scope MTYPE on GC 9.4.3
Date: Thu, 9 Nov 2023 12:25:52 -0500
Message-ID: <20231109172552.2491460-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb8e56c-18f4-4c63-1fef-08dbe148f543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQF+8OV9Vfm3gkkqyTg8a6VNQ0O5xHgv/HTRrj4B/EBPVb/qS0zzf2hR/3D/Db6Hqzkpn5SxK3r7k3OBnXweOFj7/CM/VQRWJHTwEiCkKg7coyMXFIh0zv4LenWOGApN/g/yycxigRjyz0fOzKrMc3HXqQUbPJRWf83aKK/9Kfc+gwqFLYObKKqid/6lzhPnRDedK/sQ8AP7t7iiM7PCY8mowLiaRlQXi1ESIXYwCrbS/0luqZxrWPoUF25RI1e0dD046//jEd0yr3Tn02FKTBqn8a9XGNwQgscYZFI7XV5xNJebsmhPHz9aYvyUhmMLjtPaTD5LzfNC3y5p9uuc5V99vmVG8ChPIHmd+pV1jcBb/YasWPJ6nquv4JcTe6PmJDoChnCltlnergnZBXa/2HL0qjLt5Dcz72HmCUk3/3ZHlhleAVWbO2EyKH9bWK9hlf2VstR8w1edjfVRNFNt/aHvp4rj2emMNkj95D6v2muM3yezlFdrVpgGp1e1m8ncBU0GuNg5MgiebSm9DhjORRE+b6UDGZhQPEQxVIxjWWKjz8euGjMUVAlL53lvgGIQxAMjO/gBEWse44YEhTKgiSPZW5uDff4EbsNKz+5mKboDzCx6TUctQReLBmxOfx2aiWQZVgrzdJqoBdwiRPRF6L+MMnUvkIyWKXJMSkjqJMD00nmHFv16W5H7s+FpDCBWl37BVe9u+YmVcQNwbNLQBprmOe1SArAt0RZ2oRN6MfwA1kLE9B0Nv9zGr/AN59jQAFP4ftZeRr4ewH8iq8knjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(40480700001)(8936002)(16526019)(5660300002)(83380400001)(336012)(26005)(8676002)(316002)(4326008)(54906003)(6916009)(70206006)(1076003)(70586007)(36860700001)(41300700001)(47076005)(6666004)(478600001)(7696005)(2616005)(81166007)(2906002)(426003)(82740400003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:26:07.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8e56c-18f4-4c63-1fef-08dbe148f543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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
Cc: Amber.Lin@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change local memory type to MTYPE_UC on revision id 0

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5464b08064c4..b5633cc2b97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1197,7 +1197,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			mtype = is_local ? MTYPE_CC : MTYPE_UC;
+			if (adev->rev_id)
+				mtype = is_local ? MTYPE_CC : MTYPE_UC;
+			else
+				mtype = MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
@@ -1318,7 +1321,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 
 			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
-		} else {
+		} else if (adev->rev_id) {
 			/* MTYPE_UC case */
 			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e7f67e5226ec..08aa9b85c71a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1257,8 +1257,11 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
-		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-			     (amdgpu_mtype_local == 2 || ext_coherent ?
+		if (ext_coherent)
+			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
+		else
+			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+			     (amdgpu_mtype_local == 2 ?
 			     AMDGPU_VM_MTYPE_CC : (amdgpu_mtype_local == 3 ?
 			     AMDGPU_VM_MTYPE_RW : (node->adev->rev_id ?
 				AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW)));
-- 
2.34.1

