Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23192D0D7BA
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 15:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF01F10EB17;
	Fri, 11 Oct 2024 15:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IffQxolG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7C010EB17
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 15:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi27/xdvA/uhdrkkKMNd8cFdh+BGuAGaXB5yiun86lX89ZY/CizJVDEox6TYA3/SJ4Ho7Pmw/CZCW2AhEsHau/Z/4GZENCu5WiuSt/3M/yHr5cYoAFUdTQjOC5BEnEORU2PzJakHLTrVU27PXKkFKVt6Rz821Sg8g3TAZ0ssLwB0CDEGMLAA/frmy1rAnGEt3rSiE1pxgtg1Ct/ZipM/JrbNdJQS5XMYkNSQ/P3qFFKhVRNKZ1Tap5RBzIXO6S2fYNBsU3pFk8AP31xyrfqBr9QgPFXqhYrG42mN9ulhaV1WdlIafsXdJvxL43WlLqHmsJDejKcYo3wF/zgR3TwASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL92NLeyCcexRt+d9ASdMwQGrcNUEqX0wMYYwO1xK2c=;
 b=bF9IoH9IvMPfSFY31yaC1U8bKGSXGYWLzleVg5IAjtTZYPJxj3LKehd/wNZya2Bi7+hNgMG3k7Uf16ImRnwt8XpZcUUSoY9guNl6/nmwiAde5E/9bI/j44mmL2fYkM6o0Y1PJDtYwRR2Bdlou6zC4ANui/rs4LX4s6/gpDSrrTVwQw59htQv9+caJOl7lNC+/AjVQYdGgkT/KneXJ3fTW+2MtodgjyJ3OOzYUGMGYLSMfUOQooohr1iQniVfQYOetMTytIy5Hgg4NDw9hmYwCMiKSO6vTDbsx8sHEwxXMhQ4xc2mIsd+EGsH7HoyrLLy6LUtWs9Zain7nuNhILKlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL92NLeyCcexRt+d9ASdMwQGrcNUEqX0wMYYwO1xK2c=;
 b=IffQxolGgaEp2c4YLOyKb2UBM3haoCrthb8PxGrgvCl5dpxfb4Sxvvrg44tdpnVY/1vcX9ON8XGbE8C51QNabdCTeL6NjQK3hzc1mZ9uqdf79h9Oxo2SLJksNsJYDaJ01lldS0bIx83w/758095sTUT4VKqdfIIoYI5Rrlx4wbY=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 15:31:49 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:31:49 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Thread-Index: AQHbGy/zs3pjCNepAUKK2/i8Lu09lbKBqCyAgAACwICAAAPUgA==
Date: Fri, 11 Oct 2024 15:31:49 +0000
Message-ID: <SA1PR12MB8599AED6F3BA2803BFCF1535ED792@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-2-Yunxiang.Li@amd.com>
 <BL3PR12MB642501535A7BEEBBBB32C54DEE792@BL3PR12MB6425.namprd12.prod.outlook.com>
 <3d0053a5-efa2-497b-8316-8e0ec571bf2b@amd.com>
In-Reply-To: <3d0053a5-efa2-497b-8316-8e0ec571bf2b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=151fb38d-1548-4037-8fb9-69fdef7625bb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-11T15:30:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|SN7PR12MB7300:EE_
x-ms-office365-filtering-correlation-id: f8461b73-13ad-4bf4-9472-08dcea09d2cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NUx3OW1WWGxMZTIrYUEwcEIwa2ZzbXpPUU5HTXV6Ymt5YzVqOFRudnY4Zy9t?=
 =?utf-8?B?aE9YWXFvNmpzbVF2SkcrVHZEMGNVMnlCZW5sNENiQ29Ta2tPY2hmV1hWOGhP?=
 =?utf-8?B?eFVMSit3bFNpVE1CbURUKzlxYmZxS0xiWDE5dFZEVVJMZTdJZFRiSEZZei9G?=
 =?utf-8?B?SVh3RnpDWjRKVkdsbmhzc3F0Z3ZSVkVhSjNoM2wrbTM1Vm5UT01ySDVJc3Ju?=
 =?utf-8?B?VEhlYklSdC94MHhuMmJ4ejFmMTZEZjQvVHp1SXdCZ1NIeU9NVTBxOHFENVZB?=
 =?utf-8?B?cDBINVBtUmZvVEpFeW84dlhLRit1RkJzNVRqY2hBNVRmUXhYWi9EcFF2NkhB?=
 =?utf-8?B?MGlvZm9RbnpHYUpwbFIvSUQwR1I4ZWNXUG51TUdvM1I5ZlRJT2w4TVM3OEF4?=
 =?utf-8?B?M2IyMW8rTWhrMXduNGdUWitvTzhXMEc0Y1YyUVBCZ1hZRk1PckhoTjZKaldt?=
 =?utf-8?B?aGROQWxiZzJONlI1bGg1WndJemYyTXRBd0dFMEpiam00ZkUrbCtDOHRadnhD?=
 =?utf-8?B?RzJWNHpnSWRtZ0puTjkvU3RsNktEcjRxSVRxY2c5MTZWUmR3K0ZFUUR3M2V0?=
 =?utf-8?B?V0dBOXJ4N1ZxZnRETFBCWldTNlhkMHVtNkhXUk5NNXNtbjdSZTlFVk1zSy9O?=
 =?utf-8?B?akNNeTVpbzBjUVZTa3R0aVZZeEZWS1lOeVBjeE5ISkh6aU5OMHpWMG9qdHJS?=
 =?utf-8?B?UmlwakpYZlArUlJwbmhqT2QrYUZBKzZ2aGlwdHhsVHhWang5K0M5cmJhbTQw?=
 =?utf-8?B?VHVlYStHdG84TkVDWHlBVmdxcmYrQzhxa0ZrdUdFdW5YeXcyT0M1YkM4cHMz?=
 =?utf-8?B?em15OUJJUVZaVWNJVnkvb0RNaWo2UXFwNmZ1N2hIQmxTVm55WVhLR3JWZ00z?=
 =?utf-8?B?dnkzZHJVU2VnUEhkS2FWOTZXanU2N1E4cXc1eGh2bzVRbVFWcVM4NHREOHRM?=
 =?utf-8?B?ZGxxd2IvbUhoYTEyaHFzeTZrM2JYc3NSc0JTVWVlUnBaM2p2czBFME1qWENO?=
 =?utf-8?B?SmVia1oreWYrU1gwV2ZnYmwxbGM4WmRtSjIra3FlakU0dmJBM09Qa2VaMzlz?=
 =?utf-8?B?RjY5dEdGYXl4UStSRHdydUF6SXNFWHgwdENZbkxySVBTekM3alpldm1vbHFC?=
 =?utf-8?B?MlNkUXdUdkJiZUxEVm5tN1hLU0hMRVJqRzh0NW9paFBzSDMwMVJpOGRzNm5Z?=
 =?utf-8?B?eGdlMzhtYXVCTzQwWWxnNjY0MjM5d1B2ZFYzelc3VUVPNkJ1aXJLOFlCb1lk?=
 =?utf-8?B?bkZ5TW5OVlhqZ0htNzFFdUhtTFYxMVNDdFRoVUpPWEpKZTZPUlQzeVA3ejBz?=
 =?utf-8?B?QzFzY1VnZ3JYM0N4aUd3d3VEVGpBUGVhT2tsY0ZjNmxIUk4vS1E3dlNQUEhC?=
 =?utf-8?B?aUNad0R2VTdDWU1oT0IwMU9IeVpKTHg0S00zUDhoV0VjdE9jNUxjWnJpMVdP?=
 =?utf-8?B?UjFuaTl6ak1TMzdZVUdZYVVRcnFobkpHZXZiYWE4VWxZUU1xYjVwaHR2N0NT?=
 =?utf-8?B?bzhhbWxISUdhQVdnYTVMT2JTSVY5b1MxS0hpekhiTHQwTGpoMmlON214NkFH?=
 =?utf-8?B?WlBRMXNVMFM4UUpZcHRtaExVbFZFbFJzR3QwbGtvdE9xSG1WSGluVnp1WGlP?=
 =?utf-8?B?ZXNNV05GS2JzdUxNQ2tnc0pvSkZoVWMxWExZb0Y4Y3pCMi83SXNkQnppQzg1?=
 =?utf-8?B?WVc3ZzlnemxCMXA5VDEzOWpEeWJSMjJYRVJFSkpPL1hKSkZqOG4vWGdiOFND?=
 =?utf-8?B?dFk2b0xBcHJUTnNXQlFvR1lBVWtQanNEMmYwbU1FWGJ5VnRsVEF1Z2FnWHVr?=
 =?utf-8?B?dkJ6TXk5eTQ4QnBOaDFYdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZ0aTFVOTZQMmhnWm5OQkFXZWtBL2hWUXQzd1NzdkozUk5VOHZHWjE3SEZE?=
 =?utf-8?B?SWZ4MDNBOFhBcENQNUNEV2kwMXgxUEJSR2RaeXd0SkpPU1BNNTEzK2lZNWc4?=
 =?utf-8?B?czgxVzJha29hcVZHQzNGTkNqRk1xQTNvQmFlY1FhcWtVSmdvRDM5N3ZJdVlW?=
 =?utf-8?B?cSt3eUZsUHpWVXUyMlRpaGNyVDdGbEtrYmVzcThjU0thRDczSnM3VHVXdXNQ?=
 =?utf-8?B?NW9sc2pwYi8vSi95NDRDMWVwcTlwTVBUZGtRd2J6NXUzMDkyMTFxbFpZSjJ5?=
 =?utf-8?B?M3ZWQWFpMytPVXFNcC9TZm11Ylp4TXdVNGdIdUc4SUFVR0lacWUyZjBxQkQw?=
 =?utf-8?B?Y2xkcEJaRk5FTEtnUVJDOHUzNGV2WjZrbzVONlhWNERDL1IreG9adXRDajZM?=
 =?utf-8?B?b0o4VkF5bFI3RkJFQ1NVTFR2SCsxdXhMTEZKREVFMWZVa2FJTGxMMFYwT2lZ?=
 =?utf-8?B?Vk4xcmdOaXRXTHR0cldsRzJuZ0o0aWNKT095SUd1RFNVNGM5VSs2MVUwYTZv?=
 =?utf-8?B?SkZEcTRGL255cnE5SHFZTjVsaHZUUkdzQ3NpRUY4Z2pESlNnd1RjMERtZXFB?=
 =?utf-8?B?bU12Mzd5NXhiQnFLTDJVUnRlQVljNGhGaDY0UWg4OG1COEZDOUNuY2E5V2gw?=
 =?utf-8?B?b2h1YUo2R3ZrZ1NwTjVZV053a3VYVmVYbmhVaVpXMFk4OEN0cDViOVF2YWtD?=
 =?utf-8?B?ZHE5Y0ZISlE5RytjZXdnTzd3ZmdMRmFtbGM1amQySko4KzBxaUZwQ01uMlcr?=
 =?utf-8?B?c2tqZ2NibWphdXZyNlZjeTNIVm14OUUwOGFXck9IQkFRT1V2eE9nWTJOcHJq?=
 =?utf-8?B?ZmVjSXJwWW1CTU1ZRGVQUHc2Sk51RElRd2ZERGYybjVEZ05lMzZQQnZSMTZF?=
 =?utf-8?B?TGNBaTAyc1k5dC9sTnlWYWZZSXRocjh3TVpGbk5ldTBJUVhYRVNCRS9uRHpP?=
 =?utf-8?B?NTFVYXQwbkxmTjBxTDhNNHpUZlgwWW92Mjgwa1BKcWpUUXpsUHA3ZTRWMXEx?=
 =?utf-8?B?V1FNaXBQZStIZHdBeERsdnk2OHNFOFBkTCtVYkxLWDl5Nno3WUw3QVQ2ZWdz?=
 =?utf-8?B?bVRjNTVJNEFUeWNOVXNPNG03dGFEY0k5UGJvc0VoTEJHSjVXcWhWZ3RIaUE0?=
 =?utf-8?B?aGFaV2Nlak1KajhiSGJ5MGFkNEhyREMya1dPUUVoZXBoVlVWYXJYSFJEQk9B?=
 =?utf-8?B?QnFTbzMxLzR6Tm5nODB0OWdzV0ZldkM4QmtEcXNTTGxOcUl6QU9EdkZ2bFda?=
 =?utf-8?B?U0laV3RFeFRocnZKUnAzNUhjVUlOWmZEdG80eHA3SXFnMllZdjBlamUrV1hQ?=
 =?utf-8?B?alVYUWRNTC9BT0hoZ3l3RnZ6ZlZsUG9HQjI4UzBtNHArdFRVMEcxK0ZEOTN3?=
 =?utf-8?B?UUFGenZpTWpHeW5KY1VpVytSeDEzZnV4UWV3UE1tRU1IZGFiZEhnQVJXNXVK?=
 =?utf-8?B?SW5TV1VDZkFsUHlTbjlqT2t4WHVHd1ZFU0VoUnFTcXRORTlFd2F5Wi9pSHZG?=
 =?utf-8?B?NjlxdkhDN1k4TXZ5cjFiT1podW93a0k5QXFrZTNjcE9YS1M3MWo3YkFYMy82?=
 =?utf-8?B?NWVmSnRPamx1VG5ESHk4Z1VSdEFFNmRQbXppckJCcWIrNjBEUGtnVDMvUnpL?=
 =?utf-8?B?bDc5SmVDdGdlbTJqSzY5UlAvQjdBd0htOUV4d3U0bCtxQ3RYc2pVKzVMUmsy?=
 =?utf-8?B?amFlZm1XRlpod1VhQWJ1N3lKSXdidStRMGZzQllIYUgwbUkvakZFOFJnN2Nk?=
 =?utf-8?B?dXpDMG9sZU81WXM5SXd1ZVMySUpvK3R6UkIySnFPYTFtalFYdS9iZlR0dDNv?=
 =?utf-8?B?ekZPcWMyTVRzLzNOa2c5NUlReDFpbE9DZnlUdHcvZXVqbTFFUTg3K2tPbWZ6?=
 =?utf-8?B?R3dPemp0N3hVSy9EVzhDRzdlbjB5MEpGR3dRTE5Cc3JkdjJzVExKeXZxQlFt?=
 =?utf-8?B?WEdQbnFUc1FGcDlxWVpJRVBSVU13V2N2Z0Fzd2s3V0IvNEd6ci9yRExhK3JF?=
 =?utf-8?B?cE1HME1oczJOTit5MU42MjBTbWV6ZGRFaTRjbVZjM25ybkZIaEV6V09nSndR?=
 =?utf-8?B?c3JZOUNOZkwvUDJBR3d6R2k0L0VJdFF1OUFjQXZ0Z3phZ0hGTE5XVlgrd2l5?=
 =?utf-8?Q?rP/E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8461b73-13ad-4bf4-9472-08dcea09d2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 15:31:49.1572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhoGX3A52jMO559/vfGE8st4x2TMeEYKHhwywO8pXo14cddOeBG/i9eSp0fmM3HDl5Y4OUpobG3wosZcDfOzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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
Cg0KWWVzLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYXV0b3N1c3BlbmQgaGFwcGVucyBhZnRl
ciBhIHRpbWVvdXQsIHNvIGl0IHdvdWxkIG9ubHkgZ28gaW50byBzdXNwZW5kIGlmIHRoZSBwZGQg
aXMgbm90IHVzZWQgZm9yIGEgd2hpbGUgYWZ0ZXIgaXQncyBjcmVhdGVkLg0KDQpUZWRkeQ0K
