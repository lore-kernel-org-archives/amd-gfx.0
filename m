Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A233C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  7 May 2022 07:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C141F10E0EC;
	Sat,  7 May 2022 07:06:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B5A10E202
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 May 2022 07:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpuVWHS2mWDqa6tb8q6hNjD+8FizXHlA+32KNhw1Ed8wqWa5mwv9licaa+QW77MXDEAkC+MjF8aItpWUoPNdfkjbZj5/Dw3GLDWkE/owuFJV6PGyOPEU/RNMmC5vA/rXA4fwiPGXGogGQ5RjIAX0PCVCGbIhR2A87Dfm4wMI1sxajD5K0h4RKKH3giYDKvAOj/jSkIDC6s6AHQI7UhRrIcuNGrrVJmFybLZYNfPI4zf7Qn6JLIirzn1TchKGuguXHd8gECKV3yuaP6BPUz5hvkOQYMleSYXwTNiC5vXcXcBGs63e+N/NPNPAuy98+dFbHBKv7hprtm7cdobpKzupXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKloUJ32i1k3JnMMDoMsdpB/dH4bt2+T51nR/luNk7M=;
 b=jbej8QTZ3mCe0VasRHB1TUU2HsDnoB6PzsY0saNLgEnA6sh8Za+VCl1CgElBQIZqEiCgsTQ03M1Le2GUNAoc+JEWOHQd4lNdZ478mFfv0L9f1KvMqRMIA2hoydie36paMG31msGvTnJ8D6cJGKQB7avnIP5br/9Tk7ihaf4h8RSA50f+oQBdOvGk/o9Lm79AMzY+8VscSay+kMsjKgqbEXsOe7NMv9jXGYHinaRoOSwHVMj7o0i0N2GdMsX3X9qwuFXYKcNm1+Oom+Vu7+7U1eV4C8DEyH9nnx9uw/1HbZG0vM6Be4BIb4wheawgIfShrC7nzs3DGKQbCPg1WjzTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKloUJ32i1k3JnMMDoMsdpB/dH4bt2+T51nR/luNk7M=;
 b=VvH92DyGz9CqsAaGTsLHt4N6kILF0nR1ui080JgQMPDMsu1P4YZTMuIlQbVsXHrlUIijCgrMdVBslVdkrgo0jOpzmCW8k0wanP/+C11d7lFQGpKfMFttIbwH/53mUs3ZSI61PgktAnXMVHna/5xZWVpc96PtLgjRFbWnuu6CCWQ=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sat, 7 May
 2022 07:05:58 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::30) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Sat, 7 May 2022 07:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Sat, 7 May 2022 07:05:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 02:05:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: suppress compile warning about possible unaligned
 accesses
Date: Sat, 7 May 2022 15:05:37 +0800
Message-ID: <20220507070537.1344218-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e5fcd81-d8f8-4660-0343-08da2ff80900
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02192D7E95EB01FFCB427562E4C49@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGBp4L1I+C74eZuGqh1WHLKCnw5SPBhf3kQyIp05IScS8mozu0XYGR499qMU1lkxnp40SjukMrMWcGdtuSqD5KpYxIYRcTvqNiGL7542b8U423ofjkIjbO+VGraTxy/dDH1eDA5HIJa1dGAg/SBolEm6autUkpJkXIi2JeEYObBt5KYx5W4P5dqnBUgcX6Iicc4eAK+CZRpY+W3kjAaFbP+zlBCX2TNXtgCQLTg/1XiUp5ufYdIMremREbNnPtz/xh5w0GgRrYbMjcIF3mwQaShE529qTHpoOzDW0ysbrS6U8ucNfvGxVapsXOcZgvGQjBvlgYoQHoEcN1TPYkw/U4Ywb8639vjZQM0akUFzsYoZQb9MBzo1RNYX08082LxVu0VHOPOC5lineVsClYqtY6TkGnwtmy1gG3jzmdnbPRsAP0L1C1Qbh0cU86nWKkIF/Wmvj9mHK/U0xj9x5mlVKljgLssHiSrv1O04Yi3DeFPfjL5YNYSFAuMiVMCdoVUSPbe18n+5TgVqjMcsv0I+TxgcP3CB7vj0uA1raBPtCv1gFN3iKDovjtrt+vr2QVPmNkNzxcd/4QWsn+tGTmvjF8OLYtoBB7YS8viHQhKTMiyvK3L0O+naxvTm3yyqwS9VHjD9y4ixg820CkybRM7Xeq1siYE/XkQkubbSoUbY2nizxesbFHo1dYqC8jC0kUwvuyCPMEuKs16QOZUt7j07oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(2906002)(508600001)(5660300002)(186003)(36756003)(36860700001)(426003)(336012)(40460700003)(82310400005)(83380400001)(47076005)(16526019)(70586007)(70206006)(8676002)(4326008)(2616005)(316002)(54906003)(8936002)(1076003)(6916009)(86362001)(81166007)(7696005)(26005)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 07:05:57.4018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5fcd81-d8f8-4660-0343-08da2ff80900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>, kernel test
 robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the following compile warning:
   In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_0_ppt.c:39:
>> drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0_0_pptable.h:194:39:
warning: field overdrive_table within 'struct smu_13_0_0_powerplay_table' is
less aligned than 'struct smu_13_0_0_overdrive_table' and is usually due to
'struct smu_13_0_0_powerplay_table' being packed,
which can lead to unaligned accesses [-Wunaligned-access]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ibba9dbfcc6440d0bdf0fbe0534ce6a82ab6d5d10
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
index 670f2ef67868..566a0da59e53 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
@@ -22,6 +22,8 @@
 #ifndef SMU_13_0_0_PPTABLE_H
 #define SMU_13_0_0_PPTABLE_H
 
+#pragma pack(push, 1)
+
 #define SMU_13_0_0_TABLE_FORMAT_REVISION 15
 
 //// POWERPLAYTABLE::ulPlatformCaps
@@ -194,7 +196,8 @@ struct smu_13_0_0_powerplay_table
     struct smu_13_0_0_overdrive_table overdrive_table;
     uint8_t padding1;
     PPTable_t smc_pptable; //PPTable_t in driver_if.h
-} __attribute__((packed));
+};
 
+#pragma pack(pop)
 
 #endif
-- 
2.29.0

