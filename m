Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C111C74A5B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B506310EF72;
	Fri, 17 Mar 2023 17:18:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C928A10EF62
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiK+M+fjJeWFHfMwtvvdmlRr4HRhe1xgq2yN3WFy8iaNjUzjcB9wmJ2jnkA5UNp4+40mgeKNt746rgOHLmjqCnb5glvSQH2QordfTg9NacKKNA2PFxTW5wk+jAASijd0kXE2NvngkQt+x0iQGkgsqtPGYZ4b65aRIOnoV3OVWtWodolLVw/Ts7411hpCLkdU70dNyZghoFPzfNuSHR8FZxK21QMG5/Bv00EUgDQcarKpjTED+9hjvFbcRE3Z/CAyXEFG4zJqz1zBIDxbzrTBA8eKD3ufDqrgQcWA4nV32djion5VEseTpEP0Y8flZJpO9ko9nynirFftGBD0SDfYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V+P6JF/7mrp+OpCfRuHXGAhoRlMgoHX9KUNheIHKpE=;
 b=UQfx+3ALXlTxD6BT7iN7v2jJ23NVJAquZ5eoNnvcDfZ1ed1YIiuZjHxeh5z4DzlnVMTQuJ5kn9ue9Q9HccXvJdldyVMhl3YY3AoQjnxUovjXv3PkDzXzId7IB81Q5DcZka63DF3zOELPi41j+unVAqZvr+qU1f+lPTlGqKilb1SjCH1qY3DNU2VhlMJPFptNLWJtug6yFGthGWmtxvNwW5Pk+NpOMmvcRxykOeekwq3stzrCZ98jFZRpHemXcUy063pL1ax9pq6NUx+p1KvTYtpueNjyOempX9w/kg07n6LzvYA+lhr/6k+FLgqKCiqm3XT2hH1fFRrg4u1IqCS4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V+P6JF/7mrp+OpCfRuHXGAhoRlMgoHX9KUNheIHKpE=;
 b=aY6eUgEZquabbEQjkEBRlw4gMe4wjLaoc5YEWhr9EiRrIx6FPTfcNVxWiiEqQi1H9z8E6agTT68YGUqMYZ3L1oe4kmUUY7i3IG98zXQjNH6M+4FkKe8PhI6OgRRj/Dh1asObmlM4uBlupP0+bvTNcd7f4G0kV5XSSCgx4/qUxdk=
Received: from DM6PR08CA0008.namprd08.prod.outlook.com (2603:10b6:5:80::21) by
 PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Fri, 17 Mar 2023 17:18:11 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::c7) by DM6PR08CA0008.outlook.office365.com
 (2603:10b6:5:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amdgpu: add support for new GFX shadow size query
Date: Fri, 17 Mar 2023 13:17:47 -0400
Message-ID: <20230317171748.682691-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3a6909-c0e2-43f5-ac0b-08db270b95d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGMtD/Cqs7rfSizy1hBVQTeSaggxMwKVEXFZyHAO+e+7LX56T6nbqX+UYCCSQ5EhlplhQbaiwKEoNfsQTUl7Ru2JAPDv1fsysEAL+nnSeg4/TGd9DNvdp5Hmh9MTmvOpyIZPtQwVzjv2ePiKBOMgJW4hdehejG4twtUrLKPRvpTIh8Kf3Mr/pkmwpJFXoHpLDyWBKiuURaw70Sf0WwDHkpwBE89SL6f6uDinx0+1UtwJ5a2YauaJTmVNi8s+hwrefLv9fFEq2uPpt3evg79oInKdAJ6OetCTs90rRIZAwDDW+FeAHTKMRcJPhORbK78tFLNRMBTSY7d3CxBdC4+/3zFSDnvRgMkjXu/RgmlRGyKQ9X1PEbVInURNRpk0gCw6SgZvx0C3LpT8M2Nidu+Nd7Qr6zIPZcuYH4pw09KiQqOC78i519tn99HutqR0dqsnTwkbFWcYfQmH5WTqrdUxJAWxJai6DPUPF9CWTRMc6c+OtAe0r0vtcN+IhCS4+9//3HsBkr/tX97mICUZ++37PMS8MkroZwUFWAuGt4zg3CoE+5NqVUDt1wC8RedJO264helrvCt1CmDF0ss1qOxQpIXLRXJAHu03K2yrbBC5P44vGAX5ndAlkuICY+F2O36kCLo1O7q42BTIBrikv5t7CWCm0PhfnQ/6eg4h/gy2QsTd7hpf6IqG8l5a+HYoN9dRPKJYgFiFyQfO1P4XdvPiGq6ybyrMrI689YsORpqHXEk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(41300700001)(8676002)(36860700001)(4326008)(6916009)(356005)(40480700001)(86362001)(36756003)(82310400005)(40460700003)(81166007)(82740400003)(2906002)(2616005)(16526019)(83380400001)(186003)(336012)(6666004)(1076003)(478600001)(47076005)(26005)(7696005)(426003)(70586007)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:11.4273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3a6909-c0e2-43f5-ac0b-08db270b95d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the new callback to fetch the data.  Return an error if
not supported.  UMDs should use this query to check whether
shadow buffers are supported and if so what size they
should be.

v2: return an error rather than a zerod structure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9e85eedb57d8..8a6764756dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1139,6 +1139,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		kfree(caps);
 		return r;
 	}
+	case AMDGPU_INFO_CP_GFX_SHADOW_SIZE: {
+		struct amdgpu_gfx_shadow_info shadow_info;
+		struct drm_amdgpu_info_cp_gfx_shadow_size drm_shadow_size;
+		int r;
+
+		memset(&shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			r = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
+			if (r)
+				return r;
+			drm_shadow_size.shadow_size = shadow_info.shadow_size;
+			drm_shadow_size.shadow_alignment = shadow_info.shadow_alignment;
+			drm_shadow_size.csa_size = shadow_info.csa_size;
+			drm_shadow_size.csa_alignment = shadow_info.csa_alignment;
+			drm_shadow_size.gds_size = shadow_info.gds_size;
+			drm_shadow_size.gds_alignment = shadow_info.gds_alignment;
+		} else {
+			return -ENOTSUPP;
+		}
+		r = copy_to_user(out, &drm_shadow_size,
+				 min((size_t)size,
+				     sizeof(struct drm_amdgpu_info_cp_gfx_shadow_size))) ?
+			-EFAULT : 0;
+		return r;
+
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
-- 
2.39.2

