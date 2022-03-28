Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0703C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 08:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A06A10E635;
	Mon, 28 Mar 2022 08:47:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74A910E635
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 08:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3hBdqGbNP61HdzTsixC/biwQFG3UzlC1z2WHdZL+eRKd/eAPK8DnakDtL6qEO484vTQUpzoEyFUvqs4JEoM0L0hTHBGRj/KtJUm1K8TZVSePxLP17vMF5I3C7KJ9yjEinrBHPmB75mEnX/HDzcB06JFMs40jxohqRCCorvpmoOltptPEOlAQzyKcBk39on/SeXyvhHJWmKj7KwqQlRS03WiApukOg6LwyeDoD6fiD5ijBcKrjFNgJ+6cqfS58lFoX1ve+cEkkhoLeEU9CTcWVT+yAXFspoRI2qlkS7ivoKLx6R+W60x3Xqh7XoRn2x/sWTQxrGvZ7p0GeRl+LdpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE7RlRlXI5U17QNPVhI4V+MpWcHHP6V3eAvVkaiAIn4=;
 b=DciCeBk5Bl5RGynZ3mPczXYA1+wL4XOrnSy9KCkLl1RSHnF6Dq6bZwHnYpjIgsY65Q09iwB72Utbb5C5PWm/M3CNmdjdefi6sxAHPQhihuvZ3MQL+BFD2++g62zhgnUJQWEzupyzGG5uhVDWyVhdB6c96X62gfA0/gdI8IOk6M5MP3BvzC+hlthRI2SKxCtiFBLdB2rz9drJSQ5FVmcGn/zKkJSapkbbE9lRxC1C2vMTIktz5rDGcylLXiAkoDVXzKVRq4zCyVZ8D7GSGagCBZklkIh897eESLT6K9mB+Yi8JIii9F86rHhZy5xio2U6Ctc5Kr3rKL9dJrvYy+yHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE7RlRlXI5U17QNPVhI4V+MpWcHHP6V3eAvVkaiAIn4=;
 b=CMs+j9SfnLxg7XE1j9/oEV//bqJnpmgjrjLsJUrOQPuUHk944YPPvovOaxIhVjNSvOF6gxl+oweW/Kx9jlkkp4Vl4K2f3kYlHP2tpV2cQpr3M1/BDyQpWDN9zlMKdaCPEEltm2GshlWBEC507YQrAQ3JCk9LhILHJDc+71QdLxo=
Received: from PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 by CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 08:47:29 +0000
Received: from PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::9cf6:6683:b92b:ae42]) by PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::9cf6:6683:b92b:ae42%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:47:29 +0000
From: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Thread-Topic: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Thread-Index: AQHYQmyab1uU8owgCUWioXdX2ewBnKzUaiWAgAACcgCAAACmUIAABACAgAAJzqA=
Date: Mon, 28 Mar 2022 08:47:29 +0000
Message-ID: <PH0PR12MB54519484FA4DFFBF63B0AE3C981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
 <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <3c80e4e5-97fc-9222-d9a3-f676125b0f5c@molgen.mpg.de>
 <PH0PR12MB545100117A4F02A2C98BCE0E981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <92b220d2-1d1b-c673-f9f9-3636dc1ba804@molgen.mpg.de>
In-Reply-To: <92b220d2-1d1b-c673-f9f9-3636dc1ba804@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T08:47:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cff74951-b09b-4cfc-a2ff-71954f4dc9d5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-28T08:47:26Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 78d4397d-e94e-43f4-a67d-c302ce14c316
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfac4f7c-5d85-4d0c-c0b0-08da10979794
x-ms-traffictypediagnostic: CH0PR12MB5089:EE_
x-microsoft-antispam-prvs: <CH0PR12MB508956DF0D9A75C8109E7AC4981D9@CH0PR12MB5089.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2xyeVxptJvB1MI66quTNjnnAAKdYz544k5e3ldKywMlIIE5vaKgdZZbgRQGq3KW3OmM8d494v7jIEGdT2mqc2ebn9922G12NdGS6M2/2UqN6JCEGgFswrX3BreUKPelN2dlVOjivUg0O7keWxzu4FwCxgVIvREnQnJfYZk367Sk96IzXaKAk8K0Fs0NUYF2j5QKfKVmy6sDnJ4kYJfdkskMMAPXpHmuxKHr8hTum2w53W/6BDvnnlFDa/JzOhR6xdPBZLY3rZQu5w6FScTVBgozCwO1yWvKb1/IKPELX51VJC8DpUE843BSPOcLvC2pZfPhpF6qa0YZhJAQCQ5H+JMWX2ERp3KztH5cU1v6z7GrEdXP96UjZytIRjz5e7se4rLE2LACiVzItjxAKddmIlAEJMWOCY35d+71wgm21pdHx/c8pLsnMW2TXizGTt5zUvPVndxngECjFY7WJGaLHBt0fPew98KpHuO2AM5/HWXblYX8q5KiEOzoobAbGzX5oystpa1X/M89JODvrNR4Zurwnm9NqLfcGHxcjwm5nLP0RTTG83PiFTvFOmJcIf7LflF3c3GylA+DpX+H/wnxdM4eGkiqlRZKqlVTSbzd0cnvnPuuBuq040lpPMXCP43Bl/EzdqHS9zSXr26Xg+NU6Og8dPFgyM8yXzO+6SOYDgHe4t5O3WwtlbcVyKe1bv/edG0xNz8cIRk/7Wmx9aRDOqB8Hk+ZRLGV1X4Rm3MfFR4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(66446008)(64756008)(9686003)(4326008)(2906002)(8676002)(52536014)(55236004)(122000001)(66476007)(38070700005)(55016003)(8936002)(5660300002)(6506007)(7696005)(83380400001)(6636002)(316002)(54906003)(110136005)(186003)(26005)(33656002)(38100700002)(76116006)(66556008)(66946007)(71200400001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHo5elA0RkxIM3pyU29IWHRCUEk1ZHVMcDdYZU1HL3FNeCs1Z3RGRXB5S00z?=
 =?utf-8?B?OFN6V1pqZXFpUnhtV1gxeDhNTnNyekxRSmVsU1VqZXZ6ZS9CYzV4MHQ4YWVJ?=
 =?utf-8?B?WUlLWlFPZVpEdGZtK1lzRlB4b2FqQUhxY2REQ3lYYitMSnB3ZGR2RVlVQXFV?=
 =?utf-8?B?NXR3SnFha2lLRnZXS1puaXNGVHhmSGhGMzhFcGVWL1RVbzJBYmloME5wRTdz?=
 =?utf-8?B?VXVFS2htU1FzY3RMaFhialhoSzB2TmdYaDZYVFVaSFVNNFN6Qm0ybko3eHAx?=
 =?utf-8?B?OFFEQ0dFUFg4VzRBOHdRL044YTNEa3dqczFIdnZGSXluc1QzQmczdEk2L1Zq?=
 =?utf-8?B?UzkvVkF1ajEvZFRjYlg5UFNLU3FIK0Y2WTdDb1BGMGthUlpZeUNHSnZHYndY?=
 =?utf-8?B?eTlhSmszWGRILzREQUhuRjdvcUEyb1loYjhLeU1YazEwZE1aNFFZZXdnYWho?=
 =?utf-8?B?Q2JrR1FWVlV2YWR1d00ycVpLYlRyejY3TllSTlRhNE8xbEVGMTk4dnNqdjVw?=
 =?utf-8?B?UWdqVWdpT3daTTRCQTJNams4bllYYVhyazdwdHNueng0OGVIK3lqNlh3SHB3?=
 =?utf-8?B?K0ZlV0VCb2NEVWV0TEUvTXFEU3VGekl6TEhWWGNRL1pSZ2RxZzg1RkM2bG9I?=
 =?utf-8?B?QjFRdEJzZ09zSEtiTGVvYUkyS3EwaFRSMjB3akVKQzV0SUViZjgvU3k1Smwr?=
 =?utf-8?B?L2xKZFNLSVIzejNxSE9zM0c0K3VTclNlOHN1TDkyOVQ4R2w4b05GRzZaWlha?=
 =?utf-8?B?bnFzZVVRMG9IRzVBd0FzU09vTUVyWXRudnlFRVZjWStFRkxXeksxVHhUTlc3?=
 =?utf-8?B?M3B6N0M0clF4VnFrM0VUMmxPaVJ3bkRaODg0UFlsN0dyWm5RMjcrdFMySHBk?=
 =?utf-8?B?R1NqdVR4bDE1ZEYxRkhCWjd5MzRFdUVRV05GdTFkQnN1Wi9BQnE3bWZzamMz?=
 =?utf-8?B?cmRvNzdDRkZxVUloN29GWWd2M3M0L2k3a0JlS3pBVnBUSWpma1VqNm56a0dE?=
 =?utf-8?B?WnA2cTE5SDBqb2I0TXdvaXBnbHJySERLN1VCT0toa0k0WGsvbU9Cd1hyN2xW?=
 =?utf-8?B?QzJwR3RlUzNXTkNJUTVtT3hLZ2dzY1Y1d3hSUElGblhQZ1pWYlFZZitXbzVu?=
 =?utf-8?B?L3o1NXVNQ0RFejFIS1VoS05OSWZ5MjRKcCt0TUFmTnNsYnVIV1lLVHR3SVZH?=
 =?utf-8?B?d1lBYXQxUjdQMzNEcUFBcnZUZVpwNi9vS0tmaHExUGovYjVpOXRlWGZXMXFQ?=
 =?utf-8?B?Zm92TDVGYU9QMnBpaHYxeHVVcXRzMFJYbyt0Wm5UZE9haE1abGJkakM5eEps?=
 =?utf-8?B?Rk4zMDZFRUhRWHcxV1NJeUNzak95NGM2NHZxQ3RsVzJNUzFvUVFuYU1seHE1?=
 =?utf-8?B?S3ZmamNWQ3BtVGR1Lzhndk9VenhnYnVnNzVtYmJuemFoa3JRNEd5SmxXdVlu?=
 =?utf-8?B?aE9JNjNxSWRZTUM4YzdOV05EeDJKZ2N4UnhLY00xaWZkbmhJT3VJVWU0WmpO?=
 =?utf-8?B?ZmlSZXpIS3RQTXpZcmNNaGFHNU5haXNXUjFGU1k4TTNXNU13cjhOYlQzRGty?=
 =?utf-8?B?MkNGeFczVkU5NkdtVzlxVEtIbkNwYk16YkQzeDNnekxDNS9WZEhIUkxJSE1z?=
 =?utf-8?B?UXJGWndIendRWm1velFEQnpPT3FQUmlVUUJlUjNMblkwNGF6U29oNDdZYkpR?=
 =?utf-8?B?cmNaZXE3bDlGZ1k3NlFGMlVmSTNGSzRocnVTMzhZY2F4eXA4ZjBKSklQSzgv?=
 =?utf-8?B?UVdQQ3R0Ui9DK3hkcFM4L1RJVGpJdi9aVTUzSHlFM045VTkvSStmdE5EQlpN?=
 =?utf-8?B?MEgrL3NhajVFcW9VMVgzdGpnM3lXU1hvNUR4am9SVHU4RzIwSkhGcTZjOERj?=
 =?utf-8?B?SkpvTDJSeS9KSmRCQU1KMFdxbkxkMUxSSzRoeW8vOE41M3NHa2s5cTJMUE5B?=
 =?utf-8?B?RFpnWXFUdG5TV0NIOHJndisvbmFXcndjZDBIVE5idzZ0YUliSUxWa1ZIL1Qx?=
 =?utf-8?B?NDNSaHBaY3VVMGNNOWpoek1jRncxM1dPaml4R2FPNTJGQmpyWXkrLzlZYWhN?=
 =?utf-8?B?cTZIZVpZL0tEKy9zRjN5Sk9xK09WN21xWDZoWWFRa3dCc1dicTdWYWFCdlZ1?=
 =?utf-8?B?MkxFbGlEL3dyaHRWL1JyNnlHYjZ5Z3NQTEdzdXJDY2NDNDYyMy9RcHRsbHI5?=
 =?utf-8?B?cHM2d3JWb2JOWlRCWk9RVG1kdmRCNTZQQkFGOU5KSnRvQlRScmtqenorT2t3?=
 =?utf-8?B?VjRyRnRGK3JYdFBQUjVVYnJ3dzZtbzY1U3pXWVJxMWM2cnVVWUFOZko4OXRE?=
 =?utf-8?Q?p1IPlIFUgrIfE4KB0j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac4f7c-5d85-4d0c-c0b0-08da10979794
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:47:29.4623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCxS7UnsNH5I7pVKi2OAdIeuyb7hJTEjMMDg2bU9TmZNY3JlCHmj7iIofQr1UHwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5089
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRGVhciBQYXVsLA0KDQpUaGFuayB5b3UgZm9yIHJl
dmlldy4gDQpDb21tZW50IGFkZGVkIGlubGluZS4NCg0KUmVnYXJkcywNClphZmFyDQoNCj4tLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdl
bi5tcGcuZGU+DQo+U2VudDogTW9uZGF5LCBNYXJjaCAyOCwgMjAyMiAxOjM5IFBNDQo+VG86IFpp
eWEsIE1vaGFtbWFkIHphZmFyIDxNb2hhbW1hZHphZmFyLlppeWFAYW1kLmNvbT47IFpob3UxLCBU
YW8NCj48VGFvLlpob3UxQGFtZC5jb20+DQo+Q2M6IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsDQo+SGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS82XSBkcm0v
YW1kZ3B1L3ZjbjogVkNOIHJhcyBlcnJvciBxdWVyeSBzdXBwb3J0DQo+DQo+RGVhciBNb2hhbW1h
ZCwNCj4NCj4NCj5BbSAyOC4wMy4yMiB1bSAxMDowMCBzY2hyaWViIFppeWEsIE1vaGFtbWFkIHph
ZmFyOg0KPg0KPlvigKZdDQo+DQo+Pj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2Vu
Lm1wZy5kZT4NCj4+PiBTZW50OiBNb25kYXksIE1hcmNoIDI4LCAyMDIyIDE6MjIgUE0NCj4NCj5b
4oCmXQ0KPg0KPj4+IFRhbywgaXTigJlzIGhhcmQgdG8gZmluZCB5b3VyIHJlcGx5IGluIHRoZSBx
dW90ZSwgYXMgdGhlIG1lc3NhZ2UgaXMgbm90DQo+Pj4gcXVvdGVkIGNvcnJlY3RseSAoPiBwcmVw
ZW5kZWQpLiBJcyBpdCBwb3NzaWJsZSB0byB1c2UgYSBkaWZmZXJlbnQgZW1haWwNCj5jbGllbnQ/
DQo+Pj4NCj4+Pg0KPj4+IEFtIDI4LjAzLjIyIHVtIDA5OjQzIHNjaHJpZWIgWmhvdTEsIFRhbzoN
Cj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogWml5YSwgTW9oYW1t
YWQgemFmYXIgPE1vaGFtbWFkemFmYXIuWml5YUBhbWQuY29tPg0KPj4+PiBTZW50OiBNb25kYXks
IE1hcmNoIDI4LCAyMDIyIDI6MjUgUE0NCj4NCj5b4oCmXQ0KPg0KPj4+PiArc3RhdGljIHVpbnQz
Ml90IHZjbl92Ml82X3F1ZXJ5X3BvaXNvbl9ieV9pbnN0YW5jZShzdHJ1Y3QNCj5hbWRncHVfZGV2
aWNlICphZGV2LA0KPj4+PiArCQkJdWludDMyX3QgaW5zdGFuY2UsIHVpbnQzMl90IHN1Yl9ibG9j
aykgew0KPj4+PiArCXVpbnQzMl90IHBvaXNvbl9zdGF0ID0gMCwgcmVnX3ZhbHVlID0gMDsNCj4+
Pj4gKw0KPj4+PiArCXN3aXRjaCAoc3ViX2Jsb2NrKSB7DQo+Pj4+ICsJY2FzZSBBTURHUFVfVkNO
X1YyXzZfVkNQVV9WQ09ERUM6DQo+Pj4+ICsJCXJlZ192YWx1ZSA9IFJSRUczMl9TT0MxNShWQ04s
IGluc3RhbmNlLA0KPm1tVVZEX1JBU19WQ1BVX1ZDT0RFQ19TVEFUVVMpOw0KPj4+PiArCQlwb2lz
b25fc3RhdCA9IFJFR19HRVRfRklFTEQocmVnX3ZhbHVlLA0KPlVWRF9SQVNfVkNQVV9WQ09ERUNf
U1RBVFVTLCBQT0lTT05FRF9QRik7DQo+Pj4+ICsJCWJyZWFrOw0KPj4+PiArCWRlZmF1bHQ6DQo+
Pj4+ICsJCWJyZWFrOw0KPj4+PiArCX07DQo+Pj4+ICsNCj4+Pj4gKwlpZiAocG9pc29uX3N0YXQp
DQo+Pj4+ICsJCWRldl9pbmZvKGFkZXYtPmRldiwgIlBvaXNvbiBkZXRlY3RlZCBpbiBWQ04lZCwN
Cj5zdWJfYmxvY2slZFxuIiwNCj4+Pj4gKwkJCWluc3RhbmNlLCBzdWJfYmxvY2spOw0KPj4+DQo+
Pj4gV2hhdCBzaG91bGQgYSB1c2VyIGRvIHdpdGggdGhhdCBpbmZvcm1hdGlvbj8gRmF1bHR5IGhh
cmR3YXJlLCDigKY/DQo+Pg0KPj4gW01vaGFtbWFkXTogVGhpcyBtZXNzYWdlIHdpbGwgaGVscCB0
byBpZGVudGlmeSB0aGUgZmF1bHR5IGhhcmR3YXJlLA0KPj4gdGhlIGhhcmR3YXJlIElEIHdpbGwg
YWxzbyBsb2cgYWxvbmcgd2l0aCBwb2lzb24sIGhlbHAgdG8gaWRlbnRpZnkNCj4+IGFtb25nIG11
bHRpcGxlIGhhcmR3YXJlIGluc3RhbGxlZCBvbiB0aGUgc3lzdGVtLg0KPg0KPlRoYW5rIHlvdSBm
b3IgY2xhcmlmeWluZy4gSWYgaXTigJlzIGluZGVlZCBmYXVsdHkgaGFyZHdhcmUsIHNob3VsZCB0
aGUgbG9nIGxldmVsIGJlDQo+aW5jcmVhc2VkIHRvIGJlIGFuIGVycm9yPyBLZWVwIGluIG1pbmQs
IHRoYXQgbm9ybWFsIGlnbm9yYW50IHVzZXJzIChsaWtlIG1lKQ0KPmFyZSByZWFkaW5nIHRoZSBt
ZXNzYWdlLCBhbmQgaXTigJlkIGJlIGdyZWF0IHRvIGd1aWRlIHRoZW0gYSBsaXR0bGUuIFRoZXkg
ZG8gbm90DQo+a25vdyB3aGF0IOKAnFBvaXNvbuKAnCBtZWFucyBJIGd1ZXNzLiBNYXliZToNCj4N
Cj5BIGhhcmR3YXJlIGNvcnJ1cHRpb24gd2FzIGZvdW5kIGluZGljYXRpbmcgdGhlIGRldmljZSBt
aWdodCBiZSBmYXVsdHkuDQo+KFBvaXNvbiBkZXRlY3RlZCBpbiBWQ04lZCwgc3ViX2Jsb2NrJWQp
XG4NCj4NCj4oS2VlcCBpbiBtaW5kLCBJIGRvIG5vdCBrbm93IGFueXRoaW5nIGFib3V0IFJBUy4p
DQoNCltNb2hhbW1hZF06IEl0IGlzIGFuIGVycm9yIGNvbmRpdGlvbiwgYnV0IHRoaXMgaXMganVz
dCBhbiBpbmZvcm1hdGlvbiBtZXNzYWdlIHdoaWNoIGNvdWxkIGhhdmUgYmVlbiBpZ25vcmVkIGFz
IHdlbGwgYmVjYXVzZSBWQ04ganVzdCBjb25zdW1lZCB0aGUgcG9pc29uLCBub3QgY3JlYXRlZC4N
Cg0KPg0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIHBvaXNvbl9zdGF0Ow0KPj4+PiArfQ0KPj4+PiAr
DQo+Pj4+ICtzdGF0aWMgYm9vbCB2Y25fdjJfNl9xdWVyeV9wb2lzb25fc3RhdHVzKHN0cnVjdCBh
bWRncHVfZGV2aWNlDQo+KmFkZXYpIHsNCj4+Pj4gKwl1aW50MzJfdCBpbnN0LCBzdWI7DQo+Pj4+
ICsJdWludDMyX3QgcG9pc29uX3N0YXQgPSAwOw0KPj4+PiArDQo+Pj4+ICsJZm9yIChpbnN0ID0g
MDsgaW5zdCA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7IGluc3QrKykNCj4+Pj4gKwkJZm9yIChz
dWIgPSAwOyBzdWIgPCBBTURHUFVfVkNOX1YyXzZfTUFYX1NVQl9CTE9DSzsNCj5zdWIrKykNCj4+
Pj4gKwkJCXBvaXNvbl9zdGF0ICs9DQo+Pj4+ICsJCQl2Y25fdjJfNl9xdWVyeV9wb2lzb25fYnlf
aW5zdGFuY2UoYWRldiwgaW5zdCwNCj5zdWIpOw0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIHBvaXNv
bl9zdGF0ID8gdHJ1ZSA6IGZhbHNlOw0KPj4+Pg0KPj4+PiBbVGFvXSBqdXN0IHdhbnQgdG8gY29u
ZmlybSB0aGUgbG9naWMsIGlmIHRoZSBQT0lTT05FRF9QRiBvZiBvbmUNCj4+Pj4gaW5zdGFuY2Ug
aXMgMQ0KPj4+IGFuZCBhbm90aGVyIGlzIDAsIHRoZSBwb2lzb25fc3RhdCBpcyB0cnVlLCBjb3Jy
ZWN0Pw0KPj4+PiBDYW4gd2UgYWRkIGEgcHJpbnQgbWVzc2FnZSBmb3IgdGhpcyBjYXNlPyBTYW1l
IHF1ZXN0aW9uIHRvIEpQRUcuDQo+Pg0KPj4gW01vaGFtbWFkXTogTWVzc2FnZSB3aWxsIGJlIHBy
aW50ZWQgb24gZnVuY3Rpb24gYmxvY2sgYWhlYWQgb2YgdGhlDQo+ZnVuY3Rpb24uDQo+Pg0KPj4+
IElzIHRoZSBgZGV2X2luZm9gIG1lc3NhZ2UgaW4gYHZjbl92Ml82X3F1ZXJ5X3BvaXNvbl9ieV9p
bnN0YW5jZSgpYA0KPj4+IGRvaW5nIHdoYXQgeW91IHdhbnQ/DQo+Pj4NCj4+PiBBbHNvLCBpbnN0
ZWFkIG9mIGBwb2lzb25fc3RhdCA/IHRydWUgOiBmYWxzZTtgIGEgY29tbW9uIHBhdHRlcm4gaXMN
Cj4+PiBgISFwb2lzb25fc3RhdGAgSSBiZWxpZXZlLg0KPg0KPlvigKZdDQo+DQo+PiBbTW9oYW1t
YWRdOiBOb3RlZCB0aGUgY2hhbmdlLiBXaWxsIG1ha2UgdG8gcmV0dXJuICEhcG9pc29uX3N0YXQg
PyB0cnVlDQo+PiA6IGZhbHNlOw0KPg0KPk5vLCBqdXN0DQo+DQo+ICAgICByZXR1cm4gISFwb2lz
b25fc3RhdDsNCg0KW01vaGFtbWFkXTogTm90ZWQuIEkgcmVhbGl6ZWQgISFwb2lzb25fc3RhdCAg
aXMgZW5vdWdoIGFmdGVyIHNlbmRpbmcgdGhlIHJlcGx5Lg0KPg0KPlvigKZdDQo+DQo+DQo+S2lu
ZCByZWdhcmRzLA0KPg0KPlBhdWwNCg==
