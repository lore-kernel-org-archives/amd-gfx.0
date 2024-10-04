Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBACDCF8843
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 14:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7043C10EA28;
	Fri,  4 Oct 2024 14:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVdbpcU1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D6610EA28
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 14:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElVgtcISUlIs3QPYpxeK9Ocby/UR1uMk00KJ9/27I90a9WX5bMfFfx6fJCBJKTiyyQIPzmTP50VG8bq2micM0hTTdsCnvajiAZYjsX1+H3qMT6m9IySimqphCWi2t8HpDX0CJDSa8ROI9YqXIXFQ4RZX18sO62jGDew3qf4cLagbV+82YMHR+ovPBBDaNjcxDLWhy0q8Xa6CKIY4zm2uMZ+edusqRll9ReqYyOY7iTMtK8A7smmg0Rwh1VGhipY6cnmt26w5DcJ3WHkiNRTLMEWnd/uUuHXsBpm/7ZqT8Bmu6LhiZjQ6tXeMP/RcWm6KsflFw9iTBiQVvHuEJGM65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiXYlohNU/akUsJdLiZAVWIUk4ZLm5rgSdNZE3zRAyk=;
 b=fdM7SCkpqqFliRDh5RdsnKJgyAwQH4z/9H0ydIq+88Nx08n439US8IN+Onpghe4ZaSFnDgydQH3YkRluq0O7y3f164+yFofPMjXujNQX8ZGymLsNmh7vQhlkMwp4ngh3BUWGpPtZEgwnniGnHASaNzc0U5RqAd+5hS58eZ4MmRmKIO4sdavKMYudeEanoU2xGj7vFPVTu2FSztJFl68txZLjjabAxo0ZXvUxF6QHoVcQzb85JadPky3EZ07F4cr+UuiL0qf9ecfFGVRz8P8IWoHMKwuB8LDwu3WEnTUizfzj/EahMxRVITo2jmZvEM86sr/meqkNA52vBVleQ5orlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiXYlohNU/akUsJdLiZAVWIUk4ZLm5rgSdNZE3zRAyk=;
 b=cVdbpcU1rpz8g0ZJ/gKRRiqraGFT5ez4aGRQjSUaE8O6H8PSxSbh18Ks710pvy1TZZhomLqwg39rWYpHkX/nFYEoo7KsOJeHyGB5RKfgQ9p2nMJTdsxO0/N5xTEG0btXRCPXsCrKoDOd+8s4Me8rXvG+s4BSwY73sv8Cd/YYHFM=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:39:33 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:39:33 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
Thread-Topic: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
Thread-Index: AQHbFdYaTvXUh/koQkSEiN/hcI2iR7J1hgMAgAAQowCAAQY+YIAADW9A
Date: Fri, 4 Oct 2024 14:39:33 +0000
Message-ID: <BL1PR12MB5898C4E23831524B7A8F132285722@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20241003205526.35748-1-xiaogang.chen@amd.com>
 <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
 <0e3ffe8d-da8d-4932-99f8-8241d17573f6@amd.com>
 <BL1PR12MB5898A00B1AAFFE27CEBB6FC685722@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5898A00B1AAFFE27CEBB6FC685722@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9b9c4b0d-1cad-423f-80ab-453a10fdee47;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-04T14:38:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|LV3PR12MB9167:EE_
x-ms-office365-filtering-correlation-id: 7e7cf5de-fbf6-462a-6deb-08dce4825cad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aEdyN1Y1VWxZcmdkZDQwNjlTY0NJckM1Y2Y0Tk9yMTd3NWJ1elgrcFNZaEVw?=
 =?utf-8?B?NFF5VGVTbjhiaDgwR1N2eXd2ZWNwRzlQZWdDWXJFTmhuSWkyY245RU0vSjNL?=
 =?utf-8?B?RitpTklHTzVHazJxd3NXSUpUclRHa0ZIa2M4T3JYMGY4YlZmQTZ4dUIrT1pO?=
 =?utf-8?B?WmtTN2tvcmVRaHIvWCtQMis5aTd4d1ltSVdMMFlkNGNhc3ByejJhalFSUkdi?=
 =?utf-8?B?ZjhJWU44cWgvak5HK3ZHRG1PczNnR2VmRUlHdk0xczNUY1NZcUtWUC8yOWR1?=
 =?utf-8?B?UGZHUVoxMFV5SkNZZnI5Z25UanFQV0hIOUJTbnRxZlVEcER2V1lwTUlvWFdq?=
 =?utf-8?B?LzBDNjBpK3ZaWVVSbVZQVEUxalVrMHp5K0Qva0JWaUZuMmpyTUJsMXM0Q3RD?=
 =?utf-8?B?UTNEa3lIVE1aUUtLMndUQ0xBeWJNZkhzZkZoOTExaWxaRTdqSzBjVytYSFg2?=
 =?utf-8?B?a0NwYmRDbHJVMWs4K2lIcGZkK2pWdW5LazV4aWtselVINmVtcHlOakY3cjZr?=
 =?utf-8?B?aDNjVTQwUmhQL3ZaSU1QY0I2T0NsZzd4SmtJb0xkYmtJZVgvcU9ETHgyZ0dY?=
 =?utf-8?B?YmNBTEtJQXpxSkwzYzhla21qbU1MVUJMSlhFTUJqa3I3bWNtVDJRMnFUMGgy?=
 =?utf-8?B?Q2RPMG5KMnEvdlVyLzZST1VqVTIxZ3BpKzVWQlc4N0crTjU2WDUwUUxrRHZB?=
 =?utf-8?B?MGJTbGxpU0MvM015L0JwSzlkK2NUMjRkREtpTEthVURzbXpEWWZ2QndrWlB4?=
 =?utf-8?B?SldQVUkyNU9ia1ZSOWpEajdkL3pYN2NBWmZUK21wUVVTVFA3L2NPbGdEUVYy?=
 =?utf-8?B?a0dnZzEyc1dCZlQrS0NMRnZwVjRiaEdmOFpRYS90MW5MOGFrQ1FzNGw1ZTJm?=
 =?utf-8?B?aURibERRbk9YeG5DWjA1bDYyd2ZnMEtpNFlic1NORlhUZ210KzMrQksyYmpD?=
 =?utf-8?B?KzIvL3R4bmhLQzZLdHczNTRzVDVYUDU4MWNCV0xpcXk3ZXZ3b2J5RXpyL2hD?=
 =?utf-8?B?UWZHRXdRVEJPaUN6MnVGRE5ZTjYyWkRUVEJPQXZ2OGZJNWphaGl4UWg2UFc0?=
 =?utf-8?B?ZlFmY0wwUzZLZGhIN2lUbmlzbnRlbXNwMEE1a0lCK0RQSW5DSENHRlpsN1k5?=
 =?utf-8?B?MjZzU1BmK0ZMUi9nUXI4cGRYcWRyNGJpMk1IaEJjeDBlb1NpWFdSQmlnNzFx?=
 =?utf-8?B?NUNBQkQzQlhuNmlGa3hhb0JHODJ0MCtVeDAwcExYSzdEWStXZmVpeE9QOXFD?=
 =?utf-8?B?SnJiZ2RuWlAwUGowZDdHUk51bVVFNFc1d20vSGRXaWlyaXNtWldmQ1dZUkI2?=
 =?utf-8?B?aENjNmNKZmhOSEVFbDRzR1lwNkpoYndURkxlUTFZUlRDK3dlT0IwaUVOcEph?=
 =?utf-8?B?c2VEM3FIa3JtL0xCN2YvK1BQUExlQWNFTEJLQzJROHh4NUx6NHF6b1pzNFVU?=
 =?utf-8?B?TUFzYkNFQitRV0JQakdZelIyRFNDcWc0c0wraVBpZW12QUtDQ25mZEhQRmZZ?=
 =?utf-8?B?eGlGSnRjREhZZ2NpUW1jQUk2eUtRK0xYYUxVMnZ0d2RZUE9hSVhJQ2JpMytS?=
 =?utf-8?B?L3RwWGdYMjM1a0l4dS9OTlhYMzhtdkp2YW1uUzFxU2g5enZLbnZUTm9KVzVL?=
 =?utf-8?B?M21zUHlVT2tkSzkzRnVzWFAzbjkzaEIyM0lMdDQ3UlBoR1FhSnBUUk5oOWVL?=
 =?utf-8?B?QVVIcmZPZGpWK25vQnZ3YXBKaWhBL1A5T2pOaDJHVzlsb2VOUlhxVWNLTlRa?=
 =?utf-8?B?aXNFdXZWQlFoRG82cVZDM3drWDY0Q25mL1g5c3dBVEFEYm1yZ01TaVIrYitI?=
 =?utf-8?B?V1NRVElDbjVVcGlja2VuZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0RIc1cxUGpOUFdvbVo0MmRGZElmQ1BPcklZYTE1T2U3bkd2UW5tQ2dlcTlP?=
 =?utf-8?B?SjNlZktMY1g5Yk1zY1ZhK041YmtVN0lmN3hJdTFUR2NGNGVpUCtLQ0VtZjRP?=
 =?utf-8?B?aTZMMEpJNW5uRmhEdFd2SGMxU3Vhdm04V0NwZG53alV0UTR0U2tWN3VRcFdH?=
 =?utf-8?B?VnR1c1NGRWZoalZscXgxTGhodGRsTFpLYVJ1WlFYS2pZbS80WDJKMFJNYlY0?=
 =?utf-8?B?RzZaNHFEblp5dmlhdEpmTXRicDRlb2s5ZUpzNEx4a3BneHVORE1uSzhpNmJh?=
 =?utf-8?B?M2lOYmMxNHRqbjYxczN3NXFlZ2gzeURUK3ZEakFCUlM5ZDN0dFNob3FjU0Q3?=
 =?utf-8?B?RTNOTjgwOS9EWFJxNHFXQ3YxYkdZQ0ZpeVRJRm9nTnpmK3F3d1U3ejFuL2Fw?=
 =?utf-8?B?Y3NEeEE5M0tEY2h2OTJVU1FYaDNMc3BvR1NlN1NQRzJUWWNRTHpVSDlrSWJN?=
 =?utf-8?B?QXY5MmhMQStYRU50U3hNQWtGaTJTMU9Ic3hkZGpITmJOMjlaYWRFWHdiTjB0?=
 =?utf-8?B?UDcydW9FL09EQlJvcVRjc1ZjZHJLYmFsMU00UUllS28xU3dVVHE1Vk4xN2l2?=
 =?utf-8?B?Q1B5Zmcramoyd1JIZlpGaWFjTDZJU29tdEtXbEdaTjBqUE84ZE9OcFE1Q0Jk?=
 =?utf-8?B?MnJvWjRvMkVIMktuMy8zelRDeGt5WExGK29FazdNY2p0MklxUyt4c3luS2JT?=
 =?utf-8?B?WHhRdDBCbmpwM1RWRW9PN2F3QS9MNTkxaEE1blY4TTZIc2lZd1BjazQ5OTVh?=
 =?utf-8?B?c1ZaVnlBOTRWYkkzM3Y2Q2VldFdmN3d1cHFrVGlTeUZuZ2J2ajJuUkxoVjd3?=
 =?utf-8?B?aERnR21ZSDVGK1ArV1h1cnJkN0h0SkxEVUNPa3A5MGJSaWx3MUVQcFB6SVJ4?=
 =?utf-8?B?azVveFFrYTF5dXdlc0Zqc2Y3TVg0RkZMdVFHVDgxaEJVbUp0LzRXV0hEQzFF?=
 =?utf-8?B?M2grTjd0bDBLOHhJUmtPOTJqVFJIUExFQkRkZHdmR3BmZkFRYXlwbldFRFd1?=
 =?utf-8?B?Rk1ScGlyVXo3M2lYK29rM05YNmRTSkFUdllIK2dyU2UwTzRtOE9JRFJINFEw?=
 =?utf-8?B?b0JLckZ5VUFvM2Q0TFhoeVVyeUlnTjQyREdEQkRBY2Q3QzR2alE4dkxFMGN0?=
 =?utf-8?B?bFZtTUZyS2hCaFltSjFiWmZSREEwNUZvRExFWFpNZ0wyWDBLQTRzRHdhZVlP?=
 =?utf-8?B?aGxXdTBVekZ0c3BwNmdVeEVSbnhTY0tyejN0S2gyYWRsMU9GZnk4enAzczF4?=
 =?utf-8?B?ZDc5VE5SMkFlSHNCYXNqQm4wd0xVb3hURDNlbXd0WkVRK0RYZzN1L0czdkV2?=
 =?utf-8?B?ODJadlYxZXlSSG83N0RGeGtRcXpyQXAzUzBJNWZ3YUFpYnlNa2ZQVWNjbEpM?=
 =?utf-8?B?L2pNSGFBdjlQeS9tSS9ySVVnUi9BYWtEaXNuRm5ZNGNpWk9pM1dCNEV5MFBs?=
 =?utf-8?B?QmdjSTc4TVRja3NaSC9DQkZ6aEUyZEMyM0xTVGNoeThqeWdyQmJjNll0L0N6?=
 =?utf-8?B?SlM3Z0J3MFh2eHJhNFZWL2h4ckYvc2p4YlpnQ3ovcXBVeU40SUVOOVpyTFI2?=
 =?utf-8?B?U1FVcWY1d0pWTFZ1TjFGMHZVRm5tcVBsRTQ1TjFWcytEczBhQm5BNi81RXF2?=
 =?utf-8?B?Y1hTdXRDTThkS2tQNE1CNmxNa09IQmlnV3dxdjZpK1doUTFhMU9hV1pXUGhH?=
 =?utf-8?B?MUpVUWxEaVM0V3V5clFIRDF3SnBhckg0eDVFdHRPUUNiNDI3Y3ZrT1QwRDc0?=
 =?utf-8?B?eVZDSUZUaTB4VFBBM05iOFZ4NnBTUXZkaC9zMmlyY1diancwSWN2QlF1VStS?=
 =?utf-8?B?WGtaMERHZitrSzZKRnhDQW5IU1NWa3VnQVVBY1FqWjh6T2tFNzFVYzFYZ0pQ?=
 =?utf-8?B?Umlia2wza2hVMDJOUmhwQk9ESitBQnpYQVNwSzVvNkI2cC9xTk15YkJZeWhJ?=
 =?utf-8?B?Yld5eVJ6RDJiRWVxY0YrdVB6cHRzRndaTjJWSFExR0J6bWRrMThOTndiTU5U?=
 =?utf-8?B?d0RmN21QZiticmt2VjJNY2FIZWJNbkZlWGsvN3VkbzcxZWphSEI2S1BuMmdi?=
 =?utf-8?B?UkNlaWdFVk5oS0VZeEFXZURjYWFZQWpiS1JHTW1nTmUzOWI2NFdPTVJjYjdQ?=
 =?utf-8?Q?m7NQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7cf5de-fbf6-462a-6deb-08dce4825cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 14:39:33.1370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVHUFUCmYos8Od8M8LRzDrhIFrAk3xO2e2HyzR7O/hJECbEx7HRLFs4qvQLlK5xGHahtLwRySl1Ay9aPeI+mqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

W1B1YmxpY10NCg0KTXkgbWlzdGFrZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgUnVzc2VsbCwNCj4gS2VudA0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNCwg
MjAyNCA5OjUzIEFNDQo+IFRvOiBDaGVuLCBYaWFvZ2FuZyA8WGlhb2dhbmcuQ2hlbkBhbWQuY29t
PjsgS3VlaGxpbmcsIEZlbGl4DQo+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1k
LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2Ml0gZHJtL2FtZGtmZDogbm90IHJlc3RvcmUg
dXNlcnB0ciBidWZmZXIgaWYga2ZkIHByb2Nlc3MgaGFzDQo+IGJlZW4gcmVtb3ZlZA0KPg0KPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
Pg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBP
bmx5XQ0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIENo
ZW4sDQo+ID4gWGlhb2dhbmcNCj4gPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzLCAyMDI0IDY6
MTEgUE0NCj4gPiBUbzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBDYzogWWFuZywgUGhpbGlwIDxQaGls
aXAuWWFuZ0BhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRrZmQ6
IG5vdCByZXN0b3JlIHVzZXJwdHIgYnVmZmVyIGlmIGtmZCBwcm9jZXNzIGhhcw0KPiA+IGJlZW4g
cmVtb3ZlZA0KPiA+DQo+ID4NCj4gPiBPbiAxMC8zLzIwMjQgNDoxMSBQTSwgRmVsaXggS3VlaGxp
bmcgd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gMjAyNC0xMC0wMyAxNjo1NSwgWGlhb2dhbmcuQ2hl
biB3cm90ZToNCj4gPiA+PiBGcm9tOiBYaWFvZ2FuZyBDaGVuIDx4aWFvZ2FuZy5jaGVuQGFtZC5j
b20+DQo+ID4gPj4NCj4gPiA+PiBXaGVuIGtmZCBwcm9jZXNzIGhhcyBiZWVuIHRlcm1pbmF0ZWQg
bm90IHJlc3RvcmUgdXNlcnB0ciBidWZmZXIgYWZ0ZXINCj4gPiA+PiBtbXUgbm90aWZpZXIgaW52
YWxpZGF0ZXMgYSByYW5nZS4NCj4gPiA+Pg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IFhpYW9nYW5n
IENoZW48WGlhb2dhbmcuQ2hlbkBhbWQuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMTIgKysrKysrKyst
LS0tDQo+ID4gPj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPj4gaW5kZXggY2U1Y2EzMDRkYmE5Li4x
ZGYwOTI2YjYzYjMgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPj4gQEAgLTI1MjQsMTEgKzI1MjQs
MTUgQEAgaW50IGFtZGdwdV9hbWRrZmRfZXZpY3RfdXNlcnB0cihzdHJ1Y3QNCj4gPiA+PiBtbXVf
aW50ZXJ2YWxfbm90aWZpZXIgKm1uaSwNCj4gPiA+PiAgICAgICAgICAgLyogRmlyc3QgZXZpY3Rp
b24sIHN0b3AgdGhlIHF1ZXVlcyAqLw0KPiA+ID4+ICAgICAgICAgICByID0ga2dkMmtmZF9xdWll
c2NlX21tKG1uaS0+bW0sDQo+ID4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIEtGRF9RVUVV
RV9FVklDVElPTl9UUklHR0VSX1VTRVJQVFIpOw0KPiA+ID4+IC0gICAgICAgIGlmIChyKQ0KPiA+
ID4+ICsNCj4gPiA+PiArICAgICAgICBpZiAociAmJiByICE9IC1FU1JDSCkNCj4gPiA+PiAgICAg
ICAgICAgICAgIHByX2VycigiRmFpbGVkIHRvIHF1aWVzY2UgS0ZEXG4iKTsNCj4gPiA+PiAtICAg
ICAgICBxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVtX2ZyZWV6YWJsZV93cSwNCj4gPiA+PiAtICAg
ICAgICAgICAgJnByb2Nlc3NfaW5mby0+cmVzdG9yZV91c2VycHRyX3dvcmssDQo+ID4gPj4gLSAg
ICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoQU1ER1BVX1VTRVJQVFJfUkVTVE9SRV9ERUxBWV9N
UykpOw0KPiA+ID4+ICsNCj4gPiA+PiArICAgICAgICBpZiAoIXIgfHwgciAhPSAtRVNSQ0gpIHsN
Cj4gPiA+DQo+ID4gPiBUaGlzIGNvbmRpdGlvbiBpcyBhbHdheXMgdHJ1ZS4NCj4gPiA+DQo+ID4g
c28gc3VyZSB3aHkgdGhpcyBjb25kaXRpb24gaXMgYWx3YXlzIHRydWU/ICBrZ2Qya2ZkX3F1aWVz
Y2VfbW0gY2FuDQo+ID4gcmV0dXJuIC1FU1JDSCB3aGVuIGl0IGNhbm5vdCBmaW5kIGtmZCBwcm9j
ZXNzIGNvcnJlc3BvbmRlbnQgdG8gbW5pLT5tbSwNCj4gPiB0aGVuIGFib3ZlIGNoZWNraW5nIHdp
bGwgYmUgZmFsc2UsIHRoZW4gd2lsbCBub3QgcXVldWUgcmVzdG9yZSB3b3JrIGl0ZW0NCj4gPiBp
bnRvIHN5c3RlbV9mcmVlemFibGVfd3EuDQo+DQo+IElmIHlvdSBleHBhbmQgdGhlIDIgY29uZGl0
aW9ucywgaXQgYmVjb21lcyAiaWYgKHIgIT0wIHx8IHIgIT0gLTMpIiwgd2hpY2ggd2lsbCBhbHdh
eXMgYmUNCj4gdHJ1ZSBmb3IgYW55IHZhbHVlIG9mIHIuDQo+DQpJIGdvdCB0aGlzIHdyb25nLiBT
byBpdCdzIGVpdGhlciByPT0wIG9yIHI9PS0zIChJIG5lZWQgc29tZSBjYWZmZWluZSkuIFRoZSBm
dW5jdGlvbiByZXR1cm5zIHRoaW5ncyBiYWNrIHVwIGZyb20gZXZpY3RfcXVldWVzLCBtcWRfZGVz
dHJveSwgYW5kIGNhbiBldmVudHVhbGx5IHJldHVybiBFSU8gb3IgRVRJTUUgaW4gdGhlIGhxZF9k
ZXN0cm95IGZ1bmN0aW9uLCBzbyByIGNhbiBpbmRlZWQgYmUgZGlmZmVyZW50IHZhbHVlcyB0aGFu
IDAvLTMuIFNvcnJ5IGZvciBteSBjb25mdXNpb24gaGVyZS4NCg0KIEtlbnQNCg0KPiAgS2VudA0K
Pg0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+DQo+ID4gWGlhb2dhbmcNCj4gPg0KPiA+ID4gUmVnYXJk
cywNCj4gPiA+ICAgRmVsaXgNCj4gPiA+DQo+ID4gPg0KPiA+ID4+ICsgcXVldWVfZGVsYXllZF93
b3JrKHN5c3RlbV9mcmVlemFibGVfd3EsDQo+ID4gPj4gKyAgICAgICAgICAgICAgICAmcHJvY2Vz
c19pbmZvLT5yZXN0b3JlX3VzZXJwdHJfd29yaywNCj4gPiA+PiArIG1zZWNzX3RvX2ppZmZpZXMo
QU1ER1BVX1VTRVJQVFJfUkVTVE9SRV9ERUxBWV9NUykpOw0KPiA+ID4+ICsgICAgICAgIH0NCj4g
PiA+PiAgICAgICB9DQo+ID4gPj4gICAgICAgbXV0ZXhfdW5sb2NrKCZwcm9jZXNzX2luZm8tPm5v
dGlmaWVyX2xvY2spOw0K
