Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843DCE8D79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 19:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1436C10E25B;
	Fri, 14 Nov 2025 19:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chFTa1g7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC4A10E25B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4HT6zqnNDRuAr++QHVPNGxH/C0V2TR0WTPAii69zb3si0aheIMeLmL2d59UDU/R/9zWC0zlftpiR0Eccmpi743oLWADVIUm5Dk3ZCslwEyTpnxDWRxf0b1QjMykgttkeysRItGnFWJHQSsOCupNOa0Ti3AMpYaFJtgZMblKBsEuN923hXBQiYCQZhHHeVNPTnvnObJs3dNT7r8gHur5ZvdBvC+/CUroBRVMxS6CY0OfsR1Zq02sF3iA0jMyGrphPU8vJ3EfcxqLi9r2qIdYRU4CRiLtkRiB8DCEwkaDN76Htr/YKn4XxonFnNGUngYng8GD5UdqHQbT6aMUylMJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXsNGCwkxH/GEFY9TITTyZgKZMQkt2uE5xsDfUhob3E=;
 b=FEQX5+Z6BoJYJJxnJuZjC83bDJat7UV4ZhMR/2f2kgOn534af0aogJ7ji/6IF/aC78o3Y9LUcdkyeabnAso6mFigql++UfKhORKLFuNKrEmJs20LuxZ+h8y/kc6DBTYwOS9I5OBgmdc0ohxI0TLxfuDoLNsju+CwNjaG+KJmG9TKYNy6lAxUA+t3D+sd8EufPXcie3C2JATTX4shitE510HJtY1gOaRfuwNoMcYpLAZdmSph1JHWGSEoCrcKIC8UGtmL+IwUobYE12NH8mrHqK4tx+K8AQVOnoluRoxun3VhXOorRB65D7QzFc1Tc90PZ+Z4syK46I9iSvr7j6Q5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXsNGCwkxH/GEFY9TITTyZgKZMQkt2uE5xsDfUhob3E=;
 b=chFTa1g7r/yzXqwD+SKWrebidHvGpHT/gAwdt4YoTXn3RGPyCTFDSlW0ghi79b4gkrUTs1iilbBWtJ4e1wL63eD6MUhWPnGOvLE2355OHk9cznKa+tVer8GMjRnPEz8eHwC11LeCgOlWoaIRlkrj8Mm6elzO8SMo8zqpT8vXU58=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 19:13:28 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 19:13:27 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Chen, Michael"
 <Michael.Chen@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for uni_mes
Thread-Topic: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for
 uni_mes
Thread-Index: AQHcVMjMANo0J83o8k6kXL7SCiVlk7TyQCoAgABLlAA=
Date: Fri, 14 Nov 2025 19:13:27 +0000
Message-ID: <CH0PR12MB5372DCADA03CC06170500CCBF4CAA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20251113180853.225907-1-michael.chen@amd.com>
 <CADnq5_MkNX=VBNkSv3T253_To=Piitm0NTxKCseZz7J7AZFTEw@mail.gmail.com>
In-Reply-To: <CADnq5_MkNX=VBNkSv3T253_To=Piitm0NTxKCseZz7J7AZFTEw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-14T19:12:45.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH7PR12MB7140:EE_
x-ms-office365-filtering-correlation-id: aa8a9cd3-716c-4a64-97f5-08de23b1e418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cFBKL0FJdktVS056NndWRkNYeWJETjdlMkxLemtNdnJaZ2R1Uy9zZE5Sc1dr?=
 =?utf-8?B?ZWFtR2ZDVWRpZFhKUHRVOFc5ZGl0Z09WN2VxRzVXOWVVejZ5NXBNOGgwdTZG?=
 =?utf-8?B?NEtEUnk1STV0bGVsTHpVbEt4anJ3eG9mNmhNRGU5b041b3Flb093MlRNRnZE?=
 =?utf-8?B?VnBtcHcvWW5nTTByWmtpc1Q4SzRqelVsWDlIUUF2ZngvYUdFUkw5TExjQWx1?=
 =?utf-8?B?QkpqbjlBa1ZXTVhxcEpoMm5xU1JrRmRQS2RWWFFTUUtOd0JyTzg1S0RHczNz?=
 =?utf-8?B?SmlxOGp0UEZFa1NSNzZ2a01BVEduQ2NxU1dQM3N4T01keG95a2hKQkpQMEpU?=
 =?utf-8?B?QlJDQXVzN3hxUitSVWdPMER1V3NaVlFZNVNXTWR3d0JseDJIRUZNeWVsVmlS?=
 =?utf-8?B?N2d4RFF3M0ZxNFBUbmJtQnBNM2VidWtvRnN2RWpRdEhKN3VaZm1wOUJ2N2dP?=
 =?utf-8?B?QnFaQmVBS1hkQjhaREZrcHFXQTlVeXFzY1RDSWh4QzN5eVd3RTZ1TmFUVXFP?=
 =?utf-8?B?Qmp0MDVBMjgrRmhKWkEvLzJlMFVuWWNYQmJ3SnhQWWFJT1FwRk44VTY5Q1Fu?=
 =?utf-8?B?dUFGWVk4VlMrWkExWmZ1Rlc4UHlkZjRwOWphdUUxUHR6bmppejdtVXE3WHVN?=
 =?utf-8?B?QnpvdjZzem9QRnFXREM3NlQ3R1RKVlkveVdYb25zdVNSSmtuT0FBdGU1ZEYx?=
 =?utf-8?B?alJYaFFEb29oS09nbXh5ZzNkOHU3dmR2VVhqTjVVbGNKQTJ3dk5VbHErVDVF?=
 =?utf-8?B?N0tWd0R1SHFTVFVGSHMwbDc0OStiRTA1VnBreXl6L3FvNmxnQ0JSL29LaHZC?=
 =?utf-8?B?Q0VLWUIwVVZnTmIxSXFDdzRsZlBlME5od2RvbE8zVUF5MkNGTTYxREJsQVR6?=
 =?utf-8?B?TkpBNDJtTmlWSFlnNXFmZ0xTSHlWK3hWZHFueEJXUC9EQldJSVZpb1U5SEZC?=
 =?utf-8?B?MDlhaTdROHNxMGFXb3dKWGMvVnFlMnB0cFlJaDZEZzczc1ZKMER2ZEJON2xu?=
 =?utf-8?B?K3IyZmNpb1JXQnNjWVlnbUgrWVRJeFRBblpBU2IrSVVPRlNOTTBWWEV2NUVH?=
 =?utf-8?B?b0VkYXZFNHVKVEkrR3hrMk1CemRSMVBxdENGaURVSzdWSW90WGlkQ21QVXA0?=
 =?utf-8?B?VDU4cmhlemVCTGxUM1Nxdy95SXlabk9Vb1NaZ1B5eE9YNzM5YXk0eitWNmE4?=
 =?utf-8?B?V0NNWms5VDFJWUx6S2c0UXU2UEs2VmVWRlZnL0N6clhhdXN6MzI0eUhFTE5s?=
 =?utf-8?B?WU14dWVQVXlSV1hmejZrbVR6TG5PdVE2WnRaYnM4QU1xZ3kybUhwZGsyc09Y?=
 =?utf-8?B?MGxkVDBmb2J1TGh1b3BVMXFPN0R2OUxxd09SbjhYdGdicEV6OEJ3cFJoR3dG?=
 =?utf-8?B?TWovUG1hcEZMMmRWelFmWDNDRnhUUy9kT3Vsa0tuYzZBQWZFclh1U1hmUHB5?=
 =?utf-8?B?ZEVueUY5YXcxQkNiRk9nbGVDWW9nREpxalh5ZEtwcVVpeWl4dk9PRmhabDFj?=
 =?utf-8?B?NVVQcmxUeUw2SDIwOVRTSkdHOEsxTElIY255dlhWNWFxNjJvbitIdlgxMERj?=
 =?utf-8?B?Q2ZmSm04ODZhK0RqYTdRcUUrdlN5OVdEQ2tjQjNqMzU1RDFaR09mY0RraUFw?=
 =?utf-8?B?dWYycWt3Q2s2MGU2L3Vxbzc4UFI3aTM3a0E4VDc4Rk1lcUtwSlJwMUFyaTJG?=
 =?utf-8?B?czJQeUdleFZVRW1uOWN2TTlCa0MzdXk1S3IvVGVTeVpxeEFXK004R1c3cVJa?=
 =?utf-8?B?ZW9wVU8zdXNEL2JFcktwMXpaaXRFcDIwMERjL1FucG5LYloxVmZuQnBwVWcr?=
 =?utf-8?B?Vi92QXhNTnVqMjlLTmVjVC81TDVOYTdBSHdUUDE0ZWpZZTlpV2xrTWRQcm0r?=
 =?utf-8?B?SzlQcjZNd0NGWkp4TExmT3ZMbDIvTmlBQlowVWNHOHZZM0FwTm1QbVJLSHk0?=
 =?utf-8?B?QkpiY2xDQTgzUlNJSnpuN0xDcUtpWGxLWDY3eW8ralBEZkZwL3lHZi9yK2do?=
 =?utf-8?B?V3VGMEp3cmtaM3B5MGRPL0pUQlZpL3pYWm9FbkJpYVZ2dXFMaDBYNGJ2NWdh?=
 =?utf-8?Q?BJLvrT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWpDYkFYOUlva2FmQzJ3UEVISVp0VXVLdmJlbFQvU0RWSzZjZUFmK01GUFht?=
 =?utf-8?B?NDdPRzhWZ29IRWpKNlVhenU2SW8xcG1XVFhVdWUzeUVzTmN3RHdzT2xoK1ZY?=
 =?utf-8?B?WXVBRlcwR0t4c0JZcU5LUGVwemFqWWZOaHdUQTFaT0hSVUtYTVBpQUJFd1VR?=
 =?utf-8?B?RVdmMWpXOFl3R1dDdUlwRXNGYUl3cUh1ODFyMEpjWHh5ZHNGWW40bzBwallE?=
 =?utf-8?B?RlQyUmFIdzRUN0kwaVRrcm1yWEpza1I2Vzl3dXpuOEFwTVVDcTZlUm9URFFY?=
 =?utf-8?B?a3FYQzBqMnhaZkdnK1d5Y3diZW1iRG00UWg0bGpCSmY0RmtETXo4aU5mNGpw?=
 =?utf-8?B?MUpYck1TOXBpSmd6SFZiK241TUUySGtsZ2cxM0tydmsvc0NUczhkckpJVFVV?=
 =?utf-8?B?UE45bU1jMEUwWHZnSUN3dzVFVHVnbC9WbXNjZEtmcUdiWDlrRW1aTDNXVTlj?=
 =?utf-8?B?NGF3OVZ0QkFQdUw1a3VqN0Fmc0JoeW16SkIzV2drV3lubHMrRU4xVUVCOGlC?=
 =?utf-8?B?R3Myd2F1ck55aUU4QXJlY1AyOU12SVNDNzMxWEVrUjlld3ZVZjJxQTY4eG5i?=
 =?utf-8?B?eDROSnYzZ0VucDcrL0FsMnlSWVdIdDdVc0w4YnBuYUczQmk5SXJSSEdHMlVO?=
 =?utf-8?B?RVg3RUVRQTdNREtvYmlHa2hBaDFUbStBR1FYRE1GUzNPRzdkSE5oVlB1VkNo?=
 =?utf-8?B?YSt6b1JWT1ZJdlNnalpoU1YyTDZmQnZlTGo1VzdzUWRjbWQ5K0s1RjYzcGRW?=
 =?utf-8?B?bW1lcUlGRVJFRjhsTHZOdVplZC9tSHd6UWs3QXlYeXppZnZzQnpxYUNhRTAw?=
 =?utf-8?B?NUh2T1B5cW4ySm1uSndENzhobVU5cGhHMjVuQVAwcVoxVE5YVTVNcDRIMXQ5?=
 =?utf-8?B?VDlzMGtDdG1PMWhPMUtQZ2hoWGp2eEh0YkRoeXQ5RlRkc1J3amtzQjBLRFRZ?=
 =?utf-8?B?K2FQSTJVN3VmOEpWWHczbkQyekc4ZzNhN0hjdGdEQXpBWnA1WE1BRmhJQjV2?=
 =?utf-8?B?aDR4eG9EbXBmTUdsdzBnNHpjeG5wWms2RUcxL0piMjBPMTVMTGR0ek1mVUFK?=
 =?utf-8?B?dEEvVUh1cDEycU41ZjljcThCbC9QUVY5T0g5NGMzanBNamV4QTdqM0RrSnlN?=
 =?utf-8?B?WW1Ta3RHMTNNNEl5VkMxaHVGQmpaSUFJTHJiS085MTRPekVVQmFCWHEwbFA4?=
 =?utf-8?B?TWJMSDZXSkFRaU1Yam5na3BXRDZtVXJKNzhGZTBqVUpDYkRqeks0WVV2OUJY?=
 =?utf-8?B?ZVpXeHRNQm9RRlZWTGt1UHFEUGdmWTlMSFUwbEFSMUs3V3lCTWVibmx6YnlO?=
 =?utf-8?B?WUxMaFFJSWY0S1Fxc2p5YVQ0NENJY29LRWpvNUMyNTBNWHZLdk5sRHhTdi9v?=
 =?utf-8?B?NmxrYi9uMkJIdE9NKzRHRU5ORXlDZHFaSUVWZXlvNTJ1eTA2MUF2VUVUWFFR?=
 =?utf-8?B?cFY2YWQvaWxkZXpUM1RuNlU3QUdRS21wSTZyVWRTTmtGbmpwNEY0L2M4ZWpa?=
 =?utf-8?B?WDlpMFBWN0ZQcjlKNTBHbDhxQzJRODYreFBueWRxaTkzL0FFV0g3UTcwbFpq?=
 =?utf-8?B?dlZRSUxzQzJDZUw2Y3hOVlFBbTFodStwV3dBZTUvTWhYdTgvV0tIazhZRXVw?=
 =?utf-8?B?aXZhYnNnSmdKOFpFUm9MdmNtaVZ1R0FpdFBQV0tZREZtcjU1MWYyRDFzMnVq?=
 =?utf-8?B?WkVjQjZOdkxvb1VEZEYyNmZGd2p6NnlGcWhZbGJqSlBHYVQ4UXhtZVZpS1da?=
 =?utf-8?B?ZWt6SUlDTmhhZjJhMHg2QmNRT1hTUDRBMXFoWDlsK1Z2ZEhHRnkzaFQ2Y1V6?=
 =?utf-8?B?WkhJeCtRbWpvZzVKOTdhMGJUbnJmdmJtdkgwTFE3VWZMc2tId1dzSXl3di9h?=
 =?utf-8?B?L2lqeW9kNGZDWExWU3JxZ0pVamtRNHF4eEN1ektZWklvRTlmaHRLUGVKYzQ2?=
 =?utf-8?B?WExRd3Jkd0N3Q05nMERHZUlRVDZQcU82SzZYZVBFZFd0c0xTZDA0UVBoT01W?=
 =?utf-8?B?MC9EdGJ4K3dQQXBvNmREQmtacGJnYjZVd0NFcGYyemN3MmdVbWduU2xZYk5p?=
 =?utf-8?B?ZU9EQUc5VURmd29FVDY4YmJJN0EyejJoem9Wck5LM1RBekE4cGUxdjh3WlRX?=
 =?utf-8?Q?rrgQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8a9cd3-716c-4a64-97f5-08de23b1e418
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 19:13:27.5838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uO+9WwRqmIPv4mTxZN+8QMkeR92NV6SqcXi+brHpPHmCiADtdYJF7C6lL7qNQhAbRZq9S5DOZ7TOr/M2mO+SqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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
Cg0KUmV2aWV3ZWQtQnk6IFNoYW95dW4gbGl1IDxTaGFveXVuLmxpdUBhbWQuY29tPg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxNCwgMjAyNSA5OjQyIEFNDQpUbzogQ2hlbiwgTWljaGFlbCA8TWljaGFl
bC5DaGVuQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiByZXNlcnZlIHZtIGludmFsaWRhdGlvbiBlbmdpbmUgZm9y
IHVuaV9tZXMNCg0KT24gVGh1LCBOb3YgMTMsIDIwMjUgYXQgMToxMOKAr1BNIE1pY2hhZWwgQ2hl
biA8bWljaGFlbC5jaGVuQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBSZXNlcnZlIHZtIGludmFsaWRh
dGlvbiBlbmdpbmUgNiB3aGVuIHVuaV9tZXMgZW5hYmxlZC4gSXQgaXMgdXNlZCBpbg0KPiBwcm9j
ZXNzaW5nIHRsYiBmbHVzaCByZXF1ZXN0IGZyb20gaG9zdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBDaGVuIDxtaWNoYWVsLmNoZW5AYW1kLmNvbT4NCg0KQWNrZWQtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMNCj4gaW5kZXggOTdiNTYyYTc5ZWE4Li40ODE0YmUwMjJmMzIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gQEAgLTU5Nyw2ICs1OTcsOSBAQCBp
bnQgYW1kZ3B1X2dtY19hbGxvY2F0ZV92bV9pbnZfZW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KPiAgICAgICAgICAgICAgICAgLyogcmVzZXJ2ZSBlbmdpbmUgNSBmb3IgZmlybXdhcmUg
Ki8NCj4gICAgICAgICAgICAgICAgIGlmIChhZGV2LT5lbmFibGVfbWVzKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICB2bV9pbnZfZW5nc1tpXSAmPSB+KDEgPDwgNSk7DQo+ICsgICAgICAgICAg
ICAgICAvKiByZXNlcnZlIGVuZ2luZSA2IGZvciB1bmkgbWVzICovDQo+ICsgICAgICAgICAgICAg
ICBpZiAoYWRldi0+ZW5hYmxlX3VuaV9tZXMpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHZt
X2ludl9lbmdzW2ldICY9IH4oMSA8PCA2KTsNCj4gICAgICAgICAgICAgICAgIC8qIHJlc2VydmUg
bW1odWIgZW5naW5lIDMgZm9yIGZpcm13YXJlICovDQo+ICAgICAgICAgICAgICAgICBpZiAoYWRl
di0+ZW5hYmxlX3Vtc2NoX21tKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICB2bV9pbnZfZW5n
c1tpXSAmPSB+KDEgPDwgMyk7DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
