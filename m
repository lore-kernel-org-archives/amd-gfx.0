Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E3C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 06:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480DD10E46D;
	Wed, 19 Feb 2025 06:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NO2qrJDa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32ABB10E467
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iII+4nTPKNVpZmoBnm+tpFL9UaSfUyIAKeF1oKtHByTqHHEHqXOG1Kc4kbwN5PQHxzJwi5s1RANjISEr/6/RdDrzIrUU9s9FDr25++1GlSFNfwd5hLRlu8/0m4GkKbMkzUO0pT9AhQ9a9tmrQ9kjUjpcaeI/v2Modmnj1XF34Iarm71Iauq1Iv7E80l5+raD1qGmUyE5dBrC9RD52jS4huv0uFyJhtCgpV8R65jXm9GptTD0m+6Cfu22rJja/4Vg0FDTsPVjEaJHWoGHLRZo/ahqfvrFr8y5BGBnzcUw66QFkDEV7dRUwoGm4TSxSqebVJGxnJVXYl3kI9CziBEanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAiDZDwKGA0qzJyt5A+5YKzSgdjr47JNkw5xkf98VnE=;
 b=wYSsoFZw7AV+pciCSMEfOwwgnIhw/eTATNjw3ZhsytsVw+hbgqi604MHpw2qnTjIXEbgonQf/kPCry5OQYRLlOksZE6YHOa1g03tGgNtEixuKmsQ6ME5gGUp+/eeMshRzeNh4tWMpLzTf3Alx1XaGuLDon60wMP7DCcHjaaam036DWF5D7lFIzof2+3CcbB+CgejvueaaRBB0iZSOkNSe0nH8AORLLrATcfy4HfuTD20JRpbX2LyCEkQeF6zE6oGjNe+lwYnr97V6Ah+wEhgQlQArLGb/q2spXpUxmVPDGxSqf4oexpdksc9x0X6R/Pz6UK/H0sWjlYZQzPCsD9kMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAiDZDwKGA0qzJyt5A+5YKzSgdjr47JNkw5xkf98VnE=;
 b=NO2qrJDano6ItBT3rNLFgTmweAJj9Kye25VYme3+9yWqsXPoEKVn6hLacXgLwUkVARtzX9z4F/lTJp+K7GZje0NY2L3g3o3Z7WAEYMhN8y5OuzwVmpLzZrAMDXmWgw2fwJSXtf9qyK+rzRojvOiXXOiTA993Udjy7SOlJawmGfU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 06:48:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:48:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove redundant logic in GC v9.4.3
Thread-Topic: [PATCH] drm/amdgpu: Remove redundant logic in GC v9.4.3
Thread-Index: AQHbgPr56P/o9Jqa6kiDHpB61nMj37NOMlwg
Date: Wed, 19 Feb 2025 06:48:01 +0000
Message-ID: <BN9PR12MB5257B9525CD59C653DBF27A6FCC52@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250217051435.10996-1-lijo.lazar@amd.com>
In-Reply-To: <20250217051435.10996-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=df015483-45b7-40ed-8bbc-c50f363f556b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-19T06:47:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8502:EE_
x-ms-office365-filtering-correlation-id: d422798e-f10a-4aeb-c4e2-08dd50b15a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TFK6HoP8+aQ8cxtpp9i48FxhOVfNfmh6mt4/RVjuScD1H5sf/9oKLmW4R0yM?=
 =?us-ascii?Q?5f83n9hWs+whoPMnwn1HJWsdbSitVo3KVtmJqpU2rjCeeKQwLEGdPsG1GWNs?=
 =?us-ascii?Q?/p+f6ZwkBjvbh55vE8oyYU/l607o7EKReyPpf350sLbLlRegwbBzobIgfTv2?=
 =?us-ascii?Q?BDVOiJzQ/GY7dB8Agt3XYyJPYgncAC78pRAYiHho7gJ7WZ1MGgqHOAMev3qG?=
 =?us-ascii?Q?E8bGCzWANu/yq4Kd4FgLlBFQOt4gsVZo6Ru07BoZjFUpx4oPreLWAMvUPZ1c?=
 =?us-ascii?Q?GTbR59F4FCItg3KH4aPiG/hcZmP8GXHH+kUpFy+VHj6vhI7jl5EeekpDoWYY?=
 =?us-ascii?Q?WmsyLG77HDGEfKojaObZudrycQ51dOxMR3EOdhIkIKC0SIqsP4Qbgw3xAgqW?=
 =?us-ascii?Q?xuBb5sjQd3KUNxMAW+tf+M2NfzGu+ZGLWeJGzNWp/ZTayNzXLICfG4DiX/17?=
 =?us-ascii?Q?1BZy5cQKVZeMyZTcoJ31oiNy09yy72y887/RtIujOtsZ0wArAzfZ8MT+HRHw?=
 =?us-ascii?Q?dG4kMxLpX6hRob3djZXhAaL2tTLMDih92cFiAOmwBF6SxQBXCNhlwEJ0DwPT?=
 =?us-ascii?Q?JewmzwP6IifvN9Fx/wrdiFKjq5uynPVTe9wlGHP9HmeYdKg+r93qhXIhassI?=
 =?us-ascii?Q?4l5lex4eD0hexSGjKmTBRB2TBZqQY3TkgJ8Af6Zhgd4hg2tGx+X52++pXnln?=
 =?us-ascii?Q?LLD1i6HybtpbQmCbMrdzkU6G/Sc5AFAqhbTclL7qNNorHGNmb2b0FY34SXOe?=
 =?us-ascii?Q?4P2O9G5p/rF+u5L0evHN49oajTequ2L0nf3UFz16X5aqqoNV5imwv0RIeSW3?=
 =?us-ascii?Q?4ynOzMAp6uhJiFn0Cgn7dWpOLkgU9qVMbfRD+tMpqgekrpUGqp+uL6MPXkNP?=
 =?us-ascii?Q?obY3xP5fYNmNA3IgCTDtGkoJG4scEDQhQr9wZtrUZW0OOs+8NdwdU3q8sFe5?=
 =?us-ascii?Q?F4G1qzfwA2M8/CK75pZsk7FaqhinKT1vt6wcb4n0fRVzMjf0Qqz7Dty2XEuh?=
 =?us-ascii?Q?N0BQyMPogdAzP37Zq4GXcWUu9MViOJ0HAAqyIyG0vFE3JhAf/Pig4C9QOo0k?=
 =?us-ascii?Q?4irUyTMzr8FKJ9NOxtijzeGdXCJmEsYL9XesyCsrUQ1pS/cJiVB2xrhT1AsJ?=
 =?us-ascii?Q?XrVde8DVGaN+ZqcRNFe29BudAe2cu8DFSEcvaboJMWBXZ3+PC6nt9gngkpjs?=
 =?us-ascii?Q?y9qaihUSGY+Kfh20mjY0aFKk+fbXmQ5lypK2IUJN0WvZi6kBQ8plp9kvkFIW?=
 =?us-ascii?Q?V3mlV3LfqFE8IGr26itEHjY7d8dGeZgjfwmR/brUnYdgGq9fnQZgY61opDCu?=
 =?us-ascii?Q?pEtBsOVrSz2ZMBvVrnVq763Z80Xg+50526P4QRPT0uxYYgj3YBQ6mtJqqkyl?=
 =?us-ascii?Q?zw7oHv9WLkKhRZaeAc3HDMhtiS3KbOXDIY6Yr8Z91Ea7W0Lc2PT11rv0C+Zi?=
 =?us-ascii?Q?Al1PECNBL7QxwGT7uFTNRngqcUM6Zi4c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J+mYMIBmcNDr+oPEsMd0+K2djjSGvgcLn/vRjxF2sy3RSigRunoX5KdPjlt7?=
 =?us-ascii?Q?qhOooY9MfBKQ9FpNuWWiou88gdmGuoDds58SPd2cPulJ7arOcQRck9uiupKD?=
 =?us-ascii?Q?H5QhiYGPqTw/ulpN1vLyqPPQEsDLCDfnEjqEyqfTcJHExeM/Awgq/6BK43WQ?=
 =?us-ascii?Q?lmDNMi8iPqbTT2mBbT96HXIRWyo9YvdkqWKF4yIHRZTyJaqe7KGFVZGzO75T?=
 =?us-ascii?Q?mO2FxKCLA4r4w7gVSq3EeGtic+szZfVbNu3mRrTZeSABikKJ72brQ8aRCO3v?=
 =?us-ascii?Q?VAHbkom5hJLGL0AfTk0ss5SSWBg5NfP4b4MIB/GZzJxtTD9g5eknjW4YdyJL?=
 =?us-ascii?Q?1wV4YX5Mkoca20yA6ynk8I9P8w4h/xDf7EzMQc0pCOtz7qEAivmC/V5h26ZR?=
 =?us-ascii?Q?r/By1etzhzBNz5rbGQKcbSWLFsP7rr8DCcDLIBZdckky1hzgj+xRe5lFspFX?=
 =?us-ascii?Q?+tbcZoMm6n1hp3dY1A2IAfUbgcZdhX093v4s6XwnCfkEnurs0LBJ1onH1Q73?=
 =?us-ascii?Q?K8SJmx2IIhA23G9fhN6rndj4u8o9lo3Bd7jJ23JtdXGVxj0NLZJS1DEq/xKT?=
 =?us-ascii?Q?qPUIm1/Y5W0gdKIGLFa1tfePF0H7+Q6y3oTNrAuiE6jEBtOyvx0XUA/+0fRJ?=
 =?us-ascii?Q?35QY9CDXuW2rNa48OQ2K7WsTwwMyUPbpxTRMgrpyTBHJasgEQBaCNpo1fXwu?=
 =?us-ascii?Q?JTHlnEBnqxn2qJZbo1pWNgtNMB6XW7eebLrOgwZzqpr1k+paEg1nYO5Yw1jS?=
 =?us-ascii?Q?D7YZr2Yem8Ea06K3b3zEmQ9n9nLWMi/NOhR+KOHRcNgRy0E9dAGqNn67uC24?=
 =?us-ascii?Q?dbEFLphy6xFvFYq/At0+wtf51KP2UVdCLXvUY4if+SsN78CueRbeXQtFKfqS?=
 =?us-ascii?Q?1y92DQdiDwgix4UOyQoL4eapCUg4PRDWl90JA8ntvsSnazRA5Xe8PG1LHKZx?=
 =?us-ascii?Q?16QVADXxtcwr4hyx9e20Ilx4Sy96oAb6Kr90dzUMgXogW9i7FfdF5/WbWnZr?=
 =?us-ascii?Q?xPXHcEzuVFdzbd5IveP5+Pymh4wTZAyhPXYZQjR0Xod2zK0vdsmO2SlUECbV?=
 =?us-ascii?Q?A++FvikNo2OMpJUNrCQSdY9oTAm63u9X4O5+pU1O3JTapbpnrtkLY0PoIsnd?=
 =?us-ascii?Q?E0MZXw888eFmd18WGa/2okQohYAMN+WNDH5qNwTQMQiK3al0bWIeflrxdh7J?=
 =?us-ascii?Q?SlvzQmosg+lDoV9akbXQBMFxfjJxFKdLbAD2EozKrsEI3tJi677KF7lZTHj6?=
 =?us-ascii?Q?I9+R9ENyVay4K6+vyei3/ygdGYkGFkqzsX/8KAFEk0AqmfBIBmrJCfB+GOHW?=
 =?us-ascii?Q?w2EhDaPvW4pob0kT1xqwAA+AWtg9MzOW/UjBNp9kKmWlutJ6n2UtrVUDsHx2?=
 =?us-ascii?Q?wJAjNQJdoyLlGW0TmDSnVnrEi4N61IdUChKV0srpnYA7kxrCyKfWZHrPu8M8?=
 =?us-ascii?Q?M+4dYs+5UX3gm2du8tCEgm6/wISF1hu2tyWB9aeSmes+7TeAgKqYfNiXaInF?=
 =?us-ascii?Q?auUvN+BakYzxjdRK2FlzSiMy8BcfImC0T0CqUJtisC5Y/U0vFsk8n8htI6nw?=
 =?us-ascii?Q?3lkYdDLe3aLAEkeE3JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d422798e-f10a-4aeb-c4e2-08dd50b15a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 06:48:01.3532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tn7DCjYIDBw3YGlhxj/buNwLn0MsZ+YJ7SboGwWxeFsNJodBS1tVIgMMYfzA4AeNKxgpJQHPEXCBTLl+ZjUoIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, February 17, 2025 13:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant logic in GC v9.4.3

GFXOFF check is not need for GC v9.4.3. Also, save/restore list is availabl=
e by default.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index f4635fc8a7ca..f1d6f4b92e99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -563,17 +563,6 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu=
_device *adev,
        return err;
 }

-static bool gfx_v9_4_3_should_disable_gfxoff(struct pci_dev *pdev) -{
-       return true;
-}
-
-static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev) -{
-       if (gfx_v9_4_3_should_disable_gfxoff(adev->pdev))
-               adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
-}
-
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev=
,
                                          const char *chip_name)
 {
@@ -600,8 +589,6 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct =
amdgpu_device *adev,
        adev->gfx.mec2_fw_version =3D adev->gfx.mec_fw_version;
        adev->gfx.mec2_feature_version =3D adev->gfx.mec_feature_version;

-       gfx_v9_4_3_check_if_need_gfxoff(adev);
-
 out:
        if (err)
                amdgpu_ucode_release(&adev->gfx.mec_fw);
@@ -1360,10 +1347,8 @@ static void gfx_v9_4_3_xcc_init_pg(struct amdgpu_dev=
ice *adev, int xcc_id)  {
        /*
         * Rlc save restore list is workable since v2_1.
-        * And it's needed by gfxoff feature.
         */
-       if (adev->gfx.rlc.is_rlc_v2_1)
-               gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
+       gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
 }

 static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, in=
t xcc_id)
--
2.25.1

