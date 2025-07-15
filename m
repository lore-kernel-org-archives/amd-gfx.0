Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A5C83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 11:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2A710E094;
	Tue, 15 Jul 2025 11:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZxweF8xd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3F710E094
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 11:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UU+cYsWx00naxW3zEuDn9egjRi8As7L8HZUqthFUl7omld6axe7RqCE72QT2lPr9SQJz1UgrU/D5H2+SuzB5a6VGknzY5e+4g1cFQVWDv5w8B+WK0hmAT3swRZv874skO3wIJVytvv5MCvcmZw+AESbdH+hHmfTYPQmYjTK9tW7XoUuAAeDwOvgvadM8nlse+3PT0LdW3Uq2WFLxPttdeSKrjQsByidanS6slFgEIc46R6FnxZ0IZeNOKVbp4GUm/XFbMQCu2f0gUTS9FVW+mVt0kgEgIlWoM7grXPUXxXqQ2keUg78PF0671ZlocFzXhTNtVuTRvB+D5JHq8inM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ewitdeYEOZrL423SOSkAVFM5qj0SMQGIkD5hKtZ7mY=;
 b=c2nPHh8OQMm6J81s7mE7ohdxTBy/Ig9VF/88C2UUnQiH3CQJAmVL6xp72cvkE1C2I33Wi8aYRNWY6J/277G2mlinigCb7u4T37YQREQSyC1K1NBRwoDbS7dmTaQdupVP8JCiyJPu/6zEdvqmeC5WyuYfNOaLmlhpqbL3HVAJ0hn9qRRwJQfip/UPH2KNZxuKLnbBLFCHuR32kkqpaZB+0aEvLcHv7oaaB6e3zAB6xp7G4LFnU0eJBs9OFcO90CPUX5//B7CHPwAhxhP98dfkwIft06fd+/rjJ24de0xkVTV6bbrgfycrbPMM40U015WzsQ0joF1qgPMzNUKgwX9H+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ewitdeYEOZrL423SOSkAVFM5qj0SMQGIkD5hKtZ7mY=;
 b=ZxweF8xdyWvJnBBNhW8wXWHGD+2vu9gDmyI3nvdqGpDHDaWCu4GQC61xErIwaasGz4FyquW4yfdULpKUhoFo4BjwB60PxyE1SArSFBIE9aZ9BY80uMpWKYa4kVUsrGA9JeE64VSHe0G9zASIkqLSn2P37jNdMpf0WaPLkVikHLM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 11:51:00 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Tue, 15 Jul 2025
 11:50:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v6 07/11] drm/amdgpu: validate userq's last fence prior to
 destroying
Thread-Topic: [PATCH v6 07/11] drm/amdgpu: validate userq's last fence prior
 to destroying
Thread-Index: AQHb8kfB+ixduxwpoEyCby4FXE5U/7Qs1ZeAgAZAt5A=
Date: Tue, 15 Jul 2025 11:50:59 +0000
Message-ID: <DS7PR12MB600519342AB474F08F21DC0EFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-7-Prike.Liang@amd.com>
 <4e9bb1f8-2c73-40c2-96e3-cc186a476a5c@amd.com>
In-Reply-To: <4e9bb1f8-2c73-40c2-96e3-cc186a476a5c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-15T11:41:51.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4358:EE_
x-ms-office365-filtering-correlation-id: bc35ab7c-902c-40c3-8e00-08ddc395dde9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cW1JN29oTzlyT1FaQzRYV0tNMXNLQ0IvN2h2NEJERlhtWThad0ErRGo0SFZG?=
 =?utf-8?B?TGxuTC9jYnVSZVdObmI1enhBNC9YZlFGWFh3VnpyY1RCeFZjbmNxMGlZY3A5?=
 =?utf-8?B?S0dSS1RmMzRSbjlWQlJuREkxc2JIb1FteUp2Y2JuRlNqaTNyeCtMY1FWbkJ6?=
 =?utf-8?B?aVNsM2dEYVQzUWlYTFMxNG1ZeDVKNXFLZzlMcWtnL1FzdnpVelNDMGZScXBv?=
 =?utf-8?B?U1VRQmhpeVRiUTMyK0NsYUJrNTNrWHJzYXV5SUJZd0NCVkNXUEJPLzhZY1h6?=
 =?utf-8?B?U2FKaVVDNFVYa3VZclo4ZTRmbTJoQWhrb2xoQk8xZ2JUVndCSTYwb1podCt4?=
 =?utf-8?B?cysyUTBhZEpyZGZXTnhBWmtXKzAwYlZrd1hyVnd4alRhRjB1VDJCUDdlUFVx?=
 =?utf-8?B?M1BYUms1TEM1RnhFRFNPQTJsOTVCOXJuVkdNSjIrNVNCM2R1L0ZuMFIxV2xT?=
 =?utf-8?B?MElZRHRUVXRDL2x1M1N2U01LSm1JWmNwV0ZaNTB1NW82T2hiRDlGeW1pd0JD?=
 =?utf-8?B?S1dqdDZmK0hXeXJPelVlMWYzaERwUmxtdGZqamYweWRaV1hmNTVRMUlrNnVT?=
 =?utf-8?B?UmE4dlRVcUFHZlFWbTVaSVd2RXRIajFhc0oxNzg4Rm1ieFA1bWxjcTA0With?=
 =?utf-8?B?WmNPM0dPbWRXcUg5c053YlByNXIxYlRMUUtLTTZ3MEFjTytTNDA5bEtZNnh1?=
 =?utf-8?B?b0RTLzUybUY3enE0S0NHeUZUUmdXNFpESnhOVFV4WDRLczNhb0hNT2ttUXdz?=
 =?utf-8?B?dXVrVkhNdm9JTGlVVk9tMWRFakNOdGNqRGEvNUFkdEVzc1hDdFlCOFQwcWNv?=
 =?utf-8?B?N3lIMlExKzlyVFdqaUlVNmlEMC8vOUVpTlpOdStNZTlIb3BCMk9hd0FPU200?=
 =?utf-8?B?MEhDaURicjJZUEk3b0c4NEFCRCtZdU45S05GMnlBbm5mQk9BVk9XSEdYZktY?=
 =?utf-8?B?K1plQWNFaUF2WWR1L1hpdTJsQWhNamNPMFFtcVpSZk84OG5BaHFXV1NQSnM3?=
 =?utf-8?B?WEVhZXFXelBpUzJxSG1qRlo4YWpjd2grbWtVVUZNaVJocTh6R1JNcVk4UUNs?=
 =?utf-8?B?MUx3UnpKbXlFK1Y3V0Y0YWlRRTNlZ0t1R3l6RTN1akU5Q1ZUYjZtdTBqaDdU?=
 =?utf-8?B?dEVXYUN6YVhCbTBNOHVxMEpHRngyYjBOVStzWENvQ0ZESUhkYm9iOWlka0Zh?=
 =?utf-8?B?Z3lMcVNaVmRmOGRBVGtjWHFpOXdXNG54cmdaL0dsZ0xVWHVsVFdpOFdyR2RL?=
 =?utf-8?B?d0ZRS2JrVjdHSjQ4amxwRG1SZXNEMlJWNk54VEk2ZGM4dDRGdjdGMEQ5ckVQ?=
 =?utf-8?B?MzJxcUFRbzJ3VHVrV1gwbHZSOURGYmNTSnpDWmZjUTdwbEE5SjRRdzJvSDR6?=
 =?utf-8?B?VXM4MzRLdnVVa1RGNkgzUzhCSEp4cG42ZFNDbjBiTHJNMjd3VTZDWTk3SGFR?=
 =?utf-8?B?ZWE3ZzlrY3l5V1o2THBqYW1BZTNjUk1VMnczb1pBY1F5d3NkUCs0Q0lUcHVY?=
 =?utf-8?B?dldYYkloM1E2MHhSNTdtVUFhS2o0d2E0cUo2NlB3MnFrMTFMUEJTT1lYRHJX?=
 =?utf-8?B?ejlJY0ZVRit4NFRoaXhqWGh0UGwyajJPa0VpWXU0L2Z6UFhtTVBSMDhEUy9v?=
 =?utf-8?B?MWRqVE9CMDBTd0dGTnUwZ2NWK1hMNXdHQ0QwTU9OWVZuRTJ4aWJqa25JQVJJ?=
 =?utf-8?B?L1cyVythSWFuN2s2L2d0WTFkd2IvaXphUUJubDZ0eDVsOEtJMmRteVRXNldK?=
 =?utf-8?B?LysxMHhmZHhwdm5hQ3RPZ3dCMWJHQUpiQnMxMzdNcWdmU1h5bitCaC9WbjZR?=
 =?utf-8?B?akYzeGhEeGVPT3hLWnplL2h1K0RPSHpJNWhKQVFySzJwQWszamNsck9zZ3U2?=
 =?utf-8?B?YzVpeGpnYm9RYUpVTVVEUExJRitERWpWR2FzTzdQN2U4bTRvNnRvNzl4VVJz?=
 =?utf-8?B?UnRjTTFTWXdwSVVrUmM0cUdKSFdoam9DMGdKZUFsMEhNMkZzWjEyRWZWaWp3?=
 =?utf-8?B?OUhyNytYWDFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXIvSGlZdlhWdjFFckxzVVlKV0JnT2srWFR4aGw3TkN3VUwzUGJUYWp5by9H?=
 =?utf-8?B?eUErQk8zWlI2QUVJT2E5cGNxY1ozbFl5ZUkxRlBMN1IxK0NZWjBrNUtyYlFV?=
 =?utf-8?B?QWJyR3J5QTJhdmJnaldBU01Tbm1tYW1ZbmQ5YXZKdkx1dmxYeTJNZS8zd0U3?=
 =?utf-8?B?SENLNCsrUithS2l0ekd6cU5GMUVwNXF3ckd1ZXZ2MTV4VHljRzE5TXRROE9V?=
 =?utf-8?B?ZWJMVDZNbnovNmdlQzgzT2UwNVg4SVdyVkJyK200Q1ltMjlEWVVtOU1hMFFB?=
 =?utf-8?B?KzN6MzQzeVRaV1ArSlBHY0NBQnAyaDIzUTFBZFRjWWs4L0Nqa3ZCME8xcG1G?=
 =?utf-8?B?eG5hUUNwTVJ0dnNnTzlxZUs0b2c0Rk1Gb3RpdGkrWndWTVlBSHJZdzVBTHY4?=
 =?utf-8?B?bGJYT2tCR1czSE4xbUFVVm14Nzl0bDJ0RzNPWVVaS1VhYjJGTGZhY294cWR0?=
 =?utf-8?B?d2JCVGxTUzJpVjNDY3Y0Z0pOV0VQM3BGcHMvcUdVS2VteW9EVHRjNnNCWm1H?=
 =?utf-8?B?MWt4UytKSk10bWliaUp2dGl3aFZXbUs4NnprZFE3ZzlLMXlSaXBBN1UwVE9r?=
 =?utf-8?B?T0xlT0lUZEl4N05UYklVZythUDhVaE0wWXpCL3NQVWpyanF0STZUdE43NmZI?=
 =?utf-8?B?UndhVHpka3UwbWJ0ZUJVZTl5c0lNVDllaTZqMC9NaVpwZ20zS0l4TU02VTVO?=
 =?utf-8?B?VmUwVEd3VGw3bEx3ZTd1MlBEQU95QmlZeDZJTElSOCtER2RFenZaS09PSzFG?=
 =?utf-8?B?NmdhS1hnTW8vRWxoZWwrWWpaZzdhT3hSM3VPNEZPZUVwRFpGemIrNmlpK1hZ?=
 =?utf-8?B?ZXh3dktjSlBldHZUczJjaTE5eW1tQ0dZU3h4bXVpRDFUdUdqRVpNQjVTNHpu?=
 =?utf-8?B?STZneGxNZzRlcS9wRTlyOElVc0hBZ2c1YjM5Ty9vQitWVGk5Y1FDZWE4Tmh6?=
 =?utf-8?B?c3grRzBqZEFLQWRnc1hLTGg4T0JMTzFGRjI2d3BpREVzRGdaaHBqMVIzRzFS?=
 =?utf-8?B?WTdMYUlBV3FJWlM0akRpbVdZZk00Smk2Wmp2L2lBdzUwVmxTbUhzMTcrY3B4?=
 =?utf-8?B?V2pWT3Azb2IrZjkrcS9WZzUvM3Q3aUR4MWJ3ZGtrNWhvUWRVTFRSckxrZ0Rl?=
 =?utf-8?B?cDN5TEhXZmdXZGNmR3JBcis3Q1FKbE1LU2dhaXpkdEl5U3ZJa2xhSWR1UU9P?=
 =?utf-8?B?OEgzaW02MmtYVEs0aWluZjV0SHQ0VlVuQTZtRURSNGUyVjhLUHVOVGZXRXJ1?=
 =?utf-8?B?UHZMNldST0wydy9KRGhncjI2c2Q0aHgwaG5kdjh1M1BFZTlGdlVxQnhhRWJJ?=
 =?utf-8?B?L2ppM3pteFhlRSs3c2VPMy8yTXFUZm1QcCtHNXJKT2wxb3hGQXZQa3ZJREhW?=
 =?utf-8?B?N1BaN0lnTmVJNzFLV2t2MTArRks1QWUzZDlrQi9HbWZlcnRyVmxQS0dWNXhR?=
 =?utf-8?B?QVFac0ZvNHFld0xpRWNCYkVXWldDWThrUlJvTlZyQ3dZbzJXdldoRXBPTVJt?=
 =?utf-8?B?OHd1WWJKOE03VDlBNTZhZVVGRHl1dzdFU1NXTEhYblRSeUpVQmxrSmNHdlJU?=
 =?utf-8?B?MzBqUC9ZZXRGc0Z1czdUNTRGUW9TS0R4QUFNRHZRZW1seUNJMlhJVCswdkhG?=
 =?utf-8?B?Mm1kcHc4YlpERDU2UlRxUmlnZVdjamlVS3JvUHl4Ty9CT2N6SmlMMUdRU2FK?=
 =?utf-8?B?VDdTb3VMU25PajJMbnZnbkVxb3N1dHA2dzlOMlVDSXVwL3ZWSzVMQzlaL2NY?=
 =?utf-8?B?WlNtMlF2YkhWdHUyWW5KSEo2aWI1MDBCM2Z6WkJFTk9RU25CdVJFT2dpM1Mx?=
 =?utf-8?B?L1JSYlk4ME9zejFOa3NXK0NFdTFkZnUvb0h2UHJROVhaWWdBWUhsU3c4WlFQ?=
 =?utf-8?B?OStQbll4QThBVUtKb2tkeUNlbHVveVExb2VUcTFrcTJmRFlibCtsbXJmWUlK?=
 =?utf-8?B?bHBDTHNDNmVwSzRrS0E1Zis3a2Z3WmRVd0lMOUFGNmRRSnJzMnB6cS9OOWx2?=
 =?utf-8?B?MlVWdWtBSUVacWE3ZDBBemF1Qk1KVlhyeXRKdWx6cHhVUHhxNnBZeHhLVSt5?=
 =?utf-8?B?djdWaXlDblBNK0FWeEhkQ2M4U3hWU0tWN3dKY3Rlc3k1azV4ZHBIT05abVQw?=
 =?utf-8?Q?D5Ts=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc35ab7c-902c-40c3-8e00-08ddc395dde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 11:50:59.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fz2N10I0hnyFCZ2DLGWH9Nhl9Ufe2BylOrpQbDOETg1nypdM8YdC5vgF9hqSOUlV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDExLCAyMDI1IDg6MTMgUE0NCj4gVG86IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDcvMTFdIGRybS9hbWRncHU6IHZhbGlkYXRlIHVz
ZXJxJ3MgbGFzdCBmZW5jZSBwcmlvciB0bw0KPiBkZXN0cm95aW5nDQo+DQo+IE9uIDExLjA3LjI1
IDExOjM5LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBUaGUgdXNlcnEgcmVxdWlyZXMgdmFsaWRh
dGluZyBxdWV1ZSBzdGF0dXMgYmVmb3JlIGRlc3Ryb3lpbmcgaXQsIGlmDQo+ID4gdXNlciB0cmll
cyB0byBkZXN0cm95IGEgYnVzeSB1c2VycSBieSBJT0NUTCB0aGVuIHRoZSBkcml2ZXIgc2hvdWxk
DQo+ID4gcmVwb3J0IGFuIGVycm9yIGZvciB0aGlzIGlsbGVnYWwgdXNhZ2UuDQo+DQo+IENsZWFy
IE5BSywgZGVzdHJveWluZyBhIGJ1c3kgdXNlcnF1ZXVlIGlzIHBlcmZlY3RseSB2YWxpZCENClll
cywgdGhlIGZpcm13YXJlIHNob3VsZCBoYW5kbGUgc3VjaCBjYXNlIHNvbWV0aGluZyBsaWtlIGFz
IHByZWVtcHRpbmcgdGhlIHF1ZXVlLg0KSWYgd2UgZGlyZWN0bHkgdW5tYXAgYSBoYW5nIHF1ZXVl
IGFuZCBtYXkgZnVydGhlciBjYXVzZSB0aGUgTUVTIGZpcm13YXJlIGhhbmcgdXAsDQpzbywgZG8g
d2UgbmVlZCB0byBkZXRlY3QgdGhlIGhhbmcgdXNlcnEgaGVyZSBieSBjaGVja2luZyB0aGUgdXNl
cnEgZmVuY2Ugc3RhdHVzIGFuZCByZXNldCB0aGUgaGFuZyBxdWV1ZSBiZWZvcmUgZnVydGhlciBw
ZXJmb3JtcyB0aGUgdW5tYXAgcXVldWU/DQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5j
IHwgMTUgKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IDgxZmJiMDBiNmQ5MS4uYmNiZThkM2Y2NmVk
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMN
Cj4gPiBAQCAtMjgxLDcgKzI4MSw3IEBAIGFtZGdwdV91c2VycV9tYXBfaGVscGVyKHN0cnVjdCBh
bWRncHVfdXNlcnFfbWdyDQo+ICp1cV9tZ3IsDQo+ID4gICAgIHJldHVybiByOw0KPiA+ICB9DQo+
ID4NCj4gPiAtc3RhdGljIHZvaWQNCj4gPiArc3RhdGljIGludA0KPiA+ICBhbWRncHVfdXNlcnFf
d2FpdF9mb3JfbGFzdF9mZW5jZShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1
ZSAqcXVldWUpICB7IEBAIC0NCj4gMjkwLDEwICsyOTAsMTQgQEANCj4gPiBhbWRncHVfdXNlcnFf
d2FpdF9mb3JfbGFzdF9mZW5jZShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0KPiA+
DQo+ID4gICAgIGlmIChmICYmICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZikpIHsNCj4gPiAgICAg
ICAgICAgICByZXQgPSBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KGYsIHRydWUsIG1zZWNzX3RvX2pp
ZmZpZXMoMTAwKSk7DQo+ID4gLSAgICAgICAgICAgaWYgKHJldCA8PSAwKQ0KPiA+ICsgICAgICAg
ICAgIGlmIChyZXQgPD0gMCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgZHJtX2ZpbGVfZXJy
KHVxX21nci0+ZmlsZSwgIlRpbWVkIG91dCB3YWl0aW5nIGZvcg0KPiBmZW5jZT0lbGx1OiVsbHVc
biIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZi0+Y29udGV4dCwgZi0+
c2Vxbm8pOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4g
KyAgICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gMDsNCj4gPiAg
fQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkDQo+ID4gQEAgLTUwOSw3ICs1MTMsMTIgQEAgYW1kZ3B1
X3VzZXJxX2Rlc3Ryb3koc3RydWN0IGRybV9maWxlICpmaWxwLCBpbnQNCj4gcXVldWVfaWQpDQo+
ID4gICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZ1cV9tZ3ItPnVzZXJxX211dGV4KTsNCj4gPiAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgICAgfQ0KPiA+IC0gICBhbWRncHVfdXNl
cnFfd2FpdF9mb3JfbGFzdF9mZW5jZSh1cV9tZ3IsIHF1ZXVlKTsNCj4gPiArDQo+ID4gKyAgIGlm
IChhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFzdF9mZW5jZSh1cV9tZ3IsIHF1ZXVlKSkgew0KPiA+
ICsgICAgICAgICAgIGRybV93YXJuKGFkZXZfdG9fZHJtKHVxX21nci0+YWRldiksICJEb24ndCBk
ZXN0cm95IGEgYnVzeQ0KPiB1c2VycVxuIik7DQo+ID4gKyAgICAgICAgICAgLyogRm9yIHRoZSBm
ZW5jZSBzaWduYWwgdGltZW91dCBjYXNlLCBpdCByZXF1aXJlcyByZXNldHRpbmcgdGhlIGJ1c3kN
Cj4gcXVldWUuKi8NCj4gPiArICAgICAgICAgICByID0gLUVUSU1FRE9VVDsNCj4gPiArICAgfQ0K
PiA+DQo+ID4gICAgIC8qDQo+ID4gICAgICAqIEF0IHRoaXMgcG9pbnQgdGhlIHVzZXJxIG9iaiB2
YSBzaG91bGQgYmUgbWFwcGVkLA0KDQo=
