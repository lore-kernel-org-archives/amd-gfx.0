Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5786C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 16:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9976960C3F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 16:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9976960C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A78F6E3F7;
	Fri, 30 Jul 2021 16:02:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6086E3EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 16:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKVTBCiNGjwcvroSZyKgQNPnSAB2vlw42OVu8dJ6ly3O7+sFpeFgwGOQ5DjOQgb9BXkOCkgad9T7vFrPYittNE0ZYP42QHSQdkCHPN1sM0G6t+T8EqXlNw5XsDRfZJE5WjJjpXv/cE1++e0PqslvjbWdC/LqruX52tpymoeu7/6PsGW2gM/k8rVyojomgwyT6cpxaWn3mkJ6fvuqTmN/Jt6EoFc9Tzf6/AaVgxWmVgIOhcpmzuEqt7r9i18se1q4gaZw4tZnDI8OB7vgQ/vKBr6LBhR+ETDfVIF3WE/e8nr+oHGM0sboi98PmURhHSKIShk0WnrKU3kQjDQoi7KzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWzOacbsiIp/jOdbbf7vDrIr20Zohg+qVNR9ZY6OQHo=;
 b=TfZmUjKyxPyviId64optRV1sbIEreml14Whv46gLzLvBv8Co+Pi8P6WNYA5Cli/vfEC2kwIk8iycfxjMwr1sxArUH/A3xhdcsplSe3g0xLNWcooGd5CzKtEk6jkPzjMMNc+5UcH7C6Wps0MC9UZmxB7TliAsy1T8R3Nso+ApiRzjngzIpjAjtsoU2YySCaLB/n7UIbIA3OZdz8eXpziPrbLpxjE7ENQ8Z9xLPtVL0+ER+IRFtAaVSdQA1hyBow+bNKsHMaAkRBiznUFpGRmoe3PL5kSpTgmhoekQ+b60S/p5bEOkt6kLPMK/EQ4aCFWboqrKLPDF6JzoVUz4YZCWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWzOacbsiIp/jOdbbf7vDrIr20Zohg+qVNR9ZY6OQHo=;
 b=U2wPcEzZ6/2hY5NIY+9stALwZK0MpuBg4yxV1btsLLYM/Jyell4lPT+Qb0fbhjF87xcZdCWnayJWir26ahEd2B+wE8EWCRbzyZTbIkpxyFn4xwcRU9g0RuN3FdQ/73Xx5M7zxwRmCU1vl2YWWxdciWu/AOypt2Kuc5SqOFDvhzo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 16:02:48 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 16:02:48 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] drm/amd/pm: Don't output SMU version for smu13 every
 time
Date: Fri, 30 Jul 2021 11:02:29 -0500
Message-Id: <20210730160231.3594-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by
 SN6PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:805:106::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.0 via Frontend
 Transport; Fri, 30 Jul 2021 16:02:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af35039a-ec21-4104-5b44-08d9537379cf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416651172A1C7F80D4E36BEE2EC9@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVQzGNRZqaGvNbja10fMWxmekQ5OY2/ieVoJGuCovtNwHDt7rV44/PgIBhVi+rszpt6wY6qRdRbqFIymnZQ/eHB7fJ+ls9Aj7RqD/GL0M4n26AahMcHFrFV3/GK9CbC4zrS0erYSyS50UVsO3NFqA6Vvmc5Ee4CMr3fkmwmGwgDPUokH7eVwSMROH3311XA6Jh/q4rWpFGfoScrn5vyJsKt5vj66mVAVJPXriBE9FFUV11n6L0JGOx9pOZmp/K/33RY5lPWseIOI/d+2Ycarbymubdt3mcVXnQ9aIbjm6zpSGUrDZUPJMO1yCPTi9S5ziiEc8sBJf2CMEfy0O3Yo1s69RhhtUw4Cv7orOP2/+9ihmCW5RP+qjbCBuLVdenwro+8Zl8E3zUD7YM1RMxlcU7JwytnWfjVPFB3I9Ry/yzFlpIH94AvimzY59LauOlZjnES2/MHQdOCh4q8m+BiAkKbBNpsds5Hyqj7l8jTNkJSiI9iLEMJMJHwQjP/8nPvjQwuT1ORkJdEmqLqR33zpHXFPaxmLERt1ildzzv1xhM0r6RY0ULK4CVE0SmcdiNxM3jIeVrolN/8IJGrB3pLds9a0TIp7H3khB896q6j7blLMX4QdrCRD6eqyqBsuuOTJmhJOjnUFXJxcD518avI9auyUUhCA724FHPSoO+Qh1GsyyqQKqWrj89/uSCV7aewEdkJKCnBz5r4GA5xPxmxgxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6916009)(6486002)(4326008)(316002)(6666004)(8936002)(2616005)(186003)(956004)(86362001)(26005)(83380400001)(66476007)(52116002)(66556008)(66946007)(4744005)(7696005)(2906002)(36756003)(8676002)(1076003)(38350700002)(44832011)(38100700002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPx2fpqO5ukSGlYHp3bu3g9GPDr+g3XYqwYzM7QICgw6UBCaizDaZCKyk0QM?=
 =?us-ascii?Q?17ku5y89h9PCgrGyj36zzs73YqQwH5zihZBUkGCxqXsc/NKPvSS+iXilJhV9?=
 =?us-ascii?Q?UI0/ig9xjlrN69WfOouci+0fct8iAx7sqyBouAi0Ewa4g/UEBMD7YxWDZ4O0?=
 =?us-ascii?Q?I+G2IIEAnXQd+ktjEJVfRqNF1ALc4ZwesxvJiw2kIq/weVYPwL3HtjgL3QeR?=
 =?us-ascii?Q?dPlQoeE9pvAFjjLAHq13SXkVX4aZnOF4WoYwiiLCFK/CV/42HRa+zblUcig/?=
 =?us-ascii?Q?Emoi6uuYsYsxd/Rhovq4mlKXrDVrfFwDQ5gMqCFPZ71pavvGWVOsOWWHJtRN?=
 =?us-ascii?Q?Yr2p5ow4TiIFMhfNlVXDKc4JNSbb7GA/Usi+bb+HQ147rRkwt0REksP+XvH6?=
 =?us-ascii?Q?t8Tqp6SGaJnP6Mir0Ju8dTlY/4hA+HxyZYQmbbZNZhqav1V1xbaITsQhL/00?=
 =?us-ascii?Q?dkzSLf2FqhcSFxfB9BZkTjkS4nkuSq+bzX2CpnGXbumcZFC6dxGnqNv3dpkl?=
 =?us-ascii?Q?492McyyNJnFDDGIcun4PuQEdIxasFwLHt/7vOaJaJG7IwH3jY5ZRrmsuzcmQ?=
 =?us-ascii?Q?dikaLyFacewPVhz3NL1n6T31UMBY2ywwbM0FfyEu9WjrDb5FA4bLu1VT4N4J?=
 =?us-ascii?Q?etD06ZE6nWY+jIPzhXmkh0spY/zblYq4K34ZDkenHrHrcG011Y/mFznHE92w?=
 =?us-ascii?Q?ZMr0DpvvvSdGQDpFujR3EjAHU8oTjY1Sey/GFQrcWrAXPdx5//N96XuNJy67?=
 =?us-ascii?Q?uY4YzMvI/FzRg41KQwNzAuqmhIneOP/XW7Q44qBVwNFdDXNGFHQJBFla57sM?=
 =?us-ascii?Q?dHiSZ0V8sjpsjAokzORzzKa3s4qHCi1NuOai+uvCyEm2cif7RJKbk+hK/ai/?=
 =?us-ascii?Q?v2sHiezLGM4Tt0voQxLX4lys6uTvuhny1bJsKDgLo6J1n9Dwa2iFxNq6PYkR?=
 =?us-ascii?Q?HFqtbbwHsli7gRJ/IhDXlqdgyDa8PaW0XwU/7vLzniTCy8s7gGwGbfIqG/XA?=
 =?us-ascii?Q?Bys2lNOlTsYUnRUsPOFtcSLEa77aPhiXVjBoky88efx/bP/BBbU0pdJzhrhx?=
 =?us-ascii?Q?KQtiQXdKf21ZbfB0ebrFNqU5EyBNGHoc0ly7KVLeGEcuUo6u/6vCQwU6HU7x?=
 =?us-ascii?Q?TfHJ+RcZQHvmLH29HXFRJinnvpqlhj3E3KOATXRK0jgLb7+R4Rl79SPidNq0?=
 =?us-ascii?Q?G33wlNWb9hstLMAENkA1BDsNpgTkaYtnj2Eu8JoLEh+4c/Nk9M5wYat24SdQ?=
 =?us-ascii?Q?mGKPEX/Wd1aUE/Pq3HwSQihiROj/edf5eNyFpKT4WWBUkPOUEmLUtZypVTIa?=
 =?us-ascii?Q?B/bcrd1WYFBSQSR85PnbjVKY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af35039a-ec21-4104-5b44-08d9537379cf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 16:02:48.1643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEeSFehVyOUcfwXb+KPH83m5QkvkLbWRJO55TBNYfT22VlZJWq0np5uo8Sd0nouo1UFWwJTCISZoOmnffa3yLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adjusts SMU13 to match SMU11 and SMU12 behaviors in not showing
this message all the time by default.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v1->v2:
 * Downgrade to debug instead of dropping
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a421ba85bd6d..e946314e1f90 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -219,7 +219,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		break;
 	}
 
-	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
+	dev_dbg(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
 			 smu_version, smu_major, smu_minor, smu_debug);
 
 	/*
-- 
2.25.1

