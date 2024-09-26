Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E628CDE009
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 13:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2256A10EB54;
	Thu, 26 Sep 2024 13:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n0JMi9AE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347DD10EB60
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFX7pAVV1NLCVALJCs9HNUh1zZHWpJ+hEiu5HEKOaFt10JPE9YM4TOC2u3NLV5FvG/8rVNejKAEbzBBgLke+sMULFv/qcBmAAp1zRui/aqZJw8+b753vAbuGWy3m3jMiHi/JDrRmSjYZyb1fzHiNDBCtQKNclq/QJgf9pHaBKjgmqn8qJQ1ViOsmWzJ0uJeyAgjQgeTYy7zqR1zXLTk2vadTYE63kD6iZLflfZ21FgcrikzSBPMZpH6Gqt/cEOEPk0OSomjAUB676oiRdnBtfQCVfourInk2seElutUlLBPwxEOTFQDjZWa++sufsZIp+XgJJID7YpiRmEZUDhS8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY57UD8dLdDMOBsR3v85iBfrA5AZTr941jg7jbZqVAY=;
 b=gnsZqXQraq9PplEUEvFzPlx2VCoEg8p0Ax7sk7QcYje6GmcrQQCkcaAKJREOO7SGX7Lg/H/qlXbKIX8LTd7RkGobyaSkNA9/NIHNOSDmJ9msruZATQXMoFYNpHjcwMhT5J5wpSGEFdC+66UlmwD6Mq/VvEUcSqKn4dlQYCDxR2NciwjHt3o7ErubmQBTordie/J22BY+I8PWOLOuXrhrKWgrF0onEnqc/RjM6+xweZmiFPXc9tmnGRTG0WM8YhYsLXXHAGk9X0q2FjZQFiH52HTtSOxwXmxZ+FcaYXXW2+pIn7K/UMHLf13gmHGTZlEFIlxrvVHNGI1EhRqG8Hj9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY57UD8dLdDMOBsR3v85iBfrA5AZTr941jg7jbZqVAY=;
 b=n0JMi9AEgNPyfzNNoeVVmELfIoGfE4A1extAKsDZI3B8Ok3ZtHWIYBbcO6xJrI52I6xIFVKPhSPaGn/GvLSHnjXUGCSlr4xLllZhUqtuX0vZJE38LZ5X9w1y/lnJv1hwUGvmCfPbzkIflPfyGKETRZaAy0Sfu/oxWiWMOt4N6Sk=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 13:55:55 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 13:55:55 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
Thread-Topic: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
Thread-Index: AQHbAIcx1U1U85X8LUWgNrj7aGuFxrJqM7CAgAACqOA=
Date: Thu, 26 Sep 2024 13:55:55 +0000
Message-ID: <DS7PR12MB593339B32878152F9F8FB223FE6A2@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20240906180345.2557849-1-alexander.deucher@amd.com>
 <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
In-Reply-To: <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=10e81de0-c22b-4418-ac70-41ce1ca504eb;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-26T13:55:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5933:EE_|CH3PR12MB9394:EE_
x-ms-office365-filtering-correlation-id: ada152c0-79fd-4bab-c116-08dcde32f114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NHBnZVVvUnRESUxtenhuWEgyYWRBM3JQamlBN1MvU3dXbUU4U2loMUloOTBS?=
 =?utf-8?B?UjFkLzU5MU15eHpiVFBaQU40MmFDUWtIQVgzeHFYMGtSVDNLOTRDMUk4ZXM4?=
 =?utf-8?B?TDZWTVNLSmQ4ZGR0Q3Bncy9VV3dVaVBQWUFQWjB0TWFTcTlsUmdabXZGV09z?=
 =?utf-8?B?a2o3ZXRaWkt4VGE3M0R4bGdxRDJKbjN2aU5IakFkWXlSNFdRQW1GM1kyeHo3?=
 =?utf-8?B?Tno3a1Z2WGZ3dHY3UGk0SzNweitqalUwSFpSMkxtNmg4THdKN3hlODZiZ0Rh?=
 =?utf-8?B?OGdwSzNadllicDV1Vk02NTRvVXc2UzRoeUIvQkozVW8rMkNIK0hxbWp6WGxs?=
 =?utf-8?B?b0FrZFl4SzEzNzRFRHNtL3VuZ1pwTjM2MHE0a3BKbzJLOFdGMmUwZk8xMjRt?=
 =?utf-8?B?VnJhU2tSYUw1YjkvWGlSUDM3RlhwNDQ1TlhQTE4reldpN25XWEdBMlBDQUhl?=
 =?utf-8?B?VGN2MkpZc1NyN2V2dXc2c0dycC9iNlUrMEhVWSt1WjZGS1FvdGgrbjBXTXhq?=
 =?utf-8?B?eWE1RHNLSG5tUWc4RGJ0RU1nem1jT0lFTDlxQzhNUnNlQjFTbndZVjJmOEY3?=
 =?utf-8?B?b2U3VWU2QkRtdmZzVW9SVHF1TGtnR1RHamNPbUNaUUhTdmE5U25taFo0SUFh?=
 =?utf-8?B?VzhwMTJVQXp6ZDB5UlNZMTBBSEFJS1NpbXp0QUx5blVDc3BKMkYrcTJ5SjVz?=
 =?utf-8?B?clpyYkNySGRlZUFHejEyMEg0REdSelBmdXduZmY1T1VlV3JvWCtMMnBrVGRl?=
 =?utf-8?B?RUdabGZtUXdoQXdlSURLWkhPRGV0dk5yYXlRaHh6cDJRZXJaQ2ozVGVsVkIx?=
 =?utf-8?B?eHFCejE5VU03aFI1OGlkcGRyQ2RzdHVkQWVWSThKcW14c2ZxSEhSWHJNbmFl?=
 =?utf-8?B?QThBdVVHRUZtc3JpRDY2cXNNdDZ6SytRbU15RmRGaFNRUTAwaXFVZ3BJVldw?=
 =?utf-8?B?WG9XaGFZajJiZjlUZWNidzZBV1kzUWpxTlR4cmpYblZybjlsNzVxOVBsM2Nt?=
 =?utf-8?B?VkFtUGZBSXlSeVl0cHFuRXVpQ3N3b1g4cytoSDVnSkpwUEpvbXZUc01MR2h3?=
 =?utf-8?B?M1Vxc0wwRFVZWnpRek15M3k5ZEgvZllwU1FxMEZsT0pRcHhsVUdScXIxRkRq?=
 =?utf-8?B?RithYTFBTlB1VVFOWUM1T29XbGRjUjV6NHRDODUvVktEYlJrdVJNS2o1R2tG?=
 =?utf-8?B?QXFTbm8xbnhkVjBkelFWRnJhZlRpaGJ1VThlZTJKNmh5eXh2VURkYW1FM0xM?=
 =?utf-8?B?UGN3QWphK2lNZS9JUHJVRnlmcWpqY2tpQmZVZHJYMlJSUlBmbUorRmtrc1Vt?=
 =?utf-8?B?S3FNWmdJWTdZTmx5bUFGci9yc05zSXVYN2twM3gxejYyTkw3T0FwRzNOWHVz?=
 =?utf-8?B?RFZvSXcyU2toQ01nb3Q5SUxLaDBPaHR5MURVSS9ZQ0FnUkVMZmRjVWRzQW5D?=
 =?utf-8?B?L2IySmxzWlFmOEdXWDJjdHJUcFcraW5nYjErMTd0eDJxa0NqTUV6c0tSYUF5?=
 =?utf-8?B?b2RhT3JCRldUSUxkYWtzdnN1bVNrWUdVdkhnRElyUGx4cFM5VjY2VnI3d1Rq?=
 =?utf-8?B?ekFYUWQxZm1MMEdHUDR5MHo3Nzdqc1E5M1hNcklqZlBQdklKTVBXWEphcWk5?=
 =?utf-8?B?Qzd1RUtkSElCYTdmSTB3RllLWVk3NmRzc1Q0NWJGU2hzV1JJMnRKdmZ5dWxR?=
 =?utf-8?B?VlQ4QUc5NC9FbERjK1FDQnZkN3NqYW9ldUIzT0Z4c3ZtOTBXRmJJWjQ5SDlq?=
 =?utf-8?B?aG51SFNPK2NhMzc4aXZvVDQrZ3JrYVV1NUN6b0lSNENsaHprZWxSOEcvQm5B?=
 =?utf-8?B?aXBvUU9pZFFiMUgxd0hBYkQ4d2dvdlFXMzBYSEZLRFMxUHd0V0NLdnU1ekdN?=
 =?utf-8?B?R2VWKzc4ZlJxVU1lOC9lMy9GU3doUklVOFp3LzVkOU9mamc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1JBdkhacUR0VGRHd2FRdWNkeFNvdk9JMWVkb1UrVnpmZ1JyanlITlJwU0cr?=
 =?utf-8?B?WDNFYVlyUkV5SHVnWlJ6bFhLT085aDFycHFHTzRTR3FVbUJNaDAvaVZEY1VS?=
 =?utf-8?B?eEdUcmNCRFpFZDlESXpPWEFpVWdhQ2ZRN2RjUmVtc0l2ZkhYMExtdEtwUjNp?=
 =?utf-8?B?S2FXaGhNYmhRaXg1YkJNWkkwY0xSUHlUbFNWeVhRS0NXbWw5d3JwQzhkdUpP?=
 =?utf-8?B?NzkxL2laMHY0ZnpXRWN0cmtGNGF4SHptVGlZbGtwZDJKcmg1aWdRUUpSZ0dC?=
 =?utf-8?B?Vm1GSVlFUWVXczNwWHpKbFFiZjYxTGVSSlAyRTVEMjVDa1J4ZVdnVm9MNW4y?=
 =?utf-8?B?YlNKSEw0T1NrWTJKek1NZDg5UDNwYk9DWVFJUzI4RDFyVFdlaFlHMXFqaXNy?=
 =?utf-8?B?UkJpK01hR1ZUOWM4OURTRVhHR3JHbHRHSGFyTHVabHdidHpIVzRnM3JRQmdG?=
 =?utf-8?B?YU1OY2NQaU5wMkt0b2ZDUGJmZmpBZWV5MXRrQjNSeVo2SHJTV3ZWd2hZdmo5?=
 =?utf-8?B?c0NDL0lZY2Q2OWpZOFpiS3pmTUR5VGZ3ckRkaVA2UUVPTjJEcCtGZGhtL3Rs?=
 =?utf-8?B?UmRjVDFRSVFRRGtnZWVORytKRGxpTVFDRm1hOGcxcnRhVE40bVA1aTZaaDNC?=
 =?utf-8?B?emx6WGl4Wjh3WEp1cEE4d0drYlRRYXl3MFlKZ3FPVk9ISjJZVWFPMzgvVUJG?=
 =?utf-8?B?NjBuWXpQcytWeGJId29UaU9pUEt5VjRrcDJIZ1BBMjM2KzVsQ3U0T1VEdkgw?=
 =?utf-8?B?N1lSYmV6ZElNSHVrSTYydi96NTZRZlZBZjhPSU9tYUdSVlk5RkRmT2tUdHVZ?=
 =?utf-8?B?UUlEK2FkOEFBcWNkcm1oZXNWY21sL3ZlMmNIRWpiNHgwVm1OZHlDbU5ZQjQ4?=
 =?utf-8?B?aHNveGxEOHhqRkZJY0FNWGFrWVlDUjloZjZIczI2SEp2Qkd6RmxqeC9MK2Zh?=
 =?utf-8?B?ZFFKY0kvbEozVzkyYWd0YzJ3OEZXT2pud2xpRDdWaUdNc05NSjl4VE5acHdN?=
 =?utf-8?B?ZHNaTks5MWlDcDlVR0hvdjdrb3VmS2Z6cTJRU2FWZ1Z1MDNtdHhiOFJROFFF?=
 =?utf-8?B?RVdKUWxISUhxbmxzQ1ZzNytLd05yaFVkbUN5QllKZDErN1VkbVo5cWZRSmg4?=
 =?utf-8?B?c2JFcEpiN0VhL1U4UmFKc0dpQ2czSlRnREtUUEJZMmxJb24wL051eUhvNStZ?=
 =?utf-8?B?dFFCdUZEZGRCQ2paMnR4UnpaV0hWYUhaTXc4bUNoSFFydU4wTGdkcUtQekJP?=
 =?utf-8?B?LzZrbWRVREZxaEdRYmdId2dmRzVtQm9xWFAwOHNXUlNjK3NHOGVQbHhGaERB?=
 =?utf-8?B?LzlObXMrMmNuMERCN0dpSk40b2JsY1prZFllVTBHc1RkdlZWR3NqWlpub1hF?=
 =?utf-8?B?NWtnN1VTclF4SHpiVERaNXpkblVkY1ppU2ZDV0wrdlRXMHVPczFDWHBsdTJS?=
 =?utf-8?B?SHU3bEU5dTQ4UzBScndnVm5ybWZ2dUNZRHJGYllCSW5ORFRnWjROUXp6d09Y?=
 =?utf-8?B?WC9zMmtWOUZyL3FWRU5LSjdVRnhFVDk4R1JHVWNFaUorNmdPdTFhcXppbVd5?=
 =?utf-8?B?ckpOeWVFSmFjWldxWWR4LzdSR0N6QWF2Wm82Rmphc1J5Y2Q3dnVjRlZUUnds?=
 =?utf-8?B?Vy9BRzhVeEtXT1doYnFxNzR3R2tnT1g0VVUzWE5wNzhFeEYxRU11eVhpVHRQ?=
 =?utf-8?B?VXBoRnBQNlhwVWMrQVE5d1ordnAxZENYSlY1MTY2UERyUGhML2hyb0JqUXoz?=
 =?utf-8?B?ZmdSVDJFdmZ3enA0UTc2bHBXaWtQS2h6TERycHdRclpmZk1od1JGUGRMWEVO?=
 =?utf-8?B?MGRaY3lPejM3b1d4TWtEQVhKSHN3UlI1UmNlTUROUXF0RkUzOG9aYjhGWTFP?=
 =?utf-8?B?UFhka1UrdDNPejBDZzRaYTRIZXpDOS9tYUozQ3JsRTNDcFYrZy9tOUVHNmdt?=
 =?utf-8?B?MnBkRWVRMjNuVlBXcm51eGlGSTIrMmdlN0tEQS9TcWYvMVBNVVJaU1AwNndN?=
 =?utf-8?B?VksyUDBtdWRheGRtVHdOL1NSY0lleEVOek5ITENESi9iaTlMdCtkNnRpNmVa?=
 =?utf-8?B?RlhyUGF5cDM5bnN1KzBzT1hUdGMyeHVWWkZUUVExNFRNM3BFaC90WTVueWcw?=
 =?utf-8?Q?PrIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada152c0-79fd-4bab-c116-08dcde32f114
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 13:55:55.3509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sd4ppr3UO3ybHnHnJB+w3l3JLmksAP+Ue037CliTeDnCDuXJCnqHO8eHJAoPFB/EzYZ9tkD1lj11Sl8olFarJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IFJham5lZXNoIEJoYXJkd2FqIDxyYWpuZWVzaC5iaGFy
ZHdhakBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFs
ZXggRGV1Y2hlcg0KU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNiwgMjAyNCA5OjQ2IEFNDQpU
bzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgT2xzYWss
IE1hcmVrIDxNYXJlay5PbHNha0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBidW1wIGRyaXZlciB2ZXJz
aW9uIGZvciBjbGVhcmVkIFZSQU0NCg0KUGluZz8NCg0KT24gRnJpLCBTZXAgNiwgMjAyNCBhdCAy
OjA04oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToN
Cj4NCj4gRHJpdmVyIG5vdyBjbGVhcnMgVlJBTSBvbiBhbGxvY2F0aW9uLiAgQnVtcCB0aGUgZHJp
dmVyIHZlcnNpb24gc28gbWVzYQ0KPiBrbm93cyB3aGVuIGl0IHdpbGwgZ2V0IGNsZWFyZWQgdnJh
bSBieSBkZWZhdWx0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYw0KPiBpbmRleCBkOTA0NzNhZWM5NDIuLmZhZDU1NmJlODQwYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBAQCAtMTE3LDkgKzExNywxMCBAQA0K
PiAgICogLSAzLjU2LjAgLSBVcGRhdGUgSUIgc3RhcnQgYWRkcmVzcyBhbmQgc2l6ZSBhbGlnbm1l
bnQgZm9yIGRlY29kZSBhbmQgZW5jb2RlDQo+ICAgKiAtIDMuNTcuMCAtIENvbXB1dGUgdHVubmVs
aW5nIG9uIEdGWDEwKw0KPiAgICogLSAzLjU4LjAgLSBBZGQgR0ZYMTIgRENDIHN1cHBvcnQNCj4g
KyAqIC0gMy41OS4wIC0gQ2xlYXJlZCBWUkFNDQo+ICAgKi8NCj4gICNkZWZpbmUgS01TX0RSSVZF
Ul9NQUpPUiAgICAgICAzDQo+IC0jZGVmaW5lIEtNU19EUklWRVJfTUlOT1IgICAgICAgNTgNCj4g
KyNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUiAgICAgICA1OQ0KPiAgI2RlZmluZSBLTVNfRFJJVkVS
X1BBVENITEVWRUwgIDANCj4NCj4gIC8qDQo+IC0tDQo+IDIuNDYuMA0KPg0K
