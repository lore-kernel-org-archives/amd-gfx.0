Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E589C30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 15:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B093110E247;
	Tue,  2 Jul 2024 15:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nskJ8Zjc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E725310E247
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 15:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3rLVSc2u3Do3dTBDFxp3pgMmaQ8VKfacI8u3tVy/CeX8E6sqw7xZf9bW28KxK+hW52NPTGW6xsMm3uoveADwiVO2bF41d8mTKvUvpqBKlY/fFlitEB5vA3jq6OgyDXHhCmwt0/UwSXiX/28SCZ5SqXfcZrG/t8Q6zPnBVbRHK6Cq2eask5hSPleQvWpTMFG2zb1r8oicO2QWbSyLq/5DA6Rz8LsL2ly8Pgf5+c2MHHtxWIyYJkKKnK+8LhSE3EKOMjrijraUNHAOTORH4hFsvU5i0ILY/lxyr3KhAYv67BioqvORsd7mOrzJAOO4vTc23YX6yEL9AiQ1IVnGPVRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/XVmnUUFJfqwnLQuvhXqyd8MJDBG2IebLuwQlj053w=;
 b=ehj0kzPaNofWDCPoZjyePqsySWpXbRkqt09U5Xl/gS8BTP1oFHPoEe6ovbXnyc0IFJte/GAizHnjGn9QYgWssQ1u3Pne1dAfnT6O9lsP21cMc8aijPd2h0AzP7/itBMZPONIqdPIyIp5nCVh0Igqeq00+ZKTYh5ygSdf2PT59EuEnIDQI68VwrgPCZIkGfX8SBmsaUz/sZ3LYbFgWgNhPOLUhBxU80tmCope4+yayvbtbRjRQENxu8PWmp/5jN0iSEhY8UmSCh/p7g79RHR/E1b5O7BbJBKAPwL5PVq5oLKsltoEIZOO3CPsS61DGrWMaKiQhmo8RpP0JI4BsxwcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/XVmnUUFJfqwnLQuvhXqyd8MJDBG2IebLuwQlj053w=;
 b=nskJ8ZjchkReGHY1huyXaIHfGvFcy1xhwrsLsPQEMDDbAvm1NCtgUfS9PSjyPQ+3baGIsJ799DE3POZEaGT9P9ERvobGZJawAQUZbp3ALrBShzirk9YJTxS9VJ+xGnlNY6lXTB4ef+m7/4uGFAPun1hoE1imvorHgLjcrrdtlHs=
Received: from BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Tue, 2 Jul
 2024 15:00:28 +0000
Received: from BL1PR12MB5192.namprd12.prod.outlook.com
 ([fe80::1827:386f:7b23:dca3]) by BL1PR12MB5192.namprd12.prod.outlook.com
 ([fe80::1827:386f:7b23:dca3%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 15:00:28 +0000
From: "Liu, Wenjing" <Wenjing.Liu@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add checks to prevent buffer overflow in
 mod_hdcp_dump_binary_message
Thread-Topic: [PATCH] drm/amd/display: Add checks to prevent buffer overflow
 in mod_hdcp_dump_binary_message
Thread-Index: AQHazHUXhw2QN2AhVUWBhj6dGIohIrHjgUFA
Date: Tue, 2 Jul 2024 15:00:28 +0000
Message-ID: <BL1PR12MB5192AEE58AE7BF054165E77EF5DC2@BL1PR12MB5192.namprd12.prod.outlook.com>
References: <20240702114314.1341221-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240702114314.1341221-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=044559ac-81b0-45cf-bb89-683f741dfbe2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-02T14:35:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5192:EE_|MW6PR12MB8915:EE_
x-ms-office365-filtering-correlation-id: cbd7aa7a-6fad-495b-e722-08dc9aa7b636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ajNMenlKUUhoT3BVMTJoSkh3U3NuSGFOOTFzZ2J0WDJyVTJqRGthOTRpeExk?=
 =?utf-8?B?SmNtcXo4UDlURFVoOVAya2ltYjFITGZOZStPQ0ROQUswMU01dFRMYXFFTGd2?=
 =?utf-8?B?UFYySERhd1Z0VEpvZytYWU40QlR0b2x5RmY2cFdCR0Z1eGg5UVZiSEJBUy9L?=
 =?utf-8?B?aGh4YWk1MUpOSTFTcUgvbFZaWnBQbkVNNWJLK2FGd05PVnJwTXVwNEkzR3Zx?=
 =?utf-8?B?TlJVS00zMEphTkg1dHJCaElUZWxpM2MzVG9GU29DZEp4ZnN2aGxKelF1TVJE?=
 =?utf-8?B?WHR4NXdURTRvblBrVXZLS3c5bHpYVmxQa1oyMDkxRlgrdmVoQUc4T1hwUlVW?=
 =?utf-8?B?a2lLTmZoTk5haGVEcmlYbWltYVUyKy8vb0ZMdUhRQlgxK0hUeVpvdi9lRzgr?=
 =?utf-8?B?NWp2a3FSNGx0OEVPeVQ1T1o3RHViaGxmYmx0RWF6MTlLYVZjVkd5bDdCZFd5?=
 =?utf-8?B?b1lqOGpab2NTUGtUQjZoaDkvMVFFN0NHU2N5aERIR0l4dmwwY3hrVVlTczJJ?=
 =?utf-8?B?NlYrWFo4OXJ0NE9MMStjTkk4M1o5bGtBZ0VHYnFOZmdWcDNvUmo1YWFwM1lI?=
 =?utf-8?B?VHIrWjlBNVhtMWlWWFVtaVFsZnRkSHlQcHJJeWZTeXN2MkRFanBpVFcxNDBi?=
 =?utf-8?B?VkdHa2Y1a05PZGlkWmFXQ2tSMitVcTRGQTBuQnkrL2RKWjRMNEpRaVJoWlZJ?=
 =?utf-8?B?VEN5TC90YU80QnFSbFB3dlBhQkhSbUMyMkUzK3pKSG9RNjM1ZDZjQzFHR2J6?=
 =?utf-8?B?cDM2UjNzMjZtQ1IxbEJCV0N1Y1lYYmVLWEdUb3ZFK20wTldUaE1IQW1IRCsz?=
 =?utf-8?B?aEFSS1ljZ1FGcW1nUkR1SFRRZXRzTW94OGVJSngxaUVqVjlsdkRaNGFrVU5H?=
 =?utf-8?B?aEV6M1oyTlMwRXlVV05ZQ3BralpqSkhjc3ZlN0Y4QzlFRThGblc3QnU5ZUM4?=
 =?utf-8?B?dTFNN2twcUw4NkNuRjRQNWh1U21pWW9PellTQUc1MUpOcTE4eUVVS3lKWXc5?=
 =?utf-8?B?ektqNTBQZ24wR25WakRweUVXY290R0RQd1VacFhXOEJSdlVPTjZPRDVHRVF6?=
 =?utf-8?B?SEJ5ZnFLeVluQ0lNUy9qcjZWQStEQmkweXRWbUdUbFlrZ2M0L3BjUnRBSXBT?=
 =?utf-8?B?UDgvYWppdHc4ZHZLU21KVnZQZlFESFJkSFB5S3c5dUJNVTQ1c0UwdWt0elJs?=
 =?utf-8?B?SXk1R2J3b2hFeTlxYi9hTFRqU0MrWDZGN0w1eFlFeExrSzNEbFBheEVFV0Zo?=
 =?utf-8?B?WG1wbVNURy9PUVJHV2hGSk1UamV3LzJFQUgvQ2ZGdC9SQmJJcEV2bWtVbjFR?=
 =?utf-8?B?REY5WlVQdUwvdWUyeEVyM3M3U3pRQmZFcFNpZld3OUl1SDE4eC9YRVhETWE5?=
 =?utf-8?B?a1UzMmNFdklYdktKYTZGN1NlamtMdi84Tm1pbi9jZVR0a2xNSStzNDVTRmpN?=
 =?utf-8?B?MEZGK0hzTnAyVlY4K0JUS3ExN0FtQ1VrUnUwYW9RSEFIUjd0WHdTVDZIRXVW?=
 =?utf-8?B?ZXBvZnBXS01RYjZ2RndOYllWOUVnYUNEcXBrNXZZZWVZeFdYWjNreUEzN2Zw?=
 =?utf-8?B?MzJ3blEzcDJhb3VuZWVUejBndU9IaU4vZzdGSWVMOW92SGsraGtlUVR3a0dZ?=
 =?utf-8?B?bVNTcUtFR2dOR25XWVlmMEdScTBFeGRQREFxbHR0YlVCOU9Ra0JrWExwMGdC?=
 =?utf-8?B?SnZOUXVFbGZKNzZLR2NhSlVFYWxvdVRnL1dUbFliN1JqUUtBVFhGUHZ3NHdr?=
 =?utf-8?B?UytZdDYvUWc4dm1VN2tPd3hacjlrVzV1dGZ6NVdGTlZUS0EwUk5uaFVvWlZM?=
 =?utf-8?B?TlhqNmw5cStyWUhhaTdjL3VLTVU5Qjc5WmM5WUwxOXlzRkxZV1MweUREZVdB?=
 =?utf-8?B?V0J6WTBwbzRjdEdHUjJJWDVZVndNd2dPUTFZRnlXZmx0Smc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkpmdm1CSDJFTW40RFp3ZkJ4OWFlSi8vQjZPYVg0YmNPci9ROXN1aGJHdGZZ?=
 =?utf-8?B?eVVYMXdMT3YwVkF2Rm93U3c0dmg4SGs4RWV1ZG94MlUvRnIyc1RJRkU2Q2Jt?=
 =?utf-8?B?OWU5Ukd3bS8xOVZJdWNWKy9nVXhOb3pEL0MwaHJyc2ZFajd2eDhqSWcwSFBl?=
 =?utf-8?B?OGdaSlhKRWh3TlVRbm1ReHFZUFVmb0ZlOVcvMW0xc2VCNjJGNE1HU3AzRUF4?=
 =?utf-8?B?WitiaXhzMHFSR1RqZGNqTGN5ME9YcGI1cDJZa1RVYk04T1dhY2J3MklDbm8r?=
 =?utf-8?B?Wmd4emV5d2dmd2hoeXBMaU41Rm11RXpyRFlZVVFhU0NVYWtTZkZkWXdISjJ4?=
 =?utf-8?B?NDQvRzQ0L3ZuTjBiTWw1MWVZenNYSE4zcjlJdFZWNWNPZGk5bGVOTEprZER3?=
 =?utf-8?B?Y0V2SWVJMUtNZ2ZPSHFlWE5TZTNYemRVUnBMb0g0SGhHSkEwUXJSZVJYUUdX?=
 =?utf-8?B?bjFpZmErUnFzUHlBUkllYWFGVkoyVy8wOFVpbUlzbFFPUkM0N0wyWVVWcXFW?=
 =?utf-8?B?WXdZdXgzU3VrSHNvR3JhbnNNOFdvcms0aUxweVR6Mm9BZEFKNTJERE4rc0g2?=
 =?utf-8?B?aTBiV0xZR0hyM2czQ2ZYai9CY1hmNDU3Y0VWaEVQWXZmYStiWUJEL1ZUTzh6?=
 =?utf-8?B?ZnpFb3BQUlRoM1NveG9LbnlnM1YzVkhQYzlZc0lDbVExNXViV0pQbTVQSmFT?=
 =?utf-8?B?eHo3WkI1ZS9KRU13RFRMcVBPZWxqMlV2NzEyYkFxaXFyajA5dkpVaUFWWk9R?=
 =?utf-8?B?ekJrdnhQa1RSOHVQeXoyRXNrazNpUGRhYkh1cENXYWY4TTArYUR1WnZCQWhu?=
 =?utf-8?B?eTFxZ3RVdTVkUW9nUVdQRExycjY1Qi91aVNiZWVlOGpuVUphMEVLSW1MOXM3?=
 =?utf-8?B?cmVlMDl3SGE4WXp5eXlzREs0MFAvZldENUdFNS9IZXYxbzFjYndCTlFCcnBa?=
 =?utf-8?B?bjNuejNKZTFGT2dGektFK0J5RWJQd3FIVU5zazZmMmJtck01Q0xrY2N5bGky?=
 =?utf-8?B?RGh0ZlorVVQvdVhXUGhKc082bkhaVndMc0cwRDloZWkxYVJlUFMyTW5aNnRs?=
 =?utf-8?B?RnViYUlPZjF1bjgrK3BQdlRYVmZITnlqVGFTZVBMQ25YYXYyQmVqZTc3aWx5?=
 =?utf-8?B?VXIrSTA2akNaVDdSdWVHRmRIeEtjQ0NKMkt0Rzk4VTFyWVdFcWp3bVdXaVB0?=
 =?utf-8?B?eTR4OWpVWk5mRDJ0eWZMQXAzKy9rM01XVzJPMUoyb2lXakV5azcrWnhSYnFJ?=
 =?utf-8?B?cjhYRG41S0NoVUYyRllGVlRnY0MwNXYzbjJnd2Y2STUxMXlGWkpOZmZzdkpG?=
 =?utf-8?B?VTdLeGlxc2l3alVSQTc5Qk9venlualZrM1I0MUlDMDNWSk5SZmkzc21SM2lE?=
 =?utf-8?B?dEhIUndsV01jYzBYdFNDWU1rblUvV3RtTHI3alFoRVFyUGI3dmg2NmhNSnk2?=
 =?utf-8?B?MlU5U3kwckluN1R1SVZ6V050c0gyZktCZVM3K09maklVT1NrelY5QVg0Kzk4?=
 =?utf-8?B?S2wrRjZuT0RHT2xTN2Rlb1J3VnlaYXFXcHIvT2pjZXR2N1F3ZFBjOTNLVHRT?=
 =?utf-8?B?MXlOV2xnQlkrQlNGTmVjU0NyUDh0Zlh0aTd2TTdiUjRDbXdoMGpKbzQyVDJj?=
 =?utf-8?B?eW9PL1kxZ1JhQ1ZZWTZORHBIYStxSjRESUlYU0xMT3hseE9HOHd3UVc1dEEv?=
 =?utf-8?B?RHhDcE0xYzlJVVV1RUhXVDA4eEVPaVMyOHJxc3BWeFh5b09mMVNVRExGZGx1?=
 =?utf-8?B?WkZLNytXejFpNE1rcmpnZ1ZNNXhxTDQ0RnlyMmt5WDg3YXhEWTFtWFBjeERx?=
 =?utf-8?B?Q2creDQzRmVCNlp3WVFOV1kyNWRKbWxCVk5EbWVrSlZneXFoSTZlRWcxTWJF?=
 =?utf-8?B?MGVzS3VYdFRFNkdHbGZicUtuY25tb0hiYzRYZlZVclY1TWtaL0lVVWo0OStP?=
 =?utf-8?B?dGdQV1l4MEtKaHlZRFo2WDY2UnM1SFdHMmwzZWVsNnBXeFZCbW1Ea01pU1hS?=
 =?utf-8?B?emNsbS9GQ0UzL2VmMU1TRURhOFBaNFZQaFpxZzhla2dNM0t4bGphZ0hnbTBa?=
 =?utf-8?B?QUNWUTFlQklFUHpTMGpycjRXNlpFd214SGwyZktuZC94RlRiTGZMQTE0OVZ6?=
 =?utf-8?Q?wdfs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7aa7a-6fad-495b-e722-08dc9aa7b636
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 15:00:28.6603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0S1SKYvH2RaHh+nv7dra41wqvWwfIlVOXrl3SpGqfLL3qzEtXidGkHxl8GAxEUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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
Cg0KSGkgU3Jpbml2YXNhbiwNCg0KVGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgKGJ1Zl9zaXplID49
IHRhcmdldF9zaXplKSBjaGVjayBzaG91bGQgc2hvcnQgY2lyY3VpdCBhbGwgY2FzZXMgb2YgKGJ1
Zl9wb3MgPj0gYnVmX3NpemUpLCBzbyBhZGRpbmcgKGJ1Zl9wb3MgPCBidWZfc2l6ZSkgaW5zaWRl
IHRoZSBpZiBzdGF0ZW1lbnQgaXMgcmVkdW5kYW50Lg0KSG93ZXZlciwgaXQgc2VlbXMgbGlrZSB0
aGUgY29tcGlsZXIgYmVsaWV2ZXMgdGhhdCB0aGVyZSBhcmUgc3RpbGwgY2FzZXMgd2hlcmUgKGJ1
Zl9wb3MgPj0gYnVmX3NpemUpIGNhbiBoYXBwZW4uIFRoaXMgc2VlbXMgdG8gcG9pbnQgb3V0IGFu
IGluY29ycmVjdCB0YXJnZXRfc2l6ZSBjYWxjdWxhdGlvbi4NCklmIHRoaXMgaXMgdGhlIGNhc2Us
IGNhbiB5b3UgcmV2aWV3IHRhcmdldF9zaXplIGZvcm11bGEgY2FuIHByb3ZpZGUgeW91ciBhc3Nl
c3NtZW50IHRoZSByZWFzb24gdGhhdCBjb21waWxlciBlbWl0cyB0aGlzIGVycm9yPw0KDQpUaGFu
a3MsDQpXZW5qaW5nDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNIQU5N
VUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NClNlbnQ6IFR1
ZXNkYXksIEp1bHkgMiwgMjAyNCA3OjQzIEFNDQpUbzogU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJp
Z28uU2lxdWVpcmFAYW1kLmNvbT47IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8uUGlsbGFp
QGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwg
U1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IExpdSwgV2VuamluZyA8
V2VuamluZy5MaXVAYW1kLmNvbT47IENodW5nLCBDaGlhSHN1YW4gKFRvbSkgPENoaWFIc3Vhbi5D
aHVuZ0BhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBhbWQuY29tPjsgV3UsIEhlcnNlbiA8
aGVyc2VueHMud3VAYW1kLmNvbT47IEh1bmcsIEFsZXggPEFsZXguSHVuZ0BhbWQuY29tPjsgV2Vu
dGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kL2Rpc3BsYXk6IEFkZCBjaGVja3MgdG8gcHJldmVudCBidWZmZXIgb3ZlcmZsb3cgaW4g
bW9kX2hkY3BfZHVtcF9iaW5hcnlfbWVzc2FnZQ0KDQpUaGlzIGNvbW1pdCBhZGRyZXNzZXMgYSBi
dWZmZXIgb3ZlcmZsb3cgaXNzdWUgaW4gdGhlIG1vZF9oZGNwX2R1bXBfYmluYXJ5X21lc3NhZ2Ug
ZnVuY3Rpb24gaW4gdGhlIGRpc3BsYXkvaGRjcCBtb2R1bGUNCg0KVGhlIGlzc3VlIGFyaXNlcyB3
aGVuIHRoZSAnYnVmJyBwb2ludGVyIGlzIE5VTEwgb3IgdGhlICdidWZfcG9zJyBpbmRleCBleGNl
ZWRzIHRoZSAnYnVmX3NpemUnLCBhbmQgaXMgcGFzc2VkIHRvIHRoZSBzcHJpbnRmIGZ1bmN0aW9u
LCB3aGljaCBhdHRlbXB0cyB0byB3cml0ZSB0byBhbiBpbnZhbGlkIG1lbW9yeSBsb2NhdGlvbi4g
VGhpcyBpcyBsZWFkaW5nIHRvIHVuZGVmaW5lZCBiZWhhdmlvcg0KDQpUbyByZXNvbHZlIHRoaXMs
IGNoZWNrcyBhcmUgYWRkZWQgdG8gZW5zdXJlIHRoYXQgJ2J1ZicgaXMgbm90IE5VTEwgYW5kICdi
dWZfcG9zJyBpcyB3aXRoaW4gdGhlIGJvdW5kcyBvZiAnYnVmX3NpemUnIGJlZm9yZSBpdCBpcyBw
YXNzZWQgdG8gdGhlIHNwcmludGYgZnVuY3Rpb24uIFRoaXMgY2hhbmdlIHByZXZlbnRzIHRoZSBi
dWZmZXIgb3ZlcmZsb3cuDQoNCkZpeGVzIHRoZSBiZWxvdzoNCkluIGZ1bmN0aW9uIOKAmG1vZF9o
ZGNwX2R1bXBfYmluYXJ5X21lc3NhZ2XigJksDQogICAgaW5saW5lZCBmcm9tIOKAmG1vZF9oZGNw
X2R1bXBfYmluYXJ5X21lc3NhZ2XigJkgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYzoyOTo2LA0KICAgIGlubGluZWQgZnJvbSDi
gJhtb2RfaGRjcF9sb2dfZGRjX3RyYWNl4oCZIGF0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfbG9nLmM6MTA3OjM6DQpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5jOjQ3OjI1OiB3
YXJuaW5nOiBudWxsIGRlc3RpbmF0aW9uIHBvaW50ZXIgWy1XZm9ybWF0LW92ZXJmbG93PV0NCiAg
IDQ3IHwgICAgICAgICAgICAgICAgICAgICAgICAgc3ByaW50ZigmYnVmW2J1Zl9wb3NdLCAiJTAy
WCAiLCBtc2dbaV0pOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZ1bmN0aW9uIOKAmG1vZF9oZGNwX2R1
bXBfYmluYXJ5X21lc3NhZ2XigJksDQogICAgaW5saW5lZCBmcm9tIOKAmG1vZF9oZGNwX2R1bXBf
YmluYXJ5X21lc3NhZ2XigJkgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYzoyOTo2LA0KICAgIGlubGluZWQgZnJvbSDigJhtb2Rf
aGRjcF9sb2dfZGRjX3RyYWNl4oCZIGF0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfbG9nLmM6MTIyOjM6DQpkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5jOjQ3OjI1OiB3YXJuaW5n
OiBudWxsIGRlc3RpbmF0aW9uIHBvaW50ZXIgWy1XZm9ybWF0LW92ZXJmbG93PV0NCiAgIDQ3IHwg
ICAgICAgICAgICAgICAgICAgICAgICAgc3ByaW50ZigmYnVmW2J1Zl9wb3NdLCAiJTAyWCAiLCBt
c2dbaV0pOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZ1bmN0aW9uIOKAmG1vZF9oZGNwX2R1bXBfYmlu
YXJ5X21lc3NhZ2XigJksDQogICAgaW5saW5lZCBmcm9tIOKAmG1vZF9oZGNwX2R1bXBfYmluYXJ5
X21lc3NhZ2XigJkgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9tb2R1
bGVzL2hkY3AvaGRjcF9sb2cuYzoyOTo2LA0KICAgIGlubGluZWQgZnJvbSDigJhtb2RfaGRjcF9s
b2dfZGRjX3RyYWNl4oCZIGF0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkv
bW9kdWxlcy9oZGNwL2hkY3BfbG9nLmM6NjE6MzoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfbG9nLmM6NDc6MjU6IHdhcm5pbmc6IG51bGwg
ZGVzdGluYXRpb24gcG9pbnRlciBbLVdmb3JtYXQtb3ZlcmZsb3c9XQ0KICAgNDcgfCAgICAgICAg
ICAgICAgICAgICAgICAgICBzcHJpbnRmKCZidWZbYnVmX3Bvc10sICIlMDJYICIsIG1zZ1tpXSk7
DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KSW4gZnVuY3Rpb24g4oCYbW9kX2hkY3BfZHVtcF9iaW5hcnlfbWVz
c2FnZeKAmSwNCiAgICBpbmxpbmVkIGZyb20g4oCYbW9kX2hkY3BfZHVtcF9iaW5hcnlfbWVzc2Fn
ZeKAmSBhdCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvaGRj
cC9oZGNwX2xvZy5jOjI5OjYsDQogICAgaW5saW5lZCBmcm9tIOKAmG1vZF9oZGNwX2xvZ19kZGNf
dHJhY2XigJkgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9tb2R1bGVz
L2hkY3AvaGRjcF9sb2cuYzo3MDozOg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYzo0NzoyNTogd2FybmluZzogbnVsbCBkZXN0aW5h
dGlvbiBwb2ludGVyIFstV2Zvcm1hdC1vdmVyZmxvdz1dDQogICA0NyB8ICAgICAgICAgICAgICAg
ICAgICAgICAgIHNwcmludGYoJmJ1ZltidWZfcG9zXSwgIiUwMlggIiwgbXNnW2ldKTsNCiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQpJbiBmdW5jdGlvbiDigJhtb2RfaGRjcF9kdW1wX2JpbmFyeV9tZXNzYWdl4oCZ
LA0KICAgIGlubGluZWQgZnJvbSDigJhtb2RfaGRjcF9kdW1wX2JpbmFyeV9tZXNzYWdl4oCZIGF0
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3Bf
bG9nLmM6Mjk6NiwNCiAgICBpbmxpbmVkIGZyb20g4oCYbW9kX2hkY3BfbG9nX2RkY190cmFjZeKA
mSBhdCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9o
ZGNwX2xvZy5jOjczOjM6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L21v
ZHVsZXMvaGRjcC9oZGNwX2xvZy5jOjQ3OjI1OiB3YXJuaW5nOiBudWxsIGRlc3RpbmF0aW9uIHBv
aW50ZXIgWy1XZm9ybWF0LW92ZXJmbG93PV0NCiAgIDQ3IHwgICAgICAgICAgICAgICAgICAgICAg
ICAgc3ByaW50ZigmYnVmW2J1Zl9wb3NdLCAiJTAyWCAiLCBtc2dbaV0pOw0KICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCkluIGZ1bmN0aW9uIOKAmG1vZF9oZGNwX2R1bXBfYmluYXJ5X21lc3NhZ2XigJksDQogICAg
aW5saW5lZCBmcm9tIOKAmG1vZF9oZGNwX2R1bXBfYmluYXJ5X21lc3NhZ2XigJkgYXQgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYzoy
OTo2LA0KICAgIGlubGluZWQgZnJvbSDigJhtb2RfaGRjcF9sb2dfZGRjX3RyYWNl4oCZIGF0IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfbG9n
LmM6NzA6MzoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvbW9kdWxlcy9o
ZGNwL2hkY3BfbG9nLmM6NDc6MjU6IHdhcm5pbmc6IG51bGwgZGVzdGluYXRpb24gcG9pbnRlciBb
LVdmb3JtYXQtb3ZlcmZsb3c9XQ0KICAgNDcgfCAgICAgICAgICAgICAgICAgICAgICAgICBzcHJp
bnRmKCZidWZbYnVmX3Bvc10sICIlMDJYICIsIG1zZ1tpXSk7DQogICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpD
YzogV2VuamluZyBMaXUgPHdlbmppbmcubGl1QGFtZC5jb20+DQpDYzogVG9tIENodW5nIDxjaGlh
aHN1YW4uY2h1bmdAYW1kLmNvbT4NCkNjOiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVl
aXJhQGFtZC5jb20+DQpDYzogUm9tYW4gTGkgPHJvbWFuLmxpQGFtZC5jb20+DQpDYzogSGVyc2Vu
IFd1IDxoZXJzZW54cy53dUBhbWQuY29tPg0KQ2M6IEFsZXggSHVuZyA8YWxleC5odW5nQGFtZC5j
b20+DQpDYzogQXVyYWJpbmRvIFBpbGxhaSA8YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPg0KQ2M6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTog
U3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQotLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfbG9nLmMgfCA0
ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9o
ZGNwX2xvZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNw
X2xvZy5jDQppbmRleCA2YjNiNWY2MTA5MDcuLjI4NTI1MTcxMWEyZCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5jDQpAQCAt
NDAsOSArNDAsOSBAQCB2b2lkIG1vZF9oZGNwX2R1bXBfYmluYXJ5X21lc3NhZ2UodWludDhfdCAq
bXNnLCB1aW50MzJfdCBtc2dfc2l6ZSwNCiAgICAgICAgdWludDMyX3QgYnVmX3BvcyA9IDA7DQog
ICAgICAgIHVpbnQzMl90IGkgPSAwOw0KDQotICAgICAgIGlmIChidWZfc2l6ZSA+PSB0YXJnZXRf
c2l6ZSkgew0KKyAgICAgICBpZiAoYnVmX3NpemUgPj0gdGFyZ2V0X3NpemUgJiYgYnVmKSB7DQog
ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG1zZ19zaXplOyBpKyspIHsNCi0gICAgICAg
ICAgICAgICAgICAgICAgIGlmIChpICUgYnl0ZXNfcGVyX2xpbmUgPT0gMCkNCisgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChpICUgYnl0ZXNfcGVyX2xpbmUgPT0gMCAmJiBidWZfcG9zIDwgYnVm
X3NpemUpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1ZltidWZfcG9zKytdID0g
J1xuJzsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNwcmludGYoJmJ1ZltidWZfcG9zXSwgIiUw
MlggIiwgbXNnW2ldKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGJ1Zl9wb3MgKz0gYnl0ZV9z
aXplOw0KLS0NCjIuMzQuMQ0KDQo=
