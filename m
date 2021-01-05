Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 00:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68622256F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 00:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68622256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D23C89A0F;
	Tue,  5 Jan 2021 00:57:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15496891F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 00:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMcNbio0Ni1lZrZs2MkQmmfH0PdpWjnlQh03OXUKqmtJ2nbGbKmYQO7hb5mKjivVCTG/l3iEx2+iFcRKExaDi7LYc56aAuxFAZsNIKGO4I1oju/xB3U83QoxCDDTYhu5UaSEQg9tzv3M32Nsf+LxkfHv/MShyyVIq+GN3z2VT2t4HT0bukoV4IFCf92AF344Rxifco1HZnGP2VBDsrM6fn2uFYsIkfR5gvP6lNo6QT9SgUBOPIIHJIbh26RQk6cCPoIfsYNp0yYK550x5QnfIEJwzbZt4WLOAols6Wn7F26wbzGiCoSdOAo53zw3R0pqB1IENrwLw3mkq5Y3rpeICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5hbr0YVdn18dh1W9gFuumDX09IaWV1MLYDbNaZoRGc=;
 b=XnApgjjYXYwOKZlET2tijDFh9BELnn7txkFadruIUc+888u/gvP4JSDN6MaMkgI/16gxiNRvBTHtOPjhsKlVvVKjxqgvXL6yLPrIjcT6Mg/qHCBgD4dW2WgHvyBqCGP9e9t9AA+uU9l02tyomqWMj57WOwUkEjYjX9XSW8Q6PV4PqWIS8MEYjOluVR5bkUepnMopken2zB7cGI4+K++Gg/y2UQbEAhWMUUvehhsadRwKAIr7uu15oSFN31SfJAoJTle50JllV6GQBeffkUvHiofNn655JFLp7rpY+X1mmJe4Rc8gH0bLe0td8KK+7qts8IvlFm1XHRb+VWkyAYxI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5hbr0YVdn18dh1W9gFuumDX09IaWV1MLYDbNaZoRGc=;
 b=W3bVJn0mpsvi3Dzc4hQPMLLRaCDBkB2FqTNMSfEsRVsyMFO62eRQg4Cn//ttS5Deo4IaIuNd1arWV1BbQyXJlPgRsY3O40cDYlTQkgbOjTvaXHB5ryKqQ7i6suG234veIGLpSWPabnwwIMzwyVMlOMlZtmt7D9LCmq6AR6bgNrw=
Received: from MWHPR10CA0001.namprd10.prod.outlook.com (2603:10b6:301::11) by
 MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Tue, 5 Jan
 2021 00:57:37 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::ec) by MWHPR10CA0001.outlook.office365.com
 (2603:10b6:301::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Tue, 5 Jan 2021 00:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 00:57:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 4 Jan 2021
 18:57:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 4 Jan 2021
 18:57:33 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 4 Jan 2021 18:57:32 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix issue no bad_pages after umc ue injection
Date: Tue, 5 Jan 2021 08:57:22 +0800
Message-ID: <20210105005722.1210-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4615c392-4090-4233-6745-08d8b114e392
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1725747ED4A87238FF2BE92EEDD10@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7LrC741MxLzK3hYmy8j/Zicribq+vplo31up+/TaGgOKYsX/gZ82caqpwrENdXmQVCpB30PW96T7EMUFNN3hf1gO3FOwONmvrZuX9lMq/NSEdej16TsDyt7X2feFZHPdIz8lMSb3U+lGw25X22tP1AAd5ScqJp8tWsO0jd8owT3OJVJccjDGWEqmpxp14S0HQ+N2/ebMMTNAhGeJli3WkcXTg0Gro5YGQRk7OCQlM3r1r1Mr+fVpBLA/XLCeSKOU2uuGF82L7skOCVuBQ4Cq2connUYaYxHHPWmFy+5Q1nOVTC1r5PEULOfF6qm4CMQtTlp9UHDJxxzqK1lFUHYLuu6jI3LWlR3pzfMafWmUbG9AVtYNsY5wGk5xPPYaGFsBKkTsBA9ney8jyFB/4+Jp/W/tI0qRxCWXoGhlnvlP+i65ONoRYqSNV4WvLxX94GhQPUXhL4BLVOo5YnuqyWlkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(8676002)(426003)(2906002)(70206006)(8936002)(186003)(478600001)(7696005)(26005)(336012)(6666004)(316002)(81166007)(356005)(36756003)(5660300002)(70586007)(2616005)(1076003)(110136005)(82740400003)(82310400003)(86362001)(6636002)(47076005)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 00:57:34.6741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4615c392-4090-4233-6745-08d8b114e392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

old code wrongly used the bad page status as the function return value,
which cause amdgpu_ras_badpages_read always return failed.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..82e952696d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1518,7 +1518,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	int i = 0;
-	int ret = 0;
+	int ret = 0, status;
 
 	if (!con || !con->eh_data || !bps || !count)
 		return -EINVAL;
@@ -1543,12 +1543,12 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		ret = amdgpu_vram_mgr_query_page_status(
+		status = amdgpu_vram_mgr_query_page_status(
 				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
 				data->bps[i].retired_page);
-		if (ret == -EBUSY)
+		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
-		else if (ret == -ENOENT)
+		else if (status == -ENOENT)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_FAULT;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
