Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994EBC49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C60E6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C60E6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0873B6E2C8;
	Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CB16E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQVKEtYBSzzxY91lBxWz/PIXKjb5iEQ747COFU/VT08o+jgVzlOH7QDDBu7CRuGFiTOBRMAoe6GS7a0kxSaKAgxIeHdtpgOU6ZaV0n+D5MtSt7+P0Qf1qKPwEU+FQF27IOPmGX2rYmROCM02JRTXUeUv6MrmK/btXYJ9xt6WqtYvLBDNPbc3Rn0hyzNuXKBKegATy1IiaJ/YSiQvHxRep2grsw6txIjdOdof7LkQzQEfKZDRgdqh1vCmYnoGkGFvGCwqGK4KJUszxuyOs4y5HJPQfcD1P/DZPvlZ+02Wq+EG5hnAVIqrlwi0ehnmCXiXQZyHFOqeEypCRn9Yo90Lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2kLsvZUDmFGFKvu8otpLGeMGBZX5VhoJ8Vzbw+MVos=;
 b=DdX3VsZyd46cZqtrbERDqvkM8TMH6n8OjNA6eO0EoOKxOx7G0rHbRDTt5iKfiR0GqoLvOlUAEAoHVfcHZod4Whw6QEAK0G+3eOWHAju7LX/WYNW6h8iGNMc1qeqV2R6Sy78GBwaUc91j0s08IKGTLL8EKTDFxHL2OhP+4ovYXAmBSRbtLv0L1Vh+0j2MRQajPtRhB4TQbju/DLuBNBh4//R6ZcMv6S4npjFoMKDrtW23El9IbCz0TkTaJ6u6uKGFoRML66GWuOcw78V6Nn7ri4tux5y9vpPgg6d5GIJW9XPXtMlDVCqlWxfOBOnHBs4/D/Jfv4HAvJIBaHMRzPi/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2kLsvZUDmFGFKvu8otpLGeMGBZX5VhoJ8Vzbw+MVos=;
 b=dYY3Kktal3ypNaqGWwgjllY0YwVGpSHyXYQJB5umUiY81MWkpl+lRQfL30lzPSWK4wuggXeSjtFU6KKWG10qKQ4Lrg/Gr27x9czIVCeyZh/VGCv4OFYtTzZf4Pn4ZH30zOTauyJzqwFi+2O4Ye9MpvrQuxBWBMPlzyfdZoapGMI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:37 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:37 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 41/43] drm/amdgpu: Fix koops when accessing RAS EEPROM
Date: Mon, 21 Jun 2021 13:12:19 -0400
Message-Id: <20210621171221.5720-42-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51332c90-15fe-4968-5632-08d934d7d6c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29851509E29BB7A662F52391990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQTFyqUIYapH2Mz6W1r4qBor9i82yafAyxfD6DPZsDoDl/OPEc/ew/br0Uda1nSG0Sb4IcPvp1Mhhznr8wKMgBTgW7X15z0/we+a8n1LAKiDxVBTd9YBDN0fNftlQIssry3ZzzoYIgyjrfr5zfW+4X+XvAlgjLKp1NjkIKsYufPO4KOsYjrgSd+Lj7jbwvhwlY0NGPi5jX1ICdj00mBm5uoU4ELMID8qiDuQHNdKN/Niq9z56k0SF7nGHS4U/jtTIJtFuJIQFZaKTluPZdcpZdpiIoNLz/1ciQpA9nRkVvuyKAVqSPNjifjgihSkIR1efe1QMQpN2MIHJP92XKU1y35WnCTZlrgb3P+Q9j6Y0BVe6V/7CeL6q0a6Bj5qQj+qrqb0szhZsBoWCprb4BTTJXMivlMdRH6UmF7avw+1RBDSDYQp9N4pyep25j+ceAZk/WufRlErVlbu+mcXTKkaQPNPZg71RdGUW9BLvsLLzprvlPAcPtI5AIv8aWEkhmonZ111YxEFMBzSEdH/zkDFJ8NIsXsGhlJRSKu5kPiIEtbZPSbux1PpEhhwoky8L6x8+FU/dPOXLuLdyZCQypclikf/lQf34qL5f2rImW7wSLXKtrJyxhb6LZpdAhTl1cazeAhlDquOtJ0lRS/yk7UTP6fRAgxgEiJBfqaA75aSgVvRXqQA5PRuteqVxRC563MY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlkN9+sRYE4XL+fw374ZCARWaObYAnkaPJ+D4iTnOBECGugJHDbIY3agObgG?=
 =?us-ascii?Q?Na07OYSMoVIGPAeJyRDPjF8uKRd6eTmMEqlKTFWvMS8ARFhg7EuT/2/cM5aC?=
 =?us-ascii?Q?DdJVLrgw4CxNwbzocFPOaIs9DX/KBiKhyCpZ9/iJ7iR1h7LVxgS1Lm38tCPO?=
 =?us-ascii?Q?KGVHurDuoZ8nBzrC8Jc5OWOiFiKcX/UR5ruGn3lxaK6T2B4I+byzCnyJ6lFq?=
 =?us-ascii?Q?GiQEgG/M58xzs0jfrajXwZO7TzKqJZt52jTk0mpMVYP79QT1oyuLRZEZKRRe?=
 =?us-ascii?Q?ecAsk3DI8n0zU7qjo112veAAw1L+M910kxCEklyKFpAEYbZrP064de50iiBq?=
 =?us-ascii?Q?Z7Pm5DLrakecdgyXYm5AWHxqjK4FzlSDE7o0lZ4fhOCs1PGreEjDaoul3oKj?=
 =?us-ascii?Q?9jn8QhWwag7Kg+87bt0b8aJJ40hOdcwnCrhQ3rITuZkx/5julZc8/NEryepo?=
 =?us-ascii?Q?XcS1Ci+QNrYX8w/2XVgooKeWglv8HEkT51VH18CC85uzRdEateua38870VO4?=
 =?us-ascii?Q?Xr8csJy3HJLS4LFlFPH8ka6F8pnzdxqTsDiF0cc2duQxT2JVlrwDkdGz4UUh?=
 =?us-ascii?Q?ICKqChjLyBMUzuAWei8KpprsZeyQQNs4Q9JjE3Rx5ocE6/NDqhALKQjstYvV?=
 =?us-ascii?Q?Clrzspt/jt9RAPyNSlvPlhJcSt7+JEQtQ5G/+adnglWqC4lgSxpYdHuyGqg3?=
 =?us-ascii?Q?apXBg9QVM2nZClMk1NaldPLq3Y1Mp7lfiQrmqBl73vs3UudxgvT0JzyVhdzX?=
 =?us-ascii?Q?rrwMXYhLnLm+d15d9wAnWlgSP3/I1QrhDqLU0K2uS84eI/PruucSK7iu9Rac?=
 =?us-ascii?Q?4tEs2YaEdil+yBLJANuRoo1XUUvnpvYHEGQvecMDLEGtgri/I/0M8KURm2oz?=
 =?us-ascii?Q?T9GUZ8bYeeY0Iar1CXXI+JrJ8QZEIVvCyIYdiMAapC5tQNf+SnN2Z0J1py8b?=
 =?us-ascii?Q?Svk9ib8dYihBdKbhIXj174xHcn2g8/zVRTQtrdDTh5VLd7japWTxR0NizFvC?=
 =?us-ascii?Q?3lbWJlypfChLIdlgVU5RSZOTtXrG18DK4BCrIRHrIAs6ymBw9Gne16T98jkY?=
 =?us-ascii?Q?o317B2ig1+mZ+zzqPgSJzAGFivRYyUY4H1UfF7b2PTM5jsAS3zcw3B2oWejx?=
 =?us-ascii?Q?bJJUpgXo6r0EI0HhA2z2jrlB33sGk005A8tZ91nIYx/qzZ5NKpWdmqGaiUsB?=
 =?us-ascii?Q?KsLu0CCslHPU90jEkbMjpovpGk+xMVeSgQcz3qZdr075LMznvSfF0naxTtVf?=
 =?us-ascii?Q?VeyEOY7FpWMbXp0QjWJCiNsBggZ2rCAGh35PKsBdPTk2RrA/yymKwWdZ11w3?=
 =?us-ascii?Q?itQROxOrVBnZ2L+vjc6/wVB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51332c90-15fe-4968-5632-08d934d7d6c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:07.6213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+RkC7cBj05AvjE1mZgVxCAP4vruFqMtnftamMd1GQtPOv9Wasz5k7+91Z5R+cSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Debugfs RAS EEPROM files are available when
the ASIC supports RAS, and when the debugfs is
enabled, an also when "ras_enable" module
parameter is set to 0. However in this case,
we get a kernel oops when accessing some of
the "ras_..." controls in debugfs. The reason
for this is that struct amdgpu_ras::adev is
unset. This commit sets it, thus enabling access
to those facilities. Note that this facilitates
EEPROM access and not necessarily RAS features or
functionality.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index edf4c02d075f48..c6ae63893dbdb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1947,11 +1947,20 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	bool exc_err_limit = false;
 	int ret;
 
-	if (adev->ras_enabled && con)
-		data = &con->eh_data;
-	else
+	if (!con)
+		return 0;
+
+	/* Allow access to RAS EEPROM via debugfs, when the ASIC
+	 * supports RAS and debugfs is enabled, but when
+	 * adev->ras_enabled is unset, i.e. when "ras_enable"
+	 * module parameter is set to 0.
+	 */
+	con->adev = adev;
+
+	if (!adev->ras_enabled)
 		return 0;
 
+	data = &con->eh_data;
 	*data = kmalloc(sizeof(**data), GFP_KERNEL | __GFP_ZERO);
 	if (!*data) {
 		ret = -ENOMEM;
@@ -1961,7 +1970,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->recovery_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
-	con->adev = adev;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
