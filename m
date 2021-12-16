Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F72C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 21:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A532910E2C9;
	Thu, 16 Dec 2021 21:15:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E4E10E2C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 21:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfI6mtLZ2P4OSdXx8pncbNOWdPaJDQUZvNHB00IA2ck9Q8/prLkAGKlkdtLEZ7Ke5FXhvZTe+Jif3qiwiONXdGo4R/L96oVrTYrbIarmQLC48CS425PEIuMQJ0RYrckIdA7EyAnhe8VCyV58zwShW2O5b7Uo0ap+b3ZLEh7J/qyR8y/7txveM3cxFVWuGekFSNu12KA+CSKRTKEyTey/bphltkXGDYiBnp6bInmfa4UFGFA42msNo2VQ84yVyjQGUxzj4wYNvggkmHaejpuAJYXNabmZKhQWNrjnJoWXhs23GnR4U4zkufc+4DYfhYZ6w48V72ppPQPfxy+bIsowEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixOdjBzwht7AlORPnv9sYEXS9oU4e3biej3Vo/+7Hb0=;
 b=WhKDJ9D9v7qxdjGbBuzzhiW16ad8MWS0q475NZeLzRROudlNfSKlDgfT2uFgkuCk2AAi/vpJgPghXgidl9Kf9yCMgJrMic4gijr69p4lYeMXLae2v1871ZQnOICMIWqNv4x965D6ym6NcQup9Z5CFvYopmUy5vgEA1JmHVRw/JwG1wpvNaYJxfW1773M8UPeYCnEqs2PYHTYcKtMY5eWczvEv0n+fFednwq76wtkBtqpyB08YOijZNU3hxWnk9edWSbj9SDKcqgqzUMT8QyOMKhkRqueb7uDaPTqzW+ATfzlBmhr17v9xkFyvUk60ABELCcuF9TAnM8SpRS6+gvpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixOdjBzwht7AlORPnv9sYEXS9oU4e3biej3Vo/+7Hb0=;
 b=qaczoUZnQSVJJrp7Zhp952EZm9Htse74rzU3JeWJ4vxPjA3qUx5UNABft07rkWg95rpnxax5hwuqNpSIRPY87a/OHPryRimp46kmetxHBefoBGmpNEKWytFZcva4H25/dHlaFmrYK5jKUwO60LM/sHOcn0//2iFlMHdE93wbFNo=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 21:15:41 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 21:15:40 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Thread-Topic: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Thread-Index: AQHX8rUgYRM1OEJxrU+okuZ3t1xOE6w1jqoAgAAKOXA=
Date: Thu, 16 Dec 2021 21:15:40 +0000
Message-ID: <BN9PR12MB532451388DDC8A494CD5AC858B779@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-5-victor.skvortsov@amd.com>
 <CADnq5_Ow9sz5Lyho=6ZasS7mbxtXk4TjG9YttZRRuz_xEj8izA@mail.gmail.com>
In-Reply-To: <CADnq5_Ow9sz5Lyho=6ZasS7mbxtXk4TjG9YttZRRuz_xEj8izA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:55:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c27251a5-05f0-4086-9945-b337889169fd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-16T21:15:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9320eb51-2f28-4723-a147-609ed4be0b3f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17801d5-0234-4f2e-dee5-08d9c0d936b2
x-ms-traffictypediagnostic: BN9PR12MB5322:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5322CB8D3501B04BAF7B58A58B779@BN9PR12MB5322.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pZ+xgSVqFY7d4IUaRCP/q3ned4cFyazGo9unhE8AMCc7RY/NuWvAP99jBOjo4jgrQqS+91g1IZEyqtOiAkWoeBK4Rjrzu31B2zI960TG5h4GaM4/RoHUMTKE1iodUKmyEdMqgp2cK+5Z/0qyzLWIGaffuvPoer+rLYH4ggiSYz937REVipf3UOESRyK3WPDd+VGsFdY435uIeliOkCPiaaPa3u3GKgYfxhjn4RYX6o2PKhPxw5ntIfDESR8nkP+Y/dlvO48Lq4fnr0ScLxhFNDJEQPZLv0EhkJjn0sG3bSDMIdUUDFfMyuX7sA03OJbV/GuwxYd3clCUf0KTk3HM52vuK7ZCjbIzlSONpRlSGnSXiHRKh/zguSbCK264p2uAk3gyxZ3539FMLD2woMCKHpvp2vFqcIo0iwp0KHgAFWa6ovBBV4NJ4sG+v1eCJAW4EZo55QC9cexmDaCQnVaj6jY0HM9MN6mKw3I3m1ITJ29Im3vg7VbAsxoVOO/tPPf64OTv0F64Z1ChIHFEVx57Z0Ff7EwL1d7m9VpjFHlLtThWDPVW/Qi5A81jqE/zXT298v+I3+QQjjVBacC4ZwOAurNnBb7vUzOQ0MSC9gjpVFtaE5VqVrsO7z92mB87Hvo/1A5tvOgNMNEA/AuAECOK3vqEp0WMQRpZ8R+yvb/FhU8PcUeBPXVPof+r2nC2xQfRcm0QwrPWYbddm1U/HlP7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(6506007)(186003)(7696005)(26005)(66556008)(38100700002)(4326008)(8936002)(64756008)(66446008)(38070700005)(66946007)(9686003)(8676002)(76116006)(5660300002)(122000001)(2906002)(71200400001)(53546011)(52536014)(54906003)(508600001)(66476007)(316002)(33656002)(83380400001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGZMc3JWWE1YMWZISEgyNEdSemhUOUhFSmNnSlhPbGE4aW5IeWhkWUhYMDhB?=
 =?utf-8?B?NldWL2k2L0Q5ZUh1cThnTnV6elkyK3lFc2IrQjFzZDN1VGx1S3RHN2Eyclpa?=
 =?utf-8?B?ekpuS0pSZE1hcVEweE1wOWNoVFRPZ0dKL25ISVEzcmFMdnhubE1JQnpCWGVp?=
 =?utf-8?B?QnJ6TVIvRzIvdFN4RzM0YlBHemVtaFc3OU5FR2FZcldNOUJseHhURDVydGRj?=
 =?utf-8?B?T2NZZUliMEc1NERneEhyYVNTbWVhVkNneXdQdCt6dnpNakJTbVVvRkVlMGlJ?=
 =?utf-8?B?SUpOSlB0YmxtTU5HZ0g5dUNsbE9DdjIxTE04OHd4bVhJZFZJYnRMc29hTlB6?=
 =?utf-8?B?a2JQS0R0ZTJsRXRqUTd6VWtMSVJxaXlSQk93aVVodzM3KzArT2dTZkkrMHR2?=
 =?utf-8?B?QVFZZS9mVmpsUFhveTFPOVVBSVBmNldZbTBUMUhnN1FUL3RKWGpMQmdCby9L?=
 =?utf-8?B?Qk9JTkVRbWx5OHlGeWdlY1IyWlh1dWVtZXZ1ejU5MlJ2TENXU2dMWUpXVzdr?=
 =?utf-8?B?eUlGWGtGS1o3YnNBTXpzNkI5NEZldUMzeFRHK3Fpa3h6NXY4aWVLK0MwSjZP?=
 =?utf-8?B?NVRmZEpFa0NXZThTOHR2NXcwcFg2U2xCU3U5c3o2cVp0ZUNBKzc3MUxFVlZU?=
 =?utf-8?B?N0pnZWVqN2JNaWFRR3hGbEJWUnphRUNPRnJwTmlOczJtemZ4SVFSWHp5Q0ha?=
 =?utf-8?B?WHF0NHVhLzFMdTBmYlNnZVUxN2V5U0tGR3J0dXhPYzlNMUxDZllrQnV6dWhx?=
 =?utf-8?B?ZzNvUmg2TjdnQWphYkxUNGRSRlZHUXAwb2RibkpMdU1EbkJ2V2FiejRBeUlN?=
 =?utf-8?B?ZVAzcE5SRG1wNTV1RDd3a3F1N25IcWRlNGtQalFCQTJYNjRYa3p0T0VNL3lK?=
 =?utf-8?B?eC9nZWxTdFJRQkdOdkpveWxsSkZyeURnRHVlaHAya0VQcXRlVmhJVWtlZ1RI?=
 =?utf-8?B?cStGZ2tVZVhhUlhKVmxxdk5jcm1wYlVDVjcwaGxKMUhXdnlmRXJ2eVR4dWxk?=
 =?utf-8?B?b09NdFA0c0lsaHozeHdzWWxZb2ozU1ZFSVR0QUR0SnZVc05SZkdWNHFBWUln?=
 =?utf-8?B?b0VFYUxudGRHbjJoeVdaVG04TDNzQnE4TmlhbkpzcDcxRENJSEVGaEgvaW5T?=
 =?utf-8?B?Smd6YS9IbHI2dmhicVB6N3JwQjRoMW5ROTlZclFQTVRRRTBGdERCOHpPbkd1?=
 =?utf-8?B?eWZSbFI3L3VPbFJ5bXE1SUZvMmpVVmdYTmtRa3JvN3RJU25YNjc3aTgzU2lm?=
 =?utf-8?B?WXl2L0VVRUJJY3Vwb1BNYzFISVN1NkJsVkc4blArVWVPbFV3UEUzZHhyWmtq?=
 =?utf-8?B?bFNjVW0wWVJyQVJBMWM1RHdNN0x3dGV2K3dKZXBXUmlkNVFLUmJDSFZPSnQx?=
 =?utf-8?B?YzFuc2hqVytNSk1mSW5QcmZ4cDU2VzlsWGdwbHRUNysxOHZUaCs5Qng4a3R6?=
 =?utf-8?B?ckVhc3lWUEZmd3RzSTN3RVAwVldmL0xRbndBbDVONitqUDZXKzYvUFpUVno1?=
 =?utf-8?B?VDkvKy9CSlpjVkFPTEZFOU5QN2VIWnRiclhQSUcwVEJ6MjVyaVBOZkF6TVph?=
 =?utf-8?B?bG1INVd1c0I5Ny9kUU1hSDJyZHhGNUtZSitpTURuQWdhKzA4YU05bEhsN3J0?=
 =?utf-8?B?aS8xcTU2eXdnblpqQjcrN0xNUXNNQXB6NjNIVTBiNjkvQ21WOXdsMEtxYkRE?=
 =?utf-8?B?OFlqNnBYeWdybHVkUWNJVnByTytPN3BhOE5zcEY1bUtaelV2aEhuTjhvU2oz?=
 =?utf-8?B?RklzZHVVY0JwdTYvUnpqWllXZS9DN2NTUlNxajJlQVNQdDl3dllrUnFVcDJG?=
 =?utf-8?B?MnJQU0Y1MDlFMEFSdmJxZUFLb0lJL2FYRmZJMnhCZ1lscGZ1cy93Y1hBeCtv?=
 =?utf-8?B?KzFqWEM2WlBRS2F1dmZkRDNDZENBVWoxN1BiRXpGUFFjSThIR2J6UXlDa3NW?=
 =?utf-8?B?WVpaRFZiVjJ6cG9HUFBSc2dCTjlNbFZ2R2FQSkxYSWJsTWhEL1dwV216ZnBQ?=
 =?utf-8?B?NWdPc1VEWFVQcVlYcEZ4SkZZRkRHM1lieG5MNllOeEZZb3VmNVpETVdQVklC?=
 =?utf-8?B?RzJFelltL05BamxUaEJjWjJjWnh4KzIxVGErMk1LdTUyKzBLUHpON3p4bFR3?=
 =?utf-8?B?NFBvd2FOaEo3dFlWdTNZU3NNOFN6N0I4ZTBWc0t4SW9hc0paa0hyd1gxVU44?=
 =?utf-8?Q?wM1iOLDA9eSbi+fimVZbm2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17801d5-0234-4f2e-dee5-08d9c0d936b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 21:15:40.5108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHY+kKcRytbJ3GDPp5B8hSra8EDv7pfeJ4S1I+9gHidP/+kaXVntu5ZpvNC/t+T80ZtsFHTGwBMOpbdtyEIpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Nieto, David M" <David.Nieto@amd.com>, "Chen, 
 Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSB3aWxsIGZpeCB0aGUgaW5kZW50IGlzc3VlLiBU
aGVyZSBzaG91bGRuJ3QgYmUgYW55IGNvbmZsaWN0cyBiZXR3ZWVuIHRoaXMgcGF0Y2ggYW5kIHRo
ZSB4Z21pIGluaXQgY2hhbmdlcy4gV2UndmUgcnVuIHdpdGggdGhvc2UgeGdtaSBpbml0IHBhdGNo
ZXMgYXBwbGllZCBvbiB0b3Agb2YgbWFpbmxpbmUtZGttcy01LjEzICh3aGVyZSB0aGlzIGNoYW5n
ZSBpcyBhbHJlYWR5IHByZXNlbnQpIGFuZCBmb3VuZCBubyBpc3N1ZXMuDQoNClRoYW5rcywNClZp
Y3Rvcg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE2LCAyMDIx
IDM6MTggUE0NClRvOiBTa3ZvcnRzb3YsIFZpY3RvciA8VmljdG9yLlNrdm9ydHNvdkBhbWQuY29t
Pg0KQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBEZW5n
LCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgTWluZywgRGF2aXMgPERhdmlzLk1pbmdAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1
bi5MaXVAYW1kLmNvbT47IFpob3UsIFBlbmcgSnUgPFBlbmdKdS5aaG91QGFtZC5jb20+OyBDaGVu
LCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5D
aGVuQGFtZC5jb20+OyBOaWV0bywgRGF2aWQgTSA8RGF2aWQuTmlldG9AYW1kLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgNC81XSBkcm0vYW1kZ3B1OiBnZXQgeGdtaSBpbmZvIGJlZm9yZSBp
cF9pbml0DQoNCltDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCg0KT24gVGh1LCBEZWMgMTYsIDIw
MjEgYXQgMjo0MyBQTSBWaWN0b3IgU2t2b3J0c292IDx2aWN0b3Iuc2t2b3J0c292QGFtZC5jb20+
IHdyb3RlOg0KPg0KPiBEcml2ZXIgbmVlZHMgdG8gY2FsbCBnZXRfeGdtaV9pbmZvKCkgYmVmb3Jl
IGlwX2luaXQgdG8gZGV0ZXJtaW5lIA0KPiB3aGV0aGVyIGl0IG5lZWRzIHRvIGhhbmRsZSBhIHBl
bmRpbmcgaGl2ZSByZXNldC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVmljdG9yIFNrdm9ydHNvdiA8
dmljdG9yLnNrdm9ydHNvdkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDcgKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMgICAgIHwgNiAtLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMgICAgICB8IDYgLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDViZDc4NWNmYzVjYS4uNGZk
MzcwMDE2ODM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jDQo+IEBAIC0zNTc2LDYgKzM1NzYsMTMgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICBpZiAocikNCj4gICAgICAgICAg
ICAgICAgIHJldHVybiByOw0KPg0KPiArICAgICAgIC8qIE5lZWQgdG8gZ2V0IHhnbWkgaW5mbyBl
YXJseSB0byBkZWNpZGUgdGhlIHJlc2V0IGJlaGF2aW9yKi8NCj4gKyAgICAgICBpZiAoYWRldi0+
Z21jLnhnbWkuc3VwcG9ydGVkKSB7DQo+ICsgICAgICAgICAgICAgICByID0gYWRldi0+Z2Z4aHVi
LmZ1bmNzLT5nZXRfeGdtaV9pbmZvKGFkZXYpOw0KPiArICAgICAgIGlmIChyKQ0KDQpJbmRlbnRh
dGlvbiBsb29rcyBvZmYgaGVyZSwgcGxlYXNlIGZpeCB0aGF0LiAgQWxzbywgd2lsbCB0aGlzIGNv
bmZsaWN0IHdpdGggU2hhb3l1bidzIHhnbWkgaW5pdCBwYXRjaCB3aGljaCBtYXkgb3IgbWF5IG5v
dCBoYXZlIGxhbmRlZD8NCk90aGVyIHRoYW4gdGhhdCwgdGhlc2UgcGF0Y2hlcyBsb29rIHByZXR0
eSBnb29kIHRvIG1lLg0KDQpBbGV4DQoNCg0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gcjsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICAvKiBlbmFibGUgUENJRSBhdG9taWMg
b3BzICovDQo+ICAgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gICAgICAgICAg
ICAgICAgIGFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0ID0gKChzdHJ1Y3QgDQo+IGFtZF9zcmlv
dl9tc2dfcGYydmZfaW5mbyAqKSBkaWZmIC0tZ2l0IA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192MTBfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTBfMC5jDQo+IGluZGV4IGFlNDZlYjM1YjNkNy4uM2Q1ZDQ3YTc5OWUzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiBAQCAtOTE0LDEyICs5MTQsNiBAQCBz
dGF0aWMgaW50IGdtY192MTBfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiByOw0KPiAgICAgICAgIH0NCj4NCj4gLSAgICAgICBpZiAoYWRldi0+Z21jLnhn
bWkuc3VwcG9ydGVkKSB7DQo+IC0gICAgICAgICAgICAgICByID0gYWRldi0+Z2Z4aHViLmZ1bmNz
LT5nZXRfeGdtaV9pbmZvKGFkZXYpOw0KPiAtICAgICAgICAgICAgICAgaWYgKHIpDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiAtICAgICAgIH0NCj4gLQ0KPiAgICAgICAg
IHIgPSBnbWNfdjEwXzBfbWNfaW5pdChhZGV2KTsNCj4gICAgICAgICBpZiAocikNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiByOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jDQo+IGluZGV4IDJiODZjNjNiMDMyYS4uNTdmMjcyOWE3YmQwIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gQEAgLTE2MjgsMTIgKzE2MjgsNiBAQCBzdGF0
aWMgaW50IGdtY192OV8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgICAgICAgIH0NCj4gICAg
ICAgICBhZGV2LT5uZWVkX3N3aW90bGIgPSBkcm1fbmVlZF9zd2lvdGxiKDQ0KTsNCj4NCj4gLSAg
ICAgICBpZiAoYWRldi0+Z21jLnhnbWkuc3VwcG9ydGVkKSB7DQo+IC0gICAgICAgICAgICAgICBy
ID0gYWRldi0+Z2Z4aHViLmZ1bmNzLT5nZXRfeGdtaV9pbmZvKGFkZXYpOw0KPiAtICAgICAgICAg
ICAgICAgaWYgKHIpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiAtICAg
ICAgIH0NCj4gLQ0KPiAgICAgICAgIHIgPSBnbWNfdjlfMF9tY19pbml0KGFkZXYpOw0KPiAgICAg
ICAgIGlmIChyKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+IC0tDQo+IDIuMjUuMQ0K
Pg0K
