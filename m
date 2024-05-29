Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3455FC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E8610E27F;
	Wed, 29 May 2024 13:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MB7MQ+yi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80AA10E27F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 13:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwuXj8G//twYzxLaWduu8bPg9Al7bK3hV7hhfMtcvSf0o83VEBzxTv+J3CT0AcC5J8L792Uvs+QiMLxIqC3xXUH+eLOKISwWxe7o2wPN7KVUQfr5UAt+ETrC3OEDoY78yF4yobrn6D14rmrD9OXoUGjZmaZA4uGR17k5Dj3UY19nI6JM9uIqzlRZ8LmVZiImkhz6DBxp0zXP4LuJOX2OHkYAqkVoxHtPe/F4A/415ykXzL4ihwaF0Gbcbmq+ueiWoKX6u/JKolPAVaWmkywVTdp3RLOHFHmjLoVOFEt8oOk33omHSJQVwuad4HEShEK3LLPg3GbwdXkCqohPRH0+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWqqUB1eWuzjv7cZemyE6Xlrdy/NT7L5ayggwIDrrlU=;
 b=eT3bZdo9YFVSDmyQG9DEE8D1kUeWx809avBLcs0gto2IAUeE9x1pFdtL/b9cDqqYn2LQMVP8iEFzy5Q8HEn3X5Yppv7lWVYvol6MpKfA0qLq6y6pGDLUkBJt3RdtWxz4rp3iTj7ggAnY5+xxQ8iG7EjSOgKFqpxFiRzNuoLIdoIXc8ziqcqXTJcAFpz7TgmN9hGHWJNyGCcWaZoCJj7IuItOBmcNtACYtv3aDN1gvnrCQ1zb/FeYJXjziJWZZcrDIQyglZn4Vwd5kSNkMwQg/MYwObFSCbaJu8xp0HSbyQqIXIfvkiEgnrZj54V8LaOk0WEF+l1d1OAhM9lzdxLTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWqqUB1eWuzjv7cZemyE6Xlrdy/NT7L5ayggwIDrrlU=;
 b=MB7MQ+yimEiPMqkyAwybjuNtDNWpAnuKLrYoF51GmjOYFYmFGeavZANAkbnyvxDuRK+UZQTKOimEkdxSHYiYgRyY3fN4+AzzJcxLClNu+1s7S3v0FsOZ2cCftWuFFRx63K7caDQ5TXUSyVvZJsz1RzSCbu5e7WrgykGxJ4c2HHI=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 13:22:18 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 13:22:18 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Topic: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Index: AQHasSPj5dWiHd7YP06y4F37f071D7Gtw2cAgABr2bA=
Date: Wed, 29 May 2024 13:22:17 +0000
Message-ID: <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
In-Reply-To: <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=823d83e2-225d-421e-84e4-22bd2225dd31;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-29T13:05:14Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|CH3PR12MB9027:EE_
x-ms-office365-filtering-correlation-id: 39550d8e-e235-4b56-bec5-08dc7fe25d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?K0NKN3BpcXBDTUlRRXNXVDcwS01wSGdnSnlIZ1puVnpxajluTXlNQlRiQ0hL?=
 =?utf-8?B?T1prL2Q1bFRabjh2OVVFdnROYW5KaHp2MGEvWGxGbzNlWFMvVXUrWThvVjha?=
 =?utf-8?B?VFpQcjFqTzFRU1pTWnRiMHVMN0VDWWN0K1crZEV1dncwTkVLTU84QjMyMUk2?=
 =?utf-8?B?bVZYMGRFcFFoOE1zdWdXUDJXbW5FNUIydmhDTUZheTBkbmNsaXRiMWZTOFc3?=
 =?utf-8?B?VFkwano4N1lVbkpqOENxRmhSaVl4UVIxZGpoUDlReHFtS3dCZDV4ZXJ3Y01a?=
 =?utf-8?B?UnozOVBwOGFkUWdRQlQ0VktERm1HZ2ViR2RwYTM2WUxhQS83OU9mQTV4VVFV?=
 =?utf-8?B?RU9pR01BSnhBYjFRNDBIODgrUFlGVnR0UXFKNHM5UHYrdUJ1Q0psRzBVM1dG?=
 =?utf-8?B?L05tQmRtcmowMnNwcHUyN000Smc0MWl6M3huUU5wY0tLRjZ2dnBsS1YyMCsv?=
 =?utf-8?B?dFVvekhIME9VbVVxRDYwYXhWMjhnVEtYeDY5WENSRGJQOVh3UzRNVlBsZUlO?=
 =?utf-8?B?alArY1JYaXlKaGx0Uk8rUFlyQ3UrRnFUZU9rSTJPbGpIL3NRSC9PY1pJZlV3?=
 =?utf-8?B?dnVyZld3TmJ3dEovWVZ4U3B2bEZYZHIwc05YanlYVG5DeFQxWm5PVEdoOWY1?=
 =?utf-8?B?T2UvTzQxN0cwdGx1MlEwWmsrWmNPYktMOE5ETE5aWXB6RTQ5cmREcWlMaTJH?=
 =?utf-8?B?d3VXblNxK2pEaHhJU1NHUjJkRDFkV0x0UXVDaHhOdjMwMXdaOTBiOW04NCtU?=
 =?utf-8?B?L09qbnhWTDNYbUdsMGFRR25GZ0tKRlR2Z2N5UWFBSHBsU08xWG1ZbFNUQ2ZO?=
 =?utf-8?B?eHJYanFEcVJ6dS94REhxOE9uNk0xK0t1MHI0dXAzRFMvR25IUWYxUy9ZOTBo?=
 =?utf-8?B?cnBJeVJiK29oOUVCUmo3N2RmTFR6djNJZ3BIQ25WdCs2ZzRVdS9ubWN2V1Qw?=
 =?utf-8?B?NHdvQlllaTFlRTBPQWpkWGNtMzE5N2ZNcFdzWCtjRURFTkdPTGY3UXV3b1FC?=
 =?utf-8?B?WU4vRXk3Zjd4N0xtVnpxOFpiaURFa3NNbXJSbHEyV1RXT25vUzRFSGUxQlV5?=
 =?utf-8?B?d0hqMi9ESTFidm4zTS9aU20wS3IzMjM5eGt3eGZhZnpBcXpENWNHR1hpZjZM?=
 =?utf-8?B?RkJLZlc4RURua080dysrSnhzdyt6Q3VZNGg4YnVTVEp3RzJpMjM5azhqZUYz?=
 =?utf-8?B?RDlKU09oYWlSZ2poKzFkRGpWQllmWjFjM2o0UnpHT0JzL1NQaDdML3JLb0FM?=
 =?utf-8?B?TEpWb0hBN2p2VEQvalU1QThwVm9FSTIzU0JvY2NXUDNjc0diald1V1ZRTmpH?=
 =?utf-8?B?UWRtR3FrU01oQzlXOXh5YlJFLzQ1alIzMktsWURWT1NsdWVnT2dvTmVVUis1?=
 =?utf-8?B?Sy9sTExWNDVCN1lqLzFTR3NKSkZYdUp0cDNjQzArWXd1Q09GVG5yU245Zy9M?=
 =?utf-8?B?QURaa3ZiWDBwMCtFVWVhNGpMck03VmdsdG9TN0lFRTR4TnlpbUdHSUhEWmhN?=
 =?utf-8?B?RjBDaU1mWU5sYjgxR3RPUUlzaTlDYWJmRkpzUnZqd1Jnd0NrR2s4eTVWNmdX?=
 =?utf-8?B?ay9pbzk3NmpybGtjZWd3b0hFWEg3RldBNGxMc0xJcXYzK2xmb1RpTTZSUTZN?=
 =?utf-8?B?RnNubXgrWnBnVmdPbW5xQzFrOUd5VnRtZ2VQNGVFc1pjTUxMWG5BcUpMWUo3?=
 =?utf-8?B?N0t1WkNNcjFPeVNrbnNYWjNlRkU3MWtXYmxTOUFEenJrOUJkUncrTkF3elhl?=
 =?utf-8?B?dE9tOWNuOHVFU0RQdzRqRjNrelFkZnpVTyszNnNmVDNBZ2tlUG04dWtOemNP?=
 =?utf-8?B?S012YWJ4U2NNenkrNy9TZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJvVVNsTnJaY0NSSE5vQjNEL3Y1YTRRaitxeXdlVlhTaXRiRUVEOFVKZjBt?=
 =?utf-8?B?NmhTdk02aXlYalBQSVdyd0dQSU1UcEZnYmcvaER2VGIwK01xbjM2V3ZkY245?=
 =?utf-8?B?emtCdDhCYWlCbkpLZHVIc29RV3pCTXhTU292MkJjRWJaVUhMTnZtVU1rQ1RO?=
 =?utf-8?B?U0tBS1ViTTUzUVFIb3dYSHREOUgvaVdLQXdSUHlhMzhwTUFpMWZ2a3R6eUxs?=
 =?utf-8?B?RFppeGJhbWRxUURsMjBSWW5HV202bGhrdWxHTjhJTTRZd2ttZTk4WTl6bjlz?=
 =?utf-8?B?NDZocmw2VDNLOUtiQ1FFaW1Za1c3RWdFUXdaZTFSeWtSR1NVOHdYK0N5K016?=
 =?utf-8?B?dk9CZ1FaR1ZuNjc2Y3dydHhRWWxxQkJ3cG5ONHBkNzhURkxPRm5VV0pUUUZC?=
 =?utf-8?B?WlZLRlc1ay8yTUovcmVBZ1EyMjRpcFl0aUZjM1A1eCtoZlpqSVBzeE50a0ts?=
 =?utf-8?B?MEZDZHROam44TlRDakpZdmM0V0w3RE1ZUW9GVVVJcmZRSmRySXd1cmdSbzNu?=
 =?utf-8?B?VWVxNTRKcVMvaEphcDlpK0szcGk1UStvZVVGRE5aNFc0ZXdQY3ZmSVUzQkhW?=
 =?utf-8?B?RXhuN3FpN3BJOWMxUG4ydzIxU3lON1dRczhjS2tsMXIwOUFWM0xVeGpPbFZE?=
 =?utf-8?B?bDhSMzc4V3B3VVQzNHlUMm00WVh6ZWdiaVNpeklYdncrMS9Jd2NNR3BHYzl4?=
 =?utf-8?B?Y241L3IzczE5RjdHNjdrR3FMdHBKMlQ4REpoK0FCN0FOZHcyTktEZENGV3ph?=
 =?utf-8?B?WGNrZ2drTnY4RWowU1Z5UWQ2QXlMYm9KNGo0Wnljbm90WnNhcU9TT2cvV0xk?=
 =?utf-8?B?VG5TWE1VRHp3SVBidmpscGpiUWRHODMrSGUwTFRDMjVhS0RtUlp0b0VFaFQ2?=
 =?utf-8?B?SlRTMC9JVjNHR3plQ2pxMllseTR3b2xvZUF0NndJanZQZVFmam45aCtaSFIr?=
 =?utf-8?B?cU1pUW04bitXM0tveWNDbjJoTlNNVml6ekJUVmxoTWJiM1N2VXpCZ0NzNEFK?=
 =?utf-8?B?VEc0ZEJwMmk0K1Z6UHBnUTkyMytmQzJiMHBxLzBrdStmcjdBTzlFY1NmQkVy?=
 =?utf-8?B?dmRJdDdiaHp5YUtyYWZNRDgxTDFvNlV3RkF2VEM1RkRNTjg1ZGc2ODE4Qkl2?=
 =?utf-8?B?WWcyODBveUdiVERXeU9kV21XV055V2xCWjU5UnZqMlFXVE9jd1VMSFp4VGgz?=
 =?utf-8?B?SWdsMUpIVUd6bVlBbW1rd1RHRGllajhGL3pMZHhiVllOd3g0UGlMWWp4V3ZZ?=
 =?utf-8?B?SXlyOEo5b3pwUkJOMGtKTFZyVWZFaEF6UmlPUms2ZHk5aWsvRlZOWStxa2o0?=
 =?utf-8?B?TDM1djFsNUxBTm81UWRSRHMvVnJPcURYblBvNUFtcFZPZXdoTEJQaSthZVhq?=
 =?utf-8?B?Y0grdjRzQzZiTGlGV0pKOEIyU0dGeHFvNzZlMmlUa1Y5ckdOZnVlZ0JRR1kz?=
 =?utf-8?B?RjdtVHFwdnNFekFHcEtiYW9id1MyblFoSUg5aGptVVdmSHVZUERPV0lNVXJm?=
 =?utf-8?B?eFpzOGNubytXT0dhbHJLTGNicHcvSmphL2JELzR2WnVIMEIramhWVDk5RldB?=
 =?utf-8?B?bnlReER3SGFYQmdMakQ1UkxvL3kyYWd6d1FqbktWSlQrQXVUWDdvaHpwS2Q4?=
 =?utf-8?B?UzduOS9laktFUVF3Um1mLzVodTdqdTZacUtZVXkwNEg5RXB0ZkU3U0hKYmpa?=
 =?utf-8?B?amRIUnk0UDJTY0lLNnQ5WHZPWGIrOFlZTlhJNkp4Wi9RamNITkkxbUNyMk9D?=
 =?utf-8?B?eTNKY3pja1ZDN3AxMU1vL2k3ZlhlRlVrMUNiK0pld3FKWjFjZmgzaUpJM1NT?=
 =?utf-8?B?dmtHZXlWWmNrVHpIak9KK29XYnd5a2orQ1ZTR3Qra05lUmFJV25HTi9mSUtS?=
 =?utf-8?B?YnN6N2cvMlFQWCthWVJHWFF0ZXdpTEFiRVdSREtUcTdmbHVDU2thWVNkUGV2?=
 =?utf-8?B?MWhaM1lFNnZOdk1ZanJJV3krd3FJK1RMbWFMcWtwYmFrK1UrRWx2OXB0RjVS?=
 =?utf-8?B?Ym1sY3RQUmNramRyRmdHajRYNU9kMXRMSUVzOXo3c0hRN0ptMFErUENkd1JR?=
 =?utf-8?B?YTh3V2xsOGNyTlBBaERoVWRTSi8wcWxZbXhFa0wzZ2YwQlJwRlpFMUViakpH?=
 =?utf-8?Q?2pEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39550d8e-e235-4b56-bec5-08dc7fe25d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:22:17.9607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mxx9yAwF6uPFrAJegZfmzb8cGKO5zj//AGadeg+Qs7APiF7piQPdaH8tQtU/DzqWdDidIj5Oz3SPYsTFCsFUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
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

W1B1YmxpY10NCg0KPiBJdCdzIHBlcmZlY3RseSBwb3NzaWJsZSB0aGF0IHRoZSByZXNldCBoYXMg
YWxyZWFkeSBzdGFydGVkIGJlZm9yZSB3ZSBlbnRlciB0aGUgZnVuY3Rpb24uDQoNClllYWgsIHRo
aXMgY291bGQgYW5kIGRvZXMgaGFwcGVuLCBidXQgaXQganVzdCBtZWFucyB3ZSBhcmUgYmFjayB0
byB0aGUgb2xkIGJlaGF2aW9yLiBJIGd1ZXNzIEkgY291bGQgdXNlICJjYW4gSSB0YWtlIHRoZSBy
ZWFkIHNpZGUgbG9jaz8iIHRvIHRlc3QgaWYgdGhlIGZ1bmN0aW9uIGlzIGNhbGxlZCBvdXRzaWRl
IG9mIHJlc2V0IG9yIG5vdCwgd291bGQgdGhhdCBiZSBhY2NlcHRhYmxlPw0KDQpTbyBsaWtlOg0K
SW50IG5vdF9pbl9yZXNldCA9IHJlYWRfdHJ5X2xvY2socmVzZXQgc2VtKTsNCndoaWxlICguLi4p
IHsNCiAgaWYgKG5vdF9pbl9yZXNldCAmJiBhbWRncHVfaW5fcmVzZXQoKSkNCiAgICAgIGJyZWFr
Ow0KfQ0KSWYgKG5vdF9pbl9yZXNldCkNCiAgIHVwX3JlYWQocmVzZXQgc2VtKQ0K
