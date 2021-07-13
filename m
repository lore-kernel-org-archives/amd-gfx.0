Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACF9C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 18:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A986127C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 18:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A986127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA948979F;
	Tue, 13 Jul 2021 18:48:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2585389973
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 18:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDeUTJuYgjsFgymzUbBW5JK21dkgVYxvu0p+BWzIa1CpmQkrZMGLrJAOmolrKUmoianfSozj3Aw2h2cBiI+O7M1K0bscjBbknENHYUcxtsZpWDO04GUO41+kpXHKGDUUUXD3UzL+bELy7wtUB2VsWlW/WvIOrZ3+EJ0wi/6cmscHzAOfszWryuoY/4gsV1N0XZeaXCxxoO5V3j03tubtbMmr4mN0LuPjF31lUgE0zq9rhC2WxH1nAEc/a++UuQNkcnxDNukGTQ1cMwrcmN3no/isJPwlKq1gYI/USlXNQdtG/9OCX8SoHmq9naAlVhSkPOqDqiH5jB/BUfMOiSvcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOf4K4HBkQvjzK8WiVIjaLpW8U7WWVN243k6PL3WSpg=;
 b=gZpVc0/PC4nV2hDSqlzWgRhUTzFSRV+1DPlZnBA589NjqyMMufIUCbnurLZwENuKkSdDfu+oHjHZwjetdTC69cMtKX89g3F1r3OeV46xzch2hd3MEeySJRrFsCL7cK4qcBQbg00Sfm/VtqHtp7Boxc5DpHwWcBphH0aGlBMJxxTbKyGnR5ThbZ6D6HOn/w431cr80kude9USt5buVH6y7S8K8IrbsJXQRgf2T0HpmqnIXg3hfZlkOmZC4ldRohwbJUDf86q7XfenYnc3M3tTaspv1VtIdIEyoVSalurndv2G7x1pfxwNnHMfzykWoFRrjOPX4VlwbASzBjknXB2GDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOf4K4HBkQvjzK8WiVIjaLpW8U7WWVN243k6PL3WSpg=;
 b=IHJBYtmhsBNOfJP6OxRfIIuIvQuG0K+p8aWG57LYSuQQl1A+zJTuNWDRswLZ6WNod/JKhMGHUhnijpoxxIkUVbqKlJqIuGdpIX8n63Xhu7jmYSxBs5ttS/hBeoXnaAytyXJYQvFSrFQcvwVlNBkS8Ck3dHEeCsUsjWQdH9AoCFY=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by BYAPR12MB3382.namprd12.prod.outlook.com (2603:10b6:a03:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 18:48:31 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::59) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend
 Transport; Tue, 13 Jul 2021 18:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 18:48:31 +0000
Received: from X570-RTG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 13:48:28 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] amdgpu video codec support addition and code optimization
Date: Wed, 14 Jul 2021 00:18:06 +0530
Message-ID: <20210713184808.1268570-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd36cf3c-9a94-4130-62ea-08d9462ecfaf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3382:
X-Microsoft-Antispam-PRVS: <BYAPR12MB338277FAB7DE523EA0ACE066FA149@BYAPR12MB3382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY7L5NDEm1/WxoHbVXBaLlBtBtmduQMTTXqhPDS+ldiHV42wNdEYg5gfRr/by7ZaEQ5yohmcMmzuc5OX/S82gTz0j94+Im9pLI4STk9AJEvSs/ZU8KmfHRwm4c54b59eN6IC2GA1NU8pNba+Pvh7yObKl6Z72iNfSDuHoA20CN9KjuG/SsQbHRIE9LIaEZJr0tnI7zNYp8O4Us/MMOUtYq7pC431mV0DLMsqLXhYgsQILa11JbnwcDBq2FlgdRPDLnumSpAZOsY0YWUXuw6DLNcMY4DfAZ44FBATykWJPPB7vPijhmjEdNh9AAMr4QHljN+O7knQhM0nVfwmzIXuMuenEuitDu4pL7F16658Q0Adawl3q9/WBSQQSZAHpTUoWbY6aFqcZrASXZ6nHKV9VGiM8liX/EGPJ+mYZgmB0p53oiKnaMbwOw+pWel81oWCYKDLkZFAsb0KvRb1Je3RY51qIaqFuAh8I/o1GRtxs1+keKxqjXTKaJsmUxM2um48TCoCTOtoGaRLJANeUVLclu0N7nXycTCiGEWZ/ycUtzB0DEixfNal/FKhf3oq/qfouvp2zavbk0naHQJ8GKufKoAOUyaOMLfMcfyZnGPyNqwkPoTj+BLlxbWW+iG/khWuCAqbB6Bj9I8QBWr8U2orQyEsPS/L87las+zMF7KtpS4UhB0uYHAPXAmc0CLs7mj6kbOE8wM6ZMvdkaOYzIHqoHvxhXz9ag9duTXhZBpdO1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(82740400003)(186003)(82310400003)(8676002)(16526019)(336012)(356005)(26005)(4326008)(4744005)(2906002)(478600001)(36756003)(2616005)(426003)(6666004)(8936002)(316002)(54906003)(2876002)(70586007)(86362001)(5660300002)(36860700001)(7696005)(6916009)(1076003)(83380400001)(81166007)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 18:48:31.4764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd36cf3c-9a94-4130-62ea-08d9462ecfaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
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
Cc: Boyuan.Zhang@amd.com,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 james.zhu@amd.com, leo.liu@amd.com, srinath.rao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Patch 1 - Added the list of supported codecs for yellow carp in the codec query.
Patch 2 - Code optimization for the codec info structure initialization.

Veerabadhran Gopalakrishnan (2):
  amdgpu/nv.c - Added video codec support for Yellow Carp
  amdgpu/nv.c - Optimize code for video codec support structure

 drivers/gpu/drm/amd/amdgpu/amdgpu.h |   7 +
 drivers/gpu/drm/amd/amdgpu/nv.c     | 243 ++++++----------------------
 drivers/gpu/drm/amd/amdgpu/soc15.c  | 176 +++-----------------
 3 files changed, 75 insertions(+), 351 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
