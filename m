Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10B6C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 19:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7972E10F255;
	Wed,  8 Jul 2026 19:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KLe3MH+J";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4025A10F255
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 19:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6nCDt8+REgcCrSiIFQo4YS8Zl4ongAbnEjcPDkbivcvDb9/RGhGpz2fr8jKIXiwLt8dfoKJofPldMgKLRnjbsb4j6ZuBfOLTzkweiy0ugQ21WlBZO6zIiE+giIFJtd1YQFYCaEaIsc4X7fBwmDr8H3ayxp+rTDgsnQ/5IZyuL6y5y5i2suwttectynRVn58PeDOx/RoBEfih+27en0FEcLRjVPH/DIBsfXjuhFhuZNbf3s89g+kMMLmiDBtI0/IazXZhNRirk0rpoiuo9Gkj11pyfIQ2Urg9AcrKv7PqEZnf8VVAkUfMoIwHD3IxQLr2s7qo7oOwhvBCRehhtGgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFp65RFDb1lb3GXpz57LMea9KwydmwzLpEyH8BXjW00=;
 b=fLfWzLysksKnzbyP1h33iP0oYglIAo+V7a+hRACt3MXihLmD4O9Ya7LQ9/cuz54/vgghP5tZzhqK9xdJNql+HzXoaiej88r2AfvqTzL4Nvx8pgVM1yrOSyAmW6jRuHyFrIto1vDEKfL8WZ3qA+Ers4tyMsYT6T/5xBixh30HMPZP2xs5UZoDEw6DbgjNUuAlawk8gaKUOOXUZpWMPk6OcR3RQLuA4FnYHH8A3ZqlAvuf02cuF2cpRSqaYaasZNLX6uPeMUtAnfEDQdwJTEDFNReW+zild5Bie8iGTzF+LNMt73sqS82QZpTWIKNI/1Hrzp+Lx4NalytI1jXxVe0lpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFp65RFDb1lb3GXpz57LMea9KwydmwzLpEyH8BXjW00=;
 b=KLe3MH+JdJoxhQ0SuNufg4Q6PemU6dhbgFABdhV2AMjrw7rdN7rJKvxShqklG+Vt+f7FFz8zjuQYazjvNWd5qnlq2Zkb1pfZ+tJiHj3wJlKWiNbU7I3j1ul5B8GXYlGTr8Th397n34zXL7kf4724ODH2kJWA7f8lqyulycWF1zg=
Received: from BN9PR03CA0918.namprd03.prod.outlook.com (2603:10b6:408:107::23)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 19:35:33 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::7d) by BN9PR03CA0918.outlook.office365.com
 (2603:10b6:408:107::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:35:33 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:35:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Oz Tiram
 <oz@shift-computing.de>
Subject: [PATCH 2/5] drm/amdgpu: Release VFCT ACPI table reference
Date: Wed, 8 Jul 2026 14:35:15 -0500
Message-ID: <20260708193518.702584-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708193518.702584-1-mario.limonciello@amd.com>
References: <20260708193518.702584-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: a3654e69-939c-497a-475a-08dedd2813b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: drO6gm0+f+n87DSvW6ljwPnZwcrbFpfEkoHZudkajn/rC1ap79Lk3GhYsJdaimYVkMaRZkTtVQnO9sPNUvhBB4oYv/MDeDjR61YCgi5w14UR98ACYoxSCBVJL6ILN6j0vdBKdYewc1CVMtaK/42tpeN+6yTgTnMJXUFC/ERkU6NSepOXXs+KQ7pXkMKzCRMTZkrvlt5v7S9msAHN3e7hE0B7edzw4Nzzv0HKqud7q0MjK6tEUTvT5Ps9KMS817dhhq7y8l+7C+4cL0aI6oKPfwMX6Fk9WlQY7jMS9lDopJqQXJsM6BLDat9OBfORGSJ9ftEcxS9kaTKWSuhtAirBz/bnLaH6Q6sbZSdMfufNLQ5GqaMBFOfqpSqyMDo31CzDqHGvvRgRD4XAdbDPG+ypNNE+NjMUOSckONxqj+Rvs+Cp1pibWfIARJKcHfgTTu31nJdv1zh1/Zs2NSZWOVHXQ3bTmHVFfEpbTmy+tMBaWhuBSrGYQgHus3DkvTlCibZCJWdxEfDPpFjv3oJv2uxpzER76uTpGck1H8NYARC87bWdMfzKBHRC9KLRSa03sQKytvumNMV+pRyJZFh+Ku1iDeauXbrZvuLlt2Jz+gXWcNfAa3UBM52qRAUkHJcRhU9cN8J9Vf+jXSJR3ycCKN5xKBr0NObFcezCclsLMjKRms2SUbVerBLQ7PyIzWaNZlSsWMJHA0py9Q4rownRGA7iag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ttvmUrzx5Z32Uj5UQeYY1kbGT+oZcZNQ2vwtnceheDmodu4qFQWOuwZT0gMaSkarhffmD8FHcsRWpMuNF/d66ZK2qar1Z64IldpLCA2dVQNzSoPcquqbyZgyH0Ck97DKcbXE7FmaYehP6YHa1Gf6QS+mq6Yc1d/oObL8SHpp8u2RCy6K40sJcSFo2c3J2+UZo6b3Jw/eJKsaV1Qhn39Ofn7CpBpzdt/GXBywPdII+T8uAMHh+ddHWtwjhvt1GqKBZtFGIbSJmYyjL+10G+kEFjS25MHhjxsk31GWbLDJ6cQPdH/8HiA1ByFdkoAQFIzB/4q5ke2uNM59lxykAFTQy2JGtDQK3NaBZNCh52kH4VaHrCbybDwmt/HSpaSu9yKnbTQ0GZbSzWCBvz6xwZdQ6R2SV0VPNmNraFd9ZdDJLYm6NhugVmXE61YfMpnXugLw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:35:33.1709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3654e69-939c-497a-475a-08dedd2813b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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

amdgpu_acpi_vfct_bios() fetches the VFCT table with acpi_get_table()
but never releases it. acpi_get_table() takes a reference on the
table (incrementing its validation_count and mapping it on the 0->1
transition); without a paired acpi_put_table() the mapping is leaked
on every call, whether or not a matching VBIOS image is found.

Route all exit paths after the table is acquired through a common
acpi_put_table(). The VBIOS image is copied out with kmemdup() before
the table is released, so it remains valid for the caller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Oz Tiram <oz@shift-computing.de>
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index d8fd047295d9d..bf6df87e0bafd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -423,13 +423,14 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 	acpi_size tbl_size;
 	UEFI_ACPI_VFCT *vfct;
 	unsigned int offset;
+	bool r = false;
 
 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
 	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
 		dev_info(adev->dev, "ACPI VFCT table present but broken (too short #1),skipping\n");
-		return false;
+		goto out;
 	}
 
 	vfct = (UEFI_ACPI_VFCT *)hdr;
@@ -442,13 +443,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		offset += sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
 			dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
-			return false;
+			goto out;
 		}
 
 		offset += vhdr->ImageLength;
 		if (offset > tbl_size) {
 			dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
-			return false;
+			goto out;
 		}
 
 		if (vhdr->ImageLength &&
@@ -459,15 +460,19 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 
 			if (!check_atom_bios(adev, vhdr->ImageLength)) {
 				amdgpu_bios_release(adev);
-				return false;
+				goto out;
 			}
 			adev->bios_size = vhdr->ImageLength;
-			return true;
+			r = true;
+			goto out;
 		}
 	}
 
 	dev_info(adev->dev, "ACPI VFCT table present but broken (too short #2),skipping\n");
-	return false;
+
+out:
+	acpi_put_table(hdr);
+	return r;
 }
 #else
 static inline bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
-- 
2.43.0

