Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 09:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 398EA10F53D;
	Tue, 10 May 2022 09:57:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917D210F53D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 09:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBqd1Ek4ZGDzXl5VIs7+KW/WNBG+Fv9m894w0DtkZwiqiHGIK2izob/kytQIsSwaa4K8sElv+Vupjr5YCYhyUoy571dUTmXaK/h/9t8IRhxLgRdjTyMUO7KzvpO5SkHDI2F3GAK1A83iRuySXOwgqqrjqZQ5z0SzrAScvPETq60zt5+FcKiSaPMrVPYQy4LqCthiSDDRM5hbaIFxs3Q7Kxta91o9tcs6nGa2BMXPVZofEW4yAc42wD37UfKkFNuhbf+pAAllm1kYjG/Ge9950uLRcFCYHKmzvrArQ9g6x6qp2j5vvdv6N8JvlmnhBB9fg/1MJXrErGQlMTNRgiEKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWPVFojuoVovka3sXvlJU1+isj/mHRqHO7mb99R97ig=;
 b=Shdbr2Pe8ehFWj+c5+EaqDyeYlOmgZnbQxNEnkkDdA+j7VdEeCFP2YLg3fdsKa/MhYNFnLb0R6dQcjIDHFddGqmFgFvfx5WVrsobcYvUWPIL4SjBbMcJuExmyew+zBoUjdcxnfeur/FzNHlCV6bOlvX8Voh/NN9D0rtssXc0M1xRnSg4WpkVw0WwgaeAuNDu13jjdw2gzIymS4ct2N83crvZqSvAo6biUwGF5nRUCdajcz38HHM0dlf1o2xBin2uNnWlUH5Sni8m2LeJJMW6j8GKyUWrUyFCDisBd0fUUrqekHmOHIE5lkjJVe9SsYvQDMy9WDnSL7lIV3L9qdwD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWPVFojuoVovka3sXvlJU1+isj/mHRqHO7mb99R97ig=;
 b=bYrfxhin6otlXiGzjUJNDJFqlC/1XIqn4oBRxnYQdVZ1qcZ+4etdUBAkwEQ3Mds1QQZNJ7r/+9qEDWguWfeeo7R3ZGh3tjoIUxSwIF1D8YgB/V2cc2VKvVrilpGAm2s2r6yy5r/HEAWjUGBN0kYjWKbCCAd3fR3VXhUwcbMDMxw=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 09:57:38 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::de) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 09:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 09:57:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 04:57:37 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 10 May 2022 04:57:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Fix issues when unplung monitor under mst scenario
Date: Tue, 10 May 2022 17:56:58 +0800
Message-ID: <20220510095701.57375-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83df213a-778f-4f90-37a7-08da326b83ff
X-MS-TrafficTypeDiagnostic: DS7PR12MB6261:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6261412D14DDE81C6888EBCAFCC99@DS7PR12MB6261.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMJf6Mv1wzKkyGfjdwao3MRhHMlLkYSZhkX3W7CVSegUsjQctI5CMTc86kbFoXwVceKxQHISiLKNni/N0uABRyg9yj9VM1Wx0/2i9My8A4RJ5tdDmli/51Yx2NXVehYGBWptIoGQRyIISs8Qjm4vuA+VQfRsSUwVPzWpaQOtKushTFcunIpbIcmz+Ed9TIfNJUdQHQoN8WjPbG3Micum0lCp3DLXhvuwq6fOiGLvsHi0XmDBa9VFlaqk83MZUBgZcZ6WVau88D5T13GStVCRXJMMjOFOyfMkciEdtHvdN/QLscnTuSWIFxMi9jhSaXyuYSEqzkc01oi1ys3tDAjPaPzZrIA6drSurkRTTwyb2G3u96UUK4YGtMCgMJZWjviBg8kACBue7Mgkva421CUzqadGf4SBi/c+al28z0oSYsw7JpfH2Kqm/Ra6Scdeu1ERNGhgrYCddGrpe8nEJ5Zj2XAw91j8rJO1klzsSgxLKTGKn5HXAc76csfBCnDMt6Fg/pXEDqQ4f2zAXq2GpyOyEGUSzlDPPx0jC1nVf4AdAHLH5QaBQ86M+g+gubQ8fHLSc0hCS53nhzcnbaWmT5d0N9nEsP/AEo86pSd+ZMVktTPP05cYaUXHuFHMajcP62s/+h+vGsIvnUTVo9WBoiXewzqGoBnW6vrCj2CNZIqcI5NkZO2TGXQRJ7UOy4jps8NEpC2ppfXAYHOp1b9L6c81PhF4+EzkPlKMkClxLYPsgabjygWRuks4ygyAzAqlxf6Eu+MbCgYduKlrHx5u21cXpW4lMfuLxNhoZBQVqpax7WI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(40460700003)(86362001)(6666004)(356005)(508600001)(7696005)(26005)(966005)(81166007)(82310400005)(36860700001)(54906003)(83380400001)(186003)(2616005)(336012)(426003)(47076005)(1076003)(5660300002)(36756003)(8936002)(70206006)(316002)(2906002)(8676002)(70586007)(4744005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:57:38.1902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83df213a-778f-4f90-37a7-08da326b83ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set is trying to resolve issues observed when unplug monitors
under mst scenario. Revert few commits which cause side effects and seems
no longer needed. And propose a patch to address the issue discussed
within the thread:
https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg396300.html

---

Wayne Lin (3):
  Revert "drm/amd/display: Add flag to detect dpms force off during HPD"
  Revert "drm/amd/display: turn DPMS off on connector unplug"
  drm/amd/display: Release remote dc_sink under mst scenario

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 49 +++----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 16 ++----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 18 +------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 39 +++++++++++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 -----
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
 7 files changed, 46 insertions(+), 92 deletions(-)

-- 
2.36.1

