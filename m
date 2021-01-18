Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB968C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 04:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F9A22475
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 04:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F9A22475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF322890D3;
	Mon, 18 Jan 2021 04:31:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1169F890D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 04:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9qfkJzXMnT/yJcqAn3fINT49Od1XQGC9SQVr+3XCN7+UCJPPgMokvWv4EANxXXDjtzsZ8zC3h8A1eb8hHPchfBjRUqefnmsu3U5j2UFo1HnFmoewbQyRA/wpIE0FinACj4L6qNo8S6cIaCa7RBV3OUTS81MoUMfJHZURs8bMkU1rb4kldanLv3EL/tX3/RJ3BJ8YGy3efJxsdWqRmogFoRN+E15xIUplpTq7qsGiD4n9QN+OZsMhzTaRCLn+00/7++jAKPM+5ZZlrsVJmtxSYHLDb+GmCrWaiQ193ddOyu6yUUc6/yb2vWeSdSMiZ9KEytl9Q1rfwRTWuOVnlxNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxKq74mZojK3X49mvlkRtCl8Lsyt8G2q2cmFCpprSS4=;
 b=C6ewBrX96dYTSUHc58dtBdg4mctcMWoS0vGnRE0mlyyxe39cRy7MDIpcbhbU1wdVGnRdlLhDRGYd1mgxp1Y8IJnui2HJ2SfHUeMqCihPzGLqhy0aw0aGuN4S2iWEV5hGAH4HDE4xHg5t3//0kHwhAIF4uek0Pq/rcNfE1ZV5E7feDNI91+RK+3D/QcnMjwy9Z/gdTZOLHuOMA6ed53cDCr1O2U13Duni3abTteN8DRgSn2NLv02hDQkxLM2xwfhl+vLP3gGhaXCzBDXZ7Nm2v6kb1fR5VFKSMbYkzsapR52GBNAIv/8ZbCgPT1AZwGOj+1C77klx/a24Cf31XFUJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxKq74mZojK3X49mvlkRtCl8Lsyt8G2q2cmFCpprSS4=;
 b=xt2k4y4R1YAhy1I/shft6p+ZJhhSSb1+z0Ky40Jgys0FXY9l5mccWXTytJRAMIMJIkWbS/6QpGR6h9ArZF2lKn6fz5swaU0/gpIukMR4uIuu18o+Z28hOUEhDu5WLypuA4yWef5jXPFNSC9yw/a++uh3ywux9nN6LPc6OxcSOCc=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 04:31:19 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 04:31:19 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Index: AQHW7Tz7EphdyhBXgU6UUh5ewnxEFqosyueQ
Date: Mon, 18 Jan 2021 04:31:19 +0000
Message-ID: <MN2PR12MB45490B1639A0735C9694257A97A40@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210118015452.418724-1-evan.quan@amd.com>
In-Reply-To: <20210118015452.418724-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-18T04:31:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=75c1b52c-cac7-4e7d-95db-d4ad8c28562b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.211.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eae1e0e9-4d5c-4d8b-f773-08d8bb69e717
x-ms-traffictypediagnostic: MN2PR12MB4342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43427D70D1B37D350F72AA5097A40@MN2PR12MB4342.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VsVO1kzYjFQowne5H/qawBc1xAjobTxv61KwKMU9xxaXeQIaYcxi3iF9LxTmzemQg5Z1TWeqCIyYpv4MJ1VBbQH8haIMnACub4ZlPvC+CPm/OmzUQZQjvGaJL6zI5xkUai7emiZdzstvJBBNqA8JJoKZe0oSGS1D2+CXYAgp6xg3zOVTcBjsyVa2/qL3oSH00YlF1IE+gFS6i16Z9ZXqrECkBGIy6RfVResF+icCMckxXYajepoXXmdqCXOj3sRamxoo/fgGSvHI50hLqWihBD8AUnQUqiHAzzJQAdziuLOZZ6GA12w8byZ2ITIM4nV0ajSDDFukU97OptTa5LGyIqIsXyKxAzp0Bl5/nxgFdywn3R9wSkDkX58H+qrNSlMuWvc+73aR1igx0oJJClbz6Pt1ZOJhVtcggkUlsg97JH6JE7rhLDgvJo+5Dnd2xwvuIqGzELc/K27kkGf3nqs7QepwwUEhVfg2It1fs1UKdbvmyCvJlxxu3gv9RNONztTT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(9686003)(4326008)(55016002)(64756008)(53546011)(66476007)(6506007)(66556008)(66446008)(52536014)(66946007)(5660300002)(83380400001)(76116006)(86362001)(55236004)(45080400002)(26005)(186003)(478600001)(966005)(2906002)(8936002)(71200400001)(7696005)(316002)(8676002)(54906003)(110136005)(33656002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6DLLtU/k2XvBv0Rkrp5PVQWs0joEwaaZVf7bPYrRyCo2cRinnI/zWiNT+V+S?=
 =?us-ascii?Q?kSdNxnXxZcdrQ2pdVQBsau66JubsWP4hZFBqw4/aURZKHZJIF7MLgCEvskXU?=
 =?us-ascii?Q?+bja+n3JcWBC8bNocLD8LbVMXzailKCe9Q7I0dl7JWJ5XOdO6nmt9F2td//w?=
 =?us-ascii?Q?8ebcIdzofbuVBKzQALTtAKThJ2IV1lhuBZgQdiQhuY0JqZkPfZIlWX9IPs0B?=
 =?us-ascii?Q?M29j28omxRD0cAl2uXrUngQaEBHYcaIq1xpXdoczoHN7uCSj9BkVdG1bw6Ox?=
 =?us-ascii?Q?hhoenrZKOfWBp8StygvFUDIwvR1/dx5/NO7jynERo58DZO06WfWveNs06GNI?=
 =?us-ascii?Q?7y4PBBQcVWstqcnlKeU+6bLoXVRA2cSvM3Vs219cSNlYClLkMgPGDxFWtqRg?=
 =?us-ascii?Q?sWzw81ljA/KG3w6pJQfU/PF+n3SCXrve4tbwjYItBjKHHUz+RS2zGgcGkR2n?=
 =?us-ascii?Q?e0b1fvq0CUFbnGKnaQKIaHK79/SDb1r0kriVVQv3aBA9kNLYtoa/yoUEAZNZ?=
 =?us-ascii?Q?VYOA02dSnnkkH0oXprhaYXlGxoHrTn/+Z9w+loDYM3l4K1VRnRLBX8tUZqc9?=
 =?us-ascii?Q?iKk8K1gE4Ld5FbW4Ut1p/A+vIELKltxY1Bx9Uxbn17T1jphFJSOIANzsSBFQ?=
 =?us-ascii?Q?1Lpqel9xu6A9eI/f0Z0S03iQXNpcBlV2ABVybG004OnM9mBR/Y4MTlJRKmp/?=
 =?us-ascii?Q?qEwSq+Cm3xE7T8GD05ZLpSXpGb2arw3kw8gZ1lg0FZy9aRINHlO1JECJjTmp?=
 =?us-ascii?Q?j2hk0doo+XFFaTWfk8VKYrM3mn0l7+OIsDTEG0Rurfx1BZi/tPivApE2Ib69?=
 =?us-ascii?Q?xr5u2kV3ThUEbv6yskNSomaKqh4JImAlhPuSu2cMY3jWliSmnolZy7ty3SVJ?=
 =?us-ascii?Q?bhyCSifdSwnTBKcXkHRKCxcfYLk27EAXdutB8+SBcEjs3FZizLFUCRdGxcy1?=
 =?us-ascii?Q?7BGD8PD7DMYJsnJtGIofK9uzS6EHBN+ziHngokr7YG4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae1e0e9-4d5c-4d8b-f773-08d8bb69e717
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 04:31:19.4409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CnTZCaQuFGSITN/BZxPYJkpq8Yp9zF39UN8TomwPuJh6TKwIxVgjfiB/J1MRcKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

This is not guaranteed to work reliably. By the time driver fetches and reports say status 0 (in GFXOFF), there could be a doorbell interrupt which changes the status to 1 (Transition out of GFX State).

If there is no requirement to report the instantaneous status, better to avoid it.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, January 18, 2021 7:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving(V2)

Support Navi1x gfxoff state retrieving.

V2: some cosmetic fixes

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 22 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..4d346f289ed8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..730a4880af08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,25 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: smu_context pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+
+	return reg & 0x3;
+}
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc151c052c37046e6745308d8bb541c99%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637465317233388908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AEi%2BA21xfZI5Wv2SjPCatiShlKGVa5ZHOtGR%2BIBjXfE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
