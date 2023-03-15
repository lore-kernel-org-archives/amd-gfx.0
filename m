Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B3FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518B010E023;
	Wed, 15 Mar 2023 07:31:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843A610E023
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 07:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/e0QhqjW1YY1TJ0Lv2y9zZIfE9jx2SxsGlKnnHZxoyHMdcMmUhxCzkHUn70QIvT/sduiTYCVoySyQPgmrKSLaUdVKrXDcsk3nTqwkoKkcTwBOAQ9aMA0G+A9Y/dw1JZ/TwhByyvW0yVdGmk4cX9zL1kGF2cjVfvL9xX6X7IFBuiHNa790wYz5JhLCb+wsO1T+YEW0zskl8dayfR2+Ca5O3uyrKRpyt50st2YgpDb5iU5wXkERshZ7UsSReu08iQcjq03XGhHaMpJptkZlqVKJGgMEzqxnCwCD65I7lNWz0nQahjuutxNv9Xu7MCgC+xuu8PBuVv/etf+pi/V9XfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBCB68TAd/Qa9c1SCyU1t/U72gxJ/AobnSGIf/2BJb0=;
 b=i3yxunR87gULkHAOiM2hCDPsrPOULWCdqb9XEA6bkllVhGLai2CSVatseAF56jmSPeLMPl6NvXk0rx2puFPXwLM3Wb/1Svb2qAxdvAG98FlPknOHOo1b1NPmbjyWtzNQQC3RDas+ev96/xiMwmWjSL2vt5EOkD4EssVH6kZUI5ixl+cPUDKGxeJQrbte83EEbxm5+Bw0sKFCwJ7qD/pOyHHc4XX+JBqUuhzUppvTplwCCtH/4S3XqZn78OByWTPWKLWvNmta1oTAs2DDfiJTSNxf8lKDHc8jVutE0Cs3I0c8DZ+jj7zXvqObStPfwRbFwmq/ekhWl7j1bQUQvbckDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBCB68TAd/Qa9c1SCyU1t/U72gxJ/AobnSGIf/2BJb0=;
 b=SQW47UfwQdUFcb0sfGWS4JMyc308pcIM2uNh4LfqVOAkUg2cotRFFvtOUxzLGtNFnMu/iIved00NtOLvF7Wwt0wg4qfC4avQbsInFar711UBmXUPGX481+JhMl/1g3fHxDtTb1A6pLvGs88gD/2OtVSPq4ii8Ch+BDPUO2JyudU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Wed, 15 Mar 2023 07:31:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 07:31:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Cui, Flora" <Flora.Cui@amd.com>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amd: fix compilation issue with legacy gcc
Thread-Topic: [PATCH] drm/amd: fix compilation issue with legacy gcc
Thread-Index: AQHZVw/SZ8PBsFi2K0S+iHtB58GqY677cdyw
Date: Wed, 15 Mar 2023 07:31:10 +0000
Message-ID: <DM5PR12MB2469A98160F6371729707209F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230315072854.45644-1-bob.zhou@amd.com>
In-Reply-To: <20230315072854.45644-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4073:EE_
x-ms-office365-filtering-correlation-id: 643ab0a5-139d-4486-dee1-08db25273f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tEHzdWBw3horIrzDAqhFzHhKyEFa8SpFcOv2Xdujlp8yaNvI9toAWFxny4I6x8D7mKzjEUTvEWe3u3+6dPZVXms9p6vSZVRk1JYdo4phqOx98etFS4ShJ2m9EqY2tC29akK+q+wssg+TYodJVWh0vNprfLy62ChEzomwjWyg1nx3aTulzNdjT/XoHuegJP4bINOlHYH8wAufPiwCR2ARgyRkxhR+f+f+9lwMcpwTgs1g3oP1thixKdggiHV8gHuRuEE9qRgV5wYNFAyXfWSbJkCe0EoqzIswbY9cJW/WJ0OVkM0lMaDqtZEHGIzbvEm2ryfijOrkdeMRQcgIYHZcHIqKxUmg/sGke4p++A5SMi34+P8sCjf6B+zILunUD7wgxQZ8LHTpo0CLG9RVyr81yXeEATm6YeaY94EID6H24/JF90/pSNrJ0L/6W+B5G/92klUrac/ZGs65D1+aBfApTRU3Us/ielXTBf10XUkHK5rPCYRDVtq7daa1TjPKonIZ332qftm6w/s98wtfHzUn6sBM64CmyxKTD0reFyxhyyPkRmAYbqt3LsdzP52c+6QmKbAexz3/Rpe5015yDUpTpbubgY/MDS9wQzCV2OCj/OTFkhxGQezSXt5gKYIt17KSfrxBEVEjzQFvh0Vb8Acs9v2WPSn6WYjeIb/KCSpcHGux5EG6IbwJMz6DkiDcDcRWPzoIzRQhJhewJzaThp24ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(478600001)(83380400001)(7696005)(71200400001)(9686003)(26005)(53546011)(6506007)(66946007)(76116006)(6636002)(66556008)(316002)(110136005)(66574015)(186003)(66476007)(66446008)(64756008)(8676002)(4326008)(41300700001)(52536014)(8936002)(5660300002)(38100700002)(122000001)(2906002)(55016003)(86362001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2t3YUhWUUpPdzdNT3BsNHBHZUJKaXJ6YWlMaUtoTmtGSmlOZGVZbVhMYng1?=
 =?utf-8?B?ZVpmekdOU25KeGNoUUsyYlBVWWFia0FtWXNzdzZKa3ZtMkZwcE9xUWZpSzI0?=
 =?utf-8?B?NThKMTgyQSttbVA3ZDByRy9mOXkzRWovT3BFR3V3b3hnWEhqUGpRTFphVklB?=
 =?utf-8?B?N3BIRlBPMENRWFVTUjNlUDJWSDNtdnpDL0s5YUZ6QWVlSFhmRFNXVUI5UEha?=
 =?utf-8?B?cng4WEZST25BRkI4L0hxZWR2TVFTNjZvMWNOSHFreDRjOHZ1WEtDcXYwRFk1?=
 =?utf-8?B?b2I3cmtpQ3lRUlRtOUZROU1ja0lpSHp1YTQ2Vkg2eFBucnVYWWxvZy9TcVVp?=
 =?utf-8?B?NkxwSFdCMkUvK01ERkRKU0FnMHFzVU1uTkJzeE1BUi9iTW5PTEpTY2QzM3RU?=
 =?utf-8?B?VDJ5U05PUGxhZmZwcEFCcUtMSVR3Unk5RE9SNmpqaGtwYmJpOU04dW5WZVFz?=
 =?utf-8?B?Vm5GZGM2ak5JczVtSnZ5dzU0WEJTVElqcmxMOStKNFkzS1NaZ1ZvYUpQR3JD?=
 =?utf-8?B?VTdVZFJacjBxN216cWZiQlhCWnNjc21mWjl2S2ZKb2RWdHpMSmlOSzNVM2dF?=
 =?utf-8?B?ckVVazdHa0xwLzB1SUppekttWGNhbHVEcEdQRnduV0p1N2dCaWxKR3BhS0cz?=
 =?utf-8?B?eGJQK0MvZ2VSb1A0c3VQK2JTZkREVExmbkRSV0NqcGFoTmUrbm9mZE1OcjZK?=
 =?utf-8?B?TTJsbnBaRGFrTUVkZHFDMEoxRHhuQlhJU2YyUDljQ3daeXZEVi9FSWtIUTds?=
 =?utf-8?B?TXdMSmZ4TjFQa2d5dHhQemFpY2x3Z1dPT20vMkNIaGxEMFB3QXFoWVlyaWlj?=
 =?utf-8?B?eFd1a3A2NzBqbnhIa3U1ZldtV2pVbmErZ1VGdG4xVVFHcWlyZ1ROTVh5eWlo?=
 =?utf-8?B?NllZRXRKbmtvaEhZUzJyNUMzQlNDZE5ZTXhweXgxajMrZ3VRT0tjRUQxTDF5?=
 =?utf-8?B?WDNGbWludHRLT2p1WEFaUG9tZjY1anlFQ2IxSTVYcE9JbnJ3KzQ0ZDNnTWl1?=
 =?utf-8?B?OFZWNjlGa2lRWlJlS1AwUjExbStEMjF0TGR5emNWVFdJOE9IUElXMTZEQlky?=
 =?utf-8?B?RWViRWpKdVNyaHFpTXpJcE9BT1JJY1lwL1B0ZkV3enlFbjhzTXgyZXZjdmhK?=
 =?utf-8?B?MVJobHc2MklibGp6UVJJS3lSQjJoM3RVbU40VWZGQ2hFSjBzQ20rQTBMcEZa?=
 =?utf-8?B?c3hkdHF3cjVRelJLc09lR1VtTCs1cXd5a2Y4RHA3L2h3Z1hBZHBNRGNNMVVC?=
 =?utf-8?B?bTRLUFpGV2lSN2YwSmxDVDVEZ2lySDJFWGk3OUVST25oQStVdXRPck5pY0pu?=
 =?utf-8?B?ZjlGYVJTTjJVSDJNSC9oYTJDMlZ2TjUrTTcyUkQ4bk1KbHFmUzRvaTQ2Z2p0?=
 =?utf-8?B?VFZjcTUvYkpxSWNNWGNKenFrcFpsQjBxVGpwM3l0UmhuL1c0d051anRxcHdk?=
 =?utf-8?B?OTlOSUd3a0NSQmtXV0c1ZklJTlZQUlhLU2g3WnFKQk9tYW9ReVNVeVdoc1JE?=
 =?utf-8?B?YkJiRXdybE9SSUpIeU13WTNGeElxNzBiSGJtcUlLMVV0K0p5Q2RVaGNVTHhi?=
 =?utf-8?B?Umg1aEE2QUw0cmg2MGM1NGU1cEU3bmJmekkvUkNyeG1aQkpHeGNUTkRnRHJv?=
 =?utf-8?B?djUvQWhOQjNCSUFFbmd6a0pmZThpanoydm5PY094SHRXd005MExJSWZpK2JH?=
 =?utf-8?B?cDBzbW91RHorYllMMFR2MlJwMmRIY2Z0VmQ0UnBFaytweXlQdTJQTlFMWGlR?=
 =?utf-8?B?S1hpTGJyUlVZeDdXcDNFZDlIS1RnbllGcmxVRXduTW5lTmdBcmw3cGlxOXA1?=
 =?utf-8?B?S05CQlN0WDdjVWdiQzUxTm83b1VPbE5BY3E2cmM1dHpiLzdpRVk1bVRmRTNE?=
 =?utf-8?B?OEc5Qkk2UVlTd2ZkNUlRWmdZbi9Tcit5aFVXRkE4SUtBRHliOU9ZK2xZNFVN?=
 =?utf-8?B?ZEs4dnNlOXhoa09ON0NtaWZDVmxPUkRXb3NMaFB5SFh4MFM1aWo1bXdxZHZ3?=
 =?utf-8?B?VXA2UUtGZkVrc25MWDBXcFJXUi9VbC8zd3NaSjVGYkhsaU4xcC9seXdYTmYr?=
 =?utf-8?B?SEVoUUpsTSt4Q1hleWhhN3hwUURjUFZVbzdVY3RLSEpuTVpGaHovRTFUYWZF?=
 =?utf-8?Q?62DxtW0X4LD19wANG2+NbHuSO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643ab0a5-139d-4486-dee1-08db25273f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 07:31:10.1779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxnZCUb7REEaH7oaXmpH4bVs9KgriRzTWRDFwy35UuED7kdydkIwGGBbnBNzYstqPVXAE8JqVoiyHOYEzeB3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGJvYnpob3UgPGJvYi56aG91QGFtZC5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTUsIDIwMjMgMzoyOSBQTQ0KPiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENoZW4sIEd1Y2h1bg0KPiA8R3VjaHVuLkNoZW5AYW1k
LmNvbT47IEN1aSwgRmxvcmEgPEZsb3JhLkN1aUBhbWQuY29tPjsgU2hpLCBMZXNsaWUNCj4gPFl1
bGlhbmcuU2hpQGFtZC5jb20+OyBNYSwgSnVuIDxKdW4uTWEyQGFtZC5jb20+DQo+IENjOiBaaG91
LCBCb2IgPEJvYi5aaG91QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZDogZml4
IGNvbXBpbGF0aW9uIGlzc3VlIHdpdGggbGVnYWN5IGdjYw0KPiANCj4gVGhpcyBwYXRjaCBpcyB1
c2VkIHRvIGZpeCBmb2xsb3dpbmcgY29tcGlsYXRpb24gaXNzdWUgd2l0aCBsZWdhY3kgZ2NjDQo+
IA0KPiBlcnJvcjog4oCYZm9y4oCZIGxvb3AgaW5pdGlhbCBkZWNsYXJhdGlvbnMgYXJlIG9ubHkg
YWxsb3dlZCBpbiBDOTkgbW9kZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogYm9iemhvdSA8Ym9iLnpo
b3VAYW1kLmNvbT4NCj4gLS0tDQo+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvcHJvdG9j
b2xzL2xpbmtfZHBfZHBpYV9idy5jICB8IDkgKysrKysrLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICAgICB8IDcgKysrKy0tLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9saW5rL3Byb3Rv
Y29scy9saW5rX2RwX2RwaWFfYncuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9saW5rL3Byb3RvY29scy9saW5rX2RwX2RwaWFfYncuYw0KPiBpbmRleCAyZTI1MWRjYmIwMjIu
LjkzMWY3YzY0NDZkZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfZHBfZHBpYV9idy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9saW5rL3Byb3RvY29scy9saW5rX2RwX2RwaWFfYncuYw0KPiBA
QCAtMTM3LDggKzEzNyw5IEBAIHN0YXRpYyB1aW50OF90IGdldF9sb3dlc3RfZHBpYV9pbmRleChz
dHJ1Y3QgZGNfbGluaw0KPiAqbGluaykgIHsNCj4gIAljb25zdCBzdHJ1Y3QgZGMgKmRjX3N0cnVj
dCA9IGxpbmstPmRjOw0KPiAgCXVpbnQ4X3QgaWR4ID0gMHhGRjsNCj4gKwlpbnQgaTsNCj4gDQo+
IC0JZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfUElQRVMgKiAyOyArK2kpIHsNCj4gKwlmb3IgKGkg
PSAwOyBpIDwgTUFYX1BJUEVTICogMjsgKytpKSB7DQo+IA0KPiAgCQlpZiAoIWRjX3N0cnVjdC0+
bGlua3NbaV0gfHwNCj4gIAkJCQlkY19zdHJ1Y3QtPmxpbmtzW2ldLT5lcF90eXBlICE9DQo+IERJ
U1BMQVlfRU5EUE9JTlRfVVNCNF9EUElBKSBAQCAtMTY1LDggKzE2Niw5IEBAIHN0YXRpYyBpbnQN
Cj4gZ2V0X2hvc3Rfcm91dGVyX3RvdGFsX2J3KHN0cnVjdCBkY19saW5rICpsaW5rLCB1aW50OF90
IHR5cGUpDQo+ICAJdWludDhfdCBpZHggPSAobGluay0+bGlua19pbmRleCAtIGxvd2VzdF9kcGlh
X2luZGV4KSAvIDIsIGlkeF90ZW1wID0gMDsNCj4gIAlzdHJ1Y3QgZGNfbGluayAqbGlua190ZW1w
Ow0KPiAgCWludCB0b3RhbF9idyA9IDA7DQo+ICsJaW50IGk7DQo+IA0KPiAtCWZvciAoaW50IGkg
PSAwOyBpIDwgTUFYX1BJUEVTICogMjsgKytpKSB7DQo+ICsJZm9yIChpID0gMDsgaSA8IE1BWF9Q
SVBFUyAqIDI7ICsraSkgew0KPiANCj4gIAkJaWYgKCFkY19zdHJ1Y3QtPmxpbmtzW2ldIHx8IGRj
X3N0cnVjdC0+bGlua3NbaV0tPmVwX3R5cGUgIT0NCj4gRElTUExBWV9FTkRQT0lOVF9VU0I0X0RQ
SUEpDQo+ICAJCQljb250aW51ZTsNCj4gQEAgLTQ2NywxMiArNDY5LDEzIEBAIGJvb2wgZHBpYV92
YWxpZGF0ZV91c2I0X2J3KHN0cnVjdCBkY19saW5rICoqbGluaywNCj4gaW50ICpid19uZWVkZWRf
cGVyX2RwaWEsIHVpbnQ4DQo+ICAJYm9vbCByZXQgPSB0cnVlOw0KPiAgCWludCBid19uZWVkZWRf
cGVyX2hyW01BWF9IUl9OVU1dID0geyAwLCAwIH07DQo+ICAJdWludDhfdCBsb3dlc3RfZHBpYV9p
bmRleCA9IDAsIGRwaWFfaW5kZXggPSAwOw0KPiArCXVpbnQ4X3QgaTsNCj4gDQo+ICAJaWYgKCFu
dW1fZHBpYXMgfHwgbnVtX2RwaWFzID4gTUFYX0RQSUFfTlVNKQ0KPiAgCQlyZXR1cm4gcmV0Ow0K
PiANCj4gIAkvL0dldCB0b3RhbCBIb3N0IFJvdXRlciBCVyAmIFZhbGlkYXRlIGFnYWluc3QgZWFj
aCBIb3N0IFJvdXRlciBtYXgNCj4gQlcNCj4gLQlmb3IgKHVpbnQ4X3QgaSA9IDA7IGkgPCBudW1f
ZHBpYXM7ICsraSkgew0KPiArCWZvciAoaSA9IDA7IGkgPCBudW1fZHBpYXM7ICsraSkgew0KPiAN
Cj4gIAkJaWYgKCFsaW5rW2ldLT5kcGlhX2J3X2FsbG9jX2NvbmZpZy5id19hbGxvY19lbmFibGVk
KQ0KPiAgCQkJY29udGludWU7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KPiBpbmRleCA1NGQzNmRmMTMwNmYuLmVh
OGYzZDZmYjk4YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQo+IEBAIC0zMjUsNiArMzI1LDcgQEAgc3RhdGlj
IGludCBzbXVfdjEzXzBfNl9zZXR1cF9kcml2ZXJfcHB0YWJsZShzdHJ1Y3QNCj4gc211X2NvbnRl
eHQgKnNtdSkNCj4gIAlzdHJ1Y3QgUFBUYWJsZV90ICpwcHRhYmxlID0NCj4gIAkJKHN0cnVjdCBQ
UFRhYmxlX3QgKilzbXVfdGFibGUtPmRyaXZlcl9wcHRhYmxlOw0KPiAgCWludCByZXQ7DQo+ICsJ
aW50IGk7DQo+IA0KPiAgCS8qIFN0b3JlIG9uZS10aW1lIHZhbHVlcyBpbiBkcml2ZXIgUFBUYWJs
ZSAqLw0KPiAgCWlmICghcHB0YWJsZS0+SW5pdCkgew0KPiBAQCAtMzM5LDcgKzM0MCw3IEBAIHN0
YXRpYyBpbnQgc211X3YxM18wXzZfc2V0dXBfZHJpdmVyX3BwdGFibGUoc3RydWN0DQo+IHNtdV9j
b250ZXh0ICpzbXUpDQo+ICAJCXBwdGFibGUtPk1pbkdmeGNsa0ZyZXF1ZW5jeSA9DQo+ICAJCQlT
TVVRMTBfVE9fVUlOVChtZXRyaWNzLT5NaW5HZnhjbGtGcmVxdWVuY3kpOw0KPiANCj4gLQkJZm9y
IChpbnQgaSA9IDA7IGkgPCA0OyArK2kpIHsNCj4gKwkJZm9yIChpID0gMDsgaSA8IDQ7ICsraSkg
ew0KPiAgCQkJcHB0YWJsZS0+RmNsa0ZyZXF1ZW5jeVRhYmxlW2ldID0NCj4gIAkJCQlTTVVRMTBf
VE9fVUlOVChtZXRyaWNzLQ0KPiA+RmNsa0ZyZXF1ZW5jeVRhYmxlW2ldKTsNCj4gIAkJCXBwdGFi
bGUtPlVjbGtGcmVxdWVuY3lUYWJsZVtpXSA9DQo+IEBAIC00NjYsNyArNDY3LDcgQEAgc3RhdGlj
IGludA0KPiBzbXVfdjEzXzBfNl9zZXRfZGVmYXVsdF9kcG1fdGFibGUoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUpDQo+ICAJc3RydWN0IFBQVGFibGVfdCAqcHB0YWJsZSA9DQo+ICAJCShzdHJ1Y3Qg
UFBUYWJsZV90ICopc211X3RhYmxlLT5kcml2ZXJfcHB0YWJsZTsNCj4gIAl1aW50MzJfdCBnZnhj
bGttaW4sIGdmeGNsa21heCwgbGV2ZWxzOw0KPiAtCWludCByZXQgPSAwLCBpOw0KPiArCWludCBy
ZXQgPSAwLCBpLCBqOw0KPiAgCXN0cnVjdCBzbXVfdjEzXzBfNl9kcG1fbWFwIGRwbV9tYXBbXSA9
IHsNCj4gIAkJeyBTTVVfU09DQ0xLLCBTTVVfRkVBVFVSRV9EUE1fU09DQ0xLX0JJVCwNCj4gIAkJ
ICAmZHBtX2NvbnRleHQtPmRwbV90YWJsZXMuc29jX3RhYmxlLA0KPiBAQCAtNTEzLDcgKzUxNCw3
IEBAIHN0YXRpYyBpbnQNCj4gc211X3YxM18wXzZfc2V0X2RlZmF1bHRfZHBtX3RhYmxlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQ0KPiAgCQlkcG1fdGFibGUtPm1heCA9IGRwbV90YWJsZS0+ZHBt
X2xldmVsc1swXS52YWx1ZTsNCj4gIAl9DQo+IA0KPiAtCWZvciAoaW50IGogPSAwOyBqIDwgQVJS
QVlfU0laRShkcG1fbWFwKTsgaisrKSB7DQo+ICsJZm9yIChqID0gMDsgaiA8IEFSUkFZX1NJWkUo
ZHBtX21hcCk7IGorKykgew0KPiAgCQlkcG1fdGFibGUgPSBkcG1fbWFwW2pdLmRwbV90YWJsZTsN
Cj4gIAkJbGV2ZWxzID0gMTsNCj4gIAkJaWYgKHNtdV9jbW5fZmVhdHVyZV9pc19lbmFibGVkKHNt
dSwNCj4gZHBtX21hcFtqXS5mZWF0dXJlX251bSkpIHsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
