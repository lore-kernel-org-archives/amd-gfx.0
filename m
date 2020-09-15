Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F97C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 02:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B65207EA
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 02:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eIFPaIvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B65207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE4C6E82E;
	Tue, 15 Sep 2020 02:32:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E32C6E82E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 02:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsPyCtgBbZYwbUxtwwtrE5FytlJz7SDp66/Dz5zQv9Ufg0h7gGpV+jIPhDHYEX9yFJ034/aCRBihfwYs4OleSEEkX1DU8CzIWk0Xr+JTbzXu9aaknM7kJUDqP1+CR2uizJ874NrqByABvlotsh1oQyQwOPXREp31FFh/6ThAkz43uQlURC2Vbo1TqQMzEW0iuALzt4k646LBFjVWWBXGM1boXK6jfgkg4FyucExD7tYN1QPincyRlzRxnmb3i5XYtEl3bAUDHlIwM0XhIDkiNEukaHZu6IVhe6NzsOLcef6w37A6MHwI8RFnG30lh7/5id7TsDh1oz39xjUk4tVtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXjviXjZSdexpEilmkO7jC+dOSy6G1rFfGSN8rpLsCo=;
 b=oRA1qiqtpLxq9Rsn3kOI/Vccs8SChAhk+UU7jv7sH8/PJABxQ7y+Dxgq4rssjFsHVQCBrUJOc9Cd2scUw5DaehVz4cVNY3KdxZd8B7CEGLxgIk7opWz7UxHpfS2PYAux8L4vKvFQdw8qwCxWzhE5yHrkLIdW3lzALv5cNC0SAjA2qtqC1gyuBgIL8WGMiytswMwqMRng70JLQPudzO/QojaRB0W4VYESmntkLI8AXrzA6pkbDBhSWZA/Ujb75HsPnqmnwhoiGhDU994hqCbeEDYLefSZILxAvlE8QnXxHcpxwZQLUKKF3Pq4ZMGukjnfur9zqtKT33WDvM9dUEpGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXjviXjZSdexpEilmkO7jC+dOSy6G1rFfGSN8rpLsCo=;
 b=eIFPaIvlr9kyv3glBKoSaryCfuTHUW8YEhC9rwMpHEXum4YaLvxKPZGmEqTfCGxutEDeMZMmpfqkzbFAcdVQXTDoPAIPyWIg3DATZnNMNWs5PkTZWV0GEJf+TizAF2jA9zEX0TmDBPb6pl1WIFKnAZlXdzQsJl2tMuiebLWaAPE=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Tue, 15 Sep 2020 02:32:17 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3370.018; Tue, 15 Sep 2020
 02:32:17 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: fix xgmi perfmon a-b-a problem
Thread-Topic: [PATCH 2/4] drm/amdgpu: fix xgmi perfmon a-b-a problem
Thread-Index: AQHWheDvyT/URvjdjUaQR6DsgULGS6lo4mYQ
Date: Tue, 15 Sep 2020 02:32:17 +0000
Message-ID: <DM6PR12MB27611A67A79B8670EF725D8C8C200@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200908130603.10344-1-jonathan.kim@amd.com>
 <20200908130603.10344-2-jonathan.kim@amd.com>
In-Reply-To: <20200908130603.10344-2-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-15T02:32:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a2c7a894-d77a-4bd9-bf78-5cff7b963b27;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:81e3:f385:61e0:4d2d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6add0e5-f30d-4bcc-8ad4-08d8591f905c
x-ms-traffictypediagnostic: DM6PR12MB3291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32919CC851B6FDDA47D456B58C200@DM6PR12MB3291.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VK8pOcMCaYNniMBxZnekEMFDlblmy6MgyA/6OXPuzcqEKaia0P+zCDIcB5ifOQ5Zgg2Kxq3bDlFTD5oJvhcJ7eI+6S5Od73gukX/CeqL1gn0jyzh3Qee76WGwJYR9t/TuKEWSFIG6S7aI8l1rRUQIFnBUTPd4NiI310fqpI3JKsW3rrZbrEdqfnQC7Qm3JzFRvUprozvQb2f/n9Q2bzl3lZh030E3SrHfwCiLZdofwh2BvpGgIYvG38pNTcyANvZCEyIxKcQTmqfpAmrEylWITvlB5cqqQ0Q0/wUcO6MupqmFOoVc4fXPskllVoyFS1O6F3U8+h04K9+6j6SRo7xcUs0SxTzJvtrCtW3X0iHlEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(7696005)(76116006)(53546011)(64756008)(66476007)(83380400001)(6506007)(9686003)(8936002)(966005)(66556008)(2906002)(55016002)(71200400001)(66946007)(8676002)(66446008)(52536014)(45080400002)(186003)(5660300002)(86362001)(54906003)(110136005)(30864003)(33656002)(316002)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cLIev2Qi6YgaS45DHFprol2yuqon3eJACOoSIiKu/xBJHmVK0xxcrh/S0ZohPqvIlpLIvYjuAh07OWlDWcUjBVE4NxEEx/EFcm9pZNVybsWNh17idvH5+C+48y2t4eAuNTrTAaKFbN4hiIe6Of5xxPcHaBf9UxkOhIkH5dlIjnEOUczTsz2m4dC9/vYZE/ylKXi7kXSW12Pi7rm6p5JSkNemfDJoL5s6up2NqDV4NFeRymaytasZHEu8eH3+6xczm/cp96/xGiHuG4rr63G1qHnAuHVzfuwC7C0Q/KXfC0M7+8PSt8Cy1reYaSxZs5dmUsrtz02JlF1dH4Jpsv/IHHEu7QZu4QCkw1/8cgGyiP+AgeCLnkrl4QZxd5pb4CEgtQ/au2/EJFHpb2d+B2psvIcyeAufOnsT5dBpn3OGUroRbJqhzjjF2csMhgK/Hcl/c5AegjhpaZEgIrqCP7ci8zh9p+mHq2ix+a+soGU4CXX/PpUEeND/vlAGhX2B+MDGqnQoZUmhIa/B8Ka4FWezMgBEzLsrVtR0O/xRILtXv+dT1aGmfPF6t7KCuMrexo8VFEtHPPFPxpLjIzR9HCXZ3d9zcLta8JLOrYqxEQD/OuEzA3LWpUKOthuPPwSsWUDEsZL81by4kjFuTjKdgKy+4d4bGTBn7muz1j1pnO/JEbiffHmLogzEY5forCu7DmqnJTYbak4jZaquRhI7pOUhAA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6add0e5-f30d-4bcc-8ad4-08d8591f905c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 02:32:17.2288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAdVmzvEXo37+uHVUo44RDaExL41ZpeJRnAc+5BE3sVu9jmGdHuEp9gqqQ9/cV1zyIFI61R8xcH8bK6bQrfJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Few minor comments. 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan Kim
Sent: Tuesday, September 8, 2020 9:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: fix xgmi perfmon a-b-a problem

Mapping hw counters per event config will cause ABA problems so map per event instead.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c |  23 ++++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    | 104 +++++++++++-------------
 3 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 373cdebe0e2f..52488bb45112 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -44,11 +44,11 @@ struct amdgpu_df_funcs {
 	void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
 					    bool enable);
 	int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
-					 int is_add);
+					 int counter_idx, int is_add);
 	int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
-					 int is_remove);
+					 int counter_idx, int is_remove);
 	void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
-					 uint64_t *count);
+					 int counter_idx, uint64_t *count);
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
 	void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
 			 uint32_t ficadl_val, uint32_t ficadh_val); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 69af462db34d..915c580d30be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -74,9 +74,11 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
 		if (!(flags & PERF_EF_RELOAD))
-			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 1);
+			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
+								hwc->idx, 1);
 
The previous pmc_start() can fail if there is no slot available. The code will still continue.

-		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
+		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
+								hwc->idx, 0);
 		break;
 	default:
 		break;
@@ -101,8 +103,8 @@ static void amdgpu_perf_read(struct perf_event *event)
 
 		switch (pe->pmu_perf_type) {
 		case PERF_TYPE_AMDGPU_DF:
-			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->config,
-							  &count);
+			pe->adev->df.funcs->pmc_get_count(pe->adev,
+						hwc->config, hwc->idx, &count);
 			break;
 		default:
 			count = 0;
@@ -126,7 +128,8 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
+									0);
 		break;
 	default:
 		break;
@@ -157,7 +160,12 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
 		retval = pe->adev->df.funcs->pmc_start(pe->adev,
-						       hwc->config, 1);
+						hwc->config, hwc->idx, 1);

Passing hwc->idx to pmc_start() is confusing as that variable is not used in this case. Either add /*used*/ comment and/or pass 0 with /*used*/ comment.
And may be add a small comment saying that when "is_add" == 1, the function returns a counter slot.

+		if (retval >= 0) {
+			hwc->idx = retval;
+			retval = 0;
+		}
+
 		break;
 	default:
 		return 0;
@@ -185,7 +193,8 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
+									1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 7b89fd2aa44a..8dadcdcffba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -391,33 +391,28 @@ static void df_v3_6_get_clockgating_state(struct amdgpu_device *adev,  }
 
 /* get assigned df perfmon ctr as int */ -static int df_v3_6_pmc_config_2_cntr(struct amdgpu_device *adev,
-				      uint64_t config)
+static bool df_v3_6_pmc_has_counter(struct amdgpu_device *adev,
+				      uint64_t config,
+				      int counter_idx)
 {
-	int i;
 
-	for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
-		if ((config & 0x0FFFFFFUL) ==
-					adev->df_perfmon_config_assign_mask[i])
-			return i;
-	}
+	return ((config & 0x0FFFFFFUL) ==
+			adev->df_perfmon_config_assign_mask[counter_idx]);
 
-	return -EINVAL;
 }
 
 /* get address based on counter assignment */  static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
 				 uint64_t config,
+				 int counter_idx,
 				 int is_ctrl,
 				 uint32_t *lo_base_addr,
 				 uint32_t *hi_base_addr)
 {
-	int target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	if (target_cntr < 0)
+	if (!df_v3_6_pmc_has_counter(adev, config, counter_idx))
 		return;
 
-	switch (target_cntr) {
+	switch (counter_idx) {
 
 	case 0:
 		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo4 : smnPerfMonCtrLo4; @@ -443,15 +438,18 @@ static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
 /* get read counter address */
 static void df_v3_6_pmc_get_read_settings(struct amdgpu_device *adev,
 					  uint64_t config,
+					  int counter_idx,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr)
 {
-	df_v3_6_pmc_get_addr(adev, config, 0, lo_base_addr, hi_base_addr);
+	df_v3_6_pmc_get_addr(adev, config, counter_idx, 0, lo_base_addr,
+								hi_base_addr);
 }
 
 /* get control counter settings i.e. address and values to set */  static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint64_t config,
+					  int counter_idx,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
 					  uint32_t *lo_val,
@@ -462,7 +460,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	uint32_t eventsel, instance, unitmask;
 	uint32_t instance_10, instance_5432, instance_76;
 
-	df_v3_6_pmc_get_addr(adev, config, 1, lo_base_addr, hi_base_addr);
+	df_v3_6_pmc_get_addr(adev, config, counter_idx, 1, lo_base_addr,
+				hi_base_addr);
 
 	if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
 		DRM_ERROR("[DF PMC] addressing not retrieved! Lo: %x, Hi: %x", @@ -492,18 +491,13 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,  static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 				   uint64_t config)
 {
-	int i, target_cntr;
-
-	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	if (target_cntr >= 0)
-		return 0;
+	int i;
 
 	for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
 		if (adev->df_perfmon_config_assign_mask[i] == 0U) {
 			adev->df_perfmon_config_assign_mask[i] =
 							config & 0x0FFFFFFUL;
-			return 0;
+			return i;
 		}
 	}
 
@@ -512,59 +506,50 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 
 #define DEFERRED_ARM_MASK	(1 << 31)
 static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
-				    uint64_t config, bool is_deferred)
+				    int counter_idx, uint64_t config,
+				    bool is_deferred)
 {
-	int target_cntr;
-
-	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
 
-	if (target_cntr < 0)
+	if (!df_v3_6_pmc_has_counter(adev, config, counter_idx))
 		return -EINVAL;
 
 	if (is_deferred)
-		adev->df_perfmon_config_assign_mask[target_cntr] |=
+		adev->df_perfmon_config_assign_mask[counter_idx] |=
 							DEFERRED_ARM_MASK;
 	else
-		adev->df_perfmon_config_assign_mask[target_cntr] &=
+		adev->df_perfmon_config_assign_mask[counter_idx] &=
 							~DEFERRED_ARM_MASK;
 
 	return 0;
 }
 
 static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
+				    int counter_idx,
 				    uint64_t config)
 {
-	int target_cntr;
-
-	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	/*
-	 * we never get target_cntr < 0 since this funciton is only called in
-	 * pmc_count for now but we should check anyways.
-	 */
-	return (target_cntr >= 0 &&
-			(adev->df_perfmon_config_assign_mask[target_cntr]
-			& DEFERRED_ARM_MASK));
+	return	(df_v3_6_pmc_has_counter(adev, config, counter_idx) &&
+			(adev->df_perfmon_config_assign_mask[counter_idx]
+				& DEFERRED_ARM_MASK));
 
 }
 
 /* release performance counter */
 static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
-				     uint64_t config)
+				     uint64_t config,
+				     int counter_idx)
 {
-	int target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
-
-	if (target_cntr >= 0)
-		adev->df_perfmon_config_assign_mask[target_cntr] = 0ULL;
+	if (df_v3_6_pmc_has_counter(adev, config, counter_idx))
+		adev->df_perfmon_config_assign_mask[counter_idx] = 0ULL;
 }
 
 
 static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
-					 uint64_t config)
+					 uint64_t config,
+					 int counter_idx)
 {
 	uint32_t lo_base_addr = 0, hi_base_addr = 0;
 
-	df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
+	df_v3_6_pmc_get_read_settings(adev, config, counter_idx, 
+&lo_base_addr,
 				      &hi_base_addr);
 
 	if ((lo_base_addr == 0) || (hi_base_addr == 0)) @@ -574,7 +559,7 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,  }
 
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
-			     int is_add)
+			     int counter_idx, int is_add)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int err = 0, ret = 0;
@@ -584,10 +569,9 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
-		df_v3_6_reset_perfmon_cntr(adev, config);
-
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 					config,
+					counter_idx,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
@@ -604,7 +588,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 						     hi_val);
 
 		if (err)
-			ret = df_v3_6_pmc_set_deferred(adev, config, true);
+			ret = df_v3_6_pmc_set_deferred(adev, config,
+							counter_idx, true);
 
 		break;
 	default:
@@ -615,7 +600,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,  }
 
 static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
-			    int is_remove)
+			    int counter_idx, int is_remove)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int ret = 0;
@@ -624,6 +609,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 	case CHIP_VEGA20:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
+			counter_idx,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
@@ -635,8 +621,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 
 		if (is_remove) {
-			df_v3_6_reset_perfmon_cntr(adev, config);
-			df_v3_6_pmc_release_cntr(adev, config);
+			df_v3_6_reset_perfmon_cntr(adev, config, counter_idx);
+			df_v3_6_pmc_release_cntr(adev, config, counter_idx);
 		}
 
 		break;
@@ -649,6 +635,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 				  uint64_t config,
+				  int counter_idx,
 				  uint64_t *count)
 {
 	uint32_t lo_base_addr = 0, hi_base_addr = 0, lo_val = 0, hi_val = 0; @@ -656,14 +643,14 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
-				      &hi_base_addr);
+		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
+						&lo_base_addr, &hi_base_addr);
 
 		if ((lo_base_addr == 0) || (hi_base_addr == 0))
 			return;
 
 		/* rearm the counter or throw away count value on failure */
-		if (df_v3_6_pmc_is_deferred(adev, config)) {
+		if (df_v3_6_pmc_is_deferred(adev, config, counter_idx)) {
 			int rearm_err = df_v3_6_perfmon_arm_with_status(adev,
 							lo_base_addr, lo_val,
 							hi_base_addr, hi_val);
@@ -671,7 +658,8 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 			if (rearm_err)
 				return;
 
-			df_v3_6_pmc_set_deferred(adev, config, false);
+			df_v3_6_pmc_set_deferred(adev, config, counter_idx,
+									false);
 		}
 
 		df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7Cdd87ca2efb7547914bba08d853f80f67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637351672175311161&amp;sdata=5LsHUQogyAkmCKwgLsmuyNGsK%2BB9ng5T%2F9d45CPc%2BcA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
