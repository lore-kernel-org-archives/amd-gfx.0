Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273ABC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 10:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAE110F2E9;
	Thu, 13 Jan 2022 10:32:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF8D10F2E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 10:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6w6pW0E1S7q5G4JXkPGVQeTa30hKY+OjdbGrjWP1qNHeIRvvjtw0oxdIXRFzkTqP86b8cg8S8V/WUKlEHsY+rFOGgvrdrhHsxiMtQIWdXue39Z+fx64yQj75R6Y3dF6lt7NdtwqlwA/X+/aPhjrN+YrmtYOBQkZNbuVgDxhe1H9yxUdnAj88V3qCvqt7+4En2Jle6rfGXAPsrSg2M9yh550K/p4m3fY9Uwf2MdWURrmbMIJyzemmxOK4OzciOyQioR6vaBQ8WmXirWxYCjDNJQ0Nmd0g7uxuxIHW0dlk0E99vZHCNMor+DhN9tAJB8dOBXD7AGR2dbVCWgTg/vifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSn6yrgLZ2srJhUKN3LwuUMtXnQ1sqDjspy4JwDM854=;
 b=PmA1dQJBqE9nYx+TpVVWakTnb73p8vP1tP5vPiyNzVvXSHEPOAiTud050ieU/lkeoA/wsMeGlftgkskrBMjMmf8o9zGeJlogQfZQY70P7polkNo8eCpvT0ZXdS/4OSSqbU6yBAcDIEKLUmxE3XTjCWqjeiH23ug9XPDsZfzgnav1oV6Tj1Fyk6NWvsOrN4pM7rIgNPoPUqrdqE36jqfjGojcuuZBmfM+WKolQbtKyrfNTmuz49T9R8b+draB7DZaEIhy/mQ4VV/i/y7+R4C+qjQXxet2VoFPW4bJd+DqOywWYEmhiSSRJqL82oIQW7bYG1TqlEJxy99Rem66KYC0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSn6yrgLZ2srJhUKN3LwuUMtXnQ1sqDjspy4JwDM854=;
 b=TZcpZrQOpVUGdDQ1YeCdcPLGEtOGNQ8MshpLKXvnaEHjtb7KXl5lwn6rb4T49M0e/Tdwfgwq/f88HMF/SVLfd1ujVyJfDcf1YZf5/Ju+Z80MAY/KRhIjKUDsouOEABslpgbYHz7If5eOUjjbSv+lIN5koOUDVGxPWu3UYpbFMEE=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 10:32:01 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::f2) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 10:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 10:32:01 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 04:31:58 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] drm/amdgpu: To eliminate the warning of no previous
 prototype for 'amdgpu_ras_block_match_default'
Date: Thu, 13 Jan 2022 18:31:32 +0800
Message-ID: <20220113103132.3910820-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113103132.3910820-1-YiPeng.Chai@amd.com>
References: <20220113103132.3910820-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24cdb222-c570-45e6-9a0d-08d9d67fef7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5513E7DC6751FAC6E59199BDFC539@CH2PR12MB5513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UtZYODaSxz7E7/mJ0aeEraLTplWwICObFLR2pO8l+oLNu333oO6kaIA/mhAGbvZMiYd558MIXGfQ85ZoPxDFAc4OhSMua4HIe/Qj0lZrfh+LwB3TlfqugWI5swrk9VGqdX+zLptBgL3sDsslfRVX/nbTuvTbCuXqfg9D3K+hQHfaaEkxrgVsGXD3+Igq3FCroQc1XHBcMb1C+waR2gYviq+7kS139kSUsyZnGbvOQtdJoyDYQj5vcORYOPkzOdXrgwOw3Ktr0SBlhXf0YpVxOXsadxXv4YLqDIiOmGHUFUP85gAWJDR4iLFFBZsXxEDwbdNQMvWiwUkmc7eMqVTQMIB31CW/CZRrI3fGDdSbW4VmK9CZJtc+KdetkbJjEZYLBagpdJRLzADsX1b5CKrnpZgZ1f6Fs0iK9DKGZsJUHmyvJuKm8bDfUb5Sj4x904CJkc37LY0qzwf8Q1liOzycgX51haAVpu7EcKTFXZA/WDll867ZiI7ew6h/yqQp+/IUvbaY4f6GHIhobcXJ+hMUJtkrA8RWYifW5aaDyem7JCTRUF2GS0W6arOAU7k2GxiUoQcv7G9L/YbUtn01dpSdkUq6VIpEGQ62m5fBkPAYcMvmRQDo5fY9K9vhKj00jfi+c0ot8/4Vlqjp3AZHXqKFYU6Wi3jPRYaWGhlEFWKBuTDjxq/qS0DkEdxrCZJiS65Izdp4v1ytRCCyE2xqHR66AkHcrKInuHI0oR5tpJs/mC4Nrpw36aUc7QwATR2hqbo8AF3Mcjd5UqPx1uBUKr88wzlvamR0wnob/NyTzoFqoqUWNFP1sKqITLL1bvYku3BHXwVueSqUK0BSiq3PGIa+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(7696005)(16526019)(54906003)(70206006)(316002)(70586007)(8676002)(8936002)(26005)(186003)(356005)(6916009)(86362001)(47076005)(6666004)(508600001)(81166007)(36860700001)(4326008)(83380400001)(5660300002)(36756003)(2616005)(426003)(40460700001)(1076003)(2906002)(336012)(82310400004)(4744005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:32:01.5784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cdb222-c570-45e6-9a0d-08d9d67fef7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To eliminate the warning of no previous prototype
for 'amdgpu_ras_block_match_default'.

Fix compile warnings.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 394a18e3c6af..7afeec4255bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -869,7 +869,8 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 }
 /* feature ctl end */
 
-int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block)
+static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_obj,
+		enum amdgpu_ras_block block)
 {
 	if(!block_obj)
 		return -EINVAL;
-- 
2.25.1

