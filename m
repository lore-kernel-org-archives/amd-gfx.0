Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2573CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 05:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2894810ED2C;
	Fri,  4 Feb 2022 05:27:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3448810ED28
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 05:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPZZnCI4R57kAofOGViMBwMvh2PvhsOAnM5VMy3aZxdRyVpPMgNiLG1AphV9B25Oq0HX7z61OPPRDbTCn/zDYPWM+r2ELcXPMsrgteTwA+hohLDXGKMrFPvh7LNWtQRrHtiDMjwthRcz0v8uIcSWJKRdTfBoUx3Qc5X+5bBpyyiCVj4JzW0IDIjlwgxDqzeKoXbwP8w+s1a8EkO0BATQfsfOX6KGzlCOyITvcJC5A0oCPCWM6617WZaWVXjz2XvsxoAFTg0Vr7IpUeqaB+EHjGYARZz7GGsYLhJ5EAeGNXGePGwxRahnjq0+j5LgRbh0BD+GH23ZtBQR+uFOdG3G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtQpcM9t0Wp+KLtFgMwGqZB8rpGdkYSGa8oHeFNe2+0=;
 b=QGpsRKRbzZbdh6jpPccnxP8NS30SB9SxZDe1sAt9CHmGAuE7hBCEr2bc+nLz2HQcG41Neu8SIwZp/y3F8DwmtRwd0qF4nDn/jEameV3jdW6VhaybUqkkUYo6nEm+5Ap1DGwVFPPm3pwWGfxoQiahZzhv1SBr0t1U2kYmaFaayEpGY6FTHQ6SI1F9Mz5AD4Ok1jFA35lLtk0m0eqdsk4I9OZPyDFgjmUhuG5ovOcvCPQ0SxOvtZPNhZdYk71EzRpKT5xwdcBE0qu3lX9uon5T3+SiU2BuSK8cpRz87pb3PaohYACWVBfCN7WfhEucw34BuORtneA1CUG8IiE1ACJcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtQpcM9t0Wp+KLtFgMwGqZB8rpGdkYSGa8oHeFNe2+0=;
 b=nCFSnX08wugyx94RMeym8hm5gTbmyrO7DbozR6hmjPxyrUhgHIPgV1xQxiRec5YDqjUNmHEz8Z25ddCTtd+xshGe5Uyw2GjZjZPZUj1ZgZPe1VhpW5zWmiiyh0ciEXLsw+ODn6rO41r5/EEFe5HWXhFLJKxOW+k80ssVRC4B4/E=
Received: from CO2PR05CA0106.namprd05.prod.outlook.com (2603:10b6:104:1::32)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 05:27:39 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::49) by CO2PR05CA0106.outlook.office365.com
 (2603:10b6:104:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 05:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 05:27:38 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 23:27:36 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 0/3] AMDGPU FRU fixes
Date: Fri, 4 Feb 2022 00:27:21 -0500
Message-ID: <20220204052724.469469-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac580f1-f075-4472-7191-08d9e79f0ef0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4976:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB497622404500CA3F9844672099299@DM6PR12MB4976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqnEaUVTJ1wEMADXdrBLXz0RJ/5VLRWBPwjR34m+sRWgs3EZlOyaVD4W/04eOoUOsuQOelKpyQLL6NR5jMSIGA6chOmSmDEQjfAoL4ThHyoiyQpGzMiC+QJbHgJicHNtPGwkLS+BFU/rKwVEjz3SLLNBevpVI+2xuTO6NtWLRmymds9SORuPK0H3IUEOWxrJrYsH5saI5LllUggBzhFVnNadDQknRNfazGWJwLO3w/LoGIVbhpOixDN5RTUjgIJqSxQNNFgg6oo7mqZuH5WauPcf4NY0WrbkQ4LfA2TIuFpzPJLT49QIw4+blvSwEx/Y88y4Cy6I6t/yONbJmAKg1jP1r0ihAfEObk5iJMmgii8KlpjMBFrMQyQIdV80tWzF5bNf0alE2HCQkvfFcBNMpv9XsRCH4CghNi9/ZfZ73P20p38aDB+XQmFWB9DBTvt9LbaxMPdk9OFxcILTzz8yKg80nKI9MxXvyLTVNgXEViJijoDNf3lNKoK2y5LN+eYLhn73NH2hdOTEPxUj1XN6nguFaMDwVmKH5DqnQtUK/fmHpS28a6ipEojUtNpfUwGyADoOCnhVfd8p2b2aJFoQEqwAu+R5kMLlVrCDvUs7q/AtrcqgjfpeBsAvydFLgXUvjvDGuYuoFFgxW5QQJNMegajwbG9orc9flBkMJ0IqBC1JEKyyQPROT7ST3v0pOpVUBWqdf+VE67WjCT9X+xA1aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(426003)(356005)(16526019)(1076003)(186003)(86362001)(83380400001)(336012)(36860700001)(82310400004)(26005)(47076005)(40460700003)(4744005)(7696005)(70586007)(70206006)(316002)(54906003)(6916009)(6666004)(5660300002)(36756003)(8676002)(2906002)(44832011)(508600001)(4326008)(8936002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 05:27:38.4216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac580f1-f075-4472-7191-08d9e79f0ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reordered the patches; fixed some bugs.

Luben Tuikov (3):
  drm/amdgpu: Nerf "buff" to "buf"
  drm/amdgpu: Don't offset by 2 in FRU EEPROM
  drm/amdgpu: Prevent random memory access in FRU code

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>

 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

base-commit: af42455918c42274f6f317a88c878d59c4564168
-- 
2.35.0.3.gb23dac905b

