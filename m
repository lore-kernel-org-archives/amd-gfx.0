Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3379CE8D7B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 19:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5279410EAE6;
	Fri, 14 Nov 2025 19:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j9mBBym0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAF610EAE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhARX3lGjsXQHYz9mXedRMY6oR8jhxej6vh3c+QnzkYaVhjIAZ32cSUZJDvnsjXzZgfxQghViw9vgEv0p1M0sPQChs67e12YtoLwG2GgpTUkS2Bt/HO+vpuYe8Q/Umjb7sDGnj6WJWHznvfpy2LboSIlv00oWoXJSd9KLW+nSLCHAWYEg6JR4Shn1olLCqBeej3iPUbU8d3GmenI9498G7mfzeis4MLN1jsNJXfDxwW5LXsEINwKF/zLuOsTj3Maq+axJIjhPNs0Eq7XqyXizgBxiQcCnVh3Nrb0I778ZwONixSFyaSLLDnPrMQPkVRptLZq/pDRLMjiO4eCxaGDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+4Bxd/VwOJ1OOYCg7ITfPZ9OedJj05S7zlmVBfqOdk=;
 b=eAC85mFzzsbZFNsEtivFTPo0BOWOn+Tx0lOp55WrzE/R0A41iRfnYZZqjz36qNgsbEBdZ8ml4wRWTED6NwQnkHaiKz2O4OKFYXbrarrpr1kQuIJiBXa8N9alBynZVpuYTi3NWrJBZWbNndDP4hmKCDBUsXQBoMbOrWaM7dLNDjGm7Ymot1yChbaUDVKvlK8+x3eG6/3EQh4T5hFe4mvmILyRCc4joeIwD0nF2SPhMBm0M41f35Ump8zptC+YNWqUI05j52lkahevRqHqXQL8FABAz0Y0lNdKjMa/cJiLWu6/3qm5ZS7iqMsqKkT14VRCYLJ1gIl6Mi5seFgHUrpu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+4Bxd/VwOJ1OOYCg7ITfPZ9OedJj05S7zlmVBfqOdk=;
 b=j9mBBym080ckw9eNYOvggFblNigSn6Q3OK3+w8zN3fmQCLdD2Z0x3dIlf3PJ8qZqkvEjlI/j9iYWmVz/VwE6lXfbplJ1dlP9H6JRPwbrL0LkDchkJAZMQPAmS5fiTHqCntrdFQ7n+s3Mmbc7087JlX9AvMAZ357P83pgQGF1jHE=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 19:15:35 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 19:15:35 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdkfd: Ignored various return code
Thread-Topic: [PATCH v3] drm/amdkfd: Ignored various return code
Thread-Index: AQHcVMvS1sRGpXPZLkG+kJgpWwWcIrTyhjyAgAAEIeA=
Date: Fri, 14 Nov 2025 19:15:35 +0000
Message-ID: <SJ0PR12MB81383ED01D8A68C2AF19269EF5CAA@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251113183155.1120872-1-andrew.martin@amd.com>
 <34a397c8-bb8a-b7a4-372d-14d335c1e55e@amd.com>
In-Reply-To: <34a397c8-bb8a-b7a4-372d-14d335c1e55e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Philip.Yang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-14T19:07:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|DS5PPF6BCF148B6:EE_
x-ms-office365-filtering-correlation-id: 01b3fdbf-e50a-47ca-10b7-08de23b23024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M0p4cnVRejVRUDIybUpLalVKZSs0bURxWUp5bWw3M0pKZWthM2JhRWJUSEZW?=
 =?utf-8?B?Z25tVExURTRpVlJKT3pJYVY0WG4zWDUyMmpCRzlMK3J6UEtIOWp0MnJPNWRq?=
 =?utf-8?B?dzlQNTl0SVBraGxyY1dCcXBndWhPZXBzanlveDVza0txbEhMMXQyTm9IN29I?=
 =?utf-8?B?b2FTQlp2NlJNR2hiUVlZdzFKazBRdzBaZ01DS00zSEw4Ykl1aWp3UEY1NmdY?=
 =?utf-8?B?VlkvUm0veGM4QUtwdHR6SFFkT3V1VG14WWJyTzRZcGQralRQNlY2K3pLRS9j?=
 =?utf-8?B?N0U0SENNUjNhZ2VXN2Vkb1pNUnZwZk0zZS9YWUR1bFhWb0hRSlFianE2dUUr?=
 =?utf-8?B?bnJJdFFMVWdwS3UvRG1nMFVUZFROcTJHL0tFN3kyNHloelRaQ0FCZDhNWFpE?=
 =?utf-8?B?T0loNm9USlNPY1p6SXlyTFg5TXVtNXdHSjh4ZHZ5UEUzN29Odk42NUZDbXNM?=
 =?utf-8?B?OU1GZ1hHK3VwVnVBeUtPSFdINnplYldNU2M4TzBxWEdyU2ZjQmltL0UyRmdT?=
 =?utf-8?B?UTZvSjNpUXhpUnRGQzB6NmRGQlF2b0NmWm1jOWVBOXFMMGZjczBZUS9VT0dN?=
 =?utf-8?B?d2JGRERlV3QvMi9nVzc0WkRLcW1PTkdEbjRpeFppcTlZdVo2SEVLeUZ6Q2Nz?=
 =?utf-8?B?NWdEWmJ5VWlFdU43QlpmQzYxSHBOQTgzdDcvQXQ3Rk9rWWFzY3hkUjllM2dw?=
 =?utf-8?B?RzZuR1Q0bWRZNC93RDF6MlhOd3ljdVYrQnRPL0ZIQWhtTGkxbUtpR01sRU1V?=
 =?utf-8?B?MGxqSTh5YXRvME93bU9sMGowdGtObmNmUjdrTlNlanpDM0xBMXpoZVA0Z2lV?=
 =?utf-8?B?elh1TjJOS1pTSVZPbFdwZ2l0M21hbGtGZGEwRGFpWWc5VVpaMG8wdTIwZlhJ?=
 =?utf-8?B?UTYrNFNSZHNBSGQ4VVFRN2hZaHFjQ3J2NjNvTFRJYU1hQitIUFUwcUZ3anZx?=
 =?utf-8?B?RTJRU0VoSTg2VmhCTHd6MThrV3ZnTitUNG91bFFXdHdLc2NOOE9Ta2hBbHlJ?=
 =?utf-8?B?M0xiNHBvVm1LL0NIeHdpM2JTV0JwUlNTdnY5VllMWTJRT1pMWWE2VXZDSVZa?=
 =?utf-8?B?NERRL1JGRzBYR0pCVlU3SmpKNll4WWVQa3dTUWlNeENUYjFhOE5zNVRZUk5k?=
 =?utf-8?B?UlBpdjhqM2taT1dtOVU5NUtZNDUzSkVQeHBWZ0RTNGpmbGRoSjZSTEZsekQy?=
 =?utf-8?B?NDZWSEJUR3NzbG9iUkRVTjVUK3MvTmJnWEo3OGlpMXVKTFhERDBtb2k1RzYr?=
 =?utf-8?B?bm1hS1gwV2VzZ1hGT0FGZlY2M25jWFFqcnFtZzN1WTdIcHAxLzR5RFM2cWhj?=
 =?utf-8?B?Vi9jR0NHT1RTSW1ORXBSUDRRQ0JCcklUNGw0aFlPdkxINVV2K1Zta2piZFpU?=
 =?utf-8?B?MUZrMS9zRTE5SlFiNEZzUG9OV0pyR05ydUJ4YUlDUHozV2xiY0NxWjg5MTly?=
 =?utf-8?B?T2hNb3RmKzNqeFNUZHppWmNEQkQ0djJHWmtmdHZNUFNHVklSeG5MQ1BYUWdY?=
 =?utf-8?B?amN4WGRyV2JCYThlUERXVGlabmpMQWFISDAwRUtyd3c5ZnpOUk1WZ1AwVmlH?=
 =?utf-8?B?ZnZQbVp2cjJXeVRudTRScXVNUThYdXZuK202bkFKN29lYTFTcHRzb0FDT1Jh?=
 =?utf-8?B?OFkzeTUwSnRMNnpDMCtKRVdMa015eDJ0TG02ejNtcFJRM3lMUlRkN05La1Iy?=
 =?utf-8?B?VzJEQlJoYWdSa3BQYkd0bmdiSWxiS0hNWi9yeW1qRzVlVm1iNEloYzVYNmF6?=
 =?utf-8?B?Z0FiN1pzZW1SbzNobkowMXRIcjIwaWlkNkJSeHpSdGM0MW5McHZ3WXFlYVdx?=
 =?utf-8?B?cFpaSFNCdFRvcHVDMmxPRVFhVi8yUmN1TGdtWEcwOFZ4UXlFbXRwOTE0amk2?=
 =?utf-8?B?YnRpaHVKYVRnTzI0UjVEcnY3RVJ5eWxSVnRWVU9Pd3JOdEJiTEM4MFBOYStv?=
 =?utf-8?B?WUxWaFdyeEEvOGVXbTdoclR0RFZCeXRpRXA0VWtEaXhrSTVHMWgxa3JRaE1L?=
 =?utf-8?B?SFE5SHgwaHJ3VUtEZGwrdVlwQVVrSmIwZ2YrayswQWxubjVaaXNXU3dFbEJu?=
 =?utf-8?Q?35HMmG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hqTUsyMVNGcnhFcWl1cG10d2NFZjl3SEdscDJURlk5cXBLVmJyanZ0UW5W?=
 =?utf-8?B?L1lrb29vTkNIam5OVFhUdjNWQTZvWklUUDRrNUNRalpYNkJHeDJWbWhaTW03?=
 =?utf-8?B?TmpDbjUrL1k2SWduOVVSbGpBc2VyOWVxSUgybHRUbnVFZGt4U3BYcWVZY2pQ?=
 =?utf-8?B?RHZmeVYycG12YmRqRjZBd2ptRHdaQVpaNGJ4NkczOGRzSG43Mmx2TCtwYis4?=
 =?utf-8?B?YWpPZ1ZkNk5ybFB5TFdEWTg4R0o4TURhRThrekhYb1d4dU1PTGRaSDJkRHYv?=
 =?utf-8?B?dEsrY0N0RHBuYUNiVWlWK002K2dDZHFVRGdJcmhEYWI2ZVk5T2NRdEdWYUla?=
 =?utf-8?B?NEdDaDhUejF4ZEVUNi9DcVBuT3hRbUhkRlRLQzZ1eFZCdE1UNHFrbU9HKy9p?=
 =?utf-8?B?QzV5UFd5d0dHSlpxSTB5WUhZL050MVd6c1FjbUZFcUQ5MmV2ZDduZlBvY0U3?=
 =?utf-8?B?SFp5TURDTWF3MzA5elBqRWVOUFZyY0pPWGZBSGNZOUwwc2t5UzdibDN1V3R1?=
 =?utf-8?B?YzROc3B0QlZKdmFKN2k5NDIzZmNBOVBFVjdqWnEwelArU0IwM2F5Tjh3T1hV?=
 =?utf-8?B?MkhtdzRTV3FCUnJuTm4wRjNBUXBubTkvdlF6anNzanBvMVJoWnJmTTVTbWZZ?=
 =?utf-8?B?WTZzRmMrT2xHbFZwZzVkLzVQTUl6amhLSGFqdHc1MVE3VmRNZVpTeWtDdHFW?=
 =?utf-8?B?R09lTlZBWXdXQnhDRTNUaE5hMVZKUUsvazczSnVhZEVoM0IwNGMzY3VVdjFT?=
 =?utf-8?B?SVd4cFFYcnNZbWpqOFhoOGFtd29lN2YxQk8yRDV4NGR2REorVHloczJuYVJi?=
 =?utf-8?B?V3p5L01FeFZRa1FIZ0ZzMGFqSkxnYjBrVWo4RjFqTVRCQlRiTFYyd2t5WUdw?=
 =?utf-8?B?OU9PUVpXdXhHZXdMYWZEY0JHTWU1REhNc2E2ZXFXZnJtMEdTbWJYdnFFL1hP?=
 =?utf-8?B?enE0QW5YSm1uUExKZ0YvVVpOZTVpZ0s1b2pDbGpnREtnYkwyOHVaejRFdGlV?=
 =?utf-8?B?KzJnSkhKK3BZUG5KeEViWnl1c3h2c1VSbzlyU1RZb2gyMjIvNWk2dnM3R3hG?=
 =?utf-8?B?aGF6Z0FQRXE5dlhQYjdDZFFkdkJYSEdXK3grSTk0cFlkc21wbmttYmk3Qzg1?=
 =?utf-8?B?a05iSEloL3FpaVpXbU13MjBhUXl0WmZJbENYOEN5NmdCMml1c01DSktqeWpm?=
 =?utf-8?B?dDdPTWQ3NXJBOFJjYy8wS3RtRWdtWGY0Sy9mUU9NQ2Jyc3RnNjRra094OTlU?=
 =?utf-8?B?dGR3ZkVTcGVvYUZYMUlNNXl1UmFkM0orM0hZcDVxa1dvWjJ3OXYxRUdNYWZT?=
 =?utf-8?B?aUYyZ2hHSDBwUndYVVY0RXNralRmQlN5VlNFSm02V1B2WVlHbzIwTEd6RW43?=
 =?utf-8?B?VXJvYXFOMDVBWnFkM2d2ZDAzWUUxTzRtYWFPSEFQdUNUa2cyMlA0T1NSNkdz?=
 =?utf-8?B?K2g0ME5xejhqQ0w0eFRoYlh6UWdhNmtOOTVxalV4VU5hd2hobk5vL25MU1VF?=
 =?utf-8?B?aUxlZHJjdG9zSm1mK244YlRzR2RiMlZWTi90U1FidFAzMmE1V2FnRGlMeXNU?=
 =?utf-8?B?Z1F4eDNSN2NaWk1WMWtFM0ROQWRmMFFUSTZjYkl3N3grUldhY1prbGpmV2JV?=
 =?utf-8?B?dnBWcTZMWU55MWtxUzBKc1oxbkVuYkh4TytVVFRwL2s5MnNBaW9xUnZJclZU?=
 =?utf-8?B?eXZTZ2VveDlxTTBYU1NFdjdVYUpuNWYzdGdHYkNKSzhsUHVLZDIrZGMxeXRy?=
 =?utf-8?B?aHpqc2RzcFkvZGQ5QVBEWVBwMjhWOVJTYTk4dldTLzlselByeWRKV1pkWVRY?=
 =?utf-8?B?bzNOVnJIVkdEQWNYQzJ1ZThjZFUrTEVoTE9YQ21palY3cTBoWnRveUdsZ2V0?=
 =?utf-8?B?RTRGSlcvTnJRaFRkUllFNWR6REJhZk9LNXFsajJDcHhWOC9nYVYwd3crZHV6?=
 =?utf-8?B?U01BR2dTZ1JPNGYzSWtRTUIyeXFMYjBoWDV4ZWwvZDEwRmtlVmwvMUg3eVpK?=
 =?utf-8?B?NlI1SjVoSlRtV2xDemJIbUVadVF3RTRhZXNLWEFZWnBrMHRrM09jUDZNYyti?=
 =?utf-8?B?MjBRS216RWl2Uk5WOWNKRCtyL1ovU1U2eFQ4ZWtaaVdDbnpHNEplRU56RDZm?=
 =?utf-8?Q?IS/E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b3fdbf-e50a-47ca-10b7-08de23b23024
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 19:15:35.1860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVkWoIgbyXmoatxEEJosTtO0TE+NUp6qK5yLF7OF1t2umiHBhtAZ6dsG/+lTFatDcJDjMcnFF3h1N/sM6U+q4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6
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
Cg0KR3JlZXRpbmdzIEBZYW5nLCBQaGlsaXANCg0KPiBUaGlzIGxvb2tzIGdvb2QuIEl0IGlzIGVh
c2llciB0byByZXZpZXcgaWYgb25lIHBhdGNoIG9ubHkgZml4IG9uZSBpZ25vcmVkIHJldHVybiBj
b2RlIGlzc3VlLg0KDQpUaGFua3MgZm9yIHRoZSB1c2VmdWwgY29tbWVudHMuIFRoZSBuZXh0IHBh
dGNoKGVzKSB3aWxsIHJlbW92ZSB0aGUgV0FSTl9PTkNFIGFuZCB0aGUgdXNlciAiKHZvaWQpIiB0
byBzdXBwcmVzcyB0aGUgdW5uZWVkZWQgcmV0dXJuIGNvZGUuICAgIEkgd2lsbCBhbHNvICBicmVh
ayB1cCB0aGUgbmV4dCB1cGRhdGUgaW50byAzIHBhdGNoZXMgKDEgZm9yIGVhY2ggIGlnbm9yZSAp
Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlhbmcsIFBoaWxpcCA8
UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxNCwgMjAyNSAx
OjUzIFBNDQo+IFRvOiBNYXJ0aW4sIEFuZHJldyA8QW5kcmV3Lk1hcnRpbkBhbWQuY29tPjsgYW1k
LQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNd
IGRybS9hbWRrZmQ6IElnbm9yZWQgdmFyaW91cyByZXR1cm4gY29kZQ0KPg0KPg0KPiBPbiAyMDI1
LTExLTEzIDEzOjMxLCBBbmRyZXcgTWFydGluIHdyb3RlOg0KPiA+IFRoZSByZXR1cm4gY29kZSBv
ZiBhIG5vbiB2b2lkIGZ1bmN0aW9uIHNob3VsZCBub3QgYmUgaWdub3JlZC4gSW4gY2FzZXMNCj4g
PiB3aGVyZSB3ZSBkbyBub3QgY2FyZSwgdGhlIGNvZGUgbmVlZHMgdG8gc3VwcHJlc3MgaXQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTWFydGluIDxhbmRyZXcubWFydGluQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkLmMgfCAxMyArKysrKysrKy0tLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jICAgfCAgMyArKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiA+IGluZGV4IDY0NGY3OWYzYzlhZi4uZTQ0
MzhmY2E2MjgzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmQuYw0KPiA+IEBAIC0zMTMsOCArMzEzLDEwIEBAIGludCBhbWRncHVfYW1ka2ZkX3Bv
c3RfcmVzZXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICB2b2lkIGFtZGdw
dV9hbWRrZmRfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgew0K
PiA+ICAgICBpZiAoYW1kZ3B1X2RldmljZV9zaG91bGRfcmVjb3Zlcl9ncHUoYWRldikpDQo+ID4g
LSAgICAgICAgICAgYW1kZ3B1X3Jlc2V0X2RvbWFpbl9zY2hlZHVsZShhZGV2LT5yZXNldF9kb21h
aW4sDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0+
a2ZkLnJlc2V0X3dvcmspOw0KPiA+ICsgICAgICAgICAgIFdBUk5fT05DRSghYW1kZ3B1X3Jlc2V0
X2RvbWFpbl9zY2hlZHVsZShhZGV2LQ0KPiA+cmVzZXRfZG9tYWluLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0NCj4gPmtmZC5y
ZXNldF93b3JrKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIkZhaWxlZCB0byBxdWV1ZSB3b3JrIQ0KPiBhdCAlcyIsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7
DQo+IGFtZGdwdV9yZXNldF9kb21haW5fc2NoZWR1bGUgb25seSByZXR1cm4gZmFsc2UgaWYgcmVz
ZXRfd29yayBhbHJlYWR5IGV4aXN0IGluDQo+IHRoZSB3b3JrcXVldWUsIGl0IGlzIGZpbmUgdG8g
aWdub3JlIHRoZSByZXR1cm4gdmFsdWUsIGRvbid0IHdhbnQgV0FSTl9PTkNFDQo+IGZvciB0aGlz
Lg0KPiA+ICAgfQ0KPiA+DQo+ID4gICBpbnQgYW1kZ3B1X2FtZGtmZF9hbGxvY19ndHRfbWVtKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzaXplX3QNCj4gPiBzaXplLCBAQCAtNzE1LDkgKzcx
NywxMCBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfc2V0X2NvbXB1dGVfaWRsZShzdHJ1Y3QNCj4gYW1k
Z3B1X2RldmljZSAqYWRldiwgYm9vbCBpZGxlKQ0KPiA+ICAgICAgICAgICAgIGlmIChnZnhfYmxv
Y2sgIT0gTlVMTCkNCj4gPiAgICAgICAgICAgICAgICAgICAgIGdmeF9ibG9jay0+dmVyc2lvbi0+
ZnVuY3MtDQo+ID5zZXRfcG93ZXJnYXRpbmdfc3RhdGUoKHZvaWQgKilnZnhfYmxvY2ssIHN0YXRl
KTsNCj4gPiAgICAgfQ0KPiA+IC0gICBhbWRncHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlKGFk
ZXYsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFBfU01DX1BPV0VS
X1BST0ZJTEVfQ09NUFVURSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAhaWRsZSk7DQo+ID4gKyAgIFdBUk5fT05DRSghYW1kZ3B1X2RwbV9zd2l0Y2hfcG93ZXJfcHJv
ZmlsZShhZGV2LA0KPiBQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFLCAhaWRsZSksDQo+ID4g
KyAgICAgICAgICAgICAiKCVzKSBmYWlsZWQgdG8gZGlzYWJsZSB2aWRlbyBwb3dlciBwcm9maWxl
IG1vZGUiLA0KPiA+ICsgICAgICAgICAgICAgX19mdW5jX18pOw0KPg0KPiBhbWRncHVfZHBtX3N3
aXRjaF9wb3dlcl9wcm9maWxlIHJldHVybiBmYWxzZSBmb3IgU1JJT1YsIHBwX2Z1bmNzLQ0KPiA+
c3dpdGNoX3Bvd2VyX3Byb2ZpbGUgbWF5IHJldHVybiBmYWxzZSBmb3IgbWFueSBjYXNlcywgbGlr
ZSBpZiAoIWh3bWdyIHx8DQo+ICFod21nci0+cG1fZW4pLCBJIHRoaW5rIHdlIGRvbid0IG5lZWQg
V0FSTiBmb3IgdGhvc2UgY2FzZXMuDQo+DQo+ID4gKw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBib29s
IGFtZGdwdV9hbWRrZmRfaXNfa2ZkX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUz
MiB2bWlkKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y2hhcmRldi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5j
DQo+ID4gaW5kZXggMjI5MjVkZjZhNzkxLi4wMjU2MDlhNGFiY2YgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gPiBAQCAtMjc4MCw3ICsyNzgw
LDggQEAgc3RhdGljIGludCBydW50aW1lX2VuYWJsZShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+
IHVpbnQ2NF90IHJfZGVidWcsDQo+ID4gICAgICAgICAgICAgICogc2F2ZWQgaW4gTUVTLg0KPiA+
ICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgIGlmIChwZGQtPmRldi0+a2ZkLT5zaGFy
ZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpDQo+ID4gLSAgICAgICAgICAgICAgICAgICBrZmRfZGJn
X3NldF9tZXNfZGVidWdfbW9kZShwZGQsDQo+ICFrZmRfZGJnX2hhc19jd3NyX3dvcmthcm91bmQo
cGRkLT5kZXYpKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICh2b2lkKWtmZF9kYmdfc2V0X21l
c19kZWJ1Z19tb2RlKHBkZCwNCj4gPiArDQo+ICFrZmRfZGJnX2hhc19jd3NyX3dvcmthcm91bmQo
cGRkLT5kZXYpKTsNCj4NCj4gVGhpcyBsb29rcyBnb29kLiBJdCBpcyBlYXNpZXIgdG8gcmV2aWV3
IGlmIG9uZSBwYXRjaCBvbmx5IGZpeCBvbmUgaWdub3JlZCByZXR1cm4NCj4gY29kZSBpc3N1ZS4N
Cj4NCj4gUmVnYXJkcywNCj4NCj4gUGhpbGlwDQo+DQo+ID4gICAgIH0NCj4gPg0KPiA+ICAgICBw
LT5ydW50aW1lX2luZm8ucnVudGltZV9zdGF0ZSA9IERFQlVHX1JVTlRJTUVfU1RBVEVfRU5BQkxF
RDsNCg==
