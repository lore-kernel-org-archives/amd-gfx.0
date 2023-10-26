Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAD6C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 05:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0152D10E75B;
	Thu, 26 Oct 2023 05:31:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E93910E75B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 05:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXijq6b4EnTWUN1MNaYMzHzFNl7kOUQwYkx5lhTghf/qwQtOcvjreJzIKYwRpf92Fc3BtALOAeMPok15C9D022giuTdyxX5EFDLbSUXfCy6rNW5k2Lj3xN9/CE5WusX8T4WuAuYZ5zZcPpsdfIjt8H7h0tKHW9hTP306exowqmcuiMMI36wGPvntROHHlJWS+EnAsWB9Zaev+31VFXET6QGA1qj9FEtSxjGYGNRcBIQG3oGTj0EIfuusEIFIpciqX4izmksqi7aM+HUZVWPyJLzcpsWAl0P6aBQfdyCwfZbbVnCq56SIjuF7GAtWTpHpzH/9aFpkNRtMijyay5ORqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCUjp3H0Utff0vcYFsT36n07crUvdkMTUkDo6CWWamQ=;
 b=WCCQelNVgrRC9sJD7GCGwnWJoDSh3aY0Dvs/O1+4cgIJPRFWi0ZAQNlYpU/bVihEO3ZPBy9/81H/EyCc65vnYgFrNQyM71zgEKdTD63t4Oh5ov5YRENNmW+YqKiC34UV5aKf6Nkp/67AAkjsORuA4NNOZzKl4h39p3tKcPcsOz2qHtcJqnqwvwqYSWEY80Lsuj5+UMV/VPxinPAnaU6aoyw0cwdjon5s2FmkbW4Ec/+kMQpW+GweT0MLQexRFsqtSEM2ckT+GO5/gwoAaqk9mJWvBRSCFXNyqRAAW3sqLksgf+X2LcCJYPfYLbQ8UaFY+xCTrMO7JlYqVvCICd/OVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCUjp3H0Utff0vcYFsT36n07crUvdkMTUkDo6CWWamQ=;
 b=Zd0DfowZ2GcL4yItyFsreHlSUbEY3WyaazTje94WprczggjbtQpjw9vWel8BReAEzXun4HM2xcCixfnO+R0QiKI0w8m21kf5RsvfEsZG8xPaw+9WeQJtpMtBlDOgQCKZ0sjAIs05WkTfl2FwcLPlLGStPyxxlMvle+BHXD/p/bg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 05:31:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 05:31:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Retrieve CE count from ce_count_lo_chip in
 EccInfo table
Thread-Topic: [PATCH] drm/amdgpu: Retrieve CE count from ce_count_lo_chip in
 EccInfo table
Thread-Index: AQHaB8YhptG+NGEAU0yL0dd3WCrLIbBbi6zg
Date: Thu, 26 Oct 2023 05:31:24 +0000
Message-ID: <BN9PR12MB5257185B2D548647176857C8FCDDA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231026043642.1104712-1-candice.li@amd.com>
In-Reply-To: <20231026043642.1104712-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6fe4b647-883b-4f7d-ab93-4dac508f087d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T05:31:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7165:EE_
x-ms-office365-filtering-correlation-id: 681a07fa-94e1-40c7-6c71-08dbd5e4cb43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iGtejsayVJU2TrM0R6tRWE/AGcMRexm76FXNn87kafDaPUjFEXOuLFELrvp0IUjVAycB2K5GulSrRilp4cpqjIF4MNlqMUpJI96UkYrI4taMFd3NG2XQd72E8XJiaV6fPRINjeoB94pc2CLCaZ4/xhTFRl7YmSbsrm2iozFrTO47WAK5iKhrpxZp0ro9Xw9jEVOF4okXARiNkfyDI0kwM+HnTzWjjumqSnfPaUieAjB8TCvC+BItIPH0L/Pz/jYzpTyK7/aUFKo79tk+QsH7+TW8ZncSF1sImCvCnmsV5/k2pc/hbW+kahhwZbmAvPBd3wEdTl4Sh1cQgshhExXLu5H7BOtXj1mbTg2mAKlbbEe/zYko+NnP0x75oyJyFdQveTs+NUwR4L/CRtbyhTigfQUJC6eioykmmoTpdQKnjDeikOF9UVzoyrU9coUqnYPegyauHj0NWmw+qZpBF05aHSnGiZ5xt4Jq8B6nO7radGnk61NzrSC6+S1lx7PJjh1y7X4K+XDSBK70mV+1oF+A5rxoL3cthTxmbZpNwPbvryurwibr38x9jKQS2A1ErJSrXBUxZ2/Jw3OMQnQAtafi3zyiZUysqfqgkTFEXNrdhtKM3nSglkkRvyDjgxrzdLd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(55016003)(2906002)(38100700002)(66446008)(41300700001)(122000001)(478600001)(66556008)(316002)(76116006)(66946007)(66476007)(6506007)(71200400001)(110136005)(7696005)(53546011)(83380400001)(64756008)(9686003)(4326008)(52536014)(33656002)(5660300002)(8676002)(8936002)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OVFi5EVM5F9ug2D67d7LwWylo6blKlKcJz3a9sv7G6519z5zliUrr6Ud8Jh7?=
 =?us-ascii?Q?etZenCKEO7Y2aFnDyJDdMGEpxkw/SOwfQPN6ZtakRwZMvfAZTeE/8vN6Drid?=
 =?us-ascii?Q?Ui0uAX4s4y/6MkKxrgKLDWcfhLD5loiTzfWduuljIDw57M2eQPgD/n2uXJi6?=
 =?us-ascii?Q?DN+8e7bhgSfmA+uCiQ7y2IVTU587Guyml6tVm1jHfcX4jslYicFVtalakXH5?=
 =?us-ascii?Q?W5S2YnI8DOraGE/eVpFbLI/cTRH/auHvl0irlQM60rt4wg+vjB/apbmt2bE+?=
 =?us-ascii?Q?j+DiPtf1/CIaAw5RmmeIOAGrqxW6wila227RTZ2tsqijqwEiUsBpsY1ouBYo?=
 =?us-ascii?Q?STjK4IoneAbsrLUrq1XjgzsiVW9iCnxjE2mYXSqGhao26UbzRC/7pBWvjPhW?=
 =?us-ascii?Q?+5fTCGC3u4Rclfaj4Q3s0eKjqRPGO7ZTmBOO/YlY8KEhzDMNdsbHSLXQ69KP?=
 =?us-ascii?Q?qD09WoPoM/pAld87OfXoCT9rBTycZpjW69k/RiMoMDIMvaBnKS8U2HES08zJ?=
 =?us-ascii?Q?GW8FoKG/xJkpgJtqYvo65gp2WlihvCMB1aZQBIrWgMkmYHjZt2z9q/JgO6aE?=
 =?us-ascii?Q?05MfCV+d4fVtlwvVOszbdwQ542ZXPlwDdteAlWgCRD+DQ1QOC3GsiywRfVWj?=
 =?us-ascii?Q?x6aPypnJe1uIEKtN+QKEqon/Wy3eaPCKDy4v+llI5SB07Vh7Q9w36apMtESW?=
 =?us-ascii?Q?qsPZxVU+9Op9iK8dcEepLy/yqX7nZNVWL0b+JQwSrOC6I8koG8T+jVmHY0dT?=
 =?us-ascii?Q?jVF5ptECoJmUItEt+0AGPUVT2l5uIQUcMsp7Wuf6mOdK/5Ah7SPEXlvurwdx?=
 =?us-ascii?Q?wpVve8du4KhCQ7ZzhdK4RxkEiR9uKMzyszQWvNCf9m4hSlp9r2FkarxuSAUa?=
 =?us-ascii?Q?0g+SnN66p+2xV8hOBeBsQdW6TMtAooO7clAI4MMEjYWPAI+HbHZiUwm1dKcJ?=
 =?us-ascii?Q?EkYuV4NMEjYYPKL/NpqtUjFhM/rynIUqjX6Sq1Lwb8nhByGgqTCzEZg6IWRq?=
 =?us-ascii?Q?v0KILsUSgOlkduFGd0kiFplzeXr/V8zfHF5cnmGAU5pFeN5x7beL/Ca3rWly?=
 =?us-ascii?Q?d08XyARfL9XJs0rfYsh5t0wzIb+ZSRo/08EBLoYKGaDz0CVxLgwBwDyqowtO?=
 =?us-ascii?Q?grKWCrrMGxh8BOZaWdbza11I1WUqoDpeRtq7hMDlt84qdtDgLFSpSLXcoDoR?=
 =?us-ascii?Q?3EV+4TaerJ3kM55tNV7DMztEMedWlse88KkMEftB+32DU/mq3p7wrw/G/U6j?=
 =?us-ascii?Q?uBjTeBgW0+sY+yOdSi7zyvKe28zYOrL/OZZyF1Za/X0rQ1syJG4+7S5McQBn?=
 =?us-ascii?Q?kgr4TN+r4fFM58wVEPNbtxFKXMZYPfsI8wPewjZcyBd3O2Wqm6bXBf6j3ceg?=
 =?us-ascii?Q?7AsT28iXIOHi/bt05faiSsIsYrgR1H5BseCBMLONyVLKhcvVE0A4xQeVmlb3?=
 =?us-ascii?Q?jziaMkeyA24xsNs1JSRUB7/URocy/sWRNUgpb/gKgmVgm6qJC3zY32kz0+8W?=
 =?us-ascii?Q?+KyY+K2gr5DcdeBLilODCzaaLVltm3qZaL5XSfLDEt1EvciSXGjiJrqnds/1?=
 =?us-ascii?Q?d2zS6875SvjPUzSjWFNsRuC944203QYbEqD87/hY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681a07fa-94e1-40c7-6c71-08dbd5e4cb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 05:31:24.2172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7IKsraVzhyiNs2lx2xlbYH9Go1+59umu4PI+FXipU246ZEiVpireYP8lDHW/RdToUT/Pk3LI5bWIkqxntWtMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, October 26, 2023 12:37
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Retrieve CE count from ce_count_lo_chip in Ecc=
Info table

Retrieve correctable error count from ce_count_lo_chip instead of mca_umc_s=
tatus.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v8_10.c
index 46bfdee79bfd2a..c4c77257710c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -336,7 +336,7 @@ static void umc_v8_10_ecc_info_query_correctable_error_=
count(struct amdgpu_devic
                                      uint32_t node_inst, uint32_t umc_inst=
, uint32_t ch_inst,
                                      unsigned long *error_count)
 {
-       uint64_t mc_umc_status;
+       uint16_t ecc_ce_cnt;
        uint32_t eccinfo_table_idx;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

@@ -345,12 +345,10 @@ static void umc_v8_10_ecc_info_query_correctable_erro=
r_count(struct amdgpu_devic
                                  umc_inst * adev->umc.channel_inst_num +
                                  ch_inst;

-       /* check the MCUMC_STATUS */
-       mc_umc_status =3D ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_statu=
s;
-       if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC)=
 =3D=3D 1) {
-               *error_count +=3D 1;
-       }
+       /* Retrieve CE count */
+       ecc_ce_cnt =3D ras->umc_ecc.ecc[eccinfo_table_idx].ce_count_lo_chip=
;
+       if (ecc_ce_cnt)
+               *error_count +=3D ecc_ce_cnt;
 }

 static void umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdg=
pu_device *adev,
--
2.25.1

