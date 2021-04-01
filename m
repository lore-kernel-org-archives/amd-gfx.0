Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3904C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57DA6138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57DA6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1306ECD7;
	Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726C96ECD8
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTU8XzoXlith0z2wi5J1bxo8XgU6mT0xjE0OHwDma6O32sCSdtsMwiRGUmTfqGZYczxT45cFPSFkNyUSqz3gRrENDuUBImaEpIFdNy5SUuL36xvFF92q9gb3Ek/cmIXEa0Q4gt+4y8dg1cftEFyVp1Mnxs5EhfSzrmDYTLSVgHz+9TaKQ8rTGrZOu7wfLI9cFGA5vPUXuxNf7fbl4KhQr5lBBq66vExopaI2D4lCcLI5sPuDwI1wvumhUSxzjt/NYS1RyhGYKiaGAfKbURykho/ZWVkT42ztZpcqH0jwMPXe+5n0+v5MAEugfJQlpMnKqEV3wfY8gKd/+uXmZYorZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iidamq+uzz6XE+DorhO81X9qR+rOrqt5tWo8FSWQGv4=;
 b=dcus1n9eXLZnyj7Y/infYI+cuuat8xv59oFsGHWBAlyrUBLeaMeBgJEY02/u+s7swW96bkCTWu+I/idbaabD8ktlGBSqs/xI6MX0EpCuvyeRmP7YRPvpyzm2zac8T5KV4IN2lTYqRaWaVMTLeQhlaafp2MNrHqVzDl+GdoK2IE6qCTroO2ohz6KGa93MkMvxm9YxHtrNb7aI8XQL5T+IOI0LSAgp7GB9MAIONTQDx65Ja3Wojn22wQE5wPHNATQtViLlMlbumUO+ZdkFQ0lyNp4YDaq0hdVxj4PBJVA+6dk55Tsy7ldyB4Iror1SQNKu/PYz7qqi73F4KXYqkZOoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iidamq+uzz6XE+DorhO81X9qR+rOrqt5tWo8FSWQGv4=;
 b=gyVohXz3gvTWtQMOJzmzfnLu2+or0rw/e1TP3mudsCpGPoXStmsxXX6yU5qA69CrdeIAIpskCdk/RDUkQB3gx57+YPkxllr+876eelUAP9cgjMLsSQZNyPB0BrgZ3uYJTDXpLjO7JEsklKWS3H4CZRwdjVbCvL33T6dSTuMAvp4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Thu, 1 Apr 2021 16:45:55 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:45:55 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/21] drm/amd/display: Fix 32 bit compilation of dmub_srv.c
Date: Thu,  1 Apr 2021 12:45:07 -0400
Message-Id: <20210401164527.26603-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b67434b-66ea-4445-19a4-08d8f52d9e9c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB151491C1900E2B834FFEDF76FB7B9@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ggor4I58TlhpoTqIE3dP9cDk/DHQ10jAeGlp1DX4vqTeok+8VNj2TjrDh3C2Fu1l/SWyR9ZWmnaG4P77pIYS3e4vTmrGDxx7nFJq85ubjEWaCEPLJtTLOroZ1htrljMS/K0ebiYG7UO5NYfUxwNWFv/PXoH2izukYj6wQ8o8BvqV+Kvum3X6D5dBwo+sm2PgyCU8z5fhYuDFacwgPuXCksE1TNIi79ruH2t6h58El2dkJmCuRI8+IZ1MfWWldeiFU/Egv5kcHPoJDIKAaz4GHidcY/1ZYciES3dSM0EPHsClANWGCmhihIlz8AwRCFX8q609Obv8PHZpcIyoL4wkW0s9fb9+wKhmiPfxCk2Ls4rzlj4bjYaYGD2hXy0Ve5DlbDphrnUk3V3g5Nq4uAxhhuSXXdT9WXW73kDQcJA29CDPUhGzjLuV8l1UJfH3sylBg7egxrmKRDnIcQEPOQQACDQsJJfEKVv5EfnDZhHHMzidRctqQxFgI1+++63hpl5Dxq7RzEZv/qcLU9wdkWyPT98WpV/raHeEdeknjnZOCVWy0XdYUSf3E4ZXN9JZQL7AzenL/rDDP8i7MY/TmRAIytYTeviRePeZUZV9Tb8llynZxTmwHq5E4SbtuoedIWaTApBeZ4sGWeEFtDiGB4drQTciglLCUfBdvkgbginbzqZXrjMFBOzcuF2kenh9fM+1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(86362001)(69590400012)(478600001)(44832011)(8676002)(1076003)(6512007)(956004)(16526019)(83380400001)(38100700001)(6486002)(6506007)(2906002)(6916009)(52116002)(5660300002)(186003)(66476007)(4326008)(66556008)(26005)(66946007)(6666004)(316002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RVo51/B93zAUYX2IbPp17gNvjV2oZqKNjhDzWPt5v6TZpkXX7G32PuKDsJ2s?=
 =?us-ascii?Q?0IqWemuAIm5SDzW8GtqG26CkIkuSTfyNfwK8SLVSmukmjLYe/TuFyYFcuQ5T?=
 =?us-ascii?Q?USafoE8J5lXTJfCu6D1ODNtEwmrKjss864nvWomo9bqJQaWmmUMoo1huzR1Q?=
 =?us-ascii?Q?jtFukSJcvhnloWD24d4qsQ3TPMKlta5/OTcosQChvJJGzlTENkBCIwaH3412?=
 =?us-ascii?Q?dxaoXEQNAafJASztSgsT3yc4T+c3ZBU09K4E6AbYP0NCnwjtc4AnBhZafK7Q?=
 =?us-ascii?Q?wC1WYRpiWDjbByCOD24cQwk9LlcnTDxTGur/LwEJ9Egb7ESc9W9cg+xU7HbD?=
 =?us-ascii?Q?dF49NW69RNB/CCEMPfAlL6PGFFzQg1i32Jb2gKted2KATVIj4MiJRqj4zHDS?=
 =?us-ascii?Q?JU2btwSYfTu8i2CsAsCOI4gzmWS4C7AT5vO3RaC8f38VtQjesAyXG6Z9+Zy5?=
 =?us-ascii?Q?Z6yF1UAP6vjdRkLKaihslTcj1x91nyYoYTjoyTMIFX5xEO3kuHLFetAIIPL6?=
 =?us-ascii?Q?Zy0ldIXPf/9Gp83089dOuokUkJxIMxcvGyC7/RdQvaP/WBV4mKaEkrY2Y5OD?=
 =?us-ascii?Q?RJ4E3ofc1jOqRRzRXKH8IObk+e3TZIdXBZDF4NX1IqkK9fcaZY0L/whasL//?=
 =?us-ascii?Q?kLcIQekWO9CDT438Z4eHVE+5tg5G9D7YMhUlrT6tr+NkrZp/0zf0hI/QU7TG?=
 =?us-ascii?Q?ASWrn43QW7KmfKxFW3io0ImnghDLur70MMpllBDsk1forMkfFR4LyZXI8SYZ?=
 =?us-ascii?Q?De+H68ttmexZAHNVhGCe0NRRpbo7dNUVLRz/wI+fDoKVhJkeVGRG8Ey3Y3fN?=
 =?us-ascii?Q?3S5QJvOGK3WNvfhMVUJBIMfG2BC5D9PWzO9B89wm+mghT33NgeuPmhvxXpMO?=
 =?us-ascii?Q?msRF7+0vhOkChuyQ7JQ5hCidrt9xpQfbsHOp0idOKkV1CuJmbLH+Q39pK1oZ?=
 =?us-ascii?Q?pvOEaefRC/sHOqjTzpwajBvtXx8k9gKxwWUUpsNQZcHK/kj3nMpOrhx5ubQ8?=
 =?us-ascii?Q?rC9ycaErKxPJVQSuLeyzzJtLMna4qonaimRh/Mri2NjI1WOuJxiYgAWU1km2?=
 =?us-ascii?Q?NdDskTQwClJjpackucLVnHdnBgZI7bTKp9H/DceKVi+UJUF71xLZ9yV/4+v/?=
 =?us-ascii?Q?clZ+mII4539PKcCXyatn+/khHsDotpizMBNNxYCW3xW6B7c3L5u7fw8yTwVx?=
 =?us-ascii?Q?fPRuPnB6lZdaveGX88ojDob66PsBWxATw9J4sTAkvbkTSxQ2Avyuui1xCiBk?=
 =?us-ascii?Q?8Dnu+at9e9XwKxyG1XXimvqpRbhrn0932dYgL/E+RaK28HJ8U/SncQBfMYJ4?=
 =?us-ascii?Q?VRDtSxJfOaWg5QxlVrAu1RIx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b67434b-66ea-4445-19a4-08d8f52d9e9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:45:55.7688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XxJnepPiR2NgfNf0WRQ4Oo4dRdcloPYo7qlK/RlfAy3zV3SwDNEPWac8tA7gkJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anson Jacob <Anson.Jacob@amd.com>

[Why/How]
Fix cast from pointer to integer of different size error
from dmub/src/dmub_srv.c

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 743d3b7f6f24..e36e89157703 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -510,7 +510,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
 	outbox0_rb_params.ctx = dmub;
-	outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
+	outbox0_rb_params.base_address = (void *)((uintptr_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
 	outbox0_rb_params.capacity = tracebuff_fb->size - dmub_align(TRACE_BUFFER_ENTRY_OFFSET, 64);
 	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
