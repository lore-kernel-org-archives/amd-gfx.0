Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92BECAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 02:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B67710E5EF;
	Thu, 18 Sep 2025 02:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqEd5ik2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4783E10E5EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 02:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp6S36n9/rrt6Wxa+W7EDjSZ5k6I88Exw+EmIGqcMGzg37dJsCOwRkrxAHUmNcomuL1HojxUpMtaMdxP4mqwyRfrl+ozciVKNyg3VlLnLosMq7PcDEL+F9RwfRmaSVFuFCq2Nc43ljipbt9qreqjs5xzyVqgortJb3ujaqArXRWt1mQMB2Q0X6fgECb0Cyq2zc0gCrl+TNrvwyeb5UhOpNHfmp6dwkRChQSlo73oTYJymET9WRjvtl6OK8COyEfUcZUin2BI6beKSksosAWWqCmiA7i18LvLRKpag1hwi4tgsFaNOwkQGnz0Ik0Lf3DZ1jp5Kiky+2F8ocPWcsI8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erXIzH3fI2k7yF3fPDY3bZti6au/dBNrAWjTA44qWVk=;
 b=rQraZp4z1IL5+nJzMixYg7eCu777U6ssmY6m7L4eTBORtUUC0O9aIjsiDBXQ0qQesjggsibHArbFSJGOQIvzV7obU9qgP01ES/F4WidkgReAb3oNlT9XBhbMoQlau2YfEmR7Xx9Uy+0noM2AR7hNcvzyjFQz648URbs54XKLFz/MSc4tm2KA6oiGrMOEYdi10+uyATOduYSntq7k66dMx3JCe1WSeZwjivDHml8TPN3BRGF+zMPPdetBtyc2vr+iw2yRi1EtMQv/KRrKEKyrsh3NLlX6ckB1y1mTq1SD2KQBQSKdznc5rrZ3Q5QstWD2fpqFc0xxJ6ZLa9b+/MmP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erXIzH3fI2k7yF3fPDY3bZti6au/dBNrAWjTA44qWVk=;
 b=ZqEd5ik2YoEot9fBz7Kg9YIuvO6M007iR2hgO7DqlxugPM3YH0RVzQsifBjfBy3NEjaHgChk1dLgGmDdRv5IHSqxFwW+ka9NCneiA4jSVP9DzgS/7RiEtiU92FXs2gbQ4d1N6VBNG/ib2Sx7DZed+Me1GiXRX9tiH3xD1dYMN8Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.21; Thu, 18 Sep 2025 02:37:38 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 02:37:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 9/9] drm/amdgpu: validate userq va for GEM unmap
Thread-Topic: [PATCH v2 9/9] drm/amdgpu: validate userq va for GEM unmap
Thread-Index: AQHcI6niwtJkimJklUC4T2M6x4qcJLSXcjSAgADQRqA=
Date: Thu, 18 Sep 2025 02:37:38 +0000
Message-ID: <DS7PR12MB6005162B656C4EF265B6E602FB16A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-9-Prike.Liang@amd.com>
 <CADnq5_O8AA=LvBwv518uwbW=YHBAuedg+WsoQodLwinTdL+hMg@mail.gmail.com>
In-Reply-To: <CADnq5_O8AA=LvBwv518uwbW=YHBAuedg+WsoQodLwinTdL+hMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-18T02:35:40.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS4PR12MB9587:EE_
x-ms-office365-filtering-correlation-id: 5a967466-c29f-47b9-7e51-08ddf65c551f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SENrSUh4NzJhUUtONkx4bHB1REpnSzBDTW8wQlhOQkg3ZmlWNzVkNm1hbHpN?=
 =?utf-8?B?VGdUcE5tdkE0dWdldFJmMzJnejQwK01iZWNNYk1OdWh3eDFKMWJWcEZhRElC?=
 =?utf-8?B?RWE1cFNkTk03bXFTR3BzVDcwdjVDdW9YU2RMZGRzSFc3MmNtQUFYZ0N2TTV3?=
 =?utf-8?B?RVVVNEJpUkRjR1RsSjhiWEV6STNQRlBoeVpoSzRlWXhmTzUyK3RYWkpadjZI?=
 =?utf-8?B?U3hqbVY2ZCtDY1QxTmRrMjBJOE8xZlAzT2RWQ092WGE5STlTYk0wbHlOSElT?=
 =?utf-8?B?TVdXSVA4ZzcrbXZmTFZDbmt1YkNKK2czbERyN3FCZW1SYStoaFNBMHhlbExL?=
 =?utf-8?B?WkZRWEdMZ2k3OVFjakV0TStyVFpiSVlPU0l4R3FIR0NuZmZuSWJhWlNrdzF1?=
 =?utf-8?B?Si9qQXg5SzNUejYwaHJDZmJ5VUNkOW4wUWdqOEdmbjQyMjQ4TFh1SHBLOHFH?=
 =?utf-8?B?NldncGZyVjlxQzhibTVZNHBuYTRtVUc5emRrWGtxM1pCaE02V090U2JkLzk0?=
 =?utf-8?B?cVVPSkpJK0F2RXVpd0lyQmJwN05xbi9UeVF6RVNxNEFtS0ZTb3RPa2cySER3?=
 =?utf-8?B?ZHNzYk5xVms1OUN5cVVCclV2L1k4aFZlME9uRmR5VU9jdnNvSFlzaFZaM1g4?=
 =?utf-8?B?N0VrYXVITS9Rc2pkRlZ5KzF6RUVEdHlyTnIrM2g4ZStTaklSbEdRYnZPdlQ4?=
 =?utf-8?B?NE5zWXZkZVNoNmVNY1NXd1VneHhtNmNCMnNzaUNzOG9YSmJWdWdlSGwzanN2?=
 =?utf-8?B?cFdST1Q5MGpYMHVkL1hUNTVwSGdPV3hrYmlHdUV6bFhTVWo2NVovL01QczFx?=
 =?utf-8?B?OG4wQXNRTktVd0VTU2xFS1huVzVXR0hPQlhydytpd0owRXdibktYYmFlY29i?=
 =?utf-8?B?TlRUckdHKzViNHZiMnZVMWswdzFzQWRtWmxvS1V6Y09xV3ZSbDlEVEpGOGVm?=
 =?utf-8?B?WWl1dVNQc1FWMjBiUHR5NmZVeENHV1NoYjI1alhlRmpoWEsraHBTeGhUYzB1?=
 =?utf-8?B?YXpGc25tZ1pHSXVmbE9kak1tVFljM0JsMDIzUEVtQmxXVUNMWEZUVzFQTzk5?=
 =?utf-8?B?d3VpbkdhT2srRTNmaURWc2pDbVJ1SVg0bTJLREhBZWR2UmVkdVp1c0F3RGpI?=
 =?utf-8?B?NGNnaVYrNHVuSlAyU216WFE4ZDJ0RDFMeW1FeWMzUHgraVNwRG45VFZoNHUx?=
 =?utf-8?B?OURlZlQyZXdsNXhwRngvTGlsaGVzSk05eWlncmlQbFJ0b0N4eXoyVjdXSVU5?=
 =?utf-8?B?YWRpdStnRjRYRzRXakNTQkVZSFBCYnhoMW9hR2FGQmlsZUEvTTZhVy9lREY2?=
 =?utf-8?B?ay9GWTFnU2RKZCtLL1Y2TXJDM2M2ZGhlRXdXdzJhaDRTb1V4aWZlNGlWYnpX?=
 =?utf-8?B?OTVtL0RCaHVFV0hpbnU5OVRZeVRPQ21nYjdSdTNVNzYyNWJRL0ZvSVlXblE5?=
 =?utf-8?B?dFQzNWU1UWtiVld2ZkNmZlFoY0tXcTZUWGl3OUhCZkRUdkxBRlhsdnJkTHJ6?=
 =?utf-8?B?WEY1NVpVQjd6RzNMTGd6OGhrMVQrWGF4NTd3dTVNQzhCQXd3VGlXZS94MXZo?=
 =?utf-8?B?REZSRFdlVks4WHZhM2ovRStSVWlieW1xRERNZDZFYjVSUmlIOEtPTm9HYk1Q?=
 =?utf-8?B?U0huVnU3aUhDUkh4emNhRnRDaGtzYjU5VEtpNVBsVSs4aHRjTHZ1WlJvNGRn?=
 =?utf-8?B?U3VnZXR2YnRHc0hualkwbXNSWGVGY2V3eVhWT040QUZUN0FkWm5MeWRXOWgw?=
 =?utf-8?B?T2VrdVhIdEdlQWZIdW5JQitaMkh6Q1hJUTNtOFBHT29lOFJHaXhERmdlckxR?=
 =?utf-8?B?UVY1TG9mWHdOdS9sZ2Q0UFdmQWhZNjlWMGNLY0hlQTBBaEgxeU5xeEgvV2RK?=
 =?utf-8?B?MnR3RkdNQnYyaU0yRDlleERXVXpQQUVBQ2t4QTB0ME8vczZ1Vnd2QjcxRGV6?=
 =?utf-8?B?dldIZC8rMC9VMHVIWEt1aWNTQ3NNZ0NSaElLVFgwekR4TTNzVGsyR0pJWTUy?=
 =?utf-8?Q?C3A9496o0MwJZ7lYWlChhy8bYqrusE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFVSQmdwVERpSjRxS0Rtb1ZTdk9UaG1uT0xkaFNIcUhVaVdBZnFyU09ZeSs1?=
 =?utf-8?B?ZzJPdElkZlFzSXd6U2RubHBVYWxydDNwT01JT3lUN1B1aUF2d0NVbzNHL1Mz?=
 =?utf-8?B?ajJlaTg4em9MdlBZOUwzVXdqcnFrR3FNdGJ5cDB2NnRPSUh5Ly8zeUJDVzdj?=
 =?utf-8?B?RmFaN0RZUU9jK25JNkRQQ2lReGtwWDlkSElkT0RENzBKSkF5QkNZZFFNRmhP?=
 =?utf-8?B?dHl4V3FBbjhKZ3hJVXQrU2kyRVNaYmdOWEJaaHpJZFVhUGJIaStrVHlQbnMz?=
 =?utf-8?B?bEZXenFHZmpGNW44UCtmay9weC9HdDU2SkpLWFBjaGtPdFdnanBlTm5yZWE0?=
 =?utf-8?B?MW50R016R3JwWG95S0JBSUJmOVRTeWFuWGJKYVJ0QVVWeWFIYUtVakVQcnIv?=
 =?utf-8?B?WVNMRHNZb3FqbXB1VlRRYTl0aEp5dDEreDdwM0lyUXgxUkhxdlVjZzhBbk1n?=
 =?utf-8?B?L3pHN1pxdm15OFpiQnc2c2xVUzdTTFphUys2cE9LQlZJd0FyZTlKNUJXTHBl?=
 =?utf-8?B?Q3pNdU5JdWh1ZzFSUWtqWWNQekhSd2hUWENOQStSSm9lczd0Y0U1dXAwSzho?=
 =?utf-8?B?MnZtbmtYK2ovYVNQV1UwL3M5WjYwdnVTQ1NoYXd0RXZVMHVYcmNXUk5pS1N5?=
 =?utf-8?B?OWpmTjZ2ckZ0QWVTVGZPK2IxMllGbXl0RDA3VStHOFBxU1pETmk4WGFwOW4y?=
 =?utf-8?B?aWlodFVSMkxGU1E1clBrVmx2OGt0akd1Z0w3UFNIdEN5L29XQUs0NllHdWIx?=
 =?utf-8?B?UkhmTG5UdTh2V21kWDgweWpwMXlnTnB6eFFITDNQT01ybGNVY2x3MHhhWVQ5?=
 =?utf-8?B?L2RjTHAzN0lBS2tYTXZiL3FqSVlDRUR3ZFBtUkhETFlDbnFpMVFGUUJvRE9Z?=
 =?utf-8?B?Q1hBV05aV0xQN3FGckh3OVZRdVBQR01qR3dhUXV3L3ozVXlnLzJwamd3Smsv?=
 =?utf-8?B?YWgxMGtKeDNQanhBc1Nka2NQbmlJek5jQm4vRkd0NUFsRWY2RVJrZjZIcFZx?=
 =?utf-8?B?OVpQbVdSNFpPVVREQ3dzbW5pY1FTS3NGV3NGSlVtS3A1Z2o3ekFpc3ZtSjNO?=
 =?utf-8?B?T2cwVUQyR0RIMWg5ZzZ5MWoreWJJTDZCaUJPRGdHWXBLZGxUekVTNkVGcHQx?=
 =?utf-8?B?K2ZvelQrYTViNWNQVjg2NHJXc3UrWGdNMTFUOTZOSmFXVm9lQ0xwM05MYmNj?=
 =?utf-8?B?TEpDUVBZbW1RUjd2L1liQ1o2aUJoOC9RQUlNQjIrUmxjOWk4VHA0clpHVVoz?=
 =?utf-8?B?d1UxZ0VyQVZUODhNYTNuWmVKam1zaXJ6cThpbFo5NnVQNXpGMGlDem4xbU9a?=
 =?utf-8?B?V1lHSDVWL21oQU5kOHN1TUNwZWw5SXJDdFlydXZNSXpSL3dsNzZrb1dsNGpJ?=
 =?utf-8?B?TUNQZjFQR3QrOWxsM24wVVZJeTFOZWNTWWVDZXR3cEtOUkk0aHB5WEkzZk04?=
 =?utf-8?B?bkdvVm54dFo4eHRpZjFxaENPZUJPR1dZRW5aSG9SVi9NNEJKMjhpSnJtb1lT?=
 =?utf-8?B?d2x5NE95NGdiNzI5SCtLcHpFTHQ0cEFjNEJMUFFYV2MrRUVxbjUyUVM4M2dp?=
 =?utf-8?B?VnZYWlVsWXAycUh4d0xzemJTcW9xdmpCSmdmUWI1a1I3Wlg1dFdVVmp2eHFK?=
 =?utf-8?B?RGFzaHRLMExWNmJldlJEaUFQcnQxSXBWOU0xNHlDWEJtQmNzM3BGOTNjbmsr?=
 =?utf-8?B?aVRKK25uUE5zSStHenVsM3BHd3JLOFo0eWFBZndzb3JlcGUySHY0OXZjdnhG?=
 =?utf-8?B?V05LR056MnVZWTJoU3BTanZQbktBc0ZSNDNia2hKZUVPZ1Y5OFZMeXNsNzBL?=
 =?utf-8?B?enRIeXZ3ZXpGSDZEempTYnNOQ3ZmK2lmcU1QL3RycWxQK0d2QTRvSUdsWktB?=
 =?utf-8?B?SFdxcTM5UmV1N1Z5MXZic3NNc3QxWXVZOXBYQmRkejNZN2YrdkFIcUhoNkJ5?=
 =?utf-8?B?S2dIU3luOUtydGdvYlhuL3M2cldLZWM1WVNTSWxoT2R5WHEzS3pwN210bmZo?=
 =?utf-8?B?TkhVTEt1blVMV1diWWJpNDF2b3BLTmNMQ2NOTFJhcjlkZ01uWUg3VFA0S2RL?=
 =?utf-8?B?enBqODRkVUNVeXllaUx4SjA0MzRvNm1pT1dIOEFFS3lxRzFiZDhSd3FueXc3?=
 =?utf-8?Q?bb7k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a967466-c29f-47b9-7e51-08ddf65c551f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 02:37:38.1817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /339bAUoMR01yDW98bhddhpzNZpMtZwEMiRotzUIrdBX8YiFiH2+Ts+2xFZ4/Y/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE3LCAyMDI1IDEwOjEwIFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiA5LzldIGRybS9hbWRncHU6IHZhbGlkYXRlIHVzZXJxIHZhIGZv
ciBHRU0gdW5tYXANCj4NCj4gT24gRnJpLCBTZXAgMTIsIDIwMjUgYXQgMjowNOKAr0FNIFByaWtl
IExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdoZW4gYW4gdXNl
ciB1bm1hcHMgYSB1c2VycSBWQSwgdGhlIGRyaXZlciBtdXN0IGVuc3VyZSB0aGUgcXVldWUgaGFz
DQo+ID4gbm8gaW4tZmxpZ2h0IGpvYnMuIElmIHRoZXJlIGlzIHBlbmRpbmcgd29yaywgdGhlIGtl
cm5lbCBzaG91bGQgd2FpdA0KPiA+IGZvciB0aGUgYXR0YWNoZWQgZXZpY3Rpb24gKGJvb2trZWVw
aW5nKSBmZW5jZSB0byBzaWduYWwgYmVmb3JlDQo+ID4gZGVsZXRpbmcgdGhlIG1hcHBpbmcuDQo+
ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxLmMgfCAyOQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuaCB8DQo+IDMgKysrDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgMTEgKysrKysrKysrDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IGExM2YxODZmMGE4YS4uZTE0ZGNk
Y2ZlMzZlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxLmMNCj4gPiBAQCAtMTE4MiwzICsxMTgyLDMyIEBAIGludA0KPiBhbWRncHVfdXNlcnFfc3Rh
cnRfc2NoZWRfZm9yX2VuZm9yY2VfaXNvbGF0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT51c2VycV9tdXRleCk7DQo+ID4gICAg
ICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gKw0KPiA+ICtpbnQgYW1kZ3B1X3VzZXJxX2dl
bV92YV91bm1hcF92YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhX21h
cHBpbmcgKm1hcHBpbmcsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3Qgc2FkZHIpIHsNCj4gPiArICAgICAgIHUzMiBpcF9tYXNrID0gYW1kZ3B1X3Vz
ZXJxX2dldF9zdXBwb3J0ZWRfaXBfbWFzayhhZGV2KTsNCj4gPiArICAgICAgIHN0cnVjdCBhbWRn
cHVfYm9fdmEgKmJvX3ZhID0gbWFwcGluZy0+Ym9fdmE7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZG1h
X3Jlc3YgKnJlc3YgPSBib192YS0+YmFzZS5iby0+dGJvLmJhc2UucmVzdjsNCj4gPiArICAgICAg
IGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFpcF9tYXNrKQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gKyAgICAgICBkZXZfd2FybihhZGV2LT5kZXYs
ICJub3cgdW5tYXBwaW5nIGEgdml0YWwgcXVldWUgdmE6JWxseFxuIiwNCj4gPiArIHNhZGRyKTsN
Cj4NCj4gZGV2X3dhcm5fb25jZSgpIHNvIHdlIGRvbid0IHNwYW0gdGhlIGxvZ3MuDQpJdCBzZWVt
cyB1bmxpa2VseSB0byBydW4gaW50byB0aGlzIGNhc2UsIGJ1dCBJJ20gb2theSB0byBjaGFuZ2Ug
dGhpcyB0byBkZXZfd2Fybl9vbmNlKCkgb3IgZGV2X3dhcm5fcmF0ZWxpbWl0ZWQoKS4NCj4NCj4g
PiArICAgICAgIC8qKg0KPiA+ICsgICAgICAgICogVGhlIHVzZXJxIFZBIG1hcHBpbmcgcmVzZXJ2
YXRpb24gc2hvdWxkIGluY2x1ZGUgdGhlIGV2aWN0aW9uIGZlbmNlLCBpZiB0aGUNCj4gZXZpY3Rp
b24gZmVuY2UNCj4gPiArICAgICAgICAqIGNhbid0IHNpZ25hbCBzdWNjZXNzZnVsbHkgZHVyaW5n
IHVubWFwcGluZywgdGhlbiBkcml2ZXIgd2lsbCB3YXJuIHRvIGZsYWcNCj4gdGhpcyBpbXByb3Bl
ciB1bm1hcA0KPiA+ICsgICAgICAgICogb2YgdGhlIHVzZXJxIFZBLg0KPiA+ICsgICAgICAgICog
Tm90ZTogVGhlIGV2aWN0aW9uIGZlbmNlIG1heSBiZSBhdHRhY2hlZCB0byBkaWZmZXJlbnQgQk9z
LCBhbmQgdGhpcyB1bm1hcA0KPiBpcyBvbmx5IGZvciBvbmUga2luZA0KPiA+ICsgICAgICAgICog
b2YgdXNlcnEgVkFzLCBzbyBhdCB0aGlzIHBvaW50IHN1cHBvc2UgdGhlIGV2aWN0aW9uIGZlbmNl
IGlzIGFsd2F5cw0KPiB1bnNpZ25hbGVkLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBp
ZiAoIWRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWQocmVzdiwgRE1BX1JFU1ZfVVNBR0VfQk9PS0tFRVAp
KSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IGRtYV9yZXN2X3dhaXRfdGltZW91dChyZXN2
LCBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCwNCj4gdHJ1ZSwgTUFYX1NDSEVEVUxFX1RJTUVPVVQp
Ow0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0IDw9IDApDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAg
ICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmgNCj4gPiBpbmRleCA4Y2QzMDdiZTcyNTYuLmM5YTQxODc2ZjEwZSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuaA0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oDQo+ID4g
QEAgLTE1Nyw0ICsxNTcsNyBAQCBpbnQgYW1kZ3B1X3VzZXJxX2J1ZmZlcl92YV9wdXQoc3RydWN0
IGFtZGdwdV92bQ0KPiA+ICp2bSwgdTY0IGFkZHIpOyAgaW50IGFtZGdwdV91c2VycV9idWZmZXJf
dmFzX3B1dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKTsNCj4g
PiBib29sIGFtZGdwdV91c2VycV9idWZmZXJfdmFzX21hcHBlZChzdHJ1Y3QgYW1kZ3B1X3VzZXJt
b2RlX3F1ZXVlDQo+ID4gKnF1ZXVlKTsNCj4gPiAraW50IGFtZGdwdV91c2VycV9nZW1fdmFfdW5t
YXBfdmFsaWRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ib192YV9tYXBwaW5nICpt
YXBwaW5nLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2
NF90IHNhZGRyKTsNCj4gPiAgI2VuZGlmDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYw0KPiA+IGluZGV4IGJkMTJkOGZmMTVhNC4uY2NkZTFmMDQwY2VmIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBAQCAtMTk0
MSw2ICsxOTQxLDcgQEAgaW50IGFtZGdwdV92bV9ib191bm1hcChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfYm9fdmFfbWFwcGluZyAqbWFw
cGluZzsNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfdm0gKnZtID0gYm9fdmEtPmJhc2Uudm07
DQo+ID4gICAgICAgICBib29sIHZhbGlkID0gdHJ1ZTsNCj4gPiArICAgICAgIGludCByOw0KPiA+
DQo+ID4gICAgICAgICBzYWRkciAvPSBBTURHUFVfR1BVX1BBR0VfU0laRTsNCj4gPg0KPiA+IEBA
IC0xOTYxLDYgKzE5NjIsMTYgQEAgaW50IGFtZGdwdV92bV9ib191bm1hcChzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVO
T0VOVDsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyogSXQncyB1bmxpa2VseSB0
byBoYXBwZW4gdGhhdCB0aGUgbWFwcGluZyB1c2VycSBoYXNuJ3QgYmVlbiBpZGxlZA0KPiA+ICsg
ICAgICAgICogZHVyaW5nIHVzZXIgcmVxdWVzdHMgR0VNIHVubWFwIElPQ1RMIGV4Y2VwdCBmb3Ig
Zm9yY2luZyB0aGUgdW5tYXANCj4gPiArICAgICAgICAqIGZyb20gdXNlciBzcGFjZS4NCj4gPiAr
ICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKHVubGlrZWx5KGF0b21pY19yZWFkKCZib192YS0+
dXNlcnFfdmFfbWFwcGVkKSA+IDApKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHIgPSBhbWRncHVf
dXNlcnFfZ2VtX3ZhX3VubWFwX3ZhbGlkYXRlKGFkZXYsIG1hcHBpbmcsIHNhZGRyKTsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHIgPT0gLUVCVVNZKSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfd2FybihhZGV2LT5kZXYsICJIZXJlIHNob3VsZCBiZSBhbg0KPiA+
ICsgaW1wcm9wZXIgdW5tYXAgcmVxdWVzdCBmcm9tIHVzZXIgc3BhY2VcbiIpOw0KPg0KPiBkZXZf
d2Fybl9vbmNlKCkuDQo+DQo+IFRoaXMgbG9va3MgZ29vZCB0byBtZSwgYnV0IGl0IHdvdWxkIGJl
IGdvb2QgdG8gZ2V0IENocmlzdGlhbidzIGlucHV0IGFzIHdlbGwuDQo+DQo+IEFsZXgNCj4NCj4g
PiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICBsaXN0X2RlbCgmbWFwcGluZy0+bGlzdCk7
DQo+ID4gICAgICAgICBhbWRncHVfdm1faXRfcmVtb3ZlKG1hcHBpbmcsICZ2bS0+dmEpOw0KPiA+
ICAgICAgICAgbWFwcGluZy0+Ym9fdmEgPSBOVUxMOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4N
Cg==
