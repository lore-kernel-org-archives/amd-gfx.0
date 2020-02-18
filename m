Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91001C3402F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 02:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675D420801
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 02:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SKRYVeYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675D420801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C796E11D;
	Tue, 18 Feb 2020 02:54:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC37899D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 02:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwj/EtDo4WwNDEiQtPJ6Y1NbySQIh6moR4IfjCdZjJk5EDOZQYNFKTwhR2cLx6GrLMAD2R+bpRdUJTIkT+LmQ+7HRPcDiCa4EUG4/f8LGfoK/67P6iLJLRisQ+0NRc24kI4RgqtaRr/w6esHxHRsH51roW7J8kCxZPpGxE+2+wuFTcW1PDCuH/JLgyILFKo2aQ7cFuDunhnycFhU0Y7AV381rXasl1E/qquOmtwMhtE5qOXSLDNh08ZdE1yUIDlCcSweTpnCX7aZBR4Jrc3fGE2z+q+P3ImQ1qne2QuxiQHqZ6oUDAwOae3qdzEphYjl0K4b7IEdSt0Qt2fktBmvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVlEQmXB34xq4FRXrQUy86f9qAIDcCNgG+m/06rc1Mo=;
 b=i+eJNc5na0y243b1EG4OE8iOpHWFoQdMMrtGa05U27zyh0HEWRrf086FdiuOQt0Q1N2iSwMkxx6iI5Rt4DWp0g8ntivCIo5K8I3bXMJRMR8rKGoyVzU39q1Y9UF5u93e9qbeKlrqTPQueWVCFmAMK0AbKPyeKJoe54PHi3vq8j5ciggQjkrdh2+hm087M/pBOcPRGqG7fWxaYfNkyo7aZKZ7COBTtLkB04+11I/N35ytQ0i+Jg28TrKKq6lb2tGBYJGhhSXKKG4XyB7JS+vuk0050ovENOqbLHu1ATKc8hzazyCi9nBLzxF6oWYpz4KhePPYh2unmf24b2LwLPCJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVlEQmXB34xq4FRXrQUy86f9qAIDcCNgG+m/06rc1Mo=;
 b=SKRYVeYkNBBOUncikAOmsR9TkDKv4/bU9MEsTmJ83zVqpNfMFPaedI5O7MGVWzzdyrejJPPoLLb0Bnf0+pqIbK/+AiTxmTv9fCtMS0CP0HQAZr52MPWWALLuRcGlWqg3VIw7rCij5/qyhnIdMj7tZ7V+bZ/s6pbEU7c++aiEoA4=
Received: from CY4PR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:910:16::25) by BN6PR12MB1716.namprd12.prod.outlook.com
 (2603:10b6:404:104::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.31; Tue, 18 Feb
 2020 02:54:20 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by CY4PR1201CA0015.outlook.office365.com
 (2603:10b6:910:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Tue, 18 Feb 2020 02:54:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 02:54:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 20:54:19 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 17 Feb 2020 20:54:18 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: fix memory leak during TDR test
Date: Tue, 18 Feb 2020 10:54:12 +0800
Message-ID: <1581994453-5498-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
References: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(428003)(199004)(189003)(4326008)(336012)(2906002)(81156014)(2616005)(7696005)(8936002)(5660300002)(426003)(81166006)(8676002)(186003)(316002)(86362001)(36756003)(26005)(478600001)(6916009)(70586007)(70206006)(6666004)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1716; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64f1485-51e4-4e37-4434-08d7b41dda36
X-MS-TrafficTypeDiagnostic: BN6PR12MB1716:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1716260A576B99046C1FDA4284110@BN6PR12MB1716.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-Forefront-PRVS: 031763BCAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hd7PWzAM9YSysdZNv89LR+Ut/0ja3j0DULQ0nI2XSxpg8gbE79Ztigccp/8hpOvumgsHlI3V872iKRSytH86nyOvIBiCetpmA2jq+tYDnUFwEX0ZdH7HNTpwJ6a5cmbVtDjrbNglSot4ytvL3Zn/GfhjbsIyhdVDO56KgxQDUpketnkIbl014JgehXpXBBuG2LrIsEJFvmF0ZgzErl684OXD3Y8UnBFdwBBOuLeUdvXTrQBL2Fa/144U59CMltmk6jh4aD9gOSv4/g+olD2xl5CaxymazgTL9AE1JxXp2cWXlrOd32Pwg7IUTxBEb09hG5PjuEE/iYLxFILPrp9sMMSdE0KCgok5F1w8kVsN7nU4PC2f3bms82v00K//6nlZGnfL1QOMlk0Uq9qHgS0fGlQvfE3LNhmcKxCRcPfgSoS7t1+zD8JsoZegeW2cU67E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 02:54:20.2644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64f1485-51e4-4e37-4434-08d7b41dda36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix system memory leak regression introduced
by this previous change of 201331 - Single VF Mode Test

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 9d15acf..3363f1c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -978,8 +978,12 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks;
 	int ret = 0;
 
-	max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
+	if (smu->smu_table.max_sustainable_clocks == NULL)
+		max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
 					 GFP_KERNEL);
+	else
+		max_sustainable_clocks = smu->smu_table.max_sustainable_clocks;
+
 	smu->smu_table.max_sustainable_clocks = (void *)max_sustainable_clocks;
 
 	max_sustainable_clocks->uclock = smu->smu_table.boot_values.uclk / 100;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
