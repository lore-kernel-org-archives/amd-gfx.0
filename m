Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64553C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F104C10E9C7;
	Fri, 11 Jul 2025 08:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CF3Mq5Ei";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A02B10E9C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jepJYUq+gGYiUh4lv648Z+tYhGTUjNHzjsNoTVgtP35bkBKcr8NNTNy/QMBiwAZ0ItrPCeXeXQ/ou7y8D+GT1KD2S5SAK8zRc1PE0eBz7ii5u4ZROsvWuQF9BER7DQDzbIR6tP0TBXLoTAS3onGRsdwxINwnGvxyDPU8DphJXeu/jNkJ08TVBclJNX08w02oBkuSAADLnYwZ4/ZeopJ/rFwiea4oInr0q1bWtzXHb6oHedr/aoajInsLLSLKrX9ormVSq9rfeMRX/RB+l1/hNk9/K51hmoMH2pkwg076vJF9PIxxso/Kl1QlIoshUHhXU6QoWGsCHRRSIzonqqxLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAsVzzXE53UOWaVQGi5eeHqQH87k424I8Z+JURA3oV0=;
 b=WgCUrnihcdWI+ftt+ksBDt5T9wtFDdQpo5tGyibykzim2QG0EzhYfTJK/7oGsLIXgF1z+w0NJp9quPxB+MowBh7Ln1ZiW/rNH9E4Sn81xN23WS1B6wYwYP2LByeMZ3i2LVWz+6Gt/atDtFu/yQWo6PFX11RnSC7jIgdSlsGg79XdXXAUVw47QmpP2siM3AbbnQ+qUK1UxwdosfKZGHm2iwnTjFKc6dvWwf0Z30jm5+Y1MmLZgNwG1TZKrvZjaGlmHEgXMM44umQKIml9q3/8LmS9nMG3bXCv/zZS7F6yWtLPDmKFvykTTVqowV6U5vNu6l8mWL2SmHwxHkijQ53Z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAsVzzXE53UOWaVQGi5eeHqQH87k424I8Z+JURA3oV0=;
 b=CF3Mq5EiGyerZ8PnQoDZ2Li52hqJ2QWO0NkkUy/C7vIWSe9V7Ru/33NHEqwCxabygJ8UzSOAZiEwUE3ziKlqC8uNHhSsjNyb0pRvC0osP2V9wt7J8CyuRfBHC5/U0W92MMwxY6Mc2/mJGfxhYlkhoenFs/c/+5GHQ3G68nVDA4U=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::997) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 08:06:31 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8901.021; Fri, 11 Jul 2025
 08:06:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Index: AQHb8g1JvXEZsezShUilIup4MFEGCrQsg30AgAAIUICAAAU40A==
Date: Fri, 11 Jul 2025 08:06:31 +0000
Message-ID: <PH7PR12MB87963C06B09A82C566CFFAF5B04BA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250711024059.25658-1-ganglxie@amd.com>
 <46073fea-6d57-4ad1-a835-6541c4360a78@amd.com>
 <MW5PR12MB568466B947006E5AF0E72EB9E54BA@MW5PR12MB5684.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB568466B947006E5AF0E72EB9E54BA@MW5PR12MB5684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-11T07:46:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ5PPF6785369A4:EE_
x-ms-office365-filtering-correlation-id: 400f02b7-824a-4b23-cfd2-08ddc051d886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?b3JsbENHOTZnUzQyYURCMWUwQVlnY3cxVzhoZWtDRlFodmhLWGV6REtyK1Uz?=
 =?utf-8?B?TU5qRStkN3NnUElJYllaMlk3bUhxTlJxOENtdEtDUEV5SjZrRWo3T0QxTEox?=
 =?utf-8?B?QzJYbHpmUVY0UFlGMkNnL1pzZmpGR2hCb0MvMFVNRGJFaUFBbnEraThKdmg0?=
 =?utf-8?B?cEhGby9uYitsUzdJNldaenlPTUFTd3UrYVpZK2xwd21sRXE2Mm85aExpSU9I?=
 =?utf-8?B?bGFSQnhDU2htRHBkM3ZHdHk1NlBiMXRoK05FYnlGeEdkUnQrOUcvVlYxMW5B?=
 =?utf-8?B?WEQ2SmQ1SUFpNGllTGgrLzJBcUdHS1UyeUxnVEdIL05OUlJJcGFhMk5NemZt?=
 =?utf-8?B?RlZnWEFTcyswVXQzeEI5VGZuODlWVGRVUktxRVNVNFVqdnQ1NEJLbHRNSmZI?=
 =?utf-8?B?SElzaTFwNllvWTE3bkRYanovbmluQnZ2cDgxT3Jacno5cE1WcXYwSnRQdEp5?=
 =?utf-8?B?SW9UdEpTQzBVcUwzQUtucWZtU2Npb08vZnhNLzRlcXBpbTdRd1lraGpvMWU1?=
 =?utf-8?B?Q2hweGtPM3ZuNXQrb21kQ0Nyd1l5UmZzNFozNDNqRE44dTRlYmxwSnRKam13?=
 =?utf-8?B?OEZTczBRb3Bicko1Y2JNOWRGQ3VLdFo2dmViUlRhZGNKY3ArRjNsVHZFeGU1?=
 =?utf-8?B?UE1aVTVEWllyUTRJQXhWR09hMnF2WDl6K1RoOSs3bWRNNjZObGZyYXhtSnI2?=
 =?utf-8?B?NlREeXduSGJoT0NrWmNKV1lJWm5WL2dWa2taZVZRUk4zTGZXSnpIRXQ4TUd3?=
 =?utf-8?B?RmpRTmNZaUhibzNBb2IrR2k2RGNGelYxVmEvUys2MWUreDc1Zk1WRW5ndkFt?=
 =?utf-8?B?R00xbnk3VmpZSEIrY3FQMlVYZUFPcWhIQ3hqa21ORVVDM2ZYQVhJUmVtNlpK?=
 =?utf-8?B?a1N4N3RGV3lnZmd1aVpiZFhSWDVYQkFBdTM3dzJvZWZWb1hBYkIvQkNSVmY3?=
 =?utf-8?B?OXJWU2lrNTFJM1RtK3pGY2c5WXFTS0ZNTUMwSEVBTzZJSGZhQXBaYlFQSys4?=
 =?utf-8?B?UmFLZGtkYXZxUXRaY3h4WmEvMjgva2hRNml4SUd5SDRZS1Q4elJhd0IzUlFW?=
 =?utf-8?B?STFFYktpYi9hRDN5cy9HVWNUT1NrVjY0NGdvcTQwTDhMdVdQbFdOYXdyblVB?=
 =?utf-8?B?Z29xKzJscXFUdWYvK1B5TExSczZOcy9wNXF3MG1tZ3dnR2lnVC9VUXg0ZWhw?=
 =?utf-8?B?U2pyYW1ZUmFjYksyQ28zVUlGd2dBbWV0c0hoMVZaY3FRWjdRK0hyZ21RbU5Y?=
 =?utf-8?B?dWFzWmdYUHpnTjJXaUJhamJyTVRFMHBzamNPUGtTSkxwakl5L3huVlhiOUtQ?=
 =?utf-8?B?VVA4b3VTUzZUTjNET1U4cEtPQWc1eUNPYWVYMEpOVFJMKzV2K3VUb0Q5UnZU?=
 =?utf-8?B?Z1duR3ZpTWRmR25IWDQwQ2NyZUNUbE55SHRvUGtNSldtQXVrL1JOYmpLa0Vl?=
 =?utf-8?B?M2lFRTZkTmVzU1lSUE1ZWHFRSTNhRDFjMkpBQTVzNHpFcGFyRnY0MDRCVjcz?=
 =?utf-8?B?UzBFUCs1aTQ0QTkraTNkQlU3Um50RnlMMW52a2g2UXFTNXhwM3hwbzNHZzNL?=
 =?utf-8?B?OWROeExZUTRCRmVaejl4N0M3V0xvNW1qZGZPb21LMnJOM0dNNURaa1JmU085?=
 =?utf-8?B?eUJVaEFpdS8yb2lXS0NBZXVjUVZ3akh5Y0V4aG9OQ05BSTd1RGY0d2RkS3U3?=
 =?utf-8?B?SnhHSHBicWJBRmM1V0VmU2w3WXRhZmpKMjJ5aUl4UXhYZElJaEROeWVuSFA4?=
 =?utf-8?B?ejhqMXNXQW5RTTRFUFV0a1JPK3U5UlZpbTl2Zk1oci9NQ1N1Q1ZoaTJLWlJK?=
 =?utf-8?B?bWVxYjdyUDR4RTBKTFRNUWI3a202T1lWMkh3NEVhb0lseVYwd0RjQm9kTm5G?=
 =?utf-8?B?dEU4UWVvSEdYOVQyR29XV00zRG5SVDlLVitPWitFVnlpSXhIVGtud2ovNTdw?=
 =?utf-8?B?eTladHMrMG13ZVhxZ2tWR29WRVJzWFhzVm8wSTR4MkF0M0J3emUxTDFHWGNi?=
 =?utf-8?B?V01jem5FYlRRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG5MUEZQUDVraGJ5dThsUnJ1TWEwNGpvN2I5RWxsOXJzMHV3dE1JREZObFR5?=
 =?utf-8?B?QU45UkphVzdiaFh0ZzEvb3QwQURFMHVaMXE5b2MrVktPenVtanV1blRONzFE?=
 =?utf-8?B?RHFXbTI5bTBHRWVBVFZmcW54SXdCV1B2dGJJcndQd0xYa203Qi8rT1QzL0pB?=
 =?utf-8?B?VzN0QlVBUXRKbkZlSFZSWUNFQ3RKS0tmVERiTTA2SVdPTXpJNWo5V3lKa3ZV?=
 =?utf-8?B?Nzltei9ldzlIK0daNGJTWFFjUEtRWGFuZCtLcC9MUWgrTU13a3M4WEhoVW9q?=
 =?utf-8?B?K3dMcm9jN2hxQ1JjWHprUHdmNzVsNzQvRUZhMWRsMlFaMnRreFdOeHNYZHFZ?=
 =?utf-8?B?MGh1U1Y5QVU2R055WFBpdERYM25WaGpqLzJBT2FZbmM4N3JtRzZlWGl1Y094?=
 =?utf-8?B?QytvZElvejNoM3ZGS08rTlVySUViZG9tNUJmV3M3MTJacjJxb3VPN1djNEUw?=
 =?utf-8?B?V0VRZE1ZTU1WbzRQQnRYK0Q5K0dWUHArZktPKzE0eUx3UllsQWh1czFrd0s0?=
 =?utf-8?B?eDhWeCs5ZHQ0UXZnNTZ0cVZJWEpxaitRRnRsU1pKa3Bka2FxTThxRmxNZUFj?=
 =?utf-8?B?ekRPVDhZQUs5OUM0THBreHA3Ung5bXQrQ01LeWxUN1lvd0FsUWlRWkVRQ2dS?=
 =?utf-8?B?Zlg5VXhqUkt3V2RJTFBNUldqS0prR2xCclN4Mnk1TTNQblAycnROWXlkS210?=
 =?utf-8?B?V095QlF3U1R2WlMvVW52NU83UFBncHpKcFFEZWxxUEJvcEJqSFBHWG9sNXhD?=
 =?utf-8?B?eUFaVHJJN0JPOWw5bkFFN0FPWVdYckd2YzNMc0cybmZ0cXpqYi9FdWN5bG40?=
 =?utf-8?B?NzFjSE9qV01DVTVQUzBNM25tOXJWT0V1OCs4MHAxNEZmaUpHQWhxYlBPb1hj?=
 =?utf-8?B?OUc4YXpvcWtJNU9jWUtYV09PQVh5empGL1Q2SlA5VmdNTHhHbVNGM29CbkN4?=
 =?utf-8?B?RlhlK012a1Q5M0YrWHZ2b1R0c3hzU2ZhQnVwMHlKVDJ6OVV1eTlCeGFGR2VJ?=
 =?utf-8?B?OW0wS3dEdGVkQUozY1hkbzlwVDZDV3BuQWxCd0k1bHR3N2lQTndsTU5qcmVZ?=
 =?utf-8?B?Tys2QmM3RzRqNzZrNktCMHcrQ1BqZ25iTWlxbUF5UU41ZHRjMEQ3TUZ3TUZa?=
 =?utf-8?B?Z3VwNmgwOXNjdkFIa1ZFenNrYUFIOGZVcjVHaE1HdWlMSU1aczJsVGEyY0ZW?=
 =?utf-8?B?eHNNT1FtR0Y3TEcwOFF2UEsvS292RitCNmIyMkVZR0pYZnNVMXl6RFpTZE1u?=
 =?utf-8?B?QXBucWZrTk5wazB3SjJaRVNPcFdybGowQm9UODdyZVNUYjB4dlEya2RmcGVJ?=
 =?utf-8?B?M0hQOXQraXZxNTQzVUdZL1grUXZFN3JyODJsNHFtdGx5U3JZMVFSdE5Ta2JT?=
 =?utf-8?B?UTkvdlFManBxK3RJZklzZUVLMXJUUU1qdzk1RVdiaDV5dnBSVGFuSGM5dHVN?=
 =?utf-8?B?YjV4bnlRTG9udWIwN3Jub1ZhMlVjakkwYnVFaGNXbjFzWUg4UG14OTYzU1RX?=
 =?utf-8?B?RkMybFREeDNNRWI2cEE5NUxiUXV1VDB4OVpjMWRWMWlkUUtJRTZJRTV4bm9Y?=
 =?utf-8?B?OTZNMFQ4d3hlR2dGa2lWRmdSUk9vS3FTME13aUtwWFhtd1BQd0I0c0tFUEZp?=
 =?utf-8?B?TEtkNk14OTFLUmpuQUk0U1VyUnN6QjUwNUhPMlNUZ2puMjgwZ2kxUEdDV0lW?=
 =?utf-8?B?Um1BQXhHRHBPMUhEbmw1bStTWjhTRlkzczJLeFpiNFAzRnZZTDU2ZEhwc01s?=
 =?utf-8?B?NXkrSCtncDU5TDdudnByc0RYdCtOd2hMSWd5aWdUZUdNNEJuVDd6amRCcEFn?=
 =?utf-8?B?c2JXYUpVTS9jejNxTlNId2x4dUxoMmJXNDZMVC9yMmZmd0NOd1dzbmk1Qm0x?=
 =?utf-8?B?MWh2YXE4MW02RnlGMDl4dEhlcW9RcTlOQmx6VnZWUkNYTHdGYVpvLzR4Vy9q?=
 =?utf-8?B?Y0xROEpDeEVXYjhSSDN3QlRGak1GT0JzNURSb0VzNS8zUEEvQnNiVVc4TUZi?=
 =?utf-8?B?Z1YwUmhQV0ZPMU1ZY2lpTFNJSGhDYmlLYzVKMUF0S3pWMXFnSUdNVG5aR3F4?=
 =?utf-8?B?eVo3T2p2NlVMSUNVSDV4UmRCcDRIZUF2QUFSTDcvV012dWlqMEhjZ1pBT2VF?=
 =?utf-8?Q?WB4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400f02b7-824a-4b23-cfd2-08ddc051d886
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:06:31.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yO5gDTeMa7ij8TUG07mHWME9VVoOwLZMG9nylpMEyrG4xjldNszh3aeDNcdaJx95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4
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
Cg0KSXQncyBiZXR0ZXIgdG8gYWRkIHJhcyBzdXBwb3J0IGNoZWNrLCByYXMgaXMgbm90IHN1cHBv
cnRlZCBvbiBhbnkgQVNJQy4NCg0KVGFvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogWGllLCBQYXRyaWNrIDxHYW5nbGlhbmcuWGllQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgSnVseSAxMSwgMjAyNSAzOjQ3IFBNDQo+IFRvOiBMYXphciwgTGlqbyA8TGlqby5MYXph
ckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpob3UxLCBU
YW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHJtL2Ft
ZGdwdTogcmVmaW5lIGVlcHJvbSBkYXRhIGNoZWNrDQo+DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IFRoYW5rcywgd2lsbCBh
ZGQgdGhpcyBOVUxMIGNoZWNrDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVs
eSAxMSwgMjAyNSAzOjE3IFBNDQo+IFRvOiBYaWUsIFBhdHJpY2sgPEdhbmdsaWFuZy5YaWVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6
IHJlZmluZSBlZXByb20gZGF0YSBjaGVjaw0KPg0KPg0KPg0KPiBPbiA3LzExLzIwMjUgODoxMCBB
TSwgZ2FuZ2x4aWUgd3JvdGU6DQo+ID4gYWRkIGVlcHJvbSBkYXRhIGNoZWNrc3VtIGNoZWNrIGJl
Zm9yZSBkcml2ZXIgdW5sb2FkLiByZXNldCBlZXByb20gYW5kDQo+ID4gc2F2ZSBjb3JyZWN0IGRh
dGEgdG8gZWVwcm9tIHdoZW4gY2hlY2sgZmFpbGVkDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBn
YW5nbHhpZSA8Z2FuZ2x4aWVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jICAgICAgIHwgIDEgKw0KPiA+ICAuLi4vZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMgICAgfCAyNSArKysrKysrKysrKysrKysrKysr
DQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uaCAgICB8ICAy
ICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gaW5kZXggNTcxYjcw
ZGE0NTYyLi4xMDA5YjYwZjZhZTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jDQo+ID4gQEAgLTI1NjAsNiArMjU2MCw3IEBAIGFtZGdwdV9wY2lfcmVt
b3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7DQo+ID4gICAgICAgc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOw0KPiA+DQo+ID4gKyAgICAgYW1kZ3B1X3Jhc19l
ZXByb21fY2hlY2tfYW5kX3JlY292ZXIoYWRldik7DQo+ID4gICAgICAgYW1kZ3B1X3hjcF9kZXZf
dW5wbHVnKGFkZXYpOw0KPiA+ICAgICAgIGFtZGdwdV9nbWNfcHJlcGFyZV9ucHNfbW9kZV9jaGFu
Z2UoYWRldik7DQo+ID4gICAgICAgZHJtX2Rldl91bnBsdWcoZGV2KTsNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYw0KPiA+IGluZGV4
IDJhZjE0YzM2OWJiOS4uMjQ1OGM2NzUyNmM5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jDQo+ID4gQEAgLTE1MjIsMyArMTUy
MiwyOCBAQCBpbnQgYW1kZ3B1X3Jhc19lZXByb21fY2hlY2soc3RydWN0DQo+ID4gYW1kZ3B1X3Jh
c19lZXByb21fY29udHJvbCAqY29udHJvbCkNCj4gPg0KPiA+ICAgICAgIHJldHVybiByZXMgPCAw
ID8gcmVzIDogMDsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArdm9pZCBhbWRncHVfcmFzX2VlcHJvbV9j
aGVja19hbmRfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiArew0KPiA+
ICsgICAgIHN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFk
ZXYpOw0KPg0KPiBEb2Vzbid0IHRoaXMgcmVxdWlyZSBhIE5VTEwgY2hlY2s/DQo+DQo+IFRoYW5r
cywNCj4gTGlqbw0KPg0KPiA+ICsgICAgIHN0cnVjdCBhbWRncHVfcmFzX2VlcHJvbV9jb250cm9s
ICpjb250cm9sID0gJnJhcy0+ZWVwcm9tX2NvbnRyb2w7DQo+ID4gKyAgICAgaW50IHJlcyA9IDA7
DQo+ID4gKw0KPiA+ICsgICAgIGlmICghY29udHJvbC0+aXNfZWVwcm9tX3ZhbGlkKQ0KPiA+ICsg
ICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgIHJlcyA9IF9fdmVyaWZ5X3Jhc190YWJsZV9j
aGVja3N1bShjb250cm9sKTsNCj4gPiArICAgICBpZiAocmVzKSB7DQo+ID4gKyAgICAgICAgICAg
ICBkZXZfd2FybihhZGV2LT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICJSQVMgdGFi
bGUgaW5jb3JyZWN0IGNoZWNrc3VtIG9yIGVycm9yOiVkLCB0cnkgdG8gcmVjb3ZlclxuIiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgcmVzKTsNCj4gPiArICAgICAgICAgICAgIGlmICghYW1k
Z3B1X3Jhc19lZXByb21fcmVzZXRfdGFibGUoY29udHJvbCkpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIGlmICghYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyhhZGV2LCBOVUxMKSkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIV9fdmVyaWZ5X3Jhc190YWJsZV9jaGVj
a3N1bShjb250cm9sKSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiUkFTIHRhYmxlIHJlY292ZXJ5IHN1Y2NlZWRcbiIpOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgIGRldl9lcnIo
YWRldi0+ZGV2LCAiUkFTIHRhYmxlIHJlY292ZXJ5IGZhaWxlZFxuIik7DQo+ID4gKyAgICAgICAg
ICAgICBjb250cm9sLT5pc19lZXByb21fdmFsaWQgPSBmYWxzZTsNCj4gPiArICAgICB9DQo+ID4g
KyAgICAgcmV0dXJuOw0KPiA+ICt9DQo+ID4gXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVw
cm9tLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9t
LmgNCj4gPiBpbmRleCAzNWM2OWFjM2RiZWIuLmViZmNhNGNiNTY4OCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5oDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uaA0KPiA+IEBA
IC0xNjEsNiArMTYxLDggQEAgdm9pZCBhbWRncHVfcmFzX2RlYnVnZnNfc2V0X3JldF9zaXplKHN0
cnVjdA0KPiA+IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNvbnRyb2wpOw0KPiA+DQo+ID4g
IGludCBhbWRncHVfcmFzX2VlcHJvbV9jaGVjayhzdHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29u
dHJvbA0KPiA+ICpjb250cm9sKTsNCj4gPg0KPiA+ICt2b2lkIGFtZGdwdV9yYXNfZWVwcm9tX2No
ZWNrX2FuZF9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gPiArDQo+ID4g
IGV4dGVybiBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zDQo+ID4gYW1kZ3B1X3Jhc19kZWJ1
Z2ZzX2VlcHJvbV9zaXplX29wczsNCj4gPiAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMNCj4gPiBhbWRncHVfcmFzX2RlYnVnZnNfZWVwcm9tX3RhYmxlX29wczsNCj4gPg0KPg0K
DQo=
