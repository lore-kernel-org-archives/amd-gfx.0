Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A49CCD19A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1886310E45B;
	Tue, 18 Nov 2025 09:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ozixTlsh";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724C010E45B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpBMVk1GMLkpQEfwIoUjRQPeSiPqCstdEuALjzo+gNScj4SSpyDeoYJ3IczzDeb6MJFZ9JpZEOxkub6bsR0JCaMjh7R1EAliV7c9C3Hn4ZOCuZJdyVe3YIJ2/pQ/GUOYdSa9K+lm2F0hhvFf7WZ1aAe/p2M4SXexBrSmsRiIbCCy2+9v5nhfBapH+EUEjFoqipI2QwX7hUWZMDX4gNMNcV0/shN/gxoLkfFByd1hnLYomw8TTu+PobkIzBQUV0TVmPrCCDCDBJDhvxmsRPZauNailTy5fR6lZ67Hg872TYliM2GNsKxnXvJkE9gGSsazK2yUbo6IKbAYsHnasUFUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJrROYuVkZysA1dRj3wVW/AsBONsqQod+YeqZenc9sQ=;
 b=V24p1OjbWPrSGlJD47H692J2J/RoMJvEG9EY2rSRYm12uYheO3iIt3lRaIxqsRKEsU0hwova8Krv1xuLXGZMadVHHFmcwjg4R4FH7mUde80qTNjsysoSoA5q7mTLTR5MbDoMuVkSMRK3WT1oeUst9cHqvfU7LsP9BmkTe6lg0VhksZXeWB3+e5MVkuTDmtJ1KXQH3aj3tig3BpAnKeyCkwXzEf6yjXcGQp0NfiyoxzFPwh/hl6EmQdLslRxZf/0ExO2bNOwQQyjWmK0TL1yGkWPpUHyJ8P1MiNLjKjopc06niDYCceDA6rnOybctbc0nQh4nXb77XhG0yd++cubfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJrROYuVkZysA1dRj3wVW/AsBONsqQod+YeqZenc9sQ=;
 b=ozixTlshdMo4OfWQmf/rCqxjO0nNbRW7f19x7Ku44PDYbDR9mG8w6E2G1XMah9teDVrjIoQrs/geSD61zpggpTena7PzqO11b0XzBgzR5HPZTNDfJnLlpHjPXH4oiGphhS+rz1Js8/wl7rnzDuJ946UhAiiYF9FBYAdifWViTSM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Tue, 18 Nov
 2025 09:06:56 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 09:06:56 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in
 PDE flags
Thread-Topic: [PATCH v2] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in
 PDE flags
Thread-Index: AQHcWGpCOqtCQzzHUEesWrHZXLM3crT4JIGA
Date: Tue, 18 Nov 2025 09:06:56 +0000
Message-ID: <DM4PR12MB51524D7A76A7C7E8009E0344E3D6A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
 <20251118090333.109361-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251118090333.109361-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T09:06:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB6008:EE_
x-ms-office365-filtering-correlation-id: dd490967-8d8b-4fbf-644a-08de2681d2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?dUJMZ0hpblB2bk5OVUdyWUFMVVgzSGI5dWVJcjZpNk1Zc0ZNdG1mSFF6Wno5?=
 =?utf-8?B?WVBST0tub21DRGFoKzI3SEtvTzgyeEJMS3F4cmgrNE9hSlNZYTc2alVrWmw4?=
 =?utf-8?B?V0JXTzFUQ2JYdGJiNTJUMUlNQ1FZRk84MkFtbmx1SXZhV0IrYyt1Ly8rMEx5?=
 =?utf-8?B?TWhuVkdkbDkzTDh5UEg3K2VnaXJTQmRPbmUyVjdhYnBwNms1dFp4Q2RsMG11?=
 =?utf-8?B?TUFTTWYyNmNkSGZDR1ZSTVlETkNkS2hzUDArVnhlY0tyWW1KNW5wa1VrL0Mw?=
 =?utf-8?B?ZFRnMjhKY00rN0pMY3VvUUViWmEzenZ4UGhxTDFaQWFWU2VKa0xJUUZmdHdB?=
 =?utf-8?B?bzRTSUdlT1VSOFBqcXhEV0REMERzaDIvTE9jYjVrcXFjTGw2MDdCM2F6cVNG?=
 =?utf-8?B?MTR2NUs5ZHhJaTBzT0E4ZklCTmVGT1Q1MGMyNVNzVzlNOUlkMEc3OHhBclVx?=
 =?utf-8?B?UjdCTmJ5R0RTOVRkNlJCRmpYT01oc0JPKzJTeXJ1QWp3RTduS0FKcUJ3bHpw?=
 =?utf-8?B?SHpJNWRUSW9VeUw3cEZ1YWZYaEduWjNHQ05TeUg1M3BtVGhZUU1wYjArYml2?=
 =?utf-8?B?S3lJN2VjUVBqMTZnd2JQMFJSV2E3NjY1NWNyVnpkUVY3a0Y2aDJqaERpUjhU?=
 =?utf-8?B?M0tuYnRiSVViL21TWjJmZlM1U0FwL3gvdFpHVnBGMGdIQU1Pa1RxS2I5M1N5?=
 =?utf-8?B?NGdvaUhMWXY2RkxaM1h0djdHT3NqYy9DVEY0SGRhWDlJMmFQeUhQdTVOVFNB?=
 =?utf-8?B?eVpQVVRINnJTeGR6UDFSd0FyTVJzd1hjeXkrOU96YUxSWHF5cnV4bVRsOW1I?=
 =?utf-8?B?TUNPWWRCeWozN1o0ZjVJYUwzQTRHNGxGdjNVcjU3L0RObnQ2Tklld2E3R3hP?=
 =?utf-8?B?bEU3d1FZMUROTUVmQmhWUlRRalo2SnBBMFo1Ui9rQlE4cllzekF1OGNOUk9R?=
 =?utf-8?B?ZXJaUmI0cjh6WTFoUlo5UXc4MlBFS3doS1M5SHZwUE9LSUpZRHRua2x6QmJt?=
 =?utf-8?B?NnhlckE0eDh4clR6Z1RGV2RQMTlCS1lINGZQK2dqV1BjY3k1MG11NG9nL3RT?=
 =?utf-8?B?WGpTLzJKMWFGZHhabUptc2RHbEVLRVFxNDNWMm5jWmRidnNLN0tMY0dTaEpt?=
 =?utf-8?B?UlVJeitVQ2lkZ2tnLzl1M0xhaGdNaTJ0azczRWM4ZTlEU1NZUUw1cy9FWXZZ?=
 =?utf-8?B?UUZWQWszUjhJaExkVmN5bFM5Tmd5b01qdzFyMUxjVEFNMGFaQS9rZU1QMEhl?=
 =?utf-8?B?L2lRMlBYYTByL1lMR1cxWUYyTkxCWWVIU2Nwc3BwRGdaRW1lS3ZGTTFuTUFL?=
 =?utf-8?B?VjdtOW9PSjZLbk11ckJNT0EyZm5OOVJMM0JIeEhEb0M3RFQ4amNzY1ovRE9u?=
 =?utf-8?B?NFV6STJSVmxvOENuTlN5UDQ2dVpTLzVjQUVTQTQraG9TcWdGT1EvODI1VWww?=
 =?utf-8?B?aGJhN2V5OTlrMGRpS3BnNVVzSEpzb2hRaGlVclAyTG1VT01jQUJsSmZnSzhS?=
 =?utf-8?B?Qko3SlJjZDhFbFpXNjNxd2lsY0tZdjJ6bDBrWDRuSU0rVkd5R1JDZndVNUNh?=
 =?utf-8?B?TzNLMksrOUhzc1hVUDBmMDNiVkR0Rys1R3g4YXFjUndvZ0hPZjBlcDlIcGhW?=
 =?utf-8?B?MlJsMWxWcStmVVZCelNKMnpTeWlCNVpwZzAvYmY0YnRhUUZWN0VNakxFTU1r?=
 =?utf-8?B?QWZHMkl2blVLWWJVZXMxQUd5UnNjRi8zVitZVW1iSGorQWg1UitJNS9KSUlB?=
 =?utf-8?B?U3hYVTRqNE0zY0M4UlJnWXd1UjRtRzlIUndtNmlLNG1aYUx2TVNGbE1JQ2Fs?=
 =?utf-8?B?VnV5Wno1cmVGTzR1VEZyVUhZd3owbmxXeTRqQ0UzUVdmVk4xelB1ODlhQWJY?=
 =?utf-8?B?a0E1Rm1hNi81VUhTZnFRV241Vkd4ejY3Ti8vUUlLdGNFR3JsdEhlVm1hSVNC?=
 =?utf-8?B?U2NWU2VIY2k2SnN1NWFOT1dGMGhRMmpWdDBuN3ZQcDhmSWhBanpZY3grOUVG?=
 =?utf-8?B?WW4wTDFKYm40bTE1aDhkUlhNQ0xpNi9CcyszdktKQXB5N2RGZG9qNHBkTEcr?=
 =?utf-8?Q?Cw3v1J?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJTSGlJVlp0UGg1c3MrSVBSek1NSktCVk9xQ04wVWt2YVRxUUZSUit4UUwx?=
 =?utf-8?B?ZGMxbzJJd2JpNHJ2SHhTczRzUTlqWEdPYVNSM3NKTnkrZ1ZCMDc3d0kzMXFU?=
 =?utf-8?B?SVBsa0cwSzBXVGRHb2wvSkdmeU5rUjVyckhST2FaaytUakM4NDFwZ0NTRElF?=
 =?utf-8?B?NGtEc1drMXpxZzMydkk0YUtXQzBERVhCa0V6Umd2dkRreVpadXM5eklZMSty?=
 =?utf-8?B?eWRIQWhWdHdvNzJ1aERjTTBNYi9SY0NTcjB4dVJhbUVvdnJEajJETUYwMS9k?=
 =?utf-8?B?UXoybFVxWnVUUWtqVU04ZnpWRGFFWGlETTJLYXlHdnBKZng0V0twcDEvb0xj?=
 =?utf-8?B?eTA5eDlVRXJQek5UL1NZd0wzczNhUjgybkRyd2ZTai9XeTYvWUhaNTJkL0k0?=
 =?utf-8?B?RU1oYnB2ME9NMytXWFVqMXVRRkJyeDV6QWxtZElNSlNMMnZvbmtXN3lOQitV?=
 =?utf-8?B?MEkxakZZNU5LQUVnWkgvZVhsaWN2bTNkWWVPVHVVMTlNYnNWa1dZQVd2enVi?=
 =?utf-8?B?dHR0RTRwbmt1a1NTRGd3UnVmcHhQUFB2TGRVUE1SSUV0anhmYWd4akZZK2Nw?=
 =?utf-8?B?YXgyZm03dGhUOXJVY091S3kwZkRsYm4rSTlyUGd0aUVDUHprMEtuem9vcmY1?=
 =?utf-8?B?VklKdlEwangxWXBLeG16QXNIOGoxOEhuTC9XODRPcUFGdXNGaXhRTkpjZHc3?=
 =?utf-8?B?NWNiRkpFbkxIL2FpbmZ3bURXbHA0cTVNNkVqVmQ0OWgzcDljQml1YmR2cW5X?=
 =?utf-8?B?dkJTZnIxMHFTbEVWdmo3Nld2KzNsZm1TL1UyNE5UNFZiOFgwQi9ZbU1iVzlI?=
 =?utf-8?B?TE1nSTBBb0QwNElVMVF1WHF0U05mKzM4TG5zdFhnY3JFa3ZqRXpQcms2eUpE?=
 =?utf-8?B?VjBQL0RUWjVKaWY3NXpWS2w1aXo0SVVpdHBzNjc0ZVFhY3JGN2lxZmc5UnV3?=
 =?utf-8?B?a1Y1VDhDR293VFNDTEJic0FGZmkrd1J3S2h2MU9UNk8zbXhuNzZudzlncFpF?=
 =?utf-8?B?TWtYSVVEbHBsL0pDd2VjUHdPS3VLMzhjRWJMM1NtTEFCdGR0TzJZMnpaUDEr?=
 =?utf-8?B?WjkwOEQyOXArWStYdGhZbVRyV2hnQnI3SHhCb0QwdVN1VGpBUmNxa2szajdC?=
 =?utf-8?B?TmdQZ0pDUXM5N1BodklGd1VRdGFta2J4dSsxTk9jUHZzWWZUaHhWbU5CL2tl?=
 =?utf-8?B?YkVBMkMxcUdrclQ1UEFhb3c4enF2YTVWdU41K1dFT0srUWdscy8xa3NpRjRM?=
 =?utf-8?B?MDB2T2Q2aXE1M0dJRGtCZy9TdW1CVk9jRWFtbC9LVUlRTDBDL2JLMnhsblVZ?=
 =?utf-8?B?cUpTM2pkTEhxS0hLY2d2ZllFMzRBUmYzRENtc2M0cXdja1BNNStTbUFGN2JP?=
 =?utf-8?B?NWFOSitVSU16RG1EYThSQW16NXB6Kzl0NzFUQ1pscVVlWEY4cXVxUXBmWE51?=
 =?utf-8?B?T25semsvQ2pXeklid1pnRWJ0SWM2WDBDODg0NmVyQmJCT2dVcWNHaXlmRFFa?=
 =?utf-8?B?cmN1UXp1M3JNdEduTjhxeDFCVjFocEVUR0pKU1VhMG50dUU1V0w3RUxhNi9k?=
 =?utf-8?B?dml0c0ZrZHYwUWVwdlpVUFJlbCtuczRZK2FreWZhWC8xNFp2UCtwbmFGdW9p?=
 =?utf-8?B?STRsTElyNENwQTBMdEliYlpDQW5xamNVQTZhMldhaTZzVHBuV2ZoWWh5RUpE?=
 =?utf-8?B?V0cyMmZoR0NjalJrZWRSMWMwRm1nOTMwWWpYQ3JuYjhFaUsrdWkyYjFWSzFa?=
 =?utf-8?B?ZlJrd21ncHEwc21vNFlqeUNRSVhac3RVaTFNSkdNT3BDTWd4MWpLa1FoRFpG?=
 =?utf-8?B?N2xGSXM4Y3ZRanVUdGtwdkxDaDNuTTI1Z1kxZXlQYk5TY2hZTk9OMUZpWi8x?=
 =?utf-8?B?SFhZOXdtaDA1Rzd0Z1dmNUwzRG1nQnBFTWdTT1hJRktmbFFnZGRXUEtLZEg0?=
 =?utf-8?B?b2loOWtUcExZdUJkVVNzVUthVGM0V0R6Y0NUSGMvR3UzN3Y3Z3FJMmRNaVNV?=
 =?utf-8?B?RDVNWTdwSm4wdFFuUEtnOWRqZ095bFdjVTl2a2djZnM1Q3FSTHNkT3dhRHVw?=
 =?utf-8?B?ZzVDRDdqcURIVWJxNmZZODluV3pReldOOTZDMkRzaFEzNTRSdmZxTjB3VFhL?=
 =?utf-8?Q?xZMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd490967-8d8b-4fbf-644a-08de2681d2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:06:56.0918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5IWCjXIW63eIK9YGb9rlfERxfo6oM2rqtwyRVw/VTegH45Hzs43cngdIj6/KoI7IP2JPLtz2ydLB6L975w1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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
Cg0KdGhpcyBwYXRjaCBpcyBnb29kIGZvciBtZSwgYW5kIFJldmlld2VkLWJ5ICJKZXNzZS56aGFu
Z0BhbWQuY29tIg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNIQU5N
VUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgTm92ZW1iZXIgMTgsIDIwMjUgNTowNCBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5j
b20+OyBaaGFuZywgSmVzc2UoSmllKQ0KPiA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVj
dDogW1BBVENIIHYyXSBkcm0vYW1kZ3B1L3R0bTogRml4IGNyYXNoIHdoZW4gaGFuZGxpbmcgTU1J
T19SRU1BUCBpbg0KPiBQREUgZmxhZ3MNCj4NCj4gVGhlIE1NSU9fUkVNQVAgQk8gaXMgYSBzcGVj
aWFsIDRLIElPIHBhZ2UgdGhhdCBkb2VzIG5vdCBoYXZlIGEgdHRtX3R0IGJlaGluZA0KPiBpdC4g
SG93ZXZlciwgYW1kZ3B1X3R0bV90dF9wZGVfZmxhZ3MoKSB3YXMgdHJlYXRpbmcgaXQgbGlrZSBu
b3JtYWwNCj4gVFQvZG9vcmJlbGwvcHJlZW1wdCBtZW1vcnkgYW5kIHVuY29uZGl0aW9uYWxseSBh
Y2Nlc3NlZA0KPiB0dG0tPmNhY2hpbmcuIEZvciB0aGUgTU1JT19SRU1BUCBCTywgdHRtIGlzIE5V
TEwsIHNvIHRoaXMgbGVhZHMgdG8gYQ0KPiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hlbiBj
b21wdXRpbmcgUERFIGZsYWdzLg0KPg0KPiBGaXggdGhpcyBieSBjaGVja2luZyB0aGF0IHR0bSBp
cyBub24tTlVMTCBiZWZvcmUgcmVhZGluZyB0dG0tPmNhY2hpbmcuDQo+IFRoaXMgcHJldmVudHMg
dGhlIGNyYXNoIGZvciBNTUlPX1JFTUFQIGFuZCBhbHNvIG1ha2VzIHRoZSBjb2RlIG1vcmUNCj4g
ZGVmZW5zaXZlIGlmIG90aGVyIEJPcyBldmVyIGNvbWUgdGhyb3VnaCB3aXRob3V0IGEgdHRtX3R0
Lg0KPg0KPiBGaXhlczogZDcxNmIzYTJkZjFiICgiZHJtL2FtZGdwdTogSW1wbGVtZW50IFRUTSBo
YW5kbGluZyBmb3IgTU1JT19SRU1BUA0KPiBwbGFjZW1lbnQiKQ0KPiBTdWdnZXN0ZWQtYnk6IEpl
c3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBT
aGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gaW5kZXggODRmOWQ1YTU3ZDAzLi4wNGE3OWVmMDVm
OTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gQEAg
LTEzMjgsNyArMTMyOCw3IEBAIHVpbnQ2NF90IGFtZGdwdV90dG1fdHRfcGRlX2ZsYWdzKHN0cnVj
dCB0dG1fdHQgKnR0bSwNCj4gc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtKQ0KPiAgICAgICAgICAg
ICAgICAgICBtZW0tPm1lbV90eXBlID09IEFNREdQVV9QTF9NTUlPX1JFTUFQKSkgew0KPiAgICAg
ICAgICAgICAgIGZsYWdzIHw9IEFNREdQVV9QVEVfU1lTVEVNOw0KPg0KPiAtICAgICAgICAgICAg
IGlmICh0dG0tPmNhY2hpbmcgPT0gdHRtX2NhY2hlZCkNCj4gKyAgICAgICAgICAgICBpZiAodHRt
ICYmIHR0bS0+Y2FjaGluZyA9PSB0dG1fY2FjaGVkKQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
ZmxhZ3MgfD0gQU1ER1BVX1BURV9TTk9PUEVEOw0KPiAgICAgICB9DQo+DQo+IC0tDQo+IDIuMzQu
MQ0KDQo=
