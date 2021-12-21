Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E7EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 17:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BF110E148;
	Tue, 21 Dec 2021 17:03:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEAC10E148
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 17:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/b6+Q0RqMi+ecT3c1UH0Z+BrECMD9+zP+ReibpRgMo6vsBTRCoc6tNZUEqQP2Mi3brc0m5Pr6ji7LIU2xLaibTzaADQ2BcI2UuGLd7PEPFI0vY2t7gJChrKwkylJfahCYzw1gsk3V3D5BFL1jKqrZcruSeSz57HEbU19EyzGHHRvAjlRZfBUk/tnu87nqkp0WXC2ZVFfDH/cd5rIRpr7/625KRZRmAVnbUviCzhio3CbrS9W120TSYbAeRzaP6KQ60Yw6mvLVl4+xQcg+1pZ49rGSoTC/7snC0D2FuSSMuomBDpNSh6WJsUj8ff4cNytaZsnuvE84OzVvpMMsBiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78BzzsDRqRzvPY6S9lY400kL1MaLjpTNi87Zhx/AVQs=;
 b=WvO1JMN7kCOoRuaY9L+OWUghfXJ8BCdOBWjulNuplUZZeDFHWhX5UP1qyOfuvpInNuAOFT6Wu6QSgmJBFhyuDDzP4QIEYFuBw+Ht9ydVmDl1fZJgmkU5U6s5aHEvNydprdJruYDAfut+VWjTXYQyKTs7HSFrpbwArPnLFI/EWHMdQg6aI5v2J2UEnLwWd6ELQDXlXwY++VDSLts3TpWhPjjzc4Bpmtf0itvmnseul0RepEGckyXpskq6RlLsxareOi5839FD4Tdo4sXxOwBywoBNhTtwZAA44W+x1cvYNuLDbNGDo/xpwblwusuFyDna/qu31Ug799Hg0ODAMgKG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78BzzsDRqRzvPY6S9lY400kL1MaLjpTNi87Zhx/AVQs=;
 b=WXbHqCO7owyEpQDthTalcfW5FY2AY3jguSj+Gr+JlDDw9HaKuyxMngQUKNYYUMMw7MHGcqIcUb9qoJIbasRgnx63UswOAbYcBqFK1nPZOF9MfIuQXOXFPCCXVdTMJkEeFw71JCl3MDKC7N/Uix9fl4a1UMfQ/+qXshHQdkk8UF8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 21 Dec
 2021 17:03:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%7]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 17:03:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Imre Deak
 <imre.deak@intel.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
Thread-Topic: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release
 PCI device ..."
Thread-Index: AQHX9chgu3Z8LhpJr0q5gQSTVOUPJaw75roAgAAI7ACAAASHAIABFBgA
Date: Tue, 21 Dec 2021 17:03:37 +0000
Message-ID: <BL1PR12MB5144C08311094DDBC7069AAEF77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
 <CAHk-=wgtGHeEqE9e-NSYQ51pU8QR13CL5Njp_wh9n2hwPiKZEg@mail.gmail.com>
In-Reply-To: <CAHk-=wgtGHeEqE9e-NSYQ51pU8QR13CL5Njp_wh9n2hwPiKZEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-21T14:49:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4c6af976-a5b7-430f-a45e-33f02b29fe99;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-21T17:03:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2a82f125-fe42-440e-8acb-bba8f644cb47
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a97e43b-9436-4e9e-7f9b-08d9c4a3d4c5
x-ms-traffictypediagnostic: BL1PR12MB5125:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51254DA3A208F3BE5C019C97F77C9@BL1PR12MB5125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NrRpCpz5tFXgx3Er1PUTYWe7JEpdbrbppw4CcfjbyhLgq/kc8rNiouFTb8SVVzkP0HCVWPQ7nX29nMbJ1qeX1EQx56XSGSlEJPgoddSlh2cVElLdJF1xTw6koFX/Q5NlZcgCFYsDnF/BpjS3Cg6oBctp8DGjxadbs3pgHmfN9E68izLTcjxTDdGBmmcHGUX7lJ03oYWKQL1rTO6hExULeltxOUHbO3J0OhVamnkqMg+MRLImRo3EEdyUgqm6t60PEUI8fQ48hDan0phPD9oPkPi547itqNWB7cnEV4LXllv3J18Xybg5/1SZ7Ub0y4ngpaVU5jDqkKOYTfwTdiTId3Slh2J4pDUS9ebHAVQKzMvkuNPxWOdQ1NnxxnFEKM63mjQ25YfsG/SmMJHifHa5sBFFz7Zu2KtbjYDsX1ZlGsT7HdoO/8jTdr9+wTcsv7vQl52snsQLFPnPJXsyTRBSNBjGRi2dHE1RY7EHtjLkg8zf9A/o5Iq5u/jChTQI6V5Qx43jcPjAnp8OVNfBEtfSlBakMEUMPnB87os1V73GbDpKRFAKMu/7lS1SL5fv9SzuCCjmUf9oEBlogRbsP8js80vmrDzNMmCJtr7rBDcwuwz7HmVNM/FOEm2QksOVEDjaiiaXg8+0/GFOVenyY/0183m4hqJQLlA01BTzzJlrbQXdWbVOJuKtHc/UzkweXSR7z35h3OMSfqgzK2QnT++t+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(66946007)(66446008)(83380400001)(9686003)(55016003)(6636002)(5660300002)(186003)(38070700005)(966005)(122000001)(38100700002)(508600001)(8676002)(4326008)(33656002)(53546011)(2906002)(7696005)(64756008)(54906003)(86362001)(66476007)(26005)(316002)(8936002)(66556008)(71200400001)(110136005)(76116006)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmpGVFN3Z2dwOVlWYmY5NlJMS245MDdiODI5L2dvaW9oazliQ01Md01rSit2?=
 =?utf-8?B?cGVXTXNVbGh2Rmt3R3MrYk1HUVFyenpMUzRCa1Uyd2dLa3hKeUlMSGo5WENk?=
 =?utf-8?B?ZmU3SmNCWXU5T3U4UlVJZTdBY2pDOWRHMXltR1JQWUp1RTFsUGFRVnc0TVIv?=
 =?utf-8?B?RUVPSkdFZkJLODBWbXN5QTZOTEg3L0VPQ045VnJrb0x0eFJaQkozQ0pmbTF6?=
 =?utf-8?B?cVkyUHFDcis0WU9hT0tOVnF3YjdFZ3dGTlBhMFNpaVpRMTJyT0wrb3BlM2pK?=
 =?utf-8?B?dm9Lc09JUWRKZlhoWVppRVVoSXVZTStkNVdxeWVHK0xIM3VBeUdqZUNHeXJz?=
 =?utf-8?B?dlB1b2pOZHNOc1U3WlBSSUhPVmlkeDdYNmtlTjB4ejZlcW81cGdUb2Z6U2xR?=
 =?utf-8?B?cm9VSHZwejFaaFp0aGFINUpXYXc5elVudXAzWG9TbGxpWGJJMzZhbEpnS3lB?=
 =?utf-8?B?VEFDVUZKYnJkdzBTZ2ZTWEtKWlpOcmdIeDdBMndLTTNDZldRblJwSWtvRHhY?=
 =?utf-8?B?OTAvaVFXRGg2Q3pOaWM5OVJMd1VyM3FTRmFxOGg2NTgrNUlHa1FUNnJHSFJP?=
 =?utf-8?B?eTFYLzQrVGRETlhTVitON1Q4dzFyeitteXNGOEdaR3IyQTc1a2pXay9uZFJ0?=
 =?utf-8?B?VFRiVzUrY0FGbkowRy9yR1VoRFFMQUptZnZETHoycldhcFRrbFViN2h2VFJw?=
 =?utf-8?B?YUU2NHl1K3I4VDZjb1JLNWt4RHY3YXBmTGFoWTQ2ZFRGeUFmSjR3cGRZWHI2?=
 =?utf-8?B?Q1dzUHM4SXM1WWU1RlJNQ2hQci9HWUo2YXVsY2l6M3B4WXFWWkthNzBya3Y1?=
 =?utf-8?B?ZVRIU2xVSGRMVFlhMW9FUnQ5ZldneXhQQk14Qm9ObzVWVlNPbW9lQi9VTFVB?=
 =?utf-8?B?eUpJVTdPRFNmc1daRDJoZTlzejRyNTdMUlo3b3BzS1RUQ2hvSHJFSGxzVVVG?=
 =?utf-8?B?dzE4WXZvNFJKUmc4UnFsS3NHTXdQQUlNbHh5bkg5YlV6N25HWDN2MHQzU1Y4?=
 =?utf-8?B?bitJeVdZdVdVQklRM05WRHEyeHlLZXFoakhmU1F5Q2owUWZYc2hhZjFCcHZX?=
 =?utf-8?B?QnNlRmdHTm16ZTlwRkFmL1VKMlRudVhvMzgxTHZ0Y1drcE9BQWFheW8wZzJ4?=
 =?utf-8?B?UjFhNk5hZklBY0ZTTzhkWFhyWW1tSTJUdCtUTE5nNTB6emhLNVJNZFJrYzRV?=
 =?utf-8?B?V0VHZEVwbWFkMm0xM3hoTzN2NXVsSUxoVWVkVkFrT0VMSkVXRE1ic2lnaEJL?=
 =?utf-8?B?S0ZiOE5XSzNsbmM5NzQ4UWFmTXZRN1A5NHM3azc0c1Q2QXdJWHEzdFd6YitW?=
 =?utf-8?B?NHd1eFB3YUd5R1dSamoyQzQrWXlZOGxERTVzVWprTWtObU5ScGRYOFlwelFy?=
 =?utf-8?B?NW1rSUNCYVF4WlB6b1Z2cVIwWjJnNFFNanl4UjkvMFlKcjMwNW5UT2RIWUR1?=
 =?utf-8?B?a0NUSTMxMi9XUU91TUJjVTdCT0pDcDR3c3p5eEtOcmt1M2Mrdm5jZ1BJVmo2?=
 =?utf-8?B?c2g1aE5RZFBmVHpkYkZaQVRWOXluT2tmWWdGVkNhRjVuaEZQZlUvbFh1SExJ?=
 =?utf-8?B?WFlSQkNqajJmbWQ5VWJEc2lwOXduRDRMZFBFY3RVdHV0bHcwdkU3V1pJUHZa?=
 =?utf-8?B?cld2QnN6MDJlYys4VjN1YS9DWGhpenFRMHZyNEdmZXpMbDVRdGxlNStzYSt4?=
 =?utf-8?B?Tmc1ZmJKYjR2OC9kMVRiQjVpQkROR3lLSThReDZYYVdYNFg5MXZKRENpbFkv?=
 =?utf-8?B?NVhFZnRqc3BJYXJ2UXc4VHNtQUdUSW9WUTRMTHJlUHNEWDBiWGtacW4rVnRP?=
 =?utf-8?B?NXYzdjMvbnlWR011TjJCVEpCdUx0UmVMQlhsR3VnVWpOWDZkamg0RWFxWWVG?=
 =?utf-8?B?Y1NhVkYxTENZTnZERVlkNjV5WlRuS0FDa3BvNzFoUUtrRVMrbU8vdHRsRDQx?=
 =?utf-8?B?amsrM0V2SGRRM05BUU40dnBQV2QzeWJEM3VibHp1NC8xbStwUm5XTGkxcmxU?=
 =?utf-8?B?VEtmeTBqYzdkNlJ0OWlPQkFYdkYxbFlmQ1NQbDArcmpLQUJ3aHhxaTA1dXY5?=
 =?utf-8?B?cHlDTUNVblltSTQ4SFRjcmlXTjRhdVZIVE5tcVNCVUdGemZpSEozRUUyTHd0?=
 =?utf-8?B?dWtxVUhVbFVRcStYcjI3ZXhVTjZ5cE14V09ISWZyd3FTMkZ0QkhPZEVNWUJP?=
 =?utf-8?Q?2hrq8z9Da+CU+pyRyfx1AH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a97e43b-9436-4e9e-7f9b-08d9c4a3d4c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 17:03:37.5862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUHNEikdDQvYC3j3SwJAXzeAn2hzkLGLEp5iC4R934X9at8kP2Kkik/AYLPZhY6gMh+L9u+RYMyLSFOQFFgM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBU
b3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
RGVjZW1iZXIgMjAsIDIwMjEgNToyMSBQTQ0KPiBUbzogSW1yZSBEZWFrIDxpbXJlLmRlYWtAaW50
ZWwuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47
IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+Ow0KPiBXZW50bGFuZCwgSGFycnkgPEhh
cnJ5LldlbnRsYW5kQGFtZC5jb20+DQo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVy
QGZmd2xsLmNoPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS2FpLUhlbmcgRmVuZw0KPiA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPjsgYW1k
LWdmeCBsaXN0IDxhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBFeHBlY3RpbmcgdG8gcmV2ZXJ0IGNvbW1pdCA1NTI4NWUyMWYwNDUgImZiZGV2L2VmaWZi
OiBSZWxlYXNlDQo+IFBDSSBkZXZpY2UgLi4uIg0KPiANCj4gWyBBZGRpbmcgYmFjayBpbiBtb3Jl
IGFtZCBwZW9wbGUgYW5kIHRoZSBhbWQgbGlzdCwgdGhlIHBlb3BsZSBEYW5pZWwgYWRkZWQNCj4g
c2VlbSB0byBoYXZlIGdvdHRlbiBsb3N0IGFnYWluLCBidXQgSSB0aGluayBwZW9wbGUgYXQgbGVh
c3Qgc2F3IG15IG9yaWdpbmFsDQo+IHJlcG9ydCB0aGFua3MgdG8gRGFuaWVsIF0NCj4gDQo+IFdp
dGggImFtZGdwdS5ydW5wbT0wIiwgdGhpbmdzIGFyZSBiZXR0ZXIsIGJ1dCBub3QgcGVyZmVjdC4g
V2l0aCB0aGF0IEkgY2FuDQo+IGxvY2sgdGhlIHNjcmVlbiwgYW5kIGl0IGhhcyB0byBnbyB0aHJv
dWdoICp0d28qIGN5Y2xlcyBvZiAiTm8gc2lnbmFsLCB0dXJuaW5nDQo+IG9mZiIsIGJ1dCBvbiB0
aGUgc2Vjb25kIGN5Y2xlIGl0IGRvZXMgZmluYWxseSB3b3JrLg0KPiANCj4gVGhpcyB3YXMgZXhw
b3NlZCBieSBjb21taXQgNTUyODVlMjFmMDQ1ICgiZmJkZXYvZWZpZmI6IFJlbGVhc2UgUENJDQo+
IGRldmljZSdzIHJ1bnRpbWUgUE0gcmVmIGR1cmluZyBGQiBkZXN0cm95IiksIHByb2JhYmx5IGJl
Y2F1c2UgdGhhdCBtYWRlDQo+IHJ1bnRpbWUgUE0gYWN0dWFsbHkgcG90ZW50aWFsbHkgd29yaywg
YnV0IGl0IGlzIHRoZW4gYnJva2VuIG9uIGFtZGdwdS4NCj4gDQo+IEFic29sdXRlbHkgbm90aGlu
ZyBvZGQgaW4gbXkgc2V0dXAuIFR3byBtb25pdG9ycywgb25lIEdQVS4gUENJIElEDQo+IDEwMDI6
NjdkZiByZXYgZTcsIHN1YnN5c3RlbSBJRCAxZGEyOmUzNTMuDQo+IA0KPiBJJ2QgZXhwZWN0IHBy
ZXR0eSBtdWNoIGFueSBhbWRncHUgcGVyc29uIHRvIHNlZSB0aGlzLg0KPiANCj4gT24gTW9uLCBE
ZWMgMjAsIDIwMjEgYXQgMjowNCBQTSBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtDQo+
IGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IE5vdGU6IG9uIG15IG1hY2hpbmUsIEkg
Z2V0IHRoYXQNCj4gPg0KPiA+ICAgIGFtZGdwdSAwMDAwOjQ5OjAwLjA6IGFtZGdwdTogVXNpbmcg
QkFDTyBmb3IgcnVudGltZSBwbQ0KPiA+DQo+ID4gc28gbWF5YmUgdGhlIG90aGVyIHBvc3NpYmxl
IHJ1bnRpbWUgcG0gbW9kZWxzIChBUlBYIGFuZCBCT0NPKSBhcmUgb2ssDQo+ID4gYW5kIGl0J3Mg
b25seSB0aGF0IEJBQ08gY2FzZSB0aGF0IGlzIGJyb2tlbi4NCj4gDQo+IEhtbS4gVGhlICpkb2N1
bWVudGF0aW9uKiBzYXlzOg0KPiANCj4gICAgIFBYIHJ1bnRpbWUgcG0NCj4gICAgICAgICAyID0g
Zm9yY2UgZW5hYmxlIHdpdGggQkFNQUNPLA0KPiAgICAgICAgIDEgPSBmb3JjZSBlbmFibGUgd2l0
aCBCQUNPLA0KPiAgICAgICAgIDAgPSBkaXNhYmxlLA0KPiAgICAgICAgIC0xID0gUFggb25seSBk
ZWZhdWx0DQo+IA0KPiBidXQgdGhlIGNvZGUgYWN0dWFsbHkgbWFrZXMgYW55dGhpbmcgIT0gMCBl
bmFibGUgaXQsIGV4Y2VwdCBvbiBWRUdBMjAgYW5kDQo+IEFSQ1RVUlVTLCB3aGVyZSBpdCBuZWVk
cyB0byBiZSBwb3NpdGl2ZS4NCj4gDQo+IE15IGNhcmQgaXMgYXBwYXJlbnRseSAiUE9MQVJJUzEw
Iiwgd2hhdGV2ZXIgdGhhdCBtZWFucywgd2hpY2ggbWVhbnMgdGhhdA0KPiBhbnkgbm9uLXplcm8g
dmFsdWUgb2YgYW1kZ3B1X3J1bnRpbWVfcG0gd2lsbCBlbmFibGUgcnVudGltZSBQTSBhcyBsb25n
DQo+IGFzICJhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JhY28oKSIgaXMgdHJ1ZS4gV2hpY2ggaXQg
aXMuDQo+IA0KPiBXaGF0ZXZlci4gTm93IEknbSBqdXN0IGt3ZXRjaGluZyBhYm91dCB0aGUgZG9j
dW1lbnRhdGlvbiBub3QgbWF0Y2hpbmcNCj4gd2hhdCBJIHNlZSB0aGUgY29kZSBkb2luZywgd2hp
Y2ggaXMgbmV2ZXIgYSBncmVhdCBzaWduIHdoZW4gdGhpbmdzIGRvbid0DQo+IHdvcmsuDQoNCkFw
b2xvZ2llcyBvbiB0aGUgZG9jdW1lbnRhdGlvbi4gIC0xIGlzIHRoZSBkZWZhdWx0IGFuZCBpcyBl
bmFibGVkIGZvciBhbGwgZEdQVXMgd2hpY2ggc3VwcG9ydCBydW50aW1lIEQzLiAgSXQgd2FzIG5l
dmVyIGZpeGVkIHVwIHdoZW4gd2UgZXh0ZW5kZWQgc3VwcG9ydCBmb3IgcnVudGltZSBwbSBiZXlv
bmQgUFgvSEcgbGFwdG9wcy4gIEZpeGVkIHVwIHRoZSBkb2N1bWVudGF0aW9uIGhlcmU6DQpodHRw
czovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvNDY3NjgxLw0KDQpBbGV4DQo=
