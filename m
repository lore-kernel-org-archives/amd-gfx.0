Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF87FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 09:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690C314B0D4;
	Tue, 19 Jul 2022 09:33:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A28A14B0BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 09:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKk4pm0xF7NZE4kpMRGbYIEMphXjJd/yoajKQmXO07cprdVNexrKHzyXCpuY3/gG1uKGp7PR8XgCEDYaolH5bR561zaa54IdWaKu/0OIjIJRFkve4pFFMbdVgQkU4z3z2PrbnGcCT3mO04zIx47tHEfWCECv/i5oep2+xHTsK31ENlL7cFkXAVKxZu01X+bsprqONjxqVTzteDiOEbFqzPuOp294qmikOC2SupMveEBUeSK/ly1TYVh+91iXM28zd4Nmx3gfRFsZoSKfAw13jHMVsah8RN4KcCGSbX+hPeEFsKhzaqiMihCbRurEuKF6s8cOgaG8ln5xWT76W2+6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebCqI7VZChRt9UjoyfWyzMGDiiLqlEpkxbhhPpLZVg8=;
 b=Tw+0i9UnsJXWZ7GVBbRDt2n4azkD8eYVf7X9TQ5KUcMiIWPOb3O1lLoX5J8y6aSK8hseLbltYwXSVr4D8JrG+shxqHTMu1saLpKhXJAz4tsvfkfsC/ggHgjGkNbyOKL+JlefwIaR/vH1bnD7ipTj91S61Msfi7RglMKXcSegwcghfWxYuhW31Y28eG2ne3BlWhpdR1cDnz7Cg5KTnSKtAOCU8jM1BJ8tB0cWY3etbARPCyb1fEv5+ui2NOe4YOh6QPuO3J71jcEmlYAm+nGJ3AlUAcLAI2yLp6azbu6ASs1HLkXmp7SPiDNRG98GTFu6/JCXxfUKB76Ee6UVTOJkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebCqI7VZChRt9UjoyfWyzMGDiiLqlEpkxbhhPpLZVg8=;
 b=UAMWSMhPB+Fo3VgC16C/1EY4/Sdph5w7/elzrQ1rDEdFv0wg1ZkgP6IFmm7TSqOmPwZ1mvi9x+qwuqoBmM0ChV7hwfSjrBchPvGnWUaJQvYqbcXamNPdZh+J0b0BkamHKcE9Z5jqSNvRrRmtHG3Lbnjqa9bKaKdERuFkqBiVX5s=
Received: from DM5PR06CA0081.namprd06.prod.outlook.com (2603:10b6:3:4::19) by
 DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Tue, 19 Jul 2022 09:33:32 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::7b) by DM5PR06CA0081.outlook.office365.com
 (2603:10b6:3:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Tue, 19 Jul 2022 09:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 09:33:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 04:33:29 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/pm: revise the driver reloading fix for SMU
 13.0.0 and 13.0.7
Date: Tue, 19 Jul 2022 17:32:44 +0800
Message-ID: <20220719093244.27827-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220719093244.27827-1-evan.quan@amd.com>
References: <20220719093244.27827-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347f59ac-a31f-4ad9-ec3d-08da6969bebd
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gdjrvqM4u8bmRU6NVDXyF/0306wLMTf5bTpm9jYDI6LRdbO/BsbSMX1Rfuh3M/lgN44JOZi4nP9V/b48I/vJTJWYEnU8msg/lS/DxILdb/dp6iBfaxN990HbpRHB3HIi955QtUnA7FDKUS9TB190rCLu3ifkK7XZl+8FXBOOrghbaPThyFwI62BAkx4WAEg7vkymSd+zFAwZkQV07hfJNYj92FM3SHiauQ0dJ9M3OiTeFG3dQ/4qAoXwhjhWXI3TsWAUCIlwATocgSQdURcAEQth03EP9T8y2TKXSrV/O1jpyvqK20W0Z/Sg8S/YxGUBi/WvsfAMJmSXzwwit292IJGju8GsyqpHo2NpPWmsaq+1KnFYfHQMYA+ccsKW+m8xwXl1/4K9aTLXVgQYvcLqCObKHtOw7raC48IyRhO8rE6TSWfers9ee0FzrIHPRzPoy9DIGTgYr9+h3xe0gfuDV3JjSd4+lcKZGUzvIglYRS5rAza7eAARLh1XpBNNZeHXc0SMRTpv0ryup1QFx/l9bvKuUlWxKUu+3P53JlhjSbylxxEg0ZQD2ROB35wNNe9uhGCdP6d4afQkgOaK5KtyRn0xUI5uZdk8leRcFgtEFBidwLi9Hmch+JK6XrF2rA4GYAP6scAZOJ3nYwiFKfZRZ5XH78oXXXrOcTHsU/1yQZHsGzEZulnQyhGzwGJ/mBE2A9aoh1cLlGpZckpnW6ze+IrCpjuYnOtMa+w3Eox9R+6GBDo3pczgtBFUYy06ByPaP23zsTAeeuWg81Z63WaiBlChEzSBx0lRtuda0jgoGALwwwg10nQ2w2CKck9ki4nUyBiezf1m8D7CZmtOJ/qjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(83380400001)(478600001)(186003)(2906002)(41300700001)(44832011)(26005)(6666004)(336012)(86362001)(7696005)(1076003)(47076005)(40460700003)(8936002)(5660300002)(2616005)(16526019)(426003)(82740400003)(19627235002)(6916009)(316002)(82310400005)(54906003)(81166007)(36860700001)(356005)(36756003)(70206006)(8676002)(70586007)(4326008)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:33:31.8009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347f59ac-a31f-4ad9-ec3d-08da6969bebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current approach breaks S3/S4 as asic reset is needed for them.
And putting SMU out of service(via SMU_MSG_PrepareMp1ForUnload) will make
that(asic reset) failed. Considering with current designs, there is
actually also asic reset involved on driver reloading. That can make
asic back to a clean state. So, the SMU_MSG_PrepareMp1ForUnload operation
will be not so necessary. Thus we will just drop the SMU_MSG_PrepareMp1ForUnload
operation. We may revise the whole driver reloading sequences when there
is a better design.

Fixes: 826126d8f805 ("drm/amd/pm: fix driver reload SMC firmware fail issue for smu13")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I4e93f08f930ebeb1ed134307e62b4c53a9885066
--
v1->v2:
  - limit the impacts to legacy ASICs(Hawking)
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fd79b213fab4..6d9b3c6af164 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1415,13 +1415,6 @@ static int smu_disable_dpms(struct smu_context *smu)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
-		if (!(adev->in_runpm || amdgpu_in_reset(adev))) {
-			ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
-			if (ret) {
-				dev_err(adev->dev, "Fail set mp1 state to UNLOAD!\n");
-				return ret;
-			}
-		}
 		return 0;
 	default:
 		break;
-- 
2.29.0

