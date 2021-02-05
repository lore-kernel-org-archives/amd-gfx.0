Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1B1C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A9C64F97
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A9C64F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D4D6F4FF;
	Fri,  5 Feb 2021 22:03:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB15B6F4FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiRApRAl+zDjDz3FVZC9AOsvZqBjiZ2/z8T9MvBHLI+Ck9IrYffG9vsTWxXqjWQknU/U6GAw+QVu8ij4qc4aFOXC1SsFVGiKLGXHW6ufGtN7DLbxIoxH4gAd4pcbWgQDRO3oZEBYcUlP5p+FmauHwo0P+JQ4QiHgkwGE5uVPO94RLj2rgbMtgWTx7XQhW+d7u0IzU5wPfwOdt8xyYVkddCdRdadw8t6hOVTTHMBOauMeioNRZRFgpb5yYauFe5uRJO8nm6VkQ2HdrPdko8AJhB1FjjNDn6CfvX0L5xKMPIQsBREsBOv5ICmvMtZ3XzTxqz3Y4UuAGyM89Q+KXz8ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSyzG6JkNwnJjTxjFH7TMYDcOgUZoWXDljdNATEjgxg=;
 b=Hx8mqPksLSwRK8IUZTEfNtE2V8LgDBqbAiK5caQTEd5yEUXcE45uVLBUyHQQ/Yvsy5jCGvVzuFj3h4Rq5yF7hSTKKodMihzS6AMxmfmc9pr30M5UpxWTfrkkC5yWJi2yWof387oe49i/q0h54fZALgMntkFiurb4YC8LKX++jUGNZSCC0Lp3nz7CeqC3Y+kp8boEkV2toAABzv4RqbJCWtx44GzKT1TOUuPVy73ycthurlCj4NCI3JTEG8G9vEy14pmC/SK5z0SqUOtEZRaorn+eGTqh3dNy3kHbltCqxnwgcNHE2C3gSu417Fj+NJUvTR1yA3atIBrnTVJo3ldlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSyzG6JkNwnJjTxjFH7TMYDcOgUZoWXDljdNATEjgxg=;
 b=kbpsq7Vkv1yDIbsZMzij2tATzcXQRxOv5m45OXY3/5iTG5tsgqYhkk5hOczkA7kQSFKun0tbgNvq1007EqcN/Acr3CkilQdScDe4/jDCNgkOLaIg8afVM6YeSNEv5cai2CinQfJ0Oi3j5MxTT7QGkQKAF02BwKnj372/iwymCqE=
Received: from MWHPR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:301:15::17) by CY4PR12MB1205.namprd12.prod.outlook.com
 (2603:10b6:903:38::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Fri, 5 Feb
 2021 22:03:11 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::2c) by MWHPR2001CA0007.outlook.office365.com
 (2603:10b6:301:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:09 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:08 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:02 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: DP HDCP Compliance 1A-08/09 tests fail
Date: Fri, 5 Feb 2021 17:02:42 -0500
Message-ID: <20210205220250.1871069-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c31087e-2029-4107-757a-08d8ca21d334
X-MS-TrafficTypeDiagnostic: CY4PR12MB1205:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12052B4C658E9BF7D0893080EBB29@CY4PR12MB1205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXMfHfaBSSaP2/SrGcBIBj3eRAvJvDF0s+Ui/HnVn2e2NqN+hBv6+4M/IC7T8vN+sLdjs0QDMpPqdQO/zuQWUXt1EhLOFW35euXzwLo/DNItnTbxD1yjRLqarcWnqTXfbh0okx5PA9yXdS6VyNW7/ie0tA/jgWNe+QJ6nXRcUS2FIwHw8nV79HAgg5ifPoCPoBgaCcmKHE/U3gCTDyTanVVxsSf5VTavGEP5ZvrdX+NkN5gpOb2falJie91UggKjlcXnYmdbwezXNzP0cHgkuWaqxbbiDUhzcu3IZcDWNSflbULuWY9Nz4jIik8oHCdw6jR9SEA1DbV3WUdHa8ABKUQ9VnJ43PR1bRRB6qMUnIHHhjcmNdKBZEcjyfXDjzKvw6+enTR+3WY2u4yBMl7slPfk0yBBKBgPj3vWllTwFpjmvJF22s3cdqQchi2166W+cnfcp3QLIoAKk86x9FWCdPBf6z90ykfL5y4UnCVQLqKrip2W/nzOZ9NuZnoGzfZZOWMcOQpGfO4tEdYwLfwV11AFTy3pH7WzUFbf+QJTWBSyezHFI8EAmlkk0Hs1CqCt8kqcMrqf6IfvwAZyZZOT6Cu/DkL0rzTshYficegi9eHOiuRY4kp6XsgOWdcpzXaHrAqBjV7yFDjfnjnkGhPZ6yposdeH6uJJyQ2JbD6e94uDcNoylu3V6LoZI7Mi+aP0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(8936002)(2906002)(7696005)(6916009)(426003)(186003)(83380400001)(70206006)(36756003)(6666004)(316002)(478600001)(1076003)(4326008)(86362001)(82740400003)(8676002)(2616005)(70586007)(5660300002)(47076005)(356005)(54906003)(26005)(82310400003)(336012)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:09.7458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c31087e-2029-4107-757a-08d8ca21d334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1205
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
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Current implementation of mod_hdcp_hdcp2_validate_ake_cert()
does not process HDCP status message
TA_HDCP2_MSG_AUTHENTICATION_STATUS__SIGNATURE_CERTIFICAT_ERROR.
As a result, when there is a signature certificate error,
mod_hdcp_hdcp2_validate_ake_cert would return the default status,
which is success.

[How]
For all messages other than TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS
and TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED, return status
as failure.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index b26ed64eaf98..904ce9b88088 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -548,6 +548,8 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp *hdcp)
 			   TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
 			hdcp->connection.is_hdcp2_revoked = 1;
 			status = MOD_HDCP_STATUS_HDCP2_AKE_CERT_REVOKED;
+		}  else {
+			status = MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
 		}
 	}
 	mutex_unlock(&psp->hdcp_context.mutex);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
