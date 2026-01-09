Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DE2D167F2
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 09:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F9C10E867;
	Fri,  9 Jan 2026 09:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9wZQ5jo";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D0C10E867
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 09:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1kCIsEt4aTqqvZaonJC7oHIsPnPhstOYS2ANbLYYQfLPkdwsuPEfaE0ljqfJWP1JM+pn/wlCuKHx+eNs+O1FQjqp8k/gPWfDG+4EYd29Z4jMZ8fnrd19MuOYFDu9A8twGfsvRlviDAzWId+Xj+DwxnKlf2CvR5EBR7XoHVndyFH4RaU+3CFck0O7fvwYinkI95rcwlntPW5trhSMIrdTFy8pUffBNgO0kq1RYbxQSZ7e6x2JtqtYYu+5Kbgk7Ejtwhtznm/neKyedjKiR/l27QLTz5Cwg5TeyaS5Qs8UPQCcSBg8carm9EbC/1mAz5kxlr+u9dvfDzFzGiysHNuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPOYy/C55cXr8JotlHUD+4KBaOl1QhkNcdXzRhXamEk=;
 b=V1JBCqXpfrdWGsmDci62bHY88TAE864o440y80qqc3Eg/qhrB5Zl5r1IqTsH3b2KeNtRG2e0wh+VNknrSErlihfiTgysZliXbRHD5izCqZWp6Mlc4LQT+GJU1fn0h3gDrS2CXKHhTTSII9KozIJpOq+/zgMjW43DjHUljTwxKSEhMMMP4L9kJNJAIDs/FcQQ/3pmLtNEg/ttTamsuazgOs54xfbd5+r9Kg/jcW6Ev/hbkgRRslUNtl7UkxcnKE5n0/AOGUwiWIT+Ywc53CA+NdHNM9gZ4Zih33F2YObv81T3AOlFyViG41a8LoDvzdGulzIaOdCj0CK1gvwadmjANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPOYy/C55cXr8JotlHUD+4KBaOl1QhkNcdXzRhXamEk=;
 b=y9wZQ5jodGgj5bw4QSoKA3moBYFrf+UNKCstZvFMtCu71Q8pVXLZFpjpc4Oyvta1upDHSb5cO/8ZHCgA/0wYGuQnmKV9Sr3fdHpwGv6zcHYPsEkyOO1z59NmFri2S/ouDV5xwRpSytxs7lbtP2ct4K5WSZO3Y+T9CD+ViszgqyQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 09:44:50 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 09:44:49 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/amdgpu: Add timeout for user queue fence
 waiting
Thread-Topic: [PATCH 1/2] drm/amd/amdgpu: Add timeout for user queue fence
 waiting
Thread-Index: AQHcgRCLtiNuSQJvVkyfCSfQ9d2zg7VJixWAgAAEzWA=
Date: Fri, 9 Jan 2026 09:44:49 +0000
Message-ID: <DM4PR12MB515245A14DE04DAC9988AC82E382A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
 <f9ed2178-06a7-4d2d-96d8-ec3c6f64bd12@amd.com>
In-Reply-To: <f9ed2178-06a7-4d2d-96d8-ec3c6f64bd12@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-09T09:19:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BY5PR12MB4049:EE_
x-ms-office365-filtering-correlation-id: 5a592eaa-3e88-42ce-fe8a-08de4f63bb57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?dzFlNmpmbUxRbnBQTDd5ZXFMUXhJVzk3RnphZjU0MTZ6QnZoMmZRbVhKNTdL?=
 =?utf-8?B?WEJJS1FYbXZ1TWxmU2Zkb1huLytwNTlLc1g3bUNpQU1nd2NzdGhFVUM1eFVr?=
 =?utf-8?B?ejA2Q0JDZjlLNFliNmlLdEZZRTUrTjNRUUgyTnpSZ0dSQnlEeUZkTDROeWZU?=
 =?utf-8?B?N054QmlFeC9aQlAwcUtkTmUzZE5wMVdlK2FaTldFNlZzc2s2b0kzemlOTDlR?=
 =?utf-8?B?c0trQkNIL3djajJKYjFTd0s5Vm9lOXZLdWZVS0VYSk14Mml2OVpweWR2Y21q?=
 =?utf-8?B?TVdzckFaeXZmaHpqcjFGSGNaM2tha2cxVUZRaGFiK01jWUNmejgzV1VyWlRW?=
 =?utf-8?B?ajI0Vjl1eFIwOUtwUXYyVHNQZStSOEs1UW54cnozZXFEeUx3SjJEcEoxd2Ex?=
 =?utf-8?B?ck84dDdNcm5YQ1ZwSzhTV2NGMWRwK1NrY0kvOHRSZDJGT1pWSDI2TURWci83?=
 =?utf-8?B?cXFnTFl2eGp1cWRxL0xnbXZsbnVSaSttVkZGU2NkQ3NCTFZTVmJCbnpBNldh?=
 =?utf-8?B?UVh6SGVaaVIzL2EyZkhLZGU5cm5wOUNlckVVQnN1b2g5STlKOWx1SytNaDM2?=
 =?utf-8?B?UVNIc1dSNGptQUk2bmpKcEkxME5hdUc0VkhYOGk4bmRnczNsU1NmendWU05p?=
 =?utf-8?B?d0RRZlpxMU5QYWlyUVA2TEVJck5SMXBoTU9IbERhUkl4eWExMkVaMlhQTDRq?=
 =?utf-8?B?Um5XZ1U4Ry9tdWVSSEFVdW12dU5mUGNRYjJ0M0U2aHNWKzFCRDhINnhTSWxR?=
 =?utf-8?B?Q3FYV3hERkc1ZWgvYUdRVy9OTEc5NnFLNVJzelpNRE5XSzZONjRTelVhb2dk?=
 =?utf-8?B?aFcwRm1jbUl5L3F0MVRWL1hXSEpUTmhVWTNRK3dDcUhNTktOWEFybXE2RUJY?=
 =?utf-8?B?SXJoQllXNUtyQ1hlQzZPaE1XaGM1d1BhY2JsY21JVlYvWVdicldrWG80N2ZR?=
 =?utf-8?B?ZTN2Q0FQUEo4Z0x5ajA0amNEMWZ3eTBNSGhRTmxDTGVkOWxIWnlsRmZWMVZ0?=
 =?utf-8?B?Wk5saHZ6QUpjUW5IQlo0akVXZE5JWTdnSXNRRmo0dUlJQW9jTENuY2F1NmY5?=
 =?utf-8?B?TzN5OGpCaUJsZHhEL1BBVzBiaW1mTVFOb0FlckpnOWZWVzF0TEptYWtGSXVo?=
 =?utf-8?B?OGw2ekJoM1FjRjFYYXpuRUlLTjczRi90N3ByMmN1dFdmcWE2WGpaWENuRFJ3?=
 =?utf-8?B?UXd2ZHRRK1kwMDdYbUZZdE4wdHdKaTF1TytIOERiaWFpQXNLMzhOVXF4SHB1?=
 =?utf-8?B?aVdtMXc3QWp1RGNlSzZrbFdGYklDZngxZlNzZ2c4eGxiL2VJZnRjNTArYkcv?=
 =?utf-8?B?NnhvYXFTVkZyZGhhQjJpQ2k0WmxPWjMxNnkzVFVkeEVmNnA0QnFrM2M3VHh4?=
 =?utf-8?B?VkY5Z3JQMVYxSEZNVDBybTJnV3pPNnJsR1ZCazh5RTZqMTdFbTd1OEJMRDE5?=
 =?utf-8?B?dUJyaW1kYzJTMWNoUzVJQWFoenNEaFZkcXMyeVRVWWRKekFFTTZhcGV2TTZk?=
 =?utf-8?B?OFlUSEgraVZlN2FLL1E4Mi96OWlBblFIVHR4SkZZTFFKZVI3NDRpdnd0ak5O?=
 =?utf-8?B?OW00N2NIc2d5TXo5SXF5YSswczlPMXV2alMzbFlJOHIxR2lQVXBrdTRncjVl?=
 =?utf-8?B?YStWaEt1djV0UFZXOUR4c1dQSWFpRDVZSjh1czFXYlVoTlNLWDB1YnZOUmVk?=
 =?utf-8?B?WDlxNGZvUDFSYk55RnpFYzdMcEhvVXB6MEMzT3lhL0pQbWV5VzlSZFhmR3la?=
 =?utf-8?B?blcrV3dwcUVWcnp2S3pGUjlNQ0ZPeXY4b1FmL1EyL2hpN2JZZU1JMUFGU0h4?=
 =?utf-8?B?RFFCamcwYWhaZWZ0QVVkbzdDa0JVK1BtVldSUk43aVBDQmhzUFlsS0VsSHhG?=
 =?utf-8?B?YUtXbUlEb3VQUTJEYkY1emlTUWppazdUK3pkS3dRcFdKRVcwc05neHNvbTBD?=
 =?utf-8?B?NWN2c0s0TWw1bXBTVVFyRmMwTGVQWE93N2J6WjZCME1wVzR3d2J3KzlCT1BM?=
 =?utf-8?B?T0NlV0J3UGF4U3QwV2cyUUxGaGgwV3BhOXE5eDFpU3E5SWt4ZEk1VUFaK1Ev?=
 =?utf-8?Q?R4uxtS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVA1b3crdXFEUFBrN2E4M0xUY012SWoxcktJS2JWaXphT2FBSjVLRllBZkQ3?=
 =?utf-8?B?bXJKejFLKytnMitmemZvbHhBN2xOU1E3VVdDc0EvU3Z5MVFxcExyMWQrb2Ns?=
 =?utf-8?B?WDk2R2ZnaWthT3g1MW9NSG13ZjNvc3NqTm5aYmpUSUU3K0RHS20zbzJjQk4y?=
 =?utf-8?B?WmZqWkRRUHVVMGIvb25HTG9wTG5hUnNLcDJKdmxodDh0Q1ZUMVR0RzJaVGha?=
 =?utf-8?B?UWNNZ2VQRVBBWVZoaVZVa0tpRW5kVHNzNWtDUnJ2dVN0RW83bWxFbnJpUlA1?=
 =?utf-8?B?Y3VzMzloNkxHa1JpdDlZTjVMSTlyOVp6aXNxcGRnVGl5QW1XZkQ1QmtISnFT?=
 =?utf-8?B?TE5VVHlvZG83bkN4MzRITW11N2p0YWJHTmdqMzJKa0pIQ3hkMytQNzVsMUhO?=
 =?utf-8?B?WlJjSDF0U1pFME9Ed1RvU0NCWkNUQjVERlk5Q25vMzRzK25jTlQ3ZHY4NHhX?=
 =?utf-8?B?WksxMk1VK3d0UGYzblYybkQwM0I4a0VMVjNaenRNSTZINk5LZkJwMnJwenc0?=
 =?utf-8?B?aWV5ckJNYlgyaTRKdW8wSkRmbm1pSDBZd1JEUldySXRFcHNBNTcySUt2Rmsw?=
 =?utf-8?B?bVpRa1ROdk4rSUV2clliZTBaN3dsQTJ5d3NaSEp2eEdoMG9qQlREcHJkaEtH?=
 =?utf-8?B?aEZSeVdKYUJYeFdOajFTcXFXTnh0SENiUkNQQ2VpYlN6WFdlU2FzMmtBdVRZ?=
 =?utf-8?B?VC9tdnM5bzB4UHoxMThDbTFRenJER2pqSkwybmpUeDQ4NDVCRXBFQU1QazBM?=
 =?utf-8?B?UVVwOGFycVV2WU94R0FkNy9CeDYzWkdieFE3bno0dHVCTmg2NFNINGIrVHNE?=
 =?utf-8?B?dnJ0VVM5dURzRmxhWm1OUDUxS2dZWEoydTB5WTBva0trWEdqenV1ODRNUDU1?=
 =?utf-8?B?eFo0TFdUVTFkZXo3d2prcTIxWTc0WkQ4YkxSWVhoOHQ4NUEyd2hhSElEMkc1?=
 =?utf-8?B?WFRkalkybDcvODVyNjNGbGhpT3FGajJ2dUErNWF3QXZBQkowTlI4TGcvYXFz?=
 =?utf-8?B?bTNxVHFST25lbndkYm9neTdiVmJiV25SL3pSdURwK0lBd0dRQjM2anhETEcy?=
 =?utf-8?B?R3ZMTUlxUjNmZ001OFNIQ21tN2duZ294VS9wcXVocGxiS0hPSkRLYmMrNkVa?=
 =?utf-8?B?WDZwUHpwSHhpWVhRQ0FYNFFITjZLWVg1WHRzY0FVdml2ODQ5VlhHR2xVZGVP?=
 =?utf-8?B?UjlKZ2o3a1hXT0xXOUx3THVZbFQzVXhRTm5tMzlKenlCV3ZsSW42ZzRMTXZG?=
 =?utf-8?B?akpoL0g0QlJhL01yRTF5S3M4SWlXVi9GTlR5bktGYkdTajlmQmhKdXlFa0dV?=
 =?utf-8?B?NnFXeDltRGw1Q21zYXNZMjVXMTV5Nk9GS0FPTVFCeDhlR2ZTMlhxcXJwV3VH?=
 =?utf-8?B?dUc2amcwNnk4TDl1enhFcDAxUU1jc2FJSHNON1ZtV2oweTlQN2NSZysrazlK?=
 =?utf-8?B?L1RiNVhPL1hDUXNXc2RESlZqU0xoOHdhSG56NXBVdDFHeWZXQWFOSE9FSnpk?=
 =?utf-8?B?d3hGY29aeFRncDgrTkNPSjRKRmkwN0FDYUR1d1pGOFZHTm9aZFNtNzBxTnk2?=
 =?utf-8?B?dmk4aXdIWFBFclZZSVZsbWRkU0ZtdHJjUU13TGhyOG0zU2d3SkRaRXNNYTZG?=
 =?utf-8?B?UWt5bHhsOW41V2JZNzJSc3R5b0d4cUU3Y1Vab1RXbWhLWjFrL28rWlI2a3cy?=
 =?utf-8?B?Ylp1NkRwMHF6RS9hRVhrUC9qZ1hBeEpBSHpXMmtSODN6L1pUUlEwMnlUWHox?=
 =?utf-8?B?UDBCWjQ3eko3d3dNN2wvMWZrTnRDSGVpU1YzalMyZzh3aC9sT0EyenZmczFC?=
 =?utf-8?B?U2JXMTV2RzA1ZmIxWG8zais0MUd1TGZ4K3NPaWxBbDNVcThSTEdTSjdjbHNQ?=
 =?utf-8?B?Y3o1aEtSOCs5dXNKZFl6QU5KcTFJOHpRMlpnaVkxenBVM1ZPY0ZhTy9uZXhq?=
 =?utf-8?B?K25FdUtWc0Mxd2lGdlZmU1pjMExnMFlhYjhFZHZjZWtidkhHYTNIeFUzWnFH?=
 =?utf-8?B?SXVqZEdHbitzSHRqaHd4WVRRbElyaCthdERSdzJWOHJ3RTNROGlvdHhHaVgw?=
 =?utf-8?B?RHFMR0MxODFReEdzWU43bHovNGxjQjhCUzlKa3VRWkhUeTVQbWJxcUZOZ3RZ?=
 =?utf-8?B?d3NFd2NTdHlFNGhXOEVqOTVjUWxNaVVwZjUwNTRTZ1dvbnl1WGtPSElQWkFL?=
 =?utf-8?B?MFI5ZHA5NVA2UFFtSm04NWtmOG9zUFRMNkVBV0l6VzZaZ3NDcE8xdkk1L2tv?=
 =?utf-8?B?WHpxM3pKNkRRbXYrQTNVRitJNVQvdWsvcWMvMCs2bjdRTk9yOGtCQzR4YVFK?=
 =?utf-8?Q?DAfWb8wKEXCJ/fNKv5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a592eaa-3e88-42ce-fe8a-08de4f63bb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 09:44:49.6302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQZy1bnAdDQ9HeFz7el5PLDGdGoEYNtOp5hbQ7GytKfEuwJUdaNk8tnrbdLa3kPg4l0CcMrETImhB71UNresVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgOSwg
MjAyNiA1OjAyIFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkcm0vYW1kL2FtZGdwdTogQWRkIHRpbWVvdXQgZm9yIHVzZXIgcXVldWUgZmVuY2UNCj4gd2Fp
dGluZw0KPg0KPiBPbiAxLzkvMjYgMDM6MzQsIEplc3NlLlpoYW5nIHdyb3RlOg0KPiA+IEluIGNl
cnRhaW4gZXJyb3Igc2NlbmFyaW9zIChlLmcuLCBtYWxmb3JtZWQgY29tbWFuZHMpLCBhIGZlbmNl
IG1heSBuZXZlcg0KPiBiZWNvbWUgc2lnbmFsZWQsIGNhdXNpbmcgdGhlIGtlcm5lbCB0byBoYW5n
IGluZGVmaW5pdGVseSB3aGVuIHdhaXRpbmcgd2l0aA0KPiBNQVhfU0NIRURVTEVfVElNRU9VVC4N
Cj4gPiBUbyBwcmV2ZW50IHN1Y2ggaGFuZ3MgYW5kIGVuc3VyZSBzeXN0ZW0gcmVzcG9uc2l2ZW5l
c3MsIHJlcGxhY2UgdGhlIGluZGVmaW5pdGUNCj4gdGltZW91dCB3aXRoIGEgcmVhc29uYWJsZSAy
LXNlY29uZCBsaW1pdC4NCj4gPg0KPiA+IFRoaXMgZW5zdXJlcyB0aGF0IGV2ZW4gaWYgYSBmZW5j
ZSBuZXZlciBzaWduYWxzLCB0aGUgd2FpdCB3aWxsIHRpbWUNCj4gPiBvdXQgYW5kIGFwcHJvcHJp
YXRlIGVycm9yIGhhbmRsaW5nIGNhbiB0YWtlIHBsYWNlLCByYXRoZXIgdGhhbiBzdGFsbGluZyB0
aGUgZHJpdmVyDQo+IGluZGVmaW5pdGVseS4NCj4gPg0KPiA+IHYyOiBtYWtlIHRpbWVvdXQgcGVy
IHF1ZXVlIHR5cGUgKGFkZXYtPmdmeF90aW1lb3V0IHZzDQo+ID4gYWRldi0+Y29tcHV0ZV90aW1l
b3V0IHZzIGFkZXYtPnNkbWFfdGltZW91dCkgdG8gYmUgY29uc2lzdGVudCB3aXRoDQo+ID4ga2Vy
bmVsIHF1ZXVlcy4gKEFsZXgpDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFu
ZyA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4NCj4gT25jZSBtb3JlOiBBYnNvbHV0ZWx5IGNsZWFy
IE5BSyB0byB0aGlzIGhlcmUhDQo+DQo+IFRoZSBmdW5jdGlvbiBhbWRncHVfdXNlcnFfd2FpdF9m
b3JfbGFzdF9mZW5jZSgpICpNVVNUKiB3YWl0IGZvcmV2ZXIgZm9yIHRoZSBsYXN0DQo+IGZlbmNl
IHRvIHNpZ25hbCBvdGhlcndpc2Ugd2UgcnVuIGludG8gbWFzc2l2ZSBwcm9ibGVtcy4NCltaaGFu
ZywgSmVzc2UoSmllKV0NCklmIGRhdGEgcGFja2V0cyBhcmUgY29ycnVwdGVkIChlLmcuLCBpbmpl
Y3RpbmcgZXJyb3IgZGF0YSBwYWNrZXRzKSwgaXQgY2FuIGNhdXNlIHRoZSBxdWV1ZSB0byBoYW5n
LiBUaGUgbGFzdCBmZW5jZSB3aWxsIG5vdCByZXR1cm4sIGFuZCB0aGUgcHJvY2VzcyB3aWxsIHdh
aXQgaW5kZWZpbml0ZWx5Lg0KVGhlcmVmb3JlLCB3ZSBzaG91bGQgc2V0IGFuIGFwcHJvcHJpYXRl
IHRpbWVvdXQgcGVyaW9kLg0KV2UgY2FuIHRyaWdnZXIgYSBkZXRlY3Rpb24gYW5kIHJlc2V0IG1l
Y2hhbmlzbSB0byByZWNvdmVyIHRoZSBodW5nIHF1ZXVlIGFuZCwgaWYgbmVjZXNzYXJ5LCBzZXQg
dGhlIGVycm9yIHN0YXR1cyBvZiB0aGUgbGFzdCBmZW5jZS4NCg0KVGhhbmtzDQpKZXNzZS4NCg0K
Pg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4g
PiBpbmRleCA5ODExMGY1NDMzMDcuLjQwMjMwNzU4MTI5MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gQEAgLTM2NywxMSArMzY3LDI5
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3VzZXJxX21hcF9oZWxwZXIoc3RydWN0DQo+ID4gYW1kZ3B1
X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSkgIHN0YXRpYyBpbnQNCj4gPiBhbWRncHVfdXNlcnFfd2Fp
dF9mb3JfbGFzdF9mZW5jZShzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSkgIHsN
Cj4gPiAgICAgc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVxX21nciA9IHF1ZXVlLT51c2VycV9t
Z3I7DQo+ID4gKyAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gdXFfbWdyLT5hZGV2Ow0K
PiA+ICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmID0gcXVldWUtPmxhc3RfZmVuY2U7DQo+ID4gKyAg
IHNpZ25lZCBsb25nIHRpbWVvdXQ7DQo+ID4gICAgIGludCByZXQgPSAwOw0KPiA+DQo+ID4gKyAg
IC8qIERldGVybWluZSB0aW1lb3V0IGJhc2VkIG9uIHF1ZXVlIHR5cGUgKi8NCj4gPiArICAgc3dp
dGNoIChxdWV1ZS0+cXVldWVfdHlwZSkgew0KPiA+ICsgICBjYXNlIEFNREdQVV9SSU5HX1RZUEVf
R0ZYOg0KPiA+ICsgICAgICAgICAgIHRpbWVvdXQgPSBhZGV2LT5nZnhfdGltZW91dDsNCj4gPiAr
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgY2FzZSBBTURHUFVfUklOR19UWVBFX0NPTVBVVEU6
DQo+ID4gKyAgICAgICAgICAgdGltZW91dCA9IGFkZXYtPmNvbXB1dGVfdGltZW91dDsNCj4gPiAr
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgY2FzZSBBTURHUFVfUklOR19UWVBFX1NETUE6DQo+
ID4gKyAgICAgICAgICAgdGltZW91dCA9IGFkZXYtPnNkbWFfdGltZW91dDsNCj4gPiArICAgICAg
ICAgICBicmVhazsNCj4gPiArICAgZGVmYXVsdDoNCj4gPiArICAgICAgICAgICB0aW1lb3V0ID0g
YWRldi0+Z2Z4X3RpbWVvdXQ7DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIH0NCj4g
PiArDQo+ID4gICAgIGlmIChmICYmICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZikpIHsNCj4gPiAt
ICAgICAgICAgICByZXQgPSBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KGYsIHRydWUsDQo+IE1BWF9T
Q0hFRFVMRV9USU1FT1VUKTsNCj4gPiArICAgICAgICAgICByZXQgPSBkbWFfZmVuY2Vfd2FpdF90
aW1lb3V0KGYsIHRydWUsIHRpbWVvdXQpOw0KPiA+ICAgICAgICAgICAgIGlmIChyZXQgPD0gMCkg
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgZHJtX2ZpbGVfZXJyKHVxX21nci0+ZmlsZSwgIlRp
bWVkIG91dCB3YWl0aW5nIGZvcg0KPiBmZW5jZT0lbGx1OiVsbHVcbiIsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZi0+Y29udGV4dCwgZi0+c2Vxbm8pOw0KDQo=
