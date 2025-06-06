Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD5CC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 07:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D8A10E383;
	Fri,  6 Jun 2025 07:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TDGtu4dd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29C210E383
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 07:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJHM9uOI68KHVF4UIQmsjxwAuQZmZhzuLuFDqp6f4PRLlHMBZcBPkSv9lR8/+5ppBrzRPJip2+tYhrIbZg9PFVMFN0sRCfSxhjU1C05TH+PaSmZnBanHTg/wL0HqJAc2DfLop8qR1/QLijarXt3Y+a7Y4g2QgUjRNy5uqP3LX7c8lusVWPkxCLv/U+wlHtrVJ9ziBjfb1UXI9vDylyUsQb/raIpkn9NzCH4dkEDKTn4fI3OXC0kH91QTWskGTyUqrb7YoCAkRrB5y6jEQmbCRDmEdDMeMvS554y9mecF1iqtNva04sYLX0IerCUWg1NMpjblJqj5mbKqxIhu2MJEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75xCDHKTUzY1/rA0Ndi/BRaPZCDm7J/shrc6OHFfRS8=;
 b=j2dcarA49BxWpfneTO8co191zJV7QL27Vm9DDockOqKN9ib5fSK/mpYeCwWCQs/Hypfs921iOahW3kUnurNkQ5Pi/EKRhQeo61ZPRPHTxcfa9+G5L/QrPkcx8tN6+fhzINgQ/Yo+RLLfi/qnnVZRzXKCx3+4wafP3hno2bfszHsTsOfrUkhWDP4uBiecMMFhF4lF22JTQGUuTd4ZInO2+BI3HRoFc10yZCswPJiKYtaDRCBjjlAxuCvyJJNGh60Oz683Np/kXDGzZlEqx5mft5y8bUEPNO1nZCMls7NTj+8mxEHpe3netG3kCbvQTwwvYlIEImLJG9hRsoOEM1Y5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75xCDHKTUzY1/rA0Ndi/BRaPZCDm7J/shrc6OHFfRS8=;
 b=TDGtu4ddwLdLFrQo19vXys+u5GlBQObywR913b85iu+bKBQKridDMJHskb5rU9/iI/CKApQvUxmH4AYW/2tbkKMS+2oOQLRKfvBxn0j+iSFU5qL7dAxhAIFOWiY5RFbxeTG3Zd7hhgRBW9WcCZguqw3VsbZ2Pqpdfo5WokY4nFM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 6 Jun
 2025 07:19:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 07:19:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Thread-Topic: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Thread-Index: AQHb0TgzsvvuSO+E80Oz8dMCPvga+7PvufqAgATVRSCAAAxogIABJBFg
Date: Fri, 6 Jun 2025 07:19:07 +0000
Message-ID: <DS7PR12MB600595715ABC3F9888DD0ABFFB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
 <ba16b7a2-130b-433c-a305-fa756bead449@amd.com>
 <DS7PR12MB600514C513A65F0C3298D02EFB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <d0359d3e-0096-4d95-968e-b1fc0b344604@amd.com>
In-Reply-To: <d0359d3e-0096-4d95-968e-b1fc0b344604@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e2ede630-4843-41e4-a095-ab05222aae17;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-06T07:03:27Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BN3PR12MB9570:EE_
x-ms-office365-filtering-correlation-id: 18d6e3b7-96dd-4d10-214e-08dda4ca6cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?OHNvWllKcHJuR1BPTDl1dy9pLzRIU1gzNW9sNXFNM2ZLbFBSWU1VN3NuQm9T?=
 =?utf-8?B?OHNMVStma3d4V0VvcExCQ045VUhOUFZ5amo0YlRVZXhHSkEvUzlpcnd0WGRH?=
 =?utf-8?B?U2Y2Y0NwTnBkMUhRS0JJdERpSFZFZkM2K2pidERqdDMrcm5LanhKeFJhSnIv?=
 =?utf-8?B?enFHRmtYVlBZbUFydFZ6ME1tdGlhNEYyM1R3NTdjMm8zbk9pZXdPSjg0b0N3?=
 =?utf-8?B?T0ZaT1RjbnlCSDZVa0VIQUhnTkFqSE5lbGJSdGd0eFdYUXFuMVp4bG5jSC9B?=
 =?utf-8?B?RHYzR1RNdXJqTHBzSG9KOVVlY2c3REtqczJBbmNXUUJlWkZlS0dZMm1qL1lp?=
 =?utf-8?B?K0NYVzB3aHdFWDRpODNHRDdOL0N1OXpKV3AzS25aVW5DcGxRckx0OUt2c2JG?=
 =?utf-8?B?VjYxZDNBYlpGNGdOYUJydy8vNVptL01nTWp1N0J0THBCTUZISEJrZGx5K1Ir?=
 =?utf-8?B?TGRkMmg5cDkrN2NUcTNBZDlXbXJneTVDbFNoTCtsblRGRG1yQVdsVW1sMjVt?=
 =?utf-8?B?ZDlsWjBzeWtIaXdtVmVPbVBxb2Q1TFJIdGdXNDh1WHV4Rm1SVFdzb1hVK0dT?=
 =?utf-8?B?OGt1OWxsYmJDRy83VWl4bkVXcnJCWHZsZTFjVlpVSkpjcFpHeHRmVnNDQlV3?=
 =?utf-8?B?U0MrNFZkU0h5Q3Q1VWcvTEQ2Z1dtMkdtaGtVbVh1enBqa2s5MDk2K1I2dnJI?=
 =?utf-8?B?Y1pEam0vUUJ1dnNaZStMWHEzYXdYTjlhUWJOY0RoeG92citzSWdjaS85V0o5?=
 =?utf-8?B?eWkwRlhIT3J1R3ZGNmdOSVJIalRKcHg5bVlmNjllVFoyZ3ZlQ0hPYkFIR3Rw?=
 =?utf-8?B?bmFIOVRuOXlKWUJ4SmdPMlpzd1JMZE5qL0hpV2N5NW1YRldieEdFSEFnUDZQ?=
 =?utf-8?B?WTI0SDJCRVZpV20ySFlyalRLT0pzZUNEbHc3MDdpM092WkR2cElMZjJXTGRw?=
 =?utf-8?B?TVcwaGxNQnUzT1JLTXRPckNBU3luVWtQSU10T0hSRkd1Q2VoRGQzdWlBZ3B3?=
 =?utf-8?B?NmNiTU5tK1JzdlRLRjMrSlVHdlAvUnBDTFROZGhURFpWalU4UENXRWg5ZEVM?=
 =?utf-8?B?NzlYa1RrWDhEaytlSlJ2MkpCZlFFVmkxMVhBZWhCZ28rMTBhSmszclp5bEw4?=
 =?utf-8?B?My9qd3VCcnhVSU1JQlJqdDFyeGR3Zk5MRkJmM3dtTTh4cnRUQi9rbW5lZWp4?=
 =?utf-8?B?dkx4dXBXSVo1RmxndFF5TDF3NnlFNXRDeVlYWWpTVE4wbkw3WXg1bE9BK05v?=
 =?utf-8?B?S0dBTWZOeDNwN1BTb0RMaEpDYktYWlluQzJ1cmt2MzFhUGtNeE9CN1RCNXVq?=
 =?utf-8?B?ZmFCUEJBWU9CclpndlhHeTUyUFdsVHo4ZzhQMHFkUTZoRmZEMnd1Qm85RXFy?=
 =?utf-8?B?aEVuU0RpdzBjdGoweGVKcm9WNmJqSHFJVjZJRHg4bXMwejY2QVRoZUJoSThR?=
 =?utf-8?B?eDJ5b01ab2taQW9TakM4Vy9YT3JHRHZsbitZNDNocGN6czNydDcxektEK0hv?=
 =?utf-8?B?L0hSUWNPemwxdStkMEhxNjgyeWNaTVluYUR3MEI4WWc1YUdQc05EM20rWmQx?=
 =?utf-8?B?ejBlN3RBY3Uya3FRZm4rS0tZRldiVmZ2aWpwdUs0K2YrZDhUMTZnenZEWVJ6?=
 =?utf-8?B?L1BEcDk4MUlmcFI3UWFtQTN2WVFWamQ3Y0VFWStvaksyNXRqQ3FpL3dDNDgv?=
 =?utf-8?B?SDVwZVUzdHVlQjVnamdKSGhhQXpNODZlQll4NkpNYmVJSlVHekR6YktzR3g0?=
 =?utf-8?B?Zkk2YlRDYjdsaFBWS2hHZG56Y1BYZVBQc3pHckNSaUVmenBaTWh3emZKU2p0?=
 =?utf-8?B?WUxNcDR5ZVJCNDhFMDlRckIyVGpxMlZ1Y2hXdXIvTllGekM4UWhRSlN3MExZ?=
 =?utf-8?B?enB1RUN5djZybzdFbjhvN1lnMitmbHM3NWoxT01XVENLdDBZRnBoMkdOWEZM?=
 =?utf-8?B?SGc4SlVKdE4yVVV1d2QyOWtjK3lhSFIrMlhxSWRTb0JDd1dYcEluTlRmYzZX?=
 =?utf-8?Q?qHKhqnOIeBv9e0qB/jfznfRVgdtNnk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXNTWnZhVU9NNzhoYkhVdENId2xmQ2FZOG1BaGhvcXJhZnhYYVkrSDJqNkhh?=
 =?utf-8?B?TEZwYzRQVEdOOXQxN0tDMnJYdC9meklYVGpPOHo3Wm90elIvY2VYL0NVaWZw?=
 =?utf-8?B?TlNqVUlIdm1LV29ucHJpMFB6bjhrTUlKak81cUlTQUc1bHV1VDBnVFZjMFFJ?=
 =?utf-8?B?RmRuS0tBSlVtM290cEFsaWFqSFJwMWVVdW9ZK2ZWT1ozUW9oRWZ6elA3UGRU?=
 =?utf-8?B?RTNPMlRiVDRIOGJpOGp3S0orYlRsR0RkTEZVSDBWcTRraUJ5dlRJa2Qwam9L?=
 =?utf-8?B?alVMamd5bzRHbm5wU045TkFRK3VuYkFiVkRJRUkySHU1NmJ3QzJBR0J1T0lH?=
 =?utf-8?B?K3E2Z1FKUnpwNWY2OHpIT3ByMmNjSjR6VWYxcGNHeTBhVTJiY2Z2Nmw0Mi9a?=
 =?utf-8?B?NEtzaEhBY3RKVldYNXlLWUxMRk9ZekxHcVYxdUJ4ckRKaitCMDlDRVJTNnZR?=
 =?utf-8?B?UjVPbU9CT3dUNDBzSU4xalVDUHdXQnZNc2FTZ1R1Yk53MkVJcDROeGs4ZGRx?=
 =?utf-8?B?bURSUnRSV2ljRC9WT1FhdUlXbFJVOUY2T0ZVRHZiNCtJWXlvRHNMK2g1SFBw?=
 =?utf-8?B?WFp6OWZ0dkJPNjRJU0xsc3cremR6dXhLS3FKTVpNQU5FMEEzZjRtWmNHcU9B?=
 =?utf-8?B?R1pwRVVVMjFvM0E5elczQ1dSU0Z0Tk1nMmlyb2NNMGxRWU05RXFwdnJRQTcw?=
 =?utf-8?B?YUE0S0JISG5WVndYc3o4MGpDZ0xXYmh5MTByYjFXc0poZEZFSjhhekZKaVdY?=
 =?utf-8?B?SEN3ays3c1kxN1ZmZE1HRnVhZEdaWW5TTUlEbE5iZkt5c3BBTThYak5pLzVT?=
 =?utf-8?B?T1Vab3VIV0xzZFdiRk5mUTVPdzZjR091L3FEb3lFMUNXRWE2NTNhK3U1cDNk?=
 =?utf-8?B?YVZKOExub2kxeTBHNkNTTWRpeVZkZXF6SUljSnBGWTlFSmxyNTVqMVZRY3J2?=
 =?utf-8?B?K2ZoTHZmaG95bjB5WkxFblczdHJxVjBKTCtxSi8rUCtjbG1Ja2tKcWx5aG94?=
 =?utf-8?B?S0RxcjJBWlpHVXZLMmIrQVhYVEdvY29vZVR1WThySWZha0xYdkJYNEhSdjBa?=
 =?utf-8?B?ZmZMKzRia2p5T1hVaWFhc3YzL1dqQkNKR1JlalBhRy9uUDRYRlNDUkZnd1c5?=
 =?utf-8?B?WUZvcFoyWFFWVjYzTFlpVkF1OXJoMkhEdmYwTVVFQjh3M2FVMGpURy9qZXhq?=
 =?utf-8?B?WFI0T0h2a2JPa01WK0F0UHZMYVRCUnRkZVdxYjl2aU9wcGxxT2k4Y0xKNUVE?=
 =?utf-8?B?THRHMHZ1c0g3M2hVVnBKam5rN1ZJZlFncmRIdTByTWJGT2Fxbi8xb1pTWFVt?=
 =?utf-8?B?UUhLdTg0dnBmNkYxZmFtOWZFMkczbWRPWVJFRFp0L0Z0OXVmNlBveklFUjZT?=
 =?utf-8?B?Y1d4RlFhblFqRHB2cWZWMitoRHRtUTdlbnpuTXJmK3pFUU80Q2ZJTUluck1V?=
 =?utf-8?B?RXIwME9QZi9ieHpiMnZjc0R2TGkzVmFvYnNPd000c3JQaHpGNEk3ajF1Wmww?=
 =?utf-8?B?TFh2eWpvOUF5NTZvWENOaWtNLzY4bDNSZStzNG5hdHUyN2VGVXFUamtjSW9Y?=
 =?utf-8?B?d2hMSUJzWHV5YUJKSVByeXdKdG95djVIK21wY3ZlL2tnWG8xR01LK2ljNDhZ?=
 =?utf-8?B?S1JUMGltZSs4WFoyY0w0UmZ6YktjWE9IcEIxRGV5cHBGZEVQeDdPK0pMaWRm?=
 =?utf-8?B?THYxM2FPWW1WZDJrQjBBSDhTSTZxQmxOU25wbk9zdERpcUJRNGkvbUtoTlFh?=
 =?utf-8?B?NkNsSVZ0cFpYY01wRi8zdUlLVlpNbXcrbTBRbTd3dER4WGdkSnlENlRvQWIw?=
 =?utf-8?B?R3Y2RmNHTmxwNjB4dkZXb1N4b1pCT0VFU2hTZGxVTmVEZ2o1K1hCcW5tbDAz?=
 =?utf-8?B?emdmcXo0SFhRa2hINHlSZ2pTbXlzWWNFR3J2S0RZRDRlQnRhZG10QXlYVFox?=
 =?utf-8?B?TmkySm9yVFArOVVSYU8wUXpCOE9RQXFBTG9KYzVBVk1NU2I1VVNFZFFmb1dP?=
 =?utf-8?B?UjZ2TDJQaW9ZeFdEYUtjSDlqS3dBZDJBbHBFdFd2NlZUZW42L3ZPeFNtUGJu?=
 =?utf-8?B?cVozVHNCSHdlZHhMUERlTDAxbnZEWDJ6d2JiZlBJZ3ZuSnU1eWUrZ1ZiYTdt?=
 =?utf-8?Q?CoDM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d6e3b7-96dd-4d10-214e-08dda4ca6cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:19:07.2568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6E99/YLXdUzYU7emvt8PbgEmh0AcXWBkA27we9xvmOo7XXKSlZe+eQsa6rqYzND9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570
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
bWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSA1LCAyMDI1IDk6MzggUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBMYXphciwgTGlqbw0KPiA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDMvOV0gZHJtL2FtZGdwdTogd2FpdCBmb3IgdGhlIHVzZXIgb2JqZWN0cyBkb25lIGJl
Zm9yZQ0KPiBkZXN0cm95aW5nDQo+DQo+IE9uIDYvNS8yNSAxNToxNSwgTGlhbmcsIFByaWtlIHdy
b3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gPj4gU2VudDogTW9uZGF5LCBKdW5lIDIsIDIwMjUgNzowNSBQTQ0KPiA+PiBUbzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IExhemFyLCBMaWpvDQo+ID4+IDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMy85XSBkcm0vYW1kZ3B1OiB3YWl0IGZvciB0aGUgdXNlciBvYmplY3RzIGRv
bmUNCj4gPj4gYmVmb3JlIGRlc3Ryb3lpbmcNCj4gPj4NCj4gPj4gT24gNS8zMC8yNSAwOTo1NCwg
UHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4+PiBUaGUgdXNlcnEgYnVmZmVyIHNob3VsZCBjb21wbGV0
ZSBpdHMgYXR0YWNoZWQgd29yayBiZWZvcmUgYmVpbmcNCj4gPj4+IGRlc3Ryb3llZC4NCj4gPj4N
Cj4gPj4gVGhhdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgYXQgYWxsLiBXZSBzaG91bGQgd2FpdCBmb3Ig
dGhlIHJlcXVlc3RlZA0KPiA+PiBzaWduYWwgZmVuY2VzLCBidXQgYXBhcnQgZnJvbSB0aGF0IGl0
IGlzIHRoZSByZXNwb25zaWJpbGl0eSBmb3INCj4gPj4gdXNlcnNwYWNlIHRvIG1ha2Ugc3VyZSB0
aGF0IHF1ZXVlcyBhcmUgb25seSBkZXN0cm95ZWQgYWZ0ZXIgdGhleSBhcmUgaWRsZS4NCj4gPj4N
Cj4gPj4gSWYgdGhlIGtlcm5lbCBkb2VzIHRoaXMgaXQgc2hvdWxkICpuZXZlciogd2FpdCBmb3Ig
YW55dGhpbmcgb25nb2luZywNCj4gPj4gaXQgc2hvdWxkIG9ubHkgZm9yY2VmdWxseSB1bm1hcCB0
aGUgcXVldWUgYW5kIGRlc3Ryb3kgaXQuDQo+ID4gW1ByaWtlXSBZZWFoLCBnZW5lcmFsbHksIHRo
ZSB1c2VycSBkZXN0cm95IElPQ1RMIHJlcXVlc3Qgc2hvdWxkIGJlIHBlcmZvcm1lZCBhZnRlcg0K
PiBNZXNhIHRlYXJzIHRoZSB3aW5kb3cgY29udGV4dCBkb3duIGJ5IGV4ZWN1dGluZyBhbWRncHVf
d2luc3lzX2Rlc3Ryb3koKS4NCj4gPiBCdXQgaWYgdGhlcmUncyBhbiBpbXByb3BlciBjYXNlIHdo
ZXJlIGtlcm5lbCB0cmllcyB0byBkZXN0cm95IHRoZSB1c2VycSBCT3MNCj4gYXR0YWNoZWQgZmVu
Y2VzIHNvbWVob3cgaGF2ZW4ndCBzaWduYWxlZCwgdGhlbiBpdCdzIHNhZmUgdG8gZm9yY2UgZGVz
dHJveSB0aGUgdXNlcnENCj4gYnVmZmVyIG9iamVjdCB3aXRoIG9uZ29pbmcgd29yaz8NCj4NCj4g
V2hhdCBkbyB5b3UgbWVhbiB3aXRoIGF0dGFjaGVkIGZlbmNlcz8gV2UgbmVlZCB0byB3YWl0IGZv
ciB0aGUgdXNlcnEgZmVuY2UgYmVmb3JlDQo+IGRlc3Ryb3lpbmcgdGhlIHF1ZXVlLCBidXQgYXBh
cnQgZnJvbSB0aGF0IGl0IHNob3VsZG4ndCBtYXR0ZXIgd2hhdCBmZW5jZXMgYXJlIGF0dGFjaGVk
DQo+IHdoZXJlLg0KW1ByaWtlXSBUaGUgdXNlcnEgZGVzdHJveSBmdW5jdGlvbiBhbHJlYWR5IHdh
aXRzIGZvciBpdHMgbGFzdCBmZW5jZSB1c2luZyBhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFzdF9m
ZW5jZSgpLg0KSSBtZWFuLCBpcyBpdCBuZWNlc3NhcnkgdG8gYWxzbyB3YWl0IGZvciB0aGUgcmVz
ZXJ2YXRpb24gZmVuY2VzIG9mIHRoZSB1c2VycSdzIE1RRCwgZG9vcmJlbGwsIGFuZCBXUFRSIGJ1
ZmZlcg0Kb2JqZWN0cyB0byBiZSBzaWduYWxlZCBieSB1c2luZyBhbWRncHVfYm9fc3luY193YWl0
KCkgYmVmb3JlIGRlc3Ryb3lpbmcgc3VjaCBCT3M/DQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFu
Lg0KPg0KPiA+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IENocmlzdGlhbi4NCj4gPj4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5j
ICB8IDMgKystDQo+ID4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVl
LmMgfCAzICsrKw0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91c2VycS5jDQo+ID4+PiBpbmRleCA4ZWVhMGUxZTFiNmEuLmY0NTU4NWJkNTg3MiAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEu
Yw0KPiA+Pj4gQEAgLTIxNyw2ICsyMTcsOCBAQCBpbnQgYW1kZ3B1X3VzZXJxX2NyZWF0ZV9vYmpl
Y3Qoc3RydWN0DQo+ID4+PiBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsICB2b2lkIGFtZGdwdV91
c2VycV9kZXN0cm95X29iamVjdChzdHJ1Y3QNCj4gPj4gYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdy
LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJx
X29iaiAqdXNlcnFfb2JqKSAgew0KPiA+Pj4gKyAgIGFtZGdwdV9ib19zeW5jX3dhaXQodXNlcnFf
b2JqLT5vYmosDQo+ID4+IEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQsDQo+ID4+PiArICAg
ICAgICAgICAgICAgICAgIGZhbHNlKTsNCj4gPj4+ICAgICBhbWRncHVfYm9fa3VubWFwKHVzZXJx
X29iai0+b2JqKTsNCj4gPj4+ICAgICBhbWRncHVfYm9fdW5yZWYoJnVzZXJxX29iai0+b2JqKTsg
IH0gQEAgLTMxNyw3ICszMTksNiBAQA0KPiA+Pj4gYW1kZ3B1X3VzZXJxX2Rlc3Ryb3koc3RydWN0
IGRybV9maWxlICpmaWxwLCBpbnQgcXVldWVfaWQpDQo+ID4+PiAgICAgICAgICAgICBhbWRncHVf
Ym9fdW5waW4ocXVldWUtPmRiX29iai5vYmopOw0KPiA+Pj4gICAgICAgICAgICAgYW1kZ3B1X2Jv
X3VucmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4+PiAgICAgfQ0KPiA+Pj4gLSAgIGFt
ZGdwdV9ib191bnJlZigmcXVldWUtPmRiX29iai5vYmopOw0KPiA+Pj4gICAgIHIgPSBhbWRncHVf
dXNlcnFfdW5tYXBfaGVscGVyKHVxX21nciwgcXVldWUpOw0KPiA+Pj4gICAgIGlmIChyICE9IEFN
REdQVV9VU0VSUV9TVEFURV9VTk1BUFBFRCkgew0KPiA+Pj4gICAgICAgICAgICAgZHJtX2RiZ19k
cml2ZXIoYWRldl90b19kcm0odXFfbWdyLT5hZGV2KSwgIkNhbid0IHVubWFwDQo+ID4+PiB0aGUN
Cj4gPj4gcXVldWUNCj4gPj4+IGZvciBkZXN0cm95aW5nLlxuIik7IGRpZmYgLS1naXQNCj4gPj4+
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ID4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+Pj4gaW5kZXggMTQ1
N2ZiNDlhNzk0Li5iNDZlNjdiMTc5ZmMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+Pj4gQEAgLTMzNiw2ICszMzYsOSBAQCBt
ZXNfdXNlcnFfbXFkX2Rlc3Ryb3koc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gPj4gKnVxX21n
ciwNCj4gPj4+ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUg
KnF1ZXVlKSAgew0KPiA+Pj4gICAgIGFtZGdwdV91c2VycV9kZXN0cm95X29iamVjdCh1cV9tZ3Is
ICZxdWV1ZS0+Zndfb2JqKTsNCj4gPj4+ICsgICBpZiAocXVldWUtPmRiX29iai5vYmotPnRiby5w
aW5fY291bnQpDQo+ID4+PiArICAgICAgICAgICBhbWRncHVfYm9fdW5waW4ocXVldWUtPmRiX29i
ai5vYmopOw0KPiA+Pj4gKyAgIGFtZGdwdV91c2VycV9kZXN0cm95X29iamVjdCh1cV9tZ3IsICZx
dWV1ZS0+ZGJfb2JqKTsNCj4gPj4+ICAgICBrZnJlZShxdWV1ZS0+dXNlcnFfcHJvcCk7DQo+ID4+
PiAgICAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0KHVxX21nciwgJnF1ZXVlLT5tcWQpOyAg
fQ0KPiA+DQoNCg==
