Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85028CAC5AC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 09:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889FF10E310;
	Fri, 26 Sep 2025 09:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PKxsgSOE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D85910E310
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 09:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDRA+cqNq8TfccCuSOQn7mWo6F4/Vd759t9M30MjSGxaxoQDvojXIH9jMv45MS0UKBiVKto+Bm1OK7iW9A79lUTR3vR4Vc+cN5Wk5h6Qn7cgflkpCtgLUFLECDKgJZPyPBLaMjSDRxFEPpvrev1rf6sxANx2dDRLR8UGceyTw/gTe1MX1CCyh8xHth7NHMOM3EzY36g1Om9WZa5eGUOYLHpCD5tkfMdfMU2ryfdnQzIptyZV2XP8PscAnufQTbd3wICeq2v9sw3VnLybMvtjuleud9+k3o4p9WE92XahUmmEpAmxeHf+JuKXhx4LtWoEBtYnK/5eGxal36vf9cjoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P21Nj3JII4CC76S2mXivvh4OxI+crLV27DK5QA4CrGI=;
 b=r+kV5ag60I0EU8o/M1iu4NZxt/ohtaSakmtDS8gYOrSeKgzlU7OkL1E+fFYyUxWic0BXCjGEouzeWXZcYK9GYypkVWkzMFSH7XUEfV7bxpaLwp3+QBx+ytc1YAwtnXTZH0WP03b5S91jOrwLPbrvHCxli2GYpEKtBGy1gcD2nVgG3qZkto0dSm3LUpNri68DPRpPrkLG1ZitWVwHGPUJEdQty0LCuogjAcmgVrPrt6bjU+xx2MtefkwackuGA039ccmi2rolnDr4S9hZgo0mngqugbtRnbx4K7rJBMMwjvyoyhtb3rxLN34xHobZzefPiHOigPa9R0myw8jkZCr6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P21Nj3JII4CC76S2mXivvh4OxI+crLV27DK5QA4CrGI=;
 b=PKxsgSOEpQLtrImkGfnFaai4bbE63Rqzh1Yz1uSA/wb64agcrYMYcCrQs8GW2PoQK8dBIu526r+ehw8BSkk7hIrktqkm+QdzPKUVDgIa3B/gTSkol62dAvcDVbF2vBfl3LzHEaebyY15a9TRgJuDF2+1D7TUjia4RmDCngzWsFo=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY1PR12MB9584.namprd12.prod.outlook.com (2603:10b6:930:fe::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 09:22:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 09:22:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Topic: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via uevent
Thread-Index: AQHcLq/CnRqszrely0C0m9n0ee75DbSlBt9wgAAL3QCAABzd/A==
Date: Fri, 26 Sep 2025 09:22:04 +0000
Message-ID: <DS0PR12MB780416F186166F39E61F39DD971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250926063345.1131635-1-kevinyang.wang@amd.com>
 <DS0PR12MB780479816BDE27232614F6B4971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB5997351862909E500BF2DB7F821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997351862909E500BF2DB7F821EA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-26T06:52:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CY1PR12MB9584:EE_
x-ms-office365-filtering-correlation-id: aa4e1e21-eba4-412c-5f5b-08ddfcde2824
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bwbOjpE3f1xp/Y/rKKKCpiHtgl2zIspW8jAQMt1rEP4wfKLK7KW1ubc5wsc8?=
 =?us-ascii?Q?PK40lvDjoB86A1WvQDEJhn2evXrZJia7gXw9WUjpTgESd/3/Mr91z8TF6Paz?=
 =?us-ascii?Q?lYF+xrFCpsA7IqS/nmGAdxMoTdc9DcAnTvo+weFFyTvFlbDdA+A70OmGG9v2?=
 =?us-ascii?Q?nxyrPYhsqThJlr/6BfIuRmAX7CD+jX/poEmUWb9Sm9eHAg3z2DRMjNB0BmP4?=
 =?us-ascii?Q?UIJW7AuukLhf3M4VR3U3Puwnm7ndIezFgZDLLZfr5hTsWNFdPpWRZ9DIOvqq?=
 =?us-ascii?Q?VX8cjF7HMfBOdHdAGkYkFfuFbhKAZyqsaovug6rRAjDB5hwz5hn5Z/4Vml6l?=
 =?us-ascii?Q?Dlu6e/tFNlJLp1FuDCMZYZD/0XHURBsjxiepYVSEVQRB1bgMPTtteCEAA0Z9?=
 =?us-ascii?Q?lTOPtf0XlcWMPXW2O4/YfawzdvW5BYYSPl2iPIidKiuQpjigIhCU5MBxK47m?=
 =?us-ascii?Q?dw05sJvSF6L3eQow9EPPX9VyvS/POJ8l5pTzNHpRU9bjoUaMRgKhEAEAVqON?=
 =?us-ascii?Q?VlXDbGDwxqSZthciUgNbelfH52qA/cF/LiVigQkiZ9k+ANMIG0x03C7rhF59?=
 =?us-ascii?Q?0LhHa911RO744hAv41HQpbzhVhMoTzGfbFeXyzS7nzvdi+pAreduV55XvDl1?=
 =?us-ascii?Q?rCJej6xc41U1N46XMpiie5bR9TnGqJD6+s+yTCQMUTGw2ksvny3hVEtQI81D?=
 =?us-ascii?Q?4Xi2ssdXSwuzwY+/KcRHqtdEBEXWBLOlRdsW4WzSHuj9H8svqPtXpAEu41AM?=
 =?us-ascii?Q?HFsvz6PGSiM0tUYlR9Usxc8wiwK+ev4dFkuYKYx+BKq/JdGWM7iDnGMJRBsB?=
 =?us-ascii?Q?vwyXOhi6u7KyRwbzYXLcqLIX+EVwsFI97OIE2+ctyEEpnz8CrNJoRZB4EI3b?=
 =?us-ascii?Q?lMiVQnJG56P1H9WExu8lfGdWseaBd5imSKaiIAAlrscQ4LLDhwP/PKf2OYkV?=
 =?us-ascii?Q?ghuo2s0mNf9Zx1Rx1enB0QzODhuhsadP//h06glUAQqnX1qeEQZs3V5P7diB?=
 =?us-ascii?Q?L+QoTy/R6UfF2Gl5XD3bqqyFGZtChheSky++otBlo2bbLOeDwWoESqpJqItt?=
 =?us-ascii?Q?fDiCj1D0izOuaxr26+/TCKs6GZZCdyqMKsiI/91zrpaZbrd7V8zFOg9xuBVi?=
 =?us-ascii?Q?W1vUeKydMIIDSazQmqd4w1HDvEZtYFF4kOMpQ4/7EjaGKOoCLehdKAbRF8lI?=
 =?us-ascii?Q?QkTjTk/bqgrnsyjXQElePFAYEMYh1rL3kGy0xEIURHFsKG+cODpxI84X7y1C?=
 =?us-ascii?Q?JLr8+3sJac3wHOOhf2nfUgD3mR9TZ1nQOhFKxWD8CUmnfrJYe05R+H2c22+l?=
 =?us-ascii?Q?tSGkiCPIRNPKg4TcbeHfU7PhoaxmU0V6l9I4VXJBWYTjgOKkwDqSGpfU+z1z?=
 =?us-ascii?Q?vJEERJRIPnslkyd7ThdRkpGI89DymurkcfqrMxFc4Csps7MxqZTTCaZ1uZJ9?=
 =?us-ascii?Q?Z0rjqDhFL5IQJb8kRxYiYmMgLYjfSrdkl0wPabmk7HBJi5AWSStnBvZm/bKi?=
 =?us-ascii?Q?BQd12YUf/eQpigY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hL+CbnmsvAe10JetN+VfeO8RIiTCgSGjZPrKBJE4ij7M3jPV8qaIv8p9rriC?=
 =?us-ascii?Q?Wr5a5QU4DcqRR87P0nmfrLtMBNB9x64sfh91WKkyj5Rg33e0tR9bbrcZvh1O?=
 =?us-ascii?Q?m8pGHT3PuRH6Dc3p6qFyyii2trVsyKQ8dJUDPsF7Cgv1KHlxyIiOpcoLlke6?=
 =?us-ascii?Q?t/ybaKWZl+7HbWvQ3fvyTYUOTyalauW+NCb1uMGqTnQfBwiFkEh/RoeXZvz0?=
 =?us-ascii?Q?wa/WgAEVV3aaP91yWfSCWlKbGim9r78F2icz5LOeMN+Qt0R8sevo0PWGD78k?=
 =?us-ascii?Q?Ey124llpusau5dIhiBQPkRAfSAxutatNvUSqagdfI7QsxJyNcMgLVTYbV/vE?=
 =?us-ascii?Q?CD/2zA56Hx8crKUSpixy6CiGNSUK4Uh2Yxe+uUMxCSbUPa61et/v/2Qm1hWF?=
 =?us-ascii?Q?zWEuHqwOmxRW7c8rE2yGlkySf4T8dQ3m67L1+qAGKpAN1kNMaYGEX01r1E4z?=
 =?us-ascii?Q?5O84AF1VcR8+JdW9AFVPO40WfsHqShHqNVH/qCQnkWdMwIwqfMibmq7Zap6d?=
 =?us-ascii?Q?bbaTSjoJt4vW7BXAnC0LuPYT8CsCS62WneX1WgJfpDt7stSAmNkBsxa1+YsT?=
 =?us-ascii?Q?Wya68rQGYBMy6Grrwhj6AuLRR5thNwEkpAAU0u9KngzDYZH/q+3kdBOgBGIT?=
 =?us-ascii?Q?Z8u8VdMf2vavD7qp6qYCJVnJLKo3+HLfQrPQF8Nhyx+7GQWOg12+SHWyX1w+?=
 =?us-ascii?Q?963QhRcJQvUG+3U+wDxv/4eZ2QWMVumS9Tx9U8zry/OQBpehC2rrdaWhbjnU?=
 =?us-ascii?Q?qwh0LG2XvfWDzqYN0o8HJPTBsNyxZ1sliFxn5icWuDaZ5z1dTnYN4LMM8zQM?=
 =?us-ascii?Q?b5yGtfX4LKzRkQpKfCrSMl37nOp8IuK7cq1aVSQyPHiOzXsQr9kDXs2vTSzd?=
 =?us-ascii?Q?oXzBTO1mB7TFd9BiwhxBTAHP6WFQxXeurwmx82m1kACBbpwj4g9jqTgtGX+j?=
 =?us-ascii?Q?6WdDtoQDij3Q64EJShs+EChwEq1sp2n0fVpyxXsR+rBzoOdONonHGA/9bA8q?=
 =?us-ascii?Q?CDHz0xGAc6PU+xkVblrsUtbn9NU5BWnqqXxaPCD8TxAG0XyNEO5FpktbnQob?=
 =?us-ascii?Q?pJNqQ8SoEEIVDeB6xa18dFENsA7c/It+czNlMFKWyz+g9rhMHV7EYpe5bxbw?=
 =?us-ascii?Q?saGb117/tSO8I1bIf00tnV5KGW09deXFqSQttQYRo0fHGV8M7urrba9Yu9ib?=
 =?us-ascii?Q?Vf4YcXYlv/aFZ+rOIh8zLXMRNuZ842+lwuvMTfcSprH8TxYQHS1QA0ywpWtF?=
 =?us-ascii?Q?r2zevGCKwKm3oMqScd52wJ/3YNGsXyvv4+HJBTs2mOwWnb1nIfcyYzdIsBFQ?=
 =?us-ascii?Q?w4Zrrsy4XRihy3fMjUqEnFZOTAa04PIjoOK+piYGDqeb7QK1EVdXnpjRAgNV?=
 =?us-ascii?Q?WkHE9LCWuOO6fUUAtn1vtligs5M2+PiScl0s0FSEaEtrmvFrgRtELHfVw54U?=
 =?us-ascii?Q?rt3odCUVLbcrSaohioFFYPntyN4EEU2xhaBLBHg+OPaqJeU5HNiM3EEHa5ei?=
 =?us-ascii?Q?w96JIzSighr6rhJYXGXPiV/zB+yobTNUA0B1RJyeJu4vuM5bEU33DCNvwhB9?=
 =?us-ascii?Q?OJ91GL9eWvctY003mrayenqFAtUbO7rqYYm6uXtV?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB780416F186166F39E61F39DD971EADS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4e1e21-eba4-412c-5f5b-08ddfcde2824
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 09:22:04.2821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfQMAoNOEqVsw1uOBo2aSiSpSrrBUx7QSH9G1SdM5YVAIfkvOl6codWyzFkOOhY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9584
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

--_000_DS0PR12MB780416F186166F39E61F39DD971EADS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

The intention is to notify users of the device about the event.

I guess the primary reason to have drm_ event and amdgpu having that is bec=
ause all the 'users' interested in GPU events come through drm interface.

Thanks,
Lijo
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 26, 2025 1:04:56 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
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



--_000_DS0PR12MB780416F186166F39E61F39DD971EADS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
The intention is to notify users of the device about the event.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
I guess the primary reason to have drm_ event and amdgpu having that is bec=
ause all the 'users' interested in GPU events come through drm interface.</=
div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Yang(Kevin) &lt=
;KevinYang.Wang@amd.com&gt;<br>
<b>Sent:</b> Friday, September 26, 2025 1:04:56 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: notify amdgpu gpu reset state via u=
event</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
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
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Friday, September 26, 2025 14:55<br>
To: Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;<br>
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
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ya=
ng Wang<br>
Sent: Friday, September 26, 2025 12:04 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;<br>
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
Signed-off-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
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
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB780416F186166F39E61F39DD971EADS0PR12MB7804namp_--
