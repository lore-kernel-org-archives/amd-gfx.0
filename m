Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEAFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08EB12A729;
	Thu, 30 Jun 2022 18:46:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E565711B62F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzJxoB86rF6ob4wkZqNq3pv+kR54uHXIf1QCHAZ11IsN+SgzL8bPCa+IzO2OCAszmC5Q4Jdk2hgvS2HarrwRAiAPcAKVbk9rkSOo9YfJPDBpjInag59AUvkcOxzyMjV0DusWdQUSYAx0OKhBQNoV9DumnaTlcGYLAw4fD+AO3KlB5tsP/Eseb2ACqgqqIBxALNhMeyDom3JoCz8hJJqjWq/RpeC5pHac43ygciDQhqhTXGsMy52RENkIshe9YyoXO2lMBbssNCNDtr4gEEAaJrFzcGqaEt4LnMwro72RI2ADUvqwSUasywXGsmI62c2y8nEYMlK0KGNu7BBT0xfe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNdYJ/T4Itr8CtXbuEXwx5lGADyeYqMbPiiuv74tvc0=;
 b=ej0Ra3DKnO5UTRAN0YqLJmXirJvvFQ9nmBWJcFc4SodtwrahRElwGfFkC7V2niy94EbBdiaJgdSklpBcC5SB/dNYC1sCoh8FNR3RoPqpnIwhA2CUH1xjaZEk6scNlT8vGsNlKD+bDWStyOKIPSEQSaTpy+MnLqJrr6JbSOlALYRTkEle+LxjqlmWTmrfNS4lpnk0uf+9UHGyD3F6XwTmYLvA00DyXzvVweYFlZiDHn0jbLApF7X+Ik+C+PrRVd+4h8B7K045uJtXSXp3YSaay7ls1f1jfbvH50GL0kh8mW6GdfKu3bwmblpibK93wJQhFYqQu/Cb3oMTd0P7hX8mLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNdYJ/T4Itr8CtXbuEXwx5lGADyeYqMbPiiuv74tvc0=;
 b=WuaFxBTKwLIC+wj3k2g74XCXZJsOxG4GMLnsSduRu9YNPxhqmjbVQd+qJfLspInYePBKQp0PosA6GIKNTBsedIgVK/hoJvGrwVQrOTiYm5GisI/sG9P+WGH9hVoAJhkpoUIOxpCK6lnhtlwDsp3nOWmNWgrbue5A0so9ysjemjI=
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 18:46:37 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::df) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 18:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 18:46:36 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 13:46:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Randy Dunlap <rdunlap@infradead.org>, Leo Li <sunpeng.li@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 0/4] Fix compilation issues when using i386
Date: Thu, 30 Jun 2022 14:46:17 -0400
Message-ID: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be3bfe19-06a8-4d27-0152-08da5ac8dcb4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2590:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WW2PNx9fF+j+selq5tqqUtlCvNTbQwZPIIW0QjugYc3rZ4BXRA7nBEkgAmDw4VJSGsFykM+9vPieEa4d8VIcZCWsnJzoxgMHfNloc+vFNKxkp11HSRbZi60erNsA6EzodpkG7jxqaGmmnwWuevIxSzzdRYdUI9JYnnIqcnWKVF60WG2sB3WpPhX1t1542S/wIqr8ZXYFuCOESLqI6n5Uuxna7xPY7Yxf/1BvZX1+jyXA/OKsrDLrgeqbuOuELAMKzHn+iZ61Oga31KwJIys9lGBBlAgm0RF9069H72NaYeMR8PTArg+AyBTWTmbivt9lHCkx/nEGZqdmempTttvAgtjGMphckT57olB0BjatKMJizravHXVKA2wE41cy4V+0bVqzWGOfK9nrvphXW6Eg6zMx2cZzjSmUe1R79h9tpkgafIbzPuvLGEtHYOHzbGsWp1Z6mNIUX+UwBy/zd3EmTYxCUoYPUSNx/twElbeZ6XgptuF9rZmWdNrPnYCBu0DujyrHPyVz+RxoR9nbfmNy5uMDslD1OKOJHT6See/DkI9ulXXymbpjG7xs+5RpBU15TIDXlx2/cNQHcZPUmnZ/PBupGrnTjyjhc/rd2crScJQ+Hz/er9CGIVbeEUGOux/WfC5/ARHCIlpPYcyzpZ+O0tBDTxPvql2slVqz0G29qVWAG8MiAO9QFE0pch4qYmJ4Cgk7Wyp2vkt6GvwRkCZaNFEVDC2IkbucSDJx02bmBjzlvP0ONz4EsSAhBWOKdtZs0RlXYAPExviNgeT/h/S0hwrMxTxZ3NA3+dD/+zfnvVYlRfylFWNBjHO0hmDT+X15R59aay7aft5iwRHcnAvRWzQtOuEh9tWvFeSFDqvAP5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(336012)(110136005)(1076003)(83380400001)(356005)(26005)(70206006)(186003)(316002)(70586007)(6636002)(426003)(82740400003)(81166007)(478600001)(2616005)(4326008)(47076005)(8676002)(82310400005)(6666004)(40480700001)(36860700001)(5660300002)(16526019)(8936002)(36756003)(41300700001)(2906002)(7696005)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:46:36.8464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3bfe19-06a8-4d27-0152-08da5ac8dcb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix compilation issues when using i386

We recently got feedback from Randy about issues in the x86-32
compilation.I was able to reproduce a very similar issue by using:

- gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
- make -j16 ARCH=i386
- amd-staging-drm-next

I'm able to see these issues:

ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined! 
ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined! 
ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined! 
ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This patchset addresses each compilation issue in its own patch since I
want to have an easy way to bisect display code in case of regressions.
Please, let me know if you see any issue with these changes and if it
fixes the 32-bit compilation. If you still see compilation issues,
please, report:

- GCC version
- Config file
- Branch

Thanks
Siqueira

Rodrigo Siqueira (4):
  drm/amd/display: Fix __umoddi3 undefined for 32 bit compilation
  drm/amd/display: Fix __floatunsidf undefined for 32 bit compilation
  drm/amd/display: Fix __muldf3 undefined for 32 bit compilation
  drm/amd/display: Fix __nedf2 undefined for 32 bit compilation

 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 15 +++++++++------
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  4 +++-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.25.1

