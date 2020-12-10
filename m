Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7705C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C41239D1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C41239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB7576E2C7;
	Thu, 10 Dec 2020 02:45:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C4F6E2B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTsajozfbE3lJWMlxANBKzkk5CbaQQQDHPBIrh0t7vsPxWnLwXK9NzdGNb6FOA1Hwu6+bwAf4OEvGOGOIdlBDeA5Q1rO5MrP9CxJwweHCjP+DU44v4D6t4mD/o7R7UAk4/xmILF37qMaRy0/UGcB1iRbjZ7dAVr93945i5VXMNJ4H3S9jX4UrcTCCrJDQZtimfv7bTYG1L4PwhtIwDcJXkLNYS+vtv1qJQy86T2nBqKy0WdwI3tbojyxgV1u2DLGM9M4hI6B8PyJprqjD/H9var0LM/q8wqD0/allQmvNGIiYxqje+FTVdd4iilRnEpvvkOALnHK8F21vpbUsHbzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2sR8BTfjRucTFwKBIR/F2fUCGuh1XPBz8A5IzlOxeo=;
 b=eEge2w1E4Bg0E0rr8w34BCur/hEj+TIqFjgF5Gs8P16kX8N1koJoef2rizWXKgHMkiobxTDn6fT8yD0tehh4abk2XgubhuobOzLzMYve500CHRPW4j6uxZUwJgRY8bq6xpiU6zQFHs48nQOl6qweRIA7ny5V/Az6r+R8/d+Btgqk/KDMcWFyVNwqP/naKqdTQBlDsW7ek4amXktQ+poda0EoYbQZ9qWqvuw54TfPgJzxIoAWuKOHFtmFah5Kwf/AqoMpc8YZqlO2Mj05aEuO97YN9W+eznf0SEq7mBitXw80SMRWqcg2ajAWCrVn4DtpbwZ1dQNtmhX+GXGSDEH32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2sR8BTfjRucTFwKBIR/F2fUCGuh1XPBz8A5IzlOxeo=;
 b=thpfe9tzW0MAezTOI+CFIxJP4MBF2INffT4a+v//d8P62aJMsU4+xI2eQr7vdwgntG0eBzfMvnxX3DnBrLtSetfomd73inNdKCZe5CbhsuQEIKkUUoOpRpTa/JqzXTL5YFMep6vVbe2NjJCkTCaw5/6023Svm/pZxMyCxHjuxY8=
Received: from MWHPR11CA0014.namprd11.prod.outlook.com (2603:10b6:301:1::24)
 by BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 02:45:29 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::62) by MWHPR11CA0014.outlook.office365.com
 (2603:10b6:301:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 02:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 02:45:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:28 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:28 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Dec 2020 20:45:27 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Experimental freesync video mode optimization
Date: Wed, 9 Dec 2020 21:45:23 -0500
Message-ID: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abddd44-52b7-4ed5-2875-08d89cb5a806
X-MS-TrafficTypeDiagnostic: BN8PR12MB3378:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3378CA734B65D58726963DF68BCB0@BN8PR12MB3378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Apjla3/A3SLc3Ku7Gp15RuhrH42VJIP24KdL0D57LWX9u4kLKYwff3/AreWt9EMaycv1/7+T2QmL0LI7qAyuqvjZNYgnrv9TszClz4diL2NkC5xjSnvzL3imRTXwVKczvn/Ecc0+eK91cTQPArHtWg3DVrKCJ69pzJKsvJPpbcrWzWpQ0rzczQGW+fjKpCdoBGgQWZM+SnqIhNEpF9PxxBg/jC0WbqHSXZvJeOtRsBDDQm6fhu0ZgOpSxcT6MCbkchh1n7KmM1zZVKjOFBoz7suws5uIgxKOIo6f93S9E0x6wsn5E8LslTh7IJTB+Dddtj5LxOphepU+ohj7jtLtwqRzqBPVVX3k+vjiw0SARPDdb1BS6IIYEFMWbqL8dQoF6c4v28Pa/4DkvUey6K4ykw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(4326008)(356005)(5660300002)(86362001)(8936002)(54906003)(336012)(508600001)(82310400003)(6666004)(6916009)(2906002)(47076004)(426003)(2616005)(81166007)(70586007)(36756003)(44832011)(4744005)(83380400001)(8676002)(7696005)(1076003)(26005)(186003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 02:45:29.3175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abddd44-52b7-4ed5-2875-08d89cb5a806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
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
Cc: stylon.wang@amd.com, shashank.sharma@amd.com, thong.thai@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
 Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset enables freesync video mode usecase where the userspace
can request a freesync compatible video mode such that switching to this
mode does not trigger blanking.

This feature is guarded by a module parameter which is disabled by
default. Enabling this paramters adds additional modes to the driver
modelist, and also enables the optimization to skip modeset when using
one of these modes.

--

Aurabindo Pillai (3):
  drm/amd/display: Add module parameter for freesync video mode
  drm/amd/display: Add freesync video modes based on preferred modes
  drm/amd/display: Skip modeset for front porch change

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 366 +++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 4 files changed, 363 insertions(+), 17 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
