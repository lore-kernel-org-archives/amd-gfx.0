Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB5CD0BB54
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 02:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC2810E89D;
	Thu, 24 Oct 2024 02:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcKW9pd+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C20210E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 02:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN8rsNkOiaKbNntLMMfa4c9P7uRJ2e2ih3gvzNgOlzF/Wp5KMOySKFERSYCKZS737y/SyalwzDk/j7rTX6W2Yu8fOC5fyFrJHR9Mocvoqc9nE3EyMJBX8T+5CNks6w426gttIA9wVEoXw1RV2pjkWGpg7H9ef6ILWamJdntJUhUgHc4goYcOyM3opW3ctuAIWrvm7tfpviriwaqOdQHs0jbcstX0FZWrMrKLh4UYISooWWbckY3L9aFlXSXi+Uqual0syoLx3Jc2EGRtbNj8M9AfDHBzw2zX96xHE2XSCcP6ahqHihTm3jf3MSVKbxjpOz38/H5OcFD3FMthKMyMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6HyPpSHCpAJtT2CmvKB2E4PnBY1x4g+tZtKpcoJ63o=;
 b=LkCdtWGT/gE6ImAmE3rGJo1uEQgv8ajmv+dLsv7WvJ8dQWfvCapDQ0TRqck4K1TzCQPoV2wdbNX5yk9xtl84vFCUVhIzBOzcph2AXmmcWETFgx/xYdVh9zD2KxS9lf9buWByz0HP8q4rPv+fNbh8wo/oE59EkaQE4x0Ts8PPA1CeeJ+oq8kIe1OGIsSaUCbEc9DjRDSVkiqDNC9vM1aywyVMeLHRRgBmzvyStmUw9enYZg8oo77PEW0JtihxCAkgFA+LSMdnuk67j7e/SKDSo0wC8pdqCAt2ABaroWOaBJrJGmvVXyhf5Sqe1nRMGCF8X4IRauAwnItR52XRFy5eRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6HyPpSHCpAJtT2CmvKB2E4PnBY1x4g+tZtKpcoJ63o=;
 b=NcKW9pd+YUhE7HRs711Jnb3XrNf0PFr3X0pve8VDR/1qtTw/ZwjVBE+TYW/4OyAMUJxVDB9AcBvRoRDERCFhlb2sIrn3hW9WNXg4F6xTNqNqUDUqDGSiuO73zWWQAtL5J8yGEtqRFgpXAIUq7fI0oqukoqOhbtz4BC95VN9NX4U=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 02:54:00 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 02:54:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Index: AQHbHg2S9Q7S+WlsDEqU6j9plY5fkLKUOAqAgAEBFJA=
Date: Thu, 24 Oct 2024 02:54:00 +0000
Message-ID: <DS7PR12MB6005B9EE7961C317C9639193FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
 <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
In-Reply-To: <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=026d6d9b-6cbe-4274-82d6-63386a4dd011;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-24T02:16:17Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB7578:EE_
x-ms-office365-filtering-correlation-id: e096c710-aa5a-4012-205b-08dcf3d71cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dy9CbERhUURFcm9oVGFqOEMwT3RjaTlURk80bHA0RU1mT3pCa09rKzM2OWNP?=
 =?utf-8?B?aFp0NVFXYk82NFVIQVduazl6ZXNzSXNvOVNOU2xzZHcvNEZFRllCTExVWVNo?=
 =?utf-8?B?M2xOblhWYi95YTBNQ1ZNd043bHNreEhCQ3M1QU05WE1iY3NVY09aNW5qVzEz?=
 =?utf-8?B?OTQxTWV5V3NlZng2RU50NGZGOXZzWFJnQTl3QWhITGRSdGNRSzNrajY3UWN1?=
 =?utf-8?B?K1ZHZUFGQ3RrcUMwNkR6STU4cHhiUndwRFVWeU5Eekd6NjNrZzdkMVRySy91?=
 =?utf-8?B?UDZYeTJ1d2JpYWxQcm9Md1h4Ym5RMVBUbkJiV290N3pZUEdEU1FFMmF3OU9Y?=
 =?utf-8?B?U2ppMU9wclBjZkFVV05aZFM2bnlKQ2ttNHU0REFJUHZRN2w5Wk1rK285amJP?=
 =?utf-8?B?QUxMeTlaNU5mUXh2TlRIZHJRMXRKcHV1VEhQbVB2dGk1R1RzQjdEQUV3VkZp?=
 =?utf-8?B?Ni9nTXAzYlE5YkJYSTJEbk9rVmVhQjBTUHIrVVpwOUhtTVB6YzlJdmV4Sktx?=
 =?utf-8?B?dlRKTlhIOEtXTFUrNkhDaDRQbjhnVk80K3VKY1B6bGZOb25xbCtpcXd2NUx4?=
 =?utf-8?B?VGcwSXMvbjNCZHZOSzA1TTBtc1hTdEpMS2RNMkNYU1VMakdHWHl6TzZ6MnlZ?=
 =?utf-8?B?anhtbmpPalJ0c1RXUzF2TkhzcXVJRnRlaE14VTBHbnNtUUN4WGVzbzNvNjhY?=
 =?utf-8?B?dGUyRG5Xbng0SXIyNkt5aG5uMHgzRWQxc2dQNThQeGRpaUJVNFVsY3N0NmZE?=
 =?utf-8?B?YVk3dDZBbE5uWEF0WlpNUFk4QkV6WVlnelMzWXFDUFFDMDM3MVlYVWU5TThC?=
 =?utf-8?B?QXlUdFlrQ1MxZHhFdWpRVXBZdjlEclpLMnhRcDVCWFNDNjNzUmV2eXhzMlB6?=
 =?utf-8?B?UVlySWhIRXZWYllBTFYyS1ZuZGFOTzVuZ3dlUDJBK0wxZkg2OE4vZUxWUkgw?=
 =?utf-8?B?UWZDbUxEb0k0aHBUK2paS2NRY2l0cmpsSm4zYVJuMUd0Q2UvVkF2R2hkRFdR?=
 =?utf-8?B?ME1tZVdxSDVLWm5TL0JwaW1FR2Z0bUxkcG9XUGJ3c2ZUOWRYeVBJRG1BaW5G?=
 =?utf-8?B?WGNsMVRWQU5uSGN4L2QxQWo1WWVubkswOG9vWUhINm1VVloyYSt3YzBBVWxK?=
 =?utf-8?B?TkMrcnVtVnNEdEc4bE5NTUFaMTBkcGxYR2FNdGlnc0ZNN3M0TjJ1MkM2MmxC?=
 =?utf-8?B?aDBLUFpSMWhsYThZenhxVUZMcUxIWEdLbmpvNkxiVCs2RXRRbjV3b2ZvaGxI?=
 =?utf-8?B?cWcxaEpncFVIYy9OUjNjL0ViOVh0WmZ3TEUzUzFsSHFiRHkyK1RBS0NqZ21t?=
 =?utf-8?B?dzI3eS9RVlVYdUoyQlYzSWg0U01SS1ZUTVBzZGVYQ0RqMmRsT0UxVHpiaHYx?=
 =?utf-8?B?QXV3LzJMdlY4djdUbS9KMXNSeEtEU0hxYTdjSFFnaWxIeURyM0FqOVhxS05F?=
 =?utf-8?B?Rld3R0JGWjJTcDRKbXNybktmdVBqczUwTDlxdHY4Mmh0VUxxMHczRmJ3eTR2?=
 =?utf-8?B?RUxyTy9ZZDdraGI3ZHRiSTBmNlEybXd4TUFSVjIzalhvaEFFS0NNTytBZnNq?=
 =?utf-8?B?b2xHVEwwK1EzVkRXY0pGYkdCRHVPVld1eFdUTTQ2VVExdjk2YjhyN250UlV0?=
 =?utf-8?B?VEpSbTJ4V05QODJRcWZ3UUxZNmNhYmZONHpYQ09jdEJKSE5XeDNwQVpzZXRO?=
 =?utf-8?B?MENHdk9udi8vRGFuUjZ5RFFzRVo5ZDA2OGVpanl3Q21xVDl1SHMvdTFOemt2?=
 =?utf-8?B?by96cGNUSzBPam00ZDJPQnpDUDlpR2V6WG1XOFluVFFsZmhwRlZEQkRqR2gw?=
 =?utf-8?Q?LagGzk+fzWI5swl4AaldaKCCI1gwzDTLNYGG4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUc0ZllSVG9OZGZqOWVvVzB1Rmg5RkcwWUQ0QSs2Tlc4UkE5eWxBT0VnZWs1?=
 =?utf-8?B?c1h0WFdvRnhiREdQSXhCVU9EQlRSM25XNm5MMUVNYTcyZkVBOFhXYjdQT0ZY?=
 =?utf-8?B?M3BFb1NBZlFPS3l1emMzTHQ2UGdvU3JtSjVlTi9kTlJtd1pXcDIxZ1JFZTNi?=
 =?utf-8?B?VVZlbkFiRDhYK2ZIK2J3Q2M3aGRXV1pQWWRtUXhpNW5raU11cHc3aUVKYW5Y?=
 =?utf-8?B?YnpzSysrZnZoYkRtQ0c4c0VXK1o5eFJHdHNLQ3BEL0NVM1Z5WUVBOU84anZ4?=
 =?utf-8?B?TnpnYklvS3N5MDA5VENKWkl2dThHQjZ2YjJMb1FuSVMzOHhCWktXSzgzZlRF?=
 =?utf-8?B?Ym5qZzFxOVcrblRESWFBdmZwWTNlNlNZTTlnVXdnZTY4cUcrZUU5VlRRWE1E?=
 =?utf-8?B?cHR0cXdnUktCV2NLNkplKzJQTTBiSll5Y01uWGxpbVdkUTVKeDZVcUxLd1Uv?=
 =?utf-8?B?RUFHSVR6eWEwV1RzSGlvb1RPanh4Z2xqbmROWHdqV2s2RVFteW5OOGtOVE1S?=
 =?utf-8?B?aXVOcXVEWFlNa1BFK0x0Q0hFd1M0R285T0N2RlNnRWE1ZGl4akxkVytGa2hG?=
 =?utf-8?B?VlROaVRKSHNjMFBmeERycDYvYkZxajJZTUMrZFFINTB2OTNBakRneFdVaVho?=
 =?utf-8?B?TERRUDRxVlhFbE14SlZUOFRkTFVxZGIxYW9EQkFpZDN5VUVOU2ErNHpyNVZm?=
 =?utf-8?B?OWt3VGQzKzF1OHNyTC9Ea0JjZW53R1FUejdtQWZHNnpQdmNhVUxta1o2Vi9O?=
 =?utf-8?B?UEo0TlJHSWhRdVMvdlg3SUp3T3RpT3ZJd3Z1MUlrWG5HdHlHSjFkTFJUUVJK?=
 =?utf-8?B?S2tHWEU5cmVkczlzai9KeFRkVXJteURZdVZ1ZFN4M2x2cTJXeWZ2MFNlZU9O?=
 =?utf-8?B?UUNVajNWdjZyKzdVdjZaSWFENHF3Vk9OdFBTN3UvR0pTczA3d1BuVWY0cHl6?=
 =?utf-8?B?cU1jMGVrbWxFSy9FY2Noa25MZkNFcE53U2xQckpEdDh4ZCtQZHZLbnYyWVgv?=
 =?utf-8?B?QWZvZHQrTWx3dTZGd3ozTWo4TGFmUFhMTjFMcmR6N3F5ZDVKZVN4L0ZkRXo5?=
 =?utf-8?B?bHhmRHNaQ1pTajVkWk9pamsrTGNJTm9BZGpHczhnNk44Z0xMNmNQTHdyUjV6?=
 =?utf-8?B?bHFQR3Z4Y2FjcVZtQ2tMdUx3TWlma3VaZ0dFTVIzSlBBRmFHZEQzL2EyeGlv?=
 =?utf-8?B?N2QyZWtOdEU0YzdLc00zdy8wZHNldXdMNEhWeTZVcjZRK3dRamNEeEQ0VnBS?=
 =?utf-8?B?TForSERHc2pGRlhKUG5LcGZlUGgvSVVOempvd01GWjRFZ04vNytPSW5WcFhz?=
 =?utf-8?B?d0l0RnUxcEFRWWUySTdLaklFWklmalpTdDBPUkVZdDlzU1N2MTJDLzU0UjFS?=
 =?utf-8?B?b05rcXltSll0V0h0d1R2ZVJJL09LWXA3OUZxZHhtMjNjVFhyM2lYNkhHblJl?=
 =?utf-8?B?RHh6aFBjZk1zTXRiVkdTdXN3c1NsY1RXcEJ5aFc2KytvUHBvTkxaV1U3aFNn?=
 =?utf-8?B?SERnWWxrVHV3V1NGbStQNjlOTDB4VGlleU1Eck9OdXlDL0h1WnBEL2FQTHRq?=
 =?utf-8?B?NHR5SnNWbTdHOGVEMW5UR2tBWGw5bDBPTkZWWUMrTVB0V2U4RmJXUjBQbUFM?=
 =?utf-8?B?MVZaMnB2WWE0bmZxdzBWcUpnb0RBeUVkT2hOeW5QUWYrVmFuSW0xRUdIMXZl?=
 =?utf-8?B?ZExLcGxzaFhWekNpYm9QMERvM3l0Q2JNM2dDU05mMmFyUmRBcnZlaTJubWpP?=
 =?utf-8?B?RWpRV1hzV1QwOUF6eUhzb3ZsaW11QlNSUlF5bHpLL052WExnOXhldkJnWGx3?=
 =?utf-8?B?NHVNYlRDVzJDN09DSzN2MUJQcUxsU2JKdFhQeW9NcnlYWkF2eElra29OL1Iz?=
 =?utf-8?B?WnZWSUFkMHQ3NVdVbnBDWkdwVTZ4NXQrQnk1eTJNOEJlbjQxS0UwVTdRV29C?=
 =?utf-8?B?WE9zS080UTQ1aVJkb0Q4R3QzZXBUUDlJWHhoZ2RmbThuVnlIZkFDcVhqa2lP?=
 =?utf-8?B?UEVPMzhhTE9GRjY3ZENEcEF0bHJPOFA1dHZVVzhvcnRYd1pIMDZMM3UrNGhK?=
 =?utf-8?B?aHhkWTRnWU5JQ01SaitIV092RkUrSHBhK3hBUTgrL2s2YmRnV2p1NTgwUkdN?=
 =?utf-8?Q?uTHY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e096c710-aa5a-4012-205b-08dcf3d71cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 02:54:00.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dqd/iPWyXL917NAmU/6KLbhiBTUVBZriFlXyxJy1rmrjyzevVfa9I9+qY72OVWl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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

W1B1YmxpY10NCg0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjMsIDIwMjQgNjo1NSBQTQ0KPiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIGRybS9hbWRncHU6IGNsZWFuIHVwIHRoZSBzdXNw
ZW5kX2NvbXBsZXRlDQo+DQo+DQo+DQo+IE9uIDEwLzE0LzIwMjQgMToxOSBQTSwgUHJpa2UgTGlh
bmcgd3JvdGU6DQo+ID4gVG8gY2hlY2sgdGhlIHN0YXR1cyBvZiBTMyBzdXNwZW5kIGNvbXBsZXRp
b24sIHVzZSB0aGUgUE0gY29yZQ0KPiA+IHBtX3N1c3BlbmRfZ2xvYmFsX2ZsYWdzIGJpdCgxKSB0
byBkZXRlY3QgUzMgYWJvcnQgZXZlbnRzLiBUaGVyZWZvcmUsDQo+ID4gY2xlYW4gdXAgdGhlIEFN
REdQVSBkcml2ZXIncyBwcml2YXRlIGZsYWcgc3VzcGVuZF9jb21wbGV0ZS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgfCAyIC0tDQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDIgLS0NCj4gPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgIHwgNCArKy0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgICB8IDcgKystLS0tLQ0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jICAgICAgfCAyICstDQo+ID4gIDUgZmlsZXMg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBpbmRleCA0OGM5YjliMDY5MDUuLjli
MzU3NjNhZTBhNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+
ID4gQEAgLTExMTEsOCArMTExMSw2IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4gPiAgICAg
Ym9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9zMzsNCj4gPiAgICAgYm9vbCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbl9zNDsNCj4gPiAgICAgYm9vbCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbl9zMGl4Ow0KPiA+IC0gICAvKiBpbmRpY2F0ZSBhbWRncHUgc3VzcGVu
c2lvbiBzdGF0dXMgKi8NCj4gPiAtICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dXNwZW5kX2NvbXBsZXRlOw0KPiA+DQo+ID4gICAgIGVudW0gcHBfbXAxX3N0YXRlICAgICAgICAg
ICAgICAgbXAxX3N0YXRlOw0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X2Rvb3JiZWxsX2luZGV4IGRv
b3JiZWxsX2luZGV4OyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYw0KPiA+IGluZGV4IDY4MGU0NGZkZWU2ZS4uNzg5NzIxNTFiOTcwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+IEBAIC0yNTAxLDcgKzI1
MDEsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiAgICAgc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsNCj4gPiAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihk
cm1fZGV2KTsNCj4gPg0KPiA+IC0gICBhZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gZmFsc2U7DQo+
ID4gICAgIGlmIChhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZShhZGV2KSkNCj4gPiAgICAgICAg
ICAgICBhZGV2LT5pbl9zMGl4ID0gdHJ1ZTsNCj4gPiAgICAgZWxzZSBpZiAoYW1kZ3B1X2FjcGlf
aXNfczNfYWN0aXZlKGFkZXYpKSBAQCAtMjUxNiw3ICsyNTE1LDYgQEANCj4gPiBzdGF0aWMgaW50
IGFtZGdwdV9wbW9wc19zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgICAg
c3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAg
ICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkcm1fZGV2KTsNCj4g
Pg0KPiA+IC0gICBhZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gdHJ1ZTsNCj4gPiAgICAgaWYgKGFt
ZGdwdV9hY3BpX3Nob3VsZF9ncHVfcmVzZXQoYWRldikpDQo+ID4gICAgICAgICAgICAgcmV0dXJu
IGFtZGdwdV9hc2ljX3Jlc2V0KGFkZXYpOw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMNCj4gPiBpbmRleCBiZTMyMGQ3NTM1MDcuLmJhOGU2Njc0NDM3NiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+IEBAIC0z
Mjc2LDggKzMyNzYsOCBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2NwX2dmeF9zdGFydChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4gPiAgICAgICogY29uZmlybWVkIHRoYXQgdGhlIEFQ
VSBnZngxMC9nZngxMSBuZWVkbid0IHN1Y2ggdXBkYXRlLg0KPiA+ICAgICAgKi8NCj4gPiAgICAg
aWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSAmJg0KPiA+IC0gICAgICAgICAgICAgICAgICAg
YWRldi0+aW5fczMgJiYgIWFkZXYtPnN1c3BlbmRfY29tcGxldGUpIHsNCj4gPiAtICAgICAgICAg
ICBEUk1fSU5GTygiIFdpbGwgc2tpcCB0aGUgQ1NCIHBhY2tldCByZXN1Ym1pdFxuIik7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICBhZGV2LT5pbl9zMyAmJiAhcG1fcmVzdW1lX3ZpYV9maXJtd2Fy
ZSgpKSB7DQo+ID4gKyAgICAgICAgICAgRFJNX0lORk8oIldpbGwgc2tpcCB0aGUgQ1NCIHBhY2tl
dCByZXN1Ym1pdFxuIik7DQo+ID4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICAgIH0NCj4g
PiAgICAgciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIGdmeF92OV8wX2dldF9jc2Jfc2l6ZShh
ZGV2KSArIDQgKyAzKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+
IGluZGV4IDEyZmY2Y2Y1NjhkYy4uZDlkMTExMzFhNzQ0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gQEAgLTU4NCwxMyArNTg0LDEwIEBAIHN0YXRpYyBib29s
IHNvYzE1X25lZWRfcmVzZXRfb25fcmVzdW1lKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2
KQ0KPiA+ICAgICAgKiAgICBwZXJmb3JtaW5nIHBtIGNvcmUgdGVzdC4NCj4gPiAgICAgICovDQo+
ID4gICAgIGlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUgJiYgYWRldi0+aW5fczMgJiYNCj4g
PiAtICAgICAgICAgICAgICAgICAgICFwbV9yZXN1bWVfdmlhX2Zpcm13YXJlKCkpIHsNCj4gPiAt
ICAgICAgICAgICBhZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gZmFsc2U7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAhcG1fcmVzdW1lX3ZpYV9maXJtd2FyZSgpKQ0KPiA+ICAgICAgICAgICAgIHJl
dHVybiB0cnVlOw0KPiA+IC0gICB9IGVsc2Ugew0KPiA+IC0gICAgICAgICAgIGFkZXYtPnN1c3Bl
bmRfY29tcGxldGUgPSB0cnVlOw0KPiA+ICsgICBlbHNlDQo+ID4gICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPiA+IC0gICB9DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50IHNvYzE1X2Fz
aWNfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIGRpZmYgLS1naXQNCj4gPiBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiBpbmRleCBjNGI5NTBlNzUxMzMuLjdhNDdhMjFlZjAwZiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0KPiA+IEBAIC05MDQsNyAr
OTA0LDcgQEAgc3RhdGljIGJvb2wgc29jMjFfbmVlZF9yZXNldF9vbl9yZXN1bWUoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgICAqIDIpIFMzIHN1c3BlbmQgZ290IGFib3J0
ZWQgYW5kIFRPUyBpcyBhY3RpdmUuDQo+ID4gICAgICAqLw0KPiA+ICAgICBpZiAoIShhZGV2LT5m
bGFncyAmIEFNRF9JU19BUFUpICYmIGFkZXYtPmluX3MzICYmDQo+ID4gLSAgICAgICAhYWRldi0+
c3VzcGVuZF9jb21wbGV0ZSkgew0KPiA+ICsgICAgICAgIXBtX3Jlc3VtZV92aWFfZmlybXdhcmUo
KSkgew0KPg0KPiBMb29rcyBsaWtlIHRoaXMgd2lsbCBjb3ZlciBvbmx5IEFDUEkgYmFzZWQgc3lz
dGVtcy4gTm90IHN1cmUgaWYgdGhhdCBhc3N1bXB0aW9uIGlzDQo+IHZhbGlkIGZvciBkR1BVIGNh
c2VzLg0KPg0KPiBUaGFua3MsDQo+IExpam8NCg0KWWVzLCB0aGUgcG1fc2V0X3Jlc3VtZV92aWFf
ZmlybXdhcmUoKSBmdW5jdGlvbiBpcyBvbmx5IGNhbGxlZCBkdXJpbmcgdGhlIEFDUElfU1RBVEVf
UzMgc3VzcGVuZCBwcm9jZXNzLiBIb3dldmVyLCBBQ1BJLWVuYWJsZWQgc3lzdGVtcyBhcmUgcG9w
dWxhciBpbiB0aGUgZGVza3RvcCB3b3JsZC4gSWYgdGhlcmUgYXJlIGNvbmNlcm5zIGFib3V0IEFD
UEkgY29uZmlndXJhdGlvbiwgb25lIG9wdGlvbiBjb3VsZCBiZSB0byBjaGVjayBpZiB0aGUgZEdQ
VSBuZWVkcyBhIHJlc2V0IGJ5IGRpcmVjdGx5IGNoZWNraW5nIHRoZSBTT0wgcmVnaXN0ZXIuIEFz
IGZhciBhcyBJIGNhbiBzZWUsIHdoZW4gdGhlIGRHUFUgY29tcGxldGVzIGl0cyBzdXNwZW5kIHBy
b2Nlc3MsIHRoZSBTT0wgdmFsdWUgd2lsbCByZW1haW4gemVybyB1bnRpbCB0aGUgZEdQVSBpcyBy
ZXN1bWVkLiBDb252ZXJzZWx5LCBpbiB0aGUgY2FzZSBvZiBhIHN1c3BlbmQgYWJvcnQsIHRoZSBT
T0wgdmFsdWUgd2lsbCBiZSBub24temVyby4NCg0KVGhhbmtzLA0KUHJpa2UNCj4NCj4gPiAgICAg
ICAgICAgICBzb2xfcmVnMSA9IFJSRUczMl9TT0MxNShNUDAsIDAsIHJlZ01QMF9TTU5fQzJQTVNH
XzgxKTsNCj4gPiAgICAgICAgICAgICBtc2xlZXAoMTAwKTsNCj4gPiAgICAgICAgICAgICBzb2xf
cmVnMiA9IFJSRUczMl9TT0MxNShNUDAsIDAsIHJlZ01QMF9TTU5fQzJQTVNHXzgxKTsNCg==
