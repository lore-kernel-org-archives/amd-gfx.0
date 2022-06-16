Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF3DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 04:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC1010F3CE;
	Thu, 16 Jun 2022 04:13:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC18910F3CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 04:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7oJ9GaRuycLkwvEd7yDW7fSnZNLTZ8BlwiYGPE2SDqjPF/EDYF2qOQwvGrRw/84vWNU+T9+aYBEbOiFIW6rczodahC25YaMBKbXnLSU7sXjrN89c619WdZ9KlKLI5IpkVVz+S9elM40tSCAJYWj/nrRS6Ylask+AkUxQcwvV9rsQGP/jUcRFz3NAZgKWtcFyxPXiSt/M1BJceyH8zhXcwzKsvrzqM6g5eYjwl1HmesJJkY4sRDw6Ee9kkFYBDWGysl1CZoK2JFGU20OsJHXqK6s2/2bJqqj9+j50izbyKer6SCu3FcnIQtFcMEFqgbi93lxWoFzYKDu2X4LWHEHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLVywMTC9734Yl0CrGaCK8meCS7g6b+o8gQY6OMM98o=;
 b=gTL2+/3pVrJTvk8cz3jI0Mo2XQ2D3TYXrvghMKseT2MmN44QmyHEKd2OlQ2jkmNGElaEb/P6w9UOjCP0IITFuLCTi8KOfEXtPBJ4PQBUgDd5dLkFxWHZMVo35Yiejt2D6DgWr9I9oPbION/9aFdf67Ay+3ZLZu+o19CJN8fNFm8eesSoClHZP2+f6wVVRqshWAtoilPW11prRnbM5fmSYhq2d+yA+ljazpa+A/8HhoEDvCu5ej7pMe2iEyL6GRHXEJDk+ROJqqdnsR93KTuQ5957HFcMZfeWnhqKNXSWGpZFAqYaCQH3gXUJQ+2gtnk16PwQSwoTXct2Ijwe9AJzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLVywMTC9734Yl0CrGaCK8meCS7g6b+o8gQY6OMM98o=;
 b=EDG+DziF760VWfh/wV+a6t2sSdopGu9OWq/ff1OSFxkdRZ6/Fc2f7XYUW35M8x9Lyuj5FuBcoRsCJFnBG4fy65GAy1hkbtAPJE46OfbZn4j+I9WbgeMycL+P5TXtV85DlAn3IEXzUyfuNLCpwE7Nqf2r+a52HcE2vWisxajfSQQ=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BYAPR12MB3608.namprd12.prod.outlook.com (2603:10b6:a03:de::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 04:13:49 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::99e0:2660:e0:83e9]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::99e0:2660:e0:83e9%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 04:13:49 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdS9wbTogYWRq?=
 =?utf-8?Q?ust_EccInfo=5Ft_struct?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct
Thread-Index: AQHYgTBXxBesc1AlxEuD1O3eX9fYIK1RZd8AgAAES6A=
Date: Thu, 16 Jun 2022 04:13:49 +0000
Message-ID: <BL1PR12MB53346272EF2F476F7F936FF39AAC9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220616032222.9207-1-Stanley.Yang@amd.com>
 <BN9PR12MB5257AE3268E3C404A62FD923FCAC9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257AE3268E3C404A62FD923FCAC9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8ebd7c7-4daa-4058-a6b0-a30c486c8183;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-16T03:48:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a08d781a-f99f-4239-6573-08da4f4e9d6b
x-ms-traffictypediagnostic: BYAPR12MB3608:EE_
x-microsoft-antispam-prvs: <BYAPR12MB36081A4F3AD06D96D3BA9B889AAC9@BYAPR12MB3608.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1C2HsO/AKalXOu7qUhPBz+VXc+aT20gpM559qLX8jphEIQYpRHoAu4le8gstUrYL272415dzV50YNvAf0Y8u9IEQcHC/j+QC32SQC0Q8I9e6Nl+obPrSFQTh17mRqX1Ah/QBD+3z9nkYAQXO63OCEJ1q8bNfmP4Xf7GljSpzETyzWe8iSmAbcOgEQF+XgdH79rufofdRTNQKUif3sEuU0/3+Pnew+GhrUeP47qUuM6xOQPPKlmJWfcoPtyo5dn9/XUsGm4+GZdbqrIURrdqT3RWfqimaP8EIO1ICv+895AhMXIbHWLYwcO40+e/QWMiDOclCqOdM8bY5dgmACvvzHSPe16hF4KGnCzyZOOPWTcO/jKzNfZdfTMd3ISFac123qdQ2F2Yt94Vza/ORC8HkTNIHNNhattrkYBj1BeIt32svRrXkLQSGhTV4PUcrOqkFAF7KhCQx6nVKxcKx+2UqGE0doqzyqRDuCDEeNiuCmyTjY3DsPAXvrtm0zP1FBfxOueIcJaJssacbLYsDf89d9EjGwoYPQpt1hnFpE7yPEuB8I5jI92Ol9Kjwv0Biyno2vkitbySEDtjoOyYDM3Vd8mrHAMUV+2v2hveqt3Ko0H6wvoIuhshw/Z3nS7OmMOZH0ivpl8NB6ddD26NDk2pbxCDgo9eJcbH51yUkHcJTDKPuNEQpfc4xAA8I5FFcWj+jwrCWFl5Q/ASIKWvkAF/oLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(508600001)(52536014)(66476007)(316002)(66446008)(8936002)(71200400001)(33656002)(122000001)(38070700005)(66946007)(6636002)(110136005)(86362001)(76116006)(64756008)(66556008)(6506007)(83380400001)(53546011)(5660300002)(186003)(26005)(38100700002)(2906002)(55016003)(9686003)(224303003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2R3MUJBSjYrUUE1NXVSN3djV3lxdzFRSkdIT1NOdXV4QnhVYlB0OGpnUThY?=
 =?utf-8?B?L2owL0ZrZFVoeTZhdzdEYTBJUVF5NWxGMk1OczBHbUVmVTdFT3IxK09RcDkv?=
 =?utf-8?B?RzFNL1MzaC80UHYvQitJKzhRWWVmVU9QRXBXWHgvOENJR2dqNHMwNlhmSU5M?=
 =?utf-8?B?QUVtdTlrMnJDYmF5dmM5YXZUY09jTFJhaVo3Qzhya3VsVUxOZnpzR2tCTGxi?=
 =?utf-8?B?NGFBbmhBQTc2SFNUWnVXcDlDZDZ6QUIwNHp0YzdTV2paVENTa2ovSE15SmVx?=
 =?utf-8?B?ci80eXdqRTl1Y3kreVNJZHg3dVZmM21FdGJhWm5Qa1RRb1lET1FvWUJuK0kx?=
 =?utf-8?B?WHdxZDM3KytTL1Q1anExZ0JxUGFJenJHaUV5T1JDbzJwdzFJQzBxUmVmdTRH?=
 =?utf-8?B?ZmZ0eHY5Y1hoRTNHUTcwZVN1cWZxQk5aSXhoQjJOb3RqMVlKOURLWWxqcEZS?=
 =?utf-8?B?UDZ6NGhnbzZKZ2hoUm9rVjB3WkJNa1pQamdSSGRGa2NCMXpsMnJWNS9sY2Rv?=
 =?utf-8?B?Z1M3YXkwZ0VlNzhRTFhsczduTXhoM3hLV0ZsbUo4Q3orWCtxQ2xwbDJQTjF6?=
 =?utf-8?B?MHNxbG1aaDg0ZXd6M3cyWEx2Z3FOQlVCcG1NOVgyMThJVjFhU1ZHLzJGcCty?=
 =?utf-8?B?dExXQm85RS91U2REVnorLzdhbTBGRDdHMnhoS3JJeGdlUEY0TGhZc3NCMnhl?=
 =?utf-8?B?VUYvbVBvdlpmTjdSYUcraGxKTk1aYVR6TEF0MmNCV2lJK3VwMEJqZFR6Qldu?=
 =?utf-8?B?Q3JQRTV6Y2tEbXR6dW96RWYzalFURXpWNG5SYXBqSlNTN0pwMnNlZ3dsNnZX?=
 =?utf-8?B?YzNBVWVYaVM5THpwSnU2K2ZHdGdPNG1tV1JMcHlPVGdxcWxJcEFVS3k4RHJq?=
 =?utf-8?B?ZzdTYlJ5Z2VhRFVBczFOY2dGaURCbXcvRTVOVXZBVGRxazJSUDFxbHhrZEJv?=
 =?utf-8?B?UU0xeHNrMUZ3MUNLWndlQnpmTGJBcE1QdlE2VThvelpXSXRpSEtPVzZPOTZM?=
 =?utf-8?B?ZmtKdTZOL2YxcE1neFNORzRkaWpyci9VZXNWOFJmNWpqc250QklwMmFsTllT?=
 =?utf-8?B?MTg2SnQyZ2xXQWJJblNQNUVFRzkyZitDL1FxeWNMUVJnbkdmMG4yQmNFb2ti?=
 =?utf-8?B?L29TL1hNZTVLVEM5eXEyTTBYNC9pdzU1QW9RSUhuRXFKdkpBdFNBa2w3ejVY?=
 =?utf-8?B?R0FvWS8reURqNm5wYXBFeEk4UXNzQkdqelNJZVQrdXNXTzNtKzZTSVk3Mm5p?=
 =?utf-8?B?bXB6N1ZUM0RCeEtxZS9VeW05QytmNE11THpCSkZaTS9SdHNWTmswYzdKdUlU?=
 =?utf-8?B?Q2swN3FxTnh0WXU3UXlZZHNaQjN2dVFpeUdqVVFtRmhpZEtibmhPNFhjbE1w?=
 =?utf-8?B?U3pHS1BIS0k4YTFOdVBZUWZZYXdWbzUvbUZUbXRwUENtWFEwME1FeXY0Sndu?=
 =?utf-8?B?Q1FXcWUrcTkxS1o1Qkh6dnB6YlhxN2IzTnB1UGt0aTdnUFEwenp2QmpId3hR?=
 =?utf-8?B?ZVdsVUp2THFjVzhFYm9QVTNJV2ZJWnlKWlgyVGlJQWI3ZEpQKzJHTkRwVWxr?=
 =?utf-8?B?TTlVNlVYV3ZGTHVnRWhtR2M4dEJuQ2dSSVV1cnNURVpwbDdmVXRRRW93UFRt?=
 =?utf-8?B?bVZrcjZPazg5ZVJLeVIyc3dHWXoyeDNQS3ZvZTEvd2JvL1FvOWZLNk95a0ZY?=
 =?utf-8?B?REwrSXBoN0pFREpwK21aY0pHd0JDKytaTG1PM2J6ZmZnMmp6WGdtRWdDcktj?=
 =?utf-8?B?c2MyR2YvNjVIRWRnTk1TWTJycmJPWHZwd1RSTG9xZjdjZEpSdkxIQzczY2hZ?=
 =?utf-8?B?RzFGMFJuZFlobmdXUnR2NCtKRmErT1BXemYraElzVldRczRJclZPWTdEdXk4?=
 =?utf-8?B?S1ExUkN0eTVmUndsQXAzYXFVTktVRERvU21qTzZ3b2RiS3RlL3J1dS9QK25w?=
 =?utf-8?B?YjczYVdCVzFvcEp6aUhTbHYxN1VlNHJhMkh1TG5UZTcwSEtocVJyMGdnMmtV?=
 =?utf-8?B?dHRGajE1YXhURllCR3l4U3Y0aXJwOStST1MzdFhMdG9URXh4UnhRekZQcDN4?=
 =?utf-8?B?cml5a3BFOXprT0pXSzhaSzNMQVdzd3hOQ2hGUzJIU3dvODZ6NFhxWS9oM0VK?=
 =?utf-8?B?d29FMHc4d3RxMng0WElHV2t5UnFtR1cvTGg0ZkNiMnNhcFZVK3UzSUUvVllE?=
 =?utf-8?B?eGlhdGJKNTA1cFJCUVZPYXkwZDI1R0QreDVYQUZmeGd2WldqS21Fa0I5SjhO?=
 =?utf-8?B?UEtPcmlPdDdIc2p0Y0xVeGFTeG5OK3dBWmxDZkpKTmdQVnZRdkJLaDI2R3M2?=
 =?utf-8?B?ZERRa3V4dHhDMkJiQnN6Tis2UlQyRUQ4WmlFT1VPNnJha2tvaWkxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08d781a-f99f-4239-6573-08da4f4e9d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 04:13:49.2982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsixtNBt7kFnd/jlCyif4v02sZZkY6zgkfbFZnuL1F/YXyozLPVlxhL5sznG1ZO+uUIUdLg++NDS1JUu2Bp3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBoYXdraW5nLCBpbiB0
aGUgcHJldmlvdXMgcGF0Y2ggaXQgaGFzIGNoZWNrZWQgcG1mdyB2ZXJzaW9uIGFuZCB0aGUgRWNj
SW5mb190IHN0cnVjdCBpcyBjb25zaXN0ZW50IG9uIGRyaXZlciBzaWRlIGFuZCBwbWZ3IHNpZGUg
d2l0aCBwbWZ3IGRlYnVnIHZlcnNpb24gNjguNTQuMTM2IGR1cmluZyBkZXZlbG9wIHRoaXMgZmVh
dHVyZSwgYnV0IGl0J3MgY2hhbmdlZCBpbiB0aGUgb2ZmaWNpYWwgcmVsZWFzZSB2ZXJzaW9uIDY4
LjU1LjAsIHNvIGRyaXZlciBzaWRlIGhhcyB0byBhZGp1c3QgaXQuDQoNClJlZ2FyZHMsDQpTdGFu
bGV5DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBaaGFuZywgSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiDlj5HpgIHml7bpl7Q6IFRodXJzZGF5LCBKdW5l
IDE2LCAyMDIyIDExOjUwIEFNDQo+IOaUtuS7tuS6ujogWWFuZywgU3RhbmxleSA8U3RhbmxleS5Z
YW5nQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpob3UxLCBU
YW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UNCj4gPENhbmRpY2UuTGlAYW1kLmNv
bT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiDmioTpgIE6IFlhbmcsIFN0YW5s
ZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiDkuLvpopg6IFJFOiBbUEFUQ0ggUmV2aWV3IDEv
MV0gZHJtL2FtZGdwdS9wbTogYWRqdXN0IEVjY0luZm9fdCBzdHJ1Y3QNCj4NCj4gW0FNRCBPZmZp
Y2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IEZvciB0aGUgc3RydWN0dXJlIGl0c2VsZiwg
dGhlIGNoYW5nZSBpcyBva2F5IHRvIG1lLiBCdXQgeW91J2xsIGhhdmUgdG8gYXBwbHkgcG1mdw0K
PiB2ZXJzaW9uIGNoZWNrIGluIHRoZSBpbXBsZW1lbnRhdGlvbiB0byBtYWtlIGRhdGEgbWF0Y2hl
cyB3aXRoIGZ3IHN0cnVjdHVyZQ0KPg0KPiBUaGUgcGF0Y2ggaXMNCj4NCj4gUmV2aWV3ZWQtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4NCj4gUmVnYXJkcywNCj4g
SGF3a2luZw0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGFubGV5
LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxNiwg
MjAyMiAxMToyMg0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBI
YXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IExpLCBDYW5kaWNlDQo+IDxDYW5kaWNlLkxpQGFtZC5jb20+OyBRdWFuLCBFdmFu
IDxFdmFuLlF1YW5AYW1kLmNvbT4NCj4gQ2M6IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdS9wbTogYWRq
dXN0IEVjY0luZm9fdCBzdHJ1Y3QNCj4NCj4gVGhlIEVjY0luZm9fdCBzdHJ1Y3QgaW4gZHJpdmVy
X2lmLmggaXMgYXMgYmVsb3cgaW4gb2ZmaWNpYWwgcmVsZWFzZSB2ZXJpb24gNjguNTUuMA0KPiB0
eXBlZGVmIHN0cnVjdCB7DQo+ICAgIHVpbnQ2NF90IG1jYV91bWNfc3RhdHVzOw0KPiAgICB1aW50
NjRfdCBtY2FfdW1jX2FkZHI7DQo+DQo+ICAgIHVpbnQxNl90IGNlX2NvdW50X2xvX2NoaXA7DQo+
ICAgIHVpbnQxNl90IGNlX2NvdW50X2hpX2NoaXA7DQo+DQo+ICAgIHVpbnQzMl90IGVjY1BhZGRp
bmc7DQo+DQo+ICAgIHVpbnQ2NF90IG1jYV9jZXVtY19hZGRyOw0KPiAgfSBFY2NJbmZvX3Q7DQo+
IEl0J3MgZGlmZmVyZW50IGZyb20gdGhlIGRlYnVnIHZlcnNpb24gZHJ1aW5nIGRldmVsb3AgcHJp
bnQgY29ycmVjdGFibGUgZXJyb3INCj4gYWRkcmVzcywgc28gYWRqdXN0IEVjY0luZm9fdCBzdHJ1
Y3QuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5nQGFtZC5j
b20+DQo+IC0tLQ0KPiAgLi4uL2RybS9hbWQvcG0vc3dzbXUvaW5jL3BtZndfaWYvc211MTNfZHJp
dmVyX2lmX2FsZGViYXJhbi5oICAgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxM19kcml2ZXJfaWZfYWxkZWJhcmFuLmgN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZl
cl9pZl9hbGRlYmFyYW4uaA0KPiBpbmRleCA2ZjkyMDM4NDcwZWMuLjdhNjA3NWRhYTdiMiAxMDA2
NDQNCj4gLS0tDQo+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9z
bXUxM19kcml2ZXJfaWZfYWxkZWJhcmFuLmgNCj4gKysrDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxM19kcml2ZXJfaWZfYWxkZWJhcmFuDQo+ICsrKyAu
aA0KPiBAQCAtNTIxLDEyICs1MjEsMTMgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgdHlwZWRlZiBz
dHJ1Y3Qgew0KPiAgICAgICAgIHVpbnQ2NF90IG1jYV91bWNfc3RhdHVzOw0KPiAgICAgICAgIHVp
bnQ2NF90IG1jYV91bWNfYWRkcjsNCj4gLSAgICAgICB1aW50NjRfdCBtY2FfY2V1bWNfYWRkcjsN
Cj4NCj4gICAgICAgICB1aW50MTZfdCBjZV9jb3VudF9sb19jaGlwOw0KPiAgICAgICAgIHVpbnQx
Nl90IGNlX2NvdW50X2hpX2NoaXA7DQo+DQo+ICAgICAgICAgdWludDMyX3QgZWNjUGFkZGluZzsN
Cj4gKw0KPiArICAgICAgIHVpbnQ2NF90IG1jYV9jZXVtY19hZGRyOw0KPiAgfSBFY2NJbmZvX1Yy
X3Q7DQo+DQo+ICB0eXBlZGVmIHN0cnVjdCB7DQo+IC0tDQo+IDIuMTcuMQ0KPg0KDQo=
