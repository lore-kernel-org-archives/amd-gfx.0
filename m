Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC7DC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD59520773
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MesRUP9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD59520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4756E1ED;
	Tue, 29 Sep 2020 15:11:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54CC6E1ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0t0ygw3X5+HMgcu0URBZL6G1OCC51INYx4IAkHHtq4i+9sRppfdXoh1VkgGK1bJ+BXbe2FMjtNErsh/KpdY5xpoX7w8tz9Ua+x5PH49r1cxkwRWvdej4LZo5j1tSlubHh3GdEhC/wTprCX1PdMwasUwG2FxEsEL9JXfnQ6NpKDu2HEsFX/ZwQmZ7OmGbdw5X12HqHA4xiYEoJQio87RcW6010XSb9plpO39Wx7dcd6EjtTeju4pQRGU3qjPYXJ/G9FnIKtuC3cL/4+k8PG6la9lEcYUl0e8JQ/AgKg7SLpdS8bvBX6lXylyC/sJXxBUDve/TL1ZInZes+vXjNbIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI+GNuk7UVcuyty84htdWEKZ1xzJRz0OSPGdCDlfGnk=;
 b=n1Od8Q3lCAsoRPpMHIeoCUx8dm1vv8iwLQy+c7Zd9arII9gcC0plowgKb2rlIudosOsDCJH/W0OqRTv4NukEXSz6vulrYL+WF+r+p1ijFedRW2dZZKuAEqnQGUO3jogc4i6zVXT/U2sKCS/5HFYNBCnIWYMeR/EycCm+e50VnMDUtZnAgyY6YtUGCoxo0MOUL0yxA1UG0QGVc1s+ue6cvhJ2Oq22HJP5ro7PWHxxuxmj1RdXeM317jaP7vTR9MuSlkhzjfmqBk4/aPOn1B7tVlTpvLz+OIWTR8IDtG/vTQWKYrOKhmFxPvLHRfHzO+0DLvwrgwYcgUOyIZc971ar5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI+GNuk7UVcuyty84htdWEKZ1xzJRz0OSPGdCDlfGnk=;
 b=MesRUP9XdmapQ5B4pNurWUKcGAKM+YthFRNwTsemJ6ESbvdE6nEWsjPdyMfWH9FqrWHNVxnNqn68jDhTX4fliL+g4J6vVKBH0su5bugVKkuZpShzwmj3dSiDT/bAVwE8c+o01qY6ksDn0StkubH8iA941DKOoghrg9B1h9jH6Sc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 15:10:59 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:10:59 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check v2
Date: Tue, 29 Sep 2020 11:10:48 -0400
Message-Id: <20200929151048.26863-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 15:10:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae2ff132-4d4e-486a-9925-08d86489df19
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1737FDCA258C82EA225B91B285320@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVdYEa5BUBFNT/+z/l1YfZnX4ezmJHauarlYY4A2cgDYn7vf5tBl5xIw5XFE5yaybi0iXSUdUQ9E/J3Ve67t6m38rUxCD1tN7Z6GOVxMIAO6FZsNc98HIis7B0RAKjfOf5ZeXu04deEVYhNwQUzQxgQSWZgLVxC6ZamaL5UNv4sZX/SwM1Ga5hmOcz/6Xsq21/fwVyd9X9BRQEHvCkDkRzmcIha5LasfktwSRidCEAhQuNwFu8b3UvrrV05bLnBkpIvXbkpYr2dwP9kaVOTS7cHxe7GI2NghvFsOWlEP9ZF1o4/XQVFQWxGUC5yxnjnN/y2mVw9NkOteFM+iBZxj1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(186003)(44832011)(5660300002)(16526019)(66946007)(66476007)(66556008)(2616005)(956004)(8676002)(6666004)(4326008)(26005)(6486002)(86362001)(1076003)(36756003)(52116002)(6916009)(83380400001)(7696005)(316002)(2906002)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bg9CCZF0v2lAW3BdK58xHyuoQaksDOxB4BMPjGB+xl4naOccxTwa5ZKnm/1AVElftWLb/iYKBPPOCnELvMpmppaAj/M56HFx0ax4q7gQ2y+EFV4vK7ixIK9QgnmxKxB/XFJN7ZrsvBkyNBQwSqICZWpFnoKBVdt8rJJQbrKu/FPod9220xa2liUk7AeTuF6krhPoJS+OifFXFrIf7gvzlUmColu4s0IqsWnDcuRAEZAd5wd3aB3bD0g+8KKlhJKDBiQniW+5TvGw31iAihkdCrr3q+NHsg4uAmbPln4MhRxgz13tNjEqYDjur1ciy6mHAHhPh9osWLJhEwXYRGqtrAN5cpIV3FgOQcBKSQ6WZIvH+nfm8ZfKr+WdPeDbTsAsBy38/EO1ooa/ZqXRx+zB0tzPahqY41DQro3lPE3jA7Xw/duOce3ZEUSKT2qoK3uc3rmqXWKJyJ6SDfa3nbheHaim3ymVMT0xQXS9SKRCrWBND/ra30DNy3GKJb9Cgbe0dgmdM9bOM2I2U5OZPHnjVPpsJjYJatBd3afX2ETRz8XaUbsciL7cfvUTBWiVel6nI79Y12wXovT7TLsWNn1UQ21BC/lQWkEXCDw+zMVQOa4efxt09pnOOHlHmJEaunJehXJEH+BfXZKsHiynEbDtzQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2ff132-4d4e-486a-9925-08d86489df19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:10:59.0978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ang5gGRcvyVe3bsugvggtv+gauIY0VvRVJYFS+DAuE/YS2Wieln6vrHSF4wONmNSHBBbu6tmaWSz3kBqH4/tvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VG20 DIDs 66a0, 66a1 and 66a4 are used for various SKUs that may or may
not have the FRU EEPROM on it. Parse the VBIOS to check for server SKU
variants (D131 or D134) until a more general solution can be determined.

v2: Remove string-based logic, correct the VBIOS string comment

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index e811fecc540f..8f4a8f8d8146 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -34,18 +34,31 @@
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Gaming SKUs don't have the FRU EEPROM.
-	 * Use this hack to address hangs on modprobe on gaming SKUs
-	 * until a proper solution can be implemented by only supporting
-	 * the explicit chip IDs for VG20 Server cards
-	 *
-	 * TODO: Add list of supported Arcturus DIDs once confirmed
+	/* Only server cards have the FRU EEPROM
+	 * TODO: See if we can figure this out dynamically instead of
+	 * having to parse VBIOS versions.
 	 */
-	if ((adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
-		return true;
-	return false;
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
+
+	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
+	 * we can use just the "DXXX" portion. If there were more models, we
+	 * could convert the 3 characters to a hex integer and use a switch
+	 * for ease/speed/readability. For now, 2 string comparisons are
+	 * reasonable and not too expensive
+	 */
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		/* D161 and D163 are the VG20 server SKUs */
+		if (strnstr(atom_ctx->vbios_version, "D161",
+			    sizeof(atom_ctx->vbios_version)) ||
+		    strnstr(atom_ctx->vbios_version, "D163",
+			    sizeof(atom_ctx->vbios_version)))
+			return true;
+		else
+			return false;
+	default:
+		return false;
+	}
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
