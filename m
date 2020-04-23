Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6C8C54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4389208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YotMg3pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4389208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FF189F1B;
	Thu, 23 Apr 2020 07:02:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D973689F1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4RXjSe4/AOvx+FbvPSY/d5vrb88Vwd4VU27hakeusVVPSAtqZwEKz8o1ERtie06uusXLq76ZfPydMh5p1G/kYZDpn7p6HRBrOnBiAaV0vKWw2bYTWJ0sYxfmrmSgbXgWBVbYYJOIPsAHc9K/pMXVAmUG0J4Zp/IjZO0wdj+JOuzLb95YOTOLqqSaPl126/srlTYs3PXwItOj8cLjiCeAqaJs/Pc8Oyyp3LL5MhP8INM4Y1uK06Yb61WNMXkiJkqKgewgP9VN+Z1WmEX7ml77/+dZDDp8F4Z4wV0inckyhHv7x+WfTgQYCQcPKJc5rqmgOyP5vJFNQdRCHYXEzPlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP26eZkTLSNU6JE//FHEowyxvj0uY5UpJAQ3m4SeWfI=;
 b=ZEXCfoeJrJCHNU3XaVDOs5XIkHfhseRf8fTWnposuiJH2sM9Jyh6H7AXYF2TiMrOElafBDUeIThkRbUwM+LGOt5fg3OV2iCmg5XUHjc8HjMuENd45lhdkjaFm5i8sG1MXFWSvuKLBL6vrADOjVHmRcOhytt5dnlIDw06nos34M8J3vRhhXPM3gfZXDVY+IJfGjv6HrBtJlaOQ0BIrP7YGQ2tzmMSP58ElRv8Swf3e9LhApgLD9zwASKCc4mxeT25F5hWO9N8eV6Jg3i0I7DIiQMzpqhpahRpZMT0gHyOeVOxNChvi0aauaZf+Y3owQyczy6HFQQI/UK3wqUl02v7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP26eZkTLSNU6JE//FHEowyxvj0uY5UpJAQ3m4SeWfI=;
 b=YotMg3pLbPcE9APIQJk35X8ClYpxlt5zKaPmN7GoEfW7wChv72USXIx8sI1sG31yyXnor/3DttXcGb6sJZhQDiKHZwgylbeowR03e6UK4p8N1TQeXwXNRXc90Wudwwe9bqNQQsQggzFYCnUhyGnCAF2U2i0zkIyLNRaJimlF0q4=
Received: from MN2PR14CA0015.namprd14.prod.outlook.com (2603:10b6:208:23e::20)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 07:01:57 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::59) by MN2PR14CA0015.outlook.office365.com
 (2603:10b6:208:23e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:52 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:52 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:51 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: sriov is forbidden to call disable DPM
Date: Thu, 23 Apr 2020 15:01:41 +0800
Message-ID: <1587625306-20704-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(46966005)(336012)(426003)(2616005)(186003)(478600001)(7696005)(26005)(6666004)(8676002)(82310400002)(5660300002)(36756003)(8936002)(81156014)(4326008)(86362001)(70206006)(70586007)(4744005)(356005)(81166007)(6916009)(47076004)(82740400003)(2906002)(316002)(21443002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4355de4a-2865-4840-1608-08d7e7543531
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571655BC11C259E6993421984D30@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2O0sRM0q7NBBf4yIUhQsK9LZF/Rxikrwwn3vIHsJgyd3SLudQrMBgRWdRUaedHch9hIFG1fuJI7KO9jGDubmMlkc3/4QHAzeeg/tYTl7+hMLWuEHDMxqTcrrM4ONdl8TMfNKwI1aujessvDpR7Jc+Alj5axBlMSxxCCfQqjzhzDuiaO7bUP4jwyZM5HR0I5NMB+d1pW9zCRua0+V/z2RiKOPuIPGkcfyyJib5KPW3GPUMBGQlx8/HuLkOJE0S7ryIdPXWR2opuBuFcYOJU2ZLfy2Ss1jbQChmWOCLR/QRsTp9PPDgyKS5AoO0f3agFxhFRfJRCtqh+Mng0laiALQGc0kNgMTNy9gd8MZ5eze+LQuMTERTlkelNWxUjwtVcKhgZchxl18P4Bi71Wy5bTXiTTnMjgzHBwp4EyScvuRM5/uM7+0e03fTOk9YpwN+BNQXUjdOcDIAS9DfrNq+hP5tfaAa1dRKisFN8bOxWsRHyywiCxc2NRlVTspt6Gs7MTUZLkbi7YA5gdlMhC54N1QZhmpIMs67ZSnQmM39o4fBs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:55.1463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4355de4a-2865-4840-1608-08d7e7543531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 88b4e56..2bb1e0c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1403,6 +1403,9 @@ static int smu_hw_init(void *handle)
 
 static int smu_stop_dpms(struct smu_context *smu)
 {
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	return smu_system_features_control(smu, false);
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
