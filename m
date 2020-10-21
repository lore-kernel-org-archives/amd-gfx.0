Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0478AC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 06:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B33223C6
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ny6m1hQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B33223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675476E886;
	Wed, 21 Oct 2020 06:45:06 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690050.outbound.protection.outlook.com [40.107.69.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 061D56E886
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 06:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghiW1fyxjMfZGT8yS5tvKZmycwEY3PiuDLTzM4DoO+SDIwlKEz8x92ZkcEh7NcNvjnxAscVAGb0DG08/Tyluaim3n7MWn9kCmofaeFNMqb0DC4Fkvuj1isJX5I6mGQsVqKLVxdJRg1n6d+/ClNTqGEpCtbQfHmoNNqQmKwEgLKLZVcconsJdoa79T+elKQZIZvfLEt7SvbWR5cSPvxRn5KN6VYjtGjxVz08sho7CF3eyZIMJFBnEhc6lQXrQM+FCm/5zWNYl+OCB+iF8ioYe9ZPbH1oIG+AUXr/Iq/Tu94Vc5tRp0EPwJn8WCyB8q1a72DAhjYEp1v7WxLZfSJ7+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKSMlXHYZdA6So1vhOVlBNG9UoZYl2K3mA3FWraZ77A=;
 b=Dpr+tzz1cJp1cunHWG/i/NLHhfNpZ8ps4HDPLMGVd9YqU5NNwVcRyEkLMkRJrSPCDNbl7+LvxvvjPN8ZB44xuHIyud25pKIXMj2uZInUDJOqiKnia0R5hrhjcc9SZIWmKiqvSBeiFF4HTlAjVP3w/ZUd4ao2Fh1oB3iRFGfb7cO3SvvnxgAa9O8U6Jzx311loa+Va9g5ES2R00/x5UOYfNf0RVdwc2F9q2T6mVo9nVYUovE7UEQMVqeT/3sn0VUm+yxzXgbpz0Vs9laE6WvW4T6fxtVOUWSKJuVxe+YQWevrHqRNjfPiM/vlxau74rsgoamnzFq5xvPxWVAQUxQckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKSMlXHYZdA6So1vhOVlBNG9UoZYl2K3mA3FWraZ77A=;
 b=Ny6m1hQ/VZToZBTTp0QJrr3MC0HieO4ByTfDXWD8zduyBy/ZvjqhNpxTW2rv6ce3MaRY4qOcSdFKr2AYFKWmp9lqgiZ6DunMOHVna1wuk4gNhKverIO6EJ1tal5gGusStdU0RcPY45FwwAbClYepc4eRQtvEmH5GSxosdTct2zE=
Received: from DM5PR19CA0041.namprd19.prod.outlook.com (2603:10b6:3:9a::27) by
 BN6PR12MB1393.namprd12.prod.outlook.com (2603:10b6:404:18::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 21 Oct 2020 06:45:03 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::25) by DM5PR19CA0041.outlook.office365.com
 (2603:10b6:3:9a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 06:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Wed, 21 Oct 2020 06:45:03 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 01:45:01 -0500
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 01:45:00 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Date: Wed, 21 Oct 2020 14:44:55 +0800
Message-ID: <20201021064455.14935-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974a5b50-458f-40b7-0c50-08d8758cd6ba
X-MS-TrafficTypeDiagnostic: BN6PR12MB1393:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1393D227BF95A165E036B3108E1C0@BN6PR12MB1393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfOdhP+uby178uhV172Z7CWfwEe50HbA62HOF6Nv3KyLaytcCc3Q6t19H2kw3FkEhqA67S5+IlnOqUgx8lbFwnmxFeoC2FiKrFGePz1va2AIwtz2a2iYBHeQe272mZlSOynukQXZ4nEG5YzKujqKOwTm+bWTsYdr5Vk7K3oQ0b9tng1FdzsO7J1SDyjDKLBXwu88RPgldrUvcjG35e9xbItPPDshvx0CVaAd7SXOhrnCrEerhgN7t4YeWKHQUc+fM64kL9l07ATi0SDqwRU7NsZi98gBzQs7g5SpvsXmfCMBT1g0r4jXD54Vns/Ca5a/rYrFfy7KmzVSmIzu3ivSYVbOqhpwIjCPaAWy0+ak3pmdFb9EIFg7R18+laIec7quvqH5ut2KpldjGoDaa0MC7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966005)(36756003)(8676002)(186003)(2616005)(426003)(4326008)(6916009)(478600001)(7696005)(26005)(336012)(2906002)(44832011)(8936002)(70586007)(82740400003)(70206006)(82310400003)(316002)(356005)(81166007)(86362001)(1076003)(5660300002)(54906003)(47076004)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 06:45:03.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974a5b50-458f-40b7-0c50-08d8758cd6ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
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
Cc: likun.gao@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the wrong fan speed in fan1_input when the fan control mode is manual.
the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
since the fan speed in the metrics table always reflects the real fan speed,we
can fetch the fan speed for both auto and manual mode.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 496abc31b07e..27b6cade9ade 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
 	if (!speed)
 		return -EINVAL;
 
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		return sienna_cichlid_get_smu_metrics_data(smu,
-							   METRICS_CURR_FANSPEED,
-							   speed);
-	default:
-		return smu_v11_0_get_fan_speed_rpm(smu, speed);
-	}
+	return sienna_cichlid_get_smu_metrics_data(smu,
+						METRICS_CURR_FANSPEED,
+						speed);
 }
 
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
