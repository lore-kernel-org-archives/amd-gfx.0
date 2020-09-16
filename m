Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDECC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFFC208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yTDwFl8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFFC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B676EAE3;
	Wed, 16 Sep 2020 19:42:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846B16EADE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuansHBbFRNyTX9TgjYZjxdgUGVcqGyGZlgHs879L4KlrEewWF3WNry+v+SF73kSvyjq1YO5QsYNYT3qr+vjNcTPw0dZh6kHQP/xXIFvdojKf2Nmrh4Rf/6QPqzxiXKqQEdVkDFJMfKe1CPVplmTIXECT7ji7NRF1oqhwEPcDLzpc53dVEtGOPuKf6qQc7R7Nm0zW9+h10K3tJdzqh4lOzswrgexYFhsmmqAtUK06T8hjQWeZ73iy8pi15O13sqVdNVwbR8mdlksNun39kWML0sJFvTZVBzeozvAZPALAxS0LyB3v7QLXE8Wn9qMIH7dA8YhMchUbeVy1YDi7EygWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e70dvBwLCqXBJ04cOKPCj86OuC6sKXgti5XdlJdZT3s=;
 b=J1mEj8SjpHu4nXjmURBjnkncTiKGhkF54NmzrGbSKlqfgG8UM34g5k5rmKd0h4ddrpV9E4Ro36sShARrC1HJJQmUW3CjkOycboTCHGArLfT34KWwLID2MpAFCKhwKono3UGrD+IOhlfvSCVTZ7nPdMfj+dIpwexi4OfzGhPZH9NeCJPLajent1OB30DlvxbR0rMvzw9wmIjZX6EL9f34C8FWy0+dIjvWIZXq3LdEciGjXwfth8U/lvCgbVQAPDOyu0VIwA6UX3Zd6j3N9TCW8BbPzsU6kTdL6eKP77OKjTsU8AdOX+VpzEiAcDCEIP+1bktFGkmAwywmlgHVoXZTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e70dvBwLCqXBJ04cOKPCj86OuC6sKXgti5XdlJdZT3s=;
 b=yTDwFl8G09WCpEdeDCz98+HneZ/IB15wJ603jMqF9i+ThmKv+wW6qYdTOv2kci2vK2ZFglzt7lr4T67q02J/pVfCY2JtLekGeNQ0xO8cu6wXz2kQ6TTpdA2Gt41u7tGsqnYgK1NaYmEFL5kNszKJ+lXwws+XyOe5yxBy7lRXpSE=
Received: from BN6PR03CA0117.namprd03.prod.outlook.com (2603:10b6:404:10::31)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 19:36:39 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10:cafe::43) by BN6PR03CA0117.outlook.office365.com
 (2603:10b6:404:10::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:38 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:38 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while read
 edid return defer.
Date: Wed, 16 Sep 2020 15:36:24 -0400
Message-ID: <20200916193635.5169-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79f32d04-e24e-4432-a3ed-08d85a77d4f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38958D09741EE8A65E3C5536FB210@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbEUksxbhPaQDOP3u/oa8x/uJSNOpqdvlvcxayD4+zbwZk7z4BCflfLg7si/CiDxK+exHwZKZ89h5lsGOojaE9J0LX/PztWXBEMN8yOuqytqDX8jjkv4KIjosOdPp4R2hCNuIh029/iFW82iZeH3OgD7i1Gbo/mQLu60jmplR69FsropRvVQ+vIEcAp5DuP1VIxrrffG/JDwiKVxeuGN7Pwoy9d9HPq1d7nDi9EK6H/yv8VShqIczBRymZ1qZHxqc+PRC+3mVQ1xgxeYN1MhRYHS+1bKumUoHEQwbjUBQtWXEletGXVHwhMksZwOm6bIwC/9kcYKpHieLvhik3UvUZ1uoR7+tVd3rmLeOKaBR/76J3vkH1GheQVGmukDXHV4xYpoy0VKdYlNTlw0HidUdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(46966005)(54906003)(426003)(44832011)(47076004)(186003)(4326008)(70206006)(2616005)(316002)(70586007)(86362001)(8936002)(1076003)(478600001)(6916009)(336012)(8676002)(36756003)(5660300002)(83380400001)(82310400003)(356005)(2906002)(82740400003)(6666004)(26005)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:39.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f32d04-e24e-4432-a3ed-08d85a77d4f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 jinlong zhang <jinlong.zhang@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jinlong zhang <jinlong.zhang@amd.com>

[why]
while read edid return defer, then it enter to msleep,
but it actually took more time during msleep,
this will cause remaining edid read fail.

[how]
Replacing msleep with udelay, it will not take any extra time, edid return pass finally.

Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 743042d5905a..cdcad82765e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 					if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
 						(*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
 						if (payload->defer_delay > 0)
-							msleep(payload->defer_delay);
+							udelay(payload->defer_delay * 1000);
 					}
 				}
 				break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
