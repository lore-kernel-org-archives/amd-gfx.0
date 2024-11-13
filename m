Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BD1D462A5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9164610E004;
	Wed, 13 Nov 2024 14:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/DogOLE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DEB10E004
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 14:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ttpc6ImBRjJfjNkm634u7DHun7Klvv7NNLyCFoPnxYNplQw6C9yAEk/ZLONYwgd9+HMMPmH8Wg3SLAF/1hrMHEQLJomHFvhmZioMxVIiWmK5IixO342V+lAEDTIGhMgilN4NGMz0qNUlamUyBvyx38fHgrEwG3dhqzB9SJN/e7S8itfCc3B2wp9O1M9s/fazZpvl/4nXEZ/zTGnHQ1oDejkGGwrGSs+3xpFDdbhooFsc7SnQel2xugUHMBZv3ha5FkI1avAwyD8Yak7LLuvReU+0+9Q7yHrKkxZNkuksWKBtVzt7cVjNuJrQBRDB/jHfc0Y5Un5upqJ0zYVoPgK3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGt9+7773mF3lWE4skqJB0gsItcvN9l3TWYhIUUAGzk=;
 b=JH9ZHzaBasQZlcHyTfe/yuxpIUGf0pRrxEOBZbbPRQLSkbuQ9zzMR2sVWHuXlOEKb3D1HCUqQfdJektNnHsw2y0Bpfvm/ad7yHVDAq5+/WrfH8Lmxl5Yfz/TJ+O9NcAwZ8Gaid7xJ0ZxhHDo5ncKr1OSVkSZvjhI0JY7Ky76JcrAKWT0VAPglVsMeWO39PSWYNTLnkJ6shekKgTAamgyOqoytgLOowcVdUWMqaCW39Qw8rFe+uqIypBWTF6Pca6zSXW/bOY9cZlBi/UrRUVVUjQF7n7IvujP8JR89b3GxmA+Tl3JdajjNdy+4+BaW/W7CNnPnrFX0zkzb/a8oatGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGt9+7773mF3lWE4skqJB0gsItcvN9l3TWYhIUUAGzk=;
 b=Z/DogOLEkKIeWU/BLt0inRURAfkZh3nz6MD6sOlAhs3ElZRJRIP5CcSChCGDigEKRE93UuXYjG2KrE6ASpCS9BhwJocn9DPyX8zE2iIJqcH2nxSgl2quSFcHApRPbtTXvGi2TAekNxYWIKmmORejho5YYE53zSe1pinGIKuFyaM=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:09:49 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:09:49 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "tvrtko.ursulin@igalia.com" <tvrtko.ursulin@igalia.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHbM4cm2Qy9C3gimkGj8UdltocsKLKze08AgABz2+CAAPuMgIAAVmGw
Date: Wed, 13 Nov 2024 14:09:48 +0000
Message-ID: <SA1PR12MB8599C03D7B92F3B24976552AED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
In-Reply-To: <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=26f92a9a-5b2c-4c56-be07-920f18c20850;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-13T13:58:18Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: b542c8dc-7fb2-4f3b-ee10-08dd03ecd5be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?enUySTlDbHlIaUYybkhxUlVUY3JEdGF0WnVBSUphT1lkQ2pjYy93cW5JZ0da?=
 =?utf-8?B?U05sUUdGSzRuWnRRcXdodHEvL1FGYjMvMG1ES0ErVWp1NjBvMVY2QU1HWnAr?=
 =?utf-8?B?Mk9jZERxTG9KeWxvOFNrdktZTVpZMjFzanYrQTRzWVdQOW9DQXpYRWtrS2kr?=
 =?utf-8?B?Q29rWlNmSlJpaHdZMmFLeGtOM29EUW9FV21FQmlMcE1QZGxnMjNHZXJiMGlL?=
 =?utf-8?B?NE9Tb25BQS9YcU5VYm1PM2MxRitVR09jOU5BU0RjTWNvQnRrQjFmeUt4VkdK?=
 =?utf-8?B?NmMvaEZ4dWMrSnBaNDE4MzhKMXlteitJdGZDWU9qbFRqelgrMXpJSENqYTFC?=
 =?utf-8?B?UCtBS3lQZlJjVGMvYmpYMkhseThFU3Z4bWg3OUhpbXFvZWtYNTlyWlhHRkxU?=
 =?utf-8?B?aE9hdVYvMlNxS0pERzBXMUdIL2h5NXJOYlJGQXg1R203QS9UTFdQQ1hSZGxj?=
 =?utf-8?B?QkNFYjNlU01tRFhmTWVQL24vVXdtbUdzRGx4RUhSQ2VXMU01MVorNHFpNlZP?=
 =?utf-8?B?UmxVMzVPMnVXeXVMTDVvRDZiVXVSRW9RTFFiQXAxNFJZcnZUakQweE4wYWpP?=
 =?utf-8?B?L1NNV0tVZnVhbGcveWMrb01iWittbkt6VUo1WEdZSFowNnFpd3hGRG1WTkdl?=
 =?utf-8?B?NzZiNHdWdGJ1UW1TWU9TTTl5T1Q2bktHMDVNcHU4M3l4VzRrQSt6eXN0bWxi?=
 =?utf-8?B?cWo1Q3Y1bVN2aGRVRGlCV3JmZnpQTVlYUzlTQ0hjb01IbTU5ZFNNaGpiR2Zz?=
 =?utf-8?B?aW5pc1NZdE51RVVFL1o3MnlvNmNkRHBTYTN2K2VjQUlYRHpHeElWZ2lWcHFK?=
 =?utf-8?B?VVdWS2VrYjROcTNDYzRvVGFwR2JTeTBPaXhjMEVTRG1XSE1ZQ2FaZG9aTjYr?=
 =?utf-8?B?eC9CSWVZOHEzSEVSd2puWHFudEpXU3BTT1d5MkdLL3FTY0g1NTZ4ZUdoYTZF?=
 =?utf-8?B?ZFZVcmhCeFN4TE1waWMvNXRNSS9NTnYwTHBwa0RIQkdqVnJOSjlVVlZUSzhy?=
 =?utf-8?B?bnZqWHRxSXlBYUZoaEMvVm1KSDhjSkRIeWMvUWdMWHR0Y3ZJZjZBV3lkTk81?=
 =?utf-8?B?T3Z3WFhVM0FQVmlQV0Z0cjNLRkNRNEJTdGo0MHZkQ2pRSUxRcU1DODNKcFlK?=
 =?utf-8?B?TkdXKzkxQUlZdU9XbmxwSytpUGR4ZkM0UzBQaDlOV2hhOFBrK1NqQWp3cEhv?=
 =?utf-8?B?VllBdnFSKzd3M1VsektLY1FnQVcrZ3BYQ2x5dXZmdXIrSzhwNGJCOGN1ZVha?=
 =?utf-8?B?UlZsTFRGR1ltamxHZXA3VWZ5WVlHSEJQQ1BUSVNjUVFwcm1OaE82K0ZtRGVO?=
 =?utf-8?B?aE5mQVdlcjBVN1h3MmNneERGblR1WmRieTY2bEhaNFVwa1NpeUc2MmpPNGVB?=
 =?utf-8?B?UHpYVDUwNVVxMmZDSzczbmQ3a25mM204RG4ra3REd1BtOXpyVnpLWmVpWTZQ?=
 =?utf-8?B?MUVJR2NSZmJhMHVhbUhHck4yN05NbHQ3aXhUWHYxQklaVWJISGdWeXlDSFhC?=
 =?utf-8?B?WktLcW1vdTZtZnZkMEI2NWV1TXphV2xLU2h5RUh4VlVpU3cyUlRXRDRGWnF6?=
 =?utf-8?B?bjVmeTlLVXVtSVUwVk9yTlRIcytpUldYd2FUQis3NjNNMmZZdno3U2JDZUVr?=
 =?utf-8?B?SitPRmVvNU93MWk3dy9kN2poM0hMSndhVS9UNm9aMkpJc3VRRUpkVWhjWTZE?=
 =?utf-8?B?dm9aeGR3K0I2WU1zRDlmN282cVFEcHQzYVFZZFZpWjQyLzd3YXpMencvVUcr?=
 =?utf-8?B?UnM0czV3UTQ5eGFROXBqVCtPSmtBYUdxdnpPT2lFTXpaVWlLbGlWQ1BaM2Ja?=
 =?utf-8?Q?kQVuosVJUVfRvNR9tPiKpKtQ2nbViBJ5ei2NQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHV6ZjJFQTkzZFJJa1NINHoyY24wRDdILzVHYkdBMzRPamM3S0N3MEU5T1d4?=
 =?utf-8?B?MjFWcTlwY1hEb2Vnb083bDM0OUxOQ1lOVWRWQ2JHSzFtK0FhTHRyK2dkU3Fq?=
 =?utf-8?B?dVIyTGhORWx6RXgyUUlVVkh3aXREUlV5MUFyekVnZFlEYW9KTkhNZVpDeS90?=
 =?utf-8?B?TjNxYWZoaDkxbklFLzdXYzNtcjcvcHBYWGhmS2N3NDEwMngzaHZ5SWZ4Y3Bu?=
 =?utf-8?B?V1hHVlZzSWs5WVJvVFlVN2l6RGYxZDJ6Mis4bThQTEhMRWhGMFFvdzJlc1Ri?=
 =?utf-8?B?YnlPUCtTbCtjc2pVczVVS3Bic1NkT2R0MVdKOWRtUzlJWHYxcWl1TThPL1Y1?=
 =?utf-8?B?dTk1MmFqZkFiUnhIMENmWGV3STA4OERqNzNiSWZodFowZC9MWkI4OEYzQU84?=
 =?utf-8?B?VmF4Wmg0Q0F5N1lWQWR6TDJmZk1TRnhnZklmbmswWjUvZUZJaVozNTVOTkMr?=
 =?utf-8?B?S3VLMUUxOHJ4VmFhRlZiRHpHdEp6UlNucnQ3N2RKVVc2V1ovZmNJbHVoNXRT?=
 =?utf-8?B?ZUdSbUYzOWtsbVNBZWlpeHpJMy9PcVlhREIwL0Yrb0JwaFkxSGFWeVVhREk1?=
 =?utf-8?B?MTdadkhFbnE3QmlaaWRZVG5HUXJueHZwamdiSDM3clhDMWVCMEhXUDlmUVZX?=
 =?utf-8?B?TU9PVWNpWnlRMDMvQXNGcHdSVXpLaGtaaXVDN0cvaG5kQUFsZTQzakZVa21I?=
 =?utf-8?B?K3JqeW1KcURkU3ZLSytFRWxsa1hMVWNCT3ByVmppcWszN1d2dE5mSjQwRTVE?=
 =?utf-8?B?WW0vOTFxVmZLR2praDVmaVNQcjVnOWdlaHNNNWF3TVdDdStreTVDSXhJZVVN?=
 =?utf-8?B?YXlnK2Vjc3R5TzRaa3FQT1JKcjl4Smk0ZzFWeUVieGtLbzEvclJoUmdKWitt?=
 =?utf-8?B?b0VCNmN1alcxMTNwbTRacWgvalA5U2RwR25ybEF4blFCaVU5UHkyTFYvNFZO?=
 =?utf-8?B?c2pMeHVCYUVBa21LWWhTQU1Ud2NyVlhiT2ZFaXRSM1E4aXFOMTYwZWo1YmQ2?=
 =?utf-8?B?cXJQZ1VZbzBCMTBXUXF4dFhhREZ6WitITHJUSmEweTBQU3FrVllWd1R1TWxP?=
 =?utf-8?B?citkSk5BZlIwdm9LUFZ2ZXEvWlNad2FMUGx4OWhubGRXVjM5bXU3TUxIQUFh?=
 =?utf-8?B?MWRTL3RVTmhNUDAvMlR4ZGJRS3NCcVl3RURDWVl1Z1lNc2tUOWttaXdRbkFi?=
 =?utf-8?B?N2NKUm0zQ25tcEI3RGVPUENKYXhPNWc3cGxDdmpRTjIzNUhCRlV1VTNjenNk?=
 =?utf-8?B?b2lteWVUV1ZreFBEUDBWU2NBQWQydm02alVIbjFCT0kzMk4ySGErUWE1Zm8v?=
 =?utf-8?B?MUJDZXhjQ2ttb3FlNE52WHcvdy92dCtsc3pZbG9CYkc4bnY4ak56UWFVOHhG?=
 =?utf-8?B?Wm9mSTd2dXhhNUdYMEY1SUxYYzBDQitKcEZ4cHRLZWhTV0VxN05FeDBHa3Qr?=
 =?utf-8?B?ejdCUVd1cWVGamlCZEsxMTI0Y0prdHgwWFlTNW1FNUtmUTdyeFVsRGM3RnVy?=
 =?utf-8?B?RmYvQ284eUYyWmRXcXVBQi9yTGVCa3BLcTBIbHpOWTFXcmhsdW5PcjdxcjRu?=
 =?utf-8?B?REQ0MG9ReWs3US9JVHkvNmVSWlIwWHgwcHRPd1lSOHZUWWVFaHVvSjZ5VmEv?=
 =?utf-8?B?MHNkUStId2RWMGtsQTBZMXBVUG5mcndiK1lYemNtY2s1UkdVbzhDdGRIdW1j?=
 =?utf-8?B?ekdqSi9hUm13WEgwUGVRUk5Pek1pdndhbmVERjN0eUxwNlUzdlV2N3NiLzBC?=
 =?utf-8?B?RlhLMU50Tk9xcnRhci9zYk1KZmFmMFh2eWprcDNybmthdmJTRk44NzJCbEpu?=
 =?utf-8?B?VWFqS3lsNVZIeVpzdWJPUjBqd2o2RlhXTDQrT2EzL3FwS3RzTFloOFhPSEkz?=
 =?utf-8?B?S05naVR0blRFWnIzTmFRWVd2VEduUFgzdjE1YVdEajIrL1FiMnk4VFo2eHAv?=
 =?utf-8?B?R3pEd0JoQUxCYkVKdEJBcWoxRS9kVldHMDRMT3hldktBUUFUWnJTbVRsY1BJ?=
 =?utf-8?B?YUprMml2TzNyeDBzbDdGUzhQV3NWcG1ZcGZQN2QyUEtmajd3VDV6NVUyUWNQ?=
 =?utf-8?B?KzZ3bThNRmhoYkkwQno4Qi9nQzR3UGlFMFpnOFdoa0RKcGtGN2FubDlqRXJM?=
 =?utf-8?Q?Io6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b542c8dc-7fb2-4f3b-ee10-08dd03ecd5be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:09:48.9343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lenFFjmgtSoGwpRkDAv6oQJ6A3aT6Iy2+1KjykjO+D8swlRIkZKiQ6cTs5EvNVUWXV2dREwcebk8Cjpcd733jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0IDM6NDkNCj4gQW0g
MTIuMTEuMjQgdW0gMTk6MTYgc2NocmllYiBMaSwgWXVueGlhbmcgKFRlZGR5KToNCj4gPj4gRnJv
bTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+
ID4+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0IDU6NTQNCj4gPj4gQW0gMTAuMTEu
MjQgdW0gMTY6NDEgc2NocmllYiBZdW54aWFuZyBMaToNCj4gPj4+IEBAIC0yNjEyLDcgKzI3MDcs
NiBAQCB2b2lkIGFtZGdwdV92bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4+PiAqYWRl
diwgc3RydWN0IGFtZGdwdV92bSAqdm0pDQo+ID4+Pg0KPiA+Pj4gICAgICByb290ID0gYW1kZ3B1
X2JvX3JlZih2bS0+cm9vdC5ibyk7DQo+ID4+PiAgICAgIGFtZGdwdV9ib19yZXNlcnZlKHJvb3Qs
IHRydWUpOw0KPiA+Pj4gLSAgIGFtZGdwdV92bV9wdXRfdGFza19pbmZvKHZtLT50YXNrX2luZm8p
Ow0KPiA+Pj4gICAgICBhbWRncHVfdm1fc2V0X3Bhc2lkKGFkZXYsIHZtLCAwKTsNCj4gPj4+ICAg
ICAgZG1hX2ZlbmNlX3dhaXQodm0tPmxhc3RfdW5sb2NrZWQsIGZhbHNlKTsNCj4gPj4+ICAgICAg
ZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF91bmxvY2tlZCk7IEBAIC0yNjYwLDYgKzI3NTQsMTUgQEAg
dm9pZA0KPiA+Pj4gYW1kZ3B1X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+
ID4+IHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPiA+Pj4gICAgICAgICAgICAgIH0NCj4gPj4+ICAg
ICAgfQ0KPiA+Pj4NCj4gPj4+ICsgICBpZiAoIWFtZGdwdV92bV9zdGF0c19pc196ZXJvKHZtKSkg
ew0KPiA+Pj4gKyAgICAgICAgICAgc3RydWN0IGFtZGdwdV90YXNrX2luZm8gKnRpID0gdm0tPnRh
c2tfaW5mbzsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgICAgIGRldl93YXJuKGFkZXYtPmRldiwN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICJWTSBtZW1vcnkgc3RhdHMgZm9yIHByb2MgJXMo
JWQpIHRhc2sgJXMoJWQpIGlzDQo+ID4+PiArIG5vbi16ZXJvDQo+ID4+IHdoZW4gZmluaVxuIiwN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgIHRpLT5wcm9jZXNzX25hbWUsIHRpLT5waWQsIHRp
LT50YXNrX25hbWUsIHRpLT50Z2lkKTsNCj4gPj4+ICsgICB9DQo+ID4+PiArDQo+ID4+PiArICAg
YW1kZ3B1X3ZtX3B1dF90YXNrX2luZm8odm0tPnRhc2tfaW5mbyk7DQo+ID4+IFBsZWFzZSBkb24n
dCBtb3ZlIHRoZSBjYWxsIHRvIGFtZGdwdV92bV9wdXRfdGFza19pbmZvKCkuDQo+ID4gSXMga2Vl
cGluZyB0aGUgdGFza19pbmZvIGFsaXZlIGEgaGF6YXJkIGhlcmU/IEkgY291bGQgY29weSBvdXQg
dGhlIGluZm8sIGl0IGp1c3QNCj4gc2VlbWVkIGEgYml0IHdhc3RlZnVsLg0KPg0KPiBBaCwgbm93
IEkgc2VlIHdoeSB5b3UgaGF2ZSBtb3ZlZCB0aGF0Lg0KPg0KPiBJSVJDIHdlIG5lZWQgdG8gZnJl
ZSB1cCB0aGUgdGFzayBpbmZvIGJlZm9yZSByZWxlYXNpbmcgdGhlIFBBU0lELCBidXQgdGhhdCBp
bmZvIG1pZ2h0DQo+IGJlIG91dGRhdGVkLiBOZWVkIHRvIGNoZWNrIHRoZSBjb2RlLg0KPg0KPiBE
b2VzIGl0IHdvcmsgaWYgeW91IG1vdmUgdGhlIG1lc3NhZ2UgZnVydGhlciB1cCBvciBkb2VzIHRo
ZSByb290IFBEIHRoZW4gYnJlYWsNCj4geW91ciBuZWNrIGJlY2F1c2UgaXQgaXNuJ3QgcmVsZWFz
ZWQgeWV0Pw0KPg0KPiBUaGFua3MsDQo+IENocmlzdGlhbi4NCg0KSXQgbmVlZHMgdG8gYmUgYWZ0
ZXIgcm9vdCBCTyBpcyBkZWxldGVkLiBJIHRoaW5rIHRoZXJlJ3MgYSB3YXkgdG8gZ28gZnJvbSBw
YXNpZCB0byB0YXNrX2luZm8gYnV0IG5vdCB0aGUgb3RoZXIgd2F5IGFyb3VuZCwgc28gaXQgc2hv
dWxkIGJlIHNhZmU/IEl0J3Mgb2theSBpZiB0aGUgcGFzaWQvcGlkL2V0YyBnZXRzIHJlY3ljbGVk
IGJlZm9yZSB3ZSBnZXQgaGVyZSBhbmQgd2UgcHJpbnQgb3V0ZGF0ZWQgaW5mbyBzaW5jZSBpdCdz
IGp1c3Qgc28gd2Uga25vdyB3aGljaCBhcHBsaWNhdGlvbiB3ZSBzaG91bGQgdXNlIHRvIHRyeSB0
byByZXByb2R1Y2UgdGhlIGJ1Zy4NCg0KVGVkZHkNCg==
