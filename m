Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABDFEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 05:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789D110E3F7;
	Wed, 19 Jul 2023 05:20:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4FB10E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 05:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiHAQ6Jy/Dy37fkbbrRBPEEwGk9bnEApBzbMKpksGZ9wzlKPkTyUljdiAs5waNHfL/lC8aA9ZIPSQ6D4wBeh36dZXKVLnCAq1IERkKFxmTBlInx4tpIwYmV5hm+2tkGtM0ywyeJeWxIxulgrvAdv4O0BRxUscBbs2lDIHpUqZZkquTfVLpTHtnaNYCCMOfomJ2sWwIyN+wR+0S/tp4yzQRWk/mYLfdCVT+7mC1uv0Xz0w8R6/L+7ST+l/4JWUlLgDcuveOGbd3WiteoELEC826ohkgkLol06YU431IQ/o45r9iRqEHceyEYAAinpKFK5lVMz99BLbIUbj9p3NbXrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COtyvZdPBRX2UkutMCVx95ReTvbgKz/PUdcz204vrRI=;
 b=ADAEq5BH/ECcaJg+x8vCgqCsKn1lmh7lv4FpRThknHyjwr8gtlUGt3KfPApO8GiAJXFFWUbPHJQwT8WTk15ghER3JbqDzg1+uZHtCQks6YX8DUGBANt3/PKCxdZ0vdzuytf5JrVuhU1s1Q1gPCoPg0sgHjM5sHKXg7ZiH141E94yCOd+JErs4Wyu0jkVKoyuC5zqZuaCJdklQZALNF3AHmU4EuIbNSoaeARTOEDTxie9Y+Eixiyec5Lvyj4F0TZmoyJR0ljXtW/xvEuDpKtMMRS+mb+SvUTQOp7ZTOHIzYgHurtvV1zR4jSj4rAOgFfKcS/TnKBxXlI9XL6HTU1hqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COtyvZdPBRX2UkutMCVx95ReTvbgKz/PUdcz204vrRI=;
 b=oM213SUOjvjxOHE2KAxihU7D/kUoG3wH68Z0HvALTbp/GuVpPXYpyPThXIBWmlmAmXJN7HA+Xn3xOuUwEkLi3lZaFZeWQZ1ZQ1a2fckKWEf2EystlLtwHSTkV2CdjZnnCo9O8qaGbLmPqOD2SrkgFQumZFTgd/iPpm1NuvVGCmo=
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 05:19:55 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::45) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 05:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 05:19:54 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 00:19:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 0/2] Some more Cleanup fixes in radeon &
 amdgpu/amdgpu_display.c 
Date: Wed, 19 Jul 2023 10:49:36 +0530
Message-ID: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 1020e08c-828f-4cc8-e0b0-08db8817c947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyfYlfMWqb+spwT6AB4zabAm4uutwDAN1YIWqFiji6nNt2xqggH6G3XIJ1lbgGANgz7PlEjnvC/yJ01LbY38BEk9yfWJGJWWh/4Vej68uc9Gu8+uU9EBY3hQfS9JPhWpHbY2OLAOTwUoi+amIOGUkZ370u/gAxBwaeV15Hec/f78XO/tuiP/D0jOKYr54jmZG4+OGC0Q6t94bzTPc4ERD1dgiqYWS2LiSbuoOGQO1n5tww+t6/aB/TnfTxunrv215rRsIovUJKuRWoQmMCJNXJ1ZJT9EllyP5O1gJCFB+LAHVMMgrMgrEs/PLjp/JvExgnnZVKswoVoOMPvYLQHdGfcjL0XICbTAnDGyv3Fu17DDQ0F0+PP/XiYuKpz48CUGGwk0FMcla/M0ySz4ZPmqQckRTzZ+Jfq8zi5H2dgHERWDMUsR8BwBa6NckW7j+LfxIbjfumM/DJCbMstAcX9WEyO3fKXPhzhFTKBd8SNnmBhVvzNrj2lG+y1Xzt/0RejTLMdnpYM/Xu3q60W3ysWZOxXnn0a4gNOkbI8jWOCJkbmvXZIyaHCI+e4tlti9Zvma14PHhPn1YtXod/u4oIJUDX6R5rJnghaVP6NuEt8F+t1l3HvyySxtCyfVnQJ4IER1ZzI/mVJlEtOdhJlF/sTys4gNaEDmuzjUu+g0MQNzUrYgKBVpO2TajPNcmBxkk6DhP5NvvqDnNXBmfApMTVSfNq1o+6NjrvyD4ity9NRvsaRiDvfoUIBufyDvg/I7kLFPo/YdeVj4qQjx3s6nO/k8pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(40460700003)(356005)(81166007)(478600001)(82740400003)(110136005)(54906003)(40480700001)(5660300002)(8936002)(2906002)(8676002)(36756003)(4744005)(86362001)(44832011)(4326008)(6636002)(70586007)(70206006)(41300700001)(316002)(83380400001)(186003)(336012)(4743002)(16526019)(36860700001)(26005)(1076003)(2616005)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:19:54.4363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1020e08c-828f-4cc8-e0b0-08db8817c947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Srinivasan Shanmugam (2):
  drm/amd/display: Convert macros to functions in amdgpu_display.c &
    amdgpu_display.h
  drm/radeon: Prefer dev_warn over printk

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c  | 118 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h  |  46 ++++++--
 drivers/gpu/drm/radeon/radeon_atpx_handler.c |  10 +-
 3 files changed, 141 insertions(+), 33 deletions(-)

-- 
2.25.1

