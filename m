Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760B8C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 12:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD3610E83B;
	Mon, 31 Aug 2026 12:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WAfzLgw5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA6710E7EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djb3kQr4lFCejmoJ2e1A5blx9utmE+j9kEtx2XdStBhRo5/9acOIEgTQAYxinn3IoNFrK8OYHZpVWFGUGlnylsLOa7qn2FbVaPw7QwBSRLprb2PKC36+uOhRrG2jw/sjRQNaxiMnVgGqG/le5FUEyFMHzP40cRGqvdHaHn4mX/6as1qq3nORQPua/bcWv/da2JWI24H7hVhedibcOIzpCIn97KOHoDKdzZPnUXHzkhecz9HkNXDhau5/V/UDZ/d9xVwPlN/JU+HevgRpc/k6h8S/HEhc6iflVheHqEn9mwGS+MOlT5rigShqEkwAptNkooZhRDvv9DH+uQ7KcBX4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPhHw5mCIeUMxYyLJmdN32qyc4d/AccDhbdYmP934Dc=;
 b=PosLbdKVDbqhqHNHRi0zv0vU4FHWogBpHtQBDZ1Ew3RjE+ji54PPvmLX/iUFgJLLKYfAg142eXA06ee+KMiw+ycLLsarjUA7tKF07xHOlOW1aIIzxPj9HCjs/kX0F1c+U+6q2PGxx9gDuCB34XONeHNhq0mGXAh9sVkWr1gZuBlukm2+0+zQBVfHrtLHjQwhp+E6TQevTkC1EUUj+rHEijP0uh7qIiWw3o+9T043cQU6/LyOrr30LTEOpZ4/TeR+eZQPsqOGUZbS/x10WBV4Kq9811Vx0Q2XhNM5ZbjzNgkiXL+qqQafuXKq6B5jhKUEmWcu5Yfw+JcO+jKax1C7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPhHw5mCIeUMxYyLJmdN32qyc4d/AccDhbdYmP934Dc=;
 b=WAfzLgw5OyVZqgrY4IAgoQGiJGTYPk5pCzVlR+r88wP/ebIc5MCThdazaq/EEPnqbICYIW/mjjpY72Yj+Y/mHSvilNl8zdYDng3jRppVQdkg4o04InPAHBNJc3F5Tkvs+anIM5N02MpR5wwg+IruvrEMnSGszozHG/h4AZg/GjM=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Mon, 31 Aug
 2026 12:47:46 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:47:46 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Topic: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Index: AQHdOQIsOtLaxb5uKU2B0jqBexC/y7a3/IKAgAACwoCAABBroIAABNQAgAAE+1A=
Date: Mon, 31 Aug 2026 12:47:46 +0000
Message-ID: <BN9PR12MB52119D373A6AB87F0DD5A1B193A92@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
 <0e34543c-4802-4023-befa-480b5452d92b@amd.com>
 <BN9PR12MB5211F46FDD421E130B99248793A92@BN9PR12MB5211.namprd12.prod.outlook.com>
 <0a3293bd-317c-4bf8-8fca-395f7a1435cb@amd.com>
In-Reply-To: <0a3293bd-317c-4bf8-8fca-395f7a1435cb@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Kenneth.Feng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T12:39:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|SN7PR12MB8130:EE_
x-ms-office365-filtering-correlation-id: 6ff773a2-1cd5-43d7-0895-08df075e0ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|38070700021|6133799003|10067099003|4143699003|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: vCDS3QqsQYiz8bnAKUh6ZHTimOoKWMXRO+IxkIHYEXW0EqmBBagx1XVPGRK3H2J/ErPS/DGDbV7sxqdqIqf3kE+HHVETX6EY79MHaZE5y0nFj7gOT1tzJnvmjkFO8ePUlYeSt+l8iRa7Oeqjdh1S3a/iSzfjjB7rEc2RtnCuwjt9UxJDn193QMASiuHIG1H+UGhNbxT7GwIo6uHXoFYKJdEBD4fHgXjv2Q1G1RdrGUC2dVpu5ZRSQH4ZslrJJkB+e5QrGzbBAROUJGJ5QZ1s+3lBkFWTglG5qfk+q+2oCon932xreYAHzDDnR4f9FfGjc+z0kXpl30IjE6FkNoH07hmVeaZyaVD9s86C8rXkMZ3PmgfojYEb2eairQ7eQAJ/YYenI54efl1OSoNC9b6LG0Db0/hRxP+0pHY4kNNeqw67gD/b4MTgtXBUWl62lvXtRjJA5LLrvCklNuwQsnC9jQ8PIKhgZtsJ3wtPLFN969yNDM7Y6GKbeGQ+s9GJn/S/+VObcwq1d2MjpjPe8Ycu01bu26NoKtwSoGR0mAPSH1/CDoGSMxBTmBRoJsIHfV4NjviNivGRtReRitA+/aUMAm2xdDaDqg2FEryxczeBVjmWgeg47RRT0cy5DU8mR8TKK54kmvJy8h3aL06RGJ/nybOwSF8QM7hHrisZpIBH9r4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHUrNWluRk5FWEpFLzI0NGIvOXkzNkpZN1kyK1AyUk1sMnVpSEZPTEdCU1l5?=
 =?utf-8?B?Wm9mOVVlZ1RxMHByeHFkeXZ6NCsvaUlzUGI3VTJmYTJxQk1yZkUwVTNWRFhE?=
 =?utf-8?B?RDVGdm1aeXNwbFV4bDk1UzRBSXZNWDJ1RzlQdDkycEVIZm5oY205UHlTSWdH?=
 =?utf-8?B?YlgxVnhtcUl5VTA3Uy9pVXZLc05EcFlsaCtabEFiRmhDUTM1MmkyTGtjcERu?=
 =?utf-8?B?Y1BHZHNoNTdpTWZ2YjVqRFY2VFI3ak1wVEFUZGswbm5ibjhuNHZMTXF0NW9H?=
 =?utf-8?B?UG02c2M3MWcrUFpXS0dkQXhTbkloTkdVTENVbTZ1Zm92YWQ5V2gzVzZMbXpn?=
 =?utf-8?B?bTYweitRcmZreERjeEF1c05vdXlSYUh3L3gvdlg3TVRKMXBuZlFMRHB3eDZ0?=
 =?utf-8?B?M2t2bGhxOXd3T3NrczRUOEtlMVFYQkQ5NDhGQmNKQzh6MUFMMHBJZWtIK0w5?=
 =?utf-8?B?Z1ZobjN2SWJTcFNRdUpMODc3b3JmbVpXTUprMjVmQTh0RTA3cUdGVmowMUQv?=
 =?utf-8?B?M25PS01HK3pTakkxMFgwL3lvdWxmd3d2MnhBUllMOHFMNVNqS3NROWVuK3BR?=
 =?utf-8?B?RUh0NzlkeHdaNk1CWDZlRUpTQS9TeU42TjdBR241SHVBSm1FREtIVmF4OVdU?=
 =?utf-8?B?V1hLM3hKaFBpRnlDc3BWY3lVU0xPZkg2d1VHOXZQUEpCdmt6cnpraHlrM2g0?=
 =?utf-8?B?RGJRSEJDYmljUERBMnRaZmJrVEVLYytzVDNQVk1oN1gydUpqNmVCQXN6ejBN?=
 =?utf-8?B?aW1lL0dRMHg2c3ExRGdiMjR1U04yMkk3aXN0eWJ5bFZ0WVZRMFBvOTR6TkhD?=
 =?utf-8?B?NFg4Z0xrWHZwclNEU240THZNdW52OXUzdVBKb3V2bm16b09mSG1GU0FUenpI?=
 =?utf-8?B?ZVRLT3ZFckZ4WnU3Znpoai9JOGVTRU5sc2t0eVI2Z1ZadXFDSEprWWxBQTRB?=
 =?utf-8?B?emJ6bDZ0WGV5RStRWTg2Vy9BOUJ6aXRiMlZoRU9jOUpWUlJudEYyVzI3YVdX?=
 =?utf-8?B?KzJOaGk1RWZEQ0ZsTU1YVGEwUGdtbFBnT3A2VFA4SWZFcnFTdVV3dHFGM1hu?=
 =?utf-8?B?ZVgxNE5wVE5wZzRjQ0hGSVFPOXhKZFBVd3VUcTMzUWlUcVdHZFVjcDhLVFF0?=
 =?utf-8?B?RGErQzlpbVBkbWN5Q3ZrbHIyZCt2VTRHTHE0MGhhYWk4WWZabU1qSUxDR2dU?=
 =?utf-8?B?OHNNdTgrMXZBdzFRem0rMTFXK3hUNUZ4dGZJNG1aaVJZZ2RqYUJ6R012cy95?=
 =?utf-8?B?WmZwT2RiSlZleFZGTXpOcGsvbnV4ZnRIdEhLa1hwdjAxcjNxL0VHMXNObnJ6?=
 =?utf-8?B?NTlBMlRGWVZSM043RC9GOFFzSXl4RE9IaEtLcDBnRzNxZ3I1MGN2bk5OeG0r?=
 =?utf-8?B?SFJKVHNDb1ZrZXBBbVVmUHBzL0N1MUQwZSs4bGdRYXFwcGQ5NnlUMmk3TW9s?=
 =?utf-8?B?ZEFKVjdWWDlSZWZqQkpmL2h5OWRJYzNHaTVYbmJxZUhmNm4zWmFpMXVQL0c3?=
 =?utf-8?B?MDBQZE9jclVGd1pVTHIxMWs0T2NNZi9iOW5VaEhnMDRka3ZnR1dzdnhvZlk5?=
 =?utf-8?B?MWlFVFppRERhdFhGeWpERzNWOUxvWWpkbjNrS2d0cFljWDZ1Q1hRT3ZVSmtM?=
 =?utf-8?B?NHNaTCtkcW9xc08wU3Y0TVRHOUVqWGpBajd6ZFdrZFFqNERhM0c5Vmw0TTVp?=
 =?utf-8?B?SiswcjJ1YmxmUVNIWUtxSEhGc1BsSHZ4bVBTZXp0djAxYkdTVkpzS0tnSmVC?=
 =?utf-8?B?U2t1OFlRL1U1dS9HV2FpUE1iS2R5ZEdlK3A5R2hqTzVvSUVaTlc4dUx6WkVO?=
 =?utf-8?B?aDVwNTlSb1NrNE5oOWN6NVB3eWxlOS85eVloOU9HZEVjdDJkL3pmUmJmOHND?=
 =?utf-8?B?MUhqSjlYMHd5T29pMTZlZVpWalF3djhZNldqREhxeVg1NWswc094OXdBT2FK?=
 =?utf-8?B?dFF5L3ZuRUZ3U1VPQXBDZUR3M3hKSENnOTc1K3JkVEsxUnJCSFV1amVpc3Vp?=
 =?utf-8?B?ZVAvK2VnRTFJb1N6THY4QmpHTmNzUER6WVN4VmVMQVJsd2RUcWs4djN6OGt6?=
 =?utf-8?B?S25pQkloRmp2UnBkeEJLa0JFL0Fra2wvejNGME9IRi9FQm5kSTR5M2RPN3RK?=
 =?utf-8?B?T0d4ellGUHRxUVArcHZLL2d4cWpZTWQ0QjVZUGxmQXhobkUrVWY1eW9naStE?=
 =?utf-8?B?cmFTUGNjRFJNT1VkVW5telpZTmxGRERUYlgwVkowamJrNy9mdElJRzVqSVZW?=
 =?utf-8?Q?1OvajSnMIKNwyP4U9aaEHj6bCs0cGpeDANG5EwlDik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff773a2-1cd5-43d7-0895-08df075e0ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 12:47:46.5206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58LgjiVKYUSiTTt0Ed2i0PtnpYnuYqMelTHoPXBvscQuumlxuHru9xp0RzTrvJmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAzMSwg
MjAyNiA4OjIyIFBNDQo+IFRvOiBXYW5nLCBLZXZpbiA8S2V2aW4uV2FuZ0BhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAwLzddIGRybS9hbWQvcG06IHN0YWdlIE9EIHJlc2V0IHVudGlsIGNvbW1p
dA0KPg0KPg0KPg0KPiBPbiAzMS1BdWctMjYgNTozNiBQTSwgV2FuZywgS2V2aW4gd3JvdGU6DQo+
ID4gQU1EIEdlbmVyYWwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+PiBTZW50OiBNb25k
YXksIEF1Z3VzdCAzMSwgMjAyNiA3OjA2IFBNDQo+ID4+IFRvOiBXYW5nLCBLZXZpbiA8S2V2aW4u
V2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdr
aW5nDQo+ID4+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRo
LkZlbmdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzddIGRybS9hbWQvcG06
IHN0YWdlIE9EIHJlc2V0IHVudGlsIGNvbW1pdA0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAz
MS1BdWctMjYgNDoyNSBQTSwgTGF6YXIsIExpam8gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+
IE9uIDMxLUF1Zy0yNiAxMDowNSBBTSwgS2V2aW4gV2FuZyB3cm90ZToNCj4gPj4+PiBbU29tZSBw
ZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJv
bQ0KPiA+Pj4+IGtldmluLndhbmdAYW1kLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50
IGF0IGh0dHBzOi8vYWthLm1zLw0KPiA+Pj4+IExlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlv
biBdDQo+ID4+Pj4NCj4gPj4+PiBUaGUgcHBfb2RfY2xrX3ZvbHRhZ2UgaW50ZXJmYWNlIGV4cG9z
ZXMgYSBzdGFnZWQgT3ZlckRyaXZlIHdvcmtmbG93Og0KPiA+Pj4+IHVzZXJzIGVkaXQgY2xvY2ss
IHZvbHRhZ2UsIGFuZCBwb3dlciBzZXR0aW5ncywgdGhlbiB3cml0ZSAiYyIgdG8NCj4gPj4+PiBj
b21taXQgdGhlbSB0byB0aGUgU01VLg0KPiA+Pj4+DQo+ID4+Pj4gSG93ZXZlciwgUFBfT0RfUkVT
VE9SRV9ERUZBVUxUX1RBQkxFIGRvZXMgbm90IGZvbGxvdyB0aGlzDQo+IHdvcmtmbG93DQo+ID4+
IG9uDQo+ID4+Pj4gZXZlcnkgU01VIHZlcnNpb24uIFNvbWUgYmFja2VuZHMgcmVzdG9yZSB0aGVp
ciBjYWNoZWQgc2V0dGluZ3MgYW5kDQo+ID4+Pj4gd2FpdCBmb3IgImMiLCB3aGlsZSBvdGhlcnMg
dXBsb2FkIHRoZSByZXNldCB0YWJsZSBvciBzZW5kDQo+ID4+Pj4gZnJlcXVlbmN5LWxpbWl0IGNv
bW1hbmRzIGRpcmVjdGx5IGZyb20gInIiLiBBcyBhIHJlc3VsdCwgdGhlIHNhbWUNCj4gPj4+PiB1
c2Vyc3BhY2Ugc2VxdWVuY2UgaGFzIGRpZmZlcmVudCBoYXJkd2FyZSBlZmZlY3RzIGFjcm9zcyBB
U0lDcy4NCj4gPj4+Pg0KPiA+Pj4+IEZvciBleGFtcGxlOg0KPiA+Pj4+DQo+ID4+Pj4gLSBTTVUg
MTQuMC4wIGFuZCBTTVUgMTMuMC41IHN0YWdlIHJlc2V0IGxpbWl0cyB1bnRpbCAiYyIuDQo+ID4+
Pj4gLSBTTVUgMTQuMC4yIGFuZCBTTVUgMTMuMC42IGFwcGx5IHJlc2V0IHZhbHVlcyBpbW1lZGlh
dGVseS4NCj4gPj4+PiAtIE5hdmkxMCBzdGFnZXMgdGhlIGJvb3QgT0QgdGFibGUsIHdoaWxlIFZl
Z2EyMCByZWFkcyB0aGUgY3VycmVudCBTTVUNCj4gPj4+PiAgICAgdGFibGUgaW5zdGVhZCBvZiBy
ZXN0b3JpbmcgdGhlIHNhdmVkIGRlZmF1bHRzLg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBzZXJpZXMg
bWFrZXMgInIiIHJlc3RvcmUgZGVmYXVsdCB2YWx1ZXMgb25seSBpbiBkcml2ZXItc2lkZQ0KPiA+
Pj4+IHN0YWdpbmcgc3RhdGUuICJjIiByZW1haW5zIHRoZSBzb2xlIG9wZXJhdGlvbiB0aGF0IHVw
bG9hZHMgYW4gT0QNCj4gPj4+PiB0YWJsZSBvciBzZW5kcyBmcmVxdWVuY3ktbGltaXQgY29tbWFu
ZHMgdG8gUE1GVy4NCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgZ2l2ZXMgcHBfb2RfY2xrX3ZvbHRhZ2Ug
b25lIGNvbnNpc3RlbnQgdHJhbnNhY3Rpb24gbW9kZWw6DQo+ID4+Pj4NCj4gPj4+PiAgICAgZWRp
dC9yZXNldCAtPiBzdGFnZWQgZHJpdmVyIHN0YXRlIC0+IGNvbW1pdA0KPiA+Pj4NCj4gPj4+IFJl
c2V0IHNob3VsZCBiZSByZXNldCB0byBkZWZhdWx0cyBhbmQgc2hvdWxkbid0IHJlcXVpcmUgZXh0
cmEgY29tbWl0Lg0KPiA+Pj4gVGhpcyBicmVha3MgZXhpc3RpbmcgdXNlcnNwYWNlIGZvciBTTVUg
MTMuMC42Lg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSBzZWUgdGhhdCB0aGlzIGJyZWFrcyBleGlzdGlu
ZyB1c2Vyc3BhY2UgZm9yIGFsbW9zdCBhbGwgb2YgaXQuIFNNVQ0KPiA+PiAxMy4wLjIgYWxzbyBy
ZXNldHMgdG8gdGhlIGRlZmF1bHQgY2xvY2tzIGltbWVkaWF0ZWx5LCB3aGlsZSBvdGhlcnMNCj4g
Pj4gdXNlIGEgZmFsbHRocm91Z2ggbG9naWMgdG8gY29tbWl0IHRoZSBjaGFuZ2VzIGltbWVkaWF0
ZWx5LmFwcGxpZWQuDQo+ID4+DQo+ID4+IFRoaXMgYmVoYXZpb3IgbmVlZHMgdG8gYmUga2VwdCBh
cyBpdCBpcy4NCj4gPg0KPiA+IFRoaXMgYmVoYXZpb3IgY2hhbmdlIGlzIGludGVudGlvbmFsLCBh
bmQgdGhlc2UgcGF0Y2jigJFzZXJpZXMgaW50cm9kdWNlcyBhDQo+IHVuaWZpZWQgdHJhbnNhY3Rp
b25hbCBtb2RlbCBmb3IgcHBfb2RfY2xrX3ZvbHRhZ2U6DQo+ID4gLSBgcmAgcmVzdG9yZXMgZGVm
YXVsdHMgd2l0aGluIGRyaXZlciBjYWNoZS4NCj4gPiAtIG9ubHkgYGNgIGNvbW1pdHMgc2V0dGlu
Z3MgdG8gUE1GVy4NCj4gPiBUaGUgZXhpc3RpbmcgaW1tZWRpYXRl4oCRcmVzZXQgcGF0aHMgYXJl
IEFTSUPigJFzcGVjaWZpYyBpbmNvbnNpc3RlbmNpZXMuDQo+ID4gU01VIDEzLjAuMiBwdXNoZXMg
ZGVmYXVsdCBjbG9jayBsaW1pdHMgZGlyZWN0bHksIHdoZXJlYXMgb3RoZXIgYmFja2VuZHMNCj4g
YWNoaWV2ZSBlcXVpdmFsZW50IHJlc3VsdHMgdmlhIHRoZSBjb21taXQgcGF0aC4NCj4gPiBUaGlz
IHNlcmllcyB1bmlmaWVzIGJvdGggdW5kZXIgUG93ZXJQbGF54oCZcyBzdGFnZWTigJFyZXNldCBt
b2RlbC4NCj4gPiBCdHcsIHVzZXIgc3BhY2UgZGVzaXJpbmcgaW1tZWRpYXRlIHJlc2V0IHNoYWxs
IGlzc3VlIGAiciJgIGZvbGxvd2VkIGJ5IGAiYyJgLg0KPiA+DQo+DQo+IFRoaXMgaXMgd2hhdCBi
cmVha3MgZXhpc3RpbmcgdXNlcnNwYWNlLg0KDQpBcyBzdGF0ZWQgZWFybGllciwgdGhpcyBzZXJp
ZXMgZml4ZXMgaW5jb25zaXN0ZW50IGRyaXZlciBiZWhhdmlvci4gTm90ZSB0aGF0IGRpdmVyZ2Vu
dCBzZW1hbnRpY3MgYWxyZWFkeSBleGlzdCBhY3Jvc3MgQVNJQ3MgdG9kYXk7DQp3aXRob3V0IHRo
aXMgZml4LCBtZXJlbHkgYSBkaWZmZXJlbnQgc3Vic2V0IG9mIEFTSUNzIHdvdWxkIGJlIGFmZmVj
dGVkLiBUaGUgc2VyaWVzIGJyaW5ncyB0aGVtIHVuZGVyIGEgdW5pZmllZCB0cmFuc2FjdGlvbmFs
IG1vZGVsLg0KDQpIaSBARGV1Y2hlciwgQWxleGFuZGVyIEBGZW5nLCBLZW5uZXRoLA0KRm9yIGRy
aXZlcuKAkWJlaGF2aW9y4oCRY2hhbmdlIGNvbmNlcm5zOiBJ4oCZbSB1bnN1cmUgd2hpY2ggZml4
IGRpcmVjdGlvbiBpcyBiZXR0ZXIuIFN0aWxsLCBjb252ZXJnaW5nIGFsbCBoYXJkd2FyZSB1cGRh
dGVzIGludG8gdGhlICdjJyBjb21taXQgYWlkcyBkcml2ZXIgc3RhdGUgbWFpbnRlbmFuY2UuDQoN
CkJlc3QgUmVnYXJkcywNCktldmluDQoNCj4NCj4gT25seSBTTVUgMTQuMC4wLzEzLjAuNS9OYXZp
MTAgYXJlIG5vdCByZXNldHRpbmcgdG8gZGVmYXVsdCBjbG9ja3Mgd2l0aCAncicNCj4gb3BlcmF0
aW9uLiBUaGUgZG9jdW1lbnRhdGlvbiBhbHNvIGdpdmVzIHRoZSBpbXByZXNzaW9uIHRoYXQgJ3In
DQo+IGRvZXNuJ3QgcmVxdWlyZSBhIGNvbW1pdC4NCj4NCj4gIklmIHlvdSB3YW50IHRvIHJlc2V0
IHRvIHRoZSBkZWZhdWx0IHBvd2VyIGxldmVscywgd3JpdGUg4oCccuKAnSAocmVzZXQpIHRvIHRo
ZSBmaWxlIHRvDQo+IHJlc2V0IHRoZW0iDQo+DQo+IFRoZSBwYXRjaCBzaG91bGQgYmUgdG8gY29y
cmVjdCB0aGUgbm9uLWNvbmZvcm1pbmcgb25lcyByYXRoZXIgdGhhbg0KPiBlbmZvcmNpbmcgYSAn
Yycgb3BlcmF0aW9uIHRvIHJlc2V0Lg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4gPiBCZXN0IFJl
Z2FyZHMsDQo+ID4gS2V2aW4NCj4gPg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IExpam8NCj4g
Pj4NCj4gPj4NCj4gPj4+IFRoYW5rcywNCj4gPj4+IExpam8NCj4gPj4+DQo+ID4+Pj4NCj4gPj4N
Cj4gPj4+PiBJdCBhbHNvIHBlcm1pdHMgdXNlcnNwYWNlIHRvIHJlc2V0IGEgc3RhZ2VkIGNvbmZp
Z3VyYXRpb24sIGFkanVzdA0KPiA+Pj4+IG9uZSBvciBtb3JlIHNldHRpbmdzLCBhbmQgc3VibWl0
IHRoZSBmaW5hbCBjb25maWd1cmF0aW9uIHdpdGggb25lDQo+ID4+Pj4gY29tbWl0LA0KPiA+PiB3
aXRob3V0IHRlbXBvcmFyaWx5IGFwcGx5aW5nIGFuIGludGVybWVkaWF0ZSBkZWZhdWx0IGNvbmZp
Z3VyYXRpb24uDQo+ID4+Pj4NCj4gPj4+PiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3Rv
cC5vcmcvZHJtL2FtZC8tL3dvcmtfaXRlbXMvNTY5MA0KPiA+Pj4+DQo+ID4+Pj4gS2V2aW4gV2Fu
ZyAoNyk6DQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdlIG9kIHJlc2V0IGZvciBzbXUgMTEu
MC43DQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdlIG9kIHJlc2V0IGZvciBzbXUgMTMuMC4y
DQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdlIG9kIHJlc2V0IGZvciBzbXUgMTMuMC4wLzEz
LjAuNw0KPiA+Pj4+ICAgICBkcm0vYW1kL3BtOiBzdGFnZSBvZCByZXNldCBmb3Igc211IDEzLjAu
Ng0KPiA+Pj4+ICAgICBkcm0vYW1kL3BtOiBzdGFnZSBvZCByZXNldCBmb3Igc211IDE0LjAuMg0K
PiA+Pj4+ICAgICBkcm0vYW1kL3BtOiBzdGFnZSBvZCByZXNldCBmb3Igc211IDE1LjAuOA0KPiA+
Pj4+ICAgICBkcm0vYW1kL3BtOiBzdGFnZSBvZCByZXNldCBmb3Igc211IHZlZ2EyMA0KPiA+Pj4+
DQo+ID4+Pj4gICAgLi4uL2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5j
IHwgNzUNCj4gPj4gKysrKysrKysrKysrKystLQ0KPiA+Pj4+ICAgIC4uLi9hbWQvcG0vc3dzbXUv
c211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMgICB8ICAyICstDQo+ID4+Pj4gICAgLi4uL2RybS9h
bWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jICAgIHwgMTUgKy0tLQ0KPiA+Pj4+ICAg
IC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jICB8ICAyICstDQo+
ID4+Pj4gICAgLi4uL2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzZfcHB0LmMgIHwg
ODUNCj4gPj4+PiArKysrKysrKysrLS0tLS0tLS0tDQo+ID4+Pj4gICAgLi4uL2RybS9hbWQvcG0v
c3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMgIHwgIDIgKy0NCj4gPj4+PiAgICAuLi4vZHJt
L2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYyAgfCAgMiArLQ0KPiA+Pj4+ICAg
IC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTE1L3NtdV92MTVfMF84X3BwdC5jICB8IDUwICsrKysr
Ky0tLS0tDQo+ID4+Pj4gICAgOCBmaWxlcyBjaGFuZ2VkLCAxNDUgaW5zZXJ0aW9ucygrKSwgODgg
ZGVsZXRpb25zKC0pDQo+ID4+Pj4NCj4gPj4+PiAtLQ0KPiA+Pj4+IDIuNTUuMA0KPiA+Pj4+DQo+
ID4+Pg0KPiA+DQoNCg==
