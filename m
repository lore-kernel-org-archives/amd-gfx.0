Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD69AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 10:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B71610E7BD;
	Thu, 10 Feb 2022 10:01:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CD710E7BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 10:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZBb7vaM3V2x+izsOiEuZ6X6474bhN9r7B2tFEiApYYdH5Lw51NV/J7XpG+VCpNy3JFbdLYL5QJR0jeATqXIkgMoNWz/UHoNKdDz7MzLJyVhSME/2mVome+i9VPa/NhnT8Sj5Tx5bNOC/w/MPw6x6snob5iUxbE53524STnWvpE7kflQx8BsMXLph7oEwd00zocLoQiSED3UwxoYOrWXryFDd8twqZmosJBj08uk0Y12n5g5wcD2t0gPUL57z4Jn6jpvF4zUoqF8+2nFdr37EwPOpsCjGN00WyD5l+nQBFi/pwB03YZzuwpTvv088PfYhy0G1XtXeL/NNBbe7p/fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHPsc6c/o9UXJUw8zTQzsjy80jU+ewTaH93gav1uhhQ=;
 b=hEQOQNT6W+i/zXwSSvtNm/7InAsiRnQLWFDRCZqMUN5qN0Ubx5strWv6GpPhWhlUq2vbyknSc+vF6mfp7oDknl0ONyCSG3F+eMiKQIwiCQd+ladC5QuMI5f6HcaaX0J95CwFt5TzYhfzGyjjquVTd0JJshH/1+YV//SNe4LHi4R3g1cMQTABhnCWdzUo6y40sPNVHzmx21UDsG/WJWzoNqsmEgh/29aowCzg1j0Zk60u/N4oVbW3Qba45X9FxjSJgW8uVSgRAYvc3fu/b0hInZihifbNUlEUvX1FE482HmB1X9UeMm4oob08x0dotSXVPWVwpsX5Eq/YFxg46lOgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHPsc6c/o9UXJUw8zTQzsjy80jU+ewTaH93gav1uhhQ=;
 b=3AbJ9VA77a1D0cyB6pwb5imBO8UczOosD/0Of3pga/J6f6K4YkkxcAk6+EWQmBHAce2XJw/z8370A2igm9ST+NSQ0r7Vujn/m18GhcMxOFpjQ9f3VgzNfO+6zqiICnfmNYVImkWc8+KgubPASBG4k5KqaHa1CqLMF+LZLw5mcVo=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by BN8PR12MB2930.namprd12.prod.outlook.com (2603:10b6:408:69::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 10:01:35 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::2d85:a89c:7814:f724]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::2d85:a89c:7814:f724%6]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 10:01:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Topic: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Thread-Index: AQHYHkknn+lEqxkKSEKEAfgJkCVv3ayMjbUg
Date: Thu, 10 Feb 2022 10:01:35 +0000
Message-ID: <BL1PR12MB52546BEFD2C3B67857A269C5FC2F9@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20220210064029.16545-1-guchun.chen@amd.com>
In-Reply-To: <20220210064029.16545-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T10:01:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=81a0eb33-4cd3-4cd4-92d7-720266dc994f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3285f3fd-1883-459a-83b7-08d9ec7c52ac
x-ms-traffictypediagnostic: BN8PR12MB2930:EE_
x-microsoft-antispam-prvs: <BN8PR12MB29309027EDBC26223C784910FC2F9@BN8PR12MB2930.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 989rD829ZEEVc1vBRymhhXsShSffqF3TObaAbvoxOTW6l+He7+z7l/uXKFj00cpoC1cnhiCgVVJ1RZQdiWvtcoYGyVHw/TPgzarA0ctBgiLS2FrLgQtEz/s3WNmoSupn4nW2x373KJzIbp4cMjCWfUYT1i2TrTbztxoQuEOsR6/W1MnGZNRUtTqEQdpU941TQk7kupg+lslqnh7Cue39tBXWOZgsFdK6zCf7NwVE3rC+YCkmg2Fs1YxAUvbM53jsaEDnUF79UxT21FKa0hfKEfnUQsIXUO1OfMGlfvga0ePyb2KSViGoH+ZUNeOpLG1IkGc9dGb+ltGFSAZZ8NZUdcd2FsCtQQUTHX1mXnTmQt/Vwo3r8vDQscASMxcxsOZZbzab49TPVazDyTjkB0OvT3nGQ0pa+WSSFsbuPE47fhqQTldQ5zxoKkQPuCVE39zkN2Pf/H2WN5FPw1IdJ3nyWu688SgH7xz4o/ReSSjRPfLbiMMAVqEb5Z3dg8tnDMjxanHGElAqwK4f9wNfnL4Osf264Pl51/aPXFVhMylip5sz+w94RijmPaNVf262dnpSQpSiF9DY95Q2uYF0fKpUA/4FxmEZMJ0h05gBE4hGKzuUok9ShtErwzmB+RQ0O6+gsZgyWfKIF4skJ5vpnSBC1CPgUrmbRWyuCS+eFJtIoh5Uo5sEUSiYr8EwVL89IMfZU4aAKcz97MOhbdDW1VG+vw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(5660300002)(26005)(186003)(86362001)(6636002)(38070700005)(38100700002)(71200400001)(76116006)(53546011)(122000001)(316002)(66476007)(64756008)(33656002)(8676002)(83380400001)(66946007)(66446008)(508600001)(7696005)(55016003)(8936002)(66556008)(9686003)(6506007)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wjOrNw4O84tNwufbSgT+472UKUyZgcJpBOlRpz81Ug2cY+ldadC4xBwfKkxM?=
 =?us-ascii?Q?17xf9pWGxi9CIoo4ewpllL+2BjtF957kcLOfAaUHlcagT5pWr3deGU7dNCUA?=
 =?us-ascii?Q?amboQEZEz/SIa1Fas4YlynGyjq1XWdOu5c5jVeI25GSw3fX9sRJBV+FuG/9t?=
 =?us-ascii?Q?OSSfDm+61H6+tM/oa787RX4VifGxMcyut02VP4SXIFE54NuThCjRutbKbw3C?=
 =?us-ascii?Q?im4SivmH41HimpKAEsC/iDYyVBE/rpoSxHkd/jeNz02Y+VAwVytTHzLzcISn?=
 =?us-ascii?Q?kfomfWT3AVXS9MuE8bKy/XmtxPeHbBKwGkdvz05rCrx48cweNhWNUpJNBiqg?=
 =?us-ascii?Q?NikaOXdv0aLihe4FVFPVIjDNuqivBW4MtOgo54GdAIx7N6EFeIqPWWOFwy88?=
 =?us-ascii?Q?2LG57vgmJAW2b66oFNlQBspwk3KPQjyWhRwXYeYD4wIjRcAZXqdsOJ0xlyO8?=
 =?us-ascii?Q?BJZ+Pvk/I8VMY1eBz7cj+8HRXxRn3ExzsC6fT384Zet0TwEKOBYDrTFKvFbS?=
 =?us-ascii?Q?gBAInCOBvsNjU8gFUj8LzwnnhTi7sb+EQYlLCRsHhhKh0Wjx/rsw+v0FOHc0?=
 =?us-ascii?Q?uffjrM4fturSo0W76rz69BEQT13+MeV48BBmjwFFm3D3x+cz84UTPslqvN3a?=
 =?us-ascii?Q?PGUCxdYxXSUL22HeLX5h07+X2PkwP8ycr0WqmxJ1Qo56AabXjojf8nK4Rpc0?=
 =?us-ascii?Q?p4UAXkZ/319fZAnCiwQ6g47/vnURolIzGPNkxifRLD4YxVDKFNzr45i/KGa6?=
 =?us-ascii?Q?5f8d9ZS+9ILIpoIHxV/SWJkuvMeI1oidJRTjKN7t2I397bhYoRKhdSEPboZN?=
 =?us-ascii?Q?gNOfvo9FSebmY2TUqw1N0YMYXapYHTFDjn677qruaNglDlfta1tHS4FuHwqM?=
 =?us-ascii?Q?Wt8s7YwpAF8iYN1h7d6SirjCz8nCQdvvSA+iDgOV2cI6QL3t5JNhmTNGIFNJ?=
 =?us-ascii?Q?t6eA6DsHaIva/Rxt+tXnEAEbtAoS+x8sfytFPpPOteootNZqbzULSTtnTh3O?=
 =?us-ascii?Q?7UsZpO1EIJq41hGuL+LiL01csPMe5oEZj9yHVMAwBFV3c+9RoUBggpeRN2t4?=
 =?us-ascii?Q?2EElUwMBWBrvVxrkcIZSWUbXHzu5DFSGo7q5cvdKGn4zlKR1OSU30Rs7B/3l?=
 =?us-ascii?Q?eWscbQpQA4k33Kb2mX7a1OlYqJGVK4+K+/EGieBi5m3VVmsx16JZZHZt+J5p?=
 =?us-ascii?Q?TqRp/DFhcs6zKJamAFXewUBiy2laWfuw4D7EPaakZBcpB7Uh/3Zld1HwLy6E?=
 =?us-ascii?Q?PeVLzc0si/ENXHcgo1r4unGgrvaAvI9Fn0VOhPLsS+ZQEWSKOQCU7dh+RAZK?=
 =?us-ascii?Q?vBpwvAcqG28Lf/U68NUNK/1EXihpoKK9r50hUerrHhcv4CRCRCz+y9hd/j3f?=
 =?us-ascii?Q?oEG/3xUc1jsHNg8To1kKge4iYKacPdEzEpKeJwWIOP7SSrGjlyAJL0vtXKiG?=
 =?us-ascii?Q?tN5DPTr6tzbekFQnQyhPJwKsA/1vQb8yqzrHk2jiJtnly9zq8R+3/vki6Nud?=
 =?us-ascii?Q?uNkjvBs2T5ptIogpBkVpqENCg14GQewlvxNj/EztqqHMiWW12iz5C7/x2I2n?=
 =?us-ascii?Q?nMGNpFvzPpjXBrwRDAkT+6PDs2oYMkitwtvelovJO9Tl78CU+rgTqnslIod+?=
 =?us-ascii?Q?BDmpfnNGP9tZ79jqKvzkp7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3285f3fd-1883-459a-83b7-08d9ec7c52ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 10:01:35.5523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOnXF6JXv4c78OK1iJS687SUZbaV5dMUd0YT+FkImnzTzeJN0b74sQIDb6KHo3/b7VlCztSazFvZH8pl/bu5AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2930
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Thursday, February 10, 2022 14:40
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9

Fall back to MMIO to read registers as rlcg read is not available for gfx v=
9 in SRIOV configration. Otherwise, gmc_v9_0_flush_gpu_tlb will always comp=
lain timeout and finally breaks driver load.

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx=
9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a3274fa1c7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -37,6 +37,16 @@
 		vf2pf_info->ucode_info[ucode].version =3D ver; \
 	} while (0)
=20
+static bool amdgpu_virt_is_rlcg_read_supported(struct amdgpu_device=20
+*adev) {
+	/* rlcg read is not support in SRIOV with gfx v9 */
+	if ((adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(9, 0, 0)) ||
+		(adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)))
+		return false;
+
+	return true;
+}
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  {
 	/* By now all MMIO pages except mailbox are blocked */ @@ -957,7 +967,8 @=
@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
=20
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &r=
lcg_flag))
+		amdgpu_virt_is_rlcg_read_supported(adev) &&
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false,=20
+&rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
=20
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
--
2.17.1
