Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB80C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 22:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1315F10E651;
	Wed,  9 Feb 2022 22:52:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C0B10E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 22:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baGRY+RBOraSSa69z2qn+nR6BWN/m+t6tB88AOcfumXREEdwRoq67qMUmvYsFk3qfx3qu0zWnaDdT+QGXQBLCQTy08hjswEyfifu/1QtpLLFh1be/uY0qJJHLUrcbNAstJZ6x6DjZbsDVE7nOYiaoBGwqn70o5ZZURGKE2QYz+OQxtJLqrrEBg4i112kKTpGUPYjT8qq9ct9ELPoalmZNuTic1pfOoj41w+B1jXOMCA7bRyyp2vyCYKIi37P8HMX/R0j+NHMjrRHDPLXXX34iyfo5v39oyCzuL+Um3F/VGw6bGCDXbYREYJMJw8iLVZ8tBb67JVpIrH10nVN7Z+JOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd1d3PvYyTGx5GOyb5moKalovbzUDwmaKPzlUP6e1Ks=;
 b=IOLqOZwJFxA33aPktC++pj0h7+t/T08xhXAFCRXDQd0Lct+Nh/6x7XnExZElboeuhkTwzoMOih4/94Az/vcykWUPK1ECTqMUndxQrnZZkceNcXyiXDKijMmBps734zrY/oj+79VKg6DJfNywQIayQO88o2TrGXys9J6z++DN5tI1RCUCqEbsmGKHNfnA0Av6itl6ERUtY96OOFTurbsUf0aYQ9h1UK6070GTIe1x4fMhVOswEdpfyht8tIn8WseMgY4K2e6ml9T8AcWuFTiN7th7cTKNEzMAU4Ey/EJNZQNn0GQLyjKbgFgniKtks+h2+rq3/YgpxDq4D7f7uPpTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd1d3PvYyTGx5GOyb5moKalovbzUDwmaKPzlUP6e1Ks=;
 b=bd+/gMZjTgcf/J7HnwlcjryL4f35i0sOjX0XwtbVhtPxyR1PG3iNUWPgC0B99NXla0l7ex/QSYHrUKS4CVRS6uIwmoHkUwZM9ofnn+FWw8ynRgHk3S7etgFhKPxJ0UBLIk/8P0shDl1KANux7tGH0kxbGYA02OYfIl3eXPfsl1I=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by BYAPR12MB3607.namprd12.prod.outlook.com (2603:10b6:a03:dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 22:52:00 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::70) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 22:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 22:51:59 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 9 Feb 2022 16:51:58 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 0/1] drm/amdgpu: Show IP discovery in sysfs
Date: Wed, 9 Feb 2022 17:51:43 -0500
Message-ID: <20220209225144.8433-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d74e365-820e-454a-27d4-08d9ec1ec81d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3607:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB360771B69F01A65CB7E7F6A7992E9@BYAPR12MB3607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3G8qJkFSMtZbvXZDWFnSF1r/GX7+L07Bl3XjvDk6brWrvi+T6geUa2obZJcP4xV+KIFsxjAwKFvcfYrtxfw55Rvu3EonR269F7r3BtZM9gebhm5mWOcTpoOlGcEJBbts8G5TG1eRITI328BYolWdycTSMOFx1jVkkeLxMdS08ngz2hWu4//5iOt/Eyzdycz8ox88snhII0CdxBWrrnhcjiq4csM8fZItqiLjfhFcSaJW0TPj7kv1jT8+HWr01prL++CnD6B5yKd8jLOuY7OHYn0KcCd64Y6dfftWWWnWZx+t5p+H7Pg795BOs8tiqRu6kHqexUaCzth2cFYnAZJDCQUx0SdW/nQBLMKiDavEfDxhzuKrtMTEVay0mMl9SpgELBb3Iy1iC98Q3Pz0AY6nEPXUp7LOMCvHOjCcQOxBb2ZungfraiT1jINEhjZTkk54z8mBTBR/DEDl1dt6sbSSLI+Gmiy0GRIESEeBJ3eRlImTcvGFVXNAXwqezrMkvX9nnTocJhiCOa/XzA5WmLvErVJ3LFnRr5Ad+HgGKR8/9jpGFoaegY8bGLm0qgU5e/RFt0cqvqGl9+5ZXhODKhFRzw2dob9Gtu5Nl8wOaIUNdFWxTuUlNrpLUpR86gDAo8zCozQ2tooLvUaSNIHy1tvP0/A5GYNJrS+X3a7pVDzVFO3ydPhG+Zplijo5Szn7olUc+8NUbc8PCjjasi8DqO/kLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(426003)(82310400004)(16526019)(6916009)(186003)(26005)(336012)(1076003)(2616005)(316002)(2906002)(81166007)(47076005)(40460700003)(70586007)(70206006)(356005)(6666004)(508600001)(8676002)(44832011)(5660300002)(7696005)(4326008)(36756003)(86362001)(36860700001)(54906003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 22:51:59.9070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d74e365-820e-454a-27d4-08d9ec1ec81d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3607
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Version 1, this version, adds sysfs tear-down on rmmod.

Show IP discovery in sysfs. See the commit message for the layout
format.

For instance, on a Sienna Cichlid, the layout looks like this:

$tree /sys/class/drm/card0/device/ip_discovery/
/sys/class/drm/card0/device/ip_discovery/
└── die
    └── 0
        ├── 1
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 108
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 11
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 12
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 1
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 128
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 150
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 4
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 5
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 6
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 7
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 170
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 200
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 1
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 255
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 271
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 3
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 34
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 35
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 36
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 37
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 4
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 40
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 41
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 42
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 43
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 46
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 47
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 49
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 5
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 6
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 4
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 5
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 6
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 7
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 8
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 9
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 66
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 68
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 69
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 70
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 80
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 4
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── ATHUB -> 35
        ├── CLKA -> 6
        ├── CLKB -> 47
        ├── DBGU_NBIO -> 36
        ├── DF -> 46
        ├── DFX -> 37
        ├── DFX_DAP -> 49
        ├── DMU -> 271
        ├── FUSE -> 5
        ├── GC -> 11
        ├── HDP -> 41
        ├── MMHUB -> 34
        ├── MP0 -> 255
        ├── MP1 -> 1
        ├── NBIF -> 108
        ├── num_ips
        ├── OSSSYS -> 40
        ├── PCIE -> 70
        ├── PCS -> 80
        ├── SDMA0 -> 42
        ├── SDMA1 -> 43
        ├── SDMA2 -> 68
        ├── SDMA3 -> 69
        ├── SMUIO -> 4
        ├── SYSTEMHUB -> 128
        ├── THM -> 3
        ├── UMC -> 150
        ├── USB -> 170
        ├── UVD -> 12
        ├── WAFLC -> 66
        └── XGMI -> 200

114 directories, 365 files
$_

"num_ips" shows the total number of IPs, as this count exists by the
same name in the binary data.

Typycal contents of IP attributes is,

$head /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/*
==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/base_addr <==
0x00001260
0x0000A000
0x0001C000
0x02402C00

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/hw_id <==
11

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/major <==
10

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/minor <==
3

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/num_base_addresses <==
4

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/num_instance <==
0

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/revision <==
0
$_

Luben Tuikov (1):
  drm/amdgpu: Show IP discovery in sysfs

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 486 ++++++++++++++++++
 2 files changed, 490 insertions(+)

base-commit: ff7951de1a24615706ca2533e27170961ce11f27
-- 
2.35.0.3.gb23dac905b

