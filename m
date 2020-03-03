Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3F4C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ED8208C3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sDT5JwSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED8208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20FE6E59F;
	Tue,  3 Mar 2020 21:54:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6835D6E59F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z06kxQCQyp85zHU9fyMp+Avqu+7gTkkStwbnJgrhgCdBVHIRF2N9H6XP28N8zZi2C6IisWtcegK/v5DczBlfxHnBdjYj6RqtraHS7g+LQeQ68X5YygjxwYrMaWrxb5fD9OGbt6dff2GIREluphqEAV4vGb1hoEpuBpQLXogYCrNPHbOzIr3NF6BkDP7pcCLNJBwAYaRmu/g3bXZwfDaMXZzufux8BGEnpa8h8bxA1iZex/46zukOacAYBfF5MpfeAEsBT6z5+QQK7gR8DAShhRo7lZf94iJaLdb+68ZEztOhPGWD54xH5BHQJXLZvMkbxWnvlQSVOnQJrI8xu6CNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vczyTbbFCELqE93J9UIW4OkmgFpDurqrVK9InoxQQF8=;
 b=Srd8ESbkB77iZRFAN/bMpBhYn9avT6Oi/H5sLxpec1AucDyRlp5wYWkEsqqprWRIuUjVuVCmXGSwciPJGB9VY9SBcVbh9zq1D6haVRsT/WHGyr7P4dhb7Y7txsrntnEoeXImg57drN+aL5U62s8HWjJm5K0ehQuoCgLm6AtvOxjddBPCbseZlRIgeUT2UvhM/hbtNGp+tkY+OV8erJojoyYlhL47bA7rFcpkRx+pyw6mC+1y+DJ++iOc21DiIt0KDWnHIlcFtway0FrqjNQE7NDO/aWnPZS3IfDtcnJVyNgZwFFUnfRNS/RTqBhWjczDHLERy0GWWFlnZvH3lEqoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vczyTbbFCELqE93J9UIW4OkmgFpDurqrVK9InoxQQF8=;
 b=sDT5JwSmeKhbb50FYcDpfebWHyrAmyrI2b7JgLy9zZ/qO3F0fFb0BzUOx0+0GOG01SJyCJZ7kWB9zww/DjlkyTBRJIV4rRZ/A8S/IYTHzdYEf/ti2utCjxJSyOnqIkcGq0Urwb0+25HxqGu+bXg0KsYkkanZdZfyixPIVZtmv9I=
Received: from MWHPR17CA0089.namprd17.prod.outlook.com (2603:10b6:300:c2::27)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 21:54:31 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::8b) by MWHPR17CA0089.outlook.office365.com
 (2603:10b6:300:c2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Tue, 3 Mar 2020 21:54:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 21:54:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:29 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:29 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 15:54:29 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Add support for USBC PD FW download
Date: Tue, 3 Mar 2020 16:54:24 -0500
Message-ID: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(428003)(199004)(189003)(5660300002)(54906003)(316002)(26005)(70586007)(186003)(426003)(336012)(6666004)(44832011)(70206006)(4326008)(356004)(2616005)(81156014)(81166006)(8936002)(8676002)(2906002)(7696005)(4744005)(36756003)(478600001)(6916009)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4287; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52ce4d2-8ad3-4a42-27c3-08d7bfbd73d8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42871EC8FCAB0A33CD616ECDEAE40@MN2PR12MB4287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xb6dZcfvzJg7xEKBu0OYfTSiGhXRXnMNl32l+2TsR3JFRjvGBLJQh6DojbyR3DetcljvDVUqU+ZLcjJULXYokYKxK7xtP79XeCidohxv/sHBniJ39eCeDtoJXB/hjo451Pzi4G+TXjyizYJUqv6Zei223j6LyChTMZuvFQn02Qn5JBcPmF6RV/uGmacxtcYO9FJn/zhKYCERE36kmi0lr733Gm1EZ+RgJO1Fq8ABXpZ+R1Qe0PMlXYJ4rm1kp2b3wVRQjstJvkUoZLqXtahAI+P1P6tYRdhc7YLvJtXDL38ICUiMZ7HIrtH34NeXMYFZS5GV9vbamKr0n4DC1eAsBOw2GaYXzhO9FgZmUgtl5H2XuNtxueoCnuI/Aa5woK1LkXBcq271eLq8LXbewooWczNpFq2EpDjYTh1jKKiB+GwshSN9JDPvt8LqYh8gcOJR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 21:54:30.7885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52ce4d2-8ad3-4a42-27c3-08d7bfbd73d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset adds the kernel driver part of supporting USBC power delivery
firmware downloading to USBC chip on the ASIC. The FW is placed in DMA buffer
visible to PSP which then proceeds and copies the FW over I2C to the USBC chip.

Andrey Grodzovsky (3):
  drm/amdgpu: Add USBC PD FW load interface to PSP.
  drm/amdgpu: Add USBC PD FW load to PSP 11
  drm/amdgpu: Add support for USBC PD FW download

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 110 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  10 +++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |   3 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  |  82 ++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
