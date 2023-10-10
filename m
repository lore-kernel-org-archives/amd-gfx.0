Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8ADCD6916
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 09:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E8010E15F;
	Tue, 10 Oct 2023 09:34:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA5610E15F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 09:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNp3Sm8km4n1Qyf34uj6jskN7z75cwxC3SuZvHHSxI8HA8vHK6irGjN8dObmhwNOTY38Z5kpyFpNuG4KTIAaIIlGR5f7ElD+DQf7wTBsRxfckvcjf+kMXacZ70rDG1E59xSB23pb8Qe0736ko9GphC86rjd7JchhrGq7+AtItJlvdcJ8Awz0owFDbWsP7gN9P6pilamxEMEvcpSiE5/IcJyvnuJvlyHEWJa6sXy30u4F2ZABEhqGEceaZrtrZoxy14a0+nVwq935CFltBCO7UN+gnH/ienVoNLbAIw5OR2a+j1GA0RMmRFQq9mtG/4m9Bmrb8dqF8rrLKcdIzHS75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x2tNxxR0O/w5QYcsux2s+Wt4DRmMrrtIgS5uD3L4Xs=;
 b=AwGcpFJ8jdc5VHCZzTOUCV41cBQay38aPaZWXWu1DhWuDF4m1o/meW16ZbwuRrMVvfucOYVxmSi8qvRJMfQwnru31S52xgJ/ykSDe8hDYFYcw2imAb+X8d/5lSdQhbdbIP11dM4t8fsz9fQh83kU7EQLIf6wJQdTH8il+cknx9u4gRLlLo2D5smPTtMB+0/I2kAuPgEWXnQQ423naiv3Y7zrhaU5k5OPSRCOmz/Oxlj3+heB0Xy7v59+Pl1dfELsSyfEXRMKJzvUjzwM7xrpPIX/uWBAXNX9UWbSz+GaZlpWBTkIUdsk33iw+mk5KeA2UNVQKnNcnuwZxIU+u4se5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x2tNxxR0O/w5QYcsux2s+Wt4DRmMrrtIgS5uD3L4Xs=;
 b=hsHRwt4rPlyGIF0hzSNvEdz0evbUJREwcjajW4ynKFOpxvRXGpTtKEfeXNoWEE1mqvlp7ptPZBaZ2euD9IZUTJJ25Cky38w1VpwMCij28mxVskAAM49pUEDWfOjLIgi8rwgC3ew+EuvCkXEl6H9OGRL5wlgz1DOZdqrR3xqjhuw=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Tue, 10 Oct
 2023 09:34:16 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:34:16 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8qZ0SmqTbiB0uJBjZ5G/CDQ7A/5QOAgADKnbCAAHhagIABhvew
Date: Tue, 10 Oct 2023 09:34:16 +0000
Message-ID: <CH2PR12MB41525E613C802F38013C96A1FECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
 <10a568bd-e514-4ce1-b3d5-3c7534a8f3e7@gmail.com>
In-Reply-To: <10a568bd-e514-4ce1-b3d5-3c7534a8f3e7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae2e522e-c1b0-4e23-b578-7c8d202fd1ae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T08:10:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|PH8PR12MB6987:EE_
x-ms-office365-filtering-correlation-id: 75c5633f-8bea-4a48-a937-08dbc9741275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvlW6GW3bh/ZOnVVge57nLSBmdbSgZlapk1kGktUyPy9N3tj6mPoydzMv4FIRpZ6q5z70PN7I/YXxfTdbRnFpw2fWDsKOOVAZAj0Sq48HWgNjqtVRtEYKDg3EPGzr3rdHvBc63f/EqrXiX6Ng5VTVhEWKcvi6twJFh/hcI6H0ABzQwjUk9C+BN1k5KwzislD/rIoSsxXER2Nv+rxkreIMpd4WYxddbS53YLuz1v25Z8PtN614v7ijnppxpQxv+a7QnbhZv0pY6awl4z83bq0BnsxD7pgO11XEUd90WIp5Kw8hWcMD4dNMdBMk4CvwNntG3QfGpvPgaBQx72g7rnYjcy1aiQ7oaLt+BToHzRFn7wTeKFHKjo23xI0uCZCC0BFc82WRJaMHK8Wb387F7jO6XM85AgtYKf8iwNVmQabZghki78OEQoYIMoPTC5wAeaP+02CWG5nJbGyBQLil4rtnLxPDx4SQMe59yhFHxjs9K1GW4ZOSQ3h5dce3Nq/kpkNLR0jjaH8GN0pREZ203EHScht1Xu/P22HH0j/gp31qrABirLTciLsesthxySUwU22OQCjB397EOGWtCDpW9yENMVjPq7YUkC8XonNDBsj1y1dbhB/Se+1qOeTW3erwQij
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(86362001)(38100700002)(33656002)(38070700005)(55016003)(6506007)(478600001)(52536014)(2906002)(9686003)(53546011)(41300700001)(4326008)(8676002)(8936002)(5660300002)(71200400001)(7696005)(83380400001)(66476007)(66556008)(64756008)(66446008)(110136005)(316002)(76116006)(66946007)(66574015)(26005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1BiRURTZVpwTVAwQlJiSDV2S00vUmxkeFV0dndsUS82dmF2L09oWWcvd3lJ?=
 =?utf-8?B?ZnhxbWl6K0VUYXBEMW1JN29ReHZEV3RseWgwYzlyVjFBamp5TjlGRk5hQUgy?=
 =?utf-8?B?T0pXWFNXVzdVdkZCZkMvM1BiY0hFWFFwenFzUUlUNGR4VGxHL0FBMForUVk2?=
 =?utf-8?B?djJOV3dZYmN1SGRuc0E2c21zcVdaMUlReEN2cFI2L0RIZ0pzRmdqMGZHbEFa?=
 =?utf-8?B?cTVLUXIvT1pWQ3o2cGE1QnR2eDNpZUtrQmpsazc1V202WC9DcnBHUmsyUEYy?=
 =?utf-8?B?RWdKaEJQZ3p6T2ZWLzYzcWtyYkE4YmF6M0F5Z3o1VkZsNUFGMnBEeGNDTkli?=
 =?utf-8?B?RFpIRnBqOHYvWk1pWnhOanJMeEI1dVVMMnQvRnR2c3dkcm42VXhjTU9WLzZr?=
 =?utf-8?B?MW5RTHRzUEhYQmIxWnFpRmowZlpXOXhkNjM3L1BIbVJLRHFxNkF1bEZXazM1?=
 =?utf-8?B?WS9pcEg0MklocTJVQ1RTa2pkaUtkc2RsbVg4ZG4zVG56bWtEQ1FXWng1Yjgw?=
 =?utf-8?B?Z09oWm13MUNJNHVjVkgvc2pwcUUvWHNNc0YreTlxREhvbEZvNndjZVArZlF3?=
 =?utf-8?B?VGZaSGJBcXBRYm5ROGdobTMxcjNraWNQUjAwcFcrcXVteWJNODlvcFJsUCtB?=
 =?utf-8?B?bE5XUXFha2pwQzY4eTdFZ1JtWUVhL25pYVdEdlVrRVIwRG9EdzFTaTdpSEI5?=
 =?utf-8?B?bW9VbldwQWFKRWFMOTgycmlHZHhqbWRtaGhtTGZ5WVhKR3BCRVFzOExjQ1hz?=
 =?utf-8?B?dlZKTVk2disyZUx1UVNIdTNFUnZieStNQXoySGwzUzU2OHAwMXZTOGhvYjRw?=
 =?utf-8?B?enZWVzBZMTZSeWUzZW84NnNsY2FRMDd1a0hzb3JpMHl2cW9jU2toclpKVjJ3?=
 =?utf-8?B?b1lWUk9Ib3dlb1NqSk02b0NYVkxwT3ZzSWZMZWM0V3UwVEE4b0x5M0c4QmNZ?=
 =?utf-8?B?WFlXaklKREZoYjIwUDdlK2R1aGkxcFg5MFZHTFZWVlkzVU9GeEZxZm8rU05Y?=
 =?utf-8?B?L0lhYVFwdTdIZEZ3VWhrZlBVV0FyS1BodnpGSUVRckJubnZXMGtCNGJJdWtH?=
 =?utf-8?B?dTBqVlBzWmJFNXY3ZTc3K1NlVmJrdDBKVFBwT1BBb1ZMbk90L2pGZk1EdENT?=
 =?utf-8?B?QjlaRDArODdoaVFEZTNWTndUZ0VPL3RKMzVrTWdJaEpmSnFPaGFFcGlrbm9K?=
 =?utf-8?B?MVc4UUY5UHFUaGM5SmNrVXJETGtnb1V4cGhSNmlid2h1dDhZNlRtVEhWSDRr?=
 =?utf-8?B?V3QydWJaSzRZU2UvN0J2YTN6UCt4YkpHRi9SN0lNSUV1dmFydU4zWmxoSVhS?=
 =?utf-8?B?bVVaQUFvZmkzL3BFUXVTR2UxcWpuSTNOVHZkekhnaDVGWk55UzU4ZjRLVyt6?=
 =?utf-8?B?aFliUHl5SlRma2s5czh1R3dLejZiYkJGUVhKWXdpSkJ5dlVSemoxdTlRWktp?=
 =?utf-8?B?eEJ3U0RESGxnRXpuQVoyaE5seVU3eTdSTjFldlJUSHVoNWNCY3hIOGNJbnE0?=
 =?utf-8?B?Nko2VnlwbnE2S21FVDA5TFM2ZEdXeC8zSjFwQzVlazhBamRnOEo0Tkd2SUlO?=
 =?utf-8?B?QkFnSW8vWm9Mc3loVXFQcnFyQUNmNUx4YjVLQ2ZOSmpZVEJjU0QzNUFsN0hi?=
 =?utf-8?B?RGlFNVdIbVJGNDRZb3dLVlM5azlNOWgyZTJpVmRJWGVVY3RmaDNISHpZRUxo?=
 =?utf-8?B?dXVuWTFEV2FnMGVTZGtsWFljbnlYUUJhbHVjRlJMQWJYblpVdjFTUmhaYi9y?=
 =?utf-8?B?YU1UeGdUbXMxN1lYQ3pxYjlXOC9IcEl1WVcweTh2Ri92SjROYU5YRFgybDFo?=
 =?utf-8?B?NklwSFNLOFd3aWFRNzBQYlNYNUJ5KzZMclZXdnFRWmJZQXQyVndnOERxT2kv?=
 =?utf-8?B?ZUpNZDVwVlB0ckxpUzRLUkMzbVh3YjQ2M3pCNGVkaWFvaVZpVW1QNFZNaDc5?=
 =?utf-8?B?YUlEM01uS0kyZGJmV3lLdE5ackNUMzhqbTN3aEpmV1llTk94enRiN25OVGcv?=
 =?utf-8?B?T3owRHRNL09VSUtMa3FVb2orOVF2cUIrVTZOdkhnYThod1Y2enRQSnl5bHZR?=
 =?utf-8?B?dW9wbGRPVGRSQVExWTF0RFZ2MS9CWTlGVVNsOGJZMjUzZnRCMTNnVXlpVkpG?=
 =?utf-8?Q?zsJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c5633f-8bea-4a48-a937-08dbc9741275
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:34:16.5551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NlzhYh4irRb8qPt+Ra3tcfkN3BVPm4PlwRjM1g8tGUYxYpfmBSN/PY3b0wpk3ii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4+IFRoZW4gYSBUTEIgZmx1c2gg
c2hvdWxkbid0IGJlIG5lY2Vzc2FyeSBvbiByZXNldC4gQSByZXNldCBpbXBsaWVzIHRoYXQgdGhl
IFRMQiBpcyBjbGVhcmVkIGFzIHdlbGwuDQpIbW0sIGluIGN1cnJlbnQgaW1wbGVtZW50YXRpb24s
IHdoZW4gd2Ugc2F5IGEgcmVzZXQgaW1wbGllZCB0aGF0IHRoZSBUTEIgaXMgY2xlYXJlZCwgYXNz
dW1lIHRoYXQgdGhlIFRMQiBjbGVhciBpcyBwdXJlbHkgaGFyZHdhcmUgYWN0aW9uLiBUaGVyZSdz
IG5vIGdwdSB0bGIgZmx1c2ggaW5pdGlhdGVkIGJ5IHNvZnR3YXJlL2RyaXZlciBhZnRlciBzdXNw
ZW5kLg0KDQpXaGlsZSBpbiBzb21lIGFzaWNzIG9mIGdmeDExIChsaWtlIG52MzEpLCBncHUgdGxi
IG5lZWQgdG8gYmUgZmx1c2hlZCBieSBzb2Z0d2FyZS9kcml2ZXIgYWZ0ZXIgc211IHJlc3VtZSBz
dWNjZXNzZnVsbHkgaW50ZW50aW9uYWxseS4NCldpdGhvdXQgdGhlIGdwdSB0bGIgZmx1c2ggb24g
bnYzMSwgUzMgb3IgcmVzZXQgd2lsbCBiZSBicmVhayB3aXRoIGdmeCBwYWdlIGZhdWx0Lg0KDQo+
PiBGaXJzdCBvZiBhbGwgdGhlIHBhdGNoIGlzIGJyb2tlbiBiZWNhdXNlIHlvdSBvbmx5IGhhbmRs
ZSB0aGUgbG9ja2luZywgYnV0IG5vdCB0aGUgdW5sb2NraW5nIHBhcnQuDQpGb3IgdGhlIHVubG9j
a2luZyBwYXJ0LCByZWFsaXplZCB0aGF0IHlvdSBhbmQgS2V2aW4gYXJlIGNvcnJlY3QuIEkgc2hv
dWxkIHB1dCB0aGUgdHJ5bG9jayBjaGVja2luZyBvbiB0aGUgcmlnaHQgb2YgJiYgdG8gbWFrZSBz
dXJlIGl0IHdpbGwgYmUgY2hlY2tlZCBmaXJzdGx5LiBPdGhlcndpc2UgbG9jay91bmxvY2sgbm90
IHBhcmllZC4NCg0KVGhhbmtzLA0KRmVpZmVpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT4NClNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIzIDQ6NTIgUE0NClRvOiBYdSwgRmVpZmVp
IDxGZWlmZWkuWHVAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0Bh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6Q2hlY2sgZ2Z4
IHBvd2Vyb24gd2hlbiBza2lwIGZsdXNoX2dwdV90bGINCg0KQW0gMDkuMTAuMjMgdW0gMDM6NTAg
c2NocmllYiBYdSwgRmVpZmVpOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0N
Cj4NCj4gSGksDQo+DQo+Pj4gQmFzZWQgb24geW91ciBkZXNjcmlwdGlvbiwgdGhlIGFib3ZlIGNv
ZGUgc2hvdWxkIHVzZSAifHwiIGluc3RlYWQgb2YNCj4+PiAiJiYiLA0KPiAmJiBpcyB0byBhZGQg
bW9yZSByZXN0cmljdGlvbiBoZXJlLiAgVG8gYXZvaWQgc2tpcHBpbmcgbmVjZXNzYXJ5IFRMQiBm
bHVzaCBieSByZXR1cm4uDQo+IEZvciBBc2ljcyA8IEdGWDExLCAhYWRldi0+Z2Z4LmlzX3Bvd2Vy
b24gaXMgYWx3YXlzIHRydWUgKHRoaXMNCj4gcGFyZW1ldGVyIGlzIGludHJ1ZG9jZWQgZnJvbSBH
RlgxMSksIG9ubHkgZGVwZW5kcyBvbiByZXNldF9kb21haW4tPnNlbTsgRm9yIEFzaWNzID0gR0ZY
MTEsICFhZGV2LT5nZnguaXNfcG93ZXJvbiBtaWdodCBiZSBmYWxzZSAod2hpY2ggZ2Z4IG1pZ2h0
IGFscmVhZHkgcG93ZXJvbiBpbiB0aGUgcmVzZXQpLCB0aGlzIHdpbGwgbWFrZSB0aGUgaWYgKCkg
bm90IHR1cmUsIHJldHVybiB3aWxsIG5vdCBiZSBleGVjdXRlZCwgdGh1cyBmbHVzaCBUTEIuDQoN
CkZpcnN0IG9mIGFsbCB0aGUgcGF0Y2ggaXMgYnJva2VuIGJlY2F1c2UgeW91IG9ubHkgaGFuZGxl
IHRoZSBsb2NraW5nLCBidXQgbm90IHRoZSB1bmxvY2tpbmcgcGFydC4NCg0KVGhlbiBhIFRMQiBm
bHVzaCBzaG91bGRuJ3QgYmUgbmVjZXNzYXJ5IG9uIHJlc2V0LiBBIHJlc2V0IGltcGxpZXMgdGhh
dCB0aGUgVExCIGlzIGNsZWFyZWQgYXMgd2VsbC4NCg0KV2UgZGlzY3Vzc2VkIHRoZSBwb3NzaWJp
bGl0eSB0byBhdm9pZCB0aGF0LCBidXQgdGhpcyBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgaGFwcGVu
aW5nIGF0IHRoZSBtb21lbnQuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4+PiBBbmQg
YWZ0ZXIgbWVyZ2luZyBjb2RlIGludG8gb25lIGxpbmUgbWF5IHJlc3VsdCBpbiB0aGUgbG9jayBu
b3QgYmVpbmcgcmVsZWFzZWQgaWYgdGhlIGxvY2sgY2FuIGJlIGFjcXVpcmVkIHN1Y2Nlc3MuDQo+
IElmICFhZGV2LT5nZnguaXNfcG93ZXJvbiBpcyB0cnVlLCB0aGUgcmVzZXRfZG9taW4tPnNlbSB3
aWxsIG5vdCBiZSBkb3duX3JlYWRfdHJ5bG9jaywgdGh1cyBjb3VsZCBhdm9pZCB0aGlzIGRlYWRs
b2NrLg0KDQo+DQo+IFRoYW5rcywNCj4gRmVpZmVpDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29t
Pg0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgOCwgMjAyMyA5OjM2IFBNDQo+IFRvOiBYdSwgRmVp
ZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5Y
dUBhbWQuY29tPjsNCj4gS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT47IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6Q2hlY2sgZ2Z4IHBvd2Vyb24gd2hlbiBza2lwDQo+IGZs
dXNoX2dwdV90bGINCj4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mDQo+IEZlaWZlaSBYdQ0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgOCwgMjAyMyA2OjA3IFBN
DQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWHUsIEZlaWZlaSA8
RmVpZmVpLlh1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47DQo+IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaGFuZywgSGF3a2lu
Zw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6Q2hlY2sgZ2Z4IHBvd2Vyb24gd2hlbiBza2lwIGZsdXNoX2dwdV90bGINCj4NCj4gVG8gZml4
IHRoZSBncHUgcmVjb3ZlcnkgZmFpbGVkIG9uIEdGWDExIHdpdGggZ2Z4aHViIHBhZ2VmYXVsdCwg
Zmx1c2ggZ3B1IHRsYiBhZnRlciByZXNldCBvbiBHRlgxMS4NCj4gR2Z4aHViIHRsYiBmbHVzaCBu
ZWVkIGNoZWNrIGlmIGFkZXYtPmdmeC5pc19wb3dlcm9uIHNldC4NCj4NCj4gRml4ZXM6IGQwYzg2
MGYzMzU1MyAoImRybS9hbWRncHU6IHJld29yayBsb2NrIGhhbmRsaW5nIGZvciBmbHVzaF90bGIN
Cj4gdjIiKQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgfCAz
ICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBpbmRleCAy
ZjliYjg2ZWRkNzEuLjA0OGQzMmVkZWU4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYw0KPiBAQCAtNjExLDggKzYxMSw5IEBAIHZvaWQgYW1kZ3B1X2dtY19m
bHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLA0K
PiAgICAgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAgICAgICogQSBHUFUgcmVzZXQg
c2hvdWxkIGZsdXNoIGFsbCBUTEJzIGFueXdheSwgc28gbm8gbmVlZCB0byBkbw0KPiAgICAgICAg
ICAgICAgICAgICAqIHRoaXMgd2hpbGUgb25lIGlzIG9uZ29pbmcuDQo+ICsgICAgICAgICAgICAg
ICAgKiBGb3IgR0ZYMTEsIGdmeGh1YiBmbHVzaCBjaGVjayBpZiBhZGV2LT5nZnguaXNfcG93ZXJv
biBpcyBzZXQuDQo+ICAgICAgICAgICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgICBpZiAo
IWRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkpDQo+ICsgICAgICAg
ICAgICAgICBpZiAoIWRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkg
JiYNCj4gKyFhZGV2LT5nZnguaXNfcG93ZXJvbikNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybjsNCj4NCj4gW0tldmluXToNCj4gQmFzZWQgb24geW91ciBkZXNjcmlwdGlvbiwgdGhl
IGFib3ZlIGNvZGUgc2hvdWxkIHVzZSAifHwiIGluc3RlYWQgb2YNCj4gIiYmIiwgQW5kIGFmdGVy
IG1lcmdpbmcgY29kZSBpbnRvIG9uZSBsaW5lIG1heSByZXN1bHQgaW4gdGhlIGxvY2sgbm90IGJl
aW5nIHJlbGVhc2VkIGlmIHRoZSBsb2NrIGNhbiBiZSBhY3F1aXJlZCBzdWNjZXNzLg0KPg0KPiBC
ZXN0IFJlZ2FyZHMsDQo+IEtldmluDQo+DQo+ICAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdt
Yy5mbHVzaF90bGJfbmVlZHNfZXh0cmFfdHlwZV8yKQ0KPiAtLQ0KPiAyLjM0LjENCj4NCg0K
