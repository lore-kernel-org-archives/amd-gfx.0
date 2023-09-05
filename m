Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E507C83F3E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 14:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D8610E52F;
	Tue,  5 Sep 2023 14:25:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598F910E52F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 14:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjtvgdbi7q9IPsAnUd3b5LJA8zQe98bo0fRNdbdl6HPWqshnxPNa5uyDuD6WXMMJ+8w6n9FhvUkEoZAc9kmsERLorgLzCHqI1WwGFEDR/T55YiyyqM/YDIjlFNc6dXUNEvj/WJd5SSdt9ZMq+ziyz0Liw5BgKDS1t40YIK6nzQx3vyhfc+McbOWDAkj74gyol5KeC1PIul0s8XW+p4oVpko4A46pW/v9iinB/WRsrSxNeKjdul4H2ePaOTmFU3mICDUyuXDuHMCNocJaAzqqhg48IPzURxIyduqU8VR/6VYIK4wEICmni64tqVKks7f2ja9CjtkAUT9Qb8Ma53C8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7nltB5bIoIDecdpkl6pHeWuRrOdTf1lys0tpq+2i2U=;
 b=N6dPU7dBEatb4qb3pieGwMN6aCeTa6Eeeevp9p58eTLfCCxP3vr3rhcpFwtE+gFR8Kz5wlIVMV+7lUr3IqJrnnfIS6+zCOqDAPH7rgsnU2PmOGfOH+38ws9KmlILkqOHi8Gn17BTsD4sXqF09Olq744CWV3YA0K380zEpg8L4CLFJOkTdyMUh4fuJNGmjvpgioEMpKyceFhWHYhv3KKvwnXSE5YCN5ITrFbfSCdCd+NlvGnsU3aS2Wai6o5O5ptmRSRW/jS/T1Gy/KLZqKlTMWoIvkwu+ow58m2ZvgOCd89ok6i33s6nmaVD9G54UoGJ6iRSA283+BVH1Upmz6RhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7nltB5bIoIDecdpkl6pHeWuRrOdTf1lys0tpq+2i2U=;
 b=VOimA0AOKxeuswAensujCN/SjBO8FqTKBkL2PQrUAuGPZgO8yMFT9vkLH0RRYhYZwQDqtofNQ4AmqsadGa9ZkVPMI9Ti1jESg46FvYDvfqAkJy5rKyyDbAhKeMz44qffyrBS/9+VZAFQ5css7uCQ00nDgJZrmEbTUfejd7/Mk/g=
Received: from CH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:32::17)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 14:25:12 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::a7) by CH0PR07CA0012.outlook.office365.com
 (2603:10b6:610:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 14:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 14:25:11 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 09:25:05 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Handle null atom context in VBIOS info ioctl
Date: Tue, 5 Sep 2023 10:24:32 -0400
Message-ID: <20230905142432.99760-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b90393-1f30-4768-76c2-08dbae1bea26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+aISwo7r7RD9HYf7/9LUNdoaiqf96aounE0LpARthA3YWoomprq27aWL4Uc7lPilbXb763JsGhSWL3h7ZleQoqCbzI5ygCVWIJzBVMzaiOb3HiqXVzlOY04uizVfUgPmW/mL0daHcp/wfl9C/Dg0tTTMfILGsunDORuZXoaF6of188jU6sak+Ykh1Iipn+6ECXfOGtjB/WelnKZJGvVRHIP6Nr8X+mHszw9sb/pNwaKy/WJm1MQrgnMhiN/bDi9+jUqGLKZ3tG7+lOjWJY57/cVFQRXW0ESBA9UkuZYDOhcyug/61o6uoGitZOqvleT9Cb4XYtLSS+OF0dbzAQ3PPeTa5MRwUBCMd7WsV+mT44CMTmOYNVSNZK21OcdH3GzkgA39XGv9lTaqzauh3SnQdYde/Lvg6YfWctBVWxK5Bx7Lj2YLWqK0d0uwFxmai2dwOX5UyB6Ht6g3AgVVrZgapmUzHDHCJ0Z1+MCovzUwbxWhQhj9p1gKdowFeRi1rneLpPyTfeY2PCsqGVaH7hg6YhvsMSwjHJFh3wS04gEBskhqJx8q0Wkc+hwUGGcnfIaHaWrG+RI5MXSmafCMDMuguiM/GlsBBFMsEeBRwFQi5mmMR+3tJD0aF0b0ZfNb6GBbJGfa13cQOUSe9B2+WnPYz0//p6TrnOQGqcnIjDnzL00Yq2sdLut+iEYjsg0UFYxIlwdEhsTpRGvutcy41VQ1fzzUuU5ORHqOIjP/Ca8Vh4oF+Dzdr3wNEUGYBnnR68O8GGHoKlm7cwJMd9+jh/+YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(2616005)(1076003)(8936002)(316002)(6916009)(8676002)(70206006)(4326008)(70586007)(40480700001)(82740400003)(356005)(81166007)(7696005)(41300700001)(426003)(336012)(16526019)(26005)(5660300002)(83380400001)(478600001)(6666004)(2906002)(40460700003)(36860700001)(47076005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 14:25:11.7546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b90393-1f30-4768-76c2-08dbae1bea26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some APU systems, there is no atom context and so the
atom_context struct is null.

Add a check to the VBIOS_INFO branch of amdgpu_info_ioctl
to handle this case, returning all zeroes.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a48bec10aea..86748290ead7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -947,16 +947,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					? -EFAULT : 0;
 		}
 		case AMDGPU_INFO_VBIOS_INFO: {
-			struct drm_amdgpu_info_vbios vbios_info = {};
+			struct drm_amdgpu_info_vbios vbios_info = {0};
 			struct atom_context *atom_context;
 
 			atom_context = adev->mode_info.atom_context;
-			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
-			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
-			vbios_info.version = atom_context->version;
-			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
-						sizeof(atom_context->vbios_ver_str));
-			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
+			if (atom_context) {
+				memcpy(vbios_info.name, atom_context->name,
+				       sizeof(atom_context->name));
+				memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,
+				       sizeof(atom_context->vbios_pn));
+				vbios_info.version = atom_context->version;
+				memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+				       sizeof(atom_context->vbios_ver_str));
+				memcpy(vbios_info.date, atom_context->date,
+				       sizeof(atom_context->date));
+			}
 
 			return copy_to_user(out, &vbios_info,
 						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
-- 
2.34.1

