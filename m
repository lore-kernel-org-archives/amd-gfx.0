Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC70C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 12:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9218F10E36E;
	Fri,  2 May 2025 12:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRTMAcLS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAEE10E36E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 12:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt+k4MC2zON1vlIUJhr4A2edgCTp5e4i8tS3HrSdRnHwI9dIzZMA+PbM0WBiy+Xo3bL8pzTMAEFvA3h1E9BkS6//AlYhdKowaX3D4Pwvp7bg9xsl/ahkw9nQVQAdo+gHrNUQkcKiXHBrv9cY7PIRX0rzH4xV0fv03QEKvG97VclGApRbVkBm+6uNez4EN/tsbCEqZpx82enz8ZH4gGZvnGYEibsmvkBbDCruLlPtim4fO/9gjBPssI2UVOq96fnu5OO3hE9oVdDGI8wNOiI5rrsLle+DJUjwF5qEUQAO/TT0i1zoZWdQlscsVnrv6Q3c+yRgl6umbb2JOubt6frbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwGJmNKmef4aCGasDlXxuzbHWD5xCrWxAO5G3DRlXMw=;
 b=PUNffUb899Yo7pTVZwr+oBpaBKvm18B/5suT5b66uK1RjSc3q8dKfJsNSr/9zn6ma7XYJSAafN3nEPdqxY240jejy549iPQAVyCuvkEXig9R0YiT/bgQe9YxXw02wM13Oj/D8cJzmf1SAxP3QMUEqQJUezrurTPx2BaUz4xE/3asGzuwy9eNu14Eo9Z6zN7GLhCYzgMx2tAHVlym7feQ49XobNbaF79Qqq+B0finh4E8YwrIgJeXqasRj7M4SHes9jn1TSq1U/P67izcojN0f6iEcSXBt3fbtwnEVxR8XLQUTcobzLKTQ3b7wfBAb4pgVyYrR1RGeW8o6aLqNz+BZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwGJmNKmef4aCGasDlXxuzbHWD5xCrWxAO5G3DRlXMw=;
 b=DRTMAcLS8qrHfNHdoGngm2zU3uicAObmyto2Fx7f8hI2bZGLfTyqAAYMhJbKLIvqbeVceaT/HnpvlcqR2Y7xRlKUKph+E0jQzc5BbSTtcfLmfBOQN275oVDMDmr3OWsV04jjjyxMNz+b3OMRzYQjjIxZr854xlXabpcVLLvRLKY=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Fri, 2 May
 2025 12:26:01 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 12:26:01 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 1/2] dma-fence: Add helper to sort and deduplicate
 dma_fence arrays
Thread-Topic: [PATCH v4 1/2] dma-fence: Add helper to sort and deduplicate
 dma_fence arrays
Thread-Index: AQHbuem760ZMOa4yj0+k5ctsa7HgQLO++zKAgABLlMA=
Date: Fri, 2 May 2025 12:26:01 +0000
Message-ID: <BL1PR12MB5753AA8AB1E425797A239BA4938D2@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250430160521.35670-1-Arvind.Yadav@amd.com>
 <b3f05cf9-2d96-4846-b768-834f0295aa39@amd.com>
In-Reply-To: <b3f05cf9-2d96-4846-b768-834f0295aa39@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fc1b97fa-5f3e-448a-8f8b-79dce5da1dc0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-02T12:25:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|LV8PR12MB9110:EE_
x-ms-office365-filtering-correlation-id: 6943f724-728d-4a3d-8506-08dd89748040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QzNweUlXdmxLcTJtOEJPa01vVFJIa2lJZVVSZW5kN3I2WGZVTDhTTXAxaHZa?=
 =?utf-8?B?a2tGQ2t1ZHk0ZFNkdGYxNTJOWGpINmdPNFA4OEFwWkY5dEdmd3N1K05QTFFD?=
 =?utf-8?B?b0taMEJudTAzRjJTMTJteE1nY0p1QkhqQkkxRFg2Q0JOemc1ZWRMMUw2VURI?=
 =?utf-8?B?a01yQ3hUaTJkaDQ0NVRKTUFuWm41UkNDSE8zOFdTelpNZUpRYTErbzA5UHRX?=
 =?utf-8?B?cituV0tCNE5CUzlFZ05QNmg0K3V5Uk1jZE1oVXhNMzhLTmNieUc4Q1dGRVgw?=
 =?utf-8?B?anV1c1h2d1VHNFlDWEM2dXlmZVdiemczUG40enlQU0hnN3ZFRStMZm9zMXR3?=
 =?utf-8?B?R0dFcG9sUCtuR3VMSHFMdVg2UHg1MEFMZUxkOG1YYng5WEMvaVlIdjV4bzZv?=
 =?utf-8?B?WGxKZTdic2xRbVFzUG8yM1h0Wjc0b0dOTEg2REF3QnkxQmdwZ3A3QmFySzhy?=
 =?utf-8?B?MnpzR1I3SEhVZjRUbG9QaGRtTUYrQ2daRmg3TU4zc01sWnFXVWtVWEhvUHBx?=
 =?utf-8?B?aS9LUDlqbXc1ZERUSGw3WUdIZjJ4NEhtSUdrOTVnVWxFbFc3dDFlR2h1ZEJK?=
 =?utf-8?B?YkxkeDVwSVZmenVaVnJMS0lTVnZFOHplM1pCSk1VbEVzZk1DbjlsR0Fzdm54?=
 =?utf-8?B?bEMxMU9XSThvSEt2aEo3OGd5eStCMVVYWjR3THoxbjIyNWRIRGxnZEhLMXFu?=
 =?utf-8?B?Q1BQaU9zcW02L3VjckNVWDh5R3BBOFVpaGJEWlBicE4zMEJPckJUZGFJbWpQ?=
 =?utf-8?B?dUtPY3gvY2JGdnhUOThrY3p1THBjcFNCTXdHRkI1Sy82NFVmeXZHd2ZWN24v?=
 =?utf-8?B?ajRUcC9KNHpRcTVmanUyWmptb3JPMXFOSkkwOEQ1VXhrTVEwMjh2b09JOXFO?=
 =?utf-8?B?ZG9WeGZKL0JLRW9mMXRpV3lCWVkxKzRyY1FMbHZqMHoxSFpDOHpVZDlMTllJ?=
 =?utf-8?B?RFh2cTlkTVlJL2Z3cUU0a3I1MXV1Yi9zK0lNelZ1a0pVcUtGSkZiMFVObk9t?=
 =?utf-8?B?a3Z2Zk81azNRaEtKNTZzL3FISUNZMkFKcmNmdjJybkpzbXBHRTVSZEZMRVlt?=
 =?utf-8?B?SlhjK0Rna2htQWxTRnNBU3pIYm8wZ3p6cnpqRHNVNDdMa21pVllqeVNDT0tV?=
 =?utf-8?B?QkJpVXJMZ3gzZkxhM0ZSSkxrbHd1REdPV09uRzlLN2JGQjQ4UWZSc1V4alg0?=
 =?utf-8?B?eC8yU0Rjai9hWjdWcDN4YnRzUjJsQWgvbHpyM1NjbkFDMkhzSituZnhOa1hM?=
 =?utf-8?B?ajRudE5kK2ZuRXpmQ21PWWR1SEJORnpQNTB1VDV4bHowdVdoOE5RcWJmbVpu?=
 =?utf-8?B?eDFKYlhtcWU0cUQxZkEzbUk3Y0RWNlQzaXFQU1oxYTJCVUZ6UGk4Sng1eDFG?=
 =?utf-8?B?ZFJGT2UxNFpLc2dTRStqTmhRbmtHK3FmQ1hYOFVTQ1NJUUFXcHREcllRdGR4?=
 =?utf-8?B?djhiZDA4Wmo2cmtCcHR3OFBtZStBU2FnVWJNZVgwUWlHaE9jQlpuamJ4Uzlp?=
 =?utf-8?B?TXkwTGxMdERwaEFqRHN3U3AxUjRTcEJ6STdMVmM5K3lWYUducEQ2UGc2a0FI?=
 =?utf-8?B?dlM2YlFpL0R5c2hrQVFvUUhPWDAvVWR6ZklheWRsYzZTTDh0dW5xaDZRNDlU?=
 =?utf-8?B?R3BZUEdHOWpnY0l3TWQxZko1QzBjcjRHNHNvRG9GUGRESGJDN1lxdWdjY0Zo?=
 =?utf-8?B?dk9CWUVpQjNzYlVxeWV3cmk1blVmRk4zbGFOV2J4U1Q0Ri8rcVJLZFhjL1N0?=
 =?utf-8?B?NFpPbjQvaHJPS0J4NmJHTG1VWkxkNjN0Y1NPc1A2THo0dnFVVjlaNE5xZTNU?=
 =?utf-8?B?ZUU1SU95Z2MzdnNlV01tZ2hnUzBzWVBiKy9abTJPZlR6dFdVV1VYRFdXVXhh?=
 =?utf-8?B?WmxFRWR1eVpiaHZjVkpWTCtKRTU1VGZwTjFkQ244aE5vMHA1MHJneUxzVTJC?=
 =?utf-8?B?czZwaFlnY2ZTYTd2RGprN0gwN2hsSDQrOTgxV3Z6b3pXaC9yZGVNZGY1Uk45?=
 =?utf-8?Q?6fR2c4JoKX/gBt4FiXdYhXd+CW48lI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2tzbXQ2dWQ1YnIvOU8yQmN2NnhJQS9Rc0FpVlhITEYzRFM5VWVPNkRyQlhT?=
 =?utf-8?B?QmlhTnpucWdZRmhQSVFwTk9OZVpnTFRLQW80SmNPNjhPL2E0TERrUkFCK1Av?=
 =?utf-8?B?SDkwMjFPUlQ0Z2ZGN2RUUFlhcFdIMXp5Y1I1YW15cCtDY0o4VnB4WFBIOVAz?=
 =?utf-8?B?TkR0dU1oTzJwekpmdkpNKy9PVGNvOCtmQnY2U1B3YmJNMlJGU05KdE1lS044?=
 =?utf-8?B?WUVqYkNXM1kwVU9BY2lxZXQ3cjIxdUpvTmtBWVMzTUQrNTNRUlF6bUhvZzlo?=
 =?utf-8?B?b3AwZDc2dWNOaTQ3ZkxEaFNXeHNTSDBuN2tYemY5OWVCdVlQUGUwcHhROTI3?=
 =?utf-8?B?d3FXd20zSENGOS9VVHlFSWIvTWlzcGpILzRuTkg0WmRtNjF6TEdjbUw1UGNM?=
 =?utf-8?B?T0prU1g0UDhGalVnbzNqaG1PNm1vVW82N2l4ZUgxcG5MSUU1ZERRTWRFczZE?=
 =?utf-8?B?V01yQytTT29CWVlkemlFazVDeVhVYTZGeXFwdWVkTG55WGlKSUpwL2haTHly?=
 =?utf-8?B?QU1BTk5pQXVpVXFGM0dQOGEyTXR3T0Z4Rm93MFRNbFBEbkRLSWxBb2ZoUXZl?=
 =?utf-8?B?T2pZNG1XUStRa1JBb0VpL055VGE3akFZV3Y3eTR6VytDRE5LeDE5UUVScUZs?=
 =?utf-8?B?N2pWaHlVSE9sRDRjLzcxU2x0S0Z1V0VscTE0Q3dQT2lSS3l6eXArd2U3WXJw?=
 =?utf-8?B?SzVXYSs0RmJ2bktRYmNXay9vVFpkdENZaW9tYmZEM2RLbHcwdlZqN2xwN1d3?=
 =?utf-8?B?bVBlcnpqd2l0TWR2Q0FsR2RJNGpVZU9FYjFzT3BUQlZ0Wk5uRzVJa2VHT01t?=
 =?utf-8?B?b05KeVZUU2pyanB4ZlRheFpQV3lWcjRNcjU4YWplMzE1MnBnem43V2pQNUZC?=
 =?utf-8?B?R3ltajRGSTVVRXg1VnhDUkVEMW9xMEpkZjVLOEZodDZ4Zis2dU5JdDgrdlhn?=
 =?utf-8?B?VHk3NDdKZnJNenl1N0RDSkVKUHQrRHRkdWtrNit1N09WL3craXlEZTl5cDFG?=
 =?utf-8?B?R282S1phNlcrT2RKUnlWdUtQRzBxTGg5S0lJQWpoY3piSFRpN3gzMDhXVFhU?=
 =?utf-8?B?bnF0OUN5SDcwOXJHNnpjMmE4SHByQXZEVlM3Q3doRThhNGNoRHg2LzZjOHBu?=
 =?utf-8?B?U3pLNGNCZ2YxQlNGRDU2QUtUUWJBcnFiM01lYjg5VFBpeFBtVHVnWVJPbHBr?=
 =?utf-8?B?K1ZaRHRQd3QycGJ5SVc3bXU4UDcyeFlKN0tSNWJGeVJGQkgvdlJyd05SUXlh?=
 =?utf-8?B?YU9Lem52c1ZsVUNKdldzY2FyRmNIR0NERDNHelRLMFNKTkh4bUJ3QWxGNE51?=
 =?utf-8?B?YXZLakM0d2gzVFh3dURlSU9RbW96UlRlUm9KRHlQK0Nmakx5dW1sUDZITFhr?=
 =?utf-8?B?c1hRUzZXZnl3Q2x5WGM2a1laQzFFL0tHQ1ZoREl6WGxnTVd0LzFnR01NdW9C?=
 =?utf-8?B?WVhSNnpuOVJ5ZHgwK2xsNkg3R2tRNEFnaFBCVG1WS09wYzFDT3lFTnNxSS9B?=
 =?utf-8?B?N2tqOXEwb0QzREdxY2lUZC9RRmVsalRWOHQxRmUydEl6TFpuTHdBdmNSSmRs?=
 =?utf-8?B?aU9SQy8rU2ZXQlRmRitQSDN6VUFxUzN2dllLbzI4MDE1eXdYQzc1bWx1amZB?=
 =?utf-8?B?aHRWb2JQZTJoMFR2RkNKOHNEa3VVL2tCZXdWUllVQ1dsS0x4c1NibHBXdkY4?=
 =?utf-8?B?KzJ0dk05VVhFei9UVjFxdmhmczh0ZFI1aFJCQ3Q1LzVPalFCcFVobS9reTR0?=
 =?utf-8?B?N1NJWGk0SFdUR3dSdkt0anRRcy9wRHJXekU2ODBuQ0I5eDFyYXlWTDlpRWgv?=
 =?utf-8?B?ck1Zd1dZbEplTlBMa01wa3RLSHcvbU9mTnVHSDZteVQ2eUtsbUlqWTI4bVZN?=
 =?utf-8?B?elhjcVlMVVVzcGZTUk9yYURoeWlWUHdIbWxJM2gyQ1Y2bUtkR1ExUDlpMUtl?=
 =?utf-8?B?VDEwY2lTdnp2SFlDcG5LNVB6LzA3VUVjQzZ4TWsveThibGR4K2lvL3lwUFZw?=
 =?utf-8?B?RDE5RkthVkR6RENMR1RTVlBFMGZLcFVFbyt5R3R0OW5ZRzlCdDN4bnppaFFU?=
 =?utf-8?B?by9FRlExbVYyVzI1UHh3UzVDY2hGcS9qZHplSHRyMEtDWmFsdFY5cVpNYlRV?=
 =?utf-8?Q?AWxY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6943f724-728d-4a3d-8506-08dd89748040
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 12:26:01.6802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07didphr4kp80jv6P7+YGmgWnmv+7/9JUNvfLIKVHWkUHSFy11COJdU1PJz91GaIxJB/qu1xuUEJa9MfH2BkMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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
Cg0KUmV2aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogRnJpZGF5LCBNYXkgMiwgMjAyNSAxOjI1IFBNDQpU
bzogWWFkYXYsIEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0
cmlAYW1kLmNvbT47IFBhbmVlciBTZWx2YW0sIEFydW5wcmF2aW4gPEFydW5wcmF2aW4uUGFuZWVy
U2VsdmFtQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjQgMS8yXSBkbWEtZmVuY2U6IEFkZCBoZWxwZXIgdG8gc29ydCBhbmQg
ZGVkdXBsaWNhdGUgZG1hX2ZlbmNlIGFycmF5cw0KDQpPbiA0LzMwLzI1IDE4OjA1LCBBcnZpbmQg
WWFkYXYgd3JvdGU6DQo+IEV4cG9ydCBhIG5ldyBoZWxwZXIgZnVuY3Rpb24gYGRtYV9mZW5jZV9k
ZWR1cF9hcnJheSgpYCB0aGF0IHNvcnRzIGFuDQo+IGFycmF5IG9mIGRtYV9mZW5jZSBwb2ludGVy
cyBieSBjb250ZXh0LCB0aGVuIGRlZHVwbGljYXRlcyB0aGUgYXJyYXkgYnkNCj4gcmV0YWluaW5n
IG9ubHkgdGhlIG1vc3QgcmVjZW50IGZlbmNlIHBlciBjb250ZXh0Lg0KPg0KPiBUaGlzIHV0aWxp
dHkgaXMgdXNlZnVsIHdoZW4gbWVyZ2luZyBvciBvcHRpbWl6aW5nIHNldHMgb2YgZmVuY2VzIHdo
ZXJlDQo+IHJlZHVuZGFudCBlbnRyaWVzIGZyb20gdGhlIHNhbWUgY29udGV4dCBjYW4gYmUgcHJ1
bmVkLiBUaGUgb3BlcmF0aW9uDQo+IGlzIHBlcmZvcm1lZCBpbi1wbGFjZSBhbmQgcmVsZWFzZXMg
cmVmZXJlbmNlcyB0byBkcm9wcGVkIGZlbmNlcyB1c2luZw0KPiBkbWFfZmVuY2VfcHV0KCkuDQo+
DQo+IHYyOiAtIEV4cG9ydCB0aGlzIGNvZGUgZnJvbSBkbWEtZmVuY2UtdW53cmFwLmMoYnkgQ2hy
aXN0aWFuKS4NCj4gdjM6IC0gVG8gc3BsaXQgdGhpcyBpbiBhIGRtYV9idWYgcGF0Y2ggYW5kIGFt
ZCB1c2VycSBwYXRjaChieSBTdW5pbCkuDQo+ICAgICAtIE5vIG5lZWQgdG8gYWRkIGEgbmV3IGZ1
bmN0aW9uIGp1c3QgcmUtdXNlIGV4aXN0aW5nKGJ5IENocmlzdGlhbikuDQo+IHY0OiAtIEV4cG9y
dCBkbWFfZmVuY2VfZGVkdWJfYXJyYXkgYW5kIHVzZSBpdChieSBDaHJpc3RpYW4pLg0KPg0KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzogQ2hyaXN0
aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogU3VuaWwgS2hhdHJp
IDxzdW5pbC5raGF0cmlAYW1kLmNvbT4NCj4gQ2M6IEFydW5wcmF2aW4gUGFuZWVyIFNlbHZhbSA8
QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQXJ2aW5k
IFlhZGF2IDxBcnZpbmQuWWFkYXZAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZG1h
LWJ1Zi9kbWEtZmVuY2UtdW53cmFwLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0NCj4gIGluY2x1ZGUvbGludXgvZG1hLWZlbmNlLXVud3JhcC5oICAgfCAgMiArKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UtdW53cmFwLmMNCj4gYi9kcml2ZXJz
L2RtYS1idWYvZG1hLWZlbmNlLXVud3JhcC5jDQo+IGluZGV4IDJhMDU5YWMwZWQyNy4uYTQ5NWQ4
YTZjMmUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLXVud3JhcC5j
DQo+ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UtdW53cmFwLmMNCj4gQEAgLTc5LDYg
Kzc5LDQxIEBAIHN0YXRpYyBpbnQgZmVuY2VfY21wKGNvbnN0IHZvaWQgKl9hLCBjb25zdCB2b2lk
ICpfYikNCj4gICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+ICsvKioNCj4gKyAqIGRtYV9mZW5j
ZV9kZWR1cF9hcnJheSAtIFNvcnQgYW5kIGRlZHVwbGljYXRlIGFuIGFycmF5IG9mIGRtYV9mZW5j
ZSBwb2ludGVycw0KPiArICogQGZlbmNlczogICAgIEFycmF5IG9mIGRtYV9mZW5jZSBwb2ludGVy
cyB0byBiZSBkZWR1cGxpY2F0ZWQNCj4gKyAqIEBudW1fZmVuY2VzOiBOdW1iZXIgb2YgZW50cmll
cyBpbiB0aGUgQGZlbmNlcyBhcnJheQ0KPiArICoNCj4gKyAqIFNvcnRzIHRoZSBpbnB1dCBhcnJh
eSBieSBjb250ZXh0LCB0aGVuIHJlbW92ZXMgZHVwbGljYXRlDQo+ICsgKiBmZW5jZXMgd2l0aCB0
aGUgc2FtZSBjb250ZXh0LCBrZWVwaW5nIG9ubHkgdGhlIG1vc3QgcmVjZW50IG9uZS4NCj4gKyAq
DQo+ICsgKiBUaGUgYXJyYXkgaXMgbW9kaWZpZWQgaW4tcGxhY2UgYW5kIHVucmVmZXJlbmNlZCBk
dXBsaWNhdGUgZmVuY2VzDQo+ICthcmUgcmVsZWFzZWQNCj4gKyAqIHZpYSBkbWFfZmVuY2VfcHV0
KCkuIFRoZSBmdW5jdGlvbiByZXR1cm5zIHRoZSBuZXcgbnVtYmVyIG9mIGZlbmNlcw0KPiArYWZ0
ZXINCj4gKyAqIGRlZHVwbGljYXRpb24uDQo+ICsgKg0KPiArICogUmV0dXJuOiBOdW1iZXIgb2Yg
dW5pcXVlIGZlbmNlcyByZW1haW5pbmcgaW4gdGhlIGFycmF5Lg0KPiArICovDQo+ICtpbnQgZG1h
X2ZlbmNlX2RlZHVwX2FycmF5KHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZXMsIGludCBudW1fZmVu
Y2VzKQ0KPiArew0KPiArICAgICBpbnQgaSwgajsNCj4gKw0KPiArICAgICBzb3J0KGZlbmNlcywg
bnVtX2ZlbmNlcywgc2l6ZW9mKCpmZW5jZXMpLCBmZW5jZV9jbXAsIE5VTEwpOw0KPiArDQo+ICsg
ICAgIC8qDQo+ICsgICAgICAqIE9ubHkga2VlcCB0aGUgbW9zdCByZWNlbnQgZmVuY2UgZm9yIGVh
Y2ggY29udGV4dC4NCj4gKyAgICAgICovDQo+ICsgICAgIGogPSAwOw0KPiArICAgICBmb3IgKGkg
PSAxOyBpIDwgbnVtX2ZlbmNlczsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgaWYgKGZlbmNlc1tp
XS0+Y29udGV4dCA9PSBmZW5jZXNbal0tPmNvbnRleHQpDQo+ICsgICAgICAgICAgICAgICAgICAg
ICBkbWFfZmVuY2VfcHV0KGZlbmNlc1tpXSk7DQo+ICsgICAgICAgICAgICAgZWxzZQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgZmVuY2VzWysral0gPSBmZW5jZXNbaV07DQo+ICsgICAgIH0NCj4g
Kw0KPiArICAgICByZXR1cm4gKytqOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoZG1hX2Zl
bmNlX2RlZHVwX2FycmF5KTsNCj4gKw0KPiAgLyogSW1wbGVtZW50YXRpb24gZm9yIHRoZSBkbWFf
ZmVuY2VfbWVyZ2UoKSBtYXJjbywgZG9uJ3QgdXNlIGRpcmVjdGx5DQo+ICovICBzdHJ1Y3QgZG1h
X2ZlbmNlICpfX2RtYV9mZW5jZV91bndyYXBfbWVyZ2UodW5zaWduZWQgaW50IG51bV9mZW5jZXMs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9m
ZW5jZSAqKmZlbmNlcywNCj4gQEAgLTg3LDcgKzEyMiw3IEBAIHN0cnVjdCBkbWFfZmVuY2UgKl9f
ZG1hX2ZlbmNlX3Vud3JhcF9tZXJnZSh1bnNpZ25lZCBpbnQgbnVtX2ZlbmNlcywNCj4gICAgICAg
c3RydWN0IGRtYV9mZW5jZSAqdG1wLCAqdW5zaWduYWxlZCA9IE5VTEwsICoqYXJyYXk7DQo+ICAg
ICAgIHN0cnVjdCBkbWFfZmVuY2VfYXJyYXkgKnJlc3VsdDsNCj4gICAgICAga3RpbWVfdCB0aW1l
c3RhbXA7DQo+IC0gICAgIGludCBpLCBqLCBjb3VudDsNCj4gKyAgICAgaW50IGksIGNvdW50Ow0K
Pg0KPiAgICAgICBjb3VudCA9IDA7DQo+ICAgICAgIHRpbWVzdGFtcCA9IG5zX3RvX2t0aW1lKDAp
Ow0KPiBAQCAtMTQxLDE5ICsxNzYsNyBAQCBzdHJ1Y3QgZG1hX2ZlbmNlICpfX2RtYV9mZW5jZV91
bndyYXBfbWVyZ2UodW5zaWduZWQgaW50IG51bV9mZW5jZXMsDQo+ICAgICAgIGlmIChjb3VudCA9
PSAwIHx8IGNvdW50ID09IDEpDQo+ICAgICAgICAgICAgICAgZ290byByZXR1cm5fZmFzdHBhdGg7
DQo+DQo+IC0gICAgIHNvcnQoYXJyYXksIGNvdW50LCBzaXplb2YoKmFycmF5KSwgZmVuY2VfY21w
LCBOVUxMKTsNCj4gLQ0KPiAtICAgICAvKg0KPiAtICAgICAgKiBPbmx5IGtlZXAgdGhlIG1vc3Qg
cmVjZW50IGZlbmNlIGZvciBlYWNoIGNvbnRleHQuDQo+IC0gICAgICAqLw0KPiAtICAgICBqID0g
MDsNCj4gLSAgICAgZm9yIChpID0gMTsgaSA8IGNvdW50OyBpKyspIHsNCj4gLSAgICAgICAgICAg
ICBpZiAoYXJyYXlbaV0tPmNvbnRleHQgPT0gYXJyYXlbal0tPmNvbnRleHQpDQo+IC0gICAgICAg
ICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGFycmF5W2ldKTsNCj4gLSAgICAgICAgICAgICBl
bHNlDQo+IC0gICAgICAgICAgICAgICAgICAgICBhcnJheVsrK2pdID0gYXJyYXlbaV07DQo+IC0g
ICAgIH0NCj4gLSAgICAgY291bnQgPSArK2o7DQo+ICsgICAgIGNvdW50ID0gZG1hX2ZlbmNlX2Rl
ZHVwX2FycmF5KGFycmF5LCBjb3VudCk7DQo+DQo+ICAgICAgIGlmIChjb3VudCA+IDEpIHsNCj4g
ICAgICAgICAgICAgICByZXN1bHQgPSBkbWFfZmVuY2VfYXJyYXlfY3JlYXRlKGNvdW50LCBhcnJh
eSwgZGlmZiAtLWdpdA0KPiBhL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLXVud3JhcC5oIGIvaW5j
bHVkZS9saW51eC9kbWEtZmVuY2UtdW53cmFwLmgNCj4gaW5kZXggNjZiMWU1NmZiYjgxLi42MmRm
MjIyZmUwZjEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLXVud3JhcC5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLXVud3JhcC5oDQo+IEBAIC01Miw2ICs1
Miw4IEBAIHN0cnVjdCBkbWFfZmVuY2UgKl9fZG1hX2ZlbmNlX3Vud3JhcF9tZXJnZSh1bnNpZ25l
ZCBpbnQgbnVtX2ZlbmNlcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2VzLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFfZmVuY2VfdW53cmFwICpjdXJzb3JzKTsNCj4N
Cj4gK2ludCBkbWFfZmVuY2VfZGVkdXBfYXJyYXkoc3RydWN0IGRtYV9mZW5jZSAqKmFycmF5LCBp
bnQgbnVtX2ZlbmNlcyk7DQo+ICsNCj4gIC8qKg0KPiAgICogZG1hX2ZlbmNlX3Vud3JhcF9tZXJn
ZSAtIHVud3JhcCBhbmQgbWVyZ2UgZmVuY2VzDQo+ICAgKg0KDQo=
