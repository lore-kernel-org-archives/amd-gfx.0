Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E159C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860E010E30A;
	Tue,  6 Jun 2023 09:17:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B59710E30A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ3wK7EqTJqdFUQMYkPCfnMIvt98mfg0jq8RG4PhW/HJIGLEEwIYqTWovwkqjpMTZ/xLvyf00wxNLGjIFJZ1njBP5hj8RWRCh56kFuP02Ud7E7kqO4gfIqwSoneTor9k5aoP3KJtNOeepRMv4YrT/P+InaWR8/uUK6vedWL9TL69MmJmEvBoVQD1CMGclTSneuubJpM4vLxV0b1hgz19iISRqa/9nJkCsMv6ybE6mVl0gdOfCh1F+vzLtgyxYSgtQQrxkO+mcXDplk3HYSQNUO24a9/0dmzB4gRAnOKd4ZiYeFYJvsabniaKc0zqXZtDVgw/SEZ0g8B7FB38nLy3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIqI4kzrUA8MVj/rb6bqkNWwbkKFuocmTEWQ5SXZcAE=;
 b=bKjgaZIPf91Sz1+n/sbn9p7nppWCb6K0G4NlGis10JmCglEW/4yk6tdyRpAQkXafQxWpOIBj93BzBApr3a7Rbz8YfqQfZmDl+l94rJcVBL0FCNXDu+uo4n0QUGfnIMxF6USEqBJpGuuBEkT7nENcSftvhmvDj0IfRPwDF4xaFaxbFsGt/FZdTpLcjHdrG3hW8Ib1purrnRxEq7TqHyobV3NV9b3hF+mCct0y4xP6MYSqMsCbbS5HJWdjnvoTIf2CJ4zKoXtEVs6kW8jbYcwByOOwL0TtwYPPe0P2IiIiDq4Xuq3RzYAeBo8V97eqzrJa5kCoNEso/lrnMf9pUTQ6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIqI4kzrUA8MVj/rb6bqkNWwbkKFuocmTEWQ5SXZcAE=;
 b=atabyUSjGr1HvRHATh4kyxutCHRlR3YQohsW6ztZZFeLyCdfQLdeOsFo32IBhFJ2tRj0/QgWi2vYi5p8dKZ4piZo8ykqQmbf8mXUx0SyUhmeLf/gtVaiyvgab0HjzHbiDmb5+fkbjz/2w0zwb+qvFcRToPWel3Cg7fjP0Hz+zYU=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:48 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::93) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:47 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:43 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 00/17] Various fixes and features for shader debugging on
 gfx11
Date: Tue, 6 Jun 2023 11:17:08 +0200
Message-ID: <20230606091725.20080-1-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 32274837-3428-4e8d-798c-08db666ee51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bw/t+fFIfQ5aHhLAUtb6IGTQOXAhhO6OqSRhYkdOekaxlYgwYOZikRKcXdMpXwZwb3EFXyL6iSyWkAdWIWMWpLiO2lj4Ric7wqy6MNSQTbvQ7H1YwRV1q5DD3gbN4gOsDeJTgwm9dmtnZ3oZtJPdamih5z3ooE1HTrqCcsqor3E4EXEq59IsSZB9M83JPk6TBbxFdEkFw3cGR8ww/yScjuOjizNg6kqGZ2BXX1ehJjhAmOecuk+La57K+YoUBH/hMjzFEiqLaw/91tl1uZbPY2MzmgD+LWCd6zmo1f/V+JSYgFJXk1BRhIlTMti7wlXJURej4h0lbbjyMqUivSUr2TkWAEdEIJ5fA6FYaa6vDqtrs6v047FjC9TtgUdk7KXTomw3ZBqmB8FGdgijHSiZtFsMY7IXvp7ZW4swoseHswOddcgjeD1YjwV76rp5FOnpFsqXHvl7tyEPrFCvXHyckdtrTkbVH22RwUGLasep7hFI0nrlV5hEwu+OZu3A61W2KMDxN88J5qwFGE/o85d2P1vVsjA8T+4c95UnzVOuNDLyHLcmi0NilSrGzTRdprQiNCoIAeLgTTeYYKc9J90SStZnYyFiYnXnhxotbl4I0M9fQyJH3vixtGr4lHHna+hal9TIgV2BO+W7WIh79cvfsn1LLIZKG54fQND9c9xglvGE24ZxC4rTPMF3yJULVCLpAmYxYR5MB1NzpLzt8Ub/u8ENbSCfEDQrmn+Kf8m+kxJXY3ugmo+7vpUTCz5z2zQ7UFEu9GnhlgHYWxbhSd6tIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(16526019)(186003)(26005)(2616005)(426003)(336012)(47076005)(36756003)(6666004)(4744005)(36860700001)(82310400005)(7696005)(2906002)(8676002)(8936002)(40480700001)(110136005)(82740400003)(478600001)(40460700003)(5660300002)(86362001)(6636002)(41300700001)(316002)(70586007)(356005)(81166007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:47.6685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32274837-3428-4e8d-798c-08db666ee51c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

This series does a bunch of things that I found necessary and useful for
shader debugging on gfx11:

* Fix a bunch of trivial gfx11/Navi3-specific issues like misidentifying the
  ASIC family
* Enable wave scanning on gfx11 and fix some related issues
* Cleanup a bunch of things around the "waves" panel in the GUI, e.g. fix
  the behavior of the waves tree view when waves disappear
* Add the ability to single-step a chosen wave

Thanks,
Nicolai


