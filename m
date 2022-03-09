Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52597C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 23:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A521510E55E;
	Wed,  9 Mar 2022 23:31:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8A110E55E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 23:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzykuVooa/+Qm7dwhXq/p/F6mb1sREDqiKfDHV/H9pwBFPuWDKid0ZHJE5Rx7V2u0JHAuqCMWDWKlUuktmuD+P6Ugalu0clOT2SOjAPMDpDaqwpaativS75o/yICzekEgxjmaFb8oYUhXMZji1Kt/DMI+Cn3srmtXNxdH4q6s18M+2KRoj409UbFcANw6RXAFNhLXN+zOamRID1P5zCAXF3HahWw8FZ0gEHCLQc6xjplJy00OZ0KPn+B/7MN2ScO5zfBCsPdkDzy8xRXL4bODeaFpZed6gofn48e8At89axcqznB54/xUoaub8612ZUA4Vyc6+I+lu2j+aweL8YFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Crt1rYcUgH6U1TF3XEymM+dLvdeRlGtmCoSOYzOurvQ=;
 b=GYeJTTiVANQXcShdPsq3v8nTeSPr1+kbH8U51jX4tKPwa8FVn1G+BiYQTXRkd+BiMB1rCL+EmyuoRU3fyDg8KZ340jKLsWHkqKdjph7/ZYUK/+9G3/eY3TGOv6Pn8/2wp+lEewCW4EwbTUZonDJJ7+/7IhSmj3FIrTukRqnHPURNPUEfpWq4SUmdZFq9/pxQg1CMwVWgrfVywaBtvnJfQnzcDo/w1c01XUE7pG4YYQsVTuq6OjUgH7AVo1ByHIfE2msviDJ5wGMv4wPzpwvHl57H5R3ni9dmhPhq7cX9AgALG30UM8sPsjpwA8LeTLe/0XnxfhoHpFZsjmNRinEQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crt1rYcUgH6U1TF3XEymM+dLvdeRlGtmCoSOYzOurvQ=;
 b=wED6a52JcWnkBlk1ggL4Ew1BmEaoMc503nC+3ESMKrKoyJamovgMs1WcbJjb7FXdnedcLDVeSuCyqNDL24sapc/js7EtyB3dY9xOoxVMoobjXj6JR7IKEBCxfwYXxsT4kH7Id0hJcyufjVPVs5xDG3ZZWlx8lFEta4of2QsXwAg=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 23:31:16 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::482d:3d9f:876b:a038]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::482d:3d9f:876b:a038%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 23:31:15 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Thread-Topic: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Thread-Index: AQHYNANrz5YaU/HPfkOOHNh+j3VeDqy3riOAgAADmbA=
Date: Wed, 9 Mar 2022 23:31:15 +0000
Message-ID: <DM6PR12MB3163413DD1FA0B1BFA460A7E850A9@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20220309221645.468184-1-jonathan.kim@amd.com>
 <99d17bed-06e1-45c2-7a70-449f1ae47eb0@amd.com>
In-Reply-To: <99d17bed-06e1-45c2-7a70-449f1ae47eb0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e3b4d3cb-6155-41c0-a6c4-46eaf8279682;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-09T23:25:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 711234ad-52b1-4ac0-a22c-dfd12a6a460f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f07a1bc-4426-45b8-9ca1-08da0224e7ec
x-ms-traffictypediagnostic: DS7PR12MB5816:EE_
x-microsoft-antispam-prvs: <DS7PR12MB5816C3F9566429CB6F8B4DA1850A9@DS7PR12MB5816.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtt+qeOxzgGrtJshgxPiQTYgYPN1vOKeperd1sXCcczZgDgEv8yoBQWLaQFpeA29fDjzsZT1xyHiKyVkn3gzZUYLRF5D0NI3mQHC9K++OBHuHEHbQ8EWF6ULq3AsQDtFH36/cneD2a+P/3GFOs2H9U2GGF+0/S9SMO1XcoRUVcKXkRzwfAdCj1z4gUsR2hqyL6GupLd6nrH7QEXZ9UbFcSGiZh78KR1IoPlDwFNTyrvsn8oz7giCzpYGAn3qm/FHOXemXdi8V1PlGJmJsOSKT+WlNBdnhpS37V7HT83ah/jwqHSSqjuenDzK9tJmq3g16kVbcJllEuwvQB5/mFPix6L5CuoVU7zsGHgo64KRVvz1AFcGyuR16tbJaN/ySyymbNOcVGbRKTXJncNfykPOkg5Ksf1w1gjJFptmrG/SvbeVQ945kRkmwcJtDABvomD49u1aZZyIsqhsoDzi1ZPei5lWrbfSqi+s7ZoflJ3Umo8nivmOXOT7x1AYzUZ/x0PxGxjzeo1W7mWkI3cQhFEnngpdIJ5bwgG0s2vFbpg+kMoLR6ywuArA3WUKsbp2ArPTmVTJqddlW2F+SBbYOG7wtwPfMK381UeC8XH1hdyuY9LkO6Iz7EBQe04r6ftXo71Z2/+S8HGVGFOarHl0Ih42K5JtINIwk9+7QqECMn0qZH04E7KotYkgQ6vT2wOR31MmCDJ0pChdZMW53Yw3s7HxTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(64756008)(38100700002)(2906002)(76116006)(110136005)(66476007)(7696005)(6506007)(66446008)(4326008)(8676002)(186003)(83380400001)(508600001)(55016003)(66556008)(33656002)(71200400001)(38070700005)(52536014)(5660300002)(9686003)(8936002)(86362001)(316002)(122000001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1BONXRZcks2S0kzYmlHNWIwM3kyd2FDWisvZ0c4Q1RrWFB0dGwzU2dicTd3?=
 =?utf-8?B?VDZNckdWeFVQZDZ2WU5HZmg2aUgxQlVHRE52aDJheEVCOEYveUJnYTByN0Z5?=
 =?utf-8?B?dTR3TWNXaVZYRmlCYTlWWC9oamJTOVBZRXBkeFdhVGI4MG1zN1RDM0dXbGdT?=
 =?utf-8?B?OUtiYTRaV2MyVmtrSFYzcm1GNDFVdzZBRDQ2bEhlSzltclJoUHh6d3ZkMnlF?=
 =?utf-8?B?M21nRkl0TjFrcFF6bW4rdDdYdUNVa3Q0M09hbHRFc1lRZmk1OFFncUgvemUv?=
 =?utf-8?B?WnVZdVEveGoyclBQb3FSenI4NjN2L3BTaUpySkx5Z3V4bXlGbCt5WEJCRnBO?=
 =?utf-8?B?aHA5QWZCUmY3V1UxMHY0OTlQZHd6VE41OU9XTUdVcEtSYTZFV000ejNET3hI?=
 =?utf-8?B?MW1acEVzUjMxeWViazdVeUJZeHFuNU1wbFlXeTN0YWxxbWJSdU5YbEpXdWJn?=
 =?utf-8?B?R084L2sySnhmcStJc3AxT0pNd1ZKaWVYMEdZazdROHFOR3hIRVNGTWVZRmxm?=
 =?utf-8?B?WXJiWmF4MEEvcDFIS3NBbXZQSTVncmpGSTcxalNzbWRmM0JBb3RaeEVRcGE5?=
 =?utf-8?B?V1FYbG9leFlmMnhkMmtqN1daZldDeUVoY2dMTTlxcUdyb2NvU1hwNmVqTVJS?=
 =?utf-8?B?dWRoMTR6OXR4UFRiRy9xYjJRUXY3K3JQNHRwYlMrckdDSCtJelc4akwrTzJP?=
 =?utf-8?B?MnFnMkxadVVBWmlVcFpjS3krSTdUa2xOaTB3a3Q3djZGQ0tNTCtQRkxuVS9P?=
 =?utf-8?B?V3lFa0NYYmxQWGdEK0h3QXFudUtuekpyQ2FnMXhIbE50OFhucHZ2Z013WVZp?=
 =?utf-8?B?TDBKSTVJQUNwSzUycUxVd3g0anA5T2pTamd4OTl4UnBFSHB6Ynh2Z1hNTDZz?=
 =?utf-8?B?b1Mvd3dKcUNZeTQ1NlBvcDRnM3Q4bk5OYTYzaW9YZTJQWVl6VU55ejBoOW13?=
 =?utf-8?B?SlpaakMxUVRJb2E0eWE1UGcvdGJVYnJycGUzMFFDWjV6ajFUbFdUY1Zvanh0?=
 =?utf-8?B?MXdTZm1mZlpCQ25MaDZxOWx1RWx4NTBDTzVHcm5yMlFUemJhd3JmVEIwRXQ3?=
 =?utf-8?B?eVZ6QWxsQWFNOUlDeG1WRnROa0M3M2RoVjI4QnFhQ1pJNzBTRUwxaGc4VHIv?=
 =?utf-8?B?Nkp3QkhqemxYRVJyMWR6OS80STY1TS9TK1pJVUhPYXg3U3hTNTBsOXhyUkRm?=
 =?utf-8?B?RGV1OENPQmdrOVNzeldnS0wwTWpYWk5VWnpwMG84NVJWN3dOR1ZIcG9qMEFL?=
 =?utf-8?B?VW5sTVFzUDQ4bWZvNnBnKzdJZEVjWk1OM3NxRnZWWGhPcGx0THBsNWpLblhk?=
 =?utf-8?B?MzJWU3o5ZTIxQms0Wmd2UjRvc3l4MmVhZmFqNjNlYVNybUlvUTk0WThYa2ht?=
 =?utf-8?B?OWx3eUI5OC9tQVhjWkZ4b1VDYW1NM1Rkd0xpbkpVUFRCQ0xRNEp3ZlV0ZG43?=
 =?utf-8?B?ZnFrbm1VenlaMnZDb1laNUdjSmk3ZmJXUEo0OVFFdnlad1ZyelJiRUZZeVJy?=
 =?utf-8?B?RVQ2Rkx0K1ZpS3dXaFYxaFIxOENqODZ5VmNPdjNzYmo2UHNMYmx3ZEdpaXNp?=
 =?utf-8?B?SW5ia1llRW9GOXdxQ0lOdnoxdnFhK0hHL0xOaW90UWRSMHJjN0FnSDNraFBi?=
 =?utf-8?B?TUtiQTZpMEhyUFZva3dMcnVuYUF1MFlOS3dDSkFvZERPWExXZi96NzljN1pD?=
 =?utf-8?B?S1Z1ZnpMUGp6aEE5djBWR2Ywd1dGakZyMC9RQ0tVbndlbzIwenB4dnlCUHBD?=
 =?utf-8?B?NjR2UERLSnJ3M09tUmxHcDlSRHV4MjBZcldrbnE3UzdsazNud3JHTjU4UWNm?=
 =?utf-8?B?azY1NS9DMFhmbUFPU3hSeHcwK2RKc0xDdEJJQmJTZDVzTG9KTUFJRkpNQkFq?=
 =?utf-8?B?eWt4SjVJL1kxQklXbEhLT08yZlVmaE1MY0QrL1I0dm5lRVJFRTVYS21pZnNw?=
 =?utf-8?B?SC9rOVRpam9IYzQyZmRLRWtJR0tnOGd5QWFOSWZpbnE0d1c0UWd3dmFPZytu?=
 =?utf-8?B?STc5VnJCVnJLV0JXbExiMERrVWJrMFo0emEzNWhJVEpFYVNPVm5LZldTbXYz?=
 =?utf-8?B?anBZYk5FYkhyYkk4OXN0ZWZaRjhKVmVhUEJ4OTBtcmh5SUhybGdmMytsOWxS?=
 =?utf-8?B?MlRGbUFLTnB4UWh3c3lJYzhGVVpRa1FEMEVDTEJGV2RYMXpsN1dTVStzYnhJ?=
 =?utf-8?Q?EnKnqocSWcmvPX7h3Dlv2vE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07a1bc-4426-45b8-9ca1-08da0224e7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 23:31:15.8062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjLUHfr4De+AOu4ZCTHBzSdxBCYGymE1BtxWoW3quSA1J/c/CdyqDPPAaEgt2HD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IE1hcmNoIDksIDIwMjIg
NjoxMiBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGl1LCBTaGFveXVuIDxTaGFveXVuLkxp
dUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYWxkZWJh
cmFuIHhnbWkgdG9wb2xvZ3kgZm9yIHZmDQo+DQo+IE9uIDIwMjItMDMtMDkgMTc6MTYsIEpvbmF0
aGFuIEtpbSB3cm90ZToNCj4gPiBWRnMgbXVzdCBhbHNvIGRpc3Rpbmd1aXNoIHdoZXRoZXIgb3Ig
bm90IHRoZSBUQSBzdXBwb3J0cyBmdWxsIGR1cGxleA0KPiA+IG9yIGhhbGYgZHVwbGV4IGxpbmsg
cmVjb3JkcyBpbiBvcmRlciB0byByZXBvcnQgdGhlIGNvcnJlY3QgeEdNSSB0b3BvbG9neS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+
DQo+IEkgdGhpbmsgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuIFlvdXIgY29uZGl0aW9uIGZv
ciBzZXR0aW5nDQo+IHN1cHBvcnRzX2V4dGVuZGVkX2RhdGEgaXMgZXhhY3RseSB0aGUgc2FtZSwg
YnV0IHlvdSdyZSBpbml0aWFsaXppbmcgaXQgaW4gYQ0KPiBkaWZmZXJlbnQgZnVuY3Rpb24uIENh
biB5b3UgZXhwbGFpbiBob3cgdGhhdCBjaGFuZ2UgcmVsYXRlcyB0byBTUklPVj8NCg0KSSBwcm9i
YWJseSBzaG91bGQgaGF2ZSBpbmNsdWRlZCBtb3JlIGNvbnRleHQgd2hlbiBzZW5kaW5nIHRoaXMg
b3V0Lg0KVGhlIHByb3Bvc2VkIHN1cHBvcnQgYXNzaWdubWVudCBoYXBwZW5zIGFmdGVyIHRoaXM6
DQoNCiAgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCiAgICAgICAgICAgICAgICBy
ZXQgPSBwc3BfaW5pdF9zcmlvdl9taWNyb2NvZGUocHNwKTsNCiAgICAgICAgZWxzZQ0KICAgICAg
ICAgICAgICAgIHJldCA9IHBzcF9pbml0X21pY3JvY29kZShwc3ApOw0KICAgICAgICBpZiAocmV0
KSB7DQogICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gbG9hZCBwc3AgZmlybXdh
cmUhXG4iKTsNCiAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgICAgICB9DQoNCmFuZCBw
c3BfaW5pdF9zcmlvdl9taWNyb2RlIGRvZXNuJ3Qgc2V0IHNlY3VyZSBPUyBtaWNybyBjb2RlIGlu
Zm8gKHRoaXMgaXMgd2hlcmUgdGhlIHN1cHBvcnQgYXNzaWdubWVudCBjdXJyZW50bHkgaXMpLg0K
DQpUaGFua3MsDQoNCkpvbg0KDQo+DQo+IFRoYW5rcywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDYgKysr
Ky0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+
ID4gaW5kZXggM2NlMWQzOGE3ODIyLi5hNmFjZWMxYTYxNTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gQEAgLTMxMCw2ICszMTAsMTAgQEAg
c3RhdGljIGludCBwc3Bfc3dfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gKyAgIGFkZXYtPnBzcC54Z21pX2NvbnRleHQu
c3VwcG9ydHNfZXh0ZW5kZWRfZGF0YSA9DQo+ID4gKyAgICAgICAgICAgIWFkZXYtPmdtYy54Z21p
LmNvbm5lY3RlZF90b19jcHUgJiYNCj4gPiArICAgICAgICAgICAgICAgICAgIGFkZXYtPmlwX3Zl
cnNpb25zW01QMF9IV0lQXVswXSA9PSBJUF9WRVJTSU9OKDEzLA0KPiAwLCAyKTsNCj4gPiArDQo+
ID4gICAgIG1lbXNldCgmYm9vdF9jZmdfZW50cnksIDAsIHNpemVvZihib290X2NmZ19lbnRyeSkp
Ow0KPiA+ICAgICBpZiAocHNwX2dldF9ydW50aW1lX2RiX2VudHJ5KGFkZXYsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFBTUF9SVU5USU1FX0VOVFJZX1RZUEVfQk9PVF9DT05GSUcs
DQo+ID4gQEAgLTMwMDgsNyArMzAxMiw2IEBAIHN0YXRpYyBpbnQgcHNwX2luaXRfc29zX2Jhc2Vf
Zncoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgICAgICAgICAgYWRldi0+
cHNwLnNvcy5zaXplX2J5dGVzID0gbGUzMl90b19jcHUoc29zX2hkci0NCj4gPnNvcy5zaXplX2J5
dGVzKTsNCj4gPiAgICAgICAgICAgICBhZGV2LT5wc3Auc29zLnN0YXJ0X2FkZHIgPSB1Y29kZV9h
cnJheV9zdGFydF9hZGRyICsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGUzMl90
b19jcHUoc29zX2hkci0+c29zLm9mZnNldF9ieXRlcyk7DQo+ID4gLSAgICAgICAgICAgYWRldi0+
cHNwLnhnbWlfY29udGV4dC5zdXBwb3J0c19leHRlbmRlZF9kYXRhID0gZmFsc2U7DQo+ID4gICAg
IH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgLyogTG9hZCBhbHRlcm5hdGUgUFNQIFNPUyBGVyAq
Lw0KPiA+ICAgICAgICAgICAgIHNvc19oZHJfdjFfMyA9IChjb25zdCBzdHJ1Y3QgcHNwX2Zpcm13
YXJlX2hlYWRlcl92MV8zDQo+ID4gKilhZGV2LT5wc3Auc29zX2Z3LT5kYXRhOyBAQCAtMzAyMyw3
ICszMDI2LDYgQEAgc3RhdGljIGludA0KPiBwc3BfaW5pdF9zb3NfYmFzZV9mdyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikNCj4gPiAgICAgICAgICAgICBhZGV2LT5wc3Auc29zLnNpemVfYnl0
ZXMgPSBsZTMyX3RvX2NwdShzb3NfaGRyX3YxXzMtDQo+ID5zb3NfYXV4LnNpemVfYnl0ZXMpOw0K
PiA+ICAgICAgICAgICAgIGFkZXYtPnBzcC5zb3Muc3RhcnRfYWRkciA9IHVjb2RlX2FycmF5X3N0
YXJ0X2FkZHIgKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgbGUzMl90b19jcHUoc29zX2hkcl92
MV8zLT5zb3NfYXV4Lm9mZnNldF9ieXRlcyk7DQo+ID4gLSAgICAgICAgICAgYWRldi0+cHNwLnhn
bWlfY29udGV4dC5zdXBwb3J0c19leHRlbmRlZF9kYXRhID0gdHJ1ZTsNCj4gPiAgICAgfQ0KPiA+
DQo+ID4gICAgIGlmICgoYWRldi0+cHNwLnN5cy5zaXplX2J5dGVzID09IDApIHx8IChhZGV2LT5w
c3Auc29zLnNpemVfYnl0ZXMgPT0NCj4gPiAwKSkgew0K
