Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B030CCF9EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 10:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E36510E436;
	Mon, 27 Oct 2025 10:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IITiiaJr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E54A10E436
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB0ES47YZZHG1V/uBsyD+ebvUCCka7mB02WioZOdWrElH1gPzRg0LzFhe0EsV8TMXzULbLLwwR/gr7NZg1gUPQhzgk7h+toF5XbYEVb95QufroECLhrHvZGxCbO7aEBjl8E1j0oxMv83x5qcdaRQyUxtXbmcDkCmsNbd4d781qyyYU+WTtKdh3Dd9NQyG4Dk95BCjlCdkpzL5mx9tTBWIvDDxexydWiS3IFlOcFGPPgVvqEpR0WWr7ED2tvG+PgFnOdPwV7yPF3RtB9oHdMtJpG4Lvag58Lg6zDGWGiKnDossBFzWAOzj93y/bpn0lQFMbV41rG6uxPyzI0Wpj/oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPz+JNCtrufKrkrMb6jcsKqeWYNtpBRFMV11rAHIX1k=;
 b=uyk43o0kVJiu+c0ktIAZZgSLR+mTWFpnzh/Dgd1opMfZPDVjg5thOCBXIjPHdToxrH4Hq1HzFW8sodg00btI/JxV0Ln1Y9J73oAra3D67LbvI0RBShGzzV/xd+YkMobTT2CzB4gIxKloWiQ0JbbRQACFQEweVxZ7HmtpcR1sLziRsx4JHKrDZQLn4BZuHuP+59NTUHO0SL6Dg7PnICVnLY65RXhzkKaJpk1wiXh8Sl/hZeLAbjvt+HdzSPkQ+73pbwjEcZW+F1NCraYuW+wkazMtA9h3qiB0KcMXKMP8HM68yH3iVCGQYJNjfEWFriwgtRo2cLbNl3GettRmqe+/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPz+JNCtrufKrkrMb6jcsKqeWYNtpBRFMV11rAHIX1k=;
 b=IITiiaJrVXufkoGZhqB3FdsTFC7/D6L0ltVSXZ3YYy25NnVVGnTM7PV3ENsOz2ibFGr/mnFaXOzYAzi/+fJWue8TXeGiE/uvaFerN9vA+L+UN3bMEwZrmCbBmUxk2Sl5RMe5YgO8rmtXj44Tnt0DJubJdB5LLYl2JMXuL0TZjs8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 10:30:17 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 10:30:17 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: fix the issue of size calculation error
 for smu 13.0.6
Thread-Topic: [PATCH v2] drm/amd/pm: fix the issue of size calculation error
 for smu 13.0.6
Thread-Index: AQHcRx1WN6cYIj8DtE6OcJHiH4yQ9bTVsbWAgAAZauA=
Date: Mon, 27 Oct 2025 10:30:16 +0000
Message-ID: <DS7PR12MB607175638B0A3D6D97B4D8D78EFCA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251027083956.1278788-1-kevinyang.wang@amd.com>
 <bca90d96-ac78-472a-9d63-5e84cea5163c@amd.com>
In-Reply-To: <bca90d96-ac78-472a-9d63-5e84cea5163c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-27T10:30:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: 4815f7b8-b298-4e77-7632-08de1543d266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?U1Y5bktzdkdOQUtkVS9jbm5TK3o4dXNpRzY3OENWYTBTaVdJMzhuWWl3cXND?=
 =?utf-8?B?c3QyTUlGZ0F6OEtQU1BqSUIxc2k4K0hMaU0xdlRpRHBuc0ZTdWlsbXFWaTVk?=
 =?utf-8?B?VEtJY1RTcmxJRkhYZ3gxVlJPT1FhK28vaGRPWTNQc2FOc0ZCK1ZCOThCb3Js?=
 =?utf-8?B?ZnhKZ1lwa0JVZU12U3l1WUdyYUo1MThoU1VOYTlPQmxqcXhwSllHMUhXQ3lV?=
 =?utf-8?B?VFozcy85Tzd2MFJFYnZFT2FmdlVhUGY5encyUFBHZG9vS2dnVDdtU2FxNzRD?=
 =?utf-8?B?NUl4cmpFR0pDV0ZrcndtN0syYnpmYXRvT0lYOXpxN3NmTUNoTmhRME1GcU9W?=
 =?utf-8?B?QmpQM1RwSTJPU1VpWU9WWWIwRllhUTdKQllrM0R1T0ZkdnlvOFp2WHZ6MVND?=
 =?utf-8?B?MGdENks3L3o3Z0srK2MwbFlVM0JETzA0RWRLVTNCWXhJSGVqeEFadzdRTWJh?=
 =?utf-8?B?L1hLRGtETmVncnplS3pHWEphZHNKSk8wSmNwazRyREhRdlJUcmREWU0rVnJQ?=
 =?utf-8?B?dUllYW5vVzlmM2NZY3p0WUgyRy8yeU5DVGZpdGFlVDFRd24zNVVWZm9lMXR3?=
 =?utf-8?B?aG8yQlpLQmNXb0NNWHZQSUxFRjduZlgwYUQwUmc4ZXB5RGdOb2tBK2p2OTN3?=
 =?utf-8?B?YUFPa29HMXR5Z25xZ0hWR1lQd2M2eTZ1eTRPZzBFODZFN2dFaXEycGFYRXhm?=
 =?utf-8?B?cVcweGJKYmU4ZkRWVDVzNkphMVZCSGhqODR0TkVjNUh0OEg0VEUzU2k1YUg0?=
 =?utf-8?B?S0xvWnpjamp1WWlRb3cvRHd0cjB1NmcraVlwa3RxOERnOUZhcUZHQzAzUVFw?=
 =?utf-8?B?ZFBQMC9SdHp3WmtiVWI4Rng3YXlBYkZJL0FDZFEwTnV2RE1XM3B6dzJzNkdI?=
 =?utf-8?B?WE5PN3k3SlJFRFpNc2IvdUN5S3F4Q0pyVU1rUi9GN05LNlNiWHFON1dkbGFr?=
 =?utf-8?B?N1YxZFhrMTkyMmp2MHYrM1c5ZUJERjhmM1dzZElwRGNZSnNxQm9scWQ4RFZx?=
 =?utf-8?B?SENQYmdybEgvSlh4TjBlME9aNVFYeFhRL1pud1AyRjNmMnQ1bXVwMmMzVXp3?=
 =?utf-8?B?TzV1aUxTNlNxUmI1dUIrL0pIQ25lUjB0TTBtalUwZHlFbFhSZnNKRU9PbVVn?=
 =?utf-8?B?T1VUNGU4YlROdmRndXpJTHIvVjZGbkluQTAvYWZneUhKckZLL2lvTThnREo4?=
 =?utf-8?B?OW9xaHdMMjNNT3hRNm5ZSDcybXpzVVlUcmpJeTRoRVVJdDliOUxCN2JpNzB3?=
 =?utf-8?B?VER3WmNiSmNVTDNNQlU5empqakwzWFd0dmRhUE9ZcUJkbnVsT0JFd255MjB5?=
 =?utf-8?B?cDlydE8vK0tkYStiYUxQSTBqaDhJYjVrVURQQ3h2QkJXZ1hpV2hiT1Y5ODlV?=
 =?utf-8?B?YkFLdS9KWmpWK2RjaXpCaXlTcEpUaVJtUDliTktqaUViT0RQSGU1QlZZVnZp?=
 =?utf-8?B?WkJMdVJpMzVYeFVORS84WlVTZG1MenpXS2wwRVMzSG43VVRpbzI0UFB4L1BI?=
 =?utf-8?B?VEpTdGFyZGdIRlQxYmV4NzlLOHNYL1loNi82cmtVSGE5d1hFd0Z4NzdEY2NT?=
 =?utf-8?B?aitJViszMHVjNFBPZEdpQ1ZVTFREcHJ5clVSRHlTZlF1YlpGbVJpKzFpZldS?=
 =?utf-8?B?RXpHeW9EU25wa1lnZmxlMGRrRXkwa3ljWXo2MkZzKzJ6TDdZMUNNaTljNXFY?=
 =?utf-8?B?eE4wMDNIZ1haNlNEa3ZjVUwvN09ta29wQ0FMSXdSZVMzTEdmUWs3RnVEeVg3?=
 =?utf-8?B?QXRzT1ZXMHhxVndKazNsYmxBK3h1QmVQVVk2VVdaY3NRWEI3RWJWUVBRbjVY?=
 =?utf-8?B?c2xWdjNHWk9SdWx0cDMrUFNvRlRjNHVaZnJMVElyY2FMSzUzcnJiS04vczNP?=
 =?utf-8?B?VFh0T05GaHBUZXQrcCtSL2hOcmJFQ3JSRlhGZlgzL0t1emtvRkt1Qng5bDBw?=
 =?utf-8?B?TmZoYVV5K0pnL3gyTisrSzJlaEM1WjBFaEdDcWdkQzhVVFp3Z1hKQ2ZTQ2wr?=
 =?utf-8?B?Nm1BM1BTQ3RhM2VGTml6YklaQjJyNWsrSmVOdkhtalExb2RDYUVLSHQ5cFBq?=
 =?utf-8?Q?r7j0oJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDNvazZURkMyZ0RaNE5RUXgwSXd3dzJZQ2xpWldyT0hZREIyeVVxVmw2aEYw?=
 =?utf-8?B?bGpudHVDU3NHWk9ZNGd1OVJnZ2dTUmk2Q3FadTZUaVVuYjhaYm9hWUJCOGFl?=
 =?utf-8?B?REZlYVBITUFoZW5zOFZlTER5Q2ZqdG5MbS8zRk1TSjJ6a0lUajIzU2VncGhY?=
 =?utf-8?B?SnJteS90dzEwQzIzUkhiK0lua0Q4Q0JVV2M3UnV2Sm41NG85b0JxdEZGVzha?=
 =?utf-8?B?YURtWmFDLzR2elZYTEptdE9IcTNvazI2d2M3TzhsNTZ4dDh1SzhkK2FpYlhG?=
 =?utf-8?B?dCt0MmtvNEJ2L3B2S3BXSTBIVS9yV1NXNXZ5NzRPL1pIWll1YnJkODYwYVRq?=
 =?utf-8?B?RUhVSDFZVjh0UnlDMzNxK0d4WEFqdU1wUGFYK1laNXBvUkNFeWZRVVVsTGpJ?=
 =?utf-8?B?SXBEaEh1UU0vMjJYTnBvNVczZm5jN0lwRWltWXRtWWR6UVp5QzdCWkx6ZUxG?=
 =?utf-8?B?bTVrWlFBMWZmZXN6eXhLUjZiZlFBOVRqSitnRGRhOTdLei9WbmE1eGNhZGZp?=
 =?utf-8?B?RmxkUEdQNThKTUI0b3dVb0QzMlVHOEt4QVc2K1BNZ1dpamYwanJMUnBpS0VO?=
 =?utf-8?B?eDN2TXY5RnpRemRidU15aEhMd3QwcURPak9CcFV3NzVJTGprZDI0bFR2N1pD?=
 =?utf-8?B?eUhaZVExbHMxek83Q3VTZStGQXlBNStsZHFwaGdiVmt0Y0xCOXpKaGM2azJu?=
 =?utf-8?B?b2I5MlNWTndPMldiL0Zoa1NQSkVwVHY2UUMwclp1b3dvb1U3L0UyTE9uL2lE?=
 =?utf-8?B?MVVEU3Rwa0FlQmNudWVTdW5hSWNBSU9veWVLMXNzWVdjZlhGTUlJVlBENEVN?=
 =?utf-8?B?ZWpVOVZjcUc0UE5sdHV6WlFXMU5xNVBKeGREUEd2M0VDTTZyREtESkdmTW1v?=
 =?utf-8?B?ajJkcytObytvWmVnQkVhZEhYa2RrWWJjT1VldFhmU0hSbVA3ZnUvTUh4TXhi?=
 =?utf-8?B?WFJLcTV0S2Uvb0ZoV1RodUlMeDY2ZEM5MDNnWHgzRnF3dlpLZ2JSUUlSYmlr?=
 =?utf-8?B?T3l5UHoyK0l2RmZhUzlkK08wVTBNTlYzR0NLQWdXcnliYUxObVN2VWhtVlYv?=
 =?utf-8?B?Y0dQT0J0ZmdkTnFidHBEWHA1dWhteWppNTVJVnYxa2w0cmd0Q2pwMDI3b3Yy?=
 =?utf-8?B?a3lvT1JZS01udittdXJBcm9hM1FheVJlMXVCSThHSWU2dFhhcjdaeEJxNHpt?=
 =?utf-8?B?Vm05RkRRdUFSVlhiOEJVdnVSKzh0WlJ0MTBhdUZBTzRvVFZNU1l0b09MZWhQ?=
 =?utf-8?B?MnRkY1hrZXp5azZJTWtaY1YvSCtsN28xZXBEeklCQnZlaVdmZWxRaU8yS21n?=
 =?utf-8?B?Wml3TnJaSXRIRnRRL3hDNWxXYUFZd05YQkZDak1iUHZCeGFNK29aZ0xacnR4?=
 =?utf-8?B?SGRJcnVMcjdVY1J5K21yd2wyVlFiNlZEbkJvOTY5T3JydERqM0djblE3WlAz?=
 =?utf-8?B?TFBmRk9Fb2x2VlZvRjdtdWVLRCt1aWNndGtJRGZHZ1h1d0RXandGUWhLbXdr?=
 =?utf-8?B?eWlWSnlxOVI2THNqZ0JKeDQrN0dSRVUxNDJKbXViajJob1pVc1lWUmhEYk83?=
 =?utf-8?B?M2k5Uk9tdlIzV0oyWXFGK3h4L3hxRS84M2svSW8zcHc3dzBzSDR2OFZoaTFw?=
 =?utf-8?B?VitGcHJnbzBFcG9iTEtRYjRlRUVJY21lYW56VUR5RlpHcE5LaDgwMUJtVDVk?=
 =?utf-8?B?aGZsUVRYQUE2VjI1bDdZd25KdWVwR25mRjltR2ZUcHlCVTU3Rm83eVhxdEt4?=
 =?utf-8?B?cjNYbWw5WWFlTXJMYVYwblZRc1RPa3poc2tHUEQvNWZxZVFOcTNJTGFFNTJQ?=
 =?utf-8?B?SGFkVUx1ZjZPdjNGTlVLcG01aUJiSzhKSzFvT29QUnl4VldJbldib3ZqaVFv?=
 =?utf-8?B?VEo5WTFrK3RRWWkrYXpjMSt2VUJSb0ZJYzFKQmZnakZ6VXA5Y2JJbEd4K0NR?=
 =?utf-8?B?U1VGVmhqc05ybUI5T29UUmVYZm5lbEZrcWZQT2tLMkVnODVBb1VZMGpaSkxN?=
 =?utf-8?B?V3RxV0RzSitteW1ONW9Db2UyR2xRWm1GR1U2MXYvY2dKcGpCR3BiZ3VxazJ3?=
 =?utf-8?B?akd1WFdHdm0vb3MzQVpFS2x6OXJlb0pEYzA1b1BuTDc4RjNjUE9kemN3NFBZ?=
 =?utf-8?Q?ECrw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4815f7b8-b298-4e77-7632-08de1543d266
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 10:30:16.9640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxlFdnEN9IqzTj4JDU+l4ONp0zSdrsGlO0mPc89jjyqAsBvuf1BZ2pFFugp7LqqgruJfmHqSZ4AGytWCij4SIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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
Cg0KUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCg0KVGhhbmtz
ICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6
YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNywg
MjAyNSAyOjI5IFBNDQpUbzogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPg0KU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gZHJtL2FtZC9wbTogZml4IHRoZSBpc3N1ZSBvZiBzaXplIGNhbGN1bGF0
aW9uIGVycm9yIGZvciBzbXUgMTMuMC42DQoNCg0KDQpPbiAxMC8yNy8yMDI1IDI6MDkgUE0sIFlh
bmcgV2FuZyB3cm90ZToNCj4gdjE6DQo+IHRoZSBkcml2ZXIgc2hvdWxkIGhhbmRsZSByZXR1cm4g
dmFsdWUgb2YNCj4gc211X3YxM18wXzZfcHJpbnRrX2Nsa19sZXZlbHMoKSB0byByZXR1cm4gdGhl
IGNvcnJlY3Qgc2l6ZSBmb3Igc3lzZnMgcmVhZHMuDQo+DQo+IHYyOg0KPiBmaXggdGhlIGlzc3Vl
IG9mIHNpemUgY2FsY3VsYXRpb24gZXJyb3IgaW4gc211X3YxM18wXzZfcHJpbnRfY2xrcygpDQo+
DQo+IEZpeGVzOiAwMzU0Y2Q2NTBkYWEgKCJkcm0vYW1kL3BtOiBBdm9pZCB3cml0aW5nIG51bGxz
IGludG8NCj4gYHBwX29kX2Nsa192b2x0YWdlYCIpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcg
V2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIg
PGxpam8ubGF6YXJAYW1kLmNvbT4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IC0tLQ0KPiAgIC4uLi9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICB8IDQyICsrKysrKysrKysr
KysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTEzL3NtdV92MTNfMF82X3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KPiBpbmRleCAzOWFlNjcwMTE0N2MuLjFkOWNjMzg0ZmMz
MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVf
djEzXzBfNl9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L3NtdV92MTNfMF82X3BwdC5jDQo+IEBAIC0xMzk0LDcgKzEzOTQsNyBAQCBzdGF0aWMgaW50IHNt
dV92MTNfMF82X3ByaW50X2Nsa3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGNoYXIgKmJ1Ziwg
aW50IHNpemUsDQo+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+ICAgICAgIGlm
IChjdXJyX2NsayA8IFNNVV8xM18wXzZfRFNDTEtfVEhSRVNIT0xEKSB7DQo+IC0gICAgICAgICAg
ICAgc2l6ZSA9IHN5c2ZzX2VtaXRfYXQoYnVmLCBzaXplLCAiUzogJXVNaHogKlxuIiwgY3Vycl9j
bGspOw0KPiArICAgICAgICAgICAgIHNpemUgKz0gc3lzZnNfZW1pdF9hdChidWYsIHNpemUsICJT
OiAldU1oeiAqXG4iLCBjdXJyX2Nsayk7DQo+ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8
IGNsb2Nrcy5udW1fbGV2ZWxzOyBpKyspDQo+ICAgICAgICAgICAgICAgICAgICAgICBzaXplICs9
IHN5c2ZzX2VtaXRfYXQoYnVmLCBzaXplLCAiJWQ6ICV1TWh6XG4iLCBpLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2Nrcy5kYXRhW2ldLmNsb2Nrc19p
bl9raHogLyBAQCAtMTUxNCw5ICsxNTE0LDEzIEBADQo+IHN0YXRpYyBpbnQgc211X3YxM18wXzZf
cHJpbnRfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4NCj4gICAgICAgICAg
ICAgICBzaW5nbGVfZHBtX3RhYmxlID0gJihkcG1fY29udGV4dC0+ZHBtX3RhYmxlcy51Y2xrX3Rh
YmxlKTsNCj4NCj4gLSAgICAgICAgICAgICByZXR1cm4gc211X3YxM18wXzZfcHJpbnRfY2xrcyhz
bXUsIGJ1Ziwgc2l6ZSwgc2luZ2xlX2RwbV90YWJsZSwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBub3csICJtY2xrIik7DQo+ICsgICAgICAgICAgICAgcmV0
ID0gc211X3YxM18wXzZfcHJpbnRfY2xrcyhzbXUsIGJ1Ziwgc2l6ZSwgc2luZ2xlX2RwbV90YWJs
ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vdywgIm1j
bGsiKTsNCj4gKyAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+DQo+ICsgICAgICAgICAgICAgc2l6ZSArPSByZXQ7DQo+ICsgICAg
ICAgICAgICAgYnJlYWs7DQo+ICAgICAgIGNhc2UgU01VX1NPQ0NMSzoNCj4gICAgICAgICAgICAg
ICByZXQgPSBzbXVfdjEzXzBfNl9nZXRfY3VycmVudF9jbGtfZnJlcV9ieV90YWJsZShzbXUsIFNN
VV9TT0NDTEssDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJm5vdyk7DQo+IEBAIC0xNTI4LDkgKzE1MzIsMTMgQEAgc3RhdGlj
IGludCBzbXVfdjEzXzBfNl9wcmludF9jbGtfbGV2ZWxzKHN0cnVjdA0KPiBzbXVfY29udGV4dCAq
c211LA0KPg0KPiAgICAgICAgICAgICAgIHNpbmdsZV9kcG1fdGFibGUgPSAmKGRwbV9jb250ZXh0
LT5kcG1fdGFibGVzLnNvY190YWJsZSk7DQo+DQo+IC0gICAgICAgICAgICAgcmV0dXJuIHNtdV92
MTNfMF82X3ByaW50X2Nsa3Moc211LCBidWYsIHNpemUsIHNpbmdsZV9kcG1fdGFibGUsDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm93LCAic29jY2xrIik7
DQo+ICsgICAgICAgICAgICAgcmV0ID0gc211X3YxM18wXzZfcHJpbnRfY2xrcyhzbXUsIGJ1Ziwg
c2l6ZSwgc2luZ2xlX2RwbV90YWJsZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5vdywgInNvY2NsayIpOw0KPiArICAgICAgICAgICAgIGlmIChyZXQgPCAw
KQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4NCj4gKyAgICAgICAgICAg
ICBzaXplICs9IHJldDsNCj4gKyAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgY2FzZSBTTVVf
RkNMSzoNCj4gICAgICAgICAgICAgICByZXQgPSBzbXVfdjEzXzBfNl9nZXRfY3VycmVudF9jbGtf
ZnJlcV9ieV90YWJsZShzbXUsIFNNVV9GQ0xLLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZub3cpOw0KPiBAQCAtMTU0Miw5
ICsxNTUwLDEzIEBAIHN0YXRpYyBpbnQgc211X3YxM18wXzZfcHJpbnRfY2xrX2xldmVscyhzdHJ1
Y3QNCj4gc211X2NvbnRleHQgKnNtdSwNCj4NCj4gICAgICAgICAgICAgICBzaW5nbGVfZHBtX3Rh
YmxlID0gJihkcG1fY29udGV4dC0+ZHBtX3RhYmxlcy5mY2xrX3RhYmxlKTsNCj4NCj4gLSAgICAg
ICAgICAgICByZXR1cm4gc211X3YxM18wXzZfcHJpbnRfY2xrcyhzbXUsIGJ1Ziwgc2l6ZSwgc2lu
Z2xlX2RwbV90YWJsZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBub3csICJmY2xrIik7DQo+ICsgICAgICAgICAgICAgcmV0ID0gc211X3YxM18wXzZfcHJp
bnRfY2xrcyhzbXUsIGJ1Ziwgc2l6ZSwgc2luZ2xlX2RwbV90YWJsZSwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vdywgImZjbGsiKTsNCj4gKyAgICAgICAg
ICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
DQo+ICsgICAgICAgICAgICAgc2l6ZSArPSByZXQ7DQo+ICsgICAgICAgICAgICAgYnJlYWs7DQo+
ICAgICAgIGNhc2UgU01VX1ZDTEs6DQo+ICAgICAgICAgICAgICAgcmV0ID0gc211X3YxM18wXzZf
Z2V0X2N1cnJlbnRfY2xrX2ZyZXFfYnlfdGFibGUoc211LCBTTVVfVkNMSywNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbm93
KTsNCj4gQEAgLTE1NTYsOSArMTU2OCwxMyBAQCBzdGF0aWMgaW50IHNtdV92MTNfMF82X3ByaW50
X2Nsa19sZXZlbHMoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+DQo+ICAgICAgICAgICAg
ICAgc2luZ2xlX2RwbV90YWJsZSA9ICYoZHBtX2NvbnRleHQtPmRwbV90YWJsZXMudmNsa190YWJs
ZSk7DQo+DQo+IC0gICAgICAgICAgICAgcmV0dXJuIHNtdV92MTNfMF82X3ByaW50X2Nsa3Moc211
LCBidWYsIHNpemUsIHNpbmdsZV9kcG1fdGFibGUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbm93LCAidmNsayIpOw0KPiArICAgICAgICAgICAgIHJldCA9
IHNtdV92MTNfMF82X3ByaW50X2Nsa3Moc211LCBidWYsIHNpemUsIHNpbmdsZV9kcG1fdGFibGUs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBub3csICJ2Y2xr
Iik7DQo+ICsgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ICsgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPg0KPiArICAgICAgICAgICAgIHNpemUgKz0gcmV0Ow0KPiArICAgICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgICBjYXNlIFNNVV9EQ0xLOg0KPiAgICAgICAgICAgICAgIHJl
dCA9IHNtdV92MTNfMF82X2dldF9jdXJyZW50X2Nsa19mcmVxX2J5X3RhYmxlKHNtdSwgU01VX0RD
TEssDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmbm93KTsNCj4gQEAgLTE1NzAsOSArMTU4NiwxMyBAQCBzdGF0aWMgaW50IHNt
dV92MTNfMF82X3ByaW50X2Nsa19sZXZlbHMoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+
DQo+ICAgICAgICAgICAgICAgc2luZ2xlX2RwbV90YWJsZSA9ICYoZHBtX2NvbnRleHQtPmRwbV90
YWJsZXMuZGNsa190YWJsZSk7DQo+DQo+IC0gICAgICAgICAgICAgcmV0dXJuIHNtdV92MTNfMF82
X3ByaW50X2Nsa3Moc211LCBidWYsIHNpemUsIHNpbmdsZV9kcG1fdGFibGUsDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm93LCAiZGNsayIpOw0KPiArICAg
ICAgICAgICAgIHJldCA9IHNtdV92MTNfMF82X3ByaW50X2Nsa3Moc211LCBidWYsIHNpemUsIHNp
bmdsZV9kcG1fdGFibGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBub3csICJkY2xrIik7DQo+ICsgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ICsgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPg0KPiArICAgICAgICAgICAgIHNpemUgKz0g
cmV0Ow0KPiArICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICBkZWZhdWx0Og0KPiAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgICB9DQoNCg==
