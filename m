Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF02C71130
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 07:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FE210E149;
	Tue,  8 Jul 2025 07:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="baV4RjSk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC2C10E149
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 07:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOeI58btCB+G0Olr6bC/FnTI5gLyYoWSs8rZdV2jrQAKd8oJwmIb1uPqqel4EkTqOgh3pg0Vi49DYhSR6pnF4dlQafQJJGoeZF1bsihbSYLUp+uNbmRw/0u2V9EYk8iCJLGiLYZM5VjDpYUGY9yrBkudT/8HzUUh5MjsrXj67dC+YTvWOKVvBRUHFeIxxVsIryhTVk1WJ/j9yL4NWja1otN4GURsK7l92vO9/FLssm7dKqZUUUbvpnkUlzyh4mqNWNIQqy0+Hqg8ZhhBce8lHH1bTVd04kVh5Y51aO5y5AoO1BJxyu+/NKZFeYKWVRLFPPlrciauL9cUl+8JKMKXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBScrCWL1knJO5Luek/BTOBnJyRQoFrTbd0xuoMoFI8=;
 b=ESlOKsVIPQdvMTRx0saTb+7hpaRl4ffOzfNFvIW+FUM/vKUwRArkdg25dLpsm35YbfjUAEJv7GeA7uh1FGw5tm7jGG1sHCcIBDjUiu+s5DdP7hvYkljS3uM2JYcTYrZZCyOni/LRTSZH/or9JNc5OAcVK49FR7e58h9/V6oa0qikJqiHCJAu6WmcuF7aWROj2Y4o8X0TdGwAsIVi+lq+hOuDqorL0Xm67+tj/G2vz0JYBobD4M8V+he8EnPWOy2qrJz0QT94/xk6f9nhbgVgr6/heyHIIpA8z/XQo1dxZ8TJu0mHOvdR3DsHVAswzpb/7xSM+M/EzIFdeVaKG6YILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBScrCWL1knJO5Luek/BTOBnJyRQoFrTbd0xuoMoFI8=;
 b=baV4RjSk0/wKM4Z+5k7xRo+hfjK6OxXww4wOazMfqPfgPaCLpwMIIfvZIsQ/Upe+1+VKmKLxebRMf0oCnmPWfS6dxMjLQWcnr+jMzLi6bzUQAeDLW0ONtlKF4OmdqNia956zb3coNNSEeq2Vz9UBl5YZHx6fj2a0ed4rK7jrqUs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 8 Jul
 2025 07:00:43 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Tue, 8 Jul 2025
 07:00:43 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v5 3/9] drm/amdgpu: rework the userq doorbell object
 destroy
Thread-Topic: [PATCH v5 3/9] drm/amdgpu: rework the userq doorbell object
 destroy
Thread-Index: AQHb7M8TuP18y4H8MUurdLFjhHIjzbQmaSqAgAFlRrA=
Date: Tue, 8 Jul 2025 07:00:43 +0000
Message-ID: <DS7PR12MB60055EBFEF1E99030CD2C218FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-3-Prike.Liang@amd.com>
 <4974d335-2b5a-46c8-a832-6ad1ce642e7e@amd.com>
In-Reply-To: <4974d335-2b5a-46c8-a832-6ad1ce642e7e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=20bf6983-372b-463a-bf65-75072e03b5c8;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-08T06:46:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA5PPF916D632A9:EE_
x-ms-office365-filtering-correlation-id: b4a1110f-9681-443a-9db8-08ddbded27fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?akZlQ0hFVkJOMloxcHQ2Q0JHb3B0cG80Umx2Vy9HQnBjQ3cxd0JoVWhWVGkr?=
 =?utf-8?B?UHpVQ25VcDRmeUg5WnZnd0x3dS9zWlZTSUt6VWZKZ3E5b1ZBb2dHeklSNU90?=
 =?utf-8?B?K1dwR0JrMDZLallZRVpCdXdrK2FqcmxzSGVDVXdydHoyRHozWjJFOE8rVjJu?=
 =?utf-8?B?K1ZIVWIxbk8xMG1QK2xGdEwxSGlOZmpZaUxBRlFkcWdkb0lubWY5Q1pkZUN6?=
 =?utf-8?B?MWhYdVhxell3d1RqYkNKc2VpTkxVRTBzU2N0K09tL296Skl4cmUxMHExYjZm?=
 =?utf-8?B?ZFZ6Vmd1OEgrRXNVM010Y3dkYlZRNUNxOVBaMVdmRTVaemdZaDM4NVVwRTFv?=
 =?utf-8?B?SURUL3d0eHNOUnZqdlAycEhpZ1VvWGJoOXBFNndMUHV5VThJR2NOSHJrNUg2?=
 =?utf-8?B?c0ZvWWU1OUtxeDI3ek1adG1BWHZqRWNpWkhLNEhDMzV0b1k0eEtiQjRqWVhk?=
 =?utf-8?B?RCtBcmxWOTdFYndjK0RxMEZranF0Y0ZXQ3B3dHd5VnRoOXRrYmtGa0ozMmtw?=
 =?utf-8?B?NGVsRGRPZk1VbHpyN3JtczRjWkRPZTFSQjZTMjRHcTZ4TE16c2NsTW5tZzYr?=
 =?utf-8?B?MDkxRDd5Tm13WTFUM0RRT1NVWkhwdW5OZDZYYXZIdGtOYnlubUlDQlA0ZlRv?=
 =?utf-8?B?SlV6WXgrNitnYjVPQ2RMUUR1RHZsOERLd05nUE5JUjZWcXhIUWRmSHc2Vldw?=
 =?utf-8?B?WDV4RlhLeHhVd29TT2lCb1JDTnRmaWhJNHluc2dPMS9remdDRkc2YnVLTS9M?=
 =?utf-8?B?OXFYaUxjaWFhT21pU1pBVjR1VmUwSTcremU4RzhMQ3pOaWpGYWN3bjU4bytr?=
 =?utf-8?B?bnREcFkxTVY3anRXN1FPaGJRckt6VmVPczhsMmNjZTNHdy9HQ0VPL1JMSjNJ?=
 =?utf-8?B?YkU2RlgyUy80VE5TSGJCYW5PSzVENXhGd1JxY09EcWNqTFBrb0NBYXREL05O?=
 =?utf-8?B?QWFoUFN1U1NQeUc5c2poM2xpdHAwSS9uZzU1anVxQlJjdnI5R0lIaHNjcEV0?=
 =?utf-8?B?OXRGWWEyREltUkNzRm9YTUlFZjJOc1Nvd2pjM21iOWl0bTdFMVk1cncvczVE?=
 =?utf-8?B?SWhWR09uakVhcDV6alJDY29qRWVjN053S1c1Vm1aZFRld3BUVHN0ZnpSejNh?=
 =?utf-8?B?eVBGR0FZTW5YQjJnSlc0SEZkbFhPRlBhUVJnekpqSDRlRUQydFMyTC9oNW1G?=
 =?utf-8?B?eDl6UnJqVkMyU2JualR2WHhKeUE3YTJBdTlJZ1BuTUdhNWkvcjI2SE9LWHhI?=
 =?utf-8?B?bTdEcXNLNXhQSHU4VXhQVHFvZTZPQWUxK3FGOHhXUlRveHJ2SkZNcHJGT0FK?=
 =?utf-8?B?a0hQMnAvamVTY3FFWFZTYXVCZjlXUThJWFZxaHdLRFltQXdhM01pME1lR1A0?=
 =?utf-8?B?SXBhaGVQSnZseW1Ud3RweWdMYmwrbGw0THM0SDhOVTVSdmN1TE5HMm5aNWtW?=
 =?utf-8?B?QTFtM0MrSmx0eUhSZmNMOHI4WnQwR05JS2RqSW91dzQxR2Y1cVR4RVp4WjNG?=
 =?utf-8?B?ZUh3WkU2b2hGa1FqSGdzTUpKb3A1WTdVWlQ0SHE0UWdoSDlZS2htN2JyazFn?=
 =?utf-8?B?M3JPc0g1Q1dmMy80aG52YXdtQnZ2bDBVWFhGRDNmWktsYU5xcmJnWFdBYTBq?=
 =?utf-8?B?Q0k0Z1U0MnRrdG05MGhnQ2EvajVMYm5UUHpUK3FyenA2bmZ1VklpM0pmdlhD?=
 =?utf-8?B?cEJaTCs1NDFnY2Z1U1Z6b2VGNFBYWFhxOGFaQjNQQ2JlbVBkK1VhL3BVeXRL?=
 =?utf-8?B?VThCTHl5cGhSNkQrRWdkaXByUXJwUWdoYzJxOGFLN1dzRFBXVkh1WUFDNTNZ?=
 =?utf-8?B?UU9BSG8yZ25VU2h4UkI5R3pFZGZBZ3BQQ3ZjT2NodmZiM3BrdUdCOG5NVXls?=
 =?utf-8?B?TXdqMG9ZWERrMzY4OE9DWGppTXRLUDV4QTBFK0ViOVRzYWZvbEJ2UXM5eFR4?=
 =?utf-8?B?TTFvT2tMdXZRQllQalk0QmpHbzRLaVF2aDhnYVN6ZGRBUnA1LzMyTHV3aVI5?=
 =?utf-8?B?N0xqRmlSWURnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVyei9hV1pWcHNzSWxkYTY5UlZnYmg0azNobC9OTVFYcWJMamNUSldNSVRE?=
 =?utf-8?B?Q1BmQ1YwNEVkeFBhNHJkQmd4R1BGY2NvdkhHOW1LZVErK3FqRGFmVDZ4TlVE?=
 =?utf-8?B?QmlXMDdzTHJBaXhhdzlGcG56Z0tFaU5IRmZoKzhHZzhOS3lSWDJ0QnFQZFRS?=
 =?utf-8?B?MlArZU1RS2sxeFEvYXFRais5VWIxYlVVQ2VTQXZHblVidWt1TW9CdVFPcXlM?=
 =?utf-8?B?cnhBNXY5S2VVdHgyR0RlNFZQSDlJQlhZT0M0a3JWRFhZM3VhNjJERWhYM05q?=
 =?utf-8?B?WGE0aHA4OUFiS0tTdGhZYXlXZHFITXo3anRzeW9YV3JXLzI3SDdRc0JURFc0?=
 =?utf-8?B?VlZpaytIbWMyb0l3eVRPTlpoTTF2Tm5xYjR6MFI2ZnhyTjV3V21Md0Q3OS9l?=
 =?utf-8?B?YVA4VG9zSUpmSnhMeHdUdzBDMGJWc0g1M2JOYkJrcFZwSmw3Z0dlTmhCcklp?=
 =?utf-8?B?QzBIN3NGc01sTWJ5K3VQRFNiZlNxbFR2eENucWJJUlBPelNvekZSR0s5S05h?=
 =?utf-8?B?bXlKdUdWY2h6UUtoa0FHaFRNNTdGVG1OQjNkalZHbkcva0ZJTXhsSGU3WE11?=
 =?utf-8?B?bWVvSG1TeGhrWU82bTJ2T2NKZG9wUURQYkRLQUZnV2RZcjRrdmpGSU83Um9O?=
 =?utf-8?B?VUw5d1c4MjB4Uzl6VG95R2FPWndmajhFQ2dFR0ZkWm9EZ1pRd0hqT1M1amM2?=
 =?utf-8?B?aGtlUisyL2h1NmoxUllvakFiWTYxQVdiR0ZpanhuT2t3SiszYkwzcEp1OFg4?=
 =?utf-8?B?YmtMSkVUZm5aMytSSGtFTHhuemxhUUd4ZXNRQmZCdlRBZ2VJSHFWVjAxM3Bz?=
 =?utf-8?B?Ums2bGlrL29pU1VSdS9tNjdTTEYrWlJpb1RhTmczejQ1aDZDbGpnRVpEbUM5?=
 =?utf-8?B?QzZzMktrd2M3ayswRnVoZFFCN3ZqT2hQeCtWbHllQTRkUVprSU1ZUTRuRENv?=
 =?utf-8?B?MVJNZzBIVzdwSklKQldxU2RoTEY4NXhMaW1BRWFXMFQwN3B3dmtOcCtENjcx?=
 =?utf-8?B?cGlldmZiSkV1MVI3czRYNlJ2eTBiNHN1dktpU3BtQzJiMnpIRlRqNDVvc1Mw?=
 =?utf-8?B?WjhTdVJ4TEpnam4yWW4rTHZpVk9aaUdaU0JXUkN1SEhGekcyVW9xYlFwdVdx?=
 =?utf-8?B?ZGJmZCs5U2VUT0ZETjQ1cGpzUU5FS1JKbHI2UUVyS1J6YVBxMzNDUG5RMEw1?=
 =?utf-8?B?cE1lMEpvNHlsNmZIU3plb3ZHMXkyZTNSdGtVNHVnSjl1ZFJVdU9iSStVS1Zm?=
 =?utf-8?B?TTdNMHNtWGdPaUdYdnNEalhyVDdVb3JXTFJCMFBDbnUrei8vQ3BYc0xDaTk1?=
 =?utf-8?B?WjhIalBMaTdSNHdvVE8xcG9QakZxZEZrSVpyVGFzV2RCazhwQ2VHVEVYb1FS?=
 =?utf-8?B?RHBHVzQvR0kzVm0wL3FnNnZHenRKdk9RU0tmdHFQQ1VkS3EzazcvL3BJbitL?=
 =?utf-8?B?VzlRTmthWlVKR0pHenJSMm4rc0Ryc09ralg1Q1JjRXFiME16cFZQMXVueEF2?=
 =?utf-8?B?YnB3MW5VRjZwcmlXVno0UjZzUUtRNkswQkN5OU9mdVZZMERRQXd4L0xGa3E4?=
 =?utf-8?B?c1FxODcyTkIvMmY2clpQK2kxdE9INVlrM2JNZHJUdmxoZXdjNjl6WSt5VjZ0?=
 =?utf-8?B?ZFREQTF6RHRqZWN3SndVMlp2Z3JpQ1RvVWJKVU11MUh4alo3MzY2THJ0VDA4?=
 =?utf-8?B?eU9Id3phNmpLRTduU05weFVtZlZyWDZ0dzR1TkdOeStyVlFVNXlFWWNHazFj?=
 =?utf-8?B?RmZiQmdVL29VTkUrWVltVU1naytUb0szT3duVlVJcWxHd0t4QnBCdGpwQSsy?=
 =?utf-8?B?TDZwTEpYQVY4SUF0U3NCSCtWRVFyd0RwRjJMN3VxVnpEQmNtd1FKL2FzOUpn?=
 =?utf-8?B?bUpQd1h1VkhOUzVYdFhIYzN6c1IvcUFtbzR4OC83VjhvT05EUDdPQ1kyenJh?=
 =?utf-8?B?elpPQjFoMjZtNk8rMXEvTHI2SWZlVEZ4VjFuZHljR1VrYk90SndDT21sdkJy?=
 =?utf-8?B?WmxWTURkNmgvVXg2QlRrVG9tcis5Nyt5clZTOXF2YjRQWXRXU1VMdyszaGhk?=
 =?utf-8?B?eWhINGM0dWFRV0xCV3d0K0lMQ3Vab0tYdVZEYmg0Q29NejBzSG5xWTBuRGdZ?=
 =?utf-8?Q?sLUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a1110f-9681-443a-9db8-08ddbded27fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 07:00:43.1653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDHEWQtv3OSoNnfOCQKLkTBDWOuJcgXmLKt0/g3oXO6Y+HKA1WEbUzmU7dVCtFbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1
bHkgNywgMjAyNSA1OjI4IFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1
IDMvOV0gZHJtL2FtZGdwdTogcmV3b3JrIHRoZSB1c2VycSBkb29yYmVsbCBvYmplY3QgZGVzdHJv
eQ0KPg0KPg0KPg0KPiBPbiAwNC4wNy4yNSAxMjozMywgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4g
VGhpcyBwYXRjaCBhaW1zIHRvIHVuaWZ5IGFuZCBkZXN0cm95IHRoZSB1c2VycSBkb29yYmVsbCBv
YmplY3RzIGF0DQo+ID4gbWVzX3VzZXJxX21xZF9kZXN0cm95KCksIGFuZCB0aGlzIGNoYW5nZSB3
aWxsIGFsc28gaGVscCB3aXRoIHVucGlubmluZw0KPiA+IGFuZCBkZXN0cm95aW5nIHRoZSB1c2Vy
cSBkb29yYmVsbCBvYmplY3RzIGZvciBhbWRncHVfdXNlcnFfbWdyX2ZpbmkoKQ0KPiA+IGR1cmlu
ZyByZWxlYXNpbmcgdGhlIGRybSBmaWxlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtl
IExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jICB8IDEgLQ0KPiA+IGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8IDQgKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IDNkMmE3Zjg5NDZj
Zi4uZjFjNDFiMTExNGQwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmMNCj4gPiBAQCAtMzE3LDcgKzMxNyw2IEBAIGFtZGdwdV91c2VycV9kZXN0
cm95KHN0cnVjdCBkcm1fZmlsZSAqZmlscCwgaW50IHF1ZXVlX2lkKQ0KPiA+ICAgICAgICAgICAg
IGFtZGdwdV9ib191bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAgICAgICAgICAgYW1k
Z3B1X2JvX3VucmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAgIH0NCj4gPiAtICAg
YW1kZ3B1X2JvX3VucmVmKCZxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAgIHIgPSBhbWRncHVf
dXNlcnFfdW5tYXBfaGVscGVyKHVxX21nciwgcXVldWUpOw0KPiA+ICAgICAvKlRPRE86IEl0IHJl
cXVpcmVzIGEgcmVzZXQgZm9yIHVzZXJxIGh3IHVubWFwIGVycm9yKi8NCj4gPiAgICAgaWYgKHVu
bGlrZWx5KHIgIT0gQU1ER1BVX1VTRVJRX1NUQVRFX1VOTUFQUEVEKSkgeyBkaWZmIC0tZ2l0DQo+
ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IGluZGV4IDE0NTdm
YjQ5YTc5NC4uZGJhY2RmY2I2ZjdiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IEBAIC0zMzYsNiArMzM2LDEwIEBAIG1lc191c2Vy
cV9tcWRfZGVzdHJveShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21ncg0KPiAqdXFfbWdyLA0KPiA+ICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKSAgew0K
PiA+ICAgICBhbWRncHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmZ3X29i
aik7DQo+ID4gKyAgIC8qVmFsaWRhdGUgdGhlIGRvb3JiZWxsIG9iaiB3aGV0aGVyIGhhcyB1bnBp
bm5lZCBieQ0KPiBhbWRncHVfdXNlcnFfZGVzdHJveSgpKi8NCj4gPiArICAgaWYgKHF1ZXVlLT5k
Yl9vYmoub2JqLT50Ym8ucGluX2NvdW50KQ0KPg0KPiBDbGVhciBOQUsgdG8gdG91Y2hpbmcgdGhl
IHBpbl9jb3VudCBoZXJlLiBUaGF0IGlzIGNsZWFybHkgYnJva2VuIQ0KVGhhbmsgeW91LiBJIHdp
bGwgZW5zdXJlIHRoZSBkb29yYmVsbCBvYmplY3QgaXMgbG9ja2VkIGJlZm9yZSB1bnBpbm5pbmcg
dGhlIEJPcyBhbmQgdGhlbiBjb25zb2xpZGF0ZSBhbmQgcmVsb2NhdGUgdGhlIHVzZXJxIGRvb3Ji
ZWxsIHVucGlubmluZyBjb2RlIHRvIG1lc191c2VycV9tcWRfZGVzdHJveSgpLg0KDQo+IFJlZ2Fy
ZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiArICAgICAgICAgICBhbWRncHVfYm9fdW5waW4ocXVl
dWUtPmRiX29iai5vYmopOw0KPiA+ICsgICBhbWRncHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFf
bWdyLCAmcXVldWUtPmRiX29iaik7DQo+ID4gICAgIGtmcmVlKHF1ZXVlLT51c2VycV9wcm9wKTsN
Cj4gPiAgICAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0KHVxX21nciwgJnF1ZXVlLT5tcWQp
OyAgfQ0KDQo=
