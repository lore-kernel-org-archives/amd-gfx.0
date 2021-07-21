Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66111C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9C461019
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9C461019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20726E8E7;
	Wed, 21 Jul 2021 04:25:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FAA6E8E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 04:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4hAPm1UqQIDy4A9xUZXpWas8JpuLXToXYZ1hc6FqNTH3RWFOY7fSf9dCuk8cgByqfaE7WsKYvgTHtgwmoUM5HYdcLlY6U5pl1LiQVnfO4b6f3hr2gxvgKGeKYTxsfcJnmkAGfy/hNDT9AjORPm0K3HbPjK465Hhxa23csAfcfNV1C8V9tUw/u0bDPci3NYOlcwXnAQuN7JZ2zhDw4A0OxI0MkfP0W6gwZ5tUj//VSSWdHTlhc7OkJ/ek1nc08Y1uaeary5xfDvm4eo0s2aXWrpl8o5xPSgVXxILtq+ryXt9alQYhKOhIZ9U6VAV59U8O6mqqpHdAelf1ShUpEhzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk5cHpq6095F2x8fyKGW4BIMtsVT6zAltp5xrFWF4t4=;
 b=bJw1c4ce31f1nPAqDWvfg8QWabB8/vTQ7grxhnfuM18bDLt+BA4o+Tb8AcTngKe8gqGq7D0tQFucpRdFikxs8GKinHPHNOrqUwZLHykzZL0g3QFLxk74rGIJLhGexKXJDbk7G+/uQBV4GTHckXAG8kNOsjEc63DnuuQLgzETYn3wGRwKvVLv1fUhx1X52lJgL9ZXuoYBMF8si3Jv2yuj48RUfzWFux8H9jccQQYLTsKNbGKyKH+3BFi/WHi8XH2w73nhzsaDP7Pwiz8sFvpI/OtcUpUnRVZtYH3VUadkuS1MZRH70+iq5EsQwwWhCax7HqeeG3AfsIxF13w5U74cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk5cHpq6095F2x8fyKGW4BIMtsVT6zAltp5xrFWF4t4=;
 b=ui0acvoLsuzXc3J9wvXzhuDqY0t2mHYYeSI5ffhqySrmFZiUOq0mlTKZhCFKhkPYMHyN6A3dj3S6z37VA6mCwzbrKXuEC9R66QhecVxW4pYmFdTmmEGxnP2f2R1UBCHHO/7kKZCJRdQG/mQxj/aUYxxxzqOrqcn+4o9wAT2eVX0=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Wed, 21 Jul
 2021 04:25:40 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::6e) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 21 Jul 2021 04:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 04:25:40 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 23:25:37 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/2] Fix regression on embedded panels caused by enabling
 ASSR
Date: Wed, 21 Jul 2021 12:25:22 +0800
Message-ID: <20210721042524.754014-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720033317.686726-1-stylon.wang@amd.com>
References: <20210720033317.686726-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846c1648-ca0d-4d2f-98e0-08d94bff98d6
X-MS-TrafficTypeDiagnostic: CH2PR12MB5003:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50030868BED3C02DB2F36B54FFE39@CH2PR12MB5003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pe5jW9J/9nEZn+cvWYmbIjc9TjQ/e2rfg5NNd+4VsjwOuuhpWntMk/O1ze2EGnDkONExOGgIMGfydTqkfHt1sNdTrrt//YKFA/bQXWn/Ry+14m7blmMCCpgQD0eP6nPgNFs65b2iGnjmegNMUNXI4+pwbhKCzufloVwjaz1R1cxnXXS+MFgq0vyrOO7r44lFzvq8tQmeh3qbKEyDxsgGi8OFNCFkLK87MyxwAX4cyqPluQmZBdz9HQg+1TdhTJNtoRb2MwEM1Ridn8APMzeWCIjb+EkSEtBHBCNJi2segF18SaEMXcU+9HMmnLm2/1+/WqLvK+1lI1bkNUh/EJxszD2jkqosKmsSq64+7I3E90Ctqk+N2RI0NYNCB1tGFrWqaqwSJfLebOMs1916cN4pIB4SPInm0HIUjCv3sfCV68/Cvoy/76wGOtqnMhgeXxqNlajcg6UEpvMGha2DhpRtE5SyR9TxyZJWy64hV545dgRMsPkAjxSb5fB8BhnbhDl5vjQ5sYiMKrvQvYX/XzFAvT8KDW6xcJswuSTSpDF2t5gKAWWIPV9iX5eQHbLajY2OXT/EqLe31McdhMF6MLfKtQecH2EuGVxMCCo/Jc6JHg+bh+NZy9C+9jQZ/dFaPqsMwDSCK3Hv9R3Tkq7sYxfyoC36FPuNw5wUHPVULUweG3wg0kGVSF4rTMQxlhYLEDUqCBBxVDmEW7NBwX/frcQiETZOSQC/IGtOAIUR7NPdbg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(2616005)(36860700001)(356005)(44832011)(86362001)(2906002)(36756003)(70586007)(426003)(47076005)(26005)(6916009)(336012)(6666004)(4744005)(70206006)(8676002)(8936002)(82740400003)(54906003)(16526019)(478600001)(5660300002)(83380400001)(186003)(81166007)(4326008)(82310400003)(316002)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 04:25:40.2050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846c1648-ca0d-4d2f-98e0-08d94bff98d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previous ASSR-enabling patches cause blank screen on some embedded
panels. This patch set minimize the changes made to code logic prior to
the ASSR change and also improve on code readability.

Changes from prior rev1 to now:

v2:
 - Update reviewed-by and bug links 

Stylon Wang (2):
  drm/amd/display: Revert "Re-enable 'Guard ASSR with internal display
    flag'"
  drm/amd/display: Fix ASSR regression on embedded panels

 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 58 +++++++------------
 1 file changed, 20 insertions(+), 38 deletions(-)

-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
