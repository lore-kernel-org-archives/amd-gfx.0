Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB9C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 07:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7F510E5FF;
	Tue, 23 Jan 2024 07:31:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8610210E5FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 07:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogE/agzI0DpyqhI/6niZt1N3VovqDreHkJuSfkyKjFRIG8e3dfl+NDd0m3GltUw0K51jI4fF8f0se//0BzVMwQHwbvz1TvCrZExsTIm0o4BNgK+d/zpvoA//c+Vh4C0hpGs5750GjXI8T84kb0Sk6shk/ngDPRpxBZodzM1NQURz9haenlqJu+/E32LTWL9CkCu3spfsG4UogkuU0MVGf4OkoJvvbU5LHiBEobCCZat3/8psC84pu74tzBIIknXlBQnCNmLN8IvU8ru++i6CYv0PHPRPtkLKGPTkeel+7D4Hm13CxPDfD/jgSFPTj3bxi5DJmQGqs+XVy1iZVzer6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lB90k4h1woMOrW53gnWyomnmAC8BQ9NsnZApRQKc1g=;
 b=Y5P48WqH9W6mbnaMbXwCTegIHp5UVfNfYckydSGiiwFJfT1Hn05ChEXevIId7xE83vXPmgSwZd6NDYMbCojeGQpKpelsoHOsJVAkbaS5KXH0eFu+k2c3d0Qbo3UHxGdhoNqv8RtpBZBw3gh/IRI20G/WMTZbKY+APwj4r+k/WZCj7vXJk8z7kOgQKJ4eicmgIKgKW2gUppAjwDvlyAzodAGYA4PGW7gr2qEVnWM9fv+Gf61cit7X/UdKDfshqBF1CwIpVI2zX/gQDwKNRpRH8IcN36QPdo4RBR4OHscXeUgIchMjhTJk9kXRbSsuca+mD9Hy1TxZyJ8JBDYyd2x54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lB90k4h1woMOrW53gnWyomnmAC8BQ9NsnZApRQKc1g=;
 b=2mFM7nGANwv8vnifRxWdOCM79A3RFta1B1iTCJyCmsX5feSz6K3auIAQfKFkA4VFbHqPdfx4nAVMebP7OJTK+uwHQLR4V6PrD1R5/SBkAk2Obq7lOZ70dcg9I11PI6Brs7S+SPrgafdNXdkMRQJ4yXf1EX8BnzSpwhWSjIw1Si0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 07:31:27 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 07:31:21 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix return type in
 'aca_bank_hwip_is_matched()'
Thread-Topic: [PATCH] drm/amdgpu: Fix return type in
 'aca_bank_hwip_is_matched()'
Thread-Index: AQHaTc2bmBOLbGWPEUKUiOEFvDTf8rDnAHBQ
Date: Tue, 23 Jan 2024 07:31:21 +0000
Message-ID: <PH7PR12MB5997C85327DD0BFF13DF604E82742@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240123072627.358019-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240123072627.358019-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e6aee2d-c5ae-4ed9-a951-2cc445a04bc7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-23T07:30:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA1PR12MB6650:EE_
x-ms-office365-filtering-correlation-id: 8a8e5c7b-e129-42d2-2103-08dc1be54c16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk3oksD7+e9V8FOD2zettD9Rc6/M1PWIV+xDPQljHMLMPmeZiDSO8GPHLS0OUUV2dOsqDqdpiKD4wI5pHmw/5hXQk8OLL80NDzS5Poarjc/ZkvwLOiOZ+qPfWnNpgW3SdttdUl3pFoSpKsVUILhblysD5s5eVJuAxDXJrKc6Di3WVivScVMu2Ye8TmbpXvCetC9+3CKZ/N9rQMnm2LyPrNSzz+slvvOj1P5uwubzVDNwtwbwppc43LDNAA29QqisYgF2T7DSrrGZi2wl5GvXWjbtk3eUkNBvlLif5AF8NKs2KqQH0Dw4p+qYcz6gOaDAa6OFyqnXPy5mRfYQQ/7rDKLH/yMiHWlNb7wvIi3WJjbJFxvuZVcgc08zv/LwyXA4O0hR3Kzi2vMlRf4Y2vp4zGS4S3+v5BrjzYZkjhJxz6oS8WfWfdvg0i/11JuOrp7wB2Cmu2Sr2n1+JGa9ZLDgUdNyUoJz2f5cWGOIMrT4z/Xm5/oV4g/OGf/DWikiCORbDv+HfFsWMJnP5rWeCXej/pqNndQQLpec+SeMt3K1Z6ctrEWLzYFc6YrU3ZapUpXDTttyFzDzRvJUK3z5HLqZLZS99CYu4oi14IAZ/XKQG+mfPD4Xw8JwkYPjcImNCNKd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66574015)(71200400001)(26005)(6506007)(7696005)(53546011)(9686003)(38100700002)(83380400001)(64756008)(5660300002)(2906002)(41300700001)(38070700009)(478600001)(52536014)(54906003)(4326008)(66476007)(66946007)(66446008)(8936002)(76116006)(8676002)(110136005)(316002)(6636002)(66556008)(33656002)(122000001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkJqWVBSSENYL1VBUnVzbWNVRjFkbE03R0FTWGZHS0kzZVB6OHpzc0xKam5J?=
 =?utf-8?B?d0ZZOFBGUU1pSDhmYlNYNVFLTjh0Q3ltUExUUkdKdXVXbWJlQlExanRua3k1?=
 =?utf-8?B?RHRHVFVmYzNlenY1dXJsUHhLSVI3TldhbVNURnNDWFBhc2kvRTV0NjdkcEZR?=
 =?utf-8?B?ZmtJNDVPVThKaVZ1aWRBYSt0VldTN3FDeld3V01lTWFFbmhsNDlYaExpOTNQ?=
 =?utf-8?B?SmcycnFwSDN0YXMveThLVGM4NUZZQ3FDK2EwZ2VkR2JnbkQ3UXNYdXY1eE12?=
 =?utf-8?B?VWtCUTRmK2RiMm02WXhXZ3VIcWdxdVF0bktxTWphSUhvNzlDWC90VzFzaHc3?=
 =?utf-8?B?QTFZbHpvc0dPQXh1NEQ0NXh6cmlDTzJRMjgyN3NzMXN4RmI3MHdXa3k1NUNy?=
 =?utf-8?B?TTluYjl4ZGNxSWh4V2Q5cnd2MGhJWEhhS0ZRZVJMNi9tU2RscER3LzdxRVhJ?=
 =?utf-8?B?T2VaUmFqZnNEU3Q5MFplSXIvS3g2bE5OWlNmOU51ZWJwOVRhQTFUSllxRUdt?=
 =?utf-8?B?WHBEUk5pY2p2ZVFKSFpuRGR5R2ptSEJMWFVxMEhQdWdYSTE3aDQ5aHZYK3Bj?=
 =?utf-8?B?QThKNkJMQ2NZTGdoR3hjcXVjVzBpSEJKVll0cXdweHRVTmZRYXZyY3cwNVlD?=
 =?utf-8?B?VmZPWEhpSmxlWkNXWkVZRW9ZbWUxbGM2MVIwb0ZKU0tZeTVHS0N3a0syb3RF?=
 =?utf-8?B?V1dSSWcvbWVVVTQxOWQzRkNvbVhkSUZ5SlI5WFNjV1drSHdFa2FMSzJDSHRZ?=
 =?utf-8?B?NWEvaTJWdFlWMmFUZ0xkRDA5WTVYUitnaWxxRFQzRmhSUWpzNVQwT2JFRDYz?=
 =?utf-8?B?QWJtWm5oTnpGZm9kY3BPbmtGaUVDYlN6NTBvbzNONXhwNUpQWHRRZkRLTG1S?=
 =?utf-8?B?d2craVBhU3QxRXdidUtxVTJuTitqZkU2SC9qNkN0MWhsQ3FGNnU4R3J1Z2pv?=
 =?utf-8?B?WE9vZFNHL2I5eWVxY3pHSHJMWjg0WVNhdXF0Q0taMXRESkFaSlBKNFdINitD?=
 =?utf-8?B?MUNlRWpKaGpORkhMNTJGSlM5NWZHQzlDRy95L096STMzZ1NJejE1RWd0WFJO?=
 =?utf-8?B?MFBCYzh2L1JBQzUyNEJMNVBmN2tCZWI5UlhBaW5Tb2VENC8vSFI5bVBmU1lB?=
 =?utf-8?B?OXNWaGpDK0dFdGJ4RWN3Yk9Fc2pBdGFxTlpvSTNjRFhMWk1lbFlCa2htTmlj?=
 =?utf-8?B?VHA5eU1EMGJleEN5WldVL0ZjZTVuRE9ldy9SRVM3WXJaTEQ4aTIvMHYrbmFN?=
 =?utf-8?B?YU5rK251ZCs0cDRmUkE3RXNMbFcvZFVZVkhxN2pYTVFQNGQ2K0R4VmFCby9x?=
 =?utf-8?B?YWdqSXFBMUp0S0xQUHBIRE40c3lNOC8yR3dlWWU1Sm90RWRDSFlnZUZqc25a?=
 =?utf-8?B?TkJkdjAvOUZnKzdRNEZ4d2pMOWYzSmhoZGJ4dVFzQ0s2b3FxcVBOeDluaHIv?=
 =?utf-8?B?NVZ0TFJUcDc5R3cyZ2hadnI1bXV1TUlmUEM0UWVWQWQxQThlWElzMlJQeDJQ?=
 =?utf-8?B?RVVhSkpkT0poRWZGQXhVb2lWZkZ3dU05bFZmSXdvdmQxd0pMKzNiblhmdFpU?=
 =?utf-8?B?R2h5ZHYyTEFXdkgzN0ZkMzhLeXZzaHpxSkhGVHIwcC9hWnJxOXdQSUpvZ3hz?=
 =?utf-8?B?amZXcVpENjIySVQwWERnbVo3MXNnOGU4Tjl5QmhFbUFnYzRFT2NPd3V3VFJM?=
 =?utf-8?B?b1FXYWx2bGNKUTdzK0JRUkVZWGZhMUJ0czVJK0FzTVYrNnljTSt4cktNT01M?=
 =?utf-8?B?Y2Erc000TWV0TnlYUHlUTFRMRzdpdnU0eDJYRndqQVVUK05HOWFCNUNLMWVw?=
 =?utf-8?B?dUFmYnJ1Wmord1RwbUorM1ozb1R0U2E5YmFmMEFMelhqZHAxeWNHNUFaU3lx?=
 =?utf-8?B?MGpsK0ZyY1hLMnUyd1gxTTdQb1R2c05xdnNJcVNhN1J3UStMVXJjMk1XOUtz?=
 =?utf-8?B?aUxzNG0wVEUwSjV1TzBYcFp6QmkycEhYellpYjJLSDdjVGJKMFdvVEd2VHlI?=
 =?utf-8?B?SHRXdUVUZjRldkRMSVJHR3FMU1FSTUMzakx0RzRLUERySE1pclpmNndVNlhq?=
 =?utf-8?B?MUhHcmhMUW1GZU1hZkRPWnNPc3JmN2k2TnEyRDRGeW8wdVZWV3dqMnVzaGUy?=
 =?utf-8?Q?BHWg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8e5c7b-e129-42d2-2103-08dc1be54c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 07:31:21.6982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zz64vtYadePPxM9nss32uf0mQa0HuBz/f44P3Nykd2GjlocVmSY4joNLOZLfr7jd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcywNCg0KUmV2aWV3ZWQt
Ynk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0K
S2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNIQU5NVUdBTSwgU1JJ
TklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEph
bnVhcnkgMjMsIDIwMjQgMzoyNiBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJ
TklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4p
IDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IHJldHVybiB0eXBlIGlu
ICdhY2FfYmFua19od2lwX2lzX21hdGNoZWQoKScNCg0KQ2hhbmdlIHRoZSByZXR1cm4gdHlwZSBv
ZiAiaWYgKCFiYW5rIHx8IHR5cGUgPT0gQUNBX0hXSVBfVFlQRV9VTktOT1cpIg0KdG8gYmUgYm9v
bCBpbnN0ZWFkIG9mIGludC4NCg0KRml4ZXMgdGhlIGJlbG93Og0KZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FjYS5jOjE4NSBhY2FfYmFua19od2lwX2lzX21hdGNoZWQoKSB3YXJu
OiBzaWduZWRuZXNzIGJ1ZyByZXR1cm5pbmcgJygtMjIpJw0KDQpDYzogWWFuZyBXYW5nIDxrZXZp
bnlhbmcud2FuZ0BhbWQuY29tPg0KQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1k
LmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVkLW9mZi1i
eTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQot
LS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNhLmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNhLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYWNhLmMNCmluZGV4IDhhM2MzYTQ5NDE1ZC4uZDI2NjJmNGQz
ZDc1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjYS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNhLmMNCkBAIC0xODIs
NyArMTgyLDcgQEAgc3RhdGljIGJvb2wgYWNhX2JhbmtfaHdpcF9pc19tYXRjaGVkKHN0cnVjdCBh
Y2FfYmFuayAqYmFuaywgZW51bSBhY2FfaHdpcF90eXBlIHQNCiAgICAgICAgdTY0IGlwaWQ7DQoN
CiAgICAgICAgaWYgKCFiYW5rIHx8IHR5cGUgPT0gQUNBX0hXSVBfVFlQRV9VTktOT1cpDQotICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KDQogICAgICAgIGh3aXAgPSAmYWNhX2h3aWRfbWNhdHlwZXNbdHlwZV07DQogICAgICAgIGlm
ICghaHdpcC0+aHdpZCkNCi0tDQoyLjM0LjENCg0K
