Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC28FC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5284520719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CItGnaEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5284520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6D389A32;
	Mon, 31 Aug 2020 15:50:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE1B89A32
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVusaWlsOPET1gG+fs3P/w7xSTI+wGM+Khu5JVIwRNbiID7QCR2g5TRkk1XwAwrCH+NbOi8vCIOSTflOOsb8jwU2JuaC2e9/ui8wpzyB1NaZL+KalwHkP2O9lOOhb6Iyc0XPcERIVIsqggoxguE8Ueya83vg7He8AQElrypiTn/OkS7OWrwJFuvcQEiGOunKX9EfPnA8A3eeobKEPV2QSepPpyW5EParG3ktSLa7WLZ6juy7/CmoEfWDrLE2aVTZRlyFB9PSAHJPLB68db22yzzoe2IcPxNbL9HpwO0RVuBwQbqSpKq79E2jURY2H4DxCjB5g8jZA+wS1YUzIZGnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H1rB+lUR9gIRjGIfzy4Of4YQCwbOkYJol8Lo2GsFPk=;
 b=kr4iDolGPrnGUUbvBgxgD+4Q2ia66Lpr3olVE+U2RQ8AvVfptkIKcAKeMtCJY0fVFE3et5JZZO218cAvINHs/3Zxy9ov7uA/USIZ7yUOXqH/Rb++VMrksq/WJoMkfMeNxZHIuS9MEKWNqEWM7xpZ1IPxK9PykTldS+uKjLhlWE/E0nCVhEzLDpir3quAPTAPMLnxjbYmE73MFkRt6KGpCC9v87wUXOISR6WgnJUEsmlnDhrq1wLZaOuzjPuw9fq9mlDp40JOLIy3nhbdIOgY7SBWYteqAXMB3bgGJZfSF9i+U8n6NzsT4OiVUjiG1WfwBjpjHNJB/73FTK5Zmg+vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H1rB+lUR9gIRjGIfzy4Of4YQCwbOkYJol8Lo2GsFPk=;
 b=CItGnaEbU4Why6ywL9waae1GsZAn9qwSKvAtrNIrrirG/vWu7/vd4xTeQOcjYtXbpVShsIWqiKKVHoIj+l/6GOVXgMpt7S0PPiHmwwLyL7O7hB3HPWlZy64uNoxEcza+J6jGDGtbP2ATKOgwq9icvuA+9+WRKLbawRi79Isr74M=
Received: from MWHPR14CA0068.namprd14.prod.outlook.com (2603:10b6:300:81::30)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 15:50:56 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::f9) by MWHPR14CA0068.outlook.office365.com
 (2603:10b6:300:81::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:50:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:55 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:55 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:50:54 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/8] Implement PCI Error Recovery on Navi12
Date: Mon, 31 Aug 2020 11:50:41 -0400
Message-ID: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e890d3b3-1724-44e4-0532-08d84dc5a645
X-MS-TrafficTypeDiagnostic: MW3PR12MB4363:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4363C2759EE1DAC9BD153DEEEA510@MW3PR12MB4363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtvQiLxsa4Gy/DtJ6zrW7sSp0h5ICcCjSP2OoTBD5NxSqYdXSKNE3AYMQ+DYJXiPvCzOQC5hH9jhWAoz0KwhEysSOwfgocc5LQ1Y5g32fGaZiGJBvrY1MeECAdoorRQoN7rqUktPxbpeUp45IWoQtcmCdz3Dm2wUwlDz7Q8ei7hXlZxvGSbboGul3fs2Pp3oZA8hHNWMdqk87tg8ZaBaUrt6nBczER2eV7Y65O6578gmNfXT3uqFxGRd3t09KOGzdvIyVbwmf3ZXzbg2XUtEwR9Q23D/BX6IQeyoMe09nPIf8f4vzyWQbT6ltm6PK3fPULqzzgvBV+Ke2rqI+zFeR2h8tleTFCEhuurbwdHAHcsiZcrVUv1fFCIIaUFSEJrsCmiGw06ljXF8e93WPkFuvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(2906002)(86362001)(54906003)(6666004)(478600001)(5660300002)(82740400003)(186003)(336012)(47076004)(26005)(316002)(82310400002)(7696005)(83380400001)(4326008)(6916009)(81166007)(8936002)(44832011)(356005)(426003)(2616005)(36756003)(8676002)(70206006)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:50:56.4763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e890d3b3-1724-44e4-0532-08d84dc5a645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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
driver which will intercept the PCIe error, remove (isolate) the faulting device after which it 
will call into PCIe recovery code of the PCI core. 
This code will call hooks which are implemented in this patchset where the error is 
first reported at which point we block the GPU scheduler, next DPC resets the 
PCI link which generates HW interrupt which is intercepted by SMU/PSP who 
start executing mode1 reset of the ASIC, next step is slot reset hook is called 
at which point we wait for ASIC reset to complete, restore PCI config space and run 
HW suspend/resume sequence to resinit the ASIC. 
Last hook called is resume normal operation at which point we will restart the GPU scheduler.

Andrey Grodzovsky (8):
  drm/amdgpu: Implement DPC recovery
  drm/amdgpu: Avoid accessing HW when suspending SW state
  drm/amdgpu: Block all job scheduling activity during DPC recovery
  drm/amdgpu: Fix SMU error failure
  drm/amdgpu: Fix consecutive DPC recovery failures.
  drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
  drm/amdgpu: Disable DPC for XGMI for now.
  drm/amdgpu: Minor checkpatch fix

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  16 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 298 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  18 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |   3 +
 9 files changed, 346 insertions(+), 22 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
