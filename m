Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B178FC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 10:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5227D10E082;
	Wed, 21 Jan 2026 10:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tkokN9lS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490DA10E751
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 10:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU1KWpXYu95axyumUYXdQkugaHRu2SMwnmNQOO5+B5kvpShsVq7PKe6pOZUN8BeDU+CwoEOQhBEBp7Mn4d7yqhv9sb0HCXOvun+NHIsxBnA6A2INAc8Kvwf3NUbmkg897fq75WWOfXLU7lJBzO/rOOI8A4n9ZMsJKGQnj/0VLZs/1sYGYMqDVZc7aw/hnXIcwF+HriYUz/ch1vmQtCdYA4Lwy6+uEcXGjtbUjpYxVcr073H1rrWozgAb+O7TDAZS8PEUMWFhWnG8HbPq4KYwjoh7O+ObJZJ0tS0qrrxlfJN+OYwOjc9+1OfTAbr5OJ4ezHhtVvU5IqiCNqG2AEzXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF3F2Q4aHjKqOBx+RRuX+1wCKvQ+u8HNJfLaXOnYh3g=;
 b=SRcqwceUuAgItP3roIbC3MvHA2W8S6BXrjLuTFxzMzYh+wiWv6fqqZRI8DAD0pC1+QmFU0h+2qk/zO/L/tQr3Xomp79baMMIyuoly2qWefyJOHm45bH2ityECG3pshvIDV6ErKb+wnizIjOpa5isjdFxtXjzib0n9kW+62NoAAinKGCiz1WN2/VZYZv6gdvxQjB2fP+RNAhysRA6DYpu28BvME1K6EilX9E90Co6tYF3pjFbAFQyp8cw0/4WcmZ8MOKClIolJDK2P8FJAQILZUZ2rsMr35eBhs/bq0ZmOdp47lGbqogMa/2+F5VOPNaKf1MZD9xt+TR+43JM4r1nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF3F2Q4aHjKqOBx+RRuX+1wCKvQ+u8HNJfLaXOnYh3g=;
 b=tkokN9lS8ljNhT9sSl9LFj5ct8VPMB2lBDb+BJ1g8NyodAIJr6P4WLectlb0upJQZXKTUXkklZp8slcu72fExdDSPs/95kHR4gRJzxItR8mlEhNh/JzP8o1f4qgPGwjl0LPg/cgWeW9CPhkoYFqFGJWRrD5IoUiaWAd+8DX/EN4=
Received: from IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:37:05 +0000
Received: from IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0]) by IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0%4]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 10:37:05 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Ba, Gang" <Gang.Ba@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 3/5] drm/amdkfd: gfx12.1 cluster barrier context save
 workaround
Thread-Topic: [PATCH 3/5] drm/amdkfd: gfx12.1 cluster barrier context save
 workaround
Thread-Index: AQHchyhcZ8PevN5ASkiZk2HZSoPxK7VbukuAgAC7BjA=
Date: Wed, 21 Jan 2026 10:37:04 +0000
Message-ID: <IA0PR12MB86476D24617053E76B1DAA329A96A@IA0PR12MB8647.namprd12.prod.outlook.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-4-jay.cornwall@amd.com>
 <e212145c-6c77-49ec-a0da-48cacb031fd9@amd.com>
In-Reply-To: <e212145c-6c77-49ec-a0da-48cacb031fd9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T10:36:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8647:EE_|PH0PR12MB7984:EE_
x-ms-office365-filtering-correlation-id: 7b79f6a1-f511-4fbc-21ce-08de58d9051c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OFR6UGMxQ2p1M1gyT3RMQys2M3ZrYmppQ2J3TkNMV056VlNwT2lLUFNGYXcy?=
 =?utf-8?B?dzlZWDdYcUtQTTN6Uk0zVllHancwVlB1dW5TZTVTOXJ6bVdGbEVtVktXd0VB?=
 =?utf-8?B?SUVvQTlBYUc4dU14cXlNMjJUYmJQdzZjOXp2bTA2cythZHhLbE9nTUtTclJz?=
 =?utf-8?B?c2xDNnd6UFIycWlmT09taG5zbi9lWWNPVXBiRTFaRVN3VGlONGpoZHBrZkJ5?=
 =?utf-8?B?S1g3WlR4QkRvQitZTnloVGxpOStaaDFMTkhxR2s1TFNyWmFhV29FZG1XZC92?=
 =?utf-8?B?NGhnelNFbE9aWDVDdHJoWEF2MlVUZU5YNTRHclk4b3ZWVVZnbzN1dUhFVWl2?=
 =?utf-8?B?ZHF6bUVLdnBrU3g2UEhtZE1LczM4aHpiL1lIVmk3ajAvekZldHB1NGpPKzEw?=
 =?utf-8?B?YW9iUUNKVXFJYjBsaDIyNTV5eHZnYVNzSjdFd2VpYmNzVkRVUkxnR1lCbHNs?=
 =?utf-8?B?OXp4WXpWamtJekpHdld6ZWpCKzB1QUNHY0U5aFlhUDZ3RHRCV1BYMHNraGl1?=
 =?utf-8?B?UHA1VzlOTGoxRE1yYVJ2a25zZUVXeUhwbkFGbDI4enN0M2MwQzdkczVIekE4?=
 =?utf-8?B?SzV1NUZpOXZkV2tjSkFyWE1lRkttSFRScXFzVStsbFZsSUZyQWY3bUY3SEtR?=
 =?utf-8?B?Y25FdGs0Ly9VNkc4RTBNbEt2a3hjcGJkNUJsZHJnNWZPaGlCdHgzMGVxOWpv?=
 =?utf-8?B?ZldEZW5Ca1hFandUcEk0WCt0M1hQcWdXYlJKSlVGMGdFaFA2R1hQS3FvU011?=
 =?utf-8?B?QWV6a0pORktGUXBRT1B1RVpjbHAxUkhQejdrNExiWnMzTEJVajU1WXlLbWhw?=
 =?utf-8?B?Ulh6eThONzAxaXFMUGlpYkpkcGptRnhqYXJIOHd1VExmTEtxNy80NWRLZHdj?=
 =?utf-8?B?aGE3ZGVNOUJZc3YzNTZxMm9nZHVHZ0pTdkFOejdydXhHckJsRGh6cnRtenFn?=
 =?utf-8?B?Q1k1ek1aUHBZckpOWDBpUWxTQnFERk5JR2RWKzFhYjN6Q1NQaU5lS09zTU1G?=
 =?utf-8?B?YmlWanNBZWNIMU0yL3lETlRnRXpSeGI1WS9oZkhheDZqWVNTUWVkWDQxMWJm?=
 =?utf-8?B?bjVySjdMbVlBMWtnWjZkKzhEenZ6Y0VyNUVUTnBzalNiVzEvWnY0TDJsSUox?=
 =?utf-8?B?Mzc4VkltYWxnaVZMa1g1QXNCZkNSelhpWE1rT05JcXZPR2ZsbW5GeHcrWkdJ?=
 =?utf-8?B?WmYxcWsrUWM4QUprRUs4MTBLN1RVdUVWdFFuUmRKRExYZERLZEMrQWVFbGEv?=
 =?utf-8?B?NlpzdjZuY0ZSU1FzTmNadzFZQitNSTd3SUZ6bUtwc3JtUTc4SjFZUERlZ1U2?=
 =?utf-8?B?MGtITTFxdHByRkpjbmNpOGJMUDVodDJaRXY0dkRzSkhQdVNmWHdrSi8xNmFK?=
 =?utf-8?B?Z1FLUmlaWERjc0Z2VzFnREw1OTlpVlIyN1RtYmdReGFhZTlKbFNRYzNwQXhW?=
 =?utf-8?B?UFhKbXlBL3ZGS2krakYyRHNZbkgrVHAxUkE2TUFlUjFhdlBYN3kwUC9nOWND?=
 =?utf-8?B?aFVOcUNYQlpFUGl6c0RTUnB1THlsa1plNjBCVTNiQ0NNYi9KTXdXNExJZzM4?=
 =?utf-8?B?RWQ0VnV4OGFEZFZWcjJhN1RwN3BSaFRXcHd5S1htclB0dk9EK2lkSi9rWUxU?=
 =?utf-8?B?TjVJWWQ3WlNibGMxbFY3U0xyc2c0K0ZoSk85S3BOSFBzNjdZLzhBbGlWZ2lT?=
 =?utf-8?B?QXNkS25vMi8xeUFQcGhVTkM5bmJXYmVUcFcwOWc2Y2F1dHdNbWFuZGZsNG1q?=
 =?utf-8?B?NEZlVUZTcU5Tb21Eb3Z0UDBZY0JlbkxuRDY4cyttelI0YXc4d2V6RGVRZktk?=
 =?utf-8?B?UHNOYnc2aytqL2d0dzJKdlRQclZDQUt3R0dLUWdzdUlHU1J0Zk5ITFBaZ3B3?=
 =?utf-8?B?UTRWcjljU0tzR0ZVcFEwMVdlU2xqY2Y3bEY3dVFpVU1lWlI2QXVISW1FdXBK?=
 =?utf-8?B?RFJHeU50WWtTVTdIYjdxcVhpN0RtSUtZemxvejM4WmMvSHNqU0FFeTQxVjht?=
 =?utf-8?B?MVlMakI0TzN2bGRldWV4ZUxGNnIwNmYxc3M1UUtsOVd6dWNpN1d2aDBiTUxm?=
 =?utf-8?B?WnFwNW52NzRSSHhuK2hHYm4wVjVEZmpQa04xWWZNZ2FZUGlzc2svakRwMmNv?=
 =?utf-8?B?V2hjWlExTWI1ckMzWm5EMkN6UTBDV3pCK3d1N21IU2tnWWtNN3JwTXJ2VWxJ?=
 =?utf-8?Q?pptzG9WAQ2E2rh6kYavI8qU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8647.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlJ5OU5vVitaRXgvZXdnQ3RKbUIxb2RNZFRPRnlZWXpBN2hXcmVYajM3UGdL?=
 =?utf-8?B?blRHSUp5cFdZSndHd3FlVDRZS2RTcEg5SmJWV250OVJwNXdlWEZuRjZ6WkRo?=
 =?utf-8?B?Y25kNFJTVXVKNk5QcUJHdlRMbjBodEJ3R0ZUamEvNGlOWThKS3FIVkl2MW56?=
 =?utf-8?B?UWpCVXpzZzk0YkRFWFJEdEgvN01MKzBZRGxFbUs4bysyY2lhQVRrRHdKTmNX?=
 =?utf-8?B?T2UzMmRPRXZOcm1kMllZRlZ0czRLTmFLeFRrajcwdkV5Y0JtTEtnQlArcy9p?=
 =?utf-8?B?dWlkc3VBUVBPVHlYd1FIUkZwZFdiT2ZrUllPM280bVRDK1JUM080ZnVuZ3NJ?=
 =?utf-8?B?OVdYdVU5T3ZGSEZCMmd6Y2VrdUZuM1pqbHQ2L0pwQytoZGtRWTk4bVljU1Y4?=
 =?utf-8?B?VUlyQlhIWGJHVCtiRlB1N3NZUEV0WlgySHA2K2RKNklVTitzOFV5cEdzVG44?=
 =?utf-8?B?UW1ER0FzUFdXVUlhOW5Odk9GL0hwWFQra0F0ODJ5QnVyS01SY0plL3lpYm1l?=
 =?utf-8?B?cmVZcXBFNHk1Sk9Dd1FBR2g3N1VoNHV4c2ZKVFZMOTdRSVNzOUJ4V2VJTDdL?=
 =?utf-8?B?ZkFyOXJiYUhxczRwZ1A0SFZ3bnBaVUJwUzBDcHpzUzRTa0RTNVFSbGQ5Um9V?=
 =?utf-8?B?MTZ1RGVteS9USTRJTmRBL3ZYT2RsZGdCUlJrcVZ6clBTVXRtT2F1cjg5UlZi?=
 =?utf-8?B?RUFHSUltQ2dvY0NPYVJRYmptTDJoOE4xUzdSTEo5ZFVRNTVFV3VkRlhIblFE?=
 =?utf-8?B?NVU3WWVudWxheWpsTHovclhSVjZGQlE5REllcnFvV2xYaEY5YW5aQUUxT09J?=
 =?utf-8?B?T1gzMFQ4TnBaSmIvWWlYSWo5bzYvS29VYjU3MHZrTmtRTVZDVkxBazdtbnJs?=
 =?utf-8?B?Q2lzTHRUczhyVm9kYjJXVTBQVWV2a0tsS2J1NXdsR0NCeGhwT0pMRFlXNm93?=
 =?utf-8?B?QUdSZjd1bkVZamsxTDFCWHpZTnVsUmZuTE1hY09yNEdQQkVmcG5sMVJlZDBr?=
 =?utf-8?B?a3psMFZvZGpHeEptemZLRllDVCs3czlLZFJRbTVOQ2dob2owR2QyS3VPb1lL?=
 =?utf-8?B?TlNicWJ6enRuV0cvcHIySDB0c0o2bCtwaVFCc0Z3VUNlNVh0V01xMnhCMith?=
 =?utf-8?B?YlNkQ0l6Qk9GaDEyMUdLaWN6dUdiL3R3bGVhakQxR0VYbEp2cUVPR0J4U05I?=
 =?utf-8?B?OGtrdVZkQm9iRy9LWFlURFg2VzJNR3RYMktkZi9WWXF6Wmhld2UwL05KU3lJ?=
 =?utf-8?B?U1ozZVlWKysyajdIY3hURkR4d0pHcktaL1paUFZSakdLR0xqSDl2N21YRnMx?=
 =?utf-8?B?alhOQko4OE82dUp5L0VWV3QvYjIvR3RlVytUSndOY1BoSHVuMzg5bnZ2NDhD?=
 =?utf-8?B?NE5IVFlUdEFIQ0tOakZNbWhjWkFPemFCN1MzQ2RRR3FJRHZWSlY4M0IrZVdx?=
 =?utf-8?B?Y1FhV0tRRW5GaEFpMnBLclozUzRaT2tHeE1wMExJMDlaKysrQ3k0dEl5Mm9F?=
 =?utf-8?B?YjRUQ2ZDV2hPZmhvZU9xUk95MktyYXZ2NWhXeWRRUmpDUHpkMUFBd1dyZFVh?=
 =?utf-8?B?ODFXZnBSeWE1dHpMQWFBMlFBMFFFK1VKanhFa090akV1QnB6MmNjK1BkWDFh?=
 =?utf-8?B?WWk0WDJJSEhjTE80ZU90bXQ2Y2pqSUZteS9QU1MwcUttaFFzTWQvSHpwdjB1?=
 =?utf-8?B?ZjlrQmV3OVIxODlHcnA1MWdYMHNtbTdMdENobEYwZTFmb1VGaXlZemRVSFk1?=
 =?utf-8?B?TEozWCt6OGsxM2Q1RHF0dnZXOEJxL1hicHYyWE14OE5vbzAvNUlXbTQyVVFR?=
 =?utf-8?B?eWZwSTA1b1IwOG5xOHB2bDIrMU1vU3RDdkl0ak41dzA4R0t2eTgrZ1Z0WWcy?=
 =?utf-8?B?aU1LZCs4VEE5UW1XaXFQTERuUlJaSUh1OG1ickx2eCs2bk8vYkVmaFJZbmI1?=
 =?utf-8?B?RUN3a3FkUWlVVmU2Vm1XOXFobk9MTjFPN2JSQzBlcjJqTStzTUVNZXdXd1dq?=
 =?utf-8?B?OWdXbk5VZ2NKU0MvNUNGZHA1Wjg2QUQ0SEtCSWFCSXpjRVgrTVplVGppbGVL?=
 =?utf-8?B?UHVzbkd2bjR1SXF5TmxhR2R3bnZIQ09HelRINVk2RmgyWFRuVjd4UGF3dVEx?=
 =?utf-8?B?SWs5clZsbzdKZHVROTRvVURrakw5azI3RHBZa0pLbzkwcjRXMGZ5dlYzQVZV?=
 =?utf-8?B?M0RsUXo4OGtmaEQ5THpxNnFIamUwTDJ5WlEyZmRPT2NuZzRyTitvSWkwWFZ2?=
 =?utf-8?B?SFFkelRzR0JPMFY5SzZxaXU4aGlZNlNBZXJyd045SXREUHBjYno3U1NLRU5B?=
 =?utf-8?Q?JvkInjhazoR3JQkDcQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79f6a1-f511-4fbc-21ce-08de58d9051c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 10:37:04.9471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytgyHXDL70lX4pfGmQz36JaBBG61NSl7DigvHzlK2ObE6G2cbyOYOVmlbq/R9/S3nnAMLg39Y7NgECfSK+75XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
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
Cg0KT25lIG1vcmUNClJldmlld2VkLWJ5OiBWbGFkaW1pciBJbmRpYyA8dmxhZGltaXIuaW5kaWNA
YW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNpeCwgTGFuY2Vs
b3QgPExhbmNlbG90LlNpeEBhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIxLCAy
MDI2IDEyOjI3IEFNDQpUbzogQ29ybndhbGwsIEpheSA8SmF5LkNvcm53YWxsQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEJhLCBHYW5nIDxHYW5nLkJhQGFtZC5j
b20+OyBLYXNpdmlzd2FuYXRoYW4sIEhhcmlzaCA8SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQu
Y29tPjsgSW5kaWMsIFZsYWRpbWlyIDxWbGFkaW1pci5JbmRpY0BhbWQuY29tPg0KU3ViamVjdDog
UmU6IFtQQVRDSCAzLzVdIGRybS9hbWRrZmQ6IGdmeDEyLjEgY2x1c3RlciBiYXJyaWVyIGNvbnRl
eHQgc2F2ZSB3b3JrYXJvdW5kDQoNCkhpLA0KDQpPbiAxNi8wMS8yMDI2IDIwOjM5LCBKYXkgQ29y
bndhbGwgd3JvdGU6DQo+IFRyYXAgY2x1c3RlciBiYXJyaWVyIG1heSBub3Qgc2VyaWFsaXplIHdp
dGggdXNlciBjbHVzdGVyIGJhcnJpZXIgdW5kZXINCj4gc29tZSBjaXJjdW1zdGFuY2VzLiBBZGQg
YSBjaGVjayBmb3IgcGVuZGluZyB1c2VyIGNsdXN0ZXIgYmFycmllcg0KPiBjb21wbGV0ZS4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogSmF5IENvcm53YWxsIDxqYXkuY29ybndhbGxAYW1kLmNvbT4NCj4g
VGVzdGVkLWJ5OiBHYW5nIEJhIDxHYW5nLkJhQGFtZC5jb20+DQo+IENjOiBIYXJpc2ggS2FzaXZp
c3dhbmF0aGFuIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+IENjOiBMYW5jZWxv
dCBTaXggPGxhbmNlbG90LnNpeEBhbWQuY29tPg0KPiBDYzogVmxhZGltaXIgSW5kaWMgPHZsYWRp
bWlyLmluZGljQGFtZC5jb20+DQpUbyB0aGUgYmVzdCBvZiBteSB1bmRlcnN0YW5kaW5nLCB0aGlz
IGxvb2tzIE9LLiBUaGFua3MuDQoNCkJlc3QsDQpMYW5jZWxvdC4NCg0KUmV2aWV3ZWQtYnk6IExh
bmNlbG90IFNpeCA8bGFuY2Vsb3Quc2l4QGFtZC5jb20+DQo=
