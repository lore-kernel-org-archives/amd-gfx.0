Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A0AC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 06:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292D210F60F;
	Wed, 24 Jan 2024 06:35:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9E810F60F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 06:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMg+4zT7ZeBun36GzOQYMFPjbMeJbZx2D+JqybBNpHcQoD4w9y+TdG+NDnusEbTDXOGE6pkYhpUKwF5pmerttuhqzvisFyiqxpzsKHyiXbioryVTZEYAuUbnvZr/8fGmuZsFOAN8g9wweN4yLK/t+onhzyzLSF2gy4Bko/VX644TZKu6eyzCRQsjNeQXdWqwezZwZ4O6ZTpXRE+n4cvbNoKVvKbxQkxmonTZWd7EP436YT6+PSzesWcxQNsNFvp/jVuVdoJMdVEhyRRpXNYP2zWdUXVPZwQtLPbCrIaQNI1JUK4agdcVDsUuL2nyK4lFizH0rXLxfmBXmqMc9BFuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbznR1OCayCSwnCS7s8xh4bzfWKBcVsQmhD3IzY5A+M=;
 b=NksGMW0ExEpTDDPqgp6vPk2sXeEb0KxnX39j320rS3GBp6W1t3Ym58VZoZz6d8vp8AKQx23l9KUqjgI06NdLrOWctBPNF26ZQKuFnbLM7Y+wArZLt8yNDvQY3Ad7GQK9/fryP7Fo8sOid0Ge+58BezZTAeCxmRnXLS4StN8nRmqJBPkhaUYV5kMUgJT/DQu813VghVPyND60PFRHMziALLBPteHD6fLKjh6WUjwYQSGoCeifc7sdZ3JtZNr8NGzHSg4dv+fbkkz4yKsMIPmEwaBdhnI6yD98N97UGPo/ve8l+fwz7cJ8lG8LKfy/HBpU4LNLysCqp3hhnrEvbpndUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbznR1OCayCSwnCS7s8xh4bzfWKBcVsQmhD3IzY5A+M=;
 b=BPXsMZ6odihHqtA5YkgBWOF4Qj6C6m0jUuhW9y+fuSaVrvW39FMR0A1SiF3cJFV98YSequU4S9aFE1yqL7Lsf2JfR7m2/y8f+xjVXonmla/V16iOE1SCXP3n7Dh9yWYFQ+V3ID89GXhA8ifA24Ej7r+BmypWZV71EJzND16/h1I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 06:35:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 06:35:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: adjust aca init/fini sequence to match
 gpu reset
Thread-Topic: [PATCH 2/2] drm/amdgpu: adjust aca init/fini sequence to match
 gpu reset
Thread-Index: AQHaToqOwo7S/4JPK021dS474KrbiLDogaMg
Date: Wed, 24 Jan 2024 06:35:17 +0000
Message-ID: <BN9PR12MB5257FD2F5280446C7F869F5FFC7B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240124055915.3886458-1-kevinyang.wang@amd.com>
 <20240124055915.3886458-2-kevinyang.wang@amd.com>
In-Reply-To: <20240124055915.3886458-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c71558e-6956-41f0-950d-d790f9b6f00f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-24T06:34:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7630:EE_
x-ms-office365-filtering-correlation-id: 6f9de59c-d1aa-4cae-a985-08dc1ca6a17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: matX/GOD7MnwwWMkxm0NylY83iivK/Ic1W/zVRkQh9VV9kxw2Xrt0ySrkOcKG+hJfFtayoAcbMNq5LNyrUzMKY6sKB/7VOm3fZw3WjcNrJLU48MxDgkDGw3FaLsPkt6lq88zV1+en7bZ2nLwftHzOBCrlzZg51uGE7hYjVdBLdQKqr/rSc+VhuvZhIrtwfVSLRMQX6OQ5WRq//cT50UlKv2Z1ZojDOldnqMZsnXz+2lzhIwsV8AwGBFanXL1TygQDXvnwFAYNe1n/BM70+AwZDrvU1DU5kkpps4czdmIH9aeHi89fN1Nd2Nz+LsaFkAWmlS9nMkuJtPT8V8NPU5F+a9cIPQ5zBqJ1LK7LQiKtlnE7wKee3Nq3xPJ4dMBotXR/jkbpu3bVSE9bWn1hJg9eE/s9JmyaJ4AnqhYtPNdfMe9Xml+sRWUctkDDhiQ//2+f3noH7vpJ58o5aa3pxoPZS5O/1uu4+EL+MVAzYyOTl/0BXR4gpUb+BTxWyGJ6D1DkffYG8IGTvs8M2Cs/wP67Zb2F3iOh1WXkryP5+uJ4V72lUS/ZOSXA/rf/iqlOuqW0iayuxv0l/GQQP3E8bhm5ONUl8yiHYxW0JM/GjQduNpftjJ/l98JgZKQT3YM+JaE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(52536014)(8676002)(8936002)(4326008)(38070700009)(83380400001)(122000001)(55016003)(316002)(2906002)(41300700001)(33656002)(86362001)(71200400001)(66946007)(5660300002)(26005)(66476007)(66446008)(66556008)(64756008)(54906003)(110136005)(76116006)(38100700002)(9686003)(7696005)(6506007)(53546011)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x9iqm9aNDo8gh4UoTjh1jTfLAiitP2WZz/1TcbSqDDYeHtu4PAv8qnmJBOwx?=
 =?us-ascii?Q?JvpRMOxOQBv4U81veEbpwg0NihHR5oDqRgF3JtZgGu8gc6i37GNk4fvcgQXS?=
 =?us-ascii?Q?3ocjWm5hvnpiY+WnelVpcc+o2fvAfL1MUzvukXTFKxNoACyJ6oachVURLpEo?=
 =?us-ascii?Q?20lp/TQy3XMZbQPMZnvLeb1FUARf3Mml5bVcT7J9Xcacg+1vo7OVyOHvG0pR?=
 =?us-ascii?Q?Gtbwx4YJR99Zqgp+bgql0kBQd5Y/rKLWaADeXUlvqKh5d+7o6q8bBEADXIGf?=
 =?us-ascii?Q?OEZrRaWKBOpzwxThXlOouFq9ItJ9+5Ysgmq3qdbXRQnV9qz35SjkE+7X+rk2?=
 =?us-ascii?Q?oEOgNNArB+mNDtmlFv/SpV17eiI1clNj64isoQrTbhRU3TtnTNG0SXafgizy?=
 =?us-ascii?Q?3VMtsre2F+1RrRIXXbswtP7qYIZOV/ZtCx0taHuUIiwraQC1P6z8h45dDjS3?=
 =?us-ascii?Q?E+HDKGJhbVey3GNCZt03FGufvcaBTz6SHpA/R0Pi7dBzeQd/6ekVoKCl1S9l?=
 =?us-ascii?Q?dk0VvcwPWaa3ewwKaNo9L7ACJNoEwX6tqyfuH205x8xiqVZbAyJo+mF5qw4i?=
 =?us-ascii?Q?8ecQKqSuNso+iNzBm7m38qX1ztbp0SaFTxkZWWCSpNFn2w4di4trDw7hlebo?=
 =?us-ascii?Q?1pZkUXZSYcuWn8kGYLIkPGcVYxR16+Hd6qyNjXsQMWGBiJIHxacqkjTjY3W0?=
 =?us-ascii?Q?3BO4mehyEYzP43TFG84V//xQhzCOnw8yfEzmLEX94lbaSsl8HzQlvkI2M7co?=
 =?us-ascii?Q?0weZ30p8EO+SC7knwfE2WeJjxIkRD+rd/F3vlV3yfZCU7SjUlQwDtSsauI6/?=
 =?us-ascii?Q?6x5h5dxw34hQgnpTT6o24HADBeo6ytrJAjVzEsGkwuFzZfh1xTqkXqLPMbFr?=
 =?us-ascii?Q?G8l+++Eeq9myZMQQt7rRT2U9MqeJuATdfih09CjUHmsol5CxZCl3LuCIbmQC?=
 =?us-ascii?Q?oaej1FamEgfRfTGrbYiMYzdanuolAX1EobY2aFSBl/AKv39OkQeVCl25Q1bm?=
 =?us-ascii?Q?n7gjKm0zfRuiwe89KYDH7P3z2ZD63ZHAJ0Ohs1PSIYj34sQBMOY40EIp3uoo?=
 =?us-ascii?Q?iZcrM3gmR6wRqLdAKGM7vA6RgTpemeFoYokklT96XylvyiweJRbVtIrJA6Fl?=
 =?us-ascii?Q?H5GK5l0VcmzJuzjASzqSJX0FG0AFRjIDtfGBt4hY3qSDWME0unQjG3KQXsZr?=
 =?us-ascii?Q?LFkPW9Pr3f0JNTi6mBqLhBXXSPJ7resXMZXG6ZGH8ErGyVHrV1Ncptk2D+NL?=
 =?us-ascii?Q?xYBAOPn516MV0Lu1F5WHSCYyfYSN906mb5ejbG1Xy5se1Aekac6yENqbPjTI?=
 =?us-ascii?Q?gWaUZJHpiU+NtoJL8Bz40A9e2svPyHpUbOL1ZV909JlUrfo9MAswFejusbER?=
 =?us-ascii?Q?irBAr3AHEDi3grryz97OwfK5iDvjK9Gv9Ih1GfEjMLHdrW3cDRX7Z6cfd3XU?=
 =?us-ascii?Q?Pxs7FVlpfynJJMtv8uRi8nByLMcYXXlD0vaRss4TJtJBdZNZDfEhVrhidFJH?=
 =?us-ascii?Q?rBygReJxQIw0RcOt+6QNcuD/eouO6O6/SrE9Gce69T4jnL7cDgOBo8h4vTR5?=
 =?us-ascii?Q?8gZlGJF7kCvbbw82eTXibcZkhJKA1THUrT05+sfP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9de59c-d1aa-4cae-a985-08dc1ca6a17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 06:35:17.8739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQYmCqKNhGKTk+xPoC6mkAUZ0E8crH5wvyYNwSvo5mkGDsTB9tNelpmB70CQ61hBW+C3rxp9kWSMnXmdu+QiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Wednesday, January 24, 2024 13:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: adjust aca init/fini sequence to match gpu=
 reset

- move aca init/fini function into ras init/fini to adapt gpu reset
  sequence.
- add new function amdgpu_aca_reset()

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 15 +++++++++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 52a0ea2f0ebf..40c1d5c4a9d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -688,6 +688,13 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
        aca_manager_fini(&aca->mgr);
 }

+int amdgpu_aca_reset(struct amdgpu_device *adev) {
+       amdgpu_aca_fini(adev);
+
+       return amdgpu_aca_init(adev);
+}
+
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca=
_smu_funcs *smu_funcs)  {
        struct amdgpu_aca *aca =3D &adev->aca;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
index 6e9a35eda683..2da50e095883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -185,6 +185,7 @@ struct aca_info {

 int amdgpu_aca_init(struct amdgpu_device *adev);  void amdgpu_aca_fini(str=
uct amdgpu_device *adev);
+int amdgpu_aca_reset(struct amdgpu_device *adev);
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca=
_smu_funcs *smu_funcs);  bool amdgpu_aca_is_enabled(struct amdgpu_device *a=
dev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 56d9dfa61290..dac73f8fbda4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4039,10 +4039,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,

        amdgpu_device_get_pcie_info(adev);

-       r =3D amdgpu_aca_init(adev);
-       if (r)
-               return r;
-
        r =3D amdgpu_device_get_job_timeout_settings(adev);
        if (r) {
                dev_err(adev->dev, "invalid lockup_timeout parameter syntax=
\n"); @@ -4437,8 +4433,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device=
 *adev)

        amdgpu_reset_fini(adev);

-       amdgpu_aca_fini(adev);
-
        /* free i2c buses */
        if (!amdgpu_device_has_dc_support(adev))
                amdgpu_i2c_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5b519dc4df01..f7c6ea60316d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3348,10 +3348,18 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev=
)
        if (amdgpu_sriov_vf(adev))
                return 0;

-       if (amdgpu_aca_is_enabled(adev))
+       if (amdgpu_aca_is_enabled(adev)) {
+               if (amdgpu_in_reset(adev))
+                       r =3D amdgpu_aca_reset(adev);
+                else
+                       r =3D amdgpu_aca_init(adev);
+               if (r)
+                       return r;
+
                amdgpu_ras_set_aca_debug_mode(adev, false);
-       else
+       } else {
                amdgpu_ras_set_mca_debug_mode(adev, false);
+       }

        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                obj =3D node->ras_obj;
@@ -3420,6 +3428,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
        amdgpu_ras_fs_fini(adev);
        amdgpu_ras_interrupt_remove_all(adev);

+       if (amdgpu_aca_is_enabled(adev))
+               amdgpu_aca_fini(adev);
+
        WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not c=
leared");

        if (AMDGPU_RAS_GET_FEATURES(con->features))
--
2.34.1

