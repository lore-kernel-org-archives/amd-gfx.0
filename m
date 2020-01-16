Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B4AC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379AC2072E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QIsNf+JV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379AC2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4A589228;
	Thu, 16 Jan 2020 20:30:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C101F8911D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDw2B1D8YKqBL6O0AM3H847mr3yYbrNPFfErmulIbPFkYlk6FdafVdEZwoKYSVgr+aZX0OCXz7DRYUmpW/Atgw2ZYwHiRnQey8nT7ccgwtjDBG7wNi7VCbzY7Ho2wDAR0f/iff13BkPNGN4Bep7FSLaLfNnG9P0I4zfLNlHZWRO6yzy15OBBwYvhJCC1LJicLccuo20PRcYiHKsZf3HaFPZFxvd/pDWDwpYl6wgRioBqAFIXGwq6WwM8Vr+Z2hvgOvOPjoucbV2+EJF0zH8e5k7ygnZvGFsGdkq90h4ZJek3mCcfnzBkHRh1NiLhF8euc6z1mKyp6OQrmpn+GfYuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvQr6xdUDyBdPc02+2cyht2Pmh9vwvfBsaXmMJgVLgw=;
 b=A8y86k8GcvmXObR0L0d6ec8g5WvJFms0PI6CALw6XIFHxks+c7m1z82d2vwt3SjiF7gqabMdia3bA+blqELv1eUntalqNIByFRE7KbUO0eICocULrxCWPknibEFDlZZsXJ/SFZpXXQT2lH3fmUj6piiNlFfGdGshhAwXAWBWmSiKhBplLx+TD2jh3dUj4iRWLiaERhGa+cA42lA1+k/aNX1BN/570yLvJfrehSO9fY7HPPBrKbIC1dLxa0XY+wKgDTsluHpkTOaO1Swoo9VBMEP/tyztt/PUzDNdyTR8Q6y1M6EqCjGd96krDY891zyUraXKEkdOFXZgaJwajO0QIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvQr6xdUDyBdPc02+2cyht2Pmh9vwvfBsaXmMJgVLgw=;
 b=QIsNf+JVNyNoTIuergzHzjpxibj8SgBqx7y0OP3YJZvw7Dizj6PPdhChuUpblXeTnM7c2M0OuAHTciJYPiK4ck4/hMD/ONruCbOWKzSBjmSiglONGcnyqq3apLsaGxQ/mwlDWkKaAIhogrIWYRxwShVnh3x+0DyqipaJNHTYIjs=
Received: from SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15)
 by MN2PR12MB3470.namprd12.prod.outlook.com (2603:10b6:208:d0::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 16 Jan
 2020 20:30:10 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by SN1PR12CA0044.outlook.office365.com
 (2603:10b6:802:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Thu, 16 Jan 2020 20:30:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:30:09 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:07 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:30:06 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] HDCP SRM interface
Date: Thu, 16 Jan 2020 15:29:40 -0500
Message-ID: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(428003)(199004)(189003)(316002)(54906003)(4744005)(70586007)(26005)(36756003)(70206006)(6666004)(478600001)(81166006)(2616005)(81156014)(4326008)(6916009)(356004)(336012)(8676002)(86362001)(186003)(1076003)(2906002)(8936002)(7696005)(5660300002)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3470; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022b88a6-5f2b-4a70-c26a-08d79ac2e17c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3470:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3470E5362C8BE30E4485CCC8F9360@MN2PR12MB3470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrqcRMzyZeiFnMOEUcJ08gcpyUtGqXQZjoQuEwOaAodRrPZ/jiwS6sjwzMNb/WNILJVYCtZuiNYEJGeaxTy45uzhp+nPXjPOKArxw3OuP1OJ/ISASkxxkHzK31zMYXBU9Wd5cbqmiD29KRlRxd7d/T7u+Tui5/O/2bW+ABMbjzKq/b+B9Pys+AD9ihfQo85j5HZxvJAJoq8RCXrBtNX9upOGJIi7M/Vu+g83/OMKdqlVds8nrbTzdlnHQAJgZWo2jn6Cr6v5E8rF5jxe4Yi7ByxkLRmVziFBcEywfkdCoRPGhDjbxnfUoDGwZhJDBiRb8USoo1pBnWblWtdO4b0BPBoOHeslOQaCkXrMwsOs2yMYTlcUH16WqgTzAQkhbVEALkBUwpbXJ1aVzD/7RnhT/VKlMPgCJVaXklZ+KMja1c7Rqiw9vTZ8zqsXlweCXOj9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:30:09.2023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022b88a6-5f2b-4a70-c26a-08d79ac2e17c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3470
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These patches adds support for SRM loading. By providing an interface to the
usermode

SRM has to be persistent and since the kernel cannot directly write to system
storage we need to provide an interface so that the usermode can do it for us


Bhawanpreet Lakha (5):
  drm/amd/display: Pass amdgpu_device instead of psp_context
  drm/amd/display: update psp interface header
  drm/amd/display: Add sysfs interface for set/get srm
  drm/amd/display: Load srm before enabling HDCP
  drm/amd/display: call psp set/get interfaces

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 182 +++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   9 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |  26 ++-
 4 files changed, 212 insertions(+), 7 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
