Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B388C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAE210EF47;
	Wed, 15 Jul 2026 08:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMYLO0gf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8B710EF47
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYeQDTyt4bcygRm3CZQuVjzpzOtROX0Bi/ptYrdfhJtQoz9nA0RCVgidhWoTpMDpB3Upw8qMoauzekfHwsmArtzyHxbxx9lW/d7bkD9ECkZqT1B0V4ylE92EnOc1A3BIqe0BoSzu2WYBXpGCXO1JB7Vqrx6jnzAMcXYwwmrzonKyHEBoFduogG+O7+mKBA/j7qX+jVljV7dp4CfR6ox266AkJhi7Q2VkkvD2Q0KdGXWHCiGZEXzeDvSDHp8KGpRwUSoXA/xfYAfFRsAXQch47m34T2dTHYMOvB/oZnUDGZ+YjcZwHzfSocMKqsRSfPy2/Om6Igspi/1U6OTuMrYeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpUG9/QYQGUJ5LAQjsKohZV6vRTjyswB27IgPfb9tgE=;
 b=PMwZvpRzOOJnA3f+85P5VX6GHNxaHcB/qlDED+MbiCEF//s8ZDtA7jFK3uc1FhHk2uu0vrkGx1oxhOmLSUThTwzhvF8TIpq01q/MfRe6G5GdTYGxER0qjiLWSvWwZ43Zfs0CZyOirxzibXyKJOWrbHbpL3QVReC/ST+RbO2dkP0laq/8AHVSXuTNOdkixQ+Iyal1Su1y2w8sB4Ac02Of4FhHmC/9Ekcn1xzXaxCOFs6CrJqF841x0KYSYggcCnyRDBZuHPbjbneJ/XMwEbgnE5a8UcEDaAE5+gDGB6ItT1ZaHA5KXLMHQL4DwpnQl5TbdNI7d36wMF/GfQFQzVqmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpUG9/QYQGUJ5LAQjsKohZV6vRTjyswB27IgPfb9tgE=;
 b=IMYLO0gfN2Z01AZzDgAYrO7P4tiXpFyeOYQ4qoIcS9SiYMXKywfSuA21VfsEPhnwUwA+YDslWOjYekXBxLm6IwjSrD//goVPhBd2+xMxUoFkj10G7RkHbCeushvJ3O3OOcBW9rrEOKTBqV71VJmeyZUVIm8zUS8UQymXP97htGw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 08:26:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 08:26:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Topic: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Index: AQHdFC5DfJKfEjIwEkqufAeXQZgEDbZuPpww
Date: Wed, 15 Jul 2026 08:26:55 +0000
Message-ID: <BN9PR12MB52575849F098B6FD36227AB1FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-5-tao.zhou1@amd.com>
In-Reply-To: <20260715074734.2668631-5-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T08:25:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5594:EE_
x-ms-office365-filtering-correlation-id: 8cd926e3-cd54-4b6e-f075-08dee24ad4e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9eo/LabKiKbNDVJ5be7dUt+zwgy9tVbqSSos392xloI077Ns97SvzCZkyUQHF/1u1/7cZpUmFN8DmPOso3SdTjCSFnoVnaPiH6195IV+gIUO1x0XMCj864xAN37IJCyuGm08D8HIaxfggkx0p0BUAy6ZArD618RfV3oqnPBV74WVwxuGjt19+TMK0EqPvB5pKGuOnGX8Easc3hW3CfK8sM8nZnnBNxaF7RSpVJAGVKDjV4JZp+9u1+Tj5EZkZZya7t1ExpsDYqiA1oPAZCITxvh9Jr2S+N15WoiLsHCQu/OszP35aZvcQZb5lMFWwLVksyIkPSTCfyKR/MjCO7js86pREOHE3uSdYuOkK8otgS6v5/c3Ppm7V2HQIE3VL0K7btb33209gp/XqtpiwtPMjsPdYfhF0Hgltblh+2fZqRweUtyxACYdLQc3Mbk5fnF3xg9koprqBO6vgGRTe/uXXIVb30Cs6l7N/d6q3jVJC07ijVT9UTJUKvzTfi/QG+tMy5GKEAhFzl5WVPfTWvsl96VVOfBi8h40sh70Wla+lDt82gShLLdfLKuuQhWHRr1xVWA+Fq9DjxJNBv2B3nFDFpgL39J4d+/2qAYnTyRAn3Z/PB3/ayZywhEKgCbpjCHenWeMi4bB26DQ5qnHsFdn6SrqaY5lwX2+ijGJXP+gqDTQ5jxuQX0lrdkGiXXcRrYz1HAMbjry5KLIdXHjtkn/vbdd1h/wKjmRZn8mUQdhnDs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qFO50tIvn/alurLVFTv/v7DbHHP2HMC8IwV4hdpCwr9eBf/wNmcbFeGytKy7?=
 =?us-ascii?Q?X6n+GilPMx5vE9D7XBZb+4eHCaal0BFpZpbOWuBIOySpa5UqYZfFcENIQKgs?=
 =?us-ascii?Q?y5S7pWz0z0kNw9I0TswtjpIqjIaC3VgrWCAGTNX7bx6MjVHjeAY+1qGN/elQ?=
 =?us-ascii?Q?7xCnEl6h9fEDIocQbR5q/UhmOPAOGh8ZY6AQ+1nj2OjWxSaadputkR1obq8Q?=
 =?us-ascii?Q?nqm5ScSCxS+WYeSMyO0pXS61DIY5j/PMZMaPQvrxBRF+YlgbC8bW+nW2djSN?=
 =?us-ascii?Q?P0lGkmkpiCY3u9eiN+72ym5Zp9a2aS8RNsY5A9alTBKVOfuYNGBX9BuVtUsz?=
 =?us-ascii?Q?2tCbQD+DEtaoiCIg2xxeZLF3VUFJiFcluvIUUNGuM4pSnSgnSabx8q01jfUQ?=
 =?us-ascii?Q?GeeoNLIpm/UDAkNGLOlLuqaGmOsLkeXg/2lLm8KXcpwxTP6htXVN2BwsQFzl?=
 =?us-ascii?Q?eBLuHRDs/zIpkgiC0INxt7nCj6z379ykpSasey80/iyBRbbF4RJitxLmINXn?=
 =?us-ascii?Q?vmU4J56rme5uKaC1+/xsFLFxxuMMVCKX6RGmoSU8iLD6QE3cd6MQ2R5eLuvz?=
 =?us-ascii?Q?N7rhT7GjB6z5c7Ww3tnHwohoq2pmM6RDNQUcEjzNI/5CwThNvRBwn27Wv99S?=
 =?us-ascii?Q?VeVH8V8+rZ1ptpzrC94cAgkrkAh8g/yvSgsif5hU8FxsvI47MH3f/KoTfe7g?=
 =?us-ascii?Q?bfX7ckMQ+czNaDis5hfuB7dRe3/zJW3Q3FGfp9L7TZ+UpiqfDDZuSMEc7vpC?=
 =?us-ascii?Q?fv21K7SExEwDkGQcuk32RDxm8UsFHTsh5Ow8/ARI4MUtEDJT/lPebm8uoqtv?=
 =?us-ascii?Q?/TV4Ixvc2kn6X7q8z4tqrxYEgnt/AqrkRPM788fEeYZ4fS2H5zW2HzuRUmXI?=
 =?us-ascii?Q?JL0O8xCiMM7cd6QwMcVsAYd9AV2HMxNtTuTF6QYnm93tglOfdtXEJ//X3lRb?=
 =?us-ascii?Q?4FrckTbGXQYt2a7kHTmjZ8jDPgiELX0gdv+0KkAWEoNWGms80BzeZhz2+Auu?=
 =?us-ascii?Q?8m/n+M9VzdPNUZrdrdJRChrHH5m1EI3Cp+dTg/TVjNZyb21wyjRG7KMwry0W?=
 =?us-ascii?Q?801zk/Q89Z/VMaKA3zCErhYUEpgxEkuprFblScgZXphZF1o75zMOdRCRAIYb?=
 =?us-ascii?Q?BwF51XgKGO6JzR+7l/uGfP/PbyoJTkbzaI+iBw2zb5jN6HXmVdYT5+Srf/Dv?=
 =?us-ascii?Q?+iJqP3f8GhifjwTkYpyPNQ6vrAfVGKf4poS5NiE3ONbWkxT2QCIciXNvEOnq?=
 =?us-ascii?Q?PwVw/7/5hPRt/x+jSzmsdfyMO6EzD7o83edx9oKQu/8yafdy/WAH8Eb7QPTl?=
 =?us-ascii?Q?Bmv9Hcd+GjOfAAsozB5CwUTmiyUcDQGrl7Ca1crSXJ6VfjKifQ+SA6Kgw7EQ?=
 =?us-ascii?Q?2cqiXTiKl+m22vBPTiGKMKyXo6mcPYQxZT5eSgUtKaVdzjpMush9tm5MR3VN?=
 =?us-ascii?Q?MFmPFn0U+IFer0fUz3LYF/BrIQb6uvlU1jJzKmG7wlI9G88lnKChNBAiZ0J3?=
 =?us-ascii?Q?uRq7xikAhXzT9pWUSNAicGeesW1alXvj4lZsG6w8/s4vs3iC6b+QwHMk6kFd?=
 =?us-ascii?Q?L7pd5LoKli7SYra5aOOFeqDzgqnRQSrPNntyA6G9NERmAsRwz9fo7g3F7bC4?=
 =?us-ascii?Q?lD3laGehKyPvEyYxYfk2xPzg6nzK7phnWJYsalhAkqCZOMBGC1wishLgwIXo?=
 =?us-ascii?Q?jE/ywiG9WefCsXmeskWCCANwkgKsF+tclqkypROd/AsbsQ+D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd926e3-cd54-4b6e-f075-08dee24ad4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 08:26:55.9896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXifOnu34ZQ6oO6riA5tKG+CqM32iGPrLxJFjVfTBzqn9dvVi7hobPcHsoAVSpTa21yY6blTEx2s4ut75iFHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

+       init_config.debug_disable_ce_logs =3D adev->debug_disable_ce_logs;

Let's pass the full amdgpu_debug_mask to ras core

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, July 15, 2026 3:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras

So we can disable ce log manually.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h            | 2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c        | 7 ++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index c55288c2df9a..1e95419989b4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -310,6 +310,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_r=
as_core(struct amdgpu_dev
                amdgpu_ras_mgr_eeprom_is_supported(adev);
        init_config.poison_supported =3D
                amdgpu_ras_is_poison_mode_supported(adev);
+       init_config.debug_disable_ce_logs =3D adev->debug_disable_ce_logs;

        amdgpu_ras_mgr_init_aca_config(adev, &init_config);
        amdgpu_ras_mgr_init_eeprom_config(adev, &init_config); diff --git a=
/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ra=
s.h
index 5719bc1b6167..9d538a07c50e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -301,6 +301,7 @@ struct ras_core_config {

        bool poison_supported;
        bool ras_eeprom_supported;
+       bool debug_disable_ce_logs;
        const struct ras_sys_func *sys_fn;

        struct ras_aca_config aca_cfg;
@@ -348,6 +349,7 @@ struct ras_core_context {
        bool ras_core_enabled;

        u64 ras_fw_features;
+       bool debug_disable_ce_logs;
 };

 struct ras_core_context *ras_core_create(struct ras_core_config *init_conf=
ig); diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/d=
rm/amd/ras/rascore/ras_aca.c
index 67a35409ff0e..9760894c4c66 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -98,7 +98,7 @@ static void aca_report_ecc_info(struct ras_core_context *=
ras_core,
                        blk_name(blk));
        }

-       if (ecc_count.new_ce_count) {
+       if (ecc_count.new_ce_count && !ras_core->debug_disable_ce_logs) {
                RAS_DEV_INFO(ras_core->dev,
                "{%llu} socket: %d, die: %d, %u new correctable hardware er=
rors detected in %s block\n",
                        seq_no, skt, aid, ecc_count.new_ce_count, blk_name(=
blk)); @@ -114,6 +114,11 @@ static void aca_bank_log(struct ras_core_contex=
t *ras_core,  {
        int i;

+       if (ras_core->debug_disable_ce_logs &&
+           bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
+           !bank_ecc->real_de_count)
+               return;
+
        RAS_DEV_INFO(ras_core->dev,
                "{%llu}" RAS_HW_ERR "Accelerator Check Architecture events =
logged\n",
                bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c
index 2346918c7736..cdef7727decb 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -377,6 +377,7 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
                        ras_core->config->ras_eeprom_supported;

        ras_core->poison_supported =3D ras_core->config->poison_supported;
+       ras_core->debug_disable_ce_logs =3D
+ras_core->config->debug_disable_ce_logs;

        ret =3D ras_psp_hw_init(ras_core);
        if (ret)
--
2.34.1

