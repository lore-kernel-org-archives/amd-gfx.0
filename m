Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EEBC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492D410E876;
	Wed, 24 Apr 2024 02:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="thmeODUQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E5010E5B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib5Tkl8SlrkJDWcQijh9i5Dpu4mgO5S9Jy9sLxdlFnmIOHwDbGFV03E5KXYq2QlQFwUT7eTDDzUxYxSp076wO5FsGoNTcR5dBcwQFjM8nklQl5/Gu6IzvA0ef+crn/ZG90iLpt93kvcBa7TmclOhr3RSkXnFxx5dAEykdJsyGZi+m2+0aeQjPoMisKQJOEU+DoyGkZAi5PUIpOgxBAsPFiGMeFVEXl5Q6mH+qTOS7KTURrfxA+KbATiMXiDwxXSvbAgr22W8+/Y8hb3yywHvAP/rtKKiNN2X3TUEVfETCnQqVmhQqgKjPXSOI3qeuclF8LRvWqMTlqhmUgC6TWuamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5OIpDy8ERslVaaIHxzTDtC0rh0z3RhzPlRK56WXm78=;
 b=YyBnHDf6s4oGuCEiPu6Pv0RLU8KDgrA+qci9zMqCZ4pgtzwdQkNbMiVfvvGdMJpq2Otz5lehEnTjvXHo9vvD6fKIXKwKyD/ry8POaUpzYlnSNSK29eVXoJ1yTEBAWf9EmXGp3GlFj9i2TbEu61jDnAoM28BlZqod9cQjTrcMJqMHfTvYiVu+EsU5KlcMGRkZ4hbnL3/220b2zjickPOQlu6BMz+D3uc7xuXzPV/CJvAGfQPrx94LwFpuEQmo49/ziGsjtTLbI3MRiGi4P+sLRPTbT7xQoyCMX/BIYKrJhEaWLvrQMKZHBtCUBUz4KPufeb/8uScxGHUWitVmEQ3tFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5OIpDy8ERslVaaIHxzTDtC0rh0z3RhzPlRK56WXm78=;
 b=thmeODUQUyQqZb0Hvud7XxwiDtdoR5lupo95YshYdrQRw7KCp/nidDVkFRXKCJ1v7Nl9S6HtVS45I8u2+Esj/ridX1v13tpkvdHp4t1aIUkRMYaSCXlRQ1QeDb4vWh7vgW9ejpRTWMYcMuWkCqAyFxP4zoxpoyxgIvCwu2ozHDk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 02:04:48 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 02:04:48 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix some uninitialized variables
Thread-Topic: [PATCH] drm/amdgpu: fix some uninitialized variables
Thread-Index: AQHaleWF+rdzkt4Ck0q7cDyMcLHlbLF2pn2AgAAB/qA=
Date: Wed, 24 Apr 2024 02:04:48 +0000
Message-ID: <DM4PR12MB5152BC1A6ECE3A5F86B55667E3102@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240424011940.723906-1-jesse.zhang@amd.com>
 <CADnq5_MZeCg3dUnkCmKXu-m1Kp01yR0h1uz2htKoWaQdbj-+_A@mail.gmail.com>
In-Reply-To: <CADnq5_MZeCg3dUnkCmKXu-m1Kp01yR0h1uz2htKoWaQdbj-+_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3df04eba-88bf-4ea1-a646-9e74ee3cd070;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T01:53:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB6562:EE_
x-ms-office365-filtering-correlation-id: 8dae441d-4b37-4cbf-872b-08dc6402ebb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?VHJVV3BRWmFyWmlKVkFYd3djUmsySmRReHJkNytmbkRYUDZsQ3NGQWZnVlRu?=
 =?utf-8?B?QnR6UkxWRVo5VGdnS251Y3hoR3NjM3dEdHlmL25ta2MrQnpCVzRqazdZRE0w?=
 =?utf-8?B?SnhEbXp4d05mQXhRZU1SbmNLcUxvcXpCeG05TDBWbDVWNVVJNmx0WGRiUEYz?=
 =?utf-8?B?dnFkUGZBZDRBdndEOFJGOXVtVmFCUVBIOXRYMmpaT01CdDdpQ1QzM2Z4Vi9H?=
 =?utf-8?B?MDBNNGJXNEQzSGt2SStqWFhYVmJFMmI1UW90RFg5Z0dvOSs5bFFndEhBa2lY?=
 =?utf-8?B?SGtKOGxNWVdvVSsyTGhMS0IwSU9VOUxQMzJFVUM3VVAxQnp3cmNybVNEUER0?=
 =?utf-8?B?QzJEck1yajlIc2djZWRycTd1NWJHR0l2NHVSTS9qMk81RWRDOThoaU8ycVhT?=
 =?utf-8?B?T21mdTZ1dkFuL2JORlZpL0xCOGd5MzAwS0xyd1J0bXZQbGpSYXhXakxLdVZl?=
 =?utf-8?B?SWNhNkdISk5qM3VZNDAxdFkvV0Y2d0NtQitCNzF0UU1KKzhLcWFPVllzMisy?=
 =?utf-8?B?UHJ2QWdHWHQzdG83aEhTM3JMTTZydEkxVlhNbDRydkwwcDFQRnFUL1poL0xz?=
 =?utf-8?B?dzkyU1kxZkNsVDlOSGZHOUlES2FGYnNIU0Z6cE5jR2pNRG95bG44K3RNbUtH?=
 =?utf-8?B?NTRsOVQycHRnRUw3Yjh4NzFxczI4RmFheXZ4UEQvT0VPU0hTeWFISEZlcU04?=
 =?utf-8?B?YmVaQjdaZHhMWGdUdjFIWkdyL1AxUzdCVDhFTC9BL3pnbzJibUN6RGRqMmRG?=
 =?utf-8?B?NzBRMnAvdFNuRXRrWUFzbUxxbEJjSDBCZHp4U0xoYWtZZUQ2QlRQWkpkVDRR?=
 =?utf-8?B?UUVpWFhiTDBvR0tuRUpYeElDcFNJY2JhblpkeDRnTmpLRVduNTRDNVkwZnor?=
 =?utf-8?B?RUtJVnVjalJDdDVKZWdYSCs2NDBnTk1HUjNDU0V4V0l3RTV0TEFLZHU1b08r?=
 =?utf-8?B?OG9aelc0OWZCbGdLYUZOYkUzeW9PckgzTFZKYkxENkNRUXoveUVNQUd3UTEz?=
 =?utf-8?B?aXFDNGhqcGd0am9GSDRsOEdFRTQ5QVowMUJwL1JMRlVHdHlPRXp2SC9HNnB5?=
 =?utf-8?B?bW5vSTRxYk53bnlCTTBocUNPSFVSMGZBL2QzZTNncE94OWFya3FINXQxV2lq?=
 =?utf-8?B?akYwMDJKTllpT1MvTXpNRmd2MWsvVjNpR2VQVzVjWkVRQWh0dG5qbncvejJ6?=
 =?utf-8?B?dGxzK1hiV0VRMjZ1dWU5bkJSYzEyZy9UWlFNTnpLS09sTnNXdzB0Z2paZXFl?=
 =?utf-8?B?bEdDcU4rSmc0Rm5uOUdIdTVuYmw1ZXkxNEo1NjBBQWcxVHVJeXgwd1Y4UFV6?=
 =?utf-8?B?a2JuWHVacnhBUFJWcWFOaHFSUzBjUDRpL01TUWtjaWw3WGxKK2V0MWV0V1hS?=
 =?utf-8?B?THJLQ0o5bEt6NENFR0hYMTFEaGljSERxL3VZcXFBSzdYWnp1UXc4S1lrVXpC?=
 =?utf-8?B?bnVBdEVYZ2Y4UEQ0ZjBVNzVic3BOcm5rZ28yWUxPT2Z0YjI0VmJXa1NvV1pw?=
 =?utf-8?B?aENHanV3ZU5KMDlUb1lVV0F3Z0dpaUZjaTBZdmJ6SjFoQ052cjZTSXZGeXlr?=
 =?utf-8?B?ZW82REZRNzVnUGJ2UlltTGJteWlXVktHdEFkbmtLWWl0b0lnNlozVEtraklp?=
 =?utf-8?B?WVNzd200aFhNNTA1ZHF0Z0ZSekVrSzRXek84SXVTS1lQaXBHNUxwYWdHRWI0?=
 =?utf-8?B?UWNTYWFYblg1OWhnYUU0NTdQTE1sRm0yZjJWQnFBSCtJcDBhblhRNllrSDBB?=
 =?utf-8?B?WjkrdDkvOTUyZmNuOTkxUzJSb3Z0bTZHMlhyVm5MSzRwVUYzaWU4bDRHVDI5?=
 =?utf-8?B?d3l4NDdhS3gzSFN1eno4QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWpIaXFFWkVMUUd3dzNyTnFKQWduZjN2UVlhazAyYzU5VGJEYjloUzAvUTZD?=
 =?utf-8?B?MmZqMWNWWm0vekVvSDhYZHI0N2U4TUp3c1ltN095Y1VBRWlJQktNNmJwbFBH?=
 =?utf-8?B?ZlQyK1Z4SVZXNDdZTWVQd1VaWXA2Mm9UY3ZPSVF0Sll0OWR3UEpxZEp1MFdy?=
 =?utf-8?B?UC9FRkZ3YmkzaXdGZWFNYmthMG5UMG03MDVaU1Jqb3R1ekc2ZVNwS2NlYlRs?=
 =?utf-8?B?MkkxbGNpU3ZMZXY5TFlzVDZDMXdHWTdmMnhRNEN1ZUx1YUw3RWF0S2MyR25q?=
 =?utf-8?B?SVpHenl0Q0M4OEZEblI4d200dE9IU3R1djdWUUZmaERRcVBmUWZMd2VlTlFN?=
 =?utf-8?B?ZE4yQUVNWThZWlUrWENZTmU3bDZUWXdZelFoS0I2NXVveWFyNGpuVE4yajVn?=
 =?utf-8?B?OE1KZkVZbWxNR0NWeUoya21Ld0JPeTF4WlRLaENkdzREaWF5TWhVd0ViMzVy?=
 =?utf-8?B?TkNkYmZ5WFBpbjVNSEVKbE5ScG5MTFNRVzBCRlRrWWVLM0FuTTlONllnUXJx?=
 =?utf-8?B?QkJseDRuSDhLYThxZmFVdEJZODl1bERiVFZWcDJUaDlqcjBjREhIeGR0Ull0?=
 =?utf-8?B?NlZyOHlzYjgyVFZMLytJSWtnVjBWb2ZmcDlmZ1d3SFUzSUpzOUthREZROGdF?=
 =?utf-8?B?Zmgwc0pEaUdtbkkxWkViQzg4L0FtU3VDb2pJV0YxazRZWXRMSExqRmVnakMw?=
 =?utf-8?B?OVRiK1hTVzAwVmlyeHpXN0RRZnN5dkM3V3ZvUWpqaWQ5M3BiV1RGTEg5R2pT?=
 =?utf-8?B?MFZOcm4rVzcxOGowRmZNLzA5WHpxV1ZSaWx4bkRKQms2TFFsOU1hQ3ZZQ3Nl?=
 =?utf-8?B?R0Rnbyt2TEZwVDdTU2Jad3o5dnJTeGRHNEVNOEl5bkR6UVorUERZcCt4QUIy?=
 =?utf-8?B?R3YyR0x6TkJJM3IyemJvMEJtV3pzeWp3L0w2Z3h1cFRLYUFTdnFRMGtsYmhJ?=
 =?utf-8?B?L0hxaFJvMEtXZ1BTRnVrZExSNnV4VS9UcmRJVVcyanFlN2FjUmNQbWhja3l3?=
 =?utf-8?B?aDlUR1dxZHcwWCtpUDlWdEFYelJ5eHF1SlA3S0xCWUtDRWprZmRTRkxHbzFa?=
 =?utf-8?B?VWtyaEMyVG9mT1dScFlkbnNvSk5leU5HN0NkZWZtUzBBbU16MTdNcWxlaU9N?=
 =?utf-8?B?SlU3T2xrZThlVzJTYnUrMnVUdWRMSFNCVUhYdVFlRm9TTEx0RkpzOEdLZkU5?=
 =?utf-8?B?WUcwM2tKejdZd0ljN01PUE41Q1JFWEU2MDBwb3VGeU03MDRTL2JWTHJDbWNh?=
 =?utf-8?B?V3pCQ3ZvMEduWktuc0ErVXdjMDA1Vmd1Z25RQm1pRHU1Zm9KS21oaS9rVTcv?=
 =?utf-8?B?eDg4YnZwYVhLNkxzQ1hCQXY0eTVEUTdCMzVKLzdQL29QVWZ3S3RDV29tL0FB?=
 =?utf-8?B?MXdKVzZHaUFCMTNYNUJiaVJkTVYvMDRtWkFibmlUcWlYK0tCR0xVTFR1N0tC?=
 =?utf-8?B?cEI0ZXhkMTFuVm1uOGZMRE9KRVVQSHkzK2xkMG4wRmwvVVJJNHBaYlN2VnAw?=
 =?utf-8?B?ZUMzbHlsS0JiUWNvUlNjZ0tjUW5UL0VMeUVZR24yMHI0N2NyZjZ2NFlJTFpm?=
 =?utf-8?B?UEwxVnQyZHR2M3Q3MmlJd2krUXIvWGN5clhMQ1pxZGMxUlJsVzhGUVoyTjJh?=
 =?utf-8?B?eDY5empDVUppMlNpdkNJS2l3Mjk5NE8zbDlUWkJvUVZZOSt3WnB1Z3lhbnM4?=
 =?utf-8?B?TUxQZjgyQ3hkVVF0UVRwYmQyOGVzbVRnUGtiZFJpQlJGOGlXeUNBWGNGOVZ5?=
 =?utf-8?B?RFlnTkRlTzNubkNwSFZoZ3I4R25LUkpFVTNxSHZ2c0oxOVhFZFpGSzVTajVM?=
 =?utf-8?B?anVDNGliaENwTGduZ3IzTzBUQzYzMzZSZTFzdWFtQ3o3eDJUYk1vdjQwMm1s?=
 =?utf-8?B?TU5LdUgxdXk0Z1JaSHQrMlBVd3preFE0NUhTc0xDRys0OXNidzRscnpDWHJX?=
 =?utf-8?B?Q3hzT3NadFJaQ1ZpcnVDZ3VYQlZ4RnpNTEdzNXllZ29GblFKdWd0RGZPOStR?=
 =?utf-8?B?OW43cHhOUEdiL0oxYXBXS3NCNXhkaExydXczRGRDT3NVbWJjOTgyeFVxUjJW?=
 =?utf-8?B?bWdvelVCSmhTK1UvZHlEcXVpYUkzN0JtSlE5bGhtc2UxNWQ2RlJHbHJKKzdl?=
 =?utf-8?Q?CIE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dae441d-4b37-4cbf-872b-08dc6402ebb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 02:04:48.7010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HL/eLdBaPJXAy1XxpLxnnznLGuQn8MHNN5ZmkHuseK6TQTAuIcl2wJGt0DWf6JS8SRYgrlJ5hjSDqJIQYVNb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWls
LmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjQsIDIwMjQgOTo0NiBBTQ0KVG86IFpoYW5n
LCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgSHVhbmcs
IFRpbSA8VGltLkh1YW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBmaXggc29tZSB1bmluaXRpYWxpemVkIHZhcmlhYmxlcw0KDQpPbiBUdWUsIEFwciAyMywgMjAy
NCBhdCA5OjI34oCvUE0gSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+IHdyb3RlOg0K
Pg0KPiBGaXggc29tZSB2YXJpYWJsZXMgbm90IGluaXRpYWxpemVkIGJlZm9yZSB1c2UuDQo+IFNj
YW4gdGhlbSBvdXQgdXNpbmcgU3lub3BzeXMgdG9vbHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpl
c3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyB8IDIgKy0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jIHwgNSArKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYXRvbS5jICAgICAgIHwgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y1XzAuYyAgfCAzICsrLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIu
YyAgfCAzICsrLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y2XzAuYyAgfCAz
ICsrLQ0KDQpQbGVhc2Ugc3BsaXQgb3V0IHRoZSBTRE1BIGNoYW5nZXMgaW50byBhIHNlcGFyYXRl
IHBhdGNoLg0KDQpNb3JlIGNvbW1lbnRzIGJlbG93IG9uIHRoZSBvdGhlciBodW5rcy4NCg0KPiAg
NiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jDQo+IGluZGV4IDU5YWNmNDI0
YTA3OC4uNjBkOTdjZDE0ODU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZjZS5jDQo+IEBAIC03NDIsNyArNzQyLDcgQEAgaW50IGFtZGdwdV92Y2VfcmluZ19wYXJz
ZV9jcyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwNCj4gICAgICAgICB1aW50MzJfdCBkZXN0
cm95ZWQgPSAwOw0KPiAgICAgICAgIHVpbnQzMl90IGNyZWF0ZWQgPSAwOw0KPiAgICAgICAgIHVp
bnQzMl90IGFsbG9jYXRlZCA9IDA7DQo+IC0gICAgICAgdWludDMyX3QgdG1wLCBoYW5kbGUgPSAw
Ow0KPiArICAgICAgIHVpbnQzMl90IHRtcCA9IDAsIGhhbmRsZSA9IDA7DQoNCkNhbiB5b3UgZWxh
Ym9yYXRlIG9uIHdoYXQgdGhlIGlzc3VlIGlzIGhlcmU/ICBQcmVzdW1hYmx5IGl0J3Mgd2Fybmlu
ZyBhYm91dCBzaXplIGJlaW5nIHBhc3NlZCBhcyBhIHBhcmFtZXRlciBpbiB0aGUgZnVuY3Rpb24/
DQpbWmhhbmcsIEplc3NlKEppZSldICBVc2luZyB1bmluaXRpYWxpemVkIHZhbHVlICpzaXplIHdo
ZW4gY2FsbGluZyBhbWRncHVfdmNlX2NzX3JlbG9jIGZvciBjYXNlIDB4MDMwMDAwMDEuIEJlY2F1
c2UgdWludDMyX3QgKnNpemUgPSAmdG1wOw0KICAgICAgICAgICAgICAgIEknbSBub3Qgc3VyZSBp
ZiBvdGhlciBjb21tYW5kcyBpbml0aWFsaXplIHRoZSBzaXplIGJlZm9yZSBydW5uaW5nIGNhc2Ug
MHgwMzAwMDAwMS4NCg0KPiAgICAgICAgIHVpbnQzMl90ICpzaXplID0gJnRtcDsNCj4gICAgICAg
ICB1bnNpZ25lZCBpbnQgaWR4Ow0KPiAgICAgICAgIGludCBpLCByID0gMDsNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBpbmRleCA2NzdlYjE0MTU1NGUuLjEz
MTI1ZGRkNWU4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
Yw0KPiBAQCAtNDEwLDYgKzQxMCwxMSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29y
a19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5ld19zdGF0ZS5m
d19iYXNlZCA9DQo+IFZDTl9EUEdfU1RBVEVfX1VOUEFVU0U7DQo+DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZChhZGV2LT5qcGVnLmluc3Qt
PnJpbmdfZGVjKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXdfc3RhdGUu
anBlZyA9IFZDTl9EUEdfU1RBVEVfX1BBVVNFOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBl
bHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmV3X3N0YXRlLmpwZWcgPQ0K
PiArIFZDTl9EUEdfU1RBVEVfX1VOUEFVU0U7DQo+ICsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsIGosICZuZXdfc3RhdGUpOw0KPiAgICAg
ICAgICAgICAgICAgfQ0KPg0KDQpUaGlzIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoIGFzIHdl
bGwuDQogVGhhbmtzIGZvciB5b3VyIHJlbWluZGVyLCBBbGV4LCBJIHdpbGwuDQoNCg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jDQo+IGluZGV4IDcyMzYyZGYzNTJmNi4uZDU1MmUwMTMz
NTRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jDQo+IEBAIC0xMjQzLDYgKzEy
NDMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9hdG9tX2V4ZWN1dGVfdGFibGVfbG9ja2VkKHN0cnVj
dCBhdG9tX2NvbnRleHQgKmN0eCwgaW50IGluZGV4LA0KPiAgICAgICAgIGVjdHgucHNfc2l6ZSA9
IHBhcmFtc19zaXplOw0KPiAgICAgICAgIGVjdHguYWJvcnQgPSBmYWxzZTsNCj4gICAgICAgICBl
Y3R4Lmxhc3RfanVtcCA9IDA7DQo+ICsgICAgICAgZWN0eC5sYXN0X2p1bXBfamlmZmllcyA9IDA7
DQo+ICAgICAgICAgaWYgKHdzKSB7DQo+ICAgICAgICAgICAgICAgICBlY3R4LndzID0ga2NhbGxv
Yyg0LCB3cywgR0ZQX0tFUk5FTCk7DQo+ICAgICAgICAgICAgICAgICBlY3R4LndzX3NpemUgPSB3
czsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMNCj4gaW5kZXggNDVh
MmQwYTVhMmQ3Li5iN2QzM2Q3OGJjZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjVfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjVfMC5jDQo+IEBAIC05OTksNyArOTk5LDggQEAgc3RhdGljIGludCBzZG1hX3Y1XzBf
cmluZ190ZXN0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiAgICAgICAgIHIgPSBh
bWRncHVfcmluZ19hbGxvYyhyaW5nLCAyMCk7DQo+ICAgICAgICAgaWYgKHIpIHsNCj4gICAgICAg
ICAgICAgICAgIERSTV9FUlJPUigiYW1kZ3B1OiBkbWEgZmFpbGVkIHRvIGxvY2sgcmluZyAlZCAo
JWQpLlxuIiwgcmluZy0+aWR4LCByKTsNCj4gLSAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vf
d2JfZnJlZShhZGV2LCBpbmRleCk7DQo+ICsgICAgICAgICAgICAgICBpZiAoIXJpbmctPmlzX21l
c19xdWV1ZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV93Yl9mcmVl
KGFkZXYsIGluZGV4KTsNCj4gICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiAgICAgICAgIH0N
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMNCj4gaW5kZXggNDNl
NjRiMmRhNTc1Li5jYzllOTYxZjAwNzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjVfMi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjVfMi5jDQo+IEBAIC04MzksNyArODM5LDggQEAgc3RhdGljIGludCBzZG1hX3Y1XzJf
cmluZ190ZXN0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiAgICAgICAgIHIgPSBh
bWRncHVfcmluZ19hbGxvYyhyaW5nLCAyMCk7DQo+ICAgICAgICAgaWYgKHIpIHsNCj4gICAgICAg
ICAgICAgICAgIERSTV9FUlJPUigiYW1kZ3B1OiBkbWEgZmFpbGVkIHRvIGxvY2sgcmluZyAlZCAo
JWQpLlxuIiwgcmluZy0+aWR4LCByKTsNCj4gLSAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vf
d2JfZnJlZShhZGV2LCBpbmRleCk7DQo+ICsgICAgICAgICAgICAgICBpZiAoIXJpbmctPmlzX21l
c19xdWV1ZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV93Yl9mcmVl
KGFkZXYsIGluZGV4KTsNCj4gICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiAgICAgICAgIH0N
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjZfMC5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Nl8wLmMNCj4gaW5kZXggMWY0
ODc3MTk1MjEzLi5jODMzYjZiODM3M2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjZfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjZfMC5jDQo+IEBAIC04NjEsNyArODYxLDggQEAgc3RhdGljIGludCBzZG1hX3Y2XzBf
cmluZ190ZXN0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiAgICAgICAgIHIgPSBh
bWRncHVfcmluZ19hbGxvYyhyaW5nLCA1KTsNCj4gICAgICAgICBpZiAocikgew0KPiAgICAgICAg
ICAgICAgICAgRFJNX0VSUk9SKCJhbWRncHU6IGRtYSBmYWlsZWQgdG8gbG9jayByaW5nICVkICgl
ZCkuXG4iLCByaW5nLT5pZHgsIHIpOw0KPiAtICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV93
Yl9mcmVlKGFkZXYsIGluZGV4KTsNCj4gKyAgICAgICAgICAgICAgIGlmICghcmluZy0+aXNfbWVz
X3F1ZXVlKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX3diX2ZyZWUo
YWRldiwgaW5kZXgpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+ICAgICAgICAgfQ0K
Pg0KPiAtLQ0KPiAyLjI1LjENCj4NCg==
