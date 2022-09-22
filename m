Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C81C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06AA10E046;
	Thu, 22 Sep 2022 17:57:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB7E10E046
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUnxyVX7CHfiWf77ARj8IghBE00TxV+4HuBkVrPz8JmyLPKz+rCCS6Xy1c00K83stjsvHLz1ClmNJm2aZkNRu6RygQvJuVG3BFpAEbvPHLjoFye74lq1wgLEh3ldIqrUuaPDi3f0644vG6tGlyybg38dOANy9TKaGMcXFxbnX5Mm7YGxrrJDJgdaBJec4Vp7Fup6HU11YyHskedcPYSqMLxNXzuXE7wQcM5FU9kfjR2sBuzu/WCDqzum2B/lLVnROFrVnUc2H4ayvnS/YOEcQI85hoiCTZY/JGdoja0ZiATWp+mz6F39LTxpuIFPWt0x+z3GPy+7Jpw/YHr3Ln+PvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e/qnCl/mhcJo7yWDWF/q8fp8B90awyGAGNX0wNwtvA=;
 b=PD26MInEs+TWEH0LMtCrw2NSvB2cgrqyuPTdP1+BQj9mDbPE5atSYHoVkYfb47cRBT692J51VKVRyU4hh2ocOMaRhQAAoGi2rFPda5CE3cWrnHnMcdVe9f0si6yoejp6hJKclu3W2HBDayMMUC4TkzKkbFQcs0an0geyc/ep5DtgABGHIJG532paS9JAWgUHITxj59oiaoKTlYwZafVNVTf1l7jPQAV09pqw+u65jeoewq8J5iEs2eQaz247Ed90fSApPTOpLprKoyeLqU62y1KQM29miJ4+19R/FvXLArH1J1N4LTY8EsY7qkysgMu8OpDFux4TntKHlMsSkroFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e/qnCl/mhcJo7yWDWF/q8fp8B90awyGAGNX0wNwtvA=;
 b=V62+6WVpp/8NfUvsc5cnBb9rISB5J+oZkcyGTOgLcQQqq2xdMW3TKGZSGO8IxAssrp52+SZdQCHwou/CO7ZvcnN7kXlfiLwtNbqQVAqHgo2rrnOQafsFHvqQ0E7l7cAlmu+vp66yhsumi+FM+InUzQczWQx7JZ2hDkeB9Q5yRfw=
Received: from DM6PR12MB4828.namprd12.prod.outlook.com (2603:10b6:5:1f8::26)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 17:57:48 +0000
Received: from DM6PR12MB4828.namprd12.prod.outlook.com
 ([fe80::d465:82c6:e25e:afce]) by DM6PR12MB4828.namprd12.prod.outlook.com
 ([fe80::d465:82c6:e25e:afce%4]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 17:57:48 +0000
From: "Belanger, David" <David.Belanger@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable SA software trap.
Thread-Topic: [PATCH] drm/amdgpu: Enable SA software trap.
Thread-Index: AQHYzp74F/5k9rz45ki/fjnPiMfzOK3rsDuAgAAKz5A=
Date: Thu, 22 Sep 2022 17:57:48 +0000
Message-ID: <DM6PR12MB48283F913E02A64B3E3AE4DD994E9@DM6PR12MB4828.namprd12.prod.outlook.com>
References: <20220922161703.916705-1-david.belanger@amd.com>
 <2943b204-2999-b6f7-1f30-bdeb85a711cb@amd.com>
In-Reply-To: <2943b204-2999-b6f7-1f30-bdeb85a711cb@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T17:52:54Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7a2acb97-d079-46b2-83f2-c4770728f55c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-22T17:57:46Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b7e63bca-42e6-418a-aa49-a5db773439cd
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4828:EE_|CY5PR12MB6597:EE_
x-ms-office365-filtering-correlation-id: 563600c3-b90a-40ac-85e5-08da9cc3f5b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UW3vbi9FM3kqVUCYNuAtkEi2A/WJjGmlonoWI78GUgOpm9wOR72tazxVQqrY0W2VRT/kElLeqeb3hGbXy66LICbck02gFKmlfvXLIt65ot9GOjrt2ouW1CT3rVSY6HT8kHDEaDfe7wqyw+sVnVTIxZKJyli+Hh7XfO9lsDEt0hwsU7FZYRUxTYJoVhtnfUuWbtVWiSnlgV6vsgm3xcPLU2ficVq0YyDlQwBkJcB7adl/JRBljKuupSJN83nFGqjNY7YSjvYZO+Qb2nDb24SVqm0aD41ZQ6Gyo0ktYjSF0FzJ9KfNZTqlKRG50rW+qTQgy/vPHQ9xFFjyPxr1XjEIoNhlIpnRj2yWyiS0ONcl9gLQkuBrI56wT/5u2ZGrtx8wbEVZCfnKN9qoDL3cP22ekKvR074hYSyuO8KQzyEJ8bx4kCvJRaTyzg0eYivbF35BfbWbUl421MajZ0nOagPwCkSSsNC3OHEye4Su7vkfeyEG6kOsmEzO4gOEHR8nJMzM5xqr7AP6kMKEH+nqQ71ju0lqUMBSuzZRtoPaaWDgAhubJZCEIS+RQI3cAjtVQk6YwDm2vExN0pSWKJ3oDatYUzUcmR9miWDfqnzZalv+qBfH5gbsnq1FKFSvzcDcz4zlD121o5lPPbFkj2KBS5eSJcRVbTQWGeoi5njS8nn6Hb8yd8n/5W0Pwo53SxntV2GphsXO+yg3ZU1J5VFyipdT/JFS4kgyJHJtYk1nIlwDCTE9YZoiAVT/1JxNyvLphxSKkkMuFgcM6Q8RD0POf9C5pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4828.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(4326008)(478600001)(53546011)(26005)(71200400001)(55016003)(8936002)(5660300002)(9686003)(6506007)(7696005)(41300700001)(186003)(110136005)(38070700005)(76116006)(33656002)(86362001)(66946007)(52536014)(2906002)(66446008)(66476007)(64756008)(83380400001)(66556008)(38100700002)(316002)(122000001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk4yR0VQU05QWDViOHFXUHZiR3NLZUJuN1JSNFBHRFFDeWRtWjlVQ1VpQzly?=
 =?utf-8?B?RGovSm51LzVRdVRJSkZiRzVjU0lmbDNzcVVXVFBlZW5Pd2UrcVBFb3NlcGkz?=
 =?utf-8?B?TFV3ODUydjV0bC9lSGQwdDlVWlNobk15eXFEWkxYd05Ed0R0NGxzdUhaK1JD?=
 =?utf-8?B?Um9XVGxMdHVUVGxyN21EYy83M2JRVW5hcnNwMUdZYnR2QWx6TjREcXlDUXZC?=
 =?utf-8?B?dklSc0kyOTVySTBDVTA0TmhlMy9JY1NmYzVISFVYV1RrNUI0dU00R1gzbEh4?=
 =?utf-8?B?Uk5CWmwybzEydU9WQithM2Jsazc3ZU5lVWJVUml2eEpuWHoyQ0Y0aHVhdHli?=
 =?utf-8?B?RE1TdkFSOFVHZjJFb293RXluY0JMVHR5aEtJMGs1MXBGUUFWdFJ0OVUwZTlT?=
 =?utf-8?B?d1M2ZlAyMmhJajRPTXZ5TXpvZ0JVeHQxT0d1ZzBTZlZVU0Z5akRqNlhyb21w?=
 =?utf-8?B?ZXlGVEtsdEliSW9FSHhyRWdzbTFENmtObWkybTl5eklpSmNhZ3BHUW1STHFI?=
 =?utf-8?B?MU0rRWNhcXdaZ0dNS3UycUlpandSUnQ4WGdFaS9NR3dWL0VLRjBpaHJEMkJ2?=
 =?utf-8?B?L3ZoRHNueUlSWjZZS3JNZFpkR090bkxvWWkzd3NLVUJjZHQycWpqQlhMTWF6?=
 =?utf-8?B?NGJyelJ5ay9DSmxvbEVPcndNRGlzM0Jmc1RsSzJxa2J0QkNnQmZLc2JjWm05?=
 =?utf-8?B?dTNTa0I3UUpQbGx0eXZrdXZzOEVyT01HWTlFZ2Zqb2J6NjJYSXRqQUZIbGxD?=
 =?utf-8?B?cE1Sb2tORXdXUlJkNUZpM2hwVkJEWXQ5ZlNLRk1uc3RVQzA2VnZXTkRibitO?=
 =?utf-8?B?cGYzS1FzR201S2lFVkI3RHJmWFhlaG92MHZnbHMvbmJjTE5DOW9sVnNMbU5a?=
 =?utf-8?B?ZTJUeDROM0FPS2wxOG56NWZsbUIyNDdSLzNBY0FSSldqYjBJRlFxdk02OGJC?=
 =?utf-8?B?TjNHanAwUFIxQUFZbkpBR2l2bDc4TnRFU1JDWEpQcTYxYzJYeXZWekszbTBM?=
 =?utf-8?B?UG5qZkJjb2ZUbWRBTXhtZ3c1T3lCREpyN2dKMXpWeXlFclhSdU9Fdk1GTEFG?=
 =?utf-8?B?dmpNSGlzOURKZUdTRCtxdzZNS1RUayt2ZnhQQ3BEVko5aTNQb1JUY21yY2RP?=
 =?utf-8?B?R1FwN3ovYjZjZ05VYTFoSDVOY1h0VDhnYmY1ZzU3Q0JxVUFqYTM2YXlkSm9O?=
 =?utf-8?B?TjBJUHdVcFdjSnBwRGQ1WlVVZW1Ma2k0YTdWb1E4R25NckhsTzk2YzJJL1RS?=
 =?utf-8?B?Ny9ob1BlcUlRQnBNRlFHRmV5aytOQ0xBckVvbjBocmFhTTR1ZHgzUm5zaFQ1?=
 =?utf-8?B?SUVkS3BHVS9rNzA5blYyRzV4M2JTYmZJQ1NPQzVPdGg3OXZWbHFXa0EwaGty?=
 =?utf-8?B?c3ZrbVJHNXJpMjlCTmlMRTczb1ZrRk5LNkh2SFlEUlU0cUl1aEtHNDhNeDdR?=
 =?utf-8?B?UEUwNHdYcCtyQ0ttV1AvTlYwcklQWDZwa3hFMThEYkYxMzZUVGNSWmJzNjk1?=
 =?utf-8?B?ZzluMkpsTVRWOHovdXpLUnpXYU1NN2RqcmUvVElHeFRUaktrN1ZlRVZGYnNz?=
 =?utf-8?B?WGY3dDI4clU2Z21mdHdoT2FGQVc3VUdYS25XUjZGM29JSm11ZGNvRXNkNG81?=
 =?utf-8?B?QUVIWVplcUxZLzZVKzhobm1yRFVJMlV0SzcrWWFtcHF0aGZnRWxzMGFYb3ZN?=
 =?utf-8?B?ek9zTnJ1Q0lleWN5dnlyMk5pUXVpZlZCN25XS0t6T2NZRUQvcGk3TDg3S04r?=
 =?utf-8?B?NXlZNGdOZXlQck5PdHk5T1VPOHVvNlYxSUdaVmpTTStHckhsdzR4SjVEdTNZ?=
 =?utf-8?B?NjNHUktYdGszZmpHdmF1cmgvRjhhZUVSbSt6VzFoZUMrbWxSY05jRVRndFkv?=
 =?utf-8?B?dDJiZklESG5GeTE3S25iZjZuSWVWNnV2b0VvcVhyYzREWnFJRWc5ZW1mSHo1?=
 =?utf-8?B?T1AvVkhWMUY1MkRiY0pxWGJ2WVZlaWdWVUQwRzd2cTQxMWVtVEdTVE9xUXFj?=
 =?utf-8?B?cEs1d0prZU1MVUxLV2dqckpZTUxtSTBtM1FCV1dHNzNXM3RCMDQ5VEYwMUJ0?=
 =?utf-8?B?aFlGZ2N4ZlNZMEJIOHFPV245QnVzcW5uYmpZOFhlZXlrOGx1RzJPM1JEOU93?=
 =?utf-8?Q?TlZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4828.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563600c3-b90a-40ac-85e5-08da9cc3f5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 17:57:48.1125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JB//o4WiIl5iKgZBHdzA9eFNEzbk3fQ5OPCCLf1fM6OEPD1RzoFxaB5JamqlUak60FKGhI4g6Me+8i6Uwsg4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMiwgMjAyMiAxOjE0IFBNDQo+IFRv
OiBCZWxhbmdlciwgRGF2aWQgPERhdmlkLkJlbGFuZ2VyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IENvcm53YWxsLCBKYXkgPEpheS5Db3Jud2FsbEBh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBFbmFibGUgU0Egc29m
dHdhcmUgdHJhcC4NCj4gDQo+IEFtIDIwMjItMDktMjIgdW0gMTI6MTcgc2NocmllYiBEYXZpZCBC
ZWxhbmdlcjoNCj4gPiBFbmFibGVzIHN1cHBvcnQgZm9yIHNvZnR3YXJlIHRyYXAgZm9yIE1FUyA+
PSA0Lg0KPiA+IEFkYXB0ZWQgZnJvbSBpbXBsZW1lbnRhdGlvbiBmcm9tIEpheSBDb3Jud2FsbC4N
Cj4gPg0KPiA+IHYyOiBBZGQgSVAgdmVyc2lvbiBjaGVjayBpbiBjb25kaXRpb25zLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogSmF5IENvcm53YWxsIDxKYXkuQ29ybndhbGxAYW1kLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBCZWxhbmdlciA8ZGF2aWQuYmVsYW5nZXJAYW1kLmNvbT4N
Cj4gPiBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYyAg
ICAgICAgfCAgIDYgKy0NCj4gPiAgIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQvY3dzcl90cmFwX2hh
bmRsZXIuaCAgICB8IDc3MSArKysrKysrKystLS0tLS0tLS0NCj4gPiAgIC4uLi9hbWQvYW1ka2Zk
L2N3c3JfdHJhcF9oYW5kbGVyX2dmeDEwLmFzbSAgICB8ICAyMSArDQo+ID4gICAuLi4vZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192MTEuYyAgfCAgMjYgKy0NCj4gPiAgIDQgZmls
ZXMgY2hhbmdlZCwgNDM3IGluc2VydGlvbnMoKyksIDM4NyBkZWxldGlvbnMoLSkNCj4gW3NuaXBd
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJv
Y2Vzc192MTEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9j
ZXNzX3YxMS5jDQo+ID4gaW5kZXggYTZmY2JlZWI3NDI4Li40ZTAzZDE5ZTkzMzMgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3YxMS5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Yx
MS5jDQo+ID4gQEAgLTM1OCwxMyArMzU4LDM1IEBAIHN0YXRpYyB2b2lkIGV2ZW50X2ludGVycnVw
dF93cV92MTEoc3RydWN0DQo+IGtmZF9kZXYgKmRldiwNCj4gPiAgIAkJCQlicmVhazsNCj4gPiAg
IAkJCWNhc2UgU1FfSU5URVJSVVBUX1dPUkRfRU5DT0RJTkdfRVJST1I6DQo+ID4gICAJCQkJcHJp
bnRfc3FfaW50cl9pbmZvX2Vycm9yKGNvbnRleHRfaWQwLA0KPiBjb250ZXh0X2lkMSk7DQo+ID4g
KwkJCQlzcV9pbnRfcHJpdiA9IFJFR19HRVRfRklFTEQoY29udGV4dF9pZDAsDQo+ID4gKw0KPiAJ
U1FfSU5URVJSVVBUX1dPUkRfV0FWRV9DVFhJRDAsIFBSSVYpOw0KPiA+ICAgCQkJCXNxX2ludF9l
cnJ0eXBlID0NCj4gUkVHX0dFVF9GSUVMRChjb250ZXh0X2lkMCwNCj4gPg0KPiAJU1FfSU5URVJS
VVBUX1dPUkRfRVJST1JfQ1RYSUQwLCBUWVBFKTsNCj4gPiAtCQkJCWlmIChzcV9pbnRfZXJydHlw
ZSAhPQ0KPiBTUV9JTlRFUlJVUFRfRVJST1JfVFlQRV9JTExFR0FMX0lOU1QgJiYNCj4gPiAtCQkJ
CSAgICBzcV9pbnRfZXJydHlwZSAhPQ0KPiBTUV9JTlRFUlJVUFRfRVJST1JfVFlQRV9NRU1WSU9M
KSB7DQo+ID4gKw0KPiA+ICsJCQkJc3dpdGNoIChzcV9pbnRfZXJydHlwZSkgew0KPiA+ICsJCQkJ
Y2FzZSBTUV9JTlRFUlJVUFRfRVJST1JfVFlQRV9FRENfRlVFOg0KPiA+ICsJCQkJY2FzZSBTUV9J
TlRFUlJVUFRfRVJST1JfVFlQRV9FRENfRkVEOg0KPiA+DQo+IAlldmVudF9pbnRlcnJ1cHRfcG9p
c29uX2NvbnN1bXB0aW9uX3YxMSgNCj4gPiAgIAkJCQkJCQlkZXYsIHBhc2lkLA0KPiBzb3VyY2Vf
aWQpOw0KPiA+ICAgCQkJCQlyZXR1cm47DQo+ID4gKwkJCQljYXNlDQo+IFNRX0lOVEVSUlVQVF9F
UlJPUl9UWVBFX0lMTEVHQUxfSU5TVDoNCj4gPiArCQkJCQkvKmlmICghKCgoYWRldi0+bWVzLnNj
aGVkX3ZlcnNpb24gJg0KPiBBTURHUFVfTUVTX1ZFUlNJT05fTUFTSykgPj0gNCkgJiYNCj4gPiAr
CQkJCQkJICAoYWRldi0NCj4gPmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdID49IElQX1ZFUlNJT04o
MTEsIDAsIDApKSAmJg0KPiA+ICsJCQkJCQkgIChhZGV2LQ0KPiA+aXBfdmVyc2lvbnNbR0NfSFdJ
UF1bMF0gPD0gSVBfVkVSU0lPTigxMSwgMCwgMykpKQ0KPiA+ICsJCQkJCQkmJiBzcV9pbnRfcHJp
dikNCj4gPiArDQo+IAlrZmRfc2V0X2RiZ19ldl9mcm9tX2ludGVycnVwdChkZXYsIHBhc2lkLCAt
MSwNCj4gPiArDQo+IAlLRkRfRUNfTUFTSyhFQ19RVUVVRV9XQVZFX0lMTEVHQUxfSU5TVFJVQ1RJ
T04pLA0KPiA+ICsJCQkJCQkJTlVMTCwgMCk7Ki8NCj4gPiArCQkJCQlyZXR1cm47DQo+ID4gKwkJ
CQljYXNlDQo+IFNRX0lOVEVSUlVQVF9FUlJPUl9UWVBFX01FTVZJT0w6DQo+ID4gKwkJCQkJLypp
ZiAoISgoKGFkZXYtPm1lcy5zY2hlZF92ZXJzaW9uICYNCj4gQU1ER1BVX01FU19WRVJTSU9OX01B
U0spID49IDQpICYmDQo+ID4gKwkJCQkJCSAgKGFkZXYtDQo+ID5pcF92ZXJzaW9uc1tHQ19IV0lQ
XVswXSA+PSBJUF9WRVJTSU9OKDExLCAwLCAwKSkgJiYNCj4gPiArCQkJCQkJICAoYWRldi0NCj4g
PmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdIDw9IElQX1ZFUlNJT04oMTEsIDAsIDMpKSkNCj4gPiAr
CQkJCQkJJiYgc3FfaW50X3ByaXYpDQo+ID4gKw0KPiAJa2ZkX3NldF9kYmdfZXZfZnJvbV9pbnRl
cnJ1cHQoZGV2LCBwYXNpZCwgLTEsDQo+ID4gKw0KPiAJS0ZEX0VDX01BU0soRUNfUVVFVUVfV0FW
RV9NRU1PUllfVklPTEFUSU9OKSwNCj4gPiArCQkJCQkJCU5VTEwsIDApOyovDQo+IA0KPiBXaGlj
aCBicmFuY2ggaXMgdGhpcyBmb3I/IGtmZF9zZXRfZGJnX2V2X2Zyb21faW50ZXJydXB0IHNob3Vs
ZG4ndCBleGlzdCBvbg0KPiB0aGUgdXBzdHJlYW0gYnJhbmNoIHlldC4gVGhhdCBjb2RlIGlzIHN0
aWxsIHVuZGVyIHJldmlldyBmb3IgdXBzdHJlYW0uDQo+IA0KDQpNeSB1bmRlcnN0YW5kaW5nIGlz
IHRoYXQgaXQgaXMgZm9yIGJyYW5jaCBhbWQtc3RhZ2luZy1kcm0tbmV4dCB0byBtYWtlIGl0cyB3
YXkgdXBzdHJlYW0uDQpUaGUgY29kZSB0aGF0IGNhbGxzIHRoYXQgZnVuY3Rpb24gaXMgY29tbWVu
dGVkIG91dC4gIFRoZXJlIGFyZSBvdGhlciBwcmUtZXhpc3RpbmcgaW5zdGFuY2VzIGluIHRoYXQg
ZmlsZSBpbiBhbWQtc3RhZ2luZy1kcm0tbmV4dCBicmFuY2ggdGhhdCBhcmUgY29tbWVudGVkIG91
dCBhbHNvIHdpdGggdGhhdCBmdW5jdGlvbi4NClBsZWFzZSBhZHZpc2UgaWYgSSBzaG91bGQgcmVt
b3ZlIGl0IGZyb20gdGhlIHBhdGNoIGZvciBub3cgb3Iga2VlcCBpdCBhcyBjb21tZW50ZWQgb3V0
Lg0KDQpUaGFua3MsDQpEYXZpZCBCLg0KDQo+IFJlZ2FyZHMsDQo+ICDCoCBGZWxpeA0KPiANCj4g
DQo+ID4gKwkJCQkJcmV0dXJuOw0KPiA+ICAgCQkJCX0NCj4gPiAgIAkJCQlicmVhazsNCj4gPiAg
IAkJCWRlZmF1bHQ6DQo=
