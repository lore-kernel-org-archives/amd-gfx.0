Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB97C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 20:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52EF611BF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 20:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E52EF611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941316E22B;
	Mon, 15 Nov 2021 20:50:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8326E42F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 20:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwJ7PSyGSCClEQHG1XdmYhOOVSBrNLn9XTO484F+Et0SQ678vHWJAveC4x39gPble0AaGl1VjU2Hud2pgD7p6iMJeB+Gw7+5b2bjmNLGwQKJr4FBJmAjm6qS654XqeTOFor7INe9W9oRWjpRQ7OvZ87+lQQuEE3i2IFWSuvTzt4gB84t56S73t5z/AnfgYj1VtYxnekcwOGPk2M1a4WjA3oJ6YBK1zOayLjxN6tK46rbVQZt/y3hsSNAqMbmv/j/P2FI+T3icEzB8WKPjN3eW5c4fuK4Mn1DUltp931TbG/Gnkr3zh3Ia5bJrxFey8Ewl2tYP2M3CENYdq2oujaMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRENoBB0f5jmgefbUcF7cQWiHnVqScuBey6adYd3EhY=;
 b=DDnFAuxWQUiuMV4z3gXBuEdf99B+KuR71MqL9bn2/X8FIy9C/UVvLckG3yGj7IWjtuoLfcpyKgUi0r00WQ/1AFkAfACCJfdZX9aeybw+PxxntfNkdaFC42KQXrV+T8mBwJ/lnsmWd3CraKFYsSsudjHGPoGyHqs9CNbsJF4GgpCi5+Pb2ukJUREB0POz1uQ8knxSr09ymz7a58IYldzER4bKU9mOM0kczcP0kDusg/zvrARs1PvrbGF86NT96r7aHTpsO2ePRAY1AEf65lBrEXT/DUX0z3oSTfHFodfX1+WbtgesyvHTee344D4EhJ7KcBsmWFdpzQH+/osShIQjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRENoBB0f5jmgefbUcF7cQWiHnVqScuBey6adYd3EhY=;
 b=Vl9AIO7n++Eeho7kfP8kXLXpg6d3wblE3jfWTDfzP1Ac5iN5X8pvPJvYGWyGB8apP06ifjXhLUK8ak32502ISEFsoUWiFoKf7QNXOOs72kLuwk8TyRiXBQHlSbWIHREYS+Bfy5p7alUyjvFlDntRq0xXqEOLj2xXaMoz2mvdB/U=
Received: from DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Mon, 15 Nov
 2021 20:49:56 +0000
Received: from DM6PR12MB3929.namprd12.prod.outlook.com
 ([fe80::353b:72c7:3d1b:787f]) by DM6PR12MB3929.namprd12.prod.outlook.com
 ([fe80::353b:72c7:3d1b:787f%4]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 20:49:56 +0000
From: "Kakarya, Surbhi" <Surbhi.Kakarya@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: Add sysfs interface for retrieving gpu
 metrics(V2)
Thread-Topic: [PATCH] drm/amd/pm: Add sysfs interface for retrieving gpu
 metrics(V2)
Thread-Index: AQHX1+1BBO5yM7mbIE+FV3X3yCow8awASqYAgATJjCA=
Date: Mon, 15 Nov 2021 20:49:56 +0000
Message-ID: <DM6PR12MB3929AE532047ACB9FF6D260C8E989@DM6PR12MB3929.namprd12.prod.outlook.com>
References: <20211112174632.48205-1-surbhi.kakarya@amd.com>
 <CADnq5_Nvtege4LHemFnbnnA4qEmfCNWvCK1Owc1NGpHom0mKSg@mail.gmail.com>
In-Reply-To: <CADnq5_Nvtege4LHemFnbnnA4qEmfCNWvCK1Owc1NGpHom0mKSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=974f9f62-a198-41d4-af75-a59bf9ec25de;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T20:47:38Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dffc9716-9c40-4f35-4cc7-08d9a8797b57
x-ms-traffictypediagnostic: DM5PR12MB2439:
x-microsoft-antispam-prvs: <DM5PR12MB24393D0F9536119E2BC9F1228E989@DM5PR12MB2439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDu24o6vzY3ZRz8NMqZZ32wcbrVfansueU2Ze/zCLWR5DJJvKdyWv4/plXUywauC5Q5LpF+vosIAYP+H5zAtMniUV8JSrmyMMbvwCxEk5xC7oR6nTPrkdmTRGQgVXfWOZ5o4F/wLwK6bTZHCLzytu48VWEw1bOB3frGVGEMAOVqeDg0+TRTUAIy43vnHzjVGaUc2emgpBSUVoa31kFdhCwRfil5dAXImiMUkx7AlHM3kbqE7q4uFfk0+FxVekkKmU9V7gGSMb6ZfjX8dWCIetyDrZ74BFBJH9ZjvdqVUDs7ucUzh2Y0hU5fUmSRKuqzOpqVdnDz+t569zoP8kFsZdi4AMtaUFIugUojwa0nJ26gx/nR7OiW+SrHMiCiZjickcT9WBJdjT7Iq0StuEtz+adiG3qlxObNpLUDXkzJP2IZ+qMmvABE7d9+AIlaexzvrPKPO29rA0B0JOqJd0ZzcYbi1WfwWGYnlpqQJHIuGy5XlyKqGw6hJUhk6ss18X7Ew49ifHTKEoD1Pvcvqppx66yTaUPm2dm+jGWO+UVLwTI3IUgZVjN/vmFsTUoBBH9ATuUGJ6XtbH369DZ5VEBUK9dmIyBAL38/rCzT9UBWrEIducDrzGYTxMliR5RZ7sTYke+ABZN8ytM7A3l63Lrc5zGuXmhKKXEAWejWcIg9g+eH58pvzM3jI74kc3KCHD5AQD44VD3syuUijFoicizF6f1gn77+86K454ekY+QtE79Ifs0ITkj2dbzJhOBhbzQArtAdNo6dr5LImdKT8SSduzGMEwiaBF9U380UlP6ITKmTCJ+6orqc6IBH84cHegMww8aIeWWMmVJRrxUMmhBrDGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3929.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(4326008)(8936002)(316002)(54906003)(6506007)(38070700005)(38100700002)(8676002)(508600001)(6916009)(86362001)(5660300002)(966005)(55016002)(53546011)(2906002)(26005)(52536014)(71200400001)(186003)(76116006)(66476007)(66556008)(66446008)(64756008)(66946007)(7696005)(83380400001)(9686003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGZTdWtkTnRFZFU3WHJGVjVXUFp6WnFuMytyVG5FSjJQaDNnVUlIZmdrbkdU?=
 =?utf-8?B?YzVqQTc4VHFKZzk3b0RXdm8yR3hnbzBOaXFnd0s3Zk9pdWQ0YzllcTlMRk1F?=
 =?utf-8?B?Z2J4NEU0TlkrMkxySWIzdy9DTDRWRUtOQWpoMTVGZ0ZmMU5RRGk4WmQ1WHlE?=
 =?utf-8?B?bzhzNFl3OEljWlJleVJQZUJ2VVpiUXdNeGM5aUlFQ0YwRFRwMElURGhIRXVs?=
 =?utf-8?B?eE11Y0tYTEJxTDREV0JzblUwYnIydVBFRDltRWRiRWQwbFpQS3lXdjJmYXVj?=
 =?utf-8?B?b1lXbWlrd0xENW9IdEYzcVNuYXBqNldxTjBEUjlmWWx2RG5Bc2JtZkpydUQ1?=
 =?utf-8?B?dURhMERQUHJhM2VpUVlrNVl4OWtMOHNnQSt2NUpPQkN2T1pUWm1nK1RmbzF3?=
 =?utf-8?B?MTVTUWtHVHg3WkFENUMvUEhPV2thQ1ZBWFBqYnUxWk9HNG5Pdm85aW96U1g1?=
 =?utf-8?B?T2pBVEtKcXZaVFRYMWp5Qk5lZFBZblpPRUVEMVRoQlVjN3dMbFRoWEljUUtK?=
 =?utf-8?B?TmxLVGkwZVkybU5QRHhRR3pDUmlhaFlTNEhuNUVzQWM3dW4yNlRRZzhUTFF0?=
 =?utf-8?B?dXZiaXg4NUYyUW90dTFEUlBpSGg5dGtoZ2tUem4veTE0RVVkbkE3MWx5Unl1?=
 =?utf-8?B?SUI0MDJTak1hR1ZqKzU2RmpBeFhjR09XZDJWZlBMV3dXVzlsb0xUYVdjbkg0?=
 =?utf-8?B?dWhxbjdKMmpQR2hUaXZMejB3U0szS3AreklOKzZ6RmtQQzlyVnBKSFpjY056?=
 =?utf-8?B?NVR3TmUxU0h2c24zaGhNc0JRUGZ4a1gwREd6SFJVUmxSeEtzTHJORGw4S1JN?=
 =?utf-8?B?WEs4VlpDbyt2N2FRYmJWYlBGbzFaMHdMa1I5UlY3YTRFMEQ1NCtKMXBEZTFB?=
 =?utf-8?B?aERXTVJuekxnZERmWXdLSVZXYWszbUVrMGlUNUlJQ1lXSXAyY0NLL1hHT25w?=
 =?utf-8?B?Nm9ISEdWcjY0enAxOWRON1ZQOU9xUVdtM3pjYVU5clpleHIzYzJRTW9NaTZU?=
 =?utf-8?B?YkM5WGxBNktPSHZBVzVCY2gveUhucTVKVXZ0OXg2U1FhQ1c3bFI5WjhhM0lF?=
 =?utf-8?B?eGlmZHFzYTNmcXdXdzFDdTIwSlV0SkhtSHV4Z2VjVHV3NHBkK2RsM2NFSEkw?=
 =?utf-8?B?TnBYK1M2OXErVXEwYnpPVUFoT3d4aG85UkhxV1NVV2ZLUFA1a2pQSmFoTGZW?=
 =?utf-8?B?VTFvWFZvL1Nhc3lFQmRpWHRsNVBpL2JraDF4WkVyV2tQd1BOYU94RmpkL1A4?=
 =?utf-8?B?bGtteWVySnFpOC9oL3BBR09QOWg5S2NlT0tHb3BMckQvTTRpS2p6dHVXbWdO?=
 =?utf-8?B?bi9kdnBHWXpVUnlveTVPdWhDVmEyK2htYUpTQTI5NDJaWXJBUDhVT3JScGVs?=
 =?utf-8?B?N1FYN2RkaDBOclc0Y0VDYnArREJaUUZuMncxRVVxWE9rV3BRcFE0Y3NGOG5w?=
 =?utf-8?B?SkdQM2FCZjd0VFU0SThvbnByZlpiUTN6bDdKYTVQdFNlVlFlbW8zS3hXMzdt?=
 =?utf-8?B?UkJGWE5Na0NQV0MxbmlScW5VQVFKMVdKMERSMW80Wnl2ZnVSZW5KVko5KzZO?=
 =?utf-8?B?UWcxQms5RXFnWWdOUFlJTHBGRHRLK0xNbTQ5OG1JWVV0bnRkb1ZOemlUVkYx?=
 =?utf-8?B?Q1A0Rjh5V0NvaEx0RDJTMmZuNjY4Q2M5Y1l2Q3UzUEpmb0xXNTRNbHNpL3Fr?=
 =?utf-8?B?YzVrdFZwZWFQdGJLemlXeHR3ckxZc29ZSElQM0RrbWVUTHh0cFFpbUhyTDQr?=
 =?utf-8?B?dzM3aHg3UU9ZQ1cyZE96WDY0cDVnWXBMeEFNV281Y0RWQkUwSWRTU3lxRlpB?=
 =?utf-8?B?SVd3RkpqQ1JCRFQ2TnRaREh5a3huODE1T0NPVENZWXFFb3g5YTluUGV6VThM?=
 =?utf-8?B?WS9rSDR0djY1WWFQTFJZMHQrMDZxRDRHZU82UnhqVlMrRjY1SjFnSnRnbzFp?=
 =?utf-8?B?ejhUUVJqUGp4UzhHZTNOT2EwaDNXcEpJdThxTnl3R1lxQXBhMzlkWk1xRE5O?=
 =?utf-8?B?TThYdS9CMHRXMVY3Q3NONzZzakpMaWV5TTArb0tNem8wa1hjZjlvN0Vodi9C?=
 =?utf-8?B?c0kxWGVUNFhnczB5TDBjdWtYdGpaWm4yRWRtdGpxb2dkWXloV0o4aWYrQUdL?=
 =?utf-8?B?Zi9WcEt6SHdob1c4cTRXSmxSS1dpMklUajdjOGVEQWZwT2ZlSm9lUXQwQ0cx?=
 =?utf-8?Q?EXy+RMCdQ6gJ69EDWYnGAoc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3929.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc9716-9c40-4f35-4cc7-08d9a8797b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 20:49:56.1475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbpQMHcf+Thk6TJly7LcaWN55mGsT7aRaXA8iAsRdkAxCm4oCJMunUe2vcDNfh4rEF6GyifwdFYKD/mztW+u1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
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
 Bokun" <Bokun.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQWxleCwNCg0KSSBhbSBwb3J0aW5nIHRoZSBw
YXRjaGVzIChodHRwOi8vZ2Vycml0LWdpdC5hbWQuY29tL2MvYnJhaG1hL2VjL2xpbnV4LysvMzk2
OTk3IGFuZCBodHRwOi8vZ2Vycml0LWdpdC5hbWQuY29tL2MvYnJhaG1hL2VjL2xpbnV4LysvNTI4
NzQ1KSB0byBwcm92aWRlIHRoZSBuZWNlc3NhcnkgU01VIHV0aWxzIChiYXNpYyBhbmQgc3lzdGVt
X3N0YXR1cykgc3VwcG9ydCBpbiB0aGlzIGJyYW5jaC4NCg0KVGhhbmtzDQpTdXJiaGkNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0KU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxMiwgMjAyMSAyOjQxIFBNDQpUbzog
S2FrYXJ5YSwgU3VyYmhpIDxTdXJiaGkuS2FrYXJ5YUBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlz
dCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBaaGFuZywgQm9rdW4gPEJva3VuLlpo
YW5nQGFtZC5jb20+OyBDaGFuZywgSGFpSnVuIDxIYWlKdW4uQ2hhbmdAYW1kLmNvbT47IExpdSwg
TW9uayA8TW9uay5MaXVAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IEFkZCBzeXNm
cyBpbnRlcmZhY2UgZm9yIHJldHJpZXZpbmcgZ3B1IG1ldHJpY3MoVjIpDQoNCk9uIEZyaSwgTm92
IDEyLCAyMDIxIGF0IDEyOjQ2IFBNIFN1cmJoaSBLYWthcnlhIDxzdXJiaGkua2FrYXJ5YUBhbWQu
Y29tPiB3cm90ZToNCj4NCj4gQSBuZXcgaW50ZXJmYWNlIGZvciBVTUQgdG8gcmV0cmlldmUgZ3B1
IG1ldHJpY3MgZGF0YS4gVGhpcyBwYXRjaCBpcw0KPiBiYXNlZCBvbiBhbiBleGlzdGluZyBwYXRj
aCBJZjdmMzUyMzkxNTUwNWMwZWNlMGE1NmRmZDQ3NmQyYjg0NzM0NDBkNC4NCj4NCg0KSXQncyBu
b3QgY2xlYXIgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBkbyBoZXJlLg0KDQo+IFNpZ25lZC1vZmYt
Ynk6IFN1cmJoaSBLYWthcnlhIDxTdXJiaGkuS2FrYXJ5YUBhbWQuY29tPg0KPiBDaGFuZ2UtSWQ6
IEk3MDExMTBkNzhhODVjMDkyZjVkZGExNjdhNTIzNTBjYzZkZGE3NTU3DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyAgICAgICAgICAgICAgICAgICAgIHwgIDYg
KysrKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmggICAgICAg
ICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVf
c211LmMgICAgICAgICAgICAgIHwgIDQgKy0tLQ0KPiAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jICAgIHwgMTAgKysrKysrKysrKw0KPiAgNCBmaWxl
cyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gaW5kZXggMDFjY2EwOGE3NzRmLi5kNjA0MjZkYWRk
YWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBAQCAtMTgwMCw4ICsx
ODAwLDEyIEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9nZXRfZ3B1X21ldHJpY3Moc3RydWN0IGRl
dmljZSAqZGV2LA0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICB9DQo+
DQo+IC0gICAgICAgaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+Z2V0X2dwdV9tZXRyaWNz
KQ0KPiArICAgICAgIGRvd25fcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsNCj4gKyAgICAgICBpZiAo
aXNfc3VwcG9ydF9zd19zbXUoYWRldikpDQo+ICsgICAgICAgICAgICAgICBzaXplID0gc211X3N5
c19nZXRfZ3B1X21ldHJpY3MoJmFkZXYtPnNtdSwgJmdwdV9tZXRyaWNzKTsNCj4gKyAgICAgICBl
bHNlIGlmIChhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPmdldF9ncHVfbWV0cmljcykNCj4gICAg
ICAgICAgICAgICAgIHNpemUgPSBhbWRncHVfZHBtX2dldF9ncHVfbWV0cmljcyhhZGV2LCAmZ3B1
X21ldHJpY3MpOw0KPiArICAgICAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7DQo+DQoNCldo
eSBhcmUgeW91IGNoYW5naW5nIHRoaXMgY29kZT8NCmFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+
Z2V0X2dwdV9tZXRyaWNzIGFscmVhZHkgcG9pbnRzIHRvDQpzbXVfc3lzX2dldF9ncHVfbWV0cmlj
cygpLiAgQWxzbyB3aHkgZG8geW91IG5lZWQgdG8gYWRkIHRoZSBzZW1hcGhvcmUgbG9ja2luZz8N
Cg0KPiAgICAgICAgIGlmIChzaXplIDw9IDApDQo+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0KPiBpbmRleCAzNTU3
ZjRlN2ZjMzAuLjVmZmU3ZTNiZjFhYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5j
L2FtZGdwdV9zbXUuaA0KPiBAQCAtMTM5Nyw2ICsxMzk3LDYgQEAgaW50IHNtdV9zZXRfbGlnaHRf
c2JyKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiBib29sIGVuYWJsZSk7DQo+DQo+ICBpbnQg
c211X3dhaXRfZm9yX2V2ZW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBlbnVtIHNtdV9l
dmVudF90eXBlIGV2ZW50LA0KPiAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGV2ZW50
X2FyZyk7DQo+IC0NCj4gK3NzaXplX3Qgc211X3N5c19nZXRfZ3B1X21ldHJpY3Moc3RydWN0IHNt
dV9jb250ZXh0ICpzbXUsIHZvaWQNCj4gKyoqdGFibGUpOw0KPiAgI2VuZGlmDQo+ICAjZW5kaWYN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gaW5kZXgg
YjA2YzU5ZGNjMWI0Li5lYzgxYWJlMzg1ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+IEBAIC0zMDA1LDkgKzMwMDUsOCBAQCBzdGF0aWMgaW50
IHNtdV9nZXRfZHBtX2Nsb2NrX3RhYmxlKHZvaWQgKmhhbmRsZSwNCj4gICAgICAgICByZXR1cm4g
cmV0Ow0KPiAgfQ0KPg0KPiAtc3RhdGljIHNzaXplX3Qgc211X3N5c19nZXRfZ3B1X21ldHJpY3Mo
dm9pZCAqaGFuZGxlLCB2b2lkICoqdGFibGUpDQo+ICtzc2l6ZV90IHNtdV9zeXNfZ2V0X2dwdV9t
ZXRyaWNzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCB2b2lkDQo+ICsqKnRhYmxlKQ0KPiAgew0K
PiAtICAgICAgIHN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gaGFuZGxlOw0KPiAgICAgICAgIHNz
aXplX3Qgc2l6ZTsNCj4NCj4gICAgICAgICBpZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5h
ZGV2LT5wbS5kcG1fZW5hYmxlZCkgQEAgLTMxMzUsNw0KPiArMzEzNCw2IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgYW1kX3BtX2Z1bmNzIHN3c211X3BtX2Z1bmNzID0gew0KPiAgICAgICAgIC5hc2lj
X3Jlc2V0X21vZGVfMiAgICAgICAgICAgICAgICA9IHNtdV9tb2RlMl9yZXNldCwNCj4gICAgICAg
ICAuc2V0X2RmX2NzdGF0ZSAgICAgICAgICAgICAgICAgICAgPSBzbXVfc2V0X2RmX2NzdGF0ZSwN
Cj4gICAgICAgICAuc2V0X3hnbWlfcHN0YXRlICAgICAgICAgICAgICAgICAgPSBzbXVfc2V0X3hn
bWlfcHN0YXRlLA0KPiAtICAgICAgIC5nZXRfZ3B1X21ldHJpY3MgICAgICAgICAgICAgICAgICA9
IHNtdV9zeXNfZ2V0X2dwdV9tZXRyaWNzLA0KDQpXaHkgYXJlIHlvdSByZW1vdmluZyB0aGlzPw0K
DQo+ICAgICAgICAgLnNldF93YXRlcm1hcmtzX2Zvcl9jbG9ja19yYW5nZXMgICAgID0gc211X3Nl
dF93YXRlcm1hcmtzX2Zvcl9jbG9ja19yYW5nZXMsDQo+ICAgICAgICAgLmRpc3BsYXlfZGlzYWJs
ZV9tZW1vcnlfY2xvY2tfc3dpdGNoID0gc211X2Rpc3BsYXlfZGlzYWJsZV9tZW1vcnlfY2xvY2tf
c3dpdGNoLA0KPiAgICAgICAgIC5nZXRfbWF4X3N1c3RhaW5hYmxlX2Nsb2Nrc19ieV9kYyAgICA9
IHNtdV9nZXRfbWF4X3N1c3RhaW5hYmxlX2Nsb2Nrc19ieV9kYywNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5j
DQo+IGluZGV4IDNiMWJmMjcwZWJjNi4uOTdkMThlNzY0NjY1IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0
LmMNCj4gQEAgLTM2MTksNiArMzYxOSwxNiBAQCBzdGF0aWMgc3NpemVfdCBzaWVubmFfY2ljaGxp
ZF9nZXRfZ3B1X21ldHJpY3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgICAgZ3B1
X21ldHJpY3MtPmVuZXJneV9hY2N1bXVsYXRvciA9DQo+ICAgICAgICAgICAgICAgICB1c2VfbWV0
cmljc192MiA/IG1ldHJpY3NfdjItPkVuZXJneUFjY3VtdWxhdG9yIDoNCj4gbWV0cmljcy0+RW5l
cmd5QWNjdW11bGF0b3I7DQo+DQo+ICsgICAgICAgaWYgKG1ldHJpY3MtPkN1cnJHZnhWb2x0YWdl
T2Zmc2V0KQ0KPiArICAgICAgICAgICAgICAgZ3B1X21ldHJpY3MtPnZvbHRhZ2VfZ2Z4ID0NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgKDE1NTAwMCAtIDYyNSAqIG1ldHJpY3MtPkN1cnJHZnhW
b2x0YWdlT2Zmc2V0KSAvIDEwMDsNCj4gKyAgICAgICBpZiAobWV0cmljcy0+Q3Vyck1lbVZpZE9m
ZnNldCkNCj4gKyAgICAgICAgICAgICAgIGdwdV9tZXRyaWNzLT52b2x0YWdlX21lbSA9DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICgxNTUwMDAgLSA2MjUgKiBtZXRyaWNzLT5DdXJyTWVtVmlk
T2Zmc2V0KSAvIDEwMDsNCj4gKyAgICAgICBpZiAobWV0cmljcy0+Q3VyclNvY1ZvbHRhZ2VPZmZz
ZXQpDQo+ICsgICAgICAgICAgICAgICBncHVfbWV0cmljcy0+dm9sdGFnZV9zb2MgPQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAoMTU1MDAwIC0gNjI1ICogbWV0cmljcy0+Q3VyclNvY1ZvbHRh
Z2VPZmZzZXQpDQo+ICsgLyAxMDA7DQo+ICsNCg0KVGhpcyBjaGFuZ2Ugc2VlbXMgdW5yZWxhdGVk
IHRvIHRoZSBvdGhlciBjaGFuZ2VzIGluIHRoaXMgcGF0Y2guDQoNCkFsZXgNCg0KDQo+ICAgICAg
ICAgYXZlcmFnZV9nZnhfYWN0aXZpdHkgPSB1c2VfbWV0cmljc192MiA/IG1ldHJpY3NfdjItPkF2
ZXJhZ2VHZnhBY3Rpdml0eSA6IG1ldHJpY3MtPkF2ZXJhZ2VHZnhBY3Rpdml0eTsNCj4gICAgICAg
ICBpZiAoYXZlcmFnZV9nZnhfYWN0aXZpdHkgPD0gU01VXzExXzBfN19HRlhfQlVTWV9USFJFU0hP
TEQpDQo+ICAgICAgICAgICAgICAgICBncHVfbWV0cmljcy0+YXZlcmFnZV9nZnhjbGtfZnJlcXVl
bmN5ID0NCj4gLS0NCj4gMi4yNS4xDQo+DQo=
