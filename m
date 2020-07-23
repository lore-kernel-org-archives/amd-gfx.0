Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27D4C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D6D20709
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bbh3/5Ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D6D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74AEF6E199;
	Thu, 23 Jul 2020 16:10:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4E06E199
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 16:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZaCkTU32QOLsa/G9ZWmwjxjYUpLyN+afbTqBQM48s9/BiZhHEsJO0yshHVz4m9OaKqFwUaUrlZtMHN2l+FKiO79Hk5FHuvIbLcfuY/xq/EgQrag1utriAD2zSDtQWISz9mjGx/o81K0vTdDF/5J4bNMdyk5/gbS2se65k1wXrNtBaqmU/GjZjAw/Xr2bgESGi3OcuDMu9KJACYNjEJhXqv3HEb68BvIdwmRtPXHXcmdHK21RJYzHkov3+poq4XpNJqnP+uuVgJlJUTkATNppVGWhfbTFFt+8M7WgSCwpgm9A0zhekKiGv0LAzKUzLuv7Iv+EsvAhJod4WWW5moxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Sp6oVQMKztFJU6l57HwWPEZYDn7mkH8z1I4Am4WVM=;
 b=mDjBOz+RRDXzPKDNlvOq6e/DuSZ9uxfDhT+VW85NiJ8siox2PALWgdDR4UIPUDJaX8BN3NHJiz1tk5sdS5z6j/udeT8/P0wyLQTgpxGRaVlBDT60KnX3I+yXgH059ejveVDI1r1TeN2RC0M8BhXT1Upj4JWX7O+E5h9Y4+mCLKAQKpUEWxYem4ZEryVZ6GzbISBNxYzOIzCw7dFfZO5Iz/mp/zj54EzS2FbC7KODQ++9bY1OkYI+mwUlkHuQ4Xf6/dwLHrTPpMXlnYyOsTaAg1LdnZEh5UFZxJORvFgWySH3l3LN66IEPNnh5QZ9I8zyYwgiY+uItWdLj47ZO2jWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Sp6oVQMKztFJU6l57HwWPEZYDn7mkH8z1I4Am4WVM=;
 b=bbh3/5UlpWEiRB+HY6QtE1JsqYauXG8a5Ak/yGbLwJxaRkAfUGjQpunEMySj3fvDETsEzmHEyT8O9tgAyX12ZYJs7NTdslFrwOWlt4KR0ZhX5CqRU9GLL/KhidzL1gUWyY9sKEDcxATd0qkomMqWqtPZva6btEHOD6xF44LqJUw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Thu, 23 Jul 2020 16:10:31 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::7860:3c62:4087:db16]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::7860:3c62:4087:db16%4]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 16:10:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/jpeg3.0: remove extra asic type check
Date: Thu, 23 Jul 2020 12:10:20 -0400
Message-Id: <1595520621-8216-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 16:10:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f8e388b-849c-4816-cde4-08d82f22ec08
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27481FF68B32665D64EEF6D0E4760@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIvWgzjcoIiShIVAA93XpBMXSS424iRnaqRECwN/bzzyI1jMMNws3azuDQ63PARhMSp4GfZcTqpm0q6h2ZBOHq5YXKnP3FVJ1ve0ewv1n+tKbm+2SFHHXSKkHi02LQ0L2jWkdVEZWmL8EobjcXs3m/fPfqrojR4CAhHpcKiGAwq3/lQWKLrraPEkHuw6OGRfmQiVC1YtH7j3SA/qzLURJiVyLh/ymHhKz5dnsCPiFkeWeRD6d3pHDMse7VViLtc9xZpDesKPjvIXg5BkoRQE8QRnBxutTDZJcgxQNrS1Q7MQ9OS9iBzLVAb5lX9qqayj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(478600001)(8936002)(8676002)(36756003)(83380400001)(4326008)(86362001)(6486002)(6916009)(2906002)(52116002)(7696005)(316002)(66556008)(66476007)(66946007)(26005)(16526019)(956004)(5660300002)(2616005)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xPb6SpxvmPzMw5nC/DAneAKidnWlJE/ATfv7aXP7X0Cei9AmpWyjVX5UDf4fDY9C3Dr9q3UjKZWRB/qkuVTN0ZBNdRNLiUoLTUEAClRYMu7LZN38seZ6uakPK66M/Y9nNPJEqSubgwWQyysKjYiSR3lnbuRCPDJJWGaTencmK8GiqxJKlxJm8Be03py8fT59VkbFSkmfbIzKiuBgcEmyUKfnER/tqE45LTE4InfCrDV3o8JgQWkqCM1m2h86HjMKpdjoTvtOtBLn8c9wr9wUNk/6ekNjPPGDk2BepnpKNNbOrLmQ9NrvYmtMqQZabZ2Eg2/+5cj4LHlnSU2rCH7K+a7HAswrQcwD2xgqy57CLm6DPzEzmCJuen76OQkGJNzqBEa7OMvhkxfnaCu17xEqFGlcdQSo8NF9hU8RUaTyNTOBo929sKx4O/TodpcLd29bQmCJcQ6MxEmVVvX8YXQbzRX6NRvwenfzrYzkfuCI3efiRRMgwwHIvq05zn8UVyQx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8e388b-849c-4816-cde4-08d82f22ec08
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 16:10:31.0549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91NXhTNcGfflK0ACyttW9pcdAd1j3G8YqULQDS1/y4vg181yS3uk42XbXTYxkqtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

jpeg ip block is already selected based on ASIC type during set_ip_blocks.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 42f1a51..c41e559 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -49,12 +49,11 @@ static int jpeg_v3_0_set_powergating_state(void *handle,
 static int jpeg_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
-		u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
+	u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
+
+	if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+		return -ENOENT;
 
-		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-			return -ENOENT;
-	}
 	adev->jpeg.num_jpeg_inst = 1;
 
 	jpeg_v3_0_set_dec_ring_funcs(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
