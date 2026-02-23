Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CFAE98DEC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 06:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B8410E23B;
	Mon, 23 Feb 2026 06:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9U87yEG";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D962610E23B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 06:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwT0wdqPnK3l01Ga+2A98K4Wub04x97irTe9iGTCqqx2etReZ81MXEBlo2hqGI3twujO2RS0t3kBX8wnQtfgQAnoWMr8qrZLcNWSXZ8NoQnv1VqXX5yZ0LEguk1UZMqMLtbX+xD07OMh7S1xl3+KWdd1MqYQHoNrfVI/ma1YmGTMOC5BBoKNqq9ML2P7k6n0S2oK+ROhCPst/jzdxVEsi9IUHKA1812wIeCtJW9qMUdOHSd8TgccDUIkzuB4siT4wRlSS+E9F18mfdN6uCLbXtjcIDSVKyLzVkCcN606XQFStjZyPYaOykkMMJ8NZw9y3py83s1k43Nh0R41Pm4bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7ZwcYcqxUx0+i9RNid52iMI0C4ZMfH5lgvYW0ZZGQc=;
 b=X6bBVMBcYXw7D24w3JcnSggh7NLTwPMm+BTICKJYpnp2zCzUkyUDmTBdtAi5UG5q0bx296qBtIScidELYN8s8xLvhtIZ2P5sSiMA3ws68OGtusV+bRggU90/pkPOKoY52kllJ8iSC27ZESPqPhtNkVm3EB6+G9l1eldR0IO9gRO596jVW/YTSodpWxirXs6HMai6fHvrqgwl9o4Os8xVUtGo4LRUINNQqDvrT9F8g97cBhbAGmc+1Lf/ZvnXcnSSnjQ64F1SMTXgeiOxZE4Kp8wmr3OldHGw5Y+FbAAL7aLbMAOR7mpUfGP9OG8EAxHVGm7rBBOM3ElMeyN6xXXPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7ZwcYcqxUx0+i9RNid52iMI0C4ZMfH5lgvYW0ZZGQc=;
 b=B9U87yEGKqV2pQP6wwcttgKfSvHP1qPhloc5NEXmItGDACAzoV6T21XkZyakp3s/CC8Q922hKuTrwVdBdE6U5QX4K5A3zPMjQI0ca4SgmCy76FVMwDRD4ft/Qt8p0ngV65Hlr3nvDynHF0s8r23QaIua8i2LK9+EBvjDqDKSapk=
Received: from SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:41:13 +0000
Received: from SJ0PR12MB8165.namprd12.prod.outlook.com
 ([fe80::1499:6598:d339:f12e]) by SJ0PR12MB8165.namprd12.prod.outlook.com
 ([fe80::1499:6598:d339:f12e%5]) with mapi id 15.20.9632.015; Mon, 23 Feb 2026
 06:41:13 +0000
From: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>
To: "Guttula, Suresh" <Suresh.Guttula@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn5: Add SMU dpm interface type
Thread-Topic: [PATCH] drm/amdgpu/vcn5: Add SMU dpm interface type
Thread-Index: AQHcovELqlP5rcUVnUOx0ExyxIBQB7WQNJeA
Date: Mon, 23 Feb 2026 06:41:12 +0000
Message-ID: <SJ0PR12MB8165000182B53F6E1E9F4FA58077A@SJ0PR12MB8165.namprd12.prod.outlook.com>
References: <20260221051436.2176281-1-suresh.guttula@amd.com>
In-Reply-To: <20260221051436.2176281-1-suresh.guttula@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: SJ0PR12MB8165.namprd12.prod.outlook.com
 (15.20.9632.007)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8165:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: 3b99be9d-10de-4695-2ca4-08de72a68974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?RElCbHZNVlR5TXFKUFU2NkxCbk9lY3BWYURTK0VGZXdWa2FQV3JaOUJwUTlO?=
 =?utf-8?B?eFNWb2pxNjZJVG1sdkxPb2c5VFZkVjVZbmVTek1kaXh5NUhXWFBaOEdDZmtT?=
 =?utf-8?B?OVQwUDVSQWJyS2tKa1FZOG1URFliQVhIbmFFRmYxUFdhVHNoa2ZKMTFJNHlF?=
 =?utf-8?B?VGp3T1JHS043bWtYODBEU1Y3T2d5QjBtTDRNWExMQytqRFM0dytOMUJhYkMx?=
 =?utf-8?B?TWhpYlNFVjdwUzFYV0E3Y285R0xCeWQ0ZEh5R00xSENxbmRldGxQVFpqMUVz?=
 =?utf-8?B?QTh2Q1hNZXh1cU9DL3NBaXVGeHArL05XSWNnWTJTcFNzRU1hWU1RbElNMFBG?=
 =?utf-8?B?bXFMSTVWMlBsQnF3M0RFQmFJU3IrVG0vVkt3Z3M1SklWWkxxczFNUnpHTEZS?=
 =?utf-8?B?ZitKN3cwQlJ2eTYyUzNPcjY0aE5PMHZNVFVRaEZ3SG1Gd1c3cVVGUVQ0UEwy?=
 =?utf-8?B?bXJhYnk3U3orR0dQNmRZQjZjLzFNZFE0dEtZenNVbmh3YlNXUERJTnRLYXRw?=
 =?utf-8?B?S3NieE1zbDFtYlgvNWZndTVPd3F0NjU5QmNWMFdEalFTWHY2OE5lUlJJQVhx?=
 =?utf-8?B?M0tuNUJDT3krNUNmZUdCZWo2ZHlleXRNWmtyRlhrcTVubmJBb3Q1UEhVZE5x?=
 =?utf-8?B?L1hpVitIaU1OUEQveVVXZzJpaThKeWZYajBwbyt6NWxETVVPVk5CTnVIM0NB?=
 =?utf-8?B?WTEyTHVmS1VSZTFHNWg3S2tOaS9STm1ib2V1ZUhnVnNBdWp4R3R1WmhNcjFo?=
 =?utf-8?B?bjV6MzFLQlJ5SFVsVE5iZmo4UTZaVkhJNnRvWnBMYkJibkx3eEp5bDR4bUo4?=
 =?utf-8?B?OXBJUHZsd2VVRzVkbFpwU2hOa2NETUNYNkNwbFNZUmcxTHZIbEw2VmFCaUcz?=
 =?utf-8?B?dTE2bTdwSFBKQW45UlAxR2JnWW9JaTkxT1lGU2dueGEvWVBSRFNhL3BIS0sy?=
 =?utf-8?B?MmF2c21IOGhvSDVRL1VFcFBEYXJYWVEwMzk1aHRXNStGbkphUlowdVJVejJm?=
 =?utf-8?B?d01Edk1KK2hkRFlBZklObXROaTMvbW9kTE5DS2FOWWg1VHFUUDArbkMzKzVW?=
 =?utf-8?B?Y0VGd3BwTXY4d1B3RVpUQVFEaWdDR2p5akdGaEpuY21zcnNURWJJRjRtY2JV?=
 =?utf-8?B?aWl4U29kTy9VRG9ia1ZycjhvbnQvMHR3TC8rbys5ZWxSTlc0WFZ3WFNld0pH?=
 =?utf-8?B?azdZU2VwV2U3ajcrTVh2V21nWE1lZHhjSk92c25sQk5mQTdYTTY3WEJmcGxD?=
 =?utf-8?B?dWNKbDZoU2xqS0JYZFNqNFM3L014dFdHZDhsMlBkeGVYdlpRU2dGYTM1b3Ex?=
 =?utf-8?B?bm1sVnN5YVJaeVBmMUFqNG5YaFJCc3kxZTA5NjhKd0JYajlUZjk1S1pzTWxp?=
 =?utf-8?B?ZS91MEJQNHdDaEFLREk1b3dmNm5SbzA3Q3VVWjRpWTFpL1FUZGtrbkdHenAz?=
 =?utf-8?B?c1FlMnNmeFhTZnQxVis5TzJ5emxMQVk0ZjBITHpHWnVyUVVxMjl1UzJZU0sy?=
 =?utf-8?B?RlZJTjBRTTlORUI5UElGN3RMVm41OGNMc3hvVEpsRE1rZUcyd3BTa0RjQnF1?=
 =?utf-8?B?QWdtdFhaNGZ3QmF4TGt0NklJWnl5cXBJVys0VFREUGh5TlM0K2ZWZkFkZWR4?=
 =?utf-8?B?Unl1bk9nbVM1WEVmbGZOYUxmRWFCSXNhYVZtVmxnL2tneWp4OXo0ZEtFeE5a?=
 =?utf-8?B?UnJuRGtTS3lNZFgraGNXZXYrVG9TV1NyR1p4TlpqMi9HSThYdWpULzJCdHlw?=
 =?utf-8?B?UmxKalBxbitjQ3AxbUtqV0NVNUM3YVI4OE94Z2w0Z2xPckxaN000blpqWDIw?=
 =?utf-8?B?ZWwwZDZYQ0FmS1puemJ3TjBDTkVZTjhJaHEzbWQzSEFyMUMzZE5MSXdTUXZX?=
 =?utf-8?B?aVlMS3hUaWNBaTlLeFlEc2FmeEYvR3dTYnZXUTIzZ3dRT1RUdmhmdFpwTktN?=
 =?utf-8?B?SytJUU92VWFXajlyKzdKMG5oZXJDcmdiMGZtR0FVNUhBSFdTUzNISU5LKytj?=
 =?utf-8?B?aG9pSmpSckdONnhuSFdudkYya3JXejVaQ3lDSnRwTXlnVlFRc0gydFY5S3Vo?=
 =?utf-8?B?Zm8rV2ljTHRtK1ZBOEVxRzNiZlJtNGxOZ0hqQ1pHemp4WkJRNEFOQzFqdG9v?=
 =?utf-8?B?bmZrbkJudGFqcE9GaVdteXlSaEZaQy8xZGx3c3Qwdjc5dU1IRk9WRDVlTW85?=
 =?utf-8?Q?hLx3t1Eq3ehw31vgHV9OosA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDlXMEowTGNuVjlWazNJbURXY0UwYUgraUk0UVh2REVSUlBzV3JWdzlDRVda?=
 =?utf-8?B?Nyt6WXFrMmp6OXhxL3F3MDNRcHE5Tk1WSjlCdVJYVWFUNUozYUh2V2loVWFV?=
 =?utf-8?B?d2piRkQyMkZqRGZRbXcrM1RhMEs2dXlMRGpYMzNZSGppSUNMNkFTVHVYeXJr?=
 =?utf-8?B?cVhGMzVOUS9sbG13OStOak9zS3lxR1JVMms3ZUhHWWJxV2hVRFpVMHlxN3gv?=
 =?utf-8?B?bE9tcFp2eTBTS3lRS0FLSGFyR3JQZ211T0JHU2FJRElRaEkzaVpULzVDcEdp?=
 =?utf-8?B?YzNvZGwrdDUraVgzbEVBMjdxdlJjbFNQMmdoSFpzNTlQaWxqRFFQdUhreldK?=
 =?utf-8?B?bFV2Wmx5N1JlaTRrd01STU5hejh2L3h6MFBpeGE5aVF0cktBNVplc3NMUlov?=
 =?utf-8?B?RHVUalB5bUpoS0g1UzNtcnMzWjFxRml1MEgzM1hobUNmNCtMNVZxdGN4S3Zv?=
 =?utf-8?B?TzcrSnRzcG5nMmxyN2RVZ1VxQWdXS2NRYkw1OHJqUWxzeDZEV0RrdkgzNHNh?=
 =?utf-8?B?Z21NWU1KcUsvdmZDd3dGV1NIVWxOVng5VnhxRHhzMmM0R3I4cnR5SlRBK1Bu?=
 =?utf-8?B?Qm1rb3VWUzVPQWR6OWo4S0FqSHVSWEpnOFZDWjN6QVhiMzhrbFY1UUZOOVBP?=
 =?utf-8?B?Znlvd29SMWNaSU02ZmwyTEZyVUYrNXo0TmU1MXBERjF4YURML2VjVUYrOUJG?=
 =?utf-8?B?cUdZV1NaNjF5THJlRTF1eXZpVXdFUkxzZUhiWTZtSlVnYkNHUkppQThudW44?=
 =?utf-8?B?NlZpZDg3ck1VaWN1c0U1bjVXS0ZLdjQ2a0tWWlUydXBTL1hZNHcrUWpxTE9R?=
 =?utf-8?B?VURFL242bmpXRzBRdEhFS3daVzNKMG4rV2l5c1pjc0tYTTZiYnRIVFIyek84?=
 =?utf-8?B?R2NaQjRtSEJkazhwUVVuWW4yMWZNNitWdGthdzlPVllWVzduZndWZngrR1h3?=
 =?utf-8?B?ZnlSbXdaeCtSaS9CZkxQK2ZjcHZQeE80SE5QTDc4RXlyQ2xHcUxtcEE2N3VN?=
 =?utf-8?B?U1FKRTBRUXI1N2RJL0hDTGVHbWdhbUkrcjBndFJhUE4xbi9lVHNGdit3dmRQ?=
 =?utf-8?B?UTZUUVJFUndYaEtxNGMzcUNuc1B6MVlMZ1phVjJGZ1Z1OTV4VWU2anhwYklz?=
 =?utf-8?B?QnNFY0dJTEtDbTF2d0FVcWt3TlUyQ0NhS0h3ZGJKcFNWUzVwZTBqbllxQkFK?=
 =?utf-8?B?V0ZLYkZRYnlld25Ld1AyRGJxM1VMOTQ2QVBOMktLMmQ5RzdzZGhxd2NTRzFk?=
 =?utf-8?B?R3o0OW54UDRSdHFTNnR6MmozSk9CMzdtTGQ0dytIZXVia1VvVi9POURBT0Iz?=
 =?utf-8?B?OXd5WFdNcWxkQ2toK2JVN0d5bXlaVUN2bCtwMFRmcndWMksvdEsyWFFEL3Qw?=
 =?utf-8?B?aktMaHhOVzE0WWhnTFI1dThKNHljSkF0TldscnNOZEhjT29LTWsrTXdrWDhJ?=
 =?utf-8?B?ZHlpOWcxT3pleERsRlRLNFBGTEl1em5OVlFTd2NlckUwUnZPOW1HTUx2VGh5?=
 =?utf-8?B?ZDk2SnBiSHFHNUJkWUVyS21RS3I3SkN0eGl3b1lWeFhnWHJ0clc1WWxNWFJC?=
 =?utf-8?B?bkl5MXFBM1dSUHhCcmxlajRsUkd0RzZZenlTWTN1NTJNR0FVNlZJdU1VV2sr?=
 =?utf-8?B?Rm9ydzE4VFlnRk5aSDMwTGxiQWRyWXNMdVdGV0U5NTJ2MElkSTZlQUpsTmlM?=
 =?utf-8?B?TXBhdzJxQkpMbDk5QUgwK2kvNWNweGxtZm9namZudHYrVlN3Vm9hRm5MRWhE?=
 =?utf-8?B?cEMrUGpuUzl4TXRySlpyR2htQVlkbFR4NnlsNkVRTzVsZmhQSE5sSUZ2aW82?=
 =?utf-8?B?YTRTbHI2SWdyQWcvZldQY2MxMWF0bG0vcG1hbk1CSW5VMHkyMFo3VkJPc1N6?=
 =?utf-8?B?SndEVzV6NG5FOFk0SVNJNTB3N1FvWkhabDdTYXcxV1RUbC9uVXpCbmJuVUxv?=
 =?utf-8?B?NzVpd2VEcWwvRTBxdmRjT3FOQ1o4Z2JJL1FIZTBjSzZxMUVDRThtdmNHdGFN?=
 =?utf-8?B?eVk3OGRMWTFxbk11Y0FzMmJnZ1FYdWRSTEVDKzFTUkQzaEhwYWo2TWtMOXhM?=
 =?utf-8?B?eHgzajdkSjB6ZmZzQzZkbHdUNFE5dWwzVmFGNitEMzZMWXBHbE55YzhoY2ls?=
 =?utf-8?B?Z1pvQnRpZmhmTG5BQUZyKzNGeFhIMkNlV0JNSUJzdmZ6K1hlWWNhaENNcDND?=
 =?utf-8?B?Zy9KS3g0Zmp4MHkvWVBvWXp2NzJ2WU44MjYwTExhWEJTay9YZm15ckxNU3FZ?=
 =?utf-8?B?OVJrcVF6Ri9JY3lyZnQ1bGlIR1AwaW84YVljeGNaZ0tYQjFMTUVvZXAvOEh3?=
 =?utf-8?Q?2qSfsvmZ9EioZ82EZP?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB8165000182B53F6E1E9F4FA58077ASJ0PR12MB8165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b99be9d-10de-4695-2ca4-08de72a68974
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 06:41:12.9178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsv1KdpDxFYsZZRNjB1cW26mQ6HqKlBAGD6GMddl5oDEt2XeUeQwpV4/R/0/E92/CT6WvPW3ZMUdPlN4tAMMLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
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

--_000_SJ0PR12MB8165000182B53F6E1E9F4FA58077ASJ0PR12MB8165namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpPbiAyMS0wMi0yMDI2IDEwOjQ0LCBzZ3V0dHVsYSB3cm90ZToNCg0KVGhpcyB3aWxsIHNldCBB
TURHUFVfVkNOX1NNVV9EUE1fSU5URVJGQUNFXyogc211X3R5cGUNCg0KYmFzZWQgb24gc29jIHR5
cGUgYW5kIGZpeGluZyByaW5nIHRpbWVvdXQgaXNzdWUgc2Vlbg0KDQpmb3IgRFBNIGVuYWJsZWQg
Y2FzZS4NCg0KDQoNClNpZ25lZC1vZmYtYnk6IHNndXR0dWxhIDxzdXJlc2guZ3V0dHVsYUBhbWQu
Y29tPjxtYWlsdG86c3VyZXNoLmd1dHR1bGFAYW1kLmNvbT4NClJldmlld2VkLWJ5OiAgUHJhdGlr
IFZpc2h3YWthcm1hIDxQcmF0aWsuVmlzaHdha2FybWFAYW1kLmNvbTxtYWlsdG86UHJhdGlrLlZp
c2h3YWthcm1hQGFtZC5jb20+Pg0KDQoNCg0KLS0tDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjVfMF8wLmMgfCA0ICsrKysNCg0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykNCg0KDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25f
djVfMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8wLmMNCg0KaW5k
ZXggMDIwMmRmNWRiMWUxLi42MTA5MTI0Zjg1MmUgMTAwNjQ0DQoNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92NV8wXzAuYw0KDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjVfMF8wLmMNCg0KQEAgLTE3NCw2ICsxNzQsMTAgQEAgc3RhdGljIGludCB2
Y25fdjVfMF8wX3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQoNCiAg
ICAgICAgIGZ3X3NoYXJlZC0+cHJlc2VudF9mbGFnXzAgPSBjcHVfdG9fbGUzMihBTURHUFVfRldf
U0hBUkVEX0ZMQUdfMF9VTklGSUVEX1FVRVVFKTsNCg0KICAgICAgICAgZndfc2hhcmVkLT5zcS5p
c19lbmFibGVkID0gMTsNCg0KDQoNCisgICAgICAgIGZ3X3NoYXJlZC0+cHJlc2VudF9mbGFnXzAg
fD0gY3B1X3RvX2xlMzIoQU1ER1BVX1ZDTl9TTVVfRFBNX0lOVEVSRkFDRV9GTEFHKTsNCg0KKyAg
ICAgICAgZndfc2hhcmVkLT5zbXVfZHBtX2ludGVyZmFjZS5zbXVfaW50ZXJmYWNlX3R5cGUgPSAo
YWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSA/DQoNCisgICAgICAgICAgQU1ER1BVX1ZDTl9TTVVf
RFBNX0lOVEVSRkFDRV9BUFUgOiBBTURHUFVfVkNOX1NNVV9EUE1fSU5URVJGQUNFX0RHUFU7DQoN
CisNCg0KICAgICAgICAgaWYgKGFtZGdwdV92Y25md19sb2cpDQoNCiAgICAgICAgICAgYW1kZ3B1
X3Zjbl9md2xvZ19pbml0KCZhZGV2LT52Y24uaW5zdFtpXSk7DQoNCg0K

--_000_SJ0PR12MB8165000182B53F6E1E9F4FA58077ASJ0PR12MB8165namp_
Content-Type: text/html; charset="utf-8"
Content-ID: <796E61120D7CFF40A4407D82A0DD12D2@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7fQ0KQGZvbnQtZmFjZQ0K
CXtmb250LWZhbWlseTpDb25zb2xhczsNCglwYW5vc2UtMToyIDExIDYgOSAyIDIgNCAzIDIgNDt9
DQovKiBTdHlsZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2
Lk1zb05vcm1hbA0KCXttYXJnaW46MGNtOw0KCWZvbnQtc2l6ZToxMi4wcHQ7DQoJZm9udC1mYW1p
bHk6IkFwdG9zIixzYW5zLXNlcmlmO30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsNCgl7bXNv
LXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVy
bGluZTt9DQpwcmUNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCW1zby1zdHlsZS1saW5rOiJI
VE1MIFByZWZvcm1hdHRlZCBDaGFyIjsNCgltYXJnaW46MGNtOw0KCWZvbnQtc2l6ZToxMC4wcHQ7
DQoJZm9udC1mYW1pbHk6IkNvdXJpZXIgTmV3Ijt9DQpzcGFuLkhUTUxQcmVmb3JtYXR0ZWRDaGFy
DQoJe21zby1zdHlsZS1uYW1lOiJIVE1MIFByZWZvcm1hdHRlZCBDaGFyIjsNCgltc28tc3R5bGUt
cHJpb3JpdHk6OTk7DQoJbXNvLXN0eWxlLWxpbms6IkhUTUwgUHJlZm9ybWF0dGVkIjsNCglmb250
LWZhbWlseToiQ29uc29sYXMiLHNlcmlmO30NCnNwYW4uRW1haWxTdHlsZTIxDQoJe21zby1zdHls
ZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7fQ0KLk1zb0NocERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5
cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1zaXplOjEwLjBwdDsNCgltc28tbGlnYXR1cmVzOm5vbmU7
fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6NjEyLjBwdCA3OTIuMHB0Ow0KCW1hcmdpbjo3
Mi4wcHQgNzIuMHB0IDcyLjBwdCA3Mi4wcHQ7fQ0KZGl2LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldv
cmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPg0KPC9oZWFkPg0KPGJvZHkgbGFuZz0iRU4tSU4iIGxp
bms9ImJsdWUiIHZsaW5rPSJwdXJwbGUiIHN0eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29yZCI+DQo8
ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHA+PG86cD4mbmJzcDs8L286cD48L3A+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gMjEtMDItMjAyNiAxMDo0NCwgc2d1dHR1bGEgd3Jv
dGU6PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW4tdG9w
OjUuMHB0O21hcmdpbi1ib3R0b206NS4wcHQiPg0KPHByZT5UaGlzIHdpbGwgc2V0IEFNREdQVV9W
Q05fU01VX0RQTV9JTlRFUkZBQ0VfKiBzbXVfdHlwZTxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPmJh
c2VkIG9uIHNvYyB0eXBlIGFuZCBmaXhpbmcgcmluZyB0aW1lb3V0IGlzc3VlIHNlZW48bzpwPjwv
bzpwPjwvcHJlPg0KPHByZT5mb3IgRFBNIGVuYWJsZWQgY2FzZS48bzpwPjwvbzpwPjwvcHJlPg0K
PHByZT48bzpwPiZuYnNwOzwvbzpwPjwvcHJlPg0KPHByZT5TaWduZWQtb2ZmLWJ5OiBzZ3V0dHVs
YSA8YSBocmVmPSJtYWlsdG86c3VyZXNoLmd1dHR1bGFAYW1kLmNvbSI+Jmx0O3N1cmVzaC5ndXR0
dWxhQGFtZC5jb20mZ3Q7PC9hPjxvOnA+PC9vOnA+PC9wcmU+DQo8L2Jsb2NrcXVvdGU+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0ibXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMi
PlJldmlld2VkLWJ5OiZuYnNwOzwvc3Bhbj4NCjxzcGFuIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5n
dWFnZTpFTi1VUyI+UHJhdGlrIFZpc2h3YWthcm1hICZsdDs8YSBocmVmPSJtYWlsdG86UHJhdGlr
LlZpc2h3YWthcm1hQGFtZC5jb20iPlByYXRpay5WaXNod2FrYXJtYUBhbWQuY29tPC9hPiZndDs8
L3NwYW4+DQo8bzpwPjwvbzpwPjwvcD4NCjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW4tdG9wOjUu
MHB0O21hcmdpbi1ib3R0b206NS4wcHQiPg0KPHByZT48bzpwPiZuYnNwOzwvbzpwPjwvcHJlPg0K
PHByZT4tLS08bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3Y1XzBfMC5jIHwgNCArKysrPG86cD48L286cD48L3ByZT4NCjxwcmU+IDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyk8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT48bzpwPiZuYnNw
OzwvbzpwPjwvcHJlPg0KPHByZT5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3Y1XzBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMC5j
PG86cD48L286cD48L3ByZT4NCjxwcmU+aW5kZXggMDIwMmRmNWRiMWUxLi42MTA5MTI0Zjg1MmUg
MTAwNjQ0PG86cD48L286cD48L3ByZT4NCjxwcmU+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3Y1XzBfMC5jPG86cD48L286cD48L3ByZT4NCjxwcmU+KysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMC5jPG86cD48L286cD48L3ByZT4NCjxwcmU+QEAg
LTE3NCw2ICsxNzQsMTAgQEAgc3RhdGljIGludCB2Y25fdjVfMF8wX3N3X2luaXQoc3RydWN0IGFt
ZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spPG86cD48L286cD48L3ByZT4NCjxwcmU+ICZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBmd19zaGFyZWQtJmd0O3ByZXNlbnRf
ZmxhZ18wID0gY3B1X3RvX2xlMzIoQU1ER1BVX0ZXX1NIQVJFRF9GTEFHXzBfVU5JRklFRF9RVUVV
RSk7PG86cD48L286cD48L3ByZT4NCjxwcmU+ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBmd19zaGFyZWQtJmd0O3NxLmlzX2VuYWJsZWQgPSAxOzxvOnA+PC9vOnA+
PC9wcmU+DQo8cHJlPiA8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGZ3X3NoYXJlZC0mZ3Q7cHJlc2VudF9mbGFnXzAgfD0g
Y3B1X3RvX2xlMzIoQU1ER1BVX1ZDTl9TTVVfRFBNX0lOVEVSRkFDRV9GTEFHKTs8bzpwPjwvbzpw
PjwvcHJlPg0KPHByZT4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGZ3X3NoYXJlZC0mZ3Q7c211X2RwbV9pbnRlcmZhY2Uuc211X2ludGVyZmFjZV90eXBlID0gKGFk
ZXYtJmd0O2ZsYWdzICZhbXA7IEFNRF9JU19BUFUpID88bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBBTURHUFVf
VkNOX1NNVV9EUE1fSU5URVJGQUNFX0FQVSA6IEFNREdQVV9WQ05fU01VX0RQTV9JTlRFUkZBQ0Vf
REdQVTs8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4rPG86cD48L286cD48L3ByZT4NCjxwcmU+ICZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYW1kZ3B1X3ZjbmZ3
X2xvZyk8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4gJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBhbWRncHVfdmNuX2Z3bG9nX2luaXQoJmFtcDthZGV2LSZn
dDt2Y24uaW5zdFtpXSk7PG86cD48L286cD48L3ByZT4NCjxwcmU+IDxvOnA+PC9vOnA+PC9wcmU+
DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_SJ0PR12MB8165000182B53F6E1E9F4FA58077ASJ0PR12MB8165namp_--
