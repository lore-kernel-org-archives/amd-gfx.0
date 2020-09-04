Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB56AC433E2
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A084D2074D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lW6BTGRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A084D2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421E76E241;
	Fri,  4 Sep 2020 08:21:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CC86E241
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 08:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWiCXuT4CBQ8HTBPB20DW8gxrdmBrpNhkr5MkkIundaqQ1dphFM2kfIDnCop5VhS6bmgqyNm2DO0UYHksTB676E3+4TDBU+TmEdx3Vjefz3muS9xRwajJBJdzvWfz9rB7lp7QOrjq3Gxm0n053CdS4WiH547s4a3Xy0O3frYwbV16Km+oc8hquX9H45nLl9Aasz4UhTKf9UhJmqLAcHvQH2rPiLx9bW27qtTXFgJccFtjW/CQgixvZkz0QY5uhUCIyY+Yg3QL9cvitkx3hozjGy+bnkMfnkOeYZE5w/o2aAllu1kR7bHDd0juLqjsJOP272Ukg4QvNFLvs4te8BgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcFTf9r3tZQF0WstzRFqK37M/5rtO4YpKrXJc+bvSA=;
 b=AmH5RF4WwMvsRkPYxetozAbHYdJYrDJmoIRzZOIeyQYM9Tn3j85GIt67+LOruVHxAy6DJN/vmyRQEqlzW3Q7L/zBNtFOVdT0J/ven3+3wAJpc58GC2bYmQuFrtCnNO9KSNJ73+0CtXJmRRC1qyGMy9lMnH0axHREBuZYJVCtpRlx6lafV4iSOadv9yZuHjJC9axdNsfUcaaN8mMecUQm9dRdqNYLuE5ZrbpXq5cNE0+o5DXxqh/ctYCJKT/St2gAS4n5ecl0zbdntqlyW9ab2oEj2ydpeUxfc5rI6kk1miI5+AZPeWs8/Cu4EAE/dP9HSB0Z3cwjyeZ3sWKLgQljYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcFTf9r3tZQF0WstzRFqK37M/5rtO4YpKrXJc+bvSA=;
 b=lW6BTGRXCMwWKtgxXBS2rVsbXvvRxC5t2fVxv7coWgnxFgGDzaBb7biBhLcHp98oLzgO3Em41sdOvW41PqzqXw73fnN2cUiCxyY6Jif+o+zqD2cSiZmi5/x42DM7LVNy2EZ9C6xUzIuDAcmV+qluw1feKUBd01YlMRR9sfY1Q8s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Fri, 4 Sep 2020 08:21:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 08:21:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: process pending AC/DC switch interrupt
Date: Fri,  4 Sep 2020 16:21:16 +0800
Message-Id: <20200904082118.19927-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.1 via Frontend Transport; Fri, 4 Sep 2020 08:21:40 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e05f89cc-251c-4756-bfa4-08d850ab8d86
X-MS-TrafficTypeDiagnostic: DM6PR12MB3275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3275696BFECF914D28DAB0E3E42D0@DM6PR12MB3275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PPGoEHBKkPa0NidRKfjQeYkorsVENUAvhWYhAz/Q3M/MBIqZXek4bAVk3+vqrh9l6B3ZmUXhi5bR+Wl2mN5Z1xCqg4axFb2+BPIziNHGkJ9oKf3w90oIy2Y9VjE4UjBPmYTIQxKtM1HXRQY04cYDZIb1O6IWIAr2OLIsSob1E8NwpFzhDz338mTYdgKrv6A7Ya/q4ieCPYAz0DCQXuGKH9xSl6uPHbeTh/34XzAnBRmGAEtM64w/1XpgUU6dBG8giQ8MHbwh9/WX92aDlv+dUbO4pCQ7o8Y3xpZLiPJlriryaB2uYUwTQPk1oWmhxqkZ2SFV+q4ocYPK1jyq9iJOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(6486002)(7696005)(316002)(83380400001)(2906002)(52116002)(44832011)(2616005)(956004)(26005)(8936002)(4326008)(1076003)(186003)(478600001)(8676002)(16526019)(6666004)(86362001)(36756003)(66476007)(66946007)(5660300002)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gPwwViw3vOenOxGVKpvqZhZWE0azoqkVJEDh7vJmuopgKAQ/i1yDdQK/B1Xk0LrsLz1WOjeYv24JD2cf9MHT1FVEemhHnvcXCWhY/lxp+FmOtcK274NMFzusYA3AcwlptXvOW4NF6QmdksAzFnvk+TvlEvfs7kTHvRFSLfUJlfbhEnvD2T0jNyXTR1T5KAd/ctvLdJVCWkdw7YRLT1G7sYz+lq+7IaVJ7qrpPk+2b5BNvUAyViFiDAFAzINCGBEYa8AIGfFRtV4jeP7Z+URlDWv6DjJqvqBclXnp4TBU/kXNafoV8zV9by5pZyiblvik5iKbyNHqCp3RBp/az1wEuqgRq00xDdyxEgI2hscdfBIGKSWeegyikyPZRtTG7xjJPewII+GpHTQaAI6Wzh9cQ3mNegM0egoJqzBSsCYJlph6dgfpRx9wFj0XSZvLS4zUtyN1D9My4GHQWqMOI9KPlCVPjAr7iU0j680F+j9yxQiFYM3VcKYZGYgIYcZnaLBlHRI+d4cCnUCFGnp0JG6NHM7+RQ7xKE672cIhskvhpGgVLUpMwyLxnFK0Ko3VIz+ugiPj9YuBNuWJfOlWJbaAJYKkV4AjOyI5OBo9zEDHgkcayKeVSUDtsMnK9H9aquZ6Oy5HNT8cwxWo9ALBIi7WGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05f89cc-251c-4756-bfa4-08d850ab8d86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 08:21:42.1790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MS+Al63DQhdD7XKMCWZA9H5DQWU5czZYgw9oA8iP9hB2zDqYyGj7b3SvNxi2YtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Process any pending interrupt that occured before driver register
for interrupt from GPIO/SMU.

Change-Id: Ie846304408df27c7a7f2b29cec8f7dcb9d08905e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 40 ++++++++++++++-----
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5f80ca5a3a31..b710e049db8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -934,12 +934,39 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	return 0;
 }
 
+static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu,
+				SMU_MSG_ReenableAcDcInterrupt,
+				NULL);
+}
+
+static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (smu->dc_controlled_by_gpio &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+		ret = smu_v11_0_ack_ac_dc_interrupt(smu);
+
+	return ret;
+}
+
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
-	if (smu->smu_table.thermal_controller_type)
-		return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+	int ret = 0;
 
-	return 0;
+	if (smu->smu_table.thermal_controller_type) {
+		ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * After init there might have been missed interrupts triggered
+	 * before driver registers for interrupt (Ex. AC/DC).
+	 */
+	return smu_v11_0_process_pending_interrupt(smu);
 }
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
@@ -1235,13 +1262,6 @@ static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
-{
-	return smu_cmn_send_smc_msg(smu,
-				SMU_MSG_ReenableAcDcInterrupt,
-				NULL);
-}
-
 #define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
 #define THM_11_0__SRCID__THM_DIG_THERM_H2L		1		/* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
