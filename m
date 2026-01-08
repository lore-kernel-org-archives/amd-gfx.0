Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0BDD185EF
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 12:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C4C10E34F;
	Thu,  8 Jan 2026 12:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gUzsjwTb";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3860310E34F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 12:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OePp7UWw54vVQYc9bpfVRhaRL/dAWaSK5FgtHbdB6kyAV8TfmYlMZySeXICCV8g5QtEzpY92H8td4AZmI2Q/s4baPQMM4T7skdcVDcl+e3b/Q2xfNl1cDrDesv9ybm/3j2vdocn1QG85g3B/oy6q5Fb4abqoeXolSh6l2vtEFWLgwPVOzieb4Emz0cQaTXiKgG9tZj0mVvOsRtoLk9xJafyI/Q4GDijdIchnRlN1+5nueA4Q9bJ7zOcmQJ6aRmlV4w2YqR1Wj4tuqOWRZ7OO59b+kFNlMAHbAb2Ohv+uymPIXy3QlV/oEIXEjVLaFzAXWUdpA3OscedJbJlVKuKZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYaI/yEIjvZfDsjxKoH/KmNA/wUUbYUZ/jzIIQPfwSo=;
 b=DuoqBoN88JfSp8naqWU7QOnWq8SYjuonn9BI4p8pN474WEw/dH9wItc7NDElgRPQnT6h44OKUZg+2KMoR8n4VkYdVOz7/V6ROZnoC3+XWH+ikbRmhNtZqY7ule0JUeiFoJDw8rZK4XFVt+JGDNuZ1JQcfr3ghGWpX4bvhrCZU4qVrha7T0XkYOUJGMv8ZXGzE/hPsHmOtKrSDYW3SPKrOXSSVfYRNIz0q+Qtg+cseGrzUQurOwnpctF4lCgq9ih4z07NsRf6ri96MAhz0fWu7LV5qLlgGMBlbgYMfJLqyCyNe+eM0Tdl7fnV1mid8ZXYA/AAO+VO5scnYjO1iUT8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYaI/yEIjvZfDsjxKoH/KmNA/wUUbYUZ/jzIIQPfwSo=;
 b=gUzsjwTbVMPQryM69mApF88tzA9yp3yxUs8L+xTXtghk1a687Rwbd6elYDz0/Svb2kfAygPblO8f7eqd6BnP8pv8BEeGL4rme2A2fDe7+2ufYY/T4tHJ1eYXf2YivHSKnhenE3tDYwuaV065xzq1LQU3XzmqY26MaMS0Ktb13E4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 12:54:03 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 12:54:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Thread-Topic: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Thread-Index: AQHcfw8bLzfrjVkAK0in+Mc3MnRAybVIOuoAgAABaaA=
Date: Thu, 8 Jan 2026 12:54:02 +0000
Message-ID: <DS7PR12MB6005E3B971A03814345CD820FB85A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260106131921.801193-1-Prike.Liang@amd.com>
 <2275758d-de1e-42eb-b224-89485511a83d@amd.com>
In-Reply-To: <2275758d-de1e-42eb-b224-89485511a83d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-08T12:53:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB6868:EE_
x-ms-office365-filtering-correlation-id: d915a7be-de47-4f70-40ba-08de4eb50009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?aFc0eHpnbWg5aDBRMmxUU2JOS0JvdzFvQUN0b2JhRE5pdEY5cWVhZTh5eDkr?=
 =?utf-8?B?TDZWTUJIUU5hajQwT3VxU0MzeVN4V0ttNEZmcHhUdllIUk1uYnFyaVZIcFh5?=
 =?utf-8?B?TklpQjF4cExkWkVHTjhXQzgyRjRBcS9rQm83T3plc2dNY2VQV21sVC8wMGlt?=
 =?utf-8?B?TFNsUThpOXBnL3VNUkRNdGhaOVQxSTBjUW13aXRMbnlncnNLdHZjak9SNlBW?=
 =?utf-8?B?QURlcW5qbzR5OEFLYVptTTFYYWZtbXdzbjcwSUQvOWhNd2M0aVlHRFVtRGUw?=
 =?utf-8?B?WmJxK0VLNTNVNUJLZFA4U29QZmllNzZzN04rL3l0bjlqbFdjL29IRTBaNTVR?=
 =?utf-8?B?OUJMOFVuTVlwT3ZWb0ZDZzQyZUZCdUJIcWluYUJMQUh1STFicFM2TlZVU0s1?=
 =?utf-8?B?YmIzRzg5OE5MdHljdDdUVElVb0I0U2ZiMTRGWkhDdTNNY1RHY0ZUa2piUnFz?=
 =?utf-8?B?VGdKY0o4dkpOQ1BBTWFIOWh5ejIzYnFyeFMwSkt4eXQ2dko2SDlYc3o4Wkcx?=
 =?utf-8?B?azlDY2UwMEdwOVVoSHdnTEd2L01KeUpuYWI1ZGNXaVJXemdYc3BzUms0OCtj?=
 =?utf-8?B?ckdMajZ4ZExva0JvVjFWek9KWTZSYWZROXNyT21yV0xQN1VKT0RJUm9wSmtD?=
 =?utf-8?B?Vm9LcTkzY0tJVkpNSCthOFdxaW42WXpmSWUxblZYL2hrK3hkRnBESTRDWHVC?=
 =?utf-8?B?Zmk3Ny9BRVBYVC8rVkdKZXBmclhpVWtWVlNKN1pFNXRSOStWRE5oSmIyQjVX?=
 =?utf-8?B?UGM5MW1WYUE3RVd0Y2lZNWpCRmlMZ1k2NjZtK2NBRFh2eEU1bDRaN2g1Y3hw?=
 =?utf-8?B?VnllOUtudkxXMXVCSnFlZTRnbjlQQm5HUmE4d2YwRlBzaDZOSXpyWCtZa1pJ?=
 =?utf-8?B?bGZzOGVvZ21FY2R4MTlKdk5hRHlMWVNGbHdYUGlZOUhyNkVUK09pT25HdHQr?=
 =?utf-8?B?WUpkSGQzTmdSS00yaTB2M280L09WM29mbW9FM2xyQWFtRUxIWWdNOVFrWDFF?=
 =?utf-8?B?VTNpSWd1VUdzdjQwV05IUWdIRlhwU21sZ3BlVXd6aFRqVTY3WXE2VUVaUVBT?=
 =?utf-8?B?Y2M0RUMvUmRsOFhsTmFDZTRReHdRbWVaVDd6U1pQdVJCRjEwT1gzSkthMzV4?=
 =?utf-8?B?U2FxcU92WHoyaEJydU94ZmEyYVU5aHFuTll0Vng1MTM4WmpydGQ5djI1VnNk?=
 =?utf-8?B?ZzZXMHI4TUZsMmFzdXJYSlI4dW92WUZoeXdTQ0ZTME1pY3U0K3paNHBISXNN?=
 =?utf-8?B?aGZZOTRKamNOeXNqcWpGb3FhRE9UYWtKK0JEMXZPOEFTMUlhOEVhMmZUNkxk?=
 =?utf-8?B?K3E0b2hENTMzbmpZSnhlbkQvSnY4UmdPUGZFREtVU2I1Rjc0WVRwdFEzc21Z?=
 =?utf-8?B?a01YNjkrZVh6d1FmM0kxTXRKTjg1OTQzNWJTWDl0WEEzcjVhNGJ6eW9CS3V1?=
 =?utf-8?B?L2kzbEJVZlAzWVRXOWYrcVQzb3M1eFpkZFhhSWxiVFhZb1diSGhyUlFOWUZo?=
 =?utf-8?B?RGpOZWdCVjdCY2RIRXIvZ3hsS2hFckNTSTAraEhMdWFES2dCTzlFYVErUVoz?=
 =?utf-8?B?RGJmekZ3ZWhFa3IySFNLeGtYYmlPY05ZRUh4bFZsU3gvaEszRnBqRjd0eGlG?=
 =?utf-8?B?Y0ZBaFFTQ0JlTUVEa2c0Mm9qQlNJSHdCeTNqbzBubmdoRjlBcjVSK25XZ0NS?=
 =?utf-8?B?WWZwZFZQNmZsU0I4K25LL1hPSStEUVlmRzFNUEdhOVRuZXE1M0RscFBjNWZr?=
 =?utf-8?B?ZHM5WGQrTmRKMkRGN1ZoZkxwU3dLakxwWGlieStVNDFqRmVyTC92VGttdG9D?=
 =?utf-8?B?WlZlbWt4UDlhc2FHWEltQlgwL1kwQnBvaFFCVUs3SDZkQndWdGtRU0xZT1hD?=
 =?utf-8?B?bUNhMWc4S243K3JwbmpjbzIrSVh6YkhXaVJ2OU55ZmlRRmVYWWhqL1dyeXNH?=
 =?utf-8?B?Qlk1N0xRR1JybUdDWW9hSU5FYTFwTk1pVWxyQ05CcWZSYTJramVrTmh5MEpP?=
 =?utf-8?B?VlM2YWd4VzhKWVdKMHVxL3VzeTluckdoR2R6WW5obWRpWFZrOWo0NDNHMGxt?=
 =?utf-8?Q?a7w7T8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3lPZkZreHg0RUNmc3Bab2kwdnJpb3ZsSWFrWTdTTmhjWkJpYmRtVjczRGc2?=
 =?utf-8?B?dlNkTXgzOGc2MnRaSTV6dWxtL01nYUlVN3RJSjF1dmZxK2poZTdETGt5c0JO?=
 =?utf-8?B?M0dGeWFSTWZmNys2U0RQK2dkZXB5ME5XZktKUkU5Q3hwZEp3eU9odTJXZkZK?=
 =?utf-8?B?cGlvN0syQTJ6ZTVxUFltNlNzLzVGMk9mWElaMnlaQXo4Nk5wL0FaTnY4ZllP?=
 =?utf-8?B?RDBXYWlvWXM0SHhyY3JvRTEyQ2F2ZEJmTGJvQmt5QlFyVmRiTGFxNVUraHNj?=
 =?utf-8?B?YWxHcjFDWVdSRlZKZ1hJN1VHOTBNRTZ6ZjVWTDQ0K2N1U2dmaCtCcXNMOVdV?=
 =?utf-8?B?M1FqcW9kcU0zMkV5d2dGWHVsNUF0RHVaMXFSNkJPRVpzSXdSbkh5S21VNzRH?=
 =?utf-8?B?eGh6UnJFZHpQTW1mMGJKUHExTlB4MTBoaDFVcnRLRE1CcVgrcTNkcE5xcSt6?=
 =?utf-8?B?bEU0aHh1K25KdHRWWVN4NVVpK0dOSkNvTERZNnNNVlRLR1V1aHVjUGtFWFVW?=
 =?utf-8?B?SCtWaFdXT2VtSmx1MTQrczNpUllLMmNKVFpSRHMxeDU4UmhtN2NUTENPZ0Q3?=
 =?utf-8?B?MHluTFZlK2E5ZUlVRkZHdUpZdXlQVzZocWVDR3dXRWlpTCsrZFZSSzk5dmpk?=
 =?utf-8?B?Z1Qxb1hMcGUvQnlVMUh4UVMyOW8wRUJjTUIrVGhCanpEQ05ONzdoNnltRXdh?=
 =?utf-8?B?NWdtbmp1UUZkYmlUeWkzamhOUFFCVGlUdHlVWTV6ZG9tRU85UzBMMm03TVhv?=
 =?utf-8?B?MnNvajFiL2dWaUcvcUJqeDhZYVNudi9FSUp1ektEYTM1NExrSkVqeFhlUExm?=
 =?utf-8?B?VjUrRFRUN3B0U3kyU1ZzRkNaUmRVaEV4YlBsbkFqZS8zT2pYQ0dxT283SVkr?=
 =?utf-8?B?Z0o4UlFVL0ZKZXAvYktLYkVObER6VHFUaXp3SytIcjFHZG51NnMvTDByZXRE?=
 =?utf-8?B?OXVXTW5YbExId3Z3a2VpNVBWYzNQVmNWbnBRanhCNUxVRXZudmhyWG1KV2RR?=
 =?utf-8?B?cXlEVzZ1S1BZM2ExWVNPdDVtNko4cGNObW5MemRyam8xbzR5UTFkOUZabFd6?=
 =?utf-8?B?SlZvTEw0VzVYSkg4YWpMY3pPSm40RE5OSnQ3cVdCUzI3M0tRakpmVEs4YmpI?=
 =?utf-8?B?ZGY4TXlzb1JtVnBYWXh3c2U2M3dTdTJOSXVXRFRIMTRrOW9KT2c4K1JpSytR?=
 =?utf-8?B?VWNKSkhob2I4clhheGM4WmtJdm5ldm42SFo4SDFXRUVYWldpUUpLKzFWMDZ5?=
 =?utf-8?B?TUxoRnlSQUZHb0R1SmcxYWJkdTJIUTFzOWdtSSsvUVVES2Q0RklBa1RDWHNY?=
 =?utf-8?B?ZDN3bTBlaVUzWGNZQTk3MG1Tazl0a2p1cmNuaUNDL2ZueTVSdjVHWC9GM1lO?=
 =?utf-8?B?S0Y1ZEJKeUhhU21ESmM1MUI1eFJaejd3cy9ERWtqMXBxTUpCYjBoVjl3cHho?=
 =?utf-8?B?YXpxQWJDbEg1Vlc1bmlRUzlDbXlvVGpqbGFFNDZLR2dobTlGWHdmYSttd2Zx?=
 =?utf-8?B?MjdtSXVUenJyY3NEMllnOEhqOUpNb1N6MlNKaEpsTUMxaVBaajJMYjhLRkM5?=
 =?utf-8?B?cDFZQkNxUDZSYTZVcFNSdWVtYTdJM3d5blpTVWNqZ1pzREM4bC9jQWdXUk1k?=
 =?utf-8?B?bGhoTUoxbXhvMjdoVXlsR2dBaDQxaDJFWG45TmJwd2V4VkYvMnAvYlZaY1h5?=
 =?utf-8?B?VUNuV291VHhRMlZxbnFEUjMwL0plb0F2VEVRTnlFQk0wRkZCRFNQRE5adEQ1?=
 =?utf-8?B?dWJraDhQQ0pJZ1dTMGN4cTdCQm0rcUtGNk5ZaG5pbzh0K0RDOXdyUTM0UWRq?=
 =?utf-8?B?TURLaTNOTlFGU1VBOHQ5czF0Y3E3SDMyQlV5MERWUkV1ZURNWG51alVHVXJG?=
 =?utf-8?B?dDVkNEoxeSsxUVVkZGR0STM1dHRJSGlYTXJ2bDVaenlHZXI5SlBjMGNnZ0hQ?=
 =?utf-8?B?T1BiVWVSaHlXc0xiOTV2bXBHdnRESWg3VFdmd0lkdnRGaW9NMjl0anRET0xH?=
 =?utf-8?B?UnF4cjJoZHBMaHVjenE2a2hNRkhiamxUNGNxS1hSMzR2cG1JK1JCcGN3RDBy?=
 =?utf-8?B?bU41TC90eFZjMUpVcGUyU05RN3k3bWpJYm54YU5LZ0RtTklHR1lJTmkxSk5Z?=
 =?utf-8?B?NnEwY0phTCtzWmU3SVgzcFZjV05TWVNTUW1rYjZjNkFQY0ltTmNVb01icUxM?=
 =?utf-8?B?TjJnSko1cDFzQUZmRkRIN2tVK1BtNExzcWIva1BwVTV5b08zZ2ZPTytpMWlk?=
 =?utf-8?B?NTZFc3FtQ05nK2lNY2JNWkJhWlBpVFgxcElmaitpZDNmYmlMbURpMUZtNEpB?=
 =?utf-8?Q?noboN5PJZCmBPtB+dh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d915a7be-de47-4f70-40ba-08de4eb50009
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 12:54:02.9656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5gSQcDxTepWrLXfnd6w7ohWLcnZ7lfeqdvXtMrGseNuKByzjFdDI/vOfn3TOfwN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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

W1B1YmxpY10NCg0KSGkgQWxleA0KDQpUaGlzIHBhdGNoIHNob3VsZCBmaXggdGhlIFRMQiBmbHVz
aCBzdXBwb3J0IGlzc3VlIG9uIHRoZSBvbGRlciBHRlguDQpEbyB5b3UgdGhpbmsgd2Ugc2hvdWxk
IHJldmVydCB0aGUgZm9sbG93aW5nIGNoYW5nZSB0byBjbGVhbiB1cCB0aGUgVk0gbGF5ZXIgZmx1
c2ggcXVpcms/DQoNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2FtZC1n
ZngvMjAyNS1EZWNlbWJlci8xMzQ5NTkuaHRtbA0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA4LCAy
MDI2IDg6NDQgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IHZhbGlkYXRlIHRoZSBmbHVzaF9ncHVfdGxiX3Bhc2lkKCkNCj4NCj4gT24gMS82LzI2IDE0
OjE5LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBWYWxpZGF0ZSBmbHVzaF9ncHVfdGxiX3Bhc2lk
KCkgYXZhaWxhYmlsaXR5IGJlZm9yZSBmbHVzaGluZyB0bGIuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4NCj4gUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgNCArKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gPiBpbmRleCBjZDRhY2M2YWRjOWUuLmY4
NzFmMTY5MzQ4MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ21jLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMNCj4gPiBAQCAtNzgwLDYgKzc4MCwxMCBAQCBpbnQgYW1kZ3B1X2dtY19mbHVzaF9ncHVf
dGxiX3Bhc2lkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MTZfdCBwYXNpZCwN
Cj4gPiAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICAgICBpZiAoIWFkZXYtPmdtYy5m
bHVzaF9wYXNpZF91c2VzX2tpcSB8fCAhcmluZy0+c2NoZWQucmVhZHkpIHsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgaWYgKCFhZGV2LT5nbWMuZ21jX2Z1bmNzLT5mbHVzaF9ncHVfdGxiX3Bhc2lk
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICAgICAgICAg
ICAgIGlmIChhZGV2LT5nbWMuZmx1c2hfdGxiX25lZWRzX2V4dHJhX3R5cGVfMikNCj4gPiAgICAg
ICAgICAgICAgICAgICAgIGFkZXYtPmdtYy5nbWNfZnVuY3MtPmZsdXNoX2dwdV90bGJfcGFzaWQo
YWRldiwgcGFzaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDIsIGFsbF9odWIsDQoNCg==
