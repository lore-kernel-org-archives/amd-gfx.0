Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE86C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 00:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512E864F8E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 00:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512E864F8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DDA6F3ED;
	Fri, 12 Mar 2021 00:47:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DF86F3ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 00:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLZ8phhXjsMytQNW0hJw5xzWzPsjd5xTE29SgxR3rjeXIcTLw2hvRTg4mtyc6YcSRkcxaw5sGpP1WxFGSQuQTIjnRtwS2kiuI1Q5Xc3t/UHFwkHFV2XivrkdHy+uRGM4eFg5op7ahtbeK4/pduZEsWkDmx4rJ8hQ/43yUUl9Qhba5pP0opgVH7BZoc257rh1nCBkZv98PS+zLGg0gx9HLD37rll9Yh2UmkZsY/LkQzYNH1a8DuxRtobjNNzM3s+30CIodfIdvejW4au7oerDObyeBXAv1RWfYJ2Q4c/hhFbF6P/Ce3slznML2cizjsdrvbZ0uQDTkqEkX8J3K/KpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QbcYdNtkn5wFpq5wNhLN12hpK5eeKs6iB0+kL3vaN8=;
 b=ZN0wkUzH5oS0IZDFHaxAMZIhqvTYZxG2Ynh+G3hu6aE+tRpZSFVMSAIx9ATdt5ssVRC6y7bZxo3dgGo9qAshgvnCD0p+/v2NhqJeOHurVNinpwGzZ7ApEnYWrn7fxg4XUmlXowZIgX5cjATRe/6Dg60ACgk3apz/dJWqjYizVoGQIqWitAmNofWr+nuLihHLGTIM9tSk+jEy/YR0N7X+xyCSJRa1zamqVpvZnSDMVsAviav/vMGxeQcDzOpV9QpHpBDHJ8rFCWQuX1G7gd23ymTlk+U5Q599lc2tlluLBu467Mk1V/2GVT1F6oeIlVij/T31zar+MChrW1zg7aOigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QbcYdNtkn5wFpq5wNhLN12hpK5eeKs6iB0+kL3vaN8=;
 b=hr9E9cwW9I0/Zh7zMlIkG6sGoOulHo43U28L4UJ4OVAUPtmbKA01pabP8Mnjdh+sJtLGw6gTPv4Ml0mo3W5xxWhL3WdUP/AStkVdJIGEScB/Lnn/mp/LoRIVh1KNb/LI5patkP7OGgiNT79SsVeGQdVxxN7YaDXvYc1IjPIcsWs=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Fri, 12 Mar
 2021 00:47:35 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Fri, 12 Mar 2021
 00:47:35 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Index: AQHXFpo1/qViy9Iqmk2vLKn/BFJ85qp/hVSg
Date: Fri, 12 Mar 2021 00:47:35 +0000
Message-ID: <DM6PR12MB3835AA9836B0159298FD0526F46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210311171548.10671-1-shaoyun.liu@amd.com>
In-Reply-To: <20210311171548.10671-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-12T00:47:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=03a2ee93-ca6b-44d6-ba9a-b1d924e9dca6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:6408:a69e:d447:15a6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6847521f-e4e2-44ce-b60f-08d8e4f06dd0
x-ms-traffictypediagnostic: DM5PR12MB1756:
x-microsoft-antispam-prvs: <DM5PR12MB175618D692B5EC551A21F16DF46F9@DM5PR12MB1756.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t75E6KVXYHcV6FY3TZfyOX88yPgFNUf3bTWyXzT8txuL63RWw4xwyI1IiBu0yerp+p4jFrS3pF5OvmrEMXkPZVLHYpT0AX5OI7MMiZc/CWT9Nh3eY/i8M+sGwgSF1fKsf9d/I2GIRWgd1KIyziswXB3LHho19m+rEs4APKjiFUfGTlj3GtlKOpDcZLG3bzcQZS39qh+HcTHlSc2961Ce0QyIcZK3crHSv1CQ2atMHDt1S329c+IrkfkjEB/LhusU7+xv+ZF8EDtuJ1fQ8cW2LALA7pX4fs4jtIyjaElKxKloxZJWQtmouNRFwgzxmUTjrTGlq6x/Wx9AGIPqPH4IozIwoH25kpFu36eecrwB6ej29fx4+LHbHOLrtSyRlw1q/g0yqvV9kIwkvCIzGu/syJAi+YFwI/komkVQhbPrvIhdDgN7UlBhSIYx7o6jC66cxLcOAECzbhxUu8+X0fi3XTpQY7KSzORqqoAYVReoZIBUIktk0iGMTe0DYpYPVbnaffrsRpGxRDAwXFIm+XjLOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(66556008)(6506007)(83380400001)(53546011)(76116006)(478600001)(5660300002)(9686003)(71200400001)(8936002)(316002)(2906002)(55016002)(64756008)(33656002)(8676002)(186003)(7696005)(6916009)(66446008)(66476007)(86362001)(66946007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f42kxZfqxWZpbhdUw3ybGHg36mIAMrF9KpwJ+/Ddb57r/wFXD2VUepgUa5cQ?=
 =?us-ascii?Q?pSVSl8zwIlFIUn1szNvrPSoAlKZ+jNP9KOYk7FDivIndk4xUz9KV7TBwuiw/?=
 =?us-ascii?Q?y2i7UBH786xohdXox6jeQGeZy859jvP4d9iosyKTaSGxDWadKI0J3CN3YXZx?=
 =?us-ascii?Q?YlVwWnluykym0kf33t/Vy9HCjDooIDBHbqlYXEz9f0+EZCBVKTh4BoskL0yq?=
 =?us-ascii?Q?rO1xFgQC9vS7n2mJFlv71qyLzEpadH725ymfey5x5zcGmmaIkJ94a+vGTTeX?=
 =?us-ascii?Q?K5DCVreBt+5NhppCFCx/3dVwJCWwd+bYG7vSraMcFYGxcNpH5QmFUxlDJmAX?=
 =?us-ascii?Q?LFSOEb38paF38FUv68f2U6VcgBLNeDQkhhp83PrZvZPWrtC4ryUTQ7kL8OJS?=
 =?us-ascii?Q?Bh1J8Fubgu2iBoD/B7ZALAGyC8TjTV+13WGeKoVwTcoAjfFAqjUy2WcrPDc7?=
 =?us-ascii?Q?nHjmNLdUyz/FQ+YRJ8b4+yfVzeLlhN5vOnK7VEzOLpBA+CA/gFor8EtiJ8Ob?=
 =?us-ascii?Q?BdG+OS13H+mZx3tViEPMK5AhaqBTwCKM2p0VkrbgBpAZeh90TOu7fI+9lWYZ?=
 =?us-ascii?Q?fSyGzOZ4wv9my/+Pm4q1BpIGgmZEDARkGFdpXpHSiKVMgVSuA0c5dNwawYR+?=
 =?us-ascii?Q?7mb6+ukioDMZElfy82kA+U/qjp140zArydhLYhaV2prIkd5AiSUBlw9hMaA9?=
 =?us-ascii?Q?/Amp2PGST35nU/xzpoSXx6B68st26NB0MPS7EUq6PM6Zv5P0QbHOmMFkKvD0?=
 =?us-ascii?Q?cxdJHAMfbf/KV3NVy8kP8YSVX3LWOF63zlIGYxJz/LlD7AoLFwfbh9qZVB0V?=
 =?us-ascii?Q?p4Ir67xzZBYYWSvwQWrqr2jDjk2/V72s6bInJiaV/E6rZBSDzBk07nIfiqoK?=
 =?us-ascii?Q?ompCinHQmXqoh9ybCrGx+E2PdDv/yoDkpplmdwIhRwCy/+EaGQrNCp0kXvHS?=
 =?us-ascii?Q?IAn1CusukULgdqSNKRmCD9hUMJeZgEkJDIhrze+qxOFctQMQ8MT0sFXT8ABz?=
 =?us-ascii?Q?nbRZ8zFEmVzqDl4tn6z6Fo6+1ny0RmXQeHcZBRWo9A4qTq+R5MFrSCbdZYKo?=
 =?us-ascii?Q?JfqGrzeGNOlNlcBoBTJzAilmswYpHFAx4ZRP1NfaYacLiex5ufYdJtkWwZKW?=
 =?us-ascii?Q?lSfl0e8Nt6kzDg2/T7TfpMctDLAXqN53I8hXW7wVESfS6icidR2XbyqoG85d?=
 =?us-ascii?Q?OQeiW4S3X5m1jBg03ZMpx5M+Ps/3B+Bb+mT6HqXx25A3xiAlMvUjD2ratOCL?=
 =?us-ascii?Q?TENjhjDmg1RbxMtv/LLU3WyOxawGwZMcA+zWW2GjevxLBFiU4208cOylBItv?=
 =?us-ascii?Q?cwRLhvGNzwxPxH5PaVcIrbyxW0FButaMzyStztKO7jtztpjtD3rTs48yuwhH?=
 =?us-ascii?Q?pyfxY3a2c6YvI2Ubt4tDJbnP+DzH?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6847521f-e4e2-44ce-b60f-08d8e4f06dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 00:47:35.7704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gyo39+/xlNSBpGe5g/xglfAmUHgqTOgge8spkD7UULNOr0KXHFGxYGXwcIx6fs2F7qJiaE7607+D6W1qyHbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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

[AMD Official Use Only - Internal Distribution Only]

Ping . 

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Thursday, March 11, 2021 12:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configuration

This is to fix the commit dda9bbb26c7 where it only enable the light SMU on normal device init. This feature actually need to be enabled after ASIC been reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
+	/* For XGMI + passthrough configuration , enable light SBR */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_light_sbr(&adev->smu, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
-	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
-	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
-
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
