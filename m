Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D196C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 15:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B028B61476
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 15:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B028B61476
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6182489E1B;
	Wed, 30 Jun 2021 15:26:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6046E10D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 15:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWSUrYAPttgZgt/eMyJzbd1hkfz9OMqz1pyDz5Lzt/7usOb9j9AUYoRRPkfbuMBlUNsVDa97rqCti+TLQOWxfeM+uryPAeODnOrgCJ8cMBlNCvx+sta+E71i9Ox267oab7LoOBc9dg2ExO4BCHjy4T1ANI3YKF407Jvjtawp7sA60zDe2P8kLXTUNFdoZceRezQF4ngpb/hPBz0AEbbL5FquLG6eGXsuDcZHKyOafgJik4d/FOEZvcUpdp6wpV6iC7TexlrZ4I6S5okQe6XdcjrtD9FkwPOHqYtnY+dFT3qgegmZRKFAw+f00lH+KCzJpcwNZvvGwF7AfiAchqe//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIwbqFKxmyYOXOU4SZERGAcY13IZYXDO5pFdFetqgas=;
 b=MpBmIPWtP0uQAE5UxEDRIkw3UJgpx0uIyj1haxk5pKUUtJDdC2qpRifHkiPCa8ppLRtgms4kE75699cUgoma87ah/bsG/8UOLZ9gq/wZOQoqT9DFB5WGvK/jJfR2Dlq6UwMLrpJ2coBKvf590SNSkM7Fwgt++s/6m6OZW7nVjJFW3HHw5c56pXNq5WF8uy51zKLSl0uVBTq08LLAXpR/iuIWvlzrIVia9WKRfCkvw1hLW6L/j7ny1oUVy6j96oiySInRI3g2TUoq26EqJFbegsFYDuw/4OpW9auZ0uUZ6SGY5Udj1Zc5oW15WzdPRVg4rv+jUZcjhBL+0e8eWEa8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIwbqFKxmyYOXOU4SZERGAcY13IZYXDO5pFdFetqgas=;
 b=Ru94g6j9n9TJXaPYCkLUrqFY0i3BXiiPHJ4AwyDGqZr3h59K9V1UwX/co3w4W00/NcAUV3uahaWkqP1oa2Xu+DuUUl0x6oNs5zMgZpbqg265iP+BqfLQQQcCbu4Qc0IOGmYt50j0LMhhy68sEJTCRUVbEbrG558oK5OZQak6G5w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 15:25:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 15:25:54 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix 64 bit divide in eeprom code
Date: Wed, 30 Jun 2021 11:25:37 -0400
Message-Id: <20210630152537.1133143-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.198]
X-ClientProxiedBy: MN2PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:208:23d::12) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.198) by
 MN2PR06CA0007.namprd06.prod.outlook.com (2603:10b6:208:23d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 15:25:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31294612-0ab5-4b9e-09d8-08d93bdb5a16
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5333902C94CADD97746BD72AF7019@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+Nf3Kouo6drN1mm/LygRVn3/azHRFxXzmExludVCSXnQbPepe0lZ8DgUXD2X+4R+vhaDITQWfUEl4J8M4TQCcH4pmF/EoajD0+Akdzw84BtyotBdQDPW9/Vrk4L1ajxrTZqo+Dy23L6uWFLgElBEGu6qIfcC6Ml6DJxzSwITz104nsdwYZyJojY92lym4muauYp2vEjUJsmhlcrgteR262YD4eR8r7whbJjFqUrkNMn9P/PDn0pRL+8oVEs1VV9ffKC8BbnYugFWTm59EaYAsKUj5TztiBLis/j/TYFUaiYfaBzXJzLEjI9MORM1UkJL3xYOO1hEI+QF8MdsD1q0TUumrK0+Zb7bnbYQsPp4DwyUpwwzyGiTZJxBPsE3APhPbVMpWE6tOIwBEt01o2MZptOusCyqYJd2mrJT8aRabYEvi++soi9iHtFGyNu4KaKrON0cdHsQVz1nHybpBeZLdMZD2ljGb7bg1d2zjzzaUUfOEH2jsB2xNBk/PU/qdCvmFKVkOLH0InnmpqnaROR7tbT1jo6uTcIOFGyaeZCSJl43gS7Af8WYEjTnf8xfuSQZGkABe+tYvu/7iRwBSORjmXiGDTNm9iGeeD7iib7M69kEPG8eLcAu0+ymMlWP7nXVvpNsBPy19CwT5KC+ctsZpJCsHCYCh5in38DJ6V0zmuWOWNTRgw0HrbkUE4aTgfNmRSBubf6D1dl26kOwcNdGaz/WZo4N0hw7kCKBmh31qtw27uJw9knTEU0Y8C36JxH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(6506007)(6486002)(2906002)(16526019)(38100700002)(38350700002)(54906003)(52116002)(6916009)(186003)(26005)(5660300002)(6666004)(2616005)(36756003)(956004)(8936002)(8676002)(66946007)(86362001)(66476007)(66556008)(1076003)(83380400001)(498600001)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZnvDDe4pVPqfkZ0c8265KdKAV/o/gn3ohr4PKmhw3b4VEKSoFAOEjy/9UKP?=
 =?us-ascii?Q?X4M7fkhJtWqGoyGW5+1OlLrOqmPKlaAEyMXoaUKAdi8fTwpBq7j2BIe97OjG?=
 =?us-ascii?Q?H9wMMryvSi6TD70s/bhuWH2A38w/QaAcgVca+JnrGVlYIOIIcUKpZzYWXkpl?=
 =?us-ascii?Q?oTePHCAzCzhCpEgTObE1CnvVNzWZaxYxgitt3SHy2QnThNw/PiazR2D3dQnQ?=
 =?us-ascii?Q?3f2T7831q5+W6UHKzTdN7JIQ26oJOR+VYHwAFWdAVGHP8XmbCLShcxNbHTQW?=
 =?us-ascii?Q?Xe/T/E4fI9omDTbi2AxYMd34xLNOMoOw9df8FF9DIrE3kAHr5wurVHse5RvG?=
 =?us-ascii?Q?q95UONNKecNqPR9Iori22LeMJwTql6ot1Sb+6ofSJ05WkDV73It1Ww25y4aW?=
 =?us-ascii?Q?a9+M76eUMAZ9Tpw6vY/ChMwEn7vrjjBeZqMZNpEnpLdCIJ4yj/XBWFAB+X2p?=
 =?us-ascii?Q?9ZHhU66Xj54wbHbSJN+hPpjqTZfAt9dnVGMOSPQaTgU0ROQ+sXVRRtPpwH+A?=
 =?us-ascii?Q?pPufeyHlVE8ktOzswAwm3nM6FMNxGMYv5QcSBuYMsrnITu53qZFjQnrJv9G7?=
 =?us-ascii?Q?w7R2xAqXi7GOlyNKa0gLXLwhFL1Qb1mx7t5UlmTlukQ4U79A4pid0Uly1DhZ?=
 =?us-ascii?Q?JStIJtL3Ec1d1ZXteo/I3n7pqwoBdx4GECoYqAdyPE14sigPkm75k9/yCNzG?=
 =?us-ascii?Q?IF4FMTmNs7k4LPrdkVrLRdaK7BTwKqHOLTYScZsrMQ/jLHJ6B1sA9/syo5IT?=
 =?us-ascii?Q?3pLNndIT8Ojb1QWotJkt0OYBOP35u1LFLF4gpOMQK4XUgp+E6Qd0nVdrscOk?=
 =?us-ascii?Q?QFyAppuP1DM1KGwt7wqvdnYZP1tRW6jcp/X5YQ78ejFWNNCUa/owE/5m0Mqt?=
 =?us-ascii?Q?HyEzD8ZNlKFcBMlX8TZlvI5qOm5NlJZMAKumLmt9iTUJeWzCtSkfLhSISHd8?=
 =?us-ascii?Q?01iOxmzVfLsj46bU3o75kg5pdBCuSCRhTeWill9MDjzZ5YQSmEPmHm+weAVB?=
 =?us-ascii?Q?ojxKTdu0Tqf2tejIB6wDANWnTs+oAUsXqFHDoUmCJ/14Q6AalD/ENWCeovUJ?=
 =?us-ascii?Q?ddH0R8rf+Ii9JyaKNKx9/2GPSUojFD7J0vS5V4q6pp1aSIx2xoDuTPBFOQD0?=
 =?us-ascii?Q?05aqFBCRZnmoJy8ibqcT83XiW//pMGs8ODlOGsqiZNgVCJMoTdgyrd40yj4d?=
 =?us-ascii?Q?7Hct9cZdU96Dr7Nu6JW8IWz8FRyyYNSvv7MJ2ZHM8AqTjNv89J1A1FRhcaWg?=
 =?us-ascii?Q?z82OdUYJme9iCVE5vSj3Dq149A5lXr7I2GCurE1CAgTTW9mYxwv5rHm2kKhu?=
 =?us-ascii?Q?0QL6ux6f6behBlYgHlN57FEX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31294612-0ab5-4b9e-09d8-08d93bdb5a16
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 15:25:54.6917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMHDVe/jIYBNJ4x4HKEaC2lA2jNpY+wywxPlgzXepAB6w61iKsyZrmJ7QhXajpNv0b4Li2cR7ASLzhViZd+oCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
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
Cc: Alex Deucher <alexander.deucher@amd.com>, luben.tuikov@amd.com,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pos is 64 bits.

Fixes: 5e98eafa90ca19 ("drm/amdgpu: RAS EEPROM table is now in debugfs")
Cc: luben.tuikov@amd.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 677e379f5fb5..fc70620369e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -880,13 +880,17 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	if (*pos < data_len && size > 0) {
 		u8 dare[RAS_TABLE_RECORD_SIZE];
 		u8 data[rec_hdr_fmt_size + 1];
+		struct eeprom_table_record record;
+		int s, r;
+
 		/* Find the starting record index
 		 */
-		int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
-			 strlen(rec_hdr_str)) / rec_hdr_fmt_size;
-		int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
-			 strlen(rec_hdr_str)) % rec_hdr_fmt_size;
-		struct eeprom_table_record record;
+		s = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
+			strlen(rec_hdr_str);
+		s = s / rec_hdr_fmt_size;
+		r = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
+			strlen(rec_hdr_str);
+		r = r % rec_hdr_fmt_size;
 
 		for ( ; size > 0 && s < control->ras_num_recs; s++) {
 			u32 ai = RAS_RI_TO_AI(control, s);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
