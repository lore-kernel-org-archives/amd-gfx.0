Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C4C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BEB229C7
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BEB229C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311316E950;
	Tue,  8 Dec 2020 11:20:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6977B6E950
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 11:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsxMwfunXhp0Nxb8dAqosdyT0aY4k3y90TGa75Lsv4GcVe+SdscJ2PndNf+cmJq5FSByd2M+j/uWy4AcKlLZf0I4P+p5CFcTNBqDGINysuHSAanLmpF+eK+dUKYK7UEbBBLOQKPi8mD6sfPUA8gKos9GlxK63gG7r/FpAwWxzcJg8oeAaMIh3Bnz2nJlzkdjXD2VgXYZXyqzk0EMJOEBZApQbXNHP/YNiryF/+nJdfjhG6o7zDMdT5PeW527WvE3Ae6r/Cicw/n1cCemHpn2REutEObU7aH/2GCgrLqfOB/PA65cNYVuY04qgIHmOa7OfrPPUYx32/1Bjg+ZgkR3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTMIrcS31Rz8UNf66jVSwUHk/dYMRD+UuWG/RAoh0Oc=;
 b=Q5uOWESXqMXKyUYg1V7Y0KGapq79FuG3c4xWHwNS1CaVclXoqGsCc6i2Z5GQPu7J7hFFcI9pcsdHcEq7I7z5nEkKogUEfZoRFOAAAwN7CC1tHbZ7hBE0KQuQx1kxlVFz03sNf29uin+447oDpjtPqgFPcOYcxUGTi5pqrkEH5JbcGvIPETcr559lZ8q9GwIYK74BH4XjjYIUkiQAc4sIQ1iu0lXaJ/2iRBbcD/lV8sGb8+UCiDYjLG7QVH6JAsk1rZ9rVZOIkRUTIEKOznJA29OLoPBFucnv0kMS7GwghHwZfi3d67F80CBsG8lYbHApAoL5W/I97zU7u9l2SPFUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTMIrcS31Rz8UNf66jVSwUHk/dYMRD+UuWG/RAoh0Oc=;
 b=vL73mBBsbBpRytoxzyum3hbLgUYvAL3Y5JXOmSpuyDrUpnb31yxksFEN49Gl2b57odq4YNidGZKnkPL23hKQyJ5oFbOSSHPT7WW1TUT+3biSlhVyY50KhnoyvU+uolWCtdS0HxXaMWmrKm0+VIwRwiJNOt9JLdPL8YrxBcrYobs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 11:20:43 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.018; Tue, 8 Dec 2020
 11:20:43 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before start/stop
 rlc for vangogh
Date: Tue,  8 Dec 2020 19:19:42 +0800
Message-Id: <20201208111942.6292-3-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 11:20:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f35d4487-0d81-403b-8613-08d89b6b4d22
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270AC0DCD8152502EE5890F9FCD0@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV3uBB4jhMeZUiLrt/g6j8KCrkxQV0zkwmDa4ATicOmSHLclhTwkGkTJu/nK6jbvQAmy9Dev4GgjwQOXucJFulaZC0bsls93d/a4uy5b/4S8RoFHwo5X2Ft3hrN92OaH8vhq+HUCCUyEfHEsCt6vNNoRVf7vgRkhPOHyj6XJUVTRV7foBWmhV4BZr63pozQQ24Zi0MKdP3G356CnlBpDKMYSo6YHNNDm7HEOOWQEjEzwIqCFWLW5R5RoZbRCmoAjqjOAMbVvN4935xnkHAFuy0bcGcExraIQ/hinNwJ09zAFzIZWKOZlK84JQPjj7fX1/OrZf8hGVwHyI+ziBrloeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(316002)(1076003)(26005)(186003)(8936002)(2616005)(7696005)(66556008)(66476007)(66946007)(86362001)(6916009)(5660300002)(2906002)(52116002)(6486002)(36756003)(8676002)(956004)(4326008)(83380400001)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x1ts3dRGL2Sv15E2AcMhW5apQsneLgze7u9O1iSpk0UHaJizPAD4WtmfodvB?=
 =?us-ascii?Q?5QjyY3rVddhXL1hSaa5jEHbGlTzmFN9vOAQgUsQ1x5erm6vum2Z8EACkOeRI?=
 =?us-ascii?Q?p8+1eaFwSH2+5CECBGuXG/QonWesWdnewesc9nIQdgvfYA6EDA4s4QIwbHvU?=
 =?us-ascii?Q?mUIBIvnYCg65H0GDE92wltSD93IdwesOrU+2eZP+PCJdswVcfRLENpueCiE+?=
 =?us-ascii?Q?lt+Pe9Ey2XOkjKT/mt+ki8GttZbkEU7E5kJmy7gBTswoiGA/TMcECZlwRI25?=
 =?us-ascii?Q?HZj+pTw8N6Oy3GK7mnMMP386L025VU/0l6zroarCDJZ5r0jzU9HifKtZ9jCU?=
 =?us-ascii?Q?1pt+QVhn8HRguY8iuO1ax8y9XMpjTp05waVNuUS9kmHB50hV1w7fcal73mhm?=
 =?us-ascii?Q?FLwPB26YtdO6SZ93riR6MIPT+tI5hxPxCjpJVZH9GyAmIdJBj+C8qloWawIo?=
 =?us-ascii?Q?z43XN+iNBiX5ngbIV+BcgOpbGux2dKCT+rFJFVoqh49g54l/6WpxcubFNFTU?=
 =?us-ascii?Q?qv0Sz7gpcoxTBTYattYDj1yq4R2uH5RUpG/5hFzDgnb3dVrakvy/xzB1NAtI?=
 =?us-ascii?Q?zWk3MeBWGF4bHX79e0MxzWWdbz9mnGw+H+gUZKzfTBMQl2a3XJgefXcrxRNu?=
 =?us-ascii?Q?f+OfCVNK9zHeArSsFNrJiCUn/OtgeU7YqFt6ROptUyJkcjHCXMJbKzlrfXFW?=
 =?us-ascii?Q?+owmpOMjRXFb9AwA6PAIMJtgFmximP6xqBlGMwYlu6mZLjl/S0sXtLa8k7sy?=
 =?us-ascii?Q?S3IpUDw3UiKYAud+bK2rFmqCMd0wHyz/oBcQQInPLvbA3wks+FSCpVdU2bq5?=
 =?us-ascii?Q?LNM8nzxqO1uC7uRDCGX6jEf6fhhXJmEOGnoV4Br9bSGRLqtkiJzFKD4/m3Qu?=
 =?us-ascii?Q?H6SecdOdTBsKLHpAJstDWKA6tB/726SzSrGY+1Sx/OcR//mvv1SnUbWXtgKb?=
 =?us-ascii?Q?oenJXDGT9BEL3JzLu0nC+tnxfVtUC22eps+JadL1zITlnMcB0qIJfGPzZBLF?=
 =?us-ascii?Q?ZfWp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 11:20:42.9550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f35d4487-0d81-403b-8613-08d89b6b4d22
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DN6beTgk+tF6CEoglP3RKxZdcdQidIabLITT3C6lFpa4SqjszgNgviK9V02KSSJNWaeSGh/FmQWbrS32ZcqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RLC is halted when system suspend/shutdown. However, due to DPM enabled, PMFM is
unaware of RLC being halted and will continue sending messages, which would
eventually caused ACPI related hang. So send message to inform PMFM the rlc
status before start/stop rlc.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I7b1a04f6e249ac6753109079ecb3019c99161d9f
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..42a32c0e5bab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -920,6 +920,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret = 0;
 
+	if (adev->in_suspend && smu->is_apu) {
+		ret = smu_notify_rlc_status(smu, 1);
+		if (ret) {
+			dev_info(adev->dev, "Failed to notify rlc status!\n");
+			return ret;
+		}
+	}
+
 	if (adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
 		/* this is needed specifically */
@@ -1213,6 +1221,14 @@ static int smu_disable_dpms(struct smu_context *smu)
 			dev_err(adev->dev, "Failed to disable smu features.\n");
 	}
 
+	if (smu->is_apu) {
+		ret = smu_notify_rlc_status(smu, 0);
+		if (ret) {
+			dev_info(adev->dev, "Failed to notify rlc status!\n");
+			return ret;
+		}
+	}
+
 	if (adev->asic_type >= CHIP_NAVI10 &&
 	    adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
