Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AD4C19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAC910E880;
	Thu,  6 Mar 2025 01:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hyn6sOcI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE50C10E87E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po11jHp3tk2nixoSuRHbIi2YOgt5WcRTqlNwPEzJRlUzHaiBgX5OHhlvh1duNKgrsQigbH+os1Y0xVvWEMTn3fH9TNhISUMZX6LmWbv6+P1ZvxMqS3hqz5tU6nzGwA7Eihtl4K+H4vvBIloonVOfgHEO60G8N7CH4IaVLItjUZWnXaMlGeR5RaFdPTI3A/sfoxDnnYoNXDjtgrI/aeEOH23ioGSRxPSWjiyUDEOTkU9OaFU21K1b67ZMJLQs5sb8pAZ5GrflIikpPhBBMKr14Oy52rko7p8nrRo3Q7p37O6sno2sMMALwZcIwauFR16JNQbWtjvXJC98pv7RZtA20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WehoIm/nMPHw+vN4Jv6mJd5PsxTtyAT29WqGCvK3QCY=;
 b=DV7f7BIqXJMpy0QpoC8dfRfzFGQ5oLsqvOiLrDAmpOUl6EtRi0RYMcUNQiuUhKuJqDAiXGt40dCDgpSG7sXU9NjZxcbCK2PR4WcSSnKRz6i0Jzef8nOTO+HfVLBXRaBCuS5+8rw6hSWJpYlG6rTfLVhESdjYHDXo3lMmVgIw0sV7EuWBgHsG3SygClnNKvxiy08GMfdKEzn4FLTG8OaouPkCnyEi7yLK65/d71cDZsFKWvxSljDa+ZZEFfpL4GQJ3CkDfXqy5naUBCqkx3wsfhCeL/r1AA9XUfO05UtEhue4lqf+KDyXCsnznpBOYIeC+cmwTiyRB6J7hrUqUL8RQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WehoIm/nMPHw+vN4Jv6mJd5PsxTtyAT29WqGCvK3QCY=;
 b=Hyn6sOcIk647EUHsnZ65TnzW9tQIRrVD9c8QO6R7T4HI94+7Pc797yFgOKUSqestlXuA/1pWUaVcIU3VAiYsbAh2hlXw7IQxOWLlYv6L7UZ6ZOb85YkWvMLvjTPxWs5+6HJqM5hG4hej++g9fGAJWBL2CK8wJfmLkjyTBKRxhaQ=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 01:01:14 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 01:01:14 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the race condition for draining retry
 fault
Thread-Topic: [PATCH] drm/amdgpu: Fix the race condition for draining retry
 fault
Thread-Index: AQHbjjGj6PLF8BWBik2pAnfzrRwi/7NlR82AgAACPxA=
Date: Thu, 6 Mar 2025 01:01:13 +0000
Message-ID: <PH0PR12MB54170F6DC4424C324B78F8E48FCA2@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250306004932.3219705-1-Emily.Deng@amd.com>
 <a58319df-7f75-4757-973b-462aedd2b099@amd.com>
In-Reply-To: <a58319df-7f75-4757-973b-462aedd2b099@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7b545175-1a27-4564-8140-142e3097bb95;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-06T01:00:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA1PR12MB6628:EE_
x-ms-office365-filtering-correlation-id: 06e7bb34-2384-45d8-9b52-08dd5c4a6484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?N1FCUFpEa3hNWDUrQ0NTNXhidm5tcjY0YzFpSzN0YmJvcUVYTU5lS1VIcXM1?=
 =?utf-8?B?WWVsbDVjY1FWWHduV3F1WGRzR0ZQMDZNL3BlUE5Bb0JUajZMeTFUL1hmNVZU?=
 =?utf-8?B?aFhzUlFKdDljcG5hMjgyTG5hTDNKdVZ1cWl4THRHbVFETGRmZHdSR1dwRzgz?=
 =?utf-8?B?Vlo0MnIyVHNjOGRYeGhjY2dUTmJCQWpiOEw4eUE0anEzVnVYUEdwY3Jpd011?=
 =?utf-8?B?cGZUUHhJZllUNFlyVGJzS3Rib3pCQUZNMUNaRGpUcUJ1aS9nbXlFcVZzektr?=
 =?utf-8?B?RmQveldoZERjZHV6bkdWYVZndktSdnVZSTcvZkdiMGpiWHhIZHNTaXhCTnlE?=
 =?utf-8?B?Qkd2bzlWZWt5SXVaNHdzMFNZNm9vMS9NMjVNbGg4b3FQc2hMUGh5S3duN2x4?=
 =?utf-8?B?OXJJTCtXYm95QU5XS1pBeWZFYjN2ZlZzTkprL21LUmdOcjVjcmtmQkJtdlJs?=
 =?utf-8?B?RHJORVBqQ21Pa1BOdlVacXJTQTM1cGZEbU1mMHNvWU9iRHV6Y1d1UzRzcjZM?=
 =?utf-8?B?cTJPY1EvM0pDNzI3YmVUSGtFWHZmRXJZaUgxalZzYTE2WEQ4Qk5tZFRlUm0r?=
 =?utf-8?B?WDVSRFZBajY1VmVRWE5YY0JuQ3M3M1Q2dnlCM2pMR2lWZWZML0JVODVnc2Vj?=
 =?utf-8?B?SlI1WGM2Y01jMzNZb3cxUG1Nd0VySEVPS2RjckZ4bFdTdjZWeVhFLzV5UkN2?=
 =?utf-8?B?R0lUaU8rSjVBVjFNQVQvNUVSZi9iY0NZMjJ0b2pHLzJJbThiUlFGandUbzlx?=
 =?utf-8?B?VFgzT254WXE2VFltVTgzTWhXUC9DYU42TmZ3TS91SEJnVFFqcjJkRER2RnM3?=
 =?utf-8?B?OXM2eVJES05RcHp5Tnp5SVJlTmcweWtSZXJqOVJXaFkrT2hJRDJvU2xEN2Ix?=
 =?utf-8?B?bklhbjdad3JTSitUKys3L3k2QkhGYmpEdkZNVGtzSG0rTDBCMERFY2s3UWl0?=
 =?utf-8?B?WUM3VkNmMnVrWlY1T3JFdncwTzd3UWxqeFBSWDdjQm1UOHRFa0NHU04rUmts?=
 =?utf-8?B?SG0rUjZZc2p2QTN6a1dlSVZYclhzQWVvaEdSREhEOUlqamNiME1yQlI1YU9B?=
 =?utf-8?B?UUQxa095M1hCK0k2NEp0WTlSVFR5ZjR3dVBtbjVSdklDbW8wU0pFajUyV3Mr?=
 =?utf-8?B?d21VL3FFOHI0YjhxUERCUG9HaHpsVmJWamkxOXNzRGZ0ZUdGR2lFZ0ZsZ3d5?=
 =?utf-8?B?djFYLzkrMWtpYnJFV21Jb2t3aytSMW9ydnZBR1lVcUlZN1REUmJmekRmUFVQ?=
 =?utf-8?B?ZWQ2WFNib3RsSHdoV3hMZEo3VUE0cytHVVdwdVNzU3Y4ZXJsTFZ3d0RiTzQw?=
 =?utf-8?B?Z1Q4bDk4cDRTd21sTWZlQ3Ivb2dDN0lqclJqR3hiT3AyZkFmVmszVjd5ZEtI?=
 =?utf-8?B?U01GaFhTVzZURFlhZXZFWDZiUWF3bHA2WFdmc2tKUHlnWnptenN3NVN2ZVZn?=
 =?utf-8?B?V0J3UTk4bHFWT1Y4akpRRFFETGZvelN6VnQ0NlUwbVdneDlKYnRXMjYzNTZD?=
 =?utf-8?B?ZlZSRzNSMzM1VHppNEdRcEdYSHpyZEVxOWcyaDgyM3JwbVRVTGxGbVdwaXAy?=
 =?utf-8?B?UHBSaEhqaDNQdEVBUXhsTkZ5UHBSc2tDMFZCaHlYZ1owY255by8xdlBscjdE?=
 =?utf-8?B?cDlUdDJ5NnYwVFNoVlZWTVBPRDhaRDAvcCtrRmYrWFJFYWJJeTdVWHBkdldF?=
 =?utf-8?B?MzhEMEVtZDlwKzJWRU1TT3dOclZDR3hXa2hRaDhVVnY0VDVPbU8wUXpiUFJF?=
 =?utf-8?B?SERxeU4zdXlsMFJucXRVSk9TcGpGRkg5Z1RERHpiQzZiL2NYV0k0am13RzBZ?=
 =?utf-8?B?MzVsQ29kR3BvOFRzWWlpaFg3RlQxSGViVCtLQ2VzTC9hS0V4WElzUjZxSjNj?=
 =?utf-8?B?YTh4Y0htcUhUdzBXNEJ5dHpmUVd5TXQ5NE1rN2VwNVRRcE4va1AreDR1MzNw?=
 =?utf-8?Q?inrn4TnYXZno4yUjOKiLyuPejXS67+kZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGREVUErLy9vZDJnam1LNWI4VlhUOWtiU29kTnRFQlYrYm9Uc21WWFZSTlEx?=
 =?utf-8?B?UW1MWHZNQXo2V2x5RFVtSzZ1am9GWlhzTUIrc2VXb3lZNjE1WjMwbDhjVzg1?=
 =?utf-8?B?S2FNRFFMcDVKWUJQWG1rd3ZKU2poWDlSbXpKTThrSVdONlVyS3NFMnhZNFYz?=
 =?utf-8?B?VktpbXlZWHVzTmo3Vk5VMEd1WkpMTm5nMjRGZ3AyYmloeWUweGw2am45RG5H?=
 =?utf-8?B?TFJzNkhZRkp5ZTQrLzFvdGc2ZTh6U3E4MFdhSW1vSnoxT1VEUk0vOFdZS1J3?=
 =?utf-8?B?UHY2QXNZRC9OQkpWWlliK0pLMmh6VEg3UWUwamc2MDhpSjRIcmxwNE95aDAz?=
 =?utf-8?B?TlIyNm45RUxhZ1JQbm8ySkloYU82eFAxMHhwNFgxQXlXWlcrRFR6d2d2ZnFV?=
 =?utf-8?B?OXlXaU9ibkR4K2VqWWFjYjJLaUpNS255L1RkNmdFSHlPQUowMVpNczNoM1Qx?=
 =?utf-8?B?RVJUMHc0ZVVhYUFwYk10NjM2QThFQ1M5RUlkZDNHL0o2VXl3aUdaZk9Id3RN?=
 =?utf-8?B?c3gwbmtuMndvYytOV1hvemZVS1c5c1lKYkc5ZEo0K1B4eWhpZU1rR2Zod1Bs?=
 =?utf-8?B?Wmt0dmVib0daYi9rcWxUNWhPZmN2Z1hsRDZkamtqVTE2NmpZdzZ6Z3RrWm9k?=
 =?utf-8?B?V2RHODNZb0RmWCs4VzdEc2oxcXIzdlFaRy82Z3FXKzVFVzRFRTNoRE5Pcis4?=
 =?utf-8?B?VXNvVW9JMkJWZ1JMQVdJUTNSc0NSVUxjVXYxUjh0bGsxTmVzZWRMc3lmVXky?=
 =?utf-8?B?WWN0b0t4Tkx2RTA2dzUxMFdmOURTU2cxRHA3MGlwcVo4dFpYN3ZzL3lCaXRG?=
 =?utf-8?B?dkNjV1h1RVY0aFRqYXZkQ2Z6Mm80Nk1TcVJXM1VmalhXSVVQUS83ako2TFJ0?=
 =?utf-8?B?K0VTVndjWFl1MXRBVjJOYnBuTWVCRnNsWG1YdEJkTnc5MEpIenF6TnpaMTd3?=
 =?utf-8?B?MGk0NTl4VGZTc2tNUFB2bTVHcWNZTmNQOTI2eVY0Ky9BVFNTN0swMTVpM25s?=
 =?utf-8?B?a0dqQW1uT0lRZDVzNVBKNVMvd0NQYjJzbUhMZEZHNis5LzdRQWpyTkdNUzRG?=
 =?utf-8?B?cmdyWEgwZHhWM2pkcEY0YlZhdTczdjVkUmVwMVNSSm9wRTEzRjJDL1JKVzdV?=
 =?utf-8?B?c2M1Mk0vVWpJa2FYUHBNc2w1RXBOY2xJbEYrTG5lVng5UlBKcUNEaXZ2ZnRQ?=
 =?utf-8?B?LzVnUGpwRVZFcGp1ZUdUZUNUNTZyUGdWZkZJRStaZHFNS0JNQ0oxNEhOTTdY?=
 =?utf-8?B?SEd0clFOYkMwZG11TDRqWGtTOGJkam5mSlEzb051S0o4a0xrZ01nSGlINVk0?=
 =?utf-8?B?Y0FzSnYvZFNKdG5oMWZVSndzQzJMWXArNVZOUXlaUy9oMnhFYThTK2t5Tk5I?=
 =?utf-8?B?S1plMFp6YndhcFlzaXUyWXJLMklweVQ5d0lqWEFsVW9lcm9MMHg1TkFReUVl?=
 =?utf-8?B?Y2oxSU9KS2dpcFU5Z29CcmM1dkJVNVBsOHV2ajNOVHhkYmNLdC9OZk1UdXdV?=
 =?utf-8?B?NTBKRzF0RENKY1F4c0RTSU8za2ZCcTRnWDZ4MEtIZTQvMVVoa1pCdlVPM2p5?=
 =?utf-8?B?M0tsM0ZzejhETE03UEI4RnhPUmdsckVVQUYxQ0RCbllRSDhXNFU5MWQyblZy?=
 =?utf-8?B?ajlGVy9iRHlCa3RnUUNjeEg1eFpmVjhOSm8yVjM2ZFRCZGlBZ2tmUTJwcVda?=
 =?utf-8?B?THB5cUpjMGdpZUkramxMREF6UzZYTmIvMjNxV2xEQkcxTTIxNVJHdXZWaGZI?=
 =?utf-8?B?ejZDOFpCenFlUjB0QmluK1BWd0M1c2UzaW9HN2prSEUza3p4d2ZmVGNpM2ZD?=
 =?utf-8?B?SXU1TDFLMmppdzBaL2NaTyt2bVh3aHJqUFhrczdhYlhia3kzck5BZmRIY1ZR?=
 =?utf-8?B?V1JGbzRyVWRpSi9YK0pnekFZcDlINDNjMkhxSDRiNmFhVEFCa3Y5TExMN3Jz?=
 =?utf-8?B?SlFNTyt2VkVFUXRUMm9GT2U1TEo5dlUwSnNTMkROQ0ZRSTVncTBFNDVUYTlQ?=
 =?utf-8?B?cG1IVERramJDRUgvb0NzYmhLZFRPVlR2Y0NYejFMblUvVk5HMHVyRG80THhE?=
 =?utf-8?B?RmdUZ3dFTFJSWVFnVk1kT3dFSS85dEw3QjlGV0swVzNqdmRIck53SStYeUI2?=
 =?utf-8?Q?aZmk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e7bb34-2384-45d8-9b52-08dd5c4a6484
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 01:01:13.9627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxSe1skqIUuRZkv8KTpXq+pMD6QmKdImgTRnCi7nf9bfHOowRN0YyLDMJAZinKDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3VlaGxpbmcsIEZlbGl4IDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBNYXJjaCA2LCAyMDI1IDg6
NTMgQU0NCj5UbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4
IHRoZSByYWNlIGNvbmRpdGlvbiBmb3IgZHJhaW5pbmcgcmV0cnkgZmF1bHQNCj4NCj4NCj5PbiAy
MDI1LTAzLTA1IDE5OjQ5LCBFbWlseSBEZW5nIHdyb3RlOg0KPj4gSXNzdWU6DQo+PiBJbiB0aGUg
c2NlbmFyaW8gd2hlcmUgc3ZtX3JhbmdlX3Jlc3RvcmVfcGFnZXMgaXMgY2FsbGVkLCBidXQgc3Zt
LQ0KPj5jaGVja3BvaW50X3RzDQo+PiAgIGhhcyBub3QgYmVlbiBzZXQgYW5kIHRoZSByZXRyeSBm
YXVsdCBoYXMgbm90IGJlZW4gZHJhaW5lZCwNCj4+IHN2bV9yYW5nZV91bm1hcF9mcm9tX2NwdSBp
cyB0cmlnZ2VyZWQgYW5kIGNhbGxzIHN2bV9yYW5nZV9mcmVlLg0KPj4gTWVhbndoaWxlLCBzdm1f
cmFuZ2VfcmVzdG9yZV9wYWdlcyBjb250aW51ZXMgZXhlY3V0aW9uIGFuZCByZWFjaGVzDQo+PiBz
dm1fcmFuZ2VfZnJvbV9hZGRyLiBUaGlzIHJlc3VsdHMgaW4gYSAiZmFpbGVkIHRvIGZpbmQgcHJh
bmdlLi4uIiBlcnJvciwgY2F1c2luZyB0aGUNCj5wYWdlIHJlY292ZXJ5IHRvIGZhaWwuDQo+Pg0K
Pj4gSG93IHRvIGZpeDoNCj4+IE1vdmUgdGhlIHRpbWVzdGFtcCBjaGVjayBjb2RlIHVuZGVyIHRo
ZSBwcm90ZWN0aW9uIG9mIHN2bS0+bG9jay4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBE
ZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3N2bS5jIHwgMjcgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPj4gaW5kZXggZDA0NzI1NTgz
ZjE5Li5jOTljMTBlMjQ3YWQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfc3ZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9z
dm0uYw0KPj4gQEAgLTMwMDgsMTkgKzMwMDgsNiBAQCBzdm1fcmFuZ2VfcmVzdG9yZV9wYWdlcyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiphZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsDQo+PiAgICAg
ICAgICAgICAgZ290byBvdXQ7DQo+PiAgICAgIH0NCj4+DQo+PiAtICAgIC8qIGNoZWNrIGlmIHRo
aXMgcGFnZSBmYXVsdCB0aW1lIHN0YW1wIGlzIGJlZm9yZSBzdm1zLT5jaGVja3BvaW50X3RzICov
DQo+PiAtICAgIGlmIChzdm1zLT5jaGVja3BvaW50X3RzW2dwdWlkeF0gIT0gMCkgew0KPj4gLSAg
ICAgICAgICAgIGlmIChhbWRncHVfaWhfdHNfYWZ0ZXJfb3JfZXF1YWwodHMsICBzdm1zLT5jaGVj
a3BvaW50X3RzW2dwdWlkeF0pKSB7DQo+PiAtICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1Zygi
ZHJhaW5pbmcgcmV0cnkgZmF1bHQsIGRyb3AgZmF1bHQgMHglbGx4XG4iLCBhZGRyKTsNCj4+IC0g
ICAgICAgICAgICAgICAgICAgIHIgPSAwOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+PiAtICAgICAgICAgICAgfSBlbHNlDQo+PiAtICAgICAgICAgICAgICAgICAgICAvKiB0
cyBpcyBhZnRlciBzdm1zLT5jaGVja3BvaW50X3RzIG5vdywgcmVzZXQgc3Ztcy0NCj4+Y2hlY2tw
b2ludF90cw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICogdG8gemVybyB0byBhdm9pZCBmb2xs
b3dpbmcgdHMgd3JhcCBhcm91bmQgZ2l2ZSB3cm9uZw0KPmNvbXBhcmluZw0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICovDQo+PiAtICAgICAgICAgICAgICAgICAgICBzdm1zLT5jaGVja3BvaW50
X3RzW2dwdWlkeF0gPSAwOw0KPj4gLSAgICB9DQo+PiAtDQo+PiAgICAgIGlmICghcC0+eG5hY2tf
ZW5hYmxlZCkgew0KPj4gICAgICAgICAgICAgIHByX2RlYnVnKCJYTkFDSyBub3QgZW5hYmxlZCBm
b3IgcGFzaWQgMHgleFxuIiwgcGFzaWQpOw0KPj4gICAgICAgICAgICAgIHIgPSAtRUZBVUxUOw0K
Pj4gQEAgLTMwNDAsNiArMzAyNywyMCBAQCBzdm1fcmFuZ2VfcmVzdG9yZV9wYWdlcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZQ0KPiphZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsDQo+PiAgICAgIG1tYXBf
cmVhZF9sb2NrKG1tKTsNCj4+ICAgcmV0cnlfd3JpdGVfbG9ja2VkOg0KPj4gICAgICBtdXRleF9s
b2NrKCZzdm1zLT5sb2NrKTsNCj4+ICsNCj4+ICsgICAgLyogY2hlY2sgaWYgdGhpcyBwYWdlIGZh
dWx0IHRpbWUgc3RhbXAgaXMgYmVmb3JlIHN2bXMtPmNoZWNrcG9pbnRfdHMgKi8NCj4+ICsgICAg
aWYgKHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4XSAhPSAwKSB7DQo+PiArICAgICAgICAgICAg
aWYgKGFtZGdwdV9paF90c19hZnRlcl9vcl9lcXVhbCh0cywgIHN2bXMtPmNoZWNrcG9pbnRfdHNb
Z3B1aWR4XSkpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJkcmFpbmluZyBy
ZXRyeSBmYXVsdCwgZHJvcCBmYXVsdCAweCVsbHhcbiIsIGFkZHIpOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgciA9IDA7DQo+PiArICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4NCj5J
IGJlbGlldmUgeW91IG5lZWQgdG8gZ290byBvdXRfdW5sb2NrX3N2bXMgaGVyZSB0byBtYWtlIHN1
cmUgYWxsIHRoZSByaWdodCBsb2NrcyBhcmUNCj5yZWxlYXNlZC4NCj4NCj5SZWdhcmRzLA0KPiAg
IEZlbGl4DQpUaGFua3MsIHdpbGwgbW9kaWZ5IGxhdGVyLg0KDQpFbWlseSBEZW5nDQpCZXN0IFdp
c2hlcw0KDQoNCj4NCj4+ICsgICAgICAgICAgICB9IGVsc2UNCj4+ICsgICAgICAgICAgICAgICAg
ICAgIC8qIHRzIGlzIGFmdGVyIHN2bXMtPmNoZWNrcG9pbnRfdHMgbm93LCByZXNldCBzdm1zLQ0K
Pj5jaGVja3BvaW50X3RzDQo+PiArICAgICAgICAgICAgICAgICAgICAgKiB0byB6ZXJvIHRvIGF2
b2lkIGZvbGxvd2luZyB0cyB3cmFwIGFyb3VuZCBnaXZlIHdyb25nDQo+Y29tcGFyaW5nDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgKi8NCj4+ICsgICAgICAgICAgICAgICAgICAgIHN2bXMtPmNo
ZWNrcG9pbnRfdHNbZ3B1aWR4XSA9IDA7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgcHJhbmdl
ID0gc3ZtX3JhbmdlX2Zyb21fYWRkcihzdm1zLCBhZGRyLCBOVUxMKTsNCj4+ICAgICAgaWYgKCFw
cmFuZ2UpIHsNCj4+ICAgICAgICAgICAgICBwcl9kZWJ1ZygiZmFpbGVkIHRvIGZpbmQgcHJhbmdl
IHN2bXMgMHglcCBhZGRyZXNzIFsweCVsbHhdXG4iLA0K
