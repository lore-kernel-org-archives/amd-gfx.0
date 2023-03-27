Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904F3C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FE410E6F4;
	Mon, 27 Mar 2023 19:30:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CCC10E6D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdTcsyVJhNzgiCHGVHMIIlGu81aTvKYW1oQCmfJPqCGsBtpmmE/QU9UFWqwgEg5/50haOgPJJgnNPTE3+MzmqQ5Wp9sBNyaY3lqe97jHCX1Nto1+18UtFw5TKI4/lz5DiJlZoWqmw81uFe5RsIm2NEsQrPRESzqTRsi6tnVvj+d5yygiTW8ZyN2VIzPq2SDLEK+/KCQ3595FyRSCL5x8Q0d8f6lhKvZ6WGqIV2b40jGyajjqjDrxPfHMjlyd0Re3pv7Ifuv2/JgdYgCY2pMVPunOtz+OXV7oBJYK69Ovad8uwEj4h73EGilO5vsCivv3jVURf/slX1a4RzJqsrIZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J4JUfHoV7+9+F4Ap5JEdvIGT5r+p8L3V5W92ap3AjU=;
 b=AKSBjSz6Z4lcQLCrGuaCEkSTYjzNW/OlJqlKMFG0GLMFy5P/iiyrNp4++dFQgZ5VL772DkejyJj7k5SI3SEbciSPJrVNJm8KPyh8Tq61izTW7FGAm27B3bNtYasIWxpbvVmVAx7UTZsNbHrgGsYlHB63PSnqUxSCdlqPJEvBbb93aCG9ERe6dxImFBDrTtJdG6XvDsgEd+iZ6AebwaQ6n6qYVkmlfgPcp8FuxQwmENm6R+tuLcHrzJn3i2InDQp9qpb112Eh7bHAnivoeD6ECok1Oj4u+p9idEJYFZxXHKhsVhOZXV51uV3td96t5zzzikC/mFL7EE6fqlD0Nt4eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J4JUfHoV7+9+F4Ap5JEdvIGT5r+p8L3V5W92ap3AjU=;
 b=d6cyOgpsYzO2TElh/muKD99VGypMOoDgXAFJmvLOOwmgxNAeEFyvu0R2Sm/IvMLGKqsgZrtFW/a8DSKMu/bhoPRWh2VPT0bWUJ8SYw9+u7VMH566T1ZuBQCIspOfG613UR2joqyLQAZ/WYmCkqwqPQWJtXiMjA7HttCcP+uN2KY=
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Mon, 27 Mar
 2023 19:30:19 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::c6) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amdkfd: Add gfx_target_version for GC 9.4.3
Date: Mon, 27 Mar 2023 15:29:50 -0400
Message-ID: <20230327192953.7756-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 8846d525-4bf1-47a3-48ee-08db2ef9b3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Yec6jCTJS26Rvr0T8Q6m7Kq4Xg0O1NrzrI3vXrklLgTLbofxl10Lc4eiD8w+udL3IBbNtJJeNPlTuCnZ/vkHzBINmr3E/3l6pYgMo9HQY1ypt9K8MAGU8+w34TjAEIEEhKOw44NsDsd7EZbuTKqHb6oOAwr9OJszmjcM/3TAXFD6KiztZl2XTpWtPS4OkDWFtaNVcuaVP/KrJnFoAuySB1SBAvuvbtGaw7ycrPtBIJaU1KhO5V9S64H4SS0igV87PRNCTos/zrHqq3IFd5JpiP3w4iI8flgepZeUOl9hvLhxzvimE3fdzPQGAYp7Wf854D0lOE/Qzm2n2JPMDmZA/uC0UTpOrVrzRNwgFzGsRVFS+q32fjrrNGQHbuCRofI5Zfgbuo4/5jfjgOOt0Tzc0cz18WkdMFk1FmLj0yV3ZFHvxhGOHtf6Bnp7pl/NzIOWqZbXUJqwp3urZ0s+Z1QYPp4yjr8CJ0kKDvk1rM49ofsFg94xzIRUP2g75TGVavDT5kt7JlKT3hJkeytKHEkZpLMmMTZtb1lMoIKDcy09BtWmFl18TJxKEDRmNgxI4x3sOZ4HdirTrMU2I1SS2oieMkLOEzeIp3up5x4a9elv2qY46g/Sbb3RQ3IfgqQwqlhKPmHc1/TSHj9WirRzRpg4DAUf5FnTBLnj2JYCp/B3kQbAQRIOgOu8c+jitqklNBjACWGEoPaUuQiOoYL7Wtjc7GUyStiG8MxwhG7PNPJpgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(36756003)(82310400005)(40480700001)(40460700003)(478600001)(316002)(54906003)(7696005)(8676002)(4326008)(6916009)(82740400003)(36860700001)(41300700001)(70586007)(70206006)(1076003)(26005)(6666004)(336012)(2616005)(16526019)(426003)(186003)(47076005)(83380400001)(5660300002)(81166007)(2906002)(8936002)(356005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:19.7676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8846d525-4bf1-47a3-48ee-08db2ef9b3a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

Required for Thunk GFX version sysfs query.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0bf8d75950f7..21598ab9c520 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -315,10 +315,13 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			break;
 		/* Aldebaran */
 		case IP_VERSION(9, 4, 2):
-		case IP_VERSION(9, 4, 3):
 			gfx_target_version = 90010;
 			f2g = &aldebaran_kfd2kgd;
 			break;
+		case IP_VERSION(9, 4, 3):
+			gfx_target_version = 90400;
+			f2g = &aldebaran_kfd2kgd;
+			break;
 		/* Navi10 */
 		case IP_VERSION(10, 1, 10):
 			gfx_target_version = 100100;
-- 
2.39.2

