Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB032C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 04:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D79B10E03E;
	Wed, 12 Mar 2025 04:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZdmjHv8S";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7632B10E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 04:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9WXCEjvIB59tforKZfLfnXubZ43LtHWsII6AG4grigO8LOUbVvvpXwvm/K5ujEJm+Cwp2IuirhGVlOsQstQSN4+t1L33mmjC8+3Yhgqyp+/hhjxaipUnXqeHNuRvs+jD6qVoYB2ch6xr5KYqX/aLPx1QlmzvvOZ4FDu60pRnIv06ugLYNgtHN92ZmJCGaoObnGbydEnpj2cRSB1zIc6Z9hITgi+1/m9Gb9mPGC1sy6R7hLaqXJZEIybt4igqqAkCefr32/7H3qwDqo31vP13MJUwJ9OPE+j4IJyVFxvQq7jGCpnwwSxizNa/ZO+gWqOZ49JrniA7IYXT5aVFurCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUyh39UU/iXoFbmT2vOX7qkToQvLaVs7/zpkKx6IxLI=;
 b=RrTUUK2YuV3wEtM6G7zDK+id0Q6BDQAJUO/7zrKprL9/dhoqP4szzXrJDgo7iMWfhrixCcV2b2ZwV80+VW9JoMAoYK6PM6iHk2NfraR1f2B0lNpzsT/76QVoZ03EjnW4x34KZVRItn0Swn6PgvBLyWeWSdYS2W3fgem8QOcHRxTHwEsIBRX+bSgr75WUS8mISSGWra6Ub2ysQ3pRnUY8O2jnLLzbIBf+WbMwPfG0ygpLKRSAHK+eVI/pNOwyTCnrd3WaD6xfveN1LHaFT/QIrGkuwsDVkGsIJNXYB8U4Aywsne6kITYJFej5pg/3rTBt9EVFWbDvwNknJYRYQf57uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUyh39UU/iXoFbmT2vOX7qkToQvLaVs7/zpkKx6IxLI=;
 b=ZdmjHv8SDKueybPs178hpajSVaboo2eG0UmIlPZrzt0oxuLw3MRVZ60Q1bYDjgmTcvKyGFpMKyYSb3RXiZu+5k0Y3uWwF7QNlRSyu+dHsAKp1XZ6UvSBLLR7b48kZlATXrR1tcAowwNHjisJnm293XfxQ2H/Ik+WRD4uV2JQcPI=
Received: from BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 04:54:17 +0000
Received: from BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b]) by BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:54:17 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
Thread-Topic: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
Thread-Index: AQHbkpBSujmUCyLgeEW0IfXn9Z1GXrNuxBrQ
Date: Wed, 12 Mar 2025 04:54:17 +0000
Message-ID: <BL1PR12MB515858DD811E9D3FEC3C71938ED02@BL1PR12MB5158.namprd12.prod.outlook.com>
References: <20250311141711.1911564-1-alexander.deucher@amd.com>
In-Reply-To: <20250311141711.1911564-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7f850647-5994-4c5c-99b6-5b2811592bad;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T02:15:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_|DM3PR12MB9434:EE_
x-ms-office365-filtering-correlation-id: 5d6ac525-97db-4a68-731b-08dd6121f1b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?R3QxRGZXZ0IvNjhLTS82eENBUTQvdXlCVnV5Y1lxb3pzeENIMlljcjdiVDcv?=
 =?utf-8?B?TVRNeEhiT1M2aDUrQUVKYnNYUHpGT3hDZWt3bFllTG5ibkRRWkR3THl3YmFa?=
 =?utf-8?B?WkxMcUQ2NTljZG9DZDZSbnhrYkI2bjI5bWcvNGxENWpueFB6L2FKbk1KNE0v?=
 =?utf-8?B?alowLzBvcE91V01sOWRDYlNWODVJTGRJME5aQXhta1NGUGJJWVhiSGJya3B6?=
 =?utf-8?B?MmpwK1NxMk1VUU5DTzhoeFJYS29NbktDalA2VldtQnhPTytCTEhFNWF4RjJj?=
 =?utf-8?B?eHEzc2x4VzBxWFJJZExjenhSa2VRbWZKbkc1a3pUd0RNeHV2ZE1PdGhEODdX?=
 =?utf-8?B?SmJuTFcxV2llTU5lSlNYR2RFT2tuY2k2N3J1SmlvM2o4akJ5ZGtvd3hlVDJ6?=
 =?utf-8?B?YkJhY0s2NlN6cEROTVF0OGw0ZldTbTVIMXV1M3dkMnBwMzhZVHRsYytaU2Ez?=
 =?utf-8?B?M1lFY2ZqejEwMDFneWdUQXV5ZDNGSHl4aUNURFdWVnVoZnRjeFlILzBKanE5?=
 =?utf-8?B?TGl6VzVBbndKZXJUZzZIZzV2MGFMOWtKMHdoNFRmYWo5OEpiMXc3bmRmWGli?=
 =?utf-8?B?UjZmRVpHQ2ZaSE5YQ1FHSVJpb0Z2VzdVd1BrK3E3RHc4aTg5ZUJDTzlZTWdD?=
 =?utf-8?B?MElYeUI0emRpWCtmaVd5WHRCUW85OWdpQ3phTkZaeWhvcWJjcnZSNkZMMEVt?=
 =?utf-8?B?UytFVDYxR2xnenZqdFR4R1V1T1VnOU1zcWhJV0J6Y3BhVE1aYU1aQ3FHdWV5?=
 =?utf-8?B?QlRwVXAyTE15aFhmcTdYWjhYRERwaFdGdlJ4RGFCWnNaN3RsSE1kb0Vvd1hV?=
 =?utf-8?B?bUVET0t5a0s4TitHYXE5Tm9BZFFyM3ZBZE5aZ1BrMVFTekROZ2wzYWUrS0F2?=
 =?utf-8?B?VU84U2QwV0tzV3JDMExjYVdpTDM0OUpCRWxoR0JmZEJrQjRsenU4UmZJR05Y?=
 =?utf-8?B?dHpVQXZETVQvZWwrV0lvMFhaM3MycDhEdGZpemFkS0xjZy9TZW0xeDZISjVz?=
 =?utf-8?B?YWxGRjBrWlN2RFB6TGZLUlJMN0tBanBsd0Q0YmJYb3lhS1BaL05KaS9MQnhs?=
 =?utf-8?B?aVBUTEN3RjBtaTVUS1FXRmJEcjBMemVxSURkUHd5U05Hb09GRkIzRnVFTS9B?=
 =?utf-8?B?QzRGZzBLRzFHbzJwdE9kajV0aUs1TU1ZdUZqR3RYNkErOXFLQkQ3MXZ0SjBa?=
 =?utf-8?B?Z3pWY1kxUURoNjZCdCs0elpOSVhzT1BPNk1UdjI3WXBhWEt3bGJzQWZkVnc2?=
 =?utf-8?B?UzZVM1FLYzVvakNhZElHYnpzd05OcUVFSlI0eS92cTI1bldObmxuR2RVRXNQ?=
 =?utf-8?B?cXBRMjQ5UlRybEMvM2ZXSUExTmFzaWJ2RFg3MnF4elFpOUhjVXdIOXI0T2Jr?=
 =?utf-8?B?aktFSENjV3ZRRlAyVGk0azdOeGJuUjNtQ01QWTJQYUNJRFN6cHprNEhsc2NW?=
 =?utf-8?B?a1VoVjZxdkp3RVBOeE4xdVlOcEhoSm0yOTlaNE9IeVR6VGJLTFhCeERxcGxj?=
 =?utf-8?B?N3EyQXpDN2xsdXpKYkdWSFdpb0pkaWtoVkthN0pSVlNJVXJ6Mng0NVdmSGRj?=
 =?utf-8?B?Q0JZbWJGOTdUK2orYWFTUVhMZWJIMFVudWJjbkJPNEM0K1V0NmRyRW5udFhP?=
 =?utf-8?B?SHVrY29iVzVCU1RRR1cyS3BFRzB5Tno3RDI4aVNxWEROejJ5aDZNV2NEcWJ6?=
 =?utf-8?B?cS9pNVlxNW1xMVBkSGExTk9YaDZZU3pLQjQzYVdsQm1Uc1FPQ2tYeTRneUhi?=
 =?utf-8?B?c0pmZFpMUURXYW95VVNvTGNLUUpITm5XekhGeTRaQ1JncVBJVzQvdFB0bzl1?=
 =?utf-8?B?NWdnVFUyamxFUUQxakh4dk83VGUzdFpwSTE2VFlWZ0F1MzM1SHVjMmh4NE85?=
 =?utf-8?B?OUlFMXhqSzlFdmtWR2UvTlhBS01TUzZSMEd5akh3SmV3bmdoZER5L2tiQ1d3?=
 =?utf-8?Q?HV3VJnFWuoBtIYgjCxX/x/PLjbZ1PQ33?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3E5Sk11aXd3YnBZRFhQK0xielZwTlJqaXhZN2VEZXh4ZkszSndPNERSU2V4?=
 =?utf-8?B?U0kvOWJyQjdITTZBQUFVUVJpcWxwSXpGTlc4WTBNN0U1SW5mUE5UNXE0bjh2?=
 =?utf-8?B?UERkWDVsc2FGTHdwbmtYa1lsb2JtNVVOL0FUaUMzc1RqNXIzRUdKWnNtTFRl?=
 =?utf-8?B?WTB5aUZvRENVdmlZV2puWXByVU1ZbUlESTY0UnIwZnZWS3UzekdSVndzaHJo?=
 =?utf-8?B?aG1USWE1eTZkbGJ1aHUxZTdzajFtVFFJc090bk1qSVJ1RzNxZzBsRkNrTldN?=
 =?utf-8?B?ak00cTA1NzAzaFV4VzNreHVuVmt1V3MzZWcwMFExSmFjRzB4YnpQTC8yZll5?=
 =?utf-8?B?YTdhZWVmNk1JMWVlSmtIOUNpZlFCQjZJWGU5b2hBTzBmbFNWNTZ4NzZQODNM?=
 =?utf-8?B?TDcrbDZuNnd3TDJmdFFxNjVOQjBITUEzVHNJb2VidjBGS3R4WE45ZGxVVWVi?=
 =?utf-8?B?bU1vQTJ4Z05YUEVpVml3b21JQjQrcDRWY0ZHM2xMU0VRVkNaVnY0U01NeHZt?=
 =?utf-8?B?Umk0dUkrLy90a2QyYkh2Vm95R2RHNjdQMWFaV0VKdDFQUGJsc25uWW03RU9r?=
 =?utf-8?B?dk5VeXZ1NnZqWVdNTWpxOC9PODZNZ3BGYkV2T0NjMVkzTS9SN3BLanBINVlz?=
 =?utf-8?B?Vlp3dUFlYWlYOC9oWm00MUxVQkF6SW82SUd4ZmdDcWkvaFZhUmVSSkVZbkJo?=
 =?utf-8?B?ZjUyS2s2d25GMkhPZ2tSOG9kcVlFZFF1cW1Heks4OGlKVTExVlNrYlY0MTZT?=
 =?utf-8?B?WXFrc003Vy92MmRxM09uNzFQY0J0SUEwZ04zUTcvMCtEUlVWWGdOTXhtbnpZ?=
 =?utf-8?B?bVR0TXpERUE3djhMUTRnTlN4dHczMCtkVE1Jako3U1VSVThhdm5MQUlzc0Zp?=
 =?utf-8?B?dk94SU1ERU95Y0lEVmlSRzM2ek5nd1hobG0yc1ZvcVo1Rk8rSm1xTFQvSnJP?=
 =?utf-8?B?ejVyMkNJa3M5YzVydGpvTEhYTnBpSE0xR0hoblZ5bkw0MVkxRVpxS0hzS1lE?=
 =?utf-8?B?U3g3QjVLMlZqY25DSVVMb3d3eGtXWm45OGR5K3QyYi9OczMvaW0yYm9Db1k5?=
 =?utf-8?B?S3phbFd1Z0tBTytFQjVBSElJZ1ZWSndMdE1wRld3OU44TTZDaUgyUnJXbGRn?=
 =?utf-8?B?NSsyMGlUWVRYbnVOZmk1Yk1xaGs5YUxYNFROQ2V1MVlQY3JNRTlWZTBCVUlr?=
 =?utf-8?B?SHN3R3NHYlBqd2svdHZYZG5xWHJWbXRsVVBhalFmUno4RHFXNExSSEZCRUl1?=
 =?utf-8?B?Y1hJcmNKV0tjek5lTm03NlRHYWtKSEgwVzcwQVV1V0YvNERCTms4cTg1Ti8x?=
 =?utf-8?B?YThNK2xodnpBVVJsS28xeUxXVGQzOHVXQnI2UVUyaFFiVnFzcHFIN0E4Nm9x?=
 =?utf-8?B?SEZKSkJRRWl0bmRMUm9BUHpYdVZzMjBVWENCWms2aFAwY1orWFpodUtkMjk5?=
 =?utf-8?B?ZzhSYTRSUE0veXBlYUxSbVFDb0FwWVAyc1pOZUxCTDN6blNjcjZ3d25LWmQx?=
 =?utf-8?B?K0xvQ25ndU5UNU81b3ZkeWtYWUpEYXV1OGR3eTg1NjhQTHFHQUlEQXdwbkFI?=
 =?utf-8?B?ZFN4M05hUzgwdExmbW1mc3Z2QW0zVER3ODFNS1hNQTAxbzQwaEtZMnRtTlRl?=
 =?utf-8?B?U2RJTk9WWS81ODQ4OFpsbWxFeDhkWS9EWTNzWTljVlRqVnlFOTFyT0dkaEFr?=
 =?utf-8?B?ZmgzZlMvSmg0QnJoL3E2bzczL1JGcjQvRTlUN1NTaFNxdG1haWVqOEExQytk?=
 =?utf-8?B?WXgrdExFYTRSdkIrais0dU5kL3RnSUV4QnVRK0FMUGY0U2VYTGtXejdjanFP?=
 =?utf-8?B?a3RwbzMxQmR1S0QxSnpDek92RVNERUQ4RzluUjhrejVQNGtXMFVtck1YbElF?=
 =?utf-8?B?blFKZnBVdFlTWlV5M3I5bVBvdi9TNmw3UmJyQXZ3cWw4bEt6aTR3K2dpaEJz?=
 =?utf-8?B?bG5tM0phaGJKMkpIb05zMnBna2k2cXljblIxUlY1NDV0TVNjQ0RRcHE1Sjlj?=
 =?utf-8?B?cUJQa0VXTlVkZnlMRDZFNko3SWpOVTAzVzBIL3hzaG9uLzh2QmErZEM1cUpa?=
 =?utf-8?B?OG1mNW1iZGRPYnZlVFU0aVVRZ3k1QWp6c2RscS9RZkFRWUticG1OcWQvWXdX?=
 =?utf-8?Q?ENr8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6ac525-97db-4a68-731b-08dd6121f1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:54:17.2913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxaKzugPxKt7jMBqaqcdzwi4v4yRlZOzPiSeL2U1uXRo6hOp/8GCjV1S/Phg4KGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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
Cg0KSGkgQWxleCwNCkkgdGVzdGVkIHRoaXMgcGF0Y2guIEFmdGVyIHRoZSBkZXNrdG9wIGlzIGxh
dW5jaGVkLCBhdCBhIGNlcnRhaW4gdGltZSwgdGhlIHdvcmtsb2FkIGlzIHNldCB0byAzZCBmdWxs
c2NyZWVuIHR3aWNlLCB0aGVuDQpUaGUgaWRsZSB3b3JrZXIgY2FuJ3Qgc2V0IGl0IGJhY2sgdG8g
Ym9vdHVwIGRlZmF1bHQuDQpJcyBpdCBleHBlY3RlZD8NClRoYW5rcy4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KU2VudDogVHVlc2RheSwgTWFyY2ggMTEsIDIwMjUgMTA6MTcgUE0NClRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcu
V2FuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpTdWJq
ZWN0OiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1L2dmeDogZml4IHJlZiBjb3VudGluZyBmb3Igcmlu
ZyBiYXNlZCBwcm9maWxlIGhhbmRsaW5nDQoNCk9ubHkgaW5jcmVtZW50IHRoZSBwb3dlciBwcm9m
aWxlIG9uIHRoZSBmaXJzdCBzdWJtaXNzaW9uLg0KU2luY2UgdGhlIGRlY3JlbWVudCBtYXkgZW5k
IHVwIGJlaW5nIHB1c2hlZCBvdXQgYXMgbmV3IHN1Ym1pc3Npb25zIGNvbWUgaW4sIHdlIG9ubHkg
bmVlZCB0byBpbmNyZW1lbnQgaXQgb25jZS4NCg0KRml4ZXM6IDE0NDNkZDNjNjdmNiAoImRybS9h
bWQvcG06IGZpeCBhbmQgc2ltcGxpZnkgd29ya2xvYWQgaGFuZGxpbmfigJ0pDQpDYzogWWFuZyBX
YW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KQ2M6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5m
ZW5nQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4
LmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2Z4LmMNCmluZGV4IDk4NGU2ZmY2ZTQ2MzIuLjkwMzk2YWE4ZWM5ZjYgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KQEAgLTIxNDIsMTIgKzIxNDIsMjUg
QEAgdm9pZCBhbWRncHVfZ2Z4X2VuZm9yY2VfaXNvbGF0aW9uX3JpbmdfZW5kX3VzZShzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpDQogICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9rZmRfc2NoX2N0
cmwoYWRldiwgaWR4LCB0cnVlKTsgIH0NCg0KK3N0YXRpYyB1bnNpZ25lZCBpbnQNCithbWRncHVf
Z2Z4X2dldF9rZXJuZWxfcmluZ19mZW5jZV9jb3VudHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpIHsNCisgICAgICAgdW5zaWduZWQgaW50IGksIGZlbmNlcyA9IDA7DQorDQorICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX0dGWF9SSU5HUzsgKytpKQ0KKyAgICAgICAgICAgICAg
IGZlbmNlcyArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+Z2Z4LmdmeF9yaW5n
W2ldKTsNCisgICAgICAgZm9yIChpID0gMDsgaSA8IChBTURHUFVfTUFYX0NPTVBVVEVfUklOR1Mg
KiBBTURHUFVfTUFYX0dDX0lOU1RBTkNFUyk7ICsraSkNCisgICAgICAgICAgICAgICBmZW5jZXMg
Kz0gYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0p
Ow0KKw0KKyAgICAgICByZXR1cm4gZmVuY2VzOw0KK30NCisNCiB2b2lkIGFtZGdwdV9nZnhfcHJv
ZmlsZV9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspICB7DQogICAg
ICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0NCiAgICAgICAgICAgICAgICBjb250YWlu
ZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9kZXZpY2UsIGdmeC5pZGxlX3dvcmsud29yayk7DQog
ICAgICAgIGVudW0gUFBfU01DX1BPV0VSX1BST0ZJTEUgcHJvZmlsZTsNCi0gICAgICAgdTMyIGks
IGZlbmNlcyA9IDA7DQorICAgICAgIHVuc2lnbmVkIGludCBmZW5jZXMgPSAwOw0KICAgICAgICBp
bnQgcjsNCg0KICAgICAgICBpZiAoYWRldi0+Z2Z4Lm51bV9nZnhfcmluZ3MpDQpAQCAtMjE1NSwx
MCArMjE2OCw4IEBAIHZvaWQgYW1kZ3B1X2dmeF9wcm9maWxlX2lkbGVfd29ya19oYW5kbGVyKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiAgICAgICAgZWxzZQ0KICAgICAgICAgICAgICAgIHBy
b2ZpbGUgPSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFOw0KDQotICAgICAgIGZvciAoaSA9
IDA7IGkgPCBBTURHUFVfTUFYX0dGWF9SSU5HUzsgKytpKQ0KLSAgICAgICAgICAgICAgIGZlbmNl
cyArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+Z2Z4LmdmeF9yaW5nW2ldKTsN
Ci0gICAgICAgZm9yIChpID0gMDsgaSA8IChBTURHUFVfTUFYX0NPTVBVVEVfUklOR1MgKiBBTURH
UFVfTUFYX0dDX0lOU1RBTkNFUyk7ICsraSkNCi0gICAgICAgICAgICAgICBmZW5jZXMgKz0gYW1k
Z3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0pOw0KKyAg
ICAgICBmZW5jZXMgPSBhbWRncHVfZ2Z4X2dldF9rZXJuZWxfcmluZ19mZW5jZV9jb3VudHMoYWRl
dik7DQorDQogICAgICAgIGlmICghZmVuY2VzICYmICFhdG9taWNfcmVhZCgmYWRldi0+Z2Z4LnRv
dGFsX3N1Ym1pc3Npb25fY250KSkgew0KICAgICAgICAgICAgICAgIHIgPSBhbWRncHVfZHBtX3N3
aXRjaF9wb3dlcl9wcm9maWxlKGFkZXYsIHByb2ZpbGUsIGZhbHNlKTsNCiAgICAgICAgICAgICAg
ICBpZiAocikNCkBAIC0yMTc0LDYgKzIxODUsNyBAQCB2b2lkIGFtZGdwdV9nZnhfcHJvZmlsZV9y
aW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpICB7DQogICAgICAgIHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsNCiAgICAgICAgZW51bSBQUF9TTUNf
UE9XRVJfUFJPRklMRSBwcm9maWxlOw0KKyAgICAgICB1bnNpZ25lZCBpbnQgZmVuY2VzID0gMDsN
CiAgICAgICAgaW50IHI7DQoNCiAgICAgICAgaWYgKGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzKQ0K
QEAgLTIxODEsMTUgKzIxOTMsMTcgQEAgdm9pZCBhbWRncHVfZ2Z4X3Byb2ZpbGVfcmluZ19iZWdp
bl91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KICAgICAgICBlbHNlDQogICAgICAgICAg
ICAgICAgcHJvZmlsZSA9IFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEU7DQoNCi0gICAgICAg
YXRvbWljX2luYygmYWRldi0+Z2Z4LnRvdGFsX3N1Ym1pc3Npb25fY250KTsNCisgICAgICAgZmVu
Y2VzID0gYW1kZ3B1X2dmeF9nZXRfa2VybmVsX3JpbmdfZmVuY2VfY291bnRzKGFkZXYpOw0KDQot
ICAgICAgIGlmICghY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT5nZnguaWRsZV93b3Jr
KSkgew0KKyAgICAgICBpZiAoIWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+Z2Z4Lmlk
bGVfd29yaykgJiYgIWZlbmNlcyAmJg0KKyAgICAgICAgICAgIWF0b21pY19yZWFkKCZhZGV2LT5n
ZngudG90YWxfc3VibWlzc2lvbl9jbnQpKSB7DQogICAgICAgICAgICAgICAgciA9IGFtZGdwdV9k
cG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGUoYWRldiwgcHJvZmlsZSwgdHJ1ZSk7DQogICAgICAgICAg
ICAgICAgaWYgKHIpDQogICAgICAgICAgICAgICAgICAgICAgICBkZXZfd2FybihhZGV2LT5kZXYs
ICIoJWQpIGZhaWxlZCB0byBkaXNhYmxlICVzIHBvd2VyIHByb2ZpbGUgbW9kZVxuIiwgciwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb2ZpbGUgPT0gUFBfU01DX1BPV0VSX1BS
T0ZJTEVfRlVMTFNDUkVFTjNEID8NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJm
dWxsc2NyZWVuIDNEIiA6ICJjb21wdXRlIik7DQogICAgICAgIH0NCisgICAgICAgYXRvbWljX2lu
YygmYWRldi0+Z2Z4LnRvdGFsX3N1Ym1pc3Npb25fY250KTsNCiB9DQoNCiB2b2lkIGFtZGdwdV9n
ZnhfcHJvZmlsZV9yaW5nX2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KLS0NCjIu
NDguMQ0KDQo=
