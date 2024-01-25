Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6EBC46CD2
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 02:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AA710EB0E;
	Thu, 25 Jan 2024 02:44:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA9210EB0E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 02:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l98Q6iPW8Qi7373qNApwy4LaNtKNxo3gwcG6qd2A/uz1/ugVKZTT59tapUUuIwwysspa4TA7hVa3cJd3V5leiPmWU7nmYwBWDTGy/AZcOrwPuyuQ07klU6WabJIONm6d6kIFBE5VwKyQqHfEBd4g2WphJjlhGT7T9xSJ2DJmFJ9AE7reKboZqETFJmNKD2oRqhuLKxVZmQjZiy8/9DvIZ7+hxmJUQuhORsl49btd0pG6gxBwWu5JvL4b76RfhufDiMp0mQB+a11To+wUdMgGfk3LyCsggTC51k5u+3T/UgLuvgQnHM/IXPb4nYgGaAfckdDr+vp+x2hpJ+iYoaGspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRptOnseJ/omz9auBACde8O/mt0mIIgzu+Jwswj/9xI=;
 b=GTaZ3rj9b7bsTi/lYrseOgFZaKDAqcp79qrHzcSQrX7Tg1p3vMcWsJOu9VkJqop7dYMzqE5H7Hyj9T2GbEaddGn6Ng1ZQmG47FbJnMD8Ca/IB/2/+hdHfunnMaRmg8h7PqiMtsGkb3a+OY54tHk5lbyHzNUmvimUzdiNKZ/C7Em6amZzgOi6KEDazFRzEnPZXPbU2C6xBHKrqf4k5Mf4ab6e8JLXdDpzHfz5Q91zaMz+lqN/KvMxTShz1IscTdVIzQyUtHCP98NIosQPikqybuWeX3kM6ddjJpp8Z2gucDzEHU0pVsxrMokrldT62lBuH+qN/UUPPp5GCvvBNi3gAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRptOnseJ/omz9auBACde8O/mt0mIIgzu+Jwswj/9xI=;
 b=t4Z1zQP2GJqJPwYj87wIV3HbfW4RHGVTRXLyO1Ymp6/oaaPM5mQQUdqyLZ4kKc2sgD0oYt/TS3YAkTH04WBb/VRLEQBtlc47iXbbr4oaDXjwZiz04xKuRVnAnhbEzh9jPD422JPfnYEg5EPvmtO3YL81YURmESE3CptT6470+PQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Thu, 25 Jan
 2024 02:43:59 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 02:43:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Topic: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Index: AQHaTpL5Kj6BFglfAU2bCgiIkjKaYbDpIW8AgACn0CA=
Date: Thu, 25 Jan 2024 02:43:59 +0000
Message-ID: <DS7PR12MB6005A421A18A76F8F58C7E06FB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <20240124065932.892944-2-Prike.Liang@amd.com>
 <CADnq5_NnJeVALgswRm4f17XMZ_e5a_nd4D_q2vrXyRTvCuKx8A@mail.gmail.com>
In-Reply-To: <CADnq5_NnJeVALgswRm4f17XMZ_e5a_nd4D_q2vrXyRTvCuKx8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=905000b7-5d2e-42f1-bcdc-1de16fff4078;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-25T02:07:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV2PR12MB5966:EE_
x-ms-office365-filtering-correlation-id: 3f6a7910-6150-4881-5911-08dc1d4f7bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrdhyNcSGuY5cOqb4Nfq4bj9o6kq5nRymRPHFDf1ZcXncxAMSRU5gSTLY7BVusZq8UqR1Xcf7pkUk6UgaEA2G/34T/lgAFzPke8fZ14L1mJNwtuX5VIhCgaMOZP5C8ldqO5gUcQC6k/6OTJFneTeEkzHY/kti3SfbXTIekhBlHaGDLCcROBZw8BbjHUSrodqVKVWfv/XWazDhwdoJmp3A7DR/GRV+y97uHk0MMD5p4md7zsXDJfRAVvsWbNnlKbAepkXDSbU7h8dYEKGs3Qw037lFBFP603DUZ2Hdr/gSqb6Yvma0uf+W6QYxQSesUrZx/DMVwspcMXbAJzMHW+SpNNSEj0erq/EIrdh+vKzpSV5DYObGG7wklldNRhsZ2/F16gKBl4DiYnj3dr2rWKYopeYUwZ56EtsqG5LYiMMdT/R97JMwyB28o8wUwyiK18YSKIExApApgYbRSsbNhMF9UJZsRa87NBCOOrSTKYrNkMDX5ogzV4ssF9miAiIgQk7ZbMqXtKTqexoYg5HoJkC0iONfnQTaQcsRy4l+kOFNO1bs+Gn6Q+aqRpv9yrlet0N0uUwMWvHO6CKsHVcdVZkVeXckqofn/XIIAkZwbRoKxuGvMG7aWSMPNZQejOrs4J6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(9686003)(7696005)(26005)(38070700009)(83380400001)(6506007)(53546011)(71200400001)(76116006)(41300700001)(66446008)(8936002)(4326008)(478600001)(2906002)(66556008)(122000001)(66946007)(54906003)(316002)(6916009)(64756008)(52536014)(8676002)(66476007)(5660300002)(33656002)(86362001)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekt4bXdxaU1BZ29pcGNyWmRFMm9qTXVSVEpYc09yWU5Lck1FamQxT1B3Y0VG?=
 =?utf-8?B?QU41ck0ycnhIbE1LM1l4SEdtdkR5bjhYbXVJOVVCSmJxYjY5Qjg4cUZPY0N2?=
 =?utf-8?B?aVhFR1N5MnczYzV1YkJSeUJxQmVFMmZTOVB3TzEvUzhwbEd0MWVIMGY0aVIr?=
 =?utf-8?B?NUp3QUROUFJEU1lXMlNqMDhEZHBkVnVpcnFzODFXVGtoSXpxNXlWeHpOcm15?=
 =?utf-8?B?d3MzQ3k0SlRMT2RCSk9ib0tCVjVMd1B3OWd6L1huc1NRaWdSNkNNT2Jpb3Jt?=
 =?utf-8?B?b1I3QTRUTFdMTHRxclNrOUhrd3RwM284ZEQ3SE03QXNCRmI5VDhZaXV5cXFQ?=
 =?utf-8?B?RWNxYVlId3k4RmhPTkdoU3dTN2pCTlhxemJqd3Y5TEVzZFEyWFZPckNkbHRY?=
 =?utf-8?B?WHFnNzR0RDNOVnhtbmNZNk9aWkxzMkV5Witub0d3NjRLbjdQZXVLbzVSbmph?=
 =?utf-8?B?NEg1Tm40SWZIZXhISHZFdkRQMTdsZzVWRWhuRGtCOTMwSUFiZWVXOGlWMFJ6?=
 =?utf-8?B?NmErdCtZYkY4L1BVSDZYOERFZ01mLzV5TS9YTm5DZ0FhL09ac1ZUbC9Pdzhn?=
 =?utf-8?B?TC9WNHpvRmhFUUN3SDUrU3I1Q3VmVEdOYUdPNEcwOGhYQU5yTWpObmQwYS9n?=
 =?utf-8?B?QzNEak5idnhlODNZeWk3c050SGVWN09LLzdVKzRVRkZRcWsweC9mdmw3b1N3?=
 =?utf-8?B?NmZQM05haHVkNDNjNGhMNDAwNXRIV2hSdjlnNjNqWUh0bnFSLzFvT3dsWDJk?=
 =?utf-8?B?R2ZSRE1wRXo0a1dRSWxwVW8xV3FNdXRQdGEyTlB1alBDWko1Sm1BSGJyemQr?=
 =?utf-8?B?WWZkNXI0VEo0NWlUdnl4VEYxc3M0OUxqQlJ4dXBlRkJlWmNUb20zSEJLQVpW?=
 =?utf-8?B?bEtMUDhrY3B0M21sNG9ra2N2aVJlUm0xTERCQzVOalZscTUvVG1OaUU1VDgr?=
 =?utf-8?B?YThESXlLcEQvaStHV05lWjkwRWo3OTNCT0RpUXhIRHU5Y3hGZkwxK2hib3pt?=
 =?utf-8?B?RitkVW93dng1Tm9SMmdnbGRQcURwUjdDeUhDWVdWaFFRb203aXAxSzF2Wm5a?=
 =?utf-8?B?Q1pJSWJZYXpHbHdBSmNQMGcrVXA5YXRNMVRGMEpLYVM2QUtsaGZSWXM3amd1?=
 =?utf-8?B?SmZ0eXpvSlRQU2J6YWpsR1RuM0lRRVNXaUYwZUREZFZQakZLdmpyenErSm5P?=
 =?utf-8?B?SnhZMDFUOW10QUc4SjRvcHdyVDBQL1d6SjJxaElTRUpGOWRxenRiS0k0Tm54?=
 =?utf-8?B?NlhSSmkweHFtd08vVjR4bTltQzcwV0RTSEUxR2ViUWIrSFNma1Y3SVl2YVdU?=
 =?utf-8?B?K1c5d3E4SE01VUdhajlIRkhCSHcvUUp5L1R5eG8xR2UrTlNTalhuUDM1aGht?=
 =?utf-8?B?ODEzdUNKMG5XZm5kU3QxcmhXNnFZSEYrZmJzUXZndjhoTng3MmJtYVZIUi9u?=
 =?utf-8?B?RzlRcnpkSDFlT1J0NG0vY1p6UTVSZEJtL3pIL3Q2NUF6aFkvWVZHcFpvMWVW?=
 =?utf-8?B?bU1OK1hrRS9WT25CZHRxVU9TSXRNQklncXU2dk1lOUlyeEdSOEFiRTErQXJ3?=
 =?utf-8?B?NEJsMVB4SmlzZTJUSXNjRVpnaFZHWkxuQkZoUWI4cnBJQTJsMXk5QmNwKzdp?=
 =?utf-8?B?SEoyaExMVmtTRlpyemFYVzZsNU5RTlVsVnpxZy93UWp2cXZUNjhjTzRwM2hL?=
 =?utf-8?B?Zlk0UFJQT2RnMVEyNlppNWk5cUVpZGVYb3FnQnpGZ0lEajlVSHArWFFSeTJQ?=
 =?utf-8?B?aXN4NXo2bjZmM0YzRkJPOEtTVnhSTTdMdFRlcGlBbWRHWXFMc0hNMG9DL1RD?=
 =?utf-8?B?RzBLTXZyM25penlaendzd1lLM1o0VnJhbkxyTzNKNzhuSEpuYkszd0YrQjc5?=
 =?utf-8?B?NE5qTG1nUm92ZW1WT3FwUUtZY0tFQTVqbGkzVDlGWkNrZUlLUjYvNE5HNHJH?=
 =?utf-8?B?UXRLNldDbnBhV2pXTmRPV29lV0dvaWlNcy9UWlVnd1FQREQ5QjZpa2ZOU0Vn?=
 =?utf-8?B?bXZOb1lxdXBmMTV3MWhCdjdCZzY2aVpGTlpSL2YxWEo1V1dFR3ZQVjNhUGJY?=
 =?utf-8?B?eHFoZDlDc3dUU1ZuSnRwcTM3emNsV3ZISm9OWnVhU1BmaldETmFSWVpzWDE5?=
 =?utf-8?Q?wJGo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6a7910-6150-4881-5911-08dc1d4f7bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 02:43:59.5692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7vN9UaHHQamOnecvO6af0g8FoA/vTi4SGOi6YRDkeL9VHZCDNoRR4cTIn1w4D5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpLCBBbGV4DQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI1LCAyMDI0IDEyOjA3IEFNDQo+
IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IHJlc2V0IGdwdSBmb3IgcG0g
YWJvcnQgY2FzZQ0KPg0KPiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAyOjE34oCvQU0gUHJpa2Ug
TGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gdGhlIHBtIGFi
b3J0IGNhc2UgdGhlIGdmeCBwb3dlciByYWlsIG5vdCB0dXJuIG9mZiBmcm9tIEZDSCBzaWRlIGFu
ZA0KPiA+IHRoaXMgd2lsbCBsZWFkIHRvIHRoZSBnZnggcmVpbml0aWFsaXplZCBmYWlsZWQgYmFz
ZSBvbiB0aGUgdW5rbm93biBnZngNCj4gPiBIVyBzdGF0dXMsIHNvIGxldCdzIHJlc2V0IHRoZSBn
cHUgdG8gYSBrbm93biBnb29kIHBvd2VyIHN0YXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDUgKysrKysNCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyAgICAgIHwgNyArKysrKystDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gaW5kZXggOTE1M2Y2OWJh
ZDdmLi4xNGI2NmM0OWE1MzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jDQo+ID4gQEAgLTI5MzUsNiArMjkzNSwxMSBAQCBzdGF0aWMgaW50IHBzcF9y
ZXN1bWUodm9pZCAqaGFuZGxlKQ0KPiA+DQo+ID4gICAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYs
ICJQU1AgaXMgcmVzdW1pbmcuLi5cbiIpOw0KPiA+DQo+ID4gKyAgICAgICBpZihhbWRncHVfYXNp
Y19uZWVkX3Jlc2V0X29uX2luaXQoYWRldikpIHsNCj4gPiArICAgICAgICAgICAgICAgRFJNX0lO
Rk8oIlBNIGFib3J0IGNhc2UgYW5kIGxldCdzIHJlc2V0IGFzaWMgXG4iKTsNCj4gPiArICAgICAg
ICAgICAgICAgYW1kZ3B1X2FzaWNfcmVzZXQoYWRldik7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0K
Pg0KPiBTZWVtcyBsaWtlIGl0IHdvdWxkIGJlIGJldHRlciB0byBwdXQgdGhpcyBpbiB0aGUgcmVz
dW1lIGNhbGxiYWNrLg0KW0xpYW5nLCBQcmlrZV0gIFllcywgaXQgbWFrZXMgc2Vuc2UgdG8gcHV0
IHRoZSBkZXZpY2UgbGV2ZWwgZnVuY3Rpb24gY2FsbCBpbiBkZXZpY2UgcmVzdW1lIGNhbGxiYWNr
Lg0KPg0KPiA+ICAgICAgICAgaWYgKHBzcC0+bWVtX3RyYWluX2N0eC5lbmFibGVfbWVtX3RyYWlu
aW5nKSB7DQo+ID4gICAgICAgICAgICAgICAgIHJldCA9IHBzcF9tZW1fdHJhaW5pbmcocHNwLCBQ
U1BfTUVNX1RSQUlOX1JFU1VNRSk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+IGluZGV4IDE1MDMzZWZlYzJi
YS4uNmVjNGY2OTU4YzRjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzE1LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
DQo+ID4gQEAgLTgwNCw5ICs4MDQsMTUgQEAgc3RhdGljIGJvb2wgc29jMTVfbmVlZF9yZXNldF9v
bl9pbml0KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICAgICAgaWYgKGFk
ZXYtPmFzaWNfdHlwZSA9PSBDSElQX1JFTk9JUikNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
IHRydWU7DQo+ID4NCj4gPiArICAgICAgIHNvbF9yZWcgPSBSUkVHMzJfU09DMTUoTVAwLCAwLCBt
bU1QMF9TTU5fQzJQTVNHXzgxKTsNCj4NCj4gSXMgdGhpcyByZWdpc3RlciBjb25zaXN0ZW50IGZv
ciBhbGwgc29jMTUgY2hpcHM/DQo+DQo+IEFsZXgNCj4NClllcywgY29uZmlybWVkIGZyb20gdGhl
IFBTUCBmaXJtd2FyZSBndXlzIHRoaXMgcmVnaXN0ZXIgY2FuIGJlIHVzZWQgZm9yIGluZGljYXRp
bmcgdGhlIFRPUy9TT1MgbGl2ZSBzdGF0dXMgb24gdGhlIFNPQzE1IHNlcmllcy4NCg0KPiA+ICsN
Cj4gPiAgICAgICAgIC8qIEp1c3QgcmV0dXJuIGZhbHNlIGZvciBzb2MxNSBHUFVzLiAgUmVzZXQg
ZG9lcyBub3Qgc2VlbSB0bw0KPiA+ICAgICAgICAgICogYmUgbmVjZXNzYXJ5Lg0KPiA+ICAgICAg
ICAgICovDQo+ID4gKyAgICAgICBpZiAoYWRldi0+aW5fc3VzcGVuZCAmJiAhYWRkZWQtPm1pY3Jv
cGxhdGUgJiYNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzb2xfcmVnKQ0KPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArDQo+ID4gICAgICAgICBpZiAoIWFtZGdwdV9w
YXNzdGhyb3VnaChhZGV2KSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+
DQo+ID4gQEAgLTgxNiw3ICs4MjIsNiBAQCBzdGF0aWMgYm9vbCBzb2MxNV9uZWVkX3Jlc2V0X29u
X2luaXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgICAgICAvKiBDaGVj
ayBzT1Mgc2lnbiBvZiBsaWZlIHJlZ2lzdGVyIHRvIGNvbmZpcm0gc3lzIGRyaXZlciBhbmQgc09T
DQo+ID4gICAgICAgICAgKiBhcmUgYWxyZWFkeSBiZWVuIGxvYWRlZC4NCj4gPiAgICAgICAgICAq
Lw0KPiA+IC0gICAgICAgc29sX3JlZyA9IFJSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9D
MlBNU0dfODEpOw0KPiA+ICAgICAgICAgaWYgKHNvbF9yZWcpDQo+ID4gICAgICAgICAgICAgICAg
IHJldHVybiB0cnVlOw0KPiA+PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
