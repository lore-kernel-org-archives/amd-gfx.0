Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E448BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 13:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430706EDC0;
	Fri, 26 Nov 2021 13:21:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CC86EDC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 13:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4s9E73RDSbJsfKMnjcv3soG/ofp/SP8wBEgpriPrm2Leae02HBVKHzHMp01xv+6ME8wA/SvDldD7ZA0yiaSFP9uO2zg5RLgH2Z9w/gfFhmecbMAc0ZQnJFrZORNsyNcC/jXco0CBGhIjPituCVbYwoB1MZkHE/B1TKPfalklfIwPmKpIzxecVxTygg/8Y/czKeeCkWpIcCEOkuKigUQKPfZhfQ9/qLyJCONqm+Wvfw5V5SVD3dQnHd+36FGkoJJWfbVPUSPMiwHEMHTx+FGddFHoWkGlfUT5rbJ4qeM2aEPfHKjnbKkQxaTR9kqjQ4IbbqmeXoaLpnVM03Dk0xBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSUDPlnD6kJmMyWxC/aqjDZ70wOO2QOsmQtEROSLpWc=;
 b=hdsVU+agGTmnYXIIo0ci8ehxEncV9geXXe12wVUUxGC+T+biFFAA7pfCgs0wHkGJP0FETgcEo8Vi85leHyfG9xhgT+KfMWu4tjUQxKMpad1HChrFSRFXCBC7VLlU9yI0iu7dO17ZFuw0o1FsO10G67U8jVQC5gxBsK2U/RbEVmUf5r1j8ApHcPbP7lA4nM69awAbsd611siwMp/THVUTxp8y46G2LsZKCmEuzWb93c9aaGOrAfu9jXRR9vq/ydU95EEBeSL9nWJWOxyxOOYf21pVJaK75SSZC0ibBxYngSw5uURTDDTTUi63xgIaQ2O4V5iKL0i81VnhDbLiPMhVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSUDPlnD6kJmMyWxC/aqjDZ70wOO2QOsmQtEROSLpWc=;
 b=jO0PODCUFU3aOAx8wmMw/2Cwl5Ez17ZRWB2R47V14er46sin5M4GcbUuM3q3ns2HXR7euNZei/qLW0tEebh/k7Ep2dyMCG8o2TnC1CZr/Jfkkp9U3KNy77hkKW5iPOEjGFNYsibHjjZO0Cns3Agm4kEATaQm8130FYUAxoF1b3g=
Received: from DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) by
 DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Fri, 26 Nov 2021 13:21:03 +0000
Received: from DM4PR12MB5342.namprd12.prod.outlook.com
 ([fe80::e013:3ea8:78a9:fe6e]) by DM4PR12MB5342.namprd12.prod.outlook.com
 ([fe80::e013:3ea8:78a9:fe6e%5]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 13:21:03 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogZml4IGRp?=
 =?utf-8?Q?sable_ras_feature_failed_when_unload_drvier?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier
Thread-Index: AQHX4qrH879W1b1KHUyBatZqER11jqwVxOGAgAAB/cCAAAH0gIAAAivQ
Date: Fri, 26 Nov 2021 13:21:03 +0000
Message-ID: <DM4PR12MB53423BFFBC0B60B5D2FDD0C59A639@DM4PR12MB5342.namprd12.prod.outlook.com>
References: <20211126094826.13732-1-Stanley.Yang@amd.com>
 <BN9PR12MB52574BFE341A838E1FDB319CFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM4PR12MB5342E076533F063F000BF8999A639@DM4PR12MB5342.namprd12.prod.outlook.com>
 <BN9PR12MB5257474F4794351E0DD7D6DBFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257474F4794351E0DD7D6DBFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T13:11:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fe7f4a64-fa8e-45eb-b3be-1ee62c5d2764;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-26T13:21:00Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 37e63b81-09f0-4f63-9b0b-d67fdbafb5e1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99c0d765-a44c-4fa9-2b76-08d9b0df988f
x-ms-traffictypediagnostic: DM6PR12MB5551:
x-microsoft-antispam-prvs: <DM6PR12MB5551E24DF33CFAE56AA1177A9A639@DM6PR12MB5551.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FmECgLsBcytAqJ7GS3ZgpdDzKS6E48I0OvqIjlDQt4rKGTA5pmQOmZqQ8PoCQ6j92W27TvN3lcbaxYYM65/ujzbg4mvbWWyMF81uio+ZznF/uLZP0MPbkRF+TVPr29Viimy1vd2Vt3ZlxBFXikWm0BdjopwrPaavA8Fs2qODR/chW4fThLjJSl0mcrlzOaQ+Wq6KXUiYBFyMAkz7arE6uOchVjpAgID3x+S6ncqbx9ylB3pxmquJcIDADDou5rs01KQUquLuqzbsxZk9lawru3IoQXKCB/1kGQgkgNYh8RlCB7RuGzNoZH3fSoktPQkjS8zpCFLG66opfZ/K/PCuvyE3SCbfniGVXfQy888/VqpEMbdE+y9DSxuBdiMyLQQAZJsdawHKCJDRi+n10Fklvg2bYMRKol/NmX3uezVVcE2Ek5GEqTcLCd8ytyCeAD79gRzNwBAeKBI5SVGw/iep9FH+w1WXBHPZbZziFvjUhR8OcpQS5ssdZGhGXJey5EcKHoUECVEGW4u/0SEvRuruhKlkaAiwUGtfZjdYJbtZM6iV7lMIGWlECEDWLi6c9QZaUSUYBU9hbT7gO7tznHYqhiiWThCvnjWAJ2V8W8+CFMhHun6hj+XtMLJ7aBOK2aeYGC1YSgKnYyqMKDAJXsW//dcl2rYr94isrBBPJNq0SxHMeR6wq+vg/DK16R0Q0eGPGWsyySAL90+eZHaBszDGmzZh62vQEVaN0qhuzVm3RQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(52536014)(508600001)(8936002)(26005)(7696005)(9686003)(66946007)(55016003)(921005)(38070700005)(83380400001)(316002)(76116006)(6636002)(2906002)(66476007)(53546011)(38100700002)(66446008)(71200400001)(64756008)(122000001)(86362001)(5660300002)(66556008)(224303003)(186003)(6506007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnJRWXBqUWdQVFloc0FWUzExRnJDQmhrMCtBODl4cjVrUTlzUjBPTGJ2VEp4?=
 =?utf-8?B?TWU5UWJ0UlRTdXpBSlY0TnhqdjZVZHVWdzRjTU9WT3dKT0JkS3lQcjB6KzhW?=
 =?utf-8?B?aFhGNG4zT0s1cGd4VzlVRmowZlNqZURwRTFXNHBYVWFNazdIaWh3cFBwRVUw?=
 =?utf-8?B?VUdmL1FxU0lwT2drTU5tcUlJVWZJQ1BYdzZsNzk0bU1BUG5SeEhqWHRtYmJi?=
 =?utf-8?B?ZTFQTS9FK1k1QUgxWmpMN3FyRlN5N1FoZXhPcWlpTWJiVkhaaGhBcUh2RWxp?=
 =?utf-8?B?ZzZHVnhZWEJOVWRqMjJNalJhUmdFWFVIamUrUFpFVjBSMnRWa0FJMTc3am52?=
 =?utf-8?B?cGdldU5sN0I1dEx5dElKakpZSjhaZjgwYyt0TTQxSmJJeTZnNHJ6ZFQrRU9I?=
 =?utf-8?B?L0owVndWUjFvWXhhZ0RQZzdGRlpPbXdJbXpubVh0bVVVYmt6RVB5WFBpY2NN?=
 =?utf-8?B?anpONm81UGxRT1lldk5BYi81cjcwajQ5ZmZVMUd2RUpYQnJpeFN5Y2ZmTGl2?=
 =?utf-8?B?am1lTFQzckVqR1kvcEtMOUs2MEJVenNVUDVpdWQwZWgyZWZWdWNxR3U1TlFo?=
 =?utf-8?B?azJUYTU5SmlzY2tEUHRwdGtaVi8wNHljZldDTVNuR0JDczEzVU56aUMvWjYw?=
 =?utf-8?B?eXNoMGF5WEw1RUlNQ3RKbk4vdi81b1B2S1d4TzZJRUI5STMrbkJ0SENkcThP?=
 =?utf-8?B?dzZhNFF1L1FBVkVrOU5LMjJYc2krbG1jUnJkWEEvUCtXUWN3VGNHNkJKZjlw?=
 =?utf-8?B?cmtncDJqQmN6dGZ6Y2RGcDc4bVVRd3JZSkI4VllNeXhFRUpOWDQrbEdXTFNn?=
 =?utf-8?B?QzN2L2Z2YTdkeVM4YnZYdnJiVHgxT1ZwZWlvSmdrNTRHOHZ5Ui9aMDRhYTR2?=
 =?utf-8?B?cGxsRFhNcjcxbGxtdWtuM051MmN3Y0lGU29XREVQL0dZbHorTktsSkRadHJB?=
 =?utf-8?B?T3hVK3U4TkluQW1hQlYwcFBReStZdmhHWnVGazJmME83aXA3YlNKZ2NxQjd5?=
 =?utf-8?B?THBSbTdTVHZIWm5YSW1hZG9NbVN1Q25RQzhySzM1RFNlcng1d2VYRzBWMHB0?=
 =?utf-8?B?S1ZsK3JKNktNWEN6TUFtQjZTTXBWeG0zY3Y5UXBLRHpJckNKWkpjRHB5cTNO?=
 =?utf-8?B?MWliczJFUS9MRkhCOWg4b0xJazN3M2RYTmh5K0FtbCtjUlFOUUZRc3ZzeVAr?=
 =?utf-8?B?WWZLT3hyaUI1M2hEaWtzbzUzMXprd2ZaVm5KS3p5QjJmeDBaT2h3UkQ3TDl5?=
 =?utf-8?B?blA0U2pQaENnWUljQTFyUUdwYm9yUWNPcUViMTFTUUp2MXJmMEFMYjFzOEp0?=
 =?utf-8?B?LzhWbTUzNEo2NkdQcjc5NmZoUXJEWkNvUmNaSlJZT250Mzl1R3BEeFlvbHFx?=
 =?utf-8?B?L1pVMkZONEFCSzA0NFg5ZTJRK0RWckc5TDlSZWtEb3R0ZmU0N1dsbzl4VDI1?=
 =?utf-8?B?T0t5d0VqeWN3WUZWSFkyVjA2Q2lWYjRuL2FlZWlSMDRBS0pCNUZDYXlnOTZh?=
 =?utf-8?B?SXRsc1Z3d2k0a1BTei9BZ2JDdVQ3RGhZMmdsUjZpQ0M1ZzVKNmJOcmU3aUF3?=
 =?utf-8?B?OUlUL0RBMDE0MTBlWlhRUEZKZEphQkJ1RW0rOHdac29iWW1mOUQrSVFQTXBp?=
 =?utf-8?B?OVVLbkR6TXNSYmo3MTlzWjFyVUE2Y1hZOVVBcnVsNkF4bW5ZanVxN3hka2pZ?=
 =?utf-8?B?TlRJYlg4UThraUNvNllhU0ZSR3Zoc25OK2g0VTBOYXovZTdKMkpoZzRHS2Vv?=
 =?utf-8?B?R2NNSkN2OTZ5VDYrUGVhRnNHcy9jdXBZVkFab29VNm92a1ZrYnJ6aWozZGgv?=
 =?utf-8?B?VGhTS25BRktvQnY3UklxWDh4WGVNejZoM0pwQzVzS0daQ0g3LzFTQmsyK2pu?=
 =?utf-8?B?YTZaM2lQd2NrNXJmaFRBSVJYRC9tdmcxMWhWdVVQVFZxckZWTW9CdjROdzRX?=
 =?utf-8?B?MFhoZGxzSVdUaTZLVUM3MGdadSswUnZiMXRIdnowWGhMWTczSFE0S29QenlK?=
 =?utf-8?B?VWFFWlRZTUw3ZGxIT21FbzE4Rlc0c1pNc2ZGa1VESCtGcEk3SFp5QzZDYkdV?=
 =?utf-8?B?RXhsRURhVHJRUmZZYUxPUUNGV21JZFpzZE5rTnNMQUdHZy9UWkd4bkNXRzk3?=
 =?utf-8?B?TXdhREdod2cxTTZMR0tBeWVCbitXSndWMUxNWWJ6N2dPUzZKdFV0aE1teUNh?=
 =?utf-8?Q?OcSYwhZq3H47Qvc4nvUDEsc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c0d765-a44c-4fa9-2b76-08d9b0df988f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 13:21:03.1409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1XA7IYG+IyKYn2XBn5b+iK0ZtztlFvfeltY0hIbaAc9/UogHYBXsYcNtu95nPXdqPNC209gMXDlHD63yXn3fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KWWVhaCwgeW91IGFyZSByaWdodCwgSSBpZ25vcmVk
IHJhcyBpbml0aWFsaXphdGlvbiBmYWlsdXJlIGNhc2UsIHdpbGwgdXBkYXRlIHNvb24sIHRoYW5r
cy4NCg0KUmVnYXJkcywNClN0YW5sZXkNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hk
u7bkuro6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IOWPkemAgeaX
tumXtDogRnJpZGF5LCBOb3ZlbWJlciAyNiwgMjAyMSA5OjExIFBNDQo+IOaUtuS7tuS6ujogWWFu
ZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+Ow0KPiBa
aG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFt
ZC5jb20+Ow0KPiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IOS4u+mimDog
UkU6IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1OiBmaXggZGlzYWJsZSByYXMgZmVhdHVy
ZSBmYWlsZWQNCj4gd2hlbiB1bmxvYWQgZHJ2aWVyDQo+IA0KPiBbQU1EIE9mZmljaWFsIFVzZSBP
bmx5XQ0KPiANCj4gSSBzdXNwZWN0IGl0IGlzIHN0aWxsIG5lZWRlZCwgZXNwZWNpYWxseSB3aGVu
IGFtZGdwdV9yYXNfZmluaSBpcyB1c2VkIHRvIGRlYWwNCj4gd2l0aCByYXMgaW5pdGlhbGl6YXRp
b24gZmFpbHVyZSBpbiBwc3BfcmFzX2luaXRpYWxpemUuDQo+IA0KPiBSZWdhcmRzLA0KPiBIYXdr
aW5nDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZYW5nLCBTdGFu
bGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyNiwg
MjAyMSAyMTowOA0KPiBUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47
IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgQ2xlbWVudHMsIEpvaG4gPEpvaG4u
Q2xlbWVudHNAYW1kLmNvbT47DQo+IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGks
IENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47DQo+IENoYWksIFRob21hcyA8WWlQZW5nLkNo
YWlAYW1kLmNvbT4NCj4gU3ViamVjdDog5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2Ft
ZGdwdTogZml4IGRpc2FibGUgcmFzIGZlYXR1cmUNCj4gZmFpbGVkIHdoZW4gdW5sb2FkIGRydmll
cg0KPiANCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gDQo+IEl0J3Mgbm90IG5lY2Vzc2Fy
eSwgYmVjYXVzZSBiZWZvcmUgaHcgZmluaSwgYWxsIHJhcyBmZWF0dXJlcyBoYXZlIGJlZW4NCj4g
ZGlzYWJsZWQgYW5kIGNvbi0+ZmVhdHVyZXMgaXMgc2V0IHRvIHplcm8uDQo+IA0KPiBSZWdhcmRz
LA0KPiBTdGFubGV5DQo+ID4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiA+IOWPkeS7tuS6ujog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gPiDlj5HpgIHml7bpl7Q6
IEZyaWRheSwgTm92ZW1iZXIgMjYsIDIwMjEgODo1NyBQTQ0KPiA+IOaUtuS7tuS6ujogWWFuZywg
U3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBhbWQtDQo+ID4gZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47DQo+ID4g
WmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBh
bWQuY29tPjsNCj4gPiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+ID4g5oqE
6YCBOiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gPiDkuLvpopg6IFJF
OiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogZml4IGRpc2FibGUgcmFzIGZlYXR1cmUg
ZmFpbGVkDQo+ID4gd2hlbiB1bmxvYWQgZHJ2aWVyDQo+ID4NCj4gPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5XQ0KPiA+DQo+ID4gR29vZCBjYXRjaC4gV2Ugc3RpbGwgbmVlZCB0byByZWxlYXNlIHJh
cyBvYmplY3QgaW4gdGhlIGVuZC4gQW55IHJlYXNvbg0KPiA+IHRoZSBzZXF1ZW5jZSB3YXMgcmVt
b3ZlZD8NCj4gPg0KPiA+IEBAIC0yNTY0LDkgKzI1NjMsNiBAQCBpbnQgYW1kZ3B1X3Jhc19maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+DQo+ID4gIAlXQVJOKGNvbi0+ZmVhdHVy
ZXMsICJGZWF0dXJlIG1hc2sgaXMgbm90IGNsZWFyZWQiKTsNCj4gPg0KPiA+IC0JaWYgKGNvbi0+
ZmVhdHVyZXMpDQo+ID4gLQkJYW1kZ3B1X3Jhc19kaXNhYmxlX2FsbF9mZWF0dXJlcyhhZGV2LCAx
KTsNCj4gPiAtDQo+ID4gCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY29uLT5yYXNfY291bnRl
X2RlbGF5X3dvcmspOw0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBIYXdraW5nDQo+ID4NCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFN0YW5sZXkuWWFuZyA8U3Rhbmxl
eS5ZYW5nQGFtZC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyNiwgMjAyMSAxNzo0
OA0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcN
Cj4gPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4NCj4gPEpvaG4uQ2xl
bWVudHNAYW1kLmNvbT47DQo+ID4gWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwg
Q2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsNCj4gPiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5D
aGFpQGFtZC5jb20+DQo+ID4gQ2M6IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29t
Pg0KPiA+IFN1YmplY3Q6IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1OiBmaXggZGlzYWJs
ZSByYXMgZmVhdHVyZSBmYWlsZWQNCj4gPiB3aGVuIHVubG9hZCBkcnZpZXINCj4gPg0KPiA+IEZ1
bmN0aW9uIGFtZGdwdV9kZXZpY2VfZmluaV9odyBpcyBjYWxsZWQgYmVmb3JlIGFtZGdwdV9kZXZp
Y2VfZmluaV9zdywNCj4gPiBzbyByYXMgdGEgd2lsbCB1bmxvYWQgYmVmb3JlIHNlbmQgcmFzIGRp
c2FibGUgY29tbWFuZCwgcmFzIGRzaWFibGUNCj4gPiBvcGVyYXRpb24gbXVzdCBiZWZvcmUgaHcg
ZmluaS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5n
QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyB8IDUgKysrLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jICAgIHwgNCAtLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gaW5kZXggNzNlYzQ2MTQwZDY4Li5kNWU2NDJlOTAw
MTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+ID4gQEAgLTI4MzgsOCArMjgzOCw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9p
cF9maW5pKHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gIAlpZiAoYW1kZ3B1
X3NyaW92X3ZmKGFkZXYpICYmIGFkZXYtPnZpcnQucmFzX2luaXRfZG9uZSkNCj4gPiAgCQlhbWRn
cHVfdmlydF9yZWxlYXNlX3Jhc19lcnJfaGFuZGxlcl9kYXRhKGFkZXYpOw0KPiA+DQo+ID4gLQlh
bWRncHVfcmFzX3ByZV9maW5pKGFkZXYpOw0KPiA+IC0NCj4gPiAgCWlmIChhZGV2LT5nbWMueGdt
aS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKQ0KPiA+ICAJCWFtZGdwdV94Z21pX3JlbW92ZV9kZXZp
Y2UoYWRldik7DQo+ID4NCj4gPiBAQCAtMzk1OSw2ICszOTU3LDkgQEAgdm9pZCBhbWRncHVfZGV2
aWNlX2ZpbmlfaHcoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UNCj4gPiAqYWRldikNCj4gPg0KPiA+
ICAJYW1kZ3B1X2ZiZGV2X2ZpbmkoYWRldik7DQo+ID4NCj4gPiArCS8qIGRpc2FibGUgcmFzIGZl
YXR1cmUgbXVzdCBiZWZvcmUgaHcgZmluaSAqLw0KPiA+ICsJYW1kZ3B1X3Jhc19wcmVfZmluaShh
ZGV2KTsNCj4gPiArDQo+ID4gIAlhbWRncHVfZGV2aWNlX2lwX2ZpbmlfZWFybHkoYWRldik7DQo+
ID4NCj4gPiAgCWFtZGdwdV9pcnFfZmluaV9odyhhZGV2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBpbmRleCAzOWRmZDRkNTk4ODEuLjY1MTAy
ZDJhMGE5OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMNCj4gPiBAQCAtMjQ4NCw3ICsyNDg0LDYgQEAgdm9pZCBhbWRncHVfcmFzX2xhdGVfZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiA+ICphZGV2LA0KPiA+ICAJYW1kZ3B1X3Jhc19zeXNmc19y
ZW1vdmUoYWRldiwgcmFzX2Jsb2NrKTsNCj4gPiAgCWlmIChpaF9pbmZvLT5jYikNCj4gPiAgCQlh
bWRncHVfcmFzX2ludGVycnVwdF9yZW1vdmVfaGFuZGxlcihhZGV2LCBpaF9pbmZvKTsNCj4gPiAt
CWFtZGdwdV9yYXNfZmVhdHVyZV9lbmFibGUoYWRldiwgcmFzX2Jsb2NrLCAwKTsNCj4gPiAgfQ0K
PiA+DQo+ID4gIC8qIGRvIHNvbWUgaW5pdCB3b3JrIGFmdGVyIElQIGxhdGUgaW5pdCBhcyBkZXBl
bmRlbmNlLg0KPiA+IEBAIC0yNTY0LDkgKzI1NjMsNiBAQCBpbnQgYW1kZ3B1X3Jhc19maW5pKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+DQo+ID4gIAlXQVJOKGNvbi0+ZmVhdHVyZXMs
ICJGZWF0dXJlIG1hc2sgaXMgbm90IGNsZWFyZWQiKTsNCj4gPg0KPiA+IC0JaWYgKGNvbi0+ZmVh
dHVyZXMpDQo+ID4gLQkJYW1kZ3B1X3Jhc19kaXNhYmxlX2FsbF9mZWF0dXJlcyhhZGV2LCAxKTsN
Cj4gPiAtDQo+ID4gIAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvbi0+cmFzX2NvdW50ZV9k
ZWxheV93b3JrKTsNCj4gPg0KPiA+ICAJYW1kZ3B1X3Jhc19zZXRfY29udGV4dChhZGV2LCBOVUxM
KTsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0K
