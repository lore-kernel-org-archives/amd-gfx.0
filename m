Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D84ECD9A8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2721210E08C;
	Thu,  5 Feb 2026 21:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dh8Vrftm";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5298A10E08C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7Hi3W7l3xOQB2BYwXT/VltxYXKedNH2xvJdAccnIYKHDvZtqIvH/OYLbhtB9zuicFFvl9ZwB4YzNlh7XcNDwGVUdYBLHv7ipqo2UZcDlneusJ403FrnpBOXuS/y2hyeSPDpL3lo7UdF7TBwtWrNrEh4zt6IzDTwWZdyomHRbiFHBHivzW3rmalEifAE2PK1NXoc7Ulq3gJiHBxWljIxyvWhgRB3NdpcX7Zsq00JEbPiyFWZ50xcZNBiwpe1Cs5YtUZya1YqKs2Yo9lnDufbXD+SlJKqgxpoXhV+Aq3/yl5HYepd7Vg1EGBhf64jJM4e+2EEunvt2vpAS106eFjo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx47cPRHws6TPSaoE3vGABIYTZKFDdR45itODHe9Qsk=;
 b=GzpgPuJpn8W63c3+smvHMbgv/vAV7lATdIAm1cWv4LZmU3pxVJJkY6sDiwGV/VobSTPzKhQEf4uVg+Z9CnZcsJTRP0rP5rwUs2BkRi23/52v1zTO9drkkGceXHSb7iMbBYCQYvxYoKbROhzxBZM59bQ5EV7lvsKi9YGzrlqBquGMKuRS9JuQzUno1vHjhxUTFRVCXzAsRBxUVrLQ9+Z5PKzhH/G8RRvNtLdf6o4QAEu0Hs75czR3HIQgMoycV4TwksfzV7zehyEDDFiFQTNxbqDM/gVLb2K/E+k0PR0MS3skrBUT/NbO3Lxy+DCNebgeLgwI22oJdvD0lCmd2MONtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx47cPRHws6TPSaoE3vGABIYTZKFDdR45itODHe9Qsk=;
 b=Dh8VrftmmjmTRfZp0mcjTkx5caIxNtwBZZ7wastuRteOvho9ZrQrLP0fLTehEAkcjjC3cR8ZgB4/I2fVQp36h5UNQiwxhxYpADjooxFmW2jp8Rvwwrot4FuHlSqCXSQs5vGD3J9j9f/poyd3GYsXJi34qV3QlRpMQpjS1CXk0Ss=
Received: from CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 21:27:50 +0000
Received: from CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f]) by CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 21:27:50 +0000
From: "Liu, Alysa" <Alysa.Liu@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Topic: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Index: AQHclryff3tf3+UVO0Ch0bihHrriY7V0Z4mAgAAknnCAAAtKgIAABw2A
Date: Thu, 5 Feb 2026 21:27:50 +0000
Message-ID: <CH2PR12MB405586950159A8A1284A6FD1E599A@CH2PR12MB4055.namprd12.prod.outlook.com>
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
 <f05102ad-0902-46ff-8bc2-29ed809b11f1@amd.com>
 <CH2PR12MB4055670B034D6220F3577151E599A@CH2PR12MB4055.namprd12.prod.outlook.com>
 <e3d0e7c1-df00-4391-af3a-b51c598fb86e@amd.com>
In-Reply-To: <e3d0e7c1-df00-4391-af3a-b51c598fb86e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-05T21:25:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4055:EE_|SJ0PR12MB7476:EE_
x-ms-office365-filtering-correlation-id: c03499fe-2ebb-4499-c60a-08de64fd6a2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VzBPT0VhRFRxUHN4Wk1ta3o2MlpMR2Q4L0xKM3RicnhQLzBDZ1FRUXA5bmtT?=
 =?utf-8?B?WUk5V3ZyMG9LY3c1VitCRkJaYUpVTGlVSzMzY0pXaXZPZU5OYkRsZERUMmIx?=
 =?utf-8?B?bTUzbDFoRGJoeFd5N0dwUUNmTE0vVGFqVVVLWGJQRXg0QmJ6WFRsTWFpKy93?=
 =?utf-8?B?OVk5S3NxdDFvVndFYUwyOVUraCt3SVg1cmI1MHpHRkw0amRTM2lHb0xuU1M3?=
 =?utf-8?B?TjdIa2xKRnR2elAvM1grelZuQ3dwNVl6RGtScE1zVGp2OUxORHF2YW0rQTZQ?=
 =?utf-8?B?ZlN0K1N4MVFOMFpKVm5QZ2ZFb2EybUtrcm1jNUNNYXlvdFc4REl5T0l1dkgx?=
 =?utf-8?B?bkdNNHJ5V0dBQUs5N2pCOXZWR3MvbDNKNzllRzgrMEdwWDdLMTRJb1A2Rm8v?=
 =?utf-8?B?ZDRkMldhd0c1UFY5WFZDTi9DY0lhbWZCRXBWM2RBV2JBNmpNbGJFM0ZTOUp0?=
 =?utf-8?B?bTkxcVZuWFM5UHNmbHh6dHN0elB5dEhZSXlpd0E1VGJDM0lwektxRHpVWVBQ?=
 =?utf-8?B?U0s0LzZkYnZzN2Vaa0lPVjFmVGN4SCs5QXJ6T0o5UmtRcStVYnUxdmpqYjJP?=
 =?utf-8?B?Z0o1Q0FRamNkN0lReG0rbGhFM1RkajQzVzF0Z1U4c0FiK1pPeUNFVnRqVXJs?=
 =?utf-8?B?ditHaTdZUVFmRGN1RkdlTmx4Rm8zYjM5K3E3QTNFVFpwOXF2MFFwdEkwZmZ2?=
 =?utf-8?B?MXZDcEJ2UDdpUmcyVXhKNVczeFJVNDVrbTgxbEJTa201Ym5DaTVpWmpTdGFh?=
 =?utf-8?B?TjhWdlRkYXprNzR3eS93Z0hSbWlad0JwTzV0US9sU3ZKdk1rcWZoTHU0U1l3?=
 =?utf-8?B?L3hyQ0U4OEFSMzczR3hlUzJuM1JldkdRQk0vNERSd1NMdnlwc2s2QXN2UmRH?=
 =?utf-8?B?SDNVZUhzYVE1WXdDc1ZLRTVVK3RvMDlZdzg1eVBKWm0zYVRaUHJCczZTa3Jp?=
 =?utf-8?B?M2gvcTZmcXkwckNSREVyMWxrbVc5TGJZVDhKMU16akE3bVZhaWhkdU10ZXkr?=
 =?utf-8?B?S1JIQzVLb2JMc0NuQXJ2TkFNT21JT0xwcUVmaUZFZGpsbWkyZ3ZsdTVVR0lB?=
 =?utf-8?B?MWM3b2Jaa3dUd3dOakZtRHozaWEzVU44R0dsNU0zZnByWkRXdnJOVnJPZWwy?=
 =?utf-8?B?eVJWQ2NRUnVrRmcwRDU1Nmp5R0JoSG5hV3YzMnNFL053WkI2ajcrVVJyaVcw?=
 =?utf-8?B?alA0YTVFdHRPWG03NG0yLzdpZGdxb3NvNnBxajZqaENiLzNaSUlGcW5oTDk3?=
 =?utf-8?B?U2ZNdW1nUWs0VXQ1eGRsVUtSRVI2NEMwczVkbFZkb0c4Zi96Mk1iMVNVVnEy?=
 =?utf-8?B?WnNNY3ovWTNxZVlISWNqaFJSRlUwVjNEeENUOWlkSDFJdU1Ga01zL25Gaisw?=
 =?utf-8?B?ZEkwTmhCOHVLbFltSDYrcjJGNGJ3QVBBQXVPdHdXZjk5NjVuVzE1eHVqdEd0?=
 =?utf-8?B?RVlucWc1ZDBKdStlZmZUazNRNGZabDRxMkZxbzNSSDZVdDFSdHlNODFLQ1N2?=
 =?utf-8?B?dG4wMVk0dWZ5UUVNVzFUMkFLbjlyRWhDY0puZDdsbmMyWE5zcUxGRzA1cTFl?=
 =?utf-8?B?RmM2MzhqWVQwb1Q2S00vWWdKdEtMcHpJd2JrR0lPOWE1U3Z0S3o3QTlxRFpk?=
 =?utf-8?B?MUtySy9XMmRva203ZEEyTGZOWDA0Zk5aSHgyV21BZkVnUFhCL3l0TmtYb2Q0?=
 =?utf-8?B?Y3JkTmNJZnd3bVNZeEMzUUp6dzNueTVCQTRZYlhYSC8xWk5HclFOZ2lqOTQ5?=
 =?utf-8?B?KzQ2ZVkyT1l1S0FMalViQy9hY0dLN2RnTVBkajBhcXl2WjhqTUIvaGJzcFhq?=
 =?utf-8?B?dktXR3FzY2Y1THlITGRQTkpGT1lPZ0FPTDMzNGVEcHQ2dmhiU1NlU3NCUGlE?=
 =?utf-8?B?bUFPT1VXeS9vNnlrMXZJalluc3hPVmhBMjJZYVZLelhJUHBQQWVLejNuN2RF?=
 =?utf-8?B?TWdjNURWWnRNNFlXb0M4a0pSS1dnOWVTQlVPZGdNNkFUZ2FHUytQOUNWa1Vq?=
 =?utf-8?B?bmpPK2JJSnNHTzkvMktWOFlJTVpDYjAzVlh0eG4zdUZydzFDR0xOd09iUVlB?=
 =?utf-8?B?Z2l4aFkrdU5ubTBxaXZhVG5zV284NUxGRmtNTGxLeHo4WU9oRVpzRnpCYWxl?=
 =?utf-8?B?Sk9VTEp5QTdmT3VHTXZyWEJDUTBUWkZ0QXhkbm5LRmJwZ1JMUjNMZFRBUzNU?=
 =?utf-8?Q?bVsSPZqJaK+lJXon8+tq/ok=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHQ3aE1Ody9SSE9qV0FzT2IvRytBUmRCYnVQS0R0ckdsTSt3cEhsZHYzb29v?=
 =?utf-8?B?bmJWMzNzUmNLNkxWS3ZPL2pGTWJvcnNWNXg1THdOd3NUUVc2T3NVQVZ0QnBP?=
 =?utf-8?B?dkd6aEpySm9TNU9EOWZpdEM3NVh5VkJmdHR1NWVnZUpVQ3F0SWY1dmlkbVNm?=
 =?utf-8?B?WmFwSXh2VzBoMzdyZDV6YWQ4c2JYK2Fsa1pzSlJJN0hadWYySXU3TFVnUXpt?=
 =?utf-8?B?ZVNXeTVGekxpdE14V0s5L1EvVFltYkx6UDRJaFkzK1ZTVThneExDR1hpUlVF?=
 =?utf-8?B?TFBrOG9iVU1EMUFxeFFqQ0ErUkF0WndvR1dZM3V0UGxJZUM2UVI2YWhmTlh0?=
 =?utf-8?B?Y2lvTW5QYTVDbmlsN0VTcFluZU1qNEpNQkhQNTBlRVk0THlIQklwWlU4WjVN?=
 =?utf-8?B?Y1dKU0ljTlcwMWJkZVQrTXV2SW1LSGliTWFoODA5cUM4RnpWL1liZ1VSTzRX?=
 =?utf-8?B?V290Y3JTSnV5b3JuUVNCbEQxN1U4UGZybzE4M0NrSU1FcExhVm5ka0k0bzRn?=
 =?utf-8?B?SmRKbzcvV2plU0ZjdkVKemFNZ2hLMEFsQThCL01XaXFtNEhzRk5mdzZyVXMw?=
 =?utf-8?B?bHJqMWJQMnF3bSs0ZGI4QWh2cHQzMi9UVVJoaUlsOHV1TUhPYW5DRy9sazJz?=
 =?utf-8?B?WWhrN2x1U0ZoYk9IbFdSaWsxV2lWQmw3YzJwWFlLdUt0MStyVUFReVFkeFlP?=
 =?utf-8?B?WkRObzlVZUdOYzRqbmdoem9uSkF3NXZHcUZycUJaOXBHYnBmakxkay80c2wr?=
 =?utf-8?B?SDUrMGIvUFhnTDFrRnpNNVJTT0x2MnB0TU5JcDNBeC9mcngxdDZZQjV2VW1K?=
 =?utf-8?B?Ni9JWHpYWTNWRGFmVldoZllhMlFDQjhIT1RsbURLZUhpdDNRaVppUnhRZWJR?=
 =?utf-8?B?YnArWXVPTjBBUGxpQjg2aUlQTHk4OXNUS1ZyK3BaK0wzaXRMMGZERjlQL0RN?=
 =?utf-8?B?WEFBU3ZLeklyU3FTdE51WFR2Q1BkMGtLNjB2dSt6MzNSR0JjN2U5MzJublVT?=
 =?utf-8?B?TFk4MlQvVmx2WFdtbHE1T2I5RkswNkJrejVWajZtbGZCeUM0Qm0yTVpWZzly?=
 =?utf-8?B?N0ZrMWxFRUMvUnVDZk9EYU5zT1o1dDhNbVI0QWM1dnIzT2JNVnEvdmFQaHgx?=
 =?utf-8?B?Qm9VNUFoN1BsTzA1ZXdlYUs2WTg4RktmYnJoVi9JSlFlbk5CUE8zSTJWRkVC?=
 =?utf-8?B?cmQwRVRLcTEwUVB5enpnZTlkMjFoWjd1RGRwY3R3YWlUSkJoSXBKOVJCbmR2?=
 =?utf-8?B?WmNvUytmWldjNW1sSEFCQ0c5TnBMS2lkcXZucDhRNlVIc0JwUURNdml3ZTg5?=
 =?utf-8?B?UytBcjBVaUtwN1JqdVM1WlIzK2dnZVZvZmF2b3JNRThLZ1dHdzZnRUV4dy9s?=
 =?utf-8?B?S204U3hvUnRzWGwwbytjaThNVkhubnp2KzBHZkJUaDMxQzBxaDE1WlpkY3Fn?=
 =?utf-8?B?OTBIeSt3VVFxUjFCdXVGVkNsYlBDK3NXNVdsRTdIU3VpSzZIeitYMzhtNHRz?=
 =?utf-8?B?Qy90UWVXVmw1c3c0WjJLbmNqZjJiMFltUnVWRHlLNXUrQS8ySnhWMVczU1Rq?=
 =?utf-8?B?RHcyM1pLZW9RS0dmTjlWM0VKbDJRdm5qRm5uRHdxdS9NaHZKVlFDVGlRQmxj?=
 =?utf-8?B?SGhhSDlOUWRUOW1PcFk3UDNZWXE2cmE3ZUFrRHMyMnBEd29aRDVib2s3b0Zz?=
 =?utf-8?B?aDRHT3NsbmM0VnFuckdxOHBObHd4ekJ3SVpTMnFIRUREbHVJWVF1QkhHeUln?=
 =?utf-8?B?bmorYkFXMTNYZ1NDT2ZZMFdJcUFXNVY0ZGhGdmI4SnA0N0xXTzJ0Mk94UTIw?=
 =?utf-8?B?WEZORmk1cmZZSjhZdFJCOFY1ek5FcFAxejlXRUVCSFRPVUlNSWI1Unpqc3B1?=
 =?utf-8?B?ZmdYV0EzUUZqT2tZTTJ4V3pBZjBXWjlXbWpRbHZySENib0M2VXI1OFRnMVIr?=
 =?utf-8?B?V2d2LzZBUGxiRzQ1dDE0RlpsSTlYNitMbGFtUmE4S05ZTnhWam4vbDc3eWJx?=
 =?utf-8?B?SEVEQU8wV2h1a05mVmE3WDIzRW9zaERpQS85MEVWMFRGTFYyS2FYdjNZaVUx?=
 =?utf-8?B?dkYxNjFvaks2TW5HTGxRaUNnU2RDWVkvK1lkZmphY2t0bklMei9oTzFIRnox?=
 =?utf-8?B?KzZ3VnViR0lldHBtUVFtS3RMVDlJb1FNUGpGRVZSVFNXNTdvcFJzMURrOHE3?=
 =?utf-8?B?ZFVCQVBQTE1RaDlUaTVRdEtacnVBYnpGMWp1UmY1eEZmYzF3bXNTTzFveXlo?=
 =?utf-8?B?TDlReDRGZVYzekRHbis0a0xmTzlMcWJEVVJPL09hQ1JmdjF4czRoYUxla2FK?=
 =?utf-8?Q?JW9bX1qmmk4sJ2cuaX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03499fe-2ebb-4499-c60a-08de64fd6a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 21:27:50.3360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wld/zvG9k++3ji6tZDnPhsWEMyckAIQyxDcwi8M2PVerMf7eiFXnV8LxCzqGPcbLhsM2cuiI7lGZQH7IpV1QyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgWGlhb2dhbmcsIHNoYXJlZCB0aGUgcHJvb2Ytb2YtY29uY2VwdCBleHBsb2l0IGluIHRl
YW1zLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hlbiwgWGlhb2dhbmcg
PFhpYW9nYW5nLkNoZW5AYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA1LCAyMDI2
IDQ6MDAgUE0NClRvOiBMaXUsIEFseXNhIDxBbHlzYS5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2ggPEhhcmlzaC5LYXNpdmlzd2Fu
YXRoYW5AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB1c2Ut
YWZ0ZXItZnJlZSByYWNlIGluIFZNIGFjcXVpcmUNCg0KDQpJdCBpcyB3aHkgSSBhc2tlZCBob3cg
aXQgY291bGQgaGFwcGVuLiBJcyB0aGVyZSByZWFsIGNhc2U/IElmIHRoZXJlIGFyZSB0d28gcHJv
Y2Vzc2VzIHNoYXJlIGNvbnRleHQgb2YgYSByZW5kZXIgbm9kZSBpdCBpcyBlaXRoZXIgaW50ZW50
aW9uYWxseSBvciBmb3JiaWRkZW4gYXQgdXNlciBzcGFjZS4NCg0KWGlhb2dhbmcNCg0KT24gMi81
LzIwMjYgMjoyMiBQTSwgTGl1LCBBbHlzYSB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25s
eSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gSGkgWGlhb2dhbmcsDQo+
DQo+IEkgdGhpbmsgdGhpcyBpcyBhIHNlY3VyaXR5IHZ1bG5lcmFiaWxpdHksIHRoZSByYWNlIGNv
dWxkIGJlIGludGVudGlvbmFsbHkgdHJpZ2dlcmVkLCBzbyBpdCBkb2Vzbid0IG1hdHRlciBob3cg
dGh1bmsgb3BlbnMgcmVuZGVyIG5vZGVzLCB0aGUga2VybmVsIHNob3VsZCBoYW5kbGUgdGhpcyBj
YXNlIHNhZmVseS4NCj4NCj4gQWx5c2ENCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQ2hlbiwgWGlhb2dhbmcgPFhpYW9nYW5nLkNoZW5AYW1kLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEZlYnJ1YXJ5IDUsIDIwMjYgMTowOSBQTQ0KPiBUbzogTGl1LCBBbHlzYSA8QWx5
c2EuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS2FzaXZpc3dhbmF0
aGFuLA0KPiBIYXJpc2ggPEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IHVzZS1hZnRlci1mcmVlIHJhY2UgaW4gVk0g
YWNxdWlyZQ0KPg0KPg0KPiBPbiAyLzUvMjAyNiAxMDoyOCBBTSwgQWx5c2EuTGl1QGFtZC5jb20g
d3JvdGU6DQo+PiBSZXBsYWNlIG5vbi1hdG9taWMgdm0tPnByb2Nlc3NfaW5mbyBhc3NpZ25tZW50
IHdpdGggY21weGNoZygpIHRvDQo+PiBwcmV2ZW50IHJhY2Ugd2hlbiBwYXJlbnQvY2hpbGQgcHJv
Y2Vzc2VzIHNoYXJpbmcgYSBkcm1fZmlsZSBib3RoIHRyeQ0KPj4gdG8gYWNxdWlyZSB0aGUgc2Ft
ZSBWTSBhZnRlciBmb3JrKCkuDQo+IEkgd29uZGVyIGhvdyBwYXJlbnQvY2hpbGQgcHJvY2Vzc2Vz
IGNhbiBzaGFyZSBzYW1lIGRybSBmaWxlPyBUaGUgY2hpbGQgcHJvY2VzcyBzaG91bGQgY2xvc2Ug
cmVuZGVyIG5vZGUgYWZ0ZXIgZm9yay9leGVjLCB0aGVuIGNyZWF0ZSBpdHMgb3duIGdwdSB2bS4g
VGh1bmsgb3BlbiByZW5kZXIgbm9kZSB3aXRoIE9fQ0xPRVhFQy4NCj4NCj4gUmVnYXJkcw0KPg0K
PiBYaWFvZ2FuZw0KPg0KPj4gU2lnbmVkLW9mZi1ieTogQWx5c2EuTGl1QGFtZC5jb20gPEFseXNh
LkxpdUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA2ICsrKysrLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiBpbmRleCAwMGVhNjli
YWExMjYuLmY3YjIzNThhMDMwMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiBAQCAtMTQzMiw3ICsxNDMyLDEwIEBA
IHN0YXRpYyBpbnQgaW5pdF9rZmRfdm0oc3RydWN0IGFtZGdwdV92bSAqdm0sIHZvaWQgKipwcm9j
ZXNzX2luZm8sDQo+PiAgICAgICAgICAgICAgICAqcHJvY2Vzc19pbmZvID0gaW5mbzsNCj4+ICAg
ICAgICB9DQo+Pg0KPj4gLSAgICAgdm0tPnByb2Nlc3NfaW5mbyA9ICpwcm9jZXNzX2luZm87DQo+
PiArICAgICBpZiAoY21weGNoZygmdm0tPnByb2Nlc3NfaW5mbywgTlVMTCwgKnByb2Nlc3NfaW5m
bykgIT0gTlVMTCkgew0KPj4gKyAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPj4gKyAgICAg
ICAgICAgICBnb3RvIGFscmVhZHlfYWNxdWlyZWQ7DQo+PiArICAgICB9DQo+Pg0KPj4gICAgICAg
IC8qIFZhbGlkYXRlIHBhZ2UgZGlyZWN0b3J5IGFuZCBhdHRhY2ggZXZpY3Rpb24gZmVuY2UgKi8N
Cj4+ICAgICAgICByZXQgPSBhbWRncHVfYm9fcmVzZXJ2ZSh2bS0+cm9vdC5ibywgdHJ1ZSk7IEBA
IC0xNDcyLDYgKzE0NzUsNw0KPj4gQEAgc3RhdGljIGludCBpbml0X2tmZF92bShzdHJ1Y3QgYW1k
Z3B1X3ZtICp2bSwgdm9pZCAqKnByb2Nlc3NfaW5mbywNCj4+ICAgICAgICBhbWRncHVfYm9fdW5y
ZXNlcnZlKHZtLT5yb290LmJvKTsNCj4+ICAgIHJlc2VydmVfcGRfZmFpbDoNCj4+ICAgICAgICB2
bS0+cHJvY2Vzc19pbmZvID0gTlVMTDsNCj4+ICthbHJlYWR5X2FjcXVpcmVkOg0KPj4gICAgICAg
IGlmIChpbmZvKSB7DQo+PiAgICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KCZpbmZvLT5ldmlj
dGlvbl9mZW5jZS0+YmFzZSk7DQo+PiAgICAgICAgICAgICAgICAqcHJvY2Vzc19pbmZvID0gTlVM
TDsNCg==
