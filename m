Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09810C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 09:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E07622527
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 09:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E07622527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DC389829;
	Mon, 11 Jan 2021 09:49:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985968953E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 09:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImYAfFp+x98fjMAVSJpG5xmKUMfsj7BhjVhurxw2SoocYkKVv6n4l+U4Zsl+sFsZgn3Xv2/rwIxn/6vf6hD8mbLqJEbHGADxUpgAo/v9HOXqv8VpSO6BPKU6WH5ozPXlPzPT+wKmSNzIk1E5q1ryHH5jv0PV2DlE5xJhb1QTbsNlcHCDwdgCdD3HCIXDrVx5F15PDKgGvWkzJCdw2GmNj8yP1NzFYqLNcR7GNbva220X9VCixqc/LpaYKQmC5iiJn5xtRoMBZ+2rLDRzHraqLqhuT4Fcw/Zu1pDrLqKKAZFfBeFwxDHLNOCjt2POX9c22j/ERgX9wm5sCGWH8EdZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZpAv9Vbnw3L/l/B70A3TIjpIR7STcFJE7dcsR6vUF4=;
 b=SY3FD2glPsgoB7/+lqTXcqTOS4TI2a+YMxlnNg9+Rz1UvMYqypaPN81NAq5U4HFiwVgxnaYs1UNM1KvqVSiibmzi4Ckl2j7cRp5BvNvxQsdFOJB/gpUczrnQ3hhB7oIDtlfkmELOWZjonJLpPHgKIP39goUUvqneUmhuc1h1za5b5NOVQIJXK/fVdDuTQRM/ayhevrhOODLU5J8lCXXIMjAmOE0qJ7Jmw9vjPu5hhP/q2srcalhEE1TXihIJG2tHWTpDgksAgCREwGrOZF85/Xuvb9TYSU2ETeF66/xE+TSES69kmvrV4mEpLCJ84R5SucbTZYb+blFQ/bewkM9wIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZpAv9Vbnw3L/l/B70A3TIjpIR7STcFJE7dcsR6vUF4=;
 b=gH2IukYk8zESm8Vqu9dYYIVReZj/yfJJ11ZeJW/2y+QikE+iMFoB0PHx0YkwzNq9pwb3K7exMoyO9k2SPTJ8k3VPXGd2tTUiXuT+jCo2ylX2FohiL2mXj+BuBX7dw31eLsTpRvYAlyPYJH+gdPGhDkuy8UNjnyOICDQKxstXAPo=
Received: from BN6PR16CA0012.namprd16.prod.outlook.com (2603:10b6:404:f5::22)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 09:49:50 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::a1) by BN6PR16CA0012.outlook.office365.com
 (2603:10b6:404:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Mon, 11 Jan 2021 09:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 09:49:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 11 Jan
 2021 03:49:48 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 11 Jan 2021 03:49:47 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
Date: Mon, 11 Jan 2021 17:49:38 +0800
Message-ID: <20210111094938.2764-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844356c2-97a4-4d7c-58c3-08d8b6163c8f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-Microsoft-Antispam-PRVS: <SN6PR12MB284666A9AE4113EB2EAC2260EAAB0@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpIqsZ29+peS2KTZ6IH598jVI5oObvk7p/7TcUE6/iIGzRgcEk4a5o6dYAXiCzssc3/BM+OVRBfgfLSczvl2eWWXhIgLAhpajm0r6G35/R4efSTHYMalsPGvBqaTPOdSXoknaBrv2RrD5S9jWbBmdF2/mlvcTGzEYb6xB5UVWzLavcVdAuqpp0NfI/2Na8jTpzBk2ycD+A8cATR3fWbBBIqAPJP9U4Yu3CTisScCbXwEDXLnBfH2gCAATAyMdlHXHMat6b6KIdysAIea4F5RzIFbAldUbuihoqA4gO1peZ5zmBiNsMzKkSf84hWz7TBxdwoM54hXMRAa3Ry+pIWuZCSt2yBkpVoB0TNfqoyERSsrdRRuN1beZrsvH4cBVIth3cTJbxEQVCyDVtwYHHLB3sSvT8KkPiy1dS920UOc3Sli7/mI/h2Q5oIZ2Cbw2v8AOWRixMUp3vlo/u+4NirD+LHmgkBr6jgkt3h4UYGASECXtg/qj289DIYzGe69Nu17
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(54906003)(4744005)(336012)(1076003)(316002)(6666004)(83380400001)(70206006)(5660300002)(70586007)(6916009)(8676002)(4326008)(8936002)(478600001)(426003)(36756003)(2616005)(2906002)(186003)(34020700004)(47076005)(82740400003)(81166007)(82310400003)(86362001)(356005)(26005)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 09:49:49.4038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844356c2-97a4-4d7c-58c3-08d8b6163c8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, Tao.Zhou1@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gpu recovery for navy_flounder by default to trigger
reset once needed.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: If213b4c7a5444872ec51869da53a374bf40db7fe
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 087afab67e22..dd67b589b4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4206,6 +4206,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
 			break;
 		default:
 			goto disabled;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
