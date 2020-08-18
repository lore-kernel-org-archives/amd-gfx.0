Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B54C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 03:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F39206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 03:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MbAhvBD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F39206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAF389B42;
	Tue, 18 Aug 2020 03:01:05 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8573A89B3C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 03:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax5OSLWzbaQ9MhV8KnCxpSOvAxCJCzYL8D+BEhFShf2NE1IV1MTLzenVm3FZGpt/ORnNkmhJyVWXTgpPK6hfYhAF6jl5Iz9BvvUNqJu0ORJT5x0rZD63rbbtfoqTqHNDKri0ymWRDSN2FdiPe8rFlWTa1s8BjDNRE18TfGX4/gBuIfylUKVOmVC8WvdhSbsS/HmzWt87asqUQRM05ZL5/NY21MP2STA2SrOHvtqtvmV6CVaUJYm1ToPAO1HU1D0qw9GgEIoiQtNqPNFZ0sfofqMxJnJYa/V0xHOxwdJ84X71doVcz7ZOy/0WMV+EJ3YdCLxCBM6An9tytQoHjZ36qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoyAqHev9Sc3RoGgCxq6ghpomyAdgwhUC27ZhAKHIzw=;
 b=FAg9l5FfKSDkpu+bTkcAexFD7ibHYxSBdQW91r5Quovmj+zT0mmhrdRYMQYeZz4xl6G7jDFFleumS6iTShw/s6ppTY2dvEhh/7F6fWQDRRSPQHYjaHAQQ8f528Bg6o6AWCIND0gfdgl1wYvJr94cFiH1WrBvqteJzJaCda5oPvffM1I8N0x2KLHD3J1VNEQmMfA9bnMX0gdiEZFRnzjv2OSERMZgakTfcJ52kr1ymAw8GUCCuezbSZRRbAt0sgaQuojUuyQ5F5l/ktW7Oe1HhZ7aMWHfeCpLEjD4afGYqwIkHYp7E9/90fpkRl+sf50nHER0oddlhYqdJiPANmFmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=permerror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoyAqHev9Sc3RoGgCxq6ghpomyAdgwhUC27ZhAKHIzw=;
 b=MbAhvBD165HyL1HuCZ/56vcaM+oSoSLuX0QZKF7cLDYwUjIU/lEh5vi0fMa/EY4NeJm5k2JCrTuC1go9FX3etJWC2DOhUenXbm5vL/q7TK1XIRcLsUR9rMQnS9b/wyYlbf2/1DP6QrnxwsA4T/bnFRHgu8QwSQkDJwI14CSUcrk=
Received: from DM5PR21CA0053.namprd21.prod.outlook.com (2603:10b6:3:129::15)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 03:01:02 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::7f) by DM5PR21CA0053.outlook.office365.com
 (2603:10b6:3:129::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.1 via Frontend
 Transport; Tue, 18 Aug 2020 03:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=permerror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 03:01:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 22:01:00 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 22:00:59 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 17 Aug 2020 22:00:58 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Date: Tue, 18 Aug 2020 11:00:41 +0800
Message-ID: <20200818030041.3790-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc67cb9d-1f3b-46cb-f512-08d84322f03b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257FECF68AD6A86B9CB0BD1EA5C0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRVBqOwH6mpr9AfK74wTNXJ+6lj1hKWdPrxafvzqSBUmamfsEg9t10NDVxqp5myTSPsZMyGBQu182DK9MmvmjMMM2ky7/AqU7REr5Cp4IYJLytAF4QDI/Pd6CTiFSP5GFPUzH0izYJmFqoptYNK2gBFo9lFG+1eEOvDO7W8ENVNdIUua7ohlfjhXu9E0Idq/PfNZ7BSeLypomPhOnC2NxuwCRo2ZmVbpQXwoeKCBAB2BkeKGefeYCMjROhPPqoOqddqvg1/ARZubWi68z6xTlsPe84+DNGMIkEEPllikSsgeek+Lb76WqvdTBK1L5Xd0R7acW4yU1ufhPnKH57/dYPOzSq37MKntCaKD0Znb1IyhLA5ChrW8GB/L56pdOSUPgvF7hPtXXgEV9EYVDXADsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966005)(7696005)(2906002)(82310400002)(356005)(83380400001)(36756003)(81166007)(47076004)(82740400003)(8676002)(8936002)(186003)(26005)(336012)(86362001)(4744005)(6916009)(5660300002)(70586007)(54906003)(2616005)(316002)(63350400001)(6666004)(478600001)(426003)(4326008)(70206006)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 03:01:01.0495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc67cb9d-1f3b-46cb-f512-08d84322f03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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
Cc: tao.zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's in accordance with pmfw 65.7.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Iaac4c591f92c9a00891a29757d142c0109dcd676
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 65363d56e3cc..77d0996f4ec2 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
