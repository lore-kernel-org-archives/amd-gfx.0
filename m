Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14FAC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 16:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EF560EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 16:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97EF560EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF626E3EF;
	Fri, 30 Jul 2021 16:02:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229006E3EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 16:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRGW4UBJzMWkTNFi1xo6hE5eZKpNG77IYo8k6EdzWL1LSXNunsca8Co6N4nP7UH1IJlbt+73X0ygemVR+V93q+1cKNNgIz8VxoDe+UvAvvVYIaBsxvr9RI6XWLHhJWelWoRlUXd7LmjYtUTkT9jb5UxjRWu6HeHtKaqbMLcwi0bm9XByfC/EYKgoYHp2btDxRL2FKTXN+t0RYT8Nn07VrbjlgJpV6xwXrXiXPnoTHfHReFcdARn+zo2q50iW64VVKdc7DpE/LXD8Y9rmFTkpvl1Krcs/NjdIFA3IgmyrYYV4oOf67QF1zD9LkOnGCX/iScz9fvQX03SrlZ32Axx4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSh0pfK2Tuh3fo0DFa1JolwuyCoBQxGWkgvdsUcLmBo=;
 b=FM3voBTP81qRgVY9eDLhLbX8zvxYQYCBu3WuZXlDpqPhclCoNYMUAb9WzKgCU6qAS9bt/0WayXlL3oahcp8vp2/QTcb0J8ckRNXRzq+/yA2swcvqArnVLod53vjKCEUO2p0okRbO0guycJogTG22bsPbIvkwVUDZp1nG0+FeXhf/o/C4PB3X/YE1eIWbsD0ERl7QN26hHlHf6AsVFQDyAmXbtmNUWq9cQmjp5uuFRdx2NO87hDSzVShnt605IzsWH0r8iikvWrIq+9+Ddhn7xBwjLtVXXJCgGDNERgH2y0rjmFKRYd2URn1fLiJ4qNEO5Cbq5ZrEjZkoGNoCXCxiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSh0pfK2Tuh3fo0DFa1JolwuyCoBQxGWkgvdsUcLmBo=;
 b=jEEUsy0pPpkkq4jQEaMTmWv+k4QVKW3e2Ul+XduKGxsuiW7wMXVd9gPkCqVEnthbQyjT8viDCtiEeUh2vE+ivW/UaJmEJWXBxb85bEq4r1KA2LCgEFpg69TVrzok5wzsj3tyVE5lkVMDMB3GqPluV3pUUzLDepX5a3RShLy8oGk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 16:02:49 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 16:02:49 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] drm/amd/pm: Downgrade SMU mismatch information messages
Date: Fri, 30 Jul 2021 11:02:31 -0500
Message-Id: <20210730160231.3594-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730160231.3594-1-mario.limonciello@amd.com>
References: <20210730160231.3594-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by
 SN6PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:805:106::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.0 via Frontend
 Transport; Fri, 30 Jul 2021 16:02:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b37e9750-0eef-4d47-cae5-08d953737a87
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416883259845DFD2BE7E162E2EC9@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrQwH1mMo6/MynDb+hCrWm5XN9EYxcP2UfNbDpptHaYMD0mjioWBSYmCjAqarqBrrUwKczYN5em+7Vl9S7uRA7Pc5S/aaqRmOjezbaEcNYLSY538rp7fpolA/yASVEQgem5CbwWa3s6DumR34Ukv6ZSivQzDlonn/mp6RMM4Xc/LjQtBzsK6IRpPP5A2cviMkec9PKFR4KlhLPbk0Shjjoqag4pPagZhoYKy9PLuF4H4bE0cVxkvAmeljdx3oP0D7+GkQnE1Bjfe/DzpA8DfIQi0Un8vFIOtwxkxwWsvmIeumdVtoVuh8YPG+408F79g+44jRrNizz7SCjQY6tWSQcINtUFxyeII5pyQJFIGwtT3WYAwPxzZb1gSyNN1hcwBZO/H1FgY2nOvswTpWqKPaCzBbFXmksKMMOgx5b0MxBpK51PyM42gBanye5Qv0J7ZWLhLarMGvcL1TwGQlE3qADr7mTHh53fntO9W4DST0Q+UIZHq9w6Xh3OvcVaZt5UT11l2NLA0su3Z06hOEHeqHy8PTXFnPSKHqCv2bi5zeQ/osN7uF/JebiAMWhMV3qnk4mY5QzNk+vdbMiy/hYvKg5vLdCuIwlbB0X6Vd+WoGDsKa1mz5xUr/tMDvPbgSpx51SNC36mIGRDZ2rNJ22BZehmsQv9tNlNvpWrWfWfFWO/Uj2ZB3iUq8Hsk4bSPnM6h99YEKBmqkJCTwHQe1iNkcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6916009)(6486002)(4326008)(316002)(15650500001)(6666004)(8936002)(2616005)(186003)(956004)(86362001)(26005)(83380400001)(66476007)(52116002)(66556008)(66946007)(7696005)(2906002)(36756003)(8676002)(1076003)(38350700002)(44832011)(38100700002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c99l2ea1HYwWeJN6sR3BJbSMU4QrWtJOy8g5648R7P3k1tETpZ6JNobjihxz?=
 =?us-ascii?Q?O17Nvl9zczg+qS9/4LS6sWLRnSdV9YI7An0yq3PSVxenzAoENbxCkVqnFGiJ?=
 =?us-ascii?Q?14GhDYQRjMMhYo5VnZcEPuXXCScwC3jdCG+UJavP/KJrEKx2MAfZF2DU2vaC?=
 =?us-ascii?Q?LxPpPSktwcFf+LZuXdNpsuFxijkVg2fA73af2tRsDF5cDpMZqwu/g5nCDTNH?=
 =?us-ascii?Q?9d+n+n0BcynsPE+aBEGP+SGIbwlPHq7IB2KCHRRE43PfjjSBSfv5u0f/9i9q?=
 =?us-ascii?Q?uzXLofj8Mn73NbxcCF5JI+dSvRMUN9b1TywR5Hlcjv42BTvwyjrBTIwR0HHJ?=
 =?us-ascii?Q?SdgUdUfS3mh4txpJPAe+C6GF17arE5z2BNUi1FxivYDBBYd7cksutc7GbY+D?=
 =?us-ascii?Q?Ey1rX3F+tKpCqPwCZqgA8N1fAaTanf6KR3yCHxOjIpdk9I62HUBGryFHLA53?=
 =?us-ascii?Q?QRIcnrrjejIi1E5oEak+xU3MCxjMhgH4AgoFMiyFibBLIxdovGw0kZMJQww3?=
 =?us-ascii?Q?fUXsW7T2vXu/MSZiTeHkCIu7LxGYg/G5lQCMoPOrTlcetaC5EecvH+MEgAD9?=
 =?us-ascii?Q?i3EmlZCpt7nLhl5c/qDkKb7MhkXG72xLyVzujLDEi1bratxafkJQnmmGAzy8?=
 =?us-ascii?Q?+OuY0Nijf7PND+FuSYWD4ic47kjx2i9NL2w2aQGuTYV7J4Vshs9LraV4NB1n?=
 =?us-ascii?Q?PJKaKEuO7qzdAw+Z/gvq3Jd/MXlqLugk73DITxrkqGJzcG+I69mAUubLp70c?=
 =?us-ascii?Q?NdDWYuf+/6rkoqjFsDuwKWh3pmDOobfvdFOwxBPgxXwaMoORXoC/l+jQ+brm?=
 =?us-ascii?Q?Ul9/ushkwe8gqZMrzP4d1cvQcvRDsQvpGbPR3aMfUWqiTj9nR8dpHcCQI1vc?=
 =?us-ascii?Q?B2iPN2B22fLxr5aD8cuas4ZPlNcjHHIjEHSWajEhyni84RmmBVhvFgZPBaFP?=
 =?us-ascii?Q?psZTQES4ysPmTItHW+Ve29kPzJqFO7aCQjwCfBIA2aX4hdBkE+Ao3yRmQLCR?=
 =?us-ascii?Q?7o5lHmPK6+DLeYrDBpHHJZsZzQXU2twVQAUF1E0KcfsQXWeODcZnxbKARHyn?=
 =?us-ascii?Q?BtK+GVu6HwPiJkNRSiWi9ECYLDkhBEjrGKb8glGD82oWs1XSuGhhxNzUvKRj?=
 =?us-ascii?Q?Hw7ijQS0ZxE79egQ7wsnLgZej5KhaI1Wu3ZpnjWFdmcTr95s6PKZNQek35X3?=
 =?us-ascii?Q?5GRXBSx4Y0wyap1gbspSi/WstLvmlNBzSdmdYJUWLx9yijVARFTYHKokpMGK?=
 =?us-ascii?Q?OkY0BjEfNRV04TTzp5d4/h8JGhvgXrFgVItKj3/eFwoSv528jwWJbNeHkXgQ?=
 =?us-ascii?Q?1oTY96hIxqxPtdXVbSIN6FNS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e9750-0eef-4d47-cae5-08d953737a87
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 16:02:49.3183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qnfh3ofuacM49kXfdt8Ah6WvZhatorwwq+iSmsrA3gtas28c/dR9rt0+sEI0hD/dUzfsuP9I2/BjZl/GjiT4pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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

The SMU driver interface and firmware interface messages have comments
indicating that they are backwards compatible.  As end users can't do
anything about this and it's OK downgrade the details to debugging.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 13 +++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 13 +++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

v1->v2:
 * Downgrade information to debug, but leave warning in place
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0a5d46ac9ccd..9af4b18e5e5e 100644
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
 
@@ -281,7 +276,13 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index d60b8c5e8715..6368eb160a48 100644
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
 
@@ -97,7 +92,13 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e946314e1f90..1d3ffcca81ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -231,7 +231,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_version, smu_major, smu_minor, smu_debug);
-- 
2.25.1

