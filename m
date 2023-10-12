Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA34CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 02:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCC310E3C5;
	Thu, 12 Oct 2023 02:14:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CC810E3C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 02:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENp8cddWJR2/S8njGPDnmaWBFuGy0YftAdJkJnrJH5LRkjEG75p4DuX7eOpXYT1VhKgM7T4/uRRACJG6U0CsLlE88U3dDm55FKR14EVXUZ1yQQxSAYd7VSpvE6ibcn7fSVzhLEiem65jpaokCeY/2KTZhocg1U/nQRH+S1SpP8YuggHR7ZNGXSXerdDGUh7+uOVHhyeDnEOdWclme6jlZUHS54jqmIVmAtw8yks9gfEm3o44cz77zRIJ1N7RMjtkPcN3i4wKFiSw0khR1sjQ9lSPL36q2lOIAQYw244V9A+4bWDbiKWpWQxYBoAn/7IRiGh9HGsG83bGjBc7Q005sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15Ah0TLVxG4jj9TV4J36Blrgy/9x//wzi1FaHUdlyp4=;
 b=jgrEjmK5qp4CySN2vTR5ewjDR32fEaxnYm1xyj4OGiVkwPk6fy8IOuBSI6eZRR0Q8j1TWrwu7KYUH8XYiUkHYrMHbFp8eWaa4Q06CAhsqXrv2FTH9eTTGOS/32e35vcBFQvybZuZz13MX7EQcs8Y68EsdfMj0jShoK/bXpyXREN88pjAZNaxgARNRNRD5LEN5M6+FKxvg/opsGH4AuZhPxP/rAcZ+pobEkmj5RdWPMjIRa3R+96DB9ql9TZ/M/4aSJ4AErmB/LY4e/ZjGVdny0OhMQv/E4YLipve7ZZIjauHAfnT0sl0cRSQjhc1wcGtDupXe+kDbc3d07Ch2de83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15Ah0TLVxG4jj9TV4J36Blrgy/9x//wzi1FaHUdlyp4=;
 b=Hl9i7qgc4etDs1OLuUPWYAwV3yFe4oAFeK8TonZG/PSNLgJ1rSTQvspykt1P7mnTm9d2EEozfsrAq/TErt8AwMUQvg2VI3DZdzCiBxQERckfMGZO7X44HEEsFCkLqo2JKOOlcQ6ubGe7fu495WTd1jUJcguM1BLvV9WCIeI4/3E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 02:14:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 02:14:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Thread-Topic: [PATCH 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Thread-Index: AQHZ/Fhn/hZ6Vfmg9UyVWkcViK6psrBFappg
Date: Thu, 12 Oct 2023 02:13:43 +0000
Message-ID: <BN9PR12MB52578048DEC95E1862BC310BFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231011153227.97424-1-lijo.lazar@amd.com>
 <20231011153227.97424-3-lijo.lazar@amd.com>
In-Reply-To: <20231011153227.97424-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7696806-d1a5-4efd-95d3-0b5dddd09794;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T02:13:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB9041:EE_
x-ms-office365-filtering-correlation-id: 61c769b7-a405-49e9-3c67-08dbcac8dc30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYKdGJf16seYYpyyI4bhaq3qz5zmGelvGOMXy/75xQa9Y+SHIj82Uh2JhlqaOz9O+LUJbeb148PPQGZ5931yS+FNC/GoXSeWxNFnZzJBX2BI3XjewE8XmdL8lNk4j28MUIEDu/3es7Cbpr7nYmRcAN2ZGgLuYEgyfPOBPkMXu1y2bETnvuwWVcXf8LKrDtIrq+YevJCD9sfahRQuXp6XLbkRJbVrsXbYnt07taVZpb06P6zP+lh3sQxpE7su06sXgW7J//9tILx6dC1YrmTPD/PxvpU6ud8j3IfbKkDbLf3TiVCbFeuvxTBz4ZJntv+aARbuIcXvFN8IKHIeucyFpTs+sKY9n0LSuSGgr4jeslMccDdaHLvgRK6r3Vd+uCJGtWdv+xHS0HAMYWbvbEymVPdglOuoL5aa8qvVmYfBC6t5OlyaOYP+AkxRV/Ig6BUjcMzKLH3fydUn925ixA0cFfXrNzFXa+6Ej1cnkzAMIi0woBk/SPK96I+DYrvNBEGpRJ/rXZqkmVvclJTYp9jKAHK4xT/VNE2E1M5a2rMuGHSAzJl2yzlhBjpnT7qT1I9c3dEEgHJCZO04ict2j9G1fINRllT1vDxuOtds3FUU2fCdbsVP6H/MF1/LaflmItxH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(55016003)(38070700005)(86362001)(38100700002)(66946007)(66446008)(110136005)(7696005)(64756008)(76116006)(6506007)(9686003)(66476007)(316002)(53546011)(66556008)(33656002)(26005)(478600001)(71200400001)(122000001)(6666004)(52536014)(5660300002)(41300700001)(83380400001)(4326008)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ibAP2wy7p2jmNdJCRLVWHw7K5m85K++lMsHz6RrXX9rhRJnVR5Avc2ISV3n?=
 =?us-ascii?Q?Rq6wuIvkyzB2RCSD7e1lOSq2jEkAE3py9pk+NgGi5HrQwU1ioVoq6JQWTRYU?=
 =?us-ascii?Q?niEO3gtcyWS8FOehoA33HGp8tiqbuXDfKau/WZJtq5IbbKp1B7xGgUVS7GdD?=
 =?us-ascii?Q?Qoh0O0HevpIr/v86EuWkdAD39Ks4KyuNjuv3lGR2kihF1MEp/j4dUpRjmjpu?=
 =?us-ascii?Q?m5cTLIK2XDUmqZ4iDEG0Yy+WOhyjty9htvjF/UOP862zDVipz+dPa2Yxw9w9?=
 =?us-ascii?Q?9cRagr71kYkIjN10Ob1H7AjiLDspcl1SFNjRIl0MEdKM91SupfOYzMVwt6oL?=
 =?us-ascii?Q?nM3trCRrDvYVAU1KcrbeefHcvFfTa/s1Hs7pKzCBvDaxaL/0UYUKCl7CY6Ls?=
 =?us-ascii?Q?njCAm3Pcmy0vf95iPCM5Rvk4KxBFdHuTwBuvdL2eLnl2S1Los6Q/qyIR4wBF?=
 =?us-ascii?Q?hYdUFdkZCyObZVgZwFuxaelm37CdMU0V+k+dBDQpMAOQ93mB28LM0hRref4X?=
 =?us-ascii?Q?C1T+1FDTP5bQzxI5rTxo0tQOkFCXQQ91ZhhZNRUWTPjVvG9MwJRpX3OAX5G6?=
 =?us-ascii?Q?7yh4j26c3Cdpp68c0owV/zLdDRxxMtvUyDjrmLTtpPQUaXEOe6vsgrq2dxaE?=
 =?us-ascii?Q?O9PzFra2N93Oey0q6W5Xt0FpGbxVPK5q2qr/f1MPcJvJ5C1KsnvpnIO5DV4J?=
 =?us-ascii?Q?8MRkNbYw2YUJOMbW+1hlpe/eVsCDM1oOzzR0D/kBBHOqbB3AKRLPfCTg0FZN?=
 =?us-ascii?Q?SMILV40A30K7TopF0aDjxGfwAhM82gic/iEcyexOuSTUv+/WrL0GKnuHxNnS?=
 =?us-ascii?Q?hNkV/CFO24fYKvmiO4hmoMPChif8vZSJXdvw7UTsKNhVB8rZGFPhK+++5SXj?=
 =?us-ascii?Q?ZSrko7CvLwWTXFA7X8IpG+7ZIzJXBjTWVQBznOwY/gWHG9wMl5B9IwY6XKn4?=
 =?us-ascii?Q?CE0kbuw+v9/v9r59pFPANMqxGheIW3r1FIHZN7LwzTcfu7q+Ebx/8e4d4DwY?=
 =?us-ascii?Q?9KWJS9Jb7O8fNzKPhoL9GWdL83PG6u82gH5GB7uswya3tS1W7RH6eexNeYru?=
 =?us-ascii?Q?uJ9VSHv9Xm9izw93XY6v0Uhaz+i152iPJFFHoYi++fi5kpiItGGB5Pi8GFUA?=
 =?us-ascii?Q?uhm3NInOxmEoJjs28phM98s1NbbH13nA/PWBQLFqgtQ0sNqIKyPkCXnNDe5s?=
 =?us-ascii?Q?peM2mMkMrDzHs9Ayp1SKw/ijVFBXn7x6GG+GYOJ7xI5WVXWOv7mMBiU3Agxr?=
 =?us-ascii?Q?TU6jDw70dLWEyhUA8A7UAOxMtDVtA878W5hPXDGlkOITRcJurKK220/RT0il?=
 =?us-ascii?Q?sBajikJs8HXxGF2WWeSi6tzARwa3/jFhz+PTrCVVSb4cX9BFdfzH1RNAxC/G?=
 =?us-ascii?Q?wZQ4J5GCAXfHz18wACvowS0ef8B0ogRuoDgtMFifHr6rmY1HpusHFRaxYVEv?=
 =?us-ascii?Q?FVqLn98LauwyaMOXrSXOfiA4h+TE5ga4Hzu5bp922U9UQYAy8M7WILT3NpAR?=
 =?us-ascii?Q?l8FsljhlTyY+xgZsKjSy7Y0Afto3u01cHON7DFso4t1BG9ybayAmp3ytn+uq?=
 =?us-ascii?Q?xSgVOBwtILKJKY00JEA2ThYm32HrTJ5qYMn4fDwI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c769b7-a405-49e9-3c67-08dbcac8dc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:13:43.9221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVmVBBa42i8Z1Y6Goim0FVyBiboYbZLdZaqaZnMOamk6WkCuQ8zo57pRr401tWanN8EvOe8WI0FXTSzGwlLg3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0, 6=
)) {

Typo? 11, 0, 6 -> 13, 0, 6

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 11, 2023 23:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6

Add P2S table load support on SMU v13.0.6 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  7 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c41bd07f3f98..49e914ee6efe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2516,6 +2516,13 @@ static int psp_load_p2s_table(struct psp_context *ps=
p)
        if (adev->in_runpm && (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO))
                return 0;

+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0, 6=
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
index 8220bdcbd927..a295403e2a09 100644
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
+       const struct smc_firmware_header_v1_0 *hdr;
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
+       hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
+       amdgpu_ucode_print_smc_hdr(&hdr->header);
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

