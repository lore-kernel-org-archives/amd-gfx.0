Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A57EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E8A221EC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E8A221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEF989AAE;
	Thu, 31 Dec 2020 05:38:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD9B89AAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 05:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8eyrj4ly8uAVxFRTbEUhgtzfpXGF/BQaIMjm05v7UShRBOCXieSMekXIO+ciPj9iQDumv7mjI9W96512e8CwUCoY5NWPN8YC6M3NxsoTAvKa7L869Plk1bz3SGinCkbzu+eYSoIUoorfHTmlVtczEa88a1yuzdN5D/ETXXpn7xjrd8ebKYzYXY8hnxhgOVX88vf4DMHIiAZNkw6UtylAlP1WrHciZJUye3mCcluaTL1WG5zP1xnEkdTxNL8KpA6q9I7vlz7eVqJex+RF57qp1saQw0ZGxEDY+5VJsuXhHP7c3372g/hia0Kk6pNN3BIxhTPsMAyfaQjw1w9W3OFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIwwRkK/xMR8CcPcX0UQd00RQJ6IEgHSMAZzdXM/DMQ=;
 b=XHAHVEeOdP1Fys9FcvXgh/ux1sKVLT+BJNPLApl8OJH26Y4QEin+bat+IMIk18PzMD3Vwjavbml2OCDiF2acVFhiEFE2CEYdNDb0zGcB6NccJTNfHHxdEcUSrR0835U2z3KZRME+lyCh9M/mf1XA3XHb0DcYmQ1TUBBbu23K7Pmunr8sGzxfR7xThF/F7tsIL9yI4iXoNtU/NLCHaw4ht/690poC8zOdUi1dO1szjHNfDyup1X6RootTRks8PKFB7tuYT1xnVAS1oUPTK/gDXs9fLGBfvt0G3Qx8f2XqSfKPZy9wcQ2O+Egwgz7yhntsqj5h8JlqMKZrh7G09wXP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIwwRkK/xMR8CcPcX0UQd00RQJ6IEgHSMAZzdXM/DMQ=;
 b=F+ybOrJ1fsHwNwNNqKmUrlcO27XCLYZzfO8mM0jcnBPiBKc9C/UTZyy0o74PYwnVzlFaF6tycFZZsGaPiCZza5YScc15MAy5TW2bEhfEi0pBOeEDVpgKsMOBF3VOByl+1ubzafYDoaYRe6HdDfZT5xVp5+dHviM7YrT93zFDLPU=
Received: from MW4PR04CA0006.namprd04.prod.outlook.com (2603:10b6:303:69::11)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Thu, 31 Dec
 2020 05:38:16 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::fa) by MW4PR04CA0006.outlook.office365.com
 (2603:10b6:303:69::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Thu, 31 Dec 2020 05:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Thu, 31 Dec 2020 05:38:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 23:38:12 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Dec 2020 23:38:11 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jiansong.chen@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix a GPU hang issue when remove device
Date: Thu, 31 Dec 2020 13:38:02 +0800
Message-ID: <20201231053802.27248-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331abdcd-ef50-40fd-f7a6-08d8ad4e4437
X-MS-TrafficTypeDiagnostic: MN2PR12MB4453:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4453BAA8A5CB89898C944160EDD60@MN2PR12MB4453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2lfM5VK8L6+zElhCUC72itXOS9WlsCMF58bZYWSgVP1FCBV+K1iSn2EQmJ4VVId6qfvXeSWO8ihnmKULO+Cr5ctonBDkQ7ltNpDPVThIu+sUVxTZHB0GHdtd4sQ2GCVKQVkLvM9AH2SXBvGRKa5E7Z//n0VGWRuY64APIInGBJWp3C8o0yc3UB95h1NCxblomIuunud3REHWqKmWYpJPubFNF+kmn3Wzh7B5TnU4ODL9nDhxRzpQ+OzAMo0djOWrJ+QL1cr6YXX4fQ21psMcPGyB8WHJTxuABJpCW+4RyUjs3u6Adror3fi7W8n5UB9m7uPpc3lqTJsdp6iy7iYiCROFPnMlTcfIBa0KZZWxz3IlnEI1y7qpvRp5bFPT2X+THwcz0YtMWNc/ZyOWC9EN7w0p3BXPaPCf1zi5E8wWwwI/FGTkMQEY1Cako+TUFRsxuE2xY1NW0Nr4KjI/JnLBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(70206006)(8676002)(336012)(356005)(4326008)(82740400003)(8936002)(82310400003)(110136005)(6666004)(47076005)(6636002)(70586007)(316002)(478600001)(81166007)(26005)(7696005)(5660300002)(186003)(1076003)(2906002)(2616005)(83380400001)(426003)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2020 05:38:13.4749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 331abdcd-ef50-40fd-f7a6-08d8ad4e4437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When GFXOFF is enabled and GPU is idle, driver will fail to access some
registers. Therefore change to disable power gating before all access
registers with MMIO.

Dmesg log is as following:
amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
amdgpu: cp queue pipe 4 queue 0 preemption failed
amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2
amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2
amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I42431f5d0bf54909e1df888a0d72fc009d8e196c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1cb7d73f7317..b69c34074d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2548,11 +2548,11 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
-	amdgpu_amdkfd_device_fini(adev);
-
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
+	amdgpu_amdkfd_device_fini(adev);
+
 	/* need to disable SMC first */
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.hw)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
