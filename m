Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C057C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 12:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D455C10E0CD;
	Wed, 16 Apr 2025 12:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tM/tr1RX";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC3A10E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 12:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txA5gJ4g/PJbpA82pjo7XSIXJa+Ee27CCo1ZDvrcr3qtYinrTKf32MeRhgtRSuP2q1U6GZWFxes6YzlwH35y5JwvXmlzW67bbw9ytVH9rFmZLw6UM2DR8uLsEpTJSjMqwvv9NGplgYqIgFnnHXoRp5XTeLXZX70/hCErO971tfL7sAUUb04YPrKsCLzuMgn0M13HwH7YCctpuXnKvBmfMVj1nMAKF/q4XvrU4tfvzfaH0rDJIyXTcibQU48KiZEJZ1uovSK4xvjkkhoYYXu1+GCD8a1FrKNkX2Cm4PrPCqAXWjpIEiRe4xiOXQY1WdQTnYMqOzmCZmy0Xb0snBgDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fSpFPcrQ2HiwD6pQlLdMWinhhArszNPt0tE9u17et4=;
 b=iqSZwBd3eCrye280keIASR6ejvffPOweGZWxvG4Bs8ScTNNB9wNZvQTjswcdywYgh9rAVYT08vuy7SbnjXUQfb5VmwnH63lJGPXSzvrRvAiB2quq3vMrI1XeXnad+6NaMphxD299sbEpEaNI3NBNK7hqbWTD/uACT3VE0kOFVOEyxtDNCiTiiPd7fwlIOI3E77rW7KnE5XyXqHtciJ9Bvylu9B7VJTr2WaP0ZuPinmQuaDUpGF4Pi2QUmcZIaSso7mzliZtfkLEmL4xoaX/7HthNn2Oq249una2VNJArGEjUUpFjlvM02RLgWPhTIrt4stjNdO1E9DCk3I6HDGd4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fSpFPcrQ2HiwD6pQlLdMWinhhArszNPt0tE9u17et4=;
 b=tM/tr1RXR87RKLZt4F9c1wWHxKkUumHnaTQjeKXyT8QlM72VIeVCoU4leMDnd7SAZkP35kuS4+7Jc4kf5GQnw/Py5fvK1zjqiHvPfogs+sWn1lyXSByX1LeVzuEnmj7iKmITxeYxwa1OerrY6yuw3W5CWYi05F6Aa1ViKYW14fE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Wed, 16 Apr
 2025 12:54:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 12:54:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add the evf attached gem obj resv dump
Thread-Topic: [PATCH 1/4] drm/amdgpu: add the evf attached gem obj resv dump
Thread-Index: AQHbrqykV5wj6NKb4ECVQCr9NEKo8LOmIG8AgAAelFA=
Date: Wed, 16 Apr 2025 12:54:03 +0000
Message-ID: <DS7PR12MB6005B33759751C890186369CFBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <0ce0c2ef-f6d1-4d44-9d6e-ece14d17de45@amd.com>
In-Reply-To: <0ce0c2ef-f6d1-4d44-9d6e-ece14d17de45@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c15f191c-61de-4016-868d-b4a2bd608aa2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-16T12:51:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN0PR12MB5785:EE_
x-ms-office365-filtering-correlation-id: bd21fb6b-99d6-4127-58e6-08dd7ce5c419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MXBjTXg2S2xyRFVobGgxV0pNbjd1WWI1NmM2VCsxdUJrOGxQdTI2VnVSSFB3?=
 =?utf-8?B?R0svVVhYcFlhcy9kS2c3RUZSWGtmeW54T3hBRjdHM01KYlNqdDdZRTFvTUdB?=
 =?utf-8?B?WTkvazUxZVZlVEFKMUtRNFRUNk9BVGY5TVMyQmpWaXpMb3ZNN3lwVVNvUklk?=
 =?utf-8?B?UzV0T1Z5eUNNelRlNDJnd3dEcnNvMTVWSEJuamEyVW1EQVRKQkRZc0ROS29a?=
 =?utf-8?B?RUVvQjZxVUtibk9WTlVMVWZLVWViMmxmd1hTWThBcmJCQ3BKUzN3RkZQMXRV?=
 =?utf-8?B?NGk5MFkxRktpelRRbUptQ0N4VGQ0bVlEaUVJUnVzKzBJWWVRUkcxVjIycWIv?=
 =?utf-8?B?QnV5Y2dXUzh6WGw0TnlqSFRHTnVBOVROUVZOYkZySlZ0S2FiNFgrTlJKeGd6?=
 =?utf-8?B?Y21HdkpIWlE4bFpiaUk4WnZDb1V6OXZ4WnFGS25kWVd6S1dNa3Zkc1ZLcENQ?=
 =?utf-8?B?QjBmaE1JMG45SERTeUNkYUdxT0JmK202em50Sm5RWWRCRXI0N3F2QkJkUUc0?=
 =?utf-8?B?NWNTbDRxSmV0NjBTM0xmM0hiL2t3TTFCL1NpRUc1ZmJlemc0RHQ4UFlyc1Zx?=
 =?utf-8?B?eTdYSXBHbU1KamVHRlpnTHU1aWl3V2ZabEdvanh0c3hQeEtEUFlkaTJzbXFs?=
 =?utf-8?B?ZUovc01GYUhsZlh0eE9qTmZBeUVScGllMUUwSW9YcWlaamNsZFFoSTZlTEdu?=
 =?utf-8?B?V3BpMTlXbXFad1JNWk1vRjAyOElzQzJSeWRiL1JwMnVmbXMySW05MERmNXVu?=
 =?utf-8?B?azFua0U2QTFIcHROdlBzNEovdk1ycGppeGh4ZTBWQ2dnMS91TzF4YmVTdzJK?=
 =?utf-8?B?MkVTSGtoZ1lTWnp6QmtjS2I4VERXTlN6ZFJIZDl5d3pDb1lIUXpOdVpZT2hr?=
 =?utf-8?B?SlFobWN3VEEzVjNVRVhxYmJGQTlnNm9HdEhvaGRLdlhtV09HVmNacERLNVlh?=
 =?utf-8?B?VGw2QlRUZjRvejFsSTlZSVlPOGVSNzhBMUtuSVdSa2dITmZ3SEt5VEovbVRU?=
 =?utf-8?B?cjQ0cXkxNWNpb0hHUm1aV29GUTNBdzRsRlJodGgvNm5KWE5ZNWYycEtiWktv?=
 =?utf-8?B?aUZ6QTFEWEd1N1lyQnVmSzgxYVFSeXlJR0FiK2xWaGxSRHFzSWMweWxwN1pk?=
 =?utf-8?B?ZnBCQmJCcHdqTk54WHgyYzFUMFFqdlFXMC9QNmRXWHJvbkc4WEk4Qlhwb3Q5?=
 =?utf-8?B?RWZUN0p2dXo1bnhISW9KdkE3RG9BcGFtRURJekFldlp0dHFpVnQ3NEZMRnVt?=
 =?utf-8?B?R3dKT1FtczVYNUZONzM0cHJGVllvQUFQcFpzK2xSNnprYURRWW53ZHEwVFZo?=
 =?utf-8?B?Z0VUSE5wSXRJdkFYT2NUd2lHY0Yxd2dIUTZ2c2dCUlVDMWJIT3VsZE9UTHZQ?=
 =?utf-8?B?cm1qZ003MkRXbGlKT1VaWGFlTWtsZnpiMVdkUUhwbFZXNDA5UDNyalI3RTMv?=
 =?utf-8?B?LzJ5d0NyWjlSQXM1dExaa0JkY0Y4OHFoV20vTFQyMDIyN1BBejZ2dDZPUU1l?=
 =?utf-8?B?R3RxNjJJT2hSbXNWbHY3dTQ5TE0rQjA5bkFDNktpdmxxQTZwQXNsQXdvTTBl?=
 =?utf-8?B?TUNoS21UNHk2UnJqVXoxRFBjeGdMendMaVR3VTBmaEFOdldFWGI2WlZmdEJm?=
 =?utf-8?B?RkFGMGlmMzZjeVM2QUlBNUFwR1I1VWhRaXdsemo3dnlpa2RrRE5TUjdpQkoy?=
 =?utf-8?B?b0NnOGFhNFMzZDlRZjcyRjE5YzdNUkg1MklWaGhRL1pCcHFwUGVtclp0cU4v?=
 =?utf-8?B?WHBrSUo0angvQ1lOZE1tT1NiUW1JVXc5ZzhwRThjSGluMzZpTEJ1L3Zqdlhv?=
 =?utf-8?B?VHcwNTFjU2J1dWVmNzhSNFJxMlRkdExlbXRnenc1ai9GSjQ2aUY0RjBpanFL?=
 =?utf-8?B?Qk9DdlA1djhPM1M4Mi8zdFZ5V0ZoK0JMSGhXaklELzJYZ3hpTkNaNWcwNkdj?=
 =?utf-8?B?amJndjVvdXV3MWtJU3J4MUQ5UVZQVTV1TGZiSXh3K2RRdGVubEUzRHl6cytx?=
 =?utf-8?Q?cIMA0etjjKcKOuQF76AvvUTVf7I3F4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTArdVFZSU9nSDdHNFdyY0dmdjJ2MXJmVSs5RFVPOC9BWWlsejNRWWVqS3Jx?=
 =?utf-8?B?WnpxZ2YrbnphWEVvZFlvWlZ2d1lQS0lCMTh4RDY1SG4rWXJXYWx6Y1JGWkRq?=
 =?utf-8?B?UkRqdHpBVkM0aWs0SkU3MmNqdVpMQ2JyRW9wSzd5NzRPUFFLNDVESjdwSHhk?=
 =?utf-8?B?b2JodGdyWnZRblVUT1VIU1JybGVaNUJpek9pa1JYeUJSZVlvSFFyRkF6dmhY?=
 =?utf-8?B?TWt5VWNPMEQzZGhINzU3b0lKTUtkZlQ4a3NRR0xadWViVUdkdjVVeWtUR2w0?=
 =?utf-8?B?Rmg2OEREUndEcDFzbVNXdnNwYkFGUXRvYUR3THF2V2ZwdU5ObVBLOGtxRUdE?=
 =?utf-8?B?dWVjeTRVdmVzbmExaWwrdHJKcmE4SXpmRzFDN1BJNURqejdiYTlaN2VsdWRL?=
 =?utf-8?B?Uk5YNzhGRGJlV09jL1RhaU9KVFhlckMrMTNzMDdNVytCaGRKTVJBbVlDWWpP?=
 =?utf-8?B?RjVGMnVhenlMQ0wxakxjUWViUDg0cTZXS1RSWFp0T3ByY2pUZDhnNnNrSUpE?=
 =?utf-8?B?R0pZYU1iSlZiNHozQ0tDbWd6UitqMmkraHhzbFpvcWFqMlJPbjBzOEZaVVRN?=
 =?utf-8?B?dUYzd25MZHB2cTJNN094Y1c2RWZvbVR1Q25HeVlJWjA3bDd2ckdzN2Vpd2NU?=
 =?utf-8?B?NFdPMGhUQmd0ckhiL096MS9LSjlmVFJPT2MrV2xETXlUL1VubGdybC9iRkEr?=
 =?utf-8?B?Z2NGQ0JQQnhpWlByTGZ1YmhtYjJGUE1GL0drLzhFVHZMR0Nha0RxWGFHZkVB?=
 =?utf-8?B?eW44U2lqSlROL1pXOUs1RlNiR0RqajRmb2J3UUMzUFVNQVVYZHpkMHFScHlC?=
 =?utf-8?B?SGJTd3o3UmVXaUt3eFdIcEJWZ2FkN0d0VjZ3YnJWVWdXZXRzYVNzWWRwaTRD?=
 =?utf-8?B?UmZyTTJ4bWJIeVZEUVhPcXVDZTQxdmlTa0R5bGg1RXpnd0NWcTNidFJ0QlZP?=
 =?utf-8?B?RmNkbkJnRUZieEtDN0NoMWR1THNJamkyMWtTNHRtbEptZlBVeVdMVCt3eTRp?=
 =?utf-8?B?dUIvUVVPRHl2NEJZNFhhV2ZVcUI5NTJlR1ZaUmlPMVh6UFBWbW94L0ZHeC9h?=
 =?utf-8?B?YjJNUmlMWklkUEtBK2VocjE5WVZ2YklLUjh5dUZBendhK3R6cytOeG54MmJ4?=
 =?utf-8?B?NEJaeG9YanRwQ0htK3JEVW9UcXhEaXMyQ1IxK2lkQlI2dVJFY0w4TDZTMlJJ?=
 =?utf-8?B?NVM2TW42Yzc1QlBEVU5wMFJWcEVzblJxY3czU0hZQmg0MmdIUWpDd3lwQzZr?=
 =?utf-8?B?aXRxVTk0QkRSZnh2U00zMEl0bTNDUlprZzRMZzFlUHBUK3R1RVpkMExuZHZY?=
 =?utf-8?B?aFhrbzlwdzdFWU9PeWlrclc0Q282VUhYSGhCcVQ2TVR4WlpoQ08vYms4RGov?=
 =?utf-8?B?cHVIajRQWml4MzZGSXYxdXJCKytjQ25HeStWOENvNDBqcWFsOGF5MGtLT1pq?=
 =?utf-8?B?M3VlemU2RVdVZndoNDViVWhPZVFURXk1WkloQjlIWUVFeWhnc0tzSnk3VG44?=
 =?utf-8?B?S0FQZjUwYkdXdk9zbkI4cDRXc3l1NDcrVVNsSG5hQWxIRG5iR1dtWlBrbkJv?=
 =?utf-8?B?MHZpSG5ORUdWcmVZVGh4anpWdHRralE2NmpVa1VEeFdKdkw1WFpLODJsOWZ2?=
 =?utf-8?B?dDh0VWNGc2lpNjROVUN0R1d6VnY2VGE1c1ZZak0wekxob0lHR2dYN2QySzFC?=
 =?utf-8?B?em1DV3pMWGpKQWJYMFFCczVZTWxOYzYvTDNwZWdWR016N1ZOQ3h0SzhRaVNz?=
 =?utf-8?B?cGhRTWVOOFZpQ0J2dnIvVVh3UTlYUU03RHA5Y0Q4ck80c05pRlhCZUVINlha?=
 =?utf-8?B?VTdZVm1lRFltTUJvR29BemNXU1FLcmJjaDhaMndpbXVZbEZGUnRvaVMvTExR?=
 =?utf-8?B?by9xa1NKWk9maTF4WHRrcW8vMUlaTmFQQ0VQZlRmZjVXS2F0UmdMRHA0aTVR?=
 =?utf-8?B?OElOYk5VN0syU0xPZnJIa1o5WlBDRCtGOTRJWmxVb3pZSlZ5dHQzR3MyTWF6?=
 =?utf-8?B?OXJ6R0hYeUNkeHR1U2NuNUw0MzREVFZWeUFsYVgxZS9FV1BJcDVSSzJXbFRv?=
 =?utf-8?B?Vlhrb21vSjlOTEFITFRNell5bTJVTzFCY0ZFQXFhZE1SRC9HSkJBeDlkYzhH?=
 =?utf-8?Q?w/oU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd21fb6b-99d6-4127-58e6-08dd7ce5c419
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 12:54:03.5430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRzPZoHdY+79VmTM5Xz30CEJ7RVz9yMz1K9tamrsy+1ePspDcrzEJSXwEcwEcUcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDc6MDEgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkcm0vYW1kZ3B1OiBhZGQgdGhlIGV2
ZiBhdHRhY2hlZCBnZW0gb2JqIHJlc3YgZHVtcA0KPg0KPiBBbSAxNi4wNC4yNSB1bSAxMDo1MCBz
Y2hyaWViIFByaWtlIExpYW5nOg0KPiA+IFRoaXMgZGVidWcgZHVtcCB3aWxsIGhlbHAgb24gZGVi
dWdnaW5nIHRoZSBldmYgYXR0YWNoZWQgZ2VtIG9iaiBmZW5jZQ0KPiA+IHJlbGF0ZWQgaXNzdWUu
DQo+DQo+IFRoYXQgbG9va3MgbGlrZSBvdmVya2lsbCB0byBtZSBhbmQgd2lsbCBqdXN0IG1hc3Np
dmVseSBzcGFtIHRoZSBkZWJ1ZyBsb2cuDQo+DQo+IENocmlzdGlhbi4NCj4NCkhvdyBhYm91dCBw
dXR0aW5nIHRoZSBldmYgYXR0YWNoZWQgcmVzdiBvYmogZHVtcCBpbiBhIHRyYWNlIHBvaW50Pw0K
DQpUaGFua3MsDQpQcmlrZQ0KDQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtl
LkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgICAgICAgICB8ICA2ICsrKysrLQ0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZp
Y3Rpb25fZmVuY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2
aWN0aW9uX2ZlbmNlLmMNCj4gPiBpbmRleCAwMDc1NDY5NTUwYjAuLjcwMzBkNzIxMTk2YiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25f
ZmVuY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmlj
dGlvbl9mZW5jZS5jDQo+ID4gQEAgLTg2LDYgKzg2LDE5IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5j
ZV9yZXBsYWNlX2ZlbmNlKHN0cnVjdA0KPiBhbWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyICpldmZf
bWdyLA0KPiA+ICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAg
IERSTV9FUlJPUigiRmFpbGVkIHRvIGF0dGNoIG5ldyBldmljdGlvbiBmZW5jZVxuIik7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfZXJyOw0KPiA+ICsgICAgICAgICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZG1hX3Jlc3ZfaXRlciBjdXJzb3I7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgIHN0YXRpYyBjb25zdCBjaGFyICp1c2FnZVtdID0geyAia2VybmVs
IiwgIndyaXRlIiwgInJlYWQiLA0KPiA+ICsiYm9va2tlZXAiIH07DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgZG1hX3Jlc3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNvciwgb2JqLT5yZXN2
LA0KPiBETUFfUkVTVl9VU0FHRV9SRUFELCBmZW5jZSkgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICBEUk1fREVCVUcoImFmdGVyIGF0dGFjaCBldmYgdGhlIHJlc3YgZHVtcA0KPiB1
c2FnZTolc1xuIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJh
ZnRlciBhdHRhY2ggZXZmIG5hbWU6JXMgdGltZWxpbmUNCj4gbmFtZTolcyBzZXE6JWxsZCAlc3Np
bmduZWRcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXNhZ2Vb
ZG1hX3Jlc3ZfaXRlcl91c2FnZSgmY3Vyc29yKV0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZmVuY2UtPm9wcy0+Z2V0X2RyaXZlcl9uYW1lKGZlbmNlKSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZW5jZS0+b3BzLT5nZXRfdGltZWxp
bmVfbmFtZShmZW5jZSksDQo+IGZlbmNlLT5zZXFubywNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZmVuY2UpID8gIiIgOiAidW4i
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICB9DQo+ID4gICAg
IH0NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYw0KPiA+IGluZGV4IGQwOWRiMDUyZTI4Mi4uMWU3M2NlMzBkNGQ3IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+IEBAIC0xNjc1
LDcgKzE2NzUsMTEgQEAgdTY0IGFtZGdwdV9ib19wcmludF9pbmZvKGludCBpZCwgc3RydWN0IGFt
ZGdwdV9ibw0KPiAqYm8sIHN0cnVjdCBzZXFfZmlsZSAqbSkNCj4gPiAgICAgYW1kZ3B1X2JvX3By
aW50X2ZsYWcobSwgYm8sIFZSQU1fQ09OVElHVU9VUyk7DQo+ID4gICAgIGFtZGdwdV9ib19wcmlu
dF9mbGFnKG0sIGJvLCBWTV9BTFdBWVNfVkFMSUQpOw0KPiA+ICAgICBhbWRncHVfYm9fcHJpbnRf
ZmxhZyhtLCBibywgRVhQTElDSVRfU1lOQyk7DQo+ID4gLQ0KPiA+ICsgICAvKiBBZGQgdGhlIGdl
bSBvYmogcmVzdiBmZW5jZSBkdW1wKi8NCj4gPiArICAgaWYgKGRtYV9yZXN2X3RyeWxvY2soYm8t
PnRiby5iYXNlLnJlc3YpKSB7DQo+ID4gKyAgICAgICAgICAgZG1hX3Jlc3ZfZGVzY3JpYmUoYm8t
PnRiby5iYXNlLnJlc3YsIG0pOw0KPiA+ICsgICAgICAgICAgIGRtYV9yZXN2X3VubG9jayhiby0+
dGJvLmJhc2UucmVzdik7DQo+ID4gKyAgIH0NCj4gPiAgICAgc2VxX3B1dHMobSwgIlxuIik7DQo+
ID4NCj4gPiAgICAgcmV0dXJuIHNpemU7DQoNCg==
