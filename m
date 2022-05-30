Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3649AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA6410E5D4;
	Mon, 30 May 2022 07:07:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8F410E5D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfXLzX59uNp1lKUAenhdCxDTjb3oqsosjle0ZTf2bcNu+aVokdCrtC2PRdbTW4VeWiHQ3kV13J0yg0oxK29BuxsRSB4d19DPi2AUrx4XFmb0f7nC0jwg64oGDswq+zeSlBKhq6xtNMYLuciwr3OXOSU/ddaapyVG2lbQiAhZJjI5Robkv5VRpisWx6VgkcqjGnDo9BNOjk6pwcCsG1S3WYxBaUYUNXa+9NlU+E+Gr9B9bKClptvQ4gQPSstscDnPMwRVcsRam6Ee8YxYUnozmZCSEmQfG9hR+rH7wkXUl7MT/HVtmv/r6XkLEr520xGm6+Pb3vt8mNKf1b4Kw6DtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hJ+hUIKspd5t9qIDYnfQZnUxePVj+Q0plB6dBgSgnE=;
 b=P2PurWIQaPgz4H80MdJJJ8FT9J23b8lzmg0zyY4d9C0Uiz5a2Fs9Li5FvTjEjWh2Mv7ugXTZzzsOgmw9DezEvuO2IlY0/HVOYPHioP49jb9LJ0eRmJlJsJru018ZbOhBFONltSWAzyMFAbX/hL0FClbUphevoFYRrZsGqhHeQpy9e66FIpbaMBZNXQ/gTDrFkyjgVbWINf/FTFM9P9u+1qM84W/NDV82PajXAd3py9zoamlxUn84vWxM+K9MVpHg6qataaQesUCedDqwFkU7tP3owyXQycYMW6dHtOAq2MzJqXHYaG0lb9dN7FBt+N0qN0bITwain1JfvPov0VZHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hJ+hUIKspd5t9qIDYnfQZnUxePVj+Q0plB6dBgSgnE=;
 b=lMcoxMwlG9mr5ZV5vylqzgY9gJSJfU9O4zHuJNEDE7ptpDabwNQ7PLQo02vGwgbMyeSQiC9VA5QhNnvEfEG8toSjZSbSmBINb83aCh8AncOsvU1fEVMqlL9pzRvkmAStoYF60ZEeGqIG8TDZZyW7y6f8Q6MFB3ZNobNDBSsRlqw=
Received: from MW2PR16CA0055.namprd16.prod.outlook.com (2603:10b6:907:1::32)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:07:34 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a3) by MW2PR16CA0055.outlook.office365.com
 (2603:10b6:907:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Mon, 30 May 2022 07:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 07:07:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 02:07:29 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: suppress the compile warning about 64 bit type
Date: Mon, 30 May 2022 15:06:57 +0800
Message-ID: <20220530070657.678863-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2859dcbd-ffdb-49fa-fc8d-08da420b1219
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753A01C6145C978600CFFA6E4DD9@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lrhw6Q7gima0EgnDyWQ1QGtCZq7Wbdn2LqIA13B8cuNpBQGk44N56IeeDz4eqb4aD1KkUIXa4nlZVdQhcgB10gpekKM3axYGau64czuTT+Xd8pc5FW8FtG6jgefWQF+mVnsxIK6+aPbQGIR6TSqhq2fKz51FjhUmSDzf8RENdXyf7aMJF8cqowYeSmPwlnoEYjuf29XEt/2XO0rjNxoA1+B4lXzBC/bDL3KUqivZbhcRjA6a9PfFsy1XaZRcS+ZNlHH69+2le6QEs1ARLV7loSd+UMsetOd+7JxSg+Lgf8j9cYBF99l69uFtv6OsYaJaex0li5rLj3yXW3Ir5gagL9Gk0mVaIF2A2/kVoaHYn8cyM787pdOG5wWuI4PYXz5227XWmYYMiB/oZGyCbT+th3iRhofiDg9OihEiSnjYIp9sCQajXql6YSQu4536Wx4dCj/thgRaABAfA7M4QzWOX+PD74DYQ9Io6BuF2/h1wzbiMxCC0eqGazAUiN1z4H9JPmdqcP7iyypQ+nXbXk292l+Kvvx/e0+794c5jKtZY5fJBnH0SreS2h0DmWgK/V1cx2CiKgA5PhLNXdwecSNqsKr38EHRYdMfJpmy9ItZF5O2AJsvRH9eacN0S+v2+RnBKJkJdEkuv9GpBTDoUAbuSceKAQb7qPsXvxLQ+UvwAMF/X3DHxh6phaAHD9ORFijQtk7zwgP8+bxTadSZRwO3LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(83380400001)(40460700003)(44832011)(508600001)(8676002)(7696005)(356005)(4326008)(36756003)(82310400005)(2616005)(8936002)(70586007)(70206006)(2906002)(36860700001)(6666004)(186003)(316002)(86362001)(16526019)(81166007)(6916009)(54906003)(26005)(47076005)(426003)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:07:34.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2859dcbd-ffdb-49fa-fc8d-08da420b1219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>, kernel test
 robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the compile warning below:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1292
gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64 bit type?

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If5f83daeb4039d87c5b47c221f9c963c941400e1
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index cb581cfc7464..9039021361a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1316,7 +1316,7 @@ static void gfx_v11_0_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *ade
 		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
 
 	if ((id != SOC21_FIRMWARE_ID_RS64_PFP) && (id != SOC21_FIRMWARE_ID_RS64_ME))
-		*(uint64_t *)fw_autoload_mask |= 1 << id;
+		*(uint64_t *)fw_autoload_mask |= 1ULL << id;
 }
 
 static void gfx_v11_0_rlc_backdoor_autoload_copy_toc_ucode(struct amdgpu_device *adev,
-- 
2.29.0

