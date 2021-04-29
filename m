Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 02:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF7561222
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 02:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF7561222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF466ED01;
	Thu, 29 Apr 2021 02:26:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083DA6ED01
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 02:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxjDgzF9+0TwkN87RdthxENayYOnMaqcRFzDdlaQggXs3IVRTTaUEkniY0d1v8EjjJ+W/m8vd0cbsPMWgLLrvFLWAL+8lzt9DBv9vRzKeVYBsRQspmaBfqPXCQ+Zhah6M/N4b632HWJsr7iLYX+4TJjKr87qbDacFwJkyUL3c7Ex7rwulMOk+XXmSdQOOQYpxflk9tWfGrK1Wf6X03s2PUkZ48/sQZNsc0eHO05+ExJiXH2sya9qe3VB0luG8ARCcBW1CqQfnB5E75nhXnQPon98PRZjCPXiA0nq/RUQOTcgxmTZWFWfqTkqx5vcRAI6OyKyIyzweeSE5zUeTw7d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdroe1DmrCcFEkLm1qFXWq3X2Wx6C09C9qNFz1riBw=;
 b=agOvvLimuzzlN2hxt0czMNzDqr+XPQAtMXGAmy/mJFjVac46HST0xbAKDi+w1/OxRFnaFd7DnknLMGKXhtb2ICyYKDc79dusvPdKYQe54KXbcbOV8Gk8YLvs6tIu3iZN7bSD8sKAdjd/29tuf5BFim4qitEM/xJIBsevV+avXs59c5VXhALp25Z/rQ2SbjUBrgX9yEETlchPNjEktXNnMMcm096Mk1W6uwl/8C2w0jeer+CCqD6ROPcgN7H1Pt0KKOyiviLz/b159cRycy/LvVn+kt+WU4m636E4EPqX/62dwIzXoYFYHzoNN0TjzdZl4evDHo5XswMz8QVmeHtgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdroe1DmrCcFEkLm1qFXWq3X2Wx6C09C9qNFz1riBw=;
 b=hPlr7kfiDue1rsTt6MOjl2mlFMwx5EgemcItiRIroEc9tjrr7RtBEnNzvoF2R1gGVLsdA4thAV/aDRENIrl9E9wGpL5O93EfMSE64BNMoLjdM/ZiCPuoZ9W5YqMSEN+KSmnPXX0PDLeLmHKF+VYltRTkIxEm+Y4rrHnBaV8luIw=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 29 Apr 2021 02:26:48 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 02:26:47 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on
 Aldebaran
Thread-Topic: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on
 Aldebaran
Thread-Index: AQHXO8/kV8wAuGvG90Wda4GS9R+cQKrKxnNA
Date: Thu, 29 Apr 2021 02:26:47 +0000
Message-ID: <DM6PR12MB2761594E65565290594EC90B8C5F9@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210428014305.1736511-1-evan.quan@amd.com>
 <20210428014305.1736511-2-evan.quan@amd.com>
In-Reply-To: <20210428014305.1736511-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T02:26:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e88d74e7-d3ba-4d35-ac1d-9c8580881a83;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:ac6c:26:2f5c:c526]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e411f7-4144-4e50-ab8a-08d90ab63d51
x-ms-traffictypediagnostic: DM6PR12MB3897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3897B9A23B868E38B096D0808C5F9@DM6PR12MB3897.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KABEF1lQFocYsEa8FZYtmPN5U3OpHqvi8MxEMZnu2viIXQ93zAR35NEj88C1lu8yj2qMsayzeIEKX5VeBXYpj0mJEiwNhlohGZXbwSDbqVr0T8QQ/TOGmHYcuw+nUHp6HfxMcj9w7SYTYvW00XdwWZHMI/dNgCl225Gc5IKjtb6ZDoWg5JUk5yi0mSNp5HMGid3HctfZhS+dA8YNh+3bYQYc9FrwIGzz5eARnuFN7dkhdM1La75yHMV/F/7812x8KcaQB+GxYor79vnbNeQEoTthybn35GlPu33+PWaGPmDrAudgMuLHrzaZFMyI8F4xPaz0mQmMH8cEjm7pyKf3v7Y+uc4oSnofCov+s/KqwGsuhZMaVM5Pe/XAwncczmQO6kSwSWKvJm201ALL1C9WhgNiNDpfh0bjPxGMm6W9Q92Xd8WD0JjNu7xw2g2admQLYarcov0XtJVCUgEHa3jROQ3+m4G9A+ugCPxGeJfbSEtSjqbtXYy/i5tFrYxJb7sQafTIRjeiafD5rKTqYb+R3JpVsKTqif5v7Quc5G/2V8P9DwQt2E/hP8ju1+QcvnHeU4xCBzVxepmuKIRuKv8lirYGdElznN11lp8jOrLmcm8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(4326008)(8936002)(110136005)(8676002)(33656002)(86362001)(186003)(76116006)(7696005)(9686003)(122000001)(64756008)(38100700002)(66476007)(66946007)(52536014)(83380400001)(55016002)(5660300002)(6506007)(316002)(71200400001)(478600001)(66556008)(53546011)(2906002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/F7LDpie2USVwYJ/VtkvqxLwwFlxd+zX3caXVh0x+TpPd2sThYgE3T6xcYc0?=
 =?us-ascii?Q?sO7Vfocit0YwYm5FXDESnUD5o4QPhCVyAqZqepFiBKVqbj/HOoLNkyyhmAEy?=
 =?us-ascii?Q?fEhSLEKEVmBaQHAizip+ovhNREY+ygkM57lIJqSQe3+Zq48cXBGj9my7T0zk?=
 =?us-ascii?Q?okyo+/I4G2tsdTBykrMNnERhbKvgvFQWXB011l9lklpKGXQzo/iw6M2icNNV?=
 =?us-ascii?Q?IvOTy91OSO1meG+b45JyHVfQNXMb14g41RKmVqM0lhOZC9Z5qeZUcK0PPXLE?=
 =?us-ascii?Q?/DSniglT1ZFEsfgUC21jlihWKmIsM0CcO8WaWQvxXAT/VxClryBO772N6mHV?=
 =?us-ascii?Q?jbhH2QtOQapGhp+njTZEYFLGdLOa9RfzmGMQrAgFpmR5BFjaGP5orYT/uID/?=
 =?us-ascii?Q?kvrdvoM++Fk6gJdxQ+TgefaGuCzq62PCAtsA3CG0DsR1DWgPHDmS7dR6BMfn?=
 =?us-ascii?Q?t1WKmcskVqk0Pe9Bb+uGm36vrDXDrDB/8cR8GyOLkaOsWj6SlNoWIOgoOCrH?=
 =?us-ascii?Q?s1PM1Xgrt9hk2J+IzOuyw4EEpJgBRSWitGQc4kSD5x9t8b0+JI8rzIZkdJ38?=
 =?us-ascii?Q?+w9LcEgP7WmPoHD18h9OAlnDMzGUYZ30lUUmnrFpPXJarveGsk0T8dGAYp0A?=
 =?us-ascii?Q?6EUpc09xkHzAB0MlvFxGY5WeTrhvBEgnnEdCEhCmxVfoQFFAUT6yePW1I+aH?=
 =?us-ascii?Q?oKmyo6KV23GWlNgSt2PG28VQdNYjwzXUqWs714d0xYwgR5gkR7tjcBTOsZzt?=
 =?us-ascii?Q?p4qRv0V1ns76sGpxDmuJzr8nYHJhjKCliuJY0kMPKzZy09wPhv14q+VgkJ/D?=
 =?us-ascii?Q?1DNvA2rvLclfEDVmxR3Jd4uRNTf6VVapK7iTSb9CFJWr46DuGZXw753hxtfu?=
 =?us-ascii?Q?bMwcAU29KiMRb9STAnq1ftJGzsd6GVra+sryoGwsEcYLiKfp5TirtPBsgOdp?=
 =?us-ascii?Q?w3lLW/FeVks9DSnr6RsQtBh0wLQaqMV6jkRXASqXzdO6sQ5+54hnWO5GnDDv?=
 =?us-ascii?Q?jXJZlEJHndbGvfr7nPZG2dVaAB0LfTsNXmK59R635z3NMB6eAyb4hdIdL0wC?=
 =?us-ascii?Q?8n3esF+n+XR1ZwXRn9I1TqxY7n1h1z3iuAXUpeVMjX4nqQzwGDj5i2Vf0B50?=
 =?us-ascii?Q?vv7CI+f/8+THodYX4irZlrBxVS6Q67OMFfb2LrLkKrO63jBEkKBAFRoAO478?=
 =?us-ascii?Q?MYq4jkMik1fyBwYJ9JrETnxc8aGB94H0mk2ippXRmlL/ApL0TXCRCM8HS4eV?=
 =?us-ascii?Q?usTo7K6ufcKa1EAtH5a8IL34awxT8In753pRcT9U5QJ5S/mwzCp1uMzIMo7i?=
 =?us-ascii?Q?DeUWFHDsCqzbEoL9yd+NHAzyV0RyaWyGQ6kPKrLxjZWuqgjw4neN0MCWBSMe?=
 =?us-ascii?Q?TMuMkNxBQs9a/g99lUTtewVmWH1r?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e411f7-4144-4e50-ab8a-08d90ab63d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 02:26:47.7884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GodLbYu7EZRCBcsS8hQfpsbQEyKSsDiVaq7vzZqS+qDAX/eLkenX5FWtbOuZeylNnZ0sz8oXvg7OAsv0qiC3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3897
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

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, April 27, 2021 9:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on Aldebaran

Available with 68.18.0 and later PMFWs.

Change-Id: I0d7e61875101b476ab50f74ade6dc2aaf1e0bc24
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 ++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 771e2f0acdd3..5d04a1dfdfd8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -209,7 +209,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -1632,8 +1632,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_2 *gpu_metrics =
+		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1643,7 +1643,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -1690,9 +1690,12 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	for (i = 0; i < NUM_HBM_INSTANCES; i++)
 		gpu_metrics->temperature_hbm[i] = metrics.TemperatureAllHBM[i];
 
+	gpu_metrics->firmware_timestamp = ((uint64_t)metrics.TimeStampHigh << 32) |
+					metrics.TimeStampLow;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_2);
 }
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 9240461ed1ef..fd0bc1a79574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -763,6 +763,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 1):
 		structure_size = sizeof(struct gpu_metrics_v1_1);
 		break;
+	case METRICS_VERSION(1, 2):
+		structure_size = sizeof(struct gpu_metrics_v1_2);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
