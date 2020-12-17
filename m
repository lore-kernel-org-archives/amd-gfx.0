Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40701C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 02:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEA323406
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 02:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEA323406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562598921B;
	Thu, 17 Dec 2020 02:57:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747E88921B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 02:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwT/KJq7buaamomxdZDVilUUb8H9iQUVJAct4OD3b923Vc33Q/ze3rknr/ZC2m75dom++r3mT/++NM+hvFqQMD7UkleHtzWN2ftUnpZdPlPEw/knHE12Du7Nu1B5tnHfrU9OBm1SNVBN9e/ovHKMD/IiLYwkHFsUDIkWhvhv+CWNP39fW/cQT+7Hxn3JqihROOw4Mjmn9VBAroZ7xfRdAZQOOHldG38HiEaCQ7M4a3mu7kA41x3sXB/PvmJXRDi+d352DiuKl0QSmqRyp/4oEgvBWeve0ksE4WMA/3Ws25VyPVyQm4h8rRonmctNCPnF4ajHw7kCaX3Lg7zoTJ1Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgK85B0yfcIYjJ/nso6Po2oz+M9NAMyfOrAJrnrpMnk=;
 b=keEa63UajqW3F9LvXGOgzNMwCt0BuxauWPFtElOoCF2C4V4co++4MWHQLm44HI5OvTV1fxt4bJ31OngEii/jNPwHtUpoEPK1NNivKbSeKo9aPe3GvCCxFdkIiv3DFKfi0tZl8fImrS+u18UUGdlrbkcmHITncGxKGTPEqs1sZo77otcCfhdyEN1HJgZh7MpDnYvNzOssifT1EDTi/EHsIhC78BzRhgXMPr4AomDi67JkjStoN7vE9Hl4FXFuXBwb8yRfBLpppFoiZ8yLLt9hNw57Z1QM95NEEBk4sgGIMT5NmvPu6FXQ2XZGKDa8I+Z8xFcaXyU2SuEoPF78CpiC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgK85B0yfcIYjJ/nso6Po2oz+M9NAMyfOrAJrnrpMnk=;
 b=Gf9XLYNZq25cXGF+uEXweIvo3MO+imbNNKBCbjtFXsTesGEfHrTMviDEKl5lJYx/8WOhDGTZ2SiuZyyN9yz6lDMdAWlolxYCyrPy+RDnoX+u2/ZWTT9VQu0MkTg6zUq/6SufGpXVij7GSJMF4GjJKj50tC1DDwqY9uI2TcQaWmM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Thu, 17 Dec
 2020 02:57:22 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.032; Thu, 17 Dec 2020
 02:57:22 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com
Subject: [PATCH] drm/amd/pm: add pmfw version check before issuing
 RlcPowerNotify message
Date: Thu, 17 Dec 2020 10:57:01 +0800
Message-Id: <20201217025701.22622-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.9 via Frontend Transport; Thu, 17 Dec 2020 02:57:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 778fd2fe-9b16-4c0f-db3f-08d8a2377a0c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40931D73A6C54E83253DEEF69FC40@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7zLgOkCXzsf3pgE4Y3FZKW4cUJmHXdP4pw2K8FwtlWiWDhwB5+JROYAjsr/jpQxgNLccfaI4g/DpAsJXfa+TQBiSe7pAWO/YUsss+HhY3nvNUXfvQjBPgZ9yrZZSlb9K28bODdkhUMXcC9jU7tKG05091JrQir5Lhw4cWglmvT11mi9Qpn7I8o2lTJOX32h/xuTPNFCRhzx7kbuM7mYm6UveGVYB7Ify5Ec8v4aSAJMktKr3vrwbVX8YqXMWS14D6wLrZFgR2NISq8djGZpS5AIQ7GhnfWI40qOGzhRa2zR3UyCmhlq3gsPoZ2iEDPyfy4w4RDjRdm9e/PWHfg69w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(956004)(2616005)(7696005)(1076003)(26005)(316002)(6636002)(15650500001)(8676002)(83380400001)(186003)(36756003)(16526019)(2906002)(5660300002)(86362001)(478600001)(52116002)(66946007)(6486002)(66476007)(6666004)(4326008)(66556008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qhVBjGGK2EcnfKIxVXUaM+cb+OVZS09GhjbwgPjL53FrqczlnDKNbq8AoS5g?=
 =?us-ascii?Q?3CYB9Sn5ur9Aj974QPUfksWUhWLFHnbFacvj3ZeWJu62/yAyqqUA0X1kwsfq?=
 =?us-ascii?Q?ovkGQfAlMIFc8xQ68VD+Qth8lOE5jHqDefjFXO8a18CFRiLwWRjF+1imqvun?=
 =?us-ascii?Q?BKyMqQuY4hFW72JBcKowBudC2+Hq8caySpnMCbFw8LYMM17D3SIAfPUyLRfm?=
 =?us-ascii?Q?5Ua5ewliR602RS9K5kMhqOnAC0i8gHAUtBzT0+dmRbOxGvbo8t6mNvwkzN0j?=
 =?us-ascii?Q?fqWkS/t7LDiYY9uULgT6vf3UWJGSlXpwI018aDqKeC6AmwksUZemWKlgfygk?=
 =?us-ascii?Q?YSKEXaeIWPmTFEnJ/GMBWCo4gplOvQ+nM6uAaabyfUgD7kaNxvodltOk34e8?=
 =?us-ascii?Q?oVs1uO9unhcJpHdTQvqBS80f9MD2r0ABJFVSDJwEsUD8/yceYXWvcl1aEo5U?=
 =?us-ascii?Q?4b5haDtptdUyvpZLPsrLpIReMz+RReLPNLRL3iUyGhZSnIH7j21jiuHQ0A/b?=
 =?us-ascii?Q?iqFid1Eka42VfzflQGUsKQX+ffXxHbMeyRhgFf0WD9TTLJyv0j1h0VwG64Es?=
 =?us-ascii?Q?l58AJvMylX4mPMH19QydNwLvjuZ96fQVMuvD8NDXCuT2Qm9OQunIeM/ITwTO?=
 =?us-ascii?Q?x5zmMfb47g+lEGRFUf2EEVmVRplfn5jN6SJ3LD9XQ4ZU+2yxDglEpQflcWu1?=
 =?us-ascii?Q?lis7TBMc/yrL+qOgFyOHLNdK5w+70hKmCw8onvcAnItSHZey3+IgXICDOnz3?=
 =?us-ascii?Q?7Q1rzFzkm8dTbyL2/BnlASise7iPS7YJPDVeGQeUq5xJDZcmm5cUwueVJj/0?=
 =?us-ascii?Q?NcO4zRy2w4f01/JiqNEzM7ZarnVKoTn2UOMwgavfckqIgt8znt/+TkWJbXmi?=
 =?us-ascii?Q?IjU0QNaO6PFfdDMBMqZBdJNxgE9NbBza4CcjQl1uojQybpPAgfZU9Zz2iCGc?=
 =?us-ascii?Q?m2us+9uFNj7wyRLRcWMUM5vUNrqqNP/Zh8oa24QTpA2+JWFeRmoG+a/2rSdt?=
 =?us-ascii?Q?RiML?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 02:57:22.6979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 778fd2fe-9b16-4c0f-db3f-08d8a2377a0c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P6MM3KsrW2aGfMrGHis54V89HicPd8J7uerkxazl6NM54uYMXZNboPlEu3N+r/1O4jeqKXmN8n9avc7CzoE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only pmfw version behind v4.63.23.00 could support this message.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 9bccf2ad038c..8cb4fcee9a2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -724,8 +724,13 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 
 static int vangogh_system_features_control(struct smu_context *smu, bool en)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
-					en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->pm.fw_version >= 0x43f1700)
+		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+						en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
+	else
+		return 0;
 }
 
 static const struct pptable_funcs vangogh_ppt_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
