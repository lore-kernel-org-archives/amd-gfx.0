Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B854C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA4522265
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QZv3pex1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA4522265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064CC6EB44;
	Tue, 27 Oct 2020 09:42:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84AA26EB43
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ3z4SWi8A446xK39tatYnDAVCwAT9XKa02y7WW2LJ/Ab05Sknu1nNlP8SuAuCeF2sjkAtyWa5bBo+KXCGTz694Msss2wHfhDkSCQAw/Q3t03pK5pOvcfOavCn5K9NZbqhE4vWbxT/VioY8EHUrdQVY8RM1pT3n5TFRj/zKmjyPHc9/DAoDU4FJ2MC2zdcXXWLPTwIgNQhF5N7JJB7RTDAzWKAFCFXlXsPomflNloh+h4uPYRhjIGZert05Ne3ZpRIpsd8qfEDTObK+aoaaenMh+MAW20FH2ECvM4on5oBGA9eiT3OxS7hf9xDvg7qkDZsjO9e8NAmniwHXlIp0CKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6wdH14I8Oo8+k9vmHgHR7kqR0M9J9H7crhnhj7X3UY=;
 b=AGJJ3KKg2Tz1umwTDfJXuO+cUehHjpN8jEK01qOy9SHB5NDgo3wvBVH3MMFtiaHpeqCtjg5zmjvDt6K+oTpCCswdRP/z0D42g2abG2iUQb+ReRvTjhE6Hb5j/5WfKsZWQHlVWDgdMhyxiwo5eTo6iAnK/dTmwX2LF9pLIuTcOa4xlV4MaotBHYQA52J6bq5MElO7jQ1ynrz1+do/SDVOQnf16wZGJ4SNA7KhSXvc8wDrN+sq/vbs2nD+BETj/lzcgYNTsVz8qP75XsN9q4wmKDhnY5E5xqOYNsST2rTHhvrq4W6lcljlGa8MavzUuppvzHxOdrVyT9KOuwG8OSLnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6wdH14I8Oo8+k9vmHgHR7kqR0M9J9H7crhnhj7X3UY=;
 b=QZv3pex129e3RjLSt4A9JmWPfWBECAxZh4KEV76s70Qct3+HbMc8jnjjupepXdsUoSEv4AAdR3cTROBXtRGbv1uyMRCMX4rshpJVaAfbfilNq1KR3qQ6KzxsB5OzeCUa+EkKwQcghT9gAk4O6QJmRRpe7NNM7313qcBjbK6mBOQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:15 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:15 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 06/10] drm/amd/pm: set the initial value of pm info to zero
Date: Tue, 27 Oct 2020 17:41:29 +0800
Message-Id: <20201027094133.21881-6-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:42:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f53b4786-2c0f-46c6-138c-08d87a5c9671
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845368584AD9BF02CE97950F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wT3ihLzFMpoDuMb6ec0i7AI3uVKprb95ndmzjtoJ5kyGJgB73WIDnIUvndvrTDkjyByvlnB6hiuNbNTKrGZFPmKFlVj7mAxYzZSzIDiCDLpCYuDo6PpTnj3zcAtSTXK6KYmXC4xQQBb3LolGG3qq48nU3w+7/oxxeb4WiY3q7Be0m4IlqmkGdISSlMI+pe+J19C6FkbWNndCzmUrXrahcIWer61AVG/qDW2sUh+qZfqxng0MCBawhgdYyie8wY3O2L3ZUSS6Gg3KiK8Eqb/s1Ghhc/k2cClOSYsvWUFjRNfJJAJ7jB1o1ZTPEx3A8QMWVQPOkBIUUkKNE/V1qzxNCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mTZUOp+0HuHR84ofNsvtd0BkTWcox1WkKbJThlicm8dmbDNecawxIwlzAmDk7VmpSpRYzUwPx2wBekoU3TMExVtIPIE3oDnVvaUsTzf2t8RVWrgtbx1zFXa0g1KpfFSUGGt1F8A4F2cGRgJ6gu/yAjVTsdNHG15XQC1HO0uThFAlR40O25pv3hRcDMo5UjOEiAIkayLWzVZUKESbLLdbFaHPLCTxBUcrsLnF2AKt6+Z37jfCIkrYxpPabEUiP2uld/LM9OVL7nnuIIUYjNC/DKXOB1ayDIliOIv4JNoUHnuCK0YQWwlLynxpRQk0J0g3SULVzjtZMHdeIEgZEtaqTkjKU35CrI6WhHpvM3KvU765nZbn3d3H2iWkr1CIkxQMzeUMKoiYZMp/ijNbT/PP8VJjzr7xgeeVWYd7LexraRg/+5bAI/CiWwb5VsnvGBuSyd4Xl1Eqovi4NvRO7EsWPXmLkFrxIrQvfo01tXBHZqhlenoO8XLsHFSmaoGX2MGnv3xYoJuipDzKYZGeLVOYm8oD83Pc7QVAPYlgAYLUokjYGVCFqZerqpY94gyavQ5WWnFPH5ln0LT/eX8dMwUSa2x5BSelDKbdJYyABzgUQwkmw55IFZMCMiuo5Fna8A04UWz9vb/ZsomBbPhLjepgNA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53b4786-2c0f-46c6-138c-08d87a5c9671
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:15.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrcclJIsm1umoJT0ntb1nPfRq1tshlMh5nQIdPV5BflUvctmYYeGI/gQlkShbhEC4/IOqfcjoJD0GAIBKRCUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to set the initial value of pm info to zero.
The "value64" is ported to the hwmon and debugfs node, it is a uint64 type.
When it is used for NV10/VEGA10/VEGA20, its word size is appropriate,
because NV10/VEGA10/VEGA20 has a 64bit smu feature mask, which is separated to high 32bit and low 32bit.
But some asic has only 32bit smu feature mask,and this 32bit mask will fill the low 32bit of "value64".
So if this "value64" is not initialized to zero, the high 32bit will be
filled by a meaningless value, when the whole "value64" is ported to the
"SMC Feature Mask" in the "amdgpu_pm_info" on some specific asic, it
will be a wrong value.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 89632ee88ae2..080af05724ed 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3464,7 +3464,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *adev)
 {
 	uint32_t value;
-	uint64_t value64;
+	uint64_t value64 = 0;
 	uint32_t query = 0;
 	int size;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
