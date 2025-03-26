Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D12FC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39E310E14D;
	Wed, 26 Mar 2025 15:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="noQ8nD+h";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE2110E722
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt06bm5IQ8Te0Yvf5J8jPbcP1ZPILjK2qAiVrm7z4I8cL1/8949j8tfnNkVTKHHmvAP3kj/69qxNh4UCGRSgb4GO5uF4pjGh3vIsr7urjmk6QmCRq0H1MrUOZofgtvqm3Dy+GVxsvOtZb+9B/nr3SwNIHy7OZ9+Oas76uJkSdWrNiKWVuJv/jfuo6t0vDI3MvLqvzRrUEguQZZi6bg6DFY0pSSbyw94bpnCfi2pfLAAaFW1OB4spLudltFwWCigDpfsy6YjJay0s5cZ0J+aAXVRVn8z0c/pp/LRSgCZqx7WhufU3ogo/WZ7l0IvPA2Fmngc/y2UoHRIKgGMHztxYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE5uj7J+6ZMh/aIbalpuLaJxe4nzsylyV/4s9frNsXU=;
 b=gafKYE96TiMrK++s82RCijnNrr1NlXH9YnmM0OnUd9PLSXt8/J3eeFiq/6R+jZJ8c6dcRrzWvJ7/+TT9yzIHh8TobynlSad6WmJZQ+Fbt7REzmZCxoZNb5QY+asJTmef+oEIeUDhxpxHW6Jxw2h8ClxG7Wzi5Bp/fyj6aA9281vXFviAfm9Kcw4TKiVwPu4sczm6YWhEbtgKa47xIieJrPTE+WKbL5wLEMsl9uOwgtIauuchJcCxVMLuB3kRUMWJ9xGwie1NYNHh7H5DM9NqH/HTGNrXfUJo64wUAd9pIKIva7RgFskdYKwZwdhLDKvnDKQwA8UrszgqOd6RnWQ5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE5uj7J+6ZMh/aIbalpuLaJxe4nzsylyV/4s9frNsXU=;
 b=noQ8nD+hR172cPlUWTs4ZSGErXs4jwMUHbpEWovZIqk0abDrUZ9nr31Tt3EwnF8hDLR9BjVdjp41B45T7kis1drjFCQkP5bx8yN81WAM9Z5QJJIAqjX4o+5BH5DV1LlTvUEfGdCk7GW+3uXgcv8nuMa3SaAbYMQ1+v75tPV1g1s=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:55:24 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:55:24 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Thread-Index: AQHbnlUN5JUU5TwLhECEvzQHs0koULOFjG2QgAAFQQCAAAB3YA==
Date: Wed, 26 Mar 2025 15:55:24 +0000
Message-ID: <BL1PR12MB5753328CBBE46CD6EB5C451493A62@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250326134301.1012270-1-alexander.deucher@amd.com>
 <BL1PR12MB57532C62D07EBAE311ECB23893A62@BL1PR12MB5753.namprd12.prod.outlook.com>
 <CADnq5_NO7127h0do+5uBpdanhR1OdfWKbxv4gt0yteQD1qi2gg@mail.gmail.com>
In-Reply-To: <CADnq5_NO7127h0do+5uBpdanhR1OdfWKbxv4gt0yteQD1qi2gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e24ddaaf-db72-44fc-8ea3-60789d8042ff;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T15:54:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|BL4PR12MB9480:EE_
x-ms-office365-filtering-correlation-id: 77139ec2-2ec3-4713-c056-08dd6c7e9f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEdXTGluQklxSmtZQk91ZlFvYTdxZ3BuaDZvMGNuSFhtSS9TQlVvdXR0aXdi?=
 =?utf-8?B?Zm4vZ3RNOVY0YTBmcE8yWUp5a3cxRUFiRlF6dHdPYW42eUJSbTNEbHlYZFRx?=
 =?utf-8?B?ZWRMUUJpb1ZiOGVtNkc2VVJHZG9MK0plMXBNZ09yZmRDWEljdlc0djV4VElz?=
 =?utf-8?B?WkN5Rk1hUU0vRVhCaURwd2ZFNmsvNkpiak5OSnpMWDFUb3ZaMTRITVFGOHVU?=
 =?utf-8?B?M3BRdUxWL2J6VGFlYmlkS1ZSOGkzZ1l2SEZEZFFnWEV1dGF5UWM0c241cHow?=
 =?utf-8?B?MFkrVHhJaElMM2NxZDd1Qm4yck12dnRDK0VKL3ZnZHF3SjNSanpRUUhzemU0?=
 =?utf-8?B?ZDRVc2JnNEd0Y1BUaUUvNzZLL3BacFhxQVg4Q2gvRUtDVUF0Vzk5QVVORWlu?=
 =?utf-8?B?WWk1S2FXb0ZBSVZGb2tSYWZ2Z0c5YVFvZ01waDh2RXJuV1pUSG1JTGpFREZW?=
 =?utf-8?B?emVlTXJzUTEzeSs2YTh1WGZvYSs1RGRDd3dFakJWaWkzQlJ0UEkrQnVlakkr?=
 =?utf-8?B?eG9XeG5wYlRVemt2U01YZE1mWFAwOHN4M0dYVGhzS3JhVldXWkgrRU4zU2wy?=
 =?utf-8?B?Unh4RWZ6eGpKNEZFb0o0SkVteGhaVlhwcTMrOUVTRElaTW15Z2VFTnVxVzRF?=
 =?utf-8?B?YS9uYjhsZW43R0VrcEFVRzJxWnlINXU2WGFVRmNkUW1iVnR4OXdnbG9KWlRq?=
 =?utf-8?B?Yms2dC9GKzBmYzUwU284TUtYVXZXWkVJaUt4WjlxY00zQXlSdEFyMVNDcWMw?=
 =?utf-8?B?KzN2bVplQWlMVnd5MXRmaExrQVJTcG5BZmgvM1NiWlNIM2FhdjZ1aHBRYmIw?=
 =?utf-8?B?Yi9vTWNlRW9DSXc3WHhOaHVhTkNrSDhqaklzWXdtWmtDbWE2L0VZTnAxNFJW?=
 =?utf-8?B?dmJDS1l0SzFjUmdPNHMyQ3B5a1A1QU9uNmV6SFFZcFhpZWlvQTFyZ015Wkdw?=
 =?utf-8?B?QnN5RE5qRmg4bXN2b05BeFhQQThQRFFqL0R6b1B0c1NhYnRzckI0dGs4dHN6?=
 =?utf-8?B?OHMzRU41cXVYV2FqTmRTNHFLMVgrN3Bod2JOQkFzTUNUSHBmYUhJcko2czVm?=
 =?utf-8?B?VXQyVGJZTlJrTnhzN2RZVVcvRzBHNlBtWHpCc1NPR1lkR0VwVDlyZDQ5Z3Fu?=
 =?utf-8?B?cStUQ1hIaDM2RU5FWEdwWm95YWpwUVBobk40b296aFlpRUpZcmErN3NXK3Av?=
 =?utf-8?B?SWY1SGwwSGpLN2NuTmwrWDR3d3BGZWxaVFdrUjEwcS9GU2YrVnlyL0hMRi84?=
 =?utf-8?B?amVwVjJCdVpCMEZhTDE5RmFsdjdCdzkrMzVmNENib2Z6dklNWjdiNGV3OWhX?=
 =?utf-8?B?UkwxTHlkaHl4OElCVW5QemJhL0hraHpLYUVyelNkYnFSSi85dE51d1RDRktS?=
 =?utf-8?B?RDlLNE5GSi9RajZZTTJhUnJWaEk1azNyclF3VHhEYllKOENWaUpiMllnejRv?=
 =?utf-8?B?VkZZbG9uMktaYitoVkJySVdoWlVwekJqSTRzTHJsejE2OGUvWU9hR3RIeXJC?=
 =?utf-8?B?Y3ZlU3VxWTRLUnRmZTcyaGszUkU1YktqQUo4UzdYSHZuT3hIS2s0bTkvUUJa?=
 =?utf-8?B?dkNhTW9JdHhsVlBnQSs4d1dZaXVMNCtVeDlITm5vTjVBQ2I3dS9KS2hCUWVx?=
 =?utf-8?B?R21UUzRJTmZWb3hIYk5iTkpOMm5VN25nb3U1TFpvSDI5Y1JxT3V0eEwrY05F?=
 =?utf-8?B?U1pnZXVPTUwwdDc4WkFaVHdDZlJ0djN3Wkk0VEo0bEtFVzRraXBZYXN4eURU?=
 =?utf-8?B?OE8yMTNCN2lueUFWcWtrL3BpY3dNWm5iNmpsWEZVS0kvVGFZTXprY2p0dGVn?=
 =?utf-8?B?Tnp6M0VoaDRQVlJqUjZGa1JZSUxEQ2FhT09nQUxYN2w0TmxEbFpKVE9wQXhS?=
 =?utf-8?B?UUxSY0xlTVZaNFkrSVhEZEZ2ZkphOHBOVHBCWFhpUWM3WEh1TWtSYWphKzhu?=
 =?utf-8?Q?lrwnYyB8jJY/ViFlF2bKIlUZCo1kjb8E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThIbDRQWTFGanhyZEs0WXNpVWFmZkc0Z1R5WFA1VzhNakswUEdueGp6VEFq?=
 =?utf-8?B?eUhtcWRaa2lOWDVxUkhuTE9Yb0NmbXp3YjdDUlVZT0NQejh0S3lEQjQ0aEZ5?=
 =?utf-8?B?RUFBRDliSjBLdEttYTVhczV0M3BmUmI4dWtqaFljVUQ0Q3NkeTVIRy85ZkdZ?=
 =?utf-8?B?MUN5ai9HQlNFR1pUR05FOGZudXcrbENQbnhPczYzUnVyVm1TTk5yNElsZ0Zo?=
 =?utf-8?B?ZEE3WWtCam50V1lScWp1TU82TDR4SFZFNzZaNmxvVzY1NWxOMXZvbjdUTFlp?=
 =?utf-8?B?WnVYM0NNOTNGTmtHZHoreGJkeWRHcEcvNGdPSmgrSllhejArTDd0TkV0Tkhy?=
 =?utf-8?B?TGdqYmFoYUtRWW5IampLWUJPcVVIWEtqZVprYnhGYnRmbkJuRlVlSG5kdkpC?=
 =?utf-8?B?YVFqMktjaGJscElRNXFuQXlZaDJzbzFrUnFzanhTRzNjcWlXRk9OU1IrSllI?=
 =?utf-8?B?RXFERGluK1ZMY3R2c3ppV3NNMnQwcUJJT3NKRnUzNE1udzR0c1EwdWJUZ1Qw?=
 =?utf-8?B?MytCcnp2Nm1LUm55em9EZUczWU54MGo1U0JlT2k4VEIxM2FxWENZcTErNStR?=
 =?utf-8?B?K3E4MlBucXp1eTBiNDZGS2NQd1RnR2tMTG5qMkNFZ0VtM25BYmRKczRvTHl6?=
 =?utf-8?B?MHRvNjVxc0FSSXdTZUpsZ1pWdDl3NEJjWXJIZEl5RVhDTGpGU3AzRmxkVjVX?=
 =?utf-8?B?czR3UHJWb3NJUjFLRWVXdnAyUTV0eUtHdGFmZFl5eitpRy8rZlBtb2h4L2li?=
 =?utf-8?B?V1pLVTRTVUJWZ1ZOalFSSlEvakpyc2duK25yWm1yVzlwd2RBTEFFZXh0aGdm?=
 =?utf-8?B?T3BzdytsSkp0MEphckpPVGp4VkZ3ZnJFVXZuTGFWeG5QSFZVMUR4TURYSDli?=
 =?utf-8?B?dGF6QXU3SnliTkdVcS8yQTNsTE5FeDFjUnZ4dEhIMGQ3S1RiWUhmbmNoUEk2?=
 =?utf-8?B?Wm5WaEFSUUV1MU9DVFR0RC9NcnloTlFSY0ZuclQrME1OS3haOTVOMmUxWFgx?=
 =?utf-8?B?MmQrZXI0ZElheFp2akExS0w4NzhPdTRGM0tTS0plL0E5US9wSEhZUHN6ZC84?=
 =?utf-8?B?RmJTMS9RcGw2Rzk4S0J1S3B5WnVXNUlRSGFheld1bDI3Q3UxZWJMVlJGK1l6?=
 =?utf-8?B?ZUtvMnhQUUxjWEMxRWxVekU2bXdINWNwV0Y3bWpOclBOM3JqSFZKMVRVb1Yv?=
 =?utf-8?B?ZXlaUFV5eVcyU2NOWFhUUEVQcXdnUnB5QTUvaDZxUHp0SjZQUE41UmtOZlMz?=
 =?utf-8?B?UE9qcEM3TjZpbEVvanFKUmppUjRhdzBRZFk3OWUyekR6a3NpU1BiOXk0RjhN?=
 =?utf-8?B?T0J5Mm0rZmdpcEJtckFwa1liQ0tIMXlsTDlOMTI4TWlKb052TEdvVC9FTHl6?=
 =?utf-8?B?ZkZxZytxZm1pMlVCRE9YRTNmWEtDSWtGcE9JK2l3eEdneEZTM2ptQWpxMTUv?=
 =?utf-8?B?NDl6NlpZcDI4ZWRHUE1MYVl1cDh3QW5DRHJOSG1sZHlnbjEzTW52RFc5Vy9o?=
 =?utf-8?B?YjdRSGYwaEpHN01vVzdleGw2bXg0RWZaTll4ZE8vVm1iZG5ReWRGb3pSdTRG?=
 =?utf-8?B?U0RBV2ZNSXA1dXJFMnc0YnYvWEI4dzdjVHo0dXlQSE53T1Rmcm5ESmExR1JB?=
 =?utf-8?B?Z1lDV0t6bUw3YjhVNUdNVms3dkU2b3ZtK25ldTF2NStSQU5xM3hOZnRUcGJp?=
 =?utf-8?B?MmF4aEVZaEkwUm8yWDVoWDMraTNBQUdiTlJUQm53UG5vY1J2UjI0UmNnN28x?=
 =?utf-8?B?UHlJVmJpcXdQTHBLK1BlVFB5Mk5jck1yWGdTcXlROUZuU0JSWEJqeWNjMU0x?=
 =?utf-8?B?V1VVaklwQzcvOFFhSUZNYmw1TGQ0SXMxTVlkd3lSYWhpeUNUZzZGQ1ArcmRP?=
 =?utf-8?B?d2tIVXdYVHlqUmVaaDB3alJFdlpxVU1pK1VSRVhpQ3orVHRFajFVSzJWSnc4?=
 =?utf-8?B?c1NJRlpMc3p2SVh5NmdHUmUreGNwS2tORndKazZkUE5rUGFHSzk0TnN0TWs5?=
 =?utf-8?B?UjV0OVIvbGFNL1Qvd1RLZmZyaHc3Z3BlckZtRE5qRVRVWkUxalBpTjVuYzFw?=
 =?utf-8?B?WUxNT09YbHFTbThsbXBuUFNqSU5hTzZwMVkybm5jdE03bHZkQ0Q4RHZOQ2N2?=
 =?utf-8?Q?YX7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77139ec2-2ec3-4713-c056-08dd6c7e9f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:55:24.7220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMWnQpdXVvJzDDX9KeXAvkkJ6/087yTweC84xxpRiCKtJDazqNDiPzfpFAtZEpyo+Bk/KzkeLlBFT2JTi2K5uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9480
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KU291bmRzIGdvb2QuIFNlcmllcyBpcyByZXZpZXdlZCB0aGVuLg0KDQpSZXZpZXdlZC1ieTog
U3VuaWwgS2hhdHJpIDxzdW5pbC5raGF0cmlAYW1kLmNvbT4NCg0KUmVnYXJkcw0KU3VuaWwga2hh
dHJpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjYsIDIwMjUgOToy
MyBQTQ0KVG86IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPg0KQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdS9nZngx
MTogZml4IG51bV9tZWMNCg0KT24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgMTE6NDjigK9BTSBLaGF0
cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IEdmeDEx
IG5vdyB3ZSBoYXZlIHNhbWUgdmFsdWVzLCBoZW5jZSB3ZSBkb24ndCBuZWVkIHRvIGRpZmZlcmVu
dGlhdGUgYmV0d2VlbiB0d28gc2V0cyAsIG9ubHkgb25lIHNldCBpcyBuZWVkZWQgbGlrZSBiZWxv
dy4NCg0KRm9yIHRoZXNlIGZpeGVzLCBJJ2QgbGlrZSB0byBrZWVwIHRoaXMgYXMgaXMgc28gd2Ug
Y2FuIGdldCB0aGVzZSBwYXRjaGVzIHRvIHN0YWJsZSBhbmQgdGhlbiBjbGVhbiB0aGlzIHVwIGFz
IGEgZm9sbG93IHVwIHBhdGNoLg0KDQpBbGV4DQoNCj4NCj4gQXMgYmVsb3cNCj4gY2FzZSBJUF9W
RVJTSU9OKDExLCAwLCAwKToNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDAsIDIpOg0K
PiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMyk6DQo+ICAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDExLCAwLCAxKToNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDAsIDQpOg0K
PiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgNSwgMCk6DQo+ICAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDExLCA1LCAxKToNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDUsIDIpOg0K
PiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgNSwgMyk6DQo+ICAgICAgICAgICAgICAgICBh
ZGV2LT5nZngubWUubnVtX21lID0gMTsNCj4gICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5tZS5u
dW1fcGlwZV9wZXJfbWUgPSAxOw0KPiAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lLm51bV9x
dWV1ZV9wZXJfcGlwZSA9IDE7DQo+ICAgICAgICAgICAgICAgICBhZGV2LT5nZngubWVjLm51bV9t
ZWMgPSAxOw0KPiAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lYy5udW1fcGlwZV9wZXJfbWVj
ID0gNDsNCj4gICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5tZWMubnVtX3F1ZXVlX3Blcl9waXBl
ID0gNDsgI2lmZGVmDQo+IENPTkZJR19EUk1fQU1ER1BVX05BVkkzWF9VU0VSUQ0KPiAgICAgICAg
ICAgICAgICAgYWRldi0+dXNlcnFfZnVuY3NbQU1ER1BVX0hXX0lQX0dGWF0gPSAmdXNlcnFfbWVz
X2Z1bmNzOw0KPiAgICAgICAgICAgICAgICAgYWRldi0+dXNlcnFfZnVuY3NbQU1ER1BVX0hXX0lQ
X0NPTVBVVEVdID0NCj4gJnVzZXJxX21lc19mdW5jczsgI2VuZGlmDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPg0KPiBSZWdhcmRzDQo+IFN1bmlsIEtoYXRyaQ0KPg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gQWxleCBEZXVjaGVyDQo+IFNl
bnQ6IFdlZG5lc2RheSwgTWFyY2ggMjYsIDIwMjUgNzoxMyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdS9nZngxMTog
Zml4IG51bV9tZWMNCj4NCj4gR0MxMSBvbmx5IGhhcyAxIG1lYy4NCj4NCj4gRml4ZXM6IDNkODc5
ZTgxZjBmOSAoImRybS9hbWRncHU6IGFkZCBpbml0IHN1cHBvcnQgZm9yIEdGWDExICh2MikiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gaW5kZXggZTBhOWIxMGQ2
NDVjNi4uYTllZjMzMjA1YzU0MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMV8wLmMNCj4gQEAgLTE1NzMsNyArMTU3Myw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX3N3
X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ICAgICAgICAgICAgICAg
ICBhZGV2LT5nZngubWUubnVtX21lID0gMTsNCj4gICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5t
ZS5udW1fcGlwZV9wZXJfbWUgPSAxOw0KPiAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lLm51
bV9xdWV1ZV9wZXJfcGlwZSA9IDE7DQo+IC0gICAgICAgICAgICAgICBhZGV2LT5nZngubWVjLm51
bV9tZWMgPSAyOw0KPiArICAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lYy5udW1fbWVjID0gMTsN
Cj4gICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5tZWMubnVtX3BpcGVfcGVyX21lYyA9IDQ7DQo+
ICAgICAgICAgICAgICAgICBhZGV2LT5nZngubWVjLm51bV9xdWV1ZV9wZXJfcGlwZSA9IDQ7ICAj
aWZkZWYNCj4gQ09ORklHX0RSTV9BTURHUFVfTkFWSTNYX1VTRVJRDQo+IC0tDQo+IDIuNDkuMA0K
Pg0K
