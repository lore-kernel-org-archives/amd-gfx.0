Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F8FECAAA1
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Sep 2022 02:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EE510E072;
	Sat, 10 Sep 2022 02:26:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827E710E072
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Sep 2022 02:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blJAzn8n1DqkTGXS618bOFMCLUM7/kcQpF/Ix2JURVUppSwAhM2sfxeUpww5eBZe4kx7ZklJVKqOhoE77sV4QZTJx90IHn1xjLB+Mfe6jQJ1JW4EY3Y9JiUl7X2QUlx1dLOvbZLNhBb3e1p7BTFxVcS5Sn26DYdJ714YUdXWWCS3lXYSIh8gl6+TpiiSuuhQ/RsaFOV5J5hstegw5K6ZS/vQg9/XEeWfFsF8b6l29PVCM5j+Nbmf/5SyQfPsLx+zVItJk/6eQAjBhvtmRgICD3WMinXElxU75BTVYAVijkOKXQwyw5TO7sbvp77wtovLziIXilqbl26iwrsQaf2OAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM1dvn8zPIPc6MpSAkJRechkAfX37orLais/6IyUQ/8=;
 b=XD40wS84LY1SgLiGYVGNvQccfg2qAu/vQt2ViThl90AsIVpL5fSQNdk0id0Y0DtkkRMnMaN6f8g4NafHDyxopIWpray/+FGaX9fMt7EltzZRW/EjzvaHEwjkeIwtyzk5brksslXrD3OQfPuzYgI7qIYvhUAsWc+DgOY0r/Eq0Lqr4FCPkOPtSOIl4TWT65cOjqgCB7hJLeeYmtYTC8ouGrS6YyfnUUvwkx6YdCRtDgebmssR/FGsXo8yYTp9nq7TzXLG+IW5VfzrGTvyib/vnkcbfS4euEytLm6hHLAZfDEKZTgt1l5bOH+tlgTRh7Mn7Ax/BS6a/UAA6+yyNpvN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM1dvn8zPIPc6MpSAkJRechkAfX37orLais/6IyUQ/8=;
 b=IVTqnPn09M02UJaL+F5GbzMhtBQsnSwZw1TOyIpAiQbUmWSKvRyUWiiZ/wcAvhFDndTY9/L8xAANFjvMBU8806yjqM7xZf5UHDqPxNdFHZ2ygX4iaV76GTgH8Rrgdnu0pCdJaaeU5NJgt0R6LVH5WGx30RXxD3zxkaB/D6StHzA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Sat, 10 Sep 2022 02:26:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.021; Sat, 10 Sep 2022
 02:26:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: added support for ras driver loading
Thread-Topic: [PATCH] drm/amdgpu: added support for ras driver loading
Thread-Index: AQHYxJ/6xeCNEtzJQU6HKnEZZKUmRK3X8A/i
Date: Sat, 10 Sep 2022 02:26:18 +0000
Message-ID: <BN9PR12MB5257409A6E8B299F7CA66014FC429@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909230005.20646-1-candice.li@amd.com>
In-Reply-To: <20220909230005.20646-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-10T02:25:55.3505495Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: a58b5478-6c9a-415e-de37-08da92d3d808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QEhiHgYtCgjNBWdgB00Li/3JP268WktbruiDiqm5qyX9POO99Qj5vZMNk0hkWeOFLlvdb+xJNEniVpghqVfKvPR+JbKDEEf7rtzVudRMJQ0u1yuM4vEzYhyabA1dTLslKw+WmbKjwV7xRbKpB6jQg3kipLXnifU9wXcGGgW+eVubfV1Wza1v8JfEIyxTKVxWCikRMch69x5fm91Jwttc9/DX4lBV2piOOmMfPAetj1Z97oDr5TrdETVoppz1NiE5gi8aTOuSXEy8Sc7C41A/QchqN9eZ5NdRmz7wgExBV7mPgyfDmopjydtN/LO9IIIhWXkPaJzasYbp6hOFQCxBuh5sIrQ2tCUSnPdRjVZoRIIdzvDQCQnIVHim2reEg/shD301liBkLnJ5CKjbezjdC/hZL2dtjzqLeFrRosRMbMWsPULLEgf5o0rPbeIY2mWs+q9/6061ZuDaCYJoaFSoWFQoIUE7zfQXgwOMSn7PoflXCRCXW2hB1K0K86vRFagE1fBGqNImiN2CN53ENSKbIMG/HvDaqvUYw5p2+1+Wi7oiyX8ZBSG4zOjTbKth5BKFE3MDYB8EMPQiOjbVo9s6daG7jib/5J9nqiicSpsPhfSblBskkzB5kjEOSWL/rr3CPYon4yB9zrGy+4LqcuncHgHugviZCPAyZIgYxrinl0jcmZ5jkkC5DUnxwY7SFzmddpsWeU4zQ9Rg2+xPINfhO9duack/BpjIQiCAoqmpr6/aNp8KM/GmY2Ft2KMNnBxLadW36GifjE1wgG8RW+5Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(316002)(122000001)(110136005)(38100700002)(33656002)(54906003)(53546011)(26005)(6506007)(7696005)(9686003)(4326008)(66446008)(186003)(8676002)(38070700005)(64756008)(66556008)(5660300002)(55016003)(8936002)(478600001)(2906002)(41300700001)(71200400001)(52536014)(76116006)(91956017)(86362001)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GGqHzpleklnGi/z3SFgx3rVK0lI5KxVSPUAEvbPkp1wGQBXKXem/gUYQn1WL?=
 =?us-ascii?Q?wwLmBW/bhL00p/HxB1Khrz0OekdqcK5fpPPUNvkbtrDnu3B+dFWFlO58+Kbv?=
 =?us-ascii?Q?FewawdGsrejBeytLnjNY4zedXhNXomaWb53X4gUSjzCDK1Nf5QHXs/1+b2Ro?=
 =?us-ascii?Q?J5+z1R5e3n9THVMDiYR/H7UYqJvFiHcmLWcgv5nNFaEyglZXgU12oYENxZbi?=
 =?us-ascii?Q?kuH6E5Toz2c4rlT/oXNH0Y9WHdYss5GSf1NeJ2lBqlHbEygFyh8gUdwdoEnu?=
 =?us-ascii?Q?65h2stuh6dSqG75LPw2j4aay0kuC0YqtiLp2pC2XH33l03SpQ5In9uAbT4w0?=
 =?us-ascii?Q?qy3kOlfq6BYpkZUiA/dwetlDL4RVnrwNNNmPLt/HNTQSZyUSlj3imSUZpAuP?=
 =?us-ascii?Q?haq4Gc1o2N/vf5Y9foKzujf6qRP7vH1IZ0p4K7PPfvC1p9B6gYDxCEXOvnBJ?=
 =?us-ascii?Q?XUxZZe6xdv8g7O2AAODKVor/CEARvu7uQe9xjrpqor0ciJAY1XRaJ58Avuz+?=
 =?us-ascii?Q?tqAAHPRnf2znFTMcuEgYf5u5qRl3wkpCkOdHteouzRIJ6Gd89rzowWefFuFm?=
 =?us-ascii?Q?m9k10Z3qf4Tdkt5OGqKwkoZlzaadsMoWAddKFUf4l7DOrhj7CYmoyCyNMgz+?=
 =?us-ascii?Q?cj9zfwrHl+GuvmdzF0sRtyy7x9w57QCliN0Sw9Rg8Yv1mrqvwGL6eNBCnRFL?=
 =?us-ascii?Q?wsTJwFnVdP8oUYVctYRsT1LncxVZ4TyX+iBolOmCIovR/TsRks0V8NhAWbjA?=
 =?us-ascii?Q?yxku/cnJh6fTELxkrfG4yUswhJQyNRdwMJmQ5DjV3WTDE4pzWWjaNPLIXC64?=
 =?us-ascii?Q?GpAkt/GsQSzvUrCd7uwJ5lMzXvYTsW5xKMX4kBQ4pZh46tsFPcslEZPUDFoP?=
 =?us-ascii?Q?Omn9rHay6Tx+AQ0vTkpKnbu63fZqU3jpVKHK3CyGoNrB6F8bSaKiA13SrD38?=
 =?us-ascii?Q?HTqBdQvenwooGL/+AGfJhnvwi4/flM2/j/zaeF5JzB2TQIpmD7P0FF6qOi7C?=
 =?us-ascii?Q?dHRY+QhHmN7x2CM2xN5l4dWCxYxii+W3mgTpDdibPSz9Wxgus5P+8pCnxPJj?=
 =?us-ascii?Q?9BWz6JTdL0gQ6eEn+MX32UaA5uBqzo8yXGPdSYoMHoluYtoG1RnZ3qMOoIXm?=
 =?us-ascii?Q?rlHn4zHPDLuU+jWbyfXyjvgCkC817wcoD3WJ7QFxI/Jv9cp8hAW1El2G84Tw?=
 =?us-ascii?Q?UEmvLnDeXAHumipaqDI3jHtwd+Ect+HQXymTygpQ1pbiY4K+e0dcD/Nw8b3v?=
 =?us-ascii?Q?EUN28VqoESYYxCG88pSPImy2tvW7chakbV6rcBWLjDJR6FnbOk1SITrE1t4/?=
 =?us-ascii?Q?ZZaX6jOFMD4+lUigwom4oFD+54kcUqPLuKPHrdKbod5DqGFWndJwDrKI7QDt?=
 =?us-ascii?Q?CNSJiM5KzNyWXj9h/btWF29+bygqE0tIfLByRV+q3YV77nZkLbBunV7/u7pV?=
 =?us-ascii?Q?pGIw+Gz7NcwbBXdQh72rruwW+Fw16WXhfMbVHzt8R6swHpEHzfoPbof7ShyB?=
 =?us-ascii?Q?quubVH7EX/5nj4aKJkS0kYtsiBokrYyF3EmDPl0StTMwN/cMnTBE2rt1Lqd6?=
 =?us-ascii?Q?v1Lz9lik8DJcHtdc2AVbZFQbPAGzvWAJjIAqukXTYxkBsMut2TcSQKDov0NJ?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257409A6E8B299F7CA66014FC429BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58b5478-6c9a-415e-de37-08da92d3d808
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 02:26:18.5936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vh3KDgeS3/TS6sWYXLK2mZk2YHIBduSQ8nTXdIJlpOxYo7hStkvkQuC4RSg1xkz30kolWNhyJlkV9v05zwV6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257409A6E8B299F7CA66014FC429BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <Candice.Li@amd.com>
Date: Saturday, September 10, 2022 at 07:00
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>, Clements, John <John.Clements@amd.com=
>
Subject: [PATCH] drm/amdgpu: added support for ras driver loading
From: John Clements <john.clements@amd.com>

copy ras driver to psp if present

Signed-off-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c    |  7 +++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index cfcaf890a6a122..218666f6203a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2055,6 +2055,15 @@ static int psp_hw_start(struct psp_context *psp)
                         }
                 }

+               if ((is_psp_fw_valid(psp->ras_drv)) &&
+                   (psp->funcs->bootloader_load_ras_drv !=3D NULL)) {
+                       ret =3D psp_bootloader_load_ras_drv(psp);
+                       if (ret) {
+                               DRM_ERROR("PSP load ras_drv failed!\n");
+                               return ret;
+                       }
+               }
+
                 if ((is_psp_fw_valid(psp->sos)) &&
                     (psp->funcs->bootloader_load_sos !=3D NULL)) {
                         ret =3D psp_bootloader_load_sos(psp);
@@ -3040,6 +3049,12 @@ static int parse_sos_bin_descriptor(struct psp_conte=
xt *psp,
                 psp->dbg_drv.size_bytes         =3D le32_to_cpu(desc->size=
_bytes);
                 psp->dbg_drv.start_addr         =3D ucode_start_addr;
                 break;
+       case PSP_FW_TYPE_PSP_RAS_DRV:
+               psp->ras_drv.fw_version         =3D le32_to_cpu(desc->fw_ve=
rsion);
+               psp->ras_drv.feature_version    =3D le32_to_cpu(desc->fw_ve=
rsion);
+               psp->ras_drv.size_bytes         =3D le32_to_cpu(desc->size_=
bytes);
+               psp->ras_drv.start_addr         =3D ucode_start_addr;
+               break;
         default:
                 dev_warn(psp->adev->dev, "Unsupported PSP FW type: %d\n", =
desc->fw_type);
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index c32b74bd970fc5..d7a5ff4660cf9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -71,6 +71,7 @@ enum psp_bootloader_cmd {
         PSP_BL__LOAD_SOCDRV             =3D 0xB0000,
         PSP_BL__LOAD_DBGDRV             =3D 0xC0000,
         PSP_BL__LOAD_INTFDRV            =3D 0xD0000,
+       PSP_BL__LOAD_RASDRV                 =3D 0xE0000,
         PSP_BL__DRAM_LONG_TRAIN         =3D 0x100000,
         PSP_BL__DRAM_SHORT_TRAIN        =3D 0x200000,
         PSP_BL__LOAD_TOS_SPL_TABLE      =3D 0x10000000,
@@ -114,6 +115,7 @@ struct psp_funcs
         int (*bootloader_load_soc_drv)(struct psp_context *psp);
         int (*bootloader_load_intf_drv)(struct psp_context *psp);
         int (*bootloader_load_dbg_drv)(struct psp_context *psp);
+       int (*bootloader_load_ras_drv)(struct psp_context *psp);
         int (*bootloader_load_sos)(struct psp_context *psp);
         int (*ring_init)(struct psp_context *psp, enum psp_ring_type ring_=
type);
         int (*ring_create)(struct psp_context *psp,
@@ -323,6 +325,7 @@ struct psp_context
         struct psp_bin_desc             soc_drv;
         struct psp_bin_desc             intf_drv;
         struct psp_bin_desc             dbg_drv;
+       struct psp_bin_desc             ras_drv;

         /* tmr buffer */
         struct amdgpu_bo                *tmr_bo;
@@ -403,6 +406,9 @@ struct amdgpu_psp_funcs {
                 ((psp)->funcs->bootloader_load_intf_drv ? (psp)->funcs->bo=
otloader_load_intf_drv((psp)) : 0)
 #define psp_bootloader_load_dbg_drv(psp) \
                 ((psp)->funcs->bootloader_load_dbg_drv ? (psp)->funcs->boo=
tloader_load_dbg_drv((psp)) : 0)
+#define psp_bootloader_load_ras_drv(psp) \
+               ((psp)->funcs->bootloader_load_ras_drv ? \
+               (psp)->funcs->bootloader_load_ras_drv((psp)) : 0)
 #define psp_bootloader_load_sos(psp) \
                 ((psp)->funcs->bootloader_load_sos ? (psp)->funcs->bootloa=
der_load_sos((psp)) : 0)
 #define psp_smu_reload_quirk(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 96b6cf4c4d54f8..3975bcaa2c8997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -124,6 +124,7 @@ enum psp_fw_type {
         PSP_FW_TYPE_PSP_SOC_DRV,
         PSP_FW_TYPE_PSP_INTF_DRV,
         PSP_FW_TYPE_PSP_DBG_DRV,
+       PSP_FW_TYPE_PSP_RAS_DRV,
 };

 /* version_major=3D2, version_minor=3D0 */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index eac33d5c93e74f..262dcd7513a6fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -223,6 +223,12 @@ static int psp_v13_0_bootloader_load_dbg_drv(struct ps=
p_context *psp)
         return psp_v13_0_bootloader_load_component(psp, &psp->dbg_drv, PSP=
_BL__LOAD_DBGDRV);
 }

+static int psp_v13_0_bootloader_load_ras_drv(struct psp_context *psp)
+{
+       return psp_v13_0_bootloader_load_component(psp, &psp->ras_drv, PSP_=
BL__LOAD_RASDRV);
+}
+
+
 static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 {
         int ret;
@@ -719,6 +725,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
         .bootloader_load_soc_drv =3D psp_v13_0_bootloader_load_soc_drv,
         .bootloader_load_intf_drv =3D psp_v13_0_bootloader_load_intf_drv,
         .bootloader_load_dbg_drv =3D psp_v13_0_bootloader_load_dbg_drv,
+       .bootloader_load_ras_drv =3D psp_v13_0_bootloader_load_ras_drv,
         .bootloader_load_sos =3D psp_v13_0_bootloader_load_sos,
         .ring_init =3D psp_v13_0_ring_init,
         .ring_create =3D psp_v13_0_ring_create,
--
2.17.1

--_000_BN9PR12MB5257409A6E8B299F7CA66014FC429BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;Candice.Li@a=
md.com&gt;<br>
<b>Date: </b>Saturday, September 10, 2022 at 07:00<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Li, Candice &lt;Candice.Li@amd.com&gt;, Clements, John &lt;John.=
Clements@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: added support for ras driver loading<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">From: John Clements &lt;john.clements@amd.com&gt;<br>
<br>
copy ras driver to psp if present<br>
<br>
Signed-off-by: John Clements &lt;john.clements@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp; | 15 ++++++++++++=
+++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp; |&nbsp; 6 ++++++<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 7 ++=
+++++<br>
&nbsp;4 files changed, 29 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index cfcaf890a6a122..218666f6203a9f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -2055,6 +2055,15 @@ static int psp_hw_start(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((is_psp_fw_valid(psp-&gt;ras_drv)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;funcs-&gt;bootloader_load_ras_d=
rv !=3D NULL)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_boot=
loader_load_ras_drv(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load ras_drv failed!\n&=
quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((is_psp_fw_valid(psp-&gt;sos)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;funcs-&gt;bootloader=
_load_sos !=3D NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D psp_bootloader_load_sos(psp);<br>
@@ -3040,6 +3049,12 @@ static int parse_sos_bin_descriptor(struct psp_conte=
xt *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;dbg_drv.size_bytes&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D le32_to_cpu(desc-&gt;size_bytes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;dbg_drv.start_addr&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D ucode_start_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PSP_FW_TYPE_PSP_RAS_DRV:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ras_drv.fw_version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D le32_to_cpu(desc-&gt;fw_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ras_drv.feature_version&nbsp;&nbsp;&nbsp; =3D le32_to_cp=
u(desc-&gt;fw_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ras_drv.size_bytes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D le32_to_cpu(desc-&gt;size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ras_drv.start_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D ucode_start_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;Unsupported PSP =
FW type: %d\n&quot;, desc-&gt;fw_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index c32b74bd970fc5..d7a5ff4660cf9e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -71,6 +71,7 @@ enum psp_bootloader_cmd {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__LOAD_SOCDRV&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xB00=
00,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__LOAD_DBGDRV&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xC00=
00,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__LOAD_INTFDRV&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xD0000,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__LOAD_RASDRV&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0xE0000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__DRAM_LONG_TRAIN&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x100000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__DRAM_SHORT_TRAIN&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x200000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__LOAD_TOS_SPL_TABLE=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x10000000,<br>
@@ -114,6 +115,7 @@ struct psp_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_soc_=
drv)(struct psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_intf=
_drv)(struct psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_dbg_=
drv)(struct psp_context *psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_ras_drv)(struct=
 psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_sos)=
(struct psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*ring_init)(struct ps=
p_context *psp, enum psp_ring_type ring_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*ring_create)(struct =
psp_context *psp,<br>
@@ -323,6 +325,7 @@ struct psp_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_bin_desc&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_drv;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_bin_desc&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intf_drv;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_bin_desc&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbg_drv;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_bin_desc&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_drv;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* tmr buffer */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *tmr_bo;<br>
@@ -403,6 +406,9 @@ struct amdgpu_psp_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;bootloader_load_intf_drv ? (psp)=
-&gt;funcs-&gt;bootloader_load_intf_drv((psp)) : 0)<br>
&nbsp;#define psp_bootloader_load_dbg_drv(psp) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;bootloader_load_dbg_drv ? (psp)-=
&gt;funcs-&gt;bootloader_load_dbg_drv((psp)) : 0)<br>
+#define psp_bootloader_load_ras_drv(psp) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((psp)-&gt;funcs-&gt;bootloader_load_ras_drv ? \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (psp)-&gt;funcs-&gt;bootloader_load_ras_drv((psp)) : 0)<br>
&nbsp;#define psp_bootloader_load_sos(psp) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;bootloader_load_sos ? (psp)-&gt;=
funcs-&gt;bootloader_load_sos((psp)) : 0)<br>
&nbsp;#define psp_smu_reload_quirk(psp) \<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h<br>
index 96b6cf4c4d54f8..3975bcaa2c8997 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
@@ -124,6 +124,7 @@ enum psp_fw_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_FW_TYPE_PSP_SOC_DRV,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_FW_TYPE_PSP_INTF_DRV,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_FW_TYPE_PSP_DBG_DRV,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_FW_TYPE_PSP_RAS_DRV,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/* version_major=3D2, version_minor=3D0 */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c<br>
index eac33d5c93e74f..262dcd7513a6fb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
@@ -223,6 +223,12 @@ static int psp_v13_0_bootloader_load_dbg_drv(struct ps=
p_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_v13_0_bootloade=
r_load_component(psp, &amp;psp-&gt;dbg_drv, PSP_BL__LOAD_DBGDRV);<br>
&nbsp;}<br>
&nbsp;<br>
+static int psp_v13_0_bootloader_load_ras_drv(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_v13_0_bootloader_load_comp=
onent(psp, &amp;psp-&gt;ras_drv, PSP_BL__LOAD_RASDRV);<br>
+}<br>
+<br>
+<br>
&nbsp;static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
@@ -719,6 +725,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_soc_drv =
=3D psp_v13_0_bootloader_load_soc_drv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_intf_drv =
=3D psp_v13_0_bootloader_load_intf_drv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_dbg_drv =
=3D psp_v13_0_bootloader_load_dbg_drv,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_ras_drv =3D psp_v13_=
0_bootloader_load_ras_drv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_sos =3D p=
sp_v13_0_bootloader_load_sos,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_init =3D psp_v13_0_r=
ing_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_create =3D psp_v13_0=
_ring_create,<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257409A6E8B299F7CA66014FC429BN9PR12MB5257namp_--
