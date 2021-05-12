Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B2C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1AB61059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1AB61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216896EC86;
	Wed, 12 May 2021 17:32:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3212E6EC7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD4i+tR1FG2giWIhw7eH16cLvo99KAY0v1l94tL9I4NFG/GO6OmAkLZ6ZR8HeD5tKB1/QADxSgpohCyC2Rpp0iLmw43fjlGCP01cmCEXdnp904aS4806wvZHMZCJOucTX8Q51MDtmFUVbVvtDOyhHXzdcn3d4cNU307Pr4scc4Tmf/AMVkDn9Bxa78ncBfSrGECKFDiwPTnPwnpGxzlB5hVCLUFyU/rvQs71vTiYshLzeZcxkr2f+XCDpqog2ZLnvkzlfQUeWhZ3PiYdny7uuREFPrDRaWloZ1XSUD1FVTdi5dCm2eRIz/TdmM96APShmtWla2rAsVuUePNQJle7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biXk08vl49m+UudcFmyWJPvIM/oIxLfLWy8P3X3B0Og=;
 b=m6h4Nppj6+kKxQq6FgScg4eZlzP5FI+f+KtBcVhcqa4aX17LDhEc9mkECeBnvK4a4FD2ka9QMu2GyBxKFgq6ZNFHskS2zKw/n0gPKD0tnGPgONi4Co7xO4aUkHZ/TMXy9HVsNp9D6EXUtKXd9NauWXO7nZ62R9qDc27FfzbKy6D/+owJ+ral+IFmUxjsESpqV9hTLlFQGjtVLwQw/N76QsRftYviWVYC54st6wRLYSUHWkl55CsAChMMZ/4EAY1i3JfZdqE4JKXDu78MBgb2K21MExpgXA4Zai8HBUvcFwrAZmtWOfrf+xTC4SZfBLF5ivpym+Kh7AYMU7AvRpxm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biXk08vl49m+UudcFmyWJPvIM/oIxLfLWy8P3X3B0Og=;
 b=aSHhf2ul7E4+anLOXWPbEX9EFPzdx/hxIaWQhA+PGVfB+cvhVGvdZcJ/ZUI8HbRNaysVhvweHFtE8qIM8t800qvYf5e3zJ4iMes5p00dqmEilIxvQ7jAKloR2FhY4LOkYgzcPXWBswGJ5h0f/7lftxgx0sLSOPzCh2N5uncwXbM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/49] drm/amd/pm: Use the PPTable from VBIOS for beige_goby
Date: Wed, 12 May 2021 13:30:42 -0400
Message-Id: <20210512173053.2347842-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3c4415-9c7d-4231-5663-08d9156bcbb9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40792EABB189AC83BC1F163DF7529@MN2PR12MB4079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phNHqJlPgyRilTB5B1FeruYkf+VzjGSIQQunpsRiuuE/i/CuhC1qHKSQIixdmsT4h4/sVUjMc1IvPxDF1EmcO8z5H3kqwTW6+D+7JBWgWBPgZn16kxerdkSgTeTsLXlXH1gt2O1Ge3mexuvZbPojyYj2ey17tE01KrSwFiPISJyAwsiuCPj2jDivDaDok2v9Rs5CGXlaSfEJk51bteOhKlevNQzGjxtKed9xIy5p1SHAEhLhJrglBGyB010Tm6owTafw9P06JhoXHYiPxT5VGbPZgsS/vrw1Hq/olLwLNikLANOzNNg3yKdKaBIY1Tkz82C10b1heOiF8xfbc+KNJBjKdpkAbkZhpP1j5Rb6Q4bADarQ7Fu2Ug7Dx5Fcw+cb0RSrLskMaTELlcTomBAiKEAlV4W/DMP4fFwY7FTLqaufqZVZQ+duzDyCo/8idb0vYIBIhRkG4b01sRY2LlPt5FvlT6gsV/xEbysYaJQFsUENAFByEOms2SZ7BYDCm/OVLXleNHI1VlxumbnzkbphTXM5pSFsNWxuvAyw2dsJYTVGIFjGb1nNceyVVhYVgxVYct9DqCB4+6xd5J6xzSCW/87IsfnLKf/zAmIg6BIfhsxDFGObd8QXqzXLeXXJdgQf0mdTZGHTXyo3pWISt+5B995TKOGJVi932RnfJHjGN838LGlWCkcBMaSLGQpAC+oL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(8936002)(6506007)(8676002)(83380400001)(86362001)(26005)(16526019)(186003)(52116002)(2906002)(956004)(66556008)(2616005)(478600001)(38100700002)(66476007)(5660300002)(66946007)(36756003)(38350700002)(6512007)(6486002)(316002)(54906003)(6666004)(1076003)(6916009)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QxwCnNXIc3ERCFyMl4KI+CcrEXf+ZbGkAiQUlfKvOEWWMaEnQsaJhEKdPFzX?=
 =?us-ascii?Q?7WS6BT3GJyE4g7p9VtBAqN0U0bLrgR9d2nLRyRrkqNpXZUoZ0j4R710Xsr3d?=
 =?us-ascii?Q?lOTXqcHrSpyKlO3bmnMJ7N5SKIyZeVu8Bgx2Gj9gcxVCdipj/x6Qf0d8uYqL?=
 =?us-ascii?Q?tRHAaNCIrojilO9xFVhWfYcfVThUznZGnbLCec0WLfjGOnt47E8qaXQuvgZK?=
 =?us-ascii?Q?nDfVt4I6u1FHCPTRSghEsPszzjm/smLxmaom7jTybt+7Hd6T1b/Q2gK6jiiP?=
 =?us-ascii?Q?JZxtY9cRqhbJQidUAo8zIH9De+kp7tNKB9OfDiTWg3rtVyiwAqxErqXIjNOv?=
 =?us-ascii?Q?BmC9ToF3PXB3yllJmS2qx1UiQDzcWruhA9aoRLLPaXb9F56hADCY2Sf0+AXC?=
 =?us-ascii?Q?MC2cXABh+/4ra24bUn5kI7R1eJqfVG010UJpoGMDR/7DflWoBsdOTW8DGGTd?=
 =?us-ascii?Q?VF15dDKo7E0hCtGIcOFrU9jrZ1WPsGtGyB1yNnyfP/Cp5AK020SexfDsxInL?=
 =?us-ascii?Q?fhzli+tZG91m2qyV4lFeRqAPKEZQZ05n1DkLPtgpTSpCxzlt0ftelte6TCPh?=
 =?us-ascii?Q?EDwsuRJR4WvPVkt4HVa2QKkSC0SkTBQX4A29zGl2R6onsSfVM9RfxExodefP?=
 =?us-ascii?Q?GsZ6u6t81lmgJQWsJOO3Reta5j3kITJXD4z1MJHqGrqEs+TzQODXQvZfhlc0?=
 =?us-ascii?Q?/DAlXUqvwlfRPSo2kk2CJGEPMieHcI/U813xmg7CEhTq7XLsfNjRVAUHCPsz?=
 =?us-ascii?Q?kjX/1KStLYT1s/uUR7zCgb2E3gP9kFNPLRjE9BpuAUfojGdsB4y2jcRDmbTB?=
 =?us-ascii?Q?VtZjxb7byCpXMYdVMJ2c+p4FVIPqZraPr31vzAC2ShW0EhY9X17c04JahQhq?=
 =?us-ascii?Q?jUeSChhjtTRo+si6jYNTz+F80PcEXu9NkZXFSy+jACYHgwrrnyjuBBQwTGul?=
 =?us-ascii?Q?uSdgL8xGKypd+CHvSlCAemXN2fCSkwn8OxmZp3egI3ppSw8If/71MPWJBVgd?=
 =?us-ascii?Q?gIvfdLmcGbvVpFAg4ABL2MA4r3ykxvwyH038SYgiR38G77MHayDnF7FOwYJu?=
 =?us-ascii?Q?e5jvYNy9DjVMOHPlxxWUQsVd12mDXAEslMMUUCjzhgcKTSHj+aDHVcVSquG7?=
 =?us-ascii?Q?BrvqsJOLH/CnNPzDt9jP/u9FFdqPV1amhvjoKl94p/8z+i6XhC9rLNtDoY5G?=
 =?us-ascii?Q?TTn6Bcr+niuE+HZ+ABQ1FapspqtYIHJY+SS6u50BGckwRPiGo486Hvsp/oZX?=
 =?us-ascii?Q?eHwpRAe+gHv+9IG8fOCjDh1BqG9UCGt02S76gXNZVxEA4/GEpOoERCMu556D?=
 =?us-ascii?Q?cba/V/VibcxLnyBAWveEPZnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3c4415-9c7d-4231-5663-08d9156bcbb9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:37.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giy9+Y+MrBmT5iW6nHaqsP3ymCD0WmEjpavBQ/tMwQNyYAFTYJ+G3vTpgGi9BggMpIcDqO8Ko/YDmuFKED3RAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Switch from softPPTable to VBIOS PPTable.

v2: drop extra parens (Alex)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index af8f4101c523..9c992f31cdf2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -348,8 +348,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
-		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-		    adev->asic_type == CHIP_BEIGE_GOBY) {
+		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
 			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
 			case 0:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
