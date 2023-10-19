Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB91CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 01:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3A610E034;
	Thu, 19 Oct 2023 01:34:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F34C010E034
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 01:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/PXwxUhZgmmdefmy3cB8HWYS/Fv0BGzq2jPMEIKtFt2pvqWDQbmH+82HhdwaJTtjGIFRjzqfgOvokuF+1/rnqx1aWk1cEtAFAsl0r9yuTKJEUKJ87tp8VSJs1a+aE5dFtUaHAxL8wq4s5D6AfDlcQV2weAfga4ufqEMl7RPyGwYGQsxUUP4kaI50xlAc5qKw+nH26qZPr85t00pjxWK1Zz6XBu9W+p8/r4s4Rzoc5XmTbCHn+RmdJhVOmL5ttJlPE/je3jpAWisgiJ1+alUYyykR+ZWiOFcO7E/xim8az2fhJK6srmyUzUr067Edi/ASgtmDIT24FJam8uvz/qbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbInf6iHAmhHvOfXtcDxUZ5YH/tBPUaGpyL6GEQe1dU=;
 b=iKRyQF5e8lj0rpzzxPnK5jRHcHJeOOF22X68MrlqGTOXUNV3VLkIHWeLlWLBdPKuV1rP7D+PEfBgzL9sTeF80NrTOTBwf/2kpKxyq8UV7WKkQ0xeSCR66q/k1/xqOjW6tYpDYvBJuRxgWXm6pcKrfeFlTepPdhblOZkTtRSwTIQ9BRHpkoSPFvimQlgSeRjPh8/1xumZ1H5Ul2Z68nVrXvzFINGychZ4QUETiEvR3sOmPmVmGdwyfZmKBBqSxg1+4vYTOGXO6R58B/dtGnsJ/utoD2YHMZpKa1PjHdoTSuX/kVAodOk7N5BpsjRYHkVvdYXE3Y8UP3NxlertRW/MuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbInf6iHAmhHvOfXtcDxUZ5YH/tBPUaGpyL6GEQe1dU=;
 b=MC10xic0+5w+jceunyOHdWpvintdQp/t3tETbC8UGS+UK2ObkndhRd7se8I/jiMDl0P42sQXTtLfOd5qKO1Oh6m4xCpKDgefdsDS4lEbB3yFxQjWNVduLRN546Avgr7AiNpgg3o4TW9tosCnuWzzNDMPamtLPYXXf84557kb97g=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 01:34:22 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::2d0:bf6d:1f10:a57c]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::2d0:bf6d:1f10:a57c%5]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 01:34:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
Thread-Topic: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
Thread-Index: AQHaAZeo7exlTjjhski2itC47pF5+LBPjQ+AgAAVagCAACKeAIAAj8zA
Date: Thu, 19 Oct 2023 01:34:22 +0000
Message-ID: <DM4PR12MB515202D90219E87F76B3C19BE3D4A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20231018074931.139904-1-jesse.zhang@amd.com>
 <CY5PR12MB6369F24E1CC12D5682BAB3E3C1D5A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <ae14eee8-1cbc-8100-8390-1a9616a95a67@amd.com>
 <1bd427de-edbd-d121-d8d8-8d6bea3fe901@amd.com>
In-Reply-To: <1bd427de-edbd-d121-d8d8-8d6bea3fe901@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a0f89b3b-94d3-49e5-b32f-185cd33d000c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T01:31:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: 7cc2f612-4738-43c7-e658-08dbd04385ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKu6VUzpNrnIyzXarBxPiscg2bpUyZujOHuqHNTVyRCp7/qGDMZBF5qvCAUbwagh3uV+ufM0QxFHzHTFydjqnB361jjbIXgnSAOKZmzopKsB5TqpAp+dglJlVeGJByfxHK1OwhKz8a/SgFugvQlpQf+IH6MQBYira0HOELqPcCr71X9uTv8pFOfJOKG0zcZ5fEseBAycWYX5MAb8sgKG1ndiBdjLbO9Mc2IWyauDO/uVbjksaUn3VjxqFDEWT5JuoRajBSiGifnIAc8ZV5ZJuTasgSmX9IfgJo9EE6+sSabtsrw1CuGxXYV4Jn15Ck2yOSDvEniB/HzDfFtLMXRfrEbVf/7hRivbBEPwOqcNArCoK+lf54K8JuQKsrJtQPbUPtb3sha8Np+3SFs2hCeixIcsZ/viv3BSUge2x1xvZ/vR/uM6WDB6scwdsmkRPeZrAKOBQ92LMBy+bQB2zTG0ItTFn4U+Ssgl/qtDTL2X9xtEyfnhWYzNdUBXNl5qysekVrx4MisDVcVVmIpMOwFFoFwiJ0M2fHe9fEIx3cL/qX3OxzW82AFgY6RdJ2VRDiI3GmEcgzUeTFx4nN/K+kmA3oOJ7Dc5xibHCqC/n1cE5/T7UB5uKNGP2ztGy/NJM+ms
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(110136005)(8676002)(2906002)(33656002)(55016003)(5660300002)(4326008)(8936002)(52536014)(86362001)(41300700001)(4001150100001)(26005)(38100700002)(6506007)(7696005)(38070700005)(122000001)(9686003)(83380400001)(71200400001)(478600001)(54906003)(53546011)(66556008)(66476007)(66946007)(76116006)(64756008)(316002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3VPNThFVlZIL2Z0STF0Tkhrb3F0NEFQc2x0bmxvL3ZuZ20zd3BYd25Sbk9i?=
 =?utf-8?B?V2ZZR2ErV1FHMlltSE93ajd5aDRFMXFiaU53Z05rc2NWc1Q1M3NpYnk5bzZu?=
 =?utf-8?B?MW5peTZnNm9IV0dZSWJHYXJPWFBCN0JkNFZYcjQzUGpISXh4WlpnTzd4MDlV?=
 =?utf-8?B?bE1BTDllVXl1SUtidTF4UkJOM1FyR1p4M3ZuMnRXNndnN0Z1RExBMkp1NDFU?=
 =?utf-8?B?eExRNWN6L2hMVngrblJUS3pQWEVYUGF6amhzcFZKWVVvSi9ZZ1FkTXhEZG95?=
 =?utf-8?B?WllIR2h3L0syQ1BlMERwS2Z1N3MvQ1kyanVCUFlrRGlQcDA1VFh0a3R2cHow?=
 =?utf-8?B?UjRRKzZUVkFLcElNU0JDbTVieUVmcjJXWmN0b0dFZGtpaDh0RVlURCt0bGVv?=
 =?utf-8?B?VG9GZHhPMStldndTdC9zRUNVc3NtVm4zK1RmOCt4QmJ3eW1JSU9XcTJpeGtw?=
 =?utf-8?B?Rk5uMWMrWTAvMG9wa1ZsSXd3cDdjdWxYRVYvNUh3WG0xa2tTZitGWHlrdTNB?=
 =?utf-8?B?ZFM3TlRpM3ZycUlLcy9NeWc3SXRwM3BHTS9rZThRYXg4c3IwSGZKSk8wRzA3?=
 =?utf-8?B?aFVhTHpWRlpQM2szZzJST1JoUUp5enExM0oyZVlxYTdpR3dwNjB0Y2Q1QzBh?=
 =?utf-8?B?MlZZQUh0MzBid2sxNGdzOER1WEdxWlJUODM5UEczbk9QUjJISlYwMGtFd0Iv?=
 =?utf-8?B?OU4raitMUWxiWlVyRmtGUmJXb2l1N29GY3BKTjVtbmtLUS8wYmlGd3V1eWVZ?=
 =?utf-8?B?TzNienhhNC9RbnY3Nk0rVVNoN1B3cmdHajZtNmp6dFg5b0IxSG9BY1JFd01U?=
 =?utf-8?B?a0JZajF5c3IzeExsVkozUkpKMUNxVnR3QTVnWEhFWnhsOW9saG5hZUlIN21Z?=
 =?utf-8?B?aWpldE4zaExpZWhNN0pMb2pBL2MxT0hFcS9iTGM0dGpiL1RnSlVDZDFzeFJq?=
 =?utf-8?B?S3Iya0FOampOZ0dxU0FRSWZsWWd4R05ERi9FNHpLVG9Tb1lFMzNZZFY3clZG?=
 =?utf-8?B?N1dOWWVydFJBL1MwWWxkYVVyTDVoN1RvbERiajlDMFVDMnlISTA5cmd6Y0Qz?=
 =?utf-8?B?Nkk2aHdDc3o1YjBzNURCelpxblBkT2lIbXVDSHZqL2JiMlhoWGNpR3l6QVl4?=
 =?utf-8?B?bnlwdjdIdzB5VmlITzRRWkRORGpnYVAwYW1nUmFsT2Z4MkFIS2xFenVwZEtT?=
 =?utf-8?B?NW9lM1BncUxYT0NQOG1SRGlld29VUlgxQWtUbnF5NTNEM2R2ZFBxZUM1RlU3?=
 =?utf-8?B?RkdYOXVCREgrZnpkaXowSmtOejEzNXRVb0s2VTRtbEZXWU5teWY1WWJPUEdp?=
 =?utf-8?B?SFpnRWhVYkNmV0lrdFdra29LemVGNk1JMHAzYU1PN1ozd3lHV1RiVU5Ga1di?=
 =?utf-8?B?ODEreGo3YXZtdUF1UDdrRnlXQWs3RGpicytYa2dTRWw5bDhWajdhUnV0QXAv?=
 =?utf-8?B?bEN6SHcwa0tCTjlzS0hXa216UVoyTmdZNlBkaTc2QkNwaWlnYzFxOEJCL1Ft?=
 =?utf-8?B?WmlVY2ZQMlhtWW95OXNCVE1IbmlMTHhoOHkrQ0NzM21DMHhhOEcya1I3dDRP?=
 =?utf-8?B?QjFjZUZQZ2NMZEdXNGpYZDUvc0JNMk5TVXJNRkF1RTdOTHFwR0duQndJZmJX?=
 =?utf-8?B?MmEzTThqN1BBZkExanJtRTREVGpjQk9jU3RNT3JYZzJnQVJ2Zlo0N3pMbGh3?=
 =?utf-8?B?UC9OR0NqaHlWSzBRbFBseUJtM3AzbWNjZ1NFT0REYzdZeXk1UjRaWHBRM2NO?=
 =?utf-8?B?V0RpRjZkNTZUd3RuZUVHRFFpTy83M3c5b0VRdlgzRTFwd2NDSGpMQm5KNEJs?=
 =?utf-8?B?YkczVTB4S1lBelZPczVXbDU0T25mbktiQVBpdk1QNEFkM3dNUFBqMmY4RTZP?=
 =?utf-8?B?WmlORUhyUnVwOEFiWktRRm9KMjdGOGNEUXNDYjdQekZSQXRURVgzZWcyMllX?=
 =?utf-8?B?YUZ4RnFaYWRtNERZUkQ1VGxqMWxUK25DbkNqZkk0SzZ4RkF3anNIZ3k2Q1R3?=
 =?utf-8?B?aDdrVC82UmxlUFpWL09mQ0Y1RkY1K2h0VTBqNFJEN3lzK09VMnNDU01HZ05m?=
 =?utf-8?B?VldZMXIycGdNNDQyTXpYUG56VmMwNjMrTWRQL3c3eFduMkd5MUo2UncxL0M0?=
 =?utf-8?Q?YLcE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc2f612-4738-43c7-e658-08dbd04385ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 01:34:22.6683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0Ad9gBZ2SuOQwvU79ebwsKBvwGDfvSy3iU8Mq3gglPFY4otPaZsp5RSn4f1gMacXtvoU3Nie/vOJ1nzJLHWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBDaGVuLCBYaWFvZ2FuZyA8WGlhb2dhbmcuQ2hlbkBhbWQuY29tPg0KU2Vu
dDogVGh1cnNkYXksIE9jdG9iZXIgMTksIDIwMjMgMTI6NTcgQU0NClRvOiBZYW5nLCBQaGlsaXAg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29t
PjsgWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEt1ZWhsaW5n
LCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRrZmQ6IEZpeCBzaGlmdCBvdXQtb2YtYm91bmRzIGlzc3VlDQoNCg0KT24gMTAvMTgvMjAy
MyA5OjUzIEFNLCBQaGlsaXAgWWFuZyB3cm90ZToNCj4NCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNz
YWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1
dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25k
aW5nLg0KPg0KPg0KPiBUaGUgMjU1IGdyYW51bGFyaXR5IGlzIGZyb20gcmVjZW50IFRodW5rIGNo
YW5nZSB0byBpbmNyZWFzZSBDV1NSIGFyZWENCj4gZ3JhbnVsYXJpdHkuDQo+DQpJIHRoaW5rIHdl
IGFsc28gbmVlZCB0byBkbyBzYW1lIHJlc3RyaWN0aW9uIGF0IGNvcnJlc3BvbmRlbnQgcGFydHMg
aW4gVGh1bmsgd2hlbiBzZXQgcmFuZ2UgZ3JhbnVsYXJpdHkuIFNldHRpbmcgMjU1IGdyYW51bGFy
aXR5IGlzIGZhciBiaWcgYXMgZ3JhbnVsYXJpdHkgaGVyZSBpcyBsb2cgdmFsdWUgb2YgcGFnZSBu
dW1iZXIuDQoNClJlZ2FyZHMNCg0KWGlhb2dhbmcNCg0KPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRo
aXMgd2l0aCBrZXJuZWwgZGVidWcgb3B0aW9uDQo+IENDX0hBU19VQlNBTl9BUlJBWV9CT1VORFMg
ZW5hYmxlZC4gQmVjYXVzZSAxPDxwcmFuZ2UtPmdyYW51bGFyaXR5IGlzDQo+IHVzZWQgaW4gbWFu
eSBwbGFjZXMsIEkgdGhpbmsgdGhlIHByb3BlciBmaXggc2hvdWxkIGJlIGluIGZ1bmN0aW9uDQo+
IHN2bV9yYW5nZV9hcHBseV9hdHRycw0KPg0KPiAgICAgICAgIGNhc2UgS0ZEX0lPQ1RMX1NWTV9B
VFRSX0dSQU5VTEFSSVRZOg0KPiAtICAgICAgICAgICAgcHJhbmdlLT5ncmFubGFyaXR5ID0gYXR0
cnNbaV0udmFsdWU7DQo+DQo+ICsgICAgICAgICAgICBwcmFuZ2UtPmdyYW5sYXJpdHkgPSBhdHRy
c1tpXS52YWx1ZSAmIDB4M0Y7DQo+DQo+IEJUVywgZnVuY3Rpb24gc3ZtX3JhbmdlX3NwbGl0X2J5
X2dyYW51bGFyaXR5KCkgaXMgbm90IHVzZWQgYW55bW9yZSwNCj4gZm9yZ290IHRoZSByZW1vdmUg
aXQsIG1heWJlIHlvdSBhcmUgdGVzdGluZyBvbiBvbGRlciBzb3VyY2UgY29kZT8NCj5bWmhhbmcs
IEplc3NlKEppZSldIFRoYW5rcyBQaGlsaXAsIHllcywgbXkgY29kZSBpcyBhIGJpdCBvbGRlciBh
bmQgIEkgd2lsbCByZW1vdmUgdGhlIHVudXNlZCBjb2RlLg0KICAgICAgICBUaGFua3MNCiAgICAg
ICAgSmVzc2UNCj4gUmVnYXJkcywNCj4NCj4gUGhpbGlwDQo+DQo+IE9uIDIwMjMtMTAtMTggMDk6
MzYsIFpoYW5nLCBZaWZhbiB3cm90ZToNCj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5l
cmFsXQ0KPj4NCj4+IEhpIEplc3NlLA0KPj4NCj4+IFRoaXMgcGF0Y2ggaXMgb25seSBhIFdBIGZv
ciB0aGUgZXJyb3IgbG9nLiBIb3cgaXMgdGhpcyBpc3N1ZSByZXByb2R1Y2VkID8gMjU1IGxvb2tz
IGxpa2UgYW4gaW52YWxpZCB2YWx1ZSBmb3IgYSBwcmFuZ2UtPmdyYW51bGFyaXR5LCBpdCBpcyBi
ZXR0ZXIgdG8gcm9vdCBjYXVzZSB3aG8gc2V0IGl0IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+DQo+
PiBCUnMsDQo+PiBZaWZhbg0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBG
cm9tOiBKZXNzZSBaaGFuZzxqZXNzZS56aGFuZ0BhbWQuY29tPg0KPj4gU2VudDogV2VkbmVzZGF5
LCBPY3RvYmVyIDE4LCAyMDIzIDM6NTAgUE0NCj4+IFRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLdWVobGluZywNCj4+IEZlbGl4PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBZYW5nLCBQ
aGlsaXA8UGhpbGlwLllhbmdAYW1kLmNvbT47DQo+PiBaaGFuZywgWWlmYW48WWlmYW4xLlpoYW5n
QGFtZC5jb20+OyBaaGFuZywNCj4+IEplc3NlKEppZSk8SmVzc2UuWmhhbmdAYW1kLmNvbT47IFpo
YW5nLA0KPj4gSmVzc2UoSmllKTxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPj4gU3ViamVjdDogW1BB
VENIXSBkcm0vYW1ka2ZkOiBGaXggc2hpZnQgb3V0LW9mLWJvdW5kcyBpc3N1ZQ0KPj4NCj4+IFsg
IDU2Ny42MTMyOTJdIHNoaWZ0IGV4cG9uZW50IDI1NSBpcyB0b28gbGFyZ2UgZm9yIDY0LWJpdCB0
eXBlICdsb25nIHVuc2lnbmVkIGludCcNCj4+IFsgIDU2Ny42MTQ0OThdIENQVTogNSBQSUQ6IDIz
OCBDb21tOiBrd29ya2VyLzU6MSBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgIDYuMi4wLTM0
LWdlbmVyaWMgIzM0fjIyLjA0LjEtVWJ1bnR1DQo+PiBbICA1NjcuNjE0NTAyXSBIYXJkd2FyZSBu
YW1lOiBBTUQgU3BsaW50ZXIvU3BsaW50ZXItUlBMLCBCSU9TIFdTNDM5MjdOXzg3MSAwOS8yNS8y
MDIzIFsgIDU2Ny42MTQ1MDRdIFdvcmtxdWV1ZTogZXZlbnRzIHNlbmRfZXhjZXB0aW9uX3dvcmtf
aGFuZGxlciBbYW1kZ3B1XSBbICA1NjcuNjE0NzQ4XSBDYWxsIFRyYWNlOg0KPj4gWyAgNTY3LjYx
NDc1MF0gIDxUQVNLPg0KPj4gWyAgNTY3LjYxNDc1M10gIGR1bXBfc3RhY2tfbHZsKzB4NDgvMHg3
MCBbICA1NjcuNjE0NzYxXQ0KPj4gZHVtcF9zdGFjaysweDEwLzB4MjAgWyAgNTY3LjYxNDc2M10N
Cj4+IF9fdWJzYW5faGFuZGxlX3NoaWZ0X291dF9vZl9ib3VuZHMrMHgxNTYvMHgzMTANCj4+IFsg
IDU2Ny42MTQ3NjldICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weDdmIFsgIDU2Ny42
MTQ3NzNdICA/DQo+PiB1cGRhdGVfc2RfbGJfc3RhdHMuY29uc3Rwcm9wLjArMHhmMi8weDNjMA0K
Pj4gWyAgNTY3LjYxNDc4MF0gIHN2bV9yYW5nZV9zcGxpdF9ieV9ncmFudWxhcml0eS5jb2xkKzB4
MmIvMHgzNA0KPj4gW2FtZGdwdV0gWyAgNTY3LjYxNTA0N10gID8gc3Jzb19hbGlhc19yZXR1cm5f
dGh1bmsrMHg1LzB4N2YgWw0KPj4gNTY3LjYxNTA1Ml0gIHN2bV9taWdyYXRlX3RvX3JhbSsweDE4
NS8weDRkMCBbYW1kZ3B1XSBbICA1NjcuNjE1Mjg2XQ0KPj4gZG9fc3dhcF9wYWdlKzB4N2I2LzB4
YTMwIFsgIDU2Ny42MTUyOTFdICA/DQo+PiBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHg3
ZiBbICA1NjcuNjE1Mjk0XSAgPw0KPj4gX19mcmVlX3BhZ2VzKzB4MTE5LzB4MTMwIFsgIDU2Ny42
MTUyOTldICBoYW5kbGVfcHRlX2ZhdWx0KzB4MjI3LzB4MjgwDQo+PiBbICA1NjcuNjE1MzAzXSAg
X19oYW5kbGVfbW1fZmF1bHQrMHgzYzAvMHg3MjAgWyAgNTY3LjYxNTMxMV0NCj4+IGhhbmRsZV9t
bV9mYXVsdCsweDExOS8weDMzMCBbICA1NjcuNjE1MzE0XSAgPw0KPj4gbG9ja19tbV9hbmRfZmlu
ZF92bWErMHg0NC8weDI1MCBbICA1NjcuNjE1MzE4XQ0KPj4gZG9fdXNlcl9hZGRyX2ZhdWx0KzB4
MWE5LzB4NjQwIFsgIDU2Ny42MTUzMjNdDQo+PiBleGNfcGFnZV9mYXVsdCsweDgxLzB4MWIwIFsg
IDU2Ny42MTUzMjhdDQo+PiBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyNy8weDMwIFsgIDU2Ny42MTUz
MzJdIFJJUDoNCj4+IDAwMTA6X19nZXRfdXNlcl84KzB4MWMvMHgzMA0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEplc3NlIFpoYW5nPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPj4gaW5kZXggN2I4MTIzM2JjOWFlLi5mNWUwYmNjYzZk
NzEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPj4gQEAgLTEx
NjksNyArMTE2OSw3IEBAIHN2bV9yYW5nZV9zcGxpdF9ieV9ncmFudWxhcml0eShzdHJ1Y3Qga2Zk
X3Byb2Nlc3MgKnAsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLA0KPj4gICAgICAgICAgICogUFRFIHdp
bGwgYmUgdXNlZCBmb3Igd2hvbGUgcmFuZ2UsIHRoaXMgcmVkdWNlcyB0aGUgbnVtYmVyIG9mIFBU
RQ0KPj4gICAgICAgICAgICogdXBkYXRlZCBhbmQgdGhlIEwxIFRMQiBzcGFjZSB1c2VkIGZvciB0
cmFuc2xhdGlvbi4NCj4+ICAgICAgICAgICAqLw0KPj4gLSAgICAgICBzaXplID0gMVVMIDw8IHBy
YW5nZS0+Z3JhbnVsYXJpdHk7DQo+PiArICAgICAgIHNpemUgPSAxVUwgPDwgKHByYW5nZS0+Z3Jh
bnVsYXJpdHkgJiAweDNmKTsNCj4+ICAgICAgICAgIHN0YXJ0ID0gQUxJR05fRE9XTihhZGRyLCBz
aXplKTsNCj4+ICAgICAgICAgIGxhc3QgPSBBTElHTihhZGRyICsgMSwgc2l6ZSkgLSAxOw0KPj4N
Cj4+IC0tDQo+PiAyLjI1LjENCj4+DQo=
