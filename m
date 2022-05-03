Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEB1C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1905110EA44;
	Tue,  3 May 2022 20:09:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2810210EA30
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d53R7hPLaDgiqh3tYPliQFJGimccP4fpZWr8X1aiXnQ7dxq33gYX0G02e81qxWPsNuufDkoxX/o+EoI2XSZaUj8a9YsZWdQmExtdD4VxvnbGQarZgYpa1tGm0HNqAB6g3/WcHmb31KVe9/kJ0rbl/30LwiNyA14HDaL5I1NGqgifqBJIAR0Jy4dkOB0kiU2fQ0vN5waJuDXAgmSkDgcKPJV62g1kjw1SPFH8vMOmVlAyAYHkbl8zgUDAcYOjmExv8wQCb1rG0tSso/T4S9I+4mK2XzrPEB4bZbCpqIelULpeN4F0vLw6FgFmF5ncYktdnC/XOoLJEiPSTxr/GJEZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfQx5MOD/ix2NPHMdxU3XqOq2GS+cIcIUkCFyuPEjFQ=;
 b=cG3wk98zQCztsiCM8MTLt1ofphLqlTIgccXa4UB1W23+Ae0MV4+H9+sKHpDbC0IU+DzdSMkEBQUMdLQm1UwflHKttoIzgzuVOA6aH9+xNb0RQmotk7hBikptHj5/wvPcWqdWYuQNweHmfiBeRjP6I2GoAwFc2BC/q8H3zV3aPP0D8rWjp+eqzYHBi2WUoAuprF0qYf6PhJzoducdP0vM3zKoTeOIhcSZVLynSopWH4BqdenJF5MK9dm7Qx3dku7/OWOG2EvLoB1qRcr9vnvTwzBJnpxXkle+5GwY6OFg8qUgCBHGdUavaMh3JUySKBycfRjqsASX/dUGwVmmdPxP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfQx5MOD/ix2NPHMdxU3XqOq2GS+cIcIUkCFyuPEjFQ=;
 b=ZkqmX/niXB3eZa9Z3m/OWIFHxbH1FSjpE8aDd0CmlbfWoJb1VgXCF3e0vR4vZxxQAlZTTxX48pUfv+nRHL4H+gEnL5cx4ftFvITmytYqMozXOsQhPTK6rerzT8wgy/yqs09gUQFoQFc6LAJ2/A7nJZbPSU1C3MdoeCh7ojF2sDM=
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 CH2PR12MB4807.namprd12.prod.outlook.com (2603:10b6:610:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:09:20 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::43) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add soc21 support for GC 11.0.2
Date: Tue, 3 May 2022 16:08:49 -0400
Message-ID: <20220503200855.1163186-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8fa727e-651f-4538-e1e8-08da2d40cee4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4807:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB480710F6D741AD7D2F1915BDF7C09@CH2PR12MB4807.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FenwC1CHzA+kioMZV9pPsde6baIz0Tkg78CHVHCtPwOOYtV4XdcPMb1Gal/FQFE4muOGwKKOcUr2s+T64LLXNneHVlZYYp0o/dVKxRaaORuOBY1L3IlO1sh0aym6FsTaTB8cuu8FCy60Zi850oZbQ6iS37cEiQjSUSs8tvgUiCJ2lsVY41hL4gpq5IU2vc3N3RhIHo2m7cEL/Drdu7m0tVV5bmLR4RyA+ZAe07LqCuPsAFZ57dn7Ou8f4nR98tRFtZWqH1VGwBabYlH+2S2yTPoYexBqzaegtlRksb5JDKKotcmYDRPV1gRL8stVK2FiGMkIll3+nyan2ySv/7L0T93wp9ZentvHBPfUjfZUxqORVD2pNDcqEH/xsKXDPBwUzbUFCCsAZx+dZekbPqCfPAvAQm/HjSUYtQD/lHrFaNCb1ZnWIgAcuS7Yy+bq2Xp/HvTTfit6kyi6Y3zufA5W5AZ+vSWPyB5vbdgXQrktJuHvgHScaKoitIsT1ksArma+XRROmd0eXMRoysSmmlARlLepYASvQY8ZoqLdJEwtrcM++1ZABk3eBPPLQDphD3t0YBHwZuNJNRgPjZUlEXSnCKm5l4/Bt5rbwtwIJdZarzHRzij6Q+wnED8LG9eRLXYIxCWTbxD98Mmdz78xuWslF2WX7AfrZxpy1YdCmEuqOPSIsinU36f58cyMEKzbjrJyeONn/Mit653f6FAX8Slvuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(6916009)(54906003)(82310400005)(26005)(508600001)(6666004)(316002)(2906002)(83380400001)(86362001)(356005)(7696005)(1076003)(36756003)(70586007)(70206006)(2616005)(16526019)(8676002)(186003)(47076005)(426003)(336012)(4326008)(8936002)(36860700001)(40460700003)(5660300002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:19.7516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fa727e-651f-4538-e1e8-08da2d40cee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable soc21 common soc support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0e0382a82b22..c8ce9588665d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1479,6 +1479,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	default:
-- 
2.35.1

