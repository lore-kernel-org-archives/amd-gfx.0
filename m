Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62053C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E502078A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TcPyFTe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E502078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AF16E1A3;
	Fri, 16 Oct 2020 03:20:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24616E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc9X6Bnsrm3TET/WG2ty+dOe0W5gQUBGkxuCszpuMXVsQ4yxT3HoFGrB9o0ldxQdMXQlr/EKEQ6SbfcCakPzBDz4nG8op7aneDlsF5z+GyzRrF7/PHM4wnsBNsoqidVXEC3y+M7qZip+BxI1OYzmmqz93OfVip+bbK9gourYgsF0ZBRufKl37TyAWouqrnc5i9wttJNPduZS7Xu8t/qNhtHIYtKDgkBlLvlK9nwwn0utEG2QJ+t5HSEYXYMrl8tGw5LFxYXt1srcuuSjtB9h0VTEqbsngYyFNkd1R2Ah/9tLsCaG3T5rdJj0/QSQpbDXXNDB76J0Ffb3fxfih9cuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/h0EsEVN8vpk3HKwFPD79HupYkKSNTXJRuuFy/MbJw=;
 b=OIDlWSv/anUphWbe29flmjeEysfM9X4lIK+zUqMVGJuvXVzZ/wOPFgJ1UNGv6XUFBnH6qOew8jANTqVQLR1gbuiaw5zdhES5hIt6moIcc0wiVBM5Mpn+00hRAPAdIQ2y8ofVCmZFhYOV0jnzgiN/RyBEsgMTH/TbHH84MhdRXjfMFCXkDMu5RoUrmMAlnGG3czC+DJMNecOt5ll8KL6EfgNLc3MwwWmmEukIhgu6lGcK+tN8CopZkxxmdGxMC9lu7r4W1xLsGAxHVRA6x8s7dSV14gWI2Dkbz/23wKspu+ssoadWekmLfEYzBCpLYYkya610LHm3ej2lshky4KATeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/h0EsEVN8vpk3HKwFPD79HupYkKSNTXJRuuFy/MbJw=;
 b=TcPyFTe9u9KMSnnlHfD/n7m1cwyKY9plGe/+E5OotMETELr6yU5gOkquCq/4WYhNivJCbiPyCN0jESTPCOo1vJwtasGg2b3TusqVmkNRKJJSJg4Mx1jx0/rC5o+wEXWz/QKoEy+dFs3+mP+sgQTUFFL3L7ze1v+c/tk1bEtiHEQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Fri, 16 Oct
 2020 03:20:35 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:20:35 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/swsmu: Add missing feature map for sienna_cichlid
Date: Fri, 16 Oct 2020 11:20:04 +0800
Message-Id: <20201016032004.16843-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:20:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2d1efd1-48e5-44b5-ebd8-08d8718271d8
X-MS-TrafficTypeDiagnostic: MN2PR12MB2989:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB29890F7F92F8ECD4E1F2DB87A2030@MN2PR12MB2989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtJWU8QwhGAdNBWfiOv5Ztr+ctci12/3EZN7Piky+KU9VwUS4vN+OnuxhoElNj1GfwacJRXW0nI6a1R/PnXUnkRtXj8CZ3s8piXZkW1+F/fR+OZLiXW11vnypxmOUNbdPcO/xbKuAKU4M0UuFg5lA7RFh1CXOKMdbOe9Sa4TDtkI7FKfQT2SEv/YQ7tqqtLoHCcPm3gYXT4hFek8ASZg3CSy7J9oHQ8vwUPDZW8IrVtuxaYHpON+J2BB0xu+R6+1pYBDlIfL2vB57JBAkhob8EaPdI2bTOiW5UU6yyl9G3wIgEHO1ks0exguc1iVgtVV3z8daiJF6sPa9d6sXVTOhqJ10Y/wsI4hhAPE9hlb7DhvY+bkD35oHuWwY8h0rXjN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(36756003)(8676002)(4326008)(6666004)(34490700002)(1076003)(478600001)(956004)(2616005)(186003)(2906002)(7696005)(86362001)(52116002)(16526019)(8936002)(6916009)(66476007)(66946007)(316002)(66556008)(5660300002)(26005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cYYr0Y7AL6dJlmy5JmXDLxzfCrPDvvJ74cBfzWuOk8YTB4duolgkfHCVn7TWsQ9ZQxX8wAmKT6ltNgXVpQwscGF1YiwpKKzrYPcVoLvmMykKcoeST1NNYVU9WWr45p6q+ZkCpTJrB2qizMmAJhwnZW9z2Umk1nKkjBS+ieqrvcLwnXYZtm8mfl/np6Hf0e1Nv0ZZlEXk8PTO4WP2YBE/nAENGIjihuM/CGjCM/Oollo9vJ4CgLrjNVS7nBZIvNGSRbvy3/Dj/WNL1IoGp40hU6CJrvawDixY3LmaJA6CVpzWDtDpdn/dWDDXD4zzcuIgsAJqJ76fHzu39VMu6deIFN41ve4xzT1sdczBHHJ0ZSErIc4LSI0mY0E+veKcOZDhEx11QuQx1PfFl6jb7NqC20MQQVln86ck7suq7l6cUCHUXp1qxaDOdR5ojhr91gt2m9nDNlb8ylScknVZ9KVWGd0xpG8vP4kozCjK6sOWmJ8uFbkADC2fc1AIRPGcratTbu94Y3WH3uu/V0SEUQujsGRVexf2TVawe71pMouW4Skj3hQS0k5xWbBuakXV5GqqCklLX1FXIq/rUdZnA9InT55KIozu7AATECdapwSoBoJ+F22J2hM7jHtnq0FA3EMaJ5Ws9hiS2BbFNpd6/EGQEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d1efd1-48e5-44b5-ebd8-08d8718271d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:20:34.8840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdNsnk9SBYNWQzXAlLYK9lQgM43AzM5iX4zyBRX7CJCb1E+El9T1z2obYLbLuDGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
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
Cc: likun.gao@amd.com, Kevin Wang <kevin1.wang@amd.com>, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it will cause smu sysfs node of "pp_features" show error.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h                  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index b1a18fbb7682..85ae724c66d7 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -227,6 +227,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DPM_MP0CLK),                    	\
        __SMU_DUMMY_MAP(DPM_LINK),                      	\
        __SMU_DUMMY_MAP(DPM_DCEFCLK),                   	\
+       __SMU_DUMMY_MAP(DPM_XGMI),			\
        __SMU_DUMMY_MAP(DS_GFXCLK),                     	\
        __SMU_DUMMY_MAP(DS_SOCCLK),                     	\
        __SMU_DUMMY_MAP(DS_LCLK),                       	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c27806fd07e0..ca2abb2e5340 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -151,14 +151,17 @@ static struct cmn2asic_mapping sienna_cichlid_feature_mask_map[SMU_FEATURE_COUNT
 	FEA_MAP(DPM_GFXCLK),
 	FEA_MAP(DPM_GFX_GPO),
 	FEA_MAP(DPM_UCLK),
+	FEA_MAP(DPM_FCLK),
 	FEA_MAP(DPM_SOCCLK),
 	FEA_MAP(DPM_MP0CLK),
 	FEA_MAP(DPM_LINK),
 	FEA_MAP(DPM_DCEFCLK),
+	FEA_MAP(DPM_XGMI),
 	FEA_MAP(MEM_VDDCI_SCALING),
 	FEA_MAP(MEM_MVDD_SCALING),
 	FEA_MAP(DS_GFXCLK),
 	FEA_MAP(DS_SOCCLK),
+	FEA_MAP(DS_FCLK),
 	FEA_MAP(DS_LCLK),
 	FEA_MAP(DS_DCEFCLK),
 	FEA_MAP(DS_UCLK),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
