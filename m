Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF32BCD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 07:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F53310E995;
	Tue, 23 Jun 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="il3bD/Mg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6D610E995
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 07:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbXF+EEFsPARM6U+OUHejG4il21YmKIrLq9nKUY8bCMnJzvu2zLb13VHXA3xy3OMHoRWQZdVOUILQOatRtXcjFgRMoBGvORY36AIrF+ulRxkmiTNgydsom9FlMgQXbN1jCAFAkeaY3CjTydx+O4EFqRRxmH5n91fOO475EdLLCJyBaI+kdeQrUSfNK0jpCbAcyTyBkNEv1H3QKMcKltaJhHTBsrqvv0yunIXYc7idOc9jPNr77Vz79IIcDOjYJE/kWM2SX/CAHzp5Ocr2h0d7y2X7l9gvNY81DEg1RFkGgKP2n1EcdpeU/umHTNwyBRf8UdEx8Bq+3/bHSSFsD6uJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJHA7iAysHc8RKx97Vzx2WRw979dcduQBKkl7ib2ewY=;
 b=t8UhxDJeyPyGJxWrfLttkzG2nRN8HxfJ0jp9fRZPYmw9NQOJpUIU6a1EQhUEClSXgL5SPuKQ8rWlPL18Hvs7njovFPmCnSCIjPXGet5chAAGtrAeUSDhJ7Uv1Pg7Sw4Kzb4Tug+fzIvd2J4iZOgqwCphUl9tY+whu8dnQOMWj9feenfhilZptyl+TcpmMRzMt2A2TpRIuYQD1H+QmHdgeMCvvac7CmnqmXnu9nDy9f2F+9yXcCJ0lv5+YMSSJ7bQa702wua8tDRSpa/P3C5ULaT1zwlL5mRG0lLSZTbtw/mhrWYIU3EuX45IHBX/XNupU62Oj/0befPO+7LXpZx0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJHA7iAysHc8RKx97Vzx2WRw979dcduQBKkl7ib2ewY=;
 b=il3bD/MgmZsMVy8lYQM4+P/zKBc9cG4fL1bALnNt5kn5Ad6fdd0dy1ss+UK3nsoxYEK1bD/+svIfOelrc2fcQxn4noHS0PeEO8+cJ0rzkCT1LSlrWoWmkvgDDiCM4NoMMaLzVloqKGzjhJVIiSFjan4PkJ71AsQHI/pXAaNSgvs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:24:29 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:24:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
Thread-Index: AQHdAlo+o7mTQfmSJk+P1y4cjFU9Q7ZLvZlg
Date: Tue, 23 Jun 2026 07:24:29 +0000
Message-ID: <PH7PR12MB87969859D0E1BBA75AE67101B0EE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <5db799323a211d12937f69a1ba28d3c740bf2569.1782141279.git.cesun102@amd.com>
 <8df8e57e7a17f131ab9065b4671780378fbaeb08.1782141279.git.cesun102@amd.com>
In-Reply-To: <8df8e57e7a17f131ab9065b4671780378fbaeb08.1782141279.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T07:23:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB8465:EE_
x-ms-office365-filtering-correlation-id: 4a0e3298-aeba-4d22-1d93-08ded0f87683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: qccULKZPyuMwOkUb8AR55YgnochF2PWxEBYO5rFDess3ockXBmLJzsLXA7Ae5pWwGXkinLHgwb9W/6X/rfPCtXyQWuB6A3j4puQKbTdTYG+GxgJVbq0PMvui1E2EEa/A4uYq2BIBetkdOxwXwKHKxn8DvgZS569D1bKztow9X4ItOArpf39A2InY06uOenxHcApEDp1MYYpC/HidPEjWOgxCI9Jlk19w1NJSFkWby/REl4Z+WB4SDYW3lCO7w7m318rlAVU5Cadvbjl4SoAwtNe4a7IZELW1cfUryb+lWCN7/wLZhlm0unhYKhBE7GjL4gfUBzXC9iTduGbVYy2oPvRaO0KeNxbc5lcdZm8W41ebfEMcb7vgW4UcdPNHxcaAAEYY2/9yWcshjBFG5fe9hg6iF+kFJuqkQuRbgb4AVinl6vMyezMAR7JIV7PR2y64YbpDToautu5VAKzSAnv/y1pxxCY3BK2+VpICv/ulTI8syhex+nwbZsNFaGx+KbPO40hiBZ7uuApjlhhgUV7vwcnd7NIEmvmDTKQS2sE7UZt421wSOku0AxOnKGkn9+e9QzCDI/5Ow773c3mXJV8CZc0jSwcRSF0C7jWkv44D1RRl5GW9Kkc/TD+kp5TF6g+amkYfhtrFUk0BQ/YUlvfx4L8VzpPQlgCvgx7fuO/AatPOcKP+ERU4wJuWSTsowcsEcu4iFjYvhRDHeubaHXMokfhDUUn9lHY5OjbtGSM8uF4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+P23I0mYpzdo8Cj9xDjRucTovHqkenX1T7MYWTNlpX8Snu8Y9VYOHGrNxbN?=
 =?us-ascii?Q?mRoAQIWvysFduvMho/VpjKa4fFRuMKoEocxjIDlyoJek0eSP53io23HT5FCX?=
 =?us-ascii?Q?jAwzZ3wMm1WEHGBnXs1gNnMiAcRKvW1rPC8sboBI3L6Ej7B5cRdG6DvCsR4X?=
 =?us-ascii?Q?V7PXwD/byA7Pz6dm8l6xISnt9r8nG+5qFVGuQMpei+A7DIYY/Kbhq30RJomm?=
 =?us-ascii?Q?W7i2tuZlcCMA7xVqgy8q/Vvy9j6BTyGlf6y4+no+5itaU/ItlW32ygsuUcTU?=
 =?us-ascii?Q?52iHsckUbomx5VJyoVhdZ/Y1jBfHVwJraSIdKwsSHMZf4qTmRth7kQSVZ1WK?=
 =?us-ascii?Q?SVkFCXczpVhl39c+TyuqDrchSa4oQJc57LcKyyMeG6uJRjdzrHInyojhcJTY?=
 =?us-ascii?Q?QwNCcLHWP4Std6fp1RNKe+FZFERKsj3y5xNsr+lP42EjVXmeMgvRh5j/GTR9?=
 =?us-ascii?Q?Ss3SSCXwY6OpPznqJ7afl5X6+rrS8qmle3ygzSqnM/Zo1/sG4J/JHgjDuSKP?=
 =?us-ascii?Q?wMOFz5RsSrO6viqHbJ1ugS5XLzzJ+00K8KKWTB/enAvlrXW5FOVQXTkiYLiy?=
 =?us-ascii?Q?slfpp+PIX2XNaeadVJYCCnOPsd0nHL+LcPs+eW80ZleMuWgAbc/4yMESty0S?=
 =?us-ascii?Q?l+JGCxIkKyQh9OR96nVFJsIjtXSWtET0y59MxcIY1Gh2HSvkX0rnWqpGoocB?=
 =?us-ascii?Q?/IhwJtJeLWqdFgEdCkQALnrOJ1Ci59KjqvB0/0gj8YxpT/+nWAldL5XTCIFs?=
 =?us-ascii?Q?0T8jaBXW4/IHGgtZkiJdNC6aja5urYQjBjUrYsSv3600bDrdgiMEkmdm9XGp?=
 =?us-ascii?Q?mHcfeI8ZjcWQ713A5rOqUOQNRfENTDYFDdIfI4TVIjIiQzvbrcyHPkvXUjAH?=
 =?us-ascii?Q?IyOfBFgYqpMtBuqWbhBDq4T8W5Kselk0wKu5E5fWFOLdI2QLHWD5W6me3w3t?=
 =?us-ascii?Q?rXcPXjU2Ho5h0lFUZz1lxWEX5zHb8SZrenRgz42V8kBu3udw2jHZun6PHFSb?=
 =?us-ascii?Q?GKD1/Q8xMGHcNPLx15iLHDUsBqFFqqYkdM8dqaiKGQWp3nqkZQbDCOO8jDd0?=
 =?us-ascii?Q?6MkllsoCKU/MnXiuYf0rkVifgVp2HwuJv+OTTZ1wZTetyQ/lzpVjkFUNgMux?=
 =?us-ascii?Q?qHEW8rxI86uxJe3U0T9GbmR7Brd9wJLWgib6k6FPGJikIjmRZsfUvnNuSbsk?=
 =?us-ascii?Q?AMQpThZqQ9rmCyWAsBCFlFzR7IQsnH4dBeaD1Ek1Z/u8xoN2RgquAP2kaaXL?=
 =?us-ascii?Q?9ylEQ+pwr3ZzFw29X43gaAPQyFz3voPe7ssWR7MPL3xuoff3HsfRpAijJjf7?=
 =?us-ascii?Q?F14lVIOobZpg42n5k1gLOJXKGyEQifyY5U+EVGbfziriBgWA/eKwP5j6Bzck?=
 =?us-ascii?Q?YJszxYkpRSsZY+sQcBU7j+7C/Fh1hCzwtaKH2ayixK2g19jZaUngKhZMDIsn?=
 =?us-ascii?Q?Vt14YBaFwCw9TWn8CeHutD2rpuAzF37/ATObu5WtEh8g2gx6zaiviiylswv1?=
 =?us-ascii?Q?aZ9zR8a0/1U7nBaJmwyOIrAuo0LjYNbIP7odTb67RT1AFMm3nWxFrhJaat2R?=
 =?us-ascii?Q?vTczXSvZ+m/hnn39a/e9bDbqZoE9fqGbwmsM7DW9/Xg2R3PdmJAOaId8Vgx/?=
 =?us-ascii?Q?HKKRB+6jGiTk004oGntTWyk3QzmfcY8Dq4QOHJUoA1vfWhd3VsLhNHzel52q?=
 =?us-ascii?Q?AK1ypccMO9TLpuZJ2fC67rDI0jPqtG061rwQk2g35KLwVFzW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0e3298-aeba-4d22-1d93-08ded0f87683
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 07:24:29.1395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAcfXFWL1PnrXy29SFMnXw8TssI1slpfC85BUqXMJpvEJKzkx5JZzGd5jZw6ynVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
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

AMD General

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Monday, June 22, 2026 11:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
>
> When ACP soft reset poll times out, original code returns early without
> cleanup, leaking MFD child devices, genpd links and all ACP heap allocati=
ons.
>
> Replace direct early return with goto out to force run all cleanup logic
> regardless of reset success, preserve timeout error code for caller.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index b0db0834bfff..1bb931d1d2c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -510,6 +510,7 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       u32 val =3D 0;
>       u32 count =3D 0;
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int ret =3D 0;

[Tao] where's return ret?

>
>       /* return early if no ACP */
>       if (!adev->acp.acp_genpd) {
> @@ -531,7 +532,8 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>                       break;
>               if (--count =3D=3D 0) {
>                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> -                     return -ETIMEDOUT;
> +                     ret =3D -ETIMEDOUT;
> +                     goto out;
>               }
>               udelay(100);
>       }
> @@ -552,7 +554,7 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               }
>               udelay(100);
>       }
> -
> +out:
>       device_for_each_child(adev->acp.parent, NULL,
>                             acp_genpd_remove_device);
>
> --
> 2.34.1

