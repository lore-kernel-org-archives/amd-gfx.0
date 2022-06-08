Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E7C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 19:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0B01130BF;
	Wed,  8 Jun 2022 19:02:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B231130BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 19:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX0LCPjbeHzhLQLIfHvMfSeVw1bCKElO8LUz7k5JVJlUQZsvO8XreI/gF2heXU78Vl6vvUYo95odFbwiP9cxqs+ZadYyOp38hCLcdYFJgHA9DssXCk81kQFse0DiG1on0Xn22H7UYPlSUxmwBWE7G0aev1FaGmzrjnr/HmJnA6HnZ540tmeYXOBd7ppfvXrB5lym3q6sFnD44GPa7wrX1wCp9vZk0sx6oO8jg2xAZsl62RxtdRGjYzcmgkfY2z+nDrpKjfobeRJcyuTSM0rVz3QOTneUbO0z6FfBMBRQFEIG8EpVMI28NaDhfco0d0HRZ1AqymNEjEdbdCuHK2ysVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYd5gwTj3N32UXAY9LITI+POwOWZJpkLCVdFjxYxLlE=;
 b=h7OkYjRYLfdUiahObrdaA6mFWcZ1K+woIBwMAXEtHcA7bdaKazxIXnIoDv7U5ziJDZ/vyoiojGdlFEF9be40KKHLbTrrb9thWlJrcJjb/OcB0hdT/6+uRZv4TQvwB4FY4fneSnpfkwhfcVOIKP2GshsrCKGTNB2FPldFVXtSEDhG5vGgJTdHcdcXKYqv3DKJZcoyugv3w1ua5WOJZWk88AJJP+okPVCg1pWuKjU2G7ZpVLL+6Jbm5rvrr0Fhls7YtyxTv+vTBJ0EXYsqRp8Vh3sejGsyHT1J3L5v2fBQr7uYbE7OW/JvFbk/wJb0HfC1HAWLqCO/fiMGYdSxcPniUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYd5gwTj3N32UXAY9LITI+POwOWZJpkLCVdFjxYxLlE=;
 b=0MTcSnqWIQKK6uF/FCGS1mrDqPeVc6K5qlajV7G3Xznfu4POPiARNmOXrplzte2sSAdnQpRO51pirrunY1xLu5yu2LtLAc98VAKFyhm4ttmY3NSw7PibkRgrKLlB3Q0hTVnhnQawO55X80SXXAIqKtMmA/YXiJS0t8oKtZZrF0k=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by MN2PR12MB3294.namprd12.prod.outlook.com
 (2603:10b6:208:af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 19:02:53 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::d02b:a0eb:3e6c:d2e9]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::d02b:a0eb:3e6c:d2e9%12]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 19:02:53 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Subject: RE: [PATCH 07/16] drm/amd/display: Cap OLED brightness per max
 frame-average luminance
Thread-Topic: [PATCH 07/16] drm/amd/display: Cap OLED brightness per max
 frame-average luminance
Thread-Index: AQHYd4ZFyRRQA+bOfUejDQXIxUf0va1FTqYAgACR6yA=
Date: Wed, 8 Jun 2022 19:02:53 +0000
Message-ID: <BN6PR1201MB0084E4AC3B3130EA728CBFC389A49@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20220603201147.121817-8-hamza.mahfooz@amd.com>
 <848cd255-835d-20ee-27fc-744d43fc98c1@canonical.com>
In-Reply-To: <848cd255-835d-20ee-27fc-744d43fc98c1@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a971383c-44f4-4bdc-8a3d-6eb0d603cdd8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T18:44:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5510dc0-d74c-48b3-24c5-08da49817dc4
x-ms-traffictypediagnostic: MN2PR12MB3294:EE_
x-microsoft-antispam-prvs: <MN2PR12MB329488305F35AE9C0DA8876689A49@MN2PR12MB3294.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HRA01p+TDktpBmMr0lnhWfUpwcWZyWOfVEwncUgzbv4EwdAGQu+sCNxSbAEdgXSt2Cr/Ibu5d3JvrFzdm2y5IIxX0Kv98FH3y3EwJOcdz6wOxFFRsFWV8PEtFuJmfH4P9AAE3LjDlD4Hs2IfcGALy04XRd39mCZEMh2+JsKh5L2srwl+x2czNMHHp74ckHpz6Jg8iD6BhIHLtEmkHEVrUUq4OAa5zUyYz8EQ1qjtLPb99TbOWlr3mFVAnJyzvo0/J1bvs2hTlj49s+bqZNPDWM4IS2RH3uDO7VI4g3QxOWUxy22Dj12VCeZH6njVkgFc+O8H47h7rPgf8t7pLqG6jHHXmSFKXawoqBCCx1pvOoaELUAX1BZfQc9TZ08fMo8VC6C5Szmmb8j7ymr85JN7TTp+U1xS0A3AW7cBuOnFNVo9yfh3E/cd7nzWI4fnCOtUUjEXmVoy7a2Yjvjwf5bXDctU3qMiYHq2oGWdMJrDFdqoIH0tlKewheAQp1PdpScvWimFf07V/QPfrxVUHWiiDiGPRyQJwJMzus3ha25ynHLssljhl1eIWVapLT2Ed3/OO4WI2xEHqsluondVNkr5Jvo4ooWFaF3DHxvetqo06JkoRN9+v9lSZA/HQxB0BQY8XL+VzWi0C0ImFvNjALgvGG3ee0dXJeNSEwzwuTsDx0vbDGYUsUkDj2mFIBVPE9kPJpo5tyjCWkre3Fv6vGjog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(4326008)(508600001)(38100700002)(66946007)(4744005)(52536014)(122000001)(5660300002)(55016003)(71200400001)(86362001)(66556008)(66446008)(8676002)(8936002)(64756008)(66476007)(2906002)(83380400001)(7696005)(53546011)(6506007)(186003)(33656002)(26005)(9686003)(316002)(54906003)(6636002)(110136005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1hvM3VSeHEwdkQ0T0Z1eHR3ait0TUtzRXFaTWtOd3JVdEJwK0dXNU5TanBB?=
 =?utf-8?B?b3JIRTFYbkJPckl3NWlGTGtYLys2QjArWFU5RmVwZnUyb3kzQXh3MXpFd3Jp?=
 =?utf-8?B?Q01QajhOcWs2U05NT1pNSlB0RnYxOWpFc3IwbGhRNUlmUjdPcGNjYzkzRDd0?=
 =?utf-8?B?eHR2cUFDSnhaNGJKNE1zdlNtWFBkdVN2VTJQS2lSRm9xTE9pbEQ2RmJYQ1RM?=
 =?utf-8?B?Z1o3R0JwUEx1RFRjSTlUOVZVWnZoYTF4Qy93RnIxQndjQnBiUXdaWTFFTlFX?=
 =?utf-8?B?WW1IY3R5d1U1TWlRUlpuZDlvQVRiZkZtRlRkRUhkQTBSMGpEbCtQU0wyWHhm?=
 =?utf-8?B?RWR1VWZZRm54S3Vtdkxick1vMEpCRlhrZG4wTHpKWlM2Y3dQcGE3eTJSMGNX?=
 =?utf-8?B?a0czemJXeEVBcGhIYzJoSENPQU10SEh6WlFPTm1CV0VGR3I4SmxZL24xS3Bl?=
 =?utf-8?B?ODlod1ZlTmNWd21SSWtmd3RnTFVsd2YrWWl6WC96N3ZrYzIwYkkzZ1Fqbmg4?=
 =?utf-8?B?K1dWVHZIYXJOWGNick1lOVpPV3JrT0NzdVlYR3E0RGs1b1UrbkpyQi80MzVz?=
 =?utf-8?B?RFZWaTFla29HUjJTZmt5cDJtWm1RbE5XNE1iVnBpOEptcm9UaFRPcGREeWIz?=
 =?utf-8?B?SGlOemVNTXNIZkNYaUZUejF2Z0tVU0FDMDZ1ZzJBYWFDM1lreGxQa1hNRmtU?=
 =?utf-8?B?TFdSNWpoV1NveWgxT1djTmtSSkh5QnpFQlhMNzJJWmY2cUhYcXptaCtveXp2?=
 =?utf-8?B?MEJxRW94ak9vTk5uaHF4U2JmN05Kb1c0VzBDejZzaTdlZEdKM1U0MW40T1BE?=
 =?utf-8?B?NERHUGMrZTNaUXZPaUF3azZkeitUS1JjaThXUkxCT3phZkRkaFdHemthRjJx?=
 =?utf-8?B?VGFUQmpCazlad0RTcGpPZmF0MDdwR2x2cDNMQkltcVZmczZZUGl0Z1MxaXdR?=
 =?utf-8?B?WDQ1SFVkYkpPQzV6dnlnNHg2NVJiUEplVVJVdlV6cjljR2JvOUQzd2VoYWps?=
 =?utf-8?B?ZkhvT2xVeTFqeTJnMG1BMFRRT3NVdGFWSXZjbEN1b1F1UTB5NzJleEhCY2tE?=
 =?utf-8?B?eWtPYkx5Sk5OdzhWMHRoVG8raUdVRFR1Y2dxQWkvSm8vczFENG4vVEl5Q2Jk?=
 =?utf-8?B?TlQ0WTZQY3JlZ0ppYjYwQzlkSStZbzUxQjcwRTkzTGN6eE9pYTNWSFQwN3NV?=
 =?utf-8?B?NThIeWNXL0dUUFhEcUdKTXhwaTdRTnVoSUFxV1Y1U2h2UHk4ejBhRjNrcW9S?=
 =?utf-8?B?RmY4aDVGMnQwV3llMEo1R1pQd2t4Z1JZSnlSZ3d4QnozZ2xEdkxlSVBEMEZO?=
 =?utf-8?B?NGRlMlhxakthalRNQ2ZhS1g3S3R3TGVqMklpQUthM3dLbndqbElhVEhzcW9P?=
 =?utf-8?B?T01BK01GdXN6bnpkcVpjZ0FlcFV5dVJ6SmU0ZWhzTHg3SVNLZUkydEF5MjZY?=
 =?utf-8?B?WldKWHBBcDlWWjAxRGswNDVyNVBtSlQySVE3cEtkZ3NncXB0NGlTTEpSNXI2?=
 =?utf-8?B?bUxYWDV1cU1MTUtTdXd0dFY2RmlyNW9GcTJlMytWeDFRS1Y1T1BZYzd6MEVu?=
 =?utf-8?B?czVUc1ZXWkVISW1PS2htN05Dck55RmVRSCtZVHpadU1FTzM1ZzV4bnFvZVpD?=
 =?utf-8?B?dEdad1FGeC8wYTQyeUpEd2Q4NUdEaGxCNlN5ZjRVTTFHVWdRTEdlU0J0YUVN?=
 =?utf-8?B?NFpJM015aDFLaldTSnZCaVcxdzVUOFY2czZieE96U0tJT0trZmpPbi9JaER1?=
 =?utf-8?B?YWRWb012Z3RxMGxCL0pGQndqV3VMUDhzRTJsMHZtalkwbnc1bjlIU2NsUXFL?=
 =?utf-8?B?TWVlTHVDMVdxSTQzTGMxOTg5dVYxNXNkNUU2QjBWcUFlRHJhMTlwMVNoYUUx?=
 =?utf-8?B?SGtIUVViN2Z0TmE0cmd6c09ESXh0OFVjVFJMWGtramh2cGVjclZnV2loeHcz?=
 =?utf-8?B?c3BhTnJzczBXOWNMRm83dzZERUJWY0Q4QXF0eEg1WSsxZE5pWWdZUjhxd0pL?=
 =?utf-8?B?S00ydUU1b3NZUUFhem03WXZDZ2hEdlpjNDBwMm4zY29Jcjloc3NYTUVxS0dH?=
 =?utf-8?B?WjhPcG56Wk1pd01vd280UCtlR2FiZ3A2OHRrNUtFQjloaHdCUmwySk83S1l1?=
 =?utf-8?B?aDlZNGJBa0FHK29nZEtGeHpJalJnWDZSSE5nNWx3YUhweVV6RmdIYXFZSUY5?=
 =?utf-8?B?WGJsZnBrclpzbm5qYm9wNXlxTVZXR09HQllES1J6UnpwRlNSZDFnTWhYSDNT?=
 =?utf-8?B?Zm96dlp4OUx0Z0pDaWRDN0VoL2piUnJYSVoxaU84QTM3YjRIQk14VGhYenA4?=
 =?utf-8?Q?kRuIXsDqh2N66ePHTI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5510dc0-d74c-48b3-24c5-08da49817dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 19:02:53.5336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYvDcymFw5Bibob3eRRAfrIa6CGehZRstnwCCelt74peJfa0lLC6XEBW9jEZT3/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Kovac,
 Krunoslav" <Krunoslav.Kovac@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFhcm9uLA0KDQpZZXMsIHRo
ZSBwYW5lbCBicmlnaHRuZXNzIHNob3VsZCByZWFjaCBtYXggYWZ0ZXIgd2Ugc2VuZCBtYXgtZmFs
bCB2YWx1ZSBhcyBiYWNrbGlnaHQgY3VycmVudCBwZWFrLg0KDQpUaGFua3MsDQpSb21hbg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFhcm9uIE1hIDxhYXJvbi5tYUBj
YW5vbmljYWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgOCwgMjAyMiA2OjAyIEFNDQo+
IFRvOiBNYWhmb296LCBIYW16YSA8SGFtemEuTWFoZm9vekBhbWQuY29tPjsgTGksIFJvbWFuDQo+
IDxSb21hbi5MaUBhbWQuY29tPg0KPiBDYzogUGlsbGFpLCBBdXJhYmluZG8gPEF1cmFiaW5kby5Q
aWxsYWlAYW1kLmNvbT47IExha2hhLCBCaGF3YW5wcmVldA0KPiA8Qmhhd2FucHJlZXQuTGFraGFA
YW1kLmNvbT47IFdlbnRsYW5kLCBIYXJyeQ0KPiA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IFNp
cXVlaXJhLCBSb2RyaWdvDQo+IDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBMaSwgU3VuIHBl
bmcgKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT47DQo+IEd1dGllcnJleiwgQWd1c3RpbiA8QWd1
c3Rpbi5HdXRpZXJyZXpAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgWnVvLCBKZXJyeSA8SmVycnkuWnVvQGFtZC5jb20+OyBLb3RhcmFjLCBQYXZsZQ0KPiA8UGF2
bGUuS290YXJhY0BhbWQuY29tPjsgWmh1bywgUWluZ3FpbmcgKExpbGxpYW4pDQo+IDxRaW5ncWlu
Zy5aaHVvQGFtZC5jb20+OyBDaGl1LCBTb2xvbW9uIDxTb2xvbW9uLkNoaXVAYW1kLmNvbT47DQo+
IFdhbmcsIENoYW8ta2FpIChTdHlsb24pIDxTdHlsb24uV2FuZ0BhbWQuY29tPjsgTGluLCBXYXlu
ZQ0KPiA8V2F5bmUuTGluQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMTZdIGRy
bS9hbWQvZGlzcGxheTogQ2FwIE9MRUQgYnJpZ2h0bmVzcyBwZXIgbWF4DQo+IGZyYW1lLWF2ZXJh
Z2UgbHVtaW5hbmNlDQo+DQo+IEhpIFJvbWFuOg0KPg0KPiBDYW4gdGhlIHBhbmVsIGFjaGlldmUg
dGhlIG1heCBwZWFrIGx1bWluYW5jZSBpZiBpdCBpcyBsaW1pdGVkIGluIGZyYW1lLWF2ZXJhZ2UN
Cj4gbHVtaW5hbmNlPw0KPg0KPiBSZWdhcmRzLA0KPiBBYXJvbg0K
