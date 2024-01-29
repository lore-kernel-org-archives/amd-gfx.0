Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665A6C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 14:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A4A11292E;
	Mon, 29 Jan 2024 14:41:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3378811292E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0n1Kw+PrkJ0Y4H7tWMe6ssncEt/B7ZGY6i1wDR/WqVvegMkMip/gc9kJbIDevagdvNzcIUqRR3BHKF0kfBtKJAUDedSvQi4C5h0Q94OrSFGxmYIF2bn8amNvAt7pZruAfJzxsJ67VXA9My0Rf8J0FXvi35zYL2yoqwER2LVSfA//HECF2SMqkLx7HpPuBtIReXTGld2DgT6EdZt/UpqnsE3cyyqd2Bpx3KL2gIjFij4me7Uww1WfOI64J5PEu/XJXtUfQMVvC8ndrVoloWENc0wOvie7XkYBqphbIBRs0qMl8o9hXfU0Ri7h/7x75ALBzAZRCzIw2VLts73qdovfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N5DjKlmM57kxo5yGyTe/9hhxsaG0priNMP3Dm3mzZU=;
 b=AGNI25mKV2bTxj/MaBfecACwp8+Ou7e5hDZjlOxdpp0sulpVe6o0UHQCCUBbzEAuXwDUQrVxJAlr5cAIXNP/dEZNKmQ6hxYaEB18LYLXxaNKcmTcGgKiXYRjpE/MQv0YKpdoIthSKtqsL2B7L8wtGzAb5gYBO3u4UQ+9c8bwN2Yvu3YeYWAf5iFrzxSgWhlxgExhFSOpEXqtZUKddjS8/x9HIH1VIJ99Lp8AnP0T++CAOiugWpj/V/oQqbc72WyFHpeLhJXA/j3QiL6R5mussic70CDBA2fYjReWNwVwqXCpuAYswRli4SE4IE2Ir3LswMaqKsqFJFmng8OUaWb92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N5DjKlmM57kxo5yGyTe/9hhxsaG0priNMP3Dm3mzZU=;
 b=lgUtOZHxvt8OxlS+hsVyLrUEjUK9JDkuhRuiV44s5JEEZUkg4t+BwvYhI4KL1AKyHd7jsCC0d6Sw1BXDqg/wc+WnsNwcZQivbwlFez8ALC8pFj1TyYo1BSpjqGl1mTPPmGSybB0/tw7ldbcMhdt2hXgQ9m+eFlqmhQkv6nse4k0=
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 14:41:13 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::d370:b4a:9285:26ab]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::d370:b4a:9285:26ab%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:41:13 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update boot time errors polling sequence
Thread-Topic: [PATCH] drm/amdgpu: Update boot time errors polling sequence
Thread-Index: AQHaUsBrc+Dy8iMfTkiLSaUeyjo8o7Dw2+RA
Date: Mon, 29 Jan 2024 14:41:13 +0000
Message-ID: <DM8PR12MB5462109343A3BC49AA9A96A7E97E2@DM8PR12MB5462.namprd12.prod.outlook.com>
References: <20240129143452.16596-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240129143452.16596-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e4f747f-7618-474c-b11e-c694cc64856e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T14:37:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5462:EE_|SA0PR12MB4496:EE_
x-ms-office365-filtering-correlation-id: cfc0e57c-d7a5-440b-e355-08dc20d8578e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMKHiBVpFltKEwOcJya1+S/IFMblCRDmGyYXwCnoxj5dC6FCRXfGoFAvZHCdnGxRGAnzr94Opf664wqE6q14dbp+SOVdcmvWcMFQ3WcP1wyvA+NmkhLo/sXjlEhb9R+ONIcolc6AfHcNaSsh+ReCxlq62MbTWiCFA7l+xDArf6FbgAVi/2fvt6FhYV5/vf7+Ilvpg2LcBPtPN7OmvQSeuqBYBzVP1vBoBemSanL3iv11jnzmjevu5qRIoTe7KSD0QlpbTjQrlwm8YG11J6uG8zIqgsnHYHgCRg+L6alUAOuebmub4pr9/S0YLY7+DqtihSZI589EDwgHUKOmkVTVNT3Jyf4XeV9f3mBs0iFGYZ4uNNbm+D3ZkrWjxsqSK/OSfcQK5fisW3He5BpIZgmfnx2Wlzs/b2Rgq7MqeRjOfz455EeNfaCfy45shP/89Da3tvARcDrz+45fKLFDHphIBz7cw1B8pvN74YEPp9lif2Hcpu1EwtqWr9itB1oxr3iEYIAEPy6pcEoQaaaMHdHyWjTJX8d3MK/yUnrPLTegVfWJ3qPt4vj6pT3qPJIE6tLD+MZK8uTPsYNjrJXTLtmQ0wlyCCIhjtVaTx5lAZMmIRHxvJBXLr/t7+farvO17Ojl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(53546011)(7696005)(6506007)(9686003)(38100700002)(122000001)(5660300002)(66946007)(4326008)(8936002)(52536014)(8676002)(41300700001)(15650500001)(316002)(478600001)(71200400001)(2906002)(66476007)(64756008)(110136005)(66446008)(76116006)(66556008)(38070700009)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ePNt8ELkh3Xgl4KFXMbpfLLXPlY2i37AeKGJDiIOqXs31Gai3GyLPGbAkls?=
 =?us-ascii?Q?/vxPtYccnT3nB+iZq1y7OyARGcRqkAwhT+HopaRC4Zm4N1J2+wnleQBwdesm?=
 =?us-ascii?Q?g4Lwa0mb+5YHwQh7MUz9leXeAALKyPetW6ZORZLcuhLFhzGU5WWAFiUgpWd6?=
 =?us-ascii?Q?ldRFaTitimv+iPCeDpUjZxVR1dKtzlHTBz//hG1to1e7ogm3JCG9UzW3kVQu?=
 =?us-ascii?Q?g1K2eXI3Etqj4W7vAElh+QVCthHRMLBzd7cnAn3PkgOIusF48cR7Rn9jYRx4?=
 =?us-ascii?Q?N/z8nrvy7mSdVxQHHnrPHnM8LLp/nfAt9TET8Lp4pW2D9d/K3S5VPhBWq+CY?=
 =?us-ascii?Q?yp+AYZmfwf4+ldXsUeuhifrxiL0K6h4n5bltMPzrcc0dM/hGDuUWYxD8GNFs?=
 =?us-ascii?Q?qS0J3ZFIrn7oESvoIS97IHU2aULqYe1/wNYYyUd+xd5sAOr8rFb4RWhiM75T?=
 =?us-ascii?Q?AUI/6t0Eovg5u8BNeni5Hb7qwnlbTZ5vA+LFfT20stYz5BqxOqR9diKPPq6n?=
 =?us-ascii?Q?0k0Kcc4Y9H3xjgQNRiP7yHjSQfLlYvz0uGi4GgWGjMqsYuUWrcWtslUXtQQS?=
 =?us-ascii?Q?+nm1TUfeunfNPkXrn4OZz2BB3K5DtTj84m4zg6gTXlrzcDsTrybpe/ucw4ZK?=
 =?us-ascii?Q?zjmBDm4IEzIAZGA6jDB+OBCjawPGsJ0UAq09GVmDjCz447vFmHyFb0SrikPV?=
 =?us-ascii?Q?dHktR4crTo2vk6zuuiEfg3gX/jezC7rHGXvp9hrm5WxXIvxGhXSu+YXBb6nV?=
 =?us-ascii?Q?sr+rlcxTY2QsL0S6YsYJxR4gUFJ0E5+UIo2OSfE4fPI328XsbZWCWgET64/1?=
 =?us-ascii?Q?i+DheTRgsaUeiwmfDohxksVx2tUpMSxK8A7mYIVymrhNRKh4+d6rUMgpPcQ6?=
 =?us-ascii?Q?K4zny0YyPevcH0IgM2BKhnLD5PWP0IxJiCPvI95l0BtDetLaYjuG4C9vKn99?=
 =?us-ascii?Q?XMyUXGiP9fniR+TCeJf/2OtsztCihGqZFX84bHLoVeVfYJtC6EJ9q4Qd9Oxn?=
 =?us-ascii?Q?I3BCFI2mU/6HtDmmPkdFo1VxhGG+p1AJMalMFQRO2IA6BzyORflqKm1IMYzr?=
 =?us-ascii?Q?SA2Dje6KaECwvXP969UlCuwtK/q4B1OpKvnKJuofsphBqFD25Wib8yaEqdO8?=
 =?us-ascii?Q?UjSkpTi3PQYHS8CrmWXTQhCNcBw6LO2WmBmhb53uNtmdGridrG2JlPHerAIj?=
 =?us-ascii?Q?ExBI5YWcAsCnXuvXOLO1BSBPWEk3G0fNRr9bXzx0TVtWZeGSQenRcUFuI2ni?=
 =?us-ascii?Q?MZS0ZLorxRwgo/wNKOLqCiYVhH2bDY/vumOynkRG0MiT3BzHSBSayPGEMMk3?=
 =?us-ascii?Q?sJRkg5dr0EkYvPqhKcZO8WiqYibyfizeYf5MyjmB0McGDieCSB4FVLVVF7yI?=
 =?us-ascii?Q?hGNO7BIeWG1NtPFqnIKzSQt3RPRjqf7PLJVT+El49/kF+bFyhIC5S1oqRAlO?=
 =?us-ascii?Q?3f6kGQ75k/C59xduvyqTJFnqESwBx/rTAVfIWFPQIgZwa0pHcB82CVhANnUT?=
 =?us-ascii?Q?GGx4JGio/2MdM+uIFRpx0gBWjCQx8yd1gzM2U0B2qd6uS+XOE9eyAHQziQaG?=
 =?us-ascii?Q?pAgvn4xgSyoRsJuiTEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc0e57c-d7a5-440b-e355-08dc20d8578e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 14:41:13.3527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujmNvLEOXarv9Byh+LlJrijsmKJPhA9bSxYtUmagp1b2ALWcDljHScHTpm6BWwff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This Patch looks good to me.

Reviewed-By: Frank.Min <Frank.Min@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Monday, January 29, 2024 10:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update boot time errors polling sequence

Update boot time errors polling seqeunce to align with the latest firmware =
change.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++++++-  drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras.h |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 9e67355d4718..9b7a5c1c9af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4122,6 +4122,18 @@ static int amdgpu_ras_wait_for_boot_complete(struct =
amdgpu_device *adev,
        u32 reg_data;
        int retry_loop;

+       reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
+                  aqua_vanjaram_encode_ext_smn_addressing(instance);
+
+       for (retry_loop =3D 0; retry_loop < AMDGPU_RAS_BOOT_STATUS_POLLING_=
LIMIT; retry_loop++) {
+               reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
+               if ((reg_data & AMDGPU_RAS_BOOT_STATUS_MASK) =3D=3D AMDGPU_=
RAS_BOOT_STEADY_STATUS) {
+                       *boot_error =3D AMDGPU_RAS_BOOT_SUCEESS;
+                       return 0;
+               }
+               msleep(1);
+       }
+
        /* The pattern for smn addressing in other SOC could be different f=
rom
         * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
         * is changed. In such case, replace the aqua_vanjaram implementati=
on @@ -4129,7 +4141,7 @@ static int amdgpu_ras_wait_for_boot_complete(struc=
t amdgpu_device *adev,
        reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
                   aqua_vanjaram_encode_ext_smn_addressing(instance);

-       for (retry_loop =3D 0; retry_loop < 1000; retry_loop++) {
+       for (retry_loop =3D 0; retry_loop <
+AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
                reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
                if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
                        *boot_error =3D reg_data;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 0b6ffae1e8bb..d10e5bb0e52f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -46,6 +46,11 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)                   AMDGPU_GET_REG_FIEL=
D(x, 13, 13)
 #define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)              AMDGPU_GET_REG_FIEL=
D(x, 31, 31)

+#define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT   1000
+#define AMDGPU_RAS_BOOT_STEADY_STATUS          0xBA
+#define AMDGPU_RAS_BOOT_STATUS_MASK            0xFF
+#define AMDGPU_RAS_BOOT_SUCEESS                        0x80000000
+
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS          (0x1 << 0)
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits
--
2.17.1

