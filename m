Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828ABC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 01:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1ED64E6C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 01:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1ED64E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D929C89B98;
	Mon, 15 Mar 2021 01:13:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C38D89B98
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 01:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMd6ON8X6fk8pRpzH7mpSl2BmaZsYA1rrtqVNk3YEjWyr8kMdZMsP52ohcUWxGEwCd+qsc1KTrXwQSKKReZJa54Vg36q3q6ynwpIsJduIAyLrnDCXrfa2uGQrqeyB4Y48HjgloruBroZlS5vVKhUBowsc7FZle6y/4xfZw5/t5/tGTCRGqqrrxDi49Uq7ktbofSmwEQcwVZfVX1o5/533VL7iwcusfkZQpqjAjhJPrazey06TborLDWat6lwqCnl+6xblbI+fh0Dyi4+B2y5IgX2pIPn8sLc+VQ3S7np3q5ttslwP3yt1Zmu3q2d7gSJ4YBY+KcOmE5VkzvrrViluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD6tUxVZ0Yn4DgMwyLGzNNaaQgeVP37GxHIk/0z4k8U=;
 b=IcNorladnsGHRS15xA0UoLwORAtmSFr5lZ3Ne7jc2ID6yO2KQZCsU1yhKUh8PBdwUFET3SDUaEu3YWEuNcd6whCvK23y4LTA+PsT7Dzx2xvblf9aYsv0ngzUQUgr3tcSnIzvyd9BgnwWb6Mx8GQ7i4j5jrrZA1cNNwm+VLRslx/QheR6UWyOcFffTZHDAisarKiPlF7pvjWN2FKljX3w5DML7zeqw6mwI0pCHCOKQase2t65/BLvZ2Z59Ajq5YtBYT+tbb/Wqs+rqk7bbGPRkk/Q2vv8ryFsPOSc9Q43KIfFSI7k6bcu85Up2iNNAX1C8kZy4g/++cAkJLd8BtLufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD6tUxVZ0Yn4DgMwyLGzNNaaQgeVP37GxHIk/0z4k8U=;
 b=yuitUiakHuZxYTeKn7FNkzs7u/q4t5Y+CG/gTUOJRn+el7BZtx85VgyRBVJSPlT/90Hh9i+H7dsBO3+RRS0JX2ijX9ZbW1absJnzKAQbpBgxdIXI6iMz0viRy0HYBu3TzIK1288Yskt57Pld/FK+9WFdV28whWz2oJ74yWNyCR0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 01:13:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 01:13:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add a new sysfs entry for default power limit
Thread-Topic: [PATCH] drm/amd/pm: add a new sysfs entry for default power limit
Thread-Index: AQHXGCA2TxuFx0sVOUO9RCGH7K5yRaqEQGKA
Date: Mon, 15 Mar 2021 01:13:03 +0000
Message-ID: <DM6PR12MB2619240ABF396DC1C57E5DBAE46C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210313154708.19050-1-jinhuieric.huang@amd.com>
In-Reply-To: <20210313154708.19050-1-jinhuieric.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T01:13:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=612e50e5-7719-448f-a9b6-03bfaee2fa9e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a1858a9-7322-4990-84b6-08d8e74f7c19
x-ms-traffictypediagnostic: DM6PR12MB2985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29854FD935C9935AB09B3FAEE46C9@DM6PR12MB2985.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZ/EB/G/o5BFjOBHP7DXq1yQuxh/jT00FlDHByLh987vRwLD9+BlS9IjkLbZNiWzpMYFqw8neBilnW6YqgO9EgjEX5Kpl4PcnASdg0VPjo+fNuJno58JWYJLbETxS0KE+YyKxcJ9soK9zVGJIkFDr11lZR7RM2Pc4We1YGVDcIvfvtWnHT2KjNf6oqQcjK53gnaglUD1nOshASpXiI/FByc8rGPPmenXuJ0fqHZaIZiY+XWapRLQGO/qpYtAKPrcMK1Z7GvdQnXh7UqoW284OEEPMcsI5JR1p57elW0VUKFZUn86DMNRJsVVWDzt3cda5XXfL8Xs3s7U/BbsZQGl0Qxm9u6NRmr4+GDbbvMCpA+1c7ZShEKmoXUY1fsRbYnqxMydTFVewedP7xiQgpHkNJH4uN3GwBB3wM09WN6Vy2GSDMrFMjozvEuFpUzqBTpImzWRzStN6wGosZ2Yg5P8DblUrhwrrQmMBbmsvSThRebxiQyx7aVGJ7lLzgQRWoz6iYnYc03oZ6+r41IMm2bpho+f2+g+AEogNp2FtLDDMxiDMjdlV38HguK+nkA7Uz54
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(66476007)(64756008)(66446008)(66556008)(71200400001)(66946007)(76116006)(26005)(53546011)(83380400001)(186003)(6506007)(5660300002)(86362001)(316002)(110136005)(8936002)(7696005)(30864003)(52536014)(8676002)(55016002)(2906002)(33656002)(9686003)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nNJjmZe0REEVbAAd4tiIN+EAHn5H4w6sjE3yDLNeHvinARaS+gzO4da45rEj?=
 =?us-ascii?Q?BmKT9MKbsVAm/qs/TES1FhMELzhh+GkM7btgLKsCWCKJr14WXtbZrBtTIXTp?=
 =?us-ascii?Q?TE7wpDrlEDuGODT5+nb1Q3hpVPDv1E+Uiw//Qzkc0R6RJPex9yrTqlRutQpm?=
 =?us-ascii?Q?BpP3hnah4OydY7SAvQD3NyKbIzrWdKtrNKD4syt1qzDR1QHT0nE62w7b7tyy?=
 =?us-ascii?Q?uAMCE6Mp/YcDQH7cKPC45dHUInagfuMyUVsQUOsjGZVv9PvfVXGB7PgDc/1P?=
 =?us-ascii?Q?yT1t9VAxjoHYXKZv5Cq8heAA2y9w4ybzEhf9PQwsD+SxE/rvnbcRadvn0O5e?=
 =?us-ascii?Q?wtaSsCumhYBWuYJQYjmzEne4E+K2SLTlAfjiyVs+UIZiY1ojPLxhsxKFm2iw?=
 =?us-ascii?Q?IV8RMDAK09gGdQVnBy3sGdtgO3Sz4+7Bk7sosI8l7mjhPuMsRG2+TkuDtciS?=
 =?us-ascii?Q?OkeQOb/Yvii1RsJE2XIupyWVrkK6BamSu16CaJ9cQtAogK0gT6eg9LZxjGUC?=
 =?us-ascii?Q?nOkjsbqOv7mhMgL9xUhaqAYuq335hvAabJr7jqV18shUjC/c+OfktFkz85+C?=
 =?us-ascii?Q?Nkx//B4aPZfDOUtq6qLyXCQzrpoXDJEnP5dF3ISZ0Q4j617fkWU8qz2SDL43?=
 =?us-ascii?Q?UaZ61P/hpv/fuD4OwQKmfJnKFoM/6Ns5NxzwF4pcgcjjF7KIz8YBb+iul6WS?=
 =?us-ascii?Q?vj/iAi087Rtlk8rsj9T6AiTl2nclSeb8vknk+V3KsGiOnv+EDQYHF/zmXbHt?=
 =?us-ascii?Q?7J7gKuaHdhvl6SuxvdJMVQFterIXKUHLPKaRVu8xAa4JxrV5gbSGRnc5NDNU?=
 =?us-ascii?Q?Q0t4+C2WSp4tXAqhK+lcRwF8ub+b06MYdBs92lbwx1O7tsdo6BvS0Aku6VaC?=
 =?us-ascii?Q?8l0htmTuKBCylxs2DXJlYx8wnq7JtZTmQKutKYRIlhxrI5ytvvtkb99b277x?=
 =?us-ascii?Q?8d1YBPS7nXasxqxWV0DXmkwDCceLo9J5GVtgH3so8LqSGr/bNSgfoNcFZsCS?=
 =?us-ascii?Q?8sp3+9z2qhXhcLpuhMmRCsjEhCvdYXdyVGse+W3g7WueCYjA03X2YRZMXQbw?=
 =?us-ascii?Q?BdxTVkhoEZajsrhPty/n2lzhZHVRbY7QVb5qjMfJ4mahzfvEUoiDP9Le297S?=
 =?us-ascii?Q?/145DADY/XQoN8pDu084oWdRSfibo7e7/4G258kYcOR64RE/kAv7u4gx9oNT?=
 =?us-ascii?Q?viuO3XXkACbERJXDsbgM/iKLHnj1YNXHRKEDjezxwMnlgpYN/RMnK3/JuJp3?=
 =?us-ascii?Q?xu5Wn0v1I+hGumv4sUJliaQJD1S6HNpdvLi4nGAQexp6MnDLJ/QpAtQD1rIR?=
 =?us-ascii?Q?IRG701ZCRD4w0JpnyvCxOAxO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1858a9-7322-4990-84b6-08d8e74f7c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 01:13:04.2195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J00A4Wb14xSqqEfo0rdzU2y4iHKHyEay3N+LIsqxcpx9t9uAiYRz4IC4BhPgH/BB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com> 
Sent: Saturday, March 13, 2021 11:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: add a new sysfs entry for default power limit

Driver doesn't keep the default bootup power limit and expose it to user. As requested we add it in driver.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 53 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 +++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  8 ++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +-
 11 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 79e309a789f3..dd695817c481 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -288,7 +288,8 @@ struct amd_pm_funcs {
 				uint32_t block_type, bool gate);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
-	int (*get_power_limit)(void *handle, uint32_t *limit, bool default_limit);
+	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *max_limit,
+			bool default_limit);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
 	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size); diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2733af2d201b..240bfb05ce2d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2613,6 +2613,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	uint32_t limit = limit_type << 24;
+	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
 
@@ -2629,8 +2630,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, &max_limit, true);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", max_limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
@@ -2665,7 +2667,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, NULL, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n"); @@ -2677,6 +2680,42 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	return size;
 }
 
+static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int limit_type = to_sensor_dev_attr(attr)->index;
+	uint32_t limit = limit_type << 24;
+	ssize_t size;
+	int r;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	if (is_support_sw_smu(adev)) {
+		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+	} else if (pp_funcs && pp_funcs->get_power_limit) {
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, NULL, true);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+	} else {
+		size = snprintf(buf, PAGE_SIZE, "\n");
+	}
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	return size;
+}
 static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -2919,11 +2958,13 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg,  static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);  static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);  static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
+static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, 
+amdgpu_hwmon_show_power_cap_default, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);  static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);  static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);  static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);  static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
+static SENSOR_DEVICE_ATTR(power2_cap_default, S_IRUGO, 
+amdgpu_hwmon_show_power_cap_default, NULL, 1);
 static SENSOR_DEVICE_ATTR(power2_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 1);  static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NULL, 0);  static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_label, NULL, 0); @@ -2963,11 +3004,13 @@ static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power1_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power1_cap.dev_attr.attr,
+	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power1_label.dev_attr.attr,
 	&sensor_dev_attr_power2_average.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
 	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
 	&sensor_dev_attr_power2_cap.dev_attr.attr,
+	&sensor_dev_attr_power2_cap_default.dev_attr.attr,
 	&sensor_dev_attr_power2_label.dev_attr.attr,
 	&sensor_dev_attr_freq1_input.dev_attr.attr,
 	&sensor_dev_attr_freq1_label.dev_attr.attr,
@@ -3066,7 +3109,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	      (adev->asic_type != CHIP_VANGOGH))) &&	/* not implemented yet */
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
-	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
+	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
+	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
 		return 0;
 
 	if (((adev->family == AMDGPU_FAMILY_SI) || @@ -3132,6 +3176,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		 attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
+		 attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 5ac683fd0749..25d5f03aaa67 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -171,6 +171,7 @@ enum smu_ppt_limit_level  {
 	SMU_PPT_LIMIT_MIN = -1,
 	SMU_PPT_LIMIT_CURRENT,
+	SMU_PPT_LIMIT_DEFAULT,
 	SMU_PPT_LIMIT_MAX,
 };
 
@@ -446,6 +447,7 @@ struct smu_context
 
 	bool od_enabled;
 	uint32_t current_power_limit;
+	uint32_t default_power_limit;
 	uint32_t max_power_limit;
 
 	/* soft pptable */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 907e0967a9e8..ad4db2edf1fb 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -141,6 +141,7 @@ struct smu_11_5_power_context {
 	enum smu_11_0_power_state power_state;
 
 	uint32_t	current_fast_ppt_limit;
+	uint32_t	default_fast_ppt_limit;
 	uint32_t	max_fast_ppt_limit;
 };
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index e0d288208220..ee6340c6f921 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1034,7 +1034,8 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 	return 0;
 }
 
-static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
+static int pp_get_power_limit(void *handle, uint32_t *limit,
+		uint32_t *max_limit, bool default_limit)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
@@ -1045,9 +1046,12 @@ static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
 
 	if (default_limit) {
 		*limit = hwmgr->default_power_limit;
-		if (hwmgr->od_enabled) {
-			*limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
-			*limit /= 100;
+		if (max_limit) {
+			*max_limit = *limit;
+			if (hwmgr->od_enabled) {
+				*max_limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
+				*max_limit /= 100;
+			}
 		}
 	}
 	else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1202b9e7d0f9..e722adcf2f53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2183,6 +2183,9 @@ int smu_get_power_limit(struct smu_context *smu,
 		case SMU_PPT_LIMIT_CURRENT:
 			*limit = smu->current_power_limit;
 			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*limit = smu->default_power_limit;
+			break;
 		case SMU_PPT_LIMIT_MAX:
 			*limit = smu->max_power_limit;
 			break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f82dd8a5c773..bbc03092b0a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1129,7 +1129,7 @@ static int arcturus_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 24195b5853fb..3d0de2c958fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2111,7 +2111,7 @@ static int navi10_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled &&
 	    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) { diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 94a4ea38e5f9..3621884c3293 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1736,7 +1736,7 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 
 	if (smu->od_enabled) {
 		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d9f60dc714bc..c5b387360f01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1756,7 +1756,7 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	smu->current_power_limit = ppt_limit / 1000;
+	smu->current_power_limit = smu->default_power_limit = ppt_limit / 
+1000;
 	smu->max_power_limit = 29;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit); @@ -1765,7 +1765,8 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	power_context->current_fast_ppt_limit = ppt_limit / 1000;
+	power_context->current_fast_ppt_limit =
+			power_context->default_fast_ppt_limit = ppt_limit / 1000;
 	power_context->max_fast_ppt_limit = 30;
 
 	return ret;
@@ -1790,6 +1791,9 @@ static int vangogh_get_ppt_limit(struct smu_context *smu,
 		case SMU_PPT_LIMIT_CURRENT:
 			*ppt_limit = power_context->current_fast_ppt_limit;
 			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*ppt_limit = power_context->default_fast_ppt_limit;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 740025ee7f78..3c0d6231b891 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1088,7 +1088,7 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 		power_limit = pptable->PptLimit;
 	}
 
-	smu->current_power_limit = power_limit;
+	smu->current_power_limit = smu->default_power_limit = power_limit;
 	if (pptable)
 		smu->max_power_limit = pptable->PptLimit;
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
