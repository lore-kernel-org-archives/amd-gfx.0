Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABECC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0146310E563;
	Wed, 28 May 2025 02:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iIyoxT2B";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B5F10E556
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmS0oPfSGD/bbNC744AOl9WT01x6QD9D9MWTJNcNwfIFmGBm0Rk4Sv4ggnPq9vl/Jxtfrn+C9MxsduZfCD1xopRRHyHRn5gfPSmhVrxl/xlmWM9QfT6mcq1vfmcsfkzn6/FSvDcyN5QR0dXSuQ9hjK44SDc+eY4P2fJr2egiVx6W0K3p++yBI8duVvccmGOrGAcsKOWdHv3LtLd18uGv+/8IEqn3j/1EhF1Xau2jI/p6I0Ca2M9OgEGewaIq/F3VVh4d8WsWvHwmw01zh0b/1+W4AU/exS49m+pvu8K4am6MN8//ncPu3/xo7EO8NTpE0PZrNg72fjXcbR7kri9Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyaGw14J1wAk0tmecsbYsj8KANkxAtcL5nw9gYIV2fE=;
 b=GI2sQ8ft9tQDovchgRnji/LOdtpfSvEr+weEIIpxVCgC4CWal4Grv22ivd1ajRwp83UVPdxWVs0aNASea/YDEfueZmsxDiof9xZDMhMavEqJdGST/LIORWBut7ZSLLJJRxYhH1K6ROIIwx9XP88/RrkzY6HmEpwaPfJ66ZucKPIGLCg2e7wGni2ZmHkCkn4+MWZsfrfe9bttUTsmH3ED0AvAoBxWKaIxFPJcscX3/CCxuVnmdTsGvXbllUufQUyX4z9pGceG57wF4q+WWejRPRWj9CYSMw7hDuyYjDrWx3i0ZCa3GQdPenzluBDAW9BCsCUIbWeWGWy4+CzZb+kdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyaGw14J1wAk0tmecsbYsj8KANkxAtcL5nw9gYIV2fE=;
 b=iIyoxT2B6dNIq9XqwJH22jhiOE+P92lX1/RMmhoDpQWiuUnNw9dtbL+Q7wd+huY/mFdYOfuHejqw7fujlytTNwbDGbt0EtwQwQClBX96NfVoPMGI2eYOaioEXpVn6jFgZnqZPkj49Ij4hFoa6jm1t22+mKyvsOaRyrlRm5gQO4E=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Wed, 28 May 2025 02:09:28 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 02:09:27 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the
 dependent read fences"
Thread-Topic: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the
 dependent read fences"
Thread-Index: AQHbzuX9RG+AgIhEx0aYvw3ges7yZrPmVteAgAAPr4CAAOSMAA==
Date: Wed, 28 May 2025 02:09:27 +0000
Message-ID: <DS7PR12MB6005E353FB443F8C6A4FEF72FB67A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250527085814.3853953-1-sunil.khatri@amd.com>
 <6316cfc5-5b63-4a0b-b290-087c19f68790@amd.com>
 <BL1PR12MB5753D89DC58DD90E37F22D159364A@BL1PR12MB5753.namprd12.prod.outlook.com>
 <626b28e9-275f-48e0-b209-9c3497f27249@amd.com>
In-Reply-To: <626b28e9-275f-48e0-b209-9c3497f27249@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=51aee946-9019-4719-8e7d-edf2fd4b42a3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-28T02:01:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB8341:EE_
x-ms-office365-filtering-correlation-id: 0f30449a-25f6-43a8-ce45-08dd9d8cacb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?OXlmTVZwK09XamJZRm9jQnRiYXR3d0ljNWh1OEZFME9wVTUwV3FTTHlLTE43?=
 =?utf-8?B?RTlxMzNyZUlZTnJFT1FMcGdQd3VvY0pRNndHSWNZQVBKWllFZDQ1bG5KSisx?=
 =?utf-8?B?Rld2SXNuc1dIbEE5eTdZV2VDMFRpMXA2aGl5cFhST2pneDhXUWxEYjBQem9K?=
 =?utf-8?B?VHNIdTFKVEp0STU0bUpsRk9Vb0dySy81eDlxc3Z0N3FraTgwYmdxd1crOXli?=
 =?utf-8?B?L1FDdDdsRTAvaHYrc0x1QTlPU0E1SUp3L3lrQjlQN2V3ZEc5KzMwN2JyNk81?=
 =?utf-8?B?U3oxZkVRdDFUVUFsRmtUdUpubVVOYUVIcU93TnlxME0rVW52MUdnajRxR3pi?=
 =?utf-8?B?bmlGMHYyZnlnalJvRGgrNUQ2UXowWXhxcFZZTXpkWXFBazVJR2pNMGlVYjhw?=
 =?utf-8?B?NDF3cWVjck8wNjdiQ2JoakVKR2UyZlR5S0RTRTN6ODI1dEFCYkJBMm0wQlhv?=
 =?utf-8?B?SUs0RC9WRnlWNlFmTm5zbFRiOGwzeFBOTmJFdzdvNGtSUzJaWm1Ta3V0U3hP?=
 =?utf-8?B?dENYaTNNQ2JXSm9Qa2RTaG1xTXJ3TnR1Wml3K1BHNmxiWm0yakpJNXlMc0Zy?=
 =?utf-8?B?SWFWb2pzalp1U3luM3ZqSXB0MWdvUk5RRlhJaklaMnpHU0dhWk40b2xnRjda?=
 =?utf-8?B?dXNsVDlRTllJMWxpaCttSEJ4cUR4UGRVL2x2dTIvY3A0VkNPM1Rsb2gyZFMx?=
 =?utf-8?B?Q01HcnVDL2wrSW5rRmZaY0dKU3phM2hhL3padlFRU2VMVGRtcTZ1MkhVNnV5?=
 =?utf-8?B?ZDluckhBQ1BrZWgvdTZFME5DVlNBSldDWUxqVDJMcWpLRVM2dExkblVSRlRh?=
 =?utf-8?B?N0tjY0RGZ2x5TUhxV2p1ZDNNYzhLc3FJbExzaGovWml4dXEzTU85RXZoM1g1?=
 =?utf-8?B?eHBmQWpGUCtsVEYwbW05OE1uWENHS2dMV3Y0eEFaSDM1YUR6TFZhNGhRVll3?=
 =?utf-8?B?NDJuS0xKeGJNNkVtbkg3TVlCVzZrYjVHUWt0bnFuSWpiL01sVTRIZGJyaWlG?=
 =?utf-8?B?ZFVsTk85ajFyazVzWHk4VVM2VW5PTUYxR0Qyczl5dURCRkkwUUU5NGdoNktn?=
 =?utf-8?B?LzZoQXRSdTdpL015QmlqRGhsWWVvMmdXbmw4U08rS3dCN1F4SS9JZG5TdWlI?=
 =?utf-8?B?dThQR0dpWWhCUlZwZTY5Y0pLVXZBSmdCUmJIYVlJTUN4N2dDazJMVTFTalN6?=
 =?utf-8?B?aUlIRzJ1a045WTc0Y0Z4UlVNUURQa1duVkVVN2trTzJna2FpbUlTTE1HeVlp?=
 =?utf-8?B?ZjZBTWFqL1RXOXFpYVZ2bnNDWDVNejU5dkNaR3h3bjRGTytoK2w5TmNJc2cz?=
 =?utf-8?B?SHZ1cDNDOGJlTktLem9zeWQvSjcxT2k4SHQyOEJMcGVJL1NjQ2NmbXBWWUJq?=
 =?utf-8?B?Zk9nNHczUWpqakpFZ2YrbXVPOEZVVk9WVWlOZ25Mc1BnOG9VOWJVeHFxTzVO?=
 =?utf-8?B?UFFaQ3h1RHBvT0M1VDJqWjdKRTNJT2EyUE9QcjRLODJhcWZMYThIVG1IRm41?=
 =?utf-8?B?MHdrWU5PQmNvYzdGZkRPWERVNHMvdUlrb0l2U1hkRjFRWkw2QUo1aXRWSElm?=
 =?utf-8?B?MEthZUx1YzBiczNPM1d4LytrWkQ0MndYZUFDcXN6WkxZQTVkQy9EeithNm5j?=
 =?utf-8?B?eWZNUDArOWd5QzJxVm9VODhZWUNBZWZnbndkekpyb1pFdnU2M3Q1Z2VVeU1i?=
 =?utf-8?B?Q1M4dHF1aE1QM3BJNmlHOE5tV2V5NUJIbitOMjJWZHNmbXF4bHJJVFhLK2dL?=
 =?utf-8?B?L0tiWWxOMkJKVjJJcnZFK0VjaWgvbU9sNW9IczFjWmhvVnArYUtzcStKdStu?=
 =?utf-8?B?dW1YZExVNFdYSFhDRGQzTnVXZ0swZXEzUEQ0ZDg0L2l0aHVIbEhDY3cxTEp1?=
 =?utf-8?B?R3loMyttaFgwMUlwWStsOTdNV1QxUzhGaTIyeWlJWlNYN1ZrY0JnRDV0Z3ZN?=
 =?utf-8?Q?XW/1fkhAoLE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGY1bUl1S0ZsN3YwMm5TWVZwNk1CZ1lRYTEzUmd3QXlERjFvN2czNllGUGVR?=
 =?utf-8?B?ZVJ0MDNodFNyeTZmMW92ZjVSNVhuVlF2NTdwRVVxNTdOOFNEZ2sxd0xyVVQ3?=
 =?utf-8?B?ODZ3MkV6L2tsam9aUXlOek5DTzVvVHdkdG1aUnJDdmpBVUhaN084L3RNTDJB?=
 =?utf-8?B?YU0xZDREZXRhL2FCclB0ZlA5elZ6TU1UQkVrSzBjZVdSVHV6Rk9JZ292S2Fr?=
 =?utf-8?B?RUhGRUZGM1FiQ05hcW9SZFZtcFY1eDArczZYMkFKRlJvdlBLcDQ2MUkyZkxn?=
 =?utf-8?B?RVUvRHRSQmhiUWgyLy9MYzIrMm9JL09FdWdlRmNFN1ZBbythbEdvWlRJcGIy?=
 =?utf-8?B?cm9GZzM0anBvL1BORXNqTTlJZjQ2WE1VRzE1TWtXQzVsRy8vc3ZLNDRJQkxt?=
 =?utf-8?B?ckxvU2VIWHY3aDVJSEV0bUxmTXh5bXlDN1c5S0pKdUoxczBicFNBMXkyeEJm?=
 =?utf-8?B?dUw3VEUyR0V4VFpRM2RLU0J0L1ZWVm8yTCt2L0JOVW1vcldpTDdNMFpPdkNO?=
 =?utf-8?B?RGJRTFR5NkZCS2dOMTA1dE1NVUkrSGxvSjNYcklTOVNPVFM2aUpFVmZ0UTNR?=
 =?utf-8?B?bHEzcVVONXhpMXBHVmZlV2ZVdUU5Tzg4TUdrdnVMV2RGQlZsSGpxZW5jdjlT?=
 =?utf-8?B?V0hLcndGYnJFOU9WdGJQTER6WXdtNGNPT1VZZ0wwaHdQTFF6QXhENmlwMEp5?=
 =?utf-8?B?cUNkUXhMa1B1UStHOVpiOEhvcDlPNWZVZUZoRFY1bzg4K09la3ZWRkl3WXdD?=
 =?utf-8?B?ZmNxakRWWVJCVWc1YjdVUFl2VVNwa25SM1RXam1ZeS82VmVEREMxemoyVVpt?=
 =?utf-8?B?V3ZrclVNUXBOV3dNbTZRN21nUVk5YWNSUENYNEFNNnRxZE9vcU1KS1RxVThO?=
 =?utf-8?B?dGpnTUdZY0p6cjhHeTd0Wlg2ZlZiOGFDZGR5dTlKVWhWODZjOFB0Qkt1TWFx?=
 =?utf-8?B?ZncxWW1LUjRBbEtXTkJzUUpiYjE0a3g2Tlh1WVQ0T3lSd2N5ZGpYbXNVck5R?=
 =?utf-8?B?MXJLSGpobUt4a2g4WHJ2RURYVlNzcnpUL0gzMjkvcmt3VVNnbDc4VG05d0pG?=
 =?utf-8?B?TTdvRFR1L0gxTjFNdGprZ1lhU0V6K3k2TmoyM25oZ0hpMEJuNjVrMnF3WXNm?=
 =?utf-8?B?NDUxaXBzZitMTkNSL3kyaGVaMUd6QS9VV200MzhEdVgzcXdYNUwyWmZrS3Nn?=
 =?utf-8?B?bEJLR1ZIZ1RGVHdCTGo1eFk3eFFPVHV0enM0TGpuRVFEb1Yyeml5dldSQ04x?=
 =?utf-8?B?ZUpsaGtkR2RZd2FUTUVmSWt3Zm1kNmlzY2E3V0NRUDBhMmRhbnQ5cEhiajFW?=
 =?utf-8?B?dXRDdUZSM0FwM0ZpREVFYnhpSFlwbklXQ3Q5Qkp1ckZhUTN5VGNiRXI4LzZJ?=
 =?utf-8?B?Rm53RjFYdFFTcWRIeWJjSUZIdisxNTMxanVXM1QxM1luRGFneHpTVmhEMUx0?=
 =?utf-8?B?cVQ0YzZKWWdiSVlTRzhjYjExdEdkc1NJeVdEVlF6ejhSVVYyeHRzejRtMGU0?=
 =?utf-8?B?M3pRTjNtTjJRY1hqcTNXZ0xhbnlXWkZnZEtCeU5hMERTazFyQzExRVJNMzNY?=
 =?utf-8?B?SE96L2xOVFRvWmw5Y3JPQ1AzZEx1R0hJRVBMa3JBaUZRU2MrbW5kTHBZZ3p3?=
 =?utf-8?B?YXJTU1hWa3Ftb1hrNHRHZUFtOUZ0S0c4TnczNWRnL0ZCblZST3ljQ0dMRENJ?=
 =?utf-8?B?d3k0QzB3djVnNGptemtEbmdraEdxZUxEZjVObUNKbWFTUjNGcUVad3QyTkVK?=
 =?utf-8?B?RHFuMXR6M1BnTVc3T1lIenEzNkJJYVBWc2JCMnliaGxCcmhLdTV3eDk3bCtR?=
 =?utf-8?B?NkMvNTIyRWJ2NUpnaUZLOVBjRHE1VVlKVzM0TDVqZ0tkbnhXOGJRUnNUT1hU?=
 =?utf-8?B?MXlWODhuUmFqczcyUWFpZ2xVTjBlbmk3V2RZUjMvZ1l2NXBZNG16emZLRDdS?=
 =?utf-8?B?Vmg2Z0V0eFdTNGs2ODlJTmlhUkx0djRmSCtkSlJoQkUrZmxQbXFGS2JqTXhl?=
 =?utf-8?B?R3MzZll4UVlqQUh6c1lhQnZ3NzFjMWQ5QUplWTg4WHdRSVdyWFgxZ0Z4cEFB?=
 =?utf-8?B?QWpNeU00Skd3clM5ZkZnTEQvM2dPLzFUTjNvY3dmVmN4R2svTVhjajBYZGZL?=
 =?utf-8?Q?3MXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f30449a-25f6-43a8-ce45-08dd9d8cacb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 02:09:27.4669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1Lq6wuSWoF+lneds2h4/ajEoa3nh70CgCAs4S66qwwEZkP+WXFIuWe/fS21gDly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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

W1B1YmxpY10NCg0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQ2hyaXN0aWFuDQo+IEvDtm5pZw0KPiBTZW50OiBUdWVz
ZGF5LCBNYXkgMjcsIDIwMjUgODoyNCBQTQ0KPiBUbzogS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hh
dHJpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwNCj4g
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBSZXZlcnQgImRybS9hbWRncHU6IHByb21vdGUgdGhlIGltcGxpY2l0IHN5bmMgdG8gdGhl
DQo+IGRlcGVuZGVudCByZWFkIGZlbmNlcyINCj4NCj4gT24gNS8yNy8yNSAxMzoyNywgS2hhdHJp
LCBTdW5pbCB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFs
IERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiA+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNywgMjAyNSAyOjMyIFBNDQo+ID4gVG86IEtoYXRyaSwg
U3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPjsNCj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gUmV2ZXJ0ICJkcm0vYW1kZ3B1OiBwcm9tb3Rl
IHRoZSBpbXBsaWNpdCBzeW5jIHRvIHRoZQ0KPiBkZXBlbmRlbnQgcmVhZCBmZW5jZXMiDQo+ID4N
Cj4gPiBPbiA1LzI3LzI1IDEwOjU4LCBTdW5pbCBLaGF0cmkgd3JvdGU6DQo+ID4+IFRoaXMgcmV2
ZXJ0cyBjb21taXQgNzE0YmJiZjIwYTcyNjZlNDg2MzJmYWI0NjY1NjNlNjk1YWY5YWNiNS4NCj4g
Pj4gYmlzZWN0ZWQgdG8gdGhpcyBjaGFuZ2Ugd2hpY2ggaXMgY2F1c2luZyB0aGUgZmxpa2VyaW5n
IGlzc3VlIGluIHRoZQ0KPiA+PiBVSSBmb3IgdmFyaW91cyBhcHBzIGxpa2UgZ2x4Z2VhcnMgYW5k
IHVuaWdlbiBoZWF2ZW4uDQo+ID4NCj4gPiBJcyB0aGF0IGZsaWNrZXJpbmcgYWxzbyB0aGVyZSB3
aGVuIHVzaW5nIGtlcm5lbCBxdWV1ZXM/DQo+ID4NCj4gPiBJZiBub3QgdGhlbiB3aXRob3V0IGFu
IGV4cGxhbmF0aW9uIHdoZXJlIHRoYXQgZmxpY2tlcmluZyBpcyBjb21pbmcgZnJvbSBmb3IgdXNl
cg0KPiBxdWV1ZXMgSSBoYXZlIHRvIHJlamVjdCB0aGF0Lg0KPiA+DQo+ID4gVGhlcmUgaXMgbW9y
ZSB0byBqdXN0IGZsaWNrZXJpbmcgaGVyZS4gV2UgYXJlIHBsYW5uaW5nIHRvIHVzZQ0KPiBhbWRn
cHUudXNlcl9xdWV1ZT0xIGluIG91ciBDSSB0ZXN0aW5nLiAgVGhhdCBtZWFucyBib3RoIGtlcm5l
bCBhbmQgdXNlcg0KPiBzdWJtaXNzaW9uIGFyZSBlbmFibGVkLiBXaGVuIEkgcmFuIHRoZSB0ZXN0
aW5nIGFtZGdwdV9iYXNpYyB0ZXN0cyB3aGljaCBydW5zIGJvdGgNCj4ga2VybmVsIGFuZCB1c2Vy
IHN1Ym1pc3Npb25zLCBhbGwgdGhlIHVzZXIgcXVldWUgdGVzdHMgYXJlIGNvbnNpc3RlbnRseSBm
YWlsaW5nLiBXaXRoDQo+IHRoaXMgcmV2ZXJ0IGNoYW5nZSBpbiBwbGFjZSBhbGwgdGhvc2UgaXNz
dWVzIGFyZSBmaXhlZCwgQm90aCB1c2VyIGFuZCBrZXJuZWwgcXVldWUNCj4gdGVzdHMgcGFzcyBj
b25zaXN0ZW50bHkgd2l0aG91dCBhbnkgYXJ0aWZhY3RzLg0KPg0KPiBUaGF0IHNvdW5kcyBsaWtl
IHdlIGFyZSBtaXNzaW5nIHNvbWUgZGVwZW5kZW5jeSBhbmQgdGhhdCB3b3JrcyBvbmx5IGJ5DQo+
IGNvaW5jaWRlbnQuDQo+DQo+ID4gVGhlIHJlYXNvbiBvZiB3aHkgdGhpcyBpcyBoZWxwaW5nIGlz
IEkgYW0gbm90IHN1cmUgb2YgYnV0IGl04oCZcyB0aGUgb2JzZXJ2YXRpb24gd2hpY2gNCj4gd2Fz
IG9ic2VydmVkIGVhcmxpZXIgYnkgQXJ2aW5kIHRvby4gV2UgY291bGQgaW52ZXN0aWdhdGUgdGhl
IHByb2JhYmxlIHJlYXNvbiBvZiBpdA0KPiBpbmZhY3QgQXJ2aW5kIGlzIGNoZWNraW5nIHRoYXQg
YnV0IHRvIGVuYWJsZSBDSSB3ZSBjb3VsZCByZXZlcnQgdGhpcyBpZiB5b3UgYWdyZWUuDQo+DQo+
IEkgdGhpbmsgZmlndXJpbmcgb3V0IHdoYXQgaXMgbWlzc2luZyBoZXJlIGlzIG1vcmUgaW1wb3J0
YW50IHRoYW4gZW5hYmxpbmcgQ0kuDQo+DQo+IFdlIG1vc3QgbGlrZWx5IGluY29ycmVjdGx5IHN5
bmMgdG8gVExCIGZsdXNoIGZlbmNlcyBvbiB0aGUga2VybmVsIHF1ZXVlcyBub3cgYW5kDQo+IHRo
YXQgY291bGQgbm90IG9ubHkgaGF2ZSBuZWdhdGl2ZSBwZXJmb3JtYW5jZSBzaWRlIGVmZmVjdHMg
YnV0IGFsc28gaGlkZSByZWFsIGJ1Z3MNCj4gd2UgbmVlZCB0byBmaXggQVNBUC4NCk1heWJlIHRo
ZXJlJ3JlIHNvbWUgYm9va2tlZXBpbmcgZmVuY2VzIHRoYXQgbWlzcyBleHBsaWNpdCBzeW5jIHdo
ZW4gdGhlIGRyaXZlciBkb2Vzbid0IHN5bmMgdGhlbSBpbXBsaWNpdGx5LiBJIHdpbGwgZnVydGhl
ciBpbnZlc3RpZ2F0ZSBpdCBhcyB3ZWxsLg0KSWYgd2UgbmVlZCB0byByZXZlcnQgdGhlIHBhdGNo
IGFzIGEgd29ya2Fyb3VuZCwgd2UgbmVlZCB0aGUgZm9sbG93aW5nIGh0dHBzOi8vd3d3LnNwaW5p
Y3MubmV0L2xpc3RzL2FtZC1nZngvbXNnMTIzMzQ2Lmh0bWwgdG8gaGFuZGxlIHRoZSBldmljdGlv
biBmZW5jZSBsZWFrYWdlIGlzc3VlLg0KDQpUaGFua3MsDQpQcmlrZQ0KDQo+IFJlZ2FyZHMsDQo+
IENocmlzdGlhbi4NCj4NCj4gPg0KPiA+IFJlZ2FyZHMNCj4gPiBTdW5pbCBLaGF0cmkNCj4gPg0K
PiA+IEl0IHNlZW1zIHRvIGJlIHRoZSByaWdodCB0aGluZyBUT0RPIGFuZCB3ZSBhcmUgc3RpbGwg
aW4gdGhlIHByb2Nlc3Mgb2YgaGFtbWVyaW5nDQo+IG91dCBhbGwgdGhlIGJ1Z3MgZm9yIHVzZXIg
cXVldWVzLg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPj4gQWxz
byB3aGVuIHdlIHNldCB1c2VyX3F1ZXVlPTEsIHdoaWNoIGVuYWJsZSBib3RoIHVzZXIgYW5kIGtl
cm5lbA0KPiA+PiBzdWJtaXNzaW9ucyB0aGUgdXNlcnF1ZXVlIHRlc3RzIGluIElHVCBhbHNvIGZh
aWwuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJp
QGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3N5bmMuYyB8IDUgKysrLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+PiBpbmRleCBkNmFlOTk3NGM5NTIuLjU1NzZlZDBiNTA4
ZiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5
bmMuYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5j
DQo+ID4+IEBAIC0yNDksOCArMjQ5LDkgQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4+IHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywNCj4gPj4N
Cj4gPj4gICAgICAgaWYgKHJlc3YgPT0gTlVMTCkNCj4gPj4gICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPj4gLSAgICAgLyogSW1wbGljaXRseSBzeW5jIG9ubHkgdG8gS0VSTkVMLCBX
UklURSBhbmQgUkVBRCAqLw0KPiA+PiAtICAgICBkbWFfcmVzdl9mb3JfZWFjaF9mZW5jZSgmY3Vy
c29yLCByZXN2LCBETUFfUkVTVl9VU0FHRV9SRUFELCBmKSB7DQo+ID4+ICsNCj4gPj4gKyAgICAg
LyogVE9ETzogVXNlIERNQV9SRVNWX1VTQUdFX1JFQUQgaGVyZSAqLw0KPiA+PiArICAgICBkbWFf
cmVzdl9mb3JfZWFjaF9mZW5jZSgmY3Vyc29yLCByZXN2LA0KPiBETUFfUkVTVl9VU0FHRV9CT09L
S0VFUCwNCj4gPj4gKyBmKSB7DQo+ID4+ICAgICAgICAgICAgICAgZG1hX2ZlbmNlX2NoYWluX2Zv
cl9lYWNoKGYsIGYpIHsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFfZmVu
Y2UgKnRtcCA9DQo+ID4+IGRtYV9mZW5jZV9jaGFpbl9jb250YWluZWQoZik7DQo+ID4+DQo+ID4N
Cg0K
