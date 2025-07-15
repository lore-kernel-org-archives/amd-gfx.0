Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E9C83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 12:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDF410E59B;
	Tue, 15 Jul 2025 12:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1WJpT9r";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4093010E59B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 12:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUImDFA2F4VJu3QAs8FvAHrToQGYl0OQ8lAsLgopCiwhxCDzRvDwX6DYL5GzItZXyw8CitoUPsIbrEKZlQT1QRW9Ysbf6q/jsZOpuzz8DZIO+sTxWm7pOs87HAsKrxci3AVrxYIy6waCqttOm3QOdcTwC4W9YGjk1dVJ6Y8F/YGET4BnnjCxh/PqZKwzW5Y9Y+GjetUxKQXnEvtjFvKG/fAx6f8sHTi4sug2l4/+DCtvuP8aJosYvVeVTyJWOk/okBKHPV9y2YkgRMgxXc47RQT6ynSaqPdbY6imQMWIQoPVxZBbAxndRrIfFx/BvBLWpEDMN08Fuv0tBc3cdp96+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjWUWokomq5O/YJn4/9XnfKEiKGVQ3jdwmnkq1HHlZc=;
 b=beqh+7BRVYyBj40yqZcGfpjaGbt1ipmtTm4cTt1iKIRjnEkQtvlCmrR5eFZ75XCdzdA0rdJV6ZDzNXBDx3bYPErcG8MBkKRvm/Y4EVWTahdAdOcXVYMQVOe3ZiyWKPPyASKyNPklnRwwviHsCEbZRRkxtnm28eXFSv9F3tuGf8JS3Pd/EXR1Px4Guew0ITXxJgR0DUd/t+imzImlrsyCV7kzSNuVZE6/TLTmRL3pHI8BmvuAg+JdWqBJz/anmlqNVuwYXeZ4oTkA+CYLW4POCyVKnF6g2pZ9aTaDuCJb9q7HvYYfl/KK/DnLZFWNzZ6UjtgeFcGB/ZNbqccteu2L6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjWUWokomq5O/YJn4/9XnfKEiKGVQ3jdwmnkq1HHlZc=;
 b=V1WJpT9rv0iDhnxjh7lTYgFcOmIR8klkRdIRA2hZACOTJrYRu544VysJjHXmiun4CDcFowSRNlLISUgLrSJd6yoKw876zc5T8/6qYDXL0SGxTrsRX8ZSvG23Qh5sgoA2XFleMgbRqvtkxZK5ye/5Zp4zSm9peeCBFvODM3MdZDU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:05:30 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Tue, 15 Jul 2025
 12:05:29 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Thread-Topic: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Thread-Index: AQHb8kfAwP2djJW01kemEhcjO4364LQs1S6AgAZFFoA=
Date: Tue, 15 Jul 2025 12:05:29 +0000
Message-ID: <DS7PR12MB6005F4C0545356AE60FB5606FB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-6-Prike.Liang@amd.com>
 <f391283e-8e3c-4d07-9da4-8bfac73342b5@amd.com>
In-Reply-To: <f391283e-8e3c-4d07-9da4-8bfac73342b5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-15T11:55:58.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS7PR12MB6333:EE_
x-ms-office365-filtering-correlation-id: 47c972df-99b9-4b75-06bd-08ddc397e478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OExSdnhlQ1plQ21USjJrMUY4bWUvRzJpQytuMUhpYVY3UGFlNUpldnFxTk9T?=
 =?utf-8?B?WnpyK3BzQ2VjbGdEKzZ3MGsrVWptc0pKemp1VUJSZ0hHTmVLTk8wekZNcGIw?=
 =?utf-8?B?NlpadndWT29Dclg5cHVxb1l0WkpFK3RRR0lrV0ppNWZxV01obmErWFM4UUFG?=
 =?utf-8?B?RDh1ZTlqVFJuN2prbmJRcjd6bk5scEFhSzFKWXJLK1BhTGpoQWVsd0E0bHBB?=
 =?utf-8?B?N0hOTjlrWmhwaVdvWWdENmNkSnlXZXBSWnJ2WGk1bFk5TjBOVVg4eEJqaVlO?=
 =?utf-8?B?d0ZJTTdtanoyc3FIOFNLVmR2OFdqaUtOdS8zeEg0dlhMU0Rjb2ZUM1ZWc3RY?=
 =?utf-8?B?R1ZPVDBQcVBzM3R0cUhvR1BQQ0hXR3Q5eW9jeWxsUWFlSGVPUlJadlFQbFUv?=
 =?utf-8?B?SW9sVTlvT0k3U1BGZURBYTNUekJOV0s4ZC93RHpRd3lhcUxXTXFueW1iWkVy?=
 =?utf-8?B?c29FVFJXemhUOERnazBFdzQ0OWJPRTdYQ0JJMUJtS0xMWHdiWTRoVnRjS1pq?=
 =?utf-8?B?QjJrQ1pFNG52dkVJMWs3Vzl2N3hqbU5XeDUyb0JFVEN3Y3ZwWWluYSszMDZt?=
 =?utf-8?B?RlVhMUtneTNLbENYb1hQZW9tcjNjLzlPais3VEI3Z2o5MUk3TUxjbklFYS9w?=
 =?utf-8?B?QUsxUTRZbm9QYnYwSmZ2V0VhT3RVWG44VHJsNWRkZjFYcmFmT2VKdHhJZWlU?=
 =?utf-8?B?UWcwOVZtcEVqMVVOOE8wQXBBRTc1SElBa1FHR3NsZ0M0VFdmU1UyMFd4OGFv?=
 =?utf-8?B?dHJwQ2w0ai9VWTJpYlZ2WVdjOGlobzFmMXM5Y1hHWWFjTEhHWUZZYytlc2lF?=
 =?utf-8?B?eUR1RXY2V1haaEJZbUdVanJhUFZETy82cVZ5Qkd0L3d1SmFRbzNnTWZnY2w4?=
 =?utf-8?B?NHVMM3JUSmtaTDJCWVlsNUNoYzRFQWxsT2hJQWFOT1dDMmxvZ0pSWElYaDFH?=
 =?utf-8?B?NU9KZU52KzV5TTJBVGhVZkNlVEVpYlMxczJHVVI5MkxnZEh4RVV1RnpNbExl?=
 =?utf-8?B?U1JGcjgrckV4MkwrVGxZQ0hLOUFjQ25OdEY4U0V4cEttcm80NjlSeUIxZ3NX?=
 =?utf-8?B?d2ZZY2VuL2tncFNCb3VPYnc5K2xkREdQT3NGcWhhOVZoSWZ3R0FzZmFOWFJa?=
 =?utf-8?B?K1JyRWlmbG1jY2hicXZjbjZPVGVIR0t1cmdhV1BDY2dVZ1V4SnhKb2tUUGNX?=
 =?utf-8?B?c2RKWXRaQk1NaFZ5UWVqSjk2TVF1UWdlbU5tcytjYmVrMno0VHFMemhpL0tm?=
 =?utf-8?B?cmJ2NUMyVU0yR0lEZXRlYlJMekx6M09UWlN3aFdYSTdtaXpEN1RPa05ycmhL?=
 =?utf-8?B?YjlFL0NCUWJLYnpsVEpkTDRDNHpsRTMrcm5OQlg3OStZUUp4MitSRXNtM1pB?=
 =?utf-8?B?ZWtlRmsrS2MrbWRKdDBUeGlUaVppc3ZMbGYvMXBrbWgzSVpPVEh3bzRySW9L?=
 =?utf-8?B?aGdVNUVTaWszL29FUGdnTFZ4R0ZOU2hvcFJlbHR2ZHZZNVBxSVpDTHFPbC9P?=
 =?utf-8?B?NzdPOHR0VUpIRmk1dlFBdFpVaGxRN3dqNW9wZkx6Tm9kb1cyaWVhYllMeVJy?=
 =?utf-8?B?Y1Fjd21TVkxoS1J5NGpYMFlEYVpNVlBsVVpybmNIaldmNUdEWWpXQTVXSVRa?=
 =?utf-8?B?VW5qTHgvT0FSbldXSUVXcVJVa2JRUjNySVYxZzNJOWhtQXEzckowb1I3OXh6?=
 =?utf-8?B?bnFIaG9mTkNtZHVxZlBWZGRELzVKbnc5YXduWnRFbFIzMStRUk9UQ21NRzVL?=
 =?utf-8?B?ZGVoRGZHVTJLRDZRbDhzOFpFSUNQTWtBWTQ3OHhuVkNLbXdIZXkzZ0k4SEdV?=
 =?utf-8?B?ZzVibUdXbzhPc3IvUCtXQncrc3IydU5xRXR6SEV0WWhTSUV3UUR1dXdDS2U1?=
 =?utf-8?B?VWtDUHkrUW80QTRFMVNIemhla3JYdnlYNysvT0FJWEdYWmRQYXFKNU9lUkd4?=
 =?utf-8?B?Ym5zSzlObE1pWTNCd1NDdmRjYVFCaE1PdWlvb3hCZXNXQ25qb0pZZHFJeGd1?=
 =?utf-8?B?TnYvNGRBV1pnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHRJcnVXdm50MjltZld6QldmeXcwVFhiS09IaFNQbERrVCtvaEdNTmNUWGV4?=
 =?utf-8?B?eTlXekFOcVlPZ1QwekRMVmw1Rk9vKzY0bjZZelREU2NFTjh3Uy9VK0V3S3Jh?=
 =?utf-8?B?cjJxaG16ZTNOK09LWFE0aStqTTJTRy9GK0NGRCtMMmNZbDM3VGFnMHVwZXF1?=
 =?utf-8?B?aFJRRkFoa0tWVmsvZEVMYVorekM2OEFwTGZIbCtSd1pYeDFBdnpJNnZ5ejk1?=
 =?utf-8?B?d2RORlBtSUxBY2RmTnhlNWhoeXE5M284ay94MU5rWUdNOWIvL3JhNFlDRyt3?=
 =?utf-8?B?amkrOUZuMFoxaFU5SWRXN3R4TzYvSVhhZmcrZnVPNzdCVE9Pd2JNR2VYQmQ4?=
 =?utf-8?B?VTU4ajZTK05TdTk5ZEFRVUUyVEVKMTFQbWtRUTYrZzY3YkRoV3RVbVFFaE5N?=
 =?utf-8?B?ZzRnNFc1R1pFMlpJVGVXaXRBdlErRzVXSk1JVzkvNXY3V3IzdWNDTGs0YURp?=
 =?utf-8?B?ZGVKNXhDNGhmdE5Sb0VBbWtVWnB1bXJnTDRYYk1sbkxDVE4yL2dtbHp3K256?=
 =?utf-8?B?cnV2V3R5RDZJeHY4NE1MUE9pUHkzTGowKzAxWmRxa1hhdVNkT0p6OFBEOEZI?=
 =?utf-8?B?N2czNU5kdEJlNTdVb3FEK014aU04eVBHdjFObnNXVi8xM21DYjFkcEU2cWJI?=
 =?utf-8?B?MWF4STNQRndIdkZtSU9aaUEyRVR6Nkp2VEJNR3ozTEdRMkN6ckk4TnExSEIv?=
 =?utf-8?B?aitHb0NJOHNkK1ppc2wxMTZEQ3ZPQ1RIVkpONXJLUDhydytmOENiUExzcTlU?=
 =?utf-8?B?aFRudFZCdUp3L05WUUxEU2paRGxiejhCK0hKUm0vVWVtZEprTk5oeXJ4aU9P?=
 =?utf-8?B?bWpZOWJEWWtpUWdXRzcwTUdVSGR3WUw3S1RrRUdNVEhBdS9mdGo2MlJDODJ2?=
 =?utf-8?B?WUZldFFIUG5PWDk2eHVhMnVDN21GZUpyemhRRHdDaDE0bFJIWDMyQ1RVbHdE?=
 =?utf-8?B?TkxCZk1hbGxITnpYY0E2TVNsY1ZqSGs1dGRKNlRnZHpiZnFqSDBvN1NIc1ZV?=
 =?utf-8?B?aEFhRG5nNXJKSW1Uek9tcTlObTd2ZUZkOHN5QWpYckpRSmcrM2t5eVRxenRQ?=
 =?utf-8?B?L0xoVHh5UzBoMUhhR1hkNkcwdWtZa210R0pzekdJS0I5QkVxWERmZzdCTUp6?=
 =?utf-8?B?NFpVRzIxclVqUEZhMTJKQ3NPK1RMaityN1crZFNMV2k1T1E4SnFzYWQxcEdO?=
 =?utf-8?B?SnFLNlBxeUY1VU9aVGE5YU5GMWVtOWtsLzNCakJyaGxnQmdaWElIZ2NMbFBE?=
 =?utf-8?B?aXJCUlBkVk9vQlNMU3VWZTlKb1VzNzJOUWZFdVlyRUozWnd4U1dRd2xSbFE3?=
 =?utf-8?B?eGNkSDV1M2tkOWR0Z2dRUTB5clRNK1RiZ0FMYit2Si9wcXI2dWJPd05JNFNt?=
 =?utf-8?B?RHhNSGRXRzFnVlpvczg1MW11RHNtdi9OYWNvMTJGdmFLeUs0dXBqbmVFcFdv?=
 =?utf-8?B?SjFtNDZ6SmFMZDBWcUlodk05ckxTZFJVMzFHRE9XMkJNbkdwM2pHYjJPcXVZ?=
 =?utf-8?B?ckNJcC9oZlEwOW1ocmRVVUJFMU5kSkNZcE91UURSWDlUa29kUER6R015MG1w?=
 =?utf-8?B?QWZVbGZxN1l1UW9FSkVWTEk3YjM0bXZGMTBma3VmU2drQkJ0MW16TlZIQURB?=
 =?utf-8?B?NElaNkZ0Vk8yRy9PMjdrUlhuRHZWR3ZEaUM3bXpneUlramZRUmkwS2JKdmVk?=
 =?utf-8?B?WXpCSWg0Q01tUTdxKzJZdFhLSUdKSDIrWkw5NElPZ3pEU3NlRlBCZ0pFU0pt?=
 =?utf-8?B?c3JHK2xLNEZKUVMzT3Brc0NWN1IwOW5ZMW5GejU5Qnp4bkZpVlNTU0ZKbDR3?=
 =?utf-8?B?TmdZUVBUVnQzZzE2OEY5MExGYmRnNnNBeVJxSFRjRkR4YjhyMTF1K0JFWXBk?=
 =?utf-8?B?TnJpVTBiMkxwcVZ4NHA5dDF0Mk0wV2dvSkkxM2pRdEJmMitscFlyVjZNUFdD?=
 =?utf-8?B?dURkRzQ0M0srcmRDMThwR1JJN1NRaXhVd002RmRENUNlM1FSZTgrRm9HM01h?=
 =?utf-8?B?UVRaVTBCZElxdHlvRkI5WEJsMWtxU1ZGc3RZLy96dlpveVBralZtaUx6SXZT?=
 =?utf-8?B?Wjk1S2R5U3lybXlYbnN0NUZJYlJZaWxYMktjRU1sdGJzbitGaXhXYmFnVHlK?=
 =?utf-8?Q?pSd8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c972df-99b9-4b75-06bd-08ddc397e478
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 12:05:29.6793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMzI/wlY/xTgW2MrpI5APFZM/yDJEI1ZAfpOPfic7vIpXLRf5qa8szN37lprdTZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDExLCAyMDI1IDg6MTEgUE0NCj4gVG86IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDYvMTFdIGRybS9hbWRncHU6IHRyYWNrIHRoZSB1
c2VycSBibyB2YSBmb3IgaXRzIG9iag0KPiBtYW5hZ2VtZW50DQo+DQo+DQo+DQo+IE9uIDExLjA3
LjI1IDExOjM5LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBUaGUgdXNlciBxdWV1ZSBvYmplY3Qg
ZGVzdHJveSByZXF1aXJlcyBlbnN1cmluZyBpdHMgVkEga2VlcHMgbWFwcGluZw0KPiA+IHByaW9y
IHRvIHRoZSBxdWV1ZSBiZWluZyBkZXN0cm95ZWQuDQo+ID4gT3RoZXJ3aXNlLCBpdCBzZWVtcyBh
IGJ1ZyBpbiB0aGUgdXNlciBzcGFjZSBvciBWQSBmcmVlZCB3cm9uZ2x5LCBhbmQNCj4gPiB0aGUg
a2VybmVsIGRyaXZlciBzaG91bGQgcmVwb3J0IGFuIGludmFsaWRhdGVkIGVycm9yIHRvIHRoZSB1
c2VyIElPQ0xUDQo+ID4gcmVxdWVzdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExp
YW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IDI4NTZjMjUwNmJlZS4uODFm
YmIwMGI2ZDkxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3VzZXJxLmMNCj4gPiBAQCAtNTEwLDEyICs1MTAsMjQgQEAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3ko
c3RydWN0IGRybV9maWxlICpmaWxwLCBpbnQNCj4gcXVldWVfaWQpDQo+ID4gICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgIH0NCj4gPiAgICAgYW1kZ3B1X3VzZXJxX3dhaXRfZm9y
X2xhc3RfZmVuY2UodXFfbWdyLCBxdWV1ZSk7DQo+ID4gKw0KPiA+ICsgICAvKg0KPiA+ICsgICAg
KiBBdCB0aGlzIHBvaW50IHRoZSB1c2VycSBvYmogdmEgc2hvdWxkIGJlIG1hcHBlZCwNCj4gPiAr
ICAgICogb3RoZXJ3aXNlIHdpbGwgcmV0dXJuIGVycm9yIHRvIHVzZXIuDQo+ID4gKyAgICAqLw0K
PiA+ICsgICBpZiAoIWFtZGdwdV91c2VycV9idWZmZXJfdmFzX21hcHBlZCgmZnByaXYtPnZtLCBx
dWV1ZSkpIHsNCj4gPiArICAgICAgICAgICBkcm1fd2FybihhZGV2X3RvX2RybSh1cV9tZ3ItPmFk
ZXYpLCAidGhlIHVzZXJxIG9iaiB2YSBzaG91bGRuJ3QNCj4gYmUgdW1hcHBlZCBoZXJlXG4iKTsN
Cj4gPiArICAgICAgICAgICByID0gLUVJTlZBTDsNCj4gPiArICAgfQ0KPiA+ICsNCj4NCj4gVGhh
dCBpcyBzdGlsbCBub3Qgc29tZXRoaW5nIHdlIGNhbiBkby4NCj4NCj4gRGVzdHJveWluZyBhbiB1
c2VycXVlIGNhbid0IGZhaWwgaW4gYW55IHdheS4NClllcywgdGhlIHVzZXJxIGRlc3Ryb3kgd2ls
bCBjb250aW51ZSBwZXJmb3JtaW5nIGluIHRoaXMgaW52YWxpZCBjYXNlLg0KQ2FuIHdlIGtlZXAg
dGhpcyBwYXJ0IGZvciBkZXRlY3RpbmcgdGhpcyBpbnZhbGlkIGRlc3Ryb3kgY2FzZT8NCkZ1cnRo
ZXJtb3JlLCBpdCBsb29rcyBsaWtlIHRoaXMgZXJyb3IgY29kZSB3aWxsIG5vdCBhZmZlY3QgdGhl
IGRlc3Ryb3kgcmVxdWVzdCBhdA0KdXNlcnNwYWNlIHNpbmNlIHRoZSBNZXNhIGRyaXZlciBkb2Vz
bid0IGNoZWNrIHRoZSB1c2VycSBkZXN0cm95IHJldHVybiB2YWx1ZS4NCg0KPiBSZWdhcmRzLA0K
PiBDaHJpc3RpYW4uDQo+DQo+ID4gICAgIHIgPSBhbWRncHVfdXNlcnFfdW5tYXBfaGVscGVyKHVx
X21nciwgcXVldWUpOw0KPiA+ICAgICAvKlRPRE86IEl0IHJlcXVpcmVzIGEgcmVzZXQgZm9yIHVz
ZXJxIGh3IHVubWFwIGVycm9yKi8NCj4gPiAgICAgaWYgKHVubGlrZWx5KHIgIT0gQU1ER1BVX1VT
RVJRX1NUQVRFX1VOTUFQUEVEKSkgew0KPiA+ICAgICAgICAgICAgIGRybV93YXJuKGFkZXZfdG9f
ZHJtKHVxX21nci0+YWRldiksICJ0cnlpbmcgdG8gZGVzdHJveSBhIEhXDQo+IG1hcHBpbmcgdXNl
cnFcbiIpOw0KPiA+ICAgICAgICAgICAgIHIgPSAtRVRJTUVET1VUOw0KPiA+ICAgICB9DQo+ID4g
Kw0KPiA+ICsgICBhbWRncHVfdXNlcnFfYnVmZmVyX3Zhc19wdXQoJmZwcml2LT52bSwgcXVldWUp
Ow0KPiA+ICAgICBhbWRncHVfdXNlcnFfY2xlYW51cCh1cV9tZ3IsIHF1ZXVlLCBxdWV1ZV9pZCk7
DQo+ID4gICAgIG11dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4NCj4gPiBA
QCAtNjM2LDYgKzY0OCw5IEBAIGFtZGdwdV91c2VycV9jcmVhdGUoc3RydWN0IGRybV9maWxlICpm
aWxwLCB1bmlvbg0KPiBkcm1fYW1kZ3B1X3VzZXJxICphcmdzKQ0KPiA+ICAgICAgICAgICAgIGdv
dG8gdW5sb2NrOw0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgLyogcmVmZXIgdG8gdGhlIHVzZXJx
IG9iamVjdHMgdm0gYm8qLw0KPiA+ICsgICBhbWRncHVfdXNlcnFfYnVmZmVyX3Zhc19nZXQocXVl
dWUtPnZtLCBxdWV1ZSk7DQo+ID4gKw0KPiA+ICAgICBxaWQgPSBpZHJfYWxsb2MoJnVxX21nci0+
dXNlcnFfaWRyLCBxdWV1ZSwgMSwNCj4gQU1ER1BVX01BWF9VU0VSUV9DT1VOVCwgR0ZQX0tFUk5F
TCk7DQo+ID4gICAgIGlmIChxaWQgPCAwKSB7DQo+ID4gICAgICAgICAgICAgZHJtX2ZpbGVfZXJy
KHVxX21nci0+ZmlsZSwgIkZhaWxlZCB0byBhbGxvY2F0ZSBhIHF1ZXVlIGlkXG4iKTsNCg0K
