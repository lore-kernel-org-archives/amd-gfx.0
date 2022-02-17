Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9808C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA5210ED32;
	Thu, 17 Feb 2022 15:24:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD8610ED34
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUo502evDwR+7zOzo2xc55aFEyFQBWJCvvrr8UnBh47jqM7Jn66fgKlkkYrHq0tyZGUuEp915rs+IaJFP5Os7DVYwXCXqe0SNJS4BhPwH15gLTFXpSzTbgHHHzvu2PDaoPILNMFNBA7Rnql3kU1ZaQvUBDhSSCIKiyM5wuDzyIOvqyXQThm6zIESu2PK5YiVds+3GLOZVTvbIFqs7QqCRvwIJu+HsCrCEO75AvKunmOIY5PKgbScvklrbs93ZZQ9kjuDwCUzU3d1LSuT+S1DTQmTwSMirMQhnQVJzXn6vIyWrjOIIE64cOMX6uStd+WIAQ5eLKazLwk8guhgtIMyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wp9zxIsrLTSyWJZnAeFeXwziEMNpYUoPkjOeGhxpmQ=;
 b=J3yzzrWdKGyeMD0tU6wANBCnqqJYN/Me4FFfqBvFTPbE79UumspnyYYJO+ySaO0kIlRYgImzlofsltbtZWQJ3XmxaCAoMEa48jzJMUFKOORnACGlnMCBS48GXGnk5gS2IYOqks2eVRRXRO/ZcR9bS0+DucKWn9PpTOuDvbSra5LVWGLtsR42rXH4DfoEDIAuCJHEMCb8APJ4m/+xFGtGVwtLiCcBfPpmphHDk9+DQFEaRuszNMuIEaqEY5UfuSJVeJx2UWjJ51fI+1wYg92SA49SFQAD5usKlM1DgSNHZXyJGILrpX1Lmjy05PKVXlTei7DNPQHFJewoubSjgCvjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wp9zxIsrLTSyWJZnAeFeXwziEMNpYUoPkjOeGhxpmQ=;
 b=suXNPfr6pZv9s+P/SjwQn2UUvecfsdYEqYaoFFd/egqo+850MakXWrgsITsRY1yY+8aM6ljPLWNqwmv10+paAJHYWrYSzzIE+CvJxtO3USo7SwxcCzvWvlVdhfJrrGpLUZfia0N9pcwtZPKwmJlXY35SQo9p9yNxAwdDaJP+ZAk=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Thu, 17 Feb
 2022 15:24:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::8d) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 15:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 15:24:31 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 09:24:28 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/1] Revert " drm/amd/display: extend dcn201 support"
Date: Thu, 17 Feb 2022 10:24:11 -0500
Message-ID: <20220217152412.825286-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8db3a91f-6093-47f3-3431-08d9f2299862
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1677AFD13AB1902993BFD522FB369@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUbMs1urr4fzoCIFRyyAdKp96cN4A7CtqNZQgWQHGEQiJA6QT3UMi9BoI9DB6hq7def8Zyggha+qoL95noJdRE5m844oTXtCvJQJrDmfNHiQ84JwM2vVAg4H3zC0YmhIobGCHpfdnxO6FdtER3Rt8jcL2wKTag/xxHOBN+6k9j/1i7bPZZwlwFXDkp09I7/A5m22nU10FV5+MwMxc2yCF/+WWEnOZplFbVN52VIa7tHS5HfuwxTZ4ZRFaYvAtgYYx9VNZwNaP1rqs+WXpQLqZa5e8eAqAZSLoF2i7WzSvb6riB4DFf1dXzJaqCp+QtkxWnssSoVv3BLyvDfram2cY87ZHWTy3hz6x4SLGdajvCnV+wsWlMx52rJNp1deb47skJoFACMUAcYIjiggPynybgjdJ2yxMuMEhJU9kC7fWxa5ccFSsvABiI01bjzjxmq3K7b2ZEAC7Q9v2Of9EGC3ITDwpn+ws2P8Tmx5YMH9bISsLtqkXI5a+pIHBtX3wLrPYPVLxW2mU52QieJ90PNODVwc/fcWp5LeyNdiI4koAe8DYyHFtfoHB7VQjEosdvrIQKvVhZwvi/bq4pnujngiWoGib07o80Enh+r4wxHyma3EZoOdc7oEDK+do229KDQ9wFrOo2zVUqhuEhWuwbenuZH+1GdiyCkLOyef7zTPYdLXmuwqRlB+3IXh7jQr+Q67g/mnDrrqfc2SkIjgSAc41g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(508600001)(54906003)(6916009)(36756003)(356005)(81166007)(316002)(8936002)(426003)(70586007)(40460700003)(4326008)(2616005)(8676002)(186003)(63370400001)(83380400001)(70206006)(63350400001)(16526019)(336012)(5660300002)(82310400004)(26005)(6666004)(2906002)(558084003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:24:31.2227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db3a91f-6093-47f3-3431-08d9f2299862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e4a106919480.

Jasdeep Dhillon (1):
  Revert "drm/amd/display: extend dcn201 support"

 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

