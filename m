Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9385C35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 06:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF9110E1F8;
	Wed, 19 Mar 2025 06:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZ5cutW7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7CF10E27F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2AQwrSKHhHHpnwo9GuO0X7EAsXGUFiZJD22Bqb1cQZVrSMLBrFg9MXzy10xbz2luNnUTcr1ZhzYvOKZ0X7Npvv7vWBKvwsNRJeppcILh2IOlLQzpHrtm71YUMTVEbevUP9Kotzk0ULXsAN7GummyojA0FH/6qhrl5j8eW8Z5DUmX2wJTAugRv3eoGzcBXPVunORoFz9Hs9fLEzEHh8PorNzvVfu4m+JzJkDXlb5yCLnpPghNWgGMBJlk4sNw8laX4JYy2q9/WqSDHDFIkv+ge6VjPwqn++Qa69+QYScQYhtDUizwleqS7UuVIBtNipfi3bCkhf2Pu7LaYqnyuEXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iPNaeshUI/25AKql/EWbqoqLjqg7ZsZ/ShoflwxB44=;
 b=gj5oFKeE/5XlnjX4CQ/S4SmVFqV2eFHL7k+xlAqahK9lTDT9s3IeUQwY4F22sdk9pIELNZ+mNzqlWiP13lG8YLmuO8ZhKT1y1PXDQM0QI/1DXqpOLsO8k4M5EKmcQsVao5tu5ZEYqXGosskz6Gz0Oims5nyc0PYTNURBUsmhsJjyiRZmhi3e9V4okNKU/SCdr1rnDkM1WSrVm6CXw8XagxrexAMh9y9uu1BM/LRGgaqsF1X9uGgfeRonb33XOZWELld6w/oavRiCOj4FZMCbhA8p0aVLssI+5Qke7zKXzGWYPQT9EDDm8tYfMbA75qYKlNFZlmxc4iAhaJB7ix/YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iPNaeshUI/25AKql/EWbqoqLjqg7ZsZ/ShoflwxB44=;
 b=qZ5cutW7PGxrmQhN4oPSgmjJSsQbvdvC5qdDRpOAAkGmlMkpcxDZiFQIciodgee290sCG+Yr2b/juMxhX5wx8U5C/r9Zx9DbVAtSYx6npfgijBW7YuzPgOqGTdbxzN8uAPezCyIy/5Bcn52lzfxlSD29bfSA3cPri72fpHG0B3k=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:10:56 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 06:10:56 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: Add debug bit for smu pool allocation
Thread-Topic: [PATCH 1/2] drm/amd/pm: Add debug bit for smu pool allocation
Thread-Index: AQHbjykLNQAn3PSO9kaNAX2So6lIFLN48y8AgAEZqnA=
Date: Wed, 19 Mar 2025 06:10:56 +0000
Message-ID: <DS7PR12MB6071CB2CA73277A7F736503D8ED92@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250307062006.251686-1-lijo.lazar@amd.com>
 <ea28a732-60bb-4d2f-af1f-1451a987f9b3@amd.com>
In-Reply-To: <ea28a732-60bb-4d2f-af1f-1451a987f9b3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=06438305-d56c-40f2-82ea-28eee4aed9ea;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T06:10:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: 9bea9d66-e145-48a7-e143-08dd66accffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?R3RHWDVzajVwZGRuSTZ6NkZNWktQc3Z0ZXZxZUVjODdDY2poT1NVdmlXdGFJ?=
 =?utf-8?B?aGtqY3JlMFlEYXQwcEo4RHhUYzZyRGFOYWZUS0QyWVdyaDFpMnA4ZDJHMXln?=
 =?utf-8?B?eWxzK0w3WGVnTzNOWlpDVk1hY2ZMZERUYko0aHJvMTJ6SHdQNFQ4ZE95Y3B6?=
 =?utf-8?B?NnNHQ3NGYlVWT1pMc0IyQTZWVlJla3orR2lnTmdVM0xRQnQrNENxTmhhdU55?=
 =?utf-8?B?Q2RGUGV0QzNaanVka1JYWHdvNHVFMEVUSTJQSG5SS1Zlb2Q3bkNwU1MvanNN?=
 =?utf-8?B?Rk1SSXdkWDI1c3Y3VmJ4Tm9xalZBd0xkcnZjUExETnlBbkhCM1dTby80VVpK?=
 =?utf-8?B?S25xbnZmbEZaTGhLVVoyNEF3bHR5SnhsMlhDVDc5NzZXSkFKM3BBajU2ejhx?=
 =?utf-8?B?QU1iQ2RYNytZSHBrbUZ5SGF4dXRDUUp4YXFvWFZsM1hQNDZIYnZIUTJqV0RH?=
 =?utf-8?B?UlRJZndZU3pOOS9JREIrZTI0RzcwNTY1R2NTRWJYTWpTdDJNZXUrVjVJTUdH?=
 =?utf-8?B?RjZuSkhyc0VXRWVjb0VLRGJ0NXVvdHgxT0s1Z29Va3JsSi9yanBtWG41ZzNT?=
 =?utf-8?B?NGVqUlk5SmQ4UWFqcERGMnpXaktJTHB1RnRIdER4RW9LMW1zeVNCaUM1Tm5r?=
 =?utf-8?B?bDdBeHZZdFU4WlNGMDNkZW9XVmhrbUdqeUR5SE9lYm5QR1BZbml0RGVZbng3?=
 =?utf-8?B?WGtGcThMZG5wV3pVRUZqRkRraDFZcWVDVUFMYWkzbTVOZWZFSVdhMnc1K083?=
 =?utf-8?B?U3liOWtZSGtFQ1JseUxNakJKSExHWTJpTmxBaE1RUE5Bcjh4NzJUWjNRV0ht?=
 =?utf-8?B?MWZ0N3VyWU91YWUrQlduZHdIR0twMEJlQXFLSWlRUU0xdUErKy90cUtja0pL?=
 =?utf-8?B?MWsyVVFzTUpCbElMOEtOaEhyNzd1ZlpwM3pydE96R1NnZmlGZUprWXM4OFhS?=
 =?utf-8?B?Z3VSWVRWWFd3TlJzbmd2Slp4czhlM252eHdDOUh6c095NmduenBDZ0hNN2ov?=
 =?utf-8?B?T1EzMWNHT1pjNXJkNHQ0dTZYQjJlUHZLK3B6bGV0U1l2SGJkUVJHWHBDbm9z?=
 =?utf-8?B?dkwrTFlJM2ZMcTNQMVlxVHBNVklpakRvQzZOZ09WMjZOakdCUDNOeDJhcmlm?=
 =?utf-8?B?cEw1ZnBhU3ByMVZZcEJsOWk1UFFzb24vcnQwYXVqQmk0T3VBblpNbjIxS2VI?=
 =?utf-8?B?RXhYZUY5OFhqWUZSTU5yUkRDVnA5aHFtNGpyQ0JFNnA4RjJSTDNCMjN3Rlhi?=
 =?utf-8?B?ejVMK1FrTncyZ0VwTUFnNUlEN0EvVk5scGpadVNwajVicDFFbnZIQXV2OFpV?=
 =?utf-8?B?emdVTUlIZnI4L1hSL3JSWjFtWGZJblY5OS9idlFPYUJtSVNJM211Y05GZ1Mx?=
 =?utf-8?B?bG5PYXJMRHFsY3A4Sk5iZUlScll5VWdyVGZha2szWTJyVEszcGpsNVFNcGFj?=
 =?utf-8?B?NUJnMkx5b21ndWpKTkZrUGFXU1crT3AwWW9sUE5SNm1adGtpVFZSdGtRKzQ5?=
 =?utf-8?B?WXhJY2ZsMkFVRUxGVko1bldzamY5SDBRV1RnM3NjV2E5L0ZKZHh1WjBXZlEx?=
 =?utf-8?B?VHhnaTJZL25rNFpiek85N0pwSXBpWDZiTk1EdWk4a0ZUMW1wY3ZvYS85Rms3?=
 =?utf-8?B?SUhBa0J3ZnRaekRhc1NKQnNkUGc5Z3BodTlFSFhRcFRid04wOWx0YUlaUndj?=
 =?utf-8?B?WTRIM0IyRjRDZHp3dHN3cElRSUE2blJuekdYcG51Z1hYTTNMcHZYdm0rRDlt?=
 =?utf-8?B?Q0RnOThKUEdKWkhFYzRteks3SzVMQ0RzNnNDWVB4WEZXdldDWXpGT0FVVDRx?=
 =?utf-8?B?bng5TnVNSUwwSDVkRVNoRnF3UE1kNTU0R2JyaXV0VTl1eDhMVFVvZUZYRDIz?=
 =?utf-8?B?MEFWQVQ3UFg0YThSTFhrZUxRbm0wZmdlQUcva2NYY2hMQ05GYjdXR2k2Z2o5?=
 =?utf-8?Q?X9tn1808+HBdTrGmcHHn5TmPc1sjm9dI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dml2a2ljVW1aWDRCWWRURmhiUkpzclliTDFXZDBsTVNzV2NMYmphc05zOEhX?=
 =?utf-8?B?SEk5UFp0OWRYQ3FoMWU5NitaaTZmWGorU2dQMWtpdTRDbyt5Z3d0c1pVMVhs?=
 =?utf-8?B?WVNkeVpIWUZ0VEdKdFVYZEd0NzFsalJ0ZlgwNjVvMkN6aktFNnBPMzViN3J3?=
 =?utf-8?B?UzVNaXpJck9CWHVMdHl5YklTS1EreDJEVVJPcU93Mkllb0FiaEprOElTNnUv?=
 =?utf-8?B?M1pjT2J2bStqa1BYMWFMUlFnK0tKQmcrZndwUDZUQXQ2UEl0YXc0RWlxOEtH?=
 =?utf-8?B?WGtFMGxpMWxPc084Q3JKdjBnTmQ3Znh6WTNoTEpxNklleXNWTDIyaWVyUGZF?=
 =?utf-8?B?VDVKOWJpeXllV0I3NFB1dUlhc1V5YnFHR2pxMGZMU29GdmRFUnFxTUppYnE1?=
 =?utf-8?B?bVJ4WWZTVWVTS1dwYStpTXM0dXB4QUxTMytqUUpEVW4yZGk0eHA2WWphNFdS?=
 =?utf-8?B?eDdBZTJEcXBES0NibjViVUJ6Zi9ZYTZXYXFoN3o4UWxxL25Bd2ViaVRPc0Vn?=
 =?utf-8?B?bXVrOG1pN3A3cW5lK3VQL2MxTnhmd0h0bHl5NlNUOXBuSDA0UEZEeGpkVGJ4?=
 =?utf-8?B?ekh1RStJTC9UcDNMZFE1TGlsdi95WFBycDJ3TFp4NVRlbnRycEZMSjkwa2N2?=
 =?utf-8?B?aTE3eHVnSndVeWlOeE5aT01lMjFLMjJuTlVtRWd5cFJYbEpKVnVBQ1FHLzFZ?=
 =?utf-8?B?dmgzMFA4bzU1dHFOc3ZVSEc4OGZqMDN4ckZSL2gxejM0dzRkOTViWVIvRXBL?=
 =?utf-8?B?cm1oR2VySTR5NkdCbjY2bWtVRzlmaGpGVWJCWVk0Wjl5Yk4zNWJBRmw2UXdm?=
 =?utf-8?B?TzNVaVg1V1JycXI3TWZ1c0tPa0hmck9ycENYS1N0dmQyZ1FoeXIwQStJQXRT?=
 =?utf-8?B?emFiZ1pDblNKVnF2Qk5LV0kyT0pWWk1SZjk3NXVvWE14eHlOL2NsVzFDRWFL?=
 =?utf-8?B?Wm9DR2NVdFMrWUE4YW4rTlNvanFxV1dWWThReWl0L0FmUFdXMzd5dFFvYmlW?=
 =?utf-8?B?c2FMWno1VlhRSzE5d3d2bTJjKzRveGpiSUZDT1NJZXQySjZCdnFhT3V0L052?=
 =?utf-8?B?OERmQkQzL04yUzNvSEh4N3VqRTdyaGIveEw2VVVib1JWd2EvdWNoOEQ3R09C?=
 =?utf-8?B?OC9iR0VFc3o0Mlo2UjgxT2ZiWEFBM3dPWmpBTjlvaWVNWWtLWUxmNFU0UEQy?=
 =?utf-8?B?Y1AveThobXBNd3JnUzhtZ0VOQUg4UFlieHNyN0Z6OUhyeGx3TUtHMXdjNjFU?=
 =?utf-8?B?TWx5c3M3NWM0dEpqRnAvUEpEY3lDeUVtTTlxUnR2OHRzWlRoL0QrSmxPZ09P?=
 =?utf-8?B?OXpjMFdTTUVSZ2VzcFNBWk11TzFHR08wcmwzMnAyQmVtb2ZyR2k5bkl0OTli?=
 =?utf-8?B?dDRWdFhqME83UUxuYkxjTE5qZnlXZlRXRnRnQ3ZnYjVCdTZ3eGhDT0svYkF5?=
 =?utf-8?B?UlZtVER0TFF5V2JodEdINVdoNzArUGk5TCtqMFd3T21Kc21FeHBVYkZwQ3Qx?=
 =?utf-8?B?dzkwRk13NFd5V05mUFdHSXVqNklOLzdkRllla3F6dEVnVDRMYVR4OVZJcE1Z?=
 =?utf-8?B?Y1JmMlkzUm54Nnp4dFJUVFFPcWFSSzl1aGRielBHUEgwWGxjWVdUOTNYQldt?=
 =?utf-8?B?NGh3UkdZQ1cwOFdQT3BoY3l4SDVnM08vc0thQU51K1BTMDZqL01wM21oN1Ji?=
 =?utf-8?B?b1FtQW9UdFNnU0NDdG9oNVBQenRSUkZwb05tTzRGWUUwdWpIbEZyOTgwSzlF?=
 =?utf-8?B?dHU2UzFHTEtSK2hDaWNNUG02N3JFMEk5WEpXSGV4cWhkOFY4bDJzZVVXaFE5?=
 =?utf-8?B?ZWIwUU43eXRvUHlud2VyRElCSnhoZzVOZmo3bENJYkcwV0ovYUFDdlk3Y3F6?=
 =?utf-8?B?NExWcmxVZU85ZGdsVUtOdHNsdnBRKzZhL2NnQWlLMzY1MGVjZDBNeG5OZzJQ?=
 =?utf-8?B?SjRiUlczTFdLdzU3czNHUlBYYjJoblVDK1p1dFdFaGhUbFFldGdibU1Tdk1W?=
 =?utf-8?B?VmlBQ2Q2VmNsVU5RVktHY1BveEg1QnlsUTYwNjJHQVZDRFpmTXc0em12Z0M3?=
 =?utf-8?B?cXF1M3k4MGFTRllnT1B3RDZ5VCsxdHRZaHZRRjlKVGFQM2VNYThkVnR6Sysw?=
 =?utf-8?Q?0kFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea9d66-e145-48a7-e143-08dd66accffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 06:10:56.6013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWCUuTXtoS1NLK0BluiODQ8UfH5K0ckYiHU+vq62aQ1yfW+KSuLcfpttP8x5eZKUqyGOBas1rn96y5SzKGl41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
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
Cg0KUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCg0KVGhhbmtz
ICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IExhemFyLCBMaWpvDQpTZW50OiBUdWVzZGF5LCBNYXJjaCAxOCwgMjAyNSA2OjUyIFBNDQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWQvcG06IEFkZCBkZWJ1ZyBi
aXQgZm9yIHNtdSBwb29sIGFsbG9jYXRpb24NCg0KPFBpbmc+DQoNCk9uIDMvNy8yMDI1IDExOjUw
IEFNLCBMaWpvIExhemFyIHdyb3RlOg0KPiBJbiBjZXJ0YWluIGNhc2VzLCBpdCdzIGRlc2lyYWJs
ZSB0byBhdm9pZCBQTUZXIGxvZyB0cmFuc2FjdGlvbnMgdG8NCj4gc3lzdGVtIG1lbW9yeS4gQWRk
IGEgbWFzayBiaXQgdG8gZGVjaWRlIHdoZXRoZXIgdG8gYWxsb2NhdGUgc211IHBvb2wNCj4gaW4g
ZGV2aWNlIG1lbW9yeSBvciBzeXN0ZW0gbWVtb3J5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaWpv
IExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jICAgfCA1ICsrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2luYy9hbWRncHVfZHBtLmggICB8IDMgKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L2FtZGdwdV9zbXUuYyB8IDUgKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiBpbmRleCBiMTYxZGFhOTAwMTkuLjIyNzc1YzIwNDYzMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBAQCAtMTQwLDYg
KzE0MCw3IEBAIGVudW0gQU1ER1BVX0RFQlVHX01BU0sgew0KPiAgICAgICBBTURHUFVfREVCVUdf
RU5BQkxFX1JBU19BQ0EgPSBCSVQoNCksDQo+ICAgICAgIEFNREdQVV9ERUJVR19FTkFCTEVfRVhQ
X1JFU0VUUyA9IEJJVCg1KSwNCj4gICAgICAgQU1ER1BVX0RFQlVHX0RJU0FCTEVfR1BVX1JJTkdf
UkVTRVQgPSBCSVQoNiksDQo+ICsgICAgIEFNREdQVV9ERUJVR19TTVVfUE9PTCA9IEJJVCg3KSwN
Cj4gIH07DQo+DQo+ICB1bnNpZ25lZCBpbnQgYW1kZ3B1X3ZyYW1fbGltaXQgPSBVSU5UX01BWDsg
QEAgLTIyMzEsNiArMjIzMiwxMCBAQA0KPiBzdGF0aWMgdm9pZCBhbWRncHVfaW5pdF9kZWJ1Z19v
cHRpb25zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAgIHByX2lu
Zm8oImRlYnVnOiByaW5nIHJlc2V0IGRpc2FibGVkXG4iKTsNCj4gICAgICAgICAgICAgICBhZGV2
LT5kZWJ1Z19kaXNhYmxlX2dwdV9yaW5nX3Jlc2V0ID0gdHJ1ZTsNCj4gICAgICAgfQ0KPiArICAg
ICBpZiAoYW1kZ3B1X2RlYnVnX21hc2sgJiBBTURHUFVfREVCVUdfU01VX1BPT0wpIHsNCj4gKyAg
ICAgICAgICAgICBwcl9pbmZvKCJkZWJ1ZzogdXNlIHZyYW0gZm9yIHNtdSBwb29sXG4iKTsNCj4g
KyAgICAgICAgICAgICBhZGV2LT5wbS5zbXVfZGVidWdfbWFzayB8PSBTTVVfREVCVUdfUE9PTF9V
U0VfVlJBTTsNCj4gKyAgICAgfQ0KPiAgfQ0KPg0KPiAgc3RhdGljIHVuc2lnbmVkIGxvbmcgYW1k
Z3B1X2ZpeF9hc2ljX3R5cGUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+IHVuc2lnbmVkIGxvbmcg
ZmxhZ3MpIGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVf
ZHBtLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmgNCj4gaW5k
ZXggOWZiMjZiNWM4YWU3Li5mOTNkMjg3ZGJmMTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9kcG0uaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2luYy9hbWRncHVfZHBtLmgNCj4gQEAgLTI5NSw3ICsyOTUsOCBAQCBlbnVtIGlwX3Bvd2Vy
X3N0YXRlIHsgIH07DQo+DQo+ICAvKiBVc2VkIHRvIG1hc2sgc211IGRlYnVnIG1vZGVzICovDQo+
IC0jZGVmaW5lIFNNVV9ERUJVR19IQUxUX09OX0VSUk9SICAgICAgICAgICAgICAweDENCj4gKyNk
ZWZpbmUgU01VX0RFQlVHX0hBTFRfT05fRVJST1IgICAgICAgICAgICAgIEJJVCgwKQ0KPiArI2Rl
ZmluZSBTTVVfREVCVUdfUE9PTF9VU0VfVlJBTSAgICAgICAgICAgICAgQklUKDEpDQo+DQo+ICAj
ZGVmaW5lIE1BWF9TTVVfSTJDX0JVU0VTICAgICAgIDINCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gaW5kZXggNTRhMzFkNTg2ZDU1Li5mNmRlZjUw
YmEyMmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1
X3NtdS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5j
DQo+IEBAIC0xMDI3LDcgKzEwMjcsMTAgQEAgc3RhdGljIGludCBzbXVfYWxsb2NfbWVtb3J5X3Bv
b2woc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+DQo+ICAgICAgIG1lbW9yeV9wb29sLT5z
aXplID0gcG9vbF9zaXplOw0KPiAgICAgICBtZW1vcnlfcG9vbC0+YWxpZ24gPSBQQUdFX1NJWkU7
DQo+IC0gICAgIG1lbW9yeV9wb29sLT5kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7DQo+
ICsgICAgIG1lbW9yeV9wb29sLT5kb21haW4gPQ0KPiArICAgICAgICAgICAgIChhZGV2LT5wbS5z
bXVfZGVidWdfbWFzayAmIFNNVV9ERUJVR19QT09MX1VTRV9WUkFNKSA/DQo+ICsgICAgICAgICAg
ICAgICAgICAgICBBTURHUFVfR0VNX0RPTUFJTl9WUkFNIDoNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIEFNREdQVV9HRU1fRE9NQUlOX0dUVDsNCj4NCj4gICAgICAgc3dpdGNoIChwb29sX3NpemUp
IHsNCj4gICAgICAgY2FzZSBTTVVfTUVNT1JZX1BPT0xfU0laRV8yNTZfTUI6DQoNCg==
