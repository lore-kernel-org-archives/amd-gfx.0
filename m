Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6920DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 05:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3560410E084;
	Tue,  1 Nov 2022 05:16:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5CD10E084
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 05:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO/Smx+UtuGxMC3eMb+8acQMP47aGMgRG9FKnXZVRT2M00rQuvlVFxVOdi0U6eVoCvd6nv46ZvsVePQoMR7rycayDSMaf0OclotTHrqd2n7BmJsi/154rHVhgKC34d74R7jMiD9Z87vgJfUH1ODYe622081A1oP7/66tcRC9aZ5rcOVaFO1B/7kUDA2U+x9TuerCeIfzU6KTwBQDhPUeW6WQOgxkkq0dX7wmXhfURD0J5k55t83mR/rKW1SOZO5az4A4XJVXzg5Ick+gBadEpUsYRW+5V5rT0c/MVFgN0fE67CWE8E7R7xXzIWXHxjU16goqFj4HUOGpIxYFWe8iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFvg5WXK/QFCWsMVhYIsOux4hUabn5EFnH6fbqZamJY=;
 b=BEiF5BjWcmCtB4BRedrpa2y/s4reaHW3JW4TzxjcwviS0+6JqFsbpbi5QInjT0D2jUIeC9Mxl1hUgfL0+qBQDGQDpjZ6RRfH5GlmxE+OBmV0xogKemHaQ2Q/MZgphT39sW0StKk+4/vK5M6883XTQrK0MZIgiKQ4Wc1shwczUpmNrBL6EoqEnbEBgiH9VSTtbr21Xt78xawzJafwUGaRZuNt85fZO9SnJaFMqKGCyQKW+EnrCXKsW2ddKbUgIATRC4Vl3bC71c6SBDh4KkiAkcXOVWHV4GUZ1+/k/bvEAq2YgGYyPE3qILTrNKUz0KtmZCsCCUxuoQ2PZBvgg6FDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFvg5WXK/QFCWsMVhYIsOux4hUabn5EFnH6fbqZamJY=;
 b=Mybqw/xbmbiSr9T2GYZj7RqSE2zG9BaHUC4dUAmFIkVRZk3qKjZDzghu/wBVNa+JkRpOBATfUwUV0SoMhABHnBvnOWLqL3kNaNG/+HucNjNDDIqoz45fZ+6i0vLQUQ8GjHuZV3UZ4QB3yWJzPFcBp1OetPUT4j7fbrjFQlCE6+o=
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 1 Nov
 2022 05:16:07 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::6a) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.19 via Frontend
 Transport; Tue, 1 Nov 2022 05:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 05:16:07 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 00:16:01 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
Date: Tue, 1 Nov 2022 13:14:50 +0800
Message-ID: <20221101051450.1261693-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101051450.1261693-1-Perry.Yuan@amd.com>
References: <20221101051450.1261693-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 303776b6-d2ac-47cf-4195-08dabbc82e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0ARpyuXOR7ye0vtI2gBMsXesy7cjoj3V3fT01r95Z1AIn/9Wx8J/aPnuTDR9OlUJqatXlBLgFVjJhS0InYc422eYiYDdjDXneDwQXri5jlqy/pxq2UmHDwBLfONo4741Lh+xJggtZ7YmF4tQ+jhNprm1GPGtstiL38Kh1T/xGyrWM3Dy7v1yaIMvri1X2KeVQvOkkSCxTVJwiAUwStLMSwH1GZ5Z/fIl3l/bGApDzWFfIOonkWExGSiRPTRVrJLnwpnL1B8b6IDaJihZbdCrWvg1eGd6+O7EaDpWlvl4MTEQd/tE+QIfLuxS1sxZUnGmh+yvNWC3htr8fduacSPw3dlXHLWDEGz4Z38ZV/JibYgJTN5WQvRTw7IuXT3KpzC3umJYc3YZHkfbS7lldYNjzRzApQQpMTcDUEAbW67n3cjd07wXOCmKkW3qfk5Jg0T6BtHEcIlGkTnbS2jh1W/fkXZCCvMsyx6DpcMBGENFUApAjnCap6f4QMNmdSuQ7hrN/exPHLQIlf2VhS7ozeQVdWdXCPD1RrLJ5pG557WGEEPud/AWf03dwNR8Qgl9BsnoC6i5BIZwS+XtUsKGrjp3RvbN4x14mm7ns/WPQX0x4+NYUI88qv2z36AWPOBL+EerwzmWBcSxfRK/9CxUVWDX4yUqGXCjgyfogia8li60MTApHKt63f3GvP0BwvN7kKgGuYboz9TXLrQ+ABXZVdILhLJqxotV737fFjl3HxfEyhbcLJzFNp1YIwyygxTOpemn1YBSYSVUPOB7Iu5Q/+b4OWZfffhhjuwQnF7WMyG8BcK5h+5xUcUnlQ3PQz8+wOv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(81166007)(82740400003)(356005)(36860700001)(316002)(83380400001)(6916009)(54906003)(70586007)(6666004)(8676002)(82310400005)(26005)(36756003)(7696005)(70206006)(2616005)(41300700001)(8936002)(4744005)(40460700003)(1076003)(5660300002)(4326008)(186003)(426003)(2906002)(40480700001)(86362001)(336012)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:16:07.0979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303776b6-d2ac-47cf-4195-08dabbc82e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com, Shimmer.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the missing apu flag for Vangogh when using IP discovery code path
to initialize IPs

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3993e6134914..52a92add12ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2161,6 +2161,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 3, 1):
 		adev->family = AMDGPU_FAMILY_VGH;
+		adev->apu_flags |= AMD_APU_IS_VANGOGH;
 		break;
 	case IP_VERSION(10, 3, 3):
 		adev->family = AMDGPU_FAMILY_YC;
-- 
2.34.1

