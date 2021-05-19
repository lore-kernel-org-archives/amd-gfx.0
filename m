Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA84C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4217F60234
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4217F60234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F3A6EE19;
	Wed, 19 May 2021 16:22:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4635E6EE14
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QapFI2MAulHNAwi/xBfjJriulvX1DN0ZoLwIh1wadZr5pTwpsxNIrNQ3Vchdc3lFUw45REZ3d0chV11vzOKqhwJTv94oPGfcJXKTWp4KcRzlZkpJr5n6bR44cwW1idvhgGzCqKY4Ha5cVzVJmFx9g54bPfteg4yOtepjs/yOqMgGrEr084+pMI3j6LDhaF0+lvyRkKvSp2Ijb8S7+1cu+EZ04T/604PGvaylhQ0uNAH8tWrLetd4MH2RCCerN2/Ya8Kl2XteULyr1oWqXWGf6qXL8GmA9d/c2FxvhYm9sCvAA1Wy1OgoKUoPjQorhKfAxG26MRAfbWHc4szc5FVaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdt2AvISFAnhLW+ktfo6l+yBLJDDT7q2WOmlajKwSNQ=;
 b=gOxMbVjU90kJuIOqL3ZaRPdQeuw0i5hLPDZSEDu8LVQL7dHJeKd05ag7cIs6IMoNeHLjHQnAixHy6X3yKAmrrSfzFUhJwRvw0bpBfRXKU+4iVrezoXtEc1Y7in9YeSrwYtczR5c37L27W3rkBP2XRCGbfs8DVfJg/lbnmbIlKkeSJjWaEsnOTy1TGILaTlohYvDNh7JbNZSJg2V8s6qdhiPmCbrQp43Qlw46k5NclDUvG9NTerstYDnUbg7RG2n164G8sBJQjal04CaNpnJpMZDsYkRQAHLH4eejZA9ixS88WCOAhjJgfVP/nQ32UscNvwetpbCsf45scyZPuqY1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdt2AvISFAnhLW+ktfo6l+yBLJDDT7q2WOmlajKwSNQ=;
 b=LIDtHMk4BtFVxb6Bh6pyJJEpsVABuGCbV8EmqUFP+lnEaCDAMt2gczDHKzpdgA7oQpAL2n43eXqnbVBlwcsIctowiOZDLOcbeRg9fSXWH+3hcpOoLmre/0rzD8nkFZs2f/5aDFYcKR0u/Al57dRrgog4I3DXApOsLOcNQCW/gu0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:55 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:55 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu/vcn2.5: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:34 -0400
Message-Id: <1621441358-14685-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 032960ed-8ebb-4d90-5dc2-08d91ae25b30
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325961E9D4ADCE1E00F86707E42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XyuTJZHLn49+0c7M/wzyAqNcfeVyQLtFa08wkCE+p79GqnMjspJpVtRUynu6fZIi39NQokZBUroQzAogJWsQgKcwFegYAI39cZinN9JfgsqbfD1edELx13wT2RXv0Ne9VAV+Lab3fic1S3O+CoCkf2kGL2BLkJWznfdoSMuLvLQmiLOsoY92GagL6kGXmmIQNMLFiCCZmE5KUKsh8OZoOjMxfzSVp1/jpfMjWkmeyZePEI0gWbcs2KmhfGqC5ws0pGJnrofE5Gin2R5UCEUAhMwYvAhTtMn7D9B3Asp7X7mr/GsDIXyLTCTJ1zqTsemyv1xGbE3LbLJXiMhwJelC3kx25HBPFG3hQw0R/JlQBpaTqh/byZmSevu32TD/On+FmmHT/+3tAmtjUBlAd6Q4QSbSNxGWuCA70FWyt0rXSbhleia3l8jFHcQy88Bp8HeM12J17f+lmVPHV7MKyluFfjw8mDlRiLza6MCRxVK/iSbjqkBEX7ZTqEGML3HjFub6bD9Lipn4yy2vOb8MXKgluxZJmWbATd2C+Kylo2/5EGi0NTwlVyvuIGaJ4Bfq16M20yExaUydNCYxuy4MVyx2n5lgGyGT18yZHZkvzN+LTAg+rG5UstVKNDfdsIK5U/KQYOb3v0AslfNvVv38uHl4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(4744005)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ECfSfNvcnllTUlEs6u2tHIvfPsexreSbbACCgI4rcXesufibESD7lAd7eleL?=
 =?us-ascii?Q?x8UsKmPGwlQpkDgKuBii0P9myiYOyGE+kfm7hfL05ws4GCjAWy6dqOvOG3T6?=
 =?us-ascii?Q?wMm1Bcrn/U0viDNyTtGmnBQOk4pF+LAFdoNgoebpYcac53NHLyU5gJABeFi6?=
 =?us-ascii?Q?EhbBPaSuzLMuO/u06hDPXAUnjROzKhcyTU7UX/LdDiiqPbHImQQlKLRWanPr?=
 =?us-ascii?Q?2O605e+D3HO5WdyF1P1QiXZzTsNbRnN5/vyu1RY3ysqG9L5o7KFqMrJzmOlb?=
 =?us-ascii?Q?8T/Fxfi7IdqkfYa0ojhqwLAAJiGwOqdMOnFW2v0i9p4qBB+NrNNaqqkEoGb5?=
 =?us-ascii?Q?Kmd+nBQHKbQFUccnncbZb/DYq/TQo4cH36UmDi/tzVZZSfSeXcRkvvN6otLK?=
 =?us-ascii?Q?cTdnCKxlnVwO8M1Sw+Bpz02DHUSI7MG8+PFksPpJ+uI9Zhjoxdw103TyLQvm?=
 =?us-ascii?Q?TmtPQs61aAVdKjop23C7EcHZrLv1eh5UQTfC5fU6JcQCiO3dk8kMEuoU35ac?=
 =?us-ascii?Q?WwaQWgwL+0Xfjg1LQgrT562E9z33wlESJfGpSVvTYDVK1VB98IhjJgpEdMsG?=
 =?us-ascii?Q?6JU0u0CYDZSka++6GuUwCXAAl79UkToeZNXjgplw4I5fO+13EvDL+2SKDY5f?=
 =?us-ascii?Q?ACI/Vdz3Y70DAAbYmg5wdoQNCC5mHGbcnO/Vwqg0Yof5OUOy2pG7jMFQYBkn?=
 =?us-ascii?Q?wzENzUpOFjGMoabPl1assNdmNFCd3KEYJcNhKu9Q6u0a3iUiaxF6rnqtWfb4?=
 =?us-ascii?Q?ZFREgBwkcPgGDUcZaiRw9FKm+VOCqAiYl/qGrH/fXMXeSiHtE7d/4OblwxgD?=
 =?us-ascii?Q?ywOk3ZDU/1zHCHf6/P4TTf642kabawL33qAxmHca5SgcyaoXxVefUkEavo7B?=
 =?us-ascii?Q?gjz5PgGk0qRD/iIB+Ok8hGPIHLuGBJXJ+SJsvskXejoi4lM109aACIAeauml?=
 =?us-ascii?Q?A8ffhpY46isIJGIPYgOrW71VSHzg7XO7Lo+4AuCuo1k9VCNDEV+FBDqYOVGj?=
 =?us-ascii?Q?snDntA8BFZtqmlPI1BApYuNctjW6sKz3X0ngAOBJT+Gu/rQl33kO1jW+LmsN?=
 =?us-ascii?Q?+XbXSQu2Cr77cGox1qQ4tm3MYsmYAwAP2Y04Aiyt8NpSQ+bDvm2um9XM4NZp?=
 =?us-ascii?Q?Fo4lDRD2WdbZ6999LfMjRsbVXv4gNjQGz6n0IyQE8kGZ98cKwdjDtdUi9BfY?=
 =?us-ascii?Q?0bfVoWbWzfG2woS/7+pqLM0ByfLYSfgHSH7PLE0yHNwrYJ4vLJfzBch4OIcY?=
 =?us-ascii?Q?q2ppaXOyLAmSh5f2NkA37KKMbl5gWrnZOWAtbKmzHPNQu5JGGIa2iG64HpvS?=
 =?us-ascii?Q?6d01B60RGGUL2KoEcPhIaa80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032960ed-8ebb-4d90-5dc2-08d91ae25b30
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:54.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBJWvUjv9bR6BysQT+o/Ssw/CdCEumjEIx31c9BZONyrHdlHpzIHGjXtGutr2iL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 948813d..888b17d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -321,6 +321,8 @@ static int vcn_v2_5_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
