Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99384C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B06610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B06610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3BA6EC3E;
	Tue,  8 Jun 2021 21:40:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB1A6EC3E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxgIp/iV1Ox0rcrT3iVjN4UCSiOlyoLzaeDI2LcF8q26oiN8WbTty4iY77z4PZYIYxZFLwz7DNH/2zlBxdFLi1Tm/ZfPx05zYGYkr4OGgfl8mk6MY5+Rr4aNA4w0KO7dDQRnMkgwOnT/ECyr6xhw2CTdhZNXAIYan44B/s2vb7bM0ZmqpRHEjbwHPIFSKSwsxJqViPQ/NuWnGe3xiHzWWvpphgcocJi8vgUwwvifMMFudX72lm5tI/q+OZJjmcDHIwtBH4q0YWZvaXJNxVAji+Bf8vB79ppGe/A6Vj2in2DBu0tzn3Zz+B92nXiRRgJA23xQZY222jjLho7YapKmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTD8318Vf9mpXxChJteOMq/4vLDUqpx47mkNHnd597g=;
 b=He9LABtC7axKBeGTPNxKPeVyZH+eZmtDrIsf3O4fQy+BDUQ/hYI9zvmLjKYhwAuBO6GHBqVHHFQ0hbUy4uuSl1pKYrJSaKAmdItIko/JofcpYN/p45iBM0S+4udxVpKY9Dr3Jv8aYV3Vr52ytH2/qV9Cg2uygckhZcTt0pyg1E/5TniTepvA37XRcaSNs+UbxPlFTfbnZ4igm8H33hgOp2+uj2Mu0Hmo3Lcd3FrAL0wzxnuV5dfx8rzGyDdQD9iCqVwK8LUpF0INZz66Fllkax7Xkq1y99bAgMUjP0HM5I/D93t5nFnbcyaiorwofRN0TjK0GOF7lU/Xf64vxmXWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTD8318Vf9mpXxChJteOMq/4vLDUqpx47mkNHnd597g=;
 b=sYng4h9s35D6W8X3jr/MW8FTgHfaX9ZA0g4boHYpqGVVY9HvABQNL61eQIZxba+EWF4jjrYFyBLtmnpx7/+bs5im7Ql4WkIARJfV2riOfjWMdcmZbRSUY6s5HW5hBhkWMNHCNfAOEvvJDgZVxTY6oCfAh5BrUE7TtghzmA3Rk+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:24 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:24 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/40] drm/amdgpu: Send STOP for the last byte of msg only
Date: Tue,  8 Jun 2021 17:39:29 -0400
Message-Id: <20210608213954.5517-16-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4b5229-507f-4863-b9c3-08d92ac6060f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44350EC9689AE6C906BD435999379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9fTYucOp/wCWRPt6rsePl74QRjmcJX+6nygWuJ9Hoy6tzJY3Z5p/pPFMfUZneg/zK40re0Wk8/o8fy4A6uK2wBQ76BOfnK8YCwHOtBMPN7FE3qGNbUuBbuNJ+r1hPg9yhZ4BzXVyrL1c/GX3eVWf2mu3oxDU3bnPBz/RfLMKtQL/9kIQ4cV8+TW0qxRofOgDhPih8wWR60z0vHXG1W603wqsSrkkI570w6DaHSGgjedukckdo+oQ2aSQQZJ3HhSLDfDc23rYaa4tHMAOsDdeFX0b+JHf1/gt1zu9zf9eeTjSZUkp8VVbG8jrVa3YZUVUjzOe2VklUDNj3yLPW4v6NUqp5YCLmOYlW/WgiUcq7RoP34WEtltZb8Y0CX49amAgPcJsZLyRZ/tLkXKJHOZQmgoie17dXFFJFb1w2DVkXnZrNrlx6RjwQakvybCftQUBwKZ95fgABDEUG6VEyTcIDYKaTQlfic+da/NKBdAKl80TUDih6mOL3H4OV0DU349YKif0npuFSXIgTRZlt+M+ax/22HCQzQ+ZRMNDbNGBX9cYlkbAWAWqpFEZaEdhZsM9h6BM62dtCeVjnvhaLGB3/P4g+yvc+WBfPBxtTop6ImjAuV7iuayvWztGJYEH036w0+ZvLlBJG0kMWL3+zSrEfbyarpMlFNSA5zo3V3crjOJhCRlFqmuCW3KXLtYJ4Ln
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDafLhTciC1iBZq9qkuRRP/7qRN8p6jssEgJ8tlyftea/k2/dvYayWsHL2o/?=
 =?us-ascii?Q?QPclIoY0IoshsRNG9PaiadZW3oX4lYU6+f0N+4x1eapYUAUgmqPRASnfMgbt?=
 =?us-ascii?Q?CTXywy8ROJf9DV5i5n9WvTh1PSaDvh0Oe6CtMlUQU3/b1jKzmpYiMYM3BlT6?=
 =?us-ascii?Q?F+vrWMsR0IUIoVgmYTYnUbD3G0AhQ5mwRzsG1gfkvai4FCROxIyw+vG0ha7k?=
 =?us-ascii?Q?PY/Cy/WuwbrGBhR/LufuFAg+NRd4Gd11FhG8P26zsklnOb0CgThdtFb96vQx?=
 =?us-ascii?Q?yF6L7GSr5eQK/9I0pxsEihfpFpgN5Kzh9rsFm1E/aoXVkzWHgtp5TlFrcuSj?=
 =?us-ascii?Q?E8jvbb6L5Mq9YqtNYzmPN++fhbu+ympCPJs6sYEI/v9feagoWViFdjpcvFYt?=
 =?us-ascii?Q?Uq2C9Ufpxz6zpTrHi0lbEw7O+UqywtNxVttAiZXvgTd+i8+10d3PjRYW+S8B?=
 =?us-ascii?Q?UVc3IBeMVDoTnhKE4rUUBtJVJsiuYGNw2/mckvT4VXyUDYOBnY8s32iF9DjY?=
 =?us-ascii?Q?eldTlUP63VwG5/sO1MHHvRw6oGQedwOfLYE66CE2GfekjcVNPT5HzOGBTUDA?=
 =?us-ascii?Q?qTlDnRO7h3uV+IcUX0nJp726p1qLO+FyoMmdq8xObW+Pp4PYjh8GYGfwcwzd?=
 =?us-ascii?Q?T1cfIthowUa/MgqWQREfHkow+r9ngxN0Z4qPvF6BJ6xW375ydNaAKh+b57Kn?=
 =?us-ascii?Q?t3VAuXgw9Mfvn/93jZn5LSo9Mdu4PFwOhOSVLOxajWWHHTy11X8YyBucaNeR?=
 =?us-ascii?Q?WEBkgUb8VCkh+Td0yxwiogB+3jNINeWyjYmNsrrgm6YQRbEA7uC+vaoKSkuA?=
 =?us-ascii?Q?z0x5m80NAilUwgBdPJwVogHK4qr6qytfYB5TZHzDgoT2DBqrvw0iZ0TIMmd3?=
 =?us-ascii?Q?f6g3cfOMj9n9Kwfd/+A7KAInoeDVnvI6FCyhOE3Bcs93cqsEUoUQS+uFD5oo?=
 =?us-ascii?Q?PxZvGstS8wQqFtM5lSHVAvKlkEiXlLHw4JhBsLdCJ8d61UIKaGi49JB+wCdP?=
 =?us-ascii?Q?HHhB6uNfZ4+6/VGlqQvpk91/X1yPxtzdWWD4oV/z05I4iuQxQURVwofHxVPZ?=
 =?us-ascii?Q?516lUQJhw7e3Im2rSjspuvMqUxRCySC3BBzFuTo3RLQygcQgOcFVZqhv6ZMv?=
 =?us-ascii?Q?qKeeZ0QT+UYUsGoz361bDQPd7QwPXjehVd7RjSx17tzACIp3QJN3crwPxPJx?=
 =?us-ascii?Q?Y8oW2VGRrn0xaVkfVpsLU0ZshGWdGK8Y+cWgFKEnTq1/CqbfjLyNOQCbF+LJ?=
 =?us-ascii?Q?Ed3Qb0OFfdVdUPUNn+AEV5wzH6My13MQmpQGUSryAtLED2SeyUDqmtxmD0cl?=
 =?us-ascii?Q?wnpTi5ZJ8Nr76MQbQbWtl0zY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4b5229-507f-4863-b9c3-08d92ac6060f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:24.4640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9goR4LrVDIrb+fDDOd9AMaM2sJWMMNNS01t1WjchaGrbn/FhnrTp2Mv8fknqoaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Let's just ignore the I2C_M_STOP hint from upper
layer for SMU I2C code as there is no clean
mapping between single per I2C message STOP flag
at the kernel I2C layer and the SMU, per each byte
STOP flag. We will just by default set it at the
end of the SMU I2C message.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 72b02025b07e06..235e83e9f0feb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1951,9 +1951,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cmd->CmdConfig |= I2C_CMD_WRITE;
 				cmd->RegisterAddr = msg->buf[j];
 			}
-			if ((msg[i].flags & I2C_M_STOP) ||
-			    (!remaining_bytes))
+			if (!remaining_bytes)
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 289d09a5d711b9..b94c5a1d3eb756 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2746,9 +2746,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cmd->CmdConfig |= I2C_CMD_WRITE;
 				cmd->RegisterAddr = msg->buf[j];
 			}
-			if ((msg[i].flags & I2C_M_STOP) ||
-			    (!remaining_bytes))
+			if (!remaining_bytes)
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e8e57462ce9d64..2fa667a86c1a54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3434,9 +3434,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
 				cmd->ReadWriteData = msg->buf[j];
 			}
-			if ((msg[i].flags & I2C_M_STOP) ||
-			    (!remaining_bytes))
+			if (!remaining_bytes)
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
