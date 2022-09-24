Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E3C32771
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Sep 2022 07:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F2010E26C;
	Sat, 24 Sep 2022 07:15:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2E310E26C
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Sep 2022 07:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMeRoPq5PMm0dG8t1dVHYTIwOAcJx2bdYWqFkKQGaeGVoCP19eym/eK18gbcpUDndQlHioKnGMDVod8Wj8W+sl/kC9f/Vkr0mlvDeOhcpsPOOZ012nJxDg1CFSRqf5yW89LGW2zCyM6At4EMkRuPbnWaM182WbefDUJyO6a8kkOn0TLwniOclKMrihSFTmsLPKL9DdOl3Nhav7eDU8QipTbK/ROMmdrNzRTIMPbByBZY/u4UA1W5vjZdbAtL41UdFUXy0TgkN5muUjQ0G0nenaaNUh4o0PPl7aTO90UtlBh/Bl/19OszACvZYz1NVTeqWHNQ9fz3M0RysX290tmNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OLINYSv7b1VzXuZ1dV2+VFxCiIIwtyEYrbxa5PN3mE=;
 b=h906KDWJprWuw7tj103kCdW3SBsWqTFma/OjET9aEk+jeL7WJ7KjvZoPXpAUVVlNPlFyzQX9olCmEfHQzbAildHPsxIwF19II/k6XmZkOi8BPA+p/ldY6pppnokx1Bqe6QW94x9WUfE7viNrdvAA4AmazxusdyAhic2fj6J9ypFXAmeXgA2yNYu3RbX+H9HqW5SeoMwitSRJto1sd3oK7a2jK160dwyTd9dCDcqRjhzNGhOp65YVOrx0/D/vNgceIl9Zve4TXUPF2D/Nl07TsZ1knUFeohoVgOmY42uZYa1lzzr4euahByZpkXk5eGTEhRETJN0HDVkgh4UED+4zFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OLINYSv7b1VzXuZ1dV2+VFxCiIIwtyEYrbxa5PN3mE=;
 b=yU4CpUWjO7ffXZvrTZKahl650IeXaF6xFpxUVtQA6l37W8fW4oqxNhkarxBUoqh6VPBqUpvwXWEiumpB1Rw3/XO9KDbwfjEQBMvMdfBSAhyuuAZZuLvhAEMdVP5pnKLM+4cs82Rl2ZcHs/XgJs/8aI5MAVr7TCbDdrWu73Hjp68=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Sat, 24 Sep
 2022 07:14:59 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%4]) with mapi id 15.20.5654.022; Sat, 24 Sep 2022
 07:14:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>
Subject: RE: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Topic: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Index: AQHYySTmgJsXODeP902eD0FqOtn04q3tlsiAgAChG7A=
Date: Sat, 24 Sep 2022 07:14:58 +0000
Message-ID: <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
 <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-24T07:14:55Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7326:EE_
x-ms-office365-filtering-correlation-id: 1c108473-9a8d-4303-06f6-08da9dfc7d93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDYIlDmAFgaVEUEdjto5EbTuq1VKTY/QRwu22oKB3FaW6obCOaUtnvkPSfuBJ+V9d8Sx+T+utKwGMD/TrbtrPflTr+ghRcF6BRcaXEnuiJiOCWKyFDnZjWc5Bl1X53iJLqyTVIlK84Zzt7i+Q7fHNI8/iq1yb07vwEypw0Rrf1JYLsvJokssqOpEuCFLWBJuZx3cRic7GaF3p8wK808htS/OopjAfiZ2slnZDucwI3nw83LE29zA7opn5ATCRLcAuq1hUvkLL8tFobxvx9VzZOdHS4GF1gHAoBT1ANSX/jvcoBNCk1hn0QANVGWc/Tk3Gk8HLxab4IwkIiPlFO7cawZHcs8b12Rdhqplz5szqrMiSxBziqp4/1O2GQV+9qAlCzaPn+gnFctkjQVxxRlIjMWq+0PzR0Po20oapMl8pl8WvVtxH72zW+PPFS8p9kyH+nms5vMRM2oJKKH7NuRKBMBvhorxq+acQw1BiwFFHSJbYUes3otJzir+juAVxOBjYN8XwLcEupTK1pmJgN3BmfFVCP8XQoxUdKy1m5JSEbOUj9X8t7JB4d8fJ2iXiFeL+slz4Eh+cPlwpvDoxBNqrfvGPCjL6OWPGH/A26SzPCoI6u876Y5Pd3GgZD+otMXmnxpIGhUifOmz/8FEPcgDCvThapd/awonb11OonbTLd9dsDNla9oSgs8Sug0fUy2vZoiRtSbBY0Tv87rY+saLVS6/Ku2AygT8iRMJA/EZ+eHfqKrtRdokIDA1jy7gLnwDSb0pTdvVRfa4a30u6ugcDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(478600001)(86362001)(110136005)(6636002)(71200400001)(316002)(9686003)(52536014)(8936002)(5660300002)(33656002)(38100700002)(41300700001)(8676002)(66446008)(64756008)(30864003)(66476007)(76116006)(53546011)(7696005)(6506007)(66556008)(66946007)(26005)(83380400001)(186003)(2906002)(122000001)(55016003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yK9VzNeK6mq7VI6Lb0FuBLe9L89FjN0cAbVVQxCVQoKqVcSNgjaosdrKcp3j?=
 =?us-ascii?Q?euy0ixbYbXdt7OGgazJgPy02vypEhMt1hgH1Bpm85SJQBEIvUSVd1TRaPUQ4?=
 =?us-ascii?Q?HXMxJkDvGpgcP1u7lCGoiycT8H8wnOFpGuNZNhiUAFxyBbJVZ9heIGyyck9n?=
 =?us-ascii?Q?K9LDIMI+KIeCIoQYb4dOSRdN0vEfOT8dUqbUEX0NmodFHPf1pCWBdc/0yKiJ?=
 =?us-ascii?Q?I6W81hoqHi3h2TFkQd05oPJudyuBe5najAgyt9PoWrhWdXvfT1QZPpDSRJ/C?=
 =?us-ascii?Q?SFZ9U3ERiaFQW5dkh5uJ7HlSVGQK7vq0+O8Skf6qyHlit4dDUdzF9Vwit9dS?=
 =?us-ascii?Q?I2+EqdIlJUxpjQRNgaNWD/Dt5fHbkstuVpi3wh9NdEn8CorjbklwKlla4lFL?=
 =?us-ascii?Q?pLPuZIxJblEJrcghuBNRgLsjnGk6eShnqYAzKRIiMXCcHkLMyZx3SLb1CTRh?=
 =?us-ascii?Q?C3E24HPaGf/ntU6IuN0z+40K6pm2amRg3t+QcJSOyrvdQbd5slNcAuBcnfLw?=
 =?us-ascii?Q?9AY+4W+P3U5g82uawIRYzwFXdreRcEAXg/eIdzdJAZir9TiJQKt2EpLiWQCt?=
 =?us-ascii?Q?//NklCKu3ZZ7Y9KyVk/Z4yniM778AA9pkdxm3Uscf383QfjuKnDNCrqFpxAb?=
 =?us-ascii?Q?ylvVqWsiQ+M+4O7Dq5IGCz9znwhjv8Mz2W/svH6KsmFCxYKnrVR6AYKFKuvP?=
 =?us-ascii?Q?o8HWcUsjuDNCQnj9i7/PatWT8IHe/2WZkZdV37Jw7Cl/PGuA/wkes7gzji3X?=
 =?us-ascii?Q?ZwibIHNQfBrZ9l/+QttEoSLHE2qtgHUKQa8uIFF+caRDN7iYln4APnYHMHBv?=
 =?us-ascii?Q?E0LD+R8L7f0gzESaMjHLG3eNpY0uwY3JG5RC9GsGjjQVzS8RD+whoCKiJMga?=
 =?us-ascii?Q?VU2saZvMn5AfwCtJ8rvRummEk5h64ZsDqWeBbcX4L0+C651UNZkNHoRoQxeg?=
 =?us-ascii?Q?LrAy/bRN44SdFTcCyeMS4wbmCwCK1CfqQmjKWd49TVF/6975OEaP43n+B41e?=
 =?us-ascii?Q?BvE8gKSH3NnMh/N3GrmMiqlGIhHPqNFVRXcLkRgwRG51lrDp8n+HAMPwcpX7?=
 =?us-ascii?Q?NuxofIZ4f/CeRDY0MlTQqjWdhhyJrSDPX8hoxYnbo7iH50ZUTILM1kfC4ahy?=
 =?us-ascii?Q?S3zhbvalNKd3Tr+ibBSPPj8EtdvZ/pMzkoqzSOFnZpHucGRTRHSvkkhXlFil?=
 =?us-ascii?Q?eIa/vPmoX9otOh3YYyKsKBH8cs2Yn9q6k24VEih39/ts0bXsP9f5PsShlZYF?=
 =?us-ascii?Q?LLUghNqrUCVwY75ZZMTeGJa531EY+9ZYOFjAcfjUm5Ly4IH5ZQJAiDrKjE+S?=
 =?us-ascii?Q?/U1/hU/Rw2IAoDVgnSAyrTNIDXYegcNmOVKmrfmpWrJG6KPdRmVSoEKjksNl?=
 =?us-ascii?Q?K70bOhtaoQfA9Ts27PMPe9RY2FON0rE75yjx2iQM06ujNc52GTmWAG7CeQQT?=
 =?us-ascii?Q?RlXpDWzKd/3DDIlw3XQE2t96QpZCQ/3dt0AX832V4WxDYjrTsCr1otk5W5n+?=
 =?us-ascii?Q?uLSqf9rKkVaXUXEMJ8XHQZbkTTE0CvhuPkFPM6dpEdqmyYF9hlzvFxVdHbXC?=
 =?us-ascii?Q?SHbtmkEk9XIzaSdbybFSGkYavoiUuHMgb1lUb5GF?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257828CD0C0CE680B14D27CFC509BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c108473-9a8d-4303-06f6-08da9dfc7d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 07:14:58.9984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: astCJUM9H7eSIehonbRbowpbkBsHimH6w7z2GgLdG2iaGCdBSONUXUZjDA/t7sKvHlx1LNeswrAPM0Ur9Mkoag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

--_000_BN9PR12MB5257828CD0C0CE680B14D27CFC509BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Alex,

Sienna cichlid rlc firmware binary needs to be updated to match with the ke=
rnel change.

I shall add this comment to commit description.

Regards,
Hawking

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Saturday, September 24, 2022 05:36
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Gao, Likun <Likun.Gao@amd.com>
Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_=
microcode


[Public]

This set seems to break RLC firmware loading on sienna cichlid.

Alex
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, September 15, 2022 1:01 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Gao, Li=
kun <Likun.Gao@amd.com<mailto:Likun.Gao@amd.com>>; Deucher, Alexander <Alex=
ander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_micr=
ocode

switch to common helper to initialize rlc firmware
for gfx10

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@am=
d.com>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 191 +------------------------
 1 file changed, 4 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 26ec04fd313b..423b1b6d31b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3943,56 +3943,6 @@ static void gfx_v10_0_check_fw_write_wait(struct amd=
gpu_device *adev)
                 DRM_WARN_ONCE("CP firmware version too old, please update!=
");
 }

-
-static void gfx_v10_0_init_rlc_ext_microcode(struct amdgpu_device *adev)
-{
-       const struct rlc_firmware_header_v2_1 *rlc_hdr;
-
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc_srlc_fw_version =3D le32_to_cpu(rlc_hdr->save_restore=
_list_cntl_ucode_ver);
-       adev->gfx.rlc_srlc_feature_version =3D le32_to_cpu(rlc_hdr->save_re=
store_list_cntl_feature_ver);
-       adev->gfx.rlc.save_restore_list_cntl_size_bytes =3D le32_to_cpu(rlc=
_hdr->save_restore_list_cntl_size_bytes);
-       adev->gfx.rlc.save_restore_list_cntl =3D (u8 *)rlc_hdr + le32_to_cp=
u(rlc_hdr->save_restore_list_cntl_offset_bytes);
-       adev->gfx.rlc_srlg_fw_version =3D le32_to_cpu(rlc_hdr->save_restore=
_list_gpm_ucode_ver);
-       adev->gfx.rlc_srlg_feature_version =3D le32_to_cpu(rlc_hdr->save_re=
store_list_gpm_feature_ver);
-       adev->gfx.rlc.save_restore_list_gpm_size_bytes =3D le32_to_cpu(rlc_=
hdr->save_restore_list_gpm_size_bytes);
-       adev->gfx.rlc.save_restore_list_gpm =3D (u8 *)rlc_hdr + le32_to_cpu=
(rlc_hdr->save_restore_list_gpm_offset_bytes);
-       adev->gfx.rlc_srls_fw_version =3D le32_to_cpu(rlc_hdr->save_restore=
_list_srm_ucode_ver);
-       adev->gfx.rlc_srls_feature_version =3D le32_to_cpu(rlc_hdr->save_re=
store_list_srm_feature_ver);
-       adev->gfx.rlc.save_restore_list_srm_size_bytes =3D le32_to_cpu(rlc_=
hdr->save_restore_list_srm_size_bytes);
-       adev->gfx.rlc.save_restore_list_srm =3D (u8 *)rlc_hdr + le32_to_cpu=
(rlc_hdr->save_restore_list_srm_offset_bytes);
-       adev->gfx.rlc.reg_list_format_direct_reg_list_length =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_lis=
t_length);
-}
-
-static void gfx_v10_0_init_rlc_iram_dram_microcode(struct amdgpu_device *a=
dev)
-{
-       const struct rlc_firmware_header_v2_2 *rlc_hdr;
-
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc.rlc_iram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_iram_ucode_size_bytes);
-       adev->gfx.rlc.rlc_iram_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hd=
r->rlc_iram_ucode_offset_bytes);
-       adev->gfx.rlc.rlc_dram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_dram_ucode_size_bytes);
-       adev->gfx.rlc.rlc_dram_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hd=
r->rlc_dram_ucode_offset_bytes);
-}
-
-static void gfx_v10_0_init_tap_delays_microcode(struct amdgpu_device *adev=
)
-{
-       const struct rlc_firmware_header_v2_4 *rlc_hdr;
-
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_4 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc.global_tap_delays_ucode_size_bytes =3D le32_to_cpu(rl=
c_hdr->global_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.global_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_c=
pu(rlc_hdr->global_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se0_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se0_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se0_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se0_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se1_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se1_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se1_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se1_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se2_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se2_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se2_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se2_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se3_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se3_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se3_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se3_tap_delays_ucode_offset_bytes);
-}
-
 static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_device *ad=
ev)
 {
         bool ret =3D false;
@@ -4032,8 +3982,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)
         const struct common_firmware_header *header =3D NULL;
         const struct gfx_firmware_header_v1_0 *cp_hdr;
         const struct rlc_firmware_header_v2_0 *rlc_hdr;
-       unsigned int *tmp =3D NULL;
-       unsigned int i =3D 0;
         uint16_t version_major;
         uint16_t version_minor;

@@ -4123,59 +4071,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)
                 if (err)
                         goto out;
                 err =3D amdgpu_ucode_validate(adev->gfx.rlc_fw);
+               if (err)
+                       goto out;
                 rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev-=
>gfx.rlc_fw->data;
                 version_major =3D le16_to_cpu(rlc_hdr->header.header_versi=
on_major);
                 version_minor =3D le16_to_cpu(rlc_hdr->header.header_versi=
on_minor);
-
-               adev->gfx.rlc_fw_version =3D le32_to_cpu(rlc_hdr->header.uc=
ode_version);
-               adev->gfx.rlc_feature_version =3D le32_to_cpu(rlc_hdr->ucod=
e_feature_version);
-               adev->gfx.rlc.save_and_restore_offset =3D
-                       le32_to_cpu(rlc_hdr->save_and_restore_offset);
-               adev->gfx.rlc.clear_state_descriptor_offset =3D
-                       le32_to_cpu(rlc_hdr->clear_state_descriptor_offset)=
;
-               adev->gfx.rlc.avail_scratch_ram_locations =3D
-                       le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
-               adev->gfx.rlc.reg_restore_list_size =3D
-                       le32_to_cpu(rlc_hdr->reg_restore_list_size);
-               adev->gfx.rlc.reg_list_format_start =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_start);
-               adev->gfx.rlc.reg_list_format_separate_start =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_separate_start=
);
-               adev->gfx.rlc.starting_offsets_start =3D
-                       le32_to_cpu(rlc_hdr->starting_offsets_start);
-               adev->gfx.rlc.reg_list_format_size_bytes =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
-               adev->gfx.rlc.reg_list_size_bytes =3D
-                       le32_to_cpu(rlc_hdr->reg_list_size_bytes);
-               adev->gfx.rlc.register_list_format =3D
-                       kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
-                                       adev->gfx.rlc.reg_list_size_bytes, =
GFP_KERNEL);
-               if (!adev->gfx.rlc.register_list_format) {
-                       err =3D -ENOMEM;
+               err =3D amdgpu_gfx_rlc_init_microcode(adev, version_major, =
version_minor);
+               if (err)
                         goto out;
-               }
-
-               tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +
-                                                          le32_to_cpu(rlc_=
hdr->reg_list_format_array_offset_bytes));
-               for (i =3D 0 ; i < (rlc_hdr->reg_list_format_size_bytes >> =
2); i++)
-                       adev->gfx.rlc.register_list_format[i] =3D le32_to_c=
pu(tmp[i]);
-
-               adev->gfx.rlc.register_restore =3D adev->gfx.rlc.register_l=
ist_format + i;
-
-               tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +
-                                                          le32_to_cpu(rlc_=
hdr->reg_list_array_offset_bytes));
-               for (i =3D 0 ; i < (rlc_hdr->reg_list_size_bytes >> 2); i++=
)
-                       adev->gfx.rlc.register_restore[i] =3D le32_to_cpu(t=
mp[i]);
-
-               if (version_major =3D=3D 2) {
-                       if (version_minor >=3D 1)
-                               gfx_v10_0_init_rlc_ext_microcode(adev);
-                       if (version_minor >=3D 2)
-                               gfx_v10_0_init_rlc_iram_dram_microcode(adev=
);
-                       if (version_minor =3D=3D 4) {
-                               gfx_v10_0_init_tap_delays_microcode(adev);
-                       }
-               }
         }

         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", chip_nam=
e, wks);
@@ -4228,92 +4131,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_de=
vice *adev)
                 adev->firmware.fw_size +=3D
                         ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_=
SIZE);

-               info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-               info->ucode_id =3D AMDGPU_UCODE_ID_RLC_G;
-               info->fw =3D adev->gfx.rlc_fw;
-               if (info->fw) {
-                       header =3D (const struct common_firmware_header *)i=
nfo->fw->data;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(le32_to_cpu(header->ucode_size_bytes)=
, PAGE_SIZE);
-               }
-               if (adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
-                   adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
-                   adev->gfx.rlc.save_restore_list_srm_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
RESTORE_LIST_CNTL];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_CNTL;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.save_restore_list_cntl_=
size_bytes, PAGE_SIZE);
-
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
RESTORE_LIST_GPM_MEM];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_GPM_MEM;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.save_restore_list_gpm_s=
ize_bytes, PAGE_SIZE);
-
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
RESTORE_LIST_SRM_MEM];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_SRM_MEM;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.save_restore_list_srm_s=
ize_bytes, PAGE_SIZE);
-
-                       if (adev->gfx.rlc.rlc_iram_ucode_size_bytes &&
-                           adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
-                               info =3D &adev->firmware.ucode[AMDGPU_UCODE=
_ID_RLC_IRAM];
-                               info->ucode_id =3D AMDGPU_UCODE_ID_RLC_IRAM=
;
-                               info->fw =3D adev->gfx.rlc_fw;
-                               adev->firmware.fw_size +=3D
-                                       ALIGN(adev->gfx.rlc.rlc_iram_ucode_=
size_bytes, PAGE_SIZE);
-
-                               info =3D &adev->firmware.ucode[AMDGPU_UCODE=
_ID_RLC_DRAM];
-                               info->ucode_id =3D AMDGPU_UCODE_ID_RLC_DRAM=
;
-                               info->fw =3D adev->gfx.rlc_fw;
-                               adev->firmware.fw_size +=3D
-                                       ALIGN(adev->gfx.rlc.rlc_dram_ucode_=
size_bytes, PAGE_SIZE);
-                       }
-
-               }
-
-               if (adev->gfx.rlc.global_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOB=
AL_TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_GLOBAL_TAP_DELAY=
S;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.global_tap_delays_ucode=
_size_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se0_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se1_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se2_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se3_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
                 info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
                 info->ucode_id =3D AMDGPU_UCODE_ID_CP_MEC1;
                 info->fw =3D adev->gfx.mec_fw;
--
2.17.1

--_000_BN9PR12MB5257828CD0C0CE680B14D27CFC509BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sienna cichlid rlc firmware binary needs to be updat=
ed to match with the kernel change.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I shall add this comment to commit description.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Saturday, September 24, 2022 05:36<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rl=
c_init_microcode<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">This se=
t seems to break RLC firmware loading on sienna cichlid.<o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@=
amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, September 15, 2022 1:01 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Gao, Likun &lt;<a href=3D"mailto:Likun.=
Gao@amd.com">Likun.Gao@amd.com</a>&gt;; Deucher, Alexander
 &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com=
</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_in=
it_microcode</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">switch to common help=
er to initialize rlc firmware<br>
for gfx10<br>
<br>
Signed-off-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">H=
awking.Zhang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 191 +-----------------------=
-<br>
&nbsp;1 file changed, 4 insertions(+), 187 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 26ec04fd313b..423b1b6d31b6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3943,56 +3943,6 @@ static void gfx_v10_0_check_fw_write_wait(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN_ONCE(&quot;CP firmware version too old, plea=
se update!&quot;);<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
-static void gfx_v10_0_init_rlc_ext_microcode(struct amdgpu_device *adev)<b=
r>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_1=
 *rlc_hdr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_1 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlc_fw_version =3D =
le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_ucode_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlc_feature_version=
 =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_feature_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_cn=
tl_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_size_bytes=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_cn=
tl =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_offse=
t_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlg_fw_version =3D =
le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_ucode_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlg_feature_version=
 =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_feature_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_gp=
m_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_size_bytes);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_gp=
m =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_offset_=
bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srls_fw_version =3D =
le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_ucode_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srls_feature_version=
 =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_feature_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_sr=
m_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_size_bytes);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_sr=
m =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_offset_=
bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_dire=
ct_reg_list_length =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_direct_reg_list_length);<br>
-}<br>
-<br>
-static void gfx_v10_0_init_rlc_iram_dram_microcode(struct amdgpu_device *a=
dev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_2=
 *rlc_hdr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_2 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_iram_ucode_size_=
bytes =3D le32_to_cpu(rlc_hdr-&gt;rlc_iram_ucode_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_iram_ucode =3D (=
u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;rlc_iram_ucode_offset_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode_size_=
bytes =3D le32_to_cpu(rlc_hdr-&gt;rlc_dram_ucode_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode =3D (=
u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;rlc_dram_ucode_offset_bytes);<br>
-}<br>
-<br>
-static void gfx_v10_0_init_tap_delays_microcode(struct amdgpu_device *adev=
)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_4=
 *rlc_hdr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_4 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.global_tap_delays_uc=
ode_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;global_tap_delays_ucode_size_byt=
es);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.global_tap_delays_uc=
ode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;global_tap_delays_ucode_off=
set_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se0_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se0_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se0_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se0_tap_delays_ucode_offset_by=
tes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se1_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se1_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se1_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se1_tap_delays_ucode_offset_by=
tes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se2_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se2_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se2_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se2_tap_delays_ucode_offset_by=
tes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se3_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se3_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se3_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se3_tap_delays_ucode_offset_by=
tes);<br>
-}<br>
-<br>
&nbsp;static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_devic=
e *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
@@ -4032,8 +3982,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_=
header_v1_0 *cp_hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_=
header_v2_0 *rlc_hdr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *tmp =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_minor;<br=
>
&nbsp;<br>
@@ -4123,59 +4071,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_ucode_validate(adev-&gt;gfx.rlc_fw);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)=
adev-&gt;gfx.rlc_fw-&gt;data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_cpu(rlc_hdr-&gt;header.head=
er_version_major);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_cpu(rlc_hdr-&gt;header.head=
er_version_minor);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc_fw_version =3D le32_to_cpu(rlc_hdr-&gt;header.u=
code_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc_feature_version =3D le32_to_cpu(rlc_hdr-&gt;uco=
de_feature_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.save_and_restore_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;save_and_restore_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.clear_state_descriptor_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;clear_state_descriptor_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.avail_scratch_ram_locations =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;avail_scratch_ram_locations);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_restore_list_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_restore_list_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_separate_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_separate_start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.starting_offsets_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;starting_offsets_start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_size_bytes =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_size_bytes =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.register_list_format =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kmalloc(adev-&gt=
;gfx.rlc.reg_list_format_size_bytes +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gfx.rlc.reg_list_size_bytes, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;gfx.rlc.register_list_format) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D amdgpu_gfx_rlc_init_microcode(adev, version_major, versi=
on_minor);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_hdr-&gt;reg_lis=
t_format_array_offset_bytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0 ; i &lt; (rlc_hdr-&gt;reg_list_format_size_bytes &g=
t;&gt; 2); i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc=
.register_list_format[i] =3D le32_to_cpu(tmp[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.register_restore =3D adev-&gt;gfx.rlc.register_=
list_format + i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_hdr-&gt;reg_lis=
t_array_offset_bytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0 ; i &lt; (rlc_hdr-&gt;reg_list_size_bytes &gt;&gt; =
2); i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc=
.register_restore[i] =3D le32_to_cpu(tmp[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (version_major =3D=3D 2) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_mino=
r &gt;=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_rlc_ext_microcode(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_mino=
r &gt;=3D 2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_rlc_iram_dram_microcode(adev=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_mino=
r =3D=3D 4) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_tap_delays_microcode(adev);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(f=
w_name), &quot;amdgpu/%s_mec%s.bin&quot;, chip_name, wks);<br>
@@ -4228,92 +4131,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN=
(le32_to_cpu(header-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_G];<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_RLC_G;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (info-&gt;fw) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header =3D (cons=
t struct common_firmware_header *)info-&gt;fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(header-&gt;ucode_size_byt=
es), PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.save_restore_list_cntl_size_bytes &amp;&amp=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_gpm_s=
ize_bytes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_srm_s=
ize_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.save_restore_list_cn=
tl_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.save_restore_list_gp=
m_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.save_restore_list_sr=
m_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx=
.rlc.rlc_iram_ucode_size_bytes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGP=
U_UCODE_ID_RLC_IRAM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_RLC_I=
RAM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ALIGN(adev-&gt;gfx.rlc.rlc_iram_ucode_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGP=
U_UCODE_ID_RLC_DRAM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_RLC_D=
RAM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ALIGN(adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.global_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.global_tap_delays_uc=
ode_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se0_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE0_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se0_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se1_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE1_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se1_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se2_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE2_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se2_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se3_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE3_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se3_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGPU_UCODE_ID=
_CP_MEC1];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_CP_MEC1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.mec_fw;<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257828CD0C0CE680B14D27CFC509BN9PR12MB5257namp_--
