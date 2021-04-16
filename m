Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36868C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 04:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F35611AE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 04:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F35611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBFF6EB1A;
	Fri, 16 Apr 2021 04:20:41 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6246EB1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 04:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0odhRIzUnjzjHmYb4CixnuUlYSnnccVopvXCbgIRf4IARW8Fw2iILOZYkTfSgdc9XcmnSdISc1W8G2Ai52G3su7fvmVf3cV4awKeJaoHEy3bBJ9jV29hS40ymlU6+M+6Zi6j+btRHwaUYg5jccbG2uup6b6TpqOgbgzOOJCxDWCNpdKAtvEXfKZxKO+q+jpqeRs/iUv9sFmsn79uuqDc0CZKzQ0gB2/rYHdA71UW0NTxxXaTU9rxyYI7hkRdGAQ1HYs5EImENbAYngsyv4v3jq+SkVL5iMaTKbbe7zttM3qyn0K9VcLFUGCuYQJgYpNSmorIqH2nYaMN1I4AD6kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIZTt6jfZktr2QBL6TennPVwSkOidt+/29LRJ1zvqmc=;
 b=i9M0P1fgkntqhuLhx9a9Q19OPGPzh2gZXdw4qG7FyDELzaVYQwYfnDDtSaitWrqHp9kVdNpfMjyC9yf/Qye/6bo0L0z7W7R9lW7q7fx+zHJ1Xyzy6/X8ueFkU8b/q7kSkFQN9zjjso+rIbS1OQyMByelwWFETfHRTGsUttoB50MtD/meZIZCVSJX08svAb86vgn+oHprwTvYUa3tkHY0IwptmdrO42TxQXs8Nzc7mRYdPjoB+JpRKOuo+vUiKSs/WT4fYnsrEVGNTJrp26GMuSK5fkZpPgV+mJaTM3oiG26ulVFwmhxPuhGNcrao0i7xAsdSngaHA3FVbQcjOZzzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIZTt6jfZktr2QBL6TennPVwSkOidt+/29LRJ1zvqmc=;
 b=aR9eR5aK+V9WX33Ztb2R8e6TnUY4v3j9FMg0HxaE/741nUni32/ou3BbyTBI8aOb5FJGVkAUhW9BwoCtlINRZB73RhwyJ1FGChnkzYD2gdv16gbf7eyhmPME72rqHOq6Cxb75TSeYA2xvTK5xNob6EvsQpMhw7uCQDDZyIV1w3w=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 04:20:36 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%9]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 04:20:36 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amd/pm: Add interface to get FW private buffer
Thread-Topic: [PATCH v3 1/2] drm/amd/pm: Add interface to get FW private buffer
Thread-Index: Adcyd4DiEDmRxXYKSQ2XhS0o6gRIUA==
Date: Fri, 16 Apr 2021 04:20:36 +0000
Message-ID: <MN2PR12MB4549E0754E479AF8E7FBD235974C9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-16T04:20:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=77bb097a-6625-4ed7-baf2-8026d8aaea2a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.218.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5324f698-8d99-4e52-0579-08d9008efc3a
x-ms-traffictypediagnostic: MN2PR12MB3885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3885B079240C8EC200830389974C9@MN2PR12MB3885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1/Dd86C9gRfavWK+o28Dyfg/5xHiAVZhUUZSem2ASQ1nc5gI+c/5EjuVyCMVUR6jFrtq01wjtcOVINh1gG4kho27uL2zDsgBMlZWVedgKMLgISHpvReCx/aaZ8aXo3kZx+tvvidI6+XAPvlhqFUBxB3toKrDA4RYSb65O884pxSaGR6UUg7p7V2YlsekKGH9Me/+fECcTikse82t/CcQMc6yElUybci2xw4I6Ed7BsldZTytoudI/Lv16va5uuIdq4sAdcdec9QUdULtBA1ARurmzojpvtUi9qKk2MMa7bbphY1epHTjN9ZjtOjsprVhVkCQu26ONuUcMdGZohiJhb9UrCd0BJ2wrvclwHLXspl8u8DwQkUE3zeiJLfNUKo4PvlP/snCzetgI1uTdWYqBVXQKXTeeIuPGn4SF0J6H/ccsgrd5WTd3rhCPE98s3i068HC3hpV/eH6p5NtcLlHpeTQ0TLAUIDV1BoCtObKg1YC5ggdZtXboy2yi14VCUerLKkFx+ZeQiipP2wU/HWBSd/cr3esgT1L6uKDtSSLZOQb6vST17HASQb8j8+RTNwrMBdZOyx981b6X/RDqUqfcZ0e7ORcnDT4CYA45/eIRM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(71200400001)(316002)(478600001)(52536014)(2906002)(38100700002)(55016002)(8936002)(6916009)(186003)(26005)(8676002)(55236004)(6506007)(54906003)(4326008)(7696005)(122000001)(86362001)(66476007)(64756008)(66556008)(66946007)(66446008)(66574015)(5660300002)(83380400001)(33656002)(9686003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?r+4MPWtke0PDEGiZwO22NBQVzvO7qFBOLUU1ljGF32Cm3xKo5yqAiYjCC4?=
 =?iso-8859-1?Q?IXrizOyJULvLnvhS5+vRHyj7cLF73YfcBYggIMqtPC98fZTINFJT9iEbrO?=
 =?iso-8859-1?Q?ifx1fX2oMQHaGWIYvL0bfeb7um1j9B3GLtafPjrz7+bZKbKoWIC/gEqKeS?=
 =?iso-8859-1?Q?t3aR381gvmyw2/Gt7Dyfpx7C85fcvFkqHMHct/HGAG5XVwJNFBgJdd9Cci?=
 =?iso-8859-1?Q?qrhq2+PfL/YB+kXZ1m644Qrh6jMYj3osWiESrFAYAIPssmmGIpgKuNA7j2?=
 =?iso-8859-1?Q?uhnjP2y4LjAbh2M2MdMrMrxOSTlc5EUEp++K6Z8Zvjz5mN6VGvg40Je8sp?=
 =?iso-8859-1?Q?jYTeJoNqsc9ahpX66qFTxMVfH/6cfXNd3c8P5ZefCpegQOBvR+UT0crHqE?=
 =?iso-8859-1?Q?Dfrs5eKvbg+3C66a5elHozIbPQUaUhltuCubjVMjAKBU5M0rczY6fm5+b7?=
 =?iso-8859-1?Q?cxA/rpAGpgVNkn9UAUUKSeIkSojVi4ldBQdMI53tjcrc7pxDnb8xge4EJx?=
 =?iso-8859-1?Q?E8mTzXk1zLp9Sm6kYThQ2rcdZQDEDWueV2bBVzRFaqaTTqfaHROnutQt6B?=
 =?iso-8859-1?Q?kD1XdV8bckTFM87TzM5TDPPNLZkqEhwGLD1ERPQLlsYUTDVI1G0z6i/wTX?=
 =?iso-8859-1?Q?Ap+xwgpIqd0ckehBaAetiIoHw640Jm1BuFT1EVyDqWFJeWzku65TZMED/p?=
 =?iso-8859-1?Q?acxycM/wiFXFIZS8HViB+upkknKqTaPNzjrBYAR+Vxm0kjHXVA4dUYm1+J?=
 =?iso-8859-1?Q?g0lg1ey+SYG5G1grsX29vsuyBFLWWZbWfzFtgI3SDqFcy1RkyGa2ht+joA?=
 =?iso-8859-1?Q?2gy+Rd49ikjZoTcDJDub36cMYYaqKdYR6TvnirD9FeeHQMinbC5Ywy1Y+z?=
 =?iso-8859-1?Q?NUCaSol01vmwlzcU5ipTEQGF+qoza/AHbtO3RJXN81yZ8NTuUy7pDHiEFk?=
 =?iso-8859-1?Q?8/5zZFVJmYgIYxl9u17ftk/csXC1ly3QNBKvNa10Z6kmQ1Hew7QWbTqZ04?=
 =?iso-8859-1?Q?NEAMYzcM+1KZqzrQ4cyqXN4rB/u5j/jj/ZyZuycWpgP6KMntDs/aS16kT/?=
 =?iso-8859-1?Q?K5oEfq8E7W1HzDTUDeOPx6HL5jNdg4MarGUizEhTHD3yeiKHaY177L3FSm?=
 =?iso-8859-1?Q?/M/+mh0fWJ/dp1bOG6JjDff6Tdwix8TWW06JKMncShQwORBaPP8v3YyRlr?=
 =?iso-8859-1?Q?Ow6QXa2f0oaQb/26XtUeb/CgXM0KuV0XeYZZYl+0Q+TdS7LwxkfA/vmoyf?=
 =?iso-8859-1?Q?W/EmPBHTWkoaFaYv04xkWKxE1GOPzFnRvqTKm38rLE++eeM+XfXPknoJI7?=
 =?iso-8859-1?Q?KvKMuTOr7KsbvXeEfXczrHdcHfAAPkGF1zBNDXlggsIJHWyuIW665pasZ4?=
 =?iso-8859-1?Q?Dk43cI8owV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5324f698-8d99-4e52-0579-08d9008efc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 04:20:36.5199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gP10SRCgAfizJ/QLiwN8XAFe9ZJ9xqSYAFtwZd9O7sdrPJsO/ObxzfsW3bv8OTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

v1: Add new interface to get FW private buffer details
v2: Drop domain check
v3: Use amdgpu_bo_kmap to get cpu address

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 21 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 353468667036..abd5a9d41d4c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -350,6 +350,7 @@ struct amd_pm_funcs {
 				   unsigned int *num_states);
 	int (*get_dpm_clock_table)(void *handle,
 				   struct dpm_clocks *clock_table);
+	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
 };
 =

 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index ee6340c6f921..c73504e998e5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1651,6 +1651,26 @@ static int pp_gfx_state_change_set(void *handle, uin=
t32_t state)
 	return 0;
 }
 =

+static int pp_get_prv_buffer_details(void *handle, void **addr, size_t *si=
ze)
+{
+	struct pp_hwmgr *hwmgr =3D handle;
+	struct amdgpu_device *adev =3D hwmgr->adev;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	*addr =3D NULL;
+	*size =3D 0;
+	mutex_lock(&hwmgr->smu_lock);
+	if (adev->pm.smu_prv_buffer) {
+		amdgpu_bo_kmap(adev->pm.smu_prv_buffer, addr);
+		*size =3D adev->pm.smu_prv_buffer_size;
+	}
+	mutex_unlock(&hwmgr->smu_lock);
+
+	return 0;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs =3D {
 	.load_firmware =3D pp_dpm_load_fw,
 	.wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete,
@@ -1714,4 +1734,5 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
 	.set_xgmi_pstate =3D pp_set_xgmi_pstate,
 	.get_gpu_metrics =3D pp_get_gpu_metrics,
 	.gfx_state_change_set =3D pp_gfx_state_change_set,
+	.get_smu_prv_buf_details =3D pp_get_prv_buffer_details,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index e0eb7ca112e2..849a85ea84b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2932,6 +2932,26 @@ int smu_set_light_sbr(struct smu_context *smu, bool =
enable)
 	return ret;
 }
 =

+static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *s=
ize)
+{
+	struct smu_context *smu =3D handle;
+	struct smu_table_context *smu_table =3D &smu->smu_table;
+	struct smu_table *memory_pool =3D &smu_table->memory_pool;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	*addr =3D NULL;
+	*size =3D 0;
+	mutex_lock(&smu->mutex);
+	if (memory_pool->bo) {
+		*addr =3D memory_pool->cpu_addr;
+		*size =3D memory_pool->size;
+	}
+	mutex_unlock(&smu->mutex);
+
+	return 0;
+}
 =

 static const struct amd_pm_funcs swsmu_pm_funcs =3D {
 	/* export for sysfs */
@@ -2983,6 +3003,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
 	.get_max_sustainable_clocks_by_dc    =3D smu_get_max_sustainable_clocks_b=
y_dc,
 	.load_firmware           =3D smu_load_microcode,
 	.gfx_state_change_set    =3D smu_gfx_state_change_set,
+	.get_smu_prv_buf_details =3D smu_get_prv_buffer_details,
 };
 =

 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type eve=
nt,
-- =

2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
