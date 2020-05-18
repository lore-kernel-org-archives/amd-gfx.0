Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAABC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 03:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C3B2070A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 03:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kimeaePC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C3B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CAB8930F;
	Mon, 18 May 2020 03:27:49 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8637B89199
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 03:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POT9Hr2C9t5btYKrpT4xtmi3XBzbN2JAq+VidrnN/Ul/V+5h6h3X+AvwR2g1MHneScBWPHX9XStk+Tq/6IXhEoBuPEZ0hGBeoEvZoi19MeoY1g1TfYFjl6m0iN6WiSKIs+NL6D0g5q2JUgIX03iVzA4qR9t1FxC53qk+KzCUvJmaOYfPgLivClXO65Uldcnll7UG2Jb7t7zdfgswrPeQgSejhVy3cXaF38ZWgc2YJz8A/zaOSndgJQ1vqyxZ/wBvH6VWDTfOeom3kaL6rDrcxHqhmSpMrRgVoIfPWIQj7LrDty8Z2QImHJSS1F8tswAhglDBrmlcTw8A5tOgSi3nFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVd7Bd3tMy4lw5jHO9RS4g4RA5hnTKt1oL8MvHlqp4s=;
 b=e485bgBCUM3h/Xd2unlDTAkUAH2BjGRjUna2rTfczyRp55GF8wNPbGoEm36otAS6m9setJy3IRFaqe3bBqGk2mtflG3QRJMUpffhvSCWHr2Y9UR5PNCeZ43KRxv4E9Yw4ynU3DQeX4O40lSwufZ6ZgPVaJYuxSlmcZjFnAZeppp2oa9bLUST7rGE69VPi66sJh0D9GLzJdz+PgSuKCMvrvMWhGvEpCux/9r1Ah2oGkIrrTJVbl8H3YKQH7DZ9YeFZO114hD6a7n4GwSQM7SOlcbS1yCYD7x6z3+KeCo7Bx8AFrOe4JNQhVwX5qksYnb76pxLfpjRr0sbaDomiGEtQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVd7Bd3tMy4lw5jHO9RS4g4RA5hnTKt1oL8MvHlqp4s=;
 b=kimeaePCrcaEPdOQvI9RUjSmaYTGt5CdzL8ZEZ1ujo4/EYVssNMyOI+eyqLnvxssLjLC2MTUJx7EIhtzhrtXI1450oVmdXrH49mem8R1bkySOaN8RofzWjOxnnbnuo4tb4gzLFs9X2BLFj+TflKJx7mGA22dHhf/IEZ1qoId77U=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20; Mon, 18 May 2020 03:27:45 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 03:27:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: optimize amdgpu device attribute code
Thread-Topic: [PATCH 2/4] drm/amdgpu: optimize amdgpu device attribute code
Thread-Index: AQHWJFYqCgBgZzDEKUOeGbwARgvLq6itP6Zg
Date: Mon, 18 May 2020 03:27:44 +0000
Message-ID: <DM6PR12MB40758F62303352FDA10C1F4AFCB80@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200507095704.25623-1-kevin1.wang@amd.com>
 <20200507095704.25623-2-kevin1.wang@amd.com>
In-Reply-To: <20200507095704.25623-2-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-18T03:27:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=05a7f715-c9c0-4bf7-8816-00001bfaf511;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-18T03:27:42Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fa0bfdf4-437b-4414-a017-00006478b019
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 550f6a06-e962-4dad-94ec-08d7fadb6e57
x-ms-traffictypediagnostic: DM6PR12MB2748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2748682883A350FBB3AE436EFCB80@DM6PR12MB2748.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYmwHh9GnjbrJ+zCyBRC6WfZiZpVva645GdtJm9kdCpHr0FymYVChy+gETkUUwQiSWHi+fDg6/M8ptt4fI6yuZcXb+1bgmsWpuO2DmX9RQjYUa64GO6p9HVAPxOj9Hb7vhFoc4qHocNeHe1rq78ysSeAMdKA/3XD/IWd8E4f670nqJXu8U2wsgQl0f0yB3nkbKwszY46eALhVIQK3Iif8zWJzlQpiiICTNHVy++4Vyi8b4/kOg2+9YG1BAW2rhVSHYzcdWUqstm2IyH//PDEZPGCui/dZ78j7hWuPcX+0Po+grLckqOxWqpnGbjKmBAYFblhDU+TbWutwyhF+bxLSZAWkAvCvOREV52AH2wbq9PD7EOoLlOeXm0KPQpkNkGLLYFKWARvCwhSY3Ry1LqD9/oHEyzDlKhVZ58M/yL/ztQQBbhHHhHbAqzQj2JjdZpu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(54906003)(110136005)(478600001)(316002)(8676002)(8936002)(33656002)(71200400001)(186003)(7696005)(52536014)(4326008)(30864003)(26005)(2906002)(66556008)(76116006)(66476007)(86362001)(66946007)(64756008)(55016002)(66446008)(9686003)(53546011)(6506007)(5660300002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FHMGjOQa+krjRPWNwPaAs8P36BJqc5QDMo1gxIhEihWHa+i7heCmZILv+zBEEM18uQOvpTS8I8sJU4a+TjEE/QrOP7HcoCJ3pdwU4EUsPPpV+fmzKaPwRPtNoQTJE/euBO16R3poXWEy9/zwBvIMZcFLCPP6nBCoTTVj30w/QnkwGxOxhNzXYz3eqkRDBqp4R2c1hJOkipxw8V9CqAV38q9va17kTZUw8sRPEO5fpzViy4GIznBquOhekcZIMb0F9TAnMnaiC/vgaIl1vWK4Dgk9d9Oyt32pQl1tx3xVHbbhN/b9p/DqwP0tEKAa9qHfV/aVskiqcK/nAwT8OGYlWPGc7syWw8QEG0l783DrMW3GJ5CC25kSUmUpLjARcKddImw+3YvZdL5ffra6YYKt3aj2W2tHx4KywLAUvF5CbkvAfT87fZ8bIUrH9/WPeamvR3JGrFdm5c0hwQX3cxyGjIRfnmKEYVe9L9BmTzWGCRNKG+mmT8w51bdS8t7UVJGC
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550f6a06-e962-4dad-94ec-08d7fadb6e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 03:27:45.0109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igcv6tRxQXv81bhyIi+O7LC5bKaRcPeNuS6JJSm/vqkKgPZMmh+WvPZXzOTEAcCMdpMIO+jyNfrhX1Ytjn4vMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
 Kenneth" <Kenneth.Feng@amd.com>, "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Patch #1 and #2 are

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Patch #3 and Patch #4 will rework together with Wenhui's change and submit finally.

Regards,
Hawking

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Thursday, May 7, 2020 17:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: optimize amdgpu device attribute code

unified amdgpu device attribute node functions:
1. add some helper functions to create amdgpu device attribute node.
2. create device node according to device attr flags on different VF mode.
3. rename some functions name to adapt a new interface.

v2:
1. remove ATTR_STATE_DEAD, ATTR_STATE_ALIVE enum.
2. rename callback function perform to attr_update.
3. modify some variable names

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 494 +++++++++++--------------  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h |  46 +++
 2 files changed, 262 insertions(+), 278 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index c762deb5abc7..b75362bf0742 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -154,9 +154,9 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -189,10 +189,10 @@ static ssize_t amdgpu_get_dpm_state(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -294,9 +294,9 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -332,10 +332,10 @@ static ssize_t amdgpu_get_dpm_forced_performance_level(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -873,10 +873,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -917,9 +917,9 @@ static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -1663,9 +1663,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -1699,9 +1699,9 @@ static ssize_t amdgpu_get_busy_percent(struct device *dev,
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
 	struct amdgpu_device *adev = ddev->dev_private; @@ -1790,57 +1790,174 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
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
+static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			       uint32_t mask)
+{
+	struct device_attribute *dev_attr = &attr->dev_attr;
+	const char *attr_name = dev_attr->attr.name;
+	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+	enum amd_asic_type asic_type = adev->asic_type;
+
+	if (!(attr->flags & mask)) {
+		attr->states = ATTR_STATE_UNSUPPORTED;
+		return 0;
+	}
+
+#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
+
+	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
+		if (asic_type <= CHIP_VEGA10)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
+		if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+		if (asic_type < CHIP_VEGA20)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+		if (asic_type == CHIP_ARCTURUS)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
+		attr->states = ATTR_STATE_UNSUPPORTED;
+		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
+		    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
+		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pcie_bw)) {
+		/* PCIe Perf counters won't work on APU nodes */
+		if (adev->flags & AMD_IS_APU)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(unique_id)) {
+		if (!adev->unique_id)
+			attr->states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_features)) {
+		if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
+			attr->states = ATTR_STATE_UNSUPPORTED;
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
+	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			   uint32_t mask) = default_attr_update;
+
+	BUG_ON(!attr);
+
+	attr_update = attr->attr_update ? attr_update : default_attr_update;
+
+	ret = attr_update(adev, attr, mask);
+	if (ret) {
+		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
+			name, ret);
+		return ret;
+	}
+
+	/* the attr->states maybe changed after call attr->attr_update function */
+	if (attr->states == ATTR_STATE_UNSUPPORTED)
+		return 0;
+
+	ret = device_create_file(adev->dev, dev_attr);
+	if (ret) {
+		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
+			name, ret);
+	}
+
+	attr->states = ATTR_STATE_SUPPORTED;
+
+	return ret;
+}
+
+static void amdgpu_device_attr_remove(struct amdgpu_device *adev, 
+struct amdgpu_device_attr *attr) {
+	struct device_attribute *dev_attr = &attr->dev_attr;
+
+	if (attr->states == ATTR_STATE_UNSUPPORTED)
+		return;
+
+	device_remove_file(adev->dev, dev_attr);
+
+	attr->states = ATTR_STATE_UNSUPPORTED; }
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
 				      struct device_attribute *attr, @@ -3241,8 +3358,8 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)  {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 	int ret;
+	uint32_t mask = 0;
 
 	if (adev->pm.sysfs_initialized)
 		return 0;
@@ -3260,168 +3377,25 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
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
 
@@ -3430,51 +3404,15 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
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
index 5db0ef86e84c..48e8086baf33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
@@ -30,6 +30,52 @@ struct cg_flag_name
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
+	ATTR_STATE_UNSUPPORTED = 0,
+	ATTR_STATE_SUPPORTED,
+};
+
+struct amdgpu_device_attr {
+	struct device_attribute dev_attr;
+	enum amdgpu_device_attr_flags flags;
+	enum amdgpu_device_attr_states states;
+	int (*attr_update)(struct amdgpu_device *adev,
+			   struct amdgpu_device_attr* attr,
+			   uint32_t mask);
+};
+
+#define to_amdgpu_device_attr(_dev_attr) \
+	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
+
+#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .flags = _flags,						\
+	  .states = ATTR_STATE_SUPPORTED,					\
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
