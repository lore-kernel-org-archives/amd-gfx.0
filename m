Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436541093170
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 02:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D519E10E868;
	Fri, 20 Mar 2026 02:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1D+HJB6";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E989010E868
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 02:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjn3ity48bO7wyk36DiEzs9pH8YbvvA9BdS0xeasw6S2+bT5z4Kk4oKPT1zzO4YxH6hmfJ78iesDeoJmQ0BbQh37zVOoHJVAMjmWUqhMerkejvLVEcrXX3f3Gvb3CVK8RJeH+pPmm40jdBTjrv+9E5GmuW722PNq5zVTS8zzOaPvX+mA6vHO79PZbnDJ4jOjpxNOCkBHmtDVgi7lh8EothDy+Sl7koSayUHFmQNGk/hE78BRjamdGXtuG19gzX0bZOMSOVbX7T9RWOCIPax/ujhbs2BsoRnd4Xl9Y+fjR3ICl7ncDTcwDWuWDkMDDzXanJkjB1VhcQO6b32Mrj4R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suP722Knv6lQFSxON7AdMyib3kRiYdrRGMZSLxtefjI=;
 b=Wi54XmWC2vExdF1HLiI2cBYl5epPTdWhji9hNW9Xcf+ef9u18ilzF1O3yBqNLgIrfQiGgf9jY/v5S5qMJ04kVDrfL26tjLOQyhMcFMBkzEW88sX4FODStWVsQAdIguq2GXvt+kohHDIU9vlaFu7XLFTwE5cVSmxQi40ALxqg1V6dnjHg1SaT6LPLNuAuD03lOAk0Tq6yYnyk41vwDkQh/kz3Sy6qtM+uPkZZSpMMJYlDayd+olp2+gm+nbvSe0JbOHGnw/IWkD8kthWcjnyEHuRa5VX4x45rSXwcIJmbfp/ar7vOlSbnhVPzeMWixs0hCpLadt8o/ZM/GF2oZ2gL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suP722Knv6lQFSxON7AdMyib3kRiYdrRGMZSLxtefjI=;
 b=x1D+HJB6PYSilyEbNQExNFR9v1nPIMEEkHnEc27TSGQAgGgvGb5Aw034cOiAwTK2bcmp+C9jycQZs+VJhe7WLITwR/jMTU4CCvCEUn/QrYutElWlyjC2haTgz7WfU95qKylsNgkEzERWf8qPAbAWnN0Wf0gxDT5LDkduqk9ADWc=
Received: from MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 20 Mar
 2026 02:41:56 +0000
Received: from MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338]) by MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338%2]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 02:41:54 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Mohan Marimuthu, Yogesh"
 <Yogesh.Mohanmarimuthu@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Topic: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Index: AQHctq0to8syQiKarkGCBSlqkqwr77Wz802AgAATn4CAAAHhAIABF5rAgAA1ZACAAA5UoIAAEy2AgAA2vQCAAQkVIA==
Date: Fri, 20 Mar 2026 02:41:54 +0000
Message-ID: <MN0PR12MB6004462D78DC45C7B45B0E10FB4CA@MN0PR12MB6004.namprd12.prod.outlook.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
 <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
 <f6526ba3-91a0-4407-94f6-a34176587b40@mailbox.org>
In-Reply-To: <f6526ba3-91a0-4407-94f6-a34176587b40@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-20T02:35:52.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6004:EE_|SA5PPF3C36BFCB5:EE_
x-ms-office365-filtering-correlation-id: ed814184-cd2e-48fe-d309-08de862a3fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: 16N+ZgIrLvOOcWI8TelD9o+dW0dcozw8N5G1KVlAKa5WzFr+5sj8X2jcObaibsm5ceZ77Zv47Ojde6yD6MgyTHHkJEjEnlbGxUXSjNbf3yhovv8oIsIENubk/SCAEUHlnM2MfBXwGVUXPpVS4B3COckjPw+X+e1BDKjWydxL9cQmtG3OVOX8d6vCjeSPTr9FgVkVIO0R2wbJz2MZQmAIuZSAdlV2VttctrgSWX/q2QvxHjZRbfE+6Xb9klr6qomoNq3GUzYwcqSbiUATW375uSBXskQRweO7/lXscuj68Raza8w/XOjOb3OUohAqy2vkYei4MXMtDTJvlUA0t/vLGMCmSTzPDn9/vefgrphLhBXUuK8jiWcX4lPHilAb4YckRk80ATf+xI8aCz7q9qA+pdFHsJwkdD0jWLiq0WA2dq4m9xSOLUnl0VAZ6GhySRI2555RPYTwQ+HA3ZKe29LxuPjCB7sqCQahBV2wz4blb+dD35KGtR3rs36vUPXRGh0ruJ6PlHryUVdp2yxcaz1hTNMXaDNahtLO6wSOUwzftpKXmJQMS3eI/7clM6tSdkIzCMdcaw5QPSSD+Y2a8Rd80FmNDDan0u7L24slWC99ZHi85vyRdq0c040cqy7JVnsxBMmwXHJW/p0XR0I3D+XoPx1QCTFA1GFlc8yhBgFodsgY+xaF82SSlrZ63++m2fVxp6sWkyuQam2JaXNt0x0lcYb/xEBdAd7s3zIN2XNrgwUEFZGjbyJUBdFQPFOCQ3Qb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?endERUVKSUZ5dnVQRXJOTWl1QXJFRGZ4NFdwbU5Vdm9aRWZKQnZ6RDg5SHp1?=
 =?utf-8?B?Q1BIN1hBWGF3cnVZU3pUdEw3YUNJZWJMRFdVUWxTUlhkbTlFck9EbnJyM0Ns?=
 =?utf-8?B?Z0ExMmhLdm4xMGdQNllqRjRJUWlXMytDMVk2bFhsOEt2S2t0M2dLK1E4R29l?=
 =?utf-8?B?U1grc1kwdWFrZklOMjR2a2ZiNVlyenhiTlpIOG1ISmZVYTRrMmVOYVVpU2lr?=
 =?utf-8?B?OWgyYnJlMnVtKzBrM2hxb2NNVFZndjR4T1ZDcjBhQUxUMHVzbWFqM1VURmZV?=
 =?utf-8?B?VFZ3SlZ2Z3IrTmdlNFN1dTQyL2tMallMOWp6S0lNV2pEUnRyalVQeFV1N0pS?=
 =?utf-8?B?bDJkMGRPbU5IbGhTVEoxMGhSc3psQW8wbDFFaVFLQmg0WkdiRlpLclhscFFU?=
 =?utf-8?B?U1VPZ3VHNFI1a3VUV05DUWxDcHNmWE9adWdLZVE1UzZod0llL3pQa3c5SWZY?=
 =?utf-8?B?eml4VnYvcGE5M0J2bERNNi91eXF2Ti8zSjRCN0EzNXpIL1YvYmFFSXI5K1Vj?=
 =?utf-8?B?YlBFa2N6SVF0VEEvaW9GUkwyWWJJMkJoZFQ5emVLREF5bGVJblJNM2hBSndj?=
 =?utf-8?B?TnRueWZ4ejBTZ1F0K1REeXFOUHhtWnNRc2VJNmlqTWZTMEtzbno3UjFpTkFV?=
 =?utf-8?B?ck9GQkpmTHpKeTZtRnpIcy9jcERlTUdWdEFVRmhnOWNiTU8zOFlFcXN0V1RN?=
 =?utf-8?B?bzUxcUF6bzVpeWlPU2tsWi9oWXQ2Zmw0Yk44Mi9sa3dNVjA3Q2MvNFJLVkRL?=
 =?utf-8?B?M3ZNd2dYRm02TE84cFlQaFlMY1c0ME02LzhsMGNHUFd6YzJwUWh3clJBZ0ZW?=
 =?utf-8?B?alpMQ1c5SnUxc3NtUjFvZ3BzVDU5ZmVoRTZHcmFvZytERmhGdzRjSjh2a0pj?=
 =?utf-8?B?STN0cGovVVl6K1g1YUZyYXlJZ2Nlb3YxeWNpVTUycXo4K05sOHRMb0sxdHk3?=
 =?utf-8?B?UmgrbFdxNHdhQ043eXI1MU9RRUh3cFV5MHZNYlhQU2FtTVE3WCtiY2ZvYi84?=
 =?utf-8?B?OEFUV1lnK1kvVitSUmxJTU5Jb3JJTGtNeFBaTllJUXZOS0QxYUlITVpMQnFM?=
 =?utf-8?B?S2RSUUwxNDErOUJwVUZ0QlpYRWExVGNyZU9IN2lyS0t3enMxZkwxbkxUMkZr?=
 =?utf-8?B?cDBJdlNVZEprT1UwWXRBeURiTkdMNlVaNkE0SlFoSlBRbE1TSm1DbU04SFAy?=
 =?utf-8?B?R0JlNFRzZ3BoM2VZUEtsTUVUVnVieENNbEtBTlRHWmtZdDFlT1BqNnFYcEtr?=
 =?utf-8?B?NVNPVUxJdmRjOTNhd0lxM2VKYlNvQTk3QlJBUDNrRnpWajJ0a1NMVXJTMHIv?=
 =?utf-8?B?TU92UXBGTU0zY21mRGxKaktuY1h1YmJhQWNsZjZ0NXVJdjZ4Lzg4VTdSRXpI?=
 =?utf-8?B?R3h5d0JuODdKc2djb0FFMUptR0VwZjFzSVh1MktGRGYwblpIRFlrNXJmaGRY?=
 =?utf-8?B?R2ZoaDRYeEtETENJNWtub2l3b0p5RjArMUZJb3JaQVhlRU4wZ2tkN2NqT294?=
 =?utf-8?B?cmwrejhkMGdzMXp2ZmxGM3FUSTBIaklTYjJXREI4RHhsL3JhOW5CMmFadlJ5?=
 =?utf-8?B?TTVNYkZuTUpYUGYyZE1xcCtLNzd2ZGp6RGUwTnpwTnhTZVpmOUlhYjFTSmY1?=
 =?utf-8?B?WHpLaldYekZZNmRBa2ZPNzhGUVh2Vk80blJ3anQ3RitUczA0ZU50R3psN1hq?=
 =?utf-8?B?Z0hQUUJvZFBJNmdBNzduK3NsbnllZ3NHWHNxb1l4enJ6aHgrb1NzR2l6Z0Jv?=
 =?utf-8?B?R2dEeDNSTjdqMmZleGZkN1UrSTluakNWdGZ2dFZ2NXJIdXByN3ZTUm9tL2wx?=
 =?utf-8?B?N2FZaFZzckU5ejdPaGpaejI0OWhnUXFsOUN6aG1TSytUNGpUYTN1aXNjYW9z?=
 =?utf-8?B?ZUJwdFFWYXBNOUt4aFNDa01FUG0xV0IyVzZkSTZnSCtJUnZQTXdVSGZTVUpQ?=
 =?utf-8?B?WGdSUmErTDZzUEYzL1R5bUJoZGd3WHNBUXA5WnkyZGN2WW9NWjcxQUZZZHZX?=
 =?utf-8?B?WVp4bS8vOUYvTDJENFBBOG9SNk9PaDZLZlhRaWlsYldkTVRjMVlXd2JWOWhY?=
 =?utf-8?B?UFkrVENMRFlQSFFyRU5HZ1I3Z0dvSWVvS21Ubkt2M0VnZVprNVM3MXloL1N6?=
 =?utf-8?B?REJLcS90U3FoRnpjRHF6VlNQNFNPTWprYlc5T0NjUGtGMVFLcjEzMG5xbEpj?=
 =?utf-8?B?M1I0TmliWlJWa2ZBN1d2cTZPL1hYZFcyaldoaG16dFhrOHpBUGNjZDFBK2dj?=
 =?utf-8?B?aXZGSlFzRG1aclVJanRhWVQ3QUtnRG9NUTVML2NRYnV1T0hEUllaWFY3emhG?=
 =?utf-8?Q?ap91tXAJqGYx75V29z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed814184-cd2e-48fe-d309-08de862a3fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 02:41:54.8677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAltETxpwz+qs7ap/yESoY2CvwSk8w0kq2YqVuQDMtvVT8AUWOcqlEz+WJKTfjxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5
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

W1B1YmxpY10NCg0KWWVzLCBpbiB0aGlzIGNhc2UgaXTigJlzIGNsZWFuZXIgYW5kIG1vcmUgcm9i
dXN0IHRvIG5vdCBhbGxvY2F0ZSBhdCBhbGwgd2hlbiBudW0gPT0gMCwgYW5kIGtlZXAgdGhlIHBv
aW50ZXIgYXMgTlVMTC4NCkZvciB0aGUgbWVzYSBkcml2ZXIsIGhvdyBhYm91dCB1c2UgdGhlIGZv
bGxvd2luZyBhbGxvY2F0aW9uIHBhdHRlcm4/DQoNCnVuc2lnbmVkIG51bV9zeW5jb2JqX2RlcGVu
ZGVuY2llcyA9IGNzYy0+c3luY29ial9kZXBlbmRlbmNpZXMubnVtOw0KdWludDMyX3QgKnN5bmNv
YmpfZGVwZW5kZW5jaWVzX2xpc3QgPSBOVUxMOw0KaWYgKG51bV9zeW5jb2JqX2RlcGVuZGVuY2ll
cyA+IDApIHsNCiAgICBzeW5jb2JqX2RlcGVuZGVuY2llc19saXN0ID0NCiAgICAgICAgYWxsb2Nh
KG51bV9zeW5jb2JqX2RlcGVuZGVuY2llcyAqIHNpemVvZih1aW50MzJfdCkpOw0KICAgIC8qIGZp
bGwgdGhlIGJ1ZmZlciAqLw0KfQ0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56
ZXJAbWFpbGJveC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxOSwgMjAyNiA2OjQ3IFBN
DQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGlh
bmcsIFByaWtlDQo+IDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgTW9oYW4gTWFyaW11dGh1LCBZb2dl
c2gNCj4gPFlvZ2VzaC5Nb2hhbm1hcmltdXRodUBhbWQuY29tPjsgS2hhdHJpLCBTdW5pbCA8U3Vu
aWwuS2hhdHJpQGFtZC5jb20+Ow0KPiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IE9sc2FrLCBNYXJlayA8TWFyZWsuT2xzYWtAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAiZHJtL2FtZGdw
dTogaGFyZGVuIFNJR05BTC9XQUlUIGlvY3RsIGFyZ3VtZW50DQo+IHZhbGlkYXRpb24iDQo+DQo+
IE9uIDMvMTkvMjYgMDg6MzAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+ID4gSGkgZ3V5cywN
Cj4gPg0KPiA+IHdlbGwgd2hlbiBtZXNhIGxlYXZlcyBzb21lIGZpZWxkcyBpbiB0aGUgc3RydWN0
dXJlIHVuaW5pdGlhbGl6ZWQgdGhlbiB0aGF0IGlzIGENCj4gcHJldHR5IGJhZCBpZGVhIGFuZCB3
ZSBzaG91bGQgZXZlbnR1YWxseSBmaXggdGhhdC4NCj4gPg0KPiA+IEJ1dCBhbHdheXMgc2V0dGlu
ZyB0aGUgcG9pbnRlcnMgdG8gdmFsaWQgYXJyYXlzIGFuZCBqdXN0IHNldHRpbmcgdGhlIG51bWJl
ciBvZiBhcnJheQ0KPiBlbGVtZW50cyB0byB6ZXJvIGlzIHBlcmZlY3RseSB2YWxpZC4NCj4gPg0K
PiA+IFRoYXQgZG9lc24ndCBldmVuIG5lZWRzIGEgZGVidWcgbWVzc2FnZS4NCj4NCj4gQXMgZGlz
Y3Vzc2VkIHJlY2VudGx5IGZvciBhbm90aGVyIHBhdGNoLCB0aGUgIihIb3cgdG8gYXZvaWQpIEJv
dGNoaW5nIHVwIGlvY3RscyINCj4gcGFnZSBvZiB0aGUga2VybmVsIGRvY3VtZW50YXRpb24gc2F5
cyB1bmRlciBCYXNpY3M6DQo+DQo+ICogQ2hlY2sgYWxsIHVudXNlZCBmaWVsZHMgYW5kIGZsYWdz
IGFuZCBhbGwgdGhlIHBhZGRpbmcgZm9yIHdoZXRoZXIgaXTigJlzIDAsIGFuZCByZWplY3QNCj4g
dGhlIGlvY3RsIGlmIHRoYXTigJlzIG5vdCB0aGUgY2FzZS4NCj4NCj4gVGhhdCBzZWVtcyB0byBh
cHBseSBoZXJlLCBpLmUuIHRoZSBrZXJuZWwgc2hvdWxkIGhhdmUgdGhlc2UgY2hlY2tzIGFuZCBN
ZXNhIHNob3VsZA0KPiBpbml0aWFsaXplIHRoZSBwb2ludGVyIGZpZWxkIHRvIDAgd2hlbiB0aGUg
Y29ycmVzcG9uZGluZyBudW1fKiBmaWVsZCBpcy4NCj4NCj4NCj4gUC5TLiBJIGFncmVlIGl0IHBy
b2JhYmx5IGRvZXNuJ3QgbWFrZSBhIHByYWN0aWNhbCBkaWZmZXJlbmNlIGluIHRoaXMgc3BlY2lm
aWMgY2FzZS4gSQ0KPiBzdXNwZWN0IHRoZSBydWxlIGlzIGFpbWVkIGF0IHdoZW4gdGhlIGlvY3Rs
IHN0cnVjdCBpcyBleHRlbmRlZCwgaW4gd2hpY2ggY2FzZSBNZXNhJ3MNCj4gY3VycmVudCBiZWhh
dmlvdXIgd291bGQgYmUgaW5kaXN0aW5ndWlzaGFibGUgZnJvbSB1c2VyLXNwYWNlIGNvZGUgd2hp
Y2ggYWN0dWFsbHkNCj4gZG9lc24ndCBwcm9wZXJseSBpbml0aWFsaXplIHRoZSBuZXdseS1hZGRl
ZCBmaWVsZHMuDQo+DQo+IEl0IHNlZW1zIHNhZmVyIHRvIHN0aWNrIHRvIHRoZSBydWxlIGV2ZW4g
aW4gY2FzZXMgbGlrZSB0aGlzIHdoZXJlIGl0J3Mgbm90IHN0cmljdGx5DQo+IHJlcXVpcmVkLg0K
Pg0KPg0KPiAtLQ0KPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgXCAgICAgICAgR05P
TUUgLyBYd2F5bGFuZCAvIE1lc2EgZGV2ZWxvcGVyDQo+IGh0dHBzOi8vcmVkaGF0LmNvbSAgICAg
ICAgICAgICBcICAgICAgICAgICAgICAgTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdA0K
