Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF94C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9FB20708
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IQVVtAXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9FB20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0866EB4B;
	Tue, 27 Oct 2020 09:42:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCE06EB4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRfa3wAq+4CM34w6frszEavSs3lkwxq1Ly3nDvQWD0IShQcAYJkEzzF1/m48rveQ6du9/HScz2ErR5/Cv/yvGUkpLYlrpgqq27iVhT8ojQvh20NC07aJlqCIO3eFUWSlWuLxCQKemGyQyWZvgJaTzPTFTqA7OMtoRYxrOFx+oFItOjaqoVo8JfzptV2tjhE7FFCWXntbQZRSY8Bo8rtraqEX3L8qM8uVpHkAh3RozdnFO6cWPGhxTZoKlVDq98Wq71swk15YidBoqk/s7v8ZZ+QQARLqEr/+wrOdZsia2dbOXTEgUCNgtoiwt6IrY/I6xst+v4meTV7/vM5avAXVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdGg0RlsWWnOj5K+/KZhvHj4Iws9UyLYvvN/muZmvuY=;
 b=SMFVM6Zz6KN7SkttwsALDuH571q6owW2yFQNCCWIeGOJth/sGsFVQ6vZe50kGIhNHv/nEZCOgW2099c87UKzpBlXTI6bY50kz4Mk+EDYLGSIyH2NcPfisGO8g2m6QT3lU8ETpPJnkPyRsKYG67n+Xe8NykpJ1lpQzyqZ3UFhPfw5dIdDULWeIebxNdSHoWZxrYMHejbnqVyCeEdTWq3ZWrSCyjR4fcPQuebub01crdoUaDGJLqeLklIMyBSfqcYK6IfKbyAZ6Bai8mAYQjcBTh9M68ZHhMzNUTyn24EmtDEJhNRl1sZUpxSv3h1i0EwzYm/HLAtK9PQ3GjxYspgXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdGg0RlsWWnOj5K+/KZhvHj4Iws9UyLYvvN/muZmvuY=;
 b=IQVVtAXmxaquuRWMICK3SyAOMHFkHAIRWq4ZUQ5s+fA/CrOm2r33tJTG7WzRTsOWv/eYYPlFV73a74aZVU9BDlxrNnfbQRD9xbgmRT6oDJnn1H+zq1av7Q0wfzy5nLz9s2TY4aJFBxD/D/uPvAWABwBblUV6NPLIG64M6aP7870=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:32 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:32 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 10/10] drm/amd/pm: enable the rest functions of swSMU for
 vangogh.
Date: Tue, 27 Oct 2020 17:41:33 +0800
Message-Id: <20201027094133.21881-10-Xiaojian.Du@amd.com>
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
 Transport; Tue, 27 Oct 2020 09:42:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf1d22e2-5adb-4eab-5b58-08d87a5ca043
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845149EC178A38A9621156EF1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZVn42w2UztFD2mQE9ak1DLm1Zwm/GkXFJSWu4nPE1z7Tcf/1HWLlITapHiRgyzoX9q9Zee3HjJjvtpSo+DNpL+3faA/ojmd0hW72IaMQROJlULcN7lWLWp3dKCHlFxwbIUC2N3huPWtr/Kq4RuxE1sQA7ecO9+nNWgO+FtnBPRpYDTm555JKQnM26gS49sfHj7GUBu93alvKq0NSwp2JxVD0nGgdgeg5o7kcv4aMLZ1LGaXBWKONBeDvIClA55gaSnSZZO+cO0EvSMnrVOhx999Gt5U3/jz5RD5ZDR7xGU9PdfA4NLgqncUzuw9/QbAYRcpHDe3xeAyqbREQLxwRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(4744005)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xPqSnYW6c+vu5YlpOEwpP9rMPiKVzzgVH2MI01qfn3AUDPq7jSDVJys1V90BaSo89jCnqtomhs+oYdEPUfneAFdzVQV0muzIm6JZUJtIXIyYOVNqnMTHr9pQIC/AyASb4x953ha2gHaIuHZ4TCqjt2MY6aiXl/wh5ZVxtadBmCJyrOz74K2jpQaZSSNGKJro4vnlcTtm0y7rebkE6hwMb6PpnVoWdg122zXcNnYEyWCz3PcFx0ob73L6gNd7u0J0A0mt4Jdgs8mea1PmypRSvI47q6Nv1hjksx/MnPcU6h6CuTYp7lciH4BaKuvnirT8nuFUwoOEu3xwfscr9QtGC+1P8A0jT3xa7XpCf4bP0l2I65UG7nOeTJnemPfQc1SbL3NOCpxG+n69nyqYnL2ZFPuhLH81LSiKbZ8nZUPG68vsFMsiR0MiYbt3uGJ34LhfGNfdE/+Oj8zRumM5RNwG+XQoTVeFvLyh4/I+ry3dtIJBkRc025HNJ9YV+Vb3GLkT2FwJeWooO5Xf/CoLsadcma5geCHqgaj9OD1346oTlgRsEQFQSBKft2Pc8lmanoiqg3XJIS9uBgrHteIjfpqOqVPtvJ9mqnAsIy3q6Mz+HQ3v19Kvw3jsMO/VtDwXhVjgJ0rNGmR5G4PvyY0SzKYdDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1d22e2-5adb-4eab-5b58-08d87a5ca043
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:32.1482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ikqirjhs+kLMp++Ay5E0Chn/EmwQh9nLmZBkRbKAN9fPI1e87ooUACYY7kqzTqmthTuoZU47te46/ZCx7Hfjw==
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

This patch is to enable the rest functions of swSMU for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1a8a9cf993ce..39990790ed67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1111,9 +1111,6 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
-	if (adev->asic_type == CHIP_VANGOGH)
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
