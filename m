Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375DCC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 05:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7251410E422;
	Thu, 13 Oct 2022 05:26:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80CC010E422
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 05:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR75f3HstVKIOd+2wLTBFOyqnQTgybZ27V2KNfQVp4TN1WVpsGjW4IiZLIC8jAyS1fKuRjZjEMIVtWfhmdfb4SeMKQ8+Ph+ndj3NDRvWGAHi1Y2vHx0d4K+yCJ9wte6+j2AheXA7/rGUSa3I1oXkxMJYKN9Mku2OgYFe/wkSdhCmkKtq+SOoSkwJZ7x1YmdEopwx0y/mPmImRuWESTnmBxrjP51YsTasAMNbL391lPmM5PFh6Qx/1F1JhNtDiFDvmaLzJJofFMnCpDy/gbC4AC4hSfxcLvyZorGjnRX6POjw6k6mD0shziQ/X2icVvTNE+dZWMm7UASYt89IInkILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgT8mjV2ULvrb4PFQ6+OSpnBGx4IjdfiEisyf1GKep0=;
 b=bf77UlsZOSOkHL5BivtSM1bxN37m94V5Q/tR/MN0dEyJNQ7TRLY4dXpQcD0t9tfcYo1Kbvmdd1a+YttYr5mylikdGAK56M4xx1/IvL17BWPB1SoMO7CrnYtyPzYbPrEjWHZZHubYoA3MpDwSjrtEzCjKsGiiYgHhAjA2IF1CrXwIGodXZyFwICMr7LfjmmGqzkbxRut89xg0+5LH3+azpQLOzTDHRNUhKbWPUMtAZQ54DYWs4BhC2kOB+b1UeRFB+TNX4iRDUkoGRp9il4OndxR/4HZiCCTUKiuqEFoC1IJKJD8Ii3VrhtsjeBzLDaqzKdyogoSMzkwhMQl9cSveMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgT8mjV2ULvrb4PFQ6+OSpnBGx4IjdfiEisyf1GKep0=;
 b=S4fEMoHLKCjF+Xzd7yK8yZPe4Z19mtTeU9Ri7XuSeoZAh4wC675U3bvTXioYSBGiAVTR1eJXzockEZYZfVKPxofLNLgPBKsf0F0CjnDTtcgwqemmyG2/p8WJngiTZnxMBr5Pb2CLz9eJtKmlvF7/JFtnx6WJCV5fnHAEQNK/dOM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Thu, 13 Oct
 2022 05:26:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5bec:8c52:5bb9:3f0e]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5bec:8c52:5bb9:3f0e%7]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 05:26:34 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 3/3] drm/amd/pm: disable cstate feature for gpu reset
 scenario
Thread-Topic: [PATCH V3 3/3] drm/amd/pm: disable cstate feature for gpu reset
 scenario
Thread-Index: AQHY3qOe9vQtQiAyDUSErypAdpUrQK4Lt0mAgAAS2oA=
Date: Thu, 13 Oct 2022 05:26:34 +0000
Message-ID: <DM6PR12MB26198A696F4DBFE65C8067C0E4259@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221013013141.75369-1-evan.quan@amd.com>
 <20221013013141.75369-3-evan.quan@amd.com>
 <b0888073-7636-bc8e-11df-eb6b32c0e8ac@amd.com>
In-Reply-To: <b0888073-7636-bc8e-11df-eb6b32c0e8ac@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-13T05:26:31Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64353141-9c69-4788-98a3-0226cdf5c5a9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|IA1PR12MB6483:EE_
x-ms-office365-filtering-correlation-id: e4f8dd6f-56df-49cb-3e3f-08daacdb7e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDpW8kqcuvXwLI1SDmo6oQYmnYeHxsy7MRaL2koMvFjusMg2DHn6fpUSxNN7iB5JFOrnr108GrBaJ7wXGEUIV1NPgIArHLk9KAhCckXfmKFjkCB+Hbj9oqAWakOuD55yunuMQCpVyjHC5RRY9RjCV83q7zs3yB2Pljk1mui3R1J8nXHRM5F97Ok1AUPgntdsopTuq2IZvddpen36AWLKyc446yFTE8EtPefnguRupLRayzHw1NjEb5YhfK6qapKrSiOc04bBkQ3qcVcE/HzmIygVOefQv+ksnkHCq5qKti68jtqWCCbgo0rscJhp+SuBZjt452Q07r94O7yDurnm2K6nCbCTj0rAhutQOfngZNU17pZ4v73LSxtE9zZUU0N35+YKzHG+qC42tFezUiadTnimiO4lT1Z43Vj1ceJmpa9gbB8hqRMbj2pqmSfMHqZ+D5GqmbnOjdDQ6Abyz7H6stk7YF8lE7aPbNjiSaPNP7+lhFhW+dKsKBvwT+mf4wdXcrkEYwXbyW8EJkziSiJ+XXZHPAIOyGyOXdkU/0ehuO55Ij5gKuXj4/TOJa/gcPSBfhHVobbq08dMmAKKuLsc1PaexjueQrDM8o92NMlbM9EnL/lfCT19h9DWiM2GiOqLh91F2CUOJy6k3xumwtLHQNuhHefqvqzMeAH8gagvfJM5YShNyXBqMAYFJkg49xvXZ0ocCBtmHybLUYR9zDdD4Y96PM8adkGUW6ZRH5zxTdeow5qVuzCBpa5ZMHD67CgfL0ZnXXGdWGgSe7IRS1aQPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(5660300002)(54906003)(8676002)(110136005)(76116006)(316002)(66446008)(64756008)(71200400001)(478600001)(4326008)(66476007)(8936002)(52536014)(9686003)(53546011)(38100700002)(41300700001)(66556008)(33656002)(2906002)(186003)(55016003)(7696005)(83380400001)(26005)(66946007)(86362001)(122000001)(6506007)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpvSFd4OTVrWmNUdzhBNWc4b0tsaTdFcENhVy9tZWVMcVd6S3Q4WTgzSDkz?=
 =?utf-8?B?Mk9LMzVZNDNOdnV3MVJ1Nkpadm56L3Fxbm1XTHBqdWZzenZESU54TmQ5c0px?=
 =?utf-8?B?aytvcWM2UDJ3d1krWXFFNzQ5bEkxb243UjJxWGdwSUpVRU9sdFBqdVp0Mkpn?=
 =?utf-8?B?S1RDd3Rzb2hPb3J1SVN0cGtCOFV3NC9mV0w2QnkxdUREM3RRbHNUT0JSMDNx?=
 =?utf-8?B?b05EalVkbDh2K2pGREhoMG5mc2pKNm9VVTVyMnY2Z3pTbmJvdSsrYnRSTEtW?=
 =?utf-8?B?SkRJb3hLS3JYRnJiUWp3SGVaYnIzaHdUeXhiWE5pcGxKMEJZOU82VmlwMkFh?=
 =?utf-8?B?Z1RISThRWWhtWEJXaTVWVkg1OTZyU0J4N09BeUQ4MFE2cm8xWjlheldNRTJo?=
 =?utf-8?B?dzRzSHlqR0R6WEpxVkhuYjRzZG1wMVdSbGt5cHhrNUUyRVdTUjFpOXI3UHA0?=
 =?utf-8?B?ZUZ0cStHK0tyVmpDdVczdkJyWU5UdTV5MGFtbXNnd2YvVGdxWmVOcitNOHBD?=
 =?utf-8?B?YUhJOUYvcFhoSFlwZ0QwdWkxQ3EweHN6WC80S0FBMFN4ZE1iQTBkMlZhclZo?=
 =?utf-8?B?Q0M4cDFVVUZpVC9tMFdYK3Z1bGZxa1UzN2JFWW9nRWsyUjkrcjQ2S2pyemE4?=
 =?utf-8?B?QWtpNnpmZmg0UE4rclJoNkZKRXFqK09iSlM5SHFPb09tTGJNZERraU4vNFd4?=
 =?utf-8?B?amZrR3hFVFN0UlloTkwzTmlEZ0hKRFdKT0ZZZktBMmZndDIwanVidVY5cWFT?=
 =?utf-8?B?VTNmWkVjcXczME0wcjc2ZWRSdXpNdDRJSHczdVdqWS9BTnJheWxPaVNMRWEv?=
 =?utf-8?B?MEw0SEdjYWdmN2dlVk9SVWxQY2dUSTFjZTZscTJRdHAvMG5pRXhrditxWFNp?=
 =?utf-8?B?QjBiTzc1NzN1dDBENFhXZVFoZnowV1VqbEgxZUtaZndiaVZxUFc1VmVtTmQ0?=
 =?utf-8?B?RCthajV5NVhsL0wwcFpYRDVsYUtmQ3gvRmdTcG5xWVRQckVOV2FqRll3dFpO?=
 =?utf-8?B?VHIwQzlzcVZlRHA5ZGtuZlVOVXRJdDJxVjlIMEVacUE5Z2RaVWpTOTJBQWJq?=
 =?utf-8?B?TG5vNG91YXIwWG8rRWRCQnhzZC9tcGZhc2dhemdGRVprVUFuQ2JqbDRlc0Vo?=
 =?utf-8?B?OE1hVGp2a0I2ZlBPUGV2NnBSUWorSjc0b0FFY2hueTNxV2RMRVV2VkhsVzd1?=
 =?utf-8?B?OHNTNG5kRy9GZGNBejJHa1ViL3hRbDRjdWFLa0RSOUMvd1VzVjBBclNYSUtK?=
 =?utf-8?B?eVBQT3pUdm83SmlHU2JrYWc1Rm9OcjZnMk11UG4zWUw1bnpHV08yOUt0TmlU?=
 =?utf-8?B?cUs3U2VlZDR1VlF0Uk9KblZIOE0rQ0RDY1laM3grakJxalRBUDU5QVhRR0dH?=
 =?utf-8?B?Zm1OQ0RiZTF3cjExQk5RdUUwSndpd0w2WWxwaVd4UTA2ckxzLzFJUVAwd2lE?=
 =?utf-8?B?S3FWZmpkVGNlT0Q5TFdRZEZuUGlDU3ZkQzlKY1Ryang4dkoyczhIVm5vV3hz?=
 =?utf-8?B?MEVEai9aNXc3QVZjNlBJMzNVcm1OaFlReWtNWHdIaDhlS3NNVHdCZUN5OEFl?=
 =?utf-8?B?Qit4TWl3N25lc3BCelBWRkxtd0NDaXdhTmcyT1JtQVBjaWROdHVDR2dBT1Vs?=
 =?utf-8?B?YUhKQTg1L0lHT1B5OUQvV1NZWDRWZEphdFJmOXJoZysydjU3S0hVNldRZTlE?=
 =?utf-8?B?UzFzeUhud29JaU5lQUZSYng5TXIrbS84RjVSbGdxSnJRb0hhNGdiejJ2SUMw?=
 =?utf-8?B?RU9NcXQ0OEJWWGhlSjlSRzBwU2phQWNkdktjR2FmM1QycUF6ZnY4bFVmSERq?=
 =?utf-8?B?VHJMOHFjRmJ2K0N5b1c3VDVOV1ZMNm1FakpRWkd4aW4rV3NGK2EzNlNOMHh5?=
 =?utf-8?B?U0VpR2tIMG52SDMzWENKY2o0aVJ4MkQ3ZHdDWGZSRGtmRUFuUFd3REkvTDlC?=
 =?utf-8?B?RFBWYjM1bTJ3amNFSksrSmYrdnpaMmNleVV4RllEZ0JrcWNodjJlRGZQVnJw?=
 =?utf-8?B?QWhyMEhxMXhJMlg1L0o2dWxlODFjUS8rTmg4OHNHVURBL3g3Vjg3cHpCeFBl?=
 =?utf-8?B?dXE5MkZ0WlJZdnJJTkFXWFdXK0orekkzSHpiUG1KVEFDWStmUjVuQjk5OWlC?=
 =?utf-8?Q?OxBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f8dd6f-56df-49cb-3e3f-08daacdb7e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 05:26:34.6707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X794k5p+cW7dG4vDBdefvQrxvrMQ5WzyGqyiV8vcI3MQcdqvtJz9usg7oPbt1a+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDEzLCAyMDIyIDEyOjE0IFBNDQo+IFRvOiBRdWFuLCBF
dmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFu
ZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIFYzIDMvM10gZHJtL2FtZC9wbTogZGlzYWJsZSBjc3RhdGUgZmVhdHVyZSBmb3IgZ3B1DQo+
IHJlc2V0IHNjZW5hcmlvDQo+IA0KPiANCj4gDQo+IE9uIDEwLzEzLzIwMjIgNzowMSBBTSwgRXZh
biBRdWFuIHdyb3RlOg0KPiA+IFN1Z2dlc3RlZCBieSBQTUZXIHRlYW0gYW5kIHNhbWUgYXMgd2hh
dCBkaWQgZm9yIGdmeG9mZiBmZWF0dXJlLg0KPiA+IFRoaXMgY2FuIGFkZHJlc3Mgc29tZSBNb2Rl
MVJlc2V0IGZhaWx1cmVzIG9ic2VydmVkIG9uIFNNVTEzLjAuMC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEhh
d2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEllYjRl
MjA0YzQ5YWJkNDA1YjFkY2U1NTljMmZmNzViYjM4ODdiNmY5DQo+ID4gLS0NCj4gPiB2MS0+djI6
DQo+ID4gICAgLSByZXZpc2UgdGhlIGNvZGUgY29tbWVudHMoQWxleCkNCj4gPiAgICAtIGxpbWl0
IHRoaXMgdG8gU01VMTMuMC4wIGFuZCAxMy4wLjcNCj4gPiB2Mi0+djM6DQo+ID4gICAgLSBtYWtl
IHRoaXMgaGFwcGVuIGJlZm9yZSBkaXNwbGF5IHN1c3BlbmRpbmcNCj4gDQo+IEEgYmV0dGVyIHRo
aW5nIHdvdWxkIGJlIGRvDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMgICAgICAgICB8IDggKysrKysrKysNCj4gPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTEvYXJjdHVydXNfcHB0LmMgIHwgNyArKysrKysrDQo+ID4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyB8IDcg
KysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBp
bmRleCBhYjhmOTcwYjI4NDkuLjg3NGJmNjIzZjM5NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtMjkyOCw2ICsyOTI4LDE0
IEBAIHN0YXRpYyBpbnQNCj4gYW1kZ3B1X2RldmljZV9pcF9zdXNwZW5kX3BoYXNlMShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIAlhbWRncHVfZGV2aWNlX3NldF9wZ19zdGF0ZShh
ZGV2LCBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4gPiAgIAlhbWRncHVfZGV2aWNlX3NldF9jZ19z
dGF0ZShhZGV2LCBBTURfQ0dfU1RBVEVfVU5HQVRFKTsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAq
IFBlciBQTUZXIHRlYW0ncyBzdWdnZXN0aW9uLCBkcml2ZXIgbmVlZHMgdG8gaGFuZGxlIGdmeG9m
Zg0KPiA+ICsJICogYW5kIGRmIGNzdGF0ZSBmZWF0dXJlcyBkaXNhYmxlbWVudCBmb3IgZ3B1IHJl
c2V0KGUuZy4gTW9kZTFSZXNldCkNCj4gPiArCSAqIHNjZW5hcmlvLiBBZGQgdGhlIG1pc3Npbmcg
ZGYgY3N0YXRlIGRpc2FibGVtZW50IGhlcmUuDQo+ID4gKwkgKi8NCj4gPiArCWlmIChhbWRncHVf
ZHBtX3NldF9kZl9jc3RhdGUoYWRldiwgREZfQ1NUQVRFX0RJU0FMTE9XKSkNCj4gPiArCQlkZXZf
d2FybihhZGV2LT5kZXYsICJGYWlsZWQgdG8gZGlzYWxsb3cgZGYgY3N0YXRlIik7DQo+ID4gKw0K
PiANCj4gSWYgaXQncyBvbmx5IHJlbGF0ZWQgdG8gZGlzcGxheSwgeW91IGNvdWxkIG1vdmUgdGhp
cyByaWdodCBhZnRlciBiZWxvdyBsaW5lIHNvIHRoYXQNCj4gaGVhZGxlc3Mgc3lzdGVtcyBkb24n
dCBuZWVkIHRvIHRha2UgY2FyZSBvZiB0aGlzLiBUaGF0IHdpbGwgYXZvaWQgYW55IHNwZWNpYWwN
Cj4gaGFuZGxpbmcgbmVlZGVkIGZvciBBbGRlYmFyYW4vQXJjdXR1cnVzIGFsc28uDQpbUXVhbiwg
RXZhbl0gTm90IHF1aXRlIHN1cmUuIEkga25vdyBkZiBjc3RhdGUgYWZmZWN0cyBEQUwgYSBsb3Qo
TUFMTCByZWxhdGVkIGZlYXR1cmVzKS4NCkJ1dCBJJ20gbm90IHN1cmUgd2hldGhlciB0aGVyZSBp
cyBvdGhlciBjbGllbnRzL0lQcyB3aGljaCBhcmUgYWZmZWN0ZWQgYnkgZGYgY3N0YXRlLg0KSSB3
YW50IHRoaXMoY3N0YXRlIGRpc2FibGVtZW50KSBwZXJmb3JtZWQgYmVmb3JlIGFsbCAnY29uc3Vt
ZXJzJy4NCg0KQlINCkV2YW4NCj4gDQo+ICAgICAgICAgICAgICAgICBpZiAoYWRldi0+aXBfYmxv
Y2tzW2ldLnZlcnNpb24tPnR5cGUgIT0NCj4gQU1EX0lQX0JMT0NLX1RZUEVfRENFKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4g
DQo+ID4gICAJZm9yIChpID0gYWRldi0+bnVtX2lwX2Jsb2NrcyAtIDE7IGkgPj0gMDsgaS0tKSB7
DQo+ID4gICAJCWlmICghYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy52YWxpZCkNCj4gPiAgIAkJ
CWNvbnRpbnVlOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTExL2FyY3R1cnVzX3BwdC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTExL2FyY3R1cnVzX3BwdC5jDQo+ID4gaW5kZXggNDQ1MDA1NTcxZjc2Li43ZDM0ZjQwNDYw
ZWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9h
cmN0dXJ1c19wcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvYXJjdHVydXNfcHB0LmMNCj4gPiBAQCAtMjI0NSw2ICsyMjQ1LDEzIEBAIHN0YXRpYyBpbnQg
YXJjdHVydXNfc2V0X2RmX2NzdGF0ZShzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSwNCj4gPiAg
IAl1aW50MzJfdCBzbXVfdmVyc2lvbjsNCj4gPiAgIAlpbnQgcmV0Ow0KPiA+DQo+ID4gKwkvKg0K
PiA+ICsJICogQXJjdHVydXMgZG9lcyBub3QgbmVlZCB0aGUgY3N0YXRlIGRpc2FibGVtZW50DQo+
ID4gKwkgKiBwcmVyZXF1aXNpdGUgZm9yIGdwdSByZXNldC4NCj4gPiArCSAqLw0KPiA+ICsJaWYg
KGFtZGdwdV9pbl9yZXNldChhZGV2KSB8fCBhZGV2LT5pbl9zdXNwZW5kKQ0KPiA+ICsJCXJldHVy
biAwOw0KPiA+ICsNCj4gPiAgIAlyZXQgPSBzbXVfY21uX2dldF9zbWNfdmVyc2lvbihzbXUsIE5V
TEwsICZzbXVfdmVyc2lvbik7DQo+ID4gICAJaWYgKHJldCkgew0KPiA+ICAgCQlkZXZfZXJyKHNt
dS0+YWRldi0+ZGV2LCAiRmFpbGVkIHRvIGdldCBzbXUgdmVyc2lvbiFcbiIpOw0KPiBkaWZmDQo+
ID4gLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9w
cHQuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5f
cHB0LmMNCj4gPiBpbmRleCA2MTlhZWU1MWIxMjMuLjkzYTBmN2Y2YTM0ZSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3Bw
dC5jDQo+ID4gQEAgLTE2NDAsNiArMTY0MCwxMyBAQCBzdGF0aWMgYm9vbCBhbGRlYmFyYW5faXNf
YmFjb19zdXBwb3J0ZWQoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4gICBzdGF0aWMg
aW50IGFsZGViYXJhbl9zZXRfZGZfY3N0YXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiA+
ICAgCQkJCSAgIGVudW0gcHBfZGZfY3N0YXRlIHN0YXRlKQ0KPiA+ICAgew0KPiA+ICsJLyoNCj4g
PiArCSAqIEFsZGViYXJhbiBkb2VzIG5vdCBuZWVkIHRoZSBjc3RhdGUgZGlzYWJsZW1lbnQNCj4g
PiArCSAqIHByZXJlcXVpc2l0ZSBmb3IgZ3B1IHJlc2V0Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAo
YW1kZ3B1X2luX3Jlc2V0KGFkZXYpIHx8IGFkZXYtPmluX3N1c3BlbmQpDQo+ID4gKwkJcmV0dXJu
IDA7DQo+ID4gKw0KPiA+ICAgCXJldHVybiBzbXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFt
KHNtdSwNCj4gU01VX01TR19ERkNzdGF0ZUNvbnRyb2wsIHN0YXRlLCBOVUxMKTsNCj4gPiAgIH0N
Cj4gPg0K
