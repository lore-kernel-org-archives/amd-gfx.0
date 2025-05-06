Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE8C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 12:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2130810E67E;
	Tue,  6 May 2025 12:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvY24Vt7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E6710E67E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 12:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe5KITIjiCynAp1pU/ZaxxFARdSYA8QJHa1KDX0BplFi9tM0B6DZCdmyRFNmPYe8Ic8SaZYr698orlZobnnXtnAj8i7Ypj6TlhVv/Z9Z6HUoCLqSGAtORxLRvHh5BbJ9zL1D9TRfttVUpWz3jaXCZb2DI5TJL8GdhYjOh1UjKm5J1KB/F9eTkK94NX7GIQLxvo+pgZHFDkHd2Fpboi/OeeMZ+CBa2Ld7u28ESJSh3f/jDn65/XYu0wAED5NjGvmXMx8jJfxva1JHvnCAfYkzLYF8KAWRaYe/qCjuK/U3YYTITATE/+g6cd+C9cfvXlTYE6D4ZjTooLf/UoIP0swJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue8AnBpzDlX4Zr94Lcw6GJXG3NWF11lhMMym2e70j0Y=;
 b=Q3UTpIC2Dd2EoNZPNiHXUzjpROcQkReHOnK9Q29vjARI2M3A8WDhgxBmGbPAWoPy47Z01AWvxHz7z48A7VZdwRU1VVPVfNHAcakbWfWYVE0PkdxnAG/7n//MB2J+gd/2/7WhGMF1eh73qdoAbrGjS2yQGulEAMpOOCzPnFUqFK8lomhHoP5yS6lhT4OB4q3iqg4V6/KQqspxZrD9KTfAMZIwf/etBYWHbWKr15knEiy6V4MBX7BWq++/g+tpWdQs4KUqn4siUjmYPj4kJDM6YLBdLGlEGcBnJtzH1YVCmqhfxMfpFXss9Y/joPv3JMlEPq+hVbghlJbo9VVPSwZghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue8AnBpzDlX4Zr94Lcw6GJXG3NWF11lhMMym2e70j0Y=;
 b=mvY24Vt7SndH7MkUOLlApaOwXp3Gh1E68yw4MEhZ/2CHaWaCMt1vzX8c0e8D0tD+TwksMPM9a+TfHMEHQhyyfAiew+NBQYSeTH31nJLP8yvyn2IQa/205d2LfEla5tgZ5ro2FaWyFnV5APPA3EuwhCKcTGp5or4VdFcEfjGmKTg=
Received: from MN2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:208:234::21)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 12:31:00 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::87) by MN2PR16CA0052.outlook.office365.com
 (2603:10b6:208:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 12:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 12:30:59 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 07:30:57 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Modify the count method of defer error
Date: Tue, 6 May 2025 20:30:48 +0800
Message-ID: <20250506123048.365612-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9a3b10-18a8-4de4-c068-08dd8c99db31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?STLpKuxOlU492SP3K6KB5WLiFu3+P9ZJ57NkQTaKd+vHcnKXpM1093nCYv05?=
 =?us-ascii?Q?AIyZQkCaxvRJ/sszWz8Q5ZnWqd6bCVu9WL4uq3eOfi2iEAXK70La9kPitvlF?=
 =?us-ascii?Q?P/hC44ddjdeejiYUTL7TyrRbb5eXfQVwdFuM08o/397DAOSZXrP5Zf/+apsu?=
 =?us-ascii?Q?0IX25bYhhK5dngfpqzJ3gUJZCdb33oZ0SK3s8EPNiv5bgT5Bhyhveyjn3sSH?=
 =?us-ascii?Q?ZA0wrIokLaRfrs9Cv4N2jPDwFANU361B06o249vZVxe7j1Kyg1ceit1nU9Wo?=
 =?us-ascii?Q?UyGNmf13hJPn1KvVU1iufmpARw3Cw9GEWKDytMjiybd9ejc0LSgtpthhkQn/?=
 =?us-ascii?Q?Yri09k+hm5eMusIRRLg+ZXdPvPxnT3e7hMg4TyRnqHMukUHaYTBBXmOnY5Jl?=
 =?us-ascii?Q?SL5ut014sTlY0l2Mw0au5J+Cyhp68YNdWpQS7eIbGs4s8nWCF8nco3hBv8PH?=
 =?us-ascii?Q?pXQNf4gp6jP6NLtP/J9Cem4DnrA9MyQJHpej5WkWS48PE5vSOTnoBwIGA60t?=
 =?us-ascii?Q?8dBsN2SSkah/YFhxb4018oNdU56+vhqzSvFmqEil0g0zXlqEfst9I6T3tSxb?=
 =?us-ascii?Q?zPhcMoGhI258qQQewGgV1xlDChVnV5Dee5nJ6dwzvjn6IKaQ/JDGa3jF14pN?=
 =?us-ascii?Q?BixCtSM4ZAM4eQ7sMyMz/RIHuYq2n0m66tvVL2I5DQEnG9AlzdpUBcvVHBeY?=
 =?us-ascii?Q?7ZULqA3JpSR05jouDLekXKbrc8BuBivzg2llUQ7PBDzrh9FWdKIksXnkFfdq?=
 =?us-ascii?Q?GA+/yRJUs5dBNx1mBrS/oY2iP54+k1PWYKiLYELfl331nGyrM2jBpefJ+j/9?=
 =?us-ascii?Q?qf3vxSkY9GdsB3M1BRDeM00A7Qr35xwNzyCKRLiR5PjdG/n/TPBulykEcYJ3?=
 =?us-ascii?Q?KMJCxE4CWXf2G5RFEF+onMy4L3xzgaO/vihdazuOu36PokAjftIinbrt7UIB?=
 =?us-ascii?Q?F5UMScA++5Yx15aGSv03i5TiMKGZTa1KNFBCw95Ih5Q+mW8eWLa6xCpm/LMO?=
 =?us-ascii?Q?33w2D7mc2fvHPQ7cxjn09iFUuX2gH/qa8w/7Y2sIBkgisDhyxm4frBDSGx6E?=
 =?us-ascii?Q?i2y1qwwAvCdpro0CYpJ2cuJnzUV3Y5ULarXiYMfhvwNsn0rL/jCWvlia7dYa?=
 =?us-ascii?Q?fecs5d91gJ1kUxYrji63uuEfMGsRcuGZbgXJs3PEJZjHVnZUs0c42UmejbaN?=
 =?us-ascii?Q?f5DZzIMYrGKNqQMEf1pY934y5/HjUPie9c0Zt4OBe/IfOzxSFIfvMSr00cFs?=
 =?us-ascii?Q?uQeJdDi0PZxjxUUMpzeFFceZj9pLJ7/JlGhQmpTSaKqf5IfjNp8IjWcNqF2M?=
 =?us-ascii?Q?ZSORx2JVRuyMCd2IA634NSxiQn3GufBu0TvinbQrr+F2eQwXi4DsXdxKWSut?=
 =?us-ascii?Q?2G2ahp3+KsLF/UzIK2vW1GxRmlwvSuhvuEOfsULQkOe3auI3CBWOmyo+tX/e?=
 =?us-ascii?Q?0CP2YRiHOYlHA74JLR2Hc5xnzlusqkJwimxj0NhAPywA+D7QYcVo41yp7lpm?=
 =?us-ascii?Q?raV80LDgAXDSi5AqnMiSA8spis/MPgulR3Sq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:30:59.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9a3b10-18a8-4de4-c068-08dd8c99db31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The number of newly added de counts and the number of
newly added error addresses remain consistent
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 857693bcd8d4..52fb71c4ce9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -130,6 +130,7 @@ struct amdgpu_umc {
 
 	/* active mask for umc node instance */
 	unsigned long active_mask;
+	unsigned long err_addr_cnt;
 };
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0e404c074975..eb3f99dbbcd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -262,6 +262,9 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 				soc_pa, channel_index, umc_inst);
 	}
 
+	if (err_data)
+		adev->umc.err_addr_cnt = err_data->err_addr_cnt;
+
 out:
 	return ret;
 }
@@ -428,8 +431,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 		bank->regs[ACA_REG_IDX_ADDR]);
 
 	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-	count = ext_error_code == 0 ?
-		ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
+	if (umc_v12_0_is_deferred_error(adev, status))
+		count = ext_error_code == 0 ?
+			adev->umc.err_addr_cnt / adev->umc.retire_unit : 1ULL;
+	else
+		count = ext_error_code == 0 ?
+			ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
 
 	return aca_error_cache_log_bank_error(handle, &info, err_type, count);
 }
-- 
2.34.1

