Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F8C433E5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF95E206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NFzf9qYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF95E206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67846ED1D;
	Fri, 15 May 2020 18:13:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2486ED1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lul8mflGmg1zsyqbdt87fKp7IEZ35LUWfizpj+TBjp89sMdhbeb1XY9YhqkXV/VtUQbNw8OE36N2P7lAr7LaiYqHpxzn0NlFwewPAfkteSr+RNCFulaUNQRyBYmvY7BiX4a72PL2hVe+pQ23iENCoErXgLHsj7Iusd+jmiLDSR+4LKLOLy/W4v2fsX+5lna78h3a+0sWfTCkIb48UsqubaURCBFFym+zXixtv37YaQ8UcuAw6+VQH507dpHbHE1dF9JB4lom89/4HXYun19Tt8nLCgO/hcpmwjRG62LpoIcIl513IyHIQTEtIz8u0TaHsrjuqOEYu/1kZeC8tUiewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADh4ua0eIhmkgnuhjmP1I3vNwqXzq00++2mFpF+oq80=;
 b=SwW0K5POMYAwiQhDchWZq/7QB5zpEBvEhp+23YD7KdDGSxiDchqD0rkaHw04MOoqUY2QVuu5xWSwfqHmfxAvavMbmmnBzDKzqTb3JAv/22qxW4HjlcIZBr6eU2Urn2BkOOsIEJA9/l6oFcWRSD6UmLoHe9g2dFaSggJCHGbq0/3qyeE5xw/JGNhNLNTbMevq2+nyafvftDvndHdU4+MVtvOClHZ+qJ/LwfhksNe1whqgbzpE3iwb3QW0ELMWrt3CRMYCYb9djymF898njH3BM6RM5nZasxNHyOsgiHsnbArUfuSzc/quqYppbICbDPyECFDf6//fE6Kj3C3bJyr7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADh4ua0eIhmkgnuhjmP1I3vNwqXzq00++2mFpF+oq80=;
 b=NFzf9qYr4bOsNib8zujoa8hrWICt0xOMAWeZHFeBRpwPKlana8UQfv0r5f2Guqbgt+RO8s0vXEvoFMz+vIuTgBeMwSQblrnIzocU/smN4edXrtlbY2IaSD2EzSXfvf25h7vUYHdAzMl3oWzaHL2vaHZuBAOGR9EkIdumDVzYjFE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:49 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/27] drm/amd/display: 3.2.85
Date: Fri, 15 May 2020 14:12:59 -0400
Message-Id: <20200515181315.1237251-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:48 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57f221b1-2a08-4722-398c-08d7f8fbb749
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848C798A03A73FC4B4DB39098BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI4Syys/l+sOvppwZvr91AZTclah5EA4mHcoq9xwYRCZ+DVFs1LOe4AuZ1pHDWpP/SIExfx6PYF/bVc2Bgv1GH7VTe2QIDGqG9gUjl0cytjoYNA31KJK1pxoO0N7y90AL4MFuMOYVkfDjGf8eHaH28WY8TLN+DWyYw3K0VWq4+VRhTrwd3QKk9yshEx+bZ3I1HvcsB/oXyRpMJw+pBeMxLS6odNO8+PgXOrXaStEwL1L99adCDr8UjKaP7r0e9orA4iGsJmILC/ijnGfeGlPP/IvG9xfgdRk2ZdWUCey8455UXxuvwm0Cj/3QscFZ5iaiBCVUH6kTdJsIRDHACxeC3pNywvpXZCav3Ig8MrRd3oNh9K1LApQuRdgScANLlXXZ9DMtmHorgmrlnVdMSHxMFVTZkCjxvbCyCuPFo7fUu8F2kNu6nmGpVME3Pf4qg2A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(4744005)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HlGVb/+vd4Z4S3UzZVCpuwbVBRS+PNqRoblhhYVdpv/Ub8HWV3t44dGUJhHfUfiq1J7Xi5b65RQooJ8WfHjpYXumOCjBPauod7rqWvevkOVQdxQWEWAiCDDYVVW4d+A1kBgSiRJhzl7ffJyXrH8OJHrh3RHCWUY1xZKA18DXS2wPihI/8FNq9Nh375J+inxy2REIJ5noQ4dkr7RiQjM3dk19bz4RJlPoPTBdheuQ6Wyqu1us99EIW4yp/9rE4WBGDTpyBOH7Co5fBUDJ4I29VoBQxx7FsLiyJlPD7aZLQAjivxv0RzJ+af7FjxvGTJqm1CJ3+FLBoO6PEXkx5RT14AU6WmEhmScnF8gBAYzJ+a/0sR3AQX2unkACKeMvVDtnul5wB/NVCg6anQOGyCGVvV2fz8nfK/tW/CK55LapO0EXNwrPZNPAaymQrEgSWvdSXOFAtoR342Va9rbqVJ3ZB9mJ2w4n0T6byD0IGdy4P+cIlr74L+isRD0GqVBq0liG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f221b1-2a08-4722-398c-08d7f8fbb749
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:49.4018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3qHsF1N9Jg9mIbrW9C8ee++WyrxZU5Tf2hr10aaTmzutHjplOuf3ygsoV4tXNtfwViHG8BCAnefomH2nH5UqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 85908561c741..a4b30233aee3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.84"
+#define DC_VER "3.2.85"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
