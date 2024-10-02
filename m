Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C42CF6D56
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184CA10E76E;
	Wed,  2 Oct 2024 17:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FzdQaj37";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BF710E76D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti5bvTtlRXxFlTREfxUaVuO+0PNVf5tD8QtQkA95qdsP/Eli0I/dzzgeM1ROW6yMEDcRe8AG9Pk8IHiP02+X1SN7ETroZHDf2i7dAmyha8w6d7YBJx29RU8P9EIl1mFmQmex6aPVjQKl2nGJ7+2htxg0mzqN9qTqwhRPs2Kf2S+c4IP6A4cLp7JRNXifPpDAPSZtGDa7n0tFO8stJ3YOmgOlenjgWbP682MYwXdGYGUYF+itbfL+1uXq287JzUupgQBbvd2aiEzCBJfsCXZ3HAm3EzXA653zGoHdTUl1pfDJjSVpRDs++ngHp2IT9kHjrUb75fFuNFgfU0+Fr++h9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TQ4dmWpmr+mPQ91OLYM2cgwU9Z7OQB+yqXwxNb0VXM=;
 b=rsrtu7jufDKtkiOabAs/MyWq/bxmv61hQe7jNTER9uwNgXGFcL8QO3eVZwb1/RdLBY7LIf/NnhBRmyvGAnh/UdyDQH6Y7ZdlY81Xk7vCpWHGNVN0dYaHbt0ZHA2omIECHhd55aHAc0DRRmGhZhuW94rQNOza5prhlMOOWmGtp+Rv9WgXbk/YYcGmXsRwmb3pbaDTwEvqVV24vhDlLFO5K6VysWW/orJI507kHjMTw/xie0FWNxZp9EzHBKKs/obF3D75YM5HkPLT6fN9EgBsiiScyFanLEqLvsljjOJn2a/0chL1AAHTMDIqzwD3IFAGlUCArLgUqk4ghZ9rxANjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TQ4dmWpmr+mPQ91OLYM2cgwU9Z7OQB+yqXwxNb0VXM=;
 b=FzdQaj37BgTqqm/bEHHykaNIC8vtXDLHIfiWe0QAs8qclf5EYOxS1z3R/xhXIcXAQ2hBFvgo8EC0wfoveEv/s8pzp6oZK0fmG5ZVXfw9+oZExXeRoQ4zUQXCIFf7hN1Fi/Dr4AGnSmTaJmcBNCjuwJX1LXxZWC1/i+1ucNEWnqA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 17:04:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:04:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: James Alseth <james@jalseth.me>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Rosca, David" <David.Rosca@amd.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Amd Gfx
 <amd-gfx@lists.freedesktop.org>, Regressions <regressions@lists.linux.dev>,
 Sigmaepsilon92 <sigmaepsilon92@gmail.com>
Subject: RE: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
Thread-Topic: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
Thread-Index: AQHbFIGXUCWlOYCpjUWmxPPeCwJGr7JzsQaw
Date: Wed, 2 Oct 2024 17:04:44 +0000
Message-ID: <BL1PR12MB5144E3FDA00E09715F17E538F7702@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <O8AQvEr--B-9@jalseth.me>
In-Reply-To: <O8AQvEr--B-9@jalseth.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=88ab2896-2afc-46a3-83e5-d6cb0bef92a9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-02T17:03:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW6PR12MB8736:EE_
x-ms-office365-filtering-correlation-id: f54cf04a-4d23-4a0b-c10e-08dce3045029
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXpIQWdxSFJhb1VpWC9JUTZYN0tLbStudkttTzRDb2Nla3ZFOWhrbkhmN1Y3?=
 =?utf-8?B?V1c4dkY1dXQ3bFBuKzNkdVdjc0thdm9RMFZOcStQMEgwU2w5ZkplN2U4dVZQ?=
 =?utf-8?B?S3IvWUlHU1RXUllIL3Y0UitxUis0TlJPeUV2SEZWM2pCUHB0Sys0TWdIajVX?=
 =?utf-8?B?K2VMYmVVa3RLUFdmR2xCWkVlUGdpaExPVVdGOUFjajBMakJyVDhhcVlSOWNk?=
 =?utf-8?B?T3ZlTndOTkNHTFdUbG5OclRiYVUyL0p0WjNRN2ViU1o3TFJXVCtGcHhzazk4?=
 =?utf-8?B?bWJzdmFlbFp5dlQ3djhVRXEvNHljazAzdlZzSUJWZW92bHhreG8yOGlLYWJk?=
 =?utf-8?B?UFcrUjN5T0szRzhZWC9oRldoMFE5VHpCbG1rQXBwQ24vSllIcXRMTU5McUZt?=
 =?utf-8?B?SzBNY3htNlBKRkdmck90MThRclUzd0lMZE90ZkxsU0FQWnh2SlNkN083MVd2?=
 =?utf-8?B?cVlRYk5zN0gwSkRoVUVOcmY1UTBkdGdZTnlQeE4xVWNoeTN3eGdPTnBNUmhv?=
 =?utf-8?B?Y2pRUFkrKzV0aTJVQXk2QTgydDYzZzY3OVlZNGNBVFpkTVQxd2dsZDVPakdF?=
 =?utf-8?B?T1M3cXpsQzZML2g4U3RyREI5Uy9QVDkvREZjYkU2MUlmREpjeTVoaFlkS1Ar?=
 =?utf-8?B?OGhxUDdmSStTWEF0TnYvcVZGTkNNN2I5UFpGNC8ycnhGUHBjaWZBVEVUR0Nz?=
 =?utf-8?B?ZkJaaG1YOFJGY1ZxbU5GcFAwU1Bqc1pKVVNxdElpZWhyYTV2Z3NlbURhUHZm?=
 =?utf-8?B?WkZWdjhYeXM5OUpXODJWeGdtblRiaWZGdGdMaFpadHQyZjFnWk5qbXVJVmRm?=
 =?utf-8?B?akdEM0JTL0p1N1VnaUVqQVdDWHJiY011cE42cHBLaVkvOWZoRnBTWVJmV3hF?=
 =?utf-8?B?ZUp6WGtEcE9Cb3k1dUY3WUdXYkxrcys2RU9Od0t1OHNpL282bEZoaUhhRTRT?=
 =?utf-8?B?cTh5bzBRUytCZjJtZ3NSOHNGblNnYmU1MU1sNGVJcWRlNURBeHVIY0t0OEE5?=
 =?utf-8?B?OHJQRWxSMTh3akxZYjUwQUN2UnZWY0Izem0va2FSN09kVExabEZQVU5nczQ5?=
 =?utf-8?B?SmlPRXZ6eFdXV3hMWVFHYlNNMC9DYkVoRkZLNis1UU04WmtUaFJVK3ZIeXAz?=
 =?utf-8?B?cTBzWVJ0WGs1SW9JUGkycmFTZWdDVkJEWnVSQVk1SGk1V3Nhc3RkanNmdUdk?=
 =?utf-8?B?R3hvblRzRGlDN29YMmROVXVTTG5TcmkwSDJRdGVnQkdhV0dYMzRnN3pJMTha?=
 =?utf-8?B?ZDl0ZVg0OHJYa21IZElDYjV5N1ZXcFFlb2NPQUVkVEFPNXNBNG1jajJLSmtN?=
 =?utf-8?B?NlN4SmNOaS95d1ZpT0ZVK002eG9vaXlTTUFYZ1BHa09idmlKd0pPYjJsVmJR?=
 =?utf-8?B?dktMdEUzbkYwK0JGWFRiTUxPR01uam9Ec1NVODFkdFNicmVGRjIvTVN6UERX?=
 =?utf-8?B?K2hoUDRBWnQ5OWNiM2t4S2FrMmttNkhEWG9yRTFZSEUvNFg4alh5U09pWU8y?=
 =?utf-8?B?NS92L2hDYjRYV095YStMMEttQkptRUJMb3hGK3NpV3RVR09YZ0dsOU1IL1Zo?=
 =?utf-8?B?MDhNTGtNS1hlUTYwNGhsT2RkK0k0dGU3OWY4L2Z5MEN4MGNtZlZ1dmdZZEY4?=
 =?utf-8?B?Zk5rZm5JQkdCaEtTaUV2R3ZwZWI3a2Y3Ynp1RzE3c2dmQXJ1U2x2M2ZFaXp6?=
 =?utf-8?B?Zy9LVis4QXdHRWxTZmJLR2x4TGxzZmpZeUVoS1FmTmgzc3dsRjBYZzNGeXNZ?=
 =?utf-8?B?QlJEUWtvS0p1cUpVcmovbmRTRmFjLzJDb0NsaFpxVnlHN0lua3lHWGdnaTdo?=
 =?utf-8?B?QS8wVm40U054a1Z2bytkQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUZLRWpIRHdBSndyUVR5OXlkeDdjamJGUjVCTTkzRjNyZk1sNU5yWk96ZXY0?=
 =?utf-8?B?TkJOZ1RUajNNYWRLcHV1RzJHZ2lyZGY1bWxOOXNBRm8xK1ZrWEtJOVZsMHZr?=
 =?utf-8?B?NmswcW54R0x4OForK1VlL0x5TDNNUWZ1U0VsWThScjRSeWRZVUEwQzFhWGdo?=
 =?utf-8?B?QWRuTzZGTXVUcFNZUWNtSlVkelBnVXo3NjEzZWUwbmJjVGgvOHBLbUZ5Nmkr?=
 =?utf-8?B?b0tQVmp1UitoYlNUYTRaSTBuUkNYTXpGb3JSTjAyenRWS0V0RlQvOGhxbUpm?=
 =?utf-8?B?Zk9pTkwrM1VuTHNUSjZHTGM5cG0xZ25HblhBNElsaGMvYmlydUY5MnFrcldw?=
 =?utf-8?B?UmtHUG13MzdkKzJuUlVwVkx0WWFtYlVjdUZPdE9tc0ZTSk9LK3pjNTZBVmdL?=
 =?utf-8?B?UHdIQWZScDJEMVd3dS9PV0x2eUo5K0dxSXh5RDlLdGR4WlFDRi9HUTBGMC9W?=
 =?utf-8?B?dGZSZ2c2aHI3Rld0VVNldk1IbjA5N3BTa1NnN3lxcVNwNXgrUnF1dmtveG10?=
 =?utf-8?B?aXdNaTFmYnBaeXVnekRib1FoQ0RHdFYyVmxYb1B2V2tVZ3ZsMlc1RDdlSjFZ?=
 =?utf-8?B?d2ErUVpJWWR5TTVtNHRCQkRyZ3RSVktZbVFhMDdSaElCbndzZTVOakRmMk0r?=
 =?utf-8?B?MGZuMVVna1B2MXFRejFiRXA5c01Ca0NCMU9SenpyMHc1TEhTazhBZ09UWFEv?=
 =?utf-8?B?elhUd2JrK1lxWjErdHdRR1VKM1FmNVIrSlpvc1F4QjVwc1ZHZ1RmWUx4WWVw?=
 =?utf-8?B?ZnErS2lIS0NrSmt3Z3d0NXk4UGViMlB2Z0JaandQK0YxTElLVnBkMlFsL0RU?=
 =?utf-8?B?aUtjVkp4RThYa1drbHZTRUlFSElGQW5SQlF3T1F5bEs4bWUwMGdzTWFMVDdE?=
 =?utf-8?B?ejR6TXRkZUp3ait1bmlXUCtSSWh0ckJza0NYVXJ4YjZZUDhRRTdLbmVEblh2?=
 =?utf-8?B?emE4TlBGK0psRkhQVzRJU1ROQ1RrMythcGg1bks4Q3FZREd1dk5RU0ozdkJ1?=
 =?utf-8?B?UDRQQnpKcjNld1dRZWlXN01hcWY2dDBuNkJhanA5NWJlZWhNM3orZnRFQ3Ju?=
 =?utf-8?B?cjk2N2NTMGljeXl4OGdQZjJJVDVtMVM1NkVCYyt2c0pSOThaQnZrUzNDMXNo?=
 =?utf-8?B?Ky81QkVTSkVvcDk3eTUrWi9qNU5PbUtqd3habTlqVTZzR0Zkc0JkMkhTd0x5?=
 =?utf-8?B?MGFCaU90UEJQVDN6WmMrS2VoaHVjZmoxNjN1c1RkbVNQWGFoeFQ3clUrd2pF?=
 =?utf-8?B?N3g4L0lVbUdPaVRnWlhCZXRWa2dDVUZhVkhHSWlLN0lWc2Z1clBUY2dxaDF6?=
 =?utf-8?B?VGdCdW5UWitRTFNkWFlkYy9nZUgrYjhPWnhaMlcxajkwYXB1NzRuemFCWDlH?=
 =?utf-8?B?SkdJOTViRmI4dUpzc0ZUVEdZcFlpZmd4TXk1a2t3TjZCNHRDU0h6dldSR0Er?=
 =?utf-8?B?RnJ1OU9nMEF0QkZQelBCS3Q0a09VdWJ3UU1VdkNxbU9GWElCREF5S0drZ04y?=
 =?utf-8?B?WnV3cXU4YUtsWVZoak9ZK285NUdiQzd6WGdTZ2ZxM2FzWW1VeTV0VEgra1k1?=
 =?utf-8?B?RzZaL09nRklJWWRrQ0ZLRXpITm5hcWVYcTRHeStEZmREemJSSDkvR25WaGFC?=
 =?utf-8?B?dFVSMnpvT0FBWXordDJKeXJGTU40QmhobFcvejZlRTMrSjNTbkNUV3Q3V0kz?=
 =?utf-8?B?OCtWNUYxTUppQXYvWldQSTMrVlhQYjNSZjZNM0JadVNQUHltZkluNUJ3a0po?=
 =?utf-8?B?amJuQTE5UEFoWGpZcEhFMUY0YlIrYnRkY1drQmhCNWhWZzZVKzNxa3hHY1ZR?=
 =?utf-8?B?RFhOVFIrOWw1RUNGUCtWRGNBeVhoSFJjTkVFRERFZStlTlFQMlZsR1FEells?=
 =?utf-8?B?eWtCZzVURzl4RmlzeXFmNnVOZU55RTFiT0pxaWxUc0xHUzRucDNOaTFtVjJO?=
 =?utf-8?B?LzUreCtGbzEwS0hYcEUwT2UreVpyVFpaa3FSdS9Uc25DVzliZ1JGbW1vL0xE?=
 =?utf-8?B?M28yeWpFdDR0ME5UV2ZmYzZVTzNrem0rWEp4ZG5GRmkvenY2N1greE5LVkov?=
 =?utf-8?B?aks2UzlWUjNBdWRueGM2SGVHd1c0SlNIcG1JdXQ1blo1TDgzcDJjclcyY0JO?=
 =?utf-8?Q?wjug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54cf04a-4d23-4a0b-c10e-08dce3045029
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 17:04:44.3829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73c50l9hhBvuOpSu7LUUlfYGsmlEK5YoYjpUd8T5BVboRtks3VlAyPLYHeg0augqc4O2ntteWfMU5j+gcelpOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW1lcyBBbHNldGggPGph
bWVzQGphbHNldGgubWU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyLCAyMDI0IDEyOjE0
IEFNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiBDYzogUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRl
cg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEFtZCBHZnggPGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPjsNCj4gUmVncmVzc2lvbnMgPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4
LmRldj47IFNpZ21hZXBzaWxvbjkyDQo+IDxzaWdtYWVwc2lsb245MkBnbWFpbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiA3ODQwVSBhbWRncHUgTU1WTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRVUw0K
Pg0KPiBIZWxsbywNCj4NCj4gSSBoYXZlIGEgbmV3IGxhcHRvcCB3aXRoIGEgNzg0MFUgYW5kIGFt
IHJ1bm5pbmcgaW50byB0aGUgc2FtZSBwcm9ibGVtIG9uIGtlcm5lbA0KPiA2LjEwLjExIGFuZCA2
LjExLjAuIE15IHN5bXB0b21zIGFyZSBzbGlnaHRseSBkaWZmZXJlbnQsIGluIHRoYXQgdmlkZW8g
cGxheWVkIHRocm91Z2gNCj4gRmlyZWZveCB3b3JrcyBmb3Igc29tZSBwZXJpb2QgYmVmb3JlIGV2
ZW50dWFsbHkgaGF2aW5nIGEgR1BVIGNyYXNoLiBUaGlzIGNhbiBiZQ0KPiBhbnl3aGVyZSBmcm9t
IHNlY29uZHMgdG8gMTArIG1pbnV0ZXMsIHRob3VnaCBJIGRvbid0IHRoaW5rIGl0IGhhcyBldmVy
IHBhc3NlZA0KPiAyMG1pbiBvZiBwbGF5YmFjay4NCj4NCj4gUGxlYXNlIGxldCBtZSBrbm93IHdo
YXQgaW5mbyBJIGNhbiBwcm92aWRlIHRvIGhlbHAgd2l0aCByb290IGNhdXNlIGFuYWx5c2lzLg0K
DQorIERhdmlkDQoNClRoaXMgc291bmRzIGxpa2UgYSBtZXNhIGJ1ZyB3aGljaCB3YXMgcmVjZW50
bHkgZml4ZWQuICBDYW4geW91IHRyeSBhIG5ld2VyIHZlcnNpb24gb2YgbWVzYT8NCg0KQWxleA0K
DQo+DQo+IFJlZ2FyZHMsDQo+IEphbWVzDQo=
