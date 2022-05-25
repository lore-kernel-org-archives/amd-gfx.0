Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0ECC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 03:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397A710FF44;
	Wed, 25 May 2022 03:18:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CF510FF44
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 03:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1EdypDynbSCERNCJDzK/wgsgyHRMVNPHaM1TWq1mcG76rqLk7KtuwF6uDLxpK8/MpUz4zo3iXNEZQ3azw249sAJH0tAqlIv3h6UqqNMJsD79+DTty7KeHgSedjMnG/NQTcWBaeA8VcSHLhLi+PZNk2jGg5vlYDgjI9L5XVhrOCzJQcAcKVGVuWomNrthtW/bTJ/ZK7wAsIkj7wuTKcF/m4N2AL8mJGEIkYP3QlxctPoi4o84bfqA0YTf+k+I/Ts44tP1AvxzETpor33wcMAVJ4vp7ei29krhBejE6eR+4NbGwz63GRSceGvFZQ2woO9pNhQNMMN1SdjtE/q6uQJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcIQ9DhsA90qgpRO5h5GFrlkNGbC6drZFJ4KviMTXU0=;
 b=Ccw89DBsruVRLvt3OzjvrakbC9AhkWVTfxWUYtCBap1x0ed80BSgPTMqWg/zK1dEXmbc9jpjkm9+Ym1UtIVsDf1yFZIKETNa96RvuMMJMct1rNzHxmnL1Od/IuuukfAapxsHZdPSzaRFHDTJrXV9awiO6JVRM44DQwaj+2UzPFkb0IwZ92IRpy1+F+ztfGZTA9VKkuXsBIO61PN2KsfX0dJ7dBOfzB4nLPtRLDkeR0+h9X5PStGr+UNb8J+p5+mmkoZ2wArMS3Bm8SkuaJshN2ZGpl2slm7SDO9i9xIMIz0d8GmKq137tJV+YJWLdPdYMEenFE4avbzktqzsDvZ+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcIQ9DhsA90qgpRO5h5GFrlkNGbC6drZFJ4KviMTXU0=;
 b=M3Zn2Y5dHtJW+Tz8jNNIhSjgYx73n9KiFkA/jrCiTRJ9EeV8k11xyeFGFQ2KXdOu7L7KYFAyFC0jt75oU/NKAXCSOmLSU91wYkx75/LcuqEWoCM5YVbby2Auz3ZWxaeUmqWK8fQLfrKR0QmgEqIdzSzWhHsRcncza8A0gdTI7vc=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BN6PR1201MB0049.namprd12.prod.outlook.com (2603:10b6:405:57::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 03:18:30 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 03:18:30 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJldmlldyB2MiAyLzJdIGRybS9hbWRncHU6IHByaW50?=
 =?gb2312?Q?_umc_correctable_error_address?=
Thread-Topic: [PATCH Review v2 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Index: AQHYb3rnZdpH9JwJ00OV9OFrtsQLca0uMJSAgAC72us=
Date: Wed, 25 May 2022 03:18:30 +0000
Message-ID: <BL1PR12MB5334539CB7FA6390BEF8B1EE9AD69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220524143055.11723-1-Stanley.Yang@amd.com>
 <20220524143055.11723-2-Stanley.Yang@amd.com>
 <c597f953-fef7-e9f7-4b6f-c9fa3ae895cc@amd.com>
In-Reply-To: <c597f953-fef7-e9f7-4b6f-c9fa3ae895cc@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-25T03:15:32.8030473Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac9b9fb8-762e-483c-789a-08da3dfd3e3e
x-ms-traffictypediagnostic: BN6PR1201MB0049:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0049F0E9BEAA25FB2DD674AD9AD69@BN6PR1201MB0049.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAwDCiTdxwPlabuf6LdqXzSNJuaJVfPEkdXi9xedgjnF73tyqeGwpM7IBKFJQQxEchijMLu52HzVQk9Fs1q+iXt2U85KEc+oF+gpMYYPU7bhfFmxdJcZoYHyvh+lgRLDgDNV+f1f+inhKjZ1aJQJnypR/jaO11GNo+hl4CPUTgbdQmUkmA4IETB0+jz67WOhT0KSLlj1NxHv1oYcv8WO6eGnTGT1VJ0vIb2TZJlUlbzaWk2FEWTUmug2CDxjP+oTKG77xUc9Db/2Ym7QjbyEyzKtUNo88aJBufBChVBm/qaNuQOqullv6TvEIAd73gFa+TGyX0qhMEp/0uXjleIW1mcOYkr36XDVv05a3kpjeMeu9QGIxOT0hKK/U8s/OhK7wLjE/HZTGDRiLYZaoR45jHjtiy83l8QXssum1IDoCia6ZFOS/le0WYPj32NMVaUIP7GfPJNkrVOw2yUrsM8+pKyEBWqnNO5x2THKrmqLrdfpPkxJgXnfXlG5WxDl4+YThfYrCXCPLN4peeCamGQIaw37mq6hibZDMY1BblMhxPyGsXz1t759RkkXXGWFiYY/8YsJ59SCVQW+o0KB1DC2+RESOwZ72J3RdnY2wVsg6wNQ14NePvurhSRLKx1bDernUdzmAYny/Tavhb+UgHOmAh3J2EpeijC7pdYFALCeG6+B2fOLCZnhvVWnIjmqKwGHCKrU/30tNapUo9SKiAw0yw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(76116006)(66946007)(91956017)(508600001)(316002)(6636002)(66476007)(66446008)(64756008)(71200400001)(8936002)(5660300002)(66556008)(9686003)(52536014)(33656002)(53546011)(86362001)(26005)(224303003)(186003)(83380400001)(38100700002)(38070700005)(6506007)(7696005)(122000001)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VStaK09pYzd5QTB4MXI5UVFLNC8vRk1BQmFlamJaUVJLR2NpZzhHZnJGVlpt?=
 =?gb2312?B?NU1vVGtVbjNiQ0V6ZkR5Q0N2Z2d3eXlzb1IybzhIZVZocjZlQ3Z3MWU5NStC?=
 =?gb2312?B?d1p2MGFZMi9qWVVGb2JkWFh6aXhINVdxeHordWNrY21sa1FvaGd3VExjWGRx?=
 =?gb2312?B?OHVnOHJEbENiM25tSnErUUFOTUNHVUVubzFWVU81QTJFRUovc3Z2NmJnWm1w?=
 =?gb2312?B?YWhhZ3pKUkFXNTJpQjhqQlBYR05USTl3Q1hjWHlXSmFOSjZtaEtnREZhM1gx?=
 =?gb2312?B?bGxwTGo4cjZQSXdlckV4enl1OFV3cWFhYUN1cllqMVBGWkJ4RTkxTXB2SFhh?=
 =?gb2312?B?YmM0UXFNcXRqUzV1VDc1dFVRUnVaT2xUbkh6T0s1bmxUVmV5Zk9HOXRJa3Zi?=
 =?gb2312?B?TXdCak9nNGNQd0poTzd1MUl5d1RUZHNJMWUxcVpwMU5IMk5nck5IZjlzLzBX?=
 =?gb2312?B?dHh2L1RLQU10NldQbm10QmlnWnA2RGpQQ2xZOTJWNS9LM2U3K2VWOFlFYWdI?=
 =?gb2312?B?RmlGZmNaT0F2WC9hanVCUERmMVQ0dFFka3VLRjg2Y0V4TWJWS0o1MGJUelpw?=
 =?gb2312?B?MVU2eFRBRGRWYy9vd0V1L2dlQ0c5c1k5K3FwdTEzcHgxK09rWitwZno2b3BO?=
 =?gb2312?B?NUdhcTZ6a0I2V2dOd2NTR3dIZXgra2ZIQjZBRlZ6ZWZSZ0ZVekhQdTVFR2JJ?=
 =?gb2312?B?NHZ6ZlI5MkFrWUh4OWtWanp0dldSYzFDdFhyaExqSkNOYWRJdUZ5RlZ5anFj?=
 =?gb2312?B?SllVNEhGbHdNRXR0aUZKY2l4SXI2cWJEMFRLMEUySW1Dak1qb2Y0K0MrSXZS?=
 =?gb2312?B?SHpVMEU4Nlh6VjJGN2dQTEI2VUk4Z2tUUElrck5oZUhzNWY4cDUwbm1lK3RK?=
 =?gb2312?B?WEN4TGFnaldWZ2hCb0ZxLzRCZHZsbWdVcmo3VUNkU0RwVzgyR2trM2pVYXN1?=
 =?gb2312?B?cU5JMjd6NkUxRlpLbTZ6SG1yQ2U2bisyRVM5d1duampoVncvZE1nUnRHNVJk?=
 =?gb2312?B?MkJXdUU3UHMzMHdnQ29JRDd4MTRDVWVuV2d5dWo3WlRXM3J5TnRSbEh3WEJ2?=
 =?gb2312?B?Ym1JOC84S3Z3UWd3QUlyT3pOV2J1QkltV1ZmZ3crSG1hb1VGa2JlOG81QXVn?=
 =?gb2312?B?Qi9ETG5jTGNnZjl5RWNxbFY5eUJVYWVWK1ZIamlsdDVualN4SUtsQ2VqUVBU?=
 =?gb2312?B?aVBnUjBTa1hMY1lKanowdnlJdmRxL3ZlbFFYUVR6OXB4OUdNcEJXZ3B6TlBr?=
 =?gb2312?B?TWVvd2krbW05K3FGYVZrNk1YdWFWeitTYkFUV0h3TTJWYlBabWFGdDcvY043?=
 =?gb2312?B?aWpkMk8raGhNTksvYS9vV1Q0bzZNc1FvdmI0Ti9CeWpVRTJNMEpKUE1hdjM3?=
 =?gb2312?B?TWxOckZIMW9YbWt6L0k0R0puOGZFS1JqZWlvb0hmZXdVMVZJaE92QWRzLzlN?=
 =?gb2312?B?UmlBR2x4Vm9YRk5kRmUyaFl3c0JESFBpK3F1bHdEcWppd0lOd0d5aldJSVVX?=
 =?gb2312?B?NHpvMDg0bTZ5YUJCdHNGby9OTmM0RE5rcFdBb2E4MG9ja0ZyRmxXbmNybHlj?=
 =?gb2312?B?SkhzNGIzRHlIZlpmanh6Sm43NHZjelcwWjV2MEJOM1FocHJ6b3lha3Nod2dM?=
 =?gb2312?B?MU1BdytwQXFLdEJjdllaQktyeE5CTk00aFJvTUhjWitZNUtrY2w0Zkxtdkpn?=
 =?gb2312?B?N0VmVmJ1cnJBVDlmQjREYTdCbUJZWDFhU0ttK2dLa1ErUEtJNHlzelVJeW9K?=
 =?gb2312?B?RWVhTmlnOU0rL2lSNHBIbUY3YWpRK1YzSWZOMS9adEo3OWlsbmVyK1hMOXVx?=
 =?gb2312?B?SlJjYytlMVhxS1NNOEtRN25iL2JMZWlsUTRvazJDUW9qYk13N20zSXZCYWc4?=
 =?gb2312?B?eUtYcHJMV0hVU24vWFpsTlgzSzhyMk9EMjFYZUo0MDNEZU16YncrbTJQWTdR?=
 =?gb2312?B?cDhMdWJ3aUFQM0NBdUQzZzJzR2lRbVY1Nmo3cnNjQlhoY0xUOTVocUw2QjNi?=
 =?gb2312?B?NGZ5R1E5WjRSaXlGdWtGbHFKOVNCMkROdW9RUVgrMGNEcGlmSHlLMjlZb3Fw?=
 =?gb2312?B?L2RrNElDS1MrbDdLWEZBL0d4SHdJbDNqaWp2cU10ZlNZUkJjM3lTaTU1OG5x?=
 =?gb2312?B?ZEJpY0wyckI5QjN6ZmtybmRlWWtGRERTcEZwQ05wbFl5a3VMZ3lCZnVxTmNp?=
 =?gb2312?B?MjU0aHlha3hVUWJGZ3BZMG5oK2VlUjQ5bURlbklJU2xXenNGQWRLK0dpSXgr?=
 =?gb2312?B?VEV1djM1bGdJTDUzM0RDazlhbFlDR1Bjb3FhNnE1bFdVUEZOOW1VcTExTEFJ?=
 =?gb2312?B?enVnbTJBdnVlckRMMlNrODhQTG9MVFdBL1lQYk9EQzlmenJ2UkYzU0JZdmU2?=
 =?gb2312?Q?nbvggvLrlAs2jAAY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5334539CB7FA6390BEF8B1EE9AD69BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9b9fb8-762e-483c-789a-08da3dfd3e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 03:18:30.6335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMHCwSgnzQhp8HZzq1yQOey7eVVcZ+q3KHTLE8VkZhaWDCD9/iy/XcutACZRDFPuJABbCA03z78TBPjV6Jsn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0049
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

--_000_BL1PR12MB5334539CB7FA6390BEF8B1EE9AD69BL1PR12MB5334namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQoNCg0Kt6K8/sjLOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPg0KyNXG2jog0MfG2sj9LCAyMDIyxOo11MIyNcjVIMnPzucxMjowMw0KytW8/sjLOiBZYW5n
LCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4sIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4sIFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+LCBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4sIFF1
YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0K1vfM4jogUmU6IFtQQVRDSCBSZXZpZXcgdjIg
Mi8yXSBkcm0vYW1kZ3B1OiBwcmludCB1bWMgY29ycmVjdGFibGUgZXJyb3IgYWRkcmVzcw0KDQoN
Ck9uIDUvMjQvMjAyMiA4OjAwIFBNLCBTdGFubGV5Lllhbmcgd3JvdGU6DQo+IENoYW5nZWQgZnJv
bSBWMToNCj4gICAgICAgIHJlbW92ZSB1bm5lY2Vzc2FyeSBzYW1lIHJvdyBwaHlzaWNhbCBhZGRy
ZXNzIGNhbGN1bGF0aW9uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3Rhbmxl
eS5ZYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oICAgICAgICAgICB8ICA1ICsrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dW1jX3Y2XzcuYyAgICAgICAgIHwgNTIgKysrKysrKysrKysrKysrKysrLQ0KPiAgIC4uLi9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyAgICB8ICAxICsNCj4gICAzIGZpbGVz
IGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IGluZGV4IDNmMjNmOWFkMzI0OS4uOTg1YjhjZGRiNWEx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBAQCAtMTEwOCw2ICsx
MTA4LDExIEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4NCj4gICAgICAgIGJvb2wgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2NwbV9lbmFibGVkOw0KPiAgICAgICAgdWludDMyX3QgICAg
ICAgICAgICAgICAgICAgICAgICBzY3BtX3N0YXR1czsNCj4gKw0KPiArICAgICAvKiBEZXRlcm1p
bmUgc211IGVjY3RhYmxlIHdoZXRoZXIgc3VwcG9ydA0KPiArICAgICAgKiByZWNvcmQgY29ycmVj
dGFibGUgZXJyb3IgYWRkcmVzcw0KPiArICAgICAgKi8NCj4gKyAgICAgaW50IHJlY29yZF9jZV9h
ZGRyX3N1cHBvcnRlZDsNCg0KV2h5IG5vdCBrZWVwIHRoaXMgaW4gdW1jX2VjY19pbmZvIHBhc3Nl
ZCBiYWNrIGZyb20gRlc/DQoNClRoYW5rcywNCkxpam8NCg0KU3RhbmxleTogR29vZCBwb2ludCwg
dGhpcyBjYW4ga2VlcCB0aGUgb3ZlcmFsbCBsb2dpYyBvZiB0aGUgUkFTIGVjY3RhYmxlaW5mbywg
dGhhbmtzIExpam8uDQoNCg0KPiAgIH07DQo+DQo+ICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqZHJtX3RvX2FkZXYoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfNy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzcuYw0KPiBpbmRleCA2MDY4OTJkYmVhMWMuLjkxYmRj
NWUwNDhjMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2
XzcuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfNy5jDQo+IEBA
IC0xMTksNiArMTE5LDI0IEBAIHN0YXRpYyB2b2lkIHVtY192Nl83X2VjY19pbmZvX3F1ZXJ5X2Nv
cnJlY3RhYmxlX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICAgICAgICAgICAg
ICAgICplcnJvcl9jb3VudCArPSAxOw0KPg0KPiAgICAgICAgICAgICAgICB1bWNfdjZfN19xdWVy
eV9lcnJvcl9zdGF0dXNfaGVscGVyKGFkZXYsIG1jX3VtY19zdGF0dXMsIHVtY19yZWdfb2Zmc2V0
KTsNCj4gKw0KPiArICAgICAgICAgICAgIGlmIChhZGV2LT5yZWNvcmRfY2VfYWRkcl9zdXBwb3J0
ZWQpICAgICB7DQo+ICsgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBlcnJfYWRkciwgc29j
X3BhOw0KPiArICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgY2hhbm5lbF9pbmRleCA9DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnVtYy5jaGFubmVsX2lkeF90Ymxb
dW1jX2luc3QgKiBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bSArIGNoX2luc3RdOw0KPiArDQo+
ICsgICAgICAgICAgICAgICAgICAgICBlcnJfYWRkciA9IHJhcy0+dW1jX2VjYy5lY2NbZWNjaW5m
b190YWJsZV9pZHhdLm1jYV9jZXVtY19hZGRyOw0KPiArICAgICAgICAgICAgICAgICAgICAgZXJy
X2FkZHIgPSBSRUdfR0VUX0ZJRUxEKGVycl9hZGRyLCBNQ0FfVU1DX1VNQzBfTUNVTUNfQUREUlQw
LCBFcnJvckFkZHIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgLyogdHJhbnNsYXRlIHVtYyBj
aGFubmVsIGFkZHJlc3MgdG8gc29jIHBhLCAzIHBhcnRzIGFyZSBpbmNsdWRlZCAqLw0KPiArICAg
ICAgICAgICAgICAgICAgICAgc29jX3BhID0gQUREUl9PRl84S0JfQkxPQ0soZXJyX2FkZHIpIHwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBRERSX09GXzI1NkJfQkxP
Q0soY2hhbm5lbF9pbmRleCkgfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE9GRlNFVF9JTl8yNTZCX0JMT0NLKGVycl9hZGRyKTsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgICAgICAgLyogVGhlIHVtYyBjaGFubmVsIGJpdHMgYXJlIG5vdCBvcmlnaW5hbCB2YWx1ZXMs
IHRoZXkgYXJlIGhhc2hlZCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgU0VUX0NIQU5ORUxf
SEFTSChjaGFubmVsX2luZGV4LCBzb2NfcGEpOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAg
ICBkZXZfaW5mbyhhZGV2LT5kZXYsICJFcnJvciBBZGRyZXNzKFBBKTogMHglbGx4XG4iLCBzb2Nf
cGEpOw0KPiArICAgICAgICAgICAgIH0NCj4gICAgICAgIH0NCj4gICB9DQo+DQo+IEBAIC0yNTEs
NyArMjY5LDkgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzdfZWNjX2luZm9fcXVlcnlfcmFzX2Vycm9y
X2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYNCj4NCj4gICBzdGF0aWMgdm9pZCB1
bWNfdjZfN19xdWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCB1bWNfcmVnX29mZnNldCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgKmVycm9yX2NvdW50KQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
bG9uZyAqZXJyb3JfY291bnQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBjaF9pbnN0LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgdW1jX2luc3QpDQo+ICAgew0KPiAg
ICAgICAgdWludDMyX3QgZWNjX2Vycl9jbnRfc2VsLCBlY2NfZXJyX2NudF9zZWxfYWRkcjsNCj4g
ICAgICAgIHVpbnQzMl90IGVjY19lcnJfY250LCBlY2NfZXJyX2NudF9hZGRyOw0KPiBAQCAtMjk1
LDYgKzMxNSwzMyBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfN19xdWVyeV9jb3JyZWN0YWJsZV9lcnJv
cl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgKmVy
cm9yX2NvdW50ICs9IDE7DQo+DQo+ICAgICAgICAgICAgICAgIHVtY192Nl83X3F1ZXJ5X2Vycm9y
X3N0YXR1c19oZWxwZXIoYWRldiwgbWNfdW1jX3N0YXR1cywgdW1jX3JlZ19vZmZzZXQpOw0KPiAr
DQo+ICsgICAgICAgICAgICAgew0KPiArICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZXJy
X2FkZHIsIHNvY19wYTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IG1jX3VtY19h
ZGRydDA7DQo+ICsgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBjaGFubmVsX2luZGV4Ow0K
PiArDQo+ICsgICAgICAgICAgICAgICAgICAgICBtY191bWNfYWRkcnQwID0NCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU09DMTVfUkVHX09GRlNFVChVTUMsIDAsIHJlZ01DQV9VTUNf
VU1DMF9NQ1VNQ19BRERSVDApOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICBjaGFubmVs
X2luZGV4ID0NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+dW1jLmNoYW5u
ZWxfaWR4X3RibFt1bWNfaW5zdCAqIGFkZXYtPnVtYy5jaGFubmVsX2luc3RfbnVtICsgY2hfaW5z
dF07DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGVycl9hZGRyID0gUlJFRzY0X1BDSUUo
KG1jX3VtY19hZGRydDAgKyB1bWNfcmVnX29mZnNldCkgKiA0KTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgIGVycl9hZGRyID0gUkVHX0dFVF9GSUVMRChlcnJfYWRkciwgTUNBX1VNQ19VTUMwX01D
VU1DX0FERFJUMCwgRXJyb3JBZGRyKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgLyog
dHJhbnNsYXRlIHVtYyBjaGFubmVsIGFkZHJlc3MgdG8gc29jIHBhLCAzIHBhcnRzIGFyZSBpbmNs
dWRlZCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgc29jX3BhID0gQUREUl9PRl84S0JfQkxP
Q0soZXJyX2FkZHIpIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBB
RERSX09GXzI1NkJfQkxPQ0soY2hhbm5lbF9pbmRleCkgfA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE9GRlNFVF9JTl8yNTZCX0JMT0NLKGVycl9hZGRyKTsNCj4gKw0K
PiArICAgICAgICAgICAgICAgICAgICAgLyogVGhlIHVtYyBjaGFubmVsIGJpdHMgYXJlIG5vdCBv
cmlnaW5hbCB2YWx1ZXMsIHRoZXkgYXJlIGhhc2hlZCAqLw0KPiArICAgICAgICAgICAgICAgICAg
ICAgU0VUX0NIQU5ORUxfSEFTSChjaGFubmVsX2luZGV4LCBzb2NfcGEpOw0KPiArDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAvKiBjbGVhciBbQzQgQzMgQzJdIGluIHNvYyBwaHlzaWNhbCBhZGRy
ZXNzICovDQo+ICsgICAgICAgICAgICAgICAgICAgICBzb2NfcGEgJj0gfigweDdVTEwgPDwgVU1D
X1Y2XzdfUEFfQzJfQklUKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGRldl9pbmZvKGFkZXYt
PmRldiwgIkVycm9yIEFkZHJlc3MoUEEpOiAweCVsbHhcbiIsIHNvY19wYSk7DQo+ICsgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgfQ0KPiAgIH0NCj4NCj4gQEAgLTM5NSw3ICs0NDIsOCBAQCBzdGF0
aWMgdm9pZCB1bWNfdjZfN19xdWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2hfaW5zdCk7DQo+ICAgICAgICAgICAgICAgIHVtY192Nl83X3F1ZXJ5X2Nv
cnJlY3RhYmxlX2Vycm9yX2NvdW50KGFkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVtY19yZWdfb2Zmc2V0LA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYoZXJyX2RhdGEtPmNl
X2NvdW50KSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJihlcnJfZGF0YS0+Y2VfY291bnQpLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoX2luc3QsIHVtY19pbnN0KTsNCj4gICAg
ICAgICAgICAgICAgdW1jX3Y2XzdfcXVlcnJ5X3VuY29ycmVjdGFibGVfZXJyb3JfY291bnQoYWRl
diwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdW1jX3JlZ19vZmZzZXQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICYoZXJyX2RhdGEtPnVlX2NvdW50KSk7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+
IGluZGV4IDljZGZlZWE1ODA4NS4uZTQxYTViNmZjNjRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPiBAQCAtMTg4
Miw2ICsxODgyLDcgQEAgc3RhdGljIHNzaXplX3QgYWxkZWJhcmFuX2dldF9lY2NfaW5mbyhzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVj
Y190YWJsZS0+RWNjSW5mb19WMltpXS5tY2FfdW1jX2FkZHI7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgZWNjX2luZm9fcGVyX2NoYW5uZWwtPm1jYV9jZXVtY19hZGRyID0NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVjY190YWJsZS0+RWNjSW5mb19WMltpXS5tY2FfY2V1bWNf
YWRkcjsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHNtdS0+YWRldi0+cmVjb3JkX2NlX2FkZHJf
c3VwcG9ydGVkID0xOw0KPiAgICAgICAgICAgICAgICB9DQo+ICAgICAgICB9DQo+DQo+DQo=

--_000_BL1PR12MB5334539CB7FA6390BEF8B1EE9AD69BL1PR12MB5334namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Lazar,
 Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">25</span><span style=3D"color=
:black">=C8=D5</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;color:black">
</span><span style=3D"color:black">=C9=CF=CE=E7</span><span lang=3D"EN-US" =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">12:03<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;, a=
md-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;, Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;, Quan, Evan &lt;Evan.Quan@a=
md.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Re: [PATCH Review v2 2/2] drm/amdgpu: print umc
 correctable error address<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
<br>
On 5/24/2022 8:00 PM, Stanley.Yang wrote:<br>
&gt; Changed from V1:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove unnecessary same row =
physical address calculation<br>
&gt; <br>
&gt; Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/umc_v6_7.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; | 52 ++++++++++++++++++-<br>
&gt;&nbsp;&nbsp; .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 3 files changed, 56 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 3f23f9ad3249..985b8cddb5a1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1108,6 +1108,11 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scpm_enable=
d;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scpm_status;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Determine smu ecctable whether support<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * record correctable error address<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int record_ce_addr_supported;<br>
<br>
Why not keep this in umc_ecc_info passed back from FW?<br>
<br>
Thanks,<br>
Lijo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Stanley: Good point, this can keep the overall logic of th=
e RAS ecctableinfo, thanks Lijo.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static inline struct amdgpu_device *drm_to_adev(struct drm=
_device *ddev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/a=
md/amdgpu/umc_v6_7.c<br>
&gt; index 606892dbea1c..91bdc5e048c2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
&gt; @@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_e=
rror_count(struct amdgpu_device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *error_count +=3D 1;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_query_error_status_helper(adev, mc_umc_status,=
 umc_reg_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;record_ce_addr_supported)&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr, soc_=
pa;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index =
=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;u=
mc.channel_inst_num + ch_inst];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D ras-&gt;um=
c_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D REG_GET_FI=
ELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate umc channe=
l address to soc pa, 3 parts are included */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_=
BLOCK(err_addr) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AD=
DR_OF_256B_BLOCK(channel_index) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OF=
FSET_IN_256B_BLOCK(err_addr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The umc channel bits=
 are not original values, they are hashed */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channe=
l_index, soc_pa);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, =
&quot;Error Address(PA): 0x%llx\n&quot;, soc_pa);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -251,7 +269,9 @@ static void umc_v6_7_ecc_info_query_ras_error_addr=
ess(struct amdgpu_device *adev<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void umc_v6_7_query_correctable_error_count(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t umc_reg_offset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned lo=
ng *error_count)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned lo=
ng *error_count,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch=
_inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t um=
c_inst)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt_sel, ec=
c_err_cnt_sel_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt, ecc_er=
r_cnt_addr;<br>
&gt; @@ -295,6 +315,33 @@ static void umc_v6_7_query_correctable_error_coun=
t(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *error_count +=3D 1;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_query_error_status_helper(adev, mc_umc_status,=
 umc_reg_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr, soc_=
pa;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mc_umc_addrt0;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc_umc_addrt0 =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADD=
RT0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel_index =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;u=
mc.channel_inst_num + ch_inst];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D RREG64_PCI=
E((mc_umc_addrt0 + umc_reg_offset) * 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D REG_GET_FI=
ELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate umc channe=
l address to soc pa, 3 parts are included */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_=
BLOCK(err_addr) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AD=
DR_OF_256B_BLOCK(channel_index) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OF=
FSET_IN_256B_BLOCK(err_addr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The umc channel bits=
 are not original values, they are hashed */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channe=
l_index, soc_pa);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear [C4 C3 C2] in =
soc physical address */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa &amp;=3D ~(0x7UL=
L &lt;&lt; UMC_V6_7_PA_C2_BIT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, =
&quot;Error Address(PA): 0x%llx\n&quot;, soc_pa);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -395,7 +442,8 @@ static void umc_v6_7_query_ras_error_count(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_query_correctable_error_count(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;(err_data-&gt;ce_count));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;(err_data-&gt;ce_count),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ch_inst, umc_inst);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_querry_uncorrectable_error_count(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(err_data-&gt;ue_count)=
);<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index 9cdfeea58085..e41a5b6fc64b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -1882,6 +1882,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu=
_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo_V2[i].mca_um=
c_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_inf=
o_per_channel-&gt;mca_ceumc_addr =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo_V2[i].mca_ce=
umc_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev-&gt;record=
_ce_addr_supported =3D1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; <o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5334539CB7FA6390BEF8B1EE9AD69BL1PR12MB5334namp_--
