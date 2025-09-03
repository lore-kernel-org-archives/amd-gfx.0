Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DBFCA1010
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 20:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC80E10E936;
	Wed,  3 Sep 2025 20:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RfT2rUSj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80E810E936
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 20:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5VlYm+el5+SML5oqEiFiJSlb6nWnf5qkDm9c2Ug9RqaipYIiZifOc3TA2lxW3Vvvntg9/av3xghY/gcbLy7zV+yftvj8u46nFrmoBjINHfPDs8bKP5ui6hnMaXBhwcJMpWs9DsmytD8VseP956k79Gzh6+Gy5NMoBOmg2PHH/vl2CPRrUmjBSy0tR+xMPcA9RQy7ZV4Kxy6skDeJHaFU+gQn1JjlxE1u8ITMHpZJfBt4vzjn53+jh077czEos8Iv49T5L2CQ/v7/7afd/GYbalxGaTe6fWyQG6zbPj04vDUgGQzvFH+mDHJq8sYhc6zROPVJQQMWDTwwcTEboWkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh0ZsTewqUQHRuX49Z7ozMF0F8UXBIgamZyvmaK61CY=;
 b=gW+X/poyjuq+nHR7r3WAlQNWxKvHjZGSU9DLS/lBqeEuCvRVSahfO7XQXMaD5BLvLJscBF2xW1Pz82yySXZCoqwK6W0PQ+QGmAhnr7VssxYff3Aux2q+Wsr1StiqBcs44LE4p1djCme8ham1swJCMlL38QecSOZkB3IRZKiMPchbbblVx1V2H9JGYHCHlGlddwMDum3wbXGU5teAMufFcMiRqwmwGJ/OaN3GevSlkU2soDtHxWeTQxBdCaTpKtPHvZmGkkO2pbOWjQOSyuGGiAlKMac7KLpKcTqctnvRmumTIwd58XEVuw8MvNoNHixFdWPfG1ISoLQJKfdDcJbcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh0ZsTewqUQHRuX49Z7ozMF0F8UXBIgamZyvmaK61CY=;
 b=RfT2rUSja3kA4E5CVjErVRwvZ3oDT3I7IytD+heAfXbNAvNQz6uyhiMB4tindxBzFAIzfN2+2rYyOTPukfaUS3kfGPxzwC/PVu7NXvGLe5wTSeTRoIohPSIvTMZXwYjfsedZnDJ1dag3aPUykLILKxNH2fwvJLCTu2dgNnX92KU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:37:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:37:15 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin"
 <Bin.Du@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, "Antony, Dominic" <Dominic.Antony@amd.com>, "Jawich, 
 Phil" <Phil.Jawich@amd.com>, "xglooom@gmail.com" <xglooom@gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd/amdgpu: Declare isp firmware binary file
Thread-Topic: [PATCH v2 2/2] drm/amd/amdgpu: Declare isp firmware binary file
Thread-Index: AQHcHRJ0uDU1O88BS0eEemi6nLafkrSB6uoA
Date: Wed, 3 Sep 2025 20:37:14 +0000
Message-ID: <3a6c6254-f511-48d8-ac55-665968520db7@amd.com>
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
 <20250903203601.839525-3-pratap.nirujogi@amd.com>
In-Reply-To: <20250903203601.839525-3-pratap.nirujogi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|LV3PR12MB9215:EE_
x-ms-office365-filtering-correlation-id: 8bafc87c-5ec0-42ba-7a9d-08ddeb29aacc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHJHQjVGNHBzdnZqM1lIcnUvQk9VUWhuaVp6c0o3aFRFYWJydWhhQm9ybjh5?=
 =?utf-8?B?UkM2T2llNjdoeEU5aTlOMHV5c2pwSVlWRjRCVEEzaEcxSXJRdTdGU2dUcUc3?=
 =?utf-8?B?eTRNQlp1bjdWY2xnam14YUs1OVB1SGY2WG9nbW9jTmZpY3BPREVTM21WcVln?=
 =?utf-8?B?SllLYnFVL1IrZThJc1gwQUFYQ3FmVndqTERUdXRGSGVkTkQ1VzFsL1ZkUkZB?=
 =?utf-8?B?YUF0bjJkVmpRYVIvcmVROXh6RTV2WjhVTWpYTkZ6Q3M3OFNPY28rVmlzWngr?=
 =?utf-8?B?NmtvM1NTMlVnWXZDVG9ROW9aQlliMVNIM0w2bmIrcTI0T05hRnBkcGRaUGVS?=
 =?utf-8?B?ZmNadFBvL2F0b2RSM2pqMWxGa2RJYTZqWFVsS3RJSFVValAzclBMdnZzMGxx?=
 =?utf-8?B?L3p3Qld1TVFyQW9IVVlkWEV5NkZUNGM5cnprdm1KdUVGR3V4djFtYlJyaXkw?=
 =?utf-8?B?RXdoK0dWdi8yd2ZPUk42MUR2OWk0ajRNNXNiSk1jQ29xZE1ERGtUekgxMFBy?=
 =?utf-8?B?WFVXUVFPZFhQQlZqSjZ6SzhBcXlXYzhORHBHOEg5SnBMb1ZrdGM2SjZyR01u?=
 =?utf-8?B?c3d0MlJObEhtTlFKWGhOZitaK05YeXZJYzlLTlpxSGFuaHA3a2FGVkNGTzFx?=
 =?utf-8?B?UG9yQU1SdWtZL2VQTnJlamFZSzZ5V2xYd3p2enlhc0Zoc1RGd0RFd21kOGY2?=
 =?utf-8?B?aDdEZkVvYXdheGp2dHAxaHBhdGlBQWpBR0xka1NaR0daWjhZb0JHWUNldUs5?=
 =?utf-8?B?aTN2TExwZkt5ZUJueTUybjNVM0pKV0ZMdWpkd0tSYnlFaWtSY3lDSnRWaExC?=
 =?utf-8?B?RU0zLzVNbmUvZ1hoNDgxWk84V0JpTTF2TGltcElTd1hZZFhCZFZzdEllT2hX?=
 =?utf-8?B?K0pzVXJNVGxIQ05MK2UzSkhJeUlCYmVMNG5aV1dralRhSkw0YUJkaFcyZURy?=
 =?utf-8?B?R0VsZ2FxNS9vUjdwWklUN01hdTM0dEpUMk1FVnN0WGdXNUY2MzlsTGQ5dFBB?=
 =?utf-8?B?b09HelQyd2wzZWN3anljSXg2SVB1YzV0TUs5SUcwcHl2U25LaHRKWnExTE51?=
 =?utf-8?B?RjFrSmN5cVdDbUQ5QjZ4VXZyWU5GbXVzZG0vVEsrZHhjY2RVS2tvREtIblFl?=
 =?utf-8?B?KzBvcDBnWDFCS3RaUWFaOUFqcnJxYkE0RXY0S2ZZVXNNeDFEYVByYkpPTmpo?=
 =?utf-8?B?cWExYjdUbTFLYVRaWHU4V3hKOUw4b0ZTUWtCV2QvalN3ZHhsWm94RzU5S0xp?=
 =?utf-8?B?VmlGZGE3N2dJaHlIeSsySzRiZVBjUUZtdjZITWpZQTJRZnVaTnJVcGQyYUJu?=
 =?utf-8?B?RUY1V05FQldkeUk1UGRuQzhzb2liLzVoSHY5aWdEV1VrdVh4cUpnUzBCblJC?=
 =?utf-8?B?ZnJGV3VlTUh1OTFhajJZYmhMSVFFZmdGTW5XczV2a3BVV1EyTHZsMEZqWlQr?=
 =?utf-8?B?UGJLQUwraTdZZTBPMFpuVmErZEJSSTJxb292Wk5YeWEyMWxHNVMwanVpV1Jk?=
 =?utf-8?B?ZU5NaHZrMGE0bkxYenZOdDlOYllIUVRCVmdsdUV0REtBTW9WdmxSdUdrdTlU?=
 =?utf-8?B?ZGt0U3A3QVpJdG5tM2pMaHIybENGZktmU2pJczZmYXhrUkZXc0Y2V0hSZlBI?=
 =?utf-8?B?NmdsbFBHTCt6RVBDMkN5RVNZMW5seFhneklLWmN6M080M1JvRVdiMTFXdzRU?=
 =?utf-8?B?NlMrNzIwRExFbTd5eE5scmZCNTgwWlZ5elNlcFNpYWdEYVJ1QmtKaVgycVgz?=
 =?utf-8?B?ZjhpWWZYbWNaRnV1ZnVCdmc5UWVlZER5dkV2dlQ3N2ZjcTRyMEFoZWtrYVp5?=
 =?utf-8?B?dVpuQXViS2dWUnNjZVU4ck94RnB3Z2Y4ZjdvTHRHSVR4UnhhdDQyZkpleTU2?=
 =?utf-8?B?L1oyeExRc0pYMlNERE5PcW5PaDFOTmU1Mk5vZTlERTlXQ2JXSkR0TTlrenVP?=
 =?utf-8?B?cnNVekxuTVBmenpXb1VyWXFrS2hZYURoZmJHcnZBYm1rZk5SR0xaOFlFZW9N?=
 =?utf-8?Q?HFbVLl++o3col7WvO3p1C359b/HaKI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNBb3hmWFhreEtFVktRTGdNWVp0UnBMcnZuMU9zZk52RVFhU2ZzcHgyV2VF?=
 =?utf-8?B?QVlIZkp0d0phUjFZOWZvQ1V3R242d0x1VDVjbE83dm9xZ09KUnNJYlJLNnpu?=
 =?utf-8?B?WTFpbDVaQWJNU29SMU9KTEpzQTc4ai9RNzdwRkpLS2t6QkV2QVhNVmtiY0dP?=
 =?utf-8?B?dzE4LzB3NFg1bForWFVKZEROS2NYZ1FJMGVZY21MaDRDay9zK2ZxaHhNNlJz?=
 =?utf-8?B?U0lreGVpSGxCWVlrTFUvNDRzY0hxNk5KalM4a3FtbWRDbnBkaHByOVA2TWZ0?=
 =?utf-8?B?UHdqMDBsMVBXN0xTTzVpMGJkejNYajZCUUp0bXd1Qm1HbVlJQjhKUGpJTjVI?=
 =?utf-8?B?VDZGTDNUdzNVeVdGNVcxbWdIcWZidkRYeUp5aW1QdG8zTHZ0cEowUEJJb2ho?=
 =?utf-8?B?blpDaEJPZ3pCNHV0ODN0akIzTmNnNFQvb0FHNzBmaFVPSjAwU25aTGUrRFN4?=
 =?utf-8?B?dUVFUmRCU0Z0QWVKUGtFK2pWcnplTzNhNHEvU0VJSmROQWZpM3VBeHpvS1VP?=
 =?utf-8?B?WHhNRjJZOWFSK3YwSW9kM0R3WnBDRDUzVWkyeGg5d3NSZC9zejZLVkN4cE9j?=
 =?utf-8?B?dDNpcVl6MjI0MjBHb1RSeGthUDRvbXNuUWpPMEMwcDVTbFBPVGVndlRaeWoy?=
 =?utf-8?B?QmpXRGtUM3gwVnQ5THVkMDh0TGZyY1VkUGd0Z1FBRzZqTWpYN1RvV3plRHZu?=
 =?utf-8?B?cUUxUVVQNmtkSlRKbWxOVGd4N1dvMnVvbTYyZkR2WXV3RG9IS1liOG92WllQ?=
 =?utf-8?B?cUlHbDI4NnJFNmZzMEtGRnlUL2Z2T1lGWEhWSHRlNUducXhmbHFDNVBWejlX?=
 =?utf-8?B?L2NhMGRBMGNCWmlvSnVDZ3lVaVJ0bFVzOUZpZmZlbE9Edk1FZkIzRzJJR2Z2?=
 =?utf-8?B?eDh0b0x4eTIzSU8yWm1wdnpDek1pMVdVdWVwVHEyTkh5YUZjMDcvQk14YmZJ?=
 =?utf-8?B?L1pPVlNZV0ZBY0FReCtSOTQ4dkp0VVNjVnE5cTZ2ZEpkN3hGNWYvSHV2TEN3?=
 =?utf-8?B?QnFaVXg5eG1WN1Y5aHkyeFRIR3JzZkdQeVo1Y01HbE0zRGtMYmFvUFJQc0lL?=
 =?utf-8?B?T0lQRFdOd0g0RytFcTlJWnJHQ1dSSExibUpXb2NoUldwbVRJSC9INFJPOVV2?=
 =?utf-8?B?OEtKQkZEem5naG8rRjBtOHRLbVNRb0FDQmFNL0VMSjNubmVWWlM0T0g5VGdq?=
 =?utf-8?B?SEEwZkVXMTJWbzBPQUtYR3N2MGJ2eW5iZVhhSjdvNTQ3WFlIRW9GNEFLTVd3?=
 =?utf-8?B?KzZkTWpBeUhnSEhqNjR3Mjd3SDVwV3E0dG5FNDZTL2pVN2VZQjc2VnYrQWNH?=
 =?utf-8?B?Q1JLQ2JXVTQ0ZUVSeXhzc2FkOEYyMjF4eEhQbjlueTVGR01nazZlS1p2a2tk?=
 =?utf-8?B?V1VVbWE3dVJpdDNuMVIxam8rZHVLR20vNW02V3QweEJxcnlwS1d2QTAwZENO?=
 =?utf-8?B?dXg2LzF2MGR3SVk1dlowb1hySlJQUjJKdXdXZjNFNWhqc1ZLZGlGN0VUVmor?=
 =?utf-8?B?SndXM0ltZkNBa0RTT2EzWllvb1RWbDBPWTRNaEVXOFhHS1d1WDNTS2cyNFUv?=
 =?utf-8?B?U0RMdU55Qy9LaGFib0hlc2M4T2dTa05EN3Bva21xRTcwY0NKUENjc2Rkd1R4?=
 =?utf-8?B?bExLbUEwcjVjanEyK2c4TTN1MC9GZVdhT3J1emZJbXh5UzY0YlRET1h6Y3E4?=
 =?utf-8?B?Y2N3UDFyQUUvMmZEWStlR3pTNlFHM05WTXZrUzZnakxRckY1Sm1YRDNsbGUw?=
 =?utf-8?B?d21sUVRHRU5Bd3hjSHdlSC9CclVmWkUrdkpPc0g3SmU0Ym9MeFdpZlNDcVJE?=
 =?utf-8?B?ZHAvTDR5dUJGTDFHSXNoQzE5V25mR3RSbjcwbmhhMlhqM0FVVzcrS2sxaWxP?=
 =?utf-8?B?TkFPOFV2d05PRHBBWk95Y09ibk9UZGJLUk43Ny9nS09YYmFSSjVCenRaaXBy?=
 =?utf-8?B?T1hxU0JDVlYvZzM0UEtXaEJIaTZ2akdTWGcwVlV3dmc1TitDRlpObGRvUzht?=
 =?utf-8?B?VDZILzJkZytxVHFaK3Y5UWo0SjNhUHFNekZxSUJEWHdRRHJTcnhES2I3OXFF?=
 =?utf-8?B?QmhEY2pHazB4bkVnb2I2RWZHdytHbjRvMGEzTXhTTWdVeWdCcFVvWlhwVkt4?=
 =?utf-8?Q?VvzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1211E24851F9B42920521A3804EEEBB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bafc87c-5ec0-42ba-7a9d-08ddeb29aacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 20:37:14.7715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dt8OWEiyWkt84t6deQ/YeEkqd+Nhbl6bAgJ7TvPCm6Q9NQSwUO1IIFoeB9zFgyIsiQa72WkzZwARYcZ3R4p8Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

T24gOS8zLzI1IDM6MzUgUE0sIFByYXRhcCBOaXJ1am9naSB3cm90ZToNCj4gRGVjbGFyZSBpc3Ag
ZmlybXdhcmUgZmlsZSBpc3BfNF8xXzEuYmluIHJlcXVpcmVkIGJ5IGlzcDQuMS4xIGRldmljZS4N
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogQWxleGV5IFphZ29yb2RuaWtvdiA8eGdsb29vbUBnbWFpbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFByYXRhcCBOaXJ1am9naSA8cHJhdGFwLm5pcnVqb2dpQGFt
ZC5jb20+DQpSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxv
QGFtZC5jb20+PiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8x
LmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuYw0KPiBpbmRleCA5NzY2YzYwNTZkYzQu
LjFlNDhkOTRlODcwNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
aXNwX3Y0XzFfMS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8x
XzEuYw0KPiBAQCAtMjksNiArMjksOCBAQA0KPiAgICNpbmNsdWRlICJhbWRncHUuaCINCj4gICAj
aW5jbHVkZSAiaXNwX3Y0XzFfMS5oIg0KPiAgIA0KPiArTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUv
aXNwXzRfMV8xLmJpbiIpOw0KPiArDQo+ICAgI2RlZmluZSBJU1BfUEVSRk9STUFOQ0VfU1RBVEVf
TE9XIDANCj4gICAjZGVmaW5lIElTUF9QRVJGT1JNQU5DRV9TVEFURV9ISUdIIDENCj4gICANCg0K
