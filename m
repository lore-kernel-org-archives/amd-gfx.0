Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B0FC3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 08:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8AC10E2BC;
	Fri,  9 May 2025 08:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AB+MZpv9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5758F10E2BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 08:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnqqlOpSH2ey+mBGOHIZ4ks1xdZ61TJzpitgtJqh9bT89VGpX+K10B2ZGmMzpp/PzUSEboRNZwXInWTgWbi3/3Q7bWwsR/3b3o5Yj2jQINsKGp2tV6UkAbaWvk01CxGQ4sm6vHK2IfdYESwFavlmBO+2UBlDg8EviSLVH87zU2oby+C4wUDD4ru+yfxdu5rIYXoXVbkTMlPhOPDhji6wKdWINI2FPHapC9a5plVkkNBANW7ooxUuhkV5/ObYmlvqXa1FphiE9Wm75iaNF7DMk7a4e8MDEP5nbq/vi5PMQT2ADpAT4xBiKLkcU4l9VsboST5VNW2Lbf6LGNCAa91SHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDpKNn/Ge+IlO0sbw0O7ntquckgBCB2rl0ueDEv3bCw=;
 b=pTUVC8kbX82JwYMK9cKBp+odSjlNVS4/RXWa7Udi3BoDJbeBknLzsiDbA+3SXp93UTfBNxul7H52c7krCj0nMgnCWW1OhGzKBeaVewPdCqXVIr1dGpGdYvl4QHgzHui2LMs7JhLIUs5dLPkFDaXAYZXcjDD6E6bGKriFhv8wYFTGxwswpqSKc5UfQd6RmsER+jUgLiop31ML8exNgNQrJ4HivIv3UG60OYIHB/paVzmWq5RBAGRIRTBdzy/4vt21Pm4d7/O02LYUHZsNVa7b6+SQbF74Uy/tPySnd7GivDo/jWB1Km9NfdH13iW7Ro2N94euhqL/1MbPn0DnJ37/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDpKNn/Ge+IlO0sbw0O7ntquckgBCB2rl0ueDEv3bCw=;
 b=AB+MZpv91RjYpOdUttymUCsguq1LMpByvD8Ut2WNVosjOWUnAx1vjgQ7hIix6uSXyXhnPLHHga6auPhlPhrCZ2e8L079WSFbMnxpHaHRXmnFEXJvPigRFNaqHf4XyK95xpwtCUh0nJ11/IvM7RjSdqP/u+iQcTY0bfCAjm7basg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 08:23:43 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 08:23:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/7] drm/amd: add definition for new memory type
Thread-Topic: [PATCH 1/7] drm/amd: add definition for new memory type
Thread-Index: AQHbuamEijvmC+SlbUy5Y6iTkQjjFLPKA00A
Date: Fri, 9 May 2025 08:23:42 +0000
Message-ID: <PH7PR12MB87963FF46C8DBC80B18B8B8CB08AA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fee0fab3-fc92-4056-9021-570a9fdb11c8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T08:21:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM6PR12MB4122:EE_
x-ms-office365-filtering-correlation-id: 95dfaf82-3403-4caa-83ca-08dd8ed2cf5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?Y3lJakxGY1gwU09sOURnendvMWRIaDRrRk54clpTZmlGRnVpME1KbXdG?=
 =?iso-2022-jp?B?d1kxRGQrUFV2NldTOFIyeGZ0Vk1JbWJtVnNwUUVudDNNNHBuK240Z0Fu?=
 =?iso-2022-jp?B?cndLWGFjYjhRME9ML0twWXZOUG5tU3FCaVExZk5HN0RxUVF6cWhkeE8x?=
 =?iso-2022-jp?B?ekRpS0xVOXFlRmlGTWNkdkJGc0M2UTE2OHN3QlNMMnhYekxlY1VCL280?=
 =?iso-2022-jp?B?S0h6cXhkdUZsTGs3WUpqMTBzNkRLS0gzaU9DYjNRdHF2d1NWcHhxVDl4?=
 =?iso-2022-jp?B?Y0c4YjdJbE4yU015OWZOcFZDRlpkeFBmcVZxSU9QK2YxK2kyQVRVdllw?=
 =?iso-2022-jp?B?MmxZL2NCYy9pUTBIRHcwYlFsejQ3RFpvY3VvR245cHhxSXAxZXMvSVha?=
 =?iso-2022-jp?B?NGd4cDI0RW5Qa2F4T28ybXZvZE16aGVNWkdGMlVLSUFqcDB0WW9BVTJQ?=
 =?iso-2022-jp?B?cEFtSDZJUzd3R1JsaS9OSjhLdm55R054T3RBTnVHellzeGUwRlRveC90?=
 =?iso-2022-jp?B?RmZlOWZ5aGNla2hCMElZcGZLMXpPdWpSMXRNWUYzbXJ6MWVaZlVjQ3dp?=
 =?iso-2022-jp?B?OGNSbnhlMU5UM0xiZHZoS3o5Kzl2UXJZNnhwdzJQcGoybUY4cU9rNnRL?=
 =?iso-2022-jp?B?Vms4VzVqeGF4YWdxZ0pyNHVVYkhHSDh4cmpQeEhrVW11bzdKa0N3blNW?=
 =?iso-2022-jp?B?SDdqelhOcXJiSGllNzBDNFhaS3dZa0dESDJ6c0hWay8ybkN6eW1hT0du?=
 =?iso-2022-jp?B?cXJYOTFVN3lkKzdnd0kyM0NyWit4RWlvbmNGeGpZN0hKck1lNXlkZWh2?=
 =?iso-2022-jp?B?ZXVxU1p4NzkvN3ZGTHNmazY0T3hwUUFzVjI4dlBqbllDTjNKZDZEbTR0?=
 =?iso-2022-jp?B?Y2ZTVjNMTVB2QlNWMDM1dVhDMlk4UUNIZmE3ZmxsY3p3a3g0L0IzdnBX?=
 =?iso-2022-jp?B?cVVBY0FSeXRsSnd4RHU0U1BCVWo5d2xHZmpFdWsrS2ZTS09XODRNYUFj?=
 =?iso-2022-jp?B?RkdweExsTUpaWnRhSXV0bXNsQUwxNEwyZVMvVHkzNFdhZjBuZWhCVUIz?=
 =?iso-2022-jp?B?MGY2S2dTVVFBeUlrOWFqSkFvekd4Skk1ME9qSnRVRGFSL1IrNXpBRW8r?=
 =?iso-2022-jp?B?N0lKSkN4bWZVekh6ZHQ2RXM2cTVhME9seDh4MU1ueGhGcGxUUG81NGRZ?=
 =?iso-2022-jp?B?ajdBaE9QM1lHYkhQS1p6TVlZeUJBR3FLYkUzTFJzWndCNEZQbGJzcWxQ?=
 =?iso-2022-jp?B?SnRGY2JuaGxXV29lK0FzMTBwMWVyZFM0TzFyOWtLZENhK3NMMlFRWXFR?=
 =?iso-2022-jp?B?Mm94YTRtNG0zN0I2Q25WKzVnd2lHUldsbEVmaHJUdmEyZWRkMjlkRmw0?=
 =?iso-2022-jp?B?Y0dFVHF0Y0pHY0FhZ1AvWFBiWkxsNVltUjByQjVjN1JiMXE3ZTh0RDUz?=
 =?iso-2022-jp?B?VUFzUlpBbHV2b1VvRlVuVHdDMXNpL3B5UlpQVi82OGlXcEZnRTRDMVh2?=
 =?iso-2022-jp?B?UGRLTFNnYXh5aS9vVXk3MXJta00xY3owLzhZam14TnVvcGdNTm5TdnI2?=
 =?iso-2022-jp?B?NzltV0RXdlJpVG1jZFBlL1pTV0tIMkxKVGVTSy9iTExJUHEwZVExYndv?=
 =?iso-2022-jp?B?R0RBSFJwdmdIQ0JFNUVtbmc4cnRjcDFpZmxQYTMxTUlCN3E4amZBdGow?=
 =?iso-2022-jp?B?OVViczJZYXFRemV6M0V5RVl6OWJnNXN1M0MxYkZnWHQ1WHZHZCsyKzh6?=
 =?iso-2022-jp?B?TWtnV2UyQVpzMzQzTW5CN2tHeEEzK2J2MHJjZUxWUzBXN09XVElYRk9z?=
 =?iso-2022-jp?B?Q3JVZ3EzWDZ5N0VVaWNsdjl5QnBla0Q4RHhPSFRqSGxWS0E5QnoyQmV1?=
 =?iso-2022-jp?B?VXFmSDhnSzN0Nkc1Z1kwTEVyajQrVXpEZkpTU2NUY3V6NVNHWUJ3em9a?=
 =?iso-2022-jp?B?cnRRdzV0U0JKMi84UmFVa1BYaFZkc0c0Y2FQajE3VmpQS29CaFo2QzF5?=
 =?iso-2022-jp?B?VzF3dFNXZXF6ZVJBYitZODNhUGtubVQrYXVuOSt6dUgrWVZsbm5SZEN5?=
 =?iso-2022-jp?B?SHNDYkpsbWRmNWhyWXRIRXRabDA2Ti9vVHVnU2JYcUNWQlllNWNSZ1VF?=
 =?iso-2022-jp?B?czZZV1RxLzE5Vys3SXdzK00vc1FQSkdMVkZ6bC9oT3lyQ3Y2T2hQZlJP?=
 =?iso-2022-jp?B?N2ZFPQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aGlYd05yamh6UXZtL09QNlp1K0FSWFN0MTNubTN3dWpVc2dhQ0k1STN1?=
 =?iso-2022-jp?B?c00yWjZ1RXVkM09VdFN0NnRZSHVXeUR6eXR0Z3NaaWNUTGgzbGhpZmky?=
 =?iso-2022-jp?B?bUQxNnBvMmpmU295dmJ6RGJRVTE2L3c5RnpaaCtYcGw3WEVsSWVESnBO?=
 =?iso-2022-jp?B?RUIwSTBxTy9JdVNVYkE1WVFqMStvMnh4aDlxeG52aCtYdTZMbVduc2lK?=
 =?iso-2022-jp?B?VEdKRmQxdHNuL0pJZjB5cCs1RGRwY3A1UEJWSi83d1lJdC9ucjZQWmpi?=
 =?iso-2022-jp?B?YWJDQnQ4RHFOVTdxWGlDM1l1Uy94VzdFS3NUV0I4cENCTlJxYno1ODl2?=
 =?iso-2022-jp?B?YmRhQTJMYUlpck5wbmoyazN4d3lhWC9HcDNTeGdiYldDdENhUHo5TEpk?=
 =?iso-2022-jp?B?dlQzM2FLU05PMDlBdmN1RlZwZlBWQ0RJeWNzSW83MUR3QlJSTjVVWDVN?=
 =?iso-2022-jp?B?Q2M1VUl1bENBdEZMV1UrTmRTUWhVZGREREtuL3dNN092czYyUWw1RXVm?=
 =?iso-2022-jp?B?ajNvM1pyRDRMbXZUYkRyb3R5aE0weGZFVkhWU3JzdDZ6ZVliZFVPN05U?=
 =?iso-2022-jp?B?NU9vQytiNEUyKytyc0xoSkliUk04UVhPNlhjWlMwMVhjSXJHU2RFSExV?=
 =?iso-2022-jp?B?TVBZRlJPcnhxcy91NTc3L3hWbzdGdmcxN2JTZ0lFSXEzMHU2aStsL0Zx?=
 =?iso-2022-jp?B?MkUzY2xodDUwRnZ3T0ttKytmNHhwUkpJZUxId0NXTFZqWVdiUWhTd01Q?=
 =?iso-2022-jp?B?UW1kdldEbFF3cGsvcGYyZ2NCdmVMQzhhVFlXcFBDUEVObktrSzg1ZHhj?=
 =?iso-2022-jp?B?ZENrZm0yTkpkZHVZblh5MklRekdZQXNBdkdrTE5oU3h4aFc4SXIvSGg2?=
 =?iso-2022-jp?B?eFVabXVtOTAzVjcrYmpKSW5SZWhFK1ArWDBnNE4wUVNpaU16SmRYd0Rq?=
 =?iso-2022-jp?B?ZlQ3WUUvM3k2UU0yVkVFSFNYb2xuS0tHV0JDNXN0bEx0NEtZZC94SVhl?=
 =?iso-2022-jp?B?K1c3anVzblJmQmZzV1RhNU5TVEFxL1ZDWnJJZ1FIS2ZkV3FXbVBXajR5?=
 =?iso-2022-jp?B?UXNoRFcwN0NwdFdCclZjcERuME9FSDlzQ2FHNUpydTEwV3JQeWRNZUV0?=
 =?iso-2022-jp?B?UE9FazB2VGRvdElidmR4MlBhWEpMTEltd3g1UTF1SFdXWXpFSEZkdktp?=
 =?iso-2022-jp?B?dys2QU9BRDlhNzJhUEpRV0tWR3kvSVIvR054MlFKNk5MYjFNakFUbk42?=
 =?iso-2022-jp?B?NFRpK3hTUDRJWTlnelE3b3pCR0xHeHI2OHZ2UHZSMEY0VEhyRHZZa2E1?=
 =?iso-2022-jp?B?WmxBNUc4NmFKNkxqdHBvU2hWZTJGaEVpaCtDeWt1eDlzRXAxamtjS0hO?=
 =?iso-2022-jp?B?OFlIRXpyczBRcWFUWndqZ1gwUkkwQnEwenp5RG9BZEpVaFFoaVhmN0lH?=
 =?iso-2022-jp?B?U2NjQlhZUFVHNGRGdGswV1R6aFNOc3VzWUNPRS9HdzY1d0gyZjdZY0FP?=
 =?iso-2022-jp?B?MlVXbXk5N3lRcVEwVWtzK0xHZTBtM1p0ZlQ0UlVOTnhwVVRHTXJkOFNP?=
 =?iso-2022-jp?B?MlJlUUNSOWsxSXRQZEVLYWEyMnUvYzBWZWd0SUFxZUpicXRnUjF0LzBY?=
 =?iso-2022-jp?B?S1ljQkpzS2tQaWkwR2ppNFdxMnlMWnVuNG5ETTZFN095bmxrRkhVU204?=
 =?iso-2022-jp?B?SHBJNGRjZy9EN1pZWERtV0lxMG5sKys3aHpXUWxoZ1NRdXBkbHMvWTdY?=
 =?iso-2022-jp?B?ekR6dWdFWTAxZTVVVWErdjU1QlZLZUxmMDFURzM2bHVKTTNDYytvSTdK?=
 =?iso-2022-jp?B?UFRqNFUza0o3akZSdGxrU09tdkQrWXQxSVZrYm5oanFoZjNrSG9iUE5I?=
 =?iso-2022-jp?B?WDVEdVBvQm4xK3grdFZjTklrZ25PNzYrNWVnaXBnOUEvTTJad1lUeS9u?=
 =?iso-2022-jp?B?ZEl6S1BSZFNRbDJHckFCK21WRlVTV2tXUFlOdDZsUUR1TXpIQW5UOWpa?=
 =?iso-2022-jp?B?YzdJNDFLcFk3dnJVQ00xeXAxd1V2RXBMVW0ydnU3TUkveGhzbEdpRjRC?=
 =?iso-2022-jp?B?Zm5GUWxNYWF6TFNPaDVKMXE5WXlCeXdPbnprdGpnRjg1RXRjL0RvbW1E?=
 =?iso-2022-jp?B?cXIxUllWaEJVSEpKVzh4KzdlbUhtVnRhTk5hWDFMK21JdG1IZjBsb01E?=
 =?iso-2022-jp?B?OUZTZGlacDdLRDUveVBINi9VZDVVM1dweGJMVXB2SW1Sd2t6d0dUUzMy?=
 =?iso-2022-jp?B?eHdFbkJHK1ovV0lLYjJkY0NURHNBRU9qST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dfaf82-3403-4caa-83ca-08dd8ed2cf5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 08:23:42.9697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyfP4pZSRelkSpQcvnHz6HVf4BF/IBcYVWyUhbtYYokMe7NY/mBVH3wgGQMkEU1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Deucher, Alexander=1B$B!$=1B(B

Could you help review this patch?
The update of include/uapi/drm/amdgpu_drm.h needs your Reviewed-by, thanks.

Regards,
Tao

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, April 30, 2025 4:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH 1/7] drm/amd: add definition for new memory type
>
> Support new version of HBM.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 3 ++-
>  drivers/gpu/drm/amd/include/atomfirmware.h       | 1 +
>  include/uapi/drm/amdgpu_drm.h                    | 1 +
>  4 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index eb015bdda8a7..c7d32fb216e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -281,6 +281,9 @@ static int convert_atom_mem_type_to_vram_type(struct
> amdgpu_device *adev,
>               case ATOM_DGPU_VRAM_TYPE_GDDR6:
>                       vram_type =3D AMDGPU_VRAM_TYPE_GDDR6;
>                       break;
> +             case ATOM_DGPU_VRAM_TYPE_HBM3E:
> +                     vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
> +                     break;
>               default:
>                       vram_type =3D AMDGPU_VRAM_TYPE_UNKNOWN;
>                       break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index bd6005cc06c0..4b8c492348b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1080,7 +1080,8 @@ static const char * const amdgpu_vram_names[] =3D {
>       "GDDR6",
>       "DDR5",
>       "LPDDR4",
> -     "LPDDR5"
> +     "LPDDR5",
> +     "HBM3E"
>  };
>
>  /**
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
> b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 0160d65f3f5e..5c293017b541 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -183,6 +183,7 @@ enum atom_dgpu_vram_type {
>    ATOM_DGPU_VRAM_TYPE_HBM2E =3D 0x61,
>    ATOM_DGPU_VRAM_TYPE_GDDR6 =3D 0x70,
>    ATOM_DGPU_VRAM_TYPE_HBM3 =3D 0x80,
> +  ATOM_DGPU_VRAM_TYPE_HBM3E =3D 0x81,
>  };
>
>  enum atom_dp_vs_preemph_def{
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> adb811ed4c34..f3223c05f71c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1443,6 +1443,7 @@ struct drm_amdgpu_info_vbios {  #define
> AMDGPU_VRAM_TYPE_DDR5  10  #define AMDGPU_VRAM_TYPE_LPDDR4 11
> #define AMDGPU_VRAM_TYPE_LPDDR5 12
> +#define AMDGPU_VRAM_TYPE_HBM3E 13
>
>  #define AMDGPU_VRAM_TYPE_HBM_WIDTH 4096
>
> --
> 2.34.1

