Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CAFC54756
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A472210F456;
	Thu, 22 May 2025 04:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3SiYxLM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DBE18AB7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 02:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Sb0WYcblAZ+0N+nOyMrayIAaTEMq8LRUII6TqDWfybs8eJjifNbZA+T8tdcLypXpwmBcOeDYziSEEMbcq+q3i5rANEpThynoKzzLYwIZY+VAAShJ1jXT2N0FcAk8qFNvEwVs81puP7/tzNi0/qwyIKcdGg0HdnOOXSb42PjaQQpbQIz+41eOU1dM6fm0BxkMfJkmwSMuUK5AdbkGyBK7GenrCuygu2iV3iU4ry/cS8ug1SMJ/i41BKgci1nB3PjZX6gbItEbZ75C/9idcB6a7qPHzbaSelDmKyRZL54FI5ojemq6/2ikPRKfhn44atHHO8e/xRhLOfurnq/LS4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3o6ZRIycI/fKvEJReKgHBMeNaesh5VqxlO1vTG/R74=;
 b=hyZquOHZpF8jqoeBcnM9yLZbGrdZWa25QJuv/7r1LaQPnJ+a8ii1LGbgPcAdKoIvrbQIMC3T2RrTOyhA1AY3ovt+eYNfgc3d73nYkZJmVhgToAnZ0uip5bXgDdSqw9NSqRecRL/dZydbidRmzeHiLRln+XxjLtn49TDvXHHZU8dT3mRObADRdS0a2GJ8pVe/5gwLcaBmuso8CKJfvOL9Eev/O8OzeNxkxkqBo/Li8HpmrmDjq12v61ThBYdwpOoeMMFif5IJAERYZCwFKCpY6yNK/p7Md1HHYsbDL2w2MzrwofTgCmproNEJ7oLsxIQ7pwFiIDO+ei8Jg7Yo6Gf+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3o6ZRIycI/fKvEJReKgHBMeNaesh5VqxlO1vTG/R74=;
 b=S3SiYxLMVqr+miqEPyI2fIHCT7FTnPwfUt8w3llEwh4xT5OEX4A5jrmKUBvgWnaBkUXYfYGxV9fkROw15sXLZwAhFJuruH7XMPE01J0xFiEABfO31ExYvztrO8Oc4noSxBHsh3MorBvkJX/fE8kABIYnJ0VRhWmCMhJze19IEeo=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Thu, 22 May 2025 02:18:44 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 02:18:44 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amd/display: pause the workload setting in dm"
Thread-Topic: [PATCH] Revert "drm/amd/display: pause the workload setting in
 dm"
Thread-Index: AQHbynOCvRsL1dU4jEaiwAOndrJtv7PdW9IAgACOpjA=
Date: Thu, 22 May 2025 02:18:44 +0000
Message-ID: <DM4PR12MB5165C4C51F61C78E7D4929CE8E99A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250521171203.48711-1-Jerry.Zuo@amd.com>
 <CADnq5_PFkqRMHYpVvQQDFXh6dxancwyZMDNWEoM-cK6f0ra7qw@mail.gmail.com>
In-Reply-To: <CADnq5_PFkqRMHYpVvQQDFXh6dxancwyZMDNWEoM-cK6f0ra7qw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1d0037ec-0514-4d01-9582-eea5335c3779;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-22T02:17:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|LV2PR12MB5968:EE_
x-ms-office365-filtering-correlation-id: 2b379711-472f-4a72-4d38-08dd98d6fa57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTJ0UUpzWUtyKy9NNmxla1d5b0Q2VVRTZlh6TDBRendBYlBjLzVyTk1VUE9a?=
 =?utf-8?B?UHk0aGZaR3I2SnBwQ2gxWWc0QWo2Zzh3dlhycGRiY3IzM016K3Y4YUFmQkV2?=
 =?utf-8?B?T0ZsT3UzbE9sYXNUa1N5QVk3RjFKaWs2MDdiU01FNDRRZzQ0cHdDdXFuOVNu?=
 =?utf-8?B?NFUyUHRUQmI0Y0l3bVJxS3lOUVpnbjdUZmhmamdsV2JhWjE1TVhwSlgwVzJR?=
 =?utf-8?B?TUpDYnpTaUZQTUNoYmozcWtJcTNWVDh1blF5TUpVM25YYThtR2tZVzhIVTFL?=
 =?utf-8?B?TTZBM0N2RDZTMDUzSzZ3dGpCZk5JOHRjdkxGSFB3Y2xuaGlnd1BiRkI0UWhQ?=
 =?utf-8?B?TXdQVmlFUEJ1VnVRQ2ZNS3hqbHQxMDQ2cVk0Q3FMVTJvd21CSFgyR01zQmVm?=
 =?utf-8?B?bWgybHJXOTVXNkIxYnlRSW5vekROajNEUzdUNGI3c2ltY0hqNFZFTGhkcW1S?=
 =?utf-8?B?QTNMNjUyRE1HSFBheUpzdjRsSmhDdnV4ZTZVZVZEUVZKUFRIUndLamk5bFZK?=
 =?utf-8?B?aHJ5OU9sUnFYSEV5cGpMNTh3emNmUGlVUnc1VkdqSGlWNlRRdFhkcVAzenh5?=
 =?utf-8?B?SStWU0g3Qm9rQmNFSUdGODBKN3hVNUZRc2dSb3NKdXpGbE5OWU5uaEIxTnNm?=
 =?utf-8?B?SGhRY2dVSmxkaEhabjdWL0VSQ25BT2pvYVlZYTJ2cWJNS3g1VU9nWDhFUUxN?=
 =?utf-8?B?YzNKTVZSTzdtV1prTnU2SGRUMk5IZDAxdUFiSXpVNlFDYlRsSjhiNURGVDda?=
 =?utf-8?B?WVlJS3lkSVVzTEI0M0dwRXJjUzJKMFlHdkQvUTAzNWNXcGdsQ1BadXY2MVZ2?=
 =?utf-8?B?eG5PL0hWRU5NaGNJREdrMTRNcElWQnZvSGNxSldHNFo4T1lRTDB1b29kc3Nr?=
 =?utf-8?B?d1ZnTG9teGQ1d2UxRFVsZHgzSjJxSHh6ekFjREFsdXpjV2RHQThrNGU0eFg1?=
 =?utf-8?B?dWdpZ2lISUNHSUtZS1c4NmpjOVYwM0pNdlFrVDYvZDNOQ1pJdk5Zb0NGWnhI?=
 =?utf-8?B?V3ZONXNJMGFhbFVtL2lCcmNLaG5vMlN3ZVc5THZaTDZQVWsxSmo4V1ZOREpE?=
 =?utf-8?B?YWltSXROeFRXa29HZk1yOTRqOTQzS3BJZDludDUxQktvNTBnMUdheUxqcmFF?=
 =?utf-8?B?NkNBeTBKNTVFbFpYTjE5U01aSDZCTFg2dXBJZ3Q4L1d0Z2VwTXZlMXNzaWh1?=
 =?utf-8?B?R1B5bGFBQUJiaGxJOE5vUjVWc0o4V1dVb2g3OWtnWE85RDJ4SitUQWhyaUx0?=
 =?utf-8?B?eUhzaXRiN0NtcTlBQzlRVCt3aWd1WGxmWGVmM25PcENQTUtZUjJhUzU0clBO?=
 =?utf-8?B?dEQzc0NBQlE1OHhZMktwMVR4bUJEdURMeE1MMWlvaUo0YnVFemhsYkRQUWlz?=
 =?utf-8?B?eUdKNWl4b05jYVo5TkhXOVowL3RreEdKaFYrSnN2eCtBZUdOZ3NOOU80WWU5?=
 =?utf-8?B?T0RMQkpzdXFvRFNJTUZicHFvUGlxRmZNdzdjaDVWQXBtRmFoanJOUXZuVXNx?=
 =?utf-8?B?aHF6S0Y3a3hwMUxsSHo3SDNIbi9QZnJ1MWE0cjhZMlQyYVVPNHRyMVhKYlpL?=
 =?utf-8?B?dEZkSmZnMnFFay94ZnZ0RWRnSkxXT2k4YnRmOVozYjhkcmdWa3E0Uk1WWWht?=
 =?utf-8?B?eTIxaU83M2dJc21PUndYN041aDRpbG15Yys4Qm9tR3RmQ1dLTXg3bTFETnVJ?=
 =?utf-8?B?cGRMZFBuZGQzMnhObmVBd254NDVPZGxXRDQwVDBHM2NWcFFXOVgraHBqcENh?=
 =?utf-8?B?aWFUV1M1SWZsc3JXc3k3ZFc5NVpyeDJQVi9mNTgvQjdHQnNTbS9yMUl6ZHQr?=
 =?utf-8?B?bW9ZY1A2WUtlWTN2bGRYZ3hKZ0pNOEJOZVhVMTNjbXdnZk5lUlRlYmQ3cGxY?=
 =?utf-8?B?blM4SEI5UDk1NFpMQmF1ZlEzbkZXRXdESzVkenBoc1NUNWM3WkYyejJtR0lG?=
 =?utf-8?B?VWQ3Sk1NUzlZdXppaC9JQ1hscHJ1dFA0a1U2Z2g1Vll6ZkwrUjc3WmVoTU9R?=
 =?utf-8?Q?ossPgEFjx28bMMnJshUUBdrR+Jst0g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTI1K25Yc3pzaU5BMWFiM2JtU3JrVU5SWFUrNEYwOFlNVjFwNHN5SUU0a2w3?=
 =?utf-8?B?MnQ5K0F3TzI5ajlkZWszWnBCcmszSVIrN3JDZTAxUEVNSzFaRjA2Q01VUDR2?=
 =?utf-8?B?TnFVS3ZBS0pzZWRueW42V3FtNC9yclZpZ2EvYWVQRXJCTXJibkx2NjVldGFJ?=
 =?utf-8?B?a2FZSkRpWnVtck5KbXhTNHJzeURxa242SkhtNWtVTUl0WTNsUnRDY1FnUTVi?=
 =?utf-8?B?NEROSHZwRW1ZWkc1bUZKSEFqc0RCeHEzcHFDL3J5RXdCaVJ4YStvQ1IxNzQ5?=
 =?utf-8?B?NUxKaHNZbFdsY2lGU01RendZS2hnSDRyb1UrV3ZnTDlDd3ZIZFdQRHJvUGg2?=
 =?utf-8?B?R2FWZG5HaGRpRW9TSWFjUnVVVnNHd2xJWW1wOUFnUzE1Q3FYU1JKZTBscWph?=
 =?utf-8?B?eExxVWtHRkdJd3RoclZWRk52SDNKTklwRWNSSFViQmZ4dFJ6Vk8rV3piZXRn?=
 =?utf-8?B?N09DdWlXQTFqUkVjLzJWTjF6OUVJamZLZUtQaUpXM0xDeDNreEVGUzZ1OVV0?=
 =?utf-8?B?Vm9mYnJqVWxDN05jOFZzejBNT1V4TzJLb3h1SkVBdnpVR1FteHc4OW41QUJp?=
 =?utf-8?B?bS9hRGd2UmtTdWpvQUdETnR0QkpTOVFkVTRhcFpMaXA2ZEF6akRFYXQyaVVv?=
 =?utf-8?B?eEgvMURQNVJ0QlNPNUNLNVFTaC82Ry9hR1BQcndUVDNxWC9jQzcwMTkzSE1W?=
 =?utf-8?B?QjZPVlljVVFMU1hadmJnaTlzLzFKd29mVXJuRUJpeC9BMTF0RU9reHYydnNs?=
 =?utf-8?B?SC80NkZ6MWUrVFV0ZGt0TzMwUjZ3MVJ3T0lRWllCb1p0d2tQNW94NHlWNGNI?=
 =?utf-8?B?MThlYUdvTktDYVhSZTA4Mm14SFRoNUJUQ1g3N1N5cmh1UUQxbjFVYjg5SXE4?=
 =?utf-8?B?b0p4S1FIZloyaC9ZY0RIWTl1SldXeXVwRWxLbDFtSDdGWUY5UHZOMVZoRkZK?=
 =?utf-8?B?dERkbVliZkpoeFlNYStOdWxpeURZbTIzc1JBcklxNDV3RGYxTTE1V3EvYWZB?=
 =?utf-8?B?MTM4YnNkNGE4T09naGMzVlR2WUl1WStXOVBNTGsxMmRWTHZIRnRrWE1xOUp5?=
 =?utf-8?B?MDQ5Ri9kTDVUdGFvQ1d5MTQ2QlJob1BKQk9TYnhxbEJDVkdPRUVIZkRUaXla?=
 =?utf-8?B?cElIelpPZzA0M3A3MVFoUERPVlVZOXg2bnRnUGxDS0RQT1V2a1NMVmlUSzZ6?=
 =?utf-8?B?YnNBMnJ3czNwTWtVRVBkM1pVQ1B3RGJFV290K28xanc4Y1FDNnE5Mnpuajkv?=
 =?utf-8?B?NHJBbzhBbExCZkdrcTZmR01KTTdlcndpaVZ1UTRNZFBYMGVzV0hrMXpLRUhi?=
 =?utf-8?B?d2pRODR3R0dSWkJyNEgzcXd4T0xqZzBBSjZhdVFtNnFOeC9NMVJzR0ZySVZF?=
 =?utf-8?B?amVSMVM2RVdLMUFNNmZabVFUcmpwdHVVRWVXYWFLUWNSRHI1NEVDL0hRYU5Z?=
 =?utf-8?B?RVo1dVg4SEJsaUZ3UmZHT050QkZyc1YrUXk5dG16bERoRURmalZzU3c5UmJi?=
 =?utf-8?B?eVFXc05rNU9OVUlhdEI4VDM3d1hEcDRnajZkOUdDdGwrSUpidUFXbDM3bktR?=
 =?utf-8?B?TUxvcExpZDRPbjFFb1dRKy9yb2s4YWZ4a2hVc082eG1wUSsrS0phd2VRbGZJ?=
 =?utf-8?B?N0s3QklHNzNQaXFwZlVjSHAyMUhJdjlhcUh6Vi80bkQ0MERsUk83QmJUOHRx?=
 =?utf-8?B?Wi85WkV4SDVmejJubHpCZzd3Ynl3NE5LSW5ZNTFxQXQxTzJ0c1U2Y0ZYa3hQ?=
 =?utf-8?B?VGhVSU1jdmh1cldkMEtkekJVUTk2bjRJd2pLU29QM1lZb2E1aGFYNklKR3c0?=
 =?utf-8?B?emtObVdKQUFXcXJaTTJ5Tkk2c0YrbTB3by8rcUFMd3RDWXduVHViWU9GQ2gz?=
 =?utf-8?B?c3ArbEFBaUtxOUVIQUQyQ3hVSVQyQVVKUFpvZHFJRmhpbE5NUlhjQktZOFR2?=
 =?utf-8?B?Ump3alFmNU9LOC9lREJ4bDAwUFVGSWkyUEEzZU1sL3dONHMySGFSK3Ywc01v?=
 =?utf-8?B?NVhlblJZQkJuTWNEaEd5Y0pNUXZoZ2kxRzd4cFlRSWdXalc2MkJSMWxKMDJU?=
 =?utf-8?B?NGkxK3FJQUVuUzB5VTBmQWpXM3hoUDJaQUdKUzMrRWtwSWZPL1BNYUJHRnZo?=
 =?utf-8?Q?1SWg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b379711-472f-4a72-4d38-08dd98d6fa57
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 02:18:44.6397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3+BShnNmxbXpp8iqhoTAMfU8sc9vJ0tJ65k6v5o8PmkKm5fGjmZmICM06lbVVEl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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
Cg0KV2lsbCBmaWd1cmUgb3V0IGFub3RoZXIgd2F5IHRvIGZpeCB0aGUgTUFMTCBpZGxlIHBvd2Vy
IGlzc3VlIHByZXZpb3VzbHkuDQpSZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZl
bmdAYW1kLmNvbT4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBE
ZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgTWF5IDIyLCAy
MDI1IDE6NDcgQU0NClRvOiBadW8sIEplcnJ5IDxKZXJyeS5adW9AYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFt
ZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgImRybS9hbWQvZGlzcGxheTogcGF1
c2UgdGhlIHdvcmtsb2FkIHNldHRpbmcgaW4gZG0iDQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBv
cmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0K
DQpPbiBXZWQsIE1heSAyMSwgMjAyNSBhdCAxOjEy4oCvUE0gRmFuZ3poaSBadW8gPEplcnJ5Llp1
b0BhbWQuY29tPiB3cm90ZToNCj4NCj4gVGhpcyByZXZlcnRzIGNvbW1pdCAyNDM2NzhkZjdhMDU4
ZjY1ZjVmNDNlODAyNmIzNTliY2M5MWUwYjY5Lg0KPg0KPiBSZWFzb24gZm9yIHJldmVydDogY2F1
c2UgY29ycnVwdGlvbiBvbiBEZWxsIFUzMjI0S0IgRFAyIGRpc3BsYXkuDQoNCk1pc3NpbmcgeW91
ciBzaWduZWQtb2ZmLWJ5LiAgUmV2ZXJ0aW5nIHRoaXMgY291bGQgcmVzdWx0IGluIGhpZ2hlciBw
b3dlciB1c2FnZSBiZWNhdXNlIEkgdGhpbmsgdGhlIGRpc3BsYXkgaWRsZSBzdGF0ZSByZXF1aXJl
cyB0aGUgZGVmYXVsdCBwcm9maWxlLg0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbV9jcnRjLmMgICAgfCAxMSArLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2NydGMu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2Ny
dGMuYw0KPiBpbmRleCBlOGJkZDdmMGM0NjAuLjg3MDU4MjcxYjAwYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fY3J0Yy5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2Ny
dGMuYw0KPiBAQCAtMjQ2LDggKzI0Niw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9jcnRjX3Zi
bGFua19jb250cm9sX3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgICAgICAg
c3RydWN0IHZibGFua19jb250cm9sX3dvcmsgKnZibGFua193b3JrID0NCj4gICAgICAgICAgICAg
ICAgIGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdmJsYW5rX2NvbnRyb2xfd29yaywgd29yayk7
DQo+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIgKmRtID0gdmJsYW5rX3dv
cmstPmRtOw0KPiAtICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2Fk
ZXYoZG0tPmRkZXYpOw0KPiAtICAgICAgIGludCByOw0KPg0KPiAgICAgICAgIG11dGV4X2xvY2so
JmRtLT5kY19sb2NrKTsNCj4NCj4gQEAgLTI3NSwxNSArMjczLDggQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X2RtX2NydGNfdmJsYW5rX2NvbnRyb2xfd29ya2VyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
aykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdmJsYW5rX3dvcmstPmFjcnRjLT5kbV9pcnFf
cGFyYW1zLmFsbG93X3NyX2VudHJ5KTsNCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAgaWYgKGRt
LT5hY3RpdmVfdmJsYW5rX2lycV9jb3VudCA9PSAwKSB7DQo+IC0gICAgICAgICAgICAgICByID0g
YW1kZ3B1X2RwbV9wYXVzZV9wb3dlcl9wcm9maWxlKGFkZXYsIHRydWUpOw0KPiAtICAgICAgICAg
ICAgICAgaWYgKHIpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGFkZXYtPmRl
diwgImZhaWxlZCB0byBzZXQgZGVmYXVsdCBwb3dlciBwcm9maWxlIG1vZGVcbiIpOw0KPiArICAg
ICAgIGlmIChkbS0+YWN0aXZlX3ZibGFua19pcnFfY291bnQgPT0gMCkNCj4gICAgICAgICAgICAg
ICAgIGRjX2FsbG93X2lkbGVfb3B0aW1pemF0aW9ucyhkbS0+ZGMsIHRydWUpOw0KPiAtICAgICAg
ICAgICAgICAgciA9IGFtZGdwdV9kcG1fcGF1c2VfcG93ZXJfcHJvZmlsZShhZGV2LCBmYWxzZSk7
DQo+IC0gICAgICAgICAgICAgICBpZiAocikNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGV2
X3dhcm4oYWRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlc3RvcmUgdGhlIHBvd2VyIHByb2ZpbGUgbW9k
ZVxuIik7DQo+IC0gICAgICAgfQ0KPg0KPiAgICAgICAgIG11dGV4X3VubG9jaygmZG0tPmRjX2xv
Y2spOw0KPg0KPiAtLQ0KPiAyLjQzLjANCj4NCg==
