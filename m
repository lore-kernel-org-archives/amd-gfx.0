Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4936DD19511
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 00:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABEBF10E19E;
	Tue, 27 Jan 2026 00:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DJDQNSLS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65B710E10B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 00:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVudmlxF6zRZKheRjIiL5NOswmrCu0+0BN7tfARbU9K7LSx8T/fwfT4ZfwH04VGtjDRPsAeIMLI99G6KS4ZPVOg+YwE0oolGLYNMwFQrtDYu0I81crnTNK1jPXr7U8DmgVXwKFyeUUbK3Itgw836c2G5CnMI6/SGiIxUbTWe8dKT5erR1anqGJwRvKKdym5/47nfR9o1Ylgd/+8tBk5ruYaN2pVaLD01d2yD100/8mbcUqvZ/COdAb27KY03ag+z7qMZeh2WA9cfn0nzS4beKLDcWZ9konwJZ7bT35g3D957n3tQN6EIVwgL91/WXR65WHtSeRjMDpj41JeK9asb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYX3+8xKCn0mZDYhSppsU6LLaTGhWN8HMLVnE3Zvgxc=;
 b=ZBJdJR2a89M8InNKMo5cQ/r7DN1TChxMwCaJxrTDxs1DLJct7SpAyA2FVKq5vD860nof1WwzxyCcrq280ZmtzAawPbLUCkttgyKkpDiABiM/LPplZyyZEwNkA8kS5tmBrqSrKHwT792DEFHhb0nP2ki1AN6BA6wCKdrz1zET3B7N4q5onEOwRpmRlrH1061i1DXE12cqc6RYTjUl0Y9JbLg4lBtgDy7L3HgLIvYFABvXaxHrq9rDUHCoTno9m2rtj81FeUTSSj/3pjsyR7euOtL9e71dOtIvjmfZEiRzG01Bpwd9RK/O+ghccRietx5TafWuJHj7/qCLiJhZDc5LAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYX3+8xKCn0mZDYhSppsU6LLaTGhWN8HMLVnE3Zvgxc=;
 b=DJDQNSLS9tywic6OR8rg8w9+J+x4mM3TqVZQeV+9Qx0cru6INoP+j52ODw84RrUW1AZei/Sy0btuowTwvmSqghjwMvaYEE42+rez9y2ytwqcB16OGRpJbNBQc5kraqdL2RoNvYBm8I799PBdf2vo3C4BRMFOG08FvSS00/YMAL8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 00:34:11 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 00:34:11 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 04/12] drm/amdgpu/gmc9: handle gfxoff in interrupt set
 functions
Thread-Topic: [PATCH 04/12] drm/amdgpu/gmc9: handle gfxoff in interrupt set
 functions
Thread-Index: AQHcjv+AVSBSWxY8iEe4saDT2oaC2bVk7GKAgAA+duA=
Date: Tue, 27 Jan 2026 00:34:11 +0000
Message-ID: <CY5PR12MB636943817E0F03241FFE41B9C190A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <20260126200747.13527-4-alexander.deucher@amd.com>
 <CADnq5_O85fxWHXXcEqpJL9oE-QVLsbXNZkaP0TguBxom2zKpYw@mail.gmail.com>
In-Reply-To: <CADnq5_O85fxWHXXcEqpJL9oE-QVLsbXNZkaP0TguBxom2zKpYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-27T00:33:18.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA1PR12MB8078:EE_
x-ms-office365-filtering-correlation-id: 6c7af8d4-365f-476b-ea66-08de5d3bca76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MDVDeGhWWG9zS0Y1ZHY2STR4bmlqWEsxNEZFMlcrWE82azVBZDgvanhGVllX?=
 =?utf-8?B?cVkzQTZVZWJudDVseEI2Wkxua2lCejRETFZ3TkJJcnQxZ2JoRFBicmtnZW9G?=
 =?utf-8?B?M1pxYlk2MFZrQTlSTmd0KzlnS0FuZFIyeDR6alRFRDR1VHZqZTFndDZ0dG9Y?=
 =?utf-8?B?ZWFqVEpjRnYzMVg0UEwvZm1iWkdGZXlKa3hIZ2hXME04Wk9abStZWUxlZ2Vh?=
 =?utf-8?B?K1pCbm9IbFB6SmlEVHU0bjBYbVNubkg1L2s3YkVVZ2lVZDlzK2t0d0lQeFYv?=
 =?utf-8?B?MWplSjQ4Vm5KWHNKb2QzV0NjS01uMzh6M2VyQzVlL2M4MVN2endSa2FsSWh1?=
 =?utf-8?B?MWR4RDYwU2ZSZk8wSlQxQ0N5SUQxZ0tpRXFEQVIyQlJTSlpBNU1hN1lwM2Rt?=
 =?utf-8?B?U2xMUWxaU1RJZVpuRWxQdFc3RVdqeGQ1Zzl4UmMxYUlVUzJWbHNlNEJBbDNv?=
 =?utf-8?B?Q2JoV0VEMzl6UWh0YTJETFI0WTR1WFl1dFZEcHZvazl0MVdhWmlpNThxcEVm?=
 =?utf-8?B?eUhTU2I3MEZLRHI5VFdUL3d2M2tRTVlVNi8rSHRXN1Y0THZHNXA5R3JZejRG?=
 =?utf-8?B?bG5XcVJndWd0RDNJNXFjRFhXSVVxYitYdmZRbVAySXRMSWdjQ3IzMUpXRWF4?=
 =?utf-8?B?QzY0NUoxRXVhVlM0S2orZXFvVldTWFRyekJaR3gwUS82UlUraVVPZkxRZnkv?=
 =?utf-8?B?UCtNNjBNdk9paWd3c0FHeG9FYS9hZWVvcVEyckxEUnFSRlU0US9zOTV1UW9W?=
 =?utf-8?B?UTlSRnc5aU15Uno5NDk0RmxiQStlOHdZVjd1MjVmQmJzSFhxZXFtcUlqKzd2?=
 =?utf-8?B?TDRPcXM2UjNpTDhKL0VUalRwYW51aVpXNGYvTzVPdlhCYUVQWk1VMjQwRXBG?=
 =?utf-8?B?dnVHd05JMmt3TklZOVhBYkdqdWdnLy9qeWhIdzY0RU42MW5DanluY21zQVVT?=
 =?utf-8?B?QzdiUHVUWE1aQWtkbDZZQXlzOGgzMnlMbTl6QVVHMHdMekJaUGhIZExIY2Rq?=
 =?utf-8?B?KzlDV3MxdkxSNjNxeFVOM0IzU09waWhYUnhWRVZMYUJtVVNCdkIwWkcxU2c1?=
 =?utf-8?B?enpNaG9vQjdhNTQ2Tm1FQjBpSUprNzE4RTRRUXJRRjR1SDYvWkk3bVp4YklP?=
 =?utf-8?B?cG5KYVFtTjdLQWZqa0IwNjV1bjA4WHllWFdkNWI0a0s0NGRCelV1MktaUG0v?=
 =?utf-8?B?dVpzd2lWR1JGZ3FhWGttVU9rNENZMHZQZWNjVXg4RGM3QXY5eW9XOEtWbHAx?=
 =?utf-8?B?YzBRYzlCY01Fc3hZOVpjdEJKMjNVdlc0RzIxbklxY3FBSkswd2Q0R3RyVlY4?=
 =?utf-8?B?MUZWMndXR1FRTGJPZlY4akx2c2x0TnJzaXhSaEZWZjBNUFQzRkE5TFJUTkNa?=
 =?utf-8?B?QmVqUHlQZ3o4ditWQlJMeVhJRWFUKzRDanF3dFo5Z0tGSzRqNXBQbUNvNVBB?=
 =?utf-8?B?VllTWFkzVjdsSk9XNDgybWZpa1F6SDlqT3BTWnZrNWE2YU8wSElJOGVqWms3?=
 =?utf-8?B?dDg4eTZYcnVjSnBsNlMvYk1vT1JCZjY1UlBPSWprN3NhUUx2OHlML3VkenJr?=
 =?utf-8?B?OUVKbFJubVBtTCtNTWQvdXhBSnphTS9BRGZST1Eyb0M2cjhZdVJ6TUE3b0Qx?=
 =?utf-8?B?eHp6S0FPMjZCQ3hBQlZFWTEyWUpTOUNwTG5obGNGVC8vRzltQ3Zua29OZ21j?=
 =?utf-8?B?KzV2Zjhic1dEWmJpZHZ5QWNYbnluM2VHbjJiMWo5S1kxdHFteU12dWdCMVBT?=
 =?utf-8?B?eTlCL2E1RHlFZHBsakFGd2MzVkhsMXhBbU9DcmkwZVRFeVdmNlpXa0Z0Mk9i?=
 =?utf-8?B?eEd0QU1yRk1abmRYb2NTUmZCSWN4dG83TzRYK0xmVVB3SWZaNnM5dU9Bd3h4?=
 =?utf-8?B?SHM1d1F3RjBFM1ZVc2tHV2hmMDd2V2V6QWdoOUduMm9pTHdCYk9BSVBiWFEv?=
 =?utf-8?B?by9ZS2ovR0hYWXRCUURpVkhqMnpGNFdoMGdQL3FweVJYMmNqM0JwaTJRTVRI?=
 =?utf-8?B?TlFpbU1Lc1lwWUNiVWh1SDc1ZXowZUwrMWdEaHlnUGtqWitpRlRZQ3FwN28y?=
 =?utf-8?B?bXgxdForaTkzRE1OU0RTaUFrTXp0ZVowbGQvNlI1Zk01NDJYMDEvRGhqM1VO?=
 =?utf-8?B?SHRqWnRXRkJRcjVmSGpLdjM0SzJPL3FNempmd0dLbWlVSSt4SHpadm5TTWhw?=
 =?utf-8?Q?5cVNpPflNhxTEC+14uCJpc8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0lUdTBTcXFkL25paG0raVo1SHh5SGRaakcwUGNPdFhIRnU3cytTTGpmaTY2?=
 =?utf-8?B?Z0xNa3REQXpTU2R0d0czSWJ6UVFXL3AwTitURnZ0TUFpdm9VN3YwWGlBZ3VE?=
 =?utf-8?B?V0lpdmVQQzVVbVFpcnV5b1dNK29IRDl5bTV5VlVJQWVkekxzekdwdEFVTGJ6?=
 =?utf-8?B?eWU1WGVEcUpxOU0xcEs2Vy9PVG9aaGw2akRacWptTEk2Y0VHaWJ4VC9kYXAx?=
 =?utf-8?B?cG4zUE9ndFJhTUJLS1FKVTBla0EvckpLdWZEQXhQMENXVW50UUxRaFQ1aUZx?=
 =?utf-8?B?blVaejIrSlN3YWpoa3QzbndKYWtFYXorbmY2Ukp3OXJOb09rYWw4TVhteXhC?=
 =?utf-8?B?NjFuS3h1Z3hXZjJueHdha2l5Q1Y0T1dFTktHV0JIRzlCdmw1YU1Fb1RkSyti?=
 =?utf-8?B?NjhJWGg4c3V0OS95NFFKSmh1akhwc3M1SllqbC9FQXNqT2lZUE9rZHNKSStN?=
 =?utf-8?B?YW5Qb1A2cVZCNmpBaThzWkRTblVEWTAwbjY5cEFuRkNYSXl3K2VKbUM1Y09j?=
 =?utf-8?B?RzFHcHhUOStWV1UxTllNSm9iODZFT0d0b0FCTXNUYWtvbkZaUXQ5M2lhV2Mv?=
 =?utf-8?B?S29oRjhTMzZyQ2RCSkYvbnFWUmZ1R2Q0K1RTbnRnREk4SEMwUEhOZmdDU1FR?=
 =?utf-8?B?WnptNnZydHNyam0zZGRFMDFHcjkzSEdINWFoK21Nby9CaWwrUjkzWEVMek9w?=
 =?utf-8?B?Tm5rNi9ZMWNTRGdZazhxOFU3UUdOakJ5cTlGRnNZZ3hFdXo5RStkcERoMERN?=
 =?utf-8?B?ZVl3VGZtMm9XZHA0ZXZtMTVTMS9rajg0TFExSFdzdi95b1Q1aVhYbWxoQlpt?=
 =?utf-8?B?V3BvTGNTb2VhajdKbk1UckRNdGFDNkNrc09uS1FtNUpzQXAzNVBnMHBzRXow?=
 =?utf-8?B?SnA4WkowNXVQMlJRUkpkdTFaa2RldTU3YTlyWWo4a2UwUFJxNFJMVjFiaWta?=
 =?utf-8?B?SGdxOWNxNFZXV3kyYkNDQ2R2R3A1YU9iTDRqQXlDTXhXSGhMV3RINmRYWTJi?=
 =?utf-8?B?cThzSkVoK3p4dTNPKzBneEVPa2dGdlk0Y2o1ZHo3ZjlyUFpjbkYvN0UvZnNq?=
 =?utf-8?B?T3J2RGpZTjY2a3NPQ2k2clRxcHlIMzJydm8wd2liUGhkQlhsL2JFb2ZhcVhN?=
 =?utf-8?B?akdoWGk3K1pidEtUUHVCQWhjQkppd282c3BQMlhIaXB3R29wVzdDanJ4VWl6?=
 =?utf-8?B?Vmt6S0RqbkZWRW1nZ24wN1ZyYU5xQ0xmcjZGeFhBVEFMQ2xaYjZGV1dzTmRr?=
 =?utf-8?B?V2ZoNERPb1NRSEhjRlp4QUdpS2RRbm1pTHJ4cVJOaXF0cWphd0tTbmN3UWdL?=
 =?utf-8?B?TlordGpibXBpcnpjWW1KejFyM3JSQnFNelJqZDd6UXgyelIra0tkaGtsNWo3?=
 =?utf-8?B?a1NaY2JGKzBOUTBtamhvcHVKVEFvT3AxdWJkc2ZFc3RQR294UDUxVkNDMmpl?=
 =?utf-8?B?dTBwUVYvWUZPeHFrWHdVVmgyQzZpRVI1M0ZCQndTSDBBMGk1a0MvWmNGZTRC?=
 =?utf-8?B?dm1abUdqSE8xMzl5SkJEMGZYN2NWdFlLYmdrWE9FTko3RnowR1pNNjFTdVhC?=
 =?utf-8?B?U0tCK05CMDRMZTJkdVlwNmJHcXU4UXdoSnY0K3NoRFBVeUhyRzg1a3Q1TTBz?=
 =?utf-8?B?WUY3WC9qVjk2L0dWc2t2cEozR2V1VGhFYzBadEYxY0c0amxZdnV1NVNlZDJF?=
 =?utf-8?B?bFByOWVxcXQ2c1BFYXBTdXQwSWR0bzlvM0pLSyszbHYrdjdNajBKbkJOdmpP?=
 =?utf-8?B?ZFJ2bzIwL2w0dWVwY3ZqeUlQd2RuZWkyUk9UMmVZSHlGcW9UcUIwckQwZHFt?=
 =?utf-8?B?cit3VFNXWS95czFOODZ6S29rbDRXekN5TFp2cUNaVFhFVlhQK0FPWm1JcmlF?=
 =?utf-8?B?cTVKbkpOclNMODYrUWkvMk1uemN0VTk4VlUwMk5vN1pZWWFBbHREYzY5UFZL?=
 =?utf-8?B?c0pZd3pVRUFQTEFNb2FVU2FYTVZoNVFJTnFnN0FLVTAxVm5BT2U5U3pYcjc3?=
 =?utf-8?B?SEVXdlFKaVRyUEtRcnYwS1FEZC9UYXpHVVB2VnkwU3M3SE5acDluWTgrU0Fj?=
 =?utf-8?B?eEhPTFRZYkNmK3VkbCs4aWYxWUIxSGxuWERaTCtEMllqc3Q4c3VrekdkbFRj?=
 =?utf-8?B?enNJa0M1SExOVmd6QnJjTTI2VFRVMWJmWXNMNlV3bGJ5MmZxRG9KdmR0SjVj?=
 =?utf-8?B?TDFxS2ZMejdCRWtTdlBOYk15ZEZFcERlTVh0WnFUSVpKK01iQXo3M3ZTSTJ1?=
 =?utf-8?Q?rnpQOJk8m9/sh/jP+48yhkz9Edc8khx/huHDXAT8zg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7af8d4-365f-476b-ea66-08de5d3bca76
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 00:34:11.4395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eyfBh2D8UkGMoZBA03JsWaCBx8cRmR5FkFrsvLyxU8wwF0VuWdNqsGF/GTkr9Hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

W1B1YmxpY10NCg0KVGhpcyBzZXJpZXMgaXMgOg0KDQpSZXZpZXdlZC1ieTogWWlmYW4gWmhhbmcg
PHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUdWVzZGF5LCBK
YW51YXJ5IDI3LCAyMDI2IDQ6NDkgQU0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpo
YW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDA0
LzEyXSBkcm0vYW1kZ3B1L2dtYzk6IGhhbmRsZSBnZnhvZmYgaW4gaW50ZXJydXB0IHNldCBmdW5j
dGlvbnMNCg0KT24gTW9uLCBKYW4gMjYsIDIwMjYgYXQgMzox4oCvUE0gQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4NCg0KUGF0Y2ggdGl0bGUgc2hvdWxk
IHNheSBnbWMxMC4gIEZpeGVkIGxvY2FsbHkuDQoNCkFsZXgNCg0KPiBOZWVkIHRvIG1ha2Ugc3Vy
ZSBnZnhvZmYgaXMgZGlzYWxsb3dlZCB3aGVuIHdlIHRvdWNoIEdDIHJlZ2lzdGVycyBvdmVyDQo+
IE1NSU8uDQo+DQo+IENjOiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDIgKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4gaW5kZXggMjU2OGVlYWFlOTQ1NC4uN2E4ZTg2ZWZkZmU0
MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4gQEAgLTY0
LDYgKzY0LDcgQEAgZ21jX3YxMF8wX3ZtX2ZhdWx0X2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2lycV9zcmMgKnNyYywgdW5zaWduZWQgaW50IHR5cGUsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBhbWRncHVfaW50ZXJydXB0X3N0YXRlIHN0
YXRlKQ0KPiB7DQo+ICsgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7DQo+
ICAgICAgICAgc3dpdGNoIChzdGF0ZSkgew0KPiAgICAgICAgIGNhc2UgQU1ER1BVX0lSUV9TVEFU
RV9ESVNBQkxFOg0KPiAgICAgICAgICAgICAgICAgLyogTU0gSFVCICovDQo+IEBAIC05Miw2ICs5
Myw3IEBAIGdtY192MTBfMF92bV9mYXVsdF9pbnRlcnJ1cHRfc3RhdGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgICAgIH0NCj4gKyAgICAgICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIHRydWUp
Ow0KPg0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAtLQ0KPiAyLjUyLjANCj4NCg==
