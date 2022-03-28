Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD0BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F130110E5D4;
	Mon, 28 Mar 2022 06:25:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2495F10E5D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK/JG+I8fL2OmpuwJYOxBePEWrfjWKtF91jNjZUrFVbMESlKNhAbux0DMB+NMhAALN/F6PFwj7Qalz6HQI8X2Rl6irlWhSlhxVKOdyPi4a9rGmCNPMjKU029tMvL6kOzX59cMnt+GZCvVRD58IGjbI45gYld3XTCU8KSQPocQhasGgJdLftFRPG3FETeWBgN/I9xPMCXYBNmMMhyvWF/u2jKo7cyGf7keITeqLL9o9M6fcmVul0n3QUqjEgN3Fqd5TjClkZAGaMoSxsYFmOe1/30OYwcFaFX6TKYaWKVTtuKcRFPDWbrlWr6iqyqnENDv4yzrWBg23mypSm55PMRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CLGv7vsCa8xvJSRNqL7jiU5VuTsHJHF0OZVUoNVuek=;
 b=biS51TNNyba1+p2knWgFsZCU3KcDVseo7mZsoa5zryONCKoYg1dL4WxZeboQKkdN4CHQ94x3ELUDpd3dwL3wqFPxfSDvRfF28emo3ohnrO+7pSJI1d5F6Zv7k0O9Y9iAPU3EUOvwKaOLPJPGOZQVi8knn/qp7er/9uvcIngN8Up2Eyfo/0hzLcSCzrmNrE6WUFfbyXRknhiy2IzVJn6qwteIpFjVS6oVKGRXRDAJ/u7lCICpxehLQiWrPR3nIu3LvX4jaTEwAr3yVld5Fi34GLz3zHFfvY+Yr3htqq872Tcg5aVrTzXkLPnbvWEQzsbcD/x5RZFwxXE1xY78d8WUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CLGv7vsCa8xvJSRNqL7jiU5VuTsHJHF0OZVUoNVuek=;
 b=TNba62HMz5BLgy5JQRRPmdEMgoWSZZBz7NVin75uX887lsFV/JvbpzyCYy4+m3eUkRRXKjKZUhM99HDEFWSGMSJ3h18UyUbPEfWzj4sOGkewlDhzbZUxguAS6mOYoAxJFuzeFp3G2Pu+8DDSiuVRdrwfklxinBX9ulKL0TrFYzA=
Received: from DM5PR21CA0031.namprd21.prod.outlook.com (2603:10b6:3:ed::17) by
 DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Mon, 28 Mar 2022 06:25:14 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::77) by DM5PR21CA0031.outlook.office365.com
 (2603:10b6:3:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:13 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:10 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 0/6] VCN and JPEG RAS poison detection
Date: Mon, 28 Mar 2022 14:24:47 +0800
Message-ID: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ea9dce-3f07-430c-7f29-08da1083b7bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4879:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4879F822040B76CFED745BD0981D9@DM6PR12MB4879.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1AvmjqXVazSlD5An76WCxkQx8CTiyDSxQUu9UAc1sEsCFnCa69CfF/xIr7S2mf+rCnjfRnbBuOVtpVpsA2Zb+z8GNR8WglTacUocftq8zRPmMJNSPdNzJYnSq1PfE4EoHsbvx+GoD/ImAqonFIjak9owXVyUYJcoCUGxeODjuf7KPg1+9O64vlcorRjCM6dQLbIDKn2XXBVskb/B+BUlqEJY+kilLsSWU6lNLXINndKr/ya04XKbQvqlyoQZBhnnsVtAilR8wMbB9XLHnud5tTvpeP6q/c6wjNgmmZwhp/RqpWSFUEBIeEWylK6pezA/wLnu/k9OQ62KkQPY8BP3s5Rh4kPgHtjzZlBpDu4jzgUG+zcnvnc6y1+RVy7aXA5QUnTKh5rW8QbtBPg5HuHCdCEssKPqFmi9Uuo6TFHwFAI4RnM/MkVOjYlE8xPK1xjKC42ednQfFjPyIoXuFFkA/uIkS+nPd1K//VLKFmIiWEkbGqCcH7bCssDbvAgvgw0hkWMnRYbQiwAa8YBvryICydiiH6osctiQPVzo45RFQgKZtN1dRMGRBfe5Z/jRAzsU+TxtC9rvDop9771CNr+j6oSwJZ+mGfKEgkXHHaZ8Pw6JrTZzB50twPes9b8oTIk1JCkKcvaMlM2oURvrWV5G3iPdJKbeBib8Yh1pvl9NOe5wYe2Bdb4ucR9DSK4pQDdYS/4IgrslHrHdvweRN8q9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(6916009)(82310400004)(336012)(2906002)(356005)(36756003)(83380400001)(7696005)(8936002)(81166007)(5660300002)(40460700003)(2616005)(36860700001)(6666004)(8676002)(47076005)(316002)(70206006)(70586007)(26005)(508600001)(4326008)(1076003)(426003)(16526019)(186003)(4744005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:13.4687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea9dce-3f07-430c-7f29-08da1083b7bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN and JPEG RAS poison detection

Mohammad Zafar Ziya (6):
  drm/amdgpu: Add vcn and jpeg ras support flag
  drm/amdgpu/vcn: Add vcn ras support
  drm/amdgpu/jpeg: Add jpeg block ras support
  drm/amdgpu/vcn: vcn and jpeg ver 2.6 ras register definition
  drm/amdgpu/vcn: VCN ras error query support
  drm/amdgpu/jpeg: jpeg ras error query support

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h      |  8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       | 10 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 74 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h        |  7 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 71 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h         |  6 ++
 .../amd/include/asic_reg/vcn/vcn_2_5_offset.h | 13 ++++
 .../include/asic_reg/vcn/vcn_2_5_sh_mask.h    | 24 ++++++
 10 files changed, 225 insertions(+)

-- 
2.25.1

