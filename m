Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679DFC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 09:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A3510E231;
	Mon, 19 Aug 2024 09:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x/xfXGMA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7151110E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XepchfN0UzQRgDC6yHFPqmUQcqFA+FTKo5lObdT4ggMtWFY9iLytsoCFvZ4XKMfnqh1cBOgGegUSTCYQdb1cK2zW06lZjIiSxy3Iroa37OZlbYgpBrIipqM26WM0hCw1giw5MXtxutT6ZUf+z2kBB9toG2wLPKlZUigr58wq7dXrenA2duOnhbXZEbv1ikVs9Kh7GuwqKNVVoRnXGE/friio289b2e5AjKLNr/C086O/xE5WobzS4UYuTAX4KMJ01c+/Cje/5Qz87EoSEpyHR4bu2O0hAJ+L1zCWOOMkFHIVBZzNbz5gIxONEu3rYgqqy9HaA0OQhxv70785fpLDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH/sW8RP8deKh2eUxOIVPIHUZeoFJ10d4LRHwnnE5kE=;
 b=XcKzlm5hSQnnFM2ln11uX8ipqgujvMCa9l7o3BRQ+uaPmAjGsETdeLbpSUvXYF0NY0ZbNHEByUJyUXFxuZLissax6O2+/VSIR9S354tnKpdPvglgU9sc8M5G6ecRAkYtRZ/7EMMJImIYsla09IMZGher8GbTZGJTGTaFvLh7n+slxlmdHgTPStuQsNibYAkqLT7No64Ecut6W7MJoW3EdMm6puMLq9PJ+vw+ok6FwV5Ch/TNft5aWqTHAt9qOfGS+WkJrVi4em3tlfppksN/xD4PncxTS2UemHbNotv6aMWPgYN8edTZJiNZqa/SPDdP/HsC52Xr1sG0sdOP3/Tbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH/sW8RP8deKh2eUxOIVPIHUZeoFJ10d4LRHwnnE5kE=;
 b=x/xfXGMAT7LPV+Zi4YIyH9O1MevWnF4roR12M0h3naoDhzvWnRbqAlb2Y1hAI2PSvubmNEP1KL8WFzKerZqJOs46zw5K7aG1DzsP360UY54MC1QbD71IXlDWU5zz64meU+xEwIBuR/zEhvVpwjJjL6dfxEDZhZa1m/bOL/OVVT0=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:30:21 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:30:20 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: skip printing vram_lost if needed
Thread-Topic: [PATCH 3/4] drm/amdgpu: skip printing vram_lost if needed
Thread-Index: AQHa77GiEZEn15VW40yjkAkOv+/ZI7Ip55qAgARtpfA=
Date: Mon, 19 Aug 2024 09:30:20 +0000
Message-ID: <SA1PR12MB7442D085F741588C05F9E435FE8C2@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
 <20240816075447.442983-4-Trigger.Huang@amd.com>
 <CADnq5_PqbSr=1bqkKL=ocwzWcyZGjDKiNBEp5HUuP477mC=aww@mail.gmail.com>
In-Reply-To: <CADnq5_PqbSr=1bqkKL=ocwzWcyZGjDKiNBEp5HUuP477mC=aww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6d93915b-1deb-4b43-8fe4-f517790afbb9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-19T09:29:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|SN7PR12MB7345:EE_
x-ms-office365-filtering-correlation-id: 3e899bd9-9f42-4f01-a41d-08dcc0318bb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Rld1TmZMNWMzbVZHR2lnQUNNUjZteHRsVXdGRU5rclh3S0ZMQXNOU3dCZDIv?=
 =?utf-8?B?RE1aaDJOVVc3RTBqQXZ4czJmbFpHZ3IvUUplSVJ4a2h2cHIzSGsrL3ZQT3RT?=
 =?utf-8?B?WnFpdFN6TExPQi9md2trbStrdmdzdldDeWlpNmREMzRxZVUycFFldWtZY0M1?=
 =?utf-8?B?SlEveXBNbExQM1FDVG1ReUpZdzJIRS9GQ0dBVll0MjU4SmlRVUVjOHAva2R1?=
 =?utf-8?B?di93Y1prbGxSaDMvd0FWTm9HZXdMNWRiL2ZBZnBqQ2F1Y2UzT29kNW5OQ0RY?=
 =?utf-8?B?TzQ0T0pYcDBRbXJ1TjJRY1Mva21TRHU5dmw0KzhybkFoNWpzZ3RsRVNuUDhp?=
 =?utf-8?B?Zk5CL1A2QTU3V0piMHQ4S1FFSWlNVFBKaHJKTnprV0pQSG1xSjhubHZMd09P?=
 =?utf-8?B?VVJ2NWJ5SFhWWlVWTll1Tm9EbTVUTkpWR3NrelFpdGR4M2RXSU1DYUxEV29a?=
 =?utf-8?B?SnFTaytSdE1GSEl2alpBZG8vZGJwbUNEeS85RE5QMWQwenZoV3FyS3lGcTl3?=
 =?utf-8?B?WHNEUk9SdVdHV00zWDJCZVg3UGFKSzdUd0IwVENkZTJwTmFZZEJFUHJqdHJh?=
 =?utf-8?B?TWV5RDlwK2N4NkFBSG51eFpQc2VGODFFME53Q2gycE8xYzBqQzlHQjQ0cy9t?=
 =?utf-8?B?RnY5M05JSEhwa0dqajFyNzFiZFh0a3pQcGxCakE3Y0dqWFFpdGJWRzdyQkRY?=
 =?utf-8?B?Y0FLRlNrUnZqOExwS0hpNzBjN2p5ODBIUDlxdXdpQnlPU2puN2loOWRiV0dM?=
 =?utf-8?B?N1JSbCtDa0hIUE44YTJYMW9ERXZSazA0UEM5NkcybmVwL2ZkSGNCYXBZN1dt?=
 =?utf-8?B?S3lJNXVUY2gvVHJ1dUJQZDY3N2F1bk1ZUzRSeER0eWR6VDdSb0wwdUROYTdm?=
 =?utf-8?B?VjVVdDUzVVpTZkJ2Nk1kWklHR2xlODFkZ1VscjJoNnMvZ3RlaTlNWkMxc1Ny?=
 =?utf-8?B?Szl0VjJrM0d4TG1BNkhEa01EaHVRTXNDR2xtbXdDU0JwWnlONWRUODJqWUJR?=
 =?utf-8?B?bGtGUVg4UmhZSGNVV2VrWVhXNWdNamdDQ3piSnNrNHZXakxGNXZnK3hzWGVz?=
 =?utf-8?B?SXVBNHBodHhoVnZ4dzRGWWxkQlhZQjlwcHBpMDhZa3dhMUNKN1dwTmg5cG1l?=
 =?utf-8?B?Z0ZSNlNNSHV0WmtuUjJTcTY1S3JHT1JJZklzMk45QXlXTTVDTmRWK1R0dTEw?=
 =?utf-8?B?NHAwVGlOT3NjSnVyM2pTT2dUekFoelVTZmh2L1JMZWc4WUxvc2NmVUdkTGhZ?=
 =?utf-8?B?ZzNONHdpQnlSZk43eTZXajVoZTlJbTRKK0NQeXhqQkdmNUgvdzdXeU95dzB3?=
 =?utf-8?B?MDNhSW1qQ0Q3OUk2UDhSUlM5SkV2V3U0RndkQ0RTWlZla2puQzB6aFk5NTlq?=
 =?utf-8?B?ZUplKzVRZVFxSjZSeGxWY2VzRi9OVVYrUm0yVCtIdXAzY2VmWjk1TDZIZ0Vn?=
 =?utf-8?B?Zzllc0M3Q05LNEFDWW5NUDN2S2lXdlNjSlRDM090MnpNbnMvV1ArSGpkZjBs?=
 =?utf-8?B?ZVlmbStTUFV5NnBGam41ZStVNDduMmk5LzROT2hzY0Ntb3ZNVHlhS05JL2I2?=
 =?utf-8?B?b1lzZDNZaXNFYmkwT21OSmZ6K0tzMi9mN3NTQUswR1Jjc0pDQVpoRGxJdFNI?=
 =?utf-8?B?QnVhWGtPUzBlOFdqRU13RlB4UGVwR2hQOHIzZGgxdXZ4WDFKVFF2YmhUeWRl?=
 =?utf-8?B?STg2dHQvM29EM0xRaHpSaXhUYjJhQmtSS3RtOVFoanV3VTUzRTUxL0M4S3Bt?=
 =?utf-8?B?YkExclBySGVzUDZQTCtwK1VSNHIyM2IzcmliTzk4SVVoanZaVVVjNzN0RUxp?=
 =?utf-8?B?alNWRnMyUUZ3KzlqWGcydEhNYnBRWlRlTTFjditGaUsxbXZqdkJ5bEtabG1K?=
 =?utf-8?B?V2srNkhnSjQxQkNIbktUVUx5YTE5NFQ3dlhMenhabldQVnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1VuVjI2UXFOMTI1ekNYTEZjT0orSVNodmp4cUJqbFA4QjE3N1pnSDdPdTdS?=
 =?utf-8?B?bkVRY05WUHozczVsN2JVRVlzQUFlQmo3RnhJQXc1dmh3SXcyK2FNWmM3Q2RN?=
 =?utf-8?B?UjJ3ZFpBL0Vva1NKMWRIN0xOWUZGdG4xYi81SGd6R0F2UkJxQWZVQ1hEV2xR?=
 =?utf-8?B?ZXJhNWFKeDREVUQ2TEh2YnUrQzJibmVyYVBDZjBoYXM5WjNpU29DU2ZMcnNa?=
 =?utf-8?B?SlNtczhaOUNUSGtnN1I0MlNjaldhL1dqeGJ5NE9wdTFPMWZKV3dSeC95QTFl?=
 =?utf-8?B?aTNyV05RcWVNUm91S2YrMW5vZjBCVlhIQ3NuS05DcDZWMDZtVFFhZVBUMjhN?=
 =?utf-8?B?bWtFZFl4N0ZFZC8zMWRpTzVZam5qeElKaFdtN0gvRXhCN1ZMdW1ydDF6RkNF?=
 =?utf-8?B?ZHNlWjlzN0hVSWYwVDlUemM4bDgwZWVoMW93R3pIcnpVdHhJenBvT1h6ODNF?=
 =?utf-8?B?bTVOb1NYQWxFeWI2ekVBcFl2VG5CcHJBM0c5bUFpTmM5ZEZ6WFh0WkE5azZu?=
 =?utf-8?B?VWljZFVxZDRnL2FncHB0YS9IWDgxUVFqSEg2UTh5dTMwcHROcHhhaEl1d2NK?=
 =?utf-8?B?NVlxMjV5bjVSejU4WlF2M05DUmNkZmNrK2gvT1VpN3dBZTAwMVVKYUpINk5V?=
 =?utf-8?B?T29qTkhkWmxyRU5WNjRTdmszeGY5czZPcE9JL20xL0k0ZjEzY2VJWkNQRjky?=
 =?utf-8?B?anAySllERmFkTEIraWhRMDhBUm5aNUVvZFZtQ2hDT0pyWHgzR0NIK0Z4d0pU?=
 =?utf-8?B?dlJJRXN0aEloNlh1cWUyZXZXdUJtZWU1cG5OTDNnTmVRVEFGNzZxYXRZU2ZL?=
 =?utf-8?B?cnN4SjNKazJxQ3FyN2MwRExsTWNsaXRqaXNuM3pnd1c1d2FLUjBqeHVvdjFG?=
 =?utf-8?B?MlFVUWl1UVNIV2NqeDBpZUlsb1dONy9WWUJZRWdrQlZIT0tqNEFuMVhpeGNl?=
 =?utf-8?B?UDR4WnBFSU1UWE4wb3FHNHFkL2JrQ3NNMmJTaDVqUmVDSUM0MXF0V054aE5h?=
 =?utf-8?B?ZlZ3TUZTQWtyNEJ6dmllcFJXeE05WFhITFFIM3F3TzVvK2l5NXBRKzMybUhT?=
 =?utf-8?B?MHpTSWE2RXZNcmNjUEE3Y1VqZTAwYVRRTjI4ZEl4NWdmbmdGV3FnaXB0dkNh?=
 =?utf-8?B?RlhiWUdpUk80eGJYSzlxY1lQTnU3VDJtTTkzSS9xbEl1cEhVUmM4UnoxNFln?=
 =?utf-8?B?YWlIV05jRWpqS1hxTWJsY0h6VUU0c1RTUm16TEgvUDh6UU81SUZraDZ2bm1M?=
 =?utf-8?B?RmJuMWg3YTVuOWx3RDN2TFhnY0pMK0hJUDNEbXF6N0ZGQW5Xc0djWmR0ckN1?=
 =?utf-8?B?dDVaY1owTzY1WHhQYTlEbTd2M212SkF2bXdBOXB1QVYwZmVidjcrV3I2b3c4?=
 =?utf-8?B?bndNanRic3g2Uklta1JSRzEwaVdPeUJTL3ErZnEyeWlWbEdlbXVFem8vandE?=
 =?utf-8?B?OFZWVWNtbDNFL1l6aGEyR1pzaE9JWW9lS0V1eEZUamZLTHJWWElMUnNxWGFM?=
 =?utf-8?B?VlBNb09Sbkk4N21NYWxFaTY2djU1VjhjUmpMeHIvbk1DSjNCdkJDNHV6Rjh1?=
 =?utf-8?B?dElkVW5JZmtxeWUxMEloM3lUNlU3dDZhbHliUGhabk1sRkxscmVSWWU2K2pn?=
 =?utf-8?B?MWNJYUUzMEJOaE1RTlpPNGd4L29jZ3pzY3ZjQ0pzYlRwSU96TnE4Znc2YTRK?=
 =?utf-8?B?eTBEWjlqZUNqRmRMeGNVUnViKzZQZXp5WHJNMjl5Vm1SaFV6cm5JcUhzTkVX?=
 =?utf-8?B?WkRrOHN2blZSblZaTGhmT3NYbkFpMTVta3ErTUpoYWlRSXdORDZHemZrbnpo?=
 =?utf-8?B?ZnFLSUFOT1NEVmZaQmVNdmtza0x2NjFTS1Y0em5LVmlReFc1M1Y0K25CWXdI?=
 =?utf-8?B?L255OGh1SHQ5b3hZL3BzWEcwdDNuV1NSVkZPNyt6UTVQL0hJTG9qdlo1UDhl?=
 =?utf-8?B?MmFIelVoanMxSGJNUVNxamdFazc4cUFqSGE4bDdYUkZHY1BoUFZFVGtzUDVl?=
 =?utf-8?B?OGYvZThhbTFKL1Z5SnNyZmpFenZiTzA2R3FSdFA2U09Sb0VBSXlXa0pNMEhn?=
 =?utf-8?B?MEJDd0xaaXBRbVlNa2xsYithSm5VMDcvMW5Nc0gzTDhwMHNaZWxibi9WSXRS?=
 =?utf-8?Q?+ryA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e899bd9-9f42-4f01-a41d-08dcc0318bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:30:20.9071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x34HthSVZ+Q07EoptnGxD8EmenjiNpDxxWdMRqXxtdp9mQzpn/uLciEcneWgKblkEgNsYRClzcEZHuFWcpV2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgOTo1
MiBQTQ0KPiBUbzogSHVhbmcsIFRyaWdnZXIgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4NCj4gQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0
cmlAYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRdIGRybS9hbWRncHU6IHNraXAgcHJpbnRp
bmcgdnJhbV9sb3N0IGlmIG5lZWRlZA0KPg0KPiBPbiBGcmksIEF1ZyAxNiwgMjAyNCBhdCAzOjU1
4oCvQU0gPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBUcmln
Z2VyIEh1YW5nIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+DQo+ID4NCj4gPiBUaGUgdm0gbG9zdCBz
dGF0dXMgY2FuIG9ubHkgYmUgb2J0YWluZWQgYWZ0ZXIgYSBHUFUgcmVzZXQgb2NjdXJzLCBidXQN
Cj4gPiBzb21ldGltZXMgYSBkZXYgY29yZSBkdW1wIGNhbiBiZSBoYXBwZW5lZCBiZWZvcmUgR1BV
IHJlc2V0LiBTbyBhIG5ldw0KPiA+IGFyZ3VtZW50IGlzIGFkZGVkIHRvIHRlbGwgdGhlIGRldiBj
b3JlIGR1bXAgaW1wbGVtZW50YXRpb24gd2hldGhlciB0bw0KPiA+IHNraXAgcHJpbnRpbmcgdGhl
IHZyYW1fbG9zdCBzdGF0dXMgaW4gdGhlIGR1bXAuDQo+ID4gQW5kIHRoaXMgcGF0Y2ggaXMgYWxz
byB0cnlpbmcgdG8gZGVjb3VwbGUgdGhlIGNvcmUgZHVtcCBmdW5jdGlvbiBmcm9tDQo+ID4gdGhl
IEdQVSByZXNldCBmdW5jdGlvbiwgYnkgcmVwbGFjaW5nIHRoZSBhcmd1bWVudCBhbWRncHVfcmVz
ZXRfY29udGV4dA0KPiA+IHdpdGggYW1kZ3B1X2pvYiB0byBzcGVjaWZ5IHRoZSBjb250ZXh0IGZv
ciBjb3JlIGR1bXAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmlnZ2VyIEh1YW5nIDxUcmln
Z2VyLkh1YW5nQGFtZC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rldl9jb3JlZHVtcC5jICB8IDE5DQo+ID4gKysrKysrKysrKy0tLS0tLS0tLSAg
Li4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2X2NvcmVkdW1wLmgNCj4gfCAgNiArKyst
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwg
IDIgKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2X2NvcmVkdW1wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZfY29yZWR1bXAuYw0KPiA+IGluZGV4IGNmMmI0ZGQ0ZDg2NS4uYTg2MGY1MmQ4YmIw
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZf
Y29yZWR1bXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZfY29yZWR1bXAuYw0KPiA+IEBAIC0yOCw4ICsyOCw5IEBADQo+ID4gICNpbmNsdWRlICJhdG9t
LmgiDQo+ID4NCj4gPiAgI2lmbmRlZiBDT05GSUdfREVWX0NPUkVEVU1QDQo+ID4gLXZvaWQgYW1k
Z3B1X2NvcmVkdW1wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIHZyYW1fbG9zdCwN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2NvbnRleHQgKnJl
c2V0X2NvbnRleHQpDQo+ID4gK3ZvaWQgYW1kZ3B1X2NvcmVkdW1wKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBib29sDQo+IHNraXBfdnJhbV9jaGVjaywNCj4gPiArICAgICAgICAgICAgICAg
ICAgICBib29sIHZyYW1fbG9zdCwgc3RydWN0IGFtZGdwdV9qb2IgKmpvYikNCj4gPiArDQo+ID4g
IHsNCj4gPiAgfQ0KPiA+ICAjZWxzZQ0KPiA+IEBAIC0zMTUsNyArMzE2LDcgQEAgYW1kZ3B1X2Rl
dmNvcmVkdW1wX3JlYWQoY2hhciAqYnVmZmVyLCBsb2ZmX3QNCj4gb2Zmc2V0LCBzaXplX3QgY291
bnQsDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAg
ICAgaWYgKGNvcmVkdW1wLT5yZXNldF92cmFtX2xvc3QpDQo+ID4gKyAgICAgICBpZiAoIShjb3Jl
ZHVtcC0+c2tpcF92cmFtX2NoZWNrKSAmJiBjb3JlZHVtcC0+cmVzZXRfdnJhbV9sb3N0KQ0KPiA+
ICAgICAgICAgICAgICAgICBkcm1fcHJpbnRmKCZwLCAiVlJBTSBpcyBsb3N0IGR1ZSB0byBHUFUg
cmVzZXQhXG4iKTsNCj4NCj4gWW91IG1pZ2h0IHdhbnQgdG8gc2F5IHNvbWV0aGluZyBsaWtlOg0K
PiBkcm1fcHJpbnRmKCZwLCAiVlJBTSBsb3N0IHN0YXR1cyBza2lwcGVkXG4iKTsgaW4gdGhlIHNr
aXAgY2FzZSBzbyB3ZSBrbm93DQo+IHRoYXQgd2Ugc2tpcHBlZCBpdCBzbyB1c2VycyBkb24ndCBh
c3N1bWUgaXQgd2Fzbid0IGxvc3QuDQoNClNvdW5kcyBnb29kLCBJIHdpbGwgYWRkIGl0Lg0KDQpS
ZWdhcmRzcy4NClRyaWdnZXINCg0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiAgICAgICAgIHJldHVy
biBjb3VudCAtIGl0ZXIucmVtYWluOw0KPiA+IEBAIC0zMjYsMTIgKzMyNywxMSBAQCBzdGF0aWMg
dm9pZCBhbWRncHVfZGV2Y29yZWR1bXBfZnJlZSh2b2lkDQo+ICpkYXRhKQ0KPiA+ICAgICAgICAg
a2ZyZWUoZGF0YSk7DQo+ID4gIH0NCj4gPg0KPiA+IC12b2lkIGFtZGdwdV9jb3JlZHVtcChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCB2cmFtX2xvc3QsDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGFtZGdwdV9yZXNldF9jb250ZXh0ICpyZXNldF9jb250ZXh0KQ0KPiA+
ICt2b2lkIGFtZGdwdV9jb3JlZHVtcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbA0K
PiBza2lwX3ZyYW1fY2hlY2ssDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgYm9vbCB2cmFtX2xv
c3QsIHN0cnVjdCBhbWRncHVfam9iICpqb2IpDQo+ID4gIHsNCj4gPiAtICAgICAgIHN0cnVjdCBh
bWRncHVfY29yZWR1bXBfaW5mbyAqY29yZWR1bXA7DQo+ID4gICAgICAgICBzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2ID0gYWRldl90b19kcm0oYWRldik7DQo+ID4gLSAgICAgICBzdHJ1Y3QgYW1kZ3B1
X2pvYiAqam9iID0gcmVzZXRfY29udGV4dC0+am9iOw0KPiA+ICsgICAgICAgc3RydWN0IGFtZGdw
dV9jb3JlZHVtcF9pbmZvICpjb3JlZHVtcDsNCj4gPiAgICAgICAgIHN0cnVjdCBkcm1fc2NoZWRf
am9iICpzX2pvYjsNCj4gPg0KPiA+ICAgICAgICAgY29yZWR1bXAgPSBremFsbG9jKHNpemVvZigq
Y29yZWR1bXApLCBHRlBfTk9XQUlUKTsgQEAgLTM0MSwxMQ0KPiA+ICszNDEsMTIgQEAgdm9pZCBh
bWRncHVfY29yZWR1bXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wNCj4gdnJhbV9s
b3N0LA0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICB9DQo+ID4NCj4g
PiArICAgICAgIGNvcmVkdW1wLT5za2lwX3ZyYW1fY2hlY2sgPSBza2lwX3ZyYW1fY2hlY2s7DQo+
ID4gICAgICAgICBjb3JlZHVtcC0+cmVzZXRfdnJhbV9sb3N0ID0gdnJhbV9sb3N0Ow0KPiA+DQo+
ID4gLSAgICAgICBpZiAocmVzZXRfY29udGV4dC0+am9iICYmIHJlc2V0X2NvbnRleHQtPmpvYi0+
dm0pIHsNCj4gPiArICAgICAgIGlmIChqb2IgJiYgam9iLT52bSkgew0KPiA+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbyAqdGk7DQo+ID4gLSAgICAgICAgICAgICAgIHN0
cnVjdCBhbWRncHVfdm0gKnZtID0gcmVzZXRfY29udGV4dC0+am9iLT52bTsNCj4gPiArICAgICAg
ICAgICAgICAgc3RydWN0IGFtZGdwdV92bSAqdm0gPSBqb2ItPnZtOw0KPiA+DQo+ID4gICAgICAg
ICAgICAgICAgIHRpID0gYW1kZ3B1X3ZtX2dldF90YXNrX2luZm9fdm0odm0pOw0KPiA+ICAgICAg
ICAgICAgICAgICBpZiAodGkpIHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rldl9jb3JlZHVtcC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2X2NvcmVkdW1wLmgNCj4gPiBpbmRleCA1MjQ1OTUxMmNiMmIuLmM0
ZTUyMmU0OTI1MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2X2NvcmVkdW1wLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2X2NvcmVkdW1wLmgNCj4gPiBAQCAtMjYsNyArMjYsNiBAQA0KPiA+ICAjZGVm
aW5lIF9fQU1ER1BVX0RFVl9DT1JFRFVNUF9IX18NCj4gPg0KPiA+ICAjaW5jbHVkZSAiYW1kZ3B1
LmgiDQo+ID4gLSNpbmNsdWRlICJhbWRncHVfcmVzZXQuaCINCj4gPg0KPiA+ICAjaWZkZWYgQ09O
RklHX0RFVl9DT1JFRFVNUA0KPiA+DQo+ID4gQEAgLTM2LDEyICszNSwxMyBAQCBzdHJ1Y3QgYW1k
Z3B1X2NvcmVkdW1wX2luZm8gew0KPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgICAg
ICAgICAgICAqYWRldjsNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfdGFza19pbmZvICAgICAg
ICAgcmVzZXRfdGFza19pbmZvOw0KPiA+ICAgICAgICAgc3RydWN0IHRpbWVzcGVjNjQgICAgICAg
ICAgICAgICByZXNldF90aW1lOw0KPiA+ICsgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBza2lwX3ZyYW1fY2hlY2s7DQo+ID4gICAgICAgICBib29sICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlc2V0X3ZyYW1fbG9zdDsNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVf
cmluZyAgICAgICAgICAgICAgKnJpbmc7DQo+ID4gIH07DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4g
LXZvaWQgYW1kZ3B1X2NvcmVkdW1wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIHZy
YW1fbG9zdCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2Nv
bnRleHQgKnJlc2V0X2NvbnRleHQpOw0KPiA+ICt2b2lkIGFtZGdwdV9jb3JlZHVtcChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbA0KPiBza2lwX3ZyYW1fY2hlY2ssDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgYm9vbCB2cmFtX2xvc3QsIHN0cnVjdCBhbWRncHVfam9iICpqb2IpOw0K
PiA+DQo+ID4gICNlbmRpZg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPiA+IGluZGV4IDk4ODVkMDYwNmIwYS4uODI1Y2M2MmNkNzVkIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+
IEBAIC01NDQ1LDcgKzU0NDUsNyBAQCBpbnQgYW1kZ3B1X2RvX2FzaWNfcmVzZXQoc3RydWN0IGxp
c3RfaGVhZA0KPiAqZGV2aWNlX2xpc3RfaGFuZGxlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdnJhbV9sb3N0ID0NCj4gPiBhbWRncHVfZGV2aWNlX2NoZWNrX3ZyYW1fbG9z
dCh0bXBfYWRldik7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChhbWRncHVfZ3B1X2NvcmVkdW1wICYmDQo+ICghdGVzdF9iaXQoQU1ER1BVX1NLSVBfQ09SRURV
TVAsICZyZXNldF9jb250ZXh0LT5mbGFncykpKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhbWRncHVfY29yZWR1bXAodG1wX2FkZXYsIHZyYW1fbG9zdCwNCj4g
cmVzZXRfY29udGV4dCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZGdwdV9jb3JlZHVtcCh0bXBfYWRldiwNCj4gPiArIGZhbHNlLCB2cmFtX2xvc3QsIHJl
c2V0X2NvbnRleHQtPmpvYik7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICh2cmFtX2xvc3QpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRFJNX0lORk8oIlZSQU0gaXMgbG9zdCBkdWUgdG8NCj4gPiBHUFUgcmVzZXQhXG4i
KTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
