Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0773C36008
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 03:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C8610E033;
	Tue,  1 Apr 2025 03:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urN+j9E7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7656610E033
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 03:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnO9RBW9xcfSDlqzFgYR9q57PnXpH6a+2Tej8SoHLAC98OIsD7Z3yRdjjZ15iT4a90oFWnKq47N37oqYzdrLbKTcgwm5NlrD2nF+Le+vFxDOU0NwEFlQsL4kYqtrFegCi95fKGzpzAOMfAUHurFYbvisEcZXhiUXwW30JowtlTjhEkwPwiwUtfEhMPOuB3mr+hF2VQ+mu8mvh6irE1HuPXrSZaSI4Ee0PPHfkNhWEDBWtTJsM2hRsJXeO/GGKkmwxHR7UzhQpf+5EPzeLrRqRB3QZsZgjRL8nnKmB/4gQv4Z4K5OC2lpUqGPU3kSSI+UcfF0Gqy/UzvzMsfsUEJe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2cNnJXFDh5oC5I5vUYPh6CAr56wf00bv668dTFtKhc=;
 b=kHMR91qrJau86Et4QMJ63yt60sjqACDKv3gLHnm5lzQZ5srIiLXU2O9LuhDIFzghXuvTi3yLAtODXGPDmKztqUodiQ/KN2ys71LVdajWUukuR3owRd8n3lMDVX7Vg5++5f4+muXucsugXGW4YVOHCvJBCMAEb8rAMURn4r+JXbubZFsiKEnq9yNHfZ4JA6Smk/UjdBlcJGav3JwZPRaj7oaangCqJW0zu7SNwBB8ZKVT/ou2gpWfL7gKJq0YJ9kMFmlfgP8HXTvblV4q6U83C/iJ3A2hptiv0CthfD/OVOSHbAW9fD5pwBDL9lcpNV4W/l7gGbGqDJCKq+IEVLFqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2cNnJXFDh5oC5I5vUYPh6CAr56wf00bv668dTFtKhc=;
 b=urN+j9E7K+YJ/cUoS3fOMV/hA3UgD/BnXDM9XpJXiNv7WZi22+nFLiePp/JdB0P7egk55Le2MlTnybdFsFHwO5q3K/m66nWZ6lujgGge21RbTWuktqPmWEXp3+d6e/3XL6LxRGVjkUva65vEGEknE/Yo+GTkqxQPS2xGvZM485Q=
Received: from SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 03:41:25 +0000
Received: from SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::6486:9a5e:4dee:8778]) by SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::6486:9a5e:4dee:8778%5]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 03:41:25 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>
CC: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
Thread-Topic: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
Thread-Index: AQHboi/O386mrN/XvkaHkADSKj6tK7ONJkwAgAEEhTA=
Date: Tue, 1 Apr 2025 03:41:25 +0000
Message-ID: <SA1PR12MB6680A9D46F3AD83E56A69964E9AC2@SA1PR12MB6680.namprd12.prod.outlook.com>
References: <20250331112634.81008-1-zhenguo.yin@amd.com>
 <64dcfc76-a973-40c8-b664-4191e9e8d266@amd.com>
In-Reply-To: <64dcfc76-a973-40c8-b664-4191e9e8d266@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ea21bd3d-56d1-4e37-9300-7ae5748bfb5d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-01T03:38:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6680:EE_|PH7PR12MB6396:EE_
x-ms-office365-filtering-correlation-id: 01912a6c-2948-470e-6f0c-08dd70cf140a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M05wcGpzVWJiQ2VkYXNVa3VCY2NhZmk5NkFOZFkxK01BMTdva1FRUmJhdjBF?=
 =?utf-8?B?YzhBdXhZZ0FKbDllQ2dIWmM5M0U4WTRoVlUwMmxkVlBYMUVxcitBa3I2VTRZ?=
 =?utf-8?B?bUJGeHI4NDJVUDVqellRZTFZWEpJbjZqdWtuaVVmenpPQnFMNHhXWGhTTG9S?=
 =?utf-8?B?V2pscnBpeTFWblR0aE1vb0piOWFRR1p6aktwWGdjUVI4UkRVVkFhQXhaUGF6?=
 =?utf-8?B?d3dnSUVLb1lkMldIRXZjS21vckpoU1JPdkNNT0RjczM1eUNOUlptRzlQdk54?=
 =?utf-8?B?M2pYbWNremZNbmdoQlpXb0xDNEFuR1JKN2xTeUtrbDF0a3VhY2R2N3JSdEdi?=
 =?utf-8?B?d0Q3aU1MKzV1ekNrMDhKNStCZGYrY0w2ZkwyRlk0K0IvdUp0aUhRSDJHcUYy?=
 =?utf-8?B?ZzFFSUFjaEdkc2JFMERGelNtS1NkbUkrMVZxdStOM01tdGxBSzcxSzgxWU1C?=
 =?utf-8?B?Njc4bVhPWGhZVFpaTVM1N0dlM3czY3RVekxkaSt0MGcycHQwV2R5QUhVZ3Ba?=
 =?utf-8?B?dWxJeWljeW1IOCt3MC96M2gwUUdBQXI0aXRVSG1TcDVMb21lMjJoSDdNdTRL?=
 =?utf-8?B?cmlJOUFmamJTWjkxT2R0ZkY4STZhdnZvem1IcjVyRUsvb1lCeWdkbkgzclNj?=
 =?utf-8?B?OHZwWExXa0prYW0wbUhTRlQxZnRxbHNxcGd0TlhqVzBUOWZ0SUcxTjRvaDkx?=
 =?utf-8?B?TXkvcFE3VVRhL1JkYWZ1L2NTQUo1cVJvcS9CenRUQnZCZHV6MTk1WUU0UVht?=
 =?utf-8?B?aktBY09rdlAvK2JHUEcwK2lKV29uVGRYNXhmT3Z2bnlxN21QdjVHNzYxUkNM?=
 =?utf-8?B?eHJPRXBkVGROZVM4Ky9XNnFKRk5UNGVCNkdjMlJOL2R4RGtvSkU4U3p1V3c5?=
 =?utf-8?B?SGtNSUJxYUY0RHFZY3ZZK04yMk5yejRSWTQ4UVpUamdQMFVWOFViQk5xSkFI?=
 =?utf-8?B?Z3ZoNUNTWDhJVjl1eEQ2R2JSaTIyZWpFbDFUWkZGbWpycUFJazFqcXM2TWJW?=
 =?utf-8?B?OTdKSS9pUERRd2NlcllCU21KSHNSY1lsWitndGFVd1pxNFg5YUxwQUc0ekxK?=
 =?utf-8?B?U2MrUlhBbytqYURZZkh4c0xER0RKTVE4TjlxYTdLcWtCVVJSREtVdWExbGhq?=
 =?utf-8?B?WjYwa0VHUjFWQyt1M0swQTlWWjFST1NGMzV4alNQV2ZIN0N4cy95bVc1TTJV?=
 =?utf-8?B?bUZPelJkRThMMHZmcEI2aHhxNEpweHdudm1JdlFYVWVFWWpkQk1EMjB2UXho?=
 =?utf-8?B?TjgzSmg5MGt5Q2RrK1NYWEZSSU15ZHExb3Z4c0E4U1NNRUN0eUhRS1FxZnRO?=
 =?utf-8?B?RDJoOFFTSG56S1h3OVpyeVg0MXd4Vm94ZEtLSmRjUHhzMVVNa3YrbjRjaGpC?=
 =?utf-8?B?T2RYZzNpOWpsMkdpbk0xS2JOWW4yU3RWNktRWHNmS1dOdFhCQmNjUFBZWmRt?=
 =?utf-8?B?aUhCbzZHS05lclQrb1h2d2ZMc0wvcHVpeURKVmZkNDdWdjZyWjhiYWIrTnc2?=
 =?utf-8?B?N3E3V2IveEQ4NXdPTUlKVnRsbEN4ZjFidzA4VlV1MFg2SXkwQmswS3hlRnlo?=
 =?utf-8?B?V1kwTmN0YjJQVzVkSG5mdXNIK3BGU0R6VVM1cVZtSjZqaU9CT3VnUzdKK3V3?=
 =?utf-8?B?eWhla2JrdkplUFMyS2NQd29lc3ZWSGduWEo4ZDhyRlcyWUxaSHNKVlRPVXhu?=
 =?utf-8?B?UEFUa0FmUVBuK1lISXZRUzRTRTlSaTRmU0Erb05nc2hGbXFwcTJsaW1SV1NM?=
 =?utf-8?B?Ykdua2VHcDRLekpnRFlodEdud2txVVNXdzExUVNhTHBRZnNJSlRTSWpmY3Fh?=
 =?utf-8?B?cmdVZWMyemdTNWRwRndaeEZkaGFtQ1NncGtqK3g2bWJoS3JYaENLS1piQ2Vs?=
 =?utf-8?B?Q0RMTGJUNlJ6SXlzbTA2dFdzeTZOY2J2ZTNhSS9vQm5VaUtwd0g2MkVHblRR?=
 =?utf-8?Q?lOxCYef22/AspNoTSmDzA5nB2/m5uT6P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MExaTnVJajFTOXF1bVVmVlhiSHpaM0xIdlVZN3dxbmNxVTlFRG5SZUlSVlgw?=
 =?utf-8?B?ZytRZ096Q0ZKSUNMZ3M3UVhvRmQ0dWdCY2RQK0ZPN3Vla0RUYnNBRURLcmM4?=
 =?utf-8?B?bDBNaTZGWUd5QzRvVXd5eW91NndKWGI1eWphRzFKZUtvQjFzZGVQd1N4L3RI?=
 =?utf-8?B?L1lCeHVNMFBiQ2NxYkFYa0wvOFJzNzZyYzIwWHhTM1RkRDVON0tYYUFpdzdJ?=
 =?utf-8?B?SWNPb3hqUmVBL0ZDQmJtblJqWWZ6K0hFbm9YdDZtUExqTi9vMlBTUCtRbU5I?=
 =?utf-8?B?MDFYcEUrUVZaaDFXY0hpTTFFQmIvMU1lWk8yYWxnL0pSSlA0Ny80QTZZRm55?=
 =?utf-8?B?Z2twenhoSHdzUFI3dnRGNms5ZVFvNURDeDg2cHp6dXY2YTlyOGtKQ0k4bGZS?=
 =?utf-8?B?WDlIR0Jkb1g0SU1XK3dQSFJ6emVKOHJMN2krei9QQlNKa1VUZ0hGWG8vdXk1?=
 =?utf-8?B?NzFEVUFKd25NVXZtQXROZ3FEVXZiOTFvYmZ2ZU0vYysyeHE0QkR6MVNYNlBG?=
 =?utf-8?B?VHgvK1VFY3RYd0E3T0gwWFpkeDFOSGpJclhwbE9YVVJqdjVCQTVpeFRnek9z?=
 =?utf-8?B?cUw2VkFvT21Cb05teXRGTkhOZExoR3JYaTQ0T0xyc1FIQlJaY0VxdjA0VHVQ?=
 =?utf-8?B?MG12cmRaT01TdllPaE5od0h6cEpQRldYK2hYdTJ1MVl5SVVXOWNTTENrdWxF?=
 =?utf-8?B?WmdwVk95Wkk4M2FnM1lIL3RNTTYvRFNQVmFvaXI4cXBSYnVVOXBGdUdGS2ZZ?=
 =?utf-8?B?ZU41STNCWEFXbGxubXljR2JpOEVQdFdiWGlESExZbDhzOXIwS1NzRENpdXR4?=
 =?utf-8?B?TExHMDBsbE1oZFo2bSs3R1BCa0FzSTU3S1BEbEVGbmlUSWxJcEpMdkVoQ1ZE?=
 =?utf-8?B?NE9WQUlCbVlMVUE0WUdWbFNxS0Jvb29xcnZCcDdiN1ZHdW8xOFJybitKWktQ?=
 =?utf-8?B?bUFCVkg5RnUzS3g4VnZWOGM2bHVCVzZnVjdEdnE4cjQ5b240cnJzRjNJNTVT?=
 =?utf-8?B?MGFIMGFubndOT25oTVlqQjBKbC9mMDBJbUdjVkVMcCtFcDk5VDV1UTIzQ2Z4?=
 =?utf-8?B?c1hzbGphaitzVzNaSlFobnNZRjJlU2NpY0lCTFVibGdUeDNvMkQ4WFpqR1lM?=
 =?utf-8?B?VXlvSUJhbHR2enloYWJ0Y2pnTDU1YkNhNWd2cnV6Q3lmZzdhN2V4WFREdVRs?=
 =?utf-8?B?czdMbzdpRlMwVmJhdWorUWVrZmJmTVRCRWMxNDZxVGtsa3BoMEVTTXFIZndX?=
 =?utf-8?B?ZFJmOGdVd2Z0VlEvendNbVdMVGRWVHdrdkIrR0NJcFZtbW5UMUFEQll6bFZj?=
 =?utf-8?B?ZGRaZXdSTDlKcGdQZENxVVNJVUxMaUM0T3FRVndXYUMyVDF0dEdKWVJKemdU?=
 =?utf-8?B?eEg3YUdFK1FaVGpzejMxb1Z5b3A2TGNEeWNJbll1TnVIV25RN09qZnJxRi9v?=
 =?utf-8?B?UFRpb2pMTGt1eS9TZmh1Qllta3Z0RU9BQituZWtqb0RKRzZ5azFLc2JDdjlU?=
 =?utf-8?B?em1GdG1OUUNvdHdkOVRGR3luVjZTRCtNQkNJTmNlamJzTGR3Um81dkVVRkZw?=
 =?utf-8?B?ak5yd3RpUXp0RHcxRnRkME5LUzA1Zm0rWkZFWVBWWEhlamhrU1RQdURTSlFL?=
 =?utf-8?B?YkxyazlwY2RRVTNZS3RmUW9XT2VlTklxTXlvNzh4SnBxZy9HWUhUVTZYMjZS?=
 =?utf-8?B?M1cwcFF6NEdYeXpmSnJzNklRWGZoWVZCSktkbGc0S2VVNC9DWUZCWlN0ZC81?=
 =?utf-8?B?VHNOQnQ2N1ozWXh6RGx5V3k2NkVaMXVDOHFRWHkwV3IraytwbjBld3h2ZEpp?=
 =?utf-8?B?SFFkSlI5M245bDBjeHM0alJ4N0JyN2w2OFZKakUzWVVZUVJpeWdzVlpkZkhl?=
 =?utf-8?B?S0hTdHRUOFJvQVBJWm9Odnl2ZWZBUmlTZmpnTVhZMllFQU81MXhWbHYvOFNy?=
 =?utf-8?B?MElMTTBlUVYzaCsxV1lGVVgrUW40NTBrWS8xS1h3Snh4WEFaek9HTGZWTUxX?=
 =?utf-8?B?U3B3eVdCckhhVEk5dm85Qnl2K05XK09memlDWGVocmhkOGx5YXhyS3BzbU01?=
 =?utf-8?B?MXpLS0U4eE9LTC9oengzZDZVYytyczBVaXZ1TkxJQ1Y2dUFpSTVtM01CMGtC?=
 =?utf-8?Q?qMMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01912a6c-2948-470e-6f0c-08dd70cf140a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 03:41:25.2879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSzV6VP/TaU2Gb9hXxNyj3keqVpNxXI9DYtXRKAxapyEtJbpHx6CI5SqlvzxIUp2bk8I5JF/UQYfLsXVkFo9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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
Cg0KSGkgTGVzbGllDQoNCkFueSBjb21tZW50IG9uIHRoaXM/DQpMb29rcyBsaWtlIHlvdSBhZGQg
dGhpcyBjb2RlIDMgeWVhcnMgYWdvIG9uIHBhdGNoOiBkcm0vYW1kZ3B1OiBVbm1hcCBNTUlPIG1h
cHBpbmdzIHdoZW4gZGV2aWNlIGlzIG5vdCB1bnBsdWdnZWQNCg0KQmVzdCwNClpoZW5ndW8NCkNs
b3VkLUdQVSBDb3JlIHRlYW0sIFNSREMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBN
b25kYXksIE1hcmNoIDMxLCAyMDI1IDg6MDcgUE0NClRvOiBZaW4sIFpoZW5HdW8gKENocmlzKSA8
Wmhlbkd1by5ZaW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
U2hhcm1hLCBTaGFzaGFuayA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBmaXggd2FybmluZyBvZiBkcm1fbW1fY2xlYW4NCg0KQW0gMzEuMDMuMjUgdW0g
MTM6MjYgc2NocmllYiBaaGVuR3VvIFlpbjoNCj4gS2VybmVsIGRvb3JiZWxsIEJPcyBuZWVkcyB0
byBiZSBmcmVlZCBiZWZvcmUgdHRtX2ZpbmkuDQoNCkdvb2QgY2F0Y2gsIGJ1dCBkb2VzIGFueWJv
ZHkgcmVtZW1iZXIgd2h5IHdlIGhhdmUgdGhlIGRybV9kZXZfZW50ZXIoKS9kcm1fZGV2X2V4aXQo
KSBoZXJlPw0KDQpJdCdzIGNsZWFybHkgZm9yIGhvdHBsdWcsIGJ1dCBpdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgdG8gaGF2ZSB0aGUgYW1kZ3B1X2Rvb3JiZWxsX2ZpbmkoKSB1bmRlciBpdCBhcyBmYXIg
YXMgSSBjYW4gc2VlLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IEZpeGVzOiA1NGMz
MGQyYThkZWYgKCJkcm0vYW1kZ3B1OiBjcmVhdGUga2VybmVsIGRvb3JiZWxsIHBhZ2VzIikNCj4g
U2lnbmVkLW9mZi1ieTogWmhlbkd1byBZaW4gPHpoZW5ndW8ueWluQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTUgKysrKysr
Ky0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
IGluZGV4IGQ0YjAxZWYwMDAyNS4uYjQ5NjA0YWRlNmMyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00ODA3LDYgKzQ4MDcsMTMgQEAg
dm9pZCBhbWRncHVfZGV2aWNlX2Zpbmlfc3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
ICAgICAgIGludCBpLCBpZHg7DQo+ICAgICAgIGJvb2wgcHg7DQo+DQo+ICsgICAgIGlmIChkcm1f
ZGV2X2VudGVyKGFkZXZfdG9fZHJtKGFkZXYpLCAmaWR4KSkgew0KPiArICAgICAgICAgICAgIGlv
dW5tYXAoYWRldi0+cm1taW8pOw0KPiArICAgICAgICAgICAgIGFkZXYtPnJtbWlvID0gTlVMTDsN
Cj4gKyAgICAgICAgICAgICBhbWRncHVfZG9vcmJlbGxfZmluaShhZGV2KTsNCj4gKyAgICAgICAg
ICAgICBkcm1fZGV2X2V4aXQoaWR4KTsNCj4gKyAgICAgfQ0KPiArDQo+ICAgICAgIGFtZGdwdV9k
ZXZpY2VfaXBfZmluaShhZGV2KTsNCj4gICAgICAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zd19maW5p
KGFkZXYpOw0KPiAgICAgICBhbWRncHVfdWNvZGVfcmVsZWFzZSgmYWRldi0+ZmlybXdhcmUuZ3B1
X2luZm9fZncpOw0KPiBAQCAtNDg0NywxNCArNDg1NCw2IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9m
aW5pX3N3KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICBpZiAoKGFkZXYtPnBk
ZXYtPmNsYXNzID4+IDgpID09IFBDSV9DTEFTU19ESVNQTEFZX1ZHQSkNCj4gICAgICAgICAgICAg
ICB2Z2FfY2xpZW50X3VucmVnaXN0ZXIoYWRldi0+cGRldik7DQo+DQo+IC0gICAgIGlmIChkcm1f
ZGV2X2VudGVyKGFkZXZfdG9fZHJtKGFkZXYpLCAmaWR4KSkgew0KPiAtDQo+IC0gICAgICAgICAg
ICAgaW91bm1hcChhZGV2LT5ybW1pbyk7DQo+IC0gICAgICAgICAgICAgYWRldi0+cm1taW8gPSBO
VUxMOw0KPiAtICAgICAgICAgICAgIGFtZGdwdV9kb29yYmVsbF9maW5pKGFkZXYpOw0KPiAtICAg
ICAgICAgICAgIGRybV9kZXZfZXhpdChpZHgpOw0KPiAtICAgICB9DQo+IC0NCj4gICAgICAgaWYg
KElTX0VOQUJMRUQoQ09ORklHX1BFUkZfRVZFTlRTKSkNCj4gICAgICAgICAgICAgICBhbWRncHVf
cG11X2ZpbmkoYWRldik7DQo+ICAgICAgIGlmIChhZGV2LT5tbWFuLmRpc2NvdmVyeV9iaW4pDQoN
Cg==
