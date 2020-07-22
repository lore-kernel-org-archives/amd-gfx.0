Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A8C433E5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448A9207CD
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OAEkASeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448A9207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D67D6E31D;
	Wed, 22 Jul 2020 03:14:56 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760080.outbound.protection.outlook.com [40.107.76.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA276E31D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 03:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9DI4+IJw2xUraZVKj3yLKkvVhtXCdRxhFmHKbA32FVtOJ9sLYQrPF5fkbZmIiDOgO5Ut2OZRKXaEGCIca/PgIeKDQZ9YKE2DjIU/G03LVEbwa0Hcie/YN2anWlUkkCMUAUt5VHkYFCUi5cp3F/CXmnkmDvZhOctBZ/nEbnuQwUffQgSh58uEx7dp3mJsZb+kL7nEJNJqJyDQzC6aRu+yTlX2FQGZjSTct4bRuSCjIV454Q2q6MjOsKN51u/hOymCsv0tYkx8pCGSkogpkoCiNOeY/V2AOt8imlKfFQ+bxHUnSZjegMYch8iUwdui7uwoZ5q7a3ariH8Wz6qF1CBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njT1fQW55upTjmTWuCZwCmzdOjXhKiapTUSGEoBrJjg=;
 b=GJ2gz6ZAz/ncKxYNuVs6X8hLyXYPAbHOQAbjMoGUmm3TDwxgPFFQofukVS+FL3FngVGTwdKKQAfXQBi8YVllAgUcYcae1D6ysuXAtIG0s7DdsH79QWnn/y/g4gdRcoK+Q8veOeHsWw0N7HgFtb/nlpXpX1ylJZ13+iyMVOLL54RnHjwL4MtGSPj89IfPTGF4hxK/W4U2HhlZLlccxuQdYwtN9s4hH6OFzDjbqzleO7XNYDyez6rvf2Qz6WNC5NWcBmDFKSGfNwuTutly9N0RclPv7Sw9aUM7eagCKJbzUlNuURyaHj0XhGVKVZ78rhAx7quJBr47qqc6bcIDbzNZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njT1fQW55upTjmTWuCZwCmzdOjXhKiapTUSGEoBrJjg=;
 b=OAEkASeqGSFAgvOLHK8CJH0VWf9wM4RuQvDFCs/F9HKwQp2QsyaijY55Mjen+6CEK1/iFSaqfw6lNsX2f7y8SvL/5olIO8+P9gkZ+w85JMg7gSrYtonlpyzf5hGXQpzHVBNlU+3zDHu/2WXlHxRuOZloapvoNyFcQ+QsQNGQCrI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 03:14:53 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.025; Wed, 22 Jul
 2020 03:14:53 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 4/5] drm/amdgpu: restore ras flags when user resets eeprom
Date: Wed, 22 Jul 2020 11:14:14 +0800
Message-Id: <20200722031415.4792-5-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722031415.4792-1-guchun.chen@amd.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 03:14:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c1df085-ce3f-42d3-04c5-08d82ded6703
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1909CAB2279BB13375BAA036F1790@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT7gcdU7dp3hZLCShaIaYvumBTqyoPDcu/eY5K4vrk/zVaYc1vSD8M2x3b4m43TxBVSqlpfGVPmNE4fmePARYILdsDCKza7cHYfso7/hlu2fw/19nrnd32ItuJTYcpp/7FT6MUqKWTaxEAhtooT23Kr+IdaA1JFN4ADCZEMw0T7lKeez0pL07iTWp3olg65mH82VKnm3nY5FeoIEcWn28qHUmNH9EpYQJxgkzJ23TiAdTykHXOKaPbrdW5Wdh4AcqbgANnihktt/XyQ/RjRu8bhFSzAaa+8o2SOOGVLaVc0LF8zmS3ODY9gvYwL98DxSegpEbzvlbUWf6TvBmYYEJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(36756003)(1076003)(52116002)(7696005)(2906002)(66946007)(8936002)(8676002)(6636002)(66556008)(66476007)(5660300002)(26005)(6666004)(6486002)(44832011)(2616005)(86362001)(956004)(4744005)(186003)(498600001)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kLVQuDFgmI2bkPAbwClQ0Mk/wFOY8U2j/EmpjYfDjIycBCfeTRSYphGrU5rcXF9l1Q0O7u+xA2HgNYSUORcEAehX8urI2EkAv9KPiEUvZBCA3E5xA6oYEPN3hhvSRUDKZbioy+NJUQ7nXRen2z4LE7dwI9l2/HQLRUqBfRt/cf98/DjJ5+UARCbi/vYpo8VN0HY1w6jBmvARjAIJ3CTjV3I+tEC2hsFbX32RM9RDqYshzXPWEx+oYqq/OvXZY+nia2kEy8RSa117ciY/NVRaYGP2x5S3ztoTikUdFvgsNcREkMdeLORjt5p69KHAiCopHtHUAa3iprcbJIBXBvvLun0I7ip8MynDDyKgU0EUGzv8EBL39k/UucxIvdKKdbJOsJw1MeiyxwclGqFqawvEnM6iCVImFiO36upH7PksKWeSUZTvMoNQEp3Dvqo4SAzjBTvIeMraB/1Bm9GA/wupuhIjs7RTreLh4TdgW3FnfGY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1df085-ce3f-42d3-04c5-08d82ded6703
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 03:14:53.6333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg2ZlvYaYcQDyB3zoCEUurWOUjI2b9mKm6lD7jAdmaN1DQaH0TM7EK7g834KGDx28tR2zyw+dM3gYGADSQntAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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

Ras flags needs to be cleaned as well when user requires
one clean eeprom.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 818d4154e4a3..964384b5fe4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -371,6 +371,8 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	int ret;
 
+	amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
+
 	ret = amdgpu_ras_eeprom_reset_table(&adev->psp.ras.ras->eeprom_control);
 
 	return ret == 1 ? size : -EIO;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
