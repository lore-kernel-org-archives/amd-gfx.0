Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288E7CA1013
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 00:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D7410E915;
	Fri, 19 Sep 2025 00:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1RlKVbf4";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B643310E915
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 00:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve470fjupTlf6rLSQbU8JeCojLEfgDccA0b7nbM2J4N1JRT4Z2OLtW4gL0/jI2ziQoTgDD1zItg9xBZzBo5OGPHU0a4lNnLn//GlegKhsAQ5uAB0o+DmAKqXVNptMFOx6Rftt6zoSSOJd4NwJ7bEzxmh2UNoYDw/Rw9QeR8jamBfYK4pNSO4BieYWcIchP4sDpFP5P59d+PsXWhHdEW6NvbaF5XcJEVswYlksac0/Eg8Cl+kHcQDSlg4PYo+UyYm0es4rr/CYK5hPGbVo6e14v3LXm9JQGIVmL/aCwNfh6L27KUgvjRs1EFX92rhW9asdoRACXwnsiVIflfckqDW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwGYvSk1Ula7NCISqHCdTuxegrXsxvXJWesu6ztJ/pQ=;
 b=vEnN/yWB8HXxc4GqYx4o1mm+pkne+ICf7Y1gJBBXGqVaHkoCnV/1FpNgDJzefmRKxzqTGT1abOgLOa8Q5nFSZWgAjj8IHSbcyIRXwtwLeZJYVJH+nPbT85FIO0Yc8zCcse2XOhJl7GDDwh8HckH4rWN35OvEBZLUKj0YkDGClecaoebOov6MVkPgyE4RCTcUJ7wqrYApdMikKR9eqPGfMgr23t3r06Ya4ViM17PC6tu12VvVSTd7HVCoXoAAd+G0uKuMXWg8kD6/qejBWWOCIh8s2NLQrbgDiIhzO2kZI32n25L0CsGAaom+Cy8ibhhCoN54tS9bzamrO+xFyoU06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwGYvSk1Ula7NCISqHCdTuxegrXsxvXJWesu6ztJ/pQ=;
 b=1RlKVbf4VxZ6abqwhxFE+N3ebhvL5hUGDF7PegrcUnyAZve/sGPCk0hxfI0P6LlqhKl4fCREfnoVvjNHvA6MyBk0xCkqvmqj18oJCnZXN3gbhBLVnJQOcVxkJAIywx0jUExKqoiuGo7j2ga2kV5I8rPkTZUmNjQpdfEA/Qa6+SU=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 00:41:47 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 00:41:46 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 01/21] drm/amd/ras: Add unified ras core folder
Thread-Topic: [PATCH 01/21] drm/amd/ras: Add unified ras core folder
Thread-Index: AQHcKDwz/KhkhqYGYUaiaA8S1IY64rSZXQqAgABO02A=
Date: Fri, 19 Sep 2025 00:41:46 +0000
Message-ID: <CH2PR12MB42150576F8FBC5E7F51EF877FC11A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
 <CADnq5_NAyA5wiqUrN-PVsY2fLS1+1XkkAqyspp86-DSH3jzQyQ@mail.gmail.com>
In-Reply-To: <CADnq5_NAyA5wiqUrN-PVsY2fLS1+1XkkAqyspp86-DSH3jzQyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-19T00:41:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB8826:EE_
x-ms-office365-filtering-correlation-id: 162681cb-10af-46bd-75c2-08ddf715503b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d3AzOGtFaTVUK09tSkluTjZJMkdVVFJaSDFoNU8vc0FmTmxmb2JmWTAxVEhq?=
 =?utf-8?B?M1BKVnNkTkthNnNRanp4a1FxVVRDQ0s5d1lYOGdMdXFjSndzVDlDUzdyYU1K?=
 =?utf-8?B?YnZtdEJNRnVWbTd5R0RkYjdTS0pNWlVCS0prWDdOd3Bmc0RLdGRVRnh3UFBK?=
 =?utf-8?B?dHhURGtkNVJZR3hselFOODM2REZhWENISytKK0FJczBmeHF0U0txWU1KaVZT?=
 =?utf-8?B?cGpLc2pYZVdWQ2dydnhoRXVTcXl6YzBSbmRzVERJWkZ1L2NJQmJ4M0VRc25D?=
 =?utf-8?B?b21nWXdPMHlQc01tT1JTOTdtamtZcHNQUGl3cGFhcWxqdHdvY01WRGhwN0Fn?=
 =?utf-8?B?Snp4YU5SMTJwdllLajV5Z1FRS0lFS3Q4UHE5OU9BUmx5aVY1eWxyVERHejNB?=
 =?utf-8?B?ZTA4RjlxL1RrZmk5T0Vjdk50UldQMithL21ycWl6WnprS21qQjIzR0ZsckV3?=
 =?utf-8?B?QVRvT0hUY0RET3g3MmxPa0l0a3dTb1pyNDEwam5Zc05hZG90UThjNStLd2N5?=
 =?utf-8?B?b1ZHV3RBVUJiTDM4Qy80VURlY3orWk9NSWpFWDlkNGNwNGFNL0pKL242cmpa?=
 =?utf-8?B?QzFFVlIwUzdiY21vQ1RMOGd1WnJMUGYraFRBNmhVYXQ1dEJSN0xHUTg2b0ll?=
 =?utf-8?B?OVhIWHNrK1lBZnkwK01RN2JpemZmSlJhZnZ6SGxNQnFQOVQ0bVI5VTFIbUZH?=
 =?utf-8?B?VWpYZVQySW5QcXBnVzlTdjI4YzlxbkFxblRCMHh0dENKT2dTK2M5U1p1dGZo?=
 =?utf-8?B?UU5OUkdXWU9oTGhoTE1wZEhoTHNCZWZzbTZCSmlJQnFRYXVuWGNtNndDVkhO?=
 =?utf-8?B?MnE1N1E5T2dNR2dnYmFNbGZnWlBHTXBVdTJxcHNIRVh0QUE1VGNHb004SHY1?=
 =?utf-8?B?bThZL0c0VXF1ZFBwVDBRN1VlNGlOZUtJQ1JDNTFoTWw2bUEvTmJiME9wd29v?=
 =?utf-8?B?cVBlWTNrR3ByUkpZQ1RDWm11SnVOdnptSjZXWndWaWZKb3hRWGFkbW1jeDBv?=
 =?utf-8?B?NHNJcHR0ZUdZTjltYlBCZTlHYWh0WHc1Y3pOcTlCU0x6alZCd2s3Njh0SWtL?=
 =?utf-8?B?UytJQTF3WnQrZFIyQUlMREF3d0tjcVNySnVSL2xXckZQVzc4QlBlbU5hc3dR?=
 =?utf-8?B?TmhNL2kxMzJtbU1oZktlQ3ZqUG1ScDl4YjR4UmZSbGNaUzhlYk9Yb0xGWTMw?=
 =?utf-8?B?YnYxeWhvRmpZZDk2bUFyZEZBWE1tVVNwRWpqZnlQeXZ5akJzWkMzdU1yWE5D?=
 =?utf-8?B?ZUM5TC9kUGRmOW51NmczZW5wOVVzeEkyRWpTc0lXcy9xbkhROFRHRThJdTg4?=
 =?utf-8?B?WXhnR2VweDZiZlVzTDREZ2JuSEVMUUw2a2dGd0NNUytsREJjN2ZySWUxaGp0?=
 =?utf-8?B?Y3M3dUtkU2hPQW1kVnhZNDNNS1lrYUoyT2liK3Y2bTdCdlhEZ3lNblVQeW5W?=
 =?utf-8?B?anU0K2RGTmorMzJtYzVNbEFwU0ZTQlpQa3UrK0Z4UmQyM0Q5SUcyelZDV2d2?=
 =?utf-8?B?WEVGS2tBR0F3enp1eEZXWUY1eE9HeXFhVUtQeHkyNGdiU2dXOHk5blBQeG12?=
 =?utf-8?B?Tk1NZW5yeExWWkYzYUkxbnNEN0NSUmxmSW0rU1I4aCs4ZndkdmEyTmhnK0ZE?=
 =?utf-8?B?MWlZT2lkY0pXV05laCs2ZFFocTBSbzEwM0FjallTWmVjVytBdVQvckx2eXFT?=
 =?utf-8?B?VjE5dUd6MHNib2Rzd3JwMkd1ZERWT0ZCQk15UWtoVnNzWFhOVVJDSTRBNENl?=
 =?utf-8?B?Qkp4RTdRUkJrQjBwbFJyZ2IxSm4xNC92blYyYXVLQ0JoUDlqK2R3SndZbjFh?=
 =?utf-8?B?UzAxN0ZNM0lVd0FobElWM1pMZGJXK3MvMUFYRkl1SHZrZU1EeWFUOERUMUZO?=
 =?utf-8?B?ZTZDcEFCSGxudWdHeFoxNXVtdXF4aDc2NWxaR1Q0c2JhWE1xNXNrUnI5aWZZ?=
 =?utf-8?B?LzBmQVBqSnhnMDhmcXVkcmdwNStzU0QrVC85WHdQazE2K1ZWUGN6cVlaeS9S?=
 =?utf-8?B?ekxXODJJRXR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDhOQWdueXhRRHJwT1pzSjg3VkJkdHN4K2UydW1GakRPcElVaHcrQnZlUDEx?=
 =?utf-8?B?SVFyQVF0bXMybkFYVXI4cENManFReWpOWkJ2b2xyb3kzL2M3NVdpd09NcmJ2?=
 =?utf-8?B?M1NSV1BTZG1BYlRaQzNOK1F6UDJCa2tFRDRwbzFENWNwS0IrcGk4Tks0NlNv?=
 =?utf-8?B?NVdXR29zUkc5Z2V0Y3N6dTY0c3Q4ZEorSzF2N1pRSEpWaVo1aC9lRU9xNnpR?=
 =?utf-8?B?OUxZdGtvREQyTGI1YTd3Z3NKNkQ4d0hvTU1mcTNkN0ZobkR1RnNQVi9wL2VX?=
 =?utf-8?B?VURxeHN5TWUvbWZMZzdJQWF5WG9obDZaUGc4QmcwZHNPR2dJWmxOczIrMVQ2?=
 =?utf-8?B?Ri8yUitpSHV4c2dPQ3h0Zk5lNmE5bXo5Z2wvOGhwckxrdnM4UTVWVGVsbGxX?=
 =?utf-8?B?dzE5b2xMbVFWMHgrVldyQUFEbzJEdldqSm9CYjcxTThsS1dkcnY1OEJjeWMy?=
 =?utf-8?B?TDMyNHFJeVN4OEJqMEZQQlJQTVZwaHcvRll1RGU1ZTVQb0c2dzNLbmtBdlFx?=
 =?utf-8?B?Nm1jcjFHamN4anAvaDBFU3ZRbWhOaVZOZ0JocG52QXJHd3Zzc2hNZUYvNnRY?=
 =?utf-8?B?bzFtM0loNFlVTEdqU0RMQlRWVDVzcEVISTBMWmM1VTA5M0ZUclhMYUFmOWdS?=
 =?utf-8?B?bzdzTXArQU9EemlLN2NrdWZXRnNtOS9JdkhCbm1KZ3hOZkRTcDkwZHlxeTU5?=
 =?utf-8?B?QjRVMkw3eXNMeVdxYU4weGRtRzhlSEJxMDZ0OU9iRXBtVndzbjJWQVlPUnEw?=
 =?utf-8?B?WUVQY3dFeURZdnZYVzUwNE0ycWgrblY4Qm5lRFNHTGRSbFRSaTR0ZGc0djlR?=
 =?utf-8?B?NkpjT2F4cUczcFNoVUNXS0padGJ4VTJjdEd1L243VUNLQ1l2VC9tMmoyTXNQ?=
 =?utf-8?B?L09CWGNXdWZMdWk5TVRQYUZBRUZyd3p3cElMdkd5V0ZHUE1Uc1JpZ1lWeXJ6?=
 =?utf-8?B?R3pwTDY1Y2ZrUmRDakxmSHpiNnV6Q0dZMzZDcUxYNTZBREVvNkpmUjQ5M2sr?=
 =?utf-8?B?bmRHd1pucGN5cW5Hd2lUajFoWE5ZQ05lZFZpY3hrcWV4YzZLSWVsRzQ1aUp4?=
 =?utf-8?B?L0VDWk8rYVVWQUszQ2R4ejliU3ArMTZ4cEs1elNpRkFVQmkvem1XdjNXZDQ3?=
 =?utf-8?B?SUxmZUF6bFZZRlpEUk9QbXFGWndteDR5dkozS3VoT0lNRFZFR244Ri9wNzNF?=
 =?utf-8?B?YUl3dW02bU1kQ3B6aWg2SVNwWXhvcklLWS8wQWp2N2c0UDI5bnUzRS9VdzdL?=
 =?utf-8?B?bk4rbEVTNVYwNTZnZGpnRlFuSVM0bG1nVTJJRXVhaUJ5VkR3ZzdLK1l5ZjYx?=
 =?utf-8?B?YTVqNWlQOUlUczYzMTJQUER3K0VFZm1IQzF5VGtTNDh0WHFmQ3REZkpraU56?=
 =?utf-8?B?RmlFQkF4MDA4Vkd3V0NubVcySGZXRXZma0ZxZkNKZDR1R2p2ODRDSXRKTWdX?=
 =?utf-8?B?R3RteVRPWGdlSTU0dnkwOEtEeVhkTy9Rc3B4TEFCQjVKc2RWSkRCTnZJeDFZ?=
 =?utf-8?B?c1RubWo3aW11R0VLb01EMzBIWmtpMys5UW9uMWlrRjJ2cHBieEF2ekRsYzJm?=
 =?utf-8?B?TVgzV2hZNXU5bTRkb0t3K1JGL1NBM3ovcWFHaEpqYkh3UlhRMmM3Q0ZWUDFJ?=
 =?utf-8?B?UUZxVVRKVzZMV0tsUVJUeEUyZmozeUJpSWdnZS9wOGlyWEpKRXZDcFExM2J4?=
 =?utf-8?B?ajREZkpLZTc2bTNIbFNaWW9GUHV3TXUzNDh4VlFQQllBT014ZHFUNHBsazV1?=
 =?utf-8?B?SVhoalYxc045K2FISk1pNW1vRGhwakFvM0NnS2Nxb3hpb2dYRURzRkh5WElV?=
 =?utf-8?B?UjNkSFZiSVpPWkxvUW8xUktBTXVRcGpNcUdtdUYzNkEzYi9VaHBtempxZ1JP?=
 =?utf-8?B?UmErRXFrOXNhcUtscXcvRG9ObWxLRG9CR0VSOVBTNW53NlRHVFo1cy85dk85?=
 =?utf-8?B?TlRteDEwazFocDlpQW1hN1ZVbDZhSzZBaWd1cFRuZTdOR0R4MktLQjdHbmdO?=
 =?utf-8?B?WGxvSC9pYUlyR3pHOSt1bHpNM2lHaW1XbUZCT1ExUlh3VS84cFp2Ty9zNWNJ?=
 =?utf-8?B?ejJxdlNJVGNTd3dzTG4xSEhWZmZVNVUzQk1hby9xQlR3SW00YnRpRk0yMlRi?=
 =?utf-8?Q?M+2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162681cb-10af-46bd-75c2-08ddf715503b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 00:41:46.8724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xo8Cro6RR8Nog8GwGfo1lANiVztVbaeWduc0OszDXf1aqXiGY4bDMOucLpUd9CHpd73LSZFlRF3yJxD7spZ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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
Cg0KT2ssIHdpbGwgc3F1YXNoIHRoaXMgcGF0Y2guDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDE5LCAyMDI1IDQ6MDAgQU0NClRvOiBDaGFpLCBUaG9tYXMgPFlpUGVu
Zy5DaGFpQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5n
LCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBZYW5nLCBTdGFubGV5
IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMjFdIGRybS9h
bWQvcmFzOiBBZGQgdW5pZmllZCByYXMgY29yZSBmb2xkZXINCg0KT24gV2VkLCBTZXAgMTcsIDIw
MjUgYXQgOTozOeKAr1BNIFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPiB3cm90ZToN
Cj4NCj4gQWRkIHVuaWZpZWQgcmFzIGNvcmUgZm9sZGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZ
aVBlbmcgQ2hhaSA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRhbyBaaG91
IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9y
YXNjb3JlL01ha2VmaWxlIHwgMA0KPiAgMSBmaWxlIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Jhcy9yYXNjb3JlL01ha2VmaWxlDQoNClNhbWUgY29tbWVudCBoZXJlLiAgSWYgdGhpcyBldmVu
dHVhbGx5IGdldHMgcG9wdWxhdGVkLCBqdXN0IHNxdWFzaCB0aGUgcGF0Y2hlcyB0b2dldGhlci4N
Cg0KQWxleA0KDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNj
b3JlL01ha2VmaWxlDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9NYWtlZmls
ZQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU2OWRlMjli
YjJkMQ0KPiAtLQ0KPiAyLjM0LjENCj4NCg==
