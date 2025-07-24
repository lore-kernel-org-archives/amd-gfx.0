Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7C3C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 06:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DA610E888;
	Thu, 24 Jul 2025 06:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gAikKUB2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F55510E888
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 06:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6ajBtUYcA7cS2nKj6lqgr5jlz/cl80EJe1CUeJxzYMcD68kjw+7vbawMRUQVVwgBfMA2ZHmtP6aB4n4syT6O92n2V+bGZKSFWfLJrQgYJRCzTCfLvq6ZUGsM/PH5z2/xEWlnfJQFo8lhTEdTTFo71BPZCFPs8COatH84mGSiTxlw6IeNQEU7uj0WAk/LI2bPAKz8dNppnGuGSadH1xgnpgOA7zukNIIKzJi1XqUUsd+xkgiefB7cBD1dgZuDsywM19N4IK4cZFaWAAendmT+39aaTJNrhThCQYepg9uJUn1cTRBjcOaW2uxeyFNLXnSOwGPqvNgkE0e9AXqOXB3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poYJnLVrXYf4240cVTN19XZh6Wsr3c5MWz2HNCFq/yM=;
 b=vjwhuaClo/AOq5f5YujgY8ELADDivb3mMnyG2ol0/C1187UNIbCcNNi7E5ytBdrleWShgcqt7aEkwAMIAE8TdzbPXOg6JBd2/uDwcZXuw+oGxOOhyOm5mRIpnrerB5bq4GwYAuJODY2Be2wT8+8x9rop6VizI2pStY2L/jWG/pcFUDdNTKPDTGcLVkdKTrhndfA6XZs5NGTyPcwhyOc+fT+Mrzx2jV1UPboIrlYbyP3WKvoI+T7aYNImw4hHqIwULbwbZ0HEShRqzm5z+uETjsk+TAbqW8aesuykBmWgBPRY0WohjGT2XMqYKgefZhMPaq8G+2EbnUkHDVMCHWTjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poYJnLVrXYf4240cVTN19XZh6Wsr3c5MWz2HNCFq/yM=;
 b=gAikKUB2i8ZGcQx/Ncn35H7pnQQtUq2PQPSDKKWUZ8PoZe3SNG7jMs0kq7A7I+HMZ5dBma2ZK7FkvEOSt+5fuw3y4ojD066igDQIGh3KLOfJqvi+xcPj/bJTR8/dpPwUpdm4ZTmClmpoMPjSIWqmSbDlCSTlPzvMbj6iQ9fx6hA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 06:25:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 06:25:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update IPID value for bad page threshold CPER
Thread-Topic: [PATCH] drm/amdgpu: Update IPID value for bad page threshold CPER
Thread-Index: AQHb+5zFtpU0HnczlUSAllHhX+yBcrRA0Bng
Date: Thu, 24 Jul 2025 06:25:13 +0000
Message-ID: <BN9PR12MB5257529F64CD11CE514FB688FC5EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250723064040.10231-1-xiang.liu@amd.com>
In-Reply-To: <20250723064040.10231-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T06:24:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7296:EE_
x-ms-office365-filtering-correlation-id: 5658d11a-c3a7-418d-2c8e-08ddca7ad90a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EpApoVblRdlUjK+yR1ERD8hPX5s5MoRUhK9iw1GAPmk+R4o42gmqrXzqC3M+?=
 =?us-ascii?Q?D5LWA2aat5EZ7DlV8iUq/9ddNTdLc7lLPtQQ0lpy+uwgCy5gAFmbE6qwvoKj?=
 =?us-ascii?Q?1j1GgT224eb3X8jRmMco26T+o1laDIeFnKEuyrjZVS4myo7FOL7OWu1Ndtg8?=
 =?us-ascii?Q?qbxGzmCdDYw3/Lb+OsDggPzJmdjg359lKsvrxLT3uMjb+0EpX5ppclF1el5g?=
 =?us-ascii?Q?/ncN6eQunedFj5/e0AGXMgwCzkJR6aC2V33bz8Bh4+AT1XTp0Cpojp4R73me?=
 =?us-ascii?Q?X5hY3W5ZZV0OXOlgYTLP2+6QRG7GZZJCYVrDlap1/uze72grZwflL0racWSc?=
 =?us-ascii?Q?k+JiCyAAjuUlTTwlR/ZnVplduLisB5a4XriMD+n7ZdPrD/zo/8ynkkmnhCtz?=
 =?us-ascii?Q?gPUdGnxQJV5AunCLXhXIXB/HlVsYhe2ZO/73oc4MW9AQgYR5bCCZhtq3KKPp?=
 =?us-ascii?Q?fEXUwHLBs6SB5pf4XDi0NtVThf8fuCpBfQxGz2P8ZAkZjvRWuP8KN4NpulP5?=
 =?us-ascii?Q?k98k2rFpBNLN+++9G1enmTOnjrYCW4Hlnd509l3CsiOSEP4E/eDBYK9hzpxk?=
 =?us-ascii?Q?AOIqmR2bpke4DcRk4t8iyon5iOD/l6Dnubu0K5i3FGPM97NDpWn3/VgNeOpv?=
 =?us-ascii?Q?3x6A2IgdD0eS7PhWcRn9LPjSippW4AdwCIFoInEqgi9YAkRuvdBo+sGdMal8?=
 =?us-ascii?Q?OCmFu82WBEgzLXOAxIQ8eEZ5RD2+AcBlcUGQxOr2r/cEwW/kU7LaWVTuUnW5?=
 =?us-ascii?Q?JyJRFq2/nnNDZrLLHS2sh0cKbJ2Fy0jkIHlWLdKTokbinLt/epcthwoDK8ho?=
 =?us-ascii?Q?qXQzvlAkdZGXkTGq/O1lPenwfcIVGdc+4AoOZyaNI4fEapX7D6fWrO0N+JWs?=
 =?us-ascii?Q?UvU1DySXfIhHZiS/s1nTWFYSo7Aq9/4FH6K+W5g1J8FezLZWP0gb1w7LDDO/?=
 =?us-ascii?Q?NaXUqnLTPhHY49dOBmtliGVKYzJmlz4yByHJ7v9i3kCtmcIxMkc4lXvD291m?=
 =?us-ascii?Q?3TqRGYCbL4JmnJxm+4Ux/b6b4BhefqDebfRSeEpsFFEAI793n+4Etq/aZU4F?=
 =?us-ascii?Q?Lc5N93MLZi8pIilxqRtMSPsZHbJQerPtqLJONa79Tae8zXud4e8E9vMU+i35?=
 =?us-ascii?Q?OsCodtwktdlJKjxpfz4XKQcQ2fuSVRoztdzGbuU0xiZ5PTU5RK4EUixoemyg?=
 =?us-ascii?Q?RChZWqzXA+TBGvM1FYOgCvHLxKUUYxOtlq6/5V7sJs0R2aMUutu2zxoFNI+D?=
 =?us-ascii?Q?Rmjhj2DUbgDXxALWECGlncW30oA71rNffswTZtA/4QlCJ8Lf4fPEbofJul3t?=
 =?us-ascii?Q?irTHANZFX7bc3/TEb+ntSQLqmBjYWEKZUUWizZPXexZkiGZhCJoN9uUUuLVo?=
 =?us-ascii?Q?qW9th8JrnEp8opyxqdEKXnxyAO30qz9bXXlUiQzzcQwuaUk9BNwZ3tEg6RUq?=
 =?us-ascii?Q?ynTaCeSXZsgh/1IrNIjzB0Fwgt8Z9YywR0L7AeeKHkHqf9jz/XWMRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?57YTmJOTJkiHOHLCuPdmPC0/KaqoDT0+8GF8TWwQAY+fF0TYVfLe/V0b1pEn?=
 =?us-ascii?Q?M3l9XsiAUJxEIEtzddoeIqUrujQLVblfTYcGrydUzHfZxZ13Fr4hGeUD0JoD?=
 =?us-ascii?Q?v0PuuKqzZVP8go7UwhYxScq4v+vD2cpwiRpkiM9TINiOeiWqzWPSTzzU0av9?=
 =?us-ascii?Q?r7lyjrEqV5i4/ZRVrERWz/lGLUccxl6FC+w/nE3eicLdzPu1HeBXX73thVIK?=
 =?us-ascii?Q?iFGhsbsIzv+CnW3Vt8FZnIxC2weS58Gu+tS2DMeNQeVOI7BRrvnNt3ogOqO6?=
 =?us-ascii?Q?C+Kuf32cXXJDz+BK6a5qf84wpwR9u4LFaFlbYH0GnfTcLZi3rgbBH204TK4J?=
 =?us-ascii?Q?xafrbVF9tzapyJ1Z3tZZ2O5L4oM4WQdNDcjxR4hCrNLBbflnyw02K+GrmY/C?=
 =?us-ascii?Q?p0OsTnreAlHwfgRWnfUSeW1k2+5sZuLpQft//yPy70D3uL3d8Y25Eqx/y7Ep?=
 =?us-ascii?Q?AU3TkClGHy3laJpDQ1EfxfWvfQr1dwTBROOQNvc+gVLgrk1CRkt3zDeyWnV8?=
 =?us-ascii?Q?WsmKSjZMQLUoyRDLiX3ypCdHBLZ3RKQPdWtKhxhnAWD+smAwQcyC7OX19Lcb?=
 =?us-ascii?Q?G1gqAVr7ZGOAs92lzF9eaXsTreidb7GsjIrkX61ZEe0305xM+sE2utQWgqv3?=
 =?us-ascii?Q?n298m3d/oKQj+HSz/5rdUujDHxtSL/PtAT3WvEtWqpxgOv/OnUFaLIAWQfSp?=
 =?us-ascii?Q?C8RKiOH4ph2SPV6dmcPEyh7xkRxCGva6Xwehp+6JWNCmrbtlL+h1b+ibmtmI?=
 =?us-ascii?Q?GSCqFq/pQ7FLfYVqBNlm8LDbuMt9Se8NA1g3gEZ5poZPhfv8l5rGY39U+T99?=
 =?us-ascii?Q?3F6k5mF+F5PwLfv3aijuaQjP52HNhtmVUz2y2ynlip/uZgV8rl4IMRyrvUe1?=
 =?us-ascii?Q?tdqAiNr3GG6twZK/NtyzYVSWywHF1gljtS8tVMBPF1Sv9jVAtlimb2MfDino?=
 =?us-ascii?Q?h8J8snAHW74rU/7zMWW5ejfkI4wuP7asXO7b9S1hWW1C6dTHVTD+d4aR56/4?=
 =?us-ascii?Q?cKN0wwHG4mhUUYHLBb9qNkLSmqgzsn9k2u1qPFNxagglDsZuljbfhZD+YJLc?=
 =?us-ascii?Q?bg4YLB7qSciGsPcg9UlOn2vLdEkHwthrhGrpPhEDYU+eqvhXDWv5plkb8O/v?=
 =?us-ascii?Q?qRNYvl44o7AWKnsDMoiiq7M2L7aGLl/jNAtclAT2CfcEmgciEpqPQLGriZGp?=
 =?us-ascii?Q?vny6/lgZinf0nV5Hjcg+qJH1oTvEVQFim4aoFy1w7fBECiPC5hC/9lQXOXUx?=
 =?us-ascii?Q?EGS/zyraym6OGqaCrAWd2ZaugL6ABuZO2AccAViJr3KtzTP6JFxKiJl/zANI?=
 =?us-ascii?Q?tfu3Sfvi5q/iVSPZluzmm9G+D86zmJqYt5Grr7n8SgDMz3JaONXEP+7v9I9e?=
 =?us-ascii?Q?zzXL4aTyCCGraPqANvlDFPdHs4bYziwffYstL3YeNDzOTR70jxSFSZwd54Wf?=
 =?us-ascii?Q?aQzVn3onCvHc5F/ANUtULbYvUFWgCVPbyphyibAmuGSikBT1H1xGqizo+tWp?=
 =?us-ascii?Q?EFFyyPjjtiE1Jk5DFA9gukXj2pGmbeuCSN2GvwypV4KYCT695kFGomgMCqoN?=
 =?us-ascii?Q?2G5vhNR2WK2G44cEvvnDHAHV8iFIGvEV4mJvR399?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5658d11a-c3a7-418d-2c8e-08ddca7ad90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 06:25:13.2198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+d4dF396Q5z1eAltOTZNV8bXW4Sap4fs/Zksb4W3YmhnSIFW6bQhQJzXXWsWyucStp8WsQbToXZwTqiLQ1rEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, July 23, 2025 14:41
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Update IPID value for bad page threshold CPER

Update the IPID register value for bad page threshold CPER according to the=
 latest definition.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 15dde1f50328..d16267868adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -206,6 +206,7 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(s=
truct amdgpu_device *adev  {
        struct cper_sec_desc *section_desc;
        struct cper_sec_nonstd_err *section;
+       uint32_t socket_id;

        section_desc =3D (struct cper_sec_desc *)((uint8_t *)hdr + SEC_DESC=
_OFFSET(idx));
        section =3D (struct cper_sec_nonstd_err *)((uint8_t *)hdr + @@ -224=
,6 +225,9 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct a=
mdgpu_device *adev
        section->ctx.reg_arr_size =3D sizeof(section->ctx.reg_dump);

        /* Hardcoded Reg dump for bad page threshold CPER */
+       socket_id =3D (adev->smuio.funcs && adev->smuio.funcs->get_socket_i=
d) ?
+                               adev->smuio.funcs->get_socket_id(adev) :
+                               0;
        section->ctx.reg_dump[CPER_ACA_REG_CTL_LO]    =3D 0x1;
        section->ctx.reg_dump[CPER_ACA_REG_CTL_HI]    =3D 0x0;
        section->ctx.reg_dump[CPER_ACA_REG_STATUS_LO] =3D 0x137; @@ -234,8 =
+238,8 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdg=
pu_device *adev
        section->ctx.reg_dump[CPER_ACA_REG_MISC0_HI]  =3D 0x0;
        section->ctx.reg_dump[CPER_ACA_REG_CONFIG_LO] =3D 0x2;
        section->ctx.reg_dump[CPER_ACA_REG_CONFIG_HI] =3D 0x1ff;
-       section->ctx.reg_dump[CPER_ACA_REG_IPID_LO]   =3D 0x0;
-       section->ctx.reg_dump[CPER_ACA_REG_IPID_HI]   =3D 0x96;
+       section->ctx.reg_dump[CPER_ACA_REG_IPID_LO]   =3D (socket_id / 4) &=
 0x01;
+       section->ctx.reg_dump[CPER_ACA_REG_IPID_HI]   =3D 0x096 | (((socket=
_id % 4) & 0x3) << 12);
        section->ctx.reg_dump[CPER_ACA_REG_SYND_LO]   =3D 0x0;
        section->ctx.reg_dump[CPER_ACA_REG_SYND_HI]   =3D 0x0;

--
2.34.1

