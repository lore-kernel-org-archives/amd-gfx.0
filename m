Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F121C0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 01:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BD810E0F5;
	Tue, 11 Feb 2025 01:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oa7JnB7d";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8490310E0F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 01:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxKd2zofsicivDyy6/nQHmnBnHQhHtDEf3YWljo8DxuYrfXVvs57jTpZu3WJcQe2m58jsJ3MhIQOsFcQr7sNZhBiCczT5ovQy1YvM6s9nd/G43V/7ns+m0YnxTKdzlmmDysOaWR1IStIZjjiUavhDIa/iDyF/W78XfVSQm6mqld36+jhJDsdJsTh1R6JkAhlKmyACzD906JBfF2NNCc3PoDCvSwlIUwhb+dT4bb5CryG2vRMyjBR63jpA+VcRDC/TAGY3MiLG0i6l1mxTiagBAgy8I78mgaeg0zHRtbNvEitJedF0BqndqJ/KzvE+49nSoClroF00XbAvZ8PZvMXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTBSRN/Ko3kGiSryJhgTDFTp3BXtpRonrBPVZ4wGY68=;
 b=U3cuLRzQhCjIP03URZ6xoGF8MQSbXhc/TTo1m3aVOttvJwUhRWnfY+FKyKAye5Pa7nlLUFKYy+4ExcTTPHOb46V8Gfjc/damxJ1sE2PQA5fuv+y22NzLLLaozogeSZnsJbZrqXJBrA9Z9B8LnZgH2j4XK2FXeG7Eeidf8wAQXGlSIt6w8ePtlJLxtD0Qh8kTPOnPSaKbLp+f54925q8BHu0rZj5lcGIfR3dyTC159i8kS5OvZK04ugHp/gO9QXC1WH01lUhJkPRaESFUpDs7hgsIc4cdBY9KM4sQFneA1orb+dxGzt33Om07nXlXUZoJ4MnxoMTSMHgJ5V7G6Kw38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTBSRN/Ko3kGiSryJhgTDFTp3BXtpRonrBPVZ4wGY68=;
 b=oa7JnB7dkWLgYRJY+vmZMSffDxGMN4WwU4AX6ramrn2CK1mJgAmxd++ithGxSY0Jk7Bxabs4D0qjBBUkcYrGhQtSlzKISrm8wLIIngK/Oq/aHuvElD1g+vwru7S/hWA1/TwZti9/rZ5BLdFlJfO7i6YnKJpzMp0J9o7FZi0dYEA=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Tue, 11 Feb
 2025 01:28:18 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 01:28:17 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH V5 1/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Topic: [PATCH V5 1/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Index: AQHbfAF2fSeh0fzs6UmXk60gMya4g7NBT7nw
Date: Tue, 11 Feb 2025 01:28:16 +0000
Message-ID: <CH0PR12MB53726E14765DD75B4F00BEEFF4FD2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250210211904.281317-1-alexander.deucher@amd.com>
In-Reply-To: <20250210211904.281317-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=923d060d-40e1-4ada-bcaa-5fbf7c2d0857;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T01:25:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|MN0PR12MB6342:EE_
x-ms-office365-filtering-correlation-id: 8f0bc4f9-4c67-4617-48bb-08dd4a3b5c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?SGJpUUkwN3NxMmhNM1VDQktpQW53N3hxQnpXNEk4c1ZvWWZrL2c3c3BEaE1N?=
 =?utf-8?B?THA3bTVpYWJQaHVnYWpFTFlaVy96aGgyTnVNL3B1Q0ozeWRXeC9sa2MrWU54?=
 =?utf-8?B?d3JJekExVTB3eUZQRXozVTlvZkE4SHpPbzNoVUU3NThXVlZwUisza0xQSHJG?=
 =?utf-8?B?aDN5T3ZVWGdnMFA3Rk9lemdGaHNXTDRNUFVRNWlETVdhdGNZc0RaanlZM1hP?=
 =?utf-8?B?bTNwSDVpY0dEVGJ1WE8vcnQvczh0Uk1RVlVmZnZ0OE1iSVpVWkdPaEsxSGI2?=
 =?utf-8?B?OXNwK0Z2eFhpUmVFZzZaTmlsN0FPTDNGQy9Gekg4MUc4T0Y0R3dKOEQrS3BY?=
 =?utf-8?B?RGZDWjJ2czN3V2xJaGRiT0RQMDlWbWQ0dWV4S2VWN0RGSFdON0hhVUwyQTgv?=
 =?utf-8?B?VFJGcTMvUDdlRGJEbzZaOHNJdDl6Rk54cUVsSTlXUmNOUkJtUkV1WW1CWkd5?=
 =?utf-8?B?U3R0S2JDaSs4MUJ6UjFUNFBuZ0lpbHc2UnFHeElEaDlYcWlSV1FkVThhcXFV?=
 =?utf-8?B?SUNYcEhNZXBDTTFWNVZBMXVtK3ZhL1hvd2dxRVczZkp4Um9Va3hqVWEwNUVO?=
 =?utf-8?B?cnNCQndIRDlrM0Z0VHFST1cwRG0wT2orVWRpb2lwckp0ZkFpeUZqang5VGFl?=
 =?utf-8?B?MGVnVGxVcXREWmxxdkkzZFdKUGdtdVB1UG9KTlJiQWRxWXViTUZQYlMxdTFX?=
 =?utf-8?B?QmRQV1l3b0lpZDFuazVkSVQ5bXdPVXVpVTNybnFUalhYLy81RFhMZTE2ZGdX?=
 =?utf-8?B?cno4TDBmUFBVUndoWGx2cTc1ZkJ3NWVGbGRTTXZjeEtTTDh4ckN0cm1MV0Fy?=
 =?utf-8?B?dURsVkFvRU0wVGtKME8wT01NWEhFZWRZTVhaaXdlR0VWTzlXRi9PMm5DME5m?=
 =?utf-8?B?ZjNBR1VzYnR4OVZMazVsWjZRdFlNU1ZBNFh0WEQ1dXArc1duM1V4T3dnayt6?=
 =?utf-8?B?YmVoL0Y0SUg2anB5ZGV3cFczM3BSTzJ4a3BPUWtvbjdBSjFsR2owUkxVdFJN?=
 =?utf-8?B?YWlYUGpNSFNvZVl1TmlkWVRqejkxR1RxenlaRTRBOFJBbm5hSVI0WVBMN3JX?=
 =?utf-8?B?TW4zWnMyZXRCMTZ1RXZsMzFDQkdJdTFuSStPMlBvT1UvckpiOHV0YjE5MFhr?=
 =?utf-8?B?bGRSVGlmSy9TdTJpSXlaWUNvM2JYdXMxL0pFQ2NxSkh2bHkyaUxEN1pLTG92?=
 =?utf-8?B?RlZOVXhvdDdXbjdLb0psQnp2d1U4YThQVnJrQ0grV3ZmRHg5VjZJa3AxVW1v?=
 =?utf-8?B?THlUazJOZ0dXYWZ6TWpUVG84UzREaWJrQUEwTmNocDBDeWtNMXQyY0d3MWhi?=
 =?utf-8?B?NUtKaHAxcUdDYVJnVWMrSDVaVkdKckFnZWxQN0hVZ1UweW5BbUNHVExYQzJ5?=
 =?utf-8?B?YUVpQkk5bURIWHpuSEdSbmxCcFF5SGd1aVE4YTQvUFZRZzhCK0haMjg5ZHBx?=
 =?utf-8?B?c05nWldEWmFMandTNmdDT1orVTFBTEFRTXhHcWJIWWRYQ3VoV01Wc1BYcGNE?=
 =?utf-8?B?Y3Z5WGJicHZ5bmJlSGlubEdnN0ticFNRK3ZMQXdoS2ZjM2tVVXBQK2ZPMjE3?=
 =?utf-8?B?S1RMOWZFdnlhVnVyQ1hKb0grNzAzVEprOW4yQnN6RzlFU05yMS9VbitWUXZZ?=
 =?utf-8?B?dFRDVSttVWZyTXZoUGUwckszbGZwaGxDdWpnS2E3QnpxYjFTQko3RnAzVGsx?=
 =?utf-8?B?ZzR5QmRTRkV0b0Z6bkFOTG9GVEdaaEdjNEdaY3ZBaTkzL3lGTXpOS1B6VHpB?=
 =?utf-8?B?S1hJeE1LRURaRWwyRnBpNE5QOHpwbTRSVkI0bCsxOEVzeUhkYTdXbW5CK3pM?=
 =?utf-8?B?d2ZnSnByT2RYMVRyajdyRWlxUzFiOHJRdkJHMXZSM0JzckoyUzY1NjhVUkto?=
 =?utf-8?B?eDVkb3VQVkYxYVQwRGpqcC9zSXJpT1dZVFUwbDZDZVZNNDZlSi9XSU01MzNC?=
 =?utf-8?Q?U7qgEzfbgQAsHPQfCRtd8swWFj63+loC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0FBVWd4NnVaZ2FKeDFiK21nOUdDa0NvR0JSOCtEKytxUitIa3VQcW1ScHp4?=
 =?utf-8?B?UzZLVWRGYmNUZWhnOTJueHBNeGxOSWI1Y2ZCSnhPbUZmNkdOSkhiTi8wV29B?=
 =?utf-8?B?WTFSSVowbVJmeHZXMEFMb1hSZE1aaWUzcEhHamxld2VLWHJJbnN2Wi9ZM1kv?=
 =?utf-8?B?RWtxTm1wUWpOM20rVTgrdWxRdWtDSGZ6TmdOdEhWSWJ0TFVZMkEzWXM3ZFJm?=
 =?utf-8?B?ZjU0Z2lvYnp6NUUzUkJHend6UkxwTUVWTG9FQWdsbDJzUlpFaGljTDBSNEZj?=
 =?utf-8?B?SFhoalRLTllBTVhieDdXb2FTVmpXbE1wVkpCWnY3NGkxZ3BvckZGd1hIdFlX?=
 =?utf-8?B?R2pEOEVNc1BNUXQ0S3pCcVpUZFMzTk0rVjVNRmZrQ21HNm5BbXk4Y3dqaTBs?=
 =?utf-8?B?cjVQYmdSRi9VTlF0SmVaZ2FoRU80N3dJZ1hWK2NYRnJBNlVVMTR4WDBrSlZC?=
 =?utf-8?B?K3p6YjB3bHpOOEFuMW54bEVxOWIvdktWeTczcW1PUWJwZ2ZIMkdENmUrOWt2?=
 =?utf-8?B?UHBiMzVBWk9SRThRZmx1NmdZSVlzK0xEcHQvd2pBVWdjTHJWMUk2ZUViUG1s?=
 =?utf-8?B?NEZmWldKeGNUTk1HbHd0N3NVQXU4WWcrQS84aWVTQkJ1dks1eXhnV3hScWx4?=
 =?utf-8?B?d09PM3Q4SVRvUFg3Z05Xa0ZUQ1VQOElxYnFtODEzSEFvZTZIcnIyUXR0WXBR?=
 =?utf-8?B?YjRTTElFdnJwY0ZMOWNEYU5WYTUrcGJyT2ZveTJqQXlMbU1tSVBsWHRxeVMx?=
 =?utf-8?B?MEtRTVFOMmV0cXlzellSK28rYTlyTkFzVEZ0YXFLYnl2Q3dJeE5hUm0zY2RR?=
 =?utf-8?B?MmtTNVZ5c0lSSGkvYXV3NzB5SklzOUw2ZkZUdXJMbnpHTU5WemxYSjNkSm9n?=
 =?utf-8?B?SGdJUG5wUEJpNzl3VWVFSEdiYytUY3FBWmdwS011am92ajVDWmJJVXRSaHc3?=
 =?utf-8?B?Ty9KYXVtYnR3Uk1UTUgvSjFPYU53MFFOVW9ZNGFtVGkyc2VaZkpvWUJTZjk1?=
 =?utf-8?B?NUVseFVuY1pkRTBMOWtpaFVYaHBCaXNsUi9xa0NaSUgrOTJpcmN1Qnh2bFNZ?=
 =?utf-8?B?UHlaSmVRTmhDUFdjSlc2UUs3M2JzeXorMUc2a29iT1BLYVBtNnFDcW1EUm00?=
 =?utf-8?B?MDJvemsxYXJ0K3NaanlSTDFVdHYzS2hud2EzMmcwa1kzMDhuSUlERS9qSVlP?=
 =?utf-8?B?Y3pBRm5ENU9zQlI4K28ybFA0MnhBSHp5d3hCNWVaOUpISC9Cb05rTEl5OUds?=
 =?utf-8?B?MVNLRjNNSzZ2TzhUZGxRajAxNTgvUUhIcVd3c0QyOXAvaHkvdXVDOVhuNlFB?=
 =?utf-8?B?cWZDMUV4Y1ErSFpjbmZwS3g4NDNEamRUQnRyLzUrVlhIdlhjRklvM0lqdS9D?=
 =?utf-8?B?bW1mUHhLMGRnUnB2MkRJaXdiUGpqTCt0NGRwRDZ6eVZwdnZScWduRXFHUENt?=
 =?utf-8?B?OE04MitGVDRXeFEwa2VackVOV2poSEJHNFQwdlVKQkt3cDFMR1A4ZE03VjVx?=
 =?utf-8?B?RlVhTGJKRGV5cTB6L20yZUF2c1duZ1oyb3pvRW1SUllZeXZPVFFCTTZUUk1R?=
 =?utf-8?B?VWFJN25IRmwzYnFTQUJkc2x6a3ZhbnBHeSt1WUpTTWV5b1ZXMTdtYWRKejcr?=
 =?utf-8?B?ZkJvMGF3Y0h2eG9zaGhyNUhrQ1NqeGlxdzR6UVVFSjBWSUdYMXlRODF2bmEv?=
 =?utf-8?B?ODBYdmJZTUpQTGVhbzUxL3g3dHdNUE5NakdLQm1Sd0lZOFdZYjRtZSt6WTJ2?=
 =?utf-8?B?ODI3bXhxc2FSMU5rbEI5QzB4N1JlZFRJRjZweEJxaWlMekU5ZFZqZVVSZ3o2?=
 =?utf-8?B?SkNDZjRBWnp3N3RWZHNwQkowQVNMd3RmcUQ3WEJ1MzhLSlVmMWpsdm9iK2RJ?=
 =?utf-8?B?dHZpSVJXdmtFZVZvK1NJaWlKclhoM3pNVlNrL0ZoaEJ0QTBsRHR6UXdNWDRR?=
 =?utf-8?B?WHpicC91MDYzYnI1YXR3MjlpNkJoWTYxandkN1VwSDJFdTdOM0d5YnZQTFBY?=
 =?utf-8?B?Y0FVbGc5NTl3L0lweXBOa01KUUZqUWZlRzZmNmlab1RQQk5RUVZjT0w2cXBO?=
 =?utf-8?B?K05DV1dIQUNaSlhHS0EzKzF2T3F5M2tuaUZqeCtEbVlCalNtdEN5MVVhYjhO?=
 =?utf-8?Q?rOdE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0bc4f9-4c67-4617-48bb-08dd4a3b5c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 01:28:16.8859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a04Jo7+cd7T+g34isQO/LC5MzkQEKy8FkO9qzQdyu5XVf5WOvjohcACjyL6qUCrJKbeMOH1QDklII93qj5a7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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
Cg0KTG9va3MgZ29vZCB0byBtZS4gIFlvdSBjYW4gY2FuIGFkZA0KUmV2aWV3ZWQgYnk6IFNoYW95
dW4ubGl1ICA8U2hhb3l1bi5saXVAYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
ClNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMTAsIDIwMjUgNDoxOSBQTQ0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FO
LlNIQU5NVUdBTUBhbWQuY29tPjsgY2FvLCBsaW4gPGxpbi5jYW9AYW1kLmNvbT47IENoZW4sIEpp
bmdXZW4gKFdheW5lKSA8SmluZ1dlbi5DaGVuMkBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NClN1
YmplY3Q6IFtQQVRDSCBWNSAxLzJdIGRybS9hbWRncHUvbWVzOiBBZGQgY2xlYW5lciBzaGFkZXIg
ZmVuY2UgYWRkcmVzcyBoYW5kbGluZyBpbiBNRVMgZm9yIEdGWDExDQoNCkZyb206IFNyaW5pdmFz
YW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KDQpUaGlzIGNvbW1p
dCBpbnRyb2R1Y2VzIGVuaGFuY2VtZW50cyB0byB0aGUgaGFuZGxpbmcgb2YgdGhlIGNsZWFuZXIg
c2hhZGVyIGZlbmNlIGluIHRoZSBBTURHUFUgTUVTIGRyaXZlcjoNCg0KLSBUaGUgTUVTIChNaWNy
b2NvZGUgRXhlY3V0aW9uIFNjaGVkdWxlcikgbm93IHNlbmRzIGEgUE00IHBhY2tldCB0byB0aGUN
CiAgS0lRIChLZXJuZWwgSW50ZXJmYWNlIFF1ZXVlKSB0byByZXF1ZXN0IHRoZSBjbGVhbmVyIHNo
YWRlciwgZW5zdXJpbmcNCiAgdGhhdCByZXF1ZXN0cyBhcmUgaGFuZGxlZCBpbiBhIGNvbnRyb2xs
ZWQgbWFubmVyIGFuZCBhdm9pZGluZyB0aGUNCiAgcmFjZSBjb25kaXRpb25zLg0KLSBUaGUgQ1Ag
KENvbXB1dGUgUHJvY2Vzc29yKSBmaXJtd2FyZSBoYXMgYmVlbiB1cGRhdGVkIHRvIHVzZSBhIHBy
aXZhdGUNCiAgYnVzIGZvciBhY2Nlc3Npbmcgc3BlY2lmaWMgcmVnaXN0ZXJzLCBhdm9pZGluZyB1
bm5lY2Vzc2FyeSBvcGVyYXRpb25zDQogIHRoYXQgY291bGQgbGVhZCB0byBpc3N1ZXMgaW4gVkYg
KFZpcnR1YWwgRnVuY3Rpb24pIG1vZGUuDQotIFRoZSBjbGVhbmVyIHNoYWRlciBmZW5jZSBtZW1v
cnkgYWRkcmVzcyBpcyBub3cgc2V0IGNvcnJlY3RseSBpbiB0aGUNCiAgYG1lc19zZXRfaHdfcmVz
X3BrdGAgc3RydWN0dXJlLCBhbGxvd2luZyBmb3IgcHJvcGVyIHN5bmNocm9uaXphdGlvbiBvZg0K
ICB0aGUgY2xlYW5lciBzaGFkZXIgZXhlY3V0aW9uLg0KDQpDYzogbGluIGNhbyA8bGluLmNhb0Bh
bWQuY29tPg0KQ2M6IEppbmd3ZW4gQ2hlbiA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPg0KQ2M6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpTdWdnZXN0ZWQtYnk6IFNoYW95dW4gTGl1
IDxzaGFveXVuLmxpdUBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVn
YW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjExXzAuYyB8IDIxICsrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KaW5kZXggZTg2MmEzZmViZTJiMi4uMjZhZjBhZjcx
OGI1ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KQEAgLTc0Myw3
ICs3NDMsOSBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzKHN0cnVjdCBh
bWRncHVfbWVzICptZXMpDQoNCiBzdGF0aWMgaW50IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2Vz
XzEoc3RydWN0IGFtZGdwdV9tZXMgKm1lcykgIHsNCi0gICAgICAgaW50IHNpemUgPSAxMjggKiBB
TURHUFVfR1BVX1BBR0VfU0laRTsNCisgICAgICAgdW5zaWduZWQgaW50IGh3X3JzcmNfc2l6ZSA9
IDEyOCAqIEFNREdQVV9HUFVfUEFHRV9TSVpFOw0KKyAgICAgICAvKiBhZGQgYSBwYWdlIGZvciB0
aGUgY2xlYW5lciBzaGFkZXIgZmVuY2UgKi8NCisgICAgICAgdW5zaWduZWQgaW50IGFsbG9jX3Np
emUgPSBod19yc3JjX3NpemUgKyBBTURHUFVfR1BVX1BBR0VfU0laRTsNCiAgICAgICAgaW50IHJl
dCA9IDA7DQogICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gbWVzLT5hZGV2Ow0K
ICAgICAgICB1bmlvbiBNRVNBUElfU0VUX0hXX1JFU09VUkNFU18xIG1lc19zZXRfaHdfcmVzX3Br
dDsgQEAgLTc1NCw3ICs3NTYsNyBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9zZXRfaHdfcmVzb3Vy
Y2VzXzEoc3RydWN0IGFtZGdwdV9tZXMgKm1lcykNCiAgICAgICAgbWVzX3NldF9od19yZXNfcGt0
LmhlYWRlci5kd3NpemUgPSBBUElfRlJBTUVfU0laRV9JTl9EV09SRFM7DQogICAgICAgIG1lc19z
ZXRfaHdfcmVzX3BrdC5lbmFibGVfbWVzX2luZm9fY3R4ID0gMTsNCg0KLSAgICAgICByZXQgPSBh
bWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBzaXplLCBQQUdFX1NJWkUsDQorICAgICAgIHJl
dCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKGFkZXYsIGFsbG9jX3NpemUsIFBBR0VfU0laRSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1lcy0+cmVzb3VyY2VfMSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1lcy0+cmVzb3VyY2VfMV9ncHVfYWRkciwNCkBA
IC03NjUsNyArNzY3LDEwIEBAIHN0YXRpYyBpbnQgbWVzX3YxMV8wX3NldF9od19yZXNvdXJjZXNf
MShzdHJ1Y3QgYW1kZ3B1X21lcyAqbWVzKQ0KICAgICAgICB9DQoNCiAgICAgICAgbWVzX3NldF9o
d19yZXNfcGt0Lm1lc19pbmZvX2N0eF9tY19hZGRyID0gbWVzLT5yZXNvdXJjZV8xX2dwdV9hZGRy
Ow0KLSAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3QubWVzX2luZm9fY3R4X3NpemUgPSBtZXMtPnJl
c291cmNlXzEtPnRiby5iYXNlLnNpemU7DQorICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5tZXNf
aW5mb19jdHhfc2l6ZSA9IGh3X3JzcmNfc2l6ZTsNCisgICAgICAgbWVzX3NldF9od19yZXNfcGt0
LmNsZWFuZXJfc2hhZGVyX2ZlbmNlX21jX2FkZHIgPQ0KKyAgICAgICAgICAgICAgIG1lcy0+cmVz
b3VyY2VfMV9ncHVfYWRkciArIGh3X3JzcmNfc2l6ZTsNCisNCiAgICAgICAgcmV0dXJuIG1lc192
MTFfMF9zdWJtaXRfcGt0X2FuZF9wb2xsX2NvbXBsZXRpb24obWVzLA0KICAgICAgICAgICAgICAg
ICAgICAgICAgJm1lc19zZXRfaHdfcmVzX3BrdCwgc2l6ZW9mKG1lc19zZXRfaHdfcmVzX3BrdCks
DQogICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZih1bmlvbiBNRVNBUElfU0VUX0hXX1JF
U09VUkNFU18xLCBhcGlfc3RhdHVzKSk7IEBAIC0xNjMyLDcgKzE2MzcsOCBAQCBzdGF0aWMgaW50
IG1lc192MTFfMF9od19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KICAg
ICAgICBpZiAocikNCiAgICAgICAgICAgICAgICBnb3RvIGZhaWx1cmU7DQoNCi0gICAgICAgaWYg
KGFtZGdwdV9zcmlvdl9pc19tZXNfaW5mb19lbmFibGUoYWRldikpIHsNCisgICAgICAgaWYgKGFt
ZGdwdV9zcmlvdl9pc19tZXNfaW5mb19lbmFibGUoYWRldikgfHwNCisgICAgICAgICAgIGFkZXYt
PmdmeC5lbmFibGVfY2xlYW5lcl9zaGFkZXIpIHsNCiAgICAgICAgICAgICAgICByID0gbWVzX3Yx
MV8wX3NldF9od19yZXNvdXJjZXNfMSgmYWRldi0+bWVzKTsNCiAgICAgICAgICAgICAgICBpZiAo
cikgew0KICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJmYWlsZWQgbWVzX3YxMV8w
X3NldF9od19yZXNvdXJjZXNfMSwgcj0lZFxuIiwgcik7IEBAIC0xNjY1LDEwICsxNjcxLDEzIEBA
IHN0YXRpYyBpbnQgbWVzX3YxMV8wX2h3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBf
YmxvY2spICBzdGF0aWMgaW50IG1lc192MTFfMF9od19maW5pKHN0cnVjdCBhbWRncHVfaXBfYmxv
Y2sgKmlwX2Jsb2NrKSAgew0KICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlw
X2Jsb2NrLT5hZGV2Ow0KLSAgICAgICBpZiAoYW1kZ3B1X3NyaW92X2lzX21lc19pbmZvX2VuYWJs
ZShhZGV2KSkgew0KKw0KKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X2lzX21lc19pbmZvX2VuYWJs
ZShhZGV2KSB8fA0KKyAgICAgICAgICAgYWRldi0+Z2Z4LmVuYWJsZV9jbGVhbmVyX3NoYWRlcikg
ew0KICAgICAgICAgICAgICAgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+bWVzLnJlc291
cmNlXzEsICZhZGV2LT5tZXMucmVzb3VyY2VfMV9ncHVfYWRkciwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0+bWVzLnJlc291cmNlXzFfYWRkcik7DQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5tZXMucmVzb3VyY2VfMV9h
ZGRyKTsNCiAgICAgICAgfQ0KKw0KICAgICAgICByZXR1cm4gMDsNCiB9DQoNCi0tDQoyLjQ4LjEN
Cg0K
