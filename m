Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F8C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 07:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AAE10E34F;
	Tue, 28 May 2024 07:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIxnBYbT";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB2B10E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 07:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F695M5SGSlkSYOcEWjXHPGKOoGcVXWQqWhaHm6MYwKBYypJtV76Db2vXz86KbTQ3Ue9xipAvt+tkbVvKV/WUZt6Jd1BLRVzct8iIu4sJajFhGi/a+yRU5T1pNAIp6mUY5JUg54C7ZQS868I78vhmtYPAiDfNUUH/PJ7vHb+kdhTTNyhE1MJLtYZvQ3QLlAz+eWL0mZRHhPK8wBx+1xDvJ6sngRHEM/DJsjBIFgNMFUoz9UCyVhOlZ2u9x46+keLaG9/OiiXkAYog2EpB1MLFJ0mY1Z8Hg6oKlyu3J9wwjoF/EwHmZXpX5ym280TmMQmqtuZmH4isHA/ZR4oa1o4Kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxSTl7X5/fHSwKxa6zuGCJ053wWHOzawe5cWUkn/9nE=;
 b=VAE8u8NKWYY8d00hPi2pT/Ol8dOqgkto3VBKtOpnYSB4TPBHzsDQQozaJbkeCmZgYIB3Yg5fs62orpKJ7Yb8M+1y/dPlOMK3LulBcgJ+GsHOf7cG9UOc4N84UnY050a6va57Ak+Xz6jh1o64ISZzpoirKHMbn3gujn32+JMsJNiIP7k3n4Wk3dG7iuDnLD9CMzauJ6LGMprm5GeVTIygGfVwJO2Xh4KDW455ZU7OzqXaKI/WCG3pHCYmOerRHwtkPC3hvV9ofU1p4CxdRJvMOSoGUCDTuN8dOZ+9EWL5f1g8Y4fHguV1DhkZmhPUDE3wWcpR8EnhpL8s7D6cn8Jqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxSTl7X5/fHSwKxa6zuGCJ053wWHOzawe5cWUkn/9nE=;
 b=GIxnBYbTkc3v64bJZPQkEUl/p3yRjkvKdeZXnW4A+PH4ZLoSh3483Y9Bb59v8cI43kB+klABvaTocvOqeVeDKqpcVkvCddz5Pb4LLY+doweKnl7qUYcTi8V/BH8uM7LDCpSFc7QjIP7Or073muA6eyX8MFFvuwXKNtRix/RJh8k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:19:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:19:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma, Jun"
 <Jun.Ma2@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix missing error code in amdgpu_od_set_init
Thread-Topic: [PATCH] drm/amdgpu: Fix missing error code in amdgpu_od_set_init
Thread-Index: AQHasMvI/qDOWixsvkmlBZBuOz1vBbGsPNsQ
Date: Tue, 28 May 2024 07:19:11 +0000
Message-ID: <PH7PR12MB5997BE1CB46189510D5DBB9E82F12@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240528065316.1875823-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240528065316.1875823-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=af248813-bc75-412c-beb0-cc7bd65fc849;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T07:18:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW6PR12MB7086:EE_
x-ms-office365-filtering-correlation-id: f1dc0aaa-24dc-4887-a77b-08dc7ee678a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eEVOMWgzQXlycGJLZmMvZUovREluYkQ1OTZ4YkpZbE5VY0dheWdqTzgwRXht?=
 =?utf-8?B?M2NDTkQrSUdIQzQ3VDdyQ2ZWMUN6MUlrbEdhdXRhNGM1TnNBYmlWdExnQVJN?=
 =?utf-8?B?UUw1TjdQZzlhZjdTWW4vc1pyUHMyNmNEZFU4Qm9FR3ZpMFMrbURmcFBvbWtS?=
 =?utf-8?B?UWxQM1dlVkJCazNFNGx0UERzSDBmWWp3Rk83VmxwZ1IrY0Nmc2w1MEVrcUNQ?=
 =?utf-8?B?ajRsKzFYUWJkWFljTHVYTVVWYXlMd3YwZVhkYnI3d0ZQcDUxR01tSy9telNj?=
 =?utf-8?B?cTdaY253UFd3ZEpheUliZTNaM0JGc1E4ZDBOUkZCWDF4WlNGZG81SzYyWFR1?=
 =?utf-8?B?cGpCeFUzaklwNE1DV2RKVkp4dTB5RlRDQndSN2tSYmNMTmxSL2gwamtnREQx?=
 =?utf-8?B?QUdjMjRIMlJubHFibGdxVysraEtyRzlybVpCakFKc2RnbWhVVnBLd0hHNVZX?=
 =?utf-8?B?WmRQNFVaUTVwZ1BzVGpJOHc0UTFXUjgvdkYvWWxuaUtWajQvSVFpbW9KVXRW?=
 =?utf-8?B?OUt2NmppS2d6MmZ3UGg2Mk8vZjJiMWxLbndWeEd1a3g0ZURmeC9Ya3NCN3pm?=
 =?utf-8?B?ZzBvdEl2UUc2K0UzUjhXb1RmNThHSUJWTm9FMXh4bVdabEwwSW9manZIUEVv?=
 =?utf-8?B?SWhTK0JXK0xnczBvUlI3Qllka3FCVGYzeXZmL1lvbHltcWtwQjgvdk81MUV4?=
 =?utf-8?B?Yy9KOTQzc3hYYnczbjhxUFV6aS9rb3Q2YmRiZ2ZpcWRzbS9jazhsM0dqYkxU?=
 =?utf-8?B?V2IyTXV6OTg3ZWhOcXJvU05mdzlveGk0RTZRT29LTEVRL2QrZnNVT2ZLUDFQ?=
 =?utf-8?B?enNpQVpTYWNneHhHTjgvdHZRcXU2cUpJbHhsY0h5dkFpbmV3cEQ3OEI1TWt6?=
 =?utf-8?B?ay83MTJiSjBJV09UUUJsOHRGWDFza2hKaDRPNTVxYUxiUDcvUWt5TW5XR1ZI?=
 =?utf-8?B?NklueVRtSm9YY0UyMTFBSEhhUERQdXR0ZnM5dnIyRVFYUDh6OXhyUE5OTE96?=
 =?utf-8?B?SUxBbWU0NUtYSUZINmdaZmdhbjhXQWRDcnJRTGI1UFNQU2dqMlluNEZKWHNs?=
 =?utf-8?B?aGFLR1ExWVVmL1JjVGhDSFBFa2tiajdVL21BQ2JGenM3amRBRXB3NElaUGJv?=
 =?utf-8?B?YnRHZ1RmUjVDVXZ3ZzNxc1JndGlQR1RCMzRJcmxsQWwrajRoVFZJNzNMaE4r?=
 =?utf-8?B?TitqaXlIUUVydDRCbmtJNG9ObzJZeXhnK3c4ZTJQOFNlS0RDQ3pSN2pZRnF1?=
 =?utf-8?B?RUcrVEpyYWVoUWZjQTZ4Q09jRyswZ1dpRC8wVzNOcG1Ya2k0RXZhWldwMWYy?=
 =?utf-8?B?eUtOb0lMeDNCMXVoWU5uMXV0cWpzek1yQXVPU2NsMGlOL1FyMXRIVEkyUkNy?=
 =?utf-8?B?eFdUSHd1NGhYYjRkdzQxK1g5bUZ1TEJqK2ZyOU4rcy9VQmthc1hYTW9sUzJL?=
 =?utf-8?B?YkVhOGJwUkd6UHVTQ3ZLUndrN3pjU3JrdzhJRHVxSEhpVjRYVURmUkJYc1Vq?=
 =?utf-8?B?STAwaGJyOTNUY3FZdDVMR1B2UkJWYUNvMVRLNFUrZ01IK1UxdTFzcUhwTWl2?=
 =?utf-8?B?clo3N01icW9LVlk2aHVFeXFBdGlJR1FJZk1zRnIxeGJDdmNMNmY0UmdPL3ZK?=
 =?utf-8?B?bXcvSDRoem0vMGRnZVM1NmU3R2ZzZU1EbG9BOWFmNVVWVCtjY1ZvL3BiWUFo?=
 =?utf-8?B?bkxycVVHazVaTHVGNFlsUzFmVWhJWHZQV09DNEx4RHdxL2diNUxKUnlhaUhL?=
 =?utf-8?B?RGpwUXBpd1ArbTJ5c0podWtVSjZHRFZ1c3lETGdBNjhidEx1YnBoRy85Y25N?=
 =?utf-8?B?dFhQd2xBWVhtc2hwWUFzZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE1tdStROGJsMFZEMUN3akNReXFvWXJzQW5NaXBrdHVpKzdtM29Mb3NmWXlT?=
 =?utf-8?B?SjlRdjdpRE1jTE10eEVtR294di9ac1dENnBaRlpsOHRHS040cmI0MS9Tc0N6?=
 =?utf-8?B?VVR1bm54UDcxekc2ZVl0RGlUb2JPUWVRYzhhWWNJOTFZUzE2YXk2M1Fwamx2?=
 =?utf-8?B?dVVtUVpGMnFXMG14T2t5WDYwNWZBWVgyTGFJMUhyYWRBZmtBL0N4OXpyRkJ5?=
 =?utf-8?B?T1VPZmdTN2J4bi83NUNZeTMrdWRiTm9TMmkrbGg5ZHFIb2ZxdVo1aWVQazF5?=
 =?utf-8?B?a2ZNMFRvb2pUck83SUhWOCt6eU5odytCbjVFRmZJQzRaSUlEZCsrYlVmTFBq?=
 =?utf-8?B?SnFJNHl1QWFMSXBRYUtjUndZZ1g3Q0NhQSt3NFdXdk9HRFUxNHVmWHkzQ0k4?=
 =?utf-8?B?ODBwTUtVa3FrUDJQU1N4UFZ5QU9nTGVoMzBseStNdFFES3kzNndVUnJRQ0to?=
 =?utf-8?B?VlhUb1F4L1FiUGtEZnhhQ0ZISGtaZURXekRuRXpQZU4vdmdkSVNKbVlISE01?=
 =?utf-8?B?NlhpMUorZm5TTmpZK2cyRFVpZ05QaGp2NVpiR3FsWE1GalpMc1dzbzBTbFJv?=
 =?utf-8?B?LzVyWk1GR1poRGJzcGVRMVlpYVNsWDNicHRsKzJrZ0ovK2tzdFhxaTlwTlZC?=
 =?utf-8?B?VXE5WVhrTy9iTW9zUEsxZHpMeW44YzVEVTU4S0VEbFRzdHB1cVdqK01pT2JU?=
 =?utf-8?B?VG5xd3RuRDY1aTdXbW02VUY5MjFnNkFZUUhLQkdBVTE4cDNURndNc215dGpH?=
 =?utf-8?B?MHJGNy9rcXhEaG91NXhHNjkvbE5TNFlXWDROL1dxd2FnaVJzd1h6YmY0MVo2?=
 =?utf-8?B?ek84aHJ3V2hxR2ZxclFzVGovMFhSLzNQdDk3REd3cGh2dkkwYVZVVEZmbEtz?=
 =?utf-8?B?alNGblR3TnJMYjdXbWRsY1ZuendGdW90VjE1Q3MwRXlOeEZMS3o0R3I1S1Bw?=
 =?utf-8?B?MGsweHUxT244NnN1eWJEeXlRcytXUE5VbXpiQzluSzl5aUVxNXR2NW5oTWVt?=
 =?utf-8?B?d0RBZEdEQ2hEZnRsK1V4Ym5ZRm1wd1EyalN6Y3RxZ1l2N2ZrMlZKMmNqOGZp?=
 =?utf-8?B?VjcwQTAva1pxRkNDT2crVlExQmVoMTZlTnJRUWovNloxVkNQaTFHNVNVRStk?=
 =?utf-8?B?V283WUpnWGMwcXMwbVFjMmg2Slo3OU9YQnVxd1FiblBRaFRJdkppelNQOGMy?=
 =?utf-8?B?NE5aRXhFZDd1YklhanlkTlRBdTljTFNFcSs3NmZiYVJDNzgvWm5WMU9jcEZZ?=
 =?utf-8?B?b21JWE1mVHUxRml1dWUxdGc1aTgyQnlhNFVieC9PVkh3dGlKakN5TlFLZkxt?=
 =?utf-8?B?VjNhdGJHdkdqRDdYbm0ybVpvMWVpMUpYc1p4NUlpekwyMnFQQUVYS2dOR1Zn?=
 =?utf-8?B?NXMyTVY4RnhZRFhNWmVIaFBKOXEwSkJ4VUZhcVVsU3J5Y20yUmFmZVJsbTl3?=
 =?utf-8?B?L2t2S0RuTnZWVkIwcUt0NCt4NFhBVEJoSmhpMk9Bd3pYclFCeTJwNnVaRndt?=
 =?utf-8?B?TVNNN2pxenRmNkFCc3NtQmdNWlFSN1kxZllEbjdOMytZQTZDOWRjRkFjL3Bx?=
 =?utf-8?B?Qmd3ZkZDakRLa2JpWFZ6S0t6U0Zmdi9MbGdVOXZTaEFMZDZEZkpXRXlXRk9r?=
 =?utf-8?B?TDBUNExXNkpGcytyc2JoMjVUNXV0eldOa2dzTU8rWHVwdm00QngrWVdINDlu?=
 =?utf-8?B?TC9qMjF4SDVuZVRwY2t6WUIxcE1rdFo0UEJWK253bCs4UUVpRXNHVkpMcDBX?=
 =?utf-8?B?S3FKaElGRUtIdnZ4MWw3T3pwSUpHV2xGaEhXQ0ZOMUJ5bldzRmdGWjFLSmcr?=
 =?utf-8?B?Q1BoZVV6SHFsYnZxWmJNQ0xvaE9TVHRJK3JrSVp3bmY5bjVMWDdSakkwUmx5?=
 =?utf-8?B?U2lwYy9XelVWUVdXNFpCSmRuVGNoSDNUSmpYTXdIZUV4MjBOMW9JWnQ1clVy?=
 =?utf-8?B?ckNUN3JCdGlvS0h5VVVmcmY1dStuK21VVmIvem1kUU5aVmE0MXN4M0J2Q1M1?=
 =?utf-8?B?MmE3NGlsMUNnSjBVUVlVVHZDT2ttcVRHUjE0b2M1QWFGUVRyTDJ5dG1aL0Zm?=
 =?utf-8?B?Yk93dzlPOFNMcjFkcDJnRHZnYXlBUG9qanFHR0d2a1phamoxQzJZWnpUWlll?=
 =?utf-8?Q?f3qI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dc0aaa-24dc-4887-a77b-08dc7ee678a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 07:19:11.1078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKzCLIa57JN5gYQAuvPaIOB1lLsFPbwZjW6KZmgudjtXd1cjUCOKUihGZyFpVlmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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
Cg0KSGkgU1JJTklWQVNBTiwNCg0KUGxlYXNlIHBhdXNlIHRoaXMgcGF0Y2guDQpUaGUgb3JpZ2lu
YWwgaW50ZW50aW9uIG9mIHRoZSBwYXRjaCB3YXMgdG8gYXZvaWQgY3JlYXRpbmcgYW4gZW1wdHkg
ZGlyZWN0b3J5ICgiZ3B1X29kIikgLCBhcyB0aGlzIGNoYW5nZSBtYXkgcmVzdWx0IGluIGluY29y
cmVjdCByZXN1bHRzLg0KDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMjQgMjo1
MyBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNB
Ti5TSEFOTVVHQU1AYW1kLmNvbT47IE1hLCBKdW4gPEp1bi5NYTJAYW1kLmNvbT47IFdhbmcsIFlh
bmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IG1pc3NpbmcgZXJy
b3IgY29kZSBpbiBhbWRncHVfb2Rfc2V0X2luaXQNCg0KVGhpcyBjb21taXQgZW5zdXJlcyB0aGF0
IGFuIGVycm9yIGNvZGUgLUVJTlZBTCBpcyBzZXQgaW4gdGhlIGFtZGdwdV9vZF9zZXRfaW5pdCBm
dW5jdGlvbiB3aGVuIHRoZSBvZF9rb2JqX2xpc3QgaGFzIG9ubHkgb25lIGVudHJ5LCBpbmRpY2F0
aW5nIHRoYXQgdGhlIGxpc3QgaXMgbm90IGluIHRoZSBleHBlY3RlZCBzdGF0ZS4NCg0KRml4ZXMg
dGhlIGJlbG93Og0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vYW1kZ3B1X3BtLmM6
NDM1NSBhbWRncHVfb2Rfc2V0X2luaXQoKSB3YXJuOiBtaXNzaW5nIGVycm9yIGNvZGUgJ3JldCcN
Cg0KRml4ZXM6IGQ5YTNhNWU3NzBkYyAoImRybS9hbWRncHUvcG06IFJlbW92ZSBncHVfb2QgaWYg
aXQncyBhbiBlbXB0eSBkaXJlY3RvcnkiKQ0KQ2M6IE1hIEp1biA8SnVuLk1hMkBhbWQuY29tPg0K
Q2M6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCkNjOiBMaWpvIExhemFyIDxs
aWpvLmxhemFyQGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdh
bUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyB8IDQg
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQppbmRleCBkNWQ2YWI0ODRlNWEuLjg2MTE4ZmJm
YzMzYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCkBAIC00NDYzLDggKzQ0NjMs
MTAgQEAgc3RhdGljIGludCBhbWRncHVfb2Rfc2V0X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpDQogICAgICAgICAqIElmIGdwdV9vZCBpcyB0aGUgb25seSBtZW1iZXIgaW4gdGhlIGxp
c3QsIHRoYXQgbWVhbnMgZ3B1X29kIGlzIGFuDQogICAgICAgICAqIGVtcHR5IGRpcmVjdG9yeSwg
c28gcmVtb3ZlIGl0Lg0KICAgICAgICAgKi8NCi0gICAgICAgaWYgKGxpc3RfaXNfc2luZ3VsYXIo
JmFkZXYtPnBtLm9kX2tvYmpfbGlzdCkpDQorICAgICAgIGlmIChsaXN0X2lzX3Npbmd1bGFyKCZh
ZGV2LT5wbS5vZF9rb2JqX2xpc3QpKSB7DQorICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsN
CiAgICAgICAgICAgICAgICBnb3RvIGVycl9vdXQ7DQorICAgICAgIH0NCg0KICAgICAgICByZXR1
cm4gMDsNCg0KLS0NCjIuMzQuMQ0KDQo=
