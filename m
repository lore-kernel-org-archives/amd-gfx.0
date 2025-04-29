Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6F1C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 09:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858C710E401;
	Tue, 29 Apr 2025 09:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rSLUe9/D";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8BC10E400
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 09:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgJiTsAxr0IM7tynT9IHDrfaO0r+cxix1Q81B4g5+TDB6ABQ7Xa3x9ArkE7LyeYqQpc0MzZ+CJownvs9cS7N1K307SAteka1/7Qu5di8k9ebasgJxcbF5Nw5vKtUXzImhjhOxG85cawaou/rgb+GCnLydhaDMbhvAz4t4/N06jFd+m0sy/6MI7e3890neeiQhL5jmFQEHuA7mY6l2SFqSIHCe984gIhHuEZuC0sAk5RUVBnq+Te7gVmyKAxHrgWlYmmTJOhzQhkX6+EfzLHhJHT9VNAB8oDG9CULY0njDBE+7kmdOz4YufMpSOOG24K406ZQeBWtND933N3/RbhLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3rKPY2XCt7Dgbvk2N4jUt57qw3CFOKEd8UNwy6HSYA=;
 b=J6r30Njx3oUhMg2xEvN/NkVHF8tlbzALfEuehFHt2ln6vGcK4jqJ0Pyra4t0ydsQ4e13QHpEPnBiuvIvw6r4zNv8ONigU9wNhHS2VgZvhaeW9In8avFWe/8UFDfLVaIUF/DAgnU64f40NabpBU81jbBiBBBlEBk6WvVM+9QIJEyV381aZgcF0nZB+08xptigpAn2HxGIf260M5ShyvjXB1ImSF21fSkYbVBF3Wb8XiG0yeNsVahJ6icjD7FSm/nAGgBSoK84w9IlHlAGgTaoKkfDOTqn8zDMDOePxlmamH0fWt7srgF75l305Umr6J3TKNugOJtrb5dALhwXnMaBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3rKPY2XCt7Dgbvk2N4jUt57qw3CFOKEd8UNwy6HSYA=;
 b=rSLUe9/DlR3MW9B5k5yl2DMC0rphNquO4McEkJz3K4/wQJftMyRR4yqS02w0psCV8McrPA2cKPGme2MXD+bNr7PxLknZ3rUwE/gRyu3ISRKkuzJpDEFLO7O9tSr/QPGiUds8bQF0ri8hw4LOuTpA3I0ETtNzgapk///8MJJRdmE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 09:05:12 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:05:12 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: only sync on the dependent read fences
 for user submission
Thread-Topic: [PATCH 1/3] drm/amdgpu: only sync on the dependent read fences
 for user submission
Thread-Index: AQHbtbKXKEi7MfLGhkWKJ+145EU8CbO5YaGAgAD+aqA=
Date: Tue, 29 Apr 2025 09:05:12 +0000
Message-ID: <DS7PR12MB6005F8A51AB88A67E1843070FB802@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425072039.4034161-1-Prike.Liang@amd.com>
 <074a4769-e9e0-4416-9e24-2373c6b7905b@amd.com>
In-Reply-To: <074a4769-e9e0-4416-9e24-2373c6b7905b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4bb1390c-b577-4efc-abd0-12fd9233093c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-29T09:04:39Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6092:EE_
x-ms-office365-filtering-correlation-id: d5b1f5eb-f30e-4d63-5865-08dd86fcf2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bUo3M2JEdmlFTVJGc1VVS2pJdkQ1d0RhS3I0UVJhY2JsZk1tci9jK1FsR0hZ?=
 =?utf-8?B?SmVCSU83TUdQWmZRSHFYNmxkWGRRa1AvTHozUHRKMjZTUmp3SGVqSGtVdW50?=
 =?utf-8?B?eXR1RHZnNHJqQVFubUF1V25qN05SVHY1RlVCaDZhTWxBWU9EZ1NVdnhCbHU2?=
 =?utf-8?B?K0lKZmlNYktjWFRvTVBkU1BWWkkzSzhZYkZRa1p2ZXl4M1RnbTRUcEw4QTVx?=
 =?utf-8?B?L1JubkhhM3pselVuWVU0OWx4SzBoeWVRTHJBbUsrUWMvSStNR3NYQVhhTHFT?=
 =?utf-8?B?OWJITUtxRDFQMk1pMTF4bUx3TXB1dmxWSDI3VjhudVNBWjAyTUhXdGpKaEJ3?=
 =?utf-8?B?M25qNkNBRFZpa2lhelFwSCtyVU5YSy8ydFBpZVgrbi9kY1dCQitxNzA0ZDZ0?=
 =?utf-8?B?aExmWU1xRHRGWnd4MUptTk1Ubmo3bHh4T2UxaEhNbUJ5YUhaWUhnMnNTYWhi?=
 =?utf-8?B?MXg4QWlrdzdVdjROekZRdkdkd3NHM2h6WUZqSjRRS05MeGJzQ3FWYjZ2dnF3?=
 =?utf-8?B?eCtEbGwxY3RKMmxTVE5nVkVKMy9YNVNNeHBObVlOMExMWVIxdGlzdldHZE9D?=
 =?utf-8?B?aXVqeWhVUnFLM01kOHFNWHU1cXRjK3huTzdxWHd5QlRrNEd4VW1DU3M0UUdD?=
 =?utf-8?B?d1lPalcrdlYrNEdBUHhrclZVRXpRZjhyUkVyK3ZMZVV5dEhUaTZUUkU2cWdl?=
 =?utf-8?B?SlBEcHUyOGU5c1A4T0VMb2IrZE81U3A5VzVCV25ra1REbVhCaWhYczRUaFdB?=
 =?utf-8?B?NXVBM2V6ZSttMDVZNzFlZkYyUjlZbFJzU29jaHcvQXpBL2FON1RxRnc1REhv?=
 =?utf-8?B?YkdvWWptOTNxQ0FjWStCMThGNnVLNjdCVTczWVZRcXdnTnAwMUhSc0FOdWdV?=
 =?utf-8?B?aFZLSnR4V1hjUnVueU5Kd2JRaWlnQ1hSSGhuTzExcWxWaFhrSzQ4U2RVNFBx?=
 =?utf-8?B?bzZrNWdQS0hIbVNvbDVyMlJFYlFSZFNEUFd5b00zbE9RWXIrdjgwT0srNGF4?=
 =?utf-8?B?ZU41dnRiRGJGOC9qL1FycTFNSnZGSkFleEkybDF0MDBMU29wVFgzV2ZRTGtP?=
 =?utf-8?B?SmJEQXJwUHlCT2JUZE1BZEZnWE1BK1M0UHVCSzgzVmpBM0VwMmcvQXNobWlP?=
 =?utf-8?B?QWgzdEYzQktCTmZqZHg5M2ZZNzYrT1BHMGt5OGkyTnJaSzBnblgyVytjSVZJ?=
 =?utf-8?B?TTRKdWJtanlibVMrWFkzSGJQMXFrRVE0SmFKdlh5UzczMktFVHNYL3lJTWdN?=
 =?utf-8?B?OWE4c3hudVNobDN5R0o0TENWUTUrZEJhaGtjUEF3VllTYVBHSCtGT2MrZlJZ?=
 =?utf-8?B?dmdoeU12QzV6QWhIQkVBbXI3ZTI4alFlalJSOGo2Uzc4c2N1ZEx5MXc4STF3?=
 =?utf-8?B?QVV0RzVnSDJZUDZRVzRTRGsvdlMvdGxsUUhYSktPWG42L2phTU9PUGw1TWI4?=
 =?utf-8?B?Mm1DU3VyQmsxZVY4NVh4Z2t3M0NJbzk5R3o4YlFtY1ZpWDJVK2F3SGxZVWRt?=
 =?utf-8?B?TGlscXFsZ3NrNGowS052ekVQWGZpZzJ2QncvWHJBb3JaWGlxNVduSlBmVnZV?=
 =?utf-8?B?N2FCcm9zTG5iUU1IYlExcEdsZFlWNWFJNm5RRGlZY21ibVN0R3gxRTZqR1Z6?=
 =?utf-8?B?a3BpR2RoajVzZTBTU1owSW9WNEo1d3BBQUNiSmlRWEtmZjErMm1FY05YWjhP?=
 =?utf-8?B?b0VjZXF0VWVUWGlVbENPZ2hlVzZJVXNxNTBiTDROV3c4eEhUTFVybWdOUXNN?=
 =?utf-8?B?WWc4WmtUSTAxU2xLY08yd1Y4TXZNVjdMYzM2TVRIME5RS1FjU3NsVjN3NldZ?=
 =?utf-8?B?cjIrdW10V0VsWnVjTHdqR2hINCs1em4wVktGK092dk8vZThBM0hpMVhERzBT?=
 =?utf-8?B?d04yanIxa2cwVFBaWnU1MHlQWHJQSDVQenZLQXpXbFFiM2Fnb0NnckpQdHlV?=
 =?utf-8?B?NDgybzhBRjBqRW1zdndQQS94M0lLRFJESk9qZ2hOdXIrNXJiRzhFWEZrblJp?=
 =?utf-8?Q?WbUfY97w1ooV2Sp0CGsLZJge+wSk0A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anFOMjdNUThwU01seERYQnhVWitTcURLb3ppaFNyUGYzem5UWER2R0tCSFZv?=
 =?utf-8?B?RjJza1ROK1g2SC94QXV3Nk90YStSaVl3eVZ6ZGRHZmdvektrVE5JY1NyMVJC?=
 =?utf-8?B?dXdsZjFaQVN1akxLVmtEZzY1ekRzOWRpbndpajlESk9XQmI0enFYdVo3T0VC?=
 =?utf-8?B?Tksza0RyWGs1TkxlL2UzeDJKMFg5WTRNcnkzcXdoelpGWG4rR3RtU3BmUDRa?=
 =?utf-8?B?VUMyN0djbFdYZjU3eFkvY1l3YjN6Mi9jTVFxbzFsVEJZT2ZDaFo1OTFNRmRT?=
 =?utf-8?B?QUNVNmNHNzN0V0ZuSTUzM2hEZDVXaGJuR3RaT0pIYmpjQzFGSGhTMTc1ckFP?=
 =?utf-8?B?RFdTelV0MmgxL2laK01sUjJrRDV1RnNBRjdzc2dKRzl5b1hmUXVMSU5UdXBh?=
 =?utf-8?B?NFF1cUE0T0M3Q2pSZExjcGtScExTYmpETzdGWkpoQ2U1dEFoZlM3c1hZSEEx?=
 =?utf-8?B?L1M1YW1CZFE1dy96M1VZNjJmSlM5cTFCZmF2RHRSRGxOT054emFRaHB6M1Fj?=
 =?utf-8?B?Q2ZSQTd1Q3VLcXp6OTZESGl2QXUrcVBmU0xzN2pqOHE3T1BkOXdSZDdkWkMz?=
 =?utf-8?B?bEpIU21ESDI2ZHV0Rmx3WXBrR0MwdVU4VkZRNzRQRUUxdW5JeUF1MTNBcUhO?=
 =?utf-8?B?dEljN2YrV1E4Z0hnd3JEMVB2SjJtNFZCYlgwZ3krWlN6anVId1AyaEFVT25k?=
 =?utf-8?B?YlZwb3pEY0tQZEFrOEVBYU5mMDI0YXFxejBMaFNGN09rU2hiWDU0dTBIKzdJ?=
 =?utf-8?B?ZTEzcGN4VXQvVjQrdEdIY0dON0JHR2s5N0JQZnV0SjZlQXdrNmI3WWZGZFE1?=
 =?utf-8?B?enJtNlIvMXJ2cVdRVVlMYUdKN2d6aW5lYi9EOWJUU1lkSVdJVmYrTXJsWlpF?=
 =?utf-8?B?OUtEdFhDbXZZUnJJV0IxU2k2QkpROWo1NTZuU1hOT0s5NEVTNXBaV0hRaW5r?=
 =?utf-8?B?MlNTL1ZvRlJxWWNEaTBwMCtWcG1ZRGhXdWJQTC9uam5LQ2ptSFJnTW0vUFZQ?=
 =?utf-8?B?RHRXb2tYMVZPK2ZzWTFOTFJEOC9hR1pqaHZRdU9RS3crTnYxajhVMWI3Q0dt?=
 =?utf-8?B?Mm1hMGFKc2lIYUk4aWtjY0ZiR0UrMWUwdmo3dHFCd3dDOUpKSFNzeVkrdDBU?=
 =?utf-8?B?ZVp6Q0NNNk5mMjRHSHlyT0oyTWdyQ3Y2YVh0WlJMbkRpUFFrV2dlbGhoOWkr?=
 =?utf-8?B?ZlRpUlVSNnhVV1NXano2dXFlU2Z0dmdkNmI2THFrTGhUa2EyM2lEdmNHUUdS?=
 =?utf-8?B?c3MzcndKajlYTzVPa3lveGZRTVYzZlpjamNYL2Qva0hSSHdSKzJJVlZxeXMy?=
 =?utf-8?B?NVhsVDhiV3VoNEJlME16L1RDbkc4K0ZRdGNpR0xGWlVMQnVwNWZPdmlGSUg1?=
 =?utf-8?B?cDNibGZPUXVQNWlLZlVTdDU2Q1BEWmFnUkJSMEVhdXJJaGppSGtCVlhaNFJi?=
 =?utf-8?B?enZzanpzRllrVVdPQWcvWFdheFVCeThZT0J1b2l6aDlJeko3VkdyNUdZM0tJ?=
 =?utf-8?B?a1B0TFFPSXdWYS95ZmdKQWpacWFieVNrY1ErYTlFU0d3V1lWRTNTaEcwVkRz?=
 =?utf-8?B?SU4rbTVhUmEzYUJhQ3hadFQrWmJ5L1JuZ3RyNWRkVS9IMGcydEIwY3FWZlFG?=
 =?utf-8?B?RDM0VHAxd1RtWk9saTZJSDlPODVwazlLWkJHZ29xK3BrWFREcmNoTDZmOWxz?=
 =?utf-8?B?akdVVzJvcDIrRUl1bDJmOEZJazZpUkRPRGdPek9lM2N2K00vMVNDdFlSSTFn?=
 =?utf-8?B?VUozcUNXaktTWklBYVlmcnZlR2UzMlBWak05Ull0anNJSnhiQUcyVEQ0SU5R?=
 =?utf-8?B?VzZzRXVWWnJKRlZ6N0FUYlhGazE4TmZnOWdkeTdPQVVrOXhBMStMUmhNekR2?=
 =?utf-8?B?dkt1KzlZK2Q3emFWSitGbkxmM0Fkcm1zcG9ZdnhVdVN0MU1BYjBXUVBKU2NO?=
 =?utf-8?B?VVViZjB5Vm9Cc25ITlU3QjgzRmQ4RXZteFF4c2VtazJQOUh3R3BJUDFZZllN?=
 =?utf-8?B?WWxtYnNPT1ErQWJVd3NxL0xjbzJWN3lqVEtOL2cxeFBaWXY3WTRTSW9vQ0dG?=
 =?utf-8?B?NG96VVhVR1c1RjRFVmFCbWxLNlJ4T0ZiZ3Q2OHA1dVVtQ3BUTS9wRkNycWdH?=
 =?utf-8?Q?RWPw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b1f5eb-f30e-4d63-5865-08dd86fcf2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 09:05:12.2496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DxV+nvhjau3w/3KiSKO0jdYzBHR7GYiY5TL7jXCz2eHd9MRusop960dpxeKeABG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAyOSwgMjAyNSAxOjU0IEFNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvM10gZHJtL2FtZGdwdTogb25seSBzeW5jIG9uIHRoZSBkZXBlbmRlbnQgcmVhZCBmZW5jZXMN
Cj4gZm9yIHVzZXIgc3VibWlzc2lvbg0KPg0KPg0KPg0KPiBPbiA0LzI1LzI1IDA5OjIwLCBQcmlr
ZSBMaWFuZyB3cm90ZToNCj4gPiBUaGUgZHJpdmVyIGRvZXNuJ3Qgd2FudCB0byBzeW5jIG9uIHRo
ZSBETUFfUkVTVl9VU0FHRV9CT09LS0VFUA0KPg0KPiBUaGUgZHJpdmVyIGRvZXNuJ3Qgd2FudCB0
byAqaW1wbGljaXRlbHkqIHN5bmMgb24gdGhlLi4uDQo+DQo+ID4gdXNhZ2UgZmVuY2VzLCBzbyBo
ZXJlIG9ubHkgcmV0dXJuIGFuZCBzeW5jIHRoZSBkZXBlbmRlbnQgcmVhZCBmZW5jZXMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyB8IDUg
KystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfc3luYy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5j
DQo+ID4gaW5kZXggNTU3NmVkMGI1MDhmLi40ZTFkMzBlY2I2Y2MgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCj4gPiBAQCAtMjQ5LDkgKzI0OSw4
IEBAIGludCBhbWRncHVfc3luY19yZXN2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+
IHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywNCj4gPg0KPiA+ICAgICBpZiAocmVzdiA9PSBOVUxM
KQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0NCj4gPiAtICAgLyogVE9E
TzogVXNlIERNQV9SRVNWX1VTQUdFX1JFQUQgaGVyZSAqLw0KPiA+IC0gICBkbWFfcmVzdl9mb3Jf
ZWFjaF9mZW5jZSgmY3Vyc29yLCByZXN2LA0KPiBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCwgZikg
ew0KPiA+ICsgICAvKk9ubHkgcmV0dXJuIGFuZCBzeW5jIHRoZSBmZW5jZXMgb2YgdXNhZ2UgPD0N
Cj4gRE1BX1JFU1ZfVVNBR0VfUkVBRC4qLw0KPg0KPiBUaGF0IGNvbW1lbnQganVzdCByZXBlYXRz
IHRoZSBvYnZpb3VzLiBXZSBuZWVkIHRvIGNvbW1lbnQgd2h5IHRoZSBjb2RlIGRvZXMNCj4gc29t
ZXRoaW5nIGFuZCBub3Qgd2hhdCBpdCBkb2VzLg0KPg0KPiBXcml0ZSBzb21ldGhpbmcgbGlrZSAv
KiBJbXBsaWNpdGx5IHN5bmMgb25seSB0byBLRVJORUwsIFdSSVRFIGFuZCBSRUFEIGZlbmNlcw0K
PiAqLw0KPg0KVGhhbmtzLCBub3RlZCBpdC4NCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+
DQo+ID4gKyAgIGRtYV9yZXN2X2Zvcl9lYWNoX2ZlbmNlKCZjdXJzb3IsIHJlc3YsIERNQV9SRVNW
X1VTQUdFX1JFQUQsIGYpIHsNCj4gPiAgICAgICAgICAgICBkbWFfZmVuY2VfY2hhaW5fZm9yX2Vh
Y2goZiwgZikgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqdG1w
ID0gZG1hX2ZlbmNlX2NoYWluX2NvbnRhaW5lZChmKTsNCj4gPg0KDQo=
