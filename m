Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7255FD41C25
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 09:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0862710E6BB;
	Wed, 13 Nov 2024 09:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SdnGG1Vg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2310E6BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 09:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJb7fzcWyfln2/uKMWhj5usO9BaNSsyLmll02KK0VNZTVm5anzXEWF4wgoy+N8crrUQd4AA1S/aVBO58FiQ6wVti+jFhDGapuC8wt8kFg65kaFsltyMIgE3tuYUuKEXJ7esYrNP7qXy2UVebZLuLu+MtNi9hmPOePwd2x9StXi1qQeC+mX2RbTiY/c0O8RnQpkEZH/Z+6N9oOZTVmElkoqgNSYPJO2fEcRVoiaomkhamrYsRfg1L8GpsshdlCtZvPICaEHwXbLWOTKkODMpAsVpZHVz2XF33LV3ciZR9Y/8zvHQKWiAAXabg+cqutpU4A4T6bMhsRpxH3FVWlv2mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SBXMwpDvm98z/vvgh9csBJffDUlQMMRrz674sOXbyM=;
 b=ItJvCBL6f3Zg1an9B9OHOLH95FgGhT6mEOCUIdqn/w8eLfza1QjhxNwo5zIoN7gjGNBTL9oTnz36Yy5X84JHtRuavGBpkifwvR/kcrROGWfGOKFqiqNJldAP1ywZjTV13sFI3eyNrjPRXi8p5Ek6YXIbDw1XlhTbUUgu2a4IyMlsIV3oN1xa6EC2UAnLzxTR0devpZofqc9aTkD/VdUCQaP7Q6sNqAsS7tlKehCiC+NEQ9kKvJK0kDFLz5lnDOfIXXT0b3+TrXn1LQJWRDwAwp9wBP/spPf9hRUjvJY9fZQg32fgkN9D8ha51jpzKfW/dfuxHbu59dX5YOeH8VUkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SBXMwpDvm98z/vvgh9csBJffDUlQMMRrz674sOXbyM=;
 b=SdnGG1VgTQKEwXzlQLlv0biyhYMAYcub96tY/VtgukwOEJOg0t4HQmUl2wQ4KJ8iBTwL+yuNASLowPFSgTtgSYFNHOaRTyvh5xBrbUxSC7Rycdpmdo8hmcjeNXbQZIOaV11gVqyd+hnzxzIzyd6wLEaTEpJ/DZ2x/mXCJ9J/pVw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 09:34:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 09:34:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, 
 Asad" <Asad.Kamal@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>, "Cheung,
 Donald" <donald.cheung@amd.com>, "Khatir, Sepehr" <sepehr.khatir@amd.com>,
 "Oliveira, Daniel" <Daniel.Oliveira@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Update data types used for uapi i/f
Thread-Topic: [PATCH] drm/amd/pm: Update data types used for uapi i/f
Thread-Index: AQHbNa7GGYz59Nev/EOL+2DBCQ8w17K08rLL
Date: Wed, 13 Nov 2024 09:34:11 +0000
Message-ID: <PH7PR12MB59970DDA580B998075FD6ABF825A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241113093043.1313004-1-asad.kamal@amd.com>
In-Reply-To: <20241113093043.1313004-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T09:33:00.6955335Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN2PR12MB4205:EE_
x-ms-office365-filtering-correlation-id: 642d9a2c-d078-4a9b-21b1-08dd03c6549b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?SEdRTVhNWW1RMDh4MGhUWlY4MktVczRGcGF3dU5ZNXl1TWFwM2ZEZmIrUzBP?=
 =?gb2312?B?U1N0T1NUUGxNV1BzblFKWk5sMUdxaGxGL01Zc2E0L2M4YzNLYlc4bDJhMG4y?=
 =?gb2312?B?WDZ0NGUvM1pRT29LU25scmlqb3hxNkFtVEgzVEptVmZIWElMWjZYMm4rbXQv?=
 =?gb2312?B?ZFYxcmpJVFRBY05nbzVNbzlEeFRSMlhLK0RXS0l2NnJrSERrOTFFS3VzMDlV?=
 =?gb2312?B?QVR6Y05SNEVWYVdQSjh5MGJoVFJEcWVCTDJOamtGZkcvTFhVUmFlVmJJYi8w?=
 =?gb2312?B?Rm9Qc2RzSnJLemR3LzNvVWR4STkzS2FOY29DNUxUVmdYOEFNcWgyY3hIdGFp?=
 =?gb2312?B?a0pLeEdLdUthc2Jib2E1U2xVR3JUbUxZdWNCVko2N3V4VDF6YVY5OURYY0cr?=
 =?gb2312?B?dnJFb2JKRGtQWG1vUFpPU1cwaEtzY3dXb2MrN1plWTB0M0RvM2VoZzh5cC9S?=
 =?gb2312?B?VjZabDFsRHp1WjVIWEFsZVNRTWdCQm1uMWtjTVNLY1BvVndadmREa2p1anc5?=
 =?gb2312?B?UDJ6RXc5dUozRGtBSmxMajh4Uy9MenI3cE1yZG04eFMydXFkVUJ2OFlBQk1U?=
 =?gb2312?B?TWJMSGJTQVdKbDduVCsrMHlTK3hsNnJiaWRFMWRzQVVjUUtSSTFpcVZ2WUxj?=
 =?gb2312?B?aTliSEhheHBiaTc5akx0UHRwUGh1ZkxsWmtZcHRRbVJabFYzam5ycEN2UzBJ?=
 =?gb2312?B?VEk0QWFHazUvZUdCbmhBcVQ3dTdPRXFOWE5IN1VvaE5vRE9mYlFTbG9OaFJI?=
 =?gb2312?B?cFliejlTZThvamJoV3BSSnpSVlA4V2h1VzQyc3hQYlBQUjFIbXUxYmNCcGtW?=
 =?gb2312?B?emorRnVKb2hIYUFRamR0Q1FFcDhpamRWazhIOC8xMEpIWmdBNU5IS2RaM2Y3?=
 =?gb2312?B?SVUrUTMxaEp6YlU5VWxJWjVQVjhUbnVyd3NSeEJaS2dSRmpJRlpRWG42MFNK?=
 =?gb2312?B?Wm8yS3NYZmVtYlZkVUMxY3g2OURsYkVDWWduWmNwTTQ0dTB0dFFLOFhiWkZB?=
 =?gb2312?B?c1U5L1N1Qmt6NGdiYjhFQ0ZjbW5sZFRaalRxMEZDc05rRGd3UW9JQWlCWHdI?=
 =?gb2312?B?dTZVN2xNVTNiZGNYamkwblJIczRsL1dJb0lsOXdzZHZhakkxZ255eU40UXpY?=
 =?gb2312?B?SWFOVGN1Tlc3bWlGc2JLbmZKQm9CSlQvb25OaFl3MUw0L2NLRlpCa05iRmN3?=
 =?gb2312?B?QUFZamNMa0tCWHg3ZG1VcXFLZlR4Z0FuZ3lkcGpwRkZtVTJUQno1b1BiVVZv?=
 =?gb2312?B?WkZVbUNIVzk0bXlRUzAzcXh3NUFBSlNQWDNXamZCeFVxanJRL05lcDNWaDk1?=
 =?gb2312?B?c0ZGS2sydno3dFdOVVVYSEhJd2JPQ2VMbjNRWE9KSHVwaWVhQStDR2dyRi9k?=
 =?gb2312?B?cmZCZ2JyVzNJUjllY2djU1QwV0lmak5vNVFTNG5DRzFKRHplLzJTRGNHUWJs?=
 =?gb2312?B?YWZadGVUOWNXTk5GcTgwMEh3QWhsYWt6elpzMThBTnVFQ1hkaW5ZaGV3aWti?=
 =?gb2312?B?eHZzK0tsUjYzTkFacFI4ZmxkRGwvZVJNamVrWkc0MjRzVFJadTNXLzdLVlZl?=
 =?gb2312?B?RzM4Ky9RL0p6MHlEOExiR2ZraVdHS3ZIZjFPMDBGNXI1MVNFUFNJSUVYUS9t?=
 =?gb2312?B?ajZzTFVNUXVOT1RqaHhHK0swT3pBK254YUVyNUk4Rnk3SkFXNUszeUIwSkNm?=
 =?gb2312?B?SFNLVDB0TFlCaEptYjlOZFlNUDVxZm5TcTUraW43OGU0Q3Z2WEVaeWxPN2VZ?=
 =?gb2312?B?UXNEclhmeW5jcGpnTWVDbGt6UmVyeGVwN1A4ZXNHWnlPUjBrQVUzSXdNRHE2?=
 =?gb2312?Q?D51wnU1emSk2fCcwuR07uIl7MFk4VFDkt3Rkg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cmI3RVFVZFI0QzB5eTdySlQ4VEFMWjh1Q3ROYVZ4KzFReTJVWkdqR25uUjlz?=
 =?gb2312?B?MHplR3FjUG5pd09DZ1VsZ0xndFAwd1BFOThGTnF6YXpXbUM0cnVPbTAxbDkv?=
 =?gb2312?B?ZGZXRVFQUnFTMk5xMGVKU1B3TG9YTlZwVG4xMTk3L09xUGlpMklTZnZjcVNH?=
 =?gb2312?B?YnpWOWhFWitwOE55YmRoaGRkR3NLR3pQQWZVOTBBRk5GQzBDOHJtZ0paOXlz?=
 =?gb2312?B?OFlGZUt3WlgvYVpjSjd1SkVycFFzSGsrZjFoQlZwZWNEb2tkQWtiajQ2eWEy?=
 =?gb2312?B?VzBoV2trV2pFN0dycWRuZnlmY1h2MU9LSjY3K2VoV3ZBdHh4OHk1ZHNHeHNW?=
 =?gb2312?B?NHdOUHNSdEVPNXlsb2FmSjNZbGNhUFhYTFE4bDlGb000Y3F2dlpHZ28zY1lJ?=
 =?gb2312?B?UFVZdFRoK0M0V01aK0V1aS9rdE9IWHoycUg2WVIrd0VIWUJocWtSUkFhd1ZP?=
 =?gb2312?B?QVJBTitVbXdlZGE0STNyV0ZhcGppMGZYamQzYVNVdUpDWExBdUh5KzhOVzFO?=
 =?gb2312?B?ZWZHTTZEUXRYOUFXQUNKdUcxYXozQmRJUi9Bajc1dUVMWkhtNTJCd1NiWjQz?=
 =?gb2312?B?Vy9KS0JkdlphS3hmSnIvSU92dzVGaHJMaHVlWDRSS3JBVlpoem5TZUxLV2ds?=
 =?gb2312?B?NFdrU05wNHkwQkQvK0lLUjNTNHpsQ1VrVy9pOUZlcytiUXJvS0plS3BMb2FI?=
 =?gb2312?B?OXFkU1JqRXVBVCtiNndKenhTdTIyVmYxMmd0R3Q3QUlialZYZys2VzRKWXho?=
 =?gb2312?B?ZDVxZ01LZ24wRDh0WVgzWkVSUFVzb0ZjU3MwT3RsZ01nSjF5OUZaOEhZZlov?=
 =?gb2312?B?M3E3UXU3WVBEcC9sTUxuaHo0TjA1Mm81MXlNcG1iN2l4WWR3OG9TMmhSazVr?=
 =?gb2312?B?R1h6ekxWR0lEVzZGQ0dKbjBVTWp5Nm5hR3N5MjdCcFJubndPUUJrWC9HSEp5?=
 =?gb2312?B?czQ1Q25VZjg1TFMveXJaR0F3aUpBL3RIcmNFMnB2TzcxbDhsWmlaajUzb1Nt?=
 =?gb2312?B?dnFobTRjNzRLQkJ2RlJrU2NPZmRINUt2SXEzZGhJa2tSbVh4ZnhXT0RwZDhv?=
 =?gb2312?B?RDRPb0c4bDRMUHRmL1p2aU1Jcmk0eXBvV2g0Q2xuY0RqMXdRaUtoY3NnTml2?=
 =?gb2312?B?TFZLTVE5VnpDWVI0Z3JZNFkxTDk0LzYwYU5XQ1djMkkzZXNSOEVESHdwQm53?=
 =?gb2312?B?YmJlaVFOenE5OFdGUGxTZVVjdmVVTUgxMTlxMTk4RnNjdC8zQjBGck13UVNm?=
 =?gb2312?B?RlJXOXdJUTNmdkg3QWw0TkgrbUxqZTFCRlpqSmd0Z0trbHJiZFNQSHA4QzJB?=
 =?gb2312?B?b2pKZlR6ODBkUWh2cEZyTUVQWmd6VnorUitKb2JxRHRaR3g4WmgwWUhxbDVx?=
 =?gb2312?B?TldGamVtZEd4bGw4R0U1VUwxeHh5WWNTd0RsRFV1bkpxdTAxK1J6UUkrc1NW?=
 =?gb2312?B?V2twSVoyWmFMOEZLZXlGY1FhNkZ6RnJheXhOcHBaVVdFR05KdGhGNzdvVmhQ?=
 =?gb2312?B?ZDVPVzA5M0JwRHJFNS9BVURBR2MxdFZ4eVM0MUtEb0xHVWo5SjVzZVR3Njh3?=
 =?gb2312?B?bEpnd2VGRzV0M2xUdmo5SGc0anoybUNLQmhnV3kvbndxdGZnUU9BMVo2SWtx?=
 =?gb2312?B?c0RMaEdwNys1THNINlZxdnBnZldzNlRrWVZjM01XaXJlRkhVa3VmVW0rdVQ0?=
 =?gb2312?B?K0JJeklad3pjZXczM04waGpPcmZaUEFDd1p1dUxVN1IxcnMzeWEzZlBLcTBn?=
 =?gb2312?B?YUVsUlErQkE1dE05c0VhSTNQVjRhdmlUTytic3VUdTNrMG96ZGtFNWxjdGxN?=
 =?gb2312?B?RmJQOWZ6YXFGUWUrT0NLeFJPT2ZzOTZVSUpYTzZNak5EMnd5VU1sTWprU2xO?=
 =?gb2312?B?NVBYbXZqaTdLTkhGdzhNQ1FDZiticmo4c0hycjB1ZzgzYnhRbnZuOGpieGlm?=
 =?gb2312?B?V1ZKZU5UeEhyRTY5TVo5QlJZcmE3OGxlREFUcDJvOEdCbi94cDJJRzdPanlu?=
 =?gb2312?B?MG40aXRGVDFBdGJKRU1yQlZiVUI3YWxRT01ZVmZlZmdmQ0Q5NzdzbzBMME9s?=
 =?gb2312?B?WnBIbFYrSVZ3WG1MUm1IdnU4S3FlbG9IRjR3MG5oczhUalFHUXZkUmpNZ09L?=
 =?gb2312?Q?it10jUdsNXTSBicZLWkbgB7Mc?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59970DDA580B998075FD6ABF825A2PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642d9a2c-d078-4a9b-21b1-08dd03c6549b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 09:34:11.3723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oG4f0B9WO1gt7U0qjmqxaH444r8ObSuLROrKssblhSyPiGmW6fM6oKAoGtW6OaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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

--_000_PH7PR12MB59970DDA580B998075FD6ABF825A2PH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVz
dCBSZWdhcmRzLA0KS2V2aW4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+
yMs6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0g
QXNhZCBLYW1hbCA8QXNhZC5LYW1hbEBhbWQuY29tPg0Kt6LLzcqxvOQ6INDHxtrI/Swgyq7Su9TC
IDEzLCAyMDI0IDU6MzEgz8LO5w0KytW8/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBMYXphciwgTGlqbyA8TGlqby5MYXph
ckBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0Ks63LzTogTWEsIExlIDxMZS5N
YUBhbWQuY29tPjsgWmhhbmcsIE1vcnJpcyA8U2hpd3UuWmhhbmdAYW1kLmNvbT47IEthbWFsLCBB
c2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBQb2FnLCBDaGFyaXMgPENoYXJpcy5Qb2FnQGFtZC5j
b20+OyBDaGV1bmcsIERvbmFsZCA8ZG9uYWxkLmNoZXVuZ0BhbWQuY29tPjsgS2hhdGlyLCBTZXBl
aHIgPHNlcGVoci5raGF0aXJAYW1kLmNvbT47IE9saXZlaXJhLCBEYW5pZWwgPERhbmllbC5PbGl2
ZWlyYUBhbWQuY29tPg0K1vfM4jogW1BBVENIXSBkcm0vYW1kL3BtOiBVcGRhdGUgZGF0YSB0eXBl
cyB1c2VkIGZvciB1YXBpIGkvZg0KDQpVcGRhdGUgbWVtYmVyJ3MgZGF0YSB0eXBlIGluIGFtZGdw
dV94Y3BfbWV0cmljcyBmcm9tIGxpbnV4IHNwZWNpZmljDQp0byB0aGUgb25lcyBjb21wYXRpYmxl
IHRvIHVhcGkgaW50ZXJmYWNlDQoNCkZpeGVzOiAxNTVmYTdjZWQzOWIgKCJkcm0vYW1kL3BtOiBB
ZGQgZ3B1X21ldHJpY3NfdjFfNiIpDQoNClNpZ25lZC1vZmYtYnk6IEFzYWQgS2FtYWwgPGFzYWQu
a2FtYWxAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBf
aW50ZXJmYWNlLmggfCA4ICsrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dk
X3BwX2ludGVyZmFjZS5oDQppbmRleCBlZTgxNzBjZGExZDcuLjgwZjdhZmM1Yzk1OSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgNCkBAIC0z
NTcsMTEgKzM1NywxMSBAQCBzdHJ1Y3QgZHBtX2Nsb2NrczsNCg0KIHN0cnVjdCBhbWRncHVfeGNw
X21ldHJpY3Mgew0KICAgICAgICAgLyogVXRpbGl6YXRpb24gSW5zdGFudGFuZW91cyAoJSkgKi8N
Ci0gICAgICAgdTMyIGdmeF9idXN5X2luc3RbTUFYX1hDQ107DQotICAgICAgIHUxNiBqcGVnX2J1
c3lbTlVNX0pQRUdfRU5HXTsNCi0gICAgICAgdTE2IHZjbl9idXN5W05VTV9WQ05dOw0KKyAgICAg
ICB1aW50MzJfdCBnZnhfYnVzeV9pbnN0W01BWF9YQ0NdOw0KKyAgICAgICB1aW50MTZfdCBqcGVn
X2J1c3lbTlVNX0pQRUdfRU5HXTsNCisgICAgICAgdWludDE2X3QgdmNuX2J1c3lbTlVNX1ZDTl07
DQogICAgICAgICAvKiBVdGlsaXphdGlvbiBBY2N1bXVsYXRlZCAoJSkgKi8NCi0gICAgICAgdTY0
IGdmeF9idXN5X2FjY1tNQVhfWENDXTsNCisgICAgICAgdWludDY0X3QgZ2Z4X2J1c3lfYWNjW01B
WF9YQ0NdOw0KIH07DQoNCiBzdHJ1Y3QgYW1kX3BtX2Z1bmNzIHsNCi0tDQoyLjQ2LjANCg0K

--_000_PH7PR12MB59970DDA580B998075FD6ABF825A2PH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>=B7=A2=BC=FE=C8=CB:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&=
gt; =B4=FA=B1=ED Asad Kamal &lt;Asad.Kamal@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> =D0=C7=C6=DA=C8=FD, =CA=AE=D2=BB=D4=C2 13,=
 2024 5:31 =CF=C2=CE=E7<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Wang, Yang(Kev=
in) &lt;KevinYang.Wang@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt;<br>
<b>=B3=AD=CB=CD:</b> Ma, Le &lt;Le.Ma@amd.com&gt;; Zhang, Morris &lt;Shiwu.=
Zhang@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Poag, Charis &lt=
;Charis.Poag@amd.com&gt;; Cheung, Donald &lt;donald.cheung@amd.com&gt;; Kha=
tir, Sepehr &lt;sepehr.khatir@amd.com&gt;; Oliveira, Daniel &lt;Daniel.Oliv=
eira@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amd/pm: Update data types used for uapi i/=
f
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update member's data type in amdgpu_xcp_metrics fr=
om linux specific<br>
to the ones compatible to uapi interface<br>
<br>
Fixes: 155fa7ced39b (&quot;drm/amd/pm: Add gpu_metrics_v1_6&quot;)<br>
<br>
Signed-off-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_pp_interface.h | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index ee8170cda1d7..80f7afc5c959 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -357,11 +357,11 @@ struct dpm_clocks;<br>
&nbsp;<br>
&nbsp;struct amdgpu_xcp_metrics {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Utilization Instantaneo=
us (%) */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 gfx_busy_inst[MAX_XCC];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 jpeg_busy[NUM_JPEG_ENG];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 vcn_busy[NUM_VCN];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_busy_inst[MAX_XCC];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t jpeg_busy[NUM_JPEG_ENG];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t vcn_busy[NUM_VCN];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Utilization Accumulated=
 (%) */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 gfx_busy_acc[MAX_XCC];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gfx_busy_acc[MAX_XCC];<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amd_pm_funcs {<br>
-- <br>
2.46.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59970DDA580B998075FD6ABF825A2PH7PR12MB5997namp_--
