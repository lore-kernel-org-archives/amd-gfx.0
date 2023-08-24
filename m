Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D73C7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3388D10E5D2;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AD310E5C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGduklUNbJftn4ObRhBOtjGrQ/DeulB+bLSSsqIb1ILNhSYxasmKLWvggHkzmH6XJ+3+YLCe79Z7Mm3RoCQLOj1huZOcYwcpTnNwHJvd3eUKSOp751yBJ19K860PhqfLkAXL6gD6cTbzZKSkxo+VRC/CyWa8UAvoaaatuYvz8LJ9SJ+zDOMVT9RA879j5iJolcqXiCNXQLa95kCSa0OW9bpjV1kOJ2B+Q/6Ey85QfKp55TOY4GOroivAIZvnr+LfXYA9Lep/VHhlEIT7CLbap3kvT0CPqIT9XPWMMTKz853L6Lm97P/uaVVmDxj2CVKYF637gjnSLPpD62W07w5qjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CElXdY0ecHa1gWFlRJFiTIaUAFz29dZXY+rpUBPBVos=;
 b=aexqkee4hyc6m4fSWTt1nxb6orw2GfXiLB2R5AfJGrXPpi0+G0DrbETfYQ/q0eYJgQLjp+ZKwxMbhc7d272cvdmR/efLEACjGBLiopzLnpiNYDUuRjkTMUqMw0BQ393uj0dI2QxbGbD4QlHeEVxENA3VHSVWAJ2sxsD/FxelShQRCkiLaCftUTUZ9lVjZ3rlDynuLRRW+cWD+ISCSzzzAXPzzLvOu/sA7u3nWHzwWnq7f0q34T5VoqYMfYiBBrraUnplLFvvj7R95yzSwxywSRnmR0ZelqZ45IT9WSDSm/LzvdDbFcxVacVoylHQnTzMJ0yeRqBedile55DUb0rzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CElXdY0ecHa1gWFlRJFiTIaUAFz29dZXY+rpUBPBVos=;
 b=TmdzDS2ap+cYWzjfzNhvfjxsG7IbFUqmP+DOEYTNR7xMLOkDheS138rfaPoW/qKRWb9x0E87ckwJNIGLxFKmOPbVwvZbe/YsiA0FLnHQKBMs4gAZ4oo/8IGXHp1e9NxIVSPsvI+a/EXO/EGzrgdYjOsQsL7+eP1PYqbZN9YVioI=
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:53 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f5) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amdgpu: add UCODE ID for VPE
Date: Thu, 24 Aug 2023 17:31:19 -0400
Message-ID: <20230824213127.2725850-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc33570-f978-4103-1f89-08dba4e98877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNYhZJPGzbXAbKiFvDF0CiMCKlzRCJ0NoBY7W6ByEQH8Sav3Um6ihY6V+rTlhEzac5S37maHdmArzgXgzVx+cZ+UTlJrb+QT6VmYeVDkhoyFqavUgUZ+9K7hGLg3aPbqPfKXahpE4qHZm5hXcUHEvR0TEGx7jRO+Rb1zyg0rpMa9vFYCWH5Z0zflKSQ5RddrmO036wOL51Ss6HBH0KkLLqh8E1vJXESb+r1q5haquuBtUenUh9XUz7wW7q8lpNc1FwDAD0JDgRKrYLaPnaqUFB83CvcO3tWxmQCXT4JMbA7Iz9c0+5CgHPvqtDFIK31cNE1EgWaEg1JqmLcgUHkUVfSAG0U+nprLI7JMsmUaGRT+zvJOX2ACU91rR1Z3hLCPA6/D6KYvZCr3XebuZqJr3MpZe2Gp4IP5zCe6FmuSLZnE8hG85cC9RvobgvkDepBnbC08b3uincbpY6Xw+Vv0Kuv03ukY92hsSY2QQE3XUt5ZOcTMde63sP/53x8RxsalZSUkhiwBWJloarijHlaCS+wEuOvGjwduBaWNRZzg7LF47lQRDacT7mvn9oqbga8GQd/ee64Pr9EEyJ3OZGqCtvkCZnHDdXNBEajuE5g5UZaaXRNNgNf3RjXpmIieO2sIC06QkySrfDiFftRMN4QVIEB1gAhHUr8u8wPqUgY0A/2MutVxbLm86CZJm5hDGOT/3G5SjA1njASJcs8E8eclqPZsKmCdOkUrZtcaH20Lg6R2k3Sx5h8E4vHdoP4BgT/Q4tB7i30MqvDASzi+HUld2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(2616005)(1076003)(47076005)(36860700001)(4744005)(41300700001)(70586007)(54906003)(2906002)(6916009)(316002)(5660300002)(4326008)(70206006)(8936002)(8676002)(478600001)(6666004)(7696005)(40480700001)(86362001)(81166007)(356005)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:52.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc33570-f978-4103-1f89-08dba4e98877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add UCODE ID for Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 81a8ddbd6b2f..0b601efa2944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -487,6 +487,8 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_VCN0_RAM,
 	AMDGPU_UCODE_ID_VCN1_RAM,
 	AMDGPU_UCODE_ID_DMCUB,
+	AMDGPU_UCODE_ID_VPE_CTX,
+	AMDGPU_UCODE_ID_VPE_CTL,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
-- 
2.41.0

