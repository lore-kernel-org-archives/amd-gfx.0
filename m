Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D25C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACCE206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vo250oV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACCE206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEECC6E842;
	Wed,  6 May 2020 09:26:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38C76E842
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 09:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8XFCOKeCGdU+/gxvqzXpjcNvQS7uuqotc/SmuoYnAnY8Vq0Ck1H1G96Xzc4mr7l5n6lohvE4MzoekaAwnHpDi2DyWJYqrg+0fc28b2ubegPXU7T26+AHY0UoYfeorGiYY185metGt1RZGyACA57FlrCbEj4t+D/iceVgYYcEUE9saKJlWZlC8CYrfnUA+vKbhUpO3HBIduQLe/PC0hCxHuVscJLaFC1exWCdyT4pE2edtriF6NmcLx8iCrzG1I1qFJ7SXpCw9eoqFYOkOB0cXwRhyL50ExNFXHAdk4yIiE7vsXdVmlGS8EgU24j2g4LjKDBHXnrdCritLeJDEkJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvA5padSvz7zjI8ryD/TebihSOlGp12eIbXT0EXnDAI=;
 b=DIACrW7Zv0QYRKa0DtFsqc9bLxM3XVf6ofUoyzdh6nXm3FnhSjPovawIpuxdMXrDTLNZQ2oseivhktomNqUOpJJ31PdfMbbndQeUw6YtyqQULdC+YQvoQ5TjCWOHKcZFQ6UA5+E1/1PFkkbCm1fyyYn5Eg8ZFHW+9dMBGf8cLdJr8jd4yulqxZCCXpCEju7nFimvdRpfMwA7j0SXUXDlUMs32HFdLsgmYmGp4+cLkORDXe97shlcbd69KqJuGnb3Si18pK7ZccZ8BAK5rJUMHAZKTWa4ysVlnDkGFa4mmXWLhKEhfsvgdOZD++JBm1/+Fs6OL/PRzmDLXZP4gtAvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvA5padSvz7zjI8ryD/TebihSOlGp12eIbXT0EXnDAI=;
 b=vo250oV+RAjadmvXrKQvQTx7ehFavEQ8GQJLGuBA5hVvyvmlGmj4T42+z9W7W5AcFZak9k0yc6Ezf5OgnMYrQCO+f+3wPFAtnibEWGA1IGd20nQc0hveT291iXR3GoW7P5jUPhNwA11i4uDzKCFhX0CxgiKBeNwe2vvHjm/5guk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Wed, 6 May 2020 09:26:25 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:26:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code
Thread-Index: AQHWI27hGa8itWkfI0KPOG9OlMPn+KiawXKg
Date: Wed, 6 May 2020 09:26:25 +0000
Message-ID: <DM6PR12MB4075C26C1CB012FA4ABBF497FCA40@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200506062314.16040-1-kevin1.wang@amd.com>
 <20200506062314.16040-2-kevin1.wang@amd.com>
In-Reply-To: <20200506062314.16040-2-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T09:26:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=909e5c34-4466-4bd9-8ac4-00002ace5112;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-06T09:26:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0523ccd0-a7ad-42de-b4c9-0000cde13f7f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0ab3b05-067b-4b54-49da-08d7f19f8c58
x-ms-traffictypediagnostic: DM6PR12MB4516:|DM6PR12MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4516008A6AA6F8597F4DA5A6FCA40@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xdlryik7HDwX+wYRr3Xw3xu7EtFFpODnltfJcyZkTxKPFzlFBhC60xb6TvZdwTcYEknc7cR5R0bYjCj79wXqC9PnHLvnU0rHQlj+uK/LdL69DbCKqD7t2opqJ++bxfxvd5YKIeLGYVqIUYjrYF9HiYI1UuzaTB3R+MsZv3R/E2G0vnLQ0kQGQDQhhbh5Uip8EfuAOo4PNGtYjlT08FrCHTR7LeaxHzMgrglJwQhV587MZ3JdE0cdzY/pazQptTnD6wDAj4Qcx8sqA+rxnAx6m1p8p6oRnGL/pxAyLobK3rOoZZcYgKt8rUp0ZcmOMenCHLc5Hi4ID0Y8Ws3pb+1FWuUACg79GrITfkDIMj3veBbNP0aLb17O1XFhb1pZMQbitiuKctQl0vVrZNiPC37HAzU2XCC9BZ7HL+3iInCZjLhB52mdWGEUYR/2hy3b79zLziQdrCH+T7n7Gdfa+Ij9u0/5P7SPt1gwXUP9xUjk939kMG1TsnMVVWJPu9BQ3GrVoj7L2yBtpK1Kpk9QhxAJseNONwi3gIFq3DUvv0pllU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(33430700001)(30864003)(76116006)(6506007)(66946007)(66446008)(66476007)(64756008)(2906002)(66556008)(71200400001)(53546011)(4326008)(186003)(33440700001)(5660300002)(55016002)(8936002)(52536014)(54906003)(9686003)(33656002)(110136005)(498600001)(86362001)(26005)(7696005)(8676002)(21314003)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 55XKp6d2+RBSe9u+ERqFtKfRphZXugbSuMpJJ23Zcq4mOMxKtUm0BmJ63djZBn4McnXppsg5gntdCDPVkrgz0HX9BrWKxze9G1RZG42UESt/0xMAgb711ZrwD8ntF0+7SKA4p0/sGR9T4ykp1kmVn+g0Tm2WdIAvQWUUtthD8Z0AhYcWTB9b8xOkq4gHYAc2xysDOpddjqYJUQG3D+e8eypeg7+5gqTeK5y8ZfBXbzhCTIl/HSonrlSXAtfCQERe61MlYF1ChUjySIqkTNAzxFDzD7Qt7Zuidyv3JkP/ElIOHIVC2Ycezgs9imZrunmnyTwEW+kooSORDAVggEInikPG0++qAXXPDQD7gTAz1L9PIZq+eiz5nHJeg7F/MDn+AhyKJdaexCijYyJgIhmLaYJMcFmmQqWJPv1RzQDfTVd4nkIAX8+Yl9+pd0qttiYqLWStA2TECz6om8l+KSkM8Zawfo9i4USv8LGR0hc9YvU0r1+N8kPKoY/psgSJEdUXh2NRRtrt9apme/+KdEMZzZ090pfvMpAbdg31/TUEnc32iRIc3ZbSx37+x2z5FDYEGXUM+hEn3T4soOTocFp29FyVc2iTGla7wLTTExNypSeecYRIJfp1pQVVfTrVjMBscopHUB6c17c9r42hD1YGkWHzTCiUiiKnnagj/giTFrhojWdCGJ3sMDf6Z4Vk+esqj4QDgaTz5fF6U9fs3gnC1z4eVVUqTuZWALCOV6twQWpCVVb/tjkMOqleVwcm56pEaRe7KP9/Rm/LnKoqovMMdx1G+lPMqv1ytJn2w36vBag=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ab3b05-067b-4b54-49da-08d7f19f8c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 09:26:25.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbyE0xKeRAUK1j6r7GGRCauO6Dbs9bA0RVtwedfPce3DzMuO3IOKiU7Olax06FJufzfEswo6Xkxe+1XAykXnGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Kelvin,

Thanks for the series that remove the duplicated one_vf mode check in all the amdgpu_dpm functions.

Can we split the patch into two? One for amdgpu device sysfs attr code refine, with the new dev_attr structures, the other for retiring all the unnecessary one_vf mode support.

+enum amdgpu_device_attr_states {
+	ATTR_STATE_UNSUPPORT = 0,
+	ATTR_STATE_SUPPORT,
+	ATTR_STATE_DEAD,
+	ATTR_STATE_ALIVE,
+};
+
The attr_states seems unnecessary to me. You need a flag to mark whether a particular attribute is supported by specific ASIC or not, right? Then just a bool variable should be good enough for this purpose, Like attr->supported. I' d like to understand the use case for DEAD and ALIVE. Accordingly, you can simplify the logic that only remove the supported ones.

If we have to introduce more complicated flags to indicate different status, I'd prefer to go directly to initialize one_vf mode attr sets and bare-metal attr sets directly.

In addition, the function naming like default_attr_perform also confusing me. Would it be the function that used to update attr status? 
+static int default_attr_perform(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+				uint32_t mask)

Regards,
Hawking

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Wednesday, May 6, 2020 14:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: optimize amdgpu device attribute code

unified amdgpu device attribute node functions:
1. add some helper functions to create amdgpu device attribute node.
2. create device node according to device attr flags on different VF mode.
3. rename some functions name to adapt a new interface.
4. remove unneccessary virt mode check in inernal functions (xxx_show, xxx_store).

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 577 ++++++++++---------------  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h |  48 ++
 2 files changed, 271 insertions(+), 354 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index c762deb5abc7..367ac79418b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -154,18 +154,15 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
  *
  */
 
-static ssize_t amdgpu_get_dpm_state(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -189,19 +186,16 @@ static ssize_t amdgpu_get_dpm_state(struct device *dev,
 			(pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");  }
 
-static ssize_t amdgpu_set_dpm_state(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t count)
+static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (strncmp("balanced", buf, strlen("balanced")) == 0) @@ -294,18 +288,15 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
  *
  */
 
-static ssize_t amdgpu_get_dpm_forced_performance_level(struct device *dev,
-						struct device_attribute *attr,
-								char *buf)
+static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
+							    struct device_attribute *attr,
+							    char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -332,10 +323,10 @@ static ssize_t amdgpu_get_dpm_forced_performance_level(struct device *dev,
 			"unknown");
 }
 
-static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
-						       struct device_attribute *attr,
-						       const char *buf,
-						       size_t count)
+static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
+							    struct device_attribute *attr,
+							    const char *buf,
+							    size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private; @@ -343,9 +334,6 @@ static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	} else if (strncmp("high", buf, strlen("high")) == 0) { @@ -475,9 +463,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -514,9 +499,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
@@ -534,9 +516,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
 	else if (is_support_sw_smu(adev))
@@ -592,9 +571,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -634,9 +610,6 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -873,10 +846,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
  * the corresponding bit from original ppfeature masks and input the
  * new ppfeature masks.
  */
-static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
+static ssize_t amdgpu_set_pp_features(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private; @@ -917,9 +890,9 @@ static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
 	return count;
 }
 
-static ssize_t amdgpu_get_pp_feature_status(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t amdgpu_get_pp_features(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private; @@ -985,9 +958,6 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1051,9 +1021,6 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1085,9 +1052,6 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1115,9 +1079,6 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-			return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1149,9 +1110,6 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1179,9 +1137,6 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1215,9 +1170,6 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1245,9 +1197,6 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1347,9 +1296,6 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1377,9 +1323,6 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1571,9 +1514,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1615,9 +1555,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (count < 2 || count > 127)
 			return -EINVAL;
@@ -1663,17 +1600,14 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
  * The SMU firmware computes a percentage of load based on the
  * aggregate activity level in the IP cores.
  */
-static ssize_t amdgpu_get_busy_percent(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1699,17 +1633,14 @@ static ssize_t amdgpu_get_busy_percent(struct device *dev,
  * The SMU firmware computes a percentage of load based on the
  * aggregate activity level in the IP cores.
  */
-static ssize_t amdgpu_get_memory_busy_percent(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1748,9 +1679,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0, count1;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1781,66 +1709,186 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
 
 	return 0;
 }
 
-static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, amdgpu_get_dpm_state, amdgpu_set_dpm_state); -static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
-		   amdgpu_get_dpm_forced_performance_level,
-		   amdgpu_set_dpm_forced_performance_level);
-static DEVICE_ATTR(pp_num_states, S_IRUGO, amdgpu_get_pp_num_states, NULL); -static DEVICE_ATTR(pp_cur_state, S_IRUGO, amdgpu_get_pp_cur_state, NULL); -static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_force_state,
-		amdgpu_set_pp_force_state);
-static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_table,
-		amdgpu_set_pp_table);
-static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_dpm_sclk,
-		amdgpu_set_pp_dpm_sclk);
-static DEVICE_ATTR(pp_dpm_mclk, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_dpm_mclk,
-		amdgpu_set_pp_dpm_mclk);
-static DEVICE_ATTR(pp_dpm_socclk, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_dpm_socclk,
-		amdgpu_set_pp_dpm_socclk);
-static DEVICE_ATTR(pp_dpm_fclk, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_dpm_fclk,
-		amdgpu_set_pp_dpm_fclk);
-static DEVICE_ATTR(pp_dpm_dcefclk, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_dpm_dcefclk,
-		amdgpu_set_pp_dpm_dcefclk);
-static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_dpm_pcie,
-		amdgpu_set_pp_dpm_pcie);
-static DEVICE_ATTR(pp_sclk_od, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_sclk_od,
-		amdgpu_set_pp_sclk_od);
-static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_mclk_od,
-		amdgpu_set_pp_mclk_od);
-static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_power_profile_mode,
-		amdgpu_set_pp_power_profile_mode);
-static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_od_clk_voltage,
-		amdgpu_set_pp_od_clk_voltage);
-static DEVICE_ATTR(gpu_busy_percent, S_IRUGO,
-		amdgpu_get_busy_percent, NULL);
-static DEVICE_ATTR(mem_busy_percent, S_IRUGO,
-		amdgpu_get_memory_busy_percent, NULL);
-static DEVICE_ATTR(pcie_bw, S_IRUGO, amdgpu_get_pcie_bw, NULL); -static DEVICE_ATTR(pp_features, S_IRUGO | S_IWUSR,
-		amdgpu_get_pp_feature_status,
-		amdgpu_set_pp_feature_status);
-static DEVICE_ATTR(unique_id, S_IRUGO, amdgpu_get_unique_id, NULL);
+static struct amdgpu_device_attr amdgpu_device_attrs[] = {
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC),
+};
+
+static int default_attr_perform(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+				uint32_t mask)
+{
+	struct device_attribute *dev_attr = &attr->dev_attr;
+	const char *attr_name = dev_attr->attr.name;
+	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+	enum amd_asic_type asic_type = adev->asic_type;
+
+	if (!(attr->flags & mask)) {
+		attr->states = ATTR_STATE_UNSUPPORT;
+		return 0;
+	}
+
+#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
+
+	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
+		if (asic_type <= CHIP_VEGA10)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
+		if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+		if (asic_type < CHIP_VEGA20)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+		if (asic_type == CHIP_ARCTURUS)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
+		attr->states = ATTR_STATE_UNSUPPORT;
+		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
+		    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
+		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(pcie_bw)) {
+		/* PCIe Perf counters won't work on APU nodes */
+		if (adev->flags & AMD_IS_APU)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(unique_id)) {
+		if (!adev->unique_id)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	} else if (DEVICE_ATTR_IS(pp_features)) {
+		if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
+			attr->states = ATTR_STATE_UNSUPPORT;
+	}
+
+	if (asic_type == CHIP_ARCTURUS) {
+		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
+		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
+		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+	}
+
+#undef DEVICE_ATTR_IS
+
+	return 0;
+}
+
+
+static int amdgpu_device_attr_create(struct amdgpu_device *adev,
+				     struct amdgpu_device_attr *attr,
+				     uint32_t mask)
+{
+	int ret = 0;
+	struct device_attribute *dev_attr = &attr->dev_attr;
+	const char *name = dev_attr->attr.name;
+	int (*attr_perform)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			    uint32_t mask) = default_attr_perform;
+
+	BUG_ON(!attr);
+
+	if (attr->states == ATTR_STATE_UNSUPPORT ||
+	    attr->states == ATTR_STATE_ALIVE)
+		return 0;
+
+	if (attr->perform) {
+		attr_perform = attr->perform;
+	}
+
+	ret = attr_perform(adev, attr, mask);
+	if (ret) {
+		dev_err(adev->dev, "failed to perform device file %s, ret = %d\n",
+			name, ret);
+		return ret;
+	}
+
+	/* the attr->states maybe changed after call attr->perform function */
+	if (attr->states == ATTR_STATE_UNSUPPORT)
+		return 0;
+
+	ret = device_create_file(adev->dev, dev_attr);
+	if (ret) {
+		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
+			name, ret);
+	}
+
+	attr->states = ATTR_STATE_ALIVE;
+
+	return ret;
+}
+
+static void amdgpu_device_attr_remove(struct amdgpu_device *adev, 
+struct amdgpu_device_attr *attr) {
+	struct device_attribute *dev_attr = &attr->dev_attr;
+
+	if (attr->states != ATTR_STATE_ALIVE)
+		return;
+
+	device_remove_file(adev->dev, dev_attr);
+
+	attr->states = ATTR_STATE_DEAD;
+}
+
+static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
+					    struct amdgpu_device_attr *attrs,
+					    uint32_t counts,
+					    uint32_t mask)
+{
+	int ret = 0;
+	uint32_t i = 0;
+
+	for (i = 0; i < counts; i++) {
+		ret = amdgpu_device_attr_create(adev, &attrs[i], mask);
+		if (ret)
+			goto failed;
+	}
+
+	return 0;
+
+failed:
+	for (; i > 0; i--) {
+		amdgpu_device_attr_remove(adev, &attrs[i]);
+	}
+
+	return ret;
+}
+
+static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
+					     struct amdgpu_device_attr *attrs,
+					     uint32_t counts)
+{
+	uint32_t i = 0;
+
+	for (i = 0; i < counts; i++)
+		amdgpu_device_attr_remove(adev, &attrs[i]); }
 
 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 				      struct device_attribute *attr, @@ -2790,7 +2838,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	umode_t effective_mode = attr->mode;
 
 	/* under multi-vf mode, the hwmon attributes are all not supported */
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_virt_get_sriov_vf_mode(adev) == SRIOV_VF_MODE_MULTI_VF)
 		return 0;
 
 	/* there is no fan under pp one vf mode */ @@ -3241,8 +3289,8 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)  {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 	int ret;
+	uint32_t mask = 0;
 
 	if (adev->pm.sysfs_initialized)
 		return 0;
@@ -3260,168 +3308,25 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	ret = device_create_file(adev->dev, &dev_attr_power_dpm_state);
-	if (ret) {
-		DRM_ERROR("failed to create device file for dpm state\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
-	if (ret) {
-		DRM_ERROR("failed to create device file for dpm state\n");
-		return ret;
-	}
-
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_num_states\n");
-			return ret;
-		}
-		ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_cur_state\n");
-			return ret;
-		}
-		ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_force_state\n");
-			return ret;
-		}
-		ret = device_create_file(adev->dev, &dev_attr_pp_table);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_table\n");
-			return ret;
-		}
-	}
-
-	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_dpm_sclk\n");
-		return ret;
-	}
-
-	/* Arcturus does not support standalone mclk/socclk/fclk level setting */
-	if (adev->asic_type == CHIP_ARCTURUS) {
-		dev_attr_pp_dpm_mclk.attr.mode &= ~S_IWUGO;
-		dev_attr_pp_dpm_mclk.store = NULL;
-
-		dev_attr_pp_dpm_socclk.attr.mode &= ~S_IWUGO;
-		dev_attr_pp_dpm_socclk.store = NULL;
-
-		dev_attr_pp_dpm_fclk.attr.mode &= ~S_IWUGO;
-		dev_attr_pp_dpm_fclk.store = NULL;
-	}
-
-	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_dpm_mclk\n");
-		return ret;
-	}
-	if (adev->asic_type >= CHIP_VEGA10) {
-		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_socclk);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_dpm_socclk\n");
-			return ret;
-		}
-		if (adev->asic_type != CHIP_ARCTURUS) {
-			ret = device_create_file(adev->dev, &dev_attr_pp_dpm_dcefclk);
-			if (ret) {
-				DRM_ERROR("failed to create device file pp_dpm_dcefclk\n");
-				return ret;
-			}
-		}
-	}
-	if (adev->asic_type >= CHIP_VEGA20) {
-		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_fclk);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_dpm_fclk\n");
-			return ret;
-		}
-	}
-
-	/* the reset are not needed for SRIOV one vf mode */
-	if (amdgpu_sriov_vf(adev)) {
-		adev->pm.sysfs_initialized = true;
-		return ret;
+	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
+	case SRIOV_VF_MODE_ONE_VF:
+		mask = ATTR_FLAG_ONEVF;
+		break;
+	case SRIOV_VF_MODE_MULTI_VF:
+		mask = 0;
+		break;
+	case SRIOV_VF_MODE_BARE_METAL:
+	default:
+		mask = ATTR_FLAG_MASK_ALL;
+		break;
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_pcie);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_dpm_pcie\n");
-			return ret;
-		}
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_sclk_od);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_sclk_od\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_mclk_od);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_mclk_od\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev,
-			&dev_attr_pp_power_profile_mode);
-	if (ret) {
-		DRM_ERROR("failed to create device file	"
-				"pp_power_profile_mode\n");
-		return ret;
-	}
-	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-	    (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
-		ret = device_create_file(adev->dev,
-				&dev_attr_pp_od_clk_voltage);
-		if (ret) {
-			DRM_ERROR("failed to create device file	"
-					"pp_od_clk_voltage\n");
-			return ret;
-		}
-	}
-	ret = device_create_file(adev->dev,
-			&dev_attr_gpu_busy_percent);
-	if (ret) {
-		DRM_ERROR("failed to create device file	"
-				"gpu_busy_level\n");
-		return ret;
-	}
-	/* APU does not have its own dedicated memory */
-	if (!(adev->flags & AMD_IS_APU) &&
-	     (adev->asic_type != CHIP_VEGA10)) {
-		ret = device_create_file(adev->dev,
-				&dev_attr_mem_busy_percent);
-		if (ret) {
-			DRM_ERROR("failed to create device file	"
-					"mem_busy_percent\n");
-			return ret;
-		}
-	}
-	/* PCIe Perf counters won't work on APU nodes */
-	if (!(adev->flags & AMD_IS_APU)) {
-		ret = device_create_file(adev->dev, &dev_attr_pcie_bw);
-		if (ret) {
-			DRM_ERROR("failed to create device file pcie_bw\n");
-			return ret;
-		}
-	}
-	if (adev->unique_id)
-		ret = device_create_file(adev->dev, &dev_attr_unique_id);
-	if (ret) {
-		DRM_ERROR("failed to create device file unique_id\n");
+	ret = amdgpu_device_attr_create_groups(adev,
+					       amdgpu_device_attrs,
+					       ARRAY_SIZE(amdgpu_device_attrs),
+					       mask);
+	if (ret)
 		return ret;
-	}
-
-	if ((adev->asic_type >= CHIP_VEGA10) &&
-	    !(adev->flags & AMD_IS_APU)) {
-		ret = device_create_file(adev->dev,
-				&dev_attr_pp_features);
-		if (ret) {
-			DRM_ERROR("failed to create device file	"
-					"pp_features\n");
-			return ret;
-		}
-	}
 
 	adev->pm.sysfs_initialized = true;
 
@@ -3430,51 +3335,15 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)  {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-
 	if (adev->pm.dpm_enabled == 0)
 		return;
 
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
-	device_remove_file(adev->dev, &dev_attr_power_dpm_state);
-	device_remove_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
-
-	device_remove_file(adev->dev, &dev_attr_pp_num_states);
-	device_remove_file(adev->dev, &dev_attr_pp_cur_state);
-	device_remove_file(adev->dev, &dev_attr_pp_force_state);
-	device_remove_file(adev->dev, &dev_attr_pp_table);
-
-	device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
-	device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
-	if (adev->asic_type >= CHIP_VEGA10) {
-		device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
-		if (adev->asic_type != CHIP_ARCTURUS)
-			device_remove_file(adev->dev, &dev_attr_pp_dpm_dcefclk);
-	}
-	if (adev->asic_type != CHIP_ARCTURUS)
-		device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
-	if (adev->asic_type >= CHIP_VEGA20)
-		device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
-	device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
-	device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
-	device_remove_file(adev->dev,
-			&dev_attr_pp_power_profile_mode);
-	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-	    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		device_remove_file(adev->dev,
-				&dev_attr_pp_od_clk_voltage);
-	device_remove_file(adev->dev, &dev_attr_gpu_busy_percent);
-	if (!(adev->flags & AMD_IS_APU) &&
-	     (adev->asic_type != CHIP_VEGA10))
-		device_remove_file(adev->dev, &dev_attr_mem_busy_percent);
-	if (!(adev->flags & AMD_IS_APU))
-		device_remove_file(adev->dev, &dev_attr_pcie_bw);
-	if (adev->unique_id)
-		device_remove_file(adev->dev, &dev_attr_unique_id);
-	if ((adev->asic_type >= CHIP_VEGA10) &&
-	    !(adev->flags & AMD_IS_APU))
-		device_remove_file(adev->dev, &dev_attr_pp_features);
+
+	amdgpu_device_attr_remove_groups(adev,
+					 amdgpu_device_attrs,
+					 ARRAY_SIZE(amdgpu_device_attrs));
 }
 
 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
index 5db0ef86e84c..5ca5f3f9e8c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
@@ -30,6 +30,54 @@ struct cg_flag_name
 	const char *name;
 };
 
+enum amdgpu_device_attr_flags {
+	ATTR_FLAG_BASIC = (1 << 0),
+	ATTR_FLAG_ONEVF = (1 << 16),
+};
+
+#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
+#define ATTR_FLAG_MODE_MASK	(0xffff0000)
+#define ATTR_FLAG_MASK_ALL	(0xffffffff)
+
+enum amdgpu_device_attr_states {
+	ATTR_STATE_UNSUPPORT = 0,
+	ATTR_STATE_SUPPORT,
+	ATTR_STATE_DEAD,
+	ATTR_STATE_ALIVE,
+};
+
+struct amdgpu_device_attr {
+	struct device_attribute dev_attr;
+	enum amdgpu_device_attr_flags flags;
+	enum amdgpu_device_attr_states states;
+	int (*perform)(struct amdgpu_device *adev,
+		       struct amdgpu_device_attr* attr,
+		       uint32_t mask);
+};
+
+#define to_amdgpu_device_attr(_dev_attr) \
+	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
+
+#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .flags = _flags,						\
+	  .states = ATTR_STATE_SUPPORT,					\
+	  ##__VA_ARGS__, }
+
+#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
+	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
+			     amdgpu_get_##_name, amdgpu_set_##_name,	\
+			     _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
+	AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,			\
+			   _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
+	__AMDGPU_DEVICE_ATTR(_name, S_IRUGO,				\
+			     amdgpu_get_##_name, NULL,			\
+			     _flags, ##__VA_ARGS__)
+
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);  int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);  int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
