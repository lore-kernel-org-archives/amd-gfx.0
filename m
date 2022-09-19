Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9363FECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 05:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E4210E131;
	Mon, 19 Sep 2022 05:25:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8C610E131
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 05:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqxSZaGAV9h9oR+01ytPDT3TwnwJLRW5nYGAh60HW6UHzpdOZcoBBTWnL4BLpY4VEqnqZoL9zZxPKP2Xtas13qKvurhIyx7sKdwGnQ8x9mv5VsHnq3PiABfqaI+1pRgz9aSNgVMWHactPkExWpwqiXNeWENxEk/jYYSeizDAbq1vgxhgqvERQMxODwsQ7TK6oZRKDQXBxAyZo06aIov+lP8j62AbQ02NIbc2sf+2/OmU0rYbJGA4dtLsKa9RoMu1taWmDq6f+KnsrAXn9X4+Rh/ZnbjQMaFf7aCMmiYI3X3mAX9aaoye5ZMSUWn3aquxW1nbrPFvMRow48SjaW/0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkLIiB1OTYD8EOa/zDI8zJhRfWMM+gMSUDAMtWMmDTw=;
 b=UpJusJw4BBV40DAB9G8assjaSNpyHMfwvt30Ez5tZa4TKaBeHx+GMpoZuYmBtEYTY33Dt7Xoe/5pUWsuA496TkgR/bhvIqIaw208M8fVr+NXhb9frb5AN9ElDzODeU0HhXdK9kPdcafUZzDpNFMBWMQeCMOGEBJlHlljUyhtOVp+MYnIoNbngwDdGcy5ZUxtZnsY1C1bh0gGKJJcT/2nl2b1lJcHXtwmG+aFmlvOufx+q5Dl9FUsgrFOiNl1IF9SEkYIANfzcVra/4ZuKTNVdTR1bphqFjXulO7jpc1N7KzbZiXZkof5ynTicLTBniDkMTYP5Pr6/IpRqKxs6ocftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkLIiB1OTYD8EOa/zDI8zJhRfWMM+gMSUDAMtWMmDTw=;
 b=ZVsjlzHQR4hJL6esm6uKzh1wGAJRJQ3PLgFQrhe78VFpqDavMACtWc+BF4j6wZ0661gXmqwaGO8zCPiItf3VUVgBt76C/Emdmv8ui/uUW3xMiNaCvqU4cffz1UH43vZxK1WR2P1vcxh9gQcYYUuDfTS9GIka9NQJC/GnijpjTs4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 05:25:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::24cf:abf5:436a:e1f3]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::24cf:abf5:436a:e1f3%7]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 05:25:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 07/10] drm/amdgpu/gfx8: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Topic: [PATCH 07/10] drm/amdgpu/gfx8: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Index: AQHYySTv0iCiTNpQ+0mAN5YcG0yjKa3mNZ7g
Date: Mon, 19 Sep 2022 05:25:28 +0000
Message-ID: <PH7PR12MB599773434B137AC9F487C5C0824D9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-8-Hawking.Zhang@amd.com>
In-Reply-To: <20220915170135.23060-8-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57cc5c27-4a65-4bcf-b5d3-bbb0635a17d2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-19T04:54:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB6396:EE_
x-ms-office365-filtering-correlation-id: 684275db-c152-41a8-d572-08da99ff5d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WC/W/7k+bT3vEnLpjX1BtyDVSLvYV50tMkyQQuKZ6+TVmPhWpTKzKQ1D2slSkDJtHSsYcoauCWAGoGExFGhqzobN3QDJT/jmZ1H+obh7g5oHAuiT4JlAja4zY50PO0rA8lAP76SLeH4nDXo5OQS1HTHYetVlTHbYwecw2a10YFwX8xnVrWnmi7OapyZBcG40UZGYBnSZiX7Dj0/T3MxUBQhJU2Efe2TQeMJasIN042dp94vs5nx7CCT44/YfOyQwAgoSGUwyHlvfQa4yR6hMxbRzNtEcpAgQnwv0MuIiWSNK51eooXzxXfGNMIwSjrifLYocbBhlDl28g9mQsNqqmfZsm/FkJ9pHO/bPOxSSforMZW/OeIv4nwc0E5WV7EMQ05d/Zvqnhm88TinidTjjlRVzV57v3BmmFjXtxSqZ+zYugXo55zjEkmBbgUpxhN/Rdllkuhp6XMQh16Q1YgtptMnNz5QZzHJMWiF8PtSy+JSeHUAkSENlI9ItchTmPVu71nJeN36jsxTZP+vzvCtwopVclQeqwQiuvD6vaFOC0ElHfux8fOHt9lOR7zmc2ZldI0dCO6xSUuHEPAmJ02H7hN8ZvCGRPsx1aP8P8e2NaoFDKUVEE9qN2+At/Gj9s0q/2bFGyYDiXS1x74v6RK4pPww6yrv//6PyOTbeQBfjV1BiZ9k2Bx6zxhAaxfQMjF54cLYyA3wejW/lGXmDqirZW+KccMo7gSkIx/nIGd4sstWO+4j1BpyNLH88q3TeYznYwVXa4TCfo4gFrSyU3+gqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199015)(55016003)(478600001)(33656002)(66476007)(38100700002)(66556008)(52536014)(64756008)(4326008)(38070700005)(8676002)(8936002)(66446008)(316002)(5660300002)(66946007)(76116006)(110136005)(6636002)(83380400001)(122000001)(9686003)(186003)(41300700001)(71200400001)(2906002)(7696005)(6506007)(86362001)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?78AItWsZbQH7aenYqzDDo5C5Deg4UgmwxKYNyQoSvxmU+g1rmVeSU+Md2ErW?=
 =?us-ascii?Q?D91R4PA1RLC9naiaJtHGWGxxcmW6JVcXRzH9OkHThqzBM9HXvJ+ZBpFRCQGx?=
 =?us-ascii?Q?wuLI+4S+FSXwOjlZntjht7Jp+DjFgUg7zGUh1F1Ad1zBN2/aQjb+KzDqauAn?=
 =?us-ascii?Q?LpfWH5XDG3kQx4U6YBiSM6yeazAlB6Txo7eWeOfY3gqfGtmw+N7DIWMU4P9D?=
 =?us-ascii?Q?ULHVAOHQA0UunZLSZ8+d/rhvxxurHnPehA8mk0ZIkzTTKv0UAVgklzjAR5c/?=
 =?us-ascii?Q?rEEMumYWExx//fBboKAdCLYdFL6xRhh4+eG1pLELLxkjGJZPAG4ZBP/QBWpF?=
 =?us-ascii?Q?sglXXAI3M2yquRpILWlupyN1kdRqmjzgq0Wg2IvfgrtuuUdnBRqW/HVrTbak?=
 =?us-ascii?Q?mCspMzRePRlRSmDbiSAbOMlVJcsbLaSuKLIVZkkW1sXR67IzGCdWdYcEm4Ev?=
 =?us-ascii?Q?nP7Z6zY6NFtUBUKbLxKf25OcnQwTQSYIU9zosKo1VXqB2qMwKy33uxEyBhtd?=
 =?us-ascii?Q?ZS+iWbKvh/jOrA5aMwjyWonpKKZwwBJXKU7RcWxPQ67ukMnm2lDmueCwY+65?=
 =?us-ascii?Q?ZcfoDdu1w9AuqwE8Vfu/niOaFjdO6vKfuNF6bpRjzL2uJxcLdchUP3sk+7Ve?=
 =?us-ascii?Q?j7vQQSUC2dFV2AQKB9VpeBAwIkoPDian1NNemJ13Q3ILBgb4rQULiBdlCA+q?=
 =?us-ascii?Q?mcxlEoJnLqVyjSmRg4Xy4gTreGxqqezxX3tkYnvBKzHnHbSNuEwbBizm/F5L?=
 =?us-ascii?Q?TpPJ2WI2uhJYJLNtmAriggBXcFz5KQZOWFGEMPer0iUjeNjCxuM+Y1xwuBIj?=
 =?us-ascii?Q?4HjJZ/Op620N1FqpHNSqgj+i59jCsaOT9rieW9beqPH6GaP9u9MbH3W5NYRy?=
 =?us-ascii?Q?71uU7E+bpDOWCQui2N9Z7o898uRABcT4TBGPBuyp4TY6Q2NjnNeHZ+p1m5Tr?=
 =?us-ascii?Q?wwdCZmtbSLxYjfOT0P8Kwz9s9ehdbKNECG10T0Y0YwdK7W9WEzEkXEp6/KkB?=
 =?us-ascii?Q?umaPISO1K8fwp5/VQjDAnhAy7ZlJ/AIqy9wzI+nOk2x4whrMZKXF7+T5jeq1?=
 =?us-ascii?Q?EDNNha6G8ciV6M5gts8vYZwnusfYkZq2hiWPLWxcAsmasWuh8YHxprdXJSEx?=
 =?us-ascii?Q?P1rMpvZIixQkSLkCbCFCG6TQmEGaa2D2Vs0m13gYTJbKBHtO9vRVEJY4r+1a?=
 =?us-ascii?Q?Z5d2BpUQ1N9toqoYcgxMMO1ITpoAEkpVyxJHG9NXznrxWKTvD7Bq1cxCdeas?=
 =?us-ascii?Q?BWZZACMsWLCFcgh4LwqFYRoBH8XCPAffb3kvY/u0WEfsw99ITZ+roWpE6RRi?=
 =?us-ascii?Q?rv4NxStQbpWrH30qBZe1wJ+xJ0xgBStGBXiOW3RnWElzQGYzDnKWtf11EZIx?=
 =?us-ascii?Q?5gOBs01wAKp7RV3d9abvUUTjlYF1R9/1X2jl2DwYTtPkjKH9bbT7KxV94BGy?=
 =?us-ascii?Q?jNAx5pL6W7M849eap1EU/VlUNfBM1uWoeCmjTzl4xry0XNbB9pH2e7QLC6Ni?=
 =?us-ascii?Q?3Z5pJkYWhLuaOX5xrbi3uvhFOqUmJ7vbG5nZOaMGiQ7Uvr4bHnuWAzzev7X9?=
 =?us-ascii?Q?0Frfl8nTbu4ANwAwAfA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684275db-c152-41a8-d572-08da99ff5d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 05:25:28.5266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OTWel26wLeF54Jaz32ekk+huYyQBygILoUO9ZrkueRQ2gE7Ql3Fk5EL3ueKCx9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Friday, September 16, 2022 1:02 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 07/10] drm/amdgpu/gfx8: switch to amdgpu_gfx_rlc_init_micro=
code

switch to common helper to initialize rlc firmware for gfx8

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 60 +++++----------------------
 1 file changed, 11 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 606d0c873d71..09c63e2d4637 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -951,7 +951,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device=
 *adev)
        const struct common_firmware_header *header =3D NULL;
        const struct gfx_firmware_header_v1_0 *cp_hdr;
        const struct rlc_firmware_header_v2_0 *rlc_hdr;
-       unsigned int *tmp =3D NULL, i;
+       uint16_t version_major, version_minor;

        DRM_DEBUG("\n");

@@ -1064,49 +1064,18 @@ static int gfx_v8_0_init_microcode(struct amdgpu_de=
vice *adev)
        if (err)
                goto out;
        err =3D amdgpu_ucode_validate(adev->gfx.rlc_fw);
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc_fw_version =3D le32_to_cpu(rlc_hdr->header.ucode_vers=
ion);
-       adev->gfx.rlc_feature_version =3D le32_to_cpu(rlc_hdr->ucode_featur=
e_version);
-
-       adev->gfx.rlc.save_and_restore_offset =3D
-                       le32_to_cpu(rlc_hdr->save_and_restore_offset);
-       adev->gfx.rlc.clear_state_descriptor_offset =3D
-                       le32_to_cpu(rlc_hdr->clear_state_descriptor_offset)=
;
-       adev->gfx.rlc.avail_scratch_ram_locations =3D
-                       le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
-       adev->gfx.rlc.reg_restore_list_size =3D
-                       le32_to_cpu(rlc_hdr->reg_restore_list_size);
-       adev->gfx.rlc.reg_list_format_start =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_start);
-       adev->gfx.rlc.reg_list_format_separate_start =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_separate_start=
);
-       adev->gfx.rlc.starting_offsets_start =3D
-                       le32_to_cpu(rlc_hdr->starting_offsets_start);
-       adev->gfx.rlc.reg_list_format_size_bytes =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
-       adev->gfx.rlc.reg_list_size_bytes =3D
-                       le32_to_cpu(rlc_hdr->reg_list_size_bytes);
-
-       adev->gfx.rlc.register_list_format =3D
-                       kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
-                                       adev->gfx.rlc.reg_list_size_bytes, =
GFP_KERNEL);
-
-       if (!adev->gfx.rlc.register_list_format) {
-               err =3D -ENOMEM;
+       if (err)
                goto out;
+       rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_=
fw->data;
+       if (!rlc_hdr) {
+               dev_err(adev->dev, "invalid rlc fw data\n");
+               return -EINVAL;
        }

[Kevin]:
If variable of rlc_hdr is "NULL", the driver will get a data abort in amdgp=
u_ucode_validate() first, so I think the function "dev_err()" should never =
be called.
May be this error has been returned in previous position. (maybe in err =3D=
 request_firmware()).

Thanks.

Best Regards,
Kevin
-
-       tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +
-                       le32_to_cpu(rlc_hdr->reg_list_format_array_offset_b=
ytes));
-       for (i =3D 0 ; i < (adev->gfx.rlc.reg_list_format_size_bytes >> 2);=
 i++)
-               adev->gfx.rlc.register_list_format[i] =3D le32_to_cpu(tmp[i=
]);
-
-       adev->gfx.rlc.register_restore =3D adev->gfx.rlc.register_list_form=
at + i;
-
-       tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +
-                       le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-       for (i =3D 0 ; i < (adev->gfx.rlc.reg_list_size_bytes >> 2); i++)
-               adev->gfx.rlc.register_restore[i] =3D le32_to_cpu(tmp[i]);
+       version_major =3D le16_to_cpu(rlc_hdr->header.header_version_major)=
;
+       version_minor =3D le16_to_cpu(rlc_hdr->header.header_version_minor)=
;
+       err =3D amdgpu_gfx_rlc_init_microcode(adev, version_major, version_=
minor);
+       if (err)
+               goto out;

        if (adev->asic_type >=3D CHIP_POLARIS10 && adev->asic_type <=3D CHI=
P_POLARIS12) {
                snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", c=
hip_name); @@ -1178,13 +1147,6 @@ static int gfx_v8_0_init_microcode(struct=
 amdgpu_device *adev)
        adev->firmware.fw_size +=3D
                ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);

-       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_G;
-       info->fw =3D adev->gfx.rlc_fw;
-       header =3D (const struct common_firmware_header *)info->fw->data;
-       adev->firmware.fw_size +=3D
-               ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
-
        info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
        info->ucode_id =3D AMDGPU_UCODE_ID_CP_MEC1;
        info->fw =3D adev->gfx.mec_fw;
--
2.17.1

