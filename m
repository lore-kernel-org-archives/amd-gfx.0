Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C85C369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 07:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437AC10E755;
	Wed,  7 May 2025 07:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dRp5Jgb/";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3749B10E755
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 07:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHVYzUY0HjUxAbNqBkY5iSkh1DTXhidF6KBI6fWAxsmwk41IBN+figsoKuYDjS9p1Hu3NptwZjHDAXD3mlDrcf2m2OJFA+cjscz0jhqhncwUlIk4uH8K8T69reYD8KkjJqXSbOW8vEL0xmD5wEY8R2h1KyHPdB11fxa8SqIx00KDq3Dj3aDFRrJMuFfRrUvCXkC0fgdIE+6d5PZiSU+pj/kN4HstL2Y0aQqG8gynsCiD5FHjZtZUls/n9NewfP3gDf71AU0VKnMD3a9hTBJORQsDtXHDqNAFTq/kU0Mpr20NHph4eZ4rtuKG+lNDsMPvDy29WeFGyUb36Q3JZ0jQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcNWf1xfCB5WMFmhROectZNJyVIw2CAeSTSRDGeSiTU=;
 b=M70R+n+gZjqtng0gif7gradPzvQFQSpfdRYjpxHE9qzcO6rBrrfrGXBR2JAEPDnH5Z68z1oQ0JjWVbeBn6iiYrADf16C+VDVUEKC/et+5qrCRDHgAC/tK91a4wjlFgmIo3znWqt9ToK7FwRw9UWN2qvL5fMi3oWcIt3yr+eA+cDTLLZ5cnW+xyU4i1UV0ObzpfjCyWx7CnfQrxK639tpHV5cD68d592A7dq5AchaQCOH02x7TzuLW3ucCRRQcqin8uxH/3b8OENa/w2bDWPcabP6iHU6wJU6tbOhXyj2uVUSiPJ0Uc7azL24H2O/8GK/dlEGMhA9lQPk/Ekzb8l8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcNWf1xfCB5WMFmhROectZNJyVIw2CAeSTSRDGeSiTU=;
 b=dRp5Jgb/Z3RX3FqSkK3I4ViIzE1vvW8cH8tqiyoLLOS0PI182MSn1VV0EPztsWUGeGTDAcibpEMYKc8lOgmBQI+K/Vq+yCI7hNlXIg6IO2DK/Jbjdqn2AJ6c4U+WlOLXRdNt0HHMUctYQupqXa2GZ0C0RTsQ0KchnKjblwTcztQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Wed, 7 May 2025 07:05:44 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:05:44 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Topic: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Index: AQHbuAbbGAa0pwMfOk2XdnXKBBngkbO7hSoQgAohxyCAAAncAIABF9mA
Date: Wed, 7 May 2025 07:05:44 +0000
Message-ID: <DS7PR12MB60059FF6EC19EC5485240D89FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
 <20250428062853.4057900-2-Prike.Liang@amd.com>
 <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB600557F4E08F81716AAD4D69FB89A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <72c1df20-46a5-459b-9c4b-5775a55bbae6@amd.com>
In-Reply-To: <72c1df20-46a5-459b-9c4b-5775a55bbae6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=58a37814-0614-49b3-a114-f10570831f92;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-07T06:50:53Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY8PR12MB8299:EE_
x-ms-office365-filtering-correlation-id: ee0966a9-793e-4ea0-d498-08dd8d3595d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UFhmZlJmNjJuTGZsSWlDZDJhRHErRytiVVVocGFINUVvSHpqY1hsR3VKYUR6?=
 =?utf-8?B?T3ZUM1h5bGh0aXUxeS90YnpTUXBVdDNPRUkwd1VRZnZwKzZqS2Y4T1RsTGE5?=
 =?utf-8?B?bjRuU3ZWNnJneGVxY2R1bml1bTFxR3JSTFlBNEVxM2lVV3g2bkpQajk4eVgy?=
 =?utf-8?B?djZubjFSbnAwL0VNZWZXdkdzWHNkendjdHJid2p3RXJ6VkcwNGNJejBtK25m?=
 =?utf-8?B?ZXBNWGtKVEdZVnNMa3hOZXkxY09saHpNRmdNQVpRc3diRGo0TFVDM1hGa0s4?=
 =?utf-8?B?Y0Q4a1hON3RkdElmOHliT3lFZmhmNk9RTTBQWWQreWRiSjZFcWJJR0xzQ21B?=
 =?utf-8?B?ekVDUU5jQnN0TXZwcDNZM2tJTkpacGhQNUZVa0pCakN1N0Fhand1aWhlWTkw?=
 =?utf-8?B?RDY0bWFPL3hvU0g1Wm1tOWVqRHpMSjd3bHJPV1BvblFtVWFDSjI5Nm9MdENU?=
 =?utf-8?B?T3pYOEtPMTdqNDFYcmFyWFRsenhOQ1hkWExyV1lrL1JuRHJGT29RRFZ4STlq?=
 =?utf-8?B?WURYbDRtUXkzTVl4Ui9iNHpyWllHWDZxOXlUTGExTjRYYjVWeHdSUERDVjZo?=
 =?utf-8?B?THZZQzU5YjVTelRkYWJpSXRmU0h5NTFPREpDMXZkSXdMVk9WeG1tR1FxdGpw?=
 =?utf-8?B?N0dEdEdvbkpkQ3MxL2hEUVJPMzFQR0YybzB6RnFsQ1dTZDdOZE1sOWVaL3Z4?=
 =?utf-8?B?cEhhMWhkRVVTcUVmK1JqdTBERkxadjRsTVhYblBRQktrT2dFamJGMDN3MWJj?=
 =?utf-8?B?NzNzZGNueHNiU0NWb3dzajExRVV3U01yMTVxVG9lZnZ0d0dWV2dyTSsrTnVm?=
 =?utf-8?B?T2RzblFyOTZpVTJuYS9CWFJmY1BhZUptQzJ4ZHkyYUlaK2tKTGpqRW1xaThE?=
 =?utf-8?B?dlJWdHphVFVVaHlUNk1sdkNzbURpYUY2bHh5em1pWThNcGxvaElLMGQ4UGs4?=
 =?utf-8?B?czZPRU5meGtjOGIra2V1SjhZMVRaZGljSUhKbWFQOXRPNzAveFBzeHJaWXVE?=
 =?utf-8?B?ZCt2eDlaOVNFYzlCYkl5YnZOR2twRUxtcC92MVpXc0RUTHR4NXU3c0lJYWFY?=
 =?utf-8?B?ZEY0TllhYi82ZHRLeTRPbjRIZ0ZyV1l4TDRDWVhFcllFUTV1OGlpVE1oTGRF?=
 =?utf-8?B?WG8raWZNYTl5Y2J6U2JJVHVUeDhCWUEyc1MwcUJXd2FkRk5jSmRqVlNHc0dz?=
 =?utf-8?B?d3dvNGNmNnRDelFNRFpkWlNkKzA1K1pnSk5nTmdKM2tBVFBEem1vT21NRENo?=
 =?utf-8?B?ZUYySHBqZHhtZDE2MWJtdGpnMlU0UUh0ZlpIdVprbjBQN0dTYlRKdEV1VEJy?=
 =?utf-8?B?S3lFbElSeXplN3RJeS9lL0RLUG1idkJoeGRodGtUUSswdnlHK1NSbDFPL1p3?=
 =?utf-8?B?ODc2MDExU1hyVXV6N2hEYTR3MlpVK3puVWJnTkpIMnBXTysyZDdwTlFqYTMx?=
 =?utf-8?B?NXk4Q2ZzMkYzTTE2QXRwYThTYW1TTzlVd2toa2ZFaDNYcG1HSHFHQ1M0S1Q4?=
 =?utf-8?B?Z3dsUXpNWG9QVkNwcDF6QzY1aFgrMmNQbXBJV2V2RlZ0LzhIcXdGWHU4WENB?=
 =?utf-8?B?QkROaUNzemdWbTJ5SkJhZnhEbkFKZmNOYXBaQmJhaVhyWGo3ZndNeEpjTTgz?=
 =?utf-8?B?WlY5N2JhUEhHQ00xREVVTHVXUmpJenc5dHZkMk4xT3RZMFBTN2IvRHhnNnZD?=
 =?utf-8?B?dEpXZXlzK2FxOTVjMGwrcHJNbVhmZWN6bC9YZXJQN1Fhc2tHUWpRcVdoeTF3?=
 =?utf-8?B?NjRQTlgwYW5jbk9RUGVUYU1SY1VINFFJcU1xYlZHejJGdXljc3l2L2F0YkpC?=
 =?utf-8?B?OWE1eXFpNDJTbDR4czJNeEs0WHBmQkVWemVmazRQeFFCbTJxS0tIaVFhN3Rt?=
 =?utf-8?B?WEhkOXdFVjJwU3UrWGh3OUh1M1pNRC9kcWdqSnJrVXZ0Rk1yWWNhRnlLRjFC?=
 =?utf-8?B?WGRRRnQvd3Vham03RjF4Sk03SmROR3RWY012QWVQSDVoNjZTMlJHQzBucmlJ?=
 =?utf-8?B?TytnRUVCM3lBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5sUHVsWTl4WnhxVXJXWEVOQkVidmhmaGRtYVN3YWpPNklpM1lrQ09EbXYy?=
 =?utf-8?B?dTZDRzcyTndDM3V6K2l0VjB4bHE1NFlNRzl4V3BXUnV3ZFJiRjRWR2dsaDlP?=
 =?utf-8?B?cFZKZFZlTXZlR2cxQ3dZb2ZCckw2ZDJWUEJ3a05LalpnaTNKc2pSZVpUNzE5?=
 =?utf-8?B?eXc3TjNQc2NYc21DSnlPSHRtLzNuTkp4QjBESUdQcGRrUDdEeEViZlhWdkto?=
 =?utf-8?B?NVF3RlJKNCt6aFI5MWxHNmt1WHNGSEF1eW9PNDZCcC9Dd3dOQnVWa1hmT3h0?=
 =?utf-8?B?SzRyb2MxRGYvdWNEUWF4SDNyZTR2NWZxTzVURnJaQXo1b0c1Q0pzNU9SbTFE?=
 =?utf-8?B?S0xxMHUzYytvd1J5Qk9hWDNMdEdtb080RWc0QVY5TUtMTkRxdE9KT2lsWFBF?=
 =?utf-8?B?S2RySVVyWWJHbFlmckg0MXpZd1ByQnlSYTJxTGFEbFUyNEpsbE41a2pzNkFl?=
 =?utf-8?B?Q2N4ciswdElPNzRSZ1QxakdGcWlFWmJIQStTNVljSVVBTkNsNkVCRlBsb2Ux?=
 =?utf-8?B?WGcreGZMQ1VTVjhQVGdyQTZMSEY3VjkwWXZBd0FOa0N0SzExS1pQbU1Ic09u?=
 =?utf-8?B?NGwxdlJwL3pUdHRlRGhBZjZ6TElzZjhZKzJyR25VWmJIcUlsV1Zrb3VENHFk?=
 =?utf-8?B?c3QvaFM1dGhBNy9hZU1TR1AwUlpxU3krQk1WbmxWa0h2a2xUWW1JYmVYK05t?=
 =?utf-8?B?Um1TZ2FOSmZLZmV0Rm5tY3BtTUhjZmZsbHI3T2JWVEUrbytxczVwUU9GRFNR?=
 =?utf-8?B?dE9pSFhvVGFWOUFrN2xlcDRsT1FuYVhlRG9CWktvd2VoRzBBNnNHLy8vWG9Z?=
 =?utf-8?B?Y3Q4NGJsaC8vT1BWTmdMeHdONHpwWUNnSHZ0aTgvYnVoQWhDSUVtdTJPbTRB?=
 =?utf-8?B?WHpZZkRDTWtnWmJMNXNXTFI2T3Z1cXNIRjRqMzh3c3V0NnQ0MTh6eEdlZzhP?=
 =?utf-8?B?aFZQSnJ0eE13SzM3SkswWjR6eVJCOVZkTUtmVkdhR24wck53dUp0T012VUFx?=
 =?utf-8?B?ckVJM2pRQmVvWnpaOEJoL1pVNElTU3lQNzFZUVZIWDRzSm1QMWJpTXMreWxu?=
 =?utf-8?B?eW1LcXlTOXg0ZXNydEM0WHpYZXpTZWtmUFg3d0dOVlp4UWhQbUFmS0grSkpt?=
 =?utf-8?B?OTN4ZjFIbFlKN3BqS1ByTi9PY1A4TEx0d2QydjhScEVCQktQSk45K0xGSjR4?=
 =?utf-8?B?eVU2YXVXKzRub0hkeXcwQWVJUHFzTk9zWkwvN0tjdkFxbTBPcDB4VS9Kd1hI?=
 =?utf-8?B?bEthNlU5WUdrT0JHWldsTllOSWRxcWE4d3hyTU9hVlhuVHlsdXZneVlQOWd5?=
 =?utf-8?B?OEtoTnJ2QXJDY0c3S0ljSlFIR0xNYzhvc2VPS2ozeUZwUFRUQzVlSjRadHBP?=
 =?utf-8?B?MDRuL3BZYjFlQldlN0c1UkVTOE5FbC9rVXVLN1l5cW1sckE2V3BGZm05Vjhy?=
 =?utf-8?B?d2xHYnE0OHJRQzM4YStEZ3EwL3JlMURwaW9abFc5V3ZuTllzeFRhRTN6bmVB?=
 =?utf-8?B?bU1XRXdXSGJYbFRnTFU1TlFPeXY1T0hqQ3ZHTm1oYm5lQ0xNRVArOFM3TThI?=
 =?utf-8?B?ekJHT21uZXpyMjdSL3VGQVBzczdhSEx2MVlXL3owY3BQcmhmbHFaQTliSGQ5?=
 =?utf-8?B?TFJ1aFZiNTRmc2x4bTczZ0JIeDVMZnlUalcrdUxqbzZZWjA3K09CSXJrdkU2?=
 =?utf-8?B?N2FOc2FmQUJVN3JST3dqNE5MaXpMUm9qQlJKekZkby8xZ1R3K3A4SFZCMUcr?=
 =?utf-8?B?SFAvanRhL1ZpWFNld3JwcUR4dlo5dHo3TkJTOW56MWVNV1hIaVc0bFpCWERm?=
 =?utf-8?B?aCs4QXZpNWQ1WGhUQmFuV0gwKzZqWHZzWnpXS2VEQ0ZldG1QZXowNzZZK2ZT?=
 =?utf-8?B?T2d2bVFwMThLRUZ5VGhXZjFrMThrWUxDeldqbnAyQ3FwV3p0am9LYmU1Rys0?=
 =?utf-8?B?ZXc4SGtORjZuYnRsM2V0TmdTclJEVEZ5S0doMytqYUJBTkNlVWY2SkllYmNT?=
 =?utf-8?B?eXBnNmVBSlFKMkJpV3lqZ2x6UEl5c0JXUEdyZnByMFNuakFxRkFmKzBkaFBn?=
 =?utf-8?B?QXlVUmphUmJTTkNoSkVGSkNZOGVkc2dTS3lRUHgvZjNzSm1RbDNudVhNWC9Z?=
 =?utf-8?Q?2m7I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0966a9-793e-4ea0-d498-08dd8d3595d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:05:44.2297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xzTWbFicHVJleliJaZ7OpnoqvaRi/fUantPueNf80SMKHjKtoQDdYwZBtm4sBak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXkgNiwgMjAyNSAxMDowOSBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzJdIGRybS9hbWRncHU6IGxvZyB0aGUgdXNlciBxdWV1ZSBvYmplY3QgUFJUIG1hcHBpbmcNCj4N
Cj4gT24gNS82LzI1IDE1OjM0LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4g
Pg0KPiA+IEFueSBmZWVkYmFjaz8NCj4NCj4NCj4gU29ycnkgdG90YWxseSBtaXNzZWQgdGhhdC4g
V2UgYWxyZWFkeSBoYXZlIGEgdHJhY2UgcG9pbnQgZm9yIGFsbCBwYWdlIHRhYmxlIHVwZGF0ZXMu
DQo+DQo+IElmIHlvdSB3YW50IHRvIG9ubHkgc2VlIHRoZSBQUlQgdXBkYXRlcyB5b3UgY2FuIHBv
dGVudGlhbGx5IGVuYWJsZSB0aGF0IGFzIGEgZmlsdGVyLg0KPg0KPiBJIGNhbiB0cnkgdG8gY29t
ZSB1cCB3aXRoIHRoZSBuZWNlc3NhcnkgY29tbWFuZHMgZm9yIHRoYXQgaWYgeW91IHdhbnQuDQpZ
ZXMsIHdlIGNhbiBjaGVjayB0aGUgUFJUIG1hcHBpbmdzIGJ5IGNoZWNraW5nIHRoZSB0cmFjZSBw
b2ludCBhdCBhbWRncHVfdm1fc2V0X3B0ZXMoKSBvciBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoKSwg
YnV0IGl0IHJlcXVpcmVzIGZ1cnRoZXIgcGFyc2luZyB0aGUgUFRFIGZsYWcgYW5kIFBURSB1cGRh
dGUgb3duZXIuDQpBbnl3YXksIGl0J3Mgb2sgdG8gY29uZmlybSB0aGUgdXNlciBxdWV1ZSBQUlQg
bWFwcGluZyBieSBjaGVja2luZyB0aGUgdHJhY2UgcG9pbnQsIGFuZCBJIHdpbGwgZHJvcCB0aGUg
cGF0Y2ggc2V0cy4NCg0KVGhhbmtzLA0KUHJpa2UNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFu
Lg0KPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExpYW5nLCBQcmlrZQ0KPiA+PiBTZW50
OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDEwOjUxIEFNDQo+ID4+IFRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPj4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6
IGxvZyB0aGUgdXNlciBxdWV1ZSBvYmplY3QgUFJUDQo+ID4+IG1hcHBpbmcNCj4gPj4NCj4gPj4g
U29mdCBwaW5nIGZvciB0aGlzIHNlcmllcy4NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4gICAg
ICAgUHJpa2UNCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBG
cm9tOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+PiBTZW50OiBNb25k
YXksIEFwcmlsIDI4LCAyMDI1IDI6MjkgUE0NCj4gPj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywNCj4gPj4+IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPjsgTGlhbmcsIFByaWtlDQo+ID4+PiA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4+
IFN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGxvZyB0aGUgdXNlciBxdWV1ZSBvYmpl
Y3QgUFJUDQo+ID4+PiBtYXBwaW5nDQo+ID4+Pg0KPiA+Pj4gVGhpcyBwYXRjaCB3aWxsIGxvZyB0
aGUgdXNlciBxdWV1ZSBidWZmZXIgUFJUIG1hcHBpbmcsIGFuZCB0aGlzIHdpbGwNCj4gPj4+IGhl
bHAgb24gY2hlY2tpbmcgdGhlIHVzZXIgcXVldWUgUFJUIGZ1bmN0aW9uYWwgc3RhdHVzLg0KPiA+
Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
X3B0LmMgfCA0ICsrKysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+
ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9wdC5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9w
dC5jDQo+ID4+PiBpbmRleCAzMDAyMjEyM2IwYmYuLjc5OTJhOTdmODc0NSAxMDA2NDQNCj4gPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+ID4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fcHQuYw0KPiA+Pj4gQEAg
LTkwMyw2ICs5MDMsMTAgQEAgaW50IGFtZGdwdV92bV9wdGVzX3VwZGF0ZShzdHJ1Y3QNCj4gPj4+
IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsDQo+ID4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1cGRfZmxhZ3MsDQo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2bS0+dGFza19pbmZvID8N
Cj4gPj4+IHZtLT50YXNrX2luZm8tDQo+ID4+Pj4gdGdpZCA6IDAsDQo+ID4+Pg0KPiA+Pj4gdm0t
PmltbWVkaWF0ZS5mZW5jZV9jb250ZXh0KTsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgaWYg
KHVwZF9mbGFncyB8IEFNREdQVV9QVEVfUFJUX0ZMQUcoYWRldikpIHsNCj4gPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAocGFyYW1zLT52bS0+aXNfdXNlcnFfY29udGV4dCkNCj4g
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9kYmdfcmF0ZWxpbWl0
ZWQoYWRldi0+ZGV2LA0KPiA+Pj4gKyAiVGhlIGtnZA0KPiA+Pj4gdXNlciBxdWV1ZSBQUlQgbWFw
IGlzIGZ1bmN0aW9uYWxcbiIpOw0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICB9DQo+ID4+PiAg
ICAgICAgICAgICAgICAgICAgIGFtZGdwdV92bV9wdGVfdXBkYXRlX2ZsYWdzKHBhcmFtcywNCj4g
Pj4+IHRvX2FtZGdwdV9ib192bShwdCksDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGN1cnNvci5sZXZlbCwgcGVfc3RhcnQsIGRzdCwNCj4gPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnB0ZXMsIGlu
Y3IsDQo+ID4+PiB1cGRfZmxhZ3MpOw0KPiA+Pj4gLS0NCj4gPj4+IDIuMzQuMQ0KPiA+DQoNCg==
