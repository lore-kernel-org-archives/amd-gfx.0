Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B8BC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 00:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F056F10E17D;
	Thu, 30 May 2024 00:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lPrOHmik";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50D310E7A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 00:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y34gph1c6J6c+fAw2rb4qk2/+93G9So7d8H9Ws3bzT7Fv7R5bHl15Tl8+TBkBrjdOaNFqlK4WV/Z0gbfvo7S3zz8ihFrbKlMUZyeUSSsKlkmeKLqyzcypheb0oHtgE/DFIjiGwV0NIQUIoqoBmnMwVfsozGpKjnx5PleV6VXCkp/Zkj1obbrg+IgkobWLu1dCkD9QH46pnfV9s50ANeTKyJgk221SijokB8OWTa+XJE9v4T/TWKQ4nw0a9ZqhIPtBSQj4Uc2QjmraijnbDIg7JEMqlGgXKFq4/Wm3ErkK6HbS5epVdJbYmGkaqn7R9va6EvOLHR4ehBDFExj3aE8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRu5OUBSyQsXeSjfbS4K8M1BAJz82WshIpSrcnnqAYs=;
 b=KutDBN36TCHjzQukKU8POPXPHg1oW5zRYgjVRzrRYqqIdSAApG9W2hIcy4ASL4CgMXGejNK3NtVqcuSN9j4FZxvyvkGq2KLIM5mXslujhWknZJU3I5XXuWi+FvaNB/oduf16Win/dO3Ks1Oq7thz6AODpn+s7yvBXZ9zjG254K9AKD5aUaNku9wJYv37lwDimcF4EmuYqGPmeppDVr2oG0OqLKQDd2dYATrsKzJYG4+51UD3o3sBwteeYuWyOHGeNhCr9GDAdVd3M/uzAvzLPKvCjM+oBbVfPXDTi6762L0fbHCICuGFCmZM1rWfyppzUkv5ssklFnPnXhxUUVi+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRu5OUBSyQsXeSjfbS4K8M1BAJz82WshIpSrcnnqAYs=;
 b=lPrOHmikiDUvRN/JKE97pfTfXn2qBV72wBkcM+FgD44bxLalexyigs4VyI6AfIwDDo08+/nfvUVwdLdWmnZQ4jztL9MWo0sicfaER1aKLWSkRXaIRpLvZYWS7ECctRTGeM6bqXbHxp+ekd054mgioHHt8VnrB6H5aq08gBD/HBU=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 30 May
 2024 00:06:25 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 00:06:25 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2 04/10] drm/amdgpu/kfd: remove is_hws_hang and
 is_resetting
Thread-Topic: [PATCH v2 04/10] drm/amdgpu/kfd: remove is_hws_hang and
 is_resetting
Thread-Index: AQHasSPka45zy3pdiUKAnuJsefRyPLGu1uKAgAAQGzA=
Date: Thu, 30 May 2024 00:06:25 +0000
Message-ID: <SA1PR12MB8599DFC3E33270B0901179F8EDF32@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-5-Yunxiang.Li@amd.com>
 <d7715590-edb4-42af-ad08-175fc9aca048@amd.com>
In-Reply-To: <d7715590-edb4-42af-ad08-175fc9aca048@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a685a8d0-b995-4ddd-b237-4059e49cf698;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-30T00:02:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|CYXPR12MB9320:EE_
x-ms-office365-filtering-correlation-id: 1a774cb0-59b0-4fd2-9d96-08dc803c5888
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d204dnZCSkZub1JtVlVVOFVNZnBUb04xVGxLTXRFSWQxK21Nejk5aFd1RHlw?=
 =?utf-8?B?Uy9DTEM1dGpGeXlQOTA2NVgvYis5NkdaQ1BWanB2M0hleVVkNXNZM2hGelpy?=
 =?utf-8?B?dTNGeDBCNVdXdTQwWDA0SkhzRDhXVUV5MElOemM4NkxNRGdOS285djNCVVA3?=
 =?utf-8?B?MUpwdXc5OEVLYUpTVnZzYWlpN1lTc2s0RDY0amk2TG5MYVpwSUlmUUlvR3ls?=
 =?utf-8?B?RStpN3BBQk9vOXQwWXlRdkpMZEZ5OHh4U1cyR08xa2NmajFleVJQNFZYVVRz?=
 =?utf-8?B?QXFqUGlEdEtoNzVpK1JqaXNBUWpIU1RJMG90NEZ0NXUzaGJNbno3eElxb0FY?=
 =?utf-8?B?ek9yZ2Rka01sV2NYV3MwOCtZdWt1aVk1OGs1QS9UUHpCTlRSamMwOTJiN3pR?=
 =?utf-8?B?NTY0bzJyZXlJUU5xcEhSVzhycVFoaVh1RExwL2RtZzNCYW5PRXl3ZUdwSW90?=
 =?utf-8?B?VFQrL0ZINXRrWGNZQWVNeFBhSDFpTFc1L3RVUVAwRGdSOTBIMTZVR2xVMXJE?=
 =?utf-8?B?REptVDJCZVNueE9kMklJVEpwTjlZSHgxVGRHMmpTMjhKRWJFZGpMbWpyWFRv?=
 =?utf-8?B?ZTNSUnQ0L3lVT3FOZVB1d1FPcmpseG5HY1FmeStWaWZNOVZSejlwcUJocDMx?=
 =?utf-8?B?ZGZFcjVOUFc2V01lS01GNW4vbmZlS3ZrR1p1TVcrVU1yOGlYc2x2aXkveEpC?=
 =?utf-8?B?bE9XNUQ5S1dCQjBJcWNUUElpbUUveWlQTFZwa3VSeTdwbmNIamFwSktmRVVF?=
 =?utf-8?B?RUt1L0JwS04rWDZpTlRSeXhMZDV4TW41dzVUK0psRXI2WFNMZHUyVjJrVHpD?=
 =?utf-8?B?SkNOR1VaY3U1V3FKbG0vZVhBZlBQRXU2bWdIcVR4azIrK3FGRWJjV1BRNHpD?=
 =?utf-8?B?S29zM0NLa2dTd2RBdmwyWDMzRFJ1dWt6cUNpZmVDa29zMFJhdHBidlNFRE90?=
 =?utf-8?B?cW9LNGdKdnNDbStoS2xldEd6UU5Pai83dlczdkZobDJHQW4yUHJSM0NxMlRu?=
 =?utf-8?B?SzlodWY3NDhJZ0U5dFUwcGF5NHlNN28vc2xodmdFUEh6cUJPbE54VTNRbHE5?=
 =?utf-8?B?QjNqanhzMTl2Y3NEdTIxYi9sRk9Ia1ArWUlWQys2SGN0Y0RHN2gxN1dIeE5D?=
 =?utf-8?B?WmVZSVh3c0lOTVA0cnZpUE82R2MwLzBQT3NpK3FpSVdLSE9Td3BaZFQ1QmV4?=
 =?utf-8?B?bWg5T3plOVFyMHhPVHdYSXk5VjB3OXJnSUExZE1mcXlqVTJiUEdxa2owcUZa?=
 =?utf-8?B?dWFuUzd1dkJ6dGxrYnRpc2tucFN3OTRLNEIyeklXVVVJelRlb3pYaFZHdkZM?=
 =?utf-8?B?bi82Z0JiRmQ3Qnp2R0dqbWtNbkZTYmxTNDhFSlJ5RFM0aThLdm5laUIxSlI1?=
 =?utf-8?B?UENTNW5xanMwTUdhMzFXSGw0ZFRxamN6V0Rpdk15cE15QVJhRGFhZjNZanhX?=
 =?utf-8?B?b1p1SEs1clBSaENRd3RYZjBadWZUeHpVRU5GeHRRL0xMZ3JHSlREK3F6TGVP?=
 =?utf-8?B?aXNMc2ZrYW5VZHVCMzhvczRHTDdRNGpWQk5xWWwxZmhwU2JydXBtajNrYWdy?=
 =?utf-8?B?dEkwTHVEUHYydEI5Q1dDbWU4UzJrdVJZMG9weG8vbUg1R1VJcUlQTUpiRllS?=
 =?utf-8?B?R0FyZXpXNnVqajR2Q0JXZmlRWVRQWGZLVzlFMDlVOUt5ckVRMzkrWW4zUVJC?=
 =?utf-8?B?MStzemhvQ0h6MVFJempjcGxQLytSUHJFU1NTK0ZmZm9WdWZxNlJkNDBKNTN4?=
 =?utf-8?Q?HoF8UWKcsH4Pd0fN8vFrxXQW4i1bvLjxG6oQJjz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0V1SFBGSzhpU245L2NCK1A5L3ZMKzJLMml1cjFSREZ1RExJWFRqeVJGNU84?=
 =?utf-8?B?MjNJUnZtdmpwZ0NSc0Nyc1RaSjMvZUxyUUZTL1hETFQxMEEzM2tkYWtBSm0v?=
 =?utf-8?B?b3FiRHl4OUZtRExkZmlBb094L2FFRzVrZmRZVFlYVmhYMFY2djBaVU9aUEVI?=
 =?utf-8?B?T04vM0Njdk9YUjY1OUtWR2xTbjdpdDZXTWFBUWF6eXU2UGhzdUZiWElhSE5Q?=
 =?utf-8?B?V1VxSzhZVlZxRVBmeWRJUHdDaTJGeXBSQ201ZW5lWEJRdm5XRG8zUEpHSUVk?=
 =?utf-8?B?SmF4R3JFa0FCYWYxZXBLeHA2c2ZlUFhFTktMYTNlRHI3TGp1Ni84YlBNeDJp?=
 =?utf-8?B?UmVxYWU1MXVid3lpb29xQlBjdDdtaHJNcWUxQVZZeXpMeStSYVZmNjJGbU1E?=
 =?utf-8?B?WW10aTdEeGN0VVl6aVlQSHc2aTN5R0JHK05XUW1vNE5CZDZ4QWdQd2RyWm9U?=
 =?utf-8?B?Y3ZMQ1BOQ1lUM0N3b3ZST29VSGN5VHp0bE5jQWtiL3R2dFQxQVFhZmRFeDY4?=
 =?utf-8?B?VmlxN2pPbjNMUWNXbnZkTnlQeHhEOFhJZnlnMGdlME1Rc3NOQjVXeWllclpW?=
 =?utf-8?B?SkRjczhoeHl3anB6WEF4R0xCMU5Mdm9BU1kzTUM2VjhNNkNXcnlmNXJSa1JT?=
 =?utf-8?B?VkRib09rK1M3NGtqTmxWdnJSQ0E0elJvQTNxSnJyaWpuUmtzaDlrWmRwWHpQ?=
 =?utf-8?B?Tzl3Wlk4UlJSYWI4NTBHdGpYTXk1RVlpVk1yUk1raFJ0cFA5bzFJRzNaZ3Vm?=
 =?utf-8?B?MTltN2phcGp6d3JDSXpERitGZHJiZ3RFMHF4dDdZN1JCWU1mK3BHYjJUQzNM?=
 =?utf-8?B?QWUvSGJySTdTazBKR2ZoaWdnN0NHNTd0aDhobTlKOEpLd3QvVU05dWVpN3ZC?=
 =?utf-8?B?bjlzTXVnMGdoSkZqbUp2TVJSQUNYaXQyZFp1VkJtN3pMUzZqYVRwL21JRUEw?=
 =?utf-8?B?b3JOQWF1RGc4NHlha01zSERWNzFoKzkwK2xHTlNkaTgrT3VidjRMaCtzUmVx?=
 =?utf-8?B?aVpING1vMnI1RC9NcVp1Z1ljcXBBWUdDSEpvTjA3SmUzOE9tWStoZnpRWHVG?=
 =?utf-8?B?VWdqOERHUFV1bFMyWVZlZW1YeE1LWXd1S3BuYm9DR2FkeE05T3dCbDJIN3ox?=
 =?utf-8?B?cm5Oc2Vvdnh1d1Z5TTVocnk0ck1EZk1ValdvSnBpUFR6MEZhZlRVclc2R0Vh?=
 =?utf-8?B?eTlmMW02TmlhSXN1NzIrSnIwL1BoeEhNNk5na1ZzWm5rQkR5dVFrYmlTZUpj?=
 =?utf-8?B?dDM4OHA3Q0JOVkhmcHgxU1pTM1NRbG1SSUlzZnM5eXBndmoxSFlkZC9NOGNm?=
 =?utf-8?B?UEtDMi92T1JNT0ZCbkt3azUwR1RCZnVKUFFHcUgzd1MvN0E5Q1Zsc1VlZmRs?=
 =?utf-8?B?aElLdjQ2S0F4bHdTdHZtZm1PeFNCNXpSVThhMldHL1ZWSmpYcUFLOTRCUHo3?=
 =?utf-8?B?VG1rcXl2WHZ2TjJQWEU1NFdYRis4bm13bnhMWGFRTnZubjBjUzJNV1Frb3R4?=
 =?utf-8?B?UmtWSkdCT2g2bGg5VlhzejZ6Wkoxd09Sa24rUGZJczJObzVFbCtuakM5bFJT?=
 =?utf-8?B?b1BwWTBkbUx6WWhzMExXd2I2RDAweEJNTUJsV1dldU8wYnRXc3VLcW9wemJj?=
 =?utf-8?B?bGpHRTdVa1FUUTVrRktFSklLbVlpMkhYZm9tVStqYWxSQ2NWUzBDRWZ3aVlr?=
 =?utf-8?B?VjFQSEFPRnRqTDVyVUx5eEJRVUpkWmxTTHNtSjY5ek5GOUp4ZEtTN1E5dE1Q?=
 =?utf-8?B?cEpZZTFOb2JwdmRFR3lmQWg3VE9valB4eEJsRitnL2FFaUIya0hoZTBsSGl4?=
 =?utf-8?B?L3dEbC9GTWdLMC9hV2hnaEpWVDVOdzRRNUlTR0grVkZlNWNNV0taT1NZTHdz?=
 =?utf-8?B?OGphaVRXRGNiUkRzOHc3aXdwZGNmNFZYbFIwdDdCMXl4TG5WamNQeWFpNGZR?=
 =?utf-8?B?RHRqa2J5NjZMZnJPWEwvZlptNmdLZjZBS0d0aUJJUHNub0lESStZU2VzN01p?=
 =?utf-8?B?czgxWi8rSElwUGxrUkpwcjR1YVZEeVkxcUVodjJoSTBpelpVR0FsQ1ZDamlO?=
 =?utf-8?B?MlN3bGZmSVR4OVJHckEzNVRudlR5aW5KV0F3TGpDWWJNZi9TNVYxWGNhL3JW?=
 =?utf-8?Q?urqs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a774cb0-59b0-4fd2-9d96-08dc803c5888
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 00:06:25.1203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ASB7V+qv1qa58W466kdSzTDrJA/mIPs2WBZUWwklWitpCJIpTQ2CAPNnD6zIHeJXN7xF+Cpy/IQhQI93+pt2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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
Cg0KPiBPbmUgdGhpbmcgSSBjb3VsZCBzZWUgZ29pbmcgd3JvbmcgaXMsIHRoYXQgZG93bl9yZWFk
X3RyeWxvY2soJmRxbS0+ZGV2LQ0KPiA+YWRldi0+cmVzZXRfZG9tYWluLT5zZW0pIHdpbGwgbm90
IGZhaWwgaW1tZWRpYXRlbHkgd2hlbiB0aGUgcmVzZXQgaXMNCj4gc2NoZWR1bGVkLiBTbyB0aGVy
ZSBtYXkgYmUgbXVsdGlwZSBhdHRlbXB0cyBhdCBIVyBhY2Nlc3MgdGhhdCBkZXRlY3QgYW4NCj4g
ZXJyb3Igb3IgdGltZSBvdXQsIHdoaWNoIG1heSBnZXQgdGhlIEhXIGludG8gYSB3b3JzZSBzdGF0
ZSBvciBkZWxheSB0aGUgYWN0dWFsDQo+IHJlc2V0Lg0KDQpJIHN1cHBvc2Ugd2UgY2FuIGFsd2F5
cyBjaGVjayBhbWRncHVfaW5fcmVzZXQgZmlyc3QgYmVmb3JlIHdlIGRvIGRvd25fcmVhZF90cnls
b2NrLCB0aGlzIHdvdWxkIHByZXZlbnQgbmV3IHJlYWRlcnMgZnJvbSBjb21pbmcgaW4gd2hpbGUg
dGhlIHJlc2V0IHRocmVhZCBpcyB3YWl0aW5nIG9uIGN1cnJlbnQgcmVhZGVycyB0byBmaW5pc2gu
IFdpdGggYSB0aGUgcndzZW0gYWxvbmUgSSBzdXBwb3NlIHRoZXJlJ3MgYSBjaGFuY2UgdGhhdCB0
aGUgd3JpdGVyIHdvdWxkIGJlIHN0YXJ2ZWQ/DQoNClRlZGR5DQo=
