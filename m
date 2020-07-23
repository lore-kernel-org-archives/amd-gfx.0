Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2BEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D44E2084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tA0994aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D44E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6846E869;
	Thu, 23 Jul 2020 08:34:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B71A6E869
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nlv5QqNHC3kklhsLJL5tBVyz5PdkMZvQhEU1Om94MiBH9+IWaDv4On+/Vr0Xr+rE5pARTIdpC1DZMtmRnjmtdYH2oz/Kst7DljSIpmFTAfHBoU4K3v9W7hf9kge8OkanfUGJMoH0ZLFXucTXXQMVfDMFZMXrduSjJ2WdK4e5H2O0lM/fHswg1Aux/4arZO6VJKQnw7VZL/KcYvrrYGW0q17I9H8GyMs2S5KTtjgS5QPIKYmUGhZkbIOhfWhs3/n03wOMQfnxbK70OAHb/hbiCSDDsbfktgZZp6jqZPOLqCE+7iMQgcugBiYoXwAxBfOcQ3K4PjKi6yGsZDL+0v1+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt8yVXAdCTdAS/v9hBPGl4ffr2Ueozx6dDgMNUs6rZY=;
 b=O3vst9SNAqDnglVbaixd85joJvSIBA4jZDC1JabJDIwMMTGBkcxihFQTvx77vicgPb8OLsd/MiGDGbtKg+6V1JPOyWEr7K2qZFls+6OuTwSnddCwIRnKT/7om6YxiiAzbItu0BMknNixrO0Po9Z4IkxskvMIA/awOCg1YhcBXc38FWTpCvNSvBixplU7pfsBC1/G4mrSEBCMxSQ81tzSMJnZuH21Jw+qXOB2+Ubcu7CyUzrQ3c9K4RlQ8pGs5yjDjY/7HyzqVkNzeQ8RZCE77B9wgg5EvwNrZcYSIXKNbWpUkJ49ejFVpoRrZQEvTMo65kEBQFnDW93kGVTA9yi4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt8yVXAdCTdAS/v9hBPGl4ffr2Ueozx6dDgMNUs6rZY=;
 b=tA0994aPijAGsMgxTsN7Ats5BCVY0eSK0eCyEgXHw7UaPA/AFvITA/vBJOWE2uSSkP3oLUs0hhQu2lz8oZdPBVhLSC3v2mYRycdL+89fRKWhEp8/jMyKEww3WItALpTL1dRiTD/gyts7BPd6r0HpBUuukZrXnkPeIbO332IEffI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 08:34:37 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:37 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 9/9] drm/amdgpu: calculate actual size instead of hardcode size
Date: Thu, 23 Jul 2020 16:33:46 +0800
Message-Id: <20200723083346.8743-10-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723083346.8743-1-guchun.chen@amd.com>
References: <20200723083346.8743-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce5c2a90-f992-4ff1-1337-08d82ee33bb2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0119A46F9C2B54FC7DD5E653F1760@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XmFNMf0zJt09Q1ZKFYzHNTpHhAYDd9aSS7/mQWSTWFSe8rdbQqrSR90dzDylHClROvIHWr6l5bzHQzlwpLm9MxKpXiRq0SFB8fkq2jyS6xybGtu1YdmuD5CoKqN0v6U2dJdcnwczSyrSLIk9cBirLKmmeIetUomht8IvIuSCiwNH6haySbv9vWGZl5UZ9fX6sytqphH/ZkcMgq8/RjvzlSzHcAAbiZZnKRjvstc/cMFSFQV4/rZ7gZnSp3weGkp8aBZio37pwg7kCl0GrKyguzx78hwkTKLVr8+/o+bWVFXGiPqFuz0RVJZvjjcCG1E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(478600001)(2906002)(86362001)(52116002)(7696005)(6666004)(6486002)(6636002)(8676002)(5660300002)(4326008)(8936002)(316002)(83380400001)(36756003)(66946007)(66556008)(66476007)(956004)(2616005)(26005)(1076003)(186003)(44832011)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UJZ1y+07VuQrYVILLQsrHttJm0XKSg3Lsyx5bOri3WfF9qj+uOoSbxg0lTQeg1m1v39EVXAyFeVyxNc5JmRrdP3QVzvwOPsCM2ME2PIscdh/0RkhgwrknrtDirTSX+0ydjnMm77cGc2NJlugBZo/6nD++6kb5I6o49QHZM2w+psduIOBljcPdhmWVgRtwS0XKOE4kAppqWR7hVkafhOc/JJj1XLmCFtn1cZZ4pM/Curl8xSuWcZRNMHQNU113XV0K2zLYpM4JxF9396+K9glCCQ/KTpoJghKtNie80JtriZB5xKJVNBZpUeTg2L6x2dfAygco8lgAuIZlnz8vlAV6VcGjqRBE7dCcAsahapAvpkvNbv+R1rNC9sIfrfEgkUtahXF2wvhvJ78IhG+DAJnmVlCWyHtEpoGp7t4Z5SKVWT2Zx2nli7JTfJPZNLUN1SNQjUutxoxcblixdn74/7OvFOE3YKBX6GNwrB0qzZWEkqwuGXWcy3vgZqmbIJYY44c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5c2a90-f992-4ff1-1337-08d82ee33bb2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:37.1942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVT8pdIGtatmQ4psa57drUYM/UPB8bQOzipfUzl2ICxcqBi7DR+mf5j20J+ySBkREwSrNtB+EfcZoFe5EtRn7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use sizeof to get actual size.

v2: correct other confused comment of head and record size.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d27cd5ae431a..12ae8eb3b53e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -31,14 +31,9 @@
 #define EEPROM_I2C_TARGET_ADDR_ARCTURUS  	0xA8
 #define EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342  	0xA0
 
-/*
- * The 2 macros bellow represent the actual size in bytes that
- * those entities occupy in the EEPROM memory.
- * EEPROM_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) which
- * uses uint64 to store 6b fields such as retired_page.
- */
-#define EEPROM_TABLE_HEADER_SIZE 20
-#define EEPROM_TABLE_RECORD_SIZE 24
+/* Define head and record size in EEPROM memory. */
+#define EEPROM_TABLE_HEADER_SIZE (sizeof(struct amdgpu_ras_eeprom_table_header))
+#define EEPROM_TABLE_RECORD_SIZE (sizeof(struct eeprom_table_record))
 
 #define EEPROM_ADDRESS_SIZE 0x2
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
