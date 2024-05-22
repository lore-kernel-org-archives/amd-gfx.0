Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B47FC25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FAC10E472;
	Wed, 22 May 2024 07:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KeVNsTZq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590D410E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tzw8lVwAmREirdOhuYtqHajCyMLhtxkO3i39N5+IEOX7MDI3aqHWBsnlEQ0i25ACF7LWkHefsxfRUVwrOkVRVUJaK8893ACVAhQCCAeqvjc/bTI8sAhY2GU0l+GAk71eUQ4j3NKITMsh4kiXmLilrnP3ga0M6jra5nfVFhnUdz1bwUrG7mLywhXS7mnAH9ujvo9AKTbI8s/fe0IPMi6fC42S32EifgXy3TV0tb+Kzs7+Q1nBe82+1LS1kFD7bzh+o9teSnIa4O6LWa06QkMcuGq5rPjx7G9Dgc+eGVNvjgfFoMSFaTGdE0ThBWHaO0azRy9B1h/hi4b8z5IbihO7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3O7nI5IFeXeoXwKOIjYk7v4AuXpkJ5RzC84FYCOTGw=;
 b=Xy8ioTzVF8b32h71lf6tST3PwtxanilAAQMnclkb8ozo/sEvvGw0BFGpxQKFR9JMJXzUs7/RQDn3ICzYbUyUw7mjZMkCQIMBJ992wWVzlLuXXX+C+E/m00HsDBLwiS6uDyh6AzRJ+VLauM82K4rl9dPJKVaAPpbzoUa+PS2g/kuvxF/7HxzOuxc+T7YGBLn2kJqYIr6eGVZ53bxzXgUDva3EFVIUvfQjwwx+9DVIl9PimCMUjb7boB0QPowHgir4hwM0EXvHBKYJVBXSXH2J3R0iLlqZLO1zWqcgltixFuGpmoCRqsarNZ181SAUy4R8PdwT10dx6kZRsMBorivfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3O7nI5IFeXeoXwKOIjYk7v4AuXpkJ5RzC84FYCOTGw=;
 b=KeVNsTZqo/BfMlh4WC8YVgnA9cFbt/2K2ce8VzFldNNmsJq7YHj08A4QwWtrjraHjcRcof7nwWfAsVBoWtTw0OKk8+hTtQUXKObn/r7tr9viLE01aObHVI3UOI3qHopO7W19k2Kw/R0CAahbbOhB2pGEDkYcmFxxBIigVIhlk9I=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:16:18 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%6]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 07:16:18 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
Thread-Topic: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
Thread-Index: AQHaq07OQGIFjR1mO0+IuugIg7CnMrGhWM0AgAEtnACAACvwgIAAIsMg
Date: Wed, 22 May 2024 07:16:18 +0000
Message-ID: <MW6PR12MB88981A06546719ED8F4A304CFBEB2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240521071615.371277-1-jesse.zhang@amd.com>
 <1d4223d3-b4e5-4c02-8da7-ab87406d5cc3@amd.com>
 <DM4PR12MB515252901B1002704C2B56F5E3EB2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <6f5301a3-acf9-473a-b98f-8991a97af9ef@amd.com>
In-Reply-To: <6f5301a3-acf9-473a-b98f-8991a97af9ef@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f755f71d-680c-44da-bd70-5af1293f6761;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-22T07:01:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SA0PR12MB4366:EE_
x-ms-office365-filtering-correlation-id: 7c737cfa-1790-48ad-9b2b-08dc7a2f1330
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d3RKRVpIaEJYdlorZWJYNEJTbUhnVENUMFUxWEhnQnJ5VTdNZWxXNzY3UWZm?=
 =?utf-8?B?c2dwWnJacU5qWmRKL1Z6UGtzUDA2ckhRQXhaMTdrYUVzUDlnajBVUFJYcFNC?=
 =?utf-8?B?NHhlS2JjR3lXNFF5Mm40azZWRzNQWXpud0dzTnhrSnU5MjNIQmpWdkZqM1ly?=
 =?utf-8?B?dFdIZWMzK1RaUVVLOE9IaFRCMkszamhldUxuakNVM1lQQ1l1R1J1R1B0cVpm?=
 =?utf-8?B?RCtGejltQmozeGVRMkFPaTIxNmpaeGZoWllrbmZtQ2NqV2dlY3h2Q1FFZXZk?=
 =?utf-8?B?ZEcyK1dwOXdRbzhhbkhWdkMzR1c3VVhZaTB1SGZ1Z3pHbVVvWDVreFJXTENl?=
 =?utf-8?B?aEl3OUI1UWxOaTNTQjBpYjhKL0xtcllIMHNQR3RyZFNXU2tUNktGQ0M2eFNv?=
 =?utf-8?B?VFg1RUxwOFROcXVqV2VwSWpMR3drMFpIeXJNa2NTa2ZGQ0ZxWkpScFllSURh?=
 =?utf-8?B?Q3N4bXZmTzEyUWV2dkljSGlRL3BXeHFUZ1JBTnBQRkVxcjI2SmNRejhUZFJJ?=
 =?utf-8?B?aTFwRGIwUG0zYVZtR2JmQTgxYkxoRHRzam5UMGJ0SjB1b2k1NVZMNjFncTdO?=
 =?utf-8?B?S3R0MWMzLzQvY040RkNmZnE2V2JjcCtlZFIvN3E2TjRNV0pFUUNQRGxhRW9m?=
 =?utf-8?B?WXdoc1A1UENDRDNFU0w2VlIxbDV6MDBFemo5ZE8vQ0lRaHorWjRqTXZBK2E3?=
 =?utf-8?B?enlpeWFJM0Q1OXNORTR1S0hXVnFGTjQrK3drMVNrUWhCTFR1SWV2S0RwdklG?=
 =?utf-8?B?U2hYSlE5YUVGeW0zYWRsY0JUclFHMFlIMUVodUlES3NoNkdMZXNib2JwVVF5?=
 =?utf-8?B?c0wvNkJMMks2Nkwwc1NmekJXUTJyYjBQR0RabXZYZ1JpYXFxUDc0ay9Yekw4?=
 =?utf-8?B?aThWUG53VE1nbVljK3VCWWkvZFFwS2YzR2JGZWlJbWRLVXVINXR3eVBCZEZm?=
 =?utf-8?B?RlVKSEo5Mk5YVU5sYUwxWDZKUDd0YXVnYWQrVVNPV0svMHhuTEJZamJMM1dR?=
 =?utf-8?B?TnZqT2FQSElUWmlxc201dU9XVTd2N3JjaGVRaDVvMnN3VUtlY0pNOE5FZFBJ?=
 =?utf-8?B?S1ZtWEpoTzJZNW1NcXBFekpyZ09MVDBiS0lWdE92S240SXp5b1FVczRSSWtJ?=
 =?utf-8?B?bUhjV2RuY01zM0xiY0FkU2RtN3M2bXVqVEFJQm1iYW81ZTlrbU0yMkhJQjVY?=
 =?utf-8?B?Zm90SDF0VWlxajBHWnV2SU00MEpEeGZCbXN1SUl2SDlRNzg2U1RMM29Gejgr?=
 =?utf-8?B?S2xwN2pFUWdkRkZYZjVPQk5hRTdLb3Q5U09DY3dFS3dhdmU5dGdpVUtESWFm?=
 =?utf-8?B?VStkZjFMQ1FoR3dRa1dlanI0ci9rMnprSjZnelJQZEJ6ZlFvZXNSWU5OV0VD?=
 =?utf-8?B?d2ZkNDFON1BTKzkwVkdvY2FFN2pWL2kxa2lWS1REYmtHRXlicGMzdHBmcERB?=
 =?utf-8?B?OUdJbnVpWWlpc2hXMndiLzMzUVNZdmxlZUU3b0FOby82N3d6Mm8yRzVhMk81?=
 =?utf-8?B?ZURWa3pnVzEzRDVhNVFYQmVGUC9oem96d1IrNzRKclFIQlJNQXkrS1UyZmli?=
 =?utf-8?B?eDc4UXpsYk05NExoanFIOStXOEpsd09tS2NHUlBVSFJYcW1mMXFNdmlJbWhI?=
 =?utf-8?B?elNtK1NlQ0NUQXRTQ1pOWTFOck1GT21rd3FvWXN0ellwSHNOV1MwV2M4dERu?=
 =?utf-8?B?NkhEMHMrQXEwV2xuak10bDBJRGNTYzluVFJQR3hlajFZUDZscDJGRzZvbk1I?=
 =?utf-8?B?ZkNLTmdyR2pkdVo3Y3ROeG0rYWN2MWZqSGRiSWI1RlJGVWlySU42R29mUUZW?=
 =?utf-8?B?anZjYTd2Wi9QUmEyTytkQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGFoa1dES3A0Z2ZqSUpjVEFKREljdmZETmQ5Y21BbnM5NnptcTlqK2U3N2Zt?=
 =?utf-8?B?cVV6TUh4cys2d05aRlgyTy9SMm5MaW5iNHJjNXdqQ1dQN3JlVjlwbUN1RnJw?=
 =?utf-8?B?dVRINHZIK25sa2Z1dG1mUHRpd2YyUDRxU1dKQ1RrMlFDdGp2UDhuT3BpL000?=
 =?utf-8?B?TlMwRkpmMHRmbmYyb3BQbXZKRzhlYi9QbEFoRW5VR2x3TXNkSDBRSmEwWkpI?=
 =?utf-8?B?dnc0bWlNQnJQdUJBK0JRQ0RRM0grOUxCeTVtRGJyR0RaMXlLVysrMVloazFk?=
 =?utf-8?B?cGpLNE9mQXJBNkxCUVB3dkpNQnFRVm0yY1BIbWtEd3NHeXlKMWkybmM1Ly8r?=
 =?utf-8?B?bXM0dmNkbFhaeWlRdE16MSt4QkxMV2docGlxci9zWXdsR0k0UUJLUW9pQ0dz?=
 =?utf-8?B?aXd5LzBkbFg4VFNCY0RkK2tRdFlwOEN1ZEFmNUJNTzZRd042T3k0R0xVdXVk?=
 =?utf-8?B?Ni9vSU1QRFBKYWc0d1hjd0xKNFRiNm1EbVdkREt1SzZlV2VwRDJOeEI0UFhX?=
 =?utf-8?B?TzhkQ05ULzRnQXhhc0xyc0NOWVJwV083ME1WNXg1b2p5MjZjUnBnS01YaVJz?=
 =?utf-8?B?UzNiNWxsL3lVUlYrM2JoTEdIYlYxU2xKdXBnVjdUdUxrUjc1LzluWGZvQVVy?=
 =?utf-8?B?SGp5QTNPT2VVYWxsRHZxNGtRVjk5Nk9GeWxZekhwUTlMaUMyb1lBdnBmbXB0?=
 =?utf-8?B?a2VmMmN0WjVLS1Z5d1FwU1JZQ1QxSHRtYXVMSW1EQU1KNCtCV0xmM1dIZmZv?=
 =?utf-8?B?eGVpWkFDRjA2WmhZbE1yV2ppVFhseDd5WWtlM3puSGZpWS9DWVJuc2NEa0Nq?=
 =?utf-8?B?c3pQZUt3VU1xaHNVSUlVVHJiYWxzSmpkNTZab2hDRkpkTkFlQ3VHZzZpTVpK?=
 =?utf-8?B?a2dRaUdHaFR2eEVoMzJKWDQrbk9qQXFraXFJMlJ6SXdLR2V4MDBKeU50SUkr?=
 =?utf-8?B?ZkxmL1ljdDZ2VkovbmNuSDJlbXYrZnRRTkt1dzNSamVxbUl6Y0U5ZjJWcnk3?=
 =?utf-8?B?Vmh2WHBEUm9RaDBzMlRqV09ZbWpkcjFCeE5yMVMzNjMzanhZU05Ib2lvZ2Zl?=
 =?utf-8?B?dWlzclhMYWQ4cXJ1T2FNcUY0S2UvSlhycE9nQzNPVW5LTklNMVZPdTJTc0hh?=
 =?utf-8?B?UEVXRElFZnJtTngvQ04zOThqNXV1aVB4dEJqeWlQUE4zdHNhMWNMYUx2Tmh1?=
 =?utf-8?B?WVVuSUJTWmVYMm5HdllOVG5DUjF6Rjh1SWhuZGd5YW9jcDVsejBnQUNoeG5v?=
 =?utf-8?B?SnlJV0JsNzFHa3lINk5DTXpoKzh6eW9id1p0QWlBejBLd0szUGdIZjBOeEYr?=
 =?utf-8?B?TjlUM0swd3ZldHoyS1hNSGdOaGxRVDNxTm1meGVSdVFjMFlrSTZENkVMaFNM?=
 =?utf-8?B?WHRIRE80TlpRNmRjN1l6RTA2N3dOT1lEQStOWTg0VU5Ici9teUI2NUJrRkxW?=
 =?utf-8?B?SW1nb1ZrT0Q1dTdadUFJK3ZicjI3V29MNEJiVUJJU3BlVDVCYXljMXNiem4x?=
 =?utf-8?B?Z2did3RXcytXOGdaMW8xM0ZiQVVZcjZXZlI1YzZzZjNqR0VTSlpSVXdTTGZ1?=
 =?utf-8?B?UG1OVjByS0daVVNFNUE5Y3orVFlTRUZWZU5UaFp1VnpLT1lqWWRWUEdjeU1V?=
 =?utf-8?B?OXl4TW51VzZwOGI2ZnNidWZlR1QwZDNuN0N4QjZsaGFBa1NvMHhLcXEzY2tU?=
 =?utf-8?B?Y0ZxZ2ZHb3JJNkpEeTBDb1ArOG4zbWE3R1RURmRVZkxCdUg0eGR4VVNqdVk3?=
 =?utf-8?B?RUpSMFMzM0lyclBlUnRTcUFmTFlJRE1sZ3ovc1JrS0R4RTJCdHkxTlFRUWZo?=
 =?utf-8?B?T1NXa0VadHB2M1Y0NHppM3ZmdFJiTGRIaytFRDVDb1Rpb2FiQzgrbDU1R3lV?=
 =?utf-8?B?Wm5ZcjN5NEIvNmFTZnpRbHNSVS9obTNJcDFVSFBtZDVNYWR5bEg3eFJjRW5l?=
 =?utf-8?B?U0JLY0hkeHNCUzVWWlNvUEhoUXlwWnRsM3JmQ0ZVRHZpaUJsZzlhb0tBK0pj?=
 =?utf-8?B?cUFGN1kyT2ZzaitNdzd1cm9rdVNNRExNTnBuYk9HK01TUlpWcVUrL2NFRk9z?=
 =?utf-8?B?Q1hwQXMySm81TFg0eGMyY1RVTDZGRVNVUGpMMVF0RDdocE9MTVZUVHExVTds?=
 =?utf-8?Q?f8yk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c737cfa-1790-48ad-9b2b-08dc7a2f1330
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:16:18.3313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opN171kopu7Y8tJvFje16MW4W6KpQkys5H6VALmKG3ww59nNh2A6FTRO5NEXMsd2f6CHwYHVeHu0Q1qQ1FPSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

W1B1YmxpY10NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF6YXIsIExp
am8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE1heSAyMiwgMjAyNCAx
Mjo1NyBQTQ0KPlRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFt
ZC0NCj5nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+PENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPjsgWXUsIExh
bmcNCj48TGFuZy5ZdUBhbWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80IFYyXSBkcm0v
YW1kZ3B1OiBmaXggaW52YWRhdGUgb3BlcmF0aW9uIGZvciB1bXNjaA0KPg0KPg0KPg0KPk9uIDUv
MjIvMjAyNCA3OjQ5IEFNLCBaaGFuZywgSmVzc2UoSmllKSB3cm90ZToNCj4+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+Pg0KPj4gSGkg
TGlqbw0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPj4gU2VudDogVHVlc2RheSwgTWF5IDIxLCAyMDI0
IDQ6MjAgUE0NCj4+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47
DQo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+PiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+
OyBZdSwNCj5MYW5nDQo+PiA8TGFuZy5ZdUBhbWQuY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzQgVjJdIGRybS9hbWRncHU6IGZpeCBpbnZhZGF0ZSBvcGVyYXRpb24gZm9yDQo+PiB1bXNj
aA0KPj4NCj4+DQo+Pg0KPj4gT24gNS8yMS8yMDI0IDEyOjQ2IFBNLCBKZXNzZSBaaGFuZyB3cm90
ZToNCj4+PiBTaW5jZSB0aGUgdHlwZSBvZiBkYXRhX3NpemUgaXMgdWludDMyX3QsIGFkZXYtPnVt
c2NoX21tLmRhdGFfc2l6ZSAtIDENCj4+Pj4+IDE2ID4+IDE2IGlzIDAgcmVnYXJkbGVzcyBvZiB0
aGUgdmFsdWVzIG9mIGl0cyBvcGVyYW5kcw0KPj4+DQo+Pj4gU28gcmVtb3ZpbmcgdGhlIG9wZXJh
dGlvbnMgdXBwZXJfMzJfYml0cyBhbmQgbG93ZXJfMzJfYml0cy4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPj4+IFN1Z2dlc3RlZC1i
eTogVGltIEh1YW5nIDxUaW0uSHVhbmdAYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdW1zY2hfbW1fdjRfMC5jIHwgNSArKy0tLQ0KPj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Vtc2NoX21tX3Y0XzAuYw0KPj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1zY2hfbW1fdjRfMC5jDQo+Pj4gaW5kZXggMmM1
ZTdiMGE3M2Y5Li5jZTNiYjEyZTM1NzIgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdW1zY2hfbW1fdjRfMC5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdW1zY2hfbW1fdjRfMC5jDQo+Pj4gQEAgLTExNiw5ICsxMTYsOCBAQCBzdGF0aWMg
aW50DQo+dW1zY2hfbW1fdjRfMF9sb2FkX21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X3Vtc2NoX21t
ICp1bXNjaCkNCj4+PiAgICAgICAgICAgICAgIHVwcGVyXzMyX2JpdHMoYWRldi0+dW1zY2hfbW0u
ZGF0YV9zdGFydF9hZGRyKSk7DQo+Pj4NCj4+PiAgICAgICBXUkVHMzJfU09DMTVfVU1TQ0gocmVn
VkNOX01FU19MT0NBTF9NQVNLMF9MTywNCj4+PiAtICAgICAgICAgICAgIGxvd2VyXzMyX2JpdHMo
YWRldi0+dW1zY2hfbW0uZGF0YV9zaXplIC0gMSkpOw0KPj4+IC0gICAgIFdSRUczMl9TT0MxNV9V
TVNDSChyZWdWQ05fTUVTX0xPQ0FMX01BU0swX0hJLA0KPj4+IC0gICAgICAgICAgICAgdXBwZXJf
MzJfYml0cyhhZGV2LT51bXNjaF9tbS5kYXRhX3NpemUgLSAxKSk7DQo+Pj4gKyAgICAgICAgICAg
ICBhZGV2LT51bXNjaF9tbS5kYXRhX3NpemUgLSAxKTsNCj4+PiArICAgICBXUkVHMzJfU09DMTVf
VU1TQ0gocmVnVkNOX01FU19MT0NBTF9NQVNLMF9ISSwgMCk7DQo+Pg0KPj4gY2M6IExhbmcNCj4+
DQo+PiBUaGUgb3JpZ2luYWwgcHJvZ3JhbW1pbmcgYW5kIHRoZSBuZXcgb25lIGRvZXNuJ3QgbG9v
ayBjb3JyZWN0Lg0KPj4NCj4+IEkgc2VlIHRoZSBiZWxvdyBmaWVsZCBkZWZpbml0aW9ucyBhcyBw
ZXIgdGhlIGhlYWRlci4gQXMgcGVyIHRoaXMsIGJvdGggTE8vSEkNCj5hcmUgMTYtYml0IGZpZWxk
cy4NCj4+DQo+PiB2Y24vdmNuXzRfMF81X3NoX21hc2suaDojZGVmaW5lDQo+VkNOX01FU19MT0NB
TF9NQVNLMF9ISV9fTUFTSzBfSElfX1NISUZUDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwIHZjbi92Y25fNF8wXzVfc2hf
bWFzay5oOiNkZWZpbmUNCj5WQ05fTUVTX0xPQ0FMX01BU0swX0hJX19NQVNLMF9ISV9NQVNLDQo+
Pg0KPj4gMHgwMDAwRkZGRkwNCj4+DQo+PiB2Y24vdmNuXzRfMF81X3NoX21hc2suaDojZGVmaW5l
DQo+VkNOX01FU19MT0NBTF9NQVNLMF9MT19fTUFTSzBfTE9fX1NISUZUDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgxMCB2
Y24vdmNuXzRfMF81X3NoX21hc2suaDojZGVmaW5lDQo+VkNOX01FU19MT0NBTF9NQVNLMF9MT19f
TUFTSzBfTE9fTUFTSw0KPj4NCj4+IDB4RkZGRjAwMDBMDQo+Pg0KPj4gW1poYW5nLCBKZXNzZShK
aWUpXQ0KPj4NCj4+IFRoZSBjb2RlIHNlZW0gdG8gYWxpZ2luIHdpdGggV2luZG93cyBzaWRlIHRo
YXQgaGF2ZSBzYW1lIGlzc3VlLiBIZXJlDQo+PiBpcyB0aGUgd2luZG93cyB1bXNjaF80XzAgd3Jp
dGUgcmVnaXN0ZXINCj4+IHJlZ1ZDTl9NRVNfTE9DQUxfTUFTSzBfTE8vcmVnVkNOX01FU19MT0NB
TF9NQVNLMF9ISQ0KPj4NCj4+IGVudW0gdW1zY2hfbW1fc3RhdHVzIHVtc2NoX21tX2VuZ2luZV9p
bml0X3Vuc2VjdXJlXzRfMChzdHJ1Y3QNCj51bXNjaF9tbV9jb250ZXh0KiB1bXNjaF9tbV9pcCkg
ew0KPj4gICAgICAgICAgICAgICAgIC4uLg0KPj4gICAgICAgICB0ZW1wX2RhdGEgPSAodWludDMy
X3QpdW1zY2hfbW1faXAtDQo+PnVtc2NoX21tX2Z3LnVjb2RlX2luZm9bZnddLT5kYXRhX3N5c3Rl
bV9zaXplIC0gMTsNCj4+ICAgICAgICAgZGF0YSA9IHRlbXBfZGF0YTsNCj4+ICAgICAgICAgdW1z
Y2hfbW1fY2dzX3dyaXRlX3JlZ2lzdGVyKHVtc2NoX21tX2lwLA0KPj4gdW1zY2hfbW1fcmVnX29m
ZnNldChod2lwX2luZm8sIHJlZ1ZDTl9NRVNfTE9DQUxfTUFTSzBfTE8sDQo+PiByZWdWQ05fTUVT
X0xPQ0FMX01BU0swX0xPX0JBU0VfSURYKSwgZGF0YSwgSFdCTE9DS19WQ04pOw0KPj4NCj4+ICAg
ICAgICAgZGF0YSA9IHRlbXBfZGF0YSA+PiAzMjsNCj4+ICAgICAgICAgdW1zY2hfbW1fY2dzX3dy
aXRlX3JlZ2lzdGVyKHVtc2NoX21tX2lwLA0KPnVtc2NoX21tX3JlZ19vZmZzZXQoaHdpcF9pbmZv
LCByZWdWQ05fTUVTX0xPQ0FMX01BU0swX0hJLA0KPnJlZ1ZDTl9NRVNfTE9DQUxfTUFTSzBfSElf
QkFTRV9JRFgpLCBkYXRhLCBIV0JMT0NLX1ZDTik7DQo+PiAgICAgICAgICAgICAgICAgLi4uDQo+
PiB9DQo+Pg0KPj4gc3RydWN0IHVtc2NoX21tX3Vjb2RlX2NvbnN0cw0KPj4gew0KPj4gICAgICAu
Li4NCj4+ICAgICB1aW50MzJfdCBkYXRhX3N5c3RlbV9zaXplOw0KPj4gICAgIC4uLg0KPj4gfQ0K
Pj4NCj4NCj5UaGFua3MsIGNoZWNrZWQgdGhlIE1FUyBzcGVjLiBMb29rcyBsaWtlIHRoZSBtYXNr
IGZpZWxkIGRlZmluaXRpb25zIGFyZQ0KPndyb25nLiBUaGV5IGxvb2sgbGlrZSBjb3BpZXMgb2Yg
QkFTRV9ISS9MTyBmaWVsZHMgd2hpY2ggYXJlIHVzZWQgZm9yIGtlZXBpbmcNCj5hIDY0ayBhbGln
bmVkIDQ4LWJpdCBhZGRyZXNzLg0KPg0KPkFueXdheSwgdGhlIG1hc2sgZmllbGRzIGFyZSBmb3Ig
aW5kaWNhdGluZyBzaXplIG9mIHRoZSBsb2NhbCBoZWFwL3N0YWNrLCBzbw0KPm1vc3QgbGlrZWx5
IHdvbid0IHJlcXVpcmUgdXNhZ2Ugb2YgTUFTSzBfSEkuDQoNClllcywgdGhlIHByb2dyYW1pbmcg
aXMgYWxpZ25lZCB3aXRoIHdpbmRvd3Mgc2lkZS4NCg0KVGhlcmUgaXMgYSB0eXBvICIgaW52YWRh
dGUgIiBpbiB0aGUgcGF0Y2ggdGl0bGUuDQoNClJlZ2FyZHMsDQpMYW5nDQoNCj5UaGFua3MsDQo+
TGlqbw0KPg0KPj4gVGhhbmtzDQo+PiBKZXNzZQ0KPj4NCj4+DQo+PiBUaGFua3MsDQo+PiBMaWpv
DQo+Pg0KPj4+DQo+Pj4gICAgICAgZGF0YSA9IGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9PSBB
TURHUFVfRldfTE9BRF9QU1AgPw0KPj4+ICAgICAgICAgICAgICAwIDogYWRldi0+dW1zY2hfbW0u
ZGF0YV9md19ncHVfYWRkcjsNCg==
