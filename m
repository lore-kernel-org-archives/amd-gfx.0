Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33A4C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C40410EA95;
	Thu, 23 Mar 2023 13:49:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7595110EA9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRqE3eyR4mVcgr5+aumcmT3Cxt030Lgt2Ewb8LOz70Q3A5hFP85cSXffCCcC6SLW8XhzYuPYR4YbWEF1fc2k6iaRJ80OdnHXpObrDgEEasZdXXKiNcErObAXuk6RLmD3ZoG211S/+Hufetd55Wo6tVVyLWRdOOKs6uJP1CqZDEkBb6qynqNlNVqoGyu/SdSboppHeiiMxetESulzPohiLxDcNcEOX1QYFtZKdKocPmD6gXZ6y55bB+kfN21txmMAmy8tvw6IQ9Yy1Eeh7lfwQqCwHZHZKw8syC6G8+MLiMhzBAi0+XrOtuYp4u3y1lAt07QaNeQu4csvijqbo79rRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozeijET77CmXyMu5OS6DxLUnR+3BMFKxWRsuXTYQ+0Q=;
 b=I+NglqRJ5TEwdzDYw960gcrBhyy/xpGH8Zm0wTa09X3ij381O2p3lc/tUExZlApH/YGPhJFRzUhmxABMvKzXv1fN0o0BcjoH0uC+5MzBc6gbC3565r0U9ATRzDPJ2Qfz8ZjDsik5C//9/9xkExZpLk+cZytfntMMQAGfx2t1jAXHT6rFP4VQ1FIkti0YW8jOpgE8vIBdimKsaJcS1IHAZzIkSlVtffrBeGHc7VPnvaRyKvW+ehPUKEUyCBGx/pvuScoJ6IPbZkxsQtI5MAXbyopmPu4k8m5yhpCi966IfiUhYr7kRzeoy1b5tJhQ8XBtXyG6DfBRrMf5eIIBsc48fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozeijET77CmXyMu5OS6DxLUnR+3BMFKxWRsuXTYQ+0Q=;
 b=N7GJr7gbtKQhhOjSg15lzCfB3a76kmvJbKB92oj/HZm1Ccd4izmaWKklhjHtnL9bZq8Qr9GO3+V3GsxG6yzOoJZrv8KbfMgVo9HpFsAPNEzb/beFQ7qJnOcZzgGMlZ2hlmKWR/6AFTL0y5+3Ri1BSeJTaTRGkAGSjxD7hTbhh6g=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 13:49:18 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:49:18 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXX+20w+FZISrM02v7ekDk7+DS68IW/oAgAAEXYCAAAEVcA==
Date: Thu, 23 Mar 2023 13:49:17 +0000
Message-ID: <MN2PR12MB41281C02B10AF01CF262F6B390879@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
 <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
 <BN9PR12MB5257B39B2E0E3365A9DB3EBCFC879@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257B39B2E0E3365A9DB3EBCFC879@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T13:49:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a008da6f-bb86-4240-910f-f4a1be7a57aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SA1PR12MB8742:EE_
x-ms-office365-filtering-correlation-id: a7ce1a67-2537-4dd2-1166-08db2ba565c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rBBzeOw+/7+Bx3EVxyKaDCS4sQCbV2ZRlUTFXH9vWKx7VlBwRvnXtYjhRLw5FSoyjZZmSO95RhZtd4iNNcsJ9S1gC+KUn1hWD7kZn4VOA5g4bHrteL+ZRZT3C5aWXwkf39ggj2q6Q6dldS0q1AXAlpbaC41oBVJ9nhhTKyUqaga3uRG0q3UDORMxh4bcyBrwABz70aN1ADW1ckLw2i8MDbhw00tRiwHaCqOgZV/uH5KZ/7Xr0WrDju9wwuvNekv4pN4Thw+TSrSPuJIvmdiD1CXo7tZ0suOc4w517xJOCRjU3mImI4dQWBQ3Ckahd3/Q4jCNEVe2B4wS9bbn1Qn5IjfewiCyHuWQXbyFJzh0MNdFov2O2/eG10TFmyB7IDy84ndk9LQDF9UvmeNunm9LjawaVPfZAGdD77l0f3H3HIaAyauLU+3zT9vpjqJgzSTLJeK6xcPWPJselkZR9UAHoRZyVsWRNxnTWPyooDKzEAHjFU9uwBw2s9iqQhAZwRjBjXDfblCTBViA+UTjwVBwYW/Dy55DlGceVeKPWZhVuQxhc3Bb8L+5tO18Nn4/qKorQ7xyrnOOnpHKdZDGEPIY1Q8N0H5FDge41G8POq69CdtBp/+ZGddRiDzINc125baIYhqHQrA+Z6gTA1t+muUSCvJkTJHjEe8kKjelyEtx7UGwLEqrjA0v7LRdpORXDrtJscvYSLuhR7ldCRIuXHQR1DKHvk45ZE2QIeexHe3YDA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(41300700001)(66446008)(52536014)(5660300002)(8676002)(4326008)(66476007)(2906002)(38070700005)(64756008)(921005)(33656002)(86362001)(38100700002)(122000001)(71200400001)(7696005)(26005)(76116006)(110136005)(478600001)(6636002)(316002)(8936002)(66556008)(55016003)(6506007)(66574015)(83380400001)(66946007)(53546011)(186003)(9686003)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S011TDV2M3NzbzF2bk42OXR1eGtYS3ZCLzlKd01SKzgxQ3g1UXJ6NWhCUlhQ?=
 =?utf-8?B?dU5ZTFIrUGdPTXdRWUNVNVN4cjBNUXFvWUhhU212OXF4Y0hmMVdRbzY1KzUv?=
 =?utf-8?B?enBTUUw3YkZlT1N2QzVFNWQwV1c2ZWNuL2h0Uy9jbDlGNjNGY0htVi9MZCtV?=
 =?utf-8?B?KzBLaEVYaDdXSTN4V1VRWmY0SE8zbWkyV2pTV0FQeEZVblVSaUtmMjZTakdu?=
 =?utf-8?B?VUsrd0hteW5WUVp5WkJoa09SMUREb1BLQTY5anpPczZtMU9Bb1FNODliNlND?=
 =?utf-8?B?RGovRjJMMEMrL2ZFSEZtSW93MUU5M1ZxMHgrVU4rcTA5MW1hRXZ5VjU3VEs2?=
 =?utf-8?B?Qk1zR2xLVTI0d01STjhlUklRWnNvSll4TURDcHVPNUdmR2d4WUg0Vnp0ekF3?=
 =?utf-8?B?b1lyZXlaeE1YZytwU0VoQWZ0eWlQcGNwWlNrNExUZi84RTIyOFRCWEcvbUs3?=
 =?utf-8?B?cFVXVzQ1a2hVeGZ1eUhjN0o0MjBPTFF0dzZuVnlpV2FvSkNFMXRidlFQSEwx?=
 =?utf-8?B?WndPR0c4UlRlQmh0NjE5c3NNN0JaRGxaTjJ2Z29UR3dMbkZQWk1nbG1yRjd0?=
 =?utf-8?B?NWxhSHo4bUs0NUJCczFONko4dkVrVU45Q25INFduQWV1MkdJSWd1SWUvRFRt?=
 =?utf-8?B?bkFtWklFZTFzZjI5amFtOEh1aXBXU1VYWjhnS1h0YXVWUUpOU0xQaEtGZFdI?=
 =?utf-8?B?TGhDN1grUVl4U3hUZzRQYi9xd0FMdzV4d24yVmFTSlZaY3F5ek15RmtBY3RF?=
 =?utf-8?B?bzh1bnhGMFNrVFQvcDYvRVhpQ2VuaUZINjBnL2pWcFFHbDBEYzV6NTRkd0xB?=
 =?utf-8?B?MDk5ajJ0NzRheDk5U2FZejBiOXFPU3JRQ3NvMVNoY2NtL1VueHUyaHJsQWsr?=
 =?utf-8?B?cmluWFR5aW5hUlUycCtvS1cyQWZJb0xPVzJCejdZc3hPVllGWjZUZXRjU2ov?=
 =?utf-8?B?Y2NvNi8zMllDZFlpL2xKWGhpcUdyUHNNMHgrcSt6bysyd2NldGhQcEJ1dFcx?=
 =?utf-8?B?L1FVWmlvQ3NiYS9GTEtlZnRiNWx4REoxcHFiSlVMRmlpTGhYQUVuN3Nrd0Fl?=
 =?utf-8?B?VXp2Vm1FNGovUjEzWllQZUYydXpyVTF6M2EwY3YzcWVjem5UdXpyTDdYVHJQ?=
 =?utf-8?B?eEt0eGoybkRvY1cvTEw1bS9Oekl0cnhxdFVSN1dtdVlkTzZEWWFabnMxVTVX?=
 =?utf-8?B?Y25oNjZ3Rmd1emEzdkpQMEFRRjlQRVljc1hkY25HOTk2ZEw0MDlmZ1NwRXh1?=
 =?utf-8?B?M3hFNDNpVmVBRXFsSTNXcjJ2YlFiN2FDWjdHN2xkYVk5aC9wYmY0cWJ5UDhL?=
 =?utf-8?B?Z0RhY0dKcmhQWTVTV29aOCtDa1VUeWRMVEs2dVJZL2gxR0FMZFlEci82clZ4?=
 =?utf-8?B?dFFaaUowSThQOC9PQkpycU1Gb3dIVmU4dTh3Qm1TOWdKM2hGT3ZDZStIVVFz?=
 =?utf-8?B?Mm03UVlZc0puK2tYcFNELzUwbURMd2IwcGs2elhuRy90TVpJZHFQZ3F2aG11?=
 =?utf-8?B?SGVBZFNodnVWdXBtTWI2ejBnVmxUZ2tkUVVIN0VXRzlOaDVGQktqNE9kWkZP?=
 =?utf-8?B?RGtNUDdiaDdsbzhCMUllbllnSytmSElGMDh6UHk2L2NrMXNFNmpiZURrQito?=
 =?utf-8?B?QkpVYjMralFSTThKdXpFRG0xZ3p3MXRQRTlUUXB3NVFTMXAwaHVzKzJrWEM5?=
 =?utf-8?B?dmNVRG11SDdIY3ZSRUI5V2d4SkYwZlRac3NhVlhiQzRkc0FNNkhWK0tNRDFZ?=
 =?utf-8?B?bm84SkFyc3ExMndIZDl0UzRnYlV4Q3lQS3dtWnBWSDBUSi9FdkNNdVU5SU5L?=
 =?utf-8?B?OHFhazRzK0crb2l5Zmh0QzVzaDlRU09SNWtNTFhCSFpQSkRQZ0k5Ri85NUNa?=
 =?utf-8?B?S1NsRGtBYUkzK0g2Nm85ai9XUFdqTHRGT25RL1J4NTBRVyt3UjQ5NU5YRXFQ?=
 =?utf-8?B?cHQ3ZVQ0QitpYWV2c1ZucmJsc3hzYTkxK1lvMTU5VTNORldBckRuaUo0a3pj?=
 =?utf-8?B?NmpiMXlKaDYxUGExWCtzVnBZd08vUW1CaEdZZFdxamVUbUkxaUEyNVdvby9t?=
 =?utf-8?B?c2VkdWRMZmtLTHFUU0FmZldkbm1oTVpvZU9WYWFReW1rVnZIK0V1aDVUQmZD?=
 =?utf-8?Q?5Wy4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ce1a67-2537-4dd2-1166-08db2ba565c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 13:49:17.9625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9wUATd0nOQgcl8UGORZnW3v0vq1VgPuT7ofEmaMgDmwZAWo5EpMA5Tmrw4Ep8JLBwvHYaUqGNcTNK8arBgL2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCBIYXdraW5n
ISwgbXVjaCBhcHByZWNpYXRlIGZvciB5b3VyIGhlbHAgaW4gcmV2aWV3aW5nIQ0KDQpCZXN0IFJl
Z2FyZHMsDQpTcmluaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmhhbmcs
IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgTWFyY2gg
MjMsIDIwMjMgNzoxNSBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+OyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFt
ZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBM
aW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBUdWlrb3YsIEx1
YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IEZpeCBsb2dpYyBidWcg
aW4gZmF0YWwgZXJyb3IgaGFuZGxpbmcNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVy
YWxdDQoNCkdvb2QgY2F0Y2guIFRoaXMgaXMgYSB0eXBvDQoNClRoZSBjaGFuZ2UgaXMNCg0KUmV2
aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVnYXJk
cywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogVGh1cnNkYXksIE1hcmNo
IDIzLCAyMDIzIDIxOjI5DQpUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsg
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFR1aWtvdiwgTHViZW4gPEx1
YmVuLlR1aWtvdkBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogRml4IGxvZ2ljIGJ1ZyBpbiBmYXRh
bCBlcnJvciBoYW5kbGluZw0KDQpBbSAyMy4wMy4yMyB1bSAxMzowNCBzY2hyaWViIFNyaW5pdmFz
YW4gU2hhbm11Z2FtOg0KPiBDQyAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMubw0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmM6MjU2Nzoy
ODogZXJyb3I6IGJpdHdpc2Ugb3Igd2l0aCBub24temVybyB2YWx1ZSBhbHdheXMgZXZhbHVhdGVz
IHRvIHRydWUgWy1XZXJyb3IsLVd0YXV0b2xvZ2ljYWwtYml0d2lzZS1jb21wYXJlXQ0KPiAgICAg
ICAgICAgICAgICBpZiAoYWRldi0+cmFzX2h3X2VuYWJsZWQgfCBBTURHUFVfUkFTX0JMT0NLX19E
RikNCj4gICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fl5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4NCj4NCj4gUHJlc3VtYWJseSB0aGUgYXV0aG9yIGludGVuZGVkIHRvIHRlc3Qg
aWYgQU1ER1BVX1JBU19CTE9DS19fREYgYml0IHdhcyANCj4gc2V0IGlmIHJhcyBpcyBlbmFibGVk
LCBzbyB0aGF0J3Mgd2hhdCBJJ20gY2hhbmdpbmcgdGhlIGNvZGUgdG8uDQo+IEhvcGVmdWxseSB0
byBkbyB0aGUgcmlnaHQgdGhpbmcuDQoNClRoYXQgbG9va3MgbGlrZSBhIG5pY2UgY2F0Y2ggdG8g
bWUsIGJ1dCBJIGRvbid0IHJlYWxseSBrbm93IHRoZSByYXMgY29kZSB0aGF0IHdlbGwuDQoNCkhh
d2tpbmcsIEx1YmVuIG9yIHdob2V2ZXIgaXMgbW9yZSBmYW1pbGlhciB3aXRoIHRoYXQgc2hvdWxk
IHByb2JhYmx5IGNvbW1lbnQgYXMgd2VsbC4NCg0KQ2hyaXN0aWFuLg0KDQo+DQo+IENjOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IENjOiBNYXJpbyBMaW1vbmNpZWxsbyA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBT
aGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBpbmRleCA1YjE3NzkwMjE4ODExLi5mYWM0NWY5
ODE0NWQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+
IEBAIC0yNTY0LDcgKzI1NjQsNyBAQCBpbnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPiAgIAkJCWFkZXYtPm5iaW8ucmFzID0gJm5iaW9fdjdfNF9yYXM7DQo+
ICAgCQlicmVhazsNCj4gICAJY2FzZSBJUF9WRVJTSU9OKDQsIDMsIDApOg0KPiAtCQlpZiAoYWRl
di0+cmFzX2h3X2VuYWJsZWQgfCBBTURHUFVfUkFTX0JMT0NLX19ERikNCj4gKwkJaWYgKGFkZXYt
PnJhc19od19lbmFibGVkICYgQU1ER1BVX1JBU19CTE9DS19fREYpDQo+ICAgCQkJLyogdW5saWtl
IG90aGVyIGdlbmVyYXRpb24gb2YgbmJpbyByYXMsDQo+ICAgCQkJICogbmJpbyB2NF8zIG9ubHkg
c3VwcG9ydCBmYXRhbCBlcnJvciBpbnRlcnJ1cHQNCj4gICAJCQkgKiB0byBpbmZvcm0gc29mdHdh
cmUgdGhhdCBERiBpcyBmcmVlemVkIGR1ZSB0bw0K
