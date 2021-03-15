Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D8BC433E9
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 16:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5C364ED2
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 16:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5C364ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522CF89F4A;
	Mon, 15 Mar 2021 16:01:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B2189F4A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 16:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqGGXxOAJyw+gIaCvLlz/acPOKHgG/Sc6I1VAqCkAAAwjgIOajcpENPanpuOnG7veHZcaxilchmdJM3zqm+4vFuYwbbc6eBe49QiloTUD76huHT+tddwFsW6mjaUf4lHxyVNHgmsazUUuHGwFY/m8h/MjonSGifSfo1iwBKJnyRUxRBw8dPSTdOinAo75sEby4zRDYWV1yjSEREu4Z0tn1aoDtsHHvSB8GP6PHrKntPH7YpHxrz+dmr/X0IFUlUxoBEpU97n4IRoMOoggpm7ioEvqU+TL5JGqIV36W43CKDOPHqHZ8ULdUHl7wzGN+BpkhEr4nMyez9g5nfL4wOj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2maW14KbybvIfn5OrfQqlQmk5r6bTXVwptiUhqvfHo=;
 b=UAEmEBnKKIVnLJFxx5hTtP9MMhZFGHMwI/Pie3gHYXiSTUgTBA0C/4vxU862P0zmgHEUHlOiL/7uW0JCp7aZyWDst1c4Y5XcOq3Oo8gGAyCM1gVyiSuy+AfeO8vyk0pu9JH3kQpcQmHuzZZzhweQV0pUU69Z+AUVBkXyzWXqFufQw6NQPBq/+aC4/q9BLry0/xncrgWIhJ2fAU71Nm9TuYtf448qyoQJ5Pk1etWj0RYwb1bhmK00IPExc2GcsgGUqDeAwXidru6G2Daul5aQeleosvJNu49rUABG6SiIjdTPD6y3JT3VMdEAItsO5PQTVB3IHq8OqDseaH+rMcE/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2maW14KbybvIfn5OrfQqlQmk5r6bTXVwptiUhqvfHo=;
 b=hVxJfbB3KW8D4dVavgODUcEMSS9ojIuUpdU6QDTs9j8nYllk558ZvXfv8JZdk5e6iY9AODI6otrXo3QyVSKWoz0Kj7XRh541xd/bf5KRsI9il6Xsl4vmsEQYLX/HsA/Kg/tUzSF5UedBLOp+b5SXJcQioxC6ClKpXAcsuyh/gXI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 16:01:11 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:01:11 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: Use BACO reset arg 0 on XGMI configuration
Date: Mon, 15 Mar 2021 12:00:59 -0400
Message-Id: <20210315160059.27937-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:01:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5907af75-c99f-4088-1ee8-08d8e7cb8db5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148AA4A6CA943DEA48751FFF46C9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM0MIDEhwbuZX5XZBHk9e+rIji+J985LgS4zct+41Gg1vXYHgGlKjZ1oa4hK9XX2bWmGc8Qm0Jn8QZFuja86zrSjnlMQSfLiPEU1Gk5hP9OFz4UdZ0VAMXjnxTbvkBY8qUlN1R34M2ErniLbSjukL65C8oQHRtypEb4dvYEPm1SOb1Dy+C3F8tBUIOyHBBrNUtoTINsRWOslvW6i2MLiFdsaP3mpkgYhXHfzNkwTQ+gOtEpavcSJ60rI26XTRbG9XBLsDA4ty4QIAHIs1gK1QG//wLjNjWiyaXqLUWKvXPFRP2cssIEkg55pK1fRQhzy19xtxVe5KpSP09krny6azLgzUm1QXUwy/zK4xvQLx6OHFHu1knQogjZo4HbID1og1HikHRLxzzYgGjJfjal38Iis2z/6Vs+duHpAfeT+5MD/rbraG1l7YQvbkbFVrRH2WD0It2dLQLm5m5b7OTdI4siGvlo30dxNs4VkArylHlecUieNeXatnENIxaVjru/q86+zPL1j5tfns8BkC1L114vUjOldYKnU2IJ6/oPg/DlX1KctyuSAQdOtc0gRHxYHfjdZyHFRKdnqXCttxE0t8IaLKMJJSEYlsCrpVrNTqkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(36756003)(66476007)(6486002)(83380400001)(86362001)(66556008)(7696005)(52116002)(1076003)(66946007)(6916009)(956004)(26005)(6666004)(478600001)(316002)(186003)(5660300002)(4326008)(2906002)(16526019)(8676002)(2616005)(8936002)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hnqDR+CjrJc/db9chY3Mz3tIy0unCYvGC9P8Rz7XHwE1C3vnt2UMU+1WbLg9?=
 =?us-ascii?Q?5779t/amtcl8tgpEo+SJrD051XIdK4uIxr6EgRp85EpzQeQe3nTNoJIKGfip?=
 =?us-ascii?Q?PrYB8GMWdZCCB8KqmdJT3jEAJBlylaGeHdki8dsH6FG1WdKZPiRPk9CyW1sn?=
 =?us-ascii?Q?fGWsM5ruFLUmfGekmQTIM8o7AC0oxaBL+BADDf1kAxaExhj/FkULRRswLWF/?=
 =?us-ascii?Q?EfUujkk6GhVowqf3h0kag+RM8ZekLhtzFK5zmbLAolizOBuKbp2MkUMgM+Zx?=
 =?us-ascii?Q?dqHtXbM1n+4QNL66fwa0k8J2G60j9QmGKfOYpKoze+O8XKu8xPM1o+7qaJJL?=
 =?us-ascii?Q?YTPJ/yIMY6bMPl2t78VtQV5nIrfMEUT7T/hwn+9Yk+KgVUHuH14PhsFubp6A?=
 =?us-ascii?Q?2Ao5LkMd859VJtoVMZB9E1AUJ4dkVvZzMbDs0ef4ejengVIotE3yzL4h2AKj?=
 =?us-ascii?Q?O6rKfkxTMhfEsUWXkS2GULEOhYWzVy+bHyhWqlCG63We1M1iGdN7svfRXXc0?=
 =?us-ascii?Q?vYNUMg5w52iL9xrRDsg9HJ+NOo4vUTtF404gWBx5GkWvdaATjuF8OxlIn81v?=
 =?us-ascii?Q?TY4oMdECbdKo7uML8EYUbBs2N2fW08cepKp0I2AuzRYByGdmPfouPJeQ6DEz?=
 =?us-ascii?Q?9H1/Tlb17dXvwbFwJ1Zw33sJl7GdoU57IV/DgVAYJJaH+0nZna8kzfrKvRtr?=
 =?us-ascii?Q?PD2k+bQeCLCPQt1bmEyewWP5VGhPPE1qScLFFZQ+R3xb9GwljWx8zyI0ajQN?=
 =?us-ascii?Q?LCPeJQI1o60SIyuF+DwDQRnwsTEfFKX6GVxruAuxavVy8Ru2q2BvDZ+HCx6z?=
 =?us-ascii?Q?6plAajupmBDLaOsskzD+yzuIQd0fQdIRvknLhApFzObnbbqCOcf8HtbRzrZ4?=
 =?us-ascii?Q?PCxU6DGF8fqNuVV1RdqRy621Sirc6NBe1J5vyGOfpvuaQn4TVBsHd55gBJ8K?=
 =?us-ascii?Q?dNG2H0jyQyPZx/oonc3/+gUxftWsZWDdj4VrPeOQtUSJ+U+WZJS7SpWPXSje?=
 =?us-ascii?Q?HDTBw3FH7sVkTCl2WYXnEvvAbWungdZ/VrK4K8LSxhgqFS5MS9Cot53MKUwG?=
 =?us-ascii?Q?+LPGPzyl2GaAEjBS0Duz1bvqo1EIUEqULqqBklL5mrnzivdcelk6RfXaCtrp?=
 =?us-ascii?Q?NUu5Ctk9FMA1hRvC4aW0f/JiOOSiTzkqu2+oYkvEWDZWml/4ScsTd3cimxxb?=
 =?us-ascii?Q?4ryg3MSJnPTk3ByVvR6lE51XQfwYJeCtNsFQyXOISxaHSbJFmOLEnhSoLyk1?=
 =?us-ascii?Q?JQ2wC5TyvC0eK6WXBDrAkYVjpozs+S8DDG+9Jp4E7TQu5MS5BjWtgloWtV06?=
 =?us-ascii?Q?C+W/w3FIj8cXUqpXLWsfr12S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5907af75-c99f-4088-1ee8-08d8e7cb8db5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:01:11.7308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfIwMmfKDnPskjGZzDbdwhfF4Av8b4Uw4E7Og4uxiC5M4CrqeqHceHwL+ktJ3zlvvUnDbM5mj4YVGqEGo/P86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With arg 1 BACO reset, it will try to reload the SMU FW after reset.
This might failed if driver already in a pending reset status during probe period.
Arg 0 reset will bring  asic back to a clean state and driver will re-init
everythign including SMU FW

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I6df90d963e259dcf1df8fe3716cdf52681202162
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 635bd5da2133..0d137af1a78a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1530,7 +1530,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 								      NULL);
 			break;
 		default:
-			if (!ras || !ras->supported) {
+			if (!ras || !ras->supported || adev->gmc.xgmi.pending_reset) {
 				if (adev->asic_type == CHIP_ARCTURUS) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
 					data |= 0x80000000;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
