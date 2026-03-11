Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941461062899
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 12:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98AA10E8E8;
	Wed, 11 Mar 2026 12:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="ioR1jSIS";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011032.outbound.protection.outlook.com [52.103.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0219F10E889
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 10:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOLqDU2ArHFHk0P4bOhpDQN4A34vCUi2nLX8MFeNjHfyKxMe7jpx7QxwD5xdDCjar8/BL1YUU/lK499i08ItNVvbRsEmAaYhUM3R1B4cWBuCTWXQW4u41iAcchWuIwVkcISgIl9WcPh2KqFHvgGXjFEf06CMnTJ/yRBO45hpnmDjhP+K1o6m7Di0NHqmFSACgmVktftxvBks4orx6fDhTdR0eicJbpCF5vUR81Nk1WTRdMtNDU/3bCWnb7g8AI4ckZ/Suj+iSbjh/kFo5b4KRpIWKznF7ygr3flVvffBXsFUO4u3HqhamozyS2NJ/OQwlHAKa4kYh8z5IogAPF/Zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWZurRFjaox77JWUFFAx13n1Is2UWMmCjj7NKAoyskk=;
 b=qetOKzPv/3QxdL43cw3UOzk7ztkmtWtYmNIv79Fwi79q3g+irUzvcvQ6u0bgyeX785IjvKh5/NuulwGFirP3RLugXIu9xUr3E4Sq01q1lkSeHfz1sq5hqdmpE1bN6ABESWfgJ7vzFR7C98q3TOdACVH8CMclwZzQ0oAKUAiYEZ8vwrZa1ziPiQ9GmWgl79A5JlXeVB89yKX1H41P3rEEXEE4rNqocY78qwUm9BqPm0B/j7Ze9rvdUBYJeOQumEcJ7w2NgCtf4z4djjOhyadQxIxpfU4Rwas1spWTdxyw+0IhCvBRm/0gIMqROKjNVaQ4Cx+q+fUN4cgLpkv8i0JLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWZurRFjaox77JWUFFAx13n1Is2UWMmCjj7NKAoyskk=;
 b=ioR1jSISLNNxhyNOlYvcL+QU/usWmNbrY+JXpjRHBOpScni0JHP6+6+yZ3qnqQ+yLEVlrLCiz9uhiHUaqPMEZ9FrjTRM8c/vjj+fPNjR3Oq3T89U1Q1r5RglPMtZN3SAHYjbTQeMkHNlHCimKPT3+IBm/7LDx5YF4VYD3Te5GD4fYmjo3K6UXKoJ8dtALByTvyLJrlRpHvW7xAYtwjV0v2bWnrw+HRxWdvBbqdwLHyDMdLIS3xGHL/97ksLdFq6sAfeRKblXw7AIUaZI/oPVSW1Il1q4x5w7Cwk4TSWZVTsHpee6A1fFMUo+cvNWzjVBleLJx2fddPMW4VodGZ7Www==
Received: from OSCPR01MB14427.jpnprd01.prod.outlook.com
 (2603:1096:604:3a7::12) by TY3PR01MB11789.jpnprd01.prod.outlook.com
 (2603:1096:400:406::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:16:08 +0000
Received: from OSCPR01MB14427.jpnprd01.prod.outlook.com
 ([fe80::882a:3611:800d:2e18]) by OSCPR01MB14427.jpnprd01.prod.outlook.com
 ([fe80::882a:3611:800d:2e18%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:16:09 +0000
Message-ID: <OSCPR01MB14427664767D9032224F563E29847A@OSCPR01MB14427.jpnprd01.prod.outlook.com>
Date: Wed, 11 Mar 2026 18:16:05 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 siqueira@igalia.com, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6FxgYkg8QZDkUWP7zP6MdH1P"
X-ClientProxiedBy: SEWP216CA0081.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::7) To OSCPR01MB14427.jpnprd01.prod.outlook.com
 (2603:1096:604:3a7::12)
X-Microsoft-Original-Message-ID: <1c597b6f-9bdb-4dab-aee3-f9bdc1ee8be9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSCPR01MB14427:EE_|TY3PR01MB11789:EE_
X-MS-Office365-Filtering-Correlation-Id: 824e9f67-e211-4eb0-c86a-08de7f5736dc
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|5072599009|15080799012|6092099016|12121999013|461199028|8060799015|19110799012|51005399006|440099028|4302099013|3412199025|12091999003|26104999006|1602099012|20055399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXJhMEhpSDFkTzdBUEtsSzkyNDBGWTRqbFVvVGdSa1NiMGJZeGVKTFFrdGtJ?=
 =?utf-8?B?aW9HVys1MlpldTVwOFpZelVFY2J3cGVWZ21oWHZ0YUZZTU55ZDNBbHMyb3lw?=
 =?utf-8?B?M1VGQ09nbXdTNlVsdUZ3aVE1RW9FcmpEb1Rqa3hpdzZSNmJwaVFCbVBWbUow?=
 =?utf-8?B?dmNvdUlXMVNZaWlER09ZMWtFK2pQTWg0bHIxYklaTytTeFBjYUxKRDhLVnl4?=
 =?utf-8?B?dVhmREtLZTc0WFpiY1J4N0VkWndTc1ArMGNtNGpOL2M4VGxrVmZnZGJzeW5D?=
 =?utf-8?B?eGx0SGpUdk10WmdwaUxLYjlNaERDa0J1U0tJdFRyUTN3eG1COUFQWTJHQzBx?=
 =?utf-8?B?ajgrNndXYnNzY2Z2ZFVlMlFaNE0vcVJEaDN2bDZ3d2NPYXlIem85YU0vMXBW?=
 =?utf-8?B?SVYxZ0hzWFN1SlZKUlJMUFFFTlN3U1lSRDMyelJXVVRlL2lDQWNrck15ODhr?=
 =?utf-8?B?dVNTbmdhdXdtVmJ6WCtaaG9MSFY0S0JKZDM1SlkwVmUxdDU1clNNWU00QnZF?=
 =?utf-8?B?OGpSeG9yeFBaMVNmTjVlOFBaSXhZRHF1cUwxWjRxRGE0ZkJMV2Y3ZStOOHpF?=
 =?utf-8?B?cFB0SHZTRUdWd0tMY1EwRUVQOWp2YWNSbFNiT01rVm5XOVE2N3N5Ymt4cVZk?=
 =?utf-8?B?amZ0N0hSSGhXeEJWWndkdVgzQVA1Tlg3YW9nNjJidkc0c0c0QUN5U1ZzZUdY?=
 =?utf-8?B?blk0aTIya1dSTHUwMWFWeEsrR1FiOVhadlJVN1dTY24wUmdERWFIa3E0L25H?=
 =?utf-8?B?cTNYelA5UlFLVGpybDkxcDlpZVRJcklSODdOeVZMODVicG5vejRQalVqNnFK?=
 =?utf-8?B?azVHUVVFbFZJU244WVN3dHFIQm5xNFF2V0lmZFg0OGtOS0JTeEVSYTNMbS83?=
 =?utf-8?B?dVRwNTRPL01pOGZVcFl6RmlrSHU5QnpjR2FIS0JoeE84cjdEeXgwTTRQN2JS?=
 =?utf-8?B?cDZDc3V6Y3Y3YnB1bW1aWVdHM3J3Vnh2ZnNVeW9iaTltUHdnMEoxMUJYOTNx?=
 =?utf-8?B?U2k2S1lWcE1pMnMwV0JGZjlxSUhSYmNIZ295NXVkeXVSRjFwMzlYdFFOVHM4?=
 =?utf-8?B?Yk9zamNFVkZzV3RCMFVoSzBkNjVpRnQ5T2tjUHdyOGlFOGJMOXlyOHZBcFg0?=
 =?utf-8?B?SXJ5bzFGNGhZaHNGZW5UV2NOV2tZUFdRVTRYR3g2NDI3RCtiZHltQmRzQk5O?=
 =?utf-8?B?cFNuVHAxUTF5VWdpMUh2UFBWMVZMMkh5NWRDSEdGblZKZTVISW1YR3NHdjMw?=
 =?utf-8?B?bzk3YkV1L3NpUzBaSnFRbGNkZjdpNWszR0tkaERCQjhQNUdXMmR1SUMvNnlO?=
 =?utf-8?B?OGdRRHFMTEEzcU5BMlpiby9xUjZJTlU3TkRFa3hYTm4wUDQxWS9LZ0dBN3hT?=
 =?utf-8?B?aDJxMk1NVmZJWEE1QklTM01UV2NZaTkzOTQwS0pFdlpINTdxajJMdFd5Nngx?=
 =?utf-8?B?bm9zMjg4NTE3Wk9BVVhETnFqb0NaTEsvMWJMeFhlcjNDWForeVJpeThObmIx?=
 =?utf-8?B?N3NhdlZWdmRwWjZTbW1KSGVMZHlvL09OblhyZ2pDQWtnTGpSc0d0WGwyanhr?=
 =?utf-8?B?blAydz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmUwUDBTeVplZjA1UUhRMGtNU3pEWWVJQzlCT2pGU2ErdTBkMkM3UjZXYnlP?=
 =?utf-8?B?L2U3WnJZaDQvUzZWdUF6bUhwRk05N0REcC8yQmd4aXlCWlpMa2pHcVJYMGl6?=
 =?utf-8?B?SVhNTmNVSUZQK3dGSkJOMWhldW5pTGZUVXVoY3VLSzhMY1NQNWk3TzNRV2lB?=
 =?utf-8?B?eXBOaENTWGorVWwzVnQ5Z0gwdG0vSE1MYU1MZnNHY1NBdFlXbEVnM1h4ZDFu?=
 =?utf-8?B?bFpWblJKb0xEbE9zU25BY0FocVI0QWhjWkxnc0poRWw1UlhSSlY4QVYwTHUy?=
 =?utf-8?B?S1U5Y3lFL3hBWnl4RExONjlJa3pSVWRwN2R5ZEluT25UaVRVeE9lU2ZXalF2?=
 =?utf-8?B?eHNWYkd4bUxoME1ubVR2WUNmR0QvdGJ0d1AyaXpkNmtPaWVNOUU0cGJybzlW?=
 =?utf-8?B?Wmo2NkFhZWRINVlzbDZDTDVOSXhoRFVucVJQbXVJOFZkek9sdXl3MFpWZDI1?=
 =?utf-8?B?TEtWS2NQY0VUOFhyclF5TkJoWWc5Uk5qZlVMR3RhVkFNUFhPSHA4OHBCQ3BH?=
 =?utf-8?B?bytxY0tPanVoK2pDQWN2eDZWUHFmcHVZdFJ4bDFQYzlzdVhiemVZV1pBOWQ3?=
 =?utf-8?B?b05yMnZFVW00akgvN0VXZSt1a20wQUVubFd3bEtZRnRLYSs5Ky84MUhKclNS?=
 =?utf-8?B?bzRmb0ZKVk5PQUloQ1FwdkhheURlZDdHVmRLL2FCM2ZoZWpNMndGbUx1dWNv?=
 =?utf-8?B?RzBrOU5oblRIcFJyZE9YZlNsZGp4UkhsMFoxMHU4OHJTcURyL1cvVnByN1hD?=
 =?utf-8?B?S2tDTWtORHJTeDVmdm1iaW82dmJaUFRkNG5hVTdMZnhNSzQ2VUhKeStLSnpX?=
 =?utf-8?B?OGVva1RWMHlvQjB0d1dTcU1qNVo3SFJXVlQxdmN6aGsrcVo0bXIrem9WQm00?=
 =?utf-8?B?UlVuR0pQQ2lacHZ1eFpTV0FUZTZ0SDBYVTRtbURhUHU0YkpWaVFBdGFDbWNt?=
 =?utf-8?B?cHlIOC9Mc3hYd0FpUFlDVHpseHhNNFhUeHBiUVcxYmlRbGgrZ3Y1cDEwU1ZO?=
 =?utf-8?B?YzkvTHJZQW9ZTjlLY1VMZitjbVFUUlVLRk1maHNYWUhvSWtzTndrU3BqcEs1?=
 =?utf-8?B?enhwL3M0Tm5PREF1Wk9RWnVUaVRodmc1NFp0SUg0Ni9lWks4WExSMklrcFpi?=
 =?utf-8?B?SnEwTml3UDh4N1RKNkRPenZpWEtEdWJKbnd0eURuWFBSaWxXZ2c4eFhmbzF4?=
 =?utf-8?B?cWFRckEwUEhQTkMvVHN4Ky9pM1ZJVkNOYUxCeERJbE9CMUhFRitoeHlBbFVP?=
 =?utf-8?B?SUtCaFRDSXl1aXA1aFFib1NXbk0zTzZSYVZMVFMrdzFKaFFpOUZFeHkzTmVm?=
 =?utf-8?B?Z25KY1JvMDEwNVFRSXhzcm9Bb3ZubEdhUGpZUzFlaFZFWmxpbzZ2YjRVU2Ir?=
 =?utf-8?B?d3RtV1hMUU9TMkYrWnZFNENBdTVISTliTXdld1lHeVV5RnpQUGUwTXhwdXhu?=
 =?utf-8?B?cTRmNVArdXBmS1ZrR0I4cHpFb1plZm9mbEZ1Q2IzM2NoRHNtM2pMRm9idFFT?=
 =?utf-8?B?TkFNWHVnQmpyeW5HTVJVK3dvYUE0NHMrUWV6d2ZKRTNDcitBT3dudlVSQXdG?=
 =?utf-8?B?Yk9IMlNjUnhiT053bi9PVHgxZnBJc1VHcUtjUEJRWTRZa3JRM1V2Y2ZjQjVU?=
 =?utf-8?B?bFRBTnR6WVIxc0h1dnExQXlVR29LbUE3VHd4TGFvSTlZS2dwUWx0elBjcitQ?=
 =?utf-8?B?aElXUWRLMDAzN012SUxvWlNNaXUrRDNJVVpvM09jUWhSQXJkRzhQQ3dGYnZP?=
 =?utf-8?B?bGZ4ZWtvQm9sZTJ6bnZ1OXJ0UW40cVptdmU5emUrTitxOUl0Wm5ScWkweGtr?=
 =?utf-8?B?Q2hBKzNjbkh0S2ZaeGN0Wmc5TURsNlpwd3JNRXMzLzJRdDBCbE9ZaUFFc1hr?=
 =?utf-8?B?U3pvbTJmNjI5Tm9FR3pjejNsZmkvSmp3d1owaEh2U1dpZ1h6ZGorZTFJVkNO?=
 =?utf-8?Q?a8XpeWvUdMbd6an7LzGh1xarxsewpfAj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824e9f67-e211-4eb0-c86a-08de7f5736dc
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:16:09.7944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11789
X-Mailman-Approved-At: Wed, 11 Mar 2026 12:54:53 +0000
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

--------------6FxgYkg8QZDkUWP7zP6MdH1P
Content-Type: multipart/mixed; boundary="------------YYnLJQC5Pwthmuym1xNJgDpo";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>
Cc: wiagn233@outlook.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 siqueira@igalia.com, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
Message-ID: <1c597b6f-9bdb-4dab-aee3-f9bdc1ee8be9@outlook.com>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
In-Reply-To: <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>

--------------YYnLJQC5Pwthmuym1xNJgDpo
Content-Type: multipart/mixed; boundary="------------pTdwJJ32BdnD50fz9QbeN0IR"

--------------pTdwJJ32BdnD50fz9QbeN0IR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29tZSB0ZXN0IHJlcG9ydDogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9h
bWQvLS9pc3N1ZXMvMjk1MCNub3RlXzMzNjY1NzUNCg0K5ZyoIDIwMjYvMy8xMSA3OjUwLCBM
ZW8gTGkg5YaZ6YGTOg0KPiANCj4gDQo+IE9uIDIwMjYtMDMtMDkgMTI6NDksIE1pY2hlbGUg
UGFsYXp6aSB3cm90ZToNCj4+IE9uIDMvNi8yNiAwOTozNywgTWljaGVsZSBQYWxhenppIHdy
b3RlOg0KPj4+DQo+Pj4gWW91ciBuZXcgcGF0Y2ggaXMgYW4gYXBwcm9hY2ggaSBhbHJlYWR5
IHRyaWVkLCBhbmQgaW4gbXkgcHJldmlvdXMgdGVzdGluZyBpIHN0aWxsIGhhZCBmbGlwIHRp
bWVvdXRzLCBzbyB3aGlsZSBpIHRoaW5rIHNlcGFyYXRpbmcgdGhlIGN1cnNvciBldmVudHMg
bWFrZXMgc2Vuc2UgYW5kIGlzIGNvcnJlY3QsIHRoZSByb290IGNhdXNlIGNvdWxkIGJlIGRp
ZmZlcmVudCBmcm9tIHdoYXQgaSBpbml0aWFsbHkgYXNzdW1lZCBhbmQgc2VuZGluZyB0aGUg
Y3Vyc29yIGV2ZW50cyBpbW1lZGlhdGVseSB3YXMgbWFza2luZyBpdCBieSByZWxpZXZpbmcg
cHJlc3N1cmUuDQo+Pg0KPj4gTGVvIGkgZmluYWxseSByZXByb2R1Y2VkIHdpdGggYSBicGZ0
cmFjZSB0aGF0IHRyYWNrcyBldmVudCBBUk0gKGZsaXAgdnMgY3Vyc29yKSBhbmQgREVMSVZF
UiB1c2luZyBrcHJvYmUgb2Zmc2V0cyBpbnRvIHRoZSBpbmxpbmVkIHByZXBhcmVfZmxpcF9p
c3IuDQo+Pg0KPj4gVGhlIGh1bmcgY29tbWl0IGlzIGEgY3Vyc29yLW9ubHkgdXBkYXRlIG9u
IENSVEMgMDoNCj4+DQo+PiAzMTA4ODQyMMKgIGRtX3BmbGlwX2hpZ2hfaXJxIFt0aWQ9MF0N
Cj4+IDMxMDg4NDIwwqAgREVMSVZFUiBldmVudD1mZmZmOGI1MTkyMjVjNTgwIGNydGM9MCBb
dGlkPTBdDQo+PiAzMTA4ODQyMMKgIFdBSVRfRkxJUCBFWElUIDJtcyBbdGlkPTIwMzA3MV0N
Cj4+IDMxMDg4NDIxwqAgQVJNIGZsaXAgZXZlbnQ9ZmZmZjhiNGYyNjE4NGMwMCBhY3J0Yz1m
ZmZmOGI0ZWQxZGRkMDAwIFt0aWQ9MjAzMDcxXQ0KPj4gMzEwODg0MjHCoCBjb21taXRfaHdf
ZG9uZSBbdGlkPTIwMzA3MV0NCj4+IDMxMDg4NDIxwqAgV0FJVF9GTElQIEVOVEVSIFt0aWQ9
MjAzMDcxXQ0KPj4gMzEwODg0MjLCoCBkbV9wZmxpcF9oaWdoX2lycSBbdGlkPTBdDQo+PiAz
MTA4ODQyMsKgIERFTElWRVIgZXZlbnQ9ZmZmZjhiNGYyNjE4NGMwMCBjcnRjPTEgW3RpZD0w
XQ0KPj4gMzEwODg0MjLCoCBXQUlUX0ZMSVAgRVhJVCAxbXMgW3RpZD0yMDMwNzFdDQo+PiAz
MTA4ODQyNcKgIEFSTSBjdXJzb3IgZXZlbnQ9ZmZmZjhiNTE5MjI1Y2UwMCBhY3J0Yz1mZmZm
OGI0ZWQxZGRlMDAwIFt0aWQ9MjAzMDcxXQ0KPj4gMzEwODg0MjXCoCBjb21taXRfaHdfZG9u
ZSBbdGlkPTIwMzA3MV0NCj4+IDMxMDg4NDI1wqAgV0FJVF9GTElQIEVOVEVSIFt0aWQ9MjAz
MDcxXQ0KPj4gMzEwODg0MjjCoCBBUk0gZmxpcCBldmVudD1mZmZmOGI0ZjI2MTg0NDgwIGFj
cnRjPWZmZmY4YjRlZDFkZGQwMDAgW3RpZD0yMDg1ODBdDQo+PiAzMTA4ODQyOMKgIGNvbW1p
dF9od19kb25lIFt0aWQ9MjA4NTgwXQ0KPj4gMzEwODg0MjjCoCBXQUlUX0ZMSVAgRU5URVIg
W3RpZD0yMDg1ODBdDQo+PiAzMTA4ODQyOcKgIGRtX3BmbGlwX2hpZ2hfaXJxIFt0aWQ9MF0N
Cj4+IDMxMDg4NDI5wqAgREVMSVZFUiBldmVudD1mZmZmOGI0ZjI2MTg0NDgwIGNydGM9MSBb
dGlkPTBdDQo+PiAzMTA4ODQyOcKgIFdBSVRfRkxJUCBFWElUIDFtcyBbdGlkPTIwODU4MF0N
Cj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuLi4NCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAxMDAzNm1zIHNpbGVuY2UgZm9yIHRpZD0yMDMwNzENCj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBubyBkbV9wZmxpcF9oaWdoX2lycSwgbm8gREVMSVZFUiwgbm8gZHJtX3ZibGFua19k
aXNhYmxlX2FuZF9zYXZlIG9uIENSVEMgMA0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIENS
VEMgMSBjb250aW51ZXMgbm9ybWFsbHkgdGhyb3VnaG91dA0KPj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC4uLg0KPj4gMzEwOTg0NjLCoCBXQUlUX0ZMSVAgISEhVElNRU9VVCEhISB3YWl0
ZWQgMTAwMzZtcyBbdGlkPTIwMzA3MV0NCj4+IGFjcnRjIGZmZmY4YjRlZDFkZGUwMDAgPSBD
UlRDIDAgKGNvbmZpcm1lZCBmcm9tIEFSTStERUxJVkVSIGNvcnJlbGF0aW9uKSBhY3J0YyBm
ZmZmOGI0ZWQxZGRkMDAwID0gQ1JUQyAxDQo+Pg0KPj4gRXZlbnQgZmZmZjhiNTE5MjI1Y2Uw
MCB3YXMgYXJtZWQgYXMgY3Vyc29yIG9uIENSVEMgMCBhbmQgbmV2ZXIgZGVsaXZlcmVkLiBO
byBkbV9wZmxpcF9oaWdoX2lycSBmaXJlZCBmb3IgQ1JUQyAwIGR1cmluZyB0aGUgZW50aXJl
IDEwcyB3YWl0LCBhbmQgdmJsYW5rIHdhcyBub3QgZGlzYWJsZWQgKG5vIGRybV92Ymxhbmtf
ZGlzYWJsZV9hbmRfc2F2ZSBpbiB0aGF0IHdpbmRvdykuIENSVEMgMSBrZXB0IGZsb3dpbmcg
bm9ybWFsbHkgdGhyb3VnaG91dC4NCj4gDQo+IEhpIE1pY2hlbGUsIG5vIGRtX3BmbGlwX2hp
Z2hfaXJxIGZpcmluZyBtYWtlcyBzZW5zZSwgc2luY2UgdGhlcmUncyBubyBuZXcgZmINCj4g
YWRkcmVzc2VzIGJlaW5nIHByb2dyYW1tZWQgb24gQ1JUQyAwIGR1ZSB0byB0aGUgdGltZW91
dC4NCj4gDQo+IERpZCB5b3Ugc2VlIGFueSBkbV9jcnRjX2hpZ2hfaXJxKCkgb3IgZG1fdnVw
ZGF0ZV9oaWdoX2lycSgpIG9uIGNydGMwIGFmdGVyIHRoZQ0KPiB0aW1lb3V0PyBBbiBlYXN5
IHdheSB0byBjaGVjayB3b3VsZCBiZSB0byBlbmFibGUgRFJNIHZibGFuayBkZWJ1ZyBvbmNl
IHlvdSBoaXQNCj4gdGhlIGZsaXBfZG9uZSB0aW1lb3V0LiBUaGUgZHJtX2RiZ192YmwgcHJp
bnRzIHdpbGwgc3RhcnQgb3V0cHV0dGluZyB0byBkbWVzZzoNCj4gDQo+ICAgICAgZWNobyAw
eDIwID4gL3N5cy9tb2R1bGUvZHJtL3BhcmFtZXRlcnMvZGVidWcNCj4gDQo+IEknbSBhbHNv
IGN1cmlvdXMgd2hhdCB0aGUgYWNydGMtPmV2ZW50IGFuZCAtPnBmbGlwX3N0YXR1cyBlbmQg
dXAgYmVpbmcgd2hlbiB0aGUNCj4gdGltZW91dCBpcyBoaXQuIFRoaXMgZGVidWcgZGlmZiBz
aG91bGQgZHVtcCB0aGF0IHdpdGhvdXQgbWFza2luZyB0aGUgaXNzdWU6DQo+IGh0dHBzOi8v
cGFzdGViaW4uY29tL3U3aEdSN0w0DQo+IA0KPiBUaGFua3MsDQo+IExlbw0KPiANCj4gDQo+
Pg0KPj4gVGhlIGNvbXBsZXRlIGJwZnRyYWNlIGlzIGhlcmUgaHR0cHM6Ly9wYXN0ZWJpbi5j
b20vWGlqdTQ0Q3kNCj4+IE5vdGUgdGhhdCBpIGRpZCB0aGlzIG9uIHRhZyB2Ni4xOQ0KPj4N
Cj4+DQo+IA0KDQo=
--------------pTdwJJ32BdnD50fz9QbeN0IR
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------pTdwJJ32BdnD50fz9QbeN0IR--

--------------YYnLJQC5Pwthmuym1xNJgDpo--

--------------6FxgYkg8QZDkUWP7zP6MdH1P
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmmxQOUFAwAAAAAACgkQX75KBAfJsRlm
tRAAo7nuqOdDZvETJRelFxJzhY9ISwOHKQXcGvcpa/8VVDbKZns1nfwGPXIbtb3WBAyVDZYip1Mx
MpEX6pSLyHFdTryEmE6Fy22CSPpkpod9EPr0DAaD9vRcEktUJxkm12YeUZ1R+iTUbKzLUTG+/Fxl
SxNK/viZdl5jAtpMn/kmMJX9vtYi3URNWDJ1gIrUOunpmAebfSRwN0gGlB2ER/QFgFOJGv/oK71/
3TsNwR8+W3+w2V0hxl8OeO84GeFonq02RD9GJ+aulPwcJulDShUgGoaAQVOK4IFcV93iH7bkTxK5
lBRZ4oXuMz2e159KBRk83wZf+7LxSl5kN9QcHcrDu3ProxK9J3LFSR0qV6qNxFEeJffhCTFPIqLJ
v+Duj05KL0TaiJ8jCM60ts1cmyXOrwfR3k/cKXVY5CmkF/sn0E+JACN+Xsh6i7ubeTZqqKRkL+qM
iKS8PbK8iXpVKExWZ4oLHgt3pPcbNs2wKrZdpLK0+QVlzK0yLSLyHNABZrsNKd5RDMAuKu8pvb0O
QPivMdjVvrKg+jIKeWrOHu2oZRFi2wf1KK1m/kVyiGWQvJzkRQXRPycpf5de81piRDU4OBBnnObU
MqIBQZVEPVMXnNT0+7UvHl0ye73Efn4HPCCCcVpTvgi7AoyrQJtN5Hkc5ZCHXCcVRVpYOq8fZxFc
iN0=
=XrrD
-----END PGP SIGNATURE-----

--------------6FxgYkg8QZDkUWP7zP6MdH1P--
