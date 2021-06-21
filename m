Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE137C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEA560FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEA560FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082E36E2C7;
	Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A9789E36
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDcge4r/sOwbGqfL5gAotho7MEYji5ePmEXuDTyS0VIGDaxsANdPH30AhO4yrXkdvsq8/yZwRd0xZKSqcablrVoodbdwjSnrIwqTMolw148C0VllYm0daYSs9RX62CJtv3njvvxt5UeWm9U4rL5/nnZIeflqKqzwOBr9UAHT9Q/h4oSb77iQMcO2Fm5AejutmzsuGnPeUBMsle0gXlVv5gppghgN59fIH9wwbQB+JdzO8dulzEDwBvYhzjYD7oaH+YP7D+C4MGCo7MnnPi4dHA7F2T7m3MFhYIV2FHD/M3m3ui/3dHhf4zEifGIyYkrFzFg33+G2Wuz07jhOWC/dIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keP1u3RZpBWhcz9QqHLns5tjPm5bXuaB1EIWVxFJMoc=;
 b=CJz1+EsiM4FcyMPNWl1xaNODwIKR2vl11eS29kKBKGWv2mTDKVu64PjLmzxZXjtF/s3t30ABf1miXNOgFVfWxOuvclQXe8ZNq78dcOrohb1QNpgWqP20KtOyBXfuu7My55yH1l9AGMmE+tx3LgBFCivERRuF4WNVG3b6hpl09BiGLFslkKThxefmKNj9EeTIulvqcCloouTc6vugboDz0hs3/qKB9FfopgPt6R4Fjt8cBmxrrPCl/EvYG72dW3+JnKkXnTeR5zIPhJ770p1Y7Pqkd+Jmilibod8KtYcf5jBuuAzb9lPylH4D2c0LuqcqYEqzU+hKJWmEDrAGMVUx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keP1u3RZpBWhcz9QqHLns5tjPm5bXuaB1EIWVxFJMoc=;
 b=sqlD/ulSaxBVLoewOEtaMWpf80NBED6gaHfr2oQ95F21UUV6Vs2xZ6eIWT7bUePLSKRF8EBARZ4dLjx0A/o6hKwc1DBCrk/gj8hZ8MZwp83Jz8XM+hliC7JPjN4jWzwz+r+V5v7dRIh5cEIzNNmmghDMTKk4qn58TJSsa/nvw5Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:31 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/43] drm/amdgpu: Fix amdgpu_ras_eeprom_init()
Date: Mon, 21 Jun 2021 13:12:11 -0400
Message-Id: <20210621171221.5720-34-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfe652c7-41e9-4dc7-58f0-08d934d7d369
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985F048BBC19A6DED5BB5ED990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqibW7b1Z+rn9RhW+i3/TL/4idkEpuIJWZEOgZxmtAqN/kPC0uP0Widk++6zr7f3bg9YsJA42lL1lFGQIh68KhN75Y4IfLzG6LebmLK5+Ff1XbzCFv7x5NwqflsIC/qTJYkBHEpa0/OxsTpAUi6E+S+CVTe+qH3uQTk4K6wlJAtlvvK3MD7DkPSxtqwjnHgBSCmO/Dm6KA6xpUS1mORi04AQ2aDi+mOnK1RkF2Jr9ipDu8ortIwdGtAiFzhatYjxtLTtuBcmygViv6inIRI6Iqcalxa2CVwyaGCiNqawy93/yfJ5EasOH79N+LyGX+chP26m1BLPWey6CO6n7DsLxLCxK+ZBgAh6D52onvEM7EX6wanXOCQEpqkcj+ZzI0xiIGZ3l8NBLQHMY9KUdGS0cE+ltvutUxlm3nznN58jiFQ9F3SFe9xIydDbmSeswCo1WxXf7DY8W0hx8yalzA5HGUa8ldgffwXQ5twUWNDJ+DGizg0DeotkwMpyRyckWCimcTHwjNc/yK3v/6XB5oUZmN6AfLEQ42hTP4iZWzJTDIC2KyqEXDzMMlFEOxN3b9yDclvOQEyiTUiHyU6DMZ3fVSQCD4mHBZIJBaTUY0s6Y8cmOWCCdrmH1Gn8IRK2zMBaZBjZqgayW7RcPQ8C/gebSY98kpTiHL5WBQ7AVUGVt2Ha1/oBain6leKqTNXgypD8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwPtwkOhPc3OOw0cZPJWcsw5qR+OCSJcdUWqf1gCpgJux6aR2iKqlChAVa0g?=
 =?us-ascii?Q?Km6u35hKdLrEZPgibGliNmiE4ZjvRNYB2S9esJR5rRDQKFsOlICT/JabfQTx?=
 =?us-ascii?Q?8oBbNXVntFXEbSFvWOWdZP2YcfK+qhCy3CYFvxpU2OfAHV2fI3oRSp0+YZkR?=
 =?us-ascii?Q?LTY5f86G8uLX3P+fVmuImS25S5zEGDCViwwiR5KV5JVZsGmWh5g9aUKqNzRM?=
 =?us-ascii?Q?XhWQYQtBc4XUiUXmwCbGSgufnKMCnSZVXponAzzojR9U89+2UnUEjcIGBie3?=
 =?us-ascii?Q?H+Xlpd/UxHTATECw1x9YCTafoXvbgGKqq1iIase6AX/fNb8iNqgsmxy68Y4+?=
 =?us-ascii?Q?XUUrjiPNaKhOBI2ESt0hljblTBuSg+xQptQKRsw8sI6wTCYYzDA+E+yNqAAW?=
 =?us-ascii?Q?CEJuhzmryoiyLE6/mBlxtAAyM3arsvOKlZArOTo12N0z3hVj1REVNoQ1ovo/?=
 =?us-ascii?Q?SJfdXOdX8Nw7xOCPVTOsBSMw1DWHOzpMAAAy/EHVoZqHeOjBTy+aXGpffOpO?=
 =?us-ascii?Q?LINhX3YjY81o1D56+rs01ocmXyj5S/v1a6OKnOyBWaaCmv8j1UaorUiqKXmq?=
 =?us-ascii?Q?MMQEW9agehb7YRdv3iZ07OaLbr+u36u5mropeiVHaPdFUid7XVGavFQ8OsfR?=
 =?us-ascii?Q?St0x0LFF9iqKyQz9NNmPPTSN5zPlwPIbYy7j77OTjoKS8PZQnzOTXc1cbChb?=
 =?us-ascii?Q?dc2wLBZbhS+HL0wVGAHpF0HRVJ334pegluJSNFdHYW/b6QIGjs1yLDDhZgsG?=
 =?us-ascii?Q?IsWduYKfXaquhP4MsMifY6rNLp4i5sZ2akzbvJ5rph/XW8gmebLqB0ioF4aD?=
 =?us-ascii?Q?C5DDtd5vj+mf2A5YrTuODSx54eb5yxwr/IWpAvxfBaX5xJh8M843giZke74V?=
 =?us-ascii?Q?ADulFCSLnkjv5zSDSkYeqHJBbWmtaMCcwvVySS+W2jCelJaiXyG1XmIqa6bu?=
 =?us-ascii?Q?LjkiBUNtM83PUhXnNDelJBWS5qkNDyHqi4BxmyNXsRKcwZPLFq4cEmm5mORM?=
 =?us-ascii?Q?8TUEWIwzTJHsxduu8j/ToCcaRqz4u1aSO47wW5mXhskNrKlPlpgSS/5WJISi?=
 =?us-ascii?Q?kBDTkEmnLyUitPdVQG1WD4FauCqsupZI64NaYUVLY4feeMa8gQf+1mjFBv2N?=
 =?us-ascii?Q?M0AdkSzPLkuIT8h6xhnotmtEPRMumcSJYS5hCc6NTRvrxjIt4zbCkFnjl4UC?=
 =?us-ascii?Q?1ra20Annbz3k+JgmQ1bBAbPGNMlg5reP5QLrMaTLnBjaDcNebuLitTXh5jsm?=
 =?us-ascii?Q?+QCpBScuTMiGIuHZKgQKSkMyfBnxmGFsbSOn7LiBK62X6RiMHIp5DWcMmB0b?=
 =?us-ascii?Q?Mw9WxCyhMaFhSd39d6gqq77S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe652c7-41e9-4dc7-58f0-08d934d7d369
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:02.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3k+YQCw6pQjac+1VdN6hdnNseu5tnlAYU7odv1Kgiv0wJs0L/xZnw6udL2AG8DA
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
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to account for the 2 bytes of EEPROM
address--this is now well abstracted away by
the fixes the the lower layers.

Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index dc48c556398039..7d0f9e1e62dc4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -306,7 +306,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		return ret;
 	}
 
-	__decode_table_header_from_buff(hdr, &buff[2]);
+	__decode_table_header_from_buff(hdr, buff);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		control->num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
