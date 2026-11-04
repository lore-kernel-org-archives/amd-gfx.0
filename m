Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59D606A32E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RWRfRO7A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA8B10E236;
	Wed,  4 Nov 2026 05:54:55 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0BF10E236
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 05:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYM5Ut3kKFEKzC8SJIJwJLpWgMX48EDy3eQTZt9bHrP+AuypnTDWbFRgyhOjBOL6fPxxfzF2oiFVXFq5UfWZ3QxVsgFE9Z7m9LIsu+O9LfG9VFNSu2rdXIhfFNbc+/wmL4lqbYARypCDyj3yRGWZ4jB03DpSM+eiMxSlATZzGgDqJX/GngIqadlD/iHlPSKUSxpCV9rcgzsPH33jNOBofjG2SRwmDgcCeGsUZ9/ZQA5Gq+fZNuS7FfSMZb6RwllPoj9ht/Qw0vkIIuQfW07PDbRnfqEOIKCNniFB9YWctvuj2RHgy3temBBQAzsOOUt5MoUTm4Y7vL6b2/AO5Y8Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7DAbjLLQLz20qYi7enjGx8QwVtFUb6fYzQW93y6H88=;
 b=r1vkYZEcX2ewPo0wi606McPsE2FvOFegZwuW+VbWeHcmitQRNrTWJeUYWcmvzQqOr0M5RauOljf0BrvROVowYF/QJ/iO4Au21JmyHpa1NUQkW04P9u/JIWG+Aqdv2VlBtd5JknY+9SQqRqSRXa9rgTT1QVNLCI7VS/93QMXuoVemPL11jrrMqEbJL30LQLkqWSIcDF4YzedkHO3eviViAf/4dbZFcivkGjx9LresHIKMc5/STgzoxsOybko25C/NSB6Yt2R07352+Z2FHqltHvGaUAnH+Pi9o3koZCa2pJx9wM+4Tk82wfAh3wf8LuHK8cyZLIbXcAHlc+sxLD3oqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7DAbjLLQLz20qYi7enjGx8QwVtFUb6fYzQW93y6H88=;
 b=RWRfRO7Ab+3zoyIJWGUNAfLegN24RYEZQb/2owF1Oytu8OchZCl94qV3IDWa4i+73RfiCuPjvPPc3Pg5D91MG5MT/vEG0IsWowHq1gsV3S2nAl/d/NI3dVuH4olj837YSkX0JCfixul9MlrsaQUGht9gtOwhDv7s7P50ooLAN1U=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 05:54:45 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:54:45 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v3 15/15] drm/amdgpu/gfx11: enable the gfx engine soft
 reset
Thread-Topic: [PATCH v3 15/15] drm/amdgpu/gfx11: enable the gfx engine soft
 reset
Thread-Index: AQHdZrp7xvImA4JvwEaM0GThajQwFLcc2eaAgACYsDA=
Date: Wed, 4 Nov 2026 05:54:45 +0000
Message-ID: <DM4PR12MB515293E412AE38BDF5887340E3682@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-15-Jesse.Zhang@amd.com>
 <06afbec39afd388120e16d63c74080977a017619.camel@gmail.com>
In-Reply-To: <06afbec39afd388120e16d63c74080977a017619.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T05:47:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA3PR12MB9228:EE_
x-ms-office365-filtering-correlation-id: 6bc2da59-7b99-41c6-dbc9-08df3a3820af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261022105027099003|261021121427099003|261022075727099003|261009223027099003|4143699003|261026140227099003|38070700021|261026121527099003|261028144727099003|11063799006|56012099006|22082099003|261102123227099003|6133799003|10067099003|18002099003;
x-microsoft-antispam-message-info: tx2SC73BvW2VVGheUF8UloNU0hSGLKkkMqsca7ccWqibOR8b0FIcIxUovP8oegn0c9qKiJqnmiiaEH+Cpoch+9fd0xgg7Ri2BQPZq2niomv+Rh6uKj33skit5XUP7KGOH/McX8HosUPNniWNpfgKgtezupJ250weumuRwVzBFBZVmufJwu0wtyEpOjXniJhce7c8z9PulItC5Iljc5L2IS8JjxDmdHvTO2+PlkSr2k+s1cZetH0wfq0eGEieyNdbuAXKGNmD7TSc2AGCKGl2HeG2DQoJwx/ztvOb15ABExb8EY0Lsi/WnWO3bR8I0b53kOF6ivuoBHHdFF3w8uFwK6ibpO2XaYFtDTMyLBXgCANyTls4he/Ga0G1fYtFUF+gsCMQLrx0htUb+FSLmE3Jy2bZbZO/iew24yddAaxKwvP+GAnrrCteJsplXF9vllafDujgmeW4rpHCEiTeomJiHWC1YJK9y9Kv1V2i0oRXzuSVb5M8jszq4Aibgks3mc80YS20gNAW9bjhHf8H7yb3aFcyft9OeOinkVJvX2mIkbsQeurdfRUucCK8JWXzEXNRl3pr+vYU0vfW+1o3gmefIW+LRgA666nRIZInCfDg0YDp2i5ajf7wqJ9vWHCGyRAyf8OUDCPcmjelbaWRMfa9qISRALa1KgkM2GYLCUzR80eHERnOSuGeivOZjCRvwhZ7vx3zabst5VRk7qvJi7O2zQDK8oLmSr2FLVCtFD5uHUE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(4143699003)(261026140227099003)(38070700021)(261026121527099003)(261028144727099003)(11063799006)(56012099006)(22082099003)(261102123227099003)(6133799003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNPTUIrNGZtWEh2L05wRENHamtjWGhqakp1UUNIdEdGU2dTUmg3NzFMMjU3?=
 =?utf-8?B?K0hBNlRGZnp3YjRvQStuTVpXQm0wYjJoUnV6SXJ2a0RDYmxrRy9mMEZ2dk1T?=
 =?utf-8?B?QnJUL3NSK0xLa2N6RVN5VnRJc1d2QUxNWGxqTGF1bzZtVzhjNjM3S0xlaFV3?=
 =?utf-8?B?Yjc4VVhRV3I1djlxUkV2WXkzSjlFb0svNGtwTWhuR3l4ZUJuelZ2c1A3NVNQ?=
 =?utf-8?B?c3JVWWd5UFJ5WmtpYlVoU2wwbktic3NucGFUYmFKajAveEVmblNFdUs0bVpq?=
 =?utf-8?B?akU5TnlIY1U5dzlRbStrWk14TFBleVdiWFJTaC9CdDZkWCt1ckVWbnFkTUQy?=
 =?utf-8?B?emRxK3VGMDZuYmNBT3FrOFdxNGtaZEdSdjNUV2NPbVd4Y1BlbFVKelhlT3dI?=
 =?utf-8?B?bEZMYlBJbUttTTgrRHpKZi95QXZwazdsUjdjaVdaQS9ENWFBMDIrcXU0blRF?=
 =?utf-8?B?N0NFcHMyRTJpSHN1b2EyalljL2xDT3M1OGg0Q1BTY2NVamNZQkNHVUVXMWdo?=
 =?utf-8?B?SldhTzBZb29HM1lCK2I4WWw5QStod1ZmK2RybkE2WEJrL3RtSTNqZjhqWHRZ?=
 =?utf-8?B?TGIrMDdXRkZrTUtSZG4rNnFlSWxHNXc5SHZGY2k2OGMvRHVoamxBWUVrOThE?=
 =?utf-8?B?a1cxZTBaK2NkTlg0SXp3VEp3U09FYjBNOEpuVjg0S0I2Zi9yN0hkcys0VHRQ?=
 =?utf-8?B?MmZxSHVSbUI2bWwvNWdWQlJmaFJUR2NKZHZ0QlNNSE93aWhtalFrMS9PeU90?=
 =?utf-8?B?U2dkaDdaQ0xPSkVSMnpESlJEZDVRT0dXY0tnekdUMEpQSW1uN09ZTWpCdG9R?=
 =?utf-8?B?WW5ROVVVdW8yV3RLMFljQ3BKOU1odjNxVjJ5N1IvUnZDU000TXUvZ3pXUVA2?=
 =?utf-8?B?VmJDSm9FL3VRcWtWTnpoTTVaVEozYVdOM0JYV1ppRjBTMkYxYzAvRVNmR2NO?=
 =?utf-8?B?Q0YvejVVbm54NkVsUThVc09mWUhmSkl3UzdYek1LbUpoZmUzTm41VVpmMXNJ?=
 =?utf-8?B?OFIvN0F5cnNVZUczekhQVkhLdlhsaXkzZlZ4c3kwcS9FNXJYNGVlYkR6VnFR?=
 =?utf-8?B?NkE3cTg3ZDRPYWpmc1FiNWZ1ZHlldnd6WVh5ZzZORk9GUVNvUmZuenF3aWJ0?=
 =?utf-8?B?aEhrYWkxd1lZazdtUXFiS0lnSXlWMVVhZklCSjQ2Vk1kT1RzV0sxaFdUTmNo?=
 =?utf-8?B?clk5OHYxRW5MMy9vVE9RbTRoa3E3NDBzbzErRm9WRllrbjB5SUVVeERLSjRm?=
 =?utf-8?B?REVkOHlmTmhmZDQxSkJkVXc4bHFxclhjRDBYdU9XT29ySGp1UkZ0bHIxWHZ6?=
 =?utf-8?B?Yitibm1IUEcvWTVHMERnRTNXWUtDY1JLeDVhT3Vpb2FKcEpqRHozWnZzOUtH?=
 =?utf-8?B?TW1LUFBkZmordmhadTB2QktTWkZFWkZvZURUNXo4TVlBZ25wTFFTVnNHajM5?=
 =?utf-8?B?RkRQVURVbWpCb1N5OTlIREJtdThUa0wvMWpFNnpIaFZmZWJLS3BUTWMrRzlz?=
 =?utf-8?B?TkR3elBZOWZzcGJYaTdDaE83cjdEZzRFeldXWmlsVkhGd3lkWnhXQ3lkWWRW?=
 =?utf-8?B?MGVDSzFvVmtFNmhsWmJiMFJOMUlBeC95SkRQWTE4Z1JoRlNYV1A0aGNPSnBy?=
 =?utf-8?B?OHVKb0xENFpXcFlYbXNZYWpKekU0eUhDWFRQLy94RDdKejFGU2NQczhsM1BR?=
 =?utf-8?B?Vk40aWtiVGNhaVFBV0dudWhybEZ3Zmd3VXhtR0k0KzZkZGRtb1cvbDNyZnJk?=
 =?utf-8?B?L3BZTnlhR1VDdmJZY1EyUmVTeTFKTDJDYUY2bWxqZEdxaWU3Sk9XTklKS2pO?=
 =?utf-8?B?a1NoOXVGanBxMVI0NTVuaTlhUEZmTmMrbTd1UzNaeU1qNHdOY3RQejJ5cEdY?=
 =?utf-8?B?dkpqVnpXMklOMzdjVVQ5SXZnRUZPSVh6NFhjQitxeW93Z3JyZHZEaTVyUmNo?=
 =?utf-8?B?WUpaUFIrS3ZmQmZhQStVUFZxWUxWWnBlUUdUaGp4L2QzdWVleWR4VDhOUkJR?=
 =?utf-8?B?c0FLMGpyWE53SHBtRmxHUXhaRTEvUTVBY0RKQldqcTR5R21uQUE5c3JhbS92?=
 =?utf-8?B?VTlkTGxuR0xzTmxPNVg3Y05IWlBOanpHTjMvZ1BrMHl5SWxFVU9JaGRPL2dN?=
 =?utf-8?B?WDlVUjg3ZCtJbzBOeDFYVmd6VDcxWGhsY1k1R3BBRWsraGZWQWVmRk1uYnBk?=
 =?utf-8?B?UlVaWk1ObVF0QjFnTm5KYjM5c21oSVlSQzIwMVQ0SmJpaXpHNEpMNWJZK0pQ?=
 =?utf-8?B?NHdBUld2UkxpclNTWHlDQWZGYXdnS1k1c3JMS0lkSERYdndSWjdOWVJEbUFo?=
 =?utf-8?Q?mIGUNQ0/tgmO7tDR2E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc2da59-7b99-41c6-dbc9-08df3a3820af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 05:54:45.0614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLOTDvW7EmcXuxncDbb+1nP0jBz6h14wW71eiye/lonoDpkUYH+NA85dEmd5bdOdgrfy49TCLdhJzCR3ZqV15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
Tm92ZW1iZXIgNCwgMjAyNiA0OjQxIEFNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2Uu
WmhhbmdAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBD
aHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpv
LkxhemFyQGFtZC5jb20+OyBNYXJpbw0KPiBTb3BlbmEtTm92YWxlcyA8TWFyaW8uTm92YWxlc0Bh
bWQuY29tPjsgUmFzdG9naSwgTWFudQ0KPiA8TWFudS5SYXN0b2dpQGFtZC5jb20+OyBaaHUsIEpp
b25neXUgKEpvZXkpIDxKaW9uZ3l1LlpodUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDE1LzE1XSBkcm0vYW1kZ3B1L2dmeDExOiBlbmFibGUgdGhlIGdmeCBlbmdpbmUgc29mdA0K
PiByZXNldA0KPg0KPiBPbiBXZWQsIDIwMjYtMTAtMjggYXQgMTY6NTYgKzA4MDAsIEplc3NlIFpo
YW5nIHdyb3RlOg0KPiA+IFJlcG9ydCBBTURHUFVfUkVTRVRfVFlQRV9JUF9CTE9DS19TT0ZUX1JF
U0VUIGZvciB0aGUgZ2Z4IHJpbmdzLCB3aXRoDQo+ID4gYW1kZ3B1X2dmeF9zb2Z0X3Jlc2V0X2Vu
Z2luZSgpIGFzIHRoZSBzb2Z0X3Jlc2V0X2VuZ2luZSgpIGNhbGxiYWNrLA0KPiA+IHdoZW4gdGhl
IHJlc2V0X2VuZ2luZSBjYWxsYmFjayBjYW4gYmUgdXNlZDogd2l0aCBNRVMsIGFzeW5jIGdmeCBy
aW5ncw0KPiA+IGFuZCB0aGUNCj4gPiBSUzY0IGZpcm13YXJlLiBUaGUgcmVzZXQgcmVzdGFydHMg
UEZQIGFuZCBNRSBmcm9tIHRoZSBzdGFydCBvZiB0aGVpcg0KPiA+IFJTNjQgZmlybXdhcmUsIGFu
ZCByZW1hcHMgdGhlIGtlcm5lbCBnZnggcXVldWUgdGhyb3VnaCBNRVMgZnJvbSBpdHMNCj4gPiBN
UUQsIHdoaWNoIHRoZSBrZXJuZWwgZ2Z4IHF1ZXVlIG9ubHkgaGFzIHdpdGggYXN5bmMgZ2Z4IHJp
bmdzLiBOb3Qgb24NCj4gPiBTUi1JT1YgVkZzLg0KPiA+DQo+ID4gVGhlIGtlcm5lbCBnZnggcXVl
dWUgYW5kIGdmeCB1c2VyIHF1ZXVlIHJlc2V0cyB0aGVuIGZhbGwgYmFjayB0byBhDQo+ID4gc29m
dCByZXNldCBvZiB0aGUgZ2Z4IGVuZ2luZSBiZWZvcmUgYSBmdWxsIHJlc2V0LiBUaGUgSVAgYmxv
Y2sgc29mdA0KPiA+IHJlc2V0IG9mDQo+ID4gZ2Z4MTEgb25seSByZXNldHMgdGhlIGdmeCBlbmdp
bmUgdGhlbjsgdGhlIHdob2xlIElQIGJsb2NrDQo+ID4gc29mdF9yZXNldCgpDQo+ID4gaXNuJ3Qg
dXNlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0Bh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEx
XzAuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjExXzAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8w
LmMNCj4gPiBpbmRleCBhNzFkYWU1ZDBkM2EuLjQxZWJkMmVhZDk5YiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gQEAgLTM2Myw2ICszNjMsNyBA
QCBzdGF0aWMgdm9pZCBnZnhfdjExXzBfcmluZ19pbnZhbGlkYXRlX3RsYnMoc3RydWN0DQo+ID4g
YW1kZ3B1X3JpbmcgKnJpbmcsDQo+ID4gIHN0YXRpYyB2b2lkIGdmeF92MTFfMF9zZXRfc2FmZV9t
b2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQNCj4gPiB4Y2NfaWQpOw0KPiA+ICBz
dGF0aWMgdm9pZCBnZnhfdjExXzBfdW5zZXRfc2FmZV9tb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBpbnQNCj4gPiB4Y2NfaWQpOw0KPiA+ICBzdGF0aWMgdm9pZCBnZnhfdjExXzBfdXNl
cnFfcHJpdl9mYXVsdF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdA0KPiA+ICp3b3JrKTsNCj4gPiAr
c3RhdGljIGJvb2wgZ2Z4X3YxMV8wX2VuZ2luZV9yZXNldF9zdXBwb3J0ZWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UNCj4gPiAqYWRldik7DQo+ID4gIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX3Jlc2V0X2Vu
Z2luZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbnVtIGFtZF9pcF9lbmdpbmUgZW5naW5lKTsNCj4gPiAgc3RhdGljIGJvb2wg
Z2Z4X3YxMV8wX3JlYWRfZ2Z4X2hxZF9wdHJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0K
PiA+IEBAIC0xOTQ1LDYgKzE5NDYsMTAgQEAgc3RhdGljIGludCBnZnhfdjExXzBfc3dfaW5pdChz
dHJ1Y3QNCj4gPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiA+ICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgaWYgKGdmeF92MTFfMF9lbmdpbmVfcmVzZXRf
c3VwcG9ydGVkKGFkZXYpICYmDQo+ID4gKyAgICAgICAhYWRldi0+ZGVidWdfZGlzYWJsZV9pcF9i
bG9ja19zb2Z0X3Jlc2V0KQ0KPiA+ICsgICAgICAgICAgIGFkZXYtPmdmeC5nZnhfc3VwcG9ydGVk
X3Jlc2V0IHw9DQo+ID4gQU1ER1BVX1JFU0VUX1RZUEVfSVBfQkxPQ0tfU09GVF9SRVNFVDsNCj4g
PiArDQo+ID4gICAgIGlmICghYWRldi0+ZW5hYmxlX21lc19raXEpIHsNCj4gPiAgICAgICAgICAg
ICByID0gYW1kZ3B1X2dmeF9raXFfaW5pdChhZGV2LCBHRlgxMV9NRUNfSFBEX1NJWkUsIDApOw0K
PiA+ICAgICAgICAgICAgIGlmIChyKSB7DQo+ID4gQEAgLTY5MjcsNiArNjkzMiwxNiBAQCBzdGF0
aWMgdm9pZCBnZnhfdjExXzBfZW1pdF9tZW1fc3luYyhzdHJ1Y3QNCj4gPiBhbWRncHVfcmluZyAq
cmluZykNCj4gPiAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgZ2NyX2NudGwpOyAvKiBHQ1Jf
Q05UTCAqLw0KPiA+ICB9DQo+ID4NCj4gPiArLyoNCj4gPiArICogVGhlIHJlc2V0IHJlc3RhcnRz
IFBGUC9NRSB0aHJvdWdoIHRoZWlyIFJTNjQgc3RhcnQgYWRkcmVzc2VzLCBhbmQNCj4gPiByZW1h
cHMgdGhlDQo+ID4gKyAqIGtlcm5lbCBnZnggcXVldWUgZnJvbSBpdHMgTVFELCB3aGljaCBuZWVk
cyBhc3luYyByaW5ncy4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBib29sIGdmeF92MTFfMF9lbmdp
bmVfcmVzZXRfc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4gKmFkZXYpDQo+ID4g
K3sNCj4gPiArICAgcmV0dXJuICFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRldi0+ZW5hYmxl
X21lcyAmJg0KPiA+ICsgICAgICAgICAgYW1kZ3B1X2FzeW5jX2dmeF9yaW5nICYmIGFkZXYtPmdm
eC5yczY0X2VuYWJsZTsNCj4NCj4gSSB0cmllZCB0byB0ZXN0IHRoaXMgb24gU3RyaXggSGFsbyBi
dXQgaXQgc2VlbXMgaXQgZG9lc24ndCB3b3JrLCBtYXliZSBkdWUgdG8NCj4gcnM2NF9lbmFibGU/
DQpZZXMuIFN0cml4IEhhbG8gZG9lc24ndCB1c2UgcnM2NCwgYW5kIHRoZSByZXNldCBpc24ndCBl
bmFibGVkIGZvciBTdHJpeEhhbG8uDQoNCj4NCj4gSXMgdGhlcmUgYW55IHJlYXNvbiB0byBub3Qg
ZW5hYmxlIHRoaXMgb24gR0ZYMTEuNSAoYW5kIEdGWDExLjcpPw0KTm8sIHdpbGwgdHJ5IG9uIHRo
ZXNlIGRldmljZXMuDQo+DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qIFJlc3RhcnQgdGhlIFBGUCBh
bmQgTUUgcGlwZXMgZnJvbSB0aGUgc3RhcnQgb2YgdGhlaXIgUlM2NA0KPiA+IGZpcm13YXJlLiAq
Lw0KPiA+ICBzdGF0aWMgdm9pZCBnZnhfdjExXzBfcmVzdGFydF9nZnhfcnM2NChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikNCj4gPiAgew0KPiA+IEBAIC03MzcwLDYgKzczODUsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGFtZF9pcF9mdW5jcw0KPiA+IGdmeF92MTFfMF9pcF9mdW5jcyA9IHsN
Cj4gPiAgICAgLnJlc3VtZSA9IGdmeF92MTFfMF9yZXN1bWUsDQo+ID4gICAgIC53YWl0X2Zvcl9p
ZGxlID0gZ2Z4X3YxMV8wX3dhaXRfZm9yX2lkbGUsDQo+ID4gICAgIC5zb2Z0X3Jlc2V0ID0gZ2Z4
X3YxMV8wX3NvZnRfcmVzZXQsDQo+ID4gKyAgIC5zb2Z0X3Jlc2V0X2VuZ2luZSA9IGFtZGdwdV9n
Znhfc29mdF9yZXNldF9lbmdpbmUsDQo+ID4gICAgIC5zZXRfY2xvY2tnYXRpbmdfc3RhdGUgPSBn
ZnhfdjExXzBfc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlLA0KPiA+ICAgICAuc2V0X3Bvd2VyZ2F0aW5n
X3N0YXRlID0gZ2Z4X3YxMV8wX3NldF9wb3dlcmdhdGluZ19zdGF0ZSwNCj4gPiAgICAgLmdldF9j
bG9ja2dhdGluZ19zdGF0ZSA9IGdmeF92MTFfMF9nZXRfY2xvY2tnYXRpbmdfc3RhdGUsDQo=
