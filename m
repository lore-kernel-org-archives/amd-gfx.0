Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAE4C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 14:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCDA10E270;
	Wed, 16 Apr 2025 14:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MmQbdpa";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DC610E27A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 14:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzZbsQ7wCynnrJl5L1iufkmpdMAuWGMfa2hMiwSeida55nDAxmsz3ZKexX68WVLa+BpKWnmKsjszF40/ywz7cTx5Dm8Zjim3SUdaegxmI1CbaS8a1oc0tvx0AUIx/no/vqwf1rmV/6M3gyK6YEw9ogXS30R+47y9Ja/raZMWsBrC1vmYNylimBvak74MKvGlzKPbaIvpoUjb8XwwaRbFX+id6X/ekJBpqluRjh/7pdgFb9+RjfllnE/KT7q4vlg301eKggMhT4BZ3hirmMKrDXhkaBVxfmbdXGq2Ax4OnCWoV/xuKyip2/ygi6xpFK7O8qKAuG4uKCAGKuRXbCBbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ko0XFkrMjhgGs0UVb8UEyzyEtjsg0T0zRd2xH++6mI=;
 b=kjE5SJKV5kx58dwDm/DvwLcwkw4JDmiymm8oJTq0Ev90KfnuWHA8Dxv5++8n2BttF94+nsxVhSa3Ex4aGGC5r3Y4+7xxRxRp4WPpvccUgSSBXSySibx40ZHtbr+IloXMmbMV74mby6rigsJXl28vVNRmaXkQ3ctpgfECHJCFzjTQOnRwsQd3aOJ+rooykbV5lZJZM6IAf8UN6AqAL80MzkN1cEr1rW24bM3OQbFiUbseYrdiuzwZfTYbVFcXYR8jatUzUStj/P4wlJtptp9QdFx9G1GRwSAlR3CHfPvmxOKAXFLywy4KfLtvVwLdWD1Wmo2JiFBBIDZaAWUeTb4C+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ko0XFkrMjhgGs0UVb8UEyzyEtjsg0T0zRd2xH++6mI=;
 b=5MmQbdpacuozzjDGMzfKIwfuQEoaPi98u013gauqfeliUsr4XVXYW+myrFKJbxaMx97QdlhyUOxuLQiKCfjLdq1NAP1F9dF4ZxC4VpwReBtLiIjeiCfVwMXieBCLcX4YeGJKg6mPYHSxAlbO+R3C16YzCtKQ6aK/Oo9SHmdAPT4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.33; Wed, 16 Apr 2025 14:47:47 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 14:47:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
Thread-Topic: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
Thread-Index: AQHbrqynvBiGApICUUGwgJuYG7zG37OmIhMAgAA1VWA=
Date: Wed, 16 Apr 2025 14:47:47 +0000
Message-ID: <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
 <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
In-Reply-To: <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1399219c-b37c-432e-8512-52d7af5e250a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-16T14:18:19Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CYYPR12MB8889:EE_
x-ms-office365-filtering-correlation-id: 5515adb6-9020-45fb-621d-08dd7cf5a760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ME5ReTRnRk1KQ0lySE1zOStQWmxacE5QT0pxYzZSWU15RS9LQlpjZzNzamll?=
 =?utf-8?B?TUpRKy9PZ1A5VmNpNWhCRXlvWG9lQnduZzhjZWFaOXZ4eEFvb0N4cll5czcx?=
 =?utf-8?B?cnBDZFNiMnBmaWxKdisxbHFndFVkMW9mTklCRTRicUN1UkdCYXNTNjFwOCtr?=
 =?utf-8?B?WE1DTTFOa3pxUzlnNzRab2Qzc3hiMFdxbkhVMHRURENRdjI4Mk1DeWpaeUJM?=
 =?utf-8?B?d09xdlVHb3JjYVVQZjhCbzU3TWlWdTcwMmhJbzNFbTIybW9tOTV3cnczb2g0?=
 =?utf-8?B?Sk5NTEVEQ0ladEduekIrdjZxZmU1WUxVd25EZUlUM3pySURpeXF0MWVFVnFB?=
 =?utf-8?B?YW5NZTJHanpVMUNYMnZKMWN1ZzF6aHRhZjIvbmhRNndyRThJSEdKZk8xRVBN?=
 =?utf-8?B?ZW1Zd3ZnOXE2VXJIY1h0UFAzYnhEMDNIUmpmTXJZcCtPbThoS29MZXFvWVBk?=
 =?utf-8?B?bDIrZmlQMTBtWUYzMWpLQlZNY282N0NieGxzV1VqdzI0UERNNzN4dG95TXN6?=
 =?utf-8?B?dVZ2by9DazJ0OEFlVUkzT3I0QXgyQmN0dUZIYUt4VElPN05rUDRNTzZPV01G?=
 =?utf-8?B?WS9CNFRWeG0wL3ZUNDBNTmlIdEVabzJQQ0xtS2dLT3FnT3hXOHpoQTQwRCtm?=
 =?utf-8?B?bGp0Um9qckRZSVRkSVJJTGpqUWVZNHhBQjd1eGJpdkhyR1J1YWxHRlpoREpl?=
 =?utf-8?B?dUEyeGprbDZXMGxuUUE2Mzh0OTVkTnQrY2NKTVpJQ3grVWNJU29xd1pCc0da?=
 =?utf-8?B?NGg2V1JpNWxQdTVEZGdaZFlRR1M1WE1BYmNzSXYxOHIvK2NxZkYyYzE5UmxH?=
 =?utf-8?B?cFZCdmN2bEFGajA3L29oa0RuMUR0ZVR0cXduZnNQUmI3UG12SXY1ZFQzb3pR?=
 =?utf-8?B?WGh1dHROTldiY1hxUURiZzI1Q01HL3MzdTMzemFkZWtzcHlJcFliUkdxUGF4?=
 =?utf-8?B?cjhKbkJkMDA4S2wzaDBxNFc0SmhMMHhZTjUrTmU5aTg5eUY1OGV0MHAwYXZo?=
 =?utf-8?B?WkxLWksxZGJxTy9MWk9QTGlEMmdYZHZRaStJOVRmQW5KT1NMajN5MDEyWVZP?=
 =?utf-8?B?aGE4WWNhd3djTE1VRXd5aTNSd01EK3JILytvOWFsNUFZM2F6cW9wR1VhL3JC?=
 =?utf-8?B?b2JZLzlwNk1KdUtiV0VSaGtpbUFPUlp4TEdHMzdkREpWazdrVWRadWJhQ3Jn?=
 =?utf-8?B?Vk43QXBpNUY5d3FLcDI3UG5taFVTQ0piU01Xb052OEQ5R2VRb2lNS3UxYjdx?=
 =?utf-8?B?SGhFcVFIb0sxQnBrZjJoUWdtY3BPeUFzbVAvYmRIcFZ3eHZOUnIzL3hLcEla?=
 =?utf-8?B?WTdBek1pcnFwZEwvRXlGUmRQNS8zK0s0MmxlRUpjL1JXWTY2b1p1UGRMY3JX?=
 =?utf-8?B?bzhpNmF2K3pRY2ZmL3lxRTlFVzU0WjdXTUZnYllGN0YzWC9BQjc4R29PVUN2?=
 =?utf-8?B?MmtVYUVZTEdhVTFxWVJ5SUhRcVdrZE9QY3BlVk91a0Vnd0tiUkxKTnMwVjNz?=
 =?utf-8?B?WUZNTWhsUVNreUhmWi9oVEVUdURVUFh2ZXlQd3hFaklhVUpVT1hMbHoyWlJm?=
 =?utf-8?B?SERnUjhLVXFWbWxZS2ZuS2JVTHgxamJLeXVwTXppdTFENk1QWmdNQkVNNlVu?=
 =?utf-8?B?MnpvMGJmMDdyMjJWdlR5K1dXRjdMc09xZ2VNVjRPODN5bzhieGFzWTVGamgy?=
 =?utf-8?B?SVBPU1VvYXZXaTd6bCtRSXJDbXB6Yzl4K1lLcnZBSnpjc1dzekNlODF5VVEz?=
 =?utf-8?B?Q0V5L1ozekxnRGgyWEZNNjhTeGMrV25KaDRYOUZsN2hSV1JhQ0k1NDczZnFH?=
 =?utf-8?B?WlBKU2ExZWhGcC8zOUFoN1psWVBXbW1zZ2laMXlGcy8rTGpRWTNoVTcyMWFi?=
 =?utf-8?B?YmZsQ1pnSnZSVGxKOXQ0bXdIb1BaRmhwNmN6U3MzZHc5Vmxmc3ZNOWltZWc1?=
 =?utf-8?B?S2RSL3g2MU5EVWZCL3hDTzJSYlU3ZktxN0NZS3dEZEJlaTMwNWRmV1N2ekJw?=
 =?utf-8?Q?PyCXIrf/41f5WazEzPpk8x/5jSxook=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFQrTlRBanZ6VTY2QlFPc3ZZWEEvalZLMHpWMkpLelJ5am5pRHFrWktxdHNH?=
 =?utf-8?B?NjV3M2k3NXNBeW1GanhmeklhajhXbjh1L2c3U2Q4WkhLOHplY3JyeVd0cEFB?=
 =?utf-8?B?NzRyRUVlUlFhcHEvMFNWMlFwZTVkcko2bmlrOExNWTYrTy9DV1JRMm9Makc2?=
 =?utf-8?B?RnZCM091UFBUenBHamdPZktoZXE0TU1TVHRUL3o4UnkxcFFMWWZncmdPWmJr?=
 =?utf-8?B?ci96a2xEcG9GWWxmQjZ2NFdydHM2NUs2M2U2UHp3T1JiYzJ5NFQ2ZjdDYmxx?=
 =?utf-8?B?QU5FL0JacWlpVFdDK1lyb2wxeC9GWGtGZWVybjVlaTBJbFlsbFp3OE9lempu?=
 =?utf-8?B?WFlKSzJvc3NHelg0OXFBL1NleGh2VU9WYWFUZmVtT3ZFZG05STdZSFNZWTBV?=
 =?utf-8?B?NVk4SnpuR2dhR2QrYWpDeWVqYzIwMUtOZ09sRjJyTHZkZ0ZkclA0SHNkL21X?=
 =?utf-8?B?QTUrMnJZL2NzNEJwSVZFWUppazh0MnhaVGcxUVVvZDlVOTF0N25oTGFnZ05w?=
 =?utf-8?B?bXN5WSs0WnJycmR0NlphZFdFaTdzY0kvQnY1SVEzUlYxaFBKNFFSSkRwaytm?=
 =?utf-8?B?bDRGcmJUQ0J5U1JsdFhMTzl6MzhyYUxrSHliQ25NTzJVblcwVkl4OWRoUHk4?=
 =?utf-8?B?K3hvZlM1U2xGb1prSHhjaHFPeU5zZE9JNEhURWtNVmc3NnZYZWJzWkNLSXpw?=
 =?utf-8?B?R1gycGxjYnZoZUZFc1VVSVovMHVYd0xjaTNySENGVjlVWGY2bHVIUk1aVmJk?=
 =?utf-8?B?WmZ4OHFNZU80K0RoajM1V3IrYzkwaHliRTlRclRIY2ljbklMd0xZdmc1SFBX?=
 =?utf-8?B?bVJwU0Y1L2hvelFNTVQwZFhiSnh4L1hJclRqeVN6ZmZKQlBrVFVsVmJKNUFR?=
 =?utf-8?B?aVo0MWtnS1JXQlhLcFRzZkoya0N5MUhKcnNQeXc3dTJzQkpNK2Y3NUkyQXUy?=
 =?utf-8?B?ZThZaVR3RUk0MWx6SGRMQ0Q3WiswTTlMdjVNaytPemVFZDFZaUJCR0R5YWFJ?=
 =?utf-8?B?ZmRDaVR5OGZXUDJtVTVpZWhvcEJ3M3FwTWUyZDM2eGlWUGp0aDhNWlRqYWdh?=
 =?utf-8?B?YTdPbWhFb3BmN214a0p3MlUwVXZPNU5OZkVGbEFEbjBvZkJaNnJaeEVsZllB?=
 =?utf-8?B?b3JOVG1aRG0vVVNQNjg5NDlQTjR3WmhLSG9DdENQV0NQck01VDdKSjVJa25I?=
 =?utf-8?B?a3FJQVhxTVlXd1NVc1BHbnd4RkpSMnZNU3laZE5DdW1yV3NGSy9YL1VKcGpO?=
 =?utf-8?B?eDdObWZHVjNGcFlPMzY5b1U3R2UwdU5zaXNDeWJEaU81SjFMSmRpcmhmZ0Ex?=
 =?utf-8?B?T20yL1VxVjltV0dxeHF4cWlmeEVpaW0xR1AzM3l4UnVGZDUzZGgvbndMMkNv?=
 =?utf-8?B?U2NBTUwwVG1SU1IyTFJrZGpSQ3c3Tk4wTE1rNlB2ZG40L0RoajhHTWZkcEEy?=
 =?utf-8?B?VFhoT01BRy96UExCRXluWkhmV3Y5QzQ3M0RoMy9UZUcrS0p3YTlpMzBoU1ds?=
 =?utf-8?B?RUl5UmMwNVEzRjhsbS9NQzZHcHNzU2tvbkxPSVZCRTNEZFBqYUdnZEtpSnpI?=
 =?utf-8?B?OGxQeHRjZVZOdU5GUXpjZ1BMeElKdHBoZVg2Y2pydEw1ZnJTKzJsSzdwYkFz?=
 =?utf-8?B?TzB5Y1ZCT1lKYk0yTFFsSWltN1d1dDJNR09aLzJQdXk1TWdiRERLdk9Rdk5T?=
 =?utf-8?B?ekJidWZtaXlublR3anJuWldNVy90akNhcnIzWFVZYXJCUSs1SE9wN2RFZDV4?=
 =?utf-8?B?cjRiQWtROTNFWXZBcXd1ZnhERmtRaE9ESnhGTEE0NE90WHRmQXJoY2F3dFlo?=
 =?utf-8?B?SnBvWGdGOC9uZjhiQStIV25XWE9qNGlMYU1QOGMzbCtkeW40NUZ6TXZ4VHZ5?=
 =?utf-8?B?a1U5Y2xwQVZESjNJL3JYQ3pXTys4VDJiMWFSNGlLU2VGeVp4YnRUV1h1Qzdx?=
 =?utf-8?B?Zk9vbnRFem45T3l2SDV1UklaeHNOUVdaWm5CRjgxVU9JY2FSYW1UYWNpY1Bz?=
 =?utf-8?B?c0RQdmdrZTBWaDdQNm9NVEczOUlDZjhTdUxGbFJpSWVUeVNsdVgvNTZKQVhQ?=
 =?utf-8?B?dGtnZjd3UUVhQUFNbXFGZnVqZFdkV3o2aVhrZ25hVkV0amozMHgzV1dqSDl5?=
 =?utf-8?Q?IoMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5515adb6-9020-45fb-621d-08dd7cf5a760
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:47:47.2924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ji14g8jHMM4i/TgnrZk6WiMweceqboXiMgLONLFjHc1wIX90eHdz+P6A85OtcPw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1IDc6MDcgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBkcm0vYW1kZ3B1OiBmcmVlIHRoZSBl
dmYgd2hlbiB0aGUgYXR0YWNoZWQgYm8gcmVsZWFzZQ0KPg0KPiBBbSAxNi4wNC4yNSB1bSAxMDo1
MCBzY2hyaWViIFByaWtlIExpYW5nOg0KPiA+IEZyZWUgdGhlIGV2ZiB3aGVuIHRoZSBhdHRhY2hl
ZCBibyByZWxlYXNlZC4gVGhlIGV2ZiBzdGlsbCBiZSBkZXBlbmRlbnQNCj4gPiBvbiBhbmQgcmVm
ZXJyZWQgdG8gYnkgdGhlIGF0dGFjaGVkIGJvIHRoYXQgaXMgc2NoZWR1bGVkIGJ5IHRoZSBrZXJu
ZWwNCj4gPiBxdWV1ZSBTRE1BIG9yIGdmeCBhZnRlciB0aGUgZXZmIHNpZ25hbGxlZC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMgICAg
fCAzMSArKysrKysrKysrKysrKysrLS0tDQo+ID4gIC4uLi9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZXZpY3Rpb25fZmVuY2UuaCAgICB8ICAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jICAgIHwgIDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gaW5kZXgg
YjM0MjI1YmJkODVkLi42MGJlMWFjNTA0N2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+IEBAIC0yNyw2
ICsyNyw3IEBADQo+ID4NCj4gPiAgI2RlZmluZSB3b3JrX3RvX2V2Zl9tZ3IodywgbmFtZSkgY29u
dGFpbmVyX29mKHcsIHN0cnVjdA0KPiA+IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3IsIG5hbWUp
ICAjZGVmaW5lIGV2Zl9tZ3JfdG9fZnByaXYoZSkNCj4gPiBjb250YWluZXJfb2YoZSwgc3RydWN0
IGFtZGdwdV9mcHJpdiwgZXZmX21ncikNCj4gPiArI2RlZmluZSBmZW5jZV90b19ldmYoZikgIGNv
bnRhaW5lcl9vZihmLCBzdHJ1Y3QNCj4gPiArYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLCBiYXNlKQ0K
PiA+DQo+ID4gIHN0YXRpYyBjb25zdCBjaGFyICoNCj4gPiAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNl
X2dldF9kcml2ZXJfbmFtZShzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSkgQEANCj4gPiAtNDcsNyAr
NDgsNyBAQCBpbnQgIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9yZXBsYWNlX2ZlbmNlKHN0cnVjdA0K
PiA+IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3IgKmV2Zl9tZ3IsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2V4ZWMgKmV4ZWMpDQo+ID4gIHsNCj4gPiAt
ICAgc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZSAqb2xkX2VmLCAqbmV3X2VmOw0KPiA+ICsg
ICBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlICpuZXdfZWY7DQo+ID4gICAgIHN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqb2JqOw0KPiA+ICAgICB1bnNpZ25lZCBsb25nIGluZGV4Ow0KPiA+ICAg
ICBpbnQgcmV0Ow0KPiA+IEBAIC03Miw3ICs3Myw2IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9y
ZXBsYWNlX2ZlbmNlKHN0cnVjdA0KPiA+IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3IgKmV2Zl9t
Z3IsDQo+ID4NCj4gPiAgICAgLyogVXBkYXRlIHRoZSBldmljdGlvbiBmZW5jZSBub3cgKi8NCj4g
PiAgICAgc3Bpbl9sb2NrKCZldmZfbWdyLT5ldl9mZW5jZV9sb2NrKTsNCj4gPiAtICAgb2xkX2Vm
ID0gZXZmX21nci0+ZXZfZmVuY2U7DQo+ID4gICAgIGV2Zl9tZ3ItPmV2X2ZlbmNlID0gbmV3X2Vm
Ow0KPiA+ICAgICBzcGluX3VubG9jaygmZXZmX21nci0+ZXZfZmVuY2VfbG9jayk7DQo+ID4NCj4g
PiBAQCAtMTAyLDkgKzEwMiw2IEBAIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9yZXBsYWNlX2ZlbmNl
KHN0cnVjdA0KPiBhbWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyICpldmZfbWdyLA0KPiA+ICAgICAg
ICAgICAgIH0NCj4gPiAgICAgfQ0KPiA+DQo+ID4gLSAgIC8qIEZyZWUgb2xkIGZlbmNlICovDQo+
ID4gLSAgIGlmIChvbGRfZWYpDQo+ID4gLSAgICAgICAgICAgZG1hX2ZlbmNlX3B1dCgmb2xkX2Vm
LT5iYXNlKTsNCj4NCj4gVGhhdCBjaGFuZ2UgbG9va3MgY29tcGxldGVseSBpbmNvcnJlY3QgdG8g
bWUsIHlvdSB3aWxsIG5vdyBsZWFrIHRoZSBvbGQgZmVuY2UuDQoNClRoZSBldmljdGlvbiBmZW5j
ZSBpcyBhdHRhY2hlZCBhbmQgc2hhcmVkIGJ5IGFsbCB0aGUgcmVzdG9yZWQgdmFsaWRhdGVkIFZN
IEJPcyBkdXJpbmcgVVEgcmVzdG9yZSwgYW5kIGF0IHRoaXMgcGxhY2VtZW50IHRoZSBldmljdGlv
biBmZW5jZSBpcyBvbmx5IGRldGFjaGVkIGZyb20gb25lIG9mIHRoZSBCT3MuIFVzaW5nIGFtZGdw
dV91c2VycV9yZW1vdmVfYWxsX2V2aWN0aW9uX2ZlbmNlcygpIHdpbGwgd2FsayBvdmVyIHRoZSBy
ZXN2IG9iamVjdHMgYW5kIGRldGFjaCB0aGUgZmVuY2UgZnJvbSB0aGUgcmVzdiBvYmpzIHdoZW4g
ZnJlZWluZyB0aGUgQk8uDQoNCkJ1dCB0aGVyZSdzIGEgcHJvYmxlbTogZXZlbiB0aG91Z2ggZHJv
cHBpbmcgYWxsIHRoZSBldmYgYXR0YWNoZWQgdG8gVk0gQk9zIHdpdGggdGhpcyBwYXRjaCwgdGhl
IGV2ZiBzdGlsbCByZWZlcnJlZCB0byBieSB0aGUgU0RNQSBhbmQgR0ZYIGtlcm5lbCBxdWV1ZSBq
b2JzIGF0IHRoZSBjYXNlIHdoZW4gZW5hYmxpbmcgdGhlIGtxIGFuZCB1cSBhdCB0aGUgc2FtZSB0
aW1lLiBUaG91Z2h0cz8NCg0KPg0KPiA+ICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICBmcmVlX2Vy
cjoNCj4gPiBAQCAtMjM3LDYgKzIzNCwzMCBAQCB2b2lkIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9k
ZXRhY2goc3RydWN0DQo+IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3IgKmV2Zl9tZ3IsDQo+ID4g
ICAgIGRtYV9mZW5jZV9wdXQoc3R1Yik7DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIGFtZGdwdV91
c2VycV9yZW1vdmVfYWxsX2V2aWN0aW9uX2ZlbmNlcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibykNCj4N
Cj4gUGxlYXNlIG5hbWUgdGhhdCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfcmVtb3ZlX2FsbCgpLg0K
DQpOb3RlZC4NCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gK3sNCj4gPiArICAg
c3RydWN0IGRtYV9yZXN2ICpyZXN2ID0gJmJvLT50Ym8uYmFzZS5fcmVzdjsNCj4gPiArICAgc3Ry
dWN0IGRtYV9mZW5jZSAqZmVuY2UsICpzdHViOw0KPiA+ICsgICBzdHJ1Y3QgZG1hX3Jlc3ZfaXRl
ciBjdXJzb3I7DQo+ID4gKw0KPiA+ICsgICBkbWFfcmVzdl9hc3NlcnRfaGVsZChyZXN2KTsNCj4g
PiArDQo+ID4gKyAgIHN0dWIgPSBkbWFfZmVuY2VfZ2V0X3N0dWIoKTsNCj4gPiArICAgZG1hX3Jl
c3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNvciwgcmVzdiwNCj4gRE1BX1JFU1ZfVVNBR0VfQk9PS0tF
RVAsIGZlbmNlKSB7DQo+ID4gKyAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5j
ZSAqZXZfZmVuY2U7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIGV2X2ZlbmNlID0gZmVuY2VfdG9f
ZXZmKGZlbmNlKTsNCj4gPiArICAgICAgICAgICBpZiAoIWV2X2ZlbmNlIHx8ICFkbWFfZmVuY2Vf
aXNfc2lnbmFsZWQoJmV2X2ZlbmNlLT5iYXNlKSkNCj4gPiArICAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KPiA+ICsNCj4gPiArICAgICAgICAgICBkbWFfcmVzdl9yZXBsYWNlX2ZlbmNlcyhy
ZXN2LCBmZW5jZS0+Y29udGV4dCwgc3R1YiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRE1BX1JFU1ZfVVNBR0VfQk9PS0tFRVApOw0KPiA+ICsNCj4gPiArICAgfQ0KPiA+ICsNCj4g
PiArICAgZG1hX2ZlbmNlX3B1dChzdHViKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgaW50IGFtZGdw
dV9ldmljdGlvbl9mZW5jZV9pbml0KHN0cnVjdCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyDQo+
ID4gKmV2Zl9tZ3IpICB7DQo+ID4gICAgIC8qIFRoaXMgbmVlZHMgdG8gYmUgZG9uZSBvbmUgdGlt
ZSBwZXIgb3BlbiAqLyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmgNCj4gPiBpbmRleCBmY2Q4NjdiNzE0N2QuLmRhOTlh
YzMyMmEyZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZXZpY3Rpb25fZmVuY2UuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5oDQo+ID4gQEAgLTY2LDQgKzY2LDUgQEAgYW1kZ3B1X2V2
aWN0aW9uX2ZlbmNlX3NpZ25hbChzdHJ1Y3QNCj4gPiBhbWRncHVfZXZpY3Rpb25fZmVuY2VfbWdy
ICpldmZfbWdyLCAgaW50DQo+ID4gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX3JlcGxhY2VfZmVuY2Uo
c3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3INCj4gKmV2Zl9tZ3IsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2V4ZWMgKmV4ZWMpOw0KPiA+ICt2
b2lkIGFtZGdwdV91c2VycV9yZW1vdmVfYWxsX2V2aWN0aW9uX2ZlbmNlcyhzdHJ1Y3QgYW1kZ3B1
X2JvICpibyk7DQo+ID4gICNlbmRpZg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+IGluZGV4IDFlNzNjZTMwZDRkNy4uZjAwMTAxOGEwMWVi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
Yw0KPiA+IEBAIC0xMzkyLDYgKzEzOTIsNyBAQCB2b2lkIGFtZGdwdV9ib19yZWxlYXNlX25vdGlm
eShzdHJ1Y3QNCj4gdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQ0KPiA+ICAgICBhbWRncHVfdnJhbV9t
Z3Jfc2V0X2NsZWFyZWQoYm8tPnJlc291cmNlKTsNCj4gPiAgICAgZG1hX3Jlc3ZfYWRkX2ZlbmNl
KCZiby0+YmFzZS5fcmVzdiwgZmVuY2UsDQo+IERNQV9SRVNWX1VTQUdFX0tFUk5FTCk7DQo+ID4g
ICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiA+ICsgICBhbWRncHVfdXNlcnFfcmVtb3ZlX2Fs
bF9ldmljdGlvbl9mZW5jZXMoYWJvKTsNCj4gPg0KPiA+ICBvdXQ6DQo+ID4gICAgIGRtYV9yZXN2
X3VubG9jaygmYm8tPmJhc2UuX3Jlc3YpOw0KDQo=
