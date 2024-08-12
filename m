Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CFCC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 05:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F3E10E0AE;
	Mon, 12 Aug 2024 05:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cC7e2HQl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0412010E0AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 05:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzvbG0qBTyjX2cluAXUvoCsa8+iHbo89ghh4AUo6JqyYRtljrkCmQp9BcyYKZozv2WWq/sr/uVFCb+MN88ztkBBs1EOojEs5sWE+z+/drZd8fRJj+GNCts+Ae+af43YO/AVs91VEaT7/qDJ3SvwlfqS8geyEnnSa+I4jFECk3ralEU3MC2nJ3T/RMgmOHiQeMnrpr3Wd4bJB39LI46aTAwuYcmsXls38ukYiwKxqQAZU73FcqYCEZist8n+K6/zqU1HjCfPJGHQ94q/ONALp+5j3iwc4YWOYk83wM3upgN2IFTvl584h7/n6n8V4a9KDOJ59AnKsOHRrifaEn6Xkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5ATuqrJguOZ5tRwQqPqLqBRRf3B9E4wd+dACP5Nmls=;
 b=btv4KPouAghitrjiPlJe3ANY2O+pZ1rRRDfBcV0uwx6p1nPDJn0IQ6Td1nWQObMiwxjEd+CpA6tBKG1hj1stvPYMnjTwaA0PoGgSG8E/rrzoHQFoCwwNJZI3L6IMwWcrRZB0vClvK7J/H5eYLajJXIouCKb63+FLXKSTXp2kvLYhhMSNiDl+Y7XqV56ihve8p1R05ZT4C8ooqEF1BI0Yg59gzR7igHB/szMeYsu4WMnjWzjmhgViYVtZxDd/7ihRXYyArHTC7U2UhwS++68fygWPxgKjl5O/4YeCnbz0rvUPQNhYOEXYQcYh6Vkir3lA2hzip4Re5g0EFxwaqnmttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5ATuqrJguOZ5tRwQqPqLqBRRf3B9E4wd+dACP5Nmls=;
 b=cC7e2HQlJP0I+Npn9qhLkvnfEs8+j313VT++Dd4I6mE83O0G3H9mMH4Dg+wfUgxp7gMG0HaWQ2ko7cjn+jWhPElxNRYkVFBwUPoVZUt+WXXIc3uVLerU63QN8UXgfki5vlRXr7nBtDKPjoM3sk7Saz/HoUNjpzm0TxnB/Cbik+o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 05:05:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 05:05:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
Thread-Topic: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
Thread-Index: AQHa7Gbpc5z1r5GoDEqGyPPPu+H+q7IjDg2AgAADgEA=
Date: Mon, 12 Aug 2024 05:05:16 +0000
Message-ID: <BN9PR12MB52578F3FEECB00427FF010B5FC852@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240812032221.29060-1-Hawking.Zhang@amd.com>
 <12589748-95c7-42c4-9670-31cdf499a18a@amd.com>
In-Reply-To: <12589748-95c7-42c4-9670-31cdf499a18a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7ec4ccbc-074c-486c-9784-ce0304d955cf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T05:04:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB8360:EE_
x-ms-office365-filtering-correlation-id: fbcc1d6a-cccd-4e95-1d84-08dcba8c5b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NmVGZi9iYUp1N2tTdDl3Nll4a0R4ckZ0TUdOSnVBeFFJQmdsSmZQREYvWUZE?=
 =?utf-8?B?Mmluc1NBMzN4Um5ybGZzUEdydmdNc2xnbnlHcitHMEtNVG9UT3VBMnpjU0pu?=
 =?utf-8?B?czBVVHBXYXJSVjFqNkJhMXp0cUgzUjAzQVdkSHBPbE4zU1F5S0psRlJsNkdN?=
 =?utf-8?B?LzUxcmJ0OXlzOUVodkJWdVpleVQzTTdVNCs5em1yT0xVVUQwMW5RN2E0TlRP?=
 =?utf-8?B?OVUwR1FQT1phanFINXRUdWl0KzhPZDhXQnBucGF0Tm1qclpDN3Y1SUQwdFVJ?=
 =?utf-8?B?OWZUVGt2S3NjYkhQSTQxVXBHaDBGTzFrZkdtdjJJUzBXQ1ZlZ3l4UTYyUVkz?=
 =?utf-8?B?TzRSQTgrYTg1elZkTmdadWg0YlRSQkpnTC9ybFNqL3hudkpVZzl1UkxDaW5B?=
 =?utf-8?B?aktSK0JDT3MrVDdnQ3duUmFzblU3Mm96N3FlOTlrZzg2UGg3RjBYUERzVXFv?=
 =?utf-8?B?dEZLcUFUUnhEVXd4aWYybVNkTzJjM2hhcXN0YXlqZVEvTmY1R3M5TjN6QzAv?=
 =?utf-8?B?V1JmRVVsYURWb0FWMTAyOGRiWmJXa1RnZkV3eVRSKzRIa2VINVVIUDh3L2dz?=
 =?utf-8?B?dmt1MEJDQVlTNk1LS3hwT0FzRnV5UFpLZjZnM0Jkb2xtVWtTM0sxMHJoS3Zq?=
 =?utf-8?B?VU5WN1lYbm5veklVbnhRSHg1YXQyVGVPRThVLzNqc2ZyVlV5R3VDZDVoVmN3?=
 =?utf-8?B?TnJvWWZDbWJKT1REUjJZbXdrdDlXajExdkNJUlJ1cHl1QUQ2ckFndXRyV2NR?=
 =?utf-8?B?SldTSzVyWjlrWlFzakE0YjlqaHdTTldMZ2VWRWdkTFpxc0R5a0lTdUFveWk3?=
 =?utf-8?B?VEk4TXMrRkdVZWdGdWJ4eU0wWkxqZytlUmJ6ZFpoNVQvRy95VXM1cXFERUVP?=
 =?utf-8?B?T0FzUzcvM05qVG9aMDBXWDFTUEQ3S3ltZUNraUNNdjdGMDNoWkVmc3luZnFH?=
 =?utf-8?B?aWZJNHVranZlRE5vZUZVVXlKdE12SFJSYVZ1OEtrK3FCN0ZlRitXWUNESitX?=
 =?utf-8?B?bHNhL25GWVk0b2U5WUlKMGdnOWV5NWsvZ0RUSjdYSUd5aWJVK2Z1NS9FRWtP?=
 =?utf-8?B?Zm5xK3hsbVo2dXVleGwwQ1oza3JpaTFzSzYydytGKzBOOFMxR0dqL0lCY3V0?=
 =?utf-8?B?SU0xMjN3MjB1NmpjK1VYQTc2cUZOdndYK20zNUxQaHVKbGFXOGRsbEkyak9H?=
 =?utf-8?B?WTNjNjBMUkN4U1pJdk9NNW9hZUdvcWZIdG9zcVdHU01EZmVxdXNLY2wrdmc2?=
 =?utf-8?B?MWZHTzhCL0hjYVFySnRRbXRQUUtvSkVObEp2N0RJMTV6ZkwzT0ZnTkFQTmhT?=
 =?utf-8?B?ZnFYMkhMSVVPS2gzZFVqbFgvamhSbWNGL290WXQ1QTQvbXJHMUo2cGorNVN2?=
 =?utf-8?B?bmtCQnpjSVk1bUxPQy9qczREejVZZEJaSzFvTU9UcmFuZENERzdSZDkrZUc0?=
 =?utf-8?B?K0U4NVRIeW5jY1BVREJ3QXJvaHRacDREQytGVTBuMmJTVm1pejN0ZWdJWnVQ?=
 =?utf-8?B?ZFl6bmVoZkgvWFAyZENRZElveWc1ZVJNb1hRVlYxdTl5Y2ZBR2hQY0I0WVFL?=
 =?utf-8?B?NnlreG5RZGU0TlhaOUFUUEVZK3R0K1JYY0R5RXppN1ZaUGlJY09xZ21PdkQr?=
 =?utf-8?B?ZHlmVi9PZXNIR2FPSUdoYk8xV3B3b2VvcEx2VmtWMWZrOFc0VlIrbHoyaVAw?=
 =?utf-8?B?azZMdkFScHZDMTBmNlBNL0dkN0x2VXMzekp0TnJqcjUzbnZ0YnVjNFpBelZa?=
 =?utf-8?B?YVFJZ2JRb3hJSll0YWhXeUNzYS9URHNYSXl4aWk4dnVncDRRTittaGlTQnI4?=
 =?utf-8?B?cFlQZUdrS1A5S21KbjZqa2hlV3RYQ3VUVVlwcWo1S0wxS2pXZFEzUlhhVzRX?=
 =?utf-8?B?eEcyU25pNjMvMGN1NmFKMDZOVExnbTZpZ2g1QzBBOFdBTmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1NTEdJUW1UVTFxa3k1bjJVM2g2TWtGR244SzlMVmkxaTJHN3BXT1I1TWZS?=
 =?utf-8?B?aHg2VnpOUlJ3ejNBdEZwRW9FY2cxaWRqMnNyL3g3QWloSXZ6akhtNENkL1A2?=
 =?utf-8?B?UEdvbC81ZDlidXVtbEN5VHpvRGtPdWRkOVdVOXZOdlBwK09BSjk5MFhOZGpw?=
 =?utf-8?B?WWVJMkhHQVErNllldkhtWnFHcmxQVmhjUk4rNTBrQlVDeGFIczVhNzNoTjB2?=
 =?utf-8?B?THNudWlTMWxUN1VmUGZnMS9ra3lqS0NSWktHSFBsRVhnNVBwL29sN0RJdW5V?=
 =?utf-8?B?RlBDdE5IVytIYWU2TncxcFdRSVIrc3QzQ0EyQ3FiVnVza0VjMmtJcE1pSWEz?=
 =?utf-8?B?emhKNVdMNXN0L01SR1BNLzV6aXFaY1ozMk5vM1lhdG4rdEZ6SldtcGJ3N2F0?=
 =?utf-8?B?MERLZnMwVSs3eENTTEFYWjNsbzFpdllhM0EyY3cxbHh3MlhKMCtPWVlpK2VH?=
 =?utf-8?B?YnlaWjRnTk05dWZIMC81dFhLRlFiVEdjeGxYZWxIUnpIRWFpaVQ1bFlEYnRJ?=
 =?utf-8?B?WGVFdlEzQVlScUoyT3JGZXlFOGc5UVMxQWNiZzEyNzRGNklIUzJvTFRTQlor?=
 =?utf-8?B?QnlnbFRZbHJJWnhvRzZtaElxU2JGaFNLUUpDVkE1WWNoM1R2a0FSM2x6Vk5h?=
 =?utf-8?B?T29FcG9vNHZWRTFwazRmODAyLzNnQUdTelFvd1hHRWJjVk9pa1VLa0IyRmJJ?=
 =?utf-8?B?QTA3L3VXWmd5cEhNQmJtS3l5VG0rMzQ3bTUwNFhUZTRzRlFUK1d0Vm9abWl2?=
 =?utf-8?B?cFdKc1BlVjBoMFhXWVFrcFF0Nm50c3RzOWlkVUQzVjlCZ1FNcE9EUW5kU3Vq?=
 =?utf-8?B?U3RRT2ZyTTNVYnhHbXlTNG51U1pqcXd2WXppMDJJc2NGV2RkQllOZFhGd2tO?=
 =?utf-8?B?YnhPN2YydjltaU4yY1duY3BtK3N0MjJ0dEtKb1V4d1ZoVDJZOGdVMEN2Rlo1?=
 =?utf-8?B?dlA3SERWNEJyRVIrODhkOUFVYWlYK2V0Rjg2OHJnVjhnaDFXNGlqdEtJb1Rm?=
 =?utf-8?B?bDNFc2V5TytvZk5mZVhVY3RHeHJmVzVaVnd6d1hodTZVSWVlN1BIS0NKSlNF?=
 =?utf-8?B?NDdqd0VkM1IvVDUxdmVFNWI0ejV2RHJjQlVtbTZiNXhHSEJ5dnBGR2Iydm12?=
 =?utf-8?B?OExsaHYzM1oxSFB5ckwrUE4za3dBMk1UbzhlcTlCbU1vdEh5MWtraXllZ1o5?=
 =?utf-8?B?clVVbnpDRVpQNkVUUzZ6V1crMUF1bzhBY0VhSEZzanZjWXJUZjRKVUgyZS9h?=
 =?utf-8?B?UXg2TkEwTmNaZ2l0eDVSN3lPY0pRNzZUeVkyS25JSm9qUjFRQzZXVDJmc2pI?=
 =?utf-8?B?R2lRdEZZZlIwdVhLY0ZWOFZndmxTT3lyU3puUGNja3dUb2NpVG1FcDZVdS9J?=
 =?utf-8?B?YnZhZjZ1OGhMVlpva1lGR2w3YmkzQjladktXdWZEekF3ZklWKzFGMUxRb2Fv?=
 =?utf-8?B?MXBnc2FMMXlHTWlLOWdMdGNiWm9wd2sxamJKUmUrdWlzemxkQUlSKzM2YUVP?=
 =?utf-8?B?V0R6VTZSV3QyWGkzR05uZENGOU90czdkd0NUbEFQdUtPMThOT2JETkdjdUNl?=
 =?utf-8?B?b1BybnpPSEs0MHMyQjVBbWp0ajl0ZkFuLzRnU0FXK0ovejNvczg3YWFycTEx?=
 =?utf-8?B?REJGRXhBRnpQN09ZUFdBL2JGMkxhQjd2QWs0VXNKNDkzdVp2V1I2L1hxUXRD?=
 =?utf-8?B?OW43L09EK0ZPaWhsT1Ixcm11a0JMRUEvYUhTNXdTNzFCNlh6UnNOOGVRcFpt?=
 =?utf-8?B?SGt2UWlpcEtoZWtzU0NDdU1qRGl2TmNtV3h4SDlnOVVBbDNDWUJTWC8vaWZ1?=
 =?utf-8?B?T0FsRW5Sd2VTa0x4NWtQMGUyWEpMbHN3bXFSalljV2FuT0k0dUwrRGZPRjJF?=
 =?utf-8?B?TDhHeUd0ZzNxdkREUUduRjlJclEvMFZaVVFHd3dpVFUxcTQxeUFwRU9ONDll?=
 =?utf-8?B?UE16YjFLWTFYMVRseTNEYnRUSnh6elFnL09XODVqYWhiaEpOQkgydlpQWVcr?=
 =?utf-8?B?b1RINjBseE8yMmZFcTZQSUxmejRNNWtuckhrUVlaNGgzNkdkZzBReE9IQTgz?=
 =?utf-8?B?czB1Z1dEMGRSMDVzN3dqaStwaWQ2TWVwL1dwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcc1d6a-cccd-4e95-1d84-08dcba8c5b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 05:05:16.6710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pybp25z+kx26YcoBl7cZnGbTBEwj4FpcN7M21Yl+QELHTyP2WvXWwaLKxl883juEXHv4jZv3y7lMFsVosBhUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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
Cg0KWWVzLCB0aGlzIGFwcGxpZXMgdG8gYWxsIHR5cGVzIG9mIFRhcw0KDQpSZWdhcmRzLA0KSGF3
a2luZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IE1vbmRheSwgQXVndXN0IDEyLCAyMDI0IDEyOjUyDQpU
bzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IERvIG5vdCBpbml0IHRhIG1pY3JvY29kZSBmcm9tIGd1
ZXN0IHNpZGUNCg0KDQoNCk9uIDgvMTIvMjAyNCA4OjUyIEFNLCBIYXdraW5nIFpoYW5nIHdyb3Rl
Og0KPiBUQSBzaG91bGQgbm90IGJlIGxvYWRlZCBmcm9tIGd1ZXN0IHNpZGUuDQoNCkRvZXMgdGhp
cyBhcHBseSB0byBYR01JIFRBPw0KDQpUaGFua3MsDQpMaWpvDQoNCj4NCj4gU2lnbmVkLW9mZi1i
eTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTog
U2hpd3UgWmhhbmcgPHNoaXd1LnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMgfCA4ICsrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9wc3BfdjEzXzAuYw0KPiBpbmRleCA4NWVjOWUzNTY5MGEuLjc0OWQ4MTQzYjFlNyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMNCj4gQEAgLTEzMiw5
ICsxMzIsMTEgQEAgc3RhdGljIGludCBwc3BfdjEzXzBfaW5pdF9taWNyb2NvZGUoc3RydWN0IHBz
cF9jb250ZXh0ICpwc3ApDQo+ICAgICAgICAgICAgICAgICAgIChhZGV2LT5lbXVfZmxhZ3MgJiBB
TURHUFVfRU1VX2RHUFVfU0lERVdJTkRFUikpDQo+ICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gICAgICAgICAgICAgICAvKiBJdCdzIG5vdCBuZWNlc3NhcnkgdG8gbG9hZCByYXMgdGEg
b24gR3Vlc3Qgc2lkZSAqLw0KPiAtICAgICAgICAgICAgIGVyciA9IHBzcF9pbml0X3RhX21pY3Jv
Y29kZShwc3AsIHVjb2RlX3ByZWZpeCk7DQo+IC0gICAgICAgICAgICAgaWYgKGVycikNCj4gLSAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ICsgICAgICAgICAgICAgaWYgKCFhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGVyciA9IHBzcF9p
bml0X3RhX21pY3JvY29kZShwc3AsIHVjb2RlX3ByZWZpeCk7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICBpZiAoZXJyKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Ow0KPiArICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgZGVm
YXVsdDoNCj4gICAgICAgICAgICAgICBCVUcoKTsNCg==
