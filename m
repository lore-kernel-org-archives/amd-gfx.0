Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCCAC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 17:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367D010E773;
	Tue, 25 Feb 2025 17:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hYtWjj0L";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F72210E773
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 17:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw5kA6ZJNULUgbdJFYPTo2SNXN4WTkLpWeDCPBH9Q1s3ir5GH5C0LWgwgm3tOA3gm56A9ll2K3rwl63spBhO1iu+q07m7OesbRyK+7iPPeBc7BApoZfXRwlJDC9aLJzBxQGehW3khnBZMpoFRjjmASV0Nn4up30xn4Rgx32ZLecCVTHDyJPfMV4vRofpW5RrwI4a6l2JeXj8vThr8SlU4s+ZPs2b1oKS512VcbSASc4LmDQf0tc9lyrF+RGVESSVUlciASVoXWhr0PVCLB376e6/OnrVKMueaQB5HZ0spXZLdCK2Ho/z4b0LCdyBbX44Zuv6lwkqKxY8k6miibm6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A78I8tUY3b/vr4RVIIYe24PUVQ5gvyxnG5WRIbDCMIE=;
 b=jPARi8v8XUn8a62Y3SA9c3CH3qbEbd3zrmQLO1aaZy+SYVajdjHbTw2sakaERlcRkcoSjNFTX2wfnfS8nlIQhQ5uOXfYxRBktlEprKWxDv1bpauM2RqFx9indzJ6Dqk0azezYaE+MaKD7QYtfTQR6pcLaTevyO+8uV1e6fn+Qbag6utidKNVNxrqKx0gCBmi4oXZTPNjotlKMAcdd+qHGyOZ1JhBtuyMfGP1jrYnWQrAf0951DumykYlFy0phtIrtrc0bYl5TBqxgaWd70M/UFrb+QoYGpYMb3CVz00pUbA2/zqW1IQ6mRLZzK67TFQe4oSEMDmvbUgLAmnNWYvlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A78I8tUY3b/vr4RVIIYe24PUVQ5gvyxnG5WRIbDCMIE=;
 b=hYtWjj0LRDq8sZ2lwZIm9MJVUSPOSXwsac9SDIgGOCpwYd+eD7WaIQBoyS4Nv4DYFP/IL1/KCk5jCQiNnYObftW8gWzWvT55chedETLr6oHwk8/Y796kzQ9Ca9hlVS8KcwAWZfijI+feJhSnG59zdfV2cVuRucfy40oJbfYClPU=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH1PPFB21296325.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::620) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.23; Tue, 25 Feb
 2025 17:17:52 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 17:17:51 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes11: drop
 amdgpu_mes_suspend()/amdgpu_mes_resume() calls
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes11: drop
 amdgpu_mes_suspend()/amdgpu_mes_resume() calls
Thread-Index: AQHbhG/iLLUtndc8/Umrc6H2QliTa7NYJdYAgAAi0fA=
Date: Tue, 25 Feb 2025 17:17:51 +0000
Message-ID: <CH0PR12MB537243151E1B7467E162ABFAF4C32@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250221144933.3440420-1-alexander.deucher@amd.com>
 <20250221144933.3440420-2-alexander.deucher@amd.com>
 <CADnq5_OXuxHMXfFaex3MD8WF8kx-yGDZ9eGR6u3VjHBTmDO9vA@mail.gmail.com>
In-Reply-To: <CADnq5_OXuxHMXfFaex3MD8WF8kx-yGDZ9eGR6u3VjHBTmDO9vA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=98e2938f-7aef-419c-904b-b3d9c33b6637;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T17:14:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CH1PPFB21296325:EE_
x-ms-office365-filtering-correlation-id: 7d26e0a3-7eea-46b8-37ea-08dd55c055bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2l5cEpsRlUvR0VrNEllK0ZRUGlORk5DbmkrcHBBTktvWXoybHpoTGppTmZV?=
 =?utf-8?B?aitRTy9pMCtNTG5pU2l4dVprSzVPV3FtTDlCdmFTczB0bWVtOWo1eDdsL2xT?=
 =?utf-8?B?NUN0cys2eWZCT0RxYnFrUUEzczMvbDc0TEVrRk5xdDhSQ0FDMXdGTFY1YkU2?=
 =?utf-8?B?NjNIcHlqd2Y3b2ZTcytjdjMrM3JNMndkVm9vUGNmSi8vek9tbzU0MGVoRHU5?=
 =?utf-8?B?RUQrWDFjOEY3NXE3TVJMTWVHZWkrK2JCQkM5ekk3TlpRcVBRVUlLRzdvQVBW?=
 =?utf-8?B?bms2bzg0WHZRMkJqZnBhL016cmQ5THlqVFg0OHd4NDdnVnVHRitQMi92eXNt?=
 =?utf-8?B?bm4rREJrRHMzV2Q2NVU5QXp2TUVvUDkvdkh1K2NkZWUrTEg4ZENYbVVXVjhB?=
 =?utf-8?B?QnlDM3BsV09JQytiY29UTjVWZ2xuSDZMYUFOTVNzS05xSFIrQVNoT0VWYU1Q?=
 =?utf-8?B?WHo1MzN2WHUxbTRPMi9BRk9lcWxnNXE2V3JLOFZkTnUwTG1IQ201OGdqcjZM?=
 =?utf-8?B?RHFObmk4cjNBMlYrTE8rb1VzcW83L0JjdTJzTVBQU0hHdUdwOWVaVzBZM2N1?=
 =?utf-8?B?c0tRZ09XNzBOZVBzdEN3ckRaUzgvbmdlSEZueS9wcVp6dkFtY3hmbEthK2NF?=
 =?utf-8?B?Qml0VENGMDc4Q2J4RnZEQWdOcXNOd09tT2NXZmhsYnJvRTk5MmZjRmxRYnNS?=
 =?utf-8?B?S2pWNy9KZ0c1UjdjVHNDVjZuRUp4UFQ3SU53czlDaEk3eEdvMlBZODB3clRL?=
 =?utf-8?B?cWlnUnlIQ1YwS0ovaUdnZGx6WndaL0xKN1UrTTVQM1ZOVVhzenRxdTYvYlE4?=
 =?utf-8?B?UE5TOTExZjNkL1V1d25Bb3dMbUZ6VUxPT0xBZ1p0NDZpbkZFckE2WjFzQjNp?=
 =?utf-8?B?eXU0NjF4ZStNWTZNWlhyMkVqaXAreTdUSm5SOXBLUDVoM1B1UXR2WlN3N0VT?=
 =?utf-8?B?a2YvSUM3d2tkWitRNkF5ZS9IR3hXd2RLM3EyYmcxdmZrVkdCU0NyS0FNd2xE?=
 =?utf-8?B?RUpGZzNYYTZHVkZsRmVRa0ljb242Tmx2cXJ0ZmRueUNmeTBWMm92MTRKMzU3?=
 =?utf-8?B?bkpNZXAxYTBNckx3ZFdGWU00ZG5TVk82eTNPcXVYLzRuejVkSVJEdU9tWkJP?=
 =?utf-8?B?MVZETWxDd1hHaDgvaExDYjJqSkQwVjF0TWd4MDN5UFdxT2YyZ2JWZytianRy?=
 =?utf-8?B?VndGOEVUZkxUUWphZUt0c0xRd2MvbjdHRC9LV2hqbmJ6T3lzQmdKSktPcklZ?=
 =?utf-8?B?b0lOR3NSazM5SmJvaGhLZW1vUEhLZzNMTjRLVDhFS2xQUC9XZnRFUEhEbUh3?=
 =?utf-8?B?VHBsRUdYcW04OFBmZW1QSXVVYXNpTEVYR3MyNDdDZHhBVk1iSEJ5SnRnbnJQ?=
 =?utf-8?B?b1N0TXVKV25IUHZCcXAzRDNoU1RMTys0RDErSFRvdjVOcDM0SkdVczhLdkNV?=
 =?utf-8?B?K0JNUlZsRFIvSDUvUHJqNTZ1Mk5OaXZ2V21POE0rdGFlM3I2R3R5MnZlYWcz?=
 =?utf-8?B?RXY3MFBJTFY1ektER0ZVQk5kOU01aml6ZTJlcjF6cUJncHQwOWpNOTlCdXFJ?=
 =?utf-8?B?dVNSZzBERjYzMWtvVkdDUHBLaGdXQnFTOXJ5cXVaaDhUWHYzZ1dsZkhkeXRq?=
 =?utf-8?B?VUhPQUczaFA2WWxFNTVOeXFZeW1lblhQbFRWcTRlZGc3bEhZd3VDN2RTUmI1?=
 =?utf-8?B?WlBPd3cvMlhRM1lwM1lRY1VDb0tJR1MySGJWOHhJakRSSWZraGJxN1kwL3ZO?=
 =?utf-8?B?Ni9LMXpXZkd4NjF1YzRvNlNUV3VWbHRadGVERldReUEvZ0FUbHl2UTRlMTlq?=
 =?utf-8?B?OHRib0p6S1UyL3Z1T3dRYXZqeS9vOHpRamYwYnZnZ1Q2TWRJanJMdExNREls?=
 =?utf-8?B?ZFB5UVFFcDl1UlVFbXc2TzJYUGpyZEZZZ0Zjbi9yN2tqSnJ1OGtIaWt4RWM5?=
 =?utf-8?Q?XpoHsFEohBHn2e3WviyCkeDdRvnH93tf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VnUWExcGxueUdTWUY1Y0grZnYyV0dKRzUxeHJEcU5SRDJXSlRDcDJjSnBa?=
 =?utf-8?B?QTVVZjNmQkVINW14Z2V6TVB4VG1sT3hiME9jamJkUDhPQzlQTUMzU1ZXRG8z?=
 =?utf-8?B?RXFIMkY5MVM0b1lYbEYxL0tGNHVPRk1yZEtwcjkwWUdqaitNUXFUamJqblpv?=
 =?utf-8?B?Rm1RODlkcEhTM29jaGxuR3I2c1h0dTAxQ05vNUxqTnpGYjFqY2t6K1dleFZ3?=
 =?utf-8?B?UzdyVk1FZEhPcHVHU1BxR2NLNkhSV05pLzdabFdqWE9KUUw1dTVGeTRjdXN5?=
 =?utf-8?B?cDJjNHhOb0taWTJMU1RhbWpkM3diNHQ3dzExVE5OYlJwcG5kanFPdDR5Mm53?=
 =?utf-8?B?Qyt6YU1tUUZEYmZUcithdmtUY1JMbndHald3ZzFaenAwR1RULy9OTW9veDZD?=
 =?utf-8?B?QnlIWDg4NGZ5SFpuaWRLMS9tWllvMmp1Sy85ZGd4amF6ZGMzUmJkcXQ4V2Z0?=
 =?utf-8?B?cXB2ajE3QnRpTVJhYUZkVFIvdHJHVmJGS3JNTjRyVnJtaDVCNzMxcDM3YXpy?=
 =?utf-8?B?TFRFb0VxeS9BbXducWFuNy94Zm5ReFF0V0JqUkMxRGhHdUlIWVI0a3ZYc2p1?=
 =?utf-8?B?TmRCanZZc1lGQWhRRVc3S2ZPRkxGZVFrL1dZaHRaUVN4K1dZdmlKS1l5eFNx?=
 =?utf-8?B?K2NEazVHcmd1ZE1rSG5rVlZXMnd1K0hLRy92Uk93UjMrYVpCWExHK1RFd0Vv?=
 =?utf-8?B?eWpIa3E2WlgyWDFVMHEwZFBNTVlMWUYyZkxUT0UwZWpXcHdyanpMaW8xWGgw?=
 =?utf-8?B?TUdFeGZsWXhGN2FUOUdxMkdDcFBoeFRleTExVElqS08rL1lEZDFwTVBlREh6?=
 =?utf-8?B?dEQxeU1OWERSdVZiWEhXMEQrMEhYTWRHMlB3cThiZzhjU1ZIRGZuWk82aS8z?=
 =?utf-8?B?ZE1xRUExL3NTcEN1c0R4ZzRNa2pYKyt2VmRhdUR2bEYybzc1VlFYRzFraUxr?=
 =?utf-8?B?RWNyNTZhR0VKTXRmc25UdmhLYWExQXErU3hCZ3V2bUZkZFFzS0tvYXVCQ1Bj?=
 =?utf-8?B?TlZxMVlRRVA4ZU9UTzZFb25KbW8yL1pleEtDMk55dmJldmVPYVAvRXZpNEZH?=
 =?utf-8?B?S1BQVmZ4QXkwL3ZGelZXeWxPVGNhRGNwZk5IRU14dkx1Q25yK0h1WkFQWnBl?=
 =?utf-8?B?OGphY2djV3Y2YTFYa1o4Z0JnQ1dlaXZvbHhvbWpldHVadmJNSTdJKy91V2JV?=
 =?utf-8?B?U0g2cnF0c2RRUEtERTZvRnJrUTZjd1JsN3EvU3IvTkx2UVhEbitMdTJZalhE?=
 =?utf-8?B?ZjU5dklMSUlpakw0M256dTlnTk1pM05IZ3JSU1MrK2lMbWcraDRLbzJnaU1o?=
 =?utf-8?B?SmxUMWkwNUNaZmN1MHhWY3E0M2hwaGdhUGU5NGFjNk9OY3FKQmFKbnI0RWl4?=
 =?utf-8?B?dm01V3h2SitrY1h3am43cGkrWSt5TzhYRDh5b2ZGTDVyajZTb0k3WU93L3k0?=
 =?utf-8?B?MEhHMFBBbi9SaG5RTzdzZW1GRG9USmUxNGE5WEVCNUlpRlVteVJOUXdpUDBQ?=
 =?utf-8?B?czlKUmR1V1FldW5KZVoyVkw4SWNhSXFsM0dFa1BuaWlyeWV0UE8vZWN3TjE0?=
 =?utf-8?B?dVM3RC9wVDl3dkRTeEU4aUhJZG1vcUt5SFlEY1dXaFVhUDBEUkczdmdYaDQ1?=
 =?utf-8?B?Rm9welVSWlJKTjdVVlpsQy8za3h1VXNrU1djQmIyU2dSSHBJN2dndnVENVVw?=
 =?utf-8?B?MkZZQVdCYkxtTlpXRmloRk9vQ2FZNGJnZG5ER29laUdYQlIybldKdzIrMS9F?=
 =?utf-8?B?M2tGb1RsY0FZRHF3aTRDSnRXZUk4QzFqdGs5eFE5c0tta0hpWnFxdjV3bUda?=
 =?utf-8?B?dG5aUDd6NlJDNVhSK3h6WklRUDRaRTBDN1NLVGhFdm1qK1dFM0ZlUXF2UTV0?=
 =?utf-8?B?RFhORGhDR3RweXJCU3YrbXRQZjNDYVZVZW5zWGhORUhQc3FLcVljM2N3WUNQ?=
 =?utf-8?B?UDJmT0lBM2J6U2t5cFY1YW1EczVtYlh5YnB2dUdwY1UwckhmNW5vT0d6TENl?=
 =?utf-8?B?VkZVbEpCRGxNNG5oRmYwTmo5SFV3RkdBL3o2R2RRWUlaT0JndWVuNmlIUzhk?=
 =?utf-8?B?UVJxRXVTUHRwaUNXdllCUVh4NW1GRHNSQ0lnTjZDQWQzK2pST2xUNkxYU1Uw?=
 =?utf-8?Q?+qBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d26e0a3-7eea-46b8-37ea-08dd55c055bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 17:17:51.6854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8wuSyBD5UOGKv0hvBwQMs0bBdP6aNuFx0x10PSd6B0ew0KYpJS6QeTI5aVXpDM3fk7DpT/7/zoYbE9PuvecMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFB21296325
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
Cg0KVGhpcyBzZXJpZXMgbG9va3MgZ29vZCB0byBtZSAuDQoNClJldmlld2VkLWJ5IDpTaGFveXVu
LmxpdSA8U2hhb3l1bi5saXVAI2FtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNSwgMjAy
NSAxMDoxMCBBTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzJdIGRybS9hbWRncHUvbWVzMTE6IGRyb3AgYW1kZ3B1X21lc19zdXNwZW5kKCkvYW1k
Z3B1X21lc19yZXN1bWUoKSBjYWxscw0KDQpQaW5nIG9uIHRoaXMgc2VyaWVzPw0KDQpPbiBGcmks
IEZlYiAyMSwgMjAyNSBhdCA5OjU54oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPiB3cm90ZToNCj4NCj4gVGhleSBhcmUgbm9vcHMgb24gR0ZYMTEgZm9yIG1vc3Qg
ZmlybXdhcmUgdmVyc2lvbnMuIEtGRCBhbHJlYWR5DQo+IGhhbmRsZXMgaXRzIG93biBxdWV1ZXMg
YW5kIHRoZXkgc2hvdWxkIGFscmVhZHkgYmUgdW5tYXBwZWQgYXQgdGhpcw0KPiBwb2ludCBzbyBl
dmVuIGlmIHRoaXMgcnVucywgaXQncyBub3QgZG9pbmcgYW55dGhpbmcuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYyB8IDE0ICstLS0tLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEzIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiBpbmRleCBlOGFh
MjgxODRiZGQwLi5hNTY5ZDA5YTFhNzQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tZXNfdjExXzAuYw0KPiBAQCAtMTY4NSwyNCArMTY4NSwxMiBAQCBzdGF0aWMgaW50IG1lc192
MTFfMF9od19maW5pKHN0cnVjdA0KPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPg0KPiAg
c3RhdGljIGludCBtZXNfdjExXzBfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9i
bG9jaykgIHsNCj4gLSAgICAgICBpbnQgcjsNCj4gLQ0KPiAtICAgICAgIHIgPSBhbWRncHVfbWVz
X3N1c3BlbmQoaXBfYmxvY2stPmFkZXYpOw0KPiAtICAgICAgIGlmIChyKQ0KPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIHI7DQo+IC0NCj4gICAgICAgICByZXR1cm4gbWVzX3YxMV8wX2h3X2Zpbmko
aXBfYmxvY2spOyAgfQ0KPg0KPiAgc3RhdGljIGludCBtZXNfdjExXzBfcmVzdW1lKHN0cnVjdCBh
bWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKSAgew0KPiAtICAgICAgIGludCByOw0KPiAtDQo+IC0g
ICAgICAgciA9IG1lc192MTFfMF9od19pbml0KGlwX2Jsb2NrKTsNCj4gLSAgICAgICBpZiAocikN
Cj4gLSAgICAgICAgICAgICAgIHJldHVybiByOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIGFtZGdw
dV9tZXNfcmVzdW1lKGlwX2Jsb2NrLT5hZGV2KTsNCj4gKyAgICAgICByZXR1cm4gbWVzX3YxMV8w
X2h3X2luaXQoaXBfYmxvY2spOw0KPiAgfQ0KPg0KPiAgc3RhdGljIGludCBtZXNfdjExXzBfZWFy
bHlfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gLS0NCj4gMi40OC4x
DQo+DQo=
