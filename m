Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB7CC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBE764ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBE764ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B496EB5F;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001796EB61
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoN7m4UymKjwlkD4tB+lgRr0exzA+bNROV8+5abNyZjDRm15NVpm/tVmpky2zwmeECRaj5pO0BNNfUj63Gj+Oc8CKIlnG74YkCCrEepR9nf709f95jAfIlH6huLpwYGC90axAfbAn6SMvIwCiEzC1O1pfR14cbInvG+qCTv+LgmH6rnpLYxCSl0EQ6kb32W3b7hIY6fKPeGVdz+tW4BQiNYGDKlk4oVzVhi8uBWMXSvhNfsAwyBsxUi2Q1wqWaWTU8waZvpdEjGJLnJfgHIbzd+YIyT7s7MUPdSqBPN8FkyPwtwTQiU/lwCILWx12EEM1yZtJPnX3nWQbOCXGjtPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjEEjRJba7UAAYbsbI9QDP5Qmf4gHmfyqXCHOIIm4Zk=;
 b=RBgT/oBTE9LeuJOV9gczGuO7Jye37t8d511sX2GY91NUn5l/A/gFFFyU+YotPayWq/jk9sMY+K6i6CocLugUGwxt5KqGsrK6IZcTNlGh+CePm2IebW52jbZ8JnR5i3VR/uEb5jZ7uy5lSYTtLz8wY7Gz4jsx321QriwwLKxag2U6f3k8LoOETwiw8eWfS6IO3cEmpfaFjd75gnOIYzUMepcUQwzlCaDECpyQEswALxWUQ0WGHkhwKn1Ub2dJu6zSiYUatT9npe0jGyEVQryrSWxoBWZlox/aR63ZsWcj+9BrBdIDF89w0/Tui1H/AAz2BuCsJ6Tl+u60H/U/TVP7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjEEjRJba7UAAYbsbI9QDP5Qmf4gHmfyqXCHOIIm4Zk=;
 b=pPn2RrIKPd8XckAWctpOrRBOcIZidtV6R/OKYVMbQ1I8vO/CufW+pwDtR29SIO6y8hG4tbga3HOu0QLNI6yit/r6a3/u7tzOh1oR2YmAk8rIP9FDX1U9to4Xq2F2woEq3mFyBS8pvLtJopgiVGq0kETyRDo/cmxnudHimSl7c5Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 086/159] drm/amdgpu: update atom_firmware_info_v3_4 (v2)
Date: Wed, 24 Feb 2021 17:17:46 -0500
Message-Id: <20210224221859.3068810-79-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a59054c-d20d-4ce1-64ed-08d8d9125ed1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404697C3AE2143AF6DD23B31F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bhHJviKbyrDiCtaQ6wwcP2AXLOGYXEhH6MkdZkKABsN+if4229/LLP4gax0731qnks7VCcKpWI9yVH1Iedi94buYiSH0mDtUcaQRWNtmhflrNdXY3un1NmudFjNDEI5BiDDmlirw/lxT3a2GJS4Fds6ATvoFATueZ47Ws8w6zNCnVSyXkwRpJYSnBF0ZhG8L9+OjJc5wFWTr3xGPW9IxJYg51WIAnP71JoH9z+MHCGBiiUtp2KRPHwH4xQx/w4b1cTfteDEp2ekSllLaTp58ulXutoCsNpDZrYK+ag6W/OcyGc0qAr/HOi0fmO+PqU1kjdHvhogZZmbPVD0bgZ1CHA9iCTdmTMh1XAJ2cx6YoDKM+gwxuXHbT+gZQ+bejPlZ2m632tdm1kv+zWc7xfuwd6IYzD0GrW6T18w3XoMwemvcSp8yrO5rznbIORDnYYi97LEyylYkBF5rdW5f2T8/YMDnYESsxmlsdcva8XhRaYU7GZGs7BbaMrNDZkmsXHHueidMbIoLIsNDAwxW72c12N7aAouRFFQHvTl75n1EzZON42UDogQ6NAm029pKhUKDyZi/nx9A0NBfOZ6CEaAxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?boXhq3r0cG06A2VmZ6hv/RYr/F99P5FoT0+8V50lt4cVmiIl0Q6VGzjPrdOl?=
 =?us-ascii?Q?6vD3K19yVt9mYM1MJyV61quKkT/VB6GNAxAWHR9Peyz5D5ZMNqJBymRB/ibP?=
 =?us-ascii?Q?xXuAB751F6V/vsTYXjItm0eBQv7tvpuwyAeF2/PZYxtcu/yb3c4fXsCDdVyt?=
 =?us-ascii?Q?MkNiVRoTJPdNQK4JPuKEaYopoGqeFhTMfe/pceHuUeooCZ5urrCu2/J7GsPj?=
 =?us-ascii?Q?VRd1xJDaw70mwjIoqAtxKRCRjpdR/7mQc69XB6D/08xbzQ3jgflomwnPgX7G?=
 =?us-ascii?Q?lzvnWLc2nPKiPmFn4Fw9T0nqJRl2+akty1OwpoWt6WSKAATcuLr0Kp8Ya1am?=
 =?us-ascii?Q?wVlCanQM3OqX/ApZJ9SgzUOwx9edc3M8N+CRP8DDE55acIzxfNmDegjSNqer?=
 =?us-ascii?Q?Dg5pjiINqQXVLLoAGUWUcNeP0UJnHXv947EfhTs6oJ9rbvMxM6ouoTSrdGIz?=
 =?us-ascii?Q?xyLik0zFmMv6P/9tNG+2woWYWIrYkr6LGK/BMxTkKcp3JIw2jduf37Te38qc?=
 =?us-ascii?Q?8QirMZhNUzbTlsal5K58Im6iZZMFz/ieYdeS4IPORIdYFEm09fyj8ieXIDh6?=
 =?us-ascii?Q?eerhQ5WyHCYBBuEvtiKuDwmQEygAcZ1XJiC4Cy+4ieanimzJUAewIu7WmHxn?=
 =?us-ascii?Q?WUgUHWcThXVw2o3KboTRGwRgDTdO6qsfDHtT9zp+M9vkGMT8ufBIR1jppYdE?=
 =?us-ascii?Q?lyhVYyD/mSsymEQEAZ3kljV0C2O4OdG6opqExbhf8ooOgLhFhXLYx6t9NMLZ?=
 =?us-ascii?Q?bNUOAktTVz120PMpsrpYEXoewkRPyr+1rTLTDuNcq4XfoRSF9e1gITbu19tF?=
 =?us-ascii?Q?2RV1a0bWCft2DZdmq+LmpAqWwI6W6giKiduzXgSItgdkWE6ECVcGwwRzFDKR?=
 =?us-ascii?Q?I5iI4UKTCmYLxyi00Rd4X8jjU9p+j7SCxPMF/NrldCzN2qvY0OWO8RMcI0Yb?=
 =?us-ascii?Q?Ua3JGIQPRXDV41uIG1n4i/49dC+4xSmRuks+SZqHf+i4DwNPWCZnXvc3xtkr?=
 =?us-ascii?Q?536LJH/uJs2wu64cX2YzR0sHBgqzeLhHOT7OBrC2Na+1wOZlrxnlEO5+5B7b?=
 =?us-ascii?Q?w+ynGRZQi1j0KNJdOdlmCPtc5T/Sv8ikvPm1hqhMzlyn4hgU3LkeUSv7e2NG?=
 =?us-ascii?Q?OBrSXGXcohCOnKflHCP/PNvIhdM4hdE5KO5Be++GpX3VGn5UiKKDpxxvEpBn?=
 =?us-ascii?Q?bDIbNSYH6SwCLdAf7l7LUviLI9MckIVomKCnZFdxhB2jMg2IJhWeBxhGIdtO?=
 =?us-ascii?Q?mUNA1R+oWKK/kprPooH1VRNIM8yz31uikY8nvH2DXvb6wfnlljNpRsf1lbUf?=
 =?us-ascii?Q?Nxum1bt0g2v6hKMzygmwrays?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a59054c-d20d-4ce1-64ed-08d8d9125ed1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:19.8684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUc+RAfeRM3n3HSjyzi4THK41f1sY1mC/raXOR5Waot4AxfXZI/B4ibvuF8iVZl8KWUW+VAFHmKI7Bsy5LjGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Lazar Lijo <Lijo.Lazar@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Feifei Xu <Feifei.Xu@amd.com>

v1: Added some pspbl parameters
v2: fix fallthrough issue

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h     | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index ec43a4fb761a..1c0034df59f8 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -596,7 +596,10 @@ struct atom_firmware_info_v3_4 {
 	uint32_t maco_pwrlimit_mw;                // bomaco mode power limit in unit of m-watt
 	uint32_t usb_pwrlimit_mw;                 // power limit when USB is enable in unit of m-watt
 	uint32_t fw_reserved_size_in_kb;          // VBIOS reserved extra fw size in unit of kb.
-	uint32_t reserved[5];
+        uint32_t pspbl_init_done_reg_addr;
+        uint32_t pspbl_init_done_value;
+        uint32_t pspbl_init_done_check_timeout;   // time out in unit of us when polling pspbl init done
+        uint32_t reserved[2];
 };
 
 /* 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0db4f1572086..7589cfe86f54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -508,6 +508,7 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = v_3_3->pplib_pptable_id;
+		break;
 	case 4:
 	default:
 		v_3_4 = (struct atom_firmware_info_v3_4 *)header;
@@ -522,6 +523,7 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 		smu->smu_table.boot_values.vdd_gfx = v_3_4->bootup_vddgfx_mv;
 		smu->smu_table.boot_values.cooling_id = v_3_4->coolingsolution_id;
 		smu->smu_table.boot_values.pp_table_id = v_3_4->pplib_pptable_id;
+		break;
 	}
 
 	smu->smu_table.boot_values.format_revision = header->format_revision;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
