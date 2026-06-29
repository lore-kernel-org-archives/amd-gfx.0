Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53B7C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 02:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4393B10E0AE;
	Mon, 29 Jun 2026 02:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IthrDzuE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B96210E0AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 02:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCMhKv/aVhKqvSzl078SqT+cdE+yfxeA9nX04uY1BdXDgG93YPz/8L4B64KZKtE3bFM3MNETx3YkKjMgb1Z1bhG0Uqsg8F+kZlTJVietI6NyL/InyByq/q0wy2Ys1y8+0xbDF8txaKgAT+8CAXYJFG+7nuHJrm1gvb9KBg6IJY8Q6PT6f7rM6tJgIt9vsGLDtDokB4vnqpbjhXctQ1O5zu5V1Oyj5I2YLkuctDibH+xJerm/KnisOsllxtR/9z9taLdYE/2JX/2Pox7n/G2sZIlBhzx6e2F+qPOc/20hyKwLDL2MMywG27iehvL7uO8HSA+DErW9xPCNE8AAr9X6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrbXMczhFv/DoYiqRJySLXeLwte2OhvPWF6nPZ/0XLY=;
 b=YpP3v0iPCbkw658xDkxb+ryNh0CzTRpf7k9/ZvosbZQ08DtPVk9vSAw4s4rtoI/CpQlTKbVOJr2YrqK+y+clJUfts1t0ZG5VICuMPHGGZanenLUCCML8O0MzOmsSHiIc35LC9b4TQjEzw2/4hlI3iZuWX6nJqJvusUiBI+9D3nt+2WqNMuFCbL3bVmf9QY9GXq4mH6BjqTZTG7Kpm5wIBVRiWSbmIsAFmylshsoLa3uznB0HmFbgW/R90NhPWGb8Rc41fErXMHSbj4vMHFA3F09Yml6J5plHw5e6+iF/VPgWSMlUj3RmHcunJUyhga4JfBwq0317pJIMJ4Hb+B2oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrbXMczhFv/DoYiqRJySLXeLwte2OhvPWF6nPZ/0XLY=;
 b=IthrDzuEzXNKXRD34u5NwLg4pIk+hwhHVdZq0I5ltuArBGHkISdW315hoZizK4jPXa9+9nyB36Y8MmMiPxTw/hpoDwoL5mIRU/0bFL9YkleHnq1xPoW56OkMMNW6U5InrMKj7RzxIlX9ARJETD7Ds/H4n4zQtNxMf2fj4JdfnAY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Mon, 29 Jun 2026 02:14:14 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:14:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
Thread-Topic: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
Thread-Index: AQHdBFCQRvUOZooLKk6kWA0Wnm99ALZPFVmAgAD5O4CABL+SEA==
Date: Mon, 29 Jun 2026 02:14:14 +0000
Message-ID: <DS7PR12MB6005F6B7AE5E6B5998B29F8BFBE82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260625031252.298647-1-Prike.Liang@amd.com>
 <20260625031252.298647-2-Prike.Liang@amd.com>
 <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
 <DS7PR12MB60051BBD4AAF99711CCD899FFBEB2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60051BBD4AAF99711CCD899FFBEB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Shaoyun.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-26T01:32:19.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY8PR12MB7147:EE_
x-ms-office365-filtering-correlation-id: 017cacfb-2962-4734-222b-08ded5841dc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: dzSb6ypxg91KHB11nfn9+/kZLCVNdxPj+SzgBHXL46+qwRO1d3UYIltmibbCKX8WpQNegi7MJZ2YlNbtWjlGW/K86urubaLbiscLgh+xbGGObYAZ8p+cg129+D+vfHA7iHx3Eeb5DL+yyi8UgQKgs4j6wAoRIJDNDQ5H9A01kFMVtL9EhGen/tD5neBRoGlOEFFPV/7yewxKEFSbPDeR19ga5BiVJj/baYMWWgsblolODMcvstRNuVoXGCxx/321HYeq7WE9ra5IG3cRwoRepV9dibFzPyvdZ5frgXEo1chBiIBx/WLYHU9TLTwBmUmYhr00RBPcDHftmt5pd/bf34xJDKOkBjKvwLK/hOyZ5EJBwlMjQ/mM3LEb5P8VtsNjUE92MYqGrY3sY7ofY/GruzDz1tknwE/NQ45nh8gYr6tDHYX6/V2kktF2s1hCO+FL2vk8FlxDxiYNRmrtB0S8XvEXObgt4+A6RhegLCCcQkF9u2mMm+I6eWHbJVauQxZWU60DBY2Ik8yBYJ9lTxWaj5y2XGTwiBNzg6U0GqWwm6XyC5gdE3J1inmAaM0UKbhV+gj1V95bAbbu7AYq7WiCoMTJSSKRiI4lmc9eWM5ZPVrAQhB0cLHJXEYqJeNJ1SMFNN0DfCDxsyXTmMp3vFDMSkwCJRtuFeQUpwyEkhCq6T06+FWH9K11e5U7cWzmE5jBF3ytEwk9AxE9wflZKPaEWAUUVrmvDgzw9dKBqqIJs+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lPM3hwOHQxWXowNEZQNElTbDRodEwwNGxya05RZDlRR2M0MldsK0N1S3lQ?=
 =?utf-8?B?TXI4TTRkRzh4YmFmWElLWGMzZDBoWWp0LytaZDE1MmtTcWZxNGMrOFo5MG1Z?=
 =?utf-8?B?YXRMNU5RMjJXVXZQemtUSjFtT0NNQVVSZTBoNm5iZGxwMmJPT1pDY0YwMzBK?=
 =?utf-8?B?YnBvVWgyU205SnZOZDBkaHA5RnlyanliNU9Pc1hadlArQ2ZuZmwyRWdIbXFw?=
 =?utf-8?B?VFNQNUp2YStlZ3gzdzZRc2Via1BNRWxqYWhwTTF1U1dCd0pYU2E5YllrbXpV?=
 =?utf-8?B?blBxa2xMRDhQVDgwWnVGVFAxYk1wYjdTSXdKK2Y2R3VGeXU5M1AycWRBRGFm?=
 =?utf-8?B?ejd4VlIza3d0UStaci9jVEhYazhuWW1Oem12SEp2dXpLZlR5RzVGZ1luZGdC?=
 =?utf-8?B?MitZdTNsNWhMQ2FkRkN5VVBpNFlrQ3k5TXMxQlBqQnhtUUVIMHFDNW5pclEr?=
 =?utf-8?B?bTFJaVpWOGZ6VE1qS1ZCekpWRk5VQmxmUUFwTVcrZTlXTXVHUTZMVXUvUGU5?=
 =?utf-8?B?SDBZQVZVcUpXbHUvRDlKS002V1VpdkhoL2Y1S1lKWGVRM0daYktmanFiN2F2?=
 =?utf-8?B?THVHWEd3Skc1eE5RdE50SElvYzVDbmczbWk0UHMzaVo5WlBrelNoblZHSmht?=
 =?utf-8?B?cHgwS3Z6WEU3Qm9uY2w3aHB1MUpsWHlpRmp4RHFmRGFRVUFGUlVLT0RveDk0?=
 =?utf-8?B?cUgyb203MGw3M3FEa1hiTlRKRDRicVdXVjIxTU5VOXFnVHg1SDJWeTY2Z2x6?=
 =?utf-8?B?K0FnOTBSMjhlcFFiL1pjRFhaZVRHaEZhQUJnbHBUcXNycmJzckJWZmxlMUJC?=
 =?utf-8?B?dU8vMmJJajUxRGZPaUtpcjYxWHkyVWVPd0FqcjBsbXlSckVpSnlmL2h6YUdi?=
 =?utf-8?B?KzdHQXY0MmhGTlBUNkYrcW9LTUFrNjZKbWtqNkxqUFhGTWpzTzlPMFE3azQv?=
 =?utf-8?B?UGVUNXF6TnhuQ3pvUHNibG83dE1aR3BBZmxTczlBVmc4QWFWNXBySitxemI1?=
 =?utf-8?B?Rnpla214MDdlQU5DNytUakhDR1FDbTJYY3hUTjJ3eVJqc0Jpc0Q4YzFnNUN1?=
 =?utf-8?B?Y3cvVzFYU0V5N3RZTEsvVURYck9sY3JTb1ZRNHJreHg0WjNtaXJtam02eVZE?=
 =?utf-8?B?d0RRSkhKWHhGWU1pdlIzcFdsUUU0ZEV5RkRrSDFzSi9qTmdPQm9PRXhDRVNU?=
 =?utf-8?B?R0lMU3JWbkUwdk53U0U4WU0vbFA2YWNXeThxd1BJQVU1Z2x3NjA0YW85aWJF?=
 =?utf-8?B?b2I4TEF1dHRnNll3RExqemw5WG5lOENXa0loNElqRzZTL3BlZlNkWXlOWElv?=
 =?utf-8?B?TXZIM0lzWlNWMXEzV0Y4ZEw3ZGJReDVvMWlzUlQwYUozYlpmbGNGTUxFZkpO?=
 =?utf-8?B?ZmRzOWVPSjZrSmhQNXdISWxuTHQvNXYwVUJhS1FHMm9UZkJ2RjBqZ2JhYkI4?=
 =?utf-8?B?dytJNElUQWtVRDlqaS9jSWlGc0lIOEFXeVlPdDMzODRZUXErM2hZMDQzaFQ5?=
 =?utf-8?B?Wk5BaUJIWGVESzdiaFBrL1lsVnFtTkZ5ZjE4d3M3bnNsclMrWFZOOHlhZXUr?=
 =?utf-8?B?Wk84S0M4N1JaL0ZYSU4veDBYRkhoMXhqWklHL0t3bFJLV0xnM3gyUTZRS201?=
 =?utf-8?B?Y1U3VWhobXdEdzdPQ0hNSHR2dTgrSGh2N2hSOUZ1MUh4TEhOcDZnYUJMYUFr?=
 =?utf-8?B?a21nR2FsZ2luTEwvYWp6M3RlR29IcHc1NmJUaklZYzJOeVFKdlkydnc5YUIv?=
 =?utf-8?B?ejB4WTdxdlJ2RGtBMnRpNmxOcGwwbmFyNVVxWUlNeUJxQTNEK2paSTd4YUpF?=
 =?utf-8?B?aVFMTlgrbmVzWUpkUlRLV0ZjQ2xBakdPVzdvdi9tbXlzazZHdFRudUpRZUZm?=
 =?utf-8?B?THVsMFJjZVB6UjFRc2NzZGVuV2FWdmNLWGVuYTRZemJhdVZYSERER3BCaEFn?=
 =?utf-8?B?WGtZR3RPQklQQkxBeng1RGhOQkNRT1ozdklhaUJvSVMyWjNpQWFOUTFIRmc0?=
 =?utf-8?B?TmZqN0ZUcXhHdFJ3NjNFaXh3RTRJL2NrTGtCZ0JZS05NQWJLZVB2Rm5Yb05M?=
 =?utf-8?B?eWxjTFNIYnFnSkFTczhKbGlzTnJoSnhHQXZudUdEQWVQQjhvNkJWSUNRajI0?=
 =?utf-8?B?NG1lb1Q4Z0RXNFV6ZjVrRUNMS2kzQTJuM3VpOGg3MlZERWVPTUJUL1BxcGZ0?=
 =?utf-8?B?cnAydVNiSnhjZktHQkpQNk9oL0ZhcWhsL1ZlSHNwU0NWYWpYenNyT2FHRnFu?=
 =?utf-8?B?Mk5qS0NNMysyVFBuQll6SGQxcmV6WUEwN0l6Tjh0Ym0wcTVjRVE2M05JdjVo?=
 =?utf-8?Q?B47ECUtuEhdqpqkY0l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017cacfb-2962-4734-222b-08ded5841dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 02:14:14.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qnmyqXn04I0yhpyYxEfDsUTotEqpAzcBmUn+gkL51W1K/+UIq9uT1eebw7zd9A2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

UHVibGljDQoNCkhpIEBMaXUsIFNoYW95dW4NCg0KQ291bGQgeW91IGNvbmZpcm0gd2hldGhlciB0
aGUgZG9vcmJlbGxfb2Zmc2V0IGZpZWxkIHNob3VsZCBiZSBpbmNsdWRlZA0KaW4gdGhlIE1FUzEx
IGRyaXZlcidzIFNVU1BFTkQgaW5wdXQgZm9yIHVzZXJxIHByZWVtcHRpb24sIHRvIGFsaWduDQp3
aXRoIHRoZSBNRVMgRlcgc3RydWN0dXJlIGRlZmluaXRpb24/IFNpbmNlIHRoaXMgZmllbGQgaXMg
bm90IGRpcmVjdGx5DQpjb25zdW1lZCBieSBNRVMgZmlybXdhcmUgZHVyaW5nIHN1c3BlbmQsIG9t
aXR0aW5nIGl0IHNob3VsZCBiZQ0KaGFybWxlc3MuIEhvd2V2ZXIsIGtlZXBpbmcgaXQgbWFpbnRh
aW5zIGEgY29uc2lzdGVudCBzdHJ1Y3R1cmUNCmRlZmluaXRpb24gYmV0d2VlbiB0aGUgZHJpdmVy
IGFuZCBmaXJtd2FyZSwgd2hpY2ggaXMgdGhlIGludGVudCBvZg0KdGhpcyBjaGFuZ2UuICBPciB3
ZSBtaWdodCBuZWVkIHRvIHJlbW92ZSBkb29yYmVsbCBmaWxlZCBpbiB0aGUgTUVTDQpmaXJtd2Fy
ZSBpbiB0aGUgZnV0dXJlLg0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGlhbmcsIFByaWtlDQo+IFNlbnQ6IEZyaWRh
eSwgSnVuZSAyNiwgMjAyNiAxMjowMCBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaXUsIFNo
YW95dW4NCj4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8z
XSBkcm0vYW1kZ3B1L21lczExOiBzZXQgZG9vcmJlbGwgb2Zmc2V0IGZvciBzdXNwZW5kaW5nDQo+
IHVzZXJxDQo+DQo+IFB1YmxpYw0KPg0KPiBSZWdhcmRzLA0KPiAgICAgICBQcmlrZQ0KPg0KPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyNSwg
MjAyNiA2OjQwIFBNDQo+ID4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgU2hhb3l1bg0KPiA+IDxTaGFveXVu
LkxpdUBhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBkcm0vYW1kZ3B1L21l
czExOiBzZXQgZG9vcmJlbGwgb2Zmc2V0IGZvcg0KPiA+IHN1c3BlbmRpbmcgdXNlcnENCj4gPg0K
PiA+DQo+ID4NCj4gPiBPbiA2LzI1LzI2IDA1OjEyLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiA+
IFVwZGF0aW5nIHRoZSB1bmlvbiBNRVNBUElfX1NVU1BFTkQgYW5kIHVuaW9uIE1FU0FQSV9fUkVT
VU1FIHRvDQo+IGFkZA0KPiA+IHRoZQ0KPiA+ID4gZG9vcmJlbGwgb2Zmc2V0IGZvciBzdXNwZW5k
aW5nIHVzZXJxLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbWVzX3YxMV8wLmMgICAgICAgIHwgMiArKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaCB8IDIgKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdjExXzAuYw0KPiA+ID4gaW5kZXggOWUyN2QwMWNiZmEzLi5hYjBkZTZkMDRm
ZjggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEx
XzAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMN
Cj4gPiA+IEBAIC03ODMsNiArNzgzLDcgQEAgc3RhdGljIGludCBtZXNfdjExXzBfc3VzcGVuZF9n
YW5nKHN0cnVjdA0KPiA+ID4gYW1kZ3B1X21lcw0KPiA+ICptZXMsDQo+ID4gPiAgICAgbWVzX3N1
c3BlbmRfZ2FuZ19wa3QuZ2FuZ19jb250ZXh0X2FkZHIgPSBpbnB1dC0+Z2FuZ19jb250ZXh0X2Fk
ZHI7DQo+ID4gPiAgICAgbWVzX3N1c3BlbmRfZ2FuZ19wa3Quc3VzcGVuZF9mZW5jZV9hZGRyID0g
aW5wdXQtDQo+ID4gPnN1c3BlbmRfZmVuY2VfYWRkcjsNCj4gPiA+ICAgICBtZXNfc3VzcGVuZF9n
YW5nX3BrdC5zdXNwZW5kX2ZlbmNlX3ZhbHVlID0NCj4gPiA+IGlucHV0LT5zdXNwZW5kX2ZlbmNl
X3ZhbHVlOw0KPiA+ID4gKyAgIG1lc19zdXNwZW5kX2dhbmdfcGt0LmRvb3JiZWxsX29mZnNldCA9
IGlucHV0LT5kb29yYmVsbF9vZmZzZXQ7DQo+ID4gPg0KPiA+ID4gICAgIHJldHVybiBtZXNfdjEx
XzBfc3VibWl0X3BrdF9hbmRfcG9sbF9jb21wbGV0aW9uKG1lcywNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgJm1lc19zdXNwZW5kX2dhbmdfcGt0LA0KPiA+ID4gc2l6ZW9mKG1lc19zdXNwZW5k
X2dhbmdfcGt0KSwNCj4gPiBAQCAtODAyLDYNCj4gPiA+ICs4MDMsNyBAQCBzdGF0aWMgaW50IG1l
c192MTFfMF9yZXN1bWVfZ2FuZyhzdHJ1Y3QgYW1kZ3B1X21lcyAqbWVzLA0KPiA+ID4NCj4gPiA+
ICAgICBtZXNfcmVzdW1lX2dhbmdfcGt0LnJlc3VtZV9hbGxfZ2FuZ3MgPSBpbnB1dC0+cmVzdW1l
X2FsbF9nYW5nczsNCj4gPiA+ICAgICBtZXNfcmVzdW1lX2dhbmdfcGt0LmdhbmdfY29udGV4dF9h
ZGRyID0NCj4gPiA+IGlucHV0LT5nYW5nX2NvbnRleHRfYWRkcjsNCj4gPiA+ICsgICBtZXNfcmVz
dW1lX2dhbmdfcGt0LmRvb3JiZWxsX29mZnNldCA9IGlucHV0LT5kb29yYmVsbF9vZmZzZXQ7DQo+
ID4gPg0KPiA+ID4gICAgIHJldHVybiBtZXNfdjExXzBfc3VibWl0X3BrdF9hbmRfcG9sbF9jb21w
bGV0aW9uKG1lcywNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgJm1lc19yZXN1bWVfZ2FuZ19w
a3QsDQo+ID4gPiBzaXplb2YobWVzX3Jlc3VtZV9nYW5nX3BrdCksIGRpZmYNCj4gPiAtLWdpdA0K
PiA+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4g
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTFfYXBpX2RlZi5oDQo+ID4g
PiBpbmRleCA2NjQ0ZmFiZWIwYjcuLmIwNjQxMmFjODU4MyAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaA0KPiA+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTFfYXBpX2RlZi5oDQo+ID4gPiBAQCAt
NDI4LDYgKzQyOCw3IEBAIHVuaW9uIE1FU0FQSV9fU1VTUEVORCB7DQo+ID4gPiAgICAgICAgICAg
ICB1aW50MzJfdCAgICAgICAgICAgICAgICBzdXNwZW5kX2ZlbmNlX3ZhbHVlOw0KPiA+ID4NCj4g
PiA+ICAgICAgICAgICAgIHN0cnVjdCBNRVNfQVBJX1NUQVRVUyAgIGFwaV9zdGF0dXM7DQo+ID4g
PiArICAgICAgICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICBkb29yYmVsbF9vZmZzZXQ7DQo+
ID4gPiAgICAgfTsNCj4gPiA+DQo+ID4gPiAgICAgdWludDMyX3QgICAgICAgIG1heF9kd29yZHNf
aW5fYXBpW0FQSV9GUkFNRV9TSVpFX0lOX0RXT1JEU107DQo+ID4gPiBAQCAtNDQ1LDYgKzQ0Niw3
IEBAIHVuaW9uIE1FU0FQSV9fUkVTVU1FIHsNCj4gPiA+ICAgICAgICAgICAgIHVpbnQ2NF90ICAg
ICAgICAgICAgICAgIGdhbmdfY29udGV4dF9hZGRyOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAg
IHN0cnVjdCBNRVNfQVBJX1NUQVRVUyAgIGFwaV9zdGF0dXM7DQo+ID4gPiArICAgICAgICAgICB1
aW50MzJfdCAgICAgICAgICAgICAgICBkb29yYmVsbF9vZmZzZXQ7DQo+ID4NCj4gPiBJcyB0aGlz
IGJhY2t3YXJkIGNvbXBhdGlibGU/DQo+ID4NCj4gPiBLZWVwIGluIG1pbmQgdGhhdCB3ZSBjYW4n
dCBicmVhayB0aGUgRlcgaW50ZXJmYWNlLg0KPg0KPg0KPiBUaGlzIHBhdGNoIGFsaWducyB0aGUg
TUVTQVBJX19TVVNQRU5EL1JFU1VNRSBzdHJ1Y3R1cmUgZGVmaW5pdGlvbiB3aXRoIHRoZQ0KPiBN
RVMgZmlybXdhcmUuIEluIE1FUzExLCB0aGUgZG9vcmJlbGxfb2Zmc2V0IGZpZWxkIGlzIGFsc28g
aW5jbHVkZWQgaW4gdGhlDQo+IFNVU1BFTkQvUkVTVU1FIHN0cnVjdHVyZXMuIEhvd2V2ZXIsIHRo
ZSBkcml2ZXItcHJvdmlkZWQgZG9vcmJlbGxfb2Zmc2V0IGlzIG5vdA0KPiBkaXJlY3RseSB1c2Vk
IGJ5IE1FUyBGVzsgdGhpcyBmaWVsZCBtYXkgYmUgcmVtb3ZlZCBpbiBhIGZ1dHVyZSByZXZpc2lv
bi4NCj4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQ2hyaXN0aWFuLg0KPiA+DQo+ID4gPiAgICAg
fTsNCj4gPiA+DQo+ID4gPiAgICAgdWludDMyX3QgICAgICAgIG1heF9kd29yZHNfaW5fYXBpW0FQ
SV9GUkFNRV9TSVpFX0lOX0RXT1JEU107DQoNCg==
