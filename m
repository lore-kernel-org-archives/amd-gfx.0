Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720D2C369AB
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 03:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9579510E152;
	Sun, 27 Apr 2025 03:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zUXN+rQ+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5442910E152
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 03:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6zBx+DNtMOg0h8eBMRSHl7p7pQ/oOV+L+wd+S8bNlVdSBk64ScaiC7/jNcZO4GcUVz3rPuOr7ALWecba4Ep3G7XlK0FE/Yo2lO+KzdNDmQl1Dryaibsp1dB18xzxm151rYKJJmRMu/64CfYWlQb2y5/XF3/OQbgb4wK+/0zFANmL7lWl92Nz+hlL5B16Qd4++8XbQDaf1RP/hV5rhOvYJ7VjfxjJy2LP5GaXX/xw6iGit4ifDq953Kuy3Te8tAi63QPBoo1VodpVxP8+yxOMfskw8kJXGe4oVBoJvt3Tb3yaIoQuSejN+N8Vasswq3SylLWhmUiukRog9jhgn+Vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pTTZsWntVUzDBx1msH8EG1jajInFIP4cxaxWEbANBI=;
 b=GNtY60DRvsIP2nbkGcmMig0QhHr7zMIqPMmRtpdfM05b24Kvw6DWDRoA6Z+mtOJW8/x4+OnNjAxt04SBiIO0tiI2MvdMIgdQkKrHUZDf9HNy2RFX1vWCuyaPRFY3OemsAqOoxwnD/PNgF5xS0Z96/v+FzVMN/PErVaNTqTz8xEDwtjST1C0pcIP3+NrNGRzOr/xmQ3yhhmalvpkv260sEJ4X3wz/DrQ+v2wgCb+UWNjNrqN43buskoP1jfTLbcwqGClB6QNxavqZAiafB6K1rLoJ4xuSh/nTad8TsR2RWrwilBRFfiGn7SqMeoAY2IH7C5lYIjE7M5kWD5LwMUQPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pTTZsWntVUzDBx1msH8EG1jajInFIP4cxaxWEbANBI=;
 b=zUXN+rQ+hU0UT1DMrwRTZkutU3vCVuae9uYF2CE8HjgFuEoigp+lErbLVQyEFT8t9dUoV427JnQHrdg1tXxxlRPrTzX4PdqAOKLpKXG/K1fdGjK3IZaPuP8AbV+n2dTWFw3TUfnGBkvVhi0qluounmfC7SzIEr48Gx1Ydxx7dKU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Sun, 27 Apr 2025 03:20:49 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 03:20:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Index: AQHbtbC+ccKGxg3NBU6MKAwb+Y5nY7Oz+dSAgAAFcQCAAtoiUA==
Date: Sun, 27 Apr 2025 03:20:48 +0000
Message-ID: <DS7PR12MB6005A31931084FC36F628C8BFB862@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <b7011f0d-cdda-9318-ddd7-6c36f6581ad9@amd.com>
 <DS7PR12MB60058C12C12F37C34ADE31E5FB842@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60058C12C12F37C34ADE31E5FB842@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d8f7ffc9-2498-4640-b2ca-bd8a7b92e982;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-25T07:40:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB5867:EE_
x-ms-office365-filtering-correlation-id: ae2fe9bf-a7b7-4285-e106-08dd853a81d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?TDEwaE0yWWFrOEpPK043UnB0aFNBaVRJZks1c3hsZlA0Zm5DTm9DcTdJVXht?=
 =?utf-8?B?VGdJdDVENkd5SmM5WGdZZzFrZmxnZ1BKYXE1c0Z1MWM4dERLMzBxekwxMWY5?=
 =?utf-8?B?WGNvM3U2NE1NR0o4OUtyd295dXZFTGxvRURBZXdTSHpVaDVkNG5aOEdxUnhl?=
 =?utf-8?B?UTNIWVJWUFIrTDI1TXFhcXB6alFSbE5CVGk4ZFhJSDYwK2tSVWJkT1BobXY5?=
 =?utf-8?B?NGJRRXQ3dHVEUWpyeHA2aUJnMkRNTGNuVHFISk9zWms4WFJsd1VKWjFOSVlS?=
 =?utf-8?B?UU4ycjVDSmEyemdEVG1Ic3lMSmo1Y0NxNzZSaFo1bVZuNkN4RUtKcUxMeDNO?=
 =?utf-8?B?aWZnRGFLREFnbW85YTJOQTR1VnF3eXd1eFNuN2kyT0k5Z1ltaUIwdXFzYm9y?=
 =?utf-8?B?ZnAzcWVRelFPTkE5L0RFSXFJRXM2SjUrY0FMREFYa3JlUEh3ek03VWtRUnhX?=
 =?utf-8?B?c1dSZDlPNm9TWWh4dzgzV1lEazBZRnZmWEJIYi9pSllmSVB4SG4rVnFJcjdQ?=
 =?utf-8?B?VWU1OXF6RS9ycHBzMFBiVlcxaXJIenBOazN1UzFDK25WalRta2l5SXcwQ3I0?=
 =?utf-8?B?bGpkSmRQdlBWV1E0Q01XOTJxdkhXZVZZOUdZMERLNWJ1dE1BNVEwRnQ1TEJm?=
 =?utf-8?B?YUJrZktiVTFhVjEvTWtCelc5eTYvZWJsYUpjNlIzVzc3c29VdHd2dXpLUHhN?=
 =?utf-8?B?VFVsR2VZQnhrWEdvTlRaZythR1QvdzhwR1YrNmRKbnZvN1ZCVUxGY3UzMkd4?=
 =?utf-8?B?dnNmMVprRU5BN1hjaldZU1lad0VPeE8vZFBXZ3VyYjAvSjVsTS9xM3IxRjZr?=
 =?utf-8?B?NFBjZjRjNkswMnRibFlPNG93TWkvOFhOZ2NBQnhHTVZPQ0xyaGVVQURMemdi?=
 =?utf-8?B?dlprMnQ4U2E3dU5rb2x0T21JWmxRSzVzTEhjRUMrcEg1V0FTdDNnTkJLWjZ3?=
 =?utf-8?B?dVJPNE9JNkNoTHBqSUdkNnYxaENvTCswMGtsNzYzOFI4d3o0UlFGNDJDQ2hZ?=
 =?utf-8?B?Q2RRZU1QQi9mQmxpaThSaWxEa2d2K2dZVnlpREYvY1ZYODg3NnpTZzBVU3pa?=
 =?utf-8?B?ZVdpMTRhQk0vK09LSXRKTHh5ME1vSmthKzBiUHlqZmtDVnFxVUZYQmxpRE9h?=
 =?utf-8?B?OEJ6VjRkQk1HV0dHUzYyR1I0TTgwWnBlZHVkM0tvK2JnM3lwVEluMlBEclJh?=
 =?utf-8?B?U1oxK0Z3YW8wdU1aZlNGOHQzc3kzTmdydmwwY0N2L3FsbnNKdHk0NFFPVkNa?=
 =?utf-8?B?RVVDNXlxRGxNQ0tFTDI1dmlWZnlFYjFHZXpSMzg5cVBCVHo5cVZuQlFOc1d2?=
 =?utf-8?B?eFgxZld2Zys4UlpWbENoNTF1Q2VIREVuc1FJM2lnUkVEVVhHanRRVEFNaFlR?=
 =?utf-8?B?ZXl4cnVrVUYzTWVWbTgxcWZHSFBneVVzRXFPVVRIYkJPa0F4R0JkRnJ0d0pU?=
 =?utf-8?B?OERHYzVrNS85ZUJENGxKWVd1L29ESCs0bDVHOHRRZTJDczc3RU5qcWtFbXlT?=
 =?utf-8?B?UUhRQ2ZOVFNmK204Ym1KbVZsSjcrSnJsdkNqeDhsSnhNYXduZjEvSFV0V2tW?=
 =?utf-8?B?bGtXbGpLUnNCOW91NkFWMCtTZFNKTkhuRVljWjVEMXBHcitrUjUzZEJibkU2?=
 =?utf-8?B?Tjh6dzZ4ZnNkWEdCUE5nUTh3M3RUMVd4VUg5L01jOFhpVy95dFJSSzc2MnBC?=
 =?utf-8?B?YWdBZDNpWTR5NmZOWWp4M3Yrc205WE5sNTlNODFLekYza1pOYkd0WnlBdVF1?=
 =?utf-8?B?UHRqT1ZPQ0svaGoxemJjOWZQNmIrUmRHZUs4d0xYUEx0cDkwajI1S1JHa1BT?=
 =?utf-8?B?MzlGaTF0M0RQdjJaUzM3Q0VTcHI0Uy93K05KdFRPT28yWUJqRkR5U1A0dis3?=
 =?utf-8?B?MFRGWURiNHNxdEJMYkt1TzdwaENmNS9pdUVYSklUWDRocWdNdHJPS00wYVA4?=
 =?utf-8?B?WU5lMWh6a2doS3BpUlZ0Z0dvNmFVVTdOUVM4WmZtd3dkc0oxemtndUlyN0lS?=
 =?utf-8?Q?9yu+zfV0b/0QMx6ft7yHjj/YdLNQpY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjhLaEs5aCtGM1pBRWFDQ2RoOUlpTkxDQ29CaUw3Qnc4Qk1neDdkbjhKNmJD?=
 =?utf-8?B?Y21XVkJOTVRlaW13bXJuTEk1d3c3T0tRcUFEU1k2aFRZUUN1TW5ZQVQwclY1?=
 =?utf-8?B?bCtOa3B0bkp2Szd4czFDczJRZUxsWlZrM2FJYms5R0dYSWJaSFVoV3puUXl6?=
 =?utf-8?B?VHZiQ2hxSVNRUlRCckRtajJEOTNjQUpKZnptN2ZkODJ6UHBXL1RubVdMSWJ0?=
 =?utf-8?B?cmJqMzRhOHJLemE2bUU1UTBsK3dKSU80NmZaTFZLaEw2K0k3UmlFbUFsU3pF?=
 =?utf-8?B?Ukk0YnhZenFtOWc0TzhicWYyeXZpQVlpa0tGLzhMRkYwdHZjMmFyeUQ2VEln?=
 =?utf-8?B?WEtYQlpJNEhiWTgrY01hNDNVWk1SeTMzUExYUldlK052Vm41RkRlWlhpMEVh?=
 =?utf-8?B?UXhxOS9BZ1ZkWW1jcDF2SFAyUUc2WFVIZGVzTGtMeFBTQzBzK3FrWmZiZnZK?=
 =?utf-8?B?TU0zc3A0bE9OOXcvYlN6OWQ2bmJWVFk2eDZsS1NCbjNEYmpwT25UMXZNNnY3?=
 =?utf-8?B?Y3g1dGptVk9SQXVOYmxnN21xdUdPNHI1WmhKOFp6bVdSclNlc3Z5NHRwc3FO?=
 =?utf-8?B?a2lIUDRMVER2UmZ6OG1aZHhSNGlHNmg1UEMwREN6Rno1Y0ZWRXFiYkFqMDJn?=
 =?utf-8?B?aW5XQkd1czN1cUtkRktvOFJ2Tm5WaDQ3ZmtZTWtxN3hmYzBjVFdvajM0SW1r?=
 =?utf-8?B?NFZ5bDl1VGtUK0hmVElJY1dFT1RxbzF0L0RpU041L0s5SklOVHdhemVBNFJK?=
 =?utf-8?B?c1NxR2UvRnMxN1NSNGpRNVBjd3ZScjlrdlhPTHhzOGFoT0w0NkFOYStPV25G?=
 =?utf-8?B?R2R4aTdSRi9HcDJDZnQvSTh4cVNBZjhNTS9paUNJaXBKbkdkR3ZScXhtbytk?=
 =?utf-8?B?TzYvU1BDdVlQbjNmZU1uYXF1VXpwakh3OUxvdElyZ1FzTHlCcHdOM3VLYnFD?=
 =?utf-8?B?S3BQcmVvengxTzU5U3lMbEdkM25OL0QzQ3FocFc4b1VSZTlDUzNzazMyVUdE?=
 =?utf-8?B?RTA4Y2lsMEo5TTNwTHRlbUN6TXlndlE1NGQ5a3AxcW1GTWFvYVY3TkhPSUVs?=
 =?utf-8?B?L1kvcTRMU25jUDV1MHU0cXNNbmN5TGtDUzdxQ0pIalI3a1VvSEtGczFzeURK?=
 =?utf-8?B?RlM3dXNOQ1lsWG9iOTFOWTI1bXcwa3IzKzVQSjJYNmJNdkE1SWhjN2RRcXZG?=
 =?utf-8?B?UUxienZtM1JCOEZaZDdqRFFrLzZSRjliRFp4Zm1YUEhmNE1waVpXTG9mRFFa?=
 =?utf-8?B?dUVrN2JERW9RM1RJTi81NEtaWVREQTk4TnJsRURCQzA4WUlHcTZqNXUraVRt?=
 =?utf-8?B?dzZmMlRtNzJYWERhVFNMSE04cFlwRnpFNEt1WHdtVS9hVnArSEVKdStVQ1Ji?=
 =?utf-8?B?MjRYcTYvUkY3K29XZHNIUUgvdVBnNFR0Z1ZFUTN3amhyUHd3Y1plTmprZFBn?=
 =?utf-8?B?bnFKcXhFYVdSOGxwc3I5MVpCZUNYKy8ySkN0dEpyKy9uL2c1T2lpV0hza2Zu?=
 =?utf-8?B?T3hocXJJTncxVWNmKzVXcVA0eGtvQ0NSMFlYWUNnUUxkT2RnVU9nd1pZZDRN?=
 =?utf-8?B?dkVrMngyZ0QwYlI3VC9XT1RWRUJWOGhLRHgyMXNTdVNZK1REMWlXeGJuVk1N?=
 =?utf-8?B?T3phRFdMajFiYXlJQ2k1SFNnUkhFQVRCUDJCK0tUYjJNNkVJbWo2VG13UjB3?=
 =?utf-8?B?OGc4cGVMckJxZ1I5WS9pL29BL1ZRMXNCalR2czVNVWswOGpIVHNHRFVCQnNX?=
 =?utf-8?B?QklxZWpzRVRvWXdpbDI3SUlpeUdlM1dWQ2xsM0ZzM0hBaGRrb1hxcjFCeS9o?=
 =?utf-8?B?Q0c1cElvL2d2bWhFWXVlYXM1eGdQQTJiTnM2dXVqZEhBY292MFF2LzZSeGZ4?=
 =?utf-8?B?Y1VHVWJZL2VydWJ4N2NZM25ZanREUUR5NkltWUdoM0xlUWNVSmxNbTVONkcr?=
 =?utf-8?B?bG9xUTVrZm9IakdENkkzNXlwamtOMUF2bjVvUThSR0FEVEV6cWxnYU9rWlRq?=
 =?utf-8?B?TzFjWjJIRnJKd2JDUTh4dkg2dC91YXRKRlhKcXk3emZGaWljVEM0eTNhbmZ5?=
 =?utf-8?B?REZZeU14NkhFTDRmcWVPbWZXNkpWb05kWUtmSVJmZExpRE9yWXdONWVaR3VI?=
 =?utf-8?Q?4nVA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2fe9bf-a7b7-4285-e106-08dd853a81d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 03:20:48.8724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iilyl0a4yVRBzNtQ0pLl9UZW8cwG6WkUfKv8DpszXQ/RzuWXFZRXraoNPNjorTBN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

W1B1YmxpY10NCg0KPiBGcm9tOiBMaWFuZywgUHJpa2UNCj4gU2VudDogRnJpZGF5LCBBcHJpbCAy
NSwgMjAyNSAzOjQ0IFBNDQo+IFRvOiBZYWRhdiwgQXJ2aW5kIDxBcnZpbmQuWWFkYXZAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvM10gZHJtL2Ft
ZGdwdTogaW1wbGljaXRseSBzeW5jIHRoZSBkZXBlbmRlbnQgcmVhZCBmZW5jZXMNCj4NCj4gPiBG
cm9tOiBZYWRhdiwgQXJ2aW5kIDxBcnZpbmQuWWFkYXZAYW1kLmNvbT4NCj4gPiBTZW50OiBGcmlk
YXksIEFwcmlsIDI1LCAyMDI1IDM6MjEgUE0NCj4gPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4NCj4gPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBpbXBsaWNpdGx5IHN5bmMgdGhlIGRlcGVuZGVudA0KPiA+
IHJlYWQgZmVuY2VzDQo+ID4NCj4gPiBUaGlzIGlzIHByb2JsZW0gZm9yIFRMQiBmbHVzaC4gV2Ug
c2hvdWxkIG5vdCBkbyB0aGlzIGNoYW5nZXMuIEhlcmUgd2UNCj4gPiBhcmUgdXRpbGl6aW5nIERN
QV9SRVNWX1VTQUdFX0JPT0tLRUVQIGR1ZSB0byB0aGUgVExCIGZsdXNoIGZlbmNlDQo+ID4gYXNz
b2NpYXRlZCB3aXRoIHRoZSBwYWdlIHRhYmxlIChQVCkuIFdlIGFyZSBlbnN1cmluZyB0aGF0IG5v
IHBhZ2UNCj4gPiBkaXJlY3RvcnkgKFBEKSBvciBwYWdlIHRhYmxlIChQVCkgc2hvdWxkIGJlIGZy
ZWUgYmVmb3JlIGZsdXNoIGFuZCB0dG0NCj4gPiBibyByZWxlYXNlIGFuZCBkZWxldGUgYm90aCBh
cmUgYWxzbyB3YWl0aW5nIGZvciBCT09LS0VFUCBmZW5jZS4gUGxlYXNlIGRyb3ANCj4gdGhpcyBj
aGFuZ2VzIGZvciBldmljdGlvbiBmZW5jZS4NCj4gVGhhbmtzIGZvciBzaGFyaW5nIHRoZSBiYWNr
Z3JvdW5kLiBTbywgd2UgbWF5IG5lZWQgdG8gdGVzdCB0aGUgZmVuY2Ugd2hldGhlciBpcw0KPiBh
biBldmljdGlvbiBmZW5jZSBpbiBhbWRncHVfc3luY190ZXN0X2ZlbmNlICgpIGJlZm9yZSBhZGRl
ZCBpdCB0byB0aGUgVk0gc3luYy4NCkl0IGxvb2tzIHRoZSBUTEIgZmx1c2ggZmVuY2Ugb25seSBh
ZGRlZCB0byB0aGUgVk0gQk8gcmVzZXJ2YXRpb24gYW5kIHJlcXVpcmVzIGEgc3luYyBhdCBjb21w
dXRlIFZNLg0KQXMgdG8gdGhlIFZNIHJlc2VydmF0aW9uIHN5bmMgd2hldGhlciBjYW4gcmV0dXJu
IGFuZCBzeW5jIHRvIHRoZSBETUFfUkVTVl9VU0FHRV9SRUFELCBhbmQgSSB3aWxsDQpmdXJ0aGVy
IGNoZWNrIGl0IHNlcGFyYXRlbHkgd2l0aCB0aGUgZXZpY3Rpb24gZmVuY2UgcmVsZWFzZS4gQXMg
dG8gdGhlIGV2aWN0aW9uIGZlbmNlIHN5bmMgcHJvYmxlbSBpc3N1ZSwgSSB3b3VsZCBsaWtlDQp0
byBwdXQgZXhjbHVkZSB0aGUgZXZpY3Rpb24gZmVuY2Ugc3luYyBhdCBhbWRncHVfc3luY190ZXN0
X2ZlbmNlKCkuDQoNClRoYW5rcywNClByaWtlDQo+IFRoYW5rcywNCj4gUHJpa2UNCj4gPiBSZWdh
cmRzLA0KPiA+IH5hcnZpbmQNCj4gPg0KPiA+IE9uIDQvMjUvMjAyNSAxMjozNyBQTSwgUHJpa2Ug
TGlhbmcgd3JvdGU6DQo+ID4gPiBUaGUgZHJpdmVyIGRvZXNuJ3Qgd2FudCB0byBzeW5jIG9uIHRo
ZSBETUFfUkVTVl9VU0FHRV9CT09LS0VFUA0KPiB1c2FnZQ0KPiA+ID4gZmVuY2VzLCBzbyBoZXJl
IG9ubHkgcmV0dXJuIGFuZCBzeW5jIHRoZSBkZXBlbmRlbnQgcmVhZCBmZW5jZXMuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMu
YyB8IDUgKystLS0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfc3luYy5jDQo+ID4gPiBpbmRleCA1NTc2ZWQwYjUwOGYuLjRlMWQzMGVjYjZjYyAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5j
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMN
Cj4gPiA+IEBAIC0yNDksOSArMjQ5LDggQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gPiBzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsDQo+ID4g
Pg0KPiA+ID4gICAgICAgICAgIGlmIChyZXN2ID09IE5VTEwpDQo+ID4gPiAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+IC0NCj4gPiA+IC0gLyogVE9ETzogVXNlIERNQV9S
RVNWX1VTQUdFX1JFQUQgaGVyZSAqLw0KPiA+ID4gLSBkbWFfcmVzdl9mb3JfZWFjaF9mZW5jZSgm
Y3Vyc29yLCByZXN2LA0KPiA+IERNQV9SRVNWX1VTQUdFX0JPT0tLRUVQLCBmKSB7DQo+ID4gPiAr
IC8qT25seSByZXR1cm4gYW5kIHN5bmMgdGhlIGZlbmNlcyBvZiB1c2FnZSA8PQ0KPiA+IERNQV9S
RVNWX1VTQUdFX1JFQUQuKi8NCj4gPiA+ICsgZG1hX3Jlc3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNv
ciwgcmVzdiwgRE1BX1JFU1ZfVVNBR0VfUkVBRCwgZikgew0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgZG1hX2ZlbmNlX2NoYWluX2Zvcl9lYWNoKGYsIGYpIHsNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqdG1wID0gZG1hX2ZlbmNlX2NoYWluX2NvbnRh
aW5lZChmKTsNCj4gPiA+DQo=
