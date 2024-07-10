Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0579BC38150
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 07:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A845F10E5C9;
	Wed, 10 Jul 2024 07:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zLasDFuq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F1310E5C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 07:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZY641XlWLk6Mj5t73Sgwg8CRls2BqGKIps1v4/le72ELvpEQBnOadhIXBZodbUzKokyUE2/yMr3pq9rIqVpfiX/ncc5fQYVYU41BFWtYTlwYxPJjytvpNaVodzAj+ZyXQUtRllLBgIIhjq8da6YSflC07wWwaqz+xSB5cq2lWC9k2OjY5KXVn06jGa3pnOt1Q77BJrK5XkSMAt1pETH+uvVLIH3v4AYG6BecVpfilGR68N6oFL0WnWeERcB1iz8JNCmAmf90Ch+DvxlLbf4fcK/S2eQEeh+1+NKdeo+ZFBQOlXBHOgbUPFlvmYpkpfyHL6PPRA1CM2ba1JLwvxZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+W8ISavpiyjLq9U18SxP0VkS92pXqnWrbRInqa0iZ8=;
 b=AU4WOOpLtitPl9T7gObofgufd5OwOOqXTQrl4hrEFtwpRS5UUXlhjETyOaRVmBQss1jcHFAFlrkUYGC+7oZGGVJHfgusDHdnkPDRPr6/f5ofpQ29t3BJxzbc2HL/6xSGUj51hrP5mEA2UEx9uf9rhymY3CtXMm21t0W+aIYf/8VnfRXTd5hztrhyNegbTE0e807WlsiOaSVZ2InlkyOxEzWhIxFOqvSb+1U9DG/mVejPLtT0Y4Y2Xa+U3OE6BLey9Zrz04sqUywUwK1Q6/oPLtVHVrBHCNMo9YwHADjjjWmzJh0T+zK+X1IA2UIqp2pp8WEO1C2y/75f45W/DlTFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+W8ISavpiyjLq9U18SxP0VkS92pXqnWrbRInqa0iZ8=;
 b=zLasDFuqDJoK0P/diYn33NDriHiF1XozeEOurf2aqGFRc/gJ2YwmF8GATe5hT3XNCzIUGbeWXHnEdtGvxyxjIz1lIo3xC0wVF9QAlYQrj2xuIhdQY5pQ7GVrYLvZT9rUZ39mjhabahVqPrAZOFUDLb19SOhts2R1hRE659XgGnY=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Wed, 10 Jul 2024 07:42:52 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 07:42:52 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Topic: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Index: AQHa0mCWFUQC/0nImUSF+KOPpXpAvrHvjZmAgAAE9jA=
Date: Wed, 10 Jul 2024 07:42:52 +0000
Message-ID: <DS7PR12MB6333621338DCEBED7EAF8F3CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
 <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
In-Reply-To: <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=799b085f-0ebe-4fd7-9d2e-5542bab6d9f6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-10T07:34:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|DS7PR12MB8204:EE_
x-ms-office365-filtering-correlation-id: a75b8932-7bd2-4d3e-1298-08dca0b3e759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RmVxMCtoK2JZR21Kak9wVVJHTU9scWU0eHBwOWRwYnRXTDZPMmR0YXVZaEJo?=
 =?utf-8?B?ay9BYTBwRlUxaVk5L1Q4T2l1M2VVMUpVbjJmK2xGbVFDZE93bE92TjdnUzNt?=
 =?utf-8?B?YklLTmxuYmRJUXZRS3kyK0x2TW8yOUVOS0wrQVJ1U3NJQUpOMnpuSWNCRXJS?=
 =?utf-8?B?YWFxZEc4ejQxb3JGWGlMNjdKWlZYTFZHYnRnR0kwa1pXYUNIekp2Q0JzV0ZD?=
 =?utf-8?B?Qy81RVh2UW1ZbG1xVFM1ZFpCYXoyZDMxdnBCQWlUUk9NMzNJZithUmJ0UWgw?=
 =?utf-8?B?OWVTR2dnYityWXgybk9ObnI0UnZjNjdpNUQyWkRyV2lSSVB4T3BZWFA5MVdQ?=
 =?utf-8?B?UHJONndMaVVuczQ1T3Q5Tm5kV3VKWG9wcEFTQ3NwRnRSMnBTWTcvVk9GdGcw?=
 =?utf-8?B?WlVYMU5IY3B3RmxNSjh4czNuV0F4NlpZSzJhQWJyeXg5QVJlUnNGM09XWGU0?=
 =?utf-8?B?c1JQdlNtTU05OEdPRVlPY1dPcmxKVWNSRnFGK2NhNU9KZ0UyZkVMQktyVDdu?=
 =?utf-8?B?TXAzRitTTnJtKzFWZkthL1d5UXFMbnhRNTNNQzBkVldVKzAzdzBTbExJN3Ni?=
 =?utf-8?B?WTFpNjQ1L25IdDh3NU93OHVWaHBQRysvU0xIRHF2NThTNjNZMVBPT0pibC9W?=
 =?utf-8?B?RnZCWE1oSExSMDdpOFByNldyOGZqTTYwTVp5RjlHZE96S0xsVVRWQkQ2RWdK?=
 =?utf-8?B?MDFkQ20vOTRUWlpHTTZqOTU0WG9nblI2eVN2ZHZiWDFlaDNBM2h2RUtVbGFY?=
 =?utf-8?B?L01SN2tSbkVyd1F1cy9CRGx1RFNtNlF6QktVUjVvVnh5QlVyT2MvTEpCUDJk?=
 =?utf-8?B?N2c2VkhSY0VuNzVnbEx5aTZzVVdVMG1BbFlFOVRBclhTRjFCdVVEN0FsOTA0?=
 =?utf-8?B?Y0s0NFBtbkVhVkcxcUlPQktETUk2djgwVW55Y0lHenZCaTg2cFE1UytYSS9a?=
 =?utf-8?B?TmNjM3pDUlNzQXhkK2U5V0R1ZXJTMWJxdFd3aEluZmhUSTQxL0M4WDh4TEJJ?=
 =?utf-8?B?LzUwa3NZRktXTkkyZDl6NFE5dG9NUkxjanVaNndTUGp2YmtWcHQ5bWRsa2pL?=
 =?utf-8?B?cU5lOTl1NmhNS2tjVndSN3VqNXFqeG1mWTdHZCt2NFAzTUJNaTBhejJ4c0s0?=
 =?utf-8?B?VzI4RXZocFJSQ2NnNk9jUmcwYVlNYWxzb2x1Wi9nQkFxQ0JoMVJiODYxY1pX?=
 =?utf-8?B?OG1nOHdYMVVRVW01Y1N1M0pWSzFkSnE4bkxMZlI1U3JOSDh0V3l0aUt0RGlp?=
 =?utf-8?B?RVFuZWplSVRPelRRZ0t0anpxZDU3N1FzN3RNQ09ENTNFcDV0NUVCa1cwY3VQ?=
 =?utf-8?B?S2xLeTMxRUNuSVRVSTdsQ3RoUTc5YXpSMmhrVjdFNGhMVVJEWXV4alRDM29O?=
 =?utf-8?B?ZFhvem9DTndZc1ZSbTljb29FS0MxaG9NcWpqOVVOSlJ1bjRsS2JQSGRnNGxi?=
 =?utf-8?B?b3JOR2tjdHRYQ3E1UGU5RmJFeXByUDh4eXRidFdQNTN4elgvN3N1czZFRlhE?=
 =?utf-8?B?SlNLS1BLcVQvTEg1WFpmQnFQNFpBcWxGMzgzVlBGNkdjbzZTUm5mQzFINzBw?=
 =?utf-8?B?MDBWOHJBL01XdFpQOElkbThxOUtEWGdLWjRSM1BIMXZ4azI0eWtqR05OZHJX?=
 =?utf-8?B?V2xtL1BLRVdpVlZWWVEzQnFabHdsbHNlNXliSUwzWm03UjIwRlRZSjdXN1kv?=
 =?utf-8?B?VjZ6bXhEY05zMUZjSDRrYkpoUDNqSXRpYWtQUGxLTklHZHVsYUxNQld1N3hE?=
 =?utf-8?B?eklVMUpuRjc2clFCcHErVStEMkl6ZVpoY25XK2pvNXFtYmpDUDRhSndubndn?=
 =?utf-8?B?dE1PNk9jblN4MzVHb2ZCTzdFT3ViWXZXT0t0OWZSQk5PaVViVDRxbmtCR2Qv?=
 =?utf-8?B?RlU2NFJia2ZSUFJQaXNEMDFRQzFHTThJanc5em9tWkZ1V3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU5QTWVqSWU0MkoraGFWWnprMndETWNYYkJpK3VTeTlBNlVCQ3JyRFJ3elZk?=
 =?utf-8?B?eEFwWkZRRnN5cEdCeXZxWEdWZEdHYjZQaCs0OHZMUVVpamJ1ditsZ1UvN00w?=
 =?utf-8?B?M2pLRHJ1U003ZE5qc3JNdld5TjJrdnFJaEdiNWRFWDJJVldBY3dPMkEveGMw?=
 =?utf-8?B?M1FaVlFqemxXOEFNZURlamdmZDBlOGptVW10SzN4STU5ajB1emdZbFdWTC9q?=
 =?utf-8?B?djYyTWZzaXJvSmhIU1huc04xN3JQdEE3KzV3Z0tOeE12eURvaXFSbU5MWk5D?=
 =?utf-8?B?Q2JKejNEbk1URm9FTkNMSGUwVW1WWVhhQ2IvNDVJa2hROWZHMGY1T0ljUWJk?=
 =?utf-8?B?akhQdklBUWVOanRKV1V1RGQxZWRFTmZpL0tkNW5HSFZkQnBxR3hMQkJvT09x?=
 =?utf-8?B?UWNYKy9RODhKOUNQaGZzU2ZURW9VNlhjUWxualRRZVhiRzM3VlJPb0dsYlBW?=
 =?utf-8?B?NS82S3U5T3hOYkN4RzR0S1lQbzlVajh6SERGeTN0VFFiNlQxMXJpZXBhRkZN?=
 =?utf-8?B?NklKVDd2anJRZkNDMjBZWlFpaDNNWUsxbkFPMzNHNTNid3dnRmVNRVo2Sno5?=
 =?utf-8?B?MVFSMnZRN0NXYlpmdy8vbDVqTzVscG80VGxPY0hsZjJGTEJXbzRiSlpiOWZm?=
 =?utf-8?B?NDR3Nnl2YmNqeWd4c1drdm1pcGRnQVFjaEdXNWVNNnpYb2ZsdktXODFSQmdJ?=
 =?utf-8?B?YTg5VHpXNEs4TS8reEphSlpIVk91d09LckZpa1JzYUthaGhndi94T2RJZzdF?=
 =?utf-8?B?TkU2TXNQMVExYzJxTktwYXM1OWZHQjJtN2Q4cHlFUVd4NHJ5Wm5ua29VY21N?=
 =?utf-8?B?cHRqaXQxbkdnYm1YYnc5TnhvU1cyc1JBNVdBSndBVTlnVUVBeHlQRW5CVkg5?=
 =?utf-8?B?dS9GaGsrMS84Zkd0NnR3dW5yUWtqZUVzY09OS21NQ2p4VGZsdlFKMU9XNmJB?=
 =?utf-8?B?bUlKQkdIem9MM2xJc1dyL1lPWWhzMmFQeDNSN09LS2VIcm1pcUVhckdPMHF4?=
 =?utf-8?B?Mm5MS2ZzOFhuTTdjU2lLU095SHVIZWdtRzlmejdRejlrR3gwWkprK2JwOGJF?=
 =?utf-8?B?d2pib2RROFFMK3N5dEFQeUVpN2ZlSnhkYzgwd0d1YUhDSE5QM3c2VXRJYjZE?=
 =?utf-8?B?VDlPUTlMbmo1UlpxNU4yOHhXcVVIYzlURFU0U2hVUU5sUjFIZ0o5UUtvaEVO?=
 =?utf-8?B?Z29KWklvaDRQbGtEVXZVY01adE1iWXVqYitWSG9WRzZVZk5WTjcyOWFUbDBU?=
 =?utf-8?B?b0hsZjhpVGJHblJSZ2kwcll4TjlDSi9DNEFJeDdaTUUrWTNqbExydGRtejBx?=
 =?utf-8?B?bzd0bDJPeENETFRzd0lhdjFob3B2SUh1TmRWMnpqOWNHbkVVSDdSbUcyMHM3?=
 =?utf-8?B?cllUSHNYN2Y2bGI0dDlzZWl4RWd5L1hPalV2QzNwdElNa0diNGxQeE9Hc2VL?=
 =?utf-8?B?VWlKUU8zU1hTZUFJR2c3K2d6cU5xaG0wOVloMTZIV1NMaGtYMXZBcS9VVE9H?=
 =?utf-8?B?cVpxUkJ5aWdQeGpWNmhhTHZlOGpxQTBjYXhhZCtTVUc2S3NDS1cwRFNhTEdH?=
 =?utf-8?B?TkhxK3dlZjZQV3RQa25oREgrUjVmeENCQXE1aGtuNUlrKzA4aVh4TW5TRXh5?=
 =?utf-8?B?UnpidU9DbGZhci9xaTNDTmlJeDErcTJkVmNUZzdQTER1R0JGbWVvWUx3SitB?=
 =?utf-8?B?MVdpQU1WWmJuNFV2eFJvUXc1aEwzMkc0a1ZjeUxjNFZiS01idFZaQjdVcjh0?=
 =?utf-8?B?SkI4T1ZoVk5YVkNTV0IzYjFHempDOTJ4eVpxYVlRWnVUZlM2N3k0VDZZVSsz?=
 =?utf-8?B?SVk5K1R6am5UOXE2Qk5SdlJmTm1jc3ZWUlVsbFFBcHVudEFYbDFLb1pxcTNh?=
 =?utf-8?B?cTRveUhWQ3JFRXI4eG52NzExUzh4RnRLTVNLdG5wcGlocFY5YnU1VVc3N3oy?=
 =?utf-8?B?eWJUTXkyT1d6RjAvSW5xd3ZNSnJhNnNLdDFSVlEzc1l3aWhGNmpoTHg4VDhH?=
 =?utf-8?B?eUpkcXZ5UnVrWjl3T3JkdGFIQnY5TVNEeDNTbjlqUHZFNWplZ0NRUUoyYkp3?=
 =?utf-8?B?U1JTcVY1M0Q1bUczTzFPR2lhOUxMN2dIREFCc01TR0NuQ0ZDak1qTnZFdmF3?=
 =?utf-8?Q?2Hn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75b8932-7bd2-4d3e-1298-08dca0b3e759
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 07:42:52.0281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hz3OjVvSFmz9Uab/2MwASpAAqo7jtQGAl8j411gZynGov6fECRXWzAjMzGiphXDT4OtmBf3NNk3qioKR2LGk1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmln
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDEwLCAyMDI0IDM6MTcgUE0NCj4gVG86IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGRybS9hbWRncHU6IHNldCBzdGFydCB0aW1lc3RhbXAgb2YgZmVuY2UgaW4gdGhlDQo+
IHJpZ2h0IHBsYWNlDQo+DQo+IEFtIDEwLjA3LjI0IHVtIDAyOjMxIHNjaHJpZWIgamlhZG9uZy56
aHVAYW1kLmNvbToNCj4gPiBGcm9tOiBKaWFkb25nIFpodSA8SmlhZG9uZy5aaHVAYW1kLmNvbT4N
Cj4gPg0KPiA+IFRoZSBqb2IncyBlbWJlZGRlZCBmZW5jZSBpcyBkbWFfZmVuY2Ugd2hpY2ggc2hh
bGwgbm90IGJlIGNvbnZlcnNlZCB0bw0KPiA+IGFtZGdwdV9mZW5jZS4NCj4NCj4gR29vZCBjYXRj
aC4NCj4NCj4gPiBUaGUgc3RhcnQgdGltZXN0YW1wIHNoYWxsIGJlIHNhdmVkIG9uIGpvYiBmb3Ig
aHdfZmVuY2UuDQo+DQo+IEJ1dCBOQUsgdG8gdGhhdCBhcHByb2FjaC4gV2h5IGRvIHdlIG5lZWQg
dGhlIHN0YXJ0IHRpbWUgaGVyZSBpbiB0aGUgZmlyc3QNCj4gcGxhY2U/DQo+DQo+IFJlZ2FyZHMs
DQo+IENocmlzdGlhbi4NCj4NCltaaHUsIEppYWRvbmcNCg==
