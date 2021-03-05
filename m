Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29535C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 05:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D861A65005
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 05:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D861A65005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A3B6EAD2;
	Fri,  5 Mar 2021 05:38:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABF66EAD2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 05:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX98ioApEi0CKGkwS2JgVsEDqHUZ3DZxYtDzSLmLVP5xJpRyjFl55Nk/TukpOthZoH2921iZuKx4ZmZinzUHKNnK8sK236A0vA+eth7fDxPxTkGIxJD+TdW8cHJMmae4UX5rGDUJBrH1d8bgznFp6pwv8PjwqgExE5EvMdILVpunJcgb8ApiKGrPLgm3Edo8O5cF3wTdRCIM0sjTNqDRCpRSAKOKLh4FTzYWNI1nq2xTg1BAtGRWV4uQBzJiGJjwFRW39y11s7Ev/GK1y8EJ2lm6kT3w4J5/Cg530zNx7KEUeEVK8fzxcVl7NADzTz1SslB7gxbhmV63+BP1sEX9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJkKoj8znifwm8CLwEeMH8zuKoNX6fFDdo3YCehtUuE=;
 b=WLQoO1H/i2YbcMxo+m75GKsk78O4YmtnQrhuCXI5sV9RBLiudt/2dQEoECG02dyomhc76EpStiAv1om0jSCbe2nYzv36WItKVu3tG0H33KXABcQSwfsRrnsXVJq/W7+0lf+F431LjilASaDQYJd0gy5GsncmDiHM8jF+jXT9yarp34POEfGlI4DAAkoLxW56H1uPpWhQDs8Wli210l4j3jGcLkvWj3clqcxZ7e9VsHnNZbceCiOSeEjWhI5HFHYT/yBuGduwXqWKANNEqgA/adD+RFt2D//UyE4r/LwT9dLw9s+kFPtabLYARzOiI6OKBiJEaA8Ic2jctu7/zLXAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJkKoj8znifwm8CLwEeMH8zuKoNX6fFDdo3YCehtUuE=;
 b=Tzb1/77ZaoMiGH5/qZRFm+MHlJyicgKaDOoK0RUgjrnUCZxZbXSJP9AQRjVZEk7HFkHkAZnRCZYZA6pCUer2DNxAAxJ9shRrEvpuSczAuHJgYTvWhlC7o4jI4FmpK41skIZk8D4gM4GxB+R838PVZJSt42tnjd238uivBa4+fU4=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 05:38:09 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.023; Fri, 5 Mar 2021
 05:38:09 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fini data exchange when req_gpu_fini in
 SRIOV
Thread-Topic: [PATCH] drm/amd/amdgpu: fini data exchange when req_gpu_fini in
 SRIOV
Thread-Index: AQHXEXozuDU/sD8MQkC5BgqOWLtAUap03/Fg
Date: Fri, 5 Mar 2021 05:38:09 +0000
Message-ID: <DM5PR1201MB020445FF3D10C0F9E6A5C99BBB969@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210305044357.302200-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210305044357.302200-1-Jingwen.Chen2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9fe84c33-a025-455a-b87a-27e26ab475d3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-05T05:36:11Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64a36991-474c-4e8a-29b5-08d8df98dc2a
x-ms-traffictypediagnostic: DM6PR12MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3931D0EB20FB00A0019104ABBB969@DM6PR12MB3931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EV3lw9Q7RPM/8UBP4Il3Mp/dQ2NZVeHHdkclV6hV9GbSnMVmJJu3GNCO8kkx6ZhhUdeSYJlYERdL51G0WoKVOaYDgziDQVF2I7qwucDh2P0Y9KzuGE4alEqM7PnULrbrvZ3lbXW2Rohgl6UigT82TvrH7ZoDxCnZgNUzK8HVscb4NBpd5ec4hf+5EkZaE0wXGi+mbYqiQXiAvmImjROf7JYeC4h87lWr4+1+zy+zfUv+2/V8s3EWwwnLlmop70Po5GQ9e5uWajDQtTbhYzU9u8UloWZLXcw9ahc1mzB8v+5cJDQrIQphQK/zEyhMEbgbbiYQsxvJAwjEHvn7hHEXDJA8X4SN6NriJmPQ2hADEfOT88Bj1mp6vkRmsCfsY4MbO1jJHIQOBJnRwSEwTJx+YaoCRvaouBLrPcW3BGRXv40oDatyw4Nk8vWIjt1KQK9ArCPs6Q2Pk48hFUvpasCO/a3KmiJ7WY8GPA2v5qysXoaUcW6djdXd9rBMjEQ3CYxCYcs4uGoiYYZZPaFPzko9+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(8676002)(4326008)(316002)(7696005)(478600001)(186003)(53546011)(71200400001)(9686003)(26005)(110136005)(6506007)(55016002)(52536014)(83380400001)(66476007)(64756008)(76116006)(86362001)(5660300002)(66556008)(33656002)(8936002)(2906002)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?alI0THlGMEN0S1h2MzMrN0tOU1pOblJzRWpvWjh0VENvNElqNDZNak82eVdM?=
 =?utf-8?B?b0dUbG1WU1FlcjhzN21jc2Jrb2g4cFRGYU51T2FyZ3BGUUhIUGRSaWZoRnp2?=
 =?utf-8?B?bjY5bWZYbnZrQ1E4SGY3RHVEemxicXk0UHpYckw5YjhWNUZ0bkFVQk1Cc3c2?=
 =?utf-8?B?UlVyalVaN0MrMnF6TWhRS0lMd0lUTk91RG9xSStxMzJqSFgvQ2JybXlEbWsy?=
 =?utf-8?B?Q0hqL2tqcXkvcVFHNHZ6Um1HSXluYk90bERYdkhsN1FSQStwNE55MzRrMWh0?=
 =?utf-8?B?M2dub3NSck5pYmtNeWQzRHowMWFkajFTOUtVLzJTVnZhcnZkQ3laTTFxdTQw?=
 =?utf-8?B?SXROMzJmYWREYmh2bExHSThjNW1SYks2OGhzYmtQSVMxaFdxUlZTVStNKzhp?=
 =?utf-8?B?VjA1K1dKWTlpMXhiem1oMnFndkY0elFzdlMyY3V4dzZBWng0eGxERnMvcGhC?=
 =?utf-8?B?RDh2cGpaOWV5bEQ0YUhaRHRHS1A4RE1qUFZwdUpYRWVTNmpIZzhLdDVLTFJX?=
 =?utf-8?B?cnVtRG9RU2ZrSUNleWNoTXJIWjBRTlZlenhiQjE5WmdFaWtXaEpFbW1hSXor?=
 =?utf-8?B?VHVuZ0x2TG02VmF1NkxCWHVnL0ZuVVBHUmF1Sk0rQ0YyeGphUmRzOXVtZlkz?=
 =?utf-8?B?a3U0bG12VmV5ZFRIZStKK1NBNUVkRk5qcmJ1VkdwSnBYRnZ3WXRjUUx4RU4y?=
 =?utf-8?B?bUlscDArUW1IUHlaQ3hTaWsxVUpmWjcvTkJwcjQzeHV4dGVjcm9UR1BBcENy?=
 =?utf-8?B?SzVJRGZQUHU2U3VFQkRMR0NnVTlMcDlKOWFjRFhhZ2h1OGFDUHVWSjR1QkVj?=
 =?utf-8?B?WXE2OHlTQ1EwWHBQMGt6NUU3Nm1sUWZoa2ZUQmMwbnhpWmhmTXhkcGN4Mk5q?=
 =?utf-8?B?TkhLUDJmTVJzM2d0ZEQwYm5CeGlNeURqMk5rc0ZTVk9HQmpGU2ZJRUpLb0p2?=
 =?utf-8?B?TEF5b0ZxRStVNENDNjMvOWF1MGJPemtiWjlqV3U3anAyQzJhNzZHMkdhTEZz?=
 =?utf-8?B?K1VLMHdaSDhrM3ZDbjk3WVl5SlRBVUo5WkFFU1dGdjZnZy9zVFdwbjNIN2xO?=
 =?utf-8?B?dU1qcStLQWhNMnpnSlhXNVpBYmJmblM3YUphUjVzUUx3cHJ4dzYyczdobUdO?=
 =?utf-8?B?NW5yWnM3YWpqSGM5eXNQa2xPbnl4M3J1U0RyUUdyK3lmVWVXUlJxc1l0RmJO?=
 =?utf-8?B?MEpGZ09YOGoxZCtvWGxobHpuakEvSVUweFlZbUNUZUk1Rzc4Y1NxUERuVU1z?=
 =?utf-8?B?Tzl5UVU5czk1MTRtcWpkdC9PanpvVE5PK29qL3NMTFIwSDFTNWtYa3pOWW1w?=
 =?utf-8?B?bWE1dHpiZk9zTndIM2RWQ1pveURUV0NacEJ3M0RCVUF0Q3VaUXZPbDlRakMz?=
 =?utf-8?B?a1pubiszVVE2Z0Z1OU9iM2lZbnEyK29HRjNtK2tuUmRBZW45VG13NW5obS9L?=
 =?utf-8?B?eVZYYTZKRmlWMk9yK2lyTmtzOTBESmhPeDJ3N0xvT001Q3pQcmR0MDlFd2RP?=
 =?utf-8?B?MHFWSFpqZGxBazQ0S25WbWREVC9YSEJYUkltYVBQRDVLVC8xS1JsNWRyS1ls?=
 =?utf-8?B?enA4MXhtdTVvbUhjdm9NdW50UzYza1F6R0wyYzE1TzM2MWRmbDB0ZnJJdWEz?=
 =?utf-8?B?U1lpVlF3bXBPQXdqUDREOEc1emlwak5MNlFTM2hnMjhzc2tCRlc3cGt0SXk3?=
 =?utf-8?B?OW9YWWVQQVdFVXlBQ0lNeWowczVUMDRLbXZmY1ZVcnhaMU0vWWpWQWlDbVpq?=
 =?utf-8?Q?wgNpw+YMs9s3z1efATQ83K+0DXBDshyTjz/AsCC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a36991-474c-4e8a-29b5-08d8df98dc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 05:38:09.3949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4gE6JRDXoXz5a3ZhyrBmIvbddjB+BjpZey34YTIrm/icnL2tX4aObdIsrrGTBNm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Please comments what the issue is without this change.

/Jack
-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com>
Sent: Friday, March 5, 2021 12:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Horace <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fini data exchange when req_gpu_fini in SRIOV

Do fini data exchange everytime req_gpu_fini in SRIOV

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a11760ec3924..e3ed52f66414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3601,10 +3601,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 /* make sure IB test finished before entering exclusive mode
  * to avoid preemption on IB test
  * */
-if (amdgpu_sriov_vf(adev)) {
+if (amdgpu_sriov_vf(adev))
 amdgpu_virt_request_full_gpu(adev, false);
-amdgpu_virt_fini_data_exchange(adev);
-}

 /* disable all interrupts */
 amdgpu_irq_disable_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3dd7eec52344..af1e5d8fc2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -114,6 +114,9 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 struct amdgpu_virt *virt = &adev->virt;
 int r;

+if (!init)
+amdgpu_virt_fini_data_exchange(adev);
+
 if (virt->ops && virt->ops->req_full_gpu) {
 r = virt->ops->req_full_gpu(adev, init);
 if (r)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
