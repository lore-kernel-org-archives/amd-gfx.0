Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF71C3F68F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246F72080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nmZaxqb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246F72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1176EA33;
	Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6306EA2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEryl596QaAxx1JMskrwGtMY3Wg3RlaTkiG+jCXrxkivAgxJgSfp1gehprirjalMwGa0ZpwfaIXVq4dw9/x9fp/E9WxPbqXo1VNUgPWwiub/btWXgZYcqMwq4cfbe6V0OhH5pCrW5rSNVAkaF2kGFM4C28uprEwkR+yS4UCEzssz5S5eN5nlFW2t0Pg5Hg7NAYAo5cP+8zW5ng8MzMeRydnmaWfJbUDFd2Z38sAXJLPaZB+lrKPb0H5RGb18jscnN6HFngINBx3Pl7Dhvq36fzOoEKyZuIwv2jWLZrzrr5P4qbawrdFWV1y+6bva57nX4cwdQq4KCOxztF7ySA/HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We0hlhP5YaUkYoV9+Rlg5PenvTg1XofHywLVfZzAEQU=;
 b=GNop9zYDV0wjOKMA8qVLUiFmygl9Hl2oNBXfK5aYC47N1Wy8K1xkI56gvZQocKy+mJfL1iWkDO2HvsKpW0GtLl0r9oH8oG/gK7STCRq+RPyCnGg6CWkMxo+twyhsdZEeuAiA6dvlYJZBr73tp1wLZwZM70Yt36vjmEhKDlZpkVgP+zBgO+0dYMlj2Q6ncm9JU2+Lot8q+cwJodpuVdIr14usj/5OGR/le4wtti4gikjCwhdPGH6QuDjeEeCSiObVUXYO4KC0Y4FZ/xD3DqPM3owNxL+2ea+2ixTOnlQO/vFwkNfqo83+ygUJI9u43UDOcYBydF0GqwQLuaquM9NsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We0hlhP5YaUkYoV9+Rlg5PenvTg1XofHywLVfZzAEQU=;
 b=nmZaxqb5HE2ltdYpd4M9kqTJMvh3hfVA7V7TgqR8lz161zcDIkrNos65lW0kBc+NM0T042yHmsJgPvZCS1LSiSpoDFYJ6Kgof3dMFQDitbD+wQxsXanuKjYztJFmjU5m2xiovO5AcnQMNEk5MFNQOTvQZQlacnKMHtKiiT9lD/U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:19 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/43] drm/amd/display: 3.2.67
Date: Fri, 10 Jan 2020 09:46:45 -0500
Message-Id: <20200110144655.55845-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:49 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ecccef6-408c-4fa9-25aa-08d795dc1093
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378719D27D1FFA3F631AFFE98380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(4744005)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAdhJUB6EJ1adzUeIJOZWdec1vwhqxSni3uADPNgOPod+5ELlgW31luh3JLBy5/EmG/Uid5sgYCIESQ85YQviRxH8VFOOT/NLt7RNGVR/nUJKwJyUb0uTSDuX117JpPKmV0nZUWGEmhh4sr1W63kV9zwdeuozkEzF/D57G/8KviL7YGZlzEgZISP3e5GScchdIUpPOS8WJfxCeJ3tcN2xzQhdUYywPQw1Gd9T9TNL1fgdjoocDFkWg8HEgHNL3zhHJuGezsTMyGI0sK9O+zHVER6IlDU4/oRAHVZI5OdHY2MWmHQoEtMWUUEW0l2cOj5w6w1IxpxIY9apJE9WEFurEZLyvAFt/popOhMvLajk0Zrk06Dve0LTSbgEOnsUUvB/L0ctjIm2Hko27j88N7jWWOV1toXfnHxi/z1Rfln+ZEPQzr4MtHcBLgo8KJV6wzZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecccef6-408c-4fa9-25aa-08d795dc1093
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:50.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJEdZ7wmYZvtvIIbNjBN484JYBAdb7r2skMUdAJDMJr3/ARZfZgTfSWd/eQNuXkovc9qsADhwGeplovQM0OtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8c7ff9e322f1..e1c11af2bcaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.66"
+#define DC_VER "3.2.67"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
