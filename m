Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41156C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 04:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F35619A9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 04:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F35619A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5AC89789;
	Wed,  7 Jul 2021 04:58:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEF86E819
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 04:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGSfyQxCr7kRnnh+KlelJVBgYJVX/cif2DK30MO05ToE3S9lVq7AAQkTtxH5oSd5nPMkx1E3sxbtBKvrf+vMYN9F7oDoX8ivsha9hQoWX11POocvi3PRdxvYM6BHlohHRgAqgmG88967YA4nVxNTWRnceDBtS4VJ/CqzppFpBN/Tnwc+s8GS5EkQmRZpqnBu0zciw3bwML6X9TvBolevLOsBKTwNQOdfAgiCE7bmUCPmLHufd+C4cwNZxSE9spQa8WsALMOVgClVJyWxvFOTEeegLzTjaaPUAA+ar6dukAuPK8ubLXYq3NBrpoVLthtiMyM4ZQtzU2gzVak0C6qOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac+De4RskGZUqx37sww2rwg+lRwsAh13dooC6i+7gsQ=;
 b=VQpJfotMUSut3Rk3L89r1ErpfhYWn2oKNlLcsCqFrL+ohNvc2NvbsemRCCPC22kqJ5bTDlos2VteIwMSD0uh7+VwTyxbjLjJEVFvfmVNL08dXg0ELFOxPqUm9pXlAiEAVFaCraPv0LCUcrdsp9GayVY08it8Wpq2kC42n3F1LSsY/p4WkosC5KwTyHT1mrPKhUGGTuFgq6Mwpfo6PM2xC7FHjoZmIrnX0764N3tLagZnX2BGEJF++qq7wtd6U0LnfUQewB+5QQRTD+B9Ci3xzzUhlWW6Wwzsqe0re5+6QOGS7NxbI0AAXliJOvMPxAAn8+oAB90VNpXcdpOlsM0l3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac+De4RskGZUqx37sww2rwg+lRwsAh13dooC6i+7gsQ=;
 b=AVevnOP3EXSV38wq3mzcQUgAU81/pPlMTeP2RXkRZWKkbN0csj6yie7ZD0cXVOXk9aVuTfewTd2rsuse+WZqLYb6Rul38zAG6ZXNI3aY1jrBiR4zpS2I/hwRvNfSUA3nA21/A0CEnzfq2NAhsO415nyfCp0r1NLB4Gi4fbVNihg=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1361.namprd12.prod.outlook.com (2603:10b6:404:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 04:58:28 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d%10]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 04:58:28 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/7] drm/amd/pm: correct the fan speed RPM retrieving
Thread-Topic: [PATCH 4/7] drm/amd/pm: correct the fan speed RPM retrieving
Thread-Index: AQHXctO7SUeEqBWn0UWIFCxjwUtrAqs280zQ
Date: Wed, 7 Jul 2021 04:58:28 +0000
Message-ID: <BN6PR12MB1283F9F008C51043CB8BB082F11A9@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-4-evan.quan@amd.com>
In-Reply-To: <20210707015647.139127-4-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-07T04:58:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=66065d3a-f20e-460f-a032-06843e2825b2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d9ca15f-db38-4fcd-dcad-08d94103dc2e
x-ms-traffictypediagnostic: BN6PR12MB1361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1361766E2C0039A865C97939F11A9@BN6PR12MB1361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkLctD75IBz2UUNaWdePARXWjBJn0VuDd7pZHgZXfYV62CARX9p36GNE5m4LKw+OgkF7r9jG4bz9KM/k3xdmwRFt75ismIqnO8gJpFkRoduLSfoe/DkZl0fEvBHARkEUN8EqAwn0vTXGSFuCI4ACmqWVTiAri31TsVm8MF6V6VoOO3NSzSdticr0tpDZsdaYqZtmDQbS3C+88SRZr2MyfWBI33Jc3f8u+lk+4HByhPbOdRKztgBmt/Mj47YYzFuvHOy8DaAV1Dsag9fMDmvcZM9fjSoBM95kvBIzbv3Cz29Y3qraruA4F9Ig4nm/v6qzJhxBXX8CA4qiCqshOthSvhPzhwZ/TJ/d2zqDhO07xxzP/VbtefNRhjTXg8kURPttlf627YyEzeF7p7/OIalzqJhS80B9qLRkudY982AtpOdNJ7pfcyfx5/o1Pq8xclZ0v0FPZSfngnEfTEboZm2zi98mE0FpYqd/UHG8Um4A7EIF9ovMhwTxzhTBoSPA3IDYYu8azdgcv8X9guXpcP3qB4tcDP/fh26dtA/ddNrcoqKIQz6ikwWUGenfN1Qtx2DDNodtRx8en1yc3hUJFk+FlASMJshBQymNE9GKAIu9sLacESOKO5gwleJHtLjiDbFfhhDeqxs9i51RexRTzicqpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(71200400001)(966005)(9686003)(45080400002)(55016002)(8936002)(26005)(478600001)(66446008)(5660300002)(186003)(7696005)(2906002)(33656002)(52536014)(66946007)(64756008)(66556008)(76116006)(66476007)(316002)(53546011)(86362001)(83380400001)(6506007)(110136005)(54906003)(8676002)(4326008)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+87LLwNOHQyDXoCkyaD5BvH0j62F7adYTZJlbgg7EU1nCwKUP3QVwFohATgr?=
 =?us-ascii?Q?xI2Bi4RkykvvQy+Q0ORah0n5LpQJuheT+SY5WsLLr9e9KMJcK7TK/X+yOiHx?=
 =?us-ascii?Q?9RZnjWK+yT8UeIb7LpvTNroJgVGEAsEqJxw+qYBputweJCR8A0A8vdQIrRDr?=
 =?us-ascii?Q?q2nJsfxePYhi0NSokW9bhGV543Swfv3gYCK7jR7UXwwSb/2FHXKJ0KFV8yMQ?=
 =?us-ascii?Q?v4s7P0PZ8EJ74UA0WOCp+Lz5JHkoSkdoclfZ3gwS5Tf9S3hBcQyNxgHW7isR?=
 =?us-ascii?Q?TXK8RSmXOexmdr/18Td2mIVqPRRX3Joy9QH+MHNEMtEsD11dwJOyo/iS8UrX?=
 =?us-ascii?Q?XCm4y97aIQU8jH7j6AUjv5/xSj+HsZ4hAEHAhQ+szQ4C058MgeaKe/KgMPnT?=
 =?us-ascii?Q?B7HrMeumIeRrs5QIa2dgC4d0YhvArpI2SzF7A+2NWLVfo5uPGPt5Q7IfMzqY?=
 =?us-ascii?Q?KmguaOHF54kNgY3T4rz8ofIPkEUJspmSZZAFhWoYYHK6FtvQyrG4EkgVS5//?=
 =?us-ascii?Q?xPKB40vPNmLl9iDkEJQnFzbamVtSOWfnqvkbidT6fd6jrNEltnRBEXe/gzKe?=
 =?us-ascii?Q?jO1J58HrPRQQEMeoTkHy1/GqXG+0npcrVguk3hVdjdk4EPouodCQ8h4k8oeT?=
 =?us-ascii?Q?MpWUMeudv1ZMsYukFS4/IClb7lJ5CipqBQ4ba+kJVM6iuTd1cJUt/EEpKYgu?=
 =?us-ascii?Q?731+DOfw+A07ySaEGQIaeK0leJo74BGZrwT+laVbuswgy6sae1LxAOSCUFBL?=
 =?us-ascii?Q?ojMpPDlxfPutINnRgnlL1/Xy9cbrviuA2AwCKiGEzj63NjYBydSyOfzjQkcs?=
 =?us-ascii?Q?0ZCCt3H8S2lGLhGaH11DAetBh3QvdfdTdN/wxqF62p6MPzuNpkfyON4bXpPf?=
 =?us-ascii?Q?yqbqCMeMlFz+UmCt9hT2AFwwQgNe+EvQzQkfVZkQmWM6pGqwNyBDym86HM6K?=
 =?us-ascii?Q?YfmpUbQ2mNZRW1lVOzvqIaR91imJJILTnVUsm71mGKxE7W8Ifh5OARdp30tO?=
 =?us-ascii?Q?Ja5KNkL4MdiWwZzM72E9BWe6t7UzwaVcWC1Ds3S1oqwJuzU5PPjBpqksxzQY?=
 =?us-ascii?Q?jw9JrI4uQxNMg7bs6XD79aZDrqx4qykJ7m4a1Dxtpy2Jr4qidXg3f12E7xFw?=
 =?us-ascii?Q?34tj60orCG3F6zOQk3f+JdWkvSqdaAgfwDkyxinLlTaM8cTuNRR7vykF7b0M?=
 =?us-ascii?Q?J1Q9C+QeX7lXgHaUGn1EGMLyL/o3vQwrcPZqmGiHRDjgWUM2mi0JWhbKVMI0?=
 =?us-ascii?Q?37A67qjNtrfqGIySnFjYC7SzG6t6fZ2rnccBZqY4kLMvR4hyNb8fl2lvb5EI?=
 =?us-ascii?Q?QfdE3vF0HBVWKPa7eI6A/cvU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9ca15f-db38-4fcd-dcad-08d94103dc2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 04:58:28.3052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUeaplpRmd6l7yzyr5Vsaq9j5zsakpMweZMvqd5b47DAOYi3vvWHGih0bX7juwN3ZQcZ1ateeJEKHktZwy0+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

A comment inline.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, July 7, 2021 9:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 4/7] drm/amd/pm: correct the fan speed RPM retrieving

The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed PWM and RPM is not true for SMU11 ASICs. So, we need a new way to retrieving the fan speed RPM.

Change-Id: Ife4298c8b7ec93ef023a7da27d59654e0444e044
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../include/asic_reg/thm/thm_11_0_2_offset.h  |  3 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 ++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 24 ++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 ++++++++++++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 21 ++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 28 +++++++++++++++++++
 8 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
index eca96abef445..8474f419caa5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
@@ -38,6 +38,9 @@
 #define mmCG_TACH_CTRL                                                                                 0x006a
 #define mmCG_TACH_CTRL_BASE_IDX                                                                        0
 
+#define mmCG_TACH_STATUS                                                                               0x006b
+#define mmCG_TACH_STATUS_BASE_IDX                                                                      0
+
 #define mmTHM_THERMAL_INT_ENA                                                                          0x000a
 #define mmTHM_THERMAL_INT_ENA_BASE_IDX                                                                 0
 #define mmTHM_THERMAL_INT_CTRL                                                                         0x000b
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index fa585f0be530..db5123fc6042 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -726,6 +726,11 @@ struct pptable_funcs {
 	 */
 	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 
+	/**
+	 * @get_fan_speed_rpm: Get the current fan speed in rpm.
+	 */
+	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
+
 	/**
 	 * @set_watermarks_table: Configure and upload the watermarks tables to
 	 *                        the SMU.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 8e0f8e9a1665..05c8fc8fc3f9 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -229,6 +229,9 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,  int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 				    uint32_t *speed);
 
+int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
+				uint32_t *speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 9a25443988e3..54fb3d7d23ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2614,17 +2614,14 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)  {
 	struct smu_context *smu = handle;
 	int ret = 0;
-	u32 percent;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_percent) {
-		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
-		*speed = percent * smu->fan_max_rpm / 100;
-	}
+	if (smu->ppt_funcs->get_fan_speed_rpm)
+		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4a6544b8e05e..e3303c8dcaca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1162,6 +1162,29 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
+				      uint32_t *speed)
+{
+	int ret = 0;
+
+	if (!speed)
+		return -EINVAL;
+
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_CURR_FANSPEED,
+						    speed);
+		break;
+	default:
+		ret = smu_v11_0_get_fan_speed_rpm(smu,
+						  speed);
+		break;
+	}
+
+	return ret;
+}
+
 static int arcturus_get_fan_parameters(struct smu_context *smu)  {
 	PPTable_t *pptable = smu->smu_table.driver_pptable; @@ -2246,6 +2269,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2ddf35788672..7dce5ea7c1a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1668,6 +1668,29 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);  }
 
+static int navi10_get_fan_speed_rpm(struct smu_context *smu,
+				    uint32_t *speed)
+{
+	int ret = 0;
+
+	if (!speed)
+		return -EINVAL;
+
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_CURR_FANSPEED,
+						  speed);
+		break;
+	default:
+		ret = smu_v11_0_get_fan_speed_rpm(smu,
+						  speed);
+		break;
+	}
+
+	return ret;
+}
+
 static int navi10_get_fan_parameters(struct smu_context *smu)  {
 	PPTable_t *pptable = smu->smu_table.driver_pptable; @@ -3182,6 +3205,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
 	.set_watermarks_table = navi10_set_watermarks_table, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e7686ce6744b..2f93dc4b5968 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1355,6 +1355,26 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);  }
 
+static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
+					    uint32_t *speed)
+{
+	int ret = 0;
+
+	if (!speed)
+		return -EINVAL;
+
+	/*
+	 * For Sienna_Cichlid and later, the fan speed(rpm) reported
+	 * by pmfw is always trustable(even when the fan control feature
+	 * disabled or 0 RPM kicked in).
+	 */
+	ret = sienna_cichlid_get_smu_metrics_data(smu,
+						  METRICS_CURR_FANSPEED,
+						  speed);
+
+	return ret;
[Guchun] More simple if directly return function sienna_cichlid_get_smu_metrics_data, then variable 'ret' can be dropped.

+}
+
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)  {
 	uint16_t *table_member;
@@ -3820,6 +3840,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index c49683b07076..0cdf55a0dba2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1284,6 +1284,34 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	return 0;
 }
 
+int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
+				uint32_t *speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t tach_status, crystal_clock_freq;
+	uint64_t tmp64;
+
+	/*
+	 * For pre Sienna Cichlid ASICs, the 0 RPM may be not correctly
+	 * detected via register retrieving. To workaround this, we will
+	 * report the fan speed as 0 RPM if user just requested such.
+	 */
+	if ((smu->user_dpm_profile.custom_fan_speed & SMU_CUSTOM_FAN_SPEED_RPM)
+	     && !smu->user_dpm_profile.fan_speed_rpm) {
+		*speed = 0;
+		return 0;
+	}
+
+	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
+	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
+
+	tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
+	do_div(tmp64, tach_status);
+	*speed = (uint32_t)tmp64;
+
+	return 0;
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C24bf2298a1554dbd9b8508d940eadc6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637612199748658238%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nB08a637vYeUyLJIcsw6fuDdjZaDUCnPIfDSQrDIIVI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
