Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD08C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 11:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589B110E1F2;
	Wed,  3 Jul 2024 11:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3vNXCm1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6F310E1F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 11:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGlhy/cV6nHG6eocKkxiFSzuhN+CZzMvndelhAmElDm858GKAGjZ/wArWf/SYZVLeujfNExiA9HiKNMte5OF5FgZDooNVznehU7CsudLUZebJkkgbMwAQHDEJWGTopzPuR2zUhPPu33ZdpONPGdvZUnZJGIPlVIcWqegCPnsfZFpCdzFJ8x4v33gCDPZS2IhzYCr2b9Qv2gnZHa13iI2ibr7Zs2cE9YawOds1VHa0ZLizkBVF1MfAXJcrDrbsRsnqk39Zl0EtNzTkapMQDyMwLRGKf2zqfs9VpL245qGbBTwRuiZf67W8BXBI+eO49w1ov6CW8QFiof4/UfNVSmbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4aYxUdYd0zH07+MOWUXnryTMTanZlzED2CQloe8FuE=;
 b=Ls7LCU4Ehcec1pNJCRyZY3IvIJurYGHgQpnDjWS/8KJYg5OaquU4sY0UbDEUBTy8N1yv8hda5k6e4jWtgYFI3yyQMf5b0R4gQl/BnEm/tBzwE8AOqUv3Zh0Voh0SOMUwpxsSspB704MA03RZS7ca8cXp0ixY105aNTSLzf/+Z3Wntud5FCVz5JIuVbKgpCBauiRvV58INntkiua/44yaKkvXDrGQ7zWbEq6I0vMkquzUcuW0WYOBaIcVX7Kbq6ptQgmnHCRiUBwLk6b0WOT5KOUsYg2GCl37mpiONvNl6zLKYcBZFzdGgbrQIfo7yGSpYjVlfSUslXXpQo3/ViT0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4aYxUdYd0zH07+MOWUXnryTMTanZlzED2CQloe8FuE=;
 b=B3vNXCm1Fm3GIp72swg5c4nXgPjdJkgyw7HeyiEcZ+6b+wbeCLf6wNBQymUsiDbGzMWamJzu3avUBObYR8ZWkvX/pSbgfaLw67lBJWwkAG7y+ndl+HvDVCvKcvUaOrNi7NsYD4jBpOFXYuJ78Li3SR+ZccMyMgSNMhTEAF7Gk4c=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 3 Jul
 2024 11:06:29 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 11:06:28 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: : Fix the null pointer dereference for
 amdgpu_device_switch_gang
Thread-Topic: [PATCH] drm/amdgpu: : Fix the null pointer dereference for
 amdgpu_device_switch_gang
Thread-Index: AQHazSekvUX8UVYyCE2FfewGbfHIf7Hku52AgAAbJwA=
Date: Wed, 3 Jul 2024 11:06:28 +0000
Message-ID: <CO6PR12MB53947BEC03CA815372F6E37994DD2@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240703090144.11241-1-bob.zhou@amd.com>
 <918275d8-788a-421e-b791-3d9537dbcead@amd.com>
In-Reply-To: <918275d8-788a-421e-b791-3d9537dbcead@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0d3cb7e2-0e42-47f2-9ada-7b3169aed25b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-03T11:02:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: 62e001e5-7e33-47b8-a02e-08dc9b50300e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0VFcWZJYVV0QVpUQXlRWmRzMDVPMCtYUUJ5TWdOdUhOQW5MOE0wWW5WSVZZ?=
 =?utf-8?B?bEM3MVZPNnZ1TDN2b2lNb0FJazIvVGN0aE5qTS9BZUhkdk52TjRScUFEN2hN?=
 =?utf-8?B?TUpnRkFJcDVMZzVtb0pOQ1k4d1hEN3l2ZFZFUlRtOVZYNm0vVHdXT1Q2U21q?=
 =?utf-8?B?UDNIL2lNZmgxd0NrRXIrRXFEb1JhNkpna0F6dTBMeWpSbzI1eXM0NlErSmsz?=
 =?utf-8?B?WGtTV24wckwxakk3Q3Q0eXBTbXJIdlBKZkNMSWNmOUJKQkFYN2YzR1RHbGt6?=
 =?utf-8?B?cm5KNUY2bkk5ZFZBbGpWMUpxaGJZbUdMNk5VWmR1MlhmOWQ0TDhsa1hzOXVX?=
 =?utf-8?B?QzJ5eldTcFBNWStkWmhNYllaYWtoM1VMUDM3bUozY0o1eldsamQwVmExTHI2?=
 =?utf-8?B?NEJ1QWk0SmJRd2c5RHorOHF0aU03bU5jZzgwcWhaUUozTHl5TjNUNmFpREhC?=
 =?utf-8?B?MCtnSmdCWEhZTWdZSXc0b3BhaE1NZHFQdnJpaDZ2cEJwZTh0emEzdVlGdm1Q?=
 =?utf-8?B?MytqMVQ2ZnpoSncrekU3S01WQUR6bWpxS3hlb2phUVdFUVI0Sy9DVDVZNk9R?=
 =?utf-8?B?T1kyMVRQM1ZLaVU4Y0sybE9rdlBRQUhGZEtBRml1NGpjYXlSUmFOWmd0MHNa?=
 =?utf-8?B?WWt2Q2RJSlVUdlVPR0RRQmNwdmJiT0RjUGpodFpZK1NkdHBYcUdXV0lhVFVK?=
 =?utf-8?B?VHQzeTFrTVgzdDhEQWEzRllOVFk5ZkV2NG9Qc28xQ3dNOUNqUER1ZXQwVDN3?=
 =?utf-8?B?OG8wb1BJMWlMYlB1eGQramtRNFJibEVmNUErNVRkM2Ztcy9kWHdxdEQyV3BT?=
 =?utf-8?B?RmpCNG0rTzM4MkR5WmdVRSt2anpYZXUyWTdsa1pUNzM4TDN2N3VKd3dCclpK?=
 =?utf-8?B?dEZoWVc0NDBYN0dqcGNlVTNkRkZtd25nK3gxVUlmWU5TMG50ZTdNYUt5aHZC?=
 =?utf-8?B?TmZEeENCbXR1amhhTzBuRlk4WXc5NkF3OTZnMjc4THdvUmdxUHhsTWN6L2xt?=
 =?utf-8?B?L2hOM2ZWN2x4UjVXWFQ4cURMSnlwdGpCY0JwNTU2QkczZkN3Ump3MnVqZ1Nl?=
 =?utf-8?B?VEUrZGZEeDRERTYzdHRpLzdSbmdPTm5NS2I1VSs2OXJUd1NUbE1hYkhUN2xG?=
 =?utf-8?B?aVZrbXdWSmNqaHo3djAyVEtLVDZYM3lqcXJqVSt6NVRBeVpyOWlsUnFBNnZw?=
 =?utf-8?B?amROaGdWdWlvSVJ6VnVaL3hqSFlibGpPMkJrY1hXQVJ4UXVhL2tLUjl0SDVZ?=
 =?utf-8?B?VHUzemFuMUFnYllneHVBM3RLV1VhREtURkVqaVpTOStCdnBpWVA5WEc0MHRE?=
 =?utf-8?B?TlJsaHRuczQvMFRNWDkxMFhlbWxPYlhMbm1UVWRiUFloSUlGV0JWdDJIWGxK?=
 =?utf-8?B?Vlh6Mkp5bFRSMW9DREdIcG9hTUFkVkEyOWRWT0M1ZkJQVjdqb1BFUHpsemcx?=
 =?utf-8?B?WWxxTHdaYy8rbmZ1OVRiV1VGbmxKUVJZTXR6em0wejc5NkFWdmRWRzdYYmxC?=
 =?utf-8?B?Z2ZIcUxTRDhTalJOQTdRNzR5R0xKMjlKdGQ4d2pscDduM2tLKytqaXgrblE5?=
 =?utf-8?B?MWZvRVVZVUlXM1JOSGxwTkJLM3JJSEdJYXJPaUlUZkJKVWR3anJRSDgzbnJm?=
 =?utf-8?B?Nm54eHF6eDU5TVlsMXVHc3Y2cW9Eb3UzNXNHTnFrUlppNW9QZFRhbUNOS1VP?=
 =?utf-8?B?cEw1dUFuUWRIdmNJQldQQU9Pd3FZRmNrZmM5ZHN3c2JkMTV3dUtVclhRNjhX?=
 =?utf-8?B?RUFsR0QrSGQvZnoxblhxbmlpYkhXWmZYV011WFpveTZaKzJOSUNBVVNucGp4?=
 =?utf-8?B?NEFpVS9VNXFWMjRBcVVXNUdnQzdmbEZpTHk0ZEtmUHBIVHBOVFJTdkdtU1hD?=
 =?utf-8?B?V2RRaGhTSlpCWmRuN0tjY0VBaVR4dXJhMTUrSmY1d3o4M3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFJR2g4dWNzSUNuWVljNnozOCtNK01Rc0FrSUtUNFM2N3pBaGxpK1pJbi9r?=
 =?utf-8?B?L29SNFA2OGtKM2xIUGlEQmFuS1pucGhBVm5ISk82NEE1M0FiaGdLTXBraW9x?=
 =?utf-8?B?VTNUV1ZSNmFLRDdEM0ZFbGJTa1NGblVhRFlUaCt6STB5ampPMDZkWFpuOHVp?=
 =?utf-8?B?S1Q0REtCcERaSnh3ODlCV2dLNXYyYmRvK1BlWWpNN2lFbTloUFdQVzF6aXFU?=
 =?utf-8?B?R3JMUmJkLzRuMGtzcUdWb2QxY25XVDBhNTlRaEFjcGc5dG55emw0a0tuRjk4?=
 =?utf-8?B?cGZ3UlFQaitnLzhtQzVTWW1zalZYTjlSRG14Tk8rMW1VemNKWGZmTXNnMnNi?=
 =?utf-8?B?TUducGNGcEhvblVZWW0zemQzdzA4VnZ3VkFkbElEdUtQUExrWFVUTkI5MlNX?=
 =?utf-8?B?SDhvSFBZTm5xNmRFOUErM3JESXI5Q29oazh5bklwWC9vaDFXRUloSm9BL0xp?=
 =?utf-8?B?RzVtSk0xekxnamZpSGoxOGtWdk8xWDdIMURXZ3hCZlB0TFZtdFFVb3RhR21z?=
 =?utf-8?B?bGNjamN1MTRqZE1kRHdoMlpsaEQwSmY0aHRzUS9ZSWpPWldGeXdSaEl2MmhP?=
 =?utf-8?B?WWNXZFVQWDg5UG5DaGhCcWhHYm16S0JOWEsxVzE0NzQvRGpRWFZIYnJ6U2wz?=
 =?utf-8?B?dWVkdEhNU05mUW9qNTlETDIycGVZV1RFKzZoUmhsYStrN0w3cmY1YXdvenlr?=
 =?utf-8?B?UUZONzcwck5CMUFJcTljTFFEYlNuNXJpM0dZRlMyak82SFpQSk03M20zeFJ0?=
 =?utf-8?B?dnFlaGtuSVJrTTRTYnBWblgxVHhVaFpTZkFibUFTbGVWM1ZkZG9hbGliRjVs?=
 =?utf-8?B?dE0rbHIwQUVJTDVqRVlydUxJUEp1OHhIYVJJQlFZOFMxdVBSckxMdUlTK3Ew?=
 =?utf-8?B?aHFGemVjTjFHL0RSRWk3dEdoajVLOXZWTGMrSjc4OUovUW14SG8zWGh5YlMr?=
 =?utf-8?B?am80QlBrM2NnaFJJQzlidEF2YWZpVENuTGZxdldCd04weHNEMnAxc2ZGRHZG?=
 =?utf-8?B?MXljL2J5VFBaYXk5NkY3bENHSlNOZmpQYnRaN0pVTFhJY1REemtKb3FDK0NJ?=
 =?utf-8?B?Sy9SR2dQeDVzWXZlUnJycVB5c1c3aWs1MWhZUDdnT1YwQk53S2dNZlRoMC9W?=
 =?utf-8?B?YUNvNU5MZi9XQ2k3cnlFUVRNbFFjTUNldTJCOElhQTloY1E4RDZpTkU4cEEy?=
 =?utf-8?B?YVA2Z29aQzNLTGR6Y0hMcGpZTzk4RFdIRzJ4bTVHeTBCRnhmWjNyUEN6WXdV?=
 =?utf-8?B?SzNQZklaMEJTUXcyamc4T3dBU1B4S21uOUdhY09QM1Z3Z1MxbmxHQUtLL0hp?=
 =?utf-8?B?K1BQMWxUQzBqd2hFZDYzY0tiR0s1Mi9SZVY0NkdFNDhjNk9qaXFRbUdPa1VL?=
 =?utf-8?B?RENwczFiZzV4MkpEY1Nsc1NqejN2anZrUUlXOFZqVHBhcmxNZlV4Wldhd1dH?=
 =?utf-8?B?dTZsNWNVbkNkT3Q2Ri9qTEFidlhCS0k3Qm1MQmNnZlBYbXJISGU4a012L0FY?=
 =?utf-8?B?NERRa3JQZCtTSU5RRk1pU1pBd3ZLYWdUOFZPakFhOUZTQlJ5M0tTRm1hMlpO?=
 =?utf-8?B?WDN5cGhxN3RKb2tuc05FVmprdGZ5L2wzd3J4aUJKTlE4VGVreXk3cmM0RUZW?=
 =?utf-8?B?N012VFJSMFN1RVpXdWQ5TGN4aU9EUXEzT3VBcmQ3cXJ0MUFVdFVwNC9NcXBo?=
 =?utf-8?B?aGZCdUxNS0tPM290R3pMbHc2cDMwclpYa3lqbkh0L29KeklBMUU2cTNyYys0?=
 =?utf-8?B?Rmp3bllRWG42ZmI0WWhIR2lqdWJEcnhEMHdnWXpXVUJRWUZ5SDhIUlpsMkN3?=
 =?utf-8?B?OFFRcVJHelZEWHlQSEtEYWN5WGlRcDBqcjJOQWQ4QWpYSENlVzgxeHZCNEFa?=
 =?utf-8?B?UEFsbkNYKzZvQWk0aDFlcmIvTkdYb1VORVMrdTNHa0EraGNHako5RDFXdzhk?=
 =?utf-8?B?VkVZcnhrRHh4d0xidG55TnNESExhOHNiNDh4SGozNktSTjdKZnMyQnlhczZo?=
 =?utf-8?B?c3M5NmFXbGFkQlY2WC9KZk0xSG9EWnRFUkpqT1A0UkQxdmlneFpGTEtFYjgw?=
 =?utf-8?B?MkFrZ3llcjJjdmdiVzJOVm5qQXlwOWZPcStPRE10NktOcDZueWhkdHp0dTMz?=
 =?utf-8?Q?5B6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e001e5-7e33-47b8-a02e-08dc9b50300e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 11:06:28.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tg4YpT4RzBQm08OD++fygN1rAhLB7/t/MmzaLD0dNTtViiSr9F10BVN5e14omQbeu516HaIOwUn1gSWVT7vBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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
Cg0KSGkgQ2hyaXN0aWFuDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCkkgbWlzcyB0aGUg
YmVmb3JlIGxvZ2ljIGhhcyBsaW1pdGVkIHRoZSBnZW5lcmF0ZWQgcG9pbnRlci4NCg0KUmVnYXJk
cywNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IDIwMjTlubQ35pyIM+aXpSAx
NzoyNg0KVG86IFpob3UsIEJvYiA8Qm9iLlpob3VAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47IFpoYW5nLCBKZXNz
ZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IDogRml4IHRoZSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgZm9yIGFtZGdwdV9kZXZpY2Vfc3dp
dGNoX2dhbmcNCg0KQW0gMDMuMDcuMjQgdW0gMTE6MDEgc2NocmllYiBCb2IgWmhvdToNCj4gVG8g
YXZvaWQgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIHJlcG9ydGVkIGJ5IENvdmVyaXR5LCBzbyBh
ZGQgbnVsbA0KPiBwb2ludGVyIGNoZWNrIGZvciB0aGUgcmV0dXJuIG9mIGFtZGdwdV9kZXZpY2Vf
Z2V0X2dhbmcoKS4NCg0KTkFLLCB0aGF0J3MgY29tcGxldGUgbm9uc2Vuc2UgaW4gdGhlIGZpcnN0
IHBsYWNlLg0KDQpUaGUgcG9pbnRlciBpcyBndWFyYW50ZWVkIHRvIGJlIG5ldmVyIE5VTEwgb3Ig
b3RoZXJ3aXNlIHRoZSBsb2dpYyB3b3VsZCBoYXZlIGNyYXNoZWQgbG9uZyBiZWZvcmUuDQoNClJl
Z2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogQm9iIFpob3UgPGJvYi56
aG91QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KPiBpbmRleCBiY2FjZjJlMzVlYmEuLmMxZDgyYzM0NmRhYSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtNjU2OSw3ICs2
NTY5LDcgQEAgc3RydWN0IGRtYV9mZW5jZSAqYW1kZ3B1X2RldmljZV9zd2l0Y2hfZ2FuZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICBpZiAob2xkID09IGdhbmcp
DQo+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4NCj4gLSAgICAgICAgICAgICBpZiAo
IWRtYV9mZW5jZV9pc19zaWduYWxlZChvbGQpKQ0KPiArICAgICAgICAgICAgIGlmICghb2xkIHx8
ICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQob2xkKSkNCj4gICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBvbGQ7DQo+DQo+ICAgICAgIH0gd2hpbGUgKGNtcHhjaGcoKHN0cnVjdCBkbWFfZmVuY2Ug
X19mb3JjZSAqKikmYWRldi0+Z2FuZ19zdWJtaXQsDQoNCg==
