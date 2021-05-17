Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0071CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B968A6117A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B968A6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D986E9C5;
	Mon, 17 May 2021 14:57:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181D66E9C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM3bY+mJ2sD4EtVIaZJwZvbVTOTXIkGaBIkBtdekssccK7d0FVzHSr6K/7CcfWst4us27xJVRuOV8z7Ps+jQtgf8QPvZzfoVG/WS9vnbvDd5q8W6TqYuJVaRrzn+kXhH79nCSuF1edK0p+SwZx8ZhPBfkHgM86h4+oQMOsidpv+WE7P9VRHYPVbCbwwID2/qHmb6MkShWoRyk7OtkUid9uxzjSp+Zy9zObCugnQFXDAoHCgAvUDWjKY9/FiqajUc7l2CdGcf9IeaKHGa8D1nKsxu/DZuBOMOtYTwcy+kI6qfkcYPgpX6d66gU7qy+LhSeL118j0kKMGRdJO1ppABQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BtehsYfcaujuTAIWT3CPN8X0jl0CwKZCtnBKdyHmes=;
 b=UyKi7/GGQhDvvLay6W/WP2HskJ8V4bqcnz3qPA8KwvSGMh5mTcNvmigtVeEtn8/ECAbl/bwkuBDPW8+gJWI8CPWEQLlaQh3FEsi2BmD0665x9Rn5kjHXdtaaD/mawagJGo+rhlfMIZ/ACcf7vaUU1r+M7h/69gQ/EcDBN5JcfiBnJ6h7cx8j202hJPfJcS+olVisoJT8iQ+/1WrGmuLSTmCt2I3lwDqckGHYsdwwEVrwsfE9eB1anYPvQiRQWImQixJe3pTpickbdZyGWuyaf03QWjdH4KgUY+ibpPE4M4Nq/XagNNbBbWuLHeI6oexFK9ro1FXjRsKQjbAVZCQZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BtehsYfcaujuTAIWT3CPN8X0jl0CwKZCtnBKdyHmes=;
 b=ki2zAkq6hfq1iexm/FW38WLF020LZ+Ii8Iu4KoIol6V3gm3Hr/BfjI90z2nAZgcfWuEFW6scSKN1QvwBIOX9ddXvPOm7aiNfGQxxqC43CfBZxtXptpwVbnTBR+BjhdRUDrV1J8ZCd4G1hpUNikrrv3rdWk87qAqfC/X4NXPYt/g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 14:57:19 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:57:19 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
Date: Mon, 17 May 2021 10:57:07 -0400
Message-Id: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 14:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e74bbef-8d07-485e-243b-08d9194411ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257F3C5DF77B8F199E636C2E42D9@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWMWsdelc8hUz2i1OVycU2K33xKHbRinxhsC36VFa4V+hMTiZpiQRhuSxplB1K+2uuAAMrHvcl+u1vKrddaea8KJAe53zwfi5L/YlRjiKViF7NyGIMce2KCXFginI7ldDjPVAE4fFSaasmgSOGOhm5DoSvXZSAh8OKCJJ7FZQDqX8cWMdwvJV2X5JV+vgAXyY7r82YHpgm4Zn4Z/pBPsr8eTl7+uEGAvAj0DoFM7TjOkNQokAOmiWJN6Psb2NKwVpXjf2xVvBQIZlcf1L1Nl/Pdz7M/jMVcudAhFNQmofmbeB/fZeC2tXrgSowgciqmttxYEMibXCf1hzgJE70SGsjXA16uwmueXVABuKKOsgoK0As9venopAvIUFme7pql3nlEGy/DrBlx6RrzdpghYb6VfhK+jndYGAOVlwfneFmPMJ9yIT6jB0gm1/VA4zEyGId9iR01V81mfxrEgTsieFGNzOw4iDuH5IXV6qVZFodi4kxm8bXsPgVIaWWLdYXTrLE35Wef4ZkL+B8ZJuEybsz90LAZL93qkjQufFeV4L1kQGaqgeBo4CSGAW74x9GP0EeYGsM3dyI7+Tq0lhgUMidK/oFwVfKz0Y3ySNrIjUQr1r2ATN2RMQ0dckWpeDDgHwn6MRdow4jO5N5lr1tJ9kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(396003)(136003)(346002)(366004)(8936002)(66946007)(66476007)(66556008)(7696005)(478600001)(36756003)(6666004)(186003)(6486002)(16526019)(86362001)(316002)(4326008)(2906002)(26005)(38350700002)(38100700002)(956004)(2616005)(8676002)(6916009)(5660300002)(52116002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gxM2cc37WW6G9r/AKvTBXZPpARKJMKV1pSBFTaTbx4mSPTXOwbHvEGqveGmf?=
 =?us-ascii?Q?ZBUW9Erq5tPmRDPNQRvbsYQ6s4nH/YN0uciRdBTqR/P6NNwFDXhvqIzyamFa?=
 =?us-ascii?Q?f03gys/R+2E+fMTS/+yTDpy++NLpTN0owWakX+YSX0kv1Ta5M5JmpTD13QjO?=
 =?us-ascii?Q?NOIoH7zQmHx3hRKp51i2e9sW5nCDbeZmVGeFbrjWp2LiiE586xYln7qjx3yv?=
 =?us-ascii?Q?O80gsCjsxGH4dIYOIs2B5rkkXzbsAho2hWPVVVv8xj0C/JcE5YU6drEY2MCL?=
 =?us-ascii?Q?N2xLcUHOR8x/HSLpMI+adcA1avXXcm7Lpg7ZmpF/hdHZAvOV+bcTQ3tK1qp0?=
 =?us-ascii?Q?XF/gLOAqxtlxmffUVAeSxUQv1BbWbde/O4+COV9UyV2f0IANTrvQvoF8hVBR?=
 =?us-ascii?Q?o2elGHtunNthJYR2drz7UcWq8UAycMTnCmk/UBiGzl0CphVH21foIid/fUGb?=
 =?us-ascii?Q?TxVIyhRdSGuo6LjQvGBmho5ck69uCSIUqNV03eHKLC3N7Th7R3sN+U1Ki2BL?=
 =?us-ascii?Q?WBW8EcKI8IwZayV4Z7roqbBFCwTcKsuQDKC/q4NnoD5wC0WHxjgRfTdY0gUp?=
 =?us-ascii?Q?OZQX8EeP1Ja+CppWvRJzQv7j5oBDsFadUfWRIqVoZvEnyyQHRjnDkfvexwUn?=
 =?us-ascii?Q?EMSTds2njcV2CO9oiTXLdlGg1HmNMZqBiRLLoqQKg/8xfm9pVxVVBPKovbV/?=
 =?us-ascii?Q?NrPW8PVi4VKj63k2RuHn5GUAfIoprmNU9oyX0xPZwKKtVn72txgBVIQW+vYV?=
 =?us-ascii?Q?6iNfpqn1vokzPuNZ9cJlaMMzDQxEmPXZPfNTpXpCjjHOvrN14HwDnl80K5oA?=
 =?us-ascii?Q?q0WSsZoL4+hQKzdSazo19y/ZKryd0xn8DffcfzszUsIeHcrVtA57/Bkcqnhv?=
 =?us-ascii?Q?DDeYr9cH4qvISqJZy1S64n2e/aPZncELxVzH6tzEOs4ZSXeoK/ErTaCkYnqk?=
 =?us-ascii?Q?RdTKgIwdjLcXUmc1JV2scsDPuk/+UvPWYsj4dTKtAIhF7TrxKTue3Q5Drd7h?=
 =?us-ascii?Q?U5OUkW655GbMKtUbeZTAWMqKil0rCmCYEcrAOLTiFfHyF6vPug1Cnw3L6r7i?=
 =?us-ascii?Q?IyS+PySurTQt5xR00lMvwLBfXMjJEyzAmtQJU1139ipTvZ8kmh/698/mA157?=
 =?us-ascii?Q?eeekCFr+8rsMPvfEAywTX6OfTlhjJ6nfjjm55YEARk2defCRepNqOXC33ien?=
 =?us-ascii?Q?RwXrsxxzktgGTmpyhAHJAeJavGFqdKFMRQUrZL+//UBOyl5apR4P7Jtgsyxz?=
 =?us-ascii?Q?aBxZCWPdoizkbJ1MeIQ11hPbXpzYPGEoljCK7GF/TIC9GpQRExYFxDn1eAEP?=
 =?us-ascii?Q?rtt+M+ye4FXD6tSk+h9sx3lg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e74bbef-8d07-485e-243b-08d9194411ae
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:57:19.6740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONIT6Kl+o6+d/zpZK8vd/jib4Qw0TDMshYBNpSqhtf9w3sAtp3pajsielhH6oU1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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

During vcn suspends, stop ring continue to receive new requests,
and try to wait for all vcn jobs to finish gracefully.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2016459..7e9f5cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -275,9 +275,27 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	unsigned size;
 	void *ptr;
+	int retry_max = 6;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		ring = &adev->vcn.inst[i].ring_dec;
+		ring->sched.ready = false;
+
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[i].ring_enc[j];
+			ring->sched.ready = false;
+		}
+	}
+
+	while (retry_max--) {
+		if (cancel_delayed_work_sync(&adev->vcn.idle_work)) {
+			dev_warn(adev->dev, "Waiting for left VCN job(s) to finish gracefully ...");
+			mdelay(5);
+		}
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
