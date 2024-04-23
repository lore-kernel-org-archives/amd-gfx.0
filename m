Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EC7C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0C61131A5;
	Tue, 23 Apr 2024 08:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RauWdzQi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B7E1131A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7abOHHxYCsubCuhNHXCSqQRN8ahukgg2m8mtfjUYPm3ChmKqYxViFwK3Zy7jPJRc+QszSKqAbC5Yw8w621jRofmbtTEuhp6fuRZblsCQIUKg6oEMQ/EicR+99KNijBwFjlHXDBYp1ESypKalnQcBCzU3rNoz1upcBWOUELGC+WeEaNi8sREF12BM2Sjnd69YcAimKvdVL9S3Qj2ddAJxq77yll1GoUIvUQ6KI7JiEM7OZyb0/ItPweCKc+VmJ0odLSBIyfK7x/gHsnaBNV8bvXJfL0iDPLqLfZTx2N5V3Y2yyWu/OW+vddRCkY2YgsSPAKzkPymEu8bqAlm43Tbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VihHddN84FJBc/sf5map0fRsynYhgb85LWM09Y8V9dY=;
 b=PaGjT9Y0NMFQLEYE2AQ6rYJOAYWI4uJa0IJMOosDI884xSg/aKFAzDQ9Om+VfMhc1iaa7NQ22DWTWeyyy4Dop27A7ng2vnBgZ9JLTbuW9D40aftCR8GUEkpxK3RqhUYrm8JW1e35sN/WN4jqKy5e6mn+vzLNhPfy7HfbFADryYOFRRhvxOwnoSh4gJoorvvQXHT/FZMU0czNIF/8LGOk2F6mVKt8FSqI9WAZbDNeT/UgiTKDe+Bu6YfZ8SDMOvL5HS9uiFeDlFAtWcIDnFaWjAb+TMG/D9eX6/xq2DaRyU7G52oOClttSx8MtZm632eu/QVVqGumCuH1f/n8Ae8lUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VihHddN84FJBc/sf5map0fRsynYhgb85LWM09Y8V9dY=;
 b=RauWdzQiUhGzyb/HNJ5jQbS+FMgUvNz2A/FDTFeQDWgRRqCSSnr83GBUfBsTfvaPLjH/8fZeWBToH73+9no+BXNQ0lZ3jIO31A8o83DBUuqAy8t6W6oenqFT0ftCZ9wIMRyiO2jmy/2LRC88aDvcFaxmjX4AOdQo3On+MJnAR2E=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:01:05 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:01:05 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Index: AQHalUeaalRAQhE8DEyHzT7uU164w7F1eReAgAAA7FA=
Date: Tue, 23 Apr 2024 08:01:05 +0000
Message-ID: <CH3PR12MB80747050F8AAA33C6F32851DF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240423062853.1022925-1-Tim.Huang@amd.com>
 <5456f6b4-7fc4-4ac1-b85e-cf3b00b5c4c6@amd.com>
In-Reply-To: <5456f6b4-7fc4-4ac1-b85e-cf3b00b5c4c6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b2619c08-234d-45e4-a7cd-a7360bd9bd12;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T07:46:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SJ0PR12MB6735:EE_
x-ms-office365-filtering-correlation-id: 0bed8399-9f89-497e-cbc9-08dc636b86ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?cmRxZ1hvL00yU1U3bjVKSW5LejcweUsyclk1SVltM3JxOWE0WXVhdWY5SmN1?=
 =?utf-8?B?aldhekh1QlR1bFlwQmdYTmx1ZzRIU2NFWUl2U3dJNmdhaGJGU21mUkJsRFVB?=
 =?utf-8?B?SHNpRVlBOC9KTzlDd3dEamlpYTNrMjF4M2YvaFpIMGM1WEltY1BDUytERkU0?=
 =?utf-8?B?RG5VdklXa2QrTjNSRTMxSWhIZXhhamxWQlArNEF5UkJTMnBJcjhFc2Q1cUNN?=
 =?utf-8?B?RlUvS0lxRTJrZVVyajhHeEQwM05zMXdyRTM4OUEwVXNUTGM1dSt0SmJsNjRj?=
 =?utf-8?B?SDRrYngrR3hsWGhicXRvZ2pHRG1DU3VmWmVNUGRDSkV6TmtybzBvMjdyS0Iy?=
 =?utf-8?B?STN4ay9hOCtlNE1nWFkvZ2JyUXVZWlh0cnlibk9Jd3MwWURUWE01c1lRQW1J?=
 =?utf-8?B?WHF0TGRzN2o4WE9QMnpraUpyMXZhcmpjc21QT2R2RGh2TUk4K29oVGNscUlT?=
 =?utf-8?B?M3FGMURVKzNTQ1plMW1HZnc1RUl4bGlIRkxCRy9kTS9HRlkvZWl5Q2ZLalhH?=
 =?utf-8?B?dVZsZlpQNkk5Ymtxb1pwK1UxR1hLb0NiKzg0eXBmMCtmRFFuOUhlT3BvZU1G?=
 =?utf-8?B?Nk5nejRHK1Rjd0ZIdUZMQ0NFRy9VQzJZN3g0RmdsNWpjT2lqcGhQOU5mcmpx?=
 =?utf-8?B?VUhkZ2M3cjU2aUZ5SG9qZkFLMVNFSkhXU3RWdGNkNVhNOHVvTFFtMXlQN3Ax?=
 =?utf-8?B?amc1b0FWK0ZwaUYzczV1aVlJT09ocElReGhjZy90bWhIL2hOSGtESmFqT2pR?=
 =?utf-8?B?UGNLeE9ZZVliMFAreXZUWWp6OWQ0MzJzdzFSbkptaTdCVkdubHA4cU9EUnM5?=
 =?utf-8?B?MDJiaGNJamJnS1l4VjR3L2tpQTZrdklWTmExRFJFK1hKZE41dUFWa3l6Q1hz?=
 =?utf-8?B?dW5ZeExlQytXYUV0RUZaU2xacnJnbVluTU1PZVU0cGRJY05DZnhrMGdQb0Uz?=
 =?utf-8?B?Wmo0Zk5NV2wxK216T01PdXJQb3pQSE1TQklpV1djUFZVTG93UDV3amRGTVI2?=
 =?utf-8?B?WU9DYXBOV3M4cHZKU1Q0U2lKM1VHVDloUEgyeTJMdGcyOHJ1ZHQ2Umh4ajRK?=
 =?utf-8?B?Q0lWN1hlZytSeFBvdUhQNHc1YWJEcDlhOVhpU0JLQ2ZodDJJOFZwenZTdmN5?=
 =?utf-8?B?TTVjS3pmTVloK0xQckpOMmlUdS85Qk9TVnlQVUpUaTRnamVBaytMQ0g1ZFZl?=
 =?utf-8?B?aEk0M0xRZWNrTXhLL0JYY0p3bHRUM0xMYXM2ZlRMRTkyZ3N6UEdYWE1IQm5G?=
 =?utf-8?B?bkpteUlxVzAzWkZ3bXd1Q2orMzd3Z3g4MEQrM1dZK1RkbDhLczVTN1hkNkNt?=
 =?utf-8?B?MTlsT0tpM29qVTZmbE54NjU0cFB1QWRuOTBCTE5kaFZ5blcyVHIyUW0rUjBT?=
 =?utf-8?B?azUyRStuRWJvWnF0aHlhZ1U0RWtiMUhrY0QzdnZBNGgzY0FZNlFLdytPbmp0?=
 =?utf-8?B?MlgwVmxBZjJKWGNUWHZ4RU94R2Q3cWF0RzZZZ2hFSElrdE03eFVsYVpUZ3FR?=
 =?utf-8?B?SWJyV2VoOFExOG0wejVKMjNRTmh0Ris3MFFCbHRhSzZySlM4ditETWdHcm5a?=
 =?utf-8?B?R2JlOWxoanA3N3RnUU45UFJJU291Sko2dFh4V3RwY0RvTnd1eXpIVzhybGd6?=
 =?utf-8?B?VXNYRHd3QmttcGF1UTlNM3dOMGFvNTE2VFBQNExWd1hhZzNrMlM0TWs0TnpW?=
 =?utf-8?B?UjF2Z2lVL2pmZ3BJZHpxWm94aWlCZDJUQkxCNjNxYUtiTXBFbW4xbS95dzBy?=
 =?utf-8?B?cXFsczZDRmlTa3NxQ3pIVTNrRVR4aTdvZ0Z5dk1Pd0hLeU1lUGNFNWNCaTVO?=
 =?utf-8?B?VFcxWG9obXRQTGJZRk1nZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXJTdTVJK2h3d1pGMWZWWm44cHE5WUJqMGs1MTMwUWhBQ2JYQWhuQ0tTdTFR?=
 =?utf-8?B?bWhZblV1NHdhMDdQTFRRMDBiNnA0cnIzQnpCNVVnanBGbWQyalljcCttU2FO?=
 =?utf-8?B?aU83cTNqRkIrcGNjazRZU0Z2TE1jSVh5RHl4UUJqQ3liMnlLS1FvS1pPUnl1?=
 =?utf-8?B?UC9udnFYUkhPUndlekwyWnhvNTdmWEdrRkRmRm1Nb3FBS1d2QXFGSzZMK0Fs?=
 =?utf-8?B?RHlvNzZaREZzdE5HWFRBb3FiV2d2NHB4SW5pN1RkOGhkTEk1UDlUZlZMSncz?=
 =?utf-8?B?NEJuRmEraXNXMjZaejJFS1czOWJObCtaUW5YZmNBdys1K2ZWYjdZQjJpVGVm?=
 =?utf-8?B?akdrNWE4YjU0RDQ3VWtpKzVhN0ppcWR2UTZ4bTFtVkN3blFuc3FLU04rWEZz?=
 =?utf-8?B?cWd1Q0poSVhYQzREdFNGSG1IVklHVC9GRUp4czJwemViTnlEaWE1dnFIV1k3?=
 =?utf-8?B?V3BCVFYxYXgyM0pMdFFPSUZWRUxmZG9GcXlFQzhNV0RIdzdPRnp3akIwZ1RI?=
 =?utf-8?B?Q2J2dVhSUEErWG5OdWFyWnZFNTI5cGZDb2k5citBQkk1KzhySGFBd3dPZEFH?=
 =?utf-8?B?Tzdqc09jNk9LemRVK1lSM0ZUdGI1Sm1NVHB4NXNFMlNOOFcvRmZ5Yy9kelMr?=
 =?utf-8?B?SkFiQmxnNXFVWkc3SXVrTmY3SVNGS2tYanUvaFViVHBiRElJbFAxWEdmQ1JC?=
 =?utf-8?B?Q21FRW1XQlRsMnB2akZOT2xQYTJpVjlVYldXc3Rwd01YL2pGRGlJMXBSeW82?=
 =?utf-8?B?VTc5VXE4WWJEMyt4UkhVdm93ditudDVOR3hWRHU5WjZpWmxPTDZQbWo5eFk0?=
 =?utf-8?B?YTRpaWFtenVSLytQZUlKTWx1bEZaR3gxenI1YWNXa0tYeDIvZ0hnbW0xVzVq?=
 =?utf-8?B?MU9EcXJvUnlsWXp1MGhNMXVzK01qMGMxZExKcGtZL3k1eWViNWhMSnZ3REgx?=
 =?utf-8?B?eGl6MkJxbi9ROVJkQzYxcW9QRFV6T28rdDVaSXNacytGNnlFVFVSVGFzZEdU?=
 =?utf-8?B?QXlTaE9nVnd5NkUzc3dYTmZLYTFSYW9VTW4vSjJDbG9IbnF4bFJWZk5RakpD?=
 =?utf-8?B?S0xlRUtMY0J4aFU3S3V2UnJ3UzJOKzRFUVQxZDBTSlA4TEl2aEIyQ2VmTThW?=
 =?utf-8?B?OEtHVXZKUHYweGlPeGdKV2ZIUWNkNmF2TXlUeXMySWYxd3JUZmJueGh0WFVH?=
 =?utf-8?B?SVV4RTE5UWs0bzZSRmJTQ1kvZkFMdmRwME9ET2hvMUZ5VW5yT29ycUw4bWI1?=
 =?utf-8?B?V3B3eVI4NEtIY2Z2OC9VTnVQWVNGRHZJT3ZjNUMvVkE5MHY2RGcxY1NXNWk5?=
 =?utf-8?B?SzVSbTZqbVZzbkppNitqSnBRT0FJVG45V0ExSjhzc3p3U0QvNk5JWGhtTUtD?=
 =?utf-8?B?SGkwYitFMnNjMW42dzVQUWhXYnNjWFh0NWFBMVI0YXUrZjZQZkRJTmNwUGM2?=
 =?utf-8?B?TXo0V3UxbjkvRjF5MjQvKzVXZjBnNzhVLzhiUnlackhoeTI1OUU3ZUZuZXpw?=
 =?utf-8?B?TVpVTmRKUEVRMy9ZbmF4QkEyTVd3N2o3a29veG95bVlBSXJNTTIvV0Z1ZTQv?=
 =?utf-8?B?b3hWYjFmdzJzbndpak44OWtSeFQ5YmFQemIvQlVMWGM4SkI3UXBtcWFGK1RE?=
 =?utf-8?B?bzliWTIvUHZ2Z2hnTURrSUVhc0pLRlFmYjZqUy9jUWRWb2NiQUh6dnh2dmV3?=
 =?utf-8?B?MjFWSlFiNFhsem1GRUdjQ2x2WlhrZjJHWHY5K3VkSXhZSWtHTnJEUG9PenVl?=
 =?utf-8?B?VzEvZEh6TlhmZU5LR1lOYUw1ZEJ4bnpjZFRjVXRKMlIvOEhNS2c5L1JLS1V4?=
 =?utf-8?B?QklqSisvbXFaQ1NWWTE3VjB3d2ZyK1YzMWF4NkcxZUEzT0FIZXpNWmlTMEVG?=
 =?utf-8?B?bVdOQ3dXTG4zbUhHZWRGNjBaODEzcXVYVzdDaUVNSlpnSVhxYXFRUE1ab2Mr?=
 =?utf-8?B?WW4raXIrQlZzSXlvOG8zU1VFMmduSkN2OHdTbTNMWHhQUFNEQlNTSDlRdHdC?=
 =?utf-8?B?MENVcEhwVlZOcVNEVmtPU1V0MWlsVzJUMFRWUThmQUloYmFWcjRrWWZKS2k4?=
 =?utf-8?B?bHhRc2R4Mm05dXZaNDZ1WmNHa0FiVWpyTFRFNUVWNHR5ZEE3Zk1LSDBoOHdV?=
 =?utf-8?Q?NLrI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bed8399-9f89-497e-cbc9-08dc636b86ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:01:05.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5sClLWKBv6T17uGKxXknMvoowhDBxoySDX8lE6tI2u5IJkF85DhK9rU1JL+qiDS5rRNzzS3de5czxUSowU2KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBBcHJpbCAyMywgMjAyNCAzOjQzIFBN
DQpUbzogSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggdW5pbml0aWFsaXplZCBzY2FsYXIgdmFy
aWFibGUgd2FybmluZw0KDQpBbSAyMy4wNC4yNCB1bSAwODoyOCBzY2hyaWViIFRpbSBIdWFuZzoN
Cj4gQ2xlYXIgd2FybmluZyB0aGF0IHVzZXMgdW5pbml0aWFsaXplZCB2YWx1ZSBmd19zaXplLg0K
DQo+IEluIHdoaWNoIGNhc2UgaXMgdGhlIGZ3X3NpemUgdW5pbml0aWFsaXplZCBhbmQgd2h5IHNl
dHRpbmcgaXQgdG8gemVybyBoZWxwcyBpbiB0aGF0IGNhc2U/DQoNCkl0J3MgYSB3YXJuaW5nIHRo
YXQgcmVwb3J0ZWQgYnkgdGhlIENvdmVyaXR5IHNjYW4uICBXaGVuIHRoZSBzd2l0Y2ggY2FzZSAi
IHN3aXRjaCAodWNvZGVfaWQpICIgZ290IHRvIGRlZmF1bHQgYW5kIENvbmRpdGlvbiAiYWRldi0+
ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9GV19MT0FEX1BTUCIsIHRha2luZyB0cnVlIGJy
YW5jaCwNCiBpdCByZXBvcnRzICIgdXNlcyB1bmluaXRpYWxpemVkIHZhbHVlIGZ3X3NpemUgIiBi
eSB0aGlzIGxpbmUuDQoiYWRldi0+ZmlybXdhcmUuZndfc2l6ZSArPSBBTElHTihmd19zaXplLCBQ
QUdFX1NJWkUpO+KAnA0KDQpJdCBtYXkgbm90IGhhcHBlbiBpZiB3ZSBjYWxsIHRoaXMgZnVuY3Rp
b24gY29ycmVjdGx5LCBidXQgaXQganVzdCBjbGVhcnMgdGhlIHdhcm5pbmcgYW5kIGxvb2tzIGhh
cm1sZXNzLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRp
bSBIdWFuZyA8VGltLkh1YW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZnguYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZnguYw0KPiBpbmRleCBkOTU1NTVkYzU0ODUuLjZiOGE1OGY1MDFkMyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiBAQCAtMTA4NCw3ICsx
MDg0LDcgQEAgdm9pZCBhbWRncHVfZ2Z4X2NwX2luaXRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LA0KPiAgICAgICBjb25zdCBzdHJ1Y3QgZ2Z4X2Zpcm13YXJlX2hlYWRlcl92
Ml8wICpjcF9oZHJfdjJfMDsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9maXJtd2FyZV9pbmZvICpp
bmZvID0gTlVMTDsNCj4gICAgICAgY29uc3Qgc3RydWN0IGZpcm13YXJlICp1Y29kZV9mdzsNCj4g
LSAgICAgdW5zaWduZWQgaW50IGZ3X3NpemU7DQo+ICsgICAgIHVuc2lnbmVkIGludCBmd19zaXpl
ID0gMDsNCj4NCj4gICAgICAgc3dpdGNoICh1Y29kZV9pZCkgew0KPiAgICAgICBjYXNlIEFNREdQ
VV9VQ09ERV9JRF9DUF9QRlA6DQoNCg==
