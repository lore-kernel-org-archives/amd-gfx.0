Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBFC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 17:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423C2206F6
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SOnPshTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423C2206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F516EC2D;
	Fri,  3 Apr 2020 17:09:11 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8866EC2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 17:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0pUSzTYqtK+XeP6C9PXXiR8b1gklyvXaXvmJY40tKxD2UG2uiAgyKJULRmf2iqdx2YmcGhFz6CRH23/OEnhZP6I6gXzD5Dqs9poW1C9TiAaF9Q8dXnYWq8OWdU61+8PhCVhhX+ch9y0kEdBQ7pDMsHZ04UwCp8qqdqXqnaj5R9aj1jhp5LzieuHpY4IpqLbEJE7N/BmsuD7vvWRup2yZ7m+zEmQgHLNuj57Ix6m4Sxi57H14SWfeRdewTRDmikH/GZ+i4oIO5rDthlzY4H3yap28dfjUTQf9meRMmBW+ViCg2Y92jyiMFP+i5q5r1MCVWWHS9lVi5JkOoWk2tzHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJfoHxu8AUtSut1FyLGtPbGSQHJ02EmfFYEHkslm0LE=;
 b=G/A1E5r4W4HeJxfCAbshu8kew/uSeS36+6401N1fE0U66k5vPCNEpyZjCXNqtS1oyshu/145RGulopiRTzxazeutbVhx2k4WdFh30mkuInkOZUdfX2TRQmn7+GYTz5xJKPxQKMjecCWVtx5uePqXeucDl8KpaXIymUOL/DRRG0GzDl3K17DcgXLDnn2D18aGvfKyFjqeNpUgQU+JchhqJFSFhTz4wkv0W2gLW5Dr5V9vg7209og37p7nl2bUW5UwDFW+gplRvcY5T3sU9VVIPYOAzCRaDr0sLWIEQzYhc+XewrpM48Ga3fGPzveJYzu3vp7pDLwRHFP8Y5H6p1/IbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJfoHxu8AUtSut1FyLGtPbGSQHJ02EmfFYEHkslm0LE=;
 b=SOnPshTPjGIhpC129dBEH8dgmVKAVTPFq+h3/WuJaDZNn213MO8ZjPuXb5FFZlHiT4s61RdU9Z1fzSWQTwH/a3qDGVHqU/+53PoJrxCSFYDde0x7PfKtX/hPXFd5JFUS4apxJfdqRixZaPJN1eZDaqmB0iAc9vKwiQADsei+Sew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 3 Apr
 2020 17:09:08 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 17:09:08 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
Date: Fri,  3 Apr 2020 13:08:56 -0400
Message-Id: <20200403170856.7397-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 17:09:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 616b9039-2aa4-4d23-dba4-08d7d7f1b876
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:|DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB431410483AB9DAF41D8AE8F785C70@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(52116002)(8936002)(44832011)(956004)(81166006)(4326008)(81156014)(316002)(16526019)(186003)(2616005)(8676002)(6666004)(6916009)(6486002)(2906002)(36756003)(5660300002)(66946007)(7696005)(66556008)(66476007)(26005)(478600001)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fj+NBTRodIw6Vcp484a0q2gDnrUixNDI8GX7St69760g+Etz0aUVdcN3Fq90KACFLzeyaKU69dyb55/a+ESn21OIF0A7hupuepm6p5dLRgISNrRAKK9lexklBzauWE+tAUpMJ21h87TpkghUkHZZT/6Ggm0Iv7fRdKaQE3W9HoaVFCO7yIJA1jUKjCKMo3uQNpHaP/TjI1nb9kBVO936DRORvNkpHwnf0p4kJV6mHjxtdTgRLoHmKh43Nsn3VY6TPQ5SY8hQLcof0p5PgI4zs9LCqnq0eet0pQJKrjb02dJAzZC+Vb2yP11dBPD4PLWRkKV95c2SQoxz/XArJQI85TkVgTRj191fioCj3AovUH9tVG+DdhsHopZfZ00Sgb8JGZcN+3PCGyJQymtGzHvqVlwZmgwlOROb2zbxzOMsiAHqIcnRY3PmCIhMINf4YpGQ
X-MS-Exchange-AntiSpam-MessageData: cRCYum1D9/45mFbFOoPk98txAPc/xO6VUZRnDjKYdX+TCZtdoIKd/B31a9OWvXriYAYZuxv5kDZ7gKAclBeQvLt0/cMBRJoi7YUBNQ+MxEm77+UGUcMRk/AC/+CrUEeOUw2XPGAhn+EZ0sYRa78xCw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616b9039-2aa4-4d23-dba4-08d7d7f1b876
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 17:09:08.0170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTVsBkU3leBGUD+jUJzgl6V+vh6iQNygAvJkDAfzsVUO8BNOeT9xfc3R8O/LQn8aVduosppmhgNvANynBrTDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

There are 2 VG20 SKUs that do not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming SKU until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

v2: Add ASIC check
v3: Don't default to true for pre-VG10

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..508906177cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,9 +31,27 @@
 
 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Resolve supported ASIC type */
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
-	return false;
+	if (!atom_ctx)
+		return false;
+
+	/* TODO: Gaming SKUs don't have the FRU EEPROM.
+	 * Use this to address hangs on modprobe on gaming SKUs
+	 * until a proper solution can be implemented
+	 */
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		if (strnstr(atom_ctx->vbios_version, "D360",
+				sizeof(atom_ctx->vbios_version)))
+			return false;
+		return true;
+	case CHIP_ARCTURUS:
+		/* There are no gaming Arcturus SKUs */
+		return true;
+	default:
+		return false;
+	}
 }
 
 int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
