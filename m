Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205AEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 03:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAFC10E0CC;
	Mon, 31 Jul 2023 03:33:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2E710E0CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 03:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9b2/fOeZkYmIKIhiU+MoyYS/GopA5c6B+fGeNHdEMNNXjRoMMs1zpjftsuGqH/Pf8CnGh+zkCEV3wSCntKnN3ef6f+we+oHsqhWJZRHv2tA/6bthEKxxUmHLyuYerWjmEpKJaM2w1c/l/668WIqnpyIS8y0dN+8oLrbpo+SVIEsgHNog01qV7/3EYBbE/9M3wVe1RrYhTyp9EP2otDi5iYLJDkpepAt9B5+/VI4ZDng8oikKRlTLrtRu5rqB0SMZPLRSfLs2x0CbZUHg3Sxg5xmJ4LxI+EsoWNubEh2zS7bny/+S9V3fsV/xLSm6CWxTbDbGBK8hlGGgn0uZaKf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hx4sEgikQT+xhv7Kmrb2OrB0b2lXu5CmNdaSCSWrrQ=;
 b=ZjfjM7VtNfpk6Cb5Ov3pJ+QwkHMhMiTIoH7zzAA6lPCKhGfaEQMzMGDAuoNw4R3lnOWzbkuoA+3DXoqS7QEPu3AjqpYYZSJDhZVNtqI6xPD9jYvB8mjiSNqs+QelINY0OVRAoxVe7Xbcv8cNsZIqdS9nXCvdGFie3wrBDhpsF7aPIi/ThWIqOB4RKazxIpcvsDVvNQIcocv8iOhdP17dPQ8cfqXYqFaXQD+Nr5SLo8iB8h4pJeY+vJbJov96LQpgAhbTeeTYiU5c8dvdEjpeywWsQu8fDSo6QhrO9cuSACsQBv9Ca4F7I3TSBh8+N45tUfwWti58MXe030VrZ+GX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hx4sEgikQT+xhv7Kmrb2OrB0b2lXu5CmNdaSCSWrrQ=;
 b=3mVcU9EO1lP0DhPDBzBHcBr5S1QQ7ZWV6ky3G0n3B9vbgcb0YyVvucph1/zEbVVv81/VJokmQ+CEiqvCj74MxjAyl5FskjkNggih6qbp3wZsy2736CvqFPzq4wnb04X6b+cXcFQmenL4hhdnlkzSBlHQ4jlRWO3gjg/maN/cxg8=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 03:32:58 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::58) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 03:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.5 via Frontend Transport; Mon, 31 Jul 2023 03:32:57 +0000
Received: from alin.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 30 Jul
 2023 22:32:56 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: GC_9.4.3 requires at least 280MB TMR
Date: Sun, 30 Jul 2023 23:32:13 -0400
Message-ID: <20230731033213.3128180-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 3951bf34-d299-443f-1392-08db9176d58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoMHwk7js+4vogqbACI4S5HHNHC28s86VbqSIj7vmnz05QtWcobkeQqKYHuHyk/KriIvbYtdh703ig0hMML127mYZY0HohjF5pAg7gYC745hYJGwbzeRvtsx6hAN4C+0k458KUtuMmWVlZEf2mhSay3J+lN05as8nKRin0NoRJd/OcDWn5IKgb7EHShf62+dcA6Zskd60kdDKU0EeT5svYBrc4lQFIFhTPa7gmS1ivL/3QzJYZHIzlUjqyh2P6jd4KFlz7FFReptpNQD1T+4EiXveFGvNTq/wQ3jWUt947wSb1PD1HAQjqFF4EpPkpfb0RDiMwiiCpv5L90D4EkyycLgXWKh1lYVXjW/clTP6Sbb0tcUOLEg+VwzJvHTVUJjXPosovaUiUTUZBb26sZamRoedo5Yx/l0M22Yqq7BSJvK/wPWocTWtPDiZKk7p8U7kxA7qk4WfdluTWlDVjGq1ug+eXCTef8DBCMMY0LXxTzrymCs/SuWXBKXCIH8DUiFd1A5DVRMq0wzbBEW75OXKe31XrbqoqVlykNVNaEXKVaOnTYOJN1p3sQdBAT+vdqYQMsTCw0Y0Z1cmV9nOOAVNwHq2WgcAuaoIEzLs68Ro6K8bGTCdhO1N8wtMc/UP0zy9+5L0kGWbLaPMhSOKlzSH94ClZup4Y0efnMhDpzO5ja7X5Ut9Iskj+3uc0fy0atR2IGq4mgrxI3HM5RWkRRQ/KXqWC990ySJBhdnsB3YwxkCXHBdkcVh/KHg6DPC7RcCIZQB7NDsxGVL7kb9RnvIWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(40480700001)(86362001)(36756003)(40460700003)(478600001)(7696005)(6666004)(16526019)(2616005)(336012)(186003)(1076003)(26005)(8676002)(8936002)(5660300002)(70586007)(4326008)(6916009)(70206006)(2906002)(54906003)(41300700001)(316002)(36860700001)(426003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 03:32:57.6611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3951bf34-d299-443f-1392-08db9176d58d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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
Cc: Amber Lin <amber.lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GC_9.4.3, if atombios reports TMR size less than 280MB, firmware area
will be overwritten by driver or user application use. Remove !adev->bios
condition since reserve_size is initialized as 0, it'll fail into
else if (!reserve_size) condition.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7c6dd3de1867..fa5721b3139c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1718,7 +1718,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		reserve_size =
 			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
 
-	if (!adev->bios && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		reserve_size = max(reserve_size, (uint32_t)280 << 20);
 	else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
-- 
2.25.1

