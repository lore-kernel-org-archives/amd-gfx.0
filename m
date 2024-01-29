Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029EDC47DA9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 09:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E711127CD;
	Mon, 29 Jan 2024 09:31:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3051127C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 09:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFM/+2UbzQT7ABXjkU6adBf5/M5iN4ZK+wgAxGVblutOSWuBgtXb+P3L5NW1tWeEyghPqMBAzdNUW6mbYyrKsa4apS7uZjnnqQmh6EyZVfJB8rh046Rup0gv9icY5KG91sFtVT2z7bRgOngsd6k5Pm4uZFacIikZ5x8/HmNj57YXvFHakqcFgIbwkxJvHf4XxEGmh0DBm0nEKnB554D34ZKkwgS+JtoNal+2KLXP+RYa8jpJF1ERl44bR8l2DXfukC3JRxXRSV0S3v72YXkS685DA+PyDkOKJTPCBfY9ujq5zWmvTUXKkN7JD5bXFHBW7I4kR3V/M2452wK1AaMslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WabR18187nOfaKqXoae/PcnXb0zFSNV0CaYiWKLbh/g=;
 b=JwPxwq+2mxH3jGTsDHnJJ3yVoPPlKo+xngKOGaQWG83axatkB+02ciMFQfUskB7SqzvmZwp9jM+UAKkRtrfL+gF07iAu9hQZ7hvk+4CzxRIPH1pBcI8GNDPQfN60OJixWo0SqK+/fbsYHH5hPFLY+XqU/pYNi6tXK3LG8WwInxEXEi4igL2XI+Mqdm/Ef65a1K0m5ESbIS7JL8SlHN0DjvnnaTFNqbU2KA+R5S22dGIzZQIKqQXaiXzsNiU9FFApufNxLAVq/xVnMzN52y76Rydc1pFojxgjfV4C12DXWW7+XDicYoE+1nnzvSpZFnqCIPSsfsWhzqfBbFv6/VpyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WabR18187nOfaKqXoae/PcnXb0zFSNV0CaYiWKLbh/g=;
 b=jzwA695NwMXFvdvkF6q9vxvECzBzvGr/6pebSdBeSgw6CULs8PpYmoo3Jme3Y10f/GjLl8zx3VhUsv+babp0hAjS4+ajzdIFzL58j4UMHUJezNXRliTm1epBNCq03NT7WedmHAwM7ho2ulY4fIVDbtEnGJU+42h7OVF6baA3xVg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 09:31:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:31:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use helper macro HW_ERR instead of Hardware
 error string
Thread-Topic: [PATCH] drm/amdgpu: use helper macro HW_ERR instead of Hardware
 error string
Thread-Index: AQHaUpMDHIKB/MKRek+9B9PMBVxh2bDwhrTQ
Date: Mon, 29 Jan 2024 09:31:51 +0000
Message-ID: <BN9PR12MB5257568E8E2489667E507020FC7E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240129091000.2068752-1-kevinyang.wang@amd.com>
In-Reply-To: <20240129091000.2068752-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=485be92b-9947-460b-950b-66d274efeea2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T09:31:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7452:EE_
x-ms-office365-filtering-correlation-id: 1ae1690f-8e67-4c7c-20c7-08dc20ad200a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwaZlbpx9Ij7KbdLjGlmOfA8M1P5wZFAMSqCm5gEcdor/9G8F6XnOeeMiKHlc5p4mybiHQcx5PH+PZ/6XJgD0V3UuPwwXof4q+Ne6OcdHso5F3TiLRJU49Ovh+GoRzHVp20G9EqcqKDZy1/DeBptRP7j6dxn8VjcBz9S9GKqT1ho8e+eO5m53XV5MprUROZTluYpM0spu9deiAL7CiVu9lYgDmtNytdnZXaNOK0sJTBs0hZfnhcRUbeWhMpLHqd83iFCedd5UGurIy1pXXUo4NCYJSir9Lq967J+nlt0HYKwXVI8T6vowWI21UH0GokF9iKiEQJskoNz9XFegAD5GYEs1XdM0YEwJIETj6K82oMg5kiDUlDiLpUznwN1fmGivwZNPWXnhXVodTcE9WThuoYtFnVIH4UU/SAbsZWyhyMj+P/cgvrrZAhuzA8u4JlKxlLg02F+HrPoYJHaA9KnNdghICQIeseGgndmtJP4iGXM2AYjIXjPnu9rJo9pgDEdByvh8gSrZvShcWo0MgnEbUFaiDG8w+AcURrz9hPXo6S4ilsbKpQPB4jcWflQdYaRVsLTx0oj0g5x5tZuSFp7nEkczNYm2csteHuMpl/cNDoFjKjL1PLSEYfn/sREeZZN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(83380400001)(33656002)(86362001)(38070700009)(122000001)(26005)(38100700002)(9686003)(53546011)(6506007)(7696005)(2906002)(478600001)(41300700001)(110136005)(76116006)(316002)(71200400001)(66556008)(66476007)(66446008)(64756008)(66946007)(8936002)(4326008)(5660300002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dM+ReoQgLo/GGU87SsvUSFjQcvrckLw/mdC52smyVgLf6gzoNFC0YGSXJDUl?=
 =?us-ascii?Q?cBk0P0CoSGdo4tPUDOgycCp+0sKC3j6q5e9JK4h4vxqOf4yHkk438R75LL5X?=
 =?us-ascii?Q?2t087IeRZQkw1e36qKoOoSkX/OBqk3i3XNdoQDENhgLNJelRrKi1yo+IgB6l?=
 =?us-ascii?Q?TdZh2GLbT5rVYAgVyVo/LZ7L2RqxVDLWXjmn0c9bZ9QhzTbPi+qvoq8673Nf?=
 =?us-ascii?Q?HbRtqDNArjc85OEwP0nlKLn3ZJGswwhPChb8k3KItWlD9AP++pfdHFZRvOz3?=
 =?us-ascii?Q?lK9GO4ekf2gPfogsBNCIdu82j9l+x8WZruqS9VPnUatw5O+HQHQdsS9Gc2+B?=
 =?us-ascii?Q?wfLCWyz/vB30OwH8vGdtGHEZa0nVHe/FBWE6Yq3ul2iy7ueC4k5H5i4Urmle?=
 =?us-ascii?Q?13fXX5u1hi+eQ8YaS6WqCCH0nYhjanv74I5xgJ9F8ikdf3CjuC9/r06fDRCP?=
 =?us-ascii?Q?1iopoF/kSjoif2oTITnEzuRBJapocHIYVP4UikfdR8vul//QO7KtPqEZUsS0?=
 =?us-ascii?Q?U2MpPxXCUklLt8IsdYexZlkEYXL0y8d+F6MbEDUFm/dPiibOWaR1HgPzpVoy?=
 =?us-ascii?Q?W683/v46AI2ewUGLH13+E6fZryllRC0kFZMcV+Ry/XRxzRFHWnVDsT4BfFC2?=
 =?us-ascii?Q?+I5cZceR1PQ0bOLy8ZB4ukFi1HahrbUUyhuvQMND0J1ZTH526pAHWD6YAqh+?=
 =?us-ascii?Q?diME/VR5Bkr23xUZIxxpfkna/0q0KrlAXTxUkFQeMAvqdIV0dxM5px4AihgF?=
 =?us-ascii?Q?hsxHncLay0GA68uBOqUjdryhCopqL3c1HKo3eMHLqMO7Cowzz9js2z0bSFy3?=
 =?us-ascii?Q?6xNDiKn0XFSYNO7M4ul5DKqOxLAaEKWeoN+SQpFDt0TgGkDT4X+d9Xv0c0mR?=
 =?us-ascii?Q?1qoWymBKVKmJh9jQjBkLPrlMbhL6wM36FHbjNpNcBHv07Mnnrq4SgMc/g8tL?=
 =?us-ascii?Q?IepYo7c5/5s7gw+YhaIxgqHBfWxLKpKGHrUBOEi8lfXwMOCzw9+dlIwQ0AXW?=
 =?us-ascii?Q?dbxVjgxaDXI1B15e+qIsd6S+HHEMBLKMpfFgMyN1k5k1ACEW+daplKt/r2+N?=
 =?us-ascii?Q?1w6jvR5CrpdJrvqfA2OPtG7WxSyuU2u0g4QVKwL4kJGlnAdI+yK7mOCpAtCJ?=
 =?us-ascii?Q?9ahBQJ6LHsCKrAfy/qh2f2eXUVM3VJvZ2swrSWWFktqk1ThWIM3M5ZiSguxT?=
 =?us-ascii?Q?bS9QO62pLV+01qsjJLmMWhkMvU+JFBUNDvCLc7aIu9qWFIM513AecvWtvu5m?=
 =?us-ascii?Q?tpoVmAZfnBhfrydzfDGSr3C4+sweykCe66/xxAaI+0Bt6kYoo7xlXwZBsPbA?=
 =?us-ascii?Q?U+g8uguUqL8sPyzUczdUCTHr8iaQwl/047XzXOYlsMWbtxqWcM7QLNEweEv/?=
 =?us-ascii?Q?Df4lZYY6nVGG5gWhmcAncvE/KQWDZaMHWdzu33op8pgxT+PW+UGvWAUhyLPL?=
 =?us-ascii?Q?iETbVkpw075bQ/6FczfpfJQxda8rKAOw8h7eXOvfjcgEOdySjNYpgfAPd8sg?=
 =?us-ascii?Q?xQegtSo149ftVMPsrnIDyvUO/lMndHgzWPbXEucWZaUQ7pPUMYKn05boZwne?=
 =?us-ascii?Q?Va1jeuVyvYvBh9zHq9I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae1690f-8e67-4c7c-20c7-08dc20ad200a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 09:31:51.8592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KF+JnEnnKtOAvkQ8nW6Lo6P9h8F1Dp2PGbaHlIyJH1pBkO+iTJF9wBrL/AGFwvi9HUHBT9gpdNKIh/BPXk/dBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, January 29, 2024 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: use helper macro HW_ERR instead of Hardware er=
ror string

use helper macro HW_ERR to instead of Hardwareare error string.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  4 ++--  drivers/gpu/drm/amd/amd=
gpu/amdgpu_mca.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index d7d2ec3ce399..be525cf3a182 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -120,10 +120,10 @@ static void aca_smu_bank_dump(struct amdgpu_device *a=
dev, int idx, int total, st  {
        int i;

-       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events
+logged\n");
        /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
        for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
-               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+               dev_info(adev->dev, HW_ERR "ACA[%02d/%02d].%s=3D0x%016llx\n=
",
                         idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 6452c09f22c6..24ad4b97177b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -212,16 +212,16 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_devic=
e *adev, bool enable)

 static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int i=
dx, struct mca_bank_entry *entry)  {
-       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
-       dev_info(adev->dev, "[Hardware error] aca entry[%02d].STATUS=3D0x%0=
16llx\n",
+       dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events l=
ogged\n");
+       dev_info(adev->dev, HW_ERR "aca entry[%02d].STATUS=3D0x%016llx\n",
                 idx, entry->regs[MCA_REG_IDX_STATUS]);
-       dev_info(adev->dev, "[Hardware error] aca entry[%02d].ADDR=3D0x%016=
llx\n",
+       dev_info(adev->dev, HW_ERR "aca entry[%02d].ADDR=3D0x%016llx\n",
                 idx, entry->regs[MCA_REG_IDX_ADDR]);
-       dev_info(adev->dev, "[Hardware error] aca entry[%02d].MISC0=3D0x%01=
6llx\n",
+       dev_info(adev->dev, HW_ERR "aca entry[%02d].MISC0=3D0x%016llx\n",
                 idx, entry->regs[MCA_REG_IDX_MISC0]);
-       dev_info(adev->dev, "[Hardware error] aca entry[%02d].IPID=3D0x%016=
llx\n",
+       dev_info(adev->dev, HW_ERR "aca entry[%02d].IPID=3D0x%016llx\n",
                 idx, entry->regs[MCA_REG_IDX_IPID]);
-       dev_info(adev->dev, "[Hardware error] aca entry[%02d].SYND=3D0x%016=
llx\n",
+       dev_info(adev->dev, HW_ERR "aca entry[%02d].SYND=3D0x%016llx\n",
                 idx, entry->regs[MCA_REG_IDX_SYND]);  }

--
2.34.1

