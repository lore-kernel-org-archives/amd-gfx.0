Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732AC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D06207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WhpbvxWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D06207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083B86E4D0;
	Fri, 28 Aug 2020 16:06:06 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE816E4EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYqKJH9xAKf+RWxgYvr2U3mHZ6PSa8eC0Tc5/Bs6yhZIbZFztj8yUH5KTpCZ6HES+dY0rWzTm0fVVix1s1xpiULG71TS1bnCujo1ABZiGv8UpiAFbZ4PDjcK0VgTmjcnTyORTMhz2793QvUMOZqp1fMW7YlGDC+LqbT2oWRERzQDlKHjS+ioHA7mirMLcQ0cS57mm7h6tHjnNzDlzoAMDkZ3cwg1KORIQKP0ZfdH+EkkPY01MWLDZOTMg0AtnnxgmihWkz/NDVo8uKHx1IKnLEY9oZ/Glhfn7+J+JmQ/H6oj5TkaT40AWFyKj5UIovhTxSnnYmuXGrU/5jbDfddZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPSQP9zwV4RlyItPfMH97M6+K7PyiZsdkIHXC6F2DgU=;
 b=hm/KZpIQ8OwQXInuc1ddcrecuAhV/Si1lBSJHrionOON6EFxzwub0AKUTzWiVMIPHoPFzyLtVcsTY/ETujcxi1BFw91N544tn7FAkqq3hjCKxo6fPRPNamPd9C5HNtVNZPKQuCiEDRmzKzID3K3sQC6cCH4kH4UA+XBqklJc4XXBY9d2HDVALZfPUtPCtY7ZD50JtJ6XeZZlfI/Oh0ugB8wmb9sokIXQXLBHWEtQ4LOhO9eTZ/DxPXyO5yUdnJSm8SMbdRgRipjrJ6GNNEYwWmy+r33glsNwGH5hVyl7usyvMpMTCqVgsAndS5Lln/Ec1vtADpGXu8LeVfoKGhhwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=permerror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPSQP9zwV4RlyItPfMH97M6+K7PyiZsdkIHXC6F2DgU=;
 b=WhpbvxWW+cfwdxVhvqqlNnh4iiKg2Rl3QLvlwHb98tF1mj7Bda+ANyaURROij0qKbhUgKCNRjg5tRlziC5TGxaH6E8yj1R/V6l1fdipOrnqs1fu7NByOGeWogXmwBDRYhsrBn6+QhpQ93U+AipspxJDvRl6A7PM5jcDrPrAYkeQ=
Received: from MWHPR18CA0040.namprd18.prod.outlook.com (2603:10b6:320:31::26)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 16:05:55 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::e) by MWHPR18CA0040.outlook.office365.com
 (2603:10b6:320:31::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=permerror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:05:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:53 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:53 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:52 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/7] Implement PCI Error Recovery on Navi12
Date: Fri, 28 Aug 2020 12:05:36 -0400
Message-ID: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c406ad20-d839-46e8-a466-08d84b6c3dc4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258979100F9E2B294DF65E5EA520@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JE3OckpOx36//+bXjFCkA3t54KOACISlVRLqsI4HW4oM/MjWw1F5KY2x16wPj+E1vgvj/0jfe0sNn4ckMgbyYmrxwDV+3xNoGbmwb9S/KqE0ZOyGYKsEsqNoNk6X0OuSPxUiYpjhsAOJxE3J+FDwV4a1/+4O+ii2kOQxbkIOFQy3cSYVgvyVC8JIkTIqIhpMHFxtw/PNshW7GIsmNgklO5yqk//3ETE8042V2udQOWlr2YfVP+4jjxALht25wtKYmvBJtuG/aLvTlsbTOXuieMHS6QnTqB0NXkEl3CZBt95wlKsM6PLuZCpSEt9Aea50nT1+x8813RNMd5nL7mxTQuUt4l46etHK0tTebgZTBGhLIldzgwUkB7B7qE9vNOQA5Shss/hOrDvDfAoQhyQ3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(70586007)(8936002)(478600001)(70206006)(7696005)(83380400001)(6916009)(54906003)(6666004)(4326008)(44832011)(47076004)(36756003)(8676002)(316002)(186003)(336012)(2616005)(82310400002)(86362001)(63350400001)(81166007)(82740400003)(26005)(356005)(426003)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:05:53.6214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c406ad20-d839-46e8-a466-08d84b6c3dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Many PCI bus controllers are able to detect a variety of hardware PCI errors on the bus, 
such as parity errors on the data and address buses,  A typical action taken is to disconnect 
the affected device, halting all I/O to it. Typically, a reconnection mechanism is also offered, 
so that the affected PCI device(s) are reset and put back into working condition. 
In our case the reconnection mechanism is facilitated by kernel Downstream Port Containment (DPC) 
driver which will intercept the PCIe error, remove (isolate) the faulting device and reset the PCI 
link of the device after which it will call into PCIe recovery code of the PCI core. 
This code will call hooks which are implemented in this patchset where the error is 
first reported at which point we block the GPU scheduler, next DPC resets the 
PCI link which generates HW interrupt which is intercepted by SMU/PSP who 
start executing mode1 reset of the ASIC, next step is slot reset hook is called 
at which point we wait for ASIC reset to complete, restore PCI config space and run 
HW suspend/resume sequence to resinit the ASIC. 
Last hook called is resume normal operation at which point we will restart the GPU scheduler.

Andrey Grodzovsky (7):
  drm/amdgpu: Implement DPC recovery
  drm/amdgpu: Avoid accessing HW when suspending SW state
  drm/amdgpu: Block all job scheduling activity during DPC recovery
  drm/amdgpu: Fix SMU error failure
  drm/amdgpu: Fix consecutive DPC recovery failures.
  drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
  drm/amdgpu: Disable DPC for XGMI for now.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  16 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 296 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/atom.c          |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  18 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |   3 +
 11 files changed, 348 insertions(+), 22 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
