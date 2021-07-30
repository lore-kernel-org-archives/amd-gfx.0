Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48862C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065236069E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 065236069E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA796F3A3;
	Fri, 30 Jul 2021 02:41:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C999A6F3A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7R4dMW/eHmVQXlGX4v5/izOEjtI6dVR3S1eFdWgk0ccBryFysdGhH6oRp2RHom5shFRZxy16XRNjKBEz5GPUFtLjMVa0oYdpc7GJhvHP9yR3/0RMiSjfgEYxR2cm5oaiZImdMIy5lt6AHuBOIR0aWxzXRlrEV7ljo12MrVgEcJ4yjYWJb+UPWzbAkzMvG8qQM/ZQv2sDq/8eWwcMoeYxyH04n4meWIneMasXSWEUNofsaGDl5wDDV8/XCWdvbgBq773AyyahCZwoxRpyywAF1NCd8Tefyd85+b4Yciz4u7whDl1a6+Y6F+iGAaUnWWosBqyZ8Fzspl/ifcIiP0RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJdG+WwNF3sQY8oAcp4qjt1Mbtott8KNX/VsjRfFlGo=;
 b=c0TrnUyW4r1I56/MfzMqmhzmIod+x9oQMjzfy3n8rDhjKVn2nQ/Q8Yr5mPW3AU+xyYKnvCT6i0UVmDT7hXt7O5fZoIICbV9H8dgcoIUlbni3BnN17bcFN2IFejyTAdsU1PfuaW1cVm7BmKnVpvKHhiUAjtDO9RpAz4lVBd6qpZudrWgVmQ/+PwfUJpDkkAsHy3s5SBg2a6NL8rk+nR0KHvHNo+Wg5ebgaNd4D6vcM/WOORTzG5il766Up1yX9TbnMHlKUskqR3fGhMF/a3YsF/yyi9kMSsXITmtMQkgWbCNNgT/auI2PxdyU7DCxW6qMPExFWHz4F6JM7gGjQ1XzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJdG+WwNF3sQY8oAcp4qjt1Mbtott8KNX/VsjRfFlGo=;
 b=xiA8SYYcjN3VIPt5BUO9G7CYIjWKadx6jkzZwpuPpYAEapkbTr5a8CjZTAJC9W1U8fA4YjTUwWNAGbi9m2bdulvalHACv/ZPUHwrsNvkja2ov8gj3+xfyi4ZZChSIL2WwQzYvSFbiIU8hzvBNtTe7/cHSMFm1K/lzHC8F0NYiI4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 02:41:12 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 02:41:12 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/pm: Downgrade SMU mismatch information messages
Date: Thu, 29 Jul 2021 21:40:50 -0500
Message-Id: <20210730024050.248-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730024050.248-1-mario.limonciello@amd.com>
References: <20210730024050.248-1-mario.limonciello@amd.com>
X-ClientProxiedBy: BN6PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:404:8e::15) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by
 BN6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:404:8e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.0 via Frontend Transport; Fri, 30 Jul 2021 02:41:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c23abe3-093c-4730-bff9-08d953037eba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26384B2FBE08159303652220E2EC9@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PYtTh3ZJu+oC2PGB1+lkd7BSBs+I3e1fwUT5lIdhyqT2SyG1aqmXRQjJ96eNUlmud/DygQCcUVePFQvxKI50Kfo5bIWTcFEr/tZpFYbyeP01woF0oowwPbDVayc4eOPBnGmTgaKpsCOQtmUPPIW78U94sNuyM97s7VBRF4UvTpE7nRLu7zv8NCSOztmQXuw4NBNJZ5gYfY3+pnLg4UvMnAkQMXWwrtbadyFqdJrCL8BoM/jerX+sVp25XpptsRjXH7pc5CtK7Hh3zeVYj3rTN7J/fF5qcKEgGgGXwrTtiVFza/4ASVX/opykQMfCRdcyKUikwZaRntHERUxVEnbFMvY9F7ooWmUe7fhxUglgPytvcCNwnneeaxhWv09IXhZGoCO+BssL7Cx69+yGL2C51wI/ozpGxufOqOENdytGQQ8EVcjPNdE3GTcI56TF9HeBsJN+acutAFIXmJFGRs3AxUAjUDOiDVPBe0kIlv9mHFEZscJP8gB6cGXtadQMOjQf3+pO/6csU0qaqr//2ovVPVOx5464bd4yzWOnAcU+45N/V2oWRrE8Ba4lc1sS9R+AGoH5IhXX0oRaGdTKQyQ5Pdr8ZPCMCqwrsL66+MEEQbtsavjaBPKyQmy6lmIWJ3VHA6fmQCyGMaqDgSQQIEQsSDOx+Pq5N3sSikXZW5CcpzWXn1SytojC0e9CU9+CdSjziuO0JgnGXJkus/Z/l80vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(2906002)(83380400001)(6486002)(8676002)(478600001)(8936002)(52116002)(38350700002)(5660300002)(7696005)(86362001)(38100700002)(316002)(4326008)(1076003)(44832011)(66556008)(6666004)(36756003)(186003)(66476007)(66946007)(26005)(956004)(15650500001)(2616005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7OR/NIeRWnPdPpNLd2OOOxoHns2P16QIX1wxab9mob7bLUuKQKK12Y1ftACS?=
 =?us-ascii?Q?C9bunEd2l77l2tX4ewVbWkV8Zz2CQHcKznw58SE41xJVQcxSyxFQk2FWkJ48?=
 =?us-ascii?Q?R/CQOQCJnD0wbb89Lrjne7EpkcfZgiRLGrqLQKBi6bSTchr+GMK3U71/WQch?=
 =?us-ascii?Q?WoT7DEUuKER37/Ha34lcMDaox3apUw3G1OeBlLMS6/eKQ1cADy3Upppt07gg?=
 =?us-ascii?Q?4Crra7E1XA7OzX52ZqstZtM372nh7axDJpuyS3Tb0+f9QbRW4chVyxG2aehk?=
 =?us-ascii?Q?g/QaNziAg/oVWFjTnjX/FLvHtMjXnr+XCr6TAUJQE6guXlNu73xnW0bhXWRB?=
 =?us-ascii?Q?7NqfRsnvKtJQFcfumpM/5bj5a3QPT4CbBmPASALDmdKoXbVPmSXoPkkb2vtZ?=
 =?us-ascii?Q?IsA4nIdOk2lajLLOyUL8NlroPG3Cq/nMVA2l+nE4b7PS5ulzNc4CcHjPgcXR?=
 =?us-ascii?Q?PgpDH/LY08bThvOzQ6E22HRbaqvSHTgy5De54mwhmMu3F/Ig0aAe7AxAnI3X?=
 =?us-ascii?Q?PxAh3p663si1uheMRZpqgISCGLVfHM9bpSgKrFozVfF3oYbxih7ytu/AKyqb?=
 =?us-ascii?Q?2wbYqRnhkJTF+67RlJ5RKfoHP2sW7xkVT33gCnZ3AiFfxCIPVgcvA3atfsBo?=
 =?us-ascii?Q?TGLbv6SBS6FPYNQf/k+jiqldvJsA7qlfnEi3owA237R0s20YEZDFumAmJrFF?=
 =?us-ascii?Q?ScxZuV/p735bihs9LZTzuNNB71z7QW9Y+WWbSCzpROD4/GbSevx0/09jZWPh?=
 =?us-ascii?Q?xcGU1Y5Fm2IFV93HsPOiGjOpAdWcwY4SgUkk944OIFaHvw8gz4YLprCacjv3?=
 =?us-ascii?Q?owIfVvM7ogRR5IXGNTceJK0LrFtYA2wzf0nKMMhRtsp+S1HoX2gjmshx3Ezt?=
 =?us-ascii?Q?LV2Ay8BK5E8F1O80E1xtCTPTAR0DlXmyv6e4rQCkhyiFiX8DX77u7X3PAjna?=
 =?us-ascii?Q?4jA7wqW/LJxeRK2KHKRw5M+FtZrkLiJ713Be5uLWbV4aQ67S7xhcicZtnIiu?=
 =?us-ascii?Q?aNjvcr6rS5s9OGPf4qee1lTwwtVOShivgFaPo3TmykeG2AOCkMic3i7y3k0s?=
 =?us-ascii?Q?lu+gUrd96llrBgAmkTrGw0Wgc5+7eIFCKp5aXLVYYQ7ko/7TLI6HhsrqfMyy?=
 =?us-ascii?Q?izAT+8UXxjXUshxGo5WQfI2NaJt7aP3JH3caO3K9pyBMbxy3LsUUZLWQrbbU?=
 =?us-ascii?Q?wLaf4SK66NutyAF96MSCIlbKFo86Og0Q4uATg9TcvD9KdLG1Dw/zGt7N1pbu?=
 =?us-ascii?Q?b7iC38IXxsbOgUT1Bj9QdKOagazXgCKGqpCe/31fVl6s5xYfCNWDKRwzcVQZ?=
 =?us-ascii?Q?Qm8O7EeTWs1IRix1XpIcRaSf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c23abe3-093c-4730-bff9-08d953037eba
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 02:41:12.7015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KxoPpsbmyeUbDoLtmvBcwmFTZuOzfqyi3S9nPeWMiQ0kqyhdIuW6vQaulkNbqKf1K3KGZ3COxNiwmcClqMx3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SMU driver interface and firmware interface messages have comments
indicating that they are backwards compatible.  Don't output at WARN
level and scare people there is a problem.  Instead bring it down to
INFO level and the details about the mismatch into DEBUG levels.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 15 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 15 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 17 +++++++++--------
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b5419e8eba89..1fb2129899e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -224,17 +224,12 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
 	int ret = 0;
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
-	smu_major = (smu_version >> 16) & 0xffff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
 	if (smu->is_apu)
 		adev->pm.fw_version = smu_version;
 
@@ -284,11 +279,17 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		uint8_t smu_minor, smu_debug;
+		uint16_t smu_major;
+
+		smu_major = (smu_version >> 16) & 0xffff;
+		smu_minor = (smu_version >> 8) & 0xff;
+		smu_debug = (smu_version >> 0) & 0xff;
+		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			"smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index d60b8c5e8715..ddd6bd5c78d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -74,17 +74,12 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
 	int ret = 0;
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
-	smu_major = (smu_version >> 16) & 0xffff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
 	if (smu->is_apu)
 		adev->pm.fw_version = smu_version;
 
@@ -97,11 +92,17 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		uint8_t smu_minor, smu_debug;
+		uint16_t smu_major;
+
+		smu_major = (smu_version >> 16) & 0xffff;
+		smu_minor = (smu_version >> 8) & 0xff;
+		smu_debug = (smu_version >> 0) & 0xff;
+		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			"smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9c99c51740a1..242d3cc6a79b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -194,18 +194,12 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 int smu_v13_0_check_fw_version(struct smu_context *smu)
 {
 	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint16_t smu_major;
-	uint8_t smu_minor, smu_debug;
 	int ret = 0;
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
-	smu_major = (smu_version >> 16) & 0xffff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
-
 	switch (smu->adev->asic_type) {
 	case CHIP_ALDEBARAN:
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
@@ -228,11 +222,18 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		uint8_t smu_minor, smu_debug;
+		uint16_t smu_major;
+
+		smu_major = (smu_version >> 16) & 0xffff;
+		smu_minor = (smu_version >> 8) & 0xff;
+		smu_debug = (smu_version >> 0) & 0xff;
+
+		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
