Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71433C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125DB10E040;
	Fri,  8 Aug 2025 19:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tkGqLyHP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CE410E040
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGXJEywJG3F96csmOGvceF1CpKMpepoIS+B16Z7EaVlpWoItBMs+4BGMq6dlDH2yN3id3qIuSk6VVjuZF7Qpd5mQaPblnwvt5nuW8IuUAvDKae2Wg3TSmk0ouGRC0Hhbz/i+6OnHjmX+4JNzK/lcV05RWnh5O52g8+YjIUK0372lOHI5hq79aXUtB8UnY1oGYr+Gzjvyr100RDyUoUdBdJTMd41pWEeh2poIT+bM+dlp381q0EOerjjc3v2Ow8eBA7lD0zDoDqR3oBtqbLl/3vLzMjvr5R7Ihpf8iKUVlUXCeH8K5aHl8kccHO6D1QGAUhGYUIKXKnbeGBgby1+MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbt76qlLxLo0Nc8skw+fg5/5lCDVdFrqcHHNV3tYtjY=;
 b=RYUfEetObkXZmGURrfI136iP07WKRP02YGYaJQtyhHBxLMHJCfc6+xx2cK/4fTI9K+SGHaH8J00GQUHcbbzfW/oQz9lLQCtR3yKU0erO6GBPNPwViKvX+eX4SrwfTDpo6B59XqdXxUkKWNyHPfKGU/u4theUBnxvXcJjdL9UoiXY9n/27XcLkxZESIrNQYsanKtGSYnN7dSy0zPffkFvPuZYBRBhm+Dlpxqyekn3kukPecv/QLquGYrqVNHBS03LK0S8FI6DnBXdxXIbz5MH0vR364aF5mI5fm2TfM19JEWNVsjhCLu5knkhNblxrL2mceyuJS+sXED0TuEBCJ01Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbt76qlLxLo0Nc8skw+fg5/5lCDVdFrqcHHNV3tYtjY=;
 b=tkGqLyHPqCyVk6OKNl7Iwporka4zeYQ+9tCVnw3d5/V4PLAaCG8SPI0M0HcSoumW7Vf+1byn3GZ///cwppUB/wPVem9ZTElV+22G1Y+xOw30cTtEkF28iARIdsW53Rmriy3tT6vDa7e1wy31OkP+JrCkXu49IWj0oaULj5CjdbE=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 19:47:24 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 19:47:23 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
Thread-Topic: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM
 mapping
Thread-Index: AQHcBhlTgig7MM3j4ki1ms9nkWZhi7RZKnUAgAACs8A=
Date: Fri, 8 Aug 2025 19:47:23 +0000
Message-ID: <BL1PR12MB5898292B07D57D667E029938852FA@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250805145743.104650-1-kent.russell@amd.com>
 <83fc2476-de21-4869-abc9-54ebd9aef146@amd.com>
In-Reply-To: <83fc2476-de21-4869-abc9-54ebd9aef146@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T19:43:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA1PR12MB7317:EE_
x-ms-office365-filtering-correlation-id: 997a6002-3bf4-4f64-8419-08ddd6b4654a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZENaWjJpQnZPb2VNV1k0ZWZrNjNkeStSWVcxQUlKN2ZVS2lrRnRLK0kreXdE?=
 =?utf-8?B?RkVzVHg3MFhRWVNuYkpWM1Zsb2FVaXZEMFM3M3RYNHV4a1lTdVZsUWFJbHhT?=
 =?utf-8?B?emdNTGh2Ni9QWC9BTCthRnNESXVRWHdkaG9NNkpIWnNGSUZUNkJDbUZEMERp?=
 =?utf-8?B?d2VVTU5UWDNpMUk4QkVhOHlteXhkV1AwVEhEZ0RwUnRMZHB5dGV5L1NYTnZn?=
 =?utf-8?B?THdPcHdyMFdLc2VhNzBjK0hyTHpWZ1FTWklYZ0VwakpNVWJqQVVwbDViOElI?=
 =?utf-8?B?QU1tQnM4K1VoN0kwM1RhUWlMOGNtbjZSSHNOL21kTUV5Z2QvV096QzZZR1Ru?=
 =?utf-8?B?SG01YWt0WlVOWWZmeG1UQzNzeXlWdktjNUVscWdKcTFqV1Z5eTdQVmhocjly?=
 =?utf-8?B?YXRHZFROR2lNTmswdW85TFpWeVhUakVnbzZJQUNQT2Rla2gyQVVPQUxTMk9r?=
 =?utf-8?B?TXNkSit6dmlLbFlQbDg2czUvbTh1bGR2WCtBNkxTK0JrOG1rU3YvNnh4cm9X?=
 =?utf-8?B?OTd6YTQxQkZreGV2dGFsdjZ2bmV4ZVBUSnNkTm9ucTVFWGV5ek44cklaVXVZ?=
 =?utf-8?B?bjJpMlFlc3M5VVkwQ0V0SkwvQUpxTzJDamw1V2Q5TWEvWnQ1aTZtWVZZc1I2?=
 =?utf-8?B?R2tscjF6aFhRUklUbFZJODJPd0xqZkVlVGZTd29jcUhKNlFZT0czZjN0TVJl?=
 =?utf-8?B?U3pUQzZhTmtqQm5lTEJWRWd6WHp5YURuMkFKZXhEd2dES0VsMUtpN2ZVcUN3?=
 =?utf-8?B?Uy9VZGIwb0xOZ0Z2NHlrTGJKaUVSMnRvUVdFbmJPWHRFdnVyNi9SVEsvRUJE?=
 =?utf-8?B?d2RMYkQ4QkZNT1lRMEZaY0ZSL0cvR2tyT3lPd3FvVFgwckVlRjU2cncyRzMy?=
 =?utf-8?B?VWVreU1OSDk4UDFDR1FQSFR4K3piaGxIUk55Y3g0TlJDS3o0UUc4N21nUnBU?=
 =?utf-8?B?cWwzekM3RW9WRFphRE5oUXJKbmowZVh4TysvWlo3ZGdTbWEyNWpXRStwaFBR?=
 =?utf-8?B?STEvaHE5d2MwQ3hCUEV5NnhDY1FmZlhKdC9seDhYWDlSdmw3L3UyREEzeXZE?=
 =?utf-8?B?OGR6SnpRaG1rL2J4TWZXeWp5S3BlMU1kanlkQ1hqKzg5WUg0SmM2ZWpIZzd3?=
 =?utf-8?B?UUhIMTI1dCtRMm1wVVdGaDJPaFpjN1ZHVXp3cFNXRUxkUXpRQUVBcENLT0RU?=
 =?utf-8?B?RklaMkgwaUhuTlVuRTdRK2VkbnlWbVBoNU0xN2psb2tKaXYyYmU0Y1Mwc056?=
 =?utf-8?B?OHBBRUc5d3lZdWo3cEIzS0M4bmlVSks1NjhNajdhdDA1VnVlVUhRNzN6RGhy?=
 =?utf-8?B?VWFOWHNlNlRGL3hINmJHa2JKTlZvRW5DcVZyRUVOdGR3Z1B6allFYWo2enFB?=
 =?utf-8?B?NHpQU3BncEw3cTU0enNpdGxBZmI5b0dWK1VGNUtxd21qNVpkck9hMXd6ZHZU?=
 =?utf-8?B?blQrOVJtam96V2UzQkVub1dKRnA4MTNFVVBBbGJwaDNzZzV1aEdQMDF6eHJO?=
 =?utf-8?B?aCswK2J2UVVSM1BSc0hvQzlkN2J0eXZISjdpdzlQZmdWMSs2cGt2YzBqUnVz?=
 =?utf-8?B?ODFxdHYzYW13d0NZaVNkcnExMVFFaE9DTUhmMElQUy83bE1FMnpHcXExUzla?=
 =?utf-8?B?eGhIR0krQlNVUTlaMTY5U1puN2I1Zm1FM0dJOUZ3OXNmYmIzMXFzV25EWTQ4?=
 =?utf-8?B?c3BrWEhIUXZxOXc1YzJjc0YyaytGNmtJZGlDcGZZL3VHemFYcllzV3Z6ZEVu?=
 =?utf-8?B?UWk1UmwyZ1hIV003cWlJRkNPUkcwaU5KZG5qQWhpV3hYTFhjZEw5ZE93T2gy?=
 =?utf-8?B?L2VEcE9sZmZueDhlSjE1TThxcTR3R0dNUHFoWndXOXpTMU5XdVBTV3BQbHpQ?=
 =?utf-8?B?aHBnUExEV2h6SitCTEo0dUV6cnFDWDgrc3B4UXUrQ1hYODNrWVZHS29QWC9B?=
 =?utf-8?B?bVRab2J0QWNLV1VITnZVOEdUcGtvdUJTUkdxbDNmdE84ZWNCMjlGQUpVM2Qw?=
 =?utf-8?Q?FxuWNU/ddNmSZwCUNBA4ziPWx+6Ukg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y205M1JSMmJBUmhCc05lbnZPVFl4Zk5iRXBWRmVJVXh5TjEzSjBXOERXQW1K?=
 =?utf-8?B?c2E2OGFYbDREM0xZS0IrYkhrMndraStJTUNRMVpXdVdrWGVsVnorL0ZidzMx?=
 =?utf-8?B?ZlppY0Z0NmljUnBuN3FsanRaZ0RWa1NuYlFlNzJ3R0UydG9oRVV4T05xSEJD?=
 =?utf-8?B?TEFnQTNOV0VPSXliMXJaQ3JwR2lROVV5aFJBQWhYUDdZZzRHR0hncmt0dkxi?=
 =?utf-8?B?Q3lIaUxmVlZvdHBMeHdGbWJGTkt2WHNKaGllNmdvOVRwR1BqUStTb2dEUkt3?=
 =?utf-8?B?NzdrVGtvTEtublk5L20wajhqekpaYkhZamh0dng2YmNJMUVqMXBNYnQ1NEsy?=
 =?utf-8?B?ZU05MnlKMnlKSGRyaS9LbWtnMHZtYWlGWDJqdG5JTTBFZEplczJBMS84UmQ3?=
 =?utf-8?B?M20wS0JBMTBrYXJBSGQxTS9NUXRLR3l0STZTUC9Nb1pSZExleWVxbzB6RkRE?=
 =?utf-8?B?cXU5amJpb0xXQ2g2a3dreC96Q0V3UHhBN2JFUVVyVVFiOHpWWWVnMjJqUHE5?=
 =?utf-8?B?cWw1VjdLbkdRZklVQ2pQc1dsZEdjR1BSWHFwdFpUZ1JKZVBSQzgwSlNxb0NZ?=
 =?utf-8?B?alRYcm1ON3haeXRtOGt1YW04bTVVRFhKZXRNQXl5L2M4WlpRU29VT0Y4N2hC?=
 =?utf-8?B?c1ZNekJRMDgrK1VNbU9HL29kdWkxSWFaVkRiQzN0eHl2eDdUYStvOWZRb3d1?=
 =?utf-8?B?bjd1eSt3M1VnTzNUSjB1YzhrbXJxbEVmb2pmRVpJZ25KVXl1ZnRDZzhRYmh1?=
 =?utf-8?B?ME5CQVd2MmpxZWk2eDBsVGxPdjVoc3Vac1RpZ2VodUthWnhWZytiNEhXSVo0?=
 =?utf-8?B?K0p1MTJlalo5eTh1dG5YQURtS05QYVhPd25LT2luY3hlVGNSY0M3VjlHY0FT?=
 =?utf-8?B?MmNFWm01eGdmcmRCMVRzS2N1Q2RMZTA1K25NMUxoRlRuekJNNm1hTWU0M3ho?=
 =?utf-8?B?QlpSZ2MrOEdNQ2sySzltd0Y1TFhhWDBxcy9JOXBRNm44bnB2VHdmVmpzbTha?=
 =?utf-8?B?NnJDM1dTRlMwTGpka1VaazlDRUlKSVZmclpmQm9FYVNReHBPTWhFbFVncElR?=
 =?utf-8?B?VjA2WDBRRkFMRDJHc1luNjBnVWg1YzlDSkRHVjVwU0MvVDFVTVZHeVdRdEF2?=
 =?utf-8?B?QlM5UGw2d09GSjhQQ0VvT1JNVERRdmp4dHJPbENJTjk5WkR0L1o4bkxTV0RM?=
 =?utf-8?B?c0JPaVYrTnhEVURya1pFdTFPODFwb0pwa3NIN1R5cjk3SFVCemh5eGt4REhF?=
 =?utf-8?B?ZWlQYjgwTFFxalI1MjM2NFMwTjlxYkQ5L3ZRTUJCZE9pQTRKQVhhaXpObXo3?=
 =?utf-8?B?dXhMNi9BK1lPTmc5ZmhHdTkxWldvQkhYQUF0dTd5cFArOS9tczR2WCtDaS9r?=
 =?utf-8?B?eXYyM2k1d0czZ0RYNWZZMjhBZGtyL0IzMHJHczBlTEN5Mnd6U25aR083UnZm?=
 =?utf-8?B?RVNHekZIWDl1T2phcnA5c2oxTHZoWGprWDNEOWp6SFc4NHo2TGJYanpTU3Nl?=
 =?utf-8?B?bUlEV1MvSWFYN0psSC8ySTFNaUxqTkpXTDRMZkxDQzY0ZUIwY1F4UWM2cDBE?=
 =?utf-8?B?SkUvZ1NRSUtMNGY1RmNRcEFBMlRYS3JaMW1vY3E4ekMvU0EvcytlWFJGRnkz?=
 =?utf-8?B?dDljclcxOFVxNDYwMDd6dk9jRWZHZVBBOENEZUtacklmQ2ljMGJsNnd2cVZU?=
 =?utf-8?B?cWZjYVZvQkhpb3k5T1Y5VjNkekNWaEVvYUpJckNtVTZOeUdqVG1zOVFEdWg1?=
 =?utf-8?B?NFlUN2VNb3BKSysyZGxGcEc5aFVnSWpuRVVSSDlaa21HNk95aEFqbHVnUXNS?=
 =?utf-8?B?eEpmNHJvMklGN0hNUE5vZnRwcU9sbUR6cWlSMEY1NUFmek5BTDFibnJhdXoz?=
 =?utf-8?B?TkkwK3Arem52QjFsNXFBOURLTndQdDFTdDViS1YrS25rQzRxNkV4RjVUL3lP?=
 =?utf-8?B?OVord3lhcG9YTzI3SEZYS1BuMTE5V2FOeG42c2IrNG9qeGhZNVF6bkErTFJM?=
 =?utf-8?B?cktmOG5jMlhOREdha3hxcUowcVVnNmxSWmtEQytxaHRSRFMrSi9hYmpHUGhF?=
 =?utf-8?B?L21lWHJ4ZXUyblhYQmpEVWZ2RmR5VXlzVzlsZUowUEo4MVE2ZDZhWjd1ZThj?=
 =?utf-8?Q?S59o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997a6002-3bf4-4f64-8419-08ddd6b4654a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 19:47:23.7771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BApl9QEljWCFChEzjtveQDTtCvuYl/kbcnKlUhTyCZf0aqCE7U67JrygNx+Q6/KOYlMFnLC3iv12eC23clXs3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDgsIDIwMjUg
MzozNCBQTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
a2ZkOiBIYW5kbGUgbGFjayBvZiBSRUFEIHBlcm1pc3Npb25zIGluIFNWTQ0KPiBtYXBwaW5nDQo+
DQo+IE9uIDIwMjUtMDgtMDUgMTA6NTcsIEtlbnQgUnVzc2VsbCB3cm90ZToNCj4gPiBITU0gYXNz
dW1lcyB0aGF0IHBhZ2VzIGhhdmUgUkVBRCBwZXJtaXNzaW9ucyBieSBkZWZhdWx0LiBJbnNpZGUN
Cj4gPiBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcCwgd2UgYWRkIFJFQUQgcGVybWlzc2lvbnMg
dGhlbiBhZGQgV1JJVEUNCj4gPiBwZXJtaXNzaW9ucyBpZiB0aGUgVk1BIGlzbid0IHJlYWQtb25s
eS4gVGhpcyB3aWxsIGNvbmZsaWN0IHdpdGggcmVnaW9ucw0KPiA+IHRoYXQgb25seSBoYXZlIFBS
T1RfV1JJVEUgb3IgaGF2ZSBQUk9UX05PTkUuIFdoZW4gdGhhdCBoYXBwZW5zLA0KPiA+IHN2bV9y
YW5nZV9yZXN0b3JlX3dvcmsgd2lsbCBjb250aW51ZSB0byByZXRyeSwgc2lsZW50bHksIGdpdmlu
ZyB0aGUNCj4gPiBpbXByZXNzaW9uIG9mIGEgaGFuZyBpZiBwcl9kZWJ1ZyBpc24ndCBlbmFibGVk
IHRvIHNob3cgdGhlIHJldHJpZXMuLg0KPiA+DQo+ID4gSWYgcGFnZXMgZG9uJ3QgaGF2ZSBSRUFE
IHBlcm1pc3Npb25zLCBzaW1wbHkgdW5tYXAgdGhlbSBhbmQgY29udGludWUuIElmDQo+ID4gdGhl
eSB3ZXJlbid0IG1hcHBlZCBpbiB0aGUgZmlyc3QgcGxhY2UsIHRoaXMgd291bGQgYmUgYSBuby1v
cC4gU2luY2UgeDg2DQo+ID4gZG9lc24ndCBzdXBwb3J0IHdyaXRlLW9ubHksIGFuZCBQUk9UX05P
TkUgZG9lc24ndCBhbGxvdyByZWFkcyBvciB3cml0ZXMNCj4gPiBhbnl3YXlzLCB0aGlzIHdpbGwg
YWxsb3cgdGhlIHN2bSByYW5nZSB2YWxpZGF0aW9uIHRvIGNvbnRpbnVlIHdpdGhvdXQNCj4gPiBn
ZXR0aW5nIHN0dWNrIGluIGEgbG9vcCBmb3JldmVyIG9uIG1hcHBpbmdzIHdlIGNhbid0IHVzZSB3
aXRoIEhNTS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNz
ZWxsQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9zdm0uYw0KPiA+IGluZGV4IGUyM2I1YTBmMzFmMi4uNDQ5NTk1YWFiNDMzIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+IEBAIC0xNzEzLDYgKzE3MTMs
MjggQEAgc3RhdGljIGludCBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcChzdHJ1Y3QNCj4gbW1f
c3RydWN0ICptbSwNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgbmV4dCA9IG1pbih2bWEt
PnZtX2VuZCwgZW5kKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgIG5wYWdlcyA9IChuZXh0IC0g
YWRkcikgPj4gUEFHRV9TSElGVDsNCj4gPiArICAgICAgICAgICAgICAgICAgIC8qIEhNTSByZXF1
aXJlcyBhdCBsZWFzdCBSRUFEIHBlcm1pc3Npb25zLiBJZiBwcm92aWRlZCB3aXRoDQo+IFBST1Rf
Tk9ORSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAqIHVubWFwIHRoZSBtZW1vcnkuIElmIGl0
J3Mgbm90IGFscmVhZHkgbWFwcGVkLCB0aGlzIGlzIGEgbm8tDQo+IG9wDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgKiBJZiBQUk9UX1dSSVRFIGlzIHByb3ZpZGVkIHdpdGhvdXQgUkVBRCwgd2Fy
biBmaXJzdCB0aGVuDQo+IHVubWFwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiAr
ICAgICAgICAgICAgICAgICAgIGlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9SRUFEKSkgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGUsIHM7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdm1fcmFuZ2VfbG9jayhwcmFuZ2UpOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodm1hLT52bV9mbGFncyAmIFZNX1dS
SVRFKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJW
TV9XUklURSB3aXRob3V0IFZNX1JFQUQgaXMNCj4gbm90IHN1cHBvcnRlZCIpOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzID0gbWF4KHN0YXJ0LCBwcmFuZ2UtPnN0YXJ0KTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgZSA9IG1pbihlbmQsIHByYW5nZS0+bGFzdCk7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlID49IHMpDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IHN2bV9yYW5nZV91bm1hcF9mcm9tX2dw
dXMocHJhbmdlLCBzLA0KPiBlLA0KPiA+ICsNCj4gS0ZEX1NWTV9VTk1BUF9UUklHR0VSX1VOTUFQ
X0ZST01fQ1BVKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkciA9IG5leHQ7
DQo+DQo+IE1heWJlIG1vdmUgdGhpcyBhcyB0aGUgbGFzdCBzdGF0ZW1lbnQgYmVmb3JlIGNvbnRp
bnVlIGJlbG93Lg0KDQpEbyB5b3UgbWVhbiBqdXN0IHRoZSBhZGRyPW5leHQgbGluZT8gSUUgTm90
IHdvcnJ5aW5nIGFib3V0IHNldHRpbmcgYWRkciB3aGlsZSBob2xkaW5nIHRoZSBwcmFuZ2UgbG9j
az8NCg0KPg0KPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdm1fcmFuZ2VfdW5s
b2NrKHByYW5nZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByOw0KPg0KPiBUaGlz
IHdpbGwgc2tpcCBzb21lIGNsZWFudXAsIGluY2x1ZGluZyBzdm1fcmFuZ2VfdW5yZXNlcnZlX2Jv
cyBhbmQNCj4ga2ZyZWUoY3R4KS4gSSB0aGluayB5b3UgY2FuIGp1c3QgY29udGludWUgaW4gYW55
IGNhc2UuIElmIHIgIT0gMCB0aGUNCj4gbG9vcCB3aWxsIHRlcm1pbmF0ZS4NCg0KVGhhbmtzLCBJ
IG1pc3NlZCB0aGUgIXIgaW4gdGhlIGZvciBsb29wIGNvbmRpdGlvbnMuDQoNCiBLZW50DQoNCj4N
Cj4gUmVnYXJkcywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgV1JJVEVfT05DRShwLT5zdm1zLmZhdWx0aW5nX3Rhc2ssIGN1cnJl
bnQpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9obW1fcmFuZ2VfZ2V0X3Bh
Z2VzKCZwcmFuZ2UtPm5vdGlmaWVyLCBhZGRyLA0KPiBucGFnZXMsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVhZG9ubHksIG93bmVyLCBO
VUxMLA0K
