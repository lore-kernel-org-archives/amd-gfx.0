Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30DBC83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 07:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA4010E5A8;
	Tue,  8 Jul 2025 07:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFnfk1PY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25D710E5A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 07:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkKBrH1TJN0GtdgDtmunwnhWLYHq1OH5IptDzB4O6V+wzhPWg2dwzIxhTtjk0MTX96iSc61sU8hcrFyRh+0LqY663YQiLouUlFWLK2/LllUG56gW7uclOVaAh7NH+7avpxXqQWST+6gjS5fZCTAgtEFqHVpcO0Hvm4sbQWXGFyGnQmJD3L/bPuWsps9wm+QHanjni/Ca5N8NuChiKXtlot9nScg3KLOrqVleJHHiECBKMrLsKawc05azpk+DMxAOESr6UGHrhilVBZjiwcQ5TH8N/9P9sjDl+JnPl2vfF91Ji8JJSwq/hpYULDx+I8K6tTFyrnGT1RCIiiwNSptjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3jKyJfM0Ql5PSzWnSEB3oVyAaj+Of1vxEjYsWxkIg8=;
 b=sADt+DVzxFQYcmX7uhyJ9Ol32itMZsAp99+/eP0nOPPc3xXMjNJ9zeWdmJ5HQUDkegOuCE7mxwqR6rywEtR6i7rRktd/1ePFpaL2Rqpb/lhaZbOchCrhGVhz1jlMMTDxjcSyyXeUgBs4bvVNb27g8cM78rNJbnjw3gaBIuAbiFhkJmtV+zU5UaHOEet1B7YS88NXFrUWIL4QCAcO3N8Mq2KTSxM5MdhPdyfKg9a+H2Zn+SDpRbaVinrU9HZcpqrGXxUGIbVPd7fIW5IIKjDOqkXl6MJA5Yllu6gfEearK3XBsv6EdG8O6PTg/Nbnxf0pJUy3g+HReil2v/V2taI7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3jKyJfM0Ql5PSzWnSEB3oVyAaj+Of1vxEjYsWxkIg8=;
 b=NFnfk1PY/VOjH29EIBaQ7PkHjq5S+WhizlzhXVb42dNocK0Jz+xZxVxDQcLSpsQl7EswIjvk3xgLufGdTXA0AF2skGFB7iNIw/6tplmid12r5u10JH0/X4rimws5qz0JeB69ExrSRJb1BhAlc7+Jvw1dqoxYaPDuolG0KWmfmuw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Tue, 8 Jul 2025 07:32:35 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Tue, 8 Jul 2025
 07:32:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v5 7/9] drm/amdgpu: add userq va unmap validated helper
Thread-Topic: [PATCH v5 7/9] drm/amdgpu: add userq va unmap validated helper
Thread-Index: AQHb7M8ahPANJqAllUa9Lo3fojRqkLQma+SAgAFnSBA=
Date: Tue, 8 Jul 2025 07:32:35 +0000
Message-ID: <DS7PR12MB6005CB25950A54FD330618E5FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-7-Prike.Liang@amd.com>
 <ce86ea02-f0f2-4f09-a168-22f89c9efaf5@amd.com>
In-Reply-To: <ce86ea02-f0f2-4f09-a168-22f89c9efaf5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-08T07:03:33.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS7PR12MB9042:EE_
x-ms-office365-filtering-correlation-id: e85ca203-f7e1-404c-106a-08ddbdf19baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MUM4M0tSYWdRUXd6VnYzSlhYU0o4Y3VWVnpYd1lmSUw5dlpLN28xL2hhNDQ2?=
 =?utf-8?B?ZzdZY2N5SzZZMTcrUmk5UHJXTGs1SDlLMlJ3U1FvTmVrdmhtNCtEVWZ0QmRa?=
 =?utf-8?B?UUV6cFJGcEFtQlBTQ2dMOWxXNnB6MlhBQ1hyZEIrVEwydlM1M21LbXoreG9S?=
 =?utf-8?B?MmcvblB0dVBmNmZualJEVFF1bHJjVFZWU2hkZ2h0QmVTM1ZsS0k0NTVnQm1n?=
 =?utf-8?B?TEVjVEZMUFQ3cUtZN3ZWQWJ0UmIxNGFScGFJczRPSlJFWmRnNy9aZnBuSmEx?=
 =?utf-8?B?TXBWdWdwWmtjZGR1ODg5bC9Ic3NjU09ncDBVNDBKcG0wc3JyVFE0eW1GdkdB?=
 =?utf-8?B?c2Z5UEM1RkUrblZYeUJ1NWlDd2JBSmJ5cWFrcUx3Nytsano5QSs3MW1EUzdw?=
 =?utf-8?B?NHBVVVR1Z0FyUllWekxwL2tOYjRWb25pZEdHUXpkUldOSmFrMUU0UGNiQzBW?=
 =?utf-8?B?Vm41SVNaL2ZKOWZidnpBa0RZRzZrMmtJOXdTVVJWU1YvUkFYK2JVOEkzSVNZ?=
 =?utf-8?B?Nkp0WWVVSXN6bWdQT0pUYjVMNTNBcWw3WUhEUUZ5WVhUcC9NSEpNdUhiQy9B?=
 =?utf-8?B?QVZ3c0lYYllBNDJZL1E4SmdlTFhXajJNM0ZNVHd2VU5vRkxralp1eHNGZTNW?=
 =?utf-8?B?cDAwSXNnTGFVcHFFTW5qdW5JWUlIdEJuS3N3ZHFiTmJTa2J5UFFEdS9KU1Bz?=
 =?utf-8?B?eEV0cVFuQnhoUlBueDV0aEtGQm5XcDhONWJ6RjI0TkpvNVVMelo4OVk2ejMy?=
 =?utf-8?B?Y0QyZUQzSUNtTGlCMVBmZ0NCS1oyOUZERFZyRjV6Ym9kLzh0RWpxaTZMcldy?=
 =?utf-8?B?WW9YcnJKUnlmSFBTc0hkVmxJaUlJNGZ3d1lNUDkzQnd6ME8veUJZRVFsNndx?=
 =?utf-8?B?Z0h5Qm1HUXM5YVJHTS9nV28xaXpJODdFdlJxT0xiWk9PRmJJK2JaRUtHekxj?=
 =?utf-8?B?WUl3RjEzRUtzanRrbnJmbk5zSGhpZnNpNFlROXJEK24wN1puRmFRK1RYekhi?=
 =?utf-8?B?TmNETU1wdTNrK1pmV1hJMmtWR0wwYnkzczlod0tjeFhLdldCdnF2WlNnNkE3?=
 =?utf-8?B?aSsxSTNZYldpOVA1UTFxQ1FGUVJqM3BOTDRpajNtcHdhMFppSm94bHltLzh4?=
 =?utf-8?B?dlYxd0YzZkxFVm5DeGZQamV5VWJ2ZW91bkNRdVlncE9kMlplWWs2bytUcE5v?=
 =?utf-8?B?b1U0Q2JlVzBYdGpGUXVzZU5HTjZrQmZGelp2d1djWFpSMHl4SU5VOVBpWC94?=
 =?utf-8?B?U3E4TU5kNmJycEVINi9FcDdiUHYvSWRjRXBJeGt6dWtWcWdhekZ3eElFY0dV?=
 =?utf-8?B?ckQzazdoeFJzM3RpU0NSREF6NTF1N0wzM01WK0ltUVNJNTJxS0xaQ2ZzdzAy?=
 =?utf-8?B?dTVoViszZmVSU1JacXI1WVJsZ1gyb3M1TC95UTJYbGJrWnZZQk5BZm1ZYmpX?=
 =?utf-8?B?ZC9TZmwraFIxVFFTMVZpNGNENmYrbmxsK1RQTWtCUFRENFhKNVFJd09hdDl3?=
 =?utf-8?B?U21hUEhHVUxXeCt2TlROU2t2UXdmNDYrekpUYmJSaXc2V0RzT1k2d1RoeTNI?=
 =?utf-8?B?U21hYXE4V2dlYTBmdC9ZbkMycjNDWDM5bHRFOXpXUXV5eUdtZC9QTEQwYTRy?=
 =?utf-8?B?UmtvdkxUbXh6RUtKZjlXVVZZYnNML09Eemo5RGRWZ2x6azZHZDYrSE9xWVJL?=
 =?utf-8?B?WVhXK2JpKzI1d2NhRXZGVHcwVjg4RnJpYWQxRmk1RXhvQklEUjZ1WkF2WmJN?=
 =?utf-8?B?cm9zQllQdmtTM2FwQTlqSzVpSEs3OUpCTC9raVYwZEhBeXdzNW42Ym5xeUZU?=
 =?utf-8?B?WjRkR3VjaWhCQllNWjNBNjBFVVZEQWRucmh1Zk14VHhONXhmcTh2T1hIWXpQ?=
 =?utf-8?B?LzBxTk12KzErQXU3aXlRbkRnbVMwNmpHTkdmTTRvNXg1b0hsODFobC81L1FE?=
 =?utf-8?B?VjV1VXRTUUZkUm8za2tpaWZPcG9IN2NMRjhkTTFCRVh2L1haN0tMSmhOb3Np?=
 =?utf-8?B?S2Vjc2hKeXhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRkT0JaL1NzQitJanpmTG1WR2lxTjhKcEpnbldkQ1IxVXpIU0Z0dlJQU0FG?=
 =?utf-8?B?RzZZUlVTRHdHeTUvZ1VZQTRReTR5RTFpdnNINHJrak5NeWtHWUVVWThhRVNX?=
 =?utf-8?B?UldIckZBM29IeW53RzhLU0g3UnpQaHNqUE91SFpBRHo5SjBXeVhxUjQ2cmVk?=
 =?utf-8?B?U3ZubUlVK3J1Z2UwekYvZk1yc3F6ZTdWNU5QTzBaNVkrcm5vUjBxeXFnZUlu?=
 =?utf-8?B?TUxQcGltWEhnYUZGTjdsRU1LdzNvQ2FoTVMwdkJnZHZoTms3MmRVbEgyNDcx?=
 =?utf-8?B?VTU4NGdITk1QWU1ES3FGT1REbW15bUlTQ1JOY1UzV1NZODdqbWhDaUNRVXJY?=
 =?utf-8?B?WHNlUlVoQ2xKZDR2UVBsdnlUVEsxeVllL3RKWVVCL3YxbjRXa3ZsRTlrRjk3?=
 =?utf-8?B?NnhoY0FBY2hjSS9sWmhvY08rUHpOZUJKTkJWazZ2R3NMbUE3dVFrVTQ3OFRy?=
 =?utf-8?B?eWM1UmJVckk1UmpCTEtqOHZkM21kRlhrWHNiY3BId3dETGlMaHZkQXB5Q2dV?=
 =?utf-8?B?blBYZzNOVEtGK2Q1M2hKMVlKZytjZS9ubys3VklSZTY1SlcxVUFXS01UNnJq?=
 =?utf-8?B?ZEFUK3JlazJqekxiampiTHk0R2tYL25FR0luZUtsYmZBa1BLd29WYVhyR3JS?=
 =?utf-8?B?eTZzS0FPSDlGNUMrOU1KRWxUb1FNeStjYmdiaU5kc1NWZ3RqclI1RkVsRjVI?=
 =?utf-8?B?c3A1dmxiUjdmaFV3MU8vM2xsY3FsQWl3b05TeFh0S25ySFgzUDB2OWxydk9B?=
 =?utf-8?B?WmdhT21hcmhtS1F6cGVMMUtZay9xWXhlckhhblhsZnlhNFlKbnFqUS9YbUlP?=
 =?utf-8?B?aDdKMzhoM1o0VzVUa2liazc1WXNaTWtuSklMcUpGbHNJWjFGVDdiREszU0xa?=
 =?utf-8?B?cVRaNGJ0dHJJcWs5V1NQbG1YOUpGZWxmdkRhcHdoeCt1dTR1aUZDeXltejE2?=
 =?utf-8?B?VFNhWEU0Q0Z3UHQxRmZnODg1RnU2d0txVEtzVHFFeUUwUDZJS1VSMkZoL2ll?=
 =?utf-8?B?OG1YNE9zNGJ5UVR4UndOdFUyakg0ajNsUU10RFlHeDdRYWREOWs5ZkQzNkhG?=
 =?utf-8?B?cDFsYTVOSzE2YTJmREd6MHBCaEsvcGFnVUVxV1dxelowNHAxWjRYNG1MYXNa?=
 =?utf-8?B?MEpEVnF2bWFiVXBwS1U1aVkwdStTY0laMzBhdllQcW5pNndxSTQ2NG5CY3lV?=
 =?utf-8?B?b2hTaFJjQmZmZWEwMXdOK0c3RUxIR2VMTFVqUDR1cnJDdkxTWkdyR2pRa1pD?=
 =?utf-8?B?N2NLYitoU2Y0dERpTWxSdC9Fck5nM2V5cDFxVnFOV0xMSkJYK01BaWcySENo?=
 =?utf-8?B?Mk5yalBlaHhaRFNieW5kVTE0THFjbzkzdGhRUlJvZi9JUEJaY3B0SlJDVWh2?=
 =?utf-8?B?SEsvN1JqSFhYOVdTYlE0bjB0TVZ4RXRNQ1BYNmM3ZklSRm1VV2UxRVRuRG9B?=
 =?utf-8?B?bU14cWZzRXN4SmdXQVZMVzdwQTRXZm9UckNDSVRnZ0V2NERlZGpTYXF1dW5E?=
 =?utf-8?B?SXFxQy9ENnBhMDJXTUthRGhacnhKekdFL0sydVZ3T2xpa1dXZmdGT3d5UTlZ?=
 =?utf-8?B?aDBreVJNZW1aLzFFNW5qSXV1c1l4eHU3cVkrUThxZkhYajdsS05ocG16V0lN?=
 =?utf-8?B?Y3c4cDFVR3dURVp6RFN6UlkzUU92aTBHL2RkK0RrRFRuRGNBdVdSaUNDMXB0?=
 =?utf-8?B?OEF1VFpQaVFPbm1rdGpVcmkvNzVmQ0R0dzlreE5JZWtoTERNUU80QThZN3VS?=
 =?utf-8?B?T2dzRDBrVFRnOHBSejlSb25TNVRRa1VqY1BWM0ZOellsTVg4MExDSzNGKzN0?=
 =?utf-8?B?TTVSZTc4bzBRWkM3UGdDeG5NdDlOT3FhNVkzaXJ1SC9QRlNYQndYSWM1cmdJ?=
 =?utf-8?B?eGdMYVBXM0tvamQ3clRBR0ZWRkRvaXNiT1VoejZCazFHby9ZdjNJYXhaaWF2?=
 =?utf-8?B?emduSkZSNXVvNUhrdkFHTmRRdWxFazcrbk12QzJMUnl4eVZkRWxpVGV1bEhZ?=
 =?utf-8?B?VDFJaXhaNjJRVWJvaTBWZFRFUmtjRnVCdWY5aFpsTE91Vmx6Y0QvV3lZN0JE?=
 =?utf-8?B?M2V0RHM3aURML3ZobUcrQWJ1L1NIRmFzejZqMFY4Rk5mSSt1M1Z1cFBYL2tL?=
 =?utf-8?Q?68Ic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85ca203-f7e1-404c-106a-08ddbdf19baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 07:32:35.2744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cm2QDY8NeLU35llkAq8MHL7hXot0G6Q7wd0oOPLQ+TmslDxNrXPTLcteWMVPaG8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
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
LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDcsIDIwMjUgNTozNyBQTQ0KPiBUbzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA3LzldIGRybS9hbWRncHU6IGFkZCB1c2VycSB2YSB1
bm1hcCB2YWxpZGF0ZWQgaGVscGVyDQo+DQo+DQo+DQo+IE9uIDA0LjA3LjI1IDEyOjMzLCBQcmlr
ZSBMaWFuZyB3cm90ZToNCj4gPiBUaGlzIGhlbHBlciBjYW4gdmFsaWRhdGUgdGhlIHVzZXJxIHdo
ZXRoZXIgY2FuIGJlIHVubWFwcGVkIHByaW9yIHRvDQo+ID4gdGhlIHVzZXJxIFZBIEdFTSB1bm1h
cC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnEuYyB8IDc4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oIHwNCj4gPiAzICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA4MSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5kZXggMjVhMzVhYjczOTViLi4zMDgzOGU1Mjc5YmQg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0K
PiA+IEBAIC0xMTgwLDMgKzExODAsODEgQEAgaW50DQo+IGFtZGdwdV91c2VycV9zdGFydF9zY2hl
ZF9mb3JfZW5mb3JjZV9pc29sYXRpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4g
ICAgIG11dGV4X3VubG9jaygmYWRldi0+dXNlcnFfbXV0ZXgpOw0KPiA+ICAgICByZXR1cm4gcmV0
Ow0KPiA+ICB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgYm9vbCBhbWRncHVfdXNlcnFfZ2VtX3ZhX3Vu
bWFwX3F1ZXVlX3JldHJpZXZlKHN0cnVjdA0KPiBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVl
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50NjRfdCB2YSkNCj4gPiArew0KPiA+ICsgICB2YSA9IHZhIDw8IEFNREdQVV9HUFVfUEFH
RV9TSElGVCB8IEFNREdQVV9HTUNfSE9MRV9FTkQ7DQo+DQo+IFN0aWxsIGNsZWFyIE5BSyB0byBk
b2luZyB0aGF0IGhlcmUuDQpJdCBzZWVtcyB0aGVyZSdzIG5vIGV4aXN0aW5nIFZNIGhlbHBlciBm
b3IgYWxpZ25pbmcgdGhlIHVzZXJzcGFjZSBWQSBpbnRvIGdlbSBtYXBwaW5nIHJhbmdlLg0KV2l0
aG91dCBzdWNoIGFsaWdubWVudCBjaGFuZ2UsIGNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBtb3JlIGRl
dGFpbCBob3cgdG8gY292ZXJ0IHRoZSBWQSBiZXR3ZWVuIHRoZSB1c2VyIGlucHV0IGFuZCBHRU0g
bWFwcGluZyByYW5nZT8NCg0KPiA+ICsNCj4gPiArICAgc3dpdGNoIChxdWV1ZS0+cXVldWVfdHlw
ZSkgew0KPiA+ICsgICBjYXNlIEFNREdQVV9IV19JUF9HRlg6DQo+ID4gKyAgICAgICAgICAgaWYg
KHF1ZXVlLT5xdWV1ZV92YSA9PSB2YSB8fA0KPiA+ICsgICAgICAgICAgICAgICBxdWV1ZS0+d3B0
cl92YSAgPT0gdmEgfHwNCj4gPiArICAgICAgICAgICAgICAgcXVldWUtPnJwdHJfdmEgID09IHZh
IHx8DQo+ID4gKyAgICAgICAgICAgICAgIHF1ZXVlLT5zaGFkb3dfdmEgPT0gdmEgfHwNCj4gPiAr
ICAgICAgICAgICAgICAgcXVldWUtPmNzYV92YSAgPT0gdmEpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArICAgY2FzZSBB
TURHUFVfSFdfSVBfQ09NUFVURToNCj4gPiArICAgICAgICAgICAgIGlmIChxdWV1ZS0+cXVldWVf
dmEgPT0gdmEgfHwNCj4gPiArICAgICAgICAgICAgICAgICBxdWV1ZS0+d3B0cl92YSA9PSB2YSB8
fA0KPiA+ICsgICAgICAgICAgICAgICAgIHF1ZXVlLT5ycHRyX3ZhICA9PSB2YSB8fA0KPiA+ICsg
ICAgICAgICAgICAgICAgIHF1ZXVlLT5lb3BfdmEgID09IHZhKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIGNhc2Ug
QU1ER1BVX0hXX0lQX0RNQToNCj4gPiArICAgICAgICAgICBpZiAocXVldWUtPnF1ZXVlX3ZhID09
IHZhIHx8DQo+ID4gKyAgICAgICAgICAgICAgIHF1ZXVlLT53cHRyX3ZhID09IHZhIHx8DQo+ID4g
KyAgICAgICAgICAgICAgIHF1ZXVlLT5ycHRyX3ZhID09IHZhIHx8DQo+ID4gKyAgICAgICAgICAg
ICAgIHF1ZXVlLT5jc2FfdmEgPT0gdmEpDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4g
dHJ1ZTsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArICAgZGVmYXVsdDoNCj4gPiArICAg
ICAgICAgICBicmVhazsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAgcmV0dXJuIGZhbHNlOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgYW1kZ3B1X3VzZXJxX2dlbV92YV91bm1hcF92YWxpZGF0
ZShzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDY0X3QgdmEpDQo+DQo+IEkgZG9uJ3Qgc2VlIGFuIHVzZXIgb2YgdGhpcyBmdW5jdGlvbj8N
Cj4NCj4gPiArew0KPiA+ICsgICBzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICpmcHJpdiA9IHZtX3RvX2Zw
cml2KHZtKTsNCj4gPiArICAgc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVxX21nciA9ICZmcHJp
di0+dXNlcnFfbWdyOw0KPiA+ICsNCj4gPiArICAgaWYgKCZmcHJpdi0+dm0gPT0gdm0pIHsNCj4N
Cj4gVGhpcyBjaGVjayBpcyBjb21wbGV0ZSBub3NlbnNlLg0KPg0KPiA+ICsgICAgICAgICAgIHN0
cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlOw0KPiA+ICsgICAgICAgICAgIGludCBx
dWV1ZV9pZCwgciA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIGlmIChtdXRleF90cnlsb2Nr
KCZ1cV9tZ3ItPnVzZXJxX211dGV4KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgLyogSWYg
aGVyZSB0aGUgdXNlcnEgYm8gaXMgYnVzeSBhbmQgbmVlZHMgdG8gZGVhY3RpdmF0ZSBhbmQNCj4g
cHJldmVudCByZXVzaW5nIGl0LiovDQo+ID4gKyAgICAgICAgICAgICAgICAgICBpZHJfZm9yX2Vh
Y2hfZW50cnkoJnVxX21nci0+dXNlcnFfaWRyLCBxdWV1ZSwgcXVldWVfaWQpIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqZiA9IHF1ZXVlLT5sYXN0
X2ZlbmNlOw0KPiA+ICsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlm
DQo+ICghYW1kZ3B1X3VzZXJxX2dlbV92YV91bm1hcF9xdWV1ZV9yZXRyaWV2ZShxdWV1ZSwgdmEp
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2RiZyh1cV9t
Z3ItPmFkZXYtPmRldiwgInF1ZXVlKGlkOiVkKQ0KPiBub3QgYmVsb25kIHRvIHZtOiVwXG4iLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcXVldWVfaWQs
dm0pOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoZiAmJiAhZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGYpKSB7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKHVx
X21nci0+YWRldi0+ZGV2LCAidHJ5IHRvIHVubWFwDQo+IHRoZSBidXN5IHF1ZXVlKGlkOiVkKTol
cCB1bmRlciB2bTolcFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHF1ZXVlX2lkLCBxdWV1ZSwgdm0pOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC8qIE5lZWQgdG8gc2V0IGEgcmVzb25hYmxlIHN0YXRlIGZvciBhdm9p
ZGluZw0KPiByZXVzaW5nIHRoaXMgcXVldWUqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHF1ZXVlLT5zdGF0ZSA9DQo+IEFNREdQVV9VU0VSUV9TVEFURV9IVU5HOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIrKzsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZ1cV9tZ3ItPnVzZXJxX211dGV4KTsNCj4g
PiArICAgICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiA+ICsgICAgICAgICAgIH0gZWxzZSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAvKiBkbyB3ZSBuZWVkIGEgdHJ5IGxvY2sgYWdhaW4g
YmVmb3JlIHJldHVybiovDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0K
PiA+ICsgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAgIHJldHVy
biAwOw0KPiA+ICt9DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91c2VycS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnEuaA0KPiA+IGluZGV4IDE5NGVjN2E2YjNiMi4uMDhjNDlkNzM4ZWMxIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmgNCj4gPiBAQCAtMzEs
NiArMzEsNyBAQA0KPiA+ICAjZGVmaW5lIHRvX2V2X2ZlbmNlKGYpIGNvbnRhaW5lcl9vZihmLCBz
dHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLA0KPiA+IGJhc2UpICAjZGVmaW5lIHVxX21ncl90
b19mcHJpdih1KSBjb250YWluZXJfb2YodSwgc3RydWN0IGFtZGdwdV9mcHJpdiwNCj4gPiB1c2Vy
cV9tZ3IpICAjZGVmaW5lIHdvcmtfdG9fdXFfbWdyKHcsIG5hbWUpIGNvbnRhaW5lcl9vZih3LCBz
dHJ1Y3QNCj4gPiBhbWRncHVfdXNlcnFfbWdyLCBuYW1lKQ0KPiA+ICsjZGVmaW5lIHZtX3RvX2Zw
cml2KHYpICBjb250YWluZXJfb2Yodiwgc3RydWN0IGFtZGdwdV9mcHJpdiwgdm0pDQo+DQo+IE5B
SyB0byB0aGF0LCB0aGUgVk0gc2hvdWxkIG5vdCBiZSBjYXN0ZWQgdG8gZnByaXYuDQo+DQo+ID4N
Cj4gPiAgZW51bSBhbWRncHVfdXNlcnFfc3RhdGUgew0KPiA+ICAgICBBTURHUFVfVVNFUlFfU1RB
VEVfVU5NQVBQRUQgPSAwLA0KPiA+IEBAIC0xNDgsNCArMTQ5LDYgQEAgYm9vbCBhbWRncHVfdXNl
cnFfYnVmZmVyX3Zhc19tYXBwZWQoc3RydWN0DQo+ID4gYW1kZ3B1X3ZtICp2bSwgIGludCBhbWRn
cHVfdXNlcnFfYnVmZmVyX3ZhX3B1dChzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwNCj4gPiB1NjQgYWRk
cik7ICBpbnQgYW1kZ3B1X3VzZXJxX2J1ZmZlcl92YXNfcHV0KHN0cnVjdCBhbWRncHVfdm0gKnZt
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAq
cXVldWUpOw0KPiA+ICtpbnQgYW1kZ3B1X3VzZXJxX2dlbV92YV91bm1hcF92YWxpZGF0ZShzdHJ1
Y3QgYW1kZ3B1X3ZtICp2bSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0
X3QgdmEpOw0KPiA+ICAjZW5kaWYNCg0K
