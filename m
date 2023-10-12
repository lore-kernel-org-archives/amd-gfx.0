Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C87CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 05:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC17510E412;
	Thu, 12 Oct 2023 05:54:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BFC10E410
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 05:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui+BnlZwrc4Hz8ftcfI3Wb15ir2OSB6N6zuLFISls/n5F3yXgy9Em13cOH1Ea+WK9bEc6mHH0ylviahLVFOkm73PqGw6/gWkPnx6Su3Szxhh9bP0ua14cEWi1Zr8z5/nICvMEaV4mJGOIK0UrR2ph+7SSsA6NI0lnA+HQlrZfTOsJU+0SALDrmQ8wcKG/eidSF7KGOWfUPSDJV1GoFZaqScERQ3t80mHvacpb5wNjNbfQyNhdKPe8eUHOr/YMGaNCVOcIhYDERptfYkaGXAeF4TYuY/diklgrkQffm56slcYmt4C1OwOSPjATTdNQLgwyOUbKnxvLbAShZqjEXjCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlJRt4nX7jF9EuKezek22GjFlD/cV/h/z0W24lwhxDQ=;
 b=EZ0wl8Dhyvnv+eqX2szcWQooiHVFGyJv2BvtlmmkQkwhdABnzv1toOBuKQOOC02X08fOCojXB7mitdI4GGgu/Y0Soi7wWhb8BfgXPuq/MPnKSd9z5hYNouEv980D7AICzOApomiBKGw/ZgMjnFuNLM33JzDyM3rogQzJZdaGC4Kqxy6wy9as9WXU1EJId7yBZthz8TxRVP2M81DmsWnp7R/zSDNFb/oD2vrMegCk3Pzr44BlwU+kgX5OIrvMuenfuCazwZQH/xbuuzrkt9fvQhvVeMg0yp8bdtNEbN1BRZuq+w6MfMCqdhYvlvMYDQnQUXf+xTviV34INDOUoXLnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlJRt4nX7jF9EuKezek22GjFlD/cV/h/z0W24lwhxDQ=;
 b=zR99/DTvReTEpCqYGmKtBQQekhuXNXy6q/czaLFM67ZaCQlJ3aETzWOao5RQuxmp7yZ6e0D1eS8+IVwYHelteuCETD+g7Q/tTRP0oU+eep5NDk2dNhQvCESc0g4D0qfjyXkTQk3yz4lWSmVi9bV/VWPJ7GwVUfqxMkxPuVm5xZI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 05:54:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 05:54:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Thread-Topic: [PATCH v2 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Thread-Index: AQHZ/MjC4RkjpxeE00qcx6voOzoCE7BFp2oA
Date: Thu, 12 Oct 2023 05:54:20 +0000
Message-ID: <BN9PR12MB5257E0B927CB5217920428D2FCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231012045755.111418-1-lijo.lazar@amd.com>
 <20231012045755.111418-3-lijo.lazar@amd.com>
In-Reply-To: <20231012045755.111418-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8afccfe8-a500-4bc4-a2cd-f5f160e43055;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T05:53:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6126:EE_
x-ms-office365-filtering-correlation-id: 5ef49ed4-116b-4013-0b71-08dbcae7adb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJ9EJ6pYPfwNL4dwpau1lEMZKVY4w0e8gv0k9XJGHPLxOeau5RcR3pRey9VXxXYVUA9gnL1upgIlNL3YQRD1+aHAJXgvPn6kVHA5JZeK5GvjDiYlvrAtbjyFHBJ/BiJkRefQbIq3RJEzQ0Np9bj5uqY67bisl7xswYiQ5SudQr6ORVtw+u+7PjdNzbeO1Gy63/3eOheWWVMUzs8eC0AtP3G9kOSeT3vSTJFlAmkETZ8vegjHEZ4+q5CHkwMUdmXxj/4CNFYlar2ru1hirG9Ww7o/GvtP1t2uZsqPViXJVwmbCFivKmSGd+g3cyOBjPZHHX6SerIDLKaHUhMMgP0g5te7KlDIq6MULLgZfhZRPwp5lwaTsX52OHvjy4+vADjrQENOLD7WqtkLJhZLSkLa8fQUX1ZOmFR4pRmlsGSvj+VgthKKZF7l5iTePycHVk+tgyFR2z2IMGqNdmvfm9Q2HCDSr3oRLHW2qYpFYPjS7WoRcm/HNy80m62twKeCucVy45VBwcW/dbT5KJYnjg4eW//lT7hFTtjfnSy337xECDKtV/F6WePsFvzeCEbF39uAur3+0ywe0+nPcpvsawcMqyA2o8ngxYHoKQgvRePy5vPmQHt8pv7aJJNPgx84VRm6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(33656002)(86362001)(9686003)(53546011)(7696005)(6506007)(71200400001)(76116006)(66946007)(64756008)(66556008)(66476007)(316002)(66446008)(83380400001)(110136005)(41300700001)(5660300002)(52536014)(478600001)(4326008)(8676002)(2906002)(8936002)(26005)(122000001)(55016003)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ZsVjK0lBU9ClNssv4GJyqn2vDZ8cHp2mhOC5Cg/4GH5E5n4b50qJOAuRUDQ?=
 =?us-ascii?Q?VXlc/hv2ljYkL2GMnZCdrMWUYogGvW3cikK335wKZC/HG7/IJSeSGcyJioZN?=
 =?us-ascii?Q?88xxH9CsBJxtyTjQg1eOsBO7ks1fRhCy9FSQaDH4SiuiPWCvxaHTL8djnwf5?=
 =?us-ascii?Q?y4YbsgjJiHj0l+k2Ufo6YzFz3IVlukS6XMKXEqr7qqC0CN8EZuy98s10RSxc?=
 =?us-ascii?Q?ONwv3STxi9jyZsAkIsM6ex2P91FG2gw0GSZInPqZRe5vJEwqkS7J44C1+ebO?=
 =?us-ascii?Q?gqwNqpN0Yu9NPdnrfcwQsE8qI2X9AFYn/7lnst8Z/+JyaqMwx1VuSxezZ1hs?=
 =?us-ascii?Q?aqXC3iid0ybFwLY8KnfP1oxrpx7iT3zVoallxqE1xx/PXJBU/80XhSqPZsWp?=
 =?us-ascii?Q?3Q4Vp3oZqjHA7DTgNkaQ7in8D2QAG9/xB94oAnW1IjokDldWy3JrCdaA7+Lk?=
 =?us-ascii?Q?Rq3w8aHzBsRiU5+LwgHfVzubCQDCyHOENk8l1vck4OY0Zd6CeOKqvjImW7CJ?=
 =?us-ascii?Q?NhddHJuDkRmlIqGTsCblR98NfXlyn1hDJZJoHBwK5fsI9Sjs7K7yRflb2jzl?=
 =?us-ascii?Q?Yh9A1WWQi3iIWoLAZOvmItyZTB6POaHmIh4oFQNOUhHxJwLAKvUk3wcWDYxK?=
 =?us-ascii?Q?cMMCLawSzJSW6eoHvVVEIFvhboGbBq2HuJgUU7BVrmDQdTcI5pbiT5P4fX4b?=
 =?us-ascii?Q?v49rw+CM3VAXDVE0c6bp0NooIQjybSyinX4EmQO1u2etSYVUM1pcGPfKLPmt?=
 =?us-ascii?Q?xSW9S2lZC8REEhfcsxeuyH0cHurH2OBE1UGrA4EEHRVVG8bJgB2Umrs4rZ85?=
 =?us-ascii?Q?xTCccwwPSqlm0fsT9BdZM8clhmeVHL3kVDkp3iLGsJ5NRcRCoRtjXRSJCy9W?=
 =?us-ascii?Q?bWdwHkoz5tWhLtPdK4MYPdSeSLkxTlltUrmIKxXicNrPl+oe9+U2eOwCZ298?=
 =?us-ascii?Q?q0Hd7gvnmaK8Ni1Va4jKK52IaWx2HjszV5pRMEhp/jfAauovn8LMm4FXKv1z?=
 =?us-ascii?Q?EYsmrczRm2ppwk7Ly3PaR/Oph1QlDrptemXWpD+mCceOwe89BrwJ+nGObi3q?=
 =?us-ascii?Q?AXBsLBdM1chqlJ0lJqevmUbC+a75x/pJkx5lcVZ8GkpQqYsor8d8qmIHAIzB?=
 =?us-ascii?Q?9RzADbdeI4ETCsljF8JJsoNvz26aLwTeuUXUqVFr9cQdFyOVyK/9ORVd8wUZ?=
 =?us-ascii?Q?Z5/VcvvLDeIA4AoIhJrNloRyP5rT1uA99aQXzKIDCaH6ccOzpbLqqh9vTgPK?=
 =?us-ascii?Q?3T87C0T4EFWyPNYrmYi43ctkLEDBMvdztPFCp6gx2MNjh0Ia05qAUB6caEiw?=
 =?us-ascii?Q?6eHWPhbco4gOoKM8nbqV905/2048cy3+f3k1cRrKP2oMAtuwFRcxAOQ4BvM8?=
 =?us-ascii?Q?5OZabfz0+zGcKW5Ly4MtImowbtis4Hf3UzEGlPUaJW/PF1F2PtVi1ox6W7Cu?=
 =?us-ascii?Q?kmWZc+WlWafvfleahPlrSI+jExLLVAEJn8nBiSolyYw8PO3uWFIEaVfnsTYj?=
 =?us-ascii?Q?oxWRMQ/pc5dWqxw58/kKkHsfTzYBNQQI2P177Frrv33mdZePjPL7cN4sxmsL?=
 =?us-ascii?Q?DRQmv5Dm+6K/p2mK7Wt+fIdPBJLHU5o/+yvcppR/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef49ed4-116b-4013-0b71-08dbcae7adb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 05:54:20.2879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cM/fOl1gftHO2IziTTbJdfFg+4f1ozZ05MOhgeGbv51gShkn+g2LpieY2nH1ZN6hTUachBFNbk+kxtA73CzRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, October 12, 2023 12:58
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6

Add P2S table load support on SMU v13.0.6 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Fixed MP0 IP version check (Hawking)

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  7 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c41bd07f3f98..7158d478eeea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2516,6 +2516,13 @@ static int psp_load_p2s_table(struct psp_context *ps=
p)
        if (adev->in_runpm && (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO))
                return 0;

+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
)) {
+               uint32_t supp_vers =3D adev->flags & AMD_IS_APU ? 0x0036013=
D :
+                                                               0x0036003C;
+               if (psp->sos.fw_version < supp_vers)
+                       return 0;
+       }
+
        if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
                return 0;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..d29740bcdc8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -65,6 +65,8 @@
 #undef pr_info
 #undef pr_debug

+MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_=
i2c))

 #define SMU_13_0_6_FEA_MAP(smu_feature, smu_13_0_6_feature)               =
     \
@@ -123,6 +125,9 @@ struct mca_ras_info {
                             enum amdgpu_mca_error_type type, int idx, uint=
32_t *count);  };

+#define P2S_TABLE_ID_A 0x50325341
+#define P2S_TABLE_ID_X 0x50325358
+
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_M=
AX_COUNT] =3D {
        MSG_MAP(TestMessage,                         PPSMC_MSG_TestMessage,=
                     0),
        MSG_MAP(GetSmuVersion,                       PPSMC_MSG_GetSmuVersio=
n,                   1),
@@ -256,6 +261,70 @@ struct smu_v13_0_6_dpm_map {
        uint32_t *freq_table;
 };

+static int smu_v13_0_6_init_microcode(struct smu_context *smu) {
+       const struct smc_firmware_header_v2_1 *v2_1;
+       const struct common_firmware_header *hdr;
+       struct amdgpu_firmware_info *ucode =3D NULL;
+       struct smc_soft_pptable_entry *entries;
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t p2s_table_id =3D P2S_TABLE_ID_A;
+       int ret =3D 0, i, p2stable_count;
+       char ucode_prefix[30];
+       char fw_name[30];
+
+       /* No need to load P2S tables in IOV mode */
+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
+       if (!(adev->flags & AMD_IS_APU))
+               p2s_table_id =3D P2S_TABLE_ID_X;
+
+       amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
+                                      sizeof(ucode_prefix));
+
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+
+       ret =3D amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+       if (ret)
+               goto out;
+
+       hdr =3D (const struct common_firmware_header *)adev->pm.fw->data;
+       amdgpu_ucode_print_smc_hdr(hdr);
+
+       /* SMU v13.0.6 binary file doesn't carry pptables, instead the entr=
ies
+        * are used to carry p2s tables.
+        */
+       v2_1 =3D (const struct smc_firmware_header_v2_1 *)adev->pm.fw->data=
;
+       entries =3D (struct smc_soft_pptable_entry
+                          *)((uint8_t *)v2_1 +
+                             le32_to_cpu(v2_1->pptable_entry_offset));
+       p2stable_count =3D le32_to_cpu(v2_1->pptable_count);
+       for (i =3D 0; i < p2stable_count; i++) {
+               if (le32_to_cpu(entries[i].id) =3D=3D p2s_table_id) {
+                       smu->pptable_firmware.data =3D
+                               ((uint8_t *)v2_1 +
+                                le32_to_cpu(entries[i].ppt_offset_bytes));
+                       smu->pptable_firmware.size =3D
+                               le32_to_cpu(entries[i].ppt_size_bytes);
+                       break;
+               }
+       }
+
+       if (smu->pptable_firmware.data && smu->pptable_firmware.size) {
+               ucode =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
+               ucode->ucode_id =3D AMDGPU_UCODE_ID_P2S_TABLE;
+               ucode->fw =3D &smu->pptable_firmware;
+               adev->firmware.fw_size +=3D ALIGN(ucode->fw->size, PAGE_SIZ=
E);
+       }
+
+       return 0;
+out:
+       amdgpu_ucode_release(&adev->pm.fw);
+
+       return ret;
+}
+
 static int smu_v13_0_6_tables_init(struct smu_context *smu)  {
        struct smu_table_context *smu_table =3D &smu->smu_table; @@ -2787,6=
 +2856,8 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        .get_power_limit =3D smu_v13_0_6_get_power_limit,
        .is_dpm_running =3D smu_v13_0_6_is_dpm_running,
        .get_unique_id =3D smu_v13_0_6_get_unique_id,
+       .init_microcode =3D smu_v13_0_6_init_microcode,
+       .fini_microcode =3D smu_v13_0_fini_microcode,
        .init_smc_tables =3D smu_v13_0_6_init_smc_tables,
        .fini_smc_tables =3D smu_v13_0_fini_smc_tables,
        .init_power =3D smu_v13_0_init_power,
--
2.25.1

