Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCEC07E96
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 10:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEF861447
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 10:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEF861447
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5266E1BD;
	Thu,  8 Jul 2021 10:24:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E546E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 10:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1FMkjNWF1jbPZ3XTRSj4nkGX6w7RhhwyJZsedk4/VUWq6T67kLkItHIuWjt3l3KVpsABK90TubT7doizeVYDdsyf/CcoqB24CcSHmAjNK8HtJz2VwNcqeM0wZgIzAzQne/Mn3Y1FjPXUt3hOuotLoCY1mplkusus/zChiVXl7mrVNq9W5nGT1ZRIe/z1PP9ig8Eb5vHN85T3pUIRygbZbdSD3kBUmkY6mgVNIdA9uBxkn30WcohTCNbFKRobkwSB+FJ4QQrazeZR2uX7Bxn0XjLNX8AFw55zQYzavX+MVPf3QcBhEm3h1O/g2jP1tyunoW4FVA83sS8Tlthffm0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUAMk0ooGN5IY1Z05zzjrsGzCwx/es+KHcNoWEA6Pxw=;
 b=U927Ekms23MbeudwvSLwL0g68Xgvm1ylUJ8NJvJUpRxVmQCdKH7m9+iCD0N8yPdgndhI1fqui1UgJfwgU9OQVYgDCvASRefImwMhMmc5vD6MaHa7o+s9dOYxjCRZFXhCQ8587m4JgnSNsd5wjBW5b3FEW0K56UFaOhlflVGpmc2WiB6g9o20u0NMUy2kwF7yumWjpMVxCQOuBad3wIWGp8bVm7NSx3OuFwJ28OMFqej2Rpj3GVBS2vQGFULrsH9KcFPjYhBqcUu4tKMpGQZPigWjBeUd93iL1Ls/2Bi1kNGx6PSu89+YWoOTwtQmCac+c0ZGKzIUI8ugo11f+7HgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUAMk0ooGN5IY1Z05zzjrsGzCwx/es+KHcNoWEA6Pxw=;
 b=Er5FWbGIRjqa7m0danNh24YNkfpKROAbr+FVE6t+ZI0bjLrpBnMha4qxUEWPtXP6RPeSBwGOeAk0TZ0bbYAMQseSF2GYiaME+ZOFTuPg30Bh+eyhHLeglAWhe5+K8bvOA6MxpBgL4VE1Yte08TlGwT5n6f9eZRdUCjunMrAh2hw=
Received: from CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15)
 by CY4PR12MB1942.namprd12.prod.outlook.com (2603:10b6:903:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 10:24:53 +0000
Received: from CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::10dd:684d:2718:5dee]) by CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::10dd:684d:2718:5dee%8]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 10:24:53 +0000
From: "Sun, Roy" <Roy.Sun@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change the imprecise function name
Thread-Topic: [PATCH] drm/amdgpu: change the imprecise function name
Thread-Index: AQHXcwefTB7VWJcLzka3kFpTBFwuFas44Ncg
Date: Thu, 8 Jul 2021 10:24:53 +0000
Message-ID: <CY4PR12MB16061F0BE2713F05A08E3675FF199@CY4PR12MB1606.namprd12.prod.outlook.com>
References: <20210707081049.38365-1-Roy.Sun@amd.com>
In-Reply-To: <20210707081049.38365-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-08T10:24:49Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8a0d89b4-3729-4f20-98a8-4d7025e6cb35;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d3ab9ce-cf02-4a70-5984-08d941faa031
x-ms-traffictypediagnostic: CY4PR12MB1942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1942FD9947E1F83CFEF5EAD6FF199@CY4PR12MB1942.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UBwKRJMjx0zzn+c/jBwlmJxva9pidQYUA5iuxtnbg+hjx1NgA5ladnXMwRzEpes3JHEVIXgfArsQuouvonPDewtcjqkuw3ipijoXFOuxcU8pGpnJzpltpg7JJDVDzY5yOT8gHjd0Ko6wzQJdz7O/tjEvQPTYHYpx+/Avr065ITW64AJNTsxmjhMLCVnFjE1fjg204vMwAJOJ3aAwBn7JL0uVG36kGu1ePlMkimlwOlq2ncTqOcG1glsgMW+pD0IKfnQBtsLJhh316SAaIj+ttHg7O13vGTdo+sNNXA3KDYbgBPshFyJjOfsQpmvC4lL00uCFfxA0JuQdqG54j+aMWELfz+MBvG6mQOXSddELqa9uD6r0QbdpUTMi510x0dzdv5NlZWLePrrZYSv22gpq/xs4ejvEYJRxhG5/z+yEy+VpO091ANZfISNI67f/FQHMGk1bZKm441B+lG35D4hODst+j+bLRQCi+n7TpT69luvGah7GF//+ferQv7YByFPNHcsfIfWm7rv80lCvKRczm1YlilnQfjgJoAg3O7skfgDQcyuLv3NZ2Wdu+IotBvt22ltOxgFmEQDzzTvKEa53cjku4dBlo7gaBfFnoQBXoVAiVVLKC7Q7c2aKBLr+XP/v+HTb9ks55IpO8I7Ehy6xA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1606.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(316002)(8676002)(83380400001)(6506007)(53546011)(26005)(76116006)(478600001)(64756008)(186003)(66446008)(66476007)(66556008)(66946007)(71200400001)(8936002)(122000001)(110136005)(38100700002)(2906002)(55016002)(33656002)(86362001)(5660300002)(7696005)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GxstxRbbHgZcmC41ONiL0WbFN3g1hQcCNGPAlgpX0jHXXA7Z30fkmSyblZaI?=
 =?us-ascii?Q?RdY/UiN06uUajc6o9ex1SyWzo4//7myrWrZndTEHrMXewkL9x289TFNoyhyH?=
 =?us-ascii?Q?cxWqCocNUJ1lPYnPyyiYyqsVSDMozIx0TJ2zM347ne0cEM616L1O8ZUKZN+7?=
 =?us-ascii?Q?NHlmbbYvg8LYxDZBHgE7SEl+q5hu0XfNw/Wf5T8+NEVWxvT1YiK/pdgmzSsC?=
 =?us-ascii?Q?cqi8XNhdCoZQJU5ryzGmMv6K8UQ1Y/Vy7j/T9U66fsb3FTCkDWgiIdcKtB0Y?=
 =?us-ascii?Q?1kC1BLoY1E4RhVjlWP+FqhHr831MP0e5f33ZfKw2tpp7cxeogI0FTvLo+zep?=
 =?us-ascii?Q?NwbNssYN2pGjxI/MzhJArv0FCthH2DKIxNfw5Cap1RAQ6cdgMejweSGxd1if?=
 =?us-ascii?Q?F9TXmNH7L3pXAqQPY0nKqXZZ/88NnQFEStZVLnhVq09xa4S4xUE+DPDTvx7J?=
 =?us-ascii?Q?PcSGDtlQDKg9GfQhgT6L2CXmspB2WNqpq9Cc5iFufl3Z8YqU5EpMIwj2Seuh?=
 =?us-ascii?Q?OExns+XHtiPq9rfwgBjqlxybW/fc1Sg03hGDq5f7po4F5Ke3OEL6gsBnn0bS?=
 =?us-ascii?Q?N2OEiPue1brjmTg3Z0NI+CLNNgMxmr4UQBcvdn+2QYIgw5u/O9BKEYTyge3o?=
 =?us-ascii?Q?/HPqZVrriDkTKWthlxC2OqKgSHt8TJrUB9ubnoHcG/lZ/W8/9z2EYFBfrJup?=
 =?us-ascii?Q?yuc2IidA2nZgvi8UqgDxl7e+59tESLg54IEXsKcXBmYl7ryZfpmBBNeATxoH?=
 =?us-ascii?Q?pQStA8TUaZe/9QtxFeZVCPcdRsdtMTyxTTPrRQa8XSTdc9xOXmWW+3Iq6mEM?=
 =?us-ascii?Q?ON3aiVkB6sK00sWA5EdQ/v6I4Puv2QB8bZ1CJQi08MEeEg7D6wIiapHSxYcp?=
 =?us-ascii?Q?sSiT16Ox8GJQrQpIkgqlrLyP2k6StBOPhvlss6iwOnOensQ3X+LYxO1eeKQF?=
 =?us-ascii?Q?5KbLFB31YXP0GCVmh9PoshjcOyfAhnxmW3Iks54u1EwMXFODGV3A7stZkDMm?=
 =?us-ascii?Q?3MjUg1ha88p5qpsl8Di+Tid+UlFmYlCL1eTOOh0uuzH5UiuR/DXnsoEKqcBA?=
 =?us-ascii?Q?Oiqr+YjyuppbJcsUwo6IyJ0r9QPhJDGh6iH+9Uixx3d7ikpjEnkBRDposdr5?=
 =?us-ascii?Q?49dKMQLKXu5J/VDmhuRwJsIciBl2fwMbB4QpeW2uqGfHM4VGfm525VvfYd7O?=
 =?us-ascii?Q?XCKZOTLlj2lchUVQBYCkWi+j8s+1QumgmcVoe1VoSlmnYZzHkzglBxG/MvXv?=
 =?us-ascii?Q?hcZsRxRA5+ApXTQxwxYaZ5uNn4ryn4Nd6u23VQYujK4AdF/37RbDdkOtVbVU?=
 =?us-ascii?Q?2ThpmMd4GJUCZFKbksAYUIlW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ab9ce-cf02-4a70-5984-08d941faa031
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 10:24:53.3774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gi3+nJyKizaqf9//CRGIT/7ta8kzRIKMkZ3xycDxw0QvX0rosB3REgv2xld+fPmZxctDpbde297soT4MR1OeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping

-----Original Message-----
From: Roy Sun <Roy.Sun@amd.com> 
Sent: Wednesday, July 7, 2021 4:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: change the imprecise function name

The callback functions are used for SRIOV read/write instead of just for rlcg read/write

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb1f3f42e00b..aa94ad0e9973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -508,7 +508,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
+			return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 7a4775ab6804..00afd0dcae86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
-	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
+	void (*sriov_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
+	u32 (*sriov_rreg)(struct amdgpu_device *adev, u32 offset, u32 
+acc_flags, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);  };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 705fa3027199..bc4347a72301 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1542,7 +1542,7 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 	return ret;
 }
 
-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 acc_flags, u32 hwip)
+static void gfx_v10_sriov_wreg(struct amdgpu_device *adev, u32 offset, 
+u32 value, u32 acc_flags, u32 hwip)
 {
 	u32 rlcg_flag;
 
@@ -1558,7 +1558,7 @@ static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value,
 		WREG32(offset, value);
 }
 
-static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
+static u32 gfx_v10_sriov_rreg(struct amdgpu_device *adev, u32 offset, 
+u32 acc_flags, u32 hwip)
 {
 	u32 rlcg_flag;
 
@@ -8269,8 +8269,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
 	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
-	.rlcg_wreg = gfx_v10_rlcg_wreg,
-	.rlcg_rreg = gfx_v10_rlcg_rreg,
+	.sriov_wreg = gfx_v10_sriov_wreg,
+	.sriov_rreg = gfx_v10_sriov_rreg,
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,  };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 044076ec1d03..03acc777adf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -787,7 +787,7 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 }
 
-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
+static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
 			       u32 v, u32 acc_flags, u32 hwip)  {
 	if ((acc_flags & AMDGPU_REGS_RLC) &&
@@ -5131,7 +5131,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.reset = gfx_v9_0_rlc_reset,
 	.start = gfx_v9_0_rlc_start,
 	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
-	.rlcg_wreg = gfx_v9_0_rlcg_wreg,
+	.sriov_wreg = gfx_v9_0_sriov_wreg,
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,  };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 0eeb5e073be8..8a9ca87d8663 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,13 +28,13 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_wreg) ? \
-	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_wreg) ? \
+	 adev->gfx.rlc.funcs->sriov_wreg(adev, reg, value, flag, hwip) : \
 	 WREG32(reg, value))
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_rreg) ? \
-	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_rreg) ? \
+	 adev->gfx.rlc.funcs->sriov_rreg(adev, reg, flag, hwip) : \
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
--
2.32.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
