Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344B4D6CFB0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 02:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1DD10E190;
	Fri, 23 Jan 2026 02:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFxDXnG9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D6210E190
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 02:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWkfzl++vxvut1/qPVn0hHZ72YnrAjlErYy5At+01TIKDe7+WzDaJ4WZG0Qo4J8f68x8NzRpLe68B8OFEpr8/JoYjejJ+A61pgulGDKAbtFiPMZutMIIG2TT9r4Yk/aqvHJifzFotgaM5js/oTnseE/FrXCpgbmEFbMwRjXlGvPtKetIjEMdfeuF0rjZjoQFeo0qW8X/BP0Lp1+eYFvcRdeig0TBD+dCJOUf96Uut4AqYW0lZep90VTVH6+aHZd/0T6TYAA44zWnZfIU/sJMNvjh/d6VUrdHfM58a4gaYRhxFH69Ct0LsEj4BFiZBnMZZVlWBN+6R4XfpGWjwNADtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYMWQpkIuCfI3yiGG22JqPwReTiKsLByoesqvaKX1To=;
 b=MQttJHcSHlew7HwAGJwMAjE38NsfElXu8kEhPYMAI9H5oB2crNHfXf/uC8+KjzBQKrkHEqkbNa4YwEzlwh/2LsTdHWs2DehtaoKUGmDFaDnblZ3DK2uBudoKU65QxtJPSHB5EuhdvUbR3GnS4EZ4bu2dkMWnn/7/9NO4Uzmsj3zHnbWwTY5nI5yv/JzWSDSp6ZJe/h+H704rSGzZUlB7TENWPsxnIkg5k5nm2pP+HXSxaqG/qfpJsx0B56Sc5ip4PhMQLt30ovEvwLkRY2NUxy0XCsv5Ti3RG2qywICAwzn6s5VJ9+rgIChYuO3dNAHHjOhz1eQ/zCPp/iVGAQJnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYMWQpkIuCfI3yiGG22JqPwReTiKsLByoesqvaKX1To=;
 b=HFxDXnG91ZLTefztHoijGXx9a4RHSk8eevZB6heRC0tno9ps9xRASSWmoQJUwHqQ+YAkwngT4xuIwrGF+sOr6hM+vu8+/qWKpt9fOj9MCvjEdY1DIwMoCPHzUTTtV7CLhSl5AAlaOTCnWsylkK9at7b5EHrENaINNHS/T2yQxRo=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 02:49:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:49:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/9] drm/amd/amdgpu: Add update_mqd callback to amdgpu_mqd
 struct
Thread-Topic: [PATCH 1/9] drm/amd/amdgpu: Add update_mqd callback to
 amdgpu_mqd struct
Thread-Index: AQHci30zL38nlO3Wg0GsCg4si8thxrVene6AgABwDgA=
Date: Fri, 23 Jan 2026 02:49:22 +0000
Message-ID: <DM4PR12MB5152965FB0678823459486B7E394A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
 <CADnq5_Pw1Fc_g2v7q7dLKz0dDWOP=8KZah9BZz+MQcPDrN4Z3A@mail.gmail.com>
In-Reply-To: <CADnq5_Pw1Fc_g2v7q7dLKz0dDWOP=8KZah9BZz+MQcPDrN4Z3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-23T02:46:32.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PPF0A63E7557:EE_
x-ms-office365-filtering-correlation-id: 53f96459-6093-475c-272e-08de5a2a034e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bGt6YWwxUWxNc28yUkVwRkFCVWVLK3gxRldtYXRrbFFYaEpvNEY4U0xPYlBC?=
 =?utf-8?B?Y09zcEhwUU5nRGwxa2FQQ1NqSVhjT2VLeGdhQXhiWXluYXpibFZXZ1c5KzA3?=
 =?utf-8?B?c0tLOUtDMGcrRFZIZ0pUU0lJQ3ZUK2kwbmlZWUQveWRNMktFYU9lREZMYUg3?=
 =?utf-8?B?cWxrc2ZIVW41alJZZmZRU1hnTkhlWkZNc1ZwaUFYQlhlWVFJMkQ0Mjh1cFlE?=
 =?utf-8?B?SGozUGo1VlNWcTA5YllHL3NaR05ueGRETmI0MDRMMjExdHl4ZHBoSlBMWTBw?=
 =?utf-8?B?b2lsdHl6REFUYndSQnRKdGNGSm94TXpraUNTQjhJRVVSa0lxcnJVTEpOZWxR?=
 =?utf-8?B?NGpSUWtLL3lZRXI5TEdTODZ6eHFmWTNSclJIWmtZOXQwb1pYMk5jSzFBaGth?=
 =?utf-8?B?N2ROMUJYNW5RY1pDTG5ROVNjVjhmUml6M1J2TmpJYjloaU42eVREdzBMY3dC?=
 =?utf-8?B?WDVTakVKcVlra05FWnNBZTcrZUcyZjlEU3dPeDZrWmR1T0t1OFZabC81L1g1?=
 =?utf-8?B?QTlSZWZSVkxTd2RvMW5tck5RMVh1QVF3cWJkbUJET0kzaTQ3ZytBVUorY09l?=
 =?utf-8?B?RWJPMEUrWExjdnlUYzByV1d0Z1pOVEFXRG1leXQ4Y0l2UERJSWNBY0syT1Jn?=
 =?utf-8?B?UHd4Y1hwU09uYW5vN3NDMnlHbWorVXJiNzVQZ3R5M3pISUwrbXRhMmxQcWta?=
 =?utf-8?B?R1YwTXZwMUFkTkpMMUJ6bDFXWnZSZjBBS1VDVU8yV3dvM2xNSU5mbnFqemIy?=
 =?utf-8?B?eFJmUksvWkxHSFhneERXRHdNWWdwYkFZVThDQyt0NWVTUitDYkVhRDkySzNQ?=
 =?utf-8?B?WjRoLzU5UDBRQ2pzN1dGTlN0bUhYWkRwY1NhUzd2OWNKL2NydDNoekRUbVJt?=
 =?utf-8?B?ZXpYcDI1MXhqclRHQU9HRFppQXFQWmhpdEdSYWpaTkQ5QjJsWUdtUytYN3JR?=
 =?utf-8?B?b0syY2hTL2dNZU11MW8yQ2k0T0xVM21XTXZ0R3ptbnQwcERWUCtOUm0zSlFW?=
 =?utf-8?B?RGNSUTNJYXVHelE2RTJ3SEFsUm1jTDNvT0J6SERqQzAwWDdUQWNCVDMwZmpv?=
 =?utf-8?B?dDhYaXlhdjZaRzFCSzBJV3hCRUdwazV0ZDVhVkhxZ2Zqc1RpR0gyVlRreHN1?=
 =?utf-8?B?OGsvcDdlb1VBSUNYbk9XMmNlM2QwZjF6dUVlby95YTFmdkZnaDRJZjlJVHhN?=
 =?utf-8?B?aGJaTndpVFkzMEp1RHpZRDJJMTMvUVBnbGFPMGU3WUV1bk5HZzk5VGNMQVBp?=
 =?utf-8?B?M1BWUjNDMVBqT2VmazRWeFJZR2JDT0I4QWRZb3JVSmtZTHVvRS8xekY1N3F2?=
 =?utf-8?B?OGtMQWZtQlZSUFBFMEVKSkRiQk81Qk9YbWtEQThVVCs3K1phbzdrVDBCWklt?=
 =?utf-8?B?WkdvbVVxa21NR3lla0hCU3M3a2VsSU15c1dCMXMzT2NkQldvT00zUjNtaU5t?=
 =?utf-8?B?MzBiVjNSQ3hRQTVuZWJUdXg5QU04V3dHUXJTNVdFRzhOam85ZEwvRVovZWpZ?=
 =?utf-8?B?bzhpTWtCdEdHUU44UEwwaDdXUWRoZ282TmdER0hnUXpTczJUVjNxV1d3K3VQ?=
 =?utf-8?B?TVRUSCtJY09yU1oweXVZWjNwenRuRmZOV3MreEhGdnhreDZPRlZLQ0pGNGUw?=
 =?utf-8?B?SE5OWUY4TFRkZXhLYWlyQnp0T25OK0FVN1NOT3g0SnZaakM1QVBLUDhDV0FJ?=
 =?utf-8?B?SDN1RjZIckJ6RS9GQkRETmlUWS9HaTR2ZXhZNHozUEYwcEJxZFoxQmx5ZHJj?=
 =?utf-8?B?bWgzU1dwd3VmQ2h2amRvWno1NWpWM2hucVNVWFZvQzMzT0t5alh3anFWbGNQ?=
 =?utf-8?B?Rnp3eWpueDhyVkVVNXM1UkYwRm9YOGx3UWovZ21PNHk0TW5PZzQ3OUg0ZDVX?=
 =?utf-8?B?T0ZNVFRSVnBQN3FWcDA2SDlmT29OL1lTZTNhNG1XQXA3K3NHSElZNFcyQWwr?=
 =?utf-8?B?Z0NDd2d2SldLakErV3NBRkRHWWVQbHA3S2RCNzZSY2d4VXp6a0pXNURpck51?=
 =?utf-8?B?OFFmK3NzeDYzR2RsYzRwaXBtN0k1azhUZHhvMi9hc3creWI0cDJlcjVuWjNo?=
 =?utf-8?B?em1PRlVCeFAxNDlDekZJL2ZJVlMvWlEzMkJiMFEvMVNPSENoRjdpeDY4NXRR?=
 =?utf-8?B?Z0tVZHBpT2tGa1ZBRVhHT3phSEpiNFl0NDlvQzZGZnhVT1pFb1BJM05TVDRn?=
 =?utf-8?Q?0PTQj7dnUS6umQCOfjIH2Oo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE1kZzRtSlcwWitlM3JJQWxkdHZPZHorektkaGVncWlqR0QxNGJhTk12VWlh?=
 =?utf-8?B?YkJ1QlZLZlZOUGIxZlI2SmNUc2E0MFE5QkhwS0M1UWtFY0dySW1GRzBoM3Qr?=
 =?utf-8?B?d2NwdVRWOHVaNWloOGFDVXU0aitHNUlBR1hGS3VoY1hPeVJTQkF1U29wUjIx?=
 =?utf-8?B?RjU0cnI3S0h3dlVVaUlXbHRZUlQ2KzFGdzNFTzNhYzlnVCtaaUU1OUlMN2o5?=
 =?utf-8?B?ZmF1YlpZR3JlMW95YS9SYnlHWU8yVmthM3hzKzltR0tDaE5iTVVqSmJGZDNp?=
 =?utf-8?B?R2loNXcraVdxbjF5d2ttRDZ1dHlFM2cxNzQ4Rm44VzlHL0h1MGM5UGhXbHda?=
 =?utf-8?B?OGJQazRWWHRJT3JXalo3UU1sZ0NxemVJOXc5aWNkRWxNd0ZUdkNQelhBNWk1?=
 =?utf-8?B?L3NUYkZKd2lIMnpOdzlFQ0J6Y1NWUWxUOWJCKzJrYWRKVG5OSnNkNSs3Wlpa?=
 =?utf-8?B?djF1V3pYRDVnb2Z5ZGlFS1RiNTdaQlk4TWFSOE5GaDRLeWZzOWpLMkx4dWFS?=
 =?utf-8?B?eFlHMXpUNGRKOUZzbzRuTmVPM2JWMmZ1djJ3YVN2S1pzdExmSm1wRnpNSXBv?=
 =?utf-8?B?cGtUcFF4OG9UV24yVUIvWnlSelR3c2EyQVFlZ1I5REdldVpUeUFJUE05QlJG?=
 =?utf-8?B?d1UvTUtjOUtLbWdaeDZmTG1lTzVzTkdaYXhqOEZGQkJYNzBxYW1NUEw0cHdx?=
 =?utf-8?B?SGxDdzcwdTVFZkg1NUNrVVQ0Z09hbGtNdXNtZVVLMUN5OUMrVFFlTUhwUW9y?=
 =?utf-8?B?cGFEcnVvbnEydWdJUjVwZ243RVpsb3FLbERXYW5IbVpWd2F6QnNtTGVmdm56?=
 =?utf-8?B?NUpOaG15bE11S3lhL0dUMzhoZEpPYldVT1c1NjNEc2xOaEZIRFhnV3dFZFhu?=
 =?utf-8?B?R2lpMTBnWUhvK0cwYTdMT3M5SzBTWnZ2aEVOSWJobjl3V1ViOXdGTXpaeWd1?=
 =?utf-8?B?cHhFTFF4Z0lZb21KOHU1N2JMWGtHMHdCT3o2cUo3TDJEN0FncWV6OFBYeGNl?=
 =?utf-8?B?MDhIeDF3dDhQS1hRaWgwc0RUYlJnUGxnbFRaQldJdVZBQ09uQWVsZDVuU016?=
 =?utf-8?B?Qmc4UUdKL1RwZkVKcFlpYlVqS0tWRlFEcHdNMVl0NEo3elFRYnJOWUVVQTNC?=
 =?utf-8?B?eGxBWGE1SzdmbmZ0RUhobG9nVTBNTENNVzJXYWNraUI0OGZyRkJiOGdKRVE1?=
 =?utf-8?B?WGJPMDhERjVrZWdGM0hnSFR4R25XYlRFMTlpZVZBWGhmZnFtQXdSdW92RTZJ?=
 =?utf-8?B?b2UzcktpWnBjRDF1MHdkcnQ4TTlKZGlQZTA2N2p3SURucmZiVmNxM0NTNkNY?=
 =?utf-8?B?OHkrN3h0dndvQm4rV3RzVERLR29WaTk5a3dxc1EwdTNJTExOeWlUVEl1dUcv?=
 =?utf-8?B?WXFGNHhyMEI5S1R4VFpzZUNHVVVtUFZ3Tm9SQ1BZdFlOOS9sb2dJZ0FrcVlI?=
 =?utf-8?B?WEQrNWNTakRjTThZeTdtR2dNTS82eklVT0ZEMnV0LzdUUXc1QmlLUU03VzVr?=
 =?utf-8?B?M0hHK1Fsb3dnMW05SUgyQTRHZnRwOHpQbUZ6TVRPTVEwbEhFN2J4YXdiTFl5?=
 =?utf-8?B?ODM5RXpIVnVWTjFOaFNCbmZQODFyLzgwRWdXeEZNQWJuT3FpdW1KcExQc2hi?=
 =?utf-8?B?dXQ0YldNM2dMaS9pK2FWTDNyem10VlNkK0E4SnVMc0ZSeS9HK09naC9Hd3ZR?=
 =?utf-8?B?dGM4UGlsdTZITHFPTXhTTDk3eGFWZ2J2RzRDdFhUV3h3c1hIRnFRc2JabWtu?=
 =?utf-8?B?dHEyUmVPa0o1aG1pK0MyRGo1K05LMlpWbUMvc1kzenVPeEprbk91cHFWVTUy?=
 =?utf-8?B?ckcrRlBFRGtjWktnYlFRSUdOU3dmSUJWMFo0aFYyUmdRSnJiNmlTTDE3MjVX?=
 =?utf-8?B?dk9UUXc4QkNqQzNnbEMraENsRHBJTnhGNVZHN1lsTUFycmxrYzZaejNlMnVz?=
 =?utf-8?B?cmVrS1lQVG5tWktQS2NTMmtrSXVEREUrbndLWnVnSGFzbWNqUnVLMWRZMTJH?=
 =?utf-8?B?UTVJK1prcmJZaHRPdEhRSC9OeDJUZUhsOE80S0p1S1NOUURqQU5OUTdXSGlt?=
 =?utf-8?B?Rzk1U1h2MXlXcE4zMHB1bSswYkM1cko2aUFvZ1IxMVFCSk1zUGpLQWtBbm1t?=
 =?utf-8?B?aFVNdVF4NnR6a2FyY25jRXVaUWNTTzR6YzJFR3BFbUY2VXdEUUU3cE1GUVpF?=
 =?utf-8?B?MTAwQjVOWXhlMmdodGFFMXQ1VWsvcWhoVVlwbit5dWI5enZLeEZuY0o2aFdl?=
 =?utf-8?B?WmhrMU1VWDFyaFN3eE5iM0ExMm5yc2VhN2xPT1NwUlRWVjRsTDBHdGFVd1l5?=
 =?utf-8?Q?/pPvlunDRLIxeLBOjw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f96459-6093-475c-272e-08de5a2a034e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 02:49:22.3667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXOTk43Wx7bAYv6bWratcohyB6rYlvT/DWJdguqX6itcrWqt1whWQimBjO2GehdnnUSqaFMRYVuRQrAH3ubVxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
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
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDIzLCAyMDI2IDQ6
MDUgQU0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS85XSBkcm0vYW1kL2FtZGdw
dTogQWRkIHVwZGF0ZV9tcWQgY2FsbGJhY2sgdG8NCj4gYW1kZ3B1X21xZCBzdHJ1Y3QNCj4NCj4g
T24gVGh1LCBKYW4gMjIsIDIwMjYgYXQgMzo1N+KAr0FNIEplc3NlLlpoYW5nIDxKZXNzZS5aaGFu
Z0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEV4dGVuZCB0aGUgYW1kZ3B1X21xZCBzdHJ1Y3R1
cmUgd2l0aCBhIG5ldyAndXBkYXRlX21xZCcgY2FsbGJhY2sgdG8NCj4gPiBzdXBwb3J0IHJ1bnRp
bWUgdXBkYXRlcyBvZiBNUUQgcHJvcGVydGllcyBmb3IgdXNlciBxdWV1ZXMNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDIgKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaA0KPiA+IGluZGV4IDExYTM2YzEzMjkwNS4uZjk5N2ZhMTdlOGJkIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBAQCAtODE1LDYg
KzgxNSw4IEBAIHN0cnVjdCBhbWRncHVfbXFkIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIG1xZF9z
aXplOw0KPiA+ICAgICAgICAgaW50ICgqaW5pdF9tcWQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCB2b2lkICptcWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdw
dV9tcWRfcHJvcCAqcCk7DQo+ID4gKyAgICAgICBpbnQgKCp1cGRhdGVfbXFkKShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgdm9pZCAqbXFkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGFtZGdwdV9tcWRfcHJvcCAqcCk7DQo+DQo+IERvIHdlIGFjdHVhbGx5IG5lZWQg
YSBuZXcgY2FsbGJhY2ssIG9yIGNhbiB3ZSBqdXN0IGNhbGwgaW5pdF9tcWQoKSBhZ2FpbiB3aXRo
DQo+IHVwZGF0ZWQgcGFyYW1ldGVycz8NCj4NCltaaGFuZywgSmVzc2UoSmllKV0NClRoZSBgdXBk
YXRlX21xZGAgZnVuY3Rpb24gb25seSBjb250YWlucyB0aGUgTVFEIHBhcmFtZXRlciwgd2hpY2gg
Y2hhbmdlcyBkeW5hbWljYWxseSBhdCBydW50aW1lLg0KSG93ZXZlciwgd2UgY2FuIGFsc28gZGly
ZWN0bHkgY2FsbCB0aGUgYGluaXRfbXFkYCBmdW5jdGlvbiB0byB1cGRhdGUgYWxsIHBhcmFtZXRl
cnMuDQpJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBhbmQgcmVtb3ZlIHRoZSBgdXBkYXRlX21xZGAg
ZnVuY3Rpb24uDQoNClRoYW5rcw0KSmVzc2UNCg0KPiBBbGV4DQo+DQo+ID4gIH07DQo+ID4NCj4g
PiAgc3RydWN0IGFtZGdwdV9wY2llX3Jlc2V0X2N0eCB7DQo+ID4gLS0NCj4gPiAyLjQ5LjANCj4g
Pg0K
