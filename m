Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C254C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 20:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3221810E873;
	Tue, 11 Oct 2022 20:56:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C6410E4E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 20:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G72fET/7tF2WXiLfhRKSVHVksfgCcfSHPsmzW5peKjUKLJJKou3uVY56iba3dDH2D8nLQRnPr3iuKDM0y5GXF7jiDxiM+dy076wFjI6tN4vbKt3hGOamOAGski1pSjUljfnS5hvWniyC3sTQgpX5NKXZgYgymCIYU82kXWdxitpV7OHaCC5dDVK1dgaBMNnjYdFCd71Bn9ReUsIEbxcfrU/gkMQw7SoFChEFxMrGeEPq3C2lOL8M2Ly7nKconkr0DWgKVcsqQsZyY9nD92ntYdd098To5KS+vQVVSjMWqs5inZFHS5hWgk+Mb80TDMpkLn2KcW8GrjBkle6OFkzLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPoU4QPwMqE1SrfOhcCfqGOP7lu7Rd5YJTLZJHUIKz4=;
 b=DPR8IQJjW9Vaki+xpsD3B8YyNUQC6MIcsOBGJcvm0+TVScc0aq+tIO91ZA8rTvtXnoXyeEgCTjWaL5u4/1bIBaTjAQ8TUJHIc0X14GFQHE2RS5sT9t2KZiaboXXVNH0HBWF8X2max138cpVpiHseJiGhKteBmwd6mOHAh7uS06h40+AVLKbpHenAQPPUnP/8RSVO6iRyejaiC+n53yv1NG1dKKqVhaLWOm9HeYqepn0Sk7vFgroSewq2FAMJD4U8fp3hMrgFUde5fcnAQAn1jDciACQq21LHa6Fbb3dPi+i9UvHUH6FIyB8VBDUSHreVk3KBNY1oHwLeRemlJVYLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPoU4QPwMqE1SrfOhcCfqGOP7lu7Rd5YJTLZJHUIKz4=;
 b=ULhlVyRMd9GrF0NvX4XUoFdQABAf2WoqcL8E4l+k4ey50RYeZf7hwGx892vbKkUtLVSviI+3uQTXVpimwLjkFnLFCG8kM71d/ytwBIBdVPgJk4Y4ufF7Z4Dk2igN8Qp9buQMHrMRWBPTpBoPSGYTW50ZgjqzagkrW7bQor+tCXk=
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 11 Oct
 2022 20:56:26 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::4b) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 20:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 20:56:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 15:56:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: update psp_fw_type enum in amdgpu_ucode header
Date: Tue, 11 Oct 2022 16:56:04 -0400
Message-ID: <20221011205606.2540082-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011205606.2540082-1-alexander.deucher@amd.com>
References: <20221011205606.2540082-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: b59db402-c6fd-482f-8bb2-08daabcb0fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX0LnGcD7sV7uaVP+yWC2xCMaJ+DnlmcJ18K93vJTIOS4ALcNk0cg8KQFANHEqdXaSQm+RtOCIAKf84rtpNphNZ0AUN8AYk5p9nOlGzFeiAyXT+H8x2bUWxtWMMy9FAL7bEIq6c0ntA9QDVfsqsvYTM/UdgVWD6kCs0ZXoQyDHZbm0TUaAL1MGaHfa7T9tCNOdQoGmvpw0dFeiJCKDt5GtizRWAJqITlWPmG4JA5CxSnWppHz0E4j0M2wxw4xZ2MXmruAEH+q+wa/ah3v4tmtYLCN2bQGZykP/IXo7zqw/YhuL12G9eoBPm6haO9Yi13bxe9PgHvq6OMse5D3U0BTliWbWoYr5ORTOm4NpY1+vjxguyUbxK9BsN7UEUwGuuVU8eBh05hNBq39sBO+tSl0a/gR/j9hULC5JfzV1Kc/bGii8x/0PkXfUxTK+nRd5kE9yXVK9nBVEO6pXrxfr4zqBHnRwHVoqvnC7NEd3gk+u6KtlPq5oAQjeR/rce5sDXEq6G82jTMoQ7pgzdQwYP/4aKTFy/RsNHiOYlHvY611IQfiPVVZA/YQ9cZJqI7nL87O7AcjQH7stkUXFI4fMsGA1u3g2iY8qQRTWSurPku9mC6LliHHmY0nHECx/huXFQ50zUlCgsqFeXIxJFHr+jWvGWiFAcVQe/hUS4ZUrXxpLDcwuPLgYnaFQuMP2NVycfK7woFyiqhyYDeV/uhp5KQ91zrMf8oVcZJ8MKoLktf8wDJNT6IY8WcGIqjuQlBf4zCSz5VrTh7uKBtcUdN7pu6DuoUYNTr2THoZsRcOzAeSKL8OXemOto8baivuvuOaV97
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(16526019)(47076005)(186003)(4326008)(426003)(41300700001)(82740400003)(2906002)(70586007)(2616005)(36756003)(6916009)(356005)(54906003)(70206006)(8676002)(26005)(478600001)(81166007)(1076003)(40480700001)(316002)(82310400005)(6666004)(40460700003)(8936002)(7696005)(5660300002)(86362001)(4744005)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 20:56:25.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b59db402-c6fd-482f-8bb2-08daabcb0fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To match with the definition in psp firmware

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 1c36235b4539..552e06929229 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -125,6 +125,7 @@ enum psp_fw_type {
 	PSP_FW_TYPE_PSP_INTF_DRV,
 	PSP_FW_TYPE_PSP_DBG_DRV,
 	PSP_FW_TYPE_PSP_RAS_DRV,
+	PSP_FW_TYPE_MAX_INDEX,
 };
 
 /* version_major=2, version_minor=0 */
-- 
2.37.3

