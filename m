Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD2CC54E60
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 01:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4286910F179;
	Mon, 18 Mar 2024 01:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/EEnQff";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEA910F179
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 01:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCjNVgMwj74/50EeRuwOc3nlaowft4+88P49ULLV9fHZOsfIdHuOb9xD9bB8CI423oXKyirBicD6VrpzxfTZukyRIuvOQgooM3if/a3rxUhf40nc6Zo4zEzEhQ+9hc90ozM6c4CuN9Az3GprN21Q9NH1TQTU8lnNEUO4Y8sI0wpRgUaS4XAw05jIrpddgTAB1qZll0rkhDxMcMaoiDK5tapibz/9hxdrm/CPAFvTw9X7Bwbk0MCMMH3pL+M2dRhx+g+pW3qBunL9Ei8m/4Om9PbMsaho/DioZUceDGCLMndgAkIYsx2GdjLwhg7gP8NwtdRO16URrKj587Ku8lEHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJcORjGwD81UKzbWM5FRPk9RXm0BmduO4g0pSzXq1bA=;
 b=bo2uyBzW0xQyKmYqlPO2ZwntX4iYIOa3PIrSjcFkXXfcOgNGAbdduv3VouKcCWOJZajLio2BIiHaB2L7oAVqrdZtS74atc2KaT5CgctUPB6IddSMycpmYXpVKUpfevwQzGnvmyJ7bNzlE8Mg7o62pUbBLFaDJ/5B3IXopdWsFwi1/bMaomPDXVQ2VEJvt7z06qoQnGbfwNgeI9lWr5n8mFMuURwpggglGbKFJ33k7vCCEfybRxDtvsrIrf4SV4bvAx4t7D4xIlmn2zoUoAft9dpgB8OmYviK1CYZjhLZgU/YkmvWncapE2vbqwjoTGpLpgstTii/cvZnt4flQes+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJcORjGwD81UKzbWM5FRPk9RXm0BmduO4g0pSzXq1bA=;
 b=d/EEnQff+BSJGMrlqzHs901GBLFqgjBNrARePvmjPr+PfLRViURAvTpV4uVkaQvF6WPUseXFea/MUebGoSEaSeTrBHq2ConPztnNWJvpdf7iMBUrJKbfiicVVo/+W0E1Q/8YzGhc/y4Z/+J3AP4qZuUiyv2FTC47VOVWwlL6d6o=
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 01:42:04 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::950c:8c43:3454:884b]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::950c:8c43:3454:884b%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 01:42:04 +0000
From: "Lee, Peyton" <Peyton.Lee@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIGRybS9hbWRncHUvdnBlOiBwb3dlciBvbiB2cGUg?=
 =?utf-8?Q?when_hw=5Finit?=
Thread-Topic: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
Thread-Index: AQHadTtmZPKIR7z+KUKKDKPyWJhnTbE1pxOAgADLt0CAAMFAAIAA0WfggAC/9ICAA/knAA==
Date: Mon, 18 Mar 2024 01:42:04 +0000
Message-ID: <MN2PR12MB4373E48E5C6D8826413024AA862D2@MN2PR12MB4373.namprd12.prod.outlook.com>
References: <20240313114451.1592772-1-peytolee@amd.com>
 <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
 <MN2PR12MB4373845FF59F1ACC83AAEFC986292@MN2PR12MB4373.namprd12.prod.outlook.com>
 <CADnq5_MzsCoj0VMKkQecWfGS1UAXE7Xvje3eoNbTP7fbdvXHRQ@mail.gmail.com>
 <MN2PR12MB437320223A607D4BAA8C182586282@MN2PR12MB4373.namprd12.prod.outlook.com>
 <CADnq5_NciR_1wqRCSYTJ+nUsYbfGiEBJtt3cwzyvREODGkywWw@mail.gmail.com>
In-Reply-To: <CADnq5_NciR_1wqRCSYTJ+nUsYbfGiEBJtt3cwzyvREODGkywWw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b2d8783-9d99-4470-aa4f-fa60af4e6aaa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T01:35:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SA1PR12MB8742:EE_
x-ms-office365-filtering-correlation-id: 1fa3f5b3-b022-4577-bcf8-08dc46ec9d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ti+Q9bqcMlXWHoJojSvLArfdKzaJOTd4pp8nkS44AKoNNtByGf4dCkIN+8B70RQgCLseIc2v6w9lBAKN1qDygpU8np12GteGSnBHisiygH/f/FUnNzOQiKEyD8Gu/6nYIAajgsMzxfXkA2qkka3SL0nyS33a80x8TvNCistHa7JnlH2jifSHyh0jxCsYE2atM1QeaN4NM+brynkjhu600WT82KxoeITa05ThoBxe7LECPqDH8uQSa3DTk8iyQjiJYtsgU4XBBRzs/iou4Rblg2ZfyDrOS2dDiMTXkUh9x14VeNfBWFG/dZKRPjR9yWcDVKB4SSPl8zpINZHuoZ0N/L9CAbsIPJ76bWYbDZ2MeM9z0DKEgi5qEt1feGvVBhoUUX8so0Og7jYxihXDjyjwKDTGo9EuXnLdoWJmQo/ikJ88egU0hrSS16kT+JgUlxdPILjIAQr6RIBcJb9t+kvcGI2Q4uIZnLnivJtM2jhKtwgMqUjL8yvx0d65AK+a4lF6+3wRkiLsDaeiIrJnHBQdsCA7X0sVRHDrwyIOTNqO3hlbpV79aVjWYySDTKUeuvCwSw/kCU2iTrknDWjI0DjmRRkmRZAjZlyQnr6nPIjsXBZVr69eieYnQyJNyqK1qHLBYqy1ORr8tKIdw30SW4Y7PY8hahYRsb0gydr+tr2CzZwupbLkN6igVNyX/2nz1yio0mhsRnuPOuYxD4BnOdre8Wl5dAu19Q+viKGxlNZuXE4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:MN2PR12MB4373.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFV0dyszSWhkVkVXZUVGNTNnZlJ3ZENjNjhlbHV2cm1YNmJnb3JXRFFxdUZ0?=
 =?utf-8?B?dEZaMEt1ckFJZlp1UVU0OXJKSjh5bGZ3Vlc3RFptL1liR01HMm5hWXZFTjNZ?=
 =?utf-8?B?VGV2YzFCbmRTdW5UanRvWnBwSXVVU2VIY2daQlEvWmhZSDZzMXF1b0tZOUJv?=
 =?utf-8?B?RXhNVjIvWmFjOWxtUDM2OUk3V3lveTdPNXBIMXJkSWZRVlB6aU1iL0JvNU42?=
 =?utf-8?B?ZzdyZW1ZU0dlb3h2TTQ4VWRoejF2R1ExbHgwZHY5QXluRHJkSnM5VitIQ09R?=
 =?utf-8?B?K3JiTXczVGJxNk5nZTFqRlFNUDN4Z3lzYmd4QU5DUzJBb1ZITGdoa2VibG9P?=
 =?utf-8?B?c1Ftc0JPcEtsRVVMWmowbHB0TllwK3VsU3NMcVdDbEVQbnplblJnT2x1MUF1?=
 =?utf-8?B?bVNrMllIdGtSUm0wRmNjdHFGNDNNUjQ5R081a2lmZkJ5amRqN1ZZZlhCN1dt?=
 =?utf-8?B?dFNWdElMb0JWSng2ZTVZcE9WVGhwQisxZ2pSNXJIMCtNZGxsY3MyaHB5V1Zr?=
 =?utf-8?B?dUJuaTN6TmV2SFRKa1RralJaaWVwVm55YURzZ0lpdU9EZTl1TVI3Z2NFMjhS?=
 =?utf-8?B?UjJVaVBCU3JDdnd4RTBmcjltNUxwUjNQNjFHanAyUkNUdzE5My9zM3ZBZml0?=
 =?utf-8?B?ek14bmZiZXFvcDZtbGNjQ2lTeU5pcTkwSlJKaW05NTlUR0VaV0ozd2dGSjND?=
 =?utf-8?B?NENiRG1QUEtVd3ZZZ3A1RytaTEhLazlsa2Y5QnVXaEJlSDV5aFI2bStsM3E0?=
 =?utf-8?B?WEhLRzhsZHVycDU4RzBqemJQSEtOdUlaR1dhbHNwVGxQcXBpZmh3KzdXVWdO?=
 =?utf-8?B?NkthUVl1ZkovT1pudmpseEZpSG9sY21mSkNpTFpHOXNMQlc2Tm9HV3ZrWXZW?=
 =?utf-8?B?K1RjbVlCSXBsU3NGUytBQXR4bTZzUTc2cFJOdUFsVUFKQ2FNUmgweGprMC9a?=
 =?utf-8?B?ZW9TS1FLZlhadlI5d3FjSGYxUnpjeTM0ckhIRDBIdXN2bXVDZDdrNkpiVzNv?=
 =?utf-8?B?VlU5VmltZEkvVVkvaXBDamlXT3FsUkpSdVZ4d2R3aGtweGV1ZEZHMkQvays4?=
 =?utf-8?B?ZGFGM2RKYStndUJTWXhPQTdGWXhhT1Zpc0tBVXNaNGhManZYclIyREh2dmdx?=
 =?utf-8?B?b0hEcVpjSlU4S21VN2Q4bEUxcWQ1TERZMlRCb283bzlDWWFVNXVHcDlITXZr?=
 =?utf-8?B?UjkyWWpzc0xqMlRVT3EydWdiZ29hcXBibFJxdDlDNmJ4MGkzL1lVWlJSOEtK?=
 =?utf-8?B?UnB3M3lTeWt1UUpUV3JuKzdrSm9iMUJrL3JaeUhyVnVNZUwyMlNQc3lNKzVZ?=
 =?utf-8?B?TlF2Z2l4U08reUhJUkkzQktOQTQvOXM0cjg3MDdUblIwamxMK2RpV240dkh6?=
 =?utf-8?B?b0w1M0VDQWJGZG1lUisxNTg0UjlOcG9XMXk5QndURlhNdndUWTE0YU1GNkpU?=
 =?utf-8?B?YkxyaC9ZZEZEMy95dVJJZzBSVllWN0lwUmVySW9XWTJlK080NEJEK3ZUc04x?=
 =?utf-8?B?NVF6eDhZUDhFb1dycnBzR2NQMTRVZVcyUXlTS2sxOEx4UjBPeTZxSTRUMjlh?=
 =?utf-8?B?RkNqRXppekdlWURLQXFVemZzdlhYMGRESmhvbTg3VW8yejQvakl3THhtQzlH?=
 =?utf-8?B?NlNkNEpuMS9UUHE1VWNuamZ0YWx6YnFFeUN3amFoT0ZvRU9pakhoOXFkUCtx?=
 =?utf-8?B?Sndqd0FJei84U1dmZ0FRWm5CYksybmNBSVJJZUp0dUdkYzVGS3h4dERPa1ov?=
 =?utf-8?B?YXk4RFl1U2RCMnN0M2RNY0tISVZMK2hOeitXV0dRekZJZXpoZjM3THhIcjgy?=
 =?utf-8?B?SUsyWlVHOEtINERCREpLMjN6cFBtdUxDSnlmY1dnVFVkb2tiTUFtb2IvM0FH?=
 =?utf-8?B?YVZFYms1cUlXM0gvaDJGSktwZlphMFdKUHNkeUI4V0w5bDBodVJMd3VFZ2JP?=
 =?utf-8?B?cDdkWUdmZTB2ZTJGbHFLUHVBdjhEbHFrVnExV24veVhaVDhQZ1lYb29zUUpT?=
 =?utf-8?B?MGhUQ3k4TWRFZzNURWYvdmZsMHZIVE5YQ3Iwb3BCbFpqSkNydndiVGxoeExO?=
 =?utf-8?B?Ym9Vc1R6RFFlMDRYSjVkMUZSTW9vYzBZS2VGMHhLb2FwYjJlVTdLMTNDMUJ1?=
 =?utf-8?Q?tsgM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa3f5b3-b022-4577-bcf8-08dc46ec9d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 01:42:04.3056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtF4TfaRv+uy2Mx0zsLAFwY3KTzopnQTsaeG1lHF18NZs9oGNWpE0j2Q1wV5RpIzPnITqf6BJqR6kza/6zIyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgNCg0KPiBEb2VzIHRo
ZSBJQiB0ZXN0IHRha2UgY2FyZSBvZiB0aGlzPyAgSSBqdXN0IHdhbnQgdG8gY29uZmlybSB0aGF0
IHdlIGFyZW4ndCBsZWF2aW5nIGl0IHBvd2VyZWQgdXAgdW5sZXNzIGEgdXNlciBydW5zIGEgVlBF
IHdvcmtsb2FkIHdoaWNoIG1pZ2h0IG5vdCBoYXBwZW4uDQoNClllcywgdGhlIElCIHRlc3QgdGFr
ZSBjYXJlIG9mIHRoaXMuDQpUaGUgZmxvdyBpcyBsaWtlIHRoaXM6IGFtZGdwdV9kZXZpY2VfZ3B1
X3JlY292ZXItPmFtZGdwdV9kb19hc2ljX3Jlc2V0LT5hbWRncHVfaWJfcmluZ190ZXN0cw0KVGhl
cmVmb3JlLCB0aGUgaWRsZSB0aHJlYWQgaXMgd2FrZWQgdXAgYW5kIHRoZSBWUEUgaXMgcG93ZXJl
ZCBvZmYgdGhlbi4NCg0KVGhhbmtzLA0KUGV5dG9uDQoNCi0tLS0t5Y6f5aeL6YO15Lu2LS0tLS0N
CuWvhOS7tuiAhTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQrlr4Tku7bm
l6XmnJ86IEZyaWRheSwgTWFyY2ggMTUsIDIwMjQgODo1NSBQTQ0K5pS25Lu26ICFOiBMZWUsIFBl
eXRvbiA8UGV5dG9uLkxlZUBhbWQuY29tPg0K5Ymv5pysOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
WmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IE1hLCBMaSA8TGkuTWFAYW1kLmNv
bT47IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQrkuLvml6g6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHUvdnBlOiBwb3dlciBvbiB2cGUgd2hlbiBod19pbml0DQoNCk9uIFRodSwgTWFyIDE0LCAy
MDI0IGF0IDk6NDDigK9QTSBMZWUsIFBleXRvbiA8UGV5dG9uLkxlZUBhbWQuY29tPiB3cm90ZToN
Cj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IEhpIEFsZXgNCj4N
Cj4gPiBJIHRoaW5rIGl0IHdpbGwgY29udGludWUgdG8gYmUgcG93ZXJlZCB1cCB1bnRpbCBhIFZQ
RSBqb2IgY29tZXMgaW4gYW5kIGNvbXBsZXRlcyBhbmQgdGhlIGlkbGUgaGFuZGxlciBnZXRzIHNj
aGVkdWxlZC4gIElmIGEgVlBFIGpvYiBkb2Vzbid0IGNvbWUgaW4sIGl0IHdpbGwgc3RheSBwb3dl
cmVkIHVwIEkgdGhpbmsuDQo+IFllcywgY29ycmVjdC4NCj4gQW5kIGFmdGVyIHRoZSBWUEUgaXMg
Y2FsbGVkIHRvIGRvIGluaXRpYWxpemF0aW9uLCBhIHNpbXBsZSB0ZXN0IGlzIGV4ZWN1dGVkIGZv
ciBjaGVja2luZyBWUEUgc3RhdHVzLCBhbmQgdGhlIGlkbGUgaGFuZGxlciBnZXRzIHNjaGVkdWxl
ZCB0byBwb3dlciBvZmYgdGhlIFZQRSB3aGVuIHRoZSB0ZXN0IGZpbmlzaGVkLg0KDQpEb2VzIHRo
ZSBJQiB0ZXN0IHRha2UgY2FyZSBvZiB0aGlzPyAgSSBqdXN0IHdhbnQgdG8gY29uZmlybSB0aGF0
IHdlIGFyZW4ndCBsZWF2aW5nIGl0IHBvd2VyZWQgdXAgdW5sZXNzIGEgdXNlciBydW5zIGEgVlBF
IHdvcmtsb2FkIHdoaWNoIG1pZ2h0IG5vdCBoYXBwZW4uDQoNCkFsZXgNCg0KDQo+DQo+IFRoYW5r
cywNCj4gUGV5dG9uDQo+DQo+IC0tLS0t5Y6f5aeL6YO15Lu2LS0tLS0NCj4g5a+E5Lu26ICFOiBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4g5a+E5Lu25pel5pyfOiBUaHVy
c2RheSwgTWFyY2ggMTQsIDIwMjQgODo1OCBQTQ0KPiDmlLbku7bogIU6IExlZSwgUGV5dG9uIDxQ
ZXl0b24uTGVlQGFtZC5jb20+DQo+IOWJr+acrDogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpo
YW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBNYSwNCj4gTGkgPExpLk1hQGFtZC5j
b20+OyBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPg0KPiDkuLvml6g6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRncHUvdnBlOiBwb3dlciBvbiB2cGUgd2hlbiBod19pbml0DQo+DQo+IE9uIFdlZCwgTWFy
IDEzLCAyMDI0IGF0IDk6MzPigK9QTSBMZWUsIFBleXRvbiA8UGV5dG9uLkxlZUBhbWQuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+
ID4gSGkgQWxleCwNCj4gPg0KPiA+IFRoZXJlIGFyZSB0d28gcGxhY2VzIHdoZXJlIFZQRSB3aWxs
IGxvc2UgcG93ZXI6IFdoZW4gdGhlcmUgaXMgYSBzeXN0ZW0gY2FsbCB0byB2cGVfaHdfZmluaSgp
LCBhbmQgdGhlIHZwZS10aHJlYWQgZmluZHMgdGhhdCBWRVAgaGFzIG5vIGpvYnMgaW4gdGhlIHF1
ZXVlLg0KPiA+IFRoaXMgcGF0Y2ggaXMgdG8gbWFrZSBzdXJlIHRoYXQgVlBFIGlzIHBvd2VyIHVw
IGJlZm9yZSBsb2FkaW5nIGZpcm13YXJlLg0KPg0KPiBJIHRoaW5rIGl0IHdpbGwgY29udGludWUg
dG8gYmUgcG93ZXJlZCB1cCB1bnRpbCBhIFZQRSBqb2IgY29tZXMgaW4gYW5kIGNvbXBsZXRlcyBh
bmQgdGhlIGlkbGUgaGFuZGxlciBnZXRzIHNjaGVkdWxlZC4gIElmIGEgVlBFIGpvYiBkb2Vzbid0
IGNvbWUgaW4sIGl0IHdpbGwgc3RheSBwb3dlcmVkIHVwIEkgdGhpbmsuDQo+DQo+IEFsZXgNCj4N
Cj4gPg0KPiA+IFRoYW5rcywNCj4gPiBQZXl0b24NCj4gPiAtLS0tLeWOn+Wni+mDteS7ti0tLS0t
DQo+ID4g5a+E5Lu26ICFOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4g
PiDlr4Tku7bml6XmnJ86IFdlZG5lc2RheSwgTWFyY2ggMTMsIDIwMjQgOToxNyBQTQ0KPiA+IOaU
tuS7tuiAhTogTGVlLCBQZXl0b24gPFBleXRvbi5MZWVAYW1kLmNvbT4NCj4gPiDlia/mnKw6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5j
b20+Ow0KPiA+IE1hLCBMaSA8TGkuTWFAYW1kLmNvbT47IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5j
b20+DQo+ID4g5Li75peoOiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3ZwZTogcG93ZXIgb24gdnBl
IHdoZW4gaHdfaW5pdA0KPiA+DQo+ID4gT24gV2VkLCBNYXIgMTMsIDIwMjQgYXQgNzo0MeKAr0FN
IFBleXRvbiBMZWUgPHBleXRvbGVlQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRvIGZp
eCBtb2RlMiByZXNldCBmYWlsdXJlLg0KPiA+ID4gU2hvdWxkIHBvd2VyIG9uIFZQRSB3aGVuIGh3
X2luaXQuDQo+ID4NCj4gPiBXaGVuIGRvZXMgaXQgZ2V0IHBvd2VyZWQgZG93biBhZ2Fpbj8gIFdv
bid0IHRoaXMgbGVhdmUgaXQgcG93ZXJlZCB1cD8NCj4gPg0KPiA+IEFsZXgNCj4gPg0KPiA+ID4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBleXRvbiBMZWUgPHBleXRvbGVlQGFtZC5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnBlLmMgfCA2
ICsrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiA+DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5j
DQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYw0KPiA+ID4g
aW5kZXggNzBjNWNjODBlY2RjLi5lY2ZlMGYzNmU4M2UgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnBlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYw0KPiA+ID4gQEAgLTM5Niw2ICszOTYsMTIg
QEAgc3RhdGljIGludCB2cGVfaHdfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gPiAgICAgICAgIHN0
cnVjdCBhbWRncHVfdnBlICp2cGUgPSAmYWRldi0+dnBlOw0KPiA+ID4gICAgICAgICBpbnQgcmV0
Ow0KPiA+ID4NCj4gPiA+ICsgICAgICAgLyogUG93ZXIgb24gVlBFICovDQo+ID4gPiArICAgICAg
IHJldCA9IGFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9J
UF9CTE9DS19UWVBFX1ZQRSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NUQVRFX1VOR0FURSk7DQo+ID4gPiArICAgICAg
IGlmIChyZXQpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICsNCj4g
PiA+ICAgICAgICAgcmV0ID0gdnBlX2xvYWRfbWljcm9jb2RlKHZwZSk7DQo+ID4gPiAgICAgICAg
IGlmIChyZXQpDQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+IC0tDQo+
ID4gPiAyLjM0LjENCj4gPiA+DQo=
