Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C791FEEAA5E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 17:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6946810E29E;
	Thu, 14 Sep 2023 17:36:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD97B10E29E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 17:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+oummIRQN37DpE0HNR/OKDCy+3qmN7eEjbsMdt/k2g8mFiDyAuDl32BPG9JuJgFOskBL+690Muk3PDW4zJC6FX+XCw1Kd05M11o8pu2A6qsQLocFaM0pc8uPtlW3sUH0U8zqQFFROe/0WGp+9wX4T3YJSP3+xIHZt7NxUNsreusFfZmafLJCyU/09/hJtvG5zGYTqd81qWd0oIeGDuIHIDtMP39KPR7Y2U6hya81J9fY/ZKk1wFreJvl1kj+Nlqo+/vbLdhy80R7vt5eKvjxcBZQauYL6+xHiTGLeCVBTslSsjUuC8FHA5IJl9I5dVFOhgsKtWdy84d1UvxqFu03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89hQwLhS3TH7HmscxjC6y0m/7+Fm4DCG483xOFbP1Nk=;
 b=kK4xo2bgCx39Ml1OHplgXrzEyGpkkAtAkRlRaaejlnwd4sEYj9xTWplKX2RTnD1p9sHeCufv2UXM3PXOad6LoKUbzmk6wl2XlaU+kmcC51GzcA5NhlxeY0asI9SaGjLcHQQB5+rW6DvhgjgFiEKIHuQSCIBq46lcqeBBoAS6i+fp5Y+iHDsjpjRz+/izy6cJU9FDHyEn4DTtLuBtiXZNYKYY8EYBQWZ3BYIH4+srcPW594EivoCWnDEBsnFP6OvIJQKNwzT+3uAa9pXrtH3gcbscHKENUBPrJLIH+iA9VryRclhlenB7XwtxpAMHPH5qAVpJLh5zwXaLPsLpkjSXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89hQwLhS3TH7HmscxjC6y0m/7+Fm4DCG483xOFbP1Nk=;
 b=ekJe4SFJ5Ji0TFsZGzam5yImBogZQ0Tk5DkFVP86ctEunia7tGBLVlTTkPMw67TRtID9Y4LlfRP6kRT2xE4YC378J5Ho2oMbLkRerM6XP1pKT+7ghfb0CnabRdPpAT+C/+mrmm3p0DTThDe2ih+0UKpqZcjAcme6MvK4MdIzzPE=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 17:36:17 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::2ced:6c4f:9dc7:4a3f]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::2ced:6c4f:9dc7:4a3f%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:36:17 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Align unique_id format to match amdgpu
Thread-Topic: [PATCH] drm/amdkfd: Align unique_id format to match amdgpu
Thread-Index: AQHZ5y408hVkMQZuGUqO7cplzbp0B7Aakk4AgAACjTA=
Date: Thu, 14 Sep 2023 17:36:17 +0000
Message-ID: <BL1PR12MB5898B14E383F9D57DB885F0685F7A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20230914170906.88487-1-kent.russell@amd.com>
 <2bf0fc75-0ee3-4ee1-678c-e7f26ce781dd@amd.com>
In-Reply-To: <2bf0fc75-0ee3-4ee1-678c-e7f26ce781dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=725fb5c0-2ed0-47f7-81ee-ba63829df25a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-14T17:33:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BY5PR12MB5015:EE_
x-ms-office365-filtering-correlation-id: 746e70f7-633f-4874-49f1-08dbb54919a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8tS33jUP32QtRVivlA59aoaFQzts4ThNyLDP6FSy+hov4DIRKqjcrJYWwR+Cd7+IRJ9rZTGWpZrwz46urvjEb5eq750mdebjO9jAmyq+60KClM7d3oFAkeIMSlhzlc9V0fr53dn0s5ir3lt3qMbm+1wFUocIOhPWrPc+h6U2pmq1LzSwn9g0PaT+q2rtUj7k1LbQqPVcHFpYPx/0FXJcIK+5oFmv1OTItKAljWcALLw4/OZecz0WG0r866EFTZFMXgiFEuus9+xCxmjnfqBm7pGCksMLxIgtOZOQ8xG+Bvd4IFI0ktVWvEzD4JSWIt9gIYXefFujBnjceZ9krZv+pvCyDoAC8Rdogz/xVNIbDDrfDrhWPbN9kSqcwL0GA2+T3poiySCrcpyrl1IKZw1OxYTVQWlyYIe6QWCy0nQl88ydQDNeSjYk/51Z8Vd3LWg56y3XvJk+gN1uad+Uyh9fm7m1fvHkk41nByy8vTENSng9xN+jCrRYV9FBUd/MRt1xMcGq2vqIarbqTs2Oom1ycPcnBSwxcbvV+LMFRfpiXGkMGAbD7kpOb/C2Sl9I8F0/yFNFuU1n8LrpWH5lU04qlhIJp1TcnjTyrpMRFzL3nSApxKSot9BVPaNj6IWIXP8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(1800799009)(186009)(451199024)(55016003)(7696005)(71200400001)(6506007)(53546011)(9686003)(83380400001)(478600001)(26005)(110136005)(2906002)(66476007)(64756008)(66446008)(66556008)(66946007)(52536014)(5660300002)(316002)(8936002)(8676002)(76116006)(41300700001)(38070700005)(86362001)(33656002)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpiYVhHMTRaMmxEMWovdVo5Zjk2SmtWS1FGSm1Ma21PS0JxMzkwWFo4WTlQ?=
 =?utf-8?B?dHJoVEo3MVFlWWplSWJON3V5NHZRVTZ1WGJzRzkxM1hMWjFRbmtrZlNkZHRD?=
 =?utf-8?B?KzdtVE15UTFGeStZZjVONWZDY25ZejBjeEtQczNBRGtZeTB4YzBabzZmbFVC?=
 =?utf-8?B?MlhVOEkvTWVLOWZtWkN1VnRZb1l6NThROXdoeEpCc29wanpwUDlmczNCZXRX?=
 =?utf-8?B?bmxySk1IMzc3RFVHOVk4cWg0K2IyM2pRS2VxQW5RbUhtT1MrVUdyZDhnelZQ?=
 =?utf-8?B?MEpEWXZteWN5WVlrK1hOUjU3VHByZ04xaC9oS1ZkNTVzU0dSN3pNWE1OVHFn?=
 =?utf-8?B?WkZTWEx2cFRUYXJlclE2TGFzQlJpNVhVcGJBc2hncVBhdUdrUW1FWHNqdWRr?=
 =?utf-8?B?QzlYRm8rdmJxQ2RpK01MS0VjZ1VKaHdUYTVwQko1MDRZSHpxWFZibFBCT1hY?=
 =?utf-8?B?VDBZZ1lXL3RtMGs5L0JCOGpQWnM4Z2kydi9oWG9DTkxIbVNuSGRkWkhqSXlq?=
 =?utf-8?B?RUpRQ2NVeS9tWVN3UHB0WGlWV1M1Sk5QaU1FSFJrM1l2MGJ1SWlpUjFnSFk3?=
 =?utf-8?B?ZzZYaHNNcFNDdkxUZDJuT1hyeW1MRDdnV0REWmxhbVJBZHl0R2xiem9Eak50?=
 =?utf-8?B?T0E4c2NWbzV3SnZUK3lTN2dUZU9PL3o0QUY0LysrY3Bjc0xrSkQ4bVgrNFI5?=
 =?utf-8?B?RXRvQml0MThBSS9HTlgyRGk0RktTTXZFbGVMQzZnbDd6bUNUSDZHdzdOSzNK?=
 =?utf-8?B?MnI5aUJhWnk5YUhVcG16U0k0SmNhRldTSXBLNHN2VDB6Mk9TSUZncmROZ3N2?=
 =?utf-8?B?UmJCYUwzczk5czl3TVVvMUliUmZxLzZBYUxHUitsbzQwWFZNRlhNL1lkWVAx?=
 =?utf-8?B?UXAva1FyMFAyQWQvTFlDSjl6TjVabHdXaWVNVnJSalppVWlZZ1cvWEpzSVNC?=
 =?utf-8?B?K3lWODROeGhvdVlpeGNNQmdlaVB0ZkNncThkc3NnWjUrcTY3TjVZWUs4SVNC?=
 =?utf-8?B?NEc3aUQwNjdSNnJlelFqa09KdDB2UnUzZU1aTzJEd1lmdCtBVU1xWEtjWUpJ?=
 =?utf-8?B?SUF5ZFcva1VSYncyMUh4azdvZSs3WWpMaFhoZFk4VkFtMnh3clI0d1VxeG82?=
 =?utf-8?B?bThmTHkvR3F0dHBuekJnZ2t4TldrUmh6VDVKMXlTTGQxNzhmNEFkTWt4TEZt?=
 =?utf-8?B?UVlqd0FpT1pwYWFhSWVjNnRORENBR1hhajlHWDIzbFU5Z2h4MTdhSGZmOEdR?=
 =?utf-8?B?UGhzMmoxajdPcm50c2xYend1cHdSbWRYOWVFVDZpeTF3MlF3aWVmTnI2b1VY?=
 =?utf-8?B?Z1RZUkJjWE84QlNHY1VPVUUrL1Y5V3ZiekhLTW9iclErSU1WeXVsT0luT1Ba?=
 =?utf-8?B?eXBwNUo3TGYrMUF5Q0k2Ynk1SVFpOFY5RUx0OE1DTFBMbkFjM3FlT3VQeFFi?=
 =?utf-8?B?Q0xvYzA4WXNLOU5XNWlJVjFwNTY1QTFIUk9UL3Nna3pMNFRKU1owQnlUeTFp?=
 =?utf-8?B?QktMbDFqekdxNE41M1hLb01IVFZ5dzJOQUZiMDlxWlB4R3ZuaXRETTBNMmsw?=
 =?utf-8?B?QS96QmozVXpoOEtDNmZmYVVqZTgwTENaTFVxRThtcjBPWDhySklqTTh2VDgx?=
 =?utf-8?B?K28weTVIVWR0VFN6NmFmdDF6QnltQVIxZjZDQlhzM0hxejJVTk9FdkU4TmFo?=
 =?utf-8?B?a0p5UDFKb1J0dnhiUWl5NFFTZSt1MDNKV1phSWhTQ1ZmYnlkMEFZc2NmdVJm?=
 =?utf-8?B?U1VGN05nN1U5TS9yV0tES3FLTi9EN0NmcVdHZVlEaUtnaWQ0Vzh2U081SUEx?=
 =?utf-8?B?OW5wS1doTU1Ra1FxajEwQksrT0JqejlaVTJKTDF5ZE9yT0VDWENaOXNSMmVi?=
 =?utf-8?B?VmJqTzIzVlpERDNLN0RRVjFVbEg2Y1RhVXljMHpIbjUvb3Bya09DcEY3YTVy?=
 =?utf-8?B?d1ljT2xpSmN1WFR4TlQ2Y0Zpc1MzMFNaM1IxTndHREtxU2MycDY1LzRsOGRp?=
 =?utf-8?B?OThXdFkxOHdWM0cxckFVVXg4c01xNnNaZmZGV0JpRFpVS25GMmNxTzJadEMx?=
 =?utf-8?B?c2g5Ym1QRVJzY2s1UGVCVHM2b3NzQTV2Y2l0NFBGd1UwQVQ3T3ovU1JPaFdz?=
 =?utf-8?Q?z2HA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746e70f7-633f-4874-49f1-08dbb54919a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 17:36:17.0325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrqq1pKipwDUNcRIhkh5ZD2NFXxGNXcPvQ3sS8qAKFWO/5b7mjhSoyXXSBZzrozIq2MBzP5IrUvhWXGMqA6QXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE0LCAyMDIzIDE6MjUgUE0NCj4gVG86IFJ1
c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogQWxpZ24gdW5pcXVl
X2lkIGZvcm1hdCB0byBtYXRjaCBhbWRncHUNCj4NCj4NCj4gT24gMjAyMy0wOS0xNCAxMzowOSwg
S2VudCBSdXNzZWxsIHdyb3RlOg0KPiA+IHVuaXF1ZV9pZCBpcyBwcmludGVkIGFzICUwMTZsbHgg
aW4gYW1kZ3B1LCBidXQgJWxsdSBpbiBLRkQuIENhbGwgdGhlDQo+ID4gc3lzZnNfc2hvd19nZW5f
cHJvcCBmdW5jdGlvbiBkaXJlY3RseSBhbmQgdXNlIHRoZSAlMDE2bGx4IGZvcm1hdCwgdG8NCj4g
PiBhbGlnbiB3aXRoIGFtZGdwdS4gRG9uJ3QgbmVlZCB0byBhZGQgYSBuZXcgbWFjcm8gc2luY2Ug
dGhpcyBpcyBhIG9uZS1vZmYuDQo+DQo+IERvZXNuJ3QgdGhpcyBicmVhayB0aGUgQUJJPyBBbnkg
dG9vbCBjdXJyZW50bHkgcmVhZGluZyB0aGUgdW5pcXVlIElEDQo+IHdvdWxkIGV4cGVjdCBpdCB0
byBiZSBkZWNpbWFsLg0KDQpBIGZhaXIgcG9pbnQsIGFuZCB3YXMgc29tZXRoaW5nIEkgd2FzIG9u
IHRoZSBmZW5jZSBvbi4gVGhlIGlucXVpcnkgY2FtZSBmcm9tIHJvY20tc21pLCBub3RpbmcgdGhh
dCB0aGUgdW5pcXVlX2lkcyBkaWRuJ3QgYWxpZ24uIE9uZSB3b3VsZCBhc3N1bWUgdGhhdCByZWFk
aW5nIGEgc3lzZnMgZmlsZSB3b3VsZCBiZSBkb25lIGFzIGEgc3RyaW5nIGFuZCB0aGVuIGNvbnZl
cnRlZCwgYnV0IHlvdSdyZSByaWdodC4gV2UgY2FuJ3QgcmlzayBicmVha2luZyBvdGhlciB0b29s
cyBqdXN0IGJlY2F1c2Ugd2Ugd2FudCB0byBmaXggb25lIG9mIG91cnMgYW5kIG1ha2UgYXNzdW1w
dGlvbnMgYWJvdXQgaG93IHRvb2xzIGNvbnN1bWUgdGhlIGluZm9ybWF0aW9uLiBJJ2xsIHRhbGsg
dG8gdGhlIFNNSSBndXlzIGFib3V0IHRyeWluZyB0byBjb252ZXJ0IHRvIGhleCBpbiBTTUkgdG8g
YWxpZ24gaW5zdGVhZC4NCg0KIEtlbnQNCg0KPg0KPiBSZWdhcmRzLA0KPiAgICBGZWxpeA0KPg0K
Pg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3Bv
bG9neS5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3RvcG9sb2d5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9w
b2xvZ3kuYw0KPiA+IGluZGV4IGM4Yzc1ZmY3Y2VhOC4uNGRhYzI5Y2RhYjIwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gPiBAQCAtNTM4
LDcgKzUzOCw3IEBAIHN0YXRpYyBzc2l6ZV90IG5vZGVfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29i
aiwgc3RydWN0DQo+IGF0dHJpYnV0ZSAqYXR0ciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2LT5ub2RlX3Byb3BzLmRlYnVnX3Byb3ApOw0KPiA+ICAgICAgICAgICAg
IHN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIsIG9mZnMsICJzZG1hX2Z3X3ZlcnNpb24iLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPmdwdS0+a2ZkLT5zZG1h
X2Z3X3ZlcnNpb24pOw0KPiA+IC0gICAgICAgICAgIHN5c2ZzX3Nob3dfNjRiaXRfcHJvcChidWZm
ZXIsIG9mZnMsICJ1bmlxdWVfaWQiLA0KPiA+ICsgICAgICAgICAgIHN5c2ZzX3Nob3dfZ2VuX3By
b3AoYnVmZmVyLCBvZmZzLCAiJXMgJTAxNmxseFxuIiwgInVuaXF1ZV9pZCIsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+Z3B1LT5hZGV2LT51bmlxdWVfaWQpOw0K
PiA+ICAgICAgICAgICAgIHN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIsIG9mZnMsICJudW1f
eGNjIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVNX1hDQyhkZXYt
PmdwdS0+eGNjX21hc2spKTsNCg==
