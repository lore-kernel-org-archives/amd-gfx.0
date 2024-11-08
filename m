Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB170D5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 10:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D03610E070;
	Fri,  8 Nov 2024 10:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txO6kfKk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB8710E070
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 10:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLRMOzFx4UwMAdWG1omLtIzEvtoPg5Gi9SSVKw7DRe23c6dDl0RBTavgrDwpJHqESVSa6Dgh1h82zkvL801EYPolsBKwbSW9vhZKYb7EW7t12Y1DxQRgGzdAJZ2P5x0mbomnFxauSpDevxGHPMlxV4Rgj7wQwKhvysTaLG3zCKHSl0SxewNnTkhM3f6e0mGsY7iDMjqngiBfFlcrQyS39vpwodlJ+4+WoybeMHd/ax3REKN9LAR+WA1PdgnBBkv9kA9OtblNtHGu/4cERUmHnkgoqw1QmWuwpFDBLXIAjgR2WuVuGlxWf88T/0zNWqE1+yUjQeedOkXKbuB2jEjtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7q5ouAceNriQd3+6INdy8QcxKhYkPK/gNwNtKUZU5k=;
 b=QkJwhhmTKVu4vOqwdmIIcEBTqXGlTweishzJq7IwxVVdvLXf5X/UWJneIhyQyZ6rePtOTJKTW8K/J1CHD9sCgNYPKDT2P0FojnGGQC7l8tURG8uwhEQpHvtbBUZ43ROQN10yfkX2bohG9ybcytsTv5vywtnSDCGfFNEvX7TpeLhA3eGO6QY27B0P4wWbBeR71VdPF7KtUpBCHECjgLYrYl4NG43BfAaGfk69V7kHzta42OQH07Gi4xN6PgkePtuFZXJfKETprWPb8z8SMdPsS5KyDgdmeSPRBg5UU1cn9gfEGF2bDx301A/1xTr59aBC2Nl3byPMcsq+p+wL29chkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7q5ouAceNriQd3+6INdy8QcxKhYkPK/gNwNtKUZU5k=;
 b=txO6kfKkRAC+EwH3VNE9Hr7n15TX4u8wFgLS7l0PpefMUKyz7qYxvP9QwKNKB+e9gXO+BGT5xj73zEpwiAG2UMyOgCUa2wwQHTdgTt4Dn5r/JLna94YDieDDch2lsCH73k2Wm9SlheBFvc/m1v0OLMbd3Vqb7VvuahIt8DRr+iw=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 10:59:36 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:59:35 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Topic: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Index: AQHbMBZHMXJO9/1Wb0SUcDj9uFrCqbKqXF8AgAD3oQCAAGQwgIABdj0ggAALTuA=
Date: Fri, 8 Nov 2024 10:59:35 +0000
Message-ID: <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daed1875-2cb9-49dd-a7d3-0cee6d48f927;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-08T10:16:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|BY5PR12MB4305:EE_
x-ms-office365-filtering-correlation-id: b80f1d63-65f3-4f19-1648-08dcffe46ed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MzRQbXVlbkREUnNLRkQxb1FyRVhxUFI0aVZIMlpNWEJQY2dYeG5KN3B1OGdy?=
 =?utf-8?B?MG5IZTVIZ2RYakVEc241aTFSM3A1SE12YTQ4L3dYN2xjN2d2eklYVkNTWWo4?=
 =?utf-8?B?MzB4OGFjc09XRktZbE4xVDEzUHgwTGRWMk9DSUtoSDdYSk9oRlExM0hxdkdW?=
 =?utf-8?B?WWV6YysydWs4YVE3bVpsVkdJeHgvZkJiQjhTZjBSMmdMWGtTMXBlZjh0bHRs?=
 =?utf-8?B?ZDJPRlB1bDhtU3FrbENaUU90dFFEVlR0ai9DSDdVTlltRzNHZDdHOFNkczh0?=
 =?utf-8?B?a3JvcWpSQlhQWjd4cHFUaWtFQXFpWW43dkhBZWRMQ1k5TmNTRU5LQWpWU3Zl?=
 =?utf-8?B?VVpXdnR4SDRtbzkyckZkQkhiL0owWTdpOE9LWHAraFAxcGJqUjJiMzV6VXJX?=
 =?utf-8?B?WFZNU2tjL0d1eDM4OXRCa01FWnRNMU5JeGdaR0wydmF6S1hZRXRya081blho?=
 =?utf-8?B?QUF0bmV0cWpYZjM4Z1Q1Wmk4S1ZUekpPSnFMOFUyK2Q3ZDdTM090RFUxZGJs?=
 =?utf-8?B?WmM2aWhrK1hPSEd6bTFmK3RnMTdwaUZQNTEwV2NWTWx5VlVQcHpqM3Nnb1Mz?=
 =?utf-8?B?TktJQ3FHU1hxZDFaRzFYdzJETDY5WnlUTnc1dWtFU0FpV293OThpU1I0YzlW?=
 =?utf-8?B?VlVkVGJiVU0vcmt2ZnFoaVZQYUVpdXFVbDBFWEVWQXpQNXU5Z0NuS2szR2Vi?=
 =?utf-8?B?MWYyRjR5SWowVlBFejkyemVxWjlTbU83ZEY4eWNpODdLV2U1RjRHZk9HZllp?=
 =?utf-8?B?cUU1NDgwSHIyZE5uVGE5Q1V2bVZ2WUhIcm9OVlFrck5HNzlhakpuMWJVaWlr?=
 =?utf-8?B?WUo5SVRnb2dVMkNxck5IdUtkSGF4SXp5QnBucGRXSnZOOFFUdVZHdVJWakp4?=
 =?utf-8?B?ai9mY1BITVdyVGpHSGh4Mk9wVlVGZ2o5ZUt0cG5aTlRkdyt4YkdObk1jYW9C?=
 =?utf-8?B?Q3dubTBBVlV0bWU2SzUxNGJ3TmZ1dFNBRTVKUHd1SGVEVHFCT0FtZTVoQlEr?=
 =?utf-8?B?YklXWjhPMExDK1plckNqQUNscTVCWDdnR3cxUVJZVi9QL2h6MmRnbFlQZTM4?=
 =?utf-8?B?WFVlQ3A5dFh4SC9hUDhmQUkyK2REMXluRnI5U1pmVWlZRWVYbGRKQ2Fpd2Vy?=
 =?utf-8?B?RzluMnZFQkFvc1BBWCswL1R6Zm5vS0xjRE9rWTZRR0Vza2d6Tko4cVR0WDZ4?=
 =?utf-8?B?ZmNoL3IxMVJXeENaY0J4YWd0Vmh6RzJCVENYSW4vSWp4bW5ybmNpdEtlb0hm?=
 =?utf-8?B?SS93cytOeXkwOElkcnpZcmFES1VnQTk1SXRRL05FK2hoUjcxTVlmcDl0dGti?=
 =?utf-8?B?VnMwdmticFJ2U2RFV1BtOWJZcmpLdVJ4V3F6NC9kT0ZHRUU5cUlOQzgwL05B?=
 =?utf-8?B?a2ZhbHFnL2ZwQnAxZzFZb1RuckZVNGRqMXppWjN2a2s1bDRUYmdKU2JYV05Y?=
 =?utf-8?B?cnRjbkw2Y2pvemJiaElKSzBFaWUwRnBRNWh5QlY2S00xalpvdThrN0lKNWhK?=
 =?utf-8?B?Sm1NRzdrc3poN2Z3L1pyZmpKOVg5em90Y2xubmtQeDdzSlpVelEwekY2WldL?=
 =?utf-8?B?SWdqT1lKdnl4TXU4SFdkelpxbi9jUndiRmJZeUNZODJRR1ZzWTU0NGN3QW5N?=
 =?utf-8?B?ZWlGOGFXT3Rnak1EN1dKTC9BVU5STGZNdUpJb0dCYXlPTStKbG9iaUVWVFUv?=
 =?utf-8?B?eldhbCtnRzZvWnhKN0VidzhMSVNpRDdocVAxR2ZPV2R0T3ZMZXQ1WWJkSkZX?=
 =?utf-8?B?eXkvaS9SQUlydDFvbHhqNGxERW45ajFZSE9zbXFqRHFVbVVaY05nUkV1Skxm?=
 =?utf-8?Q?Qv9NeT/EmQPuK2hWxOsGhYEVMbfTWnS763BeM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVBSWEZjZHc3R1Ara25KcG9jSEdJazQyRXNLSlU1c0UrbVRSY0w4bVB2cmwy?=
 =?utf-8?B?YU9rRU5hV0lkS0p6WEhmdS9zdVgxcjVNMXZTMGRGN3Bla0ZDejZtVlFMNERJ?=
 =?utf-8?B?L0dFcCsyZDhtWjRwVlZkUTNPQUJvS2FaNU5xVVl4OFdpeUl5WmdpZjUvT3Q2?=
 =?utf-8?B?eDM2OC9WTHFxaVozZzJ0VTBxNUdzNTJ3UTZvd0FReVhwaWRFakpJWUVYbjZE?=
 =?utf-8?B?eVZRdHBuQkV2Yk5SdnppWVRkVVpRQ0lmaXJtSjZpMTMzVm05ZXJmQ3ZNNHgv?=
 =?utf-8?B?alF1bVJGdzUvNktvN3hiZlNWcndkdjZzNlBaZHRGcm5VRzAxMDJRRWdEelMv?=
 =?utf-8?B?VGNCZFFLRXplRkZIUmVDcThKUldYb0NwVEM1UDAxVjdHOUpQanRxSHdZOUNu?=
 =?utf-8?B?UWQvemdpK1ZWKytlb1hjaXBoNnZsaDJWMUlabEdiNFN0MHlrUGlvWTBmYWU1?=
 =?utf-8?B?WkdIN21wd3QyV0ZWMXptNGxrbSt5cmlINGR0SlpiVHlOKzhRUzRaNCtjV283?=
 =?utf-8?B?azJRaGVqMVM4T2NlSHBacThLeFZpcS9WN3BUWTExUXd4QVZjbzByWnVpY2Vi?=
 =?utf-8?B?d1hvU1U0WW5jS1VlbDJ3THZmT0FrcFoxQVlFOElJa1YxTWRsRHJBV3RxWWRY?=
 =?utf-8?B?am8zTzk4ZlQzMEhPU3ZkTDFGTUxEREtRcGtPWjc4S1doaVhEcm1xNXp2MGRK?=
 =?utf-8?B?Z0tTam5Kcmt6d1BRZEx4VTZhMnRzT1ZIWUpHMFBidGNwYzBXUjRNR0duZUZp?=
 =?utf-8?B?azNkSDZ5TGc5ZlB5RXhtSDdPSHV3ZlgxOU5zK0x1UVNYNHdYQjAvVFFYeEZm?=
 =?utf-8?B?TXY1eWJWZ0llV2VDRzV6ckQrMGwwMVVzUDYwSmdrSmNqb1BMVTBWamtwRnlt?=
 =?utf-8?B?QzllTmV5QWtwS1J2N3hmcnluOEpQWXNwTUJSeWtnOTI4Q01IZ2toRjcwcVBa?=
 =?utf-8?B?MkFXcXk3L2pzTkRWYkVQVWxiNElnMGEyd2g4dlFwcjhVVEM1SlNub1VNVW56?=
 =?utf-8?B?VUZxQitZTms2U1FJUzdSTGlLbnUxSXZHaVhIM0NjbUY0VmVoa29uTGpUTExB?=
 =?utf-8?B?N290NzZ6NDc4MHBVN3RQUjREQkp6S3BMb1IvUU90STVLcHBQdzYxeFcreUl0?=
 =?utf-8?B?T2JUM3M3cExqaFRQU0E5R3pQOWE4c3VyMGlreVJMUnlwSXB0eXNOcXZUbDMw?=
 =?utf-8?B?eTE5ME1lTDA4ZDhpOElHYSt0M2pyTklBUU1EQnJrQ0h6amo4SEdVYms5a1Nr?=
 =?utf-8?B?R0w3eTg2SGJhdGpXRjN3bUZ4SEdWNXlWWVhOaU5hS203cFVPQTRQS2w0VVE4?=
 =?utf-8?B?VmFFb1doc3VVNkJIVXdGRXVHQ0J4OG1acnJHTlIrdGdpTDBnQURrdThmYlk5?=
 =?utf-8?B?VWtuWDFNeHRrQWVEVzYreFM3Zm9vQUVBL0p4TlV5TTVNbUtGRlRlV1hsa0Vj?=
 =?utf-8?B?Um5DUkhHVWFCQUc3MVEzWnhzbTNWYWc5cDc5UHBoKzFrd3hDVHU0bThaU1A5?=
 =?utf-8?B?cG1xZXVUZkVOeEZQQ3p3UjZlVE1PS3d0YXBoZUhTQVV1TkJvUVZUcXpieTVR?=
 =?utf-8?B?amsvaDNQYlMrWDhveTRXWFRlUnE5Z3d5aTArMFNDQVVsSjZrUHo1V3pVc2w1?=
 =?utf-8?B?SGxPblkxSHNiVnE1azl6cGxQaTF5N0U5NVBQK1BwbFk2T254UWtQUkVPQ0Np?=
 =?utf-8?B?NzY2ZHpzTnZZSzhzMFEyQWpGamtDbWNvMUx4U3E0TCtxWXJoQ1lnenJkUFgx?=
 =?utf-8?B?TFdnRU1QcVY3VTM5NnBOM1N1TFNFckwyQXN0aWFpaTdLSUpLSnVBWStSWnNK?=
 =?utf-8?B?Ukx5eUE1ZlVXWmN2dXZjVCtiMlNwRGhoYnBvazFpYzdFcWl2amkyRU1vWWVz?=
 =?utf-8?B?OW0zNnhKa1RZS2ErUjFGdFFsditIamEzbG5HVkRIYm1kNkpkS3RyQkcrV1Fp?=
 =?utf-8?B?c2VlWEJyc3BSa3BVTVpSWDdkeWo0ZStGZzJmeXlpMityUEZTa0h3Y0dpUWo2?=
 =?utf-8?B?Y1p4Y2NzN3ppbXM0STZhYzRXWHZsOURlQzBiTFh1ZG5EUklUbXJ1WUVpbzJT?=
 =?utf-8?B?ZGl2S1FXazI0K3FtSUw3TFRoT2E5bjljNm9GTkN1RUFNNTlPMmkvOWdwMldH?=
 =?utf-8?Q?EoQA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80f1d63-65f3-4f19-1648-08dcffe46ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:59:35.6599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdekbYLCBcZ0UlKG4JlU09NeAjE3ijkMdNYpSgxyHmyZy6513Dxpx5gUc0rfA4Q1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVG8gYmUgY2xlYXIgZm9yIHRoZSBtYigpIGFwcHJvYWNoOiBFdmVuIGlmIHdlIGluc2VydCBt
YigpIGluIHByaW9yIHRvIGFtZGdwdV9yaW5nX3NldF93cHRyKHJpbmcpLCBHUFUgbWlnaHQgc3Rp
bGwgZmV0Y2ggc3RhbGxlZCBkYXRhIGZyb20gUFEgZHVlIHRvIFVTV0MgYXR0cmlidXRlcy4NCg0K
VGhlIGlzc3VlIGhlcmUgaXMgbm90IHRoZSByZS1vcmRlcmluZyBidXQgdGhlIHN0YWxsZWQgUFEu
DQoNCk1vbmsgTGl1IHwgQ2xvdWQgR1BVICYgVmlydHVhbGl6YXRpb24gfCBBTUQNCg0KDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaXUsIE1vbmsNClNlbnQ6IEZyaWRheSwg
Tm92ZW1iZXIgOCwgMjAyNCA2OjIyIFBNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IFpoYW8sIFZpY3RvciA8VmljdG9yLlpo
YW9AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFuZywgUGhp
bGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGRybS9hbWRrZmQ6IHVzZSBjYWNo
ZSBHVFQgYnVmZmVyIGZvciBQUSBhbmQgd2IgcG9vbA0KDQpDaHJpc3RpYW4vTGlqbw0KDQpXZSB2
ZXJpZmllZCBhbGwgYXBwcm9hY2hlcywgYW5kIHdlIGtub3cgd2hhdCB3b3JrcyBhbmQgbm90IHdv
cmtzLCBvYnZpb3VzbHkgdGhlIG1iKCkgZG9lc24ndCB3b3JrLg0KDQpUaGUgd2F5IG9mIG1iKCkg
YmV0d2VlbiBzZXQgd3B0cl9wb2xsaW5nIGFuZCBraWNraW5nIG9mZiBkb29yYmVsbCBpcyB0aGVv
cmV0aWNhbGx5IGNvcnJlY3QsIGFuZCBJJ20gbm90IG9iamVjdCB0byBkbyBzby4uLiBidXQgdGhp
cyB3b24ndCByZXNvbHZlIHRoZSBpc3N1ZSB3ZSBoaXQuDQpGaXJzdCBvZiBhbGwsIFVTV0Mgd2ls
bCBoYXZlIHNvbWUgY2hhbmNlIHRoYXQgdGhlIGRhdGEgaXMgc3RpbGwgaW4gQ1BVJ3MgV0Mgc3Rv
cmFnZSBwbGFjZSBhbmQgbm90IGZsdXNoZWQgdG8gdGhlIG1lbW9yeSBhbmQgZXZlbiB3aXRoIE1C
KCkgZ2V0IHJpZCBvZiByZS1vcmRlcmluZyBHUFUgbWlnaHQgc3RpbGwgaGF2ZSBhIGNoYW5jZSB0
byByZWFkIHN0YWxsZWQgZGF0YSBmcm9tIHJpbmcgYnVmZmVyIGFzIGxvbmcgYXMgaXQgaXMgbWFw
cGVkIFVTV0MuDQoNClRoaXMgaXMgd2h5IG9ubHkgY2FjaGUgcGx1cyBzbm9vcCBtZW1vcnkgY2Fu
IGdldCByaWQgb2YgaW5jb25zaXN0ZW5jZSBpc3N1ZXMuDQoNCkJlc2lkZXMsIGRvIHlvdSBrbm93
IHdoYXQncyB0aGUgcmF0aW9uYWwgdG8ga2VlcCBhbGwgR0ZYIEtDUSBjYWNoZStzbm9vcCBidXQg
b25seSBISVEvS0lRIGZyb20gS0ZEIGNvbmZpZ3VyZWQgdG8gVVNXQyA/DQoNCkZvciBwZXJmb3Jt
YW5jZSBjb25jZXJuIHRoYXQgbG9va3MgdG8gbWUgYWx3YXlzIHRoZSBzZWNvbmQgcHJpb3JpdHkg
Y29tcGFyZWQgdG8gImNvcnJlY3QiIGVzcGVjaWFsbHkgdW5kZXIgdGhlIGNhc2UgSElRIGNvbnRy
aWJ1dGVzIHZlcnkgbGl0dGxlIHRvIFJPQ00gcGVyZm9ybWFuY2Ugd2hlbiBzd2l0Y2hpbmcgdG8g
Y2FjaGUgbWFwcGluZy4NCg0KDQpNb25rIExpdSB8IENsb3VkIEdQVSAmIFZpcnR1YWxpemF0aW9u
IHwgQU1EDQoNCg0KDQoNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogVGh1cnNk
YXksIE5vdmVtYmVyIDcsIDIwMjQgNzo1NyBQTQ0KVG86IExhemFyLCBMaWpvIDxMaWpvLkxhemFy
QGFtZC5jb20+OyBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IFpoYW8sIFZp
Y3RvciA8VmljdG9yLlpoYW9AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWWFuZywgUGhpbGlwIDxQaGlsaXAu
WWFuZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRrZmQ6IHVzZSBjYWNoZSBHVFQgYnVmZmVy
IGZvciBQUSBhbmQgd2IgcG9vbA0KDQpBbSAwNy4xMS4yNCB1bSAwNjo1OCBzY2hyaWViIExhemFy
LCBMaWpvOg0KPiBPbiAxMS82LzIwMjQgODo0MiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPj4g
T24gV2VkLCBOb3YgNiwgMjAyNCBhdCAxOjQ54oCvQU0gVmljdG9yIFpoYW8gPFZpY3Rvci5aaGFv
QGFtZC5jb20+IHdyb3RlOg0KPj4+IEZyb206IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPg0K
Pj4+DQo+Pj4gQXMgY2FjaGUgR1RUIGJ1ZmZlciBpcyBzbm9vcGVkLCB0aGlzIHdheSB0aGUgY29o
ZXJlbmNlIGJldHdlZW4gQ1BVDQo+Pj4gd3JpdGUgYW5kIEdQVSBmZXRjaCBpcyBndWFyYW50ZWVk
LCBidXQgb3JpZ2luYWwgY29kZSB1c2VzIFdDICsNCj4+PiB1bnNub29wZWQgZm9yIEhJUSBQUShy
aW5nIGJ1ZmZlcikgd2hpY2ggaW50cm9kdWNlcyBjb2hlcmVuY3kgaXNzdWVzOg0KPj4+IE1FQyBm
ZXRjaGVzIGEgc3RhbGwgZGF0YSBmcm9tIFBRIGFuZCBsZWFkcyB0byBNRUMgaGFuZy4NCj4+IENh
biB5b3UgZWxhYm9yYXRlIG9uIHRoaXM/ICBJIGNhbiBzZWUgQ1BVIHJlYWRzIGJlaW5nIHNsb3dl
ciBiZWNhdXNlDQo+PiB0aGUgbWVtb3J5IGlzIHVuY2FjaGVkLCBidXQgdGhlIHJpbmcgYnVmZmVy
IGlzIG1vc3RseSB3cml0ZXMgYW55d2F5Lg0KPj4gSUlSQywgdGhlIGRyaXZlciB1c2VzIFVTV0Mg
Zm9yIG1vc3QgaWYgbm90IGFsbCBvZiB0aGUgb3RoZXIgcmluZw0KPj4gYnVmZmVycyBtYW5hZ2Vk
IGJ5IHRoZSBrZXJuZWwuICBXaHkgYXJlbid0IHRob3NlIGEgcHJvYmxlbT8NCj4gV2UgaGF2ZSB0
aGlzIG9uIG90aGVyIHJpbmdzIC0NCj4gICAgICAgICAgbWIoKTsNCj4gICAgICAgICAgYW1kZ3B1
X3Jpbmdfc2V0X3dwdHIocmluZyk7DQo+DQo+IEkgdGhpbmsgdGhlIHNvbHV0aW9uIHNob3VsZCBi
ZSB0byB1c2UgYmFycmllciBiZWZvcmUgd3JpdGUgcG9pbnRlcg0KPiB1cGRhdGVzIHJhdGhlciB0
aGFuIHJlbHlpbmcgb24gUENJZSBzbm9vcGluZy4NCg0KWWVhaCwgY29tcGxldGVseSBhZ3JlZSBh
cyB3ZWxsLiBUaGUgYmFycmllciBhbHNvIHRha2VzIGNhcmUgb2YgcHJldmVudGluZyB0aGUgY29t
cGlsZXIgZnJvbSByZS1vcmRlcmluZyB3cml0ZXMuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoN
Cj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+PiBBbGV4DQo+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIHwgMiArLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCj4+PiBpbmRleCAxZjFkNzlhYzVlNmMuLmZiMDg3
YTBmZjViYyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlLmMNCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
LmMNCj4+PiBAQCAtNzc5LDcgKzc3OSw3IEBAIGJvb2wga2dkMmtmZF9kZXZpY2VfaW5pdChzdHJ1
Y3Qga2ZkX2RldiAqa2ZkLA0KPj4+ICAgICAgICAgIGlmIChhbWRncHVfYW1ka2ZkX2FsbG9jX2d0
dF9tZW0oDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIGtmZC0+YWRldiwgc2l6ZSwgJmtm
ZC0+Z3R0X21lbSwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgJmtmZC0+Z3R0X3N0YXJ0
X2dwdV9hZGRyLCAma2ZkLT5ndHRfc3RhcnRfY3B1X3B0ciwNCj4+PiAtICAgICAgICAgICAgICAg
ICAgICAgICBmYWxzZSwgdHJ1ZSkpIHsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBmYWxz
ZSwgZmFsc2UpKSB7DQo+Pj4gICAgICAgICAgICAgICAgICBkZXZfZXJyKGtmZF9kZXZpY2UsICJD
b3VsZCBub3QgYWxsb2NhdGUgJWQgYnl0ZXNcbiIsIHNpemUpOw0KPj4+ICAgICAgICAgICAgICAg
ICAgZ290byBhbGxvY19ndHRfbWVtX2ZhaWx1cmU7DQo+Pj4gICAgICAgICAgfQ0KPj4+IC0tDQo+
Pj4gMi4zNC4xDQo+Pj4NCg0K
