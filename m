Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655CC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 14:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FF18D707;
	Mon, 18 Jul 2022 14:44:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88948D701
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 14:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYRHLV0YbfXmDtg+qG3oGqVu/6SpdWJ+pApmKvdIsy4m/rKln4lZ+qAEiq6Ej0PAHsE5XAAal0nlCVwhcCM30TlhTHISSuXmq4DLb3tcV2i4jp4RoW9fcyO3ZN6BAVJagq6eNoaqjocLd67/m1A9FIL0tsBkKNnE1DDDOX/IWLV2OoJWuCuFXMWi5y/1YPD/MBA0xFaRj/zWMcxCHiAzcEUl9sHKGe8uY1QvrezBgn/h4XEckfKYKZQqODmpCFfsjSRE62CNdnM8HSbRwSzQ6JWjGqSFrvyTiYyESVSWjYrrQV7JrDO0eOmdLQYfffDiPqMljGnEAVteDOTWy4OttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj+5hLZkA+4XleoUZovK+WLdVyurArlsezicQ9CHeHM=;
 b=KDAW+ZT3/Gb+FEP+BbDkxWC5U68apEXSClK0+Pxlzs7SKkE6Fc8kTSxrAMbkpcGTPRiNfH0oeodhBjoyinVfcBX7m9i8eCsMaa+zDhQW5NY0MLq01Kb4JzQDNx8iqmQqC1EocrESS5tKC63pLCxARpZ+WKEted91UZw315e08N1R6IgBLXqD5HFZE7+o0IRwoSTWnxs+7Rnv/NuQvPX8V3LEZ5sE/xilIKEJFTvk3N0bhXvtZ47hdhOqEzna8TWJuzLVzh0tYratbYn24vrELttQHYKYIjaMUlVxcrcFHIyCAjZ2RsB3lBHUUA5HK5o7tE665ufd3GxIJC26/vepyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj+5hLZkA+4XleoUZovK+WLdVyurArlsezicQ9CHeHM=;
 b=1f7b5IdObd+GH+UX09TbOMnz3cqSuYhc1QdoTDXT1ZTUyHs3lATlDgxQw71q2ZUveUiJMcqwj5uK6t47Pa7/H6h8aDsC9nK6BacuVSs2W3tpceIGbzCoPTusOLKw6R8lv+jT7bKR/2IT7IadY5WRcFfwRjjB5VhIPeZk63PTtYc=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 18 Jul
 2022 14:44:39 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:44:39 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Topic: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Index: AQHYmIYVYr2zSI2ZiUqf3I0W/7KGq62Dtl2AgABytwCAAAGaAIAAAWlAgAAKogCAAAC6cA==
Date: Mon, 18 Jul 2022 14:44:39 +0000
Message-ID: <SJ1PR12MB6194E007838F098AB5A59D4C958C9@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20220715200410.301438-1-ruijing.dong@amd.com>
 <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
 <7beb798d-73ba-7015-7b3d-441a5daef26f@amd.com>
 <4f91384a-bef6-b8da-77c1-0bd5f4e7b3c1@amd.com>
 <SJ1PR12MB61946514C9D9B9DF87C9CF06958C9@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <1126fff2-0896-1002-be28-5eb0a83beed5@amd.com>
In-Reply-To: <1126fff2-0896-1002-be28-5eb0a83beed5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d311520e-2f78-4b6c-ae45-184505b2b8fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-18T14:39:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28344c2b-ea0d-476f-899d-08da68cc0ae5
x-ms-traffictypediagnostic: PH7PR12MB6444:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWqMvFbMIJ1cl0aq3aUWDZqhjkxVde4mW4KsANANl4LNx1E+R6yf6EGHHHZ4ZD0pCLK71L5IqxcZz8i3qcGfGVitFvXPQYCWp8roOZJb2o6lAUfGnn5mxZhJUonWaH14n3VsVgS7RQRGyZ/DhSxWo6fvikozwuA/OCp0i+vLF5Nf3swl6N/HjZ5r85KtomeUErzqmfGiOW+LTWqvOAZTf432/DYpQG84Us/oVWLdcviO4nQstayGgMKR9VpOOh85Sa9FSBp9gvKSvbEN0ZLXtDMXQAwpOzU1c6dCB/zFp0qgINwZayAbejpYxPGNQVnqRsJB+hKExaM0GyYQAElX52Uw/TnJbRtDNxMrPRw7Oo9D+8STo1biXF3t7ATgw23nlew/rZ7RTAiE1OnhvgjuJG5XrcUmOLuofIBp+citqA9hC461vfigbBdcufHPqz6nVfKcgZYmiSVP4f8lWk5eVMVMdfygpoCSl1TVC6/cycCwa26kgwPFbFZroPJYqGmyRO5cBctvWV9piYDDG3Zfz4v9VBzPhC9x+gpNXn+04Z8t6W24dN/rq/Tu0yBycHxluauGBKqzGvELrVANpqE/CVW96WMCJbGX1+tZXWhxl3axvrK4IwZCpqCRkQkZ2OEU80NNQmb7SZShFUBBAhF5VORhN9Ul3oYw04KxEUzholpFEPjhDu4ViIexdKwvSwQqwSJgo8j24ljGCDeAh434KyKDai8cxlvLp11gLl4MOfsgYbSvP/n4dZ861nRwweN9DxSV8m9pmjDSkBdJQCu4Cw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(66574015)(66556008)(9686003)(2906002)(53546011)(5660300002)(8936002)(966005)(66946007)(4326008)(33656002)(64756008)(83380400001)(41300700001)(122000001)(66476007)(71200400001)(76116006)(26005)(7696005)(316002)(86362001)(6506007)(66446008)(52536014)(478600001)(55016003)(38070700005)(8676002)(38100700002)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFDL0djY3RSRmVtRVJ2b2cxN3hlK010SVhGdmxmd1ZYVFZaY0poZmIva3ZI?=
 =?utf-8?B?SjdHdjdoQWc4WS96T00vMGpkQ2ZEOW5hUnNjWXJMREVycmlsVzVnNzg2SjFr?=
 =?utf-8?B?dXA5RlA2Rll6bFI4WUxZTjhqNFRpVTQ4M1o2WU9TYjQ1S2UwVkxLNXFXK2hx?=
 =?utf-8?B?dldycXRta1h1eHpwOVl0MjN6R0I3N0J1U041dzkvNVpDTjFmdWZta3NEREh5?=
 =?utf-8?B?R0d5YVR5RHlDTkR4SHBRcUU3Rlc5Yjl0TjZGNnRTc3l1MkxncnRPNHlsdklS?=
 =?utf-8?B?UFROWWNvRTdCYVFQNXdnTGs4VDhYOUlaUVlpZVJZZHJ4S2Q2Yjh5ZUVWUndH?=
 =?utf-8?B?TUZOMnNmTnlia0ZJNGpNalAxeURtOXBkWnFHSE9xRFNQUFJVSjl5N3JHY0h1?=
 =?utf-8?B?TFJKQXB3T1dDdFdWZENaakZnUzZHRFB2WXFFN0s3QURjWVdqVm5JL3FVem5H?=
 =?utf-8?B?KzRCQTIxV1o3QTJsaTA3SnZsWEwxV205Q3hjclJ3UDAvUW5Ka0ZNV05xV0pr?=
 =?utf-8?B?STJaSGZnaHd2cTVaZElRa3VwcE5UeDRXVTA2UFRLc2FjaDZXdVRuUlpMbTZC?=
 =?utf-8?B?MVdGOFpCR3BSTXVTR1h4a3hhVVp3TEFremsvTFcrbk8xWkVZVGU0S0ltUHhI?=
 =?utf-8?B?RUdIR0p5QlBEbTdXSzFtMkJMYmVHWEkxL0pETkJjZW5WQ1FnM0hUL2tyZEF2?=
 =?utf-8?B?VEppeHpZOExXTmtvNDR3ajVyVmZ5SEkvWC9KaHBWdmIwUUFtRkZrU3ZialRS?=
 =?utf-8?B?NVQzaExKcFovd2RSYlRvVWRtOCtKVTJrZElqUzhwTE9OcTVWN1dsTU9FZFdU?=
 =?utf-8?B?azBzUVAyejZGMk9YUnJMQ2owdHVhSk1ZNVBrcnNjOHdjc2pIVUNJcTFZYlVi?=
 =?utf-8?B?dXFLZDJjazdRMytxY3pLZ05UckN3WlVVNWY0Qmcyd3Z5dEx0SGFyamsxRkFs?=
 =?utf-8?B?UGk5cENaUFZZZ01iV08ycDNZOFRma00vUFlyaDRyYkl2NzFQWGJDdkl2QzR2?=
 =?utf-8?B?WTFzemhiTzFUUjJJcU1QSGlmRExvSjZHaGJHbW5Uc0pCaENYanI5MzVhYW1r?=
 =?utf-8?B?KzFnQnRXbWhwYldCbk4wcVBNQU11eEJUODZ5M2dYN2ZLa01SbGV6ODEvYW5z?=
 =?utf-8?B?UXFJZnFodmlQa3IyWkw5SXpmL0lSNjQwYmwzUnpKcUtpTDFXcVJwNmVFK0xZ?=
 =?utf-8?B?Mi9ST1BLYUpEaFNZblp2ejl3d0plSnJJK3hNSWtvVmdWZEpJRnNxVm9qNFdy?=
 =?utf-8?B?NnUwaHVxd2NILzdXbitWNTd4dDRERXVDMXVtOGhoaGNGK1l6WW13dkxYQWQ3?=
 =?utf-8?B?TFY0cHJsQTRoZ0ZmSUVIWTI2VGtwNkxDMlhyamgrSG91ZkdFclZrVkY2SkFs?=
 =?utf-8?B?WUIrdlc3RzVVQUxUWjY5aTVWdTBuVDhtRFpMUVpFc1RjTWgzcWdlVGRaMmhM?=
 =?utf-8?B?alhabDh3ZjVDVXh4SzEwTlVFcHRtVEdGZW04T0NsSUcvNkhVMWF5eGw5dmQ5?=
 =?utf-8?B?S1FnK0hvMGFwRUg5LzZJQWJ0ck45VG9zWmd5MzR3YjViTllLOWt6Sy9mby9s?=
 =?utf-8?B?TjVFVzF5WVZqa2NKMXF0ZVEwWExzUk9YUkNQaXh1Q3J5M2pDZEllQ1Bka3Y0?=
 =?utf-8?B?Vm1Gb1I3M0dWWHA0S2FpV0NqcHpodGhRRlZlZ1QvenllOUV0Sy9NYnZvNzZH?=
 =?utf-8?B?aDdHdnYxMUVueE1xZGxGMHZmQTBMTnlLbGVVQlVIN0RLUTFtbWJaM00vN3Jo?=
 =?utf-8?B?M0MrT3BiOEJqalVGYWdyN2tLeHBIWjhMcHAvVU5BSnBwQUpnQmJCa2s2YUN0?=
 =?utf-8?B?dVBjM3ZMZTVudDVSSExGdG5tTG51bHY4NDhGSk9mbTNrTHlKeElqcEowMEtK?=
 =?utf-8?B?bGhrcUx1d0g5YWVlc0Nzd0gzdXBuSi9iYS9GZlBIR0lMdE9VMlBTSGZCTXFV?=
 =?utf-8?B?aFducDJJeFBTVTVvZWZPQ0loRHkzRzEzODgxRDY3MUkvWUZzZS82dW1oYWxk?=
 =?utf-8?B?VnpRTTArWEhsWDN2cGc0NXZyNWo3VXprQS9wWHc5RGdadjJFb21VN3BXbGtG?=
 =?utf-8?B?NWVhU2pza3o2OFBlL0Mvb1QrTkJuWk81OTh4Y3B5ZEhDYi9ydjNOelFrTUxv?=
 =?utf-8?Q?TDiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28344c2b-ea0d-476f-899d-08da68cc0ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 14:44:39.1153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBWLg2aC3wpBgND1QsFkNxqIdfzgan23l59gSOZhZwhP5UVLNgEj+OxHc7JwmGM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk5vLCB3ZSBkb24ndCBwbGFuIHRv
IGNsb25lIGFub3RoZXIgb25lLiAgSSB3aWxsIG1vZGlmeSB0aGUgY29tbWVudCBvbmx5IGFuZCBy
ZW1vdmUgdGhlIGJpYXMuDQoNClRoYW5rcw0KUnVpamluZw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4NClNlbnQ6IE1vbmRheSwgSnVseSAxOCwgMjAyMiAxMDozNyBBTQ0KVG86IERvbmcsIFJ1aWpp
bmcgPFJ1aWppbmcuRG9uZ0BhbWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gZHJtL2FtZGdw
dTogYWRkIEhXX0lQX1ZDTl9VTklGSUVEIHR5cGUNCg0KQW0gMTguMDcuMjIgdW0gMTY6MTQgc2No
cmllYiBEb25nLCBSdWlqaW5nOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0N
Cj4NCj4+PiBXaGF0IGhhcHBlbmVkIGlzIHRoYXQgdGhlIGVuY29kZSByaW5nIHdhcyBleHRlbmRl
ZCB3aXRoIGRlY29kZSBmdW5jdGlvbmFsaXR5LiBJbiBvdGhlciB3b3JkcyB3ZSBzdGlsbCB1c2Ug
dGhlIHNhbWUgZm9ybWF0IGZvciBlbmNvZGluZywgd2UganVzdCBhZGRlZCBhbm90aGVyIG9uZSBm
b3IgZGVjb2RpbmcgYXMgd2VsbC4NCj4gSnVzdCB0byBjbGFyaWZ5IHRoZSBmb3JtYXQgZGlmZmVy
ZW5jZSBiZXR3ZWVuIGxlZ2FjeSBlbmNvZGluZyBhbmQgdW5pZmllZCBxdWV1ZSwgd2UgY2FuIGRv
IGVpdGhlciB3YXkgaW4gdGhlIGNvZGUuDQo+DQo+IFVuaWZpZWQgcXVldWUgcmVxdWlyZXMgYSBk
aWZmZXJlbnQgZm9ybWF0LiBUaGUgb3JpZ2luYWwgZW5jb2RpbmcvZGVjb2RpbmcgZm9ybWF0IGNh
bm5vdCBiZSB1c2VkIGluIHVuaWZpZWQgcXVldWUsIHdoaWNoIHJlcXVpcmVzIHRvIGhhdmUgdHdv
IG5ldyBoZWFkZXJzLCAiZW5naW5lIGluZm8iIHRvIGluZGljYXRlIHRoZSBjb21pbmcgSUIgcGFj
a2FnZSB0eXBlLCBlbmNvZGluZyBvciBkZWNvZGluZzsgYW5kIHRoZSAic2lnbmF0dXJlIGhlYWRl
ciIgdG8gZ3VhcmFudGVlIHRoZSBjb21pbmcgSUIgcGFja2FnZSdzIGludGVncml0eSwgaWYgdGhp
cyBmYWlsZWQsIHRoZSB3aG9sZSBJQiBwYWNrYWdlIHdpbGwgYmUgZGlzY2FyZGVkIGJ5IFZDTiBG
Vy4gVGhhdCBpcyB3aHkgSSB3YXMgdGhpbmtpbmcgdG8gaGF2ZSBhIGJpYXMgb2YgQU1ER1BVX0hX
X0lQX1ZDTl9FTkMgY291bGQgYmUgYmV0dGVyIGluIHRoZSBmdXR1cmUuDQoNClllYWgsIGJ1dCB0
aGUgcmVtYWluaW5nIHBhY2tldCBmb3JtYXQgaXMgdGhlIHNhbWUuIEFuZCBhcyBmYXIgYXMgSSBr
bm93IHlvdSBndXlzIGRvbid0IHBsYW4gZG8gY2xvbmUgdGhhdCBmb3Igc29tZSByZWFzb24sIGRv
bid0IHlvdT8NCg0KQWRkaW5nIGFub3RoZXIgbmFtZSBmb3IgdGhlIHNhbWUgZW51bSB2YWx1ZSBj
YW4gcG90ZW50aWFsbHkgYmUgbXVjaCBtb3JlIGNvbmZ1c2luZyB0aGFuIHRoZSBmYWN0IHRoYXQg
dGhlIGVuY29kZSByaW5nIG5vdyB0YWtlcyBhIGJ1bmNoIG9mIG1vcmUgY29tbWFuZHMgdG8gZG8g
Ym90aCBlbmNvZGluZyBhbmQgZGVjb2RpbmcuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4N
Cj4gVGhhbmtzLA0KPiBSdWlqaW5nDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNl
bnQ6IE1vbmRheSwgSnVseSAxOCwgMjAyMiA5OjU0IEFNDQo+IFRvOiBMaXUsIExlbyA8TGVvLkxp
dUBhbWQuY29tPjsgRG9uZywgUnVpamluZyA8UnVpamluZy5Eb25nQGFtZC5jb20+Ow0KPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBkcm0vYW1k
Z3B1OiBhZGQgSFdfSVBfVkNOX1VOSUZJRUQgdHlwZQ0KPg0KPiBBbSAxOC4wNy4yMiB1bSAxNTo0
OCBzY2hyaWViIExlbyBMaXU6DQo+PiBPbiAyMDIyLTA3LTE4IDAyOjU3LCBDaHJpc3RpYW4gS8O2
bmlnIHdyb3RlOg0KPj4+IEFtIDE1LjA3LjIyIHVtIDIyOjA0IHNjaHJpZWIgUnVpamluZyBEb25n
Og0KPj4+PiAgIEZyb20gVkNONCwgQU1ER1BVX0hXX0lQX1ZDTl9VTklGSUVEIGlzIHVzZWQgdG8g
c3VwcG9ydCBib3RoDQo+Pj4+IGVuY29kaW5nIGFuZCBkZWNvZGluZyBqb2JzLCBpdCByZS11c2Vz
IHRoZSBzYW1lIHF1ZXVlIG51bWJlciBvZg0KPj4+PiBBTURHUFVfSFdfSVBfVkNOX0VOQy4NCj4+
Pj4NCj4+Pj4gbGluazoNCj4+Pj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL21lc2Ev
ZHJtLy0vbWVyZ2VfcmVxdWVzdHMvMjQ1L2NvbW1pdA0KPj4+PiBzDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFJ1aWppbmcgRG9uZyA8cnVpamluZy5kb25nQGFtZC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiAgICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8IDYgKysrKysrDQo+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+Pj4+IGIvaW5jbHVkZS91YXBpL2RybS9h
bWRncHVfZHJtLmggaW5kZXggMThkMzI0NmQ2MzZlLi5lMjY4Y2QzY2RiMTINCj4+Pj4gMTAwNjQ0
DQo+Pj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+Pj4+ICsrKyBiL2lu
Y2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+Pj4+IEBAIC01NjAsNiArNTYwLDEyIEBAIHN0
cnVjdCBkcm1fYW1kZ3B1X2dlbV92YSB7DQo+Pj4+ICAgICNkZWZpbmUgQU1ER1BVX0hXX0lQX1VW
RF9FTkMgICAgICA1DQo+Pj4+ICAgICNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9ERUMgICAgICA2
DQo+Pj4+ICAgICNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9FTkMgICAgICA3DQo+Pj4+ICsvKioN
Cj4+PiBQbGVhc2UgZG9uJ3QgdXNlICIvKioiIGhlcmUsIHRoYXQgaXMgYmFkbHkgZm9ybWF0ZWQg
Zm9yIGEga2VybmVsZG9jDQo+Pj4gY29tbWVudC4NCj4+Pg0KPj4+PiArICogRnJvbSBWQ040LCBB
TURHUFVfSFdfSVBfVkNOX1VOSUZJRUQgaXMgdXNlZCB0byBzdXBwb3J0DQo+Pj4+ICsgKiBib3Ro
IGVuY29kaW5nIGFuZCBkZWNvZGluZyBqb2JzLCBpdCByZS11c2VzIHRoZSBzYW1lDQo+Pj4+ICsg
KiBxdWV1ZSBudW1iZXIgb2YgQU1ER1BVX0hXX0lQX1ZDTl9FTkMuDQo+Pj4+ICsgKi8NCj4+Pj4g
KyNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9VTklGSUVEICBBTURHUFVfSFdfSVBfVkNOX0VOQw0K
Pj4+IEknbSBzdGlsbCBpbiBkb3VidCB0aGF0IGFkZGluZyBhbm90aGVyIGRlZmluZSB3aXRoIHRo
ZSBzYW1lIHZhbHVlIGFzDQo+Pj4gQU1ER1BVX0hXX0lQX1ZDTl9FTkMgaXMgYSBnb29kIGlkZWEu
DQo+PiBIaSBDaHJpc3RpYW4sDQo+Pg0KPj4gIEZyb20gVkNONCwgdGhlcmUgaXMgbm8gVkNOIGRl
YyBhbmQgZW5jIHJpbmcgdHlwZSBhbnkgbW9yZSwgdGhlDQo+PiBkZWNvZGUvZW5jb2RlIHdpbGwg
Z28gdGhyb3VnaCB0aGUgdW5pZmllZCBxdWV1ZSwgc28gdXNpbmcNCj4+IEFNREdQVV9IV19JUF9W
Q05fRU5DIGlzIG5vIGxvbmdlciBhY2N1cmF0ZSAuIEtlZXBpbmcNCj4+IEFNREdQVV9IV19JUF9W
Q05fRU5DIHR5cGUgaXMgZm9yIGxlZ2FjeSBIVywgYW5kIHRoZSBuZXcNCj4+IEFNREdQVV9IV19J
UF9WQ05fVU5JRklFRCBqdXN0IGhhcHBlbiB0byB1c2UgdGhlIHNhbWUgSFcgcmluZyBhcw0KPj4g
bGVnYWN5IGVuY29kZSByaW5nLCBzbyByZXVzZSB0aGUgdmFsdWUsIGFuZCB0aGF0IGlzIHRoZSB3
aG9sZSBpZGVhLg0KPiBZZWFoLCBJIHVuZGVyc3RhbmQgeW91ciByZWFzb25pbmcgSSBqdXN0IGRv
bid0IHNlZSBpdCB0aGlzIHdheS4NCj4NCj4gV2hhdCBoYXBwZW5lZCBpcyB0aGF0IHRoZSBlbmNv
ZGUgcmluZyB3YXMgZXh0ZW5kZWQgd2l0aCBkZWNvZGUgZnVuY3Rpb25hbGl0eS4gSW4gb3RoZXIg
d29yZHMgd2Ugc3RpbGwgdXNlIHRoZSBzYW1lIGZvcm1hdCBmb3IgZW5jb2RpbmcsIHdlIGp1c3Qg
YWRkZWQgYW5vdGhlciBvbmUgZm9yIGRlY29kaW5nIGFzIHdlbGwuDQo+DQo+IFJlbmFtaW5nIHRo
ZSBlbnVtIGFuZCBhZGRpbmcgQU1ER1BVX0hXX0lQX1ZDTl9VTklGSUVEIHN1Z2dlc3RzIHRoYXQg
dGhpcyBpcyBzb21ldGhpbmcgY29tcGxldGVseSBuZXcsIHdoaWNoIGlzIG5vdCB0aGUgY2FzZSBo
ZXJlLiBUaGUgZW5jb2RpbmcgY29tbWFuZHMgc3RheSB0aGUgc2FtZSwgZG9uJ3QgdGhleT8NCj4N
Cj4gU28gdG8gc3VtIGl0IHVwIG15IHN1Z2dlc3Rpb24gaXMgdG8gc3RpY2sgd2l0aCBBTURHUFVf
SFdfSVBfVkNOX0VOQyBhbmQganVzdCBkb2N1bWVudCBvbiB0aGUgZGVmaW5pdGlvbiB0aGF0IHRo
aXMgaXMgdXNlZCBmb3IgYm90aCBlbmNvZGUgYXMgd2VsbCBhcyBkZWNvZGUgc3RhcnRpbmcgd2l0
aCBWQ040Lg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+PiBUaGFua3MsDQo+Pg0K
Pj4gTGVvDQo+Pg0KPj4NCj4+Pg0KPj4+IEluc3RlYWQgd2Ugc2hvdWxkIGp1c3QgYWRkIHRoZSBj
b21tZW50IHRvIEFNREdQVV9IV19JUF9WQ05fRU5DLg0KPj4+DQo+Pj4gUmVnYXJkcywNCj4+PiBD
aHJpc3RpYW4uDQo+Pj4NCj4+Pj4gICAgI2RlZmluZSBBTURHUFVfSFdfSVBfVkNOX0pQRUcgICAg
IDgNCj4+Pj4gICAgI2RlZmluZSBBTURHUFVfSFdfSVBfTlVNICAgICAgICAgIDkNCg0K
