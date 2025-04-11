Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F0C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7477D10E119;
	Fri, 11 Apr 2025 17:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/kTQoDt";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125B810E119
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtDwVO593KaW8Lyip1oHLR9s+HrMVvyZorPVIBxwfu9fpSdNgv8DGsMIS4lUMScEUEjufRDbElI1zN596p4tcwj2lpXQr4XTq9B8iy32jZZ+6YEDl7pQooaD/+cJ7h2CFXJEZ3UbmOSCZRBICmID+JJo8+P+xaIF4Z/CfrzTVLT6i8xq7I0mzSpsd/QZEPhInDbbhdvAiuSh8Uhsd9lwStSG0MR2TOIi8gA8kx/DUqgoKVuVRVHSB96hWHUucqHoXznbqZDIMrbJUlN1WJqTN1z/PRNfjHpR8oWmjiOOLHqhagzFgcudDl3bhvuWjzsbOa678JVta0iE3BbvRv75nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ6PMh6Ka28dCYqIgZcd94YfMF2Zfu710Mgm1qgWU8c=;
 b=IO0cAtF1+4j+HqioxWyDu7v0Pe4WZj/OvVyObN3MdpJr5dMH3MqW+9CVEwwGjD0hU14lcsu4m6uyjb8zV+vwd3VE4cY9fQEJDprsQLzQDd82ouM4Id4SKcrylzjssgNavFzn/pimpPM9NBHV5MItkNX9RxdSH8RNevbpWOUl6iVG5vVX5HMu1jt+VdxdaDLM52MqJHh1DHnK3DhpdFaybS6DTDdDVW+/X2YwyaPAVEhpEEHrye7ru+kpllv7lG+bphn8ROMHZaFGvhOVDaiVuRggBt11yC1cyEzmXTRLd9vdT1OPwe1MZv2V7lhLbQg4CpWuGYa/ER7r47cx6jM3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ6PMh6Ka28dCYqIgZcd94YfMF2Zfu710Mgm1qgWU8c=;
 b=n/kTQoDtpPV+J21K/AmbBjqRr5AaBlehNpEx1tjNlCFTZnmBaE870E+Oub9++ksbK6ivpTjz7vaw/d4Obk34kBDAGnJav022x3jXjSPJmCp02wIbxu2xMgR1p7piV47+Rrzld5lF+412HM+5dRFG0JYBtuRG1Tm0SSGp/Eg5V6Y=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:03:26 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:03:26 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable doorbell for JPEG5_0_1
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable doorbell for JPEG5_0_1
Thread-Index: AQHbqhi+EytWlV0500GB31I5U4wiSbOesvag
Date: Fri, 11 Apr 2025 17:03:26 +0000
Message-ID: <CO6PR12MB5394003AA6E269AA834CAA74E5B62@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20250410130113.2834113-1-sathishkumar.sundararaju@amd.com>
 <20250410130113.2834113-2-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250410130113.2834113-2-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3a36ac00-36df-4416-be3b-aa50362210ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T17:02:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|DM4PR12MB8475:EE_
x-ms-office365-filtering-correlation-id: fc433801-184d-4406-6e1b-08dd791ac67b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TG5WTEErTERMcXF1eVBRT1lvNjY2RVVIcEl4cHZDQzZNWjYzZVhqU09hbUhK?=
 =?utf-8?B?aWVHSHJYeDNlZVhrRWZyQWlMRXJZaXI5Tnp1K1diV0x2TmY3M2tWSUROMVRp?=
 =?utf-8?B?cjIwbE1SV2w5M2xab2pMcTJyNVlsSmVkOExBZUE2YzltNHd0N21nVlNxQ25j?=
 =?utf-8?B?M3JmazlBRXlZcFcvVWd2STc2eHkzTUdLR1JsMjM2YkxiZ2pQbGUyRUFVUE0r?=
 =?utf-8?B?alhoRWN2cExobTFFaG1vc3NQOGg3d2pvUFBORTNYM3dCR25NbXF2TyszWnh5?=
 =?utf-8?B?NHVjZU01QW1zUkhpcCthZ3pIRHFFUzQvVm0yTnkwQVlvMXFGenhTWlZvQ2ZL?=
 =?utf-8?B?d3Y2cWlHNHNsNHVKNjNVWWMwR2lMT1FyZHF1MUNUNnJUZ0NDOVY0Wlh3YTZk?=
 =?utf-8?B?YnZCUUFJQjdRT3lCUyt4bHRiRCtyQVpyMGV1V2dPcTd0aE1pbG1CSmRBNjNq?=
 =?utf-8?B?RDh4VmFhWVJicW9GNXFHenNSclJTSzRwVEdML3UvcGkzWEk5RHFoSkx0Tkg2?=
 =?utf-8?B?cUlhUDRsYTdOVjhMTmJKNmlReGpsQ3FRTWRuSHRwL2ZCZGhlWWlVdjBUb2FN?=
 =?utf-8?B?eTYwOVlycHdLU0lmL2VNbkV6MGlVTG9lcEh3bzlLaE51aURibzhyaXhmLzJH?=
 =?utf-8?B?MEprNDVxeFR5S0lZNGtqOUoxblpzK0xPVGVFM1FjeTRyajlaVm55NFJOY2NF?=
 =?utf-8?B?Y1BqTWd1WTN2dEtTTzJqLys1eExIbEl1eGNDNVNqRnh2L2VkVDRwQ3lUTUph?=
 =?utf-8?B?cEVoQmZIbkYwMWVkaHhjTnZtSTI5MFZEcGt0YW9hSHUzZy9TWTc1R2h6d1Fx?=
 =?utf-8?B?b095WmRJd3F4N0N4R0FYWlQ4N1F4czRWYytqNEFOVnk2MmJvOHRsSzNqZEMz?=
 =?utf-8?B?eVlRdEsvd1JwZUVReVZKZk9IYm1ERys4RXo1b0U2dkhYNmxsSmVWYi9DUVZp?=
 =?utf-8?B?cUl1Wll0UG5iMmRaOUpFbHJyYmdGUWJZK3c2QzM4MjQxaG5sME1JN1J0U0pv?=
 =?utf-8?B?NHpmSnB5bGRnbXVpWEhIQVNWZ2pHSk1ncHVnQ3NSMUxsL25iTGc4K0xTWTEz?=
 =?utf-8?B?YUtxemhDWXQyeUlTZWt0a3dleHArdWdFSDJoVUFlUEFSd3hsMktCQ0Z5cmlz?=
 =?utf-8?B?WmRWU1IycHVYb1AwQm43U3BySXNMallFbE16YTJjeUs1MU1qVFdMUHE5bW1N?=
 =?utf-8?B?NG9kZ3gvcW9GNkVaVFhzbGlxZ0FZcFdvYitDa3NERlBqbDJZWlJFU3JDcTJ3?=
 =?utf-8?B?c1V4ek1aU1lyOWZHWUd2YjR6ZTFHUktuR1Vsa3JJRTJtYXNjci9XNUpOTS9o?=
 =?utf-8?B?M0dWTlJaOWxsWDVHdzZtWGEwNmh6dzJXdkR4OG42M01jbWRzRkhCcjBBb3JH?=
 =?utf-8?B?S2FDcjladUJQUDNnV05JeWQ4SFljZEtGQzRvc2V6ZmZMZWprSXNqS2hpakND?=
 =?utf-8?B?UE0rL1RwN2JaR2VOZm5qaTVpNm12WkJ2SUorUURVOHlJMzFOOTVpc3BJdjVk?=
 =?utf-8?B?TG5Oc2p0RjhCWGZpSmdySjBDbkxoZ1EzeWc3TUMyOWVGcCtsUE8rblhqOXFJ?=
 =?utf-8?B?VlNkQTdKRjhGMDdTaVB4VG9ZbXJKcG1lRVFkTko5VjNmY0lRSU1GUUxoa1RQ?=
 =?utf-8?B?K1dmQ0F2SEZyMmNQZWd2N3BML0I1ZU5NMTh6V0I0MHNwanVLcGtHaGhwemJ3?=
 =?utf-8?B?R0lyd29uUTJmTlVLdGphTGdnb0x4RVZSSTE3L1NFYU1NMERZdTRWTXFDV2pm?=
 =?utf-8?B?WU1jckY2eklrNVIvdlhMWmpvTCtEb21DVnNGMVNKTmFselBRZ2RTblF3anpV?=
 =?utf-8?B?akh0cmEwV2tka3Q2U0t0bGpzcnRGbEMwSU16UXRpZ3N2WGUzU3dCKy9CaFkw?=
 =?utf-8?B?UDZoYWMxVklHN2tDdVE1Q0RzRzFlc2xOTjNIOE9XNnpocFR2RDQ4enhFMXU5?=
 =?utf-8?B?MnRKTG1ET294ei9URmx4MVZYQ2xYSFhqd1YyQmdrLytRcENCRXdweGVWUUpO?=
 =?utf-8?B?bmgyMDVDb0h3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2l3SjlkWDd2WnhjQ25SSW9Zb0dDcW11dTlRei9veHlBUnV3NEZ4djk0OWRo?=
 =?utf-8?B?WmlEZ1BObGNIMG1HWkMyL0FHUzZOeGVzWjRUWXhmRDNsQ1ZDeitzckhFcTBC?=
 =?utf-8?B?Tld6M3V5akxWV1pJa2k3VXliOHI4ai9jLzI0TnNBYTQ3VGxZTXFFUTJudi85?=
 =?utf-8?B?ZHFNYkZ1ZzdSNHQ0eDIzTWNzZk5OTW40d0dzdS9nSFdTbEtyR2MyOUdyd2NU?=
 =?utf-8?B?K3ZYNlZRTFZ3S0UxS2Y0WExpdklxQ3d6L0NUU2JLbENaVEJta2ovYndYS3V5?=
 =?utf-8?B?WlA4YzcxUWlrYjR1d0E1bG9SUUtxdi9wQTVWL1FCeVV5cTFGMmJyYkFEcW1W?=
 =?utf-8?B?dFhlbFYwU0tScXNRZ1hzNFdnQUdod1Avdi9SNXdWUDJ3UnUvbFZEWnRQdGJZ?=
 =?utf-8?B?d2o4eUxQWVlRRGFqMDlLZVp4UUVqTnFaaUFWdVJHMUZSU280eEc0NUlETjJZ?=
 =?utf-8?B?NWlGWWpCaTRJUTg0OGIrMXlldDhmVkFHSmdOWDYwWjk4Y0k0M21ZZGJ2WENx?=
 =?utf-8?B?aHBhTHZQNVFLallYMHJHZEVlTGRnNy9VK1Mra0d4TTVNcG93N1NPYURFSzM0?=
 =?utf-8?B?KytiYkQycDJkNmFVZkVNbTJaNm8yRmNNK0hDS1RxRllXRUhNUjlDdTI3a3lJ?=
 =?utf-8?B?VnNCcHZhZnJkT3VlTXJ3N3ZZQjZ0NW51eCtJQzZzTzBzZ25CUCsxQkozUm5H?=
 =?utf-8?B?RFptd2JsN3lWbk9SRURkamJ2ZkY3REp5Qlh5WXQ2K1l5OE9mTklDdkp3TGVz?=
 =?utf-8?B?ZUFaTCttUjJSYW44NUZ2SXdyNkJyeHdYaGNkKytPWTd0SkVYa0ZqQnBmaUln?=
 =?utf-8?B?Sm9QMURydlVzSzZCdG44VGt6ZGVsQTgydUUweWJUS2htM2owSy9MZ25yQnlS?=
 =?utf-8?B?WUJFbWNTckJQTjYrVXdSSUNaaTlwU3FxdXdmdUdiTHhmVklFa0xTQmJoYVQr?=
 =?utf-8?B?bUtUK1BYUlhwYnpoaHRoRVZvdHhXVkJieTF6MXFkeHpDcVVMMVB6ZCswMitt?=
 =?utf-8?B?K0xqRDkvNXNYWm0wcldlb2kwMG1pVndBRFU2d0hraUYvVVpHakRnaUxsT2xh?=
 =?utf-8?B?NFh1SllNWXZpZDUvQzFLZVNQeFFtKzVxK096MlRnSFdONU9vZTZEOG00Y2ZD?=
 =?utf-8?B?VzJ4TW1TeEpDamJEVjNkaUJOaFZtSk9mR1VXaUFBeGN4eE1vSno4M2N5dTBU?=
 =?utf-8?B?S0FWVHR4U0hqQTl6R3FXakNSZGthZi9nbkJReWJRUVdQUElxc29XaGZ1cnNT?=
 =?utf-8?B?WExlQ0twY2VCUVVSNE1Nbm9ESmEwT3ZVOENsb1BJeStQTWRSdy8zSDhTdWJR?=
 =?utf-8?B?R3VNOWF5RGtIZFpkNFFsSE9FVEptRzlucG94eEx5RUJXQTNRM0wvc2RRTyt3?=
 =?utf-8?B?Y056SEQrSkxBV0U4SDlmaC82c1hxQTc1U1NYMmRiTFpQQnlzNUppTjRaNG5h?=
 =?utf-8?B?MzE0bjE1NmJ5RDJWYUJvdjdLOTFqVzh6V2NOMVNxSGJNeG5ZNzU1dmRZNHJp?=
 =?utf-8?B?Ym54WFJzeCttOWtJZTlFa1VmZDJ1TVBGdWlLUUhQaGtsQnJ4bkdVeFB3Um1m?=
 =?utf-8?B?aUFxTElCV01QQ3VoSmxjbkJoSTVQM2o0REJIV2tIR1lYWUJlWEhNZW5iYnBk?=
 =?utf-8?B?ZnZUUmlKTjJ2L21wMVplRFo5K01NaGluL1hpL0VYSjJ5V1pNcVdwN2o1Y2pF?=
 =?utf-8?B?c1ByTTN4clZYMUlwM3VpbGN2YVFOWFNseDl0a3hBMmczeTZrWnlCanJLL3ox?=
 =?utf-8?B?cTJnUW11Tm9NdzE3YktkM3diUmRRY0RIb2xETFdORGdJSVFuVkJyN1k0V1J5?=
 =?utf-8?B?ODJGWTY1S1h1cmpteUlMTTRVa0VUOVJNeGc2dDRVMHdTVklqdXM4WXZGTGRH?=
 =?utf-8?B?dHFReE01SHlPWVdCYmtrTkNCTGF0TEhsOWRnWHFCN3ExdUw5eTJSNm1od1Zz?=
 =?utf-8?B?QUNid1Q1RU9FSEdXRE0xY2haL1dvRW14NWlsWFRGOHNLOFNJdWxwaS81dnNC?=
 =?utf-8?B?WkhnRFp1OVhSbEZSWkIxZk0rZXlnMnZyR2VqV1FlTUZTVkNERUlyK21UVkNH?=
 =?utf-8?B?cHp0Mllsa1huNWpwSlFoNnJNZkxMUklnNUt6MTJNQTNQOWtVUjRkeUMvb05E?=
 =?utf-8?Q?xaDo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc433801-184d-4406-6e1b-08dd791ac67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 17:03:26.2140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fn9PF74uqIMJINXnUpZSyPAPaK6SkBb9fbD6XUkquwowl7o9HnnTwZjZqqvBB81H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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
Cg0KVGhlIHNlcmllcyBpczoNClJldmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VuZGFyYXJhanUsIFNh
dGhpc2hrdW1hciA8U2F0aGlzaGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+DQo+IFNlbnQ6IEFw
cmlsIDEwLCAyMDI1IDk6MDEgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBMaXUsIExlbyA8TGVvLkxpdUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT47IFN1bmRhcmFyYWp1LCBTYXRoaXNoa3VtYXINCj4gPFNhdGhp
c2hrdW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0v
YW1kZ3B1OiBFbmFibGUgZG9vcmJlbGwgZm9yIEpQRUc1XzBfMQ0KPg0KPiBFbmFibGUgZG9vcmJl
bGwgZm9yIEpQRUc1XzBfMSBhbmQgYWRqdXN0IGluZGV4IGZvciBWQ041XzBfMS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogU2F0aGlzaGt1bWFyIFMgPHNhdGhpc2hrdW1hci5zdW5kYXJhcmFqdUBhbWQu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjVfMF8xLmMg
fCA0ICsrLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NV8wXzEuYyAgfCA0
ICsrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NV8w
XzEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjVfMF8xLmMNCj4gaW5k
ZXggMjE4ZTE2YjY4ZjFkLi42ZjczMDMzZDc4YjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjVfMF8xLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvanBlZ192NV8wXzEuYw0KPiBAQCAtMTU2LDcgKzE1Niw3IEBAIHN0YXRpYyBpbnQg
anBlZ192NV8wXzFfc3dfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykN
Cj4NCj4gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgYWRldi0+anBlZy5udW1fanBlZ19y
aW5nczsgKytqKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICByaW5nID0gJmFkZXYtPmpwZWcu
aW5zdFtpXS5yaW5nX2RlY1tqXTsNCj4gLSAgICAgICAgICAgICAgICAgICAgIHJpbmctPnVzZV9k
b29yYmVsbCA9IGZhbHNlOw0KPiArICAgICAgICAgICAgICAgICAgICAgcmluZy0+dXNlX2Rvb3Ji
ZWxsID0gdHJ1ZTsNCj4gICAgICAgICAgICAgICAgICAgICAgIHJpbmctPnZtX2h1YiA9IEFNREdQ
VV9NTUhVQjAoYWRldi0NCj4gPmpwZWcuaW5zdFtpXS5haWRfaWQpOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmluZy0+ZG9vcmJlbGxfaW5kZXggPQ0KPiBAQCAtMjY0LDcgKzI2NCw3
IEBAIHN0YXRpYyBpbnQganBlZ192NV8wXzFfaHdfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2lwX2Js
b2NrICppcF9ibG9jaykNCj4gICAgICAgICAgICAgICAgICAgICAgIHJpbmcgPSAmYWRldi0+anBl
Zy5pbnN0W2ldLnJpbmdfZGVjW2pdOw0KPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJpbmct
PnVzZV9kb29yYmVsbCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX1NP
QzE1X09GRlNFVChWQ04sDQo+IEdFVF9JTlNUKFZDTiwgaSksIHJlZ1ZDTl9KUEVHX0RCX0NUUkws
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHJp
bmctPnBpcGUgPyAocmluZy0+cGlwZSAtDQo+IDB4MTUpIDogMCksDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmluZy0+cGlwZSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5nLT5kb29yYmVs
bF9pbmRleCA8PA0KPg0KPiBWQ05fSlBFR19EQl9DVFJMX19PRkZTRVRfX1NISUZUIHwNCj4NCj4g
VkNOX0pQRUdfREJfQ1RSTF9fRU5fTUFTSyk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y25fdjVfMF8xLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjVfMF8xLmMNCj4gaW5kZXggNTgxZDg2MjliOWQ5Li40YjJlNmEwMzM4MzEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NV8wXzEuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8xLmMNCj4gQEAgLTEyNiw3ICsx
MjYsNyBAQCBzdGF0aWMgaW50IHZjbl92NV8wXzFfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Js
b2NrDQo+ICppcF9ibG9jaykNCj4NCj4gICAgICAgICAgICAgICByaW5nID0gJmFkZXYtPnZjbi5p
bnN0W2ldLnJpbmdfZW5jWzBdOw0KPiAgICAgICAgICAgICAgIHJpbmctPnVzZV9kb29yYmVsbCA9
IHRydWU7DQo+IC0gICAgICAgICAgICAgcmluZy0+ZG9vcmJlbGxfaW5kZXggPSAoYWRldi0NCj4g
PmRvb3JiZWxsX2luZGV4LnZjbi52Y25fcmluZzBfMSA8PCAxKSArIDkgKiB2Y25faW5zdDsNCj4g
KyAgICAgICAgICAgICByaW5nLT5kb29yYmVsbF9pbmRleCA9IChhZGV2LQ0KPiA+ZG9vcmJlbGxf
aW5kZXgudmNuLnZjbl9yaW5nMF8xIDw8IDEpICsgMTEgKiB2Y25faW5zdDsNCj4NCj4gICAgICAg
ICAgICAgICByaW5nLT52bV9odWIgPSBBTURHUFVfTU1IVUIwKGFkZXYtDQo+ID52Y24uaW5zdFtp
XS5haWRfaWQpOw0KPiAgICAgICAgICAgICAgIHNwcmludGYocmluZy0+bmFtZSwgInZjbl91bmlm
aWVkXyVkIiwgYWRldi0NCj4gPnZjbi5pbnN0W2ldLmFpZF9pZCk7DQo+IEBAIC0yMTMsNyArMjEz
LDcgQEAgc3RhdGljIGludCB2Y25fdjVfMF8xX2h3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9j
aw0KPiAqaXBfYmxvY2spDQo+ICAgICAgICAgICAgICAgaWYgKHJpbmctPnVzZV9kb29yYmVsbCkN
Cj4gICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPm5iaW8uZnVuY3MtPnZjbl9kb29yYmVsbF9y
YW5nZShhZGV2LCByaW5nLQ0KPiA+dXNlX2Rvb3JiZWxsLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoKGFkZXYtPmRvb3JiZWxsX2luZGV4LnZjbi52Y25fcmluZzBfMSA8PCAxKQ0K
PiArDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5ICogdmNuX2luc3QpLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTEgKiB2Y25faW5zdCksDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnZjbi5pbnN0W2ldLmFpZF9pZCk7DQo+DQo+ICAg
ICAgICAgICAgICAgLyogUmUtaW5pdCBmd19zaGFyZWQsIGlmIHJlcXVpcmVkICovDQo+IC0tDQo+
IDIuNDguMQ0KDQo=
