Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5050EC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 07:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17220206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 07:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jrI3Ul5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17220206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDD86E288;
	Wed,  6 May 2020 07:02:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABDD6E288
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 07:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmjVM1/qudPrIJu1WDYr8rfVOhLClVDkHkrQQ5vj0LtWEiJM+bKuSewN99iI1l1d3VsXbq+pq0misdB3kusXKC4XJ0V7zHFXgCKICdu9G5+mPxJIUFmz5LV2Uy/hRoLrS+f4tH4ysRaM7T5aEPzTa4DrYR6EUhnm1nih6op2V7pNe4mWITi9MEcoXy7b9HE0LNpIifT7aD/Isii1nOAWN7enAVw/bFGNBWg38ubSOVz3cB/08dSn69DfNZ+ASdxAO8WbUKlf3C9W2fwM4N3G+z0b24z93oq61O0wol6suS8GzLrL1e6cQOpQB5bFqNLJ4ObUbtrsdhDjbFcMODmAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VDeSMF8SKBxaqwVpRgGiff7QkWY3g1F9FdnmhlP1uc=;
 b=d2wZaySKR7xkHT0RDTXQPbPDOHfy+E+YDuJWJOOpjUqS6PxGU59z3dPoEI78ImMawloybZPk6t0KC4qj5z+42bl9tJqvoRQbw5HA7NCNpV548QP64/XJPzAJ5y4kD9EVCHujCi4uu9ED7TAMsiakgNn8oxsvfv+TD3s0ELKW/fMvfKRfAl+jS3QuhRimajN/XeBI76ffrmn7ct4yTUctgF13Gv2e/A3ShUDGa0ml9gBBagyXqGOpipWv7Dc3IuRs5uq622kgilCoU1C5ZO33omGaSyy/I8ee2ni72cgo3vB/od6ReDgecIYkR4nk+oWpmIqTjd/e0awY5n9YvEbyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VDeSMF8SKBxaqwVpRgGiff7QkWY3g1F9FdnmhlP1uc=;
 b=jrI3Ul5v4riGd1bvtV6qLAGIoj7jidJlYGqWMbH7aE+FjJfDQXJnbXedP+Jn0LSIyC0OkYsHnufClYT+v17GWSUpSGnz2mSOnSwJvy6/BC6IeJBYOE7p7ANUox6binmWozqrxYxyD8C/8fBYHPT+75+GwZMGZ+gxoY4fNjJ8M3A=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1858.namprd12.prod.outlook.com (2603:10b6:404:fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 07:02:20 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::60b6:8e56:2853:614a]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::60b6:8e56:2853:614a%5]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 07:02:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: switch to common rlc_autoload helper
Thread-Topic: [PATCH 4/4] drm/amdgpu: switch to common rlc_autoload helper
Thread-Index: AQHWI3Ej9BX8r4A4wE+dq/POwss2OKiaoTPQ
Date: Wed, 6 May 2020 07:02:20 +0000
Message-ID: <BN6PR12MB12835F51DDE63AB2C8471BFCF1A40@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20200506063923.22772-1-Hawking.Zhang@amd.com>
 <20200506063923.22772-4-Hawking.Zhang@amd.com>
In-Reply-To: <20200506063923.22772-4-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-06T07:01:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fafd030c-dc90-4f64-918d-0000b730b498;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-06T07:02:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b7aacf55-54e8-49f0-a9f1-0000aafe09c5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1090a504-89f8-412f-e8d1-08d7f18b6bd6
x-ms-traffictypediagnostic: BN6PR12MB1858:|BN6PR12MB1858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB18581938855BF384F79900C7F1A40@BN6PR12MB1858.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:289;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9CReftTQ3tpeXUA9ai9RILMNqBmnwqTEW1msllvudM89owoL0GmWStMpBtVKOvSSnp1aYLKveJZpGO8XZK+dRCt45uRaotToUfPlJyHopZULa7vMYpAwq+RPvIXJRB8eC1woY6jdnpHD5zUcAVSFZUGOT0nSPVEyGhwngHxAWHXN1FjkKcUkoQ4WnxsF1LQQkciEMqT721LfqjVa9uV9dIpfcFdS5C0Qx/HjDDSDqcl+fWE4xv3zPMjfzLPnIhHkmLNrQGVGBpEhmMUFE/COwv5Y+3oK/hgA2e4LHiTMXKNchYkvznUBfm0RelsCgwSHfR5Z8dGTXTfkgVc/2Us0RA4azyBhyEa+pqIQui2AQS2bPUkBL8NPolrSm2by5HHA2PoroRKHzIyPnokf5HzQ5bbH+DmmNLAYgVuNHih2DyCcoBVvzPDCW1AxBG+PV3YQ6XNxN+Ocp5cFXEWZ6/N0UjrQdAyy0LDEQcKLZfUezRmGbc52fGT7tGYq5vVEYczlJEjz7dOIUKDTu4pePkHDhlBI2kfc3irEUKtvENHduQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(376002)(136003)(33430700001)(66946007)(4326008)(52536014)(33440700001)(8936002)(64756008)(9686003)(5660300002)(66556008)(66476007)(186003)(66446008)(26005)(53546011)(6506007)(7696005)(8676002)(55016002)(478600001)(6636002)(316002)(71200400001)(110136005)(2906002)(86362001)(33656002)(76116006)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: OU55tvJsCRoXz/A1emNw1ouA49IhZnqva3BTS3rVBMq3SRTCzsP192IfU91+YOtHzpYbF4V5NTZ0qYF0PRbBSijL1UMBYj7yIjZgYXoBeQXgd0IlVWosCiARKm9yNoU5/+PcHxl3CYe90NY67ksGOQzhbL9INRwwgSxfIVCIlBO8wotFCYDfWj6+A7sfmQ51yJyfLxX/pnrUazK+pNoU56QFgP8edI+HCdtJ1Kwmi4cVKPFV9tf62Qsi6rxN3l8XK+GtRR3Y1Cg76kYhBnySRtid3+OZPB+1IHslwUrOigAmTN3lmR+80470n8dhbWK/+ucIICj2etPAm5UvUmSpRtbf13fRMCD5G8qXrKkZrYfo30DRTCcQPZkPV+kTpQ8gKqXtluukW5YXwtUuOoI8MydIx1QCMghzTNqodhEpRi75dp6SM+DIn5zsLPOWLWA8aWRRUBwNX6PobKbIS+VKNi0L8mSy1VWIf21Ka9ehDoNAaM26sa0rdp1B5Qt+4KFV3zAuvP6mRAG8kFRJFE9FMgr0x6rwCPHsREF33hJy7IqvDyyj4ZETxxc1lAb5Q8uZviXecyRoq+HXxiVVSCV4WCb6rzNymrAq9VJ58HcxzSE3+sbwRL1SwsMe/OCaqdDTlMYZZVJFcQIASFR8stVa6DOE5skewL2HWT4h1hE0eRU9YQ1ZkLP4Vd0RhixfGZuyws0K4gbP2tPejN5lcENga4Bc7wYiW55ZMQAA5i5oCR3ORGgIeBQ1Snss1nbQ+BF7Lex5O52ivtP7cfEsHUszaxlOgk1cm8tXuIOXw2qAEAE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090a504-89f8-412f-e8d1-08d7f18b6bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 07:02:20.6060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UW/O1b6cIacZ7BAOpBFMX02BdNeTmMVcheoghYtAv1dWMmW8XtuMMIA1WtuZk4MgHshHqvReWK1d7+H4/UYXPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1858
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One spelling typo in the commit message, 'functon' should be 'function'. Apart from this, series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

' drop IP specific psp functon for rlc autoload since the autoload_supported '

Regards,
Guchun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Wednesday, May 6, 2020 2:39 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: switch to common rlc_autoload helper

drop IP specific psp functon for rlc autoload since the autoload_supported was introduced to mark ASICs that support rlc_autoload

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 3 ---  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 6 ------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 19f09b4..5146542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1646,7 +1646,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 		/* Start rlc autoload after psp recieved all the gfx firmware */
 		if (psp->autoload_supported && ucode->ucode_id == (amdgpu_sriov_vf(adev) ?
 		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_G)) {
-			ret = psp_rlc_autoload(psp);
+			ret = psp_rlc_autoload_start(psp);
 			if (ret) {
 				DRM_ERROR("Failed to start rlc autoload\n");
 				return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46bd85f..2a56ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,7 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*rlc_autoload_start)(struct psp_context *psp);
 	int (*mem_training_init)(struct psp_context *psp);
 	void (*mem_training_fini)(struct psp_context *psp);
 	int (*mem_training)(struct psp_context *psp, uint32_t ops); @@ -307,8 +306,6 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->smu_reload_quirk ? (psp)->funcs->smu_reload_quirk((psp)) : false)  #define psp_mode1_reset(psp) \
 		((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((psp)) : false) -#define psp_rlc_autoload(psp) \
-		((psp)->funcs->rlc_autoload_start ? (psp)->funcs->rlc_autoload_start((psp)) : 0)
 #define psp_mem_training_init(psp) \
 	((psp)->funcs->mem_training_init ? (psp)->funcs->mem_training_init((psp)) : 0)  #define psp_mem_training_fini(psp) \ diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index cfbf30a..1de89cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -524,11 +524,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_v11_0_rlc_autoload_start(struct psp_context *psp) -{
-	return psp_rlc_autoload_start(psp);
-}
-
 static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)  {
 	int ret;
@@ -825,7 +820,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
 	.mem_training_init = psp_v11_0_memory_training_init,
 	.mem_training_fini = psp_v11_0_memory_training_fini,
 	.mem_training = psp_v11_0_memory_training,
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
