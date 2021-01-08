Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F24DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE3322248
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE3322248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EB86E7DA;
	Fri,  8 Jan 2021 08:55:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A1D6E7DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5a+5h+tjoy+MTzr5urPvKXZPyaToZcT+OotHo9W8rB+pqx1hp3nN4Mj9ON5T37vhStTrDEY8+dBhrH3R7CaH38J9RfK5bsUIAaG66qCGXVBbRHBMFFIAoNNW5IFksqaOrje/kgGnh+DjFWgGhEumu9HB+F7gUohbq4UTcicaM2SgzPWioMp+lvMMJ0ostxztTPAEfxlxaDB0rmJAM8RH27h7Pzwa7x4O4MzHwDYd4RqdC7cxaxvjuEoGL8OcpBGm0LFJfx1P8jpNGMrMbcupfQCPt/tOgNMRmSP9qgy/vKntPvaSdHojaKpdCrfKzCoAS0tS5ddCHTgUtvjqLJOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwu7qFq47IEVUhiEHi7k9FklObvVTL5ImbQxWeTZhCc=;
 b=DV9gD4De5gBLCtkR5cyp3Ae673bHaX1vqywI0VzY1+DvjFx71ewIGnw/QRor/gzVsobw8r4G3+D4CMc/XBPI4ZHZZVNZizFb4gzDWhysncHXNy4NGyIAjR4S4e4zzHTIyDxDbj1RRmPyjanwh47tlNVwypfwy8veKB5FljisY0YHHT/FDB6lATQF8iAxDBTw++4ZVoTavLWTtx7mrtlGh96ls2pUHPzx6hyR72yrlsHHF2eYm1Otu0P5Z4T7j5YE2LXaa4vCc4RqRfTGEoK0hepqnMlhcHbasDq2leB5twu3QethSJkElqaGajVz+Z/CUZi8V1wU+E9rTN2mc3OkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwu7qFq47IEVUhiEHi7k9FklObvVTL5ImbQxWeTZhCc=;
 b=iWQYYL+nqD5aZ2FB+SW6reYp3sOtWNme/hFN3QvFNS4E25kPBfigqYfjZfMMFiVowO6xiieU6p5TIgmQggfXoALYxpBhB2RBTZKNpC4hROoNNLf2X+JG6GJTEcEJ4ClR4igt104yAk93+DSnbHQ4uCQRtDq2FlhO3gyQBpRPnsQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:31 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:31 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amd/pm: remove vcn/jpeg powergating feature checking
 for vangogh
Date: Fri,  8 Jan 2021 16:55:01 +0800
Message-Id: <20210108085507.1164588-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1fd33d9-75d0-4d6b-58e0-08d8b3b327b0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458245B9B56A337A96EF5CFECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHwCCIrwUKn7wGm3btOArcFN1Ctm1bHvvbfj7QL9fp7rzKGdfjUaIoVWwpvM5iiWdD4SttMTeA9MqV3jCodhicKiE5kSJ5ei8H+e0aQORHyan5whDtJ1X2bc9cgC95FEE9SUsHYIeZtJPx2OiaH0igVBPq4h2n36H2/B82WUsuWjJxLdvNCG+5kYBPVOPQ/Q4lAhUn4l5i88Y32NssLM+Qp8YmE/PhFDTvVAzBfjFkcRZGkMVvA48mQVj4vS7V46CpNZSlhPPfBlJQdV97bkpRWRit176638cVsAVAYKpq3Ze52NLN1gd5PZAXqTPFkR1vel8SLaAOcIFUnU6Jxilgh1Dc03IYMMH4DZTW8dfGlKkiavY+EAM08uQOAG8bZcahlKO2M7jzsOs/ObjFr6oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?afseZd1O6g4i0R1IcmROddA11Uxy9/MNeTpMAMOp7HYuTL14BfvKUkFq9hne?=
 =?us-ascii?Q?TeoIvxP0hBqKd2zHyqxOWYRQJXvpsLmKyaZ62XDBRHyoxHup01655uIkzbpr?=
 =?us-ascii?Q?VUW+AZ0gNIx+HnJkHxmlzvQYLdtJK7G2vZwRRoH5/QfX9xwqeDqAXh6nLfpw?=
 =?us-ascii?Q?8ij74DKJsl18Lu/yrAi4Gc3Y2w5Lr8QMLgC8ePlleNioBpyGC/KlsU4XVXwl?=
 =?us-ascii?Q?ZK2hecI+Yz3wJHaA6EmGXoLo6XmNtgAdH6x1DA60HVy1WeLyBFVD5gAA14R5?=
 =?us-ascii?Q?rr/1wBQ2BaH4+M1mphKxapNNL9yBzBgbq5bddzoK9aK/KvqgomGJgqjLt3jZ?=
 =?us-ascii?Q?wqFhnPENOKAFnZBJh23uUVQXX7kJnKuIJ9pZBzmzpB8vVoftmvXyaSP2XokB?=
 =?us-ascii?Q?h+HLL/xby4310CohgAcm0JyXHcpoFCBawv1O6DVE6fIoHcawFVMGiPwI6Blk?=
 =?us-ascii?Q?VA+rTjCRHB4G39MBqntBCzWSlbIu3qVm0GV0rLnPIsN8Ff+1ETtUjvY1IrIG?=
 =?us-ascii?Q?vS3/L2JrzrW/4XmZyVb891QMmHmGclTBHQqih/BdG256riOhzSkRDIhlAgKH?=
 =?us-ascii?Q?QVa3wyjbdZjbYo2YQa2fuzfPap9N4P3l0aecKWgTAmdpH2wRapqaPxMv4QIE?=
 =?us-ascii?Q?3z8sPMfvnknUKI2IH0NTzFt05j/LGlKqQlbGJE5xeuEjgFOP3XoWvyDsiFS4?=
 =?us-ascii?Q?Eir5CaYVErXAlkNyj5717S4QRajHk9j+NG2hwJVU3qUEqojWD2oQB7sgzbWy?=
 =?us-ascii?Q?Pq2Lsof/2R/twxjwh+gsl3HK5P8Lr2WlUKaNc2oobhiZpd0pC6PvqTygYkxV?=
 =?us-ascii?Q?Gs7sjq50MsabahVDrHIUNJiwiOUbat1Bcl3fEVKT99VD7GOn4eo9Tf9jHQZg?=
 =?us-ascii?Q?eNw9XEBhWIiaHRdIZx0ERTCTmaGmsk4WeYU4pAC/AWcrMd/gKLVIpo8svAsy?=
 =?us-ascii?Q?JfOiKcE8LxnidylZrWakzvT+7QpeEcgR9aSN+YL2jO0QsnrHGDh+G4nvpZuX?=
 =?us-ascii?Q?XI0y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:31.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fd33d9-75d0-4d6b-58e0-08d8b3b327b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2BzEvmMOhRzRcwm0A3tJcuDoQaCYPTt0SV3yirCZov4gElWpe7+Khn97IwNqy1CokC4mXBpHxuFhhTzwFZR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN/JPEG PG won't be a feature mask bit which exposed by vangogh smu
firmware. So remove it.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d0417eb93d05..fc091091eaed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -330,17 +330,13 @@ static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
-			if (ret)
-				return ret;
-		}
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+		if (ret)
+			return ret;
 	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
-			if (ret)
-				return ret;
-		}
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
+		if (ret)
+			return ret;
 	}
 
 	return ret;
@@ -351,17 +347,13 @@ static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
-			if (ret)
-				return ret;
-		}
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+		if (ret)
+			return ret;
 	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
-			if (ret)
-				return ret;
-		}
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+		if (ret)
+			return ret;
 	}
 
 	return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
