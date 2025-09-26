Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C04DCAC5AC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 07:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5486010E9E4;
	Fri, 26 Sep 2025 07:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJsEA4+4";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80D510E9E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 07:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlGlOljpzh6Y9hWMhKS6XXoNMO5P1j0qVvALLkF9Sp2y9UTI57n97Bq7xjNKyLsy3vq3Crj5ACLD6OTCykTJs83/d6DDk7YAkYqgyd0m1g7FBUv074V1HQYY9tGBAYUarZK3wDS5OK3ZTR3vptxf/j5hdiV5jHtbolDzDln9hJLcKder/EEbhudC//taR6hm6n82vfm+eoHCBg5zDo1QYkaGUxhcWhJkvru4UiQDMQPDW+zsnPlm6kSTVPLYAU+9u+pLW46qsc6en4DuhTInc9iixw4vtUtuTg2e3ZbFKPpNgaIJ1cf5e+sNoXVyZKHLag3gfPf6aM6Zfh2l8ZCePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qoZ4gAl7KVYNOf2ESJskyU9EhMDxJJeBuLXOyUS6oA=;
 b=nVoFHEh4oMhnNMskqivON/hfGaNA0ZqYBN010rNzx0QCJnW3iz6RvQR+YCzygGTVMM2c7o0jNvlBX7Nz36lPffS3ZMJCiIXCOm9BhMquMBsyI1UZeMRv+uSC/fsBWHokVl7FpKRBuxkX+hXwvkUEVRzwVzk2auu0HK6f32DDD0rmGw7oQtsb46T4Ctx2cjff0CdnJkNw59Hms2FDFfWCGiGytKzdO076k3CuvQ6csZtiPayqQL7mA8Jk0ptQMwkJjCCjePp58/D7nR1EkznRS5etSjBS6Y15mSblixVbbI0qZA96YKfXpKszXtf4HFIK1oiwVW8uKJDJLqnpOsEHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qoZ4gAl7KVYNOf2ESJskyU9EhMDxJJeBuLXOyUS6oA=;
 b=qJsEA4+4oWdlR17C5itoHgrM2X9jzbevsrH42o01w4kHzNLEuOsng8XUkaDWBM8nyRqbS+wWVFOgtS8m+pUC8n3nPmwe7adrb5lr/ghMaaPTKpHw+jbfqyvntf23z2hrCEBYO/+vfPDynnrsAx0qDdohJusir/D0rKRc0vt0Ji8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 07:34:56 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 07:34:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Topic: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Index: AQHcLq+C2vqr7ujnc0ynSedPi0ZXdrSlB7EAgAAFwYA=
Date: Fri, 26 Sep 2025 07:34:56 +0000
Message-ID: <PH7PR12MB5997351862909E500BF2DB7F821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250926063345.1131635-1-kevinyang.wang@amd.com>
 <DS0PR12MB780479816BDE27232614F6B4971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780479816BDE27232614F6B4971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-26T06:52:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4297:EE_
x-ms-office365-filtering-correlation-id: 827475d8-8269-4c3d-811a-08ddfccf30e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Hf8ucQkyuB2cSF5lVg0Tx49ODEvXQWWW7cydxA5GC8ZYhm8iH+ke2lxFYvh5?=
 =?us-ascii?Q?0y+chFd7r0IoAHy36h4Gnv3RCn/dlZxyWTyHG4MbB4r+5r4ryQdv3PHTOdJ9?=
 =?us-ascii?Q?G/4xOpMAQqy0g5Bx65CelxMwO9heyOTGOFY49SIjdAkPDCYOK5aT4se+YkAL?=
 =?us-ascii?Q?1wzhxIraxKhN2ouMN4Yh9zTBYj8Czdf0EAo2cOeoTm9ddnU6CZ2wub6K6hsP?=
 =?us-ascii?Q?3EN+LYtEmcBE40fgFYxk5fONmjnRstnIzzemvQWanJdFK6B200rPELtcwRJU?=
 =?us-ascii?Q?Sgh7YO+coGQoBFifRIOv4Ft+HHv7tAT9YDbfgqfbUf2VVMToQcBUKLRU0p0B?=
 =?us-ascii?Q?xs6dJ/HnHxfGuw764YurO1BwKvyshsDdvai7YSMkTw4sVqUPCg6Rdlu2OSRM?=
 =?us-ascii?Q?pmWCHiisZfyqDxwmqsoqoWCN8IRqdkcyZW8ZeWqFggvH7NBTO7rjPK3Epdem?=
 =?us-ascii?Q?JmPuJesk5YtaVDwTmxRY/crr7WvIE0kxCfLURwTBwama0A+4+8N0N7Pma9nh?=
 =?us-ascii?Q?xZ0kDVnE3oM/vZOuWW2wTn6N0WLFYvdckv2id0ej82doMEvKVdH3I50BqU91?=
 =?us-ascii?Q?5yJ/WMJwcwIoV6qzC5J5ZTjIsRL8M0W2lLqWoV0GpsVDG95HW7eZxUXFVD0b?=
 =?us-ascii?Q?noZGH+1C4ig1/ily/EXgm9h0rCI8EYhZVbRIaMaxrbt6Ybsh5POpj+HN1BfF?=
 =?us-ascii?Q?ki1SZ6TLW4Chr2+kZPkDVJpnxocVym5elJhzXBSWN1MNmmb5OFCB5Hv3mZ0J?=
 =?us-ascii?Q?egTFWqmXo8E6EV/G52kBunJs6Ur1Eeec1QuATg6etr3iot9/lo27hwTAm6F8?=
 =?us-ascii?Q?yk+rOTfcgyHamsn0e05PEHJ6wNyGBKKADEzGzi36D+KOz5pXnonyKTDsET3G?=
 =?us-ascii?Q?9qYdTsqVGPt2gM/WPnomfKsqllL/Yo7BbANaHCWcsL8uFfQ7ggYRY7RuHqwq?=
 =?us-ascii?Q?p5yxN5rPgQZjaCbY6fFOzeRYwSJcXpNb5yVGIs0J7MSgZ54Tmq1JIJ4Ritvf?=
 =?us-ascii?Q?gMn4LgTpu01afEAEupjAcmBx589iBCXrXWIuehUk5KScNrc7ZTT5QWlrDOTi?=
 =?us-ascii?Q?VhNMLrWDRYa4jQNmLGUuyBOyE2gK8igdskMAQWghyeDgHsLXliVhw1POc1jL?=
 =?us-ascii?Q?+1PCHTa5jTJo7vWSEespXApYOLFiVM5Yjw8g9qz0ZnUuDKFoU8jVn0AC12bJ?=
 =?us-ascii?Q?BhtkP8RSaEKLsOrbTJTpvNJtcCK3zVySJ24wfkD+j1GRaoqz5zgtdPteLvK3?=
 =?us-ascii?Q?7BOX1VlIS2Nc0xANNo8vfv+F6esmtDWDCM6haBK3Tpew4bWDWQLGQsUXelsE?=
 =?us-ascii?Q?85CW41ojYYZVcHCP0Ui9Sxn80OQFeMeEq+fwyv+Z2OkjnvtvMfxriLHCzyVl?=
 =?us-ascii?Q?n8tA5ExeUlCYe8d8KmrJ7WYq2T19uQ40I4TiLdJNd/kGw06k7bojS4UTBkCl?=
 =?us-ascii?Q?CRXps7HyWGA2M4x9t4u1zZ/tzvu4PCoFQJ3lXKOUt81AUanhmvoNz7mACfX1?=
 =?us-ascii?Q?OsFsNT59tGU2Gh26FhtVLDQvZmNL8leqMYGk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GElycV3LpPlP0ZzGBkvvemlOP6/h083BBNe0fVOzgImLrNHRuui/6TbztJMX?=
 =?us-ascii?Q?Kg7YcV8pWHylQCj9FcrsD6FRKYAk/g6qIcY5ijQan4LDf3CPlukMZqtHTXnZ?=
 =?us-ascii?Q?NVaPaL+g+VDlR3M+lE6fXG70NAa++k4P8JQB2S3Noq5Sxx/t9IFbRfjbL9Ys?=
 =?us-ascii?Q?gXy4m/SGlO2C7uMltgMBC4cS5Hnxdj8BMk+KcNlZt7NX3hQxAjaFG4srSkLx?=
 =?us-ascii?Q?1WpYOk61n/u8J0cVUnqGiVSc9I2BXag+bHeku7uTyD+29kjKfKE4O1WwIuit?=
 =?us-ascii?Q?jev4sBPdnN+OfWMpmSUPLHhw2Y1ZpktEiDrUeReA6lXml+CHDfkoPnxJpXbn?=
 =?us-ascii?Q?yjSMys3ODBjF5hd05KYYdnlyq5U5j2U5GOH5gLMD8UbUwoLEhThTLadM3uvQ?=
 =?us-ascii?Q?AjaFmFzcfLlhGRV8h+67tXe46LxtQArQ/ubQIj6L1/pzUTaV63l/7S4Scs7A?=
 =?us-ascii?Q?WjV48wceyRSxqgaFOBBYbF7rRWIT12iy/574/NDekHU0cYKSVP7P9o2FHob7?=
 =?us-ascii?Q?4+rxg0Rbw/dnLRoiBcIQ3JjUe2AXlwDgyueOY/gZLn5XXXVu0f9PvGKKoYzc?=
 =?us-ascii?Q?aEEVdwq20CIaTWjRQr9OsZWC04pmfzroP1rjSmj42D+1NO7WJzpkiCsRWIC/?=
 =?us-ascii?Q?CxTjGuKBjumlChi+6iW4hL1RFKrNA//tuOuA2gAoA3SSVJZzvJAe0tQytFze?=
 =?us-ascii?Q?kJlAPyu8G43NzT71Fb7gyxctp9H+Ci2hNliduyxgLQ6aFY19/pl/8F5vLKC9?=
 =?us-ascii?Q?AtLDyc3pcghyBFhyw5nRbo9otu1+LLY9wN/yK58DT6MT3EO3ccbjv7oynSB1?=
 =?us-ascii?Q?KjJmwFVrwSk4yd+hp+lxS+aE5vFMBMujHKPRYdT1gMaTQ4cQ7ML2deXHdBLd?=
 =?us-ascii?Q?iOjP5bNHtYSG3QplNBL04S7a2Sagdy8NjXQGDPJ+Luf5xEFGoQvihShU2pgn?=
 =?us-ascii?Q?1TAMtlROcZVc93f1n1Ewen+FnURGomveTEkmSpIWPmZ1J0f2R+Mhj218ZRAg?=
 =?us-ascii?Q?3r6rCknJ2b28hGSCm34LinNx+MkwVVsyeqtFQVEc/fc62XzFRT2Fuh93zCMe?=
 =?us-ascii?Q?lrC7OjZ8vpI6XPxwjMfxLASYsmYDsO2k+kVDmJwBUihBd6xaF9aM9/didV1v?=
 =?us-ascii?Q?6DH/oHuasO3rmBtTQgdAtk86BhKtJOWq2NSSaATlB3jB46rN/HtrnIzj/RCK?=
 =?us-ascii?Q?m4cvf8dBnyFqw0bCSkvNEKT/P1f90VffekWZRuqIWweKDNztaohgbPRbIxIf?=
 =?us-ascii?Q?buSX4RjvHKFHmLRx98+ZHJXvjudxNueiAAkQ96nfbBfH2zEvEpLmKSvA2P26?=
 =?us-ascii?Q?gkSyjLS80P+oIinkTNOwA05lr5nOh/WTHa9MHnmZC7xwqvPQ1EDqmfpIwRi3?=
 =?us-ascii?Q?kHRqgXs5qrFyl2v+vDtW11M3PfY6Kmd3ZqavAXRqQUavOrqcnVdXFlGgNIBj?=
 =?us-ascii?Q?nArwVu9hIhRe85RvKGrVOmta2kUejgnbBXq/JhpwwuZgzlomrZzs9snDmlrT?=
 =?us-ascii?Q?rYh+yKJWzHluGV+P/jr2XKEN+2bAg5ItjL8NY9mhxWaSi8DN9nxk09LMNuvC?=
 =?us-ascii?Q?AQJhd2VVoSnHIT8hxZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827475d8-8269-4c3d-811a-08ddfccf30e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 07:34:56.4549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwj5Wpl4RCVyHUqqCriXDGgX2Dq7IInLdm9gKyK5Gn3dJW4FMGA6ecLPDbJVnVSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

[Public]

KERNEL[173.150476] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0/drm/card1 (drm)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0/drm/card1
SUBSYSTEM=3Ddrm
WEDGED=3Dnone
DEVNAME=3D/dev/dri/card1
DEVTYPE=3Ddrm_minor
SEQNUM=3D6237
MAJOR=3D226
MINOR=3D1

a "drm_dev_wedget_event()" uevent example above.

You shouldn't discuss these together; they are two separate events occurrin=
g on different type devices (pci device and drm device).
software-defined devices and physical devices don't have a strict one-to-on=
e mapping,
and the device initiating the reset and the device that need to reset are d=
ifferent on an XGMI system.
so, all independent PCI devices in same XGMI link need to independently rep=
ort events.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 26, 2025 14:55
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

[Public]

Presently, there is this one also - drm_dev_wedged_event. Perhaps it's bett=
er to modify this to include additional info like pre and post reset along =
with cause of reset?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, September 26, 2025 12:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

Use the uevent mechanism to expose the GPU reset state, so that the system =
tool can more accurately monitor the device reset status.

example:
$ sudo cat /sys/kernel/debug/dri/<minor>/amdgpu_gpu_recover

KERNEL[172.053149] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0 (pci)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0
SUBSYSTEM=3Dpci
RESET=3D1
DRIVER=3Damdgpu
PCI_CLASS=3D30000
PCI_ID=3D1002:73BF
PCI_SUBSYS_ID=3D1002:0E3A
PCI_SLOT_NAME=3D0000:05:00.0
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=3D6235

KERNEL[173.137681] change   /devices/pci0000:00/0000:00:03.1/0000:03:00.0/0=
000:04:00.0/0000:05:00.0 (pci)
ACTION=3Dchange
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0
SUBSYSTEM=3Dpci
RESET=3D0
DRIVER=3Damdgpu
PCI_CLASS=3D30000
PCI_ID=3D1002:73BF
PCI_SUBSYS_ID=3D1002:0E3A
PCI_SLOT_NAME=3D0000:05:00.0
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00
SEQNUM=3D6236

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 2a0df4cabb99..73c946d9cbe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1805,4 +1805,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_inf=
o,
                           uint64_t uid);  uint64_t amdgpu_device_get_uid(s=
truct amdgpu_uid *uid_info,
                               enum amdgpu_uid_type type, uint8_t inst);
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a77000c2e0bb..300cc22dad91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6318,6 +6318,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,

 retry: /* Rest of adevs pre asic reset from XGMI hive. */
        list_for_each_entry(tmp_adev, device_list, reset_list) {
+               amdgpu_device_uevent_reset(tmp_adev, false);
                r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context)=
;
                /*TODO Should we stop ?*/
                if (r) {
@@ -6362,6 +6363,8 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,
                 * in before drm_sched_start.
                 */
                amdgpu_device_stop_pending_resets(tmp_adev);
+
+               amdgpu_device_uevent_reset(tmp_adev, true);
        }

        return r;
@@ -7669,3 +7672,39 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_inf=
o,

        return uid_info->uid[type][inst];  }
+
+__printf(3, 4)
+static int amdgpu_device_uevent_emit(struct amdgpu_device *adev, enum kobj=
ect_action action,
+                                    char *fmt, ...) {
+       struct kobject *kobj =3D &adev->dev->kobj;
+       char *uevent_env[2], *tmp;
+       va_list ap;
+       int ret;
+
+       va_start(ap, fmt);
+       tmp =3D kvasprintf(GFP_KERNEL, fmt, ap);
+       va_end(ap);
+
+       if (!tmp) {
+               ret =3D -ENOMEM;
+               goto out;
+       }
+
+       uevent_env[0] =3D tmp;
+       uevent_env[1] =3D NULL;
+
+       ret =3D kobject_uevent_env(kobj, action, uevent_env);
+
+       kvfree(tmp);
+
+out:
+       return ret;
+}
+
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done) {
+       int val =3D done ? 0 : 1;
+
+       return amdgpu_device_uevent_emit(adev, KOBJ_CHANGE, "RESET=3D%d",
+val); }
--
2.34.1


