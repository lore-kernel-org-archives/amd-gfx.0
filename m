Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE774C6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 05:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E4B10E043;
	Wed, 22 Mar 2023 05:48:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81DE10E043
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 05:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0l20YAIljhqmXYBWvo3yEh2ZmgU1gTlkIl/BGaPXrfx6xqUcQ0NXx7QgJB8FsjPDTqSVIYzYFqWJnHbeXYbSdqWEuI3xJqfDavH34amQgGXXkXCybLplZL8t+pDGvXmfWYqQkyglQUuvmU/CYmQ0LmM1uuK04Yq9uKuh2/tYnBX42TlgRufF9SnMdTEH3RlPO1wmeme9BmVDmOMgMLCTqiT1he4+qQQUvuglV6ShhDe3bXR/Zg4MThD3wmIn65a3IlkLTHrkKmiIUYnhM7w2eaMg51jMwGUQRHRFLqYHnQzx98/bHsu4YiKRirtY/ErTAz3njPeVHlKxUziQ7MHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwPeyXsRwXHEYtdWtfT4GLlU2E4H2e8F6pKL4yx+Ee0=;
 b=db+QMn+EsgrBmSbfbwiENjxTkko3C0goc+jgdKouzfXAxdc5X+7tf008eqHSVaMCCjIQjQW1BX2hByv2tjA4qD4XzrwL/5VjCX2swgMr2uCtrA95ntmowYDc0fuJ07stzaPP47JqlDpfHEG2+VXUU5UcONovLtPHIrpm6o/+29W50J23jVFhan6qdGLzLUmohuSOww/8KxTT2UDmFzZNTTO3eX6rTBVjybP40P2OQs46QBLKC3CsWTQcOj2AgCbGy3M4DV3k9NaEBJRqhDbYANrK4Hc/ub0j5Z+m7x5fQFYSDl2jkcsYiDNhuUms50VB4XJsZrU4Ju6hswN4c921NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwPeyXsRwXHEYtdWtfT4GLlU2E4H2e8F6pKL4yx+Ee0=;
 b=eQ2uDZXej57omMlps/FBRfkuK9Hnx7+1mIJJVFCluGgFwAR3mpCCcluxG5Joql14DWizvzMLpt7NckAbNa3pOkdXBN2fCiBcS027+017Ju4Pvejm1Qs9hw5DAwdX3MnB86hCwojQQJmIo5npvuL4d01bSCfXffj2WCWIcFR2t7I=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:48:12 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::50) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 05:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 05:48:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 00:48:10 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 00:48:09 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [PATCH v1 0/3] send message to pmfw when SMT changes
Date: Wed, 22 Mar 2023 13:48:05 +0800
Message-ID: <20230322054808.1555230-1-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 900f4717-c373-47f8-837c-08db2a9905ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btOOGDcRbiuwb9L7f1SGCfAbLNjV/UutX5+IMN7XwbWyzihAhlmjCKYmladGzZP9i0KdgGcpVYY3pyjUDVHG9YagnV97G9pLfVP0y+V8BGsIfzxv0CTaYQYjIpi5eMArTOpM5Jqac/IMfIxwEW75dCedambiuXCu4l6g873V/Go8D5l5Fx/98SJY8uOjk4Nt3V90la6g/PiAkgYVOM0PWAmxCLmN90/cI4/kYdpbdI33+IZvv/DahlqOsU6eqNnv4IMCXr6HLpv26x7g91e1r0TA/8ErMoNL7zzdQSqylbmVuc0j5tP3vNvSKhpnS8EsHC5JFMZGRxv4p6KGjMRkO6QzmGc16Svns3vd+Xdt2NylMQuATDWtpByJif0XqKTVznBvCtRey9G7TbJDrnxWFr+DwrykKvQPfPQKUuFkb7E9eT8VMC8KmsWPnQRpLWEVIhz/haqP99Ite0FbypQAnqAlPI2yLM+XUeQ/VTIjmKTKJd0GggnE6f755iLED/EpK11P+7HLNtiLBNMOCB8MtsiaDgQZf4TyzoK9lv7sh/ocliKsg+ZmJrThnEoeh+m0l2BG09QrXdrQW1H46ZnKpQfpf0iQPonZ0v1s/AmJio8EFuyWIKPG2K8NCpp1KTri7ml9IrvhkGRhutPEk86OBPRS1dvHRz95XP8ctYxauR3XCVpj3NbCBnsyIpt9xvi68dCN1agFGbLIV1/u3LyuaWsvJcAWO+H86vC/AGBaKBU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(110136005)(336012)(2616005)(26005)(1076003)(6666004)(426003)(47076005)(4326008)(316002)(70206006)(83380400001)(54906003)(186003)(70586007)(478600001)(8676002)(6636002)(8936002)(4744005)(5660300002)(2906002)(15650500001)(36860700001)(81166007)(41300700001)(82740400003)(356005)(7696005)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:48:11.5961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f4717-c373-47f8-837c-08db2a9905ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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
Cc: Wenyou Yang <WenYou.Yang@amd.com>, ying.li@amd.com, kunliu13@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU SMT changes on the fly, send the message to pmfw
to notify the SMT status changed.

Wenyou Yang (3):
  cpu/smt: add a notifier to notify the SMT changes
  drm/amd/pm: send the SMT-enable message to pmfw
  drm/amd/pm: vangogh: support to send SMT enable message

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++++++
 include/linux/cpu.h                           |  5 +++
 kernel/cpu.c                                  | 11 ++++-
 7 files changed, 84 insertions(+), 3 deletions(-)

-- 
2.39.2

