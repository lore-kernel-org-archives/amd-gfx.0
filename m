Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E9CC77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 10:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FC210E681;
	Fri, 12 May 2023 10:57:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41E010E67E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 10:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiuGVGetuqOwG6NR75gzxO0ShLCBt2Vplt0khO5iOSbS/MMuTDtZpY0Y2AkpN/QL8bTmvtSdn2DKcnriityBmBUnWkjjWsk0XHqTgsXgx7aFNKG7Dkw9L9hXPegGQ7Kh2FDwU/2iwkZmWjnyoa1p/KJ+e30KloZNvy/ChU8mQUibKbEANQEoi1LeGR4hdqC17TnZwwm2IYJAqUQFZ7D0P0CSzsyeoWO2us51jF+wWd7zGuMnNASeV5nV3+jF1WL2MTcvNvS6yJAKvZkl380hSB6CaF+KOVDqzEkQQYzviz0QDZeod522nO6RLYg67Mi0ZYmJMtUaKxOzk81qvDEhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZEdqZ+Op7VcwhAYyE54BmZwyAs6DAzLJgAAzMSU7Sg=;
 b=AKSIefwWjW5fvseRDmqZdM3Ira6WWnINYBWhgOYPQo57g2M2L0lvpypFlB1Kf6XFfIOInYJgLIT21aLTart2kbj+T+NB3146WnzMgKJIoI0AJ2CI3OTKD8cjMd43VdJErYVkmHIE39isYmDy/mZXJrD6XaRN2VhvosiJEWJbiF20LHit6mt94JECX1Gv2y+oywrRA6fGIMOqHvtI2drGUuPUpT7twBpg6Hf189XaIPWHMLsP+ShmosMwIoPiLvaZY3tccN+6X+bMdK0yQzRXsigQt1OXcPYslF3zbFgaL++GzTUK/ht2529L8dxZBtbeOrYLgsC/SxTtCN1/e768SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZEdqZ+Op7VcwhAYyE54BmZwyAs6DAzLJgAAzMSU7Sg=;
 b=D48uDW6XH39nznmXd0pUlPeQF+cYMDCclYjiOuCzzrE/8Xjg0+TjMir7kLumwbbO/1wz03yi+c41I5t30uId69E29WDiuh5p6py07yMmEsflD8B8NUSsRhIEf34LECvlrfzsXpKKXZu7ZbB2hqAvfPgmuKznbAKjUxegPFBgcmg=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 10:57:40 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::fb6c:ec84:7b2b:a4e4]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::fb6c:ec84:7b2b:a4e4%7]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 10:57:40 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
Thread-Topic: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
Thread-Index: AQHZgkiB4Dy7R6EosEOACumUo6qPZK9We71A
Date: Fri, 12 May 2023 10:57:39 +0000
Message-ID: <DM4PR12MB5072B465CE868231EBB19BD6E1759@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230509073229.957867-1-YuanShang.Mao@amd.com>
In-Reply-To: <20230509073229.957867-1-YuanShang.Mao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e1930db6-f903-44e0-b0bc-5389c0c4081f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-12T10:54:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|IA1PR12MB7614:EE_
x-ms-office365-filtering-correlation-id: 646147ab-e36d-48f5-33e5-08db52d7b43f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5BDUcjUrdoK3B0MMCV0iI1wWIvMuz9GQ35cXgCv1MI95DpzTKPshKtVabgxXuXduBuhKlhM3phBDVAqufF/OuZVo5oHZ/lMuU0OJGaLfgpykuvK7sC9O8LRpRX27tugTSbi9yI8qHAZituHq5FbdB2Db3y5K3K4TgxnXkbYOFSonG288DBLB2ilFNBiXZ9v4ofJge6x0EbddyP8I1RrCxF0qASqWUDS3c28YMYfRWC+qeTxYV797dW8TQVLXHW4NYAuL0FO31zP12dPoxGEyDvZYx0WhdBQPm5b3TlmbYXEbU0im2HQiqf7HudtQOqkyR2S0+XQx7BBMsFocPh9Jp6NVHsEpUnLzmQem3iLx7x43tlr3IoGgSaeNagUXEdNrHE1BDWaYLVvtw/ftyBne8n6f95C9apv4nl0TpEtiH5oQFwV6DlZxQET5hq/0j7NvH0q+wGa1IsoAOf6+Jdx4jcWPDXxLoOTVMp+nb7rfN5V8WzkyjW3u9nQWXvTyXpkhSJ5tfy3507Ea4tXLYJ25bofL7w2lKTjZcELeHllK0FSgFrYgTKZpam5z3xsqhtUWAOiVfoNPjBnayvT1yXRcOFtDESirriCAaQtRe3PbZDkpxw5Qpr3D0t2XpIKeKxR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(110136005)(478600001)(2906002)(66946007)(66476007)(66446008)(64756008)(76116006)(66556008)(186003)(316002)(71200400001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(6506007)(26005)(9686003)(53546011)(83380400001)(7696005)(55016003)(122000001)(38100700002)(38070700005)(52536014)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YtyJCGsspaKGkj12eIrtdxeccoGnUkycROvKm4Lyb2q8V/jOyiRteAxD+hvP?=
 =?us-ascii?Q?XWLPBCCqNVzONSe55O7HKKLr52Jql+15gWT5hue5SK/Mu6qJCGXhRSlD5O6G?=
 =?us-ascii?Q?YvhSR9lrt3s5ys+jUIYvA4YmM7TaKkM+IBd0OLwmktuJf3EVm2K4CFyZSLvl?=
 =?us-ascii?Q?fOKbrtJxxHpSdw87ksUQ+vaVgOPPhvKUY4pEK/XB+XcUpVKE4uIL/HGioi0O?=
 =?us-ascii?Q?lWmyHiD9Jj5OhVykZxPymM3tgQ+Mc03DSyO1QQqCSVTRIXmsleUX9y3BDCHB?=
 =?us-ascii?Q?x+bVcVZ+CuFnFd21DOy4+8YM67gIKGEG6s0eH4fd/cNycUo8Bghe40PFqcKa?=
 =?us-ascii?Q?BoT30UyZdEw49/3y/YF6VtZx/IP1qX6chFeiI6Al0dywNb72tc67pKs9RHJJ?=
 =?us-ascii?Q?SeyF+tiQezA4/a5N/4PpIJl5cNucN7LemOGOrxlX04qQckffgcjQT2B66pyu?=
 =?us-ascii?Q?NutfoJ8EPokizLqJuB9GLzhNCMlRrGsKO5/BxTFexTJaOGbI+/FzDRNo9Mqs?=
 =?us-ascii?Q?KMNlDtDwCnXbNtE8H1qLL7n40/w4nujEIQA+A2o5R72oIKME0Cmt1RO+jkfS?=
 =?us-ascii?Q?XXcNNzZhkwWCWJM5aYRlrChvXkNq38yzrO+rWDIx0VS6NwvFZ6K62d30Hdu3?=
 =?us-ascii?Q?JeVFMdUevvNe50R0rCg3kONN4phKomWuxCkEn71J304qdOj/Beqk7ktp1Ks2?=
 =?us-ascii?Q?g5wx6NFICaS+p9kT8pbAyl5V02FvCrEiEq3P9ym+E1ckFAQ/qYAD6vQcT/gn?=
 =?us-ascii?Q?dOp8eKObQIKQ9oeou519vzC9Ax+F4bOy/uVYy52YGyq3idK3gN7XC2c7yz6J?=
 =?us-ascii?Q?/wq0MpS4wJ2lCvoEjyDRwPIZIsZfNpN21TU3NN7lrNo9XX6ahmNTSLd4AT7r?=
 =?us-ascii?Q?KUUdes4LMoprqovzss9S+9ijhsSrkkaQKtmeqbAFCnhtZuO6HKxxMgHaGE1n?=
 =?us-ascii?Q?UXfT2HuvNujS2vYn75e5nUtmf4IVmbrHr1/lW8mZfn1llyl8Iqx8zznqIExN?=
 =?us-ascii?Q?mqL9FHqBwajadTMjNt/zyWuzApXh9iEtYoWAkL1N6Kvy9aDyRJcAY4udWYTX?=
 =?us-ascii?Q?/Hh8B3CXCMOsWGqJ3Y2Qtu4t8+oWFBaxLKyQCUuwHqStQISQ3Fb6EwaYxc1w?=
 =?us-ascii?Q?JcUNhNNjkwoJJG8vjB1BT8nVb7E29uVD2ncplaJTmJLdRVAZT/ycg4ddPmWB?=
 =?us-ascii?Q?gJ/Uzbab9xoXZWXa9utyF2+lGWWMcqvTfs8m4wLUq11kXqosjjs35RCLfrzJ?=
 =?us-ascii?Q?8tCodfEsU3BwztjooYxLZDSjMqZ5ZhUZa9Vef4R/c7YfekFgPsB06dredWff?=
 =?us-ascii?Q?Kue7dK5M/DvceE7mVNX0mnWa41BTgW8EXUCbbn0N97wzMaAcu3l88b16Oqf8?=
 =?us-ascii?Q?evTVnZgIOC0l2EIhHknVIFfV1CcqXHxXHNmLhZjHnV8LfxGmrL5a5TuzFqPi?=
 =?us-ascii?Q?0A4xoJ3xoMaYEM9B0TyDhI+aHtb+SJEiHxNU8AfTMjphI2F+/wshVHBflj50?=
 =?us-ascii?Q?Jj+h3xSWh34zm7V66Dv7k3tRoZ/kohGBFee6UkakuYqIkl3ensgQUkAhaRV/?=
 =?us-ascii?Q?An/1+STnwNP4ACU0t18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646147ab-e36d-48f5-33e5-08db52d7b43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 10:57:39.8232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+RJYwNy7GueTPdA7DaecSnpuvADDIZiAsnMbjfsbsWkmVLX0jzMfc/SCJivTuxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
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
Cc: "Yin, ZhenGuo \(Chris\)" <ZhenGuo.Yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-By: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Tuesday, May 9, 2023 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; Chen, Horace <Horace.Chen@a=
md.com>; YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf

The IMU firmware is loaded on the host side, not the guest.
Remove IMU in vf2pf ucode id enum.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 1311e42ab8e9..0af871735a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -557,7 +557,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struc=
t amdgpu_device *adev)
        POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->=
gfx.rlc_srls_fw_version);
        POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->=
gfx.mec_fw_version);
        POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->=
gfx.mec2_fw_version);
-       POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->=
gfx.imu_fw_version);
        POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->=
psp.sos.fw_version);
        POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
                            adev->psp.asd_context.bin_desc.fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..104a5ad8397d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,7 +70,6 @@ enum amd_sriov_ucode_engine_id {
        AMD_SRIOV_UCODE_ID_RLC_SRLS,
        AMD_SRIOV_UCODE_ID_MEC,
        AMD_SRIOV_UCODE_ID_MEC2,
-       AMD_SRIOV_UCODE_ID_IMU,
        AMD_SRIOV_UCODE_ID_SOS,
        AMD_SRIOV_UCODE_ID_ASD,
        AMD_SRIOV_UCODE_ID_TA_RAS,
--
2.25.1

