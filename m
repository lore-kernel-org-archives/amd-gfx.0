Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5196DC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 12:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AA510E16A;
	Tue, 18 Mar 2025 12:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KKEe9F9Y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E69A10E16A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 12:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5I0AcmyLd6pbneMOyU8FstLrb/CMkMoUh4eFINrgo61bTw9bpQEllMPA17ZxlfB8lBIW6A9lbbRMN/g+VU042+aOUNVGE92m/i75F/gdEpCpH1FtW5BqsFFYl3JM+ZNPZ+zmPeB5wHoc8GqxfkSAFitAkSKdyNYU4yjt5jXEJ4XHosUXvbzPmucTig7LdaENig4zzYD5rr5QU+4bNzc06OUf6PbFd7wEuag1pWieBFAqUkfnAr9Mb7ZAjR+4Xcgl6vgaKTZWfXCC9te8egL5AAoJ7cD2I9eRHUuUlWxNnitZ6sGmevcw1YomlLKsKxRjaZOOIHHrwari91zRwAOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl3ImoDdEhH+RKmbQ3cNu9cKsXngr7JktvSoKDkOvXo=;
 b=XZGQ6LQoMuGyl/n33Y9AJp1hdHbO/kTLDFBqAVzd3Y2ugPuPKuVF0nF5CRM074dKOfFtR82Fqzxu5hYpGJT0BGLfxbR7tSbs1Pl8/aKden8E5+QnwfR2On0Yc9Eg+LZWJShfYREOB+nBq8h/NSKOn9pgbh7WWH+3CT0cwFZLrQPjSPHUG0Z959xXU9wYWSQrGc3GO+iDYgDooZMOkSoz4U3CeTo+v8ma0klDv56VH6yYVUNlEwqiorjlPcW6ctuqmM5/AL1d7g9aLFrk/6sol2LXWkN59Hq7TASOZHZKd6KFUv/BJP3BWh5fHXM/gUlY9hNis8/vzDlzFaXhxIhYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl3ImoDdEhH+RKmbQ3cNu9cKsXngr7JktvSoKDkOvXo=;
 b=KKEe9F9YD+LJkZ0iSjwveF0th5p6GoEkgfIufBRZJeCX5LlKzKtRx/5CJx9bQnz0ejGjePY/Bq/IbKUtjoo+cCYDheGUqnxJZ5Yi/26HPCtMeOU8yDl/hV2avYNQbnNecTvjvExFc8wZ/kLqXqJ38v1ZNUhKPhgWelmWPGZJYyw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:23:25 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:23:25 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Thread-Topic: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Thread-Index: AQHblCYdtlcReGyPeUiPrTWI0cRMQLN3DPaQgABM4wCAAXvaIA==
Date: Tue, 18 Mar 2025 12:23:25 +0000
Message-ID: <DS7PR12MB60059679D25466562C7A5D10FBDE2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-4-alexander.deucher@amd.com>
 <DS7PR12MB6005F4F38F75F94DC2262703FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_N9BA5jz+iucHv-bPUz7ypxVHg_a47US92-Yr8Pu0cvTQ@mail.gmail.com>
In-Reply-To: <CADnq5_N9BA5jz+iucHv-bPUz7ypxVHg_a47US92-Yr8Pu0cvTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9e369526-1e17-4bf0-bdc4-bcd558550426;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-18T12:23:13Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW4PR12MB6729:EE_
x-ms-office365-filtering-correlation-id: 8c033742-7f6d-45d5-97d6-08dd6617ae97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzZUR1lmZ2JZNnp3MlQxbHlBOEM2VGFCWnZsMVdTb245azNtb1U3a25oTEFK?=
 =?utf-8?B?UDkzbDRybjBHMDhpdWV2ZlFTL0x2NVMvVWpzdFd1dE9YM2JJWW0waFpQV3dH?=
 =?utf-8?B?S1NIckx4KzlKckFRZENwN3I4MTRXWFU3cTg4WEViaXlSSm5Kcy94LzFiNGhG?=
 =?utf-8?B?TWNsUk9ZVStwS1M5YWwwQkRhVENHaUFaU3FNYzNvV1V0NERESVRMeGlDOVkr?=
 =?utf-8?B?R2NUNEp0dTZ3LzkybTVvNG1RTWtWd2NROEhBc0ROOVdCczU4ekgzbjJWQnhX?=
 =?utf-8?B?UTBpOEJURVByU1VCQmR2NFNERG1LN0Z0WWZleXJaeXkwOWNTWThXYWZ2cVNC?=
 =?utf-8?B?VUlWVnp3cS9PNEhkQis2TzgxZmJhYmdNZUFBWWprOE5tdzVGbm90anZPbERq?=
 =?utf-8?B?ZEV5aTZ3SFJva2Q3WW5KdE4ycmhYWWdXY2JjZEg1QUNwTDRBbS9UTnZsTjJo?=
 =?utf-8?B?L1o4SmxQdWx6bk91anJ6RjZVamRyWjU0V0JSREVvM0hKY0pZVnc4Q0hQZ1RV?=
 =?utf-8?B?MHZ0YnI1RkNqa09ySmdDSm1qTTdTL3Q0V0lXNi9WVHFGWmphN3ErbmtyWFZr?=
 =?utf-8?B?Qjl2VXBvVnJyOW9ndW03MzFUbnZRb0tnR2V0Tm9ncWs4bm53OXJJZC8yY0hp?=
 =?utf-8?B?RHBuRkdNRzVXbW8vUWdkOGQvR1REY0ZHVHYzT1VPRXlncGJscDU5UlNMY21F?=
 =?utf-8?B?aThsbVJJeERocmx3enhvcnJGTGprSHlEK24rd3VzQXVzQ0lzVmRWV3Q2c0Vz?=
 =?utf-8?B?R2F5ZHhmR2QwNFYwVEdFSTJBNklaYTJ6TTN4Zk56Qk5TOHZDc0Evb2Z1ZGlH?=
 =?utf-8?B?Y0s1b1V2OFEyaHoyZExJbXVWL1pKWERiRGJsa1dOTUxLMk1pYjIveGlDU0NC?=
 =?utf-8?B?NUtnOWVNOHhLS2dQM05lMG9FWXdnSHZGUG01M2o3cG0wQ1JIbVZOOUFmZnFI?=
 =?utf-8?B?TElDeU93Y0VKZFBJRkRZTEREa2JFU1FmcW84Q0FqRlZ4M282QTNUWUhmVjYw?=
 =?utf-8?B?VVFXNWlnK2lQaDhVMTNmYzlYemk2eVltZTJ0L2xXVzN3eUNpQ3M0c0hvRjcz?=
 =?utf-8?B?TmRPWnQ2Q0hCQlVRVStvMHZIRGRYR05WNlRmMnVLZ3g1bG1sR1NEZjZLVmNy?=
 =?utf-8?B?U1JxcHc2RjV5dENuNGpOVVd3VXZLR0RmZ0pSKytqZ2l5eW1OamIycUVWUDQr?=
 =?utf-8?B?aDFEZzdCNjVtSjdFck9FbjJ6R1JUaWxFeEJMLzFMNmdkWEpFaWdZa0JoZERB?=
 =?utf-8?B?d0M0eVhScy9iZkRHcWFIY2hrbml1bHR4RmZQalpGY1FrK3BLYkMxb3NwV1FP?=
 =?utf-8?B?MjhKMEhBRFQwNnB0NXFRemJYMTdleExoWHljbURTRytYNTYzQThpeXJoRDJC?=
 =?utf-8?B?Z3htWG1YbFRMcTZ2c1FPTzUvcTZGYmtPQWtTaHY4am4zU3pxQVoyUkI3VGl2?=
 =?utf-8?B?T3I4N1dYa2gxNlFrUW5VbUxoRlRySlVUOG9MeWNvS1pJSGVDTmp5cDc1VTMy?=
 =?utf-8?B?VXJmdTNrN00vWE9OeG42N0diUXAxdXIzbnJqL0g3QUFaS2pBLzJ0NlBDWThT?=
 =?utf-8?B?SU9weTlLTWR0SmEwRFlya2hqa0Nnd2x6R1A0MkRsL0xDQ2JNdVN4YmVRQlNN?=
 =?utf-8?B?d1dkK2xYMitLZW0xUHd4UzV5b1RvelZKNElKQ0NjM2RXODlUWTNUOEl0MG91?=
 =?utf-8?B?K3JzSFpFaENUdEJKemtIUWovcUxSaHhIaEpSMCtHU0F3UmsvNWFiVVVESVBE?=
 =?utf-8?B?Qk4rT1htOGdQdDlGcjFwajhvYnFZMFNxbE5SSkNnWTFXak96UzZYYWh3aDJT?=
 =?utf-8?B?czZTdHpHSldDZGF2b1ltcmVxbmtOWjZUUW84RnpkclVPL3J4Q0tvbmhHQTVW?=
 =?utf-8?B?Ynk1cTh6aU93RVA0M0pzbERLbnd1V0xQdFBEQTY3S3FVZ3VjNkNPeWdJUUNs?=
 =?utf-8?Q?YoFqm2gFgSULoXhvyvr74XzWOpqZGv3I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzhXM3AxUHFQdE53ekg2cDFYMHF0ajJPZld0aStINXVYL3RYS3lPdHVYLzNY?=
 =?utf-8?B?SHJBbVdORm1zUkJnOFhCUC9rMmkzdHpaOE9yQVFKK3BLUGc2U3lTMTREQUpq?=
 =?utf-8?B?MTRtdXd2Qkw5cmdaSWYxd1kvcHlzZ3RIUWNuZ0VjbkI0bEczWEhCTEE5Rkwz?=
 =?utf-8?B?aUV5WDB0YTRreit4NUZvQkx0aGZoM2hXMi9VSWJpUHZ1c0lxaExmTlAra21W?=
 =?utf-8?B?amgwMW1lTjJudmpXTitIMlNabG5sQjdwL2kyaFpPQi9hclBoWWpQVytsNUt6?=
 =?utf-8?B?K0lUY1pPVUtIbklOT0lvcEpvaGYyZCtrSy9CYXZqaENydGloNnRNMnZQQTVH?=
 =?utf-8?B?Y0N1VUtPTDl2MU1LaHV0VklUR0RkMFVxOGI4UUp6cUpua1RCeE5TYXNxRnR1?=
 =?utf-8?B?WkRFRG00Ni9EV3lNTmhtUkMrbG5UajVPNWE1NkgrQk03NXlESHhwN1kyUG9K?=
 =?utf-8?B?T1J4ZExiekpiRm5wR2hZeHlzb1lGMmVURTdkUFFDSk9BUm8vY2xHL2VTZW9l?=
 =?utf-8?B?VGdseHFGcDNKbytiOXRCZmRTVUFXN1Vsd0xTbTB2bzE4YmJUSDV3NzFvNVdL?=
 =?utf-8?B?SVdZdjk5ZytmWXVRc0JMamg0YkE0VXVHVVZTRmMvYjhuelpDWm1OcXI4UHg5?=
 =?utf-8?B?WU1URWRFblNyU0wxMld3dEhlbkV6bitQZnY5Vlk4Y0VFcUNDZFYzRmJYZkpT?=
 =?utf-8?B?WkprQ2hUeWZHK1Z1ZzBSeDM1elJCY1R4WWMzbk9rV1FSK3ZTL2lwbGs5cEwr?=
 =?utf-8?B?M0hyajRpeDZ4WVFuN3AxNkFKRWFWbFQrbVdVa1RHa3RSRGNkWHBjZFlTSFI3?=
 =?utf-8?B?UlRGL1RrY0hUTUlwcFFIalJOeGJNelI1eFArNWF5bmRaLzk3dlBkTitodnRN?=
 =?utf-8?B?dVJRN1VZNHY2SHRzSWRwU3IxNGliSFlMbmh3TFl3eUU4QXFwdHZPT3QyakdC?=
 =?utf-8?B?dU9sd3JUMUFTUUx1UWhSb2Rwd0h6bWtsQ2RhME5sQ3lsbGtBREhuRmFINXBp?=
 =?utf-8?B?T2EyMmhQejRGYUxKbDRobzVWK1VSdEVMQmJneTBtdkNQTFMxRFJnRVNZaXhu?=
 =?utf-8?B?SEdEZDJVSWZUcFVxWlhEUFJmc0NDNUtLRVdueEM3V0hCWFkzaTduWTJOZjNW?=
 =?utf-8?B?dWdVdy9HZkFHSHY4NzhMWUNDeGFwS1VPZzBkQkhyT0FNVHN4ZkxhZXJoc2JD?=
 =?utf-8?B?UFhEK0JlazVlbkpZa0FGVFNzYi8wUFRXblBOSElreXFPZU0vdDI5dVF1MkVO?=
 =?utf-8?B?dXQrUzZWbmJkd2dSZmJZUzZvZ09iamlONzVYSm9vVm42c1lBTk54c0JBYnhW?=
 =?utf-8?B?S0xwaXJma3lEWlRNbklLb1VzNEpsdURob0N5MVg5aG80bmlJcU85NUxGci9X?=
 =?utf-8?B?elczbFRxdWwyZ1BXKzRGSGZ6MnhaNzBWTlEzanl5dFEyU29YQTVBVDdUeFY4?=
 =?utf-8?B?Mktab1pHcEJvQ0xlYUZzMFVhaDlEN3MxQml4ekxVQmU4L2s4RmdjYWtaQUpj?=
 =?utf-8?B?OUExWlQ1NG1YR3k0VnZtelpyWW5ZZFVZTGplZlUybmVTNU5DdDRwa0FYeFFV?=
 =?utf-8?B?a0VvS0ZDcjJjZmdnMzRvUnFpeFNWeTE5VDhpak16WTJiOFVxUTRpbTBqNC9I?=
 =?utf-8?B?b3o4Y2hJQjhnQ3hISmFoYVJsL20yTG9JenY2cldUZGpsOUJPc0JGMm5yY0lC?=
 =?utf-8?B?aGh4N2VaWGgyMGFmQVpMdi9wTWhrTUh0OVAvdzVNdmRLdTl2cE9CVUtLdEIx?=
 =?utf-8?B?MUZrbWQ0VE9xaFNpZkJkNStoZjBTckJrRTZxMHRVZGZaczVSYzQvZVF4WFZY?=
 =?utf-8?B?bUhKYjhwenpKaW5mTVJrMU56SEpLYUtTV1FTWmw4QUViOVlSbzJlYzk2dGRQ?=
 =?utf-8?B?TkpCUENGNzVhMzVyUE1HU3VhVzBtZWptU1VGQWFVVjFBQks2UGtHSktlRFR0?=
 =?utf-8?B?YUQxY2VmNTd3bVl5TUE2MEYxeG9oaDFkc1ZDczZ6TnBhRmdYWHFVcjhUcFln?=
 =?utf-8?B?c1RGeFovekNZQUNGTW1hTjFwOWoyVTBjMys3VUJxQUp2dHdHYTRZeDVZVjdK?=
 =?utf-8?B?RmQ3QjZkRHFRTTVzVHpKUjcyNHBFQmI4UXdzWm1KRG1NRHlVKy9sYmdGYzlw?=
 =?utf-8?Q?ILYk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c033742-7f6d-45d5-97d6-08dd6617ae97
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:23:25.5614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZ36JoFQfrLfnVLn5zvUsGiBeTx2C9vVHZ4mMzFUHNLaIZfY5w8W0Jcor+nl93AW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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

W1B1YmxpY10NCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNywgMjAyNSA5OjMzIFBNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMy8xMV0gZHJtL2FtZGdwdS9nZng6IGFkZCBnZW5lcmlj
IGhhbmRsaW5nIGZvciBkaXNhYmxlX2txDQo+DQo+IE9uIE1vbiwgTWFyIDE3LCAyMDI1IGF0IDU6
MDfigK9BTSBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gW1B1YmxpY10NCj4gPg0KPiA+IFdoZW4gZGlzYWJsaW5nIHRoZSBnZngga2VybmVsIHF1ZXVl
LCB0aGVuIHRoZSByZWxhdGVkIHJpbmcgZnVuY3Rpb24gY2FsbGJhY2sNCj4gc2hvdWxkIGJlIHVu
YXNzaWduZWQsIGFuZCB0aGUgY2xlYW4gc2hhZGVyIGNhbGxiYWNrIHNob3VsZCBhbHNvIG5vdCBi
ZSBmdXJ0aGVyDQo+IGludm9rZWQuIFRvIGF2b2lkIHRoZSBjbGVhbiBzaGFkZXIgcmVzb3VyY2Ug
YWxsb2NhdGVkLCB3ZSBtYXkgbmVlZCB0byBkcm9wIHRoZQ0KPiBzaGFkZXIgY2xlYW4gaW5pdGlh
bGl6ZWQgYXQgKl8gc3dfaW5pdCgpIHdoZW4gZGlzYWJsZSBnZngga2VybmVsIHF1ZXVlLg0KPg0K
PiBUaGlzIHBhdGNoIHByZXZlbnRzIHRoZSBjbGVhbmVyIHNoYWRlciBmcm9tIGJlaW5nIHJ1biB2
aWEgc3lzZnMgYWxyZWFkeS4gIFdlIHN0aWxsDQo+IG5lZWQgdG8gYWxsb2NhdGUgdGhlIGNsZWFu
ZXIgc2hhZGVyIHJlc291cmNlcyB0aG91Z2ggYmVjYXVzZSB0aGV5IGFyZSB1c2VkIGJ5DQo+IHRo
ZSBNRVMgYW5kIENQIGZpcm13YXJlIGZvciB1c2VyIHF1ZXVlcy4NCj4NCj4gQWxleA0KDQpZZWFo
LCBJIHJldmlzaXQgdGhlIGVuYWJsZV9jbGVhbmVyX3NoYWRlciBmbGFnIHVzYWdlIGxvZ2ljLCBh
bmQgdGhlIGRyaXZlciByZXF1aXJlcyBpdCB0byBpc29sYXRlIGJldHdlZW4gdGhlIEdGWCBhbmQg
Y29tcHV0ZSBwcm9jZXNzZXMuDQoNClJldmlld2VkLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlh
bmdAYW1kLmNvbT4NCg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+ID4gPiBB
bGV4IERldWNoZXINCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMywgMjAyNSAxMDo0MSBQ
TQ0KPiA+ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gU3ViamVj
dDogW1BBVENIIDAzLzExXSBkcm0vYW1kZ3B1L2dmeDogYWRkIGdlbmVyaWMgaGFuZGxpbmcgZm9y
DQo+ID4gPiBkaXNhYmxlX2txDQo+ID4gPg0KPiA+ID4gQWRkIHByb3BlciBjaGVja3MgZm9yIGRp
c2FibGVfa3EgZnVuY3Rpb25hbGl0eSBpbiBnZnggaGVscGVyDQo+ID4gPiBmdW5jdGlvbnMuICBB
ZGQgc3BlY2lhbCBsb2dpYyBmb3IgZmFtaWxpZXMgdGhhdCByZXF1aXJlIHRoZSBjbGVhciBzdGF0
ZSBzZXR1cC4NCj4gPiA+DQo+ID4gPiB2MjogdXNlIHJpbmcgY291bnQgYXMgcGVyIEZlbGl4IHN1
Z2dlc3Rpb24NCj4gPiA+IHYzOiBmaXggbnVtX2dmeF9yaW5ncyBoYW5kbGluZyBpbg0KPiA+ID4g
YW1kZ3B1X2dmeF9ncmFwaGljc19xdWV1ZV9hY3F1aXJlKCkNCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCA4ICsr
KysrKy0tDQo+ID4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggfCAy
ICsrDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZnguYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2Z4LmMNCj4gPiA+IGluZGV4IDk4NGU2ZmY2ZTQ2MzIuLmEwODI0M2RkMDc5OGUgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiA+ID4gQEAg
LTI1OCw4ICsyNTgsOSBAQCB2b2lkIGFtZGdwdV9nZnhfZ3JhcGhpY3NfcXVldWVfYWNxdWlyZShz
dHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gPiAgICAgICB9DQo+ID4gPg0K
PiA+ID4gICAgICAgLyogdXBkYXRlIHRoZSBudW1iZXIgb2YgYWN0aXZlIGdyYXBoaWNzIHJpbmdz
ICovDQo+ID4gPiAtICAgICBhZGV2LT5nZngubnVtX2dmeF9yaW5ncyA9DQo+ID4gPiAtICAgICAg
ICAgICAgIGJpdG1hcF93ZWlnaHQoYWRldi0+Z2Z4Lm1lLnF1ZXVlX2JpdG1hcCwNCj4gPiA+IEFN
REdQVV9NQVhfR0ZYX1FVRVVFUyk7DQo+ID4gPiArICAgICBpZiAoYWRldi0+Z2Z4Lm51bV9nZnhf
cmluZ3MpDQo+ID4gPiArICAgICAgICAgICAgIGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzID0NCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICBiaXRtYXBfd2VpZ2h0KGFkZXYtPmdmeC5tZS5xdWV1
ZV9iaXRtYXAsDQo+ID4gPiBBTURHUFVfTUFYX0dGWF9RVUVVRVMpOw0KPiA+ID4gIH0NCj4gPiA+
DQo+ID4gPiAgc3RhdGljIGludCBhbWRncHVfZ2Z4X2tpcV9hY3F1aXJlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBAQA0KPiA+ID4gLTE1NDQsNg0KPiA+ID4gKzE1NDUsOSBAQCBzdGF0aWMg
c3NpemVfdCBhbWRncHVfZ2Z4X3NldF9ydW5fY2xlYW5lcl9zaGFkZXIoc3RydWN0DQo+ID4gPiAr
ZGV2aWNlDQo+ID4gPiAqZGV2LA0KPiA+ID4gICAgICAgaWYgKGFkZXYtPmluX3N1c3BlbmQgJiYg
IWFkZXYtPmluX3J1bnBtKQ0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0KPiA+
ID4NCj4gPiA+ICsgICAgIGlmIChhZGV2LT5nZnguZGlzYWJsZV9rcSkNCj4gPiA+ICsgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiA+ICsNCj4gPiA+ICAgICAgIHJldCA9IGtzdHJ0
b2woYnVmLCAwLCAmdmFsdWUpOw0KPiA+ID4NCj4gPiA+ICAgICAgIGlmIChyZXQpDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+ID4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaA0KPiA+ID4gaW5kZXgg
ZGRmNDUzMzYxNGJhYy4uOGZhNjhhNGFjMzRmMSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaA0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+ID4gPiBAQCAtNDgzLDYgKzQ4Myw4IEBAIHN0
cnVjdCBhbWRncHVfZ2Z4IHsNCj4gPiA+DQo+ID4gPiAgICAgICBhdG9taWNfdCAgICAgICAgICAg
ICAgICAgICAgICAgIHRvdGFsX3N1Ym1pc3Npb25fY250Ow0KPiA+ID4gICAgICAgc3RydWN0IGRl
bGF5ZWRfd29yayAgICAgICAgICAgICBpZGxlX3dvcms7DQo+ID4gPiArDQo+ID4gPiArICAgICBi
b29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpc2FibGVfa3E7DQo+ID4gPiAgfTsNCj4g
PiA+DQo+ID4gPiAgc3RydWN0IGFtZGdwdV9nZnhfcmFzX3JlZ19lbnRyeSB7DQo+ID4gPiAtLQ0K
PiA+ID4gMi40OC4xDQo+ID4NCg==
