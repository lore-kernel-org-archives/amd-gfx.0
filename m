Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034A7EFB810
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A399710E509;
	Tue, 24 Feb 2026 08:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cBcIyO8L";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386A310E509
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he5/r2Q0MOkcpgH9io31jXEPS7lSrvBqvb0IMYqcePmGQ5lz8opsM3doY33uAryGNNjifD5kzy+z2BN4O2ElT+eXfh1+r1ZwaY5ET1QyndrR2QqtUi3X7+brIYWXerA7wVCaLuIzJplU7JG/OAFez/qnyD0K1cXHQECVhqVaKBBgty3Y5u/dJmMlnLPS498xKVj90yM8MTGBPV+HoIzZeX78B6h+ZxOTaafVIC7xYBsYTFhgV37RWhug2BeTlX4SqXADx6Ix8unZkigMs9vI0eL+1BRmrLLcRgkIBtcC5YiMP8Ark4iZsBzugPGs1zdq8gvXD1fdcxdcIt2NfUz10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTEhkTYFGN2dr/yyRupkj7X4NKEEcz9X1/Yas8WK/Tc=;
 b=lzCkqP73qqa/FkixmjBjMRWj9SxH4Wct/SinVWsUANj2m5c8q3w0JMMgxw1pVq+lP0LuaTLcL8Xenlqh9Zk17pzz0BI/9rR0kSruxLYqfTExTrNEJXOpkBEv1Ngnlp4dAFzrTYtIlqEjyHcBDwY+wSId6bCnP9MXEwj43iZyn7ipdVvGocdd9FSChftPDfPa/jwUvDPtrcqUiHlgtA7BIx4lQ+algWzyAtwkIWpAvJKP8kmIqo7Nah883zqlvh6hp02tKeLk5/jeASkkJSkjw+SsSyhcOFTR+3suiBJtu1t3/Ub2WsoYr8QHFIB92qS/zPAcVGSuNs2jsIl6z1Xq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTEhkTYFGN2dr/yyRupkj7X4NKEEcz9X1/Yas8WK/Tc=;
 b=cBcIyO8LwOo2CmbzQGTNHohc1mlP35kCP2M6Wi7Ev9RLeIspWKCZlikpqhrLmwR/ikm25P4oPWEt3Wh6bs0KWd87hnJGNiPhiQI6wo0LA3lTh4OQsTtQqro1Spm5JsuRpR2hkPVkCd5u1aOojP6Qw08JghNPE3dBf9wjIctxgfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:43:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:43:13 +0000
Message-ID: <d8c657b8-fbf6-4050-81a8-1d50fc874956@amd.com>
Date: Tue, 24 Feb 2026 09:43:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] drm/amdgpu: add upper bound check on user inputs
 in signal ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <20260224082443.4002292-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260224082443.4002292-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bb4c67-7e43-47b6-6d2e-08de7380bf3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkJzZ0JQbkdZK1dtTS9zcEgwR2lCSnJUOHJJZFpVd2lTdmlvaTRiMnU5bHc4?=
 =?utf-8?B?VUpCVUk2ZGRFU21ETlIydnhxMlBiRHVMRlplZWtsY2Z0UExpMW5yT0szNTR2?=
 =?utf-8?B?SWtzbEJmZnlEZys1Q1ZJSGMrR1ZGNUhEM1JXWkJtdndsU3JFbmVnOVBaWnZJ?=
 =?utf-8?B?cU9hRkJ5VjB3eW9veHZaUVE2TmYxcnUzOXFOWVdwTUMrenlHNHBnSG8wWW9E?=
 =?utf-8?B?eUVpU0ZQRUlsaHVWZ2JuNWswVmJGbVZSTWRvN0d2NHhjN1pkYUk2NldBbThD?=
 =?utf-8?B?bFN0bXBPU0MrSnZOWmwxajRzcWoyWFlra1JVOGpZU0YvT3JndmVSZDMyaldy?=
 =?utf-8?B?aEt4TW9qczZVdjkzeHNNNk9jci9JS25YdmdXVkE4VEJlUXJBREhyQVFRQzFi?=
 =?utf-8?B?alNPMThRM2pHb2FGeGZWNDJNZnJhYXNQQXQ4NC8yYkZXTEpUM3RBMCt1OGZI?=
 =?utf-8?B?ODFJRklxV1RFR0lFOUJrQUM2K3hDOXBCaWpQbkdKbUhMRjBzdTZ5T3FkeS9z?=
 =?utf-8?B?VjJ4RHN5QkUrQ1Y2MDJXZUdTMFZlWkhpM3Y0Y3lreEk3UFoyUmNvNEd3TnJB?=
 =?utf-8?B?NmozS0RHMFUwVlZZTnMxcGhWZjVzL2NtbGo5UUhGMHF4ejR6SkdLUlVtQ01w?=
 =?utf-8?B?UmJHQTJKVnVaSTRiRU85dDVLb0pKYXkwc0xZbVkvdndVNTRoRHNKZ20xOXZT?=
 =?utf-8?B?MkFwNVRqQlF1a3pPbDJDRzJRcHUxRUk1eXRaOWRLNGpodFZ0NmdKaVZtbjEv?=
 =?utf-8?B?ZHpJejhTOS9pSnYzTkxTemtpbWJsemNpdHJ0ZzZvV3EyeFFneXpWbjlLWmFR?=
 =?utf-8?B?YTcyQlhoZjJhM1NHaXZaMXZrdWJDODZ6T0JER1lMeVNNbCs3eVNUYS9RKzRn?=
 =?utf-8?B?S28vaFMreHhXOHNiRkxWYjgvM3NvTzBmZjMyVjRkdzEva3g0M3I2V212V1ZH?=
 =?utf-8?B?T3BaYjdQVDY0eHhJT1dMN2x3UFdWOFJxRTF0YXVRMkV2S2dzRXRKTjBzcjBX?=
 =?utf-8?B?UXZwK2QrMDl0SnBvQlkwcFB3Vlg1RXlZZC9wQWNTbzY3akwvRThiaUVIQmZn?=
 =?utf-8?B?cWZweFJSUVp1cVN3NjlUb0tQaytvdTNlRTNLMytzUkx1TzcwMHQ0b2J4Wnhy?=
 =?utf-8?B?RERjYkk3WGJHNEJocGpZTkRuNTBnR0IwemkwVzRNbzhRVHJMSzk5eC9MWi85?=
 =?utf-8?B?RXJaOGg1N3h3aDVucFhOa3N1OFFEOVUwVksrSnVJMkpYTlNJYUhwcXltdE1D?=
 =?utf-8?B?eGdKTmVqdVNjaTRhLzNkOGkxZzNDSEJuc255UEhGTXNPZzZqSWJtQTZ6RmRJ?=
 =?utf-8?B?YXVPVEJpMHZwclVCeWY4ZHJoenBxMjhjdWJCaHBDL09RVHJaZEZQK2d2YmQw?=
 =?utf-8?B?V0hKOHFpL0RwNkkxbGc0U2JDK1dnMW5NeTYwb0t6QVRwaDNqWmtkSWZGblZX?=
 =?utf-8?B?alpRNUwzUW1mNDl6cERScUFrRWx4YTR4Rko2NTBGT2F1NXNJcy9iaWRSTkl2?=
 =?utf-8?B?N0xrcC9Zd2hsSk5GWEgwTXhJMjlhS2RLdEhoSm5WYkw1ektyMGE2bTNKbkR6?=
 =?utf-8?B?WFB5cDhBc1ZNdGt3WHJvNkhGNWtvSFAvSHp2L0s4KzFuWTJZbDZSb01xWjhj?=
 =?utf-8?B?bEh5V1Z2TCtnTE55d3NHUWpuY1l6S0Y1S3I4MmNLMXJTNFFDRmdpSUlMSmhC?=
 =?utf-8?B?QUpqeDJCWFY1N3JoekNkWGpqRXFFOFhJYzV1N3ZSTi9QU0tzOUk4UDZodWZu?=
 =?utf-8?B?NllqWDZFb1ZNV045YTBMd2N3TUpXZ1g0eUpqS2Mwd2dqbXR5SHNQRi9oSlU5?=
 =?utf-8?B?RGtWVG5FNTIzWGJyZU9yY3VqS0o4OXZraXFqZFJPYVNHQzcweXFEYjJpZ3hS?=
 =?utf-8?B?NVl2d2d1bVRDMUpxNlE3bm1vbW1ab2hxdnFLcUVtZUZtaEVXZ1FYbUd0MWlQ?=
 =?utf-8?B?blBZd0dMMzBSRnpSL2JRcjhYVWxjMFJXM0d2d25wRlZxSXNabWEwTjBqUXdo?=
 =?utf-8?B?S0xEMTBPVG5rVDZJVnBSR24zZmRtQkoyU2M1S3kxSjRMOXRNRTlISDZYVExz?=
 =?utf-8?B?WVczdE1QVjNIWCtnSnkxbVlqUTNmK1V0OXAwMkZvQVlLdC9DUGlRbkVQZXgx?=
 =?utf-8?Q?YdyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRxL0c4c1BiUkwrK0lmZ25mTlJGZ1VuTmdUS3lEOUVoYVBvNGNDV0p5Vmtk?=
 =?utf-8?B?NWU0RjlGbThZYUhLYW91QnhWUzVybmZCWlNuNHE5SmR2NHpLQVFKZGFtYnps?=
 =?utf-8?B?MjBpbWpNVS9UOG5IdGxWODJkc2V0UE5wSnJoUmtqQStPTlp5and2V2pCMkVy?=
 =?utf-8?B?VE1MbnRTUm5NTUJzYWZLcXhJNXAwYkJCY2pWZTd0VkNXS3NyWDdRZHdtaHF3?=
 =?utf-8?B?dHlPWC9qVzlxWmxqanluWnJkdit3VWtQS2xtVkpVZ2VhZ1NZei9Vb2Y5bWVT?=
 =?utf-8?B?SFhDdEpsOG5TeTNIak9sQldBMkJDN0ZQdzV4OXNseWR0bjlnRFFQdGNYRlh0?=
 =?utf-8?B?UzBEbElXWWJOVTZGMEtoQ240TXFJdmI2a3gvcHRJSFFLeDRHai9PdTlXYmd4?=
 =?utf-8?B?M2xIK0t0L2ZRQXl0VmwxUEU3VGlPTFBUNkdMdml3MDh3YzBuaTVwRzQ1NGNp?=
 =?utf-8?B?RmNsSzV1NEJyYkV3ZzhiT0NGc1NPZlVqK1JRUVZZK05HR1NKQ05waUtXc0Vp?=
 =?utf-8?B?amhMR2NHZDN3N2lCbnZxUit4MXFtMlh2bFFnb01QNWNxRnhkbjZDZ1hYK2Np?=
 =?utf-8?B?VzZ6YUxkV1Y0dEM3UHJaVkdqRlRma3ZIZ3JvWHByditjbG5oYXEzWlF4anBs?=
 =?utf-8?B?T2tva0hrMGllRDlCWUFiN3lvODdOemV5YTRERlBYWldXbE52a0VDK0t1VFls?=
 =?utf-8?B?dFBtak5YUFMzN1lKcnZHcjB6UlVkeVozMXNwd2VLSWRkWTVub3FVaVlJalh4?=
 =?utf-8?B?cVlyQ040MkRHVFRnMnZ4RmVVSC9rNUEyOHlTN2lwM1JubmRFblp6cDZlVFox?=
 =?utf-8?B?eTNLQkJZREEwYUdER0hmZ1prZ3pUSDNnNHNUNjlaYmpKS2N3WHFOaVpsOC9C?=
 =?utf-8?B?S3B0NWxFMmRuZEk5cXlrU09md2RGMzJJd3lza2lPaVhmeHdqQlQrMmt4M3c0?=
 =?utf-8?B?NHcxMTE1M2k2QWduSkZNUmduWk9wcFFHR1JaQ3RmZFJiQjgwVWhXdWZEb05Z?=
 =?utf-8?B?bmVMeUNQYjdKQTlRODV5TXI4RUxDcCtIS2F4a0ZzRW15NkZnalJvMWFBMU03?=
 =?utf-8?B?NEtUei9ZY3lhL240OHljZkgyOGpLb2VaeDFzY3RJR2FhQXBtTjhmS2NYZGRV?=
 =?utf-8?B?WmJ3YjY0RUdsUmpnZlprM28vSVRuRHlHQ1VhTjBpY1RBaTd5Y0l3UFdyQjFO?=
 =?utf-8?B?VnlWKzNnYXh5MXhTRVcxZnUrSlZqYm0yL1dud1pLTzJHd3dCeEUrdG85U3NX?=
 =?utf-8?B?STVVcUtMMCs3UkhpQysvK2R3N2dwNFE4NEFMU0VJUHNXbE1CZ25sVCs4NEpx?=
 =?utf-8?B?VUF4b1BYRXBsb29SeDBKWnA1dVZmSCtUeW5xWFREcTNycVJkV3BNcHBQSHNn?=
 =?utf-8?B?WmYzbUU4S3NzcnFCU21ma0Z1TUV4bVZoS1kwU1grK1dTNGtxSTNld2RndkdF?=
 =?utf-8?B?bytkL1JYYTU5SGZuOENPSmRjWGhwZlZvOHl5d0dYUTBGK0hhUlBUaHNIb2VN?=
 =?utf-8?B?MVJVemFCdE1tTGpSK3Q5aGlVOXZiT2lreE5aczVWaVR1VG9uZ0RkK01sSlE0?=
 =?utf-8?B?MUY3WGl6ZTdpQzN0QzdJTzQ4elkzeSttRkdLWndjRk8relowdXJRK25CZjhl?=
 =?utf-8?B?azR6SnJ2VVRQTHdja2RjRG5FRlBtbWwrczd6cGlOVEU0VDZlOEJjSzFKZVVP?=
 =?utf-8?B?VlZoMkJXWnB0UEgvVXh5SmM5a1FKN1hJTnBwQk1CdUs5eGZ0Ynh0dHY1RXZr?=
 =?utf-8?B?TXJ6TDBaU1BaZkQ2eVpOR1Q5MGhweEFqOWs2aEpBb2wvdnhSUnFFYkN2eElQ?=
 =?utf-8?B?cFdqTEdJNVV1QnlPV3hUMUZTZ1pqaDd0Ui9Ka2QzTmNHK1FtMUlLK2lBd0kx?=
 =?utf-8?B?MEhtVkVPSW1Za2pVb0tIeld5Z1UzQ1Q0M1ZKd2RXWDB0LzNRN1hkU2EvaFhP?=
 =?utf-8?B?d0x2U3dZQlZnOHNIaDZIOFQ5WS9UeEZERE5QVncydC9zTmNudklyYVpmS1Ey?=
 =?utf-8?B?dUlCRUtDSzkvanhmdEp4MVAvQ1g2cWV2ZXRua3BsVlBxZm5RWm5HTkVucXBM?=
 =?utf-8?B?bEVpZ1RISHlWU3RJby85VWRSd1JydjB4Zm42bjJMY2NFZ25wZ2s1b2ExTUsw?=
 =?utf-8?B?ejFMRHpmQjRLc3F3M2ZKUFBocWQvZDhKc2tXbDEzZjFCcWZIOEpVRXptNjNi?=
 =?utf-8?B?NXNXWnZGNnM2ZXlLZUo1dnM3RDVKNDRyb1VzdGhQMnB0dEJ5M215d1BaUThE?=
 =?utf-8?B?MzFaVXo3aXk4RmFHMWc3QjdhV25lMUNKbXR6Q3dtcjg0MkJsU2hlaDR5TGNJ?=
 =?utf-8?Q?VQSDODxsm/Jme0BXUl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bb4c67-7e43-47b6-6d2e-08de7380bf3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:43:13.6990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCgiGIU65QFsIvczoArHi1zgDiWP4fPp4GPBsJGBgVlmoGHKxNT3sPPfq6c8TaXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

On 2/24/26 09:24, Sunil Khatri wrote:
> Huge input values in amdgpu_userq_signal_ioctl can lead to a OOM and
> could be exploited.
> 
> So check these input value against AMDGPU_USERQ_MAX_HANDLES
> which is big enough value for genuine use cases and could
> potentially avoid OOM.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

In the long term we should probably move those checks into the DRM helpers for those objects. But for now:

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 42b548c8a86e..4f9386677c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -35,6 +35,8 @@
>  static const struct dma_fence_ops amdgpu_userq_fence_ops;
>  static struct kmem_cache *amdgpu_userq_fence_slab;
>  
> +#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
> +
>  int amdgpu_userq_fence_slab_init(void)
>  {
>  	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
> @@ -478,6 +480,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	if (!amdgpu_userq_enabled(dev))
>  		return -ENOTSUPP;
>  
> +	if (args->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	    args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
>  	num_syncobj_handles = args->num_syncobj_handles;
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>  					    num_syncobj_handles, sizeof(u32));

