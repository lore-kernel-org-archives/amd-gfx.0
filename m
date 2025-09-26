Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD31BCAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 09:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C15510E366;
	Fri, 26 Sep 2025 09:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TNUCr56q";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E13110E3C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 09:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaKgovncRXmwsGqAVVj8bJJ7jqpaRaTwNFKH/+H4sgYeR4zvFFC439dv/2XkznewgOREqAtepU6jrF4SRHrjtTl3QPFvJUxdPTqrWO454/y4ee1i4KIPkPQRG2v7LoJq8ic5adyfV9EpiFVBmrLmRLJdILRdcu33Lk+FaKpwF8q6uyE5UD4q+7xaoD5JGaiCtAVd5w6s4PGpEAOWpjIjhE4cJGrDo/k6EgGBoHyOTXatjIloURCnuv6u7+dMi6n8z4J71/1cLAyMR3dvOtozlErOcnvqUBQE2Iv9WExFuZp9eXNzEs7jfyHBbXOZOSodWIZBRmGb8FZZtk+oitkhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCasu9a7OzXHPQwl7nDt0Q76QHJzLXjuVrTgFLrz0Us=;
 b=gn3q83xfOBtWS4vCIgz0bVgX9G4uq60+gpur7TuzDjBqu8QYFv0tDeyw1X1ERjH9BndSlACwJec0VqIr2pe4NXzZTYAWWDri1w+zEmJM1DeSu+J6GQtd/p0yjKEnGd8PtfiqZr+gUy2gjpGtgqpovrumUec3aBdx8dV+/EK/ow9R/OQ1M0HEiTs4y5slERzx+7OcMJCcK8tnz63lxIIX3eWakimQf6yEm8TdfV+Ja98vuGi310cFMtu2LhBDYvbssWmuajf+UYnGjVJ7DqjRsvFyle9qr0b6FFde21R3CXpeEJZpBnbYVFZ76v1MftnG7rIpxM2U8emi1F7q12CJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCasu9a7OzXHPQwl7nDt0Q76QHJzLXjuVrTgFLrz0Us=;
 b=TNUCr56qC3jMpZWGv6ha2JL1Um4GF6UHc5/PPRC+7az/QH2rnSzODZ3ISNjQx2RZ0lEWIRhmaQWiLgyu2RwroySWK7CT0Uqp8r6yzIrS9zZZh5iQtWZ/Oye7pCC+o3N5Y0F6/WVjFj2EVKLx1M4d7MsqeGMmcIe0r7FxAXH/8UI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:43:40 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 09:43:39 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Topic: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Index: AQHcLq+C2vqr7ujnc0ynSedPi0ZXdrSlB7EAgAAFwYCAACM5AIAAAnyw
Date: Fri, 26 Sep 2025 09:43:39 +0000
Message-ID: <PH7PR12MB59974E8FB258A40D171BF4D2821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250926063345.1131635-1-kevinyang.wang@amd.com>
 <DS0PR12MB780479816BDE27232614F6B4971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB5997351862909E500BF2DB7F821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780416F186166F39E61F39DD971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780416F186166F39E61F39DD971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4220:EE_
x-ms-office365-filtering-correlation-id: b27a6056-af37-4b5b-3161-08ddfce12c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I+EwGa5oY8J/VfDXC3PrdMegZGX7sIgZ+VvLQTvtpMtHrpl/viRPxUZtLsfB?=
 =?us-ascii?Q?lBKBnQxj2e2PtHr0h9el5vK/yUshibBgYTRZDVxND4+IOU4dEU9qe/zYnwKP?=
 =?us-ascii?Q?4axB5rADZTjRGPdw8iKV011VCEdNDfRZe+cN2jyqmxtHM8eQSX8R39LUxKnz?=
 =?us-ascii?Q?ktoRfCDBGHZ58C/MrXSzNMTgpj0Pv5HI20RDpnGfijwBm7bH7M1B19cFJl6h?=
 =?us-ascii?Q?MpAzJ32BIY4o93Ac+Nme81BXsWI/bnFJ0FYB/lr3yEbImcTXNXUKt197O6kl?=
 =?us-ascii?Q?2CWmDalWn2cOWWfxkwxIodxMVKgSnOHqB+ALoPMNeASFcdgqeoztkBz+a6AW?=
 =?us-ascii?Q?YEK/Jj1RmvWHlcJdYqU616UX4vhND2vUFQ2NriSe7utticLxrqAsl+POTUBp?=
 =?us-ascii?Q?oBnPni6pBuArCE/xF1J1jIn2X1z60Fyvrazh4wM9mf0A2Tbdan0hNKR8vQUU?=
 =?us-ascii?Q?Ob8adOnoRd4qi8iaHDY1oYaMpFd4qcBo4kLbEcef1g/L8qqyBeOqeqLZG1nC?=
 =?us-ascii?Q?UIlvxpbBJLPIi+glBzCEsaVXGPmyD2mZ6pL9mjW9ZoAG1eodZexfrUuK8u90?=
 =?us-ascii?Q?WWTwKf0usVUTNogH9OHLxAO2D3ts/DjlfsLxFxZfb1XUD6R3YYpfGaogOjx2?=
 =?us-ascii?Q?mwcrC/WuEPETBWROWkVQ7OepKcWF/FZ8wgbalD/UOdLRf+h26RXo3nLktTUm?=
 =?us-ascii?Q?Ld1qKA5aub5h4NeARdGGAfr/KZ/Rp8It1cTtmpgvi1rewaeZHeQj3VSwCSmA?=
 =?us-ascii?Q?yD5fZIEdXA2zqrjy/Ds8sMM1vQtuMyewGPTd0VzWyQ2YPJ+yTytrMNjI0++X?=
 =?us-ascii?Q?DcRHUI1MM9zz0bSOUKo13Zdr+Ld5PIia66XeFqXzP55QGCxTJqd3K6dzJFVu?=
 =?us-ascii?Q?jcN9VaAYrN94aubocfn4rGw7eHfhEHX50Vqk16f2ODt7UhNfBZTs4menz72V?=
 =?us-ascii?Q?B2REHsTion40zgVcebtT7qTwjrY6QMWoQaKcmcEOUIIIR4LCoN0iw4EKTnT/?=
 =?us-ascii?Q?zBEuUleIxQUsjv/vvoEUoh+s1ixCHqpFExKfyTFqFfuAayFhTW0nMXbwtgi/?=
 =?us-ascii?Q?GucnoYSnPLBZmroasERW14QhbgXQxy8H//TaHDpxaaAZV3rZs7BZes9jKPHC?=
 =?us-ascii?Q?biktacnoCPQk3868GVsC3+U22XjcXURa++8FZYLLAA+22bagDW8AZEpjenEn?=
 =?us-ascii?Q?Oeiv8fZNkDGShwm1nth1QyWvJ6/QxK3I+cDiZ48GhBAEFk4GO4LaI4bYEMkY?=
 =?us-ascii?Q?3PN/55VncWRpwIi3lB1HSq9mPCzywpd2hfSegrOQmAn2aYwB3HpUncqWLxad?=
 =?us-ascii?Q?Qc4+uLwiFJee71dKXJnG1d6QJ+kap3/WOy9J0KTFvxmyj6FgNiw4qvV0E3i7?=
 =?us-ascii?Q?/qbC+RKKam/l3SFGjmP9A2WUkRUQ7RgxVGygUnI6tTxp/etgMySzVy5I1ty+?=
 =?us-ascii?Q?25TKOa6H+DbtqoSitfqsv+70SzYQuDdMZXoNepdxiHyqFamjSGgoRSqG39/T?=
 =?us-ascii?Q?v/IfCJp48XIJMUU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPRMHUIWphREIoaU9l7yPqXwgYDMFwYz6SxmPrQXjPCEhEIRuSVVTl4tU1fe?=
 =?us-ascii?Q?0MBW/cgVtIRt+hH326z3GPnErRG2EGmAQfdRWYB0hgXz/0EcZjauquW7qRQG?=
 =?us-ascii?Q?UqxE0+dLnivH3DpOnFX/AIX3NG1t7Ul43H+T0/Gj0YmDiAsqNgkKe59tJCG2?=
 =?us-ascii?Q?SQVpda1tWh3vNK/VXHZP42s7kdQ0tBmJSJp4J3rmsL4tdHo0H8ubriJvPZeE?=
 =?us-ascii?Q?TXydXErnE8PstnVhREScycOOfWurH6VdpAzd5QdTxU8IJm6WydM7Kist2zUq?=
 =?us-ascii?Q?CMnEepXCn77e3S6yenJxN+vW6aBjL0kLKzBh7jRYX90U0Un8T39zsl8V6UXa?=
 =?us-ascii?Q?NCjPO6OEQMpipjx5hn/K+eYBc9M5PkGAVZNV8Q0n5y3oyVWR37m9xH4+aFKN?=
 =?us-ascii?Q?hF0xhZD4uHYh9CBmyTorwcfAV7RCl+mJr0l5h/TDSGJVZr0BTFdzE0Z/0nRd?=
 =?us-ascii?Q?IHugEQbW4HcKo9iPkMFoc40G3ILlfmRrqexVqw56/15Ppzg6ijMnWMOxxLZI?=
 =?us-ascii?Q?107hg7NGG7MW8kt5sjVYzCmGKVKspRBhuYblzZd+XaiH98HBF6JA65BSrK8Y?=
 =?us-ascii?Q?IZARsQ9MMm3V820urFkupbPcwzGcqbRD3jt4IeqclxUOhCxzTR71EQYMsocH?=
 =?us-ascii?Q?kEaIgk0DCOHsNUEHfLD82fHTupywxzRCNBUNa3yhrbucHhBgfowKgor9lj3t?=
 =?us-ascii?Q?bG5Ii8FixlpV0OV5rCnJh6jRkqp6EeMzcX2Hz4Y2xsfvpYvxapoiYxJj3t5K?=
 =?us-ascii?Q?bast/WoSOtaUwA0d62QBPII2A7SySTSU2KPkU7L/dbdZaNwXyjAPG9kZDLjh?=
 =?us-ascii?Q?AaU5ZmigcAoITYApX1IW8hbUbgUDB1kUPVRUQBdUxk3XdzjWwJD9od2/lUpn?=
 =?us-ascii?Q?EY+vMdiWOIOVu8UivDtLgZQFxDGmkxpxVFhrW/ptu6mruIfEbfEq++946DMg?=
 =?us-ascii?Q?80Yg/ByVPCU6aahbk5Q/cMf6dzT9aLkNyCkV2p/26U0yMOKbhYkqJdZs+t7o?=
 =?us-ascii?Q?DMThosdl4pLMLnffrxbSJGw1rLtNPxQRsARJO70OPaRX6AICShKDbT2RO5Cr?=
 =?us-ascii?Q?YzfjHWb31RMUWaudxYs8UVO0nUUrWjagwZb9+hRp40E24C+S6EiDud6jo+DQ?=
 =?us-ascii?Q?IB+/GPS8lm5dkLx1S4dhnXNEWLFQwO7KWqKsmaoqp+wYVcGZgHkR/ncKOdr/?=
 =?us-ascii?Q?ep6RpY35x6PZoO8ufecYO2HuTRmhSG/C8ooexDSRdcvVqtjCwqEW0KM4evwm?=
 =?us-ascii?Q?SkPKPDHyUeibchuon2DjCRa4JVbvz3Oek6Dq5vM8uUHXsh1LosfItIkClU5Z?=
 =?us-ascii?Q?ms7IANZ3SadAxeG9kEdRT+W+eyBBCmp06zs7Sw8IusVlflPtiFCyuG+R8Tgl?=
 =?us-ascii?Q?4gcRN6vYKWK3OMh824gDV/eY4HqOwbF33FL91Jc8Ce66kEEwMD53yMTH2oKX?=
 =?us-ascii?Q?ZwfFUpr660C8FmXWgtC4j8ppiSWa/VZv7ntz5ZRGqZLltjsNM5DOHdaa+9Eh?=
 =?us-ascii?Q?yj5STTGggz5vvBra040CEpu1mstWsXAJvdVgueVLlhFBFoDyZiHV9OKECYjZ?=
 =?us-ascii?Q?OQgR87l4OsQoWcfFeao=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59974E8FB258A40D171BF4D2821EAPH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27a6056-af37-4b5b-3161-08ddfce12c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 09:43:39.3368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeN+60d5qgrSDarmutd8N/huZ8trknaKvnzmR4OcB4RQ+2M/snXaENLPm8oUak8d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

--_000_PH7PR12MB59974E8FB258A40D171BF4D2821EAPH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

>> I guess the primary reason to have drm_ event and amdgpu having that is =
because all the 'users' interested in GPU events come through drm interface=
.

in fact, that such devices like drm render/kfd/i2c controller/hwmon/device =
nodes are attached to pci devices may not respond if device in reset state.
so, this is useful event for user mode application.

and please conduct some research before making any comments to avoid wastin=
g review resources.

KERNEL[11438.593689] remove   /devices/virtual/kfd/kfd (kfd)
KERNEL[11438.593757] remove   /class/kfd (class)
KERNEL[11438.614767] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3/i2c-13/i2c-dev/i2c-13 (i2c-=
dev)
KERNEL[11438.615100] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3/i2c-13 (i2c)
KERNEL[11438.615624] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3 (drm)
KERNEL[11438.615951] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-HDMI-A-1 (drm)
KERNEL[11438.617227] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1/card1-Writeback-1 (drm)
KERNEL[11438.618336] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/card1 (drm)
KERNEL[11438.618429] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/drm/renderD128 (drm)
KERNEL[11438.622178] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/hwmon/hwmon0 (hwmon)
KERNEL[11438.784296] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-10/i2c-dev/i2c-10 (i2c-dev)
KERNEL[11438.784346] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-10 (i2c)
KERNEL[11438.784386] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-9/i2c-dev/i2c-9 (i2c-dev)
KERNEL[11438.784417] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-9 (i2c)
KERNEL[11438.784508] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-8/i2c-dev/i2c-8 (i2c-dev)
KERNEL[11438.784540] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-8 (i2c)
KERNEL[11438.784634] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-7/i2c-dev/i2c-7 (i2c-dev)
KERNEL[11438.784664] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-7 (i2c)
KERNEL[11438.784803] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-6/i2c-dev/i2c-6 (i2c-dev)
KERNEL[11438.784934] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-6 (i2c)
KERNEL[11438.785151] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-5/i2c-dev/i2c-5 (i2c-dev)
KERNEL[11438.785335] remove   /devices/pci0000:00/0000:00:03.1/0000:03:00.0=
/0000:04:00.0/0000:05:00.0/i2c-5 (i2c)

Best Regards,
Kevin

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 26, 2025 17:22
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent


[Public]

The intention is to notify users of the device about the event.

I guess the primary reason to have drm_ event and amdgpu having that is bec=
ause all the 'users' interested in GPU events come through drm interface.

Thanks,
Lijo
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Friday, September 26, 2025 1:04:56 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

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
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Friday, September 26, 2025 14:55
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com=
>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent

[Public]

Presently, there is this one also - drm_dev_wedged_event. Perhaps it's bett=
er to modify this to include additional info like pre and post reset along =
with cause of reset?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Yang Wang
Sent: Friday, September 26, 2025 12:04 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>
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

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
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


--_000_PH7PR12MB59974E8FB258A40D171BF4D2821EAPH7PR12MB5997namp_
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&gt;&gt; I guess the primary reason to have drm_ eve=
nt and amdgpu having that is because all the 'users' interested in GPU even=
ts come through drm interface.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">in fact, that such devices like drm render/kfd/i2c co=
ntroller/hwmon/device nodes are attached to pci devices may not respond if =
device in reset state.<br>
so, this is useful event for user mode application.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">and please conduct some research before making any co=
mments to avoid wasting review resources.<br>
<br>
KERNEL[11438.593689] remove&nbsp;&nbsp; /devices/virtual/kfd/kfd (kfd)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.593757] remove&nbsp;&nbsp; /class/kfd (class)<br>
KERNEL[11438.614767] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/card1-DP-3/i2c-13/i2c-dev/i2=
c-13 (i2c-dev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.615100] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/card1-=
DP-3/i2c-13 (i2c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.615624] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/card1-=
DP-3 (drm)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.615951] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/card1-=
HDMI-A-1 (drm)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.617227] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1/card1-=
Writeback-1 (drm)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.618336] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1 (drm)<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.618429] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/drm/renderD128 (=
drm)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.622178] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/hwmon/hwmon0 (hw=
mon)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.784296] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-10/i2c-dev/i=
2c-10 (i2c-dev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.784346] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-10 (i2c)&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784386] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-9/i2c-dev/i2c-9 (i2c-dev)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.784417] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-9 (i2c)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784508] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-8/i2c-dev/i2c-8 (i2c-dev)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.784540] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-8 (i2c)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784634] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-7/i2c-dev/i2c-7 (i2c-dev)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.784664] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-7 (i2c)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.784803] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-6/i2c-dev/i2c-6 (i2c-dev)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.784934] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-6 (i2c)&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
KERNEL[11438.785151] remove&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/00=
00:03:00.0/0000:04:00.0/0000:05:00.0/i2c-5/i2c-dev/i2c-5 (i2c-dev)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">KERNEL[11438.785335] remove&nbsp;&nbsp; /devices/pci0=
000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:05:00.0/i2c-5 (i2c)<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Best Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Kevin<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Friday, September 26, 2025 17:22<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via u=
event<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">The intention is to notify users of the device about=
 the event.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I guess the primary reason to have drm_ event and am=
dgpu having that is because all the 'users' interested in GPU events come t=
hrough drm interface.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Wang, =
Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.Wang@am=
d.com</a>&gt;<br>
<b>Sent:</b> Friday, September 26, 2025 1:04:56 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via u=
event</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[Public]<br>
<br>
KERNEL[173.150476] change&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/0000=
:03:00.0/0000:04:00.0/0000:05:00.0/drm/card1 (drm)<br>
ACTION=3Dchange<br>
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0/drm/card1<br>
SUBSYSTEM=3Ddrm<br>
WEDGED=3Dnone<br>
DEVNAME=3D/dev/dri/card1<br>
DEVTYPE=3Ddrm_minor<br>
SEQNUM=3D6237<br>
MAJOR=3D226<br>
MINOR=3D1<br>
<br>
a &quot;drm_dev_wedget_event()&quot; uevent example above.<br>
<br>
You shouldn't discuss these together; they are two separate events occurrin=
g on different type devices (pci device and drm device).<br>
software-defined devices and physical devices don't have a strict one-to-on=
e mapping,<br>
and the device initiating the reset and the device that need to reset are d=
ifferent on an XGMI system.<br>
so, all independent PCI devices in same XGMI link need to independently rep=
ort events.<br>
<br>
Best Regards,<br>
Kevin<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.=
com</a>&gt;<br>
Sent: Friday, September 26, 2025 14:55<br>
To: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYa=
ng.Wang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuc=
her@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
Subject: RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent<b=
r>
<br>
[Public]<br>
<br>
Presently, there is this one also - drm_dev_wedged_event. Perhaps it's bett=
er to modify this to include additional info like pre and post reset along =
with cause of reset?<br>
<br>
Thanks,<br>
Lijo<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Yang Wang<br>
Sent: Friday, September 26, 2025 12:04 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuc=
her@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent<br>
<br>
Use the uevent mechanism to expose the GPU reset state, so that the system =
tool can more accurately monitor the device reset status.<br>
<br>
example:<br>
$ sudo cat /sys/kernel/debug/dri/&lt;minor&gt;/amdgpu_gpu_recover<br>
<br>
KERNEL[172.053149] change&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/0000=
:03:00.0/0000:04:00.0/0000:05:00.0 (pci)<br>
ACTION=3Dchange<br>
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0<br>
SUBSYSTEM=3Dpci<br>
RESET=3D1<br>
DRIVER=3Damdgpu<br>
PCI_CLASS=3D30000<br>
PCI_ID=3D1002:73BF<br>
PCI_SUBSYS_ID=3D1002:0E3A<br>
PCI_SLOT_NAME=3D0000:05:00.0<br>
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00<br>
SEQNUM=3D6235<br>
<br>
KERNEL[173.137681] change&nbsp;&nbsp; /devices/pci0000:00/0000:00:03.1/0000=
:03:00.0/0000:04:00.0/0000:05:00.0 (pci)<br>
ACTION=3Dchange<br>
DEVPATH=3D/devices/pci0000:00/0000:00:03.1/0000:03:00.0/0000:04:00.0/0000:0=
5:00.0<br>
SUBSYSTEM=3Dpci<br>
RESET=3D0<br>
DRIVER=3Damdgpu<br>
PCI_CLASS=3D30000<br>
PCI_ID=3D1002:73BF<br>
PCI_SUBSYS_ID=3D1002:0E3A<br>
PCI_SLOT_NAME=3D0000:05:00.0<br>
MODALIAS=3Dpci:v00001002d000073BFsv00001002sd00000E3Abc03sc00i00<br>
SEQNUM=3D6236<br>
<br>
Signed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com">kevi=
nyang.wang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 +++++++++++++++++++++=
+<br>
&nbsp;2 files changed, 42 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 2a0df4cabb99..73c946d9cbe1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1805,4 +1805,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_inf=
o,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint64_t uid);&nbsp; uint64_t amdgpu_device_get_uid(struct amdgpu_ui=
d *uid_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_uid_type type, uint8_t inst);<br=
>
+<br>
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done);<br>
+<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a77000c2e0bb..300cc22dad91 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6318,6 +6318,7 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,<br>
<br>
&nbsp;retry: /* Rest of adevs pre asic reset from XGMI hive. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, de=
vice_list, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_uevent_reset(tmp_adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*TODO Should we stop ?*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r) {<br>
@@ -6362,6 +6363,8 @@ static int amdgpu_device_asic_reset(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * in before drm_sched_start.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_stop_pending_resets(tmp_adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_uevent_reset(tmp_adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -7669,3 +7672,39 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_inf=
o,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return uid_info-&gt;uid[type][in=
st];&nbsp; }<br>
+<br>
+__printf(3, 4)<br>
+static int amdgpu_device_uevent_emit(struct amdgpu_device *adev, enum kobj=
ect_action action,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *fmt, ..=
.) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj =3D &amp;adev-&g=
t;dev-&gt;kobj;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *uevent_env[2], *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_list ap;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_start(ap, fmt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D kvasprintf(GFP_KERNEL, fmt, a=
p);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_end(ap);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uevent_env[0] =3D tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uevent_env[1] =3D NULL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kobject_uevent_env(kobj, acti=
on, uevent_env);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(tmp);<br>
+<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+int amdgpu_device_uevent_reset(struct amdgpu_device *adev, bool done) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int val =3D done ? 0 : 1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_uevent_emit(adev=
, KOBJ_CHANGE, &quot;RESET=3D%d&quot;,<br>
+val); }<br>
--<br>
2.34.1<br>
<br>
</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif"><o:p><=
/o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59974E8FB258A40D171BF4D2821EAPH7PR12MB5997namp_--
