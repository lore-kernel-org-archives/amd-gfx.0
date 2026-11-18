Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB206606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w5//aPJJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7614610EC1B;
	Wed, 18 Nov 2026 13:54:02 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DCC10EC1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 13:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIRJXwZ7F5ZRbDbafSrYGlIeE33LipQgpCEZ2ZauBEhSVHjeM6Zia+2OzoeKkMlxX59zFiDbttcbjSk0M0GLaDBue/YKKRJK6TBDR+o6Guc7lGKilLRE57U9AjzPwizr/iWQlE5Fq01aSE/ByUOj0MzJ8DZwIUduIwHekMsxcDNyb40e/ZfJENTGpdsTaxQJ+sOXsNiSyxcAtI77bOsCLTrazU2L87KLFLHjgHaXzud/zU27ONME5BKks/ytEPYR943bTqdCavR0X7g07XFYVM/Z4wRprSgXSNRrIYELkdzcRG8e37EdY7GKz8GPb05f1E/AA+Va6I9dVwZgNmb5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix6VXiaCcuPXscfqdQgZzF/w/PkRFVWSPF/Tiuio8D4=;
 b=jx/LpOLMOxthyCunzQKxFdP/kNTRonIbH4DRe7CmqITlhM05+QyPP6XI64bB2fb0slI0kz/9Ki+wsPvkGu3ik6IaFdqW3l9ROip3pk6Nu/GXf85812Apg42qGBSQMsVtgnnRVlXxxkmPC/FU+9ZFVCO0SiepIY6E1nj6KWEnuIpKqY+HtSDTuL6NpTNwgkiQfZKK8N/l9yhYbEuJYbDPu9q5uIeluiCxcVJZUVyH7+owzPtDRPUzi2wHcu7xhLJ4tY+QNkFYNnvKcy8uPFllekQGd2BX2CYFdnl08YVkcOnrC9/g6KHVg4M2tpz96CGPwGwZ+YGW0FKXF2GHrFAuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix6VXiaCcuPXscfqdQgZzF/w/PkRFVWSPF/Tiuio8D4=;
 b=w5//aPJJvg8CuYLKlUIVKdHWJPUTo2+o0L9adAj9uq4IqQhaZKIOmdEnRLIyUKwOkQxR5Ywf9ZXZ7j9Sw43YhT8eQ92hf8QWzr4DadhyL71TKaR7YqmXtfX38/lBc3jJ6+m3YXHlFxPQbOf20brWSSSmHrp6GfrXzzC+L5cHXXA=
Received: from DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:51:47 +0000
Received: from DM4PR12MB7719.namprd12.prod.outlook.com
 ([fe80::6be3:f1a7:5d85:cc4d]) by DM4PR12MB7719.namprd12.prod.outlook.com
 ([fe80::6be3:f1a7:5d85:cc4d%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:51:47 +0000
From: "Guttula, Suresh" <Suresh.Guttula@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Thread-Topic: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Thread-Index: AQHdd2AZocFgjCaXP0SfgJ1IZx2am7cz1wGAgAABTwA=
Date: Wed, 18 Nov 2026 13:51:46 +0000
Message-ID: <DM4PR12MB7719CCEBF0DDECF8CE99D732937A2@DM4PR12MB7719.namprd12.prod.outlook.com>
References: <20261118132348.4101528-1-suresh.guttula@amd.com>
 <b7863c55-dacc-4519-97e8-a9cc6b07ffea@amd.com>
In-Reply-To: <b7863c55-dacc-4519-97e8-a9cc6b07ffea@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-18T13:48:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7719:EE_|MW3PR12MB4427:EE_
x-ms-office365-filtering-correlation-id: be69c1c0-6638-42ae-83d4-08df457b1674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261021123027099003|38070700021|261022075727099003|4143699003|11063799006|56012099006|10067099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: DW3hPkKXgtN+WO18wINkz1NRm7OBY7YsDP00myrMKvjbTvTTkptBDKvlKGH0INEyNhZoIeQOtKPlOVbITtDTGKyxKP6IuhJqUbh/EJaAyunijmyliTLO3sL1k5GB5n2n2vJO3kkQp/vdUMaA72YgkD1SGWPaaiav5srf79qG5UvCX56U8PBxO6nPhRYs3EVY0MAS4l0BsL9GkBmxz6+8qnZCUSW3i4ARPaDFcec7YdCZfmLf1ItlDrdsM+DH8rpATyLgtemLPzz5sQTgSLfcEyuYnfrxUXkQzm65MqrSSF5CAfLqPLUNkRpgESd4UATAxMOJB5aiFCPnXcC3UuM8XaM+Vh0kH8J6pBJ3UtwyU1rnvbXA+NFVbXuC6MN1GFOAakrVzptszP5fdv42bt0RptYF3LoQ6Ezq2HyJkH7fmOZ+fOz8CPrnEMmPp6BLegDU//ZNmffD0DA4weK7do/0pxlOQZ/foAnt+gbnBEea5X7tyjmq6X8JQ76b5XPYdR8TGaFhhUa7CFFiKtu9VwNgIu4/IJhkWKSQ8jBBvWNHDF5WflvprVvbPEL9yFXObZ8m52BKihtbChD/GySFzh71dvrmXqLnHiBKf6JCJExOuSU5d7La2D3zo4K0FqsYhZNvGjZUhQLnf3Ty+N3dPoDw9GktGu7NFG/bDqnmV5glCUJ4X7txn2W0pz1MtrwdrrqYecDV+l2d1x7p7QtgdRHP0ppYIR9rSGBc2zuheYxePm4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB7719.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021123027099003)(38070700021)(261022075727099003)(4143699003)(11063799006)(56012099006)(10067099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ZTdm5CVkl1Nkp3bEFDNjNZcStSTEhFLzhsc3ZNSElVSTVkNFNEUDRWa0xk?=
 =?utf-8?B?Y1JRNWhVd3BZR1pJNW4yek1taXVUVCtUL2lNSXlzY0R3ZDlUNEFvN3IzZER5?=
 =?utf-8?B?UUdkOXc1YTg2TkV6YkZKRUZQcFdRN05VU245b0xELzFtc3JJdFpFU0MvUG9J?=
 =?utf-8?B?WGNjYTY1OEZIV2FMUDBzTVhKd2lZYk5BaGhBTTlZYWhYdjZaQkhkY1ZlNjFm?=
 =?utf-8?B?dy80MFE0UCs3RXJZTUtTMWg3b3R1cWFCZmJVcWNNL0owaEg1ZWdUMVpqclM0?=
 =?utf-8?B?S09LSjZLS3dPUGtlODB1UVFBV3M4SDMxWUQra0Z2cXNtdlNXL1hVTmhBQm1a?=
 =?utf-8?B?OW5pbC9YSENLcXNVTmRESFdqMjk4NFlhYmVKUFk1UWFUQ3plZENzK0w2V1dk?=
 =?utf-8?B?bDZndFBqb3RKSXg5TXJ2TWJyR2FRRW9jVVpFZlNLdXVvNHJ5K01CNWZxRTBE?=
 =?utf-8?B?NDBzVXc5K0NlUG9OWW1aYVN6WldISjRkaHRTRUJMT2czMFFlUVVZaVRnWmRG?=
 =?utf-8?B?cnhUREZrcXhGVjZ3UkxOZ0pwejE4WG9VZFFDS3JMcHJsQm41OEpySFcrdFBk?=
 =?utf-8?B?bFlBRE45Unc0bnJoOVFLUUNLUzhOZ1F3WVU2YVFscCtsanoxK3RXZ2tiV1Q4?=
 =?utf-8?B?U3JGb05yUEpGZGtmNXVDVlVqVGw4V0pEU1Q1U0hZSUpjOXloSXlXYllIa0Z4?=
 =?utf-8?B?dDZCRCsrdC9zUndwd2FxblFYZVd5RDdydGRrc1ZWT3RtMUZsTVRLRVBCT201?=
 =?utf-8?B?U3VwTGVoTDhtZFBnVHNLd3EvOEE1c21mbHAvenNVd0gzVHBDZEx1Um52cG93?=
 =?utf-8?B?U1Bmek55Y2ljRlhqSmU4NVZVYnZpMk8xUXhVazRQTEhveko2KytQRFJCYkdp?=
 =?utf-8?B?MmZXMDdrK0h1YXRVUE1HWmxISEFRM2tiSFNGVkJkc1dIMkVSdFdZV2doYkZy?=
 =?utf-8?B?SVNLalRNS1pwRytUM3JPeEV4SVBpUURjeTBFR2dyWXhsUk5kUnF0elVOWTll?=
 =?utf-8?B?VTVGK3JBamlURGRSdXVIS1hWNXRPLzNpVjl5R0txbThReU52NWN4Z3AzNWRz?=
 =?utf-8?B?UGk5bDVFTVdqcVBnb3hGTlV4UE5rQWxvV2ovSC9FcUxIYkRmMkp0TFZNR3hp?=
 =?utf-8?B?S1FEWVZXSXdSeHNUbkJBL1dhWWdiSUJhZ1dXNXRIMlhPZjJibktvbFd6ZWlW?=
 =?utf-8?B?NmJ1N25iMTdxZHdZd1hidnhKdk9GMVFROE1GeEtXNmJtT0xLYy9PNjZNTzl1?=
 =?utf-8?B?YWZQeWoxNW1Tb3VjcXd6RGp1Z0xqYXUvSmI2Sy9tWGdub3hQc250WUYvczMx?=
 =?utf-8?B?L2p3SGNPckVrUUIzMVN0R3Y1YSt4a2VBN0dxOG1GQVpJelZHZ1d2V00yRktz?=
 =?utf-8?B?N2Joa1NRcWNwL0JmRmxQZU9PYkxpcTJ3TFFZZ0d4Q011cjMvSDBzblJWUzBC?=
 =?utf-8?B?TktiRVVQajF6WjBpZy93OVd0WW5HVFFxczA5MHZLc0JRS3dLYlR2bzhBZEpW?=
 =?utf-8?B?K3loVFc4dW1rWEZWbXpuRS8wTW1BT0ZWNUxyYkNTSFg0TXA1OTF3MSszbmRE?=
 =?utf-8?B?UkNtbDBsdXhCLzk4NkRvaWZnZXYrOVR3R3pFekhkVXNXR2ZJTHZPMVNQbjhn?=
 =?utf-8?B?L3YyRE9LRk52UHVKb0x1NWdvWTBWTjkzVThoTG9PMFVmZC9laEVHbCtlRGRw?=
 =?utf-8?B?dStQNStDN01Uc1ByUTlRWVNHYlMrYUg4UjdRV0llUmVONjQwc1FvNXdsVGx4?=
 =?utf-8?B?RVdMRDBjTEhSc1hGZjVvOVFSV0d6eUZVWTZKdGxHRmpDWFNDOXFlNmdudFdO?=
 =?utf-8?B?Q3VSNXR2dytCSFR3WHd3UW10azl0Z1FlWWJsQ3RMY2NhTXkwTzlWaTVCWCtE?=
 =?utf-8?B?MWViaDYwZDVRbXFEZ2pRUmIvcDZDZmVQdGR2bHVEMzZoSDE2VjExblMrZHJ2?=
 =?utf-8?B?WHVobVVOejBmb1luZUtqdEpRVDkwc3FKS0R3SkgyUHVGYTJoOWhWdXIwbWpK?=
 =?utf-8?B?MlEzanN2SVhHY0kyQ25pWmliU1gzVnh0Z29jVTJjSG5wQnZyQlVkZ3hEZXV0?=
 =?utf-8?B?ekppd1duNWQ1NTAra3oxdXpKVTgxKzNFZ21HUW5kSUR5TU41K0tiWkR2MHg5?=
 =?utf-8?B?WkJsRUE0dUYrSXIrcmVzcDByV3o2dEY0djc4dHBTTy9LUC9uVTJJTTd5OFpQ?=
 =?utf-8?B?YnpHSmp3eVpJaG1ZSFJCZTJuaUpNL29vaVlSRWxPcEcrRHdVS1hBRGdDaWhu?=
 =?utf-8?B?dXk0TjB3b0picnRmR3BBaDhYOGZrWTRQQ2szck42NFNMU1diUk5lVm1IMEpK?=
 =?utf-8?Q?5FTPwHY5tWywOSmSKz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be69c1c0-6638-42ae-83d4-08df457b1674
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 13:51:46.9577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3OkxUHCv3MqrnUxpSMdlamQRRwgNviKJlfP6nFEsz2rEQvrbPxX0tgnALKXs4V58AY4eTKV+UbuY89xVKFm3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiAxOCBOb3ZlbWJlciAyMDI2IDE5OjE0DQpU
bzogR3V0dHVsYSwgU3VyZXNoIDxTdXJlc2guR3V0dHVsYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBFbmFibGUgSU1V
X0kvRFJBTSBGV19MT0FEIENNRA0KDQoNCg0KT24gMTgtTm92LTI2IDY6NTMgUE0sIFN1cmVzaCBH
dXR0dWxhIHdyb3RlOg0KPiBGb3IgR0MgMTEsIEV2ZW50aG91Z2ggSU1VIHVjb2RlIGxvYWQgZnJv
bSBCSU9TL0lGV0ksIFBTUCBleGVwY3QgTG9hZA0KPiBjb21tYW5kIGZyb20gR0ZYIHRvIGxvYWQg
SU1VIHVjb2RlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTdXJlc2ggR3V0dHVsYSA8c3VyZXNoLmd1
dHR1bGFAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIHwgIDkgKysrKysrKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
aW11X3YxMV8wLmMgIHwgMTQgKysrKysrKysrKysrKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gaW5kZXggN2E4Y2MwNDNkZjVlLi45ZDZjMTkyZGIzNDgg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gQEAgLTQw
OTEsOCArNDA5MSwxMyBAQCBzdGF0aWMgaW50IHBzcF9sb2FkX25vbl9wc3BfZncoc3RydWN0IHBz
cF9jb250ZXh0ICpwc3ApDQo+ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gICAg
ICAgICAgICAgICB9DQo+DQo+IC0gICAgICAgICAgICAgaWYgKGZ3X2xvYWRfc2tpcF9jaGVjayhw
c3AsIHVjb2RlKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiArICAgICAg
ICAgICAgIGlmIChmd19sb2FkX3NraXBfY2hlY2socHNwLCB1Y29kZSkpIHsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmICghdWNvZGUtPmZ3ICYmICh1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BV
X1VDT0RFX0lEX0lNVV9JIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgdWNvZGUtPnVj
b2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9JTVVfRCkpDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRldl9kYmcocHNwLT5hZGV2LT5kZXYsICJkb24ndCBza2lwIElNVSBmdyBsb2Fk
IVxuIik7DQo+ICsgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOw0KDQpLZWVwaW5nIHRoaXMgaW4gY29tbW9uIGNvZGUgY2F1
c2VzIHNpZGUgZWZmZWN0IG9uIG90aGVyIFNPQ3MuIEJldHRlciBhZGQgYSBjaGVjayBpbnNpZGUg
ZndfbG9hZF9za2lwX2NoZWNrKCkgc3VjaCB0aGF0IGl0IHJldHVybnMgZmFsc2UgZm9yIHRoZSBw
YXJ0aWN1bGFyIEdDIElQIHZlcnNpb24uDQoNClRoYW5rcywNCkxpam8NCg0KVGhpcyBpcyBzcGVj
aWZpYyB0byBBUFVzLCBMZXQgbWUgYWRkIEFQVSBjaGVjayBhbHNvLi4gTGlrZSBhZGRlZCBpbiBp
bXV2MTFfaW5pdF9taWNyb2NvZGUoKSwgdGhhdCB3aWxsIGRpZmZlcmVudGlhdGUuDQpUaGFua3Mu
DQoNCj4gKyAgICAgICAgICAgICB9DQo+DQo+ICAgICAgICAgICAgICAgaWYgKHBzcC0+YXV0b2xv
YWRfc3VwcG9ydGVkICYmDQo+ICAgICAgICAgICAgICAgICAgIChhbWRncHVfaXBfdmVyc2lvbihh
ZGV2LCBNUDBfSFdJUCwgMCkgPT0gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2ltdV92MTFfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3Yx
MV8wLmMNCj4gaW5kZXggYjZjNGFlMzVjYTAzLi4zYWVmNjhjOTg5MWEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ltdV92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2ltdV92MTFfMC5jDQo+IEBAIC0zMSw2ICszMSw4IEBADQo+ICAg
I2luY2x1ZGUgImdjL2djXzExXzBfMF9vZmZzZXQuaCINCj4gICAjaW5jbHVkZSAiZ2MvZ2NfMTFf
MF8wX3NoX21hc2suaCINCj4NCj4gKyNkZWZpbmUgSU1VX0RBVEFfU0laRV9CWVRFUyAgNjYzMDQN
Cj4gKw0KPiAgIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L2djXzExXzBfMF9pbXUuYmluIik7DQo+
ICAgTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2NfMTFfMF8wX2ltdV9raWNrZXIuYmluIik7DQo+
ICAgTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2NfMTFfMF8xX2ltdS5iaW4iKTsNCj4gQEAgLTcz
LDggKzc1LDE4IEBAIHN0YXRpYyBpbnQgaW11X3YxMV8wX2luaXRfbWljcm9jb2RlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgZXJyID0g
YW1kZ3B1X3Vjb2RlX3JlcXVlc3QoYWRldiwgJmFkZXYtPmdmeC5pbXVfZncsIHJlcXVpcmVkLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhbWRncHUvJXNfaW11
LmJpbiIsIHVjb2RlX3ByZWZpeCk7DQo+IC0gICAgIGlmIChlcnIgPT0gLUVOT0RFViAmJiBpbXVf
aW5faWZ3aSkNCj4gKyAgICAgaWYgKGVyciA9PSAtRU5PREVWICYmIGltdV9pbl9pZndpKSB7DQo+
ICsgICAgICAgICAgICAgaW5mbyA9ICZhZGV2LT5maXJtd2FyZS51Y29kZVtBTURHUFVfVUNPREVf
SURfSU1VX0ldOw0KPiArICAgICAgICAgICAgIGluZm8tPnVjb2RlX2lkID0gQU1ER1BVX1VDT0RF
X0lEX0lNVV9JOw0KPiArICAgICAgICAgICAgIGluZm8tPmZ3ID0gYWRldi0+Z2Z4LmltdV9mdzsN
Cj4gKyAgICAgICAgICAgICBpbmZvLT51Y29kZV9zaXplID0gSU1VX0RBVEFfU0laRV9CWVRFUzsN
Cj4gKw0KPiArICAgICAgICAgICAgIGluZm8gPSAmYWRldi0+ZmlybXdhcmUudWNvZGVbQU1ER1BV
X1VDT0RFX0lEX0lNVV9EXTsNCj4gKyAgICAgICAgICAgICBpbmZvLT51Y29kZV9pZCA9IEFNREdQ
VV9VQ09ERV9JRF9JTVVfRDsNCj4gKyAgICAgICAgICAgICBpbmZvLT5mdyA9IGFkZXYtPmdmeC5p
bXVfZnc7DQo+ICsgICAgICAgICAgICAgaW5mby0+dWNvZGVfc2l6ZSA9IElNVV9EQVRBX1NJWkVf
QllURVM7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgIH0NCj4gICAgICAgaWYg
KGVycikNCj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4NCg0K
