Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387BBC001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3232810E065;
	Tue, 15 Aug 2023 08:43:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8563210E065
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ0Cr/gb3HGioFk03V8xvwgb181hTAN01hyW6dScFGEhbf+2MvF1afMVP747XiZFn8a3/5LQ31GWdENrnf0isg1KEBpETr3IPYStEqN9fEJk5eoMXfO1PMKToxajNAAbsz5+rs9KqlFiIA7Oeo8MehiG1C4EpHFZwth8GMBlV55HzgPiaIzwTLqGNQjZ1Ih99Atq0mLUlMZBRpEgM5O81vdMrKAd9guZPADP+HWPGDjxIgqRUlMaOv7U/Y75F7zdmgjRgc/euEopVWYd5P0p0FrujPc8kfUBf7mOnJv+urwlJVGUmCRbL3DPIggwVgHaq7YNaDVqdLudLeWCwk3ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjyPWTA2fojGrk+8tSOyJWoUXDaB6wPTfDhTkEmWMBM=;
 b=I1XvGNwUZEEV21GXUN5I0fgdjr1PKRlt7KVIB2Guup84qFcFd2aCpf5Sw04qOP3ya9SFSUNKsrG/IXNn4XC8cVg3lqRy+bjlhP646BrGiV/tj2jSI/d5Ip2BdyrjJpUZNpKxjTKlZWOsurr24t8XupMgQoIWd776nv9DxIiLmvJ7NasYEdorwz+Dq5pfmVAmWx23R91xkwyLzgIFATT3/KQkwy3JUd37VM/C8kJrIHe6zNPHpZRiWjfOSq/0WD5UjI73AdGvGuFqGT+89R+n61qQoFZXJhOhDaW5KVapPwhf3D4V/RzJOFQHL1YjfETFLHan7IX5YzaM0PPD7GnfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjyPWTA2fojGrk+8tSOyJWoUXDaB6wPTfDhTkEmWMBM=;
 b=GtCSsiMcRdQk+LE9LrEwXwNg92NuIs98q6098PZfEsH0HABvCFPOBwHB3y2uXeT33PDDjF6CDwGOncK2HohpkFyVoFMH+WLywg+uji53SyRxPOYAF+OPcqLxfTxYXBixtBxVP0u8p6vwnkwanzmmqii7rbL+JKN5dAHrOJkDVsw=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:42:55 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c8) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 08:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:42:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:42:52 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] A new set of Linux OD interfaces
Date: Tue, 15 Aug 2023 16:42:23 +0800
Message-ID: <20230815084231.3229009-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 255e8ea3-904b-4155-ffba-08db9d6b9e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+FKf5O8Jwo9q55oXBQNWLR/KRTXS+JzavWunj0nMD2td2567GMeJLRotlqIX4KFDP9hsq2JIpmgMuUPBSGLh6diIL2WdbtW5AoxSSsZP5bSZLIqpK7KIUWmtTopCSCRQOkovdGyFcVwgUlKljo15t7BvRMAb3D4XjJuuwSqUSNg/w6QK58flLOao7hFw81KwL4mC0r6syNkyXzhKGzW41C0bWpyPLThYJh5TwJFxXpJLOqki3LWbY8IlqqCoppS70kiyD7LfoAPj9FzXQveX6cTspGJpfnxqTzBIAFrmu/6CuaHtPXpxpPFTcoBqtYCY/Ze73yApMchqB7H1imJ+BXhElDZ8BLT1FdPGas4FOexMg1xqR3Vxp2XhTFhZzX/5q1ddKJVSYy3eRZ0fZz2yxDGW8ju5wS0oq2i8LJ2KH1vqa7q/wtKcOQWvLg7pdhgoJ96eHPlyeXdcLuIBWBAayQ8IMQIH0cpL/c6TwwVZg8OXr4QUC+fUycRppEFopUf0rf1vg0gang0va43x1fcypIVeBJl0T5/rOZWGKgN/AVFIQ+DFoOmZM1LkVkNzDYKDVAi0F/KMYsyKOH0J35PFS2Lf3Fywdw/eJ7ODpL1UvRDzH0NasRu24kVf3bwEsc2qvFGkdl8Vc95oKQ9ARG3O24mgNUbW5JKQx2d+N3DNHnn4iGimoGkqF3HW2aaGxhEchY+EF64J+lLXtJ8tyY4G8GVeZL9EqXEUVBSvdfkGK2lOhJlX0jlg5QzeFCYtZROXp8H5Ivj8vXleNQkFdx8kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(36840700001)(40470700004)(46966006)(40480700001)(54906003)(7696005)(6666004)(478600001)(40460700003)(81166007)(356005)(82740400003)(44832011)(2906002)(5660300002)(36756003)(86362001)(4326008)(6916009)(70586007)(70206006)(41300700001)(336012)(8936002)(8676002)(316002)(16526019)(1076003)(26005)(36860700001)(83380400001)(47076005)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:42:54.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255e8ea3-904b-4155-ffba-08db9d6b9e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing OD interface `pp_od_clk_voltage` is unable to meet the growing
demands for more OD functionalities. Since the buf used within it comes with
size limit as one page. With more OD functionalities added, we will hit that
limit soon.

To better meet the growing demainds, a new set of OD interfaces are designed.
With this new design, there will be multiple interfaces exposed with each
representing a single OD functionality. And all those interfaces will be
arranged in a tree liked hierarchy as below. Meanwhile all functionalities
for the same component will be arranged under the same directory.

gpu_od/
├── fan_ctrl
    ├── acoustic_limit_rpm_threshold
    ├── acoustic_target_rpm_threshold
    ├── fan_curve
    ├── fan_minimum_pwm
    ├── fan_mode
    ├── fan_target_temperature
...
...(more to be added)


Evan Quan (8):
  drm/amd/pm: introduce a new set of OD interfaces
  drm/amdgpu: revise the device initialization sequences
  drm/amd/pm: add fan mode OD setting support for SMU13
  drm/amd/pm: add fan temperature/pwm curve OD setting support for SMU13
  drm/amd/pm: add fan acoustic limit OD setting support for SMU13
  drm/amd/pm: add fan acoustic target OD setting support for SMU13
  drm/amd/pm: add fan target temperature OD setting support for SMU13
  drm/amd/pm: add fan minimum pwm OD setting support for SMU13

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  39 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  14 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 676 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  16 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   6 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 316 +++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 316 +++++++-
 8 files changed, 1370 insertions(+), 25 deletions(-)

-- 
2.34.1

