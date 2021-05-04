Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8391C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CA660FD7
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CA660FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D598A6EC3D;
	Wed,  5 May 2021 18:47:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02CB6E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 18:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE/9FbpohPhKFrCBjhjkFMn//AiIsgZ26l1RCGsfg87iZp/jkWTQI/If3rN5c4OQHVVnoOOEStG79FrklK3cZq1Xz1oSMMpUAbQPIou+ywDFFnGfmf6kBgTMIJDlGQ7UQDyapZmdAW9EFyX3sGJRX7Xgakd6LTgbAXsBY5/+nwHTbavXRnydbOakPmnW4GS1OeDxjtpWL/GvZC3JZIc3RaDPuf4QAcgFkjBckkiSuS4C/zrcg3L0atCs8CQIA+x3QD9MPzTVP5IoPrT4dtJs1PoDixcaJr+M102N/DwgXZM4Tpj7Aj+dv7386cEvWseJgJYrQ4sQ4Yj36R7/inAchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ac/IIdaSlF1ZNjf1XXimblRkbNXUbsBv0LP9mDX0u0=;
 b=f4EXQzZVQPJ5y4j+GyYSZ7A0b1ZCneFQXwJXmqDb29O0NrxX+pcIOXDA2zOu10TN6mfA+dTLtEDpKWTv8eojKw8ndPpHZyK1U31tzJ4gS5dfaQZuRo7tFhT9lX/GHr+OpKfTTqUuvpHf8IPIRK1y68NEYmqL2RJyoGkJ8nhxc3v8O9VGzQkaVoubGPifpr9m7uiWiNjH8Dpe+5vdWimuY7zikjnpX0Io4YAYxFYCHOjmpEeG0wXhEt33A1pxhkTOCn/QiOqNPrOYiUpa0rSFO9/v2miHe/qfMJwC5RBRs/Pphsr7UB5kTAbgXQzWdxgLe28JPdnfw37oeTQSzWU6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ac/IIdaSlF1ZNjf1XXimblRkbNXUbsBv0LP9mDX0u0=;
 b=wueGGJTVCPKEJeteoqiTPyQvwQFHjo7mm77OcdQOneeifUOE6o2wTquqrw2IGeaaugrof2yzXcixblxw7MCTQvaxJYqbLVk+dSFBuSYvRRm3qMcH12T50SWoZ2T9YJ3aEJdysaAn+lD1dDVgaQzIHBLQIWf+Fk9hHvrbDrkhnpA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 5 May
 2021 18:47:47 +0000
Received: from MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c]) by MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c%5]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 18:47:47 +0000
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update vcn1.0 Non-DPG suspend sequence
Date: Tue,  4 May 2021 20:40:04 +0530
Message-Id: <20210504151004.13749-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.157.251]
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To MN2PR12MB3839.namprd12.prod.outlook.com
 (2603:10b6:208:168::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-Mandolin-PCO.amd.com (165.204.157.251) by
 MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 18:47:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b357f6-84ab-44d0-9517-08d90ff646f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB423981FA9575C3C7C45950769D599@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbTqNczl1zEm2sUJZ4JqREPABA66GD/K8n1ASAas3qHBm1Phu17HQKm7tn1jhTIdZ41eW3BsaYC3cXbfHNF7Wx5I71R9VNvwwxCLDbodAMQZvG0Czv5NSxDGkdw904//vDlCwgQgPqmaPgVKdOPp+yL8C4yIbJ5vy1lIEuRcjlXc+Kvtq8DLuUZqcKsZtq2hR4pKbZfkwh11oNl/2mbhvilF3YFYCuKGuAe24e+j4gqreq/P5UxSCwaGTlpsnEFS0ISAn5dBmYg+A3vI+J2WOKoSy6zFzhNFxsABDwpxfFECJjoqcEOD5cHD+nCQx85xYqvIHAyBGtZu8XHI8IQI1fIbGPLaKk6nZRQ/8yfLhqavweUhKe/B9QBpb9PcM5q0TekhUfkjXC2jy7Tgvl/nTn2RXugRoFxjc99S4ftDD9ROxOpq3VIO5bp3FkDMZkjOIzNtR/a1mZYb+g6eGSbg29xBUOPSnI3TKqwY0jhjNEL9qg//mZpCwnDCoPGFjn0tA6c1vgnwFqUgZ46upA7h6cFd5LhExmXCMpoZC5TwRnpzVZmVUI2acldsADeO6cdrUTGZYdspVXo6rlOIILvREqZ9fl1HVm1pDuAje20i4P2emd3KRJylN1zcVx4B66103z+vxw7+Um0vUiZCsjXuHzHrOBwZfC2Mfv074GXa6G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(86362001)(15650500001)(4326008)(83380400001)(6666004)(478600001)(5660300002)(2906002)(186003)(16526019)(6916009)(956004)(1076003)(8936002)(54906003)(7696005)(36756003)(66946007)(66476007)(66556008)(316002)(8676002)(26005)(6486002)(2616005)(52116002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FBOLCtuNwKrG2Bit50wsn0zm3VF3ac+m1h3ALE52ACALIHl1GzNJI7srtO0k?=
 =?us-ascii?Q?gX3wCSshZDOFP6cA9ZXpq+yI4Z0RvDOqpcF99XQy/CzUDVIb9HAP6ryFHnWj?=
 =?us-ascii?Q?WSIBn94zhgscAu1ksxmCXoX5/jNIyQ7VpiTAiLwggbCWoHQAUtT7M4Ogglbm?=
 =?us-ascii?Q?3F8JT/Diqt3nGrw2J3D2ydrANTAA2bDo3ifintmCL29rXVJE1ZXOBQQSCygX?=
 =?us-ascii?Q?62Oy7l/xXg84eiQyOBiavg0F/FU0TaV55wQGsX6fiTOSADVoVCRsKMieWtrX?=
 =?us-ascii?Q?JOgWO1TGQYoXbXUoHACvMZc0txxw4E19bJ+YcemJCWZ9z2ZTUrRm9c3AQo1f?=
 =?us-ascii?Q?0eUPzK736uiD2QhDzRkKmJ7HvvKlKZW9DgqKLSGqhmR44xwcFEPfpSRuWiat?=
 =?us-ascii?Q?W0sloIas6ftJ09zfmj5jQW2CT3KpGXhoGvM9dtRV8xAfO0yoUcpJl1gVB3UR?=
 =?us-ascii?Q?lrRrx1e26LAji3WRYTvcrWEr62qsPbjHDxjV6U+JXJk6aSqDZhtQ5pqlLBPz?=
 =?us-ascii?Q?Mh3VIXQSaGnY4Jt6dru21di6seF91LtBOUHB1nFgVLk36oNALwfDh20GuTHm?=
 =?us-ascii?Q?fZ+oPtQC5pnvvz6UnKF+qObo0n2/BPvQVvPbAZ6DumycK8b3tXwipN7P15Ta?=
 =?us-ascii?Q?N8zp6D3fNVnMC7OWL46dmFRbaL9BoUL0DrcTKkLXvPPrciXmr/kIA6kYI5AQ?=
 =?us-ascii?Q?bLvwbpX/pLCJCFCNe/5igNuqBUiDFnyEnRfsyURJhaS/0yzaTZHRqFZaNEej?=
 =?us-ascii?Q?67CgZMgVU1SOPMV0Z408+lnw8rvePB2GRCBk/IchPllduP5pVDD0nngG7MY5?=
 =?us-ascii?Q?TShkmuyrTVwiyHng4PdbrBcX7Qv88YU6zrpxYAnnig4oxA+1BLobUE6fHICE?=
 =?us-ascii?Q?wUHPXrsYpFRpvjdZdHdy9oP+DhvHqVt8XGmMTxkG/iN+iXqRPPK2SfsiHwDF?=
 =?us-ascii?Q?5oZJIIHI26/swYE5bWEqT5J7SeigtFvUmRg0gr+8qj1sqzqPQGAF2CCTZ7dX?=
 =?us-ascii?Q?HcD/CaYdEzeiyBgcMWsiBiwO9DanHWtRqDEcbdrdDlbtHNQ/5GO/dDx7FjFX?=
 =?us-ascii?Q?glIc2E+OezXwcxaqHkRmGAz0Q0xQR4/hAK9gvqQa7coYTec4PS7yH4sZzUHu?=
 =?us-ascii?Q?nzLvHOyrRBtiIN3Exybc2JE7HlW+u47jhyzH137MjIT8rwlhzZa4IcRVRcBp?=
 =?us-ascii?Q?R/zFDv7tVbwt3nIvwCoyQcwYQEFUAREnVNqOMT9SDaumFnSicnLewNyx+1ux?=
 =?us-ascii?Q?tp+NmAn+fM30uzPSJK8/VlY7RpRAgf9qx4h/KkNwOQcG/EuK4MABp25uBKm0?=
 =?us-ascii?Q?6DkQclkA4eAcooaZi66/7W2c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b357f6-84ab-44d0-9517-08d90ff646f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:47:47.9086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWcFCpJ9gyx0160fBHn10LgUdpEMNeqjWRUo0d4dpL1l7YDBTYmxM9fWT2QMFL9xrH5khIdat0KRYshli1xdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update suspend register settings in Non-DPG mode.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 51a773a37a35..0c1beefa3e49 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1119,10 +1119,10 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_LMI_STATUS, tmp, tmp);
 
-	/* put VCPU into reset */
-	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
-		UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
-		~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
+	/* stall UMC channel */
+	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_LMI_CTRL2),
+		UVD_LMI_CTRL2__STALL_ARB_UMC_MASK,
+		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
 	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
 		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
@@ -1141,6 +1141,11 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 		UVD_SOFT_RESET__LMI_SOFT_RESET_MASK,
 		~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK);
 
+	/* put VCPU into reset */
+	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
+		UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
+		~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
+
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, 0);
 
 	vcn_v1_0_enable_clock_gating(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
