Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1968C433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 03:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C84A61A1B
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 03:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C84A61A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A04C6EC95;
	Thu, 25 Mar 2021 03:29:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9296EC95
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 03:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuJs3z2kq0EFJEXHypeY1WfeUT7SXq8U0GlC++BmMWdhKW4v5mIYcsCi3hEEkBTYyzsvKe3mal0Xnbl14G6oMIuw+2x9TAtwonL+oRL89T3QWm3bIDHVMQkV3bHDC3ULTEF6jaMvkPs27Eb791gRdy5tcYxlF70DsW/WxQhuuzmnzqjf+oYfKv3bcGJHJB/GsMtNRwfUDndznF7z46CiGPauWWyegM+Vah/+T0uWSq04H5PFCiTgAURjKQUyjSDpZ1fDe4MNPkWyqn2vbHWQGEhyuNRNldTpRKF/Jn6SjckS+5ij6p9UrGOXdH1tqVK8HcOJQ2VzaN2rKWFKCg1UpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BZ2o8N1+qyVZ9nrt0XfZE9e9ahWhG9xDgn8bFmIBUU=;
 b=nNVj5pYarNNyB4wRn1ux1L42eEV61jJnZ4tAjyXwQCcQnkOaSr9QK71G+qlcTEFyA64AxT5SITlwMOxyV9YLkX8xjxGireY0ku+iNe6sg2jSOhrRO1fVZmF8cItzXD9T/+9Dwth7+kg6nmmxFIzbJB5SseixCAB46AvKq6m+jzBKoblvNDESrYBiocbuT9gJy2XQMW8bwv1SPqqOD58SPRnm6440gtBK9G0HJ/TPeOtZuEixVaOSWOu9p9Lj+nLO/EwUl8+1V7deADfQqP3LYyF3mVgQ9TML3I2clt0Jbp6UWb2FgBRn72WpRerHw9xsmyd7D9CcCffn96anBDMJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BZ2o8N1+qyVZ9nrt0XfZE9e9ahWhG9xDgn8bFmIBUU=;
 b=Hg1BOeotdh+MlfqNgA3EKZqnXid3lgdJBQ7N4ezruppYMFR6l9ZE7kx+hnpypilLdZV29V2aTcRK3DSp85F9fHwgnASIE24xRfUVlSCtGYqNN2j5M5jKKLwN38zm8AXBssFz4diASBuRwKmjoI05jihFugtBVpc4U8QYzbWQ78U=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.26; Thu, 25 Mar 2021 03:29:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 03:29:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: bail on sysfs/debugfs queries during
 platform suspend
Thread-Topic: [PATCH] drm/amdgpu/pm: bail on sysfs/debugfs queries during
 platform suspend
Thread-Index: AQHXIPMnjZNZFWTU5ES3cJNI5k/v7aqUCzXw
Date: Thu, 25 Mar 2021 03:29:14 +0000
Message-ID: <DM6PR12MB2619A7B4E7AE97D870FC4247E4629@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210324211731.202254-1-alexander.deucher@amd.com>
In-Reply-To: <20210324211731.202254-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-25T03:29:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1da4f597-f0b7-4f75-921b-f1ea12058156;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc5f59eb-e8c3-4843-e7f1-08d8ef3e29d9
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2891B6206EC4595BE11CDC51E4629@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvTAynNk9kN8R7moOG4sNpp/bJCq8LEBx8IKVaD+vJH/m64FkrVRoy/JtDJhcN2YuhAZVYQeRIr6O2ZwJqzOJScMlxfHD1xaXD0jpkkssdDZUWDOpYlBP4lFjw/kUWmUrr/TgXPegUv7zDAozb/r/F5bAQrd1qUQf4dmE0Brk4vf3bfqy2FEn4bGL8K1xWK2MPk6D5elzZNJ9XWa+NDeLIPld2KJxe61SzqzLdXj2SwV1B/Jv7oGQ6MKgNKBrqifmloeNy/oHnrENgh3WBmfuCzPCWih9vZDhX/Wn2jdhly8rMssx3gXkTOgIHYSqr8H5Y0oY4PPG1EUOczOBLhOL0xR827KngEbvbpLPx4r2Ui77OWUN5omHkzOzhaP1QofjNb0XhPCZ9FmmPlUtta8+rQsq3UFgV8gQCPOFZJCK0Zo6hETZ78mbHlVWmFgfT3KWlP43tZB1LDtvE0D1nxE6AknmuTPP1ZkG9IB4l6OzVXOjwUsln0fZIdDJb+pBnjPKD8UqK8jf+PEkmixZZHOYIMQV6GAgiRl8EuP1OuCgoi3BRCZLXE0ZiJw6bTMbopD4OHWWF5Qd64lvSK7ghO2X8WD/19tm3Fvx39Zzm2Pc0Fdtg3GkEmO4ntmhcQom1gnxCiPoR0djx4APciEBxhARNq7ViBdv1YJ0zuNrSik7/5Ezc1Cr3jhtjeBha2545XuYZpkLBiq1k80vRvsP8gGhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(9686003)(7696005)(64756008)(66556008)(66476007)(66446008)(66946007)(76116006)(4326008)(966005)(55016002)(86362001)(71200400001)(83380400001)(110136005)(316002)(8936002)(33656002)(8676002)(30864003)(26005)(45080400002)(186003)(2906002)(52536014)(5660300002)(38100700001)(53546011)(15650500001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WnNSt62jvLLqw8F+vIhmjy8Ve6VOIzKStfoAZlvVuxPA5zdKxslQepdLEJJ9?=
 =?us-ascii?Q?A/58ltPfyeIPocqkO2EPMMyRowcy8AaYugxI+zXK3q8cc4rpw2+LkziGR4YN?=
 =?us-ascii?Q?YjP9ym+p/sdahe7fcY2Japz9Ny0+XpviTFJcDNWZDUGev6EbZ8jYc2BAJFIy?=
 =?us-ascii?Q?khIJuTjQi0DawmWqBuRTezf1cm8buXHeUrZT2HdWte/4Xpn2hJodU1V24mKT?=
 =?us-ascii?Q?i2RrG97pZSKymNAJSyC5x5oBwO1sMZNPJtYByT0I14pZGjaOqGr7ZjaH8EEE?=
 =?us-ascii?Q?m2mrt5BDt6d9KdBcZVXfZmITzVqn6vT2nHkHMnpYNnbwM95OAz+wC026XCmz?=
 =?us-ascii?Q?L0QSodIqg/DpcyH7uJggQySutfX0X+d2KWscjIq9yMkd6uPurHGXHRNm0w38?=
 =?us-ascii?Q?jGskV8f5N6EgdVcJ7c/em9VV8MbeZIeP1pSD54BidrxF4HhadKYVh4ePQmD0?=
 =?us-ascii?Q?GWcrPcyvSRceGhjRl+HijVZmj0Yn3KRaFF/r/O5C/x18Eg3uSb1ZyHhXS5nZ?=
 =?us-ascii?Q?L2r3d5QM1VFZazXZcvQJt5dYCx1FciCqgeoq4tNQOpGEFJXyut6tdRw7wLQw?=
 =?us-ascii?Q?fqvKn0mtZ6B5ssIXL5RQs2w+7ZdJXbVt/MrZTnqMhfpj+gZ/uK8r3rHbs8VL?=
 =?us-ascii?Q?ri46kLYMuI8FY88gzZdB8CbN9riH9T8kktettLkilQvsSMJxSpDdcTRzblZo?=
 =?us-ascii?Q?ISdkmlIlK0R48BJuUeSjLY9BIe/XD2PO7b2OHZP0sYO/ku97g3hqYTj6IeQ3?=
 =?us-ascii?Q?o4PbCDEx5ymVTKM0yc1Hdy+A9EeU9aYrNRJ2ojaNbruCv4vLRtqPc7yHCZZl?=
 =?us-ascii?Q?Cjd8p78QHz+HF++d8JpbYf/TrQ4RG5mmpF6KKiy73/pWC5N3I+B3bImSgnaZ?=
 =?us-ascii?Q?URNjVon2tioqxAJMmIiEWyO13VAPaRxUnXDBAMmsoVWpbsbmvgUXpU0dyNg8?=
 =?us-ascii?Q?7nxsR8VHviVpMJbRt5VwLrgB6OMkJtve6YxZFKEcQ+nNRawYtYLyOY/lYpN/?=
 =?us-ascii?Q?J1XAxAkI1fHwWQtuK1g/3NABno/AIRv5EMWAKII36PDvxC0FOF3tTzt6O//I?=
 =?us-ascii?Q?hFiRl8Vq/wWdxNqsy+2uS5Qy4PfmJeoDprrapiVGG6cNIR048mezdrntiL9D?=
 =?us-ascii?Q?HTugQ8hkQ4u+q9FkMXK4W1Ad9sP8A7gNAxTWzVqv8sf6cUjt1Ai02mwh66Nt?=
 =?us-ascii?Q?vT6NrQJUf4ZnHKKvKOmws0LhITGP1Hxp5F2l2A7k/BlktbVFaitWwlQXvAVH?=
 =?us-ascii?Q?7x47EeB7UdNuoR1c8iXSdK+jNiFlQ/VPBe6iU201RZjMOnpxi9aX1z02yIQe?=
 =?us-ascii?Q?OOXvvo0ra0djjXQ31HxajUtw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5f59eb-e8c3-4843-e7f1-08d8ef3e29d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 03:29:14.0723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FT03dvuhltE8G8lrrVbvidNULGcDZsJU5JtEFfCsUeqh2SDlc+vWY5ren7MXi75
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Maybe we can have an API like is_hw_access_blocked(). So that we can put all those checks below within it.
	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
Anyway, patch is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, March 25, 2021 5:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: bail on sysfs/debugfs queries during platform suspend

The GPU is in the process of being shutdown.  Spurious queries during
suspend and resume can put the SMU into a bad state.  Runtime PM is
handled dynamically so we check if we are in non-runtime suspend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2627870a786e..3c1b5483688b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -129,6 +129,8 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -162,6 +164,8 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
@@ -268,6 +272,8 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -310,6 +316,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
@@ -408,6 +416,8 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -448,6 +458,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -484,6 +496,8 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
@@ -504,6 +518,8 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
@@ -564,6 +580,8 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -602,6 +620,8 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -764,6 +784,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (count > 127)
 		return -EINVAL;
@@ -865,6 +887,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -916,6 +940,8 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
@@ -959,6 +985,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1018,6 +1046,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1083,6 +1113,8 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
@@ -1239,6 +1271,8 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1269,6 +1303,8 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
 
@@ -1312,6 +1348,8 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1342,6 +1380,8 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
 
@@ -1405,6 +1445,8 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1443,6 +1485,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
@@ -1506,6 +1550,8 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0) {
@@ -1544,6 +1590,8 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0) {
@@ -1587,6 +1635,8 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
 		return -ENODATA;
@@ -1628,6 +1678,8 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
@@ -1726,6 +1778,8 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1954,6 +2008,8 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (channel >= PP_TEMP_MAX)
 		return -EINVAL;
@@ -2090,6 +2146,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (ret < 0) {
@@ -2122,6 +2180,8 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
 	if (err)
@@ -2172,6 +2232,8 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2220,6 +2282,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2253,6 +2317,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2285,6 +2351,8 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2315,6 +2383,8 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2344,6 +2414,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2376,6 +2448,8 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2422,6 +2496,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (ret < 0) {
@@ -2455,6 +2531,8 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
 	if (err)
@@ -2496,6 +2574,8 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2533,6 +2613,8 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	/* only APUs have vddnb */
 	if  (!(adev->flags & AMD_IS_APU))
@@ -2575,6 +2657,8 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2619,6 +2703,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2656,6 +2742,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2693,6 +2781,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2739,6 +2829,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -2780,6 +2872,8 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2817,6 +2911,8 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -3390,6 +3486,8 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C10fb3758054344e3d40008d8ef0a48f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637522174749609177%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Fry%2B5pICeZfl7ShJHxquw7pBmXYCLaiyeu2LzyPVS7I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
