Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A3AC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 19:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6034210E2F7;
	Tue,  4 Mar 2025 19:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5vSBkpW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF4F10E2F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 19:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNcnBGJTGGBXJk4vpDKdf8OlhJ81SeIAq2S5AZbqTVA1wvzz9p1rUAU5WODxgLkwwoAmAL0frs4xQyqC4GxeCPHVGaGw3fohVqYDzrjI5T+ysnKzVbhBhOk/zEJpFtmwH/5EWg245S9povGjpxLixWlyc1GvHq6hvQEPJCR+kH5d3ObafEgmuyY1CAxnvwm4X2zFtHHpTY20chtlpinBqzZJMcmSnRF0AbDxpFkaPKNt3ZsfK9d+ui6983iTWNSFOPuCHVygJ6nuGIw/S8wN4ZVphIF8c5EMTYxRMzHa/63WEOxWJOecCVxHFhDT8a/3J+H53GKx6/yxE1ldzt6wpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9NCe+wDdyGOMYwPmbOsbAw0dTPLdyTSXIOsZr4xmvc=;
 b=LJzu3yXwxEdyUEKQ7KGf1Bburfd+nG2Eb+je3GdtHEwiEVmXqPh5n0F+s4744gZt/VzeZxLsdDj4RMUtUF6abRr5vahwrmBKIhBs+5aAuljIHYpXTjbYcS732Eg/5sDqpkJh231K4CMq21wxMYYOW1sAaTabcoj8n++A6M+8qiqnN/aF09RyV5rR3pFBVereL1m0+ZmsPX+ES+ORNtGObI0LRsOJDoAW7Sf18pFVa1PKwnW3447ARfJvh/tC62q54y82Kiy7L1SPAkA24NZz60bS8OgUYAjhVyc9l6XdPJRHBMJ3mL18+qKa0sKzq/vAlGFwsfGQ0EQpzIYW+K8+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9NCe+wDdyGOMYwPmbOsbAw0dTPLdyTSXIOsZr4xmvc=;
 b=r5vSBkpWIT4VBhB4VTtrqTiIoBFGW6AzqqT1Ei+5VlffPv2ew5SZcVdmonwg7n/CMkKwEY6BeFfD6HyvjIh/YrEv68CpmDLtU39zLdcaPDt2UofVMaGRnTVw7uuYkyolRnczgCWvFWEtV292SUU1WDnmUao3DwWpz8nUGz58ZnA=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 19:52:02 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 19:52:02 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: validate return value of
 pm_runtime_get_sync
Thread-Topic: [PATCH V2] drm/amdgpu: validate return value of
 pm_runtime_get_sync
Thread-Index: AQHbjTwiL6On6dGbwkWcHH2zVlNfFbNjYESAgAAC6nA=
Date: Tue, 4 Mar 2025 19:52:02 +0000
Message-ID: <BL1PR12MB57530847651DEFF105C588C093C82@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250304193202.383241-1-sunil.khatri@amd.com>
 <CADnq5_N-jy=G-7H_EVOUJvqVa5aFp6Jqi-gauqSo6VWVNWmNdw@mail.gmail.com>
In-Reply-To: <CADnq5_N-jy=G-7H_EVOUJvqVa5aFp6Jqi-gauqSo6VWVNWmNdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f0b232e2-a081-4b93-a051-e9b2c5a2b091;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T19:51:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|CH3PR12MB7524:EE_
x-ms-office365-filtering-correlation-id: 20a0d153-fb6d-453b-584c-08dd5b56085d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bm0ralZnVDlrdnd5QnBJa01VdlFvUENFWkRiYStjMXlDdHNuVXNFakR2NEhk?=
 =?utf-8?B?K0dtOHBvaW5QQzNlZ1YwT0JCR2puZXlhcDArOXgvRS9rRzN1UG80OFFzZmdC?=
 =?utf-8?B?YVo1RWRGbXJtMG9LTzExc0duMWZBclpvMGpHOFdIQ3IvelFld1Nsek16elNr?=
 =?utf-8?B?YURnamdqaXdvMUs3Skk3MG9YRE9haXhlMy95dCtrRDIwU3hoeDRveVpVOHNW?=
 =?utf-8?B?VXRaVGxIYXF4V2xwSkZnVjdiTm1YN3FxUVg5eFVuTTVoTEtpSCtNRkVjSU9Y?=
 =?utf-8?B?N3VJT3dxTmMxY1pJSVBqK0taZnJ4Z0I3c2w0N085VzlQOTNaN3BIazlvbzhJ?=
 =?utf-8?B?RUcwTkNlUTZhVkthOGNmNk0rbkd1UnQxNVIzRDJUWWtjY1dmRDZ2Y1pHcTVt?=
 =?utf-8?B?bmVRL2NRdkVqSEZjb3hQVEk4T25RZWdTS3Z5ZHZaK0llZ082MndSQ3c0Q3Aw?=
 =?utf-8?B?SDVZb3Y1Z1J2ZVZZYTZLT2JZYncxMlZxZUFKeUtwRzVNUHE5NEVicEZoWEFk?=
 =?utf-8?B?VGJSZER4blNjWWgrUTBEcmJwWlRUT00vbmxzNWVPVXlFU0l2R1BSYVRKN2J6?=
 =?utf-8?B?S0hTSTduTktkcDZOSEZSbFFBZkNIOTRJelMrdjd2eWgrbVNyb05tdFlVOTl3?=
 =?utf-8?B?R1M1a3dIY21XYVo5T3oxRXJvZWlVa2xLWHJvUFI0MmQwZitzMjZXbUpUY0V0?=
 =?utf-8?B?UW1RWlFmcWNIeXJCR09vRVFBRHJFeVFvNFpQcHRBREtDTktYY0hlYXJGdDNE?=
 =?utf-8?B?VTFQbGxMQkd3Mjh6Wi93aFZmeUlqeVZYckFYWDRkU0NjL0ppK0pXQmVyNXBj?=
 =?utf-8?B?OFcwNkJXOTZKdHFrdHd6VVlJS01qQ0NjRnBKdTRYZmxFQzFtd3BIYzdtL2tI?=
 =?utf-8?B?WnEvYjB5RkczUnptSlVoREYzQ1FWdnVJNFcwdytmaXFlNzRBQS8rOHRSZUpR?=
 =?utf-8?B?RWFocGxCM3N5QzljUjVyMU9ZaTZKOThKbTBkYUhzc0lRUEhLRVN1bHZFZjEw?=
 =?utf-8?B?aVpxZzVST0JHUVlTTGpROHFGWFBnRkJBWWlIYnhIbm1LVUh2WHR2cWszZXRs?=
 =?utf-8?B?NG05eUVJN3E0Y25sR0YwUmhSTjAwRThzZGdENlBtNlB1c3F0eDhhYnlDRzhk?=
 =?utf-8?B?eSt4d2R2Rm1SRFphak9RbFdYM1R2Y1JIbVlwbW0xRldHUEtZVTZ3ZWxabWdX?=
 =?utf-8?B?b3ZSM2NndW82d0ttbExFd0JJcm50WmF2Wk4yRTE2K1RjU21MRW1hYWRCelpM?=
 =?utf-8?B?bGdoVk5LbG0yK1BpY3Q4L2ZOYTB6WmJGRnBnOXNVSVl6ZXcwUlhyU2o0OVR0?=
 =?utf-8?B?RUYrN3dubUpZQUZKeHJHR3lDVXZ2M2RzbVdOZkF1bWZUbFFQTzBYYWZpWjBC?=
 =?utf-8?B?WjI0ZFVHSXVLbHNnWVRQdkZKcnN1VEtTcG1GVHROS0U0QkxFMkdMNGdESno4?=
 =?utf-8?B?dkhUWnVLOFJlWDkrNlR2WHdFdjB0KzVaUDVRcDZ2SUZrZDR2SHRQdTFWUVBH?=
 =?utf-8?B?TGFhNWdUT1JvaWl4eEMyUzdSSldwNXJ1ejZ6WG10NW1uNGlJNWZsVXlZTGNS?=
 =?utf-8?B?Ym03S2RwZkZhRzRiUVNmSFdLQmdUdk5NenhPYTA4RE9iS2RXQWJLQXBva2FJ?=
 =?utf-8?B?ODI4b3ZZdXFxVkNDaG1HekZXOEtwOFhvc2xpMnlEbWxCaklhanJmVVcrei9s?=
 =?utf-8?B?SmhXRnhvSm9ERXRjK3dLcmdMT25UR1lOdXJLVXd6RFROZnNqVHdWY1FDS05L?=
 =?utf-8?B?S1Nnc09NQ2NNMmZMWFIwcUltMVVFdTJHcTREaE1XWHFjRUJxWTlobGV6TGUw?=
 =?utf-8?B?OVFMN1QzTnRDTU9MbHYvbk1rdGZqZkIzVXF1bXZNYmZZVDkxNDJPZmpOKzRi?=
 =?utf-8?B?WS9Yek9GbERxMVNWVDNWOGF5Q3h5K3Yxb2dzOVNCZWd4RzFYQ1B5Y01BamEy?=
 =?utf-8?Q?23qC+p92ShVGsXSLRjLYBVlheD5QE/p4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnYzMkRyOGJOU1dlUEliKzNVbTJ1WEdJQVF2KzI3UklQV0pxN1JTOGp3VkRQ?=
 =?utf-8?B?c1BUZFQzNThvb3NVdTgwcWJqZ0NkcUYzNS9YNTBkVW5rSXpIaW1Uc2RXeXBx?=
 =?utf-8?B?TjRYMHdUdlh6Q3JKQ2E4N1poVEhMdW5xMVhxaDQrZUJLMWgvYUg1NlUwZC9J?=
 =?utf-8?B?NGsvYVVoOVdrQ0RsSVRQREFWNnduNVA3bmZ5RGtZaUUvTVAzQkRaSVlMUHl1?=
 =?utf-8?B?dmZDb3FEU0JteGJ0WjUyQmN4TUxKN296S1VDQ0lHMFcvUEFDa1ZSWCt1TDFn?=
 =?utf-8?B?MlYyREJidGFVNk85UVMyQjAyUWVzT0w1WnRPRkE2a2kySkVOWWZsREs3RzEx?=
 =?utf-8?B?QWpXRkJ0aTM4T1JLYWtsVGdYNitPT21FRkZzei9EaFJvQjZicGJoV3hPdk1u?=
 =?utf-8?B?cTZlQ0p4Q1ZNVHJGN3gycU5MRUdFdTBDTXFkQktTaW1OcUI3SGpRNzE3dVIy?=
 =?utf-8?B?Zk1heDA0a2hHQjJtaGt5QjJvNmVqaktEMnhCMUN5MEFkRGJXV2hxYjNrY0hF?=
 =?utf-8?B?MXk3NTVkZk9sKzJJSnhYbUdzN0xSeFB2bU1nc0VWVUI4WFV4YTZrdXg5YStx?=
 =?utf-8?B?YnQ1TTZmYkp4eHdPVUM4TjUvaEluLzQzaFpFaG42ak9zZFdic3NpOTZGS2pS?=
 =?utf-8?B?R1V6bnNza0FQVkFFcVBxRmhJdERjQ1F4Y1M1ZnhWUGtJR0ZiS2hRVEJVK1Zj?=
 =?utf-8?B?b3A2cTFNTHdUNjNPdjRBUFVzZFllVUtjbnVsSFdzcmJ3dEFJbTA2eEwvTGlh?=
 =?utf-8?B?TVQ3SzF3RmNQeUVEdmFUOUI4KzhETjBuTCtNbkRiSW5lUTE2KzFsN055QTVm?=
 =?utf-8?B?Q0xXWEI2UytPUnFiTTU4N2lTQUZtTXhqT0U2bkNnWlZDR2VIVkQ4ZXQxWVpa?=
 =?utf-8?B?R2xlS1NkQzhta09nU3ZpR3hwRXlvc05EMEk2WXR5U3hqeUxwN3k4K2UzWUhU?=
 =?utf-8?B?akpPTEY5R2JDRnQyQzdPZVlBcVNXTUdnMUxPQ0FYcUFscnNacWdlVi9NSnBT?=
 =?utf-8?B?NElJVjhQcWZiTERPTGRsSzltZExSMmoya3k2djNlbFVVb1hiZUl0MW9MSmJL?=
 =?utf-8?B?c0Jtaitocm5wbDRoOUwzTGR3dlRMN25OcHdXZ2kxcXVSM1dZUEYvNkZ2elZG?=
 =?utf-8?B?T0FEZTNkUkNTU3RTazhEOGJSU0xjOVBkd1dlR2tyL0c3eDY1OGxsTjliVDNB?=
 =?utf-8?B?bEc5MXk3UTN0clhidHVYQWtjWU5oN3B1UDgrdDBPUy9OajhRY3MrcStyZmZK?=
 =?utf-8?B?dVViMGxPT1NCY1JRUTAyZ0tCMjJNZlhZWU5PZk5QL2RBRFFCa3l1bmJmSVFh?=
 =?utf-8?B?NlVaeS84TGhIazd0TldWdHZXYUtQQXZtRFhMY0ZlcTR5amFRb1ZKT3FtaW8v?=
 =?utf-8?B?dGdhcFFVa2o2QkJ1QWtua01IV1Y4bW1QWEVRYnJsL1hNc1ZtYVJEZnI5VHB6?=
 =?utf-8?B?MWw0QWRONnZIZi9odWc1Tnc5a0V2Sll2TTN5d0JhamxhdFVBRUl6OFpqTm8x?=
 =?utf-8?B?ZG85Zlo1ZzJpd210Q3RENUxxZ3FjSXF6N0s4TXF2MGY0RW1Hc0RwYlh2L283?=
 =?utf-8?B?eFBaS2drbDVOam81UGlVeGhKMU5ud3VnREgrS1o3N3ZFMUltMWZldURpV1lh?=
 =?utf-8?B?Z2FVOG4wTDRLVVRMWjZKd251OHpoZTd0dXZGeTFMTFlGU1BVdnl0L0liYUF5?=
 =?utf-8?B?TkJGSzVyYXNhUHZxakViUWo5OFRnUDZYRVlqVmdDaTBJaXBEL1FXdzl3WlJ6?=
 =?utf-8?B?NmRsU21DYjZGR1YzNGlZOFZ2U2F6TmV1ZS9DOTJzZU00Y3hwY29XOThrR3pT?=
 =?utf-8?B?OXNrMzVjWWZmMGp3L1NOMnQ1ZnFTQkpkV29RaWF0bGJ3R3dtZHNmQ29jbkxY?=
 =?utf-8?B?L3NzcW8wRXpoUllmTEpWZHFzTWFSeWp1SlpVVlZsc1FwSnNIckJnejR4NFhT?=
 =?utf-8?B?K3NsRHRUTE1QTUEvMjQ0QUpjTDZRQnJxbVdBQ0xLUVBtMWZpc0t3OUVUUFFW?=
 =?utf-8?B?NTZ3YzBybHVYbjZJenFyQkVrbXRSV3ZQTlJkN1k0Qk9Ja1dvd28vNDFTcmlC?=
 =?utf-8?B?L1Y5L0FPbUJlWVhJYitNaHBSdnpobFpGSEpQQUNkeEYvOVNQVlNPcEZJemdV?=
 =?utf-8?Q?sGMo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a0d153-fb6d-453b-584c-08dd5b56085d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 19:52:02.1956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hR+3fyyhwodUhXYAyN8tCskBOSnpNH75Iroh1r2GbLnp+KyrdMMEWxayYdrdFzVG0IPROhMKncsLNSqwrxwgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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
Cg0KU3VyZSBBbGV4LiBXaWxsIGRvIHRob3NlIGNoYW5nZXMgYW5kIHB1c2ggdGhlIGNoYW5nZS4N
Cg0KUmVnYXJkcw0KU3VuaWwgS2hhdHJpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFdlZG5lc2Rh
eSwgTWFyY2ggNSwgMjAyNSAxOjExIEFNDQpUbzogS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJp
QGFtZC5jb20+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBkcm0vYW1k
Z3B1OiB2YWxpZGF0ZSByZXR1cm4gdmFsdWUgb2YgcG1fcnVudGltZV9nZXRfc3luYw0KDQpPbiBU
dWUsIE1hciA0LCAyMDI1IGF0IDI6MzLigK9QTSBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBh
bWQuY29tPiB3cm90ZToNCj4NCj4gQW4gaW52YWxpZCByZXR1cm4gdmFsdWUgJ3InIG9mIHRoZSBw
bV9ydW50aW1lX2dldF9zeW5jIGlzIHIgPCAwLCBzbw0KPiBmaXggdGhlIHJldHVybiB2YWx1ZSBj
aGVjayBhbmQgYWRkIHByb3BlciBmYWlsdXJlIGxvZyBhbmQgZXhpdA0KPiBjbGVhbmx5Lg0KPg0K
PiBTdWNjZXNzZnVsIHJlZmNvdW50IGluIHVzZXJxdWV1ZSBjcmVhdGlvbiB0byBtYWtlIHN1cmUg
ZGV2aWNlIHJlbWFpbnMNCj4gaW4gYWN0aXZlIHN0YXRlLg0KPg0KDQpGaXhlczogMzNkNjU4MzRi
MDJkICgiZHJtL2FtZGdwdS91c2VycTogaGFuZGxlIHJ1bnRpbWUgcG0iKQ0KDQo+IFNpZ25lZC1v
ZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jIHwgNSArKysrLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+IGluZGV4IDNhNzFkMDFi
NTRjOS4uN2RmNTBmZjgwZjliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bWVzX3VzZXJxdWV1ZS5jDQo+IEBAIC0yODksOCArMjg5LDExIEBAIHN0YXRpYyBpbnQgbWVzX3Vz
ZXJxX21xZF9jcmVhdGUoc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVxX21nciwNCj4gICAgICAg
ICBxdWV1ZS0+dXNlcnFfcHJvcCA9IHVzZXJxX3Byb3BzOw0KPg0KPiAgICAgICAgIHIgPSBwbV9y
dW50aW1lX2dldF9zeW5jKGFkZXZfdG9fZHJtKGFkZXYpLT5kZXYpOw0KPiAtICAgICAgIGlmIChy
KQ0KPiArICAgICAgIGlmIChyIDwgMCkgew0KPiArICAgICAgICAgICAgICAgZHJtX2VycigmYWRl
di0+ZGRldiwgIkZhaWxlZCB0byBpbmNyZW1lbnQgcmVmIGNvdW50IG9mDQo+ICsgZGV2aWNlIHBt
X3J1bnRpbWVcbiIpOw0KDQpJIHdvdWxkIHVzZSBkZXZfZXJyKCkgaGVyZSBmb3IgY29uc2lzdGVu
Y3kgc2luY2Ugd2UgZG9uJ3QgdXNlIHRoZQ0KZHJtXyogdmFyaWFudHMgdGhhdCBtdWNoLiAgQWxz
byB1cGRhdGUgdGhlIGVycm9yIG1lc3NhZ2Ugc28gdGhhdCBpdCdzIGNsZWFyIHdoZXJlIGl0J3Mg
Y29taW5nIGZyb20uICBFLmcuLA0KInBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBmYWlsZWQgd2hlbiBj
cmVhdGluZyB1c2VycVxuIg0KV2l0aCB0aG9zZSBmaXhlZDoNClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCj4gKyAgICAgICAgICAgICAgIHBt
X3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGFkZXZfdG9fZHJtKGFkZXYpLT5kZXYpOw0KPiAgICAg
ICAgICAgICAgICAgZ290byBmcmVlX21xZDsNCj4gKyAgICAgICB9DQo+DQo+ICAgICAgICAgciA9
IG1xZF9od19kZWZhdWx0LT5pbml0X21xZChhZGV2LCAodm9pZCAqKXF1ZXVlLT5tcWQuY3B1X3B0
ciwgdXNlcnFfcHJvcHMpOw0KPiAgICAgICAgIGlmIChyKSB7DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
