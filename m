Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 10:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367F060E97
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 10:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 367F060E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3F56E0BE;
	Fri,  5 Nov 2021 10:23:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D966E086
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 10:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZImXdItN2c72vf512aLKaV7ApFRo+tIwKRxNxBxkoVvkzUtYFdBtSoaGVwKWpCOvK4YAbrTiro4T27IZwy9SR07c5hH+/IrMSzdN7jQOGzlQgyEK57WhNluxNaTuK5oInCqhuPUEWv4KfgylADQ1iFaf1yYUJ7H2mC3mqdbFh3HjW8fhIvJ9kxZVaf9QF2YVOea/hCLuRWRfnkgYWDo02PjL4BrYumPAN7e+h4isBzwN3bDOdcvJeetIfBJqzfa5fD7ywKU/oYYr90rBW9iFaRLJpAU2y/urmWeaPyRQbbl1YfrGwbzCYeY1uHLD1JektHg6bIoyiYJp9V525cdnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+3S8zWxa4o83deuPzzcjMcxLogWcA932lZKmLF/yAs=;
 b=CDagCMNAllWCylO40wqQd+84reqZ7vSMr7sEuvTIseHeHuEJ9LTKZtdZkczurGboW4xCujX1bSGs23y8a8Medx9HOjt3WhXJ4Uip0WECF9+ts8TbNqXpNhauf18ZzPOhdrUSCGZCWft+d4m0B4ZgITasCq4H2TBP+0NAuWrADezwpy1+j2FFr7gcBBrtiByYWjLgGDhEa5Vie6nRYe62Xf2hDg/kydb2No396gibpKWjxQRwIHiMe82YkMqNeam+l+WzWAI1glcM2EJ1db9FhmAamDk2Znt6t1Lvb0ooT8l3lxnGjmflYcgEBGQr+Ec2bJGeNEml5GU9C38JbDPKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+3S8zWxa4o83deuPzzcjMcxLogWcA932lZKmLF/yAs=;
 b=GRkJJakIsed3ZF0g4ImkydBA/7ZV5obWZIrk1/iNuGrgFIyZlwUYPOZAzLbcOOtLk3CDMVavlGVYDBLDFJb3X4RFtlXBR387qfYHnbbjRirI6tjtkjS9aasEMJM016GRVNsEgEh8G1A9YdAz9kvDw+pp4ukjWwpZVoK77rO8uzg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 5 Nov 2021 10:23:32 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4649.018; Fri, 5 Nov 2021
 10:23:32 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs
Thread-Topic: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs
Thread-Index: AQHX0ilMWtC6OuYj40aQfhw6YBsgX6v0uTUA
Date: Fri, 5 Nov 2021 10:23:32 +0000
Message-ID: <DM5PR12MB24691F4D4E023021BE1916EEF18E9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211105094046.3651331-1-Asher.Song@amd.com>
In-Reply-To: <20211105094046.3651331-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-05T10:23:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=82d6f360-5014-436d-91ee-5b7f91f6683d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d35c045f-83bb-4cb5-418b-08d9a0465152
x-ms-traffictypediagnostic: DM6PR12MB4958:
x-microsoft-antispam-prvs: <DM6PR12MB49583AA934AB67549647EBC5F18E9@DM6PR12MB4958.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D41nieT80Z9R9TM1zuuSr1C8YYQluL98ey1Jc0t9+shGMdnIeeR/10tXSoGIJ0umx2E4g8eaGZubsc3ltT5Ui2V3Gj4coHHKVhj7/GPJT08tlxKiP0wKaAk4DqPht/2ZXkeNUoHT0bYQNG7Ecanlz+tjABqzUF0Vnl3DPlAW+5qOxWFlo7ONCA5LQXyySlNCT1ZFSjTwHUlg0m7xllGbTBjWhukT9SdoHmesI+Sfg5eHkaAm7cFpgK4C79+h0eveymBYENH8XRawHD/7Kwb2no+Nfmxy7bSefSzJn5uD14wgusy1G9btkxWSUbOT9vuFs62GclVEwM5Y59t1XLXQd67tnzQs/l6jmWO7YyImCphGAPkwNZu8zRHxDrH3by2UVW04SG8sBsb5Lt9FNeS4/TQGaNQ75/EvvFPGKrBERTEVSKIrcPuu0L4tz/VUCAwkEFNiAFlrUAu0WBElO6ldCWsW+Cxj274gFWJA9u/xK+8VHO2jDPscphQkXAEcsty3nI9lb03/FPG6DGGiAR5yE/2TxxTXFjjBD6fSx3ZXkYEEqKojVbbjS0TKgo5LCpEh54wLb1mbUn6/kTdQkpD4AzYF4BdDJDhxW5yTqA4JEFUD4vFnzJZqiTby4jDV5Z5niFQanx39H2k0jTub6rDD3ESaKKYpQTtwfp8o65cH71TmK/aIqrLLQBu1IKejDiWCq0Z3jrq4Laoa5NPnGi9d6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(186003)(4326008)(71200400001)(33656002)(53546011)(76116006)(26005)(9686003)(66946007)(8676002)(110136005)(55016002)(38070700005)(83380400001)(316002)(38100700002)(64756008)(66556008)(7696005)(8936002)(86362001)(52536014)(66446008)(508600001)(66476007)(122000001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zz6I4uzj2J6IxZJrHYsZzesQVi99IVK+xaXjA5V2M1KDzxQdZSIuwj9UGSDG?=
 =?us-ascii?Q?AW8vklptxdm0f528UZrCUfx4H/AmXG5CNG8XxHVu+Qz+QfSVs23mhzwG+Pgm?=
 =?us-ascii?Q?3qlR7B5OWL1VHwnVYgncX85J++YtXWimNnB9BCA04hLIsyAORu6FExQ8D5LX?=
 =?us-ascii?Q?lsEx4ioEO6jONghIuXW0dJRbdq9HENW91CxrfYYs5gBQcfdAvFVq6DGXyHhx?=
 =?us-ascii?Q?2GWai8B917U8+E3Xb9SWevbnAwk4KGsbp877LyBw04LIuaCJNf80OVShPlfl?=
 =?us-ascii?Q?gOYN0K+1Bx1W2K2voPrqBrbiDFH1HrkgCRsUYNXYZT8JJYli4v+DEr5jyjDh?=
 =?us-ascii?Q?aYkmOvpp2zW5gehBh2pjwPfLwvPzUtZlZH/UbPj09668aK5yD5ukVDIFWFUD?=
 =?us-ascii?Q?c3OP9SUUbA1ZQ9kQGTUjPjhE8XnwGbR77ZKylSCVzoxK9jge63sQT8SmG1iM?=
 =?us-ascii?Q?BZjylAaE4u+nbYsQkrPPcPCYgus31nr6TJypLBcKqAbtx8Nh+GYXwDg0z9d0?=
 =?us-ascii?Q?61SnJRcGEjwB5nseYZ92gdj8M2AvqrK8YG0QiVWuDjfnMbfMY6UqgIuins5a?=
 =?us-ascii?Q?R+EheAAfbFrxWnw61AepQ5DdmTrqaWtEoYRLkrZd3r5/Yq3CHFHbAGkLS2kG?=
 =?us-ascii?Q?VuMhHQO+7RACx+0KdSJVHRJnGgyrfkEybkYYoUZT+xJhB0hg1wiJufQYndVx?=
 =?us-ascii?Q?Ofc+r2ZWgMNiqmv+xfd69ArTTICjVWeYIq8blUrTPXpDvvLz8liOHWGFk/tx?=
 =?us-ascii?Q?Um5Tmr844k3LA0wsLL3B1vtNmOqToY6pF4ixM6PmbNL25kgBqaNx6WUQmVio?=
 =?us-ascii?Q?y5e6XYGlVkHYTa6DN7Vt/2YUN5qql/9mxME069OJcHOa0fGaFRZfuenfSHCJ?=
 =?us-ascii?Q?S82EDi+DeR2cTQDzR+RkS4sYoGD/gho+bAsL4VwE8VKEOBFUTRv8rvi5JH7d?=
 =?us-ascii?Q?LXyNFuhTDjEbgiRmFPBIaq2cUex3n4dvyyGwYC4BjCPAk1cqr/m/PA7WqYtX?=
 =?us-ascii?Q?tPLXS/q0gRVDU+PNw1IFoyFyAogmLPCIcP4hpxcxh9rYoDOPiUIQdsVn3W2C?=
 =?us-ascii?Q?SfgsFacRFjIfWs95Nn7Dhu3xs0vF5JTlQK8px0YRAA4y4i5btmU1w4fKVqPE?=
 =?us-ascii?Q?FloMUWiXZECb9JbttX3URDLPf5ti2mrYgXLzFtlnzTsbOU76yjZz6tGgGwIk?=
 =?us-ascii?Q?p6IXcvOny1BFO/t1RLQqot7qlERPXghAkS9ErKGGmZYvzkxkTdqyTprnqQ4U?=
 =?us-ascii?Q?lQTG4H0hylKIFZaTJmDYxfZhe0kcdhll8uisUilIsfrTkXaZSHUhJ+xBIKGC?=
 =?us-ascii?Q?Z3JmNTfneZvoXbrKPv4eSZAYrnRVabmxCE2kWbwlfc5OhgyidyGHfZFps18o?=
 =?us-ascii?Q?4gQ5R1P2lCpDsdtbhordeSLUn8RtynUE+P4UrtGZGPvPAcjvbOsODTwy9bPA?=
 =?us-ascii?Q?Stq7/sdSho2c6n4M7NG8vJ6wRP3ThSk2PkUrVlWcr4KzIiJU8wvog5j4RpSF?=
 =?us-ascii?Q?lF2SwLF75yHLeXXnSfiJOx2YNLeynubkdz/alh6J83NQDPB+Lq8/AZdiP4Hc?=
 =?us-ascii?Q?3bIXX0qgxoIdCnpfaeTNkMe86i3cqoSHNcg6vqUlhK/8NBTnT06R9uUTQN3Q?=
 =?us-ascii?Q?J7GFcsn/XaJ41JCBUvHrh2g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35c045f-83bb-4cb5-418b-08d9a0465152
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 10:23:32.0436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qz0UISaIuCkVZDUKGM7H1ZHLapAuKHayqNs4l3MzoC86FrjRc5VFwxkbO/IHrOvDnw0tMv81PY7B32S3WCO5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
Cc: "Song, Asher" <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asher So=
ng
Sent: Friday, November 5, 2021 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Song, Asher <Asher.Song@amd.com>
Subject: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs

In drm_helper_disable_unused_functions(), when !crtc->enable is false, a NU=
LL pointer crtc_funcs->dpms may occur. To avoid this, assign dpms for amdgp=
u_vkms_crtc_helper_funcs.

 Call Trace:
  __drm_helper_disable_unused_functions+0xac/0xe0 [drm_kms_helper]
  drm_helper_disable_unused_functions+0x38/0x60 [drm_kms_helper]
  amdgpu_fbdev_init+0xf6/0x100 [amdgpu]
  amdgpu_device_init+0x13d4/0x1f10 [amdgpu]

Fixes: ba5317109d0ce ("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 50bdc39733aa..9cfe479c4c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -156,7 +156,33 @@ static void amdgpu_vkms_crtc_atomic_flush(struct drm_c=
rtc *crtc,
 	}
 }
=20
+static void amdgpu_vkms_crtc_dpms(struct drm_crtc *crtc, int mode) {
+	struct drm_device *dev =3D crtc->dev;
+	struct amdgpu_device *adev =3D drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+	unsigned type;
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		amdgpu_crtc->enabled =3D true;
+		/* Make sure VBLANK interrupts are still enabled */
+		type =3D amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
+		amdgpu_irq_update(adev, &adev->crtc_irq, type);
+		drm_crtc_vblank_on(crtc);
+		break;
+	case DRM_MODE_DPMS_STANDBY:
+	case DRM_MODE_DPMS_SUSPEND:
+	case DRM_MODE_DPMS_OFF:
+		drm_crtc_vblank_off(crtc);
+		amdgpu_crtc->enabled =3D false;
+		break;
+	}
+}
+
 static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs =
=3D {
+	.dpms =3D amdgpu_vkms_crtc_dpms,
 	.atomic_flush	=3D amdgpu_vkms_crtc_atomic_flush,
 	.atomic_enable	=3D amdgpu_vkms_crtc_atomic_enable,
 	.atomic_disable	=3D amdgpu_vkms_crtc_atomic_disable,
--
2.25.1
