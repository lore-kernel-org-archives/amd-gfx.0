Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B882AC10DCE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CA610E644;
	Wed,  6 Dec 2023 19:52:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B051B10E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzP+RM1DcrXVTUDWmeY7eb2yefaSXHmJ6mggRbAC1ySakCLwYssazc+WD0hUkrszX/pU9gi9gL3uugvAKCHB0PQR1GGWUwEO/4gl7HmX8IPSTBqEB/IdCXiG2kE5baSGqMYIyHHv50aheYTjTuU1lhXsvkSYgS+m3MMW9kFclUOUDWjRxsjMs9G/wEqC5z88mbb/WfVTSINi2wcnb4ZFYZBs5PF136oj5fyOTuiJemY/Icf81e7GB8648eNYHTMjRppDEfE8WrkinvMqH6rV5EmOfpSmOHFG+hXDvs/fnwqruIrHR2pE0fsbL3+BgtMUH0QeOU2EoIsrdJ8GsVYeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLWux1tyC+k+HWDyYzyXNNP+REaM96sb2p6UxU0Qf+g=;
 b=mOF0oUcBvnHA0Ak619IHjPqKl/ov8o8VegWIdKiN5AKwghJ6K/6drHORwGTfGmMSQcMykNABqlsoIMi/vi+P/biRL1XaLLya+8uXC2NDQAPFX7EQAn1inEFQq/l7g4gHq+6obxeEf1n3j6+HR7F24V+jEhQWXw85rJytMXD9900ilCoytQcSUpZ5JzIzhWa8cfQuENYV0BgPLqXxmcp9shMghHebEkd3LZ9L26lphx8gl0gnDVhQohkMSR4oXaN+YZL8Cij1A6zY1Fm6MuKusWEK2hjZmBT4XIUXK+43GVHB0JIKTUBRDfzOkIn5BqP/rpsALhYe6vfkjFzu8xJ1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLWux1tyC+k+HWDyYzyXNNP+REaM96sb2p6UxU0Qf+g=;
 b=qff7LWeWaS5iXKzAqhM2KWirnijFI0wy9ZWWNgL36/HJQMigFnStdVdlN3aZ8u4fFY1ACF5J2ws1ObtJw6bzbEOl0E0OdhZZRk5w2aSxpvIez3sbRqDzwS3iy9ZMPvVxSjiYq183EuLhWOw1Qj/ZGGngiKzQu764fDRUx1GocpA=
Received: from CY5PR15CA0186.namprd15.prod.outlook.com (2603:10b6:930:81::28)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:52:41 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::45) by CY5PR15CA0186.outlook.office365.com
 (2603:10b6:930:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 19:52:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 11:52:36 -0800
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:35 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Remove minor revision 5 until proper
 parser is ready
Date: Wed, 6 Dec 2023 14:52:22 -0500
Message-ID: <20231206195234.182989-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: dd267bfe-8a95-4533-7131-08dbf694e7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AN6Uvw2KL4UQJlaMMI8uvfHqSV+UGzZyVDxElJBhbgHcaghdfBJvfuV8aEIKODHcawljyOirKWJ9ZTNNdfrkiBA/B66Qtt5Lj9hz0xk6UmH0skpzhhjqPulo68fNYD5dsRwAfuPi/qluXGVlOf2r5AR9BFa7QKMySOS6YgWFUOQTCPV9H5ZkJwn6+wGJWSHTHYD//IEBbLX6LyxnsbOlN7RHqa+JF0YjMs5DBBj07NssG6Ri1X871AuXCVjAvLyi9L1zV0dYdggq/yCq52pLOK+7UUbyiNn6GKXEqAboZcZjMKo4Vc9pQb6CvESwZQ8bP/YiwrJYzi58/DK9jwfwx+3Yjeoobb/C2iaZylrsAaB+88/N3XEE8ZhWjMdiaEqfAJ7s3Co7BeQNSTwAhEtBPhOHFZLS+FBNaAQszqk1iHREyFrwiZLHu0ssIVG/jw7wJmyrxgGELulAWL0I8ZDKpe0bmAel2YHBLZH+OE5CTkAgvd+RDIdIiP3XDNderFBhDhmEA4Ozl6VNHRY1xtmiywUeIMIZXk4qbn5qJEf2qqpS7E8faw0jjFC5TtsQYCXU48ywtiwN3/1Pm0BZ0emT/PEJLSyaDlESJWsyPO4Y1HcSugopQGyPKqsxz1EPFHHWPrfI6RHeSNnmhZWnqEigSebnXiqhnV3E5nXAjXQJAZoTIf7f0bN5F7UTDSTW/dVoQ2rbmdxJlTDNTdves3Pl8BJGCqOYks845pAn4ojl/WD9kLjXBsmeAPmE18Smj7MFWOrzm7zk/lObtn8i37uVhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(47076005)(478600001)(1076003)(356005)(81166007)(6666004)(2616005)(82740400003)(4326008)(8676002)(8936002)(70586007)(70206006)(54906003)(6916009)(36860700001)(316002)(26005)(83380400001)(336012)(7696005)(40480700001)(426003)(44832011)(5660300002)(2906002)(4744005)(40460700003)(86362001)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:40.8679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd267bfe-8a95-4533-7131-08dbf694e7eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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
Cc: stylon.wang@amd.com, Joshua Aberback <joshua.aberback@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index aef964f1bcbe..875a064bb9a5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1747,7 +1747,6 @@ static enum bp_result bios_parser_get_firmware_info(
 				result = get_firmware_info_v3_2(bp, info);
 				break;
 			case 4:
-			case 5:
 				result = get_firmware_info_v3_4(bp, info);
 				break;
 			default:
@@ -2398,7 +2397,6 @@ static enum bp_result get_vram_info_v30(
 	return result;
 }
 
-
 /*
  * get_integrated_info_v11
  *
-- 
2.39.2

