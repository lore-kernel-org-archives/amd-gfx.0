Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD4C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C056710E14C;
	Wed,  3 Jan 2024 08:03:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD85310E14C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmDlmw2VHAwthYFjfKLXexRyzGdV8xHAwL8ntd/Tb/RJ1UBl6cguG2XjSVvAyAPmx0GaGvysij+7Wx9DNaH+AugmT109jL4MZAmjUbF0Dh+Svdlxh2x34E3RRSSNb1WYZaDAdS+TberTWKyJA8pE8Pl6GUR7FqtOfWPdD/h4U4Ly1wmIggZJQV1sY96x3pu64zZLt4ZeB5fRtyTpf4DkjM1UaENUdPG3VDNk/Vs00If7OHdeXXvB+DYXLdjuCF3h3QifwV+jNrKmHDIeUXkvLWUkKgdkpGyWMarWBMNGD288f3mP5EPpFbKAsbD+o7mMsiihRRfDkWiI6RIWqzu7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdbx+U+wnsVJnfIRmhOlbbv4zLfw5C8wFaHWr77JkyQ=;
 b=I5s29MTdGrTs/3SFsGF5AUq39dvjiA1QqiOxgZxNf7JMEx2AzCtoBskf3bAExtY9ajHiRkSnlDOKEIUXsVPBbHZrdFbpOMx2yxIjj8WeRO9wZ6XMd/vuMdukU+NGW+EI6m470COur/SvW7nOYZ0LwMzydoFL+CH12Etlx7cTEBoHZiLdQxPvzyQn2HDqaf8CASeFSUHQGm2GO1/2KICwhhtR7ryEbTBp10KLYhMSYD70g3jRPKHiDXzGJmSIH0RgmaaCyoFboJxd/FYGw3cX/ps8PXRuixC8+qs5sec0fr3tvKWIq/wCwyv+XFqzkneIrt0BFl9lwXAdFPE31ROQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdbx+U+wnsVJnfIRmhOlbbv4zLfw5C8wFaHWr77JkyQ=;
 b=xzsdkVkQBVMht77Zoo04A72nih2rc48EvyXgORDRoqRgaKomML8QMVno4vSEx2NLch8/9u+XAQfuTzkcLbOtEBNlv6pDklJiltysqQ4e+me+Bmi7uqEPRVaQUf4e8BLYZOZhZ6gTtq8tcUpwy6p991OmXHOG80tKXeHyX+BoBJY=
Received: from BYAPR07CA0006.namprd07.prod.outlook.com (2603:10b6:a02:bc::19)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:03:07 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::22) by BYAPR07CA0006.outlook.office365.com
 (2603:10b6:a02:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:06 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:02 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] implement new RAS ACA driver
Date: Wed, 3 Jan 2024 16:02:06 +0800
Message-ID: <20240103080220.2815115-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM6PR12MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: c163b2dc-19df-4f3c-5b6a-08dc0c326b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6dfSgHciU6XgmDypawLcK5eh26IA8Ud2yL/OuDUZzolE/6ab4QbxjxYfplPCv+RGS86t5zaJ/dvPDtJQaRSsc4pzTpaixNj2shKg9aCjYtUEInWZRYyA/aXnb7DxKqgHh96vDnY16UwNMfsRCcuXPbYoJvOokgXQ8rZG3WOnG7psqPUX/0awzMTApx9otMymBupIExNwEsjxxkrqD5EfSqu53qFx5sOI/E79Z5JZ3YaA7pfTwch/0ST5vjM5q2XNCCejSTbRz+RTcrOrTaA1hcnJB2MpI86RtnIfpkbNR8sKhxZFDMOD6o70N5uRgoJThX1WJlJf0kAhnr6jRqjOIl+ruuTzCTW0YhEUPil1JMXGP6lznZv9BCMderzNqffEchVnAd6DaenoeIXKatvN3ECBsBYCFvJ1F33AIuzQtTXOrIZzUVYAZhTh5c7XD0uFUsEJp0fkg/An+jtbwHR0UV68OlZE/jFTWqCNVBWvHwOv0jhjI3LUt0OCZ2QItGXJY/M1v9rvCpJF06ZkKPsDTc6Shc3LlfWXRMo2galHOAJHfz/MlYMYTvgsT9lP3H//OPdTfBowC8iw8l+9XFlx9ywoH8usfSFU+9bBk4NisaGaeGJoTKy5RvgUd9jmoqHiAew5SDB715dFaFvgXMPrMPBidrgZeuB66/3cfybNem60YrDatQopVKbqfOFOuWzzUGF997lSorqDSITv3glQLQ03meHED/lqkXpCk3640XKYKh3nE8e1NwD15MuwptPjA2XvLiBhGy5MbsQs4ggiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(426003)(1076003)(26005)(336012)(2616005)(16526019)(36860700001)(81166007)(356005)(82740400003)(83380400001)(70586007)(70206006)(47076005)(36756003)(316002)(6916009)(54906003)(478600001)(86362001)(5660300002)(2906002)(8676002)(8936002)(4326008)(40460700003)(40480700001)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:06.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c163b2dc-19df-4f3c-5b6a-08dc0c326b60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following set of patches is the code used to implement ACA driver,
and its purpose is to replace the existing leagacy MCA/RAS driver code.

Yang Wang (14):
  drm/amdgpu: implement RAS ACA driver framework
  drm/amdgpu: add ACA kernel hardware error log support
  drm/amdgpu: add ACA bank dump debugfs support
  drm/amd/pm: add aca smu backend support for smu v13.0.6
  drm/amdgpu: add amdgpu ras aca query interface
  drm/amdgpu: add aca sysfs support
  drm/amdgpu: add umc v12.0 ACA support
  drm/amdgpu: add gfx v9.4.3 ACA support
  drm/amdgpu: add sdma v4.4.2 ACA support
  drm/amdgpu: add mmhub v1.8 ACA support
  drm/amdgpu: add xgmi v6.4.0 ACA support
  drm/amdgpu: replace MCA macro with ACA for XGMI
  drm/amd/pm: remove unused mca_smu_funcs
  drm/amdgpu: remove unused smu mca smu driver

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       | 857 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       | 200 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       | 360 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       | 114 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 105 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  83 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  85 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |  87 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  80 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        |  65 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 470 ++--------
 15 files changed, 1603 insertions(+), 930 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

-- 
2.34.1

