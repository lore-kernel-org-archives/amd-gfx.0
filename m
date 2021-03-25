Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F680C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 10:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964D860240
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 10:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964D860240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211516EB50;
	Thu, 25 Mar 2021 10:58:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1739D6EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 10:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iER+0Gi2T5hkbF+hl/1n4zpZ4AbL+XMiUkmTY46pi2VkBQRGjGCB65UcHQAjNUl7mgNxHSQgghlEepDuqGSoKmWNljikJLcNli7BH/XrMw7qxiGafsmdoML9ekD1cS5yPyNVb3W0QgSlk0FtKO3GHHBuidSArd5paeiJ2OjTxeD1iwyc0FC80+YYtmZQvfjB6uEr4nafKqIcwgn2ctqHch4bssDwVawMgBEATcs/pyxvIIKJq8TopnVuMOH+iI6WGOJ88WlmbT+go+YtfnkLE2iLtlmg9x2M+eSgXQYRRlLlbZLnCSzknUpFrzty0UuYhO98kqN5nGHS1wxpM+dBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH1LU3NwDk59aeRJcylSZHSmiUjhevfkFwIfk6VuAxc=;
 b=YFjb1SS8hWZRS+89YMTb08EjEnZ7IGQhI5gH8CpP1U+C51fAY75V4b695rHlaiZHzmR3SWlLddxXOiCYekFrfBJK8GMH72s6TQrkQgH4N7yI+V7J6vXqcowDVD0UBj8Kwi3Z23QmNQZFbm4voI8UnUAeuMgdpfIHkyrruHN1akdZ9EFW9XpztKIov1zRe4EBIJhHpepofN+lzZ/YPIMIyzKn6mJ9qX4+QL9Mxq8x6d+Uc7bfF1eU9eUJ7xRzojZEHpQW35pkOkOepg5QdhIgreAE4Uq2BlA1kaLVBHPfyS2i2zB7HpwR1XVjeb/PDTP0V7uavOCh1xIHc7QVpApUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH1LU3NwDk59aeRJcylSZHSmiUjhevfkFwIfk6VuAxc=;
 b=4uQ1okoMsve7vy9JMIo9RuZA5N2nRDuiZHJN1cvNXVJ0t07l/9ZoGnin7EBmV6c3MHuBdTUpZ4ZXoW2YxijtkiKW1c11Xo3lYvDVQ1s9CJ2MpCeJtnOZ/Xc04sDC62ew4ZD7y5/AmS8vihVCwPpujBB1YSmcwbFwEUkRQLZ7P8E=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 10:58:39 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 10:58:39 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix missing static declarations
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix missing static declarations
Thread-Index: AQHXIS5fYaRsXoXn/kyD7uR+MoKEIqqUiPhg
Date: Thu, 25 Mar 2021 10:58:39 +0000
Message-ID: <MN2PR12MB45494D5706A1E1C88DA570B297629@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210325042115.1104668-1-evan.quan@amd.com>
 <20210325042115.1104668-2-evan.quan@amd.com>
In-Reply-To: <20210325042115.1104668-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-25T10:58:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f7069137-5cff-4b38-a086-9bbcb2620de0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.202.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b2a49f5-2836-4070-604d-08d8ef7cf296
x-ms-traffictypediagnostic: MN2PR12MB3790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB379077D43C98F855E89D8EA597629@MN2PR12MB3790.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2UiGy1hsVAw1yM9H/JtRWE9fWjCdGtIFEy2/1BbkI/3+74mlkdoBSAqlFURGM4LCeUebNQCtRq5qBaH6JFCaxIk1qJ42s66xgQmLNOfZGu0Kfy2wlAj9l1ysMwgWxo3bjOo8aRnI/ga/ZK0JXWNhJtuT034goYPCfHVYKgSusnmEIeQtYOm+46d64J0iWSFlLhlHxowXbCCe3gWRuIaw5b6CneNLvQgckrYrOXgNtqw1QW43ZMKuUuahVOJZBlFol0uZl17zEieM15do1ZA7aI67RDwopgAMPcwGUpCBcImquSsYtwfwK2HPPD3y3DOIBunsj992LFITdgdAI7dN0imixek3GKkdjhbXuOcUgs0Lqke9O6K8q5xWsjGoVo9t6Lc7Q9v+oG+k5iAdMXU35Q+SnHjdITm88L6G7dMFgJRwQZynt4ig89CYLcfI3HqndnfPZ1ZlvpSEVcabtyqQl4NmgrKp4+NGqKqrGWBwuklosl6pMb8GVqzOa9Ph5Unlhb82poH2OzhpGKDhedGGEwNoPH5TRW8fRbsBQDdXDWB8p3DE7+mABkR9Wm3dosbFQjmK+Bs5g3/HgpKuqA2jj+BVNIezOSiw0ZF8uT9QZBvub2izxad+YHNLJ05aHsqP5XxZa1awP/HelNoiso6+Wx7yXdZCqpvS5bKW9ul/XlX8VZpti7b1fhL3M9J9qUjKS+jDBY4XUpLv8q0Qmg//w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(6506007)(45080400002)(7696005)(966005)(8676002)(316002)(4326008)(8936002)(55236004)(53546011)(71200400001)(478600001)(52536014)(55016002)(86362001)(38100700001)(83380400001)(66946007)(66446008)(33656002)(66556008)(64756008)(66476007)(76116006)(9686003)(5660300002)(26005)(2906002)(110136005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2wCw2FHaKMpSx7qUUzIsiZqwCgaWzLaVPh4n4s1kPmhbycDTC35RUYD4swZ/?=
 =?us-ascii?Q?Za2WqzMNImbQeUtrVYbI2Hsf6agNFJAZWg2zraTes6Pz45Sx7LQmrxb+RVIE?=
 =?us-ascii?Q?MAdVPrsgUp7eja/886ibpewpmt71QXRkuM8CvI4usJJoV5NfyuuK1n6SFmQS?=
 =?us-ascii?Q?gKSKdns+DSA3wlLbJ2Siw0I/TogNUsdzXz1kIiW3AFCGpWXMgburRCLXHU+q?=
 =?us-ascii?Q?X4zuCYrwPtPfHc8r5vves++/9dXZk/ywaEKQ5i5UiNEjdgBUtSqSi2KXhERH?=
 =?us-ascii?Q?3NQP66kzQzHuyNgHPYxd+Cpmbh0qNGxmLzbYmm0n5+fZ0K+ILFLnQwZwAjCd?=
 =?us-ascii?Q?c2pGWV/k8OuKCMAICRl7TR7/O1C0NQkn2mttR378f7bgwDS7Bly9Qt1gq+QH?=
 =?us-ascii?Q?snf0PHI5TCGsiXTn/i+vdaarws02Bv72d4KwLT0zdtykzmoK2VQUG5SJGoYS?=
 =?us-ascii?Q?ccmOoHx9fyT3dif3UTW9Am1bXTRbbCSVk0mJ02iv+Ny7a+udA/N4RElfW7Hu?=
 =?us-ascii?Q?YTzxD2EaFrxAF2+Zch707WM6u47vwWfZnS2ZU/oRmDqNNHaoZUEby1KZuqLZ?=
 =?us-ascii?Q?YMaFq2jrXw+gSHsB6okTanTNmbV53YMEb+N3yEMS9VYFbqzHb/mJ2ie7cKId?=
 =?us-ascii?Q?lGEkJWeY9wFFuaKcUYhdX2I31zbFoJ4gPBDiUz953ABzXy55TbXNMvUyopgN?=
 =?us-ascii?Q?sdMfJcpk89WunweTc1kH65yT817sGYSYGa5WmwW+/nfUhWsHuHX6IVnTMmD/?=
 =?us-ascii?Q?mfAFH8k2fwDovnxKz7zJx/4JBdIu/h2a+vIT3kQAsrMrh2WgOAobYfVfQDk6?=
 =?us-ascii?Q?ECFF+KEEJKXk9nmGcc36zY0SGcjEqnY/ogAek7ZG3myYfkQv4gx/XM1cQDbZ?=
 =?us-ascii?Q?MsfSw7Keq/z5Xbm6RRUWt2tb2R7M5GGZO1DjgR7QT1Ei5PYoRXWte0lsOTXJ?=
 =?us-ascii?Q?t+VkE1+tSv0Oofek4j+zDirdOCZB+F1q0bCw8nXejC5I82+zqwcleLmEC/Lx?=
 =?us-ascii?Q?lCw/mYksaxi9AdJjf6n8bPTMnhjyUPlgEte2mOVV1uMJrx0T+POKQeKJCfib?=
 =?us-ascii?Q?X8roegVwJ7b63xWrOahpsb+CdQmuL6bBtD1McaOMyoauSwuILlPQIzGtElFX?=
 =?us-ascii?Q?VhpCbRotQuUKVcvynLphHRorYDMpzO0Of5hznVc+2QSb2qBLt4gwWeLlZ7pF?=
 =?us-ascii?Q?PphPV/Nkb/zCDFjktJvbbjcfNS+2ana72AaDA0E4UuW9yT9owXm8cqfteD/v?=
 =?us-ascii?Q?N5Wypel7n7LD8c+NUpQP+7rOSZvHrEib4mvOIO3Wk1nmS+dd1aD6/6RIIqg/?=
 =?us-ascii?Q?DN7S57fdh2alcKOcYfca9zQd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a49f5-2836-4070-604d-08d8ef7cf296
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 10:58:39.6903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEHFM7EUY2EhM71wdd0yAIILZMhzhOisXo7mFVn8MV0LrrlHHhW/2IX8+hNdyXcl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is 
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Thursday, March 25, 2021 9:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix missing static declarations

Add "static" declarations for those APIs used internally.

Change-Id: I38bfa8a117b3056202935163935a867f03ebaefe
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3bbe0278e50e..e136f071b4f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1467,7 +1467,7 @@ static int smu_hw_fini(void *handle)
 	return smu_smc_hw_cleanup(smu);
 }
 
-int smu_reset(struct smu_context *smu)
+static int smu_reset(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
@@ -1715,10 +1715,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	return ret;
 }
 
-int smu_handle_task(struct smu_context *smu,
-		    enum amd_dpm_forced_level level,
-		    enum amd_pp_task task_id,
-		    bool lock_needed)
+static int smu_handle_task(struct smu_context *smu,
+			   enum amd_dpm_forced_level level,
+			   enum amd_pp_task task_id,
+			   bool lock_needed)
 {
 	int ret = 0;
 
@@ -2147,7 +2147,7 @@ static int smu_load_microcode(void *handle)
 	return ret;
 }
 
-int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
+static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 {
 	int ret = 0;
 
@@ -2466,7 +2466,7 @@ static u32 smu_get_fan_control_mode(void *handle)
 	return ret;
 }
 
-int smu_set_fan_control_mode(struct smu_context *smu, int value)
+static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 {
 	int ret = 0;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cb4ea58727007476caa1008d8ef4580c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637522429088901237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bNDUB66tzrjOXwn8Prqe3QSo1kHIOxa3A%2BvrEjSUZl8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
