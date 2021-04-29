Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4389EC43462
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D301461447
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D301461447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A6D6EC8D;
	Thu, 29 Apr 2021 06:26:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B006EC8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSFvfkEpwZgCEhb7YNLD0r60tQr/kY9Vdwy8I/0WHNj4ZuByBJE1PBG+ivLqycj3XS9hW9DVHIAO7WMKn9UoqELd4EAo3cvxS8fyzeHlL/71HHjwxyVbCmcyonqoG+hn5n+x8kvGPm4v49wnRke5uzektxbFcs4XIoRbCPklm5TK2rk4vihGWsYDQRwsLit8QgAJwXjWT3Xkm5MSrB3T3RVNl88s7T1rKjmWv6ILonhmw39g/V7rtmMIm8Xb5R3UdStsT/M24TGDagunSDAhTnV2af9iqJGQo7/L/q4IzWgk51obbcZM0QddPsm4+7KUm5GOeKDq7mt+4HtZc+16dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb4T8usSuqmn52n4RctC0k2sslHhG8bZ6q2NY67EQ/M=;
 b=dBRCGPaG0cI41r9NczoKiTMSFxRxJRWJxxZhC1FscvXyTkxBgvyWElNlq/C2YiYa+zpP2ccakzRj0JMUswWCDZLEYAgAy0KFUup0ddbaTRi2p2zBDkaa9lXvjMnHA5TWDZcwA7ioXj+o73N8mHBnf3HuRGzed3X5/eviZ8/SkB8R3FQx1AoTyofEKLKdmQienl7JZrRVlJcH8C+s9HEvENc7Nqbect2gpu6Z0T1t8vfJlw3Gmp/VKSs6AvbDOZmK3PQnJ54mJz/zOnzRMBUJWdPOXNcKf0L/nUX25weWU2J76S+uF+e1z9XMS+UKbM8h9iQkmwhlP1F/ILKdXqo/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb4T8usSuqmn52n4RctC0k2sslHhG8bZ6q2NY67EQ/M=;
 b=iPBBE4FvNhh/NcBtayXlbEQyJt7NyExhN7/x0k9Ci5betln4/PJfJXMYM6HYr0EXY8ZP68wASZh6kZ9+8juMOY8GrBDD2+p/MFvDhhK6GADAj79HcpGBU/fcO8MnZDJ0c24LZlhZflJp7qZiG91lYv9+n3h56hJQHeiZG6rCsR8=
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by MWHPR12MB1181.namprd12.prod.outlook.com (2603:10b6:300:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 06:26:11 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::f8) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.31 via Frontend
 Transport; Thu, 29 Apr 2021 06:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 06:26:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:26:10 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:26:09 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: retired reset_ras_error_count from hdp
 callbacks
Date: Thu, 29 Apr 2021 14:25:46 +0800
Message-ID: <1619677546-2630-7-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2677fd8e-21cf-487f-cbeb-08d90ad7ae78
X-MS-TrafficTypeDiagnostic: MWHPR12MB1181:
X-Microsoft-Antispam-PRVS: <MWHPR12MB118119DEDF75B409724BEA14FC5F9@MWHPR12MB1181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:416;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRstd64EjJWqC3baAgXUHBIbgm1fHOje0b6chbCGMVPV76TVgHnA8VGEk5jkv71ONIc1RGZNtIyD/4qsBgfrfvO23fCNosAAovJHIDGTFjxMesozaBZyTuQgWSeBOOpD+iO9Q/nu7oltTaxX+0x2/NZqVzA04FSq4DJOraD+KVO+yiwoINoD7BV1ae+mCF+5bT8V2ntmnt1+x4mZGhD7Qge3FlUiS9nTqK6cUb/sC1ZuE8KErFYQXlxSPfrraBU/4CicvI83jSGKV+hsaUp9d9fKom5GKyred7DODYu7qyjgvyYrNDoaWpC1v9Y6Lztdybz7702GQGXlFiBqJ3UWpNUY9sDiagf9JGal92ZGDdaZ1EGDVPyZ9YOlMBuUqbGKhN6I9LxqlGgEiKyFod2y00Otw5GocP9VfGFeF3iZOjOtLqbo5NsjCHLmQuudZQNKtphjLh2jJphIaU8EhyuFIF698BR6sDhypXnhjGsnYh2TYDYTQxUmx07HTm5qohvQgM4XOKCat3OUcRmCaOco8pSmpnC4fV4xTWWnnuvw3PJLsAH9cwq6Llq9fIy2baFaUQnPqHUEFmZZrABre6MHLrdeaQtmZBOxft7K1p3HcDuB2LHlagMbtex4LQ3H4OTGQpMLSnsRhPUvNE7xbKXslFqZ2Qt40C9l3V27HeoU5F01W7M8ghgdSUSTRhiCdtBC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(316002)(336012)(5660300002)(47076005)(70206006)(7696005)(26005)(70586007)(8936002)(86362001)(82310400003)(6666004)(82740400003)(356005)(478600001)(110136005)(36756003)(8676002)(426003)(186003)(36860700001)(2616005)(2906002)(83380400001)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:26:11.0594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2677fd8e-21cf-487f-cbeb-08d90ad7ae78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1181
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It was moved to hdp ras callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index ba6f272..7ec99d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -35,7 +35,6 @@ struct amdgpu_hdp_funcs {
 	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*update_clock_gating)(struct amdgpu_device *adev, bool enable);
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
 	void (*init_registers)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 330c0f0..74b90cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -159,7 +159,6 @@ const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
 	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
-	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
 	.init_registers = hdp_v4_0_init_registers,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
